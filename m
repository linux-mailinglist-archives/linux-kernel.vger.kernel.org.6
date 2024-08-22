Return-Path: <linux-kernel+bounces-297635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC4195BBB4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B403E28A510
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F381CCEC9;
	Thu, 22 Aug 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fX2cXHOe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979EE1CE71A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343592; cv=fail; b=I47ThL7FMa6rVWMiGMX+6o1aXMgGqM5BLHYN8Mscy5I3qEw6qp9SfPZwlUg0uUI+KzDhorDdrj7PAP3wKc/dz6hEYHcVyBb8LTSU9tDSWaiGbZBNrJdky6ZqAaqPy2de1ZTstDzdtvmDpwN0QmeCdAiTDHoDEbJnwgfZLnfoobY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343592; c=relaxed/simple;
	bh=URKCXc/MqFHiWVpavl303vyVaHRrJXAK8DashlCuudg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sHgtrUVOTtyF+bvBRfv+QnlrgNKgGGUFfvKMMyFkrXqy1R3ICUbihy2A2VCZWmrftrOtjsNLtXZDYKR1o3DFH9JnPYOQCMsKuSSV8dKsFeDBDYMl7PiSZ9DCSVjPf5vTEtgWbYe/wzmwRu/NKnljxgB7oSj2KpXzfHOz28VYPZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fX2cXHOe; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724343590; x=1755879590;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=URKCXc/MqFHiWVpavl303vyVaHRrJXAK8DashlCuudg=;
  b=fX2cXHOeDd5gVirafGqmyD9wMGtHzsxsbe2Fl2HPW1beTcLMpqjMfaIp
   5K9+oHhO1S5eeov+sdKCk+YlDmTJNwrrOEDq4FlabQc5/2aiX8dg2cm31
   tkyA7qB+jfiHeWKjq+VWvDvh2IC681ReTASOZ/SEcZ6VJNaO2oR1F/d/E
   tMerH7l1tu3ff2S9/cK5S21BBcQjsuJJuq9kAixblrAeP2TYilk9sq5BL
   9xXlkaWHND1TqaVNBBf4z00ZyUnb1FWuCwopDc2SvfzGcwPvsx+NMTwPt
   664gqnrciDmfyeoF+MlvyYlKR41ajjGGGCnG3s+m/HX4ZzED0Pk/+FLDe
   w==;
