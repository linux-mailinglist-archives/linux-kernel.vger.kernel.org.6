Return-Path: <linux-kernel+bounces-294709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A86195917F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB496B23755
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFF71D174D;
	Tue, 20 Aug 2024 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a5708ec1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tPcfkCGT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8288A1C9DE4
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198316; cv=fail; b=a8eQ3epOq6xTEZ4by6SnT3PgsTiEnZdkf9NQ824/jptkvvAGeRFgtE4PduB4PQJNoLjHqi41F74p1rBsUAJJ1+54aAI2g4i+4qFF9Nu+zbw9IKJobM2xpSyKotbBNND3lI+Q2+Sb4Tm+fDRRm0+hNF+zmKRqTWTZBF+x23FSZZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198316; c=relaxed/simple;
	bh=3BesS4LACcVobNkzhm2HGMiGJfNdKkj+5co/bv12Emo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e19Rp0jjGJS/6lexu5BKAg9aFec6gH9xl4XmqqTwU6hcMNVbKe4Lu6hCFX1iwrvFLxIqTFxYAMdmmuBpszjtxKDVlRauqUybINPi2bxr/RQN9D3fohl6Xvs8aLEnmnmsP/2wAneeEd0va03Y6MAbqW4qZvVYPYUu6BfadTwmLkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a5708ec1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tPcfkCGT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBdNE016629;
	Tue, 20 Aug 2024 23:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=CKnNlRY4znAwLGI+HO8zfHTa/X/PrK1n5BdvPU67AfQ=; b=
	a5708ec1Qe3yqZtM12mpU+4kXUhqu2ZYNjA3jgP5Ar/RgGd2j4Odaggxr7mqceeS
	woPt1m2da6yrT5wDhMIYWnRlKFHPtouF6OMwT8HIC/rJ5kf7cI7N7aeG6Qy7abbt
	5wYd8D4oBpXsqkspt8WZ+c8yVmzpDh+RXAIeKI/OVVf7h8DE71OkJd4dr1HxnmRj
	ZgSi1v7bYzEQaiAqrtXZz1eS7mtjdZK4QrqXd00noNZMCa+HGRRYHKD3foMJd/hx
	M4bitfT0/4y9T01eGPSM2g5/HkAeHP8b7AZO2CbevGMyQ66kh5KDDuZLo8ktkBfz
	jMhVvBQfeDBvdFoZlbi1jA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2dedrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KNY1IM023382;
	Tue, 20 Aug 2024 23:58:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4154x78g2k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBSplbAc+CSTHuXcB0I6DxgEX6BIWq+4gIw8AMDJe0J9uqx/jX4RIaVRGKJjsvQY6VMiMiT/n/h/r8mfl/h0P17YoYxOWNPE5H5rc563L9FiEcQYYkKiaWYaO+XdwVty6OQxfoYv3U9o0ScTMxNM61PFWriMA7CVMQXtSCgRQtdj40zdOUe9jOx67FsRIvPoTYaKTa5WSRjGyqOg28Y9zVng+gXnBKqin/DWJygqXVAtofQYeCrdN9ACHua4ar/ubFpMLUAUPhlE77K3vD0183rr7IsrUfRlMiVKEbKVC/wGylLwC1XXtKQ0M84dDHZ9Bx+vpHeLKaW97UPWpxwZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKnNlRY4znAwLGI+HO8zfHTa/X/PrK1n5BdvPU67AfQ=;
 b=DkznyeLukdbgL3kZHbZpJ9x+6q0LcHqVSjv75yK87NzWcRQPGSt2zd4oK4rsDZsHQsPJqDvl7kdKCGEafsVUmykb19J/BbNlbvyN+weUidSNR4qxIdY/BCzHxl3wTOYYoIa4KkpMYrzAnrutnl70LxU85gE9BIlCeU+aJpji7Os6sHp9cTlOL2bFLrjlLmB55xVAC033GOV72awq/qneiqjX2nmLS/Xd2ZzfClKNlWlqb/1Lzxy0vUrCa/9dEotIGTqFZxpSG6zTLecO26zsE3rJswtGRycQb+RtlyfIQX5nb9DC+IZDf7MMpTmJaVwRT8lGp4jjet2b6gquwGtT7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKnNlRY4znAwLGI+HO8zfHTa/X/PrK1n5BdvPU67AfQ=;
 b=tPcfkCGTfJgASJqKwvZjfKP6gcScWeXNEB3FqgzWiN5NEkF9oxSQpTtUhN3LurgegfygY7X1pMdBBw7Did+ueqXItxnZpXWpUhJb0vaE8grt6jWRHx+sRUmuXoe102hNN10FMSBRp14TLae3XFvnmn2uRwPgObaUtTpc1zmvT94=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:58:15 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:58:15 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v6 15/20] mm: Change failure of MAP_FIXED to restoring the gap on failure
