Return-Path: <linux-kernel+bounces-510131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873DDA31895
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC851888F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09BB268FDB;
	Tue, 11 Feb 2025 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="WBMF3Daj";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Z4YbA2Jn"
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAB4267714
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312724; cv=fail; b=JjUUDibo1+cJUs3Pjt0nMtLqktU/mHmlDMYAvFJj2NdLQ039P5+Bpveo3tp1mb8AUU1tjVVK1lAzYRiUDxOKF+gqZNn1ytZDcQuLh1iJlrhnU+7S/YfkEt/XBCj5vn/Kf//H5Rq60UsAvimB/CTm0hxYD41ZMkDfW5rrJTqRa8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312724; c=relaxed/simple;
	bh=Shov9XjbD2kDOmNFtedLmG8pvIe9YKXlwBHVrtddOFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QS4XBL71iGD27qM633ozH0afKSMDCwc5VmDS0ABvOoDrowdKIQ+fH3aJS8CsDjwoJ+E+W6Fe7HT09rqgDwNuL0creF1/rT9xCQZxvr6w+XrAGqXbqt80zMMsG2A/BNSJuesSbNPETB2Csvn7xwJmv5ihGTpw/l1s50oKXzoLaNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=WBMF3Daj; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Z4YbA2Jn; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BL0RsK022411;
	Tue, 11 Feb 2025 14:25:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=Shov9XjbD2kDOmNFtedLmG8pvIe9YKXlwBHVrtddO
	FQ=; b=WBMF3Daj7mXw+u1Mo/Sog5zYIfhyuXtRk/yoPxG1NtOKQqYAdF1hsrCS2
	rgP1vcGqZzcRZV5R+LecRtG4/ylInz8J47awlN3qd9hYDsICEjVxuDUmmk1zXM1U
	okbE3tynVXWSx56XmlmutqflrStN+68Ip6RpWYJf7ippyQgXwF6Cx7zViSyH66qn
	bQn5afKPOwu/Fq/a07lFta3WkcYQ6aXBOeMXV8xGX0LJ+FvFAPYz+3JsV6EvRAZk
	38e+2oiNmTxaXdTY/jJsMdc05QftVLw2tNY463s4k8BtE5U90WIy137Sr/u2MQlb
	ji0nhEhb1AAGgcCIoACexwq75PTmg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010004.outbound.protection.outlook.com [40.93.11.4])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44p7ns73j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 14:24:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1IUE9UjRCTLMujj0OS9crCBGc58GKR/3I8x3VezZ5PFq4ViRAJOEaTcfpaQPBmFNYxljHU4QXlA0vZFhkyO9h8iT7zALtEw5v0puMq9fSRiMtYyqkSKDn+OmDXWkpM+0rM0V9EfDYnmNh1iwPSq2KzXmUK59AzBMhlZZS/ZRePEJoG51ikh6Gs8GIUSch0GoQmHnZ7Nz8vEkoNvSDQSSJ9b32CHjEWqzjnJUoPWj7JrTEkeFVL/MojI6g/4OxmH9jk/Ay0/o2ZGb7ic6BEiyFGK7GAXZqOIb0kmG4YGOBt64EmfOAwJHHUVyKgenUQlDVvoIoHjIk/wT14Zov/V9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Shov9XjbD2kDOmNFtedLmG8pvIe9YKXlwBHVrtddOFQ=;
 b=F4wx51/aZA8wGABi48Ty5V+N5HaySEzLr4pJn0KKYHbHrV5sPz4gFhfK/q+d1Mt7WNjQRQmOxbQUpvdzuRhOxUW6HiJeAnkkFk/LPIcwjB5EQh8fSOApC5SmBsYlHUKZPpnF22TzrsagYdNbpHPd0yEWMxbAgTk3H+vTLDrz/6iJo3AuIAJ/pA1t2DyJs4sJ/BeWO8HwqTAeOMvCRgfIcgBTGeDWw9b4Kjzbz3eTsADskWAQYIAQZA01/UmAkRx/pxFXvmxyEdnuuhx393F1Ibzv1AHOEVSS4vLrHoDmwWjf1xbobWWixwOC2zr51pK4SfnbVc83pvuVUuioEv/DOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Shov9XjbD2kDOmNFtedLmG8pvIe9YKXlwBHVrtddOFQ=;
 b=Z4YbA2Jn1TBRV3CZ/xZg73xwGwwUqFscDaWkpN+IZrH/QYTeLpayxZPNddPzxTeVwVRPT4Hy6T//a5ZzsZIidkPwD3V9HeBXi5DKtesX5lWvfH9lySZMH2/+X7FZxTuwNQqYi8kSvZzjPc8PKUsqG77oSkkwZwsBK6CJktQOxUapck/cU4Q8S4DdS8+0Kh+VbMLRPuCu8LO7QUpM6TeOSTrAEEL8DB9veuat3ewiAQM4i8ARaLv/j5BUv4W30tBJQiwOhKUBGCfOK0OVH/Ifr7u2f5hUoLWkR8Sn6Yaad0zXritB0yj2ux5ZoPO+Rf+i8DeIbG1iUTaYkcK3muA1Sw==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by SJ2PR02MB9924.namprd02.prod.outlook.com (2603:10b6:a03:53a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 22:24:56 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 22:24:56 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot
	<vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin
 Schneider <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jon Kohler <jon@nutanix.com>,
        Gauri
 Patwardhan <gauri.patwardhan@nutanix.com>,
        Rahul Chunduru
	<rahul.chunduru@nutanix.com>,
        Will Ton <william.ton@nutanix.com>
