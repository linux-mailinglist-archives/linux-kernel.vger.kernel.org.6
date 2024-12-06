Return-Path: <linux-kernel+bounces-435289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398569E75AA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3FD284F21
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F9120B816;
	Fri,  6 Dec 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cX3OOby7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D4A7081D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501735; cv=fail; b=NXZcTna74DtnbWzCwn/jIYTBtmZ3c1Si1EQu1YcBG4taLFFjNpO4ngUp2uwl9FKrX5CtuZ0xJFowWn5wwZn9fQWjzI4BcdZ2PZJRaVJkLT4EG4/F4PZjmIxoBG95I7V3xqvkFyQ7gGdlNJRj8+g4Qec8huW5NTENiHZTMDw+meQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501735; c=relaxed/simple;
	bh=a/87uCg2m+gjatiS/+rglLQJ75WSRZkV5cd7kyyN1Ac=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ryYtkUzjGbqC5DHe3kTdi66mEzGmmEN1teT4tKUH3u+EFDtit5PascjlhJ8CrCsc70f9kNQMnf2qBGZLBFFjXmpbNVn162vKKlpIqRrsgrgaodjKN/kaXQS0QE0M3IRKFhNUYLQPqtjYut6sniW35kflq4Q5lSJePyIlBGhiWi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cX3OOby7; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733501734; x=1765037734;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a/87uCg2m+gjatiS/+rglLQJ75WSRZkV5cd7kyyN1Ac=;
  b=cX3OOby76C7yiNfQQUCFT0M4+kWgAnGR9CDTll21Mn/oOrK65pr2y9Xu
   dsuppStLefeeI/sd/7j+u8QUShsHfYJim2YFockd6qX5HjYrsC54ocxpn
   uHzsxWGHFM2311i9j89+ewvAYs7Rz5agS202+o6Rx6W50DHIYzHnxcthG
   s2qe21LMmMXVy9xKwQLUOHDbYoEqWahgFXjfOYsEROsMcDB044wpOLV4V
   /TrbsNnwH5KQQNhwB9fGoMrxoFQ6LDEiR4qjDvBo5pwkC0gtPWKun5SUB
   BgBli3Sk8zYXwPfX9Lk1c1v+pDnmoPwBmSpsp9QwvCJPiu3ilUg2hHeDO
   Q==;
