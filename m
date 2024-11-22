Return-Path: <linux-kernel+bounces-418662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F519D6402
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6899284596
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBAF1DF75E;
	Fri, 22 Nov 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPaOBFMM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3581DE3C9;
	Fri, 22 Nov 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299167; cv=fail; b=oq5M/VcFoWdPN5KOfbR61lGq2u052kh81AbTjbK/T4FQdTsYKq/QnEBBMzCtUujmzNWzDoM8kSpQpMpy6tTpW5ZspYXOFL8f5sP47NS00ZsetPrl1R+EKG5X/2yFpMDIE0IP6DrSnzVXf96h0mzU0Irnrbs6C5twWfzw87mw8Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299167; c=relaxed/simple;
	bh=BK/xeYsn4UGquC6A3hr+QatqvZu7dwajwe7pNtSZy44=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mF8g+VcVnsK0vb94i7QCT90kvenCb6mk25/fS4o67g2UdjcrITsywHjJbChiriF7cqeD3qYNwoS37MSp/AiOPs2GQwD2UZP6yGkflexVbAZ/JoGw+BSFKVHNSAOwa2W704aYB5DNh1MoXgKrIKr+djDHPKtSs+FxJQnPjRiHLkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPaOBFMM; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732299165; x=1763835165;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BK/xeYsn4UGquC6A3hr+QatqvZu7dwajwe7pNtSZy44=;
  b=TPaOBFMMPCJOzs5HeXxvwz0MxnPPWoyVSahWtHIQw8OHx0A1Hu3a+Tvj
   TWCM2hjB8mlTnxwNX/ZBscop6e+M5THzDnys+Bg6NXBfYIAlpIZzne5T4
   HS8uPuqkGB2PcJy2763ifmbB5A3nohydURtap+joP7YkBcLxMd3swUDoh
   DeeboroKFfFPrTGy+VKV3PxKnXiK22ciSmjBaBDMA2MmjSiYQMOI7FZ+2
   sO03W7xIsE6ma+tH1hXG1Yo7wepGQhsCH0arBwdJvY8MLdw3IpLwc1CUL
   4kPINr5xu0XjQzMx/lRFdLnC6sA5NW9H0UvpFCsEkdqWOKTQBE/QFO/Un
   Q==;
X-CSE-ConnectionGUID: 8Of1YAXWTYiACT/t+KMcHQ==
X-CSE-MsgGUID: 6U6ZrJUjTa+ZJ2ORfxN4kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32391347"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="32391347"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 10:12:44 -0800
X-CSE-ConnectionGUID: eHoswzJHQDyFIe719ZHBbQ==
X-CSE-MsgGUID: RjfltMlXRXGy5R4SetdBew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="90823192"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 10:12:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 10:12:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 10:12:43 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 10:12:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHQWvrbkrOaffz1x1kPcAoS8JNWwdR4cI4I4kVZV9ozDoxF0DCKy9Cxmu0+k5Vy/a1inCogAhiChIfnbNxgsIR2AO6+YiF8VbhLcJEMhSvgRR4+3jYeIniO6j8BYcGqjitEGD/u7PSo30uyGyqUTatmxeEVkh0ksVFT5OetWn5B31Gg8Y2/jGQ5XRq0RF46GjZeqQZAmAP5qtfTF11mWBHHZBWwsDiFxgQJeXfMI0OAy5dx2/Fw0vZ18vA6+UrPUgTkKc5B40qgQmMyL2njFq9+ftUVCEeig6cPRu/3gO+3oLJxQi8uyQTU1jgeP4x9tySrkpX6I5pr0BFiYcyMlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOMJwpPSvF4g50nE/JDdhtMyOJOR3rXHipbtKOvcG+Q=;
 b=MCJpKZ8J3Jt6yI8L6X4LTudd/hjUA2l/cWwKAOkC5GWXh+wk4sAtd7JmcbAwGAaNz4dQSJNAiTy2ABk4ygrHvBa+JDjizyyVz1N1RS9Injc/inQ97YCvJK+Ap/zU8qCISqhK0J5BcQuPK8hpHLRp0gb8UHPsHMfSKW1hatnxmDqN94ATfJ8wgduiF9vidq0xlGkxKpIY7a6hGnlxRsrIpdPbJb48a8FFocxF2qqUf6jIo6ui1WxCGFpfCK6AyrP36osXF8nwLN9WsjSmw9PjBrdLzArZhBhncN8fme4fHlgCd7VWFz6FdsbbffYAHrDg8JUmbOLZ3vygQdy/68F6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 18:12:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 18:12:38 +0000
