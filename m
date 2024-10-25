Return-Path: <linux-kernel+bounces-381661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A4A9B0253
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB3C1C2197A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56D2038B8;
	Fri, 25 Oct 2024 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jk2sLPvx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sge1IFQ6"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E1203709
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859230; cv=fail; b=s5c4Tgt7C1du2TIX2A6sdfLR+w6q/bRyvmL+LwnNCUxu/H6vE74owxCk4G4wQXdYMMrdf5kihLvvsz8bmk2bgTkm5MS4oGURDEHcetmMEYfW0iemf/2Ra2JxKCB9mDB8LJSWKZwkW6JEJKLXtSPVD2HMyJrPYfc2lrU/LZWrWWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859230; c=relaxed/simple;
	bh=mWY4Zvj892s8PHycPdXU9p0PJqG6P7RW1GnZFfrZ2+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hr6hB2GvKlyutY8j3gexXrt2KHBUYZkvLaEerNRlnP7wLfkJQucD0W5/1h7zsEBAnnq0YBoFgWz/74ctz3+f3tpr8+hdfnFLsVj8gq1qTk+INISCcDIGc/KyXKsMYBlhuW33JRUFojFscDfPYmXKwRhgtJNMj1t+yfMvfi4xmEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jk2sLPvx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sge1IFQ6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8Babn014732;
	Fri, 25 Oct 2024 12:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1RKAonmcILha8U/5gzL1MZCRAiyipTUTBI1zBY8/ua8=; b=
	jk2sLPvxcBTa+qktcW34pQG1spl3NzAuprtVz+URBnaOeklhuwG6UbYsyv62Z8dt
	TgbsaXJ0/BlQu6TdAzRf2uYoYG7hJ6ylOdjOoSgvFgvt7pwLJRHgEvj2czzK3EtK
	1o6seh2pJjEPQ8VX8nhws1E9jezvOM176pgDUGm6kfxNe9w08mCfGpan4BsNuKk/
	3WbQdHH/tIIwhRRzkxlD+ionC7XG1rUSjKkrhu6HV576ZUFjmFcG7+EZ3N5cU9WW
	XIo4wPkVkJlrI7QZXs02ENgEdQMuloiaj79YsM3OrrQxRDQcFoJUjJJ32bOVKh0m
	Ep3QkJ7iULMbTADaAx8sqg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asmusx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:26:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBxpoZ016557;
	Fri, 25 Oct 2024 12:26:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdt4s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:26:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDcSHylas1xZc8YOYyoNeOelaWe00gN6T4J9MPhjnGQuMXcP+YUSOhFQFm6/ALMtgNxeyprYq33za1YouSwLYfBb1K/BnCsBoW4K5x5a9CyPKelBISO0dS5HxAjOYqd0dr+BUXHO7Q8WMV8BJkwWsH+SFN4mLWpa+iIFQcdqpL21PbejvgB0fyvTDnJNkcuXiPTj7uor+m8owccVC0O35YSLZzl8RyLxsjbHGMf/bAmYxVzsANiKTGYC/mJsuDC1MQ/LwfBu2N9XgpnpmhcKfvI3HJCxTArDn2bwxp8ZfNBsbv0AvaJR2WV7f4PuSmqitqTHyuPLnpYKhWADdn8CUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RKAonmcILha8U/5gzL1MZCRAiyipTUTBI1zBY8/ua8=;
 b=cvkKnk1y1ZOvX3pNWS4OKkA0zn91DqnvvrCaZ0aj/I8HbgjGzowiWLQIgLVD+g/7i19M6ArSbdH4wZ8MhtyVXyhzhUQQb3amNw+dRjBJLGH7dO2826R0wYnFyqaT8x+SwvkEi5XdDsA10zO9egyEuHMLEcslQ1bYzcLSS4t328XO8yIOBqIJSAPk5oSfqCLWwwJ0gjUzylbz6EiMRESBFn1UjdhTeiC/zne6K9P0oRPTqCd2ZATIGtTttdT+9GEU2FDte4grgWrCaYfnIMGRyYy6h04Q1DDORJ1G54TWtO3KeBgSjFqip7bd9/UackedXhvMgsyBisCgJQUOlBRPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RKAonmcILha8U/5gzL1MZCRAiyipTUTBI1zBY8/ua8=;
 b=sge1IFQ6G1xYqSM5KxNLgBwuT0CQLmlVNVsmWWEAEecCU2fwei9zJaAdy7t4vsirwadq2QLGO1mKwNpALkL9+uZVjnHIdMMggsRs62pgtn8N/GkV0Eo0PgQrqPPH5zDczKNt8sex7kzYxqkuhzdhIAy5Cb7soW8nmFoKtAN4IH4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4484.namprd10.prod.outlook.com (2603:10b6:303:90::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 12:26:51 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:26:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 1/5] tools: testing: add additional vma_internal.h stubs
