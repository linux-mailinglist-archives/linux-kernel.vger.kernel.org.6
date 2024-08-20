Return-Path: <linux-kernel+bounces-294558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460BE958F38
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700351C2236D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2752D1BB6B3;
	Tue, 20 Aug 2024 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGmdCKrJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980DE18E37E;
	Tue, 20 Aug 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724186234; cv=fail; b=BtXGUjlsf+MMXgqZVDfAB5ceSq9WMlk0drUCA+3/s877IbSghnurcG/jMy9UPpbbQGH084sAe0V3wjqbOtu18wxfqhsL1qqiob+zfx+nfadJzG510lS0fm8imULx0PXdsG/7GANhl/ERsqwlL4+7LromcTzXgneQR/pOs3v14A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724186234; c=relaxed/simple;
	bh=oPN6grJ+d9DpTZwscfW06GJFK3FyzT8gCVFo1+hjeKQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kqODmrw+9x//9g4odqiTCh/+Xzc+dYEzCISL9u8B87RDIvM1J13DXMp1gnhuBosy4Z8QLq9z9FeHUTVrUEETINJbDWZr57nKtjGu40HfI5YcdTgFz09UVVbHSoELnpn/Q/Gr0bA9ceREymGi1S0F+WHGR9WMzQGvFdBmd9mN8Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGmdCKrJ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724186231; x=1755722231;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oPN6grJ+d9DpTZwscfW06GJFK3FyzT8gCVFo1+hjeKQ=;
  b=oGmdCKrJlP7+S7AnbuQrIpL6rYrMWM3a0P8EoSH7mjZSNM0j0nNTd/UU
   7LiLDVE67bCii/R6JOmGkVN118x/gsRowDF68ViGe6n6YuTTbshmnWU0+
   P8rpf8MV/vrZAY+gJ0sFNxt6PC3JcBgZlBIrwVaGAhTBquViYXcmWG4ev
   G4N0Iuecz+xuS8CizTt1OOSSgUBbYe73+acyPhZDVWbvw21x4J3AND2xH
   IsbtwfxfuNYdTVMSl+drWNwWGwxVpQy7Mrdivu0T4n6yJLE/q0RObw5Ah
   DdBZIxP4u+nphg0G0C+g/XftWSlRKGHCTAh20e00JIvulTfglyhYnPupK
   w==;
