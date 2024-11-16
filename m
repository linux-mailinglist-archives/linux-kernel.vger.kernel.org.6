Return-Path: <linux-kernel+bounces-411555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A625B9CFBE2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15271B2382A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0EF79D0;
	Sat, 16 Nov 2024 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMK6ex9y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F25184E;
	Sat, 16 Nov 2024 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731718667; cv=fail; b=QroyIiCR8qeLTeaF2StGEebbgPfJNDfPVygAsSg31Auois+KCbj/qskabZmNakbrVO0MGclfBWzMksOcbkBO6BDjjEVF/dZyAUtcAv7iasGSV1149/NRVS+EmlBnkVhRU6muPOJ5hzrl0FmRavNG++fky/4+cHafZNcL6zITmjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731718667; c=relaxed/simple;
	bh=KVn5nJtSgYZ0T3UyYiwB7WVlsS7ULQ9nDS1EWBuB2FU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CqXU6AHCTYjTh/89L3P059Zk9MtxLEr3PIgVOiNQX8WGdVooAuyau6b9boaE0v28GdQmKR3FkbkV0S5DSIgHx1NETOfv3RWJkDRwX+9et+ojl75rG9f0bl5vciRYkQbSGNmoyFLhOHPNbyMjH6Z/MMdBkinRQsLKKwJabDkt47w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMK6ex9y; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731718666; x=1763254666;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KVn5nJtSgYZ0T3UyYiwB7WVlsS7ULQ9nDS1EWBuB2FU=;
  b=TMK6ex9yuXI8ew7/qyJo9vyWeavcRf1HgGmgIPruqb3m/lgq4PlmsJiI
   Yo5fGEMKAnKU5kHwl1lChAp3H2Ynv3hQ3TF0lhQ7NxJFjTGoQ7ilH1Pog
   ic3zoaPtDZf08Zca1TSnQeQFiw7wMux9MmWnxtqMg3mlzyupXDjs3o7jL
   C9hz2TkaG26hPkrc7BZbxX+Y3GDACLT3V6mD3XYmaGkgUAABZy2O4PRne
   q6ipx9GIYh9O5nmLUd4S+tJAejCcmOqpL38VufSm1jiRixUcBjiGdhyA7
   DJaZIqCuEXb8HNHd00zILIf7qurXkpDAy90BHYJbCDSTvka70RUSmEOg+
   A==;
