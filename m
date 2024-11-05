Return-Path: <linux-kernel+bounces-397277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0D89BD9CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEA81C21858
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585A6216A30;
	Tue,  5 Nov 2024 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWX+QPPp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280421643C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730849972; cv=fail; b=amxJO6arBLqbxD2FJPrOyI0xeZYh1O314OuXviqgymrVxapve8vRhSWzQ6Ccu7rSZiCHQryIJ5sywCyo1Nyp1YIyjqynfZP+xf0uiX37n1tHwZtUl8UJrAy8g3/fN1qu49HNukZANxMypBX4c8FCqBk682we/Vn+fwHFYsWCSbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730849972; c=relaxed/simple;
	bh=nWAdUkh7MsB0yecKSQ32e02JIEmCzfHD03JEHxhltRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=easCzNFU//l/iKNvSTu2jwX7i1T2SWA+B+3Hww6NAy8WbHwpM/oZzA5I3I7FdhUu5q/YPdv1YtUdT/3OEYXl/SwGmkItHCUzvzgCgodpKAL8fTx9l50Iqj9E0dB1+0Z3CdmNBEry5W5G7SqDpbKfUSJ8Zg9Oj+l+1wC38NTa6nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWX+QPPp; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730849970; x=1762385970;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nWAdUkh7MsB0yecKSQ32e02JIEmCzfHD03JEHxhltRw=;
  b=SWX+QPPpwVRjyNndQ0orMcXOa5dPguA9269cUIKDLpyCZivweaCqESmW
   Z319zeZs/0DOCo7KZPpndPEQi4cC3qriy71qPYdCxV6ebGalstrHyN2pa
   EE/xMNt2zHFArTsjeQRJOggSeVjWxsqYDlAJbVTAOJvQh2ujLNQCRjAQH
   PY4Q7A+jFRwQY/jpOoPEM355F9QifZD594FUz3QLfY/Ennultl9HMp5yP
   aEeOfdXGGwsSXx7wZJFKXTZ+s3DJtj5LoBrwL3yj9XxmgjDpw9VPgWKtt
   Px/C0oSqTCCyK3HPScY54VmkwlqBrhKx9XQPeOj06ipZa3AK1As+dvWT2
   g==;
X-CSE-ConnectionGUID: +bTtilWAReGyE3RzcaPokQ==
X-CSE-MsgGUID: ubPWb11xTrSBSOS8IiYAgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30036400"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="30036400"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 15:39:30 -0800
X-CSE-ConnectionGUID: qxe6JSdDTvmpcEqslu+PEA==
X-CSE-MsgGUID: w9KoLL2IR2KE7X1jkT4Tfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84347305"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 15:39:27 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 15:39:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 15:39:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 15:39:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljwcehonSgqCAvnVG584mhVJQOwwWIU/tjqJCzfJYNu1nI9p/0hY5fbaf+DATIiGwt8fA0Pgx2mtdxz9wVx2bJ6bjiZOTTnl3uQfrw3DE4wI4DVkig6LSoiBz6dhALotexWOiMbtLjhbgnPq1ybVQMgnTwaEF7ghzp4xQMpNc9feNVS11HO9kieMTdJ/3zlsVqrYzfS2dGCzvudBvpZYtYU/HMEQF4gcrl908ZicCbXSpzgZweqa2IONjS7vbWi3a2276SdHO6l+SLuZQOjl4xiU+SkhrIrascIHwZWDC4By+S2KlpORhqCdf7w5SXDDq2mZrguL8f0WDw6PaJ+Ccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWAdUkh7MsB0yecKSQ32e02JIEmCzfHD03JEHxhltRw=;
 b=HtnhKcOnnLuxsgPvG10APB4sOlqKbZtGJKVFc2VrW5UiDpufQ3+ORhE7AF1G0NxpsBM1hBqfik49N98KKIw/eY33f9aRI+TZRvEZx9xWq8Wtkl7/SNSe6jWkbQHxJbKEI8/W1mfpapI97nVLHV5qYrJzpKLVX1vNMmCX3/y1mIJz71cxjgBcf5wc7Pr/aP+KZtxmOZIm/jJ51fUPBtWBJecovtozsC8Gk2lgnmUCoZWNyxiINPD18kBFFMZqrBnn9XMAM4N0VLz0uDWrGAYwTdC1gM4XUL1S9u67kwZbUN0s5E+tD559XstYi153mmOBgM9B7e77brrrpP2MO9Khdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB4837.namprd11.prod.outlook.com (2603:10b6:510:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 23:39:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%3]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 23:39:23 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, Peter Newman
	<peternewman@google.com>, "Yu, Fenghua" <fenghua.yu@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Babu
 Moger" <babu.moger@amd.com>, James Morse <james.morse@arm.com>, "Martin
 Kletzander" <nert.pinx@gmail.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eranian,
 Stephane" <eranian@google.com>
