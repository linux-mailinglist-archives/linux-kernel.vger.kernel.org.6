Return-Path: <linux-kernel+bounces-419045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE559D68E3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43162B218B8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9933189F36;
	Sat, 23 Nov 2024 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eOY7lw8O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7874A0A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732361704; cv=fail; b=HqVKC+DGYCnIF79l1j4Q+LMiWYL48bvTbbgIbzA1u1MHtYpSst0lMYjXPYe4ib6TivUr8hlPW1+nw9njCPMdROj8JCD3b8cjkVQJRUcGuarIbtKo5hE41dWmYHXz+dzfLdIKLFwnywgaWuJS1B822mMtp4pxwLbe1o+QB9FaIPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732361704; c=relaxed/simple;
	bh=qIcdiobbSHiO2KaqxTFEowj3K7CUVdpIhcOi7yXlrB0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XIRA/DQghiYDpL2gb0sdq9UwkpX9vrhaXk/6bsuRa17hDi2KCDVKKP2UG7kSIn086Pu6lSOYtej32jpBAGuVI2W90mriHSveBor+wAkgEGw+OXKsWROVdjrmSprS+HVKfZFCJDXNEAlB0ygD2uGWZx7+pBzqpmHtBrnguOLuWj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eOY7lw8O; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732361702; x=1763897702;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qIcdiobbSHiO2KaqxTFEowj3K7CUVdpIhcOi7yXlrB0=;
  b=eOY7lw8O8hF5eUK1Gg32jnNhloXNWzp7iP3JFDBDQX6T3R5M44J+e3bf
   W0jLWrvU/rrqxqdp1j5WoqzEMgjVepVm0hv9qMbPi6kbyLUBs2dxCVwiU
   ALPSa9aTdHCf5wS0knCKmR353ojQz6hRBasVX1RFOsPlyZmfGQCzJEg77
   QtMTkZB/NeKonuLlVrosC1M0O0dJKzWYncYavOKFI0J2i+eDTI2IDyGgU
   5FkdCZHQODin4ApJ9uc6fBwa9nK3KnikK2X0/EcymIyEQgw0eH7QJyKNU
   F8OaVdn3UWoAMGHwG33BBx94Q/c1vJsKhha7qM6R7lyjPXdi/hSWC4G93
   g==;
X-CSE-ConnectionGUID: ZhBjTueAS8iD7TeR1tLM6A==
X-CSE-MsgGUID: 8dPEwYkJQqqRnJczU78yZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32759708"
X-IronPort-AV: E=Sophos;i="6.12,178,1728975600"; 
   d="scan'208";a="32759708"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2024 03:35:02 -0800
X-CSE-ConnectionGUID: RpvQk4U5QoKBXtRecJpQ7A==
X-CSE-MsgGUID: /W0TFzuxR5qbSteIKoJx0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,178,1728975600"; 
   d="scan'208";a="90958129"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2024 03:35:01 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 23 Nov 2024 03:35:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 23 Nov 2024 03:35:01 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 23 Nov 2024 03:35:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pp/O8cP4efeby1CtuesHuLM9UOqKCCfmlucLj2aNcIkaY+4giyZ7enycFRBC2WDr0fGE1AKStpPqfqyP++xASCBc9ukixBD5/PWmZ6iVcdT+kZnhuNVRQzd1Tdh1Ge3t1Ybo3s5ptHxvVJEPcUzWFRYEGUrcd3omHV7C7TNRKq+zRTZ60yxB/FN0H8JJYI5b+k164a7TGj81lFDaT8shABxBegie75XeR4x7P4DriU0sP4IJJWgeZbczls7rGvKf/BWh2BxZTGdvmWC2GnuG7fq9dRZJktco7IA5LRN+SXppXzXtUTYJlHeDSlwAZ8DQDzQ+dZeEnvxDOw4XzYKkTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfMrUwoT3rcGbjkd2wAZBMFAg8OKowDOlalqaMGJtrc=;
 b=o4Qeech36f2Dk0+/GIs3dYi8fZjT7IcmguXx1+UUb33cUpJmDwQ3pswMIzcuUuoF6fIwuVWYTJ7HNXLJdTl/pe34xgyqbGNGxysZwy4EPB4mFBkqXZAeMagJPlgR1mIyKZykf1wcm55QXKk85+VjDvMP4KGSwPgcBE8yM0v0bYWNORKkTuo/vUONsfT0lWtv4H+YXzhMf8KkphLtBAd7sCV3sopptOnV8xb862HFoB6EO1Fk4mHlOE9GYevZeD7X+T7nfiUoqJVV0XKr8G8TxYAFgcl9ZrF+Q1eXeFLGrHB2gxyAY+ogn5HgzYNKw8rth7XhLmUovPkQxAfDXJYWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by DM4PR11MB6406.namprd11.prod.outlook.com (2603:10b6:8:8b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Sat, 23 Nov
 2024 11:34:58 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%7]) with mapi id 15.20.8182.018; Sat, 23 Nov 2024
 11:34:57 +0000
