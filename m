Return-Path: <linux-kernel+bounces-539756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC67BA4A827
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344E07A695A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004E78615A;
	Sat,  1 Mar 2025 02:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNXnqDRu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0423C9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740796663; cv=fail; b=G5fN98LzCdqfalWtCRxHAjGEXFRJl6RLpstY1rDpnAb/y+JNsAMgUjuOZILeE5gwJG4RW448bNNo/druZL4ItDGRUc2bkQ99nANFBG9rSjZlPJoRpMHPsER+MwnNra2MhAsZZ++SS6CVY9qgfa9kZ2kNbgY5BwII/3P2V3TEswk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740796663; c=relaxed/simple;
	bh=Zx5sZDAezVzmWEo7etFB+2DqBorgQJoy/Sf9iTfvlws=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RGdQ1hwbEb8gdyg8RCnaZ+Ol7ltBEXZqOA0oChRRVnN9+x0GcqBVfklZ9QMmkj/ZTlj8d+UIBw/iBJ7IYvGh+WiIBtRWdzysa65mHhC97T+eaTI9xbrPYkzL4FKa9kW8NiaYYxPPu5hvjLZG0akbveQm1ebOwXcLFCr/C6+l074=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNXnqDRu; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740796661; x=1772332661;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zx5sZDAezVzmWEo7etFB+2DqBorgQJoy/Sf9iTfvlws=;
  b=NNXnqDRu3uWxJzfDk8u48WBML8u17SP6lg+TEp6DE+W327PA2eWWD8GZ
   Vq/J+oVKWhOPoFarCyqORH2CbuvYk89iGuqMbSw0EucD8EzgAEXjtJ5v5
   E4p1PmvOw/7TSGtMh2D1KxBGPIq32WGJohRv2G8xCqT6WG9/6544qdgtW
   GK29LY9Asd3CQr5+dcNocxeC+HMMNfGIUUO53JXfcqUbGkIWvnU0RVXj1
   58065NjsF2yvkR6FBMOGjEY5+Q5avUJu+3YRuxnjQtFUhWMVANASnj8xN
   Wv1qZGgqxOTPlolfmF28LMzOEcdNVFvchG2x8f5opbJR06mmaqhCFt+gp
   Q==;
X-CSE-ConnectionGUID: XUiJcm4fSCW6Ntth+C00LA==
X-CSE-MsgGUID: Jb8IECFzSauhlDshwYHUog==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="40910433"
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="40910433"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 18:37:39 -0800
X-CSE-ConnectionGUID: SNuIHmncRp60poENJmROaA==
X-CSE-MsgGUID: Xwbvz22+TvulBgdZWv24tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="117281721"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2025 18:35:10 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Feb 2025 18:35:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 28 Feb 2025 18:35:09 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 18:35:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bICGAzQoVb7UelTVm3AVRdHfdQHTGLhubwEQ01NFP+Vcl8Wc07/0aCMyg1/yeZ6sLAijP5/c2hBiJw0i7ErReyIbbh7Te3f2C04txNO9Aq/PSkBhKVNzb1A/fPiKbnAphmleqDAb33J67ziNgWWwC+Z5kMWgWkDE/SsV/FDEskNn7QI6BfSUFYc+9sMsuuDdcQlUip2WeZ9GzIQJRfRPf9RIEKwdgnxFArxQHmWlnFEfnR6RVURHd0FtTBcu9tLS57LurRVjaA8j0RyqDfR4B5hqLvX3zCpOo+57LDui0XabXz480/QczjHh3Qo7p61RPadC/EW2mPyfTncNxfaRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlPasOCO04HHVO+bn3DwLy8IRKwPmoWdLOikUnixRu4=;
 b=QssWz/MPjugOxMqd9hLFf05mZzG3+iFmJlkruX84xMv9qBokCYiiN3WZZ7iV2b9bjelzPRSl7MjJczKOcxHVIVSSUXkLjxc8GPi//zJwM6ftXgCkwaPh2kZ1QOYo8LqMdQUYrCgdIf0TpEKmyOSNte5xIrEo8A2qkJcW9S5IwzxBva/DPFC3cdHAczORiig0ITGtdurQDAIZplHQqA5kL7kJTMQalpLir568vxIG+3X4MwP0WWt5ifLyGxv9+Qvb/r7ZwmBg2LW7f4CgG2prPDCzqrtyxX8s1gfidEfAWxeSau/aTuJcV74ibokvArJQ3zaO0jrTE3nBSoaKh+dFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sat, 1 Mar
 2025 02:35:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8489.025; Sat, 1 Mar 2025
 02:35:05 +0000
