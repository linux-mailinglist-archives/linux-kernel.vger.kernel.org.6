Return-Path: <linux-kernel+bounces-418765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED1B9D656B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C9D283130
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4567B18991A;
	Fri, 22 Nov 2024 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9Gb3q0Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E26249E5;
	Fri, 22 Nov 2024 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732311493; cv=fail; b=lteKdFLioG+/meD+FWZkB9Cb7EBJULQPh2SS5coNmDAhDtZQx5+e4wv99fmUtXqMC+uvJJnm9M7vbSCLk1X5uw5rRPdL1GELWBMcrQTtIy0L0t5yhePSMjnp7EdNT0O+B8GfJkmyQ132MrUlmC4hbOtv9X6qLWO02BD6abI2zMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732311493; c=relaxed/simple;
	bh=OcuUTfnCXv8nTAf2hGbGMxqU84dJOgzAjkrVckIILXY=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=meJjYe/qv00lh8mFEWW2uZU0/CQBYTwTI3rDzaN3XHgMEM4z4Lx4HdMQbmSFstrBoNRe2jKVpq5JFzmuaePk9srha/UeThcQ0ePikkb/pjZq5RR9oDAyN17GoLjK/843tkYNkyNHAKKiwo9tsy3OAHZb2RZgSY7THeIOR4gJgF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9Gb3q0Q; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732311491; x=1763847491;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OcuUTfnCXv8nTAf2hGbGMxqU84dJOgzAjkrVckIILXY=;
  b=F9Gb3q0QY4DksVBeWgXIPpffUfKjiPsrq5AZaoVJssg18UX4voVq5JQd
   I832OcvKeJMFrDrNMnsRGHOe1KTYnj3yGubYUeTEM8KVh0zxjvVyYzyKs
   jEU70pGt2H6TK80Q9VyOTomcl4jrvm0peaZU4CV70JyKzOoQesotYewh6
   S6LxKyk10HnphSioz0GWKBJzxybmGqxOF2gc23aY46LGXha6euHWOvBfv
   vwATlJXE3tVTxmLi5sVkDUiNWS9HgzMZIQ54lYcdcHpf9PBC37JcrVgpH
   YK/yHHDeYVRH4M5Ipqmm9rZFo6+Erv/7NcfmynqhSyhzjJditdRfFAmo1
   A==;
X-CSE-ConnectionGUID: I01AGXXYRzuyMD5BQdQRSA==
X-CSE-MsgGUID: gN/CmeBkQpeJbwyaB/dGyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="35337808"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="35337808"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:38:10 -0800
X-CSE-ConnectionGUID: Qlm3kMhbTwqykN4RaCqmfg==
X-CSE-MsgGUID: nnodSOQ9QRGcbimJv3a1VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95110023"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 13:38:09 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 13:38:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 13:38:09 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 13:38:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCDF8dsAE7WvlhiZ5QrqYBApW+5rDFU9akzMfIjsLKYLh8GBBuLqkHGiSWA/01lvh2VU0eiISl0tYkSNv1Vs43RZcXGyBo/LCR0JghMDTfJ+XLsgzmcUyp6Xn9etW8k3BTzwHw9KbLQHC0mp7g9fjA9HqA4E7y1gDVzFmU/N2pmeN/7J4TNs4OQRDLV443iZMagvHKmO9Laf62T4KY8gyzr+/btuD2xN+6UKTKzVPGPtzeWZVO/n9swntjVNu1fVYl+DF1E1ZaywPQYhe+jOKMcsMTv8BZI5EibIh8+2e8+imtzyek6bLd2JqH28gYGtbCWl8RVx+h6Q3D6Sihn7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4PDAAHj5p9Uj+fSBLPWDxZe445vOIruPnKDSx5gb7o=;
 b=qYjxUv5elCOz7QyortfNeDJKu7PSQCd7rbxYcCdLWD8NQatUJKM+G8Pd+tvmhUDAvXgrW4v3/3+ORxjG6Um5kdB5k5LZ5EiNkBujdh+oHxw1REt8iFTCutthYhsqqc7ltyEC0pyW17UoXdy58kmKMPtB0ZcIn2iK9DLujtyF3MzSxk6gZ7EzAuYzJacn3tc9hSba4vW3ngYpOUnlbnLp99nYWw+FAr6OFkpXjAc1Q+nokT/ZGosu+BTJl0GcMoTBQku/LkZb3+hRWVI2DPCQg6HMA3VFxy/JVuOiI0Xe34XVKeWhjaWtRQi8ws4GyovBp1s/HYZyhpI6d3xN68InGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5319.namprd11.prod.outlook.com (2603:10b6:208:31b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 21:37:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 21:37:56 +0000
Message-ID: <6c5f8c64-43f6-4145-b0dc-429603f8ee24@intel.com>
Date: Fri, 22 Nov 2024 13:37:53 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 08/26] x86/resctrl: Introduce the interface to display
 monitor mode
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
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
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>, <jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <121c79ea1abe6f21f726d086eba9fa61d31da3f1.1730244116.git.babu.moger@amd.com>
 <fe518638-a82e-4136-ae77-fa6a7abb4b2e@intel.com>
 <33cd0cc0-4f81-4a2d-a327-0c976219996a@amd.com>
 <d5bead60-6a38-426e-afa6-e7980a268d6f@intel.com>
 <0eff9462-e7e2-49a9-9538-c8907024322f@amd.com>
