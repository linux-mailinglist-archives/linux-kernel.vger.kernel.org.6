Return-Path: <linux-kernel+bounces-169397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6738BC821
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC88D1F21F48
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC555FEE5;
	Mon,  6 May 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gm8G1va+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F89228DD1
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979387; cv=fail; b=GgS8IdGyWPj3LVLtmcgXuHSILkKSLYiFopxQnGhHhH5QWaocchTgQ+08a5AGbUhBmPGrYNdysPMLCdDYSVZLMZ0bH0Lg3UKoqjcPH1oRGIhh+q4nkeX7qdGgXX/YBediQnbBqV1QbLe3GbQZsP8pLMDXhXD5nV6bfSx4fYmqdOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979387; c=relaxed/simple;
	bh=8UtNg91FJjSF6tRO5555/SjJ2d1FM5xttBxp7JulVWE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ajb4vXCl+u2Ao0G4cK73gUhPxzGZIIvPumb8Lh8nNXvAH615Z3MbL/eJsq9BNeuuL1mAgUYv9QYfqMH9bpgvRamB92te+ErYA+CWIOTKaw+Rev+k0v69wEJ/tQw26W8xAQwEEVt6kCSNMk2dTYh/sMkRvMupmDNGM34xHSmcTD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gm8G1va+; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979385; x=1746515385;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8UtNg91FJjSF6tRO5555/SjJ2d1FM5xttBxp7JulVWE=;
  b=gm8G1va+e7Z3F7tLMObYq3LLIVpTy9Yogzh7USQq6JB1bDJ9nCYW53Wd
   xoKwETCHuTyLsWcQGYKMMnYFgm+sG+FF3OpJz7z7XSb8Ta5UOIA5UbnZ4
   wpKr8P1QlRO3KdzwThufAHkBnIODKxf8cjsjOIyuxvq8y9iwDpmeVdk/7
   meBjQGzdEaSui/NZaWNXAeAkXRUrM6Hy9xidhJpYKO2ghDN88ZF2h5sWY
   2NzVDRKxsni8r0hiYQHeIr8O6Ip032Po2g9P+E+d3VVw0iqnaQRyaAQj1
   DzhhsvewcFG4kl24OjiNWO86k0LeJtd+mnyPRr0jNkKwPBzgJ+ScAGe7+
   Q==;
