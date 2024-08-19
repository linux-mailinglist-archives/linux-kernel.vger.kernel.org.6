Return-Path: <linux-kernel+bounces-291444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A979562AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B577A1C213A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED911465BA;
	Mon, 19 Aug 2024 04:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfnyqtMQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E413D61B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724042696; cv=fail; b=Beykg7uEtItnul8tFxNh6Q7lqC7ac4hyguKC5c93UZiZdrJfIAHN1XcnoiBR585WHOZ1wgooeo+o48FRb5ZU6S5ImoiqQInveu/ykorvBiCFzurnpMi6BSl8S4ML8knKhp2I+DXRGGsp96tOnXXyneOgMTj1HuFksHjJIHisF8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724042696; c=relaxed/simple;
	bh=1cWQN6HaKiAvP1GKixvpve81bIIWCMfMJsyibLl1RRQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pvd3KuHPJbSOyhvbGWQfXUkxg3maCHdBSpArXa+242Z/5hTovG9Mrzm9TFD4sLiBFIaZQpvsqc2CefDEMjm6xL/IwPV9XgbfRZLD9MfvmmkHsSi8qo6P4StcCOKs8uMWBXIqi3YxAD++zzqoBM9d5DdrwzyBLTIXFZdDLNCpyFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfnyqtMQ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724042694; x=1755578694;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1cWQN6HaKiAvP1GKixvpve81bIIWCMfMJsyibLl1RRQ=;
  b=cfnyqtMQYLqVlvqgifeiDwhizmGkP6E+bE0LV7WRaTWv9MSRxHwYAhHk
   G3VwAuEH9lq2LYhDSbPjdOrRHq1GWcl/7b+v3hjblqNXyfEyusmVZI33r
   ghRxeOUZi9R1Ft36H18DtHfkai/+fBTAz869PIwdTmxXqWJ0WijuUAy91
   GkCxv+Nkr9JaLiinwT1+nbMvMewkY3JjlWr7zupxncdkuw4k+XrK+L7On
   RvFIp5kubXObcJoIKgmil3h9fozZDoSQOPhphCIecROxp5M2vLXjb1VW4
   k4fEiJx7uOnLteMCyW1vbG3efZ/fvQL770MksnKL8k7Y85qYuVbap2R9X
   w==;
