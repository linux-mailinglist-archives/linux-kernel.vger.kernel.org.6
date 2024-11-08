Return-Path: <linux-kernel+bounces-400837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95379C1318
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AC61C210FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BE61E87B;
	Fri,  8 Nov 2024 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WP9naC14"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B617996
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731025311; cv=fail; b=MMTWRgmB7Yu66L7LV8mfxmaCZCF9XX2lT2Sypc/A+0ZlmZlVV1/a6shEpV6RF+45LxSeOLalnR4EVgEGTw9V/BmkH3gsoXLJA/digh4Q6XdJxkhqK8r8x3QaT3bfZX4zx5fQns/dgupoVsFIgPghZ/AKrI0nLddTtLAqkQSYRRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731025311; c=relaxed/simple;
	bh=/yG/pRofsMWmw68bedxWgc1+z3djkp4BOMcLpWc7bw4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=irSAEXv4qEtqPiYCs/mkpBOnTQjc7SFlGisJ2g9rKy/902LTNu6yI5o3A0sHg7rZWk1hvn+/7//ZXEmbYuC3JAkqrwucWhQMiQsAhwXmgLoQdq10DjifAEsR6Ll8WMuXZY8HZ452cdccX2GX//3mj3E2+nr9lLm8350SnHEDLiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WP9naC14; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731025310; x=1762561310;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/yG/pRofsMWmw68bedxWgc1+z3djkp4BOMcLpWc7bw4=;
  b=WP9naC14NILQ1EA46BfirhP5LG0rRZRrwLM+37k1Wbgopit6fdBdR/q9
   AAHxZqpcjpjBUVoLfF22hNFHvU/p0tFcm0ZfInfWBev/PwtXAPion07Ds
   GVQdJZHG+6fPjCjOfUKsHuRLQSzu6nw4GxHvSoRXRwGDapleqiOFTeHFC
   NFNLz7x1UXGjfk5KsW7wg42JdPMMgE/yg/eKjc2ptpXPORUg3DnyRa3BG
   pbGyIZf5eHdQal93MJZWYIJ7Kxux644jnNU8NEzvNu4fsNEusLlmIYJXU
   /jAPfIXLwB7kkbqfwO5JSuX2Znttdx/BUS7BQwLI4syCwJbMxmm8p/mXQ
   w==;
