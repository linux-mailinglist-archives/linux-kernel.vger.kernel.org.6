Return-Path: <linux-kernel+bounces-254653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C0C9335DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB5F28457C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D96FB6;
	Wed, 17 Jul 2024 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fc32LMv1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E9101F7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188398; cv=fail; b=rXExxuIVMNVCGFjnDnpR6SUAtK0/OSKfJbPYnOEMn0nIBbPCk/bYV6mq6uvh93bZNbu9YHQ8LG2CqjgzRe+uvIiUYcoErot5f2+xnz3K1WvHpLgQ97dTjVYvnMvDhsaVF9+EmMYW3mGE+FpnAfJxofMiQ2K5gU4S4jtvMqOBziU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188398; c=relaxed/simple;
	bh=GSebGXvA5Em840rpw7hmIwddK5LsJFHl0y4OFeS7AKQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rZuoELGL21wyUdEBm4d4htkwMqKE29Vc6mNSxix8cs1mloftguUWd/W3Otn+kkDn7bXTswYjMI3FR91YslzW9Pdnqi+9K9vL2ghKDvpIWIGuFyVozuOwvOvxg0qlx7MZSKlVfSI4b+8HEY0vvXwmG4WoT0bWjLlFtbadjfqouqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fc32LMv1; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721188397; x=1752724397;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GSebGXvA5Em840rpw7hmIwddK5LsJFHl0y4OFeS7AKQ=;
  b=Fc32LMv1cyHLtrY2X/iPto7k69jNOBZ8FmuYu7XGVL2RZMTJ5Df49wCf
   GNBPamEsDj56WgXC5q4iZX8bwB0o0NAfco0hJH2eH32u5Cuplw7ChVm/n
   xmCAULglc1UDQjt1/sXiFtaGNDkQiK0UOjMubmSNPvDuKYI+ejUR2RRNu
   m1ZMoESHAfiGsAVsMACCJloDuGAZezfbTuwTa2avN+7Umrxya4f6X2nLV
   Cbtv0Re1w18MNzNQSxP1RZPwZXAbYs1FliZqfsAKKZDGrpSBZT0Q9Ir/J
   0hjCmsKkU2F0j3altcUJ2MrHRThozqaFftsmV/2zDf8yvEaKaaEhornkq
   w==;
X-CSE-ConnectionGUID: wBaVpunnQemm2/x1kAvm/w==
X-CSE-MsgGUID: 9fBDShnmTe26ZHmcOcCdJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18367310"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="18367310"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 20:53:16 -0700
X-CSE-ConnectionGUID: V2eYMM4KTYSIEypuxumrWg==
X-CSE-MsgGUID: klUl/jsNSY+OpP4Rpxpi+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="50045178"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 20:53:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 20:53:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 20:53:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 20:53:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 20:53:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSR7zmhjOjXcxEUGyJ0d+cpkNmVeUDyjtE19gn21y6lGy1wJuUIOMFMZfIsV//oCXClTE7l+MYQ/GMfZnJwvEO415C2YNh0m2p268xQ+dSSewv/PsIHqIlVD2PnrFhNLLzqFehbsFAeHl0x5ETFAWmAe3vqb7p0q4iMvuWt/0iS70Y7AK00M9MW+1jF0Jtj86vK97jangZo8LaW7tG+ZvWXpQQQO3htz7nZKcOMYo/6V5c6dx5j07kRrgMYfzuegZeU82WeWj8lFt4MUn1xE7YxwY8Qk3SfwOnSufL3wxveAIIcVytZ6lovhmKQLxEjLmoya6ueRSyMZc/33P2Zctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WREssUKG43LmA17VLzYBunIaQInJfugi9Zhqv82WTZA=;
 b=O3fM3atYuYay9qp9Ra/Wk7P26kaqIpZPm6SYTg8QhCZvyQbD5FkTfGVLhsFgIns1+DeIWTwAu6P8r/NI3NxrkZoFwXT2zPBCgCXLukO8XR2685sJ3/tCDfkFhRPgqQwVv2xMpO9kEbdryQlmefchKqn8YKJWQ1/UQQ6twHCLPjat+EngwMAbRLNrTexCjv3b/RW73LCiqxHVpp7nbxtVOKG1e0LA1N0g3l1weC0zjZsgRbq8lbFR7kdw6CBK95fH+jZFmfpwePXOP8rgas0vF1EcDZ3NOBGvKWVq6l7BnsmeaVzCHH4dq1oYKCqh0rigo4RsyYl5r3bbaSpP5bJ5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Wed, 17 Jul 2024 03:53:07 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7784.013; Wed, 17 Jul 2024
 03:53:07 +0000
