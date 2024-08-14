Return-Path: <linux-kernel+bounces-285838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA78951355
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C447A283D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ACF3F9D2;
	Wed, 14 Aug 2024 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/kvUfGN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2737144
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608058; cv=fail; b=AGepL3b2ZXltvLyJrvQMPlyhWc9HCgBX51tofsfcs2vyVK1SYewiJcDYU8DwA/xh0wl03qbnLIz3UuBxxhrkvGvvGUeM9oalIeMP/XOn5HWK/CxVrypjQBuZNDNZzMi2i9jeHEl//KyCT5NK/VLBK0wYhIK7kIBs10/ZPUC7ATo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608058; c=relaxed/simple;
	bh=iFRak1LmWEbZW3GV81Mm6RAPr02Ku9FyzVxdEoKEgZI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cf/Mm0PuQ6B7HqtZYLqcK1OqI3awp+XgZaDARpWY9qus0usP0leRh5QakvzjbOmYjDHi8BXt9VpElKoeGxePzOq2fIk4UXzqn693JG/3ycjV6JaOvz2yAhRoGBddOUJNZPYAqdBzO+WrtHscn8StiE+Y2QufwlzjsxaZEz80iUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/kvUfGN; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723608057; x=1755144057;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iFRak1LmWEbZW3GV81Mm6RAPr02Ku9FyzVxdEoKEgZI=;
  b=F/kvUfGNNvb0JGyzxWBTM0fbpXB4Ite9eRVVBzua56Ct43X6VczWA1vt
   6o5NiEsvxlEILsWWFOqGA5hN0lp21e/18UU0qhwNfLjlNjRPMaekWJhUy
   9f7t1u9PW2MXyQAwEO4HpFhJnYI6oIs0icWF71cc3ymrtuFTyuKtuNqFk
   eqyyjNhcSR4l4chYOM27oYvkBX3wlD898/dxljq90XcSjJGLbhJTosOFW
   Qk3jNA6tbcACYgzRl+o42SwCGsCUZHTHOPWiQ91PBiRv0MsAAWz8sMXU+
   qwNTdjwWkZp2QnmeG7tFVqfwFPepE/BxcRTXPHO7vMpPqHQ2ldr0Kug0M
   w==;
X-CSE-ConnectionGUID: Ns97Ex5xQlOk6STCEuZK/Q==
X-CSE-MsgGUID: VcrVPopWRq26AaZi3bsl6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32426961"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="32426961"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 21:00:54 -0700
X-CSE-ConnectionGUID: i/PGsu/KSr+KevIjo7YEUw==
X-CSE-MsgGUID: Ro0U/riCSiOu7sD5yMiFLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63540564"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 21:00:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 21:00:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 21:00:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 21:00:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/iwGcO1TqbN8RzqReC5p1MYfWDgXh0nY/xuVEhZ+0KUndPI2n/afZfj2QzWa/FHvc9+qnc7qVowhCjgYS9+nLfgvzgt9fPlJzqz5kKgDmaRkDSCHdP6K40FJ7vBZ9SrOmvIO4bd4fJd/mkRgRL5vWLC3+iXfVzovKuh4JgUKG3R8Dm5/YG2UAhQaMmCHZ8qKEt2Kgs5mO/GG6Cqab0QBUCkrIYZ3I0AXuPPgyh0R8qqwKs12vMMzwqfXfXZ0suU94peyU1qeSYq/EYFnblaRie2GsjKtYQm3wgamwU5czKXjsiJe3FS/ye+0aOAWQvqfbmUCEAHsviScj2m8Jc5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=totFBLJwPcLmEtv9fuIP9UXhTa1gb87ElMTE0uqEm+0=;
 b=NF87KsUVT2auOdBEqekClr92FSjVrdXi0myJDLhMxLMHuujv+uefbqEljuiNHmW0FrME2+KUJcw+AYO5dWeniZN/E1mi29vFlND2ujP78kR5jx9/w5nNocJCSdDhnCa5CzPEnuvjLtwrjnpSYLt45ZLQ/j+2Eq7krF24xaUxCGt5uwA9Nzjw++t57lGt+TxQUPZZWOu6CUaRvfg7Ej+Hd7ySclcvCByVvGx6Enaou5QaDhnGS7PuxsgMU/+1B1FnM3dYUWyvNShHdiRvNVLptO+OBE9zLMNzYX+b9BPLEYAqSZom/YrE4UbmQfnVH73xGyBBmxtCOFyqfE2je+dyRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Wed, 14 Aug
 2024 04:00:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 04:00:47 +0000
