Return-Path: <linux-kernel+bounces-398915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EBD9BF7E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3426A28325A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3DA20C482;
	Wed,  6 Nov 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C83LAK23";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dXxr6FKO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE620C339
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924346; cv=fail; b=L5LMHQXJ7F6jhSDSGECACf4Q/Wa1el8/wnRRcaUuXVm6dF4WNU9MhXbPkfYb8i8/hwFHTXdcOLyXwHB4oTFiMGSYb1GyaZ04ZkEAqzmXNroVUQO1Eg0VZZ5YHTltMH8YXiNUHOIJ3x3PcHXsJtN/rFS5F1Dpa9buvt2KfvUL5UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924346; c=relaxed/simple;
	bh=xwgG1vXQAWNMgbFUPhRJk8BcpdUM03aSgI0hltXO+0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E6ZWAQgTysGe2U/fpOUDd3q05AMEEuXA2i5ATZct12e7wYgW6RUYfdsSesyFaDsn1lPFmiif4mB/f8gKa62yn9Le3ky8TyP9/niB2SbgVtUuF+WWnVngTb0qd5Rom5fiatonpRCdABm7yfavctwd5Z0XDOmLJdck1PNebmL1tb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C83LAK23; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dXxr6FKO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6JXXA2000507;
	Wed, 6 Nov 2024 20:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ac7+2S072WRZTYlD9j3ZVvZlMApVAhT14PI5THc69tw=; b=
	C83LAK23+GY6aphaKosMRPG5HMAmn36X6BhYPNKc/pzTarDE73J53BZ826TIX8M3
	HuwdyyjFAvnXVgtCowBSNP2Kujt7RtFuBsFra5cPM5jk+63bc9aE69As4zLet2rl
	509IiTCbdwjTDYZ704rZhHGw2BY7x3tcxLbYjAzI7ymn1Jk4LKsJMPuAkVRbKPyM
	EapoiK9eEpgpdmL+BtgSb3ekMUC5B5weIBTf0+BpXUPL5NdV0yEjz36HdFu5MlsG
	swq74EgrmFF/ZhqIIaR3mHxuab18dxBu7ZATjcHpCUi6ZQFaFaplyZwDj/lgBDb0
	Uv0eK7Pm7H3kJVzueWR+Qg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nav293jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 20:18:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6JYkij009712;
	Wed, 6 Nov 2024 20:18:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahfc0pq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 20:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFQPetVqoYE3SvlMG6EQkaJrQugxbl1zptVd5zZM4mJTBfGwCirCR2OUjymf6ftzHa1Xi+rI0C52MEizOmdx87wbMRY4bZfDlotj/yU+sYaQAk87aCSOJ3QUi6PL0Dk3cIMOs5t4Qx6Z2yzpNnM+1G2dyZ61vVQKmJsM3sry4grS4jrtrFNLDi+KxHVHQToVZcP9Ui9bphuUudAzXuLvyIK7NRKUejVcgAQdrDoz0/ODE+llXZcbUAeTqczNg5Gr+50oWGkha80kcFrigs8qdxvBaVyGVJZvHmI3lSgLR/QK4Z/SNzOz8xoLNe369U+FTvwsqsFrJY6lafbkQHYMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac7+2S072WRZTYlD9j3ZVvZlMApVAhT14PI5THc69tw=;
 b=YumQX2uau9dsehJ/3zU87oWj+LJgtR+SC1hlES9tJIZjl9++yS4E+yufVgb1o3N1Mb63ouFbyzTCy0la15mlaCKHn8TGKaUTTF0lkpKyGh60u55f0T7B+OatJfgMUXxK/Uu3WNqQCHinYAI0WR8pZnnMum/F1YsilhA4F7o3eJE6Zw59blMZe1rcxOld3RalVvN/4EiLgXoYKk44pb5lgs7GjfhVTlVj23/mzZHMemZLu4wkdm6gRadfC//YhJA9RKUDyRwz2HaDWGES0UiOfYqz6orUIBiwb/jOtgnIPu+7Ej3nkbHyqIBAip9wlctOZdOCz/hFZKhUWIKZ/ifV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac7+2S072WRZTYlD9j3ZVvZlMApVAhT14PI5THc69tw=;
 b=dXxr6FKOvACbWWrHR1ItTd9Y0kiD6ahViq7uVkX8ziEZ3evp20WpFHM8BPvyCKRcBD7Zpz4/XhPWt/HJuVXh2z0CA5AWbiKOtGEvRv2ToP5C/6+ZD9bgMsm4PNIixzflMX7weEXcYUqQIyHC4/QdD7W+43Dj2M0iL2ft3uELmbA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV3PR10MB8107.namprd10.prod.outlook.com (2603:10b6:408:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 20:18:22 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 20:18:22 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2 6/6] sched: warn for high latency with TIF_NEED_RESCHED_LAZY
