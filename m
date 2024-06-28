Return-Path: <linux-kernel+bounces-234230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF9091C414
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A2CB21206
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C749A1C8FB5;
	Fri, 28 Jun 2024 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BppCZ+Hm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2AD2E5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593189; cv=fail; b=kmJE1SOtT3jPwhKcQLLWHgYVXNKbjPSkliWOYKa3xZE/IgzZkuG+BSVw66dw1/J1L7r5js8dzXV4+cJ8dzms7sKnzFu8zgNkPGulAG7P556iz9EX9FGnaf0vd/WCeSARCXzPWeiAdlsbSiDp3eHN7hAmqlP9/XwA1C6veRnXU9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593189; c=relaxed/simple;
	bh=Y+mOlK3WBeQ51Z2M9Azr8+JXPDbIIcERHvrI3MGLxbU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q/AZh8Ux7W6PgT4iHybIhaJUjB7eYgYTveHApKJWzX368VaM1LYWYSh9adJ39iqB8e1U170katoWATHCuocXwTZ2Ebk8tIHPUKS17VMiqaKf80jAwq3ZspYclDmaFgGCDi9X5unXa7tK5hGcmz9xWPrhTcfjrW4y8mSAn7fHilA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BppCZ+Hm; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719593188; x=1751129188;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y+mOlK3WBeQ51Z2M9Azr8+JXPDbIIcERHvrI3MGLxbU=;
  b=BppCZ+HmlV3t7mbcukN9/n3fZhE5+vGnVeiv+c/TF6DpbF8juOhUPKoe
   j9PhEnfUkJNXEfP2BwaWp1Q8Yz8v/Fp7yId5qvcj9eSe3bz5PhDaCjmHi
   VBbblq5sgIGWZudkbqIezMqbLys5O3ZbUx43Mm+TC5GbXPZIeooE4+a+o
   Fe/U8/zmeRduAfDld2GGyTHQRinU6eS6TacO+2Kpz++q3Efar8gnriFro
   6Uhz0bipfwDjSBz1DgUpe0vpMI75yVBl623p8+mYNCd2Z/vwVbbvxyojO
   Dmg6z8YrNXvGn4HpyY4S8PFUOuh7p+oVyM9GMTPaK/tNk14+gH1pEWJPF
   g==;