X-CSE-ConnectionGUID: kyxTFKVHSke0pZWjB2LynQ==
X-CSE-MsgGUID: vxcZOyQySn6pBRjg3yVrBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="31810070"
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="31810070"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 16:57:45 -0800
X-CSE-ConnectionGUID: 9oyVG6r3QA+zzL5T3l1PPg==
X-CSE-MsgGUID: ZkQGAYMyTrG2kPc3ZER1Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="88822084"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 16:57:44 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 16:57:44 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 16:57:44 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 16:57:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcHjZ9T5BfH7Cfzblfa2u7cEN5axmWfp/fiGgYL3HR73cHmufiaOQEG8iwnsm4ojOA6irWfZ81SYKCRRoEM9SyKq560uQq4JrRfGdqdjx4dzMpSgSiQepZ1lQwPcY7eS7Th4Xu4FYOCnNLsis1P19i8KyM5R36C/DXsaGm78uGdjTePO/6p/exiNfFJaKlMrHTex8ZyKijeNK6o7T0OpMF/WXj4P1GMRQsfPQgjm88RmXV7dhHLbj7Mq80PiD/cSLSb77LxPMDwr++paJJgI+kUWAi7Pj9P7GRjtrAVkmMwr8BRjVy0s5ZcjMSGwlbyNghn2xTpPbbSGn2M5WXQiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjFAaano0YD6pAJuZIHzMGKznosWZIajcKu2KDZKEmQ=;
 b=ODzmQpByToeNtW1uGQFw7c5qk1CLvwJLNGCbHSrVmNOxAqMI0cG4Ykmqga8dgiWpeyVK1VtXby7C1tD63/bLfRp+LArQZVCSTRvOy03ujFcY2NjDWVhegjkmJsgHkrSv7Q99Bwb8+7YdnymwRy8qy3TMdePw+DCx1TAf0tJVe6XmTZUuEdIzyGZm2tMyiocllfAPxnWviXkSD6iZyM71Q+u10dwmT4bWhARH4NcTW2WJuFFO4kdtUJ/KpHKtDuFvoVur+5zSQAwR/COe9IF4OglXrbraXtUe17BUzonF5bKlA6EARrBRu/E0s3jXBYFMZW4O9GjJmm49qj89ki7D6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7686.namprd11.prod.outlook.com (2603:10b6:930:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Sat, 16 Nov
 2024 00:57:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Sat, 16 Nov 2024
 00:57:41 +0000
Message-ID: <1757cedb-e5b8-45fa-9b70-4c78b5770624@intel.com>
Date: Fri, 15 Nov 2024 16:57:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 18/26] x86/resctrl: Add the interface to assign/update
 counter assignment
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
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
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <3851fbd6ccd1cdc504229e4c7f7d2575c13f5bd6.1730244116.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3851fbd6ccd1cdc504229e4c7f7d2575c13f5bd6.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0319.namprd04.prod.outlook.com
 (2603:10b6:303:82::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8118c8-dcb5-490e-634b-08dd05d9ac03
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V20veGx1Skh6R3NaYmVXVXpUQ0tlaDRMdVB5NzViMERIUnRFTkRhampDRTFY?=
 =?utf-8?B?VGp3RHZDemxzaU4zOEJXUmdPQTJQbUZkRE9jREpRUnpOMXZVa3E5MEIwMmJG?=
 =?utf-8?B?NXlXNHVVV2NEU0d1YmZrd3VKL0s2dnZDKy9IcitkMFB0TEppZ1VQZlFRNDAy?=
 =?utf-8?B?L1l3VldtU0I3V1ZMQlFUWTdnODEybGcyVlRKZVBPV0VuZWg4bWZiamd5ZWNl?=
 =?utf-8?B?eVpFaFZwZkh3QUdUQjRRa1F0NElTT1NpcW5sQ3ZJT21XR2pCMDBaeGI3MW1x?=
 =?utf-8?B?bGVPSEg0akZLQ3lqTnE5dHBYU1BHcnc3QUl4WWNURWE5L1F5WlJVQU9lUWhq?=
 =?utf-8?B?Z2pURnRPVzVWcUxQVUJ0ek44bXFYY2pKdmk4N3BvLzRvaXplTXQxRHVsSVRI?=
 =?utf-8?B?N2EzelEvY3BKU3VramxDUFpiTEFBMklQMXJvR1F1MEpNRGhDM1EzVW9Dd3lO?=
 =?utf-8?B?T1U0VlNBTHBXdm9nL3JjRTFtRHJ6QlRaYkZDN25pb1hhWm5aNUMwR0NCTXVI?=
 =?utf-8?B?OEl6SWhSdnVzeGxURjhSTVE3YzcrZmFCNWJkOU93Y2NVVkIyQ0J0Uy96ZXox?=
 =?utf-8?B?VGt0S3RzQm53dDY4blBwT09MOXJ1Q2Z3U3NuYlpjRnRSU3RSaVFCRW4xZlEx?=
 =?utf-8?B?NzcxRXBkNVduZ1J3N2NuaFhNc3FydjlnZDJMU25iZk1SaGhWOUZWMFJmV0I1?=
 =?utf-8?B?eUR3RGRBVzBIaUVSdkRKOHlRZzRlOXFUZkZNU25EMXFPWFVTM0pSaXNCVFc2?=
 =?utf-8?B?T3ZSZFN4Z3hoLzBha1RZc2QwMllwRDVWWlNSWFpkVU0vYTVoN2R5Q0pJMlRk?=
 =?utf-8?B?S1N1S1dWaXlMSmhPM0xJSk5Mc3FxTVVXbHloUWtRUWtFdVp0M1NTN1NCTEQw?=
 =?utf-8?B?UU11Tyt4Tk1FUGtscE5zS3krWVNqVTM5S0EwREtKRjBieDVmU2g2cjVTWVA2?=
 =?utf-8?B?MkRWbU9mRGlUQWtHOFVQUGdUR3lSdjVGbURVcjBIMDNiMFQ2S1h6Vy9rQlVu?=
 =?utf-8?B?b1diRFJaT1ZETWZIcU4vTEY3NGlma2l1THlRMmdCajRaWDdyWEgxMjc4MHZW?=
 =?utf-8?B?QW1QdnBRVnlidGUyRmFpc2phSEtWKzkyVTZUNGVuUGtaUUlKMEVmcHI5ZHpG?=
 =?utf-8?B?RllNb2hvbUFJUFB5RnJmSkoycHB0VDZoRTI4RW9pdVZCeFNOTkF5bllYa0pU?=
 =?utf-8?B?NzdwL1RXbU9WcWRaQWNQOWRVaFVlUFdld2pJdHduR08zNkFzVG4rWlN0ZU1L?=
 =?utf-8?B?RUl1ZmVkRTVoSTNqTEFldGwyaS8wRFlzUnkxSEp0M3pxK29yaXA4SlBhMDhK?=
 =?utf-8?B?Q0FIdi92MTViemtvUy9HU2tMS1AyZEQxanloazFEUGc5NWwwZFZWNHJQTVZB?=
 =?utf-8?B?UnZpRVpUblc1YzYvdGROOHhlOFdrVjJtTFBCQVQzeVVXNmZnc0tocDJVUDdL?=
 =?utf-8?B?YTQ1Y0VNN0xDMDJOUE9TMEpjRWlBTU1tTDVZZlBiUjlLSTd2dmZ3TVhFUUpK?=
 =?utf-8?B?ZXg1WVpwSXVOek81TkZkU2xReEpoRVYvR3FhbWJsNHJ0b2xTekdqcERpN2I0?=
 =?utf-8?B?Y2ZpTlpWSlZ3eHNab1ZBQVNmeG1BRm5lZzNaNUppTmRqWjBHQTV3enNqQVlB?=
 =?utf-8?B?ZG9LM0FyczlTNmp1YUIwVkpMVU5nTTdLRUlOOEwyVktYMzIzMmh5TS9xOTVB?=
 =?utf-8?B?eUU0MFo0VElUd0dhWHFSMWhENld3ZWNhc0dSNThIYkV0UEt5cWNYbEs5Q2t4?=
 =?utf-8?Q?SoXzdX6htRxbHJqUsrlZpCZRhZWdYRMIT2t4gvw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEZ2K0xuMzVHQVpJTWdzSEZ4YTZsbnVOVVdVQTY3dzF5cWI1aGZwbEdrRHA0?=
 =?utf-8?B?cWkvSEliNm9uWFoyUlVoSTlTTE9BUXdSaEVXZHdtQ1pRdlIva0FtcDgvbG1I?=
 =?utf-8?B?MWQvT3p3R1pvMS9rZDVudVh6UEFqclQycWVtamRKSjI3QjVXc3FjcmRINEZ0?=
 =?utf-8?B?a1pDZ1A3M3pzMUVpaDNCdDd0aVB1c0tBMytrQlVoMG41Y3VGbjNrcTRkRnRD?=
 =?utf-8?B?KytKY0FDMi9LSEFGOEppa1E5OUQ3YlJhaldHbktlYnBCclQzMkI4b0djalIx?=
 =?utf-8?B?cnJiUEw4NllJaG01cHBrVVpia3ZDd1VudVMrK3dSTTM4N1pmc2k0N1BGRnA0?=
 =?utf-8?B?N0FZR1dpNFJiRjYxM093S01tRlhmL09qYWlNaFpIL2gydm01WGNNbHpRYUVG?=
 =?utf-8?B?VUxUR1N1SURvOCtSbHNVdGttcU95dUxFK0hNakUybzlZS3BUSHM1Q2hMT2JO?=
 =?utf-8?B?eS8vSFNIY29oMkpWMDNhSWdyaDRpcGZXM3Rhd25pbDBJQnk3SWxNOVRRZFBx?=
 =?utf-8?B?MmhGUlQ5NVdpMXdSSzlrMjlKQjQ2TFdGMHhQbkU3ck5RZGJsSWFCb3pGUkVq?=
 =?utf-8?B?TmlTMVBTMXY2RnBEZXVURHhtUUE4MmovWEs0bjhSMXdkcVltNktjYjIxMXg0?=
 =?utf-8?B?TnhLalExSDlaSHFCbnpUVjN1RWpoQWFPSzVvdmpBNWRLbWlNOW5Jcmtmek9C?=
 =?utf-8?B?TVMxR3BKeUp5UTFqOXUrcFdITlNabm5Oa2xDWmtyUVdGREZ4bElzWkw3UnVx?=
 =?utf-8?B?K2daUWJqSXZqNHFDWmFNNFVSVVZZVktva0FCdzBMcHBGU1ZKMDZCVzJ5d1RP?=
 =?utf-8?B?eXpVLzdoVk13VGhsZUpaR3QrbHh0Y3FCVlgzMUZNc2Q0bER5N0JDY2s2aVJT?=
 =?utf-8?B?Zmh6SUF3VmIxMDRDekhHRkZKVlVtNGtLOXo4cWVuYnMvSkpaSXB0Q0JMeUdT?=
 =?utf-8?B?NnBoUzQ1R1pFTkZuUWk3bjJ3L3haUThFeERzRm5FbmFpT2MwNkx5T2Z0Mm93?=
 =?utf-8?B?Z25pRE54WUo0R05oTm5oVlpjSzdrdElCWENxN25TdlJKZkhwS2w0QWpPbFhD?=
 =?utf-8?B?cGdMallxN3BTUjNQVXptbFpWeFRIM2k0Y1RZaGpraUxDRHBuNHNjMmNmRHd0?=
 =?utf-8?B?WmNpTkVhWUtETmQrUDN1ZVJDQmFFazhtNFhIUlNxZlBxK1NBbXcwYWhqbXFz?=
 =?utf-8?B?c1dOK09WY0hsWDlHQ0JiZEVva0pUbTA2QXhTU2ZVUFRQcHlPZjVHQ2tCY0lU?=
 =?utf-8?B?RmN3ajM4WDVuNDJkN1JaNkk4RGI2cUpRT2RKU1U4WkJaV0hFcFlTMXZZbWdK?=
 =?utf-8?B?VTVvTjJod09MUndocFFDbXZhMmI4WUZ5dVRNQTRZOW9pd1pCeTRyRDluTFZN?=
 =?utf-8?B?V09xMklXRGtwRy9Rcm9pOWcrZ3NqTitVQ3A2VTJpT213aGE1ZityRzJFYUlD?=
 =?utf-8?B?YndiSkFDYVdIU29HM2dteGhYSFVNZWlCVWxyU3BDcWw3b1RVK3NhdHdOSFBh?=
 =?utf-8?B?SmkyemFpZS9Rc2tQRzhNT2dQSHhqLzhlSjJJaG5TRk4zbkNjeVA1QUlBTGR2?=
 =?utf-8?B?azlQQ2FISmZrMXZKNFJORnJtT2g1TjN1WjlTMUdINHpJNFQ4bGtadVpmUnJ6?=
 =?utf-8?B?OUpod1MvQmF5UWdTbzRyb0ZpbVJlSnYvbDBwTTN1QzM5OXh4L2VJdGdtSDZ6?=
 =?utf-8?B?VDE5T1hWSHhEalhoZndrOUJYemVpK2E1S2gydmJ1QUdwcWVIQ3pRUUNZVWdM?=
 =?utf-8?B?c21QWXM2djhacDFBa0dKN0p1QzFCbWt6eEtxZndMeU10SExMQ3lMeThITW5k?=
 =?utf-8?B?eG9pMkJTbSt6YnNhWHdFZk1uRFJ3OGhJUWNUNkUwV21YcEJpNVBsL0thNVFS?=
 =?utf-8?B?ZHFPYU90dkExSEk5K0hmTGNPMGp3bkhVZ2RXZ2w4NzVySlAzaDR6eEVaWlYr?=
 =?utf-8?B?QUN6T2ViQ0hDNUpabzZxdy9rTXhZMFdiYy9GeS91T2MzQ0pnQnZCSlRXK2Y0?=
 =?utf-8?B?Q2ZqNGNabnJwcjg0dTZXSUwvekJYZVFrKzhIODRjNVNXOHp4ZWZnQVRMUnE1?=
 =?utf-8?B?MStWN1VLdEdUWWhTMmtRR1ZPTFozeXA1VEdZTXRjZ1Z4NisxNGtSV2lod0Iy?=
 =?utf-8?B?d2FSKy8vc0hEVjhzRFVzL25EblYwK213WjVlb01zek1QczE4MzcwaDFrcmZh?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8118c8-dcb5-490e-634b-08dd05d9ac03
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 00:57:40.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfk63zY7tOW9kKITJQZHcK0vpEdl+r9cBBuddf//1fhhlb/bJM9LKDnT5uPwJ1dU8QPIFsB0frwB6QuSBlrSLs76hTkbas9n2lHWL7ZUs8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7686
X-OriginatorOrg: intel.com

Hi Babu,

On 10/29/24 4:21 PM, Babu Moger wrote:
> The mbm_cntr_assign mode offers several hardware counters that can be
> assigned to an RMID, event pair and monitor the bandwidth as long as it
> is assigned.
> 
> Counters are managed at two levels. The global assignment is tracked
> using the mbm_cntr_free_map field in the struct resctrl_mon, while
> domain-specific assignments are tracked using the mbm_cntr_map field
> in the struct rdt_mon_domain. Allocation begins at the global level
> and is then applied individually to each domain.
> 
> Introduce an interface to allocate these counters and update the
> corresponding domains accordingly.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 00f7bf60e16a..cb496bd97007 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -717,6 +717,8 @@ unsigned int mon_event_config_index_get(u32 evtid);
>  int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>  			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>  			     u32 cntr_id, bool assign);
> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>  void rdt_staged_configs_clear(void);
>  bool closid_allocated(unsigned int closid);
>  int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1b5529c212f5..bc3752967c44 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1924,6 +1924,93 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>  	return 0;
>  }
>  
> +/*
> + * Configure the counter for the event, RMID pair for the domain.
> + * Update the bitmap and reset the architectural state.
> + */
> +static int resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			       enum resctrl_event_id evtid, u32 rmid, u32 closid,
> +			       u32 cntr_id, bool assign)
> +{
> +	int ret;
> +
> +	ret = resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id, assign);
> +	if (ret)
> +		return ret;
> +
> +	if (assign)
> +		__set_bit(cntr_id, d->mbm_cntr_map);
> +	else
> +		__clear_bit(cntr_id, d->mbm_cntr_map);
> +
> +	/*
> +	 * Reset the architectural state so that reading of hardware
> +	 * counter is not considered as an overflow in next update.
> +	 */
> +	resctrl_arch_reset_rmid(r, d, closid, rmid, evtid);

