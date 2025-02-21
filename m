Return-Path: <linux-kernel+bounces-526769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F676A402F3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B21B7A872F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AAA20F083;
	Fri, 21 Feb 2025 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ir2AH0lz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A3205ABC;
	Fri, 21 Feb 2025 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177817; cv=fail; b=Ivw786O4ZRwAj2C0FswRz2fZdS+ETHkiK7xUDgCbGHXvpA7bfe8WR6yXObZHP8WPAkYhsGtvI0PDmU+pvDkfVazkGmDrxS/0ZBNyhfP0pbHubvBaKg/MpuuobRIMVSgC18DgjUiCbDxRxw8le8bLPiHdAHcfu8sV/lKCo+mczJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177817; c=relaxed/simple;
	bh=XKzDNn6VOgy1nvMKZUx3ff9o3ziTSWeKlSGOWp5XKdA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oCtm5aIOLneIjxo9htyZuE8ehZ6ffvL1IJBkxv1LZKXe/nknU8fY8vm/HVqdmvZJ7XYGdbuf/ZWJPxYLJSY2g7fVu5OhnTXeBNwEERUsLtYISQw7E8z2Ld8xfIkE6Lt68EHU5uqcxSHa35BlRCmLcEUJ29haSrHYQhNcVDYST+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ir2AH0lz; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740177815; x=1771713815;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XKzDNn6VOgy1nvMKZUx3ff9o3ziTSWeKlSGOWp5XKdA=;
  b=ir2AH0lz/NsfL2gb54YPR57UNjGz5wp2QGgU1l/NeC+p+m6OR3MkMg59
   kxjjazKJxq3VleU1F7c7BeIiH9Mmay71mTyD94JgkY2yGVImEzNwkWP7r
   fWaMRWDGL6jOCuL9TVdmMy72guNN3WkHqxN9buX9InaUbakCsLUUljcfn
   510e56vBHHLV4fH3j6FU/I/PM3QJcKyCwDtx6VQPA/Q94NKVjvG95aD89
   jJsOmPrj4pn7Omtqe1iMwTnf1Hh9DNx7QVc0esPYE9IqIavYCYV69haGu
   0VitQhj3Y8CRXJxDkx378HEbqm3az3vAX8N+5/b3oRdJgz2e7ua8O7axv
   g==;
X-CSE-ConnectionGUID: lVrw66v2RIaE/e7Xwsy8zA==
X-CSE-MsgGUID: 7CkyvUCBT3egXtvsET9ZDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="58424575"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="58424575"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 14:43:34 -0800
X-CSE-ConnectionGUID: egLA2AVbRpeceaHD6/Lkuw==
X-CSE-MsgGUID: kRHN6e30TG2kLBwY2uF1/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="115306823"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 14:43:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 21 Feb 2025 14:43:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Feb 2025 14:43:31 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 14:43:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vn3Waold9Rkt1mIWVxcJpRnYcmEOefFk0Ai7PeBNwYqOfVAceN91eueOuoeoq3/6/DzGtI0RBZoDYBmNJRD3PRnNxUk6wRVR4VMNJ6UwsGcWnSHt0VOaGCeIrYjzYC9R1pl83EbD7SxsMhUqYG+p5ssXCal4Dl3Xmsst2Y1VPHoUrEeSarPCHiqCzVcmcagMxkmggoBp2uGXQtEp6hPLwTmNOhE3Fq8XaOWgnyeDI2ff0J42+omlH71waZBJKVV6FvyR9y8UWoo+n2TRwAT6xkAynZWIS7+OF7RWqNdE96s9GFyILQhsqvZdgys8K3UtHVbLoLdGZy1bh+oPRw0dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6rlJXToBbP/T+QIPhgo01pt7zc4JNKrkXoL1zMv2XM=;
 b=ygKpUPvuvXhfNmxOkeUl+VdElCaIL787ZBX/HMMu1XwGjW4lLjRuSfsawmVch5Bno/34vaBGMtkSzjd9MaBq051wlDYRPD5uNFcsuNjSC5HLmI+PQGGZU2DVaSIdKpxqB6OB5Ti6lRtabixJdRfSSdMyjRt8z/5XfO5oR7Vgayq1bpJIbyG+39hKySSXccPnjEFCWsDCecUnK9j2VfkXu/g7uwE/GdDWxs3ZQAWn0C6096HFSql6ny2KYrq0fiw7Jipta831ioq29Wj3us5Kg2ZigT8GrG4sCmHOqyHA9TMX+xMUXaU6cYTmxP/LxpVxOYMO5kvL3atzpQb3s85TdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 22:43:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 22:43:27 +0000
