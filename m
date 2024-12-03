Return-Path: <linux-kernel+bounces-428697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3A99E1236
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341CB282BE0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42780170A37;
	Tue,  3 Dec 2024 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edrQGt0U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45D32C85
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 04:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733199544; cv=fail; b=S1c8RWp0qdc5XWdmtDxcElNgFZxAo2bHgX1VsIKWF0m/Q+UhvqT7xrPodaiaDBANvBL7+wzJw2q1rmsGSiRIrgHEfo7OflBefP+jQyq3nRhaLWcRvyawQGwyXKnjXpZiIcEXQeozqeoA3EuJ+tbD/rLTK1m9GWmgJhShgJTqsdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733199544; c=relaxed/simple;
	bh=p/74P/t6UCt7lsoAAYmApbRCUna1foacHEriH4D83UM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aENSOX5A8+b49M29dH+W3jl9nbAQzo7ffKshEim4BEoIppM5R/jmiYDocRLtrZCtTzNSUOdWjy8BzgdT2E8WmrgWtkDyAG9lHoLtkPv6RiocYkWwUDVOOa0EseC8Gd1M0TpOoiS1m0WFWo6RdVEn1NlE03xZGfpWbvprW7ksBss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edrQGt0U; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733199543; x=1764735543;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p/74P/t6UCt7lsoAAYmApbRCUna1foacHEriH4D83UM=;
  b=edrQGt0UVr7HhRoboWcWwkYJEwN9o0FN/0hqNr9M22NHMlOMov0Uh6uL
   KatVTScHHuLo5cAyqvFo84WUmnVttWmHgYN3wEzgRcccYTCfwIrWXYfsz
   j/neNrSROULemVf3m+zObSRXFVTZ/HbYuSao4UkbBtPuiWa0YVeEzE9Br
   ym8Tl6/S5UHYhEGQQGUs0nvS6jLniaS9ehW37XxwvqBsxQYTcDn+q9Uys
   YmZiL72jtQSwXqF/M6kpgV0Sbu3X0s3iPWFc5AZg9xWvHCGNhMM62z+2R
   PY9MvvE8LauajmOTIWZp+P53hCg6IVWfVfnxaxaQowock4hh1XKaxVyx+
   w==;
