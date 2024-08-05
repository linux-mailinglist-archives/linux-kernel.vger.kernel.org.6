Return-Path: <linux-kernel+bounces-274631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EC3947AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853C11F21722
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB865157E9B;
	Mon,  5 Aug 2024 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VSD+pXdz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BrhTUnVq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246A4156F42
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860077; cv=fail; b=V4L0+c1IKRnW/qp+a4A0VGJOyuinmio57Asr2JQmnEmkIAlhh/IRQhJpJqxtSHEinmgHnhnTinP0NnLGzDU4Y2w0PE/nBYdYd9CF6wIBfbX9ogFujdRq09X9DotlUM0FKy2Aqmg4lr85ckCjYhY6hI1Fn4kvjk3ecwIp4hPiqwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860077; c=relaxed/simple;
	bh=Lsc/lMfj3wrcVLp9p7I+QoV02CI26YJPE4TjGlkrunY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Avp3q+plOlHFuail19wpLhValoUqeSqIr9bzbTMloBGgKI03awsxf9gpFwiUaju5quIst1dcB91S2Jnocx/QjAgH6h8SjeofnnwC+DpoH+jttbcpzUQnBHnNeRR5CfMOIa9dxyaGN6MNGUvs4NC/5BOxor9XlWtliwi+oP8oCvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VSD+pXdz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BrhTUnVq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4758fYm4026878;
	Mon, 5 Aug 2024 12:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=71E9b5edNWehB4FWBwOo1wI3c6T1Io1IcU1kzN9o+1M=; b=
	VSD+pXdz3WGvtzSqfd1wSgWTBLnR1Ox2qdN6EglmfI5NJPuIUkDQQUGXcY1lhTsf
	F8vcfiM6B3bwjyub+/DrHO5oF1NTvV15jFBPP8sShc8ea4lB1mZYvH3DENbylZ11
	EjtncaKy+VnZ1K2vQ7sNGaW93//kBYltG8jhwHrGHlFGggZgUO5eUCATjqK9di/+
	3bINn4vy6hRKB4Y2sQz102Bg3b1JgVDoCNQ2BYJV9AEvLAmt/c1dDbiBoptqvGbg
	q+GNqT5fv++U42lc8FskocJYy7VSKSsNbB3YW7Uzk2oCKFI70YPHwi0OcVGATMaY
	e05f/OnKjcUB5IGdvDA83A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sb51ag8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475BThY8018392;
	Mon, 5 Aug 2024 12:14:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb076p0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zr7zbUalMXaXxDWCR8qsSKLkqoQqipuNx4H++hR0Rkigv2DFeOiJBnq7zK6GLhaoSmWeD90PCcqXcrVA8Bqq4ta+0F8rsoNaANConqaLDg/N5/QVoVDY1jPU9UbsQqK+tNMTdULqy6t/zJ+3/LFxs1rQYbuNWTnWUjrl0nfHy5NR/3oB/HCRk/S7Gzd3o7ZbxAxvNlEJVX5fPHcqxk/dnlnsExTKm5OvPdPdygwijSZuFLql3psR5ELyYsT+iDlWDiRffVV7CwVRaia7m0lXBGiu9oyYCLWlsK08aM9PVGTy9UqObpih/vknsaQQqBDLmhrkdmDfdpMdN6WWsxSJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71E9b5edNWehB4FWBwOo1wI3c6T1Io1IcU1kzN9o+1M=;
 b=PSzTVwMFC/ZsRNPE7MrRIP5cGv0bUUPxRn85Lq662WKZpVZ6v9rhDBElqyHKED+Regg8kH98g2ysqFSn2DSqJwcGOKjlKaUesCU6npiZ0DTdZqd1qmL4UEs9v9A5MLlYt33eypp6pqCItaeQ1rD0Nu6sKKIhLOVtntVflsc+CwkOR3TOlTX8G/gxvUn9h6MPq1Sjxv67XVsLyqgDgNUc5CKJdq1SbaCkZ91nPijWjxu6C5TPQJkXbApBNRTkq9JkFZ0rhXHnROjAw/JiPmUN2yx+P/fzqTW2ndZNH+4RBL+XHr+oV8iROZnlUy84b8cAbPFaHmkIRTigvec+qWIfow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71E9b5edNWehB4FWBwOo1wI3c6T1Io1IcU1kzN9o+1M=;
 b=BrhTUnVqhsJGkOI4D+qIWcbaOS1JW1zbRLxYNDEYpZHo6FuF1fM/WhNM8cb/aZUI6weqkWEIFZMcQxL4ur8cj1CZ2MEaH9UzBlZ5QT2uIHWqov60dB+TuUp+B0FOgMN00L1Xio3U3/vzqww9rWKj6jKWuhwcMNuBBgXfTSpigm0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB6334.namprd10.prod.outlook.com (2603:10b6:510:1b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Mon, 5 Aug
 2024 12:14:21 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:14:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 02/10] mm: introduce vma_merge_struct and abstract merge parameters