Date: Tue, 20 Aug 2024 19:57:24 -0400
Message-ID: <20240820235730.2852400-16-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0167.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::23) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 839c3e95-7057-4593-4400-08dcc173f4c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AHhK11IlXFH75vDVFqqoknAhntVKkAFgeCIeHYgxSv2WVAPc0xBlQgkNJIjS?=
 =?us-ascii?Q?stMA/la0EznrPEPZ4Fxyg+UJX4bIJgYx27hehW/tl3a8KuV8C6dsADAHIOwQ?=
 =?us-ascii?Q?Depn0IWFBbK7sWJt6RRMz+bMsOGPj2Gc/LJAZJ6WQ3ZBLRYev2BdB/cn3XGW?=
 =?us-ascii?Q?ocQP25Klr+Ai1V5If/CxnKMV4P3okd48JtlM+POYBWmnX7I8KZ8pPoHQQG/0?=
 =?us-ascii?Q?2t1caCVEtiZKyXt/TbWxRSAH9VbMIa1nemYMyedJemMZdI595DHYLS6G58fA?=
 =?us-ascii?Q?pXAeehI652Syz+0396vmPO/YxZiCmNf9YFKzZIIyD9qV0v3R4kHVrmKJX8+k?=
 =?us-ascii?Q?4GJdOjh01MyOdwzrUGnT6Z3ujeAc1W1Bk2OwT/YEaG7JoRJE79qks4x0wCbR?=
 =?us-ascii?Q?WiZqAaNMJpavU6rtkCI7vOQ2qW9c8/w0b+LsKLjKJqNS0rN9IdTGlKL6APWq?=
 =?us-ascii?Q?hOBmsDlralD/TA0WrqKKprKtEvdVcflLiEMiQr1IEGOO1/hWfKpSpAiOAR3C?=
 =?us-ascii?Q?V+KaRIMRczd5cReJ09J4BHH5dGw2GpT5M4GtAsecPih3sUsMSTINKISFB/XW?=
 =?us-ascii?Q?B5L+n53KlWnYwOHEre0659LrIELSM1y8LfvExIahg1cU+BUb8t/wCKNxI5be?=
 =?us-ascii?Q?OMDY0EWticDpmGgVM23I/LzYKDe1LhemSM3gSX9S4F+w80PLLj/Hnh/d1NjU?=
 =?us-ascii?Q?AKNnqgs48V+1m4g3VlDbCrRZWv0qlwxxR4NIdCa0q7QGGc9w30NXSj6vZ1FF?=
 =?us-ascii?Q?gsOcDe5bozZnXC6ZFgnolGKC52m/x1pzKq5/r1lkOPesEsEa1XSpI1ENrb2M?=
 =?us-ascii?Q?HQt4qXUGbksBJFGgkKaRCQV8uiaO5vnK1aBgZwzBKmhwX0R+G890VE5roHiB?=
 =?us-ascii?Q?Q0n/HPHjV5vwC9rpxRipWUi/FXfRg5QfzZ3Q6gIofKLyJA83vmazGqVpVeNn?=
 =?us-ascii?Q?44cc2liJc/tpeotn63jBSPGmG5E3rPx4zy8pvpk2dGgqANkPZx9mHBExeKuy?=
 =?us-ascii?Q?cgv50R+jn5cfXvHhTiA6ev7F5FfG4+q7tSlT/ZXPk0PR3sjMqGjmlL7qUvd1?=
 =?us-ascii?Q?kZrl+YKibbCWjf0ix9QyJHwjYgmyrwIerV/F4ip8wcpFH5udrxSaX8F/IDfl?=
 =?us-ascii?Q?d6X3ZeEdN/d70zjtD90/alDsYTqCDZypuDxg/HeP81bxD6yAn+TOo22JLSut?=
 =?us-ascii?Q?WvihYq7R5exFAsFaCiou5Kr+XKEBLPQyV9n+KtUqW99WSWpURTJBaPoG51Gf?=
 =?us-ascii?Q?Z+9g/q+0MGT3KDcsTz1tsWnioxZMrOaK6wUFSCfomZkuNoicXp0aNfKwWXSW?=
 =?us-ascii?Q?DPqmuptRv+SoAzZ4bRbl/0RFZNXdGEbs7ap6xUGphApHZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z0b0tsbEOhtmBwbBnzILMekcQkVCtx2JW40NHGuSA7gOnDmP8aPNrtGrSk7j?=
 =?us-ascii?Q?VmU4qFnH3h0Q/q0ZB50ppgInu9zM9TW1M9q016leeDiYJnxRB1jdrs11zfTN?=
 =?us-ascii?Q?oqDRyCZ8LSs4y/FYsL7RDP50Bhjz9rlb05vPgG7cP8THlFyiue5AkpToHHGA?=
 =?us-ascii?Q?76PMzSPp90lj0lmhcZ0RVCSOzS8Q7wnmXAozLxTqDH4QX2TnOmTrskNOPxAC?=
 =?us-ascii?Q?oj1Ws/UIVm2VC66q6Mp1RWDjZyt9iSc9VyR0qmywnvR2HJyVjq+5pYlsrQid?=
 =?us-ascii?Q?OqZXEr0v2S9DzycZhlaNjBmdOiPIKqd4IT0Q9IvdMqVR+f6VhDH72QFJPB/I?=
 =?us-ascii?Q?5y+xgmAa76je0ja1PmtWOegicTkHWbHagL0TIdQOWPz0L7lwupR3Tz2HIQhK?=
 =?us-ascii?Q?YNZq4ri2W+xrHhYd81WAamHvkUGb1Ghj3QIWYMqr5jnNE0Zh3hnXQ1iMNyof?=
 =?us-ascii?Q?9BmgZVMYi4F1S3e9jzqaatTNxYoRvqGuQmHSw5xvfmog0GN6PHI9MwBWqKCm?=
 =?us-ascii?Q?OJzC1/DwHlRQEuvryUWj285Qsf+vU5cZYvRBNCVlZT5/SkzD3XUd/OxrAbYA?=
 =?us-ascii?Q?wtlCtOEPevmALjAhDP+yTp5BiIYaEHsHtcdKVCbVYKYmscx4vCEPfvTL4N8p?=
 =?us-ascii?Q?PsIyX+By3ogKjNGGHtxYfmFELbFHsHODLjoPfKYKspQte3X1TMbxwsklu7jA?=
 =?us-ascii?Q?NZqrTn0PBPyleSecBhkdq4GYwMG1A9zPztWh6ejHPLepfhMAfLNOExfNiTcD?=
 =?us-ascii?Q?EF16tEJd8UoIFOzabDV6O7932iSgcQHae0R9G2CDiHjlCyDF0xOm9pqesmWe?=
 =?us-ascii?Q?D/GDIHk2w/ECNVe+Rfcb10Am7YkwPfliA1tQKN1TNvh7IBhioaJ0lz1MnAXI?=
 =?us-ascii?Q?olb0pAUHw3icf61TeKxnhAUmKYleo8fGOhaAiGftjykJ6B3PFtfBHNtgJnyE?=
 =?us-ascii?Q?KuW1B88oHvRDeCX1KAGr3cj3kS952PD280lPnm5mFQq8gDXNGtGNz+g6jLB3?=
 =?us-ascii?Q?JwySIl9xJvoVo9fJUldpwuepVkUBQTyCUm8erqjMzOkKS9jBJThpjlO51AAo?=
 =?us-ascii?Q?5UZL7VtuIMMqvmpLy5ve47FbUVH7C4e/tYRDBsidPTGOwB/tqug94CbvmyND?=
 =?us-ascii?Q?R+3KHNaAEXQOyJuLHQyVQrKP1VMocFtq+grtvoZ31PwII4/6RFBygQDbwfhb?=
 =?us-ascii?Q?firl1WDC/8yEq6zd0XSZnnVxk04tz3yOU9xsPd760Bg3UyAZA1DpjIEXEI0+?=
 =?us-ascii?Q?ZSU6aKpzvrV1Syv9gDISzAiQq7XYapoA7DxYi1b3mHWhCTSQpoYTI8nsB0mU?=
 =?us-ascii?Q?JjoytmfCr65KM4aJLNOuvp28c/YEvpJWSSKfQfQAfBtU3zwBUJqYjjLAurRC?=
 =?us-ascii?Q?63SUkfMOIlM484yUN18SQpQPQLswf2vdm4gKiMfaOMGuO9YbjAIFW0Dty1pq?=
 =?us-ascii?Q?xqGyzdFrDhWhrhAmPrk7hcCLsqfjzWzpU0dLXxbuRtJm81UrsIUZWcY2kFOS?=
 =?us-ascii?Q?cX1RcEsoAzc3+Lwgskyb0nfD2V5W9R9c0MHbnSYXTVrdiAZCAuvBFQb2Vaf+?=
 =?us-ascii?Q?S3wr/9Lg2Vg4H+UIU9/luiAwBIx0Dgug937dsOEH3mHetHPqBVLcL1vhkHFJ?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bp8G8DoKUvdURNZ90MPNWH8rfQoxBxsgM8PuRcNOf03LyJZEljjPWssoGYCVYSckVmEP3znSeUyPQxb7P8S7Z0A+XptkASut7RZByIaqP4eUnOybYbyfpZlC6MUZTYjOlf4GkGdF7LmxvqFdmDJWqMw1ebxOmnmSzZJGxJZ6pglDzJjy/4vi3foKSK25GpGPipQpMN3iK1M8llgTAilRLtSouSsoOyGnAImzsehJVC33NcUu58dyiUgJNwRWSsdhtG9F9dTbkogDL584wxQN5XAh/XqdPIB/JUFf/XuqOZearctl+hMC7123cP30T4xZ1Hf35PirXTVdqapYtxNW3OGgRrkGHnwygmEU6YEo1BgfAE7GJEeXLPaG8kO61NVlZDXVnG0A4nYm8uB1HykwBv9xbORnBkBnjbtUF90+wZPb+gJtdCsWz6yKtJwoyPPNpX2QTDbjHCC3OFcnM8PMAaqa1QRqsjMT1d6tOgiW0bPoEwlrpSHgNZu3HCKvAQsI/Umgo67Pv/XNfMJotKsbc9ZcANXC8GWrkhLSvs4ZOlNFm+pVIFrQIziFIwrUj/LbMHNZQkSmSUbE5dAjm+bmk8Dj44PL5kmUlEKKkAlkS4Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839c3e95-7057-4593-4400-08dcc173f4c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:58:15.2705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTM2EuopIMZr6lm9K28Hc99DiEFC7UuHdOju3QYn3Gz2F7FqhaCZbFrd00lpwm+Oa1hnmzmdZoWKt29JSARokA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200176
