Return-Path: <linux-kernel+bounces-340972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92649879AE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85032836C6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B0417799F;
	Thu, 26 Sep 2024 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmUiPB8A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ACF16A959
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727379586; cv=fail; b=rNhDGnbCwwyhkZbClae8LUBuwMQv3VxlZFuQrp9FKwiiWoK0S/ILpiPK8w4H/C5bbEGyGi5s289YZkSh1Mo/8RYaYSN++kkYtnmz/pJVT8edqkirUxGm+JDDMEJcau5iSwR4MqSoYvmF5ozLhtk5zMrH5SsaqKewvx7FHyo2tZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727379586; c=relaxed/simple;
	bh=kQRsqeVVZliCyzmKYQFPSlDVjigM3upNFnGJA/reVWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NI6yPeKW8bY1yWr6rBgdynQP0VR6G1YfNXXQfbouAos2wyaBICwPnncp/A1da2+tGdA2uVeiXbp34KtiBNrntBWJiYXfdj5PtUg6DWHf4gIG5EkgEla70ItaOYz3/JyikTe8MbA4P8rJ/uLZnLKmt1RqkZ6cIy/fZml3MvB7mDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmUiPB8A; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727379585; x=1758915585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kQRsqeVVZliCyzmKYQFPSlDVjigM3upNFnGJA/reVWc=;
  b=ZmUiPB8AXk6TW4nqroYo/wGMFOk+ounduqzEHBbQ5wlFHzPaqUbURDbZ
   foscj/HV+E5aJGYvQKmTsFeP1k7X5yfe8UohbxkSKskfw0GZvsjKgKe84
   JFAGuwLt1/g3fIcrDdyXRo5Iwv24jPjxYVgo5+glXcaI7/M18xv8NSwAX
   h2zK05OEUMv4DHlbhu54iYvVDT/e1EeVzAsCa3GfHds0mc7P5CVZLfbwF
   GtIdmSSUPTd+jaoB+uzBzymeVFBvssYv41WbV+074tqZR0XEVqoa+oeFJ
   dQ3+J/xjMrn0EQBOA7QLM4s9EH+UCYVMV+OvTD5vi0q1fwKks/67qCyXm
   Q==;
