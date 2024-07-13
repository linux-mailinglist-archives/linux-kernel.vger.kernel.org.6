Return-Path: <linux-kernel+bounces-251405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA82930488
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 10:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00FC284D7E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 08:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C27B47A62;
	Sat, 13 Jul 2024 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRJEr64/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF840BF5
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720859313; cv=fail; b=r99W2iK2UhnSAQj+O4IUgP0sZjON+dgz6cIISn2RTtuHEH2NAA1FQXKHm8n+GhhATsl/s44CFfeqtYR1dLtjr3fDXBkvb1l0mOn2dVUZFsF0ZgkAfQQhyAtY6TFg7vsL6PD39xuYBYHDlTDtIZHj2En32uB/4mhUOwCOqT++H9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720859313; c=relaxed/simple;
	bh=5YII51QigkKtS64qKuppfq50pt0v95OOa0Jsb7tz9mU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=eAQvZmsbmPpINhOdbFiDfWw8hwqDWjdLLI0MT8HG9UAn/YF/tX+pSKPXh5EDKHzfYGfcZyfVYjf9Rs6J1ekXOroTcMmydCcxXv1xzuLbefyf4aIOk4hM6+QO0WZz6QnZhKsGBMY6DkMFDinZlumOPin74++HWFk8IIlnFzSacVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRJEr64/; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720859311; x=1752395311;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5YII51QigkKtS64qKuppfq50pt0v95OOa0Jsb7tz9mU=;
  b=LRJEr64/nlMWhkZC6HGDyvuOZEsdIqoTl5LA2bC8VfrOo8XyE8Rfw/2d
   5gG3wqQctkCrzGor9lHCGx0UdaG7LGuS7+jECvJ/DDXyqw84OXoFr/Fvb
   4KiYEZyEKfZZSVNTAP+gDFIG2qob6d/uQj/4K9m/Yh8p4EZ+uljv3kxKd
   cgYrFRBxMZxL5RD3vlwt3w8HkqCqETuelWdlgNvfAvIPhKSWC1SuF/tHj
   97/+uJJr3oG2GM40gULVQCg/jDXeCW+tLJumUVfn4uhO1WsR1POcQhRx3
   wgNcdevnJCdtNrm7S2dXMR+LNVTA9HdNN6CbMPzc6djv2kZtq8H3oXCvK
   Q==;
X-CSE-ConnectionGUID: AGoY78MqSIyA9MhBKFUj6A==
X-CSE-MsgGUID: zdAY63dtQAq1wioz+U545Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="12533305"
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="12533305"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 01:28:31 -0700
X-CSE-ConnectionGUID: XC4Vm9MYSz6LCivLc3GpRQ==
X-CSE-MsgGUID: IIssJGB8QaqbjdVALHnTTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="80227198"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jul 2024 01:28:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 13 Jul 2024 01:28:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 13 Jul 2024 01:28:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 13 Jul 2024 01:28:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qodNo9DyS6aT5+At6WAdJdCebRoDQoXFJ2YB/AIgLFtN88DNGH0/vHK5IFtMm3/Rcgyf4IUC01N+WmBPSTONTeeHWDZ2lWWEh41wQezpSL6gbVsUbuw23j16i7TmQr9Qaud7ZBP40pUeSlWGEBBKyFQWtdeTisTL0bJy2nEq3cldqAiW5crk3Q/loc17hhO7AGvw37V4UbwqAN/InIfDsXxeHyyXxzxs3ohrbk+41f2sRqQVZD4s2iUjJsiS6TLVf92MHaKtwvqyY4Jv3iyllDAx1D7c4XZ94ar3am49+7jGfwMw1Dnc8G0OuMYQSif6/9YUg3gAEe7CyJdwhcJbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9+VoE2em04mvaLvAxYeROD8ZDy0UbKKg+cpKLQaplQ=;
 b=xg6Bxub6yw9zMvY/G4aSKK5BQ2O0bx9/5tYHWm2FwcKFVxTGV5Ti3N0lT+a+/hNVu+lT99ari6fl3VQWKQ33hI1Ftke3ClmsdZ16fqCQ6FbJQ/9qzcwCZYWgvhSzDEVYWxyURL5lLNAqA94Sfvx/SEVpaehALG1r+VWEI68pBwnFRktXrrrguBrQyMNrT5J+5ewyfe2s2zFa3S2OyKfRP56cBjh9KsZ3yaBLnl56VWXbrpFbhlNtATbSPDR9pEYKhOkv+5/YJ+MnufOjTwNhcHY9Zkh3ZQO4jF8VC9/yUFlGqTFJo2dCKqWjAee7OSDGk73HBFq4BldrYJWwCmkCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Sat, 13 Jul 2024 08:28:26 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7762.020; Sat, 13 Jul 2024
 08:28:26 +0000
