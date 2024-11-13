Return-Path: <linux-kernel+bounces-408395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E999C7E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603D9B231E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEA118C025;
	Wed, 13 Nov 2024 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TeGMBXJk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F218A6CC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731536743; cv=fail; b=Jpw60kvrBpYUX6518Y3bx3FGR9G8quMFfBp1/dUx3PZqs4RQMO3EdnhqksxLlZQueIQ2ZjPm2gvRHbBPa1wRsL3MYCdgcRK5D8v9hNOSd7VzbcnC9OkmRQo8V0sW/fEOglR69o3Dhz/FBKoVTteAswLzpjGSfgcMqP3rPGPDDbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731536743; c=relaxed/simple;
	bh=9vbG+mbYrc9xMSp587jSNWvsdLC0MyQ90dGXoNqG4VY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K1SMWDQKeUVZIiN+FX6wuMrm7DEfSYDTXb71kC588BS/vpVggvlh4RyKJWi+CKXRF7pHLt43gWCDKhx0QWHJMf2keWU+vvnwYy6rI90Q4Fs2yHMtODs1PBckMyGKpCU/Niz8IGwwCKJ1pKrEoXrvw5pg4KH9Mn7rHRMEIss24Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TeGMBXJk; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731536741; x=1763072741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9vbG+mbYrc9xMSp587jSNWvsdLC0MyQ90dGXoNqG4VY=;
  b=TeGMBXJkR/otEEFsbaJ1AA+Qh6Hh2D3ONbJ7+Cu8O2zTYBn3WuMjoIBW
   ylK8x4lvBY81+ipLMRdWhUCW0OZFL9INYEdaWViAL19VyIMn39kF003iu
   53dJIhj6jPjt/qggi+sVJguk+uvgwp1ieRWKlQzO/5docX1Y0ToYRg8ZG
   lxKi5wHq+LDPDFLOGaRdOabkGmsMOr/F2JjLcGk0uG59wjiY+igPZrXIC
   Zq/A3FYfv8OAJEKRzZQsUUIRIzSsXUwQCkY6UteNZsnetWY6F4wHrpR3t
   xq9IvINRWS5f/OTjvZU3NHYwEltvwKqZgAPViWPi/9inM1QwFwnUjqUsP
   Q==;
