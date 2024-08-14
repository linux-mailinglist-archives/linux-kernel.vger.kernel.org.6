Return-Path: <linux-kernel+bounces-286997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBA6952162
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E28F28405C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D721BC075;
	Wed, 14 Aug 2024 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIt7i7HU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42941B14F8;
	Wed, 14 Aug 2024 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657076; cv=fail; b=KY/sYbDSBQakrQGErk5NAkUntSJ6pVX922ki6NaqvHA28v0m4uVpAisSzymBOlnrDmWo5Xl+bAi8dj9CtWZiH4yD2v30T1vPNQKV0Kgbu8sySJ27Ek4sfhmjhZRVfQrRKzr09+E235WaYvIGL5Sv2+w9yrhTUU25aI5IL3fLwDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657076; c=relaxed/simple;
	bh=mMOw1D9ui9U0+MzDq17hg3yzbgI5eXthM72KEnDtf0g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cZaey8A3lcKpNcvs2d/vfAiPenhYMh/fYN/ZgyuQokQWzNTcZOnKA37MsJuFCrqRQeGD4h2au8hfCem1PsxNXyVp6HX3UTpx7/EVLkz7KCbsygR/Ri5WVZmk4oMiLNVpFn2iXqiiC6JZbjeOO+f1nBAdfGNSmiqJ/pQMcZVVb10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIt7i7HU; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723657075; x=1755193075;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mMOw1D9ui9U0+MzDq17hg3yzbgI5eXthM72KEnDtf0g=;
  b=dIt7i7HUKtCshQu7d4ya1W22HsKenzkKHX6zK1U+M95JfJEJJcTBImWz
   b4yTGr3dwyc5pkFHWMF5hwiVN5wjhRJRifERXwtnI8HOIeVveFnm/lwgp
   iyYimLzvBdHKn8WD0xi9JBmVZcw3Fz2sDoyArmzpdH4VaQwyoTVRmX1YU
   brPtckrouKwdhyO5V8LqMRMhpRQmY0oucGQwzoztvC7EjmoaU3mEeJhpp
   pARbXZDLM1kt7eSwrI5FpinzZPCyAg/7VQDD5eTTAjlXYm+LHuDnRHk3h
   bUD5rdrIfz9PsyuYtKfv7zpBjRDwF6gQyi1DS0Bmn4+CJmzjBeNkKtVBS
   A==;
X-CSE-ConnectionGUID: rYj1qFuIR4ewibk/cnDHtA==
X-CSE-MsgGUID: kH2S4ueFTXmIblAbHUhCXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="24795902"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="24795902"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 10:37:54 -0700
X-CSE-ConnectionGUID: xhkeg0n2SbigVSFIUlJjPQ==
X-CSE-MsgGUID: Wy2aN3rkT2u4jz4yWL0MbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59053917"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 10:37:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 10:37:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 10:37:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 10:37:52 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 10:37:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYo9SqjbsHL1F/ASHGDypnnblWEQFvGpVcfhVh0WW80r6dd7LFxZ1FFzYnm0xx2gb020/D4OBzV2j0wQWR7BTcHN5lEkOdJ0/HEVHhhkDggrViRVOulgYhum1/Uhyts8V+8ek7Jb5EQscIXq/rXB20Gk/sk7F+zta8++4ZtuM2czjUbc36pDOUp6VrG69xq8aEaByDjP72yHYH2ttPbL8Vlnnv/EKvcZ5gn5PBeMbh31fa2/Fdoz7MdfQGjyqLKdIp0FcW1Xyaa+MSQIiJjBieBFSEZC/n2M8RENWjDjScO3aLyHrRUPgVLlYFmv3ffJl0hFZVd1Ne3/8b+pvNDyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZCQVVXkdkuQDZq7z629KzlfGig9hyhm7n0Ug0J/Fsc=;
 b=lZ3/JQK7zyzn2ULr3dQhiNYOIfotld5thll+mKxujrwtflj5PJyTyf6WTTXg3JZ2Ca1ZC+ywcN9+/VONbbvyVD2n3HwXjVVbd4/M1eha1Q5E38t333lB1QAWuNZUyC7Pv/BmOOpA6bn9cWfqaXjQM6fGH83OyETEwjNkmIVsWGVcPzaN1wbOiy6ZhJlsK2KBolgh60fH9NJGxZaSL6sDp/sd+F42JiXiuehnJTf2xH//HSzjyLAcE3SOSrRsK6tyC2EYnHb6O+hWdWqmU28hGLv65FCPboRrSrrCigNR0TP/7Fc3u0cvrexMbAnFENiIWxiZWbgFXJt8yuyMSDvWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by DM4PR11MB6096.namprd11.prod.outlook.com (2603:10b6:8:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 17:37:47 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%6]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 17:37:47 +0000
