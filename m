Return-Path: <linux-kernel+bounces-522734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9C8A3CDF7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F209178006
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0294C261373;
	Wed, 19 Feb 2025 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXffZ0Dp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8FD25E453
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009339; cv=fail; b=FhXMfFWMeEuP5UZbzed13FAaVreziK0KzIbUe7sgTv7YdXLP8GCwsqJToSHHpAOSDt5EU8qtUeJqn7yjep11l23DHnrWsfdIrdQ6AArvaXEF5R4+e1CNF46DokZBTBnROrLCuWLqB8UKoHWC+jCbSPBbenJRKFWMaqnQAuoDEmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009339; c=relaxed/simple;
	bh=jCjtvbVV/Pll6jPfaL8+iLNnArv3M0LMkqLvtVmc/Ro=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MC4qyVP3TSaAEy/ri0DxAnQTQTkd1AWtmDN3kiU8QBH7JMSjvXMf+JGsCC8AqAIN6ZxwiYZro2/oLFv1R2fO0f/pp2gV96unFXmDprxcyc17PV3L9U0L0xMzaBuBToXMrbv/VBOrN+oG81SD3gP0RwG8+oPGbYj3M7UBrSbeJ2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXffZ0Dp; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740009335; x=1771545335;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jCjtvbVV/Pll6jPfaL8+iLNnArv3M0LMkqLvtVmc/Ro=;
  b=UXffZ0DpOTQH+hoOMnEHcnpOWQ4X/0vbenHY1YqSas5jQUaxWMd9bcwa
   xIUsYu9QyU0cYzGzGLL1Bjxa3nWAcgfkUn/X2n7OzTs32Y5b4Ehn5Inh2
   NrlcdIEg7t1MT6d75NBlg5C94TGxlW96CLMjguVDEvg597QD0Vt778B2K
   FyJEHGHh1zKE7RzYacjbEBjTx1yg72APvgplUlUTiqN7e4W7nsmzYMYJp
   VuBvYAGfQCvodAVX6oV/g2DNhXXfS1NPecgCB3e46jHebrgtHoTJRLFsi
   eNN7HarpKZfvhI3EtvRDp3s5ror0w2HQ8zf2SP7QSFFM17uR+d7HUNxUA
   g==;