Date: Wed,  6 Nov 2024 12:17:58 -0800
Message-Id: <20241106201758.428310-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241106201758.428310-1-ankur.a.arora@oracle.com>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:303:8c::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV3PR10MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0cdb4f-518c-4f6a-125e-08dcfea02995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sbt9fhm+pGiXEdvU/VwMLOQT2KZWFW0S/E5pILCqvsbfJSkgknrhnIWZ5Saj?=
 =?us-ascii?Q?adnebLu5CHruhi8Yl8ph9k37gq9ZOUIcoATd4kYpEXeu+CSxBs5Dc+6vgNkU?=
 =?us-ascii?Q?NKJ7Q/+0UZLMpklrxEYuvNcXBKZiUL/8WOh8fZljxxHXErkZkRVJ0ySgMcms?=
 =?us-ascii?Q?b1NKVmUmikwuhiOkDMcV12XqV2DmPBOXIuWtWlniAkh2sSgu94fE+XZ9CcJt?=
 =?us-ascii?Q?gZY8y8WWYd8rheVULpUcSS5Kzuzg8ZYf3HhpCpnxCMCdp2sTcOFCrrGcnteq?=
 =?us-ascii?Q?n5Zxis/A8A9pMtPciJvjHxq3oGs7MRIuPSPL2Fy7OjA1Ed9OSbTuc00BGFZ8?=
 =?us-ascii?Q?heFgtkaFaztx0yRJkfJhna1n9dyS5CCthncaY4Ja96xL7r/WICPcSnmQWV0y?=
 =?us-ascii?Q?epugMjv36f3B0ibkEXtO6h4XoHkbRl7TwFpXM6epL105IPLWQYI/9RveODBy?=
 =?us-ascii?Q?yrmAYL2HSHz2OQwiklHJgOUWLb0qDYkSSDNQ32Vt7tkwOGPPuvJwDqWtBVBM?=
 =?us-ascii?Q?luq7ZHBqUIXAXlDtIeG1gfeBcy8XG+FwzxBWh+7WxtYZXFdiV4oIoUU1Vjf0?=
 =?us-ascii?Q?Y6NSb8uIXX1OCcYTTEYWHSJMsilqAxt5iD4geH/dxS7MG3jwRugVU8s9DXFv?=
 =?us-ascii?Q?gJeY5dxMKCEfH6XXfZJs5mzTEPM4NFxsfp+GxI0ChfWWw4VbRyKIr6D5uToo?=
 =?us-ascii?Q?ZkHDOND1pHTfP6jTN6ccwJ4Yd74XAtV3IsF7AM55ZLzlejQ2mPOugjKUUzFe?=
 =?us-ascii?Q?wB6IqmcfJdi38awb3+KJ8ks6FQrDHHykP6voWvVJP58TUb/llixoZA8H+N5i?=
 =?us-ascii?Q?9PQq4lwwKrfoasTLvnYwuFFOsMmIobhsk/W0G3RL3JqC6QbROm0OlUtXpuvb?=
 =?us-ascii?Q?nMVdfDHe2POJby/d+1nEDTvfgr0SpUl6+RPlIuDO5ss69CJurrmVZDGDkZeI?=
 =?us-ascii?Q?pNlQI7J8mHwz0O4Q0CG+LTSJ7fR6TrYCfq507z+uEyXM5PmQkMAn8GobOz8S?=
 =?us-ascii?Q?EWN0HxtkmI1HPZSyEv8a57iaq768x4Lr+cN1wxvaySQsbPh8QQon+MjDtVby?=
 =?us-ascii?Q?uQJhJw6h1n1KqGEoTq7DCdwD8ql6cLunc7KzB9DUEz1yURpz6ROc27wm6fC3?=
 =?us-ascii?Q?1tA5vLKq9XfQ570q8GYDCRD9UwDNIfrORLfx2Ek9iniK77UIIGvO/l10GjfZ?=
 =?us-ascii?Q?YY5k9JppAlglghBiCo0DXQnlBrNSWm067COygis92J3LorxZ49Yqf9J96fsN?=
 =?us-ascii?Q?mpb2gNOG0vJd6fjnFK88kf1ewfMRdxGOYlMN7W1mJ1MkejqP0J0OIx2CySJs?=
 =?us-ascii?Q?n0g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kpWErU4o0Lfbc011O9LQ6FlJ1MbfV8BH8ltiZXmGRxnZ5KKN467rTz472Vss?=
 =?us-ascii?Q?jggnGuPnPs7eKJGwpXeVZVIB6Arg94LLwPj3H6KdQuq65bwveV8+xraHS23/?=
 =?us-ascii?Q?beo4hIy7jp9jULsMh0DDnl3EkH4mf+9n3OFrOFYF+IWCYkKe2ARRG4xQ+uwg?=
 =?us-ascii?Q?75c2wjpPjsvnD40b6/LTegjjZhJozc6+tpWaXQCm44cOJ3aD+Rdu3vwTI/wT?=
 =?us-ascii?Q?B0GAm1QdNNLqrd+XKPlKrK1EExEqaIsyK5kjepCosD0wIJTQ12ndVy39CKfZ?=
 =?us-ascii?Q?TJ6ySqoOo3XaXLjGeKhrqgRsvDXw2tL1EsrwRLadH9hE2hCiC3bbdW3gGeCD?=
 =?us-ascii?Q?C8u1mreBiNO6e2O41+DG4fbZ0O2nWeSZg34orCRHYODNw9nNqFUX+N1s9f46?=
 =?us-ascii?Q?6ME6yjsiLbG/7S7B2pZ+brNTA6iVTV+vifTpIFoLFNO3Z6f2kcCnBYfvx9Lc?=
 =?us-ascii?Q?s3Ohhm9onOBxdNP8bvqgFTrTjS8q8b3OA/ewmH2/N64vuKAZ0USwThuIRP4w?=
 =?us-ascii?Q?9o5jpM77fPV9aPxZrPFEVGstkcd89qQwDwEZfCyqHGX2mg0De6Nwkg9cWqB5?=
 =?us-ascii?Q?UFSOD6e8oytflaHEykXpOV4AjOcjYV8yDu4mcMh/hC+sDbguQev6CrJBfSiP?=
 =?us-ascii?Q?S/EOcP4ZFgb2pMTZipgS6VzYTYeUrtnyT+8al4UI2kZTfc2IWetunBQsadVU?=
 =?us-ascii?Q?lzu2SxssSlSgyBG8MCNwB+dv0KCIV+VBFYvPKlmpFDMO5J4l7zjCIUNdChDW?=
 =?us-ascii?Q?JdiKmZ0LyCrjKsH6MYM5rde5W9vS2Vv+JFx9536E2goHoXzfMbd9ANQ0NOrG?=
 =?us-ascii?Q?G9fFSu/iLaaNDI3QYC3qgFLsJ1dA4YWgJBqTwAxE514wMMjWTAo0AI28ncrt?=
 =?us-ascii?Q?attpX/Ud/a3Zbx3gtPBubzhwuC/SO1n3oPkI60gLTvxmeFoeoj8CvFOHwrHH?=
 =?us-ascii?Q?UQkwFbbJcTKZRqYyRpw6vPNT8TXXEL/CancQzw7nTacigdUPHoXF0mJu8zMo?=
 =?us-ascii?Q?jcL/m7jX3HQb6bD13GeyROJuCPCMLXQGO3DEnEnmqGs3R30+MrG65NMqGq02?=
 =?us-ascii?Q?IQsqN5mx/ilNLzoO/IHB03ro0tZ/ZUMEUUI1FeV8mTzzqH97XxZx2gkc2cX/?=
 =?us-ascii?Q?dZGpbkR4P696+pwcjqCRjhW41h9x52h1sanMe+7JV3hDjrV8fZWG5HRCAH/U?=
 =?us-ascii?Q?lBahnwLak1Su46IjTzVFVpltkCeJPX1JhLI9Yzie3GtRUjw8r/HwxRhae/W9?=
 =?us-ascii?Q?yYk43IixvIEVL+Xe+JdxPgR5oxhHCz39Jw3CMJzvZzhcCBGlYn6JoQFlMdO7?=
 =?us-ascii?Q?5UsGVwtBstpgKUn0N99yHh+bCqKvEnLIHPifnLbbAk9ugHt4vTxyKNU4rQT5?=
 =?us-ascii?Q?gR00cBjrde7wZUASH4kIh/TbgePA5ZLaNHbobvsstnUExyYCsCULGk0OLQnS?=
 =?us-ascii?Q?fb1zSC8BxO2GTrELiCBOW3Ea4NQA77Eqv/ND8lTj43lGmjSNxNfodd5vwZBv?=
 =?us-ascii?Q?DnAKBhbTrxJ2yWhj5sYO47vpj36UuEqoO/7xCQXdj+24Yl2jhEub5n0BL4xE?=
 =?us-ascii?Q?pEQBPEVUFgdNSk1e3uix2//VU4KNRYXNWjqK4KJCWvmd4zWEM4TUZGlTKARN?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1OnWK+ZO/mEZO+sQQHcrMJIYy1zz6ZhjnKo1mdF/j5r+ZyhA5LMDjZ/oDP9EceS2QXOXJTkcCqNEkOcq+ZIZxnJm996SgJLhIfGso7UILlLGpd2TlA0MHUalgzIRSEPloqPSJ4PIgTjmVzJbpaK9xTPLMvrlekZjAAn9EzWTbuvlFADB870TT643XUA+00vt6d2zrsIPaVZI9F5jD52hV7AjXf4lcO9JRPsoCsaomsk8T7/r6UOdT9DkcQzvtmxLML4YlBL00F7v/6PFWKHX7tOt1gphoU9zjNXwQp3VFa1BEkAVJWUVPktscix9+XVkc7ltZQWOp8t29D/K80sKhL8DG5m/7yP9f0NeBwrKRO66fgXiVjVZA7vXhO67XRw8r8ZwtumBIKQ/DyQUXszfqjNIhLj3y2/RclHls8XATSaMHa2yRuGZog7J79//AWT1JxPE9M+bTaY9yK1qU6fvmBF9Oxjit7iD9T2EIkWOmk21zAqcYJ5QDniHI/JLbgEuTL1O7Fjo3rYQhv/JQ964LTEDv7prTGmTN6N4Tui2s+eNdLVRTmlIftpWXIe/Gw1ADVJejOg9l7WptRiAGHjuj3azTh/4vGT6hOel1Zk84h0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0cdb4f-518c-4f6a-125e-08dcfea02995
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 20:18:22.7441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BfG25JY+rlCWOw39Ak3lqaBkgq0YJjpFNipikNX9OX4qe3O9FyU8M5kLXj6Dd8ELGX5hOERpJoAMK3wKTBEQMFhlTl6Y/y3a7eie5CfXfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_13,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411060155
X-Proofpoint-GUID: QlJjsT9vIGyqWP2VpxVeZ0c0bSQfQiqR
X-Proofpoint-ORIG-GUID: QlJjsT9vIGyqWP2VpxVeZ0c0bSQfQiqR

