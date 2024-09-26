Return-Path: <linux-kernel+bounces-339799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDAD986ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA292820BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DDA173355;
	Thu, 26 Sep 2024 01:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsFGkbcA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FF01714B4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727315048; cv=fail; b=J/+Vxi90ii+qEW+fXbddreImBprp/1GNBXtT+ibtYPiWTKmtJlNe1aLrVk1XtzkB7TJAza+omduckS1JhK9vvjf4/McwbVjlbCA/v4CIkWIoaQ4rIvUBOvK9PutbxWQqb4w9o6XT+S7i6EzbPaRrzAr8axlpuBBL49jflO5XCko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727315048; c=relaxed/simple;
	bh=K3BFZ2K021ib/HMulIn/s3O1ZNzIGedR6TCrMz9Q/gk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mvQK7qq0XAQw553XIgl1yJdLFVtVW9mJLkENbDw5ogtLQxFIQvMBDNYNJjJtPe+xxTjfWgv0dZt1jbQMM5K+UtSPd7WwxS14LTj4KBDVTk5Iak1bbyrqL78aR+hi2qh5hWGNdcsHKELLRd4+9pgMmIasfK/F4DBPPaBJqp6V4vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsFGkbcA; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727315045; x=1758851045;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K3BFZ2K021ib/HMulIn/s3O1ZNzIGedR6TCrMz9Q/gk=;
  b=XsFGkbcASIX+Y+WF5w2x4QdrDDA4+caul3n6+D1q3arthImJQi1Z8DSf
   /ZjTUuDCfKYedwmgLPi6nEwwPvl62QvrRf3WqAn5VwjfdN3rMWCjJcGGv
   6IDZA/wPm7yBW08pl3Q3uSgXaU8HnybDcGU43uYTf6xK8J1ZWD37Yd3De
   lxd28VCEAvwWOahHCHTpv6SVwtBtNphEkdefvnJisid1Kn/mIjEgIeUOU
   HVcG3KgvOjQZsYnHk1r+VAhhIU7pMJxlEm9XBzsuVm29FW7VxLxdKiNpj
   gUKMvL1dQ/dBitx14hGDiTLnO8XRzn0K1eA6sMLm1xgtKb1A84AkvBNdk
   g==;
