Return-Path: <linux-kernel+bounces-415073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAC79D3141
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA30BB23062
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3D920EB;
	Wed, 20 Nov 2024 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gypX+fm3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABCC804
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732060872; cv=fail; b=Aovpt3ARYz+fRAEVW3LuspW1jUDkU8ULFqKETukqe4tTXdWDQFVoVA2pfHq+54+6q8e6m6HP8I6+wJzB3yERwGwTg8Xuvt48nPnXuFSopA4ms4TqmrKzHOntgceqY/aANk3YtPaN3Kl+XkmNmCVVQD6zZMLMEUbPfZ56fmh4tTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732060872; c=relaxed/simple;
	bh=5R3GspeZgbcVX6nXS6IXKlDeWUbPeVSexDSq9PpYPag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hOJiSzz1L6lyLWzxpBB8WT3Ah9gJGyejduMUe16RfRfrgwr0LDiLOM6dN4tF/qksebGSuSfZlYfBOKESWY/2enPzIpcGHrfshDLF9UGcGbTopZAAXHgIjilepfPTZZUxJRBhdyVllZQkYJ/EI8WJNR3aDHVPgAflg9XyADuBKBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gypX+fm3; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732060869; x=1763596869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5R3GspeZgbcVX6nXS6IXKlDeWUbPeVSexDSq9PpYPag=;
  b=gypX+fm3R50wBcVbA35BPbAVb3N0Iid8qR8vzYZKj1y1hvMAfZhb/kxK
   /MTkccM+kaT4VmF6Pe50liHz9FsFxzUcY/S7Hoc9Vhu6JoH+Mbp6TCHHL
   pGWMvFY/N8yj9CkmKaAbmpNS39g79EupO3zhlnDlwigNyEEaazFux6xMr
   mvYWuC4K2zgdbd21jrB7+rpKMEJ962qp9lo6uMWBSrfOR3+V4RvJvk4D6
   9PHaGvpbfGkcI702t/H323rbuJli0c3x9QY9WM4sbU/pdSwogw3zlORy3
   kLeqKro19Rxh1lmZU09ctYrWls3cGDG4EyNMcsHp9OnQz7+Pf06wq2lGO
   A==;
