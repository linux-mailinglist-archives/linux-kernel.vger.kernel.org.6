Return-Path: <linux-kernel+bounces-356362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A29C996003
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CBBB22E80
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5F17332C;
	Wed,  9 Oct 2024 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KfZGe5J4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF0617332B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456296; cv=fail; b=GK73OpUSsLCkBL2QF2VxIwQYuu0UKNVORNToW3EZ4x+Thq7rr2ajbjWaackRpYN0u54bpTbAT9vN7Wlw6CnctkGk3HU4Fjy1ay9cUBNf8yNObdbzNizNL0+XcRuhThUit3E2tVusr9GKjbTRXTp8lxybG4qzdG3w7jcjjEhpTE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456296; c=relaxed/simple;
	bh=f7Kl82twTGXFdXff8B7fliZsydT6zbMR/kCSFlGr1ZE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SyFAaaQaURjqlV1y/RSztZz/0BEB/vH7+59XIQGH3lvZL1pkpoK0b7d/xc0MRs/H8gil9P9fKleeNqHyUtlTeMK2JnUwO3Cn7a3GDHfkP8s1O8BykRvN0NtqECX/VTGJu492xFpU+Wx1LFD7NUzXfJ8Pm6bBEiHcfbUBHWU5lWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KfZGe5J4; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728456295; x=1759992295;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=f7Kl82twTGXFdXff8B7fliZsydT6zbMR/kCSFlGr1ZE=;
  b=KfZGe5J4Gye1aXN38TESyfGG8zGnsTqxKpmZHleU8j+gBX6k+UvXDOlw
   Dm8vSiKlNHMWZLnj0D879OOjXiHbE+r2Gr1swTZ7Q7KFYbKjjTmr2/jwz
   WFiEB1dKUduM6yuc48Q4lX8Kk70S7FG+nmeGFS00lv1PFXRFRafFAMNVr
   MG6Ylv50WDt+AdYDxmhk+TeJGepZeB4XFNWPnCi/2dVWVu+RzIJ4Pb4e9
   b/YNyO90X2jiqXUNTs2rumfx7v1dk4etnzazwL2wC4X8f+52ZgLffP/rt
   r9qLcxeyq5PTz1hnZhvAeSHUlkhEsJ87hVyiOzO6Vw6uVNaDJ7CSTb7V/
   w==;
