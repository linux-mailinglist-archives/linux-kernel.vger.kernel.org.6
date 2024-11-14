Return-Path: <linux-kernel+bounces-409786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386119C918A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08C42812B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6196A1974EA;
	Thu, 14 Nov 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acynJ1mB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54118CC00
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731608307; cv=fail; b=jrsf3h11m4jOQPXmL9JFilDUForjXaPiYpAAeQbEVmn80K6I24er0zWpjAJV4pJFP/+F/aK6bjPdraIC51YgU/8+NeigqlDufIMff7AyaL+lBEKyHdyzGYbsWRMXjX82L37TCM4PKgf7vJ8cQ7c4MVWngZrnKr37IoNBuwk1efU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731608307; c=relaxed/simple;
	bh=HY90aGEKh7Pz3zg4PmpZVQPf4jD8Fgx0ocjlOy5ZJug=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qxToUSHIYollcfrnYjD+YAkk8UJquV/WMwW5++CCd1JJdkT8nvl0z6gjaOcbWTQUMxLxBX8C+raFp74rnWVnl61wyH3AjqO3U34Ph9fFD3gi+MTdwIrxke1f05rZ/zsuy3vCgwBGPaLsMG+FTLmDMlDZWzV8XDcWo71qEsgtgAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acynJ1mB; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731608306; x=1763144306;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HY90aGEKh7Pz3zg4PmpZVQPf4jD8Fgx0ocjlOy5ZJug=;
  b=acynJ1mBPTkaAZrAdCc2iSQ0Hev5YvQzhuGHMDWO+JrlGK8kQhb2w8Uj
   46EObmH+LGtm1EI/d7BON7HqbRgre1N21NzRNdmLWOhQzIxLXOeZ2RvYG
   /o9EfkDre78X7Eo5Wzidz26Qw9h1eZB1xp+fmtvx5XLKRFelBNvUAMzza
   lSNTKFCMui6hm4cMxtNnBgE7Un9J1RFavrR3yQCNIjWr9B3+F6db/uFzR
   5Ger7q9UNfiZ87eb2U4BXEKLpv5utfeGn3rDBs3xuBdc7G1uTuTTVf68e
   7FUeypKfjdKs2bdoTlCFBWysLL9gBqLxVVP4OrFry3iTiiME1xmtA9Xl8
   g==;
