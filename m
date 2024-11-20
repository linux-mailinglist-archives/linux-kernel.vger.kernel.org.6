Return-Path: <linux-kernel+bounces-416264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346469D42A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88E9283B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAC41AE014;
	Wed, 20 Nov 2024 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJHdoRit"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695871474B8;
	Wed, 20 Nov 2024 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732131989; cv=fail; b=D9rjEgvDRIy7Si4nx4qsS1+Nh/W5CqRJXw6sP9xKKk5WmtkbwB7tTQTkrcMp4kmT15u9nNQ0laxLYLU6kbp3n5OgObpFZkMjHJWkXnLooF2P75e6KsFTZKxWvik8hpLhtA/zv5UmGfHe9ivEdh5ShgVrizBJFQ4cYFdemGpcjVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732131989; c=relaxed/simple;
	bh=BtXgOXd0rR31GTnWPWNGW/Hd8dIokmZgaYzoB8HOePg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F574W1QqFAn5k4xStkkcQVkzldOljosXQbu2TkygU1PmwluKe/kYDENn8+lF/OG0ifrDxOxzr/su6yztybPKe3hzS6Mwv/E0/xVSO8sUuTnTrle81KlYI2ffKRoSujzjcgbYgTejUIAim7Wf2jduWXP0TgiFom9CKbRw1pwQAL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJHdoRit; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732131988; x=1763667988;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BtXgOXd0rR31GTnWPWNGW/Hd8dIokmZgaYzoB8HOePg=;
  b=HJHdoRitsOP7i1sxdeypA6dGpCSoxqntd85xYsrHk2n6JoA/vBNj26TS
   pdA9qHLY3KqScruUbYnSRDxMIXB7MU9c+zL6SQ/j9RTe+jOZR55F3xdhm
   AxS4h1uKXNo8c+z4VG4McA1mGKR6jiCBm6Nbxxx85yUhcmi0EjT2E0WRD
   kF8Qo4hrKjnPaE18dhNrnuFzO72XwfM9w+OCCE5CimbQ8l+1xgqlUVGQY
   Vv7mUtiVBpwNo4B6+ABJAtQ6/n7gmVmgjqFJncmp28KtKJs5KNfckTJ+L
   X7UUPaBtaOX0S8D931c4E5/mQL4bUZPvNdqJksNP3fuHWzbajwenuNmrw
   w==;
X-CSE-ConnectionGUID: nNvfKuiqTUO3sqCgOA0Ncw==
X-CSE-MsgGUID: RQaeFyI5RpinjUpyGz1qKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="32143756"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="32143756"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:46:27 -0800
X-CSE-ConnectionGUID: 20iv90ZiSUyikEGaiZ61lw==
X-CSE-MsgGUID: cqNTSliyRdS7WbSdGGTaZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90423927"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2024 11:46:27 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Nov 2024 11:46:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 20 Nov 2024 11:46:26 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:46:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZHARYyuUr3kzKZRwQevQ8xBb7jZoMzzCGMnu3QbGjA+IF768+JxdTLwCnPdtL4z2R1GkFO3hhlPtHsAM1EYljvCKReEaM7gsnKZRBQ00XajfofVFxVx66hNkzqsOdQznV2AYb30to62EoU4Xu3teDuH5vYj6kenMl/kjCErPq/zsT+EUKCokRJB36VKkjSL6Y6u8bW/I/HQ1HgcNeyP5gGAQm0vsiSyev3BuPgRFuKc01EEixTg9Fbb+3rAYkv0t/9fKZWO4deZzhMQoEHq+FuTZtVRXNS6BGAPSet95oGxa9sfV7uWm/glA1AfZ0rwJIWd5LVDinwkgwcw6OOiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3S6bYCvtb0l34yioHy0cQAUC737tKsSUUI5HYaT5ok=;
 b=drdXPkuSd0+jiywn8GuccNMPKOEjNlZ3kPuMbjcOFVmNWJpOS+CyEajzhyl4k7geAcfcQ+CH0AmHuFe8v28vYzQo4IcsK2S4XKrWzjvwnbZoc1ORUtiOHQPV7fPb3aO9ShdBPtGonR87SYG7Y+3ItCpWLo3mvNn4nCIvW8ypg4qqfZhe4RE2MeAXyCjzAC5mkQwupI4FGlq02zaSt+Qr3e6qNrgmabKJ/H22KddrtP/0bkD7Du+JyKTSkNC70t74X/g7UoNvN63HVyfw26ipwOdms+OhmeTeQYEfJ+ysH9LG8m6roUL3x1ZySg9EJHh8qRsks81LDWP6EzpeO4aeXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Wed, 20 Nov
 2024 19:46:23 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%6]) with mapi id 15.20.8158.017; Wed, 20 Nov 2024
 19:46:23 +0000
