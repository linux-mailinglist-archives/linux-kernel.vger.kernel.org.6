Return-Path: <linux-kernel+bounces-347107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E30CB98CDDF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13AFC1F22B0B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F96112FF70;
	Wed,  2 Oct 2024 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MjzIBUD9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A8fsRYf4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F367F484
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854806; cv=fail; b=evpA/znOIlymqd2cp6x1/MjObILeHlOKMK5PRSWn+l7Zml96+8qt7KkF5PWmNWUy788KXo1e7XSfAU0vxah2/jaXL80ieGrq1rScuZLZrK7r2+xVDWYfM3+yYrXzxvy1xvbcqYz3ihM8JOQN7ioCs32uG1V+6p9Tk6XO5Z/UIfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854806; c=relaxed/simple;
	bh=QGhTse9uaEDA5ZAeHZG2ZlApd45+E/oRfVrDfevMSJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R6dopUphuPQ/ga+Z/MlzlSQsuKF/UyqDbKBwPL/m9k3597XQ4lo9WFgwJew38j/bUThCoT1F+LI9hbz5Q+f2PXMpaOxmVr/QJufeMHSXyqNOzQsRUC7FIyP5OtS/aRCu+07hHMPWrjaFwrSO/2E89YnCHxmM6v62lW8YWc2m88o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MjzIBUD9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A8fsRYf4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4926McUL031972;
	Wed, 2 Oct 2024 07:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=9eUbEsxWhOhIVJ
	Atv8eBLsX023BSzanoRbihYIh77QM=; b=MjzIBUD9oXZcEQhHPbNBnKZY39RHiC
	gtzLSVXrRbB834tmngU5NViPjZN30Iik5RcjA3owTtM/DgXPTg44nK88PS2TniX5
	qACuyIcWcfQKxxqiFaIcMdWeXjAsWJUvXygoyIdXh+E8oKElSAGgYOp8eC0FP4tW
	Vi7yglYfRuIyB8v05jMkdlSDBmWbip9a3vx6/LccjuOnislOvVT711qyhxtRlEoI
	eRmA6yLbXiY2VPN5bRt5ofCIIuSSiS9udVlFv2NyzoqWACSDRlXKqXcCGMqcVAkB
	PxkGiYJfwOPpURs/4S/3yzyOitAwXD7NJjIFzpRtiH6sdOXc9+vSxFHQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qb8a8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 07:39:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4927MZtJ038672;
	Wed, 2 Oct 2024 07:39:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x888kkud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 07:39:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qp8uXS0Pf0tADcB1/1tZuraQwtakN89zdZ0egL7eps/hbNd+7s52iKDzIFkdDcSqlkAG1/mfRIsLNf7yQ21x8uvQ7YSWn/965FxsR1O2VkD6ve/ROu5r7hj93dM88z+duk2fYRclyDoN/5SMK/PETUvbNYZJV+7+xFoRDPCc8o6tL1xEzOJ/AMVmNIs4Qc6mGRSRPCpuGYf4Ki3Z+Ptpk8LkFEmo/FeWqdZTQDyBUWTtIoPcSDE80pZdQke9GVN8Adiaj6g6QfLhwqtbwYPOeK/SQP2lijJle8s1IXjwI8RMdpJ0Vc8bby104XnIGIKiUY65GFNsgkHbQoycj8+0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eUbEsxWhOhIVJAtv8eBLsX023BSzanoRbihYIh77QM=;
 b=Ny5x1zd8eRqZrM0Fr5jZs1YalpQs7H5c1l+2YXPLrBZr7hdhhER+XVm44KvIAPvbi67zLY7EGmS9KZrcqUCJH4m/4hihw5OQ6RFM621G5KwVRk2ZS/q3Lzsed5OlLmIiaEjRKECGQPzzaVzsNuvnxWFFBt/ewA+KivT5WAfO6nKEPSG/4fNmnDqr4yfYlEBTccTKFstN2ctBZkOtuv/MxeahIU0U/3/tLnaI3OW+eU7+xDXNeEFCm5T8xa6flEb97VBQdSORX5Zz6Av8qMwH2amrncFm6ipSsSxD8hDgWkIO0w8jbSSoZ+9HgqAfwaTuv7+HP4QEpACA/Liyh+iewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eUbEsxWhOhIVJAtv8eBLsX023BSzanoRbihYIh77QM=;
 b=A8fsRYf4Nr3e5kTb71RAXsW0l3vfe/rlOuEAli7Qs/rA4wWDT3WbOOjBuiyIZiYP4snTjzwO64c7td4umiyTM9TSlSqWZFcmF05qsuX5/65vJH+JFrjB8DPjkVo1MabjkDGAp3f7p7dXB6Ray7DmJZarxVNI7550+I31EqB7gMU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB5083.namprd10.prod.outlook.com (2603:10b6:610:dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 07:39:45 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 07:39:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH hotfix 6.12 RESEND] mm/mmap: correct error handling in mmap_region()
