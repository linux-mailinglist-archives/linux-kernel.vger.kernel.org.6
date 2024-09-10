Return-Path: <linux-kernel+bounces-322308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2868A972712
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C96B23635
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00865143880;
	Tue, 10 Sep 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foO7si0Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A7E1EB5B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725934827; cv=fail; b=M8deUaHMIOlChLcQWliVQJsoxA8lUnYpN9xJNGXFVkmLKJZLcXiuURP6VqiUlTRITh9jEwxHhMZCrCnGBUkg+U+LsgSp8BgKL+PtPST3/etYWub9G/CZGHtny9Hg2sVq5DG7rQ+iPkl5BZhr+P3HEYNWWK13bJtxTJW0xC3IJ70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725934827; c=relaxed/simple;
	bh=2Cy1vNhsa0BHfM9+XGPpJxtfedhOcvwYH8tIFIOErF4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b2/NBtT0f+ZUvk2mNWiYhMFBb3neuJsaQAGhXb6253tK5lPy4Gg5AD3ZkgCgRqNqb6MZUvdA6IckMRXD6tQ2Ch/mThgycKvwybUCvIq175Zsp4eappOIvmkGBTlgvys/hj2QzKRq6gT0mQusApgJaRO+3yNJ93BNyZ/afZIcstY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foO7si0Y; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725934826; x=1757470826;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2Cy1vNhsa0BHfM9+XGPpJxtfedhOcvwYH8tIFIOErF4=;
  b=foO7si0YSXxkHlinhfhhkd2KWF0qWxKAMy16Jx9eixiMRJ8oKt8+lZB/
   HdpIzDemez957cA+q/P225yzSIaJzXsAId+GoPsFofLOTP//V3cZpQH+0
   hGGF3I5HYPpDLZwSxm7W9R3wVf29ae1WisnKyjcqxGdgE9+3DWbbIj0od
   Ki8Jdy4DnjIs/HsEaROvUef79Kzlb+Xq16IPrHLrf+HbBLGDjrMdEkZWj
   WuyEWfw+sFJHlhpb1qha8FIC53FosIdIEQWgmp3c1tG7me3YFKPjeZiBl
   WP+2l1ZbDq0t339+SoPvHaSA7qkzCLv/+5pK9AD9q8CEIWVSWfj4gmOE6
   A==;
X-CSE-ConnectionGUID: smV6PgTTRhSa6aK041FSHQ==
X-CSE-MsgGUID: tfP7W3vDShK5l7HSrEhGMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35327233"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="35327233"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 19:20:24 -0700
X-CSE-ConnectionGUID: 6l/uB7ICQu2ciNKAZsoaFA==
X-CSE-MsgGUID: spaOKUCdTy+eIja84VGD/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="71837569"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 19:20:24 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 19:20:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 19:20:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 19:20:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4acKEh0+asrtOf5iINE1Vl5XnnhobfyZ14Yn8M+aQQPGBntoQNSU6+O7pbh/7L8X3UyhEAsBfYWEgNRf7lNRiLjg8RUnq3Qcfg9Sw1VnCgR1RTOLjPQjH38W6cHq7guL5tM4B2NdFYYwjQQp6g7HvuP/Stt2RSIcpt6/J9GGwdZSdj4qh0xy6yKA4Acgwmb1EdsMk1+e9l+0yOCS51j0Z1D+VNko/l4FlkvBgWeOEC6vdjUlnw/PeduXfelkbI6M9WKyJ7/cTwyefK779Py2v6Zqvwpwr5d7QhI22DshZ8kFXDhCOI2otemknE3kqj9lqvhOotpTveMi3O2uhyKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybNxLYB6lun2oidHqYglPQBpDDUEjVegsqL9Ua9iXeI=;
 b=n8DJor2I/dDA3t9O4xAROFfA8lnzApMLzZAv3fXIqkvK+ysDPWXdSFP3v+aTM97jV1OU1eTIZMBnFwKv6Jdm3sFCwYjsu1+JGU/s0ez3YpIw0uXF9uWhpiW4q+WD6d3dToi+FWRdiNpul9O9WMzY4kx0pGpE+tw6Z3pE2Mp6EIju7ljc98l0K7wWpP9JKf8GZ7c01dwzwS1R8dyvvx1p7mW5/UaXN4MvBcS4jxRIoByCit1qvb1aCV7+AzGs2Q/C9ovnk1rLaqU1I7rSzPil4+E7NhTQls4UGn3TLUyU70TVBHxZ+xT9zFIxKqjdVSyx5lYPG2GH9V593JIVm+TZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Tue, 10 Sep
 2024 02:20:21 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%5]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 02:20:21 +0000
