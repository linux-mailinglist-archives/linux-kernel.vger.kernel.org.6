Return-Path: <linux-kernel+bounces-368375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864DB9A0F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5841C22BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705FA20F5A6;
	Wed, 16 Oct 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5ZaIvfn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B2B207A2E;
	Wed, 16 Oct 2024 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094070; cv=fail; b=AFg2eD9d32XuqmogycltGmod1BXsIlxdKbwA5RwiYr4wTjJc0KU4noby3tdXGZIks8gOrd2zPSYW4AOe8td75g2wLHa1atd6DYn2AVajIfWje8xkdo7s44wjxfvQyeFGcaQ5nnDWoY8zboe5MHKQRBXrVHg02kcX6/sCC4IYaS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094070; c=relaxed/simple;
	bh=VC+ZDqC0Et4Z6IwBihQuG4yyUhbnFeTxxrEtkbeGgKo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ahvxeyCfI/axRfFRosL6Owidsv3O3VRo7QV3Fo32ZlRI/JLrnccHbHTZp5csoNPpxBWXCbOfn3/3R0h/XbNMf6RnbKhYXbPq+vDr0pbOiy+8fPhFGjaVFQha/5Bh5KEPqwSo2cStelR+WRKJAkxHP182Saw68Uo3b+9/1WYQo5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5ZaIvfn; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729094069; x=1760630069;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VC+ZDqC0Et4Z6IwBihQuG4yyUhbnFeTxxrEtkbeGgKo=;
  b=j5ZaIvfnrU+Ev3yNSzK83zVqAIlziRdohIaY9TuVg0j5k5KvPLmf8slz
   mYJES64RcesUjnA3c/R/Kp9fp7NQJ1QGUPMLtz3YkxSBl4s1+DpFIO6MO
   Vu/9i9yiwGtwjDLzPLjSLwfPZaZImj7iSsV1T/3Lb/ztOFX7QgTzrbA1C
   MSqCyQ4CWQju/qRNI9qjtLqm7oe9oay2Hhf8NqtIxNOi36N2kzisVNGDO
   iQm4QK6BQNt8d4DPQJMOi7Xek8/4OJAbFx31weEMKobAsG/P7ZPIhXaMB
   XqrlJhH+UHeF9ocQDODA5uAxA0v//AejUaZbzQSZ1mFvcVwifdIwQH4Vh
   Q==;
X-CSE-ConnectionGUID: bfvVwq/2RvKsThxo1ShLcg==
X-CSE-MsgGUID: kalrNf1DTuKcx3Df29J0Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="46045788"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="46045788"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 08:54:26 -0700
X-CSE-ConnectionGUID: DyP19+fsSaO+H9+5svb6mA==
X-CSE-MsgGUID: iwgpi/KuSl2I5dVpeDMtGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78224418"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 08:54:26 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 08:54:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 08:54:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 08:54:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+f7Kn2xn6ORI36jIccsnUWe8cIGrVKXpUkj6cblHyYfA4t865rhimV+JZYkpXcupgAG8APjEonu0KWOzR4rei0L6AuvWkwabvvR3xtPCJzj7zVJobz1Qfm3OjWA3PRLudhWMo2nHpMYmrGnD1E78IFJq8bxk9SxiFwlKqStSLHX31kfvvPt6dsjQuKU9QQW7x0czrl0UqPt4UfegCkv5OiVT+xfQhP4v32+ZCuT7VIlm2I2/eKzo3uLvwNICE2VSBkZSSUR0aVyeSyh6pNa86p8g44MglNzCG5d+jIPcpYVdtVmaVk4wWE9uSjXTB/xwqEaFAvnzYCprgKYnE2cUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/81C7dc09sUp5roKHONkTGiv1pyNdQP/glW1STD3uE=;
 b=m5swH4ICNrBp5n0YktslbqyTgGXYwb4YKqg12Z9X8xVVUAUz+CjUBgMCaBHvrARbe9FfFYmyctJ2Sr4auy/Yfwx0jz3P7UI4J8zKpU+e1YOPk/2tz10F7lIMhiL3aDuHUswncHVI//PExDYY8huljWxMoI9UlAyOZ/JfOtR2HU3kLX/y7dKkP4lj3/4oAf3egdFFihxKuuuWJyzZ89rSD1CNn7PrFvyv8YWA9eYdrb0EWXeOT+vBRtjOqZEfPv+qV4UkFpLgo467laCrkd1Do7R1vXByJvg+8ZJyZvRpNdJ1432Xb/T4Ad38l6EQmXhViPtmR09JAbBKAFu0r0tmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5243.namprd11.prod.outlook.com (2603:10b6:408:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Wed, 16 Oct
 2024 15:54:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 15:54:21 +0000
