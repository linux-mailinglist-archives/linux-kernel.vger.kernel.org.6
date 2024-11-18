Return-Path: <linux-kernel+bounces-412510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA1A9D09E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C5A1F214F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7482914AD0D;
	Mon, 18 Nov 2024 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlyMrWsj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77D714A0B9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731913047; cv=fail; b=gSxnC9TiF25x2WpZxNx0TneTY00DoqLx1E9pQ8gP/mVkUBBfJKLGUSpbDilzdB98yFW4LuxBuek4HTQbj8Y3kj8UMcUiYWhjLANX1f4Pqlj/uL21L8uv4FDrs8viTjMc747HCHIqPW595dojCQQ0GdDKrNRj2B9AfOEKBWDROOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731913047; c=relaxed/simple;
	bh=NAhgQVGGMKrumgkeV6lA12T4S/6960egg2LSpx1V5hA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qhrYtnIVwsksu5jNBJ79Erwa3VBprrWaY3WbIg84r55iyH5+jKmYGTqcb4hxRD9hww7QgrJmqfGx8L13ov+bv/jXKZAAQCR17WSiimO1SwP1Z55u4cqKE4C3PHeypBbptpe/GZIch5hZPry670aNAJ++sKgmqeUkse5pJlzU3Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlyMrWsj; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731913044; x=1763449044;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NAhgQVGGMKrumgkeV6lA12T4S/6960egg2LSpx1V5hA=;
  b=TlyMrWsj0Wth1WgM8xzENJoZ7Iq26Cls9CZQMx9yNM8dN0t7VATfS+Al
   xduh/YCj1gkP6e46geT+Y2fAwSH6j81J2mmr3aAftlEFhNa7QTZr822OU
   TJZqnOWDaQZhhSPMs7bHSQkMG9kjgePtcHFFnK2i/gz+q5H7yyaWLVWiK
   O8eskILp3RyDuUjNaW4g0+G1QuGqFDnwFDm5BUTxRrAshGT09RByuZRy5
   I9cLO56VkxV6i2GMEVdNsLcsTk526+t1pA/HJcUR631fkfLV7vTpPu0zC
   KorIXaM6W5lx+FEe9wClynQG1OpdO7+Cx29AEnBw2CDeZDZh0ZuAwlG/Y
   Q==;
