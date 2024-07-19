Return-Path: <linux-kernel+bounces-256917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F02C937275
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 04:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C34D282190
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839C6DDB2;
	Fri, 19 Jul 2024 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ORiJ8KG3"
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394008F77
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721356202; cv=fail; b=drXrK6TDmV1DkNEWAXCIqee5ZqeeAdMYzf47hPzGrY/0+QvgL88gaaAya23EUXfoyMjWXI+JClOUWqDPtz0SMAfbQqvoK4o25Hgw0X4DDw822bVQ5NCjkVyy4/l0X/TpQdmAcMRGQeyl+3ZsAZqePzZU8uJqjhNumt3iZROf5Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721356202; c=relaxed/simple;
	bh=nx/lnm1XrFgWoITjA0AIxCUz2eXZFpvPa9R1NEvnck0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CBKuiCn3E1A04M7AWJYAf5vu+XLsH331E00LucGQU8qWNsmuouPd2VB0X3HF/mga8+Vqj+Xs0Nhy88zGc/nT4fbczy2F/4JevBVZugK5R9FUr94Vmvtr8xq9qn0giIspwu40ctGkhiwAu8cx4NzmEbGw90Wj/x8yhvKf1V3rBFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ORiJ8KG3; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1721356200; x=1752892200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nx/lnm1XrFgWoITjA0AIxCUz2eXZFpvPa9R1NEvnck0=;
  b=ORiJ8KG3/dnEDwHkPdlvpTPc4oFfDKISHNVCnBRCTBEec88nJINCjViV
   PiXMrcdXb6mfb/kjh/XrWqQLJ/qNaaQQX2lufJOb+9WUzGZyVKs5CKi2x
   /pQJklm26VhSMXxU8xtEI9rtbhnBl4nNjg4KXA8iaWoACLF3eVKxijokD
   PFmeBGPhCdYvrfjEIn/00/XR5iN10lB5ES1MXZbS5xS+gYDtVmfu3oqBK
   hcV9SJT8AFQRSU/VAlBajZiQUUsZTY0MJGGdXRGmvq8EVT+3GlkY611Up
   7rHX+XJu1FCqeIRZ719lwsCm8YpJ6ehfdRepHpCeioDVFPaLbq3ue2Hl9
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="125935334"
X-IronPort-AV: E=Sophos;i="6.09,219,1716217200"; 
   d="scan'208";a="125935334"
Received: from mail-japaneastazlp17010007.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 11:28:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdGH5lvnA3B+HGKT7Ud6jp1VFJY0eRInmtU7OaqKwAJLA6lFZOQPvR4XwvjG6RDlSoMt8SXR0c4JwxxJP86Ml3wuNbqZhK47VtL2f0hbnsG5QsEUA4pR2ocUzKLVwhVhy8KyzYiuTUqG9duGRMHQwXJqdWt8klL9IRWxMvgQNTIiecT9byPMQzQ3OEHUXHrlUOxa5J161KE1WEibLXo2/lWUNUJYsk6/BhnIKkdQeWATegy7dh6Mybzoy7Nh6XKfSyH8Uiy/kUavkZcLO6ANaXtcMrC5H1GK1bcbpL5+6s7NxRefIjshG/zSV4vd3QIYQ+DwVAkMPKhK8fde9U5P/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nx/lnm1XrFgWoITjA0AIxCUz2eXZFpvPa9R1NEvnck0=;
 b=bmGgAu0Op+k7GTIN8htxpUmjrfpXC+93Due74pR6IrIQ6/uUXiPe0mgyZD90uMdw6mwuVUavuC5h/mlqIRtSBHUarZt5sBUhoniEns82yAiYxrj4GEcUqKDhBnIa7ekIhZR1vodXK8x0P6kgpXAHMkYwEHf+JmTe18WKwbKMD8FUKx+ELNFRW/5WvonChSIhZSu54uK8uNMTAU5FQQ4Y4uKzep5TxTFk9+SXDHXVRGMZs4VCHXUhUFpNcdqbHCl7urbY5IRK/v0r3mLBQArjbtR/8tvomWfM21L5O8rduFf1/iAPYlwDOvqp8m8zawglFf0hzQlnGs69mMSIYDnv2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com (2603:1096:403:11::17)
 by TYWPR01MB11831.jpnprd01.prod.outlook.com (2603:1096:400:3fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 19 Jul
 2024 02:28:44 +0000
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14]) by TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14%3]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 02:28:44 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: David Hildenbrand <david@redhat.com>, "Vlastimil Babka (SUSE)"
	<vbabka@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yasunori
 Gotou (Fujitsu)" <y-goto@fujitsu.com>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH RFC] mm/page_alloc: Fix pcp->count race between
 drain_pages_zone() vs __rmqueue_pcplist()
