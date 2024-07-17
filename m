Return-Path: <linux-kernel+bounces-255633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D6A934304
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80EDBB22B74
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5059F194096;
	Wed, 17 Jul 2024 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OlqCdy9t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sfmag6f2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B18219308C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246899; cv=fail; b=InrRX7mOx1PlwDNLCRz6deNOMr0WppTwIj7JLta/donW3Sux4QwdcmFh1cfSF/DZ1SbmnNKOgBWUCev/DWDkgFdevnmQgRBEpwFvQj8W1VvGhXGDX/K+cju2tUSIh//sw2uqYHE/oWdGy7ICrqv6y+P3bcfCFqtQRmumRq9KOpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246899; c=relaxed/simple;
	bh=d4BvSrgcy6B1x8UykGR5Y8x9YIxqnUZeOk1c7Ub74b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oQpb4TkwdRNiNZe5Hyo6qolSyX5dDA9p9twDQLdXc6DmRRWEYbM12vEKKziBaur5qyFw2uYKXCNiVLwkYkairqRcKZFk1gpn5uplwH0RmTvjjIU52sYxq+ea7pkZXVFUqUNMaA+Cs8y3RPPtg+ZVAudv7GBrLwdSXSb8UTVjyCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OlqCdy9t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sfmag6f2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HK54Y9023261;
	Wed, 17 Jul 2024 20:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=0FDbMHu5kyYedV4+qkYoUE3hPMV5ccTD7+pKpKjplPU=; b=
	OlqCdy9tdyXgj9G9cpmK/2j+F6G+Dqe6gO06VYJ/eokeKqxMqujBvAp2aMxXY5Zc
	aF4x9r8XKgpDvlKI37Krj5XJywdEGp6Mmc1nDybUQLuH7jHqjz1NmoZ9m44BBK1Q
	xjMtXyfBW6nQj3UzeagbN3jGuwRethaT3C2ggRuDYnPm2xBaI9OhG6NvYPGG3r42
	YDwWD3JFxQNzr6OYEGudYov3mT4VyErf13BPVuvjHCXmXiO6vkM8g4QbLH5qHpNa
	4ocNkDzAZTbKtIYdb3lMd3cjSKMK1jtkhf84Jf13yXjQncPD2KiF2LEXe9hhkp96
	Rie4iCw/WDdcLdJj/Emz0w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emp5008p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:08:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HJ2qIT038872;
	Wed, 17 Jul 2024 20:08:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwevgjqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:08:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjylnEV0Aq/gJQsQ/uLvKBLOvCnW/2z99r/BjRExPVVJFasPhF4vfkz6k7q46XniNLZg6BkLFN3TS4W7zxt9HLcMoWNJqMc3f0ZE4H5Anjk5662+XczJ/1mmtilv25Njx99TK5zihOMVJ1DDK9RRXY+2hR1XpK7kLbHe2yX+iXzqa60baXrq4Nuz2S/WSsWBoP/icChnhyWCLX0Ui7dVArxw8InWan/qonIpaBjFeVNIde4gxcIVUxtGNqgxmnNPqZ8exLV44uvBx3+oqybYpx+Q8c4/krXszxr5vI0TcLzNd1z9GI1QxIt5V5KmXY7Vzk5VOSYqX3fzHvYSFNPwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FDbMHu5kyYedV4+qkYoUE3hPMV5ccTD7+pKpKjplPU=;
 b=QoNwtJnzNk2Bmlp1FnhX/+rqD40mr/g29EWuRRdfJ4/aVOoICPrimdkzPjAR0AgJ0ztCpFRoEAqUoF0I0VbNsSMgDFCr4deLgHVsQBis4dQFnzUStncGBpMEweozT7lS2mhfaiiWTyYMaNVNf/BIDOMoTq42anXSkiDJcuq7SCMkdnuMq6I+Y69T5DElQXc4Z0HCD/50/QZEWE9ULNSbk4pn3n58gddvUjjs8d7VVu/Xa4IkP7J9DhvSMRSUGSIyBNI5g1k9JwvFuD69RN4rCJ68Dcy8AQOkXBPglcgqdNqM7uivYQ6r4CJuZN39wiWqgAefbYDl9f5qcrnlCIVDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FDbMHu5kyYedV4+qkYoUE3hPMV5ccTD7+pKpKjplPU=;
 b=Sfmag6f2OwxphZhJWrtvY86OimBkICphB/PyHE6BZgpUUZGV2zRfem+/fsK8OndXJ7U2SX59bcEGt+GReoXhdRCAKOf8KoQ22xMfysyoHBx0kClvnC3d8ACTWYH34HK4rZvvzV/sza36W1xRgMLurb8HpJQkRHHvTVgNLFQu7ac=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB7694.namprd10.prod.outlook.com (2603:10b6:510:2e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Wed, 17 Jul
 2024 20:07:59 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:59 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 21/21] mm/mmap: Drop incorrect comment from vms_gather_munmap_vmas()