X-CSE-ConnectionGUID: SGMzYE/7R12ht4gog4U98w==
X-CSE-MsgGUID: OAQzvqoiQEOjLSj7sVj0BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="35879428"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="35879428"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 16:01:08 -0800
X-CSE-ConnectionGUID: zmVosfGZSB2hxoAcUl6Z2Q==
X-CSE-MsgGUID: VsKukFZsSXWnIJBFOANtuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="89723684"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 16:01:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 16:01:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 16:01:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 16:01:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcaQ7uTIo1XBTYrDPtKcMCNkgOUXyl1xEtgXbWnn0YIuxBUJkRRpBlIX0RUcUVyzFpS1YUrfxwBcecnEujL7kaNBJPVSTByhFepcJm0gCNmnc+IgsNADf09Hkun0sg4nnB71+UVJLx0+fe4jEYvi44AtlPeJy/eJSAEzugCnbzAw/olQy9vXAFxHT+zDI8n/GtFLkvUYp5W5t2pvhSzVKRGNpqESavxSgZFUsHMzQyJqI4WQahbNXQNbab7BFApX8AuKbFgBpMf4Tv9Mn2KdS36xxHA4Rc9O9dTw1L/pA7OGKc91YoSZKGNBYKb/OaHRoHgcmQyXPwGtCxiakwOGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5R3GspeZgbcVX6nXS6IXKlDeWUbPeVSexDSq9PpYPag=;
 b=Fz28MhGHxEKMezJ7YVvHxiWJvGGny6kQo3vQVpsgqlPsZ80D1LqhsJvTRqZtFYkT+Q4EgCCfSMpNz60H2AaPnXuNaga+MST1dYVnORywXkcC/YwYSS1Y9UW+gHshGJQnDtwFBWTPxCJ5UViZKRuROcKQtL853G8tyxa1wNFh6XrxNDu/j6DBboe9IHF4uA7jr920TxIl8LWvgWtzyGDAwPCDoMa6rI5CXtq/b3FXypDuj/02EfY9+u3UoC6x9RU2I8tevQM1pVGGntCnxtNR7EaK59FrH40IqbiyHDvlA9vBtJygmoENVbldR8kk43dmc4NkNPLXgXbVC/s4gfbo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by MN6PR11MB8172.namprd11.prod.outlook.com (2603:10b6:208:478::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 00:00:59 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 00:00:59 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner
	<hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Topic: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Index: AQHbNYxgo97ShYNp0k+eAlG8E2BdYbK0sGWAgAAC9UCAAAo2gIAAydcggAAz64CAAATjwIAALQAAgAAWEyCAADkJgIAAFDJAgAAQz4CAAnAwsIAAE8aAgAYeOFCAAANpAIAAAiqQgAAEjwCAACdygIAAGdaAgAAD0FA=
Date: Wed, 20 Nov 2024 00:00:59 +0000
Message-ID: <SJ0PR11MB56783C77FB2C1B4669FA0B93C9212@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241113213007.GB1564047@cmpxchg.org>
 <SJ0PR11MB5678C24CDF6AA4FED306FC71C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=P6mxZ+-5UcunRHeoAVwtZD=UMfKqCGUeun-krJeT8ekg@mail.gmail.com>
 <SJ0PR11MB56785F052557B685054AF74AC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241114051149.GC1564047@cmpxchg.org>
 <SJ0PR11MB56780DD2A8EB343627FE94FCC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <9a807484-6693-4e2a-a087-97bbc5ee4ed9@linux.dev>
 <SJ0PR11MB567847C73338BC325FE49D11C9242@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZ+OM2uiHgHHeNqBeSaptfXw4MG=E280-5PKpeybB=8dQ@mail.gmail.com>
 <SJ0PR11MB5678C6C693444F64E38CE2EBC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkaMMoPjrR7mLNMiFD7nOhUoLBJ22BNQYEPvfPww5d2jTg@mail.gmail.com>
 <SJ0PR11MB5678A7DF494C3FCB687D620EC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYP9c8Dc1+fuG2i=okFbVf=jBph3cdFmOO0+vAvmcApvQ@mail.gmail.com>
 <SJ0PR11MB56780456B6808A54954D9EC9C9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZiE3PeRF=9_-ySMr7rDogGQtG9aHuwfZvpMF3uPN6aJQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZiE3PeRF=9_-ySMr7rDogGQtG9aHuwfZvpMF3uPN6aJQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|MN6PR11MB8172:EE_
x-ms-office365-filtering-correlation-id: 72668437-7349-471a-2f6c-08dd08f66a76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bzRWdG9ZSGMzUXRLdDZ2RGM3L0JHNEtUbmVFdExKMktJcWtpOVU1T0VEd1Vy?=
 =?utf-8?B?RDIwWkRiNExLSTduSFRNSTNISXdCMUgvbjRMT2JzMVRyYVdNZURTbnp3ZW0w?=
 =?utf-8?B?OHFBd3I4L0ZNbDdJK1dZeURxelNDOXdZSXZNZmd0Rk5aaTh0cVhFMFFkbkwy?=
 =?utf-8?B?WXJrSFBxWXdPOGQ4cXV2Y3M1S1ZOUnRSSW1oMnNCdmgwa0JZSnVyekJCL2FH?=
 =?utf-8?B?Y3dQTHNUaHZ1eWJLQzV1YjdFY1FFQ2FqdWoybnZCOW9yQ3pPSW9nd2x6bUVK?=
 =?utf-8?B?Smh2T2tGVVBsOXgzcUUzWUg2ZC9ON050UkJZT3FoZTM4dWFxanA2cXBTMDlM?=
 =?utf-8?B?L3BJbmFudXkxOEVON0xFejZDTndaRTJpMVlQV0pwQjlLRDMraE0zdkZlem9I?=
 =?utf-8?B?ZkxQNldNWHhTVGtCMjVTeFJVWHFpcGU2Y0tGNHRUdy9tYTFXRG01VEdOUzJB?=
 =?utf-8?B?S1pIVmJ1ditjOVlhZ0FQQ1NXWDFYNXN0MFZadE0wRTdHL1ZtdnVuQnlndmdZ?=
 =?utf-8?B?eVJ1Q1U5ZU9TVVlJQmxneDNnMG5xS08vZ2pET0JCUlZYU1NSMURvTVhDTUo4?=
 =?utf-8?B?NUIrYVpoSTQrT3g3SkRYeTNkbFR5V2FUNGhPUE5UTHRTRmtJdTduQytzTVhn?=
 =?utf-8?B?M2kwMlNhZnJqOE41WDF6OU01cjk0SWhMcWIvMmVnQkNBek1DUkVJeE5PaG8y?=
 =?utf-8?B?c0hXS2FlclJ4NUVMdEw1cHBOVTFjNnlpWEpvbGpuMVoyR3JsbWx5eGRLRUlN?=
 =?utf-8?B?MnlubnBpdWpXcmRreDJNVnZCRXcxVlRPVXFTWnlrVTI0VU81QnMvTk1xbzlR?=
 =?utf-8?B?LzVLSVhDYjFPSGpWeVVGWlNJWHdsK3lFUmg3cjNJc1R6cUVtWDJFdjVPYmZR?=
 =?utf-8?B?Um9GbmVVdzJIQ3VLdm0ySWsvMUxTUFRIREtMZ2dRN3VQSm1NOUlKSm93U2Mw?=
 =?utf-8?B?NDRFQWNCaUN2VHhwQWU3Q3NCVktwQWsycUsxcUJTajhtVm9DZW4yS2FYWU9J?=
 =?utf-8?B?ODhGY0VJZEZZZzJhS0UzZW4yK0NlUVVQQ3hCbmpsbXgrOVVFL2Q4cCtoUDcr?=
 =?utf-8?B?dWtlN1lVNCt5Zm14NGlJZnRPdUNHYVQyZmg1QXFpVmpGZkk5RVBDVGcydlZQ?=
 =?utf-8?B?Q3I0RzhTbXdJSFRWeEw2TmkrMjhCZ3JrM2gwWlZrRnFWZW5OazVhb2JCZ2t2?=
 =?utf-8?B?ZFVzbUlXN1ZidVd4amJ2dDhGZEFNZzBJS3cySXJ4QVorOU11VEFWUzhHZGJX?=
 =?utf-8?B?aC9mQjF4b28zRWJnZ3hqNS83MDFxMWtnaFJUY0xTenByYkI3YmhMakw1K0pU?=
 =?utf-8?B?Q2YwWEJzQytUK0haYTVvem4rQWYvYjBRKzdHTXE4c3lBOG9QcXpvK3huZzYv?=
 =?utf-8?B?Rk43YndBbnp1anBxOVBTcTdLSlM4T2laVGlCQXp2WWdNcS9xaWZvd1diTW9p?=
 =?utf-8?B?VGJXR2hUbm5pcE5SYUJ0dzJ0UHZnSzRBenBzZUNNdU5zeGhwYllmRm0wekVu?=
 =?utf-8?B?dit6UFNMcTlPZEhuN2J2Qkg4VVlnQ3g4bkZTUzkyZmVaM05HbXp2TmJSVXN1?=
 =?utf-8?B?MTEraGlKcy9ybnhhbWlnNnBhWlovb1NuMVFGbVFSR0diaFZoOGRyaGJFeXBU?=
 =?utf-8?B?Z2ZxWi90N1JjZlg3c0tHcEVqcithbnZ6VTc0M21mMU5VQlhlUlJKN25aeWtM?=
 =?utf-8?B?K1Flc3EwakI5MFJtRml5cjd0amx0YzNaSmZON0VwQkJuNHpKSDNIMjYwR3JZ?=
 =?utf-8?B?QXJnWFl6SlpZUno1LzJTMUROL0ZiOCtFczJYZUdoYWtscFB6OVkrODRtNmE2?=
 =?utf-8?Q?JuyTCmjDHbRdsZLyD/9ImQcYQG/aUAKZXYZH0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qy9mTXpMN0VxcGlhYVpDTzN6dERKSXNxMUxaOWFtd3FHYmFGdTg3REZtejRE?=
 =?utf-8?B?YzJJVU9JNXhYRzlHZHNBODFNazFkY3R4SGZwNVV6dEJXeEhHSVFrekR1YjFk?=
 =?utf-8?B?c2ZERWlZckNVb1hxRzJ0bnVSR0RPRGpST2ZQbXh2cktTVnZRb1ZjVURPYVo0?=
 =?utf-8?B?RWZHM0tLWHVzTWVZeENCZUtIODFZVUVKaVBnWnhIR2NqUC9GaW1Jc3E2eXNn?=
 =?utf-8?B?MFZsUXFXUTdieWhVZnZWV2ZwZjlXajNLb01VdUwxaW9OR1VsV0JCNlZPM0Ex?=
 =?utf-8?B?N1dpeG5IZFlTb1gyMFVkSFBiYkUreWE4Qnk0S0tqcSs1dnBJVDJsbXovazdE?=
 =?utf-8?B?cGZEbmxPemNuNUY1S2I1ZXVldHA2Z2ppZFErRTVwYld1UjNJSTltcUgzYytk?=
 =?utf-8?B?NUtoZkYvQmRBNm1hMVloZGgyRFA2RERsZmZpOWRCd1V6ZDhGS1JFdkRrU1pR?=
 =?utf-8?B?WUZSclA3djA0eVcyNCtwYTlVaVVEclg3dFlpb3NzUnBFd3JZRktTSnNCdHhZ?=
 =?utf-8?B?dEVwbXFJS3VKdU1tYm1Sanhkc2taMzNUbnBUSE9xeHBISVRPZ2l2MzVRbjV1?=
 =?utf-8?B?YWFzSFNrQkZPMkZBN091Vm5tL3J1Q0l4a2g0VnZiSTFzZitlUVkxcVQ0Z25H?=
 =?utf-8?B?M3VTY0xkNkM3Mzc0R0xUUmQvdkdFZUkwd0YzSjBPMnZvUW9VMDcyb1ZqNExr?=
 =?utf-8?B?TDBlNW14QXlTUEV0ZlBiNm05TVo4aGVSV2J2bkpJMnp5OGtGMVVubGorQkho?=
 =?utf-8?B?ZUgvOGZzWkFWRUJZQy9FS0tKbyt5WS9QTWJmOUdtUUxMdFJ1dGg3QUdDK0Nk?=
 =?utf-8?B?eE1jTWpjb0tEMUVXQXlvY0hzVGtnYTFzbWxRSnhXRkVQWVJwN0Z5UHRoVzl4?=
 =?utf-8?B?M3lReTNCL2dPa3BGWnQ3blhQazBmcm45d1A1N0xnenJEUElNNkFWWCtpYkpy?=
 =?utf-8?B?MDdNa0V1RFZIbWQrTjVEUzVoR3ZOVklTU28vc0dXUFRKaUYvRHFlbWZDTlFP?=
 =?utf-8?B?Q012eXpodWRpazJpVFhRNnZ5RTBsd3grVllEbW5hTnVlZmIvZ2JBVXNPWHc2?=
 =?utf-8?B?c1Q3Y0dPSkJmY1N1a092YXA2eVZoYjBlOUp3VmZpaDMvKzBRcUNVN2NCRUI3?=
 =?utf-8?B?OFF5b1EybXlPTnE3MDRRemlkNWxHSEhWcEdpeXdXcUY3MjZFWG9sRjh6RUpU?=
 =?utf-8?B?aXRFTXVRR3pnMkNSS2tQbExsMHR0cG9JWUVtdnRuODlXQlRzU2tXbmE5SjZm?=
 =?utf-8?B?VDJkNGh4dDlBRFlVTDY5MzFEdlB1MzhaMnM2L2pjWVRMbzZWb3JSaXI3c1JJ?=
 =?utf-8?B?TlkrNS94YXA5by9ZSzQ1VkswQXNveWpDMGNNVmNjL09jTis0UE5YbjFQZ2d3?=
 =?utf-8?B?MVZXVmVlRG9BVldobXhsTk5iUGQvMGRkRURoVnVYSmlvZzFsMDFwZk43Sy92?=
 =?utf-8?B?dnRwQnc4ZkJwRW1TM2daS1dybnNxVTJIVTR3VWNyNFdpTXp1bVRqSlRXMVRK?=
 =?utf-8?B?bHhwZWpZakFvTjBTaUVnZzJHUGJNWHptaGhmRld6RFdzTFZXbDBtbDFSVmov?=
 =?utf-8?B?cmtXVEUwUGVUMjY2SmtRRXN0dFFlWnE2VUt2NitZNlNsUERZTVRZTW5VNGpk?=
 =?utf-8?B?Q1l2YjJOTXo1bUl5TVFMcVRnT2xDaGlhU3dMdjZlUktLU0h0QTUzSTJ2c0Zn?=
 =?utf-8?B?aW5aQ3l2TUVVTnFEbGZnUzBXSTYyNjc5UFVFTWFycHp1VldrTnJjRWlaenRD?=
 =?utf-8?B?S1dMNFVBb2h3S2hKbzNKWUQzSzRUeU85SmhvY1RtRDFFelZia0NSb0UzOXlx?=
 =?utf-8?B?d2FPSXFUWEhydjdMTGozMHhCWThPVnVkeTlKWURXL1JYOVdxR0lBVkpMbTBr?=
 =?utf-8?B?RlJSMkpKcWZGRUM2QXBJYXlxbEVPTWU2MVNkQkpyK1Q2QW9iTDBnWHQ3TGQz?=
 =?utf-8?B?Q0c5SElvaU4rVFRLZWpiaHBSNk9TeXA2bkd2M1JuemtMdXgvVjZjQVJnRmF3?=
 =?utf-8?B?Y1k5ZkU5ZEJTMlNYWkRTSUZnL1A3QzNKL1Z6eW1PNVIzUGRwWFpqeWpCc2wy?=
 =?utf-8?B?NmhpY2IvMzZTRDZmakw4Vm96ZTFNOWJ6TUlnUmlrY2xUaFA1ZUpNMUQ4SWxL?=
 =?utf-8?B?OThTa2ptejRicS9ibkJxOWtyWGMwYWFHaGdveUQwSm9hR2x5cmtQU0VzYWMy?=
 =?utf-8?B?VHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72668437-7349-471a-2f6c-08dd08f66a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 00:00:59.7231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EvoBTJLiNDGah3sZin5TdrPNwgSPSTyJozR5nwMJM27r8I1eNpaRYLrvC4EZ2NrgMvzj0W1+nHVqu2A3ogH4XcgwkCo1lf/qZoYPn32lKtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8172
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE5LCAyMDI0IDM6
NDUgUE0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRl
bC5jb20+DQo+IENjOiBDaGVuZ21pbmcgWmhvdSA8Y2hlbmdtaW5nLnpob3VAbGludXguZGV2Pjsg
Sm9oYW5uZXMgV2VpbmVyDQo+IDxoYW5uZXNAY21weGNoZy5vcmc+OyBOaGF0IFBoYW0gPG5waGFt
Y3NAZ21haWwuY29tPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1t
QGt2YWNrLm9yZzsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsNCj4gcnlhbi5yb2JlcnRzQGFybS5j
b207IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBGZWdo
YWxpLCBXYWpkaSBLIDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaA0K
PiA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gbW06
IHpzd2FwOiBGaXggYSBwb3RlbnRpYWwgbWVtb3J5IGxlYWsgaW4NCj4genN3YXBfZGVjb21wcmVz
cygpLg0KPiANCj4gT24gVHVlLCBOb3YgMTksIDIwMjQgYXQgMjozNeKAr1BNIFNyaWRoYXIsIEth
bmNoYW5hIFANCj4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+
ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBZb3NyeSBB
aG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPg0KPiA+ID4gU2VudDogVHVlc2RheSwgTm92ZW1i
ZXIgMTksIDIwMjQgMTE6NTEgQU0NCj4gPiA+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5j
aGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IENoZW5nbWluZyBaaG91IDxjaGVu
Z21pbmcuemhvdUBsaW51eC5kZXY+OyBKb2hhbm5lcyBXZWluZXINCj4gPiA+IDxoYW5uZXNAY21w
eGNoZy5vcmc+OyBOaGF0IFBoYW0gPG5waGFtY3NAZ21haWwuY29tPjsgbGludXgtDQo+ID4gPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IHVzYW1hYXJpZjY0MkBn
bWFpbC5jb207DQo+ID4gPiByeWFuLnJvYmVydHNAYXJtLmNvbTsgMjFjbmJhb0BnbWFpbC5jb207
IGFrcG1AbGludXgtDQo+IGZvdW5kYXRpb24ub3JnOw0KPiA+ID4gRmVnaGFsaSwgV2FqZGkgSyA8
d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGgNCj4gPiA+IDx2aW5vZGgu
Z29wYWxAaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gbW06IHpzd2Fw
OiBGaXggYSBwb3RlbnRpYWwgbWVtb3J5IGxlYWsgaW4NCj4gPiA+IHpzd2FwX2RlY29tcHJlc3Mo
KS4NCj4gPiA+DQo+ID4gPiBPbiBUdWUsIE5vdiAxOSwgMjAyNCBhdCAxMTo0MuKAr0FNIFNyaWRo
YXIsIEthbmNoYW5hIFANCj4gPiA+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90
ZToNCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gPiA+IEZyb206IFlvc3J5IEFobWVkIDx5b3NyeWFobWVkQGdvb2dsZS5jb20+DQo+
ID4gPiA+ID4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTksIDIwMjQgMTE6MjcgQU0NCj4gPiA+
ID4gPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNv
bT4NCj4gPiA+ID4gPiBDYzogQ2hlbmdtaW5nIFpob3UgPGNoZW5nbWluZy56aG91QGxpbnV4LmRl
dj47IEpvaGFubmVzIFdlaW5lcg0KPiA+ID4gPiA+IDxoYW5uZXNAY21weGNoZy5vcmc+OyBOaGF0
IFBoYW0gPG5waGFtY3NAZ21haWwuY29tPjsgbGludXgtDQo+ID4gPiA+ID4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiB1c2FtYWFyaWY2NDJAZ21haWwuY29t
Ow0KPiA+ID4gPiA+IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyBIdWFuZywgWWluZyA8eWluZy5odWFu
Z0BpbnRlbC5jb20+Ow0KPiA+ID4gPiA+IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZv
dW5kYXRpb24ub3JnOyBGZWdoYWxpLCBXYWpkaSBLDQo+ID4gPiA+ID4gPHdhamRpLmsuZmVnaGFs
aUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoDQo+IDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0K
PiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIG1tOiB6c3dhcDogRml4IGEgcG90ZW50
aWFsIG1lbW9yeSBsZWFrIGluDQo+ID4gPiA+ID4genN3YXBfZGVjb21wcmVzcygpLg0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gT24gVHVlLCBOb3YgMTksIDIwMjQgYXQgMTE6MjLigK9BTSBTcmlkaGFy
LCBLYW5jaGFuYSBQDQo+ID4gPiA+ID4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdy
b3RlOg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gPiA+IEZyb206IFlvc3J5IEFobWVkIDx5b3NyeWFo
bWVkQGdvb2dsZS5jb20+DQo+ID4gPiA+ID4gPiA+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTUs
IDIwMjQgMTo0OSBQTQ0KPiA+ID4gPiA+ID4gPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2Fu
Y2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4NCj4gPiA+ID4gPiA+ID4gQ2M6IENoZW5nbWluZyBa
aG91IDxjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY+OyBKb2hhbm5lcw0KPiBXZWluZXINCj4gPiA+
ID4gPiA+ID4gPGhhbm5lc0BjbXB4Y2hnLm9yZz47IE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFpbC5j
b20+Ow0KPiBsaW51eC0NCj4gPiA+ID4gPiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtbW1Aa3ZhY2sub3JnOw0KPiA+ID4gdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsNCj4gPiA+ID4g
PiA+ID4gcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVs
LmNvbT47DQo+ID4gPiA+ID4gPiA+IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5k
YXRpb24ub3JnOyBGZWdoYWxpLCBXYWpkaQ0KPiBLDQo+ID4gPiA+ID4gPiA+IDx3YWpkaS5rLmZl
Z2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaA0KPiA+ID4gPHZpbm9kaC5nb3BhbEBpbnRl
bC5jb20+DQo+ID4gPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIG1tOiB6c3dhcDog
Rml4IGEgcG90ZW50aWFsIG1lbW9yeSBsZWFrIGluDQo+ID4gPiA+ID4gPiA+IHpzd2FwX2RlY29t
cHJlc3MoKS4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gT24gRnJpLCBOb3YgMTUsIDIw
MjQgYXQgMToxNOKAr1BNIFNyaWRoYXIsIEthbmNoYW5hIFANCj4gPiA+ID4gPiA+ID4gPGthbmNo
YW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+ID4gSGkgQ2hlbmdtaW5nLA0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+ID4gPiA+ID4gRnJvbTogQ2hl
bmdtaW5nIFpob3UgPGNoZW5nbWluZy56aG91QGxpbnV4LmRldj4NCj4gPiA+ID4gPiA+ID4gPiA+
IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTMsIDIwMjQgMTE6MjQgUE0NCj4gPiA+ID4gPiA+
ID4gPiA+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwu
Y29tPjsNCj4gPiA+IEpvaGFubmVzDQo+ID4gPiA+ID4gPiA+IFdlaW5lcg0KPiA+ID4gPiA+ID4g
PiA+ID4gPGhhbm5lc0BjbXB4Y2hnLm9yZz4NCj4gPiA+ID4gPiA+ID4gPiA+IENjOiBOaGF0IFBo
YW0gPG5waGFtY3NAZ21haWwuY29tPjsgWW9zcnkgQWhtZWQNCj4gPiA+ID4gPiA+ID4gPiA+IDx5
b3NyeWFobWVkQGdvb2dsZS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBs
aW51eC0NCj4gPiA+ID4gPiA+ID4gPiA+IG1tQGt2YWNrLm9yZzsgdXNhbWFhcmlmNjQyQGdtYWls
LmNvbTsNCj4gPiA+IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOw0KPiA+ID4gPiA+ID4gPiBIdWFuZywN
Cj4gPiA+ID4gPiA+ID4gPiA+IFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJhb0Bn
bWFpbC5jb207DQo+IGFrcG1AbGludXgtDQo+ID4gPiA+ID4gPiA+ID4gPiBmb3VuZGF0aW9uLm9y
ZzsgRmVnaGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47DQo+ID4gPiBH
b3BhbCwNCj4gPiA+ID4gPiA+ID4gVmlub2RoDQo+ID4gPiA+ID4gPiA+ID4gPiA8dmlub2RoLmdv
cGFsQGludGVsLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFd
IG1tOiB6c3dhcDogRml4IGEgcG90ZW50aWFsIG1lbW9yeQ0KPiBsZWFrIGluDQo+ID4gPiA+ID4g
PiA+ID4gPiB6c3dhcF9kZWNvbXByZXNzKCkuDQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiA+ID4gSGVsbG8sDQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gT24g
MjAyNC8xMS8xNCAxNDozNywgU3JpZGhhciwgS2FuY2hhbmEgUCB3cm90ZToNCj4gPiA+ID4gPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gPiA+ID4gPiA+ID4gPiA+PiBGcm9tOiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4
Y2hnLm9yZz4NCj4gPiA+ID4gPiA+ID4gPiA+ID4+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIg
MTMsIDIwMjQgOToxMiBQTQ0KPiA+ID4gPiA+ID4gPiA+ID4gPj4gVG86IFNyaWRoYXIsIEthbmNo
YW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gPiA+ID4gPiA+ID4gPiA+
PiBDYzogTmhhdCBQaGFtIDxucGhhbWNzQGdtYWlsLmNvbT47IFlvc3J5IEFobWVkDQo+ID4gPiA+
ID4gPiA+ID4gPiA+PiA8eW9zcnlhaG1lZEBnb29nbGUuY29tPjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LQ0KPiA+ID4gPiA+ID4gPiA+ID4gPj4gbW1Aa3ZhY2su
b3JnOyBjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY7DQo+ID4gPiA+ID4gPiA+IHVzYW1hYXJpZjY0
MkBnbWFpbC5jb207DQo+ID4gPiA+ID4gPiA+ID4gPiA+PiByeWFuLnJvYmVydHNAYXJtLmNvbTsg
SHVhbmcsIFlpbmcNCj4gPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsNCj4gPiA+ID4gPiA+ID4gPiA+
ID4+IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBGZWdoYWxp
LA0KPiA+ID4gV2FqZGkgSw0KPiA+ID4gPiA+ID4gPiA+ID4gPj4gPHdhamRpLmsuZmVnaGFsaUBp
bnRlbC5jb20+OyBHb3BhbCwgVmlub2RoDQo+ID4gPiA+ID4gPHZpbm9kaC5nb3BhbEBpbnRlbC5j
b20+DQo+ID4gPiA+ID4gPiA+ID4gPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBtbTogenN3
YXA6IEZpeCBhIHBvdGVudGlhbCBtZW1vcnkNCj4gPiA+IGxlYWsgaW4NCj4gPiA+ID4gPiA+ID4g
PiA+ID4+IHpzd2FwX2RlY29tcHJlc3MoKS4NCj4gPiA+ID4gPiA+ID4gPiA+ID4+DQo+ID4gPiA+
ID4gPiA+ID4gPiA+PiBPbiBUaHUsIE5vdiAxNCwgMjAyNCBhdCAwMTo1NjoxNkFNICswMDAwLCBT
cmlkaGFyLA0KPiBLYW5jaGFuYQ0KPiA+ID4gUA0KPiA+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+
ID4gPiA+ID4gPiA+ID4+PiBTbyBteSBxdWVzdGlvbiB3YXMsIGNhbiB3ZSBwcmV2ZW50IHRoZSBt
aWdyYXRpb24gdG8gYQ0KPiA+ID4gZGlmZmVyZW50DQo+ID4gPiA+ID4gY3B1DQo+ID4gPiA+ID4g
PiA+ID4gPiA+Pj4gYnkgcmVsaW5xdWlzaGluZyB0aGUgbXV0ZXggbG9jayBhZnRlciB0aGlzIGNv
bmRpdGlvbmFsDQo+ID4gPiA+ID4gPiA+ID4gPiA+Pg0KPiA+ID4gPiA+ID4gPiA+ID4gPj4gSG9s
ZGluZyB0aGUgbXV0ZXggZG9lc24ndCBwcmV2ZW50IHByZWVtcHRpb24vbWlncmF0aW9uLg0KPiA+
ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBTdXJlLCBob3dldmVyLCBpcyB0
aGlzIGFsc28gYXBwbGljYWJsZSB0byBob2xkaW5nIHRoZSBtdXRleCBvZg0KPiBhDQo+ID4gPiBw
ZXItDQo+ID4gPiA+ID4gY3B1DQo+ID4gPiA+ID4gPiA+ID4gPiA+IHN0cnVjdHVyZSBvYnRhaW5l
ZCB2aWEgcmF3X2NwdV9wdHIoKT8NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4g
PiBZZXMsIHVubGVzcyB5b3UgdXNlIG1pZ3JhdGlvbl9kaXNhYmxlKCkgb3IgY3B1c19yZWFkX2xv
Y2soKSB0bw0KPiA+ID4gcHJvdGVjdA0KPiA+ID4gPiA+ID4gPiA+ID4gdGhpcyBzZWN0aW9uLg0K
PiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gT2suDQo+ID4gPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+
IFdvdWxkIGhvbGRpbmcgdGhlIG11dGV4IHByZXZlbnQgdGhlIGFjb21wX2N0eCBvZiB0aGUgY3B1
DQo+IHByaW9yDQo+ID4gPiB0bw0KPiA+ID4gPiA+ID4gPiA+ID4gPiB0aGUgbWlncmF0aW9uIChp
biB0aGUgVUFGIHNjZW5hcmlvIHlvdSBkZXNjcmliZWQpIGZyb20gYmVpbmcNCj4gPiA+ID4gPiBk
ZWxldGVkPw0KPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IE5vLCBjcHUgb2Zm
bGluZSBjYW4ga2ljayBpbiBhbnl0aW1lIHRvIGZyZWUgdGhlIGFjb21wX2N0eC0NCj4gPmJ1ZmZl
ci4NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
ID4gPiA+IElmIGhvbGRpbmcgdGhlIHBlci1jcHUgYWNvbXBfY3R4J3MgbXV0ZXggaXNuJ3Qgc3Vm
ZmljaWVudCB0bw0KPiA+ID4gcHJldmVudA0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiA+
ID4gPiBVQUYsIEkgYWdyZWUsIHdlIG1pZ2h0IG5lZWQgYSB3YXkgdG8gcHJldmVudCB0aGUgYWNv
bXBfY3R4DQo+ID4gPiBmcm9tDQo+ID4gPiA+ID4gYmVpbmcNCj4gPiA+ID4gPiA+ID4gPiA+ID4g
ZGVsZXRlZCwgZS5nLiB3aXRoIHJlZmNvdW50cyBhcyB5b3UndmUgc3VnZ2VzdGVkLCBvciB0byBu
b3QNCj4gdXNlDQo+ID4gPiB0aGUNCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4g
PiBSaWdodCwgcmVmY291bnQgc29sdXRpb24gZnJvbSBKb2hhbm5lcyBpcyB2ZXJ5IGdvb2QgSU1I
Ty4NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+IGFjb21wX2N0eCBhdCBh
bGwgZm9yIHRoZSBjaGVjaywgaW5zdGVhZCB1c2UgYSBib29sZWFuLg0KPiA+ID4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gPiA+IEJ1dCB0aGlzIGlzIG5vdCBlbm91Z2ggdG8ganVzdCBhdm9p
ZCB1c2luZyBhY29tcF9jdHggZm9yIHRoZQ0KPiBjaGVjaywNCj4gPiA+ID4gPiA+ID4gPiA+IHRo
ZSB1c2FnZSBvZiBhY29tcF9jdHggaW5zaWRlIHRoZSBtdXRleCBpcyBhbHNvIFVBRiwgc2luY2Ug
Y3B1DQo+ID4gPiBvZmZsaW5lDQo+ID4gPiA+ID4gPiA+ID4gPiBjYW4ga2ljayBpbiBhbnl0aW1l
IHRvIGZyZWUgdGhlIGFjb21wX2N0eC0+YnVmZmVyLg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+ID4gSSBzZWUuIEhvdyB3b3VsZCB0aGUgcmVmY291bnRzIHdvcms/IFdvdWxkIHRoaXMg
YWRkIGxhdGVuY3kgdG8NCj4gPiA+IHpzd2FwDQo+ID4gPiA+ID4gPiA+ID4gb3BzPyBJbiBsb3cg
bWVtb3J5IHNpdHVhdGlvbnMsIGNvdWxkIHRoZSBjcHUgb2ZmbGluaW5nIGNvZGUgb3Zlci0NCj4g
cmlkZQ0KPiA+ID4gPiA+ID4gPiA+IHRoZSByZWZjb3VudHM/DQo+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+IEkgdGhpbmsgd2hhdCBKb2hhbm5lcyBtZWFudCBpcyB0aGF0IHRoZSB6c3dhcA0K
PiBjb21wcmVzcy9kZWNvbXByZXNzDQo+ID4gPiA+ID4gPiA+IHBhdGhzIGdyYWIgYSByZWYgb24g
dGhlIGFjb21wX2N0eCBiZWZvcmUgdXNpbmcgaXQsIGFuZCB0aGUgQ1BVDQo+ID4gPiA+ID4gPiA+
IG9mZmxpbmluZyBjb2RlIG9ubHkgZHJvcHMgdGhlIGluaXRpYWwgcmVmLCBhbmQgZG9lcyBub3Qg
ZnJlZSB0aGUNCj4gPiA+ID4gPiA+ID4gYnVmZmVyIGRpcmVjdGx5LiBUaGUgYnVmZmVyIGlzIG9u
bHkgZnJlZWQgd2hlbiB0aGUgcmVmIGRyb3BzIHRvIHplcm8uDQo+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+IEkgYW0gbm90IGZhbWlsaWFyIHdpdGggQ1BVIGhvdHBsdWcsIHdvdWxkIGl0IGJl
IHNpbXBsZXIgaWYgd2UgaGF2ZQ0KPiBhDQo+ID4gPiA+ID4gPiA+IHdyYXBwZXIgbGlrZSBnZXRf
YWNvbXBfY3R4KCkgdGhhdCBkaXNhYmxlcyBtaWdyYXRpb24gb3IgY2FsbHMNCj4gPiA+ID4gPiA+
ID4gY3B1c19yZWFkX2xvY2soKSBiZWZvcmUgZ3JhYmJpbmcgdGhlIHBlci1DUFUgYWNvbXBfY3R4
PyBBDQo+IHNpbWlsYXINCj4gPiA+ID4gPiA+ID4gd3JhcHBlciwgcHV0X2Fjb21wdF9jdHgoKSB3
aWxsIGJlIHVzZWQgYWZ0ZXIgd2UgYXJlIGRvbmUgdXNpbmcNCj4gdGhlDQo+ID4gPiA+ID4gPiA+
IGFjb21wX2N0eC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBXb3VsZCBpdCBiZSBzdWZmaWNp
ZW50IHRvIGFkZCBhIGNoZWNrIGZvciBtdXRleF9pc19sb2NrZWQoKSBpbg0KPiA+ID4gPiA+ID4g
enN3YXBfY3B1X2NvbXBfZGVhZCgpIGFuZCBpZiB0aGlzIHJldHVybnMgdHJ1ZSwgdG8gZXhpdCB3
aXRob3V0DQo+ID4gPiBkZWxldGluZw0KPiA+ID4gPiA+ID4gdGhlIGFjb21wPw0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gSSBkb24ndCB0aGluayB0aGlzIHdvcmtzLiBGaXJzdCBvZiBhbGwsIGl0J3Mg
cmFjeS4gSXQncyBwb3NzaWJsZSB0aGUNCj4gPiA+ID4gPiBtdXRleCBnZXRzIGxvY2tlZCBhZnRl
ciB3ZSBjaGVjayBtdXRleF9pc19sb2NrZWQoKSBidXQgYmVmb3JlIHdlDQo+ID4gPiA+ID4gZGVs
ZXRlIHRoZSBhY29tcF9jdHguIEFsc28sIGlmIHdlIGZpbmQgdGhhdCB0aGUgbXV0ZXggaXMgbG9j
a2VkLCB0aGVuDQo+ID4gPiA+ID4gd2UgZG8gbm90aGluZyBhbmQgZXNzZW50aWFsbHkgbGVhayB0
aGUgbWVtb3J5Lg0KPiA+ID4gPg0KPiA+ID4gPiBZZXMsIHRoaXMgd291bGQgYXNzdW1lIHRoZSBj
cHUgb2ZmbGluaW5nIGNvZGUgcmV0cmllcyBhdCBzb21lIGludGVydmFsLA0KPiA+ID4gPiB3aGlj
aCBjb3VsZCBwcmV2ZW50IHRoZSBtZW1vcnkgbGVhay4NCj4gPiA+DQo+ID4gPiBJIGFtIG5vdCBz
dXJlIGFib3V0IHRoYXQsIGJ1dCBldmVuIHNvLCBpdCB3b3VsZG4ndCBoYW5kbGUgdGhlIGZpcnN0
DQo+ID4gPiBzY2VuYXJpbyB3aGVyZSB0aGUgbXV0ZXggZ2V0cyBsb2NrZWQgYWZ0ZXIgd2UgY2hl
Y2sgbXV0ZXhfaXNfbG9ja2VkKCkuDQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gU2Vjb25kLCBhbmQgcHJvYmFibHkgbW9yZSBpbXBvcnRhbnQsIHRoaXMgb25seSBjaGVja3Mg
aWYgYW55b25lIGlzDQo+ID4gPiA+ID4gY3VycmVudGx5IGhvbGRpbmcgdGhlIG11dGV4LiBXaGF0
IGFib3V0IHRhc2tzIHRoYXQgbWF5IGJlIHNsZWVwaW5nDQo+ID4gPiA+ID4gd2FpdGluZyBmb3Ig
dGhlIG11dGV4IHRvIGJlIHVubG9ja2VkPyBUaGUgbXV0ZXggd2lsbCBiZSBkZWxldGVkIGZyb20N
Cj4gPiA+ID4gPiB1bmRlciB0aGVtIGFzIHdlbGwuDQo+ID4gPiA+DQo+ID4gPiA+IFdvdWxkbid0
IHRoaXMgYW5kIHRoZSByYWNlIGRlc2NyaWJlZCBhYm92ZSwgYWxzbyBiZSBpc3N1ZXMgZm9yIHRo
ZQ0KPiA+ID4gPiByZWZjb3VudCBiYXNlZCBhcHByb2FjaD8NCj4gPiA+DQo+ID4gPiBJIGRvbid0
IHRoaW5rIHNvLCBhdCBsZWFzdCBpZiBpbXBsZW1lbnRlZCBjb3JyZWN0bHkuIFRoZXJlIGFyZSBh
IGxvdA0KPiA+ID4gb2YgZXhhbXBsZXMgYXJvdW5kIHRoZSBrZXJuZWwgdGhhdCB1c2UgUkNVICsg
cmVmY291bnRzIGZvciBzdWNoIHVzZQ0KPiA+ID4gY2FzZXMuIEkgdGhpbmsgdGhlcmUgYXJlIGFs
c28gc29tZSBleGFtcGxlcyBpbiBrZXJuZWwgZG9jcy4NCj4gPiA+DQo+ID4gPiBUaGF0IGJlaW5n
IHNhaWQsIEkgYW0gd29uZGVyaW5nIGlmIHdlIGNhbiBnZXQgYXdheSB3aXRoIHNvbWV0aGluZw0K
PiA+ID4gc2ltcGxlciBsaWtlIGhvbGRpbmcgdGhlIGNwdXMgcmVhZCBsb2NrIG9yIGRpc2FibGlu
ZyBtaWdyYXRpb24gYXMgSQ0KPiA+ID4gc3VnZ2VzdGVkIGVhcmxpZXIsIGJ1dCBJIGFtIG5vdCBx
dWl0ZSBzdXJlLg0KPiA+DQo+ID4gQW5vdGhlciBpZGVhIHRvIGNvbnNpZGVyIGlzIGhvdyB6c21h
bGxvYyBhdm9pZHMgdGhpcyBpc3N1ZSB0aHJvdWdoDQo+ID4gaXRzIHVzZSBvZiB0aGUgbG9jYWxf
bG9jaygpIG9uIHRoZSBwZXItY3B1IG1hcHBpbmcgYXJlYS4gVGhpcyBkaXNhYmxlcw0KPiA+IHBy
ZWVtcHRpb24gZnJvbSB6c19tYXBfb2JqZWN0KCkgdGhyb3VnaCB6c191bm1hcF9vYmplY3QoKS4N
Cj4gPiBXb3VsZCBjaGFuZ2luZyB0aGUgYWNvbXBfY3R4J3MgbXV0ZXggdG8gYSBsb2NhbF9sb2Nr
IHNvbHZlIHRoZQ0KPiA+IHByb2JsZW0/DQo+IA0KPiBUaGlzIGlzIHNpbWlsYXIgdG8gZGlzYWJs
aW5nIG1pZ3JhdGlvbiBhcyBJIHN1Z2dlc3RlZCwgYnV0IGRpc2FibGluZw0KPiBwcmVlbXB0aW9u
IG1lYW5zIHRoYXQgd2UgY2Fubm90IHNsZWVwLCB3ZSBzcGluIG9uIGEgbG9jayBpbnN0ZWFkLg0K
PiANCj4gSW4genN3YXBfY29tcHJlc3MoKSwgd2Ugc2VuZCB0aGUgY29tcHJlc3Npb24gcmVxdWVz
dCBhbmQgbWF5IHNsZWVwDQo+IHdhaXRpbmcgZm9yIGl0LiBXZSBhbHNvIG1ha2UgYSBub24tYXRv
bWljIGFsbG9jYXRpb24gbGF0ZXIgdGhhdCBtYXkNCj4gYWxzbyBzbGVlcCBidXQgdGhhdCdzIGxl
c3Mgb2YgYSBwcm9ibGVtLg0KPiANCj4gSW4genN3YXBfZGVjb21wcmVzcygpIHdlIG1heSBhbHNv
IHNsZWVwLCB3aGljaCBpcyB3aHkgd2Ugc29tZXRpbWVzDQo+IGNvcHkgdGhlIGRhdGEgaW50byBh
Y29tcF9jdHgtPmJ1ZmZlciBhbmQgdW5tYXAgdGhlIGhhbmRsZSB0byBiZWdpbg0KPiB3aXRoLg0K
PiANCj4gU28gSSBkb24ndCB0aGluayB3ZSBjYW4ganVzdCByZXBsYWNlIHRoZSBtdXRleCB3aXRo
IGEgbG9jay4NCg0KVGhhbmtzIFlvc3J5LCBmb3IgdGhlIGV4cGxhbmF0aW9ucy4gWWVzLCBJIHVu
ZGVyc3RhbmQgYW5kIGFncmVlLg0KDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBB
bHNvLCBJIGFtIHdvbmRlcmluZyBpZiB0aGUgbXV0ZXggZGVzaWduIGFscmVhZHkgaGFuZGxlcyBj
YXNlcyB3aGVyZQ0KPiA+ID4gPiB0YXNrcyBhcmUgc2xlZXBpbmcsIHdhaXRpbmcgZm9yIGEgbXV0
ZXggdGhhdCBkaXNhcHBlYXJzPw0KPiA+ID4NCj4gPiA+IEkgZG9uJ3QgYmVsaWV2ZSBzby4gSXQg
ZG9lc24ndCBtYWtlIHNlbnNlIGZvciBzb21lb25lIHRvIGZyZWUgYSBtdXRleA0KPiA+ID4gd2hp
bGUgc29tZW9uZSBpcyB3YWl0aW5nIGZvciBpdC4gSG93IHdvdWxkIHRoZSB3YWl0ZXIga25vdyBp
ZiB0aGUNCj4gPiA+IG1lbW9yeSBiYWNraW5nIHRoZSBtdXRleCB3YXMgZnJlZWQ/DQo+ID4NCj4g
PiBUaGFua3MgWW9zcnksIGFsbCBnb29kIHBvaW50cy4gVGhlcmUgd291bGQgbmVlZCB0byBiZSBz
b21lIHNvcnQgb2YNCj4gPiBhcmJpdGVyIChmb3IgZS5nLiwgdGhlIGNwdSBvZmZsaW5pbmcgY29k
ZSkgdGhhdCB3b3VsZCByZXNjaGVkdWxlIHRhc2tzDQo+ID4gcnVubmluZyBvbiBhIGNwdSBiZWZv
cmUgc2h1dHRpbmcgaXQgZG93biwgd2hpY2ggY291bGQgYWRkcmVzcw0KPiA+IHRoaXMgc3BlY2lm
aWMgaXNzdWUuIEkgd2FzIHRoaW5raW5nIHRoZXNlIGFyZSBub3QgcHJvYmxlbXMgdW5pcXVlIHRv
DQo+ID4genN3YXAncyBwZXItY3B1IGFjb21wX2N0eC0+bXV0ZXggd3J0IHRoZSBvZmZsaW5pbmc/
DQo+IA0KPiBUaGVyZSBhcmUgYSBmZXcgcmVhc29ucyB3aHkgenN3YXAgaGFzIHRoaXMgcHJvYmxl
bSBhbmQgb3RoZXIgY29kZSBtYXkNCj4gbm90IGhhdmUgaXQuIEZvciBleGFtcGxlIHRoZSBkYXRh
IHN0cnVjdHVyZSBpcyBkeW5hbWljYWxseSBhbGxvY2F0ZWQNCj4gYW5kIGlzIGZyZWVkIGR1cmlu
ZyBvZmZsaW5pbmcsIGl0IHdvdWxkbid0IGJlIGEgcHJvYmxlbSBpZiBpdCB3YXMNCj4gc3RhdGlj
LiBBbHNvIHRoZSBmYWN0IHRoYXQgd2UgZG9uJ3QgZGlzYWJsZSBwcmVlbXB0aW9uIHdoZW4gYWNj
ZXNzaW5nDQo+IHRoZSBwZXItQ1BVIGRhdGEsIGFzIEkgbWVudGlvbmVkIGVhcmxpZXIsIHdoaWNo
IHdvdWxkIHByZXZlbnQgdGhlIENQVQ0KPiB3ZSBhcmUgcnVubmluZyBvbiBmcm9tIGdvaW5nIG9m
ZmxpbmUgd2hpbGUgd2UgYWNjZXNzIHRoZSBwZXItQ1BVIGRhdGEuDQo+IA0KPiBJIHRoaW5rIHdl
IHNob3VsZCBlaXRoZXI6DQo+IChhKSBVc2UgcmVmY291bnRzLg0KPiAoYikgRGlzYWJsZSBtaWdy
YXRpb24uDQo+IChjKSBIb2xkIHRoZSBDUFVzIHJlYWQgbG9jay4NCj4gDQo+IEkgd2FzIGhvcGlu
ZyBzb21lb25lIHdpdGggbW9yZSBrbm93bGVkZ2UgYWJvdXQgQ1BVIG9mZmxpbmluZyB3b3VsZA0K
PiBjb25maXJtIChiKSBhbmQgKGMpIHdvdWxkIHdvcmssIGJ1dCBJIGFtIHByZXR0eSBjb25maWRl
bnQgdGhleSB3b3VsZC4NCg0KT2suIFRoYW5rcyBhZ2FpbiBmb3IgdGhlIGV4cGxhbmF0aW9ucy4N
Cg0KVGhhbmtzLA0KS2FuY2hhbmENCg0K