X-CSE-ConnectionGUID: ZLzK2boeS4qceezSsVtJRA==
X-CSE-MsgGUID: eZNrPvRYSsakjwdjQH7LOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22650287"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22650287"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 09:19:49 -0700
X-CSE-ConnectionGUID: 7sYX1MEMQeSTGI1fSiyJzQ==
X-CSE-MsgGUID: 9U8MRPQLQbisPRbD0pmFGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66333730"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 09:19:50 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 09:19:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 09:19:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 09:19:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEsZODs72dlt3DaNfNh8MPwbpccnJBFIbRd5QxLpogqlfT0zKo0MXJJsFqHQhSMS8YiaGSEcL8CC2iHzsNjkw0kpqtPb26YP1iW7lpru0GdI6A/G8Xfo5gqfrQ5IotEGbh33J3PjV/fScNpW/iKtleMPMjjbSJFBbIZZcWK2KGgjeJscBCZVGBctCaRjO0GANT0UUrJABYarIgVllZ2shvUezB03/reAi/LAd/sifWOkV9DtOzvPGOLZc/+eT+GTWHjGMSGF4pPH96ivNt9ofchTbwosNrP2yKAPhe5LZ8kNcZtGH/DKRtgZj1Fyqyd8GwzyfdVsqqfIO9pDT2Vr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URKCXc/MqFHiWVpavl303vyVaHRrJXAK8DashlCuudg=;
 b=naA35aoDGm+86TLDeUuCzgHKHwqinBvRbPnCBXrpzvlf0j9EQhAuAKhLpWNroSqo4Qy/kIIoQlvlEbGPHtXdV63fyd4wnHwXuYxdT+JSzuGtVzBf/7oS21AEu8LwMI7gzPQWbyJjUy6xMJ81Gj32qXd5BIFPVhKhG73XPibrEIPqpRPgPuziQwwnQ4N87dp/YJvmmbrYyF/pHkqHNnNHsreL9/8syXBjr6kMAAj8TaIOgawGxEBT8UI4QVCh09/t+vl7RKCrFVFWZFTQU6iNW5V3FzSfagPcjZuACvGpFDEVTs51bvjsgv6l1ICBuqrrZCJXhMoIq2TqEmqsjbl/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH7PR11MB8058.namprd11.prod.outlook.com (2603:10b6:510:24d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 16:19:41 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 16:19:41 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Michal Hocko <mhocko@suse.com>
CC: Nhat Pham <nphamcs@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "yosryahmed@google.com"
	<yosryahmed@google.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: Defines obj_cgroup_get() if CONFIG_MEMCG is not
 defined.
Thread-Topic: [PATCH v1] mm: Defines obj_cgroup_get() if CONFIG_MEMCG is not
 defined.
Thread-Index: AQHa8zownmBKtHWwPk69pMRSa2JXJ7IyGPSAgAADIMCAALKRgIAAqLRw
Date: Thu, 22 Aug 2024 16:19:41 +0000
Message-ID: <SJ0PR11MB5678C68754B7CC837E947F41C98F2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240820195005.5941-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=N-xuQume6C+xq0LfhVNOaK9rOiz_0c39GfoBB-4+6eng@mail.gmail.com>
 <SJ0PR11MB5678BCBBA46F1AA205A274F2C98E2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <ZsbXR6NKM7yOLODb@tiehlicka>
In-Reply-To: <ZsbXR6NKM7yOLODb@tiehlicka>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH7PR11MB8058:EE_
x-ms-office365-filtering-correlation-id: d31a455f-2388-4b59-653d-08dcc2c63a35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bnRqWnZySjZMd0xnM21mT0xIaVFaTDV6VjR1OTU2ZGovMjFPQnVTL0VCSlVC?=
 =?utf-8?B?NjI3VkpvaDlZMGx2cFJkdlNaZDhXMGpyVXBFNzhmMENGT3oySGlBam1uR1BO?=
 =?utf-8?B?NzRqcXhoejZtUWhReTNKVStMNFpsMTFPVmFnQlUzUVIrcTYrM0JjYWdIby9o?=
 =?utf-8?B?SGNmcitjWlNnbHJmLzhDVnR2T2F0b01yY2lYUkx5U0xjbU9kR0FMc21QenlU?=
 =?utf-8?B?Wm5wWUtKQmhwYmp0MC9vOXlaVWFtMlcrQnFHYlRCNkdRd3hpbWNIak8vR3lZ?=
 =?utf-8?B?SHdrZWYrWnMySjBxN0ZFMXBZU3ptVDVnUEUyc3hyWUxhWjQ0M0JETUphc3ZP?=
 =?utf-8?B?QTVzaHF6ZmtGaFVia2FYYmswR2pmU0owWnlwcTlJa0FYMkxReWtCa0w2dlVR?=
 =?utf-8?B?RE1seUhHY0x0c0pQdUNSemZvTkVuYUxmZjg2QlVZQmxPUWM1cERCNklpL2tW?=
 =?utf-8?B?L0pITWRzVmdWUlB6TVN4anhPZFBtVHBaTnpvUHh4b1VmN3ZLTXNLQUNSOHB1?=
 =?utf-8?B?NEgvYXJxakx6bjVrV0FyWDBZL1RMRGRkMG8ybi9qUWJVNnR3VGlyRzFSMDN0?=
 =?utf-8?B?TVRZTyttQWE1R1FCcHBtRDFXc0REQWd0c0xleit1RjBzTGNSTjhYNlRJNjRW?=
 =?utf-8?B?YWJlYjFQNmJKR1V5VXRpK2NURElVU0xWV0FPQ0F5dzYvRnVXaS9sMUNZUUtX?=
 =?utf-8?B?a0lEQmJIT2YxdnkwYy8yeSt2Rmt3VXV0SVdTZzVlSWJWYi9zaDhzMXZTb0ls?=
 =?utf-8?B?UktpQkM4NWQxMVZIZFZuMFdRTExBdGhGdlRmM283c0Q1TWFjVzdzYk9CUUJ6?=
 =?utf-8?B?b0JQTEhHOTVrT2xoVW9nN1d4M3lLZFZSWktVTkRQd0JNNXhtZ0dYTXpHVDZO?=
 =?utf-8?B?OUlybXYyTFNlRzl2c1hjOEJHaThTWURvR3RwYWRQZVZHQ056SDBNVkpCNHpi?=
 =?utf-8?B?dzBhVGYwUmpYaXRSUlZweGlKK3p0VURKN2tOVmkwZGpQRzRxWnptd01DVzZL?=
 =?utf-8?B?dGVYTG41ejJJdENyTnVCcjlhLzVhLzNVeGYwcjNuM2syemdrMXlhV1pHWFVt?=
 =?utf-8?B?TWdvQ0ZZUG9tRjVUV2t1ZkdQbGtzWndWUzV2ZjFmUkIxc1hZUkNHc0lxdWVK?=
 =?utf-8?B?ejNQZXdmUE4zWWdMV2pQNC8xUmVkcXU1a1JzZi9vaG1QOGFJeVY1OW1PRkJF?=
 =?utf-8?B?UXV0SVZvVTc0NnJhRWo3WGxERkg2eFVKN2FXbkt5b0lESWJicUV1T3RRenJF?=
 =?utf-8?B?QzczVFZ1WmxQWktiQTlmSjZoMEhWWk1ZU2d1NUh2T0RJNDVNVXZpVWs3ZS9R?=
 =?utf-8?B?d3pTdHRhNkVBaFRJYzBZNWdXblVHTUhpaWlMeWRtK3htMHpqbmZIemhlK0ph?=
 =?utf-8?B?NjZucEw4dkM2cjA4bS91VmVIYkx2cWlFaGlvY3RhSTRMRGxZYTdhWGtkQ3Yx?=
 =?utf-8?B?V2JlVFBXZ3Zoc05JNDNhUVhocFVJTXJCKy9OY1UxVTIwTWZXdFZmYzA2dWJT?=
 =?utf-8?B?NUxRSng2NnBXZmpQelBZTFRlb2hZL1F6V0RURWM1cjBnRmRvVk56Umozc2Ix?=
 =?utf-8?B?ZFJueExQS3lvT29kZXhPeEdJWWhTR2VhcFNTNVpKdjRJVUJlaU5ZN2RYUlIw?=
 =?utf-8?B?eEhHdm5VY1VNTmszOHRqYXRNUnpneVhqUzVGWjBYMlhzWncyQ2hFVmFMZU1C?=
 =?utf-8?B?eUdZTlBpSVVWNWtuNytuVmNQUWs4VEgwS3VxeUI3WTB0MHRKc2dnWkpnOGtZ?=
 =?utf-8?B?Ri9NK1VzN01BTldxREIzU0NNQUZjcEwrUjNCYzB3aFdZc1pZZDZGODF1Kzht?=
 =?utf-8?B?N0dxQzN3WnNPRWtpRWpxVmRUL0hEd0tSNVU5YUpnaWRCdVZMeDh5NlFqanBY?=
 =?utf-8?B?czVsTlNCQzhzSFNEVXFrTTZzbkVHbVJEMWl2ZFZDTTBMSkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3Vndk0rV1FXUU1MWjNUQXMvTXBvayt2N056Um4yYmZBTHBYdUdzT0w2Y2FN?=
 =?utf-8?B?ZTVWMkdqRmg1eGUzazFjMUp4SWJVRUxQR1FVUGE2SGhET3QvSEZaMEdGandM?=
 =?utf-8?B?cnI3MHI3c09LVHlVc3lFOWNqU1IrdW9TMUhDbUh2WldEeENSNWF1VWNCSmlR?=
 =?utf-8?B?azlrYTRnMHA1MS9TYXR5QWNrZ3FmYXJ2c210eC9TWkhpOWlkc2JCUEZEblF6?=
 =?utf-8?B?aTFlT0NISEgxVGRqeFgxemVEQU5XY2RuSTFWdU1aYWZzaGlLZkpCVm5OdnRP?=
 =?utf-8?B?c0VOMXZsVkVUbGxCT202Vlk2VVU0blF0Z0FTZTQyZTl2RnptQk9TcEFFbHNX?=
 =?utf-8?B?QnZ3WDQ2N0JmeTAyWVZ3d3FvN0Z3VnZFZkJCTGphQStxUzBjaU5IMGg4cURq?=
 =?utf-8?B?Rm4yTGZYZSs1aDlyNzdFekFWSXFhak5MVWFsT1lxTGRkWnUwcmFmZG9sOTVz?=
 =?utf-8?B?RGxnZTNxdC9RY0l6RG1seXd3WWozclVBdm14dzFrcGFMNEMyRkxZeFZDYmpX?=
 =?utf-8?B?VW1xYk8vMkV6YkthUTZDVEUxK2JTUm9FVlhGU29tYmVnaGZCWXduY0NTZFR0?=
 =?utf-8?B?L2FxRnZqdlBHbS9ORkUvMDBWc0kvUGhnVlFPWDI2Skw4OE5JVDFhL3hQZnJ2?=
 =?utf-8?B?Sm5tY21zM21Dak8xTlI3K2ZuNERCQWhTbHRsRmZ1VGQ1eGZ1SDM2L2lJTUlX?=
 =?utf-8?B?MVhDZkttZ3FCcnhpbnFYcHgvMWc1bWViazZFU0R0eE9zZUd0VlJQSVJjVndl?=
 =?utf-8?B?OGtFODJndnJKZ3A5MUhtcGxhcWFMb2hOblRJVFlsVy9kdXdvRnR0RllOTXIw?=
 =?utf-8?B?cDFSM2NXejhwZlhqZkdHQk5SRVBqb2lTeEtBZ05KOURnVGZDbDRyd0gySnZ6?=
 =?utf-8?B?WW81STBVdjUvS1BCblByd2lGSmNjMVdIdzJwM0p0Q0R5c25LbHpkbVdIMjNO?=
 =?utf-8?B?NVhVWi85WWNrMW1uaW42L2FJcC9nb1hFNUdRbmdvcHd0bDFCa3pRQVF5MkJk?=
 =?utf-8?B?ZGJjSnJDbXZMRlhXQ3hOYWR3dVhRL1Mvd1dZQk0zTjBzNnlScTJIOXFScjZR?=
 =?utf-8?B?ZjczN1Jrd3hnVEUxSW9wV0liWTc1ejFLdEQxSWpyTW8vZi9kNlpnTXkwb3V4?=
 =?utf-8?B?bzFYTC82UEJwK215M3RlS3BQNWYwTnBsQ3ZkdTg2VDFkTWdjM0tnTlVXOHBW?=
 =?utf-8?B?ZHIwMXBhRzVGZ3FMQi93cFpnYVMxMXZUWHNjQzl2aHAxdW1SRFdSWjV1OXJC?=
 =?utf-8?B?d0JpK1g2L3hmRkZzSWhVNkx2Tk1sWEtmcUp4dmxaTXdKdHhvdHRCY0gyZnlq?=
 =?utf-8?B?a3lSWENsWHlaLzdDdmNHZmpXWW42ZkNjSmF4NnZWUFoySjdsT0pNYU0vaW9W?=
 =?utf-8?B?b1pVZlRJaFZxL01BVXhwUEZMOFd2OCthVTEzTWVZWTZmdXJjSjhHcnU5bXN6?=
 =?utf-8?B?d1FudHR6RTNyUE1Ycy9xRldXbUhKUFRUdm1pNEFhdmIwMDROWXZOMk9NWm93?=
 =?utf-8?B?TFlvaUdORS9Tb1FuUVBPOXRHeWlTeHlobkQyc1NQSDQ3elZqTWwvTm95K0dh?=
 =?utf-8?B?TUFvU0pCMytMTjRXS2VLU3JlRlNielcvWm9CV1pMcXB5Q0NNdk1kNU0yUThC?=
 =?utf-8?B?aUNwVUV6SFRRNDRTU285dGZlUVFrM09vakJNV0hTTjNVUk85VURrVU5MK0JO?=
 =?utf-8?B?a3Q2cUJyaWEvTnZZUDBoUmRoOCtLZ25PZDZIZG4wWjNrbXFVdTBWcFZ6Tld4?=
 =?utf-8?B?UWF1Q09JL1Z0R01ZSmFKVVVCdDl6d0ZYOTNzb0ZOZDJ2T0E3MmxWVzE5bE01?=
 =?utf-8?B?ckZoRXJQQ0twZ1ZBOXRiTzcwNEN2dVRzVEhyc005U284UzhEZTBpNTZEMmRT?=
 =?utf-8?B?SnJLRjYvNUxHY1ZlbmZMdFYyZ1ZuSzRpV3Y0T2cxK1hnL0FZbE1UQW5ac1lL?=
 =?utf-8?B?TFFyVExUNlc3TDRBQlRrb3V2VElhWjNNc0hvY2dwYXVLSC80NlZWU3llN09j?=
 =?utf-8?B?NEVHWVlFNGtmOXh2WlBBQUdSV0hXVmgwOFE1RU9ETXVHbFJ4QmJTU1NtMWgy?=
 =?utf-8?B?UERxOFdyUC9pSXVnbG5VWUdvVnRLcmV3ajBRanIxczJNRDJmOWEwNHYrYmVi?=
 =?utf-8?B?WDgxK0VQMTBDOStobkVXa045SUd5Y1Ruc2wyTzBEUlVXSTg3N3VhVlV3MWFF?=
 =?utf-8?B?ZXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d31a455f-2388-4b59-653d-08dcc2c63a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 16:19:41.5290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56waTrMZrEcJX+9Hd7tNOn30NMbJnBIs6t/V2z1EBaiCXd8a4n4IEdtDg5HjxL+aUlmupJz1sN5KEkUu2dK7e8Uo5t9F+Nfk1YZwmcWMylc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8058
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pY2hhbCBIb2NrbyA8bWhv
Y2tvQHN1c2UuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyMSwgMjAyNCAxMToxNSBQ
TQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNv
bT4NCj4gQ2M6IE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+OyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC0NCj4gbW1Aa3ZhY2sub3JnOyBoYW5uZXNAY21weGNoZy5vcmc7
IHlvc3J5YWhtZWRAZ29vZ2xlLmNvbTsNCj4gcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZ
aW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47DQo+IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnOyBab3UsIE5hbmhhaQ0KPiA8bmFuaGFpLnpvdUBpbnRlbC5jb20+
OyBGZWdoYWxpLCBXYWpkaSBLIDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsNCj4gR29wYWws
IFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MV0gbW06IERlZmluZXMgb2JqX2Nncm91cF9nZXQoKSBpZiBDT05GSUdfTUVNQ0cgaXMNCj4gbm90
IGRlZmluZWQuDQo+IA0KPiBPbiBXZWQgMjEtMDgtMjQgMTk6NDA6NDIsIFNyaWRoYXIsIEthbmNo
YW5hIFAgd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NAZ21haWwuY29tPg0KPiA+ID4gU2VudDogV2VkbmVz
ZGF5LCBBdWd1c3QgMjEsIDIwMjQgMTI6MjQgUE0NCj4gPiA+IFRvOiBTcmlkaGFyLCBLYW5jaGFu
YSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsNCj4gPiA+IGhhbm5lc0BjbXB4
Y2hnLm9yZzsgeW9zcnlhaG1lZEBnb29nbGUuY29tOw0KPiByeWFuLnJvYmVydHNAYXJtLmNvbTsN
Cj4gPiA+IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwu
Y29tOyBha3BtQGxpbnV4LQ0KPiA+ID4gZm91bmRhdGlvbi5vcmc7IFpvdSwgTmFuaGFpIDxuYW5o
YWkuem91QGludGVsLmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPiA+IDx3YWpkaS5rLmZlZ2hh
bGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4g
PiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIG1tOiBEZWZpbmVzIG9ial9jZ3JvdXBfZ2V0KCkg
aWYgQ09ORklHX01FTUNHDQo+IGlzDQo+ID4gPiBub3QgZGVmaW5lZC4NCj4gPiA+DQo+ID4gPiBP
biBUdWUsIEF1ZyAyMCwgMjAyNCBhdCAzOjUw4oCvUE0gS2FuY2hhbmEgUCBTcmlkaGFyDQo+ID4g
PiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+
IFRoaXMgcmVzb2x2ZXMgYW4gaXNzdWUgd2l0aCBvYmpfY2dyb3VwX2dldCgpIG5vdCBiZWluZyBk
ZWZpbmVkDQo+ID4gPiA+IGlmIENPTkZJR19NRU1DRyBpcyBub3QgZGVmaW5lZC4gVGhpcyBjYXVz
ZXMgYnVpbGQgZXJyb3JzIGlmDQo+ID4gPiA+IG9ial9jZ3JvdXBfZ2V0KCkgaXMgY2FsbGVkIGZy
b20gY29kZSB0aGF0IGlzIGFnbm9zdGljIG9mDQo+IENPTkZJR19NRU1DRy4NCj4gPiA+ID4NCj4g
PiA+ID4gVGhlIHBhdGNoIHJlc29sdmVzIHRoaXMuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEthbmNoYW5hIFAgU3JpZGhhciA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4N
Cj4gPiA+ID4gLS0tDQo+ID4gPg0KPiA+ID4gVGhpcyBpcyBvbmx5IGV4cG9zZWQgYmVjYXVzZSBv
ZiB5b3VyIHpzd2FwIG1USFAgcGF0Y2ggc2VyaWVzIHJpZ2h0Pw0KPiA+ID4gQ291bGQgeW91IGlu
Y2x1ZGUgdGhpcyBwYXRjaCBhcyBwYXJ0IG9mIHRoYXQgc2VyaWVzIChzaW5jZSB3ZSBkb24ndA0K
PiA+ID4gbmVlZCB0aGlzIHdpdGhvdXQgdGhhdCBwYXRjaCBzZXJpZXMpLCBvciBtYWtlIGl0IGNs
ZWFyIGluIHRoZSBjaGFuZ2UNCj4gPiA+IGxvZz8NCj4gPg0KPiA+IFRoYXQncyBjb3JyZWN0LCBO
aGF0LiBBbHRob3VnaCwgaXQgbWlnaHQgYmUgdXNlZnVsIHRvIGhhdmUgb2JqX2Nncm91cF9nZXQo
KQ0KPiA+IGRlZmluZWQgaW4gdGhlIGNhc2Ugd2hlcmUgQ09ORklHX01FTUNHIGlzIG5vdCBkZWZp
bmVkLiBtZW1jb250cm9sLmgNCj4gPiBoYW5kbGVzIG9ial9jZ3JvdXBfcHV0KCkgc2ltaWxhcmx5
LiBXb3VsZCBpdCBiZSBPayBpZiBJIGluY2x1ZGVkIGEgcmVmZXJlbmNlDQo+ID4gdG8gdGhlIHpz
d2FwIG1USFAgcGF0Y2ggc2VyaWVzIGluIHRoZSBjaGFuZ2UgbG9nPw0KPiANCj4gSSB3b3VsZCBq
dXN0IGZvbGQgaXQgaW50byB0aGUgcGF0Y2ggd2hpY2ggZXhwb3NlcyB1c2Ugd2l0aG91dA0KPiBD
T05GSUdfTUVNQ0cuIFdlIGN1cnJlbnRseSBkbyBub3QgaGF2ZSBhbnkgc3VjaCB1c2VyLiBUaGF0
J3Mgd2h5IEkndmUNCj4gYXNrZWQgd2hhdCBpcyB0aGlzIHBhdGNoIGJhc2VkIG9uLg0KDQpPaywg
dGhpcyBzb3VuZHMgZ29vZCwgTWljaGFsIGFuZCBOaGF0Lg0KDQpUaGFua3MsDQpLYW5jaGFuYQ0K
DQo+IC0tDQo+IE1pY2hhbCBIb2Nrbw0KPiBTVVNFIExhYnMNCg==