Message-ID: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
Date: Fri, 21 Feb 2025 14:43:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
CC: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>, "Babu
 Moger" <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
 <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
 <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com>
 <CALPaoChXvLNMg240C7RyBvg0SxXfGf_ozKC6X7Qe4OxyEcL2tw@mail.gmail.com>
 <a3b46f6f-a844-4648-905e-53d662e5715f@intel.com>
 <CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:303:6b::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 64bbe6e5-040e-4696-c2ca-08dd52c92824
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTlvQzhMaEpkSFM5SmtxT2s4enRtYnlpRGlXVHJTT01BN2VFQXNiWXRXY3VT?=
 =?utf-8?B?ejF5OG5tQm9hdGlwUmRVditaVWVYQ0lVYjM0UzlLa2Evenp0Ky9ub3Rqa2kx?=
 =?utf-8?B?ck1Xem8rUW5HejZ2UXdiSzRqRDg0aFlBcmxHcUZlbVNPZXd5V2hUSEpOL2dO?=
 =?utf-8?B?L3pJVGxDaDArTmVYSG1LTDVUQnBsM2lqOHBpTkJEczVaT3pPRmw5S0wySW9a?=
 =?utf-8?B?MTBEbExqeUVkWlA4ckJFL0NsSE1zbEttWEtWdjVkT3c0SGkyRUV2NzRQT1B5?=
 =?utf-8?B?U09CMVZYV1NHc1ozaVJOR1U4SlcrTWZLRlhnRHRUdUdoelZPbTdGaHJKR0pZ?=
 =?utf-8?B?WEp5ZjJ5TXQrcmg3TldOY0MyallkMzFFK0ZUN0F5ZWNtMUQ2R0VOVis4U0Y0?=
 =?utf-8?B?MXQzanhSaUJxeUd2NHVLeW9EdXdMeitST1J6a0thV0theUg0MmlzakFKLzly?=
 =?utf-8?B?dm9IV2ptRDZJNXpxMXlVVE1LSXFCaEVIQWUzb05lYXpabjlvL2pHR1FWekF1?=
 =?utf-8?B?UFEraE1ja0VUKzlUbFRuNXRzZ0NlVGFDeGl6SFduUzZGUGNUT0NWclJDWXVW?=
 =?utf-8?B?aU9pcUl2eTFTYXdWbkVtVUNjUmNQRHJ4V2swdGxPdDZwUUtzTVV0cUJrNzVR?=
 =?utf-8?B?ZW44ZTJKSFpWRnpnUUUzUys1MER3aDZxQVY1NDVGSkUwRVRpc3E2VG5sL2RV?=
 =?utf-8?B?UnhkWWU1TUlUd3hLZXg4dnFkQ0U5MWtZSXBTZ1I1MVVBbzh0T1BEWGdoQUFk?=
 =?utf-8?B?ZGxCeVk3ckpqZHhjMy82UEJmSDZzSlR2STZrTEJtR3B3MUNBNUVqTlBFYldx?=
 =?utf-8?B?ZkFRUjVYNmVpU0k0QXJ5U1U3dWNNcy80bnhSM0VVK0Mwdi9xYTZlaloxUXBp?=
 =?utf-8?B?blNwZEpxZXc2aloyUHEwRElwMFJKQlRDREFkQ1ZGd1A0a09IRUVVeW5ZL2N3?=
 =?utf-8?B?dmc3Ty90enMwcFNSaURaVXhFVGpGRWkvSzBuZk9XRHNJZ0E1TXgzUkN2c0Vw?=
 =?utf-8?B?dVdCRkJ3dG1FR0psZHEzVjdaRkdPMCtzSnJGdVdNSHh5UVFpMUhlN1FSU2JL?=
 =?utf-8?B?RzVkTzYzNjRSQVFaMTVWYkhHRUtnVmI4V2FLcGdQckxyb2puL1pMVld5VHhM?=
 =?utf-8?B?QUk5eU5NMUJyL1N3R01GOWJQNHFOTTZMb2dGenJmZVA3TGNiOHdDd1plTHJG?=
 =?utf-8?B?VlVLempuQm56S0JTT0xSVEZmbGl5eHhyQmNXMEdmVTZ4NWw5S2Vkend0Nnl2?=
 =?utf-8?B?aEFPUHAyVFdMc3FpSVdHMllRdWRtNHQ5d2ZVZjNlUVdCc2gwcURMZXB2dStO?=
 =?utf-8?B?eVF2dENPMTFIK2xMZW1NTloyUC95S3hLZ3JQaWRJU2ZLS2pHaWxLczFWY1My?=
 =?utf-8?B?b1ppQkpLZmFCSXlPQUs1eW1QYm4vRWFPN091SXVGMlBDM0FSdTY0Y3JLZUIz?=
 =?utf-8?B?czNvbVh0b29FQ1dFVzFMM1hkZ0VoS1NyRjZuUlY2UjlGbVgxcWJVclMyT0lC?=
 =?utf-8?B?ditIT1BiY3pyR09hK2duZXFtbmc0SEY0bFJQZ1cvTGlhc3JFVmhSK3Q4MmNz?=
 =?utf-8?B?aHM3UG82eUxGZmZDYk4zUnhLT1UyVXlVMFp5TXFsZFNYYXl0cHhubGpacUo5?=
 =?utf-8?B?K3JTZTU1NDQ0YjVRcExDdDNra1QzdDRBN2VzcklQb2xNQlVKdnp3WlljVW13?=
 =?utf-8?B?QkNFc21VZHl4MTdnVmZmWHA1V1pHQ2ViQXJZSWxISUR5Y0JRTXQ1Q1U2TzZL?=
 =?utf-8?B?eUdNS0hYMlNMUVl6WDhib0dIRTY2RHJoaDVkajdWVU8wd1VWWjRMdVBkR080?=
 =?utf-8?B?L21GS2JNVDUveVNWdWRUUnZaTWtLeU9ocUZBR3JVU3E5ZWduMklIZjlrcU45?=
 =?utf-8?Q?kYaKRMCOTZ37M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWlSWG9BV2FjUUF4RzdnSk12QVZSSHNGQkpySCtBZStLd1JCRW5HOTVtbWQ2?=
 =?utf-8?B?YXFQU2c4c2FzdEE2TEg1cGFncnhvL3g5VW0xUDI4aVBDT01vSE5lNHlvV3Jt?=
 =?utf-8?B?a0lPSndWK1JqVHdWdktXN0owZ1UrSnhCNExCNEFqVmhJb3dZSGR2MUNnemZ6?=
 =?utf-8?B?OURYU0VlRGxic3lRWGZwUFBiQkdlQjlkRjJ2YnBRQTg1Rk9nK0xFK2I3SkhM?=
 =?utf-8?B?TzR5NDREQjVDSk9taGZ6T2tla0U0eW02UUlsc3VpTVE1d0lFemhCeHcyNGJZ?=
 =?utf-8?B?bkVaZGFqcmxUU0F1WnVneWkrUE13VHUzTm1VbTBoUUE0QkhvLzcvNGFUWXBR?=
 =?utf-8?B?Znd0b0plQU90cjdtQlpWRjdKL25zS3BMYkp3UHhMSkFGc3RpaW1MS01MOWgz?=
 =?utf-8?B?SC9FWFUzdzI0TzhGaGZzcXlFcHdTTVdsQkNweXJkTDN6RElXSUU1Y3UxZUhy?=
 =?utf-8?B?aCtKY2dsWlpLVGs4SDB4MmFuMjE1aDJHSEc1SWExcEdzWUllZmk3dlN6SkUr?=
 =?utf-8?B?MEV3M1A1ZmpOTzZuTjcyeW56ZGdWRDUyUjVwaVlLRGJPaTNlK3hEVUZXclgr?=
 =?utf-8?B?YVV1RjdtVlBRSDZoWDI4UmxvTjdPb3QzNG5uNGE3YUorcElzWngzV2ZkNmNq?=
 =?utf-8?B?YnhTcGhReGFDQlIyUU8xcUlwZG1HU0ptd29ObXVwSGxrVnE3WkE2dlZobkk3?=
 =?utf-8?B?aFpucUlHaEp0bm1YVzZ3aXJSdzB1NGROTzhRMVRpSFpNRmZOZVhCS3Y5Nnpr?=
 =?utf-8?B?MTQwcmF3ZVdQcUgvajR1WmR1bHU4MHNjL0hDWGFBa1ZIcnpBU0NxQXhUVURs?=
 =?utf-8?B?clp6UzlFcjVNUWZOZDZvalhKNDVBVkxvYlJMbndvSTdqSE1tMzBURkg0aUd0?=
 =?utf-8?B?YkJvSUtaTy85RXlTSUdseHd4MVA3azdkTVJuM2FFZWRQeWU4ZGxVcWJ2d1g0?=
 =?utf-8?B?bCtiWEpkMjliVGd3MTJGM0ZwMmx4R1RvVVlkdlJxV2t4T2w4aHRvM1ZUdWFs?=
 =?utf-8?B?aTlVUUpBOHYxa0JOc21sVjFSVUhDd01VTkk0VjhsTkttMHZZd2hSRmMyRkhP?=
 =?utf-8?B?c2F6NDJ0bGYvQWRjQlpjV2Z2MU1YOE9iU05yY2lwbEZNd0k3N3ArVUlwc0dH?=
 =?utf-8?B?cW1vV3BBWExteTBEWHRVak9HMWFPM1V5aHhRdGNPdHJYK2wzYWRPWEltb21Z?=
 =?utf-8?B?bVVsMVRZcExCcVdZMGpFcUVpUktIb0tWL0ZoazR3TWVEQ05uU09KOEN2Z3JZ?=
 =?utf-8?B?L25oTUtQWVkrdUZZQWFJUW8zWXkrQUVaZVJ2ckN4U2ovM2FGL0RBRW1BNnRM?=
 =?utf-8?B?WWJDL1huKzRCZVVPRjBqcGtEN2pZYUdsL3l4Ym9BTWozWDlZMDBEV3l2R0Y5?=
 =?utf-8?B?cy9tRXMzZUxyaExWcGhuekxqOGFBQXRUWjk3cFBxQytkMEpKTHF1TnlxREpX?=
 =?utf-8?B?NDlIRlZrdmxML3hCVnJKekVEdXJWb0tsajlTY3VweURkY0ZwRzRZbFdaZkVN?=
 =?utf-8?B?djVWVFpYTTNyRnROUzlMdDVyQ1pMeFB5TDhHOGxoM0NjaEZ1bjJQalVFQ3NB?=
 =?utf-8?B?aEFvT2hWU3ZTVHJGMmxjRG50aUw2aEs1Vnhkc1MvdUlxQVJCUktUaEgrQVFW?=
 =?utf-8?B?NHdQRXl4SkQrVmJ2U3NXbzlubXdZYklzRi9jM0dSV240VFo0YkZYQ0VQYkI1?=
 =?utf-8?B?YWIzM3A0NXdnT3M4RnNiMFZIb1NHRUFvaUdBajVCVDl2NEtsWkFXVjdsTkw2?=
 =?utf-8?B?emx5QnhwUHBoQXNRVDJiTGFmMDZBZjd0U2ZGZUk3VjVOb1AySW9XK2UzR210?=
 =?utf-8?B?enBiRndGY3hVUkRqZmlGU2c4ajQwcWsrdVFCOUZEa2NKVitGRkw1cVpYa3BP?=
 =?utf-8?B?RjlHL2N0dHh5dGRtNmFNOVBSS1lRQnFCeFhtQUZDQmdmMkdJYktlNk9qdEky?=
 =?utf-8?B?SFJwQSsrYjZSV0wrMDVXNWpKSHhVclBCRzJDMWF6bzE4ZEJBOHJBd2pvSWtV?=
 =?utf-8?B?b0tDbEQwM2ZqcTBvVHJUY2JNWnMweHJTSE5kK3FwWDdaeG82RzdpMFY5Yk9U?=
 =?utf-8?B?Y0JzcWtBS1dRZlpqRmZyMlJ0ZzZlMTUvd0hib3lNYm5OaE5xYVNIZnZIRWxU?=
 =?utf-8?B?RWtJMXBLWkpnekFqclNJTlpoWGdjN0lVNW5ScGx1cUVudjhuSitOL3l1ZVhC?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bbe6e5-040e-4696-c2ca-08dd52c92824
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 22:43:27.3538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yO79/44mcN+ZSpVEgswdMTMXDAD3mc48gCToo/+ZTsp2dyC0uVxkBvH2nZewyhx+uJyZiGDPeVSSkMShoCpcoR1tLwsLrZvd2jxK/n7KQqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8168
X-OriginatorOrg: intel.com

