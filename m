Return-Path: <linux-kernel+bounces-260686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1E093ACFE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2647B2218C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5106CDC0;
	Wed, 24 Jul 2024 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgHaAOr0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CE54670
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805059; cv=fail; b=N1XgyBw/9w1lzm19Okvf8b56u7L0xYyIHy+LlAdvVVsSJWEY6HO2g0un90bnc3+yWnp2RgPB0/gzhox2sG/lwqsFaDp/KXNcMILbl8a24T57lgJrFukRIMgYgQnXfe04UFYvoIp/m+fsbY2dOv/Eb6alDpS20mlNocFi9VKb7CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805059; c=relaxed/simple;
	bh=HnkD6SssZ9tSfkbybBxoWaIOJko+A0jcBtdlZUYQc7Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lWztKO1XsXX7oE/l2NZhRr8C61mqeXYi25qzLXukKmfKyw9gpJBGMz67PC7CKUcyrqj8nTonMIcea1fCLF1yoNp3AB91/UGpvl/vREMu73aZOzXXo3enuXiu5qLTnWtNiUgp1IvT2q0fmYc/EctYgP29n/CpbZ0maXn7jRduaaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgHaAOr0; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721805058; x=1753341058;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HnkD6SssZ9tSfkbybBxoWaIOJko+A0jcBtdlZUYQc7Y=;
  b=JgHaAOr0f3V7hwJR6525ckWKSrQV9x97QuJxnXltGxRmOKhZhd09A3SR
   t97al+hOy2t8bdxcvU1yX4i1RaaVV2//yQdmjqTSDdRJ3Ej8GP3Gmxh8u
   m3aO1mVZu9qSgsPA3dDyDu66RLG3rIVFvQTeNRXWnA7Gt3/xOtmCCjoMX
   FCt5eG6buGGNPRWYJ1yxTqD86kRP6LPrPoJH7bbntQoYqjfd58KMmFizA
   soWyYNUpKeU3QCxKQR5AgY4Fr/EscFA9459hdVSC96Jzcg+fKr/Q9ZQ+k
   m3yaaeOJMsh+Os3S1Woqd0lR/s1J0suX9FTC6/G7hGWoEaPWPLDX6uNu6
   g==;
X-CSE-ConnectionGUID: Kb4AskNVT+mVb9uDfQ0Auw==
X-CSE-MsgGUID: kr64Qzx8TYKJY8NzbTmOTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="41991291"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="41991291"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 00:10:57 -0700
X-CSE-ConnectionGUID: Jaqs2gdwSwmsriONlt9YZQ==
X-CSE-MsgGUID: U0qnBYbpS2acQfFWl3f2JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="57313532"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 00:10:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 00:10:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 00:10:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 00:10:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iW3cw+YLtPjdXj6X6MHN+vSrs1yPvUwjvvXtMadyD2m4jabfyKAIV92gNKab2yzqkHJSULBAN+qujhit4JIlaISdQ6xvrSXiZl+HZf4K/Zu1Q371uFOBEzRZjMPg/ZFHbBAzDXFOpxgj7noVy5DGzVOfo/JqyVvybxdqzHrTtqLAbSFAf/BRvfTd3BBqZa8AMiQcIbTvrr0+OtB64u2NC3PngCKGXjYZwUjxSYUJwBD9HBCsGvcHXaypbM9RqVDJO5SXzp+Lf3LDwvLaPhTnKR6/njkAneAeVC7CtlB5vkwIpQSt7dUGPEzt/2Y7u+cQU5qtXFlo79ZoWEhF1nI42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2WW+nfgFyVihHqWDMgz9+SJdIAhfKT0P1djoybtBEw=;
 b=jBYMcGPiWNv8pLM2VdTUGB6b3m3k/MqiVSBwBaCZMsO95vrjPn5rfyvjhpYMAdkUCfyA5KXeNiCFcINp+wg5LGZjlxci/pWhoEbKmYqhGk27hKDugbB7hLZK9RH0/ElBlz7YgKq7z5+CbpGH48EwAyoy6VJJ/jmGKAryorGP0l6CKIilrK7plAU+SBVSDYUxZSR9rAb57AXHKMZZ1UxKQkcADJRW7P08mbtLSwesF154ETZHKsmf5hU5RM2C4TGdFt2IEg1Kl+bULAI+PYy9V7rA6Mq8rRQpxjEMLSmFReDkSjRcm+aqF2yRJmEwn1ue7w5M3Sn+5og3cKL7bviptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 24 Jul
 2024 07:10:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 07:10:52 +0000
