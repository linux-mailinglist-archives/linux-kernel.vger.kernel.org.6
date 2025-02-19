Return-Path: <linux-kernel+bounces-522722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ADDA3CDC4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6887A17632C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADD51DED40;
	Wed, 19 Feb 2025 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdSeks6P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116761C1F13
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008874; cv=fail; b=ngJmfBIK0PtcGBA+QbcYSOQl1EllFE9KWzVfImLZ+bstjbotljiEmkl3OYlksiA6ecs/csSi3M/JHQ9dvu9v4NgdnhsQHUTX0CisKCkvTi3aXFHO+5r+9zgvnrmCJQgeitduMrd8bVrT44wf3nuhbu/W+aCFWEOLlrEeK4k6sZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008874; c=relaxed/simple;
	bh=fKc3J+icZmt7NJZZ5PL6p653ZzxeIvpAdPLmWfhnXRE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mPskMNrzNbzygYFotiOlFB0JPTx3jauOJh+51da/RZtNiTwyv7RnZU8g7046lj+gUhIo6fVpGpI/Zl5loTpNX2I1TppwXVqH5QrLPnBOX4hA1UbK2+e878BTDyEun/LVvKFBWleZhLvrX+1UQfsFLOFVuJ0OeHhTr+kPjeFKDm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdSeks6P; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740008872; x=1771544872;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fKc3J+icZmt7NJZZ5PL6p653ZzxeIvpAdPLmWfhnXRE=;
  b=UdSeks6PUnWTrGa12IYeelUzeLM4jAJ2hZyPtDnMy20ttBbm06kecVyi
   X/hkihUJIKLH2fWNA6uAX9Cpfkw0YBBNgxgZT6pnBYoTO9onZqdfgjKEB
   Wod5rJXAxWWRshizFS6mcHxKWStaVw/+0Ybywp9DT27Z644ru7472QWln
   Xhx9HG8Oy6UkD9UMd/11+XLnVKLcpNsOWBvdJKTiY9UgqUuFh0LkiOh2J
   YBwUYjG6+ffuTVe2w3QB9hq3Yqy9fNi2mPpnCprvPYWzI9NUBrQO3u4Le
   vlrVzGBXsxivTvs8uVmQdiMr5WYqgL5HNWuz4NCNMLHmukhx1iJt33bo5
   Q==;
