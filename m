Return-Path: <linux-kernel+bounces-252812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADA5931859
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCFB1F21FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAE21C693;
	Mon, 15 Jul 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ajf4SnRt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GfhX2rVr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F771A702
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060285; cv=fail; b=ecb3z2GCpvwzIkfpmSCj65fVjQtc2C9XiqFqwvvZ5UBR8M9P8NL0EB2uJT9IMt2L6jQOWFqLJUzJXuFWfRP+Z2NsbP7jSpHinhUb8lAPkRghCVZNMNDTayJebu9HrjtO5rPOor+kVrVZS1K/kM/CaQmywZocRPGgEfJ0d+grQYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060285; c=relaxed/simple;
	bh=XvFsWo82ikH4rfHmwGOLLdDv+rOPBt1/vm3UJqATL5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QvFHascIUKxD0n98CYW5wJnK5Y1i9uV4rQH4F3wcoGL1mKm8/4E5EJ83nOt1U5/W8I1W/i8VUebn3NcrRjB6EpgnVsRI/oZckzp2FXa9tNGoZTmklu/OCNy3e+qQ4AuU5yLkpaKmibSr3mTuKpl6PSBzN5d8umgdyZypOAwQkL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ajf4SnRt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GfhX2rVr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FENd4B002366;
	Mon, 15 Jul 2024 16:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=M4X74gcSXBjDZA6
	TakWKLzvB0r9xekZEtfRFOhviVSI=; b=Ajf4SnRtkRfOZ9TMJkTOQyjU6UBrxB2
	rs/djjOuRHbFpzX0vqeLjt56A9YieUTDLk7F7eH6CJ0jP2ON34IN67qGHZ7X91Jn
	j8kSEPPfLI7um7D//WQbTiX3mbHS/RayXKSCQSZnKFUfKpri7rOWOBu839FrVI52
	AkERRSJrK5532qAgDX5f0TmFFkLzS94A8N2vKu7g4zdglG05GCONikjqTr24t/JX
	ZQGVm6zbpkCGVZ6RL1KuxGGbGQ9hAd9BURPOqSbtnmZ/3q/oYmyQ1W/7jUMnaeZE
	Mpk8DA1+ck3Sy2/XuN8Hx04T85aUERCEgSpYtafamr+IW6QN5VcAtxA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bg0ckunx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 16:17:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46FF5H5q005886;
	Mon, 15 Jul 2024 16:17:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40bg182cy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 16:17:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZ/LMsasHCVaSIu5h8S0z2PY4Vo3kxbMMx3o9TJYVKaGBHMgh1i1NFAbFWepOspIQI2chnFZJ5H1GT9SHbS9vOwx0K9ptRA3dywsEriAYghiUM+1Y32sq0LgGXrWStjHBgp9y/zXcZC9LszUmvZQsqdXcs8imTmoO8wAEweItNg2H7fiRW9KkqUdDCKJJkNikuil5ohgdtR7j2ldTXqVwUQA+afbntpSE5opLYjTkrTA8+VctY//6Gkgx08pClg98YbepBLYn5KMrQQhLgbjeg7sQZWZ5YL6sa/dIsX8wv3LwmSVKhGxmllL6KwTNoyU4bdGw00PTXOy5RxaBM5qDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4X74gcSXBjDZA6TakWKLzvB0r9xekZEtfRFOhviVSI=;
 b=roNCHHo/a9YCbzvkps4cNWDmnRDi467PCB24Ob6n695ST76BMgB3XmpsLPpPzNU2e+8FHGzvDLrSIP/Bcz5nl/DQiDFSqe33xSEmwfwdSlxiKZ099/aZsWK/Ihbf/LH05lw0yzdMrDvvmnn5gpAwv2xLSAwjGPIlWC2Btr3SVbcHcU4HCXgA8etFTufUd0AX5BASoGbf5/T6Kmjv5zxB6U53qi8caXfVYqjUxICfnQORa9DcOjdHXwtaBYz96uSQxIEMVLt3XeWT6Wl6wxdocFMWJPr9zYyiMHOwSrvP92pypNmd871F81f+ZmCwzD6mzSdt0dMvMfRHas+tyRo9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4X74gcSXBjDZA6TakWKLzvB0r9xekZEtfRFOhviVSI=;
 b=GfhX2rVrC3yORhIILJpPTtSQZw5e0TnZ5fAm6YtDYZ4UDXCe6dvEBym+3yGHMWjdv0NvqTrfdGYfgSHSJ+AQ//SfopA4O0ZP3Rwq3DSv9JYZ2JD/sJHncaWgLPjXcsTLqpGwuIAsSqr0Q/XT8D8RHbb71QDbAnGl9yp9f1b5DVo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 16:17:47 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 16:17:47 +0000