Message-ID: <a19d96ac-f83a-4f5a-98ce-c5554e12afc5@intel.com>
Date: Wed, 14 Aug 2024 10:37:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
CC: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <rdunlap@infradead.org>, <tj@kernel.org>,
	<peterz@infradead.org>, <yanjiewtw@gmail.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>, <james.morse@arm.com>
References: <cover.1720043311.git.babu.moger@amd.com>
 <e04b721a-b5cb-4089-a3ad-125a6247e5b8@intel.com>
 <1c50b589-a738-4ae6-8362-bd1ce0d0dc98@amd.com>
 <05b4e345-ad14-4ea9-a13f-2c9b3a6eb422@intel.com>
 <CALPaoCi_TBZnULHQpYns+H+30jODZvyQpUHJRDHNwjQzajrD=A@mail.gmail.com>
 <b3babdac-da08-4dfd-9544-47db31d574f5@intel.com>
 <CALPaoCi1CwLy_HbFNOxPfdReEJstd3c+DvOMJHb5P9jBP+iatw@mail.gmail.com>
 <b9e48e8f-3035-4a7e-a983-ce829bd9215a@intel.com>
 <CALPaoCg3KpF94g2MEmfP_Ro2mQZYFA8sKVkmb+7isotKNgdY9A@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <CALPaoCg3KpF94g2MEmfP_Ro2mQZYFA8sKVkmb+7isotKNgdY9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:303:16d::34) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|DM4PR11MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: e3caa854-892b-428a-4569-08dcbc87cfe7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: Nh9cdc3DDoAfHqU0C8EspXvwNRcM2W/ckPSZZt2k2Lgdpr7bj0HqK4xrhJTIOLb+xo2/EgZMprH0RTPPxJPx5dPTHK3DpqQtktLJ6185J5jb26j3PW0EoZ6OHxDIUxgpdm9q/fXjy1TGH1sGVSkExxkNp83GsrO5Mev0B1zFMXKZINjpSO5HFK3Ib2PeXh5f3kOQCorRxRWW0AULD24zXS6exACgoJ4w9dsytoENuyOSHdkLtNEEn//uJxB3FL8Yo4F4bDHOQ+8MnT4qJNR7ztEAFf265CpXua/T9FTl1ADzvYzu8iAvqRdr2IFgFlQEzgxzP6DXNnfb1JTpN2wLbH1+7eky9ba6glxzYsYgyhCqwStesNDN2nxCBzNQxy0PXDDI5CY9IHhboZYLmYFPC7TG/lpzMfSr6cEHhR8hx5JSvgaWM1fIPIXCaWnp9bEtY4icbhslJ7fXQQG9fkd/BZhJZDXrFQHVHMIrmXxnbRgJbUU6o45oBSlCUwFJ4cXsxKPi8f+mwRFmdJAQ2JozUNBlMugFCr9xvnEQ8ZPIQnIy8nqIULqOqPOWwKDi88vj/Q6EWSsgwtUSz4w2Y6PiqC9PrOhqa3vR1xR4LjSwm8HaBAnjAX5eEZ3ANvSZ/JAS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFplWVR6V2xTcm5aeU52VllYbC9aTndHR2hXTlYrM3RGbk45WnYyVnY4QjNX?=
 =?utf-8?B?ODF6cVM4aktRL0F6NFVDL1RGYjByR0U5Q0YvSE90a1RBaWtQalh5am9ZRDF5?=
 =?utf-8?B?VkJSU3VMNG5JZEovUVhDT3E1UGlQQkdLenRTMEZoM3RLVGJjd1c4U29kVHQ4?=
 =?utf-8?B?alBvbUwvQjlnTWU3ak9JblVuYVB4V2gxYUVMZU9LazRQY3d5c0VIYXpFV1J3?=
 =?utf-8?B?cGJLQnJpRDE1V3pVa1ZveFdjV0VGaFFGeENSOFllNW0zZmJRV0ZLMDFDUU5H?=
 =?utf-8?B?L2IwelpjNTE2OUo4QWZyT2t2UmE0cmJ5aDkxNzRTbnYxK1RVVTRYa095Qlpl?=
 =?utf-8?B?K3hjcTFoQ3YzSlZjcSt1RDlMSUVzdDBQMnBGUDRSK0NWZm9IRUk2T0Q0UXlr?=
 =?utf-8?B?ZVNvTWxJY3RZdTZrUUJ5dWtzam42OGFyaHd2aXg0U1FTMkZsN0lQd2xwQlpZ?=
 =?utf-8?B?TCtyMVp2ajZwcmluMEZVamxzVUpjMUFkTldXNUlOYlN2cFdiR0JEVTNjeGRS?=
 =?utf-8?B?aHNZbjBjVFRjK2ptUVpWOVdQdktBNWhuRmd5eGNiRnAyUXpPS3Zzdmx3N1pX?=
 =?utf-8?B?bUl3Ykt1S2lNTFlFMXdibiswb2JuakEzd3pzcWVkSEN4Wko0MFZ2OUd5TEl6?=
 =?utf-8?B?amE1UTh0aHE0MW0rMUtGekJOL09LNjV4WHBoVkY3c1QvMnJ1REY5dmtVN1Jy?=
 =?utf-8?B?T1FVZUdqaU43ZlVXNlF1U0xXbmFpb0dseDNKNnIvTVd3VUhVZVNvSWpvcEUr?=
 =?utf-8?B?ZWNqM2dTN1laUWhqdVZ3OGZRUXdsWlFKR3F2djdTMW5qMzl3VEhrRUgvOGpP?=
 =?utf-8?B?OVdzeHZOTTl2QlhFNWVwU0hIM0FZNklkdm9EbklMWXQ2TjNCdTZSQmg0TEsw?=
 =?utf-8?B?R3BUa1ByZExZSlVQZnhEV3RNcmVKVTR6aEszZkZ3ZG1EY2Z3RDdKYXM1T2x5?=
 =?utf-8?B?c203c0MycWtHdXYwc2cvRU1ucVlkZlNUSVJ3UVdOVndFd1ZCVVJPWXU5WDdn?=
 =?utf-8?B?UVdBbldDM2t2T2N5V0doTk9iUEZqM2ZqWTJnNVQrMW12ZHdhYWRVaDF0M2JF?=
 =?utf-8?B?Q0xKaFJCM0IwVVhHclYzdUlGY0lhUUtydjNpcXp3NGE2SUZhcWRVT3hTQ0ps?=
 =?utf-8?B?R2NMWFdrVG50UFNwb0d5VFNHVlZWeWc4c0FnbzBLQWRFcnNzazBZV28rN09z?=
 =?utf-8?B?L0tUaEtncFFOQ2Jka3RTOTk5eEczWmlHMEptdVFBb0JVdXZLRzFUNWRrbWky?=
 =?utf-8?B?TU0wcDl4R0lFbHErSkErang2OGFlVmFvdXF2M1lNd3gwZGhYbDk0T1hTSzNp?=
 =?utf-8?B?bjVFSFd6UHhiYm5QcEpwWWp3cmZnZ2poM0lpRmw5elV1R0lwemtVS1dONHc2?=
 =?utf-8?B?L0U1d1RNdmZwdTRXcHlPSGdKVFVrQVYrTTB1RlFobk11ckN5M2drQmN1Qm1D?=
 =?utf-8?B?Rm9aQVBSdjFuaVZOb3pONDF0YUh6cEZJTUpXZzlhdHVHcDREYlhVcG10Ny9I?=
 =?utf-8?B?SHlxMTE5WWJlcFRqQkF1bzVBQStIVWlPYUJ2ejdkVWthV1lqcnVubWNyV28x?=
 =?utf-8?B?WmVaQmVieDc1MGovdlpQK0VHTWZxak0ydnpEall5ck9TUStoaytDdWpWeFdk?=
 =?utf-8?B?ejlnUmIyMERNbTBMSGNtbTgzNHdDSVEwdnhPSjhYb2hnU0RvckdjSmZWSk5G?=
 =?utf-8?B?N0UxQUhWM2wvSDE1UVh3Qy9CdXdJN29aZHlZNXZmR0ZIK08xRGZ0aHFHZzZw?=
 =?utf-8?B?d0tNTDF0RkNSWEJpQWhoYmF4NjZ1aG1xM2FNb3Y0bUNUbEhKdGM3MktuTnF1?=
 =?utf-8?B?dTdJNFNRQ2F6aUdEbW0yYUIwdkc5WTBFTXJPYk5iMmVlYWx6NHFwU3YzS1pw?=
 =?utf-8?B?SE9tcy9VY0ZIZjNYTW5KYVBEcjErNVMzRGdLWDhQQ1RqcUdGd2xFYjB2WGlu?=
 =?utf-8?B?K2N5WGFVQUk0cFV2djlzRi9HK0I1ZWdxMnNCc0dhL0tKdzZlMVIwMzNTTndP?=
 =?utf-8?B?Wk9KWW93cFRhYUkxSS9OcURaVVZOTDhxNENGa1JyblcrUkowYlh5V21RWHp4?=
 =?utf-8?B?YXNlQ0R3MXd0VnMxSmZNc0Y0UTFNUk8vZnZ1NHhMS2F5Q25Qb2puNmpyR2dv?=
 =?utf-8?B?UytRU2U4NEVnMFRDWGc2bjFNRk9iQlJzZHdUOXJVSTRIdnZJT2RrRmlLVXJP?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3caa854-892b-428a-4569-08dcbc87cfe7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 17:37:47.6583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecVez6ltVgebSMik0IsK3pRM5feq9Xk+S1N+9j7o6zmc8aHznTO2TypMMxTBi7Oj1YvQaNH7eX7W296gPnGzBJACJB227P9FluGkgFSWXdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6096
