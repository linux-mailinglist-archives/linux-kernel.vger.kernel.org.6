Return-Path: <linux-kernel+bounces-558658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDE1A5E923
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15603B485B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322EC610C;
	Thu, 13 Mar 2025 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPo/5DFR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C64DB640
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741827522; cv=fail; b=qhc6PXvLwlaHE6D+JJ93ccl4YxM/99uwCQQIPbIapSNmUlS4E/W0HBorPd6/pajT+HE2sJ5xGuyD5cj+pVZ7tefnDd0ybhCTYGL+5qC7RoVlaWVFlnDA+imjQCO0WWgHp6c+Wi6s+ntxiLPTDY4HCT0sQh93CrRIxrRbymvLHdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741827522; c=relaxed/simple;
	bh=pq8lmRNi3fK6A3XT68YWnaaGg+p9U2jV7mNDt/0yVBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F4A1i27zt195yiuLwLH/IZEL2xpNOaxs39Uf1KeequWiWpHQzrlxFD2Q3qr6tNCgLJbEE4gP/ldRFaIaGGexXBbku/GOBljcInO+V699VOKRLMIioz0CjRD5D17YlkgkZ8tVWaQPoJMZvbUuAW+rQ+XZDszIpynOKXtZ2gyZLS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPo/5DFR; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741827520; x=1773363520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pq8lmRNi3fK6A3XT68YWnaaGg+p9U2jV7mNDt/0yVBw=;
  b=HPo/5DFR9CY+gxfOQfaGDOMpcBLK9ekge+Yn2MVl3qcLAvaEmRWG0cfU
   GKZYdHycmHic//3hPd4ViX7U4K+U6B3MmN+ng+fb4d+mnMEly6AiESFry
   eHIDwll0yRkYOC0nIhyNpYtb4tIm9tuvgd7AZaWICGj8mbcFMLQWxmBjf
   Srcwl3PoEBStP+2Y83CJoGEezCTI5uSbVqSkWUfMSSrf00kRq6GLhiIAz
   imnyz8cziFuEDiRJHsS43hxo9VMGRd4SHEudvwHKfmVxKhDxkOij8BSCs
   or+STuS+NIpTdzncQL1dfhgnALD+qWrWNFoBSkBNdho9QHTJA0A6/N7u5
   Q==;
