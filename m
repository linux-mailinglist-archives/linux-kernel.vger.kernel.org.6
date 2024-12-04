Return-Path: <linux-kernel+bounces-431385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7079E3CA1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E2D161D80
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3503202F84;
	Wed,  4 Dec 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keOB8MLX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CE41FECCF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322158; cv=fail; b=TPJbxrBu0ehqQAfa+tsyPRgWzwr9oH1kC+gTx/o6S6pjMy2T7FMLY0W+846tFP2SggfuVnVAGIWJ8GcOEfwpsVbT+DFGY0pSZJir9t2xFXe85OEdLuclpnSMKrc+6os4JQX5BSGu2E7za/qNPgVUnwW/DgI33BlknnGtZBi1Ly4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322158; c=relaxed/simple;
	bh=yR+zNTiToOfhPG9wSjhtmo5nM1LYIw5LUpy+LmaAgX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WbHQtlT2s2QWv0pE+YgTPZroMW87zM1tVxDVB8GTEYvxnX7hA2OrGA4nwZEXk50TBnpithJpwFjAxiLvK98LF6+6xEFZSobP4B2+qAb9IFHGr3zcGzUyZrUuM9t8Wp77tDuNRxKXN4FlyW0OTZ38WRMfAyQXTVDBx1LW4dWfeuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=keOB8MLX; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733322156; x=1764858156;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yR+zNTiToOfhPG9wSjhtmo5nM1LYIw5LUpy+LmaAgX8=;
  b=keOB8MLX43a9pNzwlC1oS7y4F+kbek2vLwUvwtSzrd7Nd6Tv1tLy3mDV
   HoKkLRt3OoYR/Hi2E0Wxr2c67uL6fJHXPIGr3FgOVzi5ZPywyEAj7IPBS
   Hrv2c3ChFqS6bkM0gPb22BiamSerR7VOO0tMm0lo2fCEVpAhVSDHePfDy
   XPU4Hb//LxFQU+02Ba8uBYL64GvGjLbFu1P+UJOblrrT0JwBbiyeG8s37
   OiEabZu/h02Y4alCApJE065DQl/EYNhGtiDHXGosoweAGQ2HPi15MjHle
   j6uTLwfbGpaaZFnqKMSJ7JEVpOcJ5PztYfMXONb0wy8Cp/B0hegicRRs2
   g==;
