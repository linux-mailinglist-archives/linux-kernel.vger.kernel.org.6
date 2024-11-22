Return-Path: <linux-kernel+bounces-418767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977DD9D6576
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F35B21EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91758189F5F;
	Fri, 22 Nov 2024 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRx93fq6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB81CA9C;
	Fri, 22 Nov 2024 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732312357; cv=fail; b=iYxWOts7b0aM0zX4V8T/RqU2SwNatf8yyZ60yZaZrQLiQ7qcl+D1MlTMI7gBzL3p5i8N0Vsg4n4QWhnWQ6/MQgcI36CAcOWsYmqLM3bx4jBeS9UF9/lPnHXUAt7NJb0bqPNUgozTk+4WVq2cJ6nmFimMPgf7BiHW3RsCUau8VjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732312357; c=relaxed/simple;
	bh=V6LrqX5ewymbWKeIxVjmfe1Gy9dDKAH+yEnn469GwO0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HdyhO45T4Sb9EHYzSboPc0X6j0aL/ZDfJqBgzMAtFDPXmBvVG6gIjbAHtVzuFakCwna0IP8DQh4L485Jhu9WRoAwDt4vW6SERFgIphRcV0OXac3HwWzwik0o0eE5zwfL2t/FhtDpXtzyzgdzxRxND8DVz6LLhlifhBl9WXAkkbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRx93fq6; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732312355; x=1763848355;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V6LrqX5ewymbWKeIxVjmfe1Gy9dDKAH+yEnn469GwO0=;
  b=SRx93fq6uca/mqmloR0sf+k0V1e1V2J1QASyXg+c5PgSvCTkkL3P6FMR
   apmIQJyEmPEPhPm5HS162QZHP826C++V65Y16zB+qodMRHOScXz/7tmKO
   qVYHoywNbbDoeCpsFFo2mrU1jgog2HDkteh/tAEbjCg0OKzqcpzkGcIvO
   PPneQs4fOpRK9jBNi6Ip7Zn6awCKsJgKStYdkroRExOH3K2mECEXht9WJ
   I6OEbiKJ3q6/TW2kK00Iev/b9IfmS9gDYDoGeXPBw+oLSBiDjR0vb28zg
   M1oK20SE9x92Js9TsAl03lt2V8AIeJpHGrKmDEbZ58Ks5cP+jjC/7JhBD
   Q==;