X-CSE-ConnectionGUID: BjUwNeyGRr+qQrWhOUqkiw==
X-CSE-MsgGUID: Y17zyFpkRKalPT+2fEh4gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51391114"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="51391114"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:55:32 -0800
X-CSE-ConnectionGUID: RvGJWJMuSFy9QmFP7fMvoQ==
X-CSE-MsgGUID: 9zMmu8DGQwaPQWuPPjTs6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114818434"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 15:55:32 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 15:55:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 15:55:31 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:55:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ab1KcK/LEl8duYMXj135NYFktnwQCQlVJDuvB0LAP3qWaz/fkmXsyRZYWIiqaHntIF5yan4NrfzHaGX05BLEK+2N4IELFkDLjzOE4EVh+duLgro/HZdPrWTjI6XOlKGxGAVZB0mexgweHAEfJPOukZpcqo7PG4ofDYh5gcdVoPR6Z3otAvtTyCpGtj1TYyviW9709usIRJxezy78hvOCAeRxL+WBiZOE7fWZxTNEzBOm6JAWRYUHuKoCz7X6YsbLHPlWvs+nyQCBEVnQl0OUUyI50i1zhU3gtPcqg6Lmoc+EAR2Kqg8421GXMr5EU0emGknO435vN0i6S3wpDLtdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJUjvLDKNEf4+YFYF0QjUGQR5vI/Pj86bHMWmAk/trs=;
 b=XFjwh+1eRBpSxdu2b7sdCFosiqw8h9aDiOOc/hy1haLfR8jziiFVoJlAYGStEv6m7QBFAtlnnUMfiFCnMkqWmR4NW0T/shpqBP/upIPfOhAnEVnRpBfmYQ1L4HY5zx+s30U8JKZh+aGU1hRF50IDMPq3jjz+C68XdIDW42VQ+nE6gIJ0V53se8oweMir4R4AuQIkdPbt4jZElX5He8Gt2OKm0aSFZWG9di000iZ6sl68iSWBJdQ8ZG579rog0n9FQR+W46nOM9z9wz3aAW4BmQUIToGjhK8N51blt5wT9D9VvQ7J7XeSXakS1jqlkq4UT+zDNUzCuqbrYVK7BCXkLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7513.namprd11.prod.outlook.com (2603:10b6:510:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 23:55:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:55:27 +0000
Message-ID: <3b0ac0aa-dcc1-429f-9822-f1b0c55b162a@intel.com>
Date: Wed, 19 Feb 2025 15:55:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/42] x86/resctrl: Move the is_mbm_*_enabled() helpers
 to asm/resctrl.h
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
 <20250207181823.6378-19-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250207181823.6378-19-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:303:b5::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ee3baf-cf2c-4662-9409-08dd5140e20b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzNySm1OMHlFYUJWTUtwVlBVejc3TmpjWlIyM1o0T215M29qVnBiT3VKZUxC?=
 =?utf-8?B?R0E4WVV3amNsZWxBWlYyYmhPWnBLaU5vR1JNRzVzMDJKcTM2UXNIOVozU2pZ?=
 =?utf-8?B?R2VtY1hQaVlQZkg0TW5URjdzRTVWajNNcVl4dU4wWHFHKzlhVk9reS84amNi?=
 =?utf-8?B?czJxZmJUMGhoRTVkNGMvZCs2VTlnZVVuSVBYZndpa29IV1lWVmxRR3V6M3BG?=
 =?utf-8?B?Q3NOOFk4ZEJ2TW9GdjR2aHI3SzFVMDZIcS9HalhuZ1krcXU1K3NxN0taZHR4?=
 =?utf-8?B?bzZYWUhsbDFRRGNHcFpqdHNaTXNOZW9FVlhmL3A3VmlWOTVodDg2VjZlZjds?=
 =?utf-8?B?SnRrUTczYXhoZkFUOEJXbHZWUlNBd2YzMlQzUGRtWlJuRFUzejNEMTlmVXhK?=
 =?utf-8?B?QkhqTU1uQW5mTy9nZDZ0U1U4dHlrejNsY1JFTU4zN05CSGQwbG5tVXNXTmlu?=
 =?utf-8?B?YzFKbEtrK0ZEdUJTNlVMaU9YbWZ0OVJhRnBvTVhodGdHL2U4VDlQYVhVUVVO?=
 =?utf-8?B?aTlicUR2QWIrdFhGRWhibUVDU1MwVm9UTnFUR3RjNElaTUlUNUdFRXphSW1i?=
 =?utf-8?B?cHplL2RlVU1jZGhyVlZpMGdGTDAyekVFK29Ya1M1alptTDBlaTZxR01YM1lT?=
 =?utf-8?B?RHJVS1dMb2cybTJBTDUzMHlJUHh0SnBWellBL2RXT3V4cVc2RGdmRUMxNm10?=
 =?utf-8?B?Umw2aG8wREE3SXdTRXZVdHJ2ZXRKNEhzOGUyTklIUUhCUExzdktvNlA3bzYy?=
 =?utf-8?B?Z0crdWV1K1RLNXh2UW91MWYzcitEemxuMi9iaE1kSGRPdEpDdVcza3IxSjk3?=
 =?utf-8?B?RXROWTdGbG9jOG1WcGxYR24rckMxZWtZYnd2SStjdkVaSkFobTgwQlBDL212?=
 =?utf-8?B?MkZ1Y0dIeDU3VlJZNTN2bmgvQWhWMUcyb1VUeDFCZDBSSVFjWmZyWG1YdVZG?=
 =?utf-8?B?bWplZGRqNWM4dERSMG56ZEFvYXZHSUZFMzlvNTZUYlR3SmF2UkNiOUFQNWpx?=
 =?utf-8?B?MEZlSVd6RHFJWTZVVXZtL0lnSTJqcldxQWJuZlV1dFFLR2tTWEo2OWszS2w5?=
 =?utf-8?B?L25zUUJIUjUzeFcrWWJHZ0lyWTRoNEMxUVp4eFF3dXZqMUltTE1vY2VsUU1r?=
 =?utf-8?B?cFk1a2FlZlYrb0RGMzRRamFzcm9ybEZ0bWgvaENaNnZEaWozUmhSM0hUeHVY?=
 =?utf-8?B?S2hhcys4TGF1Ky9iNU1Gdlg3VVFpRDRzVUtiWFhrUkg2ZjhqUU1jTXFvV01U?=
 =?utf-8?B?a29McmdYN0JIWU0zcUhQcCsvSVBrT0E0Y1Z2OTVWVWJkeXptZ2hoM0p3MFRI?=
 =?utf-8?B?R0lWb05xL3FCYkVwY1JNblBWZHhTOFEwYnlMV0x2RDNhbG9CVks2aGM0azBp?=
 =?utf-8?B?bzdEWDZiWHRnQU53azRhcnBUSnBDdkV5dTdta0o0cmcwTWlBTmlhSG4rMnRq?=
 =?utf-8?B?N0xMa2NCSHpYS0JjYTBieldZNWZmK1JMOTlxM0NOMzQvelREV2R3cnNzcHBs?=
 =?utf-8?B?Q3RuWmh4QjQyRUFVZFNFcmdFYUt2RnpqcTl6VHpXU0RRYk5TSUpKRDAydGRT?=
 =?utf-8?B?U3FueVh5UVBBRlIxSWpwdlFsMzRueGFXbVRjaVdLc3U5T2JVUnMyNnVBUFlj?=
 =?utf-8?B?UjFtN2M3d2ZHVVB5aFlkNE03b0prQzlPNnJrekFwd0N3MVRjcCs2K3BEZzB4?=
 =?utf-8?B?QmhDWTRKZmw5My9YaGhYd3k0S3RrZUREUFNOejZna2JvaVBWRWYySVZPWndi?=
 =?utf-8?B?dzlIRkR4TktyVVVuWnlOUEQ0K3NFSGZUUXJXbW8yd2NtQUVUVTEzb0dqS1h0?=
 =?utf-8?B?RFpZY2FhL2Y4dU40dEd3MUt4ZkwxdUsxbjF3VVA2cVlTNGVIdFJ6ajdHM2V1?=
 =?utf-8?Q?zhrLjasYk8abS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTRqVEpONS9SS0tsSFNDR3VtS3I1c1E2NW85eWpReWxrRkpYREhSc0s5S2p6?=
 =?utf-8?B?TGhpeGk5aUhGRGlyMzQvU0FrYytxaXJ0SEhIMDJzQlZGSkRJaDlwdzcyYWg2?=
 =?utf-8?B?VDRFc2xWcWd6OFdOYWk5YW00YlhGM1pSUWxwcE92SkxjMjBnK2NjRSt3dmoz?=
 =?utf-8?B?NWlxUEZVSlBucU8rL2hsZm84S2hxRUdhZjlsOTlXa0E5QWtSL1dWdmo2eG8r?=
 =?utf-8?B?aTFaTks3REJ5NTEvOStkNGlLMW8wUXZoWHhEV3JBbDk3ZjZZNEtUakFMUGpn?=
 =?utf-8?B?bzVqdklRT3lFbHRkQ3dWT2lrUXFuWXZNbklKMEU5TlRIWlhhYWlnSHdOZFhX?=
 =?utf-8?B?dStaRi9pU0o4dVNXWVVySTlkcWdwZnB5WGdlOWp1bW1EQVlnTnhvYnRmenNr?=
 =?utf-8?B?RVBJM0VUMDZ0M3hQZmppVFdDVXlpZ3NSOW5qN3VrOENicUN4WTh4bk1VNGRS?=
 =?utf-8?B?ZVBhRndTdDFzbFg2SnI5SUxLMEh4S2pqU0t2TUZyMVljeXQ5cE1jOW5xWDA1?=
 =?utf-8?B?K0U5V25IQ08vaXFLUXZwQzBybFFCc3VqR0pxMnF5UjlrVVF1Y015SmRUZXZN?=
 =?utf-8?B?ZmZ1NERzK3duYzJXV21KTDFUbkJLUjJRYkJSZTZYM1BYbkRmOU5vZFpWOGtC?=
 =?utf-8?B?MFFTUkdlRDJWaXg2VHdMNjkwNG82Vjladm5KYjNrL2RBU241MWRnSGhwZEdo?=
 =?utf-8?B?blRyaUNhUko1a05pNm1FQ090L0dIbzJHS1IwU3hvWUNIZ08vU1lnZjE1aHBk?=
 =?utf-8?B?cEJjamlsbkRkQlpKdUxrdGhON3puUmVrUUpkbm01UUVKZ2FTUmRBR0c2S2Ev?=
 =?utf-8?B?TGxKckR6OE1NSHBqZGVkazRlbkNINUhMYzFUWXNqSEF3SXZTeE5UN0pwZFps?=
 =?utf-8?B?b2VOcklRUVZUUndJa1VXRlRSalVqY2RMZjFnWjVGOW43Z3hmYXpvTmpzdFFr?=
 =?utf-8?B?UitqeXF3aUYxdU1Vb0xpQ2ptQi90aE84ZTJqRmI2M0hqNWV3KzJIbWZFVEN5?=
 =?utf-8?B?VWVPUXFlaFhIcWxseGxOK0dFVlFJQmowVjZLRUEvK2lOMExmSnRqZHN4eE5l?=
 =?utf-8?B?bGFod2hrSDM4K3JOSzF0ajl5WjBMWlUyVElpMXV1Q2IrdzJ5Vi9ZY1dPTmVk?=
 =?utf-8?B?WXgwb2VFeFNuU3M5Q0pkc0RQRmlhUk1mOUgxV3daZXNnUTBIRXRoUEg2NEFt?=
 =?utf-8?B?by9qdWY0S3Raa2J4d211d3g5dUJubnlSMjFaOEZuTWhFcjgyU2ZnR2FCdSti?=
 =?utf-8?B?ekpqb0ErcXcrRmJxMmlmUjNRbUsrZHRDRzFoYjh4NXdGQTVmdi82K3VVNFlk?=
 =?utf-8?B?dUJYSFV0TnRHdUNWNUt5SGRrU1FwUGllOG52Z3VTNFFBYTNaaFZNYzYwSVdq?=
 =?utf-8?B?TzhnT0hTSEZIZzllR3Z3eHV0TjdBbXQzeGdBd0NrSFp2SEhUclVEaWtIYWsw?=
 =?utf-8?B?Tk14UVhmd1A1UlVIVjBROGcyVzkvdGZkWlhIbWRYNVBpZEZoM1RZY1FUQXJX?=
 =?utf-8?B?S2NiVStuZzRKaUFxUE5ZNmRKQmVKODNKb09Sb3JCOHR3TXI1enFrQzhoZnp1?=
 =?utf-8?B?dFYxWHpGeGJDbjdKUWh3ODBBMkluS21CdkkzaFhKWFV1alJrNFlaQmJ0NXNs?=
 =?utf-8?B?YUpuUGRQUzlvNEhoVlE2QTZFbVpQaXRlZ0tGOW1xb2tiS1did1JYWllVeEsw?=
 =?utf-8?B?b3YzV1hyUVNpczdHRWZBak4yeDQ4bmR5VHg4NCtiMll0ZE1xR042TUxLK3Ew?=
 =?utf-8?B?OVJ3eE44eThMNUNEZWtzaGdCKzE4Tk15c1NaOUIrbmtONmEwZmZBcllCOFpq?=
 =?utf-8?B?em9rR3c0R1BOKzRuaE84TXRaNERxcGxsdzR3TlRZeEQ5NHRxNEJIdkd6NU9x?=
 =?utf-8?B?cDJmN0p3bjl4Ymc5ZUlCUjBNYjFPRjd1Um9nUi9EbFUvV2dsc0wxc05TRk9K?=
 =?utf-8?B?U0lPNS9IaXhNcm1RUzhja0ZYMlZHU1JkcTgyOUl4TE9NQmZPbkljWi9WLzBY?=
 =?utf-8?B?WCtYUTZYSVBwdkU1Q040Z0EvaUd0QXhidkZnVE9YUjdjWjR5QS9ad1hXbitF?=
 =?utf-8?B?UDZSelZIZ2ZXKzJQbHhPYWVpZGZFaTYycUM1dEZTMlZKS29RWjFlaVVHQmdr?=
 =?utf-8?B?dzJnbTNwOFdqZkh2NzdyNlFJbWw4K1dCMUNra0g5dkFDYmxkK2Z2QnlHYVUv?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ee3baf-cf2c-4662-9409-08dd5140e20b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:55:26.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiqxhT5OgKZ39y9dcFvj0yq3WBSvOzZaoLL+OonSoFaXll12UUZO2D8ZhCVn50KcogLIGO06G0GVcITvdRl0yykrPAMr4nxx3bMNLawOOrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7513
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> The architecture specific parts of resctrl provide helpers like
> is_mbm_total_enabled() and is_mbm_local_enabled() to hide accesses
> to the rdt_mon_features bitmap.
> 
> Exposing a group of helpers between the architecture and filesystem code
> is preferable to a single unsigned-long like rdt_mon_features. Helpers
> can be more readable and have a well defined behaviour, while allowing
> architectures to hide more complex behaviour.
> 
> Once the filesystem parts of resctrl are moved, these existing helpers can
> no longer live in internal.h. Move them to include/linux/resctrl.h
> Once these are exposed to the wider kernel, they should have a
> 'resctrl_arch_' prefix, to fit the rest of the arch<->fs interface.
> 
> Move and rename the helpers that touch rdt_mon_features directly.
> is_mbm_event() and is_mbm_enabled() are only called from rdtgroup.c,
> so can be moved into that file.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

...

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 1730ba814834..b7d93670ed94 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c

...

> @@ -761,6 +761,9 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
>  	struct rdtgroup *entry;
>  	u32 cur_bw, user_bw;
>  
> +	if (!resctrl_arch_is_mbm_local_enabled())
> +		return;
> +
>  	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
>  	evt_id = rgrp->mba_mbps_event;
>  

Please drop this hunk. A new [1] resctrl feature makes it possible for software
controller to work with local as well as total bandwidth events. 

Reinette

[1] https://lore.kernel.org/all/20241206163148.83828-1-tony.luck@intel.com/


