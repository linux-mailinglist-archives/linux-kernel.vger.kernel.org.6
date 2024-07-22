Return-Path: <linux-kernel+bounces-258523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 485E093891D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E4E1F2160D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663641BC3C;
	Mon, 22 Jul 2024 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jlhzx/U9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881817C6C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631050; cv=fail; b=NhgrUxKJbT6tr9xZE+wS6wnnk3CU+jEAgnd/CR3WUxgxAzo+CrDLYAv/DAXd0RpElE+wnoNYyk8/r+L/48onoDIIBjRpiFqaM7peiTPCSQG/oLKPsHVuHnGMPHpt2BEV2eAK9ZeG5mZp1NJzEleYYkDm7tdwB1XYcXJ/NqHYGUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631050; c=relaxed/simple;
	bh=bJg60cSpaBq88Xbj3iWLgBWD0V88eb4NI50zlQmThic=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TJK5zUp/xRKb0UXTLkjHcBRHFaErwkvCHGLCu3MV3dD8pKySYnElolxHliEeH3MvxgUQe1W8grt1BS5Go3eMoa/rrPQCstX2liGY/En8CqVTLxthGm1wuYkKJXaSaRzi1ulIaTmTD25bdjg/xgO7dXZ9vgYRP4gwdAAC9o2I3bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jlhzx/U9; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721631049; x=1753167049;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=bJg60cSpaBq88Xbj3iWLgBWD0V88eb4NI50zlQmThic=;
  b=Jlhzx/U9d2Ypja5HLFXWWjYFWQOLEj97zXHeoqHhSABPE9Ty6Kjj3UD4
   v5PeOX7ipc3jQQyW3v0xn7zJPG/52und7HGoNn0LVrnjKs77r9pDNlEEK
   OOU650ikNdoj62aye55f7w3bTw+Bhl+NSeoEyee5t6B8VnCVYfcMuXt5v
   LwqXi8iYWe7YjqLJfTOcoI4iIwbU1pWxrhqIG43C6Nh/rv+857XVsqNaC
   /QTxEv9LzfYPyboPaqBYRsW3mefBcrZsj2eF1EZojKUQHdIdgB7efpg/g
   vH4cP1i1i59U/yWPSTUNwTbtDWRa7H/3Z9QNSC2Eh07xj7La5JCRCbSt2
   Q==;