Subject: Re: [PATCH] sched/rt: Fix race in push_rt_task
Thread-Topic: [PATCH] sched/rt: Fix race in push_rt_task
Thread-Index: AQHbfEho1rhvhyIioEiWYCFUudvdzbNCNeyAgABsjR6AAAxdgA==
Date: Tue, 11 Feb 2025 22:24:56 +0000
Message-ID: <9C390C10-8741-4992-8E29-303C907C8C00@nutanix.com>
References: <20250211054646.23987-1-harshit@nutanix.com>
 <20250211101137.5824285d@gandalf.local.home>
 <10861916-F001-4AF7-B512-9FFD0D883941@nutanix.com>
 <20250211163952.7e3a82a1@gandalf.local.home>
In-Reply-To: <20250211163952.7e3a82a1@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8861:EE_|SJ2PR02MB9924:EE_
x-ms-office365-filtering-correlation-id: d3a6a942-5fbd-441a-79c4-08dd4aeaea0a
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TE1MMENRWVhjUm00Qmp3bU5ab3Z4TWRtQTRJSHVrRWpOS0Q5QlVHK3hueTBW?=
 =?utf-8?B?a1dQcUQvVXI2UXFGai9BUHZISGtLNkVjNWJhK0k3TUl1dkR1WmdLQWJpSVpT?=
 =?utf-8?B?NnpOYnJSRm1DUEd1MTgzWUc0QTBwbmExUDhSTGo4VVFyUDdac3RzMGROQmww?=
 =?utf-8?B?NHVJOGUvbkMwNzMxcTdSTnlSeXE1eGlsRTRmZ0dTbDl3SEg3NWd5V2pMRjZZ?=
 =?utf-8?B?MERkZmxxd1ZSVFBDdDdTakE3ck8rMFZQdTRWZlNpRGpQNHlYSlF5N01JREoy?=
 =?utf-8?B?ZGtEb3RBM25sWTIyOGFOUjVWSTk2OXBCU3ZUWW9SOGJOV2JBNTBtVmNrMnR2?=
 =?utf-8?B?eG43M21NWkZuWUlhSGJUUmV3TmloQzQ2OEhZOGFKWmFpeUxkUU15VUFTdmJl?=
 =?utf-8?B?cEFZMmVwU2NZc2N4VHNJQWhEUHg1Y2h6NkJ2djBINFFUcUZlb3hyZHhqNmll?=
 =?utf-8?B?UGp6RG9ZY2pGajBGWk9zSFNOQWRrRHJxY0toTkFsRGl0SEJDNFNWSnJrdXEr?=
 =?utf-8?B?Wmd6KzNKZ2hab1pCOU82RGxTZmcrLyt5L01Od2FuZXl5dEpQcG5IUUw2S1Z1?=
 =?utf-8?B?SkRBSi9RRjhib0xBZGFFeXdLdFNQaWQxUUp1Qkdhd2NZYTRmSTJCRFBtWTY4?=
 =?utf-8?B?Zk9XNTJFczZZSUVSV0t4SWM2R0Fjc0RZVVM0N1BaMkFOeG5ZQzZpY3FDUDZj?=
 =?utf-8?B?a25sSC9NVXg3KzFDdGtMVjhjK2l1d3VkdkNxUFZkY0xFZmFyRW0zdGlLQndx?=
 =?utf-8?B?QnI3QW4zMkRZTWMwNGQzYkE4RWltcnAxeUpoZytZUmJxRXNQWHRKZEtGK2Fi?=
 =?utf-8?B?VEg0aVp2Y3o3RDNMZHRyS0kwYnRHRnQybWxhV1lLckgxZUdhaXVodXNrd2l5?=
 =?utf-8?B?VHdUME15aUljQjAvNjFaNFVVMUIwb3psb3E4eS9ZYUlVU2RMalFSYnd4OGpo?=
 =?utf-8?B?bFhGZ2hKWmw4RnlTbHlOWU0rdG83djRQSzBpLzY3RXBVK0t2bkJFRmIyb2VE?=
 =?utf-8?B?emJMbnJTUWp4cFZpa2ZaVmMxeWVGQmVubGdvb1pGZHlIb2tSWXB6ZHJYQ1I1?=
 =?utf-8?B?eHBJdTBWSm5rck5ya0NrUmpxakpia1ZhSmw3ejJaMVhnWkE5bE5kbFp1cXJv?=
 =?utf-8?B?UVphMHpFTERLRlBYcW9kN2dWL1J0WTlFZmxYNTdsUzRiMHQ5WXluYlFpVUY3?=
 =?utf-8?B?NDBCWVY1TWZWT05pK2tIc242V3djNHFzYkpzVEVpU2dHRHJHOTNOMkpJR0VY?=
 =?utf-8?B?YmxuWGRjLytBZk5Bb01VQTArWHY5MkxYeUVvNitOb3VUS25qT0huY1BONzZn?=
 =?utf-8?B?QWJ3UzdmdjFneUU3T0lkWmJPekpmRU40R1d6NlhZV2UrL2xmd244MkFsTGxN?=
 =?utf-8?B?T29kQVJCNWxWWSsvVmVwU2dVSm9UVDhEdG5sS1kxREdETktoWGhuRE5OTEMv?=
 =?utf-8?B?SXRuNkhDMGUvUzVyRUY2UHZaTU9CYjczVXA2OE4rY0N3T0tlQ2w2T0lNNGJV?=
 =?utf-8?B?SnZsSFZwVnk2VmxNeVF2dXlyRE4rYWNxb2lwbkJCZXltMVZNcU1ERURCOTFB?=
 =?utf-8?B?eURQcU5kOVhhWXN1V2YvN3JMNlIzMFE1clYrc3VVMjgwdEcyeCs0MU1vOVda?=
 =?utf-8?B?S1Rma29OK2ZwMThoV0FQWmVFckhPUTgyU24vdzRBRVNvZzdVc3RtMkJRKzRV?=
 =?utf-8?B?bHp6S20xR015ckJyMTVEdmNZMnM3eHdQZ3BNK2U4RTZjdkhsU0g4M09qL0NN?=
 =?utf-8?B?RGZyaXhlZzFxSkhwRzFuT1A3cEYrS296dzdNUW5tZktMcGpjVkMwTnNRdWo5?=
 =?utf-8?B?MllucWdlVzBsQk9aNm54NEhEOHVpWHVWUmw0Y0Z5eThSU29PZ0pVZWFPclJX?=
 =?utf-8?B?NTRMUnRQbWdqWitaa2FEN1J2S3BnSExJMmdzNXBIZTRxdW5xVnBRSGxXdDcx?=
 =?utf-8?Q?Mu9pAZtq3EbSBaHkYRMvcvf8fZ1vyVka?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K25pY2N6SEJVVGhIVDNJN0hEUFkrVEllVFVTUW5XTnk3ZFYxZy8wbHd1ajdV?=
 =?utf-8?B?amxmNFk2N2w3R01rRlNIczFMTVBIeVkvOGVjbGgzd254RzIwejdFYjJKc0Y4?=
 =?utf-8?B?RzdtdWNFWmVnRlBWRUdrQkg3SVNKMVRxeEM3eFJoM0QxS0xKTGwxenlhcnNy?=
 =?utf-8?B?T25rL0Rwb056eitYS2RFZk1oaUZqaW1mKzN0SjZYYlhBa3JBalMzdzJjZVlC?=
 =?utf-8?B?OG51a21zWEpVR0pxb2RVS2tCb0c4MzdqdlNsNit3ZWNzdE5hRXplMW43SGlY?=
 =?utf-8?B?TENRUkVOcjQ1ckRUQlpDM25NS3JuZTB6WVpoMnF2aDRUM1ZrTEhaZWhjNzc4?=
 =?utf-8?B?UTlKYlhwV3RZa2E2dUlOOWIybytSUTNjcEt6aTBGRVRzTzNKNnNIazRDenVZ?=
 =?utf-8?B?cnBJZTRWZGNLNnFuNDBKQ0Q0aEVJK1lwVkRLM2NIeHpmRU1KZ2ZJdWJlcmc1?=
 =?utf-8?B?N0VmaTZJTmhkbVhqcFNEMkVuNzYwbTVNcHI4NWZYajdUakVBSk5yNkkvSUhm?=
 =?utf-8?B?dG5VTlRmdzFOM0FkUzBQT3pUbW94eEo3NjNIWTJ0SGRHVmZwM2xWZWJPNGFF?=
 =?utf-8?B?eUJzT0ZFUHdhTlF4ak5ZMUNCSnY0OG1vQTNMWmZrbTc2MkZXanphc0h1eWxr?=
 =?utf-8?B?L0V4TkdoS0M5d0RuTkVGbVBlOTFnaDVKWUtIL3V5bWpGaFBRVW5sKzlkUFlF?=
 =?utf-8?B?ODAySGs2bGFxSzB4QkFiZUpWZTdxWldNdWNLdHFrZFhjU2t1QWhWTy85VWVt?=
 =?utf-8?B?SkdOLzVsMVVyYmp5WVY1Q3ZJRXFWZlgxem1kdDgzdk9qUDF4bkc1WFFadTdt?=
 =?utf-8?B?VnhsZWpuaVMrZWtiRllCdVpWQjkvemlNNnVvOXJ2YytFNmdkK3MyWk9NWDdU?=
 =?utf-8?B?RzB6aHRlbEpOOFJUdnd0RjE2TWVwckxVamh0NlY3MVJnSWpkMjlIc1c0Rk9K?=
 =?utf-8?B?eGRzVlFYVkxZbDJPenZOVCtrZEFaL3JzM2ZZNml0b0ZGS2VvdUpBNU9hcU5S?=
 =?utf-8?B?Q1Z5c2JXeUVuSXN5ZkU2a0lnMzlJWmhCSlphS1JwUmZ6ZTFHeXpobHlhN0JH?=
 =?utf-8?B?dWJOellrS21UeDF6N2hsVTQ4a3ZoTTd4U2htakJnWjNtNkpoQ3BHUWVMRS9U?=
 =?utf-8?B?cUp3QXl1aFhzMFJ5T0V3OGJDSE9VNHQ4K0pXZ0JXWXBWeFFVTVo1ajMzVVk2?=
 =?utf-8?B?N1Z4WDZ3YjRGMHFWeHgvczdZbEpkUXhYOWZVYTNoU2M4Z0JCY1NhOG5GcHVx?=
 =?utf-8?B?OFJxQlgyTW5QT0E2aHV5YUJqQkxud3RTMTZCTVNyN1VtRVZmS0Fod1kwZlNu?=
 =?utf-8?B?dDBXOTdZSkxMam9GOTVSYVdzaW9WTVJ1TG03dFowK0xzOGUzNTdHd2JCL3VJ?=
 =?utf-8?B?a3pNbVJ4VU50RmFvdndWK0I4Z2JFcVJRODdIRWhUU3J6RGxQeWNGK1pmRCtk?=
 =?utf-8?B?R3NpeVBPcEhhcno3MEYyTTZrQXo4aWFMY2JvdjhxZzlxRklidmZNbENnUmQ2?=
 =?utf-8?B?L1FTbm5XNVl4aXlDZmVRZnNOa1dweUp0UkJtUm5GelNvMzZJUVIyNWpOQ01h?=
 =?utf-8?B?RkJQSnUwTEUrYWZTR1dMSGlvdW04MGZPcFQxS0EzOHh0N0podjlzSEg2ZGVY?=
 =?utf-8?B?NXRNdXlPUlV5OUdYUmdZbmJrelRyR0orNFJudURHekNDYW9SY1ZoaEJNR0hD?=
 =?utf-8?B?L3FQb2pKYjIraWR1ajg0L0RpY0NmY1BteWxnRHBzcFNsNGRzdk40RHRJeUVl?=
 =?utf-8?B?SDRMOTh1dmJkNzdWOE9kdWozbXlINElEL2NsN3dNVkVHS2VWYUdTY2xBY0w3?=
 =?utf-8?B?aU9BbW5LMEtKcTZNek5tb2ZVOVJxYXAxVTdtS1RlWWtHM21PVGhxUHlFM2Fi?=
 =?utf-8?B?WVpFN0JDNVdWTGhpNzBsS1p1S1AyUkc5MWQxaEx2cyszQnBSQU1sY0pkbXhx?=
 =?utf-8?B?N0FCZTNsUDVpeWtjLzZzTlNNcWVRcFhoQkI3VWE3VkVLZlhFTmJjYU9wVWJC?=
 =?utf-8?B?MkhEd21Da2F0ZWcrM2xjZTRSRGlZQ1A1aUpndmMzd3RZQWY5RERBQ1ErVkZF?=
 =?utf-8?B?bXdkTTUvRUlVR3NjUkVCb3NteGVFKzZKWFZEUDBqRjMxRDlXMk5PMGQ4QmRM?=
 =?utf-8?B?NE0rTGJqMXJrTE5pbVdHVUpSRTREVnR5M3cyUGJ6M0hLQWR3MXkxV1NvQkRJ?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A633C83D392264E894595695119D1F4@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a6a942-5fbd-441a-79c4-08dd4aeaea0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 22:24:56.5752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETC9a+tCaqeK3mgBecZ43XVO974PonDU6jeP0zfe813FGnMtquXvqEWJHBnDfamtEQomwm0WY6rE98ssRKTjP2GM3TSdj67Tq+ufPNoJaWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9924