Date: Wed, 17 Jul 2024 11:52:49 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Matt Fleming <matt@readmodwrite.com>
CC: <aaron.lu@intel.com>, <dietmar.eggemann@arm.com>,
	<gautham.shenoy@amd.com>, <juri.lelli@redhat.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <mgorman@techsingularity.net>,
	<mingo@redhat.com>, <peterz@infradead.org>, <tim.c.chen@intel.com>,
	<vincent.guittot@linaro.org>, <yu.chen.surf@gmail.com>, <yujie.liu@intel.com>
Subject: Re: [RFC PATCH 0/7] Optimization to reduce the cost of newidle
 balance
Message-ID: <ZpdAEYN1vwlnIGiS@chenyu5-mobl2>
References: <cover.1690273854.git.yu.c.chen@intel.com>
 <20240716141645.637620-1-mfleming@cloudflare.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240716141645.637620-1-mfleming@cloudflare.com>
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
 DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH3PR11MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b79bae2-6d0e-4de2-46d5-08dca613f800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3csrczP2aKFcmOPBSgWSZP4PuZIrSK+yDr6K5Q577cPmKGuMm4BqHTIsQZTQ?=
 =?us-ascii?Q?30XHxW9C+dXaAcKRrIBtxP2HTf2vYJ2IHccctOnkJCSBgsN9zxnjAKzIVid9?=
 =?us-ascii?Q?YyEYgTfIfvNxgGjqVrbVk47PQbHptt/6vlP43FHOvGHdpfQf1JMZ8ZIP69kZ?=
 =?us-ascii?Q?ZFDQ+Aby8LU7k5lKd0CVOS8OUOGT8OIYHAHaOLhSG4+2dTcAe1shI8YypEjh?=
 =?us-ascii?Q?180Ug3LBHQxqLhvVdKLEI6yTx2NCmspzdXhTVLie/fKDzous1rzkho4U0Wbr?=
 =?us-ascii?Q?tQhXsuvaqJLKA4ltL7KlQxUFUJgt6fOizXzdnRUFQ8VZwlNb2XkhXKEPMYRh?=
 =?us-ascii?Q?EF+oDmcuErwIh3K860u3dxs6kpvS51i10ttwCRdPznvwUnV9yGPMEVXbSFV/?=
 =?us-ascii?Q?j0DawbtPLJDlDxR7qoGXgbQByjSFUPD3+j7bk6UN3qpvsOlbTMPaOGMwCZmS?=
 =?us-ascii?Q?+J+7UuzouaDpqc4jAs3hBI1yQu6D4RRdAJVJ2PYrTc0fDjadD7fAoeB52TnB?=
 =?us-ascii?Q?+0xDfd3+AnQ6szEc14Me7J7+JzBEjxcgc+3nFPDXk34Y2pN+x8VJdEKGG5GN?=
 =?us-ascii?Q?sPXOzW7MYfpSnol9S5MDhJGcqT7hpDsAsuJbwZaATdqiH39VcNpnBgB8w+Hp?=
 =?us-ascii?Q?ZPM42+kQDmCtktZQJ8lsKIO7JW9Zu0nTol+jgtdVlDMhHFrX/M4r7gzUJQxC?=
 =?us-ascii?Q?GBOmt3mMVWfvX9XUjkMRESBZwWEBNxKUfrlw2wVpniZLQoBIzXw8+NibDrNE?=
 =?us-ascii?Q?1LmX8tCSabnYYSTQ2tWWwahG5y59JkTiFIpR/P4nnzh3QDNMMSUifbfdz29X?=
 =?us-ascii?Q?13D3Ct2qs0nkMjc96N22bwrQAhMGcmp9T0hE7j8/YUiIcyXaUTykA75U6nHf?=
 =?us-ascii?Q?Z/KpnEV8OlqTVJpUhEutXIS+wFAxcXU/PVC0uLHNNxC4jhSGhPySP4GG3oSI?=
 =?us-ascii?Q?F+xGmIX7m8qINlT6/nD9+jYScbjAuDOCAcLzEVYvMK8uZR7e8wWsIV5VZQNx?=
 =?us-ascii?Q?65e21HKSCoFtigaUHb8camJtdHorkqWXwiI/tD1hjkoYkuAiMmccWqX+UpI2?=
 =?us-ascii?Q?N7HoogR2p57Gn9IsrA5b12ivPLkKvJGjmQs6K1l+FP5AZt35GQxb2kmhV897?=
 =?us-ascii?Q?omOz/fAuXePKwAFMgw5/TM62Ofe0kwLbeyGCNEVAm2pEL4Grlky8necwmI4A?=
 =?us-ascii?Q?vrtRHYxZl+bgmBL6tUHqPEXLbI0+WYMbqQzg3FJXNnST6bqjvpVB/0i2KxRY?=
 =?us-ascii?Q?rjvQGIAtQnXgLHZeZOi/gZObA0oev8rwDpW8+Jvys7C+MH1hAAj46cYUoBnF?=
 =?us-ascii?Q?uUc5xXP31AHAO9Cm28dFnzMmMMmWD+hfh8fVkyvn9wlRdA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fH45dVxZlAM3ghk/M9tkp+fwbvcph17qMqPJyU1jFzZxDLv/FWqBsQrEJ6Ge?=
 =?us-ascii?Q?Nu7uFn71cn3DjdVVnneuHMdEqE331KnKTBBQiSM1lRblY6UyCX753R15oQnx?=
 =?us-ascii?Q?750tJl+5aLnwVkxZdZ5wBemvsS7sULf1ozQOhjHLqZMTLkjBKqrBsec8jZSX?=
 =?us-ascii?Q?Z+/xcpvGJ/QFu7t9fwLIT53VuQwI4IHthw0Mx+gj8KC3rhO0DGvEd+QoFN66?=
 =?us-ascii?Q?2CHJXEANn96H/kwCD5FoYRQ7hcc1il2HhS97OzhY/S+qEXcOaCca/4Hp9jNv?=
 =?us-ascii?Q?V+ljWI9/mYMPowv1aYrMK5sqfMTuf9h+dbjbfCgYGeTf7aN5jQLbolNyoZK9?=
 =?us-ascii?Q?YcoJEwQzz18VwU40oeUyl8hkunsBloD9n7ysDzA4JYPQ7WL1kkuH/ajyW4Fm?=
 =?us-ascii?Q?mucQ4R6/6flke4hufAORcYHDEhdIWBAP8yQzlc2gpuFSBcD4y5KK5rGTfM8z?=
 =?us-ascii?Q?rXS2uEHDn09khZUAccY4dBy5HI7/0706/1j62tkjzcgQjpiOsIPVchVLbjoq?=
 =?us-ascii?Q?UDsVh+hy0dYd1Kk16NaIIigKe39KVxsdIC+/BhOgHSoL+08PIidudCZxKDJT?=
 =?us-ascii?Q?8fkQxslqzBHJbeh7BUEvy76GxG31yRmuhVWyhVWSph4IF58rUT0bPWnL4TMd?=
 =?us-ascii?Q?yJCaqqqpcd/sI28QQ62vT406csU1XAELafO/QTSJjYoX3opys8iglPNvLjJN?=
 =?us-ascii?Q?PWWyv1NDXYaU3MTWu/L7R/Y2wcnYo7hIueQjfsAvi2oR0RwQmve+Wv9j/rUA?=
 =?us-ascii?Q?i98RGaOjtgiivKmQgYgX5ovmt40a3WxzBZky4Ih8ietcYL466+DyjB9Cou6f?=
 =?us-ascii?Q?uW7jqnf5dZltTYjVAPCPznxlAs/YpyhisxM5h5FRgRaJScBwuByvPTlINX8l?=
 =?us-ascii?Q?u7cIlWFafxusZi2nuLbG+5eH451gq1vj4Jp4QSX5VfP7INTF5Ho56KhWyUXh?=
 =?us-ascii?Q?zBeAnMFnvjgJzyDwT7LXB3UddIlBS4mSyKBtLm1eFdJxZP7yngxAc6Tv0FHc?=
 =?us-ascii?Q?FSGONVycxtlxsiXlgTDkpA2/1D5XYVxNa99RzbjBjkBNwXHELvGxozK3w73e?=
 =?us-ascii?Q?YLgvD2Kt/+ljBWifVihxYtJ2Ef98Zu7mqFdhEOaDtTPowfJ6sW5gMW9CIw65?=
 =?us-ascii?Q?FHPDe84mi0QkRXifiREmp0FyxFreioAWaGrIhz/xlVSCvVph3C4rZ7ONaMdo?=
 =?us-ascii?Q?OA95RC41a8L8bXpHtwcYiDZrayKLgoKLWKpzGJ3746RynKh6gYnRuCCX2cPh?=
 =?us-ascii?Q?RPRKmH2pswhqL6C6Btq8PrvRsKgeXKG5rovZVWBw4ZfQKb4/fVOFs37+2/oo?=
 =?us-ascii?Q?gJW47t1CqBBOD8lZT9A0O4lFg4GIhewFgiIEZHJaY1q6VujSn+eAwtEKN4r1?=
 =?us-ascii?Q?OjygabczlTpaxkxFss/TcZr/k9du9VJ39YvcV3Sk8jou88fjGnZ/45ccdtGf?=
 =?us-ascii?Q?dVioV7XMKnh5guymFh+afkuBA+nWt0LDqTUJ14/nt3Mdl2/jTqKpTrYAzcYJ?=
 =?us-ascii?Q?TX+T33mgs/UKtcB3q/lpcYHLuFGwEZdgMGrwhHeSk+1mmJH1DaLBY1CuJhBv?=
 =?us-ascii?Q?9Fqe8oC7bJzf2x0gt8qtswAHSaOzl77syB4DFyap?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b79bae2-6d0e-4de2-46d5-08dca613f800
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 03:53:07.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdjvC7HxSCVNRLkVNmU3EETt05xdyVdQyUYT5iKqXJCSyP2Eig/xi7s+5z39diHaMRdC776Y3P7U+9HiygfjOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7772
X-OriginatorOrg: intel.com

Hi Matt,

On 2024-07-16 at 15:16:45 +0100, Matt Fleming wrote:
> > Hi,
> > 
> > This is the second version of the newidle balance optimization[1].
> > It aims to reduce the cost of newidle balance which is found to
> > occupy noticeable CPU cycles on some high-core count systems.
> 
> Hi there, what's the status of this series?
> 

Thanks for your interest in this patch series. The RFC patch series was sent
out to seek for directions and to see if this issue is worthy to fix. Since
you have encountered this issue as well and it seems to be generic issue,
I'll rebase thie patch series and retest it on top of latest kernel and then
send out a new version.

> I'm seeing this same symptom of burning cycles in update_sd_lb_stats() on an
> AMD EPYC 7713 machine (128 CPUs, 8 NUMA nodes). The machine is about 50% idle
> and upadte_sd_lb_stats() sits as the first entry in perf top with about 3.62%
> of CPU cycles.

May I know what benchmark(test scenario) you are testing? I'd like to replicate
this test on my machine as well.

thanks,
Chenyu

> 
> Thanks,
> Matt