Message-ID: <c7e9f509-404b-48c5-bda3-ecff80f95242@intel.com>
Date: Fri, 28 Feb 2025 18:35:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 33/42] x86/resctrl: resctrl_exit() teardown resctrl but
 leave the mount point
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
 <20250207181823.6378-34-james.morse@arm.com>
 <91026839-2f2e-4562-aa77-6901148c89ad@intel.com>
 <b3317010-b8bf-46f8-a176-28f810fd9920@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b3317010-b8bf-46f8-a176-28f810fd9920@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:303:2a::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b93536-1a77-4431-ab3c-08dd5869ad11
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NURCRk03RlNlUk1iclVxR1JLaGpuMTZrNThFOUVUUkpNTXM1czlBRDJ6bU1B?=
 =?utf-8?B?TkVIVjNkRHNUUTN3T1pneWhCa0xVVVVMNnRNNy9YRmRZdTVRc2svb0oxdEhz?=
 =?utf-8?B?WDdTTnVaeGZQd2JkZlk5enc1ZE5HUE5NcFlSMWdnUnpBU3NZUWlud1UxOVUx?=
 =?utf-8?B?Z3ZmMXZOZ2tEc1UyVm9IcGIwdlA2WkRJaklhVzVvbzN6NXg3Mi81ZkNnYmc1?=
 =?utf-8?B?WlBCNHJQOEpMTEJITXZweUx6ajNyUm9FRyt5ZjlwOWE2RnljalNuMVlEZzJM?=
 =?utf-8?B?bkpkaVhUUnhPZm1tT1R2a2xIeUhPUGQ2emEvSnhvaVZLMHA0Z2FNNUZiZkll?=
 =?utf-8?B?RTYyTGNaSVBscVZBYVp2T1ZXRmNrMElUUXJka1hXeTYzLzZxdFA0UkxhYU5K?=
 =?utf-8?B?Mlc2TjU1Qlg2Q1o5WXQ0Z29mbEdObm5BQnZyZUZjbjFFc3RVdHV2dWhFNHl3?=
 =?utf-8?B?RkJHVG5tWkRRL0MvcHNQUWsyNkdPT1JFZWwwczVGM3Mvcy8ydWpMR2V0SUlG?=
 =?utf-8?B?QWhuaTJZRWhTa3ZrbVJPcjdXYjVCVVo4MWxCbmIyMEhBWld2TGQ2MUVwbjlK?=
 =?utf-8?B?M2s4Q0hJRnc2eHQxbkxCcHk1YStlQTBEUkQ4NC9mSzJIMGxURjByMWUzU1U1?=
 =?utf-8?B?QlpBL1hyRnNTTWFsZWE3MVVybkV5VTZQbkYxWUM5R0hack1HY2Rydzk4a1ox?=
 =?utf-8?B?VW9mZGhUbm00cmZjdUNQMktFUEdob3RlTTJqK0R5czh4dHZpMEJ3QThCaFdY?=
 =?utf-8?B?QW8waXlvTWNzOWhHVDd0MlVkc0U0cmRuQnJscm5UK0ExUHN5TGJIbDRDWEEx?=
 =?utf-8?B?L09lTFRHNnFkR1ZJemxHVS94YUNyV3gvSHNvMVNxdlgzc2xOMytWMkhSRXY1?=
 =?utf-8?B?NDh5U0p3Qkd5YzBSVnRTcnpHTGRjRCtLcU5HNisrVGRPczFnWitrK3E2WFJG?=
 =?utf-8?B?RCtZOWI4M3Nlcko1NEFUOURIUzNpcms5dmtNTXdwMlk2Wmp3LzB4LzBXTWg2?=
 =?utf-8?B?Y0pzQ2ozTWszZlRsSHM2blZFaytNZ3JqWENRQ1h0Vzl1cmEzUjBuKzFVZ1hR?=
 =?utf-8?B?bzlVeVVieXdpYUlpb3c3ZmZHQnFySzBBb0tHOXRqT0w3L3lrNHFMbHZ2UkMr?=
 =?utf-8?B?c3RaZnBoQzBMMTVSelVhbk1FSGtralpJUkpCQlhvb29NaGhnMDhWTUcveWk4?=
 =?utf-8?B?THQ2VHUyaW5zRStUMUJaL3E1SmVmSlV3Z3E2ZW54dmlCTW1EeXdyTjkwdG5T?=
 =?utf-8?B?K1hFaVhmY2JDM2YyaCttVUk3bE9pVWF2T3Q4bVkvdTduQU5RTU1odzJnckd1?=
 =?utf-8?B?aEJocytxekIwWGFKc09aRmc1RGlFSkU1MWl5bXRkd0IwZmpGTkh2S2l1VzVI?=
 =?utf-8?B?Ri95b0xBSUJqRGVUUG43OStManJLblNBWkZWMDB1dUhldnJqTEhRek9tMWcw?=
 =?utf-8?B?Wk9nditNeVdXR29GOGJNUXBNa3NoaTQ2dHpnTkJGKyt5S0F3Q0hLWXpTRml5?=
 =?utf-8?B?WW9zK0l1OGZGUi9rQ0J4U1E4clJyaGdBTEVIMXQ3RE9CaTFMOTlEUEZkNzRL?=
 =?utf-8?B?aGdLUUpJbVNDTVorTjV1czhLSU93U2V4VTlCamMvSXlMSk5ZOHlJbDl6d1U0?=
 =?utf-8?B?TVhhR2xMWHZ0SzZoVi9zTllxbVRZWlVWbUw5bGNHWXRTeG01WGxFUzByaWc3?=
 =?utf-8?B?K1o4bkRDV2ZtdVZPQmlaZThMN3FjL0VNS3pZQnZrcWpyN2ttQnh3YUJvZ1Ju?=
 =?utf-8?B?dGJKNnlmRDc3U1hTQVVPM1NPSXg4RDBwUmkyMTdmS1FZWWVtMzlQaE00eVRC?=
 =?utf-8?B?UTh6aXVPZ01yMjVCWmU0UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGRkZ2Y2V0VBaXJLOUhUYWRQenR6dDZoMEJQV0x6Ykc2NG1HUUtaTXZnaFdw?=
 =?utf-8?B?K1hvRzVEVXRoSGtSeVBuOXNENm5NOXd0Rk1NYzJXZ1ZOZlFCdUltY2w4eGFn?=
 =?utf-8?B?NjNIcnd0bDFDZGE4L1VibGhnK3pib1hZa3UrQXB6WnJGMkdmRWJKazVGRTI5?=
 =?utf-8?B?UGhrYjNpSmVRekR2ckl0SjZJU2FxZWtKNGVFL3paektLZk9iY2p6bDRnTm4w?=
 =?utf-8?B?aXRhS2x0dHZEOVFGZENrZGp3ZGVTT1ZkS05raC9mS2dXQUZBZE55eUJ6RTRk?=
 =?utf-8?B?aStBUk1FQ083dzBkbWZJbU1zRUgyTnkwNTI5QkliL3psWFFZWFlPT3VFTVhY?=
 =?utf-8?B?bS9kYUJWS1hGRjgzZ0F2NnlrL2V3SVdzcDgxdnNPZm1yODdJV2hkR1ZWRWh4?=
 =?utf-8?B?TFdZSmoxZkZnbTAyRk92SmMvckwvbWRYS1dieFdqM3dzOUxXWGJOOVdQSnA4?=
 =?utf-8?B?VUZSOFBWckpWT1dHVDBPTXdtTndveXR1Z0tIU1FHQUVnTWtMYVNOV2V6Y1Jx?=
 =?utf-8?B?UVZ4MmhpTG92cjVKa0V6S2dOMnk1RnNrRG92aVQ4YUcyMi8zN25UNElGMjJ4?=
 =?utf-8?B?Y2ExVGNId3A4RUw2SDJmYVVzdDk2Wnhpc1FIMTJGL3hsOVZuNDQwOUdaT216?=
 =?utf-8?B?dGRPZEVCSm1OR0VnNE5PalU2ZGhJQmRKeHZ5c0JkaGNYUk0rRHJmM3pIc2U4?=
 =?utf-8?B?MGppSSs4cTFNdmdWUnd4aHg1eXdUZ3BTbFRSSUJkdUR5bUNyZy9JaTUwMzh0?=
 =?utf-8?B?SUxNZzRjQStlNU9TL2gwYmhUNDBpUUdUTStNNzhzYUhmTmV3M1ZLQVQvR0Zy?=
 =?utf-8?B?V2R2ZS9jcGVPcldBcjNUTkM4V0F2bUpFaVRBSGFUTllHSnJYUUtIb0lmeW5z?=
 =?utf-8?B?aDI3M3A4eGJITHR4QmZzQ1pXMGUrMzdBQWxsUC80VTloWnp2aUJHdHNUUjlk?=
 =?utf-8?B?MkY0VjBMeUNwOUZDR25NV1lLTmcyVSt6ZXlTTVBGZ0FQQlFsdUlWc1EreDdz?=
 =?utf-8?B?VXhLWGZQZVVnaUc2cDNhaThLVWxBYy95ckdHWmxSUnkwV29IYmM4SmZTWUE5?=
 =?utf-8?B?aFh0OUx1OGp5V0tINmhHanhHbzBUQ1A3NjhLR2syTE1kd201RDNrNHcyb3Nu?=
 =?utf-8?B?QXhNL3lSRjdrZWk1cEhVNkJ6RmcveDk5amZnRjVwdm8yUGdsT2xoTmliRUww?=
 =?utf-8?B?WTdzY1NCeWdUS2J6ckNENXlyaXVSVklob3kwUXN5WUpnek5pZHZqZ25XUVpC?=
 =?utf-8?B?NUFZdkkxNnFnK2pOaHpndS9YL3Npdi9hcUJzSVU2Q3VZZm52K2dScWFENGtO?=
 =?utf-8?B?SGJyQmZCQjFZdm02ckpxRFNNNGQrMnJtMDZFN0JtdU0rWnpDUnRSRjhLNkVT?=
 =?utf-8?B?Y1RWT0YyQjIrc3NJV0pSb0ZrbkhmcGdLelVOMGRLaDlzUWRXRGhaYmRON21y?=
 =?utf-8?B?VmpFMVdjN2twN05ueFVRRWxHcjlYcTQ4U29xenFhdytBMG51OUp1VnE3V0h6?=
 =?utf-8?B?WktxNFZ0YnZiZzFQVDFtYVFNUHM3UFh6dVI5S24rZk81OS8waWFJSUJuK1lU?=
 =?utf-8?B?ZW1uREgxcUMzYWpuN1dROU1zaVNpRklndjBHejZpY3pvck11Q3RmbVdheXpz?=
 =?utf-8?B?Q2thT0IzM3Zha1owK1FickZXYnVIV0s1clBZaHlTRUxaLzN5ZjVoR28rVjk2?=
 =?utf-8?B?aEZUVThxNmtzSnVVbnhjMTZKWjZ1eVllbW0vWmJSTmVOS2NHWjczRVdWdW5p?=
 =?utf-8?B?VVZtclEzejZmWkhoaFRYVDlkUFQ5Q0dPYXFQcnBCSDZPWlJzc3FKRkJEZVd5?=
 =?utf-8?B?MHpOTEdHcU4zK2h1QW1RYUtMbVJaL2JtanY5bHhQSlY1ZGo0WFNtRGpGRUds?=
 =?utf-8?B?NFU2QmZqU3doVlpwRytQTE9Da1loWjlIN3NreG54aG1ocGcxU3U3YktuMmhr?=
 =?utf-8?B?ejN2ZGwxNXJMU29GQk9icW5LQ2pIL2hnNGpSVUxsZlJDY2FUTGhTYnNlNFM2?=
 =?utf-8?B?RVRKNTliQXh3UUk3L09EVE96Y1NqOTBaclVaM0pUWTRONmk1L211Tml0WTNq?=
 =?utf-8?B?UHllVVhXUjlpZXpmYmNhWGVqR2tScFQ3WjBYcld2ZWZSZHNnRlRSUXAyR2gx?=
 =?utf-8?B?dnBLUnJLdG0xWURPRXNNdm54cnV0OXErcXNCSWZSRVExWFhkTFpFOHpKekh5?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b93536-1a77-4431-ab3c-08dd5869ad11
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 02:35:05.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlF2PiwZy2VlIvZM9fNZvftfFRuebh3T2g6s7ECNPHKwRMNKgGKpLqx5ud2RcQw/KwcCQ2zDNY+QB3M7oNRkiESAd5cVnYGQ3C5D+Tr4Rx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:54 AM, James Morse wrote:
> Hi Reinette,
> 
> On 20/02/2025 04:42, Reinette Chatre wrote:
>> On 2/7/25 10:18 AM, James Morse wrote:
>>> resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
>>> resctrl can't be built as a module, and the kernfs helpers are not exported
>>> so this is unlikely to change. MPAM has an error interrupt which indicates
>>> the MPAM driver has gone haywire. Should this occur tasks could run with
>>> the wrong control values, leading to bad performance for important tasks.
>>> The MPAM driver needs a way to tell resctrl that no further configuration
>>> should be attempted.
>>>
>>> Using resctrl_exit() for this leaves the system in a funny state as
>>> resctrl is still mounted, but cannot be un-mounted because the sysfs
>>> directory that is typically used has been removed. Dave Martin suggests
>>> this may cause systemd trouble in the future as not all filesystems
>>> can be unmounted.
>>>
>>> Add calls to remove all the files and directories in resctrl, and
>>> remove the sysfs_remove_mount_point() call that leaves the system
>>> in a funny state. When triggered, this causes all the resctrl files
>>> to disappear. resctrl can be unmounted, but not mounted again.
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 6e30283358d4..424622d2f959 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -4371,9 +4375,12 @@ int __init resctrl_init(void)
>>>  
>>
>> Could you please add the kerneldoc you proposed in
>> https://lore.kernel.org/lkml/f2ecb501-bc65-49a9-903d-80ba1737845f@arm.com/ ?
> 
> Huh. The way that is indented means I copied it out the file - I'm not sure went wrong
> there. Thanks for fishing out the link!
> 
> 
>>>  void __exit resctrl_exit(void)
>>>  {
>>> +	mutex_lock(&rdtgroup_mutex);
>>> +	rdtgroup_destroy_root();
>>> +	mutex_unlock(&rdtgroup_mutex);
>>> +
>>>  	debugfs_remove_recursive(debugfs_resctrl);
>>>  	unregister_filesystem(&rdt_fs_type);
>>> -	sysfs_remove_mount_point(fs_kobj, "resctrl");
>>>  
>>>  	resctrl_mon_resource_exit();
>>>  }
>>
>> It is difficult for me to follow the kernfs reference counting required
>> to make this work. Specifically, the root kn is "destroyed" here but it
>> is required to stick around until unmount when the rest of the files
>> are removed.
> 
> This drops resctrl's reference to all of the files, which would make the files disappear.
> unmount is what calls kernfs_kill_sb(), which gets rid of the root of the filesystem.

My concern is mostly with the kernfs_remove() calls in the rdt_kill_sb()->rmdir_all_sub()
flow. For example:
	kernfs_remove(kn_info);
	kernfs_remove(kn_mongrp);
	kernfs_remove(kn_mondata);

As I understand the above require the destroyed root to still be around.

> 
> 
>> Have you been able to test this flow? I think you mentioned
>> something like this before but I cannot find the details now.
> 
> Yes:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot%2bextras/v6.14-rc1&id=8c96f858b25aa42694c5db56a2afe255ed8262dd
> 
> This is a debugfs file that schedules the threaded bit of the MPAM error interrupt
> handler. I figure its MPAM specific because there is no way into this code on x86.
> (the aim is to get the CI to tickle this)

Thank you.

Reinette


