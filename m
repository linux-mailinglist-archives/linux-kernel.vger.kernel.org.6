Return-Path: <linux-kernel+bounces-278836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FAD94B572
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A471F22C8A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6F07FBAC;
	Thu,  8 Aug 2024 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EApFno3L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2180038
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 03:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087722; cv=fail; b=dD8Tl27SY1WhU9gyx7kxvq4UP3i64jmHF4ZlLJWY5UTmH5UtDUcfXljUxYaejWG40JHG2iphlOHKQp7QCG96uyFA7z81t0xdU4zSkWicrdHuedhowwh0cOIIAF2yVOuu0QQu2NGAVKQo1n/DDH1qS40SgYv8z5iTAFIyxWG27JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087722; c=relaxed/simple;
	bh=nHaS3kxarNDwwzsCVHGA6XOjJbOnvF8Mu61yFBNZk6A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WNNomx9gLH4AFmaLklLYXou5bSrL2PKyN9ZX/3K5A6g4RjJx4k5lHqsBTqwyF/qmGKkUMMHYopOzfdFs/UD1DWdZOe3ogzEXvbqeA+7jqFS8uclQJUdCwdw7jIKfPldSt6fVLnzxov3aPeqV3VB8zok0wQlZjTITvR2SeonXI7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EApFno3L; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723087721; x=1754623721;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nHaS3kxarNDwwzsCVHGA6XOjJbOnvF8Mu61yFBNZk6A=;
  b=EApFno3L0SnMJzt2wgsGUITSMYBIM2AAGDdYT69pAODhxAVFL+h/TGLP
   pY/R4DSXmabFfJWWwe5lNTceO3M9CR6cCddIK1JJAIIoo3f58cDmwk1dS
   C7Qh4q+BAZVzuYI3F+AUYm1dPotsXtZgbAa8w3BeAOuSFMWJwzye5FmMP
   GQ3l3LClheDVZymlD0bg9Tzli0TLVK5i/DE1VHdvsvxilRn1u/59p5kgX
   U/wN9Zeu5ToJnxV7xH0mqmBQK3r8H2caAwrMmQpl6FEt35X3x/n3zEDHg
   oBihi738kMBY54z/PU4J4q40rwFT/70AlrqevjqEqaGrWlttet+YrF8en
   w==;
X-CSE-ConnectionGUID: hxn/5rDrReq8x23v11lJKw==
X-CSE-MsgGUID: lSpTAvQwRVKuGKJlVR4okg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="31767719"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="31767719"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 20:28:40 -0700
X-CSE-ConnectionGUID: EhwbrTRTSiihyicMQ1IkDQ==
X-CSE-MsgGUID: zwEDP1igQk2qWx1K0qYE4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="80308340"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 20:28:39 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 20:28:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 20:28:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 20:28:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkviDwSPJRiVgvgKnE+fH4EpeLa/bZ0J/ukQAjCPGZzWwUbq186ZSxfalhxedPTuTAboYg3KU5kcIS+Y+Rw1i0XsZMgY4hWAQLQSkA43vRnIrTvjum7+3qSt3Yw4jFPubJgvvSgIGFusp+qQQwtvzlcc1Uh/dYYfx27yGp9L5VCiYHTx4e59SyOGZwy+43c0uT3aUPrQwaVfFqZbxrHokNnhOSiUovRiz9apYV4dsWYUpjwaDoZ3nIoKRHoGx51/H4t+S2DOLChMBT7qQ+Z4Tg94Yd5xZjbrvGP1nJCjGR5rYZJdkh9INFAPrXXt58X0ew0C+hp/XdUJx6TNaJ0zkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oQmFkQCcmP2Q8K6cImb9wzofL1xcebKhTbFfVhl52I=;
 b=FHp32yq/XKoyxFZkdAD0Ip5rNVCkML6/Fa363MTTSoOtHb2coN7akDJKgZoZzEftTepOUfQBqzTPjDZLNBZUv7ylTD1llsS8ZcvsEk03MDKxov5W+6gS5apKhiWHc7TrDnAMyYk1AevKnVD0nE28UmgMQmhQItK4/p+nWVH7K/nzm8+2PERil6dGapdmtIE8MjeY5JBs4wDNQetulI0xhL8yPlrJPLgTUl8eREpPPPUDP//WbGZacT4rTIKVWybW0ELyrhoJG34BxaqVVphb0m5IVvLuPgLqkJHYVNM/cmjHlK1WvbYXfOI9A83WduR23C4CH7Ffg2byfQWxVg678A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by MW4PR11MB7104.namprd11.prod.outlook.com (2603:10b6:303:22e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 03:28:32 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7828.029; Thu, 8 Aug 2024
 03:28:31 +0000
