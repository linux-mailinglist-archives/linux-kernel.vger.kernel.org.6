Return-Path: <linux-kernel+bounces-417458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C36B79D544E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2281F2133B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227741C9B76;
	Thu, 21 Nov 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNF+wulv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0119DF62;
	Thu, 21 Nov 2024 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732222225; cv=fail; b=LuUmtDauRaOvOdMQ8NLB1x9lv6xdyWLI4nfqpSKQzdVecQ8FFywzzM1Am2NfqliyD7nX/Enbpa+IeCZlOpnJ9a4PQWkmKQhhsgYjx0D+4P0Us2JhDIeWZ1f6agiha/tLf+lbxyfrjclYm0UvugXssjkq9pNZ9aIbEYmYMTUs8PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732222225; c=relaxed/simple;
	bh=TRUN0GxP+zd0VFGbUMQBriu5RaXkS8RQSkHuKqOUATU=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cx330briZH5JapuukgHAfZqP/BrBk2xFLBgVrvn+x0A2Dc+LY6ghvwFKQbV1oT60H4oXY+SyZkscYrxjLsTVHgFGJzebpfdF+WLARq0P52TjVnPI+bpnjVfBD/SnSRthRtkVMXcmcirusPXf+phAIsgnufuAzkC6oYqQ1cApLDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNF+wulv; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732222223; x=1763758223;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TRUN0GxP+zd0VFGbUMQBriu5RaXkS8RQSkHuKqOUATU=;
  b=XNF+wulvMZAfamRBPoPg1I09SMCN+Xq6/hLUaYzZ1wcsxAJFDXt0cpya
   DoXKA7yoZFitQ3Z0UbZRNwN2mEZCGAG2rb6zGDZY5beZFKxLZMReLXCST
   84WALjhM4/2oa0YcuVd7ZJueia7PhajR6cQtgOgt5+m+V4KhQ+xi5YVVH
   Roq/xek63SpIgXfVsXW+LYarGPogCLMFyO6wM+o99QFrRJlh0bRAIz5/U
   KWf5Q3GxDMjNUfJv6/OWFFYbGtfnPLQk+3XHgrYCuPtoVzOncteFsSxAo
   p6fu3f08VfAOQvSqAM/Q2sIetbga4oZ3MGlrhoqQ40dk2WPJbcGut/GUj
   w==;
X-CSE-ConnectionGUID: HPWgF0d0R+CDjiNLpIY3Jg==
X-CSE-MsgGUID: 4d0yuO0mTUarc7fbt8SV1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32508524"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32508524"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 12:50:23 -0800
X-CSE-ConnectionGUID: tmjXZ8SHSQG3+UzrWZ4h5A==
X-CSE-MsgGUID: h2ihKy6WRyC0SnBY/ATKkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90009270"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 12:50:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 12:50:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 12:50:21 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 12:50:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBS2ox5KyOFzZaFNFzgzZinebgNp7s0MyzPXGK0lpgGC+R+aaxMuB+nEFvMXOJBl+4sZnbvMsF0SV6NhzqZoFAu5Sbx5RCFigE/OFcezLNUbdDP+J2I9jLP/sKHKiodl86jJGGNmh+6ichIV+yLDzZPBXWjaEZqyar76/X0rFm+u69NxKrajtxTj+1kMxNoi+6XYIEJzdiw7luxJV8AXIwKxjWndzmYQl5cy9y8u/QVikkAW66Gvr+b4SVXR2XrrG7azT9AmpZh13YJAa6Wm7bpf3+VTpCYpw9HSg0KeE5KLVxOOaBWWOSkdzqzey+cOPc0x2TOhbhsKxomBVN1nIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnGzq6ntstj2iHmJ+XDQ93elOiC1KuRxEz9BRq63a4s=;
 b=sp8X1RBDRA80VfVLpiiQ0BfsKbfL+8X9sn3uwYs70vTZKQ5T/4aEZXTYyKq9rkmxwhr3dTCmcHbIUpm7XWLuM/ATt0dA82CGGX+V78lWhJDK6hFkjDRqKSs/igRGOcLtkrsAK/H/UsSlyNVPr4itDqVJIbX4HLcAiCGDi79PkfoMYx6eDH/8UADLr/ba9c3Cgx6d38wYNq67Hab9wdp35/h2g+56YFIZhVNBU45F1r6ifU3QdxeAHEMErkFB4KgWoyGr2mahU+bP/alztmy+DPbRfFOrXqWbEpoD5faiNoaaAcd9xpEjIEULSS5G4VfMKHGoJHV+CqfcEgnzuIcv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB8043.namprd11.prod.outlook.com (2603:10b6:806:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Thu, 21 Nov
 2024 20:50:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 20:50:11 +0000
Message-ID: <7fe1298c-d026-460e-aa0d-76144abce524@intel.com>
Date: Thu, 21 Nov 2024 12:50:09 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 18/26] x86/resctrl: Add the interface to assign/update
 counter assignment
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
 <3851fbd6ccd1cdc504229e4c7f7d2575c13f5bd6.1730244116.git.babu.moger@amd.com>
 <1757cedb-e5b8-45fa-9b70-4c78b5770624@intel.com>
 <77f808e3-1dea-4a85-b574-dcdcb03697f9@amd.com>