X-CSE-ConnectionGUID: DTOeDdnIQoeaiECFwtd3lw==
X-CSE-MsgGUID: F5Vkee7ESQq1kFFM4PrC1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="31950254"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="31950254"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 22:57:23 -0800
X-CSE-ConnectionGUID: Awn/1bNHS+eOt/xuqOiL4w==
X-CSE-MsgGUID: uE8z5SF4S4eebWSOHQ+BQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="89567498"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2024 22:57:23 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 17 Nov 2024 22:57:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 17 Nov 2024 22:57:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 17 Nov 2024 22:57:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9vYwQudyVlhyhI9c7ErmMX7fUtj9VcV3g/IuYrXu5WJCNRn8nyMQebJBLwRn3v0dyUF4kH5YG1RLgwd/lOJdty/YYvMIZ2ugJrDe19oHvjP4ZEExmAkpl/1sAwhYPmosa7I7K4rbw+88ZvQhJR/PdBWUX7b8eDuW+DxdnUA2UGwfriz2aGXC6VierjF2bxJuGTiqwMZatTcUB4aninuFGpxV83Sewqdlz6eazm4OKCUYegek8QeLLk/mA93OmoMqc0Us/OdXaG1r93d/5DHrrHiIet93k03gIYzb+qq+g13KFLAHG6k/u4VoHgx7qvAk2PbsjK54tQN8sMCAbZDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeZ7lspyxzsjcPqpkQrRe9VVw7xCIj06hJhNUIGnKjE=;
 b=TYlC4TD9tpQxd+xhgq6O302PGZLWWmBaewii8VhS0c+bPI3ogS1HuC9PLWELLMszFP42hQn83VYqUAkoCdTY5vffb65FBdIjk6DV+9V3MZGzuQIBT4bn1d9YYLrI2WrOpLROZekDX0KP4UhrDMDvqw4Uj+wfcfz9SND7YYOmOq7Iy/ddc2f20+C0cpsF528aU501NbK2vLwRvx5r9WDin9L2ygvZzwC5EZKNyN8Wt+eiimDqNIUYGVnQXGBAULG/CDF75GoDpe53YYTPeHw8SObxJKpJKRxMCxg5z1dxbYOOk+IYtqbdgztbe0reeeAsEBbbV+5rELpos6Zv+ypkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8327.namprd11.prod.outlook.com (2603:10b6:806:378::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 06:57:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 06:57:18 +0000
Date: Mon, 18 Nov 2024 14:56:59 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov
	<bp@alien8.de>, Christoph Hellwig <hch@infradead.org>, Daniel Gomez
	<da.gomez@samsung.com>, David Hildenbrand <david@redhat.com>, Davidlohr Bueso
	<dave@stgolabs.net>, David Rientjes <rientjes@google.com>, Dennis Zhou
	<dennis@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, John Hubbard
	<jhubbard@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Kalesh Singh <kaleshsingh@google.com>, Kees Cook
	<keescook@chromium.org>, Kent Overstreet <kent.overstreet@linux.dev>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, "Mike
 Rapoport" <rppt@kernel.org>, Minchan Kim <minchan@google.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Sami Tolvanen
	<samitolvanen@google.com>, Sourav Panda <souravpanda@google.com>, Steven
 Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas
 Huth <thuth@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka
	<vbabka@suse.cz>, Xiongwei Song <xiongwei.song@windriver.com>, Yu Zhao
	<yuzhao@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [alloc_tag] 0f9b685626:
 BUG:KASAN:vmalloc-out-of-bounds_in_move_module
Message-ID: <ZzrlO9wi8P8cyrk7@xsang-OptiPlex-9020>
References: <202411132111.6a221562-lkp@intel.com>
 <CAJuCfpGMM1=3eS_1yCEFrwdFHv_dYZ3f1fXaFaKzT-hcNfjxfw@mail.gmail.com>
 <CAJuCfpH4Vz_CxGFT7qbziF6jZ448Riss89KNXzDw3CG3gecHhw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH4Vz_CxGFT7qbziF6jZ448Riss89KNXzDw3CG3gecHhw@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 0433570e-eba8-44ec-9c6f-08dd079e3e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHFSbXFCZjFFYUlxUHZMckdaZjV0ZDFJSktNTWd4N0VlQmVsalpGbGp6Q0Ur?=
 =?utf-8?B?c1FiNGZiekRhTjRTWVZxMWFwL3Q5K1dJbkd3eHlWalNqYWRTamQ5VVlyTmFO?=
 =?utf-8?B?OVA4N0tvZENiNURFc1ZKWGwvSmZMaG9NVDBJb3FBSlE3cVZFNkNBU2pHL3E0?=
 =?utf-8?B?QktnNkVLOHVGNnZKVERLL09YSDYwZndvTjRMbGxiaGk1WERNQjJ5K09selpr?=
 =?utf-8?B?ZmJKUmRZQkRvbWdWQ2NGbjYyR0F1SjJQTjI1bUU0Q3B4aEdBRmpZU2dTb3ZC?=
 =?utf-8?B?WUJSNmljdThvREFueWhBNkl3WlhKYUU5SkxFYmhvSHM0SURzR3J6M1NjNGtM?=
 =?utf-8?B?UExlZGxuM05UYVNHM0pqY0xqSjlIWGFzT2ErdjI0ZWpDalJmRzhmRzdzQlp4?=
 =?utf-8?B?UnBHelVkWTFETi8yQWE2aXFuKzR1NS9odjJJMGZwSjJNaHEzK2R4cVlFV0NJ?=
 =?utf-8?B?Z0JQNmJiaWIzWS9IcWd0UEJTaVRJZk1Odkx5cHBBcWhUYUhKMlpseFgvcjM0?=
 =?utf-8?B?TkFydG94OFhEVVpRQTIzdWlNY1ZBaFFDOGR2MDdiUVBkQ3FqOVNrN2JnT1hs?=
 =?utf-8?B?MFBBSkh4ZlVmOTJUM1FOMVhya2JNMzNXRjdOWERabmlMZnEvS0Jla0dSRzdn?=
 =?utf-8?B?TTBJVmRmbzdFelh0QjM0cCtKZFpRcTFycmpxNUZBaFIvTDRRZkM3S1lISUw5?=
 =?utf-8?B?NlBwZ2NBclpKNmJtZHNGWnpyMWVjOW1VUGVUV0FyeXcxMjFKSXJVRmxlTWlp?=
 =?utf-8?B?R1RRUFk1Ym5uVEgwK2tRUktwTDdvRkRqaXYycDNYYTJEbmRQZG5YWkJDOFRE?=
 =?utf-8?B?WlFpY3FyY05TRXF4eGJma3lJVURhQnN3Y21WSmNNUzRXUlF5ak1BRUtHdGlo?=
 =?utf-8?B?Q3ErenY4b3FHUkFDaUhSNmovc1pvYnJGUDREM0JRMllMMzhTdzFHbWt4QmRP?=
 =?utf-8?B?UlppQlRJMW9tV0cyWnlLOGE2T1M4alZEQTYvTnpMWjVwU04yRDRhMDFTNk1K?=
 =?utf-8?B?RFFVazdEdVNkQldUaGt5S2VrVkkvUnZZOTM4K21hSUI1N01hZkRiUU5hSktC?=
 =?utf-8?B?c1JGUS9BS1U1WThBdjBMVGFqRFJOVVczRmpWQ3ZuQThBNTJ6V29KVzBlUllM?=
 =?utf-8?B?c3VjRHRSYllWK1hrekVSMmN5NzVkeXRSUmlmSzgwQTV1MUluTFlRd0Y2RDFO?=
 =?utf-8?B?cjhQeHkwZ3VrWkZZQmxQN2V1dkJBQVV1eE1BRTloeTFlb3NBK3ZkSnJ5UlZo?=
 =?utf-8?B?MmVQc2JGOWdqL3lWcVNseUIwRitlbW82OUFQSUhLcSthM3g0UStVWnhtWDlI?=
 =?utf-8?B?NzZoNnl2T1FUQjhqbmZ5RW5oODJuWE1NT29rRDdVQTk5L250bGZvcGN5ZFFO?=
 =?utf-8?B?M0RHQ2RYVysxeDJoR2JUTDl5OWtWOEJsSEx4Vk1zOVpxN1ZNYUt2WVdKRjky?=
 =?utf-8?B?ejlhcyttRkpoeFZvRUpJVy9xWkhXenZIVmVrUWJ4RVIrczBaY0p0cHVuRVhC?=
 =?utf-8?B?WURnSEYzVXRrRkNpVERZak45Q0JjWkxrS0YwNThaYm9EdEtzdkVIRlc3Zkp4?=
 =?utf-8?B?dnl1bm9YaHZwTmJTSnhrdHR1L1JhUkdxc0J6MkdHOGdwRDU2by9lMi9FT2ZZ?=
 =?utf-8?B?YURqR013M1R5am85OGoxcU52Vmp5SXYrc0FoN3lRbVE2Vldtb2xoaHV6ZWZS?=
 =?utf-8?B?Q0VkM1NrOEloQkJWWUI0TFVGRGM5bXpBQzJIY2JLMEVUMFlWVENQRkJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2QrY3JsekNtaHdLMTFwRHYvMXhXZ29BVHBvU3ZvZWY0R0IwMVRSR3ExMnBG?=
 =?utf-8?B?N2c4ajFQVkRGQ0dxSUZraE9MVGN4OUh6V3RwSU1aQ3hXYTFEaVFjNFdLQTdK?=
 =?utf-8?B?YUc4aUwyaDlFVE9sRkR2SjNBUFpxN1ZuYUJoejkyRklLaGdFZXVHekRVd3dZ?=
 =?utf-8?B?MEtkV1FtVXJVZjNxZkJDbHdQc1l5aUFpQkgyU2ErbTF4S0ZLb2FsVFZlZkJN?=
 =?utf-8?B?VlpaY3g5ZkY1UkdOK3lpSHV2QnRNTTZSY3JRaW5GUkpyS2tBUkIvbFpYYWFr?=
 =?utf-8?B?bG5lRkVaVFFXNlRoQWJDY1orRFlnK0FpZ3gzZzVhU2ZUYnlRRTZ0dUZpaVph?=
 =?utf-8?B?aU9YdnRMNnNhVWw0Zzl1T3hnd240VTRIemdjanU4MjMvR2gvRUdxWmJUOGdm?=
 =?utf-8?B?eEF1dGlZcGtIQnQrSTQ4Ykk1U09jSG5iamJzVUZNeGE1RVNYSTA1bU5QNGpD?=
 =?utf-8?B?UXY3OEpYSHNoaGhNa3JhZVVHSlhZVHRLdVdnVTBYMWJoWW5ubGlJbmk4QnNX?=
 =?utf-8?B?K0xnekhQYlQwOERQZVlpa2pKV05odGVrUGlUb2tWbCtnU0JsODZmWlpBZGx2?=
 =?utf-8?B?aCtqdWdqQTRnRDMzc3NwMFJIQWRCbVJZaFdGbkIzVE1Jb3lXMEtSN2J4OGVi?=
 =?utf-8?B?U2hjUzZlblMrYzJXSkZ0Ny9LOUVkcFhtbG1SRWJ3cHUzL29jSFcwVTRQTEtm?=
 =?utf-8?B?R1VscHZCKzg0NjI5VVZINExEQjZWOXlZRXJzamJJWm1IWUxtVzJmekJ4K2N4?=
 =?utf-8?B?cE9UMC9WaCtQamludi83eFF0QjNJUmMvc3ZTV21JcUkvTVlCTVRRU0Y4d2wv?=
 =?utf-8?B?MjFZbFRMSHVSZTNDTytraXJiVTZhN2VFdVlxVDhFNzVDRVhRUjlSa0dMbUtK?=
 =?utf-8?B?bktWdVpkK3JSWnhIMzdlUFJ2RHQya3FQMk4rSzNqUGNRSVdMdkM0bHMyMXpV?=
 =?utf-8?B?cEY3SGpyYkpsMGdQZzVPNGU2NGdFYjJHMTRybjUvQ2JLbGkrb0hHK3dsT1Vv?=
 =?utf-8?B?YzAxMXFkcTM2VTRmWXFPYmpyeURhWkVDYXZwd1lOMmNjWnpRdElxSWxRb0ZR?=
 =?utf-8?B?bDJ1Rk5ueHNYeHlIL2k5M2VtZ1AwenhtVVpQQkFzRnBvRGZ0Nnp5WjEyaE1w?=
 =?utf-8?B?N1FzRUdlKzA4VWpWWW5veFlHclJqdGhuR3hrOVlQNmlTalRoVGtlSzk2YVdw?=
 =?utf-8?B?Q3RiWmYrc1NTS0txVFY5VUZiNlZuYTlnTkZQMHZGckJPaXVEdzhJYUZyL2ZR?=
 =?utf-8?B?SXRaamRwOW82Y1ZQRUtWZ2xFTUpnR0FnZ3lYd1E4U1RTaXlBbEs1b0RNS25D?=
 =?utf-8?B?L3lyRW40Y1AxTTVWcksyUEJRa2x5NUNhbWVWSlVKRUsrWlBEYzJmTk5kVmNa?=
 =?utf-8?B?T0Q2ZVRlNmtjeE5FU09zZXZQcDFVdnZkbHhzZ0R1NkZjdEl0WVl4WEtRd3Zx?=
 =?utf-8?B?K0J3cFpPS0FBY2grTS9vQnBhYWwxOHN5Z2JIaHYwSjIxb0pPcDZnTmNKUmtH?=
 =?utf-8?B?aEdIRFNhOFVBR0pGeUdUYThrRnBIOWFOc0hKM2VnWkVSZ3dhUG83MWpVN2dy?=
 =?utf-8?B?WXdJdnhuaGVMMWZUNUNkVDIxKzhuZ0UzWFBoYkhyL2tnc1F5aXhWZThlZUJh?=
 =?utf-8?B?UUVCdjI0dHlHUmdwSVc2SWkwRVZtWHJ0a3ZHNkxmQUZCYlM4ZEZielpyWDVF?=
 =?utf-8?B?NjF3eTZWL1REVWxvRGE1SUxJSXFvS0kzeVVOV3pwaEZOSjE3YktvTExvUGVO?=
 =?utf-8?B?U1pmaGs5eVh0dTdIdk5wejV3UHI5VzN2RC95SFd0OU1qcTF1Y3g4cXkydWtY?=
 =?utf-8?B?QlVnTFZGc0RDaGJiSTQvVTREbXhOWmJpeFAwU3BzWjJUM1NFcnJONCt2WHZP?=
 =?utf-8?B?c3lsb3FuS2ROWUdKdkRidXBKTVlKMFZMenJvZE9Vb1BNcnVhejdYdGd2Y0Fn?=
 =?utf-8?B?ajVRYSs2RXRTL1ZzM0l5Z3h4eEdaUzM0NUZlTC9Ic080VUxNd3U5NVh1OTFw?=
 =?utf-8?B?U2hnOXRWRUVibE9tcEpIUitxaUpMZWphVk1DQzd5V1M1UUJWZWlBVlhLV3F2?=
 =?utf-8?B?eCtDcUd1aGFETFBpQzdzVEIxWSs3bmxGeEQ1aVRXc1c3UmhvK25nZ3VjS1M3?=
 =?utf-8?Q?g5iefFRgGeM6yk7tG8peSywLQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0433570e-eba8-44ec-9c6f-08dd079e3e21
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 06:57:18.8820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAvtkZhJjum78D6bpNAM/a82lrLR9LQlJ8boX/6BKMFMYYsxFwg/3rY4Yhj4XytAExV3R8X5bbOwfbNJ8p+8cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8327
X-OriginatorOrg: intel.com

hi, Suren,

On Thu, Nov 14, 2024 at 03:40:08PM -0800, Suren Baghdasaryan wrote:
> On Wed, Nov 13, 2024 at 1:34 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Wed, Nov 13, 2024 at 2:07 PM kernel test robot <oliver.sang@intel.com> wrote:
> > >
> > >
> > >
> > > Hello,
> > >
> > >
> > > we reported
> > > "[linux-next:master] [alloc_tag]  a9c60bb0d0: BUG:KASAN:vmalloc-out-of-bounds_in_load_module"
> > > in
> > > https://lore.kernel.org/all/202410281441.216670ac-lkp@intel.com/
> > >
> > > we noticed it seems there is following patch.
> > >
> > > we made below report just FYI that the commit still cause similar issue on
> > > linux-next/master and not fixed on tip of linux-next/master when this bisect
> > > is done.
> > >
> > >
> > > kernel test robot noticed "BUG:KASAN:vmalloc-out-of-bounds_in_move_module" on:
> > >
> > > commit: 0f9b685626daa2f8e19a9788625c9b624c223e45 ("alloc_tag: populate memory for module tags as needed")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > >
> > > [test failed on linux-next/master 929beafbe7acce3267c06115e13e03ff6e50548a]
> > >
> > > in testcase: rcuscale
> > > version:
> > > with following parameters:
> > >
> > >         runtime: 300s
> > >         scale_type: srcu
> > >
> > >
> > >
> > > config: x86_64-randconfig-014-20241107
> > > compiler: gcc-12
> > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > >
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > >
> > >
> > > +------------------------------------------------+------------+------------+
> > > |                                                | 0db6f8d782 | 0f9b685626 |
> > > +------------------------------------------------+------------+------------+
> > > | boot_successes                                 | 18         | 0          |
> > > | boot_failures                                  | 0          | 18         |
> > > | BUG:KASAN:vmalloc-out-of-bounds_in_move_module | 0          | 18         |
> > > | BUG:unable_to_handle_page_fault_for_address    | 0          | 18         |
> > > | Oops                                           | 0          | 18         |
> > > | RIP:kasan_metadata_fetch_row                   | 0          | 18         |
> > > | Kernel_panic-not_syncing:Fatal_exception       | 0          | 18         |
> > > +------------------------------------------------+------------+------------+
> > >
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202411132111.6a221562-lkp@intel.com
> >
> >
> > Thanks for the report! I'm looking into this but so far could not find
> > an obvious issue. Will try to reproduce.
> 
> For some reason I'm getting this panic when trying to follow the repro steps:

sorry about this. kernel test robot run into some cluster issues these days
and most of my time is occupied to solve them.

I will look at this later when our cluster back to normal and give you an update

sorry again for any inconvenience.

> 
> # bin/lkp qemu -k /home/suren/linux-next/arch/x86_64/boot/bzImage -m
> /home/suren/linux-next/out/modules.cgz job-script
> ...
> [   22.813623][    T1] Kernel panic - not syncing: VFS: Unable to
> mount root fs on unknown-block(0,0)
> [   22.815461][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted
> 6.12.0-rc7-next-20241113 #1 060e60d2378c08a3d0121faf43856b671a45697c
> [   22.817822][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/2014
> [   22.819655][    T1] Call Trace:
> [   22.820399][    T1]  <TASK>
> [   22.821077][    T1]  panic+0x243/0x486
> [   22.821965][    T1]  ? crash_smp_send_stop+0x1c/0x1c
> [   22.823019][    T1]  ? lock_release+0x17c/0x1b1
> [   22.824006][    T1]  mount_root_generic+0x31d/0x3d0
> [   22.825064][    T1]  ? init_rootfs+0x4c/0x4c
> [   22.826011][    T1]  ? init_stat+0xd8/0xd8
> [   22.826920][    T1]  ? __asan_memcpy+0x3c/0x65
> [   22.827880][    T1]  ? getname_kernel+0x3dc/0x41e
> [   22.828887][    T1]  prepare_namespace+0x21e/0x289
> [   22.829895][    T1]  ? mount_root+0xc6/0xc6
> [   22.830819][    T1]  ? fput+0x1b/0x194
> [   22.831682][    T1]  ? rest_init+0x183/0x183
> [   22.832624][    T1]  kernel_init+0x17/0x138
> [   22.833535][    T1]  ? rest_init+0x183/0x183
> [   22.834490][    T1]  ret_from_fork+0x20/0x54
> [   22.835419][    T1]  ? rest_init+0x183/0x183
> [   22.836343][    T1]  ret_from_fork_asm+0x11/0x20
> [   22.837335][    T1]  </TASK>
> [   22.838082][    T1] Kernel Offset: disabled
> 
> I see that PeterZ had the same issue back in September:
> https://lore.kernel.org/lkml/20240909091531.GA4723@noisy.programming.kicks-ass.net/
> , so might this be a known issue? If anyone has an idea what I'm doing
> wrong I would appreciate your help.
> Thanks,
> Suren.
> 
> 
> >
> > >
> > >
> > > [ 153.897376][ T402] BUG: KASAN: vmalloc-out-of-bounds in move_module (kernel/module/main.c:2357)
> > > [  153.899141][  T402] Write of size 40 at addr ffffffffa0000000 by task modprobe/402
> > > [  153.900837][  T402]
> > > [  153.901496][  T402] CPU: 0 UID: 0 PID: 402 Comm: modprobe Tainted: G                T  6.12.0-rc6-00146-g0f9b685626da #1 87c8486a909ba2f90eff061a4c9c1fa5c9cd90ea
> > > [  153.904537][  T402] Tainted: [T]=RANDSTRUCT
> > > [  153.905500][  T402] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > [  153.907702][  T402] Call Trace:
> > > [  153.908510][  T402]  <TASK>
> > > [ 153.909241][ T402] print_address_description+0x65/0x2fa
> > > [ 153.910663][ T402] print_report (mm/kasan/report.c:489)
> > > [ 153.911771][ T402] ? move_module (kernel/module/main.c:2357)
> > > [ 153.912825][ T402] kasan_report (mm/kasan/report.c:603)
> > > [ 153.913821][ T402] ? move_module (kernel/module/main.c:2357)
> > > [ 153.914904][ T402] kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189)
> > > [ 153.916029][ T402] __asan_memcpy (mm/kasan/shadow.c:105 (discriminator 1))
> > > [ 153.917057][ T402] move_module (kernel/module/main.c:2357)
> > > [ 153.918071][ T402] layout_and_allocate+0x446/0x523
> > > [ 153.919459][ T402] load_module (kernel/module/main.c:2985)
> > > [ 153.920457][ T402] ? mode_strip_umask (fs/namei.c:3248)
> > > [ 153.921557][ T402] init_module_from_file (kernel/module/main.c:3266)
> > > [ 153.922825][ T402] ? __ia32_sys_init_module (kernel/module/main.c:3266)
> > > [ 153.923992][ T402] ? __lock_release+0x106/0x38c
> > > [ 153.925173][ T402] ? idempotent_init_module (kernel/module/main.c:3301)
> > > [ 153.926364][ T402] ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5848)
> > > [ 153.944053][ T402] idempotent_init_module (kernel/module/main.c:3302)
> > > [ 153.945164][ T402] ? init_module_from_file (kernel/module/main.c:3294)
> > > [ 153.946268][ T402] ? security_capable (security/security.c:1143)
> > > [ 153.947421][ T402] __do_sys_finit_module (include/linux/file.h:68 kernel/module/main.c:3330)
> > > [ 153.948495][ T402] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> > > [ 153.949540][ T402] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> > > [  153.950855][  T402] RIP: 0033:0x7f0f37df7719
> > > [ 153.951869][ T402] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
> > > All code
> > > ========
> > >    0:   08 89 e8 5b 5d c3       or     %cl,-0x3ca2a418(%rcx)
> > >    6:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
> > >    d:   00 00 00
> > >   10:   90                      nop
> > >   11:   48 89 f8                mov    %rdi,%rax
> > >   14:   48 89 f7                mov    %rsi,%rdi
> > >   17:   48 89 d6                mov    %rdx,%rsi
> > >   1a:   48 89 ca                mov    %rcx,%rdx
> > >   1d:   4d 89 c2                mov    %r8,%r10
> > >   20:   4d 89 c8                mov    %r9,%r8
> > >   23:   4c 8b 4c 24 08          mov    0x8(%rsp),%r9
> > >   28:   0f 05                   syscall
> > >   2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax         <-- trapping instruction
> > >   30:   73 01                   jae    0x33
> > >   32:   c3                      ret
> > >   33:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # 0xd06f1
> > >   3a:   f7 d8                   neg    %eax
> > >   3c:   64 89 01                mov    %eax,%fs:(%rcx)
> > >   3f:   48                      rex.W
> > >
> > > Code starting with the faulting instruction
> > > ===========================================
> > >    0:   48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
> > >    6:   73 01                   jae    0x9
> > >    8:   c3                      ret
> > >    9:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # 0xd06c7
> > >   10:   f7 d8                   neg    %eax
> > >   12:   64 89 01                mov    %eax,%fs:(%rcx)
> > >   15:   48                      rex.W
> > > [  153.955810][  T402] RSP: 002b:00007ffccd7f7198 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> > > [  153.957666][  T402] RAX: ffffffffffffffda RBX: 000055cc9f9fddd0 RCX: 00007f0f37df7719
> > > [  153.959411][  T402] RDX: 0000000000000000 RSI: 000055cc9f9f24a0 RDI: 0000000000000004
> > > [  153.961142][  T402] RBP: 000055cc9f9f24a0 R08: 0000000000000000 R09: 000055cc9f9ff250
> > > [  153.962910][  T402] R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000040000
> > > [  153.964665][  T402] R13: 0000000000000000 R14: 000055cc9f9fdd80 R15: 0000000000000000
> > > [  153.966393][  T402]  </TASK>
> > > [  153.967209][  T402]
> > > [  153.967856][  T402] Memory state around the buggy address:
> > > [  153.969123][  T402] BUG: unable to handle page fault for address: fffffbfff3ffffe0
> > > [  153.970807][  T402] #PF: supervisor read access in kernel mode
> > > [  153.972036][  T402] #PF: error_code(0x0000) - not-present page
> > > [  153.973220][  T402] PGD 417fdb067 P4D 417fdb067 PUD 417fd7067 PMD 0
> > > [  153.974560][  T402] Oops: Oops: 0000 [#1] PREEMPT KASAN
> > > [  153.975758][  T402] CPU: 0 UID: 0 PID: 402 Comm: modprobe Tainted: G                T  6.12.0-rc6-00146-g0f9b685626da #1 87c8486a909ba2f90eff061a4c9c1fa5c9cd90ea
> > > [  153.978853][  T402] Tainted: [T]=RANDSTRUCT
> > > [  153.979851][  T402] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > [ 153.982008][ T402] RIP: 0010:kasan_metadata_fetch_row (mm/kasan/report_generic.c:186)
> > > [ 153.983368][ T402] Code: 40 08 48 89 43 58 5b 31 c0 31 d2 31 c9 31 f6 31 ff c3 cc cc cc cc 66 0f 1f 00 b8 ff ff 37 00 48 c1 ee 03 48 c1 e0 2a 48 01 c6 <48> 8b 06 48 89 07 48 8b 46 08 48 89 47 08 31 c0 31 f6 31 ff c3 cc
> > > All code
> > > ========
> > >    0:   40 08 48 89             rex or %cl,-0x77(%rax)
> > >    4:   43 58                   rex.XB pop %r8
> > >    6:   5b                      pop    %rbx
> > >    7:   31 c0                   xor    %eax,%eax
> > >    9:   31 d2                   xor    %edx,%edx
> > >    b:   31 c9                   xor    %ecx,%ecx
> > >    d:   31 f6                   xor    %esi,%esi
> > >    f:   31 ff                   xor    %edi,%edi
> > >   11:   c3                      ret
> > >   12:   cc                      int3
> > >   13:   cc                      int3
> > >   14:   cc                      int3
> > >   15:   cc                      int3
> > >   16:   66 0f 1f 00             nopw   (%rax)
> > >   1a:   b8 ff ff 37 00          mov    $0x37ffff,%eax
> > >   1f:   48 c1 ee 03             shr    $0x3,%rsi
> > >   23:   48 c1 e0 2a             shl    $0x2a,%rax
> > >   27:   48 01 c6                add    %rax,%rsi
> > >   2a:*  48 8b 06                mov    (%rsi),%rax              <-- trapping instruction
> > >   2d:   48 89 07                mov    %rax,(%rdi)
> > >   30:   48 8b 46 08             mov    0x8(%rsi),%rax
> > >   34:   48 89 47 08             mov    %rax,0x8(%rdi)
> > >   38:   31 c0                   xor    %eax,%eax
> > >   3a:   31 f6                   xor    %esi,%esi
> > >   3c:   31 ff                   xor    %edi,%edi
> > >   3e:   c3                      ret
> > >   3f:   cc                      int3
> > >
> > > Code starting with the faulting instruction
> > > ===========================================
> > >    0:   48 8b 06                mov    (%rsi),%rax
> > >    3:   48 89 07                mov    %rax,(%rdi)
> > >    6:   48 8b 46 08             mov    0x8(%rsi),%rax
> > >    a:   48 89 47 08             mov    %rax,0x8(%rdi)
> > >    e:   31 c0                   xor    %eax,%eax
> > >   10:   31 f6                   xor    %esi,%esi
> > >   12:   31 ff                   xor    %edi,%edi
> > >   14:   c3                      ret
> > >   15:   cc                      int3
> > > [  153.987254][  T402] RSP: 0018:ffffc9000218f9f8 EFLAGS: 00010082
> > > [  153.988595][  T402] RAX: dffffc0000000000 RBX: ffffffff9fffff00 RCX: 0000000000000000
> > > [  153.990325][  T402] RDX: 0000000000000000 RSI: fffffbfff3ffffe0 RDI: ffffc9000218fa04
> > > [  153.992086][  T402] RBP: 00000000fffffffe R08: 0000000000000000 R09: 0000000000000000
> > > [  153.993786][  T402] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffa0000000
> > > [  153.995554][  T402] R13: ffffffff864b4994 R14: ffffffff9fffff80 R15: 0000000000000028
> > > [  153.997305][  T402] FS:  00007f0f37cf5040(0000) GS:ffffffff86989000(0000) knlGS:0000000000000000
> > > [  153.999133][  T402] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  154.000578][  T402] CR2: fffffbfff3ffffe0 CR3: 0000000128853000 CR4: 00000000000006b0
> > > [  154.002367][  T402] Call Trace:
> > > [  154.003318][  T402]  <TASK>
> > > [ 154.004087][ T402] ? __die_body (arch/x86/kernel/dumpstack.c:421)
> > > [ 154.005074][ T402] ? page_fault_oops (arch/x86/mm/fault.c:710)
> > > [ 154.006242][ T402] ? show_fault_oops (arch/x86/mm/fault.c:643)
> > > [ 154.007368][ T402] ? search_module_extables (kernel/module/main.c:3369)
> > > [ 154.008525][ T402] ? fixup_exception (arch/x86/mm/extable.c:321)
> > > [ 154.009629][ T402] ? exc_page_fault (arch/x86/mm/fault.c:1479 arch/x86/mm/fault.c:1539)
> > > [ 154.010771][ T402] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> > > [ 154.011853][ T402] ? kasan_metadata_fetch_row (mm/kasan/report_generic.c:186)
> > > [ 154.013072][ T402] print_report (mm/kasan/report.c:466 mm/kasan/report.c:489)
> > > [ 154.014122][ T402] ? move_module (kernel/module/main.c:2357)
> > > [ 154.015238][ T402] kasan_report (mm/kasan/report.c:603)
> > > [ 154.016231][ T402] ? move_module (kernel/module/main.c:2357)
> > > [ 154.017255][ T402] kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189)
> > > [ 154.018379][ T402] __asan_memcpy (mm/kasan/shadow.c:105 (discriminator 1))
> > > [ 154.019400][ T402] move_module (kernel/module/main.c:2357)
> > > [ 154.020435][ T402] layout_and_allocate+0x446/0x523
> > > [ 154.021792][ T402] load_module (kernel/module/main.c:2985)
> > > [ 154.022822][ T402] ? mode_strip_umask (fs/namei.c:3248)
> > > [ 154.023928][ T402] init_module_from_file (kernel/module/main.c:3266)
> > > [ 154.025069][ T402] ? __ia32_sys_init_module (kernel/module/main.c:3266)
> > > [ 154.026265][ T402] ? __lock_release+0x106/0x38c
> > > [ 154.027496][ T402] ? idempotent_init_module (kernel/module/main.c:3301)
> > > [ 154.028688][ T402] ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5848)
> > > [ 154.029766][ T402] idempotent_init_module (kernel/module/main.c:3302)
> > > [ 154.030985][ T402] ? init_module_from_file (kernel/module/main.c:3294)
> > > [ 154.032192][ T402] ? security_capable (security/security.c:1143)
> > > [ 154.033310][ T402] __do_sys_finit_module (include/linux/file.h:68 kernel/module/main.c:3330)
> > > [ 154.034478][ T402] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> > > [ 154.035532][ T402] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> > > [  154.036819][  T402] RIP: 0033:0x7f0f37df7719
> > > [ 154.037865][ T402] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
> > > All code
> > > ========
> > >    0:   08 89 e8 5b 5d c3       or     %cl,-0x3ca2a418(%rcx)
> > >    6:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
> > >    d:   00 00 00
> > >   10:   90                      nop
> > >   11:   48 89 f8                mov    %rdi,%rax
> > >   14:   48 89 f7                mov    %rsi,%rdi
> > >   17:   48 89 d6                mov    %rdx,%rsi
> > >   1a:   48 89 ca                mov    %rcx,%rdx
> > >   1d:   4d 89 c2                mov    %r8,%r10
> > >   20:   4d 89 c8                mov    %r9,%r8
> > >   23:   4c 8b 4c 24 08          mov    0x8(%rsp),%r9
> > >   28:   0f 05                   syscall
> > >   2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax         <-- trapping instruction
> > >   30:   73 01                   jae    0x33
> > >   32:   c3                      ret
> > >   33:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # 0xd06f1
> > >   3a:   f7 d8                   neg    %eax
> > >   3c:   64 89 01                mov    %eax,%fs:(%rcx)
> > >   3f:   48                      rex.W
> > >
> > > Code starting with the faulting instruction
> > > ===========================================
> > >    0:   48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
> > >    6:   73 01                   jae    0x9
> > >    8:   c3                      ret
> > >    9:   48 8b 0d b7 06 0d 00    mov    0xd06b7(%rip),%rcx        # 0xd06c7
> > >   10:   f7 d8                   neg    %eax
> > >   12:   64 89 01                mov    %eax,%fs:(%rcx)
> > >   15:   48                      rex.W
> > >
> > >
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20241113/202411132111.6a221562-lkp@intel.com
> > >
> > >
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > >

