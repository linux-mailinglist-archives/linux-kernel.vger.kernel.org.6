Return-Path: <linux-kernel+bounces-430224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9149E2E16
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1990283A32
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1159C20899B;
	Tue,  3 Dec 2024 21:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y787AsNa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D3B204F7A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261305; cv=fail; b=PAh9M8cf/ZXgyjcqhM7kXikJOyg2Rn4drL0YuiBWeuMo6JI79vvInqyX+EL3AkXB5+pLw7BfsqknxxWBAoaD58fWmJFLL/FNhOLLn++zFiP5doHk8VohcnAsacOj4JAaGSEdb4CFRBinbyBqB3o1wpUxAyX7Y5a1k5k1tosAYy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261305; c=relaxed/simple;
	bh=FEPlmZfiKk83MBPDCuIxo071EWVSKzxLCj0EHdIa66g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WMiPdKmSG66iBW0pGiAniCbOL3urltsJx34olXMTsd8lLyjO0pd8WB+lLBJsq+2exywv6d7a3D3AfBcmCvwaiICHKL8dzB/3NEEh9LN9i+JnxQllulzTsDD4GO55nIN3oJzgSAVTv2sJCcS5h5t6PGBApPK1c6USlRoe1FepJaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y787AsNa; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733261303; x=1764797303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FEPlmZfiKk83MBPDCuIxo071EWVSKzxLCj0EHdIa66g=;
  b=Y787AsNaXVBa5x4OEygmIGZHm5iaKIM5x+2p6Q74WrUsrfQtbcZ5kXx3
   8R37LxG3Dot1SCGVMo7Cyr/+a7yL6FPvLDs3I98GJpvbGt8lV6ulhn2q8
   13eR/DTs05NefpaWbdw832WLxcmLnHFuRDyrapBXBdFLZChesN8KllfF7
   KgNQtCkgwU380OUYVV+SwhIRop6QlMrOsMNVBZhwB48k3fq77AxXYz6Br
   9D3YjoTv2E8/bCq8Yr3EGchcNFmEWDxWDFxXve5rBc3A7Gca+h9p/bEli
   mOGusJkoUsgGaZXW0v2xdioshI07dUuNADjoxpPjTu+CXuIStsM96cEpO
   A==;