X-CSE-ConnectionGUID: mKLt1Mv8RuyX+GuHSekBng==
X-CSE-MsgGUID: V5t3dqlCQfCdeF9r5fvI1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="19184326"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="19184326"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 10:17:59 -0800
X-CSE-ConnectionGUID: uvrk1Aa3TZGvivKt5eip8A==
X-CSE-MsgGUID: qhKedNAIQnmmJkRJ0RbjXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="119227895"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2024 10:17:58 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Nov 2024 10:17:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 14 Nov 2024 10:17:57 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 10:17:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4FGsdAi0hkmEQDkgYyFW0X3Gau/Ye8wtME/Kji64Hv4QdqG14UcrHIIoa6YXewV95r7JDjJBuuaF/Rh8hsKvVVKBWoC4t1BK7XgHAbHllrkKo+aIACl1O5W4ziq5zQ8xQJ8Dc/Ni4myZHKDsxCABTA68/eNmKgvftTnnPoixFvZFH5tbQo57vD5Mzf54fT2VQBXSVhp9/yJY22JHxJTcxPymA4asWIKXGfdGgcjOFnl2pjLFu91KEEpPRBFkcVoC1fizjKjWIc8i7+VpfjVAZQ/PmsfMkGK7yEzItwv1wnH0j1roTGXp/KPuGhKUuX13fA9LibbcemXjorZWsC4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HY90aGEKh7Pz3zg4PmpZVQPf4jD8Fgx0ocjlOy5ZJug=;
 b=o0KZyZhFNqrR1V/wpMxKs+fdwT5O/Td3AOyFm4tqk6LEWHjAb3Xiu3/OqK9Ih+02Uv+jNdInVej5th1Zf5Cp0NR7RY4U2anFGJ5e2mogfjsyYSENL4jSBhqktbA5K5/GYM9XgXlRtyfdTAkGe86S0IOdac9A37r1YvVRh5gruc0SglUiu8BOJ+wYTsGd6PVJy3W2uG6cz+2UUDABpAkMq1/9bdtqoQc1U8dn3nuhKjyp3PMlb/4w3V72W3RHjzkzmQsaLWtBIL/3yFoc/MNFF4vmv+RQkYI4znu3SHVbSbh1WVHqKu+NlxDgQ0YU2sikPUALoxX9QXswjLdbs0GX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7342.namprd11.prod.outlook.com (2603:10b6:208:425::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Thu, 14 Nov
 2024 18:17:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 18:17:55 +0000
Date: Thu, 14 Nov 2024 10:17:51 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Russ Weight <russ.weight@linux.dev>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dionna Glaze <dionnaglaze@google.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Danilo Krummrich
	<dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>,
	<linux-coco@lists.linux.dev>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Ashish Kalra <ashish.kalra@amd.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Michael Roth <michael.roth@amd.com>, Alexey
 Kardashevskiy <aik@amd.com>, "Russ Weight" <russell.h.weight@intel.com>
Subject: Re: [PATCH v6 3/8] firmware_loader: Move module refcounts to allow
 unloading
Message-ID: <67363ecf8a693_214c294dd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241112232253.3379178-1-dionnaglaze@google.com>
 <20241112232253.3379178-4-dionnaglaze@google.com>
 <6734119c1c9a7_10bb729471@dwillia2-xfh.jf.intel.com.notmuch>
 <20241114163546.ermxem4bgjzeaxzc@4VRSMR2-DT.corp.robot.car>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241114163546.ermxem4bgjzeaxzc@4VRSMR2-DT.corp.robot.car>
X-ClientProxiedBy: MW4PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:303:8c::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 799b488d-acc7-4678-5c56-08dd04d8a8db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/toI5gXVauPoRWg62dY5LtQi3sSjQ95AqLRYsO+tJPnHm1RQWz6nv1EIz9fn?=
 =?us-ascii?Q?L0CYTRUUcNNEKzw5a/i3SV5NPx1V1rfOYo5s/liy3gkKJ4slmpfHZznn0n+Y?=
 =?us-ascii?Q?HRx/gnMnQ//cNC4tNdyiCHeTGkMwSw/Z9rKrr7DUKGvFIaw3HEo69Kr6PnKz?=
 =?us-ascii?Q?XzQ/m8RRh5K11s3gNgt80Kn6GoE3PZEpdLmkvwuIdRDpmcQsgpdTY4/2O5qp?=
 =?us-ascii?Q?wsQicgLfgFia5c51pfII2a2AwpS6HI5fdoj6tZjJYNkJ+n/pJtlsnL8tKeiS?=
 =?us-ascii?Q?JvoVUYZUEQOBdDBTlyIryGKq79HQaLd+42jeR9P2My1m6xeq9Cpsw8CP3Vy5?=
 =?us-ascii?Q?Hh3IExmB7DAl9SgK8+VG6dTaGgdFdvjPnpbT+ECl8aTlTmz5u/Q99Yg6Wq95?=
 =?us-ascii?Q?SAbSKY7SYW77hEFqLh1sMnQoCwqRUZ89PJ+BfSZiNJ0fBbXk24ndasSsSY++?=
 =?us-ascii?Q?Ywk8Br3OfD8YkqfR1ZAvddBQ/f5wT9pAByuNjtmR3lKrseqFLQQGUNgwsSog?=
 =?us-ascii?Q?YmNXQmSQeWa/Ap95O1CJDwaARvaAlBE5Qyc2diu7LsvkTweTIyMvJY4GTG1o?=
 =?us-ascii?Q?nHeriP1t8Id3xGlDSBiBOtaoIte6l+cfPjKs5r8VvrYD5hEkllKB/FZNoQx8?=
 =?us-ascii?Q?jusn6Xar066g3hTJjsvdcdSHVbGyJhWu/mJYlnzMbgqgcOyveHHqxOPGo/RG?=
 =?us-ascii?Q?dWQs4Xg/PblEObr72OFSwZSRl9kM0SQz+mBIHL77HrcrzLhN8087gd5EPro+?=
 =?us-ascii?Q?WVJ9JjuN8sAShvSe9HTlbWMsn3ogtYEG6kxEA4SLcZFlSuqcygLSD3JeS2lf?=
 =?us-ascii?Q?GlAlb9ESaiEz2S/GB89oxCRDtn7LQnV/a7hGsUIwN9uH7liiRRIxGOfeJvj3?=
 =?us-ascii?Q?7XL8iwhRfMwGOyyp+5CH0ObLWoOI86gljXj4SauEPho2728xdpzLTTZHBKB2?=
 =?us-ascii?Q?WnW14vQ5Tj3tdtJd9NM9LHJjCWfj6Uvo16fefSEU3Wed709k76E6KbaNgfQS?=
 =?us-ascii?Q?ag5TDMMZBX6/c+kmoAfxvqy8qOSFtqz+ep/ZV86LQlyzh/GvfsDWgsJhglLR?=
 =?us-ascii?Q?IC6OR5k8O6eJakKp7HNn8m5Ri8mbc/FrBvTknsntJ4HggH/MvwKQ08YDHXje?=
 =?us-ascii?Q?b57cTeIfGJcIsAolBt/Ob2thT5xZ7sh2jPLvlAr2ZpgWbPM1xfVvRAlBYtkJ?=
 =?us-ascii?Q?NRntMcmJXYtvFAiJRmdmWr03LbSS0YTHr2uEhoHEV+a5wnbLB+5rbIOAsAwx?=
 =?us-ascii?Q?wgpX5xlmCmXfY8tiqAjXYi0DJ2k8QiyxfoudeuPwXigw54K9To5xaxa8Z65n?=
 =?us-ascii?Q?uKVsKHXGQXkOXZ5YVBDfDgyt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?om9uVu3iRD1+ymFmqaWvxHwk4DKdr5g4S2urTZUeeT12MhSiaD9chpztSxCV?=
 =?us-ascii?Q?bmZR+ZWgCLdECXUaQ0Mc0Wt6jE88VJDCdHZ4TUHqehGEGWbk4Z6H7tGju6aX?=
 =?us-ascii?Q?4p2qZEl88ZngbScxUUvoCygSHYJrPvEXbQgAjMn3rEw88Y9NiMdeXol9mhHt?=
 =?us-ascii?Q?WOgbdFACDWn2K+BWDgBqiaex9HWXRPLfcKbuhuOyA1106dqZSpEYLGde51mt?=
 =?us-ascii?Q?jCzeJwel1HZFPrZY4qyThXEschuJHeiSr/a2FrzMomaGxDZXHXmdez88t+BN?=
 =?us-ascii?Q?n6kbV94ysnUT/zNSZY8XAj3ZFtM+fBIVyIKPKAPLARRGPZxMewlvM4z4wwFj?=
 =?us-ascii?Q?bamx9nsXcatYlHicsQHdsbl1UWMC0LNE4MyU7bqYt7JT4UdMvoeOqRNx5zRb?=
 =?us-ascii?Q?IKOwz9e3Ez61xaMHo3GUzCFn7cohywlET/jbBj6qOUDlXt/Hzx4rLTUt615z?=
 =?us-ascii?Q?oEyKjQrzDriUV9GwQg58bMAjNSiy7BVayG0VXKt+tWB2knisra34AmYwEDCr?=
 =?us-ascii?Q?PfmxTj9Lf1BI7/nzfbpFBVUc2IQt5LkFepGUrm+ScOeFBWDqSauRnZYSbp4M?=
 =?us-ascii?Q?MJlb2VfR8YnT7DO+dcgi2cqHYoy8Jkf71D63lrUsmMIfl7gE6sB77YJgV/C8?=
 =?us-ascii?Q?d4SM44XTU97iAYXOCoXXjLH+kB6wyAT+HHpukq/oGhBEEGghNf/hhyzThzqd?=
 =?us-ascii?Q?KA9bK5LxkpN3zgKkZEjskZ173f+3s7i4YCG8UHVyvEzEoJRByB0wAvtM3KYk?=
 =?us-ascii?Q?XnLtos0+WPKQx2RTQ1cbnTe9ESiu5Qv3PJvHj5oTW8N2jGlI/IhDPW9fMtQ9?=
 =?us-ascii?Q?GsHoMWwi+qQGZNkyArSC7JbWDszqYyi/tmbkCX8t1pbqfXrWmUFu2bN5f6UO?=
 =?us-ascii?Q?X5GzgAFu4QpHHWt4lOlD8mqYHfRCp5sXO0rrZwK/yXIAiLxPGpjHq+FoWygT?=
 =?us-ascii?Q?ytwCwVvlwh/TrhpzenLNSo+/Tak+Rr8rW4bmfzr9OJSgNZtFabxLmOKSNXu9?=
 =?us-ascii?Q?xUwd855uJWI72YJLBl52Be4mfv+fgcKZIIe8q1xwf9OfEpt4QRa0YK1Y8z7C?=
 =?us-ascii?Q?pIcLmjIlomk9sowu9uWy530D7neTFGVcHOumQYtWZHhYphusf1WUF6sNYeJ2?=
 =?us-ascii?Q?FH0aJk+fjcpFDXtSfSWjJeHd6fnwVn1CkhYiqAUL7ut6oFOebK9Lh2XwpLtu?=
 =?us-ascii?Q?bzAxcnd1pWu4zirI4Mwq+s6lntHOh2WWvcJo9SlwUfnzmyzq2BQKipWslJgq?=
 =?us-ascii?Q?cJNyGySR9juGWSykJHljAJZlXgzxbTrrRLxsdSeCTXeId4Y7roWL8rePUGH3?=
 =?us-ascii?Q?qmSi+3sjkIumlLd+VuriuGmIoRJ6YdvHT+TKxWMXPSmMEjptmom/ImCxcNDL?=
 =?us-ascii?Q?0+LSl7ix45G3XxManRW6y0DWpeQTMXMkrkccqTdaNARHoDhEmBxrMh41urUb?=
 =?us-ascii?Q?TvdY6fSsZXWURAxi1NcsJ9U0RTYwShbCSjNq27oWLOPyLGLeLfAfv+ZRvegM?=
 =?us-ascii?Q?K/r+0g996fkyj0pDSp76R3CxJhxkLbqMEwxVclmZo8XCPhtsBx4z/hMdx7Oq?=
 =?us-ascii?Q?04qfVwAb0NHdfyDsAqI81v/tU1yd0WquBrkkDs/JHmRTN7MqlCHXyntQWBCQ?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 799b488d-acc7-4678-5c56-08dd04d8a8db
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:17:54.9958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32LMh4s/riOVKeiC7ARlY9QQcGhtWPerfollZFi8kXdfl3jePuNeSUdnB+enntGAralNj0o4hRZgcoVGCKwq/+sp55Ze7rG1c/e5PtiSYVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7342
X-OriginatorOrg: intel.com

Russ Weight wrote:
[..]
> Clearly this would be an unexpected/unusual case. Someone with root
> access would have to remove the device driver. I'm not sure how much
> effort should be expended in preventing it - but this is the reasoning
> behind the incrementing/decrementing of the module reference counts.

The module reference needs to be held only if the producer of those
symbols can be removed without triggering some coordinated removal with
action consumer. A driver that fails to call
firmware_upload_unregister() in its module removal path is simply a driver
with a memory-leak and use-after-free bug, not something the firmware
upload core needs to worry about.

So, the prevention mechanism is "thou shalt use
firmware_upload_unregister() correctly", and when that is in place
explicit module references are not only redundant, but trying to
implement them causes circular dependency loops.

