Return-Path: <linux-kernel+bounces-559922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7241A5FB15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA351889DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFFE26A0AA;
	Thu, 13 Mar 2025 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMu3NT+9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB426988D;
	Thu, 13 Mar 2025 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882151; cv=fail; b=i9YOavecrddnBW1MDcJD8/nFKdRGAlfhyPgOwfY+1pYfYZK7vBXdSQv1doK+MwbEIwduXhz+2KRLf4IGKlqNy1hrbn9Rv5zs6DjvxQV8MWhcftogab5S42dFflgT4oeqJ2VKp06Kxp9FMp2R7pqFE4OHGIMpiQ33Edcyvl5U3AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882151; c=relaxed/simple;
	bh=RSvzmNi4IJSUbM9XsloElxaGJU6lEmApGwkfgAkhz7g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u5XMZvtaDoAfXfdH7AwKcbPEFdfYy+SnKkAcKL818OcoRgF7aQprzJqjHBNX1QFeqK/t1+6ybTJfu6Q45ymVpnL8IeapIeyhuN+/PgQyrFpt0r/Inh9jSnzeG3u4WEF9d3Jx7WxnanaxAGvlRRYM5CkJPY/HRTQNdUVc0TnbbQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMu3NT+9; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741882148; x=1773418148;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RSvzmNi4IJSUbM9XsloElxaGJU6lEmApGwkfgAkhz7g=;
  b=ZMu3NT+9FzZJ9ZEY8o9MVy4t/4bBnysEhq3cGuxq5vczqpwxGHuNrehX
   M7AB1DcPb3PpAJfDpCGZZF2Yc79S39vleN92AjzVF6h5bfzjkr2jo7rI/
   4b/5/mxLUg+xfcTtY6Rmrbr5pgZ01J9zAnjU/NO4a/j907+VWnFFv8KmB
   Oq1VfK8esQe4n/ehj0+2WxvQ/bpjoDK95TMwjF9RQwplNib4LZtCb+QFd
   xrp+UUa6qFaulUdV85nIgDtEB0C4/IyTUpOPJZn9JHTJxvwaI/lmaR700
   36Q5LqfqhQTIsSf9aTJrI6TgJqt063mR06wRapRLXh2sAzQU+fHK2Zw3u
   Q==;
X-CSE-ConnectionGUID: pi596vmiQjWGvMPJDw2OqQ==
X-CSE-MsgGUID: i+Lgv67iT4eA/61RyrczPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42260313"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42260313"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:09:06 -0700
X-CSE-ConnectionGUID: EDKhdRc4RhmSLbKV9KCBVw==
X-CSE-MsgGUID: jZmXZvngQ4iOgzJenbcHjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121936304"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2025 09:09:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 09:09:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 09:09:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 09:09:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOrQxx9px8UvP0rdbyeL3rnW4ynGsPeW773zFL4CEh+P6l0wGoQuBzOVd0503dwp1MqGDUsZhyeUz3A+uwTDDc6kudxyPuEbm2k8gKZ2MpIaVDDPMTVicvaVC6QeXLmcBdDiAqvxIuVyQ3EC4EX9CB3UPu84osequv3NJWGWHMQQmoLna56Is7TAm+N2fg6YwlMjpRMMFWgHkEfzRmosDK3xWq2YkGkezJSSkhNIuEnwaBAWS5yrpnG05FuTATKLVTLUDmeGtIzZc6Zwh1FTGWllz0R5x54xgbvnc92mXlyUejiXn1KS8n3gwRMhwgoVv/axdYUU4EEm96GTiFxXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5k8/OMcpYbAcpYsRwzxgYGfFEA02c/O7JhNEuJX+blU=;
 b=w/VbXZqU+KR736FzpYII1mf4YflhdZ0knlgIet7aOwl9QbOilqofOGoXgfEASpmqWhJWP2lpdrY8NR+vGHCMkckGnK5+OR/C6zlVDatI9Mp3kn5vAf5skyAVh/iIFSvAau55lIjV8YIyy0rkAZRt0rJpJkhVApFSrqmpyWUYGvohDyPT16xL1YJlKSZ1kqecCfNjwanwLps8WZfQun6TwVeqL3g7kgrHGAXn0np3BOUESlmZGBb+tz6yW03/IN220C4zrqDlMRDj85lK1GMy8BdpwD0l7wjqdEpeVggMb370wgm8bh0agWvTggsnka5rvbdCqp0Cb7HpZL4SO6BUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 16:09:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 16:09:00 +0000
Message-ID: <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com>
Date: Thu, 13 Mar 2025 09:08:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: <babu.moger@amd.com>, "Moger, Babu" <bmoger@amd.com>, "Luck, Tony"
	<tony.luck@intel.com>
