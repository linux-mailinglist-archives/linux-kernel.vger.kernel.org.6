Return-Path: <linux-kernel+bounces-427494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615829E0216
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CF81692B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD341FDE2B;
	Mon,  2 Dec 2024 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eT/jd/OL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qEifWdth"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072411F9EBF
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142112; cv=fail; b=uqRx8Fzj5fMEp79Jn4TjLyyfjWvtTdAlPOqmI4h+HO3JLVB+4CTTQyXySVdgXAuKk30ByDjcTAZ+e6ET/0dwS/HudWXg/NcqApZGUlS5f/31bxdsDI9YmJqoh5XXJxHhPCIi2W8f0USLdMHaSMekrTYo99n+byihZ/cweLSBoOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142112; c=relaxed/simple;
	bh=gXR7v2NjwKvgIkucO5KU47btdOYhbN8/LpTcD1xPpSo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dGuXFqj8lc4JkIfmH611jOcIRBo9LnpHQUY/FQWdkpaIcKqQBy82sqY0taMuvZTbq8B1gFryht3QFnyrV/U+Pao9nK9NWvAvkKcnNVfDRCCqBSUOQe9KwAzgaompfX+fQJswMm3XPJpk3hTegND7aVAFgG3xkXZ1qYqfKb4iFcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eT/jd/OL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qEifWdth; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26WvhV006638;
	Mon, 2 Dec 2024 12:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=Ojgqet0VMPf6eEmb
	Xccry7TfSco0Az1bwC5y8FmNEVg=; b=eT/jd/OLg1xq4tTOmIcHi3EsgDEVWTUh
	q/wz2GClHvkkxtbPtU2h9YyqfOI0+Vc7MUY0elWD40fkutcW8qnbg6swJYG988NG
	EWlNFRI9SXu0VifYzEPiTm8i9ic3HdvX5XhROrfgo4ryyNoE4RFh73vJe5mAgW4C
	5+Y1P0XqrVeyIxLFTI9fNCk0Jc35nujqQXcY8CocbLjM5MrbpSUqfsraRet4xxNH
	ymarfe45IHDa2dfYesXgCaO5qLDCCwkbVc+E9+4TnXpza+PiVVKHOaevh1tN0l88
	LfkU+7PlWYF41rkueTbMoH9EGUd/y24OVVCwyoTgB4vVIBU24e6+WQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tas2vfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 12:21:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2C2cqr032113;
	Mon, 2 Dec 2024 12:21:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s56gwq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 12:21:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7jsgmVq/10V+sZCDvltnRTjVTuR1m0hDA6iynCoECnvv76y6uTnWJpapT8xmXSMaJbBDtytg/q8/2w0aPQGcsN9kX+HP5c3uNHZLipHmLpj/pY78qW2HgO0wEOk3fuHtj/BPbP4SjBwK3qL0h8qAaZU153+7FX+FYgG+NQAuqgpFQGp1hSxR772U9IvapvRaL6wlMo42Wsk9CBYtnbs6iSHc5JhU1fc4C0Zg2BX1pUBDc6Gp/a561To4IapNUMYFf4KIHNXrXWQGcrHran8iN1n0QJJ80jfYISP8afpxX37SglTgg30yC9UHGmBD9wICOLzlQz+V3MVZxQAawmZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ojgqet0VMPf6eEmbXccry7TfSco0Az1bwC5y8FmNEVg=;
 b=pmwIjZUc8CXBrbdgUcDy6bWzc8HLGVFpnp4LNn7Cyekjxwj2uzDpDptML18LfdZp1uAezZMwN3gK6H0ftC1YiCGr/PCijWOL5rBcBIkR+LmRcdp+wlMj+jeasvi7BQKkJSwJEAD68igt46ydNvm0S0kFFZUOie1V40Y77dvq9Cz9cgAa7VOGQZiqqTRcnUCOqUsNRjwEnn5Iny5nARwGrYEp2SMNIrILhTQKq777T2CAwRG/9URrQlv5SeH4RtWLdePST/8K3l+JUfnSkzpLUPFwLhjM5XdFS8HcexHnGj5hbkhrePGc3Cp6xlXt1mLFYNP3pWP07BFRRZdaSyiAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ojgqet0VMPf6eEmbXccry7TfSco0Az1bwC5y8FmNEVg=;
 b=qEifWdthTPPam9XiiBUZm+l8s1LDT8aW3ar2dTkBCMqahWwV61UU16bMDKfkdOBNlzEmWFB0u/6t0exW2bsjGTjKv+/TnVmWXtJ/J8qFVw3HrHeBSMGen9Z3g5y6HTX0toydv0w5Gtg9E/JXai3CMyhWh/OKK5oSb3xlLTMXffI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW5PR10MB5740.namprd10.prod.outlook.com (2603:10b6:303:19a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 12:21:33 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 12:21:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH] intel_th: avoid using deprecated page->mapping, index fields