Date: Wed,  2 Oct 2024 08:39:32 +0100
Message-ID: <20241002073932.13482-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0419.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: 997a95c0-2268-48b0-69f5-08dce2b562d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XbjEr4fL48dfUXUymiFc40XB0iov5mI4nnQQ+/Iz9iidnLoPrVqa4/t4GBOC?=
 =?us-ascii?Q?bY0TylEHmzspuMZMmBMgg7+Vf00drSBu8GtPD024xQ3FkMTKmUSZK6pnqezt?=
 =?us-ascii?Q?suVu1CELuoj36tJlACMg6xbYCl2eYFEVbUSgopXY2KK3NO/ufLxvq63t4qDX?=
 =?us-ascii?Q?aRom4PnFhvfJoqCQOyItRy67kIYX6tqjHdl2PR1bcYEtyowfClwGtKmB05hk?=
 =?us-ascii?Q?c7K16YC6NQG3B//D9trQ/22w13auk9QsUUm3s9cE9r3NAhcwsVBhMYBRu9A8?=
 =?us-ascii?Q?m7HJM7J13x43Koo/UyXyKtVwtbPWzls1WiS8GtekW15XjDg0P7kUc5Z5bjGB?=
 =?us-ascii?Q?frSeSuzU5CFsbhT8Gk1ICL1USNyuA2OsbcYsO0QFFYv22lg/LUcj7o0kbw9U?=
 =?us-ascii?Q?H6GFRaH22lIQKtIIZKqyQtO0bkSW7YIbqLWMJVFjNMBoaRJZfJvzOrU2aYwA?=
 =?us-ascii?Q?L+CtAG1CJD+z96QgTdQ2GnDdoJ7yQo7W3yHnv5jP0iWgnnWLypd2ejbXhknt?=
 =?us-ascii?Q?e/9QbwNkwrL6okayuqa5l9QVXEAQBr22IYpt81Nej/C4GpLNzixSuJfiyld6?=
 =?us-ascii?Q?d0EaABexa0sLzMtIsFsAHycAuSOxD8rxuXzvyMotb42Nu3uc6n5tIhCnMbce?=
 =?us-ascii?Q?Yn37K2MX2bfI6arWyyO7UeY1elLSTlW8arcHvo3+58328T0tDOWg10vMxA2r?=
 =?us-ascii?Q?7hdHYd3Q1NzAmryiObY+iPcpEsIup4vWT21ONRitlAZD2z/u3kaciLKp+wyP?=
 =?us-ascii?Q?1VlTlyCzAUgi2b3Wgw+pqjkVTgXN1HNf/M3WBMw6EFdw5SjZBBe+5aLVKOzP?=
 =?us-ascii?Q?wT1f60bs+2Osk2MT8svi+1jT1hAiFTb/BGF2W9FNMPx3zp7VkV18uzy+92Tr?=
 =?us-ascii?Q?N3fcleH2HC6T+xZij/n9WoMLtLu/SXgTXQCQ/oytxVL7MOQlnVIcVhF7Ikys?=
 =?us-ascii?Q?qNSX3yAJlf18lFQ5SZZU+Lf/Q/Q4amYR6yGjbieRsmm1fw4gSGzyRLM/8Qwk?=
 =?us-ascii?Q?3OjNUktZm9dovjr/a2wk12KwbnXt+tkQfuhPlejKLsjj0xnUYKNF1g6TOJP3?=
 =?us-ascii?Q?zqTn7qJNm6DIxs0wPKZPExRIUJfKT40hbm4jf6WP8zb/1JLgOpaly/C5hCaK?=
 =?us-ascii?Q?L9NUVl0vXzk1EFSqBeBRxRzgQvnlKSIOw6Lt7c2kJB1L4CtgZc1XiuJr0jvs?=
 =?us-ascii?Q?umFQCq5/4Dqa3HgE6nGJZsAgNzoQ4HNBv/QVBgOYUalIwVMAiAoH/aWx9RaE?=
 =?us-ascii?Q?adcY7Lbu5zHrSFIsp9vr2fKMDePjJbmLp89xctoPdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W7V87o0xJaFQfeYBvc2QoGLkySE7CEFs1YF6tnwwssrkk6P4bNabae8FvwAf?=
 =?us-ascii?Q?fOWM1eArvrzUyGowOeAlgHWgBkYzcvR9nrvmfSsTI9RtJgeO/VNlIJZgrUT3?=
 =?us-ascii?Q?RZk+2gIOZRAfOrX6bhMd0pUNlTQwz5zqCA50hwHy6UElC0XqpsEmBPfIIR5o?=
 =?us-ascii?Q?DlE6aae1SfXc2+jH5m21llRS43U9RDwzzP3RhlC9MWos1W3URmDf9F1K8a+J?=
 =?us-ascii?Q?rX1430EsBVWe5GmRGW6QfXVEG48P3J1Jyv+se8HnwMg9IX9JWDSdON+VJa4M?=
 =?us-ascii?Q?O/KaC56RW487nJFAuNk3lSH8w+6eQcKNSfvrA+hlnVN/TosvVBVUXhUNI6ZV?=
 =?us-ascii?Q?7GmT2XWlpGV/nzqHR9U4m8vcyv5ylTQ/xzcRRuT7IVj7ncQ0HLxyypOrlLhJ?=
 =?us-ascii?Q?9PEscWtzdt/CBDNAW5S34uBza0l8Oam0ne1KUCD+V8PPNIGrVbcsmgOxlA/w?=
 =?us-ascii?Q?3Xu68NIhhmVqkv3ImfxTNrlKrNY4KMwFunq9/ANfyYQm3z+F3ArYc2Oj3Gox?=
 =?us-ascii?Q?bWYq6UE0AAeC/XuoPyvQ5oR6qsg35tK4JNFV4xdnfEDX/1leVC4AzH38cdLm?=
 =?us-ascii?Q?t2h9MbmxJa7iYcGnZ0RbKH+QyiVzgr8efWAngnQMez4NFZKfN6+OFDfQ3uc6?=
 =?us-ascii?Q?Buz9Yzq95Fm58f16bH6Drz21GbPn+I0EO4mHduOTXtDaBk9wqFflLSnmNsJ2?=
 =?us-ascii?Q?JinakTGrz7J7s9Jzzyo621TwWXQaAQhDJE1x/LGe8jT2PaGW1OI9oRIVZYQJ?=
 =?us-ascii?Q?NpGJ4tUuxiLiS9XyIDAWrXq1Fqzv2NeVss2D5msiuQmXHkKEMivdo74KOw5C?=
 =?us-ascii?Q?ek63QXWox7KuDO4VZ0mGQSX/M7/ZgkBP79weej1BYCWY+JeDNdUvCGLhSV8u?=
 =?us-ascii?Q?JUgVAyZ9t1ccmLOqHJMe1oIZLFTtAEGZbb+fJTg5RMeBzs9beaHwSJikcUlS?=
 =?us-ascii?Q?2/z2kpxpCZMWbaWt+mqFk+rxIZ6URns95AHCs+ETbovAU5nZOVggaXgPF/Wf?=
 =?us-ascii?Q?jzPYe6ccMiONtJXfNk+7E/UCCPQH9Hk6uIt1nebwqwpzQokHW5eT6MgG30+2?=
 =?us-ascii?Q?er7X5dX5PhWn03haINkouLK3McMz5CWRaqA/aq8Gq88gtb633ReE9Z0f7Y48?=
 =?us-ascii?Q?ozDOdLxXNyjTmgKKm5HxihoOdIcXGSDHinvZWj21DUiuZKu7U+db0bItKOJr?=
 =?us-ascii?Q?t9jdhIx9m1bLWvPBaR4HjIjUOSaNMyYrTpSp1NlmamsCkQRfxkW3prOLw1EX?=
 =?us-ascii?Q?xaLh89zNwEimhCrONv68AjnpwURI6HY0AjzqVaZqUY5UbOdzDv8SNhoXDfTP?=
 =?us-ascii?Q?FphpZVNCIJryodH5bw5+az3fGhNC/j7wSfLnFVcMXatc/nBb+MA+dp5mJyAs?=
 =?us-ascii?Q?Hr6uwaOjBIKcqMnZhd4cT4YPvWJgqw7OSFe6IDcistBxmioIIIu+MrXZLNhN?=
 =?us-ascii?Q?x9Wts6qtmUWLqZSU+oZdMMOIrj4+Tqtqg9mUCBsJivtVvQkrmQGa31+UBPbf?=
 =?us-ascii?Q?depnik1oFIuyBVknSFSSZpoAso2r1deiaOHQtNxO82P5XBqPOIIvdbLbEwYD?=
 =?us-ascii?Q?sVRQLs2C7LjFrnZ/RZoV2PP8s0cd+uVagREpxuNgTKirK5SA2tXr4LYTY/vj?=
 =?us-ascii?Q?5VWwCgunWxF2DQZrANXS7ctPd19bP3NevndauUqYxv11FO/Z262abI9Mlj4o?=
 =?us-ascii?Q?fTMCcA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	svaGtoQBDjGzXvq5YbdIGmy3zJYeWnT+M62Z/lWRwcBkE4dVHpgyhPM3p2BSRMA48D910GK7R5BSHSjG+dPInVJZpyv7fDfkrzQyNRZ2fVibTv+aMyaeM0yW9QLkru3XCJuUpPVpEUSe6Qgt1knkuqfIH86yaVwzKAi1Y2QLbc/SOUcC+AmHD0K/uHIdZCyL6jGIFOomkTWdyKoEYjAJ6H8Xk+lyXK4wWfSjCvBl5TkYG6P0k708buMj5NqH6AppFDSU2wYQV9mn5oAWeHaNEhNsvZ9bdsGo/LoleeUhDy6NUpKr5Cj3rkiHI8tWOGxvB7FW1wlNM/nx43eDw/9pMBx1OHNpfK1RoffxCyjCOHEXfoVc+6SAIxAJweoJVWnPh36NNcirQu/tJzkUf4xbX6ybO79XhyZbmjlwKrNEEnDleIt7UFOVUtDDG1lTKHc2+czIO+HDOt0SXt9XfdWgoaAVoDje8S52XhKqBD+a2SuWJBFURRh7SuLdVphyW6GSUOCwqpK+Nb4A2mQ2sEQjFDu+SHxuCqCeDxm3OYN8tmLzn4FlnFsHWMS8V0Bw/FAHU+Gc5+h30HGD6BTSysyF1uJczduDt69TpwZJK9t8zeM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997a95c0-2268-48b0-69f5-08dce2b562d9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 07:39:45.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEWW5Ck7RF8luK0G9072A31i7Uv5xOofsYbU9koprLUw1xUlnNWZWDvsQGmUj7NyaRPUBfd1DfUpNGuN3K8v481kEqinJIJqN9u6VzHb6RY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5083
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020055
X-Proofpoint-GUID: jR_6ryQJGg9dahHtYbybRqMemjkeeJVS
X-Proofpoint-ORIG-GUID: jR_6ryQJGg9dahHtYbybRqMemjkeeJVS

Commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
changed how error handling is performed in mmap_region().

The error value defaults to -ENOMEM, but then gets reassigned immediately
to the result of vms_gather_munmap_vmas() if we are performing a MAP_FIXED
mapping over existing VMAs (and thus unmapping them).

This overwrites the error value, potentially clearing it.

After this, we invoke may_expand_vm() and possibly vm_area_alloc(), and
check to see if they failed. If they do so, then we perform error-handling
logic, but importantly, we do NOT update the error code.

This means that, if vms_gather_munmap_vmas() succeeds, but one of these
calls does not, the function will return indicating no error, but rather an
address value of zero, which is entirely incorrect.

Correct this and avoid future confusion by strictly setting error on each
and every occasion we jump to the error handling logic, and set the error
code immediately prior to doing so.

This way we can see at a glance that the error code is always correct.

Many thanks to Vegard Nossum who spotted this issue in discussion around
this problem.

Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
Original patch at https://lore.kernel.org/linux-mm/3de82936-2546-4bac-b8d7-76fa38811d68@lucifer.local/

 mm/mmap.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..9c0fb43064b5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1371,7 +1371,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
 	bool writable_file_mapping = false;
-	int error = -ENOMEM;
+	int error;
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);

@@ -1396,8 +1396,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}

 	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