Content-Language: en-US
In-Reply-To: <0eff9462-e7e2-49a9-9538-c8907024322f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:303:86::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ab2b24-45d0-4f1f-181f-08dd0b3ded72
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTFBS3VidDJ1Vk45UWMrS3luaGovcStZTmNBUy9lN29KMlhnTnhOaHQ0TkRX?=
 =?utf-8?B?QVFkV2tkTWZua2Fkd2ZBR20wMk5IQU82MWRZU1NhSUNqVCtrMXJRT1RsclR4?=
 =?utf-8?B?SlpMdTNNTDVUb0ZuV1h0bWVERk5aeW03cHRGZkVnNU9TTG5VQ1hJbDRBWDVT?=
 =?utf-8?B?Yjk1a2d4dklkRWhxZ2R1L1RFcHhoR2h2VHdUTGxYQzNWMGtIWUd1OGdUZmc0?=
 =?utf-8?B?YUZVYTdyQkhvTlZubWtVUnJxZk5WdDEyMm4ySzcyVEZiTEQzN0swV3Z3aS9J?=
 =?utf-8?B?RVpMcUFUU2YrMmJPR0xOL1RWNXU3WXhuVS85T1BVU2J0dUQzNTZ1amIrTktm?=
 =?utf-8?B?SDFYaEJIblhHUW8xRlZTQVFHYzF1MC9pTXIxUU5KdktqRjY4eXZZZzJURlZN?=
 =?utf-8?B?d1lxQitwQU9ndm4zR0dJTXQwYWwxSG1WUmsrV1VKODV0QzkweVFhQmY4VjEv?=
 =?utf-8?B?MWRHWDVRWDJUaUh6c2l6TzJhSnZlakxFTDYrMjljRTgvZzU2Zm5XdXFMSStH?=
 =?utf-8?B?L0NKR1dtbzlPOHZ4NklOU2pFR2pQckJtKzhvTzdDZVRnblNYTnlNUVh4VDhl?=
 =?utf-8?B?RDBQSU8wSUhmeUl4NmJuaUk4SVZ5SzZEeUhiekIxQm1DdENNQ1FzMVd4Z2Z2?=
 =?utf-8?B?NHRRZlRuZER3ZGNmUzYyTzJLYmUxTDZQdFJxdEpOMGE3N3hpcnB2VExDbFpB?=
 =?utf-8?B?UE93Y3RuM0lxUWFSbUhhdzRac2k5OXB6NFkvTm9tanF0bTAwTVMwVktkQTU3?=
 =?utf-8?B?Rzhla0twV05LcUJkSjB2RGFmdUdLSW5CSDk5TnNmVTBkRkhGTEd2blNaYk9t?=
 =?utf-8?B?eFcwL29mRGVveWtucmNDdVhaNmdwTWUrNEFVdXIyMURFWUFSTWJDSHFpYVdD?=
 =?utf-8?B?ZmgrR21zeXlzQkZFbzRqNXN1NUd5NUIvV1J0aW5MZkRFd283aVdocktjOStx?=
 =?utf-8?B?TVdxaEZOY0JkN0p4bm9FSVJId2JvUVRCbkxmaDZOVURVNkh5Q0M0dDdSVEpH?=
 =?utf-8?B?MVpTTVpBR3dIbUpUWVp0NTN2dDA1eEw2eUFpZFovSEU0cXN0NnJJMEVjd3ZP?=
 =?utf-8?B?TFFOODM5VWk4Z2lYYmdFRWVMclZJSXZ6aHo5OW5jcGlDR3o2Vnh5R0FnRjVM?=
 =?utf-8?B?alBMUkVGcUpCR2hpWGpiZ0d2M2dJVWhTYU1LazdpVlFRQlUrWTBtOE1EMUIv?=
 =?utf-8?B?U1hiU3p3ZGtSMnRxdU9xdzBMcHZ3N05qaVVjdFRraE5EZU5Ja1BqaXo5UENy?=
 =?utf-8?B?cFRCTThuQmFkYkhjVk9CSkhYQ3BnQlI4U0tKUm1CcjBESTNJSEh4S0hFWkJI?=
 =?utf-8?B?OXhtbEJvL1Z6OTZ2SEZPcmZhVWZPY2pxQXlIM3FwZGdDbWlnNTNBeHVVQ2dN?=
 =?utf-8?B?Ujc5YzBzSHlsSmQ5Ym1SWU1QT2taK244TmNyZ3FHdDUzZW5Mdkc5Nk1jUFZr?=
 =?utf-8?B?RnJyRno1emVmY3pGbkk0YXpka1ZRN3VTRVAybzArVVp1cnZtbmhOZ2JnSWhC?=
 =?utf-8?B?L21UeCtNMnRMN2hoRW5VMUM1SkUxOVV0Z0VMU0JBWXo5aXVtWmdGdzByZ2VX?=
 =?utf-8?B?eEY3RXFkY0Q1ZmxGV3lIN0pmcjVPQmIzK3lpTWpiZERYdHZIZExIMXlKSzVo?=
 =?utf-8?B?cWlxNm5WQ09WWHhVdmFacTBhTDJMcTRNSWNDdTBaNmhwUi9XUHdPTDZmUXNT?=
 =?utf-8?B?ckxUK0ZKaFJSYTFlMjNDTlZjeTE1OXVXdHUxZXFJRkN6NzlKdUVtTGp4anJV?=
 =?utf-8?B?Ym5GUFpITVdqSXZCZXpYZ0xnWFl4V2crcnFKQWpOeFl2UjFuUlBjL3AyOXdK?=
 =?utf-8?B?VUJjdmJlTzFrT25CM3UzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmJaSzB2WHRYWTBDYUpVN01LRzRhQU5nS01jZ2hBZWZxaVNFTDZIM21GUDZO?=
 =?utf-8?B?Z00zenBTdjZGR1RBRzB0YVNNenBYdjVDMnJWSXBGVTBmemdma0dIZi95UTFV?=
 =?utf-8?B?N3FGUHNqeDJIdnYvU2lIQU1CQ2xGN2p4azRtaVJuMTRkaURlRkVQM2I0eXZX?=
 =?utf-8?B?aHFMTUhFTU54eWc3QkcxL09CSXk5cEZST1hBUGpHRkJKVmVxdUdhWk9kSnZN?=
 =?utf-8?B?OHYwWHl0dG5NZHVhc0dGUzhjd1hLK3JhNFk3Qnh3RE04RHhxSzZNVzFGWG04?=
 =?utf-8?B?VkJlKy94ZWZabzdObTJFUi9mcVZsQlpnWDdaN1V2S0JKeXFkWG02eFRYdkdz?=
 =?utf-8?B?akFCcTZrV25iakhSaEtWbldRL09pVFQydnhoemplZUkyZk5EQUxqZlY5OXRY?=
 =?utf-8?B?dGlTRlI0NWZDb3lZKzJ5Tnc4VHNnb0c0amE5bVl1VkxDeks1bDdPUk5IVEhZ?=
 =?utf-8?B?bEUzTlRCTytEaG0yWm41Yk4vUHdmWmVlMmJQTEYvU3VRdmZ0RTBVbHAvWklh?=
 =?utf-8?B?WHVvNDRDMUlkbFIyZXBKeXdXSGU1RmF0M0t1RlpqbHpTVWRvb0lwT3E3QTk2?=
 =?utf-8?B?b1VSZy9ZSHk4SkpMZGxYVEVDbVVGOFR2bGlLQXUxQkdSeUV0SXEwUm9uMzly?=
 =?utf-8?B?TC9DT0hoOEpFNWZRVGdNZld2UmVpZmE3V3lyM2JBd2ttV1RXbnZqOWlQNHU0?=
 =?utf-8?B?enAwekRLTHVHejJCSndQSFV4UFQ3VmJCUG85ajdSZGd1MkdKTXpSeHpDa3FT?=
 =?utf-8?B?TTh1UUdBc3RCVzJ6bXJvNGpnUGlHZldkOUNMWE9jbHAxaXZkTDA4VURPd1Vi?=
 =?utf-8?B?eGhYVk5adHNCSTFKaG1LR3dkanVhdkI4UnNXNkdUVlUrbTYrd0Q4RGQyQkNs?=
 =?utf-8?B?ZFRzVGdHckJaS3Zkd2RtbnJHZ1dFQkFsNlZ1dmxwczN0MEMwbEpvQS9ZSC92?=
 =?utf-8?B?NTNSSm11bW5HL21Ncy9rZXpGVlpMYmxCUFJGNjgrRGhFNW52eFpYVzl6NzF0?=
 =?utf-8?B?MWpPYmFGWjhyMncxVk8xZWVvWmZUNkZ5VzFNMjhzaFJnSk1nWTNFNlF2RkNm?=
 =?utf-8?B?Y1VjdWZHazJCYzRHa2o1TEJ2NnZiTkpJSnJ2VW1wamFyY3JUQ1oyKzNvdnN6?=
 =?utf-8?B?WWJOMXUxQVdlTVc0S280bzBXTm9sYnBhTWxMYWN6b0VBdGNjV1JOMzByQWhx?=
 =?utf-8?B?cEhtM1poZDY2VmpnMTQ1QUR6WGVQOEdkRUhyQzJhVUVsWUswazhFYWxJNnB4?=
 =?utf-8?B?aXlJL0xMNFNITTJnSmtDSWMrbkMvZWlLU290NXpFR000M1I2aHdhRW5GaTVu?=
 =?utf-8?B?VzQwbERyU1BiNnJoTUFUdyt4MkdBSWEyOWVQQ2g1VkwwQ2ZaK29pZjlPemdR?=
 =?utf-8?B?MHRrRmVBdFFaeU9FaHZ1MzB3Yjdzd0lmRVZDZlQ3VnBmdFdLbDh1bTJMUElZ?=
 =?utf-8?B?MXJRSXhlSVg1azcvakttdHVpeFNIVWNZK3ZnTmFjMDdsMkMxVENoUDJNdmFw?=
 =?utf-8?B?Z1BJaG1vcENKdms1NUY3SlBrcUxJU0o4eFZDZjVIeEJaS3pKUXhwZ3NHNENV?=
 =?utf-8?B?bnkyTzN5T3RnWU9YQy9nWmFvRnRRRWdNNDFCSHQrREZqOHdZS2x0aFdlSmNP?=
 =?utf-8?B?ejlpL21FNnA4dDNRb3YvK3F1aFBWL2R3M1hwNjJNSDJGOCtpT0ZFM3R5dnNY?=
 =?utf-8?B?aWc1T1YvRXlnVDB3Qkx6eFp6UHBhMTlNUlFUOHFyRFMrdmRzdktoZUJBK2Yr?=
 =?utf-8?B?TCs3RXFqNFk4ZXhublhoZVlxbXh1MG5rYk4vY2R0dm5ZemgyenBjcWRqMG1B?=
 =?utf-8?B?SVJKb0krRVpmYnQzZFl2T201eDgvYjhKekxBTU9aeTFiWk1rc3lGbW94a0Zy?=
 =?utf-8?B?UVk0citFeldzNUQyR1E0UVY3cFVGK2RXdnlmdVNSUFdzeVR6SERSMEdIUU40?=
 =?utf-8?B?em9SZXNMeDhXdmptZWY2UUxIWjJLQjBVUjNyZFZqaUJsaGJqdC9uTlJvQ0NB?=
 =?utf-8?B?QWJSbVR5dmRXRlNSMm9NcU1USXovYkl2MExOM1Y1NVN3UnI3eWJOaldnbjdR?=
 =?utf-8?B?NnNEZklUVkNnUTFqWUhZUW1rZXRPMVVOa2hQR1R4S2hZNE9STm8xY2hFbTZ1?=
 =?utf-8?B?YWExR0JvRC9lMEVrSlowdXFYcTVISUZ1Y1FYRk00Zkk2YXNaRDVXSjlFNVg4?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ab2b24-45d0-4f1f-181f-08dd0b3ded72
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 21:37:56.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4o9YeUOve7lClJI6yY+OXZsL5b3hqiq9WnQYVb99ylJwhLmJsxynti2wbH+8BrwmnSRFrfKSbYDWG2xGolIOXDM/4v7QoWEAx9eRiQqBaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5319
X-OriginatorOrg: intel.com