X-CSE-ConnectionGUID: lvRSDe/cS/+0iHhfYUSAVg==
X-CSE-MsgGUID: JEjPhh68RSqTh1/1PKY3lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="51007394"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="51007394"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:22:35 -0800
X-CSE-ConnectionGUID: 8lMo+u/NRx+PuTobOd66JQ==
X-CSE-MsgGUID: xoNRLZCyR2+V8B5iYRBSPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="131230381"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 06:22:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 06:22:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 06:22:34 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 06:22:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxPGrW4PS1wUqbMiU/pEBCrH/A0re/Qls1DUMpN6skGqo+NWiCKZEcQvx02AQvXN0xcgdlEp5o7qemTMyh78dHUCuyNjDz5OztReGHDtwnEW5Ppws3awtKZzi61v8Gc7ZB71DzFbLGvwGmOvscAZXAAUXDcHgePu9lyEnSB8lp9wiWQnVCWowjS47xN3Gcnc74nsnHtD8MZMhdoRG/q5rwFMylLDDiDSCKGxbxvLbqDraplobMh0C9iqKL3eZNsLKvcN3dg3RZqmahgOaSnMzp1WZ2EMYg53e2PqLWjwOZDYI+n0E9rlJCk5ZRS0QybFKEksVX5xbdTsHKuy1dZ/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR+zNTiToOfhPG9wSjhtmo5nM1LYIw5LUpy+LmaAgX8=;
 b=TQF1KpFps5BGDWaCUX9DBo1OwzzAb0YMEw3vh/QclwXnu/JQAEAERvmW3X66j3ro1FnrCIouwXjXgV4bF8JZPUciLc9P/G8zSc2iy3m6XINKVQEuzMhnu7yNbfO+m+/hFozATQ3i18yCZI83jz749mTsZm2YFr8CxGPMWD8UDtfOzrnGO8joF1ese9ZM08sYTdk0wkY7Wcv2iP3P+W0MtHXp4MhpUlvyQfyvry7+TZQM9qOvApTjhG1ljfTrr9s+aykxySSxKCEp0tWqTTfksk9rcJrmx9QWnEPqgkSQqWkJvJetrJRfpTBjO22+uODxLcJivHRtj9khdoGwVtfkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB7657.namprd11.prod.outlook.com (2603:10b6:510:26c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 14:22:27 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 14:22:27 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH v8 8/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Thread-Topic: [PATCH v8 8/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Thread-Index: AQHbNcNRlNQ0Lob1fE++s9mJJDFOE7LWRFWA
Date: Wed, 4 Dec 2024 14:22:27 +0000
Message-ID: <5caabdaf1d7c92cc6cc5f4dc895615fccfa366cb.camel@intel.com>
References: <cover.1731498635.git.kai.huang@intel.com>
	 <23bb421e9bf5443a823e163fb2d899760d9f14a3.1731498635.git.kai.huang@intel.com>
In-Reply-To: <23bb421e9bf5443a823e163fb2d899760d9f14a3.1731498635.git.kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.2 (3.54.2-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB7657:EE_
x-ms-office365-filtering-correlation-id: ea8ab214-0058-47af-0182-08dd146f14ab
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?UTd2MnVFVzZmN3p1V0c4ekY3UTVQUUYrNE9IU1FCWkJBWkxYQ21CdEhDMFFz?=
 =?utf-8?B?Q3hHemdwbU93bDgxaTRyelFEQmNlQi9tWUFtMXgzMGtJSjNuSE12dHd6NXdG?=
 =?utf-8?B?MFV0OGUwZEpFUEw5c2wzZHFFc0FNRXQrU3RDY0t1N2ZBY09TcTgyTzYyY3Z5?=
 =?utf-8?B?WFkrdjVBVkVwLys1RDgvRzl0NUJoWXVHYjZkcVFFYzhUbmZ0Zk5NTDBwUE45?=
 =?utf-8?B?UGNWS20vcjdXU3dKS1FTUTZPTkh3M1lzdW44bllnaUh2TlF4cHZFU1hhRUw1?=
 =?utf-8?B?VFVlZHN5WnppdWlPb2hEcmNpMTd5VEJCbmlYRWN3Tld3VTJpWXBJWFJXQVI0?=
 =?utf-8?B?OUFndTdPM3h0NllvaFZBVUJJSmQxUm94UFdtcVRVWlpPYmVvbk9MMTFndm5U?=
 =?utf-8?B?MkRvL2RMY2JiOXl0VlVGUnE3Z3lFWU1EWXhlNUljTEhlQUYyMmpoNDZkQXgr?=
 =?utf-8?B?KzlzZThrSy9qNmgxbDg0dVUrM2ZyK0JybXF2WGtPOVhlM2JDNzdZT295MnR4?=
 =?utf-8?B?V2tkUnRGNG9lRUJBU3ZkSTdmYnk5RHdVd3VMakQrR2pmR2dOSms2c3BycHpZ?=
 =?utf-8?B?dFpGV2xhUFNqVWtPcUxsK2FQMVpUTGh3cmxpUmpEZE5zSGt5b1hoNXFaZ2w5?=
 =?utf-8?B?WDlTYW1mVFRzQkRaZHBoK3p4SjUzTkZvMUR3MVNoZ2lxVkl3b3MrTGVKV29J?=
 =?utf-8?B?NTcvbUR3eUlwZlByMGtDTjI2Q0V1Nmc2TDVuQi9LNVdPdTJHMGZtOWhEL1VK?=
 =?utf-8?B?V1lJS1o2cEVvQWpyMm5UYzk3em5SOVlINC9qemIzenRteFZMazlObm0raDR3?=
 =?utf-8?B?MGNjWGlzVzl2c2lXeWl1a0xhMmJQa1NWWnprMEljaTR5d3pWVTl2MGhpSUhD?=
 =?utf-8?B?VWZDcDl1S0RSanZzT0VKbTdvR0dNTEZOM2szRHFmc2xzVDdvOWh1bTdyLzhH?=
 =?utf-8?B?ajh4OUlaUmRNMExSZk5IZEpNWGRZejZMR25NSUhZRndpdENHVHhLQ25Zc1Va?=
 =?utf-8?B?azdBMU81R2pJRHRFNVFaTkdzZGhobW5tQUN3RE9ML1hEMHp5RWRHd2JGd0dl?=
 =?utf-8?B?b1FkVXJWNnI3OFZTdS9ydlFTV3ZDNHJyWmFwVC9XQ2dNNXRJOThNdi9Ga1JJ?=
 =?utf-8?B?MDJMb0ZTenM2d01VTEl4UVYzSjhVSzA0bmM3SFQxRklUVFpmSUtSYkpWbEJ5?=
 =?utf-8?B?dXBXUFBPczdIUEtzdHhzKzc3cnhseUdZZ3lzRkw0VjBydGNPMjJTbG1NeU5V?=
 =?utf-8?B?c2twODJnVXdHRkwxZUQ0WldjcStDQkhjeXJRWFhkVEVJK1J1ZjMyeWdkZjFj?=
 =?utf-8?B?aGpJYmJxS0ZhWnJ3ajVxNjI5R3Q0Zk5jQzNZU1hHb2ptTzRFb3dOS1c3MzA0?=
 =?utf-8?B?eW1nNkUrRjZKRFFkdExTK1VtMVlzSEJZdnE0TlhhR0pzbTNmdWYyV3U5c2dJ?=
 =?utf-8?B?ZVB6c2xlTHJ3MzF5MzhyZ0ZPVnRzOVovZWN6cFVTTGpiWTJxK2VyMEJHVXdY?=
 =?utf-8?B?a0Y1RFFrYktFT0ZrMWU4Q3JnS1lNTDRQZ0RSSTYzYUJxUVBCcTJPQzdMY3FV?=
 =?utf-8?B?citwN2phcWMzVURXeFJPZFFOTDZsTjdoZGZ2bDA5eWQ0eURBWm1xdldsZElu?=
 =?utf-8?B?ZEZ0UG5lSTZTK000OWZRcjlsU2NiQ2N4QkFhaFhPMFdXK0xieUF5WWxDR2pI?=
 =?utf-8?B?ejJIdE1aNmJ4bXlxZ3ZTRnB4S0gwR2FSdXFJVzN4OXNUMHhYdGd0a3I3bEVP?=
 =?utf-8?B?UXhCaUg3VW1XeFlvOFNJb05aOG5tSHJyaTNBWGpLRjlKRi9zcFNIY1lHcWd0?=
 =?utf-8?B?NlFncVltNGZtZzlLWThJc1Jxcm1VTVZKQkVLYkNhaHJrNWpJZjBOVzZKd0Jz?=
 =?utf-8?B?ZWVHRERwZlNxSjRVZGJCaUM4M3NLS1Y3MzhHd2RSNTlyY29QYXFpekNoZmF3?=
 =?utf-8?Q?pUYOOF2KFf4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTRVMENNc3dQV2FreVpaTzJGdUV0ZEJNay84M0Jobk4vYzRzcmtEN0ZmVWo0?=
 =?utf-8?B?UzdlWjd6Tm8rSHpUYS9BWTc1QkZxdFJJTURMdW92a0JTVzlBbU1wcnNHeEhG?=
 =?utf-8?B?MENwc3pFWlYvNnZ0MlBmSkFJeStMa2N2cjl4VUNIcmhwOGcxejlrSWVmN3NM?=
 =?utf-8?B?enU4YkJ3M21tTklITDVNN0xJM2FUT2t5ZWJZR1Y1WjQ4NVBzNmVzUDczUXpx?=
 =?utf-8?B?dTJKTm9BdXE0eUR0MWYrVUliSy9kVGpuNGk5TGxFSnZJc3VTRE9Rd1VOTnEz?=
 =?utf-8?B?K0xRU1NDNDFXTWZ2azd3SWZZYkJsNy90TFBSMzZMSDhuQjMybFZKU2lNb3R4?=
 =?utf-8?B?MGc0eU9vdEd1YlRJWHJiM1diN0pHUnUvZm5vWDh2RDBmdjAzTGZBQnV0aG5y?=
 =?utf-8?B?RkxmWjg2M3NqeHZuaTRkQ2xMVUhzaHhCSHpoZUdZNU16bkZ5cmdvNk5xcklX?=
 =?utf-8?B?U255ZWU4cGRzdWlZTmgwRDBYaWZoQlNLMXdZaE9HakVVaS8zVEhUc2Z5b3pM?=
 =?utf-8?B?WDRMcUwyRUdKNUF3ZDhENHdTbHRLTGw2MjlRem9LQi9ZcFROWEh3a2kybldq?=
 =?utf-8?B?WWttSVJjS1Iyb1BZOUlNQVlRNUZqalVDYnQvTG1qU3RKb1Vxdk9DMGpPbWNJ?=
 =?utf-8?B?b2VyU3EvWU5yUEhEMUNnQWd0L3huam1Va0N3c2JjY2s2c0llOFg4dDJVUmc2?=
 =?utf-8?B?amxBNm9KUm94Uk9qdFhobFJOZVVaK2lTQ2h1NkNOYXFkNlZxQVZtdk5lN1ps?=
 =?utf-8?B?d1M2Yy9EOVpBcUZPNEtZUHY3TFIxNXMyM0pCOG1iQXVaWU4xOGg3MjhYc3VN?=
 =?utf-8?B?SE1GSjlDYTN3STFJeTErOVg2ZU9YVFBkS3FIVVpFVGxkenBXZHNoUk9hUmhL?=
 =?utf-8?B?TGtONVA0UTNCSXlRbm42Qnk0UzBtc1NTSmk4ZGJWQXVLdXovNE5GM2laOWhT?=
 =?utf-8?B?QWl5WjFlbDg5UW1MazlzM2ZRVlVjSlNsUG96TXY4TFNESjIvK2JmeE9SSlNR?=
 =?utf-8?B?dnlHMmpWb2NJK1J6NXo0UWI0b1dpK2VBNnVZWnV3UXdMV0Q2VlgycnpxMUtk?=
 =?utf-8?B?RGRFOGtrZ05hSWdvdjdUVTZEamhWZGJhbzA5ZG5IajZwbjdrcXhhQU9IMG5y?=
 =?utf-8?B?Q0loNys2V1REYzN5M0QxVFdReE5hZWNyVENoeXo5b3NDS1d3UVQxTFRJZjVx?=
 =?utf-8?B?SUcySEQ2enZtZ2xNdnhteW5DSXBZc1pRTGhCTEo0VDRVakdaanFMUHRSZTB5?=
 =?utf-8?B?eGZ1Yk02QW5CWFFwMXB3M2g3aVRMQWRuQjYzMjdnQzFvSEhyUVR0TjZGWko0?=
 =?utf-8?B?YUdtaEFGcWhVODROWFBQc2d6eXlJWm9zKytOdTVoYkowb01lSWlBTHE0Q2dm?=
 =?utf-8?B?WFNoVGNna1k4czVXYzQvR2F5VE9FMTY5VTVoam5NekVvU3l0UkJtd1dFNmJm?=
 =?utf-8?B?dlAvWE53MUF5RGxUb0lCODBtS0d6dTNueDlpRnpJYzlaNkZYME1LSmJOUkhs?=
 =?utf-8?B?U1ppc1pCZWxoUGxzSXFnK0FQRElTWUpVTUsvYkdZcHVpUjduTnJaUmRwZFVY?=
 =?utf-8?B?akNMOEJHM3B5QUNOSTI4dHRXYldqZWcwbGVuMDdkNml2ODRLMzBMVGtxZHEz?=
 =?utf-8?B?MFFyaTN0Q1pkbWlqK2dCMzdtZGhURy9XTUNuaU1XVThoNk4ydWU5RmkzWGRL?=
 =?utf-8?B?VVZBQk50K0tjckNuYXNLeWtDODJlVFJwQmtMVmxoUFdhSFQvTWNMS20reFcw?=
 =?utf-8?B?QXdIRnB4aWE4ampuRU5xQVpDakJhbWYyTG1DaUlDTEEwVU9USENTOEM1NGZ0?=
 =?utf-8?B?UzJFNmExRE1kVXJ2Z2RSOExPODdpY1ErT2ViWi9RM01uQ2prTjE0d0FXTWt6?=
 =?utf-8?B?TlJkTU5FTlBmalZ2K3ZITk84OCtCam1kUi9tMGlJU3JReDZjaysrUGFSQXBv?=
 =?utf-8?B?cGJuWC94MnFoVnN3R1ErWmVqL3EwVXpMcG11VEdHQ0tOU0QvV2FvSURvZFJM?=
 =?utf-8?B?MnhSalllY1FPMEZIYU00OFhBdDQvQzlYZTZSaytSUzhiSDJpeUFIQmFnMkxm?=
 =?utf-8?B?RHlrT1AxMXNIUTJ3c2NUVVVSMW9CL1J4UFVZRkZNRkNBdjM5S2M4SmM2emlx?=
 =?utf-8?Q?Fc2RTd79vWS01je7KcNWU7TVj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E219C2FBFB0B8E488041B3B84F1D294C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8ab214-0058-47af-0182-08dd146f14ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 14:22:27.6718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlG4AsbgfWhM0DEJEGlAH3BaWFJe4SnPNuBambh7tzO9SKg0qHoqXsy8V8uj+/alOCHq3YfhOpVgz6LsVfhwgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7657
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTExLTE0IGF0IDAwOjU3ICsxMzAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+IEEg
VERYIG1vZHVsZSBpbml0aWFsaXphdGlvbiBmYWlsdXJlIHdhcyByZXBvcnRlZCBvbiBhIEVtZXJh
bGQgUmFwaWRzDQo+IHBsYXRmb3JtIFsqXToNCj4gDQo+ICAgdmlydC90ZHg6IGluaXRpYWxpemF0
aW9uIGZhaWxlZDogVERNUiBbMHgwLCAweDgwMDAwMDAwKTogcmVzZXJ2ZWQgYXJlYXMgZXhoYXVz
dGVkLg0KPiAgIHZpcnQvdGR4OiBtb2R1bGUgaW5pdGlhbGl6YXRpb24gZmFpbGVkICgtMjgpDQo+
IA0KPiBBcyBwYXJ0IG9mIGluaXRpYWxpemluZyB0aGUgVERYIG1vZHVsZSwgdGhlIGtlcm5lbCBp
bmZvcm1zIHRoZSBURFgNCj4gbW9kdWxlIG9mIGFsbCAiVERYLXVzYWJsZSBtZW1vcnkgcmVnaW9u
cyIgdXNpbmcgYW4gYXJyYXkgb2YgVERYIGRlZmluZWQNCj4gc3RydWN0dXJlICJURCBNZW1vcnkg
UmVnaW9uIiAoVERNUikuICBFYWNoIFRETVIgbXVzdCBiZSBpbiAxR0IgYWxpZ25lZA0KPiBhbmQg
aW4gMUdCIGdyYW51bGFyaXR5LCBhbmQgYWxsICJub24tVERYLXVzYWJsZSBtZW1vcnkgaG9sZXMi
IHdpdGhpbiBhDQo+IGdpdmVuIFRETVIgYXJlIG1hcmtlZCBhcyAicmVzZXJ2ZWQgYXJlYXMiLiAg
VGhlIFREWCBtb2R1bGUgcmVwb3J0cyBhDQo+IG1heGltdW0gbnVtYmVyIG9mIHJlc2VydmVkIGFy
ZWFzIHRoYXQgY2FuIGJlIHN1cHBvcnRlZCBwZXIgVERNUiAoMTYpLg0KPiANCj4gVGhlIGtlcm5l
bCBidWlsZHMgdGhlICJURFgtdXNhYmxlIG1lbW9yeSByZWdpb25zIiBiYXNlZCBvbiBtZW1ibG9j
a3MNCj4gKHdoaWNoIHJlZmxlY3RzIGU4MjApLCBhbmQgdXNlcyB0aGlzIGxpc3QgdG8gZmluZCBh
bGwgInJlc2VydmVkIGFyZWFzIg0KPiBmb3IgZWFjaCBURE1SLg0KPiANCj4gSXQgdHVybnMgb3V0
IHRoYXQgdGhlIGtlcm5lbCdzIHZpZXcgb2YgbWVtb3J5IGhvbGVzIGlzIHRvbyBmaW5lIGdyYWlu
ZWQNCj4gYW5kIHNvbWV0aW1lcyBleGNlZWRzIHRoZSBudW1iZXIgb2YgaG9sZXMgdGhhdCB0aGUg
VERYIG1vZHVsZSBjYW4gdHJhY2sNCj4gcGVyIFRETVIgWzFdLCByZXN1bHRpbmcgaW4gdGhlIGFi
b3ZlIGZhaWx1cmUuDQo+IA0KPiBUaGFua2Z1bGx5IHRoZSBtb2R1bGUgYWxzbyBsaXN0cyBtZW1v
cnkgdGhhdCBpcyBwb3RlbnRpYWxseSBjb252ZXJ0aWJsZQ0KPiBpbiBhIGxpc3Qgb2YgIkNvbnZl
cnRpYmxlIE1lbW9yeSBSZWdpb25zIiAoQ01ScykuICBUaGF0IGNvYXJzZXIgZ3JhaW5lZA0KPiBD
TVIgbGlzdCB0ZW5kcyB0byB0cmFjayB1c2FibGUgbWVtb3J5IGluIHRoZSBtZW1vcnkgbWFwIGV2
ZW4gaWYgaXQgbWlnaHQNCj4gYmUgcmVzZXJ2ZWQgZm9yIGhvc3QgdXNhZ2UgbGlrZSAnQUNQSSBk
YXRhJyBbMl0uDQo+IA0KPiBVc2UgdGhhdCBsaXN0IHRvIHJlbGF4IHdoYXQgdGhlIGtlcm5lbCBj
b25zaWRlcnMgdW51c2FibGUgbWVtb3J5LiAgSWYgaXQNCj4gZmFsbHMgaW4gYSBDTVIgbm8gbmVl
ZCB0byBpbnN0YW50aWF0ZSBhIGhvbGUsIGFuZCByZWx5IG9uIHRoZSBmYWN0IHRoYXQNCj4ga2Vy
bmVsIHdpbGwga2VlcCB3aGF0IGl0IGNvbnNpZGVycyAncmVzZXJ2ZWQnIG91dCBvZiB0aGUgcGFn
ZSBhbGxvY2F0b3IuDQo+IA0KDQpIaSBEYXZlLA0KDQpJIHJlYWxpemVkIHRoZXJlJ3Mgb25lIGlz
c3VlIGlmIHdlIGNoYW5nZSB0byB1c2UgQ01ScyB0byBmaWxsIHVwIHJlc2VydmVkIGFyZWFzDQpm
b3IgVERNUnMgYWZ0ZXIgc29tZSBpbnRlcm5hbCBkaXNjdXNzaW9uIHdpdGggRGFuOg0KDQpDdXJy
ZW50bHkgd2UgcmVxdWlyZXMgYWxsIG1lbW9yeSByZWdpb25zIGluIG1lbWJsb2Nrcy5tZW1vcnkg
dG8gYmUgVERYDQpjb252ZXJ0aWJsZSBtZW1vcnkgYXQgdGhlIHRpbWUgb2YgaW5pdGlhbGl6aW5n
IHRoZSBURFggbW9kdWxlIHRvIG1ha2UgbW9kdWxlDQppbml0aWFsaXphdGlvbiBzdWNjZXNzZnVs
LiAgV2UgYnVpbGQgYSBsaXN0IG9mIHRob3NlIG1lbW9yeSByZWdpb25zIGFzIGEgbGlzdCBvZg0K
IlREWCBtZW1vcnkgYmxvY2tzIiwgYW5kIHVzZSB0aGVtIHRvIGNvbnN0cnVjdCB0aGUgVERNUnMg
dG8gY29uZmlndXJlIHRoZQ0KbW9kdWxlLiAgQnV0IHdlIGRvbid0IGV4cGxpY2l0bHkgY2hlY2sg
dGhvc2UgbWVtb3J5IHJlZ2lvbnMgYWdhaW5zdCBDTVJzIHRvIG1ha2UNCnN1cmUgdGhleSBhcmUg
dHJ1bHkgVERYIGNvbnZlcnRpYmxlLCBpbnN0ZWFkIHdlIGRlcGVuZCBvbiBUREguU1lTLkNPTkZJ
RyB0bw0KY2F0Y2ggYW55IG5vbi1DTVIgbWVtb3J5IHJlZ2lvbnMgdGhhdCBlbmQgdXAgdG8gdGhl
IFREWCBtZW1vcnkgYmxvY2tzLg0KDQpUaGlzIHdvcmtzIGZpbmUgYmVjYXVzZSBjdXJyZW50bHkg
d2UgdXNlIHRob3NlIFREWCBtZW1vcnkgYmxvY2tzIHRvIGZpbGwgdXAgdGhlDQpyZXNlcnZlZCBh
cmVhcyBvZiBURE1ScywgaS5lLiwgYW55IG5vbi1DTVIgcmVnaW9ucyBpbiBURFggbWVtb3J5IGJs
b2NrcyB3aWxsIGVuZA0KdXAgdG8gIm5vbi1yZXNlcnZlZCBhcmVhcyIgaW4gVERNUihzKSwgYW5k
IHRoaXMgd2lsbCBjYXVzZSBUREguU1lTLkNPTkZJRyB0bw0KZmFpbC4NCg0KQWZ0ZXIgd2UgY2hh
bmdlIHRvIHVzaW5nIENNUnMgdG8gZmlsbCB1cCByZXNlcnZlZCBhcmVhcyBvZiBURE1ScywgdGhl
biBhbGwgbm9uLQ0KQ01SIHJlZ2lvbnMgd2lsbCBiZSBtYXJrZWQgYXMgInJlc2VydmVkIGFyZWFz
IiwgcmVnYXJkbGVzcyB3aGV0aGVyIHRoZXJlIGlzIGFueQ0Kbm9uLUNNUiBtZW1vcnkgcmVnaW9u
IGluIHRoZSBURFggbWVtb3J5IGJsb2Nrcy4gIFRoaXMgd2lsbCByZXN1bHQgaW4gVERYIG1vZHVs
ZQ0KaW5pdGlhbGl6YXRpb24gYmVpbmcgc3VjY2Vzc2Z1bCB3aGlsZSB0aGVyZSBhcmUgbm9uLUNN
UiBwYWdlcyBnb2luZyBpbnRvIHBhZ2UNCmFsbG9jYXRvci4NCg0KVG8gYXZvaWQgdGhpcywgd2Ug
bmVlZCB0byBleHBsaWNpdGx5IGNoZWNrIGFsbCB0aGUgVERYIG1lbW9yeSBibG9ja3MgYWdhaW5z
dA0KQ01ScyB0byBtYWtlIHN1cmUgdGhleSBhcmUgYWN0dWFsbHkgVERYIGNvbnZlcnRpYmxlLCBi
ZWZvcmUgdXNpbmcgQ01ScyB0byBmaWxsDQp1cCByZXNlcnZlZCBhcmVhcy4NCg0KSSBlbmRlZCB1
cCB3aXRoIGJlbG93IGluY3JlbWVudGFsIGRpZmYgd2l0aCBzb21lIGFkZGl0aW9uYWwgdGV4dCBm
b3IgdGhlDQpjaGFuZ2Vsb2cuDQoNCkRvIHlvdSBoYXZlIGFueSBjb21tZW50cz8NCg0KLS0tLS0t
DQoNCiAgICBDdXJyZW50bHksIHRoZSBrZXJuZWwgZG9lcyBub3QgZXhwbGljaXRseSBjaGVjayBh
bGwgVERYLXVzYWJsZSBtZW1vcnkNCiAgICByZWdpb25zICh0aGF0IGNvbWUgZnJvbSBtZW1ibG9j
aykgdG8gYmUgdHJ1bHkgVERYIGNvbnZlcnRpYmxlIChub3QNCiAgICBmZWFzaWJsZSB3L28gQ01S
cyBhbnl3YXkpIGJ1dCBkZXBlbmRzIG9uIHRoZSBUREguU1lTLkNPTkZJRyB0byBmYWlsIGlmDQog
ICAgdGhlcmUncyBhbnkgbm9uLUNNUiBtZW1vcnkgcmVnaW9uIGVuZGVkIHVwIGFzIFREWC11c2Fi
bGUgbWVtb3J5Lg0KICAgIA0KICAgIEFmdGVyIGNoYW5naW5nIHRvIHVzaW5nIENNUnMgdG8gZmls
bCB1cCByZXNlcnZlZCBhcmVhcywgdW5mb3J0dW5hdGVseQ0KICAgIHRoZSBUREguU1lTLkNPTkZJ
RyB3aWxsIG5vIGxvbmdlciBiZSBhYmxlIHRvIGNhdGNoIHN1Y2ggbm9uLUNNUiByZWdpb25zLg0K
ICAgIFRoaXMgaXMgYmVjYXVzZSBhbnkgbm9uLUNNUiByZWdpb24gd2lsbCBhbHdheXMgZW5kIHVw
IHdpdGggcmVzZXJ2ZWQNCiAgICBhcmVhIGV2ZW4gaWYgaXQgaXMgaW5jbHVkZWQgaW4gVERYLXVz
YWJsZSBtZW1vcnkgcmVnaW9ucy4NCiAgICANCiAgICBUbyBzdGlsbCBtYWtlIHN1cmUgb2YgdGhh
dCwgZXhwbGljaXRseSBjaGVjayBhbGwgVERYLXVzYWJsZSBtZW1vcnkNCiAgICByZWdpb25zIGFy
ZSB0cnVseSBURFggY29udmVydGlibGUgYWdhaW5zdCBDTVJzIHdoZW4gc3Rhc2hpbmcgdGhlbSBm
cm9tDQogICAgdGhlIG1lbWJsb2Nrcy4NCiAgICANCiAgICBBbHNvIHByaW50IGFuIGVycm9yIG1l
c3NhZ2UgaWYgYW55IHJlZ2lvbiBpcyBub24tQ01SIHNvIHRoZSB1c2VycyBjYW4NCiAgICBlYXNp
bHkga25vdyB0aGUgcmVhc29uIG9mIHRoZSBmYWlsdXJlLiAgVGhpcyBpcyBuaWNlIHRvIGhhdmUg
YW55d2F5DQogICAgYmVjYXVzZSBhIGNsZWFyIG1lc3NhZ2UgaXMgYmV0dGVyIHRoYW4gaGF2aW5n
IHRvIGRlY2lwaGVyIHRoZSBlcnJvciBjb2RlDQogICAgb2YgdGhlIFRESC5TWVMuQ09ORklHLg0K
IA0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyBiL2FyY2gveDg2L3Zp
cnQvdm14L3RkeC90ZHguYw0KaW5kZXggZTRhN2UwZTE3ODEyLi5kMjViZGY4Y2ExMzYgMTAwNjQ0
DQotLS0gYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCisrKyBiL2FyY2gveDg2L3ZpcnQv
dm14L3RkeC90ZHguYw0KQEAgLTE3Niw2ICsxNzYsMjMgQEAgaW50IHRkeF9jcHVfZW5hYmxlKHZv
aWQpDQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKHRkeF9jcHVfZW5hYmxlKTsNCiANCisvKiBDaGVj
ayB3aGV0aGVyIGEgZ2l2ZW4gbWVtb3J5IHJlZ2lvbiBpcyBhIHN1Yi1yZWdpb24gb2YgYW55IENN
Ui4gKi8NCitzdGF0aWMgYm9vbCBpc19jbXJfc3ViX3JlZ2lvbih1bnNpZ25lZCBsb25nIHN0YXJ0
X3BmbiwgdW5zaWduZWQgbG9uZyBlbmRfcGZuLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IHRkeF9zeXNfaW5mb19jbXIgKnN5c2luZm9fY21yKQ0KK3sNCisgICAgICAgaW50
IGk7DQorDQorICAgICAgIGZvciAoaSA9IDA7IGkgPCBzeXNpbmZvX2Ntci0+bnVtX2NtcnM7IGkr
Kykgew0KKyAgICAgICAgICAgICAgIHU2NCBjbXJfYmFzZV9wZm4gPSBzeXNpbmZvX2Ntci0+Y21y
X2Jhc2VbaV0gPj4gUEFHRV9TSElGVDsNCisgICAgICAgICAgICAgICB1NjQgY21yX25wYWdlcyA9
IHN5c2luZm9fY21yLT5jbXJfc2l6ZVtpXSA+PiBQQUdFX1NISUZUOw0KKw0KKyAgICAgICAgICAg
ICAgIGlmIChzdGFydF9wZm4gPj0gY21yX2Jhc2VfcGZuICYmDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGVuZF9wZm4gPD0gKGNtcl9iYXNlX3BmbiArIGNtcl9ucGFnZXMpKQ0KKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQorICAgICAgIH0NCisNCisgICAgICAg
cmV0dXJuIGZhbHNlOw0KK30NCiAvKg0KICAqIEFkZCBhIG1lbW9yeSByZWdpb24gYXMgYSBURFgg
bWVtb3J5IGJsb2NrLiAgVGhlIGNhbGxlciBtdXN0IG1ha2Ugc3VyZQ0KICAqIGFsbCBtZW1vcnkg
cmVnaW9ucyBhcmUgYWRkZWQgaW4gYWRkcmVzcyBhc2NlbmRpbmcgb3JkZXIgYW5kIGRvbid0DQpA
QCAtMjE4LDcgKzIzNSw4IEBAIHN0YXRpYyB2b2lkIGZyZWVfdGR4X21lbWxpc3Qoc3RydWN0IGxp
c3RfaGVhZCAqdG1iX2xpc3QpDQogICogcmFuZ2VzIG9mZiBpbiBhIHNlY29uZGFyeSBzdHJ1Y3R1
cmUgYmVjYXVzZSBtZW1ibG9jayBpcyBtb2RpZmllZA0KICAqIGluIG1lbW9yeSBob3RwbHVnIHdo
aWxlIFREWCBtZW1vcnkgcmVnaW9ucyBhcmUgZml4ZWQuDQogICovDQotc3RhdGljIGludCBidWls
ZF90ZHhfbWVtbGlzdChzdHJ1Y3QgbGlzdF9oZWFkICp0bWJfbGlzdCkNCitzdGF0aWMgaW50IGJ1
aWxkX3RkeF9tZW1saXN0KHN0cnVjdCBsaXN0X2hlYWQgKnRtYl9saXN0LA0KKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgdGR4X3N5c19pbmZvX2NtciAqc3lzaW5mb19jbXIpDQog
ew0KICAgICAgICB1bnNpZ25lZCBsb25nIHN0YXJ0X3BmbiwgZW5kX3BmbjsNCiAgICAgICAgaW50
IGksIG5pZCwgcmV0Ow0KQEAgLTIzNCw2ICsyNTIsMjcgQEAgc3RhdGljIGludCBidWlsZF90ZHhf
bWVtbGlzdChzdHJ1Y3QgbGlzdF9oZWFkICp0bWJfbGlzdCkNCiAgICAgICAgICAgICAgICBpZiAo
c3RhcnRfcGZuID49IGVuZF9wZm4pDQogICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsN
CiANCisgICAgICAgICAgICAgICAvKg0KKyAgICAgICAgICAgICAgICAqIE1ha2Ugc3VyZSB0aGUg
dG8tYmUtYWRkZWQgbWVtb3J5IHJlZ2lvbiBpcyB0cnVseSBURFgNCisgICAgICAgICAgICAgICAg
KiBjb252ZXJ0aWJsZSBtZW1vcnkuDQorICAgICAgICAgICAgICAgICoNCisgICAgICAgICAgICAg
ICAgKiBOb3RlOg0KKyAgICAgICAgICAgICAgICAqDQorICAgICAgICAgICAgICAgICogVGhlIHRv
LWJlLWFkZGVkIG1lbW9yeSByZWdpb24gaGVyZSBkb2Vzbid0IGNyb3NzIE5VTUENCisgICAgICAg
ICAgICAgICAgKiBub2Rlcy4gIFRoZSBjaGVjayBoZXJlIGFzc3VtZXMgdGhlIG1lbW9yeSByZWdp
b24gZG9lcw0KKyAgICAgICAgICAgICAgICAqIG5vdCBjcm9zcyBhbnkgYWRqYWNlbnQgQ01ScyB3
aGljaCBhcmUgY29udGlndW91cw0KKyAgICAgICAgICAgICAgICAqIChpLmUuLCB0aGUgZW5kIG9m
IHRoZSBmaXJzdCBDTVIgaXMgdGhlIHN0YXJ0IG9mIHRoZQ0KKyAgICAgICAgICAgICAgICAqIG5l
eHQpIF9BTkRfIGFyZSBpbiB0aGUgc2FtZSBOVU1BIG5vZGUuICBBIHNhbmUgQklPUw0KKyAgICAg
ICAgICAgICAgICAqIHNob3VsZCBuZXZlciByZXBvcnQgbWVtb3J5IHJlZ2lvbnMgYW5kIENNUnMg
aW4gc3VjaA0KKyAgICAgICAgICAgICAgICAqIHdheS4NCisgICAgICAgICAgICAgICAgKi8NCisg
ICAgICAgICAgICAgICBpZiAoIWlzX2Ntcl9zdWJfcmVnaW9uKHN0YXJ0X3BmbiwgZW5kX3Bmbiwg
c3lzaW5mb19jbXIpKSB7DQorICAgICAgICAgICAgICAgICAgICAgICBwcl9lcnIoIm1lbW9yeSBy
ZWdpb24gWzB4JWx4LCAweCVseCkgaXMgbm90IFREWA0KY29udmVydGlibGUgbWVtb3J5LlxuIiwN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQSFlTX1BGTihzdGFydF9w
Zm4pLCBQSFlTX1BGTihlbmRfcGZuKSk7DQorICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAt
RUlOVkFMOw0KKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnI7DQorICAgICAgICAgICAg
ICAgfQ0KKw0KICAgICAgICAgICAgICAgIC8qDQogICAgICAgICAgICAgICAgICogQWRkIHRoZSBt
ZW1vcnkgcmVnaW9ucyBhcyBURFggbWVtb3J5LiAgVGhlIHJlZ2lvbnMgaW4NCiAgICAgICAgICAg
ICAgICAgKiBtZW1ibG9jayBoYXMgYWxyZWFkeSBndWFyYW50ZWVkIHRoZXkgYXJlIGluIGFkZHJl
c3MNCkBAIC05NDAsNiArOTc5LDE1IEBAIHN0YXRpYyBpbnQgY29uc3RydWN0X3RkbXJzKHN0cnVj
dCBsaXN0X2hlYWQgKnRtYl9saXN0LA0KICAgICAgICBpZiAocmV0KQ0KICAgICAgICAgICAgICAg
IHJldHVybiByZXQ7DQogDQorICAgICAgIC8qDQorICAgICAgICAqIFVzZSBDTVJzIGluc3RlYWQg
b2YgdGhlIFREWCBtZW1vcnkgYmxvY2tzIHRvIHBvcHVsYXRlIHRoZQ0KKyAgICAgICAgKiByZXNl
cnZlZCBhcmVhcyB0byByZWR1Y2UgY29uc3VtcHRpb24gb2YgcmVzZXJ2ZWQgYXJlYXMgZm9yDQor
ICAgICAgICAqIGVhY2ggVERNUi4gIE9uIHNvbWUgbGFyZ2Ugc3lzdGVtcyAoZS5nLiwgYSBtYWNo
aW5lIHdpdGggNCBvcg0KKyAgICAgICAgKiBtb3JlIHNvY2tldHMpLCB0aGUgQklPUyBtYXkgcmVw
b3J0IG1hbnkgdXNhYmxlIG1lbW9yeSByZWdpb25zDQorICAgICAgICAqIGluIHRoZSBmaXJzdCAx
R0IgaW4gZTgyMC4gIFRoaXMgbWF5IHJlc3VsdCBpbiByZXNlcnZlZCBhcmVhcw0KKyAgICAgICAg
KiBvZiB0aGUgZmlyc3QgVERNUiBiZWluZyBleGhhdXN0ZWQgaWYgVERYIG1lbW9yeSBibG9ja3Mg
YXJlDQorICAgICAgICAqIHVzZWQgdG8gZmlsbCB1cCByZXNlcnZlZCBhcmVhcy4NCisgICAgICAg
ICovDQogICAgICAgIHJldCA9IHRkbXJzX3BvcHVsYXRlX3JzdmRfYXJlYXNfYWxsKHRkbXJfbGlz
dCwgc3lzaW5mb19jbXIsDQogICAgICAgICAgICAgICAgICAgICAgICBzeXNpbmZvX3RkbXItPm1h
eF9yZXNlcnZlZF9wZXJfdGRtcik7DQogICAgICAgIGlmIChyZXQpDQpAQCAtMTEyNCw3ICsxMTcy
LDcgQEAgc3RhdGljIGludCBpbml0X3RkeF9tb2R1bGUodm9pZCkNCiAgICAgICAgICovDQogICAg
ICAgIGdldF9vbmxpbmVfbWVtcygpOw0KIA0KLSAgICAgICByZXQgPSBidWlsZF90ZHhfbWVtbGlz
dCgmdGR4X21lbWxpc3QpOw0KKyAgICAgICByZXQgPSBidWlsZF90ZHhfbWVtbGlzdCgmdGR4X21l
bWxpc3QsICZzeXNpbmZvLmNtcik7DQogICAgICAgIGlmIChyZXQpDQogICAgICAgICAgICAgICAg
Z290byBvdXRfcHV0X3RkeG1lbTsNCg0KDQogDQo=

