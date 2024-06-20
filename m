Return-Path: <linux-kernel+bounces-223594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB70911558
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D610B213D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934A078C67;
	Thu, 20 Jun 2024 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XC2a/jb7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505473473;
	Thu, 20 Jun 2024 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718920958; cv=fail; b=dNzbCKW641LrDZRrAtAy0hPdlcxtsWj6vmITeTHBhkRsqeFS5MNFYj6DcdxxdvphGX6Rm0toUeHlU7lRb5G3cbeyThP+DlMo3BkH/ONl1tK2zYwSgC/xqp5DqS9SSfDZe6uyfBaomNxyLktuHXToCSkp8MfgfKwMhZbUAB0YguM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718920958; c=relaxed/simple;
	bh=oYptXGb9aXoEUQPBtu8nj1TqQxe3m2zUWM6QxK9succ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JOxELMMSu65CFr1bbcaMMZIRLvktxWHf+qtIy8VgYAV4k6Bq4d5bccQ/US2/xIbql+T1DkjojjWoirdQXHsKdbCgAkz21UN6/84CQQAOesjBIH4su99M6E8nl5N7cfgr2IOZIbztQEg1N4j/8dhJh6CPj18Z4uECM+8YjR1SkJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XC2a/jb7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718920957; x=1750456957;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oYptXGb9aXoEUQPBtu8nj1TqQxe3m2zUWM6QxK9succ=;
  b=XC2a/jb7XWCA7ERaHwojkl/Ycsstf6Hch5hmwp3jzM+T45sWnn6xSGPj
   5qY70YBxn/P3Jt+MDI75OApt2GET1shwUjBg7vgf/5zDswv610D/q8cf0
   iSScCn7O7AVhGdbPPewo5cpFZR1kZdkS4Cg0ErXsgtWlodqW37aO+I7Or
   tX3FYY7ajz8+WcKuBzJqu5IvkaRTNLk0kcz6jN3rFYDz4IfCfpKWRp38c
   gN8dHai9YzlJoT/wLMl/VQ53sJ9BBG9Wa6jhpJmWqOm7XnDv35SXonOrx
   nk9uC4Qe0FFdhQmG+od8i3kIM3w2+zn5ROhgnYJ7PMfKZIHWkGv9lkuOR
   A==;
