Return-Path: <linux-kernel+bounces-378866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E329AD677
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91D7B22181
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BCC1D2207;
	Wed, 23 Oct 2024 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l770rQC0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE615746E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718160; cv=fail; b=jcXapM6+Bf7ltex8jklJm902ka1dHScBpLcMiRut7iml0oGEkAj9E/H6ucrb9vQRUhyGKunow4Ol5NQf0/2LyRwC0oK8jwllHT761V3L+TqoqrMVq+wXO9HVptaIjA60KCZd93R0pSveiKfoqiz9/dj9Mcfw0E4QRxi8VR8EVN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718160; c=relaxed/simple;
	bh=t0A5XH0eg03oDPdEgeKdLoPMFE02Wv9FXE1PgwfptsI=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cIYGL519TUXuryZCQDTgNiAg1fZyKfysT6upwhq+nG1oppKCU7l/eegjWHdnS7TctNY6ER+MBJ1ldejA1jphZyyf6vqwrZgollc8Z3o1VSwtTFdnCa7BVjdnX8hg7NwgJWHhsrQOOkwjQX3qVELhH18DQJDMPHpUUctVwCvb6rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l770rQC0; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729718159; x=1761254159;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t0A5XH0eg03oDPdEgeKdLoPMFE02Wv9FXE1PgwfptsI=;
  b=l770rQC0Mdc3OaeuXkrGVIGJLkuS42PQ63D7zBoKn70E6MvRyD8MpbW2
   YiSWfdqkrgNWM3EkkMN0PLUlWx+P63kNfZqQ69kv7xoI0eldM6uc5SrZm
   OBWqDB07UwgFXssYOm+ImTeZJLY6QEpPGpYoC70t9XS0+kOkxVATY3Wsx
   ytdPXnHgzRRwgGxlNADaqVa2Ctc8Nn4NDLiUC//vBd5MZbAjoSbKSb2pb
   qtLrtKH8C/6iMFCDHIfytx11xgNUTCtHmgenksDiSbNaE67a4oVao2p4K
   il0GVLQDNJqbyb8TTAOqS6/otMDgHOyTvBrLcD+2qRtXPuYszY2nnOigV
   g==;
X-CSE-ConnectionGUID: 4Vs87xn6TaexplHiXo9fQw==
X-CSE-MsgGUID: Tbh/lXHgTnSg/ssNk/FTvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39875512"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39875512"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 14:15:58 -0700
X-CSE-ConnectionGUID: 6J/ZycEkRgmiNqsywRsZ2A==
X-CSE-MsgGUID: 3tYrH2nnRdC1iDTsf3tcDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80699182"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 14:15:57 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 14:15:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 14:15:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 14:15:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9HuGHGGgO6rx5y2pYPXMl40v04NJQXdSVJBjDJgOyhPagdRf8Y96+BA7FRtVsMGMp/AjGAzZJdSDrF8PffBBJ/YWxbKewkGWORAmAYesY3H5+fsRzBK0N5tAevrlS8JTje8ZhrZRl1/EDM+EZfoFmx1W0MG/lcaqohox7F+x1SLA6bR8/rFomcLSlOpS9tUw8tAla3SyIT6OExeizyuqQq2HW7u+xRFYTnC5bcNFScZMa0AYhZjNs23EVCXV300b09jY6LMYUcJO238f9lmOeCvsl6TF4N8PhwqYgmWcCfqNag1SofOkbWBhqbUc/94b13PS5dq60cH1eD8Z2g4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUW6pyEhUYHqAUQlhQC7je9JPr2r4+/z5vxj/48DcVs=;
 b=T7B+EIhvQHC5BIyD2unoB4kEs6jHcq5lfd2eDCr/dNRFKpgSgrS/EIDX7VrD4LNY4OJo4Dx8dUD280Cj4vi3t+RaBPdvEXdjMKfFHufqn422DjQs0aeUpz8UWD4ClvV817yAp+OTkZ25rvy/Ezwf6MSZ6eNDzdKH93y3AG2PL2MQiO258jjB/o4FPiChzWYfNDE/QCoRY9fC5b8y1sQNFgGjXH4z/BiTgPDQdMMSSBN55hHatRWniJde+8KJ6dA80EyMM+z1Sinxt6YC2Rc/Z4Mzq7WQlhnMxQPpgGnbEuYTJe91HyI2dfD0BS8G3Pb+Uy4CHCwWeONB/U5oouo7hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 21:15:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 21:15:42 +0000
