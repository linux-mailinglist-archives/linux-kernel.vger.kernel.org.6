Return-Path: <linux-kernel+bounces-231154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2812E9186E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9231C2080D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1065A18F2D2;
	Wed, 26 Jun 2024 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fpsS1Rak";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nnKJ585k"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806BF18F2C4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418016; cv=fail; b=sIYnz9G0wGY/BqpdIsbxBX9j3DfupZ1qDuf1WBvMxAnPYHIE7CJK39LLCrtTvLeSpQCc0hI5bti4MU9kYaKif83A8r7FzI6FUdbY8YKvBqtzM6ZMgnMPaZO1Ryt9r2NFTqrj0a5n5SnlAvqQiW50nWkf3ua9Yn09IO/tFK3up7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418016; c=relaxed/simple;
	bh=dC3pZrrJ/Pbg0plC50MVnH51hg3n7HIONWLKTdpW0ss=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qE7se6L+a5xCHaZ+6ehQzCb5eQ+NMYlfzEJg7VytZJYTTQITUQP26Fpv/P3BVdXRJUoYSxcXCgwC74Yx5QLSykXsYKw5uYTNKrlkOsuDqVzSqRxH6sZwSaQdJhGd4tYVom8xP1kOo/aEb8O3TrBhWzhbF2vqgiHH+mKUZXOkm/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fpsS1Rak; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nnKJ585k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QEtWUt026697;
	Wed, 26 Jun 2024 16:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=ectDZcZBz082gt
	4aoE3SA5jU5Dbmmj7TtKzM2HttSck=; b=fpsS1RakfIqAXWkyzlkgB6bM4C9MPT
	POP3S35NOlAJnxqtwQCQCiXnaelb4plzrOHZSHmXDzQUhXHABTqqN2VNn3vu1B5w
	Ze24N/ksFNWHUlTdayEH8+WXOwe6FcYswZVVck/7UIeElE46VdREKYDf41HSvUSA
	7nBENn8ybauxU0GNN8uGVnnR1LBMU3KEuTql0GfzljgV7ouu4y12GgNdBRk+F+cL
	oiSBvOQ2lsPbRBOYizffIseyKOeS6+SSGNTAwE/vx8uZSiJLKwSKyQtwlvWl7YLJ
	5EqGRPOKISHDBwsZoQYd1OlcgNjrkiCYqsB2jVd8H6X4Mmj+KYqjvCiA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn1d3hb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 16:06:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45QFlvKP010721;
	Wed, 26 Jun 2024 16:06:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2fr8my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 16:06:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/UhJjif2Cpe9l/lxnsVLkh+AuTN5D+tiloIrZK7ahc5Rj9ftna7YQbMTgODL5LJ9s8ug4HxynuA4e2m70zRTXD0MEjRYr4Hd5hXLjsBzSMguC/SJtbzW7EVeXlj/6Yfe8r2Aa4Np2c4EjjzRPcl82ADBi9kZOW+54WpC3VbOeuaoEt6+0LUKCG43L4KNN265YHfbM4b4UeunwzDtp/Kwv8bBK44slqLTRvjqTvFOsNtQRet7spT81q59pj5n154NI1wnUNwrQgzKMXg+3iyYK42MXz5/MXO7NYfzbtwIu/9RAqlc9WJmGIxnBpfV7mbhXOfhJ1ECEaCzNAs9Hqi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ectDZcZBz082gt4aoE3SA5jU5Dbmmj7TtKzM2HttSck=;
 b=Seq6UWxQLIJJucebPxeRopxsL4Lj3rMD+VLxLdlmoHZrwqc08d1bnC4L+q6Xbb2VLfC258wujasse8NqCRy3ByazmI1Hr6aAnw2JuLJit8XGjF5hisU03n6Kuv7Qr8YaZzV5aw0YpuAtIAT+iLDQSUOwz98ZniaJS21AVJc76lPYH09B/D9be6oDzWJIyQ2OfkaiBwnJSxQ+CkUBtCzJF3246CYjIKTkMMXe7Yx0g9hQxY15dhYvBBRTwGsSl1UepjaNrk6YwIFtzkYLQRA+/Ss6SyNwSiiGc7C0tOcXC+x5Ew6syUoQEFfU7SY4ASubDlQZP9mbea0zTlnI61BI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ectDZcZBz082gt4aoE3SA5jU5Dbmmj7TtKzM2HttSck=;
 b=nnKJ585kjoCS6BrskY3pCCBi2SuB8WiJbvg6rZ0yJf43iY9dDpaEl9bPotR/hdBV1XwNOreBBTstiaVc8lCG4sC7NtPGetl/c5C98iEhe0pG+UPF5znNqc1zYYeNaQNj+l1t2R+QFkZy+THuAls0CwJrKGbGGBtxjkNt3ZfrocQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB7225.namprd10.prod.outlook.com (2603:10b6:8:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 16:06:36 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.032; Wed, 26 Jun 2024
 16:06:36 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Jiazi Li <jqqlijiazi@gmail.com>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 1/2] maple_tree: fix alloc node fail issue
