Return-Path: <linux-kernel+bounces-258579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D70B938A06
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74EB281726
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ACD1BDC8;
	Mon, 22 Jul 2024 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJYTXMeu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D81805A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633423; cv=fail; b=p/S+teN13GMJuMolTIPMyvLxnKvMFSa0Z4uDoopaj6Ui6XNMqFqNxAJDqpXpjPr5RM/11h8PM0IJf0+iChkL/Dtdy8dAHfY3B1jVv8zNUpgaUcBTs693R5xjO/HmHRIcKd/vmUf2PvHL0RFNmD3ymrS/CH6LoM3klYGqKSDtrok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633423; c=relaxed/simple;
	bh=Q7B/ZYchplE2LG3K1MucjbMfxSHlU62BP1+maVbX/2Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=CYwkyaCO5i8TZb4iMU4uVJGYREVXGuRklKjBg5ylbwy3h9wZwSLJijM4omxPKggaByUB2iZjGQL0MI5KY8KNNEX2Ang0mvSQp7RypD6IRmxOcdzVG9XwSIBtl02yRx2KgGiPebpmlEwRxmLLh7R0bugVedLpJ2HT3y1CTO+ZcOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJYTXMeu; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721633422; x=1753169422;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q7B/ZYchplE2LG3K1MucjbMfxSHlU62BP1+maVbX/2Y=;
  b=QJYTXMeu11fXlcwjLZ8BnIHAJq8JIFX5xB/6yN2qdzcX8bg7TtivOo/Z
   IhiZUnGXcTk/DGdSTXALzOjQyrsz5K4g2RhqjSgNhNUCWyRef9DlFGY6X
   kZ+WRtggMok8EoiITgBpIbm//RId3O2Jy0th0GnHqUZdhl8wkT/R0dA23
   HVoEoTHGmusVh3UlIcsdVAtiNUochTQ/QvFlwfiYYnbgboLoNjdOKwHFM
   Vxh7xjK2jUZ1Jn7rJQ/4lRUOfnYM49mumA8hrMQiXiqQQy9Aoe1WT7t/L
   bpNBvAoj3yFis/WbnKxLkLFkHbUymKZnQYk6xXgxM9wyeaeTtTKS/sU4k
   w==;