X-CSE-ConnectionGUID: YqfaUiYLSGamCwNbpAGM9A==
X-CSE-MsgGUID: dqsU5XwYQfWUFSbGljB4GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33740717"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="33740717"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 08:15:33 -0800
X-CSE-ConnectionGUID: HHthowaNTu2l0z6lyPXzQQ==
X-CSE-MsgGUID: 0f3jgpG9R/ObfavGgfE8Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="94539436"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 08:15:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 08:15:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 08:15:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 08:15:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDOXdD/+xrr2cDkXxdg3tX7Fns+BZe63HjaZPBv9lfviRuQQiFh/oVg4AtMR7PZKjyPRJ3TMsph9yfY9/6279iAHVn6H41BEOUOH/xj3f/FCWW+lDuzJ2Oz/bphYEBNh0UjdpcOAiAmRmbDwfAnNjyoEQxDtrRsVOpV+YN5fCkQWChACpJmaMmjzyk/cyHdvW4kQPVQvlO9e3xWBum/MwzVxhVjIJdcWcosMLnD26bmzlUySp1mH6wTlKwUnsHTScnL9oD6WoyYUDDRPFckS4HMWG3F6vqbfwB1RAL8MwSj6GhQEwVxJK1BuekCBgUM6lxvXPGaW95E5Kf2Rr+LCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZmnTOMtYvnZFxQhGzjZXrnWbZRllLJiBdE2R1/PnoM=;
 b=TtcA5kNwTTk1Geih/MPS0TJeRBD4jwKAKRE1ZXFrRVu0ZGLeLlC7qYMQczCIeO/UQ1oGfnP0A34qRamtqGGay6Av15MtTT4oxw7L0oOp3LFtBwVLAl+G3SD6xVxKQHFQmG9d5UYBoF16OUYfea0TBsxIwONegXSZI4dyjC0pecIN+dXUFBc3xtCu4ult5Ytiwp3RuiAjBBYWU821iq8yCU05yL/KEcZMNSXZR4XvDpcD6gT0nyYVWQQ2ZsG8kO2MhqdXEIzK/FAHgJcz2YfpEApC4dhwtAIL9Cv8Nm+HM7UHVDbYZHt1ZtACR74Qwb2ROOzpJspy0hKw52WoQjX2aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6503.namprd11.prod.outlook.com (2603:10b6:8:8c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Fri, 6 Dec 2024 16:15:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 16:15:00 +0000
Message-ID: <46767ca7-1f1b-48e8-8ce6-be4b00d129f9@intel.com>
Date: Fri, 6 Dec 2024 08:14:56 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v1 3/6] x86/resctrl: Disallow mongroup rename on MPAM
To: Peter Newman <peternewman@google.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>,
	Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Uros Bizjak
	<ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, Babu Moger
	<babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, "Maciej
 Wieczor-Retman" <maciej.wieczor-retman@intel.com>, Jens Axboe
	<axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen
	<tandersen@netflix.com>, Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave
	<beaub@linux.microsoft.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	<linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-4-peternewman@google.com>
 <4a6b1645-c72c-41dd-a455-bdf0ec57d4c5@intel.com>
 <CALPaoCiH0CZgEL8UQZeTrRtV_b-Oc6JyvaG4+txuZzsHCv976Q@mail.gmail.com>
 <CALPaoChad6=xqz+BQQd=dB915xhj1gusmcrS9ya+T2GyhTQc5Q@mail.gmail.com>
 <2214f589-03d5-4037-8997-bbf78077a101@intel.com>
 <CALPaoCgSO7HzK9BjyM8yL50oPyq9kBj64Nkgyo1WEJrWy5uHUg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALPaoCgSO7HzK9BjyM8yL50oPyq9kBj64Nkgyo1WEJrWy5uHUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:303:6b::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6503:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b0b43e-219f-41b7-f605-08dd16112232
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rk9WK1ZkOHRsWFpFQjhJWlZqWHBHRndwSlVUdDJZNEdETkowVTFBdTY0dlVQ?=
 =?utf-8?B?Ylk5S2txNEpaditaamFZSHI1eEh3cmxkcytybTFuZDF6MWQxeVR0eWJRL2ll?=
 =?utf-8?B?VXdlZlArelJLcXFhTW90U0VHUVFjUGNrb29DNGZQaldGZ1BlMjBrMFZVT1cv?=
 =?utf-8?B?TGIydWViSXkyVGt4Y1M4a0tDaDdEL3M4Ty9keXEwTzdzVkdhc1dZZTNsSm9p?=
 =?utf-8?B?cXM2Vi9VN25Bbi9neXZ5SWZDK3hBSkhKTlVYWVRJSEU2VnozSmxKSW9WZ2RS?=
 =?utf-8?B?N0JhZ1ZLa2k5SUg0bEI3eGhFUUptRmJNRHI1WW1LdU9yWm1Ea2NXR3NrQVNP?=
 =?utf-8?B?d01UakNlOVlCOWl5Ymc5UEh1WXNZbUJaWm4wYitFZmcyeDhPOEZlQVNISGtZ?=
 =?utf-8?B?dExEeG0rY0dqT2o1OURmYXFrTnNidzZ6Y3Y3NmFtMzRXTnBTTitQQmx2SENR?=
 =?utf-8?B?N2RRV1NyWERkY213NDdZRENLMHQxdE1neVMwZDU4NVdiQmtiRU9hNzVUbEpK?=
 =?utf-8?B?VTRpQVdTcERYSXhtaFZUcmpQOUtsNm9UL2UwMElBRTJFOHd4aFp0QmxDVWVP?=
 =?utf-8?B?YVlDR0dFNUZvUUVwejEzSXZFczRUclZXQlp2a0FaQkl0ZXM2VzdxVDNxVGlH?=
 =?utf-8?B?MnV6VEU4L1lyaXU3aFQvT2JpWHYrZGdvTTEyNzBHOXJUbTMxWTZSd1FlZnRp?=
 =?utf-8?B?QmdyZ042V0wzL0hDUTR5bTh2RGdmZ3VmQWp2bmlKcHRldU5TWEVJSTFVMmJy?=
 =?utf-8?B?SmRzMm95bzRWemN0Qjc3NHFqWFVmVmZJRHlqakh3VFgzNmVIMjh3MlltZVM0?=
 =?utf-8?B?eUQ4cFpmejNQVzk4M2dJbndRMklUWTM3MDNNTGRtVkxkUTM1c01NWGw0K01M?=
 =?utf-8?B?emtPSFlsZzI0MkRTWVdYS1RKbHJmbkxFTWZUa1l5akFRaGc0Q0h3OGFTWGJW?=
 =?utf-8?B?VmRncG55RTlXMTEwUTBRVjFwZUY3UzdLNGg5QlpMUHcyN0RKaVJvV0VEYVhB?=
 =?utf-8?B?NFU5V0xva2VoL0JYYVRjU29mN2htbHdzbzJUVERNMEdPeFYwOVlndDNXdXda?=
 =?utf-8?B?QmF0QlNjd2QxRlhaS09VUDlCbGRwSjJtYWlnSHA0N3hOcTdwUGMvektuT0g0?=
 =?utf-8?B?UHJyZWUwOFFyK1QzTmdrbGdJSDVZeTRnTWRzQjhGS3FzS2pyK3NFQ1dBQ2dy?=
 =?utf-8?B?L05xUyszbm1PWmlRYUYrK3VpVXkraDREZWhVNmc4RVhnd01iMGs5Z2piaUsr?=
 =?utf-8?B?aWlHSnN4RVA0bFRvaGtGQVpkSHYrc0MxZVdEaGEvcXRmSmM4WXVMT1Q5cTh3?=
 =?utf-8?B?MVdXSmJnbytidVJac09uMVo2ZjhJdDQyc1NWZmczcWJlSUhLZFhzQzlKNzVH?=
 =?utf-8?B?aE9GMTd5R09ITU5XNnJXZTFIMml6YVRQc1JtbWxoUGI4cUNaWkl5T3QxUkxw?=
 =?utf-8?B?Q0VQNGtSdFlXY2V6V0ZtcGViUW4xL0syNWNRVGpRblJ2NXJUYmZzclJSZUdo?=
 =?utf-8?B?Z2tWdDNncEg5cWZiWTgwL1pIeVFBcloyOEJRazU5cjBHUTMyeC9UODdEMFYz?=
 =?utf-8?B?aFlvV2J3YVpNRXczNVhpc3l3WkJJZm9qTWZhc29kajREaDcwQlI0aUFBUXhJ?=
 =?utf-8?B?Y3RrSXhvVjJpZWZUcGRXMEVEYTNGblpWakFNZDI1RnlBZUpEellQbjVGSDRt?=
 =?utf-8?B?N0hnWDhTREdaWXo0NDdRV3hWZG1CbjJNVHpKWm9iQ1dNRHFhMXRSTDNXK1NC?=
 =?utf-8?B?VXBFcVdaV242aTRhLzRMUSsyVTJoZVZMVUh2Y3RRM2ZxdkxpSXcrTFpxVlNz?=
 =?utf-8?B?eUNhQXBaMWRySFIxSkJsQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFVHUm0rWHlMTGpMSG5ZZDJYR09oTzdnSnZaWmM1Q0FXaVZwd09mQ3Z2Nmty?=
 =?utf-8?B?clRYZzhqMG53Qm1zdDNlQTVadWdITjA4OU0ycys3VkFuYzJlOTJJdjlRcTQy?=
 =?utf-8?B?dzAxc0RFZktVQjY2cXMxV0JIVWZTU3M5Z3YrMWRqSDEvL0l1d1lzdERWazdL?=
 =?utf-8?B?R05qY2tremJIOTZja0I5dVJuTUU1QTV1VnYvdndMbVRNRXg1MWhSSFFWKzB6?=
 =?utf-8?B?Q01kclVsQXUvYmlaSkNramtSeTZ1OXludloyem1rY3haVS9sMWozZkxNa0x1?=
 =?utf-8?B?a1pWWG84TzJoU1RyWVhsNDNwOGY4Y3VOeUYzRWxyUGlhZkpxc3laV3VyMndB?=
 =?utf-8?B?UDZwRzVpZkgrQlV5ZEZ6WjBMOExQeVlCQ2prM3lnTEVSeGJjT0N5RGxUN3Ny?=
 =?utf-8?B?VHdtZFlZRHh1V0VGNUlEOTUrODNJcWlzRFJrM3VpUTRPc09sNUFjR2xrZm9Y?=
 =?utf-8?B?R2hOZ2tqbHByaUJDalF1MHJ2d3ZEcXl5cUpPS2FWV0hyb0xLWnJiTTJIeGd2?=
 =?utf-8?B?TW9acGFmSkFXQVNjdnZHMXJ4RkVvY1lHNkNzMnZNN2F6VHp0Wm5UR0xudVlC?=
 =?utf-8?B?dmdyM2JFSU50VDlyRFc0a0RwSTMwVGEwY0ZNZFRFeG44WkxZWExRbnJKMXZm?=
 =?utf-8?B?TTB1RFYzbnJUcE4xTlBoazRVS0paNVRnUS92ZmI0ZllFSnJFaGtPTUZ1TWxG?=
 =?utf-8?B?QmFPOXFwQ2tiVjBQWWtpRWZDZ1lJa29ReWgvV3AzRCtCajQ5eWFHbGZleVMz?=
 =?utf-8?B?ZXRtZmhWWjY1M0pHVzU2c1V4OXFQalV6bnJ3QmdJQ201TmExejBENXVETnlt?=
 =?utf-8?B?R1BIWG1LQUttUUVHdWthLzhXd3B0Q0xRbjhJeG05WllteHl4WTBRM1IycEJN?=
 =?utf-8?B?T0ZuSUxGTjlEMlVOa1g0dzZJVmJCL2ZBMm8yZkVEYWFBYU5OTWV0YS9aQWd4?=
 =?utf-8?B?YUhCYmMyRFNpMysvRmk2NUlPOEJ0dEUraUdBTGZiU3hUOEd2SnQwdXhuSGdk?=
 =?utf-8?B?bTU3Z284V2UwTGMxRWkvWHord0tJT3BLSzJ0UTdpbDA4b0IyK0FSeFFDSzNp?=
 =?utf-8?B?amNYNTZmYjhZZFNtYjZHbmNlRXJiVUdNbTNkVFFRcDF0cDZWSk9iYUozWXlI?=
 =?utf-8?B?VkV5SHJhMVhLSkF6NjRBUkpRQlZRaGR0MVRwSjVEY1VkNFFiNHJXTnFiVWRy?=
 =?utf-8?B?Wm5rNHF0R2lTeGM3eVI2OEZ0L1VGNVNMcDYvSTdUOTg3dStaQ3dPNlZHaTk2?=
 =?utf-8?B?QUNRNkVwSGVGbjJOVys2cHJ0SE8rSExFdTd2UWtOWG1oeGVzWlVYb09MTmFD?=
 =?utf-8?B?UHJLaHJuWlRkQVp5ZmNyTnVDYjY1dFFxbU94N25nVzRTdVROODlwWnQwVEFF?=
 =?utf-8?B?Z2xjVDlLYUV3djNHNGZvOFFBL3VpZUM5SlRGQnRNUTNKKytyVjdVdHlXZlRD?=
 =?utf-8?B?L3Y2dTZrQ0ZXbzZCekpETXFKa3ZwSXpETGdtVFJUckNXWUVUNHFIdTFhYmJi?=
 =?utf-8?B?Y3pQUmZVS3RyMTZHbVh5S2V5M0M2emxDN0dNRzVIancwUm0vZlBFU0pGNkli?=
 =?utf-8?B?OUV4M0JxbzNZMjNnNVpxUmU1ZFkwWlJsRXJndkhubkRaSUxDOFlEZmpibGd0?=
 =?utf-8?B?ZVhZdmVjcTlDNEgxQU0yWkxWK2Vvd2hTNjMwRVdSd1BJb203dzJWdEFMUndv?=
 =?utf-8?B?Y3d2NG03a2JYeHJobzZnNkh0ODluTHhseGJNWUw1YnZON3JnR3U3N0lGaWda?=
 =?utf-8?B?QWg4UFNhY3lrMlZ3bkQzUzNNY2ZiSjJCY2QwMWNFbjlHZUtjUllQZ1JFNklQ?=
 =?utf-8?B?N00rT2NqWVl5dWNZbHNwRUsrRk9GeFVHK3ZhRmhTam54NktIWStCRWJJaHNM?=
 =?utf-8?B?aUc2bnBhamc4VnBCWVJuQ0ZGSTUzcTUzeUlNY0QvZmxsQU43U2EvMEVvUTFs?=
 =?utf-8?B?RnlNdFhHbGpiMFpPNGxZcG16Vm9GZWw2MUt4Z0ZZSDJCVHc2M090M01LWnpN?=
 =?utf-8?B?eWNsalcyVzRyMWo3L01iVk5sc2VlTFAzQzNCaVJHUEJ1Nm9yenVvalNEMVhZ?=
 =?utf-8?B?TncrQnkycHRlZ1JkaElicFNuYm1VK1I2YkptUDBwTlZwL290Zlc1QUxzWEVx?=
 =?utf-8?B?MkxkOWVXZllJUE1sU2ZMZzhJdFc5Vk9qUFljZ3J4a05PY1hoRTU2U3NGMks4?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b0b43e-219f-41b7-f605-08dd16112232
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:15:00.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jabEfF7h4/eIHUGxnxJnF/Z6wybN6hk+o0Evpy7Z6BJhCpjLDc25EFloUK61oV992JlygIE3uV1Py2FzadcvgaCStyDCXFoRuWoBr4wl6/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6503
X-OriginatorOrg: intel.com