Hi Babu,

On 11/22/24 10:25 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 11/18/2024 4:07 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 11/18/24 11:04 AM, Moger, Babu wrote:
>>> Hi Reinette,
>>>
>>> On 11/15/24 18:00, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>>> Introduce the interface file "mbm_assign_mode" to list monitor modes
>>>>> supported.
>>>>>
>>>>> The "mbm_cntr_assign" mode provides the option to assign a counter to
>>>>> an RMID, event pair and monitor the bandwidth as long as it is assigned.
>>>>>
>>>>> On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
>>>>> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
>>>>>
>>>>> The "default" mode is the existing monitoring mode that works without the
>>>>> explicit counter assignment, instead relying on dynamic counter assignment
>>>>> by hardware that may result in hardware not dedicating a counter resulting
>>>>> in monitoring data reads returning "Unavailable".
>>>>>
>>>>> Provide an interface to display the monitor mode on the system.
>>>>> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>>> [mbm_cntr_assign]
>>>>> default
>>>>>
>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>> ---
>>
>> ...
>>
>>>> I'm concerned that users with Intel platforms may want to use the "mbm_cntr_assign" mode
>>>> to make the event data "more predictable" and then be concerned when the mode does
>>>> not exist.
>>>>
>>>> As an alternative, is it possible to know the number of hardware counters on AMD systems
>>>> without ABMC? I wonder if we could perhaps always expose num_mbm_cntrs as a way for
>>>> users to know if their platform may be impacted by this type of "unpredictability" (by comparing
>>>> num_mbm_cntrs to num_rmids).
>>>
>>> There is some round about(or hacky) way to find that out number of RMIDs
>>> that can be active.
>>
>> Does this give consistent and accurate data? Is this something that can be added to resctrl?
>> (Reading your other message [1] it does not sound as though it can produce an accurate
>> number on boot.)
>> If not then it will be up to the documentation to be accurate.
>>
>>
>>>>> +
>>>>> +    AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
>>>>> +    enable this mode by default so that counters remain assigned even when the
>>>>> +    corresponding RMID is not in use by any processor.
>>>>> +
>>>>> +    "default":
>>>>> +
>>>>> +    In default mode resctrl assumes there is a hardware counter for each
>>>>> +    event within every CTRL_MON and MON group. Reading mbm_total_bytes or
>>>>> +    mbm_local_bytes may report 'Unavailable' if there is no counter associated
>>>>> +    with that event.
>>>>
>>>> If I understand correctly, on AMD platforms without ABMC the events only report
>>>> "Unavailable" if there is no counter assigned at the time of the query. If a counter
>>>> is unassigned and then reassigned then the event count will reset and the user
>>>> will get some data back but it may thus be unpredictable (to match earlier language).
>>>> Is this correct? Any AMD platform in "default" mode may thus be vulnerable to
>>>> "unpredictable" event counts (not just "Unavailable") ... this gets complicated
>>>
>>> Yes. All the AMD systems without ABMC are affected by this problem.
>>>
>>>> because users should be steered to avoid "default" mode if mbm_assign_mode is
>>>> available, while not be made concerned to use "default" mode on Intel where
>>>> mbm_assign_mode is not available.
>>>
>>> Can we add text to clarify this?
>>
>> Please do.
> 
> I think we need to add text about AMD systems. How about this?
> 
> "default":
> In default mode resctrl assumes there is a hardware counter for each
> event within every CTRL_MON and MON group. On AMD systems with 16 more monitoring groups, reading mbm_total_bytes or mbm_local_bytes may report 'Unavailable' if there is no counter associated with that event. It is therefore recommended to use the 'mbm_cntr_assign' mode, if supported."


What is meant with "On AMD systems with 16 more monitoring groups"? First, the language is
not clear, second, you mentioned earlier that there is just a "hacky" way to determine number
of RMIDs that can be active but here "16" is made official in the documentation?

Reinette