Date: Mon,  5 Aug 2024 13:13:49 +0100
Message-ID: <f2d7cc5de8aecc50d353980f62a74a0a6fcec198.1722849859.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::9) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: b28d68a4-e08a-4dbd-54f7-08dcb548233a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s/c7LxiklbaUwb1cd3OJxrXRTEwvM9MeT6g7d80qVlaFq3Ze2XS7lSswHNh8?=
 =?us-ascii?Q?k4OmOY88zQQVBng20M0xSoOvSWXM29VqkPj8aMOQ5WehuOBLn/KHkq9HY6vs?=
 =?us-ascii?Q?MMfks4rSvzw2Rs0Jlj0zyhU5LXwhF77Q37LfJaZxuIu+Xf4ZH5LnvIUnKxco?=
 =?us-ascii?Q?QsWz4i7/iL2fvGQWIQfA4x3vlBcIbyqTrEvuqlkwxF9+msXRxByoOLJrDMdd?=
 =?us-ascii?Q?L9r2sEt2m1poB76ptNi5XoXWAszWc50NnOVU7rXEiXa/4Rw+dQ1ptMhtcUA3?=
 =?us-ascii?Q?N4RhEhk+xZcum+E1yGCTD4eTqb9FAzf8QYFZgOjfcnMOUQYYrV1OirNEanPJ?=
 =?us-ascii?Q?5UffxrqPAJLenKdNgUY0FOl+BJT7hkyQHblqSXM257kqbv3+nh44B1rHBTFt?=
 =?us-ascii?Q?uIP7OkBm0Xn2aZJev1sIXx1rz32HmgPeCnL9ougQK4Gv9izzZl2TP8UPeYbC?=
 =?us-ascii?Q?hpvP7hK1jTrMAH4DPRQ39doD3Sx932v8zq4IrHKZzaM4dAaPW52B8+yZ1yJg?=
 =?us-ascii?Q?ady3nwCUcriJId9V5kYq5Y2DpU0Y8nny/wLmrGXW+bQxMXUHD/XDOH9YVgjS?=
 =?us-ascii?Q?Z+mIavNPwfP74k/5Hll1iM13Pv6Bdd0737xojVpx4VNhbX57qqN+2dpoabkZ?=
 =?us-ascii?Q?jNVnZnsAheK09+GArLCzleCadzVRGwfjgqV2BZYHSUcAb7s659JnGLL96SCI?=
 =?us-ascii?Q?DQ+qFOqtPU2L6/ZOH1vKR2dLrRQxBOnDf/XvkgTQZlJ8QT9YI9VTDY/tAxus?=
 =?us-ascii?Q?wvjKhDItfMo0y+/xtrMlrz1Ld0diC1rO6Y9tQsbOELzZb6ilsmmfdBmTRhAR?=
 =?us-ascii?Q?SeDI88X2PSGAbxkMlpS3ElI/MUlnUhCXWKue/+b2yxr+PYC03gpUCaTSH7gS?=
 =?us-ascii?Q?Gw4fXFd5HRsGbrzG7Q8UxasW7GxuYDku+GVb3e6zsS++DEmv4KdscF3jo4tT?=
 =?us-ascii?Q?xoT7EhCAXHZLPT0MhcOaK2WnDM2zSSr+SHmXR5X9g95HtU0kLwXbi8Qx5q/c?=
 =?us-ascii?Q?20H29Nua2DswKiMbPM+2hDbZxECzJ378GCXV9U3RPTtRq91nrSjoR898moi3?=
 =?us-ascii?Q?8edMcIlFiNBUJ9YMbIcCOmcHYzNAWG7Mu1ETCATD6728KoJnxGPnDt9Y/5wo?=
 =?us-ascii?Q?VQG/h8/EhgEwg6rhHY6Qu5uYKfoAGHBSi7cnXnK7bdBiAmuIdsWMMJ+MHDc4?=
 =?us-ascii?Q?FvfqoFi9k1pgQgj+2KhTQKqToIAgbDNASUyaZZaZ/kyLH6GbHaLUoLQ/SsRR?=
 =?us-ascii?Q?YCCmbFXIY27CY/2YhvmQQfuAtfr/P7ua57M0NNnGFxXhHecx6DHX6jt7bOMi?=
 =?us-ascii?Q?PT6Dmt3l0FtHgnUN83s8Dp1BpjVXdAKhOT+n2qKstVg2TQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VdoOPPZAvqJPjeQvGKjU/kZIhJpXWGoE+PmXkPSd2cC8Oc4BR+zfluQJoQzg?=
 =?us-ascii?Q?GblZoNh2fR9GX/079rco+lUKFfEch6VCy2ptnLggEn9F/33pMFvssM1AiRWj?=
 =?us-ascii?Q?kgjtdjfUBB9ujWL8MJf0/olwaxpHtHcOtY9Tx4dKu1rGooSyCncwjc8nA9df?=
 =?us-ascii?Q?SFa90pjSvxzbh1ix6mszDVpSrxrfSIjInjMAFTfs8WFkr9cHiDBrTGdO5Kdo?=
 =?us-ascii?Q?OV/xAOOPxXEaqV3tNH5OlN9MFMIL0habS5AaQwY6dvX2vlPZDnxc7Q3tDAKW?=
 =?us-ascii?Q?PNZkP8ALVfpBBr8avBbS2CpYNirxE9h0ItqBMyyjHzoI3ASFvjQuw5kMAzlO?=
 =?us-ascii?Q?mPAgZQx8UljuWFdjBpaZr9l9RhhWas/wZ/aa+Suev6BRZ5dcpIUy8a0zklEL?=
 =?us-ascii?Q?Py5yd6fLXmh8dpu+iR5cU4AUjS17ZzMsEcvdqMnYtyLp3pW0VuPLwGj1CH2B?=
 =?us-ascii?Q?uyPCNihfGSgmnTP2/fJW36fgqL3ohfFUqfIXPSswP8mkhAX6KmxFntgdhKXm?=
 =?us-ascii?Q?T1mntzwILaB9CQao4gN9nVHN3fneu4c9FfItR3ZZWkxaj+d/WE4Uvnt4i/ZQ?=
 =?us-ascii?Q?eoCe8aXpFhRLqvj19OwDY/ADwQsAVY+ddh1Ebc7Bsz9hR7jQuVs7yIz15gXt?=
 =?us-ascii?Q?5jCxBz2Focius6K4IoXNRCEs+/oHcdg1epWf3BUAuX55V0dQuWz1sZCJkOR2?=
 =?us-ascii?Q?I7EfxN4T3OEwKayHDyMUWHYfidESiVREv5hYMYKbo1ufO7vwCJ40EmKM3BXD?=
 =?us-ascii?Q?cjH4lrgwKX4PqRWOhwML/gj008o+IxuVcqCMVjIDarHpZCAJ1M8WDjIW7g5e?=
 =?us-ascii?Q?n1zC1NQbQFChtLCy80ykc8bdpI6zcrDQotMIz+tbyUSw6EVMlyhiYj1wfBnJ?=
 =?us-ascii?Q?ATt3SwYNmBcIan7aqCkAWI6QzNNaALDk+MakwJkWkJRTuHNGfM8KWcptawz2?=
 =?us-ascii?Q?5hU6IP/r4uznHWsRRet1IfdTLMmPnheM1bLtG0xmxyQQwYzMOgrHUNzglUKb?=
 =?us-ascii?Q?UZcp4hGJfThTQZ2qSSMEh1wZHoP/kBExGjI3zmSXdqHtlFkTz92Sl/8AahOr?=
 =?us-ascii?Q?p8iS9oL4RENIyj8x506mrKwPmNfB0leCb57WiJ5rdzgibsm0c3ivX8kTAH5i?=
 =?us-ascii?Q?X+1kLwIKikQSr2F/OPr+vhpDuAx77uGXkSu0QCe7YNfuhfP28aRHvpKVVHI9?=
 =?us-ascii?Q?PN6qaUqNU+2kff988uDZH1J8GBjDnLJx4cyW6qAw2Xr5fchAw5Xaf7CFaTiB?=
 =?us-ascii?Q?gzJXsHtrVeln1oxmgMO5bNNLPNOBXnImo1NObOzWNgIzOtCFpCdTxsD1xKjH?=
 =?us-ascii?Q?kKjWk9umjVt1J/DXthwPG2Q8e5vy7y9Ty7cbSalSMOxgIkiJp+S258I0GAE1?=
 =?us-ascii?Q?fU30wAhbVhSVFG8Ezc/7ckeZNIw6cGhB8Lwoy3WGaoiHu01/3E/BXlbzC5jA?=
 =?us-ascii?Q?J9q1EjuSb2cNj4O/bax12X44865UsSbhXQVsGNyRkPlGPxW0XLkNT4xMnVE8?=
 =?us-ascii?Q?ytd3MPGEcT+yiBOtYavIV84dOpqUh0v9IUq7i1FsvuXSWt4cCBtq/BlIauZn?=
 =?us-ascii?Q?0zhOw9C2rC8uNWfhrxl4lsBXeIhqC6di5oc3Geea0uaeen6qJCNWAqrUVRFj?=
 =?us-ascii?Q?OsUNJeCiiPvpWFprVFQTpzuGcUDDzdQZMkM1cr1G27pdo+KHq9SH6cMHlsd3?=
 =?us-ascii?Q?OAAI5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XL7B0RxAPUai2ngEX0Lq/Y156r+HjBFGfQhY7bPlLMGe2xfi9t6ipbLLZoLza9FiIbSttViA4Vw9QwDcvmrwSrOIwVEY4T69Txj78mx8pgN8M8fD1/j7cAlIwQ/uZAqJbGys913ujiiM24Dn9G9vL169wbkTxYQMnZe5FF2aTeK31IodGq4M3qLJyag08E8vHalGgl/9Qisy50ROOttsdfjhYrbHKqWmnh+vTkzJ2knmoCZpTzBzTPxGGXQGcvmNzO7sm3smkkAEiksP3Ym6kfzN4oypQ7Thg8CQ5MVL74WH2ckgFdBqKq3euXC7FWe204X6OXNfJLo2R+zG2Q0faRR9ob3sov5mlDGgVtY9+rT4avVrSpxSrTMNSud96A/v9yMUENQiNL/5amsjMV2UNpe5JKY58rDGORs7SMIAz/AcKukmwTLZrK0ZV6MO24zsNVauURIrvsC5ObJ4iPkBItkq55H7wbKeSvTSBJ39cRhRFseLORZpTO4u70uRo/wg2p1a/m1jAnfY5jgfCEy5VKoDRqQwydncQjcZrAl8l/wPj2blRWbW0YvuO5flb1HLHHhWaRp9GyusIbHt/IWhEN4xYx1dSNzK0xD7yIq6ylM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28d68a4-e08a-4dbd-54f7-08dcb548233a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:14:21.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egEw34IgoPI+tPzL06bP39A975SqH+JUcnV5ct/5ot/qg2bEJSR89fpUAEX7KKCuZ0oM+eKdSim1SIcbkfQ2Ts2Fcm3ngwX+YcpBfNnjsio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6334
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_01,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050088
X-Proofpoint-ORIG-GUID: RqmQr-MSIXTZFaY511IoP4Wh8HgbH461
X-Proofpoint-GUID: RqmQr-MSIXTZFaY511IoP4Wh8HgbH461