Date: Wed, 17 Jul 2024 16:07:09 -0400
Message-ID: <20240717200709.1552558-22-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fbd985-9b02-436a-37a6-08dca69c27d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mntBeOd/xwEyv98d/LFYJftjVGJrNVbRbk3hbK6Tpw+lB30iXQ7I03I32UZ7?=
 =?us-ascii?Q?yTxGFbBHG5e8udD2CWskat9ZqQBoacy3zn0ie55GyIbQE1R7FUnra34wJ13g?=
 =?us-ascii?Q?ZQm+6hErbyc694cQ2UCenUux6CzuOCvhX3xrzDYS+x160GiTnN7hqC/b0Spe?=
 =?us-ascii?Q?sItE9i5YcYWSQvpYHXE2Hw+H6x/ELbjJwPl0kPpZlXJee3jhF8wV1gU/GVlP?=
 =?us-ascii?Q?uwPaaRjRQKBe3iBkzsS+8JC+vT72rX1r2VQ1tzSbo0Z5vxhNG5rk58huUlum?=
 =?us-ascii?Q?3CjxWDTs6mfmN7tu+cgRh601PYo40WYjLToJiFbOQSGys59aVIpVtRCEgisp?=
 =?us-ascii?Q?PuJzlq+QCcUAshbQo8PuyYUenPKPFOMgWyM1lLRzns5JPBWur3RcB4bZEm49?=
 =?us-ascii?Q?rw714WcPQVzv3XUrgP3BNAw1SNZ86w7HVD5ASlZ5EcNuANUE2S7kY2DZiiY7?=
 =?us-ascii?Q?gdc5T431MIvTfX4M1bXubI+d5aT5jIKOqQi7IcvqEEKPYqlZeD1UBoadTaVO?=
 =?us-ascii?Q?ZAfAODUopYIPiF4EQRKLubUeTQoDI0g9yRi9/scblpjZ/xTUor3I8r4Tsls5?=
 =?us-ascii?Q?DpN/j3FQ6DIbM7+DBOpQdV0u5sAFxG2w0BpFkLF1k3ALLKE82CLrSxAvgHhK?=
 =?us-ascii?Q?eV6rPpmh6TyjSmxpyaswCUKE5LOT1v4duzeyS/jUjWRihs3I1vRi5R581WPV?=
 =?us-ascii?Q?GPriq9Ne99Q39EZdZzoxLXhq/XUM3Td8j4TKxtoEuVUeB5QFHY7O9x6Sf5G+?=
 =?us-ascii?Q?ogAfOwggb0Yq7fWjLAuUHteOOqVciZF8inB9uGv7isX5JKFsMawSuwsAiiuv?=
 =?us-ascii?Q?n5o37GtAkPkI6TI8HBr5q+zCaWvvpRH4qdg14JPaAZ3v1k+4f9Ltaptmk3I+?=
 =?us-ascii?Q?yCxrvZ/4WSM1Dl9+xZKQkUTHLmB9Xng06wHoEuMn5fTZ5MbspfqBgq7Jpk4J?=
 =?us-ascii?Q?G8DO5JGAM9WWnMRlqE6/V0/Gf3t82/i6dgu9XoBBZXtak3oAzmt5z31Tuuv3?=
 =?us-ascii?Q?51NVr5iy3IAuMgqRMB+A7cSryqQBe4HZlDaT9ELu+gcI4rFhheZJAvLm3Yl3?=
 =?us-ascii?Q?3b9g1e0jdzFLqYUell67VJsgjNbqiRJRUDnwE3b5EV1CZAdhwsPNuB/XK9kb?=
 =?us-ascii?Q?ZMkMeBWNNzxyjqEpeJU530LWEdbtgCPYekNDA+420OjooPKaCyfkMkGnXlRc?=
 =?us-ascii?Q?84M6qpjHh0R9S/CLQd4GkTejAuVBGCVm/RMx/oBeuLinUNEbsrrg4pZv+gtU?=
 =?us-ascii?Q?6w2taaLhAv01BeaagaUdhhh64c4AQfSzCuCa7loFgQpHgt5/M1rLhBm+GNuf?=
 =?us-ascii?Q?Qk6P3Njlb4UX2dw1R/myKXIsmXyBf9jANTeFTBJrSeJQmQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5p6QsE/wDegjQy3eRMU8mF9O+ZdDA/NlRR6LK9pFXaziOr1OBUJCtcd56jp2?=
 =?us-ascii?Q?qLqle907iTQ93+ZxdVPWnfhhwcl9rRS1aq+lAiyIb98acrKOld+3Xox4+G12?=
 =?us-ascii?Q?RDhULJV3dNMLXoDzVOQze4XkaGZAUZey4+/i/GObD+CmOgnWeq3nSPaAjzKr?=
 =?us-ascii?Q?qzFT6PSei/QJmjXk2Uf4pq6ehbHBaERpO2j6C21m/vNXNcflfPil6Y+BtDIe?=
 =?us-ascii?Q?fc5bIBdQqTM+y+HZ/JlDxySR4lJoLS7KOUatnPrNCnx1HvcRUOkpOjga0+r9?=
 =?us-ascii?Q?k0airc8SvtkNOWDCaQTf+XG9n9MR542OYEkQTO90dWb4H+kssyhudALdQj6I?=
 =?us-ascii?Q?lEcLX7x7qylXDDF/pIY/8cMHwIoVe9/PQhh1xXPUasCIhmvg2tKnDxAC478s?=
 =?us-ascii?Q?WTYzHwfhFHq5JoVCx/PzuL2PykHFBxh+eC29bTONcJEkitth5J/y3OC16SDj?=
 =?us-ascii?Q?Y150RbUoKBhZcO3y3bv/4L7Znp6KyjXX7h6xRXrzMy+itBQGScsah3MXH5zv?=
 =?us-ascii?Q?IEdWQoxExj+AZewG+9Ojet3eoGw7cgi70YZ7Vd/1zJg99X5uCIdw34T2CBk8?=
 =?us-ascii?Q?jn2mISrA6eCV5v7uIJw65FUuJ8pLGMQbAsqR/1qhBiZkShusRWC2JiWVf/ei?=
 =?us-ascii?Q?CgahwDJ+22++g5hwG0k/HXG+2B3vmlmVTDo8Tz4g6DVBCgpLzgPYdwv+x6eH?=
 =?us-ascii?Q?NVyOiLdYU4BWsiy6f82E36BQ+m/svcGisESaZZ+9rPIhkNJMf4C4D9YIsbyX?=
 =?us-ascii?Q?tgtYGwMsia5l8DqXUXsecaDog60zyjYkJyQbNzl8Dtshvwdhwjs+pUDxPlop?=
 =?us-ascii?Q?bGxLHEaHqx49wGhA2iwjq4Owae2yECKeBNAWVw7m0gNPeyj6L1gXaMxgHHHt?=
 =?us-ascii?Q?HEGyh14cMKqUDQ0Q//DmML5ZFY6jxAE6mX6kt7846KfJHi7cdOvlciU252Mf?=
 =?us-ascii?Q?azDingt2lNI4wLSk5Y2eg6/JWtV09duFZsI6ZItYjOohELovabjdlZqxTb04?=
 =?us-ascii?Q?VSIzOb36RNcYTqI4oUD1/9JvzeSBMsh6uoz7kQ8Y+zlmlB6xZLbBE2aN3xoq?=
 =?us-ascii?Q?wY2yBCEK6IWB4/9kvy9KV8gj7r9jqocXuxGy/YX7rXJ6Ug1jtmrgX+QdSjhY?=
 =?us-ascii?Q?rH2S4i8Q2TUuvpvSzRhnFbS4SHUcBPwBV26sz3w9IBZRSrYC7lHNWF576JJO?=
 =?us-ascii?Q?Oo8TGMynQCYcxtqTWiYeAd4/m1hA4oGog78oyMeGwdoalg3p6Wbv1kvQaMTn?=
 =?us-ascii?Q?OP2eluJXa3y6GNYP7k5rD1XDeGDecuycYOaF+QCgyXkWAVz5e4g95nCuZmVd?=
 =?us-ascii?Q?pLyK7arcVbuFQEosXZu9XC2Yvbooi+c+c8P/FPTdh136umGGZfVZY/h7y9sA?=
 =?us-ascii?Q?2B9RDjMQ1jZf3tbQe+isneudJ0wXdvU/T+QPNquLzaZsXcpPrMWYiMzwHyBK?=
 =?us-ascii?Q?h8ehaBTCjRC1AfhDKysaEqVdE5D2qwIjK33bT9a+mboIbmapEMFFdBp+7Ju/?=
 =?us-ascii?Q?unvC+PNRqha04lqR28oqq5znHisU8Qjruq/MfzvOsVABBbma7RwIINV/tEor?=
 =?us-ascii?Q?pIRwq3W5FzTyoL43BRe2T0bZyaRH54aJmdU4zp6PZiN8cP6beN2IoLi3zXvY?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XEIrVSRb1exaZ6u7PMjfV6CIyDNN3IWe+HIBmmeFIaNv1/xSqajlctMCkyopcUmnH4HgdSDWNVtTkwbcRIwuAVy7z516FPEtbis32xyJqPrz/F9F/bDa2YN6V5ciK/jHJ3TF46+sowwzkjvzfV4SLmJwGuESbqLqSV5SMDw7c/qBKMVgSlGVhJHNK1f+lYSMcTy/klXIbKPebawbpYEw8KfM0EWBhokKVAMeFKiQjYnz5eHOeow9SA0rg331l18NbKnnKnLXrzdfekcnk9UpTq9y+ueIzkVo8K0sWZe2i9VRzRJLBGS8K5Ke4qEkdPu7B5Wg8w7PK5TZgnO45Ja5EkVGHBQkhSwWnbySnD/7t2QNi9DGXamS7P5xgz6i5ez2DG/OK/uYU+DYbiNJZink++dRM4rm+NZZW59z6uGto7dFHJzq5nV/Bt7NBXFG+vkCQu+XnKuNkcuUlAfTJIjEDj2+zkWcgsDEFPrXKwPNWOJffSCVb3LgR/YpOOvqQUKk3gDCFi8VxRFUZOMVA4QbrY/l7ejxdMIPPXBOBfxigkRTcfxIS3Zk+l+l0z4IcYOwkJjMKJvpce+zYZTU0HsTEkN+oTt1yESPL1f1Ykoo4vI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fbd985-9b02-436a-37a6-08dca69c27d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:59.4778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RU/k7UtLDrodjU3TJCoxNhJ9k9IC/hcVejq8mTrfAQ8sbmSa7Ylo8h/lWSiTeQ43Zh077JSfE8rAawPhjGHdzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170152
X-Proofpoint-GUID: AwpC33ZR5xbBRPdPCldc6582dugGfPRZ
X-Proofpoint-ORIG-GUID: AwpC33ZR5xbBRPdPCldc6582dugGfPRZ

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The comment has been outdated since 6b73cff239e52 ("mm: change munmap
splitting order and move_vma()").  The move_vma() was altered to fix the
fragile state of the accounting since then.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 5e74f5cb7be4..fa726116346d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2703,13 +2703,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
-	 *
-	 * Note: mremap's move_vma VM_ACCOUNT handling assumes a partially
-	 * unmapped vm_area_struct will remain in use: so lower split_vma
-	 * places tmp vma above, and higher split_vma places tmp vma below.
+	 * Does it split the first one?
 	 */
-
-	/* Does it split the first one? */
 	if (vms->start > vms->vma->vm_start) {
 
 		/*
-- 
2.43.0


