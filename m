Return-Path: <linux-kernel+bounces-305942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487AE9636B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09B21F22D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B904689;
	Thu, 29 Aug 2024 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMaZD1H4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3C17FE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890473; cv=fail; b=Ac3oSkGQ7tDXl4Veo5L6FXxh2hRcQw7t0uONcuwD2MdmsBSH9gfHVJteDFGaID2jAyR5eOxkkj+gp969QLv9GZjocj0ACVxAL8LlMQVBIR7DhsXpE1GKOoIKNSsh5uLR71CszcOwShiKCBoypGVhfv8WH9dikO5zGa5YuzYPHfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890473; c=relaxed/simple;
	bh=fQ54pjtsN7vAQtmH6X2HEl6XiGp7kG6wggwymlzS7zw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GxMPUYOZz+dDG6VY+8WjCuR14BVItHTwAIRjTYXRFxm3W2vcVpw0mL9L9rmonFFsnUOZ9EJ5rz0dVtMX62zv7obQeTMop56fiU7J/BWuLP9KldlRMppoxwI06LnUng3GpQzkRrCHo1s8gHs+O39iUUyM673WH5wmJ5/cXp3mXTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMaZD1H4; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724890472; x=1756426472;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fQ54pjtsN7vAQtmH6X2HEl6XiGp7kG6wggwymlzS7zw=;
  b=JMaZD1H4N4gNn+5p6YYD8GmTkp5EU4N9ZJRRW006/Wb5+U/vDLnj/qFR
   xs953Ikay5nY7lTjEFbl/2drLtTXlhJQ9ic6g7nf1XaopCjrTyGKKPidX
   OFWiCG+yK+4AygbHc8LrvV62OrXRreHolgLpQn/La7eiDDhVDr9WXuYOK
   U7xOE+fWAjR4P7WTAUBxlI+WPCt+w2NtcP7WETqe7CLXLrybYvF/P/TFh
   QbmKu1chP5zw1cyPonaJJ3n3zqxYetyc9U6bTteBkqn/u5CKTSgQcTGQR
   C+sbMMfOWM091GAb+zRRUq2QQiHncnlBI9HzGB11xq5wrptxEpa1Q5QlA
   A==;
X-CSE-ConnectionGUID: HEwQcp+6RPa8XXYdCLWFSw==
X-CSE-MsgGUID: fNSuDySqQimrYkivbRzpMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23643748"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23643748"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 17:08:47 -0700
X-CSE-ConnectionGUID: FltcaI35QbeY0hFnNnlXPw==
X-CSE-MsgGUID: 8lmfE/saSuG3d5+NYk0YKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63463757"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 17:08:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 17:08:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 17:08:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 17:08:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 17:08:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLpoPke+A0+BJj2ir2EnWFiGJ7baJba20EXzkvNS+TmXsS4xdRbYIQu9BelhY8L5H3hwADEtHdq47zTvk5fPG1j8JWbbm3AJFQd/27bx1gboU62p/Dkn4+4HfsvO0lMjLd5SLRaEhlv5s31HNQcUMvyOA1uwYD2bxE/L0PfIXSx0F2QWqpEfwzo/gX+r/69Oabdpwjy3LBuB2nYFIUvdY3nofXOX3e9OHjRkyMGRf0e9NyCWm2V8l84coP8a2FQUzu2yEvezMrdfti4Zl25Zf8wSdVR2jy5eyGawb7P2V5Hk5Fh2tfWERW/hvZfiAtwxYyqipBwMNWXs7aMPmeg+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZrcp7zdQd2PO9ZDwDQ0khk3Vznk+ICKOl3VHupxuOM=;
 b=vfrrTUu+2evPCs+/Xe2bZXrLQnugUoEvXBD2FdggFpfR6WyGSSRUR//qn6Ff3I9zVJz874B0nAgFvv9NOGygVg2fSiyajfXRjTV3FJga8DuAMykCzbn9UhX/Gk1zsSyXKfjvBNhEIboodGnHDCgSgQTAYLPWrwMnowXd3au7W0Ra+zkvAH0ShAKEYuP+vkJIzb4hxXt5dSjlYXSBqDLUp54YK+poE8fKfhE7XPI3Q+FhGRHdHMMZF8LyPDWAvceb0PXALvKrd6A0vOJ178mm8Kgj8gNUfaumt/MjnaUIwUZVV171tIR2pYzft3EofYcr2ptobWrWx08uX7IhmZP6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 00:08:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 00:08:43 +0000
