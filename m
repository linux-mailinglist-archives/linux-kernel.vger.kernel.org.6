Return-Path: <linux-kernel+bounces-437329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F23B9E91DF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841F728116C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32C1217F52;
	Mon,  9 Dec 2024 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FesmLGs/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UklZN066"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8494B21773F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742820; cv=fail; b=WyVtoYkFMfgbYxssnbaYw11T/RTpLpjP37VbRho63PLVIGpq4JVNvVaQ3Jac5Y8G9B3ZSvHTIAO8Jb7qVUaIsEO71/oKZ9FmVD9qfscKM9KT9kRa2cY8gj3ImXlFjj+honJxEE1adR2wpi3hkxPb/PUKa/JL2+AiWCzyREV/FN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742820; c=relaxed/simple;
	bh=mi/pbc8mJ7GC7RfzwbZ7b81Sq0t+EEAx+DIExjzDAJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TDrcIsLJB1d6fTfW5VqMmcs2iKgJLNEfIYWKyS5Pcj3n/RUJl6ueLAsedphkKUKpNaZw7Wm0sbIZHv6YR+NcrOXOv3XvGYoCpuaFpTK4EXE8GYjIAPacs3R+ICpl3tg8wLJjYJHuNv5lIh+p/Dx1+TYc5H5N2hQ94St6mckLHHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FesmLGs/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UklZN066; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98fshE022560;
	Mon, 9 Dec 2024 11:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kdGtdvW0QMl0FLuRiG
	lFp3hGo0ejOyTzZL8s5qQNqZ8=; b=FesmLGs/ctNID/AQdPtMpcawLPm7w8uCHj
	UQQKbo7CgOaAEBKnXMGYcKfaN45JYTskORikMqFogSJdmz2xbP/DBUoWszhgkPom
	MATYmDRa6xvZfrIddR0u8sPPSad5SZqI4qPjLCxlzq94+bX2NCemlWuofC/fHz6G
	1rWI91qthfv09Myx1sy+iIY1vI3RADK+Bfkk13tasLjYLd5yM17GCG6hlV7gxyP3
	bIDVpuyUj+1OamFoSkUPPFpuZ/NCUUJ0TrPNSEzk4xkrv9/+wdQ0/TqtRvKBSIV3
	uyq8ZI7SjuBT8qm3I7Ou1tVuIrfz6PSe0SmSuPtrM8Tkp0+EdynA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedc30y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 11:13:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99t6RC038162;
	Mon, 9 Dec 2024 11:13:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctd9mgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 11:13:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtlGXwxsTYJlKbZEADwt4Gl4kCgwXJv0v+irYe4vSB9xXXrPl7PT7K25UKJzZjWC8ZmkQZgIvAOoGUKKP/nkf/nLR8YtkF1LctXYJd8fBV0dJnVnUZJbY35MD9uTgyFpn/0PnGBstZrbeBB5Gj89zZO1MXgqx7VkLJS2Wq/DQB2u35FeNKM7WTk8MTiW2GbK2Z96gi31xNnVIp8ccYINlspC7Q+MsTTlc3fj4JLVfZFLFwHF4is1rZwKdOkcyImYQZKE7+viW3jTgQVeAJXgFljg2myGXxzSz64PagbEOQ5LLSJg0f/D8sk1Bz229udSMNE3nTjMuTOHjV35/rBnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdGtdvW0QMl0FLuRiGlFp3hGo0ejOyTzZL8s5qQNqZ8=;
 b=UmC8VLZIYWNNJ+mmFggYk3RajheMVFyxeJrXcFufMDWvRrbRFms3vSBUsZFTd/EXbHp34bANMt65FaucKmwq+vEu6a0X+sqNoyqJ/Yn2jHtnzXx7al7BAiZefqDn22EJfV40XpzCN8+TVn2O4p65KGprYEC3tdHdd/P85vdGHc8+zeyGOgXKBRD8+RGOxofOVHCHtWWhecQl9xDGnezaIGvvLCMRxIk0qMgpfmSQljmH65EFwGpGUwEx/5EF3CGP+FTQ21Bl59lcOLrS0FL3cFVysg11QcBqCppFrEsUHvTTU4pMlnl1qDEyZMOf3Gel2pmbeHWEFXl7qEOkP5H6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdGtdvW0QMl0FLuRiGlFp3hGo0ejOyTzZL8s5qQNqZ8=;
 b=UklZN066WtVaye5d/XNOHTle5BnMnvh9pzrE4FRqKYX6yPB37Cnmbh4HzaM3J5irdmjGQXSlbgJfjpFEJY7Q8npkemthMxGgwyzyNrTKEchiIHnx1TXtMZm3IkN1P+OSoDOog2velgCnFMpt+fL4Wz4Jw0niGf5vKo89Uz57n2E=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY5PR10MB6095.namprd10.prod.outlook.com (2603:10b6:930:38::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 11:13:18 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 11:13:18 +0000
Date: Mon, 9 Dec 2024 11:13:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Isaac Manjarres <isaacmanjarres@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH] mm: perform all memfd seal checks in a single place
Message-ID: <7dee6c5d-480b-4c24-b98e-6fa47dbd8a23@lucifer.local>
References: <20241206212846.210835-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206212846.210835-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY5PR10MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 791381f5-0d78-4941-0401-08dd18427c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6MtQxKP1NxBcbk1Y3a7aCPHzgEPe6HVL+HR9SQPMPpONHg29LT7HyYYgi4hV?=
 =?us-ascii?Q?OWoQRFxioGZ2G9K3+/fEefnoW+re3Vt/MaSYev1SpXjhtOpLJD9j3yqJoeCj?=
 =?us-ascii?Q?nFpDf5GmwX4b15pX2OkWZyT6iRsp6cHvQ/MBamAR5Z0eqkgX1fq2ZwLOZ8oN?=
 =?us-ascii?Q?MVXZrrIlc875FGXKh9ieo20LTvYtTo7A2gnqfVd2sUyNxNSnutyDw7Auulo6?=
 =?us-ascii?Q?dpaRmMcvHqh/eEpbMJIXiThpXweeSEOOh2sd4cMU85qKst9/aHUFHxH5bImS?=
 =?us-ascii?Q?PWoSv/pqWKz05yMttRFNzRs0wFUAuVP5CchnUlSdSbh3tbjXDn5preLSobm/?=
 =?us-ascii?Q?EmiQ/SXRqtirghX/IDJFfWQ7xaN7sYSAGzFhgw5rfL1iUj3izZNOTDiIRyZn?=
 =?us-ascii?Q?Xj2u1qpWspPfXS/5wO7Nb63vxzr6iTcIEC6rFXVDCrKpGeNwy+V/jytmlIzn?=
 =?us-ascii?Q?7LXKv/xVPsBMj/h5fHAohyv0LXnzoAoVByoUxEuMvLwLw/QNC9/Enyq1iNOU?=
 =?us-ascii?Q?y9A8Vb9M/AgQM2+uxpOyCyUAI/Mw0wIvIybwYYkDeOoh5Y1cjC6EKew5I7cK?=
 =?us-ascii?Q?0LZj91bMoE091GL4k+8lE8Cimeu98EPvq5mpRl4A4ovdIYMDYrt8dV8HnzuL?=
 =?us-ascii?Q?Wt7usRkoTg5IsD1Yi1gMWEzJ+SsgcIdwNAPF8sRqoLLQdq2w+2Hrv7arUxyZ?=
 =?us-ascii?Q?MmZhAfQV47sjdU7X5OPrGd1cmt0/c5Dj2E4qiOAh+DGFqd4eEP34TIj4Z1VC?=
 =?us-ascii?Q?QRAsKepEmmXZ0/05LcTn2jsVgcDFBZctGws30gEAdwLn2i42WG8Uo8FlaUXV?=
 =?us-ascii?Q?F31MF2cvkk/0Q4qyXuXMn6zdcz6/7060LSEe3W8tSr00tGf0ImWcK+JHe5nI?=
 =?us-ascii?Q?fo29earmsFRV0ryg4Q7APLzquVPablJwNRdwP2HpTpYp8K4jjz8/E6IRHORn?=
 =?us-ascii?Q?U3dKeS5z/DaxUUjozsl/1Snal8fvE3JVfsWE6vGZbKt3GuW4j21zWAF8jFbC?=
 =?us-ascii?Q?ePIolenKsUhcqaiOVtcdGc/mtrjAWR59J3MyEkDLFGuJqBJagZ0LB5+MiMCD?=
 =?us-ascii?Q?ENi4C65nO5RIeIg8PytOqIKj77DSddTJTXl/pjy6J8MKBYX4RtF3GO4aDc6f?=
 =?us-ascii?Q?ZhObS+HVW5z+EEdRagWbvY4zH160p54y8BHwQ7H9/s2TXV+Gv2c2OEu3COhj?=
 =?us-ascii?Q?b1brjKeqcqAyRZx02ff1PIXNMe9vAw0OYe6v7t55znlcMWNhCjrpC+SNuJR6?=
 =?us-ascii?Q?Fcbo2AYxGhqQ51w9GQfjcNaNdNFKxUX2xxtrD93ukXIE3g7EBlx8QWxXPHZA?=
 =?us-ascii?Q?j2Heoe6KT0U3AfTzH0a6eyXat6WdOfYdhldb5j5sOHWwJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pFYr99BE3DtpNeGk3h52Py49yKJmfkC575PLQN8EBDklM1S9hW0ZPfjX/32c?=
 =?us-ascii?Q?kX0hy6vc97Yl04dKWjy0DCgXc0VqhsV2hOI6VLDbeIP/QZy4K7Ul/ZGoiGXa?=
 =?us-ascii?Q?MfyTu451CVPr72AU5JkFFK7D8ytPE5T1q5gMUXat8ZqxX4VwHgXjruN4Q7lY?=
 =?us-ascii?Q?790BH4gL0lzH7Hx7L/xfEOO/O1+aN5qbb90rHo/s/Kxyy8SacjKbGnw6Rh80?=
 =?us-ascii?Q?d0ws409HbBoPiid24MrTGnVsmiYNGtHGoNwQVXVhcICvcunXieL4BA/WFgYU?=
 =?us-ascii?Q?HO96Z9fI7h+AmAYWSgk/UFV+a6cbg0KnoCTLb3W4gQ15ckMITGk/9QWfjBjm?=
 =?us-ascii?Q?oJy00xzLkpvb0qTf5uuFqDkBxx1uBlxZvxd/dbZF1/yyMKgxVrOQPxNBFqQE?=
 =?us-ascii?Q?gnRxWSK3x8TMh3zm2Mf3qX9Nf+v4WVZJjdnDh/Z4ZABMu+2psp2ChodMOYS3?=
 =?us-ascii?Q?kC4WtJAg3Iv4SxL0FNEJg9k5SsNytfVfXtn+iHPieruf8h56HemJujcOj2sc?=
 =?us-ascii?Q?Cxp5eHhE6mtTJuSKiTf7GWu5pMkimJ6o5R26toZJH4d5oXyh8C4kDduWYCjF?=
 =?us-ascii?Q?rLv8cDYZlD4/kIrmX5Jad3FptEEmglfKy1+K17gi36jnXngouRr22J48zr2Q?=
 =?us-ascii?Q?DbOPQRtTUrz+1JoQHpVj5ySUBshFGiMZTTkL1yfHQEs4z0jJIQyA7pTR2Z22?=
 =?us-ascii?Q?1IGukOm/TNbkuwa0w9dsiqGoPbcMWUyWTbsE328WKsdIl6lcPiX4ehOR+jpX?=
 =?us-ascii?Q?I/mnG1xQcYCKfwtZGu5SHnwCYq/opnpudH+HcUWEl7IajUu+y0yUVIqJIc+o?=
 =?us-ascii?Q?fwReWRTqcSTa1beqTiXZPY1hIx0q5hkCpfA4oS1CILF1Lu4/ytbLizVEev44?=
 =?us-ascii?Q?XkHP2T8NZQ2PC9xAWtK0utHPX/FzAW/WxKchsdPFnWX3RtGjHSSVQh+GUdai?=
 =?us-ascii?Q?KNymyozwwjCFH5RRpllOvDtioUArK+CmwCRepm/ARPQJCHv4EKTiy5oOpIX5?=
 =?us-ascii?Q?V1bnJ+sQ3fB5LSaWwsDRd2uueIL+zzs8vLI/fJhOxh1G0SWmyLnRWVTiDffD?=
 =?us-ascii?Q?CgP00FxthOSwtkDLGbnv/B70xjGhmooIK1tFbZZWY+6OuXTuYgLZrXvQjNFd?=
 =?us-ascii?Q?lENcQBhl8dJdx/4DB4EGg4+Qudgi/7YpFZixzvhsEsfMwuE/e9Saci93bYAd?=
 =?us-ascii?Q?SuxZ50XYmTfjSDQeRgfFi8cPKKjZTs7WT0Wb+zUKXoPQ38RvEXdPKNRcvbxo?=
 =?us-ascii?Q?G1Cnl1W59tNThFq7PvMs7Tr7IBtYJEylRUWgxEctWeiJTpsJUfUwDSjQFabb?=
 =?us-ascii?Q?uyROgYAT5iB9a2QWshCI5zarQ+ZH0RbNunS2Q8YnLd+OjmB+rOOb12r3atAk?=
 =?us-ascii?Q?ToxQlgiTvSeO3Ldvwx9XIZRVJmLbAQ3iW3yzKTe7+aYz8e/Y3Six2MjXPw31?=
 =?us-ascii?Q?rHgtOuYwT3pBccaPwOnUJqSEzAYuQ21rEbtg3nKTfh7dc6Y0nFRveb0Rosj3?=
 =?us-ascii?Q?syiwFmPLF15peFGdo+bBvQ6CaEPDHVfLop/7GISchWZh1v3Tu2XN0IRywSkR?=
 =?us-ascii?Q?EROez36LA6vBEY0Q9IxRMGEbqzlSEN8N3XHX4BkPcAsI8yFFZY/GofgTSW3R?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jk/MgqVX4h21DU2SCBCQswFd1b9/lX4sV0KMn8vIhwup7qQYYGtNJrkPbVPnup8ZkLlOcf25aFd4umd7V3s+5YrciFqPXWRhRQVs0Wgbi2xv2VA0N5ikASOEq6tV8irFVkXuEldfWvkCxJvBkHHHhE9iecCgHDppu2GbzsR04B4qH69GnTLP6TPB7P7TAPlgb3DpT+xCifEmNLrbqmPMXlXoGxX9+VxPf2W937ZL+cSUacc1KyijMP50it6aHGKPTsUIgri1Qdk7E7ICkHwvCBpP54/9g5vBQuao3OQLGf6EBeuV1tEa6WkO9ZGbxXjz5pNBQobLPThadl03WyEIhAUPHjxdIpLNvnAQULxXj+UlHjX1BYrjHPCeEP38FGU1KjFkbtKjdJwvbVutN2YWKgawB9wwQpkAGlLX9cKRDrTdBkyj5bziUhMx+CsckJ9FVpHsZ2tT0oGdU/VMeQTXqvdqdYWmNLHl4i62uEorYaqFBUt72NtQlBwQjBkHLNl4XA8BiKZSEKxu2G58KcpQ9FY58XrGUgqGAHh9vlMEUhzkiVs+Hpz7lDh0cc1NQn+me5arSFI2aEMekLwC1G8uqFzz6Be+M8TJWzJB6QPR8gg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791381f5-0d78-4941-0401-08dd18427c1a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 11:13:18.6436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjBi6JTlVOviU8zlYnB4VDPrrhol5HzcpmpLl4xLc/P8B1vfhocxLD6yP/d0RS+lIJIQcFb8ZjB5ZScAnWTq0afg4rcFmNzY0cdex1cOtjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_08,2024-12-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090088