Date: Fri, 25 Oct 2024 13:26:23 +0100
Message-ID: <74b27e159e261d2ac1fe66a130edad1d61fdc176.1729858176.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729858176.git.lorenzo.stoakes@oracle.com>
References: <cover.1729858176.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0376.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::21) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 2febee1c-88b2-4f95-e90f-08dcf4f04d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V0orUsKOU5W0QrCZy3vutQ1kkVa/XsYApv1AyHvkFwYRK4tHUEYhrW+Oj29x?=
 =?us-ascii?Q?SV364NKfKdCiCHN1r2oPJU4iQ5a0FNQ/BU1OzviyCEpAgH5mwWcVTepju8Oq?=
 =?us-ascii?Q?3gUoaMNnO2BgqFkbnWodBvMyflBi9CdMAVtROO3k14s6B5vQUrzKM44n9Sv0?=
 =?us-ascii?Q?kpsiWvzhtS/O+vtAV9yBR1SCW+yL7gOkuB0ebkIFdMv8U2wccFzPZCVvEkyw?=
 =?us-ascii?Q?0hUqNAREq+5w4FK6gbYUo32vaskwG1iYSwWH+V7cV4n4IKwewzYXoKcNqtR1?=
 =?us-ascii?Q?OZ/MrgKq68Ooxf5ht30cMMFSi3FhHPjUC23cTJGHMUuB44RmL6XaxLvUpjT2?=
 =?us-ascii?Q?Zl8W8Tub6deHQiv3LeoI/ldR4vwG5FNeP47hIQbwNhyI6KO/XMi8/gnFV/vU?=
 =?us-ascii?Q?Fca1YclerZzKA2Gf0Cst908hvNsEqSTdegg8bNVoGvf0rLCaTJRIukDCRskM?=
 =?us-ascii?Q?wC6uiDWmQUkuKcFnOM/w9HZH6ZC3ZQxoNjs+6EVXgdMd4TedZxrYFwE7ZAgm?=
 =?us-ascii?Q?cOHGFVpt/TUgFOI+H/w03Sb3fJ26l4IdWOXUc9Q3xhgPROcJf6aNtmA96quR?=
 =?us-ascii?Q?tU6D7mc9XdbUkLVl+b9ZSXY6C23TXrW7gOeDaGVEMpqPLlk5ZavSmm3CHNh4?=
 =?us-ascii?Q?HPw9kVxKo0uGeNrhIFf0S4vUZRSQXqQpjfigbZ83Q/a5uxCjYdCgJwRR36Gb?=
 =?us-ascii?Q?S1VfE7zd76/v3LBgHabv0bCmTNm6qwAfdRhJkNuQT5VnCiML2G/cU0SZzPGB?=
 =?us-ascii?Q?c5/x3N5NFwLV+t96AA88FWsM3OD5z9T0jAmhboOP4m5Yr5KOfO2taAHlkNvH?=
 =?us-ascii?Q?QJNRI5ABkKRyZNMR56gFkkQCUdoWLwsjBAhIvXfp90zp/WPP5lIHZ7YJ2RbS?=
 =?us-ascii?Q?cV8ll5Q+XYhh25en9Rm2zfyirbtWi69VYofEzymO5HmrySS0lqiIbsXyE2Gc?=
 =?us-ascii?Q?agw8r6ajpqkWQ8nD56836eaFoVpt6qY3Nfs9yq/cVEOqW4NftNUO+6MpQezN?=
 =?us-ascii?Q?WbBwaT3YJq6ZJGZGNzvpxMhRO2WjbF4sl+YiBVagtPZtHmtQHsqfObjsi04V?=
 =?us-ascii?Q?NHhbIaugqML6zSrDINJN7385G43Se5GjE0EHFVTWRKPoziQQhrbbedp1mRHC?=
 =?us-ascii?Q?OZf8xT4I12ggH1SLkmTfPTuMjlhO2j/t+bIxm36qUosTf6OOEFopFlvV2TUQ?=
 =?us-ascii?Q?4JEgb6u6sOhCT98jdgwwhbrrRPI41ecWTEojx09En8MphvE/iI+elaawid8L?=
 =?us-ascii?Q?uIBFVB/dYyGquEmQv9bszKrW+O/su2pEOr2jAo8ss1oyfjrAf5vO5it+wcn7?=
 =?us-ascii?Q?u3g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x8p45yt9FKPcpbMPnRRprJrxXPIRdPsym8NQe00dySAY79JQgQ50XZRf3f5N?=
 =?us-ascii?Q?IZ3NakYJDldIpcz35egynBNPsO8xEmgZ+0tsFN++lLrDiZ2Hc5qYPigCChSf?=
 =?us-ascii?Q?As231gnS64Zyusomt7DQH7SiMqfDgX8URuOpG0VVNlVN5TT+kG9m38okpiI/?=
 =?us-ascii?Q?BKH5TUnuE076Te7z381TtLewUVVIk6jlQw3EAe0pnm/er7Ckb3PP178zJygf?=
 =?us-ascii?Q?15LD1nwj5HrzkRvQ+SihDGvKoGd3VDWitgxFMasi7lbQV2iqDP25LZwMNwNU?=
 =?us-ascii?Q?h9jlkYykiIeD/s3zokzLtrDkvACOD3BAkPqKO0CFXFJWSpZdro7ejce1z8OX?=
 =?us-ascii?Q?MGHG5jENwNcFWJr2Heu3UWAeqPXs0PgHl0Y1d95E5qYuoDOpUwhKm3JPVPgm?=
 =?us-ascii?Q?dKxMbt5YiMuiNAFBuJmCj+A0vxoIGztGrFIWNgqvlChpI0+z8GqDUMjL1dSW?=
 =?us-ascii?Q?mIqYiLQuN6/f/qn75Td3d2T/VrrMFcH6VSpNJ5qJ0i1oqXfK9fuujLrfsm/C?=
 =?us-ascii?Q?fQxymWjMoPm8AphRmJr9bOV3k/Ki0UF/pUbg1Hs4OYbY17THXqdE2xUwKin5?=
 =?us-ascii?Q?fnXc6OTqF5mmaLsyCtihZsrtCcNs9KMmCBxFgDHRF3AHbMhuh0ZDkbxxTJT/?=
 =?us-ascii?Q?b3oz0UPvsMeV+ToVZx9T5T0wXl521EScOD7kxt4j1yMy2ZEo1+68CIebDYK2?=
 =?us-ascii?Q?00fjNsaLNg+PQyKdb2OEC8SovjeKVEFWa0ZO4sHsuYckVUGjyqrNE2UjDaNm?=
 =?us-ascii?Q?bBcAkkiCQJU6ZpnmqBy+dwe1dLV3CnSJTLgJ296SCwYrA2hmBIpv6Ayrep/p?=
 =?us-ascii?Q?MCpoWEwIrxfXfzKzVYcH01wgkU6Ey9k8bA9fBwDDN5Sveuh9qu3O/1hdNgLD?=
 =?us-ascii?Q?HKmRYBo7US0Vhdby9kUWp+NIwBTgjef4QFjMaJNN62aoUvYbm+jjq/2TLyhW?=
 =?us-ascii?Q?3roephfGjiJis+XA4yd5DUfHlnYhZn7nEMzojupLks1vpdKOZ7uqia2f8Goz?=
 =?us-ascii?Q?0dmHVsK4E/iONlcAta42LTC48hRAY+S132ufdhjy4j0f0Wx62kBQ+jwxdXIO?=
 =?us-ascii?Q?g+uVuSZS7U+Oeirn9CO/+bUXWIaKXaxrwEUXeHbqxEDu/CxQkdXMOTJE9eNn?=
 =?us-ascii?Q?Gx3rXKEfK9K0749JHbtDJ0Ad85rGK1MraRqxINemu9TDbRE0wmA97zE9qihg?=
 =?us-ascii?Q?QsDkxjw0jFzS7YzQSOf+dRYpJ7BjfUQFXT4SmFWwlbFg5xDLWyLpzBf0Dae1?=
 =?us-ascii?Q?s6ulGYAMd4w4QV+TgaF3L8KHbyDgDnu4775eHzUg7INotBZ70TEV/3GALojb?=
 =?us-ascii?Q?bL3Bw4B3IQoMpwU0enxMGN3h/IZCXodWo3iA5iLERLt79vjhKBlmUpiTKxgd?=
 =?us-ascii?Q?2MzaBqBgQ3BKzHHJvvffA2u2C+4OxjEJOn6UZqi/aJM4pXCX1gqLY7eAQ1fD?=
 =?us-ascii?Q?yaOzalr8Hgn/d3fmC82rpzK7qt8lFYTYhEIZ/wjHceiSJzXItxqBidouOERM?=
 =?us-ascii?Q?mfHDmpaAxFEWK3vIja/pxv4LhdbAMoPscjzWkZ3UzpNmqBbiEBc2SthSsGeH?=
 =?us-ascii?Q?FxCZBFG6OnbT6Cmo7rxHN/r+/kri2bSjRTZHGouiA3upRpKICIkNj4EQTD6X?=
 =?us-ascii?Q?KFufmTlhZ4ZtSsgFK0BmKxwvLHI649S0TnU2ixq0wFcDOld8L/b0zIJh3O65?=
 =?us-ascii?Q?ydZHwQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qineu5xaRWetUH6gU2Yn86RLod33WfYM17wl9VC5yOpaVxrVrT47vA7irwgQAYygVuia4XK+X6JvUfXaNEOjAhZxYPQkcUTeaxfwejgXfqFFMHaj4KSHPvGjRJDXsfXRNTPoDaVevbDjq1x9vkuX3EH3MV3aQq3BYuTSYq1AXPzvcrurRgLc4Kn+Tqs4IS4r9okiS3JE738LS/JHpMg9sYWNzosZGRbZRRXOkRhV931kCR/JAWPuHRVyWLura2Ikc2BXrBv90R3SNUguv3Fv4XuvD1T0JaM/2u1+uvMIYKsjF8ntpWTmlhLif7idWzr1N54nGsvtOVSo3Z8HdZVYlCzxP1CXGnkK4kMK6Iy8PikwUQp7vz7PRxebNFoymSdC9O7etQcrIiBbDkwmHZwGtpq/QFED3LtHiiCYI2whb6ur+oLuBtysnJSSXyVwtOnbKRcb+01fjBkL85WT6YuRVHw858EQSeQ4q+ZF2a6ufz7DBdRlr66jlP1iV8G3CHkSpzghPfClw44SyQqEZnsaRA/zQblccWPTLbSwmbSt2rYRekL5XfDnMSQk5hyuvy3N43IA/rhsA7CQjH3vRJOGNcsy7nqWLMBac21x11bqPRw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2febee1c-88b2-4f95-e90f-08dcf4f04d91
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:26:51.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1NX/qyhrqjVy5I/kPLm03VvmjUAE7xCgM6HIN9qnGwGLus1YZawizZH0yhZH2KpfUhBOG+yaGvtD3qQbfOM7R+Ft/5fE+jlhOSIfJhE+z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250095
X-Proofpoint-GUID: M3vftKXBPRqZs4T8LzkxgK52g6k_AsMD
X-Proofpoint-ORIG-GUID: M3vftKXBPRqZs4T8LzkxgK52g6k_AsMD

