Return-Path: <linux-kernel+bounces-349851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C096798FC37
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 04:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77933282475
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB351CF83;
	Fri,  4 Oct 2024 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lg/7u9wt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7218C08;
	Fri,  4 Oct 2024 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728008255; cv=fail; b=WUjgsItX3BG2CD1YdcN+qd7Wi4DQ9+QcErmr00hoBXNv1GFpjsSfj9UUlBPjIAvJ7gDwIZ8N4QbiwKaCE8AfKVMj3HZ3639qCFKpQvLpFifmbn3xicGMy/sFsjNoxXOV0x2qkve8COHh1wK7l+yjJMrrj4ZyJm+1FYGzZT2uULM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728008255; c=relaxed/simple;
	bh=b7V6xZHAzUwd07FpFg7k5HPi92YBXbRkwHCCVZsf3aE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mPiDarrrAXqs//lqRDmIEFVIAKDR25xw7rh/LUvcNecm66lKGXaGY6OuynTVQ/cEDpYhjpnZzG4DuJ72hFOVydezOv8cuB4lCnMHzdTOTK74QYfIHoxlLuUtQJma1f5kDgKoY48fzXLU/UWewamHoc9jPlZ3xSQzrAHQ7ugel5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lg/7u9wt; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728008253; x=1759544253;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b7V6xZHAzUwd07FpFg7k5HPi92YBXbRkwHCCVZsf3aE=;
  b=lg/7u9wtd8Tg5OtvZkAjH/tj2GxFN28edpVT0quNztU83OLI4YJK0qOb
   SrMFA3xt1uGdPuFMQvei61EdBKUFDMHEXLIlmdE59qRM2KHrFieEoWHPY
   RXY7aP+crKtM/L9y817emOzitSLEbhKVmLe0C5ymMIT1xEoCgtTAprmXn
   i7EGym1SdjAeNQsy/ldIy6IHgDMM5VXyCAzrOlwbXADGTSjVFZgA75jEB
   EpCoPcuWEEdPamd3VaZc+3aQhUXHKWhzTwGWiGtP4Oo4POk8xtKnrETOG
   2aTXDlZpUdaQqiCgRQgoAczpn/JQ4XMuHp3oH4adIYDeDm22O+e03ZNAN
   g==;
