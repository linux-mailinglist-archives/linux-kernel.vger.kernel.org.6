Return-Path: <linux-kernel+bounces-333746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4FB97CD42
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564FD1C21835
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC211A255C;
	Thu, 19 Sep 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFb1qo03"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760541A00D2;
	Thu, 19 Sep 2024 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726767938; cv=fail; b=u9+yQG8kZU96eWam4ylbH5Eac8BOXBBqebpy/UrOnq1DdFfKIEamZpaQ/m0usEJgdSdb1UheRUwTC6EqqE3FHVm5rqnMyK2/r4NCJ0S/adAhC5uBiH7wOPWxUIkhZln2TWCynjpW8xMovHQc013pyjLQ/uYxGRJPVuaJhB5EmKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726767938; c=relaxed/simple;
	bh=DbmquDm1c5YrcDJ9ic61ijwVn3zsoipX/1jpCqOTrow=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GQf3WUdXFoBG8xshLeOYLj40lwx8Z5eC9V9+MiZuCn2PqeEfrGpF44myomT1IvSG6jTBX8uafpvrTEc6OzYV6/SRyMaXQgynndt4uyLIcJCVh65ZnUJCOrNTWOHWsSD17NPApNQ6PBpEm1bK4Bw5DDUQemg7Ns1LbKookvj94j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFb1qo03; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726767936; x=1758303936;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DbmquDm1c5YrcDJ9ic61ijwVn3zsoipX/1jpCqOTrow=;
  b=UFb1qo03zliEa1srhQqPat4k8LOppwA65u2fUmJYtatafXNCflyWaZbc
   FZA+Z7iqpMbYV8eqo0EodTR4bypWTkf9YE3Hr+8QT1HIb44GNoYMGnKgB
   OX0yAfb4CZdezF8q/F7ORLRu2i+1XpEn4HYOEgQesl2lgGPqdD//2ZwGc
   WfwOWoMED/8yt4F2uVL9ABpd/3kSGevZgV2ZhFW598SdcCyJuF+g5B8ia
   uvS77QAQeaYewKyhEmUAUMzQKVAo+mPV5hS4VyBJrvNW/23JDDC8Lsw8J
   JVoY9E/d2isXJ4c0P2PzoZMgc8tjIGgs9kiXUSwziuVB8nTw60GnEXE6r
   g==;
