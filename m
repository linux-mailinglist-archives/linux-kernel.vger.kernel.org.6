Return-Path: <linux-kernel+bounces-293056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A89579DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAE51F2206D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F001667C2;
	Mon, 19 Aug 2024 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPxVnj++"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C91B657
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724111928; cv=fail; b=JIGdZGPSCCXTuT6LkSUWyi0x7t5tSPVP8QOqNiRUWFn96CWgQqVn++BFdYHPCyCU/vb8yJLSSKQR/wD236jQO0BA+j51bljcaW2Vla3HRVZaod7zqLGFU/bu5tUmn3IJqVFbjgiRbHaSqeg2DhiZK+XK5pdY7HgwdCdBWzDq4aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724111928; c=relaxed/simple;
	bh=8v91hsCe09PofRr5nJ3eIfYAIutMdo0wyW4J4L5oSZo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mdHeyximPmX8VJOZX4mDoUSUP9zxjGeTfasyPcssksLb4HS7fXdT/eKUPdumUBUO62ztr8sjZyhA1NSuw0rmTufqS6wPPGEo3r+UwO58yFOwZC7sl9W0T5mAGj8IgyF9Bk5feBap/MQN90vYeowacAWk1OEdhTWnUMU/bnq4Ctw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPxVnj++; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724111926; x=1755647926;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8v91hsCe09PofRr5nJ3eIfYAIutMdo0wyW4J4L5oSZo=;
  b=VPxVnj++hW1lSv3N0IEpjShIxghfITD2N1fwEV8e192sVnJqRG0DaylR
   0yMVJ/AoNldhDDu7GdaI2vwTsG/veUZF7zO9oCYrWr19d28SoT2BRmvZF
   SfdmEmwQCLbv1xKqg7lT9tKA/KF6dT3/bp0cyTLBfdsy7X2TjakYVa3UQ
   1Fv1QPCy0zyYs+KOOwZ2GnX+trzT4aWSk5TzPudU49jZmfXx6gfCWF/By
   PB83ZSVud0yUv96TAvR5Yfb0CcoAQA3bYnVBUoxcseNF1jhKAYTA73XEj
   wmpdoR3hMmw3f1OVjGN/t3CmCMQXCQ9Ei++/gAxuWknVYTB0/upHaLMW8
   g==;