Rather than passing around huge numbers of parameters to numerous helper
functions, abstract them into a single struct that we thread through the
operation.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c |  76 ++++++++------
 mm/vma.c  | 297 ++++++++++++++++++++++++++++++++++++++----------------
 mm/vma.h  |  92 ++++++++---------
 3 files changed, 294 insertions(+), 171 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4a9c2329b09a..f931000c561f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1369,9 +1369,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
-	pgoff_t vm_pgoff;
 	int error;
 	VMA_ITERATOR(vmi, mm, addr);
+	struct vma_merge_struct vmg = {
+		.vmi = &vmi,
+		.start = addr,
+		.end = end,
+		.flags = vm_flags,
+		.pgoff = pgoff,
+		.file = file,
+	};
 
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -1405,8 +1412,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	next = vma_next(&vmi);
-	prev = vma_prev(&vmi);
+	next = vmg.next = vma_next(&vmi);
+	prev = vmg.prev = vma_prev(&vmi);
 	if (vm_flags & VM_SPECIAL) {
 		if (prev)
 			vma_iter_next_range(&vmi);
@@ -1416,29 +1423,30 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Attempt to expand an old mapping */
 	/* Check next */
 	if (next && next->vm_start == end && !vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX, NULL)) {
+	    can_vma_merge_before(&vmg)) {
 		merge_end = next->vm_end;
 		vma = next;
-		vm_pgoff = next->vm_pgoff - pglen;
+		vmg.pgoff = next->vm_pgoff - pglen;
+	}
+
+	if (vma) {
+		vmg.anon_vma = vma->anon_vma;
+		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
 	}
 
 	/* Check prev */
 	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
