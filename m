Return-Path: <linux-kernel+bounces-254420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A879933302
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7131C225EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB931A00ED;
	Tue, 16 Jul 2024 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOa8dDRb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96145335A7;
	Tue, 16 Jul 2024 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721162524; cv=fail; b=UkMBfHhkdvglCfTTEDQewfVkhcgeUdIJMY2PR4FzI6LYtOeKnTIxC/EAo5FTDVo8ShGhYUVm6eNQmRe5jV3lkEhzwKyhIyjnYxvluVjLlLArmcHaMLzClizcn2bdAqtOMFqlqlSjdNj6wMYZmMpwVOuMUDG17Xf7Y7EtDUl0pcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721162524; c=relaxed/simple;
	bh=78SyJjEzlM+EZHD/bkc0JPc79gj09cnAA4b2KXIdzm0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cqIOoCKR4KOWorHWj14kVBbiPSPpOMLH448dcK+le2OI1As79cnzPH0jBuaWLqZhmCIWap13UbrJ2nN5kysDMqLqocYuhY5mFnuSSzZLNgubj0hG6jBwd7tLThHul33nT441XKVa0/O8acaCEyN/OlPGJatEchrfiZzk3DnBTKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOa8dDRb; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721162522; x=1752698522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=78SyJjEzlM+EZHD/bkc0JPc79gj09cnAA4b2KXIdzm0=;
  b=WOa8dDRbDZuseW3KHgxfs3aMSwIAbQSha6jVYx7F5N0SA4lqOi2xVZCA
   nKl77S+Y15+5qCkWyGTk5Vaa9L0H0ThovqL3hbmr610XxvTLH1vKNDNGC
   KnMxXliZbOcnZ/BvtTF/H/LdLD4seWfJWbJionsu3dtlEzBpT/RamO3cf
   wOQpd0XgvX9ntxh0iacm9O3gXLeLxIdju0OPKcM7t7jvx5VB+xxKA5hNR
   3RAR3AuBOaJUfIza8xyLkVDkPBWO2cZ7yC2OMoF7X5qeTFscKBXtMbjIf
   lu5TehNMUkJxmP8HxKMnCDprZ4bIIkCn9hVyYnu+BMzuDShUrbFA/Pqql
   A==;
X-CSE-ConnectionGUID: 483CDcvJQE2BtDOQApWezw==
X-CSE-MsgGUID: gLy368wMSv2LQBGV71RiyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="36073504"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="36073504"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 13:42:01 -0700
X-CSE-ConnectionGUID: D1HP9f/rTWyI0nLJ0rCtmA==
X-CSE-MsgGUID: Dhg/+tyvRg65m4Y5VKZrXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="55295969"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 13:42:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 13:42:01 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 13:42:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 13:42:01 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 13:42:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxhYrscGLHIVnXO9OdsOjw1T910LeRGoH3evCIs5nP6SCrbJd6e1qrkqJbYpOPW5XrorjC+wbKiJdSbOMRKFVTINHDdtPdwV41tyveU/yHflhotTV7ernFf1fpHt0F6YvPtx76GkOlilptsgO//EzKEdG/uOKQdBwLRHHRrr0nO8mLnJ7eb3BEaKACPxKEmHvor4oixyx1Idq0liQa/tpNa/xuvdmzhdhlfjSynOVtLIfNFFP0q/VqRPPm4Z4ywoWJIG9uehXMaWUKnFHYKxOMTvFVnAJJ5Ob196/mDeZMdXdXgsOVMJc8939dVLP6uUN97t/5m+lGgs/mDrmboPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dylEebnrOsrmpgO4Mh1INWF+eI+IsEfd5XCpV3iqbSc=;
 b=Lx16/ZAMj6p9wt1EuR47Q0tpf9Y+a0JYNsrsoKlBt8+Jo8Yhmu4D83gdxdxtwcJihKBdcIyEPqxwm9/1JEG4IGRNGqDBcHFwuF+ZjetO2TwYmjeX5XNi/9cUTORUHmyYWN//vVHh7VFxDMtf7j4hpQ+x82Qsi7R6pFNmn21ndF+48ZKErQu0lKbtQfOrAstmtbf2fLKLIrntE/GMVqMN+rZlQ6BKN7VxiHY3H+I8p8lpDvMj6iXXdrqSNsaIMG7IAceC323Sr4EEyplK63giLiGqoGwocPYpjp4dfM+B+7UjoEwAJcvONc5QQ7qnFkztyy6VJzpom6ZuZ1g+nU0+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Tue, 16 Jul
 2024 20:41:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 20:41:57 +0000