X-CSE-ConnectionGUID: pniExPCZTDSmA8+POaDtIg==
X-CSE-MsgGUID: T2nyKNUdTqaucW+3H5X+rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="28364936"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="28364936"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:47:51 -0800
X-CSE-ConnectionGUID: ABpGlO0fTTmei42Kt8QkOQ==
X-CSE-MsgGUID: Gg0pT/i3Rl+iGxok0Qen9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="119966314"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 15:47:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 15:47:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 15:47:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:47:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOwe9uO9v70Lpx3KUoWl8leP0yjM6Xsd/8BH08umBbQDuuyZalKseWRvS7BWgRjEcmdmieUSsEtWH+S3m5femLfg/7FdFmS2gLIza2b+XH2X+SdmN75W01h9r7EP/IwOwOitSyl7XB6tgMBsMOHPQ9fu9SjEF7NKM0iowLSNCBx7/ugbYor9VBXOb+Ke1RcRsSFdokod5KbgTlIPPh4RhIhz5KAeirPeTfg7/N0uxw/HmJEei6UfDRrkiZM5pNP1DKrXcdUub0uUlFuPeaQHN7PZabpj2LLVeuxcnL8OfoDMc1ThliVt9q5ywso6LMDAtzpZWroLLOZHkZiTzQGO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+fmPXe9cdJs7ELmKqBXdZb7nDwkp8231ioc61SfUfs=;
 b=ZBqSKVPBpqqPNIVpz30Fnilq96lG7z/eL9NASXUJRRaJJSKsQakUtvJr0Mg9rA63Y1qfW3Q0rOZCx1RllqJsS9BgLjbIhRlsswleK4yC4AXRxkdpZP4KPKFy/UtOkJeDp5Sc1YNPFEz4XgPaIAtkIQWu/kWV9jcFiDqhZGVLouTeTko2dI7O6zIy6Z2HwiMwwv27x7oQjRVkbHkm02te3/SNEYCbq7wF3PhDSaemv6yQlrQuQ9NPAc19iT5TTv60nM7Rb077F67VQ7vT6lnP9GSrtTbv8NDyygoNHIZKPdxKc01cWT9fxJK+Uh7xUDbQS8p6Fk5r74Y8wjAb2A9LcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6096.namprd11.prod.outlook.com (2603:10b6:8:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.21; Wed, 19 Feb
 2025 23:47:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:47:28 +0000
Message-ID: <6946822e-4644-4be8-a187-3734b83fc8d7@intel.com>
Date: Wed, 19 Feb 2025 15:47:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/42] x86/resctrl: Rewrite and move the
 for_each_*_rdt_resource() walkers
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-18-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250207181823.6378-18-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:303:8d::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a069e6b-8b94-4f5c-0a9d-08dd513fc483
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHBEdFNFbXRndlFCdjA2WXRTTG53b2h5TUZxK2xuY2ZlSDBHTGZaSCtiMnJK?=
 =?utf-8?B?Z1kydlcwOXFUNHVVNFdqMXN6blBMZ1FSQkFYY2dEOWh5T01aSkZ1SC9aZm9T?=
 =?utf-8?B?VHNMZjJvdkJhc1JucFVaNWd3M1I3dlN2OThOSERqMlJWNlJBT0g4M3FLRkdI?=
 =?utf-8?B?TEYrQ2NHaVRXdU9rUytyTStTZUU1WGNTRXI3SVcvOWFPVUJlZzArSU1qSEZZ?=
 =?utf-8?B?ajZjcURweUwrTnBaSVZuOFBUMFFUa2NiZStBL2MyZXRIMFhLdkhVZ1BXemN0?=
 =?utf-8?B?bmJKY2puTkE1QkxQaUZSVml4NXFINlNjdzhvTXg1bElpaXRTb2VoR05jenQ0?=
 =?utf-8?B?R0xZK2NKQVJDa0x3MExtVXh5aWs4ajJQLzJUZWV1ZzlVSURMZUIwcEkrUExm?=
 =?utf-8?B?MzJudDVjR2ZWQU9yRld2SzdJb1FjMmQrbTdIV3YraVVCcHp2VlNvSHFTUkJv?=
 =?utf-8?B?dnltcTRNYTByOGZVQzd2eWZlb0ZoL0VaU3BhVllyKzBwdUZYek1jOWxvbmZa?=
 =?utf-8?B?Wng4NmR1a0dlK245MmpteU94OGRIbVV2ODhIRHVkb3dZTGF6MHlZZXNzTWdH?=
 =?utf-8?B?ZDFHVkU0emRVQUl1N1hEWHhxekVCeVJqZitvTzErVS8rN01nSGtZZllGbWNJ?=
 =?utf-8?B?bnBzcEdZNGZuYzI1ZW9sNTRML1VWNUhmWDIwWEkweVBGVTBnZU90ZjJIbzZI?=
 =?utf-8?B?QThjTUowd0ZCWVhJS3dOSTRDeWVHZWtDd0NQQmJtNVpyd2Y5a1Yvcnh3WVFD?=
 =?utf-8?B?TnJ3SnVrRG96YTlQWVhXVWI1ejVhb0EzWXNwSjRqbVBIQXhWckxvMWp1KzVt?=
 =?utf-8?B?ZTJqQXpSNURaMEh2ZkwzTjZNWnduTVFEc29hQS82OEQwSWdKMVoyRjhRU2Rq?=
 =?utf-8?B?eTl1R3N6UzZGZGEvbzc2cG00TTNOMk9YZ2RDYzM5dUtNRHo5VFR5TFgySnB1?=
 =?utf-8?B?enpUSVArNFlTU3huYTFIS0FHcXpKMGN6ODI0SXZndW5vdHNDdmxwRUtYT1FK?=
 =?utf-8?B?U2k3elBDWUtqbnp3YWdFMUxJUlhRNWtqVGgzbVFiTHNqbXpodzhGUVo5NlMw?=
 =?utf-8?B?ZXJJN2xIcXZyRDhONnhrbkdDR2t6OXdzVjJLd1BiWGRDeFY2UGZ6SDBSY2h0?=
 =?utf-8?B?bCtERkpEZEE4VHF3czRJQy8rRmJSdlFVRlo3Z0l6WmZleERjdUZGWEpuc0Jx?=
 =?utf-8?B?T2pxZ1dPcFlyeTZWZStETmNoaG9mMCsweTl3ZHo5ZFFrZTRuRHpwWTB5c2lP?=
 =?utf-8?B?Z0FiR21CNEQxYlZzWWNyaTZmUTZTRlFTK21CY2pSdG9qS1BKOVdPUEJKT1ds?=
 =?utf-8?B?dlY0b2FSRUYzNCtlUGxTVHo5NEJjUjJwSU1JVmQ3SjV5NitEdC8xcXk0d0d5?=
 =?utf-8?B?YjQwRnNqcURBbkdpbTJ3WVpFSTMzdTgyRVJPSklPTnZwMURXUUo5Sm5WcmdD?=
 =?utf-8?B?dklJeWp4d3VMQnFXZHdHdk9FekZJa1ZmN04wVlRtL2hVNFpiaUFHUlJQcHkr?=
 =?utf-8?B?WVlPN1hTdE1PUW5TTDNkT3lUb3ZkWGpMbC9DSWI4Q2NFdWFkVW0zV3Nublo2?=
 =?utf-8?B?bEtLZENGaDZ1ZUVLMzdIOHhnWU9DektnaDkvN3hXc3dJOFVaN3dCQWlPREJZ?=
 =?utf-8?B?c3dxR1MvYWZnN2RZTkZET1JqOVNtZTdOdVRZTlcxTUtWZDR3WXdxK1ZvUGU0?=
 =?utf-8?B?TEJsaThoNURKRUk1cHZFSzVJZUs1Nm1IT0JENW80djFrWFE5bWtUdFRpZ2ov?=
 =?utf-8?B?Vk5Vd3llUzg4ZVlrblhFemplODdGV3ptay9OelNvaUJaSGw4WlVpNHpMWnJw?=
 =?utf-8?B?NWJHSmtzYXRFZGhNK3NxTVRWWHNld3hkUkIvMUE5YUVrK2poMkViTUkwakRE?=
 =?utf-8?Q?UQ0W1E8YjM+El?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWdZUmxPaEJGQ0gyYTlmSUoySnBscXVRM2ZQOHRBOEd5RU1zY29DNVJ1WGdn?=
 =?utf-8?B?TnAreENKblpFTFEwT2Z6SE5LdlAwWXdJZDhDZGZ3cmJYb3VRV0lKZHZKZDFM?=
 =?utf-8?B?RGExcXdDRU9uTUF5Nk9QaTR4aTB3bjZNRzl4Kzl0NHFhcklqbG9xUzhPblU4?=
 =?utf-8?B?QUJVM0VJcUpiQVBOcXZ6cXZrMGhKb3YveFZmellRelg2cURKYlJhM283aHhw?=
 =?utf-8?B?c2o0a1JidnFFWXdFQzF2RllWTEFaaTFhWlVBR1V2czZNb3NkcEd0bHAwUFFn?=
 =?utf-8?B?ck5GSHltQ2NGYWkrNXgrZWkxUU1qdW1UZ0JVNUZGL3FubzE0M3BVS3ZzNEFs?=
 =?utf-8?B?azBuWnQyY2IyTEZXUk9Zejgyc3FPZTRDbVNYUGoyaXZEb1QyYmNLTHUvU05T?=
 =?utf-8?B?cWZYcVc2UEwrWk45UlFTemlaTkYrVUtDYUU2V1JIUVBCVmE0RXQwMnNJREly?=
 =?utf-8?B?NTVRalFwSDdGalpydWhncGxvT3FWdlVxNllvRVk4WmZlcGZHMi8vbVkydDZE?=
 =?utf-8?B?QTNCb1h6UFh6VWdhYTMvVmRVSGQ5VlU2VUJjcHdMcmMzQmdZQUlEd1VjMzZK?=
 =?utf-8?B?eUxtakVoRUhPSUFmUzlGVm9MT3NkSGJGMFhOWjN5TCs1eE5mdnRDNkNlc2F0?=
 =?utf-8?B?NmxvOXcxb1ltVDlEQWF3TTZvTXhPcDQ2RUxqYUh2eEw0UVNsR0ZTdURBV1hH?=
 =?utf-8?B?djNENWE1bTRTY0lvaXhtU1VvOFZEd2tldEtUa2NnRTVVaC9CbkpUUld4eUw2?=
 =?utf-8?B?STl3d0lPVlJjOGNTQ3h2Rk1xanhiNlRlbW5QOVdBR3BDUWtUa01DSEpxeEZH?=
 =?utf-8?B?WU95WmZHR1lrSVp2blRFQlNqN0h6ckFENE9zRHpvYW9jVnlaVHh2KzJYUUZ3?=
 =?utf-8?B?VFNHSTltV1RoY3NIc0N5V0xHNzBqQ2loK21uVktiRTRtTjNpMGJJWnJEQW40?=
 =?utf-8?B?MzFJd3FkaHRJMDNLTTRsb29uZFV4d0tJUGR5Z01UYjNzUXl1WmFlSVVWQUNM?=
 =?utf-8?B?NVpPUjNHSzdIaC9yOE1RelkxZDJhWis3WkxwcXJMaThrcDlmRUZZbTBhdGJW?=
 =?utf-8?B?QXlwbzhwRjVPU1FsWlYyTnFER0xNcy9ZRlZLSHBVZlpFamFpOGxqdFAxS3ZQ?=
 =?utf-8?B?bXl3eUc0aDhydHFnRmdsOWtBMWxnOVF3NDJrOCtVMGFTQ3RJM0xKTjIzdzJN?=
 =?utf-8?B?bTRRQks1SGRiN3MrZzFqUEpCTFF6UjFmVkxFK09lUVdtTkJNdUFuOUlrNEs1?=
 =?utf-8?B?R0g3TXc5NHFqTWxlcHJqbGdEQkNCcEtKeFFTenh5U0VMR2NVSEtCRWFHZG5h?=
 =?utf-8?B?NndPaXY2cGNpZEdWUEhibE5IajlyLzVrSnVkMmJSU1JXQzRDRWRWL1JobXNY?=
 =?utf-8?B?VlBLYmt1SFplRFVma3hFNDhuTFc3S0xXcGhPTlVoQjE5Nm5lUTVUMURzMTcw?=
 =?utf-8?B?aUQ2bDQ3eWxSNE9uOEhmOTFObU96UnYzZFFFNlZ6aDJFK3RBUDFjeXluMzhr?=
 =?utf-8?B?akhmc04wREdYVXpmbWlBN3JDSEQ5eHZaOHVYRm9KUElWUTNxdUdqbjBGaDEx?=
 =?utf-8?B?Q2ROYUhqQzM0WXRlZmdORWhxRnVxTy9FMVI3MnlWdUhveUU2eFhEL2p6c0hn?=
 =?utf-8?B?ZVJ6b2lTZ3A3VngybkRORnhIb3NCVXBaNE56bjNkalA1VU5PWkpPUW14RlVm?=
 =?utf-8?B?R091YzI5dzY0Q1kvSXZ0dnY5MUhIMS96ZGxmZUx0STl4TS9PWkVrMUFjd3Nr?=
 =?utf-8?B?UWJlemRSUENWM0s0bTI4bVpxQmpmS0ZLVlNxdnlXVWtmZWEyQWxPQUx3SVk3?=
 =?utf-8?B?U3RhQ2M3eE5iQ0dZL2l6RzN1V2dOTW5RYUlNY3dzend1cUJsbHlJS21uMi9X?=
 =?utf-8?B?OXZGaXhxNUN0SEYvdXZaQXhQaVVqMkUvY3NqeHZTdi9zYm4yN1Y2dUdKZjRm?=
 =?utf-8?B?WENYdjhxejdMUzBiSTR4V2V5NVZEVTErdzdZQnV4WkpCMGR1Qmh1UytyWGQ3?=
 =?utf-8?B?Y2VpLzhVZEVOU3NOay9Qa1NqZTUyTU5oc2t4QmlMeTRLeDNHZDRQY1JOQ093?=
 =?utf-8?B?b1k5VU8zS1EwdXZHb3JYdk9BUE1rWXRUZjF1bXA1K2hZUDNOU0RSSkppL29m?=
 =?utf-8?B?QWp1WStxQ3ZjeTBxTlFOS2NrcGNzVGZja2FVSXhzTG9haUorWDYzYzZwM0Jt?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a069e6b-8b94-4f5c-0a9d-08dd513fc483
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:47:27.9993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8U5sVtFegEGxxgKT9JOL2z73pIpnjobyyX4KYxK1zOT/3Dv+6DF6MSl9sza4xJfiUixDz/y0AgqSqd8gLiGx/TEN+HafbTM61N5S8ynN3jM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6096
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> The for_each_*_rdt_resource() helpers walk the architecture's array
> of structures, using the resctrl visible part as an iterator. These
> became over-complex when the structures were split into a
> filesystem and architecture-specific struct. This approach avoided
> the need to touch every call site, and was done before there was a
> helper to retrieve a resource by rid.
> 
> Once the filesystem parts of resctrl are moved to /fs/, both the
> architecture's resource array, and the definition of those structures
> is no longer accessible. To support resctrl, each architecture would
> have to provide equally complex macros.
> 
> Rewrite the macro to make use of resctrl_arch_get_resource(), and
> move these to include/linux/resctrl.h so existing x86 arch code continues
> to use them.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