Date: Tue, 10 Sep 2024 10:20:08 +0800
From: Feng Tang <feng.tang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
	<cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes
	<rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin
	<roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Andrey
 Konovalov" <andreyknvl@gmail.com>, Marco Elver <elver@google.com>, Shuah Khan
	<skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, "Danilo
 Krummrich" <dakr@kernel.org>, <linux-mm@kvack.org>,
	<kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] mm/slub: Improve data handling of krealloc() when
 orig_size is enabled
Message-ID: <Zt+s2J87hZ7CZjl9@feng-clx.sh.intel.com>
References: <20240909012958.913438-1-feng.tang@intel.com>
 <edd4e139-363b-4a8a-a4bb-b5625acac33f@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <edd4e139-363b-4a8a-a4bb-b5625acac33f@suse.cz>
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DS0PR11MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5d8396-c7dd-4497-b7f0-08dcd13f1ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uMzPxlrvrRYKSOs+YrFPNX6kn3JFtcHRuR1lY4/d32MUKhjJhbdGJ1S3YBG1?=
 =?us-ascii?Q?RWiEcYJom6airg/4hqn34X8yOEw1c2jxkRCzUTBLWx5dLF4J22AuQlCl4AX+?=
 =?us-ascii?Q?3PTMDQ9FcyRbBbF7b2H2AoOONnkpSZhkJal05CxOM2/kyCRSLaoDXkMY3NND?=
 =?us-ascii?Q?bZ/Ri3yG71Glw7K/LGGLdVVxsYTFYiRlGLu6HUnInufsRTSmNOCkIP1ZpUzR?=
 =?us-ascii?Q?CHvyyYO1pBHSjyBbsqovgYnyPZ3lp14k/PwOYK0wObjkJdyeG2zNl0NGv3t6?=
 =?us-ascii?Q?mHg2qMw1kimiYv+/SsKgTCAygVjcokQqelHX2UzABz+zjJhp9Lc54drN+khx?=
 =?us-ascii?Q?nQifsO28Jl6vIob9+F/HDsRcAYDolInreSZj8eElJKfJ8x+rHg0/LhiOUQ0l?=
 =?us-ascii?Q?x67aJqT+jXACgLuInw9FDohze9vnna23cHUTIA9u4RtAXvQVieqdPk6VK3BD?=
 =?us-ascii?Q?sW4hEfU+pUOpA2fWSHPiEyBP3FsXg4BnbQ4eaivdz2uF5FdzTLI96i2tNmBI?=
 =?us-ascii?Q?HUVJzqgqpMvNyGDO+2HIIuYKluGB1pwCYtpxjLeSQRThYGl1QCt5LGwmH7j+?=
 =?us-ascii?Q?Vzo366LZGH2Pt5W6f5DMIgr26NrXiPJHBFeyusm1vRtamZqrhqGq1vzhPeC4?=
 =?us-ascii?Q?0yXFoYyACNonmbibNlFS6vKZ+2V8KtcqlmyIsFvQOLbNp6DaS0R2+yKVWBre?=
 =?us-ascii?Q?vk/CwFNvrahPM/P2W19I+8XZ6ra/AhgVWaCOywIMXXlaX2oeyTOHI+xBoyy2?=
 =?us-ascii?Q?3/y+IacxoHNBPCAuJw2ta4JgXKTS+z32TUVBfON17lGP6FRrKp/0SeFEDZVZ?=
 =?us-ascii?Q?C6oAVoNLj+T3jHT5TwmZNvi5ygWEH+mJ8PsqT7Z0Q154AY0/jMKPOiO51tjw?=
 =?us-ascii?Q?0C536fXPNGtejQmFFbTECdXAVtZr0pGyZEpIiviREHPoukqcWc6HULTZJH0p?=
 =?us-ascii?Q?xLXm8IIJZgaIZOqtVxAtMymxJYyg+0LiaCRf7hjcDSNDlzrFkgj9DrST+wRu?=
 =?us-ascii?Q?RIeAbLfx1xWLF0j8bglDj1CGEsA8b1WlHsy9Ryrzm4BYq3XjFv0spzw3Ebkl?=
 =?us-ascii?Q?K7TmRjBsGv8nvR+6iq01hiLWjscPxyOkgWxwru7g6DO3aXv3pNpdXfkpXq8u?=
 =?us-ascii?Q?yEHqvbPKmnlHT4aoSidWgBP29RgRmIGkKJrxgEbwRHC42eQECC2MBiKa7YIR?=
 =?us-ascii?Q?rcpgtQihZsjqc9sSOx4YLoopYYeFwVRXZIjgQniIRTuZqb6iJeAI2Gz2n39/?=
 =?us-ascii?Q?ljt7Y0JPnGQiPNl3PbBZpXmM8Rr2sX5++sBbdqSYTayVHdzFvpxktepFXNQc?=
 =?us-ascii?Q?F9B0exMgcTdtxHfQ8AuKFBUTyUZeCq7hLea4ueN7FmNG0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zWG+ErP+WGjFpXNGtb9z7WEwB7sKeDUoaqXkqSkya/MVqwWQycF9E24yIphf?=
 =?us-ascii?Q?vBqq7CEaw2imylx/zAu0VGLfBujXiJCAhjBp3i+mNhcPZ9IyBW0iW/sUDX4N?=
 =?us-ascii?Q?JKPmtvIWwva6dLJ17PC5Ezdbq5YhdtwTliOhQ2QLVuG3Vc1+baxeextw3gPB?=
 =?us-ascii?Q?Ubi01UYAKDraikyGxepegrfKxGEFAf7OK8iQw6zE/ZqOKvVrx2hR5q7TWNfi?=
 =?us-ascii?Q?2TVB1mFJ+fQVFriZqWrxKd+0mMgoHyKbKiaoPY9U08hTJUmXuPbEBC5YItGr?=
 =?us-ascii?Q?lR792GOTljkhIiMyB2dCC/TEOdy6u/cy10udeyNr3DPJNY2ITEjAqAH2mko/?=
 =?us-ascii?Q?DAMPZUZhPFRDyx9dCadTgWyAkt6ZR/l2RY9rQnH1rbqC29R88fOr8SU/Dutl?=
 =?us-ascii?Q?WT8a58eFyKkXKeg10pjqjZLssOXkRpySOeAlgZqmYIVLsDzXZT3qe8rJXon5?=
 =?us-ascii?Q?dsePEOfMX8B9cnwmKDoU07VzK5WOxaoi4I87XlokK2hHvDEmjNInChfLz/9N?=
 =?us-ascii?Q?iSix0gHbdXWt0mMYEYijrueWq5i5b7KU1R1x305bDZkJufnDMNwNrtKfEEur?=
 =?us-ascii?Q?HpgdDiC2wV3EjfaxgPjYZa+HgibjSOiH/LPeuauhTWtsp2DRTOoMp+O/EhGy?=
 =?us-ascii?Q?dMNX2HA2sUCG3eeQK6EK8qVWxmkmcii7FmZx9NMZld4cj4h4e4w09sKL8TB2?=
 =?us-ascii?Q?WQ9tdRCA2eMRDw+N3+S/cNYVgZbtpF0QO77edoTwkls1FwGXMz++AUu1v+/2?=
 =?us-ascii?Q?579eq2jfDin/4U+UPsoI3L+b4BE+kDvI96b7b0+rvIuwSE7g42ZIiRMqv+/R?=
 =?us-ascii?Q?qhLWM425jgjfDcSQBBiTiU4rZ0hXVhZ6f1gzOeUeu2g+kL3DOfaM0ozPPRYU?=
 =?us-ascii?Q?R+RC7iZ887MI6IEfbJ1YXXvrrAoYGLlJJD9I50XOEvfyyt3tUlkdqLf/0SSk?=
 =?us-ascii?Q?rQrizDd7wvxJ618XKmlQTnQ5R3TJcGQf2vUFPhWoH8uXsfILjds+FnXPsMH7?=
 =?us-ascii?Q?M7Sa8yw8jZG+rLi+dLYGGFD81EtlLoH2bp8ZqfCTrupCnZKlChZNMIRHeX3+?=
 =?us-ascii?Q?28p8mL9AO8bduysZ73IzeeeBFlVAkuCoe4WJczzTjgvK1SZxrcYvgKUcRCvL?=
 =?us-ascii?Q?9n8x/mFNl5fyQ1kt7+3Bxii63/yoL15EoAHE1CtwiQRshnPyPFOqiPTx8zIT?=
 =?us-ascii?Q?V+mLY47cIqQxWS7REN52foEQoZ+XXuh1x0dHXjnYGd27j+ZI35SRcC5focro?=
 =?us-ascii?Q?Tkzw4/rcHrofj8k9fqNxMbDt5WIJCzQEB0T9bufLHiPnLSZ6h3hm5lV6keUM?=
 =?us-ascii?Q?4QiXMf+6+LMOPS+8Tj4yCQS2oGAM8PxW087FcM29RZykw4+Sa26jKgQiQ9ei?=
 =?us-ascii?Q?IzPLzMkpfdBxLwrXoM9IHYr+5HvSU/1mD68/scapvf6ensR/8ywkCvOhqK2h?=
 =?us-ascii?Q?LhXknHyw1GRAtDqKyB1rmCImir4AJp2ac4wMT/ZKCSt8hbD90cM5bgqsQa6Q?=
 =?us-ascii?Q?qciYE5S6Z1qfF2bJoOGJBAt9zTNo+2ole20Nv3VBFLcLr5lPt50sIgONG1DZ?=
 =?us-ascii?Q?qEfvbKN7XbDphfXkrDXcl3LQeYZRDHW1rznXDVON?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5d8396-c7dd-4497-b7f0-08dcd13f1ec5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 02:20:21.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrkGVWnRBLwR9qW8I0kPLZ4BPszaQdujEq4jlj33kBNVwSX7lAwh+CkHrPthA8p65kgx+IrPdyfuS5CydoS2Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com

