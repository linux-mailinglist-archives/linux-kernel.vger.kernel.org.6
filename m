Return-Path: <linux-kernel+bounces-223619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715009115A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272632826E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA8714387C;
	Thu, 20 Jun 2024 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZWsAaVR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD9823DC;
	Thu, 20 Jun 2024 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922064; cv=fail; b=ZbBcdOGMWACJu8MjPy+H61B3jcpf95ETm1UGCgN/YP68sIOAycSBLyF1a+ckVfrXp4JVRXVyrXL/ut6VHp4OaaUcTD4Of+jRzHkCOsGzN+fGrbZLQNWB3ysLxRI/lfnmXXFCkEHYtaLuHrGg9ibaVzjuFZlVm92qfr6TNdqUa94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922064; c=relaxed/simple;
	bh=DurVMzJ/edGwNUwPxHUgqmJ/YVgmhIFIDZ5VIYJ+ccc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=She56f4Nv8Fru4Cf7KEixYanWlVaiJcR6U68cHVMIFIqgM6IIkxp28Z4yAyF4qrbsCiKHbrYx6p67cHodY2V7YjsxYydYy66cW7AG3yXJsCAemNDE6AVZexP6Q4DQ7ue1v/rsoKXYLeOi/Mx0PLtE3mVRrfjgNhqaGJE68MwsdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZWsAaVR; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718922063; x=1750458063;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DurVMzJ/edGwNUwPxHUgqmJ/YVgmhIFIDZ5VIYJ+ccc=;
  b=ZZWsAaVRmt6XdcZ9SfloMu9Tyj2jT7XUUaQ/grfkP29Z8JDD2+lvmnBd
   mCjf1FCEGIvv6dEzaSRCV0QB/Udl+mw4sLjInHloy3Kg/6KEwNNztv1Ls
   8y7QqJ42Ructp96Sc/OylUBecRfeRENnbycRfElYdbZyKdVNGFrhR6NtD
   jaKp8AbfU9+KedY5UqGNa3f6HfS6Yt/L4Nhd/1gvL+4HuPGkihhiKYJZ1
   C62wEE7wf6zhutVfYQ41HseHlK7MbqdpPcJOmVTerm3PIOiWUrQ+qQl8Z
   JiXryG4rhwTalM9PoYo7xq2aIP3gJZRCaMzP3oN6kEBZFBEs1qNzvtIhM
   Q==;