Message-ID: <ca29046a-29db-4bb0-815a-c482385194c7@intel.com>
Date: Wed, 16 Oct 2024 08:54:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] x86/resctrl: Introduce sdciae_capable in rdt_resource
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <peterz@infradead.org>,
	<kan.liang@linux.intel.com>, <pbonzini@redhat.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <alexandre.chartre@oracle.com>, <perry.yuan@amd.com>,
	<tan.shaopeng@fujitsu.com>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>
References: <cover.1723824984.git.babu.moger@amd.com>
 <cf9e47bbd66dbbdb76f0124620fad2f1b06e977e.1723824984.git.babu.moger@amd.com>
 <254da029-81b2-4745-bc78-5aefeb33adb0@intel.com>
 <b96e5de8-75ce-4a7a-8788-f5d3a959d771@amd.com>
 <89da43fd-69fb-48a6-830e-e157360aeab6@amd.com>
 <dbe8a012-eb21-426f-a8e4-46efee26da62@intel.com>
 <bf67bc4e-9cf8-4cac-9ffb-2d4f81ab7e30@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <bf67bc4e-9cf8-4cac-9ffb-2d4f81ab7e30@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:303:dc::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: 2487d5f1-f3ca-431b-dadf-08dcedfaccec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlBHQVpIOTZJWE9pakl1QUVxQitwRmNtWjVFanIzWm9PMzFscmt1a1RZMEh5?=
 =?utf-8?B?V2w3eW1iblZaNHVUQVpqTGVvTzJDKzYxSVJ3QzdlQVp4cUJLRXc1aHhvWm1Q?=
 =?utf-8?B?U2NXUWRNa1QxU2piVVVrN3F3dTM5aVhPTFRVdEdyMkE4S3N2RGZ3eWtyWkRC?=
 =?utf-8?B?Nm5EVEFOekN0Y2s0Y3ViOTNTdkNyK2FkSHBLUjRKUXZLZVNZOWxtRGVxTEQ4?=
 =?utf-8?B?RGZ1YVNqdUduVVhOSU5HY29ONi9Eek9iQS81SHI3NWJFdzRMbi85bDhNcFhR?=
 =?utf-8?B?ZFhaSlh0UnlsdCtjRDF3a1oyY0JoamNzRzY1c3VmZ2gvVnp1d0J6N0JibkZJ?=
 =?utf-8?B?NWtzTDByeWNITy9BVlBTQjhEYm1yOGhPek1XR2U2N1Jib3dnZ3FDVGdzZDNq?=
 =?utf-8?B?aFlOYStwWFVlak5JNjM0VkJUR1JUanFxNkxKa0RPLy9qNk9sRmRRWDJpMXZt?=
 =?utf-8?B?Yzc4Tmt3SHR5dWFOelFHTUVVd0txNzFHQ3VqeTFRbkdwNUZPN3RZY2NVanp5?=
 =?utf-8?B?bllMZ0UvU2FBbjZiWXFQck5GL1ZPRkR5T2hNTDFhNC9YZ2FKc1BiVVZIRmFk?=
 =?utf-8?B?QTdhN1J0TFF0b240OGxpWGIrcjVmVVNwNHdLVlI5dk5EOHNZY1hTdUdhb3FZ?=
 =?utf-8?B?cUJkWTN5VFBYam5ubDVUdlJTNU96dldsWC9MSXZTaUxlYzUwdGwvNVQwUEhy?=
 =?utf-8?B?Y0tvdEtqMVBvZ2tUbG5HN2pJWkM5dlU0eUc3WUM2dFZENnIzdFpUVVp5NDBF?=
 =?utf-8?B?UHVyZmtSZ0Y1U3dGamtwL0d4TnRBdXgvTXQ3QnA2ZXprK2l4QUJDaGRVZ0l4?=
 =?utf-8?B?ZDFZd0U1Rld5a3U2VVdLaUUxZm16UUNrdkwvcWV5V1hGWmNCWnhLL3Z5N3ZL?=
 =?utf-8?B?THQrMU0xakpCZXkzTVRpRzBWVFFVQi9hNW5MZzA0MmI3aXpGRlVpd3pxZ0Ft?=
 =?utf-8?B?MTNvR3NZckJIVXh2Z0kxMEF3WjFoek83ZlNjMnpyR2JpcXNvd2hpNTZvd0pH?=
 =?utf-8?B?YXNOMGV2cy9vdUxmeG1jd0tOb2VYN3ljRklBMFBNS0YwaHNpczA2Q0xEbDlT?=
 =?utf-8?B?NDdVQ3lHdVVkdzYrMk0zU2pLWTd4MHFNRzAwaVY1QUlFbjQxUHA5RWc3Tys4?=
 =?utf-8?B?amFOTmRIUWxDK1ZrREg5SjlWbGJsZGs1dHZYMDZpMW5JZlZvV29vSHl3VXNt?=
 =?utf-8?B?bE9LZEQ1QzdFL2NWa2ljQ1h2b1htNzduTEJUYSszeE1VcCtiVWpWeVRsK0xS?=
 =?utf-8?B?N1FvcDlzWWxzRjcyeXN2Ry9sL0cyY2RhMG9zeWJQUEo1b0VCSENGVGsvdmt6?=
 =?utf-8?B?cTNheTBEUkdzK0ptS1BHSXhCTEM1dmg5bmk4VFdWdm9SbUI3M0VYaUtDRGpL?=
 =?utf-8?B?VW5ZcDR0ZHdQckxMd1J0Y2hhRER6bGh6Uk5QNURBenZQZlRNNHJiczZCQmxk?=
 =?utf-8?B?a29TVmwyZkFWQ0dIWnp5SnhQZ2R5aDQrTkYycUp1NzU5dlN5dkR3akNOZWtD?=
 =?utf-8?B?a2JFdnVod0ZpYUxGclA0Q09vamorT002ZnNyOXp4ekJMVUtVb3hQOXZVaFc0?=
 =?utf-8?B?cEJuMlNHVmN6Q25RTHptSDZSSTVPUGpiQWs5ZnFCcTBCazk0dWRyTi9TZFZp?=
 =?utf-8?B?eUR4VzdrNk1FVGZybFU0OTZEalZMaVJ6TmN1eXVld1NNVFlobVpoV0QzTkI5?=
 =?utf-8?B?RXM3OVFQd01QTm9kV3hFSFBQczFYc0R3ZWZ1SW0veDBWbVNvUW1mcXNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU9jRXlSc0xSL2dlVHd1cGpuKzF0a3JDREk1ODNGRDR6NnF1K3h4Y085aUp5?=
 =?utf-8?B?aW0wcUs3QnZRNmVKWW04eUQ1bS84R3dTSXYydGRWQTFlcTBpNnlTVkRaM1B2?=
 =?utf-8?B?T25nNU9HYTlmQmlXZ09KVGphWUhNNU5TK21yMnhMRnpmU0tlTGhHVWRETEpO?=
 =?utf-8?B?TVJYdHdFMzZBV1dZNDNJUDd4WE1MV2hLSmdyN2RISENwMWgzY29ISzdRUmgy?=
 =?utf-8?B?dXRTQzEzMUNuT1hNbDRmQTFtaFpnM0JiMjdrN3owSjVyczZTQVNlWUFEQzVZ?=
 =?utf-8?B?N1F3ZmhTWHdjTkVZT1hXaU56cmZZU3NZU3VuVVhzeUJiZThIUERhQmYrNWpq?=
 =?utf-8?B?U1g1ZzZJWEZpSWdKRlBIM3U2dC91RkFSTFN4b3pxTHZ2SDY5RWFGV3g3eVNn?=
 =?utf-8?B?a0c3M1FaU21OL09ZQnJEeVMzV1Q5cnh2aFhjU0dmUkpLWUdHYUNTUVlQanVB?=
 =?utf-8?B?cXlqZ1ZsOE9td1Jod3NSb0pQYkhlaUFVaU5JNW5ZYzd0NVZqMG9STlNMZkNM?=
 =?utf-8?B?cWlwWlhBbWZkak52YVJwUSt1MFRacU4rcUprVlVqWnJsZUhpME5DWnNRQXpP?=
 =?utf-8?B?L3hyRjNveWd3SW1OVkphQWU0bUxSL0tkZmNoN2JESzlMRVZhbjYzZU1ycjdN?=
 =?utf-8?B?UVpSMjYvOER4LzBjOVFYRmFUOEpYV3NtV3VJWWdSY2VNclZsUHpLOWZ5V1hr?=
 =?utf-8?B?Y0dBa2taV2hqMCtEUFUzWC9adTJtTmpiK3JFYmxMNDFnUTdzb3M4azB6VCtz?=
 =?utf-8?B?ZU52QmlYMnNqNHArMkZDbjVsckxCcTRTNHUrbVhmR3JiWUhRbHB2ZkVGcity?=
 =?utf-8?B?by9rVzM2SCtIQVRoSzZjWTJGRC9yNE5pMXIrSnd3ZzJ6Q2M1YkRXdTZJZTBz?=
 =?utf-8?B?K1NRVVljSGlGOVo0UGZDWkhNaysvRHRiZ013SjZnOHNUV0g4OXFiSVpmT2c2?=
 =?utf-8?B?cGNPYXFWbXV0UDNFVGJjRVdxTDVHanJNOWkrUW54dndnbjRPL0VFU08xV1NK?=
 =?utf-8?B?cWRlSUZXbHMrWjYzQmJJRlpxMDB1cnJmM0FXTkJzeWdSL0dwSWRJWm9GMjN0?=
 =?utf-8?B?K1drWkRIWU1rbkM3M2kwdGo2WFhTdnZTUXI3a3ViVGdFSEVjeEp2djN5Yk5G?=
 =?utf-8?B?b3lUZysyNW1HWkFTb3hOU0hMNTllYjREdno2SEpyMUowMDJ1QlMwWVMrSGtI?=
 =?utf-8?B?T2ZQbmw1b0haVDlIUStodHQwcGQvNG5yT3kzVjIzb0FhVXBaTVErNTZHQm13?=
 =?utf-8?B?TnpTOS9xdjVJZVdCSVhuLzR5Q3RnZUQ5SVFmSWlpZ1BEL0FNdS9lejJCWS9Y?=
 =?utf-8?B?aXRXWVNhT2JMdW94V01vTnZzcHdPNHc5ek54L2lwK1cwb291RENNYlk2T0tz?=
 =?utf-8?B?V1I3bVYrVmZlRjlNTFZxb0xrYWJuVEhKRFpvbGRpaVRLT1pTdjJRc2g1bDYv?=
 =?utf-8?B?aXFTenMwR1VYaGVDazRLUldDdVdqRnAvb2FCcklPd0V6WEFyVnJqRkQ5VkF0?=
 =?utf-8?B?WXRlNERYZ3hSVURnYTRjWm4wdVpobU9GbC9KVEdjR2VTM2tvc2tJK3M3ZGdY?=
 =?utf-8?B?cTFkMGl3bzRUSlBWYzluSnR0eUs0NVd5VWpaZTQweFlPU1JEcW10a05KcmNJ?=
 =?utf-8?B?UzF4RC8zeG9ZbXYzbGViSXo4dlprNHFIY2F5eTFiNENrZUlmY3BldHMxQ25V?=
 =?utf-8?B?UEZwakxNVUg0Wlc0N2lEc2FDVkxNd2U2ZzE1Tk5ZMHQyTWEzbHRNUS8xZURz?=
 =?utf-8?B?emJaVG1oVDVuUUVGUERYOUdBMlJ4c0lpY3pSTkt2N29qaEJ4OElIWjFQWWNL?=
 =?utf-8?B?cUZoUVY1T2VvL3FFT21WQm1zSHhLNVZkY21heEVONllra1cxaFZtbS9yVzZL?=
 =?utf-8?B?WHNITm05NGtuVXRZcEN0ZDNyTGE4RmMzY1hGNTRqYUFJMDhOYTdWaUhvbW4x?=
 =?utf-8?B?ZWgvZ2plUzdiQ3RaMzh3WFU3djFYUGlHNC9TTjJnM2tmbGFEcHpmMHRUY2JO?=
 =?utf-8?B?dWVLVDMrQUZZcm1SY3VUMUlmZ2l1aVFyTGdYUzUxRUlIT0JoUmR6SkFIbDVq?=
 =?utf-8?B?YjFOMWtqSlR4RmYrRHpRd0FmSEdFb2hHWHBKUjQvQ2NKOXhIZDN4djFoZUR3?=
 =?utf-8?B?UW9JVE9LR3dra1ROZG5NeGN2TjE3TVExZS9KVnYzWUt1UHZocmJjT1hNV3d3?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2487d5f1-f3ca-431b-dadf-08dcedfaccec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 15:54:21.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFXYV7JwkmiMQC2TVno8hytGMPsfqEnp49ae9y+g6n+l6rYPR6TDsJnkA6/bSwNC8EsrRrEbXFKUbnxq42wMUs+mjdWolrA2YVUUqD1d9Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
