Return-Path: <linux-kernel+bounces-390564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03439B7B76
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405CD1F227BD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AB519DF60;
	Thu, 31 Oct 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRQjzMMx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7D19D06A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380384; cv=fail; b=SVbgaxJZgkS5x2VHTt0yW/+ftfx0LKkvxRHSzGZkcKKWDIrsddvMhwlf4svS+iOVYIH7g/Fvtb3ueSQtkGhAmOBINxM4nEOWyuTRA/LSRkksnAXXRMKnD1S9Bl7VHe5i+HqOccc1w41JEUfQfvFtAfrsNsT9CKsOFoC6nxy0UOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380384; c=relaxed/simple;
	bh=8g1Wi+XsbROBRswKvYuIyCKyb86di1corm2awnCMCw8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sLYc/gVaU5BG93IauDlQud7SQoUjrtAnF4zEBhoaQU3dLPZ2pKU7tSifFq3aZa7QMPFSWWrGcqdGYmMPFdHiu3o9zmMv1QONkHISrX7mg/Se6XInpcaY+p98tC9uklI+wFi+Y0k8QD62cVzbAv2H7LKRJW1jF87dRPtZcFT9lTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRQjzMMx; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730380382; x=1761916382;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8g1Wi+XsbROBRswKvYuIyCKyb86di1corm2awnCMCw8=;
  b=RRQjzMMxmujLYGv7lfU9UKpSQJpw+aIjTXQZhgj1cc5pDoXCM88pGFiL
   UrpEBSq3f9yeOMa8Sh6BvVhiWscIEWtOWOTkgPSgkSV53wyP1svTaXba+
   ZnI7/kaJx2r6mwzLnhsuOritc4jcRI8hB2XTWaMerxilrPjrJb54xgxnX
   iieLXBSuTNwuro/eEptLPUah81MRX00/xX1GO0IYszgAv/jEsUNWWdaIn
   P/O9ExuuWzATL2XGumTWlzAx3kaIavfBRpKMMI7b5Zc5b8Qu8wuIsEae6
   9/nQ46EPVenQZXhgsJO3XiH8Ura0WQ9hgl3ZZta4Vl8kJ8M5XPfT81Y1h
   A==;
X-CSE-ConnectionGUID: o7q1Ql3uQue2JGBJ2zWqaA==
X-CSE-MsgGUID: okZFx+ANSD+0zuPASgctAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="40730035"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="40730035"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 06:13:01 -0700
X-CSE-ConnectionGUID: kwoMgD59QQinEGLo643W3g==
X-CSE-MsgGUID: DwJ3ugyUQKWLttOGsFZN/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87418819"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 06:13:01 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 06:13:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 06:13:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 06:13:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyKWyUlmUTEc4FoAzlFjpmW46ttuFM9kjDu/Oya4jyoewncoqPZwz9k9jL8DMxOesWc4ug8dh6TlhF99L3ygnAaaLQGTQJQBFgJQMAPVOm7I9P/rEKbBS7nWWSzhBHAztxxa3JQ/hhyaxpk8kifwCVuZzFgag/qZ+K9wLGM9atpbgyAwBIsBAysQGfcKuAq+tb+16miHZ+AA2Q4tzN+Dvxj6BF8rf0taDIjRSrxm5PcRoNyI7JAFufOUm2dUW045hWjup/wygQan/ejhPodXY1l2HtjM6Kgry/1+mOIMjvVH8hlvaS/BwaBTZuCCqY9G6nXNrhF2bWyAo2rs62CW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyK6IJaXav/gtS/lEagfdlMoaXnzy0bwHH0cNFP0Wk0=;
 b=agNd9SJeKd3dc1UVz92tZFM81BDsvLKqBsdpmheDqiJg3MuMgZlkkuSn35zUm8C7qS+hZtfA5KEEPxEXSkwEW6WMDsVDsyWaz1GhriG8LK2m91TGyUOHEz6XZW5KFDqY7YmvBXEs4I4XKPZLuDEO+dIbIXa9OWyXwIAGZTDR2dXMFj4KLsyqvo+o/T5gDxwyyMrdac1efE8jzNYcfwVOkMvvDNaeOQbWSX91/SiqmnqC8bYQakMx7WBTjlwIbLiPxSBavpgX+8N7VVG6MPb1TsTQtc/+blYMTHtOqDEehaypt172sBQBjq6aFXzP4iyNrpD3cpDX3GI25wTR7gLchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CH0PR11MB8213.namprd11.prod.outlook.com (2603:10b6:610:18b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 13:12:57 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 13:12:57 +0000
Date: Thu, 31 Oct 2024 08:12:50 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Nam Cao <namcao@linutronix.de>
CC: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andreas Hindborg
	<a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 38/44] drm/xe/oa: Switch to use hrtimer_setup()