Date: Wed, 24 Jul 2024 15:10:36 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Dennis Zhou <dennis@kernel.org>
CC: Boqun Feng <boqun.feng@gmail.com>, Tejun Heo <tj@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, Kees Cook
	<keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, "Andreas
 Hindborg" <a.hindborg@samsung.com>, Benno Lossin <benno.lossin@proton.me>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, "Christoph
 Lameter" <cl@linux.com>, Gary Guo <gary@garyguo.net>, Miguel Ojeda
	<ojeda@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, "Wedson
 Almeida Filho" <wedsonaf@gmail.com>, <linux-mm@kvack.org>,
	<lkmm@lists.linux.dev>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [mm]  24e44cc22a:
 BUG:KCSAN:data-race_in_pcpu_alloc_noprof/pcpu_block_update_hint_alloc
Message-ID: <ZqCo7H2gcA1dvIr4@xsang-OptiPlex-9020>
References: <202407191651.f24e499d-oliver.sang@intel.com>
 <Zp6bMoDnUMxNrKos@boqun-archlinux>
 <Zp6cVgXJlzF4VOwl@slm.duckdns.org>
 <Zp6e1PWZbz4pkh9Z@boqun-archlinux>
 <Zp6kpCcQRPTGk1LK@V92F7Y9K0C.lan>
 <Zp7G4EfISRwlmmIT@boqun-archlinux>
 <Zp9EvUTqni5wMDlC@snowbird>
 <Zp9JIvoRVaa+w5OT@xsang-OptiPlex-9020>
 <Zp9J9t-KP17P-OFR@snowbird>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zp9J9t-KP17P-OFR@snowbird>
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW5PR11MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 588ad149-77ae-415b-3238-08dcabafc097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9IcMisVKV28I8BAeP40S3fpUVdHL1B+yJcNhG4lDD755Cqqw3f1BtDvixXQx?=
 =?us-ascii?Q?nEivLai5AN4+/cW66iqCmyYyCFwd/oX35tPR+iQaGKVbyJ/VUpCxsOS+n+BL?=
 =?us-ascii?Q?E3JDvDfoEjOJU2fj7M5yPWm+VdsobQdGyJa7Ahv9427Zm2zey/3U/0Htgfka?=
 =?us-ascii?Q?SBd4++EhqM/hw6qtTBE94rJ7dkNdxYVQT5AlYXGDXDGf8bW/iO3Z13N5qEf7?=
 =?us-ascii?Q?KxFUncrQsyl9hkWrQh2tnyj7obGqAOGcUHuEfSasc7gpzbgTDP3RRxP68XoG?=
 =?us-ascii?Q?muLZcfNopqBrUpH2S+QNfgmhKh65bucY+6WQgJYv+c7Gy8jdQ/Uj/2BTrBWi?=
 =?us-ascii?Q?t4bnLkjTHJcjIBFEn8V0eTxc6SwL9Zk1AEcnE17DiSMb4DNdO6R5qQZ+VdB8?=
 =?us-ascii?Q?f9sxzJKTMWOzzDphP4qjcC7RHKmykWD6PGvbV4DuTfpZdehzZEnheEP0lk5I?=
 =?us-ascii?Q?FAGO3Lgddz+IpxRMW1jeQ2TRYsVItQ4NFzk8wdp1Li5K+JMT86jW2yRQ7vgM?=
 =?us-ascii?Q?vn2J7s8fgsDCOxaNwS1n4IPvlGUGzYnlrzYETkwYB4JK6eE5TXLNhd0o9+HU?=
 =?us-ascii?Q?LqALYuwypkzNqSGHk+rphKsW+fMykX+ptRzsdXL418fn2mPMiVCu9rFvAnr9?=
 =?us-ascii?Q?SEbxXZRdhmgmOehPEKsMjVGQSYIOP/EEG7velvNdLaT4o1z0fM8yRguh1825?=
 =?us-ascii?Q?/3GVOiLkT4YxmyA0D8brclc3iAaiGCdXWqOcbH4A8NeFmZ3+SvBjh+hlfaY4?=
 =?us-ascii?Q?ZVRGEl8PcLMoo3+yDpAlNYFIxs7Eesw6JlFymtuQ0N5++9ICvXVb6BbLhkv3?=
 =?us-ascii?Q?OEsbMqTW5HX4vkt5MxSz/o0fumROs7xclmecMNJyGo9HxbarWj0lk8pCazSI?=
 =?us-ascii?Q?FAIJsZdWoLrk62zEQi0RaKoWc8lATXgLXCbgeqoQNCsJlQUsxY9vWEHAI+Np?=
 =?us-ascii?Q?TbrF4QlGRqte40Ar9gYgPQUle0diE3f7EY2XzmS9tc60pKnHAWNeF47k+8oa?=
 =?us-ascii?Q?SqcNP+mnlzYBjKOSeCRqxQzlTHWWS/iAJaq61MnZqjVVM6YpVgco/+HinFPb?=
 =?us-ascii?Q?iOcJckaU9L3sBDbqVD3+6bWiMFhDOlmP7AgFvyEmDyotPGNBszNzI5VRqsri?=
 =?us-ascii?Q?OgIELbgoxMpvbajqWRMAwMY9dtzGoz+PbvYfuTG+SqAWQdahiWQ2fT5G83Q3?=
 =?us-ascii?Q?etQMdtdgNXWzaBtsLagAYI+43an5iZfJntPQ3yV+Ke7FSgsGIJ566AF7rJkK?=
 =?us-ascii?Q?CsO9RMztbBZfFeHIhvIZr9O4jOswINei6Si2bKrhgVLNfE3PWQRra2gcu2g0?=
 =?us-ascii?Q?ljHBtwdnOgsH4C9jOTbnhKHAQGg3T7SUyRtaWnl66tEodA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5tXMQOW1qCtIJgIx5Nx74ITKiIrtSe/lGI2D4x4YqLxYVzaDQn3CWiilyKum?=
 =?us-ascii?Q?eVUew2e4RynP4vKvZw+efLU9zHg6BPFu+OMvGAXrRgTid7jRMB1DCyByEC22?=
 =?us-ascii?Q?12gX0SIAHqhNFFX+dn6AiTT3FfB+MuKvGTYk9M1p/r3ghiLOg637ulSnwPU+?=
 =?us-ascii?Q?APNuGdo3upoy650cMfxgALHhfQAVDG2AXQc8MNKN7FxDfvPxjZ+89fLHW2Hd?=
 =?us-ascii?Q?WbePWqSE5FsbTzS/kJP6yC22q+ehHtwHvNyxHzmg8R96TMJHQdZpLHgZSCU2?=
 =?us-ascii?Q?NMECqBkuX3bQGZ9/NDpa0bB8P3eqkckvuF/BCoPN25hjekE22ciRYbIZYM0o?=
 =?us-ascii?Q?NF3EcrenNRviG4b+trHqE2NNOq6gVmmgswz1GH6HhY/r8fMzx8anj+Ai1geC?=
 =?us-ascii?Q?L9zDgB3oE7l95SMj3jcfqDODHx62qWPHl91ZJYVcxAWnS/KkAxr74aQJzW1C?=
 =?us-ascii?Q?3PyJvHXtH6uJPEwnOJkjiyi78PWWWh4rLTSPoWTIOdDL/2NoZG6tTJEOqXNq?=
 =?us-ascii?Q?SCbOrtwIthHEUhkx2SkCTS8TUQ5ugf5DZJe/WZmA+9uCga7ydwrdqxfxWiVe?=
 =?us-ascii?Q?+S+hWB2La+FsDdxMIMoHdeZil/A8qE6i8HRGOEVa/HE/+RLg3eHn9kf6zOD/?=
 =?us-ascii?Q?UCekYsrQiG4u22hAmRSsAsTmaG3jyPFAftSahjF073Xk2/lrp443t/ht+Dwu?=
 =?us-ascii?Q?idf+YQVc9HtzkpSm/I4TnRelYgfWdPA9BXZLzW7xTd9BdkPwuJRsQxWsAOpK?=
 =?us-ascii?Q?06sQNZMdOcVkavwIgLnxfGX3gx3rCI6Uc7AXcLsDnpwLoyf9lFfbgGoorVT9?=
 =?us-ascii?Q?3KovujvH3uR3KxgtO8ug7M61nsbASK2uLrdw8KGI2AtRbrdPG6ZUHmw2Bql+?=
 =?us-ascii?Q?bZA5JqUvzbzlzyyuGMgg+Ndi6ni95qOzqnTBVppg8Q/5yCF0gvDAKkeEtW/Z?=
 =?us-ascii?Q?QRaCo2IOTWJHXkcsbNQux6gHlDfC57nmlEYM/wzbVrLMXDe1CNbpPyJqC7jn?=
 =?us-ascii?Q?lN4LNJjdzpOUfYidoNXAzmjFzNH26eZJHBcOOtGc8SqLr66MDgb+JDgQ7Cua?=
 =?us-ascii?Q?9ziTuduJqPbge1XoopxB5t8Afn6GoBnAAmcTS4wgdnTdYWHgIEN5wq4ZJjZR?=
 =?us-ascii?Q?S4SFem9CRMS7ttOWk0XTILnghr6b4jiZLumzCVv/3zHR/OM2JtDvBAqer5kP?=
 =?us-ascii?Q?8HcdeTYkmq7tG4PmwP8n47vGnlhl7UjM0gw1sxnhjfpK/7dh+kDnawpxPSY+?=
 =?us-ascii?Q?sqGxT4yZpm0L7OjaRhoFrNliHl5H7LqJc9ynOz6Eagocchb/RrNUqnm+rhG8?=
 =?us-ascii?Q?E9i/RUVMxXYBBq7K9yoPkUBbIK3RyQaKYCk8R/CoCx96xweSHEutQmwrTk0P?=
 =?us-ascii?Q?5pPcEa9s9qSyMWL45iyXhiOnIDTpz2DznrGa+S3NPiy+sw51BWyCwjf44r3V?=
 =?us-ascii?Q?vu3hpVzoWzwCwD4iV9YIx3r4jAWdLZlsL6n4k4Jy44tjNEyFcsLNHdrehulG?=
 =?us-ascii?Q?PbRi6YA4Z2Yn9VmuJjScWEd8TdUKIXYLor/Aau2ETVUqDrCZbo+jimhnsdq2?=
 =?us-ascii?Q?5u7FAZFYbMWIjrZ//7z3SDPfo5wDyPcT0HdFBJ9J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 588ad149-77ae-415b-3238-08dcabafc097
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 07:10:52.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6p5VLEIO1zA/hjFhj0pI9sjWUkYxP9wasql24eTHI8YTty4ph/KAU8jqit0NYJWxObYKdHZeqDSH9ID8nQCMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
X-OriginatorOrg: intel.com