Date: Sat, 23 Nov 2024 19:34:43 +0800
From: Philip Li <philip.li@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC: kernel test robot <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, John Johansen
	<john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Subject: Re: [linus:master] [tomoyo] c5e3cdbf2a: Kernel_panic-not_syncing:STOP
Message-ID: <Z0G901dGtKZFshUe@rli9-mobl>
References: <202411221744.1a298e1e-lkp@intel.com>
 <e0a6a2b5-acff-4b58-9457-292864a5bc91@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e0a6a2b5-acff-4b58-9457-292864a5bc91@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|DM4PR11MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 3900b81c-7af4-42e8-2449-08dd0bb2db43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4dLJY9hPX/wEybi8wz0fo/J0Ra/T0E7WnhNkOy+z8wDV5qv0k5tRsFijwbCE?=
 =?us-ascii?Q?qzaqU+Rn1kRvLweWiKQeyrQjKNZUQXTmFyARqz6wB4dpn1yKJnp0IIzOcvJN?=
 =?us-ascii?Q?lolkPhh3ej/FIM4iSgqd9OI1k63gTEPVbE1ERkZvFrroGMM7NdWuIxIdWz1D?=
 =?us-ascii?Q?XJ53a0tQyKRW/WTWELnt0wMXJiPNlEhsmp2NHSKvFSadQ8CFFuf9TJIcxi5Q?=
 =?us-ascii?Q?JQLXhnnNjOa1wENviwl5aoKAF6JFRD7lXiWD/O8tTXX4zurS5HqhXdkZ8O+5?=
 =?us-ascii?Q?GwBqRWfF8GnwC5Blp/ow/MYWLK5r26c2a14def0AitKgLZ7aVUhTZS1h1Gbf?=
 =?us-ascii?Q?tZ80E1F9sLBdh0K+qECdx//x/ieg+xOXnPl9msRwMXk1+NX0HvscArzWz8L1?=
 =?us-ascii?Q?/3vEtBl5gX4TKO4a2hJXUbmazfaBvlM+zjxDZIplxxh5QaEmPdp28GasTd2r?=
 =?us-ascii?Q?Q2g8k5GNhPslYG+WeGHdC2RGhqATcK5NGSx2FapwQ1hdYhs9nf0yOe5brF76?=
 =?us-ascii?Q?1qSIvbyq+5Y2XI1Y1+Hg3X5SC9kp03Xqq4Z72Bkj5SapD9TLkCvBhwzSh/RM?=
 =?us-ascii?Q?bJhIKYzRFJm3jIgNXr8CcYiphh0A2yOWalkuxtVaAYXi6L01/tijatZH8bAr?=
 =?us-ascii?Q?x/r6xBlPUZSnOSj68//0PQ0EjuC0IJAVaSifGQZ29+xl8uFbvQStrSec1w/c?=
 =?us-ascii?Q?b4LTTkEuk4nhEEZaiRzB93qlUqtTmZm0Q/lJeIuVhwgEl9MYjwxcMMKCShVR?=
 =?us-ascii?Q?473KaBX8Vvp13wJRcpns+++hb6X0y4OBnqHwmbiW6oPsqkDTqRFRgY8Y22o+?=
 =?us-ascii?Q?R6kTzOK9T0BHb9UON72H3dfvegsDtdEMkwXAzSqfpjO5NOHJkqV/iokp7PlH?=
 =?us-ascii?Q?yTD8wUFJiRxoyUF49pQaELQGC8kIg2nOuUbQHfVpTMvSoq4c7MLL39z0OHqn?=
 =?us-ascii?Q?OyYoKj4Yw4TUvLlW+M85u6dJu3+vUacVsNZfA7ZBWnHha+lApPz3D52eSFiL?=
 =?us-ascii?Q?xbc3F/cq7362bxhPwxVfX0IQ+7eff7L0GCyi54DRO2K7xFMF2F1wScEQBzse?=
 =?us-ascii?Q?N/zBY1uKUJu8PJ//4dhfmi8hpIr+mXBpEzSd0te1n7SWv9c/U3ZbzEP/ymhg?=
 =?us-ascii?Q?rI2+RSaELVKdfmoXCBAXNi6IFAEixEiVhEIauqgJI2tSbF1+mejfNCtu28at?=
 =?us-ascii?Q?uRQS+4ldtMLiaZFj7HYt/VUzjTRvwdishJU5s0tAu7K9jOuvZgUsI5h6Ex9g?=
 =?us-ascii?Q?3mgGJ0zPwvbQKw/qhAdldSIPpqInx2PPIJ/ZTrXfj0JOH8RF8010uJlNtC9A?=
 =?us-ascii?Q?6j6KQWm77wTZzRWDikFEh+gk0rRMwMzJmhYe9jkJh8Xlhg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uNP4mVoxCZxry93bccgJjddQnuoE7tI27mdMTdxJGKyIEuLjTliUdoUJXkbB?=
 =?us-ascii?Q?Qg60LdO9ECscYnKgoIpuu45dDKj71wINMyhJQDwx/WucIFh2V2ULSddO+2tF?=
 =?us-ascii?Q?WlMAwFTjaFnWUhWCeT+CkSC3bkQMVxWHsSVXy9WpDc9e09iuG7tsw3UuM6K4?=
 =?us-ascii?Q?DKctKG+2ddw2xDfLFcJ8D9PNubt+Fw2bQ+Y+HcQF+Cv7BU28RoD2+Nv980ZA?=
 =?us-ascii?Q?+Ln50Fp5HG59idFoyv4Tl3Yt0P88x49NaX9cXBuTVzkR/FZDTuRYg2zgfSzF?=
 =?us-ascii?Q?iwQTzQW2YcWtAzFczOAxL5ZT/QxKz8h1G3nttZ2yx5snWTeCvfl0n8vqoDak?=
 =?us-ascii?Q?s3IpuesG3RSdeJHQ8HxMQp98vgzzEcT015LvlPpgOaVY+qMzM1w/A932it6J?=
 =?us-ascii?Q?N2+tsD+WvOuibtR3XEwIZIoMZG0YtfP/9a0kcSCd9+clYqqTLpNnvKl7B665?=
 =?us-ascii?Q?jiGToRl4L0LU85Mhdv+9yFFnY+bzdd+c3h1Lq6WCRtnAtWZILxXADDn451XP?=
 =?us-ascii?Q?VNT4FvEnw5NBILhXaCfget8eg5ovHlGRuJxpCcTy1594a8D2/AJQi7FMM4dy?=
 =?us-ascii?Q?BFoaNIrv2w3pvs5XYRp9VSGatj5Ll+NQFd3LtkXDx5syPvcZM+7jWnO6NR5f?=
 =?us-ascii?Q?IKU1NS6oOoge3Mflxru42acTPMK6f22a4o2VGIX/jNcgbP45TImIm+tD8sR/?=
 =?us-ascii?Q?P/d3MDIFL46qtFgy4neaGGtFnyk/IBmkTZ7nlrXD+wrGXHcdAKK+uNG3Qm4V?=
 =?us-ascii?Q?Dt3KF6k9tvG0HKud4MXFiiEniftG+fkkjBh40gW6aepAlBOlMa2Y7bHU4ADe?=
 =?us-ascii?Q?kgPlp7xLpJOo6JFKpuWozs5GRvmmibH/3Gq8A65mUPrQq2nr21JGiOifWUP6?=
 =?us-ascii?Q?/9YkV2dzkI2I+onLORyMjRaWsUgopUElXO1V93JwIHcpXCob9d8/7bgmUh/i?=
 =?us-ascii?Q?NwExBGikTD0x2y/bph8KpD1Ibmk3Wvup6ukqXcg3IEx+19Ji0eZ63GknVnNG?=
 =?us-ascii?Q?TP6eSz5yUgjGzNd+O9N0CtxbxRiRLy/jirb3ckqi930gn6Tms3o/s7i59cjf?=
 =?us-ascii?Q?6LizYyqJByzCyRvzTC3tOTaOXtz3jwxbjDKH36vicREQp/xbbkcGuCKbiQ39?=
 =?us-ascii?Q?hgOIsxA7/o8DoLrAbd6DQVWH4FzCKTPNeDpe7J2cvtv3mh/Vp15dJ+oQHfUW?=
 =?us-ascii?Q?S0oxPWf7aVInBeVKRtolBqDL+OxAhT3X5jx16rr+3WM8dzehslzm3unCJq2A?=
 =?us-ascii?Q?PF0hvd4ZRDN3QcImF+AaiiS4Prlf41wcG2FblWZOv435eNlWP+ec6hrjEbZL?=
 =?us-ascii?Q?bb9dkrHtP2PwxxnH5p8uR78YPlKSTw0cHZoJSY7NiFju1Z2FtpPj7I1pgX0Y?=
 =?us-ascii?Q?c9R7i8kfm4Y7JENozGY0f0pftxbsegFI7nTstubuwsri/RqmFbOkzzXeRjw1?=
 =?us-ascii?Q?I0YMmRnLyYSCJycrISDjs/wG2QJ404UxswA7sv92zaclD3tMAYo7P9A/1wun?=
 =?us-ascii?Q?YQG42V+PXN2OaQbFYUPRmbITr2V2Q/DWoSKnOgIEHokfOpcnz4POwkdMbGw4?=
 =?us-ascii?Q?wArfV3GDddpyb6A1fzhdnXYtZtwRJMFlD3zyWpat?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3900b81c-7af4-42e8-2449-08dd0bb2db43
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2024 11:34:57.1509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuFAvuyw18XXz2n8q+bUyvSfApII4nGGH6EHxFR5NzSeNnJF795A+yAB1SBoJ6V5BgcIXBa2ok4KXwtGnNLEMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6406
X-OriginatorOrg: intel.com

On Fri, Nov 22, 2024 at 11:53:47PM +0900, Tetsuo Handa wrote:
> That commit is not bad.
> 
> Kernel config says
> 
>   CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER=y
>   # CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set
> 
> which is a combination that cannot boot without doing one of choices listed below.
> 
>   Change CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING to y.
> 
>   Change CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER to n and
>   install tomoyo-tools package and initialize on-disk policy.
> 
>   Modify built-in policy to include a complete set of on-disk policy.
> 
> On 2024/11/22 19:11, kernel test robot wrote:
> > config: i386-randconfig-005-20241118
> 
> Please correct kernel config if random config selection hit this combination.

Got it, thanks a lot for the info, the bot side will correct the config to avoid
false report.

> 
> 