X-OriginatorOrg: intel.com

Hi Babu,

On 10/15/24 1:40 PM, Moger, Babu wrote:
> On 9/19/24 10:33, Reinette Chatre wrote:
>> On 9/18/24 11:22 AM, Moger, Babu wrote:
>>> On 9/18/24 10:27, Moger, Babu wrote:
>>>> On 9/13/24 15:45, Reinette Chatre wrote:
>>>>> On 8/16/24 9:16 AM, Babu Moger wrote:
>>>>>> Detect SDCIAE`(L3 Smart Data Cache Injection Allocation Enforcement)
>>>>>
>>>>> (stray ` char)
>>>>
>>>> Sure.
>>>>
>>>>>
>>>>>> feature and initialize sdciae_capable.
>>>>>
>>>>> (This is a repeat of the discussion we had surrounding the ABMC feature.)
>>>>>
>>>>> By adding "sdciae_capable" to struct rdt_resource the "sdciae" feature
>>>>> becomes a resctrl fs feature. Any other architecture that has a "similar
>>>>> but perhaps not identical feature to AMD's SDCIAE" will be forced to also
>>>>> call it "sdciae" ... sdciae seems like a marketing name to me and resctrl
>>>>> needs something generic that could later be built on (if needed) by other
>>>>> architectures.
>>>>
>>>> How about "cache_inject_capable" ?
>>>>
>>>> This seems generic. I will change the description also.
>>>>
>>>
>>> Basically, this feature reserves specific CLOS for SDCI cache.
>>>
>>> We can also name "clos_reserve_capable".
>>
>> Naming is always complicated. I think we should try to stay away from
>> "clos" in a generic name since that creates problem when trying to
>> apply it to Arm and is very specific to how AMD implements this
>> feature. "cache_inject_capable" does sound much better to me ...
>> it also looks like this may be more appropriate as a property
>> of struct resctrl_cache?
> 
> Coming back to this again, I feel 'cache_inject_capable' is kind of very
> generic. Cache injection term is used very generically everywhere.
> 
> Does  'cache_reserve_capable" sound good ?  This is inside the resctrl
> subsystem. We know what it is referring to.
> 

Since this is inside resctrl "cache_reserve_capable" sounds like existing
CAT to me. Could it help if the term "io" appears in the name? Something like
"io_reserve_capable"? When this is a member of struct resctrl_cache it should
be implicit that it refers to the cache.

Reinette

