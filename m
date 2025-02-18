Return-Path: <linux-kernel+bounces-520053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DAEA3A523
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996503B15A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED1227426E;
	Tue, 18 Feb 2025 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsBuFKye"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720827FE80;
	Tue, 18 Feb 2025 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902644; cv=fail; b=FigGF8t9fYEbTYJoShQUfH54mRmH18/6SYosN5SRcu7vRzElKtq4oDkI3JOCzC5N8aawOHcjkUI4mzhEWXi2P8s3xIKHXqFSjfZH3HjOW/KBUtuwOzn2INX8AfEQmyX/7KZRliaDglKFD8zfo//022VgZ3XpwsK6Xg5zwRkilWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902644; c=relaxed/simple;
	bh=vNAUVjKMk9BNIboN9XwbwKUc3UrVYOIB40k/Tnywm1E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cmBaC2nnFzePw3nW783fXofOQj33LdIbBavp5xMp+T25mn3qpxECNvXsVeWCKPiOmrjy4aH6KeMAqoxZ/7XtVotq7RfRNVh58/M9oeYZY3JcAAfsNCZnrrYwaoemlyGzrhTiybwK9CxibgRZbM7IKjSdvdvko9JdSsYbhNOzqyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsBuFKye; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739902643; x=1771438643;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vNAUVjKMk9BNIboN9XwbwKUc3UrVYOIB40k/Tnywm1E=;
  b=dsBuFKyeHn3YwpiJfYqXrRxTfFXWVS0GRS9H0103ho/oVx2EtPBUI8s/
   2nquM5/Z19sIPH154fy5r1lrl+55dPfkhqvm1HjMW1L443Xn/nclqGqmU
   usgyutxkD4j/ecHUhGCO+i9RMUwjgheKGl5IEr8NzPd1AKanSQK+jsFXw
   3IRhmGz6lUAWmxtkyJ0C5SUv8f5GNgy8dRo2ldQMiWT1J0yYG08MU6Dw0
   54phrdTjPwTwLudgh+GqzsZLCSm2MFdZQVmwikh9icoOH8Ia31Ew9jG9+
   MMxlrL9el3Y2jp117JlXwUp+gJzOrfDXSRqgcCXRyrQikEQKVaUQVbk2X
   A==;
