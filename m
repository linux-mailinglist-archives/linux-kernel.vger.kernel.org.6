Return-Path: <linux-kernel+bounces-234247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4AD91C438
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29B61C22A01
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755E01CB316;
	Fri, 28 Jun 2024 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqlLT3g8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ADF1CCCA9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593702; cv=fail; b=JOMc81zRlrilMvw8Ip1GWG0DetCKsSC44+GA1dywNNBBbnr/8BsDHmcaP8XTWNni4XA9PYNFJRzQ74lvHs5LsGPkFl/s4d18tI2TzWRveXvkWqvcOqJs5txJDh9tjRfi1Wgw8ZGewSPdtfZdLTbK2WZH/GkOIT/VsjPISbfhdbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593702; c=relaxed/simple;
	bh=Uvvuy2qye3C+6Z03CfZ4sSQoyVzj/TPWrPJAyTcg2V4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tvpGLXmdXrnzoSIHGlk14MtmignCP3s3NMMlcnlsHw2DHsJtRP9laQxFmDKHJENptqgJCZ6VJL/0y9rzq0Ove2caYx2Etw0HimOmIuSIMcL7Sw/fffuqrhzA+grqxpspYKWm6cOWsRPzUvEuYuviJlvuW8OuWESrjyeMs9OYMc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqlLT3g8; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719593701; x=1751129701;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uvvuy2qye3C+6Z03CfZ4sSQoyVzj/TPWrPJAyTcg2V4=;
  b=TqlLT3g8M+FtqB07omg1yA3rcI+C07MXPeoDtkldruMEofB+fiN/cgKo
   cd3EYZQ29ub3bHJOgLDDrfsnk0rfgMjid8vcqBwNNEvFxkBiUlTgRonvz
   syuJ+UgFCj8k2FARH/DltWMi90fLUcgR1X7C6+99Ae5ACifNPzEDDBRcR
   A5r6yQZ2HX1C2KqKiyy8AZSsTywmmEkIqR+pfBxXXbcwIqqEvEt3Nsoro
   3zMKtiZ11B7tj4Ke6VF0xQIDhyRjZJrZA7OOE/qLhxHjHMeii+ue8H9Eb
   oV06J8LYo4NvuqXU4kM+QLCwwrwLg7OYzXlEv70SGwxN5fR2dN8LpuXAz
   g==;