Content-Language: en-US
In-Reply-To: <77f808e3-1dea-4a85-b574-dcdcb03697f9@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d9704b-2b80-4ec3-844d-08dd0a6e176d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dllPN2orelVpQ0tQM2Zla3VKMjRRWWk4anlxbUc5Y2lmQVJNdjVRNmcvVElr?=
 =?utf-8?B?SXNsZXN5aGNWa0VPTXFrT3JsWmdoQjR3UjB1WmpnbU1DVVNjK1ZCeXJUNG5q?=
 =?utf-8?B?ejBPK3pUUUE4NmEzR2h6MmY0NVNOTnF2ZlNRSnFhbWoxT3RmZWsybmtCSTJP?=
 =?utf-8?B?SlpaOGxpUGtQOWpLZlVCVW80Q3RlT21OOHRNem1YZEYrOUxvQzBTRWlka3Bw?=
 =?utf-8?B?b3YvUWNoN3J4d2pEN0ZobW03SDYrU0NZTXdkejluKzFVNGRLaXBqOWlJR1k5?=
 =?utf-8?B?OTg4c3hqUTNUWXZHWFdHQWg2TURzdSsxQTIzNTFDNFpFYWxXbVRxdjRLYnMz?=
 =?utf-8?B?eXFjcFkrMW4zUkg1dmZLZ1J1UHM3dzlWZWo2UkJjcUxVVUt1aitDbi9zUkJ6?=
 =?utf-8?B?WFBmYzZJNVduOURlUUhYRHFEak1DQkM3S1hzT2ozOEFpVWRrY1RkcjN2M2ZK?=
 =?utf-8?B?Mm1JK0V0bG1oTTFUVUp5M2pZRHBENkFxa0VxSkVsRjM3QndpOTAwSzFTaG5o?=
 =?utf-8?B?TlovOG1mSzM4enFLTFdXN2ZRcHpTVVIxVmpxd3RZemU3S2ZZWlVRTSsyWWdD?=
 =?utf-8?B?YTVZNnJSQnZMVngzcForUWpWVEN2ZDlsY3pFUUpMdE96eGxybVRBTWN3bmty?=
 =?utf-8?B?RFJId014d25TME44VW9xN2xPWXczak81UVRWdnJ6djZvdkxxSDFtNjRIM2tm?=
 =?utf-8?B?WFVkeXhLSmtRL0VsUDJJMzRZQS9JUW9weGk2YXYvSjhPTnNOZGZ4cEtZM3VN?=
 =?utf-8?B?T3VVWlZMZHZMUllvTm01Ymg0bDRaRk16ay9CQk02bisxcEdKdytwZTRvV09Q?=
 =?utf-8?B?Zm1EV29EaFhteTF2MGhJaTR2a2ZYVllaejdGRWlHeEJsVGd3alJGRXMzL1J2?=
 =?utf-8?B?Myt6Wk4rZFNQTjJnTU1xdXU2eVRWQmIvUVV3Z29icWtwQWpSSWdKbWdNMzR1?=
 =?utf-8?B?cThSc2J4MStMVDEwejBaRHFqbUR5Sjl4eWlFR3AzZXJaWSs5Z3dVbkdPRlM5?=
 =?utf-8?B?eUQ0ZG5DbHRJL2w2SThjdklrbVcrR0JoWFVrV2ZuTXdyR29hTmNGcWVjdlk0?=
 =?utf-8?B?dHRtNmpDL2FlYXZaVzUra1NGaFR3RnRxdFJ4YXcrQURoTFpHMzdSamtRYkRU?=
 =?utf-8?B?bHpUZlpXNEdZUEhldS9HaUlPOWY0cjhWWEk1dW5XL2h2VU15YnNlWWswZm9i?=
 =?utf-8?B?dTI1TXhlcER4UXV1UTBoNmtoSWwxemJnaTVENDNkSk9USUhEK20xZ0VVWEVZ?=
 =?utf-8?B?Mnc0ekxZc3o0TDlHaXV3MlNPb1M0RmtLWlZ4U1ppL1FLU3lSUi9zb2lZL0xy?=
 =?utf-8?B?dGJ0NnZSZFZBcU1xRytqZTkxVjRIWndBRyt4dWc5L1FlRUdxdUwxdWRBeUo4?=
 =?utf-8?B?MWxTNHJkNlh1Z3pOL0xmZHNQaDNxcER0T0ZYUGRyNzZLTWZINVM5Zzd0dFE5?=
 =?utf-8?B?TmJGb092NTlUY3dlL3MzcFNqWjRkQXoydUdCREdyN2JvcWppRzZzd1NPZFJa?=
 =?utf-8?B?RU1DMEExYUthL0cvTTh3bUFraldJVTduTVMrem9sbUt0V0NhdytTYmRuRjZQ?=
 =?utf-8?B?a0YyZW5qZTB4U3FsZVJzOGRrc3YzR25GbDhjaWxJcE1GUjVDVnVxN3FHUDdM?=
 =?utf-8?B?L1pGMXBVZHJyeUJRVlZ2S3VUaDJZeHhRcUVqb21zSXJjZm9Vb3lacVltaXhN?=
 =?utf-8?B?R3lraHN2U0l5eUw3ODlrbFdzam1nZFZSWEp0NVZuWHdZbGtZZlpHc2lRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UForTjgzaVhDZEN0YlZvQjNyZVVjYjc5SklISEtRUkY5OSs3ZWQ5S0FqNE1m?=
 =?utf-8?B?Q0F4UDl1UFJnL1g2UDg0L01mQ1plbmVRc0I1VytyTk0zOWpLVThrTk8wUkd2?=
 =?utf-8?B?MnE5SCtlbUNRSXM2TGw4eVZjNDN2Z25MVWZyNWtIMGpBdkFTZFNFMDF5OTZR?=
 =?utf-8?B?ZlNiaTBpajVqTUNqYnloMHZuVXlGVCtkS3dtRGRBYW5sb2dlUkRGRmUvZzdY?=
 =?utf-8?B?ZHFyMjBscTBVZ1pXYjFtT0VyazBHYlJJbTVzdmZPWEw2Z2xQeENGV1ZjWWhD?=
 =?utf-8?B?L1IxSXN3UmxGeXVqYis4RVlrR29sUjZKWjBNNm5QMFh0Q1pVVHBXTFJ1QTZG?=
 =?utf-8?B?WVdxdmlOcnVTU3Q5VzNMK2xmdmswWk9CUkVpRTRIZUdhRmgza2lYQmdXajhk?=
 =?utf-8?B?NjZUOVhUMmgzdlFHL0NXODlyUSs2M1NTRkthYVBVYXNWa1hKdENuODhIYVpx?=
 =?utf-8?B?bGZuT0dKMFk0Ym9HVnRMZGdIZUloTlE4MVNGbXRyZWRtWkRoczJsWDRSaStM?=
 =?utf-8?B?YWVtMmNPVFVuRkJxakZtajd6ckx2ZzF1bHFlcm44dnFpVmRVc2dIQlc3THJH?=
 =?utf-8?B?S3NsQzROUDdWVlVhUENLK3Y5MHRjSUw0R2pBZUlDb01MQklqajA0alhvREds?=
 =?utf-8?B?ckxweFlYVlBtVXZkQzNBWFhzdk85d2Y1YThvaDBtN2lTTllDWkRsajAzOXp5?=
 =?utf-8?B?dkFSWnVGMlpNTGdHQmI2N2VtY2hiM09nVXk5ZHc5a1JXd2Y3ZCs4TVVEdFlV?=
 =?utf-8?B?d0U5WFpXbnQxM09QdnVYTmN6R0FNMHVlZjUweG9jVlZiT2NqOEtjOEY1SUla?=
 =?utf-8?B?Z2ZwdnRnRlJkckpPaFZRSTdBVncyTmN4Q1IyZWdPRGJYNy9sRCtnRGg0bGRn?=
 =?utf-8?B?WEtsTS9WSTFjMDJFTnU5WDFGeTJSY2JSK3QvdXlTT3A4U2RNYVllWDhrUFFp?=
 =?utf-8?B?YnZMd0YxdHlUVk4zdHU2c0JBYlB1N3FoRElGUEp6MU44Nld6LytvWXlqbEZt?=
 =?utf-8?B?YU1TTVZ6bnRFdEsycFg5K2VCUVdUZFRjMWc5RlJWK2RyUXM3YWhZc2NDTFNl?=
 =?utf-8?B?WUpPbGFIS2QreVVYVlN1Z3JscTZzcUxFbzR4SVZnd1ZYZWN4T2xUNklvbVYz?=
 =?utf-8?B?dTRDeFBpQjU0NmpaWVpzSk5EdkRFUzg2SndGOHF1bCt3ZERCL1UxTXBjU2xs?=
 =?utf-8?B?U1pxaW9qQVlMakxWZGYxaXU2aGl2dDJxeVlPOTNrTldqeUQ0RFpwNks2cmlZ?=
 =?utf-8?B?MTlwTUJwcnNnNDVscXhoTkFPV2tIdmZDRHBJQ1RIUWJpYlNBM3RtVXk0N2w2?=
 =?utf-8?B?K2Roek80eUpiaXVmT1B3WE9tdTduZkxnUWRVTmFMVU44K29TeTAxU2l5RGNY?=
 =?utf-8?B?a3RWSm9DTHVRSEdJMGcwdWlwdkt1YTF4bm42Z054Sk8zZnY5b01xTER6WXh0?=
 =?utf-8?B?a0xYbzRXMXV4WkxiY0NDa1FDeHI2bUZZbU5sZEVKSExrR2MrK3VUVXprR3BP?=
 =?utf-8?B?SmdVUHQ0K1lCSTFqM0FmSHRZbi94clh0OVI5dVpwLzllNytBMndKZGo2NERC?=
 =?utf-8?B?bGVuemhFRHFWQXRvT2p0bEdaSEdXU1pndU8rWUFncFRRV0F1ZjhPditCdkVq?=
 =?utf-8?B?ckVocnM2dndHZm90TmMyb0dhbWdPYnBlajNQZm9Td2lWdmJGeGxoMitZM1Q1?=
 =?utf-8?B?NE5oYzZpR1Y2L3ljYUJWL0MxRHZFcXZxeG5MVHRCRGE4ZEx4aEFJb3I3bUtv?=
 =?utf-8?B?YURrU1Q3cW9xMi9MWkF0ZklnZ2VKSEZaNjRNbmg1MW1teDh3OXhPSVR4R3dG?=
 =?utf-8?B?blZ3RWxZaTBNU0k4RW5OU09aaG45QTVVSEl0cHlwVjZTemFPQ2hOdTJQNDMz?=
 =?utf-8?B?MnYxZjdJRTl6UUtGaWR3T1VndEtiZzBzK3NBWHl5ZDc3VUtoY1VjcnJoZk1R?=
 =?utf-8?B?bThYanFOWlVlNjNsNUpSTWZhcWx1NHJpNjM1aUg3TzN3NTdMUExOeDU4bXNo?=
 =?utf-8?B?dTRQdGJNUWtRcFNRM0lmb3R3TTg5ODBSSzVlc3hIZ1pxcElOS0VsSVFXL1pS?=
 =?utf-8?B?aVE0anFwRkJ2NDZ1bGRycGxGa1R4S0tFV0xlWGwrdGhHY25xK2lWQUpQRDVB?=
 =?utf-8?B?TTBMVU5rVnhCNVN4eFQwdGdxVXprNGc3NVVpYWhMTldreUo0REpUdEp4UndZ?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d9704b-2b80-4ec3-844d-08dd0a6e176d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 20:50:11.3908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7DEnFFej96TFVCyeGKl4vLdjIEc39CvFutzcDmzIYd0qbh41SDJTkEI/w8q61XHohmL8t1FDvuRjdICJAiwuJKSR9JytkNuPiFFYilxqH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8043
