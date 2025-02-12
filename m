Return-Path: <linux-kernel+bounces-512059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD4A33388
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F258B7A2948
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22B4253F0A;
	Wed, 12 Feb 2025 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dY4Regn1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ACD2627E5;
	Wed, 12 Feb 2025 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403658; cv=fail; b=nIsbj/aDkQUzPa0p6APXDsXk0MQbbCbq5b4g5oF4QvSKBWx63oAAHHwIHEg9PgdLVfSK6UEW7DULOs0zTe/H8TUMXHsTEM8Wk5qyDiu2ALfn0ZEZ8Yn21zZgiP1fPG9GM+V02sVVO5sR8RsZglDweWknhKxfAvccv0TpnX7i5qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403658; c=relaxed/simple;
	bh=8+hFXPrs+4LrsmEtNbhm19sAJhsOaSLETCG+ehAuzW8=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rl8iE4jEsdpEshm8mu/bdrVTqsW1kALwBy+ohTvQmLbXfL2/2an79jIQJrp+GJTpffZBb/WtbR8RdClJY4Pg9Js6IkmCuFXeJuH6kKJX/MBRa/i5krBs1aVDeOLNXWCteLWZArhojgJJRzZ69xaIlzXlkzgThVjMAvXTqKsUbbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dY4Regn1; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739403656; x=1770939656;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8+hFXPrs+4LrsmEtNbhm19sAJhsOaSLETCG+ehAuzW8=;
  b=dY4Regn1BQA7WaP/wMfvaTl9diLHvlre0dfZ8lqbWmognnNy4pyB5ZQw
   wmqNgW/fDakMAlrQOdg/WKt0KCTb+6fuGOVL7YyEK80mJnJkp9jZrP/5k
   HJVwNXKygLc3gk+FsKX9hRwEhz0cFH1xkdDKTRqDLbnJlJ8ns7kCWbvIL
   egMfVQ6SJICCzaY3cbT6LUPX53oDjl3uuphXD8ceBDj5imYoY0ibhfeIp
   ZCFUp4n7ZIwgtBU4nzXgLpXaHJlhwUTVkScsa40pP/mtXHziHcc/CbebC
   r1Jr0ldMoC5FM6y3OVsHZ5Arym858smLdgmM8R2sIWd/0rIFv2bT4qYZk
   A==;
X-CSE-ConnectionGUID: zO23uWuhQImT80W4QsdgaQ==
X-CSE-MsgGUID: jKk5d3BISQK733QGZ4OTZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40350755"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="40350755"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 15:40:55 -0800
X-CSE-ConnectionGUID: MNB+MCIqQkuZkxVFxq0VDA==
X-CSE-MsgGUID: zhuLyAE3T3WYsbGl7kJmZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="112960425"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 15:40:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 15:40:54 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 15:40:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 15:40:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFNFtjdwxeGGpSSpiVEnB/9CNjv2BXjT4QUY+vZi7SmFWDqQH09CBJPfv1f3hStxM2zurasTYpiZuGbUoKKEVTmy26LgFnaZe3nvl7LBzq9LpPN5/5YWWzz18FnoNmMu+iq+cixaCArC+NSoWvRhpWYdxR5i74vbX3uKKCqEy08/5K/OaOcBypFuwOtwTmDFKMh7LFb5ePW8w/ytiCeM9nTzKuKG5X7KPIvqxAliuZ8T3SOv/QooTk6J+TkJBoXn1MCd7pPZuPsYG4KqNnsKYTL9VKs7jzCF1SsgW51onn0btlsOsGZth8JpnbEvldKC/LF7WXfCrUjxk/X4Tvbtzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8Rafr4fNrtuDUnetscsnCdUHZk8cGdNjXYygpg7V0c=;
 b=kkMTJ9avZyzfLT/xLaoDBZ/YCmiSOhMnw3anJr2NMaQlcgIA5F3kxm1rZiuosI1j7/6VhNFA+QNhSBxtSH2hypqYq/wzp1EE50ZjVr7lNooWF+rRE+UnT0/KHEovUtlJY6wXHz/KYMPCCrPNTyBqPI+5w3DTIt5cPXEsp5DCL9il3Io+rp4paWYdtfARaiyL9MmKjY6gxh/DHsdb1xtr5RO5MEsXczOW7bAUbvNumZyzMjDQ699p68de/aaE7m4+s7NVLt83U3LzsO6LxZRNFzNMXsdH1eh9BaetcnvLTr7HxTzcG0NscM77ImN5Ve4h19C2CpOysj1k9Iyoaoqcsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Wed, 12 Feb
 2025 23:40:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 23:40:51 +0000