X-CSE-ConnectionGUID: 5uaitacoSvuCsuYQ9zZr4g==
X-CSE-MsgGUID: glP7SSEKRO68Zf3OrsnSNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33140345"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33140345"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 20:19:02 -0800
X-CSE-ConnectionGUID: kmHNU8sfR9W89sa7leuzdA==
X-CSE-MsgGUID: ohsFRjT6T0KQCvGzut6G/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93640285"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 20:19:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 20:19:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 20:19:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 20:19:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jg8DasrKpyrY9t2s0q+KXTUAXLUDyyjaU2Y7yPmeshnfT+kRjlD3TGmm8UvJMdXH6aRUtFcr7cjHtzZA2bKG6pDT9sspeFk3Yx2PKK8uxNzhX4z2y01swsICAO4dFh5n+WdiT3oRV/QVy3FR2oeZ1cI6J3Tu6n0VxSU0//I6KXoWET77vgWQZGF4JZE0ylrq1rosLXLbQ6FEPaV2nIvqU4Qi+e9CJshhp2WLzSVVzY7TDodEV/HdLOgyI/8AJ+Bu+tNl8+CAw8iIdx/YI2IdRSi1kgGeamkLdyk4AJO+4ksCpQPrV1tNqKfVHJzrskBusrZCp5AKdvYhvYrbycRAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/74P/t6UCt7lsoAAYmApbRCUna1foacHEriH4D83UM=;
 b=uEFRLTnuHycypE6lnED4IttguBths9chMVWABaWsZaXAwVQT17fB/JjEJ4bBQTvPvcHkmDKQ6FyQblkbKA5Fa6xp7N+pvq3MSPxPT8RPQZC+C5VM8UNl0DfN0l2RibkGv42vBTAuKG4sDOKxxI+6UXgEFFFxr9m0eu4fnQR+uFUquT0roPCgsWf7DOY0zSVqpUk8VTt0UdThncwl3g6FhFFsX1xmnad77neeDsmUBft73uGySaO61lfvE3KmQR8pMgLmFbl4oDdJyNzrx4QfEhVcfxnHieH2RIYkotaStMyHUVzYYjkVg0OGiA6gSWFqQUlj1I9YaMTEDG08p03n+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CO1PR11MB4897.namprd11.prod.outlook.com (2603:10b6:303:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 04:18:58 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 04:18:58 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Chengming Zhou <chengming.zhou@linux.dev>, Yosry Ahmed
	<yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications for
 batching.
Thread-Topic: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications
 for batching.
Thread-Index: AQHbQR8zjJv99UT6akiirMMuSrWTzbLMRDGAgAcbawCAAFSwsIAAKiWAgAAN/XA=
Date: Tue, 3 Dec 2024 04:18:57 +0000
Message-ID: <SJ0PR11MB56780123C601DFD5FF46C2A1C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
 <20241127225324.6770-3-kanchana.p.sridhar@intel.com>
 <c9a0f00b-3aeb-467a-8771-a4ebb57fbba0@linux.dev>
 <CAJD7tkbPSQguHegkzN65==GHuNN9_RPm1FonnF8Bi=BsQDhxng@mail.gmail.com>
 <SJ0PR11MB56781233ABFE772C5991AB01C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <045a786d-7b13-4127-82ce-57510565bd15@linux.dev>
In-Reply-To: <045a786d-7b13-4127-82ce-57510565bd15@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CO1PR11MB4897:EE_
x-ms-office365-filtering-correlation-id: 2847bc52-b628-4b5c-f4f3-08dd13519b8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RFpvQ2xEVU0wQnc5MWhHV0RqVHg1THFPV2xUTnJkRHJJODVFSkhaQkR4Smtu?=
 =?utf-8?B?bGEwditSalFrbkx3b2Z4aXZJZTlzVlZjSFVpdWFLT3hDNnF2ZDdKTmlwRFp0?=
 =?utf-8?B?UDA5VllyU3hHQ0RJRUZWNGQrTktvVEVQSjQrWFZ4UHNaOHZiUGcyZU1rLzVD?=
 =?utf-8?B?TnNLUk1HeWp4eE02dWxDakpVYWc3V1JwNEtldVhheHNYVUE1dEdnM3NOUkc3?=
 =?utf-8?B?NEJ4ZTBLSkd4RlB2VFVkZE02QnEzLzkvcGdFMkxyQnJjNnpnQjhDMHN6ejFt?=
 =?utf-8?B?ZGlJVmU0WE40ZEJKYThKMEJCSWtNY001SGpnb2J6cGRiaXYyK1pjQ2tIYjdo?=
 =?utf-8?B?SUo2dTdtZzkzTXRTSGpIbXVkbHZ6SGZTb2pDeFRPcXYxbTNwamtRSkY1WjJF?=
 =?utf-8?B?eU1UUXlQOVJobjI0SUpoWlFXWm5tMmdDemdtUHI5Y3JLZXhzbDhZUnNFOGs2?=
 =?utf-8?B?TkhGQ0M5VUo5MGxHTXFpTi9NdE9MY1pYbjREVG85SFp6NGJWYmUyY3JBd1pk?=
 =?utf-8?B?cXdheWVVL0ZjZG5lN3ZtRDJweFFNUTBjRFdqcHd3UWRwelcvc1hpeXE3Zi84?=
 =?utf-8?B?dTJMb0ZFdDF6a3Z5VkdJRWtSMldVeEFBd0t0SHkzaDZhWlVhMG1DNGFNdkhw?=
 =?utf-8?B?eEdnemt6dTJaemc5VEJEVHdvenZPUytYSG93b2tPUXBlOVMvV0xqdXorYnpT?=
 =?utf-8?B?WlE1TE5hbVVydU1HRGhEcWU2N2IwN3BCdHNUTnM5MVhZK3RnN0pnYzlHMElv?=
 =?utf-8?B?LzAzTklEL043V2czSnZuMldzV2RhWitueFowU1NpaFZHaGdZd0VUNUtKUzN5?=
 =?utf-8?B?SFVuYUw1ZEpKM0V1angwa1VHVmVMZGhKMmVLOFE2amEwb1BSbnFNTnFNdzcr?=
 =?utf-8?B?eDlNRGNTN0xUWmxyVEFOSm5WTVIyTlVVeHNWTytYNzlqUnkvbmJXZkhRK1FW?=
 =?utf-8?B?TWw2Ync2ZWFYSzBnQnZvbmZuQUtvcmtrVURZd1lwWlVBTDN5SndYYjc0Z0JD?=
 =?utf-8?B?dzRPL01ZNXVhUUZHWU9wbktWOFNHMDA0Q09lM0d1OFVwRjk1YWV3dklTdEE0?=
 =?utf-8?B?V0VObTlqTU52a3pEbVo1aTVZZkp1aUVUOW5vQ2daUFd6TGNkeW1ZOVBMeXJF?=
 =?utf-8?B?OXMwdUZ4YjZhdEpnVXVia0lOcnFWUDV6MGloMGtSTHdsNHJFY2pFRGErWVIz?=
 =?utf-8?B?NFRYN2JoMjZlR2dvOGRZQmxBNXRCM1RWRjhrb1lhSXFwZExPNzFoMzc5dms5?=
 =?utf-8?B?dS9QTmRLUDdVS3dibnBmWEVpSTZvUnMxU0pqTmdvQXpJT0N4Z1BrMmY2THNq?=
 =?utf-8?B?UTRPdVlYc1R1SjJiLzk3MTJNT3ZqaXNqY1phcFgvYi84amhHelV4TmVrN3Q2?=
 =?utf-8?B?VmlNMXZJSUk0TTFoMEFvVm90WEJVc0lOS0dZN1BqcnNNbUF0UnJvUmpUeFgx?=
 =?utf-8?B?K2VFRU1PNDRiNURWVnlZZFg2TCtLbDR3MmVqUHpKaUx3UkQ0N0Z6K29iMGRq?=
 =?utf-8?B?SE1VQml4R0orbGgzTmp3elR1bnFlcmlMODcraUYxdlI5YUJrR1VmczErLzk3?=
 =?utf-8?B?YVpsbjlady8yQWQ2ZDZlZTkyQXZseHd5ZEJCU25kek12dC84MmMrd3VSVHFt?=
 =?utf-8?B?eHJBMHpYUUlrWmxvNm5sVFpBOVZ3Sk54MDRxVVlKUGVpYk5nUHA4NVQyait0?=
 =?utf-8?B?L3doS1BuNHdrRTVKZC9nV24zcmxDWUhsWWY0NUsvVGhuVGdaNVpBRzVlTzMx?=
 =?utf-8?B?R0VWK0FlUWVHbytwMFhmQmRvWklKaFVaaVBKZEJaK3h3STdaZHVVamVWZFEv?=
 =?utf-8?B?d1ZJZUN2aDArVXQrYzFnVi85VVAwYVZ2bnJSQk5MSnBVb1F2L2xmMXM3TzlP?=
 =?utf-8?B?MUhzNnVncGNxQ3FzU0ZQRnFMcXp2dHY3dUFWQVpuTmxyM2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzJwc0lSSUFaeFB0S0s0L0Z3NktjMTJLUlNpeU54eWlIbkNvR2xyRTQ2bXlP?=
 =?utf-8?B?cUhJektreFN5b0Y3a05zZmRnOUU1bkVlekpwQWJpTjdxeDl2eHMycExiWVVs?=
 =?utf-8?B?elkra2lZcHM5NmlUZFFqS0JzNXMwQmlXUHluckxGSjU3R2lFbGI2V3dBNmRQ?=
 =?utf-8?B?WFJ3QlBtRjA3Sy9iZEM0Zy8xbmZ3RnlraEpYa1FYeTlpMm1Ib2dIN2RqVDBh?=
 =?utf-8?B?d01WMXgwQThFQkRTckg3dzJWSEVPQUtRQU8vYUFjdER6b1BYT28vWi9SYWd3?=
 =?utf-8?B?WXpXL0JSRllTYmJtekpaQjZXVW1JNHdSa0hrNXdyUTVxaldjMi9UUG9FcGQ2?=
 =?utf-8?B?MXZWTUE5aW1Bd29uM0ZEZWU3ZDk2R0xkUitLR09vaXBaNEVFc01keEtOMDZa?=
 =?utf-8?B?K0hEUWxHZ2RmR3BqdmxjNXRBYWlZdnFKdzd2ZlQ4K09BWG9UZEw4cVVhSzla?=
 =?utf-8?B?aHZaYjAyK1RkVUo1L0Z4VFd6NE94eDBRQllVdS9zamxVMjR5YStVQWlJN3ll?=
 =?utf-8?B?TjZLUVpjRm4rVnhUeDNWeGJuTkJ3YUdoVG9OcXZTQnpPVmg0ZExiVVRjTGIx?=
 =?utf-8?B?VEN2bzZ5czlVTysxRElGcDlVeS9IaFV5YkJweEw5WThNZ1JZZzQ5WHRpU0RT?=
 =?utf-8?B?eTJnK3NhMW1tSHhhS1c3MlVjNE1CK21JUk5nbFpwZXpkZE1rR0FEREtMYk15?=
 =?utf-8?B?SFcvWi90WWNpT1hZTHcwRXljTXZOcnJUK0RWMGZ4eEJ2eHhBR3ljLy8vNmZB?=
 =?utf-8?B?emVqRWY3MWI0MzVnV2tGS2FmYkUySDR5Z2RTOGU5Mm5oRnlGa3krSUFBUEZF?=
 =?utf-8?B?OFlwVDFkMXpHZk1HRnZlM1RrUkFnUDByc1FhbTdOOFJsWW9aYUVDNnhFUGhw?=
 =?utf-8?B?K0EweFpteWlEUGhQUFRqOFdXS1BteUdvVTZ3UHNzQ1NYSnpkK3BXZExLMFdH?=
 =?utf-8?B?a2d5VzRvYmRSZi8va2hyVXhVVndOQnk1dkM3TTJEMlloVGQvUnVzUW92bGF6?=
 =?utf-8?B?SmEwc3hhSGk1bERGb2piZm9tR000TDFIMGxnZkZHSXp5c3lBajFHTUxoemRD?=
 =?utf-8?B?U0FmUWpFdDNCYVMxMXhrZllBVW56YUFaS0duNVRKbmlHVFBqWnhaWm81ZWpJ?=
 =?utf-8?B?aUxIS3Q5WkRGemZSQVN3STZJT0FXSnYvQXR1cjNUNzROeGQzOFlDV1l3OUEr?=
 =?utf-8?B?Nm5xNlNJUy9WTnp3RHNlYUx5Q3ZYaFJHeFEyTHh3SmZDOWFhMVFuRis5YnA0?=
 =?utf-8?B?OUtYNWdKSlBuOVJEVzhTaU1YRmxZRTFBVnBHdXpKcXlacmRKN25DLzJXTFo3?=
 =?utf-8?B?Z3BiekxYZzlheHY3djZsc1V3MFhCN1RWZTZXY2s3bk5kTmkrQnhNWGxnLy9O?=
 =?utf-8?B?U25VbHROaUNFN0NtemorVlllU1JGZkhGeUVpbzBURWFyeEt0aW1tbjFKSVhY?=
 =?utf-8?B?K0tlK1Z5TlRTNWI0eG0wODB2UWFUSXZKNXNtNTIwb2M0VW9MNkRWNWczVjdx?=
 =?utf-8?B?YWF0bGZIYzVKR2E0cVJsRlo2T2IxcmFDVHVkUkZlNmJsVmxOTDgvdkdhR1p3?=
 =?utf-8?B?SWVOR2FpSlFSYXhHaFdDNi9ZRGtSUk1vcEp2anlnb3hUVTZOTmJONnhBOTRm?=
 =?utf-8?B?Nk5PKzhmdUVOT2paNExoV2JacCt2ZTlRYVRtN3kvZFhpMDhOaDVkbGZFek45?=
 =?utf-8?B?c2V4V2w2eWlHcWZ1cEJYWktQYnF0WHhZeWFZbXliZXBTNXZETGZwR1pROEVH?=
 =?utf-8?B?eUhXQWM0VTdhZU5aUXVWSVF2ZUQ0YnNMVjBuRGNlbE5qd2JZNFRmb1BydE5q?=
 =?utf-8?B?K3h5VkxpUjdhT0IzQjdJdmpkOFJjWmFwaGpWTEJMZ1lTekY3WERyOGlGQW4v?=
 =?utf-8?B?TVpBQWFZeGJOYlFrdDg4SDBMaXM2MW9BakljRGRpTVpLMFJXV2UvYVB5NTlB?=
 =?utf-8?B?cFc4L2Q0SmJScUg4TW5oaDgrTklzZm1QTDhnZENLN3RSVUV5dy94TmZMMVhZ?=
 =?utf-8?B?MTROQ3Y2Z3ZBUHE2SVBaczRXcTA3UWUxaExKRjJaemhycWg5akd1eTRlajhY?=
 =?utf-8?B?K0NjWEp2emFpL3o1VkNPKzIyV3FZVncyNE5uelhpQjExM1ZQa21CdHAvNzBZ?=
 =?utf-8?B?ZXFrcnB5bWZ0L2NnWkdzdkJ5ampvWjhKSEEyVzZVVlcxUEEwUzl5VURndUhE?=
 =?utf-8?B?UWVkV3lIWCsxdlRyd2lHQUEwRUprS2JqZFhITlo4dkFGTnh3dGpBa0s0R2tB?=
 =?utf-8?B?YmhtdmdwRElvWGE1b3E0U3kyN3ZBPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2847bc52-b628-4b5c-f4f3-08dd13519b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 04:18:57.9057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SmYYCa2hiYm2jTdC4av+di0EoNCxGAvqVQi5yhO/9hcH0NdoGaGz68vE1eLtnAJOueKvQwFF4XNrOs9P3a1J81n29be99x4JOKQUH0ilza8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4897
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENoZW5nbWluZyBaaG91IDxj
aGVuZ21pbmcuemhvdUBsaW51eC5kZXY+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMiwgMjAy
NCA3OjA2IFBNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJA
aW50ZWwuY29tPjsgWW9zcnkgQWhtZWQNCj4gPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gQ2M6
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsNCj4gaGFu
bmVzQGNtcHhjaGcub3JnOyBucGhhbWNzQGdtYWlsLmNvbTsgdXNhbWFhcmlmNjQyQGdtYWlsLmNv
bTsNCj4gcnlhbi5yb2JlcnRzQGFybS5jb207IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4
LWZvdW5kYXRpb24ub3JnOw0KPiBGZWdoYWxpLCBXYWpkaSBLIDx3YWpkaS5rLmZlZ2hhbGlAaW50
ZWwuY29tPjsgR29wYWwsIFZpbm9kaA0KPiA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MSAyLzJdIG1tOiB6c3dhcDogenN3YXBfc3RvcmVfcGFnZXMoKSBz
aW1wbGlmaWNhdGlvbnMNCj4gZm9yIGJhdGNoaW5nLg0KPiANCj4gT24gMjAyNC8xMi8zIDA5OjAx
LCBTcmlkaGFyLCBLYW5jaGFuYSBQIHdyb3RlOg0KPiA+IEhpIENoZW5nbWluZywgWW9zcnksDQo+
ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogWW9zcnkgQWht
ZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciAy
LCAyMDI0IDExOjMzIEFNDQo+ID4+IFRvOiBDaGVuZ21pbmcgWmhvdSA8Y2hlbmdtaW5nLnpob3VA
bGludXguZGV2Pg0KPiA+PiBDYzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlk
aGFyQGludGVsLmNvbT47IGxpbnV4LQ0KPiA+PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1tbUBrdmFjay5vcmc7IGhhbm5lc0BjbXB4Y2hnLm9yZzsNCj4gPj4gbnBoYW1jc0BnbWFpbC5j
b207IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOw0KPiA+PiAy
MWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgRmVnaGFsaSwgV2Fq
ZGkgSw0KPiA+PiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZp
bm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMi8yXSBt
bTogenN3YXA6IHpzd2FwX3N0b3JlX3BhZ2VzKCkNCj4gc2ltcGxpZmljYXRpb25zDQo+ID4+IGZv
ciBiYXRjaGluZy4NCj4gPj4NCj4gPj4gT24gV2VkLCBOb3YgMjcsIDIwMjQgYXQgMTE6MDDigK9Q
TSBDaGVuZ21pbmcgWmhvdQ0KPiA+PiA8Y2hlbmdtaW5nLnpob3VAbGludXguZGV2PiB3cm90ZToN
Cj4gPj4+DQo+ID4+PiBPbiAyMDI0LzExLzI4IDA2OjUzLCBLYW5jaGFuYSBQIFNyaWRoYXIgd3Jv
dGU6DQo+ID4+Pj4gSW4gb3JkZXIgdG8gc2V0IHVwIHpzd2FwX3N0b3JlX3BhZ2VzKCkgdG8gZW5h
YmxlIGEgY2xlYW4gYmF0Y2hpbmcNCj4gPj4+PiBpbXBsZW1lbnRhdGlvbiBpbiBbMV0sIHRoaXMg
cGF0Y2ggaW1wbGVtZW50cyB0aGUgZm9sbG93aW5nIGNoYW5nZXM6DQo+ID4+Pj4NCj4gPj4+PiAx
KSBBZGRpdGlvbiBvZiB6c3dhcF9hbGxvY19lbnRyaWVzKCkgd2hpY2ggd2lsbCBhbGxvY2F0ZSB6
c3dhcCBlbnRyaWVzIGZvcg0KPiA+Pj4+ICAgICAgYWxsIHBhZ2VzIGluIHRoZSBzcGVjaWZpZWQg
cmFuZ2UgZm9yIHRoZSBmb2xpbywgdXBmcm9udC4gSWYgdGhpcyBmYWlscywNCj4gPj4+PiAgICAg
IHdlIHJldHVybiBhbiBlcnJvciBzdGF0dXMgdG8genN3YXBfc3RvcmUoKS4NCj4gPj4+Pg0KPiA+
Pj4+IDIpIEFkZGl0aW9uIG9mIHpzd2FwX2NvbXByZXNzX3BhZ2VzKCkgdGhhdCBjYWxscyB6c3dh
cF9jb21wcmVzcygpIGZvcg0KPiA+PiBlYWNoDQo+ID4+Pj4gICAgICBwYWdlLCBhbmQgcmV0dXJu
cyBmYWxzZSBpZiBhbnkgenN3YXBfY29tcHJlc3MoKSBmYWlscywgc28NCj4gPj4+PiAgICAgIHpz
d2FwX3N0b3JlX3BhZ2UoKSBjYW4gY2xlYW51cCByZXNvdXJjZXMgYWxsb2NhdGVkIGFuZCByZXR1
cm4gYW4NCj4gPj4gZXJyb3INCj4gPj4+PiAgICAgIHN0YXR1cyB0byB6c3dhcF9zdG9yZSgpLg0K
PiA+Pj4+DQo+ID4+Pj4gMykgQSAic3RvcmVfcGFnZXNfZmFpbGVkIiBsYWJlbCB0aGF0IGlzIGEg
Y2F0Y2gtYWxsIGZvciBhbGwgZmFpbHVyZSBwb2ludHMNCj4gPj4+PiAgICAgIGluIHpzd2FwX3N0
b3JlX3BhZ2VzKCkuIFRoaXMgZmFjaWxpdGF0ZXMgY2xlYW5lciBlcnJvciBoYW5kbGluZyB3aXRo
aW4NCj4gPj4+PiAgICAgIHpzd2FwX3N0b3JlX3BhZ2VzKCksIHdoaWNoIHdpbGwgYmVjb21lIGlt
cG9ydGFudCBmb3IgSUFBIGNvbXByZXNzDQo+ID4+Pj4gICAgICBiYXRjaGluZyBpbiBbMV0uDQo+
ID4+Pj4NCj4gPj4+PiBbMV06IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9s
aW51eC0NCj4gbW0vbGlzdC8/c2VyaWVzPTkxMTkzNQ0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9m
Zi1ieTogS2FuY2hhbmEgUCBTcmlkaGFyIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0K
PiA+Pj4+IC0tLQ0KPiA+Pj4+ICAgIG1tL3pzd2FwLmMgfCA5MyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0NCj4gLS0tDQo+ID4+IC0tLS0tLS0tLQ0KPiA+Pj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4gPj4+
Pg0KPiA+Pj4+IGRpZmYgLS1naXQgYS9tbS96c3dhcC5jIGIvbW0venN3YXAuYw0KPiA+Pj4+IGlu
ZGV4IGIwOWQxMDIzZTc3NS4uZGI4MGM2NmUyMjA1IDEwMDY0NA0KPiA+Pj4+IC0tLSBhL21tL3pz
d2FwLmMNCj4gPj4+PiArKysgYi9tbS96c3dhcC5jDQo+ID4+Pj4gQEAgLTE0MDksOSArMTQwOSw1
NiBAQCBzdGF0aWMgdm9pZCBzaHJpbmtfd29ya2VyKHN0cnVjdCB3b3JrX3N0cnVjdA0KPiA+PiAq
dykNCj4gPj4+PiAgICAqIG1haW4gQVBJDQo+ID4+Pj4gICAgKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKi8NCj4gPj4+Pg0KPiA+Pj4+ICtzdGF0aWMgYm9vbCB6c3dhcF9jb21wcmVz
c19wYWdlcyhzdHJ1Y3QgcGFnZSAqcGFnZXNbXSwNCj4gPj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHpzd2FwX2VudHJ5ICplbnRyaWVzW10sDQo+ID4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHU4IG5yX3BhZ2VzLA0KPiA+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgenN3YXBfcG9vbCAqcG9vbCkNCj4gPj4+PiArew0K
PiA+Pj4+ICsgICAgIHU4IGk7DQo+ID4+Pj4gKw0KPiA+Pj4+ICsgICAgIGZvciAoaSA9IDA7IGkg
PCBucl9wYWdlczsgKytpKSB7DQo+ID4+Pj4gKyAgICAgICAgICAgICBpZiAoIXpzd2FwX2NvbXBy
ZXNzKHBhZ2VzW2ldLCBlbnRyaWVzW2ldLCBwb29sKSkNCj4gPj4+PiArICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+Pj4+ICsgICAgIH0NCj4gPj4+PiArDQo+ID4+Pj4gKyAg
ICAgcmV0dXJuIHRydWU7DQo+ID4+Pj4gK30NCj4gPj4+DQo+ID4+PiBIb3cgYWJvdXQgaW50cm9k
dWNpbmcgYSBgenN3YXBfY29tcHJlc3NfZm9saW8oKWAgaW50ZXJmYWNlIHdoaWNoDQo+ID4+PiBj
YW4gYmUgdXNlZCBieSBgenN3YXBfc3RvcmUoKWA/DQo+ID4+PiBgYGANCj4gPj4+IHpzd2FwX3N0
b3JlKCkNCj4gPj4+ICAgICAgICAgIG5yX3BhZ2VzID0gZm9saW9fbnJfcGFnZXMoZm9saW8pDQo+
ID4+Pg0KPiA+Pj4gICAgICAgICAgZW50cmllcyA9IHpzd2FwX2FsbG9jX2VudHJpZXMobnJfcGFn
ZXMpDQo+ID4+Pg0KPiA+Pj4gICAgICAgICAgcmV0ID0genN3YXBfY29tcHJlc3NfZm9saW8oZm9s
aW8sIGVudHJpZXMsIHBvb2wpDQo+ID4+Pg0KPiA+Pj4gICAgICAgICAgLy8gc3RvcmUgZW50cmll
cyBpbnRvIHhhcnJheSBhbmQgTFJVIGxpc3QNCj4gPj4+IGBgYA0KPiA+Pj4NCj4gPj4+IEFuZCB0
aGlzIHZlcnNpb24gYHpzd2FwX2NvbXByZXNzX2ZvbGlvKClgIGlzIHZlcnkgc2ltcGxlIGZvciBu
b3c6DQo+ID4+PiBgYGANCj4gPj4+IHpzd2FwX2NvbXByZXNzX2ZvbGlvKCkNCj4gPj4+ICAgICAg
ICAgIG5yX3BhZ2VzID0gZm9saW9fbnJfcGFnZXMoZm9saW8pDQo+ID4+Pg0KPiA+Pj4gICAgICAg
ICAgZm9yIChpbmRleCA9IDA7IGluZGV4IDwgbnJfcGFnZXM7ICsraW5kZXgpIHsNCj4gPj4+ICAg
ICAgICAgICAgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBmb2xpb19wYWdlKGZvbGlvLCBpbmRl
eCk7DQo+ID4+Pg0KPiA+Pj4gICAgICAgICAgICAgICAgICBpZiAoIXpzd2FwX2NvbXByZXNzKHBh
Z2UsICZlbnRyaWVzW2luZGV4XSwgcG9vbCkpDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPiA+Pj4gICAgICAgICAgfQ0KPiA+Pj4NCj4gPj4+ICAgICAgICAg
IHJldHVybiB0cnVlOw0KPiA+Pj4gYGBgDQo+ID4+PiBUaGlzIGNhbiBiZSBlYXNpbHkgZXh0ZW5k
ZWQgdG8gc3VwcG9ydCB5b3VyICJiYXRjaGVkIiB2ZXJzaW9uLg0KPiA+Pj4NCj4gPj4+IFRoZW4g
dGhlIG9sZCBgenN3YXBfc3RvcmVfcGFnZSgpYCBjb3VsZCBiZSByZW1vdmVkLg0KPiA+Pj4NCj4g
Pj4+IFRoZSBnb29kIHBvaW50IGlzIHNpbXBsaWNpdHksIHRoYXQgd2UgZG9uJ3QgbmVlZCB0byBz
bGljZSBmb2xpbw0KPiA+Pj4gaW50byBtdWx0aXBsZSBiYXRjaGVzLCB0aGVuIHJlcGVhdCB0aGUg
Y29tbW9uIG9wZXJhdGlvbnMgZm9yIGVhY2gNCj4gPj4+IGJhdGNoLCBsaWtlIHByZXBhcmluZyBl
bnRyaWVzLCBzdG9yaW5nIGludG8geGFycmF5IGFuZCBMUlUgbGlzdC4uLg0KPiA+Pg0KPiA+PiAr
MQ0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgY29kZSByZXZpZXcgY29tbWVudHMuIE9uZSBxdWVz
dGlvbiB0aG91Z2g6IHdvdWxkDQo+ID4gaXQgbWFrZSBzZW5zZSB0byB0cmFkZS1vZmYgdGhlIG1l
bW9yeSBmb290cHJpbnQgY29zdCB3aXRoIHRoZSBjb2RlDQo+ID4gc2ltcGxpZmljYXRpb24/IEZv
ciBpbnN0YW5jZSwgbGV0cyBzYXkgd2Ugd2FudCB0byBzdG9yZSBhIDY0ayBmb2xpby4NCj4gPiBX
ZSB3b3VsZCBhbGxvY2F0ZSBtZW1vcnkgZm9yIDE2IHpzd2FwIGVudHJpZXMsIGFuZCBsZXRzIHNh
eSBvbmUgb2YNCj4gPiB0aGUgY29tcHJlc3Npb25zIGZhaWxzLCB3ZSB3b3VsZCBkZWFsbG9jYXRl
IG1lbW9yeSBmb3IgYWxsIDE2IHpzd2FwDQo+ID4gZW50cmllcy4gQ291bGQgdGhpcyBsZWFkIHRv
IHpzd2FwX2VudHJ5IGttZW1fY2FjaGUgc3RhcnZhdGlvbiBhbmQNCj4gPiBzdWJzZXF1ZW50IHpz
d2FwX3N0b3JlKCkgZmFpbHVyZXMgaW4gbXVsdGlwbGUgcHJvY2Vzc2VzIHNjZW5hcmlvcz8NCj4g
DQo+IEFoLCBJIGdldCB5b3VyIGNvbnNpZGVyYXRpb24uIEJ1dCBpdCdzIHRoZSB1bmxpa2VseSBj
YXNlLCByaWdodD8NCj4gDQo+IElmIHRoZSBjYXNlIHlvdSBtZW50aW9uZWQgYWJvdmUgaGFwcGVu
cyBhIGxvdCwgSSB0aGluayB5ZXMsIHdlIHNob3VsZA0KPiBvcHRpbWl6ZSBpdHMgbWVtb3J5IGZv
b3RwcmludCB0byBhdm9pZCBhbGxvY2F0aW9uIGFuZCBkZWFsbG9jYXRpb24uDQoNClRoYW5rcyBD
aGVuZ21pbmcuIEkgc2VlIHlvdXIgcG9pbnQuIExldCBtZSBnYXRoZXIgcGVyZm9ybWFuY2UgZGF0
YQ0KZm9yIHRoZSB0d28gb3B0aW9ucywgYW5kIHNoYXJlLg0KDQo+IA0KPiBPbiB0aGUgb3RoZXIg
aGFuZCwgd2Ugc2hvdWxkIGNvbnNpZGVyIGEgZm9saW8gd291bGQgYmUgY29tcHJlc3NlZA0KPiBz
dWNjZXNzZnVsbHkgaW4gbW9zdCBjYXNlcy4gU28gd2UgaGF2ZSB0byBhbGxvY2F0ZSBhbGwgZW50
cmllcw0KPiBldmVudHVhbGx5Lg0KPiANCj4gQmFzZWQgb24geW91ciBjb25zaWRlcmF0aW9uLCBJ
IHRoaW5rIHlvdXIgd2F5IGlzIG9rIHRvbywgYWx0aG91Z2gNCj4gSSB0aGluayB0aGUgcGF0Y2gg
Mi8yIHNob3VsZCBiZSBkcm9wcGVkLCBzaW5jZSBpdCBoaWRlcyBwYWdlcyBsb29wDQo+IGluIHNt
YWxsZXIgZnVuY3Rpb25zLCBhcyBZb3NyeSBtZW50aW9uZWQgdG9vLg0KDQpNeSBtYWluIGludGVu
dCB3aXRoIHBhdGNoIDIvMiB3YXMgdG8gc2V0IHVwIHRoZSBlcnJvciBoYW5kbGluZw0KcGF0aCB0
byBiZSBjb21tb24gYW5kIHNpbXBsZXIsIHdoZXRoZXIgZXJyb3JzIHdlcmUgZW5jb3VudGVyZWQN
CmR1cmluZyBjb21wcmVzc2lvbi96cG9vbF9tYWxsb2MveGFycmF5IHN0b3JlLiBIZW5jZSwgSSBp
bml0aWFsaXplIHRoZQ0KYWxsb2NhdGVkIHpzd2FwX2VudHJ5J3MgaGFuZGxlIGluIHpzd2FwX2Fs
bG9jX2VudHJpZXMoKSB0byBFUlJfUFRSKC1FSU5WQUwpLA0Kc28gaXQgaXMgZWFzeSBmb3IgdGhl
IGNvbW1vbiBlcnJvciBoYW5kbGluZyBjb2RlIGluIHBhdGNoIDIgdG8gZGV0ZXJtaW5lDQppZiB0
aGUgaGFuZGxlIHdhcyBhbGxvY2F0ZWQgKGFuZCBoZW5jZSBuZWVkcyB0byBiZSBmcmVlZCkuIFRo
aXMgYmVuZWZpdHMNCnRoZSBiYXRjaGluZyBjb2RlIGJ5IGVsaW1pbmF0aW5nIHRoZSBuZWVkIHRv
IG1haW50YWluIHN0YXRlIGFzIHRvIHdoaWNoDQpzdGFnZSBvZiB6c3dhcF9zdG9yZV9wYWdlcygp
IHNlZXMgYW4gZXJyb3IsIGJhc2VkIG9uIHdoaWNoIHJlc291cmNlcw0Kd291bGQgbmVlZCB0byBi
ZSBkZWxldGVkLg0KDQpNeSBrZXkgY29uc2lkZXJhdGlvbiBpcyB0byBrZWVwIHRoZSBiYXRjaGlu
ZyBlcnJvciBoYW5kbGluZyBjb2RlIHNpbXBsZSwNCmhlbmNlIHRoZXNlIGNoYW5nZXMgaW4gcGF0
Y2ggMi4gVGhlIGNoYW5nZXMgZGVzY3JpYmVkIGFib3ZlIHdvdWxkDQpoZWxwIGJhdGNoaW5nLCBh
bmQgc2hvdWxkIG5vdCBpbXBhY3QgdGhlIG5vbi1iYXRjaGluZyBjYXNlLCBhcyBpbmRpY2F0ZWQN
CmJ5IHRoZSByZWdyZXNzaW9uIHRlc3RpbmcgZGF0YSBJJ3ZlIGluY2x1ZGVkIGluIHRoZSBjb3Zl
ciBsZXR0ZXIuDQoNCkkgZG9uJ3QgbWluZCBpbmxpbmluZyB0aGUgaW1wbGVtZW50YXRpb24gb2Yg
dGhlIGhlbHBlciBmdW5jdGlvbnMsIGFzIEkNCm1lbnRpb25lZCBpbiBteSByZXNwb25zZSB0byBZ
b3NyeS4gSSBhbSBob3BpbmcgdGhlIGVycm9yIGhhbmRsaW5nDQpzaW1wbGlmaWNhdGlvbnMgYXJl
IGFjY2VwdGFibGUsIHNpbmNlIHRoZXkgd2lsbCBoZWxwIHRoZSBiYXRjaGluZyBjb2RlLg0KDQo+
IA0KPiA+DQo+ID4gSW4gb3RoZXIgd29yZHMsIGFsbG9jYXRpbmcgZW50cmllcyBpbiBzbWFsbGVy
IGJhdGNoZXMgLS0gbW9yZSBzcGVjaWZpY2FsbHksDQo+ID4gb25seSB0aGUgY29tcHJlc3MgYmF0
Y2hzaXplIC0tIHNlZW1zIHRvIHN0cmlrZSBhIGJhbGFuY2UgaW4gdGVybXMgb2YNCj4gPiBtZW1v
cnkgZm9vdHByaW50LCB3aGlsZSBtaXRpZ2F0aW5nIHRoZSBzdGFydmF0aW9uIGFzcGVjdCwgYW5k
IHBvc3NpYmx5DQo+ID4gYWxzbyBoZWxwaW5nIGxhdGVuY3kgKGFsbG9jYXRpbmcgYSBsYXJnZSAj
IG9mIHpzd2FwIGVudHJpZXMgYW5kIHBvdGVudGlhbGx5DQo+ID4gZGVhbGxvY2F0aW5nLCBjb3Vs
ZCBpbXBhY3QgbGF0ZW5jeSkuDQo+IA0KPiBJZiB3ZSBjb25zaWRlciB0aGUgbGlrZWx5IGNhc2Ug
KGNvbXByZXNzIHN1Y2Nlc3NmdWxseSksIHRoZSB3aG9sZQ0KPiBsYXRlbmN5IHNob3VsZCBiZSBi
ZXR0ZXIsIHJpZ2h0PyBTaW5jZSB3ZSBjYW4gYnVsayBhbGxvY2F0ZSBhbGwNCj4gZW50cmllcyBh
dCBmaXJzdCwgYW5kIGJ1bGsgaW5zZXJ0IHRvIHhhcnJheSBhbmQgTFJVIGF0IGxhc3QuDQoNCkkg
dGhpbmsgc28gdG9vLCBidXQgd291bGQgbGlrZSB0byBjb25maXJtIHdpdGggc29tZSBleHBlcmlt
ZW50cyBhbmQgdXBkYXRlLg0KDQo+IA0KPiA+DQo+ID4gSWYgd2UgYWdyZWUgd2l0aCB0aGUgbWVy
aXRzIG9mIHByb2Nlc3NpbmcgYSBsYXJnZSBmb2xpbyBpbiBzbWFsbGVyIGJhdGNoZXM6DQo+ID4g
dGhpcyBpbiB0dXJuIHJlcXVpcmVzIHdlIHN0b3JlIHRoZSBzbWFsbGVyIGJhdGNoZXMgb2YgZW50
cmllcyBpbiB0aGUNCj4gPiB4YXJyYXkvTFJVIGJlZm9yZSBtb3ZpbmcgdG8gdGhlIG5leHQgYmF0
Y2guIFdoaWNoIG1lYW5zIGFsbCB0aGUNCj4gPiB6c3dhcF9zdG9yZSgpIG9wcyBuZWVkIHRvIGJl
IGRvbmUgZm9yIGEgYmF0Y2ggYmVmb3JlIG1vdmluZyB0byB0aGUgbmV4dA0KPiA+IGJhdGNoLg0K
PiA+DQo+IA0KPiBCb3RoIHdheSBpcyBvayBmb3IgbWUgYmFzZWQgb24geW91ciBtZW1vcnkgZm9v
dHByaW50IGNvbnNpZGVyYXRpb24NCj4gYWJvdmUuDQoNClNvdW5kcyBnb29kLCB0aGFua3MhDQoN
ClRoYW5rcywNCkthbmNoYW5hDQoNCj4gDQo+IFRoYW5rcy4NCg==

