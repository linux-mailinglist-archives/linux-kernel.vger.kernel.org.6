Return-Path: <linux-kernel+bounces-348307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CAE98E587
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4CF1F20EE9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FBF1990AA;
	Wed,  2 Oct 2024 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCcLz2TY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65022F22
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905876; cv=fail; b=n40O1Y57BCN8mFPQW5++EwpTCAC81fnyHpfLdXAV6eF5ZtuwCVPBkzaUpneVIc7n2ouoqHX/i1ftAl84YYi6LfOMYd0pIqxwzgi47fw3wgf1Bai4CNc91bao9vSDIaianHLQtlJOp0lY07SfQGL+lnpKJ3ExZKHQ5mdCUoG6nJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905876; c=relaxed/simple;
	bh=8J5RssAqDN+fp4KVBXUCj8NZYWSxYr/Dpk4XScb0moA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ii6QnDgpdu+cJ2tSYS5ukVJ1ssZsQz/NSL/+L/hyUWy1uZWz/pgrBMFpVsbjBTiyyHE0Mx30h+1AzmWANLJvnhhkOPiAmq7IQdf2oz9U3KL3++Nlq/fUz1XV5ivsXQOHwvfns/f5OMWgaNAumGpc6ZGfA0twxIO9nT6Dey+kHeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCcLz2TY; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727905875; x=1759441875;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8J5RssAqDN+fp4KVBXUCj8NZYWSxYr/Dpk4XScb0moA=;
  b=OCcLz2TYNLBGCiH544gRODtj2kJvxcVRqjNRZPbEORJKkem8PJ44n0S4
   A56nUN3vRzikOY8bTdTTRemiGfW8VZoEnhpIpf2OubbkgS4OXFCwvxQGA
   y//vh3hwjIzf4dknZNGhfIFeF8iPe38ZmBAMEHh3NIYXr+Adib1bfCO0e
   rsKD6ME/blCOyhrrDKOVsUJKfO0rhHXYeg9BXpYwPaGyRQM+B60kpCoCn
   ZRidkef5QWKBDgxSqG+zwrMsarOktlu/1xjwuuRIUAN3WNgZ5TRucLOGR
   FO7QxWGA57uISyoo2V/bB6/OS+kU6JyjpLJYHyTKBfAMh+hSlc2Pi+u91
   A==;
