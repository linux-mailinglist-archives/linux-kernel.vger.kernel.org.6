Return-Path: <linux-kernel+bounces-515542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58A1A3660C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA451897EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F8B19884C;
	Fri, 14 Feb 2025 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGy1Pl3v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CB12AF16;
	Fri, 14 Feb 2025 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739560704; cv=fail; b=rEtSFYOnGZ5CFuPdaCBCmKQbChE+04VPR6zwe2Y3ommW75UbcwC7pSO3RAlXxKSlaCFcY0O9ThdHGNp+v/hzkvFRF+igzj22WurC68RzaPELIQFBxShAJ6qfxWVOTe7HH6F57f18UJ0+EDNQhDZTGemZyHoo4cL4uWOio8BS/SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739560704; c=relaxed/simple;
	bh=zwEqnxRR1NrFibM82uEmTz+rNaxYRhd7DIBB2gpudzY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NusO/rswsw/jzO19SJxcW0Xg3ilZLiBtyTsrYTXGdqJSh6uvnogZcBRwFKQvLsoC3ALgsy9zi0ehrpMylTm3x/0ZInLIxth+gauKEGf65ZsvLPuSQvB8wNYZEV6Yq5RdQF9Iscb6elU9WA/qVWCrHf8LnOH3r+CFIGZS6/c0Bck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGy1Pl3v; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739560703; x=1771096703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zwEqnxRR1NrFibM82uEmTz+rNaxYRhd7DIBB2gpudzY=;
  b=jGy1Pl3vV/WpuAvfsvcsOB5vjpnC6cQDYeVY4+astFriDkwcMciXZ6VN
   9yL871d8b/ZC7EgnsLsS8/Gv+HVnFiEXxL9lsKskPrl0g7kjFxrDFUw3H
   CPeTjtC0974DqAueGpNp+kvtvJgG6+L3RLm4r0DxyGt3gpzJ/Rv9kAv+S
   7ihqzdQX5y/qtKs4D5WzxaBaROyU4W50PQ0SxLKN0cOcrGvo6LVkImaGW
   rBUAxiq/TtlrqrVgRzbZLljj0EP41djboymgiRzdapIE6xjzc2NLCvHLb
   vsCBturopurHKRQfaPl0qgIAIEiW9xSp/hzxgYZk0D3mFJIDr+5YYOpjZ
   Q==;