X-CSE-ConnectionGUID: SQebhtGMTbykrlHv1oYaeA==
X-CSE-MsgGUID: k2+7h0yfRpGkioPymmOnow==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="31841209"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="31841209"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:52:35 -0800
X-CSE-ConnectionGUID: o6aHAZjTRDSWyJXuGMNFRQ==
X-CSE-MsgGUID: RH4gQ/2WQZOwMFKCR0cKCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="90680594"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 13:52:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 13:52:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 13:52:33 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 13:52:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XflhgarzM9n8Za97wJ1URiqQdyu7xuKHV7Wlshx1fgl4hiMn+UMW2hhJybZSblHjM3gcc34cvvxwcmA16sJMEqz3O05b7B5UNellgrCbRmQ1CB3WUxjopyZ++MaeUmKZPWp/ofedvA5c21guHG6eZoWmGxsQho2Vp04hvGWRVTM26vJx0CkSADLO/CtKzB61TsV7Efh3GyHwc4LoWnj29gAVS2t2DJAO8xM2WDXWs73w9/g97RUnewNQDtehKRped4MyaL7DOoNdBfvIm8fwF3gdjVkCrZH7SXmX0wlKpOOy6EcMAv+YhCMI0qKxg3VA16GYUmCrCL9nmfiwc/nxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8yVjweLg/K8zw6lm7RL10P4A10Jk0mZff8ICaKw4/k=;
 b=qx3cOrh3pa3R7bxt7XPejRYtap5s6SZOJA8BetgPbnliu0Gww0H5B7+SbCzZCI8eh4fMKSukX2trrEPTIn204Q7rf0hr45UZorUMix5UBbCaPCJzGd61ptnZIQ+t7nf/juCdHaQuSPm7yArla3R3/lW5NrUx0Yj1R68Qs14kf0kQGvYAqv7z/3J6eW11sdXXIFXMIwjBRf0bstv09Bl/1LmkqZdegRdbcu8C+hjF7aCd2dOduuoKBiMrujDoV0X3f9wSh2JaK7r8IMbNivz+T5EsXRZC+Ge513wInhbkRLBP231159meOiqJhAhHi/9qG/Lj+ybNSrJUJmbptNFI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB8781.namprd11.prod.outlook.com (2603:10b6:8:256::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25; Fri, 22 Nov
 2024 21:52:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 21:52:26 +0000
Message-ID: <9b510a12-b0de-4143-806b-493c29f4ff00@intel.com>
Date: Fri, 22 Nov 2024 13:52:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 17/26] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
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
 <a3c2bdf2153882cc955b80b7d0fcdf7af3d09eb3.1730244116.git.babu.moger@amd.com>
 <5a7d8ff1-91c7-4e75-9730-3aa0703274a6@intel.com>
 <e108846f-930b-4afd-90c6-2266af96816f@amd.com>
 <a1417f89-7d07-4e9c-ace4-1248fb2f668b@intel.com>
 <d7bbc624-75f0-4110-b459-e69dafd9577a@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d7bbc624-75f0-4110-b459-e69dafd9577a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:303:6b::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ea53a0-4cda-4a4a-a668-08dd0b3ff3fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjVoeFVZMG9veEQrWS9MMXU3QTh0NEJVZVBlWkREWHIxNC9heUpQOEF5NVVP?=
 =?utf-8?B?WmFRa0dKTXlPanJ0eUZkbnJnMEtCUzM5QUNTK1c2aStHa1dYdGUzbGpncDM4?=
 =?utf-8?B?dXRrU2NZYk5OcmVNUk4zTDJUOENqOGVHNFJJZEZQVnVPMlFlM1BsOWNQZ2Ri?=
 =?utf-8?B?eld3bjNXWEhVVkxST0R6bEdwM0xqTWNjTDlJUCswZ2ZLVWRHTDJvTmhmRUt3?=
 =?utf-8?B?b0FyY05FbkNkMjg4aTl0TTlIZWQvdjlVNjZqby9lVDNvWXVHVkdvRnIvV1Ir?=
 =?utf-8?B?N3M0TkUrYS9xMytQdlpqMVY3UUxjLzdMQUhrUldMb1B6SjkyOUNxb3NVMU5l?=
 =?utf-8?B?U3RjUW9PazJMSWZvZVhQWGppVGM0NzFyRWg1UDd3akMzM2xUYmRwRXdQTWN6?=
 =?utf-8?B?bnBWcjZUWWM3b2pTWXVDZFBWZ1hZS3JOR1hGVmh3WTFMUlVwR2NVVHJndkk2?=
 =?utf-8?B?RVlBWTUrY2NROW1tbzRWbGMxZlc4TnN6ckhhSFVzaUZ1NXdmbEdqM2ZkdzY3?=
 =?utf-8?B?N3d0U3ZHOXhadzhwUWNpVHhFSFBsaWV3NENuTjFBdzBjSVNJc09PTFkwUG05?=
 =?utf-8?B?cDBYOHJMUXNrYlVjZHhKakpDNGZJKzNSdmlCU3p1WTZScktuUDdadytoSlBt?=
 =?utf-8?B?MDhIVU5RWFdUNEF2SDJoU2ZaRG9nTHNKdG9sRzdOK3JsQ1ZyTlN5T0R3VmVO?=
 =?utf-8?B?YmlndEdKQ1UxZC9rZnZCYk9XT2FJdGxSd3dSNDE0VjROMTlTYU0xTnF6dHA4?=
 =?utf-8?B?WWE1WnNLQTJWRmhNd3RxSXp2NW9hMXNTY2N2NVd4RGxqclNpOTlyaGs5d2x2?=
 =?utf-8?B?MkZmUDNGdDhIMG9GUjJrUlIzOG1sNitpcjJKald0UUtaNVRpNnNlTkRSWW1r?=
 =?utf-8?B?R282MkJUQXZuNS9ZUE81ZktFLzdxdm1vNWdoUmMySFNHb3FvcjRucFZpTGhr?=
 =?utf-8?B?NFdRUXJLSnBFTFdsRUlKOFoxbk5aSDB4YmVlNVdkSTR6RDFneDl0S04vSmVx?=
 =?utf-8?B?Z014azdSMWpOMkd3cjE1amhXM1orc2hOOHBnbE1RWVRIQktzUk9rbFhGUFBP?=
 =?utf-8?B?Mktmazc2NE1TeW02akhpbVhiWGR1eGIyNDU1YVllbHFrT2doeVljTkJNNzV3?=
 =?utf-8?B?VmxHMUpobkRPcUxmOW1NaHh2R0txQWM0VDBsd1FyS3RBYkNkbW4zcTExbndF?=
 =?utf-8?B?a3hWWWw5TWFzVlUzN25KODVzSVE1aGNDbXNjTHV3cCtmS0lDZ0c1QU9GYUhl?=
 =?utf-8?B?SG40aHlBOTJiUWZLODNmMU1kTG52N3lTaldQbTJ5Qzkvdi9CTXZzT0kwOW4v?=
 =?utf-8?B?cFJ5dWR4VEUyeHU3VXNaN2RvanJJblQrUlh1cjhOZERoZzl5MlNyRjBCOWx1?=
 =?utf-8?B?S3lMOVp1aGluWjBUdkhmZjRlMk9pTHhkckQ5cCt5R0VjeHkzODZYb3pSYXBK?=
 =?utf-8?B?djNDV01Hd1FRSk1Rd0NURXRKTStQSHhKcDZ1clFZeFNralpSQ3dETEZOY0Jh?=
 =?utf-8?B?UDNEakhwdG4yQjZob0JuL0VpNGNXMVdsczhXSzI1elRpQWltWXRZYXY4eVBM?=
 =?utf-8?B?VUNmcVlsdGk1RldiYk5xN0pYVjlBZDRZRUVyb1RRNGEzejEraWxPVlU1d2Ra?=
 =?utf-8?B?c3VSNFBGMnhmemlMcTJOZzdzYkw2V3JDMTk2VS9qbkNSQzBDOEovRnZRVW9O?=
 =?utf-8?B?S2pvdXFwcE1IOUVuQnVoTXIxQ3dVOVdVK3NwQ01nbnExNEhBNlZSTjh1ZWFD?=
 =?utf-8?B?bTBjL0N1Y0UyQko0RGdHZk04RFh3ellkMlVUUkl6VmhOZVJHMlhHcjlxUm5E?=
 =?utf-8?B?Sm5sR2I2SDRxNGlKVXJYQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVFtUXBYQ2p4eU43ZmFhUk1wWWVEMkRkcGNCTW5TODdTeFhMeW9IRnduZUV6?=
 =?utf-8?B?OTR4Y2NaOFFHV0I2dmpXUmxMTUhka0poUEpEUFVQTDBhR3FlZUM4MDZFSHRt?=
 =?utf-8?B?d1JDYkRGM0s1VWd1Z0xIQlBGQWtURGROd2QwbnlmeVRQSmE5aElZald1OWVI?=
 =?utf-8?B?Uk01UkE1REZ1L0hUbDhnWHFWdUdFZVBjdVRYZWcrbHNtYlpiK1JrU00wOWgr?=
 =?utf-8?B?d0puek0yN0hDL2p4dUZ2ckw0NXcxcm9yYk1lNnN3TjdUemoxTHI3VWNkZ29M?=
 =?utf-8?B?ZUdlbzFJR0V1UnVEM1l0NFFFcGpyOFNKbDRyODZaZ0NKN3VaMTY1L3FDMzEz?=
 =?utf-8?B?dnAzVkd4enlkTDlkU2tsWFUrZ2FlbzdjcnRaT1VtWjZHcnRaWjZ3MFZISHNL?=
 =?utf-8?B?dTcxekpGTXNUU1g1ZXRVQkJxOHVuYTdaY3dpWmRsT25tcmVNNk8wekVqTmZC?=
 =?utf-8?B?Mks4b08ra1ZoMng0Qk1VWXp4bndhdiszSllNKzZZRjNkU3dlcVlLQTZVK3cz?=
 =?utf-8?B?enFHdXNacC82MlVCQW40MnBNZU1QTkFreEY1N0psZFc1QmtiRkg3a2QwcGs1?=
 =?utf-8?B?b1BaUy9rNFA1Z2ZTNm5hZWRNUTZlQXFHTHhvdnFYaXdNNm53MjZra0RtZ1Vu?=
 =?utf-8?B?dVIySWlUUk5ibzV3c1JBVnc1OE9KRnN5bmFMcTU5Q1JlNTlpQVZDNTBIYUlD?=
 =?utf-8?B?ek11SDhReHBNTHJRdUF4MWVxOE9VT1RueUI0TjZuOTNDM1hGM3BqTGZSSVcv?=
 =?utf-8?B?THhiK1M0NEc0NXJCT3YyM0srNFV1enBsNDcvMzJXUERkc0dmRWNKRWc5b1ZH?=
 =?utf-8?B?elVQV3JJWVVYdklUbTAyMEFQTXBXWDh3cUxrVnI0YnduN2ZDNVFtOWc1aVZj?=
 =?utf-8?B?aEJUaDJ0Z3RCVHBuMWUzb3VLVjJ4MzlHSmVSNXg2S2FlQ2swVCs4OEJqZUpJ?=
 =?utf-8?B?eFNxS2tBSlc3YzhQK0NzcExVY2tCWFpSc0pldlQ3MWtKU3R1N3kzQjZaN3Vx?=
 =?utf-8?B?YmVuT3hHUEJzN1VnK3FBVy84OWRFWjdaN0tOWmQ0ZGVuT0VaMVIyMWlWUG9Q?=
 =?utf-8?B?cWpVNGhIeW8vbkZYQXhSMi9xMWxkNFdxK3dURWo4QThXSlY3MjMwVitEOVM5?=
 =?utf-8?B?VVBRM2lINnI5aytvUkpaT1VPdTNaeU4zWDJSMTlJVVVaWjNSZWJ4elRnOHFR?=
 =?utf-8?B?VTZFdTJjekFPVlN2TXhUOHd6QmRvZlVtd3hpaVN1NUtDRHFVSENqL250KzMv?=
 =?utf-8?B?THZ6N1RKZk1UMEZsUXBVNFhXeXkwQmF1czhCaG5FVm5qWkVPZGh1QXluSm1u?=
 =?utf-8?B?KytMTTJpOFdtV0ZYVVEwQXhtTW9aa09WRUNDMkg0Wm5xN3VTa3JVZUxPTEt1?=
 =?utf-8?B?TFh3dUNLQjl2MnRHS3diTklNTG5KYmNaTDNtdmlFdFBXd3M2cldkZk8vZVhm?=
 =?utf-8?B?S1R5YnJEREF3ODJNZTBYQWtDVTBlcTJ4c2tTYjlRQTg3SE9HRk9CQmlnOXJm?=
 =?utf-8?B?SnkzK256UnlHR0N0d0V3YjAzKzJwN2ZtTlNPOUtVcnlNV0FwN3RBUzMrcWs4?=
 =?utf-8?B?RVBmR0VhMDlLWlBDUEc4RkUxWTdiTFFVTGFkZkN1ZjZPcHg4bGdERjZiMzJr?=
 =?utf-8?B?TWpuelV5NHVtOE5Ga1RyNmJjcW9NNFNnNWJTcW90U0ZLUCtzdS9hRDB5OS9p?=
 =?utf-8?B?bmRaeEFPQnVyQkVPallWRWVpRmhPdnNmYUV4c0pMOGV3QUdLRkdlWS9mdFlN?=
 =?utf-8?B?SkdFZFc3ZEx4SUdvbVV1TERra3VHWUk5b25NM25uOE5lbGsxV01DM0kzb3Zp?=
 =?utf-8?B?dXlEcDJmQmQ4WWRPS2FDSVIxcDJ6eCs0K1BPU21CNWE0L1lDYlloTVphcGlE?=
 =?utf-8?B?UVF4dW55NGJ4eWNkYUMzbkdEQ1lGcmp0S0hsWGdWTWJWN1EvOFYxbmpRYVBP?=
 =?utf-8?B?OHVVS3grdUl6cVZnQ1BwQWZkKzNmbWl6MGQzU1BlSFR6eTJzaVBtOGNIaHZT?=
 =?utf-8?B?WXVTWkZsWmQvdjFqNXlLR2E1RGNabVV0bDQ4SXlIYXk3SE5tTW9GeGVQZndX?=
 =?utf-8?B?TjYrc2d2QjhqVS9EeXBCYlU4VjUwTXo0T0VJWGk4TmVqcmVaK09HQVpsTjQv?=
 =?utf-8?B?cEZnd3gwa0dUM3dQODExU2p2Z0JqOEEvZFZKU0srOXl1UGZHV1B4R3VOby9a?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ea53a0-4cda-4a4a-a668-08dd0b3ff3fe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 21:52:26.2345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7IhmOExnI5phKtqRPCtBF4MHU+YjSh4Hug6Hr5XGpRWOClg/VuaMnq3HBX1dnlJkQKQIBmqmH3Iu55jRpXbB7qeZhg6FKXU1o+5B1lSe88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8781
