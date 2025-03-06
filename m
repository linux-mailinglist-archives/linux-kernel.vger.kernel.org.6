Return-Path: <linux-kernel+bounces-548672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC52A547DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4991318920BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544AC2040BD;
	Thu,  6 Mar 2025 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZSnjWGmQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cCpAFuMc"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19591FE476
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257273; cv=fail; b=dSOhZQpYhceL2eKwvT6E5CYXawgc9Muus8vURTWk+1RZD0Nl0ujouVQspb275c9iFy4CVXHq802t9uheZCRBwoiwbOwabuDfAWt1rLyx+XhQNewF9AZMr6P8idu9K8ZN2ScCbePHvx50tka9yi0caicM1b0qDUQf0f1TcSoA17A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257273; c=relaxed/simple;
	bh=32NErCmLhe9vn5qO+6lSkGablv/r6EkPXHFbqB96QGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gSYvEn6yowlYKRYsDZxpTr3dTnQwtTdVWHelj1uRgZOiUV1ByVAVlQgq+zlR8xUHncKpLpVrzTruKMDiSfXwYjJmSNaGo3UkogL1iQUM3TObAr4WkeTas0/S/mGx/d8g9bYTjE1EoSZQPxJGbHtePeWbHESAwq10wRVU53EF/D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZSnjWGmQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cCpAFuMc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526ABj7T022611;
	Thu, 6 Mar 2025 10:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=cTTb8e9qNXZki0winp9zDuBW42NjoXUdms+Tbpbt81A=; b=
	ZSnjWGmQU+48kCfE3ljhmhRtZZ7sBdIMt47/Qpnbm7zYYrlYhsCnHO4eeuSdMdzj
	3bHyCCTjRwi1phKlUxFIJog0OYOk51vPa9a58LXu92kss2G0iZ9YP07COodrbZOJ
	dHzod6t0UVI/4YLkhXAFVNloi0G1l3pSc5JtlQUOJ34mnxybPIenvugrM+4qRF+b
	9pzBdc7QFScww/qsetJRtkPPFQ1KZPuKlBDHq86z1oCyr/IPCsYEFA2ftFuvDw4P
	i8RYpH3SznPZr3JZ1288a8EzM16as9cPHcLgcgySVXoAnrNu95pizsyD8giMWyZP
	rjap1zKFr4woa3Ki7tFUJA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uaw1sa4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5269KCmp015762;
	Thu, 6 Mar 2025 10:34:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpd0r16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6h+XU9dXv7K4vmC3XghuVkv6VVH93fToKLVFRxaZ8eQIW5YdybI3t7cKkR5fmzsZHfLq4H/mKWV//+pubjR7RCD3QPjdFWGfEMJM0abXhAeLZ2zNrs4sWHDaIa4tLIm05FT20vpysFxkyZ5qq33HE+FN0/Pxwdn9r+szejZKtrqPiUqLQLsEHN0msNxV7FDrDEx3zJwdkp6KKNBKlSDgHdb2DzDXodk8MoMxqKEue/T3Vx1oThJj4ssBojEbj9UuLLnPZAmqxmCJzbaePuLyPFtAxlr8ZMkMxv9F8Sb1qJCLYZuhCZJhUQDaIGbEfv/YyCA3RIkS5ryLfDrPaQx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTTb8e9qNXZki0winp9zDuBW42NjoXUdms+Tbpbt81A=;
 b=QsN7xI9uEVt/miCW7lIwINgEE+2iapwdoGzhligVvt+W4352r8HyGV1OVpUCg/1XGHJGKXON236vp9xrJNI+cwVMS3Na+KzqJ1ENPw9g4LpSCBWKWzDvPT9EVbn+5v81v541vVd6ZkZQHqdU96Lp4sR9aYO6mkCnZzC1/GCqm/nR1InJGEKIlhEk+sDNFftdAMnnAC47pfQvLQqghnnefRYkjuNkvE9sG1GPrJdI95azibOToXsKtg7L7s3sDEqldvbQpLqYZnAR2LEpYG3v2dR3dEGTaC6AQzrdOB7SjUk0sQ/2Lqx2HRVK974UNKw/9eT7YRKGpG2dMWqkNmVP6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTTb8e9qNXZki0winp9zDuBW42NjoXUdms+Tbpbt81A=;
 b=cCpAFuMcNafLKUew/BkUKy4gOcidOnvykk/+QG65e4DN1aVxyfuKXqkuNqyUoa8bLE4zdmhNvKlmRvYJoawNe7/NkjOQW8nNB4J7DE1o2lrc7n73+ayhziqyrXhx8Qh/bnaPP5FScG1RdcGoOjY9w5G7jDPMglPw8Xl2eSligEE=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 10:34:10 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 10:34:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 1/7] mm/mremap: correctly handle partial mremap() of VMA starting at 0