Thread-Topic: [PATCH RFC] mm/page_alloc: Fix pcp->count race between
 drain_pages_zone() vs __rmqueue_pcplist()
Thread-Index: AQHa11NW3pL1b9y1ckCNsMjFZY8jfrH8WT+AgAAueYCAANBegA==
Date: Fri, 19 Jul 2024 02:28:43 +0000
Message-ID: <dcf9958e-a5ae-4219-87ba-b9833d2c1cf2@fujitsu.com>
References: <20240716073929.843277-1-lizhijian@fujitsu.com>
 <6f2151a9-da23-4917-b985-8de6b0852e37@kernel.org>
 <ad628e27-6a8f-471e-b3d1-3ea77a97e090@redhat.com>
In-Reply-To: <ad628e27-6a8f-471e-b3d1-3ea77a97e090@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1566:EE_|TYWPR01MB11831:EE_
x-ms-office365-filtering-correlation-id: b3bd8a0e-b6d8-456d-5e5f-08dca79a82c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFlSanF2S0pFS0Q0MG0wYUdha2VKbnEyT3JMRUh6MkFVRlVDUU5xUVcrRHA5?=
 =?utf-8?B?a0lwT3dtRkFqb29zY3hCUlc1bE9lWkU4MXBLZFpmK0NVRFVDWStia2VUNU43?=
 =?utf-8?B?cFV6MkFNd1NJUHNpdWgrcElSbXNUSkJCa294S01TVkdnODZLbHU1RWZtZXFu?=
 =?utf-8?B?cjZGRy9aK0tBUnhrdW80YWNNL1o3VEhzZWpnMDlhMW5WTU5ZeVlEWmdEb3F1?=
 =?utf-8?B?eVc2OVJ1NGlVZWxsV200cVQwdzAxamZHUnRpdGUxREFSZ2RBd01TQkpzaXZZ?=
 =?utf-8?B?T2UyYTZ3R2wyNytGcitxd3hpeHV3OUVzZEJlUW92TGNWUFpKK0VJeHpSNEdo?=
 =?utf-8?B?TkZJUnhiVktRaHZqSmd3R0JmRkJtSk1UOXdBSkxEOGpDUWlubXZpc2hObTlm?=
 =?utf-8?B?MU85dkxmU3RkL1BqYzNuSGxsNHVKemplZTBNa2hZUkRFbVdobENXMTRFWTFq?=
 =?utf-8?B?QVhjZ3c1U1hFOS93dWdZc3F2Y2RZUmVWS05pYTNadHp4UGdHTHB2em9FSWhY?=
 =?utf-8?B?VlU4MktuNnRyb1ByRkw5UldRbUNxTHJlSThnMWZRSnh1Q0MzL1h1UmloUGU3?=
 =?utf-8?B?ZklPUk15eWNhb29XaFpwcjlXRytuZ3RIVFR6T3ZVQ1RoeFdBTXhTMmJoRWdM?=
 =?utf-8?B?Q1FHblZDQ1Btd2lNWW50eldpc3E1T2xNdHFoWXZJZTNsNVAzZVNiKzdNNWxW?=
 =?utf-8?B?ekNvWG8wQXZDN1J1OXZMbjNiVFhFRkpqZFp4Q1VWd05iZVJzMmpDbVlJTXB3?=
 =?utf-8?B?NWVPdlczdzFrMnpKQ21JcDBZVXA0bGxsdTNyNmY3TldWWW44YmJrLzhnZGVT?=
 =?utf-8?B?ZFNDL1NwK3VRVEdjN3dwSTJORUhGNFdLUFR4VU41T21TTTlkTzJNOEtGTS9Z?=
 =?utf-8?B?bGtvUnJWejRLR0RXZ3VJUjNPZ1pYMWZXdFZvaCt1S3Y3NG5jaUlHYzBsallk?=
 =?utf-8?B?NnRYZEgyb29ZalUwWFlZUEZYcDRiMTNjTWZyNHRSeVlWR2VwcXNScXBsTHlH?=
 =?utf-8?B?YWRzYWNyYWFvZjRsYlc3NHZYWmVFanY5ZUlLM2FrOHhyY0ZkNDk1RUlaeW93?=
 =?utf-8?B?VGY0MXl3WTZpQllCZUVvcEtoRDAwZFZ1bTBZZzZsYi93N1cxUUkxT2pJcy9X?=
 =?utf-8?B?dlB0ZzRvR3NyeXdFR2Ezano1R3kyTzNtR2ZvTHoxbUlaeXV1YTM2UGxyUGV6?=
 =?utf-8?B?anNleStmRmtQT1RIb0VPOVFFaTdvS0lqejVGRk5Ob0FpV3FkeHdvM1o5UlB4?=
 =?utf-8?B?bEZaRWlkTzJESi9WUHo4c2pncHpKS2doRkxvOTI5WTg2cWc3eVVFYlVBV2xa?=
 =?utf-8?B?M2cyU0tXck5lUUpxR0orTmhXOXZnbDF6MGMzV3VCRTdVVTkyVWV6cmxqTCtW?=
 =?utf-8?B?bHpDOGc3WU1hTnFvRDNWbThrNUMyQ29mYmxJTUx2VlRsVzAzaGl6VEo0eXQ5?=
 =?utf-8?B?UmdvRVBiYkJLNWVlZW9kUm53UFpZU1RIcmVwOVgzWmE2T0RlY0IzRmVIT25M?=
 =?utf-8?B?c0NIM0ZoUk1KNEcvVkFVbjZRc1RNZlhCY3VlaUZoK0lhTG9lZjBxUXFwQnFP?=
 =?utf-8?B?WWo0b25MWVhidTM3cW12bVBRQWtvRkhHdHo0THk5Z3c1UjJTK1AvUjh2UWNX?=
 =?utf-8?B?K3NrRTM2TE9sZkdEV2xtUTJGNjJMZUsvMkJwQVZLT2QyR1p4ak1Pd0x1eHEr?=
 =?utf-8?B?S0oxaUZKUHZsUEpkU0lQOVNidDdCZXdyOFk5OUY5RUp2RVpPMHhyV0ZrS1VG?=
 =?utf-8?B?QkNWVFJ3U05iU0JHa3lqdzczZ0oxL3dvQ3ZuZ3lYNmpFbWlyQzZQMzF1MUZF?=
 =?utf-8?B?aDkzemFyUDMzbTR0MEEyQUd4bTFkRFFubGtHQTRRQWErVStCMm1ZMnRhaXpF?=
 =?utf-8?Q?tvf/9f8TJNrzN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1566.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1owaHJSdk9CUGxvYWZLRXV0QVVjM1RQSHZlOW9mZk9XNjBvTjFZd0FEbGRs?=
 =?utf-8?B?VVFsRHgvMmVkUkJ1em9NMDlNMTVoYjZTK3U5QWtTckF5WVNFSUpHWkZ2TzBn?=
 =?utf-8?B?Z1VoY00zSEc1bnJJMFJ3THJ0bmIxSUFjUVBDbDhVSlREQWRyaG5hSXRWSzcv?=
 =?utf-8?B?YldTM0o4c20wSXlDb1RyK1dMQkgrWXZMOGlzNnZyM0dKTGJ3YnpZakRyQ3lT?=
 =?utf-8?B?YklSMjhJZnhKeDdtN1BMaEVtUXN5L2x5QVNTdmpyS0E0WEdoaGoxV0tYVy9Q?=
 =?utf-8?B?emc1TGRZcEVKNyt3RTVZNHZOQ0dzdW55NHluMmE3bXN2K1J6OW96NjdmRVRG?=
 =?utf-8?B?cUVVbnJlTXkyUFdyek9oVTdmRENFSnY5a3RuL1dRUS9iZmxQeXZwTnRpMEJv?=
 =?utf-8?B?N08wbXMwYmRKVnFUektKaXYwcDdNVTNGVUFCaVI2UnhnM3B1VU1idDl5K0RV?=
 =?utf-8?B?akRlOUs0d0JlUlhCUkhkd3lvYmhoM1RxQnQxbFdjVmdPVnRhRmVkNEtGNU0w?=
 =?utf-8?B?dDhDY1NyNzNXUlpHTGREdllKT0JJS2wzTGlOcFE0L0VvSkF4Y1NjL044WE1o?=
 =?utf-8?B?TnFUQm5pQzRUa2dReTY2ZzArcXRrOUF4eGNkWkdJMnVUU0pjcTU5K0s2Wi9Q?=
 =?utf-8?B?QlliUXRSZktIdFRLdURFWkp2RWwrZTgwWXp0dWI4VVRmM3hPYzFEQlhWNytN?=
 =?utf-8?B?K01uMUNXUkJFdzVSeDFwNnpUNlh6WlA1OTZLVDZOM2M3ODdIbFB3WjlDc0s1?=
 =?utf-8?B?ODAxdVlOYjZrTGE0NEV2UjZNdEpKWHJjMUpSci9GKzQ0LzV6b1BadU9zWW9X?=
 =?utf-8?B?MnlVRVcwenRMSGtOY1BWamhjUGs5S1NUeG1sdlRTN3pEN05WcXJDZk85T09R?=
 =?utf-8?B?eml4NVQvaHUwazNiUlRnOC9Mb2k1UVIzNE1qOVZLMzdpQVowNVF2TXc0czFm?=
 =?utf-8?B?MmNCbmdxUG10d25MQWFpQkRKeklQNStkMW5mZW51aVltR0tEb1JIT2JWWVJM?=
 =?utf-8?B?di9ZbG1URGVoTlZCZ205N1NwcGwyaGJ5RUtEbElBeTZFNlVQbnpOaEdVZitJ?=
 =?utf-8?B?OGQvN1JhTFE2MUxSUS9NRzJrSFBVU1FMRVVHRHFnSUQxUSsybEZKMnBHVjNa?=
 =?utf-8?B?cGl6UG9SUHlEbkVLRjNsMWtNSW1kMG5NNE1iSExIZVduVDREVGFYVWtBWkE3?=
 =?utf-8?B?SXZ6Q2JQWGFwMnZLTHdkWFZEQUgyMC9kbkl5ZjQ5dnpmZ3pCZE5qbUFlQXc5?=
 =?utf-8?B?V2prQzNUUVZJL01CV3J1QWNydWpIN0JUOXVmbklOVVV1OVd4d2RTNWJXVS81?=
 =?utf-8?B?SmtsN0RabjE3cURqeWVPYjFGRk9EU2p4YlVtcW9ZWm05MGRLbmJWeHJKMXFv?=
 =?utf-8?B?SE1aSW5UY3dISTdPTU1xTXNuWXFmeTViVUpOUGNHMVZmNGZ1amgrZTFNWVMy?=
 =?utf-8?B?L0FCNVZKWWk4THhVQm1XOHVTNmtaamtySnNGTUo0dkRFbGE5cFJWWE82N2FF?=
 =?utf-8?B?RnVKRjcxTVRJS0thMjlIMm43enhlQzA5aDhEMEt1UlV3NndMNFBCd3JrM0F6?=
 =?utf-8?B?cGRuOXhHQ0N2b0VIWGMrOTVrQXZkSzRxR0NzUElucWRUSUxvYUljWW9zS3Jr?=
 =?utf-8?B?dGNWejdqcGZpWEhOU2FCOUh1N0xxZkFOSjRHanpHMHpKMFpxRmprTlp3cTN4?=
 =?utf-8?B?TmcxSCs3ek1wRUVMSkxKUVlPM210Z1lYZHRTamorMXN6VkV0R1B3U2hlME5Y?=
 =?utf-8?B?bE5Lekd6ZDZoVHJlUWhXa1hXeW9QSUdNRWppcms4NnBrOFRmYUZnZzd2bE9S?=
 =?utf-8?B?Z29OMCtqbHZXSWhsZlJXcnRDRUZta3gwb0VneXBsN09kTW9kaTVlZFdUZnRC?=
 =?utf-8?B?SmdVOWVtMTBCeisyT3Vpdi9nYk9udjMxZzBOaUU1S2MxZWxCYlE2VytFZHF5?=
 =?utf-8?B?RzcrRlNuN0ZySUxEb2NnUnRSeGMxZWdtVjlWNXNkRDlQRXZhbVBQQ3luYit5?=
 =?utf-8?B?ZXpGcEtpYUlsWmhnU25JN0sxT3hwOVRwK1FFbm00VEl3dTVNRUUrK20wVmc2?=
 =?utf-8?B?ZFlhd1JnZUt0WXcvMVJHM09LekJNMHR4aHE0amwyWGZzQU9ydG5PQ1RFZjZV?=
 =?utf-8?B?WVVTOUVZZDZ0Uk5LVmdnV2VLUTFjSlBzNC9adDBpRWVjcGd2QnJlVjRjR24v?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <576CC46031750A4088D1ECD25D793884@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b44cou0HVXYyZX4vkYvTyzzS8k05/t9XW2OrcnaHLZHqZTeMGpRMYCTuRhJr4J20I5oxGYhq+NFfcds38ielN2Ckwuw1krtxOdgO2hAZDU70UjAA3SLGxD7JjXe+oW4XNTZmFI+lme+0gOiUfc3RWPvrJBLjo5zCo8CV9I7KQAKmjShK+/sVnwpTX8Hup2pQRWMQAKhshX41U57SIu0+NsN4QjFwNHwA03XpALDnnGq9+M/ouYANG1VLDSViW3ObdEVD4hbP3JWLBApf/oC43Wfs9YJCXZpAZvue5lE8lO571DaV/Q8PNyHX/t+diIj7FDfJaZm/FF0NbnMVrJ7elK6lVMaEcOcwkfp4mqbGqTG2fdxVSv5itqmG26N+b/vvGaw1XxiO5gNt7v7vmSLcEImHUsNoLZHQOwX4EWzNngTsQrbsda+aq0SW6DS6vODEBhtQRP5UWZZQwuoW8/kj8KGbdPLOK6YwSK7s9NCG+qbgNwW94FbtlPyBerz2zWBYHOx0dWtq3JEW2noK8MK/PtY9C4C5vK0c++iaf4WUBYYv22/dn9yBx5qUpVL7Ml+FffdSKYT0GH31zPJ42jNAnyC4u8uJRgnTioeCKn0ryOD0V9WTKRByJNg2oXimmJex
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1566.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bd8a0e-b6d8-456d-5e5f-08dca79a82c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 02:28:44.0252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EUpAucKdmxwOniPDjKWkJj8S7iIUvR8KqBGb6dQnsD79JgL/aHPnuP6DumIDMYn6yR9fmBj7IlT4nzhCM9qApg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11831