X-CSE-ConnectionGUID: 2ooZBJCDSqipE8r3mcQAQg==
X-CSE-MsgGUID: T0Bdd/TrTWOCHViAkn87uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="39971970"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="39971970"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 13:37:10 -0700
X-CSE-ConnectionGUID: MALekHihQUigWIvw9qCuIA==
X-CSE-MsgGUID: EvVPC3aeS5+Byurr79HwMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60821072"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 13:37:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 13:37:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 13:37:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 13:37:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 13:37:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTQJs79+xtnlRMtpwupKGJMwGg5JtrukS1wq7boqLOZ0d/qLxNor0LRjRlgLCdoxFez8k82qB3DgcJrqgzfILBUX4Zr9K10Iu7qVOKAgqnGdPRh9HI/z3NxZwyAfdi7f9hdmc3JJOU8myqYoc71nTKS41kbBGTBV7IK93gtdmKhFdUYaYbJ7cbLACcw7ujRv/aP4fztz3T1KfxLwSVBsmzT41X9TBhqdeAx4RBQDch9FQ9ihWgHi3vFwfs4vvA90gi6n0twiPuVI2iuhPF+NAiqoXC3dxoRGBSFzPBY7pVFbUbNGZqjFecfpBJ2JakdWRNLbywreCgWFNMkwWuYrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkjajvUb65bKbMZEAXntcVdFukW1dtFlZ0hoX+WMMUY=;
 b=c6zvPPD2ldCsgelL0WgZtN9ErmW6imgQH3OINMgnPIAIKBRWegipEOSzBEMAk8AW0GQV0iKhqHy3kAlP4eWoDOvzFC9255v4mUp3M/sviE/6foROa9VByBazgclgZf3RNpdQMP6KyBTck53YpdMRSrSWXRmJJDcywOKJIrgd0hJaNhq/PSA/0WqRaqDifxIpcWfRFbxECa5wikTzpn4QGDLcXwbrE21hF50fxI3SmALIb9IZP8hN5MyuC/cPSn5tjXvUK8d0hqTqOlAYsp+LWyCRTQBe6QR4BwIhzAO89d1fBo+QTr7g7Dz29q4XSBjwu0jaPjiSqxG/N336VHqqSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7027.namprd11.prod.outlook.com (2603:10b6:510:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Tue, 20 Aug
 2024 20:37:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 20:37:06 +0000
Message-ID: <dd3fcfff-4e8b-4a71-b6c3-1e188d61a4a6@intel.com>
Date: Tue, 20 Aug 2024 13:37:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/22] x86/resctrl: Enable AMD ABMC feature by default
 when supported
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <1061a60166f2fdb508aaf2dd9163b2bab3705063.1722981659.git.babu.moger@amd.com>
 <ab979768-a98b-417b-b319-6f14da88b857@intel.com>
 <16263da0-603a-44a5-b6be-58c66b8dd863@amd.com>
 <6b1ad4b2-d99f-44fb-afcc-b9f48e51df6e@intel.com>
 <b80a9e76-764a-4303-ada8-aa4d08559664@amd.com>
 <f36f5459-cf5a-4401-8a00-cca83c293fdc@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f36f5459-cf5a-4401-8a00-cca83c293fdc@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:303:8f::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: d999a8c0-64ba-45c7-e46e-08dcc157db65
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEFhWC91Y3htaUo1aUloenJXWmdvYitseEdobi9PcjMwQWNqcVlodk5Bc252?=
 =?utf-8?B?UUtDRmRvblBWNEFBQlIyb3ZYUml1RHVOVElNMFhhUnBqU2JUMFBQb3gwNEFo?=
 =?utf-8?B?NzNSN3d4MWJPQmpUUmRobmtJbDZUNjZFa0gvOUF2S1lucFVMSUJKVThIRU5E?=
 =?utf-8?B?TUlVb29QWHovcldvTFc5WEhjVjJqeTNNOU9jSUxjUjNBMkMvU3pRbVhaSTkr?=
 =?utf-8?B?L3dYSEZYMWUvNlZVSTZwRkVkVUhPRnBjZVVlNml0Y1dvNHFJL05xcW1yckdV?=
 =?utf-8?B?WWhGMUNTcVVlaDV2YnhrcHBqR3hZME1wT0tnVG52ZGxKRXl5ZTE2SUhqTjha?=
 =?utf-8?B?dFQzVGxQcTI4SENDajJ5RDg3b2ZBWkhyV3RNUUFYMXUyWTNjRGFCNHVCek1q?=
 =?utf-8?B?UXEzWFh0QTJqMXNVK0NNOTVQcm4zVUhMUklPTzFKdWdCWnFWWXBtbjhJTFpk?=
 =?utf-8?B?VWZ5TGEyUUp6UytGbm12UGtBUk5ubC85T1E4czlkNHNiR3gwOU83VGZ1QXMy?=
 =?utf-8?B?c0twVHU1NXdtU1Q0eDh5V091eFJPa0lwSGgrK3Q5YmpmNklqbGRsVFlpc2o3?=
 =?utf-8?B?VFpmWlQ5Z1YvVlBRcCtaSDMycjgwbFdsZ3JtTHE4Mi9meHBNZHRBMEQzemE4?=
 =?utf-8?B?WG8vNTBTelJlMUVrUWtNM3RkeUtaZmhMM1N2aGxkQUtaRlZQUFNVNE1QaWxN?=
 =?utf-8?B?MFE2M0g0ako2a1V0d2t1NFdma1kyM1ZFWnVOeFpoNUlpa2JhMkJydjV0eVNo?=
 =?utf-8?B?MnIxTjZER0N1UDVyZjBZdHM0QnBqUmZJRW51K0x1M0ZPazc4Q0l4Sm9BcWN6?=
 =?utf-8?B?VDJzSkY5OURudHN3Sml4TTlWVUxRUGlhYkhnR0lRVkR5TWRFeGFrakUycXla?=
 =?utf-8?B?V2NGM2NHR3p2bkNFd1QxWDVnWEJQQmdYTG9PZzJpa1Zlc25IUW9nRThZc3gz?=
 =?utf-8?B?OFVvZ01kcDlZMEJCSlA0VkRhcVoyWDBQaWtzck9YbHpwclBaZWZJUlVBc1ln?=
 =?utf-8?B?dFFhTHNOYm55RlNUc1lab1Y4VzZtd3F4cXd1WDg3bHR3TStXYU5GNnhseDhB?=
 =?utf-8?B?UnV5bXVUVC9Xc1pFeTkyV0RINnlOSmVYdjNWeWdKcnFXMFFUTEVCTDFSbnVw?=
 =?utf-8?B?cWpwVFBLeHpoL3NWVDFNR2dtNGlFVzQvdGZOREtEZnRwbktQMFpGMndDSklD?=
 =?utf-8?B?VS92NE45VEFqNk1aMlJvSDQyeXhva2xqeHZkMzJFdklnYlNhajFsa0JHNVRI?=
 =?utf-8?B?cnlXNFMyYVY5MVkybXZPakdrVHliZGYzbVNiU09rVG4zWko0bnVWcWQvYjRF?=
 =?utf-8?B?dUx6UzJmYyszYThTclBSb1IvcHAyTXQvSjBtZGVlTFlma29qcGRJWmlNcjBq?=
 =?utf-8?B?T0V1MkUzTTlDVzVwR0ZVSjh6SDF0QThpZW10aUJmaXhIcGNDMFVSSTc3NXpK?=
 =?utf-8?B?SllrZ091L0c1N1B0M0ViMG5nbmp3N3BuWWdub0RNV3hjT1FxY3hpZ2dRT1Vp?=
 =?utf-8?B?aTBrZXpSekpqTmtxbDIvWEhWT1BwM2RCREJlRTROajlsZTNuWFZCZ0FNZmpo?=
 =?utf-8?B?TEp6cWh4aWo2NHJlRDk2VXNlMGgrZU5GaHhacDMvNTlhcm1sUklOaXNFajI1?=
 =?utf-8?B?NkRHWmRxNFpmUjA2Q3hhL2JtVGhQOU5WQnYvaktBaW5aNXVwbVA2T1pCbE5i?=
 =?utf-8?B?eUo0b1lZc1hERDFHbDVZQXVyNFFhbTIyckxRcUU3OW5xSVhUUXRBTE04QjlQ?=
 =?utf-8?Q?NalGQL6L4n7MLLf7fA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnkwQTJGUitFNy9NMTByVno2a28vYkRmU0o4bWZFRGtRRlFGRUFTTC9yaEtj?=
 =?utf-8?B?VEc4UzJBYlVjQXZQNlpiL1NUa0F6YjhIUUhaQVk2ck1RaGZvV1owSkJuSHY0?=
 =?utf-8?B?ZVpMSWdOK01NWWpzMlFvUHYxRUQvS0xSQzFURVNuNitLbDZEVHdkK1lhdk5I?=
 =?utf-8?B?KzBLK2YrYThZbEdINWp0bGFGYTFpVHN3NWpnVXVpZEpGemdVRW1Xc2VjWjBk?=
 =?utf-8?B?R0lPT2VjM211SkJGTjZHTVI3TkdlOWhWdDJvTXZhVmZydGZ6dzhxYmlrQmRN?=
 =?utf-8?B?RG5CRFQxSThxYlptdGRMWVRwbTg1NHVobXc4UTl1Tk9ETm40OFRTaGJvMHNh?=
 =?utf-8?B?ZE5QcVF2RHB1VU1JVjdBeGVnVHYwOGlnc09SOVNaa0ZraWEySXVYa1haekQw?=
 =?utf-8?B?bzZ0NHRkcXI0TTUzZmxiMlU1bWVvNGNGRzNoTU1iWFJ0ajdxUWNEUm0wMjZu?=
 =?utf-8?B?V0RjdndIT3BFNnRheExOU21DZmRTTEhTTmd0Z1YwWWFhSjhEL0JJK01tWE4v?=
 =?utf-8?B?amxQSmJ5L0oyUmtxQzZEcG9MT3JRQzQ3b3RnR21XcCthZ1MvTElHOUE1cVZi?=
 =?utf-8?B?ZFFGOG9SaE50VHZOL0JOVS9hS01aRTVUMXJxbWhHeDdsNGN5MVZWWjQ1alVt?=
 =?utf-8?B?cCtJdTRLSXhGY3RBMUw1WEtscVo4cG9LSHR3bkJ3NmM2TFZnN0JEblowaTJT?=
 =?utf-8?B?ajdZWnZIMTZFTHdnay9zNWwyT2FvQThFUUltSVNrTVlOYkhSOHU2V3ZJNmpT?=
 =?utf-8?B?TEFPeXJzd1crNjdUeGttMkhvcFAzRTVTVXh6ZUt3UGRadVNqaE9vOWJ4eitF?=
 =?utf-8?B?cDk5Z1BhMjNnanc5WTFQc2pmNXJ1bnB1ZUJERUNURnhEQTJoSEo2eER1TFRr?=
 =?utf-8?B?ZEZOSWtmd3FMdkU1Uzc2SFF4Um5lRXJBOCtmV0IwUFc3d0NTdmdSUkpKa3VK?=
 =?utf-8?B?OHM5V0ZDdTlNbTViQTZjNlpjanJjbVVyN2J4czBBVkVGSXFwdS81V3BIdzMv?=
 =?utf-8?B?R0xwaWMza3VtamtlcGRFUzQwcUpVLzZESU5YRERodEswY3FROHllSGRDNjNo?=
 =?utf-8?B?KzZYUGx5Z2Ric0R4b05aV3ozSlNXS0l3VlV4YVZCUHBnU0hubG9oR2FSVlh0?=
 =?utf-8?B?dENIMTBhMlhSdndFVHFXVk16d3VaazZCRis1dEVJalVMcXlFYmNwczE0Qnc3?=
 =?utf-8?B?enJ0RkFNVlp3bjFjQm1WZXdMd2FHTVdzQWpxODFnNmNNcmtYSXkxUFRDSlhD?=
 =?utf-8?B?OUJpR2lrdWFRSGlPTmN3WG15eHZBTk1KQXZZQzlKa3ZpTncxYWFXLzNrTHJQ?=
 =?utf-8?B?OXJGd09NZ2w1SUNPT0dEcTlRa2NZRHFmZlNDdjgrOElEZmF5d0VBb1YxdFRj?=
 =?utf-8?B?Q0F6elFpM0hxN2tzaE02MnVncGtOemdVRFZCWnZJbGZlQ3RRL3BJMVdjWGh4?=
 =?utf-8?B?eFN0S0s0bDhuMkJuY0N2Z0Q0STkzejc0UHdtSHQ1aG9TaUFTRHVMMHNOSlRS?=
 =?utf-8?B?M0N4em5EaXVpOXlMbDVUV1N2N2pWSm82aDIzT3JlT2ZUZE03SGN6ZEY0c3Vh?=
 =?utf-8?B?eGVuU3Z1NW5mOHFDb09Ha095TGZpMWVFN2R0VmMrNndwRmxMUk8wNGtpOEJB?=
 =?utf-8?B?dEVzSkE2Y3dFREQyR1BkU3NOWkk0elR1YXNVYjU4QVpEY29sWDBxaEVoL1Bp?=
 =?utf-8?B?VXZJclhPcGtMV2ErVjlwZmgzSEhzamQ2ZDNrSkwwOW5rK0lseS84d0dLRHd6?=
 =?utf-8?B?UFROaWpERXArNlRPTnFBcVBob1djWDhMZk53QmNhZGJkZ1BXWWxrVnMvZUs2?=
 =?utf-8?B?cWw1UWp3YTltRklPWXdYNTlUaWdBTmt5NHJIRGl6TmVGWGVWM2o2Uzl2bjFu?=
 =?utf-8?B?V3NSc29vQ0NscGN5T0NRSTJLMHpxWWFid1Zlc3NhOFhXNmV0NHFIK2kwWWd0?=
 =?utf-8?B?Y3FEUEhnVDJpdEFPc3JMblU4c2R2T1lPbXFmZ0N6djJocDR6ZUVKSHUyRlpi?=
 =?utf-8?B?SU9tTkR4eEVkcGVmcXlPYnBaakNkZ3d1aDFHYUgyc2ZxSHk3d1hZQ3d4VWpD?=
 =?utf-8?B?SFhsY3dHOTB3RkJ2YW5IV2RkdFBnRTFkdzFBWG02Vi9sckZ3MWVLWHNJWTBS?=
 =?utf-8?B?Nm8xL1I1VXdTcFhWTE5iTjZFb1kwTlNGN2pDdDVHdzczUGwrTWxMSWkwazBm?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d999a8c0-64ba-45c7-e46e-08dcc157db65
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 20:37:06.8395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTZv+8iLNtU02YFk7Kw93kJMkRcuwlhzeHEXqs3dLMhGxMFe9O/LfX16Mog3wX99Yd6Y5L5tGuKpauK0MFS31beWtDiNRCUdkdW7OZtr0zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7027
X-OriginatorOrg: intel.com