X-CSE-ConnectionGUID: cWpm2GCBS12xCxV81w3SZg==
X-CSE-MsgGUID: QOHcY1xeRzGVnSaR3VMoKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="36626227"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="36626227"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 00:30:21 -0700
X-CSE-ConnectionGUID: xZLkP8aMQvq02L+4A60WiA==
X-CSE-MsgGUID: 6CDTftQfRFCvpOXl7H10fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="51682086"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jul 2024 00:30:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 00:30:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 00:30:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 00:30:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKKflf800Gx8eeNd2NiD0PycTcQ5GQox7Ck6SqqSkHVcPtmo72vDqtPXhKD3nBTO6v0IUVUhlMYppg+mHO2uqXrHBgozsurSO9TsVHQfcg8Vy7IAmQiGJgQfF5SpO2RfhcDqeSa8vdo2WQzN18wWO75ax5LEczwXKRZ5ekgxVpLQhxGWE8AGYKfFEkUP6IlbGJqnRA6M6dusquEAGvGrTSTvpzNMoW8Jb/4Nzwpzuthdj5we5dx0CFIZ/UczD0L5sTYfFdnp4DVjfBxZqjIGMF7jgl2RX4qM4BlbKCWFKQrAWXnXkfGeQgOxSrqWA3YCYBeYQJ2FlHe1V+JclXU1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoA/HYUB3j+c7yL5s7i2LjOK4XNNZq8Yo9Tk1J3pJbs=;
 b=wsaEVMXerTgL6OmcSYGskrGC/C1o+7qlK4KtaCC/GuoySmdYumogdGMTZDt5ECYyElxX5NHfnAuCgOwULPmi2IfnxGx0afs6KL7QTr/lxfyYZeX8q28p83UKh52yVESQKvSFJQY6TT2AcZsXbjTZttSieHlI9vV7Ab6tHYwpCnRtKIfCoEJpBvjB89zzhYdXxyr6hAS9AG4y4OHA4s9nW8QpSXjvvIcccBWzod3Htn7fhWS5mi7+l/zmFWfK8Q805AISBlNXOvIpy/ONkHwSXi8OonGTz+FbvANIrc0hMpVslignC9kzDTLdu+2WJod9bf1waEfQX+zasnqmuC+FQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7189.namprd11.prod.outlook.com (2603:10b6:8:137::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 07:30:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 07:30:17 +0000
Date: Mon, 22 Jul 2024 15:30:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet
	<kent.overstreet@linux.dev>, Kees Cook <keescook@chromium.org>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, Alex Gaynor <alex.gaynor@gmail.com>, "Alice
 Ryhl" <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@samsung.com>,
	"Benno Lossin" <benno.lossin@proton.me>, =?iso-8859-1?Q?Bj=F6rn?= Roy Baron
	<bjorn3_gh@protonmail.com>, Boqun Feng <boqun.feng@gmail.com>, "Christoph
 Lameter" <cl@linux.com>, Dennis Zhou <dennis@kernel.org>, Gary Guo
	<gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo
	<tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Wedson Almeida Filho
	<wedsonaf@gmail.com>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  24e44cc22a:
 BUG:KCSAN:data-race_in_pcpu_alloc_noprof/pcpu_block_update_hint_alloc
Message-ID: <202407191651.f24e499d-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 80df2343-87ac-4ab9-e42f-08dcaa202230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tG0gD5cCCEUMBwVN3fO7RLUI+L6mvwFLGbYV8twuY92YORE/Ecc+omXVEaYe?=
 =?us-ascii?Q?TkSgc5spCifb4la9YU2A6Jnd/a3rr0AO8jLeD7R7HKxn9/Pf3YLj9tUTJmKW?=
 =?us-ascii?Q?nQk2+taRJ1T5asVNKW8pxex/cWL2v7Kb1b5sJFJTPkjIDCKyvP55USMKxIdw?=
 =?us-ascii?Q?Q1thQ2yOs407qLdN3hX0rNh8uM/gpmxLqr32b6HSn1LYnV5AKtt9eJJwI3si?=
 =?us-ascii?Q?LCTMP1aiC0eY6bVAGdF8UWAZH2oZpxccL9vv04D2fWngDs5bv3O9OClbPNWL?=
 =?us-ascii?Q?G0zuguN1O1Q2kR3GxMSVLSgTI+jwsHkg3jKYhoaesFz+KDAVG8VsffI9U7U2?=
 =?us-ascii?Q?AI1wy+53Nc6ljN/sk2L8Peja/lXCRoxRwQYgoUINPKeGD+Xu9njXBaxo6wH5?=
 =?us-ascii?Q?UzZcV8APZ0IXa2US0PzIh+fSUNEJHP3cU04ovGIm3xi0XfretFk3tPmMubEr?=
 =?us-ascii?Q?FFcA0tGOXXpivy42uvK62TNuZS4oz5oXnQlq3QJucNS+88ku/Hygh8SLeDVq?=
 =?us-ascii?Q?IXsyIJKDtxbEQOB1d5Jqy4CER5y39w5URd+MLeur9XIpvc7+bqD05uoeSxQG?=
 =?us-ascii?Q?IdTSxuE1tcUJWwsZD4rwd1gE5oySjCJdzmP4AlF+038+LNU7C5sZoxDKPFEO?=
 =?us-ascii?Q?txGxLz84GghqvnER6vsRq6E4/S0uRK7/wUPQsQU56Ohv9o9zVEJ0vo9DKmfX?=
 =?us-ascii?Q?EFNQ3K8uzs7iT28aJH0eOSFZP55ktK345GWULv8EOqm4DuPgSigV0DZ+yvf7?=
 =?us-ascii?Q?vovti6QA5dyY3a+EqoTluevEV/KBelD/BtgkCHYrZ4eqqLhqTsyzEwTFyCI3?=
 =?us-ascii?Q?1xpi99nhAcVjbudw/MY20Oa526d1J6svKn2I5Z3vC4IP81ekBTgSpYPc43EY?=
 =?us-ascii?Q?ZQKpNaDeSSMyi9etxCpNaF1w0U+Dxn8EqDZzKR2ec8ujBeDGqtxWrGibQ9LG?=
 =?us-ascii?Q?zt+y7kSfcRxeA92rREB9UR2i7tMfMH+dxtNrmCK9skyjULuOIo6HEugzLrna?=
 =?us-ascii?Q?4yX2FX6YB9E6K6pFgpTAXNQ2I7zsqfIS0WZ+eu4ZZzv1yDjew69z/rxw2uYp?=
 =?us-ascii?Q?L70FsvfiRF4UpZG2I/TOzXpzHyIbrJCr+3nAagGmkrNi/AdoJLjaKWquSnMP?=
 =?us-ascii?Q?Xr2A7BlG6pQ4pu/nZ8zkGJG5bDMgkXhEoShkX10XjavWUiWQJ3SwfZSHC3sw?=
 =?us-ascii?Q?5/OPNgms7fLkmx4Ffsx+6E4++ohvBGVj8x34pKlkV7fIb4k2hwbAhnpWl2nY?=
 =?us-ascii?Q?KYyjciISbb3wYnXzILG5rHqeoYPfyf75WtVtjdnClf2Q8LDGbHVeAjqNGmWB?=
 =?us-ascii?Q?7qaRLf0hKCE62+pe9aqo1RU2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eF7MsRwR3VmImB33oBAbcfqUFfA4PahIi6OW2XBmIdBPs72ntZwvbGIht2hr?=
 =?us-ascii?Q?Lp4sGZupujxjpH5JST+6Jwi4b9rsQmsNKpwE3Q0W9wDr3aOFJFw9iNTvAUzX?=
 =?us-ascii?Q?sWX3EQNCl4LCs+lDcd3i0A553acKCjtyLjv2RIsxqwf334jBDmYWvVPhRQyH?=
 =?us-ascii?Q?9grvu18LCbpdTXjmboo3mxbUYrOigrrNAmllIYDFSTC28O5L4G90hu/KLuDy?=
 =?us-ascii?Q?0DeHFgfygZdd7SbKTCUYdI4FmDsvrbXZW1s+ThDYX0cN1LWd0sjsiH/FtO8k?=
 =?us-ascii?Q?Wtjd5FcwjyQ/a1mI9OT2UqFonSAhrgsDsSQzXjrVgoLKa+WLKb+A4t5QMTcc?=
 =?us-ascii?Q?KBjy270UuL0lsnf0Xw54+L1aOXevyYSIOt/bOEyNKb/Hid3h2mAIMzDdoEej?=
 =?us-ascii?Q?rl0rtM9jNqNT66ulfD59i020UnsrzkDUL0Uii7ytUC6LzdE1QcUW3iBV0E83?=
 =?us-ascii?Q?uHMq6l16b3yi3v57kte3XgMA1+1OtdpY3u3ufOxgwjZ6ignfyvIA0gws4DeK?=
 =?us-ascii?Q?+8GfS+6xZfxDTdJ5kIXj0h3IQLDnLdhGNDp8IFxqWZJwUIYyL83YrOeYampC?=
 =?us-ascii?Q?hzDezgEYaTTp+cYb+zi7kVfvgDYKVvamngwtW7TCxLHDdNL5nX2OIrHKXycL?=
 =?us-ascii?Q?shHJ5n/LilVZMPVOZLkTuZo4ojue/XAurenqMpY8KSRXh3Siyr6Bl5zNSfqz?=
 =?us-ascii?Q?mjgDaOiW63xI4SC/9mMk7tOym6kEsOe2MgXjewBUPTlFU2Ye13oq1KvK5PBK?=
 =?us-ascii?Q?QSW2BQwzTrvpUgnia1XKiN7rXOHY6bejutkCGzGgWLw04vDPfyokcn0GlrXi?=
 =?us-ascii?Q?2+zUvEVWgFW9LHO2h1IW4DEccP8ougusFPp1XiDfVAK2Fj6fFEKOJhLkZT3K?=
 =?us-ascii?Q?AFD44lgoWvd7QygdUVhl/Rj0PGNEtgJuSTdfRo88SDp1+HJ3adXtXFxaFavt?=
 =?us-ascii?Q?dt2FcsYFKY4NIdhesGOzfvZPbVwThT92PlagQcHLy4beRCfqDVcxELigurGa?=
 =?us-ascii?Q?1fNI1/N7zeh2nTINd6Q8FetlZ9IHjeYxsJ1qHkJ+n7cnA/BTQX0Ziyb4QEDh?=
 =?us-ascii?Q?COgxJgptfqpZGXfewitbllh4JF4l5Z001surVGTfNOdKafr6WU4CSzx9pvup?=
 =?us-ascii?Q?KRPSlIr5hOO9FZ7/UWmsrRzOuV5qRb1zyCtVnM8RncaK/W28fXxisQxZOrte?=
 =?us-ascii?Q?YkFg4GB0HdyF/KpjXpe0nCstQiJbK7TOBZVFghn1MGRQVUFEJacCC4bHSaoJ?=
 =?us-ascii?Q?pnpWXrRnsMbyAyDKzND73tdoPUj3gRuAJpn0u1xmNLf+Cjx0NgdhmZHa3fJy?=
 =?us-ascii?Q?KjN2m+zrJH6vS5S2U+mUCmbWSPRwu1nxb/6UPSuP3Cac/DGb0DBGD12/yZA1?=
 =?us-ascii?Q?uEGteRE46bCRj2XgWV6TqiZVJAB10VKLtiwkZDfDI/Hy20Hayk9x3u+wrG78?=
 =?us-ascii?Q?lPUeqtA3yD311fsIQoHP1Hv1XKF3pjSGdNa5CzOQxJgKTWyAa4V56z6d8FeQ?=
 =?us-ascii?Q?osOxI3JMWbQAawT2LHjomIZdBGKw2xKoNEQ1xhnXqpK049J0tMCEFB5nnzJB?=
 =?us-ascii?Q?rwbOoZRjW8Q12bYCMXlzev1meIjiPGW3wG2kR1mt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80df2343-87ac-4ab9-e42f-08dcaa202230
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 07:30:17.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBKATg5yeO47UjnkyolSvrXm8QkVVuUke+H0f2EN5p7MytRnZ+5zcrFf347cQ0Qw+5fNHJ9zcnG1f9ufhQQHOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7189
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KCSAN:data-race_in_pcpu_alloc_noprof/pcpu_block_update_hint_alloc" on:

commit: 24e44cc22aa3112082f2ee23137d048c73ca96d5 ("mm: percpu: enable per-cpu allocation tagging")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/mater       68b59730459e5d1fe4e0bbeb04ceb9df0f002270]
[test failed on linux-next/master 73399b58e5e5a1b28a04baf42e321cfcfc663c2f]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-04
	nr_groups: 5



compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


as we understand, this commit is not the root-cause of KCSAN issue, just make
the issue change from form (1) to (2). furthermore, we don't understand why
the issue happens randomly. but we failed to bisect the issue (1). so we just
make out this report FYI, not sure if it could supply some hints to any real
issues.

60fa4a9e23231721 24e44cc22aa3112082f2ee23137
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
        281:999        -28%            :998   dmesg.BUG:KCSAN:data-race_in_pcpu_alloc/pcpu_block_update_hint_alloc   <--- (1)
        296:999        -30%            :998   dmesg.BUG:KCSAN:data-race_in_pcpu_alloc/pcpu_block_update_hint_free
         25:999         -3%            :998   dmesg.BUG:KCSAN:data-race_in_pcpu_alloc/pcpu_chunk_populated
           :999         29%         292:998   dmesg.BUG:KCSAN:data-race_in_pcpu_alloc_noprof/pcpu_block_update_hint_alloc   <---(2)
           :999         27%         269:998   dmesg.BUG:KCSAN:data-race_in_pcpu_alloc_noprof/pcpu_block_update_hint_free
           :999          4%          44:998   dmesg.BUG:KCSAN:data-race_in_pcpu_alloc_noprof/pcpu_chunk_populated



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407191651.f24e499d-oliver.sang@intel.com



