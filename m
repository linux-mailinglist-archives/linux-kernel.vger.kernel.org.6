Return-Path: <linux-kernel+bounces-421532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27FD9D8C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8811E166C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446F717E017;
	Mon, 25 Nov 2024 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhjqUmXC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C941CD2C;
	Mon, 25 Nov 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561252; cv=fail; b=txR8IHSpoyzUL+tC3jHRq/ELjARHcmb/taNDID627qAcSpL1EdgdP1/uJbO0Y7oDLqam/mymTrmeOpYzxe9pTPn5yopJst2v0pAyAZCyI+mq5oTRw97a6vNNdFQ1rHCKdn35HjCB5EjpzLScN+irgaqHklErgDdk0Tkj1SkgYCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561252; c=relaxed/simple;
	bh=xarNUJkJbOewWzmFLiQhXafikuQGU0Hfl32yxAgvrqc=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d7FXzA267nfeOM/dsWPqqDeJ0WdpLaPnIdEhzrY5QKPM5LAVLdZLEgWZOc4azG+qFVGw59TvQJXuGdozv2wo+P2edw6FCL5wIyQipGtXdymU5JTeVMGKrtY/uVmmLeQ9jvwkzA9tz//KW5O4+/gIJisSpSzWrQan23nS2r8FYUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhjqUmXC; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732561251; x=1764097251;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xarNUJkJbOewWzmFLiQhXafikuQGU0Hfl32yxAgvrqc=;
  b=WhjqUmXCeK2IFAJa6fRHHw7ro/YTrcZghxX9o98E6eynCGvGsz9u/Qq1
   iFZ1oTwi/Q1qweXvHOoztaofw3eXnNlgzGpZJa/SHPsJAq2vbjeXN6YIY
   4n4E0vXLVSCd1843hLbkNmPWPabOKRvFo3oSjkmmgkbS1cDBzfBda+JXV
   JK3tP3gavtiR6INH8ws+xNaj5MGOZ/sD4P9zll+WdRFjlFCXj4qc/5xUK
   5IECYIkbG7YEkppOzIKjt4Psn9H3ptD2TSIImNNyBmO/3Izg47EMERVaR
   1G/rj0xq1nDAFKuMXTGn77+SEjltgvV7pezul7B+1EhzV9FdjG94gagVM
   w==;