Message-ID: <c6f4bbec-0188-4855-a57b-fa2bf1e1b731@intel.com>
Date: Fri, 22 Nov 2024 10:12:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 20/26] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <jithu.joseph@intel.com>,
	<brijesh.singh@amd.com>, <xin3.li@intel.com>, <ebiggers@google.com>,
	<andrew.cooper3@citrix.com>, <mario.limonciello@amd.com>,
	<james.morse@arm.com>, <tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>, <jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <4ec00fe60cd42c1f22c98c9f5c2f5d3ceb9f8d58.1730244116.git.babu.moger@amd.com>
 <79b8049a-b213-4d86-a021-cfd9f7389f5b@intel.com>
 <3d32c528-24fb-e701-a70b-331d1a04493a@amd.com>
 <d9571277-5d1b-39f2-696b-27000cd8fd3e@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d9571277-5d1b-39f2-696b-27000cd8fd3e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0121.namprd04.prod.outlook.com
 (2603:10b6:303:84::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4692:EE_
X-MS-Office365-Filtering-Correlation-Id: e16ad4a8-65cd-4c24-4eb2-08dd0b213f36
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGs0UjQ2a0tFbGVWOVdSTkJhdjBvMVdNaVN6K3d3TTQyRWZ3eGhGOU1LQ0VN?=
 =?utf-8?B?YVpKTXErMDZ4Ni9mRlVGSkhWTCt2bDdISWdJbUEzbWYvUVpJbjd4WXVXNU5H?=
 =?utf-8?B?dm9jVHAvYTcyYjBXN205dVlkanVjclJhd1FUVDZGN2gwZTJKT3BybXRNSTd2?=
 =?utf-8?B?QXBuODBvUnRhbitJcHVUUFhseEtHRmNzTjBGU2JEa3VUcUdNVXJTQ2lNUkJV?=
 =?utf-8?B?Q2NRNkJoaEV2RUVMR0ppb2hCTGJVMW5RRUFTVy9OK1NWdm4wRGZkcGVjemxl?=
 =?utf-8?B?YjJNeWdUNkpidXNjS0c5bjQycjJkN3FKM21pTVJKZE90aUVYYkhoYnlabGxo?=
 =?utf-8?B?NU5RdzF1VElYNXMxLzRmSjJ5RFMybk5TS2NPNTRqaGgyVko4c1YySkh2SkJz?=
 =?utf-8?B?S09abUR6TG8zY09QWm9Mdi9EYU1RaE50bE9VVDRDTEFnYUpOZU1mczVVYmwx?=
 =?utf-8?B?YXQxbHdFekNhYys3NDFFc25YR2N6NmtqMFdOSHNvdStmMG8xdjV1SFRYK3VT?=
 =?utf-8?B?WjR5V3d4d3M4bUp6L04rc1BhZW83ZHJxaGpPNC8wYUhDZU5hN3FiQk15bnl4?=
 =?utf-8?B?YnI2UXFWL1dxMHQwMGZ2SWRTMitwTzZKQ2hVUlJpU282NkM0UDJpNjBDRGxJ?=
 =?utf-8?B?NDBleEgxNVl2a0ovMHh5NlVvUlhiMHZjWHZOTzdxMitXY2VJeFQzSmhKcWxn?=
 =?utf-8?B?S25oVWR6NHg3QVEvMUZmT0tvWmZyVkEzaWx5RGRWVkhacElwdjF0c0Q5S2NE?=
 =?utf-8?B?SUNTRG9UaGNxcDY4U3RPWUxjSElwTWZvanFEcFFaallQY1gvcG1MSTRxdzA5?=
 =?utf-8?B?WmE0RmVTVW5MQ1E3bW5JK3BsWWphMnhXbG9jOXZCRlBoTWtWbDcvNWo4REpY?=
 =?utf-8?B?QlZDem03OEw4K1I2YWZMdEcxWVVLbFVacnRxKzJ0TGp0MlQxdlVybWpidXNV?=
 =?utf-8?B?enpvY2pRS2czVll0ZDZiSFIwWkQwemtwR1JMN1hib2Z0RVkvOS9tMEFuN00z?=
 =?utf-8?B?K0ZONWw1MEcvVXJ5dWRZMUNnK3FBTEliR1lRSGpxSjZsLzNsZHBZR1ZYNFlN?=
 =?utf-8?B?ZkswK1lqYmdPcVZPZW5JWHZvQVdKSEdkalZOTzhsMXRib1FicDg0YWw3aUls?=
 =?utf-8?B?a29GNU0xMUUyOEluSFZ1ZkpNcDA1N0wxa3BRTDNXSXJvYXJNa0lrcThtK0tB?=
 =?utf-8?B?WEdrN3RFb3FtZVhjWDYyVUk2aGVVbEY5MGhkZm1ic09KcTZweStxUU8vOEpX?=
 =?utf-8?B?SUQ2MkR6Z2p3MzFIT2RKNTVHYWQ4bDBCajltVW5tYWJvVGZJM2xlaDBUVldN?=
 =?utf-8?B?VUtCelpHajVHUFh3cHVrSUpOTXcveGtOT0RIRE9vTXExMGZPMEpJWml0bEV4?=
 =?utf-8?B?VFlZZmU5S3h1bGwzRVFGVUJSOW81RTNBUGlmOXhSQVdEQnlRbTYxMEZHZWFK?=
 =?utf-8?B?ZGg3S3lMVXZ0R2hZN1lyUUlSQlJGRXpnS1hHQmhlbXdjMTc0N0hlbnRFOVVi?=
 =?utf-8?B?OE1NR1Y3bWhYUXE4ckNtNTcyTUYwNUlzb0hIRWQ3MzE2dlZkR2FiYit0dW1B?=
 =?utf-8?B?bjh2di9HRjhhSm4yQkcvN1FpakdSSlhiKzNmVlJrbmVvNnROWHRsVi9BRXZH?=
 =?utf-8?B?djl4b0l3cmNWY1dxTmFxazExNE5IWDNDL3JtSVk4bFBMdHEzWm1sbVgyZks0?=
 =?utf-8?B?OHE4SThTQWQrQjRZWnM3VCtOTjdZMGZRejl5NmJIaUpnYnJzUWlzd0dkcDRi?=
 =?utf-8?B?WkZiNm1vRnk4SG9mbng3SEJQL0dhZXRuWmZ4Rk1Wa1FnYitXMTU0Z3F6K3NP?=
 =?utf-8?B?a0N0WGZ5SEp0Qmkzc2txZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3lMVS9zOWYveVFEU3Fjd3VVajFCdC83VEE4RXIwRzBwTUc0SVowMWZFRTN6?=
 =?utf-8?B?cFhrbHYvL0tZQ3BsM1gxUHFJYVgvUG1BRmxwT0wzd0hHUUFUNHB6dVY2K1h2?=
 =?utf-8?B?YWU5aWcvbTdsRHJEV0tDUWRBRGpMdDZQY0l3KzlRcDljOTdPbjlRRzFsUEo1?=
 =?utf-8?B?R05rYVhnc1F2UFlEUnZMVXNrUGpZWHNvWU5Fb3NvUUk2MUxHdStrQVZkOU9O?=
 =?utf-8?B?VW9wL0pGUlBSbnBaZjQxanJUa05Vam9FTjBIOGRxcTVZbGE4VkxCWFR1UVNH?=
 =?utf-8?B?b3N5VXZya2ZUUXo0ZTQ5a2loblhseno5cTNPeFRIbWhGT3NWNjU5YVArWjZm?=
 =?utf-8?B?WVRuN29JdHUvcjBNRnpLbE95bXFIQUNsMWdWdkFKWE9GdXJPcE9DdmkyWk9P?=
 =?utf-8?B?bFBUQXRvdDRPWnpTcWxqZmtWQzFhTWYwd3ZhTmhab2t1UjErdlB5VzZJNElr?=
 =?utf-8?B?N002dXA4MW55cGdoVzBRNUViSjl5NWlQdXFyUko3bExodFNVSnlNbnJQTjdT?=
 =?utf-8?B?RUFUZDJpcEZNQWhiYjhzdkszb1hOcVBCZXQzZHI2UnArQWJuU1BwdUdvNlBv?=
 =?utf-8?B?Y0w5dWpuZWJYQ0kyZ3cvdlJWOWJoQ3czVEVpekt6YjZ3L0xCZFJHZjFCeVp6?=
 =?utf-8?B?NVZLRG85N003aEs3R3ROL05oLzZIY1Q4YS9BRS9yR2hSQzlkUVRNMGE4VGgr?=
 =?utf-8?B?aGNWakpwUlp4ZDZTaU1pUlJFNjBuMnhLMlgzd0hYaTlCSkNDWklzMUxZa1Yx?=
 =?utf-8?B?Q0IxOXpVbmZMTXVmNmhIMk10TERGNmlaZGtEVUNBTzFvWDlqSkd5MnZqQU9E?=
 =?utf-8?B?bDNXcnJ1NDMzNHVBc01JOFl4V0psWUl1cDZhUXlEYmVXVm8zM3V2b0lDT2dH?=
 =?utf-8?B?cytvUnMvdmloQU5NeERYcVY0dmUvN3ZDUTRTNnFzS0ZXY2pFSjdRbGJqeDZW?=
 =?utf-8?B?VXFZNkgwLzg1TmI4TlA4OGFHMnorM3RiWDViYzZza041b0JFMmFHekdkVTBa?=
 =?utf-8?B?R1h4Zmx4cDZrNHFRTlY4VHc0aitMTjRrVzlianlBSWFUM2taajJkZzFaQTNY?=
 =?utf-8?B?YkRRWHNLc09Gc2txM3JWV2VldnlxYi91OG44OVlNZHhFazl5bFV3NExPVW95?=
 =?utf-8?B?TEJjTGJ1T0I2ZWpPZlJBNGczQmJVV0NueVg1ZVRDb3dDSHZjOWVRbWpUYit4?=
 =?utf-8?B?b1o3ekZMNW9LRjhYemFnQkRKQ2VSMFlPRFlxSEh5L1hkSGd5U2kwenp3MVhh?=
 =?utf-8?B?UDNuS01tVG9Da1I5RU9pZjhsNFhORXNtYjdZUTY3d3Q5QWpmSlZWR0RnTjdy?=
 =?utf-8?B?WmlCd3Z0ZjRFemRWMnV5cHoyOTdUTGZtOTVNRTNYaUthTlY1S29mQnlNdzdW?=
 =?utf-8?B?NGRid3VWajR3U1JuWUExS3VVd1k3QjBCaE9Rc0pqZ3djMmJ4ZThpSm5xMy9G?=
 =?utf-8?B?Z2RoUW41dC9abmhjN0hBMmlmOWx2c0pBSHdPajFhdHpqcnBmMjNoTkJiQjk1?=
 =?utf-8?B?UXBrWXZPL3BiM0tFNW95ejh4ZHI5ZEl0STNtSnhNMTRjeGg2R3NrbVNkdmlP?=
 =?utf-8?B?QjlkcWVpM004ZEk4eThTc0NBVkpFUmtxQ2FlU2ZVMW9CeUNKK2xEeUhZb05V?=
 =?utf-8?B?Mk8yYjBJNHI1M3FzUGJyN0IyTUVhQWo1VVBmZVY4SHNBdFBJNFpGY1dZZndj?=
 =?utf-8?B?a2ErOFRucEhtLy9mQmU1a2plbHlsUWsyamliT3FRQmZxaG5UMHpGbzg4U3dl?=
 =?utf-8?B?bm51NXY0Q3R4RXBscDN6V1pUVG5uVUYvR3BGZXExK3E5VGJkM29Ca3BncXJZ?=
 =?utf-8?B?L0x6Q2xNV01GM3o5dW5QMEx2M0dTdmtHcW9YVWRTTmlXWm5OMlJjeG94Z01u?=
 =?utf-8?B?NExGTUpGS1pEaEVUQXhqanh2WnRmRTY0c3VUT0ZTVlVJc1QyZmpjZWFNVWt0?=
 =?utf-8?B?OE1wUHpCT2RWbEUyQjFWcVRrREU5dnJlTWRUT2d5WVBWdnFEZE0zemlYczJu?=
 =?utf-8?B?ZWJZN2lEWlRJVFFqTmFSQjZXdTVkU1J4bUlJblRxNjlhQlFOZzFLWFhldlNU?=
 =?utf-8?B?UmNJUkF6ZUFxTHhqRVM4K0MwOThWbUhJUGtLU1hhWVRySXQxZDVOWnRrbk5Q?=
 =?utf-8?B?TFhrRUFVUitNRHhWaEhNZ2VhUDJJdmtta0VXQVRvYi83TGoyTitUY0FDV1Mv?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e16ad4a8-65cd-4c24-4eb2-08dd0b213f36
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 18:12:38.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvPMGpcVMzTHEvMizGtp0XgU/wIfsghq3q3PxiFpFm5IhdMKtpoppVoIWdRx+5l2WaGdFKWYSzqlatfrrsj9BLVJq9RUticDGCk/V4VpmWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4692
X-OriginatorOrg: intel.com

Hi Babu,

On 11/21/24 4:26 PM, Moger, Babu wrote:
> On 11/21/2024 6:22 PM, Moger, Babu wrote:
>> On 11/18/2024 11:18 AM, Reinette Chatre wrote:
>>> On 10/29/24 4:21 PM, Babu Moger wrote:

>>>> @@ -3871,6 +3920,8 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
>>>>           goto out_unlock;
>>>>       }
>>>> +    rdtgroup_assign_cntrs(rdtgrp);
>>>> +
>>>>       kernfs_activate(rdtgrp->kn);
>>>>       /*
>>>> @@ -3915,6 +3966,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>>>>       if (ret)
>>>>           goto out_closid_free;
>>>> +    rdtgroup_assign_cntrs(rdtgrp);
>>>> +
>>>>       kernfs_activate(rdtgrp->kn);
>>>>       ret = rdtgroup_init_alloc(rdtgrp);
>>>
>>> Please compare the above two hunks with earlier "x86/resctrl: Introduce cntr_id in mongroup for assignments".
>>> Earlier patch initializes the counters within mkdir_rdt_prepare_rmid_alloc() while the above
>>> hunk assigns the counters after mkdir_rdt_prepare_rmid_alloc() is called. Could this fragmentation be avoided
>>> with init done once within mkdir_rdt_prepare_rmid_alloc()?
>>
>> It seems more appropriate to call rdtgroup_cntr_id_init() inside mkdir_rdt_prepare(). This will initialize the cntr_id to MON_CNTR_UNSET.
>>
>> And then call rdtgroup_assign_cntrs() inside mkdir_rdt_prepare_rmid_alloc().
>>
>> what do you think?

Taking a closer look this seems most appropriate. mkdir_rdt_prepare() is where the resource groupreset
is created and all fields initialized, control and monitoring (irrespective of monitoring enabled). 
Doing the MON_CNTR_UNSET initalization in that central place seems good.
Yes, and then assigning the counters in mkdir_rdt_prepare_rmid_alloc() sounds good.

>>>> @@ -3940,6 +3993,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>>>>   out_del_list:
>>>>       list_del(&rdtgrp->rdtgroup_list);
>>>>   out_rmid_free:
>>>> +    rdtgroup_unassign_cntrs(rdtgrp);
>>>>       mkdir_rdt_prepare_rmid_free(rdtgrp);
>>>>   out_closid_free:
>>>>       closid_free(closid);
>>>> @@ -4010,6 +4064,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>>>>       update_closid_rmid(tmpmask, NULL);
>>>>       rdtgrp->flags = RDT_DELETED;
>>>> +
>>>> +    rdtgroup_unassign_cntrs(rdtgrp);
>>>> +
>>>>       free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>>>       /*
>>>> @@ -4056,6 +4113,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>>>>       cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
>>>>       update_closid_rmid(tmpmask, NULL);
>>>> +    rdtgroup_unassign_cntrs(rdtgrp);
>>>> +
>>>>       free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>>>>       closid_free(rdtgrp->closid);
>>>
>>> There is a potential problem here. rdtgroup_unassign_cntrs() attempts to remove counter from
>>> all domains associated with the resource group. This may fail in any of the domains that results
>>> in the counter not being marked as free in the global map and not reset the counter in the
>>> resource group ... but the resource group is removed right after calling rdtgroup_unassign_cntrs().
>>> In this scenario there is thus a counter that is considered to be in use but not assigned to any
>>> resource group.
>>>
>>>>> From what I can tell there is a difference here between default resource group and the others:
>>> on remount of resctrl the default resource group will maintain knowledge of the counter that could
>>> not be unassigned. This means that unmount/remount of resctrl does not provide a real "clean slate"
>>> when it comes to counter assignment. Is this intended?
>>>
>>
>> Yes. Agree. It is not intended.
>>
>> How about adding bitmap_zero() inside rdt_get_tree() to address this problem? Also need to reset the cntr_id in rdt_kill_sb().
> 
> I meant reset the cntr_id for the default group in rdt_kill_sb().

Doing the cntr_id reset like this matches the custom is to reset to defaults in rdt_kill_sb(). I am not sure
what you envision with the bitmap_zero() in rdt_get_tree() ... I wonder if it may not just be simpler to
call mbm_cntr_reset() from rdt_kill_sb()? This does raise the question if mbm_cntr_reset() should reset
architectural state. I do not think it does harm, the state will just be reset again when the mon dirs are
created?

Reinette