X-CSE-ConnectionGUID: fWm7yrDtRaWlZG+nSWaxxQ==
X-CSE-MsgGUID: a/tFTP19Rsi7jNd43FaQ8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40446504"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40446504"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 11:18:18 -0800
X-CSE-ConnectionGUID: kIfhGYnDSgOszSay9I7GlA==
X-CSE-MsgGUID: gduM4EpoSv2tvik7+PIiKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="118645156"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 11:18:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 11:18:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 14 Feb 2025 11:18:14 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 11:18:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQxML1AUy83Oe1FIawb3kbATJdJp/sbr3wBeHOiQIbBcZwpVhNCu+g49yComQBe2kIwNY8s5kwI5C18iu6wWfQSIZrGaplTNZYKbUu97zNXVVHPA+0bBFTPIlk1hNJnsET58KJLFw7HVgZAzxgxZO9vZjrtW1wLL0301QIF5S/QT+iKZ0F/8E2z9NkifKVLtmFyL99SpVVxNDyzY7FUlWmvhD3sqzDqmo+gOPPHNzO7NYbHUMiNDgWuMLYHDMRcrCgdRUgpVqYhrVoEddoiXdW3dS5cCwT1uhThfCZ96Ol+3/lRnpmg3S9p+pu3VH0iENyNMzXkvH5U7mq+YIpAMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Adgw8nUA4+BnSy9xRW9SGnTig0J794viCslnOwYTrTk=;
 b=AVpm79cLUEn0Z0DdP8DXBQHKRKA+C3CNbxSsFBmpvnBphR7bnsTcObIcsrYYoU+atKU9wjMo0uKVCwiAFn3GGLqX29M2TosAnH2SIRofMA7HMXuUvjaMmunpdcJwzWHI6QKQnzKX2LHQ4fpnJlNL2UEASb6gQoMTIcJH+C0OyEqhqKL6lxcmamzxcvHs32sw7F4xFCaeS/4ECgmz2bddM6C70jGIFhKFpzSdlCG1/35puemyH8jKkqtExfNIQxCEFvKYn7F5op9J/UDRrsqGEEEj7JoFYyOTp52K1BfXE2E8S7PH2Cl88LqvANpnHeLuScBI6ssKJXBuZvc4QC+ncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5972.namprd11.prod.outlook.com (2603:10b6:8:5f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Fri, 14 Feb 2025 19:18:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 19:18:10 +0000
Message-ID: <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
Date: Fri, 14 Feb 2025 11:18:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>
CC: Babu Moger <babu.moger@amd.com>, <peternewman@google.com>,
	<corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <tony.luck@intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <paulmck@kernel.org>, <akpm@linux-foundation.org>,
	<thuth@redhat.com>, <rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
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
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0144.namprd04.prod.outlook.com
 (2603:10b6:303:84::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a80402-93fc-49be-6095-08dd4d2c520c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dSsreTZXTkNrcVpudFI2cEd6Z09KZDZJdndGam5VWWRIQWNERXNQQWxZbHd1?=
 =?utf-8?B?SlNEbkhHdU1Vd0djd28xQXQ5aWxNdkNFYzR3ZjNKd0FwR29hUlhoem1SVFBa?=
 =?utf-8?B?RmNrb1lTTnY4U1JHamxIYUJyRmNXaHArbVNKbGVOcndQZjlKVzlHUHZTaXNk?=
 =?utf-8?B?NlRxa0JTUFFiNVQ5THNpQ3VyaEZvVDQ2a2duRFlQZk9pV2hjREtvUnNQZjQr?=
 =?utf-8?B?TnVQNFNSTld3TlJYYVArQ0NHbEdwSExYTjFGUWd4OXpTbW9YQktMak1qZVFx?=
 =?utf-8?B?NTFxRUJBcmgrcWV6ZitqOG93cG9DMmFidG5xSDBNL2xzRUpORUdMeFIyeTdt?=
 =?utf-8?B?eFQvanFBZllXaTNMUDFJbHVPSWhpZlZGK25TODFmNEpYc1IvbkczSzFOL2Mz?=
 =?utf-8?B?VCtKSmMvQU5kdWtoYmNlQ3d5eSsyMXBFaitHRWY4aDlNZ2FHdkhHb1RnWU9m?=
 =?utf-8?B?OUh1Tjl3eTVBZGVtN001NStqT0VVWGI4R0oxTm5ld0duOXZVS0Y3T2M0K0hh?=
 =?utf-8?B?aEJlSWtGUVozaUxIR2dHY3BKdjZ0UWMvTFRrVjZSSk0xQktUbEpHcER1aEZu?=
 =?utf-8?B?aHdGZjBDdThMVy9UdGk5TGlqOFMzQUtFVjRPTXltQUVzMTBMVEFYaGk5TXR2?=
 =?utf-8?B?SHYwZEpYeHBtOXhORFNSaXk3bEZwR3JoWE54b0dKb0dNU1hKYVUxMUNSZ2NI?=
 =?utf-8?B?WW9VamlvTWJvSWIvaHZGV08vb25mK3BpQkZLc1gvWXNjSUU5QWo5WkpNZnEx?=
 =?utf-8?B?K1BQWEV6bVJYQUtpNVkwQXEySU1QUGIzdUtOTG8vV2grb0RmWWZFWmp5VSsz?=
 =?utf-8?B?MmhzVkY2bjBTaWpEeUN5dWh4Y3I5WmpnQXFlSVZSQ1hOdHNKNGVzcitqUWZX?=
 =?utf-8?B?MW9DNkZzQ3BXL2NkV0dBc0RRN2xBcCtxQU9XZGFvVW11ZWtPZjBPY1ZRNlRM?=
 =?utf-8?B?ZUliZWU0d0hEUmc5ckZPTW9pLzdhektLTEl4YzY2aVZJY0tiUzY2UEJheDE1?=
 =?utf-8?B?VXlhTGloamZONUdjVVpZZytoYTBkZGdkemtrTzF2M0dkZGJ5UmIyTnBtWnFL?=
 =?utf-8?B?SExHWmRwc2t6Sjl6VlB4blhTWWpmS1J3YWxrbHdzOW92UVRHVzFEWk1qQVQ3?=
 =?utf-8?B?RkIvc21ZbzZtMlNRVFoyVkVzU0ZvMjduUnFHb0ZrVzdFMzJzR1krYWtkMTB0?=
 =?utf-8?B?cmZtQlY3MHFsdmIwTndkc0o0MkJmU2VoYVhSdGxaL2lkblNqWXRiWDNDY3pv?=
 =?utf-8?B?UUFLbmM0UWZKbTNpM0p3UnRzSC94U2NKTFF1Tm9XODg2alZ6bFd6SUE5TEsx?=
 =?utf-8?B?YWF6ZWwvUXhpNmM3aFVhN0lhb0pSZnhWMGIyMXJZYUU4NExtcENlNWZaUkhU?=
 =?utf-8?B?UWUzbmU2QzByYVd3bTlDbU8vVDZ3Y3FxbWZVdVJ1Zlh3N1VhemhRM1FrYXll?=
 =?utf-8?B?NHdGYkxaWDF2b0tRa3pSeExlVFdkejlGczBJckJwQ0E2dUxQZDNwYUlqQVdz?=
 =?utf-8?B?VmNoV0k3cGlVMHFuWWQxd1I3dXRIUElJSm1ZTWo0QzVpTWlEM05YQU1XQ2RJ?=
 =?utf-8?B?MllFTFhvYmFaUVZqVXN0dDFuZ01UMlhUVFR6QkRoK1dFWEdhWmJhckYvSjAy?=
 =?utf-8?B?NDZZc3dLblBHcmp5aURoUWNRTlZ4ZnJ6ZTUwc1RKVWlWcEFlelJNek1QZTRj?=
 =?utf-8?B?ZFh1aGxkb1Vrb0FlRG83d1RxOXJPLys0djNPQlNyeS9ZUTN2YjBRTHhaY0dS?=
 =?utf-8?B?U1VjbDEzVFNBL3l1WVZkdFNHdzJwd0RnQ29hM1hWSG1ySmtxQkcrb0hWMThz?=
 =?utf-8?B?VjBHbXgwbEV1SUthdkYxeFJ4eXBZRENVQi9XSUsyS1pEaHJMWkt0NGRlUG9x?=
 =?utf-8?Q?yVCN4brzFuk+Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkFPM0QzMzFVQTQ5YzZ2azRRNzZCOWJvdittUURUeGJGVmlvUXcvU1M2Smxy?=
 =?utf-8?B?Rmo5MHBLSXZuWHJEUWVmTVVMSjlNazZBb0xra0IrZjRHSk4yWGg0SzhsbUcx?=
 =?utf-8?B?cG5CZ1M4RUZBenNiZVlrc0I4U0wzb3hRTXNuY2t2YTk5Wlg3b3dqYzBZL3U0?=
 =?utf-8?B?cHYxNEdtMnp1N2taaStrL2hBM0c0QVI5VEZZZGlUM0R3Z3dOcE9Qejg4UzVj?=
 =?utf-8?B?YmJpRnZkeVhuVXZTLzNSb1ltSmJabmN5cEQxVTdxTXFCZEJZeFI4UmhpNWdo?=
 =?utf-8?B?UmtWaFJCNGNGeDROTm03YlRSZEdNOGFkdXlUNmY3cGZKRjFaL0RNQ29Cck8z?=
 =?utf-8?B?NEZDN3llRENaV0tYcCthYndxNktnbjd6L1N4dmtmcEswZVAzcGg5WnhmR2Ux?=
 =?utf-8?B?OHNMdUw2b0lldnZhOHJHd1prUmFuK1k2dVZURjUrcHN4SGF0M0h0MzArSHRR?=
 =?utf-8?B?NlhWU2E4SHZ5WkQzTTVYblJxNVZuajg1Wm54QTVubExRN2MxMzd2ZjFvTEtR?=
 =?utf-8?B?QzE4OGR1cThYQW1pVEFYbitMbk42Nm0zNHUzZGxCTFBoY2RxdERIQ2RzNWFY?=
 =?utf-8?B?L2RyQ1RiU2JYZU9ZMVBMcndpSUlqcFo4aUd3elkrbHVSdXZyMHBOMStpdmsx?=
 =?utf-8?B?cUc3QjQ4ZWlXRUxZQnBSVk55ckRrdk1Sak9Cd3AzbmdwK1ZXUHFnSncwbkEz?=
 =?utf-8?B?bVJaZ2haNG94VDhEdFpYQXlPRGcwUllMNnphQ0ZlZXA3TVdBVWozQTVST2xZ?=
 =?utf-8?B?TDE5WGVoZXR6d29ZSWJNMTBNd2FIdkhYd2Vxc2NMZEs3N2NLR21jMldHYjVh?=
 =?utf-8?B?citrTUZXOXdOK0c1d2UybkpGZVVISVkvcGxnMjZLMStOWUhHYklvZ2hRSzZs?=
 =?utf-8?B?a0poZ1R0VlROanYwemZ1OFF6UFFoTmpUT29JWUgra0FHQmpWQVRMd0FXZ0l2?=
 =?utf-8?B?M1ViKzZRMHBnaEFLbHNyOUxIclBsQ0R1WW5Ob1ZHL1JpcVRwRGIrbDBYM2lL?=
 =?utf-8?B?SXdGM0lYYklwWGIxSjY0ZTcva3Y5MVBRS0dQMHZDcCthdFZXeGczUGFGRVZ6?=
 =?utf-8?B?aHZZSVZXYVM3MFV1dDBpQS9NaCtGNnpPRmcwMWQyMTM3Q3lJRGRmUW1HQ2ND?=
 =?utf-8?B?UUNFRTBsRDhPMjFKSXVrVXM3U3ZIRlpqK2NmaFJJODBJYWV5cFBYTXdRNWFJ?=
 =?utf-8?B?bzVXTXFYM21Wbk8wUVlVQTk0T2JuWmhkL042cCtGYU50bW80N0hrM2d4Qi9F?=
 =?utf-8?B?eFo4cUNFK0VVRFF2SlNOUWJtVW1IZ3dwaklVQUhwZjB4MlUxbVVwMUs2Z0ZZ?=
 =?utf-8?B?MHdjM3Y5RDVuY3pta2kxd1JLNDdOU01XNHZ5c0RwcjQ5VndUb1NwUGhQT2RL?=
 =?utf-8?B?VzVVTC9aZXlUbzFHNk4zZ0doaFdoeGZLTzVoMUViOHNxcU9NbTlEaEF3R2dr?=
 =?utf-8?B?QVlpd1puQ3JmM1RybmJLUmFBZm5LZ0gyMzRGSXFsczBoYzhlN1NHSjlsakY0?=
 =?utf-8?B?c3g0VCs3QnlUelV5VlBUWU1zZ1dpMGo5VzB2K2RPaCtjeTZzRG5XRlJSMm11?=
 =?utf-8?B?MC9Cb3JzRnk4YUZ6RG5TSmZWSjkxMFlraUJjTmQvK3VPdURRcFY0VlJPamJU?=
 =?utf-8?B?YktMYlhrczkza25QQUViRkFTYWlBWkJFbFRBS2srWHIwRnpONnRuSHlqT3By?=
 =?utf-8?B?azY2VkVoUzBSRTBxR1UvbldQVHNTWmZJV2tOaTNPWnFJZTB5QzYzZFdFQjRt?=
 =?utf-8?B?b09VWkhkaTZXeWNNbDVaYVppeXJJdWJZTmxBdVZLek80QkhKN3N2TDZmdTZ5?=
 =?utf-8?B?YjNVcXBNbHo3TnBrYzBBTGZiam95Y1NhNHE2Q214VFIwQUIrSjgzTnpYS3E5?=
 =?utf-8?B?dDl3NFpsMUZNQUowby9RYjEzSTlWYStGWEFscHNoUklDSWt4dzBid2pMQURl?=
 =?utf-8?B?RHFoTzYwWjRtVXlPcU9vdDZ6K3NJY0Q4TlVOL3AvaDU2UHM5ZzNSOHduS0ND?=
 =?utf-8?B?VkxaTFltZ1JLQ0ZGNXJYUTJDbk5BVmZwWFp0Qy9lSEJxUjRNaUpWK1kydzdk?=
 =?utf-8?B?TnhRcHdGS2dsb2srS3A5NWVMVnhpRHFrV1M3WDBjSEVoUWxGTVFDSGthY24z?=
 =?utf-8?B?VzBvMHZ2YzQvMi9GaHAwWldzcHRYQUkzUFRxWVQxaHQwcW1vQVRjYUVvOEJx?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a80402-93fc-49be-6095-08dd4d2c520c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:18:10.8395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDY2Wv567quhkTWUmi7TfkrTLd1zyrb3ZguXC2UI7kHog6izr5p2bRU6LPpMB/jV02x2717/+7Ysfu+LZFG0Yc1OL7h+uqWBYxRvCCMAHMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5972
X-OriginatorOrg: intel.com

Hi Babu,

On 2/14/25 10:31 AM, Moger, Babu wrote:
> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:

(quoting relevant parts with goal to focus discussion on new possible syntax)

>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>> Please help me understand if you see it differently.
>>>>     
>>>> Doing so would need to come up with alphabetical letters for these events,
>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>
>>>> mbm_local_read_bytes a
>>>> mbm_local_write_bytes b
>>>>
>>>> Then mbm_assign_control can be used as:
>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>> <value>
>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>
>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?

As mentioned above, one possible issue with existing interface is that
it is limited to 26 events (assuming only lower case letters are used). The limit
is low enough to be of concern.

....

>>>
>>> Alternatively, if we want to be able to expand beyond single letters,
>>> could we reserve one or more characters for extension purposes?
>>>
>>> If braces are forbidden by the syntax today, could we add support for
>>> something like the following later on, without breaking anything?
>>>
>>> # echo '//0={foo}{bar};1={bar}' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>
>>

Dave proposed a change in syntax that can (a) support unlimited events,
(b) be more intuitive than the one letter flags that may be hard to match
to the events they correspond to.

>> Thank you for the suggestion. I think we may need something like this.
>> Babu, what do you think?
> 
> I'm not quite clear on this. Do we know what 'foo' and 'bar' refer to?
> It is a random text?

Not random text. It refers to the events.

I do not know if braces is what will be settled on but a slight change in
example to make it match your series can be:

# echo '//0={mbm_total_bytes}{mbm_local_bytes};1={mbm_local_bytes}' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control

With syntax like above there is no concern that we will run out of
flags and the events assigned are clear without needing to parse separate flags.
For a system with a lot of events and domains this will become quite a lot
to parse though.

> 
> In his example from
> https://lore.kernel.org/lkml/Z643WdXYARTADSBy@e133380.arm.com/
> --------------------------------------------------------------
> The numbers are not supposed to have an hardware significance.
> 
>     '//0=6'
> 
> just "means assign some unused counter for domain 0, and create files
> in resctrl so I can configure and read it".

Thanks for pointing this out. I missed that the idea was that the
configuration files are dynamically created.

> 
> The "6" is really just a tag for labelling the resulting resctrl
> file names so that the user can tell them apart.  It's not supposed
> to imply any specific hardware counter or event.

Right.

> ------------------------------------------------------------------
> 
> It seems that 'foo' and 'bar' are tags used to create files in /sys/fs/resctrl/info/L3_MON/.
> 
> Given that, it looks like we're discussing entirely different things.

I am still trying to understand how MPAM counters can be supported.

Reinette