X-CSE-ConnectionGUID: vmD1loaUQXy8vrOqdVX7Dg==
X-CSE-MsgGUID: Avf6NVwVTA+l04DL9BSewA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27104391"
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="27104391"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 19:17:32 -0700
X-CSE-ConnectionGUID: 9s1QnV3bQFWDHeQjwvW0fA==
X-CSE-MsgGUID: N6AW/NCkSOOquXdDKA/dOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="105305463"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 19:17:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 19:17:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 19:17:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 19:17:31 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 19:17:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4OqAJhOrh7FQmhmSMOAI3odp4Oo1hTNhBQz46bjxaSo8LZ+fbOk8RZ9a8w4t3xe4feT6UAMrWoCbqMkSx2lxDicAUjihikQG8Fe6cpzA4ZWTcL/QqjHUF4eI/RgN44XTfUv87kNXMAO941H52v2+xwI0NenCaJ/d81DUdF4re7v8GN7L25c23vsChhVzqNFvGjwr9rcjOaAHZwCL/ZRXvYF7b8sEev1LVgLhp3MGYfNCrBB96VJ+eom3MlV91TCKuAoP8lARwvui/zMwQfO2ocd+/n2pdFLZMzPVou6RaFeCl8UeFTlO40cdMisng78Vr2LdtVIiGWxN434VEuWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGT9rlsS1vGWSFqYSqfPvGRl56Idtbat1dntfi9TSx4=;
 b=tWISuJbQFKkppYWVVJlpdhtqw/6KZtplWgeNobk4StxHmF78ONeagkdVTkzkIVqplEN5pKAdaPUTsbJJcMuEn0IiZ60ZR4m5C01pMu+9bxX19U8MU2IGqgBBQa4AhhJeiTfD8z0MW0ss77nUZLoMf41cpdWBdPleHJU2Vn63zr5puDJPZ6aqbUT57BhNlHUtWa3lugQ9l8w4IoZnZWxF/pV+IVr/kf0kz6vzjyHarTxhspurcvePOUbadNqqjcSD6LCBzzk1RwevOSCRcZksvMkrUItVqdS2dAY3Jh3DL6GJZCM0ormWR4V9ozPDcfEz40iLJB9HQNxIGeXPjpOybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7512.namprd11.prod.outlook.com (2603:10b6:806:345::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 02:17:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 02:17:27 +0000
Message-ID: <33c56f32-4e56-47b5-890c-fbf1d45d7213@intel.com>
Date: Thu, 3 Oct 2024 19:17:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 22/24] x86/resctrl: Update assignments on event
 configuration changes
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <ff0cd2a73c78fdb7487632381b4aec642a0af5ef.1725488488.git.babu.moger@amd.com>
 <384c2074-0076-4686-bebd-ba3ac3c05188@intel.com>
 <f77737ac-d3f6-3e4b-3565-564f79c86ca8@amd.com>
 <d2147cb6-9d1a-49af-9be8-5d788ce7ee7b@intel.com>
 <c514416e-4320-3826-21dd-7e79ebc83351@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c514416e-4320-3826-21dd-7e79ebc83351@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:303:2b::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c523cce-b8c4-4e37-487c-08dce41ab102
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlVnZEI0czh1bFZJeDRGNVBiUVBBaWNqWEt4cTlRQTRPWlk4K2xBZVkwdUpD?=
 =?utf-8?B?OHF4NitpRDdtR3Z0eWFxZmNGMW52QW5SbFdhZXJzN2NJejRrYnVsZ2lrMUlr?=
 =?utf-8?B?bnprUTVMWW5odk9BWk9naHhzb0JDT1RGaEpJMW1mbXdVSVhxek1KOEZva2R4?=
 =?utf-8?B?bDc3Ri90ejlHMXFkVFNSWFI5SlI1YU9BRFByU1RoSlBGUFBFTTUyY1QzK2VR?=
 =?utf-8?B?QTdRVmRkRWFEN21qZ1RKMmxaOXAxQ1VaWm5yZXNNWTlxRWtlc0hmUGFpUS9a?=
 =?utf-8?B?eCsyc2VoY2RIZlhPVHZTYld0cFVJZUtyWDlnTmM4RXNnemM2a211dk1tdGt5?=
 =?utf-8?B?RmtmQ1RWMTI4RlAvaEcvaGplWmFUZHF1cDJLZHBHamF2RVZRbEIxcmhiUFJE?=
 =?utf-8?B?cER0aGUvSHArZzFXQ0FGcTc1cDFQRkc4MHQwYUxyV051dVhka0ZXaHhmRWk1?=
 =?utf-8?B?WnVrZ0FnWGVNR0xlMnBYVXoybWVLTWZkMnorNko1V3ZBSUVXbmFkZzZ5SmZM?=
 =?utf-8?B?UTNBbS8xUU54Zk1jQk5zNFNtY3hmcTJrTHp0Nk9tZ1VwNFNsUjZjSWgvZ3Ev?=
 =?utf-8?B?dG02QWpZY29UNzEzdDJUL0RDZ0JBbFFFS2pxY1lCNzJYTFBTRDd2MDFsYjlD?=
 =?utf-8?B?Mkd0MFFQUHpsM2xiNVErNGNTejVjajF1bnRocUdGYndmTlN1ZXd0Um1mWHNP?=
 =?utf-8?B?dlBXdXRlRE5zSFh2SXQ3MHpCRGFtaVpTQkQ0TkFNd2NjNlJsQkl3WFZockN5?=
 =?utf-8?B?Ym5pUUZrNWxTbVBGUjJzSysxRlNnV2RFL1k5bmluWkpZK2pEQjF1b1dONmJP?=
 =?utf-8?B?QXo4dVpFVWZJUE1BcGZGZFN5MmwxbjR2TWVXOS8rdjhOTDNWRXJaalFPV0pH?=
 =?utf-8?B?aVBkQnVoQi9mMUlrd1lMM3NZS3I3d2w5S0xtS0gvUTB4ajhLUGtsM2t3RnEx?=
 =?utf-8?B?ZE9CZkxXSGVVVncxWHRlSGdYNEUyN1VNYTBxeGZtZWFGYUlEOC9EWENPTTJo?=
 =?utf-8?B?Y1prYzE5RWNqSW5ySTFMcEpCZDBibHpTTlhCU0dtTnhhUXZYZkJ1cTl4cWd5?=
 =?utf-8?B?cUh1UUFWL04vNk54c0xGTFBNcjBpZ3N5dmxTYnV2M0lyU2NCd2NYWVV1YjRR?=
 =?utf-8?B?SVFLQzhPMVB6T09RYnNOcTZmSjlZbi83ZndJVFJXb0d0KzBxQiszMFhlWW1h?=
 =?utf-8?B?UUFmbGcyL2hnSGJpRVp6bW1ucU1OU0c0MTROY0I3MGlUTTRmNi9FM1FHQkFN?=
 =?utf-8?B?bzhRWEJzZnZVME5KYUJBSExXaCtuVFJseFRCWGtOeU56V3E2L2lNZjRTUE54?=
 =?utf-8?B?OUlTK0xzTml5YTdGUFRRTTJFMHJPZ3dMd2laOTZYQStYR25mL0puQmJ4cXpX?=
 =?utf-8?B?QlQrN01ZR2ZSYU9ZOTBheHV2RitPTmlqVmtDbElpcTJiamRud00xeWNETi9H?=
 =?utf-8?B?bjFuVnlHSGdKWnFBYTNRdzFML1pZVkx2VGlZSnlwbERQTS9Gazd3KzhZZWFj?=
 =?utf-8?B?dFVza05laWtwbjZlbE9yQnAxK29mTG9paFdkYTM1R2xsUXJ0TzFxWXVNdUxK?=
 =?utf-8?B?MnA0OWhFZG9xRGJueVFMYUpMNXNpdjNJOVEza0lxQm1na2dRNmtVQW0xOFVG?=
 =?utf-8?B?M1JNakkwUFdVSmk2TFM0T1FpdmhJNndGSm5YcldYblZWbE9sZ1N3MEFNSjN5?=
 =?utf-8?B?V1A0eFYxb2x1NjFxaWxGQjkwbDFiUFBKc0pySzRKR2NuK0twUzZJYitnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGpHTk5pMTlSb2VIVm1ad3dZd0VoWktzMTNQSG1XZWkwM2Z0RmFjMmlHNkth?=
 =?utf-8?B?MDRiTmxHOWRIQVhtNHduZDl4bG1rbWllOGdmNE4vSWhhZDdmZGFOcENxTmY2?=
 =?utf-8?B?cWw3clNibE1VSmpTeEhmS3RyV2hKZFZ4QkVjL1BGakdqcDYxMldwdVZpUFFX?=
 =?utf-8?B?d1ZhZ2w0SzBobFdmeVhwSDgxQWlsMDJva0ZsTm9wMDF3TEI4R0pWazFsZXFi?=
 =?utf-8?B?M1A3N2lQYkpzN3lQMTRXblE4YUpMbE9JMkVkbzB1Z2x4V21aR3lkWEtyQUVl?=
 =?utf-8?B?RldScTdzSG9rSk1MV2RHUzJpYWc4NjU3Y051YllmcVBnR1lXVTViQXJ3QnYx?=
 =?utf-8?B?WGduMkNHMW1obm9jVHNMM3R2NGVDZDRhUmFpL1NYdTBDWUtkWkFadUhtaHYw?=
 =?utf-8?B?RXY0TjE1enZFTnpscmorZWR0ckZISXQxWDRUajI5MFFUQVVFN3lFeFNLRVIv?=
 =?utf-8?B?SVlaa2cvbE1mN1BOc1ArWW5zLzd1UE1xVDA2UHZJZU85c0ljS2dUdk5nV1hy?=
 =?utf-8?B?QWdpVEZHczk4M2s2Y0ZJSksxM2dCTGlIR3p1WnYxK1J2R2Z0NVBWZG9lWHRB?=
 =?utf-8?B?SnVhSThMM2dwNGpzb2RRc2dZeGF6eDFURUdqclBPc1lYSEwwT1Bka2FTU1F4?=
 =?utf-8?B?ZmcwMWcyR3NzNEVXT1dCcHYyRGtHaWtlN0VwblZOcFQ4VGMrU2ViTURCUWp4?=
 =?utf-8?B?V1N6QTlrYlo1YXd4S3FZN1hVOTJwcktBNlp1SEQxcnlzUjhsZ09VdVU4NlFr?=
 =?utf-8?B?SllTSis2ZTVFYmlQalJvREZkUW5BLyt6OVFnRVd2dlNIa2xLYlRJcDJNVTNn?=
 =?utf-8?B?cmZ0UVNpd3lSQWEwdmZUWjZWbmxMZ2crWGR4RXZEbmk2TDBUbk5OT2hUMC9L?=
 =?utf-8?B?eEFaemZnTDNld2Y4ZkdrbytkOWpHTWV2YU4yL0JLclFIYmVMTmJiRkZ5RmEr?=
 =?utf-8?B?L3dmZkl6dExrdVppYlNScytSNjdWNGtNQ3NLaEFKeXFPdmpmb0NJTCs4TDZC?=
 =?utf-8?B?K3M0K1FUcnBidFlIZWNKSEdJeXgxYlhQVXlZVEFzaFgxcVlBc0tuR0xma3Fq?=
 =?utf-8?B?VGFHWmxhUkNXS2NuTUVhek1rbEdVdHZBU3c2cEFHcXUyNk5XWEovaXlGazFG?=
 =?utf-8?B?OTJ3bjZJbDB4MWw4TVVpc3kxYWZZeFpEOVkyajYvLzM2ZWxNUmxESER6Vzd2?=
 =?utf-8?B?YWJzOTY2QlRBNUlseW1GYXFycDJCSEMyYTREVER2RUM4K2dJcGttdEh0c1hx?=
 =?utf-8?B?QWtBZjZmdkhheWR3V08yd1RRYndWSWtHTmh6ajRMTUE4dzhwSEdyYk0zYUp0?=
 =?utf-8?B?UHp4cFRwSHl6U2JtamI5aGhZR2tuamtjWnNCQ2haUk1la1dZZ2F3b2JHaEhs?=
 =?utf-8?B?eFpLU2lwZDMxdU94K1hqNnFDaFlZNXdjWG9BMm9SZFNEZ0FaaTlMaHdIVXdL?=
 =?utf-8?B?MWg1eE1YaDE2Y0FULzI3OU01dWZDbC8vS056VUFuUXM4N3VGbUx1aWl1clIv?=
 =?utf-8?B?blRpaCtPL3hxTkZIMExEUkNUSW9oWmNWSVJ0aEtCek5lMjdQOGhCcm1OeXl5?=
 =?utf-8?B?OEd0WDkrV3VtcjdwUWJNazVVL3BsTnNWbFZMN1hpWkdBZWE4c1d0Y0lLWU1q?=
 =?utf-8?B?M2E2bHMrZTlkcmVXdDlTZzdmeUVDNy9mOGxLWWpINDJBOG1GOG5BekNwUnFR?=
 =?utf-8?B?aDRaN2Q2S3pEZDhlaTJLbTBJSGJJL2JBQnIwd3IzeUVhZlRFSFU0YUxGbE1H?=
 =?utf-8?B?SXhxemxtSTBLQWZCbVkzTFU3bTdkcy9GNUs1dmVHVlJRbEkrM3J4MTZmcEtr?=
 =?utf-8?B?c0lIdGw1WWptY0lQRDh5TXZ3MFJtNENwM3lBdWxuOCs5R0hObDhmalR3cTU2?=
 =?utf-8?B?ZlNvY0xQVWVBeE02YnczY2t1cEpJL1k5ZXR5djlDRXY5RFhoSHV4RmpoQzU3?=
 =?utf-8?B?WkhteUV0NW1YdTNqMkVMeVB6RUlBeDdVdi9RbWxyWVFUU1NVbDRHa3FaQjJQ?=
 =?utf-8?B?ek5UUHh6SGNjTU56Y0JYYVN5eURJYmxDbFBWMVY2WVpSeHpoWWhLWStuVkVM?=
 =?utf-8?B?cFI4d0RCT2xwSXpFTG5YOEZwK3JONkRsSXIxWnBWc3pQNXMweFRHODRpcGt4?=
 =?utf-8?B?c3dzb0Jsc0NvVm13MmlxOFV4NGpIR1NFMytWZ1NaUzVqMDUrek5YRzRwOE9x?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c523cce-b8c4-4e37-487c-08dce41ab102
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 02:17:27.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7O5ykASCC9Aq/v0YcvL5Ssipqh+5F6GvRLBLEcVcCmZ/FM4GdOUx7ze2MXrOyh43DJoUAswZd7rB4v2EXfKnUxQfVlm9E+QHHDteZPM/q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7512
X-OriginatorOrg: intel.com