X-CSE-ConnectionGUID: Pev6I0P/R1yaRTgqUzhL7w==
X-CSE-MsgGUID: ikK5VV+QTXKPH83KudC2UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27862755"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="27862755"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 23:44:54 -0700
X-CSE-ConnectionGUID: M1KIXjgDRDWBWO/O/PJt5w==
X-CSE-MsgGUID: TwY32H5FRAqN9YePFkPGHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="75734183"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 23:44:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 23:44:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 23:44:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 23:44:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPu4/N247KjZgmnJFNV6IM4w1ISv+lLBN3wqWQlNLtuQtcUL2qwyvFACusn+Wd1by3DrFnuiRt0XtwxGdVnFmSqt68rKnLOptG14UNGnxqBbXHYDbcVUaPJ1iVSnty01GHzvypWE7gr2rEfNiGwtL5iiIEkHA5TfP88CMaBSklxNBKeq1MzW6TgcGT/42kZJk0BsdmoN5yW03jCOrIs0lm22LvOToMFtfugz1Y70NnoJcQ4DVmkZEsH3FmBss30dWgstoA1R8iXISBkDQGcmSZmvUkaodUTrEHKGQ1XtN/IVtU0zIfbWpOnZpSiLy+GmFCh6e+4D/lxeqaP/jEY9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nk6W3CvXT3zktbC5uMk+ryHW0hubaOby9Dn5m+1XY2I=;
 b=rlDcBCURAS02WOcq3LyeJcYD9yg1xHXCxycLyiHFLHVIbl/py9CZM6SGDdB8IJjxIkvt1YyvWHabbx1t2UGnJaFS+pa6SniDDK6opaYj2DH6ypvRPqo7jFpwfYUnh5jaNgBh7IwUN91CwujpJOefOl5MizEsDg6+srlTDeYGAsazIMTr2GYq33fhTaJpRBRKw81Jqb9MxgWS36zO1+wSlRh6Ts8CCoh5LYiZljC1uDcn1uxqSo+NiRdawl6Mw72m56z9wSyXH34ZnA6foz1rFx5VInX8fZDcnUa9VvahNJeURJ6yLjzeDdP0pM2BnVChahBH93/V8raQE84wcZqPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB8720.namprd11.prod.outlook.com (2603:10b6:8:1aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 06:44:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 06:44:44 +0000
Date: Wed, 9 Oct 2024 14:44:30 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
	<vbabka@suse.cz>, Bert Karwatzki <spasswolf@web.de>, Jeff Xu
	<jeffxu@chromium.org>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook
	<kees@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox
	<willy@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Paul Moore
	<paul@paul-moore.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, "Suren
 Baghdasaryan" <surenb@google.com>, <linux-mm@kvack.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [mm]  cacded5e42:  aim9.brk_test.ops_per_sec
 -5.0% regression
Message-ID: <ZwYmTnWEhgWO702t@xsang-OptiPlex-9020>
References: <202409301043.629bea78-oliver.sang@intel.com>
 <77321196-5812-4e5b-be4c-20930e6f22bc@lucifer.local>
 <ZwTt/wB/mmszSXc3@xsang-OptiPlex-9020>
 <8f5e8ae0-dfaf-4b33-ae79-ca6065dc96ec@lucifer.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8f5e8ae0-dfaf-4b33-ae79-ca6065dc96ec@lucifer.local>
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: eeed2d9a-9888-467e-0faa-08dce82ddc03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2afu1E8e08l8AnQmFLe8GrpdFz2V9Z9vgHOYMqEuY1YYgPJECx34xGt5QENm?=
 =?us-ascii?Q?2JDtxwOWpXG/XlQ26iACbej44HYcF3NmvBZ77GIG2P8LvSS4fiYukZFoLPrJ?=
 =?us-ascii?Q?TWh7cgs/58dLB0EnRJzUi2W+oruog0OCgP7VGwuwqru4oDAfhHG6nlvWsvV4?=
 =?us-ascii?Q?4A+brR0g+6wtjR5XAyfgfizij4puKYyH0mDy7letWS3FWN2tD+JKecQz4yHC?=
 =?us-ascii?Q?M0CZoZKQA2X7IpxB0Lqp7USrqeJDR1XbhAKHa7QX0igBBoDmOnOI9gnhGyz1?=
 =?us-ascii?Q?2iSO3kWi+cle+yg1J/hpqo4MWin4kAd86ZbFKtti1QIOIgp3EHFV9j0vLDXG?=
 =?us-ascii?Q?EqiaXfDK/RtIb5W964ScQ4ghZiIu1LK2Br5mxX7K47wiePHPls+kqzJIzFId?=
 =?us-ascii?Q?tYEZRDFc2d0p5nB0aLJbCDne66wCgoTYJF5QNc8WNkiSuK9/FYIMu2jDBK0V?=
 =?us-ascii?Q?uNKJZvbdc0BKudPXIY1TZdsDj46KmT/W1ww8C2n6qrLR5HwT+UgXddwSLY0V?=
 =?us-ascii?Q?FvbM0qFKCIXGiSfOjF3oj5+Alq1NCIgLnlEiUtmmFfhT3oVK+WW8CLn3SjIG?=
 =?us-ascii?Q?JCFI6Ry1GoHHfEWbYPZZ19B8B6fsEakiWnUuw+Lj2UPyncnsfIzweOay+rqz?=
 =?us-ascii?Q?XgFkoiaQayrn67nzgPonCPx1KzabG6jxU4Nk535zB3qxYqGhBvFwe2Es3LlV?=
 =?us-ascii?Q?MSsKgTauNFuBkhRXNM5EGhjB0g+lvr3esrZZCm0Ww9KJWFt6o8YkKmvTeRwo?=
 =?us-ascii?Q?JW2+Zx6331BGIH7cX5EytXdL4fn2zLqnCF+sz/GGHFCXSXxwYVXhBpy5TRNS?=
 =?us-ascii?Q?ygFdxwQPPFeT9x42/ey8ImWr6PfKeXVvq5+tAdJl8lfKOJvDTxapaXaLvOk/?=
 =?us-ascii?Q?94agfqDWxCJs8S3m5Jat6Gxf3jbrDXSAAKpZE9FmUBkq+msNRd744n+ni9cm?=
 =?us-ascii?Q?PF9kmZtpdwXcle4pkqiolhY4DdI2RsQY9+2zWDzl/QaeNvahuGXU8PP6qy0L?=
 =?us-ascii?Q?iAaAG90T9hdCyHdyGnICKLcpPqDCCYidzna2/p8bsStE33oI2sduU3PizCCN?=
 =?us-ascii?Q?uYyH4/h0zrr1Y+bctgLKgi8HSILAAjadoDPyYfcWk2UpmJ+O7GVPAHqBB98I?=
 =?us-ascii?Q?NoqfXWb/eg05AaQSkMjzhEqAgkEh5Uc5ul9xRGE6nrv0CupU/s7kGrP37oG+?=
 =?us-ascii?Q?BkSiLDvQrf1tjxs7eHJoWmj3DAY+vxWOVbLaW4bU/TyihmdoN2GmhldwJaI4?=
 =?us-ascii?Q?TUT0Z9DJTeFVG22A/MRJ8xZIZAbBE0tBwDtGGHFQFA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wIYygoYfzo/exfApq8jSMcRfvrjyOmNM5zU6zAWoNv+J+O4OJzJGFnn0Q3q2?=
 =?us-ascii?Q?nDxv/QIeNe5Aa4On0TEgY+lOym9mDTgHBzyz4e2LoyLz2ez8hvB9nj2s39wz?=
 =?us-ascii?Q?xyYgqY4WpyN86iUsGVuY95IfHYNP9/WAUu7lj5zzc8CUbYqXTE/It+nKjS11?=
 =?us-ascii?Q?TTlBXnuZazuN1Ef9JVm621RFhxZ0agkIhAzNh6kzu4NkU4xzAC02orjflVQF?=
 =?us-ascii?Q?lAsjrDMRtuBqSIUi9jX7fYJUc4P0NOSbqaIbMmkalQznW5VbACZNGkx1vL9h?=
 =?us-ascii?Q?1oO9aT5cCv+Hlq2Zix+dYf9daupsLTDWtMjLYPush1qKXblRaz3MT53sTt/X?=
 =?us-ascii?Q?Kg1ajj9nADlmpo2tmz0qJ5yHwaM/nxpme/95Sw0+fzO6oC1yBNrUPkVf0v9v?=
 =?us-ascii?Q?nE8jzt7AT55smK/yN+hAjTPDZG0lc/kwqH8WK820Xp8lns+rujSstT7M1urZ?=
 =?us-ascii?Q?22lV2M96aZCjESezf+/usbaQvuCdsu/Bd0WWvqywUVyyrN54cQ6/PR6r2dBB?=
 =?us-ascii?Q?ax7MOMtkbQGLxLTRlSXUtjUlHgE0LQ1+1T5W5ElYu1KEhus7a5k/SnDY7OEP?=
 =?us-ascii?Q?c5xUdFKZoMHkyT/4yf9Gt73mNyocTGDCMwrX182RH1zPfzlZzjJDqAwde0Y6?=
 =?us-ascii?Q?OfTvRD2LHaE6mrM/l1LzwmXCkg2gUhWPtZu1aqV4mDWu2WjmZOlNi6iw/O+X?=
 =?us-ascii?Q?pp5OWQWtqocEshNchxqXa4apkAZ2Ctkgk/+smjfAUpRb85ILLI+iZigh6Tx2?=
 =?us-ascii?Q?aGRp832EAXCNF+DQZISL0OTb7vPMb43kU8oprboXPtSg3qnSmKDXznLMCnwv?=
 =?us-ascii?Q?RABisCT+u3to/qn3KoL+VQClYLxS+JEy9a1JVB+EdC6Rf1+l8NYPVD2quGXm?=
 =?us-ascii?Q?Yb++YZEM6WQ1Y4l0WtdJDUNeQiOMca9pkqOuyGOosn/xGE5bdCDCZLtdipAW?=
 =?us-ascii?Q?hZdQxSGGE21/gu2ncbualH1AIed4zBVfnbyFTX32tZgzhs5ApR3pESL/t9Ii?=
 =?us-ascii?Q?C7HUV3JpnK8nxudgCan/pR8IooRf/yyxcRZYhP+4zeAP9U1yZ357vHJ+xvT/?=
 =?us-ascii?Q?rrbCcX2bRTi4eowiVe6p0tXu0vevqSDLmbkQoNGEOgmsFX5/aEeqq5OdGiJO?=
 =?us-ascii?Q?ilMAb9g+JaYcDT8/Hi8N90ttpiUJMqdOXo7ex5tp/cTVO3iPlbtLUx3DB4XQ?=
 =?us-ascii?Q?4XDgknoOZ3o5MtWaTBYvfm+JHlQbX62Kd7H+9eB0r28spJE1Aidi7u2s41/c?=
 =?us-ascii?Q?O/E3PfcJkOn5hWxuKEvwPYK/pvaBZLlX2p8Hn81wi5lNQsfvJ/WyceBiGxKx?=
 =?us-ascii?Q?BqDnYjnyp40I7hb8s0aCBpFp6adaKbdC/2Tr35Odc1DBNVznNNBbLqEDz0bJ?=
 =?us-ascii?Q?gQh1BIz2XDjAbHGWDEESqBMNozXJYRXk6t7x76ly6/S5MALIwUdv4UzRjzlZ?=
 =?us-ascii?Q?Pvdhq3S0BQqiX1bfhWgtLxEbiXKxFnCBE/97UNcK7T/LaiiQF6uEI151gYay?=
 =?us-ascii?Q?gGvDUCHDB9Xruljt3fBWnY3JBmn1THZGCMVg2YPVg7vyvDlgk6T+ou9MGpIA?=
 =?us-ascii?Q?l2RscgvQ4LFhl4EFR+OJ0k3OjtdeAH014ai/Ztgx5yEx4VgDz2inw49Yo3d+?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eeed2d9a-9888-467e-0faa-08dce82ddc03
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:44:44.5664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xV0nOx0m3QLy+oUrtllMibtM0O2bKcyX4KZaDMDl4g5rPc9gmaukVnhiCe56JChDVLlVCd8/9W9gHdhB7f3wwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8720
X-OriginatorOrg: intel.com

hi, Lorenzo,

On Tue, Oct 08, 2024 at 09:44:24AM +0100, Lorenzo Stoakes wrote:
> On Tue, Oct 08, 2024 at 04:31:59PM +0800, Oliver Sang wrote:
> > hi, Lorenzo Stoakes,
> >
> > sorry for late, we are in holidays last week.
> >
> > On Mon, Sep 30, 2024 at 09:21:52AM +0100, Lorenzo Stoakes wrote:
> > > On Mon, Sep 30, 2024 at 10:21:27AM GMT, kernel test robot wrote:
> > > >
> > > >
> > > > Hello,
> > > >
> > > > kernel test robot noticed a -5.0% regression of aim9.brk_test.ops_per_sec on:
> > > >
> > > >
> > > > commit: cacded5e42b9609b07b22d80c10f0076d439f7d1 ("mm: avoid using vma_merge() for new VMAs")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > >
> > > > testcase: aim9
> > > > test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
> > >
> > > Hm, quite an old microarchitecture no?
> > >
> > > Would it be possible to try this on a range of uarch's, especially more
> > > recent noes, with some repeated runs to rule out statistical noise? Much
> > > appreciated!
> >
> > we run this test on below platforms, and observed similar regression.
> > one thing I want to mention is for performance tests, we run one commit at least
> > 6 times. for this aim9 test, the data is quite stable, so there is no %stddev
> > value in our table. we won't show this value if it's <2%
> 
> Thanks, though I do suggest going forward it's worth adding the number even
> if it's <2% or highlighting that, I found that quite misleading.
> 
> Also might I suggest reporting the most recent uarch first? As this seeming
> to be ivy bridge only delayed my responding to this 

we have 80+ testsuite but a reletively small machine pool (due to resource
constraint), the recent uarch machines are used mostly for more popular
testsuites or those easy for us to catch regression per our experience.

unfortunately, the aim9 is only allot to Ivy Bridge as regular tests now.
the data on other platforms I shared with you in last thread are from manual
runs. sorry if this causes any inconvenience.

> (not to sound
> ungrateful for the report, which is very useful, but it'd be great if you
> guys could test in -next, as this was there for weeks with no apparent
> issues).

we don't test a single tree, instead, we merged a lot of trees together to
so-called hourly kernel and test upon it. mainline is stable and is our merge
base for lots of hourly kernels, so it has big chance to be tested and bisect
successfully. -next could also be the merge base some time, but since it's
rebased frequently, hard for us to finish test and bisect in time, some time
we even cannot use it as merge base since various issues. it's really a pity
that we miss issues on -next ...

> 
> I will look into this now, if I provide patches would you be able to test
> them using the same boxes? It'd be much appreciated!

sure! that's our pleasure!

> 
> Thanks, Lorenzo
> 