Message-ID: <ak3xx3vykmyutpanofmtj43hgv5vx3k35dxfxec4s53logdk22@qq67qukpkdga>
References: <cover.1729865485.git.namcao@linutronix.de>
 <e488e80d08016ec8f9dc7de2cd6cd81e22b60f96.1729865485.git.namcao@linutronix.de>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <e488e80d08016ec8f9dc7de2cd6cd81e22b60f96.1729865485.git.namcao@linutronix.de>
X-ClientProxiedBy: MW4PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:303:b7::11) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CH0PR11MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da78ca3-cb03-4d49-c06c-08dcf9adbce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aBlEufUfDKsa1lZTg4eL3ymSeWU9mcVq0oFmfi3rvaqNwrEsOBEx2MulTMHE?=
 =?us-ascii?Q?Yge4aYPS+UEEwO9Dyr7PJckjawTt2h2nw8MC1kNj6aO4AWChFv5gtbOEBwRg?=
 =?us-ascii?Q?582drGWu/uP6YvvCfcTN1LJvbQaoh7HKooEEYWD89UG67QEiq00DbVbt0+jk?=
 =?us-ascii?Q?0MBcrElc6W9e0542ZgYEE6sKSc99BXIJFoTMjT5kLsMqR1XoPE7I96/a8ub3?=
 =?us-ascii?Q?HBbiuc3450NIFwA1A0a2tM+JEVxySQns4x4Hq2ABMxUMsW+8e146xReKb7sC?=
 =?us-ascii?Q?JOAxVntGDimTEennECtudO7SJNqZNxH4mItYeCPRaPosmKI+1sOj2MRLCy6+?=
 =?us-ascii?Q?euihPpN3ufxffa+Wy74V3r5EhrJRy5b923yJiILWdjabk5jvxfwTDWC+faKt?=
 =?us-ascii?Q?be8kA4ZB4ZuhkadM6vbC4wr7a7fpX9c/4G2ssZ0Ns8jM9yE4zURY6dkn4vcL?=
 =?us-ascii?Q?y5BdOHuh1O4Bha1y4UEZnceN/qYRMs/sB3qu62EtJ2EyMvGC6qQ4isqVf8M+?=
 =?us-ascii?Q?CoSCP/aPwcxkgo8XsgFu41jBk+4ii4owXSqSTDIbe9zk+Gkm3KNGsquf4RTX?=
 =?us-ascii?Q?LdeXLxZA9LoUn4+Eh04HIyeFjDPx7H9O6JDyS2O+9PO2NCXiPDR5K0ztqOhL?=
 =?us-ascii?Q?Jshsyk4bs8u7rXRJMeDRdVqzu1iRqTgvLZ8LyOS5ds5J3y0usdq/2r/7+FYM?=
 =?us-ascii?Q?gOgMrBcZKMcNee2oA14HVPqP0fnxVMxdnzypsh3cnI6zV70uiB7xxgsH5brP?=
 =?us-ascii?Q?ajHGrCYQuUqen1g2+fAjQDhF3cTny+FzdrYblqvc7u9Lw2rdF5xiG5kujs2b?=
 =?us-ascii?Q?1/DgpFhpb9CJ79bfV25Hu3BCOPJUlvjYwPgQUlKOaSWAqlUkb7cgksYe/jW5?=
 =?us-ascii?Q?IZCFBjUgmrdw+Fues2cKYcwOzzYd/t+0lq/KnSbklkd5hbEwKMKmgLRHX2/T?=
 =?us-ascii?Q?f1xQ8PZq1mRMtEY3eEQLTkY930uTRpqMVcbaA8Wqsg/iuItnBubJWQBEu+XK?=
 =?us-ascii?Q?wy9mdyddk2kued7/aVyg5z/bPNZ/8mSbZ85PcWw4W67+sTx6m0M+/65uZAyQ?=
 =?us-ascii?Q?PBXWRO+X8xGobJ7M2PIKZpZgKQd0Ab29o+AJEcsb4g+jMsM5G7OxQtvoCYXb?=
 =?us-ascii?Q?xyevd2Vu6xgoH1j8w4YLM4PHAb8k1RwNdlQbfKXilKcpHPjJbAo0ttNhTDTk?=
 =?us-ascii?Q?00dEqvTw//YjqPAljLuJL9VXxLqOVz/yg9U5q/NYmbsvuEmh5x7Ebj4D4sLC?=
 =?us-ascii?Q?tenKfThDQaX5VKkvmFvqybrY0/7Hs68q9wU6NOifEPMck9m2VYliDVGUs0hB?=
 =?us-ascii?Q?KJ56Sze16CPB/LqnEhZXx15x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qvGbea5RyTVCEwtXaR9/44IfvxZtpv7cZAALIOKqhMDI8dsBlRZR5yb8RzQF?=
 =?us-ascii?Q?AhSlWVuxaTdo8MXLhjdMsbaMUequGnFWNaYPRmLrRxHr9mGpSE2ahjcVc4PM?=
 =?us-ascii?Q?x7R6Ur+3P8Ab0ZYIGBKsizlqIr6Gv/jBdXo+Is7o4nIBRgEpssaEDsBJLsF8?=
 =?us-ascii?Q?zEenf0UIMfc9lihnrmK53IU1smx5B7CbOH7Y5gs4cpIJMAFx5woBdWQxP9L7?=
 =?us-ascii?Q?g2vA4opc+4f8K45ZdvJFQDVFn2lhn6vHfipQMYkjbIOeIoAWCmKJeKITgqDs?=
 =?us-ascii?Q?TGe8ZZJv5QKN/haFITk9S4g0mx09XlbPQSykydZYhtwpp/AcFMOWCn72U8G7?=
 =?us-ascii?Q?zOZapFAS33sM5S3GFc9C6Gfr9fySTf0eN04QmLCTFrG+brawBOsSxcOSoIf6?=
 =?us-ascii?Q?noqjFoS18TgfLsT6R6dV1B5vA0kh3Je92bUkRkuYf0CDgeL+MkrlR4WIEBz3?=
 =?us-ascii?Q?w+uKQD9F7PVhbv8d3hyZqk2tKF4uLdC8wM1CpUxD6/MV9xyvx+xa92EjGWbR?=
 =?us-ascii?Q?IN34g2nMKkg+qQbg/qMJtOTgrGE0fBD+yZK1UZ1j6F8oL09vxH38s2HECKlV?=
 =?us-ascii?Q?9WnV3H8wfHaR4yQ6+2sz1aie/rc7HJcvwhhglB5//Tky3naU/uT1Blp8+US8?=
 =?us-ascii?Q?ciT4tx0odMXf1Axf07MT652K1ih0sogIycSaYENfjfm3JWxG0V2XTVXHXDgE?=
 =?us-ascii?Q?GixrloHyHPM2uYkB9d1kXEABTNgruovzwhWgg+BJxtni4M5fzfeSmw2bhUoA?=
 =?us-ascii?Q?yDtnHf2YaY5FQDbUyAtXAUrn6THVtbHN64lO4987agVAvBAdwP47nxr5Q+rR?=
 =?us-ascii?Q?lbFfUgwgyuvdmGUj5GIlL5UhLW8iHOd6Nv+jnAj2xtVDKZA7qkCWtrKAOZdB?=
 =?us-ascii?Q?s78bBOJYfVvhsZFYE8V2/NYIoeu5oSZ30f8MalxwGuMakfztigKEjQneUlGL?=
 =?us-ascii?Q?nqprzo5L7TH6Kgf2GFYOqneiFgqPL7qIcovudpybEl1IvRt4Zp7uvroB6XiZ?=
 =?us-ascii?Q?QE2C+2NYQgBAnR2Lp9FxVcDkH8MGdjmiVhEQvnH+OGUwKdOYGhMy2fTCuiFR?=
 =?us-ascii?Q?cr0s9/UuvX7xbcNXg5buEwi4pLT5nIAM1D2bo6keQbQwKQFLQn6QoHWbcvI5?=
 =?us-ascii?Q?azwlySw7pJEFVh0bGS22RKLtzvrYH0mN2BvvA4eVw084cte+wI2d9NKPFQqM?=
 =?us-ascii?Q?zbqwfhtMro7UJlbFGtPJcsKBTrGEgK7rBSvvHz7QzoPvesGclx9JQGx0Ppuc?=
 =?us-ascii?Q?xg5IWX5nWPL/gVAbNcFAUaYon2Dgwg2uVpmDC1Qf/jejXdyLJk2V2UN5IfnO?=
 =?us-ascii?Q?bSj11xUMFNbkNtFpWHN8znfCEUSDowqHQPLh/BECD8FENfB9ojCH8svJnA6s?=
 =?us-ascii?Q?9DVcN3Zx1zvBELL29X9obgjMANhT1SzKNhh8ZgPgQJ2pD4qfy8Nhmm2tWYuk?=
 =?us-ascii?Q?OxmSUagja9pIQ21wcjbpBW6GFpExBQvx3uI3Vh02DB8fihxlp9JPbDIpwDQo?=
 =?us-ascii?Q?//4wNc/C1/CV3//1J0wo9u7ztLaFbe2GGkeghEVCJldcy0EQczjgS96KDtaI?=
 =?us-ascii?Q?JjvqxTYbNf2y2a+ygKXTc8d/RE+9W6Ah0rsjx7WGFwQw032U9F2ni0WCk6FV?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da78ca3-cb03-4d49-c06c-08dcf9adbce6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 13:12:57.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdFJrat2zDNJGXCExMHHTVbIPy8RCfeTw+TP9tIAxBARtrnVejBl3E3ohctbttPUHZNP/9xOGGiSnlwxptzxLQaProcEN5vWX6H2St0bKVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8213