CC: Peter Newman <peternewman@google.com>, Dave Martin <Dave.Martin@arm.com>,
	<corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com>
 <a9078e7d-9ce6-4096-a2da-b2c6aae1e3ed@amd.com>
 <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
 <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com>
 <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
 <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
 <a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com>
 <c1c0a99a-a467-4ae6-80ee-04b6a9cdb6e5@amd.com>
 <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com>
 <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
 <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com>
 <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba5286d-4ccb-44f0-da6f-08dd62495d85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWU0QjFpNGxjUHhkdU5qL3FjMDBJcjR4N1M2VjIxZU04V3ZkY1JROVlXQ3NK?=
 =?utf-8?B?Y1VTUnU1MlEyWE9oWkNaWjBOUTFlZ1liRVcwMnZqa1h6VVFSMUpmNUFNVGJ0?=
 =?utf-8?B?dW5xK2NUYktscW9DOFQwemRWN1JyMGkzR3FXVFFJNWZwT2JnSnVOMkNLZzdr?=
 =?utf-8?B?RXRTNHZIV21xRG05UGRtWlRLanJmT2FxSUFGT215UTZ3Y1N5N0VkZkwrUVBZ?=
 =?utf-8?B?aXBvNXRrdU13R3RsZWhQUGZwSzVwaW1VT3lPQzBZd2loamRrZEVRaWllTUd6?=
 =?utf-8?B?ZDRtYjVCaGxtS0FXd1BpQUZPWjltT0tlc0V6QTRSYmtDd2F3VkJscXcwL09R?=
 =?utf-8?B?Q3FySGRYd2sxajgyYTJaV2NQVzdDRnZnREFjSDZJWGhucjJaanhZR01WdzN2?=
 =?utf-8?B?ODJ2QXhvYkpmQ0c3K1A3akg3Nk9ObnUzNGREalQwaDdFOTF0Z3MzUDdaTVVC?=
 =?utf-8?B?RlRMMUpoeis2L3lPaitvWGVNSU9kQXNhZFcvUUp0bEtUK1dZTDdyaTVBRm0v?=
 =?utf-8?B?U2hmeWZBekFLeUo1cWdrelQ5VjJTMzNGUFlQRWdWcE1IbnVqcFBUWVIwcFRD?=
 =?utf-8?B?RWpQSEtIbDEyM2p0MUhoWDFDZXBxR1VrdTNRZ0Z2bEZ3cE9JbCtaRXBUcTh4?=
 =?utf-8?B?V3R2MFFTelZ6V2cvL0Y5dHorb0hBVkFrREN2Q3NvMHFFTUZXbjA4c2FIYUlB?=
 =?utf-8?B?R2Q0OVU4S2QzOVQ4Sk1GRGFHZFVPWnhKTkZIOU5QTmZhRFZaMkdMVlVNblBI?=
 =?utf-8?B?Q3J1a041Qm13YjVDVlpmNGt2Q29RRnF5eWdlNDZRTnp5Z21GTklFQldNWE1N?=
 =?utf-8?B?YWVmb1lZRzR5V25IRG5tQjZuc2dEUzZiN0crMmdIOW81bTFFV0M3ejJTeHdv?=
 =?utf-8?B?K212aWxESU5QVDM5WG9rZldxTU9tMUk3V1diN0xkY0dwSnF6VVNJSGZBMldO?=
 =?utf-8?B?RGROU0tUQUIxSDU3ZG83SXRTdnNSU1I2Z1NnMzJ1SmZuckpsKzF6MXB0M3ZV?=
 =?utf-8?B?YXEvWnByR2I5L0VmUHdrZnRoNEJxWXRERHdFMTRYNklPQmdlR1p4c00rajJP?=
 =?utf-8?B?akgxWTRKL0FvclZtMVZ3dzBpUU9VVVZLSjZhNWZBSDJ2NEwyVTNzQnFiOTN3?=
 =?utf-8?B?VWkwd1JPWmJUMUw4RFpFZEN3eEZ3Kzl6Z1NmSlg1Qy9YbUJwWXNlR3UwUzRN?=
 =?utf-8?B?cGVBZXFTS056T2Z6RTlENU1USnprNXFyUDhJbXczdEtWaXFReU5mUEw2ZjBT?=
 =?utf-8?B?RFNlLzFFc0MvdDNmbEM4QkRaNElNTkdBckNlbXdXdTN4YWZ6bDdMZlFramJS?=
 =?utf-8?B?U3hPZWYrRHB2eGZ6MkhNRnpwR0pNQjVaWTB5RlBEVXd5eXN3SDdsa2huSUt6?=
 =?utf-8?B?ZHNLdFNON2I2a3pOK1puK3pEdXI5b2w5ekU2bzlrQjV0aldUc1lPajFOMk55?=
 =?utf-8?B?NENWdEVheVBZVk9nVTk3aXpFZ0JLWkhOOHVaUW9BZGsvNzVnUlJUWEtQSjdj?=
 =?utf-8?B?UHQ5UnBGSlYwUkt4TldSUURTVjJqeXV6d29YbEkwSFl6Q01RL1lvYjNOR09y?=
 =?utf-8?B?SHVNZk5jcGhaemg5MzQ4T3k3Rm5HN0tPcUJEcWUxZmxRdE0vdVc2WHVoLzZt?=
 =?utf-8?B?VjM5bXFlWlplNm5ldEtHb2JxN2hFUDFyL0Q4WEtsZEJjUXUrekRjSmEvSjFD?=
 =?utf-8?B?aWhUSHlRR2pTNWIrSmZkTXZDMFNxZnFrOHBTc2FlLytsWWtuVjdTZ2N1T1ZV?=
 =?utf-8?B?V1dnK1VpMjNIdWhJT012MjZpSmRLR3Z3K2VabEJsZ0ljNWVLVnBibitJdVdQ?=
 =?utf-8?B?dmxCM3JiQ3RBbWdqU0FUV1J0ekZVZEFqQjNQclFCWWZzWVNRZFJyWXJ3SFJx?=
 =?utf-8?B?eHM2ZWhWWllUdEVSRWtJOVUxYVBHTWRFbVpUVVB4SGJRSEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2dFdSthUmFBSmNrSnpyWWtqeXFVUUlUeFFYZG44bVllSTdTU05jcUk4dHhC?=
 =?utf-8?B?SzhyeWhWSmdUMEpCWE1xWjF4MS8rMlZyVEgyVTZMS2pPbENBdU9aQVRzeGNh?=
 =?utf-8?B?a05HVGNWN0hmTjR0Q2hwY040V2cvQiswc3kzNTliNk5nSjkzN2pkN0hPWjJE?=
 =?utf-8?B?eUcwWm1rd3BVcVJUMlJTU09MdEd2czNYb1ZCY0g0eHprSytVQ0ZFclAwOEFy?=
 =?utf-8?B?aU4yWUIxaSt1SUhuM1EvWXVEaSsrYldPQ0pVZ0FTK1pxTWx0b01yYnBXbTBj?=
 =?utf-8?B?RG1vNG8wc1NVOUVkaUhsSXRRY2E3aFF2OFY2TFkvVG41OWRPYWVmbG1XZnkv?=
 =?utf-8?B?QjhLMHA3ajlvZDVWbExqNHNGYXYzZjQ3QTJsVHR6cU9yVU5RQ2crVUswbEhy?=
 =?utf-8?B?azZxUUQzcURjNmZoWjZjS0szSHdHUGVOUWVtR3dCMERSMiszcXNiYzJYU2Ry?=
 =?utf-8?B?cFZiUDQ0Sk9OQjdrbDIzWmF6ajNOT1dmUTFyaGZOUGM4S09hVXQ3L1IyQWls?=
 =?utf-8?B?UnVFa3pzTGpvNi94azRqNDJnSmo4ZXhySCsxNWdMRHE5eXRDV1U5THlaYjI4?=
 =?utf-8?B?d2NvL0dhdjgyb3JQVnlsTGJKS3NoU001SXdnMUZRdUl5MGhGZFZ4ZDdERXor?=
 =?utf-8?B?TGkvQjhVM0d5TlRrenkweCs1aDVOOUZNYlBuaHRCc2NaTVdDUGxYZVVpR2RM?=
 =?utf-8?B?KytVMzRYOHhiaVlCTk1LZ0VGclFIMGx4VlB0UDA2aWh5YjhrTS9WR0tBOGhD?=
 =?utf-8?B?TVVzSFFveGZVV2VCSWVtZGxSTzQyKzMvRFR1bEhFcDE0aGJSc25mVVFqWjd1?=
 =?utf-8?B?c1pnd3Z4MjVaL0FFQmlaYUZHMW90Nm1xaWl1TEUweUVieUlXM1ZBOEJVUldV?=
 =?utf-8?B?c2tTdzd3OVVOTUdweUh2Ty9DTnlpS3JGdStBRDFTcVJ6VitNdEY2ZVZhdVRP?=
 =?utf-8?B?NEk2eE41K2t1UTMrRnF6Y2JnZ3krYVRMb1V1UmZkZDk5UUZpWmt1Ukw5ZUU5?=
 =?utf-8?B?QmFxc3huYjVieVRKV3NiVzZ3L2ZoZG1rZ0J5Z21XZDFJOTlST3JQMGxhUWgr?=
 =?utf-8?B?cU0yd0R0cHBRdzBHSThOUHg3aWdHTG1iMzJYUndVdVArei9od3UyU01wUHBY?=
 =?utf-8?B?S01UUWdzQ0tobWtwTHVUSnhYNVNjZDdnTGdkS3R4a0JJcWtlSWFhWU9BOFBv?=
 =?utf-8?B?NisxdWpKT1FwbHY2VkcrTFJjYkdaRmVjS3RLOEw0ZDdiYnMycDdhd3BDMW5Z?=
 =?utf-8?B?SkdsdjZCNWNkV3JMckZXS2hIZ2FLWVlrZUtnQ3BveXdyNDJxRjFrQVpCdHg4?=
 =?utf-8?B?ZngyV3NwMktCcWRtbnVsWVRIYllDZ2JSTStnUVQzaEJEdjVJRm1XeGo4TkRq?=
 =?utf-8?B?UlF6UzlZMzFtV05KWGZaYlpHQTFjMUhNbHVsNCtGNEJkdGIwTGtWMElISGJZ?=
 =?utf-8?B?NXpnUnZZazVDUzIyVHM1MmMyQlk3YnllN1BJSXFQVGE3WU5rWmRVUis1SjBQ?=
 =?utf-8?B?L25aTmtLdE84WGhkeGxEem1yMk9GOFhUUVVZYjRzWnlDUCsxVFBPejY5KzVW?=
 =?utf-8?B?NTBhSUtFOFhIKytCV1JONnUzeTZFTTE2TGw4WTZIeWdSLzJZT3FwcmhtMVBG?=
 =?utf-8?B?Ky82dTdFSldpTzhkZjVGWXA0YllqYkdTdXpYTGFCdGhpYithTnVRRGd6eCtZ?=
 =?utf-8?B?NFpoZlRUUTFxZ2JJMG1sVmNXSmtsa1VJL1FjUlltdlY0RzE0Rk5oTHFxcFBT?=
 =?utf-8?B?bG1ZMDA3Ynk3cjdXZUd1Y1RCRW9LNjFGYThVcy9yb1Vib3dySVNiNURudUJk?=
 =?utf-8?B?dnluUWFraUluQ3Rvc2ZkcW5XRWlrbEtndEc2d1o4Q1R5ZWkzdzl1ZzNHdmVV?=
 =?utf-8?B?MVBkZGhnekNrdm5rdHVBY1E1MVpOUk9OcnU0b2JKcDZoZi9HU1dJZWJpTmY5?=
 =?utf-8?B?c3MyMWFMVzFFK2tRbjVpV1lkcUt4WU5OTjNac0M1SkpYL0szV2VUMk45QnBY?=
 =?utf-8?B?K1BCRElMNUhoK2sxU0tRVHBMRWVROUxvMFovWVNxZVBwZCthRkJENVRqM05z?=
 =?utf-8?B?aEt6ZW9SWGtLR3NML1BxZjh2ZE5id1VENlRhbmRHQ2I5Y09vTmRNdWF5b1JG?=
 =?utf-8?B?L2pWeitwNlcrNnh1RjRyM0E1M3hmT1pvbTVmcmJ2Y1BFYU9vY0lwQ2Y4YXB1?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba5286d-4ccb-44f0-da6f-08dd62495d85
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 16:09:00.0406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlaNnOP71DRAm+7FlFJTzflue7hZzRZtfleqHhuatafAPxRG6SKL8vagMIlNwyK+rRqU/MNXoKvJizMICjTmXoCqeKGcSP284kE3RBu/kKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
X-OriginatorOrg: intel.com