X-CSE-ConnectionGUID: UH1b7ug0ThWV4n0+GmYITA==
X-CSE-MsgGUID: 07TkbSerS8OjT/msyqAZTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30781209"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="30781209"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 16:21:49 -0800
X-CSE-ConnectionGUID: KWV7T3GuRI2sz1sSRgDoVA==
X-CSE-MsgGUID: eiJnTSyYSruALPqndJ1i+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="85626443"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 16:21:49 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 16:21:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 16:21:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 16:21:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmDMKRD5rI4p/9kYVXQ4P6BB5IH5f+EZ8FRrFqq/uzXzRTlNJFsuQPs/1gkE1BMO819DH8AzKQAzaHi1PPhs0Wf4ZMK4mov1RY1meAWIE5bi2yYeLVjLOWVy2xFPbQTjzK1k/PKjZcWErka68Rf9ENhT7SMG9BUFlrA9rC8B2yJoG+EKKWumy259LYX7z1vrM5ZImFk0aE4hQqWuqWDuiTsOBlRk9p9pq5oTlXt8P9xqIdMkT3yysxjgcz0iAhDJH729KX6UcsllPnBwXSyZeeaYz4scFoWypS1Z89pKyqt7ewtSyFS9pBWyJvEzzVjl6UVwtm+lSjZJa0fa2o8dug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDDQc6m/ZaOukgXo3XnlOnL37uac9+jGRAy2O9BRWZ0=;
 b=XtNhnSCp2EhS+kSLp73c9PVfU4sl8obvvgCKPEEwnGO5Q1v8AW3WeODf3qB2dmu8YgZqx0Lhmkfn0Roq2cCpGrXUJ1PFvIFzgPA/vaXGTD9bPGvlTcg7yViSPCOcXm6K9e4w+9XAtbwe24wKR/+n+KAk94r0a4Cb82gGHlUlsh+/O26Yz1WK/mnbtfmLpE4eqYHU0HF4M5C/ebicznpBmMV6u1Z+txZS36Hkiz+Lq4MnimY86qMe7TRKuVSckcxFQPX92H3jyshXnG9/cZ6gAffMH76NsWW+dBtysEtxQdWGdYUHAp9m8wlAOz0QRbW3zxSnXZIR2rPVkICPFOEoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7114.namprd11.prod.outlook.com (2603:10b6:806:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 00:21:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8114.028; Fri, 8 Nov 2024
 00:21:44 +0000
Message-ID: <28080949-d8c2-4cbf-b971-705deb71ac4c@intel.com>
Date: Thu, 7 Nov 2024 16:21:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter
 reads
To: "Luck, Tony" <tony.luck@intel.com>, Peter Newman <peternewman@google.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Eranian,
 Stephane" <eranian@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"nert.pinx@gmail.com" <nert.pinx@gmail.com>, "tan.shaopeng@fujitsu.com"
	<tan.shaopeng@fujitsu.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com>
 <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
 <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
 <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com>
 <ZyzxbhHQptbktfGH@agluck-desk3>
 <034d8377-6276-417a-983b-1af4617d60ca@intel.com>
 <IA1PR11MB6076F9F222A98125974C5CBCFC5C2@IA1PR11MB6076.namprd11.prod.outlook.com>
 <c4ced27a-b3e9-4727-9c39-7d1fd0cb0dd2@intel.com>
 <SJ1PR11MB6083BA9392D4B176FA2DA170FC5C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <a593dd7b-f502-449f-a866-5e6494de506f@intel.com>
 <SJ1PR11MB6083D9983DFD226A1FE826ABFC5C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB6083D9983DFD226A1FE826ABFC5C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0281.namprd04.prod.outlook.com
 (2603:10b6:303:89::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ac9172-41c0-4dfe-0d22-08dcff8b5373
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHk3M3lycUhvVkwxRTI4K2ZBeWFSM085MDVwK1Z1b2VRUVNra1ZZMHRJcVdU?=
 =?utf-8?B?a1hVdVAxdm82MkxGaGdqR2pPRkptdUtrdkMzcjE0eGY0N0hQb00wUDNXczFW?=
 =?utf-8?B?REZ6Qm9QSFc2ZVEwb0o5UkRlZHRGNkNDblBvd0RSMGJJVHlxc1hEWTNKajdy?=
 =?utf-8?B?VGE2ZndRRmVWdDF4YVJHckl5ck1OdFUzbjRlYUxsMEkvL2pJV3FLOFVoeTFP?=
 =?utf-8?B?dXFnc3N5TFpmdkd0WkFzcnZGdGFhUEgyRHVUMmlGa1FPNUcwVml2R1ZKaXRD?=
 =?utf-8?B?Y01aYnl0Si84WnJzNVZkQkdvOUtITUViSStTNGxlUzFjL3FzNG1jMGtYYVlQ?=
 =?utf-8?B?cEkxZHRWTlNxaGs5QXc2Ly91NVJFWjhKaGNodWtQSnkyaGtVUTVxV2lhck4x?=
 =?utf-8?B?dkcwY2tFTG0zV2JPeGVycVBUUWpkUGw3QTc5TEdZYWNTb0UxZUs4Q1dOd1ZQ?=
 =?utf-8?B?Smh0QVNQbmp6U3VPMHpqYWVZeVpheEh2d1Y5NXI2c3crRFg5VUdWeFAyeUlU?=
 =?utf-8?B?UTNIYVFIcC9NUlM4MUtUUnpjaThjS2R3VGtxeGlwY2NtMTZQL3cwb1RwS05C?=
 =?utf-8?B?TS9laDk4dWlIMEt2QUQ0YjloTkpBQzZtVHVqbUdSNVg5M3Q4Z3VCYnJCaldW?=
 =?utf-8?B?aXdpRFIvbXNvdUxXY3JISjNrL3RKcnJaYlVvNUM5b3E2UUdMRWRCNEhMemo0?=
 =?utf-8?B?WFVPTTNxY05paFFxeG5kcGo1RXpVVDV3NVQ2ejlqVllBdkJjN0RlaEl5MnpX?=
 =?utf-8?B?cFl3bjdXeDI2M0NISVcyLzI4ZXE3VnpkaWVpZkM4V2RVZEtzUTBqK24wb2hL?=
 =?utf-8?B?MlQ2M1ZjNjI0MEJXZGNha1h6cHJZN0pKak5RM2crdlhpMlZDQ3hFOEJTaEd5?=
 =?utf-8?B?RjNLRExPNjlSZ0tVeHlkMTFnSkhvRk9KV2JPTkVhbEw2NFZ2bVpTc3BwRG9j?=
 =?utf-8?B?bitlQVlUNk9MUno4WU9lS1MwNmdTYkF2dmZuTTk0VEFaRDR0cFFuemJTSUdT?=
 =?utf-8?B?NkdJYUNuUEZKWGNmNENWUnBaVmJGZmFTK3l1NHV5bFA5a1FrSlZrRFZiSG5q?=
 =?utf-8?B?KzlZMUx5WU1jRzRqWXIzcngyMEZjcy9SVnUvdmJ0Q2xzWDhDZUQvTzJWaHdI?=
 =?utf-8?B?cnJzWkFsaUtEaVFqUWozTVBqeWJjMVp4ekdXQkJudEF5SEF4VThDeHN0cGNK?=
 =?utf-8?B?REdndkVLYlJidzJLTU5mZDRyU21HQlpCZTVFNG8vSUIwdDZ0TnVzRVNVdWl5?=
 =?utf-8?B?TStlbS9GT3Q2R0hRbVhSekIwMFJ2YzRGb3lmcDlaajdmVmJXZUZJZ3kxbTZx?=
 =?utf-8?B?SGN5MjlnNFh3QzYyRXlJbUxtaGJJU0ZqZ2FyR2tCQVpHM1FCOS9JVDJGSjNV?=
 =?utf-8?B?M3A1RDQ3QkpKdWl0QjZpVWFGeUhDQnQ3TkorMTZNcU1QdURKaDJyaVB1bEhF?=
 =?utf-8?B?YXQ3cG9mOTVlV21qL2xzRWtRVjVJSzZ3ZDN3b0NoVHUrR0lzL2hlWGNkL2Fy?=
 =?utf-8?B?SFE3UUFRSCt0SHdBcktXVXZ3QUhYd0hVMVBWWG9NN0lxVXFTTU9MYTJvTjk3?=
 =?utf-8?B?dHZSSWZtSXJwb1VVcER6Ukd2VXdwamEvbEhlSlZRWFhwcHdLK3Zzcmtwd2p5?=
 =?utf-8?B?NVBOd08yQlJOaUtEMFQraFZ2NWFXMFo3VFNVVWpPSmYzVGtnRTd2bTV3UGxX?=
 =?utf-8?B?WjVJbC9nMHE5djFEY2srRWVZWFRXUVJ1OEVHNzRRcEFJUDgyb1VGS1FqV1lt?=
 =?utf-8?Q?YFSKvo5n2taPQgkM/nj3oWlVHeSqkZ6SB3Ijaq4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0RkWGZELzJGSVpKajUxRmVjY09FRTgvWnFQei9EQmM3Ykg5TnpkTnZCUWFl?=
 =?utf-8?B?TW1JcTdSazZnZUlVVTEybzlQY1AvQUZyVzQ4clp5SU9lVnF5MExqOG9Ed0Rj?=
 =?utf-8?B?MTFNL0pHdCtPUng3Z1NjMU1nSGptdlJxL3NKVmxGQW1pYzRYQ0dqcHVaSDJj?=
 =?utf-8?B?clJqLzUrUm5CTnZjcW5WUmRWUHN4dGxDTjZpbGVWcExiTjVDU2FXSmNKRk9a?=
 =?utf-8?B?cTFHbWJmTXYwZHhucm9JTDJidk1QdEZOQ2hKWlB0K2oyTnIwempYVDBUajNh?=
 =?utf-8?B?UGlUbzk0S1p4aUJJY1QvSG1UME5kRXVkL25yZ1gvalljL2l4bStWU1ArVkRK?=
 =?utf-8?B?MXl5bW5MWU9YRENEYWFlR1lZTWpocklXZWJnQnk1N3RBSC9SZXAvYnZyRXZp?=
 =?utf-8?B?VGF3aWUyeXAxTDhyS2dYRmYzeGdFd3poQ3V0OEpZNGg5UkR6Uzhram1ybXUr?=
 =?utf-8?B?REdrd0VCYTBGaWJzTTZwWGtpNnNJQlJ1Y200N1F3M0oralR5SjI0U1dGZWZK?=
 =?utf-8?B?WXBocmxSYU10TFBUdVRnSHA3V05XT0JjcTJjODh6eGs2eTR2NlhzeTBJOGNa?=
 =?utf-8?B?Y2xUU2VxaWtYM0ljOFRFc0lVQ0VrUVdVQ2NFaXg0cHV3YW82MmhBTHJneGM3?=
 =?utf-8?B?cHVWcFFQQ3RJbTc3YmE3azhxaG9ianlWUXZjMlgvT0Q0NGFMWHRlRzlFNWxr?=
 =?utf-8?B?QWlobi9NZTVQV2pOUHRXQTVSK1dOZ0lhcVRoQ0JtajVubHY0UmZXUFRNeUsv?=
 =?utf-8?B?ck9wYTBDQVZCQ05HMW41S0pyN00vMW1QVGFpdFIwZTRrRnNQZml6L0ZRZjVH?=
 =?utf-8?B?ZWIwUzZmWUsxU2lmcEt0UXdwU1VCSDZ3VUJpVFB6RVZOb0kwT0FubkpEWFJi?=
 =?utf-8?B?eUM5OHZScDRwSTZ6bjMydHU5QU5ZU3R3VHRLNDdhWG1td1pPUXYrMGdVQTVM?=
 =?utf-8?B?NDRqYUdXQVZIYUMrbGhvS1J3cDdhWjJRZWVNSUNnazFMQzU0WmgrbFYzaHRL?=
 =?utf-8?B?YjZmV1owYWR0dFhNdXZPSGdybnpWbFdEWWJZWUNkd0hqNUd1c3pGaHk1UHpT?=
 =?utf-8?B?aThJMUJObUV4bkFzZ1pBWGRha09VS1lMOHh4ODZzSjNCNkN1WVlGc0tCbDVV?=
 =?utf-8?B?U1YxVXJJVHl3cmNJMmJUTnZlNUVGQ0tUY0pBKy9OQzF3RCtlYjNYNXdkRmwv?=
 =?utf-8?B?azVxK3MvVGZqWHBhUndjUGZQdWROeHhFN0Q1RGpnQ1RmSG5VUWVwWWVMQlRz?=
 =?utf-8?B?eHBsam82TTkyN3NsT0RuVzMwZk1makRlenVOckVwWDUrVlZ6Z2VDV280VkVQ?=
 =?utf-8?B?ckp3R2c0K3FNOUlSeVBNbkV5UllFaGZCOWtEdmRoZkRuY29ISlBLTVovZTAy?=
 =?utf-8?B?V0ZKZS83endwRkc4YnV4elFSUGhEZXNyemNrRktYTWhCUlBEd1JNdWVSaXBK?=
 =?utf-8?B?N3YwejZSUG95Q1cyKzY5UTZxSThiRlhqNkdRS3c4bjZoSEYzUmh4Z2gvekw4?=
 =?utf-8?B?S2FVOTRlWmk5Sm4xVUtCSXc0TEdqVkdEYWVLZ0h4Y3pUWm9ORW5SelhCUitG?=
 =?utf-8?B?Z09ydnpYc2tFdlNkY2xMY1QzdVFESDVLb2xxWVhtc0N4U3FqQ0F5R21MdGlo?=
 =?utf-8?B?UmlJS1dCMnQ5MXFyQ1FXdTh5czBOQ0ZUaUs4THlZazBWdXAyOUdxZHJYZmpR?=
 =?utf-8?B?ZE5rOWMyU2c4cUdvTk1LbzVST1VmWHBiMjZxSmVlVjg0RkZ0QUw3TU5WaGNE?=
 =?utf-8?B?ZHRWZGZhS2lSbzlJRVlqbkMyajduSnU4OGIvajdYU2F1VmZidE9TOE55RnRZ?=
 =?utf-8?B?bkZNYVRvRDBnY21Wd093UnAzUUkwcVE3Nm4zbWExMnJsNksxVGJTRy9PUklP?=
 =?utf-8?B?bUpIN1pycjFxZFV5VVIwVk9PQXB3U1pzakJKNnpBVUNpSmJ2T0FuK0ZTejZM?=
 =?utf-8?B?YnNxdmNnSmgvT1VUa1NycFQ3dUExc1BzejFBOWlMVG8xbU5lNXljdW16WE5L?=
 =?utf-8?B?YlVSOTZXczdvY3pCemVnM3hBdzd2VDZHNzk1cTJYTzZLSE1FN0xocURialJ6?=
 =?utf-8?B?cjRRQStmY3pzempLNE9tK0dnZE13QzlwS01XaTlOSXNUZXllYjZpV1dHbTR3?=
 =?utf-8?B?M2thMXZJVXFta01WYWlONUpNV1g3U3JlRnRkUGpaL29uQTErdFJZTW9ISE1B?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ac9172-41c0-4dfe-0d22-08dcff8b5373
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 00:21:44.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXM1PcjEEsfdYf3mmvKwg98J1P8P8HuknpcvMyXLcqSGc2HvJW8LGpPMK9Wsue872FXWVc+0Z9Qka6gdfMlfxtC/SZckbUyWdh2U+y7bBUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7114
X-OriginatorOrg: intel.com

Hi Tony,

On 11/7/24 3:30 PM, Luck, Tony wrote:
>>> E.g. read a counter:
>>>
>>> $ cat mbm_local_bytes
>>> 123456789
>>>
>>> H/w counter for this event/group assigned elsewhere.
>>>
>>> H/w counter assigned back to this event/group
>>>
>>> $ cat mbm_local_bytes
>>> 23456
>>>
>>> Bandwidth calculation sees traffic amount:
>>>      (23456 - 123456789) = -123433333
>>> Oops. Negative!
>>
>> As I understand this is already an issue today on AMD systems without assignable counters
>> that may run out of counters. On these systems, any RMID that is no longer being tracked will
>> be reset to zero. [1]
> 
> My understanding too.
> 
>> The support for assignable counters give user space control over this unexpected reset of
>> counters.
>>
>> The scenario you present seem to demonstrate how two independent user space systems
>> can trample on each other when interacting with the same resources. Is this something you expect
>> resctrl should protect against? I would expect that there would be a single user space system
>> doing something like above and it would reset history after unassigning a counter.
> 
> As we are discussing adding a new interface, I thought it worth considering adding
> a way for user space to be aware of the re-assignment of counters. IMHO it would be
> a nice to have feature. Not required if all users of resctrl are aware of each other's
> actions.

If this is indeed a requirement it may be best to consider it as part of the current
work to enable assignable counters. For example, by adding the "generation" value to
"mbm_assign_control" file that independent user space apps can query to get current counter
state before parsing event data.
I am not familiar with a use case relying on independent user space applications interacting
with resctrl so I would like to understand this requirement better before making the interface
more complicated.

> 
>> This does indeed highlight that if resctrl does start to dynamically assign counters (which
>> has only been speculated in this thread and is not part of current [1] design) then it may cause
>> problems on user space side.
> 
> Agreed. Dynamic assignment would break "the user knows what is happening" assumption.
> Seems like a bad idea.

I believe that is why Peter described it as a new "mode" that user space can select and thus
be aware of. This does not address how user space is expected to deal with event data reads that
may not increment when this "mode" is active though.

Reinette