hi, Dannis,

On Mon, Jul 22, 2024 at 11:13:10PM -0700, Dennis Zhou wrote:
> Hi Oliver,
> 
> On Tue, Jul 23, 2024 at 02:09:38PM +0800, Oliver Sang wrote:
> > hi, Dennis Zhou,
> > 
> > On Mon, Jul 22, 2024 at 10:50:53PM -0700, Dennis Zhou wrote:
> > > On Mon, Jul 22, 2024 at 01:53:52PM -0700, Boqun Feng wrote:
> > > > On Mon, Jul 22, 2024 at 11:27:48AM -0700, Dennis Zhou wrote:
> > > > > Hello,
> > > > > 
> > > > > On Mon, Jul 22, 2024 at 11:03:00AM -0700, Boqun Feng wrote:
> > > > > > On Mon, Jul 22, 2024 at 07:52:22AM -1000, Tejun Heo wrote:
> > > > > > > On Mon, Jul 22, 2024 at 10:47:30AM -0700, Boqun Feng wrote:
> > > > > > > > This looks like a data race because we read pcpu_nr_empty_pop_pages out
> > > > > > > > of the lock for a best effort checking, @Tejun, maybe you could confirm
> > > > > > > > on this?
> > > > > > > 
> > > > > > > That does sound plausible.
> > > > > > > 
> > > > > > > > -       if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> > > > > > > > +       /*
> > > > > > > > +        * Checks pcpu_nr_empty_pop_pages out of the pcpu_lock, data races may
> > > > > > > > +        * occur but this is just a best-effort checking, everything is synced
> > > > > > > > +        * in pcpu_balance_work.
> > > > > > > > +        */
> > > > > > > > +       if (data_race(pcpu_nr_empty_pop_pages) < PCPU_EMPTY_POP_PAGES_LOW)
> > > > > > > >                 pcpu_schedule_balance_work();
> > > > > > > 
> > > > > > > Would it be better to use READ/WRITE_ONCE() for the variable?
> > > > > > > 
> > > > > > 
> > > > > > For READ/WRITE_ONCE(), we will need to replace all write accesses and
> > > > > > all out-of-lock read accesses to pcpu_nr_empty_pop_pages, like below.
> > > > > > It's better in the sense that it doesn't rely on compiler behaviors on
> > > > > > data races, not sure about the performance impact though.
> > > > > > 
> > > > > 
> > > > > I think a better alternative is we can move it up into the lock under
> > > > > area_found. The value gets updated as part of pcpu_alloc_area() as the
> > > > > code above populates percpu memory that is already allocated.
> > > > > 
> > > > 
> > > > Not sure I followed what exactly you suggested here because I'm not
> > > > familiar with the logic, but a simpler version would be:
> > > > 
> > > > 
> > > 
> > > I believe that's the only naked access of pcpu_nr_empty_pop_pages. So
> > > I was thinking this'll fix this problem.
> > > 
> > > I also don't know how to rerun this CI tho..
> > 
> > we could test this patch. what's the base? could we apply it directly upon
> > 24e44cc22a?
> > 
> > BTW, our bot is not so clever so far to auto test fix patches, so this is kind
> > of manual effort. due to resource constraint, it will be hard for us to test
> > each patch (we saw several patches in this thread already) or test very fast.
> > 
> 
> Ah yeah that makes sense. If you don't mind testing the last one I sent,
> the one below, that applies cleanly to 24e44cc22a.

