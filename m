Return-Path: <linux-kernel+bounces-413291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D659D16ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB8928268A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3C51C173C;
	Mon, 18 Nov 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjrMVKQe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48EF198E99;
	Mon, 18 Nov 2024 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950311; cv=fail; b=FBLjURGyS8IYkIFWC/vokIdtnV5elQuEJJEPv5hJbIT4G89Z/jvdbNszyqCrZOh22CMYvvPQCGgAAk/2UhW75WJenoG1X+cdGKAneEnu8BL2Df6IQzmdOX9nNH4Xu7uEG66RVdgyU7CGLLd4JlKLtcrVnOh86erCf5QRXx3Z3xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950311; c=relaxed/simple;
	bh=wyJwQjebxGHLC1AgFT3cyqpQ+myctDUOumJ+s8AmC80=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VGdcrhU7f8UBWsrKUH8ZLVmwIzFtTDDV2RwplUiT8kB3ymL0MvsEhu8EP5YdPOzEP2ISYDJrfRY+vGIuIf0CnFvBm54N7860r8sl39HQ9eoSHEQZZRa6RB60bTe4gEGdA1uW8dtxWsoAqpjBtrMd504b6n3lN8ih0OOReQ7LhwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjrMVKQe; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731950308; x=1763486308;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wyJwQjebxGHLC1AgFT3cyqpQ+myctDUOumJ+s8AmC80=;
  b=JjrMVKQeUIHHJR2ATP2nxGWgk144riPMiGxNs2/i3wmOH3zRfKxoMoJN
   P5MVuNpAeNppWyyH+zLBjuUN5aPjVYULdJBv8GLHNYi3CbAMoOxPCyvGH
   Qe4U6xNnwrgxkRzFFF33BjK1f4zIqS/Nr3JvmwQ1/kwqihwtVGr8J7Q9n
   ngskD8OOzbLiN0k349mV089M5tAPpBtXktq2nsxQ5K4vLlGvkXLRKEuYj
   9IQEYCu/HRo8BWK4wcwbADDMIJnrJLmoBcWkyydT7QeJdZC1hGtaZPV+c
   t8Kt8BJLyyZQwJ9GJjCmLhivUkbiTHUGOGK9Gl+HNJZ8KkD6AM5NUVBnr
   w==;