Hi Peter,

On 12/6/24 2:23 AM, Peter Newman wrote:
> On Fri, Dec 6, 2024 at 5:14 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 12/5/24 7:03 AM, Peter Newman wrote:
>>> On Sat, Apr 6, 2024 at 12:10 AM Peter Newman <peternewman@google.com> wrote:
>>>> On Thu, Apr 4, 2024 at 4:11 PM Reinette Chatre
>>>> <reinette.chatre@intel.com> wrote:
>>>>>
>>>>> Hi Peter,
>>>>>
>>>>> On 3/25/2024 10:27 AM, Peter Newman wrote:
>>>>>> Moving a monitoring group to a different parent control assumes that the
>>>>>> monitors will not be impacted. This is not the case on MPAM where the
>>>>>> PMG is an extension of the PARTID.
>>>>>>
>>>>>> Detect this situation by requiring the change in CLOSID not to affect
>>>>>> the result of resctrl_arch_rmid_idx_encode(), otherwise return
>>>>>> -EOPNOTSUPP.
>>>>>>
>>>>>
>>>>> Thanks for catching this. This seems out of place in this series. It sounds
>>>>> more like an independent fix that should go in separately.
>>>>
>>>> I asserted in a comment in a patch later in the series that the
>>>> mongroup parent pointer never changes on MPAM, then decided to follow
>>>> up on whether it was actually true, so it's only here because this
>>>> series depends on it. I'll post it again separately with the fix you
>>>> requested below.
>>>
>>> I'm preparing to finally re-post this patch, but another related
>>> question came up...
>>>
>>> It turns out the check added to mongroup rename in this patch is an
>>> important property that the user needs in order to correctly interpret
>>> the value returned by info/L3_MON/num_rmids.
>>>
>>> I had told some Google users to attempt to move a monitoring group to
>>> a new parent to determine whether the monitoring groups are
>>> independent of their parent ctrl_mon groups. This approach proved
>>> unwieldy when used on a system where the maximum number of allowed
>>> groups has already been created. (In their problem case, a
>>> newly-created process wanted to determine this property independently
>>> of the older process which had originally mounted resctrl.)
>>
>> Could you please elaborate why users need the information that monitoring
>> groups are independent of their parent ctrl_mon group?
>> I understood from [2] that Arm can be expected to support moving monitor
>> groups so I am concerned about userspace building some assumptions like
>> "if the monitoring groups are dependent on their parent ctrl_mon groups then
>> monitor groups cannot be moved".
> 
> It's to make the high-level decision of whether ctrl_mon groups or
> mon_groups are to be used as the direct container of a job's tasks.
> 
> Given the semantics of PARTIDs vs PMGs on MPAM, the ctrl_mon groups
> will always be chosen as the container for tasks, so I don't have a
> use case for moving a monitoring group on MPAM.
> 
> Perhaps determining whether moving a monitoring group is allowed in
> order to decide whether to use the model that requires it is
> backwards.
> 
>>
>>>
>>> Also, this information does not require an active rdtgroup pointer or
>>> CLOSID/RMID. The following will also work:
>>>
>>>  resctrl_arch_rmid_idx_encode(0, 0) != resctrl_arch_rmid_idx_encode(1, 0);
>>>
>>> I propose adding a new info file returning the result of this
>>> expression to be placed beside num_rmids. I would name it
>>> "mon_id_includes_control_id", as it implies that the hardware
>>> logically interprets the monitoring ID as concatenated with its parent
>>> control ID. This tells the user whether num_rmids defines the number
>>> of monitoring groups (and ctrl_mon groups) which can be created system
>>> wide or whether it's one more than the number of monitoring groups
>>> which can be created below every ctrl_mon group.
>>
>> Is the goal purely to guide interpretation of "info/L3_MON/num_rmids"?
> 
> Partially, I suppose. It is necessary to know how many monitoring
> groups can be created.
> 
>>
>> The "mon_id_includes_control_id" seems unique to a use case and if I understand
>> correctly needs additional interpretation from user space to reach the actual
>> data of interest, which I understand to be the number of monitor groups that
>> can be created.
>>
>> A while ago James proposed [1] adding a new "num_groups" inside each "mon_groups"
>> directory, on x86 it will be the same as num_rmids, on Arm it will be the maximum PMG bits.
>> At a high level(*) I think something like this may be an intuitive way to address this
>> issue. What do you think?
> 
> On ARM, it would mean num_groups child mon groups can be created,
> while on x86, it would mean between 0 and num_groups child mon_groups
> can be created.
> 
> In either case, all instances of the file would return the same value
> at any time.