Date: Thu,  6 Mar 2025 10:33:57 +0000
Message-ID: <94681428faba4c34a76e2de1c875629372aae3d5.1741256580.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::13) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be15332-f440-4e78-f969-08dd5c9a6e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QPv/2vshz+GfhcSUDpKs0yQnkIhupwEvCZd7jdbXM8394liO0TlkQ5OGkLxi?=
 =?us-ascii?Q?hzj/W4yBYTSDNBxzbphYpGtHGvicEbb3AZ5dkGtf9uffaFEaYMz6V//W0WJ+?=
 =?us-ascii?Q?DIzqqvQIsfjb3vxnmT1NDiB4818vxoUU0mhyWD1McSSghGP0H/jTow6q503N?=
 =?us-ascii?Q?qqVsWdUyUFeZTOugKrGmT+bnLosC72cZn2vJVcmLKjOiTyERHtUaCbMg8iTN?=
 =?us-ascii?Q?RknEhwujDxMdeqML6m3+qJpwbVbTTtah2YH62ZDpKAivnQLgXg1Qev5UlOiT?=
 =?us-ascii?Q?1Frx8OnVrQm4nefqE+xwcfA0wKju1K5Q+Z2sLiWPPOAaQD5ykFBhRAcVIPvw?=
 =?us-ascii?Q?/RTZSgtt4eiml7NUFhZb+Nefrk+V5257/jbWEADmriIOzCVbaFaqZ9k9Y1Ou?=
 =?us-ascii?Q?0HEfbdpN35UicBZoW3LKLsKQbvwMb2Azq1dQs1F2HShClr/zBXMbzivtYI8N?=
 =?us-ascii?Q?s81Sq1Nlez92GK+GA7JUpP+QLO4SISZmxKz4LcyCmGAAGAOSg05F9ss438wu?=
 =?us-ascii?Q?CiCWtDt7UCLlFYPqFG5wNtodM92Pr5J88qFdNeJHYAoM1RSYK2upFFTj9/3W?=
 =?us-ascii?Q?uBm66MBiosqMnO91tGarmpGN9Lon41m5PZOoqTyVRJqXwh+TemupKc6vEnMi?=
 =?us-ascii?Q?KQljP4OFKdzYWoRp9qs8YDZsz/xFH2BQYuo4F9uomGwoX6/vz6D+B33SNJ6T?=
 =?us-ascii?Q?LxSEsxN6ZxHIkhdeZ+ogVgHRew6dRHFaTUVUBfyAt4GdSX4oTUgw31bvjg6u?=
 =?us-ascii?Q?LxYivIjj4K2Yj14xzSdrnnzqwYlRv33s+Ec2Bh+r8togD2BtAU3hswD005RE?=
 =?us-ascii?Q?fCW1VVUgSgTMyNQszd3JfWWNNQy+4rhU0LfZjhw9mBptC7L8Y+lfaovSBTQA?=
 =?us-ascii?Q?c47CzonvCEqLJf92YIr/7WkGgRAurjvza5jC0L/nb/PNJId8uRyWCcnx46vk?=
 =?us-ascii?Q?l53KqzhCZYkDzL2m0OlAV/KhOTzDCPS3TiwMVLUBwHYDoEcqPz4qEYRN0bJH?=
 =?us-ascii?Q?9InpEHMQRLhrIhaSdjFk1H5G+XIinquqlNL2JPQEeLh5f3gBSzvmzpS0RvPO?=
 =?us-ascii?Q?6GfWVAX9ddnfB6Aqyy1OziJu++qWCV0eE26yNNVsf4G2y78Bk3hBL0tu2kt/?=
 =?us-ascii?Q?neEdquVmF0V0pT4O4+FKg/bst6L5Qltigu92R66pYzNzwlBfnh71cV8UQan/?=
 =?us-ascii?Q?MltxUWO+6JUoY4wnVx4wm+XTIb+6/hH2oHIUA28Fd3mPdMkTRfb5d3q4zRWp?=
 =?us-ascii?Q?FFaC8f9EFmtNvl9ieKozyN7As/izV9mWMss0doYf/Gyq+MzOHqCgjV5NJS20?=
 =?us-ascii?Q?QduZqQxGjmXiD8HBJ5e9XxuhBzDuFSiQM3JrvlXx7mhNdC+0hxMwAt4NOl0w?=
 =?us-ascii?Q?h1qtCq4JH2mq/lTei1RNAdgIA1JY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1oA7oi61/1PDxL/QDrNe12KqYvWNs0jc2eBuAf4PytOPnXeLDHMEehcpKC9N?=
 =?us-ascii?Q?d2W2C9nMQzYs7F20j9nW6UXTiGVVWVNFBruAJBHlfqpgdumadiZFSpCT8Fqv?=
 =?us-ascii?Q?nxNViQl4tKVGTSpp+d7BnquYPKqsbMy8ZWRl6eGE4M3/SO+aSnLm/RAvCn0T?=
 =?us-ascii?Q?yXSh98xpspr+guIcG3bBsAvelweJEK2XeYABkrgDF4fgnahQwTUJmZfw2LKq?=
 =?us-ascii?Q?GALf73og7kRSnKrvN0WWRUUcobG9DUtR13W2/HuBwUtyssgK2GpouoGdWtCn?=
 =?us-ascii?Q?8RjXPdez2GOzmJjyr75Wo08OPZpZx7dnC3802aCEcJLLsnA9Be+tTeUQihiy?=
 =?us-ascii?Q?9oKMWLNCjtSq2JqH9RGcP7fkH2mwv3A3+HgfAYF8P5nioHGdjSmXXUJXsiW5?=
 =?us-ascii?Q?k/HMR6m+TM2XOEF08h6HhK6v3KJEkM/dZ2a3fCcw+gtt8sFBCPlZhpAMFHxd?=
 =?us-ascii?Q?58sOpVRNj05CX6bz0HMAB9Y28BPC6SmRa1RheiNUfOzJlUXy1L5DfQdX53nt?=
 =?us-ascii?Q?XKdZl2Cv7WB6koNuEfECkALxXKc/bYRgCOt81fknP1jaJvVe/tT3I31wMX/T?=
 =?us-ascii?Q?EgHeXoisS5kkHCc6Da5A8tNjAl4wC4DEtLEqaEYOmTb0wsS11nSRyxtV5BPA?=
 =?us-ascii?Q?wsrjS0VjVcnnFRR/I8AAymuJDhd7UVCV1u4uZuR3kR4k6Rn/UbK0NtjiTEVs?=
 =?us-ascii?Q?4jzg5OTonW93OOc+wRBc30cs3mOpWo/JDHenRbvjFODMnqTMj5ytcq+eyszi?=
 =?us-ascii?Q?DXYlbfhy+IgEGdwIN5HDNCLtMiU3IFJ8WNE/073IPLc9abK77j75mijal7c0?=
 =?us-ascii?Q?Bt6tKumJnov6vfiJ5vXps7knHltGfzoJLoaDFHwd8o0aY8GYYUb8O+zmwqf0?=
 =?us-ascii?Q?vOtnLthanVtnmBsK9NyVW//wPOgIYubQQQ4EigrcnOFoKsYuwwYPxhn+k3l1?=
 =?us-ascii?Q?NRn1MwZwyCFW3LLLb8zKerJe5rN0XpCE/CYmUm1hiDRyc9R862tujtIMXOym?=
 =?us-ascii?Q?kFIXY3LY7dJQHT4gJlOquNGzpLP+wYc0hbRSghlnxNKLPo5D2C9If7anEZda?=
 =?us-ascii?Q?PBsN+4tebtQNByGFoKuE8RWby2VWa49L0XLBkBxcXoQU1g1ire3dmDwbZZmw?=
 =?us-ascii?Q?cIq0xTic+KybAD/XprjjrRW3XxYR3wUg0W4jnMNVk84biARXns4WT5Zcb5u+?=
 =?us-ascii?Q?6DHpoGXRcjbMHk6PT0jCSNryfKFKEUUadePo9XHCgaRK28v7ZBotWaYO9NLE?=
 =?us-ascii?Q?P0ZwiwqAMDNUCyqBmP9Jat5hycduQH7PU4YvU66WoCJiBEgJDSMcELXpsovs?=
 =?us-ascii?Q?edaaSVfyjx59iix0nli/S5hLeNwsJl2XuOtZrYm5jSA+QNpoSE8LoeD5gCOe?=
 =?us-ascii?Q?tQonD6CjJt18WsBk6Wa8mGoiflkCDM8QB0slKcBYf468Zy2L1EUYsiAc15Az?=
 =?us-ascii?Q?wP2+LqNn6RbXpgFq1kzFkSYIMeRfktRW5tXlZQR496CAzHf59frLAnxRbbuA?=
 =?us-ascii?Q?RnHINIsvhJ8H6lS+VLSoeMmETM2LVn2IyrKKJT5oYngvONDAd9LlQqYQxVSG?=
 =?us-ascii?Q?CiGE11t3CDa4GsqpLauCzA3lyS5l22ooCHm63CDSvc0GOTM8XUUlwHoxGCan?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HQo6OBAYEoWwSHrnMIAe+9GWf+yi5iVVwzd/9YMWqQaoPOMCP47F2KMzUDocfQDgnEEWRlOPpE9hLggw2+PYrhiAPf+ZDxaE6cryCRjkoOajMFVMa5aZYbp/NTRoiO4zivszXKkIasu1jHNaOe8BeaFGcNR4ZqQeMC4KKJV+rYe5kThXMV4UO3Pfr0lSc+pqWXtsDDqFmPeXjwpdS+9UffTl3AS85FQPvOkFCO2BPXLCzwUckmMaaZ21PKnfpZ4lDQS0kviaLP69kkpuMRe/s7dfiPDIbL/Y/ULFOpo+vtX793f6XITnP3QbGXxt6mwUbx7acp5YEccVlS4a1W5WhEEOyYu0VOPajFkSQHkeZYEf9iHgZ8Aw+MoLgl3eFlOp28KYaUyaopggKpyij/gujo6mC5vMK+Q3fpsbfZQhq5Jx9OApyLcENv0ILd66FsRp+7SDpP9olXKpp/GF9NoKGIuVgmmUIOBhK4UrJSEQBg04a8TV5gXucMQ++s2mX4GrUlg7zWQv8lPIGrFHbt8s1BzWaBofjFKi67bttXy4XQ4gXe3mA58F5E7eD68f3u7pFpzB5rTviyL3jyhqBpVT6eDDTAv00+kWVNrTThpyhtw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be15332-f440-4e78-f969-08dd5c9a6e19
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:34:09.9673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGLSESlpAI8sW5pmuVHItO9uDRG/eQ4Cec/VwUuLDyPadPPUKm/XQnwISPs09aKG9ezh4uXO42ArgmBZXZUoo567VNR34Ez+oYNW9xsFHik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060079
X-Proofpoint-GUID: 45gcKt8moDfUzUqrHSsxlSsRMvfMSOLS
X-Proofpoint-ORIG-GUID: 45gcKt8moDfUzUqrHSsxlSsRMvfMSOLS