X-CSE-ConnectionGUID: tXAPjuIlQ4WpYIkvoE2Lnw==
X-CSE-MsgGUID: 85QpxvPfQ3KveVB7vryLOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="37676456"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="37676456"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:51:14 -0700
X-CSE-ConnectionGUID: cBeo9JqDQMqiEXxShW566g==
X-CSE-MsgGUID: GDpBAz3KTZuADFkhjRyfkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="97476610"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 14:51:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 14:51:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 14:51:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 14:51:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 14:51:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXi5KXqPfKhFQYnrpVkdaxmIL8AsU6fuJ09nD197cbbiH/w1TJMRcRc5YJo9Ky3Wby1aWq1IsbQsXYIr2P6FIQxehENkWCsMm7a0KA37xe3mIFybdZw+0YPe9RR5G2N+FlMNM14jClF6JCIsZOEoL0pnbMceg5WXf1pjQADUFXd/LKY2jz9e09eYVnvr9kK4y/GZpVlz4bprpHnOlswbNMRZGhQWKnrJq9anB3pmo4N3UXys0tB/BcWi0mvnQTojKT5XDi87jA6gG5268yoVIksx9YJItHM0BSl70vmyDlNasJiKZEqiX2PXusEz8VYXHEw6RDbtunN+NqsfRCXX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6dTLGHTI8XhQMVsDmqmEKrw9bqML8zwwvYuBwud920=;
 b=Z5BqNGZh4ZxGwmNoHB4E3nJ/Q6uaqz67esTSsKMquBCPPIMGRf6H6otCrGdEm2Fw/EvdLeN8e+xEVF3Lf1eqzL9asaJxe9WjMElS0sZ48kKTmDxgX6GLkMuhMUUXqwzfGkNQ8QxMGcPCuyrfN9Pg/jukIgZXDl/IbVIUF4RnwwsUbOdOwysfaJB5vZE4fS5Q518Z41InRQ14GafkD4Z861QV8V1p3qpccjGoQz0QXB+IE0o50kL2vMrXT7be4F5PMnnllwftt5WH/jkyyzsO181bHqHEPGNb/oMAU2so4PrA6EtfmH7xopsc9vgwRwUmL1CaBG5YE5BYocNfwiW59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6807.namprd11.prod.outlook.com (2603:10b6:806:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 21:51:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 21:51:11 +0000
Date: Wed, 2 Oct 2024 14:51:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <rafael.j.wysocki@intel.com>, <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: [PATCH] driver core: Fix userspace expectations of uevent_show()
 as a probe barrier
Message-ID: <66fdc04c8bdb0_964f229476@dwillia2-xfh.jf.intel.com.notmuch>
References: <172772671177.1003633.7355063154793624707.stgit@dwillia2-xfh.jf.intel.com>
 <2024100130-turkey-duplicate-d670@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024100130-turkey-duplicate-d670@gregkh>
X-ClientProxiedBy: MW4PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:303:8d::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d54cca-c83f-48ab-74f2-08dce32c5416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5/OhKKe5/SjxtDDHYgjPR39hSk4jvVyhUbpabQn/LJQc2ZDZpmLlvlcVn5ue?=
 =?us-ascii?Q?Pj6cgxFOTjJxZP663jhhlUTNbAZs+IGU8H28H/qIpnQI95WNc3CZuI6bu2+q?=
 =?us-ascii?Q?BUSNzFqYeG0cj+LEmeUwPcHMgVP32E0JpwuoiOS96DL5XkBz1od4zkuwF4Dm?=
 =?us-ascii?Q?9bqqt9AJ49BHROXa4bt4qP6jQ9KZ7WGNAwBdR0M9k6iBInpXySufN4IlM639?=
 =?us-ascii?Q?yryD45s8mMYWmbwaBRoZQz4pjZw8RxhFR31ShY1Z0Uk7K9DlJBoPktJbABUQ?=
 =?us-ascii?Q?ZgiLodT4/g2P704mKDwe679527AS6rgnZKcI1zG4f+T5Ip9vghMm+9tGqYrd?=
 =?us-ascii?Q?Ue9STHwRF1egESKqCGSx6mITok7DHvp4yvagjQwnmKOFVIV2xpwqmuX/Co1K?=
 =?us-ascii?Q?sIlvPcRMNTy1FPOEja2T4Xz4p/E10O9IWFHJvZCqQFLKkNo8GrjmIXY0yxe9?=
 =?us-ascii?Q?t3hHQfjx6blx/09DEZGmOm+ZcGjWfFMa8RTous9EtbvoSs+SXb13/jvMqw2E?=
 =?us-ascii?Q?4lSYP4KTW9amRK15rPX8m7YJwtSroJrYig4wObh0Q5mHLo49ouH1tgvzR5UO?=
 =?us-ascii?Q?+Kb4QY9jAsULrVWOo98vmqeI5FfBsWVLGnQM4vnUnwvbetJhj9pBkt6SqJq+?=
 =?us-ascii?Q?BwLlRigTiIKfxHRl65+qKxrJrZh7z6BvYZWNglos9aJsvPsiZyoODcssGB+J?=
 =?us-ascii?Q?CpZHKuPweNWHMdg36xV22K4QzmAIzl6mlJk+DoRmBkFkwVt0Yhjj9Pzn0ZaU?=
 =?us-ascii?Q?57rM2zchW2VB/RKQjabH4ZLqC3oX6asSv7Fet0TdmcLR/PENaeawhgNVIj9k?=
 =?us-ascii?Q?vc6RDiUeJItHccJd6wmsRU6GNblNYAwxzPYZhIebrPGc+PSzWymW9a0ngp/g?=
 =?us-ascii?Q?WJLWF35dNvYyUcEBIw/LnjkwwXrruzX9z6Zrm5K375eVjp4PGPQiYeEDv5ad?=
 =?us-ascii?Q?G54FHO8rcc0prU8T9HrtXl8LXij1uqiF6o8Nw+zpQNHKBAMtoGlGUvW88ap9?=
 =?us-ascii?Q?zIHAsJEbGEekRkS0uKr0Vpl69E9PsRNzDlBMYrH2E6EralmZCt4saOIhaJ01?=
 =?us-ascii?Q?OQgKRARcaGW2oMxMCVUvOOmyk7VTx8Sxtm3CpstnkwEsQFVzL1Oe4Rrn+mej?=
 =?us-ascii?Q?3UkHQHd1ee1RPhHAYrHYAPSVvAGx0whzhnTazONwm3vTZAUfz8hR6/ymBeAo?=
 =?us-ascii?Q?PRniUQj+xsFSx6sRxbQoIGfKkALifUMnn07ZRjF0f5tuBJ24Fgea6uIpDAJS?=
 =?us-ascii?Q?723B14lHycX0gqZgPKrM9yEHlZ3Z/NWRPnGEW3hagg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F+MmhPTVwT7/03mWAGbqNhyXQmEtr2p3Up2+r9l/DZSrTs8kFoElFlOarVQF?=
 =?us-ascii?Q?qBuB555ZByN6ZLHnUP1u6Rv34VCBgLasRIwS/CBl0b35LMS4uq/e5b+ymdz/?=
 =?us-ascii?Q?N6ydcjpakBXxqhZZtigm/CXo3Ocd8qDswtNpUigx26Pf4Bsw58PQrffTJ08P?=
 =?us-ascii?Q?h8E8lrsBoKrGCct5bsKLD8Pfmefl3cetdvKz6m0IRr9OHnTSC8yQ1G2vDk0K?=
 =?us-ascii?Q?YgOgDdQI9p5UZsYbZx8YGYjIDF/NTkvXgMtprNRyvBcOkcRGhL/YtZJBGpUX?=
 =?us-ascii?Q?PxnoOc8e8/beXkZO+2dkKqZ03RjSQNISqt5coxb782PG0TQ2A83prnLLUwKr?=
 =?us-ascii?Q?TxLLKmfejpBjh6/8KZwU1g4OISIOyND3MUMg9uTCCVasqMMO+uXv5zpPsl9z?=
 =?us-ascii?Q?SK5o3gQgcVKy79YZ7SpeNf3VVmVqH6zcngrkBgubKeJF5a1hhfyq9CReJ7WF?=
 =?us-ascii?Q?gma85DIxsfZmuv7RXcbuxw/E8oScJECVefY9hmeGTkbOi8x3BPoCb4si1+cV?=
 =?us-ascii?Q?Lj4+eoOHJwDVJ3+6SkQDZd6qilXkMGUJse60iusoBVJb5OhnucKX+oxPHvZT?=
 =?us-ascii?Q?9vgukYRyVDKGk85ooMG5EX5wKnoYsSG25UobTac9ULvKXnIgrf6LVGiqSYFT?=
 =?us-ascii?Q?rwarmLFsMgldYPhRdrkQSMGnNMxSyeO3mO4t8E10WA09JUmVqxQ3szul7441?=
 =?us-ascii?Q?HrR4XqTGePec1Cb7IqkB2OYxDeyYvdaGrDHvYmHrCAm2HH76QHrJtPHLKNr2?=
 =?us-ascii?Q?A12Zp/uB2elucpL/HlW7C8AitNrbYoB6cX7jSUO6LekkC6knay/l6UNmgMYS?=
 =?us-ascii?Q?HPWwyrkNDIDUuEytkYC2Oj9JNN6wz43fL1VyFbgzbY/Zarbrt/J3E57Dfhot?=
 =?us-ascii?Q?mskoeGJv/7Hf2TG2tl9dVODPa2cIk8dJADKUTkcjI2W9w5gHuc4Paeh/FG6d?=
 =?us-ascii?Q?9zZOokuWdWUTHnCpq8cL38UObBbqpEEEKIMZVmZV4thtiNGVvRfS7yT8YGOa?=
 =?us-ascii?Q?TIsgbZF4GsXOuDYHYv5sUduy91vsnAo0kxGTNPpFsVUEz7urLE/CI5rkl2yj?=
 =?us-ascii?Q?o4MgLuLeG1uUij5FVmoErGNePbVXK6SbMI/9on4TT/Z7yhIxMCk7AdK7vpNo?=
 =?us-ascii?Q?H21EqznX337DAeCWl2qdL5TJCgJOsxwBb9Xpyeda43rSu9zfNpdc8bKtWZpW?=
 =?us-ascii?Q?UfASUq+1NoTZur9sVUBFtWzW3k5jZjuuu+GBWVIvCmCLvDtB+p446YZrDKjV?=
 =?us-ascii?Q?wLfMwSl7rz76mj9mbmUZvH9OF3/L2/THrM8vnJbn9UM1mwRkNkTyCclra5dq?=
 =?us-ascii?Q?ipP+p39rhxGrlMIRYkGNNt6u2KDHXY3+pp1w9F9sDmbBIv4oABAb3/12DI9J?=
 =?us-ascii?Q?KoUyQio6g+hqpkb2IF1ShuGDy0L+VmROwN97KItVq1ZR9GEBqXNJry1hbCD0?=
 =?us-ascii?Q?BXK97qL91EayFm6e+7F45KwJUEzQgrIIV5AK3cqzmOy29VHqX0JFkA4eNWar?=
 =?us-ascii?Q?ermBv29XTfkwdhRL64QSexgyCLkkLVHfIza8TB8yaM7wda2nMmdfmOHHAogj?=
 =?us-ascii?Q?8bAOiFofJgEUfsswSrc0deFB0EW/2aPEkfWA0/SZX3xN5FCQW3qSW2Y7KtoG?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d54cca-c83f-48ab-74f2-08dce32c5416
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 21:51:11.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S25g3yxduME3JAKcTvLPDLHxQn2GYQ+yXGUL1rt0Cp+MwZwAmCHyACeORJNJnXjdfEWEhdmZ6N+6g+KVjYaGJwfQ26XzGZhm8oaaUzq+vJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6807
X-OriginatorOrg: intel.com

Greg KH wrote:
> On Mon, Sep 30, 2024 at 01:05:13PM -0700, Dan Williams wrote:
> > Commit "driver core: Fix uevent_show() vs driver detach race" [1]
> > attempted to fix a lockdep report in uevent_show() by making the lookup
> > of driver information for a given device lockless. It turns out that
> > userspace likely depends on the side-effect of uevent_show() flushing
> > device probing, as evidenced by the removal of the lock causing a
> > regression initializing USB devices [2].
> > 
> > Introduce a new "locked" type for sysfs attributes that arranges for the
> > attribute to be called under the device-lock, but without setting up a
> > reverse locking order dependency with the kernfs_get_active() lock.
> 
> As this is "only" for the driver core, can you move some of the stuff in
> the global .h files to the local ones so that no one else gets the wrong
> idea they can use them?

Makes sense. Moving SYSFS_LOCKED and related bits to fs/sysfs/sysfs.h
is straightforward. It did result in the below hunk inside
drivers/base/base.h, but let me know on the v2 posting if that's
irksome:

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0b53593372d7..0405e7667184 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -246,3 +246,12 @@ static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
 
 void software_node_notify(struct device *dev);
 void software_node_notify_remove(struct device *dev);
+
+/*
+ * "locked" device attributes are an internal exception for the @uevent
+ * attribute.
+ */
+#include "../../fs/sysfs/sysfs.h"
+
+#define DEVICE_ATTR_LOCKED_RW(_name) \
+       struct device_attribute dev_attr_##_name = __ATTR_LOCKED_RW(_name)