Message-ID: <ca74b756-c7fc-4cdf-ba24-62053da333ff@intel.com>
Date: Tue, 16 Jul 2024 13:41:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/20] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <ed24fa5b599d6f0abe53a72613f7afd2dc9aeb1c.1720043311.git.babu.moger@amd.com>
 <ca8c5934-c531-4d5c-a765-8722e0eae5ba@intel.com>
 <706a061d-c9bf-48d5-834c-67ae1ba4729d@amd.com>
 <5e9d6516-abe7-405b-8db9-52c381559c58@intel.com>
 <892693a7-1a1b-46e4-a989-052a19566231@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <892693a7-1a1b-46e4-a989-052a19566231@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c1c415-9947-41e0-f867-08dca5d7bc06
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXJXckpLdTJ0S2JRdDZudHlWZkdLc2tyMHcvNC9sbFFpcEtlRStKR21OOS9t?=
 =?utf-8?B?bElqU3d5YnNTUUVqQlBHWmNJUEJxbjVKbU9DRVRXNnhES3ZnSXpnWmMrcXpO?=
 =?utf-8?B?dWRCcXlTSnduTXdNdHVKaW4wdU1hWXJ4cE0xb3FpbmVmdWJKYjJZYkVmOSt5?=
 =?utf-8?B?QjdMTVJTNjNvU2pnVURNdGlsNGdZeVN2ZVZ5OVNuNFI4ODBxT0s2SXZwaFZh?=
 =?utf-8?B?QnBCNWRiOUdHK2ZNQnJQSXNDUVIrbUFobGZPcDFGemk0bkt1VkkxOVZMcjRr?=
 =?utf-8?B?ejRJOUNSNDF6QVMvaXM5YUQzc1pqcnBwYWxyRlVSUE1lOGpqKzVQMnhCZ1JK?=
 =?utf-8?B?alZRcHFxcUVpbzJpSXhwMzFBendVQWh6VlR6MzBwbG03ZjdlUFJocmwxRVR0?=
 =?utf-8?B?cG1ic1g1U0ZnVzdkQnhpLzkvNTFMMXRYajNKb2FpODh1SE1RcjBkcWRuTlNV?=
 =?utf-8?B?MHQxU2Y2T2tNNnJ2R28xOE95SnR0V0JrbUlCMGQvbk5rNWhsUlJIYWZzc3NR?=
 =?utf-8?B?TEJidjFtN1Z3cm1ub2t3MUgrb0hWU3VOMmQycHpibjlWMWJtWE4xbDBNWTRC?=
 =?utf-8?B?dVVkZzVVWHFmZ3lyVWlabkpXV21DQ1RHNDFhY0lNZHRDOTB6RUVNS2RiMXFB?=
 =?utf-8?B?RmpmdGVTM1l1VjZPRXZua2hMNFpzN1I1c3NWRzdMV2NhM3lzL0dqSU5obFdq?=
 =?utf-8?B?eUNabTRoWFFJdzdFeWdnWWYvcUUrQlpub2ZyTnMydGk5NVIyYUNGSVhXODZC?=
 =?utf-8?B?Q3FoYUNkQkVYK0IvYlZnUTJ5UjlHNEt0N0NHM1pBSmxwU1REVldzOURMaWxn?=
 =?utf-8?B?MTN5U2RRYVpIOWpDTVgrdGNsL1VZSVlVanFIT3hvTTZMaHhNbWl0QlRINVdQ?=
 =?utf-8?B?cUlFS0pzYkxOaDJXSTN6UlNXOWRqK21BUjVJaS9Qdm1oTERqdjdXWVRwcHlP?=
 =?utf-8?B?TWtSVy9zZHh5ZlRhWWhNbzJhb1BHQ3Y2aG5KaFdab2ZOOWRyZ1d2dm40bDVS?=
 =?utf-8?B?VmxnSGFPaEVNN1c4bFd2Z1BqVFpJeHB4UE5tbFIvTi9kaEJJWVhiUmh2ZWxy?=
 =?utf-8?B?ZUdSS0tJUmM5TGsrME5sQWNvTUp6VCt6d3dZV0QzODh1YWg5Q1dxc2ZMTnBG?=
 =?utf-8?B?OThrbjNVK0tCQjlEbGhjNkRxaGtTc0xPVFVrS01PNzl4aUZ1VEhGMzRIaDZR?=
 =?utf-8?B?eG1KYW15U3JaR0tyWG82NzRvUEZwcy9aWmR6djBBeTB5L2ROYjQzMW55TUJK?=
 =?utf-8?B?blkvazIzYWp2U1NsQWZlZXJsQVdCc2hPYmdlTklwUktwWm1sc0V3aTRsODFp?=
 =?utf-8?B?VjA1MjdPcDcrMTlNeEhxSFFnS09VL2MycUJTMjNUVXAwWnY2V00zTS9vOExP?=
 =?utf-8?B?ZVp4cTd3RWlvdGFxZmo0ZWR2L0J0SGhranJPaStNQm1tMFNFOGRPRkxQbmVh?=
 =?utf-8?B?Z0JhN0V2eEw4RTRTL3p4dXJ4bGgxaWZZQUZGRXh6ektkKzk0R3E3NTFkTGw3?=
 =?utf-8?B?ZGdDeGFVUjJSQk8rT2V0ZkZaV3hMWTZCTk5oeHo0NTBhbjBUb0k5ckhyWThp?=
 =?utf-8?B?UzdlejkrMlJaeE01cFhtWmJ4MWwzYjYxV2xGcWRzWVZDcFdwbS9EUHVqV3l5?=
 =?utf-8?B?MUY0dG9XNTVQTUlxeEt6NzRzZ2VCZEhRT2lwVThPM3N4WlN0dlp6cHh0Zzhk?=
 =?utf-8?B?NFFJWGZXZ2JvNngwSC92N1drQk1JMzBNQVRkWEdnN3M3NU1vdlJBclJWVnpt?=
 =?utf-8?B?czBGNGhBUlpyUmsvbHVWd3I2RmJYcGZHVys4UnZ2QmEwdXBubjY2bWZwN1Vm?=
 =?utf-8?B?ZjZtUUJ4RlZCN3lsb0E1Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFhvK2U5Mk03Zm9tdHMzMDJZSEd2NFk0QU40OUdENzRPNVk4TC8wbEdQWFVC?=
 =?utf-8?B?TkRmM1luRTRxc3lSZ0tMUkE3WVZzZWxENTNCakQ4WFNuMmQ5RTBwTUJNRkJ0?=
 =?utf-8?B?aVJnV01TakkxdzQzUS9DSno1NzBqL1poZDR5N0FmWUJYMDhlTWlIeEorQ3Z2?=
 =?utf-8?B?ckRhcXI4cExvQUw4RUdYTHV4bXBjK2J0a3FGT1BSK0JRTEY2clplODB5VUVn?=
 =?utf-8?B?RUlpSndPZWJCVjIybm80S09iT1h0NWhjdWYveFhkTkxuWVNQR1diMUVPR3pX?=
 =?utf-8?B?bjdpOXFZSzBmWkpHbjFyNDJ4Y0J0S2VLQTJzYml1cFlURUorNGg0Y1d5VXBT?=
 =?utf-8?B?djNCTjNZaWFad0pLVmQrb2YyZW12aXpteXZvWkU0eW5IbkF2Zms1UnZydjFP?=
 =?utf-8?B?WDZwVUl4eXA2eUhOc1BpeGJuNE8rajd3T2RNNEJCVlRzcUVqZ2VPcldZK2lU?=
 =?utf-8?B?dlFGbkYxZmEzZ1kxUDZ0TC9QOHNxUEpjSG1YbTdVK2pQNEkxYmk3SkxsVnV3?=
 =?utf-8?B?bUR1S01McW9yM1RiOUNveC8wdXRzbnRKYUlsRk56Q2RMTmQvRXh4blNORlE2?=
 =?utf-8?B?a0pERWJFSyt1eC9zSllKUkdMMjJvRmVnYzRTZXc3Qmo3aTgwOUFYOWlRMGVK?=
 =?utf-8?B?SnV2TUFvN3RJZ1NYNFVKYXhzSTVPd2ZmSUNjVlhJdkFrSXhpTXR2bGovc0Nk?=
 =?utf-8?B?d2dxdTBMa2lYVFJXRC9zZC9Mbk9FaG5ieVJ1ajZKUHN4WXJFbGJ0K2VTVkxN?=
 =?utf-8?B?azVJOGxSQ05EUjdPK21ibTFOTG5wcVRiN0w4NnRyV0F5ODlXTDI4WEEyeHd3?=
 =?utf-8?B?OGp1dG5RUTh1ZjZjZ1ZSWFVEVnFRUnBLQjRDR0lGVjYvSVMvL2JQK2lCRTVN?=
 =?utf-8?B?NWtpcjQ3QW1CZEdOSWRlMEtTS2JISHlCVldmMVZONXhlNzJmMSt6YndlL0dj?=
 =?utf-8?B?U1JDQzJNd0ZXL0hMUlRrMlIwU1dvQUMxamY2NWl6YWRCU3psTFJyMkZLVGl0?=
 =?utf-8?B?b0MzSVUyWEwxVGxuM1JoNXZ0NVNlbE1lWjN6dXh1aWRMSzZ1cGtodFJrMWli?=
 =?utf-8?B?aXZ5dUplOUdENURaQWhYbnhGS01rRFE5UmZrYTJFT3Z4RjVrRzlOS3NBaFI3?=
 =?utf-8?B?REk0c09PbXAwUVJ6WTJhK2RDRWtPb2lQZUNHZnNQOTgxUDZIY2FDQk1KcjFq?=
 =?utf-8?B?SjFFZUYzY0dZaTUraGYvb1I2UGpsR3pTRE1DZGdoREpaUG1CS044cGc1VEtJ?=
 =?utf-8?B?cUc2Tms1MllIOTdWQ3B0Z2QvR0x5bXQvSmdhQVhKZ1VpbG5qc1AyTUg2MDNk?=
 =?utf-8?B?RGZ0bzRobVZwWDFtTXpXR2Q0NmV6d0dhcGcrTnh5VnRBUXU5c1BROCtDdmt6?=
 =?utf-8?B?ajVlV0dIMUw4a0RVT0UzaWU4cXpOQkNpTlAydERURWZ5S3dpbks2UHdNVjdl?=
 =?utf-8?B?SUNUd0VoNmQvS0M3ckgyMXdUKzhTVDVaUExaMkhhRnJUdXVtbityMVdHRDUx?=
 =?utf-8?B?U2RMT0FaT0Q5dzFRZ1lEcmJkWGNKRnAxcFJJQjM3dmZlUEU5WkUzbWVTckU0?=
 =?utf-8?B?S2NKVFVZaWJDL055RHd1c1RxNGp6ZDBJdE9XREdyZ2NHWDZIME5zZFJkWjdo?=
 =?utf-8?B?MDdrc29aaEhwUG41bndPTVdxUVExYmFJMEZCMzFXUWVPVVpmVEhESmpBeExp?=
 =?utf-8?B?SzV2ZTZabmtLZGlVWG53UUNwV0RWK1JyTVJPWUI2WGJ1a3o2SlJBZG4vMGtv?=
 =?utf-8?B?TThHUXY0cHpHZndlNnJWNnRQYncxK0dKWmpsR0QzOU81ZmNNbzhvR1lGKzdS?=
 =?utf-8?B?VjM3dVF6dFg5ZklWSVh0S1h3M2w4VWFkbytSYXZMN2N5amZ1U252ODlvalRX?=
 =?utf-8?B?Ykp2VVIrQ1lucWdNM0g4clB5SFpDbGtoOWJKaFNsWGlBd1hYYzhmMlRDSWN5?=
 =?utf-8?B?Sk00VlI2WkNUYXlYQnVDTWxWTDB5OFA1OTVzY0xGWndEcTN2M2xuWVlMWE1S?=
 =?utf-8?B?d2ZnbUtja3pLdUZtTGxPRUZOWk4rWExhQXBVUXRQUnVIbmgzQ1lycks5ZXVH?=
 =?utf-8?B?V2dWYWtmbHFIVGk5RzJTdHY3N1FrNmEybXpISDIzVFlyTkIrVVQ0UHh2dWts?=
 =?utf-8?B?bnJMVHlnc3U2VGRFeFZvd21JRFdhMUdmREhUbk9OMTNFRHREaTE0ekZmdTRN?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c1c415-9947-41e0-f867-08dca5d7bc06
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 20:41:57.2533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DeFhcO5IIX+tz4lNnF/gfmBFfdAG7P/r+DlL8JUAu2ARxlq+SI2Z0pOkmyscr+np4euTbvyCy6cEqKGEx8EQiYCVBYOI2sfhR2hNQRLpXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
X-OriginatorOrg: intel.com