X-CSE-ConnectionGUID: HeeigCnlS+OWLQ7EpFaweA==
X-CSE-MsgGUID: mKzvRDl/R3CO2pItTCq2UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="27918028"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="27918028"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:46:05 -0700
X-CSE-ConnectionGUID: wEU5wo1iQdqNEg5iWzoMwQ==
X-CSE-MsgGUID: 7nkHRY0QSmK2JMkrBYPEUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="75987144"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 09:46:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:46:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 09:46:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 09:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6W9lm9Cx+2motbMKuL6exvMuZLL28cale99TSL0cmz3vkqbuhcnrU1XTLuWHJuWr5AUtrd9GovDYkZG9kwQRx4D5ZKdsNkOYamM0363nddKwsOklb2T0BfyfyJWU20uD0Js9+P3Q3xGEX0y0kifFkncqxVJMtEps2H/bXmNYwCqPXJp/rV0YRdVzGCERh7K5giuH/xHT+RQv6k8/pLhqNS+uKPnayYGn6iYnxTxw10yzh1tQmP6rbXO45AcWs8FNWGH4l1H2TAnxukC++AXAvIS0vqvkVQ45yackP+4NV8ioCa411IThySE2Qk2fmAK8s8pGGs9j/zE/M68MGkwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvSFF87uHYVvxdFJEQ4jkfSft0f2lmYrkZxG62iqTaE=;
 b=DOdC9XT8HGm6n3kIIYbBHI6v6JhjkjNdcq/L3wBIjJswNUIL7Pgfp3NkMneszhu9zvaxNl0eHMWaMXidxdOeUetJPQUjo+Grn7lGAKTgRHEFgwOLUiq7Vn623+27ucACZzNTpLMNWnrnCJ6uB5gQqdxNcnIMoZppA2znGvJDLBWv50ZcgK+CA89jXJ8jnCHxoGg3thKOXlHrQ4u/M94lh0GVbOdTEIJsKhqgy2VujPiHqL77hMM1kgNw1rFlwiC+JJ3sfTlJpWRZ1/orGw7vunc9LjeBVmXh+oc0chLZwLNJeql6PG9QZx5czmbZHG/nhxHhprGGvynTbwVZAUguYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB6173.namprd11.prod.outlook.com (2603:10b6:8:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 16:45:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 16:45:58 +0000
Message-ID: <0b51606b-2799-4d31-815d-d5f6f5f35047@intel.com>
Date: Fri, 28 Jun 2024 09:45:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/38] x86/resctrl: Move resctrl types to a separate
 header
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-14-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240614150033.10454-14-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1b3bd2-415e-422c-02cc-08dc9791c980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW41YkxmOVJDNHc1TzJNZzFseHE5VVhXd2J5YTNGRDNzWWFKMDBlUC9kOTB0?=
 =?utf-8?B?MXdQdVJDM2NCTk4vRGtXYkxqMWFYd0ZETjZyTEpOSnBNejhCRmlvZ3lhaGFn?=
 =?utf-8?B?bGE5ckJ6TU80U3hENjFWelNIM3FaQmtlYjN6WnRZNCtYMVZWbExYWmkrUmJ6?=
 =?utf-8?B?RXhGRmZMT0pMbmJsVE9YLzFOVVlXUERiaFl0WVdMYlNoUzJmWXVPL0ZVbFRJ?=
 =?utf-8?B?OGRFN1RLaTZYVnorTVF5VHVPVU1WQ2JzQXZlQk4yZkRkTmVDaFk1K25sdVpW?=
 =?utf-8?B?RzVWZ1o0YU1BSmVvdExlRTc1MTBETFo3bHM3TzNMUjdlN2d4UnNvdUdTSnYr?=
 =?utf-8?B?VFBvOUt3cWZ3ZWpKUThjQWw1UTE5OTVReEhwZjZLK214cnlhMDBXRldQOGlz?=
 =?utf-8?B?bjVWcEVwMmtTWUo2QlcxdGtuT1VoQjRlanNjM0gyWVVVSG9tMm1YaDlkbGlp?=
 =?utf-8?B?RUpwV3JES0k5WEtHSkdEeGVYeE1HTSszZ3NzejlzTDNUU3RaWTJZRExoa2g4?=
 =?utf-8?B?OWZvZEpjVXlxNG90dXNPcktyUWpIV2cyYy9TSDFBQitHODI0ZXNrTWZvVDJD?=
 =?utf-8?B?cnRmSEVGVk9ZQWZPR0RMWU0wSVBRMm9SRkJacUtFZnRockJIM2pkeUdPMU5u?=
 =?utf-8?B?MVIxNkJPckFydGM4Yk5zU2xackpYNDRjbEw2SGtvSTIzNzBJN3RBNERSeGM5?=
 =?utf-8?B?OGlMaFB1Vk13N1Y1WTNpZU4xOE00UElFak4waGpmRjdOa0ZwVUYxbEZhdUl1?=
 =?utf-8?B?VUVWbXpvZmM5Z2ZJS1BFVmh6WVVpWFk4QnhJZVVnV3RpcE5MNW9heFgvMmU4?=
 =?utf-8?B?VmpBcys3NkdKNXkvaXVhNzFzMmRqQjh6TU9sSlZlS0J4TWNvd3FVd2g2WTly?=
 =?utf-8?B?OEhrSktDMzBaRHJUajNmMlJhVmUvQmVtelVmRjA1cFFvSGtZb0JPakptN2tO?=
 =?utf-8?B?V2lGQnJGVS9yWDlhUW1mUUxmaUJLc0R5OC84UnRIR3BGY1NoSkMzUVlFVi9a?=
 =?utf-8?B?VERFWG1lMHZqaVV4ejhIZGIyMDZEd1RIWm5HeWpjODFHQ1AwQkdkdUJuYkdm?=
 =?utf-8?B?eGl5ZWUvb1hmUkpLS3J0cWQ0UmZvRitPaVNEQUEyaEVVb3cyUzhrYlA0NUV5?=
 =?utf-8?B?OTllZnl1Y2w1RHFWekV2TFhPeUdBV083eXdHc3hLMGkrb25VcEp6Z3o1TjZy?=
 =?utf-8?B?N2h5S29vc1lvRDZHWE15cHBFdWpjZFRUcktHRjRsdDZBVEhCSktLcGtVU2N5?=
 =?utf-8?B?Y2J0STN3VmQwZm9vdWU5cnBZRmpoQWNqbThRMlZyNXZmemlkcWtsTDFWQWUr?=
 =?utf-8?B?Sm5WSWZ2U1J0VlNrYWIreGRZd0lvZm5PRCszVnBqd21CTC9TZmRHclRvUGJs?=
 =?utf-8?B?ZU0yaWJQMWk3azlFZk9lRWVvQTRpWDdTdDhtOHFvZ2tGZEEzb2Q5QlpiL1hK?=
 =?utf-8?B?SlFYamVybEN2NzZDR1FkanNMZzc5VG00TVRnMUI3VE5LdWIwbmQ0TU9oUVVa?=
 =?utf-8?B?a1JIc0U0LzBuRWZNa015TkRPWHZGaE9yZEhtdG9YV0hTOWg1S2xqVllWTGhJ?=
 =?utf-8?B?OXNiUzZJN3NNanU0VmRkUldyMFppU21GeVM4Umc1YllrTXVSNGtCclkrSXJO?=
 =?utf-8?B?Zm4yOUhTUlovTGtWNWQ5djJmOS8zVlljaFRwbDQyTWpjU1Y3M2hQVjRmenFo?=
 =?utf-8?B?ZjdKNm9hVFJ0N3VRM2dSNDhqUUZsWHFGMHF3V3JTY0ZkYnhyTUJIQ251ZHh2?=
 =?utf-8?B?SlJRb0JZOVZzMmZlSTRWeVhGWkxZMGdiS25pWWhqclRiZ0FQcitQRTk4bGtK?=
 =?utf-8?B?dTFIMjVpNDl4TmRSTndrZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmxEL3gxZTBJUFVITm1lc01CWEx3M0F0cUl5ZlJJMUhwTW02eU5Rb0RsVkxh?=
 =?utf-8?B?QkNxa2ZoQlFRNUN0VnJjWlRNUTR5SEtxMmlxbFdIRHVDbFJsWlVPV3JQNHNN?=
 =?utf-8?B?L2pGZkFoT2JJdGViemVjcDZ1bFhjR3dhRnoxdmwvMFRqcFY0c1BRSlhXZ0pG?=
 =?utf-8?B?U2ZEWmFMbzdDM0VQa3JzWldWQ2hEUWYzNS9MZGo2dE5Gb0loZ0xsRlAwSTJu?=
 =?utf-8?B?Q1dWR0NkY2tYQUthUjQ1Rm9GcWo3R0s5VTNUU1lpcCtwTzVnRUIya1NxTXdh?=
 =?utf-8?B?SmRQOGc2UlNIdy9OYmpHcXcvcGZpUGliNmY0ZHF6ZitnYjlCbWFHUWFKT0M4?=
 =?utf-8?B?cG81Q1pVMG9LZ2NzWTVibkFtUk5YWEpBZ0J2SHA2MWU5U0JOd2Nla2ZReWxz?=
 =?utf-8?B?a0dOQUtUaEg0WGpzZ2JNdE91N25pbmxZZnNVYm9ZTnZ5bDB2TnUyc2NWaENv?=
 =?utf-8?B?SEd1dnVQSkt5SFhJRE96K2dDdjlDeXlBR3lxT1I2cW8rdkpaSHBaOU8xWnFH?=
 =?utf-8?B?Z2ZZL08yNmVGckM5QzRHbGVtS2hNZFdRVlZXWkhtNUpJZStjSldrbzk1Y1E1?=
 =?utf-8?B?KzVnWDgrY2hvUncrLzVrWU1rYVA1UmtucVdoVEhtajI5cnVnYk9YZzA1ZWtu?=
 =?utf-8?B?c2ovOVdNa1JLT2VXaHd3VnNoUVlnVEdwOXhPQUJhV0JWWkg4MmFhbnJ0eEVI?=
 =?utf-8?B?NjBNVlFSck1PMmNwQzB0VVBVZ0trWlNLQ0k0ZGtzQzNBbFN6V29VanFob0Fl?=
 =?utf-8?B?RGJFNElQQUU1VmQ0THJUeWoraituVkYzS1pvb2ozUmNzbnhjNlhUUXllZnRo?=
 =?utf-8?B?UHYvSTRtb0pRdUtzTXhtKzdhNDBKa3kzcEFlcW1qUEpBTHRVNGpWZnFFVDRq?=
 =?utf-8?B?azlQcGIxek9JaFQxajlmWUNNVjF4eExNSHVPRmY2RmlXb05wdnlGbmxsZnN0?=
 =?utf-8?B?YkNnN0toZ0VpV2dHMVo0elFVbFNJWWQ5MCtaVnNtTXNzeVBYWWdXeHlYdUM5?=
 =?utf-8?B?N0t5OGNuVHh5WmRGZC8ybjFTNjV5YVpqc01LdGxURmlHY1lCK2tmK09aT1k1?=
 =?utf-8?B?SExjMzJoMWpoQkgvVHBXSjR0YXY4YllIZFVwenBvVmtWb1BveERDSWQzb2dX?=
 =?utf-8?B?V0xTV1ROZlo4eGVnQjF4NWcyZjBOY2ozUWN1MGhuWEJ0cTh5S2VTT21vb3c3?=
 =?utf-8?B?RVgxdkJrYXBRZkEyY1BaMGZXZFdoM1o3VGQ1blNBOEFERkhnWm1iNExqWm1o?=
 =?utf-8?B?SEtDVGFOeUdCejZVTnQxUyt4eXRMVTZOVDBqOXNTR0tQQlRHczZ1aG1HaGZ6?=
 =?utf-8?B?aGwrMTZ6SHcranA5bmpJRlVhWEo3KzhIZUNKbEU2Y3ZDZURFRDRYZ29sYzMy?=
 =?utf-8?B?Nmh6a0Zod1JGNmlCZTVrNEF0WjZLcFF1QTRMdVk4RjhUMUxQSldPZytxSEpx?=
 =?utf-8?B?NWhlTXpsRlBGZS8xNk5VWkFrR3pqRElkYlVyODUxcmlzUm9LZGRsVTZ2UEU2?=
 =?utf-8?B?S1VSZmNzQ254N1FRNC8reS8yOGJ3UHFVYXZPL2FmdnF4cElTd09lVFc3NGt6?=
 =?utf-8?B?bkx5ZnpTSEdpQ0RJMllENVluaGNXekhNRWZaTVRrQmxwSVRzVlBmeitGcGZB?=
 =?utf-8?B?bjArdUtmeXk5UmhrWFQxNFpPYzlkL2R0UFY5ZHZ0eXkyMmUxU3JJREJ6dTRZ?=
 =?utf-8?B?NC9Ja0UxMFNEekdXMmhDaUpFaE9Na1UxZ2E5Y1U1QTUxQ2N5a25oSkVVNURj?=
 =?utf-8?B?OUxzQXhSdWVrdEJkOXIwL0xnTzQ5NUJoZ1FFUFlwM0s0MkM3NDhJZDZQUlE4?=
 =?utf-8?B?WlVwS0RFWmgwQjNFWXpuUTVzUGhkQm52QjZIQ09GVzROT2owVVh5akJNQlNX?=
 =?utf-8?B?Y0hoVkVUbWpLOWVyOXB6RzBaQWhLc0c4ZksyTzR3REN5eG9acUJOdDVITXFP?=
 =?utf-8?B?MkNpSzYxaGJwRXloTm5Bazg0RDB0ZTIxU2diendrYjMrQ1VncjZpa0tYVTNZ?=
 =?utf-8?B?RTM0bTRhQ3dvQjlnaUwzd2ttQ0g3NUlzNVg5SncxMlY0UEJ4alNYaGkwallL?=
 =?utf-8?B?UVNvWHFXRDJDdzFGd0pmK29OSlJKdEg0UWlWbHg0ZjEwT0dodEk5cWdXT2lF?=
 =?utf-8?B?OVdVaStPVnhtZFVwM0RYeFVzQUdobmgrQ214MlZzZGhxM0VRVTM2a3Mwb2R3?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1b3bd2-415e-422c-02cc-08dc9791c980
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:45:58.7293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0v6k8AJnw9NyOYUjbdWNKXIOAKiQye/9/I/S0NLZsJNUCoDdDzLUFxyhPFroTBvV7RiA+/bF68VWYLvoJpOyWIHcUy/vxNsw2BZulM8JS8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6173
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 8:00 AM, James Morse wrote:
> When resctrl is fully factored into core and per-arch code, each arch
> will need to use some resctrl common definitions in order to define its
> own specializations and helpers.  Following conventional practice, it
> would be desirable to put the dependent arch definitions in an
> <asm/resctrl.h> header that is included by the common <linux/resctrl.h>
> header.  However, this can make it awkward to avoid a circular
> dependency between <linux/resctrl.h> and the arch header.
> 
> To avoid such dependencies, move the affected common types and
> constants into a new header that does not need to depend on
> <linux/resctrl.h> or on the arch headers.
> 
> The same logic applies to the monitor-configuration defines, move these
> too.
> 
> Some kind of enumeration for events is needed between the filesystem
> and architecture code. Take the x86 definition as its convenient for
> x86.
> 
> The definition of enum resctrl_event_id is need to allow the architecture