-	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
-				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
-		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				       NULL_VM_UFFD_CTX, NULL))) {
+	    can_vma_merge_after(&vmg)) {
 		merge_start = prev->vm_start;
 		vma = prev;
-		vm_pgoff = prev->vm_pgoff;
+		vmg.pgoff = prev->vm_pgoff;
 	} else if (prev) {
 		vma_iter_next_range(&vmi);
 	}
 
 	/* Actually expand, if possible */
 	if (vma &&
-	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
+	    !vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
 		khugepaged_enter_vma(vma, vm_flags);
 		goto expanded;
 	}
@@ -1790,25 +1798,31 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Expand the existing vma if possible; Note that singular lists do not
 	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
-	    can_vma_merge_after(vma, flags, NULL, NULL,
-				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
-		vma_iter_config(vmi, vma->vm_start, addr + len);
-		if (vma_iter_prealloc(vmi, vma))
-			goto unacct_fail;
-
-		vma_start_write(vma);
-
-		init_vma_prep(&vp, vma);
-		vma_prepare(&vp);
-		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
-		vma->vm_end = addr + len;
-		vm_flags_set(vma, VM_SOFTDIRTY);
-		vma_iter_store(vmi, vma);
-
-		vma_complete(&vp, vmi, mm);
-		khugepaged_enter_vma(vma, flags);
-		goto out;
+	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
+		struct vma_merge_struct vmg = {
+			.prev = vma,
+			.flags = flags,
+			.pgoff = addr >> PAGE_SHIFT,
+		};
+
+		if (can_vma_merge_after(&vmg)) {
+			vma_iter_config(vmi, vma->vm_start, addr + len);
+			if (vma_iter_prealloc(vmi, vma))
+				goto unacct_fail;
+
+			vma_start_write(vma);
+
+			init_vma_prep(&vp, vma);
+			vma_prepare(&vp);
+			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
+			vma->vm_end = addr + len;
+			vm_flags_set(vma, VM_SOFTDIRTY);
+			vma_iter_store(vmi, vma);
+
+			vma_complete(&vp, vmi, mm);
+			khugepaged_enter_vma(vma, flags);
+			goto out;
+		}
 	}
 
 	if (vma)