Hi Babu,

On 7/16/24 11:48 AM, Moger, Babu wrote:
> On 7/16/24 12:51, Reinette Chatre wrote:
>> On 7/16/24 8:13 AM, Moger, Babu wrote:
>>> On 7/12/24 17:05, Reinette Chatre wrote:
>>>> On 7/3/24 2:48 PM, Babu Moger wrote:

>>>>> @@ -491,6 +495,7 @@ struct rdt_hw_resource {
>>>>>         unsigned int        mbm_width;
>>>>>         unsigned int        mbm_cfg_mask;
>>>>>         bool            cdp_enabled;
>>>>> +    bool            abmc_enabled;
>>>>>     };
>>>>
>>>> mbm_cntr_enabled? This is architecture specific code so there is more
>>>> flexibility
>>>> here, but it may make implementation easier to understand if consistent
>>>> naming is used
>>>> between fs and arch code.
>>>
>>> How about "mbm_cntr_assign_enabled" or "cntr_assign_enabled" ?
>>
>> My preference is to keep the term "mbm_cntr" to be consistent with the
>> other variables/struct members to help when reading the code.
>> "mbm_cntr_assign_enabled" does seem to be getting long though.
>> Are you planning to use it by assigning it to a local variable with shorter
>> name?
> 
> Yes. We can do that.

ok. It is not clear to me how this will turn out. I'm afraid the length may
start to be cumbersome, but we can see how it turns out.

Reinette