Hi Babu,

On 3/12/25 11:14 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 3/12/25 12:14, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 3/12/25 9:03 AM, Moger, Babu wrote:
>>> Hi Reinette,
>>>
>>> On 3/12/25 10:07, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> On 3/11/25 1:35 PM, Moger, Babu wrote:
>>>>> Hi All,
>>>>>
>>>>> On 3/10/25 22:51, Reinette Chatre wrote:
>>>>>>
>>>>>>
>>>>>> On 3/10/25 6:44 PM, Moger, Babu wrote:
>>>>>>> Hi Tony,
>>>>>>>
>>>>>>> On 3/10/2025 6:22 PM, Luck, Tony wrote:
>>>>>>>> On Mon, Mar 10, 2025 at 05:48:44PM -0500, Moger, Babu wrote:
>>>>>>>>> Hi All,
>>>>>>>>>
>>>>>>>>> On 3/5/2025 1:34 PM, Moger, Babu wrote:
>>>>>>>>>> Hi Peter,
>>>>>>>>>>
>>>>>>>>>> On 3/5/25 04:40, Peter Newman wrote:
>>>>>>>>>>> Hi Babu,
>>>>>>>>>>>
>>>>>>>>>>> On Tue, Mar 4, 2025 at 10:49 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi Peter,
>>>>>>>>>>>>
>>>>>>>>>>>> On 3/4/25 10:44, Peter Newman wrote:
>>>>>>>>>>>>> On Mon, Mar 3, 2025 at 8:16 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hi Peter/Reinette,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 2/26/25 07:27, Peter Newman wrote:
>>>>>>>>>>>>>>> Hi Babu,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Tue, Feb 25, 2025 at 10:31 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Hi Peter,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 2/25/25 11:11, Peter Newman wrote:
>>>>>>>>>>>>>>>>> Hi Reinette,
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On Fri, Feb 21, 2025 at 11:43 PM Reinette Chatre
>>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Hi Peter,
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> On 2/21/25 5:12 AM, Peter Newman wrote:
>>>>>>>>>>>>>>>>>>> On Thu, Feb 20, 2025 at 7:36 PM Reinette Chatre
>>>>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>>>>> On 2/20/25 6:53 AM, Peter Newman wrote:
>>>>>>>>>>>>>>>>>>>>> On Wed, Feb 19, 2025 at 7:21 PM Reinette Chatre
>>>>>>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>>>>>>> On 2/19/25 3:28 AM, Peter Newman wrote:
>>>>>>>>>>>>>>>>>>>>>>> On Tue, Feb 18, 2025 at 6:50 PM Reinette Chatre
>>>>>>>>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>>>>>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
>>>>>>>>>>>>>>>>>>>>>>>>> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
>>>>>>>>>>>>>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Please help me understand if you see it differently.
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> mbm_local_read_bytes a
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> mbm_local_write_bytes b
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Then mbm_assign_control can be used as:
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> <value>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>> As mentioned above, one possible issue with existing interface is that
>>>>>>>>>>>>>>>>>>>>>>>>>> it is limited to 26 events (assuming only lower case letters are used). The limit
>>>>>>>>>>>>>>>>>>>>>>>>>> is low enough to be of concern.
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>> The events which can be monitored by a single counter on ABMC and MPAM
>>>>>>>>>>>>>>>>>>>>>>>>> so far are combinable, so 26 counters per group today means it limits
>>>>>>>>>>>>>>>>>>>>>>>>> breaking down MBM traffic for each group 26 ways. If a user complained
>>>>>>>>>>>>>>>>>>>>>>>>> that a 26-way breakdown of a group's MBM traffic was limiting their
>>>>>>>>>>>>>>>>>>>>>>>>> investigation, I would question whether they know what they're looking
>>>>>>>>>>>>>>>>>>>>>>>>> for.
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> The key here is "so far" as well as the focus on MBM only.
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> It is impossible for me to predict what we will see in a couple of years
>>>>>>>>>>>>>>>>>>>>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
>>>>>>>>>>>>>>>>>>>>>>>> to support their users. Just looking at the Intel RDT spec the event register
>>>>>>>>>>>>>>>>>>>>>>>> has space for 32 events for each "CPU agent" resource. That does not take into
>>>>>>>>>>>>>>>>>>>>>>>> account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
>>>>>>>>>>>>>>>>>>>>>>>> that he is working on patches [1] that will add new events and shared the idea
>>>>>>>>>>>>>>>>>>>>>>>> that we may be trending to support "perf" like events associated with RMID. I
>>>>>>>>>>>>>>>>>>>>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements to support their
>>>>>>>>>>>>>>>>>>>>>>>> customers.
>>>>>>>>>>>>>>>>>>>>>>>> This all makes me think that resctrl should be ready to support more events than 26.
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> I was thinking of the letters as representing a reusable, user-defined
>>>>>>>>>>>>>>>>>>>>>>> event-set for applying to a single counter rather than as individual
>>>>>>>>>>>>>>>>>>>>>>> events, since MPAM and ABMC allow us to choose the set of events each
>>>>>>>>>>>>>>>>>>>>>>> one counts. Wherever we define the letters, we could use more symbolic
>>>>>>>>>>>>>>>>>>>>>>> event names.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> Thank you for clarifying.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> In the letters as events model, choosing the events assigned to a
>>>>>>>>>>>>>>>>>>>>>>> group wouldn't be enough information, since we would want to control
>>>>>>>>>>>>>>>>>>>>>>> which events should share a counter and which should be counted by
>>>>>>>>>>>>>>>>>>>>>>> separate counters. I think the amount of information that would need
>>>>>>>>>>>>>>>>>>>>>>> to be encoded into mbm_assign_control to represent the level of
>>>>>>>>>>>>>>>>>>>>>>> configurability supported by hardware would quickly get out of hand.
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> Maybe as an example, one counter for all reads, one counter for all
>>>>>>>>>>>>>>>>>>>>>>> writes in ABMC would look like...
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> (L3_QOS_ABMC_CFG.BwType field names below)
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> (per domain)
>>>>>>>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>>>>>>>    counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>>>>    counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>>>>>>>    counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>>>>    counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> I think this may also be what Dave was heading towards in [2] but in that
>>>>>>>>>>>>>>>>>>>>>> example and above the counter configuration appears to be global. You do mention
>>>>>>>>>>>>>>>>>>>>>> "configurability supported by hardware" so I wonder if per-domain counter
>>>>>>>>>>>>>>>>>>>>>> configuration is a requirement?
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> If it's global and we want a particular group to be watched by more
>>>>>>>>>>>>>>>>>>>>> counters, I wouldn't want this to result in allocating more counters
>>>>>>>>>>>>>>>>>>>>> for that group in all domains, or allocating counters in domains where
>>>>>>>>>>>>>>>>>>>>> they're not needed. I want to encourage my users to avoid allocating
>>>>>>>>>>>>>>>>>>>>> monitoring resources in domains where a job is not allowed to run so
>>>>>>>>>>>>>>>>>>>>> there's less pressure on the counters.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> In Dave's proposal it looks like global configuration means
>>>>>>>>>>>>>>>>>>>>> globally-defined "named counter configurations", which works because
>>>>>>>>>>>>>>>>>>>>> it's really per-domain assignment of the configurations to however
>>>>>>>>>>>>>>>>>>>>> many counters the group needs in each domain.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> I think I am becoming lost. Would a global configuration not break your
>>>>>>>>>>>>>>>>>>>> view of "event-set applied to a single counter"? If a counter is configured
>>>>>>>>>>>>>>>>>>>> globally then it would not make it possible to support the full configurability
>>>>>>>>>>>>>>>>>>>> of the hardware.
>>>>>>>>>>>>>>>>>>>> Before I add more confusion, let me try with an example that builds on your
>>>>>>>>>>>>>>>>>>>> earlier example copied below:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> (per domain)
>>>>>>>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>>>>>>>    counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>>>>    counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>>>>>>>    counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>>>>    counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Since the above states "per domain" I rewrite the example to highlight that as
>>>>>>>>>>>>>>>>>>>> I understand it:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> You mention that you do not want counters to be allocated in domains that they
>>>>>>>>>>>>>>>>>>>> are not needed in. So, let's say group 0 does not need counter 0 and counter 1
>>>>>>>>>>>>>>>>>>>> in domain 1, resulting in:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> With counter 0 and counter 1 available in domain 1, these counters could
>>>>>>>>>>>>>>>>>>>> theoretically be configured to give group 1 more data in domain 1:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> group 0:
>>>>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>     counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>> group 1:
>>>>>>>>>>>>>>>>>>>>    domain 0:
>>>>>>>>>>>>>>>>>>>>     counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>     counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>    domain 1:
>>>>>>>>>>>>>>>>>>>>     counter 0: LclFill,RmtFill
>>>>>>>>>>>>>>>>>>>>     counter 1: LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>>     counter 2: LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>>     counter 3: VictimBW
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> The counters are shown with different per-domain configurations that seems to
>>>>>>>>>>>>>>>>>>>> match with earlier goals of (a) choose events counted by each counter and
>>>>>>>>>>>>>>>>>>>> (b) do not allocate counters in domains where they are not needed. As I
>>>>>>>>>>>>>>>>>>>> understand the above does contradict global counter configuration though.
>>>>>>>>>>>>>>>>>>>> Or do you mean that only the *name* of the counter is global and then
>>>>>>>>>>>>>>>>>>>> that it is reconfigured as part of every assignment?
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Yes, I meant only the *name* is global. I assume based on a particular
>>>>>>>>>>>>>>>>>>> system configuration, the user will settle on a handful of useful
>>>>>>>>>>>>>>>>>>> groupings to count.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Perhaps mbm_assign_control syntax is the clearest way to express an example...
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>    # define global configurations (in ABMC terms), not necessarily in this
>>>>>>>>>>>>>>>>>>>    # syntax and probably not in the mbm_assign_control file.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>    r=LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>>>>>>>    w=VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>    # legacy "total" configuration, effectively r+w
>>>>>>>>>>>>>>>>>>>    t=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>    /group0/0=t;1=t
>>>>>>>>>>>>>>>>>>>    /group1/0=t;1=t
>>>>>>>>>>>>>>>>>>>    /group2/0=_;1=t
>>>>>>>>>>>>>>>>>>>    /group3/0=rw;1=_
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> - group2 is restricted to domain 0
>>>>>>>>>>>>>>>>>>> - group3 is restricted to domain 1
>>>>>>>>>>>>>>>>>>> - the rest are unrestricted
>>>>>>>>>>>>>>>>>>> - In group3, we decided we need to separate read and write traffic
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> This consumes 4 counters in domain 0 and 3 counters in domain 1.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I see. Thank you for the example.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> resctrl supports per-domain configurations with the following possible when
>>>>>>>>>>>>>>>>>> using mbm_total_bytes_config and mbm_local_bytes_config:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> t(domain 0)=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>> t(domain 1)=LclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>      /group0/0=t;1=t
>>>>>>>>>>>>>>>>>>      /group1/0=t;1=t
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Even though the flags are identical in all domains, the assigned counters will
>>>>>>>>>>>>>>>>>> be configured differently in each domain.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> With this supported by hardware and currently also supported by resctrl it seems
>>>>>>>>>>>>>>>>>> reasonable to carry this forward to what will be supported next.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> The hardware supports both a per-domain mode, where all groups in a
>>>>>>>>>>>>>>>>> domain use the same configurations and are limited to two events per
>>>>>>>>>>>>>>>>> group and a per-group mode where every group can be configured and
>>>>>>>>>>>>>>>>> assigned freely. This series is using the legacy counter access mode
>>>>>>>>>>>>>>>>> where only counters whose BwType matches an instance of QOS_EVT_CFG_n
>>>>>>>>>>>>>>>>> in the domain can be read. If we chose to read the assigned counter
>>>>>>>>>>>>>>>>> directly (QM_EVTSEL[ExtendedEvtID]=1, QM_EVTSEL[EvtID]=L3CacheABMC)
>>>>>>>>>>>>>>>>> rather than asking the hardware to find the counter by RMID, we would
>>>>>>>>>>>>>>>>> not be limited to 2 counters per group/domain and the hardware would
>>>>>>>>>>>>>>>>> have the same flexibility as on MPAM.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> In extended mode, the contents of a specific counter can be read by
>>>>>>>>>>>>>>>> setting the following fields in QM_EVTSEL: [ExtendedEvtID]=1,
>>>>>>>>>>>>>>>> [EvtID]=L3CacheABMC and setting [RMID] to the desired counter ID. Reading
>>>>>>>>>>>>>>>> QM_CTR will then return the contents of the specified counter.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> It is documented below.
>>>>>>>>>>>>>>>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
>>>>>>>>>>>>>>>>    Section: 19.3.3.3 Assignable Bandwidth Monitoring (ABMC)
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> We previously discussed this with you (off the public list) and I
>>>>>>>>>>>>>>>> initially proposed the extended assignment mode.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Yes, the extended mode allows greater flexibility by enabling multiple
>>>>>>>>>>>>>>>> counters to be assigned to the same group, rather than being limited to
>>>>>>>>>>>>>>>> just two.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> However, the challenge is that we currently lack the necessary interfaces
>>>>>>>>>>>>>>>> to configure multiple events per group. Without these interfaces, the
>>>>>>>>>>>>>>>> extended mode is not practical at this time.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Therefore, we ultimately agreed to use the legacy mode, as it does not
>>>>>>>>>>>>>>>> require modifications to the existing interface, allowing us to continue
>>>>>>>>>>>>>>>> using it as is.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> (I might have said something confusing in my last messages because I
>>>>>>>>>>>>>>>>> had forgotten that I switched to the extended assignment mode when
>>>>>>>>>>>>>>>>> prototyping with soft-ABMC and MPAM.)
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Forcing all groups on a domain to share the same 2 counter
>>>>>>>>>>>>>>>>> configurations would not be acceptable for us, as the example I gave
>>>>>>>>>>>>>>>>> earlier is one I've already been asked about.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I don’t see this as a blocker. It should be considered an extension to the
>>>>>>>>>>>>>>>> current ABMC series. We can easily build on top of this series once we
>>>>>>>>>>>>>>>> finalize how to configure the multiple event interface for each group.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I don't think it is, either. Only being able to use ABMC to assign
>>>>>>>>>>>>>>> counters is fine for our use as an incremental step. My longer-term
>>>>>>>>>>>>>>> concern is the domain-scoped mbm_total_bytes_config and
>>>>>>>>>>>>>>> mbm_local_bytes_config files, but they were introduced with BMEC, so
>>>>>>>>>>>>>>> there's already an expectation that the files are present when BMEC is
>>>>>>>>>>>>>>> supported.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On ABMC hardware that also supports BMEC, I'm concerned about enabling
>>>>>>>>>>>>>>> ABMC when only the BMEC-style event configuration interface exists.
>>>>>>>>>>>>>>> The scope of my issue is just whether enabling "full" ABMC support
>>>>>>>>>>>>>>> will require an additional opt-in, since that could remove the BMEC
>>>>>>>>>>>>>>> interface. If it does, it's something we can live with.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> As you know, this series is currently blocked without further feedback.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I’d like to begin reworking these patches to incorporate Peter’s feedback.
>>>>>>>>>>>>>> Any input or suggestions would be appreciated.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Here’s what we’ve learned so far:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 1. Assignments should be independent of BMEC.
>>>>>>>>>>>>>> 2. We should be able to specify multiple event types to a counter (e.g.,
>>>>>>>>>>>>>> read, write, victimBM, etc.). This is also called shared counter
>>>>>>>>>>>>>> 3. There should be an option to assign events per domain.
>>>>>>>>>>>>>> 4. Currently, only two counters can be assigned per group, but the design
>>>>>>>>>>>>>> should allow flexibility to assign more in the future as the interface
>>>>>>>>>>>>>> evolves.
>>>>>>>>>>>>>> 5. Utilize the extended RMID read mode.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Here is my proposal using Peter's earlier example:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> # define event configurations
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> ========================================================
>>>>>>>>>>>>>> Bits    Mnemonics       Description
>>>>>>>>>>>>>> ====   ========================================================
>>>>>>>>>>>>>> 6       VictimBW        Dirty Victims from all types of memory
>>>>>>>>>>>>>> 5       RmtSlowFill     Reads to slow memory in the non-local NUMA domain
>>>>>>>>>>>>>> 4       LclSlowFill     Reads to slow memory in the local NUMA domain
>>>>>>>>>>>>>> 3       RmtNTWr         Non-temporal writes to non-local NUMA domain
>>>>>>>>>>>>>> 2       LclNTWr         Non-temporal writes to local NUMA domain
>>>>>>>>>>>>>> 1       mtFill          Reads to memory in the non-local NUMA domain
>>>>>>>>>>>>>> 0       LclFill         Reads to memory in the local NUMA domain
>>>>>>>>>>>>>> ====    ========================================================
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> #Define flags based on combination of above event types.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> t = LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>> l = LclFill, LclNTWr, LclSlowFill
>>>>>>>>>>>>>> r = LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>>>> w = VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>>>>> v = VictimBW
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Peter suggested the following format earlier :
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> /group0/0=t;1=t
>>>>>>>>>>>>>> /group1/0=t;1=t
>>>>>>>>>>>>>> /group2/0=_;1=t
>>>>>>>>>>>>>> /group3/0=rw;1=_
>>>>>>>>>>>>>
>>>>>>>>>>>>> After some inquiries within Google, it sounds like nobody has invested
>>>>>>>>>>>>> much into the current mbm_assign_control format yet, so it would be
>>>>>>>>>>>>> best to drop it and distribute the configuration around the filesystem
>>>>>>>>>>>>> hierarchy[1], which should allow us to produce something more flexible
>>>>>>>>>>>>> and cleaner to implement.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Roughly what I had in mind:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Use mkdir in a info/<resource>_MON subdirectory to create free-form
>>>>>>>>>>>>> names for the assignable configurations rather than being restricted
>>>>>>>>>>>>> to single letters.  In the resulting directory, populate a file where
>>>>>>>>>>>>> we can specify the set of events the config should represent. I think
>>>>>>>>>>>>> we should use symbolic names for the events rather than raw BMEC field
>>>>>>>>>>>>> values. Moving forward we could come up with portable names for common
>>>>>>>>>>>>> events and only support the BMEC names on AMD machines for users who
>>>>>>>>>>>>> want specific events and don't care about portability.
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I’m still processing this. Let me start with some initial questions.
>>>>>>>>>>>>
>>>>>>>>>>>> So, we are creating event configurations here, which seems reasonable.
>>>>>>>>>>>>
>>>>>>>>>>>> Yes, we should use portable names and are not limited to BMEC names.
>>>>>>>>>>>>
>>>>>>>>>>>> How many configurations should we allow? Do we know?
>>>>>>>>>>>
>>>>>>>>>>> Do we need an upper limit?
>>>>>>>>>>
>>>>>>>>>> I think so. This needs to be maintained in some data structure. We can
>>>>>>>>>> start with 2 default configurations for now.
>>>>>>
>>>>>> There is a big difference between no upper limit and 2. The hardware is
>>>>>> capable of supporting per-domain configurations so more flexibility is
>>>>>> certainly possible. Consider the example presented by Peter in:
>>>>>> https://lore.kernel.org/lkml/CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com/
>>>>>>
>>>>>>>>>>>>> Next, put assignment-control file nodes in per-domain directories
>>>>>>>>>>>>> (i.e., mon_data/mon_L3_00/assign_{exclusive,shared}). Writing a
>>>>>>>>>>>>> counter-configuration name into the file would then allocate a counter
>>>>>>>>>>>>> in the domain, apply the named configuration, and monitor the parent
>>>>>>>>>>>>> group-directory. We can also put a group/resource-scoped assign_* file
>>>>>>>>>>>>> higher in the hierarchy to make it easier for users who want to
>>>>>>>>>>>>> configure all domains the same for a group.
>>>>>>>>>>>>
>>>>>>>>>>>> What is the difference between shared and exclusive?
>>>>>>>>>>>
>>>>>>>>>>> Shared assignment[1] means that non-exclusively-assigned counters in
>>>>>>>>>>> each domain will be scheduled round-robin to the groups requesting
>>>>>>>>>>> shared access to a counter. In my tests, I assigned the counters long
>>>>>>>>>>> enough to produce a single 1-second MB/s sample for the per-domain
>>>>>>>>>>> aggregation files[2].
>>>>>>>>>>>
>>>>>>>>>>> These do not need to be implemented immediately, but knowing that they
>>>>>>>>>>> work addresses the overhead and scalability concerns of reassigning
>>>>>>>>>>> counters and reading their values.
>>>>>>>>>>
>>>>>>>>>> Ok. Lets focus on exclusive assignments for now.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Having three files—assign_shared, assign_exclusive, and unassign—for each
>>>>>>>>>>>> domain seems excessive. In a system with 32 groups and 12 domains, this
>>>>>>>>>>>> results in 32 × 12 × 3 files, which is quite large.
>>>>>>>>>>>>
>>>>>>>>>>>> There should be a more efficient way to handle this.
>>>>>>>>>>>>
>>>>>>>>>>>> Initially, we started with a group-level file for this interface, but it
>>>>>>>>>>>> was rejected due to the high number of sysfs calls, making it inefficient.
>>>>>>>>>>>
>>>>>>>>>>> I had rejected it due to the high-frequency of access of a large
>>>>>>>>>>> number of files, which has since been addressed by shared assignment
>>>>>>>>>>> (or automatic reassignment) and aggregated mbps files.
>>>>>>>>>>
>>>>>>>>>> I think we should address this as well. Creating three extra files for
>>>>>>>>>> each group isn’t ideal when there are more efficient alternatives.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Additionally, how can we list all assignments with a single sysfs call?
>>>>>>>>>>>>
>>>>>>>>>>>> That was another problem we need to address.
>>>>>>>>>>>
>>>>>>>>>>> This is not a requirement I was aware of. If the user forgot where
>>>>>>>>>>> they assigned counters (or forgot to disable auto-assignment), they
>>>>>>>>>>> can read multiple sysfs nodes to remind themselves.
>>>>>>>>>>
>>>>>>>>>> I suggest, we should provide users with an option to list the assignments
>>>>>>>>>> of all groups in a single command. As the number of groups increases, it
>>>>>>>>>> becomes cumbersome to query each group individually.
>>>>>>>>>>
>>>>>>>>>> To achieve this, we can reuse our existing mbm_assign_control interface
>>>>>>>>>> for this purpose. More details on this below.
>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> The configuration names listed in assign_* would result in files of
>>>>>>>>>>>>> the same name in the appropriate mon_data domain directories from
>>>>>>>>>>>>> which the count values can be read.
>>>>>>>>>>>>>
>>>>>>>>>>>>>    # mkdir info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>>>>>>>>    # echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>>>>>>>    # echo LclNTWr > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>>>>>>>    # echo LclSlowFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>>>>>>>    # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>>>>>>>>>> LclFill
>>>>>>>>>>>>> LclNTWr
>>>>>>>>>>>>> LclSlowFill
>>>>>>>>>>>>
>>>>>>>>>>>> I feel we can just have the configs. event_filter file is not required.
>>>>>>>>>>>
>>>>>>>>>>> That's right, I forgot that we can implement kernfs_ops::open(). I was
>>>>>>>>>>> only looking at struct kernfs_syscall_ops
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> #cat info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>>>>>>> LclFill <-rename these to generic names.
>>>>>>>>>>>> LclNTWr
>>>>>>>>>>>> LclSlowFill
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I think portable and non-portable event names should both be available
>>>>>>>>>>> as options. There are simple bandwidth measurement mechanisms that
>>>>>>>>>>> will be applied in general, but when they turn up an issue, it can
>>>>>>>>>>> often lead to a more focused investigation, requiring more precise
>>>>>>>>>>> events.
>>>>>>>>>>
>>>>>>>>>> I aggree. We should provide both portable and non-portable event names.
>>>>>>>>>>
>>>>>>>>>> Here is my draft proposal based on the discussion so far and reusing some
>>>>>>>>>> of the current interface. Idea here is to start with basic assigment
>>>>>>>>>> feature with options to enhance it in the future. Feel free to
>>>>>>>>>> comment/suggest.
>>>>>>>>>>
>>>>>>>>>> 1. Event configurations will be in
>>>>>>>>>>      /sys/fs/resctrl/info/L3_MON/counter_configs/.
>>>>>>>>>>
>>>>>>>>>>      There will be two pre-defined configurations by default.
>>>>>>>>>>
>>>>>>>>>>      #cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_total_bytes
>>>>>>>>>>      LclFill, LclNTWr,LclSlowFill,VictimBM,RmtSlowFill,LclSlowFill,RmtFill
>>>>>>>>>>
>>>>>>>>>>      #cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>>>>>      LclFill, LclNTWr, LclSlowFill
>>>>>>>>>>
>>>>>>>>>> 2. Users will have options to update these configurations.
>>>>>>>>>>
>>>>>>>>>>      #echo "LclFill, LclNTWr, RmtFill" >
>>>>>>>>>>         /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>>>
>>>>>>>> This part seems odd to me. Now the "mbm_local_bytes" files aren't
>>>>>>>> reporting "local_bytes" any more. They report something different,
>>>>>>>> and users only know if they come to check the options currently
>>>>>>>> configured in this file. Changing the contents without changing
>>>>>>>> the name seems confusing to me.
>>>>>>>
>>>>>>> It is the same behaviour right now with BMEC. It is configurable.
>>>>>>> By default it is mbm_local_bytes, but users can configure whatever they want to monitor using /info/L3_MON/mbm_local_bytes_config.
>>>>>>>
>>>>>>> We can continue the same behaviour with ABMC, but the configuration will be in /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes.
>>>>>>
>>>>>> This could be supported by following Peter's original proposal where the name
>>>>>> of the counter configuration is provided by the user via a mkdir:
>>>>>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
>>>>>>
>>>>>> As he mentioned there could be pre-populated mbm_local_bytes/mbm_total_bytes.
>>>>>
>>>>> Sure. We can do that. I was thinking in the first phase, just provide the
>>>>> default pre-defined configuration and option to update the configuration.
>>>>>
>>>>> We can add the mkdir support later. That way we can provide basic ABMC
>>>>> support without too much code complexity with mkdir support.
>>>>
>>>> This is not clear to me how you envision the "first phase". Is it what you
>>>> proposed above, for example:
>>>>       #echo "LclFill, LclNTWr, RmtFill" >
>>>>          /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>>
>>>> In above the counter configuration name is a file. 
>>>
>>> Yes. That is correct.
>>>
>>> There will be two configuration files by default when resctrl is mounted
>>> when ABMC is enabled.
>>> /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_total_bytes
>>> /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>
>>>>
>>>> How could mkdir support be added to this later if there are already files present?
>>>
>>> We already have these directories when resctrl is mounted.
>>> /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_total_bytes
>>> /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_local_bytes
>>> /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_total_bytes
>>> /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_local_bytes
>>>
>>> We dont need "mkdir" support for default  configurations.
>>
>> I was referring to the "mkdir" support for additional configurations that
>> I understood you are thinking about adding later. For example,
>> (copied from Peter's message
>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/):
>>
>>
>>  # mkdir info/L3_MON/counter_configs/mbm_local_bytes
>>  # echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>  # echo LclNTWr > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>  # echo LclSlowFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>  # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>> LclFill
>> LclNTWr
>> LclSlowFill
>>
>> Any "later" work needs to be backward compatible with the first phase.
> 
> Actually, we dont need extra file "event_filter".
> This was discussed here.
> https://lore.kernel.org/lkml/CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com/

