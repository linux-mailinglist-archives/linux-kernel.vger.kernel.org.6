Return-Path: <linux-kernel+bounces-446444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E52D9F2463
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A49188666B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5CD18FC81;
	Sun, 15 Dec 2024 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLnGvMmM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F45189905
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734272873; cv=fail; b=m/p2DKwIuZ8wQd0AYXX/l721JrZVZ7gKX+M88g8BvMufXKyPp0Yv3Jd3WinF6iofiv+FXwAg+xgRDu42KOjTIkWRaFXRLFneChgbSYdXFGfWytDQ8bQMlipkoi3CTmuZMS4tyovom1/jsdn5a2A2Dt4Y1z0bW4fImYwdfycaiHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734272873; c=relaxed/simple;
	bh=+SGs9iRfv5uFnpdcww3huWi1tdBM+PPhH1bdNffRPbo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jEnK+XGgVI2i2Gbt4oQmx7UK1KfmlU30MKTqfhgRnUoDve93qcO32BL8K+NQ0p7R4WywkjhZZsq26W5rutGM8QnnjqOiYfIPp7Fpwxx8JZK2A0N43fHAGwFDe44I3BO3+6ojSYkl6gYaOqFnqI9W/OUxLlC26ltwkquJCb0PATc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLnGvMmM; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734272871; x=1765808871;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+SGs9iRfv5uFnpdcww3huWi1tdBM+PPhH1bdNffRPbo=;
  b=LLnGvMmMShEea7rz5bsn9CFBJpTHWb1+Vp5ettXW5Y9kiViCNURtPJ3Q
   BeJzunS/WzvH9MzPjj9kCxW+0e4377BYqtTTA3WLEegO589sp6vRtoxiU
   uCxTpY3nMVydmRgXpsyPFpeGV88mDzUlee9WBYjjlqDxuG1DiccR4X49Q
   xTBwsLU/aeBYXMtf+51lFw0Xg/J8+w7c8XMxODFh7b4ugRs45cUKgqEKh
   7T+tMaanbiwe+yMhy8vK5Zo53Jidv1Rp5JSmh7HGsCEkq32i/kfU65/Gw
   l5+f1E3ZacVHoCXNz9WYGFvT3JyiOPqIn+lVo34Yh0XisMggBs77Oqplk
   A==;
X-CSE-ConnectionGUID: h5UlH3VoQu2IjsG9B9lQIg==
X-CSE-MsgGUID: PZfqRZZBR2iRr9NSU0bwGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="52185286"
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="52185286"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 06:27:50 -0800
X-CSE-ConnectionGUID: OjSB6xVVRPa015kd/tb4cA==
X-CSE-MsgGUID: LFao+8+MSVaGd0BaQm4KFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="97204338"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2024 06:27:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 15 Dec 2024 06:27:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 15 Dec 2024 06:27:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 15 Dec 2024 06:27:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+03Z5ZbMJZJcajdOVGPolWpGFkErVivj1DjoTW6MGy+YRFljxiZK6YOgYsq6L0u+MqLWSF/Qj8R10AVPZ0ASAxVKn4PFsoTs/Y1Wn9MJlfAZDykhXTuLACOcadf4syH5Bt3isjAthGkwsx2ad7cnvhzN/SsTautm/vfpUV2ZSBOukvM8OP8xTfEnWLupzz0qyHcxpVu3Wx1HVBJ6yHSycrQ5nEm8/23f71g7iXkHS/0CqhY6jPNymIeYIvoDXQv2wtlNuEme4PPTVHrWoCHw9yHnwFyUHjJjKmkyS4nAt45QzSV7NXZRPDC5DZcBrF8cyIw/I8ey3rCeNo7PGQWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rd6ZscZgkkoFRAlQBnb/kNgGYro1VsUPS/C5ksXq3tU=;
 b=CBTHxEIWM5QrlDNvPzmzyOygWqhLU7Uqom4BG404R5ISaTG3mUzEoI9WgWMi/vph/7FpCMhirnlJ3hDvUnEEvR7c9kp2hwMzJBayFisbcKflbDmwfbyU+KEf4Hipwj7zsvpd6/+I7AQgPoZldBR/q0KAmD7nnzT6LBQrVz+dyFo7V3FXrwkPznCjDlHoE8CmJ2c47pIG9tW54b0EU5h8pZCxI8/yJURuU9KMQqaXgwP0N+pnmtf3BDyTLt2QPJUbzwihkNlgYF3wfO7DLFZIBv65BEKUphzXY2VzpYi53KCichiNZcR9Kv9icgrO2L/WKhxdHhCVKDvy/6B5oBNqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SN7PR11MB7640.namprd11.prod.outlook.com (2603:10b6:806:341::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sun, 15 Dec
 2024 14:27:07 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%7]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 14:27:06 +0000