X-CSE-ConnectionGUID: MqDj72M5Q/CTe8NmJeOgvQ==
X-CSE-MsgGUID: z2U28jPyQSiTDlEQiEDS6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32632288"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="32632288"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:00:49 -0800
X-CSE-ConnectionGUID: 4P96Uh6DQ5GMFmKxyNgFxA==
X-CSE-MsgGUID: UHpkhzhdSliDJpZWJOg4cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="91546591"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 11:00:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 11:00:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 11:00:47 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 11:00:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhRar11fCIdS+Dx9yyaes+Q9wmlkYJMNp3da5gU7p0AzSfgRDQLeO+Wpl4IXRiIBoRzlmbKl5v6s6FFYUAx67N1R9lff5Eh5m6JS+rD+qgim3uMP8j5XUBJ453yYHVp+D3MAa9RTzkXwTH0bNWYb4skPtrK8n/tRrSx4HA5u1onLCacA0jEs1fSpRLVu+wq120sglGSmQ2/pdTrqCX9KaD4DJD8ivVRsCdLa19jYERs5fxXnRd6Tsqspn2NF1xdS9lSP8w8DzMZbt3cLp+bcE9xjxb/crpDn8pmb2YbUR9noWO2Kscgb6xGPsN8Rjltpue8aKvTxIXo4i0aa3AZ2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1Y1/JcBGbu2DQx/57jznmqo7ilOl5ZMPOE0pvL0iOE=;
 b=v6RD5+7J2dhUAmEH7WUEkam+dDl5xh7YzBUT3HnslsEPxWj/3Skrln/u82k2s4DWvVpS2QBOWVe9pQOgqGtof7lX5VLUhFtCsC0DAT4YUUhUsewdRgB9cLRMIZfjnAKRis+S9aiCSkrsh2Xp3WBae/JNw+ShZjwFELkLO8fWrULOaK6PDQ3Cb8OKa0OmbSoOzEXBIM+4GCV4WPB6nHBIdCYgirwiLYfgxWs+Jz/abQIMTXNzUAlLix8zCxUVsBmPP/v9usSRJ6B99dfbz+FMu0XIy2zksWjchkVPLr8nys+MxdF74/rgsyN2F879zh6CJLAsKonl0D9HcMyTzbPFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB8090.namprd11.prod.outlook.com (2603:10b6:8:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 19:00:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 19:00:42 +0000
Message-ID: <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
Date: Mon, 25 Nov 2024 11:00:39 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
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
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
Content-Language: en-US
In-Reply-To: <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:303:2a::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 646fe44c-98c6-4bfb-ff86-08dd0d8375e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFM5WDgwbWk5MkoxdlBSeUF1TVZQSnBaMlpYdGFYRFVNakMvSE1xaVpnTzBi?=
 =?utf-8?B?UEVVY2xCMUc3R2FvU2dTYzhxOUhKYWo4K2x3akF3elFOUmdmSkkwN054ZzZQ?=
 =?utf-8?B?VE9UM29VaDBTWGhJenNxbzl2cWRIWk45SXdUTklRTWxFS1pJVFBkbW1NZjZD?=
 =?utf-8?B?dXducGlXMmVsZWxaTjdqRHpBbHZlMzVQUW13c3YrbXZoVEQrNWdtcnR5ZWJH?=
 =?utf-8?B?cFJCaU1tOWVpWmtjTkwva0xjaDMwM3ExY3hlSFVlRHNKU3NyTHN6ajcraHVi?=
 =?utf-8?B?TWUwU2pBWkVQMDBEaW5qUXJiblJzMGpqd1hqSDE5MUhjYzZnZGtwb3dZSDJ4?=
 =?utf-8?B?QUZESHdHVUx2YjRVU1gxa1F1NFlPSjNkOEVkVjBpZDdNR05vbUJTM3MvTzJL?=
 =?utf-8?B?SHBCa3M4RHFqd1Rtc041R0lvenV4SXZkdndkZXR2RDFNMG1FZUROK0pvcUcw?=
 =?utf-8?B?SU1yUmlGYXdUZHNuS3FDQ0NUT0p0L2hESzRIK3FvNyt0ZmM5LzFjWVYyVzln?=
 =?utf-8?B?WGhoRWFwWVR1eUxBTklhVkF0ZmY4bk5EaTNKUHQwL2MycHFidVFoTy9EdEx3?=
 =?utf-8?B?eDhnMG5RVGI3SlY0UW15L3dTR05uWGdmV01pMHpoTFdoYVFIQlZoVm0vQ0tO?=
 =?utf-8?B?Q25WMUlRVjVLL21zdEZ6NEVHMGEweDJieFBiUEtoclk5cWlMdzQ0VjEwbmwz?=
 =?utf-8?B?THVSdmRBU1lJZjMzcjJqRTJxb3RsK3JXbkFxNUN1TEhvdm50WHpaWmROVnZJ?=
 =?utf-8?B?ZmZ0eXNlWHN0Wkc4TnlzZW04ZFB0a3JMaEZMWFlYSDhQVlQrRTBsWHdjVUEv?=
 =?utf-8?B?UWN6eHdZT1JUSHlnayt5U2dzK0Y3K3lQTFR0ZVVneXdqS3NvempDTjYwYUw4?=
 =?utf-8?B?NElwQ1lMZkJIYVlqb0hnUkRrSklXNFFheExtWVNaSnhwcDdDT0hmL2plVmhx?=
 =?utf-8?B?MG11WGxXNVpuOWdNdjhRRHNrWS93SEdhZHBtWnFzZEtTTzRBbytoK3ZsbXVl?=
 =?utf-8?B?a0ZRQjRNeWs5NExLc3cwdnlpdTdvUkY4VFVMUGxwOHRMYkxlNEFuNExlRFVW?=
 =?utf-8?B?WG9IZTg1bm83d21VODVsbnhWbFpHbFVxTG9BQXl1T0o0Q2xhTHpFTEZGaWxm?=
 =?utf-8?B?cFJjWUxybGY1aExwbVg0d1VDQ2RVRHBSalk5ZUhTT0t4Tk5uUkF0ZG9nTDZ1?=
 =?utf-8?B?TWVSUUJZRXYvbmRZWU1lMDFrbzRSZk1Nb09RQmdoWVA2Y0prekRzNHU5TmEy?=
 =?utf-8?B?U3JFYk83TExDV0YrN2tpN3crdnIrRGJCWnRwRFhDR2FlaVVRQ3E1VmdaVjJF?=
 =?utf-8?B?WExSNXpucTRTM2lKSHV0a2RLZzZaZzFjTDlVWCtiLzYyRDJlbE5tS05yUndT?=
 =?utf-8?B?YW93dXcrdW5Da0gwMVkxS0tQWXRtbE0wVlRNdVg2Ym9mODJnNFBaQmVVR2hy?=
 =?utf-8?B?OGcxWkJ1ZVl1RTgyR2k5cE5BUU9HRW5sK0pYQ0RaYWFQZmlGQUE1d2FzSHUw?=
 =?utf-8?B?MzNzbWk2K0J5VGJTVS9ZQWMxSS9BY3pOa2YyeHYzWEVSTTRNTFAvRTVPenp2?=
 =?utf-8?B?ckR0Z1U4bDFGY0FNc1R5d0dlUnEvak8rMWtUSS9pN3FYbWNDdnBDaUJ5OU54?=
 =?utf-8?B?VURYK2tWMnBlWTM1MjNKOGlMQnR5V3NTTU01OUQxTHVHUGJmMXNJN0t1YUE4?=
 =?utf-8?B?Z1Zld3plK0kzakN2Zk9oWTBwQUVwMW1DVEJ6SzBwT0ZKZWxUSjNWdDg4L2N1?=
 =?utf-8?B?Z0lsVDVCR0E5SXkvbzk5TXhHZWt2bXl0eWFLRk5yWjBxSUlGZlpTaU1tZWdv?=
 =?utf-8?B?eTlMRloyR0dTTFdvZjhyUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REMzeHVhbisxVTJtM0F0TDI5bFhIV0hlaUhUcVBPTGI5dkdxVDk0VkdKRmpw?=
 =?utf-8?B?cVh0c1FSVGFNc29OZnNuVDhvK1BSanJ2elIrSWhFaUV3QzJkYi91em4zNjV3?=
 =?utf-8?B?WlUwMmROS1FBZk1DTWdLNTNJV2ZReVhORFJ2TlQ1TFVCWlVqVGl3OUQ5aUg4?=
 =?utf-8?B?MTAwQmpTZEs5RExzRnJIVlZLRzZBdVRiY1NsMldweHNNZStxRWNadmtXOG95?=
 =?utf-8?B?K0RDaE1jMlkwKzY3NzN0WW1SOVRZbzZ5UHpkOW9ienRkZGpBemxQVTg2NEtk?=
 =?utf-8?B?TTVjYlB4bVRuMTVxRHY0K0RNYjB5NHF3U3lvL0xST3l5bmNLZXJ0WXJjRUN2?=
 =?utf-8?B?L3Z5Y08vWnlkTVQ0ckxwdGExT3JpRFhWU1JpMFIvWGljdzU2SGdhWnRsMWtS?=
 =?utf-8?B?L0F5djhwTGNvK0xCSzJ0SlR1Y3JkMXBUSFJ4d0llMDExRyt1dHFrSVhDdFFk?=
 =?utf-8?B?TGlGQ2tSU2FtU3k2WXhNTzBETysyYkdWQ29HU0cyY2pSY1JqUTBVRERUSm42?=
 =?utf-8?B?S3ZlaGVzNEpaS3ZOQSt6Z3UyU2RmTjlaL3VNOExCbVNhNFN0VVRkMzRiWm9U?=
 =?utf-8?B?WkphZTVqQ1lDbXYvUUZmajVVL21EN3ZTaUZqTHZTVlZGTXEyN3ZZelZ5bW1w?=
 =?utf-8?B?NHo0cGhpdzRiWGhxcXBweGsveXlNU2p5R01UbUZQWDBJMTJOTVBmM3lyNE02?=
 =?utf-8?B?SFJzbitJRGMybFFXSktGUkhEeHppNE8xUUpCY1Rra0FqbkszQ3NtYTkva2Rk?=
 =?utf-8?B?aERlUTF6WS9MNGhpTzd5Q25mVldMV1NtMFduQWhoZjJMNjNVOEUrR0RUZXBo?=
 =?utf-8?B?WkNRejg4QVJlTG81ZVVOTkdUbVZGbVVwaFBJd3ZMcGhEYXpSMVFwb1E4Y0FN?=
 =?utf-8?B?RERYSjJuTGw5OVRHYzAvU21NMkVCTllGVHRGS01mY3Jlb1hCamtPYUNVNWQ3?=
 =?utf-8?B?Wm5Md0s3emtJcnc4Sis0WDRqRWdHSjEvWTNkbDBLNDJ1RitGRkFuMEI1d3J3?=
 =?utf-8?B?K2RhUjNGY2daa1k3UWN3QUZrY3ViQks5aDFyUTc3UzBCaC9HaXNlUHVwR3FL?=
 =?utf-8?B?RmRrM21ZYytIOEFvRlpzakVnOXZoMnE0aWhwckZUV1JlOGxMUk5Qbk52SnJB?=
 =?utf-8?B?blhGNnJ3ZXROUUlKUDMvajljSklucUxsdHJadkQzZ2dRTFd2L3lrSXA4UDNz?=
 =?utf-8?B?Ui9lcWlqakVad2xDMXE3ZDVEQWlvUjUvRnZrU1gyT3JPRnFES3RHb0p6cVZW?=
 =?utf-8?B?SFVsVy80Zk5qL0ZoUlVuVUl5TTZ2YmEvUGZ2NVNhVlM0dWZqVmhBSWd1MXpn?=
 =?utf-8?B?RnRuTGswKzBVVWtIYUwralhpdzkwaUUzSzlETUdPNjI1a2xUZVFJUmhBb0NJ?=
 =?utf-8?B?M1ZRSVk0cVg5a1h5VDdPS3g4UXR1VDQ2L0hEQk55Wk5LaERkS29VMFFQMERu?=
 =?utf-8?B?N2llUVAxZGxXdXdjK0lwTjlsZ1hGU3dIU3l3YytlRWdnWnNOdlZITTEwaWtJ?=
 =?utf-8?B?TnovcGp4YWdmVU5hVHkzcDM2dHo3SlJ0N2hoNHhjWk4vaE1oQXNHSjRpZVgr?=
 =?utf-8?B?Sk5WTlFvWG9pL1JFdkF5amc0OFBTbE1YTEVOS3pyUmdFNkpSR3dPWmYxTHIx?=
 =?utf-8?B?YWFQdlpvYmFQNHBFZUZtSUtYVjQyaEN4ck5qdU1TYitBV1A5M09EV3M1WWRP?=
 =?utf-8?B?TGJjN0JIK1Rvd3RZUGpPZUtJT0RkczZML2FkQmJJcHJBbXhZM2h1U2xVWldR?=
 =?utf-8?B?NSsreFVydTNsN2tmNGE0Q0ZWb2hxaXdYb3h5cXpVaWJYMjhpdXVVNUl5cGhj?=
 =?utf-8?B?blhpUUoxbnFSQU9KZDlBMWxyM2ZRSktSMzZXYloyTWZZdTZCZEpkaXgrYUZL?=
 =?utf-8?B?alhLeWRvTjdFOTNWZ0cxbVU3bEFsMEE5bHNORnUwdHFScGd0YUQ5NnJrUkV3?=
 =?utf-8?B?U3A2WDg1TnYyc3Z0bng4ZmJFUjNkR0NMSUNPdkl4bzdjN3dzTjhudEZTQ1pD?=
 =?utf-8?B?STFmT2ZKTlFUYVlPS2R6SnFFdC9zQkJVcUFyRU16cmpZOWtrNmc5WFBUbzkz?=
 =?utf-8?B?MmdIalEzK0txd0ZFQ1NjZTJ4ZmpTTUZ0VjJwWDJaTzNBNm8yWXRKVHpFU2R1?=
 =?utf-8?B?NU5KakxOMnI5akhlb1B2MEhzbE9FWWRpaXYyYlkrd3RKRU1EQkx2bWl3dmZ4?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 646fe44c-98c6-4bfb-ff86-08dd0d8375e2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 19:00:42.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFe9cPHv50gKsybKqpGOQr2MdHoDlXw2RNOH9lLcKGi2URtdLYIKACsdLhgICs172mVAFJJk5YQsKBmY/n4Af71rDL224SibNif831ldS0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8090
X-OriginatorOrg: intel.com

Hi Babu,

On 11/22/24 3:36 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 11/21/2024 3:12 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 11/19/24 11:20 AM, Moger, Babu wrote:
>>> Hi Reinette,
>>>
>>> On 11/15/24 18:31, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>>> Provide the interface to display the number of free monitoring counters
>>>>> available for assignment in each doamin when mbm_cntr_assign is supported.
>>>>>
>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>> ---
>>>>> v9: New patch.
>>>>> ---
>>>>>   Documentation/arch/x86/resctrl.rst     |  4 ++++
>>>>>   arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>>>>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
>>>>>   3 files changed, 38 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>>> index 2f3a86278e84..2bc58d974934 100644
>>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>>> @@ -302,6 +302,10 @@ with the following files:
>>>>>       memory bandwidth tracking to a single memory bandwidth event per
>>>>>       monitoring group.
>>>>>   +"available_mbm_cntrs":
>>>>> +    The number of free monitoring counters available assignment in each domain
>>>>
>>>> "The number of free monitoring counters available assignment" -> "The number of monitoring
>>>> counters available for assignment"?
>>>>
>>>> (not taking into account how text may change after addressing Peter's feedback)
>>>
>>> How about this?
>>>
>>> "The number of monitoring counters available for assignment in each domain
>>> when the architecture supports mbm_cntr_assign mode. There are a total of
>>> "num_mbm_cntrs" counters are available for assignment. Counters can be
>>> assigned or unassigned individually in each domain. A counter is available
>>> for new assignment if it is unassigned in all domains."
>>
>> Please consider the context of this paragraph. It follows right after the description
>> of "num_mbm_cntrs" that states "Up to two counters can be assigned per monitoring group".
>> I think it is confusing to follow that with a paragraph that states "Counters can be
>> assigned or unassigned individually in each domain." I wonder if it may be helpful to
>> use a different term ... for example a counter is *assigned* to an event of a monitoring
>> group but this assignment may be to specified (not yet supported) or all (this work) domains while
>> it is only *programmed*/*activated* to specified domains. Of course, all of this documentation
>> needs to remain coherent if future work decides to indeed support per-domain assignment.
>>
> 
> Little bit lost here. Please help me.

I think this highlights the uncertainty this interface brings. How do you expect users
to use this interface? At this time I think this interface can create a lot of confusion.
For example, consider a hypothetical system with three domains and four counters that
has the following state per mbm_assign_control:

//0=tl;1=_;2=l #default group uses counters 0 and 1 to monitor total and local MBM
/m1/0=_;1=t;2=t #monitor group m1 uses counter 2, just for total MBM
/m2/0=l;1=_;2=l #monitor group m2 uses counter 3, just for local MBM
/m3/0=_;1=_;2=_

Since, in this system there are only four counters available, and
they have all been assigned, then there are no new counters available for
assignment.

If I understand correctly, available_mbm_cntrs will read:
0=1;1=3;2=1

How is a user to interpret the above numbers? It does not reflect
that no counter can be assigned to m3, instead it reflects which of the
already assigned counters still need to be activated on domains.
If, for example, a user is expected to use this file to know how
many counters can still be assigned, should it not reflect the actual
available counters. In the above scenario it will then be:
0=0;1=0;2=0

Of course, when doing the above the user may get impression that a counter
that has already been assigned, just not activated, is no longer available
for use.

 
> "available_mbm_cntrs":
> "The number of monitoring counters available for assignment in each domain when the architecture supports "mbm_cntr_assign" mode. There are a total of "num_mbm_cntrs" counters are available for assignment.
> A counter is assigned to an event within a monitoring group and is available for activation across all domains. Users have the flexibility to activate it selectively within specific domains."
> 

Once we understand how users are to use this file the documentation should be easier
to create.

Reinette