X-Proofpoint-ORIG-GUID: oZZQ_ek7KWuqeM5-yl1Chz1bHzUDMfbU
X-Authority-Analysis: v=2.4 cv=XaRzzJ55 c=1 sm=1 tr=0 ts=67abce3c cx=c_pps a=uYdjBAypVXkA+ZVpDPXefQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=meVymXHHAAAA:8 a=64Cc0HZtAAAA:8 a=s2bZmBFEbgtpRtOniDAA:9 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: oZZQ_ek7KWuqeM5-yl1Chz1bHzUDMfbU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_09,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gRmViIDExLCAyMDI1LCBhdCAxOjM54oCvUE0sIFN0ZXZlbiBSb3N0ZWR0IDxyb3N0
ZWR0QGdvb2RtaXMub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMTEgRmViIDIwMjUgMjE6MDg6
MjIgKzAwMDANCj4gSGFyc2hpdCBBZ2Fyd2FsIDxoYXJzaGl0QG51dGFuaXguY29tPiB3cm90ZToN
Cj4gDQo+PiBUaGFua3MgU3RldmUgZm9yIHRha2luZyBhIGxvb2suIFllcyB3ZSBzaG91bGQgaWRl
YWxseSByZW1vdmUgYW55IGNvbmRpdGlvbnMgdGhhdCBhcmUgDQo+PiBzdWJzdW1lZCBieSB0YXNr
ICE9IHBpY2tfbmV4dF9wdXNoYWJsZV90YXNrIGNvbmRpdGlvbiwgaG93ZXZlciBJIGFtIG5vdCBz
dXJlIGlmIGFueW9uZSAoc2F5IHR0d3UoKSkNCj4+IHdpbGwgdHJ5IHRvIG1vZGlmeSBw4oCZcyBz
dGF0ZSB3aXRob3V0IHJlbW92aW5nIGl0IGZyb20gdGhlIHB1c2hhYmxlIHRhc2tzIGxpc3QgZmly
c3QuIEluIHN1Y2ggYSBjYXNlDQo+PiBwaWNrX25leHRfcHVzaGFibGVfdGFzayB3aWxsIHN0aWxs
IHBpY2sgcCBhZ2FpbiBhbmQgdGhlbiBpdCB3aWxsIG1hdGNoIGFuZCB3aWxsIHByb2NlZWQgdG8g
ZG8gdGhlIG1pZ3JhdGlvbg0KPj4gd2hpbGUgdHR3dSgpIGlzIHRyeWluZyB0byB3YWtlIGl0IHVw
LiBNb3N0IGxpa2VseSwgc29tZSBhc3NlcnRzIGxpa2UgIXRhc2tfb25fcnFfcXVldWVkIGV0YyB3
aWxsIGJlIGhpdCBpbg0KPj4gcGlja19uZXh0X3B1c2hhYmxlX3Rhc2sgYXMgc29vbiBhcyBwIGlz
IHBpY2tlZC4gSWYgd2UgY2FuIGJlIHN1cmUgdGhhdCBw4oCZcyBzdGF0ZSBpcyBtb2RpZmllZCBi
eSBvdGhlcnMNCj4+IG9ubHkgYWZ0ZXIgaXQgYmVpbmcgcmVtb3ZlZCBmcm9tIHB1c2hhYmxlIHRh
c2tzIGxpc3Qgb2YgdGhpcyBDUFUgdGhlbiBpdCBzaG91bGQgYmUgc2FmZSB0byByZW1vdmUgaXQN
Cj4+IGVsc2Ugbm90Lg0KPiANCj4gTm90ZSB0aGF0IGFsbCB0YXNrcyBvbiB0aGUgcGlja19uZXh0
X3B1c2hhYmxlIGxpc3QgaXMgaW4gdGhlIHJ1bm5pbmcgc3RhdGUuDQo+IE5vdGhpbmcgc2hvdWxk
IGJlIHRyeWluZyB0byB3YWtlIGl0IHVwIHdoaWxlIGl0cyBvbiB0aGF0IGxpc3QuIFRoYXQgaXMs
IGlmDQo+IHAgaXMgc3RpbGwgb24gdGhlIHB1c2hhYmxlIHRhc2tzIHRoZW4gZXZlcnl0aGluZyBz
aG91bGQgYmUgc3RpbGwgZmluZS4NCj4gRXNwZWNpYWxseSBub3cgdGhhdCB0aGUgcnEgbG9ja3Mg
YXJlIHN0aWxsIGhlbGQgYWdhaW4uDQo+IA0KPiBJIHRoaW5rIHRoYXQgaXMgdGhlIG9ubHkgY2hl
Y2sgd2UgbmVlZC4gVGhlIGlzX21pZ3JhdGlvbl9kaXNhYmxlZCgpIGNoZWNrDQo+IHNob3VsZCBw
cm9iYWJseSBiZSBjaGVja2VkIGVhcmxpZXIsIGFzIHRoZSBvbmx5IHdheSBpdCBjb3VsZCBiZSBz
ZXQgaXMgaWYNCj4gdGhlIGN1cnJlbnQgdGFzayBwcmVlbXB0ZWQgaXQuIElmIGl0IGhhZCBtaWdy
YXRlZCwgYW5kIG1pZ3JhdGVkIGJhY2ssIGl0DQo+IGNvdWxkbid0IGhhdmUgdGhhdCBzZXQgb24g
dGhpcyBjdXJyZW50IENQVSBvdGhlcndpc2UgaXQgd291bGQgbm90IGhhdmUNCj4gbWlncmF0ZWQu
DQo+IA0KPiBIZXJlJ3MgdGhlIGN1cnJlbnQgY2hlY2tzIGFnYWluOg0KPiANCj4gaWYgKHVubGlr
ZWx5KHRhc2tfcnEodGFzaykgIT0gcnEgfHwNCj4gICAgICFjcHVtYXNrX3Rlc3RfY3B1KGxvd2Vz
dF9ycS0+Y3B1LCAmdGFzay0+Y3B1c19tYXNrKSB8fA0KPiAgICAgdGFza19vbl9jcHUocnEsIHRh
c2spIHx8DQo+ICAgICAhcnRfdGFzayh0YXNrKSB8fA0KPiAgICAgaXNfbWlncmF0aW9uX2Rpc2Fi
bGVkKHRhc2spIHx8DQo+ICAgICAhdGFza19vbl9ycV9xdWV1ZWQodGFzaykpKSB7DQo+IA0KPiAN
Cj4gTGV0J3MgbG9vayBhdCBwaWNrX25leHRfcHVzaGFibGVfdGFzaygpOg0KPiANCj4gcCA9IHBs
aXN0X2ZpcnN0X2VudHJ5KCZycS0+cnQucHVzaGFibGVfdGFza3MsDQo+ICAgICAgc3RydWN0IHRh
c2tfc3RydWN0LCBwdXNoYWJsZV90YXNrcyk7DQo+IA0KPiBCVUdfT04ocnEtPmNwdSAhPSB0YXNr
X2NwdShwKSk7DQo+IEJVR19PTih0YXNrX2N1cnJlbnQocnEsIHApKTsNCj4gQlVHX09OKHRhc2tf
Y3VycmVudF9kb25vcihycSwgcCkpOw0KPiBCVUdfT04ocC0+bnJfY3B1c19hbGxvd2VkIDw9IDEp
Ow0KPiANCj4gQlVHX09OKCF0YXNrX29uX3JxX3F1ZXVlZChwKSk7DQo+IEJVR19PTighcnRfdGFz
ayhwKSk7DQo+IA0KPiBJZiB0YXNrX3JxKHRhc2spICE9IHJxIGlzIHRydWUsIHRoZW4gQlVHX09O
KHJxLT5jcHUgIT0gdGFza19jcHUocCkpIHdvdWxkIHRyaWdnZXIuDQo+IA0KPiAgIWNwdW1hc2tf
dGVzdF9jcHUobG93ZXN0X3JxLT5jcHUsICZ0YXNrLT5jcHVzX21hc2sNCj4gDQo+IFdlIHN0aWxs
IG5lZWQgdGhhdCBjaGVjaywgdG8gbWFrZSBzdXJlIHRoZSBDUFUgd2UgcGlja2VkIGlzIGluIHRo
ZSB0YXNrJ3MgYWZmaW5pdHkuDQo+IA0KPiBJZiB0YXNrX29uX2NwdShycSwgdGFzaykgaXMgdHJ1
ZSwgdGhlbiBCVUdfT04odGFza19jdXJyZW50KHJxLCBwKSkgd291bGQgdHJpZ2dlci4NCj4gDQo+
IElmICFydF90YXNrKHRhc2spIGlzIHRydWUgdGhlbiBCVUdfT04oIXJ0X3Rhc2socCkpIHdvdWxk
IHRyaWdnZXIuDQo+IA0KPiAgIGlzX21pZ3JhdGlvbl9kaXNhYmxlZCh0YXNrKQ0KPiANCj4gSXMg
c3RpbGwgbmVlZGVkLCBidXQgY291bGQgcG9zc2libHkgYmUgbW92ZWQgdXA/ICh1bnJlbGF0ZWQg
Y2hhbmdlIHRob3VnaCkNCj4gDQo+IElmICF0YXNrX29uX3JxX3F1ZXVlZCh0YXNrKSBpcyB0cnVl
IHRoZW4gQlVHX09OKCF0YXNrX29uX3JxX3F1ZXVlZChwKSkgd291bGQgdHJpZ2dlci4NCj4gDQo+
IFRodXMsIEkgdGhpbmsgd2UgY2FuIGNoYW5nZSB0aGF0IGNvbmRpdGlvbiB0byBqdXN0Og0KPiAN
Cj4gaWYgKGlzX21pZ3JhdGlvbl9kaXNhYmxlZCh0YXNrKSB8fA0KPiAgICAhY3B1bWFza190ZXN0
X2NwdShsb3dlc3RfcnEtPmNwdSwgJnRhc2stPmNwdXNfbWFzaykgfHwNCj4gICAgdGFzayAhPSBw
aWNrX25leHRfcHVzaGFibGVfdGFzayhycSkpIHsNCj4gDQo+IEkgbW92ZWQgdGhlIGlzX21pZ3Jh
dGlvbl9kaXNhYmxlZCgpIHVwIGFzIHRoYXQncyB0aGUgcXVpY2tlc3QgY2hlY2suIElmDQo+IHRo
YXQncyB0cnVlLCBubyBuZWVkIHRvIHRlc3QgdGhlIG90aGVyIGNvbmRpdGlvbnMuDQo+IA0KPiAt
LSBTdGV2ZQ0KDQpNYWtlcyBzZW5zZSBhbmQgdGhhbmtzIGZvciBhbGwgdGhlIGRldGFpbHMuIFRo
aXMgc2ltcGxpZmllcyBpdC4gDQpJIHdpbGwgbWFrZSB0aGlzIGNoYW5nZSBhcyBwZXIgeW91ciBz
dWdnZXN0aW9uIGFuZCBzZW5kIHRoZQ0KdXBkYXRlZCBwYXRjaCBhZnRlciB0ZXN0aW5nIGl0Lg0K
DQpSZWdhcmRzLA0KSGFyc2hpdA==