Date: Mon,  2 Dec 2024 12:21:27 +0000
Message-ID: <20241202122127.51313-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0643.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW5PR10MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: f6eed542-f82a-4581-cd55-08dd12cbdbe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fOF9Sh7Lv7UZt1VA30+4Dv7OVib5ZGuSFr+1kDdOvcA0oaOeOAcWCyXU5dvA?=
 =?us-ascii?Q?562k1Dv4F8RlxvDdlM89Mo+vgUSTDIbKjMDfy6TtYiJxVUfa6vHt7omagh5g?=
 =?us-ascii?Q?dZDr8uICBlSBHADcUpAl2yQv7RF89K7nylRi8UYPR9/Bwc1nf44n6S69rmHi?=
 =?us-ascii?Q?Tokc694NEuk3h4n+VhPe7UHLINp0/gVBijcz2gQY8np/P+EfxZ84DTeBh1+T?=
 =?us-ascii?Q?GvCy2Yvd2a0L75BF0mKXfFIP9FBbKUVtt6Vt99z/ROJzepGo7kdrn8kjU1s4?=
 =?us-ascii?Q?2rFWSwFltVhlr1X5uL/GIWM4DVhvEth6GJsGxKiZ9Sv96j+7BWjWE8NxLnST?=
 =?us-ascii?Q?QQlZCNuegfEivn3I/UdjE8jhLsJPJt0BBc8FGcLCSHw38jXbqzM0E4sqStrd?=
 =?us-ascii?Q?OSHkRub1Z5XlByhIawaZW5DBWPUqAq01zqxEH6jjZRAfo5oUyjCiBo0Hu2Yv?=
 =?us-ascii?Q?Ah7o+0We2NYvN9GRqqoTLXgtqsGIUCV//DhjeBYGSQgAnogkdssucuRGZNPg?=
 =?us-ascii?Q?Wjtz30PLE4fgERZSiiWNpQhF7aE0agQHpjj0KZlQPetDj0tw8R/d5IgkvMoi?=
 =?us-ascii?Q?aGJwFHnAblwXSwJxIF2v6dPdCOqjbBD1t31gGhl5xk9icXEjteNC6yQtUym8?=
 =?us-ascii?Q?uvj9ilCLylKwcSobn1NsOeLE+mr5Ry6ESsSbfPnA2xA+d8iH6F/DNW4rCWSL?=
 =?us-ascii?Q?y0UsWoT7IQv82RCpi5IlNybkkr7+d6mAZhg8qNfR00EPVWK7EhUEqxbWR17p?=
 =?us-ascii?Q?q1Ur0nk9s69+zcthfmWFOP7zGDIoL/GKTjqg0lDZLBHhn61zUGN+jJbMYf7W?=
 =?us-ascii?Q?yTD2Dc0J+u2wMFUZjIEA9c+XOIvDrSoLpxV6hokrX1BcjVzNH6+bhlbk0p+V?=
 =?us-ascii?Q?oQVPv2ow3tpkVkwbNe4sOJ/OKtQTqDu5WrqCHCtAo6v8gS0hOILdf9KVDHxd?=
 =?us-ascii?Q?3urmPdpzI4qgUS5l3RXc4Fz/Gy8nNYrmSoUdfDNK6XpM+8boeHwyrSm3W40H?=
 =?us-ascii?Q?DhP20yy4zq57w3mZ/Uk7PxoP6fpkLaQNIZrj3OL9p2VzLFsTe1Y8IbiYG84f?=
 =?us-ascii?Q?Tr4hgU77lQ605Ee0ZDePaKeUEn42FlWxCVsUHkX9WR4/RpVa477L9r4C3KtR?=
 =?us-ascii?Q?iYp0cSmC/nX+TgOiW9zmzAREBtwGmIWKftX/hAd1VXFJplURIwlloILK5dkS?=
 =?us-ascii?Q?yFvVO86d0DJnoSB4+XqEeSb5sV6vs3psTm5blTc9ccQlQOp/ynVgeBmEfs9K?=
 =?us-ascii?Q?SLyvd4fokCTavPIgeCmGQXUEQEt6/tm6nCqX+g1QgnrD1/gYgmQPHILlSatY?=
 =?us-ascii?Q?pXyS2mmI25pdW7c4SIqeSJ3voZcrnNSIVHmGIgMWCaPrHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lyLVCqPRILwI2xkrpxEK93nRhQJpSkdDfbshL+zkF+YMcAev7U2twlX4ROqU?=
 =?us-ascii?Q?RCprGte7wW+F1qceQrrfhis1IsTQHPe6SBw18k8C4fwakksyykqCuOqTjFrA?=
 =?us-ascii?Q?RhpcvtJ+FtgKerUbKHKRjt2Gunmnlson3MbvTn9C65hD79104cMxS4FsnGEz?=
 =?us-ascii?Q?zkw4d1PaZsADnMvlRgUOtQI5BoEl91cUZbQL+R6zhBrgkzTzVdzPw4v6ya5B?=
 =?us-ascii?Q?EZI6wkcokdGiO3Hn+ar/G2RWNtlNWYfsmikPLHzlYdTAVE5i8EAqoVHNjIJU?=
 =?us-ascii?Q?KY5OUFexRclA+xienZnYgfXJjS80n57WZEr5b0hTBDJ68Gnje6mIfpZrX9lB?=
 =?us-ascii?Q?YzKGXcnbb0xzOxh4jt5G+JjkCjEvoezl3oxpCdKD3Wzhx89BFJwqEwGAMofS?=
 =?us-ascii?Q?Q2y7WfkNGMspIOn7NZ1cFWjh/ANvKTJZNLsfw7P7SVwbMkcoPEzcswOPcL+B?=
 =?us-ascii?Q?jN0cHlWsSHs9luxdufQ/nqiKXkvQCEp6hN4cV9QIlK6O9NXrXF7ItDoA7SFM?=
 =?us-ascii?Q?giEgwpb3B+oH3lsZPZyjxZbGDj/EpvpHVpP0+RYC3msAjZTI4PqPeLwEeIu9?=
 =?us-ascii?Q?RWYUYZRXG/Y6E1JC8VCUVdIM+ZlXPOd/ZlIzXnje7qOnxYwmVEhz65P0B6vY?=
 =?us-ascii?Q?eVPMh0lH/Mfy8Dw1Q3GqaKGPOoSXuEIn2KibGyiwOAmZ5HqIQER4FEB5ymLD?=
 =?us-ascii?Q?07wUUKvwLSj1PZm6vhR9t+6qYpk/+A2NbA41Y/orm6ImRjkLORKKHXndMS+K?=
 =?us-ascii?Q?qcJr1/Vn6WXCNTQ1wpwpxdOmr8d79H9YPP6uzOvf2hXz0Gb6Oc4ysHbrtc4+?=
 =?us-ascii?Q?K3gfxQ3Sa+1KUhTvIOp1p35vrZ7BGqCQrVU+DpHyf9azcxLw9/66LOx8HSg4?=
 =?us-ascii?Q?yRQZmchsxgweurbxEReke1QbdlUlh0JivHs+oaExSHzYKmvi4afURl42pEOy?=
 =?us-ascii?Q?aoIatZm6n99Hlf46wUAHQBbojj8LJRoEJhDGSoM46cs4/oRL4wPtwltwYTZe?=
 =?us-ascii?Q?049ttggNgNfag02khKDr3/wtol181lOsYWH+YgkqVUmLghnXbQ+GfKoBp4Dh?=
 =?us-ascii?Q?U1HifdVN0V5jSEfbo6pGJydO2VMznwDqjuOUU9qzAOh2rPas9MNo46BBQZIq?=
 =?us-ascii?Q?N7qb3B71I6lNbGPzY9wwp4qspFLMlir4XKi8f3u07Ot2BACUEfM3YA+OQwwR?=
 =?us-ascii?Q?19Xp2pboQdn0/FDNzkK5GQiHf2FVxxDJf0LKJT3NOM1uSZMCG3aXWzwSa5xi?=
 =?us-ascii?Q?BkgOKT4aVTnEHxsXb4KF0lBaSTL8XRm9nxYdnf6NHivDz0Tt42Gb4IBrDTta?=
 =?us-ascii?Q?m+73R8dpx3x/6E4w0ZaWf2wMLmvkvFZK2dNUrE+gQjxK8Bydy3pjgX/D70so?=
 =?us-ascii?Q?5S1y2KZHhxflYeiG1i8NSqA0ttxdIzUoQjMaM7q18Jr67S3gw7sO539lwAC3?=
 =?us-ascii?Q?/J5AGe4wp3JhhFSc38TuaZfMRw7L9sVfHI2KJqEBIG1LGTML/QjTmi/se/ff?=
 =?us-ascii?Q?J3CO7Ot/bdKdw61lTWKizMSUSo1tyxK9Df+TQxg4Cjitweie2mLugYPPWt+i?=
 =?us-ascii?Q?4Px0Ge5WHJBn8T+a62nFBe0kmbaEK8bOYcRq+SndZQ1j9sf2SchLZL4nrfUf?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Al+Fd1tRtJ2afpD7Iz2K+Pv+Rsem3DL/RhHajYdYTxn3+MpCWXaPL1y1891vdKStm+tP5VycujRz1Ocd3AMoLDJMu/Bl7/OQr7JXBupzSC79fjImhOW71237QyAzgGBnnufZsSOHHrbJrpryWUO7g7dzLXs/29QU4NnXaeh4dCSl4CalbaNhBKPT9H4K6c5rHxhbxdLLOP7B8Bdc5HbF8gd6h6Fi/2EjgILVGYZw84GIi9uih+gUDigtCXwq3eVadhUJ4zvIZVnni1h9f06PzldUeH6lwZ7bWynMeIKXkrUOOk7LHXZuue4ZHj2G1u0Xe7+7ss0reA9jtZXCGpu4sW9zLOcASDx9h/I88r9agQ/cYhwyLRZH5CsB/0Kr2BUW1nHT/UZYfq3EK/nPQScTOA8KUnxj32BRMTv5uKfgOcqiihnsXpr+mVSBZ1AQKB0LPWVhL2jScnq7rMDkZPGBcRA6cJbYS+YP6ifBEM7Ci8g1sZcEmE1UeiOq7+njGynSoDMduSOhO4bKfU9KMauEv4De5+PvGM7Cv2YmmHuQlZTb1bC9F4P63QZ3NUkMH1ulhK1+EaRWSe8pZhSCBZjSXyPPgCew68uwGs6DxFY3wO0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6eed542-f82a-4581-cd55-08dd12cbdbe3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 12:21:33.5827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URdBWVndBNyobHXUZmJSyIoQmcSWWw8PZi204IM82G0DLi880gRL+7RJRvWippM5a2mTn8EZ58SmR+2pFSZB3PKwmtuKNjIUA7dcgjZn7lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_08,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020108
