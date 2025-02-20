Return-Path: <linux-kernel+bounces-522739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591E5A3CE04
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D583B748F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E47E28F5;
	Thu, 20 Feb 2025 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3rqAXr1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2F0257D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740010479; cv=fail; b=qxIXW3MB3XghWHewIml77OBE9iSBuklEL78lMwRpfidet08u7JSLTZVm7m0a4jsGSB3p7Op4PNrvAkH2kufzGU60s4w81QigguLPXUXdTVGgom6+wIBZftoq4+u8k+ZdHogcoL6VXqeLpxLEqFrPKc1CW6LkHz9UsL9q9N2uMMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740010479; c=relaxed/simple;
	bh=XV53jaIbMQ4y9Il2iKdB5Z9DJV5oF7dG4RE0U9E0Iq4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gOJJdyFpoGiybPLpLADgB8HxKVMqPJL1syfDcFHsakB6BbR2TlNl+c1yvuybIjnrwCrG0G9ES/docho9j/mqYVSSrcXXoY0OgwoEJ9JGZVvr9Hb71T5vTzL7+Ype9SnTIFZK9NEH69+4KHpLUNoUrraQd7vEao47SB3Sz15TQU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3rqAXr1; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740010477; x=1771546477;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XV53jaIbMQ4y9Il2iKdB5Z9DJV5oF7dG4RE0U9E0Iq4=;
  b=X3rqAXr1+c/PYs6TJ4SrwG96rIocRJriDa3UuD92UIprzLnoOHlvcNy3
   Yt1nD2rud8rw4a+db5cTV8gmB1TDglfGys3wWAqUFtuZpGD1Y2k88N9hG
   Dlyg96F0mzzmFXCcKoXqlzUWrkw1+zeowy5jT3ih1TuOQxzcTBOtxHx1X
   stER474NsiKogq7XLTH8H82HTH2AgWXFE5UoXF7elo/LNgH+d1g1e9A8L
   cjBqmx67JyjD/bTg8qc08vSLHzD7PM6U3Y91aa8x1U7Q9YLolxkzGBNpi
   Zy8EyUtWlHqPHLdw+xAnAqpw+IVsv8IZy7rrB5w9WQCFNPvY7luhKG0aj
   w==;