Date: Wed, 26 Jun 2024 12:06:30 -0400
Message-ID: <20240626160631.3636515-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::9) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: b91b0498-7b54-4a23-c4a5-08dc95f9f449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qOyt/9rzIejFSpNKShgdbgSbJ3sie95u+1Qc9X4z3bycvgh/Y5X4T//4FXdH?=
 =?us-ascii?Q?LsdC4RkGzTlZHqTnBthJYj/aFB2XXYiiM+ZIrmusZfarZENtuO+Lj82H1AlU?=
 =?us-ascii?Q?dr2yJwFopeg/JXRAwf9FYROfmS/897BhPKW/daNPVmRsQqzlx7rPFZ/eb9Ui?=
 =?us-ascii?Q?NxcXc64ZP5P9I635NKBnxipCn7b/z2PbtjlZn0TKQXumWgSY9sNXs8J26NSO?=
 =?us-ascii?Q?Jy7uYtcto7OJmLODUDiAtmsPUChJ0a6nOkKVDZRk6Zri2yB6VRjQwxX6/kRH?=
 =?us-ascii?Q?hEH1oT1eLJllUGIvWZ+Wx+HhChDhZ7G78Z7aIVafYcTHX5Ajykr+kztIp10j?=
 =?us-ascii?Q?jI+U1G1xo86lqDjlgllSc260CY8GTTx+QtDsgDkud1dBTRRFUJ5yfStYT909?=
 =?us-ascii?Q?EljR8eGcoi+tYVlsi/NY1rtGjeP+e67jINgld9Rj2SIkQRfgjl/fVYtD7HK4?=
 =?us-ascii?Q?fjwZljBDJu9z8FZjr+PmFfJkQzwQk69HxFK3K+AHbVN5ytqaUU4yWGzxt2r5?=
 =?us-ascii?Q?JUJa2/IlMHs7+QlPYy/NCUez3Y1n0JieBDsouwUOFd/m7eGjx/mPJQDa8t2t?=
 =?us-ascii?Q?axoEFtC2rN0YUdzf/j3Ha6kYW0qUPed61c86UE7NnsFyNtvYZMmBYi70WHeI?=
 =?us-ascii?Q?HscFqgfCpxdrshoLGNhfyQiuA9DJ5sOmuYGtAV6twRCGX+Rn+VZFun+utSNP?=
 =?us-ascii?Q?9giy5bh6BJMxfUC4oz7dbNuB4xUDb3GCQ876ZvD6Sy59SOhr+9baKNzwTq0Q?=
 =?us-ascii?Q?BUQbv2CTkWZd5/LTupzdzlJGJ1lFGOw6ToOD2UVSq7VwcWVSZzB7TcrJf/yw?=
 =?us-ascii?Q?kb/fx4NQK08DrY9tKQXkeZHzLg1g2V5dIxpH9v4WThkwqdme8umQNMrlQkvI?=
 =?us-ascii?Q?w2rYHGQ0Z4sekA0X35SHZgkAfVcO7H7s5Tx1X0ltMzEVVMN7tDqy7UTGtv+f?=
 =?us-ascii?Q?3D9ATL1aVUiBOdTAbIa6PraoH7201tI8PunAjYYWoll/EVCsFY+g2ZKmkByA?=
 =?us-ascii?Q?+Z8MYoujCpBZGP/A1qPy/0qeXS1wXl9+Ngq9FKor8tOboVNtlRrzcipVh1Jm?=
 =?us-ascii?Q?Gi5EYH3lJ4R2AB/NGczc8DL/PVKyEIe+6zTs33HEc3L0aqDCwmz5kwJovaY8?=
 =?us-ascii?Q?VLAUD54yHo0dY2x4rWv0hTBuq/Y0VAt0wQPoHGdPBmgfxF1FO5A6BN6WbyQi?=
 =?us-ascii?Q?IQJkijIffTY8c4YBu6L/McNV2mBZ4vltsZp9K86LcAhzc3NOuder0/+qrO4f?=
 =?us-ascii?Q?AdgM+GzAe+GbjS0GLWhecqoXHGttHJU48ghN8RQ/DX+iazYJtbohppAC7XTa?=
 =?us-ascii?Q?k/4In+wF873xm4m5tHzYOa+7cfEr2pRv1+layVetccSpLA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iiH/MV0ZJwG4OeMDCqi2YdPN117MsV72SimaQBH5eGKGv9JCvHobr045e/ZO?=
 =?us-ascii?Q?aN5SAyqViLl4oCiIJa2fpUEtoW/fnrYvdi8+F69/U+LNcLXGwPUVssCqZ+nP?=
 =?us-ascii?Q?fsJ+bR3p2ehUg1j7VdV1UAqcckp6fqo1SbdFXbrD7yM2kLS3rZAgyN9aEcK+?=
 =?us-ascii?Q?sS7icpRtRdVzEtR1XP6ynJT6lvCAXhO+RNAPGKLaPMFWo5eWrDLKJb6CyFZp?=
 =?us-ascii?Q?/tUeJ5ksQdGWurNNo3BKEWRz3tAN270LcOExrL7wkpvQGw1HoFSZWj89rDKg?=
 =?us-ascii?Q?Gk30Ek3NfXe5GbQKgjzsZSu24GYkk1snt90vSIAoBnJDoIXepGuqDSVsqOCg?=
 =?us-ascii?Q?3b3ABOr1owB7vQsMKbftY7u2t41D1L0UO/Jzn0gMmKtyPYB2Bg3ZhS++Qlqg?=
 =?us-ascii?Q?nd0Fm8sWwdmLVelh2PO3sGv3Hmtcym+tzrNQVP04cZjfwWTsrkMRXP8OIqIY?=
 =?us-ascii?Q?1Xp+iXyoY0Di0+rRM322+LM2GqEKRPdo403lqahPVDwkNhSCIAkQu75oAPX/?=
 =?us-ascii?Q?trimhfGwNXzQSTFwT5v1xhYfSRji/eAdG2OfLch62DBt8GvvobQuIotBjwUP?=
 =?us-ascii?Q?LEf/WAyUYg0FKdKbryrbCPMzdlIvhTrxhzC1b9g11d/HbKiP2SOxc1lM0r77?=
 =?us-ascii?Q?72h+0VzLd4ijF0raa9G5NJKaoBM/dAE+yfi0wsN2hAfFUR7znr3QI0yv7uMG?=
 =?us-ascii?Q?rBSALTtxwP1obA5K9c5RGtLYFGeVcZ/9rGJyvlVxrsdQJyjDB5NE6qRVfahH?=
 =?us-ascii?Q?MKtsu1i5tI7ft9j6N5ncUWXjyaRiNmN8hmerwnxYP3ysXhOTrf03yyMQirB1?=
 =?us-ascii?Q?Ey/T5PgT45inrGA4PedZlX/wewvKJ+/CPpvRkHdk6b5TSUZIrFFW2zLTtvj0?=
 =?us-ascii?Q?QdG7NjljgzDJPIf2Wt84SYD2nrgIwR3fQdQ/tLKuPR537uo+TTbBH8dlrSh+?=
 =?us-ascii?Q?uF+anZW8x93pebwxC/HwMw5eAWIx4zcFqcCjPqWxy7/nDPVzGbm4r4m7ni7q?=
 =?us-ascii?Q?Ozwndz53ARKIiUmOwA2cKY3W9vUEVmSSjVrUw62WI9wsGAwdE0up9hh9Uxj7?=
 =?us-ascii?Q?ZLSavobZnTUEyyV+/qL9h/fboCOul51NVZL6JkdcpILljc5yKTD6TLY0U/dy?=
 =?us-ascii?Q?PMYJGY4NFd8m+2IlMfiewREJFHE+aKVqSwY461XtX1kQl+o49m0zPXRZIuoZ?=
 =?us-ascii?Q?XSerug+spzPEP6n4ikkkrMSQowRP0zmbIgAGLzGv9NYMQgFpLKqu5uFU7jmI?=
 =?us-ascii?Q?9tG/yTSfWExt3xlIZZo4Hl+affbZMoxOd9GkRuh0AMNN684YOQ3fLtRb5fVT?=
 =?us-ascii?Q?ZqaDMTl2EeZMZOwPA/85c8LZyDX/Pvc1YSd3IOKyIf6WAoF+plF+SOn9QB7t?=
 =?us-ascii?Q?N6cxhl58eJJm/m1pV7W1PxE6qh6qxR/nkWr2Bz90YvAjEWiubH6xFWs0/Qui?=
 =?us-ascii?Q?2+Hg8SIZEPjL9UusTY+VNaMevpXt0nXErCCOhCcOVy4fHNYBde61xB+2IKkl?=
 =?us-ascii?Q?pED4bE79Kq7iZgKtn49+JBsaazo+srNTTzSAW8Wlkh/gn8jx1LDeWSQwh0Cw?=
 =?us-ascii?Q?j5hKoTObhg4qw7T3nOnFAHAqnBElQ66EZpMT8oBiHEn5y7FLz8SGeqR6Gnws?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QUrHudMBR4ScNzdRX82DpKh/uYtUSwS3TstZ17/UZ7Sdsegf5yKWJ2D5ZFx3SFT0Iwhf4yENYFcegUlCYWfsHjC/gvRSDTOywt31OWI10ZI/42gqztPEYfBQi5v6cPxj1Ml9pChE4w9KtU+MFW8ONO8pdchFs4ohX/CPvJqjSuW6AQrs7OhFB05aLfeUKTb9lnCjrVxJT9QwiA3bZuimZBfqRN9wU5HKIYxWguzkCnW5E8wXGSKT0SSWknpodWmUsL0daR37DHx9Yhc+ub9wlSgZhqKr40emNT0zV410p5hFKqIlbVz4DaGhpDLUkXZE1qbnskiJU3hVO2ZI0iQmtm7H8dGDY23jBnTjFje3dTOxvhXRefGj7OUT/s5i/+KgrIXG0/16hf/nkKBQIU+FcBnT1MwyGPp4D1AS/tvyMUq25B73xLco1jKE/xHCFuSCeFsCt5zsG/R4crl8F0ECnAlm/0UYGjI21IXlvavARrCKiroPPAMzA6k4hRUJBUKEAz8ovvo5fjd28/hq0H0k/nOl/VQGg/3C9QUoYzrL1uxv1MLeZgONbcSB9JOrHYdzFxNMP4W8IC1fS3rK6ZO01W0KCq6tqHjGfPPFkU/z8Jo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91b0498-7b54-4a23-c4a5-08dc95f9f449
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 16:06:35.9355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xy/4SFwSUHdplBs9bHscrL/KRK6P7xABTtJ47+T/8fc6s/e8jNFgeXSG0oJJaGp6fesrF01qO3v9OobT2GGucA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406260118
X-Proofpoint-GUID: AjrVpalinlCQg44D7Y7FupoTixuJ6kFh
X-Proofpoint-ORIG-GUID: AjrVpalinlCQg44D7Y7FupoTixuJ6kFh

From: Jiazi Li <jqqlijiazi@gmail.com>

In the following code, the second call to the mas_node_count will
return -ENOMEM:

	mas_node_count(mas, MAPLE_ALLOC_SLOTS + 1);
	mas_node_count(mas, MAPLE_ALLOC_SLOTS * 2 + 2);

This is because there may be some full maple_alloc node in current
maple state. Use full maple_alloc node will make max_req equal to 0.
And it leads to mt_alloc_bulk return 0.
As a result, mas_node_count set mas.node to MA_ERROR(-ENOMEM).

Find a non-full maple_alloc node, and if necessary, use this non-full
node in the next while loop.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 634d49e39a02..fe5c6fab26c3 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1272,7 +1272,10 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 
 		node->node_count += count;
 		allocated += count;
-		node = node->slot[0];
+		/* find a non-full node*/
+		do {
+			node = node->slot[0];
+		} while (unlikely(node->node_count == MAPLE_ALLOC_SLOTS));
 		requested -= count;
 	}
 	mas->alloc->total = allocated;
-- 
2.43.0


