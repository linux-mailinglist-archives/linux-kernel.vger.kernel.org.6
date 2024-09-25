Return-Path: <linux-kernel+bounces-338291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F189855F5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9191F26732
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F98815B135;
	Wed, 25 Sep 2024 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="BU5+TVu7"
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FDD139579
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254803; cv=fail; b=biv3Kd3cUG1VfM4L63wIS7LSaTAf04l8ESLoijay/YhUgf/t33+zhUR1ybNuUY/JHoKaw/lJvR9803KQUfKWAsMkQ+P+eV3YNcqRXekoEHC1Zd+KjA0HjfD8ipwhGbGMN273F8OA6HzJZ8hcdauuBDpr4NxnI9UKgDPols3m+js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254803; c=relaxed/simple;
	bh=BY7n8DWYbjvb+6nmiVsJBKFpysPueQ9mu50BEYHGVyc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BfEY6L7slD8DYwWWSmQuhOX1wJPNby6n75UZmR//TQyUd6xLWdLakM9o/wEwSEBypsluOosc3NF/1k2WH7iqvomjDUMs8fOsmNMDGKK4quezDLh1ZMcATYsusXGdVpoVQ4BtSTZ0xA3ut8crD8f4wnzs8QzPGOW68NIOJ+GpDFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=BU5+TVu7; arc=fail smtp.client-ip=216.71.158.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1727254802; x=1758790802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BY7n8DWYbjvb+6nmiVsJBKFpysPueQ9mu50BEYHGVyc=;
  b=BU5+TVu73rEs5rfwREX13zMU0kbxcOpdmM3dwQ0BQ9Mi9FWSvgk9UX2k
   qhCfGslpXdmog6S4kyoh3IksxiicIgJP/1/MosZIl/5Ix4zh7k7pFh7il
   6QLB3nEtk3FLwvS+NdpoxrFjGCHE9acgA9Tbowu34sOXrKosWVZFVtMps
   XBk0+tYaXdnZPMDtOwuh+3g597rnu5Fy7CEGTgmdzu/2QtqLtxpVoiYSl
   AcMEQWIEOqLFbqkvtx204Qk5A36jxvyGhy5PUFCUP+dxUpZ+2M4lL1iKE
   dfE2nIprK34Ga9RmUZEKZKBXqmWn0vR7iTE76E5DKUGW68u6BK9bi16h0
   g==;