X-Proofpoint-GUID: gdwSbxlm6JZbexl2HyRx32P8hk1eG7LO
X-Proofpoint-ORIG-GUID: gdwSbxlm6JZbexl2HyRx32P8hk1eG7LO

The struct page->mapping, index fields are deprecated and soon to be only
available as part of a folio.

It is likely the intel_th code which sets page->mapping, index is was
implemented out of concern that some aspect of the page fault logic may
encounter unexpected problems should they not.

However, the appropriate interface for inserting kernel-allocated memory is
vm_insert_page() in a VM_MIXEDMAP. By using the helper function
vmf_insert_mixed() we can do this with minimal churn in the existing fault
handler.

By doing so, we bypass the remainder of the faulting logic. The pages are
still pinned so there is no possibility of anything unexpected being done
with the pages once established.

It would also be reasonable to pre-map everything on fault, however to
minimise churn we retain the fault handler.

We also eliminate all code which clears page->mapping on teardown as this
has now become unnecessary.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 drivers/hwtracing/intel_th/msu.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 66123d684ac9..93b65a9731d7 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/workqueue.h>
 #include <linux/dma-mapping.h>
+#include <linux/pfn_t.h>

 #ifdef CONFIG_X86
 #include <asm/set_memory.h>
@@ -967,7 +968,6 @@ static void msc_buffer_contig_free(struct msc *msc)
 	for (off = 0; off < msc->nr_pages << PAGE_SHIFT; off += PAGE_SIZE) {
 		struct page *page = virt_to_page(msc->base + off);

-		page->mapping = NULL;
 		__free_page(page);
 	}