X-CSE-ConnectionGUID: Dt1Os6GSTROEiq++AMbs6w==
X-CSE-MsgGUID: uU6ggKMhQheJUS2EFALGyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16621214"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16621214"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:55:00 -0700
X-CSE-ConnectionGUID: BENXd9MCSPyLeueKcAp42Q==
X-CSE-MsgGUID: ZQVoIF0fT66htn1dcx9i4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="75522432"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 09:55:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:54:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 09:54:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 09:54:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DG66TvRnSm/9pPNmTsxPo6JwoulfjgekfGvmtB8h8j9ITt3oJiw3AFTe0SV3D7aFqfhGyQe8YpHGHw3mv5UdnUGTPhtQYXp24wCqTSswMRihayprKpFOwDDHFY7oCOphcnK/pOln7kxWbKNM8j2YDUfrdtxbAX0jVrZNpWTt4KlpsW5jqBebGJSFUmRZkUWlxfptWVHN0K6d73dofVfZpWOoYXdLIIZ3+83CP6G+Ucfvsz8KD9hXsLAr1L00N0MCPXQByzUn32IWrLlVXkT+00rMqLjpLHtUBVRyJBrV6pKl3VIli6HTUAXKnQMCqKr6OLIcEu5jm7hXjQHQM8qvfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjTnQMhK0A09bXDzp4nywe/OCO4qjEIR3EWvu8hVbhQ=;
 b=kTlmznfVux5ISOIQuEShkwA2VxsXSxvqWgCke36coQ5aBm5akVi+kI+uIaZ/QrMhoujYqccBBYCiWHl7rSOD8Q9fq02NBTTPxnsFRZUKBQmFaLJd1uFftTRmN1VLQjHlt5VThD30GUT0Auyogf/t3Gg2DAn68ft5VCtK0+aNUdnhY+2WRZKwqXqtuRMTm2t+DXY/UnsXALoqZMM0W2Ou+N+xdL/Vsx5FZhfngZOWqOpIKG2vQeW6ta4T3M6Jk8VenIE+BdjXJOndTNjXuk/bV/cn86ENiJ+rmlQPNENg4Z8kUxJu9Km5xJ2kbXi0h9e7jMefEus5B5XvJuSaZwoKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB7543.namprd11.prod.outlook.com (2603:10b6:510:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 16:54:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 16:54:51 +0000
Message-ID: <d7aa590e-7ad5-4eaa-9ea0-94322b802dd5@intel.com>
Date: Fri, 28 Jun 2024 09:54:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 36/38] fs/resctrl: Add boiler plate for external
 resctrl code
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-37-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240614150033.10454-37-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0340.namprd04.prod.outlook.com
 (2603:10b6:303:8a::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: a72a67a5-1a92-4e73-17df-08dc979306e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzFnVGlkV2Z3QTd4THZzT3RPRzVvWHIvdXJWNCs5RGErWmN4NnRIc3M0U0lu?=
 =?utf-8?B?TFpFTncyREJtUE40RUtlYkJhd0hTSEVZVU8raDVuK3hMUHBZRnM4THNiNHVW?=
 =?utf-8?B?ZU9SMnMzcUtFSTU3UExQbTFCWGZKUDFieXBTNmw4U3FXa0hMTmJidzR0M2Jl?=
 =?utf-8?B?WGxrODA4Tzk5RWREaTV2OHlKMTJtOUd0azFlVGx5TXJybDZ6bSt6RlF4aXRF?=
 =?utf-8?B?Y0dpeVlpSUZWWXdjYmp6d0lvMWZYMkxEeCtYOGNFcTU3ZlJJUG9YRTYwdTB4?=
 =?utf-8?B?dTkyK0dJcmJsQ2xHK3FZSGVoOW5wcEtVTWh0NDhXWFNwdHI1aFRxUGZSS3J0?=
 =?utf-8?B?MldleFcyYzdhVnlia1Z6RXl6NHYzTXM1R1BFd3VYZjJCTmt4ODFyNzBpaExE?=
 =?utf-8?B?OXlXWC82VjFUT1d2UTRxYkVOd1NoU2xwRjFFWWxxeGtJY3RvWTJENHgrNmZr?=
 =?utf-8?B?WVNzUWh6bkR2UjZCQ1Y1b2s0U1hqQWhJMTNRckFSL3pQcVlVK3RzWjRYdUhu?=
 =?utf-8?B?ZWl4ajVHem5zVWhiZ0s5dHBnTnk2ekNYUXlDNlptZXphTmVzaXBZTVdITmRn?=
 =?utf-8?B?bEwxVEFwZFBqUi9xck5rcW5hOFBSS0NLTnFzTFdqbjdjbUxEbkZnU3NUMTJ6?=
 =?utf-8?B?NTRDdWU3Ymt2bU5EZ1NVOExiZWdic295TEtSVEREZ0pTZmxxclpRRnZsT0tx?=
 =?utf-8?B?dWphb2s5d256RS9xUmFKMFlyc3hhR2VWUGpFbmRYOXowMExJaFFpNnNLNkho?=
 =?utf-8?B?Q0FOWnVHSlNiOTVOdGVTYU9wYlpwZGgxZHR5NDl6d01HWjdFL2lWZUJ6dllI?=
 =?utf-8?B?c3lkRU40dVBsdDFFdmZDeG5pa09ScG1kbjBJdmVybE1raDl0MnFvUGd4aHhL?=
 =?utf-8?B?RGVHN2daenZRWmFEY0lLaW9EM2VrLzd6SG95VHhwUTk1bENtUkNMaDZxWkRu?=
 =?utf-8?B?Q3ZZSXRiZlJDeGJsZ242OWdMVmFZTU5UQ3NwMUo4V3Vnd3EyZEZuNldQVDNs?=
 =?utf-8?B?YkI5N0RFUlhadDhPTU9aNEN1eHFxa0JBV0phSzhUTGhwK1Brb29nNGIyZG8r?=
 =?utf-8?B?MHBXMEt3OCtuQXhVUVlwb0NlY3VjTmNueU9YY0JUaFk2cGVaU3hYZmpsWmda?=
 =?utf-8?B?N2ppOTNQa3dmbkJLVUQvYkYyRGQ4RGUzdVVWb2VpMHNyMGtkN1MrcXRzaXVZ?=
 =?utf-8?B?QzZITlVjdURPcTdvWituZFBQOGVwUmZTd1pIVjY3R2tEaWFQclFialBKV1JJ?=
 =?utf-8?B?c1IraXlRYTBwSWl6aVFwcXhuc2xncFBGbEpIUTZQM1FteWtVWEdOeEZCbVYr?=
 =?utf-8?B?c2pPWGFIL0gxd1Ayckd2WE8wdU11Q1gvcTZSdHlaUW9Sa1hJS2lycmgrUlV6?=
 =?utf-8?B?b0t6eER2SXJrT2ZSNEYvbFpkcmJqUVl0VGhYWXR3Z01XZ1RRd1E0SDVrYksr?=
 =?utf-8?B?Tk9zeDdPZVQyU2JtL3RVNGErZk1QaDFVQTM1czNUT1UzSm4wWThLRDFLQVVx?=
 =?utf-8?B?RHpGejFZT3g3MysrTHJmSWJxUWlTVmFiNFc3N1duN3NlMUN3SytzbkFRQ0pM?=
 =?utf-8?B?OW5QTzhsZkNobkE1bEVmQnF2TFN1azc1ZTZnMTZRTllYT0hPMUNnNUNpeVRi?=
 =?utf-8?B?MENtaThsdnh5aElmWG4zME9Xdlh4eVRpQjdWZEwzMmNBalpPdmMxZGkzZHY4?=
 =?utf-8?B?SExSMnFwcmFoVzVrT2p5bStnWjcvTkNrbkhZZG8xMVlCQnR1ZndIU096czRZ?=
 =?utf-8?B?VldmcXU5NnNML016SW1XYVdlaUpXY3I1RHRGeWZDN3lpMHl3SkRxa3ZHVlRn?=
 =?utf-8?B?WWJVUHNkRW9lVVRRTUVmZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWNERTNXdjhKWVU4WlZ2UHgyT0VTakF3enEweEhWWnlMWUE1MlJGTDNuY2wr?=
 =?utf-8?B?a1NBem00NS9BZG9hNDJ2a2hJS2x6dzUzL1hraysxelRmdUc5QWJ5Zm1NdHhk?=
 =?utf-8?B?di85RU1zVkdvQTRqTWM3WURyQlJGUVhHQWdJa2hlSzZIREZOYUxDZ3M1YjhU?=
 =?utf-8?B?cS85bk80M2wrTDRZaytyQnFXQUJOc21Ed3RIbXQwbWwvUUdPVEU2Z2dRL3U3?=
 =?utf-8?B?cDdXU2dwelhPRDlGcHRVbnNpaWhKK3BqTzlldGU3UkdnalJUSDlydWFYZHVE?=
 =?utf-8?B?Wlk1Unh1R0I0TmplOVF0NzZkbkNNdmM3ZzBlSjdOdk5KTmhvMkxLVm5rbDh1?=
 =?utf-8?B?bFJvY05Ld1pwZ3Z1NHB0YUE4NlI2SVRkenpWMUdzVFRHRkJ2VUR5VzM3cTRU?=
 =?utf-8?B?NlVSYjJsQkkrVzZ6TTExcHBqb2taWUNkcU1pdWdhLzRZdGVlTFU5aDExU2kw?=
 =?utf-8?B?R2Q3M2hGMVljSDNoMlk0VFhaNlpDZzY4WlJyRlJOUDc3RmZRU09CV2pIbEVr?=
 =?utf-8?B?ZTVoRS82djF1TVFDNjR5OFR4TnFLN3oybWtmVHY5Y3NxUDNHT2RKayt6Rmd0?=
 =?utf-8?B?ZjZOOHlMS2l3T0VNNVl2VW5UajB4eHBPSlFiYmpJUkhtUVZCSERpOXNoUENn?=
 =?utf-8?B?YzNhNGVLczJUZDVJTXBvSVlGYVc2RVZNTWd4THBZdUZmTDZvbjM4bERNOFU4?=
 =?utf-8?B?cXJlMVQwZjB4b3dlZFVVcXg4UHcyUm5MNUIzZHd6b1hTQ3ZMQnF6ekJpWTd6?=
 =?utf-8?B?bGxJY0JPUGVYNkk1dHJCYnZabEp5Yjh3a0w0dEtWUXI2bjhPc2Z3R2hHcWpD?=
 =?utf-8?B?ZWZ4WHVXeU0yTitnZDcxSXZpMWlESFVaNmxpOXBtYjhscVY5eEYrYmtGaUtx?=
 =?utf-8?B?b2Z0R3QrSE1Eb05CWHpMSm5yWURVSWRtSWxpV1FJQzA4SjhTVUgzcTVaRlJK?=
 =?utf-8?B?NXU5QXZwaVp2MXVjNU83bWEvcGx5NDZiVFc3YVFjQVo1RW9mUEJEemN0WkNv?=
 =?utf-8?B?ZllZelJVK01wSVRZbDZxc0NpK3FFdWJRaWdyVlRsbDlNcHpoaE5lMTkyNTNG?=
 =?utf-8?B?eVJPaVhqSUZuNGVtbHRDTW5qVDJyd0F3T2JNS0ViOStTa2EyMXI5a3lRejlF?=
 =?utf-8?B?TFEwK0VqYWU5Z0pZREFGcFAyR2pQNFRCVW43dklNRVdXZGpuTFNETTdzVlBi?=
 =?utf-8?B?NXYvTDlyTkxVOXJTN2tncThOQUJxQXk1ZzZoeDJ3YThWdk5pdHpLSzBna1U5?=
 =?utf-8?B?anRXa0FHRFZPVjJ0Q1FaN1l6bGI1Q3ZFTlJ3MlkxN1dLUlZBMlVRcXlQalcy?=
 =?utf-8?B?d3hSN1VRVXVHTzJ6TFdkMm16ODR2blYzbXlRUUNrcFk4TmhsMjZmaHBXNFZE?=
 =?utf-8?B?bjNwc0VVZ050U1VYWDhKU1hMcHBkNnJiYXZsS05oaHVrWlVldVNRM1BNUk9C?=
 =?utf-8?B?elVPa2pXcldmMjVXNDRYUUNsZ0JaenVNY3ZaUkRwaHdWZzdtZUZ1QXJ5bHps?=
 =?utf-8?B?emtFelZhOGIyM1FnZmppbW5HaHE2VXVxMjkwTXR5dE9IYXVnbmhYcjZGTXVh?=
 =?utf-8?B?UE43dXdlVk1TTGxsVENsNEtycE9mZllOUVZkNGZBaTdESlBUSHVod0k0THpT?=
 =?utf-8?B?dGhteTVFSU12cDdUaHRmL3crSWdVNmZUQnRPd2Jsbmd4U29TSkllTzJFdGkx?=
 =?utf-8?B?dnFGemYyZ0RxMnlUWDVJNnIybzBYZ29xenN5YXdaeDRkOWY5WmZMWms0b0pH?=
 =?utf-8?B?ZU5CTTNLcnFna2Zlc3FRWDF1bHhid0RMODFxWXpaNEM1SzN6N0l0c29xSHBC?=
 =?utf-8?B?ci9vN01rczdEdXlsRENHZ2ZlYW1qNUZIS2FvNDhBRzFlQ2h0MkVpeXUxVVAv?=
 =?utf-8?B?ajdpRTAzVStMbVFWbU02TUVHZFMrSStOb04vTGNDUFRoeXA2b3g2MDhSTzdF?=
 =?utf-8?B?czlkK281N1YxSFRpWUlacFlDSWVKWW1qOFV6OXl5K0MyRGRQbjBLTWxNRXc3?=
 =?utf-8?B?MXRkbS9vVi9PV0kxYnNsd2d1NkFyMFc4bm16YzAvYXV6djJieXUrOWdvekJy?=
 =?utf-8?B?dGs3QXNwNy9razI4eGM5TWJQSVQ1cjVGemV2aUdYR256ZTRtY0dpKzhSbksw?=
 =?utf-8?B?M1hOOW94amVkaWp6aEVvL1pRTmw2S2tOc1dHcVRUbHBCTWU4UjNCbUU2ZFY5?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a72a67a5-1a92-4e73-17df-08dc979306e0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:54:51.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMykGi6Mqrd40INIRYaBbJGqWcdFNNyplDITsYc0+UorMZnd8idzrYt+bkct+tykiE/jM9DpkvOD9Y4MKyfFpZf4zFi4bE/XSPa69lrouck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7543
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 8:00 AM, James Morse wrote:
> Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
> for the common parts of the resctrl interface and make X86_CPU_RESCTRL
> depend on this.
> 
> Adding an include of asm/resctrl.h to linux/resctrl.h allows some
> of the files to switch over to using this header instead.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Changes since v2:
>   * Dropped KERNFS dependency from arch side Kconfig.
>   * Added empty trace.h file.
>   * Merged asm->linux includes from Dave's patch to decouple those
>     patches from this series.
> 
> Changes since v1:
>   * Rename new file psuedo_lock.c to pseudo_lock.c, to match the name
>     of the original file (and to be less surprising).
> 
>   * [Whitespace only] Under RESCTRL_FS in fs/resctrl/Kconfig, delete
>     alignment space in orphaned select ... if (which has nothing to line
>     up with any more).
> 
>   * [Whitespace only] Reflow and re-tab Kconfig additions.
> ---
>   MAINTAINERS                               |  1 +
>   arch/Kconfig                              |  8 +++++
>   arch/x86/Kconfig                          |  5 ++--
>   arch/x86/kernel/cpu/resctrl/internal.h    |  3 +-
>   arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
>   fs/Kconfig                                |  1 +
>   fs/Makefile                               |  1 +
>   fs/resctrl/Kconfig                        | 36 +++++++++++++++++++++++
>   fs/resctrl/Makefile                       |  3 ++
>   fs/resctrl/ctrlmondata.c                  |  0
>   fs/resctrl/internal.h                     |  0
>   fs/resctrl/monitor.c                      |  0
>   fs/resctrl/pseudo_lock.c                  |  0
>   fs/resctrl/rdtgroup.c                     |  0
>   fs/resctrl/trace.h                        |  0
>   include/linux/resctrl.h                   |  4 +++
>   18 files changed, 61 insertions(+), 7 deletions(-)
>   create mode 100644 fs/resctrl/Kconfig
>   create mode 100644 fs/resctrl/Makefile
>   create mode 100644 fs/resctrl/ctrlmondata.c
>   create mode 100644 fs/resctrl/internal.h
>   create mode 100644 fs/resctrl/monitor.c
>   create mode 100644 fs/resctrl/pseudo_lock.c
>   create mode 100644 fs/resctrl/rdtgroup.c
>   create mode 100644 fs/resctrl/trace.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 441b039068d8..64195c298baf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18859,6 +18859,7 @@ S:	Supported
>   F:	Documentation/arch/x86/resctrl*
>   F:	arch/x86/include/asm/resctrl.h
>   F:	arch/x86/kernel/cpu/resctrl/
> +F:	fs/resctrl/
>   F:	include/linux/resctrl*.h
>   F:	tools/testing/selftests/resctrl/
>   
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 975dd22a2dbd..4156604dd926 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1431,6 +1431,14 @@ config STRICT_MODULE_RWX
>   config ARCH_HAS_PHYS_TO_DMA
>   	bool
>   
> +config ARCH_HAS_CPU_RESCTRL
> +	bool
> +	help
> +	  An architecture selects this option to indicate that the necessary
> +	  hooks are provided to support the common memory system usage
> +	  monitoring and control interfaces provided by the 'resctrl'
> +	  filesystem (see RESCTRL_FS).
> +
>   config HAVE_ARCH_COMPILER_H
>   	bool
>   	help
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 446984277b45..e4dd4097e10f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -490,8 +490,9 @@ config X86_MPPARSE
>   config X86_CPU_RESCTRL
>   	bool "x86 CPU resource control support"
>   	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
> -	select KERNFS
> -	select PROC_CPU_RESCTRL		if PROC_FS
> +	depends on MISC_FILESYSTEMS
> +	select ARCH_HAS_CPU_RESCTRL
> +	select RESCTRL_FS
>   	select RESCTRL_FS_PSEUDO_LOCK
>   	help
>   	  Enable x86 CPU resource control support.
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index bad103f20663..6f6785a31efe 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -7,10 +7,9 @@
>   #include <linux/kernfs.h>
>   #include <linux/fs_context.h>
>   #include <linux/jump_label.h>
> +#include <linux/resctrl.h>
>   #include <linux/tick.h>
>   
> -#include <asm/resctrl.h>
> -
>   #define L3_QOS_CDP_ENABLE		0x01ULL
>   
>   #define L2_QOS_CDP_ENABLE		0x01ULL
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 145bd05eafa5..a1539edb25fa 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -17,11 +17,11 @@
>   
>   #include <linux/cpu.h>
>   #include <linux/module.h>
> +#include <linux/resctrl.h>
>   #include <linux/sizes.h>
>   #include <linux/slab.h>
>   
>   #include <asm/cpu_device_id.h>
> -#include <asm/resctrl.h>
>   
>   #include "internal.h"
>   #include "trace.h"
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index c096fa106b80..97e901009c91 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -19,12 +19,12 @@
>   #include <linux/mman.h>
>   #include <linux/perf_event.h>
>   #include <linux/pm_qos.h>
> +#include <linux/resctrl.h>
>   #include <linux/slab.h>
>   #include <linux/uaccess.h>
>   
>   #include <asm/cacheflush.h>
>   #include <asm/cpu_device_id.h>
> -#include <asm/resctrl.h>
>   #include <asm/perf_event.h>
>   
>   #include "../../events/perf_event.h" /* For X86_CONFIG() */
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 969c454b67f1..c7cbd30ac0f2 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -19,6 +19,7 @@
>   #include <linux/fs_parser.h>
>   #include <linux/sysfs.h>
>   #include <linux/kernfs.h>
> +#include <linux/resctrl.h>
>   #include <linux/seq_buf.h>
>   #include <linux/seq_file.h>
>   #include <linux/sched/signal.h>
> @@ -29,7 +30,6 @@
>   
>   #include <uapi/linux/magic.h>
>   
> -#include <asm/resctrl.h>
>   #include "internal.h"
>   
>   DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
> diff --git a/fs/Kconfig b/fs/Kconfig
> index a46b0cbc4d8f..d8a36383b6dc 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -331,6 +331,7 @@ source "fs/omfs/Kconfig"
>   source "fs/hpfs/Kconfig"
>   source "fs/qnx4/Kconfig"
>   source "fs/qnx6/Kconfig"
> +source "fs/resctrl/Kconfig"
>   source "fs/romfs/Kconfig"
>   source "fs/pstore/Kconfig"
>   source "fs/sysv/Kconfig"
> diff --git a/fs/Makefile b/fs/Makefile
> index 6ecc9b0a53f2..da6e2d028722 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
>   obj-$(CONFIG_EROFS_FS)		+= erofs/
>   obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
>   obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
> +obj-$(CONFIG_RESCTRL_FS)	+= resctrl/
> diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
> new file mode 100644
> index 000000000000..a5fbda54d32f
> --- /dev/null
> +++ b/fs/resctrl/Kconfig
> @@ -0,0 +1,36 @@
> +config RESCTRL_FS
> +	bool "CPU Resource Control Filesystem (resctrl)"
> +	depends on ARCH_HAS_CPU_RESCTRL
> +	select KERNFS
> +	select PROC_CPU_RESCTRL if PROC_FS
> +	help
> +	  Some architectures provide hardware facilities to group tasks and
> +	  monitor and control their usage of memory system resources such as
> +	  caches and memory bandwidth.  Examples of such facilities include
> +	  Intel's Resource Director Technology (Intel(R) RDT) and AMD's
> +	  Platform Quality of Service (AMD QoS).
> +
> +	  If your system has the necessary support and you want to be able to
> +	  assign tasks to groups and manipulate the associated resource
> +	  monitors and controls from userspace, say Y here to get a mountable
> +	  'resctrl' filesystem that lets you do just that.
> +
> +	  If nothing mounts or prods the 'resctrl' filesystem, resource
> +	  controls and monitors are left in a quiescent, permissive state.
> +
> +	  If unsure, it is safe to say N.
> +

Will user ever get opportunity to say "Y" or "N"? It looks to me that
RESCTRL_FS will be "forced" on user as it is selected by the arch specific
config X86_CPU_RESCTRL and be invisble otherwise because of the dependency
on ARCH_HAS_CPU_RESCTRL. The text about when to select "Y" or "N" thus does
not look practical to me and it may be helpful to instead provide
information about when it is selected? I do not know the customs for this
text and if it is intended to document any future usages also.


Reinette

