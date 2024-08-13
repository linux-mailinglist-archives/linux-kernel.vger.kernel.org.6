Return-Path: <linux-kernel+bounces-284949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11C3950740
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6763A281FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052D419D07A;
	Tue, 13 Aug 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ENPFUC9c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i+6aeIm1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FC63A8CE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558354; cv=fail; b=uqdhOq9c57Ptqxr2I6GE5Hi7b3lNPGdVrbBiEbwMQxYwXp5auAEcTvznFvn78LXdgHdXtE0GxeXBSF8HK4sQcUI/dyyNEK4OGOtVOZguf9yP0+nkQZ6JafsCCUrliini7Shsl/r4mNKMpnymVfM6zmDTi5Fi2k/x8mHzx0YzuL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558354; c=relaxed/simple;
	bh=XS8AxMDcRBKe4xAZm5IuGNvdXK7w4D2DIQp/aeFRnq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PHqDc6ODbI/PNimcQ/vB/BHdznzvfLvWB2AKZJfKk58tPoOO8+0Tq46Bd7E/s2/nlAyxGVV/GNl3szoWI6WjnpgtPZiATvp9QSOe9DWh6My3ZLm0HBGkrF9DjBcJyXOOV1tmBAyds2Yu2Z6JJ3IRnY4ho88E5/4NB67f5PIDPIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ENPFUC9c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i+6aeIm1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D7tY1Z014007;
	Tue, 13 Aug 2024 14:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=QHWtbfKJCOCOUdt
	1QAtCyKzuf/WHznjGv1IKuBZsbIw=; b=ENPFUC9cSU7xaJTFHhjQzkRNXOtDVei
	vKdTlk+qDWBH8g1x2h8Z9ogYLUp0ttklOfWK0hteObJoIoUfLGQ0isym7Q2nKqnz
	txt0vyu1KXLuxbitoyQgu7QoRaaY20HFuYu78xGkch2L1CnEo+qpab5VTlQu1RCR
	EgIB1TDmDjaYYWsAraW/rKjkU85Tlvj/2HFd5qwvnXyn04GEGOuR564lWVXeitK7
	ifZHRisC7IPq12Au258t92gdNPxoqC7th6rl7T5hGT4rACdOFVmU1JQaz+dt4muG
	86w1D0g7dYwZ2wvXzSsEUV+bPybAaVe5HA+bpDy7i8HgQD3vkwdLFpA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy4be3mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 14:12:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DE3gaj021224;
	Tue, 13 Aug 2024 14:12:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnf2rta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 14:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W14dLRRYIL7SsP5qiFlCtjH6EweHpbtoAizG7Hr2HcW/1iN4LxcHbwbUOLCciRl5/B6ew4YwjqKmvMV8jfJAcDAd/hfIRWf9pT21duYcrrPP/3Eq+xhyssW43ifwC9rZtCXBaop6vhvXOajD3ZZz0gT/2LGy3Bhai/lP+Lx4fjsMtVALlkHg1d4OxR3MeFHd9ikBNyLUvtAqvmzx/W9dDcr6iH8BYoB8nsiggcEOl4fCir6Tr8gepsVvL8hXbmWaFDba+F+wd/i5bjL2kzG5MCcFSwFPxSw+vqDp6BZaXzWoFC+xXUa/Zz/26NDZ3FvNAYHcS7c0jo6gNhVMGMSfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHWtbfKJCOCOUdt1QAtCyKzuf/WHznjGv1IKuBZsbIw=;
 b=JmsGsgUQ/SX3hhCimqoc+Pvt+4GUQnSYLfGwqVYnHAp5WkqrzfodlfxMcVX9jilZ7AkHjgWkjIvBMpTu34X281H42PuHhwJ18CyCyWCPf3iPk4Z8dN+iSrHwlkpCG3Vj42PkYQKm2+tpe5RPTAzLgf0iJFeUCNzSKnqvdjLh4sZViZvaWxOxNLXZvAKYd73hlSGqfNNcz93T7z72gnaImwMwTJcRmth0B7q8f2HyKb6t42MIe0HYfgcgWiU6IpztpNYO5ldlq5uM5SsXDwS9pfzkft8c5BESKiY7gCIGS3Lb57xiy32PTRpoVWKk2UV+pisBQeAh1jbPCrqGBwZTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHWtbfKJCOCOUdt1QAtCyKzuf/WHznjGv1IKuBZsbIw=;
 b=i+6aeIm1I1FAIkQX6QStOaKR2M81TIa6iwwAoT9v9kmUgkBBPMY8YL+6NnvUZQYvZKpHwLOa0ESMjIlqRfzSKVY+yqdWdSBf0c3sUYej5md86ZdO+YsNsFOM8nhXhB9SxYxuclSC5cRTpxLMWW483bYUr1D27wrrBehiHb/Phxs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by LV8PR10MB7725.namprd10.prod.outlook.com (2603:10b6:408:1e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Tue, 13 Aug
 2024 14:12:08 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7875.016; Tue, 13 Aug 2024
 14:12:08 +0000
Date: Tue, 13 Aug 2024 10:12:06 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH v2 1/2] maple_tree: reset mas->index and mas->last on
 write retries
