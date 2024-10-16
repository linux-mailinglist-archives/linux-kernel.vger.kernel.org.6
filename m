Return-Path: <linux-kernel+bounces-367146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1979499FF1C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A98284B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0187914D6EF;
	Wed, 16 Oct 2024 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0j7o4Ip"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B20F15C139;
	Wed, 16 Oct 2024 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729047989; cv=fail; b=Jk2RVHt0UwQnxpCCN+LHJU+WqShJ8iYa8PKHNHZNcVDBCRLG566Kl9Te6BjEDqByZJpKCvd3ugWt3VkMI3FiJmdJt14WFbuicPMoBLynKQLFUvxo066AqWis7KrKalwvw2//BhAvo22ZpJGHRjhDw6gLvO8DJWKd3V6THXOqiPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729047989; c=relaxed/simple;
	bh=JKUL3Lz/FTu12isru7QGl1I3iWiruuYl9A+K1lGKSJQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=juAczt2g4qh0YrdWTmSE9k90qX+2HNlJjqSMQ6zGIUV7EOuGDjEB/87u8BMC2/ibt2UrSMTSB1W4bxZMORLF+5EuUmHOmSJbEZQJ9sj6mBcnetvoj/EEFHdDkL5qwKP3SVg7O8sb8X46dcvMKT1hfQ36+II7Zr51z/IeXMHRwBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0j7o4Ip; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729047988; x=1760583988;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JKUL3Lz/FTu12isru7QGl1I3iWiruuYl9A+K1lGKSJQ=;
  b=e0j7o4IpGpWyCNfDrjKV7E5LO9+TVP5EvoB4anlXnNvau6RfNNiX6mTR
   UUBKYFdBg/oK7rDg9gxKyYsxW6t15wdKcDZRcC2crlgKe7EXLoROT6Ose
   eoVyqq22rxgn3Zabfi3D885+L9Oa1Xp1BuLrHGfT8X6ABPcsmhaOnEi+/
   ZOwnWVHkFn0ieqXopSJ5Q1kYmnN18NglWGuWNecA1mMlX6u6Fzvtm/KW7
   PwL793WLbcpPBltOu0LpFBQwyMB0VRMRQJuz0Irzleq6m7Br47H0mpSph
   nlhYW6/2IsGTQI3si5JqwkAOiqxBlmOfw70mu6mPjNdHxH/koJIZqLbWI
   A==;
X-CSE-ConnectionGUID: ONPVTOmgToymZVh+kay81w==
X-CSE-MsgGUID: 77gJkBK2THCQw4WXp5Hxpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45954031"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45954031"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:06:27 -0700
X-CSE-ConnectionGUID: JzB3D9nWS1itVrulegqchQ==
X-CSE-MsgGUID: YoHNrarDTyySzBYNV5Umbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="77979860"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:06:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:06:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:06:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:06:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:06:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcJhRtujmL5NZ41n9nOc8FNTfZWN2jeakfKpNdp8fwfy0ATVti9Vsdp/fhceYjy5Jueoj+S1T9J8ZQLjw4la993zdZ77MjucOLsbSbFmqEZkC8uOW5FsGSYoYo1qA32kTsHxDkyVSYg+Dtqhfo0UlxSzZtyEJhGBKD8UIWWwOsjV8gWxkjkUPdg6RaOkMMnVMwGRghavkD+GQScnN8Rjxs6uvx0d03GcdVt43BwfCGMVv4/HUss0KGPGtqBSQNar+CpzbAZpYQQxfZc6cntvGM885LlUVKgjljYAeYteO4v5AAJR/1OTW0NJKoEJaMLbymcOqYNNZ14faFEXF2aJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFdWwdH41rhFkH/JVDdCepV7dtZIo0yyb5PSjprY2Ds=;
 b=mOYaxLudrmlR3AQl6f54gOEJw+pK+S1+8ZWzEorOpwfuqI0zZSyD72vcuVFHMc2OGiowXI5Rgc9rkmC72w9Bm5YU5p6iC6Wtu1kS24SrZa01DZNOz1hvs6xqRqdjpjtLo8KikWQNOJw9VDeE7faejN8BLRlc2qtECtpIuBraYm/JIyBVvY5wBA2iqg6jFkggLYRoRY/BPLJbfoMeNapFKWZUsHLkqI+H5BqqVEPcXYIt4utP8tR9jf9D6O2rh9xE0x2hfQ70k//KCgt6QCOVP5CM7qMsRWFvLEbq2ixbYZSZ+ol2H2ZssUIpTZDiDWl2vwAXDlHrQnQrPSwWnHbPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 03:06:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:06:22 +0000
