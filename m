Return-Path: <linux-kernel+bounces-302278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1238E95FC0A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9D3282A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51D519D06E;
	Mon, 26 Aug 2024 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4A+PNLQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA8919D8A4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708874; cv=fail; b=ZSJsDbIAGUm93CWFyA9p1beAxMni2wujC6JSK3aEwb+/jB37MtyKg6/VlImZTcuTFZxyDaOlCo8HZr0ZX+GftYJJqXWWfW4iEkoAUMJToDMd9kLnXscMaaPRok9nUJtP2wLSCsMd4T9YitKJUqM09/bEFxBW4xtDuQlys5AuEcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708874; c=relaxed/simple;
	bh=UagHZQY7RFLzLT1eTaHsiPFCFfiYBryXT8MQVluDlwQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hb1/llBGFFoYSXxZ5Vob1W51+tEIsfOFGupQ9SQNFLyluS1J3hyHWO9L5oHd9XjJM6XaLYaQG9TFVHaYb5dxFb5sJE1uJEDGL12DY16+ne+0Gaf2Y0Cfg+ehvQBxfHvSdVBfJy071zMf9hl+aAEgkCTnyCPSEjj/GLD71w6OM6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4A+PNLQ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724708873; x=1756244873;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UagHZQY7RFLzLT1eTaHsiPFCFfiYBryXT8MQVluDlwQ=;
  b=e4A+PNLQRErXze5/vMdvN/IJGvcgwNLv1o2zFTPR41NsfAS4mgRzpHXe
   fw2SYZozB+UFmUY6jnxU3Xz6ktfyNsfXknGvCqUQRqaDSdM673PKGHDqq
   sj2tfVmzMOBB9heQgIPkIx3XAwRgT4MKeJxXY8soh0PtzWBC+4Ux4uCbR
   NuOWqTfoeLhhJ067Wrnb4Ytf9jZFVyiXpUxiTwnIAYIn0/6nfg+Ei9WNz
   mnaj/kumS3j+7nm3i4lg04QFb+V2f3NYoyWXMQfeWCec7pG88hrCzDM9J
   0iOdJerU5WhTdfmb+WO3GZpB8NE3mZ5DXodUtaNiJ3bTubFbgYK9IW0Vv
   w==;
X-CSE-ConnectionGUID: i5Kohq8tRR6hhrOk3IX2og==
X-CSE-MsgGUID: k4go91LaQIis8X5Hej2tAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23126772"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23126772"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 14:47:53 -0700
X-CSE-ConnectionGUID: RktrV835ScOmKmIkXgOwxg==
X-CSE-MsgGUID: A9Dmze0kRXO3lSY7m/NbEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62961834"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 14:47:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 14:47:52 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 14:47:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 14:47:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 14:47:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJif4lYKhujV7BMcni2wJQSr+3QOgz/iki07xm9n3sdZ64Ts3pko6GPmcSIn9S9MWlrfNM0Wu52JRV8/yLaRZjIo1uvFWeerTC5gOTVxdaQGmN1DqEgj5rpcfOpVQUxBAt7hI+OhNtnaJl+irL/e3rltoD5aajsGA6zROgu7SICiwwwGCDhOiZjWwZCqTCN1YvSGL1fNt7ztm6O2ioObjYzQYvDz5/XuMxvtTReS1E7p/Ht/GYNKuel80dzqCvDInrXYHBihie4pLTzOefSNZqyAu2HI56mEpwzK26sCr1B5JEFC99FOC6TzRREhPiknOm6wkHM1gha8xZk3M2XKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+anF62W3bDE9sA7DsRfcfI6GWyzYAKNnOR3zNwDg3s=;
 b=b+iiUnWNeu/FJgy45fzm9kNz5GeJhwKyHEy5GFiHTpwT1kh/ecvC0HAMkKvRx9NB6BdJtBG6zPRsZH+AoWmnAJ/ZBmz9kT1ExVyN5wILJ0g43foJnuBdupymlR7uimQX4ekaUVYcSUd/QOZdpgQkAGdQXjk+fBFAlmtO+lHpr3ftTdS1JRtQJJbj3PWXAhCeupl0ejmhyprgTNwbPG1nmRHRpFsIQmmxTW32TCtpIg2eICea3KhGYq2pwvadHeJY5d9O+gWhwMgxp+L0LvmZOYIbLBBNgv77aABV1PBTXKW7qrztKLW2W2MYXurmaxLTxs84Ws9EroBd1f5lLOYlnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB5815.namprd11.prod.outlook.com (2603:10b6:a03:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 21:47:43 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 21:47:43 +0000
Message-ID: <d7a86076-d1e8-418f-a167-e2d16b2dd7f7@intel.com>
Date: Mon, 26 Aug 2024 14:47:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] x86/cpufeature: Add feature dependency checks
To: Sean Christopherson <seanjc@google.com>
CC: <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Uros Bizjak
	<ubizjak@gmail.com>, Sandipan Das <sandipan.das@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Vegard Nossum <vegard.nossum@oracle.com>, Tony Luck
	<tony.luck@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Eric Biggers <ebiggers@google.com>,
	Xin Li <xin3.li@intel.com>, <linux-kernel@vger.kernel.org>