X-CSE-ConnectionGUID: Jmxftz2PR56n8j7E9LQ80Q==
X-CSE-MsgGUID: wmuz08cjQmGUnxEVcraumA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63092047"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="63092047"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 10:15:30 -0800
X-CSE-ConnectionGUID: Fv2pSZtRSFGRTFQOBh6txg==
X-CSE-MsgGUID: Vd3LKj4SRdesOvWBn0nO2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="114439332"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 10:15:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 10:15:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 10:15:27 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 10:15:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ek0DrP7hG29GWT0sNA2lvrRvgMDEOeepbtxHlyK970LjQ5F7VS+kWsclDCzDojZGIHi1fXGUjLenbWkvEr9HHonwS/FQqRFWRWjGIud5BEOcMaX/BW2MyyCJF6/wR6P7hpPs+3jCmzMxnSSqGaRNdAJaKzsp7RDmi+jUXE1Zz1Md3TUGU4bPRh98WTaIb/x9L+tRDMuVFSv02r078QpM9p/kj8VORFKOJ4A+m4dexNAhRnZiKHQTfQ/+wXCfVNdKWO885EJHWHTli+V9y0AwKfopHHnITTcDg2v7DSbf46lPSZgs5baSndEnhwaseAb5E/wf/5XOqq3eTn2w+Fmeew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/zUAaypvbkHZDPgOEetGWvpLwmXmsIzG6KNaBrnaxc=;
 b=ufm6JtAsqyVRcKvKIA7vDU+URPCJkqPodgerQ4vrxh6B44G3aK3Atkvgyteiq/v4zAT4o2/otxy5c9aI4j/NDpillTKM11QvtywCs6AmhMiDeJt0CepLdKnvImSrjY/zmQ9qFjRdKwBMmuB/pshQ1jkoM++Q1i4m/t4xyNDMZYWONLbUMZ/dFtLIG0KZdH1VRBb8bnrNu0w5nKS6T8suko1mX3RubsmxIYRTdd1d4KUwkmLuFg3vJPrK+QBs7TUURLSNaextIYecvc0IHiM0qyBALfgZ1boz/Mjfr7EmkEpaGbuXNC5Kk5aYi4ln8n9VmI+rcBbwX5QuKgUiw+7Swg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8371.namprd11.prod.outlook.com (2603:10b6:a03:543::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 18:15:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8445.015; Tue, 18 Feb 2025
 18:15:02 +0000
Message-ID: <81e3993d-2f00-424b-8cf4-341c321149cd@intel.com>
Date: Tue, 18 Feb 2025 10:14:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: <babu.moger@amd.com>, Dave Martin <Dave.Martin@arm.com>
CC: Peter Newman <peternewman@google.com>, "Moger, Babu" <bmoger@amd.com>,
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
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <bdb48b29-92cf-4f98-b375-25ec84f0941a@amd.com>
 <Z7R9VedhOSp64W7X@e133380.arm.com>
 <56a48b63-7625-4d90-81bb-29a1eb588871@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <56a48b63-7625-4d90-81bb-29a1eb588871@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:907:1::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 37095f83-88a1-4947-e3c6-08dd504829c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGNxSWdhVUxSWkNKOFpWM0lEVWVYeGNmVHdvTnp0bWF6NXdwUFlOazFBQStE?=
 =?utf-8?B?Zi9ub29VRCtHN1paalMrVFBqeWNEdGRKbmh6RHViVTBJZXZtQURJRXVKWmw4?=
 =?utf-8?B?SUdRU3JiRWlrNVZLT2lXQnU0R0dMVEVBWmZoV3FNSjV6dVJBdkxrSU83blpC?=
 =?utf-8?B?Wk03a0Faa3BFTWprUC9GVitlU25lOEFpWVp0WGRKUjRDY3I2ZGM4ZzM5OU84?=
 =?utf-8?B?RlVMcGNTTnZSSmw0eDE0RGkvcnhpbFl0SnM3bUVUdjJWR0VPaytYdjBQblNB?=
 =?utf-8?B?UW44ZGRHRGxwKzllYTZHalNkY20rb2pkK2ZYNVJmRmtrbytXRnBWL2l2MlpN?=
 =?utf-8?B?N3o5cUNsdm10R3NpK0kwc2ZJQk9GRVpkS2M5REZySVhob1pCZyt5ZGZZZkF0?=
 =?utf-8?B?WlhxZHB2QnlwYjUrby9UZTZWUk02WWQ5K2FIbFlnOUxlZG1hNjloZk1TTXlq?=
 =?utf-8?B?WWJIK1JWaVlhYVJ5bXdsUUkrUTExR2c4eUdWTllUenQxbTlzVXdlZ1VteEdi?=
 =?utf-8?B?elVqY1FjQ2d6ZTBJK0FDQU9leGVvekdOVDZldEl0bEpFTVdKUENkb2EwU20z?=
 =?utf-8?B?VFFVZ083a25abmZDV1czaFRod2N4clEwd3JqYW50VERNNGVVRC9sVGhxSGRw?=
 =?utf-8?B?WnkvbWptMVo4WUtxTHlpR3g1cStkSnVVODR5N0tPSk1XTGJnMEVOcytReXNL?=
 =?utf-8?B?dnpjRmJiejNDaG5SQ0lXaWVSTittZ0FTeHhFRWd5Y0hjNW5BcUQycTAzRnc4?=
 =?utf-8?B?NDN4VzhXVTlSenY4OVhMVmZiRDMyNHY3OHBRNytVeTdEWnIramVqL0NTYWhl?=
 =?utf-8?B?QjFqQWFpb083KzJjYnNPd0VhRkJTK1lPZGpYazVHS3FVU3ZwZUtyR1ZlNWFF?=
 =?utf-8?B?Y3IrVU5zU0dWL0xWTVlXZTVpWFNEK1pJVk5Hd20wUStPM0FvMUcwajZCNFpM?=
 =?utf-8?B?UXljY2w1QzBuTjBZTWJpTVo4RHVsV0tCRmlQWkdkOTcyejgzZzh2cUpXeXpq?=
 =?utf-8?B?dW9vSjIzeHQvSEllWXpkdmVWM2RXeGszY2lwRTFOdHdFc2IxcjN6NDNOMDlm?=
 =?utf-8?B?NXNoYWtUc0t2bXg3SmxZN2pWZ3VRYStEV0M5UXl2d0JDb0FMWkdmQXgzZzJB?=
 =?utf-8?B?OVdtbUt4czVXQ3dqbzVweThVUG5mRXc2ZEdiWU5YbjBoWjcvZHRFem1Za1Ri?=
 =?utf-8?B?NFpKSnVIQU9jUFFSbjVyZjgrOTZYeTFmTytBY053cit2Y1ZlbmFBQkNGajlh?=
 =?utf-8?B?NDA0YUVmM2p5RFduUmh3cHU2dzNVNzg5c1BxNUlETmFGK0ZOU0Zpa2M5OHhR?=
 =?utf-8?B?UWtHelV5ait6M25vRlN6MHM0eEczYisrWk41SjM5M0NJVFNrUlh4Rno0TEh2?=
 =?utf-8?B?THF5UjBKZUNoenBTRGJyYW5rR284TTZVdkpmOXE0NHlWTXZVT1cxUndud280?=
 =?utf-8?B?WjJPVkN6SU5WSCtUMm9IUUNDakdoU2M5WnRSTS9acE82QS9USTV3bzRibjVX?=
 =?utf-8?B?ZGxYSUVoK1NnamdPL2RLOVkrQ0p4OHBFNkVXK0F0M2QrZlArekVDUmp1VWJt?=
 =?utf-8?B?MHAvN0w1eHRtNFpMWnJvWXpDQlVrcmQ4eHhNNHNHcS9pV3NjNmlkUVl3aUNQ?=
 =?utf-8?B?bXozYWVCV01GTFVQdE53cnhRdnlvZW1YODMwb1dwS1Z6OW5hQzFBVFdVMlND?=
 =?utf-8?B?MnRKZUc3djhULzJMbVEzVnVkdDBJY3MxRmZmWFh5WVlRQk14bENGaTlFdURK?=
 =?utf-8?B?bnBHa09BdzQ5eFdMTVFYaWR0Tmp3SWtYN1g1LzhWYnMxYnNMV1pUSUVLZHg1?=
 =?utf-8?B?bHVEQW5VUVNGb3VyRll3M2hCcjNNdUZucE9UUnptT1NINC82V2o3QzVtR3Rs?=
 =?utf-8?B?U2U0bDlpaHJ2RmxwdFh1OHcxa0p1TElFaHhmRk1EQzJ1NlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHNlOXoybDhDZ1dMRmFtZWFFbmlqMlV4R1dWa3ViSTcrbFRjK3ZEUUVZSHJW?=
 =?utf-8?B?Vlh5cDVKZmZGYU5JL2IrdkV2NTZEbis2OWFnejBvaGVoUitsWUhMM0hWbHdU?=
 =?utf-8?B?akFTY2JXY3hvSmo3MU1SaThVc09vcXc5RXpjaGQ3TEMxWVlweFNFNlR1SEdY?=
 =?utf-8?B?b3hGV0JRR1czRW5sNmlBVlpoaldqaE1DM250bTRiNWF4RFBZVmhNcC9ieVhB?=
 =?utf-8?B?UFZ1QVZTdmt0RERTdFQxeEJVTXQ2eGtFM3VFZDNEbVZTWFR6VnVGVzJwZ0Ft?=
 =?utf-8?B?UkFHTjRqZ1BVZGp5SDA3RVhQNXlmWFVWTjEwSjVhNFJ2YURnQ25TalU3SGhV?=
 =?utf-8?B?a01LOS83cFprR2V0d3VZSlFkcTlRdHpVTTFoY2hLODlxT0pRU2ttQWFnY2VL?=
 =?utf-8?B?TjEzQi9BRjBpSTcxVTVQRVM2N21wK1ZqNlY0V3hYYjVIVkMwRktyRE5iY2p5?=
 =?utf-8?B?VG9qRi8wTmozWWNSWWxjR3ZWV0RGYmR6bnFPRkhBZ1g0VzVTdnJaTW4vVFhP?=
 =?utf-8?B?WGpKcmx3d3Z0SHkzQnFLQ2plRmZMREs1Ujg2YksyRnNvRjZFWEo5ajk2VTRO?=
 =?utf-8?B?UXNJbzJEVHRacTVxMjZUL1dYWDJibCtSU1MrL0I2NDhkcEZCbE8xYW0yTXVK?=
 =?utf-8?B?Z0pZR2p6MXBkZ0ZVT1ZnUjVDNlBUV1RGSEswbitTdTVwVTU1ODVhYTR5U2Zn?=
 =?utf-8?B?VC9PaDRZd1hmdVRQSTRhdE9tQ2JhWUdOK2MyeUlEN0N5MmpkQU9lVFBFMGZ0?=
 =?utf-8?B?WU5IQVF1K3NucFFsRXUvZkZDdS9rQTRRMGhCZ1JZQ0MwalBNRk14Mk1IMWJK?=
 =?utf-8?B?KzBWSkxTMzltZHdCN2dYcW5lYVJWaU0vVGZzM0tXTmpNbm81dXg0VStuTS9R?=
 =?utf-8?B?YlRXNWZCR1hGVVB4R0lORldHUW9rWCtMMzNvZXRrS3lGaXAvQml2Z1lIeXNV?=
 =?utf-8?B?YkFVdzZFS1JEMWlId0RrYTZaWDFXMGd5Zkl0b1kxVXJ6M3FzbjJLVFI1RDNN?=
 =?utf-8?B?NG1HZFpLb0lLa0V6cVJEUWZOemFpTmpWanlhd2MxNkFwMEpTUU9xMEdqZUFy?=
 =?utf-8?B?MklVT3I3YlBXLytzaG05a3JMSXhlSDF6bnIzY01oVVpjaTNqNnVBVW1HalNN?=
 =?utf-8?B?Y0cyUTBYV1lXeWNYUEpUTjFPbDhjU3g0bktsMHE1QldiTTJQeldQWGtMTlZQ?=
 =?utf-8?B?Mm5hbmdvNzlrRkZXQ3IvTWhwWFdzcWFiQnFCTTdyVnAvanRCdkZOc2VGblJC?=
 =?utf-8?B?S2g1WEhHMkliM3N4T09oWDh2dUlGZVAxY3BBaVIvUEtyM3cyVk8xWVZQejZM?=
 =?utf-8?B?cGxORnc3elpoSDVUWGQ5SEVYUXVSdkdkUjFmTFcvL0ZIcXBFUWxqUkFXcDZr?=
 =?utf-8?B?amphSjIzenZvQzB3dzVSUEh4UVR3Y05MYkVXSkFiK0JXVVh2ZVBtendjNmVa?=
 =?utf-8?B?UWhQR0JpVXB5Ykk2TXZjVFhOaUY2OEhJalB0VDZ1aDRTRFNJMXBrMVVlTnJv?=
 =?utf-8?B?eTRZQ1ZmNE5OQ2o5UzdPNE5KNFFTMnh6RnI0OG1DWkFqNVJRMkgyWXRkNWVi?=
 =?utf-8?B?MDlqSFEwdjBFL24wYUc1akphYjM2azhubUNDOEp4NkRzNjZ1Z25rWGt6QzVG?=
 =?utf-8?B?NGY2M1djR2duczlGNG1BVEpna3l6S2RaUVpHYnpXdzZSUlpIZS9mNmtTTG40?=
 =?utf-8?B?K0RVdm9KUVl6azFqTG1NZnVzeTFMdG5KOUh0STUyQktsVUhLWi9sbU9FYnV6?=
 =?utf-8?B?cUhyUkxvOTZ2ek5RVytyU0xUU1BDSDBVK3hkY21HYUJWUnA1RlBBUDR6VFJo?=
 =?utf-8?B?d3kxd09xY0VHeFpYMkpsRUxlZm9uZnVVUXRFQ3V2cG9NOXp3czdqYVljU2hP?=
 =?utf-8?B?emZEcWM2WVhDc1VPa2pEazRScEtLemZvMU1XVWptbzdZUXJPNEI2V3dzTHRy?=
 =?utf-8?B?eEF2bm16bTZvdVpuLzI1TGRXWExpNnI3N0lCY2dIcHIxN0ZhNzF5SGhsVlR1?=
 =?utf-8?B?eGNqeUR3SFI5QWxyWlJHaUVzbEtwYUtsekxQaW10WEc5NE04NjhlQUJQMWYy?=
 =?utf-8?B?Ykl5TXY3RHExU2pnblV3Qmg4dHFOWHNrRzNrOElVbzFWZ0dqTXArb1VkUHU4?=
 =?utf-8?B?T2Z2cHc4OGdpWFYzdGVWTVB2TWMrWDllNVhLT0hMRGdoelJhSXlLQjBBMG9s?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37095f83-88a1-4947-e3c6-08dd504829c2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 18:15:02.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtLC4uRFp9aIP58H8guH7khMEByPQiVnbytJc9eepQm1UUDTEmwbvus2Y8Aig0ZdqU8ORJdYXXrEhzA0KSfVfCB2LN8G5adXLKRIFCSVcQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8371
X-OriginatorOrg: intel.com

Hi Babu,

On 2/18/25 7:39 AM, Moger, Babu wrote:
 
> 3. Use the actual events instead of flags based on the below comment.
> 
> https://lore.kernel.org/lkml/a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com/
> 
>  Something like this.
>  # echo '//0={mbm_total_bytes}{mbm_local_bytes};1={mbm_local_bytes}'
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
>  Are we ready to go with this approach? I am still not clear on this.
> 
>  Reinette, What do you think?

I was actually expecting some push back or at least discussion on this interface
because the braces seem difficult to parse when compared to, for example, using
commas to separate the events of a domain. Peter [1] has some reservations about
going this direction and since he would end up using this interface significantly
I would prefer to resolve that first.

Reinette


[1] https://lore.kernel.org/lkml/CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com/



 
 
 


