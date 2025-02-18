Return-Path: <linux-kernel+bounces-520088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE696A3A585
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C22B169C29
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C9C2356C2;
	Tue, 18 Feb 2025 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QovZD4X2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5117A2E4;
	Tue, 18 Feb 2025 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903245; cv=fail; b=Geeg4USEG2JjDkEoRQ5oZokVW1N6KG22zOacA04we7QVr+1PXJLSkUf/odbpHSeotUPLyTuXfGLNbUPjIdIc8oRk0YLhDHTBIoBo3RmeVaYlLB5Cc876Zo/4CHW1ifQBA0n8g5bP/WVygAlIEYbmTGI2Ct8c3cDnyCKzAF+Omco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903245; c=relaxed/simple;
	bh=mkMGHky4odQbLAwmYTHHXpSJ0baPToB1exTtHWwpcXQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aXc+spurRpgpSmZWEDGQM039xcGrUBa++E8qhruu1Se5OGA8D+dIfI26w1OKhFvwVfVdjmqPiPzhhurEMmqJa5GkGco+9gHdBh+USpywyb6BlZZFJjiRUwz7f9RQ2PnXCYjiDaQqftIgGusP+ogAbXZoI/Rgz5lgZvuz0QWxZzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QovZD4X2; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739903244; x=1771439244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mkMGHky4odQbLAwmYTHHXpSJ0baPToB1exTtHWwpcXQ=;
  b=QovZD4X2flpQiq3b1V+wXZ8sqnKgEzEMgWa/9FNPVGvg6IVIxnWxkxKy
   vQGnZZkyAMT18de/nxJsJlrY7kDDnYpeL8ni0YyIGxjKQYAnignSy4t4Z
   xKKbF9aBstXxIoXRMiotiGFnvX/u6uZsHrDTJO1AnTqEVUxdwDZxw99wP
   +CT2l2CcTJEdftYGYaF12oxL3by0YKVl3EGGnTu1TKoc5HAVbuAGZyS5A
   Vo/Xgq8UDA9domPLf5sJmFqUGOjfIGuU/k4UroNe0RHfJpPa9aOPoWkkh
   DxC/s/wDVx2tgdbZ3U+sO/nIRtKcJoPy5vCEnPMRHxgHtc+ue3RZ1OXLY
   Q==;
X-CSE-ConnectionGUID: gi7O67jZRAijRYyXmLCD3A==
X-CSE-MsgGUID: Oza4ce5LTZeoh1GKhTZVtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="65970264"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="65970264"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 10:27:23 -0800
X-CSE-ConnectionGUID: ELWs/JSGS9CKKM1H93K/2g==
X-CSE-MsgGUID: Qf36TEFgSwuS2rdGdswDKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="114403083"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 10:27:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 10:27:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 10:27:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 10:27:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqMWoiPHcCNaftHGeBhmWQP0KLNLddfWebGQuTEFEs+GFi1blKVZZGS+l/EwMN3AxYA/y1LdWwhnVjWaGou8AtQvqpi2eNUT3Bq573MqM/7+w2vDz0fVkYRQ2+i8mm4hUnGAn0kqLZYIMQN9igBrZxKU9k0tgX06WFWyWC+aHyhzdJmICilPPCrmU5E4rOyYaJ1hNR+Y9tTI80QY90YBW8PPJu0ea4ub1IkP4wPaZEUIlcoVcn67/rc4rQi5zeHcfIaGWOOelHohOyHcZVXSW5caT9Z/QoPgZBwuDikRfQs8Jj0PG5HdKOUhyHlZOV2N4ymE5ioNwANWMukdRKHgrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5RFc3OKCziZD4P3I5VE6mYf8eAEmmIX13NGLUhOviQ=;
 b=jwLcuVq3hSs3kQrv1VpILgByRaFDVz5+i2aI5EaBzKoWXgigjHSFoYrYstIGvLhjUttwydEaByxQ7rkBkpJmButPUdxpMjdPO2jPC+4GCJ2QQFfy44ooRfIdrF4rEYw50VPAwE2xvQKL3wodwDfaKavIx0D7smGdtUWDgYEBpi2crSccya9UeDckPdJCH3GlZj2s9N1tNkWW5IXPVMw18+mWsWWvgAxd36MxPXOF4hWUfNW+KCO75TZL6uDwcN+rGl9L+zm/jEhLHx22oqK5WppcjPWiF2dTSi5OsQ1+1S8R//rVcNVgBiBTZpfXgI0gdf6Do6DLFe17uT8+edJ6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6008.namprd11.prod.outlook.com (2603:10b6:510:1d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 18:27:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8445.015; Tue, 18 Feb 2025
 18:27:16 +0000