resctrl_arch_reset_rmid() expects to be run on a CPU that is in the domain
@d ... note that after the architectural state is reset it initializes the
state by reading the event on the current CPU. By running it here it is
run on a random CPU that may not be in the right domain.

> +
> +	return ret;
> +}
> +
> +static bool mbm_cntr_assigned_to_domain(struct rdt_resource *r, u32 cntr_id)
> +{
> +	struct rdt_mon_domain *d;
> +
> +	list_for_each_entry(d, &r->mon_domains, hdr.list)
> +		if (test_bit(cntr_id, d->mbm_cntr_map))
> +			return 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * Assign a hardware counter to event @evtid of group @rdtgrp.
> + * Counter will be assigned to all the domains if rdt_mon_domain is NULL
> + * else the counter will be assigned to specific domain.
> + */
> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +			       struct rdt_mon_domain *d, enum resctrl_event_id evtid)
> +{
> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
> +	int cntr_id = rdtgrp->mon.cntr_id[index];
> +	int ret;
> +
> +	/*
> +	 * Allocate a new counter id to the event if the counter is not
> +	 * assigned already.
> +	 */
> +	if (cntr_id == MON_CNTR_UNSET) {
> +		cntr_id = mbm_cntr_alloc(r);
> +		if (cntr_id < 0) {
> +			rdt_last_cmd_puts("Out of MBM assignable counters\n");
> +			return -ENOSPC;
> +		}
> +		rdtgrp->mon.cntr_id[index] = cntr_id;
> +	}
> +
> +	if (!d) {
> +		list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +			ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
> +						  rdtgrp->closid, cntr_id, true);
> +			if (ret)
> +				goto out_done_assign;

This may not be what users expect. What if, for example, domain #1 has a counter
assigned to "total" event and then user wants to change that to 
assign a counter to "total" event of all domains. Would this not reconfigure the
counter associated with domain #1 and unnecessarily reset it? Could this be
made a bit smarter to only configure a counter on a domain if it is not already
configured? This could perhaps form part of resctrl_config_cntr() to not scatter
the duplicate check everywhere. What do you think?

Also, looks like this can do partial assignment. For example, if one of the
domains encounter a failure then domains already configured are not undone. This
matches other similar flows but is not documented and left to reader to decipher. 


> +		}
> +	} else {
> +		ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
> +					  rdtgrp->closid, cntr_id, true);

Looking at flows calling rdtgroup_assign_cntr_event() I do not see a check
if counter is already assigned. So, if a user makes a loop of assigning a counter
to the same event over and over it will result in an IPI every time. This seems
unnecessary, what do you think?

> +		if (ret)
> +			goto out_done_assign;
> +	}
> +
> +out_done_assign:
> +	if (ret && !mbm_cntr_assigned_to_domain(r, cntr_id)) {
> +		mbm_cntr_free(r, cntr_id);
> +		rdtgroup_cntr_id_init(rdtgrp, evtid);
> +	}
> +
> +	return ret;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{

Reinette