X-CSE-ConnectionGUID: gcBN5G7WTRCusIlzQt3WkA==
X-CSE-MsgGUID: VFeewsMeQmW4H8myb0Qnqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22147995"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22147995"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 21:44:53 -0700
X-CSE-ConnectionGUID: Bw19KSc1RguumE333tLjkw==
X-CSE-MsgGUID: uwgYKqR7Sx+2Vs1katlYjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="65220798"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Aug 2024 21:44:53 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 21:44:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 21:44:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 18 Aug 2024 21:44:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YL2bXQ1pedSycWB//x8mg3yKrutE8l3vgSTXVEkf88H3WfNH7JiB+D33YgLSs0wYP1zVomVmtfhxQs41I/QzgUUk5u6e6CrQrcQ2Hr9sRYbdX7XSNEnMBC1L1foi1aW6hEMVXZ85Pt3VdoZijFDFPq0A6LvuOPHYeYeTdWu+fhp25+dQrRpTeiICKDkCHU2ZChccea2Dp8y/b2cTEfSXRNyuWEFbtJ1abRlc9d3DaZTa6m+fofuq6eaTKvzFoPIcEokttFjDtFu2xfbTvA5s3zLySbtxaJne8CPaFCdmT6pMM4nIDkoWZzA6P99zs06D+iWfimCqO1hLvNTqiyc47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3r18S8FVkjFWeE/uPA2c1pILRkhrVGishrthHtDGgk=;
 b=F+Q1fia/CZcK1pmfxLrqHzl1NUvjRFlB3jVBfx0fICbYLIbsJ2iUXSrl6tIjr4zIwQ4D+KDpGYTyzrwdcaipS9f+Q/rIlXbr+MyH2dfiZqKjWre8mqNC4H/VnRhs3pFF2qTeDM1y1r349UpsSLdkrS9QWpx09Ih6AJJOU71xh8LcYGZirHKlzoHrSizb3sLt3w7gBNQxhMqjlgCIydgitS7XhnrLCYFCs/EPFpWMDSUqvvB/a0aywsq389hxwZ356Ej5oq+wNdq8vRpHrpjwtIeBjukB9sAtXWm4tRuedibnvW8MrOSS5UbK8z/kptrrjGujvGlqIhcbRqpHAbuLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MW6PR11MB8411.namprd11.prod.outlook.com (2603:10b6:303:23c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 19 Aug
 2024 04:44:50 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 04:44:49 +0000
Date: Mon, 19 Aug 2024 12:44:39 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Oliver Sang <oliver.sang@intel.com>
CC: kernel test robot <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <aubrey.li@linux.intel.com>
Subject: Re: [peterz-queue:sched/core] [sched/fair]  420356c350:
 WARNING:at_kernel/sched/core.c:#__might_sleep
Message-ID: <ZsLNtymGVe5wk5vP@chenyu5-mobl2>
References: <202408161619.9ed8b83e-lkp@intel.com>
 <20240817093329.GA32430@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240817093329.GA32430@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MW6PR11MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9fc0a6-8d70-4db3-01cf-08dcc009a8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q2Tkut78SMEm1+9oZ+zS1ZIYdTjD+4HO5af7UantjtgDwWSj5esuxuCUvhos?=
 =?us-ascii?Q?0RV6I/zlDiIy304KkZBrizGNHlYqL/tS1qxlCO+qVI7B7u8nl/zQPgGpA3Du?=
 =?us-ascii?Q?RIUCtcB5SkfeHsl55oQJ9YpvADCiK5/heKdtHePNCSXzcFfDtcKD8IYFYgCw?=
 =?us-ascii?Q?GHH+LExN8jjs1TZNgYRoOmxtIcJ/seQVSgzFEXbU7F+HCXxWwk8PDEs3rYTf?=
 =?us-ascii?Q?q3wy0XMTLuj73Y6HPzWngGfzxCsvdZuSujpzOuY8scYZfULBte91zH7YF1z+?=
 =?us-ascii?Q?tTspX5raXSue1TJ/MtxgU+3AJ3Cf/uLF2M/Dxnmg2nNNfzcYckffAjRhdOi1?=
 =?us-ascii?Q?Q8cIzTJM5fBPoQtG61HXAUHa6vy2KoqjSD5HS/Kz/CzMFeen1b501WPKsOkA?=
 =?us-ascii?Q?8IV6juy7dlA9E7KpVkFMRzyhOFeo78kzBKHOI/JEauC9W3/62a3KC5APYtJa?=
 =?us-ascii?Q?Cb3d3uONRdQ/2yFFhvnD4qgXzLDQij1u1fdPWtNMDk8aewsp5Lew7m3yqT0c?=
 =?us-ascii?Q?zbZqjEXnGRI5tLqZYkXNJjxJPaKGaPJtdU5hCmfS1PkXbToLiuf5MDEZ3c5V?=
 =?us-ascii?Q?m212B0SHfuZAOQZRGy3Wy15gi9X4oHTdKcLy8mtwcUrkMkYdXAEWoH7YRH8N?=
 =?us-ascii?Q?SZ9f3+4UjDNu7TBPF6nnV0OTWQnGKfQ435YI56kb0X/GL7UEoFCjuI5JzpcO?=
 =?us-ascii?Q?SrlSFOjwqyNS4wcAIu83F5UXzEgUuF/nwI/4pfEUFVbIiPxebqKyHfSgIPev?=
 =?us-ascii?Q?raMyIWszKNcbSF29DQstK2CUEwR4L4OcZbTtEaYDLkafzvlXSJ0vtZUPLPrv?=
 =?us-ascii?Q?eDxnTv6X6EFeAI6zg6fPwDBc1mJKuRMBBnMhYr2XV6uyhMsV4W2MAGRn5mNf?=
 =?us-ascii?Q?KxnN6NwQJCDyPuabP6Rht2Zd+1r9HD1z+ietYKmPB8eXmuraogHMm0jFDNfz?=
 =?us-ascii?Q?5CsQqoZou/OZ3V/Iyc2Cs9owAwgdEFc4MBZ/Ildj6ChkFZVcZ/esBknw5z7o?=
 =?us-ascii?Q?jKkI6C5/0bU1K9pz/9i3eouNFI2kjIbDJ5LfUlWb8aGj9X56daeasFo8536Q?=
 =?us-ascii?Q?LQV9pXxkvV5PrW7CWdXC1gb8HPI8ZTpxgxlhKCuxAf0aFtmRs2I3ubftTI3Z?=
 =?us-ascii?Q?1V9Et4y6jfVCKydsrzen7WcizZqvSXaAhak6QavAU05O7zRUxHnFyDg6SDMj?=
 =?us-ascii?Q?qp1a8ACcRIrYmN141SVL52MZzMLeWiKKsTGmkgK7nNEOzqKEvZ2pvi0BO0az?=
 =?us-ascii?Q?9i/UWWazFDYk3s7n44qA99qiriMeK3a4+nLwCW/Jg9Vk5+KQMjrPLDel5ZMP?=
 =?us-ascii?Q?0bfmpZ5IrHLyIGr4fZgJGhdrYwa+odz2tmVRIF24vJ8D8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pHxLhe4GKsI+QAZRz6LlSCsYH63CwJXqS+AUEstxz97HhZ8xBufDm3fjueC2?=
 =?us-ascii?Q?xIVMEPCKhRi9/4hfcJW3Cxvc1HxQcVFT9ergry7Jim/7kPHNADm4Qs6vYx2Q?=
 =?us-ascii?Q?YvRNPzUfvOdqr+E1hgdIyAplG5ajDwN7WOPUaAIEE8oCmKm5R2PSPoWBFK21?=
 =?us-ascii?Q?eOVDAjHrx/0WVe8+xquy76qABUVQ9h7pD0Rthil5SHd8FbfvOw8a1Y31uSFV?=
 =?us-ascii?Q?6SZ4L+qzIPUqMGfHX4OUzycWOgA5SVuwhpJkTfli0SZyRkyfbxNRmybk2nWk?=
 =?us-ascii?Q?Tzd+ON+XbTkek6GzsOzcawsMRGjpg4YZ+2vMGFxLI0R0osd3vLBkt/LZ28SQ?=
 =?us-ascii?Q?EF5NzIwLWlvH44BE62CwEOu0FXRno0M7QHUIHYacWBHwsigUm2xpxSTsgfm7?=
 =?us-ascii?Q?ZzHdtjHQf4DP9M618QQimJyCzwe/P2dN9aG+a3fSTuO9pwo3uoMvT9Nv+ejo?=
 =?us-ascii?Q?8vvPmnRLUAQF75S7Bb178qHwTjGdtnOoMWHc8jrNGJE86QCrumcB3AXWxcqs?=
 =?us-ascii?Q?dUCHtZfKL80yHLEQul2+/h8F3os3wkES6hqneYNvNCrbmRx5IQI/BRmKq1LJ?=
 =?us-ascii?Q?/PlR63xM8RsV4wIXQTnIyZToaCgqcE58/lln4+OO/ihr5Xad7LX+k3Tz9Rj+?=
 =?us-ascii?Q?gbJ157qResZC5cOHgcLhu9H9R1VxT/kGUEOS6dqi7ZJo3A+YajyFgLLLWSAi?=
 =?us-ascii?Q?Y62lyPwM/Xnf5XWIASdnRGzQexvPBS0qVQnwLiZv2KIBLKZHBzckytRpsmWS?=
 =?us-ascii?Q?S1YQahq4tOajGTj0lkR8YbmEui/CikKlwMzLjvqTJIADXWOB9hLMrSAJSWE4?=
 =?us-ascii?Q?eCongmsKPy8Xc8YtdgGNvrIgbsOfLt0JfVipWpjGwPS3afkDAb/Oxje9soEm?=
 =?us-ascii?Q?fvAv6rcmfTBPD/5C3aPMZT0BI19eOZ2IAf9GaTWlXcqWgInhOKA8bYfBANnE?=
 =?us-ascii?Q?Ijzl/7fX5fhwQr5d+uuf5RM/dLGIpWhkpqvZTfyOBiWa8SpAd9rftqAFQYD2?=
 =?us-ascii?Q?W1l969gZF/hiX0pxZhgoZSC5D1tPZiuDNv3PkQCARfFojBIpfMKuRzqIEz3Z?=
 =?us-ascii?Q?R+HP9mwZo+2UEhzFGcBaMUEmdCoyc04cifmXEAkptdylRlkSEi5CX56SUe26?=
 =?us-ascii?Q?I8FSWWepakGK9XEGpoGB/BPriY+e+yAGu3DiSQZPjMtjvXWy1fkOek161CkQ?=
 =?us-ascii?Q?s01gUklO0uQEFXaXSZqaRuJ60ZfBmRNkZy+Ho/2ubdBnuIbbTWwbxLWR+FL1?=
 =?us-ascii?Q?k4xTPm9oVNhz7yDzGUN5ay6LJ3jkrV0Lr2UXuc9TPtretJy2zhlKerxXG27a?=
 =?us-ascii?Q?M78tVQcQwLPhjuOV0n45CzBmWNO2B4Td2dkhcRgh3WNiI9jG0aoXeVAOGa8l?=
 =?us-ascii?Q?NTmiEUuBF0GUcjA0YEyPm7+0J05lhT+D1LeKR3y6JBSHnWmdbx4fWN5JT4Gf?=
 =?us-ascii?Q?/j5/AZAyOb7GAeIMyWXaORtGB5+RDa4VFYy/uP76S7ART/oAeIT+b1ZeSwfw?=
 =?us-ascii?Q?t3DJEP8O6Hu0dGVOtAEvFNJjamj0+WsWQw6MaCY+K2SO73aJ8kT1x+MOmDmz?=
 =?us-ascii?Q?nwrzC5sVl/8LmxidarrLuGCqGbUfbZdvwyB2MjK3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9fc0a6-8d70-4db3-01cf-08dcc009a8bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 04:44:49.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EllnT8sjnOpTuZyreMoFEeBqN1MhWP3VojI0o7rF8eyU0T0AOESyEATMgeHYyKP6clQ9+V7AFlVwf8wlgj1e/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8411
X-OriginatorOrg: intel.com

On 2024-08-17 at 11:33:29 +0200, Peter Zijlstra wrote:
> On Fri, Aug 16, 2024 at 05:15:12PM +0800, kernel test robot wrote:
> > kernel test robot noticed "WARNING:at_kernel/sched/core.c:#__might_sleep" on:
> > 
> > commit: 420356c3504091f0f6021974389df7c58f365dad ("sched/fair: Implement delayed dequeue")
> > https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/core
> 
> > [   86.252370][  T674] ------------[ cut here ]------------
> > [ 86.252945][ T674] do not call blocking ops when !TASK_RUNNING; state=1 set at kthread_worker_fn (kernel/kthread.c:?) 
> > [ 86.254001][ T674] WARNING: CPU: 1 PID: 674 at kernel/sched/core.c:8469 __might_sleep (kernel/sched/core.c:8465) 
> 
> > [ 86.283398][ T674] ? handle_bug (arch/x86/kernel/traps.c:239) 
> > [ 86.283995][ T674] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
> > [ 86.284787][ T674] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> > [ 86.285682][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
> > [ 86.286380][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
> > [ 86.287116][ T674] kthread_worker_fn (include/linux/kernel.h:73 include/linux/freezer.h:53 kernel/kthread.c:851) 
> > [ 86.287701][ T674] ? kthread_worker_fn (kernel/kthread.c:?) 
> > [ 86.288138][ T674] kthread (kernel/kthread.c:391) 
> > [ 86.288482][ T674] ? __cfi_kthread_worker_fn (kernel/kthread.c:803) 
> > [ 86.288951][ T674] ? __cfi_kthread (kernel/kthread.c:342) 
> > [ 86.289560][ T674] ret_from_fork (arch/x86/kernel/process.c:153) 
> > [ 86.290162][ T674] ? __cfi_kthread (kernel/kthread.c:342) 
> > [ 86.291465][ T674] ret_from_fork_asm (arch/x86/entry/entry_64.S:254) 
> 
> AFAICT this is a pre-existing issue. Notably that all transcribes to:
> 
> kthread_worker_fn()
>   ...
> repeat:
>   set_current_state(TASK_INTERRUPTIBLE);
>   ...
>   if (work) { // false
>     __set_current_state(TASK_RUNNING);
>     ...
>   } else if (!freezing(current)) // false -- we are freezing
>     schedule();
> 
>   // so state really is still TASK_INTERRUPTIBLE here
>   try_to_freeze()
>     might_sleep() <--- boom, per the above.
>

Would the following fix make sense?

diff --git a/kernel/kthread.c b/kernel/kthread.c
index f7be976ff88a..09850b2109c9 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -848,6 +848,12 @@ int kthread_worker_fn(void *worker_ptr)
 	} else if (!freezing(current))
 		schedule();
 
+	/*
+	 * Explictly set the running state in case we are being frozen
+	 * and skip the schedule() above. try_to_freeze() expects the
+	 * current task to be in running state.
+	 */
+	__set_current_state(TASK_RUNNING);
 	try_to_freeze();
 	cond_resched();
 	goto repeat;
-- 
2.25.1

Hi Oliver,
Could you please help check if above change would make the warning go away?

thanks,
Chenyu