Message-ID: <1932ef4f-b797-49b8-ab86-b687210c8778@intel.com>
Date: Wed, 20 Nov 2024 11:46:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: Merge x86-specific boot options doc
 into kernel-parameters.txt
To: Borislav Petkov <bp@kernel.org>, <linux-doc@vger.kernel.org>
CC: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Borislav
 Petkov (AMD)" <bp@alien8.de>
References: <20241120163033.12829-1-bp@kernel.org>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241120163033.12829-1-bp@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ2PR11MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: e28a658d-955a-4d6a-548d-08dd099c0369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXczWU1iZDI1QUxOY3ZmUHFLWm1ZYVVYMHJlRUpLelVCYXdBeE9GQ0dEUVBy?=
 =?utf-8?B?Q0FrdzZJajRGZW8yR2FSMDdqbFlhVUp1Mm45bmJvN1k3amovRTE3eHgyUWNW?=
 =?utf-8?B?NFo2QUdnVmlJNWRhcGJQSmVFZlFTT3ZJMTkrNy9BTXJCS2h1bkpzd3RSTS9y?=
 =?utf-8?B?bDNpSW5RTnJDYUV1WjdNQkJENkg3RXA3SVRDaG93bFFmNEY4Y1FDRzZvcnhx?=
 =?utf-8?B?Z3U1SXFKbjNpaFl5ZG5qMnU1ZUM4ajBTR0doLzdxK1NDK3l6YmZCVUNndEV2?=
 =?utf-8?B?ZzczcnlMeFd4bHBEWTJRWUdocWwwSjI1WHVLR1QxSk1YbkVmc2ltYmFuaWNi?=
 =?utf-8?B?MW9vY09wUU9CTk9XUUtCNlNoQmMvVzRpN3hVbWlPbmdyOG9GaFJhM0dnMHkz?=
 =?utf-8?B?amVESU5UMG95Mk9pZnJ0OVZONWJpUjBybUZTMFNJWVAwRkgrRTFpTGVSOGFO?=
 =?utf-8?B?QnJiMEFaelVwK2wyb0FId09GUEw1MWhqbERHcTd5MC9kOWMvR0RTWGRHWU9U?=
 =?utf-8?B?ckhzbVJKOU43aTBMUmtiTW1tRTJVMkJJUUdaZ200SlhWR0R1cHFsWmZienBE?=
 =?utf-8?B?OFpmUEMyeS9mVzVPYTEyekFOLytaTnVSb2NBQkMzSDMvM0F2Z0kvaGM4aVpO?=
 =?utf-8?B?a2lKQ3grOGJHaDdxM28xNndXSDFxeUluYWxUQW5UVXdwN0dkQVJCNzcvVlhY?=
 =?utf-8?B?TzdZakhzUzltbVNkMk9yT3c3eDZWT3VSNUR1bldVZnlvZ1RuSXZBNS95MEFI?=
 =?utf-8?B?c1JLbUNZTDFlN0EweTAvdkpZcXpqWjBYemFDNTJ5VkxRSmtHOWw1bjVIMmRY?=
 =?utf-8?B?ekRjRlo2YnJ6SFpraFBGMUdEdE42L3hOd1IzSXZvQ1VWdHBwRy9NSndQanpo?=
 =?utf-8?B?YU1uZUhjMGZFNit1Tm1YeUY3ajU1T0NLYWNZVG9RZXVpVE5BQzd6S2cwWTVY?=
 =?utf-8?B?TU1Kc2JXUVFMNEVtaWJZUXI1TEQrNGhKbkV2ck9IUjI4QkowZS9JOGszdkM4?=
 =?utf-8?B?QWdNR1RkdnA5bDcyUnRKYjN6T0VhL3A2QThvN3YvSjJVMm9UZXY1bGxQaURu?=
 =?utf-8?B?SUkwRVBkdVFyTFRFOFdJOEpOc1JBa09qZzh6R05JQVljbFpldHJoZmp3bUV6?=
 =?utf-8?B?Q3ppVFUzUXk0QlY2UXRtZnhlUS82Q21GSWZ1MmlPcDRDODB2bWNtNENhd2lP?=
 =?utf-8?B?WVBDd0JBaGxKVHlpOWtYbmM0VkRyWDV5dGtJVEROeGg3MkpoM2xmb2pZUlVi?=
 =?utf-8?B?ZzhvbkRtR1FvNkFyVE85SndJbC91WkZmREhhQ0VKMVc5NGxJK2dJNlBOTlVv?=
 =?utf-8?B?cDlXRlBmaFU2dCszazZDT2U2SEZmcDNKOEREZUc1dDN2a3UvQ3VMMWZVemc3?=
 =?utf-8?B?Mkl5L0hTWWpoRlVmdENkVUVYODA3bGdHU01LcTM0YTR6UVZOTzlJSGFKTXBl?=
 =?utf-8?B?WEk3R3JaNGZmUUFqekR0L3FkSFZYOUFlcWlnY1AzTC92YjZOYldUb1RxOFoy?=
 =?utf-8?B?OEtUZFJHbFgzOUdPalNWQ2FqM3hpeHo5ZlkvUDJWVkF0MXJVcGxlanpia0lm?=
 =?utf-8?B?K0d6RS8xazZLRHJiNHlwT0tiTXIwLy9tdlNjTUFENFF0bFFPaUtiSkdldFpK?=
 =?utf-8?B?OWJTNSthYk9HWFVqQis2SFllaFB0M0FkMS9kUXNtMDY5S2JnditUSkRiWnk0?=
 =?utf-8?B?cFF1QjVhazIxWWxUOE5BeHhZeTgzZUR4dHBTdG54cGxaY0szcHFFRm1RY3dM?=
 =?utf-8?Q?IVQ6fj/JNmtjxw8Y3HXtRBgiUFvImzhM37qjho4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djA4MHp6akVnblhjVHBtckEyS1JiTWJiYnVBY1ZUcVdJS2d3QTBHZ2JkTG8y?=
 =?utf-8?B?MmFMQzhXT1ZMSE5lWEZraHVRUDJURksvZEtIT3VDN1Y4bEpSVlZOZkxxSFdu?=
 =?utf-8?B?VXg2MDVHUFlaVUhvdzFUWVZLODB5UGlLUHMrQ0hYc1F2T2dUM0UxTVgxekU1?=
 =?utf-8?B?bWg3cEI2c2NuSjJkY3BWSEs1d3YwOWpkOEZGYkxRcStJNDVxUlowbG5uaXUr?=
 =?utf-8?B?bjFWc1lMWFUvbDB3eHVsbEJmSmF0KzJudTZOaURoT2lZSUI1K0l0OXJESnpw?=
 =?utf-8?B?ZFFiWmlTOUpscFoxd2lBSVVsMmFyajJNZnpUMWppMXplMnBLVXc3OU1PakZ0?=
 =?utf-8?B?R0tqWHBjYXNJdUJiM2JxS0J4ZjczU0VyRFBnbHVJQkdMMEFxM3lNWDhMN2tv?=
 =?utf-8?B?WVhSZTUrNUJZc2ZlOWZWWU52V1AzYkpGd0xWdVp5UnlIRjUwM0RsdlpOZ3lh?=
 =?utf-8?B?T1FSMGtCaHNjOTh0Zjd2Smd2VzdmOEVWdDlLUjJiYzFXdGVBV0JoWFBlcFJY?=
 =?utf-8?B?c0JFUEVGUjJtUGt6TlQrU0laNzA3OVZEMkVvZHIxWTRLSFM2cjYvcWpsYkJK?=
 =?utf-8?B?Q1RMNW5adGhlQkE0QVZKeWR5N1RsdDZzQWZmY0p6YmZoSmo5SmY3ZG1zN2ln?=
 =?utf-8?B?RlkxMkprQlowSjNWclpmbEdjMkhxdnNRMlI5ZnNLY1NKSzk2Sm9YSHNCZDVl?=
 =?utf-8?B?RG8vK1YvYVVGQmdqeGZCMTZ1MzVQQjBoR211NjdqaVNMOXpDUE9PK2tmYmZn?=
 =?utf-8?B?SlBLam1sc0dnZEpBNE9nWWtVdk1mbUNrYnN2NGxCUnpOVXhHY3BDWWRJSXpX?=
 =?utf-8?B?SSs5anZCVjQraEQyQUVJUnN0L0xtRWc5UFlxTHh3T1dYaVU3MHdJdnBRZWY1?=
 =?utf-8?B?RFhqcGwyT3h4T1lDTjhaZkpNQ09KWWVmQXVHNXIrTWVQK1BOMmVuVHZXa2t4?=
 =?utf-8?B?RmdqVWcxdTZwOWl3RXJpakR1Sk1nbUtXbk5Lc2p6MWhKMFZROUpKck9GZGlr?=
 =?utf-8?B?bnJBYmMwRzI2OWlPeU1QSWQxQmtnSlgvbm4rS1B6UitjZnlCT0hrT2FXbTA3?=
 =?utf-8?B?OXVGNkE4dXZ6aE1tNUNzSVpZREROWkxHRXE0enRoZUpmSWc1MDRpRlpqWkth?=
 =?utf-8?B?bWpxb3dPT0owcUh2aVNjOVZmRHRWK2FINHZWQmt6NzErYm42U2FPa3RZNCtu?=
 =?utf-8?B?a0ZiWTVBeDA5MndzaURvR2RtUGh5blNWL3FFOXF4WnFrTHVWL3N6eFh3LzF2?=
 =?utf-8?B?S1hDeDRwQXEzTm5vTEllV1ZPU2ErYjR5ejhWUUpMejdSN1MwNGd4Qmt4K2JP?=
 =?utf-8?B?cVRCc1d5Q1c5Uy9zcVNQQ2g2SXdoTU9RaUE0YjNWSTNzWGhtdjZidWdUZG8x?=
 =?utf-8?B?UkJ5MlNwSkxlSWhGOXdSYlI0WFhGYmJ5M294T3RqTFh0MThUWHJqSGZMaXRw?=
 =?utf-8?B?QjBoazVrcGRFWWlab2RSeEgyMk9LWUdZRmJweEtYc2ttVFRzKzQycXhyYmNt?=
 =?utf-8?B?UEcrWk9kQmdXTnVMVTFRR05WSzNiT0JzOFJhRzlxd08zU0pXSnFURnRIUWov?=
 =?utf-8?B?NGJLWFhiWjNyRDNSNXFRTC9KRVFsMjYwL29uVS9lbDBjM1dkOTV6dExNbDFV?=
 =?utf-8?B?eUNVTCtPUk9QanR0OHhlUFFoVVJNZ2NHR1ByTWgzMnN4amhVRnRxMk1ORUNq?=
 =?utf-8?B?R2w0dnFVL3lqL3BkaDZpaFNsL0NCMFU2ZXFTa3ZxNm01RU1xRzlhbUVKRkdP?=
 =?utf-8?B?MGdQZ2drWmQweXFBSmJ6Mmo4bUVLT0VaSDJSaFVoK25OTUZZb2NXQ3IrbVBj?=
 =?utf-8?B?QVhwaEplSFN0WTk1cWxRcFhBTkRQQ011L202cStxUmlTcS9CZmd0ZDUvVWUx?=
 =?utf-8?B?MCs3K2dnQVgvRTBTOFJqZXZ5RE1ZRkpqRkVrQjlZRlUrTTdwNmVxcENDSWlH?=
 =?utf-8?B?NmdtbFZxZ0lXTjIzcDJTUWppZlg1bzhWQmd6LzNKbGYrTzYyTDdMVGpBZlVz?=
 =?utf-8?B?TXZ1QlBaZ0pBWkJ3UFp0NVpsL2UyWTNRNm4wcXd6N0l6MzNHT1IvZjRUa1F1?=
 =?utf-8?B?bG84RlhCcGRTYlJEaEd4L0QwMENNVjdJZzFGVUlqaWg1M0RlcDA3TklVMlJG?=
 =?utf-8?Q?Bz/O4TcQqmS1yR3Zs+b4+HpJ9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e28a658d-955a-4d6a-548d-08dd099c0369
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 19:46:23.4950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Rkq8BrzBt2VFkMwxos0s3N6fenGcfjL7uC1asaxvcFQnv8T0P1y1iwV114yNJZFoq/A6pF8GBH9Oat9jHNPAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8451
X-OriginatorOrg: intel.com