Date: Sun, 15 Dec 2024 22:26:58 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Kees Cook <keescook@chromium.org>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: kernel/reboot.c:226: warning: Function parameter or struct
 member 'cmd' not described in 'do_kernel_restart'
Message-ID: <Z17nMtLdGdp6w+nP@rli9-mobl>
References: <202412152053.KeJr8B5f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202412152053.KeJr8B5f-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SN7PR11MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a8b59b-a6ea-40d5-11b4-08dd1d148d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8BcSw535x9otrs9i5skXROnGy5FmSHvpVQbujD2REd7qyHtEPmNJyTxI1wbE?=
 =?us-ascii?Q?kV1Z00gsF9Sgin4q2YsM1dy6OdZtMx+OdwyjaoSrFNjDEUhwhFROIuG0AAuv?=
 =?us-ascii?Q?k5b7490KGgeVk5W0H8mFtsqTrsMXjG7oQA9OYZEIB6cbS5nXoG9BQcYkF1zy?=
 =?us-ascii?Q?jLTRKdQbepF/u2SJFiII2CHKlpak3MVe6wzsnuIYl2mhHJG54+IbVuocJKUq?=
 =?us-ascii?Q?PuV0lxAsghI+J7p19RvRQ7Mtgp5Q/h17jokj1Rp/uthi12S0xXnPWcHpOqiu?=
 =?us-ascii?Q?ZsuI5d2YpL4K7SRrWg4YKJBhB06iZeQVPYsUaF66UVr75aMPcSUhc9Ph/Rkk?=
 =?us-ascii?Q?+IXNpSzGw2XTp0kmPXnu/lPtYR116v9sf0vYNqzcLnNTH0ESq47k5E90KyA3?=
 =?us-ascii?Q?EqCpKDoaRWeuAHceJuCJAvrgkp0fL3+5k3zh1aPNqvdbx16GR4T+FDAjOCQ+?=
 =?us-ascii?Q?PISyzOG8OhCAZGRXoI5ODnthuGoyrMWbwUVIPQJCqPvb7GOG+tT1SOoi6LLM?=
 =?us-ascii?Q?f4nZtw01pcLtWH2oIBt3gLmUrDFptr9QeUxv62vlrVvdPGIdy++oNty407s9?=
 =?us-ascii?Q?n46zXMEzVvaYJvSnK9Uvfp4Id8Of6se1KzjE5GM3LjhsxvAiZxwJ/Gqho4ky?=
 =?us-ascii?Q?nLevPRFWmRFD9rx1zyXWt8jc/fD/GmQVWG24T9kuHcZX8djrZVNs7DEYXG3p?=
 =?us-ascii?Q?nktkiMli4IAX5nv92VihyEiJZzfjpm3Q+8Qbvigc0QdtUJj12deh5jbz4xWn?=
 =?us-ascii?Q?yhb2qkEvmVcPe9VpoamlHvOfgMBCUl0ZltQKoKGnGIWFmMKvkOx5AfNg1HNE?=
 =?us-ascii?Q?X2nu2Kk6tFVdFpUKdMVvzEk+JVlOzt82YYkwBqud9M/1IApgJY8lrdp941OR?=
 =?us-ascii?Q?jmW+af3ADifZBhVfv4HVvxCgf88mpVMAA2ztYDp0jEzlOZQ37hMwkaNhzZ/S?=
 =?us-ascii?Q?AkeiLXWpFj2TrrdnELx8xPO/kiau/F9oFuvmkTbd7Ant9EBBrwUkILv64OKS?=
 =?us-ascii?Q?rnyZbNjcruMNfayAmtXxtdXhq58ZfSxgYaoUh3svSRqe7+5NTd4Ntv8ed+Eq?=
 =?us-ascii?Q?jeIP0vLtrBF4LzMyqr0FKNRU7VzOwh2cIESYF8+YGKAfqsTQwkuIXF2AeIQz?=
 =?us-ascii?Q?GhTvopnPfXr8hB2oL69kkYuEPAPMde1sZUCWwJWrA3dCz/PVgcFJ6mRzYEcU?=
 =?us-ascii?Q?QMmMTxNB43HUZl4iPNryY50ME2IBqPCxNh0u3zg4Zx72s0XTUvN7mz2lvYJ/?=
 =?us-ascii?Q?eBYrWrh9Vjuly7lPEhjUFMEOmL1VQb1JF55lBSfpLjs/k5SVwAWHncGFZO1l?=
 =?us-ascii?Q?C0ZaZ9YYzhVzFhlOLXHDoGaETxyvat+alIihLFWJ8i8k1Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uQl8Okit/V+igLf+UlBD2NfynbZSFTapOr5eV/lKOrv0PCtArX9CQiVJsppx?=
 =?us-ascii?Q?fwMRSe3X96W17d+Ap5eej53GJRVeQiu0WJxMwbAJcLkULxig/twUQZQ6AAOs?=
 =?us-ascii?Q?5SrRkVueoOr/1dUmVEngu89LEkMB/rffTShhO1ttVPMfyRd3UZsoFH7SRYav?=
 =?us-ascii?Q?fiNGLyuuNLbO72GU2Qrte7XtMaVEj0sKchgdvapHWvEh/Gkuetb+7V6XCrzO?=
 =?us-ascii?Q?BDKVlEFXRO4ncm9uFJ+Eo/pu8oD7AkXJkulYzNZZS2r+59fri/0dVG2AigA2?=
 =?us-ascii?Q?HuBCtEJHBScyG1/Xjar8NLqNYkVHA39fBIFKVqmRWG6UqTfMVaBWjFij+c9j?=
 =?us-ascii?Q?C9E/A2FODuigtzW1St2PT/e0QJIbmXp5nA8jrQ9rQXx4Z8rsxUix2EKd8+Vb?=
 =?us-ascii?Q?ifdi8Uk9ZGwhP9nvRwQ9PxjAtz47tMn/PEzLH9sq1VQTKi83cpVCJYrEk9x/?=
 =?us-ascii?Q?DCIVQwE5TGz4foGPzpRxvHGa1YJPceEaf4npzFf54zkgbgKBFYvgyflf2EH5?=
 =?us-ascii?Q?zUdO/aQfiLEuMAWBwDUcaMEP1VunAPpBMt9rBALiELylkwV4z30tfrgU6kHR?=
 =?us-ascii?Q?vfDVXUHFWuCshVlKYmhk2IVYV6U4sEaVnxKfJwZop3ztdv1o7YDHKfG49Dxo?=
 =?us-ascii?Q?KvUbTKhSr05f57Ba7P36y8rgqIYTFMp8S8TiMo/pq5THCSTOEer4KFEVKPD7?=
 =?us-ascii?Q?x4o15mQ67wEiyDOcxczi8ZMQytTA1p6do+JR/mfLGVIMA5nAGjCEuL/u8S7S?=
 =?us-ascii?Q?eZV+tTEj3xNaJ8TZR7yauRm35shfGK8ZBdwsLHMR5c8Bu9V/VF6sPrNY8qKv?=
 =?us-ascii?Q?mku59cVh/QQ6JuGmytIyLSFS4onuHE1ryfKVkvoRHD9/YcIUSwFPEVgm2gXm?=
 =?us-ascii?Q?LcqOKUT4CmlYHDyJyMQYWigp2xUCHh7/foSnrubWB1Y3jct77JW+jHlbXG7z?=
 =?us-ascii?Q?Il9HfAO9VWQx7JS5zOHSnBL55+elNlT/gjvVlb0+lW9+8AFhxgmgqfvkbcRa?=
 =?us-ascii?Q?FCyYczDNMrWnvCg2nZi0TbJkknkPNqraCxeSt30K0MeNyITeJmgYy7tXgSQh?=
 =?us-ascii?Q?+E5kqQKTWlvz35O48qzj5iLgDr7Wq4uHGr/TEIZLUzlsFPUxaPxdDw74jfzv?=
 =?us-ascii?Q?gBGItjtg2S048k5Y5DP8Qvbj3qcnVtiQ7XJGcAZWDOXYl0q4sTOrgAUTH8Ao?=
 =?us-ascii?Q?oVeKmSMO4BsJCnbrPI1T8Whv/TK3EJDljk9lLea95ZrfFUq8q5nycJsa0R3D?=
 =?us-ascii?Q?NKxqfC9+58lk/sqhE2FkKkTCAtTSBiAWbCj/8tKYG+9hCYIPg36DXruAWbHH?=
 =?us-ascii?Q?f1saX+mTBlzQbKwFQvvZ+y78jJw2i7aI4+uUxz/GgIdfeudoquB7TWPY2IJf?=
 =?us-ascii?Q?iJIy/6l530cStFcZTIx/eq4jW3s3vITFqbMdpUzBMX+uQrhfhsjlCZgm7E6K?=
 =?us-ascii?Q?14F8ljZvwjcu29l1u2L4gxyaZPY1pUGykJbNtgjwBoQur2o3FdPjaHrZGaS9?=
 =?us-ascii?Q?pfDbofpisKHJyWNy0LJKy9J8cD54PV/KnwJAuipyBo1sck6oWm93Iinmid/V?=
 =?us-ascii?Q?z/pMVG2uwQ9HjkEspkvQB+DjjUxG/wXDhGa+mrMk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a8b59b-a6ea-40d5-11b4-08dd1d148d0e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 14:27:06.2707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+w1FqoLTGGl6ulBOAAKKSMlQVEvePQj1xmvVK4eeLiajbNFl3JQKvRJCmaOu/QhrEUGe+nav9if/laH8YQF8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7640