Date: Wed, 28 Aug 2024 17:08:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: D Scott Phillips <scott@os.amperecomputing.com>, Dan Williams
	<dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, AKASHI Takahiro
	<takahiro.akashi@linaro.org>, Alison Schofield <alison.schofield@intel.com>,
	Baoquan He <bhe@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, <patches@amperecomputing.com>, "Felix
 Kuehling" <Felix.Kuehling@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] resource: limit request_free_mem_region based on
 arch_get_mappable_range
Message-ID: <66cfbc08a457f_473472946a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240709002757.2431399-1-scott@os.amperecomputing.com>
 <668c92e35c677_102cc29475@dwillia2-xfh.jf.intel.com.notmuch>
 <86cyltjqwy.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86cyltjqwy.fsf@scott-ph-mail.amperecomputing.com>
X-ClientProxiedBy: MW3PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:303:2a::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: 86376907-a5ee-4a6a-7f63-08dcc7bebe98
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3q6GUsS349QTvsx/ZMyFqsdxlACoS44ejgP6iziElQED7Kr8x64c2wxN+GUe?=
 =?us-ascii?Q?qplq0NIFq2TCiqTFInAtQfn2apyLAg7XuY9USC8ignMqbq0Mc1d3XfGyuawp?=
 =?us-ascii?Q?Y81jl9Nv6iO/+AxpYSCaIgqlq6TzRcXSaeIK9C+mHgPCHqz7zAlwlshrYK2e?=
 =?us-ascii?Q?vrxT0X+KxZmTbOvQk0defIopy7sTYLldoLHS8OodYCY0hhjSyQiLvq6x3i9V?=
 =?us-ascii?Q?vbS5dE8HvXjIx6CFK128RZeAH+X1qJl2pS9kT/X6rEbhztazULJodZhq/sY8?=
 =?us-ascii?Q?ygCbvoIfMbL8jJE9HkJAFsBTeLKjWsJBtsdbf5nBW+CBV7hoECDMhqSL9xRI?=
 =?us-ascii?Q?PueadRugEW96fczjVDAHyMevIIT9/KpC8D1TDZutu5y/9YYmuOciv0/WVpLr?=
 =?us-ascii?Q?AawC2kB3/MCgxtByOhVtKCpCMjtHFyCry4XQcmZIcsqiuB6LSGHVd5HQEL71?=
 =?us-ascii?Q?WpMSIgzYxALopGZMWv8Hpz+1xP8sd0yLt/R76/BFh+BY2FllLlGlUPJsMX2T?=
 =?us-ascii?Q?gB0Cjnm/EodXXMyX+mKPyZQ6lueDboViS0jw1dqG2RFwQCAP3OdLMHLvRsVd?=
 =?us-ascii?Q?3XXfUVGE0gsnXxHvoaQiOIr8F4CjMCsIsGJywc/sazAOY+lkNsas/ol3btS4?=
 =?us-ascii?Q?sd4KRwgZ0ld8Ll8oa7DEhgQXm8f63h1T1uRlitxik1W1TvoOTRYiRcAeujVZ?=
 =?us-ascii?Q?4JDlvUS04YGr/T/lcVgXFPXItGF65BuLFWbLrvTYyjqtU5OBl+7l8o8WJNVV?=
 =?us-ascii?Q?yLJXOkSp8mSHJG9uq+MA0rsxscfTX/42+tGMfwngE89k+mYpqce4rx2DDm9y?=
 =?us-ascii?Q?6sJ74p0V6TcoebfAqs3DlCXi/yIScTdGOp9peSh+/JTKe5Aoaw/rfXl6qs5u?=
 =?us-ascii?Q?KjJ21oUy2spxxNOMcJ/2UIGFUoQtEbw1KCfBmaBBrBaGTJyuSqGxzx/qwuEB?=
 =?us-ascii?Q?aWZK3Scz34QEqMzJTtvjvBQSNupzW8mEJSVmE9q0CqLk5X4NwygmZ/PCSbAJ?=
 =?us-ascii?Q?/Qr6l5M7u6ygwM/KDUFkcRwExLxNgj8CFjfgzwX/AYclz+TJRfD9hD42FGou?=
 =?us-ascii?Q?NzviANfVZcEHJXhoXWLJX+QJugCsgxQcQUIQeAi1ayyHcbjy/hktOiy4piSt?=
 =?us-ascii?Q?IEhQheJTycRtgzsUKERg4EZu+U/N9wee03czSvQV6zRMdFGoft55aebsz9r8?=
 =?us-ascii?Q?C75DDTIzQY3ylgXfOAXQG/XdiRqWEP17LXBrpE1wRmvd37fN5DH3V3SpZrOE?=
 =?us-ascii?Q?/d3JtYPGvyJm7zNyjjSEeBBWgHsQsV5WD/I4f5ec2RWK652THiheWUkEFtQ4?=
 =?us-ascii?Q?cjYm3r3bGDa2G7bht6KnztA+AoEbo82BxiSnQXhjvZdSokRr05uSl8onf3MD?=
 =?us-ascii?Q?2qfkQvQyU/J4BkbnzVPSsE5jsHhE2MzrKiYjgyH0MOjZNGjE6A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gplot+wyQH5J8FXkEMd2Cn804if3QFb4+GMLzjdXklZqAq5JV61F07rLss/Q?=
 =?us-ascii?Q?osyjgO+1cDWzWawrk9SOlUSeyyyDo28pFX+qtBAzyZ6E6BSnzdp8OkcrvJyi?=
 =?us-ascii?Q?719M/FwWUvJkqIpQsGOr/SAoCv9E7RQaIy1hcQ2eGHMYDPqlr/qaK/FEeRs/?=
 =?us-ascii?Q?CaVUjGiGgnLyKWYQQ4TnEuqGcoVTdhJG56crvYRl3wJHMubCsw7gV5vvNSvR?=
 =?us-ascii?Q?Xb3e5G76r5oDM9cTNLw7WkF5e+7iIxu0bQK8NFiEtzh7y1raNbC+3zhpvNjw?=
 =?us-ascii?Q?G14Ir2V3uChpnXOP3H4cmEV42ShGkMUunrUgILHs91tCKqxVZqmxutFuHG3G?=
 =?us-ascii?Q?gugbFVCIRDXeA1KOPcq1KlaQgwovNtwpijIAfDyXyVPfJWZwuK+g4oHBF+ig?=
 =?us-ascii?Q?bSBZjtNtx90a+su8qdeNe5wqB6S9JIN3EgW+AQLW2W72PgXlfmSaG4f2GBUf?=
 =?us-ascii?Q?JhDMYSX+6iO3eJeCfEOdhawD9LoP6mnR8caAyPAjC02HGQpubHmfL0VAduvN?=
 =?us-ascii?Q?op8wgd04c8eHWESPxXYfvfGcJv3nKJQWe71lA+6RwuB+o2rV0UunqhZBdsoT?=
 =?us-ascii?Q?406d80gGDK4n0rrNKSYxWNrnatsaIEx72jdRUwUJMhsBViiQSEdNmLunzlYF?=
 =?us-ascii?Q?uWS2tL63dYH7SdKA+OOouNXTYXG3qGOQQC6MA98JmGIfyrKIlRncvtK6/XLA?=
 =?us-ascii?Q?/SSuG62uospTNVbLe/5C/b9A6zoGi3IGr6AW665eCE3/sO+QLP6355X4o/Ze?=
 =?us-ascii?Q?5ONQ3YKD5X/LWl7kQY8UMJ9spg/Xu0qFPrE2JBulx9CK2EQIId7Qgajcdrq8?=
 =?us-ascii?Q?//4VmDvVpjtGTj9wmQX2LdToleN+VuMN6y2RyP1gTXTXGTVWoLp/+5Im0NMb?=
 =?us-ascii?Q?4Wp9XwIZY6OaDFf7Wk9oC97kKuJHnxwyKqXzrw8Xdf8WVeG1gjj+vYyGUNdB?=
 =?us-ascii?Q?ag5k2Z75s/s/HGEpAqqSD+X4Q1CP6nbRsbuj9EJD4I/YzyIKieX+Pw6dnYOk?=
 =?us-ascii?Q?+bZrQTMZF22KUWr8j/p5EaMPxK6TMmLVbE8T4x/YlAL7Nkz3lG7+HABfWnDa?=
 =?us-ascii?Q?2AQtOqGNrahb/8Dk+SMSZQAALQPCjIYZAVmWnUFP9oj+/82M+0C0ROEPhqmN?=
 =?us-ascii?Q?oNQBH9QO1MzbA1RGLBgsIWkfALBB9AkPGgpeN/4m7IBkCI/tPuosFsfQljx+?=
 =?us-ascii?Q?jMxGLN7SifxXR+xDC3hCREhTa20lGhKusJ82dODsP1kSFEe52gdSWWClHx/Q?=
 =?us-ascii?Q?k+8h/U+yzT3zXGEY3QaOL6JGs7G1GCYd6ZljvL6TwKd1RWeWFCJIK8yLzRY3?=
 =?us-ascii?Q?TKkzYHmx/L9pWpqqPTNBgFrKcHn9Uqm1Tu0z4Ix4i/4rfmp7GT5Xl0BvR+kt?=
 =?us-ascii?Q?0DsGMcvaa0xJSmQRr167FQUwGR0t8KC9AH4rZS8k6sPKMMrYWs4Ryf7C4Dp+?=
 =?us-ascii?Q?NDmWN93cHh51UwgTve8lQkW2CR5vZI0uUCSx6B869R8lU63RkW8Y0xuJm+4B?=
 =?us-ascii?Q?+CuMSAdFb9yNat5LT5BeANg0VyVL/j3gJnVkDK8Qzt0KFAXgba1zkkAGSCEd?=
 =?us-ascii?Q?SYmm4AUjC7Ryls3ohtO1Ce/NkM9Nlh+GmEZYZSrzyV7kb9DrEnkvOIZowzJ1?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86376907-a5ee-4a6a-7f63-08dcc7bebe98
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 00:08:43.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: up0ZbtEOAtotruPq/G4JCh7It9KuRriDljrneUsYL1ZHd8kGhzmVZ+3mINswafpGIhmR0sPWKcYao6bJiqBT8D7SzAZ3m/26qxkuRq4b4xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8700
X-OriginatorOrg: intel.com