X-CSE-ConnectionGUID: 7i7jlN0IQI2CtcLIhkj89A==
X-CSE-MsgGUID: UBlE5lcQR86SwFxV/o/MdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="14014482"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="14014482"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 18:44:04 -0700
X-CSE-ConnectionGUID: htdR/gXZQey4uuP10tJ2KQ==
X-CSE-MsgGUID: 5zXTN7f6SRium3DDmgv+Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="109447515"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 18:44:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 18:44:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 18:44:03 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 18:44:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBMBsosW5uLsK6hD8P5kAjAxNUbkQjTNqIHZyUbzBf+ktDgBLR5Ws0Q1nl1CeAQwzwFEW7VFvTSWLT+n+nllnayQiZSdys3jF/51J3H9YHgKsyXXtY1PdseqbPCR83twlBBt4d1RFyZHPlXc4I/Jzs4u31gK/EpeRwwpLwTSSBqognpia3HxVMIMaazBduhVkVoDZJXP7wenUR4SLAHKdwFv307jIWeWOuTLHuezduLox7iQIKOmqcQXj/zvvI/QMdMEiD4ZqufMvJCorWGVck9AXfp4ImvP/5+2P3ORynvNUyyoKTR2zpRbgrPZd82L/DO9gGAzo11CmCYVhWLOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6GolKzCi/Lk1HEz/8MbXBaq+oIGiFQQLN5LfAGcYRY=;
 b=yPRNWXyl9B+hQO/pcdL+lEP2u0ugnmrraNURjBIxf3rK9ckwM6/gm8YSEzfgsBw8wwxybWWihKC65L4Ain1h2+43lCKj20jR3+IRXZZji7Ms25E9RMkdMiT+Ucq0rA8dPabUluKPuziX14PL8DhWDDCxrLdjSOYp7bC6chGnMOWcy6hVdCD0CaZn2UDtBmp6azaLDVvllOsShDPHP8kuqfEPxQJbCieIg012zNYZauUH9sLYSDM5q/GCpABVxP9ImjDGsOr5WwawN7/vAcFC/oZCG2YebdLZYZQrTxQG2yGZTP7B0/YnmHbPZKnQGPQTufHVAugcF3pOqtJEKt/rPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BY1PR11MB8056.namprd11.prod.outlook.com (2603:10b6:a03:533::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Thu, 26 Sep
 2024 01:43:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 01:43:56 +0000
Date: Thu, 26 Sep 2024 09:43:46 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: John <therealgraysky@proton.me>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Unknown <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
Message-ID: <ZvS8UhWRlfd5PjEn@xsang-OptiPlex-9020>
References: <202409241436.b37a069e-oliver.sang@intel.com>
 <4_u6ZNYPbaK36xkLt8ApRhiRTyWp_-NExHCH_tTFO_fanDglEmcbfowmiB505heI4md2AuR9hS-VSkf4s90sXb5--AnNTOwvPaTmcgzRYSY=@proton.me>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4_u6ZNYPbaK36xkLt8ApRhiRTyWp_-NExHCH_tTFO_fanDglEmcbfowmiB505heI4md2AuR9hS-VSkf4s90sXb5--AnNTOwvPaTmcgzRYSY=@proton.me>
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BY1PR11MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 5afd4b9b-6dd9-4696-1da6-08dcddccaf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UV75K1II1eDnX3fe5wnFxME/q2+tQHJ2lCiMAFP3gYUpmkJjPTmUjRy23bXK?=
 =?us-ascii?Q?hfp5jirPkx/Z79Y+htmDqeQhi6hme2eTbTT2f3mm8deYSQoMdrwUfsXhbb65?=
 =?us-ascii?Q?j/PykXXl3hq0VRB0fSkJdJu8+HZllJJKV3ooep6zzIZkN4InbGfhApD9Xs34?=
 =?us-ascii?Q?RzvV4ByC/eb409aF0uPO6qTRTzZzh3mzjDg9cwNc2/kl17goMQI7j3rgyVGB?=
 =?us-ascii?Q?oNeOZpa3DK9ezMquQ0nMd1p8Rk6xBai/KFPh3JWe93CTwur1ZQYu9oDjQjyP?=
 =?us-ascii?Q?TS9cwZlEEw2qZ2hldT2vWmJAfvK2YhfJhinN//4ZonnkZWaZ6EGLwZN4PWkn?=
 =?us-ascii?Q?zvv+WJJ1fPlCsaUfUQLGuVzPLCq2Go0ACLAZk7E1EpkJ98hntd8cohuziztr?=
 =?us-ascii?Q?fnA9zQS+se5jouqksCCDxp/3tDDtnqDIT/yuHKz/AmjheIzxAhR4VEF/aTgH?=
 =?us-ascii?Q?XjesXntEvOQmVWfADTo1hsHK1qOXLGROwkFpE0B9sOoIQ5nKnP9TaLn1sG+e?=
 =?us-ascii?Q?4I5YkwPdTzGUdfnr5gU80MuRM4mUkWZlJas2Hvk8QpauALNSQM9UAehF62GX?=
 =?us-ascii?Q?+2u7kC8XWmqGbNGFv6akorwKTS55x3AifG+9ZzL8C9/jQXKvFXD1MBYSf9JX?=
 =?us-ascii?Q?GKIE2VJGLlYDxMnesgPwMU1MjPtVgv3IG3uSc+bf+xxBZgMHb4nfFvf2/M0E?=
 =?us-ascii?Q?dHjlsUUidzhcsyqtLsr8X4sJFtosH3RNgVRQPamHgWAMUI2d4a1R6PtxvS2J?=
 =?us-ascii?Q?UG0IOEsMmw4I3pAG3S46f/46TUqpjnL3Lk0HjCZFHesicV8bR0CzIf2BMpyP?=
 =?us-ascii?Q?51kw7LAqXjB2cRaLF+HXkJlBTfuzmztBLb/2s2+zSGn4R+VamuPDMZXE1cLM?=
 =?us-ascii?Q?Xxh60E04uG5xojC0Jz2wdYtE6Z9c5n+dYekaOrwGee61OlNhwMfhOv7I4uYG?=
 =?us-ascii?Q?Bue6Z3+sS8S0lhM5MV1rZse1IobBjbVOSRegWIuf0a7hvJROUV+AVUv3Cxcq?=
 =?us-ascii?Q?oYuWYCStm9biLCobW13tCn5In3PQedr0pGUx5/ab8AU3kWzjTlM6jigIBZpL?=
 =?us-ascii?Q?D+QE0x/RMXYbIPMZo3dV4oEubplQLwffSPk2lSu4YOQeERdS2vAZI5McxL6F?=
 =?us-ascii?Q?YOmmiWRZrYBcRGy69iTNF6BXVPa6YLu62jLvZNpfvVm3KlOKUy+ol+YD6QRU?=
 =?us-ascii?Q?VpYvUpdFscqYX5BV1LB1Qc4DT0q3y56CiPJMnN3uMd3YLocRvDd/QSQAM1sJ?=
 =?us-ascii?Q?52PqfFsMGAFCgCRkPNr+7UbnNdf5LCrjCMXwv/4VVvA7c390EgnBpZWOxcd7?=
 =?us-ascii?Q?rYc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EI46056MK7uXyo+pTif/nbMmrTz93z5gSbxTEkgMC7GrLsNNrGrjder8C0/H?=
 =?us-ascii?Q?87Czg8d+oKFbxMAbQWm/lZKZgDLI2xwPPlCscfYW5HasneHfQseoTIvf2N2j?=
 =?us-ascii?Q?OnovyPm/AvbZTpOm+q/deqYX0Vr+GxNW1sq69HblZQaMJUX7gssHufHcE4/K?=
 =?us-ascii?Q?ztyh7W/N7XdmahySrjEjhTdAbeEsQzpMWyO3eHOSDO7JYN0c/sCleArwnVBO?=
 =?us-ascii?Q?e1Ck8Koay2542WbC2KSensxujLvDyPeMJsb4wEeEirQ4414d60jER4FKyu3i?=
 =?us-ascii?Q?td5wP+DPnz3WiGX4kUkKBKDNcEj0majuwAASJzktqqw6L9/Bm/c1aBtbYx5p?=
 =?us-ascii?Q?h4SlaVAj3OUGIGpVHsGsaF7/948Djd/ePq3vZIeuGFOZvMXZ9ZJMOZI1ukIB?=
 =?us-ascii?Q?4gf7jasg7HYDVnNDPLLa3/Dc2eqq7bfGR2c11291DnfUJzGldOmzAETelCcU?=
 =?us-ascii?Q?CvPYuSNzeJA/fnMza8TqFQ8BAn14sv/nwoAaEJAlLtdRQNKAnrMJ1L2YJVWQ?=
 =?us-ascii?Q?34uJ9ssPEeHD/hauZPAwjDGr2l3oup8A4VGZzLoGOvEGJCsSOAPj5X5g/WKI?=
 =?us-ascii?Q?ceQ6hT7KFyEDaIybCpuOdDcepcJp60AYkZU18X3yWC+b4ryq5iMyHbX1d0TH?=
 =?us-ascii?Q?OUL/NLQLxTOYxw6IyoEZjcne9rizwNdZKpNwbyd/+I0zXVtNk/yQiwOrw4eJ?=
 =?us-ascii?Q?CN0LBkHiOEP7jTPULsLaVQi1HwS3At/Ag1+N70fxkCY7F45NgPdNXglIXy/B?=
 =?us-ascii?Q?YsIfQUYxD9Ap2T4HmvWf5AvFfm40t2mXLg2AFNZwBRD2X+QhDerygFqHaVDf?=
 =?us-ascii?Q?m0YypwSydE/Qol4WgZ+SDwjLuHsbgFNs+hbJqDWlh1qMtvVreutTGO+e+i70?=
 =?us-ascii?Q?rqPZYo4UvsFvB4jSdB4r0MIrcKbwXem1L6qMfVsfNLN5d3nHwbt+ih4i1Ixh?=
 =?us-ascii?Q?5H6OiyLJ8rP6Cl3lTqYAL3PJp4tzCYM9M8NmAvcypobT52IlTkWyRrV//NKP?=
 =?us-ascii?Q?CvrPFDyyT8E03bLw1eWP1XCBbAnEu68jxPg5tIKL6O87BGqqMVenCa6g0M2n?=
 =?us-ascii?Q?buwB881aXs7kReRVzKQw8Bc9ZKvXECquXRomHSEaHC2VpI9rTK3EGxXU69pN?=
 =?us-ascii?Q?xGgUC2d+3eMsyS7xWw2tnILjlwu0rSFzmUWZaIo17kZ3wV6n/0KH+ZtJINht?=
 =?us-ascii?Q?ECKIVj8t9puPtc3aQuAKsvbrhq4gU9ax5AUY3CJuscD6YKDmrMPQ5vUrFyrp?=
 =?us-ascii?Q?uoMJLxi6h6Tm9/9NfeIZDKAxv1HbmbNnzSYXj9XZnDPNHi5zR43meS2MKhry?=
 =?us-ascii?Q?oc8DQY4qPeXzcQIQB//p9n8Cynk1euBhX19QmbyWrn3/ipQCUvN/hcBxuBWq?=
 =?us-ascii?Q?i5vmT6/FWUE4YEEdQhniDctmV1LDI63Lt4U73VlxJsmCMCRjMo9RiWgFPv6k?=
 =?us-ascii?Q?BsrnTgxoZIPquUzaDpNXA27AloTZIz11bKx5OOIz6qzE3A9nHRRxDJOZTNqF?=
 =?us-ascii?Q?6TEZLDPsMkiU+31MVYaqKPQMWlJDfl1Lt1peZpKs4xdJW30gnSf/28lJvxHv?=
 =?us-ascii?Q?1zpZ8xgxjq1HhB1tVtJhZBo8gbeMu8Slm8A2PLvc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afd4b9b-6dd9-4696-1da6-08dcddccaf14
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 01:43:56.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wks/UyY2hup3CwtngHHC22o0dW2FqzY6xJyhiW/HkVxnwbmq0QvFhCsQUa+dbYi6Ns250w0Xlnn86XsJBUXAqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8056
X-OriginatorOrg: intel.com

hi, John,

On Tue, Sep 24, 2024 at 05:40:36PM +0000, John wrote:
> On Tuesday, September 24th, 2024 at 3:00 AM, kernel test robot <oliver.sang@intel.com> wrote:
> 
> > early crash happens 70 times out of 500 runs.
> > for parent, keeps clean when we run same tests almost 1000 times.
> 
> Many thanks for this rigorous testing.  Would you mind using the current revision of this patch (attached)

with this version, we cannot reproduced the early crash issue.

like previous version (178c2862ab0388f7de1ca23b7b4), we still apply new version
upon 70ad4cfb4d4a9f97. we run tests up to 1000 times.

70ad4cfb4d4a9f97 178c2862ab0388f7de1ca23b7b4 e9725b726c3c0bd129959c308fb
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :991          7%          70:500          0%            :1000  dmesg.BUG:kernel_failed_in_early-boot_stage,last_printk:early_console_in_setup_code


> or accessible at my github linked below?
> 
> https://github.com/graysky2/kernel_compiler_patch

> From 718155e6164b4bec45bcba8814c3f82e84f36db0 Mon Sep 17 00:00:00 2001
> From: graysky <therealgraysky AT proton DOT me>
> Date: Mon, 16 Sep 2024 14:47:03 -0400
> 
> FEATURES
> This patch adds additional tunings via new x86-64 ISA levels to the
> Linux kernel.
> 
> These are selectable under:
> 	Processor type and features ---> x86-64 compiler ISA level
> 
> ??? x86-64     A value of (1) is the default
> ??? x86-64-v2  A value of (2) brings support for vector
>              instructions up to Streaming SIMD Extensions 4.2 (SSE4.2)
> 	     and Supplemental Streaming SIMD Extensions 3 (SSSE3), the
> 	     POPCNT instruction, and CMPXCHG16B.
> ??? x86-64-v3  A value of (3) adds vector instructions up to AVX2, MOVBE,
>              and additional bit-manipulation instructions.
> 
> There is also x86-64-v4 but including this makes little sense as
> the kernel does not use any of the AVX512 instructions anyway.
> 
> Users of glibc 2.33 and above can see which level is supported by running:
> 	/lib/ld-linux-x86-64.so.2 --help | grep supported
> Or
> 	/lib64/ld-linux-x86-64.so.2 --help | grep supported
> 
> BENEFITS
> Small but real speed increases are measurable using a make endpoint comparing
> a generic kernel to one built with one of the respective microarchs.
> 
> See the following experimental evidence supporting this statement:
> https://github.com/graysky2/kernel_compiler_patch?tab=readme-ov-file#benchmarks
> 
> REQUIREMENTS
> linux version 6.8-rc3+
> gcc version >=9.0 or clang version >=9.0
> 
> ACKNOWLEDGMENTS
> This patch builds on the seminal work by Jeroen.[2]
> 
> REFERENCES
> 1.  https://gitlab.com/x86-psABIs/x86-64-ABI/-/commit/77566eb03bc6a326811cb7e9
> 2.  http://www.linuxforge.net/docs/linux/linux-gcc.php
> 
> ---
>  arch/x86/Kconfig.cpu | 24 ++++++++++++++++++++++++
>  arch/x86/Makefile    | 11 +++++++++--
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index 2a7279d80460..562a273be222 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -308,6 +308,30 @@ config X86_GENERIC
>  	  This is really intended for distributors who need more
>  	  generic optimizations.
> 
> +config X86_64_VERSION
> +	int "x86-64 compiler ISA level"
> +	range 1 3
> +	depends on (CC_IS_GCC && GCC_VERSION > 110000) || (CC_IS_CLANG && CLANG_VERSION >= 120000)
> +	depends on X86_64 && GENERIC_CPU
> +	help
> +	  Specify a specific x86-64 compiler ISA level.
> +
> +	  There are three x86-64 ISA levels that work on top of
> +	  the x86-64 baseline, namely: x86-64-v2, x86-64-v3, and x86-64-v4.
> +
> +	  x86-64-v2 brings support for vector instructions up to Streaming SIMD
> +	  Extensions 4.2 (SSE4.2) and Supplemental Streaming SIMD Extensions 3
> +	  (SSSE3), the POPCNT instruction, and CMPXCHG16B.
> +
> +	  x86-64-v3 adds vector instructions up to AVX2, MOVBE, and additional
> +	  bit-manipulation instructions.
> +
> +	  x86-64-v4 is not included since the kernel does not use AVX512 instructions
> +
> +	  You can find the best version for your CPU by running one of the following:
> +	  /lib/ld-linux-x86-64.so.2 --help | grep supported
> +	  /lib64/ld-linux-x86-64.so.2 --help | grep supported
> +
>  #
>  # Define implied options from the CPU selection here
>  config X86_INTERNODE_CACHE_SHIFT
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 801fd85c3ef6..e1f88f846bed 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -178,14 +178,21 @@ else
>          cflags-$(CONFIG_MPSC)		+= -march=nocona
>          cflags-$(CONFIG_MCORE2)		+= -march=core2
>          cflags-$(CONFIG_MATOM)		+= -march=atom
> -        cflags-$(CONFIG_GENERIC_CPU)	+= -mtune=generic
> +        ifeq ($(CONFIG_X86_64_VERSION),1)
> +          cflags-$(CONFIG_GENERIC_CPU)		+= -mtune=generic
> +          rustflags-$(CONFIG_GENERIC_CPU)	+= -Ztune-cpu=generic
> +        else
> +          cflags-$(CONFIG_GENERIC_CPU)		+= -march=x86-64-v$(CONFIG_X86_64_VERSION)
> +          rustflags-$(CONFIG_GENERIC_CPU)	+= -Ctarget-cpu=x86-64-v$(CONFIG_X86_64_VERSION)
> +        endif
> +        cflags-$(CONFIG_MATOM) 	+= -march=bonnell
> +        cflags-$(CONFIG_MCORE2) 	+= -march=core2
>          KBUILD_CFLAGS += $(cflags-y)
> 
>          rustflags-$(CONFIG_MK8)		+= -Ctarget-cpu=k8
>          rustflags-$(CONFIG_MPSC)	+= -Ctarget-cpu=nocona
>          rustflags-$(CONFIG_MCORE2)	+= -Ctarget-cpu=core2
>          rustflags-$(CONFIG_MATOM)	+= -Ctarget-cpu=atom
> -        rustflags-$(CONFIG_GENERIC_CPU)	+= -Ztune-cpu=generic
>          KBUILD_RUSTFLAGS += $(rustflags-y)
> 
>          KBUILD_CFLAGS += -mno-red-zone
> --
> 2.46.1
> 