X-CSE-ConnectionGUID: sj80vNydQE6bnPrfQXMJ2g==
X-CSE-MsgGUID: N3hSHtVVTpKbtAx6zk6rgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="25976508"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="25976508"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 12:39:43 -0700
X-CSE-ConnectionGUID: pGeYNy2hSdeZ8HcI91WFlg==
X-CSE-MsgGUID: uBXbs6GAQ6SapKSmiGcxMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="103087639"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 12:39:43 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 12:39:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 12:39:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 12:39:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpGubv78HyGbdv9dxTEsA2HVeKoSyVsQoLX8RlwWhHGZ8LEULXBXFd3AArBY1NQf1SfgTbml1mcUUr8hhGS7XeYkZ5CkgWSKDQrTe3ijsgfy5QF/HMBPi0B3+2GFcSiSxqj7VNnZ06LMFuzqDyQ96dp2fShgHhpW6ZrrAqK9DpWfiOb1cibF9M/bVaQK0G8Twh7/C8SOnfFA6duFq2mSYyofjy7KbeHO6KOO6SpQE9PNRf3Ltw4r70Uaws7+olnTdH6l5ZWteOgp215Yk6vK4pNBdd3rUAFfd3OHSAB9AOO0Pc3/xihe4J17aceEaPI+w3me9ALzGrIdZZu7ruatuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NDMxEy6EaiSk36y6dzbS64FpQw+v+Aeg1uk+L49Mk0=;
 b=tQLGlGx8nNB7u8a9jHynMPXKHJgsnFYe3Trhm1BniVjLv3jf69EfPrSaMLPFjQK7OdevOU4IeMaAz3POgk7fx76/hR35F+YM3x+R2H7l49xQnoLNGe1t3T+tZIxsOdfeVKskANQ1kdveY+Q3AVTSdJnBrB+vwQ66RjOvpr01oe91Vb1ySzg0mwdRjg3J9YqFsphwnw8n6pB3VdktIk3L3yASKQDbTuOK758lD3YksGfjWzbEwaXgE/JmC/y7OPp4bRYcwHnTWj8lgki3xfJYirJWa2bHfCEh5EM0+BMShM7rQpx+fP5jZuX6687YBTynaxWWnzOTN4jX2P7QIIWMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DS7PR11MB6245.namprd11.prod.outlook.com (2603:10b6:8:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 19:39:39 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 19:39:39 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: Yosry Ahmed <yosryahmed@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying"
	<ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Topic: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Index: AQHbDh+C+ZYgIzdq4EuvViy0xt7aPLJnVm0AgAEuMgCAAFEmAIAADdcAgAAFSgCAAAmZgIAADtIAgAAWxLCAAFmCgIAAEe0AgAC+71CAABHrAIAAANsggAAWW4CAAA78UA==
Date: Thu, 26 Sep 2024 19:39:39 +0000
Message-ID: <SJ0PR11MB5678300E878F43C5BB8C485DC96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240925192006.GB876370@cmpxchg.org>
 <CAJD7tkY-ayU3Ld+dKTLEEG3U72fGnCbiQgZursK+eGMXif_uzA@mail.gmail.com>
 <20240925201323.GA880690@cmpxchg.org>
 <CAJD7tkbCDe1Y__0vUKt9q0dz_sXM74fKGQo2Zgq9CJ8=FEjH3w@mail.gmail.com>
 <SJ0PR11MB5678EC9681960F39427EABFFC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB56781A134838ADDD04731AA3C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYtVR6fi1R2O+jAxVfj7BJ2EKWbXHke9fkv_m=mf5pkFQ@mail.gmail.com>
 <SJ0PR11MB56785027ED6FCF673A84CEE6C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkaRjrPTdCCAA0zSVyAZ2sCKiJUC36J0fsajdtp1i_JZeg@mail.gmail.com>
 <SJ0PR11MB56781678BE55278052EB590CC96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20240926184301.GA883850@cmpxchg.org>
In-Reply-To: <20240926184301.GA883850@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DS7PR11MB6245:EE_
x-ms-office365-filtering-correlation-id: 231b7386-7bc8-4f1e-175c-08dcde62f5f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HVWYfrcsOu94tAWG3eGi9C31zG2MY2YaG2eRCJEiwEgQURFVkv/BomggpvC5?=
 =?us-ascii?Q?XC4xW0ZOc17aDjSs6e2hN5va+RHBSBKv20Rh9NHYLSPPbkrtLAymW4wAnaex?=
 =?us-ascii?Q?nYm1DfAoDl3ajAcZM3fdDpTMH62KSQ2XDz9xxYRrjNRinoNfViMBahbf+cmB?=
 =?us-ascii?Q?uJLKyYDGGtnl/LwcF1ht/gcKThl0AgwX0Nxq9xNqjiXX/6HnXDbBHr2l0N0R?=
 =?us-ascii?Q?LfIo1h8UYcTxgUxvwJlj0HISRtOb5CLJ0R0G8mE5cMCk7SMPD4jnI+GjmLQw?=
 =?us-ascii?Q?cpQvFQOTOvgps9sGzJJxYtYj6EsX08vOCKSUgTPJhHNoRmtDLBek9aZCfxKI?=
 =?us-ascii?Q?FFw2R3OGEgnDhk+pnkeiFaecxjCYRdcaD6D3lloMPzwa7Aq9zRtlr7YNa+hx?=
 =?us-ascii?Q?LMoqPfhCu8bVcgLFHUXzL9+H/iglcP3EaBiLWNM+UHKbnDjI/YgyYAjC1Mft?=
 =?us-ascii?Q?9GFwgg3wXbvYrM6cZ7oS4MfvmhdYglNCm68w4Wp9zoH2NLiIdM3M0F1iEl8P?=
 =?us-ascii?Q?vQPL7XywFe4AbWSynEYI5Us4/WfOTD3F5WqJDOXS4LWJTVrIpWmISKi6ZHxn?=
 =?us-ascii?Q?4FmF6LtsfV6ubDSxDp+QNJZPIZrlomvEOpVp9UuEKSZy9P5byidfp3E1Hxkh?=
 =?us-ascii?Q?RLNItxPV8pT80UkYIIG70j5YImRTYZDweQCkXW/jlyIukfSPgORqgEY7b0Xb?=
 =?us-ascii?Q?j0oCH41VitzV0ABS7QJzYKNObuk9FgAwvQxuJr5YgTgFzCLYCw4j4Kkb44FF?=
 =?us-ascii?Q?lQoD/QoTXL30+z4q/SIZC5H7NmfBxHqALmxOIncgXdOURccki9lPLsWWR033?=
 =?us-ascii?Q?iOKRUjJeV2ZI2HXoSnq02TenDUjM5+EH0L5f+H2cYQ3ZwoE+xz/fTMQDynzW?=
 =?us-ascii?Q?f6k4Y1PcetEEcz0N38fD1PqwLuzzUW9DBB840X4rv2TcdeNG+M+Bgq260tpZ?=
 =?us-ascii?Q?Rw9xIFrNHf+967qo6CzLvyuFH0GNTlVjH7H4ku7g7XPT6v2/DNDLuAmyafRs?=
 =?us-ascii?Q?4zvN6Mtr9swEfqqBAV1bKcFpziDQK70+KnhwVRXqse9bw2cMJrENM1f6Mw9D?=
 =?us-ascii?Q?5F+RLEaMM0BXJ22+1zKNYxK1Rq3JFVDHwNIeuzkM3dxSG5YZGzTP5Wit1y0c?=
 =?us-ascii?Q?t7CiDGF2kR0Vt02sIOq/vWNbFLLSTbsCknzizE+vG2cnMtQ5yTUqJioDhYG6?=
 =?us-ascii?Q?dzVNTvTSt5tmHfLar0w4IStw4d3AP8wfKNRGg+rXF1MKY7EI0FlqH5QIWLFh?=
 =?us-ascii?Q?pNYMIPhRFdJ3iAB706WRJia77/zu2D3r9hjXvhDQ7j820TGgpgK6e3t6aZfj?=
 =?us-ascii?Q?JNA9FV4DSWXwdt1RrNye/42fiNJPwLrrMTF/jRb3maBCKntI3xFASexVF9ay?=
 =?us-ascii?Q?ZF/K0+to01iCkvmDtDFzXoTdh1aRlziAf/ivYVodZaEf6lENxw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2xOzmRAvEsCLZWv2vbykbPFvPyjsz+DXcylwpEQNFtG13xoG2k13Sqb6bfNB?=
 =?us-ascii?Q?u6mcAHfzLxDtkNrb8zJIK8S2otlRynWw46+XwtIUcBzoR2I9FpsWrfdgJmlI?=
 =?us-ascii?Q?hoqxrzawdSvGnpUdX414rB5ScYbpdEy6mAcuyQn0CZxYgurx+RAbOYvdSJW3?=
 =?us-ascii?Q?DSYy3bWsl7Hru1b2nnuMawlYxKKCbUkaRvEtcqtMcsOw2QzGf6G6CeuuB/0/?=
 =?us-ascii?Q?v9cELFatbj93Hzf35hT0s0krDl3GfWe9nYidQ937SvGedeJvHwdYdzgSmEPv?=
 =?us-ascii?Q?gXJCeW88DXcu3jCwDXGl5ogSNEibE4XY41mN5TSdm0MR3lNDUa0ni80XP7bb?=
 =?us-ascii?Q?nlSY1HkS8ykGAjzK54/+umbw4ABAM4GhGhbjyF97340vCQADwCuV/fZ1jcUX?=
 =?us-ascii?Q?2Aun9ey1CEc/O/Np7Dh5VoB9ibDcz1Lz73caLog0xpuQka9JA4c9bcAXS75n?=
 =?us-ascii?Q?Al8Kd5Swqjtv7FK7NMzeg8+aajusLyB+LKHD3Wtg+ffTroM+qwDCXjZVgirD?=
 =?us-ascii?Q?rjWI+okc1eIgQZhpNTy/iSkWxmuXvgvsnqHsYaZQ2MIL8RenL3miiGyr3pSw?=
 =?us-ascii?Q?Zzd++JlW1s5jvAwahzoX2KIbOIatOym6hY178cABspPWdGOkwaR0J1XIxvVv?=
 =?us-ascii?Q?CRWv7VOhcv0zOBzczawWq126FB+9njPLJMtfbIN8kZzbyEo/jk4/5cskMvcx?=
 =?us-ascii?Q?6j672nabPoe1oE8XVMf+JDu0cy053nhq5nEJ+/hiVntGMHq6xV+OQWOKbn6n?=
 =?us-ascii?Q?wihfrEe85XFZAO5lTUTdptzocUDyBKwXNPGnkX5S/F8d8+9hnGKiA3JrrJ2Q?=
 =?us-ascii?Q?vKWD0OS795AGJMGOa3MYmL29uudRtia9jv3be/DYHTs57oswHSoyfatUaB8u?=
 =?us-ascii?Q?HGhs+6mVOnRYaKb9aqb9QGd5xB8tQgP4UzPl+SG4FweoJRnYieWt6+BK6AKt?=
 =?us-ascii?Q?Bqc+4JENT21UQVdWCSGCY8yLTkn8FS8jucOBhF5dgxePbdAAytZwfVXDQaow?=
 =?us-ascii?Q?iH8jopcT2vqHDrbMb2Dfyw0SGXuaMgx0Q+6OtNyzIwARwEHYRNUBVs37ueWo?=
 =?us-ascii?Q?I2BJG0P4aeLog+JT7cmK3WLyeKyRDA8u8wVipqMuAxydpBo1RotYMtXVX4YG?=
 =?us-ascii?Q?w6d4Co1MBr7lOSIBI26+g5s2TVFZ1AgJwSZhvUMIzHVuKkIC4609MMmZi2xs?=
 =?us-ascii?Q?i/VZ2lrejG8BgSghyW2ARsl0DYU6fJ6HYFrqfBpos+H6XqL1Y3vbJOzHjK7d?=
 =?us-ascii?Q?JWpXa9rACFj1pOSJZ/B3IsE/YB0fca0ssc/QX+ZuubJ2xBDikJIE/E3w77NM?=
 =?us-ascii?Q?Os+AZ5eGIrABacPJXcz+8oVzHRWI+uJ+d8ybrrS3ifHavbrpQ3Bv46Z8LOU0?=
 =?us-ascii?Q?HyGCj6jduAK1CAgVIUTKLtXGLoTY+z3aNyWYFff0GG6TrhkOb4YCrbyn2xOY?=
 =?us-ascii?Q?+tQDZJOordESvOkFjY7qcWG5Ujx693vL8d4/5oF/eeIuQQwd6MK2roa56e6A?=
 =?us-ascii?Q?f8AVwbtgDj+B62Fcn0dQgBzBKwhDYcUuucNtwf3MZ8ArmZ0EkIM0/J3GZX4K?=
 =?us-ascii?Q?pImSk7yQL3fQJsVOc5xUsMA+iGU9dwyVop2ALBTi5DOYlKR073pBapzhj+6n?=
 =?us-ascii?Q?lQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231b7386-7bc8-4f1e-175c-08dcde62f5f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 19:39:39.3535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2RUbwww3q1dUVff6dzPZDezNHggDxUCqwC11rxChQ1aGBswz6i5CJS9StAkA5iSUUBvW5cgdBBt8r1k6AwKwavbwFPcBYm61W5u6nCW1gM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6245
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Johannes Weiner <hannes@cmpxchg.org>
> Sent: Thursday, September 26, 2024 11:43 AM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>; linux-kernel@vger.kernel.org;
> linux-mm@kvack.org; nphamcs@gmail.com; chengming.zhou@linux.dev;
> usamaarif642@gmail.com; shakeel.butt@linux.dev; ryan.roberts@arm.com;
> Huang, Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
> foundation.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in
> zswap_store().
>=20
> On Thu, Sep 26, 2024 at 05:29:30PM +0000, Sridhar, Kanchana P wrote:
> > > > 3) Keep the approach in v7 where obj_cgroup_get/put is localized to
> > > >     zswap_store_page for both success and error conditions, and any
> > > unwinding
> > > >     state in zswap_store will take care of dropping references obta=
ined
> from
> > > >     prior successful writes (from this or prior invocations of zswa=
p_store).
> > >
> > > I am also fine with doing that and doing the reference batching as a =
follow
> up.
> >
> > I think so too! We could try and improve upon (3) with reference batchi=
ng
> > in a follow-up patch.
>=20
> Yeah, I agree. The percpu-refcounts are not that expensive, we should
> be able to live with per-page ops for now.
>=20
> One thing you *can* do from the start is tryget a pool reference in
> zswap_store(), to prevent the pools untimely demise while you work on
> it, and then in zswap_store_page() you can do gets instead of trygets.

Sure, this sounds good Johannes, thanks for the suggestion! I already
do a zswap_pool_current_get() at the beginning of zswap_store in the
v7 code, for this purpose.

>=20
> You'd have to rename zswap_pool_get() to zswap_pool_tryget() (which is
> probably for the best) and implement the trivial new zswap_pool_get().

Ok, will do so.

Thanks,
Kanchana