Message-ID: <715aed9d-dbfd-4b7b-a70d-b69262553c1a@intel.com>
Date: Wed, 12 Feb 2025 15:40:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
From: Reinette Chatre <reinette.chatre@intel.com>
To: Dave Martin <Dave.Martin@arm.com>, Babu Moger <babu.moger@amd.com>,
	<peternewman@google.com>
CC: <corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <tony.luck@intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<akpm@linux-foundation.org>, <thuth@redhat.com>, <rostedt@goodmis.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <jpoimboe@kernel.org>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <xin3.li@intel.com>,
	<andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
Content-Language: en-US
In-Reply-To: <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 29581158-7516-4452-33ce-08dd4bbeaf39
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnJER3JXcXVLNjZPSHRtdWlYZFJadHJrMUwxRXBWWld0QkQwaWlYNHdsdVpy?=
 =?utf-8?B?VWJRY0E2OUk4N2hwdkZCSG1rMEdZWUFDWitrelhtZTgxbVZWUUdOa0svWElB?=
 =?utf-8?B?aFMzZkdVL2xYU1JQUkQ4dVc5N1VRY1BqK3dmNzBWRkl5bVl4eXA1Z0IrSHRF?=
 =?utf-8?B?RTRwV2IzY3R3OHNBODg4YVFLSEJ1dmoxT2tISHQvRi9GTytrQzVhc2ZUWjVj?=
 =?utf-8?B?L2pTZGh1dnI0NE1rMk12NHBmdjJySnNWMXY5SElCbG8yL0JVcGdOaEo4MWZv?=
 =?utf-8?B?Q3djTWJHemlvTGIrcVh3L1M4bUtrd1hsRnh3a2oya1h4Mkl3cmVLdUJ3QVNo?=
 =?utf-8?B?QjN3VXBEU1EydjZXcFdoM01HTEVkUGZxTW00WDNMa3p1NWt6R0RET1EyS0l4?=
 =?utf-8?B?STNlK3A1cjIzM1Yrd1VsblBtRitnMnUvSDNrdzgzb1B1RURWNUV3SHUxN1RX?=
 =?utf-8?B?YjV6MG9WVitsUVpGYURTQVJvY0Vub2ZmZ0FZS3V0QVRDeHYxM2xvaVY4ejRZ?=
 =?utf-8?B?UzVkOHNEem5YYTJxS2E1aWtLREJDYU1CdWZBUWpKYjEyS3ZDZUlvT1RZZnQx?=
 =?utf-8?B?TDg2Rml6UnJMSktBMnRIUnBuNnZlQUcrQXo3Uk94Wm9LeVNkVGN2YitVeVVC?=
 =?utf-8?B?dGpEMy8xK0ZYU2ZSREJZU1B2ZHcycEV2MjV2a0VhaFNiUjIvdmNrZVQyRWZ5?=
 =?utf-8?B?NzBaeE1iNVl1R3V0WDUva0I4NGdpa3l6NzBaSHBlRHBPNVJxa21qWlZ1YTNk?=
 =?utf-8?B?K1dvcVFEUFBNaEJyUzUyOWowa29tQkFaN1pDTnBZMXZaaUtnVnlvRDB6d3dM?=
 =?utf-8?B?UU0waDBpYXJ6ZTBSYk42SkVtd2gxSkFiWTFpV20yTmhPamRGeXZhd0w4Tnlv?=
 =?utf-8?B?MlVleis3dmxrU2dYM3B4bS9SZzlIbkk4TGtHOW1LQTN2RjNBMnVjUlNreDRi?=
 =?utf-8?B?emZ1TnR6OVZ3UGFSSFZKS24vczhwYmF0UU9WYjhPNmZna2dEbmtJcHFpcjF4?=
 =?utf-8?B?THdSeGN1MGUrSjJ1V0Y1MHVhNHI4VmpQZ1dId2J5UGZ1RDFrK0hVOEowRnl4?=
 =?utf-8?B?YWtwbndCNVRYeUNqY0M0ZXdMNXRjdU1EQWZMWjkzNUxHZVIybGhzb3VwbG5r?=
 =?utf-8?B?S0dSVTJnQUpuei9nMWZxM2dMeDF0SUkvcHV4U0ZrUnRGS0tMTU1tYThrMGZm?=
 =?utf-8?B?aGxub21tR2FBNXk5RGZPTHAvV2lLOGp2RUZWYkxweVlxKzVpVStGOU8xeVp3?=
 =?utf-8?B?YTB5K2hscTZXZ283WHUwOE92K1NnVFBsQVRBckhKK1NKZlNmQ2JXVHZpN1lm?=
 =?utf-8?B?dlhOTGVxaFJpYWhEMUswZ1p5bmhVYTR1NkxDa3JwMWdKQk9OWWVGZEtDd2ww?=
 =?utf-8?B?Rm9JQnRKcGcvQUFLWGtuYW9uNmFidFoxZnBocitBSEtSOTEyRzJsaWxGRDBm?=
 =?utf-8?B?WGhoRkJqcGt2ekVPMHVwMXFvL29lNXZnYWlaL3FqUGFXamNjSGhFWVJrNDFV?=
 =?utf-8?B?Q25ONk16b25PSTVnTzhWWnRKOWpHd1JTR0ZqN0FUZTI4b1k5OW83Z3Z5SlNP?=
 =?utf-8?B?NUk4QzhHY0VYcER1SnZCelluTEVSdEpYdmpBYmNRSUt1WEVhdytpMFc5d1ZQ?=
 =?utf-8?B?SVVObDlVSFpsLzJPLy9aak5DeC93YXJzNUhCUEM0djRueUJQWGlqUXlmQy9t?=
 =?utf-8?B?TGJJTVBMRmJtZEhNbjFmNkg5b2JmNHlVaTR4SXhOcFYyYW5pK0tKdytGY1lK?=
 =?utf-8?B?aU1NR08zSjNZWTRGSk5yNEdqWWJTaXZxRDBLQmlCYXdSVWlvLzVZWTZSeHdr?=
 =?utf-8?B?a0VKd2VNM1hTWHpOYWZvQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnlnTEpqdWdYODIyYlZHMmRZYTU3Wlg5bUkxNFEvWGp3bnQxYzd0dk50Uk9o?=
 =?utf-8?B?Wk40VldRRUxLSWtOQTBVSE9FYlJUTEVzeFBnMjhYeDV0cG92VEVRU2djOUh6?=
 =?utf-8?B?OUxzTVFSeXhlUVlpT3liOGVJVXorK3RvSGhwb0dqcHg5ZUxCREZQZ1p2SkR5?=
 =?utf-8?B?NitKb1JVVnI0OW5kREpBMzBqSG5LaHNlQ25CTjNKazBibEI2QWFFVDFwc1Zh?=
 =?utf-8?B?L1JRRjhHL1BQMHA5OW5WeXc4S01wNVlIVHVZLzBjbE5rQmRWbVoxYVJGMTRL?=
 =?utf-8?B?UU5FaEhraEliK0Q3M2dsWVRXU1Jlb1k3OGdSQlNNOExXN0NJWGliMjNaSUFY?=
 =?utf-8?B?d1RJSENYL2RscFRqd2cwbFM5VURnTnF5RlExWUdKTDZnZUE5UHplaWZjLzJ4?=
 =?utf-8?B?MndzWWpZK0pzeXJTY3psdGdLbUttbzJhU2tLd1pBdGxOdHc3Qzc0ZTgvUXRH?=
 =?utf-8?B?VXh5Mlk5QnFXejZBMDFlTllqeXB0ZXJMVzJUQkxLQmlwaXd2WXdMZHRKUFhP?=
 =?utf-8?B?RDhyR2phTTlsOEp3NytGZWI3L3dUcTVObHJJZ0w1U2VSa25vMUpVQ0w5UWlq?=
 =?utf-8?B?QVBZMk5iVXFKMjhIZDZHd1BxaURDV285aTFhQnIrVnE3RENBakZLY3VnYmZy?=
 =?utf-8?B?Ui9WZUZVNEJyckVWemRTYXdVMHpmOGV6ZnJmcmRPcUFNTjUrQTJPZ1FpSnVR?=
 =?utf-8?B?THN4L3NUOGZSUzgrOEl0aUJFdTJCRUNWZUJTNThYekpaRWl2Z1hsbGR6dlMz?=
 =?utf-8?B?L1ErNTM3RFQ3d0pEaCtCS1gxeU9SdlpoWkZNRDBTd1ZrbkxOR0srN3dJOS85?=
 =?utf-8?B?OHJCUHI0b2dkbjFUVWgxMXI5RkMwYUhOL2w4RGh5REwrTXlITWVZS1JEa1U0?=
 =?utf-8?B?KzdRT0J2TFpWOFF5Tmw5STY4RVhROUhmSW5jWkRmd0tlVmFvbTBkQ091K2Fq?=
 =?utf-8?B?T0pMdEJUNVliL0FQeG9uTFhIUFRyYXNCRmJ6UFN3RDhPQXFyc0RDQnZEeHN4?=
 =?utf-8?B?K2I3UjVJS3o1eCs2YzMwaGI5akZDMlJ1OWdyd0UzV2xIQWErZ3p5aEJzQk5t?=
 =?utf-8?B?cXoyeEI5enppZmNyclhXWVRsbnRGSFlGQnFDb0ZZcFFuMVZ2bjJubXk1dk1x?=
 =?utf-8?B?eEVPK1BLKzc5bElrblpIMjJESi95KytBK2N4QkhkK2UvS2dBQjRaNFM1b3l1?=
 =?utf-8?B?eFR6Q3grdW1USkw0RDNDL0ZweStqdmFoVHViTGhvYklmby9lZzJQRlRUczhZ?=
 =?utf-8?B?S3ZZZmpIcG1pWU0wcXRCSE0zTVZzZCtWNXlSN1F2Mkd6THZYaWFxQmJIQjA2?=
 =?utf-8?B?ZFlBalhQTGdKQzM3bG5ZeHUxaXE5ZXNMQnI4WGtxMUFiY1dQd3FPUi9oS2Ja?=
 =?utf-8?B?Q1lzVmEwYmViVlNSVzM0alJOdTlCYjl1TG5ONG9qUk9FQTVLRm5YSnhaNU5N?=
 =?utf-8?B?RVB6V0NRSVY4YjY0QnVrcDZIb3Q4VGxUekVLejQvbndKRGVKcnNDUkJKbU1u?=
 =?utf-8?B?SS9oRnhjTTZWeUY5WFN3TllyanI2aTlJS1dMWTcra2hMeUxVWElJcnVPS1Iw?=
 =?utf-8?B?Y0ZQRWpvNk8rQkpUZllUZ3dXKzk0OEFZSzNsQ3F5dmRRbUgvWmhLbS93K1dq?=
 =?utf-8?B?S0ZzeUo3cUh4U3QweWpxeXZFeWpIVXZPM1I1Q2k5L0p5TzJZZk1lblF4STBx?=
 =?utf-8?B?V2M2Wi9uekxucEN3aFlONnBlODY3akxKaC90aDV5VzVGWUM0amNxM2E0RGpF?=
 =?utf-8?B?YytRWUpRMDBlVGJpQkVmQzc3MDBUMGsrNEI5bGpCSjJ2Q3VyaEhWVEhiU0to?=
 =?utf-8?B?SXZVWjRDOHBVMjgzSk43a2VKWGtFdEY1QTlKZjZldDVOcUVKWGpKRmp1R3JM?=
 =?utf-8?B?ZFNnL2dNTTc1MnRhYVJRSHJuRmhaSjd4eWs5OEROUXQwWG8valVwRzl5czJa?=
 =?utf-8?B?MXlFbHBPclJwbGhsWFQvWERmRjBsdEhGelNrZld3R1JrK2N0UkZGKzRGZ3NZ?=
 =?utf-8?B?ZWVaRmZaejBmRXM2WDVMc2tsWTZxT1FwYlBSS2grc0IzY2txaThsUi9uSFAx?=
 =?utf-8?B?TmtpUjY3Z1FxRVdKWXRjcFZYdHlBdlU1YWdFMnpwNnlBK05vSVV3VlRKQnV2?=
 =?utf-8?B?dzc1dmlVUS92dmc1dXhZMXIvbzdFVW1HQjhUa3Z4Vkc1QjdCU09Fb0J2RWJs?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29581158-7516-4452-33ce-08dd4bbeaf39
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 23:40:51.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VQktpws5WnGWppHHv9BSpN32Vg+5SfUHPULqguwVTUYXrJ3xmoXYBxEWltXCQ7P/QuRqaXRKV+M7hsmQleqaBRwTX11+aweOy7D/aPihaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
X-OriginatorOrg: intel.com

