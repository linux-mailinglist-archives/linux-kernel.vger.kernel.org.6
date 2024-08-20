Return-Path: <linux-kernel+bounces-294454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F9958DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EAFAB21D97
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C71BD507;
	Tue, 20 Aug 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoxwy/Rz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694A91B9B32;
	Tue, 20 Aug 2024 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724177517; cv=fail; b=VweXiWd9Zh6qk4vvxuLY9wkLvaK/B5Q9OUVR5meCN+AfsyStEoJZwYG4JipK7nlmtbOE64vQEvytgvcjEwmJRk/HuPz14JOWCQJzf620qssr+LlOn606TX1f2saAdm00GV2m8Hw4Y0IablWOvfUywWoi2R8Qv5GaKpMcT2pICOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724177517; c=relaxed/simple;
	bh=zHxdFcH+ho6hkHzexDbGO92pQmhKcudVFe6ucEMTwDQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GYFhaHFfauXh4KmWxNikAcQ2KyxvT646W6jVjzr5u5hTl5g0rBDAoS3tLzmxy+3a9RqDJiu8HhbK+xdwm30NdsJF381VW34SQIVqv19r5lKRm/Wj0Qu+jyoKL2crf6N8NO8AqbpyR02Yrvb0HoCFuuQ93dfofRRG2qL4ZCdHako=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoxwy/Rz; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724177515; x=1755713515;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zHxdFcH+ho6hkHzexDbGO92pQmhKcudVFe6ucEMTwDQ=;
  b=hoxwy/RzQsX0oFYwSH4FYFJ8x/XPm83iVokC7zIwObAfkCCOVr/OK0Oj
   x03Q5gL141zwEGpnpc+WvsaJnCpRhCQM+B6bvsRxiCiFhpRoxZi4qbhWC
   lQmm2SGfyCDhC+DbUBS/DCp608XLhn8eLfbW0Do2IXLcQUBGxwuKS06tM
   S97vS74TeGBwZ18PEKR3ThHXHYFSnNX1q/RDiuHmieqzMOq4UOgjwbs2s
   8iieW9wMyrInY8EEiYvqfbIWmJxZH7iRHG02+sn+Jx42cetmKO+xioq9B
   JQPv/s0XyVC86q72wf/XKvT35AnUGQufi2mk1oq2+H3kH6HPhHuqKRPto
   A==;
X-CSE-ConnectionGUID: ApUyorX/QZ2ozlOkjjFFFg==
X-CSE-MsgGUID: CjW3qglBTkem3eHf/JZPqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22633614"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22633614"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 11:11:54 -0700
X-CSE-ConnectionGUID: moyHpp8DSNq6cVomQ9tAHA==
X-CSE-MsgGUID: YrhMl+ERTX+aCAOLh246tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60667867"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 11:11:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 11:11:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 11:11:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 11:11:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 11:11:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYOCC6K5dksZtRz/1C9HEyUBaNd/fvoNX3trM8cfAVy0adieTHa8IJ66L1/k20qHkwGmX6mLrzR2PQEi7FO+YlXokBluLEV1oixGEpCIcLNy2zgxa6HtkNu/La2krF7F5W5Ird4BUMin763UkGBvYor6YiYCgTCvwc0MwmHjLSRtw64PifevgJtlmoo4GNKTw8UIHIV6i0i1zf4Z4g6rjENf0U8U34slv8dU5kvKZxu7w02UAYv5EfdHc12HQOS9kclzH1dOpMpkExeET+KpDtQs2EZsU66AxCBnHRKZMslbuO7kKD83FRoLZeeqGp5MJjwaSx2hlXppAEaCEr6lPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKQ7Ct30c0fYCCwGwD4SVtVmN0smaR33v0KxAQUyX4s=;
 b=vrKtpunTN2F8TQ/gValLNuRuVMP7oGkcXVc5DTdTxz97ywPOi96EqbEPmK4fWRap6fVmWc/1dMCl8Bxuz1sxqZAXdvsTeS3T56AW6l1ldLo/DmOsbvNVHMVjeeYXf6RWXtYuy3gyhhAFpFYn7P+3z/gFCsf7UwjHXyglFQyapJUcC7c5bY9HpQH/nJSjExyoekac341lhMEXxDi/p9XLl374wFG8brKLmGLUsum2mGEfJYet5YxVmVx0N+uYFabZLZHn2v27AMgaLTIof1vNHYNpkEzKvkBdGBrVmimIZNhFabRK99uWD/zQjRzF38WvCsLw6txih8BBQJ2vjj+Mcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 18:11:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 18:11:48 +0000