Message-ID: <e1cf0105-5357-41b8-bc7d-44399b346b37@intel.com>
Date: Tue, 15 Oct 2024 20:06:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/25] x86/resctrl: Add ABMC feature in the command
 line options
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <4ad8817bfdd13e048f93b5868e888a799f8c538d.1728495588.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <4ad8817bfdd13e048f93b5868e888a799f8c538d.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0327.namprd04.prod.outlook.com
 (2603:10b6:303:82::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5fac76-940c-426c-9df1-08dced8f8381
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmI0Q09oV3NyN29FaU9vcmRBenhjNkJKdHlUdmVJaWRYQjZrUVdsR2NseGRE?=
 =?utf-8?B?bHNLYkhxZ2tjSUdMQmxkcFpSZHlFNUN4NmV6L0tRemdjbzVqeUVZdTZuWjNB?=
 =?utf-8?B?Z2dsNmwzT0ZzSStHcXFMTWJBUzBwQ05tUXFIMVd5dC9WbTBLTkJrUEhYSzho?=
 =?utf-8?B?TnA4NXJydk95VjF1TythZWZ3aXNpSnQ4MWd6TTArMm9HWUJLZEM4b25sWXhu?=
 =?utf-8?B?bVd6SkhFdWdseDNvaWM3S0JBeVl1WTRhRkJlbUVTdXJERHpSNGNKY1prUFN2?=
 =?utf-8?B?cVJ0RUdTTDhFRXhyQzZnbU9WbGtzNzZnUDRKZmUwRnN2SUplZVVpVXNyRGI1?=
 =?utf-8?B?eXQvWnQ5NklvYXFCY0JmNWZPcnJuQW9xYnNySFBZVzZPVE5MZlFGc1Y3cmJ3?=
 =?utf-8?B?Z056SExDVDlOMWRvUU5MV2hTRDRadE5KVzQ2S3czMEl6TVZiMGZNbTZYVDAw?=
 =?utf-8?B?QnRWSkpTRUZWTU1qRUNFNXRhY2p0ak8rVFZ1K2xDeHYwTW5zWGtpVGpOd1Vq?=
 =?utf-8?B?MDcyUmM0bHFxcG9LYnBJRlo3dVRhSVRNQ2xWWVhmT1RMR1ZITXNJbEw1UXY1?=
 =?utf-8?B?b3QrY0d3WCtzSXA2R0VzUEFaS0hDRmpsQ0FSeVBjNzJ2OWZTOGM2NGpIQ3Av?=
 =?utf-8?B?MlpvZ0h5Rzd4Qi8yMk5LWUQ1RmtFQW8zS2NNNlA0bnJxR1UxcFpRb1IzSjhp?=
 =?utf-8?B?b3ZES3NQQUo0MVJXN0pyOVEwQmlWVDlIRHJzNEVkcVNRQmNnZGZDTFJNYXJO?=
 =?utf-8?B?eDdMQi9Qb2RqUk1uQ3phZHlWeVN2eWZSQXdmZG1yMHphNXVmWkFBVTRvbmpu?=
 =?utf-8?B?K1FGeEg3aStFbWYzdjRGYi91bkV5UHI4NExRT21GVFI1RzRYVnZuQ01WU2tj?=
 =?utf-8?B?MHREWWxHbFI5dXkxTUs4TFFzVENNM1RGQ29DTXVxajlwcWcyT0FkUmg5MUpm?=
 =?utf-8?B?cVJwTTZHSzVaTDJrWXZVSEtObmZBNWhOK1Q4UFA5ZWdoWTNiK1gyaEl3L2lU?=
 =?utf-8?B?RlRCL0dNeStsWmtvVXJmRGdXQXZFelJ3RTE1SFVVb0dHeEwzclEyb3phQnNV?=
 =?utf-8?B?d2FCL0tTcXBHOUJMcWFNT1MxTHZBb2lJc1g5eUEvbHFXb3JNSWQ4amxoRTY2?=
 =?utf-8?B?TnduUEJHcnRQU0VIYW93T0RpL1hSMEsyMkQ2dzJhb29qQ1dHejRQa0tYQVJK?=
 =?utf-8?B?Zk0xblJicmZSQ0xGNm05bE13eFMyNjFEL3FyYWsxSnVPa29IbG1TeERVVk5T?=
 =?utf-8?B?czZvTnptenZNOTgzZWtPazZpYkZ2MFh2Nzd5YWdJQnBwaWk0cUc5bFh3b0NM?=
 =?utf-8?B?ZC80cFRQOW9sNUhGa0U4b0lkT2EwYnJkU3Z3dEFSeElUOVVQZVJBcDFCQU1x?=
 =?utf-8?B?a3A0d25VVm1rRXNlbU1aSUlpU2hWWU1LUTJHQVg0U25sVzhxZCt1dGZhTjQr?=
 =?utf-8?B?dmxja3J4bXpRQjZyZ2daMWhZZlNaREVHMy90NWt6SldiUkFrUVRhSlZxazZ4?=
 =?utf-8?B?QVkvT1ZISG9DM2NWZ09objRFeXp2bzRaVjlQbVBOblRxWTRUeDJqbHJZeUVP?=
 =?utf-8?B?V2lRciswcVlWeVFZaFlLNDlyb0gza0pncEVFbjlvZGZsMnBXUFMvVWZhNHh0?=
 =?utf-8?B?Q3hTZzFwSysvT25rNkpRUzJXczd2T3JKRTI0Yml4NUFCVWF0bUE2NGNPbkQw?=
 =?utf-8?B?eEo2NUh6bnk5NFdadzBEOGgwY2tsM1VBb1dyZU1icU5MczNOcHArTTJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1VZcE5aN0Z1aitiMW5tVndoanFzaC94ekM3dkdYamxTODd0OVdHVzVZRFBu?=
 =?utf-8?B?ZFVKaGxLZ0Q3SEQyZUREN2JFZlYzbjdSOWg3QTJsMnBWVk5SbEIwcC9lZ2J0?=
 =?utf-8?B?c2crSkNEVUJSd3Z0a2tCNHl2OXlVN1lHcFpSNjRLbysyNW5yYzY5M0tYUnly?=
 =?utf-8?B?UkFyQUl6K1YzdElScTVxSXhqMU1Oc1A3VnhNS09WVlg2aG1aQ25jSFhuNzBC?=
 =?utf-8?B?RWE5SVBZaFBGMExHNGFwSVUyK0Rubyt2TjBMRkExVWhlQ0JtV2xLSnpvSkJ5?=
 =?utf-8?B?bXUrckpzT001eC9LVjVXU2ZPZ3pFaW9MTXpmTkV1L3ZMOGRkNlFJeG0zSVF3?=
 =?utf-8?B?VnIzeTUwbmQrR3JSOTVzVTdGamp2Q1pITXp1bUc2ZXEzYy8rY1pzRlRzd2JX?=
 =?utf-8?B?MW1SSzhTTWRCUlF2K1VqQWtQaVRhVkNoOU5pQzNIdXdwWlNwdFJGQ29vS1Js?=
 =?utf-8?B?aG1wazlWa3JsQ1Jpb285bjhIc1hUclRnSFJkMHNEQXFsL2pjeVpNWUdzMEtZ?=
 =?utf-8?B?K3NHQ0xCTDNweE9MNVdlL0drMTBMbTVjdUlTdEptSitDb3JrRmtpVFg2NlBY?=
 =?utf-8?B?M2FuVDVtYnNuaGQ4SXBoZitXbHVsTDVxOTlDNTVXci9ieGlrQ0E1QndKU1p4?=
 =?utf-8?B?MXhhc1ltS3UxTUNsVmh1azBQR1lVbVpZS0ZaUDQyREJqUG1JUnUvSERGUnpx?=
 =?utf-8?B?U0hUTzF0RDMxblp4UUxjZEFzdFZzYk9ROHQ1NWZpc2J3Y2wxVHB0Z2R5akJ6?=
 =?utf-8?B?OWZTQkY0Qjk1MTlUTFdTV3B4Yzk0eFFYV3AzVzNCNTBvRWVQYjlhclM3UzBt?=
 =?utf-8?B?YXN1NlZ1R0dWSjYvWFNmYVg0eDM0T3RMVUxKdDhKbk1CeGY2RC8yTjV5N3Vj?=
 =?utf-8?B?RG1RNFNNTWp3RHZVTmlBdDJaVENJT1JmRXFnZzYrSk9qdnJTSTN3T2Rja1dR?=
 =?utf-8?B?bEdzOEJvWDlQV3pOZTlrVk9GSzAvYnBqbHVjcGxORE16R1V3bHNVbUYrQ21R?=
 =?utf-8?B?djlRTS9BWVI4TG5mNWhCZE9lVk0raDQwSEhRN1lFM0IrcGVydGErZ2pxZCto?=
 =?utf-8?B?Z2ZmakYrK2VrWkhENmFqTHpHV2FGMEU1enJQK0h3cWZ6b0l3VTBkSjZMRld0?=
 =?utf-8?B?c1JoaWpJT1VNL29DRW5TVVJidmVOVzZFUVNOS2gzVGttTTBLNm40cUowdmQ4?=
 =?utf-8?B?bGdwTTUwdkdOM3p0NWttWmtPR1U3elRLdU1xVGY4RDl6ZnZuNVhSNkY0ejFw?=
 =?utf-8?B?ZWNCcWdKY0JORWozVHRSbms5c1QrSmdzdHVHUHAzY0dBQlBWY2pDYko0SjNu?=
 =?utf-8?B?N3U5NU9Ia1hhcnRtQm1qVFFHaDZ6RmZPYnIwQUhHZjZHWnFIMnExYzZvQ25X?=
 =?utf-8?B?eWNGN0N5Ym5EZ1BRdXNUNXhNYWdOSmE3azlPenMrNVdNOWM3Smw5eXdpZU05?=
 =?utf-8?B?NUJtWWpBbld4SFoyQWJiZEs3dHRHeGwrWk05L09rVCtjeHNCd1FoOWVYY3V0?=
 =?utf-8?B?Zmd1b25HTDk4bEtrQXVESlVJRjZuZGdFQ0Z3UmhPZFc5ajgvcnljajRxNENK?=
 =?utf-8?B?YnQvWnpHUWdmMEhBdjh5WXhobzJHVS9kSGtsSk9NRHBFdytUSzl5TjVXV2do?=
 =?utf-8?B?a3k4aVI3UEV2Z2tTWlVKYlZIV29jaEQ1dFZDeWNlc3FYMmIzeTRNcnFMdkJq?=
 =?utf-8?B?Qnp1TTBDZmsrZG80TFhYa0Z4U2lzTk9hTjFTcEtaZ0U3amRuRzNIdi9EVGxa?=
 =?utf-8?B?WFF3dlhPc3FlaEhRKzRCbGJITUhKN3VrU0pRM1lnVFEzMkE2S1lPRkkvcDZI?=
 =?utf-8?B?WXFEcTZFc1lVNEpweGcrOXpiZmg0YXkyYUVkRGxqRVpaNDI3dTR5K0dsQ0xn?=
 =?utf-8?B?d2pUN3NQcmJtU25jOEtzTU1ObkN1RGd4K25za1l0MXBnZDlwMHV2UU5CbUtF?=
 =?utf-8?B?TEEzZnFjTk5NZ1lyZFdxc2tjSk1lY05zWnRUMlJMWUJuWE50cG9xSFFMZHh6?=
 =?utf-8?B?SHYxL2hPN1VzajM5dGxxMzJGSUNXUHlkQ0dqZGpzY0lYRUtrOTRMSjNjblVJ?=
 =?utf-8?B?Z1V2R1BVZTRpMUt4bjBlOHZSMk51SE1jV29TSWJIUTdEMytBS0RYaGx5MXps?=
 =?utf-8?B?bzRNMDhyK1RDWkkzay9RTEF4Z0NJUmtsZkRaUllNc1N5RUxyV2lDbWhkUXUx?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5fac76-940c-426c-9df1-08dced8f8381
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:06:22.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jk5ylnKVW/x2luJq39blaJujE+VrErpCbLw3jKolcpXN9iS35Ir6enEvHZM/ptvR/hTz+3AggOn9nChKMl/OJVXTbUK6OxHD6idrZavGcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8748
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> Add the command line option to enable or disable exposing the ABMC
> (Assignable Bandwidth Monitoring Counters) hardware feature to resctrl.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


