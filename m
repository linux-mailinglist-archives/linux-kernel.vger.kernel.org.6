Return-Path: <linux-kernel+bounces-337688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9B4984D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC1CB22C62
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B543155742;
	Tue, 24 Sep 2024 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFlQLxR0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E61482F5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216344; cv=fail; b=Uz1+LQSyp8byCHitCC5DB3Zud8RLRrva9StIynXMKxke5zHC2I+VGqIUHKaCJfRSzfgQTN++noMA1QdXZAKpwvlom360fK0mHV0f6YGiI/xwnEctjNdrABJzQrkF1dXnWgd7OkNhIPhEU34x6zkDPIX5UehrxrAlrd7wkVpNuw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216344; c=relaxed/simple;
	bh=7f0SGeHY1sLA/lNfLrcD++CWw+H2+tGCEpqo21LvVL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BNa3QWwZIk1yot1Fv42X3PVuhXOyIZ8nvaTiSFc/2crXaMps2YPHWFFH2uenQhjmvevmN8koIHyXyLGAHaMN/Dju5In5kX34JyE94OuKuLNavGv/DJRjIRNqTcKL2JC6PINjGlXDZ1YhkMXKkjTq8aT3pVKnQijuOypiNzlTN3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFlQLxR0; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727216343; x=1758752343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7f0SGeHY1sLA/lNfLrcD++CWw+H2+tGCEpqo21LvVL8=;
  b=CFlQLxR02++b9jXNDOBOoZPfv11fus9Rv7JZR92r2ZSr+LitPESniG7L
   50PMnazPEcW/tj7xGEN0TDfKNTTfTXWg6W3Fq7IosCam+O807PpJgSAyx
   2kvZ11k0V49wQfmEwm4OufvMTC+MPnBl3+9Ke5Pb7fu9cjHAISN05xkb7
   1xosSHQTY9OoH5V5uKLiKczUkAcl/wDPJzZlarzfDxorEBr4adGpKFEE2
   YlD/qop83nXKhyMukMkq/IdThxXF20ibNpkpFoOG7/o5eJxaOhi7kFRkq
   zuOpa44wA9QWAIJ4gmb7uuIaCLnbQ6a947+93Wl+7KTg10xy+WLZ+fbZu
   Q==;