X-OriginatorOrg: intel.com

Hi Babu,

On 11/22/24 10:54 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 11/21/2024 2:18 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 11/19/24 12:12 PM, Moger, Babu wrote:
>>> Hi Reinette,
>>>
>>> On 11/15/24 18:44, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>>> The ABMC feature provides an option to the user to assign a hardware
>>>>> counter to an RMID, event pair and monitor the bandwidth as long as it is
>>>>> assigned. The assigned RMID will be tracked by the hardware until the user
>>>>> unassigns it manually.
>>>>>
>>>>> Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
>>>>> specifying the counter id, bandwidth source, and bandwidth types.
>>>>
>>>> needs imperative tone
>>>
>>> How about this?
>>>
>>> Configure the counters by writing to the L3_QOS_ABMC_CFG MSR and
>>> specifying the counter ID, bandwidth source, and bandwidth types.
>>>
>>
>> ok with me. Exactly what ChatGPT suggests.
> 
> Hmm. ):
> 
>>
>> Please do note that that first paragraph informs reader that
>> a counter is assigned by user to "an RMID, event pair" while the hardware is configured with
>> "the counter ID, bandwidth source, and bandwidth types". There thus does not seem
>> to be a clear connection between what user assigns and what is programmed to hardware.
>>
> 
> Adding RMID in the text might help.
> 
> Configure the counters by writing to the L3_QOS_ABMC_CFG MSR and specifying the counter ID, RMID, bandwidth source, and bandwidth types.
> 

Isn't the bandwidth source and the RMID the same thing? How about something like:
"Configure the counters by writing to the L3_QOS_ABMC_CFG MSR and specifying
 the counter ID, bandwidth source (RMID), and bandwidth event configuration."

Please feel free to improve.

Reinette