Subject: RE: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Thread-Topic: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Thread-Index: AQHbK6DbACO0R1VGa0C5nUIcf/5WR7KnvKiAgADW1ICAAMfagIAAA9UQ
Date: Tue, 5 Nov 2024 23:39:23 +0000
Message-ID: <SJ1PR11MB6083D1B48E48BBE797ACF21FFC522@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241031142553.3963058-1-peternewman@google.com>
 <20241031142553.3963058-2-peternewman@google.com>
 <b3a52af9-e298-7baa-19b3-8931d03731d1@intel.com>
 <CALPaoCgc13hS64mSWvn6zYQWwVKzcyF8xueWsaP62ZZJiv+nog@mail.gmail.com>
 <4e2f31bf-1035-40a6-b16d-081d6e45ead8@intel.com>
In-Reply-To: <4e2f31bf-1035-40a6-b16d-081d6e45ead8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB4837:EE_
x-ms-office365-filtering-correlation-id: 515832d4-818f-4c53-20f6-08dcfdf31450
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YmVWdUVUYWF6VUZUcDJJb2ZCQWpvblI4N1ZUOFI3aHFBcFJmR21SUEYwRDBh?=
 =?utf-8?B?TmUvWVlJdnBzZThCR1lYM2dQakhYOVVKU0VoN2ZTcWlsTnVTaitKVGpyRWp5?=
 =?utf-8?B?dkhoU2lGeXZsRi8zSklEdW1nVExnSC9oOXYxNk9ObUIrUjJMUStQZ2pSdzB4?=
 =?utf-8?B?RmtNaG91bCtsSTNHRm9pc0VEMTZLaDN2VmttM2xsWGNBNlpwK3Y5Wm1CUk95?=
 =?utf-8?B?VmVUUEZYSHRoN0NDVzY2VzN5UkZSVUljdHZNMUk5Vmk3VkZXSUpUcW9ZMHh5?=
 =?utf-8?B?eTExUXdLR09kMkJBaUNPekJDbE9SVUVoSEhLVk1La3NYSGlvd3JXVmt2Y1ZT?=
 =?utf-8?B?VW9UVXNMYk43d2ZJM3ZiQ0pya05yYWdzV3d0WlV5SEhaOGRpUUpaK1F5Q0lT?=
 =?utf-8?B?WnEyWkFyaFZMb2JIdWdJT2hQNVk4REZsamlnWTl0L1gvMmYvcHg5Z25WRWEv?=
 =?utf-8?B?QlB2TUFwcWxxOXJOeUdyWEY1amN1SE5CY0E3U0hOaDJXMm9kaDF5OG9xbVdJ?=
 =?utf-8?B?Y05pRVJxZ3o4YnRSRDEvMVBuYzd4ZktmZm05S1FWQkc5VzY1c0xDUjVMcnJi?=
 =?utf-8?B?NDU2RDRRR1FNNGJma0VvSHl0ODFFU1FmMzh6dE02eWFnRnl3aC80TFMxSk1X?=
 =?utf-8?B?cnhoNHBkc1dYZjNWSkMyVkc4dzh5U0s3MSs5eUJ0eXFudWhUMUtMcDE3eFh4?=
 =?utf-8?B?TE9nNlI1MXVYNXZ3RVNXemhLdFhoaktZeHcvWnI0dC9ub253YjZEMWNwQlZI?=
 =?utf-8?B?US9vZmNtUVBsd1FhMU8rUmdRamE4TDlzVm9TTVlOV3hnZFBwcjBJbVAyNjVw?=
 =?utf-8?B?SkVaSmFkUU9EK3RjTi9ZQ0NzdGI4MWRvbU5tNEYvL0hhdzBuc2kweHR4Q2J2?=
 =?utf-8?B?bkcyS29aSEZVd0lIM2pydVl3VW8rbVloTUQ3bkFjNENqU0xENEdQNVhnenlz?=
 =?utf-8?B?RVBheHJadlBOc3B4SHYzbDVlMDZhMlBTNWJRNk1vdkJGY0k0alptRzhYV0pC?=
 =?utf-8?B?b2M3Ukh2RnhpaEJ1RFdDaWlyYVEvdFdjUUtWMkh1cWpKSmJxenBlOXczR2xU?=
 =?utf-8?B?eklKcFU2aTlNWlVWZ2FKL2FmUUxJb0JLczlPRHZqa3NQOGhaZlB1Y2wwYldj?=
 =?utf-8?B?bzQvTFZ6Q1hVaVpmRFByZitUaXZWZnIrUkdERzZScU1mamUwYW9OazEzaFVh?=
 =?utf-8?B?bW16L0dFUUQyMFB2U1BmYVZxZzJMelRCWUg4emZHU1NUcS9ITGN2dE1IY1Zs?=
 =?utf-8?B?NENWY0hNOFhGUW03aCtmclh4VzNNVGM3SWUzTXJ4VDRlb2wzbUtGWTlGYU1V?=
 =?utf-8?B?TDFGUVpUMzNVVU9tZGUzcFlNR1dWVWdjQVI2ekFzS1h5dE9TWnhTR2xyYmxC?=
 =?utf-8?B?T1BNOHlTTnBKWkc2M3MzaFFOSDlITmIrNHM4eDJpQ2V6eTJPektXSzBVYnZB?=
 =?utf-8?B?MTBKazUyWkttZ0l6YjIvUVpta01zUjFuVklEM0t6TmFxYjZncVNPeTJVT3kr?=
 =?utf-8?B?T1AzTXdtZG1lUXlvZWtFRHBpV0NtTWpYaGtkQUdDRlBJOGx2azVLYnp2cC90?=
 =?utf-8?B?MGlicCs0RGE4cGZycU5XbG1aZmgwV1pCamF0bFRaRGYyRWZWTnJ0bzhaNTJ6?=
 =?utf-8?B?V21EcUc5ZnByZzAwK1FRYlYzQ3lNRUo4ODlEV0FWVnMySFNUU1JXblpnckxp?=
 =?utf-8?B?YXdHVm0rMmtGYzZodmZEdHY5bXZZNXY0U080N1UzQjhsUHZJOEZVSXhTanI1?=
 =?utf-8?B?QlgrVmRjT3RsWE1PcDViZDhPUUU3aXd4bi91T3JzdVBzN1BWTGxuMlZqWU04?=
 =?utf-8?Q?J3PPM9KZlaPuobBzEiAV18M2K/dH3d0WZRLdk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjJpaGVlcXo2Tkg1WFNRMmozYnZCS1VqMEp1bHhkL3M5YkU1MDNyS0RRZm45?=
 =?utf-8?B?S0hmZWphNysvcmtRYWJQZE1wQ05DTkM0N0NWVXVseDZDOE5YNzVPQ0dpQjNI?=
 =?utf-8?B?aW4vdSt4VlJlelQ2d0ZEc3ZDL1BIR0s3WjNkVW1sU01Odml6a2NuOVYyZzZF?=
 =?utf-8?B?VkFPYjRkUTg0cWg2dytWYi9heVpJaHZ4ajYvWHhZd3pOTXo1c05ldE1wZGo2?=
 =?utf-8?B?akpnYzdBOWRKV1ZnaTNQS2pITXUyUDVNUEVvMkxqd0hBOWNab0dWT2xnMFk2?=
 =?utf-8?B?MFRYTlRxcWFMWG9CUnB4R1VBS2UvRkErb0pNVG5qdm5kcjY3M3A1am9uZS9L?=
 =?utf-8?B?OGNvN3VQa1dLUU5XVlJJT2dXRU1RaDhGbFVVbmNDby9udWdEamZtOVF4R2JW?=
 =?utf-8?B?TkQ3TFRFY1c3MjZLNjR2d2RDQWsyenQzTGU1QTQvNTVBZFFtN0tER3pYNVZK?=
 =?utf-8?B?ZVVLaHdDZ2Nrd3Jtc1A4MDdrMis0ZHVFNWxlSkhHSkJRamkwcGlqUi80cnRM?=
 =?utf-8?B?eFdFcVdaTDJwbGUzdXB1Sm0vUlkyMlZ6cjZuOFAvcmJnTUFXYnVLV0xJOS9v?=
 =?utf-8?B?R1orQ3BkZk1FSVdWZlFLQk9TckRIU3hlTG5WOE5Kc0FnOFY0WW1YcWFib0xG?=
 =?utf-8?B?eXh1NmtjQzd3YlRCMFBGMDArZ1c5cjdnOG14NU4wMU5KdEw2Z0wxYUQ2NWhp?=
 =?utf-8?B?a05US0VkZmlNdERjeFNSUFkzQUxkSkdRTVMrVUhJNkhyeFlJOE1SalJ3T3NO?=
 =?utf-8?B?VDk2TVoybWZoZnZDc3dQMDlmcmtsSEROb0diTHZ1a1pFMDhyeERhdlZKcy9z?=
 =?utf-8?B?SlJqM3JzSGQ4aHcrekZIelA2MW02QzlTL25zUGtpQXVnT1AyWnhZMXRqaHZO?=
 =?utf-8?B?Vy9ZV2VmQ2xaZ3ZwNy9NV1dxa3NveXY0UWZ5eXJLNU14ay8yQ2ticGNZdnV2?=
 =?utf-8?B?L280QjZ0c3cwdDJDR2d1RjJmN2gwK1RmbEswd3hGNXE1T1VzZTdaeVN3MWdG?=
 =?utf-8?B?ZXZyaUxncEM1VkVIWE0xTFdMWnRwQ0FGclFIMTl0Tk44dGhKbjJNQmFuQnZM?=
 =?utf-8?B?cVk1MjIzYS9YTlVXaXpKS25xRnVUUXoyWDA3d24rUGJJc0ZXU1RlOWJVU1o2?=
 =?utf-8?B?Q3JIcjFyQnpsd0x1ZXJBZWxwQ3dpOUJpSmo2bE9aNW44bGtaSXdIVW1DY1NL?=
 =?utf-8?B?Y3JMeEpONHQvNnppNnhFU3ZZNlpUaFQ2Z0pJN0RLNlJuR0xFNUVZbFBSUmVZ?=
 =?utf-8?B?S0kxZm9jYURWUmlGVzlucjhhVExKL0dHQlMzRlptWHdpNFgwODBiT21FdGk5?=
 =?utf-8?B?N1JoMk0zYm1Vc0FEb1ZuZ3RHdDJSZjN6aDlFSWJST2pZQm1PWTNTajhoWFdY?=
 =?utf-8?B?Y1I4d3F3dWJRZTdlcVlxZUFXeHYxekt3WW5mREdOczdlNlpvWjYzL0tWTTB3?=
 =?utf-8?B?Q2EzcTc1aFh2c0hXc0VIOE9yVGorSDJlMmFtMnlqdUVMWWFORUtwMXBmVGJB?=
 =?utf-8?B?OUdnL1UzaGRaaSt5emNPRzFrcUd5L3RnVWxZemJxbXpWSk9vWmlSQUJrVHhR?=
 =?utf-8?B?a0lUWjZWWnBGR3FaVXlyT1ZDakl0RTJGb2FSTXk4R1JMNWpKS0Frd0JscUYr?=
 =?utf-8?B?V0hxbXdnVk84RTJNbGxQRlhFc2hTNW5rbERzUkNDRjgzRWVlV216UHoxSkZW?=
 =?utf-8?B?dDZkeGRhVDdsV0VSWjBCaUJxWlVqWndDQ1g0UmRHUXMzODNvRkt3Um5TU1FD?=
 =?utf-8?B?aXpPRW43TUVESWdORHZjdm5YbXljUkJmL2Rra1BETm5sWWs2N3R5S2NXVWIy?=
 =?utf-8?B?Nk5GQkszZVJhdHNnR0RMclJHUkNQTURMb0R5cnpQZWNnNENRQUh4RTRzdjI2?=
 =?utf-8?B?WFErTUVGMVdSZGQ4blowQlBWenBDK2NTWmQzaklCa05VSVNJaGUzQ3ZhZHJ4?=
 =?utf-8?B?bXVCcFdsUndHRWJSbG4vU3FzaXJJNGdVWTl6WkVtZ2lkRXd3L2c4Mm9FSUJk?=
 =?utf-8?B?YThEYk9oekw2VndpNmRROFZiYXVzTmVsZkJzVHhPblYweUV0bjZGanVqMkRs?=
 =?utf-8?B?MXl2c0EvckswanR3eHFldDhMcnYyd2JyWFY4d1F6VzMrUWVPeWMzc2dEQldW?=
 =?utf-8?Q?N8LRf8RXUtctpPua7m8jvfpDJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515832d4-818f-4c53-20f6-08dcfdf31450
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 23:39:23.9065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lllqdhIp/FvfyhVoVGThs1S5MP2j+5f8BYF5caXhOiP/LVXS5F7k23oB7k4i+s+Hj2GGkIiUTKKkdyt9N54liw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4837
X-OriginatorOrg: intel.com