X-CSE-ConnectionGUID: erxXYSVrRFCgDcG5dixVdg==
X-CSE-MsgGUID: aPrzYtKzSBqvUGcmRFPnuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="26528437"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="26528437"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 15:02:36 -0700
X-CSE-ConnectionGUID: uaSEGlBVSny+kNF+9uoOlw==
X-CSE-MsgGUID: jnhluVRRT5C853/Iii5mSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="73594507"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 15:02:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 15:02:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 15:02:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 15:02:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpAXFx2mtIQs08BTQjcgBWYlE5Tp3qx7PcW4K03LKHD5fBGHF22E+xKdW256kRZX/Zq40nOxbuHl3gMHDO9B1YHW774G5/zkN7FCiGClbujqXRO3AbjzwZqru0KDz1Zpahd+AXZzf5nfS1vitfLp3MvRIVxUG41yNCMcqwqFEysGmo1SdhAhkXE+Efc5+XUAtzUYoR0PSWiG0k3/pqvmadNCK9kGS585iLTEUh4QzgQHURQEEJpcWGraJ+6fEss+TsklaTTOTCppHnRP23z082j4/o54+EwKqlK+4MNUnmM6DVsDLzk0l5gXJTdqsmIKJb5SHluFfUr2i1g42eYXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfCFmPWzTbFyiSBLrDZGZi41oYGmUueC6DAmd3ZxcrE=;
 b=iq/N8C/K/bILCL3r9wXtt4AYwL60hqUAwBxIjsxwvNAOK9hSXoqzvrJ/SO38oHw8aTIdISVcRGMj3FSF4XwfTsdKi/R4YKm94Jrjljr1zUAvGSrpQySA7ONb6sCe9M/dW6MftnOgfFLaQaw8a/cXDNU0OspwmYa2k+LpqRpCRlOnHv7F+cKvUDqH24xVRiTE2dcY+0jNwLclyKKxuQIGwSKPnCWcgNHiDCJPZJD1IJ4QkYCBcBTJK0PcvGC5rMgC2Q/F8F8FcqaEvqy2h+OVV3AYLALK1JX5ctlT6tBm7V7m3xJqz3kaV2kjv0k9e073MGxUkKRs9XRWtQFr2HZ/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB6877.namprd11.prod.outlook.com (2603:10b6:510:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Thu, 20 Jun
 2024 22:02:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 22:02:14 +0000
Message-ID: <4a072745-11d1-4903-896b-c1544ceb692d@intel.com>
Date: Thu, 20 Jun 2024 15:02:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/19] x86/resctrl: Add support to enable/disable ABMC
 feature
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
 <e4edf1794852cff132b17c8f061f24799d9e79ad.1716552602.git.babu.moger@amd.com>
 <28cd2683-2ab5-4772-8597-6aaf0aec1f0e@intel.com>
 <a08d4234-651c-4ac5-9cf8-96a4461c71ce@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a08d4234-651c-4ac5-9cf8-96a4461c71ce@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca7a87e-e5fa-45f8-b166-08dc9174a48a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emRjOUFkcTRFMWF0clN4SVQ0MU5HYXZPT3dzTy92eDlpeXdBYmFBTUFlMHR6?=
 =?utf-8?B?aXdlbmVuSEdERzlUT1F4RlBhZE1ickVsM0RKbUkwZW8rb2dMcXBBZU1pSXdt?=
 =?utf-8?B?Sk9QUmcwRkNXekIvdnphNm12SG5Gd0U4OG5jdHloeXdDc0trcFVpckNMS2pu?=
 =?utf-8?B?U0Qxa095cFNWT1llNzhJVzVoVDl5czBqZUtRbkx0YVluSjlTaHRCdXBDU283?=
 =?utf-8?B?K21BRFExS3VsdkUxZ3MrWUFlQkRUdUVUVlcySGwzODVlSWJVSU5YaE5GVUpW?=
 =?utf-8?B?RTZCSG9tU3NLVDRSRE1wWFZtMnNBQU9nRlNUTjdSdXRVTWF3OUxIakwxdWdp?=
 =?utf-8?B?TzlBQ3lDOTV1WHBrcjJVd3ZOSHJRdmdQcTN2TTkxL2NkN2sxWTNUMXZXU1pk?=
 =?utf-8?B?dXgwS0YzdnU3eTdDOUhOVzJlcUZ1SWxHL2NROEh1bjcrRFA1Y1ZWbGtqNkRF?=
 =?utf-8?B?OHRPOE1OZ1ZQRlJERmpSMHRUdURIRTVLRTRZUDRBWjNVaXBSOXp3QUM1UGxC?=
 =?utf-8?B?Y1lsS2NudlcrYmVTM1ZaV3B3YmhlLzlOQ1I0UGNQbFg2Ym9wUTRvNEpIcksw?=
 =?utf-8?B?dHhVTFZvUVkrNWQrVFp3VlhwbkxHQitrSmVMVnd3cGVIM1lEY3gyemxyTWRF?=
 =?utf-8?B?d09NZ05JTmNmVDdwT1Z3Z3JTRThRRkxxMkYwaEhDUmpQNmpUR0ZwVi9qZE0r?=
 =?utf-8?B?Y2FaN21YNnIxSUFPUVZiTitQTm9Vc3c0MUJpdDB5ZGl6T05UTUE4NXRHSUdC?=
 =?utf-8?B?V2ZZM1FhS0ppQlpodXhoaUQrTDR6MU5ueFBOU0xOVlZKYk9tVFhJUm5sR1hz?=
 =?utf-8?B?aTN1UE1nL1FJeXFnaUM5OHBUZnpnbUlSRnpmemczOXB4bHBhVmViTGlGcDgz?=
 =?utf-8?B?WVVFOHNIRGlLS2xKQ09rYXZQSk5BWXZUSFMyVHlIZHN6VjFmVXNxQnBabGZC?=
 =?utf-8?B?YVBjNnUxZWgvOTc5dkRINWJsR08rK2Nid05mQmRuUy84OXNWM3pzQjJXSFdX?=
 =?utf-8?B?QU8yY252eE8yNTgxUG52NzRLc01XUlV3MjZpb0VNQVFqSEFBMW16UDE4SWlm?=
 =?utf-8?B?c3ZZSHhIZ1p2enR2YTJ1TGtrWjRLYW5TVFZnMVJBQXUrRVNQSms1eXYvUity?=
 =?utf-8?B?RkM2ZWNtTG92Z1FYZzhIK3BuSXRzdTk1dEZ3RzdKWWRyYnVBM0k5MXRMN1dr?=
 =?utf-8?B?UEg2ZklodVRuMDhXL0ZFSU10ZDhyc2NHNmlPNTZjc01qS2xCRHBFVDA2SHpl?=
 =?utf-8?B?ZHc0R2EzSnhUbTRaVGRLL2xPQ2RUUGJGMGhYZWVBaG1TYWgwS0tSb0lmM3Fn?=
 =?utf-8?B?L1Y4amVoM3RCZjRIVkJTTUJXSnltZ0dXQVdyR1Ixd2J3NGg4UW5lZDZwWkFz?=
 =?utf-8?B?WEV3T1hUZDBuUzZYQ0xBYzYzeG9oNXREUHlCRElHTEJNU3VKV3RJTnJtU2pm?=
 =?utf-8?B?bENycExLc1NjU3RuZnpRQXNyQWJqWnU1T3JYLzhESXJ0akNvd0JqQnNoUmFR?=
 =?utf-8?B?bHdEMXcyTThhckoxeXA3WWl6R2NBcmNBaURRTldYaDQ5ZGVqd2ZNcGtZQzl4?=
 =?utf-8?B?bkVER3ZjMnNMb25sSCtGb2xDSHIzNStDTDZRRGVEU09TaWxJOHQvQ3B6TjNM?=
 =?utf-8?B?QjZJRHVSZ3AyTmRkUDl4RXRFRWJXeEFIUFBPd1JsQ081cVF4YkwvN1FDL1RH?=
 =?utf-8?B?UHFWWUNyQUxqQTlmWmNJbTQxaWFDRVEzbVdyVU1nUGxWaFR4NHNsTmJldlZM?=
 =?utf-8?Q?TmKUhJmSvJXX4aZwnezn9i3ERLtiLQVM17eKKzC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nlp4Qm40dGM3RlVTeVZPMGVJZ05VYlA2d1NXVzk0VCtkam1KS1ZOa2szUkR4?=
 =?utf-8?B?S1pGbi90MDUzRHF0RERHK1NyZFRyTk9LRzB5MHN6dm93R0JZUm1uWkY4SlZV?=
 =?utf-8?B?enFVdml4SDJQODdQSi9JRDc0aEZOeWkrQUdoTmNZdHFQYW11UndEbUo2cytW?=
 =?utf-8?B?NTFIQ0NOUW4yZ0xVMGxnc2pQRktnVEhIN2dpb0phWVFJa3JvK0h5N0NqVGxO?=
 =?utf-8?B?dWQ0dVUvM2JIMWYzS0l0VWMyRnVCdU1wREExbjRSM2JFcW4wbWZMSStlNHVS?=
 =?utf-8?B?NzVGQ1cxcStZanpXZnhhNWFDWjlqRDhWR0RPdkdTU3l6QjZ0TFpOeXBwTlJB?=
 =?utf-8?B?U1hqRHVLdE02OG84Z2ZiZUx4Ymh0OVBkSkh2SnU5WFErWXFFRFhYL1krSFJY?=
 =?utf-8?B?dlh3R3plbHNiS0c0cEVHWi9ncTFZT1g4b2xqUVR4QkJVNTdzV0FzREhGWkJX?=
 =?utf-8?B?SnpndEZXaGNDczRSRTNWcW5oeWdLbEhUVVMvN2k0cmwyU2pCMXR1SU9QY3ZH?=
 =?utf-8?B?YTdWM3dIWFJLVFI5dmJqSHdGckJncUtJdW1KcnJjUHVLOXI2WGFBUmI2TDhD?=
 =?utf-8?B?VmtObGVXNzU1ckRqU290ZWtvdXRLZXRuQlFjTkdyQzBQYkZ3b3Faa2Z0RUlW?=
 =?utf-8?B?V1JBdmc5UUo0M1ppV1dDNjdBUk9FekVUZGVlYkI1V25pNFhxZVF3MllzVWVC?=
 =?utf-8?B?M0hkL3BxV1prQjRCc2tVQ3hOZzFlSXdGMGJpbVBVMXlUdEQ1eklJdTBZK3E2?=
 =?utf-8?B?RFhlTU1xRDFOSFJLSFRRY3hXM0FqWVFJcG9tYkdwSW9UUXdQWFA2SnNTYStj?=
 =?utf-8?B?MG52ODliUXhSWFFWQUtKV2pwbm0zaDRZdzdJcUlYaDBSUXVJWUZsU2t3OXB2?=
 =?utf-8?B?QWtYQjUrR0dKb3VLU2ZRNWZGY2Y3RXdnbTFoQ1BvVTB5VFZjYWVHT1drQUpR?=
 =?utf-8?B?R0RFS2ExOU42UXFyWDZZNmZBbzAwOC9OdXdSNHlTT1laV0FUZWJ1TE8ydkF5?=
 =?utf-8?B?S0VZb3gwWDhFTjlrQ08vd3E3cFg1d3pNTE1PL0ZUK3VZdU5JNVBvSlpOUlR0?=
 =?utf-8?B?TzMrTHF0QzVqNnlFRmxQRGtieFFMSGd4cFZWcFR3R1pUcnVXMVFXbDhGL2d0?=
 =?utf-8?B?Y0hpQkdKNmU2ZjR4b0dZdmRUMU1mTkxNazhIQVZ5V0VCZkl6UXFCdzEzR2lY?=
 =?utf-8?B?OWxCRjNwQ0lScXV1b05RNHU1TnhpanA3RVova281Z3FWUnZpeUovRytZTnVY?=
 =?utf-8?B?UHJ5cU9vcGRsV0MwbzNwcHgxc3pKbUxmamsrTjYyQWdCWVhMRis4YU9Tck5v?=
 =?utf-8?B?QUJKRjdNTDZmT1hoVFNhUUUwZHBud0NRQnhLcjNTOENIcUk4K0dGL1d2R1dM?=
 =?utf-8?B?QndzUmxnYlpKQWZEcElvN3B2VUNrcmYzc2pWdklBZ0FZM0F6c1BRS290dUZk?=
 =?utf-8?B?TkRwbTBkdHBqZjVXNFBmWnpwaHR5cGtJTlYxVE5OOThseXV3Vk0xZGdPQVNG?=
 =?utf-8?B?ZEdPYURFN3JKcWZ4QkhOU3lJWmthOXk5OXlkZGVScEpsZFcvekZlNWEzWW5q?=
 =?utf-8?B?elkzSG5KVUR4TDkxWDJDb2hYaVBFaXpFbmNQUmt6emVwS0RNMkhmMTdkN1JW?=
 =?utf-8?B?cCsvbE9vc2hDOXl6K3lHS3pGWnN0V1E3YklGU0ZtL1l0TU9QUUpMSXVWQzdy?=
 =?utf-8?B?RU1JWmp0N2JpNjB3N3A4SVhlUUpEQjhFeE5IeHo5RnNTamtpQU95Z2p5N244?=
 =?utf-8?B?N3dSUDRTZzVtQWZPQ010T2RQN1gwRDI4V3pieHJUS3ora3NVTFh6b01qUVIx?=
 =?utf-8?B?dktiSzBhd28vWmhBWTNFRFZIbWZWTW53N0lHKysxSG42ZzBRNEhkVTlzalFw?=
 =?utf-8?B?TlNCbHcvZkE2M0tDbzZXSUxISjRwYktCTnBwYXFKRDVMNlBRZHdscmpvU3dt?=
 =?utf-8?B?SzIrbFlVOXVsTEdxVjc0RTFrL1RQU0JhVzRJOEtZWktaMzNlUHhKVUh5M3FL?=
 =?utf-8?B?MlI1dU40RnZYcm5XaVpCencyQkxMV1c3ZlhhMW9acWFYTmtTaFJZTXk0TlVL?=
 =?utf-8?B?bDkxWGxEcUIyOVRQR25GOFpDVmtzTzdsZVNYSzJ1aHRLR1VTNnROYjBZK1hV?=
 =?utf-8?B?TE1qcWNLTk16RXUzVEM4Q1pGUlNmMFU3WEdNcGErRjlkOTcrTDRBdzlGbzFX?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca7a87e-e5fa-45f8-b166-08dc9174a48a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 22:02:14.3806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kowu+UN5egSOnRlqBKOc/4spJeVYInKb3q/1U4fLoiS/+rDYdhSHraQlXk3/f5ZDzSzyh/mGYbFGAKx4JGUW7iw89yqOxZQcQIr2gtZHHuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6877
X-OriginatorOrg: intel.com

Hi Babu,

On 6/19/24 8:37 AM, Moger, Babu wrote:
> On 6/13/24 19:59, Reinette Chatre wrote:
>> On 5/24/24 5:23 AM, Babu Moger wrote:

>>> +     * Reset the internal counters so that it is not considered as
>>> +     * an overflow in next update.
>>
>> For the first time the term "internal counters" is introduced. What does it
>> mean?
> 
> How about "mbm counters"?

I think it refers to the state resctrl maintains to be able to catch overflows,
so how about just "architectural state" with matching change of something like:

	Reset the architectural state so that reading of hardware counter
	is not considered as an overflow in next update.

Reinette

