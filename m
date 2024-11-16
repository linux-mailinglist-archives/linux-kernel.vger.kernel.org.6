Return-Path: <linux-kernel+bounces-411536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8659CFBA8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5AC1F21AE6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24414A28;
	Sat, 16 Nov 2024 00:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqDXACrr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14641361;
	Sat, 16 Nov 2024 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731716678; cv=fail; b=a9YVYdrEI2QnGFmjQXkWp5F88kwQt7nALjcljExFpo+mpaejqp3y8Jnt6+KEt7YXu9AmpmHcPu6gO/u4mR/lmKGf2q3SzkV7cRAf/Vv1uMfMtxlaBYnXZmv3dtDEW9EYlq6+qUr5mkT2DPim4M1XXxtd5ebmKydXenHzc+4VhvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731716678; c=relaxed/simple;
	bh=m8rmKahun/56ugeECPWxFa/8oRSE5MfTEyRYg31A1wg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uITJmI6igvewk+EvFhLYossl7NcNN8YfWA36eYOejyZtGxdybzv3BH/kQ40lXJVzAhw+IKnVOZBEE33DOGhMVLtHOHouuLua3RQDBHbkCyqQFw7S+EjVhinHITG7dKdmXR0IOenFUV+VvREnBpww5Etbs5NsWWo39TxF1AUmFCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqDXACrr; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731716676; x=1763252676;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m8rmKahun/56ugeECPWxFa/8oRSE5MfTEyRYg31A1wg=;
  b=HqDXACrraYOgtzRfU5PNLLI/j24Xuak8CK19EYQAnVARxaXa1N8jBi1p
   Nf7qUWAzcrmGYHAfQE/y5PXTiS0j9bGc5QNRpn+0fXAT4J1S6AFfkbhbk
   BaBwqg+78U+s7sl1rSfO7OavEDYYHuEE56U4AfaLkJKaSXEx2X6c9vlpG
   GumfSy3jVTRHr9aEWxnxMyuRShnl3wSChNu0HoS4KinQTNsa7qy0OOQUM
   WMSztnrH1GE8Iih0C+TttST5EPNT6M9fjylp0yG8Ms6sc3LU12yhK7CL1
   yTtmY8CCbkK41daLhJCSTA0ynvOwjvFngPnBi73fuyQ+wZ+XqyuY4Y2gH
   w==;
X-CSE-ConnectionGUID: aDPZCZt6SOamJirT8IbqnQ==
X-CSE-MsgGUID: SYe/rTWYSW2d8g18hsUv6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="35667138"
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="35667138"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 16:24:34 -0800
X-CSE-ConnectionGUID: zG22Um4cTeuY5QE96QmPcg==
X-CSE-MsgGUID: 3JxdyN6UT5q9hJzBWVKcLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="119648434"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 16:24:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 16:24:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 16:24:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 16:24:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRHQ9adnv7AlnBcFKRjP5pixrV7p0RjyW89ohAxUBXmRhAtBHQCj23HdYaFKiSmGyhICoRk2R2UPRtQ/k/NNu5rv4GvOIO2wPeyG/lPXIaKf3d73w69J1eGzF4oGerCKilptvU4hgDR50NMj2O+zJvmh00hlu7WGEchErN9baz/KcqdphmusdWO1R7l2Qdznz7QTiun8Wzwdk9lQ8DrEVFLnPdEtYwkIuu5GuDYBxm7faLyFMOf0Cqs3V7kRDXaE1Ra4Li8NOLuKvS4PH/2vx/siaqTh7YLJilbb2nqyifQf5pjIF7Oo5k0Jpi35O6SpiQKLKablE3va/PcMtzuleQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3uZFjLXw97ELZBcSyW7BrLQftiE3kBqQOoPPGqr/MA=;
 b=YtSZ13NKQ6/H8cTBAU5fDQuXTjjXOuSmjA6nXpQHobcxNRAETu7TOn+wnwPL/qBPl04BaMdNCsDkhzlZ6uGtGh21ubMmaeyoh6AlJRexButHmIEcbUs8OaGH6sgutBrJVxLITAav3O1GL4pGr6XKEuqpbFzvDQTpj/Bnc3wEVShR+fzmzzEe6rtlcYI9gln/hmrikhDZ3sVUTMae+Cq9rIJLCApx4rnaBSmgnA2Rros4aMm6t5XKU65eGbR5fKykNwEn7gOD6oSpyTDXmJQB41sLJibm5Hy2P8MrOj1IhQ7rTXIaqUOw6edCALhjFOxjTfI8/v7nAoD7WvwYmLCuYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4737.namprd11.prod.outlook.com (2603:10b6:5:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Sat, 16 Nov
 2024 00:24:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Sat, 16 Nov 2024
 00:24:29 +0000
Message-ID: <f653969d-b946-43df-a5ee-d5153589bc5c@intel.com>
Date: Fri, 15 Nov 2024 16:24:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/26] x86/resctrl: Remove MSR reading of event
 configuration value
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <jithu.joseph@intel.com>,
	<brijesh.singh@amd.com>, <xin3.li@intel.com>, <ebiggers@google.com>,
	<andrew.cooper3@citrix.com>, <mario.limonciello@amd.com>,
	<james.morse@arm.com>, <tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <3180058bd0b5f80f8525063698c6d5971165193a.1730244116.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <3180058bd0b5f80f8525063698c6d5971165193a.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:303:6b::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e03d9fb-1b67-495c-7eec-08dd05d508be
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHVPZlRHbUgrdHdNdGYzSWNlOE02RHdxWWFZczd6V1RhVFRZZjQ0ejEwUG1X?=
 =?utf-8?B?YzJHRElqdCtHcjJFcFRsc1VEWkZrTSt2MS9ITzl3Qk9LMXFVQkJKMTV3NjFw?=
 =?utf-8?B?WnZkcnFzQ1dTWjFWd3U4WTBhU09QRVhiQndwUHRiVEJwVDcrRHJDOENXMG90?=
 =?utf-8?B?TlJMRVZYdGlTaUZmR2dmQi9xNVJQVDA0bUZHcTQySVhTRVBOMllGQWVtQlhz?=
 =?utf-8?B?ZGtveXZQc2ZQeUk5TjFEbENRSVNlaG5NNlgwY21hM0plYW8xRGh6OURHSk9S?=
 =?utf-8?B?TWdoSk1zN3craXduQTZjblU5SE1tMW90cGVFbkYwRU5oVXhaZ0dabnAvL2pj?=
 =?utf-8?B?UmdDdTdtV3NCSkk0L3MvdWU3dHRndUI0V0pvOW9IZnhqWEdlUlY3cUxtQmlu?=
 =?utf-8?B?aGFaK2dHQkZKd1ZsUUJ5MzJKQm54end5SStXbWxCTDRyNHEwclJvajBBeUhv?=
 =?utf-8?B?VjJ0NWQvSFlvVDdTeVc2OFFQRnEwZDRxd3d1RjQ2VUt0aHRFVElUMmx0VVdL?=
 =?utf-8?B?NkR6TTMzRXBydy9OSHJiQ3prZ0J3YkRlMVcrYU1XVnlRVnFhclpabmg1OVZG?=
 =?utf-8?B?aDhXNWRXQnc2dWZ5R3VpM3RhWWFrTTBiMkxMZWFzWnVDcHg0a3QvMCt1Qzh5?=
 =?utf-8?B?TW1ybU1HWWF5ZlMzS200S1V5TjZRTUdnR3NUTDBUTk8remhIQ2sxaithZEpu?=
 =?utf-8?B?bmIrNzhLSEtsMU16ZUw2a3d2TzQ4TnZMNHgxUzdGYlhGK0pTbEkvMGRpVUoy?=
 =?utf-8?B?bGYrYmRDdFN5b3R6VEE1cWY4akpqMXFGU1ZabStBYWw4Sm84aThiZGp5MXhR?=
 =?utf-8?B?Nlh4alJycU5ic2R5U25iZ1ovaEdMT09jdGQxZjRBejNGbEZmai9YOTFRL3lE?=
 =?utf-8?B?K1FkTTBBVERPTXFsQkxWNnQvdGxSZWpGUjU0VWU1b1RKUFdLK1hWSDA1SjBZ?=
 =?utf-8?B?em9GU3NVZmpkMXVoMUlkZWQ5amt2QUdrUlRSbXQ5NzM5U252UTlXMk5KZG5p?=
 =?utf-8?B?YWFBZ0NFUVRUWjB5N1pKUWd1MDV1TEx2TEpIald5YTc4NHQ0MUMwbVhxYjVZ?=
 =?utf-8?B?ZGtTUzFxN3NtVElSL3hqUks0OXJ1SWFDTWZVdXFSVHdGc2Q0REwxSTJVZjZs?=
 =?utf-8?B?NU9BQ2ZFSGRnSWgzaC9nem5QYUcxUWJoZFFsdm1xcE4ydnpJUXVMMFdrMTEx?=
 =?utf-8?B?WklDMnRPaUpJZTVaSkJFemtuK2xqZ1l4RGtFTUhmZFFsWWIxQ2hheDlMUExv?=
 =?utf-8?B?MzVkTmpXM1ZjblpXZ3Vva0QxVktzWDZUKzkyQUlGUUoxaTl0RXlEVGd3dnBJ?=
 =?utf-8?B?MTBPVmR5VGFEaFJNQmR2RkhUY1JMdkcvcXVpdjJjZlAycUVELzdkZGlva3Rn?=
 =?utf-8?B?V2F3Vmtic1pQemRnT3hmdDJQcElyc3dBNURjOUdCaHdObDJFQ29pZDliMjhv?=
 =?utf-8?B?b1luTDJnZmcySkFMZWtPNmF6Nm1JM211SXlPUHFseU1qR2IyekpSWGRhMW9P?=
 =?utf-8?B?ejBmQlVkK0k3V1RxZmRCb2pCcWpXSnMycm5tNzR5N0lkeWoxaUNwQjdMQ0tF?=
 =?utf-8?B?bHdoK2hLR1NmZUQzSzk5dVFLbkQ5RDJOTFA3cnkzTUZpOHg3aU82NmlGL0E0?=
 =?utf-8?B?RHpONmt1ODFBUkRqTk5ia25oRUExRWZUWU1GVitGQkFTR1B2VThOTTlQTVBR?=
 =?utf-8?B?dGdiWEVVYVlpUDBvRzVTVkVTeTdUcGNhajJnbHloTjhURE1CdHlTVnQrNFRY?=
 =?utf-8?Q?ZfBz32QHguWevhWJKeXkNhDKm9xeU5P1Uc4KwtE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3A4NlVqdE1oWjdBVXNQWDVQOHcxdnBJV0RyRzF2QksyZVZWblh0UVlyQTNV?=
 =?utf-8?B?L2hSSmpFdkx6c0xUYnRaY0g1Wm5wejRJS0pVOWN0dUJsbWEwVndhUUVWWWNa?=
 =?utf-8?B?YjZXVkVlTUYyOXRlcU5ETlpNWFg5RGZqM2JjeW4zRGNXVzh3bzVnVXR1RERh?=
 =?utf-8?B?RDNacWlMbXlWVjc1T2pEMUx4eWdVemJnQnhvd3Q5ckxJY2FhTjNrb1YyZlBD?=
 =?utf-8?B?SW9iUDJwVTMyMk9ydTdFZEVid1krQVd4KzlEQmZpczhta0UwSFY3cFdxY0ZQ?=
 =?utf-8?B?a3lnMlJMeFVsOGhCbU9GdEU0cXFBWTUvR2kwRE5KRFFhTDZtQ1ZMa3BqN0JK?=
 =?utf-8?B?RWYwS2xDQlZmNER0Wmk0VG82UUJNbm5WQ2FuM2FqNzl6SWovbHlsTW1mZjZy?=
 =?utf-8?B?aVJWUDg1R0ZKVlZmZDBPRVZGZ1pqWWJ1ZFl1bXdJRE80TU5ETFh0c28xeVZj?=
 =?utf-8?B?bUtqd3Q2MkluR1Q5OGpxd2lvRXc4RjEvSm1sUzJlUnFUQXJYdU1HL2RBKzQ0?=
 =?utf-8?B?MVUyeVkrVzdVd2dxUVIxY0F4c3EraElIUHJHLzRIMlNFQ3hCNUNxUkExbWNH?=
 =?utf-8?B?YTFmUGo5R1lSMTdjdkd6Z0I4UFBaeWM2bENaYTVlRU1BWlU5VE1wdmM2cE1p?=
 =?utf-8?B?MkNlRTFzeS94ejd2WTJRMUtSaE1za0x0Z3NYQWw5NWpIZkNRd2FMUU1Cakhz?=
 =?utf-8?B?Ky8rWEo0dzlCYUdoK2pXbytDOXpscEtwMzhPNklhaVJvK2x4VEs0aTF1ZHU2?=
 =?utf-8?B?QS9WUzgrMTNFRjVJWWFJQTBHbGxHajNrT2xjaGppelBoMFpKRmx5WGFraVAr?=
 =?utf-8?B?ZFJUMWczYTRMTzliUG9NNmlEYWxUM2NaSFk1am9LMy8yMEtQcmNDdGtOTis1?=
 =?utf-8?B?VTRTajYyMUlHcVpjWEgvVUlibDZhMWp3UEM4bGZWWGlkS1NLS3JoVUhhVWlr?=
 =?utf-8?B?K3BXQnYrMmVRZEtUdjRuLyt0dDZsTXlyUlVIQ054M21ZYWdDelYwNmhzbHhB?=
 =?utf-8?B?ektnMXNrRklWUkdORk0vTmZwUmwxSHZ4eXp2TjZteHNBbm45T2grMis3UEM2?=
 =?utf-8?B?dXRXNzNvaGJVMnVBUUhENzE5RGRMQWJpYW95VDc4U3BBcDFmanlPSkhJYTJR?=
 =?utf-8?B?SlZPMVY0VzJ1R1BzUitYQ3BJemlVNFg1MmM4N0c3ODNFODF4WlM3aThreDh6?=
 =?utf-8?B?dnRsKzBzY29Lb0pBR2d2dDFaeThnMEZMNVM3TTFNL2ZpMFRreE1OU2IySnJC?=
 =?utf-8?B?Wks3SHpHK1Z6Vm9peW5uaGJ4OTZCSGFjcGt1dzAwKzVxMmh4OXdsZmlncFNv?=
 =?utf-8?B?elVIZWZwWnZFQzUraDhCZ2FJUlVnVmRvKzNUVW55MmNCM1p4aktGbEdocFpv?=
 =?utf-8?B?c3FzbWNEVGRGY0ZSSkQwOVpSRkFDQzRERkxFMHErZ3cycGpWd3dJeEZvQUxv?=
 =?utf-8?B?aEpHcCtUVmN1RDUyQll3ZWFYd1pncUlkUFhZa1dsUjV3WEpocnVmRU5CV0RB?=
 =?utf-8?B?dktkbVpHMENGTUtPbEdTWlpFZmtOT3F2RXJFS2V2OTd0Um1EWEt2MnJpQWl0?=
 =?utf-8?B?N1FDTW5xemhCbDZGb1FWYW5qQVQ0WkRaMzZPMElITXJ3TmlYZGJ0eWJGc3c1?=
 =?utf-8?B?NjVsdXBweFFoM25uc3NXZmdXOHFUQVZHdXZ2clo1UlZiaUFyN3RoZ3BCSEFE?=
 =?utf-8?B?UWpZK0h5SjFENWlsZmVHb2J4T3BRYTI4eFR4Mi9SYWRxU3pEWE0wTCt5bXN4?=
 =?utf-8?B?NUtmRUEwRTRkbjh5aTVHZTR3R3UxK2pNcUJaQ1JETWJGa2FWTXZ2L3U3MTNH?=
 =?utf-8?B?QjJXekxoMXNJODhJN1lLTXZaVlFTVzNoMll5UmFNRlpUZ2h3VUFhVVZscm1K?=
 =?utf-8?B?R3UvR1RZQ3BuWTYzWGdqS3lCbXZLSXFFVnBRaHRNYkdMQ3BSMi9wMUlUL1Js?=
 =?utf-8?B?M0xLMWJCUm1XaCtnd01FTm15RzVZQktjeWVGVEhIN01aUVFZVUg3UzU0NGIx?=
 =?utf-8?B?dngrS0RUVlNaT3B0cUgrbEswSytHcTJLWGk1OXc0T1A3Tzhsc2U1Rzd2OWh5?=
 =?utf-8?B?MnJCcm9pYkx2R2NoeWY5TXBGTDkvcHY3eTNoQm0zeG1ESjR6dFhoZ1grcS95?=
 =?utf-8?B?MGFtUGs1alNhYTZPWkM3eHJyVGVmTU5YLzVwY1hNVGpiRUxFT2hUTllONE9x?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e03d9fb-1b67-495c-7eec-08dd05d508be
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 00:24:29.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pM0MI7Hkfy5I164g/Khcii4dQuDzWaC0uQCFY70pyUKb/YpUL4n7tg4tU4QJuQ5NpVtKEqVvt0s89joJ1gVaHG8VyH0A7G6DKHyKml2u2Jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4737
X-OriginatorOrg: intel.com

Hi Babu,

On 10/29/24 4:21 PM, Babu Moger wrote:
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -354,6 +354,10 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
>   */
>  void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
>  
> +void resctrl_arch_mon_event_config_set(void *info);

An architecture that may want to use this would need to know how to interpret
the info passed. For an API I thus expect the struct it points to to also
be available in this header file. 


> +u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
> +				      enum resctrl_event_id eventid);
> +
>  extern unsigned int resctrl_rmid_realloc_threshold;
>  extern unsigned int resctrl_rmid_realloc_limit;
>  

Reinette