X-CSE-ConnectionGUID: /RCpDVL8TsO+vipLkUqSng==
X-CSE-MsgGUID: vyT3G2rfQgK3pkZMBBgLKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37439527"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="37439527"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 13:28:22 -0800
X-CSE-ConnectionGUID: orPLSuLRRDWMqS3xuhfZnQ==
X-CSE-MsgGUID: xtBtK0+iS8uPOvy4YrsygA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93222306"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 13:28:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 13:28:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 13:28:22 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 13:28:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkW5ujMPGQRBgRDjBpav3kXyV6Coqn4YaDXikR3fojwotDgBA3dpIKaUhKZKGPUC3wz9SKbH+Y2Ewy7RXEGclBjYpidbf7krljxn2cmAHoJuLyRDaa14toP7L3wZdcWoCWWTxpL6Pkrq6Z67CHln1Uz1dO2Bw5yccR9rISfmO2jZFYMZASpRPv707Xn1u+/ulAf1WRmT+y1nvgF7Br1j9EXPyxX7IzsF3/4gkwsnaBH4YqfC9HsLH0fDfGY5kkYxRIbBR+QTaXaSF/rJWHWdPl76u9ufZw1cC/sCcM38q4f69IoTFC21Slpx2s+VvD0fV/q5lJaf/qtL0LEPl5wnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEPlmZfiKk83MBPDCuIxo071EWVSKzxLCj0EHdIa66g=;
 b=A248biDHHWh3Fi/q0OnshDUa15lsXU5PvXR8oiPU+FQo3mt56wmcOs8n6umI/WvAVEPTPQp381WA+c38TM9KkYhpSN0Sy03zFv8/GZReviU0vigRYg7wy/x1M8dmRwZMxrDp45xHEQhnO+9x+AKKOs8+/X3PGWut3wPqYasLu+7xg0568TypNGcW8cfPHWdtJzeC8OyouHkQqDP0c+hx230vAenlji3FqOnCz7McecOSpHCmsONfvOQ2odasRUC1+ljV/ndskIU+ZmGR/8qCiZnxTf9BAXjWtB+snkiOVRgPE0AHTyQ6+P3veXkqbuKlSAefdVSHwArEt9g+FW1xyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by MW3PR11MB4572.namprd11.prod.outlook.com (2603:10b6:303:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 21:28:18 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 21:28:18 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: Chengming Zhou <chengming.zhou@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>, "usamaarif642@gmail.com" <usamaarif642@gmail.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications for
 batching.
Thread-Topic: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications
 for batching.
Thread-Index: AQHbQR8zjJv99UT6akiirMMuSrWTzbLMRDGAgAcbawCAAFSwsIAAKiWAgAAN/XCAAB+TAIABBXTQ
Date: Tue, 3 Dec 2024 21:28:18 +0000
Message-ID: <SJ0PR11MB567853E78B182E133748AE6EC9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
 <20241127225324.6770-3-kanchana.p.sridhar@intel.com>
 <c9a0f00b-3aeb-467a-8771-a4ebb57fbba0@linux.dev>
 <CAJD7tkbPSQguHegkzN65==GHuNN9_RPm1FonnF8Bi=BsQDhxng@mail.gmail.com>
 <SJ0PR11MB56781233ABFE772C5991AB01C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <045a786d-7b13-4127-82ce-57510565bd15@linux.dev>
 <SJ0PR11MB56780123C601DFD5FF46C2A1C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYM=6Mp7zdmrCf1rdQZUg4B2+_oLKVE3hQ0t8vEFqdH=w@mail.gmail.com>
In-Reply-To: <CAJD7tkYM=6Mp7zdmrCf1rdQZUg4B2+_oLKVE3hQ0t8vEFqdH=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|MW3PR11MB4572:EE_
x-ms-office365-filtering-correlation-id: 283aeac0-2609-4942-d0d0-08dd13e167a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YS9UVzVsM215Yy91OGtwbWJlcjhraG9BYXczNjJiNVFmTjFxMDhrMEtZeWJ2?=
 =?utf-8?B?QmZyUTZ3dm1PS3BHRndxdEl5M2dKT0Vxdm9KbjVDVGsyN3dPV0xCdUU4amxG?=
 =?utf-8?B?emx0WGl0V3hGVFpuR2NEckQ4RTRqZjNTMHp0YVljem9LeWUya0ROaHJtcjVN?=
 =?utf-8?B?aHdvNjlKRUk2aC9ySVRlSFlrd1IxQllCcmFyNDhrWTc0VS83YTJTQWd2cXgy?=
 =?utf-8?B?akV2ZnNCa1JJNWk5d1NmdXVjUXdDTHRPTFRHakt0WHZVaUZ5OFlGNjZIakd3?=
 =?utf-8?B?Z0ZTNW9KNWwwMW1RblpKMG1YTVhFSktpdWZNLzhhL3R2T0pVcUNRN3lmSjhY?=
 =?utf-8?B?OHVIaTlDS0RzMVBLOVpMZUMvbXRqV0xOaloxQUZablpXMU0rWE1RRzN6Mita?=
 =?utf-8?B?bGttMWR6bzhUNERydlVtV3Vzd0dKUFFLVllqcURtVjhYVGpVMkdmTFkzdW9B?=
 =?utf-8?B?aldVY0VRL2szd1UvVVVMYW0zTTNaWXdqZHZTSTZSTVcxaEdySmR2YnNIZ3VG?=
 =?utf-8?B?NjhpRm51WGxvMGMvK09UZUxENXJWTVhwYVpvaTNpbGpCakhNV0F5VjdOOFlN?=
 =?utf-8?B?b3lXMHNRNlczQjR0ZnhWU3hvV3dWL1h4S2VLKzdtd3BIUURza3JVdUJRUFpP?=
 =?utf-8?B?ZnhhSFh0RG1uaUhBOUt5VVJFSVFpSVZxMDBhMkljajBqT1E3bXVRaDU5eERS?=
 =?utf-8?B?QnMySWdKcVBpMEVLd1NxdmpHa2kzS0Q0aG9aVENUS2Z3dkRhU2l0OHJZQVJX?=
 =?utf-8?B?dEpaYXFRN2FIbHNiL291ZTlxaUpjT052czZhcjZFQUhTNjJxTjhSTEUwRlJv?=
 =?utf-8?B?SXRxTlUzTHZhWlhWNmtUdkUybDZuWU1pUkt1M1ZSenBOM2luTmVkTGJQcWFP?=
 =?utf-8?B?aGlUUElwQ2xoc1lvUTNHTEt6dHpFL1hHOTZoYXAvWVVkdGdDNVIwU3NJUis3?=
 =?utf-8?B?T2diN0tEeUVaTDhXRFp2aTVVcDMxU2p3RitOOG95dHYvVy8zSEJadHpsdTl6?=
 =?utf-8?B?UEtqLzVqS3VTeCt4SUY5OGFLYWswY3VjQ0FGcHcxT0JobWhyamhKUC91UzJK?=
 =?utf-8?B?b0hQSWJTc08rdHh4eFRKQWhnaFBBVUs2aXV1aENtdlEwZGsrdEkyUERKb2V5?=
 =?utf-8?B?aXpENDk0cXR1WnJ0OGhMQWlXVGlKL0FwQTFoeWFvMyt1RVY5WHhNYSt2TVRY?=
 =?utf-8?B?TkhMR2l1WFc2eU45enRPenhpQjlweGdGa0IydkFsSmx5TzlHRERnVThabW92?=
 =?utf-8?B?ZTZ3M1ZwS1hGUWNoVnBSUW9jTzhXUjB4MitzTHNRSTRTNWRRYTRDWFNsbWlE?=
 =?utf-8?B?bC9LVFJPL29BNUxoOFFaSFB4MXNuN3YyTXpZWkFBMklDeUk5bWpjRGo4TG41?=
 =?utf-8?B?dHlLTEZ4NzlHVWFnMEpNSkhUS2Nud0ZuV0wxOFZqb1hXMmRMWnRnL0V3OER0?=
 =?utf-8?B?RlgyYXBQUWxWdVZjMEFRbVpBNHhiSFJ0K2wrck9YUWo4cUZ3MzgvR3lrVGFh?=
 =?utf-8?B?VHdXdHUvVVMxWW1RVmMrbG9EVTRiNGpMVlFBdVhVVnZuZ1h1VnF4NXk2c0FD?=
 =?utf-8?B?NDJaaDk4V1JEUDdwb2FHMzJGbVNlUThKUG1OWTVvdHVKRzJnOXQ4MFU0NjV4?=
 =?utf-8?B?cUFiT2t3dzQxbUtMVmswUzVBSUdrV29iSDQ4cXhIWkFjNE1QTTZ5ejBhaGdM?=
 =?utf-8?B?SHpDSDlBNkNNaDNZT1AzS0VBM1UxNGM0TWkralU1Rkc5TVpkMmVtUjl0cWRz?=
 =?utf-8?B?TWhlNWtiWDlPU2kxZTRqd0dWdVgvWElRWUhTeW9ZSUFLTkJsS2VySjlYUm14?=
 =?utf-8?B?SGtVdHJ4ZXhVYWNWTlFvNFN6NSthbHVVOFZoYVl3NDk3T1VpYTdvdHVtQWZR?=
 =?utf-8?B?eVg3c0FyMldrL1BGWEZhNlJSSTRCTGkvUDlGaXhOMWl5OGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXZYK3QwZkpjSlg3YjNvM1ZJaVV0YWZxRjh3MHA0QXRkWVcrWitRWUdCN0RH?=
 =?utf-8?B?QUFxRTVWV3hwdE9OU1AxNnlnRmtueDRMbnpiVmRlVWVUcU1LcmNsYmJ5ZmhU?=
 =?utf-8?B?U2dBNWtjQkRNZnlXdHpvVXNlWTFSWFdlbGd1RmpuNW9pK2VNdzBuWGpOdm1O?=
 =?utf-8?B?dnpQOVI1ZFpLaHJnZFBwTWQrdWZKd29hc3Y5Q2tZemY5ekg3TXpUQ0tDaVFy?=
 =?utf-8?B?RnR0YTV2bHJaeW5ySlVGWXZuVUNheTAxUDRBQ0RjOGxmZEM2eU9vNGNFVmpX?=
 =?utf-8?B?UlBNeEFlbDF1LzF4c0ZJOVBJNmtaYUxoV3JhQTB6Z0orM0hrZGRsNTBKVWts?=
 =?utf-8?B?SjR3U292dElsRkk4ODVLTzdRMk1Ec01TQU5UUnFYRHJ4RjFLLy90Um56VllM?=
 =?utf-8?B?VDZZd3JHUW5JS3BreW1UY0lGNHI0L1ZLRnMwYTNuOUFrS2VxQ2JoOUo4ak5Q?=
 =?utf-8?B?cWFsVk5mbkp3aHl2dnJLcUx1aVU1eHBaSHNRa0RBZHJla053Sjd3U1RnNThZ?=
 =?utf-8?B?QTA4bkZHc0NFQmM1RnlDMXdHb2lqa0JISUFuNExxcjBueGcvTDAvQkwzT1RS?=
 =?utf-8?B?U0Q0NDBPYnVFM2lXeCtGMGdUaWd0UWE0ckJ1Y2cwaVh3WEcreis3dHcvUktC?=
 =?utf-8?B?alYwMEZPZEx5K3BTcjU4RkV6UWxTQlZnRVNDMXhqbTU2ejRhTVhaampKeDFl?=
 =?utf-8?B?VEo4QzlDM28zMVMyNFlHMTlzcitpSVRGdlA0dUdkZU43Y2thRzlaY294cWJh?=
 =?utf-8?B?QnhKVXFSQW5qVDR6UVRJWUQrbS9GNDFoa1hpSmJuM0k1aWtxR20wRGtYczJP?=
 =?utf-8?B?SDlHOWFMWm9VVkN5QlVSWlpIcDJQMUFXZ0pGMkZGdVoyQkEzNzlZNjNvdDNG?=
 =?utf-8?B?enpWR29xU2VUakxCemJwRnRJeHBab1RLRWF5Tk1uOHZoclhzU0hTL29TSy9z?=
 =?utf-8?B?eGFsQ25iWTNmM3I5b2RNMmNtTS9BZEV0ZnJpMTNETEFVY2hXVVg2dTdlUWxw?=
 =?utf-8?B?V01rWmhSMFVyRnV4TFg3YjNUQUZKcEoyZnNPNDRHUG1xQlBxR3FPZWJUNUlM?=
 =?utf-8?B?VWYyUnlSMThQeERJUmhkRWE2cTV5cXhvSUxSckdqYVUwU1ZtTXAxcnAycU1O?=
 =?utf-8?B?eC9DZ0FhT0hxY0JjUWozMUg0aENYdmFuclZtcXl0LzFXM0hUQTBJVG9ZQWR6?=
 =?utf-8?B?RU1vSDFjM2xJbEEvdTBmeXFpOCtiVld5RCtXdHNnQ005L1h0b0llb08ycU0w?=
 =?utf-8?B?TWRKMVlpaUhhOTNpTk5hTTMxMjdJcVliWDJaMzVONm92UUdtZTFISCtRQ1do?=
 =?utf-8?B?ejg5dmxFVXVMb2ZNYlZWQmtnMUlWLzRmVnVjSm10WCtGcWdzaEliSHFuR2tk?=
 =?utf-8?B?enVjUXdIbUJZeDFwYlBJZmJRSEl4dGlKR1AyN282ZkZtNlpubWxNUFY5UnY4?=
 =?utf-8?B?Wm5Zd2tiSjRsVGEyWXE4MlN1SGlBSmRRL2JMS3Foc1g0ZVJqZ05LcFVKQ25Q?=
 =?utf-8?B?aG1yOXEycHFWb3lHR08zQVBWbEJtTWZ1TzYzYms0WFBGaERZYWpmY0VFRU4r?=
 =?utf-8?B?SkZ5bVJtUEtsZ0lSeDZWSmI2Qy95Yjk4dFQ0Q0F0UkEzb0djcWxvQW4yNDJZ?=
 =?utf-8?B?Q3dVZittNUZPUzlMbFQ4Z2IxV20wazZIZFcxa1FZSE9XNFRkczlMNERuZEUz?=
 =?utf-8?B?bUkvQXIzNGg4VWI4andUM0kwRGliaTRCRy9zV29LVllQb092djF2QytxRnVs?=
 =?utf-8?B?R3IzSGhWWWd1WmlFYkQ2TXhhMmhnZUdFM3dFWENWSnpHZkFPV3U0OXhpcXBp?=
 =?utf-8?B?bitLdUsyd29UZGhuTW1GWmhhK1RTSyswanBNQjdBVFJRNDdTc3VReFpHVlk1?=
 =?utf-8?B?TDl4TEs2cWRwNlkzN2hFQXkzc1VNYzlPS3V2Tzl6Z3dQMDJUemIrZE1odEFv?=
 =?utf-8?B?UkhpQ2RrSk16S3pBaFkxbVA0cUFWR2xnS3JNY2pFWWVleVZsdjZoYlhURGQ1?=
 =?utf-8?B?T082MFkvV0VrTlVVQkdENktabmNobWlpdWpBS3NSSHk1L3JwS08vVlVxZ08x?=
 =?utf-8?B?V3RVTlF5UXFJdXhUNHA4VjhOV01jSVBmdmJOZjRKQVp3NVp6UXdYaThZLzRT?=
 =?utf-8?B?QWNRSVRIQkxjMzBETEpzeEhmazVJeWx2dHNSVmRsNmRFMTl3MUdnZ3dFd290?=
 =?utf-8?B?QlVMK0ZOSlB1Ky9VZFo5QXpxcmhlVEtHVE5BTmUvRW9sOVRrN3BVb3d4SEEw?=
 =?utf-8?B?b09UbnlsWkpBNmsyWEc3L0hJbElnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283aeac0-2609-4942-d0d0-08dd13e167a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 21:28:18.3765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTO1oRGIyaxYx3dFHiqqfzQX5MHF/jj5pKI9l/Rchjq9Tl2zUnSnaW3IyBM+T0MHxRLKnNJv+yPcvrIHGm35Aofle30JbQY7Cc3sJgCflpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4572
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMiwgMjAyNCA5OjUw
IFBNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwu
Y29tPg0KPiBDYzogQ2hlbmdtaW5nIFpob3UgPGNoZW5nbWluZy56aG91QGxpbnV4LmRldj47IGxp
bnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGhhbm5l
c0BjbXB4Y2hnLm9yZzsNCj4gbnBoYW1jc0BnbWFpbC5jb207IHVzYW1hYXJpZjY0MkBnbWFpbC5j
b207IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOw0KPiAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51
eC1mb3VuZGF0aW9uLm9yZzsgRmVnaGFsaSwgV2FqZGkgSw0KPiA8d2FqZGkuay5mZWdoYWxpQGlu
dGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjEgMi8yXSBtbTogenN3YXA6IHpzd2FwX3N0b3JlX3BhZ2VzKCkgc2lt
cGxpZmljYXRpb25zDQo+IGZvciBiYXRjaGluZy4NCj4gDQo+IE9uIE1vbiwgRGVjIDIsIDIwMjQg
YXQgODoxOeKAr1BNIFNyaWRoYXIsIEthbmNoYW5hIFANCj4gPGthbmNoYW5hLnAuc3JpZGhhckBp
bnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gPiBGcm9tOiBDaGVuZ21pbmcgWmhvdSA8Y2hlbmdtaW5nLnpob3VAbGludXguZGV2
Pg0KPiA+ID4gU2VudDogTW9uZGF5LCBEZWNlbWJlciAyLCAyMDI0IDc6MDYgUE0NCj4gPiA+IFRv
OiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPjsgWW9z
cnkgQWhtZWQNCj4gPiA+IDx5b3NyeWFobWVkQGdvb2dsZS5jb20+DQo+ID4gPiBDYzogbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiA+ID4gaGFubmVz
QGNtcHhjaGcub3JnOyBucGhhbWNzQGdtYWlsLmNvbTsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsN
Cj4gPiA+IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51
eC0NCj4gZm91bmRhdGlvbi5vcmc7DQo+ID4gPiBGZWdoYWxpLCBXYWpkaSBLIDx3YWpkaS5rLmZl
Z2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaA0KPiA+ID4gPHZpbm9kaC5nb3BhbEBpbnRl
bC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDIvMl0gbW06IHpzd2FwOiB6c3dh
cF9zdG9yZV9wYWdlcygpDQo+IHNpbXBsaWZpY2F0aW9ucw0KPiA+ID4gZm9yIGJhdGNoaW5nLg0K
PiA+ID4NCj4gPiA+IE9uIDIwMjQvMTIvMyAwOTowMSwgU3JpZGhhciwgS2FuY2hhbmEgUCB3cm90
ZToNCj4gPiA+ID4gSGkgQ2hlbmdtaW5nLCBZb3NyeSwNCj4gPiA+ID4NCj4gPiA+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+PiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiA+ID4gPj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciAyLCAyMDI0
IDExOjMzIEFNDQo+ID4gPiA+PiBUbzogQ2hlbmdtaW5nIFpob3UgPGNoZW5nbWluZy56aG91QGxp
bnV4LmRldj4NCj4gPiA+ID4+IENjOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNy
aWRoYXJAaW50ZWwuY29tPjsgbGludXgtDQo+ID4gPiA+PiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1tbUBrdmFjay5vcmc7IGhhbm5lc0BjbXB4Y2hnLm9yZzsNCj4gPiA+ID4+IG5waGFt
Y3NAZ21haWwuY29tOyB1c2FtYWFyaWY2NDJAZ21haWwuY29tOw0KPiByeWFuLnJvYmVydHNAYXJt
LmNvbTsNCj4gPiA+ID4+IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24u
b3JnOyBGZWdoYWxpLCBXYWpkaSBLDQo+ID4gPiA+PiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNv
bT47IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+ID4gPiA+PiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxIDIvMl0gbW06IHpzd2FwOiB6c3dhcF9zdG9yZV9wYWdlcygpDQo+
ID4gPiBzaW1wbGlmaWNhdGlvbnMNCj4gPiA+ID4+IGZvciBiYXRjaGluZy4NCj4gPiA+ID4+DQo+
ID4gPiA+PiBPbiBXZWQsIE5vdiAyNywgMjAyNCBhdCAxMTowMOKAr1BNIENoZW5nbWluZyBaaG91
DQo+ID4gPiA+PiA8Y2hlbmdtaW5nLnpob3VAbGludXguZGV2PiB3cm90ZToNCj4gPiA+ID4+Pg0K
PiA+ID4gPj4+IE9uIDIwMjQvMTEvMjggMDY6NTMsIEthbmNoYW5hIFAgU3JpZGhhciB3cm90ZToN
Cj4gPiA+ID4+Pj4gSW4gb3JkZXIgdG8gc2V0IHVwIHpzd2FwX3N0b3JlX3BhZ2VzKCkgdG8gZW5h
YmxlIGEgY2xlYW4gYmF0Y2hpbmcNCj4gPiA+ID4+Pj4gaW1wbGVtZW50YXRpb24gaW4gWzFdLCB0
aGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIGZvbGxvd2luZyBjaGFuZ2VzOg0KPiA+ID4gPj4+Pg0K
PiA+ID4gPj4+PiAxKSBBZGRpdGlvbiBvZiB6c3dhcF9hbGxvY19lbnRyaWVzKCkgd2hpY2ggd2ls
bCBhbGxvY2F0ZSB6c3dhcA0KPiBlbnRyaWVzIGZvcg0KPiA+ID4gPj4+PiAgICAgIGFsbCBwYWdl
cyBpbiB0aGUgc3BlY2lmaWVkIHJhbmdlIGZvciB0aGUgZm9saW8sIHVwZnJvbnQuIElmIHRoaXMg
ZmFpbHMsDQo+ID4gPiA+Pj4+ICAgICAgd2UgcmV0dXJuIGFuIGVycm9yIHN0YXR1cyB0byB6c3dh
cF9zdG9yZSgpLg0KPiA+ID4gPj4+Pg0KPiA+ID4gPj4+PiAyKSBBZGRpdGlvbiBvZiB6c3dhcF9j
b21wcmVzc19wYWdlcygpIHRoYXQgY2FsbHMgenN3YXBfY29tcHJlc3MoKQ0KPiBmb3INCj4gPiA+
ID4+IGVhY2gNCj4gPiA+ID4+Pj4gICAgICBwYWdlLCBhbmQgcmV0dXJucyBmYWxzZSBpZiBhbnkg
enN3YXBfY29tcHJlc3MoKSBmYWlscywgc28NCj4gPiA+ID4+Pj4gICAgICB6c3dhcF9zdG9yZV9w
YWdlKCkgY2FuIGNsZWFudXAgcmVzb3VyY2VzIGFsbG9jYXRlZCBhbmQgcmV0dXJuDQo+IGFuDQo+
ID4gPiA+PiBlcnJvcg0KPiA+ID4gPj4+PiAgICAgIHN0YXR1cyB0byB6c3dhcF9zdG9yZSgpLg0K
PiA+ID4gPj4+Pg0KPiA+ID4gPj4+PiAzKSBBICJzdG9yZV9wYWdlc19mYWlsZWQiIGxhYmVsIHRo
YXQgaXMgYSBjYXRjaC1hbGwgZm9yIGFsbCBmYWlsdXJlIHBvaW50cw0KPiA+ID4gPj4+PiAgICAg
IGluIHpzd2FwX3N0b3JlX3BhZ2VzKCkuIFRoaXMgZmFjaWxpdGF0ZXMgY2xlYW5lciBlcnJvciBo
YW5kbGluZw0KPiB3aXRoaW4NCj4gPiA+ID4+Pj4gICAgICB6c3dhcF9zdG9yZV9wYWdlcygpLCB3
aGljaCB3aWxsIGJlY29tZSBpbXBvcnRhbnQgZm9yIElBQQ0KPiBjb21wcmVzcw0KPiA+ID4gPj4+
PiAgICAgIGJhdGNoaW5nIGluIFsxXS4NCj4gPiA+ID4+Pj4NCj4gPiA+ID4+Pj4gWzFdOiBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtDQo+ID4gPiBtbS9saXN0Lz9z
ZXJpZXM9OTExOTM1DQo+ID4gPiA+Pj4+DQo+ID4gPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IEthbmNo
YW5hIFAgU3JpZGhhciA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4NCj4gPiA+ID4+Pj4g
LS0tDQo+ID4gPiA+Pj4+ICAgIG1tL3pzd2FwLmMgfCA5Mw0KPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiA+IC0tLQ0KPiA+ID4gPj4gLS0tLS0tLS0tDQo+
ID4gPiA+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlv
bnMoLSkNCj4gPiA+ID4+Pj4NCj4gPiA+ID4+Pj4gZGlmZiAtLWdpdCBhL21tL3pzd2FwLmMgYi9t
bS96c3dhcC5jDQo+ID4gPiA+Pj4+IGluZGV4IGIwOWQxMDIzZTc3NS4uZGI4MGM2NmUyMjA1IDEw
MDY0NA0KPiA+ID4gPj4+PiAtLS0gYS9tbS96c3dhcC5jDQo+ID4gPiA+Pj4+ICsrKyBiL21tL3pz
d2FwLmMNCj4gPiA+ID4+Pj4gQEAgLTE0MDksOSArMTQwOSw1NiBAQCBzdGF0aWMgdm9pZCBzaHJp
bmtfd29ya2VyKHN0cnVjdA0KPiB3b3JrX3N0cnVjdA0KPiA+ID4gPj4gKncpDQo+ID4gPiA+Pj4+
ICAgICogbWFpbiBBUEkNCj4gPiA+ID4+Pj4gICAgKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKi8NCj4gPiA+ID4+Pj4NCj4gPiA+ID4+Pj4gK3N0YXRpYyBib29sIHpzd2FwX2NvbXBy
ZXNzX3BhZ2VzKHN0cnVjdCBwYWdlICpwYWdlc1tdLA0KPiA+ID4gPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHpzd2FwX2VudHJ5ICplbnRyaWVzW10sDQo+ID4gPiA+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1OCBucl9wYWdlcywNCj4gPiA+ID4+
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB6c3dhcF9wb29sICpwb29s
KQ0KPiA+ID4gPj4+PiArew0KPiA+ID4gPj4+PiArICAgICB1OCBpOw0KPiA+ID4gPj4+PiArDQo+
ID4gPiA+Pj4+ICsgICAgIGZvciAoaSA9IDA7IGkgPCBucl9wYWdlczsgKytpKSB7DQo+ID4gPiA+
Pj4+ICsgICAgICAgICAgICAgaWYgKCF6c3dhcF9jb21wcmVzcyhwYWdlc1tpXSwgZW50cmllc1tp
XSwgcG9vbCkpDQo+ID4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7
DQo+ID4gPiA+Pj4+ICsgICAgIH0NCj4gPiA+ID4+Pj4gKw0KPiA+ID4gPj4+PiArICAgICByZXR1
cm4gdHJ1ZTsNCj4gPiA+ID4+Pj4gK30NCj4gPiA+ID4+Pg0KPiA+ID4gPj4+IEhvdyBhYm91dCBp
bnRyb2R1Y2luZyBhIGB6c3dhcF9jb21wcmVzc19mb2xpbygpYCBpbnRlcmZhY2Ugd2hpY2gNCj4g
PiA+ID4+PiBjYW4gYmUgdXNlZCBieSBgenN3YXBfc3RvcmUoKWA/DQo+ID4gPiA+Pj4gYGBgDQo+
ID4gPiA+Pj4genN3YXBfc3RvcmUoKQ0KPiA+ID4gPj4+ICAgICAgICAgIG5yX3BhZ2VzID0gZm9s
aW9fbnJfcGFnZXMoZm9saW8pDQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiAgICAgICAgICBlbnRyaWVz
ID0genN3YXBfYWxsb2NfZW50cmllcyhucl9wYWdlcykNCj4gPiA+ID4+Pg0KPiA+ID4gPj4+ICAg
ICAgICAgIHJldCA9IHpzd2FwX2NvbXByZXNzX2ZvbGlvKGZvbGlvLCBlbnRyaWVzLCBwb29sKQ0K
PiA+ID4gPj4+DQo+ID4gPiA+Pj4gICAgICAgICAgLy8gc3RvcmUgZW50cmllcyBpbnRvIHhhcnJh
eSBhbmQgTFJVIGxpc3QNCj4gPiA+ID4+PiBgYGANCj4gPiA+ID4+Pg0KPiA+ID4gPj4+IEFuZCB0
aGlzIHZlcnNpb24gYHpzd2FwX2NvbXByZXNzX2ZvbGlvKClgIGlzIHZlcnkgc2ltcGxlIGZvciBu
b3c6DQo+ID4gPiA+Pj4gYGBgDQo+ID4gPiA+Pj4genN3YXBfY29tcHJlc3NfZm9saW8oKQ0KPiA+
ID4gPj4+ICAgICAgICAgIG5yX3BhZ2VzID0gZm9saW9fbnJfcGFnZXMoZm9saW8pDQo+ID4gPiA+
Pj4NCj4gPiA+ID4+PiAgICAgICAgICBmb3IgKGluZGV4ID0gMDsgaW5kZXggPCBucl9wYWdlczsg
KytpbmRleCkgew0KPiA+ID4gPj4+ICAgICAgICAgICAgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2Ug
PSBmb2xpb19wYWdlKGZvbGlvLCBpbmRleCk7DQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiAgICAgICAg
ICAgICAgICAgIGlmICghenN3YXBfY29tcHJlc3MocGFnZSwgJmVudHJpZXNbaW5kZXhdLCBwb29s
KSkNCj4gPiA+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+
ID4gPj4+ICAgICAgICAgIH0NCj4gPiA+ID4+Pg0KPiA+ID4gPj4+ICAgICAgICAgIHJldHVybiB0
cnVlOw0KPiA+ID4gPj4+IGBgYA0KPiA+ID4gPj4+IFRoaXMgY2FuIGJlIGVhc2lseSBleHRlbmRl
ZCB0byBzdXBwb3J0IHlvdXIgImJhdGNoZWQiIHZlcnNpb24uDQo+ID4gPiA+Pj4NCj4gPiA+ID4+
PiBUaGVuIHRoZSBvbGQgYHpzd2FwX3N0b3JlX3BhZ2UoKWAgY291bGQgYmUgcmVtb3ZlZC4NCj4g
PiA+ID4+Pg0KPiA+ID4gPj4+IFRoZSBnb29kIHBvaW50IGlzIHNpbXBsaWNpdHksIHRoYXQgd2Ug
ZG9uJ3QgbmVlZCB0byBzbGljZSBmb2xpbw0KPiA+ID4gPj4+IGludG8gbXVsdGlwbGUgYmF0Y2hl
cywgdGhlbiByZXBlYXQgdGhlIGNvbW1vbiBvcGVyYXRpb25zIGZvciBlYWNoDQo+ID4gPiA+Pj4g
YmF0Y2gsIGxpa2UgcHJlcGFyaW5nIGVudHJpZXMsIHN0b3JpbmcgaW50byB4YXJyYXkgYW5kIExS
VSBsaXN0Li4uDQo+ID4gPiA+Pg0KPiA+ID4gPj4gKzENCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtz
IGZvciB0aGUgY29kZSByZXZpZXcgY29tbWVudHMuIE9uZSBxdWVzdGlvbiB0aG91Z2g6IHdvdWxk
DQo+ID4gPiA+IGl0IG1ha2Ugc2Vuc2UgdG8gdHJhZGUtb2ZmIHRoZSBtZW1vcnkgZm9vdHByaW50
IGNvc3Qgd2l0aCB0aGUgY29kZQ0KPiA+ID4gPiBzaW1wbGlmaWNhdGlvbj8gRm9yIGluc3RhbmNl
LCBsZXRzIHNheSB3ZSB3YW50IHRvIHN0b3JlIGEgNjRrIGZvbGlvLg0KPiA+ID4gPiBXZSB3b3Vs
ZCBhbGxvY2F0ZSBtZW1vcnkgZm9yIDE2IHpzd2FwIGVudHJpZXMsIGFuZCBsZXRzIHNheSBvbmUg
b2YNCj4gPiA+ID4gdGhlIGNvbXByZXNzaW9ucyBmYWlscywgd2Ugd291bGQgZGVhbGxvY2F0ZSBt
ZW1vcnkgZm9yIGFsbCAxNiB6c3dhcA0KPiA+ID4gPiBlbnRyaWVzLiBDb3VsZCB0aGlzIGxlYWQg
dG8genN3YXBfZW50cnkga21lbV9jYWNoZSBzdGFydmF0aW9uIGFuZA0KPiA+ID4gPiBzdWJzZXF1
ZW50IHpzd2FwX3N0b3JlKCkgZmFpbHVyZXMgaW4gbXVsdGlwbGUgcHJvY2Vzc2VzIHNjZW5hcmlv
cz8NCj4gPiA+DQo+ID4gPiBBaCwgSSBnZXQgeW91ciBjb25zaWRlcmF0aW9uLiBCdXQgaXQncyB0
aGUgdW5saWtlbHkgY2FzZSwgcmlnaHQ/DQo+ID4gPg0KPiA+ID4gSWYgdGhlIGNhc2UgeW91IG1l
bnRpb25lZCBhYm92ZSBoYXBwZW5zIGEgbG90LCBJIHRoaW5rIHllcywgd2Ugc2hvdWxkDQo+ID4g
PiBvcHRpbWl6ZSBpdHMgbWVtb3J5IGZvb3RwcmludCB0byBhdm9pZCBhbGxvY2F0aW9uIGFuZCBk
ZWFsbG9jYXRpb24uDQo+ID4NCj4gPiBUaGFua3MgQ2hlbmdtaW5nLiBJIHNlZSB5b3VyIHBvaW50
LiBMZXQgbWUgZ2F0aGVyIHBlcmZvcm1hbmNlIGRhdGENCj4gPiBmb3IgdGhlIHR3byBvcHRpb25z
LCBhbmQgc2hhcmUuDQo+IA0KPiBZZWFoIEkgdGhpbmsgd2Ugc2hvdWxkbid0IG9wdGltaXplIGZv
ciB0aGUgdW5jb21tb24gY2FzZSwgbm90IHVudGlsDQo+IHRoZXJlJ3MgYSByZWFsIHByb2JsZW0g
dGhhdCBuZWVkcyBmaXhpbmcuDQoNCkFncmVlZC4NCg0KPiANCj4gPg0KPiA+ID4NCj4gPiA+IE9u
IHRoZSBvdGhlciBoYW5kLCB3ZSBzaG91bGQgY29uc2lkZXIgYSBmb2xpbyB3b3VsZCBiZSBjb21w
cmVzc2VkDQo+ID4gPiBzdWNjZXNzZnVsbHkgaW4gbW9zdCBjYXNlcy4gU28gd2UgaGF2ZSB0byBh
bGxvY2F0ZSBhbGwgZW50cmllcw0KPiA+ID4gZXZlbnR1YWxseS4NCj4gPiA+DQo+ID4gPiBCYXNl
ZCBvbiB5b3VyIGNvbnNpZGVyYXRpb24sIEkgdGhpbmsgeW91ciB3YXkgaXMgb2sgdG9vLCBhbHRo
b3VnaA0KPiA+ID4gSSB0aGluayB0aGUgcGF0Y2ggMi8yIHNob3VsZCBiZSBkcm9wcGVkLCBzaW5j
ZSBpdCBoaWRlcyBwYWdlcyBsb29wDQo+ID4gPiBpbiBzbWFsbGVyIGZ1bmN0aW9ucywgYXMgWW9z
cnkgbWVudGlvbmVkIHRvby4NCj4gPg0KPiA+IE15IG1haW4gaW50ZW50IHdpdGggcGF0Y2ggMi8y
IHdhcyB0byBzZXQgdXAgdGhlIGVycm9yIGhhbmRsaW5nDQo+ID4gcGF0aCB0byBiZSBjb21tb24g
YW5kIHNpbXBsZXIsIHdoZXRoZXIgZXJyb3JzIHdlcmUgZW5jb3VudGVyZWQNCj4gPiBkdXJpbmcg
Y29tcHJlc3Npb24venBvb2xfbWFsbG9jL3hhcnJheSBzdG9yZS4gSGVuY2UsIEkgaW5pdGlhbGl6
ZSB0aGUNCj4gPiBhbGxvY2F0ZWQgenN3YXBfZW50cnkncyBoYW5kbGUgaW4genN3YXBfYWxsb2Nf
ZW50cmllcygpIHRvIEVSUl9QVFIoLQ0KPiBFSU5WQUwpLA0KPiA+IHNvIGl0IGlzIGVhc3kgZm9y
IHRoZSBjb21tb24gZXJyb3IgaGFuZGxpbmcgY29kZSBpbiBwYXRjaCAyIHRvIGRldGVybWluZQ0K
PiA+IGlmIHRoZSBoYW5kbGUgd2FzIGFsbG9jYXRlZCAoYW5kIGhlbmNlIG5lZWRzIHRvIGJlIGZy
ZWVkKS4gVGhpcyBiZW5lZml0cw0KPiA+IHRoZSBiYXRjaGluZyBjb2RlIGJ5IGVsaW1pbmF0aW5n
IHRoZSBuZWVkIHRvIG1haW50YWluIHN0YXRlIGFzIHRvIHdoaWNoDQo+ID4gc3RhZ2Ugb2YgenN3
YXBfc3RvcmVfcGFnZXMoKSBzZWVzIGFuIGVycm9yLCBiYXNlZCBvbiB3aGljaCByZXNvdXJjZXMN
Cj4gPiB3b3VsZCBuZWVkIHRvIGJlIGRlbGV0ZWQuDQo+ID4NCj4gPiBNeSBrZXkgY29uc2lkZXJh
dGlvbiBpcyB0byBrZWVwIHRoZSBiYXRjaGluZyBlcnJvciBoYW5kbGluZyBjb2RlIHNpbXBsZSwN
Cj4gPiBoZW5jZSB0aGVzZSBjaGFuZ2VzIGluIHBhdGNoIDIuIFRoZSBjaGFuZ2VzIGRlc2NyaWJl
ZCBhYm92ZSB3b3VsZA0KPiA+IGhlbHAgYmF0Y2hpbmcsIGFuZCBzaG91bGQgbm90IGltcGFjdCB0
aGUgbm9uLWJhdGNoaW5nIGNhc2UsIGFzIGluZGljYXRlZA0KPiA+IGJ5IHRoZSByZWdyZXNzaW9u
IHRlc3RpbmcgZGF0YSBJJ3ZlIGluY2x1ZGVkIGluIHRoZSBjb3ZlciBsZXR0ZXIuDQo+ID4NCj4g
PiBJIGRvbid0IG1pbmQgaW5saW5pbmcgdGhlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBoZWxwZXIg
ZnVuY3Rpb25zLCBhcyBJDQo+ID4gbWVudGlvbmVkIGluIG15IHJlc3BvbnNlIHRvIFlvc3J5LiBJ
IGFtIGhvcGluZyB0aGUgZXJyb3IgaGFuZGxpbmcNCj4gPiBzaW1wbGlmaWNhdGlvbnMgYXJlIGFj
Y2VwdGFibGUsIHNpbmNlIHRoZXkgd2lsbCBoZWxwIHRoZSBiYXRjaGluZyBjb2RlLg0KPiANCj4g
SSB0aGluayBoYXZpbmcgdGhlIGxvb3BzIG9wZW4tY29kZWQgc2hvdWxkIHN0aWxsIGJlIGJldHRl
ciB0aGFuDQo+IHNlcGFyYXRlIGhlbHBlcnMuIEJ1dCBJIHVuZGVyc3RhbmQgbm90IHdhbnRpbmcg
dG8gaGF2ZSB0aGUgbG9vcHMNCj4gZGlyZWN0bHkgaW4genN3YXBfc3RvcmUoKSwgYXMgdGhlIGVy
cm9yIGhhbmRsaW5nIHdvdWxkIGJlIHNpbXBsZXIgaWYNCj4gd2UgZG8gaXQgaW4gYSBzZXBhcmF0
ZSBmdW5jdGlvbiBsaWtlIHpzd2FwX3N0b3JlX3BhZ2VzKCkuDQo+IA0KPiBIb3cgYWJvdXQgd2Ug
anVzdCBtb3ZlIHRoZSBsb29wIGZyb20gIHpzd2FwX3N0b3JlKCkgdG8NCj4genN3YXBfc3RvcmVf
cGFnZSgpIGFuZCBjYWxsIGl0IHpzd2FwX3N0b3JlX2ZvbGlvKCk/IFdoZW4gYmF0Y2hpbmcgaXMN
Cj4gYWRkZWQgSSBpbWFnaW5lIHdlIG1heSBuZWVkIHRvIHNwbGl0IHRoZSBsb29wIGludG8gdHdv
IGxvb3BzIGJlZm9yZQ0KPiBhbmQgYWZ0ZXIgenN3YXBfY29tcHJlc3NfZm9saW8oKSwgd2hpY2gg
aXNuJ3QgdmVyeSBuZWF0IGJ1dCBpcw0KPiBwcm9iYWJseSBmaW5lLg0KDQpTdXJlLCB0aGlzIHNv
dW5kcyBsaWtlIGEgZ29vZCB3YXkgdG8gb3JnYW5pemUgdGhlIGNvZGUuIEkgd2lsbCBwcm9jZWVk
DQphcyBzdWdnZXN0ZWQuDQoNClRoYW5rcywNCkthbmNoYW5hDQo=

