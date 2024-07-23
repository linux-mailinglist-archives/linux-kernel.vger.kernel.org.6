Return-Path: <linux-kernel+bounces-259614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F672939990
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923011C21A66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405BA13D538;
	Tue, 23 Jul 2024 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFSlBIZv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24015632
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721715001; cv=fail; b=U1pTahT1lhRBepa0EBN3tEltpdrg2XHvonS26eZXdCgtuC40AKFJ70ROxg5QMfoZUQlju2Ndo7cZeMRZFtsCqGc7aLMCaR+zyqB6mge6cd9igBRHlJBtTsRBdWe/fvGHlFrm+qtKjzkUNyc0MshxGA0ut6C0uRPGVvNrXnZ2xBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721715001; c=relaxed/simple;
	bh=YbPjja3ZxZGnqajE+KDgzPgaxGcfpJdI1kZcQZ8URPM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MN7siz+tiwb/vA+G47SrOJSIkzmZwZ4+wSAPyeJWgK+aq1XvAXU7Km+q4MBaFjBw9nyOdBJgQ8C+UM7G3zdfAs06D+k939PkDgYhgCDAGoGqN4cYf2gavSZj8qzzfrbK9m0VHSKwCBFGmbTSeigWnyrwaUMilPjpiMpZiuxZFok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFSlBIZv; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721715000; x=1753251000;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YbPjja3ZxZGnqajE+KDgzPgaxGcfpJdI1kZcQZ8URPM=;
  b=kFSlBIZv84pAz4w/xMEyW90KF2ABnLtda7s1QMBKy+SnOygEvqtU5ZpC
   X1vxlnUPOkmXXFv26l5l75UushXvYYZnga8Ec4RFsZlW9R3fVg3W5UZkE
   ErbE7dU8x8f9ZnYfQafHoD2sEUnIXE1rnbkgz07XP8JaGu/DoYSgnN9WE
   wkG1/GErEYRPwUA5d9B59GnXkb/Q/fxaPdHsjPJnH0p8u5Bb6tKvqHiwa
   9+CXloMNMDF/qX573BubT16MiIvHFOGAF2PZZwXkeQKR0poEGMb8LXDIC
   /CjazKANF6rE+oDnHAhHGO7j9/a2n+ozV/abdHbF8QXdhuAxV5tbaAdpe
   w==;
X-CSE-ConnectionGUID: t4reX5mDTG2K2VLhTdCsqg==
X-CSE-MsgGUID: uNMR8KVOTPGgRCSVkDnwLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="41844956"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="41844956"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 23:09:59 -0700
X-CSE-ConnectionGUID: RLNPvAQUToKHnZvk1xKeWg==
X-CSE-MsgGUID: 7vwVJLmhQIWuU1S2w6G/Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="51778555"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jul 2024 23:09:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 23:09:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 23:09:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 23:09:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 23:09:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0THv65LPZpEGrlZL3dPLPll+1Ofe2ZgFG92YU8pzw+rSABi1GvVT3dKglH1ba30DCASwgqIrs79FBIyj9yrpA0QAZ1EvdkHxvqJWdB9LrGOqWJ5QaH8+53Z1BX2URUyGyPnmoJidFrQJrNvsqAk8EmiiDFyXbBovbP6yH5SW1abV9OoOgFmY6Oy4DUE4x1ZcNlaLqC/2nFI16/9CyKnDP/XvwDu133hjPQtDbYpdestrwY3KFxuNlAOnxdAaTvLGaYkyhUJNOIFAnOgrLq2cAjs2vsq77OL6TnNYktBRg2z4H2gqRTgCIejZB0c3Q5hNDhO4ffIAWRAuk8waG4cJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWHfvXIEHbNCbOHkh5tMBMaOu2UDBGqYc4+7INK4Z7Q=;
 b=wBvWVGn3goW7lfhcSPkrZRglIAVYRKWyr9GNd2v3wT5WEPzbSwH/bTBGTTikkrhmzw+ggBYYUVcaK0TQuqtdDXPtDtvHOUlpUGod1x/NslhZucSqCFtsT0wQ1vUH9BOmZeVDUKe3iuYFaO4otrES5lQwjfYz9sQ/VHvSlvo5t4j6sXwNNdpmSJ1bYoIszGptZ1bY76pD9vZ06eJR5mZrp7EErM+ey7GAn80hpal1t6ufIx1udGN7Hh9Iao9DEjPXdGubKVcdsJyEmf5aUr1XmCWJNzB0m2Cyy5PA4drJTONoRKMM0rNOg5OF58yygzA4zzjDaLVRw8zGrkm88qBvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Tue, 23 Jul
 2024 06:09:54 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 06:09:54 +0000
