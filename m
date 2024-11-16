Return-Path: <linux-kernel+bounces-411542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7AD9CFBBF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C30B22B4E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFE4522F;
	Sat, 16 Nov 2024 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZiBYxa66"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69C567D;
	Sat, 16 Nov 2024 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731717335; cv=fail; b=AeltQ2mHrFgWVec74KpFH24PM1az244OQ11jOWPMYIPgwGvlR8Ve8vAXuOzbb2KgjMkwEdiTRuIvy3zW6juU9nPADU4OcrxOGAG6e9FcY2sXfSi9qSL04PYhUWBemTOAeV0yV/LvdpZkAYPsU1jNnE8DntCVkb7yalJQQDiQkeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731717335; c=relaxed/simple;
	bh=93xfDDi1EtP6O+0J9RyIbyntBNnqiP8pMGxav0vuFCI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YpjRbOFUVr507PuxdTHbD5ahMn5m1nkHRZ2W6CBCcTl2s4rj4fX+pqr6OfGD97znYuuLqvwWcVRghLzYSPP1Xfys+gntBNBLHLpMkBAfrlz0F8e9dNcQFnJ17Bsc3abLgQZeQc2DMgtwnSEPtEDidCTysTluwqdh0gCJZ/qPPto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZiBYxa66; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731717333; x=1763253333;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=93xfDDi1EtP6O+0J9RyIbyntBNnqiP8pMGxav0vuFCI=;
  b=ZiBYxa66bKyShOFmkrtkTh9prKU32Ovy+pIH/xc6huKcDqtECbOOCjxI
   NOw7pRUzwwLmb0iLuye0oHbkRBHrq7LtRx2rnjcKRRv1s48fKDgt7LTq5
   0ulBwPCgmci7ks7jkxlfTJkYmdZFtniWQBzjAPQ7vjT30MxLelKOjoFMY
   w4P75dZ1LXt7brSiZ/XLpZdo01BvAoSj0FI6PDhPdovKUlNzNNwF8jGWW
   EidB3bCv7UG4562H59bql0PYB0XYePeMqAxteYGT+ZJlzmKobAMfOwjKY
   4iACh2fikcMTPYAK3Plcb2C71kUCRHo6P5jMgTFGXx/0rhpwuzlXl+ljB
   A==;