X-Proofpoint-GUID: TPsk4msRKmLbfgiSTxbGDVQbfhF0-6uM
X-Proofpoint-ORIG-GUID: TPsk4msRKmLbfgiSTxbGDVQbfhF0-6uM

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Prior to call_mmap(), the vmas that will be replaced need to clear the
way for what may happen in the call_mmap().  This clean up work includes
clearing the ptes and calling the close() vm_ops.  Some users do more
setup than can be restored by calling the vm_ops open() function.  It is
safer to store the gap in the vma tree in these cases.

That is to say that the failure scenario that existed before the
MAP_FIXED gap exposure is restored as it is safer than trying to undo a
partial mapping.

There is also a secondary failure that may occur if there is not enough
memory to store the gap.  In this case, the vmas are reattached and
resources freed.  If the system cannot complete the call_mmap() and
fails to allocate with GFP_KERNEL, then the system will print a warning
about the failure.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c |  3 +--
 mm/vma.h  | 62 +++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6550d9470d3a..c1b3d17f97be 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1622,8 +1622,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_unacct_memory(charged);
 
 abort_munmap:
-	if (vms.nr_pages)
-		abort_munmap_vmas(&mas_detach, vms.closed_vm_ops);
+	vms_abort_munmap_vmas(&vms, &mas_detach, vms.closed_vm_ops);
 	validate_mm(mm);
 	return error;
 }