Message-ID: <72e612b3-0840-4cbf-b5fb-85ed3be4cfc8@intel.com>
Date: Tue, 13 Aug 2024 21:00:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/39] x86/resctrl: Generate default_ctrl instead of
 sharing it
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-9-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240802172853.22529-9-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0124.namprd04.prod.outlook.com
 (2603:10b6:303:84::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b90067-8694-4aed-e962-08dcbc15ad91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3A0U1dTb0NvZEhTUncyamcwN3hKQ21jdWlqZHZ1ZDE1V1hGSVpleStKSUlR?=
 =?utf-8?B?a2cwL0VJZXI1VUxVSkd5SG1HUU5Cd1ArWUtUUWJJNnhhby96cGNuRUcyZkRw?=
 =?utf-8?B?SmZUWFRCV1RGRDZVMmlzL2NLQzM2Rnd0TjIxejJRRXFYRzEyYVZpbERDRFZv?=
 =?utf-8?B?WFZmM0VuSUtnNmFsK3llTVZwOXRaVXBWN2hwRCtQclVkbUFKVzcyR2UrcWNv?=
 =?utf-8?B?VkwwWnFTZkliWWE2VjBaYTdIUUhhK1UybHpzeDR3c1BhRGErcDBZNzVuZnNs?=
 =?utf-8?B?M2hWTERYVkk3YUxSdkp3MVVTR2kzTDlRR1dPOFI4cDBTREh2TGRZaXNWV1pz?=
 =?utf-8?B?ZkJQMElKa0JSTVlsendHYWIrVUJCMnp2dzQzMTlLeGUwTTRZd0NDZEJyMGVi?=
 =?utf-8?B?cVArZWtDeTc5TTdIUll0RDBwWDllQXlpaGg1dW4rN0RlWkVhekJ2RUZNNUYr?=
 =?utf-8?B?NnQweVl2M0ppUWtBWnREYzl3NENzY212LzVxU1luWHQwdTVMSE54bWZteE53?=
 =?utf-8?B?eDdMZ2dkMmVpRGlHZWgvVU1YN1ViK2N2eEd6dVRUaTlSUFBSRmhiOFFMSEsz?=
 =?utf-8?B?VHQrOVg1WGlPU1Zsd25UK29MSUVSSkxvWWM0azRSVFgzVWZ6Skxuck12a1hV?=
 =?utf-8?B?Z0VDZjBlVXlhRzhXRlM0eWQvUDc5RzFIVTdRWEhIWDlqZW1leVlQeWVyc1M5?=
 =?utf-8?B?ejJ4OWtXSks3RWRXV0ZjZ0hjY04wU3ZiVXdDeFpJL0x2bVVnRFBNYXJJRVZD?=
 =?utf-8?B?NWFiQlhvaVE5K0R2ZTdnRGIweWxIOGxjSmVsc2tSRnVyckRZWk5LRDAzeXQz?=
 =?utf-8?B?OG1lRlYxVFVQK3FYVmcyMnBpekxDRzFKcEpaeFg2R3hiOGtyZm1uTUJHSXI3?=
 =?utf-8?B?ajhZemtwSFRjZUxsVmc1eXpwelJjZXlZbm4xYS8yTDRtOWx2NzZsbWpRWmJ2?=
 =?utf-8?B?SG41OFdNYXBLRnRGSmkrRlh3RGNmUzNYRzJVYnNMaVdTNmc0elFSbHc3NWlq?=
 =?utf-8?B?YlZMRlA2SFJkcmJyMXJPdmtNaUFaVVpOTkNGMFpwVFVMRWJnVjh2NG1YTU42?=
 =?utf-8?B?d2gwVTlRVG9uUHMxUnE0bzQvMEtoMGIwWHNMN2VWRytyR1g5MzlpOXNVWnhB?=
 =?utf-8?B?WHFKOE54Y01wTDdET2ZxT1J0UDFGRVRPekI0clgxWkdjdzVMcm1uMUNXdklV?=
 =?utf-8?B?cCt4SWV6VXBtaWdJN0cvT01mRVlULzh6RFNtWGNaa3NFWlYzaTZ0ZjlsSGJE?=
 =?utf-8?B?LzFRYXRhK1pRTmkwak40SjViZkpZU29LVzdyMzZQK05ldWVsdDV0YVlZTFZu?=
 =?utf-8?B?NFpwSVZ4M2h5VzlWUndSOHJFQmp5M0RCT1VRbDA0NmlBbE5zekVyTGdSR0pP?=
 =?utf-8?B?OUpjaS9hVVJWOHlPZkVxM2pDVmt2WjVnWDRkdTFzM212N3ZCeG95TCtjZm1I?=
 =?utf-8?B?WG45NnRrYURxK3hBZjVoNEFqdmNtQXdTL21zNUc2L1YrTUpub1A5U2JrdFFt?=
 =?utf-8?B?cEw1U1plZzBpSmZ4ZFF6SmNxbXVTZk5vTHFZUWNGNGE4c0FsVTAvRFBpR01C?=
 =?utf-8?B?Y244alJ1SVFkU1d5cTVXVFFrNlZYQ0Z3RUxkN05qSUVLemk5YWZTVXRVSjJP?=
 =?utf-8?B?WnM2UExqNlZTYWM5VEo1Q0VLa2kvRElJOW16SEIwWXRlWlRiM2ljSW9TSlFu?=
 =?utf-8?B?UjJIQXBJeHhhZVd2U2szUmF0YmVkKzFBQVpBVU9JdlNXMGpTc3hleGwxckNr?=
 =?utf-8?B?QldZWmpVUE1hcjNQd1BMb1RFaHV5d0R0bWdsMzRKRllVZXplbS82eE1TOTgr?=
 =?utf-8?B?cGZjVlZPanp2ZG1hWFZGQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzBrYm5MNXgrMlh2OGVxcFR0c0lETVdUZ0RoZXhCWHhGcFJtdWt1ZmswSDl2?=
 =?utf-8?B?OXAzNGVuMmNiU1E2V2dwamQ5SERPVFBGOXpPazhCUnlMMEluNHJWZlNLenpj?=
 =?utf-8?B?TDFWY1ErZEo4TjVUcnBibnJ5SDhSWUJ0WUJzSmFnM1R5Uno2cWdDOU9iWVZX?=
 =?utf-8?B?TjIxMmVmY2tzZjk0NVBuYTNaTjkxRXpKaWZNb3FNV3podkc1MC9GWjZiUnJR?=
 =?utf-8?B?WkJVajhLaTNtS2Jqci9TWFNJZlFtYXBhdU1HV3NSSVJodVRyR0t5a3ppUXFs?=
 =?utf-8?B?aGVkcHp1SDExQmpjNElHY0FTNFRuREZkOUtwaFhMV3Ava1NpcGtmd1dPZC9i?=
 =?utf-8?B?d09ZSEEzcHBQS0IwdWtOYkRFUkx1L1M0dDUxV2RLM3RUakh1eVhhdFl0TjdU?=
 =?utf-8?B?dzZDOVRHV25rNXZxTEszdjlsd1Q2NFlRTzNSdS9qc3B4WGh4T3ljMDZub1hx?=
 =?utf-8?B?NnV1WjlaT2V1aDVzczhYWFo3NFdydVhrcHZ0ODZzb1A1YjF5NUp1eUhzYjN2?=
 =?utf-8?B?S091dGdxUkM1a0ZvRDI0WW9BRHU2TWIzdHk1OFJRMlFmdGM1d2pic3dQTlJ1?=
 =?utf-8?B?UG5NWHlKbmRhck0yQmN2OTZWUHJ6Vjdsc09rdDNKTUhrYU9kK2x0MUwrTDUz?=
 =?utf-8?B?WC80M09BRlRKbndtVS9FQXBIaFk3SHR6UU5HMis4dHZXMGZJeXMwUmRta2VO?=
 =?utf-8?B?RjlxVUFOTjRBNHZoM0V4cnRTMk9ISUREQkZwck0ydlU2TmdUbW9pNlNVZlBW?=
 =?utf-8?B?ODZIc0hrdCswUDNGdXRDdnIyTHFIdnY1cm40RUI4MGlWY2JhWEgxUEFaMlho?=
 =?utf-8?B?V1QvajlRck82VXR3Q1FGb2hzZDhvM01WcjJoVXZwVmlPMjBNcFQ4Ynhyczd6?=
 =?utf-8?B?YXFmU3NhSjR5WTdVdFBhY2Y2eTFnVXBjb0QwSk90dUpKVEJqODk5SXByQm9L?=
 =?utf-8?B?dHRYM3pyYnNmZk9xRkRSaG5sOFRpWS9tVEZYQnRUTHhVTUhyY1dtQktRZmVH?=
 =?utf-8?B?b29ZeFF4aGVyN0dYcjZrTk5KL2xTdUhLNDJ1aVF3OU5MdHZQR1d3KzhwejM4?=
 =?utf-8?B?UEFRRExjNnRDeDFzazVpQldOVDBqUm1ubW5GMDN1ZFNHZ1RsSm1JcThVc3ZK?=
 =?utf-8?B?cDc4UWNFemxTV0YrbGM0MUFBSHhaM1hCV0ZyTnd5TEFjT1Vwa3BvRzlqY2RK?=
 =?utf-8?B?ck02VXJ2VGF6eW5LUTZHUXArTm90M0xZSGtad2ZuVTkwNHRQbXNBTXJRakxV?=
 =?utf-8?B?bm55OHh4S2NFMnUzVHhuRTh1SFFJMWVtTDNOWEF2WndzZktjdUh5MFcrN1Rr?=
 =?utf-8?B?b1d6bG9uU2dWUS9WM2d2N0pRQVRLZmFlOWxseGFkd2RpNjdiTFo5SDZJWC9o?=
 =?utf-8?B?QVZ5RFJUemFGTXdNY2I2YzJ3d0VPdXFIcjNkUTdLZUJ0dkJQOTF0MWd6clhq?=
 =?utf-8?B?Q2lNd09VUUpmd1hMdjdWYjBwZVlwRkI0RWo4eGRDdVZBb1BqQVAxczMvSEV1?=
 =?utf-8?B?MDFraDdVVUJZcjNBQVpmZk55Y25EdnlEU2FlRWdwZ1VlMlRVTXRtU3JjQW1R?=
 =?utf-8?B?Z1lpc2tSODdaVko3S3NlbXdXanJEdTVkMk8yUDV5cFRRY0VrTUUyd3RqVzN2?=
 =?utf-8?B?eEZycXB1Nk5vUkh1VHFQaThCejBmZi80ZU5sZDV2TldRV0FoRDNlWTJJNTA2?=
 =?utf-8?B?UTBRbmx2TUFOeUloSFVxaHQ0RkFLOU1qK3d0cnQxeitLM0g2aGJncCtwMnJS?=
 =?utf-8?B?bmlYNTZjTEd6R3VZRmNVRkVNUU1MdGxmdmJrZTcxYm5QSStuYXZ0Z1NEa2o4?=
 =?utf-8?B?TENuVHNzQnNRWGxCUU1ONm5PNzBhSFlDditSdS9NU2JGYjdaYkhBSGtwVG1q?=
 =?utf-8?B?RGR2ZlFacy9qZXgvbHJIdDlLSlFydlM4b1o5SFFjOXFKMFd6TVpZN0YxbURu?=
 =?utf-8?B?dStaeHFSZUNjRnMvcmRkZ0J1Ky9Nb1ZhZkVWYmh4eDFzemhycEljRW82anJC?=
 =?utf-8?B?aVdnbEUxeG1ld3NHQ0I0TVEweENzUVZnTDhBTlplcC9PV0xvKzF6cE95R01L?=
 =?utf-8?B?a29xR0Y1S0VSdWN2SHovVWxuYnZ0bFJuRTAwWktmeXhNdXJsNkt5NWlEWVpX?=
 =?utf-8?B?dXVDcVZkUU5TeVlsNUtHMlhwckhtdkN2TmdIekZ0clFTSzAzeTRIUzUxNUFp?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b90067-8694-4aed-e962-08dcbc15ad91
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 04:00:47.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUx6deKP2niIWpeDOim/Ws8yBDGJIlNiUPPcqnyUpR6i3giiF41+m8Ral8OFSM0TBKsU73k5OcRv3zgqVrdlBCdb2gGXJqmFtKmwGctR+nE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-OriginatorOrg: intel.com

Hi James,

On 8/2/24 10:28 AM, James Morse wrote:

> +/**
> + * resctrl_get_default_ctrl() - Return the default control value for this
> + *                              resource.
> + * @r:		The resource whose default control type is queried.
> + */
> +static inline u32 resctrl_get_default_ctrl(struct rdt_resource *r)
> +{
> +	switch (r->schema_fmt) {
> +	case RESCTRL_SCHEMA_BITMAP:
> +		return BIT_MASK(r->cache.cbm_len) - 1;
> +	case RESCTRL_SCHEMA_PERCENTAGE:
> +		return 100u;
> +	case RESCTRL_SCHEMA_MBPS:
> +		return r->membw.max_bw;
> +	}
> +
> +	return WARN_ON_ONCE(1);
> +}
> +

I am concerned where this is headed. Since RESCTRL_SCHEMA_PERCENTAGE remains
in use when resctrl is mounted with mba_MBps the default cannot always
be 100u (it should be MBA_MAX_MBPS when software controller is active).

Reinette

