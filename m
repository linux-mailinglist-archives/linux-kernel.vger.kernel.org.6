Return-Path: <linux-kernel+bounces-186925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012968CCAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D7B2821A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC2A12B151;
	Thu, 23 May 2024 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3SnqtIP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28E31E871
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716432604; cv=fail; b=fUwSO+Wf3ETWrqakg/s6sV9YxELzxx6snlnISSdM1Vqv0f4t6yLxgnwlQdxO7WAH2D/+qMGDMX5lKq0thBP9z1qwgcgMGof1crZcOMaH4MFJ3qSEfezAGPMg8iAUD8SmM4UB+/l07Trq1Hi01HfDXz9MwJJlmB0wYIPkklLRcGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716432604; c=relaxed/simple;
	bh=sJYfj3SXBTtxlh9KWOwaBkeH95SVPVgcxHsRR8OnGdY=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dS4qVoPYDkqsKwYbgcxot8yKYfX0VKAx5EDGQJD7MiigmgEsYwqD6GKvKhjG0Mv2IanF2pRQXJYkcPndN1d2nusz9p9za1M2H32fsdA73GeVZOaz5PKFvbb/F2pmYkQPWw9aOYzaMmuufS5GDvIG7MPOf2mVet7VewtHZMlvWfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3SnqtIP; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716432603; x=1747968603;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sJYfj3SXBTtxlh9KWOwaBkeH95SVPVgcxHsRR8OnGdY=;
  b=M3SnqtIPX87bKIkOIYlPBWS4NB6x7ASJCeVLDApoM/+u/sUHDO1/owJ8
   ZSVHceLj542Lug+bEO9t1iNDIXQFDXqE4t1Bx98FKYeAvpo/zoWT2GEJe
   pxv+VqCJV6IJmMkOmoN3NpF6qxArFlGoB+Ybl3bDPUFc5yoGBR63aRiS0
   ZpZitRZ5ytj00fkeuX05yRd/6fLJ9xNCCUsVUx1+3RBAS4dwKv/E4sa3/
   HfSbrOvSSdMGs7iEhBmW51ZIqWhHOrN2PfUspszEFSaVt2pHYG8oF2z18
   1CxzWONJNyWXWxwqN60i2kRoDcxMhxPAD/KIZL9vpSHMnFMUvjavBXkr2
   Q==;