Add support for warning if the TIF_NEED_RESCHED_LAZY bit is set
without rescheduling for more than the latency_warn_ms period.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c  | 3 ++-
 kernel/sched/debug.c | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5c47d70f4204..077ea42a17f1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5579,7 +5579,8 @@ static u64 cpu_resched_latency(struct rq *rq)
 	if (sysctl_resched_latency_warn_once && warned_once)
 		return 0;
 
-	if (!need_resched() || !latency_warn_ms)
+	if ((!need_resched() && !tif_test_bit(TIF_NEED_RESCHED_LAZY)) ||
+	    !latency_warn_ms)
 		return 0;
 
 	if (system_state == SYSTEM_BOOTING)
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a48b2a701ec2..6c1a5305a1b3 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1293,9 +1293,12 @@ void proc_sched_set_task(struct task_struct *p)
 void resched_latency_warn(int cpu, u64 latency)
 {
 	static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
+	char *nr;
+
+	nr = tif_need_resched() ? "need_resched" : "need_resched_lazy";
 
 	WARN(__ratelimit(&latency_check_ratelimit),
-	     "sched: CPU %d need_resched set for > %llu ns (%d ticks) "
+	     "sched: CPU %d %s set for > %llu ns (%d ticks) "
 	     "without schedule\n",
-	     cpu, latency, cpu_rq(cpu)->ticks_without_resched);
+	     cpu, nr, latency, cpu_rq(cpu)->ticks_without_resched);
 }
-- 
2.43.5