X-CSE-ConnectionGUID: VtzWZ2yjTVeFejv3AENtSg==
X-CSE-MsgGUID: 1CcaOkc4RQqXXuuYcZ5F7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="43266520"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="43266520"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:45:34 -0700
X-CSE-ConnectionGUID: UYUyUVwqQ0mMSf+fa61Y1A==
X-CSE-MsgGUID: eMLho+d7QiOXukZPxVpasQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="107486701"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 10:45:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:45:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 10:45:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 10:45:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxI5N/RWFccuxjO82Bw3MddWR/hhRzzIoS49ia1vSEvbaSs15IOz3BQCwOv6jujnzn+rbMKho32VamLEf0d3QvkkPwqJ/Cjz4DvcT8rztODkI9YivFut/tByzTC/h9skx12X96HeqHgW5256AqLUhXIbJ6DNzmOW9c/uKUefDag6UKpxXPAIS3MRWnI9ojkFO8smrXEZAtwn6plv501EF2uRlsCLF3GKxDYMN34VEbX44cu5GRJ+R0Z26ZaVolQe/Y1hQjWlXbbviOo248YqHdaAW0WUTQk88HUhFG8iEhHXGe0jBQ9Alu1MEdgWJ5F0qsA0oQlvb73wSl+LoThsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAgSDjtiNT7zlSCrxlataHauJdI4NO/33AYcPPOw7Bw=;
 b=aPJUQhsfxt0oP57252wu6w1IikNKWYo4hPVwbPtJEW/kLeXiKGGVwNtbjRji+21L8FneV2pCvKj6pKn2AaB7XOKpC9PO02IjeaOcL+CnDbLWzqq5ACVuN4AjIA8kWVWa570UqO72Qxfq7oNwvCdU1v4Fmdm37ACOeF4aAiO77IObr0f9l/iyFtX6w21Zq/zeIxbJFedStzaqveTUB+eYg9gYKx9FWrH6F9UB9m94nf82op57HK0MU2ShauzLnzCcEbmcIKkg6XfmpU+yi0G4bJxh+UITGdX2P1Uxhf8Cr/Wmx895x40hZqBzZ5tc0gx1UYij/kUYmAzdu+UxfHyMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4710.namprd11.prod.outlook.com (2603:10b6:208:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 17:45:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 17:45:20 +0000
Message-ID: <384c2074-0076-4686-bebd-ba3ac3c05188@intel.com>
Date: Thu, 19 Sep 2024 10:45:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 22/24] x86/resctrl: Update assignments on event
 configuration changes
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <ff0cd2a73c78fdb7487632381b4aec642a0af5ef.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ff0cd2a73c78fdb7487632381b4aec642a0af5ef.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4710:EE_
X-MS-Office365-Filtering-Correlation-Id: 540f4a1c-c5f1-4c3a-a192-08dcd8d2d490
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmFiL1dHZ1NkU0xxdnA3RjIwbmRTdWZJUHU5RGw4M0Jad1hGTkticVk3ZERw?=
 =?utf-8?B?V0xRcThLSkpSZFpmUmtiUU1vM2pETVliUWgrakJISTYwM28rU1RNSkhKd1Zv?=
 =?utf-8?B?UFFScXc2OTh2UTZwK3ZNRkFFa3lPTDVPbmN1Y3dFYmJQMjRKb1Z2NkZQR3pq?=
 =?utf-8?B?UzFLMnRmalhaa3BZTkIvZ0NsNXdyeExlQitlVEdrSFdSUGlMZmRFZUx6V1JY?=
 =?utf-8?B?andGQXpXbGFzNGJBZXBtWnN3SUxVRkMvMmRFWEttNzVnY2pMTHQ5UXVMckt5?=
 =?utf-8?B?aFF0Ymk1TkpoVTl0eTVBZDB3N21jUWhwZnRrY0hSYnhZOU50QnZ3QUk2VU5i?=
 =?utf-8?B?QitnV3ZKeDk5OWM3Slhzb0d3cGc0cGEwbmdWWlFqSU81WU5RdStaR1lzazJM?=
 =?utf-8?B?cHBOaTJjOW9zY1J4ZFZYaG8yUERuYzVTR2FZaE9jbkVRMVdqelN3eVcvRW9m?=
 =?utf-8?B?Q1B2ZTQ1OTIzSzBiL1lpemliR29pNjRiTmJOeVFEWXBJaERiQy9zZmNlVWh3?=
 =?utf-8?B?SlZ0cy9ueitqTVo4cFFmdmhDUXZkREY5VUZLVTk2bE9xTTRNYWRldE0rTkxK?=
 =?utf-8?B?VzZwSHgzaHpnRG0ybXc2b3VSdjNuZ1djOExqcE52N1hOVnlsd3A3eCt1NlRO?=
 =?utf-8?B?VUlDa3MyZ3NMdVJjSm9RVFhsZHNwN0x2eW1kL1VmenR4emZxLytDZnZ3Q3Ax?=
 =?utf-8?B?aFNDd2pUZlMyZjBGUDZjY3RpbUNHZVNrYUhCRmQyTllwbmM2Zkh1MHZyd2do?=
 =?utf-8?B?VC9JbU1JVkw3TnRIUnVHRlIrMVFRR2RoS2IzUml6dUFudnpCODdEbThnaUQ4?=
 =?utf-8?B?aHJsTkhVMVhhcVc5TmdGaFBuSTJTU21NRm81QjRLVU9uWFFPcGIzcStTOWNo?=
 =?utf-8?B?WTMycmtiOThES0Nndm41Y2ttMUM1em4yVmsycGt5d3V3ZjhiUlJKdXI2WlVP?=
 =?utf-8?B?bmdCekEvMGs3UDZPUEZ2cDVEOHhaRXppUmVsVkRnSG01SEVpZUFrMTV2bGly?=
 =?utf-8?B?K2hLdStMdFlCZ3g0QktaWWU3aDl5M3ExVWdaOE53aTdiK1IvQUNEeEFmSGM3?=
 =?utf-8?B?OHVuc2ZOWXFhZE1oSHY0SHQrUUNneFZ4eVJNRWFubHR3N3BNZGhyRThKZU1W?=
 =?utf-8?B?TCtOUG9kYzkrVWlVTFlBTWhKbExYdVNhdUF5djhXMDhycUUzQjBSQ2E1d0Vi?=
 =?utf-8?B?bld2d1grYlVzK3BLSThoU2lxdmhtL3A0SGU3Q20zNWp2L2FJVHU1cTcrRDND?=
 =?utf-8?B?RStSdU13cVZ6ZXgwTWpoZjcvSDBiNWpKVEJodElYMXk1WEhOWDhsSlRaTGpV?=
 =?utf-8?B?YnJUVTVVVXpHUkNxdGdIa1V3WVBxUmhaSzUrMWhDc1N6LzFxNWx3Zmh0VTBS?=
 =?utf-8?B?bzQ3SkxsU3NpbnpWWUlTMUVhRlMwdkJJQjhaKzlKLysyOFgzL3k3QXAyWHJn?=
 =?utf-8?B?UWE4ZzR4MUpzaGNxOW1RbkJ6VjlwWFlnU0JSdGx2QUppRlRwVGp4bkw1dHI1?=
 =?utf-8?B?anVoVXp2Wk5Ma3A5MXJMTnMzUUdPMnp4Z3NQeExGVU9zYkl3YzhRNTdGZWs0?=
 =?utf-8?B?Ui9LRWxWeExVZjdWT0tIVEpla0o3SXZwMXZHS3p6NWdKV0dUS1lxUDZOSC8r?=
 =?utf-8?B?NW0rVE53cTc1OFEvY29zMG5jT2x1bWt0OE01Y0tYMG41RGVBOVV5ZUw1ZnFy?=
 =?utf-8?B?TExlelhuSU52akhmWDdlZWdVU2hicUZvWE9PZXFHenQvVFF5akVCWlVLTEFa?=
 =?utf-8?B?aHJ5bTZweTJyWXJyT25hV1VFNXNSL0tCZjB4cUJTYi9rOWMzQ3RKM1pkN0Ez?=
 =?utf-8?B?TnkxWm5WdkVMc2V4ck5NUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWcrelZJc0JweERjNFZEOUpYcG1zR3dGeWoxM3RZOXhzaVlRd0w0TGluQnJV?=
 =?utf-8?B?aGJZd0krMTl2ZmErMSsyM3M1YlNRNk5naEEwWjJIUGFqbW52aGhFOHkwZERn?=
 =?utf-8?B?ZE1rQnVWa0Fwa3kxRWlCL0dUZ2RQMlRDcXo3YTYwRTNESERUQ1FNU2ZzMEJV?=
 =?utf-8?B?TDlsNDdJWEhMMTNGdE85b1hPNUwzRHVvYlpyTmJva1JTUGdLTUdOVTN0MG5T?=
 =?utf-8?B?a1BjS3Z4bXRsdVpobFZVSFJsdVU2KzBVbDhsMXR0Z2N6TlJoRFpZM0ljUTBo?=
 =?utf-8?B?SGtVS2xnRHVsV3VRMU54NkU2RTZYY2Vya1lYbnVjeHQ5WE90cll6WHZIT2JD?=
 =?utf-8?B?L203UUxaRmp5bmswOWFZTHhCMG4zT25TL3dwaENOMFRPU0NQeTlyemVaNGc0?=
 =?utf-8?B?dzRrVUFieS92am00OVB5ejdSeldpcy9OZ3ZkakkwOTJZT24wM3JINW10ODc5?=
 =?utf-8?B?TlJSQVZCVFB4akR5WGljR2d3ci9UaHRLemp2RWR3TTl3U3poUS9ZVEZDUk5S?=
 =?utf-8?B?aFN6a2ZmcmZTMm9KZzh5cncxVnh5QjlWSk5leGNGdXBHc01DSElGaDVTSXpW?=
 =?utf-8?B?U096VE5rVzZFNjNQM2xUZUNrSGRqT2JQYmQvZlJHUGxRMXJtQmtRTklOb1B2?=
 =?utf-8?B?VmFUTEUzejVxRlMxQm5HeGFDbkRXamY4cERYSWRsL05oQVdZZTd1b05mNjZG?=
 =?utf-8?B?dXlCUVZ3R3k3NGNQRTBxM0lBSUduN3JydDNoNHBjK0dKaTVxMUdmMVJMdXZ0?=
 =?utf-8?B?NGpoRnp4ZlE4Um03ZERlOStsb0JkR3RERFRGL3FHYkdFdzlweVZaa1ZhM09P?=
 =?utf-8?B?Z2I0ZFhHcEdzMnNwS0Z3SzJjVXdabVA0aE03VlVvWDJ6cytWLzBDOFlyWWdB?=
 =?utf-8?B?bytjMUpOZWdPcEN5ckdzaFNqUHNFV0pWaGdFT2R3cFB2UVg3aWhDSFhmZVRE?=
 =?utf-8?B?aE9tVTRrRkVWelpCa1BvaUc1Ylp4NUluc204SnZsNm53bUtkNkdZMjluYldS?=
 =?utf-8?B?U3gwNm5kT0RyNkNvbWgyb29GWnNHbEpPMGMzQ1VLSVNzNTBpaytSTDJjUXk2?=
 =?utf-8?B?a0lJQ0NqM3F3Znl0K3BvSWZVZmk3U2lyQi9DYXdYc2ZLUTVKalA3bUZnSjVJ?=
 =?utf-8?B?Y01qNEMzUEdCVXlwTlBvL2V3K1dJb3gvQlhKVHdjVG5paGkzRjNlOGdyS09B?=
 =?utf-8?B?ZExtMkdQajhYR21LUmcrYXRrazB0ZSthZmtyME55V3QxQytXT3U3V1lyc0RI?=
 =?utf-8?B?NksxQStRRnlmWXJUcUlyWVNnWWxRWE96UEFabGxDMWZ0N3gwajRud3g1eW12?=
 =?utf-8?B?dzA1MFBWWlo4L0VUbWtKZngrakx2RFVrc2szWWhneTQvVytLQTMraG9lMm9h?=
 =?utf-8?B?MVR4QklCRGVZY0laQ1VoS2lQOUtRT01ldnFxY0VGKzQzNTZTM0srR01telAr?=
 =?utf-8?B?em53T2xWcE16RFdJVGFyQXVjRE13aXFRRHRMRE5mQ3VWZlVIWkJ1djZIS2Ez?=
 =?utf-8?B?QWcrZmtNMDJMN2xjdHBFenJVczk0bnJuaGFSVjd2c3NVZUs0eVZCclRYRFZk?=
 =?utf-8?B?cENOMWYwZC93YzQrS2l3azhHNnk1eFZjcTN4RGhidlZjTFlQUi82MlpLY2JI?=
 =?utf-8?B?N1Z3NVJaU1k4bmVxQ1hnUkpHUTY3S0dCSEN5ZUhiTXFHa2UwUVJlSFlMM2VR?=
 =?utf-8?B?b3I1a1B4L205andzQm9KNVBmNDkzNjE0V2JoYlBPenowRnMrOU9nNXZOcEx4?=
 =?utf-8?B?eDFRbHBxZ1VuTGdEcGRjZTA0WFpSZFVSS3IwMVBuMTlTazFXeUFIa015Q1JR?=
 =?utf-8?B?QXpUU04wWXZxMHR3VmNJRmtWaXpaVm5HMXN5OUtmWit4QVg5WWs1TWNNU3Rw?=
 =?utf-8?B?RUVjcTQzNldkdExYTU8raFdqaUtLTWZhcU5FczNIR1ByQndZRnhCcG9kSkZs?=
 =?utf-8?B?bWI5TW4vcHRtUlFxbDg0ZU5DZUpVQUxEMCtwSU1jMExNOHZ3M1U4THVzemI5?=
 =?utf-8?B?Q0JaU1ZYYmR6ZU1HV3E2ajlCNStRdHYrZFN4eVlzdTJwZ0tFMG9abVY0OVFj?=
 =?utf-8?B?bTVRaFJMTWorYmFseG0xUXI0Q3JxNEJhMUkvUldMbFU2V01renJGTS9HcGdy?=
 =?utf-8?B?bUxPNUFRcUFpV0k1dkNkcENFWDRUblhQamRxcmpDQk9aY2lodVJxNGFpMm5j?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 540f4a1c-c5f1-4c3a-a192-08dcd8d2d490
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:45:20.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJ7EAdAEZwqHz4D+Vlgm6clRaNG1VisDYal7PaGMs+am54sBZ80whZGeh0UJT00XlMnqb18GtkeEVS59hDpsLwXUJl7iYsLAenwGcoaNXA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4710
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> Users can modify the configuration of assignable events. Whenever the
> event configuration is updated, MBM assignments must be revised across
> all monitor groups within the impacted domains.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v7: New patch to update the assignments. Missed it earlier.
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 53 ++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1054583bef9d..0b1490d71e77 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -871,6 +871,15 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>   */
>  #define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
>  
> +static bool resctrl_mbm_event_assigned(struct rdtgroup *rdtg,
> +				       struct rdt_mon_domain *d, u32 evtid)
> +{
> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
> +	int cntr_id = rdtg->mon.cntr_id[index];
> +
> +	return  (cntr_id != MON_CNTR_UNSET && test_bit(cntr_id, d->mbm_cntr_map));

(Please check spaces and paren use.)

> +}
> +
>  static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>  					 struct seq_file *s, void *v)
>  {
> @@ -1793,12 +1802,48 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static int resctrl_mbm_event_update_assign(struct rdt_resource *r,
> +					   struct rdt_mon_domain *d, u32 evtid)
> +{
> +	struct rdt_mon_domain *dom;
> +	struct rdtgroup *rdtg;
> +	int ret = 0;
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
> +		return ret;
> +
> +	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> +		struct rdtgroup *crg;
> +
> +		list_for_each_entry(dom, &r->mon_domains, hdr.list) {
> +			if (d == dom && resctrl_mbm_event_assigned(rdtg, dom, evtid)) {
> +				ret = rdtgroup_assign_cntr(r, rdtg, dom, evtid);
> +				if (ret)
> +					goto out_done;
> +			}
> +		}
> +
> +		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list, mon.crdtgrp_list) {
> +			list_for_each_entry(dom, &r->mon_domains, hdr.list) {
> +				if (d == dom && resctrl_mbm_event_assigned(crg, dom, evtid)) {
> +					ret = rdtgroup_assign_cntr(r, crg, dom, evtid);
> +					if (ret)
> +						goto out_done;
> +				}
> +			}
> +		}
> +	}
> +
> +out_done:
> +	return ret;
> +}
>  
>  static void mbm_config_write_domain(struct rdt_resource *r,
>  				    struct rdt_mon_domain *d, u32 evtid, u32 val)
>  {
>  	struct mon_config_info mon_info = {0};
>  	u32 config_val;
> +	int ret;
>  
>  	/*
>  	 * Check the current config value first. If both are the same then
> @@ -1822,6 +1867,14 @@ static void mbm_config_write_domain(struct rdt_resource *r,
>  			      resctrl_arch_event_config_set,
>  			      &mon_info, 1);
>  
> +	/*
> +	 * Counter assignments needs to be updated to match the event
> +	 * configuration.
> +	 */
> +	ret = resctrl_mbm_event_update_assign(r, d, evtid);
> +	if (ret)
> +		rdt_last_cmd_puts("Assign failed, event will be Unavailable\n");
> +

This does not look right. This function _just_ returned from an IPI on appropriate CPU and then
starts flow to do _another_ IPI to run code that could have just been run during previous IPI.
The whole flow to call rdgroup_assign_cntr() also seems like an obfuscated way to call resctrl_arch_assign_cntr()
to just reconfigure the counter (not actually assign it).
Could it perhaps call some resctrl fs code via single IPI that in turn calls the appropriate arch code to set the new
mon event config and re-configures the counter?

Reinette