X-CSE-ConnectionGUID: 9VAOE3qTSjGPj5FJ0M1znw==
X-CSE-MsgGUID: Jfss+pYOQK2TZLKj3DbbiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="52180997"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="52180997"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 16:14:30 -0800
X-CSE-ConnectionGUID: UTVK+UD1R86hdWMY2qoXFg==
X-CSE-MsgGUID: YmB+W9tEQ7qd5++AHTPwFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="119498821"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 16:14:27 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 16:14:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 16:14:26 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 16:14:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTi/bbeKIiao6vOtwMAoqcB0IxpmyRNeMHrzv8cP/475Yb87csDfXOewvs0HarGJvz6rvBb2f9uoN3z7PyO3popomdREPlYVhwzctTNNCCcRrMTdvgwl1ftNlcCCWXlmlkUk6lR01+MvKZfxSrIcf/0th6hf2XTXBT7xwZsW+YFvb2/i37l7W8jx/XbLCbI6qlHEr5c/IqATjPqh3o2MgCBW68cbfEpN1lp9YbmljiUTyNXlhRbcZivD4h0b06BNmoOI3spk4iiyxiCm8VFEiyNFz2KTjz8WSVIMEK5koqF2N1afrkMZSKrW8k+ciF0pPtwVJxIIWazdHbkmtgT2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+S0UqyeHxC6UzQ/Qjb3bVznytMHKu1RSzAvDsTBS4o=;
 b=NIttXHBSoKEtzRq06bOhUVmQOo+P5S4N9Eo2x5ySwQrLpZlEd00Ht7K6kmTGQTx4Z1cfsBaM/ROVsjfRsedvCpbsdCdJfXNRTGcqQ4agTz2jrVnzZJkXFN3WA/dvSDp0lZMLPyTEEAfgZMEcyptOA0UMkxtwzJmG4XlBAZQOE91QIAXxWN26mPTGJvAuH7CLeTJLUvm2DHbVJIBaX+upGJ4tq9B/mKtEauQdv0ITIQMC97H6KnKq5fgQWocOEtkc4s/SJxHoXeM7j0gseuDcfsf6s8q9tdQyQ/X5vgzMssU9jGneSKUnIli2AZNVCSQMVMpn4KwOHDMCKtxCaXZpPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6154.namprd11.prod.outlook.com (2603:10b6:a03:45f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Thu, 20 Feb
 2025 00:13:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 00:13:48 +0000
Message-ID: <bbbfd020-ee0d-42db-b055-f4056d63977e@intel.com>
Date: Wed, 19 Feb 2025 16:13:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/42] x86/resctrl: Add
 resctrl_arch_is_evt_configurable() to abstract BMEC
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
 <20250207181823.6378-20-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250207181823.6378-20-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ1PR11MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2e7bfb-dbe8-435f-e658-08dd51437277
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2MvSytzT29ZRlU3b1VGUDkxWkdob1NKem4ybkJBNGsvMjFybEFoekxMOENO?=
 =?utf-8?B?STJyTEZ2TnA3WmgyRXoyMG1Uc3VBYXdHZWFCdlRkU1I4TWYwcnZUWi94cWlY?=
 =?utf-8?B?VzdaZmpDQUJLUDA5M3pNcVRYRk5UeFNsQndCWHVrbnhWZUJ6Q2FRWGFsQ3pn?=
 =?utf-8?B?VWNlalM5TkEyd2NQSFRDdWkrY0tvQS9Ta0FHV3pwN1IwNjI0S1ZYdGJaNDVF?=
 =?utf-8?B?YTVhM0p6aFhaYXYrZURXRWp1ZTZ0VGNwWHZIdnR0aXE3ZFZTR2h2NUR0UXcx?=
 =?utf-8?B?aEhVSGk4WDFrMS8ydkpEK0Zwb1c2Ly9MSForRDBMQ1pjSGlRVkF6VWY4YXVF?=
 =?utf-8?B?dGU1QUZ6TmxGUE0rYWhBVTUvaUtNbWlGaW1jZ1ZDNjFESnVuWEJiVFRmcjYr?=
 =?utf-8?B?aGhpcHlkVlBIamcweGZySnFwL2R0eVBqaVc2aHhybEpwSVQ3bElFZUVhYVFh?=
 =?utf-8?B?MnArM2k3M3hzYkRvWHp3M2djODNINzBuVS9mU1FvVTB4L1Bkc1V2M04xM21u?=
 =?utf-8?B?L1BrQ3RybEc0bVU5M1lDYWZWcWtHOXpNOEdDWFYwRkhyZ3UzRk1SbzlCZWlE?=
 =?utf-8?B?QUNOeTRaQ2syNkdSSUs0dVNrN01iVmdTeGVpb080SGRTSXp5M1ozWjdrdGxK?=
 =?utf-8?B?bDRic0FHUUVQenE3QlZIc2x6eHdoc2Z4aUpBR1FnMFlmVGI2cGovdlg2czI0?=
 =?utf-8?B?dURmRUUzMEdrQ0kwVkVlOU1sSGRJN0dGYzVnb0N1WWxFNHdwVVQyeFBKeGgx?=
 =?utf-8?B?eStUSnkyNHJ0OUZ5dFRMWnpqRVpxR1FmTUpZY0ZhVmpKZFJxd1oxOVR5R0gy?=
 =?utf-8?B?RmNjYTJCdklPN0UyeEd4OFdQR3l6ZExTV2VHb1FQVUV2OVMvZkFFRm9icksr?=
 =?utf-8?B?aXFpS2tSTit4cXlSSWUwS0FPWnZ4TVNEMm5pcEFkdXhlcHJtajgzYTg3WHgz?=
 =?utf-8?B?bW5ZV3pNLzRZaVloUmFVQ0JMeGNiT00yL3VGQVJiMEFvcVN0aEtONWVnZmQ1?=
 =?utf-8?B?YlVIZEFpa09OSmZNRjZYUTNWeXY0MDVPbzRRTVFNblZKN1AyLzRQYWdOUkVn?=
 =?utf-8?B?NWlEcUo0U2JzTnpXSmVOanphQjV3WjNOeUNLREJGalhaUGZBelZyWGFXNUlE?=
 =?utf-8?B?Y0o4Q0l4YmlzdDZQWXJmc0N1RFhDak1NSnlRYlJYWHJNNGdnZEQ0OHRVYmZW?=
 =?utf-8?B?WTFUV3hMOExWRU42WEJLMEtmeE9uemFISDhkNjRuV1hDRXFPdDVxOCs0Q21l?=
 =?utf-8?B?Vm10K1RwTnpDVTkrNXJsaGJYSC9vYlQzcVdvalR0OFByaFF3a0xXUGpVNVVF?=
 =?utf-8?B?NStaZERTVzNWbTNaVUE0eXZoaXBJTE1ZMkx0em1yWDI3UTJIdytLSnRyUElv?=
 =?utf-8?B?bEdSaVBtd0tXdWZlaURYNVNLUTExZVZFNTBHYTRvdkl6VGljL0ZGTm9ERDNC?=
 =?utf-8?B?Q1FNdDl4ajltZmllODhPVyt1R0tZRlJLYlVvdlluOVpycXc2bmRCZ3ZvdjRL?=
 =?utf-8?B?TEFNL1NEb2txdlJUeHBtbE45WEhzUjhYbnlkUlY1amVMTDlzRmQzQnF0QVlX?=
 =?utf-8?B?WjFqdTJYSWpFNm40Y1Q0UUN3M3BwN2x6MzZEV0szMGJvOTU5NUx6MVZNSmdQ?=
 =?utf-8?B?RzRDclpEU1JZUi9FVnlvdFRwQ2k0K2dWZG03L2F0VUVBV01FNDlkNEtrdjNS?=
 =?utf-8?B?QVRPeXRGdkdkQS9Zb0hmeHZvYUMxK2ZsakNQWE05dUw2YXovQ2NZeXphUGVy?=
 =?utf-8?B?dFZsQUQ0Y3BLZDdGMStDeTg2b2dPOHZ1VG9SMjRvUTlVQTViTnUyWHBabk1N?=
 =?utf-8?B?L0UwdXVobWpHWGxFVlFLdkptZEtNWkZObVVEVzYwR2V2bjAwa0RBbDFnVkNw?=
 =?utf-8?Q?0/J8hGF1Jhk4K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmdqbGRLQ1RWT1o3bVVCUFVudVdWM2l6b0E5d3pOMEJvZjFlVTNrZjBUQ0RZ?=
 =?utf-8?B?TTZ1VS82RU44NHBaRDRycWlFZDRNVVNHMUtHNDV0cmp3RlpBMWZhV3dPRUMy?=
 =?utf-8?B?VzFUQXhFT3V5cHQwNTdNeENnL3JDRnNJWk5jYThMMWc3YUhQWXd5THUrWWJT?=
 =?utf-8?B?SEZibVlQMWx2RGVNamZ1dGNadDNBR3V0aDk5TWlXcHB2UUd4QnRLMXorNjJY?=
 =?utf-8?B?S2ltVHBaVW9qcEQ3Y3h3MWVDckpsV2R2VkplVzJxTS94V1VqNVNsODlDY1Zz?=
 =?utf-8?B?MWF2R2JLc1hEb3kyRENOK3NVVFpobmM0R3pKVTBwRmVrTGRqVm5welEvYUFq?=
 =?utf-8?B?RjltZEJ3V3V2RkNKQ1ZkWW1lWTA0LzdEdXBCM3lzU2hzSFhQbEN0bXU2K1A5?=
 =?utf-8?B?djVscXpIaFErdTE0T2U4VEFXZXdZeHVPdjNYU1JoWDlFU01PUVNHd2Flcmha?=
 =?utf-8?B?QldIN3BOTWdWbTZZRTh0MU9DV3JLSkp6QndweDZTZUJ1ak4rOHM1bGlvSURQ?=
 =?utf-8?B?NVNienJqWmFhaG5TcWxIcnVPMFFDK05LSWpCQ2daS0FibkQrait5M0lDbndF?=
 =?utf-8?B?M0hCc1VhbW81QjFjYk13OFFoT2FzWlhBQm0vTmNwRTNIT2xWZFJPUGI1VkF4?=
 =?utf-8?B?QXM4am9vbTRocjhZaitsZ3pMZk5pTnMxZmFtbEJUSVJSdk9TaXpyVUxXcG44?=
 =?utf-8?B?VXB6SGtQQ2VDa0VWR0JxbjlSQThuVHhXc0RxanN1TXBkU1AxY0xYbTdEWGZi?=
 =?utf-8?B?a0dGQXNOdTgrVnpCT1RHVXB6aGhyOGZ2YUkrZld6UHFucTV4ZzJqL0RURXYx?=
 =?utf-8?B?b2NZeFJGOEhaU2hXUDU5YUIxdHJIVGw2T3NQNVlyaGl1cEdEZEdXK2dMbG5G?=
 =?utf-8?B?aFZ5eXpWckxiVXIrYkd2eG1uOFJVd3hFVFYwbWlNNmdQeVg5TVVFSGRoSG1V?=
 =?utf-8?B?OFJIZTRnK2tGVHFUcTFkbHNnL3dBNnZkY1ZISlNaTzZvRUZ0N3F5SWNpbStR?=
 =?utf-8?B?ZDBzRE5HYTV1VVc3WmpTTHgwUVVQdFlISzV6U0NPVkMvS3RuSWd4Mzl1TnRH?=
 =?utf-8?B?Z0IwczV0U2s1YXFZU3QrQXJhaTI2SjBudmJqTk44MHg0WTdjVlc3OW9yWnVZ?=
 =?utf-8?B?M1FnMnViRytkZVUwSmx1b3pCRys0eG1tdXoxTVgrYktNR090MEFyVFlwK0dW?=
 =?utf-8?B?RGMrdUdwbVpoQjAwTGhuM2Mrb1NUd2pvZk5jZlpxY1hvV0c1dTlvdnlUUnV0?=
 =?utf-8?B?aVhjT3RFNU1xTmZpbEZNUGFiTUxPdjJyVFBBS2NkWitHSDhRT2tKZHN3cHpy?=
 =?utf-8?B?Vms1a2hYSzBmeW5DTUMxY3VJSzJjckNHU0xZYmw1dGYvVnd4dEtlbmNMSjg2?=
 =?utf-8?B?TmF6eFlXMDZVUkxVam9CNGE5enRDbU1QT3JmTE9CWTIvZlNqWDV5eHI4SnVr?=
 =?utf-8?B?ekd5WFQ4Q3htSkd3R090NTlOSjJ0dGRCV3d6TlJUVEZVWWIwMVJjYTRlNSsw?=
 =?utf-8?B?azVrZElvQytPL0tZUWVhQXJZSWIxUUlqR2FwUkRKdGgzNmRtVkJyck0xdUZN?=
 =?utf-8?B?MGRxSGZKd1kvRm9wSk1sdXdoME0zODZ0MmtOZE5zT1VVZzMrZW45UjRNRitM?=
 =?utf-8?B?cE1pcjM1WDBoY3lKbkJMR0tBVS9MTjd0Rk1qZ05vSzg4elVENHFIVHRCVFUw?=
 =?utf-8?B?a3dKNmhDZlI3UnFXaSs3aDZaQjk2TERCVEF1WXJ3b21tTHA2bGQ1NnE4MVBu?=
 =?utf-8?B?clZWblVoQjNqcHVTZEhtWlVRVFFzdzVwK01PSEx6WDdTdUFNc3ZnMUdsOVFk?=
 =?utf-8?B?dExUemx4NlZBMjJJSzNSUndKbGM5YkNhbURWZFhoaFJ6T2NkSm8wVnltOEhV?=
 =?utf-8?B?VFk1YmdLQVZzQ0JBTEYrclZLbll2TklEUEQzNVJpOUJBSWs1Sk1nRE1zeG43?=
 =?utf-8?B?YlQ3dUl5MXZ2a1ZUaGhJeGs5MUh1d0RDeCtyb2d2MFc1WEJCMmducjRlZGVW?=
 =?utf-8?B?d0JYTDdUeUlSVzlyZ0lWKysrMUNneG03WktQSGRNUGVxdVZoMjc1MUlKeCtO?=
 =?utf-8?B?OHB3L3dQYk9GbExhdndaV1dtQ1dFOEYwOGdGczRSWTBOYXRKMXI3ODFSOERx?=
 =?utf-8?B?N3VhemxQVXRteXZxRktxY3dJSUNlendpaHg1QVZuVnJDZGxlaHA0N0FwbktI?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2e7bfb-dbe8-435f-e658-08dd51437277
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 00:13:48.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12jGTIYhdIfJhWtVP4LwLCkVOpb+mzMv+aL4A7YoWU9sHC16uaocZtNvSrFWRX4GK0DG3edZcuvz7nFNtmeQ7HuNqK8PdMaxXOCdxKhbBOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6154
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> When BMEC is supported the resctrl event can be configured in a number
> of ways. This depends on architecture support. rdt_get_mon_l3_config()
> modifies the struct mon_evt and calls mbm_config_rftype_init() to create
> the files that allow the configuration.
> 
> Splitting this into separate architecture and filesystem parts would
> require the struct mon_evt and mbm_config_rftype_init() to be exposed.
> 
> Instead, add resctrl_arch_is_evt_configurable(), and use this from
> resctrl_mon_resource_init() to initialise struct mon_evt and call
> mbm_config_rftype_init().
> resctrl_arch_is_evt_configurable() calls rdt_cpu_has() so it doesn't
> obviously benefit from being inlined. Putting it in core.c will allow
> rdt_cpu_has() to eventually become static.
> 

Please replace all instances of mbm_config_rftype_init() with 
resctrl_file_fflags_init().

> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v4:
>  * Moved all the __init changes to a later patch now that the exit gubbins
>    comes first.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c    | 15 +++++++++++++++
>  arch/x86/kernel/cpu/resctrl/monitor.c | 22 +++++++++++-----------
>  include/linux/resctrl.h               |  2 ++
>  3 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 7d14d80b3f94..43a9291988d3 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -831,6 +831,21 @@ bool __init rdt_cpu_has(int flag)
>  	return ret;
>  }
>  
> +bool __init resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)

I know resctrl is not consistent in this regard but I think that it would improve
resctrl quality if new additions follow guidance from Documentation/process/coding-style.rst
(see section 6.1) Function prototypes) to place storage class attribute
(__init) before return type.

> +{
> +	if (!rdt_cpu_has(X86_FEATURE_BMEC))
> +		return false;
> +
> +	switch (evt) {
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		return rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL);
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		return rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL);
> +	default:
> +		return false;
> +	}
> +}
> +
>  static __init bool get_mem_config(void)
>  {
>  	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_MBA];

Reinette