X-CSE-ConnectionGUID: QlyLB/NbRSypndmkx7KDOg==
X-CSE-MsgGUID: rEvSE16VSwSLSEvkPDx4/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="37595849"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="37595849"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:19:02 -0700
X-CSE-ConnectionGUID: WEfiWtrBTOSkXQccuJjfDg==
X-CSE-MsgGUID: vlK4BQB6SF2tQO/uczqypg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="76323269"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 15:19:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 15:19:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 15:19:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 15:19:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 15:19:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 15:19:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/PquemOD4rF9/pMwoIaIbJ9/mlPXy7j34ubwtTrPGO1I3nKgXPQ9DwCHoJ5xsq2QsffSLqN8GkDmOivcDNl5uM6gxe99x1T3AwK88JfNKLLJ+opJdVVO9rHq0piAb+LYa62rNSFUi0RQ2Tdn38XWPuo0iecidTngk6rcLvtCnD8BBE9CsMe76OgRKHLOniOhQ98YZZL+NSxVrBQpgdFHCXQ1OE2ifaTXJ47OGGDuXrU1zhRpuQveVOzAQECxN7a8ZbdQ3NICYAOvTyZTy7v3/wBAD7fhGc1hTzeQ2Zdg9lDAFJXt2jS7IFhwKsex/UMQcnxmuXld/KX64oFnuV4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f0SGeHY1sLA/lNfLrcD++CWw+H2+tGCEpqo21LvVL8=;
 b=flpylqfip3/pUeXR5wAHYKjDHvNYQFX80sXzj5ycYwrXQWcEjcONsho3kNJH+nlZdYhjy65NyCxOoBijbiH6A+wlZbrtBihLCU9cemdjPsaoN0e4DW9OF+s1ZDbksAv2ItXZiIZr7/A8cELGJqEOapDyCO3Kwt6hJATXNoqlG+rAQ1sLIrxy328Bloky80hrmAnAfVrEo9fpBI+dmYNhnhdtrIbkf4qVbUb/SVVAtKj0EsgB24aL1v8OfWMUyouwQLveeZVMvtIs1QG32lgu2AuaAz9aJEwEcR2S9t6fXU5a7tAgY2E46O+BsRgKmHtz/J5AAtoXJz0MqB8iDCTu6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by MN0PR11MB6110.namprd11.prod.outlook.com (2603:10b6:208:3ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 22:18:58 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 22:18:58 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Topic: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Index: AQHbDh+C+ZYgIzdq4EuvViy0xt7aPLJnM4MAgAA0ncCAAAdQgIAAB1eAgAALpQCAAACkUA==
Date: Tue, 24 Sep 2024 22:18:57 +0000
Message-ID: <SJ0PR11MB5678B1F845444D6620491700C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <CAKEwX=Nw_ax0RRSaD9n3h1vqbu+5PEuur3RqXrMrYyvOPuzB3Q@mail.gmail.com>
 <SJ0PR11MB56785712C0EF98B7BE558720C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=MgpP_w6JFC5ahVN-erCWK2NDGSbxNdLxKg9P4yd01Unw@mail.gmail.com>
 <CAJD7tkasC4n+mE=q+L9cjf4342eSkOQPeeV1wzBKxTp39wnZJA@mail.gmail.com>
 <CAKEwX=PV4uwP7jyxYtThPGe8SFSchBXZGwxqvCr4YTWgYjtqYw@mail.gmail.com>
In-Reply-To: <CAKEwX=PV4uwP7jyxYtThPGe8SFSchBXZGwxqvCr4YTWgYjtqYw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|MN0PR11MB6110:EE_
x-ms-office365-filtering-correlation-id: 8a79c90a-42a2-4263-2c18-08dcdce6e277
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dFREaVJzRkJmV1d0ajRPSVZMR3RmeURsWUtBUEczRG5QNzh2NCtUaDRnK0J3?=
 =?utf-8?B?ak9MWHZlOHFqMFJ4WUVpdmIyeFB1dnh0SVNBZHkrN0hrQkg3dSt3d3ovMDl0?=
 =?utf-8?B?MFBjMklHc29HbW1aMzFzK2NQQzI1T3QrMHpTM2xXNm5Gb2VHWGMraGh0SUJw?=
 =?utf-8?B?amVUV0UzeGxJcVpmWXBDMU1KbU5qR1FNRnNlajVOZ1FmZWVXWklkcGxwMEtj?=
 =?utf-8?B?dkJlaDZHWTV2OGFYbDZKNDlxb1BiTHVGWEY4cFZzRmZSeWRqZHU2VWJSQk1L?=
 =?utf-8?B?dUhIUEYyZzduSTlMSSsrUktmWWdOVzFFc2xubXNNV3JKL2RrZFpKYVRTLys2?=
 =?utf-8?B?UlJQSVpuU3BXNGlDOG9GM0ZiT1RqSkdpOHZtdEF3N2ZuRmhmOE1NWHArRFNw?=
 =?utf-8?B?OU8yR2xFSzFYR3gxWGlhNnhDM1psV2VOZlBaYlYydHVwdTcrazNyK2RXSDhu?=
 =?utf-8?B?UjFmaExGTkdLNlFZeHZ0eHd5U2pVWDVkcElEd0dBZ3kxbGc2eHJ3amY5ejA0?=
 =?utf-8?B?bDdnVzFVQ2liQ0RqTVFwVHV4bFBLb2ZRMEZkWGRRc3JUZ0ordFVzcm13NTZu?=
 =?utf-8?B?NVN6REJhNWpWWjVYOWFTK0hkQW1UUXRvMEZOS2RoNTRTY1p4bDBrWDFSblpC?=
 =?utf-8?B?V3VzdGtwZ3oxZlk3YkVKYTJWMUZMNVZ3ajVYcE9ycVIvajk3TThtelNpY24x?=
 =?utf-8?B?RFRwT3Z2SDI2OVhFVWNTZTcyVDFqYTl4OUdFcUZPVG5NbERobDZXWndBTXBq?=
 =?utf-8?B?Y2ZSdWdPcWlpWjdvdEVMNWNyQWJBSjF5N2E5VzN1OStJTTVQVmttRjhaT0xy?=
 =?utf-8?B?TGtuZDJpdDQrU2RrS0JlbjBOdGl2UnBaaDF6K1B3VVR1eStLVG9NdHhxRVlp?=
 =?utf-8?B?d2FYdDhlbGNJcFhSUTJOYmNjUkEza1FWM09KOHN4dUZ5bnE0Z0NqNXdNU3Vo?=
 =?utf-8?B?WGxzTXdQUWs4RStWZnJRN0ZuOUxORUgwS0plWm14QldlU1ZZeWYwcXcvaDlQ?=
 =?utf-8?B?TVJjNllvcTRTamtObXJBZUdrTG1hdFljQkE5eDY3eTdxd2MzcTd2Wm01NVRx?=
 =?utf-8?B?b29SV0toOUx0bEZMVzF2UWxhSWI3ZUNRbW52NkMrL0dvQUhCNzV0KzhuSnZ3?=
 =?utf-8?B?M2hUdGFjT1J0QmhWaXI5RFhPVld6RTJUN2lFaUN6VlRBSUNqN2lLVHJQNFFl?=
 =?utf-8?B?RVNCaDRuSGIwelliRnAralNwaTJRVjJxdzdGTEkwMzhjb2F5UnJ3d3lydldp?=
 =?utf-8?B?cjIrMlVSZW03aXpDS3BQdkZYblZucmxRaHNiNWt1a1ZwUm50NEY3VzdQL0Nk?=
 =?utf-8?B?dmxEOVBlMU91d3RUUVo3V3V4eTFBYjlrYmJmSzJNZ3RSN0xnU1MwYVcvUHdJ?=
 =?utf-8?B?S2F1VnhTUXFIS09nTVB5UEx4OTJ2MFQzSDBVSDFnSlFoNWFZaGtMUlpXNFdv?=
 =?utf-8?B?SE9ob1VmWTJBSHhva291Tld2cVRoZ3ppNzczZjZoVHBPQTE4SkdxRXN1U1NO?=
 =?utf-8?B?MUJ0ZVR0L2RaazhEWTQvWDMzZGZxU2xZWm8ybGQyTldyRmJCdjhYNC9YdTMr?=
 =?utf-8?B?akl4cU13MUIyUWNNUm81c0Vhck42aEF1aGVXQTVZTXNJQm9LY0ZwT0dJR3Jm?=
 =?utf-8?B?b0JjaTJaK00yVzZSSXkrSklsN1o1Z0Q2bldpcFhtZ1hCcVRCVVdrSnYvWFl0?=
 =?utf-8?B?QkI5M0M1N3JaUzJ1ZEtpMVlxZ2xHbDNnNXRsTnFEVmhqdE9tWU9UYzIrWUs1?=
 =?utf-8?B?ejhpdUNkUEphWTd6NjZjcWtEc0FyemhXMDJIclRETUZGdzB0NldOOTQ2bzU1?=
 =?utf-8?B?TDBPTWpyYUJaMDYrQ2IvdGNITVpTdUhmQ24wNVdmZm0yRERxTldzRU1rQW5n?=
 =?utf-8?B?Y0xnL0ZNRkRlc2phd1ByNHArZ3lYenpibEhLVXFZazU5cEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3o5YUlmR3YyY21VOFdRRmRnRGRRT3BRd0xnVEJBVHdBWXRTektOQnpIa2Iw?=
 =?utf-8?B?RlQ1K3VtMGFGaHBEWlc2eUUwUFBTTzg0cGxUTHN5NWw3QkFWa3JTNmFyWmF2?=
 =?utf-8?B?K2lWOGtlMnFCTFE3cTBjUTZSTllPWUlHTCtJVFdxeXRvc1NxK0pyTjZMZy9q?=
 =?utf-8?B?NmRFMW4wQk4vVHc5NEduZmJidjlIaTdQN01aQ1llM05ZYjZEblhCYS9ZWTYv?=
 =?utf-8?B?alczV2U1dXc5M3RiS1FsaUFHbXY2dENFT0dTdTRUUE9sbDRndnNFTVl3bnRy?=
 =?utf-8?B?WS9HaGF3eTVadVpiYm0rcUZpMkZOc2Z1T0FQRTV2SEdFa2FlckxQcm45NEdI?=
 =?utf-8?B?djZDWDhsRXBRV0tUeU5UTklKZ3V3alRpbnJBb2JUU3V2Y0dJRXFiVGRmR29V?=
 =?utf-8?B?Y3QrZ1RrdEhUYlZidGxjMzhPbmFQWU90K1gvNmVTZmZUV0E4OXVZNnQ4MDFn?=
 =?utf-8?B?ZjhsNUN0TUo2cDZCZ2h4SmhidzF1OWFQa3FuRzZiTkFTck01Z1NxcDF5ZmlF?=
 =?utf-8?B?d3hSYTRWWHhaUVB0WHM4cHdSYlgvWnJvamNRZFA0RVJPekUrVURpT2RRSWIw?=
 =?utf-8?B?OFFIbHB3ZUVjN3d5OGtRbGx2dUtYZFUzd2szOUhhMFY5K0J6YkZGWkRLMXdm?=
 =?utf-8?B?MkNkeXVBdzdrUkhkTVQ0aFJwNEd6YTNYTzlGSkFJR0xkWUlLcmFtUWN1dnN6?=
 =?utf-8?B?aW9YVE1ZV1VIdVpWL01zLzBRbExkWXF1MDhVNFpFY1dPN2Y1K0l2RmJGTHFM?=
 =?utf-8?B?RDl4Z1g2Z2J1L1hoczYzWVZrbzJCL3JyQ3JnZ2EwT2FzLzA0cjhTYWlYQlJq?=
 =?utf-8?B?MGhqeGNMTytnR2oxcnhibVMxc1BCUnJhL3hyZ2FqRVJ5K3hqV2pBMldJNFNv?=
 =?utf-8?B?dDRwbHJNV1VxWU9tdzdYdkNiMlZUaTZuaElwRmg0dHB2OUxhc0pXc3RRWkhz?=
 =?utf-8?B?WFFuSFBGWEJJRXB4UTBrd2hkZ2xGUWNwZllWZ3NXdThWbHpOdnBUTXNRTDZq?=
 =?utf-8?B?djhQTXF2Y1hlcUJuWUY1a2xIY0k0bUhIK01YeTRMZE8xLytNa0lPV2h2MW55?=
 =?utf-8?B?NzdubkxZMXBKekV1TDlTUHFocm9Sbm1wT3Rwci9sN09oUEdpc2NUcHZ2alds?=
 =?utf-8?B?L2ZhWHNpbkxFUWFja3cwUHpVVCt0bHJqVU1ZdEV5T2tqaTg3QVlJQzZzZWZw?=
 =?utf-8?B?YWQyTDZkMm9ZNnhnREUyRi9OTDNSUEtwUFdMdEszMmxoSlFSb2wyQ3RjZVZs?=
 =?utf-8?B?eDNNNkVJSFhYMlZGdDZBTzhHeFNyNnUrMjg3V2xoZ0g1aFJTRDJITkpsOVcy?=
 =?utf-8?B?NWZNT0xMalo1NkhpWUJPdTVnNlNVWEt2RUc1ZzdtWG5vdFpxLytBMFF6T1hw?=
 =?utf-8?B?QnNsYUYvSkZ1b25BR1h4RDBnVjNjUVp4QldQSmtiWjdXNFNzb1lpaU81aklW?=
 =?utf-8?B?a05SbHd0RG5oREhmVnltekxscE1XNmJkclVrOUppODRPQVczS2taREJaOHIv?=
 =?utf-8?B?WmQrVS9Pbk9YTDQrSDhXODBRYzJXZk1qand6TEpaNGoyblluREJwN2lKV2c5?=
 =?utf-8?B?aSt0RGhVNUtueHY0MG1VL2dtdW1jaGlvdXhqTHgvbWx5YzR6TTUwK2ZibkFE?=
 =?utf-8?B?TkQraUpQY2RIa0t2QVJESzRSVFc1YUYrM1RURWdBc1VUL2c3Z0pBeExQb01P?=
 =?utf-8?B?ZjAzelQ2T1czT0xvVU51SWY3bkk3QXA1VFZvRTBrWkkxdkRIQ3hoT1liMHFC?=
 =?utf-8?B?cWEvcHp4QkNxYktWV1NNeVhYSGIwQ1FyeHhORk1WcG5pem1rMkw3bUpQczBP?=
 =?utf-8?B?N3ZUQVNUSHN0eG93MC9Xd0dGbVRGakd3N01VQmRSeUkzc0NPdkpLTVNUaXl3?=
 =?utf-8?B?RzNRazNzQjZKMDdkN2ExY1J4SDVSd2tOZk81ZFltNmFpYWpPcEQ5ZFNlcUFQ?=
 =?utf-8?B?a3hZWjUyVzJkckZ6azJ3YmdtaGlqanIzZWhDSXBJNW5DQkpzV2Ira1FzSjRO?=
 =?utf-8?B?a1hqMnZSWTR1UG5pK0RKcHJ1VG5xK3R3K3B0MGVHMllVS3RIbmU0aWNNN2Za?=
 =?utf-8?B?aFZHSDRmZEt5QjVOdE1IV2l4ZTdlZGhmZGRTZ1E4c2xGeUUwRjRiZzQvbHJm?=
 =?utf-8?B?dC9uckhCN2IyUHMzamNMWDNWanBDM3FwRTU5b2FKNHpTeWQwZEtRWEMreDEv?=
 =?utf-8?B?QlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a79c90a-42a2-4263-2c18-08dcdce6e277
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 22:18:57.9417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qtx4dLgIvNrS+s7DUM/8tlm0VQfJL43btq5Y42pkZYAqQGjm3wVzUcm1LQTPMOrSZtQepE6cGsUjZYRwSgs9UwqkIWaaPwzzNVlm754WhhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6110
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NA
Z21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjQgMzoxNiBQTQ0K
PiBUbzogWW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gQ2M6IFNyaWRoYXIs
IEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+OyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBoYW5uZXNAY21weGNoZy5v
cmc7DQo+IGNoZW5nbWluZy56aG91QGxpbnV4LmRldjsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsN
Cj4gc2hha2VlbC5idXR0QGxpbnV4LmRldjsgcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZ
aW5nDQo+IDx5aW5nLmh1YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnOw0KPiBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+
OyBGZWdoYWxpLCBXYWpkaSBLDQo+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWws
IFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
NyA2LzhdIG1tOiB6c3dhcDogU3VwcG9ydCBtVEhQIHN3YXBvdXQgaW4NCj4genN3YXBfc3RvcmUo
KS4NCj4gDQo+IE9uIFR1ZSwgU2VwIDI0LCAyMDI0IGF0IDI6MzTigK9QTSBZb3NyeSBBaG1lZCA8
eW9zcnlhaG1lZEBnb29nbGUuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gV2h5IGNhbid0
IHdlIGp1c3QgaGFuZGxlIGl0IHRoZSBzYW1lIHdheSBhcyB3ZSBoYW5kbGUgenN3YXANCj4gPiBk
aXNhYmxlbWVudD8gSWYgaXQgaXMgZGlzYWJsZWQsIHdlIGludmFsaWRhdGUgYW55IG9sZCBlbnRy
aWVzIGZvciB0aGUNCj4gPiBvZmZzZXRzIGFuZCByZXR1cm4gZmFsc2UgdG8gc3dhcG91dCB0byBk
aXNrLg0KPiANCj4gSSB0aGluayB0aGF0IHdhcyB0aGUgc3VnZ2VzdGlvbi4NCj4gDQo+ID4NCj4g
PiBUYWtpbmcgYSBzdGVwIGJhY2ssIHdoeSBkbyB3ZSBuZWVkIHRoZSBydW50aW1lIGtub2IgYW5k
IGNvbmZpZyBvcHRpb24/DQo+ID4gQXJlIHRoZXJlIGNhc2VzIHdoZXJlIHdlIHRoaW5rIHpzd2Fw
b3V0IG9mIG1USFBzIHdpbGwgcGVyZm9ybSBiYWRseSwNCj4gPiBvciBpcyBpdCBqdXN0IGR1ZSB0
byBsYWNrIG9mIGNvbmZpZGVuY2UgaW4gdGhlIGZlYXR1cmU/DQo+IA0KPiBGYWlyIHBvaW50LiBJ
IHRoaW5rIHRoZSByZWFzb24gd2h5IEkgc3VnZ2VzdGVkIHRoaXMga25vYiB3YXMgYmVjYXVzZQ0K
PiB3ZSBvYnNlcnZlIHNvIG11Y2ggcmVncmVzc2lvbnMgaW4gZWFybGllciBiZW5jaG1hcmtzLCBh
bmQgZXNwZWNpYWxseQ0KPiBvbiB0aGUgc29mdHdhcmUgY29tcHJlc3NvciBjb2x1bW4uDQo+IA0K
PiBCdXQgbm93IHRoYXQgd2UndmUgcmV3b3JrZWQgdGhlIGJlbmNobWFyayArIHVzZSB6c3RkIGZv
ciBzb2Z0d2FyZQ0KPiBjb21wcmVzc29yLCBJIHRoaW5rIHdlIGNhbiBnZXQgcmlkIG9mIHRoaXMg
a25vYi9jb25maWcgb3B0aW9uLCBhbmQNCj4gc2ltcGxpZnkgdGhpbmdzLg0KDQpJIGFncmVlLCB0
aGFua3MgTmhhdCEgV2lsbCBmaXggdGhpcyBpbiB2OC4NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg==