Date: Tue, 23 Jul 2024 14:09:38 +0800
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
Message-ID: <Zp9JIvoRVaa+w5OT@xsang-OptiPlex-9020>
References: <202407191651.f24e499d-oliver.sang@intel.com>
 <Zp6bMoDnUMxNrKos@boqun-archlinux>
 <Zp6cVgXJlzF4VOwl@slm.duckdns.org>
 <Zp6e1PWZbz4pkh9Z@boqun-archlinux>
 <Zp6kpCcQRPTGk1LK@V92F7Y9K0C.lan>
 <Zp7G4EfISRwlmmIT@boqun-archlinux>
 <Zp9EvUTqni5wMDlC@snowbird>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zp9EvUTqni5wMDlC@snowbird>
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN0PR11MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 9535eea1-643a-453b-4ffd-08dcaade1251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?34ie0JxRLxBfSM8zkNrXieGGYgzpiWc2nvCdunil7Zyn17DMMoNBLfaFcKP7?=
 =?us-ascii?Q?uYoicJ3l/pAEi5+h3uzzlyThShM8RCZu6857OKdE9xpVnH5S2VdToxZbTU8s?=
 =?us-ascii?Q?q4EJ4X1dwt5k1KkRE0fU+fqGKgL0diXi5dcJ9472fPoJECq71XnljViTEmz4?=
 =?us-ascii?Q?AXExCOILrfj6kkPqZZ8U92ACoNh/83m//27hABlzaPJZQosOyMJub2C/u8ud?=
 =?us-ascii?Q?sZdCP9KkWGkl++ryW7vMEljrn4ljOZfWTAsWDHomsW9+YDPn6+eC5+sJCWu9?=
 =?us-ascii?Q?Jb84UDJP6ojlUUfWyV/+FbFx5jUSv3xATdPf473akgqhAQRl6obkp9bUh0r7?=
 =?us-ascii?Q?2KOw9yVKvhSID6dbbxRdS++aDNXCO3x3faKroyYg9HzBg5VuBGmDBwe1G3eu?=
 =?us-ascii?Q?WZ0MmwaMYh3RyTsO0h7dAO/ziwuzNSPfAJmJCQEeCCptPIZAjEukm+Oopd1u?=
 =?us-ascii?Q?US+B11stA4W+iN4Uw/2V2DwAY7gl4kCK1tIvo0g3Xv3WH6AVFhb3qzdXrTDQ?=
 =?us-ascii?Q?+onV8Ow6ywv2Q7gJXvqROKhKZSiTdZ66JFE7br3Hzymb7hDGGZzy4wY9+alo?=
 =?us-ascii?Q?zZKmyVJPb8TWX/D72oEuM23jfGPr8uNwZH1n/39a8AfraBHPyuXyS6G2ZD+P?=
 =?us-ascii?Q?CXfVvkmCbpaoIudRCrcKHHoHtJM/i4cEj/dGmPgADI5Na/Ldjnlyj5vCl20G?=
 =?us-ascii?Q?XU+zI524hLZaXxgNL2WiJWk7QPToLZ7MAQiOM6okOCU/FnGzQrF39CzE4chl?=
 =?us-ascii?Q?1I/gCAJq0V/ITPD3RaxHGdg8LYhGX4OUBZV5kBf6wK8Mh8PrggDvNKeLmdrW?=
 =?us-ascii?Q?nECEW6/ZvhfyDGvy74RxDm9eS9DZrtOs7GtUuNvi7+TbQAWbodKl8P9D/xSn?=
 =?us-ascii?Q?kFujACDMoHl7uSCTbu7PqKkYO4RDNQjf7WSb3n4yInAqk8xqZHI+IjCkXyQV?=
 =?us-ascii?Q?m6cpktsQ14yNeF7hhNWzf4IpZYgELgajzQbBS6kpgkWxNAHuZwIgs1Zda76W?=
 =?us-ascii?Q?q77eKWY4dinzcifHjQJ7KmUKveqWBkjXurJI3iZL4wCwi5ii0QteDqSBt1ck?=
 =?us-ascii?Q?Q3A6IqoZRKsMsXOtiqiQ1ZmQUYxCN2jojtUfzXhMWH+AuvFT6NxokB89D1Sf?=
 =?us-ascii?Q?w3vGow8kNw8h2FeICAiwtipklblDZhCSxbDfkN415MhSqWIUJ4q/mCE87uo9?=
 =?us-ascii?Q?diunSjoTHDZyKX42pXVyvf61YgtwRVFtfED9EcUz6r2nUNYdPshQVSzR+rC4?=
 =?us-ascii?Q?oGhXZ2W++DYz6flLA0uddneK+wTn5ntTSjZ5WlbVcYbgTOb3WfmukxDNwpyQ?=
 =?us-ascii?Q?nvDZUqHMXv9WhsJ24OXW+BTUERxjzoIByuQg9GVymK5tGA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eRU73KJGqeU0Ps4ol55zrxlmQq8zmLOHmis9+0iic5AI7rJ9piQ2+Tf3Vz9a?=
 =?us-ascii?Q?wnONrsnZx8Mz+DobRZUjP2X00J+9Il7lEDU0ChRzWih6xmAoZfpvgenQsucw?=
 =?us-ascii?Q?DKV9ZluNH0b+FeZ6CxAiYhT1TCR0EzbV2UXlm3b3avwWnCBubAKahnQybsuu?=
 =?us-ascii?Q?62xXUnyA1KoJaWsLLUavpKRocaFo2/nQFJHcXydssgnJgt5j89pxWf3ncbFj?=
 =?us-ascii?Q?ZXXVlc4CS1XZUg5RwiRsuTgHXxlCutFvwMi7Wy+oHxWwXP5M/Vj8hCf4ORZL?=
 =?us-ascii?Q?IUZkQhHN3A5HHQGtXx8v7z9H6tHLx9xXDAt1vjNRpGU7h6rtUsjq+zH4D/d5?=
 =?us-ascii?Q?bnuPyRWFFHUdl0qiBs2cvbYVxr+HFjz752KTwWndaWS6QqzIsowlOWyJDVhu?=
 =?us-ascii?Q?7OeLv46Eqv779SQ6OwggDFpPInfvC3f50cTB17key003OhRfW42mxi0ZxQAl?=
 =?us-ascii?Q?umruXg4n4LqL1NOqtZeugdbDchc1BH7LkqqOYdouegYFAM+VG1UuWdrYHuy0?=
 =?us-ascii?Q?TNgfsCNh0fv50FkbkA6T8w1CgZS3Mk/13bX1f3EHYvdc1sSnIInvK9h3UxF4?=
 =?us-ascii?Q?r9C/W+P5ah95QRN37ezakQ8Mg2m2hfy3gE5FmpXyMdA709U+5LLSQQcUtxaq?=
 =?us-ascii?Q?gNcT2jXa8RQIskShHx0i/wA94Z7t1WVnKedb5IT6wq32gWc6e/joLEM6d2lt?=
 =?us-ascii?Q?VUScSedA19E9wA+dxhoxyYQPa1hevqylZJHe6kfzAdx9hNvdpIKlKAQp4lHJ?=
 =?us-ascii?Q?Z36HLnJaGI6Fxa6dXqez7415t567zQRqDJx1uJ18zM6nSNwu0AMFYuasHErk?=
 =?us-ascii?Q?57mJfRg8nyZXOzQKkTI/iNi1gY5gyvRIw0ReS0azun8EQ0r3EIN6ru6W+d/h?=
 =?us-ascii?Q?yfvtgYoUUh30RINVaNOoNGdK/yjz2pwgNs+dcD3uiOQOBMy69tsx/yt1JyEr?=
 =?us-ascii?Q?Vm4UYwMMmXqXyHNlwXGlxuEaWnq4pjoGp0G1X2PIVrLct6t9fkQCFKbsXXLQ?=
 =?us-ascii?Q?M8MhIKC9f122aKFN61fWz6+9EDZz2JBicHVbsOwn+0J6+8oqlH/RrcA54aT/?=
 =?us-ascii?Q?IVpXWxP2UEkqvOKvuVm0KbrQIw+YddpUe0qIrREsn/yfhGToQjwRsm3WaKeI?=
 =?us-ascii?Q?SJvXj5lPMKnd2CRLxm/RyXhse2M6YkMKQYVbM5esd/HvlvxFri/5VIR0mVfQ?=
 =?us-ascii?Q?rnDmNIQfoav+QfgUc1YkoJNb5bpsC1DuNBssfEK2OACueBcOFVuXnQvJxwpX?=
 =?us-ascii?Q?daOUnuFzGQDhQ38RQxqCkFq1XYKFzcOfNYezoCgC2mmmRMGzE41L478kD/Me?=
 =?us-ascii?Q?nJdiBDn1eWvY9p/1sxnYh0UFyEzkNZnb/CTRHad51+zU3CDfuftaFtlq41i4?=
 =?us-ascii?Q?bur6Mf/QbOoFvsR6vEe4RQRzZvMtv9Y/+w2Y6ZhkMH6RNr9o05nSAT8m07Rt?=
 =?us-ascii?Q?ylZf75Hh1v1fG3lx4qI+UEPY4euO8VReo2lzDqC7m3dZmlsseCe+UsMPpG7c?=
 =?us-ascii?Q?GyQ/bxyk0VU3CVUR58rL6KAWGdUVCO8u2NSg/UKjFk5MVRvfnZnf2gJqHtvh?=
 =?us-ascii?Q?1Eas+S5OeCI1YU4Sn+u9GXDnWUX+ylQhmMAR/32KLD5u2sdr/DRXr9LLhPb3?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9535eea1-643a-453b-4ffd-08dcaade1251
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 06:09:54.7295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPBKDWfDoXrzxFKsyRy79ePJ+l4UU9VIHIOg8YUkAvOOYkN2c6SPMR2lPV14Rt0wbuBnW+xDd1d4nqZz/ZZT0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
X-OriginatorOrg: intel.com