X-CSE-ConnectionGUID: AYG0Ab+1R8KXPstDbgIdpw==
X-CSE-MsgGUID: Vxt5ywuYSuKh/kPZi5wR/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="19059001"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="19059001"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 14:25:40 -0800
X-CSE-ConnectionGUID: vnwGSNsoTQSU1bZnTvDHsg==
X-CSE-MsgGUID: pWQo9inRQtm8JI0R6VzYoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="111319935"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 14:25:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 14:25:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 14:25:40 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 14:25:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZam+cT0k4oR3024/3lS0VXg2/UezWVAkB3BWmdZvYmCjzjkIO2Mq/XAVB6CrsqrGwWG6R5k5VzApVXd+aSbDzjErar2E5mkeaLrUiRX43oopqfn2bS5wKwh/DBDAT177ygJWiKhE63rLEPlbM6ff26Q049+nHw8/H6JId3TAw0PsYFFfxZ76CUnFpRcqyYAY0USUW5xTdXX/GG1rLDB+HNmTR7wsrcnO0GH+E+lp8jCRczbYxd7y6ligcZgi/+rKc+d5Sfb5yvLQMl2JodPX2tkRgUrY1ecDhcgZr81O+/PKJLKN5M826hc8yLjHB9poyDCj8zdkKdbX11o+1p1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vbG+mbYrc9xMSp587jSNWvsdLC0MyQ90dGXoNqG4VY=;
 b=XGV3l0YCykzuhvV2qSRrYtgicuksPk0c82oq3qF8DNVZnmcdMP3xBw7Twl8TboEVMlJ/USHLciGhNrunQaSziz7Alou/nrBBMseubXjkQ4/LaAYdoTRZbbdwMuo3gr4IvfU0NIENN+jaK49uMl26NzZQUNo7IJjVbVAqZNk6rS892jkrhWHyZlti4dUoi6S/mioL+4jX0foU5jiYXIZIFEgY+Gy0iOBpYIv4FGsr6ZANd4BS0zXa0AaQhgmcuk81wGrc7fzHenwVbXA64Wae3j1sXt0x5eTHH0x4FTVGn2Mwkww6j/Dg0MutY4HLr7+b1PyhtZ4kPmjHxb6Jnh8wrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13)
 by IA0PR11MB8417.namprd11.prod.outlook.com (2603:10b6:208:48d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 22:25:37 +0000
Received: from LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::d099:e70d:142b:c07d]) by LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::d099:e70d:142b:c07d%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 22:25:37 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Williams, Dan J" <dan.j.williams@intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH v8 0/9] TDX host: metadata reading tweaks and bug fixes
Thread-Topic: [PATCH v8 0/9] TDX host: metadata reading tweaks and bug fixes
Thread-Index: AQHbNcM89kfZg0E46kyQYYoXNl99bbK1ymUA
Date: Wed, 13 Nov 2024 22:25:37 +0000
Message-ID: <1e00cac3164ea0f20ba2cd68e3f4790c6f1da091.camel@intel.com>
References: <cover.1731498635.git.kai.huang@intel.com>
In-Reply-To: <cover.1731498635.git.kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB5976:EE_|IA0PR11MB8417:EE_
x-ms-office365-filtering-correlation-id: abeeaf29-3a65-4a1c-9bda-08dd043218ff
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L2lpS3hycGQ3dk9vdzl3Y2h1WitWa3c4emhsNk9QYmQ1LzZTVkJaOHR5cUNa?=
 =?utf-8?B?dXhPSFNGMFVqRkliVjdTY1FSVCswSjk4OGFZWU5GdWZpZ2NrTmdBSklTL2RJ?=
 =?utf-8?B?dVB5OHQrd0RrQklQZkpSSW12cU91RFJiQWk4YUhUMU1VQUZncjBvOU5LL2Nx?=
 =?utf-8?B?Q0ZHblE5ZjVNNyt0OVZEOTBodFlaZFZXRnZDeHNNVGk1T3U0a0pDeUZmQUhE?=
 =?utf-8?B?aFRVWFVvNVhYNEI1bHI4U3I3aUhabzFKWThEU3BmK0NrclJHRUJFN0lrRVJS?=
 =?utf-8?B?YlUrQ1FicXErK3I4MWl4aFVSQlYzc3ZCZ1hLTmloV20yVm4xbXQwQUFpSXdq?=
 =?utf-8?B?cUpBd3UvRy9oUHZqb3F6QTBobzBQMkwyM3cxdE1hZUU0V0tnRjBLUjNiUHpO?=
 =?utf-8?B?eTJKT2NzYTdFWm0yejcrSGo5bGluVU9JL0ZkZnBZYm1RV0pGM1BjZHRnSEdE?=
 =?utf-8?B?UlhidnpRcnE3S0llZDFYWFYza0c2d1FnRjZhZWg5am9Sa2k2TU9BV29CeVEw?=
 =?utf-8?B?OSs2dmRvYXgwVERDaTA2dnVHNkZicnFLaitxNkp0bWxHay9FeDN4bzRTNVd4?=
 =?utf-8?B?dUNEVWs1YjBVUUtDNy80czJ0cnVqMFV4dXFad3dXeDl0bGxqMFFhNG1UVzVX?=
 =?utf-8?B?MWhDWGlMa0owS0pPNkVQdW03S040bXlaRTh3U1hyZzEvcmx6WW13SEY2bUYw?=
 =?utf-8?B?ZUpDSDEwUzhjc0ZlaFRNa3pkNElwQmRXZU5EdHdrcmhRdXdCeHFRWDFUaVZj?=
 =?utf-8?B?V2VsVFZnNXcrQmxyT0kyOHd5VW5Jbi9nSmRMY1pNcmtjZHpIeG5xQ0lGZGZk?=
 =?utf-8?B?R3VXaTIwNHBqY1hyODB1cW16WHVlckdnY1RJdUkzZEtCbXJ1c2VGaExGNExK?=
 =?utf-8?B?OVRwQTZRdURydU90WnkvYmUzdGtpR2xscCs2Ky9rbFU3Y0tFaVYvMU1RdnI5?=
 =?utf-8?B?OUlxUkFFQlU3YTdDRDFaUHZqYk1uZnVHbGRYalEvUWpJb1ZZWlhGUHZZQi9z?=
 =?utf-8?B?a0hQYVJWdzV4YTNVZFhuem9aT2t6a0U3QnViOTJIODQ0KzZJdG1aclFDTXVY?=
 =?utf-8?B?QW5WV1N0UWhvWlBDckhQNHJzNjdJTHdSSGxpaTZXTEVLMTIxRXVhN1I4a05S?=
 =?utf-8?B?UTB4MUx5ZWF4SEVUa2dRelRQQjVYUTI4UEJuMzFzekdZZ01uSWdNVktlSU5n?=
 =?utf-8?B?dTRvTDVEcHVVRXJPTEhUZDFtV0pCWVd6MkFBVTYwdTB5UkRHbUZLWGx2Q3By?=
 =?utf-8?B?eTBsbFFLRFZwOWRiSWlaMzE0NnJWWlBMcTVUVm9BNEVOZGZCdVFlZWtXckpL?=
 =?utf-8?B?TkJFbHZTaElMZFdWMjBuVmw0UkhMcFF3bHBVelJWUGpoU1c3bEs5dXJOZk9p?=
 =?utf-8?B?RSt0OUZaaUEybmlTTUFCZktEampBcHpwb05RZkJQV0gva3dFVXVqTnk1N1Jn?=
 =?utf-8?B?UDJxNHc1Z2tDbmk5N0R5Z0lJYXQwZ1k3eTNBbzBRdW5UU1B1UFlwVHRad21j?=
 =?utf-8?B?NVgxcSthbzNXTkJvQ1F3WDJDRkRMOCt5VzhtaTdRa0dxc2FlcXhsR1h5em9B?=
 =?utf-8?B?dmpscCtJbzFTNXk5S2QzSy9hU0tFZnBaRFBNcGRQSDd0cDBPN3Z0ZVU5OHUr?=
 =?utf-8?B?Uk1ZQnV2eGwvZXhsWkZZZkhXM3dPNFkvVDNNanJzRStTamtBMWY0VkpPeFdE?=
 =?utf-8?B?SzNraGJEYkNSUXBuOVRCbjZTVUpBclg5bnA2YUZGS1dJcGhheEMwdnoxZHRu?=
 =?utf-8?B?Q1c1TW1mZlpudS9IVFIrN0ZJc0cxZTN6Smh3N1YwSXQ5di9pYzYraTIzaG4y?=
 =?utf-8?B?MlI1bzQwb0tlY0dCWjY1VWVQS25iZWR1ODIrcTBna3MrWEJkTjlaTzZVOTNG?=
 =?utf-8?Q?jPEzE7qvTGlhx?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB5976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU5BWGlSeW9wdWllM0tDZlZPK0tmVGhBLytVY2h2KzhIL0p5d01QRGJVTm1p?=
 =?utf-8?B?bWhweE02VzREWkZDdHNNZVBlVU9JZTBESzRsaHRObFdROGxhWFFJUCs1SUtH?=
 =?utf-8?B?VFJzSGY4UGh5OS9kVk12a1NuclRxUUdXKzVmNVBpQjFnY2dwYm1VVFRQV0Rz?=
 =?utf-8?B?bnNOdU1wVjdlS21IaUwzK2xKdlMwbnFsWVFBRFdZWmd2N0ZPb2hSYkNIQks3?=
 =?utf-8?B?Zll4bmxUN0xTUDc2Z0FXYnpEWWRYdnM2c1Nvc2tMenZ3MzE2RjZURDFuME5V?=
 =?utf-8?B?TjZTdFVSRkczeWRReGQ5NXNMSjUxMlp0QnVrL05GOGRFL0Nwb24xRVI4dGRE?=
 =?utf-8?B?Yyt2Q1N5Mkp2Ymp6TlRYTGFaWDY1MUxSaVFjWkJHWFN4c1pGMzRhMysybmRL?=
 =?utf-8?B?UG1GRUVTQkFHa2d1dUw1WU41WWhmTjg3VHBaRU4zSzh2cDdyditDS2I0QnFQ?=
 =?utf-8?B?eFRFRHI5YkJUTmtoYk50cE1Bc3VVdkw2K283elk1TUVlaGZ3aU9lNmpkaXd3?=
 =?utf-8?B?S2RQK210QXJCT0FOREVkOVVZMlZoQVNPakNPLzhEcDFKcU81SnFtSHJiU0hx?=
 =?utf-8?B?SXBtdit0aVRLRy9MTDBUU2xsWDFnNWVYeWczUEFZOEd2RWFsRTZRcEZoWUJ2?=
 =?utf-8?B?RUh0RHhDWWZETElZb0JNak5yV0ZxelZucXVvTlpJdUlpTnJzd3hrbDNrVDZM?=
 =?utf-8?B?Z1ZSaEs1RmFHOWtUb25OaWxFS2ZsWVAzeUszWHV2ekVIMGpSaDV4YjdPa1ZS?=
 =?utf-8?B?aUhYQmthRTBkN3RvdTI5dnROSW93aE4zVFBIb2Z0TkZpTytsMkVVbnZMWkNw?=
 =?utf-8?B?NGg5WmFWRjkwSUhPUk9jR080V3Y3ODZ2ci96cVhHaXpaaHBGaVR4VW93NkNR?=
 =?utf-8?B?Y0V1SThJSlZIZ3NpdDdvaWcrMUV1K0J6Z2x1QWducTZKNGV5cFhLUFFuUWNy?=
 =?utf-8?B?aFRDU3NCYkdHdGlmOVc4REh3QVBkY2J4eEE4U296MnRKbWZ5OFBDL1hsSGsw?=
 =?utf-8?B?aXhnNndRck80QnVIYzYvdUJpLzRxdXJGdDYzcWV5S25WdW1QS2RzVmNnOEhE?=
 =?utf-8?B?UmVlZyt6MUpjcnRLRDBEOUVFYTIvLzdxVTVhY2N6R2ZYNEJUNVhCbDFTc2tX?=
 =?utf-8?B?M0VGZm4vWWZnQ1Jvc0dFZUhZbjNKTGpxbmVPQ3hQb2hoS3J1K0hieUlUTEo5?=
 =?utf-8?B?RldIeks1MUVLY0JSTTBIQ3QzckRraWFMc0VQbk1hQksyOFQzWGk1MXpXeTEz?=
 =?utf-8?B?alNsU3hRM3hMZlBNODJvUW9wRVNGK0lWRW9yN1ZsWHlXaUJhQWJZQ2F3VTU3?=
 =?utf-8?B?THdDQmlDcTZyS0VNdzk0blh5N05STVFsT3A4UyticEVvVkdRYkNZaE5QcnJ3?=
 =?utf-8?B?TzhuWFFRV2ozK3dacWJhT25yWnZLckNEMjBEQzN3aWFNREIwQlY4VVFSTE8r?=
 =?utf-8?B?dytpb1JzbDBRZ2N4UnM3K0M3MWVJdnR2QTlCSjRqVis4emFNYzNob3BweTBl?=
 =?utf-8?B?eSsreDJtcGo4a1VmN1dBdG5VVEFZWkJyMHI4Y0t4RU1iNjNCUUxsaHdQZE9Q?=
 =?utf-8?B?b3BQc2NKWWNGZVNQZE10OHZCb3paSDdydzJvM3F4ZWhqMExCRk9qOENyUzlh?=
 =?utf-8?B?VDMvZ21ObEhkeHNYa2FDdTFvREpqQ2lRakIwS2c5UGcxSlpGRGFBZHZ1V3Ur?=
 =?utf-8?B?SFM0NWttWGtBNnRMdVJPc1QxVUJBWEV1WjFtMmphYWxBV1BxNVhMUEtQM044?=
 =?utf-8?B?enQ2cFcwMXZxWEJGS09iUlpMTUhCdWMySUt5ZTlLUWFKaXEyMkVPeVFMejdx?=
 =?utf-8?B?M01IeVNoSkdzM05JN2ExZUUxR2ZpRXA2NkpuTG0rT1FCWGl1NW9wN09palMy?=
 =?utf-8?B?djRzM25ySkpmYzB6VFNWcHkrQzJMcUdOZitFWmJnZ21oUE9jRUpId3lqb0hS?=
 =?utf-8?B?YUlHcytJLzE2VVJvNytWU2tzMzJraVNPb3ZOZWEySWNoVGo5RGJYdmdsYmVL?=
 =?utf-8?B?U0FTaitmMU1mYmlBMVM0OTBkdFgzZmNiWTNvMWhScXBzRHhrRzNDSkNwenQ4?=
 =?utf-8?B?ZzRrL0ZDZ0F0Q3NKREVoZC9waWdFWnBjRkN6UWRNd3phSW1COHMrWnlMKzZm?=
 =?utf-8?B?OXdOT084Sm5DLzUrWmIrSEhyWkxCdHFHS1AvdmVVb2M2bW5zc2RWTlBDYnRL?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6369D847116BA943AB876232D9B1F7C7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB5976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abeeaf29-3a65-4a1c-9bda-08dd043218ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 22:25:37.0207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uYsXUl9Ern1EmiKvRtw71AXi3B8ykVRRVtHM5NCt2RTzyk+eHsxEaXKG0VcAlw8zmyoIPIRMcQEcRQLVzguYIQzKiLxNTr8/9UeKtt7hF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8417
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTExLTE0IGF0IDAwOjU3ICsxMzAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+IFRo
aXMgc2VyaWVzIHJlcGxhY2VzIHRoZSBleGlzdGluZyBURFggbW9kdWxlIG1ldGFkYXRhIHJlYWRp
bmcgY29kZSB3aXRoDQo+IGEgbmV3IGF1dG8tZ2VuZXJhdGVkIGdsb2JhbCBtZXRhZGF0YSBpbmZy
YXN0cnVjdHVyZSB0bzoNCj4gDQo+IDEpIGFkZHJlc3MgdHdvIGlzc3VlcyBpbiB0aGUgY3VycmVu
dCBURFggbW9kdWxlIGluaXRpYWxpemF0aW9uIGNvZGUsIGFuZA0KPiAyKSBoYXZlIGFuIGV4dGVu
ZGFibGUgaW5mcmFzdHJ1Y3R1cmUgd2hpY2ggaXMgc3VwZXIgZWFzeSB0byByZWFkIG1vcmUNCj4g
wqDCoCBtZXRhZGF0YSBhbmQgc2hhcmUgd2l0aCBLVk0gZm9yIEtWTSBURFggc3VwcG9ydCAoYW5k
IG90aGVyIGtlcm5lbA0KPiDCoMKgIGNvbXBvbmVudHMgZm9yIFREWCBDb25uZWN0IGluIHRoZSBm
dXR1cmUpLg0KPiANCj4gQW5kIHRoZSByZWFzb24gdGhhdCB3ZSBuZWVkIGEgbmV3IGdsb2JhbCBt
ZXRhZGF0YSBpbmZyYXN0cnVjdHVyZSBpcyB0aGUNCj4gY3VycmVudCBvbmUgY2FuIG9ubHkgcmVh
ZCBURE1SIHJlbGF0ZWQgbWV0YWRhdGEgZmllbGRzIGFuZCBpdCBpcyBub3QNCj4gZXh0ZW5kYWJs
ZSB0byByZWFkIG1vcmUgbWV0YWRhdGEgZmllbGRzLCB3aGljaCBpcyByZXF1aXJlZCB0byBhZGRy
ZXNzDQo+IGJvdGggMSkgYW5kIDIpIGFib3ZlLg0KPiANCj4gU3BlY2lmaWNhbGx5LCBiZWxvdyB0
d28gaXNzdWVzIGluIHRoZSBjdXJyZW50IG1vZHVsZSBpbml0aWFsaXphdGlvbiBjb2RlDQo+IG5l
ZWQgdG8gYmUgYWRkcmVzc2VkOg0KPiANCj4gMSkgTW9kdWxlIGluaXRpYWxpemF0aW9uIG1heSBm
YWlsIG9uIHNvbWUgbGFyZ2Ugc3lzdGVtcyAoZS5nLiwgd2l0aCA0IG9yDQo+IMKgwqAgbW9yZSBz
b2NrZXRzKSBbMV0uDQoNCkVhcmxpZXIgRGF2ZSBhc2tlZDoNCiJXaGF0IGlzIHlvdXIgZ29hbD8g
IFdoYXQgaXMgdGhlIGJhcmUgbWluaW11bSBhbW91bnQgb2YgY29kZSB0byBnZXQgdGhlcmU/Ig0K
DQpJIHRoaW5rIHRoZSBnb2FsIHJpZ2h0IG5vdyBpcyB0byBnZXQgdGhlIGNyaXRpY2FsIGRlcGVu
ZGVuY2llcyBmb3IgS1ZNIGJhc2ljIFREDQpib290IHN1cHBvcnQgdXBzdHJlYW0uIEJhc2ljYWxs
eSB0aGUgYmFyZSBtaW5pbXVtIHRvIGRvIHNvbWV0aGluZyB1c2VmdWwuIFNpbmNlDQp1bmxpa2Ug
dGhlIHJlc3Qgb2YgdGhlIHBlbmRpbmcgcHJlLXJlcXMsIHRoaXMgc2VyaWVzIHdpbGwgbmVlZCB0
byBnbyB0aHJvdWdoDQpMaW51cycgdHJlZSBhbmQgYmFjayBkb3duIHRvIEtWTSdzIGJlZm9yZSB3
ZSBjYW4gZHJvcCB0aGUga3ZtLWNvY28tcXVldWUgY29weSwNCnRoaXMgcGFydCBpcyBhIGxpdHRs
ZSBtb3JlIHVyZ2VudC4gQXQgbGVhc3QgZnJvbSBhbiBvcmRlciBvZiBvcGVyYXRpb25zDQpwZXJz
cGVjdGl2ZS4NCg0KSSBsb29rZWQgYXQgdGhpcyBidWcsIGFuZCBpdCBzZWVtcyBsaWtlIGlmIHRo
aXMgaXMgbm90IGZpeGVkIHRoZW4gVERYIHdpbGwgbm90DQpiZSB1c2FibGUgaW4gc29tZSBURFgg
c3VwcG9ydGluZyBwbGF0Zm9ybXMuIElzIHRoYXQgcmlnaHQ/IFNvIHRoZSBjb25zZXF1ZW5jZSBv
Zg0Kbm90IGhhdmluZyB0aGlzIHdvdWxkIGJlIHRoYXQgd2hlbiBLVk0gc3VwcG9ydCBsYW5kcyBu
b3QgYWxsIFREWCBjYXBhYmxlIEhXIGNhbg0KdXNlIFREWC4gQnV0IGl0IHdvbid0IG1ha2UgdGhl
IFREWCBLVk0gc3VwcG9ydCB0b3RhbGx5IHVzZWxlc3MuIEFuZCBvdGhlcndpc2UNCnRoZSBlcnJv
ciBjb25kaXRpb24gaXMgaGFuZGxlZCBjbGVhbmx5IGluIHRoZSB1cHN0cmVhbSBjb2RlLg0KDQpT
byBJIHRoaW5rIGl0IGlzIG5vdCBwYXJ0IG9mIHRoZSAiYmFyZSBtaW5pbXVtIi4gSSBkb24ndCBo
YXZlIGFueSBvYmplY3Rpb24gd2l0aA0KaXQgZ29pbmcgdXBzdHJlYW0gd2l0aCByZXN0IG9mIHRo
aXMgc2VyaWVzIGlmIGl0IGRvZXNuJ3QgZGVsYXkgaXQuIEJ1dCBJIHdhbnQgdG8NCm1ha2Ugc3Vy
ZSB3ZSBkb24ndCBoYXZlIGFueSBtb3JlIGNvbmZ1c2lvbiB0aGF0IHdpbGwgY2F1c2UgZnVydGhl
ciBkZWxheXMuDQoNCj4gMikgU29tZSBvbGQgbW9kdWxlcyBjYW4gY2xvYmJlciBob3N0J3MgUkJQ
IHdoZW4gZXhpc3RpbmcgZnJvbSB0aGUgVERYDQo+IMKgwqAgZ3Vlc3QsIGFuZCBjdXJyZW50bHkg
dGhleSBjYW4gYmUgaW5pdGlhbGl6ZWQgc3VjY2Vzc2Z1bGx5LsKgIFdlIGRvbid0DQo+IMKgwqAg
d2FudCB0byB1c2Ugc3VjaCBtb2R1bGVzIHRodXMgd2Ugc2hvdWxkIGp1c3QgZmFpbCB0byBpbml0
aWFsaXplIHRoZW0NCj4gwqDCoCB0byBhdm9pZCBtZW1vcnkvY3B1IGN5Y2xlIGNvc3Qgb2YgaW5p
dGlhbGl6aW5nIFREWCBtb2R1bGUgWzJdLg0KDQpJIHRoaW5rIHdlIG5lZWQgUkJQIE1PRCBmb3Ig
YmFzaWMgc3VwcG9ydCwgb3IgaXQgbWF5IGNhdXNlIGNyYXNoZXMgd2hlbiB3ZSBzdGFydA0KYm9v
dGluZyBURHMuDQoNCkRvZXMgYWxsIHRoYXQgc2VlbSBjb3JyZWN0Pw0KDQo+IA0KPiBUaGUgZmly
c3QgNiBwYXRjaGVzIGludHJvZHVjZSB0aGUgbmV3IGF1dG8tZ2VuZXJhdGVkIGdsb2JhbCBtZXRh
ZGF0YQ0KPiBpbmZyYXN0cnVjdHVyZSAod2hpY2ggaXMgYXV0by1nZW5lcmF0ZWQgdXNpbmcgYSBz
Y3JpcHQgWzNdKSwgYW5kIHRoZQ0KPiByZXN0IHBhdGNoZXMgYWRkcmVzcyB0aGUgYWJvdmUgdHdv
IGlzc3Vlcy4NCg0K