[  117.357897][ T3648] ==================================================================
[  117.358568][ T3648] BUG: KCSAN: data-race in pcpu_alloc_noprof / pcpu_block_update_hint_alloc
[  117.359222][ T3648]
[  117.359424][ T3648] write to 0xffffffff8559e600 of 4 bytes by task 3653 on cpu 1:
[ 117.360048][ T3648] pcpu_block_update_hint_alloc (mm/percpu.c:602 mm/percpu.c:598 mm/percpu.c:923) 
[ 117.360554][ T3648] pcpu_alloc_area (mm/percpu.c:1260) 
[ 117.360960][ T3648] pcpu_alloc_noprof (mm/percpu.c:1835) 
[ 117.361393][ T3648] bpf_map_alloc_percpu (kernel/bpf/syscall.c:466) 
[ 117.361825][ T3648] prealloc_init (kernel/bpf/hashtab.c:338) 
[ 117.362211][ T3648] htab_map_alloc (kernel/bpf/hashtab.c:573) 
[ 117.362618][ T3648] map_create (kernel/bpf/syscall.c:1320) 
[ 117.362987][ T3648] __sys_bpf (kernel/bpf/syscall.c:5642) 
[ 117.363348][ T3648] __ia32_sys_bpf (kernel/bpf/syscall.c:5765) 
[ 117.363738][ T3648] ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-013-20240713/./arch/x86/include/generated/asm/syscalls_32.h:358) 
[ 117.364151][ T3648] do_int80_emulation (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:253 (discriminator 1)) 
[ 117.364578][ T3648] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[  117.365004][ T3648]
[  117.365203][ T3648] read to 0xffffffff8559e600 of 4 bytes by task 3648 on cpu 0:
[ 117.365797][ T3648] pcpu_alloc_noprof (mm/percpu.c:1894) 
[ 117.366210][ T3648] bpf_map_alloc_percpu (kernel/bpf/syscall.c:466) 
[ 117.366627][ T3648] prealloc_init (kernel/bpf/hashtab.c:338) 
[ 117.367000][ T3648] htab_map_alloc (kernel/bpf/hashtab.c:573) 
[ 117.367400][ T3648] map_create (kernel/bpf/syscall.c:1320) 
[ 117.367766][ T3648] __sys_bpf (kernel/bpf/syscall.c:5642) 
[ 117.368120][ T3648] __ia32_sys_bpf (kernel/bpf/syscall.c:5765) 
[ 117.368503][ T3648] ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-013-20240713/./arch/x86/include/generated/asm/syscalls_32.h:358) 
[ 117.368907][ T3648] do_int80_emulation (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:253 (discriminator 1)) 
[ 117.369341][ T3648] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[  117.369761][ T3648]
[  117.369968][ T3648] value changed: 0x00000003 -> 0x00000000
[  117.370454][ T3648]
[  117.370662][ T3648] Reported by Kernel Concurrency Sanitizer on:
[  117.371179][ T3648] CPU: 0 PID: 3648 Comm: trinity-c2 Not tainted 6.9.0-rc4-00089-g24e44cc22aa3 #1
[  117.371943][ T3648] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  117.372811][ T3648] ==================================================================



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240719/202407191651.f24e499d-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