Date: Sat, 13 Jul 2024 16:28:14 +0800
From: kernel test robot <lkp@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?=
	<philmd@linaro.org>
Subject: arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: i2c-mux@70:
 idle-state: [1] is not of type 'integer'
Message-ID: <ZpI6nr3HE+hTCRON@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|DS0PR11MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 64806fb9-1168-4801-3da1-08dca315c450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p8qklbMKDXi6Iq0j5QP0NH4Qb5ppvlfBPb35nc2Lqdcv/KPDCWrrPbdTHm/k?=
 =?us-ascii?Q?un6som+AAxpkV+HPih7PpA1qCIvx52dwnLymww9LZ9OEeddIn8hGemTZ+X2B?=
 =?us-ascii?Q?J5HVbd2OOEAMp0KUMIt4e7eBOQiecIzMJyDh9n7TPZgAvuQNhEY0EGAqRLTk?=
 =?us-ascii?Q?vH2auyXPQqetSBeSZk+ipQTgHuXhhS19dO/8biecC9sSuGMmkud+muubBaG7?=
 =?us-ascii?Q?XBCXrJTD+oq9gVTDqogDQtX1/L7dZoZjlMhZUQ6xpr4Lkh5TKqKoNCzS7PXI?=
 =?us-ascii?Q?AV2qYEcJ2jkL+T9FGmJMst8e+QDNl9u4IlUuYzN24nBdjTbtR01CcUpq6VaM?=
 =?us-ascii?Q?KheuRiHEmxqtLPT05AsgorIrQtyM7+5yvh0v0+nhH71JWHiD6XG66+2tdzcV?=
 =?us-ascii?Q?0wR1K3YEq6WPgAZRjELujBvtHzhVkQzbIaT0eF1ghQhjVJe+7OGlLtb0lSff?=
 =?us-ascii?Q?vXCUWunuybIbjlFXffRpcCGcZea6X6JfZXshgFJ1kaIVBzjQx+5rAzrKyaxr?=
 =?us-ascii?Q?ZRUL54ShasSC1lJll12xTlLZANWBIbgejLhCRAvvP6MrlKmZusfg7WIq4+59?=
 =?us-ascii?Q?QUihvV1h3o0FU3ZyH0QEddv4tesZxjGgF3rEn/aC//F6hcEOPboySSIf8FXF?=
 =?us-ascii?Q?GtbrHGb4qWhnpDcyTi/yagndnO53v4zwMmNz3jUWzUwFo+a/OjIyYNTDOJy8?=
 =?us-ascii?Q?LaCQFxBf6htHcmoe7dBSBQQSZ+TJls8KmH3xMaXnbPdeFmfmR4gOfbxAMn3T?=
 =?us-ascii?Q?yn7KOcIR9XkRnRqQB1/IdS9qJoTqPSFSre+khAMEp9+osXt+8078i3lNQfTR?=
 =?us-ascii?Q?hdfJCxwqwvqaKogHZx/H0PGxEImbnEsTcAHo9o1S65A5Z6yA2meJhFxU1vr5?=
 =?us-ascii?Q?X3m53bMuNIZ3HK9m5aPgPiVevPpYY0ossM0bXLnK1BhjmAU7LqR+6DXCQ0dL?=
 =?us-ascii?Q?zE3tUTld+O5Kk/57kL7e8MWPIcEUyUUFnzqjpQMqajiNvxvPD2kZPfn87orW?=
 =?us-ascii?Q?TQB+uW90PSPYwU7ZoC6ufxjsZSBWfomjxouXcXC2h8fMUcojOZ95u1r+LyYX?=
 =?us-ascii?Q?R77H/ePi7fIiWRYGM0I8Lx4zZXbZ2KaMveoKwckHFIyrKGH29r87e8OvRrMB?=
 =?us-ascii?Q?q5kQYsUs9jtZMUUYE6WSQGaYmqantemeCcMInj7NnvX4HG7na9ToVKmvlDkZ?=
 =?us-ascii?Q?KJBwf66pO0gIOrvSOnwdrfEJ+aEPkdjRfzUwTenRad00Nje9029oqhabtmWO?=
 =?us-ascii?Q?RwJlKVP8OMGStKpWyEwu+idMPVmQdponk7uvlTaVMD1rFIjWfZyM4GzI0Ij9?=
 =?us-ascii?Q?ESEtWtFRaxMQxeXtdYrcq4Q529dv94a9WsFwd8zUQHbSayo8GQMBJzQb+gYp?=
 =?us-ascii?Q?5TQr9ro=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3EiAJk+vTetVszLcZfEqDE6tRfFOjSLjFSmlFoOnjfp0JOeTzSKzj8ArNYYU?=
 =?us-ascii?Q?K9nsU41k5xnZ2ee4KkgtRoK5vTEZbanI8ElQsOKJvLZ77QcEwQPavlEMfBgW?=
 =?us-ascii?Q?suUh8pj/wk3WSv3JS4OEEalPBstfdzMEY2MdwCEE4FtiFYUOyzR4Yy8bwjyz?=
 =?us-ascii?Q?X/c31TbeohCcTc6M0/Te7BPyyIPZPHQFblZiQh36BR9YCxuKIp5REvkQQOvU?=
 =?us-ascii?Q?SWTZGuLu1Pgey/syqDie7GW7tc7PGcDElQyZtxrhVT70h6ov9uHZVNh9AxWC?=
 =?us-ascii?Q?Xv7SGZFholv3lu9CZg/2sWVm0xP1LZYBEUpIz98cd/cXGHnQWJAmmclf/VaI?=
 =?us-ascii?Q?THMhxozeuD8VdB2nhFwh+kZ/sN2K89AbXMbZ92aA8CynSnaUPrZIGMDMZVxQ?=
 =?us-ascii?Q?anivcCcHj4Kwlpdu76YN1NxJzE9iqvjPBlh/S/wS5GPGCd6SiLYZ60mjHr/u?=
 =?us-ascii?Q?fJdONv69/UxQYyfbZDHnuJy0jvQoiL3PNv0VjoE8g6GIidPEB3/dSO7aw93/?=
 =?us-ascii?Q?ahNamLuuWewJFzE3fAPDgCJDVIcL7V0+em5IIdBNAQzaBdFZstro7uF2M6HD?=
 =?us-ascii?Q?nGkKj7viCepCycLAFTWx8zd9D7/D4qILh6f3RLYF4siRAnVr10s2wJQcV5wi?=
 =?us-ascii?Q?i2Y/1LFtJv6XJYRHdLpEATdXFsslonEduXEUWIQzpZp/XXxb+rjcH01OIs4T?=
 =?us-ascii?Q?JudDn5rElm7yx/S28uQWnatTVpN/4Ob9TGBLFEV1xwQwQPmXuOeaToKm5w9U?=
 =?us-ascii?Q?Td8ReXgKT8uqwIQOHnedpzQT7gT3SBQ4nrjnRYX0yludui7la+4ml3kSOR3C?=
 =?us-ascii?Q?kvW6p/5f6ArtM9PnEfEJBmFZjQBIP95K/PI3CydlQgBrEDxwYCWopcnKIvgC?=
 =?us-ascii?Q?EZJUWtBpatJ2s2LhVDlrgLKLJKP5VSwhX9DknnBP8139USQ31E6AXZb4WHnD?=
 =?us-ascii?Q?yM1zy8BBguWA8ZDHZjlnIQYhK9z34bxou/pK2F1Hw5Mz27YBbFzIqTtR0V5A?=
 =?us-ascii?Q?crhMkAZFlIt+JAYV/C7UnanhbSUzo5u6AlPK4QAh8WriBxnin4FA6+xRtljQ?=
 =?us-ascii?Q?zEXIvLLCgaXWOobh1a0U7vXN8JJi6JfzG39o3g1hL4iaT73aqXQ+aB4Yemxm?=
 =?us-ascii?Q?w6RYyvr9B0GsCUOLJdC5MTD6idl0VQ4ijFwY1gM17Jw2fYw26BSCStODxJrC?=
 =?us-ascii?Q?1cClVMWS4Vu9uhIqRbxbpJEgK3Xc+uO51jwHo+zZO+zkFK+nwUb0KoPZs0j3?=
 =?us-ascii?Q?SCRTquK4K8Op2AayykY7uDW1VbfY6JbDY1uYvhHH/I9I4Fq2Wg9hvDtHLpVo?=
 =?us-ascii?Q?0LFfYCEMkO6D6gRTqGG1jefwi6pbGLzi99XiHUNeAPEaRErzDdJvGVaCYqqo?=
 =?us-ascii?Q?VdwVvnj5SCbx7D5VC5z5IWCaIbrVx5v7UtBNxl1quwfP5t3Puk0J6Kq/r4Dr?=
 =?us-ascii?Q?OCApQTwh67SFpSlapqzx3hbc3g5mPQI+cB6UjLHz/R0syQECi5Ekf0F3AHk/?=
 =?us-ascii?Q?Awp3yf8bWcyfNFyYa/nzmMKq6+oRAhXw4fVWHdjc5g4zji6M85sdJLEhsLaj?=
 =?us-ascii?Q?JfFpCDXKoVr7h3yuUCCkAlaeGM9eheWYr4BtXAbYqFJN6O36sBugBGvTLQ5f?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64806fb9-1168-4801-3da1-08dca315c450
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 08:28:26.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtPNpWvrzgIy0FFHd7NWnUG61HCSt5hAgjLJQb0KZgko17OGbK52E3jMiCwZFXBFlc5qdDt4zjiT4EXhpuPhBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8018
X-OriginatorOrg: intel.com