On Mon, Sep 09, 2024 at 07:12:31PM +0200, Vlastimil Babka wrote:
> On 9/9/24 03:29, Feng Tang wrote:
> > Danilo Krummrich's patch [1] raised one problem about krealloc() that
> > its caller doesn't know what's the actual request size, say the object
> > is 64 bytes kmalloc one, but the original caller may only requested 48
> > bytes. And when krealloc() shrinks or grows in the same object, or
> > allocate a new bigger object, it lacks this 'original size' information
> > to do accurate data preserving or zeroing (when __GFP_ZERO is set).
> > 
> > And when some slub debug option is enabled, kmalloc caches do have this
> > 'orig_size' feature. As suggested by Vlastimil, utilize it to do more
> > accurate data handling, as well as enforce the kmalloc-redzone sanity check.
> > 
> > To make the 'orig_size' accurate, we adjust some kasan/slub meta data
> > handling. Also add a slub kunit test case for krealloc().
> > 
> > This patchset has dependency over patches in both -mm tree and -slab
> > trees, so it is written based on linux-next tree '20240905' version.
> 
> Thanks, given the timing with merge window opening soon, I would take this
> into the slab tree after the merge window, when the current -next becomes
> 6.12-rc1.
 
Sounds good to me. Thanks for the review!

- Feng

> > 
> > [1]. https://lore.kernel.org/lkml/20240812223707.32049-1-dakr@kernel.org/
> > 
> > Thanks,
> > Feng
> > 
> > Feng Tang (5):
> >   mm/kasan: Don't store metadata inside kmalloc object when
> >     slub_debug_orig_size is on
> >   mm/slub: Consider kfence case for get_orig_size()
> >   mm/slub: Improve redzone check and zeroing for krealloc()
> >   kunit: kfence: Make KFENCE_TEST_REQUIRES macro available for all kunit
> >     case
> >   mm/slub, kunit: Add testcase for krealloc redzone and zeroing
> > 
> >  include/kunit/test.h    |   6 ++
> >  lib/slub_kunit.c        |  46 +++++++++++++++
> >  mm/kasan/generic.c      |   5 +-
> >  mm/kfence/kfence_test.c |   9 +--
> >  mm/slab.h               |   6 ++
> >  mm/slab_common.c        |  84 ---------------------------
> >  mm/slub.c               | 125 ++++++++++++++++++++++++++++++++++------
> >  7 files changed, 171 insertions(+), 110 deletions(-)
> > 
> 