D Scott Phillips wrote:
[..]
> Hi Dan, sorry for my incredibly delayed response, I lost your message to
> a filter on my end :(
> 
> I'm happy to work toward your preferred approach here, though I'm not
> sure I know how to achieve it. I think I understand how cxl is keeping
> device_private_memory out, but I don't think I understand the resource
> system well enough to see how amdgpu can make a properly trimmed
> resource for request_free_mem_region. My novice attempt would be
> something like:
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 8ee3d07ffbdfa..d84de6d66ac45 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -1038,7 +1039,14 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
>                 pgmap->range.end = adev->gmc.aper_base + adev->gmc.aper_size - 1;
>                 pgmap->type = MEMORY_DEVICE_COHERENT;
>         } else {
> -               res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
> +               struct range mappable;
> +               struct resource root;
> +
> +               mappable = arch_get_mappable_range();
> +               root.start = mappable.start;
> +               root.end = mappable.end;
> +               root.child = iomem_resource.child;
> +               res = devm_request_free_mem_region(adev->dev, &root, size);
>                 if (IS_ERR(res))
>                         return PTR_ERR(res);
>                 pgmap->range.start = res->start;
> 
> Apart from this being wrong with respect to resource_lock, is that sort
> of the idea? or am I missing the sensible way to hoist the vmemmap range
> into iomem_resource? or maybe I'm just totally off in the weeds.

You have the right idea, however, I think a better solution has appeared
in the meantime. See this recent fix from Thomas regarding collisions
between KASLR and request_free_mem_region():

http://lore.kernel.org/172418629773.2215.4158024254077335422.tip-bot2@tip-bot2

...in that case KASLR is limiting the maximum possible usable address
range that request_free_mem_region() can play. For this
arch_get_mappable_range() restriction can you adjust the new
@physmem_end variable for the same effect?