X-Proofpoint-ORIG-GUID: HeQdgVWonyNDtEwlRslVAbTRrFNkL0Z_
X-Proofpoint-GUID: HeQdgVWonyNDtEwlRslVAbTRrFNkL0Z_

On Fri, Dec 06, 2024 at 09:28:46PM +0000, Lorenzo Stoakes wrote:
> We no longer actually need to perform these checks in the f_op->mmap() hook
> any longer.
>
> We already moved the operation which clears VM_MAYWRITE on a read-only
> mapping of a write-sealed memfd in order to work around the restrictions
> imposed by commit 5de195060b2e ("mm: resolve faulty mmap_region() error
> path behaviour").
>
> There is no reason for us not to simply go ahead and additionally check to
> see if any pre-existing seals are in place here rather than defer this to
> the f_op->mmap() hook.
>
> By doing this we remove more logic from shmem_mmap() which doesn't belong
> there, as well as doing the same for hugetlbfs_file_mmap(). We also remove
> dubious shared logic in mm.h which simply does not belong there either.
>
> It makes sense to do these checks at the earliest opportunity, we know
> these are shmem (or hugetlbfs) mappings whose relevant VMA flags will not
> change from the invoking do_mmap() so there is simply no need to wait.
>
> This also means the implementation of further memfd seal flags can be done
> within mm/memfd.c and also have the opportunity to modify VMA flags as
> necessary early in the mapping logic.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Hi Andrew,

I made a rather silly typo in this patch which resulted in me failing to
mark a static inline as such and therefore, the build bots got very cross
with me :)

Apologies to all for the noise!

Could you apply the enclosed fix-patch to resolve this?

Thanks, Lorenzo

----8<----
From 6cfef80e2ea5154302ba9b1925acd8e77ea6cd18 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 9 Dec 2024 11:04:08 +0000
Subject: [PATCH] mm: fix typos in !memfd inline stub

I typo'd the declaration of memfd_check_seals_mmap() in the case where
CONFIG_MEMFD_CREATE is not defined, resulting in build failures.

Fix this, and correct the misspelling of vm_flags which should be
vm_flags_ptr at the same time.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/memfd.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index d53408b0bd31..246daadbfde8 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -24,7 +24,8 @@ static inline struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 {
 	return ERR_PTR(-EINVAL);
 }
-int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags)
+static inline int memfd_check_seals_mmap(struct file *file,
+					 unsigned long *vm_flags_ptr)
 {
 	return 0;
 }
--
2.47.1