@@ -1149,9 +1149,6 @@ static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 	int i;

 	for_each_sg(win->sgt->sgl, sg, win->nr_segs, i) {
-		struct page *page = msc_sg_page(sg);
-
-		page->mapping = NULL;
 		dma_free_coherent(msc_dev(win->msc)->parent->parent, PAGE_SIZE,
 				  sg_virt(sg), sg_dma_address(sg));
 	}
@@ -1592,22 +1589,10 @@ static void msc_mmap_close(struct vm_area_struct *vma)
 {
 	struct msc_iter *iter = vma->vm_file->private_data;
 	struct msc *msc = iter->msc;
-	unsigned long pg;

 	if (!atomic_dec_and_mutex_lock(&msc->mmap_count, &msc->buf_mutex))
 		return;

-	/* drop page _refcounts */
-	for (pg = 0; pg < msc->nr_pages; pg++) {
-		struct page *page = msc_buffer_get_page(msc, pg);
-
-		if (WARN_ON_ONCE(!page))
-			continue;
-
-		if (page->mapping)
-			page->mapping = NULL;
-	}
-
 	/* last mapping -- drop user_count */
 	atomic_dec(&msc->user_count);
 	mutex_unlock(&msc->buf_mutex);
@@ -1617,16 +1602,14 @@ static vm_fault_t msc_mmap_fault(struct vm_fault *vmf)
 {
 	struct msc_iter *iter = vmf->vma->vm_file->private_data;
 	struct msc *msc = iter->msc;
+	struct page *page;

-	vmf->page = msc_buffer_get_page(msc, vmf->pgoff);
-	if (!vmf->page)
+	page = msc_buffer_get_page(msc, vmf->pgoff);
+	if (!page)
 		return VM_FAULT_SIGBUS;

-	get_page(vmf->page);
-	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
-	vmf->page->index = vmf->pgoff;
-
-	return 0;
+	get_page(page);
+	return vmf_insert_mixed(vmf->vma, vmf->address, page_to_pfn_t(page));
 }

 static const struct vm_operations_struct msc_mmap_ops = {
@@ -1667,7 +1650,7 @@ static int intel_th_msc_mmap(struct file *file, struct vm_area_struct *vma)
 		atomic_dec(&msc->user_count);

 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY | VM_MIXEDMAP);
 	vma->vm_ops = &msc_mmap_ops;
 	return ret;
 }
--
2.47.1

