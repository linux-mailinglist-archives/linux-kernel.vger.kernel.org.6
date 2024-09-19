Return-Path: <linux-kernel+bounces-333750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FC097CD56
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC141F2206C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B4419F469;
	Thu, 19 Sep 2024 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P3mrVW4m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDD018C31;
	Thu, 19 Sep 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726768398; cv=fail; b=Mp6BsO8DLet0EPdvipOvfjFDdocgwejIV8uw5wVt6idTD75MYW+pY5GE7EMKa+xqAjDpZ9ngCFujcZw4jnJVKj0j7QPXHqsjdgOaKhNytq4DNbpHyyTVoMh15Hv0zXLUyvpeF0l2mVC/rN2HYcuVlvQnmhmir/XD8TmrZ2oU2EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726768398; c=relaxed/simple;
	bh=eBrAsAjq8gXR1laM4aQShNdajEOr9ytLCEvj2c8xlXw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IqKmFf5OD9P0qZHfPVN6q/8AR4QdDbNvOL5TPi/jDlEK1IBSKiCZDTXJHsht2RKU2kWfZwNenRdehMEEntouON/S3ZnQz5/okIygvP3mvs5ONjGUWQdJkvQCsLWP+6XQrXOMsg/aeJTY2HJw+YS85kktB7cq3Vn9Y/cAJKL3VLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P3mrVW4m; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726768397; x=1758304397;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eBrAsAjq8gXR1laM4aQShNdajEOr9ytLCEvj2c8xlXw=;
  b=P3mrVW4m0DewzYw3RcffnA4SaRTzIoE+Z4I/71HsI//XxJPV9+N22j2y
   UXePKvm34HIImXvfOJUqGdPd6vje0DFw/k5ZxlLdIskc8Wggw267/vI5D
   +NRg1D0OoOEfFQWHeREhokGJ+oRBtP5HcEb8cEF4mUZ8bHZOFSigMYFAH
   ZaHV81/pt6LWvzCnlftG+aqb1dN06op3IePKksD7jpptgKDWJhgIvPi3Z
   cZjLn6NJR8ogsITNHSKORlNgJqtgpP7inSIBVC7gyb2eOCEaE49gqnqIc
   ggLrWuf/lmGqEGMlGQkuoelu7jDCsMx4iV5PXxXkd8w6qyw4SV/UTDuAO
   g==;
X-CSE-ConnectionGUID: P+O7+Hp7QKK2+Xu3zV4vVA==
X-CSE-MsgGUID: R+guyhcuT/WA2cUdkOcs/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="43219825"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="43219825"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:53:16 -0700
X-CSE-ConnectionGUID: pQ97dXaMTkKBUsdmlWMDWA==
X-CSE-MsgGUID: vYEgP1YiQCaxYC0jt184YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="69884480"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 10:53:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:53:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 10:53:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 10:53:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+s62B3eIPgHeWi69eWjSvyPISoVb9BVoPDmXZEiwkB0XdI02meNFcfL2aKPTo//wtiyCbE9HU5lXWE/LHrw8FLbsszuUlCZVVdfytC5CrFT0RQ2S2S3nlHs1B1l8rkxwFnDIF8GIdIgQ7AUZkAle8Goh5wFGsWcnHViw0qVkb8Ky/IExvHpSC0w4vr//mq/FzBaenThJ9IykY4uTcyEuyW7CdQaulxJFIKlbDMU0FTsC5iFE5IrzhzOnlJcewP/OEJKX8nJNwI4e6UB92J9YvuRIIcMkYYFlNMPRtSwMLaB0ZzmfHFs3eQteS9mu4xfOZcIIjVJz+3kBNFooTrqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpfJ0Dsi6FMC2/e3o6tnU254neaKG4afci19qp/cEE8=;
 b=XVGFShzoy6MugeTQTkD5wumrOr3V1ZqGGeFD7D10mMwAqA69E/2DFQBFjg1D3792RcHx+oyr//UdQCVN9Su2BWka7far2Ofc1HZP5oehiUk1OQCt1rVGnF/hjG6qShZAgDAx4uBeYzUC0z7y8HpOLWd46QWkDH6Qa+FB3EUiVw/vF/t9N1Q7u0Ai3s2jXEb1uOGCxqWiURgYDj7bDz18UYLibmJjVfzXG/AKI9ji78ukp9pG2f7mrmgzsJgQ+Rd9RWR30mk53+OLCDeo68acm1Z9xYkVCOF4Mq3UF8Lg1j1nNFB6pkyf4yJJLoRAdLUoeUOyK4Lxz30L+cjtdZIaAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4710.namprd11.prod.outlook.com (2603:10b6:208:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 17:53:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 17:53:06 +0000