Hi Geert,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d9a2f29aefdadc86e450308ff056017a209c755
commit: 4b46d86c978bbca24c110a5b0d6890380ed4b6c7 ARM: dts: aspeed: Fix pca954x i2c-mux node names
date:   11 months ago
:::::: branch date: 5 hours ago
:::::: commit date: 11 months ago
config: arm-randconfig-051-20240711 (https://download.01.org/0day-ci/archive/20240711/202407111159.NNLaem91-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.3.0
dtschema version: 2024.6.dev4+g23441a4
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407111159.NNLaem91-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202407111159.NNLaem91-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: i2c-bus@600: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: i2c-bus@680: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/bus@1e78a000/i2c-bus@680/tpm@2e: failed to match any schema with compatible: ['nuvoton,npct75x', 'tcg,tpm-tis-i2c']
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/bus@1e78a000/i2c-bus@680/tpm@2e: failed to match any schema with compatible: ['nuvoton,npct75x', 'tcg,tpm-tis-i2c']
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: i2c-bus@700: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: i2c-bus@780: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: i2c-mux@70: idle-state: [1] is not of type 'integer'
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
>> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: i2c-mux@70: Unevaluated properties are not allowed ('idle-state' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@70/i2c@2/pca9551@60: failed to match any schema with compatible: ['nxp,pca9551']
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@70/i2c@3/max31785@52: failed to match any schema with compatible: ['maxim,max31785a']
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@70/i2c@3/max31785@52/fan@0: failed to match any schema with compatible: ['pmbus-fan']
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@70/i2c@3/max31785@52/fan@1: failed to match any schema with compatible: ['pmbus-fan']
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@70/i2c@3/max31785@52/fan@2: failed to match any schema with compatible: ['pmbus-fan']
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@70/i2c@3/max31785@52/fan@3: failed to match any schema with compatible: ['pmbus-fan']
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@70/i2c@3/pca9552@60: failed to match any schema with compatible: ['nxp,pca9552']
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/bus@1e78a000/i2c-bus@780/i2c-mux@70/i2c@3/pca9552@61: failed to match any schema with compatible: ['nxp,pca9552']
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: i2c-bus@800: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