Message-ID: <feb03d13-e82e-422a-ba5f-ff9a937aad99@intel.com>
Date: Tue, 18 Feb 2025 10:27:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: "Luck, Tony" <tony.luck@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>, Peter Newman <peternewman@google.com>
CC: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "xiongwei.song@windriver.com"
	<xiongwei.song@windriver.com>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "Huang, Kai"
	<kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Li, Xin3" <xin3.li@intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"ebiggers@google.com" <ebiggers@google.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Eranian,
 Stephane" <eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <bdb48b29-92cf-4f98-b375-25ec84f0941a@amd.com>
 <SJ1PR11MB608314CFF36D167483859044FCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB608314CFF36D167483859044FCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0313.namprd04.prod.outlook.com
 (2603:10b6:303:82::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 8370294e-ba30-4c23-7c1b-08dd5049df30
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGNJcXZzYmpnNFFzRTdLRVNLZEd1OFRjcFlTYkw1SHZhVjlvaWt0ODlwUUlT?=
 =?utf-8?B?dnlybCthRVlRbFBCUElxemdUZGlXampjTG02QXFUeEV0V0NCMlVYUmN0Z2xy?=
 =?utf-8?B?dXpHQ3lHNk53b3FLOFFzNklzeUdxb0tjTkcyRVVSYmIrQzNISnpSUVpBYkNG?=
 =?utf-8?B?UlBodzhBbUgrSEtVS3psMlB2aUZGUERRbEFiRUN6cnBLQldNZ1ViZk9mUGhF?=
 =?utf-8?B?QUZmZTlyVkNrMGROTGY1NVRNNTVQSGMrTnRUcFJCdHpDSk5IcWZSLzZZUkpz?=
 =?utf-8?B?dVdnNDR5WHZSMmViU3U5amJDbTJHNms1cWh0MG5XMjloMzB2WnlpRVZRT0pB?=
 =?utf-8?B?S0toVHlFY3RxS1J3MHNIYUhVblBodm16V1BBYXBURlJVb01OSW9Qb3JxOVFy?=
 =?utf-8?B?dHoxNkIvVGRzdlNhNnFCS01BV0t4Nm1ETGdLUU15V2daU2FkT1oraFdtU0Js?=
 =?utf-8?B?OHhud2tYOEFaRzhDeWNNU1piSDNiRWNaVTFUR3FXSjBobThDTHFVMUsrTnBk?=
 =?utf-8?B?SGw0RUgxRmNqR1dLYTFvdE5UZzErdzV3VWNtaldTc1RWUW9tdi91S0pBQzNl?=
 =?utf-8?B?Tm5UYWtaQ2FFYlZGam41clVoSVZDd3NsZWUvM1hsam9nYmRGSE9yeGdWYXRU?=
 =?utf-8?B?V2FEd0FZbjhSRWlYMXZoZ2FJeDFvZGlOWnZDUFZMeExSUUJlZkJXc3ErVlY1?=
 =?utf-8?B?REpGRGgrMEw2REZTVlpUYWlOM1YzRHlkNjFQRzhxc2NLU21GMHloa3V6VTRW?=
 =?utf-8?B?aS92NEtPK1o0Sk1SUU9sVkxIREx3NE9Cd1VQTGhoVlBBVlBCRUhEdnRjM2Ur?=
 =?utf-8?B?ajJ6UUd2czZmeE9TUTN5TytXSFlWRjRKVDJBVlR3R2hLZXFjS2MwMDk0eXZ4?=
 =?utf-8?B?eFlKMFVIWlVseFd3KzVUeFFRZXQ3REMzT0pIdDJscSt1UVNDTmFFMnozbjlj?=
 =?utf-8?B?Y1FudUlCeE5pS2Z2YUJMVlN4NUVrbG4rOURnZHVTVEdJTnp3OWJ6YkQvTXNh?=
 =?utf-8?B?MHkxejFCSTJNL0dGQXBlUXQyZE44NkhYZitGY2lRT3NxMkgvQVdyVFpnd0Ny?=
 =?utf-8?B?Q1JVSXRLMml3bnF5bmorOUNBZXoweUNPaCtmZURtUlprd0lobVNoeE9MYjl6?=
 =?utf-8?B?Vi9VQUU0L3Zra21ndzcxbmhKTlVkOEdmcEthcmZlQW1lMnRnNXJjdFNtTXRl?=
 =?utf-8?B?QjFZY3Fva1hoT0lhWHVFRkZkRzJMVHFBQytQN1ArR1RUWllWdUlYSTZESlhu?=
 =?utf-8?B?TGhNcnJVUDhBZkt0L04wdDJoZ0tqa2RtUVMrN0ZvVHQ0ZDZlSG1DeXdrTE5r?=
 =?utf-8?B?Nis3YjB4ZDJSd2psWVNPYXdGd1VaSjEyaXZQbjFPanhnV1FIMVB4V3hzTG5l?=
 =?utf-8?B?OURwbXEyUGY0YnMxWldabFFCZ1VsejlPVXY4a2xjNzVNT1kzYUJua1RBK0RI?=
 =?utf-8?B?bE55UWphUjZHeDNWSUkycVE0TllJY0Q4cW8yWUpqYTlVL010aEoxd0o0SGlv?=
 =?utf-8?B?TnFicW9EWHErYU9qK2hLYUdZSEYybkFDREdtZVIyRkhkdEdWYVRmQjg5N2s2?=
 =?utf-8?B?QXNwQUZaQUkxL3NOY2E0K29Cb3RIUUh5UWV2SlVoZlU1ekxzWnNuNTFWa0o0?=
 =?utf-8?B?WHQ1M0Y1a1BVbWs0b1BnN2x0Q3hFYmdHSTJzeURDLzE4SFZBRXRSTVBERmdK?=
 =?utf-8?B?TmprTFNTYnJBMzVXeUVCMmlVWk1jdlB4MjIvQ1dPOVFiNnZ0dmt4REJJckdC?=
 =?utf-8?B?ajRkVDZPejBhK05aaGQ2TkVRcXFINkhEcVdCTGpwcXp1SWN4dUxHSUFEM2lH?=
 =?utf-8?B?aDUvYlV4S0NlUFY2UUdjcE9MeGpOM3ZJRm1IaHpSNlE1dDNTLzJac3ozQ1k4?=
 =?utf-8?Q?6q+c39L2wvUtH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk5YMzRPejl5RXE5bVY4OFJDS0FhbGdKM0VuL1NjaG5SR1pTTXNjNEhNdFZz?=
 =?utf-8?B?RDFBK2RKNmFUUHAxMGNFZVh3c2FYOUxhNGxNTGloOU9HeUdvSXVtL3NzckJs?=
 =?utf-8?B?VWk1Wi8xcXhCalMxS1VmbVhHZnJRTEU1Wi9PSTlzcTA0Zm9aTGRIM3Z1bEMv?=
 =?utf-8?B?VnNwZk5YK2RJUG1CTldQT2FyMm9mbTNWNzZoSXBlV284S0U4M3IxVURnR1FO?=
 =?utf-8?B?MDZvcXAydm8rL09kSWZnWDNVUFQ2ZDB5VHUvRW00akxKdy9MeGh0MTdUWHho?=
 =?utf-8?B?MU1uZk9jV01OZFBQalRFcHREQjd0NVZ2U0NHY1pMOEdNR2s3ckFvMHJVbGVZ?=
 =?utf-8?B?MkY0dUxIQ3VseEtkS0xvVDY2alM0VGtSRndaNW1aVDAyNmJ1WUlOSThoVmVt?=
 =?utf-8?B?aVlYUjcwUzJBeVdpaTh4YnBPbXNTTHBEV1I3eGxEREVTR3JyZkQxN1VBbTNz?=
 =?utf-8?B?cDZGbFNkSzZPdXl6eGZmV1ZnUDloTHM1V3hzMFJFckM2WXNJb0l6QUNXTUVq?=
 =?utf-8?B?ZDk4dEZCN0hjNktLT2JoWFpIZXFPSkUyQWpVK1MvV2ZnVmtsdW1RTnc3dzRS?=
 =?utf-8?B?dW1wRjBmUUNHNlJLZW90SERPUUVDL1kvKzA3dWtnSkRDZ1J4MUwwL0thYXk2?=
 =?utf-8?B?b0hSTEJwSE9taDJBKytKT0k4K3Brc0dES2xYK0s1L0RsQ2FISlR5WHdGd09S?=
 =?utf-8?B?SzQ3WmI0OTZialM4RVo1U0pIbEp6Uk5VZXFJc0xGVmZBTGl1QXZTeUtRWHdn?=
 =?utf-8?B?eVdIWGEyeVM1WGxOLzVxOWpzN3NDZHlDelYyRGhVVm9rRWRKdTZmUmRMZkxu?=
 =?utf-8?B?djVrTjdCaFFlenBKdTVYZlk0ZjVWZmZtOHBUZU5Pbk9YNmJkV281MmlyQTBY?=
 =?utf-8?B?TE5KcmoxRFFyNHJMV0VXY3VuU2tLT3Ezc01tRGt3dWc0WmFYUGd0UCt3aUdv?=
 =?utf-8?B?OFRIK3FOandpQlRxN2NjUzV3c1gvTjZob0xBNWorcmpORE9LUWNvSGJkd0dF?=
 =?utf-8?B?T09KZnJXVnhKZHNZdjBjUDFjenVOQTJ3VStwWEgyZ05IWGtUdDNLQU5aREF2?=
 =?utf-8?B?M3l1WnIxdVloR0JhanR6S3ludFcrd0I4YVFiM0o2cHAxcysrRzZlZlJmR1pI?=
 =?utf-8?B?SVQ3Y0doU3hIUHl2WDZvbmdtTEp1dzhJNmtJOGtKclRJTzNsTkkxODhESVlz?=
 =?utf-8?B?c2xic1d1aGZ3M0lvcXk2aytZRllEQ0hub05ERi9vOTlJV0FzV3NnS3hkMHRa?=
 =?utf-8?B?Zm01c3dwaHJ5c3dJNkhyMUhOR1Z5VEE1TThsK0dBWjJYYVp3RGhiS0RkQ1Ny?=
 =?utf-8?B?emQ1Tko4c3FsREhBdWFzNlhBMmhuMU55Nm94blFtN2xaOFdkaW9hYVBRZUhN?=
 =?utf-8?B?dWpYM2lMR0hHZkJHeGkzYmovaUxnVThqanA5bGNiWGhlZGNUM3pyTFZXRmVD?=
 =?utf-8?B?RjZYbDc2UDFKQ21pQ2hIeFV4dFV0Vm5uRlZxZHo0TVZGRlN0d0pqV2w5YzNU?=
 =?utf-8?B?QnJKSlhWdnlXSm9RclYrdDlQWVlybzF2VStGZGEzUkZHdFZmZnprVWkvdm1V?=
 =?utf-8?B?eVBzK0E0NEM3bG5WMjBENkJsL0ZEYlNDeEV3SlV0NXpoQXNxTjNxcmJEU1Bp?=
 =?utf-8?B?eDV3ZHpCM1dnUGpuR3pUNXpUWGk1Wm9SWTc1dVQzYVZ4RmhDSHA5UmlvaDRa?=
 =?utf-8?B?WFU5Wi95cXVoYnJwcGxQU0VROERzQWM5ZmZza1h1eTVkZWlscFJDZzNVZVNH?=
 =?utf-8?B?TTFuRFpraUE5R2x1aE8rZjlGcGdmSmp0b0h5UFovTmduR21hc2hkWkVyNDcv?=
 =?utf-8?B?RjMvSXY2c3V3ZkR6ZTFpTHBaWG9wYjh1YldUSXlyaUZ3c1ZBekZoSHZQYytX?=
 =?utf-8?B?eWltOEFGaElPN3I0ZmNuZzFCeTJSV2FvaHdHOGREZkxiK2dZWW9tSUo4c2t2?=
 =?utf-8?B?cE9rNlJ0TjF6M3l5bmJwRlhnZXp4ejNiUmtOTzRoTEc2VStUWE1hcWQzWTBl?=
 =?utf-8?B?c2ZuOEZGL0R3bUhLT01mS3lhczJYVzRLaGhvdU94U3JvSGtqdC9vSzVYU21t?=
 =?utf-8?B?R0lyN1NWajBsbHhJbmNubTh5VE4raWlDYzJqc3NYRy9YZ2Zvb0EvQUhwNGgx?=
 =?utf-8?B?QkoxVm1zdWViRnlSVXV4Mk85cmRoNk1lcFNmTE5Od2ZvWnBFQlpmSEgvb3pj?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8370294e-ba30-4c23-7c1b-08dd5049df30
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 18:27:16.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FU4oaitg0BIgTSSV/jFHTcQMND1dALP3N4NTe4w0A17bcawim0qvHnB/3QeTDl75uN0M+t80f8dZXauAdm482VdN6S+UXvpE8v84NrjwrsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6008
X-OriginatorOrg: intel.com

Hi Tony,

On 2/18/25 8:51 AM, Luck, Tony wrote:
>> Based on the discussion so far, it felt like it is not a group level
>> breakdown. It is kind of global level breakdown. I could be wrong here.
>>
>> My understanding so far, MPAM has a number of global counters. It can be
>> assigned to any domain in the system and monitor events.
>>
>> They also have a way to configure the events (read, write or both).
>>
>> Both these feature are inline with current resctrl implementation and can
>> be easily adapted.
>>
>> One thing I am not clear why MPAM implementation plans to create separate
>> files(dynamically) in /sys/fs/resctrl/info/L3_MON/ directory to read the
>> events. We already have files in each group to read the events.
>>
>> # ls -l /sys/fs/resctrl/mon_data/mon_L3_00/
>> total 0
>> -r--r--r--. 1 root root 0 Feb 17 08:16 llc_occupancy
>> -r--r--r--. 1 root root 0 Feb 17 08:16 mbm_local_bytes
>> -r--r--r--. 1 root root 0 Feb 17 08:16 mbm_total_bytes
> 
> It would be nice if the filenames here reflected the reconfigured
> events. From what I can tell on AMD with BMEC it is possible to change the
> underlying events so that local b/w is reported in the mbm_total_bytes
> file, and vice versa. Or an event like:
> 
>    6       Dirty Victims from the QOS domain to all types of memory
> 
> is counted.
> 
> Though maybe we'd need to create a lot of filenames for the 2**6
> combinations of bits.

Instead of accommodating all possible names resctrl could support
"generic" names as hinted in Dave Martin's proposal.

The complication with BMEC is that these are the underlying
mbm_local_bytes and mbm_total_bytes events on which configuration
was built. Specifically, by default and at hardware reset mbm_local_bytes
counts exactly that. The event is fixed if BMEC is not supported and
configurable if it is.

Reinette

[1] https://lore.kernel.org/lkml/Z6zeXby8ajh0ax6i@e133380.arm.com/