X-CSE-ConnectionGUID: ulqBZvGdSsKeUaoneYQokA==
X-CSE-MsgGUID: zzNG9BP5RWG/VilxU3Zx5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="19351916"
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="19351916"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 16:35:32 -0800
X-CSE-ConnectionGUID: Cwke6tw6QVqYU5RZmoghkQ==
X-CSE-MsgGUID: RLDG85cYTEWuUDKAhI8hRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="88598445"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 16:35:32 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 16:35:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 16:35:31 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 16:35:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aa1LhNTGo6Q41UXZdfszbWwYJ8dYPafj84HLIcThJJwPDpuH2I0iKuGP9hMF3VGKG/SuNOPLoCTrzlUixjJNornMPTIvBUa34ai8MZ7GtbDNgoRbDvSCaF3Vt2QS32bYK34nZ5xFOA8cUvpp4Yzmxg32KIDYKL+khJT8Fj36hlNDl6FPVGRpr/pec/kQ9RrRSXtHkOmQtpQmHb+ahicCV2qTI8BErANW3s/v9Ouk74Z133S5awVZScFG66+e5KoINvbKwvbXMeGwjd9AQ8I8ChFnA8DYXFvHHdzLpLaSS3uMxXrpatrqQw/Rb/wUr/syFc8nxLL//dcl050t9KHaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sC3iR4AGFDGDBrVRYOG01PSHVbRnkiR72S5zVaZ3yE=;
 b=D3fm7c0ke+p6VFOS1fzS5e0yWQ20rZCKiGyyFeweNE/ZcH/59Tw8NflDOwSmS9kwG0zro3XWB4/L1wA9a2gZmLpKrmSbXSxr7gkuj1dEIUr5OQWy1vhGKBYP+WNlMPFsQsLFZWEzqndp7OfJ5J3myPC7AnYgjUEn3ziE4m1ARrpL8matvSTaLnYKlQ2MnEWPXlk5Eo9ABc7O3jKU9NVCyqWPBnK3l6aiQSnGlMxQ6qk2dpeKZi7UjNTCvTqWvpQ5PGeT2hYizivc6Y0ZkviwrdB2rvmyIDl1ZT3ZsGGyRe1ONDOfFztyTOjHJOigzciCXCb9Kc7SugkYYOuyQgmfJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6955.namprd11.prod.outlook.com (2603:10b6:510:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Sat, 16 Nov
 2024 00:35:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Sat, 16 Nov 2024
 00:35:22 +0000
Message-ID: <eb50c0e9-a35e-43d0-80fb-678e47d777ad@intel.com>
Date: Fri, 15 Nov 2024 16:35:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/26] x86/resctrl: Add data structures and definitions
 for ABMC assignment
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
 <219cac124638f576cc7a9c5a14207f8c018e31f1.1730244116.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <219cac124638f576cc7a9c5a14207f8c018e31f1.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0302.namprd04.prod.outlook.com
 (2603:10b6:303:82::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 9198288e-32a8-41ec-9ead-08dd05d68e1b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDlhRVB6VDdzaXYvVmU4TTFvQno5OU1TU2tLZE5zZzV1bS9NdVU2Smp1aERI?=
 =?utf-8?B?bis0OXFld0dLVGF1dkE0bmlNZTAyeUFKQ3Z6aVJWUTE5bTVWejFDSnNDZnE1?=
 =?utf-8?B?K0J1bjUxMEJac0kwSUhXZVp1WUpRa0o5M3ZLcjlOVW9nUitMRXZXQTJpZjZu?=
 =?utf-8?B?WmdNaS9Zd0tzNC9US1ZQV2cvbU1JOGladlJzQXJVL3BLMk5zQytmN0NMdHBX?=
 =?utf-8?B?a1VZWCt1ZWhubGYvdXpBN1RIYzZQb3hlaWJyMkh3cFZsRGNhVmhpUU5Rei9l?=
 =?utf-8?B?NktXbmF2cGtqek1ETmVNa2ErdTFjYXNkY1pEWG5rakUxWnJOYWwvbzFBQ3J6?=
 =?utf-8?B?akdqcG1TbEJ2c2djWGZIUEpCY1hZNVZHYUt5ZDUyVXBMN2VkNXdDTUk4MUU3?=
 =?utf-8?B?dlcwcE5xQ084UGExNGswWTl3U1NPcHRnL0pzWDJFZTBJeHdXcFdXeVlSSFQy?=
 =?utf-8?B?VTRqcHoxUGZ0bmJVRitxajY5Y0ZKaW9nQXpkLzZrcmttY2tTWDZsblgxcnBL?=
 =?utf-8?B?ckVtdXJLQWE3NWpWazhTOC9taEtRQjlBaHFPN1VhcFNOSW9xbTFLM3hMTXlh?=
 =?utf-8?B?LzhIM2dROFFoeDZrbW5ZaGRYSGJPZWVYRjBCZDFub3BpVTduS1RlOGF0Nkdj?=
 =?utf-8?B?d0RkVVp3WDFac0FaTXR0Y09QVGtsdEZzU2s5NXgzNXRkR3BCcEtjTG03Umhr?=
 =?utf-8?B?RVZUbnU1RWN3SEMveVBlZlJEWlEwczNPcE9XVEkzMzJxR21WV2lqMXBkR2h4?=
 =?utf-8?B?SFBKVUd5ZEh1WnRDT3hib2FHTlFpb2Q2d2NaQytnbDZUYnd5WkZnaWlFUE5p?=
 =?utf-8?B?NWE1ZXU3bi9tL2ZDVmFLcHhSYmZWYU44RkRmTjd1OThuRU1OQmtQZ0lrUzli?=
 =?utf-8?B?VkltelRlUkFVbkFrR3RkR1JsZ2V4THFwUXVNOW5ZQThzVG5OelNScDJGcFh1?=
 =?utf-8?B?Mm5OdnVzTmZvM0Z5M3hCSjY2SEtKRVlISzljR1M4cjhZOWpEUXFhVmNGR2lj?=
 =?utf-8?B?Q0JFM0RVUlg0VDFMRW9Kam1qTE9mUjhvWC9Ha0lUYUljbExiZ1k0dXpaMTlB?=
 =?utf-8?B?dXpDVUdPRWVNSHBUaWpJQVZnaFFFYkl0eFM4RmtGQzVteUExZitXS0VZUHdi?=
 =?utf-8?B?d3h0TjMxWGk4bDhwejdGelJyekJJMWhUUEt2WW51UHIwZFFNa0RCWGViMWx2?=
 =?utf-8?B?QktJZzZmQk55OFRuQlpHbEdHS1B2MXQ1RnVoU0cxbXlTcHdmeUJORWw1aE45?=
 =?utf-8?B?TTF2NDdCYXJCZmlwaHdNYW1KclpjamUyYXpQNUFuL3BYVW4vaktuNXdjSXpW?=
 =?utf-8?B?eG8xdW9ucDZjcHJpdUd1ZWxWNHJ6RUQ4dHQ4d1pQZlJHb21KUEFuQ2FOWndp?=
 =?utf-8?B?WWdCNEhnaEJYdDBNMUVHRGhMeHZMTkpnT0JmN2xVamNBRFhVRi8rZ1pma3RO?=
 =?utf-8?B?OU44bVN4RVpZN3kwSUpneVk4ajJ6MDV4SHhFSE9zV3JmeElDdkNXMEVObllo?=
 =?utf-8?B?UDhpbWdQTm9UMGs1Zy9DQzFFcDhKVzlxOWpiWmFYUWg2TElxLzZBOWdXbmZW?=
 =?utf-8?B?U01YOVNweHlOL2ZBRDVLZmp2SHd6cFRHNHRuRWk2aFVSQmQwN09NSFlkOXE0?=
 =?utf-8?B?NlcwUVBDK3hkeUNyQWt2eVMrcWEreVhRSWNkWHZieDEveGhaYzBueVhLbk1p?=
 =?utf-8?B?TWtxK2J1QXg5emZxSE85YjIyNHhkTFI2VFZlNnRkb1oremZyK2ViWDRnQWVk?=
 =?utf-8?Q?xkY6C84XM0Iy748zDBhcojiISZU5G/vhpkZqiu1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE9lbStHb3hHL2dzZmdxVkJJOXVGdFlNUTU4SEtObmxKVnJXZk40a1FWbFhX?=
 =?utf-8?B?M2FiK0ltbGlxQjRmRU1UYVBBcHJISjVWZG9rTUdJSGZLSk81SFdHWHllQmQ0?=
 =?utf-8?B?V0d3RU9NTzc0TEtoSGk5OUhYSWlLSXMzNzY2UHd1bkppc21HUjRSbFdlY1hU?=
 =?utf-8?B?SW1CT3pPelRmZ0tkNUVJZHRteXVWVFB2SFpjVmFRL21TYWtiWHJKTmYrN2pR?=
 =?utf-8?B?bkhPYnZMQmtOdnlqeEhsTS8rd0QvcEViQ1E1cERibHc4WWsyMWdvbDdyb2ph?=
 =?utf-8?B?UWt0MGFBTDBoREFhNzloMVZWSTd1bUtNYWxDdFVLN1dFemgyZjFjVGhCS2RG?=
 =?utf-8?B?RXBoeHJiTlFBaHBuVzhPMTdLWGk1UmJCamk2SitIcjl5eUkxWlZvMVVZSHF5?=
 =?utf-8?B?UlpiNzV5ekpOTy8vbWpKZlJYWkU2dVo2Qi81OWU2L3BEbWR4aFZGeDhKSEZN?=
 =?utf-8?B?YmZGVnFzWUxmeVhBMDlIRTQwT1prSFRsV0FVcGlONmNhQ3NRL3hRZ0EzR1pY?=
 =?utf-8?B?VlVPSGNodFgvYkQyejJMbU5kZXRQbHJ5M2kvR01rNmhRdGVCV3JHUG0yZTA3?=
 =?utf-8?B?eUhYTER1NVkvSnpSZThXejdISkl3WStjSW15TnlBbnA2SEdKWkc0WmVEeTNI?=
 =?utf-8?B?VFZPRFpHTTF3N3JldS9wek5UNkd6eHQwNnM4YzdDajZSeUZoOVdpTi9NTFBy?=
 =?utf-8?B?STZ1NXlLUGp5OUx1UkVpdDhtNDMrdzFKRldBQ25nUk1oVnNIYTlDTVdHd002?=
 =?utf-8?B?Zml4T3YxVzJLOXlIdkFOM3dUcUVpZDZ1cGFnbDN4a0hZRXQ3QjV1eGVZRkNZ?=
 =?utf-8?B?UG0wM0ZuZllQQldjY05qbFBGOGdYRStiMitwSWlQc2p6TXk0di9Qc1U2b0w5?=
 =?utf-8?B?ZTFqUFdqd081ditUYm14QThsby9IQmE3dDRKTnZWR3g1OUZ3MDlIK21vYkE1?=
 =?utf-8?B?bUx4Zk1sMDlLNm1GNGExREQ1MEZZVUpNVldSTHRBL1ZQb2o5SzBIamhlcVR1?=
 =?utf-8?B?RzY4dFZwMmMvMGpBOERUeVg5RXVOMmZLMi9pUTBORWpBQUQyaWYrdGg0NjBs?=
 =?utf-8?B?VmwvWERkcW96MzZJL0JGeXlHOVJxNlFrekI4Y0EwT1JOU3BoMnExdndETXdh?=
 =?utf-8?B?ZnE5NlFCNHgxYmNtTzArNFVHdUZzRXVVUGphZ3YrQ2ZVNFlDL0EvendMQnAx?=
 =?utf-8?B?UGkvTFdFRmMvcW1DQ3pKSGhhTDc0YkhDanEwdXJrakVtZ3VBY0tnNmh2dlht?=
 =?utf-8?B?UXBZdHNRUk9TeUhOYTE4QlByZXpyVVJwZVd6UFA4V3JKdHNrSkYrdDI5U1lC?=
 =?utf-8?B?RGFRbXZjM0NQbFBkaFVScWhVSklTOHJsOGdTcTREcnQ4clhnQngyNm8yUnFm?=
 =?utf-8?B?d1JSOEZHNkphK29VbmhRMVdRS1k2aWV4TFk4K1BOUW9QK1ZkS3hXNW1LVW0y?=
 =?utf-8?B?Y0hCRjNjbGdOMjNLTUFkbnJFd3MzZkFLcFdnVVJVME1VOVhvY1IyYnVOUHFk?=
 =?utf-8?B?NFZ1ajNiRUFyMnV3MXhzeVNmQXlJNDJIUVIrTVZ2c3BmZUdtREpHUnVvTW1O?=
 =?utf-8?B?eDZFdnJDMGZLTElXSFVTZ3dDaXEyOUdLODliM2Z3NlB3SmRXMmF1MlBrRmNR?=
 =?utf-8?B?WjV6TFJydHdieVp3QTl0S2lpZU1NV2ZSb2xabW95azNHQXArd2FJbkpvd0RV?=
 =?utf-8?B?ZnNBMWhETC9KMVE0dStHdy9iSk51T2Y1NGszbFB2UzlGSHYxRG5mSlNyS01Z?=
 =?utf-8?B?V1VBenVaSWNMSzlsNFB5ZGZ6L3NSb2lpeUt1b2trTzMwOGdSOCsyMTdvNHBr?=
 =?utf-8?B?ck5DU0V4cHFrVmd0ellqeVA1WnB5aFl1N0hnOTZGSmdGOFNNaElRZTNZYlVY?=
 =?utf-8?B?U2V0eGtjSTBLQ21TWi9JTUh3L1pOU3kwSzZOWUtxMHVGREgxajJtTGl1eXV3?=
 =?utf-8?B?OTUwR04rNnI2OFgzWlliU0ZGdnprTlRkRTNjOXNkSDV6MVUybmViTUovRzFZ?=
 =?utf-8?B?Z29zTkVPYzZ4M0JHalZnTDBvckRsMmlBR1NyVXF0dEN4OGM5ZWxvMzlwRk4y?=
 =?utf-8?B?Rnl3VG1WbVN0ZEJaaFR5U0pseTJ5dE80Q0ZDVDdHeFFzSWxLZFRURENIcVpm?=
 =?utf-8?B?Yi8vT0VrYndOS255TkI2MlRiQzZmdFZVM0dxZDB5N2puUmNCOFhkeWdpc01u?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9198288e-32a8-41ec-9ead-08dd05d68e1b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 00:35:22.3453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVobaHA3xQQICvEsRZUEUhfsUONmxTtpElPTLo5kWluwStuDJL1ZtkmA3FqA4HbGVEzttyx7qXioPeOCfcG2L+C9qUgzMVIaHyLK+Z8w/ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6955
X-OriginatorOrg: intel.com

Hi Babu,

On 10/29/24 4:21 PM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID, event pair and monitor the bandwidth as long as the
> counter is assigned. The bandwidth events will be tracked by the hardware
> until the user changes the configuration. Each resctrl group can configure
> maximum two counters, one for total event and one for local event.
> 
> The ABMC feature implements an MSR L3_QOS_ABMC_CFG (C000_03FDh).
> Configuration is done by setting the counter id, bandwidth source (RMID)
> and bandwidth configuration supported by BMEC (Bandwidth Monitoring Event
> Configuration).
> 
> Attempts to read or write the MSR when ABMC is not enabled will result
> in a #GP(0) exception.
> 
> Introduce the data structures and definitions for MSR L3_QOS_ABMC_CFG
> (0xC000_03FDh):
> =========================================================================
> Bits 	Mnemonic	Description			Access Reset
> 							Type   Value
> =========================================================================
> 63 	CfgEn 		Configuration Enable 		R/W 	0
> 
> 62 	CtrEn 		Enable/disable counting		R/W 	0
> 
> 61:53 	– 		Reserved 			MBZ 	0
> 
> 52:48 	CtrID 		Counter Identifier		R/W	0
> 
> 47 	IsCOS		BwSrc field is a CLOSID		R/W	0
> 			(not an RMID)
> 
> 46:44 	–		Reserved			MBZ	0
> 
> 43:32	BwSrc		Bandwidth Source		R/W	0
> 			(RMID or CLOSID)
> 
> 31:0	BwType		Bandwidth configuration		R/W	0
> 			to track for this counter
> ==========================================================================
> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