X-CSE-ConnectionGUID: xZz5eybDSPuERMdCBWRvoQ==
X-CSE-MsgGUID: tpAiSpq6RTyvdR2/EIE+IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22268484"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="22268484"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 16:58:45 -0700
X-CSE-ConnectionGUID: lSfCrgL1Qe6pah5DgmdIOA==
X-CSE-MsgGUID: 9Qwet7WBRByyW8giDQeW0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="65350067"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 16:58:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 16:58:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 16:58:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 16:58:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 16:58:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAcQU47U1Pd5rb3xD+UAg1iYO9T9T46mbh7IC/3GRFM5+NGa76mK1+VUoQBnUCzYD9VnipZXQGM0ghs5bNGt5miblzmPksDhYVJnLbuamGHcLf8sdxGMIbwRSxX7TlW5xk5tyEs+FWASQ2el95Rxhq+c0sHGsG6NCalcUP0a+xOey86YkYtGj48IT98Qr6juG0L7FFTGiQ+mZ6bkkgt7FRbakJFpGx7CRMfDtY6IwTKbxfnpUpb2Hjk1s9NM2oQfFEEYqMeuqcXWjj1ghz4LZASNPytM+6FxBrnh4vxeKHbslVS01/+fL1kOAwGksyy5WiDXIvlPw+djPloxGYeIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CD2QCXbjgu0zwHzUOOYhX/IOFHzbcBmHGyaaKYrZe8=;
 b=lqrV2xOGINbk9cY8ILf4XwN3xHaLeXqLmS0chJeD+Lc8V4rNkC0ipQg6zxouWJ3lm+5VqbSnbQuPqy5O3XNBL8L+nHoSLtKqAflzwN8yDnKgHxBV6V51T97BO4T0Omnj6gTP+rMzTKAKf6uL+Dk4A5o+Gi+ALL22neX74NUs5ocIjY3YQWcj6R0gb4KPBPqrQLzfb48bkAdEsMULXscJ2p9cMDxib+b8M/qrcDT5NgLAVZS4AfeCLRmlKguAovvKQ4yW8UKgWADuAL0EgyJaPghFNfmTPcaKsOrwxd+/bQJlNXpJ4T4LTFm70msFfA0oMwA3NjFbfZ4i3nZwe5Wn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH7PR11MB6699.namprd11.prod.outlook.com (2603:10b6:510:1ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 23:58:41 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.7875.018; Mon, 19 Aug 2024
 23:58:41 +0000
Date: Mon, 19 Aug 2024 23:57:25 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: Sergey Senozhatsky <senozhatsky@chromium.org>, Lai Jiangshan
	<jiangshanlai@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <ZsPb5aEVL1b0PMs9@DUT025-TGLU.fm.intel.com>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
 <20240815070900.GB12106@google.com>
 <20240815072427.GC12106@google.com>
 <Zr4lN63t25Og5/0G@DUT025-TGLU.fm.intel.com>
 <Zr4rosIiK2a0sGhc@DUT025-TGLU.fm.intel.com>
 <20240816023831.GD12106@google.com>
 <Zr69QOysEfYXkMwb@DUT025-TGLU.fm.intel.com>
 <ZsO1-gCkeGuskOnT@slm.duckdns.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsO1-gCkeGuskOnT@slm.duckdns.org>
X-ClientProxiedBy: SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::35) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH7PR11MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 7519d8e4-aa83-4854-7d34-08dcc0aad9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?srTDTgK2i8FtnlYcjmEWZFUJsXF0jqV62Bv+0pteU1bBr7Mi7ICvhK2HPPrq?=
 =?us-ascii?Q?GNtYppR8E2yPryQBSbVTqAVA61SnTYLGtQQPe9DSjCAew2YEvt1MiQfUNK0O?=
 =?us-ascii?Q?Kt5lB7yXmwAtyRQNnIpVaZkEYlbvvJlCRzCfYOnyqwp70Xmqu4MX2NkkfUrM?=
 =?us-ascii?Q?Tla3cphh+ES/vqx3oyuVpqHUI0fbITaLj4xcc/C2PNQ9MCph0xqVS7II0Lyq?=
 =?us-ascii?Q?eu4w5xuP1MmBptmYHIqwXkTH1YbamHWpr9HP350UC2cRAQaSvtom9jsCp2jE?=
 =?us-ascii?Q?058SH21UDebxzdAofICMVIQYRTeT7nfFpiySRNgT/w0AbD3vDfmfDlOynVbM?=
 =?us-ascii?Q?Lw1ji6QH5MSkj02wRHxc/6TMXoDm76oYlqAXA1unne2WMtDdaZ8SPUNCY4TW?=
 =?us-ascii?Q?s45dwejjtiEYKVvI4p7IMZFd7Pzg3+9beb3bLRLm1Y1gNQHcepx/4sJ+ZYAn?=
 =?us-ascii?Q?RFspCEjvZgdwMACLh/ahAEV1JTLkJCHkgf2Oh0hkf0wbrkqYB2hYJr3wK0oU?=
 =?us-ascii?Q?D6Yd30MMFCTL8u/Xbws1RTYPJ9v4npeaYfDTJUVgD3U8s439A3Pp+Uyj9wWT?=
 =?us-ascii?Q?uB2V+2irNXmJY6Wimlpw5yXNtqdbigK1sTGoXl8QQyAOLGfsxNNWwjGKBY0r?=
 =?us-ascii?Q?OHQ5eqWWmFi5F7jW/bi1L0uoh47AlyYFXX3d2ExHuj0CeZRKPx7UrpdqRNeo?=
 =?us-ascii?Q?zYhxiEOqrYuR9NXngPr2mAWYFHXxgbikpi0eSWriQWb1oCg5cQ5S/qFBGas5?=
 =?us-ascii?Q?tr4vxa224rClM2aOUuPL01+LVZOfdhPIU7MaFjdG8qmVsOhQlDJFTB7//5kS?=
 =?us-ascii?Q?YoeIlm8A9Fk4cyyWxqYtw6zv2c4fgPVy/9R5SVSHLE6lI4wUHurvKTbAeNUC?=
 =?us-ascii?Q?dyavisb/L3OZd/xxKg+3Necxf5YkakGRzBvbbVwNUl4emmNs4PT2p0Tl0aE6?=
 =?us-ascii?Q?szDGR7aklXvYNAa6LH8EUYQeQ/hdY/4/sdA8BoybPrPGf8gIj8hTT/Yi4nBh?=
 =?us-ascii?Q?ax63ValBVYAB39AB17i7qmUJptCkwKm4kPTHEddWHudpMK7I1OG5tln2Haqh?=
 =?us-ascii?Q?Z8hqGbut0L/j+wb4DS59APR20+SCpQ6qwsf9nxVJcrj7p5QwM0F3w8NafCo9?=
 =?us-ascii?Q?CK400ckvb6r9C9axhrMRiJxzxT+2GKvoswsc9HeaNyrS0KCbVul6o7qTUZZw?=
 =?us-ascii?Q?wqhZ5qq6gdGBU1bgdeOtiWsPCvrl5U5Stm8Z1+3t223RANfTN5K2ExYgvMBJ?=
 =?us-ascii?Q?AS2fD+ZVWehV9oz8eqUCjLBCrBbcqMU+XvxUdxZf4rvsN6rXTKGnx35dkbgL?=
 =?us-ascii?Q?MoszFEpi1b4K+5NGVI1EGqbo/8Fs8mtldEO6X6K2/mMywQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1rL6RZARNDSW7VrKF6RESxLSZWlDqZ7eEDCzhA6HVTE4qoh3CsXXHYOn5JQz?=
 =?us-ascii?Q?meu6vkSz5CsR7tAJD0/JECQvpVgxk4Gimwa6YvaEfLLw/kkWDqDXJmwObNmn?=
 =?us-ascii?Q?l8mm0SQco0n+E0YckJ6Em76YU3+1Asba6wD7DVlZK4YiSsAIVe+Bt0nOZCpZ?=
 =?us-ascii?Q?EqvH7hscwee4GdYlzTUJeIx0JP0bRwvPPEnxgh9fGKVFQiTzTBUJzMToUJM1?=
 =?us-ascii?Q?xhmSX1LmjoNZHSMTA8jP/rt84dy9zq1S9AG+aa6OhTVp/VIeKk2Ws0THMmod?=
 =?us-ascii?Q?tU7AwyMuiabgHkYiPfByGzKzRaUSHf4PYYhmFHc4bje8mMZVImSGEJ3PNdlW?=
 =?us-ascii?Q?p6P8Qskp26+MPrST5RBLY9dyqrdnlW4dImfW2VRD2qT/iffOcsDgmp0u6XJv?=
 =?us-ascii?Q?ybYt7ExSKSn8fG2VTq0VY+9Aox/m7LI/YWVDK9k91zPC7IuiuxWvg5Q+Je8a?=
 =?us-ascii?Q?eL7Nyq8dkRsufoilJo+wcJNRqLONMANB0+clFtzxOdqhSLWxV+RIUAGSOVp9?=
 =?us-ascii?Q?f340C9DeypzK0EXRx0PTT62z9YtP04uflZA42+h4XLYcjJCLbLtA5mpSRV8C?=
 =?us-ascii?Q?RU9gq0go6an+Rw+yHy5vyB8bGFsMeb5b10mnduhoT8v+PVjAGykhoA7D0JVW?=
 =?us-ascii?Q?+b7BVuwxHpsJsAIIn/YE8d4XqqnTRM4Tb2DS/LYXYMnP+L314oN6l4YStSpt?=
 =?us-ascii?Q?fbRQM6WveEA4R+s+EdZl6DKYKGcGhxNhVkXaHjevfs+4r0LLTQf00Sw5bvsJ?=
 =?us-ascii?Q?LJ6nGLcLpxpBGe5S+BTwI1XeRXjuOpK4GcrwfdJH1GRov7g0NbB41DZQUxZD?=
 =?us-ascii?Q?EFZ0pFAKTR0obTrRgPMeUGEYQI/JKWnvnZX1fE6aqwQtKJBH3VlGjb5n8Q7r?=
 =?us-ascii?Q?41FtBHyssuAObFzzJnciUR+TydwSnS+6RZ+nl7jsUh7FbsMWDou6AIhXxaDh?=
 =?us-ascii?Q?TyTrCuWa0lmlScVXVIMBn82LrAaoh5hTZ72mTkrAtwmkk3EbTLh3wjIf8Nz0?=
 =?us-ascii?Q?T2/fq7u+bLK/JRa7oL2c2V1xRfLwhABPpHOYHvfSj1D3f2AFvepYhNCiwoiY?=
 =?us-ascii?Q?yge2ay2adEQMOl1/CKFsY0aoaWTQ6gHpIvVffpM/1wNgBDt3Y9/206Wq/VU7?=
 =?us-ascii?Q?SUjHGuKJxb7CtSdj/SMX/01RWMDp8tSWT7JbI4Pq5N0R+Fe4JW8OWlO7j5fp?=
 =?us-ascii?Q?0oTg+19mvVmrz663QIr/9KPJhKhQaA/h9EU1PeMs1EF5lBBPKoo6eIlznwLb?=
 =?us-ascii?Q?Iji7JFEJMXdbxbx89EBXE4ywR1Xlg7C4S0fxsNVLnq/NuBJNUb5nqtscK/1G?=
 =?us-ascii?Q?n4sh1ywQniyf0baJwmhLR3kIUJygaK8ZTlyDlpPfQaysdK8DG90HZGHCZtN9?=
 =?us-ascii?Q?SJSXOQI5NLeHNGSxZkFlf55xlmSFCfD4rAn7YbJoDArywqjVRbECYpY22S8b?=
 =?us-ascii?Q?ChU4znRYrsF8ugB9yryUZFTq1R719wlQFiiFlPhvZWWq0VONusDyzbRHrVBZ?=
 =?us-ascii?Q?ZtbrmQcbrXDqLCokOlec4O9rcrUcB3xKbY0z0h/v/dgzssuIX9SfBKDcpGf4?=
 =?us-ascii?Q?O9R3cykGFzjxUuqIkDcXhP9uQo3592fhcAGdll6zZA09q/GUQSaX8fZUCQmL?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7519d8e4-aa83-4854-7d34-08dcc0aad9eb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 23:58:41.3685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OGY76ilpoF9xkIeTC+V1FePWbz9gCSqDLBT0A0qG2bPgcOec5wKH+6Apdf7ys7sOcaCUQjQ4K2L6H0A+TuYaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6699
X-OriginatorOrg: intel.com

On Mon, Aug 19, 2024 at 11:15:38AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Aug 16, 2024 at 02:45:20AM +0000, Matthew Brost wrote:
> > > Tejun, how do you plan to handle this?  Would it be possible to
> > > drop current series from your tree so that Matthew can send an
> > > updated version (with all the fixes squashed)?
> > 
> > Tejun, yes let me know how to move forward with this as it is highly
> > desired for Intel Xe team to get this into 6.12.
> 
> Can you just send a fixup patch?
> 

Yes, will sent one out shortly.

Matt

> Thanks.
> 
> -- 
> tejun