-Fenghua (his email address does not work anymore)

On 2/12/25 3:33 PM, Reinette Chatre wrote:
> Hi Dave,
> 
> On 2/12/25 9:46 AM, Dave Martin wrote:
>> Hi there,
>>
>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>
>>> This series adds the support for Assignable Bandwidth Monitoring Counters
>>> (ABMC). It is also called QoS RMID Pinning feature
>>>
>>> Series is written such that it is easier to support other assignable
>>> features supported from different vendors.
>>>
>>> The feature details are documented in the  APM listed below [1].
>>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>> Monitoring (ABMC). The documentation is available at
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>>
>>> The patches are based on top of commit
>>> d361b84d51bfe (tip/master) Merge branch into tip/master: 'x86/tdx'
>>>
>>> # Introduction
>>
>> [...]
>>
>>> # Examples
>>>
>>> a. Check if ABMC support is available
>>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>>
>>> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>> 	[mbm_cntr_assign]
>>> 	default
>>
>> (Nit: can this be called "mbm_counter_assign"?  The name is already
>> long, so I wonder whether anything is gained by using a cryptic
>> abbreviation for "counter".  Same with all the "cntrs" elsewhere.
>> This is purely cosmetic, though -- the interface works either way.)
>>
>>> 	ABMC feature is detected and it is enabled.
>>>
>>> b. Check how many ABMC counters are available. 
>>>
>>> 	# cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs 
>>> 	32
>>
>> Is this file needed?
>>
>> With MPAM, it is more difficult to promise that the same number of
>> counters will be available everywhere.
>>
>> Rather than lie, or report a "safe" value here that may waste some
>> counters, can we just allow the number of counters to be be discovered
>> per domain via available_mbm_cntrs?
> 
> This sounds reasonable to me. I think us having trouble with the
> user documentation of this file so late in development should also have been
> a sign to rethink its value.
> 
> For a user to discover the number of counters supported via available_mbm_cntrs
> would require the file's contents to be captured right after mount. Since we've
> had scenarios where new userspace needs to discover an up-and-running system's
> configuration this may not be possible. I thus wonder instead of removing
> num_mbm_cntrs, it could be modified to return the per-domain supported counters
> instead of a single value? 
> 
>> num_closids and num_rmids are already problematic for MPAM, so it would
>> be good to avoid any more parameters of this sort from being reported
>> to userspace unless there is a clear understanding of why they are
>> needed.
> 
> Yes. Appreciate your help in identifying what could be problematic for MPAM.
> 
>>
>> Reporting number of counters per monitoring domain is a more natural
>> fit for MPAM, as below:
>>
>>> c. Check how many ABMC counters are available in each domain.
>>>
>>> 	# cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs 
>>> 	0=30;1=30
>>
>> For MPAM, this seems supportable.  Each monitoring domain will have
>> some counters, and a well-defined number of them will be available for
>> allocation at any one time.
>>
>>> d. Create few resctrl groups.
>>>
>>> 	# mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
>>> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
>>> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
>>>
>>> e. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>    to list and modify any group's monitoring states. File provides single place
>>>    to list monitoring states of all the resctrl groups. It makes it easier for
>>>    user space to learn about the used counters without needing to traverse all
>>>    the groups thus reducing the number of file system calls.
>>>
>>> 	The list follows the following format:
>>>
>>> 	"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>>
>>> 	Format for specific type of groups:
>>>
>>> 	* Default CTRL_MON group:
>>> 	 "//<domain_id>=<flags>"
>>
>> [...]
>>
>>>        Flags can be one of the following:
>>>
>>>         t  MBM total event is enabled.
>>>         l  MBM local event is enabled.
>>>         tl Both total and local MBM events are enabled.
>>>         _  None of the MBM events are enabled
>>>
>>> 	Examples:
>>
>> [...]
>>
>> I think that this basically works for MPAM.
>>
>> The local/total distinction doesn't map in a consistent way onto MPAM,
>> but this problem is not specific to ABMC.  It feels sensible for ABMC
>> to be built around the same concepts that resctrl already has elsewhere
>> in the interface.  MPAM will do its best to fit (as already).
>>
>> Regarding Peter's use case of assiging multiple counters to a
>> monitoring group [1], I feel that it's probably good enough to make
>> sure that the ABMC interface can be extended in future in a backwards
>> compatible way so as to support this, without trying to support it
>> immediately.
>>
>> [1] https://lore.kernel.org/lkml/CALPaoCjY-3f2tWvBjuaQPfoPhxveWxxCxHqQMn4BEaeBXBa0bA@mail.gmail.com/
>>
> 
> I do not think that resctrl's current support of the mbm_total_bytes and
> mbm_local_bytes should be considered as the "only" two available "slots"
> into which all possible events should be forced into. "mon_features" exists
> to guide user space to which events are supported and as I see it new events
> can be listed here to inform user space of their availability, with their
> associated event files available in the resource groups.
> 
>>
>> For example, if we added new generic "letters" -- say, "0" to "9",
>> combined with new counter files in resctrlfs, that feels like a
>> possible approach.  ABMC (as in this series) should just reject such
>> such assignments, and the new counter files wouldn't exist.
>>
>> Availability of this feature could also be reported as a distinct mode
>> in mbm_assign_mode, say "mbm_cntr_generic", or whatever.
>>
>>
>> A _sketch_ of this follows.  This is NOT a proposal -- the key
>> question is whether we are confident that we can extend the interface
>> in this way in the future without breaking anything.
>>
>> If "yes", then the ABMC interface (as proposed by this series) works as
>> a foundation to build on.
>>
>> --8<--
>>
>> [artists's impression]
>>
>> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>  	mbm_cntr_generic
>>  	[mbm_cntr_assign]
>>  	default
>>
>> # echo mbm_cntr_generic >/sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> # echo '//0=01;1=23' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> # echo t >/sys/fs/resctrl/info/L3_MON/mbm_counter0_bytes_type 
>> # echo l >/sys/fs/resctrl/info/L3_MON/mbm_counter1_bytes_type 
>> # echo t >/sys/fs/resctrl/info/L3_MON/mbm_counter2_bytes_type 
>> # echo l >/sys/fs/resctrl/info/L3_MON/mbm_counter3_bytes_type 
>>
>> ...
>>
>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_counter1_bytes
>>
>> etc.
>>
> 
> It is not clear to me what additional features such an interface enables. It
> also looks like user space will need to track and manage counter IDs?
> 
> It sounds to me as though the issue starts with your statement
> "The local/total distinction doesn't map in a consistent way onto MPAM". To
> address this I expect that an MPAM system will not support nor list
> mbm_total_bytes and/or mbm_local_bytes in its mon_features file (*)? Instead,
> it would list the events that are appropriate to the system? Trying to match
> with what Peter said [1] in the message you refer to, this may be possible:
> 
> # cat /sys/fs/resctrl/info/L3_MON/mon_features
> mbm_local_read_bytes
> mbm_local_write_bytes
> mbm_local_bytes
> 
> (*) I am including mbm_local_bytes since it could be an event that can be software
> defined as a sum of mbm_local_read_bytes and mbm_local_write_bytes when they are both
> counted.
> 
> I see the support for MPAM events distinct from the support of assignable counters.
> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
> Please help me understand if you see it differently.
> 	
> Doing so would need to come up with alphabetical letters for these events,
> which seems to be needed for your proposal also? If we use possible flags of:
> 
> mbm_local_read_bytes a
> mbm_local_write_bytes b
> 
> Then mbm_assign_control can be used as:
> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
> <value>
> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
> 
> One issue would be when resctrl needs to support more than 26 events (no more flags available),
> assuming that upper case would be used for "shared" counters (unless this interface is defined
> differently and only few uppercase letters used for it). Would this be too low of a limit?
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/CALPaoCjY-3f2tWvBjuaQPfoPhxveWxxCxHqQMn4BEaeBXBa0bA@mail.gmail.com/