diff --git a/mm/vma.c b/mm/vma.c
index bf0546fe6eab..20c4ce7712c0 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -7,16 +7,18 @@
 #include "vma_internal.h"
 #include "vma.h"
 
-/*
- * If the vma has a ->close operation then the driver probably needs to release
- * per-vma resources, so we don't attempt to merge those if the caller indicates
- * the current vma may be removed as part of the merge.
- */
-static inline bool is_mergeable_vma(struct vm_area_struct *vma,
-		struct file *file, unsigned long vm_flags,
-		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name, bool may_remove_vma)
+static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
 {
+	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
+	/*
+	 * If the vma has a ->close operation then the driver probably needs to
+	 * release per-vma resources, so we don't attempt to merge those if the
+	 * caller indicates the current vma may be removed as part of the merge,
+	 * which is the case if we are attempting to merge the next VMA into
+	 * this one.
+	 */
+	bool may_remove_vma = merge_next;
+
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
 	 * match the flags but dirty bit -- the caller should mark
@@ -25,15 +27,15 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
 	 * the kernel to generate new VMAs when old one could be
 	 * extended instead.
 	 */
-	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
+	if ((vma->vm_flags ^ vmg->flags) & ~VM_SOFTDIRTY)
 		return false;
-	if (vma->vm_file != file)
+	if (vma->vm_file != vmg->file)
 		return false;
 	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
 		return false;
-	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
+	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
 		return false;
-	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
+	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
 		return false;
 	return true;
 }
@@ -94,16 +96,16 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
  * We assume the vma may be removed as part of the merge.
  */
 bool
-can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
-		struct anon_vma *anon_vma, struct file *file,
-		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name)
+can_vma_merge_before(struct vma_merge_struct *vmg)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
-	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
-		if (vma->vm_pgoff == vm_pgoff)
+	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
+
+	if (is_mergeable_vma(vmg, true) &&
+	    is_mergeable_anon_vma(vmg->anon_vma, vmg->next->anon_vma, vmg->next)) {
+		if (vmg->next->vm_pgoff == vmg->pgoff + pglen)
 			return true;
 	}
+
 	return false;
 }
 
@@ -116,18 +118,11 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
  *
  * We assume that vma is not removed as part of the merge.
  */
-bool
-can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
-		struct anon_vma *anon_vma, struct file *file,
-		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name)
+bool can_vma_merge_after(struct vma_merge_struct *vmg)
 {
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
-	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
-		pgoff_t vm_pglen;
-
-		vm_pglen = vma_pages(vma);
-		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
+	if (is_mergeable_vma(vmg, false) &&
+	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
+		if (vmg->prev->vm_pgoff + vma_pages(vmg->prev) == vmg->pgoff)
 			return true;
 	}
 	return false;
@@ -180,7 +175,7 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
  * VMA Iterator will point to the end VMA.
  */
 static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		       unsigned long addr, int new_below)