diff --git a/mm/vma.h b/mm/vma.h
index 756dd42a6ec4..7618ddbfd2b2 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -82,6 +82,22 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff);
 
+static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
+			struct vm_area_struct *vma, gfp_t gfp)
+
+{
+	if (vmi->mas.status != ma_start &&
+	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
+		vma_iter_invalidate(vmi);
+
+	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
+	mas_store_gfp(&vmi->mas, vma, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
 /*
  * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
  * @vms: The vma munmap struct
@@ -136,15 +152,37 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
 	struct vm_area_struct *vma;
 
 	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX) {
+	mas_for_each(mas_detach, vma, ULONG_MAX)
 		vma_mark_detached(vma, false);
-		if (closed && vma->vm_ops && vma->vm_ops->open)
-			vma->vm_ops->open(vma);
-	}
 
 	__mt_destroy(mas_detach->tree);
 }
 
+static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool closed)
+{
+	if (!vms->nr_pages)
+		return;
+
+	if (vms->clear_ptes)
+		return abort_munmap_vmas(mas_detach, vms->closed_vm_ops);
+
+	/*
+	 * Aborting cannot just call the vm_ops open() because they are often
+	 * not symmetrical and state data has been lost.  Resort to the old
+	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
+	 */
+	if (unlikely(vma_iter_store_gfp(vms->vmi, NULL, GFP_KERNEL))) {
+		pr_warn_once("%s: (%d) Unable to abort munmap() operation\n",
+			     current->comm, current->pid);
+		/* Leaving vmas detached and in-tree may hamper recovery */
+		abort_munmap_vmas(mas_detach, vms->closed_vm_ops);
+	} else {
+		/* Clean up the insertion of unfortunate the gap */
+		vms_complete_munmap_vmas(vms, mas_detach);
+	}
+}
+
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
@@ -297,22 +335,6 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
 	return mas_prev(&vmi->mas, min);
 }
 
-static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
-			struct vm_area_struct *vma, gfp_t gfp)
-{
-	if (vmi->mas.status != ma_start &&
-	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
-		vma_iter_invalidate(vmi);
-
-	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
-	mas_store_gfp(&vmi->mas, vma, gfp);
-	if (unlikely(mas_is_err(&vmi->mas)))
-		return -ENOMEM;
-
-	return 0;
-}
-
-
 /*
  * These three helpers classifies VMAs for virtual memory accounting.
  */
-- 
2.43.0