hm, yes.

The documentation currently states:
"num_rmids":                                                                    
	The number of RMIDs available. This is the                      
	upper bound for how many "CTRL_MON" + "MON"                     
	groups can be created.

On x86 the "upper bound for how many "CTRL_MON" + "MON"                     
groups can be created" is the number of RMIDs, while on Arm it is
"<num PARTIDs> * <num PMGs>".

It seems reasonable to have a global file that indicates total number of monitoring
groups that can be created while a local file indicates number of monitoring groups per
control group.

We could thus follow your proposal to start referring to the global "num_rmids"
as "num_mon_ids" that for x86 would contain number of RMIDs and for Arm would
contain "<num PARTIDs> * <num PMGs>".

Partnering the global "num_mon_ids" file with a per CTRL_MON "num_mon_groups" file,
where "num_mon_groups" contains number of RMIDs on x86 and number of PMG on Arm, may
give necessary insight to user space to make needed decisions?

I do not know what would be more useful here ... if expectation is that the
local "num_mon_groups" would just be the same value for all groups then it could be a
global file also (with more appropriate name). Another alternative is if it is local it
could be a dynamic value of how many monitoring groups are available for creation. This
may be complicated with the limbo handling but worth considering when thinking what would
be most useful to user space.

>> (*) If considering this I do think it may be more intuitive to have the file
>> be at the top level of the control group and be named "num_mon_groups" (or something better)
>> to support the idea that it includes the CTRL_MON group self and not that all monitor groups
>> are within the mon_groups directory.
>>
>> Also please keep in mind that during the discussions about moving monitoring groups
>> there were some ideas of needing to provide additional information to user space about
>> whether counters are reset on a monitor group move. I think that if we are starting
>> to look at these random properties as files in resctrl (like "mon_id_includes_control_id"
>> and maybe "counter_reset_on_monitor_group_move") then we should consider some alternatives
>> to present these flags to prevent resctrl's info directory from turning into a mess.
> 
> In the meantime, num_rmids > num_closids will probably be a good
> enough heuristic to correctly guess the ID model.

While it works it is not ideal how user space is required to be familiar with implementation
details. Interesting is that I notice that while the documentation already links num_rmids with
the number of monitoring groups that can be created, it does not do the same for num_closids and
control groups. Closest is the vague "creation of a "CTRL_MON" directory *may* fail if we run out
of either CLOSID or RMID" (emphasis added by me).

Reinette