X-CSE-ConnectionGUID: j5Jdd84lQVy1nXJcMnRbDA==
X-CSE-MsgGUID: Uvjdt1/ZRf2DJWP8CFp4Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="19363564"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="19363564"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2024 23:50:47 -0700
X-CSE-ConnectionGUID: UB3Tj/50RHCwfWXbR2hNgw==
X-CSE-MsgGUID: QW326DLIT8u2olDANwU9vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="56623066"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jul 2024 23:50:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 23:50:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 23:50:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 21 Jul 2024 23:50:44 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 21 Jul 2024 23:50:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xADoqQ/ado1xU8Z5PzQ+fLRbLNgrWfPDr0yUYAAqq+KBL2725wt5PDrzCJdNkpgCoGZN4L3yTN4AQd3b2o/OBX19q4aRDl+0P5wLDzx+q56VT3KRuGqsJrZTzkjbXXsFerMinHYckFutbvYkHHme22Od1XIrvtFvoOG0ZGHwl6cEjwbZok7d3YgThA7zwf3Y61oi93R+3ZniYK/4DBQ9eS+Ajm2pNdLTn4mfMzCB1Fc+piWAK1W6uPj2fQA4pBHTnN5jZHK7GoaNqJnfsIHujpRqa2Hx75hj+XJPj+Pq3yaVMYh2pVMlkdKy+jFGqnbrl2qyr5JSbrNzw1ldfA3kTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v4HmTD1v7g9PHRlt1f4LlzqJ/Z2jKDR0XXJGJMCk7w=;
 b=i8A5zw2jF5ETIxOa7UxP3rY+YqPnj5l8ZDKOrsiBGqJp0ZoR8leeHU7X6VH3/agP8OZ8VANg6J6naV5UpinDwcWeiw4S1Di3Wu6Qv2VHrLLkfoWjfUo5uLb6gKR2fa29Qcb6S3sgyh5ST4O701csIq8pyhh1u4WfX3CCWga0W7MDsllIxMTK6doJZrTorZRCGubdnbGDSjFwsJpWMIu+cA2rkjQAlPVG9dhfRk/sulyAXY2sRCTWHEx+UbO/ZlTcUvUmL2bmEK4x/H4XJ73C17AgMJ7xnojFXArfepqY7K96v73KFfcDOUoe4NC4Dtm/ZswRiGHil0mq3GzvaEgLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 CH3PR11MB7817.namprd11.prod.outlook.com (2603:10b6:610:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Mon, 22 Jul
 2024 06:50:42 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.7784.013; Mon, 22 Jul 2024
 06:50:42 +0000
Date: Mon, 22 Jul 2024 14:49:12 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: David Hildenbrand <david@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>, Alex Williamson
	<alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Al Viro
	<viro@zeniv.linux.org.uk>, Dave Hansen <dave.hansen@linux.intel.com>, "Andy
 Lutomirski" <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Kirill A . Shutemov" <kirill@shutemov.name>,
	"x86@kernel.org" <x86@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>, "Pei
 Li" <peili.dev@gmail.com>, David Wang <00107082@163.com>, Bert Karwatzki
	<spasswolf@web.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <Zp4A6HNhamaNQJOL@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk>
 <ZpbDnoQxGubegtu-@x1n>
 <Zpcgmk6wexTKVv2E@yzhao56-desk>
 <ZpfR_L9wtuXhtSGk@x1n>
 <Zph051h5BsSFMpR6@yzhao56-desk.sh.intel.com>
 <ZpkglfpbHH7lQSft@x1n>
 <Zpmi2JWirNDiJz+7@yzhao56-desk.sh.intel.com>
 <1a0884cb-39ed-455e-a505-7c1b2a0e5225@redhat.com>
 <Zpp0jX_x2awQk6Nj@x1n>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zpp0jX_x2awQk6Nj@x1n>
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|CH3PR11MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 206b22fe-ce07-4b7f-01ae-08dcaa1a9aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rB4GB4oMmuENbXdgxGFZ8qA3VqL1o4z0shXtO6FEc6g0qqwDio+0kniPWNwZ?=
 =?us-ascii?Q?T3SMhaxibIJPWk4p2CIxUvlrcZey+LdEN52BhMxaDgtDd9tJQP0s0xalEOfO?=
 =?us-ascii?Q?yZ0R6G3fhY+S0T08xeIIPVUZDsVh51UAoLlwPg8oGoShYEnMmQSP3oy1iASz?=
 =?us-ascii?Q?lfqG1AYAnKaBD+lG6eMbz7SEv+5bOJLuTgNMuF7lQ/V/FJj/CorRFDMbyfEv?=
 =?us-ascii?Q?DyXFIJqqg9KjLr/FIVQSebKRodZStGMOBJlTEAuXVW+Ugy/IXdxBuTd8NpTe?=
 =?us-ascii?Q?Mmt13wiT06KMa9WO7m4k7JOXesjE8Ae1KNyiKX7qsCBm1WROsH88aImEItAL?=
 =?us-ascii?Q?+Gbq7yo+IUMXhQlFkuLue5Y6e6hAbdM4FBSUf7eo1rOL/DAXrezDkc8NHQp4?=
 =?us-ascii?Q?JENYQrb+5PAmfIvY7QBXMNAbTB5sQ35VuNGPhMzWWdeXpqWHeWnTwea2SSud?=
 =?us-ascii?Q?uKLwFIJdFtkktNitxFtFpBgnhZ1/A3lDT0+PTnSQlbjAN3oMdp9qF1dvq+WR?=
 =?us-ascii?Q?VeAvtltHjGO6xYgLEwXJ0YaOeE/x5Y5vCY94iIPYBcgFI+az+ZD8kylo5XxS?=
 =?us-ascii?Q?i8IpeD0x47V9YijwlFJlZWqqFzxpGKt3NL2odA/f8sxptn4ZRzofQQyrNzrM?=
 =?us-ascii?Q?yyaDczemZlKqL8DaIFd+dB9CTieH1us+h/0M0uEllZ9XLTI/ICOIdg3Zxhw7?=
 =?us-ascii?Q?xJF5FCGCUzCcgIqaIXBhH7ri1rKtbrQvTMig9+YeXRZGf87bXs1so2LgxTtR?=
 =?us-ascii?Q?l0I4q7oQHwWuKJW3JHxJhZg/7rQNy4NXUSS+NTF/BvZzOiB4nxIIOQHkm+pW?=
 =?us-ascii?Q?k2f1RHOLRtefLAl5WaJGiYwQ8z/L6pCslldpZcZHb70NMBXKlGG1GXaT8kVx?=
 =?us-ascii?Q?+dXBJfvVNij6zORzCS0whUgfvjs44DgQ+v5Um9kkhK6qGQRHcDCasPQB0sUy?=
 =?us-ascii?Q?yuoTZpUmj4wOug58uSMyaLrID8Be233AERJiHxXOzBZpc3pVLs1YKzUqPwWt?=
 =?us-ascii?Q?flTqwt99jhoiHbkJqDeFmqnEbIdt58MzJiAd8BvG1z2HGZLpgZ28c2OnHYFY?=
 =?us-ascii?Q?R1FcMWWNKWXSUtaFSmJw1B6jCuxcP8iGXEjGyZItWZ7/4qFOTaoNRpEX11MA?=
 =?us-ascii?Q?e72MkoiCVDLgm6S7+94PlNkDsKHpAXs5dUnmRDXtT5jLzHzvds2kEYm9ygSE?=
 =?us-ascii?Q?VzR97WHG10rCagJvK0hTZHfShoPROOZozzNx4JDEGmV3VMY/9QJlts0gYZwf?=
 =?us-ascii?Q?eqmyDhn5yFTC+kafyqnEi/uo6IQqVJjVPCVaKGHmeEpZXZS6Agoj+m1gEnSM?=
 =?us-ascii?Q?egYptmbQZawpRHO4oz4j0a76i/ZxThb/chQ/CDvOI42FtQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zjsw3cZ0Zr+yEcpw9HmIBCsxzcA3ImEb1dA3z6M1WmjLMEg5R4Z6SOZ5mOfr?=
 =?us-ascii?Q?3Zgn20kBpKBcWTAFUnnMaI4lZAh3sJ5HKIrtlJF357X3tuFCULEARWXTClR1?=
 =?us-ascii?Q?kcEaY7raluGrdQzLZSRCX0N8AysgGpjGjldgeLL/2NkUbuEqnLMVR+3EaKDp?=
 =?us-ascii?Q?Slt7xFsn89EwHyFogcbjX2iv/eFI/gnBtcd6zgar6SBX/MK8LQx6w1QJJaMA?=
 =?us-ascii?Q?Hy2CKKzV+Xjy0pT9btHLDjU4VOcSkLdaRpw542xijLP8tVsb5SsXRtpsZAhJ?=
 =?us-ascii?Q?71rLb2GhxOERlLW+hLgjuvtTVhaTLgELdj3D8dbuWTHnffNR8jHpGLB1nLSW?=
 =?us-ascii?Q?T/+TAq923YXOXm14rGo+oWhMp3NsJf2Z1p/pqITnZa+KTi+TEGSEpUMK6SGn?=
 =?us-ascii?Q?Q76rdxKXMq5t62RKVv2aS5GoljfyAbnkXPgvrMJpjRwTYqpnw67awn8brwLl?=
 =?us-ascii?Q?PAs3LotRskdUrjBMIFyU0rZuALM609dsHcR0Z2UV5Q/4pfYdEzFzZ4Co7h0C?=
 =?us-ascii?Q?vLVmg5iHo4Py23SK1Jt5Urka6n4kPNa/GwDb/iNdP6bMMBa/gy4ABpQOI8ux?=
 =?us-ascii?Q?0PmgssnQORTehlcggFZYB6x4ZxhunXloW7PZ8abDjjCBZ1n9XymqV0yNiKoj?=
 =?us-ascii?Q?ozcBwNhvOBztvVwTmBKnTFVpoSUPO3sLHQa2ibimBblQZxKWFg3Br3DWKs5v?=
 =?us-ascii?Q?GDo79yqbTrWQGC8F+bHok3Jw604gS4djYYuRb/zyf+QqlPc3jIlkdYgEFKZI?=
 =?us-ascii?Q?ibJWPZBydWmel/BcUGjizs2WNRG26xy70J0p6O0HjPVXzDWPevXwBb/gBaTv?=
 =?us-ascii?Q?H87bhLmmVvv5wXoQlIUn0jEON3ryUQFj45ZMOHUKTE904St/WWNR/S/RokKs?=
 =?us-ascii?Q?BKD2HhcfAuVfCM2myFBE/hh2f2kY6VjWuhRsk3mQQGGFcX5vIA0lYy/aPfzD?=
 =?us-ascii?Q?jFprJXdiPdPsNF+pnT/g+ms9v5CVrMg+8on2IyY9UcI4UR9yfII0Wx7RhHff?=
 =?us-ascii?Q?Y0tJ+B9DWhnQ82c4/fLTLgeCnnpQIlyN2ZgWz0byN5r9GQpcl+eNjQotGsb8?=
 =?us-ascii?Q?Ro8/UFsxMsWkRpuHPcyDZk5qEvB+3cS2OP7iFBCe8Py8rPbJwksIAR+dhgV1?=
 =?us-ascii?Q?Xl+zCKu4jsfWf0HZi6l1c4WoEwZ/THaSIB+yEUiJzl7FqOqgysqVTyhv8Wtc?=
 =?us-ascii?Q?ByNtHXU2H3eEqt1zDnM45Ra/G+L517Szn4ZRIOkERjH23VhBHTMlnhuhIorc?=
 =?us-ascii?Q?alygKt3Hk1HYaOLfC9C+/qG+q0PG44wTQwtucbdI64AD7ZSgEENkagChS4FU?=
 =?us-ascii?Q?lNRbec99nrmmOb0s+e6f/VUKGZxP1M24K0S7gZXeueHdu+r1dGxgXzSUwJ4T?=
 =?us-ascii?Q?yaLPWS2WYC87B5Bs6z//wJwA27LPQYtEeGgb4bhGCIONwK1xSgOuqCUpiDOA?=
 =?us-ascii?Q?WmCCuJeJuBrRAwK8cNl7KLO1acqkujerRzPl/6ZF2OeGBOc2J1sA9QuF5qzj?=
 =?us-ascii?Q?eHU4CT1iyXs4ro4lw2W6Q432VatuYiI+uuHgHhd5+wdeywSB2NdTVsEAaLvy?=
 =?us-ascii?Q?Vx4L6JQTJX/GKSbKnRL8rtW1MT6eYCuq1jUYsglT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 206b22fe-ce07-4b7f-01ae-08dcaa1a9aa9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 06:50:42.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFzBS37AhGQia6zL4MQlJGvBGX+9Wyzs+wYGO+CqP0NuzxlYkad6OvrB/4VTIaVd5InNnV433HEASMZ2554h6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7817
X-OriginatorOrg: intel.com

On Fri, Jul 19, 2024 at 10:13:33AM -0400, Peter Xu wrote:
> On Fri, Jul 19, 2024 at 10:28:09AM +0200, David Hildenbrand wrote:
> > On 19.07.24 01:18, Yan Zhao wrote:
> > > On Thu, Jul 18, 2024 at 10:03:01AM -0400, Peter Xu wrote:
> > > > On Thu, Jul 18, 2024 at 09:50:31AM +0800, Yan Zhao wrote:
> > > > > Ok. Then if we have two sets of pfns, then we can
> > > > > 1. Call remap_pfn_range() in mmap() for pfn set 1.
> > > > 
> > > > I don't think this will work..  At least from the current implementation,
> > > > remap_pfn_range() will only reserve the memtype if the range covers the
> > > > whole vma.
> > > Hmm, by referring to pfn set 1 and pfn set 2, I mean that they're both
> > > covering the entire vma, but at different times.
> > > 
> > > To make it more accurately:
> > > 
> > > Consider this hypothetical scenario (not the same as what's implemented in
> > > vfio-pci, but seems plausible):
> > > 
> > > Suppose we have a vma covering only one page, then
> > > (1) Initially, the vma is mapped to pfn1, with remap_pfn_range().
> > > (2) Subsequently, unmap_single_vma() is invoked to unmap the entire VMA.
> > > (3) The driver then maps the entire vma to pfn2 in fault handler
> > > 
> > > Given this context, my questions are:
> > > 1. How can we reserve the memory type for pfn2? Should we call
> > >     track_pfn_remap() in mmap() in advance?
> > > 2. How do we untrack the memory type for pfn1 and pfn2, considering they
> > >     belong to the same VMA but mutual exclusively and not concurrently?
> > 
> > Do we really have to support such changing PFNs in a VMA? Are there existing
> > use cases that would rely on that?
> 
> I share the same question with David.  I don't think we support that, and I
> don't know whether we should, either.
> 
> Such flexibility already will break with current PAT design.  See:
Previously with remap_pfn_range() being able to be called in fault handlers,
this flexibility is doable. i.e. reserve in the fault handler and untrack
in unmap_single_vma().

> 
> untrack_pfn:
> 	if (!paddr && !size) {
> 		if (get_pat_info(vma, &paddr, NULL))
> 			return;
> 		size = vma->vm_end - vma->vm_start;
> 	}
> 	free_pfn_range(paddr, size);  <---- assumes PFNs to be continuous
> 
> So untrack_pfn() already assumed the pfn being continuous.  I think it
> means pfns cannot be randomly faulted in, but determined when mmap().
Hmm, in the hypothetical scenario, (vma->vm_end - vma->vm_start) == PAGE_SIZE. 