X-OriginatorOrg: intel.com

Hi Babu,

On 11/20/24 10:05 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 11/15/24 18:57, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>> The mbm_cntr_assign mode offers several hardware counters that can be
>>> assigned to an RMID, event pair and monitor the bandwidth as long as it
>>> is assigned.
>>>
>>> Counters are managed at two levels. The global assignment is tracked
>>> using the mbm_cntr_free_map field in the struct resctrl_mon, while
>>> domain-specific assignments are tracked using the mbm_cntr_map field
>>> in the struct rdt_mon_domain. Allocation begins at the global level
>>> and is then applied individually to each domain.
>>>
>>> Introduce an interface to allocate these counters and update the
>>> corresponding domains accordingly.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>
>> ...
>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>> index 00f7bf60e16a..cb496bd97007 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -717,6 +717,8 @@ unsigned int mon_event_config_index_get(u32 evtid);
>>>  int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>  			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>>>  			     u32 cntr_id, bool assign);
>>> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>> +			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>>>  void rdt_staged_configs_clear(void);
>>>  bool closid_allocated(unsigned int closid);
>>>  int resctrl_find_cleanest_closid(void);
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 1b5529c212f5..bc3752967c44 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -1924,6 +1924,93 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>  	return 0;
>>>  }
>>>  
>>> +/*
>>> + * Configure the counter for the event, RMID pair for the domain.
>>> + * Update the bitmap and reset the architectural state.
>>> + */
>>> +static int resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>> +			       enum resctrl_event_id evtid, u32 rmid, u32 closid,
>>> +			       u32 cntr_id, bool assign)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id, assign);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (assign)
>>> +		__set_bit(cntr_id, d->mbm_cntr_map);
>>> +	else
>>> +		__clear_bit(cntr_id, d->mbm_cntr_map);
>>> +
>>> +	/*
>>> +	 * Reset the architectural state so that reading of hardware
>>> +	 * counter is not considered as an overflow in next update.
>>> +	 */
>>> +	resctrl_arch_reset_rmid(r, d, closid, rmid, evtid);
>>
>> resctrl_arch_reset_rmid() expects to be run on a CPU that is in the domain
>> @d ... note that after the architectural state is reset it initializes the
>> state by reading the event on the current CPU. By running it here it is
>> run on a random CPU that may not be in the right domain.
> 
> Yes. That is correct.  We can move this part to our earlier
> implementation. We dont need to read the RMID.  We just have to reset the
> counter.
> 
> https://lore.kernel.org/lkml/16d88cc4091cef1999b7ec329364e12dd0dc748d.1728495588.git.babu.moger@amd.com/
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 9fe419d0c536..bc3654ec3a08 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2371,6 +2371,13 @@ int resctrl_arch_config_cntr(struct rdt_resource
> *r, struct rdt_mon_domain *d,
>         smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd,
>                               &abmc_cfg, 1);
> 
> +       /*
> +        * Reset the architectural state so that reading of hardware
> +        * counter is not considered as an overflow in next update.
> +        */
> +       if (arch_mbm)
> +               memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
> +
>         return 0;
>  }
> 
>

I am not sure what you envision here. One motivation for the move out of
resctrl_arch_config_cntr() was to avoid architectural state being reset twice. For reference,
mbm_config_write_domain()->resctrl_arch_reset_rmid_all(). Will architectural state
be reset twice again?
One thing that I did not notice before is that the non-architectural MBM state is not
reset. Care should be taken to reset this also when considering that there is a plan
to use that MBM state to build a generic rate event for all platforms:
https://lore.kernel.org/all/CALPaoCgFRFgQqG00Uc0GhMHK47bsbtFw6Bxy5O9A_HeYmGa5sA@mail.gmail.com/

Reinette