+		       unsigned long addr, bool new_below)
 {
 	struct vma_prepare vp;
 	struct vm_area_struct *new;
@@ -261,13 +256,14 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * Split a vma into two pieces at address 'addr', a new vma is allocated
  * either for the first part or the tail.
  */
-static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		     unsigned long addr, int new_below)
+static int split_vma(struct vma_merge_struct *vmg, bool new_below)
 {
-	if (vma->vm_mm->map_count >= sysctl_max_map_count)
+	if (vmg->vma->vm_mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
-	return __split_vma(vmi, vma, addr, new_below);
+	return __split_vma(vmg->vmi, vmg->vma,
+			   new_below ? vmg->start : vmg->end,
+			   new_below);
 }
 
 /*
@@ -712,7 +708,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
-		error = __split_vma(vmi, vma, start, 1);
+		error = __split_vma(vmi, vma, start, true);
 		if (error)
 			goto start_split_failed;
 	}
@@ -725,7 +721,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	do {
 		/* Does it split the end? */
 		if (next->vm_end > end) {
-			error = __split_vma(vmi, next, end, 0);
+			error = __split_vma(vmi, next, end, false);
 			if (error)
 				goto end_split_failed;
 		}
@@ -934,16 +930,10 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
  * **** is not represented - it will be merged and the vma containing the
  *      area is returned, or the function will return NULL
  */
-static struct vm_area_struct
-*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
-	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
-	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
-	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-	   struct anon_vma_name *anon_name)
+static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
 {
-	struct mm_struct *mm = src->vm_mm;
-	struct anon_vma *anon_vma = src->anon_vma;
-	struct file *file = src->vm_file;
+	struct mm_struct *mm = container_of(vmg->vmi->mas.tree, struct mm_struct, mm_mt);
+	struct vm_area_struct *prev = vmg->prev;
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
 	struct vm_area_struct *anon_dup = NULL;
@@ -953,16 +943,18 @@ static struct vm_area_struct
 	bool merge_prev = false;
 	bool merge_next = false;
 	bool vma_expanded = false;
+	unsigned long addr = vmg->start;
+	unsigned long end = vmg->end;
 	unsigned long vma_start = addr;
 	unsigned long vma_end = end;
-	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
+	pgoff_t pglen = PHYS_PFN(end - addr);
 	long adj_start = 0;
 
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
 	 */
-	if (vm_flags & VM_SPECIAL)
+	if (vmg->flags & VM_SPECIAL)
 		return NULL;
 
 	/* Does the input range span an existing VMA? (cases 5 - 8) */
@@ -970,27 +962,26 @@ static struct vm_area_struct
 
 	if (!curr ||			/* cases 1 - 4 */
 	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
-		next = vma_lookup(mm, end);
+		next = vmg->next = vma_lookup(mm, end);
 	else
-		next = NULL;		/* case 5 */
+		next = vmg->next = NULL;	/* case 5 */
 
 	if (prev) {
 		vma_start = prev->vm_start;
 		vma_pgoff = prev->vm_pgoff;
 
 		/* Can we merge the predecessor? */
-		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
-		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
-					   pgoff, vm_userfaultfd_ctx, anon_name)) {
+		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), vmg->policy)
+		    && can_vma_merge_after(vmg)) {
+
 			merge_prev = true;
-			vma_prev(vmi);
+			vma_prev(vmg->vmi);
 		}
 	}
 
 	/* Can we merge the successor? */
-	if (next && mpol_equal(policy, vma_policy(next)) &&
-	    can_vma_merge_before(next, vm_flags, anon_vma, file, pgoff+pglen,
-				 vm_userfaultfd_ctx, anon_name)) {
+	if (next && mpol_equal(vmg->policy, vma_policy(next)) &&
+	    can_vma_merge_before(vmg)) {
 		merge_next = true;
 	}
 
@@ -1041,7 +1032,7 @@ static struct vm_area_struct
 				remove = curr;
 			} else {			/* case 5 */
 				adjust = curr;
-				adj_start = (end - curr->vm_start);
+				adj_start = end - curr->vm_start;
 			}
 			if (!err)
 				err = dup_anon_vma(prev, curr, &anon_dup);
@@ -1081,13 +1072,13 @@ static struct vm_area_struct
 		vma_expanded = true;
 
 	if (vma_expanded) {
-		vma_iter_config(vmi, vma_start, vma_end);
+		vma_iter_config(vmg->vmi, vma_start, vma_end);
 	} else {
-		vma_iter_config(vmi, adjust->vm_start + adj_start,
+		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
 				adjust->vm_end);
 	}
 
-	if (vma_iter_prealloc(vmi, vma))
+	if (vma_iter_prealloc(vmg->vmi, vma))
 		goto prealloc_fail;
 
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
@@ -1099,19 +1090,19 @@ static struct vm_area_struct
 	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
 
 	if (vma_expanded)
-		vma_iter_store(vmi, vma);
+		vma_iter_store(vmg->vmi, vma);
 
 	if (adj_start) {
 		adjust->vm_start += adj_start;
 		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
 		if (adj_start < 0) {
 			WARN_ON(vma_expanded);
-			vma_iter_store(vmi, next);
+			vma_iter_store(vmg->vmi, next);
 		}
 	}
 
-	vma_complete(&vp, vmi, mm);
-	khugepaged_enter_vma(res, vm_flags);
+	vma_complete(&vp, vmg->vmi, mm);
+	khugepaged_enter_vma(res, vmg->flags);
 	return res;
 
 prealloc_fail:
@@ -1119,8 +1110,8 @@ static struct vm_area_struct
 		unlink_anon_vmas(anon_dup);
 
 anon_vma_fail:
-	vma_iter_set(vmi, addr);
-	vma_iter_load(vmi);
+	vma_iter_set(vmg->vmi, addr);
+	vma_iter_load(vmg->vmi);
 	return NULL;
 }
 
@@ -1137,38 +1128,141 @@ static struct vm_area_struct
  * The function returns either the merged VMA, the original VMA if a split was
  * required instead, or an error if the split failed.
  */
-struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
-				  struct vm_area_struct *prev,
-				  struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  unsigned long vm_flags,
-				  struct mempolicy *policy,
-				  struct vm_userfaultfd_ctx uffd_ctx,
-				  struct anon_vma_name *anon_name)
+static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 {
-	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
+	struct vm_area_struct *vma = vmg->vma;
 	struct vm_area_struct *merged;
 
-	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
-			   pgoff, policy, uffd_ctx, anon_name);
+	/* First, try to merge. */
+	merged = vma_merge(vmg);
 	if (merged)
 		return merged;
 
-	if (vma->vm_start < start) {
-		int err = split_vma(vmi, vma, start, 1);
+	/* Split any preceding portion of the VMA. */
+	if (vma->vm_start < vmg->start) {
+		int err = split_vma(vmg, true);
 
 		if (err)
 			return ERR_PTR(err);
 	}
 
-	if (vma->vm_end > end) {
-		int err = split_vma(vmi, vma, end, 0);
+	/* Split any trailing portion of the VMA. */
+	if (vma->vm_end > vmg->end) {
+		int err = split_vma(vmg, false);
 
 		if (err)
 			return ERR_PTR(err);
 	}
 
-	return vma;
+	return vmg->vma;
+}
+
+/* Assumes addr >= vma->vm_start. */
+static pgoff_t vma_pgoff_offset(struct vm_area_struct *vma, unsigned long addr)
+{
+	return vma->vm_pgoff + PHYS_PFN(addr - vma->vm_start);
+}
+
+struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
+					struct vm_area_struct *prev,
+					struct vm_area_struct *vma,
+					unsigned long start, unsigned long end,
+					unsigned long new_flags)
+{
+	struct vma_merge_struct vmg = {
+		.vmi = vmi,
+		.prev = prev,
+		.vma = vma,
+		.start = start,
+		.end = end,
+		.flags = new_flags,
+		.pgoff = vma_pgoff_offset(vma, start),
+		.file = vma->vm_file,
+		.anon_vma = vma->anon_vma,
+		.policy = vma_policy(vma),
+		.uffd_ctx = vma->vm_userfaultfd_ctx,
+		.anon_name = anon_vma_name(vma),
+	};
+
+	return vma_modify(&vmg);
+}
+
+struct vm_area_struct
+*vma_modify_flags_name(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start,
+		       unsigned long end,
+		       unsigned long new_flags,
+		       struct anon_vma_name *new_name)
+{
+	struct vma_merge_struct vmg = {
+		.vmi = vmi,
+		.prev = prev,
+		.vma = vma,
+		.start = start,
+		.end = end,
+		.flags = new_flags,
+		.pgoff = vma_pgoff_offset(vma, start),
+		.file = vma->vm_file,
+		.anon_vma = vma->anon_vma,
+		.policy = vma_policy(vma),
+		.uffd_ctx = vma->vm_userfaultfd_ctx,
+		.anon_name = new_name,
+	};
+
+	return vma_modify(&vmg);
+}
+
+struct vm_area_struct
+*vma_modify_policy(struct vma_iterator *vmi,
+		   struct vm_area_struct *prev,
+		   struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   struct mempolicy *new_pol)
+{
+	struct vma_merge_struct vmg = {
+		.vmi = vmi,
+		.prev = prev,
+		.vma = vma,
+		.start = start,
+		.end = end,
+		.flags = vma->vm_flags,
+		.pgoff = vma_pgoff_offset(vma, start),
+		.file = vma->vm_file,
+		.anon_vma = vma->anon_vma,
+		.policy = new_pol,
+		.uffd_ctx = vma->vm_userfaultfd_ctx,
+		.anon_name = anon_vma_name(vma),
+	};
+
+	return vma_modify(&vmg);
+}
+
+struct vm_area_struct
+*vma_modify_flags_uffd(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end,
+		       unsigned long new_flags,
+		       struct vm_userfaultfd_ctx new_ctx)
+{
+	struct vma_merge_struct vmg = {
+		.vmi = vmi,
+		.prev = prev,
+		.vma = vma,
+		.start = start,
+		.end = end,
+		.flags = new_flags,
+		.file = vma->vm_file,
+		.anon_vma = vma->anon_vma,
+		.pgoff = vma_pgoff_offset(vma, start),
+		.policy = vma_policy(vma),
+		.uffd_ctx = new_ctx,
+		.anon_name = anon_vma_name(vma),
+	};
+
+	return vma_modify(&vmg);
 }
 
 /*
@@ -1180,8 +1274,22 @@ struct vm_area_struct
 		   struct vm_area_struct *vma, unsigned long start,
 		   unsigned long end, pgoff_t pgoff)
 {
-	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
-			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	struct vma_merge_struct vmg = {
+		.vmi = vmi,
+		.prev = prev,
+		.vma = vma,
+		.start = start,
+		.end = end,
+		.flags = vma->vm_flags,
+		.file = vma->vm_file,
+		.anon_vma = vma->anon_vma,
+		.pgoff = pgoff,
+		.policy = vma_policy(vma),
+		.uffd_ctx = vma->vm_userfaultfd_ctx,
+		.anon_name = anon_vma_name(vma),
+	};
+
+	return vma_merge(&vmg);
 }
 
 /*
@@ -1193,11 +1301,22 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					unsigned long delta)
 {
 	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
+	struct vma_merge_struct vmg = {
+		.vmi = vmi,
+		.prev = vma,
+		.vma = vma,
+		.start = vma->vm_end,
+		.end = vma->vm_end + delta,
+		.flags = vma->vm_flags,
+		.file = vma->vm_file,
+		.pgoff = pgoff,
+		.policy = vma_policy(vma),
+		.uffd_ctx = vma->vm_userfaultfd_ctx,
+		.anon_name = anon_vma_name(vma),
+	};
 
 	/* vma is specified as prev, so case 1 or 2 will apply. */