hi, Dennis Zhou,

On Mon, Jul 22, 2024 at 10:50:53PM -0700, Dennis Zhou wrote:
> On Mon, Jul 22, 2024 at 01:53:52PM -0700, Boqun Feng wrote:
> > On Mon, Jul 22, 2024 at 11:27:48AM -0700, Dennis Zhou wrote:
> > > Hello,
> > > 
> > > On Mon, Jul 22, 2024 at 11:03:00AM -0700, Boqun Feng wrote:
> > > > On Mon, Jul 22, 2024 at 07:52:22AM -1000, Tejun Heo wrote:
> > > > > On Mon, Jul 22, 2024 at 10:47:30AM -0700, Boqun Feng wrote:
> > > > > > This looks like a data race because we read pcpu_nr_empty_pop_pages out
> > > > > > of the lock for a best effort checking, @Tejun, maybe you could confirm
> > > > > > on this?
> > > > > 
> > > > > That does sound plausible.
> > > > > 
> > > > > > -       if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> > > > > > +       /*
> > > > > > +        * Checks pcpu_nr_empty_pop_pages out of the pcpu_lock, data races may
> > > > > > +        * occur but this is just a best-effort checking, everything is synced
> > > > > > +        * in pcpu_balance_work.
> > > > > > +        */
> > > > > > +       if (data_race(pcpu_nr_empty_pop_pages) < PCPU_EMPTY_POP_PAGES_LOW)
> > > > > >                 pcpu_schedule_balance_work();
> > > > > 
> > > > > Would it be better to use READ/WRITE_ONCE() for the variable?
> > > > > 
> > > > 
> > > > For READ/WRITE_ONCE(), we will need to replace all write accesses and
> > > > all out-of-lock read accesses to pcpu_nr_empty_pop_pages, like below.
> > > > It's better in the sense that it doesn't rely on compiler behaviors on
> > > > data races, not sure about the performance impact though.
> > > > 
> > > 
> > > I think a better alternative is we can move it up into the lock under
> > > area_found. The value gets updated as part of pcpu_alloc_area() as the
> > > code above populates percpu memory that is already allocated.
> > > 
> > 
> > Not sure I followed what exactly you suggested here because I'm not
> > familiar with the logic, but a simpler version would be:
> > 
> > 
> 
> I believe that's the only naked access of pcpu_nr_empty_pop_pages. So
> I was thinking this'll fix this problem.
> 
> I also don't know how to rerun this CI tho..

we could test this patch. what's the base? could we apply it directly upon
24e44cc22a?

BTW, our bot is not so clever so far to auto test fix patches, so this is kind
of manual effort. due to resource constraint, it will be hard for us to test
each patch (we saw several patches in this thread already) or test very fast.

> 
> ---
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 20d91af8c033..325fb8412e90 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1864,6 +1864,10 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
>  
>  area_found:
>  	pcpu_stats_area_alloc(chunk, size);
> +
> +	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> +		pcpu_schedule_balance_work();
> +
>  	spin_unlock_irqrestore(&pcpu_lock, flags);
>  
>  	/* populate if not all pages are already there */
> @@ -1891,9 +1895,6 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
>  		mutex_unlock(&pcpu_alloc_mutex);
>  	}
>  
> -	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> -		pcpu_schedule_balance_work();
> -
>  	/* clear the areas and return address relative to base address */
>  	for_each_possible_cpu(cpu)
>  		memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, size);