Message-ID: <3780be3c-07d9-4c36-a1aa-eae505ce8cb0@intel.com>
Date: Wed, 23 Oct 2024 14:15:39 -0700
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v5 08/40] x86/resctrl: Generate default_ctrl instead of
 sharing it
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
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-9-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-9-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 575959fd-e03a-4d46-ed28-08dcf3a7da45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SytQYzVZSEZoZk5HVTBld2ppQjYzOE53MGRuNkdXYzUyRVBRVFp4Z3ozNkZs?=
 =?utf-8?B?Q2V4cWhQR2lnb0lZTXRTbW9DbzdnSVRVazhuSXJCN09qSjVTWDJOYzRSOURu?=
 =?utf-8?B?UkdPbTFyNVpFMXFrSXIxK2hhQlhVRG1BR3h5STNJckhxL2tkNG55ck1CQnRu?=
 =?utf-8?B?NDUxSk5BeFAyK2lXaTVzYkRGQ1dlbGVvY0NGMzB6cVhXMWJFTmdGKzJIVitt?=
 =?utf-8?B?MVdZai9iV1cxWnEwSSsyQU1FR0c2TzBhdVNnMmRYY0FLVUl1a2FRdGgvKzJC?=
 =?utf-8?B?ZjhGWXpXbU5WaG9IQ2tNWmlkR3hMdFpVL3BXUnB3THZRLzN3ZThmLyt5NjZo?=
 =?utf-8?B?cFVLSUZ5RnJVSks4VlFUenpPWUErUVlNUnJsQm5OTUFxNEwySENhZk5TdWJD?=
 =?utf-8?B?dUJjajFHSnFmUHBsQk4xb3lJQWhhSFFrOU1iMjdNUmNhRTdWQngybXpoaXB3?=
 =?utf-8?B?eXdVV2Z1Mm5YRjRGVGQzNjZpWkRjenBwSXdGVndscVRrdHpzanpzYnBuZStz?=
 =?utf-8?B?SExLeFlQano0MHVwR0FqME16bkNjaThQTTlYQzVTbnZZNmtiWTRqcTNyNm5o?=
 =?utf-8?B?R1RIR05KWmNIT3c5ZW9MbWxRdlArZnpEblNGa0ZjaUFjUWx6dWhNdlBPUHZk?=
 =?utf-8?B?eTNSOVNnelZnUWVPOFhucy90SmprWWQwSCt3S1RKVzdKdUoxK2EzVmVoLzlC?=
 =?utf-8?B?K2RVMmpodzV3TllPUE5CUEdadzBPYzhhT294NVVmYnZqNDBYR2U2VW1qdEV0?=
 =?utf-8?B?MnZxWXlTeXlrcVdpK0VaV1ByTFpiUmphcFBqSFZ1UzJ0L2daSE5KNG5DcFJP?=
 =?utf-8?B?V2dhMXhVRStXMU8rTThlbkNGZ0xpRkJaMlNJVWFkeHU3OWMvWVpMS3VGazRB?=
 =?utf-8?B?Zk1BZzNybmk2ckNLaDJ2VXp0em5UeG9PSHQxUkthNnZoTmNLY2N4Z1p5ejVR?=
 =?utf-8?B?M3lDQ0YxYmdZbTZ4ZmxHd2NwdzNyMDV6ZlkxQU4zSVErbm00L2xIaFRrNE5S?=
 =?utf-8?B?Z21vdytqLy9lT3F0aVA0K2hXSWdUczBCUklwQ3J3MG1GUnpaemw2MFpTYWdU?=
 =?utf-8?B?R0V4QjBFVWpDRFcycnFjR1hFaS9PckVqRWZXaHd3eVJpWk9zRW1aYVNJRy9s?=
 =?utf-8?B?SVhQRzloQWgrS0Niek43QmMwMUlNR0NGMTB1aTJ2WktmTE81endQckhmaGls?=
 =?utf-8?B?RFQ4aG1ncHBETkF4ZHFGTnU0UkNzWm50U3k2cDh5aWxhMzAycDNaS1FUT0xZ?=
 =?utf-8?B?dWNSVzYraVJ2R1MyL2k2NERRZlNnbXM4bjNNRi9wREVhRjNVUVpyQ0V0dVI5?=
 =?utf-8?B?RGtRbC9nc3ZxZkxWam1Ha1lESHowdTNQdi9aUVZ2aW4zc0tVNmZTNHlZdHJi?=
 =?utf-8?B?T1ZaeE9UajRwVXZEUVdjYXFPNGw1UHc0UVNxMzlBUUhveURoVFFvcFdhd1N5?=
 =?utf-8?B?TkpsUENodWtITUFKcDBMQ0gzYkRUVEZXWmJiSTVVNUxsekQ0azBCcG50N1NS?=
 =?utf-8?B?REJ6b3Z3UTRRQzdOWjNlTzYzU0diVlN2dmJLN1NpTjBKV3A3Y0ZCWVExUHlX?=
 =?utf-8?B?YWdSV3FPa0hDTm4vcitUQTZRUXJWRWtsVVpTNVhxTDYybUQwWWZSNXczVXlZ?=
 =?utf-8?B?YlZpaWkxVnFPQXViUkZURE9kRy9OVEJGc0Z5WTZVenp1T0RrWXRFdXdkREp2?=
 =?utf-8?B?YzkwaHpTTlVmQ3BlLzF3Rk9TaHpmRmFXd2hFcCtGMzBJV1kzbmFuSlJxQ0tx?=
 =?utf-8?Q?tfn34Rv73csEpNylARhrxV5mzquhSU0RqjDflWW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlR1dW1XaDBwQnFVVFNRRzdVUVBPeVorQVdrNHh5d0pzNUpmK0NvaWVNKy90?=
 =?utf-8?B?K0hSQnord2t5WElVcE9FRmFHZEJGelZpYUJxaGFiSTViL2tlaCs5ZS8wcEhR?=
 =?utf-8?B?R0VBajJoNFBKWG9lSXF0K2hFREoyWjVDSXEvTjFuTHJWbllZbVcvSWNYNmI0?=
 =?utf-8?B?MGY5QzZaUjU1M0wzcTJsSkcwNGlqQkxzZis4SmZBQm5qTnhnTFZTWWdhL3Zp?=
 =?utf-8?B?THBndmpkNDF3SVU2ZDNsd1VnWDZzRWZYbmp4Nm51UE5kWXh5ckwrdXd6SGJE?=
 =?utf-8?B?WXI0UFZzeWR4SUtkM2d3akZycUR5U20wRVNIcEtRQ1FqUlk2VnNISWhVVmFu?=
 =?utf-8?B?YWZnRHA1QmFZL1A3NkNrZ1hLWVMzSXl0a1ppQVZYSE5wQW94bWRFNjJLenpS?=
 =?utf-8?B?L1lWT2t5c3hnTFBCYzRPeXBEaUdFZ0haQlFUdlJJa1o2bXRQMjZNbEJyd3NI?=
 =?utf-8?B?VEYrK1UrYUpiMC9vTm94bXZyNVlpaG50SC8rNTVVM3JSOE1kMGpoekwrai9y?=
 =?utf-8?B?RnB4aUVyYjNJZnZNTmVXc3hWbTRyaWt1RThGTmUzTDkySkdweFZFOVpFYUYz?=
 =?utf-8?B?UVo0VXNIMkR6ZzlFMU0xMkJYLzlLTncxLzJ4bWtNT21mTndoRHUyRVB2T2Jn?=
 =?utf-8?B?TzgyK2JhYU5lUmNkaW5WRzlDR1I0cFlSYmdLS2ZXdGx3RlU1bkRia3g1OFF0?=
 =?utf-8?B?T1lwL2FCNXhidXRaT0VNbHAyQ05vWEV6bHpyNDdPRzhhWm9JLzE5cWlLbWk4?=
 =?utf-8?B?c3NMcUNKT2RSQ1Fhb1RqMm5JMURJTm95eW5TZG1QM29ZWlRjSW9oczFyNVU3?=
 =?utf-8?B?Zyt3S1V5VG02SzhYbUl1SkpBaWtSeHFmZjluMFo0RUkwYnlDUmN5Q1FxR0Nk?=
 =?utf-8?B?QjFFdlNnczhVNXdoRlA0SGtjRitxNEdPNUJTWEVhbEptWk5RbFBmRXJoU24w?=
 =?utf-8?B?YnQ0N01JV3dMM25qdWdQNWZzazdKS2dieDdEOVZhRkxMOXVaakhLMTAwT25n?=
 =?utf-8?B?dzFhejBoMXhRNmFTUXhPNlQ5TkNSSjdQYWVDSDc3cTJYRzZKTDVKdUw1Z3lC?=
 =?utf-8?B?ZFlMbmlCdEdESWtYSk1TdWdnYndZMmFueGYrZ0k5NXNQYndJVzhkZVRKVE1X?=
 =?utf-8?B?TGxucUVabWZWd3ZwR0ZadnBMT1JPYVBxNzJxZm91Q0JPMW1wVzZ6WDRUOGtY?=
 =?utf-8?B?bGFvR2lGbTVBbEs2Zk9UTEI0UUpvMjZrRllhaHBIL3NNaFNUUW5QdW0xL1NL?=
 =?utf-8?B?Qzh1cDhvY2J3SSt0NlJ3ZXI3Z0ZrdDl3SndDbGVYZzB6a3QvUW5UeFdYSDhj?=
 =?utf-8?B?aTg0U3hPelhRa1pJMDlUZHNVczJGVlk5cWtzTWdNSjFpODBLN0doenFhRkZh?=
 =?utf-8?B?eDlTeVl1Y2VKM2QrSXExR2NvZEY0bjFWR3lMRVdJQ2NxMHVjRUxKU2l0dWU1?=
 =?utf-8?B?c3lPT21BdnZNcjNDbWlINXc1VFgvc0hCd1JNZEVHTzBYSHNKYk5Vc0JmLzdD?=
 =?utf-8?B?TU0zNDZNanpCVWdUM0hhZEJQdE9kT3g3Y0I0dGJQRmcxcjZTcGQ0bW9ienBp?=
 =?utf-8?B?Zk5JSjZncGdjdTAyMlJjMlZHZFFEMUZHbTlXanZLZDFsM01Ld3FXNklodXhn?=
 =?utf-8?B?YUg4SDU4Z1dXWGZYaENKenI2L1pxRmVoc3psdTNKMHNnS2dYZkNGZjM3VmFJ?=
 =?utf-8?B?NC9OcHN2bFZrVS9lY3cyL3l6anZEYWxWNCt3Z1ZOZVQwTmQzL3BOeFd3LzlW?=
 =?utf-8?B?UWdiUVdtcS80N3RkZXhmZy9iWWtDRE5UbGxDcEN2SkhNMnB4c1ZaVWl5Z0sw?=
 =?utf-8?B?NVcyODVFZ2lNRy9lckNyMDhzcXVKOWp4ZmJEUEUyYU04T3Y1N250ejhJRW5S?=
 =?utf-8?B?ck54YkJRbkxtL0ZjZjNpZ1hYMld0RU5pcU1SODZSUlJ1MGtpUWI5VUp2QUNI?=
 =?utf-8?B?N2hOVS9BQnFtVWZBM3owMWlwMTlFclFDU2YwT1Y0OUd0azJVTURlcEZrNXRF?=
 =?utf-8?B?ZDlpNkVlZjQyNWNZczlaQitqaVhqZTEzZnJSUHFFU2hWTGphaU5sblk2M3lk?=
 =?utf-8?B?eDliY05NbGx4d2lhWERGMVQxK2VtRW9NMVdCYVp5TUNIMXhnR0hlWGpjYWhP?=
 =?utf-8?B?V2lyQ2g5bkxtbTZtQkFJTUhrMTdGOG96SEJ1RlA4VFdpbERoMDdjK2FxcS9p?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 575959fd-e03a-4d46-ed28-08dcf3a7da45
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:15:42.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvbsUjZENcq5/AZPMDRXE/yPq5qDoJYmhpGOgDJknrh0Jua2ZSXSdlc0Z2Nryl6tT81Hrgv9rvAc0BjIbhadg3ZC91SrdhpBAGTdHpHWHu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7958
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> The struct rdt_resource default_ctrl is used by both the architecture
> code for resetting the hardware controls, and by the filesystem parts
> of resctrl to report to user-space.

This is not accurate. The hardware controls may be different from
what is reported to user-space, for example when MBA software controller
is active.

> 
> This means the value has to be shared, but might not match the
> properties of the control. e.g. a percentage greater than 100.

Are you referring to software controller here? When would this not
match properties of control? That this value may not match properties
of control contradicts first paragraph that this is used to reset the
control ...

> 
> Instead, determine the default control value from a shared helper
> resctrl_get_default_ctrl() that uses the schema properties to
> determine the correct value.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---

Reinette