X-CSE-ConnectionGUID: p33KY/SnQPm4ypPC0/SrSQ==
X-CSE-MsgGUID: TLxmwsbvS2CsH20bEAl6Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="34781578"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="34781578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 09:18:27 -0800
X-CSE-ConnectionGUID: G2ZshF+US0iXvjIm1HTbXw==
X-CSE-MsgGUID: UVXMNB0PT5aIqkW46XwxQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="89679876"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 09:18:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 09:18:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 09:18:27 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 09:18:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C59nueNxm4xS4tOgaPwM5nbCzWPhtJRCLHSTom+I/GPMoFWC5AfJ0vkXTyu6n+a9V5fSvUdj+B85OHNLl8l0aeqLx7Q5dJs6RD2olMLW+0bKIyy4de+mfn0eSt/8Hx8EW2WgDnQNZcrfBYKwvMEarc1HdaCT7SdTlepQU3xZ1GUyXiM+PzQ7rLrMLmfBzu9yf/rGgvURls4oQfIX4O0SkzReoYSMq6SWLiQoV3rGX9xitFP3nI+jFamhjAdcE0Muv8yLaL4edJmj6ZEU8VcF2V6FnMl2il+b1Lg27e4rJTH5zzoDLuAT7Lh9HffNDbl+Y81A8Nhs+IOnRnnnrSvvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtW/7s5+sfuNB/W9X9ZWlYt66Dd7DXRz+xrVaEleJ80=;
 b=cHfjXq0dzw013neA7ElomwNVcojdSF6+lWwynj28MvkS6VUOAO1D0I3oCFDU3lP6CgSLdKHu+gpZOoVGofMgDB+FWd5r+LUg2VDoExLJ1Kxc3NWvOySZTkNA6mObvcTOCyqcb5fD2jdjnuNvOSXzyoXLVYW7C/yhOoWfwQkvfPiAgUFK3rO0slaRYjcGUc+d+mdLKKfiTGHcfAIiiyEC0jx46XitRbWNHxoIha4QaceYJGbu7JBXSTxV3Q7cMNKBdn9pNNl5KJYvEMEDXgwmvSP6GQkqRoYEhWqNTnBYdpSGcPVxp5YdZ78rZ1ql53kr0TbT+KxN3jiUxGWLp6ilIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB8786.namprd11.prod.outlook.com (2603:10b6:208:59b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 17:18:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 17:18:21 +0000
Message-ID: <79b8049a-b213-4d86-a021-cfd9f7389f5b@intel.com>
Date: Mon, 18 Nov 2024 09:18:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 20/26] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
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
 <4ec00fe60cd42c1f22c98c9f5c2f5d3ceb9f8d58.1730244116.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <4ec00fe60cd42c1f22c98c9f5c2f5d3ceb9f8d58.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:303:2b::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: aea57c80-c7b5-43fd-4b54-08dd07f5003b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWNiU3lRNU1VemQ2cUEzdkR6Ykkzb090eGozLzF5KzBVam10eWNuWDNETGl6?=
 =?utf-8?B?MXdPbm5UZ24zQjRlMEVTcVFHdGNiVEhIeUh0d3BhOUdndzV1YW10SmdBakIv?=
 =?utf-8?B?SDRycjJIeTBBekpiVW1Xd2xKMGRpcVU2enlpMzVHa2F4YUI4cWlWbE9sUzYv?=
 =?utf-8?B?eVhyWXZNQzJtV3pzeDdReGg1UEFoQ3oyVURDVGFMWVoyOU1WSEhzYVRvNVJ0?=
 =?utf-8?B?ekk4SVVVZ2t0cXFsb01PODI4VHAxVkdQdVJrUnhvLzNwRXBBajF5eUswekVO?=
 =?utf-8?B?cWptUGFzUkpad3k2N3IyR1dWT0hGRTBWZUVYQzZkTFoxNVhCbE14Q2lHdEtV?=
 =?utf-8?B?SlFHWVhGeE52djdNWWpKcW1nV3QrTGRac0dUMUxsbFIwbmtWbENYK0NkSWRh?=
 =?utf-8?B?dHpDTk9EeEgrL1UvbHZ4b0JJNTIwU25iL3Ztc1prYUY3NUV3aXhoVCtnNytK?=
 =?utf-8?B?eHdHVExMWWpwajJYa1UrdDlHZXVhZTg0dHJoa1lzTC9RMjBBLy9sNjF2cXBR?=
 =?utf-8?B?d0JxYU4wZDU5RHM3NWxxYnQyYzZZdFhGUllUc21Qbk1jT1VxcW1PRWozUTZ1?=
 =?utf-8?B?TzRJc1Z4OVh5WVRkRGJqT2FZWHk5eWluVWdXU0loTEsxckliQ01UcW10MDk3?=
 =?utf-8?B?NUZzZER3empRa09xQXlBQTdNSTRJM2RvVGcrc2ZiRitrTi92MHpnWjgzSE5W?=
 =?utf-8?B?UHZMbExxZU5rRGd6OWRnL1ROd29OT0N1K0N5SUR2eXE1VFoxTmJpNVIrNU93?=
 =?utf-8?B?R3pzb2EydWp6ZlhEc284ZDNZam1MSldNSTY3ZURIZDFzOW1sMXV6a1IvdzJz?=
 =?utf-8?B?c29vcGNaSzVBNmFkK3FyU1F6YjJRd1hZYzlpWVduMHhiNHdzQmJUbVJiTGkw?=
 =?utf-8?B?bVlsTXRMcjg4L1BYZjZjTjFKeTAvb3AyVW9EYTM5Rm9zVmRKVWc3OHc5Y3Fk?=
 =?utf-8?B?UWprRmVRNnkyMWpXeDZYb1MwKzBNc1pockEwYlVSZWRhVDB1T0JoMGFYQTM0?=
 =?utf-8?B?bFhSYnNLS3YwOHdqQ1pBYjhTcXBubnZzT3VvbjhhQ2ZHbnA1TGoyaHNidHpm?=
 =?utf-8?B?cnVuN3Vmam03TDh4bUNNRTdKMXRWQmE1WlJwRnd0Z3NraVd3QVpRYy82dW9L?=
 =?utf-8?B?aXJrbk5lQ1JHY0NINEdXL01hUWhaZlJhR0ZEbzhveUZIVHJIZm9YMEZWeWJ5?=
 =?utf-8?B?NXgyQzBDNEM1S3YwZ0R6UUpzaWNUV1pENlpMdWhyVk13dGdZUzVhbjRLZkE5?=
 =?utf-8?B?am9tTjZPNnNHKzBYb3orVkUrY3hETHozbEd0YmhSclBLS0dXNG1lM2JmcEtr?=
 =?utf-8?B?WTNyVjVTMFdVNkUwcGp2a0RqMjBSckZhRmNwNDZxVnpYRkYxZEJpa0dDQzY3?=
 =?utf-8?B?cm15aU03a2dma2JORnFobEJtR2RpUTRtVjZOL1ZuMGw4bC9LWWhKejM4c3FC?=
 =?utf-8?B?RlRCenF2SW0rQklTb1FsOFczWVVzT2JQcXhERmt5THBqMkVVM0E0Tm5NMFNZ?=
 =?utf-8?B?MUlkN0ZMUGRuMDF6bktBV3B5T20xTXlWNkk1L2tyZ21wejVCc3NDNHluREdo?=
 =?utf-8?B?NkJqT29EYjZBSmlmWW1LeEhVVEc3M05LcU5XWkFMTllXMTBVOUd1MFNWbkV2?=
 =?utf-8?B?dGlhbjBUaTZxS0NlZjViamZzS0d2b2dzUXo3YmJ5RkFDSTFMUHhFRTkwNFNX?=
 =?utf-8?B?UFczREZMbnZTaW1vektJdy80TnZBVEl2aTdlVUkwYVRzTTBXblJBcGpYRUEz?=
 =?utf-8?Q?eVbgRazXUWu4xD0Au3qsMM2MOYFjbA24/AD9ZRI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ZSc0Z0c3MxVzkrWW5VdmtKdWtYUVRxa2pZZVVuTEx3SWRSaWFtaldwMzgz?=
 =?utf-8?B?WnFiZjZjZmF6Mzd5SnMzT056UEVyUDlHYjhRZDRPRkIyS2V1czdFdUNtZk1V?=
 =?utf-8?B?RTYwWkszQ2RMN0JDK1pOYVdEeXJuWFVLck5Qd1NjYmhvQ1p1L1pUTFRyMDlI?=
 =?utf-8?B?ZDRyUHlOYTZJRFlMclFIbW81cWZxeGI3a3gzMXBzeSszNXhYVnQ1eTRNYXMz?=
 =?utf-8?B?OUtteHpCRFJYUFZqbHltdkJsdHdoQmVuZ1MyYnBWRFJOb3VlUE5zRlp1NFg2?=
 =?utf-8?B?cTBKN2t0ZlJldFhtb0dseVZQc2gxcEJNdUNibjZPUHkyeDlMWmw4VExEZkFy?=
 =?utf-8?B?N0NObDdCWUNzVWh6LzhIdloyN3VTWmsydkoyZTdqUEJUNXJzM25FMDdtS3E4?=
 =?utf-8?B?dXdjdmkybWlIUHBRR3NibFFWZ09veURKTVhicXcySWhGbXZOeVFZMTRBaXRx?=
 =?utf-8?B?Qm1VcWxkMzQ0QzZ1L3RVOFJUNWI3NS9QWUkzVEhtSnovUXI0YXQ0NXdBdW9s?=
 =?utf-8?B?VGZkcEFpRURoRHFNM2prTVlKandtcFIwcUhHZTBjdU5jclRRRmVNeVNOZmhS?=
 =?utf-8?B?bElsTTlNQW12R2RnV2N5a0ZrWjJnNHZ4UEl2ZHpMVE5jRVZ1UzB2UFYyY0py?=
 =?utf-8?B?K1lISmdsM2hmUklNd3RLTDUrK2hhY1UyM3B0c280Q2x4TzN2VFJGak94bE9N?=
 =?utf-8?B?MUlBNjdqUjZuN08xVDN6SGt4dzVQVzlFbnRpWm0wOUhwQytZSVFmcmhFV09j?=
 =?utf-8?B?czY2Rk1YQnJVZ1VxdXRMZjVZZFlUY256S0Y3YW5LYlF0WVBscVZCbDl2OXRP?=
 =?utf-8?B?bm9DVU9NR3dxVUlNQTIwdmhucFV0SkVSbmlaZHNJWXMzc1d1Q1kvSGJGQzJ5?=
 =?utf-8?B?akxTUUhsTGErbHUyV0xYVEZGUHZlOWNHSkVuWXo5T3NrSnFGNHllWVFYbUV4?=
 =?utf-8?B?b3NVSFlCQWhldXF3SkNydWRiOVZXRVhFSTFjU3ZaR3B0Y1FscDdGRnplbGQr?=
 =?utf-8?B?Tmk4V1R3VCtPcnBrdzdFd0VuakhNTEVXQnlIUCt4dUFjQ1pUOHd3NmcxQXNM?=
 =?utf-8?B?cE1CeGR6WDROY3Z6d2RWcG9pQ0krYlVrUnJPNUZvWThqMGJmdWFscW5Pb2I5?=
 =?utf-8?B?LzJZZFB6ZUZNa1hTNGhOZkt4Z0JEZ09nMHhLcW01aWhPUUJIRUpiZDZMVk95?=
 =?utf-8?B?bFl1azNrZGkxZURXenVBaFhTa2lFd2MyeG1mZktNNWpoN29UWU5SMkRzQnNI?=
 =?utf-8?B?cml6MHBsT0FmY0E5dXJUbmNycmRtb1hSN1AzbjI0QnY3Tng0QnhSYlFVUHZx?=
 =?utf-8?B?RWdscVdWNllDWnVzcU53eDRzK2haUjZ2YTZYTFB4Wkovdi9QV0tKRnlPVWJI?=
 =?utf-8?B?a0pQUDNtMWdhanZWT3l3Z20rZG9meXYxaXRxRElWM3pHQnhWc1NwVFRQbEtU?=
 =?utf-8?B?MU44Um9tY3cvWnpLMDBIMS8rcmZPZTR6QlR4L1JMcG1FWmd1bW1Kb1pLd1RE?=
 =?utf-8?B?VXdTSkIvUlEzQ2RtVURJczNkME9WNHlaeCtUbE1vRVU1dksvNDkyODRtT1Nx?=
 =?utf-8?B?emU5MDJVcHpjcCtZQmlmdWhaL1hRMzZZYjJNalAzVHlZcnZQOTBQT2JlWWRZ?=
 =?utf-8?B?ZlJYZ0Q1TmZyc2x6NXN5R1ZiQVY1UVdncWRndW9nM0F4KzBpWEpKOU9reGV0?=
 =?utf-8?B?YU9TSmJUNEF6N2hzcVNFek1oMEk2cXZ2R3BSZUNKSUh1S3dZZTVRbHBFVERU?=
 =?utf-8?B?bkNmNFFRYjh3WUFlNlpWSDFjdUhHSEZiZ3hMclkwTnkxMGZyNUo2Nzl2MWl1?=
 =?utf-8?B?UmpmWWRCRG9IMGxoR2xROFFTaE5vUWxuV21RTlZaMW5Ua2wrZHJSL2ZQZFg4?=
 =?utf-8?B?MUxGU0JMK1ljMUJsbFc5VWp6SDdXSU5mN0lmMEkrSFczU3d4dStRbWZ1MGl0?=
 =?utf-8?B?YlEzRnY3cDJEeURXLzlvaTNSa0RweUNwU2lZYnBoSzdocUFlWlY0UzdOZWlH?=
 =?utf-8?B?R2xzZUFEVmpyb0g4ZDlDNG4xRzV1Qi9RSnlKSUxtOTJZWUlGSDFtWTJTVDhj?=
 =?utf-8?B?Z09RY2c1WUdIZTZUK28zT2pvOTl5SU9mVUJVT2RXakJwOFVTOGJleEpsM1hp?=
 =?utf-8?B?Y2M0cVRQdEoyYWc0dUVKZi9yaXc4Zm55bW1JcDBkejhqaVlSbUNlUGFqZmRu?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aea57c80-c7b5-43fd-4b54-08dd07f5003b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 17:18:21.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+79Kld6up36xD9PHuGb0X52foWs7g++GE6dHMykhAgQdY9OHokIHmMHb3WxmY+MEeDe9vSSaa+1UgCownYppfnBiWbX0DlcG8UoMp8wVmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8786