X-OriginatorOrg: intel.com

On Sun, Dec 15, 2024 at 08:57:39PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2d8308bf5b67dff50262d8a9260a50113b3628c6
> commit: 0c3ebff535956d2718594dc90aa9cc87521ec9fd scripts: kernel-doc: Clarify missing struct member description
> date:   1 year ago
> config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20241215/202412152053.KeJr8B5f-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412152053.KeJr8B5f-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412152053.KeJr8B5f-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):

Sorry, kindly ignore this, the commit is not the actual cause of
the issue.

> 
> >> kernel/reboot.c:226: warning: Function parameter or struct member 'cmd' not described in 'do_kernel_restart'
> >> kernel/reboot.c:952: warning: Function parameter or struct member 'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'
> --
> >> lib/hweight.c:14: warning: Function parameter or struct member 'w' not described in '__sw_hweight32'
>    lib/hweight.c:14: warning: expecting prototype for hweightN(). Prototype was for __sw_hweight32() instead
> 
> 
> vim +226 kernel/reboot.c
> 
> b63adb979583ef Guenter Roeck 2014-09-26  213  
> b63adb979583ef Guenter Roeck 2014-09-26  214  /**
> b63adb979583ef Guenter Roeck 2014-09-26  215   *	do_kernel_restart - Execute kernel restart handler call chain
> b63adb979583ef Guenter Roeck 2014-09-26  216   *
> b63adb979583ef Guenter Roeck 2014-09-26  217   *	Calls functions registered with register_restart_handler.
> b63adb979583ef Guenter Roeck 2014-09-26  218   *
> b63adb979583ef Guenter Roeck 2014-09-26  219   *	Expected to be called from machine_restart as last step of the restart
> b63adb979583ef Guenter Roeck 2014-09-26  220   *	sequence.
> b63adb979583ef Guenter Roeck 2014-09-26  221   *
> b63adb979583ef Guenter Roeck 2014-09-26  222   *	Restarts the system immediately if a restart handler function has been
> b63adb979583ef Guenter Roeck 2014-09-26  223   *	registered. Otherwise does nothing.
> b63adb979583ef Guenter Roeck 2014-09-26  224   */
> b63adb979583ef Guenter Roeck 2014-09-26  225  void do_kernel_restart(char *cmd)
> b63adb979583ef Guenter Roeck 2014-09-26 @226  {
> b63adb979583ef Guenter Roeck 2014-09-26  227  	atomic_notifier_call_chain(&restart_handler_list, reboot_mode, cmd);
> b63adb979583ef Guenter Roeck 2014-09-26  228  }
> b63adb979583ef Guenter Roeck 2014-09-26  229  
> 
> :::::: The code at line 226 was first introduced by commit
> :::::: b63adb979583ef185718d774d8162387db5589c0 kernel: add support for kernel restart handler call chain
> 
> :::::: TO: Guenter Roeck <linux@roeck-us.net>
> :::::: CC: Guenter Roeck <linux@roeck-us.net>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