References: <20240822202226.862398-1-sohil.mehta@intel.com>
 <ZsfJUT0AWFhoONWf@google.com>
 <096cdf1b-bc79-4e88-8ae9-99a373245ef8@intel.com>
 <ZszgGxZLDQYIEJpX@google.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <ZszgGxZLDQYIEJpX@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0149.namprd04.prod.outlook.com
 (2603:10b6:303:84::34) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ0PR11MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 82539663-ef63-41cb-3935-08dcc618b721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejlJR0d1WEVCVGd6c0N0K3NWYkVSSHlLWUlxaHRNejNvWGxnRFhVQlE1UGdY?=
 =?utf-8?B?NHlFRDJadk5JMnpHdlFlZzFLU2tTTXAvZmtreEx3ZUZRcTY1NU1LVkxrWU5q?=
 =?utf-8?B?aSsvM0tTRzI5SHRIQWtmRWYreFJlNkJYdWRyTHdnNVQyMjBpQ1k3MVlYNUVq?=
 =?utf-8?B?VkJmTmphYUZZN2ZVTkFZTDM0VDdEbEMwK2s4a0RjNlo2NjhSNVJyRjdIY0ZS?=
 =?utf-8?B?MFhUWjd2U0VUdGdnVSt2WVprK2hGTW12UzFUUjF5MUxxMXhlQ2N4bmtjYkdk?=
 =?utf-8?B?R0w0VXRUanNpRkpuY0QxTDBreTFINWxnc096SjV4MjVTSVJ3NXc3OU00MGVs?=
 =?utf-8?B?RUpZYmJCNTJ0VW0zOStUSHBaaTk1c2Q0NmhpYTFzbWk2M3J4aFRBUlNsMXFz?=
 =?utf-8?B?R0tFZTB1SzVHWTRoN1FVL3IxcFZRWmhOTitjaVg1R0h1M01KV0ZiSTg1OFMz?=
 =?utf-8?B?UkpmenV0ZjZLa1J1WVJRZ3g2R0pTZG9XcGtZekN0SzFQTHlWQm93aVdpZUxn?=
 =?utf-8?B?dkVRQ21xT2doQlhMZm95ZmZEeU1ZZEw2dXRXZ2FDQzA5NVpKVnV1UzgwbklK?=
 =?utf-8?B?RnZHeW5UckNhOFBSbkxOcHUvUkN1elhHKzZaWHhIMlZtNVhhNnBmQzRUK0Fh?=
 =?utf-8?B?ZjNlWTBuMGlIS3IvSm81UnJOZXY2U2QwamhXSjFGb201M08yUWI0NGhYZnBO?=
 =?utf-8?B?YzY3Y0swc1BkMElUNnEvYk1UbVRocW9WTlFLT3NFRERyS2o4M1FUQzV2ME14?=
 =?utf-8?B?QzJEZFUxSW90SkVuMTFJQ0dzZ3ZiQ2dVV1p0N2t2T1J0WlBWV2xwRmV1TlNt?=
 =?utf-8?B?Y0ZNUElKOEdOdmdyc1ZNUWFodlpjU3BSUnA1QmNBK1YrMlpMZU4yelVQM0N6?=
 =?utf-8?B?VUJyRm9QZHZudkFuakF1em5ac08weGJ6WnZyUi9lVjJKQkx3SWFtTWIzRll2?=
 =?utf-8?B?L2paQWNxcmw0RS9HWk53anhEb0toblR3Y0dXVDFOT2RNc0hJTjdCZ1FFd0Rq?=
 =?utf-8?B?VUNYL0ZONzNmejQ2eC9TU291YnlaalZ3bTlTem8rdjh0OXkwenlwSTBVamxS?=
 =?utf-8?B?MHU5bENGVUdtVVBNOFpyTFRvbXBOK2ovbUJzTG0xZnRtK1QxMUZZVktuRWVR?=
 =?utf-8?B?U0pOZ1FKMEZKNWtoRVgwcnk5Z1F2NHRpUm5Mb2QyYUtkcXJXYm93RFRaSHc5?=
 =?utf-8?B?RkM1ZENQeUlOMkJtVTl1RzRsWmRaKzRTVzhKd1ZEY0swUC9iSTFaODhNSGt2?=
 =?utf-8?B?VlJlR2ZNZ3hKdzBzL2ZtNm1ISE50Kzh6eE5FcEpkWEVMa2QzRU1HeFdIRlBh?=
 =?utf-8?B?K1lHNWV0TisrSWFDNVArM2xwTHA1ZVd2OFBHVTk3T01Wb1VRNE12QXduK3l0?=
 =?utf-8?B?aDJhRDgrM0J1WnBzWTdZdkkvZndyUFovT1Yxa3k1UDhBYWVXTDRXeE9GRjBs?=
 =?utf-8?B?NmFOeDc5bWFOamFJQVVKRzBpV3ZJb3h1ZCsyVHYvUjIzN0Qzdmc0Ly9OdUhu?=
 =?utf-8?B?Z0prclM0MHZvTTFkQndYRjF1ZGVQTFhzWk5pczJkZk1mMUcvS0daQXFCcENL?=
 =?utf-8?B?MGlFYWEzNjB1OWJ5ajl4TEFFWkJ2THhDYS9Td1REdmRnNXExSnB1UXFvOWxu?=
 =?utf-8?B?Y2ZPMlMwbWFmWkFvYmhyVCtVUGl6WXZxTUtQb2ZuSTM1Ly9qbUM0dVhMaDNF?=
 =?utf-8?B?NHVOc3FMcTdKQTQrS2F1VHhObXgrRnZrYklRVE9FVUQ2WTNPMmlZSnhBMzVG?=
 =?utf-8?B?Y2ZWVDBCU3VTUDMvWHVqL3lXaTNNNVRPMWNjaVJDQnFzQXRpa3JRZm1pWmVZ?=
 =?utf-8?B?a1RZUTVLK3ZIaGI0V1Q4dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUloMHR0c1ZadDUyc09aRENtN01MRlhIWWlGdlNmRXRhbVFBMTJYWlBoQTVR?=
 =?utf-8?B?TzB3c3BXVjd5N0RBZmtkMDhIMTQwV3R1MWxEc0RmcGRZZFJ0dTlmT3BLMVBy?=
 =?utf-8?B?UGFPQUZvcCt2UzJUZmcvTTNiMTNBN09WbVZNSzBUN3J1bmQyK05kODhUeXJO?=
 =?utf-8?B?b2ZMSEFmREdSN29iWTlzMytSWWFhTjVSTGw3KzdTckhYRVNnOEpOV0IzY1Vu?=
 =?utf-8?B?d0tmc2YzWkpNWHF1Um1yTC9zaW0yMHU5dmcvR3RSMms0a2hXQ1pVUjVFand4?=
 =?utf-8?B?eDhsNGNsR0JJWGRQR04vMFMyY2Jrb0dxNHo3dHo5V2RaZjBsemtuUnF1QWxB?=
 =?utf-8?B?OS9nOTl2SXVIQ2dvQ1MvQUNEVjJjMmU0SHdielYzSFhSNWtSY2dZNGdPRlI4?=
 =?utf-8?B?TFQ2Ly94M0VuOS9NdFd3Y3hPZ0tsUXJ1TlZKK3hyMEhSTXFqMkgxcFVkb1g3?=
 =?utf-8?B?bVFnU1NkRzdmMnVEU2VabVR3c3liaGVwOCs2czdLeTV6ajJnWFhwSHEwQzcv?=
 =?utf-8?B?U053amNkSHJVdG4rWXI4YUM5alFCeDZiUjhBWllJL2pCTFFoMHFkemRuQ3RF?=
 =?utf-8?B?emt5YjhhTzFXWlU1TUEwY1Y3SThzYytlcHpveTB2eFQwa29DSkNzZlFubmJY?=
 =?utf-8?B?N2JlRThPTnUwbHphNlByRWRLRjNDbFdIWFMrLy9DdkZPaUJOMFN6Um02S2t6?=
 =?utf-8?B?SXRIYko0Q0RoeXNTR01kKzlJWmJHTGh0aXRsZDZjM20xMlFuc0lyYmJkSjNh?=
 =?utf-8?B?TmRsMVVrZzliK2g4cVlxWkdNUHRvR2NlcExlQndlb0tsVHdLRGFpUW13cXNV?=
 =?utf-8?B?U015WTQxNjVPZndYQVNHMStXUmwydUp1UFVXV0FvSVBKa2c0bmhNcnhOQnR4?=
 =?utf-8?B?bWpoQWN2RnNnQ1dOUjNuWUdLUUlOZmJGaXI1UHExR1hYUFNIV1A2YWlWT1pl?=
 =?utf-8?B?aU9mZDM5RzdURU11Um9KanJWUUF5azg3bFZncWVyNWdyQnFleCtlcS9aK1Y4?=
 =?utf-8?B?VzF1ajA2SE4vSXh5QXpheHJqWS9yUDJJTVJUc1BXNkwxTVpMYmlXcnMreC9t?=
 =?utf-8?B?b1p0djQ1bkJFQnQwNVE0QTRSQ1Jkd0x3bGJIM09IQThBT2dTSWo4UDc0ZG5j?=
 =?utf-8?B?bmZxekIxOEZNZmZ4TG96bUZUQUM1QjFncmxncmttc1M5VThkZ1A1cEY0Q04x?=
 =?utf-8?B?QmN1b2crQm9jbDJuOVQrcENwTnRoOWkydXl6VkNJaW91OEttRCtHUndNQTc4?=
 =?utf-8?B?UEFOZnFWM0FBODVoVmdHeHM1T21DbW9VbWZ6RzZKQVdISDVhR3FTOXJhS0M4?=
 =?utf-8?B?QlI1aVBpaUhPOWQ4cjNTUHlyTVZwaUJ2TDc0bWk1a2FyYkgyL1BUMU9Ed1Q3?=
 =?utf-8?B?VmIvalFlMXMxQ1NsejNxZStIMDJBVUkxSW9HU1pqdktCbjdBTTBObXV6ZEFh?=
 =?utf-8?B?c0tlWTRqTXJRNGlhclZzMGVzTWwxczgxbjVPN0lqQlBXakVyRnl0Q0Flbzdh?=
 =?utf-8?B?d2dQR256RFhTczVzc2tOQzFDN1dPU0tVZmlwdmxjNENOZFIxMEdNRGc1U2VN?=
 =?utf-8?B?UlZ3U3lRUGNGWVJBWXh2K3pJa2RxZmdXWC90V2VQbkduZFZtaldPN0dzSmY4?=
 =?utf-8?B?MnFNOTVXeEZTOHNEREZLejFJOUFVT2pscGxqTlpIaW04Y1FuSURycVZjOXNt?=
 =?utf-8?B?eUFDbFY3MEQ5VHdoN1k3aW9JQ1RZcy8wR3lQejFFU3hSOFlrVDAyL21SK3NC?=
 =?utf-8?B?VkpDT0cxTG1sb3F4eHhxMjgwcm9tdmdOZTRtbWV0RXpjUEZ0YWVWNURabHc3?=
 =?utf-8?B?Ry9iZk9oMkZrMktlUEYrQVM2bjVXbW5hdjBFZG5MRXVXUUZKVloreU41dmVW?=
 =?utf-8?B?cks4YmxyQk4yR1IvdHdQaFI0N0lXZGsvVDRjNVg1MldiNncwQ0JySXdrVHRP?=
 =?utf-8?B?TitMek15QWdRNU5UelRkc1hxbCsxZGtkU20rV0x1RmMrRDA1STJvQ0UzVk5G?=
 =?utf-8?B?OVh6L0Yxc25PYjU3d0tuVHFrd1pMb2Y3THBWS0gySWgvZ3FWV01Oai96Tmtw?=
 =?utf-8?B?eDFtczZrNVBYbFR2YXM3aTllcHMxWVBNUkZyUHRJQnVNYVR6OXNBemFzVDd3?=
 =?utf-8?Q?L7dMPXR2JE5t4vp2ooi5fGQuZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82539663-ef63-41cb-3935-08dcc618b721
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:47:43.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVWAJnHf7jfLBA195qvQZu2qi58iuJAebRfjI4s6RUQTHvReddyeCf37z5mmvckHW1qcPpx+eU2o1Brw6pPYVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5815
X-OriginatorOrg: intel.com

On 8/26/2024 1:05 PM, Sean Christopherson wrote:
> On Fri, Aug 23, 2024, Sohil Mehta wrote:
>> But I still feel that for the rare case when something like this seeps
>> through it would be better to disable the feature upfront than run in a
>> kernel panic or some other unexpected behavior.
> 
> Agreed.
> 

Great, I'll wait for a few more days to see if someone says otherwise.