X-OriginatorOrg: intel.com

On Mon, Oct 28, 2024 at 08:35:14AM +0100, Nam Cao wrote:
>There is a newly introduced hrtimer_setup() which will replace
>hrtimer_init(). This new function is similar to the old one, except that it
>also sanity-checks and initializes the timer's callback function.
>
>Switch to use this new function.
>
>Patch was created by using Coccinelle.
>
>Signed-off-by: Nam Cao <namcao@linutronix.de>


Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>

Lucas De Marchi

>---
>Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>---
> drivers/gpu/drm/xe/xe_oa.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
>index eae38a49ee8e..600eaaee8a72 100644
>--- a/drivers/gpu/drm/xe/xe_oa.c
>+++ b/drivers/gpu/drm/xe/xe_oa.c
>@@ -1437,8 +1437,8 @@ static int xe_oa_stream_init(struct xe_oa_stream *stream,
>
> 	WRITE_ONCE(u->exclusive_stream, stream);
>
>-	hrtimer_init(&stream->poll_check_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>-	stream->poll_check_timer.function = xe_oa_poll_check_timer_cb;
>+	hrtimer_setup(&stream->poll_check_timer, xe_oa_poll_check_timer_cb, CLOCK_MONOTONIC,
>+		      HRTIMER_MODE_REL);
> 	init_waitqueue_head(&stream->poll_wq);
>
> 	spin_lock_init(&stream->oa_buffer.ptr_lock);
>-- 
>2.39.5
>