Date: Thu, 8 Aug 2024 11:28:22 +0800
From: Philip Li <philip.li@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: kernel test robot <lkp@intel.com>, Kent Overstreet
	<kent.overstreet@linux.dev>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: ERROR: modpost: "__popcountsi2" [fs/bcachefs/bcachefs.ko]
 undefined!
Message-ID: <ZrQ7Vj4hf8Fbxa6j@rli9-mobl>
References: <202408070432.X6n56VaY-lkp@intel.com>
 <20240807153616.GA2942016@thelio-3990X>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240807153616.GA2942016@thelio-3990X>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|MW4PR11MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 45428a86-0417-465c-191a-08dcb75a2d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9N49utCt29ruR+YLQlhVU3p067rJlwOchvaRYjb1wKkXM2p7SinJD6lb+8pZ?=
 =?us-ascii?Q?kdxBxL8MxH+M0bUxIEaTF1RikkrSCQNl/ZasVDgd0ZgTJGvu/QfbQHtrSZ5X?=
 =?us-ascii?Q?LSw1ZNWPNiZjOQwBSQdMjbvaRp8oqWTbR48vvRXNElnfnxjpIOtFxJy8toH3?=
 =?us-ascii?Q?p6XA8NdnukUuqQhtTFve0DeByqc1dSKzj60eYVUXJgdbkTxXc+c/q2ihEsEH?=
 =?us-ascii?Q?jbYRIqmm/bti7GszVgjUa881Ltsfkc3whlAMLwziCYVxQIdsQENdWzSBGCH7?=
 =?us-ascii?Q?/PNaTsUPni9Lq6gOFIeQeWaGZwYyD1GfH3IwPWmUjt74UmnNiK5ny4pN1bn/?=
 =?us-ascii?Q?v2hxduntCZDUYmtTZDDQK8nDvMwcrRfTBoo2VAef8ZMXjoecWGoGY+GaEh1c?=
 =?us-ascii?Q?KrgVsNFtijeLeeBboQr8jgW4elJ9Y5lI889jc8huWGq6gMF9XGA/iQMRqccS?=
 =?us-ascii?Q?v3Aoo3eFcNzkIx81X3VjPrakhNgv0d5IcMbvhQKpR0j9GeXCci3Igxf2ti4U?=
 =?us-ascii?Q?AGJzRFjc6C7dvL97KX0K1kWwhxSBvKyqC8NeMcZ7RZFIl6oE/pzxh2qzrv3a?=
 =?us-ascii?Q?oXQ1Ja9OSYgOJsmqV28Jtnsd+ul1rEP2Zxoz80KbrzhC2PqO3WAipJdH9Uoj?=
 =?us-ascii?Q?+E8M0QrNa0z54sNxG+1iWRWdn+VNpunCHBa/T4oOsFr44VKjMmU4Xz2NrdKu?=
 =?us-ascii?Q?m/TYBYB05Pshe6oib8wmLxasN9XnP2hifKSGZ0sTYocRvBZpLgt6Tkfgv2Ps?=
 =?us-ascii?Q?WELQRTbMRKrGP9ZWdDLWANbp7DAuvClSLXPJzIk41mz61vry/Gk9KWzbfJW0?=
 =?us-ascii?Q?xpW8dyuufxhnE/Gd2vT4ALDFddJdbqJRbLA/uP3xUhT7AM+6QJH3muBPpnCW?=
 =?us-ascii?Q?srT47wAr0u67HL4i12WjPmCt3uUPFRhPcN/niAedBq0BXqZJdCPg4GCNAqbb?=
 =?us-ascii?Q?2YCyZSDiEc0rDw1iqKEAokJAB5SUdxxBYmZP2ZNTkuGRxGud2W47GvZHs13T?=
 =?us-ascii?Q?XtNTBi0a5BToN4F1jmb/AXCWri4ibLi6VLROzh74P9kwOGMMfM2jX7awQ20z?=
 =?us-ascii?Q?kop1nM1sUjHUlJymp9uoRUXOvX9f1NoAVECudSoJi3SLNHvm+o31i7mFFqRI?=
 =?us-ascii?Q?tH7ozmsU5ElBzdOo6QJvlAbPTNsZvegjWiI0/Vh+D3VFlsUg/fxhmzra8C/s?=
 =?us-ascii?Q?p1e7AB7nj8Yz+tb2IwD2G1E0ChHD1IZRIKCd2Cmqd1ykk4xGfETDhnPWIMWQ?=
 =?us-ascii?Q?C9/aegYKBw8iN/sor773ttSJiUBC6cZRpGIDFdPYZTHSwHo4LTNqGmBi0BgZ?=
 =?us-ascii?Q?6O8KjvFQdThF+OEPL0seNeVO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qiO6omPwuu3nIenYileNlFeyr5rtOHuVmcdpdM1gGmivh65W03fi/DYCMAHt?=
 =?us-ascii?Q?/48PcYe5dzCsY5X+G0VNNuI9ga/aCstlANSk+TqzPP0xbNEvzlJ6sNE7GAzN?=
 =?us-ascii?Q?9OutHaLUMEuRRxj02FyNpvFkvqLDS1r2h1Fl9tP9YBezxUGFbtMd/ujtWoAi?=
 =?us-ascii?Q?y5SjEQVkGPTPeFuxGgb0ErXUkqp3vMXCCfkN6pP2gtE/ZTMe2ff9PKvoRNGq?=
 =?us-ascii?Q?EMhAmwdgbftrHaNinwNTpoSVnjAXoqQzWMF7vxC15+iv+d7+tWIYXS+etkBP?=
 =?us-ascii?Q?e9g9oZJq3NPNgDakTKw5RKZo6Wtvz3qOPEsbUDyyZQFNDCPR13CpPRcu1K1p?=
 =?us-ascii?Q?d4P+NDO36q7GGS0FVqQKhJJjdqJjwtbxxdvbooiZzJaCZwyyxZVnVuC5eSRY?=
 =?us-ascii?Q?XljhmmBWcEW3uJHS7LhvHnRh3q+N1mw68i9tmBLBf8VuiMKub2oCB/CXDeWw?=
 =?us-ascii?Q?VTYtJ0a/EOn00qBlM6Tq0erFIB3NWZNnxnniPZMpFiy9AkPg2RApgmqxFMmR?=
 =?us-ascii?Q?KwCaaL6ua8N3NI+Qk7OUIWL/g5NpkJ57Hqmx93/kbQnc8LGuKTgb93/jsovm?=
 =?us-ascii?Q?K6hH7ESnPfYVew2rnNdz3pKYsupkXbPYbXMXn5TN5NDaF3IJhfpHFQLAHXwB?=
 =?us-ascii?Q?c204efkj8z6YvXYiv/u0U0PuDNzgCKQXE4nOho/ulXnoh9QRaqz4wgpSdo1A?=
 =?us-ascii?Q?cVBAhiKjzJw0KvUhZzOhz0LHym//WBafd7xKEZyRWtfntX1F0QASKox6XPaA?=
 =?us-ascii?Q?b4z/mIkX5P1N1ijIS2TNC5UIvRim30I2XdJwSDs/ncUD156e4fi9qhVzCjJ4?=
 =?us-ascii?Q?yFmOn5j07jLkEhf7Tv3DguM8MJ3nVcds5AgewO8uGgiZpEMQDt4VsYeIGG6z?=
 =?us-ascii?Q?DS1dfPaH5tVg/9rXCRFR1duNEFxTjZ/SCIB9o+RVqCxU7fpyrPQBsBId5swz?=
 =?us-ascii?Q?49KtJcVdtJ1iVSkJ+zEJq/SwvIGix+NoSB4BbDhbvr4o1M19ObMmE7LanyUA?=
 =?us-ascii?Q?xjQsqPeGIkOXXiLw/ma6GoneYzB91jv/Gsi697ERHxyCzabz7YEAntOc4rOi?=
 =?us-ascii?Q?RA61PHytfPl2C2MB0gFiiUHhDjAIH+sqSjsAtXOnp/FKQn84dnyj3vGAfmtL?=
 =?us-ascii?Q?nEjcF1lNrd/1yO5WRfS4sTKsLSmekfNwAepVmIKBL1D4WDGJZIePi6yiuj2S?=
 =?us-ascii?Q?tCNU0ejp37yaBUoIPD+z4geR+Kq41IRRK4VacbKTMP5nEpSQXSyinfknNlS7?=
 =?us-ascii?Q?ddBBDnkQxi94nPtm5VpkmmGRdztqsSYFDFASu2xb8LpPpUyizKq/h0qY6KNe?=
 =?us-ascii?Q?FSV7bUInWElUQHukzcC3MOc+uiYrtzDbrECFRvzH3wwekm73ufx2AQOlKoue?=
 =?us-ascii?Q?AxFh0PQ3APHSqTTjHUlqxrEU2yUVucSX0h4L9Teuu/oBL4QJs+KtQ+UkJKOV?=
 =?us-ascii?Q?cxIqyRfARfuQAxt2gYXN4lxLhL+LZlIS5GQ6D7LTeLx8TwsCvqHa4Y/CvkK1?=
 =?us-ascii?Q?eqYf+3q0hw2fq1h6yDCwiTEif1qPcnFS4o8tQF0cIUSMpZ9hbd/8KAluMjCh?=
 =?us-ascii?Q?Q/GrhwUlh2xgZpjfQjXueW247aNQWio8OUnWxVJY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45428a86-0417-465c-191a-08dcb75a2d34
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 03:28:31.8882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRZozyoRcjqOl36p9HBZHyih8mihSgOwk79KGeVkEXQzRo2mc6cuBufjiClVtRQjpyK1eTkREWgaVp1FdaN5ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7104
X-OriginatorOrg: intel.com