I undestand from that exchange that it is possible to read/write from
an *existing* kernfs file but it is not obvious to me how that file is
planned to be created.

My understanding of the motivation behind support for "mkdir" is to enable
user space to create custom counter configurations.

I understand that ABMC support aims to start with existing mbm_total_bytes/mbm_local_bytes
configurations but I believe the consensus is that custom configurations need
to be supported in the future.
If resctrl starts with support where counter configuration as
managed with a *file*, for example:
/sys/fs/resctrl/info/L3_MON/counter_configs/mbm_total_bytes
how will user space create future custom configurations?
As I understand that is only possible with mkdir.

> 
> # echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes
> # echo LclNTWr > info/L3_MON/counter_configs/mbm_local_bytes
> # echo LclSlowFill > info/L3_MON/counter_configs/mbm_local_bytes
> # cat info/L3_MON/counter_configs/mbm_local_bytes
>  LclFill
>  LclNTWr
>  LclSlowFill
> 
> In the future, we can add mkdir support.
> 
> # mkdir info/L3_MON/counter_configs/mbm_read_only

This is exactly my concern. resctrl should not start with a user space where
a counter configuration is a file (mbm_local_bytes/mbm_total_bytes) and then
switch user space interface to have counter configuration be done with
directories.

> # echo LclFill > info/L3_MON/counter_configs/mbm_read_only
> # cat info/L3_MON/counter_configs/mbm_read_only
>   LclFill