On 11/20/2024 8:30 AM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Documentation/arch/x86/x86_64/boot-options.rst is causing unnecessary
> confusion by being a second place where one can put x86 boot options.
> Move them into the main one.
> 
> Drop removed ones like "acpi=ht", while at it.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  .../admin-guide/kernel-parameters.rst         |   3 -
>  .../admin-guide/kernel-parameters.txt         | 214 ++++++++++--
>  .../arch/x86/x86_64/boot-options.rst          | 312 ------------------
>  .../arch/x86/x86_64/fake-numa-for-cpusets.rst |   2 +-
>  arch/x86/Kconfig.debug                        |   2 +-
>  arch/x86/kernel/pci-dma.c                     |   4 -
>  6 files changed, 194 insertions(+), 343 deletions(-)
>  delete mode 100644 Documentation/arch/x86/x86_64/boot-options.rst
> 

Remove it from the index too?

diff --git a/Documentation/arch/x86/x86_64/index.rst
b/Documentation/arch/x86/x86_64/index.rst
index ad15e9bd623f..a0261957a08a 100644
--- a/Documentation/arch/x86/x86_64/index.rst
+++ b/Documentation/arch/x86/x86_64/index.rst
@@ -7,7 +7,6 @@ x86_64 Support
 .. toctree::
    :maxdepth: 2

-   boot-options
    uefi
    mm
    5level-paging



> +			triple: Force a triple fault (init)
> +
> +      			warm: Don't set the cold reboot flag
> +

Whitespace error here: space before tab in indent