X-CSE-ConnectionGUID: goq1lGkYRt6mBJYxQYZ3og==
X-CSE-MsgGUID: JW25xVZVQOySYnAtpNzp3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="30223669"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="30223669"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 19:50:02 -0700
X-CSE-ConnectionGUID: nykeRg8EQn2qpuZylNo6ag==
X-CSE-MsgGUID: 0Z3BoB3QTou2UjjDWOdSGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="37899177"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 19:50:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 19:50:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 19:50:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 19:50:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 19:50:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Il+zaDJsppcpWeBk9oAFl/ea2n297k3T4vWiyKl2l+8YcHtawRCMPjpkQDEBfYyJgpjStYo3dNO13rQ+xoKsNYf+ZvL80KttPAhJxV9vMJfLqJihbl1rbzcxAXkZMKgcLElIs5bDqYXfMOCI7FgxqVutExvELT5EV2pIW6Y13bjRZMAi3KhPtJ0TySPQRnie0nQE+sjSVd//kVXUpYBMavlysEF5TjPfJo1HrP8/btk2DirE64lfRgUiA/wQ4YbXqOrvAwFi/4I8BenuuazS1y/UChm/t/Nmo7eaCleScYdbDBibDfVdyZCZCpQ52iiyVf5WI63QJdQBBAXhNFXbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqfIMg7aPxayUMQ+h6BHc6ptiNJyRyvFUusCvmRdOic=;
 b=PAyWJwSKCwJWMfAVRQQvGajGpLExeZ8tzA4FWVoUOPZ/xhsRabSy72E+4uSy2VUwXgFSnNZWO4v7OGq6v7L1KtO2fzdXGajgzrpuKTEs8MK7k0HaAne4Ply2O+y+dITI+779TrjumXkH8zAy5j3JJOEBMBIrwcuNEoVHKRSUnzBhK9nljblwcV3jSQ05ePX5nlW5593gI3ZSiZe12wTEn2iXdsggZfCKZ/e9H/I1ibX49uo7+ZQ1nJ3tNX9u2on3s1XnEOAyHsB35oaAe+wP5W/4gtqXWrx8SPe5KbtElUHFguxuhSckYSKmCO93Fctz4KaJVDg9MSIMhua1MdGSCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8186.namprd11.prod.outlook.com (2603:10b6:610:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 02:49:53 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 02:49:53 +0000
Message-ID: <1ca2c140-8ab5-46a6-a26e-6840d7ba051c@intel.com>
Date: Thu, 23 May 2024 14:49:41 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
From: "Huang, Kai" <kai.huang@intel.com>
To: <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <dave.hansen@intel.com>, <bp@alien8.de>,
	<kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>,
	<ashish.kalra@amd.com>, <chao.gao@intel.com>, <bhe@redhat.com>,
	<nik.borisov@suse.com>, <pbonzini@redhat.com>, <seanjc@google.com>
References: <cover.1713439632.git.kai.huang@intel.com>
 <327899e13c4dbbfbe8ca95cab83ba229d17fb74b.1713439632.git.kai.huang@intel.com>
Content-Language: en-US
In-Reply-To: <327899e13c4dbbfbe8ca95cab83ba229d17fb74b.1713439632.git.kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:a03:60::39) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CH3PR11MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 2483315e-a6f3-4cd9-9a0b-08dc7ad305eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0JvMGU1c1R4NVM2VnlmQjd5ampxeDMrdWx5TlY1REFXMWNuMkdsMTZKRHFU?=
 =?utf-8?B?VFExUmpqTC9BUkRYM2tmQlpUbkNDci9ZeHBIZ1NYeERBOGxWL2lyYUxwWlA2?=
 =?utf-8?B?amJTS0JXWFBqRFNlQzBFWHMwWWJCay9NQUlhclg4czhZVldDZC9UdFlFa2FW?=
 =?utf-8?B?RnBack5GZWR1NW90dldxY1A2NVpxMWRZRW80RWNkRFppS3BhZzR6Z3BSSExI?=
 =?utf-8?B?T1BNc1k3UVBEWVZBcDlHdVRHdUl1c21kNGdnUUZKZm9WTVJpSnE1cU1hNDJx?=
 =?utf-8?B?WXRoNzA4aGNleXI3enRpaXMyTUlWaWQzMW53U2JOd1dHdDhoQVRGMzllVDlx?=
 =?utf-8?B?S0NVRWxqQ1dJZjE3SUdxc0lCQUVQd1Blb21BL1dMdnhUM290ZWo5dmNyZFVu?=
 =?utf-8?B?QTY1N2kwY3U2dUp5VkQ1dFlnM3ZMNjE5N1JBbWVxaHk3OFhZZVp0Nm9Ba2Vh?=
 =?utf-8?B?K1FxM09pbm5EcU5sQzlCdFBXRzlhTVEvS1lhVjlydnpKMVp3NWJhQlB6Znlv?=
 =?utf-8?B?cHJkZFJiUU5HMkhDaGpLN2pzQ1BRS2RVMTlhQzdURjRZQS9yTXFyZ0hTUnRV?=
 =?utf-8?B?R3RSVXdBUkpOYlRPUk91ZGVLL21UWndXaFZkVDNUamdUWWQ5Wk1hYkJaSk5W?=
 =?utf-8?B?SUlGTys2d2c3N3RPQTJ5dWRnZ3NHeitYRkVJR3ptUmh6d3NyMXRRdHpTb25K?=
 =?utf-8?B?NmgweG5tZFZJRzVkRnJLMjR6NnBad3c2dXZDeTBaQ2VCNDZ2cHNiWGRwdWVQ?=
 =?utf-8?B?MVlFVGFVdE83MEZUUi81NmNjdVNBM0EvSkVyQVRRQ2x5SjBPOFRGL05QRVNU?=
 =?utf-8?B?S0RQN1N2ME1HR1BPRnRnTmFoMWtTQ25nVjIvSVBOM2N3a1FLTW12YVJvTmZR?=
 =?utf-8?B?VFRINmNYNHRXTUdmYmNubzI2V0NveTVzQjNQb0YyM0lzMnMwclFPT2pLSzNn?=
 =?utf-8?B?RDRmYm9SdmlrazI0bklyVGdjMVBnK3lpNVF2RnQ3aC9tS3lvYlFMTFVUYWxa?=
 =?utf-8?B?TVRobVVxNmxTRlRVbHhabWdvcFVQeThSRXIvVWNudGpETFpnaCtudldlMjZl?=
 =?utf-8?B?NjhITndqNDRhMVk4Tm91SWU0Y0M0aFY4VEZFOUo2ZG43SXNBRXEraTZZNldr?=
 =?utf-8?B?ZmwvcWxCMysyNkxSSHRKYnJYOHI1K1dsbC81aFR0Z0JKbkxRM0pST3JXRzhp?=
 =?utf-8?B?elIyR1l6OTNXQTVzT2IybnhRTmV4ZENCeklQZ1JreEFGVS9jblIvaDUxNitl?=
 =?utf-8?B?ZnNvOHpYMmc0RlRpdjR5SnJkTmdEZExFN01hUDREVlJzUWh6Z0F4cUJjdlpW?=
 =?utf-8?B?ZHpnMDl3M1pOWjhGTlVVWlVleGk4bGlpa1ZFU2FqSnRyMUxLbUg5Z2xEM1Ux?=
 =?utf-8?B?YUJ0UVcrYTJUdGhUb2tnNGFKa3lscjg0VUZMVmVWaGpJdWJ2ZkFQMlJ3OXp6?=
 =?utf-8?B?SkZtaERpdzVob1gvUFo5aVRNbTh2NmRGL2RLNy9QVDFPOURYblEvQkNkckU4?=
 =?utf-8?B?aE5uZk9pTmFvNzhhc252UDRKQnhXNmNiNXh4Tyt2NDM1cG5DWWZDdG1qcnpq?=
 =?utf-8?B?ZGVRdU82RDBPNGZLUERmZlJGeDhqdmZaUmlZQ2IyQkM1d1BkUk9FeU9tWjdp?=
 =?utf-8?B?QnVOQ1BXMklWK0xrSHRYRkFzaStpdCtud2RYUzd0TFZQeVEwaGtrK3JSQ3NH?=
 =?utf-8?B?bk5VZmNiRHZ6SFc0TXE0eElVWHF0TmxYd1lPVUlKMk8xK2I0NDRLQk5BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm13NTlleDN3QTJGRnFsbmN0NzlHT21reFhPVGhYTElrdktvNUVxMWtWdVlq?=
 =?utf-8?B?VnA3alUwaXJlVW1xRHd5eXZ6bnI0UWkwZzUyUitBYXk1SHRnQVJYRk15M3Jp?=
 =?utf-8?B?VmxJdVdjUmxzTFJ1dy9TdWZ1TTk4eGpOQ1c1MVdwTTVlcnhUZmFiMXJmNWNT?=
 =?utf-8?B?OXZoZ042cHBjYnc3NklSbjVRYjJwbDlEd0x1Y1JpMEdkdXJTNVhIMTBZdEdI?=
 =?utf-8?B?MVVaa3Q1WDdmbnFyVExRTVZvS1ZhQlc5SC9PV1ViRHlVS3B4ZTRWOE8xZlF3?=
 =?utf-8?B?UWRLZG4xODRSR3l0RmQxd3kxcXBsV3BUNXBJZ3g3WUh6RndkM2NsSDM2aVhP?=
 =?utf-8?B?cmt4U0JvVTI4OUc1d3dNWlRmbG9TdUhFMnBXOUFLam1RSHZUQ0FxUnVlUVlS?=
 =?utf-8?B?VEhjNnFvajVQdEFRc1VITEhZVEdLc2FPclJXL0dWeXhlN3F3Y0xDalUxOEFy?=
 =?utf-8?B?QkFsdU05UGNtMjBvY1FyN1BLNkNzT2JqaFpYQTJZbG1EN0N3dk1lYWg2QkFr?=
 =?utf-8?B?NDNlNlYzcWZsWEdWRE8wM3FCNFFpOUk4NzFxb3FlRm9KTWI3YWlRRloramN4?=
 =?utf-8?B?eXlBZnlPcXZNY3lCV1p2dlE4MHhlMW1sZmRzN3AzT3N0Y2tTdzdHMGpobGFP?=
 =?utf-8?B?RTlJeHR1NStOQlpZKzQwazBXT1dyTTZ4SkdKSDJZWXVxRm5aV09hNjArZ3cz?=
 =?utf-8?B?SVY3cWVGTDhLbWd4d2prSXNYV1VUZFBJYy9uYnRmV05neFJMZmxnRGNoUDZr?=
 =?utf-8?B?RU1lYkxtbjlsV3RrVUhqN1VSejJIcjF2ZTl5aUhDdHl1YUFQdnVUZHhCaUJ0?=
 =?utf-8?B?WUo2MTV6eVhLd0VmOHdjVWtVZ3d2eStvZ0h6YTJPdWtDdmpkT3ovZjJQZXVB?=
 =?utf-8?B?QW12cGJSSzlONkk4ZnRBcWI0REwyclFxc0E0eW9oSVJDZFNVZUYvY2UxZDly?=
 =?utf-8?B?ZjhXdUkyL3paWm1UV3NqR1hEYy92UDZMMzIxUVMrUTVVa2RybURHdkhZVVJV?=
 =?utf-8?B?R1BxS3RRV3JRMksxVHVDSVF6RmJyNktsbnBvNmpLYWt3QzFLcVpMZTZsR2RX?=
 =?utf-8?B?ZXVyYnpJWllGVE5lN05xMUJhekxpOTRvYWxrQ2ZTd2tqUlM5eDkyT245VUdt?=
 =?utf-8?B?T0h2Q2NxelcxakFIUlZ5ckRJNFNvY2hHd2kwMUcrbTZieUxUUnlJWTFUQlZN?=
 =?utf-8?B?NXR1NzQza0x6d2lMU2ZkVlBMbGZPK3A5cDhtVWczSWV1RlZFaG9sVnVCZjFx?=
 =?utf-8?B?WDVMV3czUndiMTZ2T21URE4rbnFXZm0vMDI4L2Y1RTMxbzJMampXMXZCa1ZC?=
 =?utf-8?B?dGExYWdsd3V4cHpSZDlaK1lIVXlxVEVsbzJmZE4ydkd1Qzg5d1FUcTAwU2pL?=
 =?utf-8?B?VHlKUWp3bE1sWXhRMWxiOVBBeFNzaEhQNzRseHFvYm5Lc1M1cVNxeTNLS3li?=
 =?utf-8?B?ejBkTmlmRDhqSGIxSW9VUWJueDd0aDlzRkRVbi9qazQ5NTI3SDIxV2g5SGJU?=
 =?utf-8?B?L3ZNQnAwbkFZaFVkdDBEYXI2eGhWOXh3MzZucG9walhlMXVSQ09pL2N1cTlt?=
 =?utf-8?B?N2hwV01RNUtHM3JjNndlRGNMWjdmREpZbDRaN1JNOEdqdzl3OVpCN2ZqeSti?=
 =?utf-8?B?VmllUCtHYWoyYVFmMHkrVkh3U28wcFU3S1JrT2NLRVNsRGtzS1dtT2JJcktn?=
 =?utf-8?B?RTNGOFpOOWljRURUOEJGbzlOV1Bkc2t1Y3dlb3ZXQVlvZDlSRkJuV3g2TG9Z?=
 =?utf-8?B?cXBqN1NpZ3ZQZUhpWEZIMlo3S3ovVkthMGMzMTFsTVBOODVhWHhJUXNIWVRY?=
 =?utf-8?B?RHR2czNROWRRTnN2M3VyZms3TlNPY1Vvd1NmR2tzM3Z1OXBrS0xHL2xNbkx1?=
 =?utf-8?B?NFJ0OW55bWRYUXoyTk45WDRyaTRnYmtPYnBTRkFzZ1Y3a0xzU0w5RWNGL05I?=
 =?utf-8?B?QkgveGZML2xXQ1dKcU8wbk12OC82UFhDbTFhYS9kMDBzK0MvaElLOEJub2Jz?=
 =?utf-8?B?dzBKY2g2dUI2am1EcDdramRLUFZvTE45bnptTk1mNjQyRXpEVnRHd3ZPNDNV?=
 =?utf-8?B?LzV1NDhPS1RFalprcU5VS2xaUzZOTk5DOUZRcHNVY2p6bFN5eVBYVHhnb0dt?=
 =?utf-8?Q?g3j+y6SDfb9mIb004xHHDxsCa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2483315e-a6f3-4cd9-9a0b-08dc7ad305eb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 02:49:53.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quK1eRjithx4SfGsWnlmMRRI7TSCJcmWg//eaHdWSKJxXA+K87KBWkqqFh3GWhUC6pliVKPZfwADxi9ndAosxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8186