Add some additional vma_internal.h stubs in preparation for __mmap_region()
being moved to mm/vma.c. Without these the move would result in the tests
no longer compiling.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/vma_internal.h | 115 ++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index c5b9da034511..e76ff579e1fd 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -44,7 +44,9 @@
 #define VM_LOCKED	0x00002000
 #define VM_IO           0x00004000
 #define VM_DONTEXPAND	0x00040000
+#define VM_LOCKONFAULT	0x00080000
 #define VM_ACCOUNT	0x00100000
+#define VM_NORESERVE	0x00200000
 #define VM_MIXEDMAP	0x10000000
 #define VM_STACK	VM_GROWSDOWN
 #define VM_SHADOW_STACK	VM_NONE
@@ -53,6 +55,14 @@
 #define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
 #define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
 
+/* This mask represents all the VMA flag bits used by mlock */
+#define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
+
+#ifdef CONFIG_64BIT
+/* VM is sealed, in vm_flags */
+#define VM_SEALED	_BITUL(63)
+#endif
+
 #define FIRST_USER_ADDRESS	0UL
 #define USER_PGTABLES_CEILING	0UL
 
@@ -698,8 +708,9 @@ static inline void tlb_finish_mmu(struct mmu_gather *)
 {
 }
 
-static inline void get_file(struct file *)
+static inline struct file *get_file(struct file *f)
 {
+	return f;
 }
 
 static inline int vma_dup_policy(struct vm_area_struct *, struct vm_area_struct *)