Message-ID: <fd370cfa-cee7-4b3a-8a95-b6047794d475@intel.com>
Date: Thu, 19 Sep 2024 10:53:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 23/24] x86/resctrl: Introduce interface to list
 assignment states of all the groups
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <e6782ee97520b92d44ba80e510e8983895426e0d.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e6782ee97520b92d44ba80e510e8983895426e0d.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4710:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ab6282-cb59-48c6-53b8-08dcd8d3ea7e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1JPSEhQQjFlQWErbEVjTHB3L0czYWN0dWdCNEppdll4QzFjSHR4eWpHdDdQ?=
 =?utf-8?B?ZDZmRGpPSnYvendQVG1qNGlqQmdBQ3U1eWFwbHdvcFM0RU9nUEN6RXNuQjFO?=
 =?utf-8?B?OHhuenFPazhqMElsNmZQTEtsV2lpaU8xL1YyaGpISnZwd3pZQXdZV3A5cjl6?=
 =?utf-8?B?VDgzb2JmY2I3TTFIQ0NhUEs3aUhHTFFuMG9pV2NaalQwQmJaUG1TWkJCYVBn?=
 =?utf-8?B?WEZJRDRkODJyRHNVaTZET05Yclc5K0Z3V0hleVNZbkVrU2ZGNVlGSmJiZWN6?=
 =?utf-8?B?ME1NalpPY2h6YzdDSmpQN09MVXR1UmMzNWVRNEJnZ2gwV295WUFjYStYb0FR?=
 =?utf-8?B?bFpqMnVMYlYvaElwd1Ewd3hCbXhUdTFNbjVOamdpa0xPUDVHYmtSNTV0b1Ri?=
 =?utf-8?B?RTNlMHNLbGtOa0wyVGFHaGZ0VUx2UHZFWi9GQ0ZQNmpXek5wZnpBQzZNUks2?=
 =?utf-8?B?a0x4V0w1U1QwNnRGYXprSlpRVzY3SHJ1eS9qTitCbGl5UjN0RnoySFc4WWtT?=
 =?utf-8?B?M21hOW1WeEhhWlNKYkp3SG9QV3lKenVERVlyU0NWWlA4elhNMmdQb1p5N0Uy?=
 =?utf-8?B?Q0g0WXdpN2twZTBzRTc1L3BKYmhnVjF0L3RJTDJ5c0l6MEswMlFIT2plRjMy?=
 =?utf-8?B?VnZWMnZjUVc2WEFtSk4rN2QwM042SU9Oc0dqWDBCQ2dkc0N0eldtZFdCc0tl?=
 =?utf-8?B?bmhHdXR5T0pFV2V6MWlReGc2VThZYzJwR2kweCtLY1RSdEg3UUU0bkVTZ1po?=
 =?utf-8?B?eUJyZU93bVNqRFB0UDZHMlZyN2s2a0hzdGtQN2lOc3l5aEY0cXZhV3NMOXRq?=
 =?utf-8?B?UWVaN2NZQTBkM3RtdlhQalNvUE5Ia01sNHNYTzl3dVZGUEJkV0RodUZSbDQy?=
 =?utf-8?B?L3p6VG9OWHFycXNCREw1bEVzSGdCOUYrMS96M2svZ2hLdUhJMXUycURjdmxL?=
 =?utf-8?B?ZlRQamdHUVlSeVRzbDhvSG9tT0VES3BwVzhBUzZRaDlsTlB6dHhHdkpoR1dN?=
 =?utf-8?B?NzFnblFObVRGZlg3eDlkaUt1WGt5M3hoaGpHbFBUMEp5eFlzcUdoUUtOd3My?=
 =?utf-8?B?aVB6WkpwclVCNW5OL0RKeDhXRFFhZGdkd2FkQ1RWKzI4aEgrTFpFMmEwUlNn?=
 =?utf-8?B?ZEhncE1QMTh1eldMRmt1YnU3WUx3QThOaGJ6ajIvSFdPWGQ2TXppcTdkN28v?=
 =?utf-8?B?WVpaZWFkVHgvQUdCZVRiVTFMbTRYY2hXVW1Xd0tZRCtXMkFHUytmWUlvWkQ5?=
 =?utf-8?B?azk1Tm1BNnJVOGJaQWZZL01Ha1BEZVJQTzQ2QS9WdWRhNnA3M0c4RWVud2ZK?=
 =?utf-8?B?N3hRb2x2Y3FTVHRGS3ZabG94cEhUa1R4V0F3ZTV3dW9lUExYR24xaDg2NmVo?=
 =?utf-8?B?SXNHcDdlWDAxckdkWFMzbDl1M3o5U0s4STNYNkVVYURKTWZ2TEhrcmdHc1Ix?=
 =?utf-8?B?R1dqeFlTbFN6OGc2eW90Y2RWakJrV1J5UDNpYjVCMVpmUGdXZ3hadW5LU0g5?=
 =?utf-8?B?S2hpaEdlYXJXbTFsQ1Y5WEJmb21hTXVKZGhMQklrSzlaeHpUcGpsQi9nelhr?=
 =?utf-8?B?bVVyUEoxTlRucitaSHJsVEFkTFBxK2hjMWNnNTh2UE9UWUJJZlhUcU9BMmlZ?=
 =?utf-8?B?R0dBcmVqZCtob0tuSFB0YTl2ejZtcmxscjBNT3lKS3R5WkN5WHVHMU9FUVVu?=
 =?utf-8?B?MGhVcHhScXFsemMxNndOQ3VSbG43T2pMVWUvYmRLcGR1L0NHd2p5aURDbXlY?=
 =?utf-8?B?R0VKRjN5TXoxZlY4czFEdUFMME5DRVRjTThRZkZDWUpTbVNwMjNCOGJBM0tj?=
 =?utf-8?B?UTRKTFR1aElhQ3FVeGFYZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE5jYUtMaTBMZTQvOEJ6U05LM2Q3WWhDSWtkK291cWRuZzZ6aCtjRFcrWnhm?=
 =?utf-8?B?bDUvVXdMNUVEcFI3aEhIMk91OVZSSjQwZ1k2dVp2SmlxT1dlL3B6SmtXclZP?=
 =?utf-8?B?N3VpSjR5bDRNbnZ4SU5kb2ZYRmhpdUhBaEVRa25WajBvdlhkUEoxU0xiVGxX?=
 =?utf-8?B?Zll1cjRsRlF4RWNraDBNYVdSL3Fkc1pRL1c5bnBDalcvWm9rUXZZS0NoZWJx?=
 =?utf-8?B?QSs5WjVBa0hvd0hGdEE0bXR5MksrTEdwTVhJbHoyWlBBNnZ0SUl1NEhHWnc1?=
 =?utf-8?B?WlhvY3h3Y3R5VXNxd3JHczRjaFZmdldmUjJqUFRSbjJKY1pRcVBBakYwaEhF?=
 =?utf-8?B?bU1NMjBsSHpoUjBWOS9Paks5Qjd0dnVjZ2k5WDZVUnNCRGs2UEZzakhrRkN5?=
 =?utf-8?B?d1d1SkpTM1FzRzgrV3JTNkp3WDlFa2RLUWlOSXhsenVsdVZRRGlqdVZJam9i?=
 =?utf-8?B?NmQ2REVieVcyRS9zVDlRQ201bDh2NkkrQk5qQ3FpYVBsajVLOFY1cjFvVWNR?=
 =?utf-8?B?d2xBMDh3Y1Q4MWZnQ3kvWXZkaVV6U2xKMkh4ck9YV2NEZzZFQmFiTUlPc2hE?=
 =?utf-8?B?czJBQ2MveFZIZ0hlUGRRU3ZMOTJmdVJkRkpMNzJsS1hOVmdYd1I0K3FtMHVZ?=
 =?utf-8?B?QUFSZ3p5bGZ1MFVWUnlleHBweERwVXRxOHJHczBlS3JsaFZINXFVVUp4bHdy?=
 =?utf-8?B?OWdDQUZtVUdoNnBBRnlrRjFOSnpWWnEzNk5MY21KQ1F2dFFmalp4anU5bEV2?=
 =?utf-8?B?eDh4c3RjQ1FnZERhOVByOEFEOUo0NGdZNDBScXlkK0pOV2MwbUR1aWsvQ2Vi?=
 =?utf-8?B?Y0EvaVFzTDMyZWl5ckJEQU5aam1tN3ROMXBYVlFyUUtxZ2UvZ2dvSWIvNXp0?=
 =?utf-8?B?L0tnOGlnWEo5NWtBQnVWOWVqSGZMaEk5eU9sZVBoUjNlSjBvVWtZUTdSczdN?=
 =?utf-8?B?dFhtRzlNL2ovTEVtbUlaL2xYYkRZWnpFYTlUY1c3dmY5Z01KalBjRTIwQ2NN?=
 =?utf-8?B?NTlYVVN1M1ZLRjI5L1cyaEMvRWhCd0luNnhlMDh2bHd2anZYUS9tOWM0bGFU?=
 =?utf-8?B?cU11TDFzWmdzU0lMbjFpeUdob1F3cysrMXZnZHhscHY5UzFiTlJFekJ3WEZp?=
 =?utf-8?B?ZllPSUE4K2VFYTZYUTRSdktDNnFIYTJ0SmhheWFoc0xpZ254WitJaGQ0azJ5?=
 =?utf-8?B?cE1yTmpRVTFjV1c3RUZlZzJpZnF5NUt0UTVLVWdvREhPMmI5N0V4bVJHZFVw?=
 =?utf-8?B?WG5XSXRDZDc2cS8zOTc0WlB2VGtPVUhhQWQwSzhZc3NCMEkza2pSR254VmNX?=
 =?utf-8?B?K3RtQSt6Z3dWWEtGQXRKSmZZM3hWOGtXci9QWXp5aTZIL0lOem9SNmxrZEhY?=
 =?utf-8?B?MGM1blRVVU9tM3VHbEZsbEV6Y2d1TVNXUkVPbDRHa0NNOWRkejc2cGtHeUUx?=
 =?utf-8?B?VmNMUStlZ0hqVFJuUm5Zc1d0bWNJUWVkWVFESkZwTFJZVG1yeE94bEIrampn?=
 =?utf-8?B?b28rYVg3OTk1eXZLU1VEN29kcFEvS1c3S0RMT2lwNG9aUUliWEFDUlJFQ1Vr?=
 =?utf-8?B?RVRxUXY3SWNOUnVJUVF4YUllZHV6TXIwd05UY1E5bU9QMlZyNEFwSjcvU0py?=
 =?utf-8?B?d210eHYrVlE4S2tTdUY5RWxJMXBqWlE2R3luOTE4Zk1Sa1E5M01DcXR1eEti?=
 =?utf-8?B?Z0xOTU5SYUo4ZW9BY1RMNFYwY29ZcTZWN05tN3FMVDhJTU5NN1FQeDhDU1J2?=
 =?utf-8?B?SEgxQ0lwY1dyaE56cXgrcTVQbWhmbU5iRGJITFB1L05Ya09KZVJGNkhVWWM5?=
 =?utf-8?B?VHl3ZWxTZ1oraUltNzJFNmx1VTlqQmh6dWhSVzJMNlo3MWxDNWlEUTV4akZF?=
 =?utf-8?B?RHpGMXZYZWF2aVZaTTBZZm14SXJ0VGlOUHlmSFhoYW02U3ErUzlFSXp2S3Nj?=
 =?utf-8?B?N0J5S3FrM2MzT2FiQkJyRFVNSG1Zd201K3pyTWQ1S3QvYmhEaS9nWG9SSWhW?=
 =?utf-8?B?OXUxNHV3eWNUQ244SjUvVzkyRHAvaEprZWpaWEFmdGxvUk9lSVFBQ3Axa2VD?=
 =?utf-8?B?SW84S0hKYk5va09NL2tVVi92eWlXVlJFcU9OeVBpR0pGMVRGMmFkWGVvSjJy?=
 =?utf-8?B?OU0rdExqOVovTGY2TW4wc0EvamdBTzZ6bjVoWXBvUTdQSkR2alJNZjhWQWZy?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ab6282-cb59-48c6-53b8-08dcd8d3ea7e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:53:06.4695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2ykOadIhr7+nWgJiSuh22DHvkS1FFgdldwqkbzPXaOP4QNXfrhwM7UOlJqCCFpCcRNlcsod6MZS0kIYabwqHxtBs5UNAwflN55HkRciB2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4710
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> Provide the interface to list the assignment states of all the resctrl
> groups in mbm_cntr_assign mode.
> 
> Example:
> $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control