X-OriginatorOrg: intel.com

Hi Peter,

On 8/2/24 3:50 PM, Peter Newman wrote:
> On Fri, Aug 2, 2024 at 1:55 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 8/2/24 11:49 AM, Peter Newman wrote:
>>> On Fri, Aug 2, 2024 at 9:14 AM Reinette Chatre
>>>> I am of course not familiar with details of the software implementation
>>>> - could there be benefits to using it even if hardware counters are
>>>> supported?
>>>
>>> I can't see any situation where the user would want to choose software
>>> over hardware counters. The number of groups which can be monitored by
>>> software assignable counters will always be less than with hardware,
>>> due to the need for consuming one RMID (and the counters automatically
>>> allocated to it by the AMD hardware) for all unassigned groups.
>>
>> Thank you for clarifying. This seems specific to this software implementation,
>> and I missed that there was a shift from soft-RMIDs to soft-ABMC. If I remember
>> correctly this depends on undocumented hardware specific knowledge.
> 
> For the benefit of anyone else who needs to monitor bandwidth on a
> large number of monitoring groups on pre-ABMC AMD implementations,
> hopefully a future AMD publication will clarify, at least on some
> existing, pre-ABMC models, exactly when the QM_CTR.U bit is set.
> 
> 
>>>
>>> The behavior as I've implemented today is:
>>>
>>> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_events
>>> 0
>>>
>>> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>> test//0=_;1=_;
>>> //0=_;1=_;
>>>
>>> # echo "test//1+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
>>> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>> test//0=_;1=tl;
>>> //0=_;1=_;
>>>
>>> # echo "test//1-t" > /sys/fs/resctrl/info/L3_MON/mbm_control
>>> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>> test//0=_;1=_;
>>> //0=_;1=_;
>>>
>>>
>>
>> This highlights how there cannot be a generic/consistent interface between hardware
>> and software implementation. If resctrl implements something like above without any
>> other hints to user space then it will push complexity to user space since user space
>> would not know if setting one flag results in setting more than that flag, which may
>> force a user space implementation to always follow a write with a read that
>> needs to confirm what actually resulted from the write. Similarly, that removing a
>> flag impacts other flags needs to be clear without user space needing to "try and
>> see what happens".
> 
> I'll return to this topic in the context of MPAM below...
> 
>> It is not clear to me how to interpret the above example when it comes to the
>> RMID management though. If the RMID assignment is per group then I expected all
>> the domains of a group to have the same flag(s)?
> 
> The group RMIDs are never programmed into any MSRs and the RMID space
> is independent in each domain, so it is still possible to do
> per-domain assignment. (and like with soft RMIDs, this enables us to
> create unlimited groups, but we've never been limited by the size of
> the RMID space)
> 
> However, in our use cases, jobs are not confined to any domain, so
> bandwidth measurements must be done simultaneously in all domains, so
> we have no current use for per-domain assignment. But if any Google
> users did begin to see value in confining jobs to domains, this could
> change.
> 
>>
>>>>
>>>>> However, If we don't expect to see these semantics in any other
>>>>> implementation, these semantics could be implicit in the definition of
>>>>> a SW assignable counter.
>>>>
>>>> It is not clear to me how implementation differences between hardware
>>>> and software assignment can be hidden from user space. It is possible
>>>> to let user space enable individual events and then silently upgrade it
>>>> to all events. I see two options here, either "mbm_control" needs to
>>>> explicitly show this "silent upgrade" so that user space knows which
>>>> events are actually enabled, or "mbm_control" only shows flags/events enabled
>>>> from user space perspective. In the former scenario, this needs more
>>>> user space support since a generic user space cannot be confident which
>>>> flags are set after writing to "mbm_control". In the latter scenario,
>>>> meaning of "num_mbm_cntrs" becomes unclear since user space is expected
>>>> to rely on it to know which events can be enabled and if some are
>>>> actually "silently enabled" when user space still thinks it needs to be
>>>> enabled the number of available counters becomes vague.
>>>>
>>>> It is not clear to me how to present hardware and software assignable
>>>> counters with a single consistent interface. Actually, what if the
>>>> "mbm_mode" is what distinguishes how counters are assigned instead of how
>>>> it is backed (hw vs sw)? What if, instead of "mbm_cntr_assignable" and
>>>> "mbm_cntr_sw_assignable" MBM modes the terms "mbm_cntr_event_assignable"
>>>> and "mbm_cntr_group_assignable" is used? Could that replace a
>>>> potential "mbm_assign_events" while also supporting user space in
>>>> interactions with "mbm_control"?
>>>
>>> If I understand this correctly, is this a preference that the info
>>> node be named differently if its value will have different units,
>>> rather than a second node to indicate what the value of num_mbm_cntrs
>>> actually means? This sounds reasonable to me.
>>
>> Indeed. As you highlighted, user space may not need to know if
>> counters are backed by hardware or software, but user space needs to
>> know what to expect from (how to interact with) interface.
>>
>>> I think it's also important to note that in MPAM, the MBWU (memory
>>> bandwidth usage) monitors don't have a concept of local versus total
>>> bandwidth, so event assignment would likely not apply there either.
>>> What the counted bandwidth actually represents is more implicit in the
>>> monitor's position in the memory system in the particular
>>> implementation. On a theoretical multi-socket system, resctrl would
>>> require knowledge about the system's architecture to stitch together
>>> the counts from different types of monitors to produce a local and
>>> total value. I don't know if we'd program this SoC-specific knowledge
>>> into the kernel to produce a unified MBM resource like we're
>>> accustomed to now or if we'd present multiple MBM resources, each only
>>> providing an mbm_total_bytes event. In this case, the counters would
>>> have to be assigned separately in each MBM resource, especially if the
>>> different MBM resources support a different number of counters.
>>>
>>
>> "total" and "local" bandwidth is already in grey area after the
>> introduction of mbm_total_bytes_config/mbm_local_bytes_config where
>> user space could set values reported to not be constrained by the
>> "total" and "local" terms. We keep sticking with it though, even in
>> this implementation that uses the "t" and "l" flags, knowing that
>> what is actually monitored when "l" is set is just what the user
>> configured via mbm_local_bytes_config, which theoretically
>> can be "total" bandwidth.
> 
> If it makes sense to support a separate, group-assignment interface at
> least for MPAM, this would be a better fit for soft-ABMC, even if it
> does have to stay downstream.

(apologies for the delay)

Could we please take a step back and confirm/agree what is meant with "group-
assignment"? In a previous message [1] I latched onto the statement
"the implementation is assigning RMIDs to groups, assignment results in all
events being counted.". In this I understood "groups" to be resctrl groups
and I understood this to mean that when a (soft-ABMC) counter is assigned
it applies to the entire resctrl group (all domains, all events). The
subsequent example in [2] was thus unexpected to me when the interface
was used to assign a (soft-ABMC) counter to the group but not all domains
were impacted.

Considering this, could you please elaborate what is meant with
"group assignment"?

Thank you

Reinette

[1] https://lore.kernel.org/lkml/CALPaoCi_TBZnULHQpYns+H+30jODZvyQpUHJRDHNwjQzajrD=A@mail.gmail.com/
[2] https://lore.kernel.org/lkml/CALPaoCi1CwLy_HbFNOxPfdReEJstd3c+DvOMJHb5P9jBP+iatw@mail.gmail.com/


