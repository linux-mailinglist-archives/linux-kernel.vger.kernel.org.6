Return-Path: <linux-kernel+bounces-236345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39AA91E0BE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78533281135
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CD015A863;
	Mon,  1 Jul 2024 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ES5+B42s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F431CA9C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840705; cv=fail; b=Ok3tr0Dq0v8wh/OfBolnjCm2Ajg5puOp28DicEunK3SfcO8f0pwRzWG8Jq1C1SfM3l/xe3s5hmdYIdiRTKa7UqiKoYUwqKbvMwMS1LLNoCWeZfRxF76ai9ibmjjyTnQDlA3Z/ta/x8m+4oPJHPl75tXLQocT0ljmJ6TISfGWcy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840705; c=relaxed/simple;
	bh=iI59/q3Xrlv84WEmQRbNATfNqMnrB2wHqsjKPz77VCw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LRQ7ljW/vtU+WZAuSiZDtATXbAcaSQ/r5UIdlTP3VB7us9Xemzo1SC1KwaUlI1t2BvgcNiyKmD+VsVyqhWXhSdkZSBCbWWV7x20vdvi/IqAuuOmi3eku/aRpR/V4IPOapNkhbNxg44XYOlG3tOV39OYdNi+ylvCmb8Z00YPGmaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ES5+B42s; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719840703; x=1751376703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iI59/q3Xrlv84WEmQRbNATfNqMnrB2wHqsjKPz77VCw=;
  b=ES5+B42sa6jjNg0uXVfKisQVDRXJwJ96M38q5UTBO3aCsXrnsl41EO9n
   z7iTVy3C34NSrgDyYSHua34+6noeYKDqziE+rxxysCj72wMiLILZdWKAg
   lK0XWzb3eXoPhVtKUL06LbaOTLLIGJbweeF2RD3syZz2J3JEUchbFTsZv
   nQeKe8tCz/yJ5Tdcy1+5+wegHqpKtiY3GrfKuXya3xO7siq2DGSWb275s
   3ugt4SrGHLswGtAO3De5Tw3aXZNxIokjKodCWPprEHB8Z+KARQnImtkfb
   RmELjPT6VdS3OJf7ATcbIKN0s8lZ5bv0y8ZdrrhjT99LIMzdnmO8znnRg
   w==;