Consider the case of a partial mremap() (that results in a VMA split) of
an accountable VMA (i.e.  which has the VM_ACCOUNT flag set) whose start
address is zero, with the MREMAP_MAYMOVE flag specified and a scenario
where a move does in fact occur:

       addr  end
        |     |
        v     v
    |-------------|
    |     vma     |
    |-------------|
    0

This move is affected by unmapping the range [addr, end).  In order to
prevent an incorrect decrement of accounted memory which has already been
determined, the mremap() code in move_vma() clears VM_ACCOUNT from the VMA
prior to doing so, before reestablishing it in each of the VMAs
post-split:

    addr  end
     |     |
     v     v
 |---|     |---|
 | A |     | B |
 |---|     |---|

Commit 6b73cff239e5 ("mm: change munmap splitting order and move_vma()")
changed this logic such as to determine whether there is a need to do so
by establishing account_start and account_end and, in the instance where
such an operation is required, assigning them to vma->vm_start and
vma->vm_end.

Later the code checks if the operation is required for 'A' referenced
above thusly:

	if (account_start) {
		...
	}

However, if the VMA described above has vma->vm_start == 0, which is now
assigned to account_start, this branch will not be executed.

As a result, the VMA 'A' above will remain stripped of its VM_ACCOUNT
flag, incorrectly.

The fix is to simply convert these variables to booleans and set them as
required.

Fixes: 6b73cff239e5 ("mm: change munmap splitting order and move_vma()")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
---
 mm/mremap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index cff7f552f909..c3e4c86d0b8d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -705,8 +705,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	unsigned long vm_flags = vma->vm_flags;
 	unsigned long new_pgoff;
 	unsigned long moved_len;
-	unsigned long account_start = 0;
-	unsigned long account_end = 0;
+	bool account_start = false;
+	bool account_end = false;
 	unsigned long hiwater_vm;
 	int err = 0;
 	bool need_rmap_locks;
@@ -790,9 +790,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
 		vm_flags_clear(vma, VM_ACCOUNT);
 		if (vma->vm_start < old_addr)
-			account_start = vma->vm_start;
+			account_start = true;
 		if (vma->vm_end > old_addr + old_len)
-			account_end = vma->vm_end;
+			account_end = true;
 	}

 	/*
@@ -832,7 +832,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
 			vm_acct_memory(old_len >> PAGE_SHIFT);
-		account_start = account_end = 0;
+		account_start = account_end = false;
 	}

 	if (vm_flags & VM_LOCKED) {
--
2.48.1