X-OriginatorOrg: intel.com



On 18/04/2024 11:48 pm, Kai Huang wrote:
> TL;DR:
> 
> Change to do unconditional WBINVD in stop_this_cpu() for bare metal
> to cover kexec support for both AMD SME and Intel TDX, despite there
> _was_ some issue preventing from doing so but now has it got fixed.
> 
> Long version:
> 
> Both AMD SME and Intel TDX can leave caches in an incoherent state due
> to memory encryption, which can lead to silent memory corruption during
> kexec.  To address this issue, it is necessary to flush the caches
> before jumping to the second kernel.
> 
> Currently, the kernel only performs WBINVD in stop_this_cpu() when SME
> is supported by hardware.  To support TDX, instead of adding one more
> vendor-specific check, it is proposed to perform unconditional WBINVD.
> Kexec() is a slow path, and the additional WBINVD is acceptable for the
> sake of simplicity and maintainability.
> 

Hi Tom,

May I ask how does SME work with kdump in crash_kexec().  Looking at the 
code, AFAICT the crash_kexec() path doesn't use stop_this_cpu() to stop 
all other cpus.  Instead, kdump_nmi_shootdown_cpus() is called to send 
NMI to remote cpus and crash_nmi_callback() is invoked to stop them.

But the crash_nmi_callback() doesn't invoke WBINVD for SME AFAICT.  It 
does call the kdump_nmi_callback() callback where a WBINVD is performed 
for the SNP host:

void kdump_sev_callback(void)
{
         /*
          * Do wbinvd() on remote CPUs when SNP is enabled in order to
          * safely do SNP_SHUTDOWN on the local CPU.
          */
         if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
                 wbinvd();
}

So if I read correctly, what's the reason the WBINVD is skipped for SME 
in case of crash_kexec()?