X-CSE-ConnectionGUID: vaOaVVLQTDaizN1MTZeYrQ==
X-CSE-MsgGUID: I2/MdtvaRmWZ0eOlGybn1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42656549"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="42656549"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 17:58:40 -0700
X-CSE-ConnectionGUID: cUM757JPTd28lv50UOf1kQ==
X-CSE-MsgGUID: WKwtnD0YQZy3YJlPa7Sf3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="157965333"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 17:58:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 17:58:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 17:58:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 17:58:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2CjXVEhTEG+Q728i+2gKICl9Ff6wi/K+uY+yS3kLvzLRmQ9FY5yEZcA9gFRxqvOpVm1ikfuA2kSkthlak/Sra3mlKb1n1NuvDiS0i2JGHHUZZ3JejaQmJvfS7sWdwSKF7LmflkWAa4fDdAHsFiTgsgRmnIWaM+2FAErNSiQW56qAckNH6yRGiwxFR7NFcCt3k2+8DJ7x05JS/cNc2I138edDaye+ykvffSfLjkqInK84GTlZk9d5Te0uZHwwEb1zApccg5izGeBi7daUs6qVJZYvlKh2+X68odP+EDhLZIjZ9SOL7R1Ruv5AUcOq11Zwucp/w/imiNpzzERIoGllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pq8lmRNi3fK6A3XT68YWnaaGg+p9U2jV7mNDt/0yVBw=;
 b=BDxxWHZvbGrjKUVT/51Uu0q9qabYfqXhlAQGTYECE58B9atEW/KiLtZEymhL479NE+rH3tZym0qhYLNJ035iFBWF45rJkWsS/1o/4cBvC1CvjsCM/Q0hsULCZY/+gM2m7XzCEi99RAibrXaAfba0NJLupKrnIFbS9lGySPPV1tCwmwHbLyImFI+9k8PMlNNU8S0r6V49/DI/lbCWfPdfGURmd0+2MIY1IaHDgIybVhSd9U9VEG4XZdPqEQfLjojuSd0l8etb4+h1Cl3+ShGp9kwQQfnkDmovRjT+mXVlrBmjeM0EcpTpc4legb35GHtDFfil6xcQYk/hpXvWYwPX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8382.namprd11.prod.outlook.com (2603:10b6:610:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 00:57:55 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 00:57:49 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"x86@kernel.org" <x86@kernel.org>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "bhe@redhat.com"
	<bhe@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Topic: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Index: AQHbk0Li0j4hIZraA0O6rldQIQB4e7NwJfwAgAAZWQA=
Date: Thu, 13 Mar 2025 00:57:48 +0000
Message-ID: <e1b3da33446178861ca34e61675f184b439101e2.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
		 <408103f145360dfa04a41bc836ca2c724f29deb0.1741778537.git.kai.huang@intel.com>
	 <4ac689506269e907774806a484e15171b04ffc63.camel@intel.com>
In-Reply-To: <4ac689506269e907774806a484e15171b04ffc63.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB8382:EE_
x-ms-office365-filtering-correlation-id: 600f26fb-c259-45fa-3f4c-08dd61ca133c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?alBzWnpCemtpVS8xS1V3cndYdXFheExoczMyWlJaWnFCT2ZXN2tMbDhjSURH?=
 =?utf-8?B?SktYeXowTVRBY01DZWdNSWpoUUI5b2Nob1VpWjdMT2Y2WGtOL1BtTkpWMEJx?=
 =?utf-8?B?WnNKaGRzbmtaeHd5c1ZINUE5YmFUT0w0a3BMckh2S2xoU2ZzWE42bzkycW5q?=
 =?utf-8?B?UU9YQWNEUEF2cERuVERtUUdNaVQzUFZYL0Iwd09DTEdoalhRTFNZTHM0QkZH?=
 =?utf-8?B?QUk3VFRwcGhGbTM1SmxITFl2U095VEtOZ0hvT2VhcEV6MVI3bVdJdmg2elVz?=
 =?utf-8?B?NGdYK3k3cTRxTDlZeEc4TWRWZDhxS1oremdMbnR5N2dpUDdRK3ZRTkorcU5R?=
 =?utf-8?B?UUtVSTdhWDJzSjFacGU1bDA4eE03U2U4M29COXFES2l6a2xpL21iQ0dqS2Ni?=
 =?utf-8?B?SC8wN2o0U0hKaXZPYzkvcUZYMWFWb1JHdkppTnpiemZJZ1ZPK2lLMFc3eEF6?=
 =?utf-8?B?THpTYjVVRzZUTk4wT1YzeEhhcUk3b05YUWNiWDFEU3pDdGwzL01IcTRUSlVp?=
 =?utf-8?B?WW0wTGhKQTV5a3pWZUhhUW5PaGRWWXp6NU93dkhNL1hpbXVOYzF6a1hFak9a?=
 =?utf-8?B?UWRVWVBpSzh0M0JkMUhzZmEzRWMreHpzSVBReGYvOEdlekZiMWRDcEJoWDhu?=
 =?utf-8?B?VkJZTHV1bUNTeEh6ZTJwTnZyTnRmcjg5TXlJSUk5VThFUHFWVDJZOTRSK0wr?=
 =?utf-8?B?cWd2a0o4UjNDM25udlVaQTlIODRGMWtzRFRxcGNMa1Vab0hjZzYrUVArVmZB?=
 =?utf-8?B?elNWSTFJam1BY29oK1V0Z1UzMnBoV3BLZ2VhdURLeXg0cUdmWUlwQXJLMWRY?=
 =?utf-8?B?Rk1FRWhRQ2VjMlQvcHR4KzZTaG1GcmVtTUhFZElXRjdJdmVvUVRtdGZGQVJp?=
 =?utf-8?B?NGQ2SnZpMFVXeTJaVCt5NjBXZ013L2gzUUdZRDM5OC9lUzVNMjFuR0lLMnlC?=
 =?utf-8?B?QXBocnhqY256ZWFEU2Z3K2J4WndETWdWT3dnUEFGK29EMThITElBQlVLTlVY?=
 =?utf-8?B?ZXExYWRUM1VkcmlqSWczOTlpQkZOYU1LL0dSMnU3YXBQNFlzVDF6bE1TajFr?=
 =?utf-8?B?ajZTVTVnM3VFNXoyZ2tFS255VCs4N2U0WkhOS3VvL3hrQjAyRlZOdGcydy9J?=
 =?utf-8?B?SStmV2trT1VyeHNSanJrYWNBTEFXTHNvdkZ0eG55R3BMM3k2MlNDam1rdXdG?=
 =?utf-8?B?VmhJOUFoU1NQUW43QU02UW0yaG0zWWJJQVB5ck90MGIxNXF6Szk1WmpYQmRB?=
 =?utf-8?B?eWJRTEpqOHBVQUw2eEZKUHFZYlU3bDVJMnFrN2JYVXhKRyswTlhRQ2Vvdy95?=
 =?utf-8?B?aUFrUHdYbHJtWjFuYTQya1RJdzREWG8wWmZuYjM0dmFFK1Z3d0NrR0pkcTZo?=
 =?utf-8?B?ZWM5NkM4eU1GN1NWWHhBV0lQamJYMkVDWEVodHpUQ0ZwaVlKOXBNb2pWMlVV?=
 =?utf-8?B?TU56cXZKWWJtdGhyZUVDajMwbm9zdVdONUtJb2VaaWp3azJiTy9HSzFPSitw?=
 =?utf-8?B?Z05Od1Q0MzVwRWlFMlNZZHNNNzM3OENxMXNPcFRRb1RFWkpPVWtlQjVWVGZK?=
 =?utf-8?B?dzI1R1J1L3FMUVdHS3pJbDZXOGhYTnNaQkNWTkx0cVlvU3B3a2gvbjAzWUFN?=
 =?utf-8?B?eXYrYWFDQnR0UE96djdNcUVmcVVJZVNlSHdUdG15S0JXREoyc21zVXE3bENO?=
 =?utf-8?B?N1NZUFNPSGhld2pLdng0UC9EdzM1NWluQkxHNVVNYTllYkx5OEZIMytrNjlp?=
 =?utf-8?B?ZjBmc2xtWlRjM043d3RBM0tXYnhZaHFYbG42UTJtZE1MUURHb3d5OExOSWcv?=
 =?utf-8?B?cVpQVDZmczhOa1l5bDJWanFGSFE2Y2dldVVhenBmSHRkZ2lCQTE1ZDVicmFM?=
 =?utf-8?B?amp1MXZtbDczbzZDWjJ1MWNGN1ZGQldSVjlhTjQxbnZ3UUloTEtjVjJWWVpi?=
 =?utf-8?Q?wzPcvmn6Zxh1UHMuhNBod7HiZMtvOkoh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUZpcHVacHkyQmg0UUlzU0dIYytySUd2cUFXUmNTeHNZNkZmeTV4MVBITHRv?=
 =?utf-8?B?Rm1VR3hOOE1ZMExxcmF0UkRSODdpY2p2T2FGNGdFVmFBN0xQN21SWTFqTkVV?=
 =?utf-8?B?T2cvOVpYZ1FBbENHOEp3L3VRSXdnN0FkVVBVNlFUeWZhemFtODhMK3RVcnM2?=
 =?utf-8?B?YndyWVhYTkN0R2pJNXo4YzNPSERiVVJuc1lxTjROSEk5cXdSYkFRckk3VFhY?=
 =?utf-8?B?MEVQWFkzSU9EY2xObEpNZjlnSW9OTHBLblBtZGptdWVsaEU0eklEa0FNMVFl?=
 =?utf-8?B?UjJhZEhvc01IeXlGNzhJWGNOVVV1UlFCOTFPaDdMTEN0Sk42VEd4aU96UWMr?=
 =?utf-8?B?MStxYWhvV3dJOTNZR29jOGxRb3F0QytHQWlyVStxbDd0WkIxV2I5YVl6OFhG?=
 =?utf-8?B?cUNUdEREU3hGcVFtR1JqaktrMFhIaGg1NSs5MGs3elFBVmlXOEVGWENCWXov?=
 =?utf-8?B?d0ZaY2wzYnR6WU1keURUYVRzbjlFaGhHRnl0WlA3QlVmVHM4OG1kSkk1bkZw?=
 =?utf-8?B?Y1VDK1FMT0JuUkZSL1RXNC96V1hpSUZtQnQ0VWlIb0tZb0RUWWtFcm1kSTRO?=
 =?utf-8?B?SnIrZlV1WFFsYWtwYjhXMnNoVjQ0SlB5TEhaT0UrREd5d2lOZ3EyTzZ3b2x6?=
 =?utf-8?B?NlkyQ3VLbVdWMVVLL25ZOW85dFR3eHl2ekhjZHR2NGp3T3VzRTBmSkNyMC9V?=
 =?utf-8?B?YTBSWWNnd3lWcEFqV2J5RUh0NnNWY3hpNVlaVHdTVTBJcTNzQlY3eE4vSzIz?=
 =?utf-8?B?Mzc4eHBJZUpXTDlITUx6WVNraFBCUXdweWliM0NEVHNxQ0xXNHdwK0Y3OExX?=
 =?utf-8?B?eGg0M3N5SzdyK0lzYXZYUTdFZXNhbytTVzdNMldnRE8zWTZPWThXdHZabml4?=
 =?utf-8?B?TnBKaTdaU1J1MGkyaGhkTlk0YzA3ZlR6Q1R0RStHbVQxTm9qUm03Qm9WVlg3?=
 =?utf-8?B?bUs4KzcrcktVOEU4bGpEd29BTUdLbEZlTlpNaitKSTloYk1DLzJEeSs1amJq?=
 =?utf-8?B?VDJBcDlGV3YzcncxU0hXSVZnbm9JK1Y5ak1INUdBQjhCaHd1ZDF5aDBjL0Y4?=
 =?utf-8?B?UTRkZmZMVGpnNUU0bFllYm9qNkhKb2tYamJDK29zT2RMQWNVbjA2NDIyMTM4?=
 =?utf-8?B?UU9TK3F3bWRmUUtLNUIrZkVtRUFiTzJocFlSYXVzOTY4ZWF3OHVxOFgxeGFo?=
 =?utf-8?B?aGZrUXlIQTM0QmpaS0ZkalovL2JpYjkyWXRqYnlSbDRHNkU4d2twNWhZaXpv?=
 =?utf-8?B?QVREVzRUN1NwdDNVUGkzMUNteWFrM0ZpRjVoTVdrLzBVcENmWTUwUC9wUHhI?=
 =?utf-8?B?RG41WEhwWUtWUTdpNkxsenlpcUVwYnRHV25WK083ckVORVprQ1I2VXZaSFZK?=
 =?utf-8?B?d1o2cXhJa3h2T094K2NLa3QzOEF1aWJLVUNmQVF1c0FuM2htZFpMdzB2cFg1?=
 =?utf-8?B?U1d1QVlqRVd6S0dpYWJIL205QmxPcEtLR3E1MFRzZzdiZ1lYbnVyQTZZZmov?=
 =?utf-8?B?U0VjTGxIbEk4a2ZvNjFxSTVnN3hhNGp5NE9VckM4S2h3VGtoUUNOaXZYSVU2?=
 =?utf-8?B?Sjg5dnRWVFlUTEtKME84bjBaVnBRNDVWcE1aOXdHai8yUU00aUkxbVhWcUJM?=
 =?utf-8?B?ck41VFNpczJFQkN3dS8wNlZSNEVwU1lnbEdGNUtnMEJYenBzZFBNRC9lU056?=
 =?utf-8?B?VXR2bkhVSlhxQmRCM1dueXdpbUdvbitxV3JpK2tua2xha0VISXRFV0JYaFYy?=
 =?utf-8?B?Wit6MjlGemZlUmZmU242SURCVzA0cXJhcERjS3ZFWWVXQmRNWEoyb25DdXhO?=
 =?utf-8?B?bDZRTytuS1NFd3JVQSsvbHBacFFid1ROT3pBeXc3b0F5WTZMTnBGY2tMOCtJ?=
 =?utf-8?B?TVRtQ2I3aTI5WWovelRSOUw5d2w5Wkppd0JMRXplNDVhUVpMdVQzVjV1S0RX?=
 =?utf-8?B?QWtOd1hvU1E0cEpQZ1FDUVRKNENxVGhHRkhySkJ6RzJsaVh1VnJoYlordTRm?=
 =?utf-8?B?QTcvZ2dINjJBandITnczemRoeUNyclByclR4RUl5TStRaW5IeFVSVUV2MW5o?=
 =?utf-8?B?NU1ocGJSZExEZUs1ZWQyYnM1dGxGQW5UamVxRFBOK3AvTVUrUU9YWFFmZnZN?=
 =?utf-8?Q?/BlXT/13ph0osi50enI8cWwQ1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7E86B2CCAE7D040B64B44BAC3EC9132@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600f26fb-c259-45fa-3f4c-08dd61ca133c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 00:57:49.0031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PqzVizxzr2z2iyk6NEInng+lUD8VPLS4u86McWjEXdG590BW4GHsxrZc512f+0eLQ2WOMWvU5RQjTfjz5beRpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8382
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTAzLTEyIGF0IDIzOjI3ICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gT24gVGh1LCAyMDI1LTAzLTEzIGF0IDAwOjM0ICsxMzAwLCBLYWkgSHVhbmcgd3JvdGU6
DQo+ID4gVGhlIGltcGFjdCB0byB1c2Vyc3BhY2UgaXMgdGhlIHVzZXJzIHdpbGwgZ2V0IGFuIGVy
cm9yIHdoZW4gbG9hZGluZyB0aGUNCj4gPiBrZXhlYy9rZHVtcCBrZXJuZWwgaW1hZ2U6DQo+ID4g
DQo+ID4gwqAga2V4ZWNfbG9hZCBmYWlsZWQ6IE9wZXJhdGlvbiBub3Qgc3VwcG9ydGVkDQo+ID4g
DQo+ID4gVGhpcyBtaWdodCBiZSBjb25mdXNpbmcgdG8gdGhlIHVzZXJzLCB0aHVzIGFsc28gcHJp
bnQgdGhlIHJlYXNvbiBpbiB0aGUNCj4gPiBkbWVzZzoNCj4gPiANCj4gPiDCoCBbLi5dIGtleGVj
OiBub3QgYWxsb3dlZCBvbiBwbGF0Zm9ybSB3aXRoIHRkeF9wd19tY2UgYnVnLg0KPiANCj4gQ29u
dGludWluZyBhbiBpbnRlcm5hbCBkaXNjdXNzaW9uLi4uIEEgcHJvYmxlbSB3aXRoIHRoZSBwbGFu
IHRvIG1vcmUgc2ltcGx5DQo+IHN0YXJ0IHN1cHBvcnQgZm9yIGtleGVjIGJ5IG5vdCBzdXBwb3J0
aW5nIHRoZSBlcnJhdGEgcGxhdGZvcm1zIGlzIHRoYXQgd2hlbg0KPiB0aGVzZSBwbGF0Zm9ybXMg
Y29uZmlndXJlIFREWCB0aGV5IHdpbGwgbG9zZSBrZXhlYyBieSBkZWZhdWx0Lg0KPiANCj4gUHJv
YmFibHkgYSBiZXR0ZXIgZGVmYXVsdCBmb3IgYSBsb3Qgb2Yga2VybmVscyB3b3VsZCBiZSB0byBo
YXZlIGtleGVjIHdvcmsgYnkNCj4gZGVmYXVsdCwgYW5kIHJlcXVpcmUgb3B0LWluIHRvIHVzZSBU
RFggKGFuZCBsb3NlIGtleGVjKS4gT25lIGlkZWEgd2FzIGEga2VybmVsDQo+IHBhcmFtZXRlciBi
ZSByZXF1aXJlZCB0byBlbmFibGUgVERYIG9uIHRob3NlIHBsYXRmb3Jtcy4gQnV0IHRoZW4gd2Ug
YXJlIHN0YXJ0aW5nDQo+IHRvIGFkZCBjb21wbGV4aXR5IHRvIGF2b2lkIG90aGVyIGNvbXBsZXhp
dHkgKHRoZSBlcnJhdGEgcGxhdGZvcm0ga2V4ZWMgc3VwcG9ydCkuDQo+IA0KPiBTdGlsbCwgaXQg
bWF5IGJlIGEgbmV0IHdpbiBvbiBjb21wbGV4aXR5Lg0KDQpXZSBjYW4gYWRkIGEga2VybmVsIHBh
cmFtZXRlciAndGR4X2hvc3Q9e29ufG9mZn0nIGFuZCBza2lwIGFsbCBURFggY29kZSAodGh1cyBu
bw0KZXJyYXR1bSBkZXRlY3Rpb24pIHdoZW4gaXQgaXMgb2ZmLiAgSSBzdXBwb3NlIGl0IHdpbGwg
YmUgdXNlZnVsIGluIGdlbmVyYWwNCmFueXdheSBldmVuIHcvbyB0aGUgY29udGV4dCBvZiBrZXhl
Yy4NCg==