Message-ID: <hxs6snfghhcgdvjse6vrvxzpxio4oixw7hezkryhsishap6ngm@tzsoubsx37sk>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
References: <20240812190543.71967-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812190543.71967-1-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0203.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|LV8PR10MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1f5af7-ec07-4fc8-fd76-08dcbba1ea80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LZv0p667OtdTOb7nU8f+e1NwW2hOXDkadgsngKqim1u8xE0KIx82RHOtkChk?=
 =?us-ascii?Q?V0Ev6Zg9je/L0D4GlaCrxyky+LSQzZaKmtKIPX7UDHM4B41d9BXvJsC2t5jb?=
 =?us-ascii?Q?u0Vb0LNxERsr723UA/eSLSHIWQ10BqKq87xEb6EXhZpjUha08y1/z3U1YeVu?=
 =?us-ascii?Q?nVrj5uUrqO5mOBWfvKCv2OJUEjH1c0aJLoO8KRK4TNHrA5UFjEYfxKwOxQD0?=
 =?us-ascii?Q?iDEgpaE71De8CAaBb74Tegc/PdZxbUmVZhtmRva2rIFTKLZ4sGYSWZw3UgRl?=
 =?us-ascii?Q?pSWiAsKjZ5/eeyI4NtvnsRjDQ0SGUMTnjsRMcCA1EvfubhaaaWr0e9V8rQo6?=
 =?us-ascii?Q?T5YLQekbgR2gjf+K/6PL4XCC13pPDUlkM7CegtohEAa0uBC5hgq+24jCWGJl?=
 =?us-ascii?Q?bc01nqzt9V2kQe/PLjG+GynUvmpjrrQFyltItBZQ0ix3WlRKWzmoLmIKixmA?=
 =?us-ascii?Q?DLljj4PcNlBp/KochxzRB7YpwsjjFYUYnqxnF/7s8QZxSbXGfZ91lFJyocfd?=
 =?us-ascii?Q?gGvzm1qy4N96hnRsKzLaalRtRzgJoUfEs6vxMjvIRvydp17PxWaSUP2lJ11W?=
 =?us-ascii?Q?zhgYuagzhU2Yf4VprPhRyEL+CkUj/SMtydgPy61zjT7mxvo/NMwYDF+1MVWb?=
 =?us-ascii?Q?A4Y2aTON5GUtzDhtXomjs/OakWcM8OuKBONqna1MFYe56bqHU35dlZ5mYQTJ?=
 =?us-ascii?Q?6m2N7DDz0MTw4CRK44misag2z/gN2gQ9LxfZaF+Q55yQXl62GPJu4iNLmKkk?=
 =?us-ascii?Q?X506prxAAm2vt7hxr/MkDc5TjxKcR5L1QhKEjBF5FHrgouzsPns25YyyE75M?=
 =?us-ascii?Q?IVoVRYFqH5+XKGhqrJaZCKs+d3sDFGFYnRoerv/iK6wCtVOI/5DtYncXNxMd?=
 =?us-ascii?Q?IPK83W+CVgosAuU0mz4RmPTMnpHQc6jMC73qSrergn5Ta1kB5MdMS36Wtif4?=
 =?us-ascii?Q?2idXnj2ADSF1KZEqDAvb8948G/broG2F8+WYsLcuAFwshxinScMQBVDp/fSZ?=
 =?us-ascii?Q?ONtGWJxSLPWCpKzG3bJt8PHjZ17GKT53mfX0Nm+62r7SiQEchMBPupF3JYcm?=
 =?us-ascii?Q?KBewYcY7QNBNDCKsVc78HJ3nPtlkvrwH7SRJ3Pjgjq695J+BluIvZy072BWI?=
 =?us-ascii?Q?UJdxF6W+QRuGRmB8TVa5iy5y8IkktCrqF+A3B8eiGpF2fGDYVPUaXMVvIpuo?=
 =?us-ascii?Q?YFjVX8pTXS8islFeXxeE8BKL6O1KlOdtfGmd7iUOaC0Oml2sxA6ulkkfJ+J7?=
 =?us-ascii?Q?cQaMISG53Lnnwh8ECyJkVuIImEIOXbvRvu0BMYGISzHcmCz/u6D0dRX5CSwK?=
 =?us-ascii?Q?JXAqUNec41xFjwRkW8KbDHLVH7taK9kYWCYXsTFi5zSFiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zPHwQj/kKjDqli2p4ouxYlzaYwSaj01DvDh8h68wYUVhAN1yaf7kLdEfoYmK?=
 =?us-ascii?Q?4sZEdiI/wTwMXwnGHVTD1ezLZFaw7Jw8Dft7St2eu+s3jMBmcR0eXlqeoHcR?=
 =?us-ascii?Q?N9YfNGrCHQ4baCI8lULZPrpmcg9yP+V9BUBENIERVQStVo2GgGiMY0nHhkAw?=
 =?us-ascii?Q?Nh99DnlwOPzCW/9fhkaMJYkIcarPbbq78c3bdu/mWVoMdGK+vanIvG9NzZkv?=
 =?us-ascii?Q?ZtB9DK/bzeen0xceQpkgk5CyTdvqhGCn6xr0Y2Ev3TRcSSeyASiqLzkI3D2t?=
 =?us-ascii?Q?heaygH4DcM2RdU8WMrQEooqC5EtaEq971E5U7sp1h5t7CX2De27Ndf3nNVYG?=
 =?us-ascii?Q?DjhUracx4hOaqzbNFOAI/r06pqgweGAL+PYUr4oih8CKVLk2kuthLuK0l2wz?=
 =?us-ascii?Q?QoozruW0pnw2iXm1uArsyTVXpu+UJFwd65hv6J5omvas3eV0q8SRVQ8sgRQl?=
 =?us-ascii?Q?ejJ58zO2v+ugmDNIFvoBmcLNyzH2dOM7mu0WWfbrScH4uBEZpqjit15AQGRB?=
 =?us-ascii?Q?QUupauPRql9oTBz9/gG0OA+F63o60l58fqOLx9pKZG5NAZ6yO3NnUR3ml/bz?=
 =?us-ascii?Q?gxdREH8PFgXdaj0GnSmbX8FcxbYevaY7xWIRgTrQhGAShmKYX40lCIeTBM8o?=
 =?us-ascii?Q?Qt7vdctu8qTJmKBaWM/3cXPKiWnzX8akgd4ezo5JfOBz/R8e2nw16YSmIroF?=
 =?us-ascii?Q?zx+8nmP5UGMN8LvikciKJtKzAQrHqVXYNbFsNi33DSo9RWYb85LCn88YkkpM?=
 =?us-ascii?Q?HUv6MB6TlP4K/e4c/XQFlMqhFDTKI9DBzVB2J+y8x7/na5jmSgyb9VivOEb6?=
 =?us-ascii?Q?SkxQYEyvwUOj9LWiylxcxsS6o5hwf/Xujm2bF3FLqyq4PC11muRR+eKPx9uQ?=
 =?us-ascii?Q?Al7Vrc7sI2J96PzBL4JIZWHSFveIKtUOTmpHYmSZcTPzri4Ks1i8zNnUe/MU?=
 =?us-ascii?Q?MbAkbI8VWe8IxZV3TztvOr7k+cy/EaSLM9gqqQy434QzoRVuuhQwf12nkzcd?=
 =?us-ascii?Q?N+C0/8rap5sZ2C4bAQ0b/HufgzB+F5QSviwD9ArWUv5gPYMjA3hIls05t9zu?=
 =?us-ascii?Q?3eu48WDAPhnEKzz7mUyg/cX1Gt15A2yFkZyyYcuBDsyadzxj1jIe/NViF7Kg?=
 =?us-ascii?Q?i5UzYWHlBir4o9jnjXID28YKVm8ZtOrG5OxgUblJQr9sBnRikaScuZJCAc/6?=
 =?us-ascii?Q?fP3MsQwFFaT27Jxp8fgpkqFX02RGokVfVEh7R04sAwBrde83Hxcc72tu3aHR?=
 =?us-ascii?Q?xkODzlJcYecrDKEr5/qE2mZCcgES89670knjt5VZhhqgecPQH7OuTr6ycSEQ?=
 =?us-ascii?Q?hhS9Tf2LmiRWJ/uciT9G4FmW/cQXKSBqvc9Aw9DLxzkECgTApiTuc4t0Jqh+?=
 =?us-ascii?Q?WrbENWh16SqJEcQlPfRz1KL9NlqC3LlyjUZye31+RXyN3SA/cxVPTywJQT+V?=
 =?us-ascii?Q?YjaoNysRnl4VrDG1th6V0Ch1XlrLGeqV0eRhkH2rkYmsyZooFoeEKnWcOX/M?=
 =?us-ascii?Q?N347XeRcoolqxKV0yJqDOcam4ZbTYmSuPHSYeQzC13pOoubWf8zdKS/APTU0?=
 =?us-ascii?Q?P/rjRTP4reSfiUc84afmnbCoQed3Ez2XYu4IK8/x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kEQChmCm2FnwwytslVLxoVgwfONVjwQyB4D1rp2jqeZO4WLZy18y3nx12MTImTmU+gJVMgqjmX+pVZJttJN1wn4XIQ/YSGkBIlWzfPgQlp21a+icbmNtDMOIQa0Ikr1bYllmEOBiW0nSmgZHxXncSz6Rckgla7eUBSu8PzInWMUYT4rI8koEUpG/9+OOZ6sxU4K4HJsptdvR7FYW+31cGXAeEGIEw/11SriL+zJKO4PBrXJ9Xxer3keqJ4Hlz3Ra1CpELwuqHSysu7/h1/i31KDcDt8d8MUToTgOKCKK8Do5xCPrMlpQXLG8pgNE+yAO4RLbiU9MWhTi8Q+NP6UqFj8Maxm3Vpmuvfc7wwKrnqHl4d3Z705NZ18dXQYco5y6Vb2ELvKKNvhVgH4W3YdTbnSrdw2gDmCHQHVmsykOAGi+OPUGx8gPvMWbWY/E+V7bd50ZKEv7uF2WIi6feukvx3Oks6SVjaJ+E3nXS4upWSTqAb6Q6s+tei/5ecTNFK32GcBEmiXw4wKykA5+GeRar3sT73LZrxMTqKxPXyoJPzTnX1EVArZFxsMwFABYAXMlnGwBQ030hpgteKWOTl8/fuStjOoZAwNXDqn7i+Hl8OE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1f5af7-ec07-4fc8-fd76-08dcbba1ea80
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 14:12:08.0135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPNv1V4lVwxfA5C1AIthbAiNQWEAVVuZKw5DiSt2R+Bptxg3Qr0dqgCMvjKpD5SISdu5LFnc/PC4dSWPjNIclQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_06,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130102
X-Proofpoint-GUID: MkzkcsfPhdX1umT6QGULgY3FTLiiPrk1
X-Proofpoint-ORIG-GUID: MkzkcsfPhdX1umT6QGULgY3FTLiiPrk1

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240812 15:05]:
> The following scenario can result in a race condition:
> 
> Consider a node with the following indices and values
> 
> 	a<------->b<----------->c<--------->d
> 	    0xA        NULL          0xB
> 
> 	CPU 1			  CPU 2
>       ---------        		---------
> 	mas_set_range(a,b)
> 	mas_erase()
> 		-> range is expanded (a,c) because of null expansion
> 
> 	mas_nomem()
> 	mas_unlock()
> 				mas_store_range(b,c,0xC)
> 
> The node now looks like:
> 
> 	a<------->b<----------->c<--------->d
> 	    0xA        0xC          0xB
> 
> 	mas_lock()
> 	mas_erase() <------ range of erase is still (a,c)
> 
> The node is now NULL from (a,c) but the write from CPU 2 should have been
> retained and range (b,c) should still have 0xC as its value. We can fix
> this by re-intializing to the original index and last. This does not need
> a cc: Stable as there are no users of the maple tree which use internal
> locking and this condition is only possible with internal locking.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
> v1 -> v2:
>         - re-initialize index and last in the mas_nomem() if statement so
>           fast path is not effected in mas_erase().
> 
>         - use __mas_set_range() rather than set mas->index and mas->last
>           directly.
> 
>  lib/maple_tree.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index aa3a5df15b8e..b547ff211ac7 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5451,14 +5451,19 @@ EXPORT_SYMBOL_GPL(mas_store);
>   */
>  int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
>  {
> +	unsigned long index = mas->index;
> +	unsigned long last = mas->last;
>  	MA_WR_STATE(wr_mas, mas, entry);
>  
>  	mas_wr_store_setup(&wr_mas);
>  	trace_ma_write(__func__, mas, 0, entry);
>  retry:
>  	mas_wr_store_entry(&wr_mas);
> -	if (unlikely(mas_nomem(mas, gfp)))
> +	if (unlikely(mas_nomem(mas, gfp))) {
> +		if (!entry)
> +			__mas_set_range(mas, index, last);
>  		goto retry;
> +	}
>  
>  	if (unlikely(mas_is_err(mas)))
>  		return xa_err(mas->node);
> @@ -6245,23 +6250,26 @@ EXPORT_SYMBOL_GPL(mas_find_range_rev);
>  void *mas_erase(struct ma_state *mas)
>  {
>  	void *entry;
> +	unsigned long index = mas->index;
>  	MA_WR_STATE(wr_mas, mas, NULL);
>  
>  	if (!mas_is_active(mas) || !mas_is_start(mas))
>  		mas->status = ma_start;
>  
> -	/* Retry unnecessary when holding the write lock. */
> +write_retry:
>  	entry = mas_state_walk(mas);
>  	if (!entry)
>  		return NULL;
>  
> -write_retry:
>  	/* Must reset to ensure spanning writes of last slot are detected */
>  	mas_reset(mas);
>  	mas_wr_store_setup(&wr_mas);
>  	mas_wr_store_entry(&wr_mas);
> -	if (mas_nomem(mas, GFP_KERNEL))
> +	if (mas_nomem(mas, GFP_KERNEL)) {
> +		/* in case the range of entry changed when unlocked */
> +		mas->index = mas->last = index;
>  		goto write_retry;
> +	}
>  
>  	return entry;
>  }
> -- 
> 2.46.0
> 