DQoNCk9uIDE4LzA3LzIwMjQgMjI6MDIsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPiBPbiAx
OC4wNy4yNCAxMzoxNiwgVmxhc3RpbWlsIEJhYmthIChTVVNFKSB3cm90ZToNCj4+IE9uIDcvMTYv
MjQgOTozOSBBTSwgTGkgWmhpamlhbiB3cm90ZToNCj4+PiBJdCdzIGV4cGVjdGVkIHRoYXQgbm8g
cGFnZSBzaG91bGQgYmUgbGVmdCBpbiBwY3BfbGlzdCBhZnRlciBjYWxsaW5nDQo+Pj4gem9uZV9w
Y3BfZGlzYWJsZSgpIGluIG9mZmxpbmVfcGFnZXMoKS4gUHJldmlvdXNseSwgaXQncyBvYnNlcnZl
ZCB0aGF0DQo+Pj4gb2ZmbGluZV9wYWdlcygpIGdldHMgc3R1Y2sgWzFdIGR1ZSB0byBzb21lIHBh
Z2VzIHJlbWFpbmluZyBpbiBwY3BfbGlzdC4NCj4+Pg0KPj4+IENhdXNlOg0KPj4+IFRoZXJlIGlz
IGEgcmFjZSBjb25kaXRpb24gYmV0d2VlbiBkcmFpbl9wYWdlc196b25lKCkgYW5kIF9fcm1xdWV1
ZV9wY3BsaXN0KCkNCj4+PiBpbnZvbHZpbmcgdGhlIHBjcC0+Y291bnQgdmFyaWFibGUuIFNlZSBi
ZWxvdyBzY2VuYXJpbzoNCj4+Pg0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBDUFUwwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDUFUxDQo+
Pj4gwqDCoMKgwqAgLS0tLS0tLS0tLS0tLS0tLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC0tLS0tLS0tLS0tLS0tLQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Bpbl9s
b2NrKCZwY3AtPmxvY2spOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19ybXF1ZXVlX3BjcGxp
c3QoKSB7DQo+Pj4gem9uZV9wY3BfZGlzYWJsZSgpIHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAvKiBsaXN0IGlzIGVtcHR5ICovDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KGxpc3RfZW1wdHkobGlzdCkpIHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyog
YWRkIHBhZ2VzIHRvIHBjcF9saXN0ICovDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGFsbG9jZWQgPSBybXF1ZXVlX2J1bGsoKQ0KPj4+IMKgwqAgbXV0ZXhfbG9jaygmcGNwX2JhdGNo
X2hpZ2hfbG9jaykNCj4+PiDCoMKgIC4uLg0KPj4+IMKgwqAgX19kcmFpbl9hbGxfcGFnZXMoKSB7
DQo+Pj4gwqDCoMKgwqAgZHJhaW5fcGFnZXNfem9uZSgpIHsNCj4+PiDCoMKgwqDCoMKgwqAgLyog
cmVhZCBwY3AtPmNvdW50LCBpdCdzIDAgaGVyZSAqLw0KPj4+IMKgwqDCoMKgwqDCoCBjb3VudCA9
IFJFQURfT05DRShwY3AtPmNvdW50KQ0KPj4+IMKgwqDCoMKgwqDCoCAvKiAwIG1lYW5zIG5vdGhp
bmcgdG8gZHJhaW4gKi8NCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogdXBkYXRl
IHBjcC0+Y291bnQgKi8NCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGNwLT5jb3Vu
dCArPSBhbGxvY2VkIDw8IG9yZGVyOw0KPj4+IMKgwqDCoMKgwqDCoCAuLi4NCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC4uLg0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJnBj
cC0+bG9jayk7DQo+Pj4NCj4+PiBJbiB0aGlzIGNhc2UsIGFmdGVyIGNhbGxpbmcgem9uZV9wY3Bf
ZGlzYWJsZSgpIHRob3VnaCwgdGhlcmUgYXJlIHN0aWxsIHNvbWUNCj4+PiBwYWdlcyBpbiBwY3Bf
bGlzdC4gQW5kIHRoZXNlIHBhZ2VzIGluIHBjcF9saXN0IGFyZSBuZWl0aGVyIG1vdmFibGUgbm9y
DQo+Pj4gaXNvbGF0ZWQsIG9mZmxpbmVfcGFnZXMoKSBnZXRzIHN0dWNrIGFzIGEgcmVzdWx0Lg0K
Pj4+DQo+Pj4gU29sdXRpb246DQo+Pj4gRXhwYW5kIHRoZSBzY29wZSBvZiB0aGUgcGNwLT5sb2Nr
IHRvIGFsc28gcHJvdGVjdCBwY3AtPmNvdW50IGluDQo+Pj4gZHJhaW5fcGFnZXNfem9uZSgpLCBl
bnN1cmluZyBubyBwYWdlcyBhcmUgbGVmdCBpbiB0aGUgcGNwIGxpc3QuDQo+Pj4NCj4+PiBbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vNmEwNzEyNWYtZTcyMC00MDRjLWIyZjkt
ZTU1ZjNmMTY2ZTg1QGZ1aml0c3UuY29tLw0KPj4+DQo+Pj4gQ2M6IERhdmlkIEhpbGRlbmJyYW5k
IDxkYXZpZEByZWRoYXQuY29tPg0KPj4+IFJlcG9ydGVkLWJ5OiBZYW8gWGluZ3RhbyA8eWFveHQu
Zm5zdEBmdWppdHN1LmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+DQo+Pj4gLS0tDQo+Pj4gwqAgbW0vcGFnZV9hbGxvYy5jIHwgNyArKysr
LS0tDQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9tbS9wYWdlX2FsbG9jLmMgYi9tbS9wYWdlX2FsbG9j
LmMNCj4+PiBpbmRleCA5ZWNmOTkxOTBlYTIuLjE3ODBkZjMxZDVmNSAxMDA2NDQNCj4+PiAtLS0g
YS9tbS9wYWdlX2FsbG9jLmMNCj4+PiArKysgYi9tbS9wYWdlX2FsbG9jLmMNCj4+PiBAQCAtMjMy
MywxNiArMjMyMywxNyBAQCB2b2lkIGRyYWluX3pvbmVfcGFnZXMoc3RydWN0IHpvbmUgKnpvbmUs
IHN0cnVjdCBwZXJfY3B1X3BhZ2VzICpwY3ApDQo+Pj4gwqAgc3RhdGljIHZvaWQgZHJhaW5fcGFn
ZXNfem9uZSh1bnNpZ25lZCBpbnQgY3B1LCBzdHJ1Y3Qgem9uZSAqem9uZSkNCj4+PiDCoCB7DQo+
Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgcGVyX2NwdV9wYWdlcyAqcGNwID0gcGVyX2NwdV9wdHIoem9u
ZS0+cGVyX2NwdV9wYWdlc2V0LCBjcHUpOw0KPj4+IC3CoMKgwqAgaW50IGNvdW50ID0gUkVBRF9P
TkNFKHBjcC0+Y291bnQpOw0KPj4+ICvCoMKgwqAgaW50IGNvdW50Ow0KPj4+ICvCoMKgwqAgc3Bp
bl9sb2NrKCZwY3AtPmxvY2spOw0KPj4+ICvCoMKgwqAgY291bnQgPSBwY3AtPmNvdW50Ow0KPj4+
IMKgwqDCoMKgwqAgd2hpbGUgKGNvdW50KSB7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGludCB0
b19kcmFpbiA9IG1pbihjb3VudCwgcGNwLT5iYXRjaCA8PCBDT05GSUdfUENQX0JBVENIX1NDQUxF
X01BWCk7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGNvdW50IC09IHRvX2RyYWluOw0KPj4+IC3C
oMKgwqDCoMKgwqDCoCBzcGluX2xvY2soJnBjcC0+bG9jayk7DQo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGZyZWVfcGNwcGFnZXNfYnVsayh6b25lLCB0b19kcmFpbiwgcGNwLCAwKTsNCj4+PiAtwqDC
oMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJnBjcC0+bG9jayk7DQo+Pj4gwqDCoMKgwqDCoCB9DQo+
Pj4gK8KgwqDCoCBzcGluX3VubG9jaygmcGNwLT5sb2NrKTsNCj4+DQo+PiBUaGlzIHdheSBzZWVt
cyB0byBiZSBwYXJ0aWFsbHkgZ29pbmcgYWdhaW5zdCB0aGUgcHVycG9zZSBvZiA1NWY3N2RmN2Q3
MTUNCj4+ICgibW06IHBhZ2VfYWxsb2M6IGNvbnRyb2wgbGF0ZW5jeSBjYXVzZWQgYnkgem9uZSBQ
Q1AgZHJhaW5pbmciKSAtIHRoZSB6b25lDQo+PiBsb2NrIGhvbGQgdGltZSB3aWxsIHN0aWxsIGJl
IGxpbWl0ZWQgYnkgdGhlIGJhdGNoLCBidXQgbm90IHRoZSBwY3AgbG9jaw0KPj4gdGltZS4gSXQg
c2hvdWxkIHN0aWxsIGJlIHBvc3NpYmxlIHRvIHJlbG9jayBiZXR3ZWVuIHRoZSBpdGVyYXRpb25z
PyBUbw0KPj4gcHJldmVudCB0aGUgcmFjZSBJIHRoaW5rIHRoZSBtYWluIHBhcnQgaXMgZGV0ZXJt
aW5pbmcgcGNwLT5jb3VudCB1bmRlciB0aGUNCj4+IGxvY2ssIGJ1dCByZWxlYXNlL3JldGFrZSBz
aG91bGQgc3RpbGwgYmUgb2sgaWYgdGhlIHBjcC0+Y291bnQgaXMgcmVyZWFkDQo+PiBhZnRlciBy
ZWxvY2tpbmcuDQoNCk9rYXksIEkgd2lsbCB0cnkgaXQuDQoNCj4gDQo+IEFncmVlZCwgaGFkIHRo
ZSBzbWFtZSB0aGluZyBpbiBtaW5kIHdoZW4gc2tpbW1pbmcgb3ZlciB0aGlzIHBhdGNoLg0KDQoN
Cj4gDQo+IEBMaSwgd2l0aCB0aGlzIHBhdGNoIHRoZSBwcm9ibGVtcyB5b3UgaGF2ZSBiZWVuIHNl
ZWluZyBhcmUgZnVsbHkgcmVzb2x2ZWQsIGNvcnJlY3Q/DQo+IA0KDQpZZWFoLCBJdCB3b3JrZWQg
aW4gbXkgdGhvdXNhbmQgdGVzdCBydW5zLg0KDQpQLlMsIFByZXZpb3VzbHksIEl0IG9jY3VycmVk
IG1vcmUgdGhhbiA1JS4NCg0KDQo=