-	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
-			 vma->vm_flags, pgoff, vma_policy(vma),
-			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	return vma_merge(&vmg);
 }
 
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
diff --git a/mm/vma.h b/mm/vma.h
index 6efdf1768a0a..c31684cc1da6 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -26,6 +26,23 @@ struct unlink_vma_file_batch {
 	struct vm_area_struct *vmas[8];
 };
 
+/* Represents a VMA merge operation. */
+struct vma_merge_struct {
+	struct vma_iterator *vmi;
+	struct vm_area_struct *prev;
+	struct vm_area_struct *next; /* Modified by vma_merge(). */
+	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
+	unsigned long start;
+	unsigned long end;
+	unsigned long flags;
+	pgoff_t pgoff;
+	struct file *file;
+	struct anon_vma *anon_vma;
+	struct mempolicy *policy;
+	struct vm_userfaultfd_ctx uffd_ctx;
+	struct anon_vma_name *anon_name;
+};
+
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
 void validate_mm(struct mm_struct *mm);
 #else
@@ -72,80 +89,53 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 		struct vm_area_struct *next, unsigned long start,
 		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
 
-/* Required by mmap_region(). */
-bool
-can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
-		struct anon_vma *anon_vma, struct file *file,
-		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name);
-
-/* Required by mmap_region() and do_brk_flags(). */
-bool
-can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
-		struct anon_vma *anon_vma, struct file *file,
-		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name);
-
-struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
-				  struct vm_area_struct *prev,
-				  struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  unsigned long vm_flags,
-				  struct mempolicy *policy,
-				  struct vm_userfaultfd_ctx uffd_ctx,
-				  struct anon_vma_name *anon_name);
+/*
+ * Can we merge the VMA described by vmg into the following VMA vmg->next?
+ *
+ * Required by mmap_region().
+ */
+bool can_vma_merge_before(struct vma_merge_struct *vmg);
+
+/*
+ * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
+ *
+ * Required by mmap_region() and do_brk_flags().
+ */
+bool can_vma_merge_after(struct vma_merge_struct *vmg);
 
 /* We are about to modify the VMA's flags. */
-static inline struct vm_area_struct
-*vma_modify_flags(struct vma_iterator *vmi,
-		  struct vm_area_struct *prev,
-		  struct vm_area_struct *vma,
-		  unsigned long start, unsigned long end,
-		  unsigned long new_flags)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx,
-			  anon_vma_name(vma));
-}
+struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
+					struct vm_area_struct *prev,
+					struct vm_area_struct *vma,
+					unsigned long start, unsigned long end,
+					unsigned long new_flags);
 
 /* We are about to modify the VMA's flags and/or anon_name. */
-static inline struct vm_area_struct
+struct vm_area_struct
 *vma_modify_flags_name(struct vma_iterator *vmi,
 		       struct vm_area_struct *prev,
 		       struct vm_area_struct *vma,
 		       unsigned long start,
 		       unsigned long end,
 		       unsigned long new_flags,
-		       struct anon_vma_name *new_name)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
-}
+		       struct anon_vma_name *new_name);
 
 /* We are about to modify the VMA's memory policy. */
-static inline struct vm_area_struct
+struct vm_area_struct
 *vma_modify_policy(struct vma_iterator *vmi,
 		   struct vm_area_struct *prev,
 		   struct vm_area_struct *vma,
 		   unsigned long start, unsigned long end,
-		   struct mempolicy *new_pol)
-{
-	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
-			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-}
+		   struct mempolicy *new_pol);
 
 /* We are about to modify the VMA's flags and/or uffd context. */
-static inline struct vm_area_struct
+struct vm_area_struct
 *vma_modify_flags_uffd(struct vma_iterator *vmi,
 		       struct vm_area_struct *prev,
 		       struct vm_area_struct *vma,
 		       unsigned long start, unsigned long end,
 		       unsigned long new_flags,
-		       struct vm_userfaultfd_ctx new_ctx)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), new_ctx, anon_vma_name(vma));
-}
+		       struct vm_userfaultfd_ctx new_ctx);
 
 struct vm_area_struct
 *vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
-- 
2.45.2