Hi Peter,

On 2/21/25 5:12 AM, Peter Newman wrote:
> On Thu, Feb 20, 2025 at 7:36 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 2/20/25 6:53 AM, Peter Newman wrote:
>>> On Wed, Feb 19, 2025 at 7:21 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>> On 2/19/25 3:28 AM, Peter Newman wrote:
>>>>> On Tue, Feb 18, 2025 at 6:50 PM Reinette Chatre
>>>>> <reinette.chatre@intel.com> wrote:
>>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
>>>>>>> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>>>>>
>>>>>>>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>>>>>>>
>>>>>>>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>>>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>>>>>>>> Please help me understand if you see it differently.
>>>>>>>>>>>>
>>>>>>>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>>>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>>>>>>>
>>>>>>>>>>>> mbm_local_read_bytes a
>>>>>>>>>>>> mbm_local_write_bytes b
>>>>>>>>>>>>
>>>>>>>>>>>> Then mbm_assign_control can be used as:
>>>>>>>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>>>>>>>> <value>
>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>>>>>>>
>>>>>>>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>>>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>>>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>>>>>>
>>>>>>>> As mentioned above, one possible issue with existing interface is that
>>>>>>>> it is limited to 26 events (assuming only lower case letters are used). The limit
>>>>>>>> is low enough to be of concern.
>>>>>>>
>>>>>>> The events which can be monitored by a single counter on ABMC and MPAM
>>>>>>> so far are combinable, so 26 counters per group today means it limits
>>>>>>> breaking down MBM traffic for each group 26 ways. If a user complained
>>>>>>> that a 26-way breakdown of a group's MBM traffic was limiting their
>>>>>>> investigation, I would question whether they know what they're looking
>>>>>>> for.
>>>>>>
>>>>>> The key here is "so far" as well as the focus on MBM only.
>>>>>>
>>>>>> It is impossible for me to predict what we will see in a couple of years
>>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
>>>>>> to support their users. Just looking at the Intel RDT spec the event register
>>>>>> has space for 32 events for each "CPU agent" resource. That does not take into
>>>>>> account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
>>>>>> that he is working on patches [1] that will add new events and shared the idea
>>>>>> that we may be trending to support "perf" like events associated with RMID. I
>>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements to support their
>>>>>> customers.
>>>>>> This all makes me think that resctrl should be ready to support more events than 26.
>>>>>
>>>>> I was thinking of the letters as representing a reusable, user-defined
>>>>> event-set for applying to a single counter rather than as individual
>>>>> events, since MPAM and ABMC allow us to choose the set of events each
>>>>> one counts. Wherever we define the letters, we could use more symbolic
>>>>> event names.
>>>>
>>>> Thank you for clarifying.
>>>>
>>>>>
>>>>> In the letters as events model, choosing the events assigned to a
>>>>> group wouldn't be enough information, since we would want to control
>>>>> which events should share a counter and which should be counted by
>>>>> separate counters. I think the amount of information that would need
>>>>> to be encoded into mbm_assign_control to represent the level of
>>>>> configurability supported by hardware would quickly get out of hand.
>>>>>
>>>>> Maybe as an example, one counter for all reads, one counter for all
>>>>> writes in ABMC would look like...
>>>>>
>>>>> (L3_QOS_ABMC_CFG.BwType field names below)
>>>>>
>>>>> (per domain)
>>>>> group 0:
>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>> group 1:
>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>> ...
>>>>>
>>>>
>>>> I think this may also be what Dave was heading towards in [2] but in that
>>>> example and above the counter configuration appears to be global. You do mention
>>>> "configurability supported by hardware" so I wonder if per-domain counter
>>>> configuration is a requirement?
>>>
>>> If it's global and we want a particular group to be watched by more
>>> counters, I wouldn't want this to result in allocating more counters
>>> for that group in all domains, or allocating counters in domains where
>>> they're not needed. I want to encourage my users to avoid allocating
>>> monitoring resources in domains where a job is not allowed to run so
>>> there's less pressure on the counters.
>>>
>>> In Dave's proposal it looks like global configuration means
>>> globally-defined "named counter configurations", which works because
>>> it's really per-domain assignment of the configurations to however
>>> many counters the group needs in each domain.
>>
>> I think I am becoming lost. Would a global configuration not break your
>> view of "event-set applied to a single counter"? If a counter is configured
>> globally then it would not make it possible to support the full configurability
>> of the hardware.
>> Before I add more confusion, let me try with an example that builds on your
>> earlier example copied below:
>>
>>>>> (per domain)
>>>>> group 0:
>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>> group 1:
>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>> ...
>>
>> Since the above states "per domain" I rewrite the example to highlight that as
>> I understand it:
>>
>> group 0:
>>  domain 0:
>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>  domain 1:
>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>> group 1:
>>  domain 0:
>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>  domain 1:
>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>
>> You mention that you do not want counters to be allocated in domains that they
>> are not needed in. So, let's say group 0 does not need counter 0 and counter 1
>> in domain 1, resulting in:
>>
>> group 0:
>>  domain 0:
>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>> group 1:
>>  domain 0:
>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>  domain 1:
>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>
>> With counter 0 and counter 1 available in domain 1, these counters could
>> theoretically be configured to give group 1 more data in domain 1:
>>
>> group 0:
>>  domain 0:
>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>> group 1:
>>  domain 0:
>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>  domain 1:
>>   counter 0: LclFill,RmtFill
>>   counter 1: LclNTWr,RmtNTWr
>>   counter 2: LclSlowFill,RmtSlowFill
>>   counter 3: VictimBW
>>
>> The counters are shown with different per-domain configurations that seems to
>> match with earlier goals of (a) choose events counted by each counter and
>> (b) do not allocate counters in domains where they are not needed. As I
>> understand the above does contradict global counter configuration though.
>> Or do you mean that only the *name* of the counter is global and then
>> that it is reconfigured as part of every assignment?
> 
> Yes, I meant only the *name* is global. I assume based on a particular
> system configuration, the user will settle on a handful of useful
> groupings to count.
> 
> Perhaps mbm_assign_control syntax is the clearest way to express an example...
> 
>  # define global configurations (in ABMC terms), not necessarily in this
>  # syntax and probably not in the mbm_assign_control file.
> 
>  r=LclFill,RmtFill,LclSlowFill,RmtSlowFill
>  w=VictimBW,LclNTWr,RmtNTWr
> 
>  # legacy "total" configuration, effectively r+w
>  t=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
> 
>  /group0/0=t;1=t
>  /group1/0=t;1=t
>  /group2/0=_;1=t
>  /group3/0=rw;1=_
> 
> - group2 is restricted to domain 0
> - group3 is restricted to domain 1
> - the rest are unrestricted
> - In group3, we decided we need to separate read and write traffic
> 
> This consumes 4 counters in domain 0 and 3 counters in domain 1.
> 