X-CSE-ConnectionGUID: EWkxR+XXRy21g++oRbejjg==
X-CSE-MsgGUID: OyJZkWokTLOqaNDtTEeXsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="14517980"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="14517980"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:09:40 -0700
X-CSE-ConnectionGUID: HFsLzklITMC/LmM5AKOwLQ==
X-CSE-MsgGUID: BztNLoSeStG2wuyMIpIk1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28158057"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 00:09:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 00:09:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 00:09:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 00:09:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE1ejmvcNf95paR77JQnKqgL9z9fAMZOrvb4USqR8gKG21voLkGuyspea2EZUbAf2rBLJ8WoEYkQSPhpId4DX69EL5eyaaIXEJK0Em9vGouwQdggljxrCS6WBUQbkqOXTARghWHSy8zUXpdhmweEzyABdTNPn7st7+alESVgsC6ALqDN69uaoV1M2ylFqwZVbEtuVjWehz2cmT30TOZMpNmxSdiXkoztbusP0KUXSYIqzLALg2PyJUsLu3lvej2SYv/qnUS+9yPM+DcXJyuU4r+B9DYr0nbadDlyEBdS+v467yCeWENjxKWSyDZglTQu46+zAxUHwBLeAT0tocidXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFJ4v/GhxMBCUqmXdk6N/vg5GwXsoe7o0F2zA33oA7k=;
 b=dGt3EzaV4t0kKoNvKEoBEMFia5DkROzqK50hiqXGMdH7ZGyLo99WpzAqXmYYOkiWHIuaBYvMqU12Wis25A0Ne/m49LJXqIrfjyw8ya+DcxrKFGEJYnzcuwfeR6Ziw2MJiNO2crBLYZsEuZZzJAhNsSDMeo+RIguiUvGR/MyIzLKn9UImYedbNIDSkD4+Z5RHfjzzGGxp7WOdsgSb6eBw9cm0qzMB+96SSrB0C2E+unUkaEftUuEQvgVDsEmgFmwLLjEK71v3mYc5KrHPxH5GzILyyujklVpM/Z4MW/IOzIOq+uQbdJktKH2NwmDU188J/05nQ/zl7lBVlo0AWRw+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5125.namprd11.prod.outlook.com (2603:10b6:510:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 07:09:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 07:09:36 +0000
Date: Mon, 6 May 2024 15:09:27 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Sean Christopherson <seanjc@google.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>, "Ingo
 Molnar" <mingo@kernel.org>, Srikanth Aithal <sraithal@amd.com>,
	<oliver.sang@intel.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <ZjiCJz4myN2DLnZ5@xsang-OptiPlex-9020>
References: <202404302233.f27f91b2-oliver.sang@intel.com>
 <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
 <ZjE7DkTBSbPlBN8k@google.com>
 <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
 <ZjFLpkgI3Zl4dsXs@google.com>
 <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
 <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6891a3-5500-4728-9f47-08dc6d9b7ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EoH7KqOGmoqPZSeEDVmS8y7V+WegBnpoArZFh37MHs7uGRXGQReBdCbWufuk?=
 =?us-ascii?Q?Qp9pM0B7w9FkJC6DkvzYKsixmd/7VmMLv/BKY3egmFOQnrKO+51a6V1kYUTw?=
 =?us-ascii?Q?3+QRo56Sx9+00P1RJPSorpoTp9rWscjvVE5j8aL9c3GJ6uaiFNWUshL8le8I?=
 =?us-ascii?Q?icvwFJzRgHYEAG5RRVZb5CRUIZCeJNbtN/vpeFz7An4CuZLifKUKuC2kPrqe?=
 =?us-ascii?Q?sDYuNF5OHxVdxdCHdyuahqwOpJiwQnKziahQkEBdBAJaGpUQh2yipfGlbyre?=
 =?us-ascii?Q?2cUhff0YRRLYv9m7yp853iCrsSK49JLIB7Iytr9G9Kee6gVMmQ/NTmXo0FKM?=
 =?us-ascii?Q?v6a95mwLarp2IFAxRGdzZdOmdEt+VyxEtXXup34PDS2MCj6BUMpmWmIkj6Rx?=
 =?us-ascii?Q?u94x+51TPFgh0PnwU228hGIIVzd5YCAZ2g79oUJSjFB80cbEdePiVrCxy1L1?=
 =?us-ascii?Q?tHrXeQ99MbQBvYX5VQPK6OAHHZlp+WoAJj3ddP2OrcWsGny8JIc3M4+X6B2Z?=
 =?us-ascii?Q?Cj58Uo/rcdOYTvtqRyNxKu2V85ovviK3qmViz50TcUUa5ulTsbH0L1B3zatB?=
 =?us-ascii?Q?aYdLqCq++8wT08AIqksI2WoJC8mwAphobwfteRUPQ7LTewm7bjnO5koF3XJ0?=
 =?us-ascii?Q?oN61HEy3xv6n+dJW8XJWPgmL/+yiT9ggzc4HQNG/pSSn5SOvfeDiMAtxTt6c?=
 =?us-ascii?Q?w0jf1V6KV+VnBWZWKiwj3HglYwfEdVfZph8dJ4geTbmiHTuCHvwv+meuuvdm?=
 =?us-ascii?Q?bzddUXj83GlSEuN+nGLaAxpJYhsQB7T1ZyqoOF5hO/8F3Vz88tfNYczmTaup?=
 =?us-ascii?Q?/l64PUMv/JH1dkJjCz1ZV2GqEy7Wh9icGhhQc7f+pU48rSL+aRfZ8ZSNqWIB?=
 =?us-ascii?Q?5R9M0mS97zuxSHoLd2m7HgfNNfSWOUDwcQ8S9f9HWJyRPQTUbw3ww07E7raB?=
 =?us-ascii?Q?2fBmKYIzK9AGL25EpdetqxorUuKtBvb+myVwowSxgoGoS8QhelSTivycKsyn?=
 =?us-ascii?Q?aOR4gmI9FELI+PPK5ADfTBgv+2Ed4UjU5dAiQiS1M2mVAZ3F1RvRXT+GUPx9?=
 =?us-ascii?Q?ukwQMZn/+49fYovXCgtLQbexBejDk45ag2aHdbbvH2abV+GDNX7rbnnncHMP?=
 =?us-ascii?Q?YnEK9Cqh/zYAWd5fH1E/p1g8pF7XEgXcqT43LUJ1RPteVJr1JBJUY126kxjG?=
 =?us-ascii?Q?ZrkgDByXyqcuvLd/NugoEyk5tKYzOZ/UhkJSQfwveYhAM174KHar496aJvgd?=
 =?us-ascii?Q?Myzqre3+9ssNFWR4Yup3roxNBfZOPha6HRITdTv18Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FK6ZT5sUfq8IlEVKjbOaqk3S7vJGPAsKIxigWgQWlVvxvN8H24RHbrKwup0n?=
 =?us-ascii?Q?SWafGnhtWXtSNsqfEQUieSJ48YOxJIcb9Tabeq+fTeTIDN1OXieOcVQ35Rg+?=
 =?us-ascii?Q?yST/99BjM10TohbxI69YBaMCDJMF1VewoPkEY7lIEzmqvXaCkUfjB5Bopjh4?=
 =?us-ascii?Q?CqsybdxMCBVrRLpjNkwXe2PnDQgTbYQe7U6uAeAOnNRVePaB0/t/bRPBhJBy?=
 =?us-ascii?Q?VfnPrK38NQe2zKmqnIEb4qnVp77WEouinRJe61V1xZJxH9Ui3NFI5yxZgHut?=
 =?us-ascii?Q?WltQ/3cEZjFqjhDNBHLxwTVwv3ujKMHGTF/pce7ft82LX545UsKPCAtJeHKF?=
 =?us-ascii?Q?kaIr0lPE3E26zk9AiVxN4apClwyyCefv5iqhUKdGQTkfcY4rviqG0SP7n0ay?=
 =?us-ascii?Q?PrUDLQRfoWh5JqDL9a9jrrYFerJgyegoAmxoGy5+UsEoKj7Fk6EGfs2Gzhm1?=
 =?us-ascii?Q?Nn3cmSZNo9sbP0UoQThAftXrpall9tMabWOZU1fQCgXljh5OY8YiRGICiRdw?=
 =?us-ascii?Q?VU601DuoH6nQNAxnZUb3HVSMCNhwMpY1GX5UC5/Y73Nb+A9Cp1K+LKXy+b+V?=
 =?us-ascii?Q?T19Mfm+TT7zAP9FwDoEojHk1FHqAw2XA801J5r6ibaDyOsn1z6xie3TpIUsf?=
 =?us-ascii?Q?tZeu+tbnh18X5qhhDSz+iG446Cv4n9PDaaj9Nb3O2+VF8dFjk3LuvMZUzfcq?=
 =?us-ascii?Q?JN8RklTzG4H5tSiQFigrPzQ1OA+23I8tv6G1mZT90plRCXe4h0KJ58sU2KJ8?=
 =?us-ascii?Q?38Z5aA2Fhwbt4CgU8ybvOH+7eV8yEKUGR17sfbdJcRZ/Wl3QUzjjjxTYCpar?=
 =?us-ascii?Q?GbESknd9RQeN+Pt/hCmRCTD93rAPm6V2RdoX2DFOZ+1Nqt8g1+kbAljHexHY?=
 =?us-ascii?Q?WDG+q55VwmVT4g2eCwtccCoNeo1vv1pJs5crkAYIcCde57Ni7fCoQbM7yJwd?=
 =?us-ascii?Q?EN4xiM/Vgwi4KQ7E5+vl2cOgh2/RUxWLQUO1uw2bjNNRjKnCakJEWXmTpKSo?=
 =?us-ascii?Q?TKgPkdMyFh+1mUYVp+wCa1s9s+uBD2hnzmwTYbFWaGskMx9Xk7oIqfqLPoFh?=
 =?us-ascii?Q?Fv8/nOxjoY4Ep1vt2zzjtYrL2uWpDaMoEqzRACXGLVvmGFNNUVG/dcIFRYg3?=
 =?us-ascii?Q?8kgdGLwrYlbNqhRgZZs4/Suc855ZELuLmd1HeW7Hyd/AsE0O3GW1xKna5aIn?=
 =?us-ascii?Q?Siy7lYg0wpGfb8QMQTvrHvsoKJi2evOAO+QMVO3eGOlGnWkCRr3U9uFKF+W8?=
 =?us-ascii?Q?BJHo3dWXLTva7KxMbY/sqAmliTJ6JaaQn6RFWevQXfUzBzWbgoNgm9thrMQW?=
 =?us-ascii?Q?je0wtdJsEWnLV4OhrCWMkiGAZ9Hod/53SGhS/kJga+8JmVW+a+3O/4hoNwLc?=
 =?us-ascii?Q?TLwhm6JxtPVfsod+5nGUqGB7+wsYVuVlL7/QvVREJpaVHqwfQ9vxPehwDK9H?=
 =?us-ascii?Q?WawxwfJ+n3AAcsrKxm/iv7ZY+7W6bd38qQOkHKzaqBiFixMYMYTYF7qDGU9n?=
 =?us-ascii?Q?pqGXYKCfpJKJzDwj7DDS1A3eP5F6FCsNwFt+0Gu20MlHfB4KpR8HLB1s+Grc?=
 =?us-ascii?Q?YnAZt3mdZEnLebUxst5hQp9IkbF7/MFbIRSTrxgX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6891a3-5500-4728-9f47-08dc6d9b7ce3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 07:09:36.3408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oey3An7AEwt3zz59Y6BJZUjougMLQZP8b9IK+SoAmgevEhZPLh3bI4joNaOjvOZiQ043hclT7kGH4+/w+46/+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5125
X-OriginatorOrg: intel.com

hi, Boris,

On Sat, May 04, 2024 at 02:48:22PM +0200, Borislav Petkov wrote:
> On Wed, May 01, 2024 at 12:33:05AM +0200, Borislav Petkov wrote:
> > On Tue, Apr 30, 2024 at 12:51:02PM -0700, Sean Christopherson wrote:
> > > But that would just mask the underlying problem, it wouldn't actually fix anything
> > > other than making the WARN go away.  Unless I'm misreading the splat+code, the
> > > issue isn't that init_ia32_feat_ctl() clears VMX late, it's that the BSP sees
> > > VMX as fully enabled, but at least one AP sees VMX as disabled.
> > > 
> > > I don't see how the kernel can expect to function correctly with divergent feature
> > > support across CPUs, i.e. the WARN is a _good_ thing in this case, because it
> > > alerts the user that their system is messed up, e.g. has a bad BIOS or something.
> > 
> > Yes, and yes.
> > 
> > There are two issues. Clearing feature flags after alternatives have
> > been applied should not happen, and this particular issue with that box.
> > 
> > Lemme cook up something in the coming days for the former.
> 
> Two simple patches as a reply to this.
> 
> Oliver, can you run them on your box pls?

we confirmed after applying them upon ee8962082a, the WARNING which was reported
in our original report cannot be reproduced any longer.

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