@@ -920,4 +931,106 @@ static inline bool signal_pending(void *)
 	return false;
 }
 
+static inline bool is_file_hugepages(struct file *)
+{
+	return false;
+}
+
+static inline int security_vm_enough_memory_mm(struct mm_struct *, long)
+{
+	return true;
+}
+
+static inline bool may_expand_vm(struct mm_struct *, vm_flags_t, unsigned long)
+{
+	return true;
+}
+
+static inline void vm_flags_init(struct vm_area_struct *vma,
+				 vm_flags_t flags)
+{
+	vma->__vm_flags = flags;
+}
+
+static inline void vm_flags_set(struct vm_area_struct *vma,
+				vm_flags_t flags)
+{
+	vma_start_write(vma);
+	vma->__vm_flags |= flags;
+}
+
+static inline void vm_flags_clear(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	vma_start_write(vma);
+	vma->__vm_flags &= ~flags;
+}
+
+static inline int call_mmap(struct file *, struct vm_area_struct *)
+{
+	return 0;
+}
+
+static inline int shmem_zero_setup(struct vm_area_struct *)
+{
+	return 0;
+}
+
+static inline void vma_set_anonymous(struct vm_area_struct *vma)
+{
+	vma->vm_ops = NULL;
+}
+
+static inline void ksm_add_vma(struct vm_area_struct *)
+{
+}
+
+static inline void perf_event_mmap(struct vm_area_struct *)
+{
+}
+
+static inline bool vma_is_dax(struct vm_area_struct *)
+{
+	return false;
+}
+
+static inline struct vm_area_struct *get_gate_vma(struct mm_struct *)
+{
+	return NULL;
+}
+
+bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
+
+/* Update vma->vm_page_prot to reflect vma->vm_flags. */
+static inline void vma_set_page_prot(struct vm_area_struct *vma)
+{
+	unsigned long vm_flags = vma->vm_flags;
+	pgprot_t vm_page_prot;
+
+	/* testing: we inline vm_pgprot_modify() to avoid clash with vma.h. */
+	vm_page_prot = pgprot_modify(vma->vm_page_prot, vm_get_page_prot(vm_flags));
+
+	if (vma_wants_writenotify(vma, vm_page_prot)) {
+		vm_flags &= ~VM_SHARED;
+		/* testing: we inline vm_pgprot_modify() to avoid clash with vma.h. */
+		vm_page_prot = pgprot_modify(vm_page_prot, vm_get_page_prot(vm_flags));
+	}
+	/* remove_protection_ptes reads vma->vm_page_prot without mmap_lock */
+	WRITE_ONCE(vma->vm_page_prot, vm_page_prot);
+}
+
+static inline bool arch_validate_flags(unsigned long)
+{
+	return true;
+}
+
+static inline void vma_close(struct vm_area_struct *)
+{
+}
+
+static inline int mmap_file(struct file *, struct vm_area_struct *)
+{
+	return 0;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.47.0