On Wed, Aug 07, 2024 at 08:36:16AM -0700, Nathan Chancellor wrote:
> On Wed, Aug 07, 2024 at 04:43:13AM +0800, kernel test robot wrote:
> > Hi Kent,
> > 
> > First bad commit (maybe != root cause):
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   eb5e56d1491297e0881c95824e2050b7c205f0d4
> > commit: 9ae82fe6ace1b267005758ccfb2347a4a6aa4398 bcachefs: Inline make_bfloat() into __build_ro_aux_tree()
> > date:   10 months ago
> > config: arm-randconfig-002-20240805 (https://download.01.org/0day-ci/archive/20240807/202408070432.X6n56VaY-lkp@intel.com/config)
> > compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240807/202408070432.X6n56VaY-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202408070432.X6n56VaY-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> ...
> > ERROR: modpost: "__popcountsi2" [fs/ext4/ext4.ko] undefined!
> > ERROR: modpost: "__popcountsi2" [fs/fat/fat.ko] undefined!
> > ERROR: modpost: "__popcountsi2" [fs/hfsplus/hfsplus.ko] undefined!
> > ERROR: modpost: "__popcountsi2" [fs/xfs/xfs.ko] undefined!
> > ERROR: modpost: "__popcountsi2" [fs/gfs2/gfs2.ko] undefined!
> > >> ERROR: modpost: "__popcountsi2" [fs/bcachefs/bcachefs.ko] undefined!
> > ERROR: modpost: "__aeabi_uldivmod" [fs/bcachefs/bcachefs.ko] undefined!
> > ERROR: modpost: "__popcountsi2" [drivers/block/virtio_blk.ko] undefined!
> > ERROR: modpost: "__popcountsi2" [drivers/net/ipa/ipa.ko] undefined!
> > ERROR: modpost: "__popcountsi2" [drivers/memory/emif.ko] undefined!
> > WARNING: modpost: suppressed 5 unresolved symbol warnings because there were too many)
> 
> Intel folks, can you upgrade your build of Clang main to
> https://github.com/llvm/llvm-project/commit/4527fba9ad6bc682eceda603150bfaec65ec6916?

Got it, we will update clang to this version 4527fba9.

> The current revision is broken and unrelated changes are getting
> notified. There might be one more regression that I am looking into, so
> consider not going further than that revision.

Ok, we will keep at 4527fba9, and kindly let us know if we can move to
latest head.

> 
> Cheers,
> Nathan
> 