... wait ... user space writes to the directory?



> 
> #echo mbm_read_only > test/mon_data/mon_L3_00/assign_exclusive
> 
> Which would result in the creation of test/mon_data/mon_L3_*/mbm_read_only
> 
> So, there is not breakage of backword compatibility.

The way I understand it I am seeing many incompatibilities. Perhaps I am missing
something. Could you please provide detailed steps of how first phase and
second phase would look?


> 
>>
>> If the first phase starts with a file:
>> /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>> ... I do not see how second phase can be backward compatible when that work
>> needs a directory with the same name that contains a file for configuration:
>> /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>
>> sidenote: I think interactions with the "event_filter" file needs more
>> descriptions since it is not clear with the provided example how user space
>> may want to interact with the file when adding vs replacing event configurations.
>>
>>>
>>> My plan was to support only the default configurations in the first phase.
>>> That way there is no difference in the usage model with ABMC when mounted.
>>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>      # #cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes
>>>>>>>>>>      LclFill, LclNTWr, RmtFill
>>>>>>>>>>
>>>>>>>>>> 3. The default configurations will be used when user mounts the resctrl.
>>>>>>>>>>
>>>>>>>>>>      mount  -t resctrl resctrl /sys/fs/resctrl/
>>>>>>>>>>      mkdir /sys/fs/resctrl/test/
>>>>>>>>>>
>>>>>>>>>> 4. The resctrl group/domains can be in one of these assingnment states.
>>>>>>>>>>      e: Exclusive
>>>>>>>>>>      s: Shared
>>>>>>>>>>      u: Unassigned
>>>>>>>>>>
>>>>>>>>>>      Exclusive mode is supported now. Shared mode will be supported in the
>>>>>>>>>> future.
>>>>>>>>>>
>>>>>>>>>> 5. We can use the current /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>> to list the assignment state of all the groups.
>>>>>>>>>>
>>>>>>>>>>      Format:
>>>>>>>>>>      "<CTRL_MON group>/<MON group>/<confguration>:<domain_id>=<assign state>"
>>>>>>>>>>
>>>>>>>>>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>      test//mbm_total_bytes:0=e;1=e
>>>>>>>>>>      test//mbm_local_bytes:0=e;1=e
>>>>>>>>>>      //mbm_total_bytes:0=e;1=e
>>>>>>>>>>      //mbm_local_bytes:0=e;1=e
>>>>>>
>>>>>> This would make mbm_assign_control even more unwieldy and quicker to exceed a
>>>>>> page of data (these examples never seem to reflect those AMD systems with the many
>>>>>> L3 domains). How to handle resctrl files larger than 4KB needs to be well understood
>>>>>> and solved when/if going this route.
>>>>>
>>>>> This problem is not specific this series. I feel it is a generic problem
>>>>> to many of the semilar interfaces. I dont know how it is addressed. May
>>>>> have to investigate on this. Any pointers would be helpful.
>>>>
>>>> Dave Martin already did a lot of analysis here. What other pointers do you need?
> 
> Yea. He did. I still need little more details on implementation of that.
> Will come back to that when we decide which way to go.
> 
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> There seems to be two opinions about this file at moment. Would it be possible to
>>>>>> summarize the discussion with pros/cons raised to make an informed selection?
>>>>>> I understand that Google as represented by Peter no longer requires/requests this
>>>>>> file but the motivation for this change seems new and does not seem to reduce the
>>>>>> original motivation for this file. We may also want to separate requirements for reading
>>>>>> from and writing to this file.
>>>>>
>>>>> Yea. We can just use mbm_assign_control for reading the assignment states.
>>>>>
>>>>> Summary: We have two proposals.
>>>>>
>>>>> First one from Peter:
>>>>>
>>>>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
>>>>>
>>>>>
>>>>> Pros
>>>>> a.  Allows flexible creation of free-form names for assignable
>>>>> configurations, stored in info/L3_MON/counter_configs/.
>>>>>
>>>>> b.  Events can be accessed using corresponding free-form names in the
>>>>> mon_data directory, making it clear to users what each event represents.
>>>>>
>>>>>
>>>>> Cons:
>>>>> a. Requires three separate files for assignment in each group
>>>>> (assign_exclusive, assign_shared, unassign), which might be excessive.
>>>>>
>>>>> b. No built-in listing support, meaning users must query each group
>>>>> individually to check assignment states.
>>>>>
>>>>>
>>>>> Second Proposal (Mine)
>>>>>
>>>>> https://lore.kernel.org/lkml/a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com/
>>>>>
>>>>> Pros:
>>>>>
>>>>> a. Maintains the flexibility of free-form names for assignable
>>>>> configurations (info/L3_MON/counter_configs/).
>>>>>
>>>>> b. Events remain accessible via free-form names in mon_data, ensuring
>>>>> clarity on their purpose.
>>>>>
>>>>> c. Adds the ability to list assignment states for all groups in a single
>>>>> command.
>>>>>
>>>>> Cons:
>>>>> a.  Potential buffer overflow issues when handling a large number of
>>>>> groups and domains and code complexity to fix the issue.
>>>>>
>>>>>
>>>>> Third Option: A Hybrid Approach
>>>>>
>>>>> We could combine elements from both proposals:
>>>>>
>>>>> a. Retain the free-form naming approach for assignable configurations in
>>>>> info/L3_MON/counter_configs/.
>>>>>
>>>>> b. Use the assignment method from the first proposal:
>>>>>    $mkdir test
>>>>>    $echo mbm_local_bytes > test/mon_data/mon_L3_00/assign_exclusive
>>>>>
>>>>> c. Introduce listing support via the info/L3_MON/mbm_assign_control
>>>>> interface, enabling users to read assignment states for all groups in one
>>>>> place. Only reading support.
>>>>>
>>>>>
>>>>>>
>>>>>>>>>>
>>>>>>>>>> 6. Users can modify the assignment state by writing to mbm_assign_control.
>>>>>>>>>>
>>>>>>>>>>      Format:
>>>>>>>>>>      “<CTRL_MON group>/<MON group>/<configuration>:<domain_id>=<assign state>”
>>>>>>>>>>
>>>>>>>>>>      #echo "test//mbm_local_bytes:0=e;1=e" >
>>>>>>>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>
>>>>>>>>>>      #echo "test//mbm_local_bytes:0=u;1=u" >
>>>>>>>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>
>>>>>>>>>>      # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>      test//mbm_total_bytes:0=u;1=u
>>>>>>>>>>      test//mbm_local_bytes:0=u;1=u
>>>>>>>>>>      //mbm_total_bytes:0=e;1=e
>>>>>>>>>>      //mbm_local_bytes:0=e;1=e
>>>>>>>>>>
>>>>>>>>>>      The corresponding events will be read in
>>>>>>>>>>
>>>>>>>>>>      /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>>>>>>>>>      /sys/fs/resctrl/mon_data/mon_L3_01/mbm_total_bytes
>>>>>>>>>>      /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>>>      /sys/fs/resctrl/mon_data/mon_L3_01/mbm_local_bytes
>>>>>>>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_total_bytes
>>>>>>>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_total_bytes
>>>>>>>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>>>      /sys/fs/resctrl/test/mon_data/mon_L3_01/mbm_local_bytes
>>>>>>>>>>
>>>>>>>>>> 7. In the first stage, only two configurations(mbm_total_bytes and
>>>>>>>>>> mbm_local_bytes) will be supported.
>>>>>>>>>>
>>>>>>>>>> 8. In the future, there will be options to create multiple configurations
>>>>>>>>>> and corresponding directory will be created in
>>>>>>>>>> /sysf/fs/resctrl/test/mon_data/mon_L3_00/<configation name>.
>>>>>>>>
>>>>>>>> Would this be done by creating a new file in the /sys/fs/resctrl/info/L3_MON/counter_configs
>>>>>>>> directory? Like this:
>>>>>>>>
>>>>>>>> # echo "LclFill, LclNTWr, RmtFill" >
>>>>>>>>          /sys/fs/resctrl/info/L3_MON/counter_configs/cache_stuff
>>>>>>>>
>>>>>>>> This seems OK (dependent on the user picking meaningful names for
>>>>>>>> the set of attributes picked ... but if they want to name this
>>>>>>>> monitor file "brian" then they have to live with any confusion
>>>>>>>> that they bring on themselves).
>>>>>>>>
>>>>>>>> Would this involve an extension to kernfs? I don't see a function
>>>>>>>> pointer callback for file creation in kernfs_syscall_ops.
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I know you are all busy with multiple series going on parallel. I am still
>>>>>>>>> waiting for the inputs on this. It will be great if you can spend some time
>>>>>>>>> on this to see if we can find common ground on the interface.
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>> Babu
>>>>>>>>
>>>>>>>> -Tony
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> thanks
>>>>>>> Babu
>>>>>>
>>>>>> Reinette
>>>>>>
>>>>>>
>>>>>
>>>>
>>>>
>>>
>>
>>
> 