X-OriginatorOrg: intel.com

Hi Babu,

On 10/29/24 4:21 PM, Babu Moger wrote:
> Assign/unassign counters on resctrl group creation/deletion. Two counters
> are required per group, one for MBM total event and one for MBM local
> event.
> 
> There are a limited number of counters available for assignment. If these
> counters are exhausted, the kernel will display the error message: "Out of
> MBM assignable counters". However, it is not necessary to fail the
> creation of a group due to assignment failures. Users have the flexibility
> to modify the assignments at a later time.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v9: Changed rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs() to return void.
>     Updated couple of rdtgroup_unassign_cntrs() calls properly.
>     Updated function comments.
> 
> v8: Renamed rdtgroup_assign_grp to rdtgroup_assign_cntrs.
>     Renamed rdtgroup_unassign_grp to rdtgroup_unassign_cntrs.
>     Fixed the problem with unassigning the child MON groups of CTRL_MON group.
> 
> v7: Reworded the commit message.
>     Removed the reference of ABMC with mbm_cntr_assign.
>     Renamed the function rdtgroup_assign_cntrs to rdtgroup_assign_grp.
> 
> v6: Removed the redundant comments on all the calls of
>     rdtgroup_assign_cntrs. Updated the commit message.
>     Dropped printing error message on every call of rdtgroup_assign_cntrs.
> 
> v5: Removed the code to enable/disable ABMC during the mount.
>     That will be another patch.
>     Added arch callers to get the arch specific data.
>     Renamed fuctions to match the other abmc function.
>     Added code comments for assignment failures.
> 
> v4: Few name changes based on the upstream discussion.
>     Commit message update.
> 
> v3: This is a new patch. Patch addresses the upstream comment to enable
>     ABMC feature by default if the feature is available.
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 +++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index b0cce3dfd062..a8d21b0b2054 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2932,6 +2932,46 @@ static void schemata_list_destroy(void)
>  	}
>  }
>  
> +/*
> + * Called when a new group is created. If "mbm_cntr_assign" mode is enabled,
> + * counters are automatically assigned. Each group can accommodate two counters:
> + * one for the total event and one for the local event. Assignments may fail
> + * due to the limited number of counters. However, it is not necessary to fail
> + * the group creation and thus no failure is returned. Users have the option
> + * to modify the counter assignments after the group has been created.
> + */
> +static void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
> +		return;
> +
> +	if (is_mbm_total_enabled())
> +		rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	if (is_mbm_local_enabled())
> +		rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
> +}
> +
> +/*
> + * Called when a group is deleted. Counters are unassigned if it was in
> + * assigned state.
> + */
> +static void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
> +		return;
> +
> +	if (is_mbm_total_enabled())
> +		rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	if (is_mbm_local_enabled())
> +		rdtgroup_unassign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
> +}
> +
>  static int rdt_get_tree(struct fs_context *fc)
>  {
>  	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> @@ -2991,6 +3031,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  		if (ret < 0)
>  			goto out_mongrp;
>  		rdtgroup_default.mon.mon_data_kn = kn_mondata;
> +
> +		rdtgroup_assign_cntrs(&rdtgroup_default);

I think counters should be assigned *before* the files exposing them
are added to resctrl.

>  	}
>  
>  	ret = rdt_pseudo_lock_init();
> @@ -3021,8 +3063,10 @@ static int rdt_get_tree(struct fs_context *fc)
>  out_psl:
>  	rdt_pseudo_lock_release();
>  out_mondata:
> -	if (resctrl_arch_mon_capable())
> +	if (resctrl_arch_mon_capable()) {
> +		rdtgroup_unassign_cntrs(&rdtgroup_default);
>  		kernfs_remove(kn_mondata);

... and here remove the files before taking away the data exposed by them.

> +	}
>  out_mongrp:
>  	if (resctrl_arch_mon_capable())
>  		kernfs_remove(kn_mongrp);
> @@ -3201,6 +3245,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
>  
>  	head = &rdtgrp->mon.crdtgrp_list;
>  	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
> +		rdtgroup_unassign_cntrs(sentry);
>  		free_rmid(sentry->closid, sentry->mon.rmid);
>  		list_del(&sentry->mon.crdtgrp_list);
>  
> @@ -3241,6 +3286,8 @@ static void rmdir_all_sub(void)
>  		cpumask_or(&rdtgroup_default.cpu_mask,
>  			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
>  
> +		rdtgroup_unassign_cntrs(rdtgrp);
> +
>  		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  
>  		kernfs_remove(rdtgrp->kn);
> @@ -3272,6 +3319,7 @@ static void rdt_kill_sb(struct super_block *sb)
>  	for_each_alloc_capable_rdt_resource(r)
>  		reset_all_ctrls(r);
>  	rmdir_all_sub();
> +	rdtgroup_unassign_cntrs(&rdtgroup_default);
>  	rdt_pseudo_lock_release();
>  	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>  	schemata_list_destroy();
> @@ -3280,6 +3328,7 @@ static void rdt_kill_sb(struct super_block *sb)
>  		resctrl_arch_disable_alloc();
>  	if (resctrl_arch_mon_capable())
>  		resctrl_arch_disable_mon();
> +
>  	resctrl_mounted = false;
>  	kernfs_kill_sb(sb);
>  	mutex_unlock(&rdtgroup_mutex);

Unnecessary hunk.

> @@ -3871,6 +3920,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>  		goto out_unlock;
>  	}
>  
> +	rdtgroup_assign_cntrs(rdtgrp);
> +
>  	kernfs_activate(rdtgrp->kn);
>  
>  	/*
> @@ -3915,6 +3966,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>  	if (ret)
>  		goto out_closid_free;
>  
> +	rdtgroup_assign_cntrs(rdtgrp);
> +
>  	kernfs_activate(rdtgrp->kn);
>  
>  	ret = rdtgroup_init_alloc(rdtgrp);

Please compare the above two hunks with earlier "x86/resctrl: Introduce cntr_id in mongroup for assignments".
Earlier patch initializes the counters within mkdir_rdt_prepare_rmid_alloc() while the above
hunk assigns the counters after mkdir_rdt_prepare_rmid_alloc() is called. Could this fragmentation be avoided
with init done once within mkdir_rdt_prepare_rmid_alloc()?

> @@ -3940,6 +3993,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>  out_del_list:
>  	list_del(&rdtgrp->rdtgroup_list);
>  out_rmid_free:
> +	rdtgroup_unassign_cntrs(rdtgrp);
>  	mkdir_rdt_prepare_rmid_free(rdtgrp);
>  out_closid_free:
>  	closid_free(closid);
> @@ -4010,6 +4064,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  	update_closid_rmid(tmpmask, NULL);
>  
>  	rdtgrp->flags = RDT_DELETED;
> +
> +	rdtgroup_unassign_cntrs(rdtgrp);
> +
>  	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  
>  	/*
> @@ -4056,6 +4113,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>  	update_closid_rmid(tmpmask, NULL);
>  
> +	rdtgroup_unassign_cntrs(rdtgrp);
> +
>  	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  	closid_free(rdtgrp->closid);
>  

There is a potential problem here. rdtgroup_unassign_cntrs() attempts to remove counter from 
all domains associated with the resource group. This may fail in any of the domains that results
in the counter not being marked as free in the global map and not reset the counter in the
resource group ... but the resource group is removed right after calling rdtgroup_unassign_cntrs().
In this scenario there is thus a counter that is considered to be in use but not assigned to any
resource group.

From what I can tell there is a difference here between default resource group and the others:
on remount of resctrl the default resource group will maintain knowledge of the counter that could
not be unassigned. This means that unmount/remount of resctrl does not provide a real "clean slate"
when it comes to counter assignment. Is this intended?

Reinette