Date: Mon, 15 Jul 2024 12:17:44 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] radix tree test suite: include kconfig.h with
 incomplete path
Message-ID: <lj3rlnhffccwunowrjvk7i6pq6gcpg6rzdmvspwhjdiqfmfvob@a45kjy2du77z>
References: <20240712074151.27009-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712074151.27009-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0385.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM6PR10MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: b5125de8-73b2-47c1-efd5-08dca4e9aa24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Rb8mQmMSBSV4Nc8OA85UW/SoxGf5aEbpk4wOj/N4hgF6AzVV4FDqVTgQ9FXv?=
 =?us-ascii?Q?Y6YfQDRAKZl4UycY7BuOmWCsC/flyLxy2nPVeUZFeOev2Ay6MAmdoE7gRDa5?=
 =?us-ascii?Q?0JarbPO05ycaxcG/0SMJArY5adybMpSSv04XO92GwkIQ8MTI1Rzy047PMNYu?=
 =?us-ascii?Q?EizrHSrH4a365ndXH6vJ6sU3ZgXLy3SO3xL7XjGmBtG4R1PGPG9jvGr88vbD?=
 =?us-ascii?Q?B2BGDVyBsvFsvksgeSa3b8z+poKTrpzzs8/x1bOjEXUbuAlxpv0042U0bJGJ?=
 =?us-ascii?Q?byPVAGjWmWb0DxNPXA3RojhPFCzVpNqWlRU7Of8PR1y38/D3gKqw7VFSWWsG?=
 =?us-ascii?Q?wjXvfQ1dN4Vj/pKYz7n4VM/6MUvb7nX35Jj2+1paswV8BD0WbIObnhr/nW9S?=
 =?us-ascii?Q?DFuqwz29UIIDn9vH6XPzmU5dJLLdhXyEyCBl7megUha7+KEdE6RVapzP3f0z?=
 =?us-ascii?Q?LMbatTI/Nd7wUPrPJf7cT5ZHltHoZgTPKrcbRWD7oEHC4ctrFXQviA74GSHE?=
 =?us-ascii?Q?wuPO3EMFfPgMKl9YdsqmWXDMOxuIWrBVRGNKseN0NdHuo28N9Ae4Ph0D0Ere?=
 =?us-ascii?Q?MQyCLDGASEMs28KHwNIk8o9LDFN+25KGORv7XNO4W39nlWE6a3Myu7IDXjPM?=
 =?us-ascii?Q?xr7zqSxSfAIoo8NZs0fCMQJi5OaRjX3driFTXb1+MrFIrbTNJYcalImtotFD?=
 =?us-ascii?Q?9q9eBWgYXrAGhi/KIUUab6CnpHRvOopBr4OWAWSTlnTHXeGop8BwyoL22Wyq?=
 =?us-ascii?Q?ahM7mP5ZwRcfj9gAENXGvnKAnC5B+2yBAUKBysRXZ1SgvAuKZCSd7VklCdH6?=
 =?us-ascii?Q?NJixmrIFLp9p5uHUY9SzwvVjdGMwD0d92oNOBxw9S6hIXv3oLhyHNQXOUJMF?=
 =?us-ascii?Q?JecLaToL8ePgOlz/8AtB+TwHjo6EgNsfetOghkfdqw1POVWL5Ft7BanwuAda?=
 =?us-ascii?Q?Q7u5fNUE5AQ7XBrDnsLcFWjSW0vKengR/1k2xPqOB50WBdSJZ/UkC60tLgCz?=
 =?us-ascii?Q?kRgoLit69ZdSrFNkYEaJXZbCpRng7waS+Y5SFMeCceEvvmvG491JTxIyB7hp?=
 =?us-ascii?Q?dAgnQMt+iB5UsrievyjK9YUxMlWAuHSGPo7nk/KWHlsFESOOJ/JNHDOPrGKT?=
 =?us-ascii?Q?mpfeAqX+jwOR6Jekf0Ge6pgeGmQpQY2ag6sSMit/8MoEWK3aprIWaxOzx9dx?=
 =?us-ascii?Q?cTIQK1OcE7A0KwR/gEs93BTF/IjjyEJ+qAFilc7nMnwdKhHUMKXMthmFWKjB?=
 =?us-ascii?Q?1cj7RgE6/bSr1pqBSjYsickh2rZ0lq2U8xtof/ebJ5yZJhI1UpHMXgsn2hkO?=
 =?us-ascii?Q?UrP0uy0RbO2E6u+B68rZnFiC4zDUjqQ+0rDYhn1GhY0QaQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?B5h7mQn+qneqmTDkD3Ya2BDOknbjUhDgSJ/+pC4gcNu+Cie4yAyrS2oldpwK?=
 =?us-ascii?Q?3rqYxx9kvJFqsJwYxkiM1H4epdofSFXC9FIfvwNPzmfvn39PMtNRg+xOsIZk?=
 =?us-ascii?Q?XMg2qzeqFsYYHVvP0roJc0DAAfINEVwsLZwCM0kKzO8h6yWxYkVXn4k+EoST?=
 =?us-ascii?Q?C0hw3Nsq8c9BDSIewitwy3xRDsDTa7m0w8iXM6dgBNbNesxV1gyFj+MRADSl?=
 =?us-ascii?Q?OI5TgjvLHF/izPuUebZvnZipx02v6yOTuyT/pfAXB5yfnbGyHre0mCozJhxu?=
 =?us-ascii?Q?phbMOBc5KGb0Y2Ozx903BYvAyzY/an6k/17lfrENEBjEPTOKvH9EfXUCW/7n?=
 =?us-ascii?Q?5tjPPyvxdFQcyt0i819Odd8u1m4C9bk5u59q79MpeVHEPjslnIsWQ+V2UZcv?=
 =?us-ascii?Q?QdyM+MgWBlpQoX6OfdaY6lSS17n8uCWbZZ3Sc+ErpEWVKv7ldqr4Osa3ORPk?=
 =?us-ascii?Q?x9/mj3QMNSs1FFIZcT0Wa425M20lmls0Q3DU/CXGRk0PUHwJmmssSMUNP1h1?=
 =?us-ascii?Q?YwIP2vFGDsDbifzvN+0YnMB070s7ZznDiaDfdYKVU01tY91dJIVG0PwJ+/Zq?=
 =?us-ascii?Q?nUlSFyna3o23kp2CWkTsLzoaXs+av47o8X2yuHoeMvcTrSyDllkwT/8ryqHq?=
 =?us-ascii?Q?zkSJAbsmlhK3ceAvLwn2yGZXBMnq9fnDU4KXkJoLAe3pAGjKnRevJgR8pL7G?=
 =?us-ascii?Q?xT4fRb1g1S2I00RbRLUbml6kUtwNTsrBFAswerFiHLC6eqc4aLSAAubw3Drv?=
 =?us-ascii?Q?I24399LI5wGPT7e5jTG7YiTGHNs57GHrdYIDhwS9ymGozOkfjRgGpY22tHd8?=
 =?us-ascii?Q?BSR0PIVhqkejBsTaCKvJbfyPUzna8cc9a/hWwPx2rHcNVr/IU6scOrbpyGWV?=
 =?us-ascii?Q?w29B9VXuOk6O2aK2tc/m+k9ywnh4REYTJYLnbw8kubnZVX0p/ckQejaM8yqM?=
 =?us-ascii?Q?vTj+EXCNUzqPBkXNl6gbyvhBMFm+ZVInhpab5H/xjFIYpRFunmNA7u4LCqXH?=
 =?us-ascii?Q?u4zBUQl+i3xWEZDXYDgPXuhXje2rIGJOWNGUEBlDXH0q21njb1ib396yX7oK?=
 =?us-ascii?Q?XXU820YfCMN7zT93h8Xmn6+CJn7pIGvawX+RJ7AQlqysfwDQ7Dq9UU/VZSqU?=
 =?us-ascii?Q?Oa02fvXRBjdrNtobP1jPXDIPISuFjkTwJjoF2K/m+t5H23/46oqSeSwIJWve?=
 =?us-ascii?Q?xwTw6WFb7ItOCR2iCy2o6nWHHnX+1hTm+znwIPAVezEq3kewjR6nxki2GIPJ?=
 =?us-ascii?Q?oDy56RoX+SQ+E4yhyCYI7Gw4cUhTap8pjccjs41Urn3Pf0YHLGPItUyQQK5e?=
 =?us-ascii?Q?Zm0v1LNCJ8ZM2F8pHG8uvZcgfYCupAA+GBKV0RR+hALwlCfjRWBfZ8kRDrzO?=
 =?us-ascii?Q?0tWZlG27HWI/O/08F85HU8QeuqqGqWHNmRZTttklC0zkTsM4r5fjLm5UhbBF?=
 =?us-ascii?Q?aX+o4NEiDTD2OHQ7CjVQsGHVb3cEoa5ACfRq8Kt+WYXBwipNTpLUnRaDCSr4?=
 =?us-ascii?Q?LuHZ6PzYv0aQa9FQWUmKQGsN6c/AjwaUE+KKCTEGatS8RUxMiVHwb10JxsbS?=
 =?us-ascii?Q?GCnvyLZtuLUp1/8e+f4o0Lv7WlMs77eefDjXkwhw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pyuAtQdOxB/DkFOi2t845PiPupkGEtb4olPzPhrwSoBjqwsGCobXymvUL7a2vdEXqId7UOajUo30gdHQC5LArfFNSt5w+5G3NpeVTV96gS76FxD+2JLd77doPpY1Wq/aPaMunTDm9nDegdnlpZmhOREh28zSQ2BYoKXitJeNAwGISiXoE4+ss199EjUUAZB3TAzfD2ymkhxQmy892P7M0JJc1WjgJcf4xHVCvwgHu9ONtk9XWhyMJdu8Wp+qfPdP0qaHoWS/xrBgcegMdbM+k25nin8gqR3ABE21gH89bGrFx3z7y15GkhCIq/rxFDZ1pjio3PWm/YgUeXwnddq2kyIwkh7vr+SKHTZQkZ3QAzWKEA8mHmGWXuTDp3GeQ7WKe5wfgsI53ufl0Xeb1O+NH2zApI77Bh6Uqqie8RBvlUw9Rw53u877Z2xHGe5RrY4HsqTosNs7SLGLRlP5n00c8d8U8uPHsnWtbbH9YHo9bp6KfrVyECl1s7Q4aHlW5HOtmST3RcOTJMyBzpVIJy/Ompzqtgn5fvL8D8vYTYLcqr8e5/nddiBVJcAx+V0n4Hg6ilwPb0spurvuaBzpJB+Ix634upT/iS8mN8r24UdRxhk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5125de8-73b2-47c1-efd5-08dca4e9aa24
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 16:17:47.0279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5X/+fygLhj6Lh9j+5xLVnry/Ih5L65OJ8pOO0F44JklIeT308a7gupJTXI5p/9b3F/Efm/oS339qAfFBsfvCeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4380
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407150128
X-Proofpoint-GUID: 1V5il_4Pjmz4aAKCZqToBOvpkYZEGrEz
X-Proofpoint-ORIG-GUID: 1V5il_4Pjmz4aAKCZqToBOvpkYZEGrEz

* Wei Yang <richard.weiyang@gmail.com> [240712 03:42]:
> The include path indicates it is the kconfig.h in tools/include/linux.
> 
> Let's use the same format as others for better reading.

nack

This change stops using tools/testing/radix-tree/generated/autoconf.h
which is included from kconfig.h.

If you add an #error to that generated/autoconf.h header, then you will
see it will build with your change, but fails with the existing code.

So this is not equivalent.

> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> CC: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  tools/testing/radix-tree/linux/kernel.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-tree/linux/kernel.h
> index c0a2bb785b92..fab6f47a9472 100644
> --- a/tools/testing/radix-tree/linux/kernel.h
> +++ b/tools/testing/radix-tree/linux/kernel.h
> @@ -11,7 +11,7 @@
>  #include <linux/err.h>
>  #include <linux/bitops.h>
>  #include <linux/log2.h>
> -#include "../../../include/linux/kconfig.h"
> +#include <linux/kconfig.h>
>  
>  #define printk printf
>  #define pr_err printk
> -- 
> 2.34.1
> 