It is not clear what is intended with above example, was it intended to 
have some output?

> 
> List follows the following format:
> 
> "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> 
> Format for specific type of groups:
> 
> - Default CTRL_MON group:
>   "//<domain_id>=<flags>"
> 
> - Non-default CTRL_MON group:
>   "<CTRL_MON group>//<domain_id>=<flags>"
> 
> - Child MON group of default CTRL_MON group:
>   "/<MON group>/<domain_id>=<flags>"
> 
> - Child MON group of non-default CTRL_MON group:
>   "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> 
> Flags can be one of the following:
> t  MBM total event is enabled
> l  MBM local event is enabled
> tl Both total and local MBM events are enabled
> _  None of the MBM events are enabled
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

> +"mbm_assign_control":
> +	Reports the resctrl group and monitor status of each group.
> +
> +	List follows the following format:
> +		"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> +
> +	Format for specific type of groups:
> +
> +	* Default CTRL_MON group:
> +		"//<domain_id>=<flags>"
> +
> +	* Non-default CTRL_MON group:
> +		"<CTRL_MON group>//<domain_id>=<flags>"
> +
> +	* Child MON group of default CTRL_MON group:
> +		"/<MON group>/<domain_id>=<flags>"
> +
> +	* Child MON group of non-default CTRL_MON group:
> +		"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> +
> +	Flags can be one of the following:
> +	::
> +
> +	 t  MBM total event is assigned.
> +	 l  MBM local event is assigned.
> +	 tl Both total and local MBM events are assigned.
> +	 _  None of the MBM events are assigned.
> +
> +	Examples:
> +	::
> +
> +	 # mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
> +	 # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
> +	 # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
> +
> +	 # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> +	 non_default_ctrl_mon_grp//0=tl;1=tl;
> +	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	 //0=tl;1=tl;
> +	 /child_default_mon_grp/0=tl;1=tl;
> +
> +	 There are four resctrl groups. All the groups have total and local MBM events
> +	 assigned on domain 0 and 1.
> +

Please create the docs in chosen format, like htmldocs, and see how it ends up being formatted.
For example, above seems to be intended to be a code sample but the description ("There are
four resctrl ...") appears as part of the code sample.

>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy

...

> +static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
> +					    struct seq_file *s, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	struct rdt_mon_domain *dom;
> +	struct rdtgroup *rdtg;
> +	char str[10];
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
> +		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
> +		mutex_unlock(&rdtgroup_mutex);
> +		return -EINVAL;
> +	}
> +
> +	rdt_last_cmd_clear();

This should be done before any attempt to write to the buffer.


Reinette