in our tests, you patch could solve the KCSAN issues. thanks

=========================================================================================
compiler/group/kconfig/nr_groups/rootfs/runtime/tbox_group/testcase:
  gcc-13/group-04/x86_64-randconfig-013-20240713/5/debian-11.1-i386-20220923.cgz/300s/vm-snb/trinity

commit:
  60fa4a9e23231 ("mm: percpu: add codetag reference into pcpuobj_ext")
  24e44cc22aa31 ("mm: percpu: enable per-cpu allocation tagging")
  dcfbb68202759 <--- your patch

60fa4a9e23231721 24e44cc22aa3112082f2ee23137 dcfbb6820275994e92a9dcf309e
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
        281:999        -28%            :998        -28%            :999   dmesg.BUG:KCSAN:data-race_in_pcpu_alloc/pcpu_block_update_hint_alloc
        296:999        -30%            :998        -30%            :999   dmesg.BUG:KCSAN:data-race_in_pcpu_alloc/pcpu_block_update_hint_free
         25:999         -3%            :998         -3%            :999   dmesg.BUG:KCSAN:data-race_in_pcpu_alloc/pcpu_chunk_populated
           :999         29%         292:998          0%            :999   dmesg.BUG:KCSAN:data-race_in_pcpu_alloc_noprof/pcpu_block_update_hint_alloc
           :999         27%         269:998          0%            :999   dmesg.BUG:KCSAN:data-race_in_pcpu_alloc_noprof/pcpu_block_update_hint_free
           :999          4%          44:998          0%            :999   dmesg.BUG:KCSAN:data-race_in_pcpu_alloc_noprof/pcpu_chunk_populated

> 
> Thanks,
> Dennis
> 
> > > 
> > > ---
> > > diff --git a/mm/percpu.c b/mm/percpu.c
> > > index 20d91af8c033..325fb8412e90 100644
> > > --- a/mm/percpu.c
> > > +++ b/mm/percpu.c
> > > @@ -1864,6 +1864,10 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
> > >  
> > >  area_found:
> > >  	pcpu_stats_area_alloc(chunk, size);
> > > +
> > > +	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> > > +		pcpu_schedule_balance_work();
> > > +
> > >  	spin_unlock_irqrestore(&pcpu_lock, flags);
> > >  
> > >  	/* populate if not all pages are already there */
> > > @@ -1891,9 +1895,6 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
> > >  		mutex_unlock(&pcpu_alloc_mutex);
> > >  	}
> > >  
> > > -	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> > > -		pcpu_schedule_balance_work();
> > > -
> > >  	/* clear the areas and return address relative to base address */
> > >  	for_each_possible_cpu(cpu)
> > >  		memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, size);