Hi Babu,

On 8/20/24 1:18 PM, Moger, Babu wrote:
> On 8/20/24 15:04, Moger, Babu wrote:
>> On 8/20/24 13:12, Reinette Chatre wrote:
>>> On 8/19/24 11:18 AM, Moger, Babu wrote:
>>>> On 8/16/24 17:33, Reinette Chatre wrote:
>>>>> On 8/6/24 3:00 PM, Babu Moger wrote:
>>>
>>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> index 66febff2a3d3..d15fd1bde5f4 100644
>>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> @@ -2756,6 +2756,23 @@ void resctrl_arch_mbm_cntr_assign_disable(void)
>>>>>>         }
>>>>>>     }
>>>>>>     +void resctrl_arch_mbm_cntr_assign_configure(void)
>>>>>> +{
>>>>>> +    struct rdt_resource *r =
>>>>>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>>>>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>>>>> +    bool enable = true;
>>>>>> +
>>>>>> +    mutex_lock(&rdtgroup_mutex);
>>>>>> +
>>>>>> +    if (r->mon.mbm_cntr_assignable) {
>>>>>> +        if (!hw_res->mbm_cntr_assign_enabled)
>>>>>> +            hw_res->mbm_cntr_assign_enabled = true;
>>>>>> +        resctrl_abmc_set_one_amd(&enable);
>>>>>
>>>>> Earlier changelogs mentioned that counters are reset when ABMC is enabled.
>>>>> How does that behave here when one CPU comes online? Consider the scenario
>>>>> where
>>>>> a system is booted without all CPUs online. ABMC is initially enabled on
>>>>> all online
>>>>> CPUs with this flow ... user space could start using resctrl fs and create
>>>>> monitor groups that start accumulating architectural state. If the
>>>>> remaining
>>>>> CPUs come online at this point and this snippet enables ABMC, would it
>>>>> reset
>>>>> all counters? Should the architectural state be cleared?
>>>>
>>>> When new cpu comes online, it should inherit the abmc state which is set
>>>> already. it should not force it either way. In that case, it is not
>>>> required to reset the architectural state.
>>>>
>>>> Responded to your earlier comment.
>>>> https://lore.kernel.org/lkml/0256b457-175d-4923-aa49-00e8e52b865b@amd.com/
>>>>
>>>>
>>>>>
>>>>> Also, it still does not look right that the architecture decides the
>>>>> policy.
>>>>> Could this enabling be moved to resctrl_online_cpu() for resctrl fs to
>>>>> request architecture to enable assignable counters if it is supported?
>>>>
>>>> Sure. Will move the resctrl_arch_mbm_cntr_assign_configure() here with
>>>> changes just to update the abmc state which is set during the init.
>>>>
>>>
>>> I do not think we are seeing it the same way. In your earlier comment you
>>> mention:
>>>
>>>> We need to set abmc state to "enabled" during the init when abmc is
>>>> detected.  resctrl_late_init -> .. -> rdt_get_mon_l3_config
>>>>
>>>> This only happens once during the init.
>>>
>>>
>>> I do not think that the ABMC state can be set during init since that runs
>>> before the fs code and thus the arch code cannot be aware of the fs policy
>>> that "mbm_assign_mode" is the default. This may become clear when you move
>>> resctrl_arch_mbm_cntr_assign_configure() to resctrl_online_cpu() though
>>> since I expect that the r->mon.mbm_cntr_assignable check will move
>>> into the fs resctrl_online_cpu() that will call the arch helper to
>>> set the state to enabled.
>>
>> There are couple of problems here.
>>
>> 1. Hotplug with ABMC enabled.
>>
>>    System is running with ABMC enabled. Now, new cpu cames online.
>>    The function resctrl_arch_mbm_cntr_assign_configure() will set the MSR
>> MSR_IA32_L3_QOS_EXT_CFG to enable ABMC on the new CPU. This scenario works
>> fine.
>>
>>
>> 2. Hotplug with ABMC disabled.
>>    Current code will force the system to enable ABMC on the new CPU.
>>    That is not correct.
>>
>>
>> We need to address both these cases.
>>
>>
>> I was thinking of separating the functionality in
>> resctrl_arch_mbm_cntr_assign_configure() into two.
>>
>> a. Just set the mbm_cntr_assign_enabled to true during the init.
>>     if (r->mon.mbm_cntr_assignable)
>>         hw_res->mbm_cntr_assign_enabled = true;
>>
>>     This is similar to rdtgroup_setup_default().  Isn't it?

Right. I (mis)understood from your earlier comment that this was planned to
be done from "resctrl_late_init -> .. -> rdt_get_mon_l3_config", but
handling that within rdtgroup_init() (after MPAM it will be resctrl_init())
seem appropriate to me since it is where the fs code can set its policy.

> 
> I just noticed that I cannot access rdt_hw_resource here. I may have to
> write another function resctrl_arch_mbm_cntr_assign_set_default() to do
> this. What do you think?

Sounds good.

> 
> 
>>
>>
>> b. Change the functionality in resctrl_arch_mbm_cntr_assign_configure()
>>     to update the MSR MSR_IA32_L3_QOS_EXT_CFG based on
>> hw_res->mbm_cntr_assign_enabled.  Something like this.
>>
>>
>>     void resctrl_arch_mbm_cntr_assign_configure(void)
>> {
>>      ---
>>      if (r->mon.mbm_cntr_assignable &&  hw_res->mbm_cntr_assign_enabled)
>>              abmc_set_one_amd(&enable);
>>     ---
>> }
>>
>>
>> Yes.  The function resctrl_arch_mbm_cntr_assign_configure() will be called
>> from resctrl_online_cpu().

Checking r->mon.mbm_cntr_assignable may be redundant since I expect that
resctrl_online_cpu() will also do the check. Would do no harm though.

>>
>> Does it make sense?  Any other idea?
> 

Yes, this makes sense to me. Thank you.

Reinette