+	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
+		error = -ENOMEM;
 		goto abort_munmap;
+	}

 	/*
 	 * Private writable mapping: check memory availability
@@ -1405,8 +1407,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (accountable_mapping(file, vm_flags)) {
 		charged = pglen;
 		charged -= vms.nr_accounted;
-		if (charged && security_vm_enough_memory_mm(mm, charged))
-			goto abort_munmap;
+		if (charged) {
+			error = security_vm_enough_memory_mm(mm, charged);
+			if (error)
+				goto abort_munmap;
+		}

 		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
@@ -1422,8 +1427,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = vm_area_alloc(mm);
-	if (!vma)
+	if (!vma) {
+		error = -ENOMEM;
 		goto unacct_error;
+	}

 	vma_iter_config(&vmi, addr, end);
 	vma_set_range(vma, addr, end, pgoff);
@@ -1453,9 +1460,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * Expansion is handled above, merging is handled below.
 		 * Drivers should not alter the address of the VMA.
 		 */
-		error = -EINVAL;
-		if (WARN_ON((addr != vma->vm_start)))
+		if (WARN_ON((addr != vma->vm_start))) {
+			error = -EINVAL;
 			goto close_and_free_vma;
+		}

 		vma_iter_config(&vmi, addr, end);
 		/*
@@ -1500,13 +1508,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}

 	/* Allow architectures to sanity-check the vm_flags */
-	error = -EINVAL;
-	if (!arch_validate_flags(vma->vm_flags))
+	if (!arch_validate_flags(vma->vm_flags)) {
+		error = -EINVAL;
 		goto close_and_free_vma;
+	}

-	error = -ENOMEM;
-	if (vma_iter_prealloc(&vmi, vma))
+	if (vma_iter_prealloc(&vmi, vma)) {
+		error = -ENOMEM;
 		goto close_and_free_vma;
+	}

 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
--
2.46.2