Message-ID: <c6d59533-c15a-48cc-8712-222540b13d74@intel.com>
Date: Tue, 20 Aug 2024 11:11:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/22] x86/resctrl: Introduce the interface to switch
 between monitor modes
To: Peter Newman <peternewman@google.com>
CC: James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>, <mingo@redhat.com>,
	<bp@alien8.de>, <corbet@lwn.net>, <dave.hansen@linux.intel.com>,
	<fenghua.yu@intel.com>, <tglx@linutronix.de>
References: <cover.1722981659.git.babu.moger@amd.com>
 <784eaa900b9e0778ddc534c04c7ded9466bfd19b.1722981659.git.babu.moger@amd.com>
 <983fded5-48f8-439d-8afe-45b60841985a@arm.com>
 <8c93c091-39b3-4219-b892-9df2747eb91a@intel.com>
 <CALPaoCjmRyP00b9rTCjpxwLDJ2rYkQ8HuNMYJA+qVNo5a4Q9JQ@mail.gmail.com>
 <56aae68f-b590-42ec-a6b5-de3af97a8091@intel.com>
 <96880c73-7f0b-4a62-8f9f-11042dec92c7@intel.com>
 <CALPaoCieONpok0ZXyBbWxzFwTT3mq4vPoUuaRsE7_Ad8CY-1AA@mail.gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCieONpok0ZXyBbWxzFwTT3mq4vPoUuaRsE7_Ad8CY-1AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0308.namprd04.prod.outlook.com
 (2603:10b6:303:82::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce8e8aa-bda0-44f1-a6b2-08dcc1438e98
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXdFcE00Mm14Sy8randha1pzcE91Y0lPenJOa2F6ekgzZi9aQ1Rta3FpWFI1?=
 =?utf-8?B?MGhMekc4YlJRdUlITWFWWDNnUGJMbVhnYkZqZDYwUTZQRE4rMUt1dGFtYisx?=
 =?utf-8?B?d1BzTUlUUStRaXl4MWpnK0FyWXpWbkZGUGVrRzVBU1Rrd3VUV2M2KzVCOTZK?=
 =?utf-8?B?VlZSbmNWVVlEUzE5OVFwdExEaitIQ2lqTVBCQjZQMGZJRVVDNjdTV2dzTXN0?=
 =?utf-8?B?WFJFUjRReHEyTFAyYXg1WWhCQ29kNGdtbU14aUVCL21JdWlpZENWUTV0UlZ6?=
 =?utf-8?B?bURLbzFxdkkwUy9HaTJyWXBMVC9SblYzeFl5R3RMRk80N0FYd0lmY21ZNFY2?=
 =?utf-8?B?UGpDdGIrdVEzTmhPbHpxdDdhdWFZa0MvejE0aUdUQ1hMVmExT1JmUXBjSFBJ?=
 =?utf-8?B?N2liWFc5ZEUrb3FlQkwyMXlSNnltSCttVk4yQlFjOGR4dCtoWTRuRVNPUVVM?=
 =?utf-8?B?RUJrb2tCNmRKeVZIdU5DN0lwZjNFSXBHS25LK01zMHNDZ3U1NTkwRWxRVXRI?=
 =?utf-8?B?K0VUeEowZ3NGNSt3WVd0S1hTMmwwb3J5dnRMVzREaDlzNzdUb2dUdTcxQlU4?=
 =?utf-8?B?ZUtpeXA5R2dJTjhtWHNaUTZpUGxPVUIwL2MvRGoyYnBxRkV3R1JFRVk1QzBP?=
 =?utf-8?B?Q3k1MzFVUlltUkdodWVSTHhCWGw5bjNNTUM0QXRaSTNnZUpLQjRmOFlCOTFR?=
 =?utf-8?B?aWNJOHp3TGkrOGdJZFFuTDFFcGQ3dWxmR0lLbVkreVRuNEU2cmw1QU41VkFy?=
 =?utf-8?B?dHpLa2dEQUJidEVreGRIbjVZcnVNdEYveHk0QnhyUEx0Y2duVzdRd1h4Rk5J?=
 =?utf-8?B?MlN2VXgyekppY1Q5Y3hFdXdDelR0bmdhZFVTcnd1bUpUcHN6L0lQcUhITmJ4?=
 =?utf-8?B?ZHpYUlB4K0VwS250WUF3QS8zT0VjZTdNV3dUazFUcmdFVUQ5TklNd2N0NVo3?=
 =?utf-8?B?aEl6dGVITVlwT042WGdWYmRLZzV0TCtHdHNSc3lRTGNtbmxPNFZ6RjNpRmQ2?=
 =?utf-8?B?RFlldDByNTlUU2toNEVKUlNpVDBma08xY1hNZk1OM2luRVE3YWxrUlpsZHp4?=
 =?utf-8?B?TnovaG5zazdTSEMxNENQemFBaHFpdlZjbVhlV1dsdThxVWl6MlBnRGFhR2pY?=
 =?utf-8?B?bWthNEJ1WWVOLzBVYktFOHRPYy9kNE9CQ3B1Z1NGWmlOWWFIVHAwOWJzTVZE?=
 =?utf-8?B?dUFtRlRESXNteFB1VWFZRHlRbXdyaE1MTjc2dmgxRlV2YmhRT1RTMGNxaFA0?=
 =?utf-8?B?NVNmdm1ybDlZNGoyR2cxeURUT0UraCtNeVVWVVBScjQyUzY2MkRmSVorYTdq?=
 =?utf-8?B?UUloYXQrVE9OYXZlTlhVUjFPWkQwenFBZ2hhMnlKVFlDeWpmSVdsMENkOUlU?=
 =?utf-8?B?N0VDSzZKb0VEaUJTOGNtZjZlcHM2bWxYWWZMeTdDSEQ2ekhMdEpWN1ZTY01r?=
 =?utf-8?B?RmJsOElYUlhFRDFZcnNmdUEyYzRtd3p6Uy95U0ZmKzlzdHgzYmZiTkFHVUU5?=
 =?utf-8?B?S2czZlBQcXJGQ09kM3N4Tm5CZi9LbUVyTlNpV0RQMVVWckViR1IvYUZYNWdN?=
 =?utf-8?B?d2hWVjJXc21ld2hLemtlOW5VbkptdEcxUTdLZlJ0c3ZKZUNRRWpYNWdkNWVv?=
 =?utf-8?B?dkFqV1Z5bW1nZVVZTDBsMjgyOFh3QkMxT1huelJIc3NRWTBTRXBIZlRINHMx?=
 =?utf-8?B?MjFjYVhBT1JqWmU2MzBkYUwvWVI2T3NRWi8vdXVzNm1TMm80VWJZRTFCc2h2?=
 =?utf-8?B?RGk2U0hpV1dzemxJVkRCUzRiOGJzYlg5YzBWTURYWlV4NmxLRk5rWW1xMTBr?=
 =?utf-8?B?T1BDekM1OGc4K1JnMDMyUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0NtTmJjdzZhT2JOWitkSm4zZVBiajErLzN3R0ZnM3p0VkNiZHZKb3FVUjI0?=
 =?utf-8?B?VmZpK0NuNUZpK1JvbWkvNXZPcTd4TGN5K2VFdU93UDI5NkhMNG9adkdKTG9V?=
 =?utf-8?B?dUY0RzlmZ25kVHI0UGN4ZXY3cGQ3K3A4SnhtZ0hWSmM3Z1Z4d1FvSUtNd2hp?=
 =?utf-8?B?cDBzZVBDMlVDdWw3M2JmWU54Zzdmb215ekZ5dW5ldE8wclVhNmFCYS8wUEFP?=
 =?utf-8?B?a0NEWDJ4aFJwMGJoTnFGYTZ3aHF5Tnp0RjArL2FPWEdyYmlJQjdvMGpXUHlH?=
 =?utf-8?B?M1ROK0xmT1AwTlIraXFyTW9qUTlleHVPaE9kYWtBd1g0QUNxTjlsOVBzSUxK?=
 =?utf-8?B?QWFQSG9BbEpkbGdzTXJ1bmh6NGZDUHd5TGJLdmE1Kzc1dk0zV0xtSWpJenJ5?=
 =?utf-8?B?UGFONFdjZStyeTh1TCtvcU84Sk5ic204S2tiZGYrZklad1Yxc3ZsYTZoaURs?=
 =?utf-8?B?YUVuTjVWbHdKQTZUUXk4cGJ5UVlkOE5zb2hnVjZuOHd0eFFxSFZCbFNFUmFT?=
 =?utf-8?B?clAxQ1N4ak1vS1dQclhoNFowV3Jud01rcU1oWVZjeUh2R2k5OXdIZ3B2MThH?=
 =?utf-8?B?K0YzNDR1QmpWUHUyZnI3aXBRSkNPdnNwdDlZRXhJb0JXb0YwTUJ0VmRJTTdT?=
 =?utf-8?B?TWRPRUtBbDBBNDZ3V0w0MHdRUDRvMHBGZ25hTTA3MFpPaUxWcjlZT0MwMGFo?=
 =?utf-8?B?OUIvZm1LN09EY2JJQm9Qdzczc2xVUTF5UDBLbkJ4bHhlNStDcHBtQVoyRUU5?=
 =?utf-8?B?ZGJwakx2M0liY0Vub2pSRkhVeXpQdEw0dmtzN1ZOV2FUMHQ5bmszeVhwT2Ew?=
 =?utf-8?B?NC9HeEo5QnlwUkZuaGRPMm56V1JTcnVrZmFwTDc2TmsraHhmQ2hWdHFKZUg3?=
 =?utf-8?B?ZXdOcVE4N1NlSUdZM2trWlg5Q1BLY2svcVd5RU1mZE91cSs3Z1JEYVkzZkw2?=
 =?utf-8?B?M0lWWDFRbGhDS2Q1TGJnZUthckZlR1IrVzZCQ3ZXV3hVSm9Bazd2VXpaU3Vt?=
 =?utf-8?B?Y2V4V3p2c3UvZ3Y1YlYrcllOaDFiWithNHljRmpMeGpXWU03aDk0M3NJT0h6?=
 =?utf-8?B?dWRCc28vZkhtdXNTSE5PUVBxaXozcllIaURJbmk1VUhRWGZ0ckVSTXFVelky?=
 =?utf-8?B?VjR0eDRnck1ZOGV3ZTBFT0RBTkNYVE9OdXlTR0pWM1JRcUJTNXRadmhIZGlW?=
 =?utf-8?B?ekpiWkZ0em5oR0RQbFd1ZEFWN0dpRE1TMkUvUjF2enREQXNmQmhWd2orVlBw?=
 =?utf-8?B?MHZ0OVZrRG45ZjFGeFF5VzRZQUdlS1Zpc3JxeUo4UWovbmJ5QVJLQVFTeHNZ?=
 =?utf-8?B?UlZwTVlXMFFIUkxGQ1drU09oZFoxdmFpMHpoclVBOVBES0dtZUtObERVdVVJ?=
 =?utf-8?B?K2NTakxyWlR0K0dBREtLUUcvbFViTDNjaGRXZGM5dlBzV0dpQVZ3NzJPREdG?=
 =?utf-8?B?RDl6dmthKzhFazNIakF0ODI5R3h5aW9pc2toMURoTGc3V0tUT2lvSm0wdTJm?=
 =?utf-8?B?dXVHYm5mdEczTXhkQS9CWkpuV2F0cnQxamtGaWJ5UzNuSG1uZmt1RGk0L2c5?=
 =?utf-8?B?SVR3ZGxKWFdvYkMxUDhTNkVOd1RnLzA3Tk4zK3B6Ym1tbkhhRkVsRHBDank4?=
 =?utf-8?B?bFFrWjVlY1pmbjM3a2pPSEM5elVyeHA1eEw3WkZoMzhWN09mVzFLSWJ6MllI?=
 =?utf-8?B?NVVydkh0cnFOYWV5VTliaUx6d05YK2tMZnNubE4xQ0pNYkE0NFFxNkFad3dB?=
 =?utf-8?B?RHV3b2JaSllJRGNYNk9XMGQxQk9QL3dWTlpzdUNPYlBYc1lwTHF1V21YZEtE?=
 =?utf-8?B?VWMwRkFTWFQxVnlvV0g3a0g0THRNb1piUnVQb3N3aWNyb3NpNUZiM2tYaGMv?=
 =?utf-8?B?aXcyS2wyMzlEajMrajJzeWZDcVA3dytzOGppbVZiQ2ZTTVlKa3g3QmJrM2hk?=
 =?utf-8?B?bzNtME9xZnV3STlrTXJFTnhBT1pyZGxkZGZoYW1QNjJIZi9hMndrM1dqMFlq?=
 =?utf-8?B?L2xBVnp4RDFVaDBTVUY4RW84TXhuVnVPdXcvaUtuY21sSU5UQmJDV3BOdm50?=
 =?utf-8?B?ZHVHaXlBMFUyaTBmc3Z5SzU4eVdlSWpPKzM4eWU5aXlRNnhsbGFNOFpicmo4?=
 =?utf-8?B?am1SalJNQTdsdEFYTnMvQlZFdGNnMDMvZGFXKzYrODJUb0gxN2phd1ZDT2Fl?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce8e8aa-bda0-44f1-a6b2-08dcc1438e98
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 18:11:48.0165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ed5+pbgnKchv2ihG+Oc4G57PIJgp7IMeoxGkH2cK2sat52Q5P/9wJTyyMEaRQ6855ZgkTpte03E+Q8EUMKnXr9t2aKrutq91Uba8ypxhBQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8118
X-OriginatorOrg: intel.com

Hi Peter,

On 8/19/24 11:27 AM, Peter Newman wrote:
> On Mon, Aug 19, 2024 at 7:53 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 8/16/24 11:09 AM, Reinette Chatre wrote:
>>> On 8/16/24 10:16 AM, Peter Newman wrote:
>>>> On Fri, Aug 16, 2024 at 10:01 AM Reinette Chatre
>>>> <reinette.chatre@intel.com> wrote:
>>>>> On 8/16/24 9:31 AM, James Morse wrote:
>>>>>> On 06/08/2024 23:00, Babu Moger wrote:
>>>>>>> Introduce interface to switch between ABMC and legacy modes.
>>>>>>>
>>>>>>> By default ABMC is enabled on boot if the feature is available.
>>>>>>> Provide the interface to go back to legacy mode if required.
>>>>>>
>>>>>> I may have missed it on an earlier version ... why would anyone want the non-ABMC
>>>>>> behaviour on hardware that requires it: counters randomly reset and randomly return
>>>>>> 'Unavailable'... is that actually useful?
>>>>>>
>>>>>> You default this to on, so there isn't a backward compatibility argument here.
>>>>>>
>>>>>> It seems like being able to disable this is a source of complexity - is it needed?
>>>>>
>>>>> The ability to go back to legacy was added while looking ahead to support the next
>>>>> "assignable counter" feature that is software based ("soft-RMID" .. "soft-ABMC"?).
>>>>>
>>>>> This series adds support for ABMC on recent AMD hardware to address the issue described
>>>>> in cover letter. This issue also exists on earlier AMD hardware that does not have the ABMC
>>>>> feature and Peter is working on a software solution to address the issue on non-ABMC hardware.
>>>>> This software solution is expected to have the same interface as the hardware solution but
>>>>> earlier discussions revealed that it may introduce extra latency that users may only want to
>>>>> accept during periods of active monitoring. Thus the option to disable the counter assignment
>>>>> mode.
>>>>
>>>> Sorry again for the soft-RMID/soft-ABMC confusion[1], it was soft-RMID
>>>> that impacted context switch latency. Soft-ABMC does not require any
>>>> additional work at context switch.
>>>
>>> No problem. I did read [1] but I do not think I've seen soft-ABMC yet so
>>> my understanding of what it does is vague.
>>>
>>>> The only disadvantage to soft-ABMC I can think of is that it also
>>>> limits reading llc_occupancy event counts to "assigned" groups,
>>>> whereas without it, llc_occupancy works reliably on all RMIDs on AMD
>>>> hardware.
>>>
>>> hmmm ... keeping original llc_occupancy behavior does seem useful enough
>>> as motivation to keep the "legacy"/"default" mbm_assign_mode? It does sound
>>> to me as though soft-ABMC may not be as accurate when it comes to llc_occupancy.
>>> As I understand the hardware may tag entries in cache with RMID and that has a longer
>>> lifetime than the tasks that allocated that data into the cache. If soft-ABMC
>>> permanently associates an RMID with a local and total counter pair but that
>>> RMID is dynamically assigned to resctrl groups then a group may not always
>>> get the same RMID ... and thus its llc_occupancy data would be a combination of
>>> its cache allocations and all the cache allocations of resource groups that had
>>> that RMID before it. This may need significantly enhanced "limbo" handling?
>>
> 
> For the use case of soft-ABMC that I'm aware of, it would be better to
> disable llc_occupancy events and accept it as a limitation as we're
> not using this feature. I don't want to slow down the rate at which
> MBM counters could be reassigned. Over the course of a multiple-second
> bandwidth measurement window on a bandwidth-saturated host, a previous
> group's initial cache occupancy isn't significant enough to justify a
> limbo period, especially when padded out to 1 second.

This sounds fair. It also sounds like a motivation for user space to
be able to enable/disable soft-ABMC to be able to disable/enable
llc_occupancy.

> 
> I would feel differently if my users were more interested in
> llc_occupancy counts and it was possible for the LLC to immediately
> notify when the occupancy threshold for any of a set of groups has
> been crossed.
> 
>> To expand on this we may have to rework the interface if the counters can be
>> assigned to events other than MBM.
>>
>> James: could you please elaborate how you plan to use this feature and if this
>> interface works for the planned usage?
>>
>> Peter: considering the previous example [1] where soft-ABMC was using the "mbm_control"
>> interface I do not think it is ideal to only use the "t" and "l" flags while
>> llc_occupancy is also enabled/disabled via this interface. We should consider
>> (a) renaming the control file to indicate larger scope than MBM, (b) add flags
>> for llc_occupancy. What do you think? I believe this is in line with stated goal
>> from [1]: "I believe mbm_control should always accurately reflect which events
>> are being counted."
> 
> I should have said,  "I believe mbm_control should always accurately
> reflect which _MBM_ events are being counted."
> 
> In general, MBM requires maintaining cumulative, running counts, while
> llc_occupancy is only a snapshot of cache usage. This is why MBM
> results in contended resources (counters) which must be managed by the
> user. In the MPAM implementations I've seen so far, a small number
> (relative to the number of monitoring groups supported) of occupancy
> monitors is sufficient for a large number of groups, because it only
> limits the number of monitoring groups' occupancy counts which can be
> read in parallel and can be adequately managed within the MPAM driver
> without user interaction.

Thank you very much for keeping an eye on the MPAM requirements.

> 
> Because of this, broadening the scope of mbm_control to include
> occupancy would only serve to remind the user whether occupancy is
> supported, but would provide no new information beyond what's already
> provided by mon_features.

Thank you.

Reinette