PiBJIHRoaW5rIHRoaXMgY2hhbmdlIGFscmVhZHkgdW5kb2VzIHRoZSBtb3RpdmF0aW9uIGZvciAw
OTkwOWUwOTgxMTMNCj4gKCJ4ODYvcmVzY3RybDogUXVldWUgbW9uX2V2ZW50X3JlYWQoKSBpbnN0
ZWFkIG9mIHNlbmRpbmcgYW4gSVBJIik/IEFzIHlvdSBtZW50aW9uIGluDQo+IGNoYW5nZWxvZyB0
aGUgZ29hbCBvZiB0aGF0IHdvcmsgd2FzIHRvIGVuYWJsZSByZXNjdHJsX2FyY2hfcm1pZF9yZWFk
KCkgdG8gc2xlZXAuDQo+IFRoaXMgY2hhbmdlIHdpbGwgY2FsbCByZXNjdHJsX2FyY2hfcm1pZF9y
ZWFkKCkgd2l0aCBwcmVlbXB0aW9uIGRpc2FibGVkIGlmDQo+IGl0IGhhcHBlbnMgdG8gYmUgY2Fs
bGVkIG9uIENQVSBpbiBtb25pdG9yaW5nIGRvbWFpbi4gV291bGQgdGhhdCBub3QgY2F1c2UNCj4g
TVBBTSBtb25pdG9yIGNvdW50IHJlYWRzIGZyb20gQ1BVIGluIGRvbWFpbiB0byBiZSBhIGJ1Zz8N
Cj4NCj4gQ291bGQgeW91IHBsZWFzZSB0cnkgb3V0IHRoaXMgcGF0Y2ggd2l0aCBDT05GSUdfREVC
VUdfQVRPTUlDX1NMRUVQPXk/DQoNCkhvdyBpcyB0aGlzIGFsbCBnb2luZyB0byBsb29rIGFmdGVy
IHRoZSBzcGxpdCBpbnRvIGZzL3Jlc2N0cmwgYW5kIGFyY2gvKiA/DQoNCklzIHRoZSBmaWxlIHN5
c3RlbSBjb2RlIGdvaW5nIHRvIGhhdmUgaW1wbGVtZW50YXRpb24gY2hvaWNlcyB0aGF0IHByZXZl
bnQNCnBlcmZvcm1hbmNlIHNlbnNpdGl2ZSB1c2VycyBsaWtlIFBldGVyIGZyb20gb3B0aW1pemlu
ZyBtb25pdG9yIGV2ZW50DQpyZWFkcyBieSBiaW5kaW5nIHRoZSBtb25pdG9yIHByb2Nlc3MgdG8g
YSBDUFUgaW4gdGhlIHJpZ2h0IGRvbWFpbg0KdG8gYXZvaWQgSVBJPw0KDQotVG9ueQ0K