"is need" -> "is needed" ?

> code to define resctrl_arch_event_is_free_running(),

Cannot find resctrl_arch_event_is_free_running()

> resctrl_arch_set_cdp_enabled(), resctrl_arch_mon_ctx_alloc() and

resctrl_arch_set_cdp_enabled() should not need enum resctrl_event_id


> resctrl_arch_mon_ctx_free().
> 
> The definition of enum resctrl_res_level is needed to allow the
> architecture code to define resctrl_arch_set_cdp_enabled() and
> resctrl_arch_get_cdp_enabled().
> 
> The bits for mbm_local_bytes_config et al are ABI, and must be the same
> on all architectures. These are documented in
> Documentation/arch/x86/resctrl.rst
> 
> The maintainers entry for these headers was missed when resctrl.h was
> created. Add a wildcard entry to match both resctrl.h and
> resctrl_types.h.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Changes since v2:
>   * Added to the commit message why each of these things is necessary.
>   * Moved the enum resctrl_conf_type back to resctrl.h - this week arm's
>     CDP emulation code gets away without this...
> 
> Changes since v1:
>   * [Commit message only] Rewrite commit message to clarify the the
>     rationale for refactoring the headers in this way.
> ---
>   MAINTAINERS                            |  1 +
>   arch/x86/kernel/cpu/resctrl/internal.h | 24 ------------
>   include/linux/resctrl.h                | 21 +---------
>   include/linux/resctrl_types.h          | 54 ++++++++++++++++++++++++++

Considering the motivation I also expected to see a change in
arch/x86/include/asm/resctrl.h that adds the #include of the new file.

Reinette