I see. Thank you for the example.

resctrl supports per-domain configurations with the following possible when
using mbm_total_bytes_config and mbm_local_bytes_config:

t(domain 0)=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
t(domain 1)=LclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr

   /group0/0=t;1=t
   /group1/0=t;1=t

Even though the flags are identical in all domains, the assigned counters will
be configured differently in each domain.

With this supported by hardware and currently also supported by resctrl it seems
reasonable to carry this forward to what will be supported next.

>>
>>>> Until now I viewed counter configuration separate from counter assignment,
>>>> similar to how AMD's counters can be configured via mbm_total_bytes_config and
>>>> mbm_local_bytes_config before they are assigned. That is still per-domain
>>>> counter configuration though, not per-counter.
>>>>
>>>>> I assume packing all of this info for a group's desired counter
>>>>> configuration into a single line (with 32 domains per line on many
>>>>> dual-socket AMD configurations I see) would be difficult to look at,
>>>>> even if we could settle on a single letter to represent each
>>>>> universally.
>>>>>
>>>>>>
>>>>>> My goal is for resctrl to have a user interface that can as much as possible
>>>>>> be ready for whatever may be required from it years down the line. Of course,
>>>>>> I may be wrong and resctrl would never need to support more than 26 events per
>>>>>> resource (*). The risk is that resctrl *may* need to support more than 26 events
>>>>>> and how could resctrl support that?
>>>>>>
>>>>>> What is the risk of supporting more than 26 events? As I highlighted earlier
>>>>>> the interface I used as demonstration may become unwieldy to parse on a system
>>>>>> with many domains that supports many events. This is a concern for me. Any suggestions
>>>>>> will be appreciated, especially from you since I know that you are very familiar with
>>>>>> issues related to large scale use of resctrl interfaces.
>>>>>
>>>>> It's mainly just the unwieldiness of all the information in one file.
>>>>> It's already at the limit of what I can visually look through.
>>>>
>>>> I agree.
>>>>
>>>>>
>>>>> I believe that shared assignments will take care of all the
>>>>> high-frequency and performance-intensive batch configuration updates I
>>>>> was originally concerned about, so I no longer see much benefit in
>>>>> finding ways to textually encode all this information in a single file
>>>>> when it would be more manageable to distribute it around the
>>>>> filesystem hierarchy.
>>>>
>>>> This is significant. The motivation for the single file was to support
>>>> the "high-frequency and performance-intensive" usage. Would "shared assignments"
>>>> not also depend on the same files that, if distributed, will require many
>>>> filesystem operations?
>>>> Having the files distributed will be significantly simpler while also
>>>> avoiding the file size issue that Dave Martin exposed.
>>>
>>> The remaining filesystem operations will be assigning or removing
>>> shared counter assignments in the applicable domains, which would
>>> normally correspond to mkdir/rmdir of groups or changing their CPU
>>> affinity. The shared assignments are more "program and forget", while
>>> the exclusive assignment approach requires updates for every counter
>>> (in every domain) every few seconds to cover a large number of groups.
>>>
>>> When they want to pay extra attention to a particular group, I expect
>>> they'll ask for exclusive counters and leave them assigned for a while
>>> as they collect extra data.
>>
>> The single file approach is already unwieldy. The demands that will be
>> placed on it to support the usages currently being discussed would make this
>> interface even harder to use and manage. If the single file is not required
>> then I think we should go back to smaller files distributed in resctrl.
>> This may not even be an either/or argument. One way to view mbm_assign_control
>> could be as a way for user to interact with the distributed counter
>> related files with a single file system operation. Although, without
>> knowing how counter configuration is expected to work this remains unclear.
> 
> If we do both interfaces and the multi-file model gives us more
> capability to express configurations, we could find situations where
> there are configurations we cannot represent when reading back from
> mbm_assign_control, or updates through mbm_assign_control have
> ambiguous effects on existing configurations which were created with
> other files.

Right. My assumption was that the syntax would be identical.

> 
> However, the example I gave above seems to be adequately represented
> by a minor extension to mbm_assign_control and we all seem to

To confirm what you mean with "minor extension to mbm_assign_control",
is this where the flags are associated with counter configurations? At this
time this is done separately from mbm_assign_control with the hardcoded "t"
and "l" flags configured via mbm_total_bytes_config and mbm_local_bytes
respectively. I think it would be simpler to keep these configurations
separate from mbm_assign_control. How it would look without better
understanding of MPAM is not clear to me at this time, unless if the
requirement is to enhance support for ABMC and BMEC. I do see that
this can be added later to build on what is supported by mbm_assign_control
with the syntax in this version.

> understand it now, so maybe it's not broken yet. It's unfortunate that
> work went into a requirement that's no longer relevant, but I don't
> think that on its own is a blocker.

I understand that requirements may change as we get new information.
Digesting it now is significantly easier than trying to adapt after
the user interface is merged and essentially set in stone.

Reinette