X-CSE-ConnectionGUID: p13Ga27ySESi8d9Z2hP4iQ==
X-CSE-MsgGUID: GW/HFp8cQ3G7I1p3D4bFdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="26530208"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="26530208"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 15:21:02 -0700
X-CSE-ConnectionGUID: lPMnKcbRRE6QNWLKRUi4nw==
X-CSE-MsgGUID: fzEkoDAETmGmf0hSpyMU7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42495454"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 15:21:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 15:21:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 15:21:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 15:21:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcJJ7/BeZteaIGqbgpIoM33elgrkI4dWbOX38Da8WBSdhe5Ni2mdPxvP4SkbBahDt4WO/MTzmsG6xF7iIo7d5ojZjzjTwwUQfzDnjqAZyArLjSMK84FoZoQGHovzXEuI8u4JVoFgfZ9trys9ITb0ScmZxCEiIwTaZ0irlxxLblDYzyCgNecSHbyveKzHxn+AwHxxmyC+J9gY4gfu3453HRXM5XwpSHBrI/wQhVEOjmoPgjJFthgx2HMCT3CT2OO7jaGKpd6uT8OesGG7CEml2Yw2USKVv2ZrwWWMLS06ykMwOb6xoHgX5dPenWY9BQKwzgVefiEoosQTpQ2ahC7GMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IFolfnsw4JASYSsvyVUzH39rexVcqQIBYE1ONzViPI=;
 b=WY/uCIReeKhPP7B7NzJwJretoNeAHScnJW2cf/g1O0ruCOK1+E0TCMbpx9qTbIrOEPJ+FCH5G/cZIX/xB6gKfixG1yiFN4/s6HgnwrNA5UtN1LCjSwumGxISQbIJK31XosAql4bif2/Tlj1Eddcho5KJYvOyb6tlRzoids2SqZR+klCQFdJ/Vi/1buR7hZpgoI+aJiGYSzdcQ/E0tqBCtwTXKMJ8+p6edu1IwzyfdRdq7vlnT/63F9+wfUuhcWBMTDt1eLXoWmnhkRlnkDlXBhPb39SqtjAgwpz0gtwS9yR0wj1w+HTC2U2YTK6chpBhotOMvqdIyrZNrzh53WLGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB7949.namprd11.prod.outlook.com (2603:10b6:8:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 22:20:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 22:20:52 +0000
Message-ID: <5df878a3-2b47-4027-984c-88e8ac34de05@intel.com>
Date: Thu, 20 Jun 2024 15:20:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/19] x86/resctrl: Initialize ABMC counters bitmap
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <395f8ad5bba4e572cb8bcee11fa19b02cc950253.1716552602.git.babu.moger@amd.com>
 <915bebc0-03bb-453f-b468-6cd8aec08de5@intel.com>
 <62fe683f-3a4c-4280-8770-d2aaff478d33@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <62fe683f-3a4c-4280-8770-d2aaff478d33@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0366.namprd04.prod.outlook.com
 (2603:10b6:303:81::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 014a4c0c-93ca-44fa-f011-08dc91773ee5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011|7416011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tm1kd01yOWV1bm52ZFM0Q1grV0E3N0hUemFBS2dGMlUxTDVEOVpqamJDQTU0?=
 =?utf-8?B?MjZGK2dxUmMyVzcxMmtGcWlqeXQ3WHZMSEhUbEdRY2M0cksybUU1OGdYQXhG?=
 =?utf-8?B?OHFxSnQ1N2J4ODVVU0RsczlWVWZXYVB5ZWt1UzFLdmtBVUFmTWw5ZU1QR1dV?=
 =?utf-8?B?cFBNRjdraUVnQ2djNE4rWGVlNFQzS0VkWDNVTEVRREFmT1FCaVpXUVFoYksz?=
 =?utf-8?B?NVAveVNoQkh2YmtOZ1Q1eTFYVW1iNmV5bE9IZ056dkJNaHM5a2F6OWRpR1dw?=
 =?utf-8?B?N0ViTm02R3puZmtuOXdSUGpid1BoWkdzbnZIOWhpL3ZIZC9raktyL2NxZ2JX?=
 =?utf-8?B?T3Vha2pFUGg0NmVlaURnS05GVlJSY011ZUNkRWJJYUNYQnRxOEhPQWlDbk9J?=
 =?utf-8?B?MVpqWG9hNXlIOGVIaFFidk0zdHcybzV5SnZYUGQxaFZhRVlCZDZ6V3pRQWN3?=
 =?utf-8?B?YThHZ1FZR3JZSVl2dVFmN1ZScWxrR2hJMHp4bGJ2bUlZejZoZHEyaHppdC95?=
 =?utf-8?B?ZURMdklFU0VNbGYrUWhmVEcwT25OWjlaY01SR1hGUHFYSit4bStaVmtnRXFl?=
 =?utf-8?B?YWJLTExoR1J2OWNiSTRuRGZFK0JPMDFyc0RnR2w1WEplSnhmcmpjYVM3dUR2?=
 =?utf-8?B?RWFCRW1vRXBKaVpuQitMQWxvd3E0YTZiOHdRTmo1eUViSzRqSmJPbWJLOTFi?=
 =?utf-8?B?TkJyb3VzbDFHdHdUM2UzenZmUXFlRDRqT1BlQ3htUUNDNDJRQkdobk9YWXdZ?=
 =?utf-8?B?SGhNY0RvcE9GaXFmZEUxZFdTSGc1bW9VbkQ1amJLSFZzMWtZc2NNQWFmQTMr?=
 =?utf-8?B?cWlEVlFzbzlZbzh4dFZ2L2pWUEs4V081Zk0xK3FOUWZJWGpoZXlEMEdZUXh4?=
 =?utf-8?B?bC96R0dBSVVBdEtXOVNFOGQrRi9KMHJmbjdQTWV6QnNFVXRqS2l1RndMY1Y3?=
 =?utf-8?B?cUtUeXI4UVQ3TjRESDFEd2VzMjJhaUNzVVpnV2lRK0lmRVlIK3Vxc3dCekxK?=
 =?utf-8?B?NzIvMEVsaERudDVQV2JVWkhUbnZKZlZIYzlQR2R5ZlQyUnEyb3Zteko2YTlZ?=
 =?utf-8?B?NU5wU2dxdEd2YUJUYVNYM3RUZzNCMkFlZ3NJZHdWbE5YWXgrcVBpM3k4Ump2?=
 =?utf-8?B?UXV2Y1ZvNjYvMXhXNDBNN0lraVZFSlRSc3hXanBtVUE5aU1zL1NHU1A5NVFl?=
 =?utf-8?B?NzBwZXlGOFVESk9vSjQrN1dQS3VEWlBlRXNsS2xxVzJXY0xCeHpudENkdGxC?=
 =?utf-8?B?blZpUGZISFMyY0RFbGNKTGRLZmZMZnBIQXMwZU9aeVpyZ0t3clRRZ3AyRFFw?=
 =?utf-8?B?OTg4RlFFWVc4YllFQlJsQkEvbWh4QnllQ1BTMXh0MndxenoxNjNMSjh3WG5N?=
 =?utf-8?B?MjdCS0p1cEU1czhJRlNpeVlsQVVWWDl6N1J3dlp0RkFpbnhRbitWd3kxNXl6?=
 =?utf-8?B?Uk85bzhGV3V5elhFcmw4MmRaM1VWQzg2SzdxTWp6WFZkOVgzd0ZCaGtxZDJV?=
 =?utf-8?B?TnhuUHRrbTlYdzhvTGZGRkd1eHp5c0syQ0cvb3B0MU83OUhaeXlXUU9ZWUVI?=
 =?utf-8?B?SDhFK2psME9pcGFNSGhNbERaUktDT3dtWjhWSGs2R24zQUZVRGRUZk5NNjJR?=
 =?utf-8?B?VlZpZWljOEJ0N3E3SHJxdUsxUXNzc0x4b3FnclhCdnQwN2lEUlJXNGVnM3hk?=
 =?utf-8?B?cFJvRkY4NlNLSjBxYUtpZGpkYUROREhRbkxuUzZCMlh6ZWhaUFk2ZVo4Qmxx?=
 =?utf-8?Q?rSOBxCD7UKTIu83nXLrnE6gv5JUqG2mUr84cPct?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(7416011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE9BNEczTjFLVEZ6cDczclJub0txN3AyKythelQ0aW5nK2kyaW9sSDNTUDVr?=
 =?utf-8?B?RXBOWjlMVWdQbG5YYWFhUDZpWE1wSURRNUhUMEYwQXpBU3BRZ1RtQlc1RVQ4?=
 =?utf-8?B?amEvSWdaVktBVG1hNTdOS21MaUplaDhDa2xhZkdRNmNpakJtbkJ5L2IwcjFj?=
 =?utf-8?B?QmxmRzJWd1JkOEtubGJ3UDhQTk9iMlExQktsaldJTzNjMkFEZlN0akl0UkEz?=
 =?utf-8?B?d1J6ZTJmQUFpMTdDUThqSWZRWUxuZmloMnZ3MW0zazZabGpUODVWMmtOOWVF?=
 =?utf-8?B?ZlN2V2RnL3dUaG44Rlh5VUc0NGJrd04vVDFBVStMN25hc2MvUWcxSC9EcXVm?=
 =?utf-8?B?cjFZa29jRFd4aTNqYWZmR3hrTWZGWTF6Ylhzem9NeCszVVVOZUhoVnRvVndv?=
 =?utf-8?B?ZDZuL3J5aS9NV1ZaK2tFRmQxdWZtekYvQTRCSXAzT21IWXRLYy9nTmZQYmRu?=
 =?utf-8?B?a3kvNnlhUGE0dVhRRHRHTFVBTTd1LzNxdEpHVmkzZ2hjaFBKem9ZQTVYQTBG?=
 =?utf-8?B?Rmw3eEV4dlc0QkFPdEtjcmJyR243WEhITkM5VmtuUngrRXlyczZ2c29qMHRP?=
 =?utf-8?B?ckJGMXd2NEZoTE8xY1YwSGw5VXFMdzlvaGtrR24wL2FHbGdYN0NmRDhuWHpY?=
 =?utf-8?B?OVJQZnNDazlINjBBanFiQ3c1b082eHRwVXhDa1E0a0NSRG80V09QWCt6SW9G?=
 =?utf-8?B?UmpYakNETW94MnkrRXNJaEpseStxV3V5SjUwZHdiMGFGSHZrTHJDRnFWOXda?=
 =?utf-8?B?MTVIUFBZNGlKUjNBWFhicS9CK0dpb3hCTkhVK0xycExpenZGN0YxMGtlMFZt?=
 =?utf-8?B?bUxtL0prMHduNk5HYmZyWEY5N0NjeFBmUmI1MGN4eU14R29OMzQ4TVJ6SVh3?=
 =?utf-8?B?S05QeDRpVmwvQkV2ZjBYNU50UlVwZzVCcENiaWxWNy9obkxDQm56WWM1bnh3?=
 =?utf-8?B?Z2NSdVYrb3lORDBuR3JyVXZGSmlpb29CSzBDNFZpWWFma05LeE56SHljamxS?=
 =?utf-8?B?MjBOajNyUzhibFMybHI2Y3F5NDU2ajVnbm4vUjk2TnlHRUlZbzdpTlpsWVY5?=
 =?utf-8?B?b2hEckZaOCsxZm9GbHArbzlrempCcHp5ZTdsTS85TkY3MjJKVjdqdVdZaVlY?=
 =?utf-8?B?OURyQ1RnRUJNeEVMc2JYdnE0YUFTUHFBZTh0KzBuYzRPemJUaVdDRS83Vk15?=
 =?utf-8?B?RFZMSmhEcGdmSFpZR0tYVUh5dGNtNW1teFBiTHQ4VG9VdnZvQ3g1SEtTNWIy?=
 =?utf-8?B?Z3p6M1BKKzJUUzRkbmpJemwvaGQrbDRaSVY3U2NIclpoaFBDam5Ha0hWWHdv?=
 =?utf-8?B?ckhCSHFpdTk0VjArNURwbmNOZjNnVDFBdC9PVC9RN0c5TFA4KzNUS0xsT0dG?=
 =?utf-8?B?UDcyRjBTM1JkaTJhN2l0Sk8wN3Mwb0Rra3lwRFBmUW9JWmtReXJWSVJFNmdw?=
 =?utf-8?B?eE50UmZGa0hvS2hCN3FXZko1dk8xQ0NEL21mK2UyaEJ0c1FodDhiVjFxN3ky?=
 =?utf-8?B?L1FaK0hmN0c4VjZDb0RvSXNNUGFrQlV1bHNyQloxSWVLNzRpbm1HTGdSYlpy?=
 =?utf-8?B?bDhsTzNHdzk4Q1JpOG0yNWtWK2ZjZnAydVZTa2NXbHRWbGFkclVqQ3NuRk94?=
 =?utf-8?B?dGxSOTNibWVkZkhqSHZDNnlOWEIxaUdiNmxsSG9zWm9idFNTOGFWbUVqSjQ1?=
 =?utf-8?B?K2F6ejVoRUFoOEJFZmx4UTl0dnFFcmxVOE80SnMxREFDZllaVFZjMG1Ya3hW?=
 =?utf-8?B?bzd4NkRxSDVuV0NJdUhBVnM2bUdySVd1d093bXdrcjBrUDZwWG5sTG9FZHZl?=
 =?utf-8?B?cWxIZW5VRDVzVnpQcTlCMjgzRkZHQlUyNHc5R1duRUxHUjBEeHFsVEJKbWtq?=
 =?utf-8?B?bzJhMW9vM01LeVdDRW5qQUZyWWQ4QzlOdW8ySmJaeU5xUG8wVmZFdHdxZ25m?=
 =?utf-8?B?bFVCV2lEbklXTmtXWWx5Y3UwckNxZ2FDclQrc1BJWHZPRitTNTBJYkoydkM2?=
 =?utf-8?B?S01GSUpvY3VNZS9LeUIvTmtLdk1GZmlqV2Jia1ZGQW9UVEZJdkN1RWgwZzJo?=
 =?utf-8?B?T09SRDZnUW9xR0grWCtnWHA2SXp5L1A2MnhwdnBHWGlVU2x3NnpUOUNaa3ZT?=
 =?utf-8?B?eWljRVFyM2MrSlByU3hRZ0ErL0dPZndDbkRRdmFsTVBFQjRSTWIzaGcyaG9w?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 014a4c0c-93ca-44fa-f011-08dc91773ee5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 22:20:52.3666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NeGkP54QyEVzn1L8s5S9uD6Dveul0Yt+/mhRj0R8BMaaArCPmyDtzVbvuYBjFdgF8whhdb3r9MXzwr9eoa3eQJJk8ZiHNm2J48frVAPmRXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7949
X-OriginatorOrg: intel.com

Hi Babu,

On 6/19/24 10:03 AM, Moger, Babu wrote:
> On 6/13/24 20:42, Reinette Chatre wrote:
>> On 5/24/24 5:23 AM, Babu Moger wrote:

...

>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 3071bbb7a15e..400ae405e10e 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -186,6 +186,23 @@ bool closid_allocated(unsigned int closid)
>>>        return !test_bit(closid, &closid_free_map);
>>>    }
>>>    +/*
>>> + * ABMC Counter bitmap and length for tracking available counters.
>>> + * ABMC feature provides set of hardware counters for enabling events.
>>> + * Each event takes one hardware counter. Kernel needs to keep track
>>> + * of number of available counters.
>>> + */
>>> +static unsigned long num_cntrs_free_map;
>>
>> Why does variable have "num" in its name? That seems strange. How
>> about just "mon_cntrs_free_map
> 
> It came from patch 4/19.
> 
> struct resctrl_mon {
>          int                     num_rmid;
> +       int                     num_cntrs;
>          struct list_head        evt_list;
>   };
> 
> num_cntrs_free_map is a bitmap representing num_cntrs. Kept the matching
> name for better understanding. Renaming it will loose that connection.

I disagree. The "num" in "num_cntrs" indicates that this variable stores
the _number_ of a particular entity. In this case "cntrs" or ... counters.
This is just like how resctrl uses "num_closid" to indicate how many closid
are available and then have a separate "closid_free_map" to actually track
now closids are used ... it is _not_ "num_closid_free_map". Similarly,
"num_rmid" indicates how many RMID are available and the "rmid_free_lru"
tracks how RMID are used ... it is _not_ "num_rmid_free_lru".

> If I rename then I will have to rename both.

No, you do not.

> 
> How about mbm_cntrs and mbm_cntrs_free_map?

"mbm_cntrs" does sound good. It is more specific than "cntrs". I would suggest that
use "num_mbm_cntrs" to match with "num_rmid" and "num_closid" and then
you can introduce "mbm_cntrs_free_map".

>>> +static u32 num_cntrs_free_map_len;
>>
>> Same comment about "num" ... also, any special reason why u32 is needed?
> 
> Only reason is, it is supposed to be unsigned.  I can change it "unsigned
> int".
> 
>>
>>> +
>>> +static void num_cntrs_init(void)
>>
>> mon_cntrs_init() ?
> 
> mbm_cntrs_init?

Sounds good.

> 
>>
>>> +{
>>> +    struct rdt_resource *r =
>>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>> +
>>> +    bitmap_fill(&num_cntrs_free_map, r->mon.num_cntrs);
>>> +    num_cntrs_free_map_len = r->mon.num_cntrs;
>>> +}
>>> +
>>>    /**
>>>     * rdtgroup_mode_by_closid - Return mode of resource group with closid
>>>     * @closid: closid if the resource group
>>> @@ -2459,6 +2476,12 @@ static int resctrl_abmc_set_all(enum
>>> resctrl_res_level l, bool enable)
>>
>> resctrl_abmc_set_all() was initially created as a complement of
>> resctrl_abmc_set_one() ... but with more initialization added to
>> resctrl_abmc_set_all() this relationship becomes vague.
> 
> Yes. Understood. Let me know if want me to change anything here.

How about renaming resctrl_abmc_set_all() to _resctrl_abmc_enable()?

Reinette