Hi Babu,

On 10/3/24 5:51 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 10/2/2024 1:20 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 9/27/24 9:22 AM, Moger, Babu wrote:
>>> Hi Reinitte,
>>>
>>> On 9/19/2024 12:45 PM, Reinette Chatre wrote:
>>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>
>> ...
>>
>>>>> +}
>>>>> +
>>>>>    static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>>>>>                         struct seq_file *s, void *v)
>>>>>    {
>>>>> @@ -1793,12 +1802,48 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
>>>>>        return 0;
>>>>>    }
>>>>>    +static int resctrl_mbm_event_update_assign(struct rdt_resource *r,
>>>>> +                       struct rdt_mon_domain *d, u32 evtid)
>>>>> +{
>>>>> +    struct rdt_mon_domain *dom;
>>>>> +    struct rdtgroup *rdtg;
>>>>> +    int ret = 0;
>>>>> +
>>>>> +    if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>>>>> +        return ret;
>>>>> +
>>>>> +    list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>>>>> +        struct rdtgroup *crg;
>>>>> +
>>>>> +        list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>>>>> +            if (d == dom && resctrl_mbm_event_assigned(rdtg, dom, evtid)) {
>>>>> +                ret = rdtgroup_assign_cntr(r, rdtg, dom, evtid);
>>>>> +                if (ret)
>>>>> +                    goto out_done;
>>>>> +            }
>>>>> +        }
>>>>> +
>>>>> +        list_for_each_entry(crg, &rdtg->mon.crdtgrp_list, mon.crdtgrp_list) {
>>>>> +            list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>>>>> +                if (d == dom && resctrl_mbm_event_assigned(crg, dom, evtid)) {
>>>>> +                    ret = rdtgroup_assign_cntr(r, crg, dom, evtid);
>>>>> +                    if (ret)
>>>>> +                        goto out_done;
>>>>> +                }
>>>>> +            }
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +out_done:
>>>>> +    return ret;
>>>>> +}
>>>>>      static void mbm_config_write_domain(struct rdt_resource *r,
>>>>>                        struct rdt_mon_domain *d, u32 evtid, u32 val)
>>>>>    {
>>>>>        struct mon_config_info mon_info = {0};
>>>>>        u32 config_val;
>>>>> +    int ret;
>>>>>          /*
>>>>>         * Check the current config value first. If both are the same then
>>>>> @@ -1822,6 +1867,14 @@ static void mbm_config_write_domain(struct rdt_resource *r,
>>>>>                      resctrl_arch_event_config_set,
>>>>>                      &mon_info, 1);
>>>>>    +    /*
>>>>> +     * Counter assignments needs to be updated to match the event
>>>>> +     * configuration.
>>>>> +     */
>>>>> +    ret = resctrl_mbm_event_update_assign(r, d, evtid);
>>>>> +    if (ret)
>>>>> +        rdt_last_cmd_puts("Assign failed, event will be Unavailable\n");
>>>>> +
>>>>
>>>> This does not look right. This function _just_ returned from an IPI on appropriate CPU and then
>>>> starts flow to do _another_ IPI to run code that could have just been run during previous IPI.
>>>> The whole flow to call rdgroup_assign_cntr() also seems like an obfuscated way to call resctrl_arch_assign_cntr()
>>>> to just reconfigure the counter (not actually assign it).
>>>> Could it perhaps call some resctrl fs code via single IPI that in turn calls the appropriate arch code to set the new
>>>> mon event config and re-configures the counter?
>>>>
>>>
>>> I think we can simplify this. We dont have to go thru all the rdtgroups to figure out if the counter is assigned or not.
>>>
>>> I can move the code inside mon_config_write() after the call mbm_config_write_domain().
>>
>> mbm_config_write_domain() already does an IPI so if I understand correctly this will still
>> result in a second IPI that seems unnecessary to me. Why can the reconfigure not be done
>> with a single IPI?
> 
> I think we can try updating the counter configuration in the same IPI. Let me try that.
> 

Thank you very much.

>>
>>>
>>> Using the domain bitmap we can figure out which of the counters are assigned in the domain. I can use the hardware help to update the assignment for each counter.  This has to be done via IPI.
>>> Something like this.
>>>
>>> static void rdtgroup_abmc_dom_cfg(void *info)
>>> {
>>>      union l3_qos_abmc_cfg *abmc_cfg = info;
>>>          u32 val = abmc_cfg->bw_type;
>>>
>>>          /* Get the counter configuration */
>>>      wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
>>>      rdmsrl(MGR_IA32_L3_QOS_ABMC_DSC, *abmc_cfg);
>>>
>>
>> This is not clear to me. I expected MSR_IA32_L3_QOS_ABMC_DSC
>> to return the bw_type that was just written to
>> MSR_IA32_L3_QOS_ABMC_CFG.
>>
>> It is also not clear to me how these registers can be
>> used without a valid counter ID. I seem to miss
>> the context of this call.
> 
> Event configuration changes are domain specific. We have the domain data structure and we have the bitmap(mbm_cntr_map) in rdt_mon_domain. This bitmap tells us which of the counters in the domain are configured. So, we can get the  counter id from this bitmap. Using the counter id, we can query the hardware to get the current configuration by this sequence.
> 
> /* Get the counter configuration */
> for (i=0; i< r->mon.num_mbm_cntrs; i++) {
>  if (test_bit(i, d->mbm_cntr_map)) {
>    abmc_cfg->cntr_id = i;
>    abmc_cfg.split.cfg_en = 0;
>    wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
> 
>    /* Reading L3_QOS_ABMC_DSC returns the configuration of the
>     * counter id specified in L3_QOS_ABMC_CFG.cntr_id with RMID(bw_src)
>     * and event configuration(bw_type)  Get the counter configuration
>     */
>    rdmsrl(MGR_IA32_L3_QOS_ABMC_DSC, *abmc_cfg);
> 

Apologies but I do still have the same question as before ... wouldn't
MSR_IA32_L3_QOS_ABMC_DSC return the value that was just written to 
MSR_IA32_L3_QOS_ABMC_CFG? If so, the previous wrmsrl() would set the
counter's bw_type to what is set in *abmc_cfg provided as parameter. It
thus still seems unclear why reading it back is necessary.

>  /*
>   * We know the new bandwidth to be updated.
>   * Update the counter by writing to QOS_ABMC_CFG with the new configuration
>   */
> 
>   if (abmc_cfg->bw_type != val) {
>       abmc_cfg->bw_type = val;
>       abmc_cfg.split.cfg_en = 1;
>       wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
>      }
>  }
> }
> 
> Hope this helps. I need to pass few information to IPI to make this work. Let me know if this is not clear. I will code this tomorrow then it will be much more clear.
> 

ok, it does seem as though I am not able to follow these snippets and seeing the
full solution should solve that. Thank you.

> 
>>
>>>          /* update the counter configuration */
>>>          if (abmc_cfg->bw_type != val) {
>>>              abmc_cfg->bw_type = val;
>>>              abmc_cfg.split.cfg_en = 1;
>>>              wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *abmc_cfg);
>>>          }
>>> }
>>>


Reinette