X-CSE-ConnectionGUID: kQGKTXVjT3Sdkz8uPdWUsQ==
X-CSE-MsgGUID: TlZVxXrJTPeIzbZdDg9SJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="131564748"
X-IronPort-AV: E=Sophos;i="6.10,256,1719846000"; 
   d="scan'208";a="131564748"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 17:59:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+d5xevMhP3U15lxnN3FEMuznj9xcRyEzq6OVA/9rnO003YPo1NneiTvR6UbNjVyIjyFHuKagUGXK1ZRvtZzpJ0S44YPo99PezZBYDsRv0A7KYFNTAY133mXrC9UwDSwXtQaSb9LUVbi5lXKkj2hzxLcYEEvnk9pMq/fgeQLKylXOaAXTxIfRNTukDm/KRGLYt/1FOiMQ/aVtE/zWmLwdsnstEAKrnLwsiAzVAdSvYNQdVRaLSAEU7nzxSs9INjMsqglz3jt6gy/ZPOwoaMuKOGeZ+SpCqt1jYh7yFeIxJGMyZTNb9fsEuijqH0+7U2fQMkvsfG0E7ZxWA4Pdj7SKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BY7n8DWYbjvb+6nmiVsJBKFpysPueQ9mu50BEYHGVyc=;
 b=QGZSFfGHu8RTFmq9wB524yu2+EIZLcMkWC8gdacKQmdyOKZ7eZFWR0w2nNytfwueGaPS2ZTcf6WODJMu+8x5yymGKe/yNZX3GY2mE+eQD4qfQA1SWK77yx553iZ3DkDQpAprsK1j4ONGBFm/M03b4JXuMbe6BKg1Hc56oUdUAj8TtY5WqUS8LyOFBzvuqaSlDPM75EFTvIUu1xwgt/shqtiIpvcnVTQpEsTbpRBqPDhwGkQbbNzq4LYdHpg27K1fu6z9Grz+aMO+bZPEAwegx14evKCw/Z4Dc3IE94Z8nD/oAEwGnbhFaWH3Ctk0mV2WFtOEdL1ynYxUse49gxa95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB6718.jpnprd01.prod.outlook.com (2603:1096:400:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 08:59:52 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 08:59:52 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@redhat.com" <david@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"osalvador@suse.de" <osalvador@suse.de>
Subject: Re: [PATCH] mm/memory_hotplug: Print the correct pfn in
 do_migrate_range()
Thread-Topic: [PATCH] mm/memory_hotplug: Print the correct pfn in
 do_migrate_range()
Thread-Index: AQHbDyErxhahfdpSoESWDVgy/wQbc7JoNE2A
Date: Wed, 25 Sep 2024 08:59:52 +0000
Message-ID: <a0a73388-3980-478a-979c-f8cbf91d0812@fujitsu.com>
References: <42545fc6-8c91-4f20-9959-2416b9e112c2@arm.com>
 <8f48a487-f8b0-7a0a-069a-78706413bd22@fujitsu.com>
In-Reply-To: <8f48a487-f8b0-7a0a-069a-78706413bd22@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB6718:EE_
x-ms-office365-filtering-correlation-id: a9229aed-b939-4c95-066f-08dcdd406b3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?QTN0YVVSSjl1cElrWXNreEJlb2hIbGNNOGRjUmZEVit5V0lYVHM4RjlPWmpF?=
 =?utf-8?B?T1grYXRTMlQvVmJCZUVFOEJ2dGN6WDVMUDZLaUFnaWkwWEgvbFo0czJtdzAz?=
 =?utf-8?B?NFNTa2ZiNVdIdXlDS3YvMTlSMWFqdnpUT0EzYmg5S2VrL3BrdUVreG1EWFBo?=
 =?utf-8?B?WVA1YWdQSStiQnkzajVZWjY1M1JucHgxWWhmQUthRlVBVEJoWDJOd2sydllp?=
 =?utf-8?B?WjV2K3pUUEI4NVMyWkliVWVCdGEzODgzOWhNWEZydlJ1WTN6dm5iaGJGMldZ?=
 =?utf-8?B?QnZuVG0rcEVGc0pERy9Hc29NUENwYXg4TnV5a3ROWTJDL0UrRnBXMWp2ZHZF?=
 =?utf-8?B?dUdwak5Db0F4Q3J0ZUp4TjUwOXo5dGtxTklYZTlKWE8rSGJ6UTRCdkE0VTdl?=
 =?utf-8?B?b0h3L2ExZ0dmREt6ZTFXdk5xeVhranAwT3BOYnlkbzB3d0Yzdm9jN1VERnMx?=
 =?utf-8?B?aW52bERWRVF1M3pvbmZ2SzRjT1lIS1c1SndKamszQW1iZFVMTHJYbVlMR2o2?=
 =?utf-8?B?MUQ1eE95OG1ZUGRrV01XTTRYSnBYbGo4cnBLTnRzcUhMd29OZGMwbHh2TjJO?=
 =?utf-8?B?QmczZDVnN0llM3hjSk9saktHTWdwbTUwR1NNdGU4SmVlejJ5VSs1S0lQMGNt?=
 =?utf-8?B?bmdvU2NUNlBoTDgvSmxIdHhuZ0krRmZ2V2ZEU2JLdHJNUlM2NGlXRmt0SFhW?=
 =?utf-8?B?M3pqaDd5eVRqS2RuK1lzZlhxRGZuakRWeHF5d2huLzJmRk5xTU5XdVI1TXhY?=
 =?utf-8?B?bkErRHJ3emNleXlESUpFbVJPVGVPbG5KYXo0dXNQSHI4bUluQWpqdmltZGJM?=
 =?utf-8?B?OUsrUml1WEQraEE5WlNLT1dTaWloMW5ZMjEra3RGMXAyNVAzNEh4a3BSQ1Ux?=
 =?utf-8?B?ay9waENNVUVhbHN5REVQNXpoUUludTJobkxKNDhWaG5NUzF0c2QwR1ZSMWlr?=
 =?utf-8?B?ZHk1bEUzLzZFM0libXlYWXFqL1FSRi9Ia2oxS1VETkpvK2hYTisxS09FYlZs?=
 =?utf-8?B?NFRaSENYZ255T0dDd2hab1EvbHJyUkZzVmxVbjBIVzhBeTV4czZXVUpNd2d6?=
 =?utf-8?B?UDV6MlgrenU5MG9ydllkU1BHOE04NFphNFMvZEV2MGxZVkxoV0g4YldITmo2?=
 =?utf-8?B?QnlieGRVYzVQUlkxWXZXSlBMTUcwN3kwU0RLbndOMjYrWWNhd3A1a3U2TnN5?=
 =?utf-8?B?aHpSbEIrUkhlS2xyTVNHWE9ZWDBPNHZoUC8vYWdRa1JrdWd5Y25XM1FUWGwv?=
 =?utf-8?B?cTR4ZmZZV2N2ODVLY2tyaldJdkRudzFJczdlMWdnMVdReUliS1ZMNC8xUVlK?=
 =?utf-8?B?bDlxeEQ3akJVWkpLS0g1aWlXaU9EMFQ0akdjMWoveGovZnQxRUVzS1AwamJj?=
 =?utf-8?B?czBQbGl1MWljaG1YR01LZmNuczRPdU4vQmo0bHRzTEdsNUtDdWtrUTNsWWJ2?=
 =?utf-8?B?TmNQUjFXaUVLTHNZY0xIUDJ6U2d3QXh4cW1RbFFDQXdkQnMxdTMyWHo3MEJF?=
 =?utf-8?B?bUJ2ZWhrMzNrNmI1LzAxbEg3bzVxVFROeEd4SDZzV3FuTnFIb0ZoSUkyU0NC?=
 =?utf-8?B?bnd2V3RSZ1FyYU1SanhoWkJSQ2U1TzFqMkJvVkd4ME9Lb3pKU1lrL0NrWHJS?=
 =?utf-8?B?M0ZDS2lXYWNBQWNEbDFENWtwZkVWUnpQZmFmQmY4TTVlbVlBQ1FtNEdGMDdP?=
 =?utf-8?B?RDBRcDRhNStyU1RQQkhLQkVkcWoxNWJmZitEdHp0TXRyc1dMd0xQRzhYTE5v?=
 =?utf-8?B?aGZsOUxPU3dqZXFtNVVKWkdGUy9aMkVQU3JyRWxmdHZ5alNBek9XTlBmbm4r?=
 =?utf-8?Q?bJr+F7s0R1eVBjA5e4MECf+GUm16oaryj5eFw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkQ1VHNoY1RSTXdZWWhHVkN6SmYrWEdLWTM2ZkJzcmR6bHVBYVZRc3V1MXJE?=
 =?utf-8?B?Rm9Xc3MyL1Y2Z0R3Z3QvanJER0lxT0kwb090aE9BZGtIRDVsWFR1ZjVnYm4v?=
 =?utf-8?B?TloranhVTW0rN2NNalJqSmUzeVNnVmlrZ2ZoeVo1bHpjSTBna2d1VllMRlJi?=
 =?utf-8?B?K1ZWT25EYjVuOTloSWtZQkVqZ0R6YnNtd0FtNUs4ZkY0NXNtVXlmUllrMGtm?=
 =?utf-8?B?Mi9BUlcwd2VkeVE0NHlXUG0yWWVjRXdRbkFteklERW9EWHdGTHdsT1pPVThF?=
 =?utf-8?B?NnE1RVpYaldmVnRTanJDNW9lVmlWT3FFOU9NZ1JmL3lIWGI2dWIrMWNwVm14?=
 =?utf-8?B?WW1zenQySzNLWGtOc0EvOWpCS1RvTml1aWE5RFBLSVVRSUJ2aVMvN2MxOExl?=
 =?utf-8?B?c2VBOVdmR0drOTlISHVnZ2ZaSndJblBwdFN6TmhISXl0TmF2LzVXM2RSWWVQ?=
 =?utf-8?B?MFBVVTZpNGlDZXVnSVAxbW5vS2JYQkk5ZTI5UkN6bVliK0VjZm12UDZCdHRR?=
 =?utf-8?B?WDk5bjdCQXAybi96b2JuVC84c2xCLzhqMHF5c1VRK0hOa3FlbnAwMU9DZWMy?=
 =?utf-8?B?bnpPT1VLM1NMYVo1QWJlYUw5ODFtRktiY1FnUHhMTDdyeE9mcWZxUHo4RzVF?=
 =?utf-8?B?VnhkZzgyNVoySGRJV3VMeUh0SzBzcE13aVFSZlF1VGZXQzVjTkx3WkNXbkY0?=
 =?utf-8?B?eVMzTDdtNE9uR201bFh1M2hLbHpwSVVPK2NmdnIyT3MrNHRYeWVnNEpTT1ZB?=
 =?utf-8?B?bWp6eHlZdmJiNDZiUUxzcG9OcmNhZk9Kb09mQlhVcE1kUWdOR2lBa0QvZ01P?=
 =?utf-8?B?ZTcrTzVyckUvSzM5eDlxOHhHWWRqcndiUEVzUVVYb002VmpTVDdlQ1ROUUFI?=
 =?utf-8?B?WVlIWjR6bzhmM2F0aEJTM3ROcEpNaG1WSmV1dnVoNDhzLzd0UDd6dC9Ya1lH?=
 =?utf-8?B?ZCsxY29GN1VJRXVoRTEvYXdCNzdmQ2xHRWZScEhCQ2VyRCt6L0o1RVdhY25Z?=
 =?utf-8?B?U0lGT2xtb1l2eW5hS3RYdE5vTUZSYVZTNmxWdnU5Rm5hYStZOWs0MEFUZTRN?=
 =?utf-8?B?T2dpeUtqM0RyYWpvRUpvYk02eGd1WGY3SHF1dFNmbVBaeTZXMDhDMUI1VTA4?=
 =?utf-8?B?RjFhS2NPTmo0M0FNZGtxdUlic3dCWDNzUW8raHNkcTlmdW8yekx2VWIveldi?=
 =?utf-8?B?ZTQ5MS9zMDNJQ1A1ekFITktTTFM2bEsrWmlRbXVUbjFrNTFXSDRkZ1c4RXNn?=
 =?utf-8?B?b2trMFFFYWoyK0d6WDg5eGVkT095VldmWEhnMEdqQ2NpTEtjVDdiS3RhdkdF?=
 =?utf-8?B?WmxKbGhUMjMwNGowOUV6S2ZlVXN1V1UwWFhaZ1R0M20yQURyOUNId3BhdWRE?=
 =?utf-8?B?WUtWd2luVjJsendEeDk2Q2hxVGJ4RlZRVFlwTkFWN0VnNHQvUmNkeUZtbWpy?=
 =?utf-8?B?aURLcUxjaTAyMXcrL0U1cE5EODMyNExKRko2U1NVVno0MWQ0VFBOdmFIaUYz?=
 =?utf-8?B?eGVMNDVkRW9qdXB3enBhUUJOemR2NGZucUIzMlNaRCswZTVPUGQrYmFOcUJT?=
 =?utf-8?B?M0ttdXhzZHYvbFliZUdCQWxqMERtdFNXNlByYWZZcFdzWWNMRGp6K3IwRkJ4?=
 =?utf-8?B?QndubDZOVUxaMk1SUVhjWitsamhXVlBPUjFVZDBCVUhJK2ovdWdGM3dUQ0pO?=
 =?utf-8?B?aW13Q2tnUzZJV1lQdHJ4N3ZoS2ZiOURURGdGY2ZjcUxVSHp5N0dWZzkxcDF0?=
 =?utf-8?B?TWFJQ0U5aVZPTCtEdTlheWZqekQzSGw0Y2huNXBDZTU3dDIyTGMwY0lXYXBY?=
 =?utf-8?B?U3B0TlQ5TzVIS21HOWhBNXlhUmZIbWxXc3JtQ0c5RUZrMTBsb1RST1VQdkNX?=
 =?utf-8?B?TDFUQjBxaVlUNWU1QWhpOHl0OVJHTCtUekljdW80TFFYMnhqL1lQZGxua0pX?=
 =?utf-8?B?V1RCWXZ3eWJ3eFFJSFNXZFo1S0MxSEphQ2dBcGJXcjRJUDhsdllWOXFSUDlv?=
 =?utf-8?B?NzAwei9ESmZ0SGJRaDRKeEtnL1o4NzFnd21QV3dvdmJ1Q1ZaNDN1WjNzQVI3?=
 =?utf-8?B?QXV4ZnhKdGpXWEZyTnRWYzBKdVQvNFY1cUNxMlRzMDhNbnBDUFlOZy9Udmwz?=
 =?utf-8?B?UW82a01CSzFncE8weXljQ1dEejlvcE9RcjZueDdXa3RsNzU5OGpOeFNWMk55?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05CFF370EBA97C4C9DD1EA3AF6FA2853@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ML2x0K/S7h1BemvX8UIVEjcrpOyeo9D6z5evcy/ahF+14xnKTqjOo+uQdtyWRG7k3Un17U7lDH41qdMocYCzQGOvddCyL6xhWVRNRF5Ec8mxKE/j/wwC8JaM6roKkpsmNtXgU7h2DPQygQbuQ9T1enEsyssU+XFFZNPq9q/JMxDftU26nCFN0uaZIc+D/mMDQid83IV+Ti2s129WnXNBqPEMrWtS1+gwxudxVGLsUNxpJojZ1nxMmCdE482hnzzDKeEHEG0/ciwOGzmgN0yn2gCKtWk0yfT9f0WheMPemf/pJMxMwmyDMwRAFvmT87wbzV137LHrJXkJQMdiaW9dW8EzqDVhXabXglNLzk7L9sEOQmkNzPWKQArWZPnbg5w9gkrWfVqxjAdaDUqXpU90sOqA242CEzthq0DMW3HHD7O+0FQ4HZQf8BbHfe2u26A9SPQeW2LZyKhRdPfioHWv2j9WI+xmIrvb+ojInK/XzWnIT3UQfbqE6YVQxqpUyHMNrcb9HKcR7+DQiRFWWNemn8QPMzM2FS96ymxO/B0OHplkrjDLtcNr+D7AuxWIfRCbdsWSy97+wibm5tbh97vrqY0faqSofVw+eXt6TvqpQMuP50M/OGymPYhgdqeUbfCu
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9229aed-b939-4c95-066f-08dcdd406b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 08:59:52.5979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hzs2+UTH6/dM8o66Ja2LRjdqyhofn5XNT4mDGhHC+HDIetTq8sJO82XdB8HgnJZq9Xg14TRQ48NP63yOCDPoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6718

DQpXZWxsLCBwbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2gsIGl0IGhhcyBiZWVuIGZpeGVkIGluIDYu
MTIgbWVyZ2VkIHdpbmRvd3MNCg0KDQoNCk9uIDI1LzA5LzIwMjQgMTY6MDEsIExpLCBaaGlqaWFu
L+adjiDmmbrlnZogd3JvdGU6DQo+IFNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4gKE15IGNvbXBh
bnkncyBtYWlsIHNlcnZlciB0aGF0IGVuYWJsaW5nIHRoZQ0KPiBEUk1BQywgc2VlbXMgbm90IHRv
IGRlbGl2ZXIgc29tZSBtYWlscyB0byBteSBpbmJveCwgSSBoYXZlIHRvIGNoZWNrDQo+IG1haWxz
IGluIGxvcmUpDQo+IA0KPj4gT24gOS8yNC8yNCAxNTo0NSwgTGkgWmhpamlhbiB3cm90ZToNCj4+
PiBUaGUgcGZuIHZhbHVlIG5lZWRzIHRvIGJlIHJldHJpZXZlZCBjb3JyZWN0bHkgd2hlbiBQYWdl
VHJhbnNIdWdlKHBhZ2UpDQo+PiBXaGVyZSB0aGUgcGZuIGNvdWxkIGhhdmUgYmVlbiBtb2RpZmll
ZCB3aXRoDQo+PiBwZm4gPSBwYWdlX3RvX3BmbihoZWFkKSArIGNvbXBvdW5kX25yKGhlYWQpIC0g
MQ0KPj4gU28gcmV0cmlldmluZyBmcm9tIHBhZ2Ugd2lsbCBnZXQgdGhlIG9yaWdpbmFsIHBmbiB2
YWx1ZSA/DQo+IA0KPiBZZXMsIHRoYXQncyB0cnVlLg0KPiBpdCBzaG91bGQgcHJpbnQgdGhlIGFj
dHVhbCBwZm4gdGhhdGZhaWxlZCB0byBpc29sYXRlLFxcXCBUaGFua3MgWmhpamlhbg0KPiAgICAN
Cj4gDQo+Pg0KPj4NCj4+PiBpcyB0cnVlLiBGaXggaXQgYnkgcmVwbGFjaW5nIHRoZSB1c2FnZSBv
ZiAncGZuJyB3aXRoICdwYWdlX3RvX3BmbihwYWdlKScgPiB0byBlbnN1cmUgdGhlIGNvcnJlY3Qg
cGZuIGlzIHByaW50ZWQgaW4gd2FybmluZyBtZXNzYWdlcyB3aGVuDQo+PiBpc29sYXRpb24gPiBm
YWlscy4gPiA+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4NCj4+IDxsaXpoaWppYW5AZnVqaXRz
dS5jb20+ID4gLS0tID4gbW0vbWVtb3J5X2hvdHBsdWcuYyB8IDIgKy0gPiAxIGZpbGUNCj4+IGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pID4gPiBkaWZmIC0tZ2l0DQo+PiBh
L21tL21lbW9yeV9ob3RwbHVnLmMgYi9tbS9tZW1vcnlfaG90cGx1Zy5jID4gaW5kZXgNCj4+IDI2
NzkwYzhkNWI0My4uMDAwNDMwNDA2YTllIDEwMDY0NCA+IC0tLSBhL21tL21lbW9yeV9ob3RwbHVn
LmMgPiArKysNCj4+IGIvbW0vbWVtb3J5X2hvdHBsdWcuYyA+IEBAIC0xODI5LDcgKzE4MjksNyBA
QCBzdGF0aWMgdm9pZA0KPj4gZG9fbWlncmF0ZV9yYW5nZSh1bnNpZ25lZCBsb25nIHN0YXJ0X3Bm
biwgdW5zaWduZWQgbG9uZyBlbmRfcGZuKSA+ID4gfQ0KPj4gZWxzZSB7ID4gaWYgKF9fcmF0ZWxp
bWl0KCZtaWdyYXRlX3JzKSkgeyA+IC0gcHJfd2FybigiZmFpbGVkIHRvDQo+PiBpc29sYXRlIHBm
biAlbHhcbiIsIHBmbik7ID4gKyBwcl93YXJuKCJmYWlsZWQgdG8gaXNvbGF0ZSBwZm4gJWx4XG4i
LA0KPj4gcGFnZV90b19wZm4ocGFnZSkpOyA+IGR1bXBfcGFnZShwYWdlLCAiaXNvbGF0aW9uIGZh
aWxlZCIpOyA+IH0gPiB9DQo+IA==