X-CSE-ConnectionGUID: VeVyPnOPSiSZCDrRmWvicw==
X-CSE-MsgGUID: PlbOPyE4RWawtPO+5drdLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="17104437"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="17104437"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 06:31:42 -0700
X-CSE-ConnectionGUID: aN5gDVOdTpiIcfCsdB4+aw==
X-CSE-MsgGUID: aXM2V/6zRFy4MWQEXget4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="76240033"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 06:31:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 06:31:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 06:31:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 06:31:40 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 06:31:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKWHK6GkGaJU5RqTd6Lty3gwtxqHcGm2n1UCHV0p9V/fY6OMPMWToFtpNHeBnzEGtve3VLi7otHgtjvygckLa79ANI5piTQsphtniLO5dLTIrC7EdkAVgJ7qC5EV0ZTC1fum9RJJUTiS+DtpSEWBBBcF4nn18XBK3lzeo13p8Nu7qUlYeq7jEZz5sUh+l9AaL75WBjJQmNZahV6WSn6dFY4Nav3u3+1TkzhzHLMQQJrw9W4zbWJcfiw3o4lhYy2mcsrc6ww/pmocrvEM2MyiVQnvSLrZqkl3wAhPQobafeP+EFpOpTscI5a4+LZqe/y7ecLh+YFFGKUUanUKJdVjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzDaqnsuS9ZMiMoAghXy07FxWkNRnxGlKl35FWu8tyU=;
 b=Se23fplBYQu+2oxkWFR5KdBSDKmrjmuaxPciG+tK4sd+lyTLf20XZMabgBDHZGTrkczAlriv2Ikc2UiGxS8iwnXoT04G0ueyh8Y890B+ceXM39wXORtVpsXADlhEIQJfNlWjFY38MEYIsVOAigtkZL9oFh0oAJV+7GuO+JBWNA1zcLCPLVuJG70Zv4y1e5WemOa6CEDOKxt49DhI0TpakMB/h1XG6LrPslczCN1mGJWubxLBgVIpo25XPotk9PXhmhxBwHdMU0rYMOZ0RAhJkg4AU/62SDVMSckE+KKeiULbU7/X3ABJy+bAmlYdR5k1CvrXvgZ52QLD7L5OGikWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM6PR11MB4593.namprd11.prod.outlook.com (2603:10b6:5:2a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 13:31:38 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 13:31:38 +0000
Message-ID: <cef39a6f-426d-4c4d-950e-edbbe5e95acf@intel.com>
Date: Mon, 1 Jul 2024 15:31:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: proposition for fixing Y292B bug
To: Bagas Sanjaya <bagasdotme@gmail.com>
CC: David Polakovic <email@dpolakovic.space>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, "Alexander
 Lobakin" <alexandr.lobakin@intel.com>, Jakub Kicinski <kuba@kernel.org>
References: <3be3235a-dea7-a5ca-b5ea-4047bdeb695d@dpolakovic.space>
 <ZoFgga45QCh2uA0i@archie.me>
 <9e3b638d-76f2-8520-2a24-7de0cd0bc149@dpolakovic.space>
 <ZoJx5GaBDHg7nayw@archie.me>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZoJx5GaBDHg7nayw@archie.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0297.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM6PR11MB4593:EE_
X-MS-Office365-Filtering-Correlation-Id: 194582b3-6e12-40eb-9e6d-08dc99d2225e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFZnNGd2UWNUTklwSGZzRXg3M3kxWWU1NjdreTRvMWlvN1dUYWNEdGE1bGhq?=
 =?utf-8?B?a2pSdHVvSTNqNFVQN2tYb0VJMTRmaStTb0RRelNISnNSMVRvTDBSYWp5R2l5?=
 =?utf-8?B?T0VWaDlScjNSR1RPTUpCcU5GZER4UTNnU1dEaSt6ZjA5VjlCQ3hkdjJBSU9x?=
 =?utf-8?B?N3orTVpPeFNQbGpYUXV5bS9zVVpLdDMzdklYVW1PNFlsT0pRMU5sczYyN2Jk?=
 =?utf-8?B?Qi9YSTBvbHN1Nm1ENXB6czRSanlkTEdlZ2NCTHVzYWhSc2tROFQ4TkhRMFR6?=
 =?utf-8?B?VzVtV2lWeGZUK284cUZhYS9GV0V6RWFyQ2dMaGNIMGQ5VFk5c1ZKUGRpZ3Rm?=
 =?utf-8?B?WVJGb1c0VU1BNEtQd1VTbXFUN2hiRXBiby9IUmFzbFloUzhEc0hQZ1hoaTBO?=
 =?utf-8?B?OTd0Vjk5dE1UR3BuUkxoYzB2Sm9ZZFBpOEJTZFN0Q2hMRWlQSFZQZURqTmpI?=
 =?utf-8?B?UElmTVZCZHhSdmYrL0FNWGE4dTBpVGZtaFZ1NWlMZkJIMDhvS25tV0RlVlZq?=
 =?utf-8?B?djNKSEtMTVFZem5SS0Q3TSsvVU1QclBxeEFuSWU0SlhSQ0ZNVkttNDlqYkN4?=
 =?utf-8?B?QWRWTm9RdXNWTHppMG0wbHBwZUtlT0RsdUs5ZW91RThOWEhvazRJMG5laVJK?=
 =?utf-8?B?OGZGWHdObjlnTlhjODRCSGlmc1N4cFM1VTkxOVlaSUN6Tjc1Wm9rN1R0UXF6?=
 =?utf-8?B?eW0wWnNaMVk4dkI4WHlMVnlBRnozZ2s5TzViTytCVjRJZndvcnRvdDUvM2dB?=
 =?utf-8?B?SFZGMFNoSFJuNmFGRUVsTUlxRGhQWGx1bXlEZS96QS9EUGVmeTlXdVpPNUkx?=
 =?utf-8?B?b2ZTejllcVYxeWNUZWVkVzQvY0xDbTZSeTM0cDhMTEZBWXZkc3FBRVB2RnNr?=
 =?utf-8?B?aFpUNDJYcnVqN2E2Zm9mdFBLMm5kZDNoM1hWNnplTUtCTmhkK3ZPcEZhWmNy?=
 =?utf-8?B?a1N4VnBLZ1JoVGpIcmFUc2F0L09rZDIyQkxnOEJhR2JvRnkrUUFJdlRiNDdk?=
 =?utf-8?B?R3hzcGtxL3VtVWpmRWN2T2lxMUdYYzRXNE1rK0p6aHQ1UFlBTFloeUV6b0li?=
 =?utf-8?B?bU1BcjBWZUU3NDdSVGpVME14TTI3MVZHK3YvaUIzeno3UEdKUDNidmZiNEw5?=
 =?utf-8?B?VVVUcjhNc2h5WUg5V2Y5ZTdDbENDVkJ2VmI1VVprbzdkeTlyZk9IUldLRjBh?=
 =?utf-8?B?ci8zSXF5NEhFemwyNXZJeEZNZzRNMU9hekhDZmVzNHgvNUVMd1lMeVhQQlJF?=
 =?utf-8?B?N3FZL3BoQU5tMTZXNnpGZlpBdzlJMEJKMkhxN2p1TEZqYS80RFNHUUROMmp0?=
 =?utf-8?B?czl0dTlpbEd5UmZ3bzh2dTRyL0s1RG54QWEwTVNBZnZxdmdINnNSYWI5L0dr?=
 =?utf-8?B?NzZZeDkwYUZtc1k4NVUvY3BWaTczUmFoVlFmTUFObjczbVJhV2tQcWFuby85?=
 =?utf-8?B?WHFsZndKMXd5aXRGNVBpZ2lvNDdxN2hsakdPRDJUdmUvZjViT0NGdnNtbzJy?=
 =?utf-8?B?d0lMMmVlWFhOcjl1bC9ZejFQL2g2M1VXTFFYejJKaEs5QU5TV0YyZ09Ga2Fa?=
 =?utf-8?B?Sk4vQ0h6eG5KOWFOeVY4R1FIWVRsNjJicGt4WGRuNUJtcWkrQVF6UFZocEpH?=
 =?utf-8?B?WUxINGJYMEpjWGZrOTR6VXRZSzVocW9RWHNKMk8vRkdTSzc1MnBhREJVcVIy?=
 =?utf-8?B?VWNtVUQ3V0VwV05GdXBkOE10UG1IZjMrVmpZb3A2QUFQci9VMWpldjlpOWpn?=
 =?utf-8?Q?43lCIqufhD0jqKKW4U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QldwRFJHY2hDYVNrL0g2d2pMZzF2dzNzZ3lnZzFMRHJ1NGwzZjIvKzRwcTFI?=
 =?utf-8?B?MGZsVzJWUjJ0T3hnOUgzRzdLVjdzT29TL1RjL3VQY2YyczZ5N0FhZzFMU3A3?=
 =?utf-8?B?c1k5M1NSY0NqcU03OFliUnRoVmx2aUpJVEYxd2Y1cUF0dlRJWGtqTkxaSWxk?=
 =?utf-8?B?UDRvc1ZnVk95bTYrbVBtdzJMR0hVRjdpTmd5Skg5MWp4MlQxcHFkUHZlSHNH?=
 =?utf-8?B?MHlSNDJOWk9OT3AxY2NkMUlTL3Vva1VZZ2lrVm1kTFFkQ2NKMS9kT3YzYlRZ?=
 =?utf-8?B?dzk2SlJ1RWNIRGM3d0xzVU8wekhQdlV4MWxmVERBSm5TbXhPY1lEWTlkWGY3?=
 =?utf-8?B?eWo5ajJBZmE2YWJYckJJWXBsQlVGWkdncnVQRnVLRWtvUFIvOGR3YjRrOHNi?=
 =?utf-8?B?WHVsaVU3UXBDaHEvTnQ2ektLV05aRWdkYjEvalBDRG0rRGdlelJBWXJCMHpC?=
 =?utf-8?B?WkFwSnQ1cjQ3Wk01YWpGbzJMQ1JLcXVzQVlYNUIvcnQwMHhGbXo2VEI5NUgz?=
 =?utf-8?B?TlcxWXR3OWhacVBUVEQvRVlvSHhDOUNCcytNcjNKS2YzUzdkb3pZaStRRTQy?=
 =?utf-8?B?TTloTGlRR2dPN1VjZVBtNG1mSFRia1J6OUJseFpHenpoSGI5WVdIWmhuUTAr?=
 =?utf-8?B?NWNuRXI0L2RYd29hZkNEamd5SFlhRlNZa1ZpNWxxV21PVWZoNkV3RlZrL2w5?=
 =?utf-8?B?Q1dETDFuYXpMeEJ1ckVQMzhLL281dEp4TVdQdi8zbzcyZzVSY2FZdW1UZE9i?=
 =?utf-8?B?d2hXUXNTalRsZ3pCSjRMdDBlYld4c245ZmZudXdNMkdCb2k5OEwrTkVaK21W?=
 =?utf-8?B?cVgyU3RjR3M3OVdJMkNLQW95OVl0WnZsbkFTSlJCZjF3TGZQSWtZVk44L0N3?=
 =?utf-8?B?cFBNSDZ2UUwvNm9VZXk5cFBIQmhhSHFKeEJnaUE0QjEzbDNzbCt2Uk15RDZF?=
 =?utf-8?B?V3UxR0gyclpVVHBQZ0w4ZUNhYkRDRkY1WU5yQVg5eHlWNmJHc2FMVGxBTHh0?=
 =?utf-8?B?SEVhdHAzcWVOQmoydm5JeFpRb0U5am5adDFRWUxKZ2JyenNpWVFtOXF3WlZN?=
 =?utf-8?B?aEU5TGgrOXBvcDlvMWpVUVNMRjU4ODJwUjJueUNZQitIRWh2dlFyeXNlVDBX?=
 =?utf-8?B?RFF5Q0RkUlo2R0VOd05hTGtSaG1YaWsxb0UwZEJxcytaYm1ZZDVjcFFudlRq?=
 =?utf-8?B?ZE80ZnhPMzUxWHR2b1J0YU82ZW5KTEIrb3lqUWxPTy9Cb0NGZUFobWRWby8z?=
 =?utf-8?B?QVZkV1FCRzFiS0VDcWY3R3RseWZhellVL0oxbDdkbW9POU1ERy8reExsRWpt?=
 =?utf-8?B?Q0toMU5ob01kZXRaUVBIWDJhU1ZrclorR0VyT0M2bVpHYkRGUElpWEdxSUxL?=
 =?utf-8?B?Y0FqVlhUeVFzbmptNFpKdkxnWUZSd2hzYjdwOGhKZm1BYy9TSzM2aitueWM0?=
 =?utf-8?B?c2FrajJtQ2dNV3RpWXlVRkVoTDdYSG53ejFBck9UYTJ4T0duTllnWGV1TkFZ?=
 =?utf-8?B?ei9FT01QTHRnSnF1OGszSlFBUFcwRXdXdGNaZjNrUWhTeFkwNkoyL3JhQWcy?=
 =?utf-8?B?UXNkVUJmNlloRmlFaGRQb2JjaFQ2czJOU3ZvUFNyRlM5SzlhS2J5MEl5MTVu?=
 =?utf-8?B?UEtEak5WakJFRTBsdTZUTzZxL25TMVkyQW55SjdNaU9UZ3V6QVBxTkZLNkEy?=
 =?utf-8?B?bUlDaHJDTnVIR1JNWmdyUVUvOUFZeWMwM0VyWGs0Q0VqeS9jMVMyNjZCTEVk?=
 =?utf-8?B?UzluNUFPNjdEVUNHKzJnd3dBam9QZzU1ckRTKzdQWTYwRFUwNm41VUxBMVdv?=
 =?utf-8?B?RlhPZ21DZGY4QWg1WDdxWjhDWUNtMVlOL2IvWVBINmoxOXdBMzFZekV1R2d2?=
 =?utf-8?B?ZlVTbFB1aG1rNG4yY2Q1NXY2bHBwZUVOc2d6VWJuUjRZNG1GVE5DNXMzNjAz?=
 =?utf-8?B?RkdOVEpVZGdqNHAzd3V1T05SZzBCT0ZENDFFOXB3L0VWYjZXMGFLQy9yTmZa?=
 =?utf-8?B?MlNyd0RPTU5SMTZBbEw3bTNHQXBWTHZUUDhMakJ0Q2lZaFNRTzVmckFvQVpm?=
 =?utf-8?B?N3lnR05WV1NRMjZmcFBiK0dNbXZpZzFsdStyMTUzT2dDY21qaXIwYmFHeHlK?=
 =?utf-8?B?RUd3UEJOSUtEeFlFWEZLQUExQTJrOTNHbGR0anRUcXl2MTVUditGaDFwQWlR?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 194582b3-6e12-40eb-9e6d-08dc99d2225e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 13:31:38.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slHtOCynzYaE3a55D8vnF0K7xYTWjBBP6RfiM0pHdX0rsWojdPGBkUtkKVBr/6YgMiM8KbuK9WHeWeiNvWGsAMh5Z/9u78YwgYh2OZ+Z0Cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4593
X-OriginatorOrg: intel.com

From: Bagas Sanjaya <bagasdotme@gmail.com>
Date: Mon, 1 Jul 2024 16:07:48 +0700

> On Sun, Jun 30, 2024 at 05:27:24PM +0200, David Polakovic wrote:
>> Thanks for reply.
> 
> Please don't top-post on LKML, reply inline with appropriate context
> instead.
> 
>>
>> My proposed solution was to create this BigInt datatype, which
>> stores the value in array. The functions for division, multiplication,
>> addition, subtraction and comparison could be stored in separate
>> ".h" library for manipulation with BigInt datatype. The paper speaks
>> more in detail.

IRRC there is big integer type somewhere in either lib/ or crypto/,
I don't remember exactly. It's used only for crypto tho.

>>
>> And yes, this truly is an userspace solution, but for kernel space
>> implementation I have zero to none experience. Therefore I wrote
>> here.
> 
> There was a proposal for adding 128-bit unsigned integer (see [1]).
> The signed counterpart should be analogous.

I have generic 128-bit integer API/infra for the kernel in my internal
repo. I've been planning to upstream it for a couple years already, but
every time couldn't find a slot to do that.
I can upload it to my open GitHub, so that maybe someone else who needs
it could pick it up?

> 
> Thanks.
> 
> [1]: https://lore.kernel.org/lkml/20220722145514.767592-1-alexandr.lobakin@intel.com/

Thanks,
Olek

