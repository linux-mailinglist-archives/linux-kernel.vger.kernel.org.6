Return-Path: <linux-kernel+bounces-324084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3589747C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6151F27381
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E022CA62;
	Wed, 11 Sep 2024 01:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqgl3ge4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D085C147
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018061; cv=fail; b=FR4RTxZkI8+ulPSbzqSrsv204sV68Rr3B0DoF+4qSyyxsTskuqY56P247xw5e1Qi11yuUnXr7B/Mu5vw9mxu6PK+ylyXVZgNfutsYEF/4LgcczaXNhuCbkgKr29R6368HlCij2Vv5zKiIuq6HS1s1bhfcRDO2WKOm9jxvj9A498=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018061; c=relaxed/simple;
	bh=NOmc6YbbztdDURuhbJaEMgNIGf1gbjfm+UQqtzF5rl8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qoIGb5Tv7cJl2PqP7iMYfbNDt4yf8jKiIcVIEGoddUqpf2WoUh+6RCzU1c7Nm/ZN4gtQ/C5UrxO+z0ItTDO6mnVQfHwpkQRT4zjbtkhYvm6H7UsT3nnnQ5oag/B5Okz8cVogVJZesTI49TXn2wbIAuyzMKMzqoQzef5H8isJfB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqgl3ge4; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726018060; x=1757554060;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NOmc6YbbztdDURuhbJaEMgNIGf1gbjfm+UQqtzF5rl8=;
  b=cqgl3ge46xUS5Bd+ebJ5Snxmlfi9Rp/BsX7yH1d6Dptx03IeFvBxirhn
   TfZ0iiwoyr5EbJOeZ7mHfgE21aExGu1I1v1f7aPAl8WMCCIczAGXX3MfK
   srcJw9VIe6q0ppjqTicRyPYaLJFVAbn8DMu6KfUtgNYKyXxLgOzKDmk0n
   w8Xj8TGH/4CLvGu97CnjhCHtOa5c5sG3H13PRQv1yM+o9H+iHv9zLwJtP
   0uLzO3xN7bIRLzmU+R02gpxIfacQDtnAXZ3jGTo8vfNvw+5CtG/J6vEoe
   NY+/osCA0n+waBCl6uRibQllpMucIY0zR25u4KKRu5hM8gP3Kpo0sFfxa
   g==;
X-CSE-ConnectionGUID: rFQA9NaiQkeI2TdPX5OFbw==
X-CSE-MsgGUID: iW/MxZTVQCOeYDswFTJ8WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35389545"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="35389545"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 18:27:39 -0700
X-CSE-ConnectionGUID: 1wbsLJSgRuuhds2GaSy3Vg==
X-CSE-MsgGUID: GAnUV7KpQY6WaD1ramkwMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="71978171"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 18:27:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 18:27:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 18:27:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 18:27:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 18:27:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grDDObeed/lsDtrXRlD03ubysC1a02rOOg+gMIbGduLT7iCh3Q0D7WKOOeP1zBBikBuWUoWwx+UYC+M0aENQLBc6lcF57xscbikpDU3X9laE7SaVuDNEOYf38UtyQxBRvktT+PROMk+0nfiP8WmS6lPPDheXn53PMjT6zTzZ1yt6jPPgznv9KRp+Owj5PH7JwUYmYvXhldlJ3DfQvG8XzIU1pI/yr2xJjYjfZymIxEn/cwX14EeiZ5n2vqhnMMwem/aIQf6Xpvi+9az5WWHr4KQ2Fxrm8aC0hEbjUzZIsqMLlbASRfAKY6Xlw85Y63PAUhWxdq8j8SpNPcGfmm8SBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0RFQQog0B18eAsc2lwifcUEeUrvhhoIPmyRJdvFiTw=;
 b=juE2P6q0Q0ss7jHSRlP4dlBGabDVlSjsR2F3E31wxGiVVbFIgiXJa960ecy1Xle6kSKzBl3eGG/QooknSjcXLvw0o7i68XDSvtxhWEjNgONDmue6h7x2hPT6QNiqAdc/qid+BEBtkxPxL29Z1Ozgh+/t+E7uihzpiapBOuWotvVfZkpJt3eu3j4nHptP7XlX43RdIf+zBiDV2YftJKDgfioPw41t/K48Lz91AUuIP6RMMPSviCb/eoMJk6gS36v2vny9sHVyghBLrupAHww3Dsr4zeVydB627UJMzIU2zB+epCLBQ+pN0MRW69RcW4q04kCSO1W4zcjYUOb7O14UBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV3PR11MB8460.namprd11.prod.outlook.com (2603:10b6:408:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 01:27:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.020; Wed, 11 Sep 2024
 01:27:36 +0000
Date: Wed, 11 Sep 2024 09:27:28 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, <oliver.sang@intel.com>
Subject: Re: [tip:locking/urgent] [jump_label]  de752774f3:
 kernel_BUG_at_arch/x86/kernel/jump_label.c
Message-ID: <ZuDyACX/SXEm8OC1@xsang-OptiPlex-9020>
References: <202409082005.393050e2-oliver.sang@intel.com>
 <20240909091531.GA4723@noisy.programming.kicks-ass.net>
 <20240909105623.GH4928@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240909105623.GH4928@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV3PR11MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: edec8b6f-949e-4a7e-ce07-08dcd200eac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fZRKrpD6aFqU4UP4MDO1TERYWK6QSRHmXtiLzXaSoyYvTRLN1wuJRLlbTh8J?=
 =?us-ascii?Q?RIC92S5HrgrlNzIcASS/SbeX+XX3Ur1qcMM1XdRIkM5UQWI3CtMtN9rxVgyh?=
 =?us-ascii?Q?VnrikMc+ENDm8xQ/gLDtLbmd2gGkMKM3Xh/d0U45KYif3IesDG2i1ZfIErCu?=
 =?us-ascii?Q?PEeF7ecygX2k/OMuviTrJgGf8Qwf8/s3KmG3h1uyLNFOWklGCnFu6M/NBRi+?=
 =?us-ascii?Q?4K2qVm5llJJX38MFCuSHF/ssBRjzXGpfzXqVNpL0dt5X3fFEHfc3eaXa9PEF?=
 =?us-ascii?Q?xZzFzoqLIa/xXPReXOGBvxftayCR1eOg44fSWDIe2M5Dz56zrlCCee6gSjur?=
 =?us-ascii?Q?/oKLphbcIgCYKZheCzsYXEQrUB9cyJB3VvcU+uAZDDGpeBJ5hQb7pNyVsBP2?=
 =?us-ascii?Q?ZZh3mxst0SAPlNG1CFc0vWnJITcG6F8NETLqRmJE6ICdk3ParEuI9N9xWb/o?=
 =?us-ascii?Q?h11sTJx5vxBSLYTaUh8bovhLoq8FmXO6ipmZ1MDlHA5IF6I+qe2OPmneUuM1?=
 =?us-ascii?Q?zWreP345oGKlXHyGMc9E7U9WEnB7TarEErPahpIIE7AOmPa5CVGE5h+KpZxy?=
 =?us-ascii?Q?zbVXmEoSlnwOU9bYU0Uo1570+n5gHnlG2o/XO29pvQhdy0WFgCSadEW4BDdE?=
 =?us-ascii?Q?5GCMZ8RH4ES+y2BALW9bUvhfV16JiSg64x/Bvgq/qGMyTX7BdsSMfL1vR4Hl?=
 =?us-ascii?Q?JGC2voOONkX6fM7f+An/RLqjAnhJ530jvouTMUGaKRalv4CQunzMU9XWJdOc?=
 =?us-ascii?Q?5zzPbYDE6hqZIzKdT5tUmr1SLrnoIDcJNin9XxE7n8FOci5/+RUvLCKYSgAv?=
 =?us-ascii?Q?56H2W4UwXW3z2w8dUoSeAxX2/GSXo1paKMw40C/stLHWeCykXNRr6q6DKIm0?=
 =?us-ascii?Q?cy6YtqLp10jcQAVOhbSZ112Rx1N8NLsMenBQ8+uKtD8ImB+NhahEV+xPtv60?=
 =?us-ascii?Q?+QdtDubq3K62feZgbWJjp0cuVTmlBprwSOrRBNrrxuyRB7ftqjSKtpyitLk5?=
 =?us-ascii?Q?uyVQ8LWv0wS5o3TLnT9IWzyFYPkb0DLV2yl5H5ms0zqNOJhT2Al/2Rs6Olpj?=
 =?us-ascii?Q?VNSbD4rF7o3HH9T7aUl6+TX1h4w0H0uQ4PR/vgJuRAekFWCOwynQrs7u5c9R?=
 =?us-ascii?Q?G/IJ437YZ9UXJUw80rAQZ1E3FOy5s0rCUiv0iBSQ383kt5FRrRrpedt4XLQY?=
 =?us-ascii?Q?U5KyVfGAWw+i5nHmw5vOppgMfF9K3ED7VzVxlavQZBwwZvbE8m0pPHLo7nPy?=
 =?us-ascii?Q?FOPCwOBqIwigyn2eXjdtnSaZRbfV1p8u/5AnUWLDjZOxO3e4SItFEMOcsuDJ?=
 =?us-ascii?Q?RGKiHnTnOLBJU2h/At70a75pDksfQX+XkRFEjN1kQO4KvjVadQUpT4M3IzsO?=
 =?us-ascii?Q?NNUPVpI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ou4NwnMOpZKLTeBnL9xmWJvgnmYpiLHfu5d/1T37rXbfk/XtiWtyxOT7WIxC?=
 =?us-ascii?Q?cQ9ZxlMJoMyXr+6kp7YGe22xzWC4gTwkCjb4wlCJGcMelDrcvX5BSRGnCPa8?=
 =?us-ascii?Q?ozJSwNxI/67dZFbNALSRr4JuzmabFlY6YbS4ssg5VVo8l8dIUlH8H81YfItt?=
 =?us-ascii?Q?whcr9N4cFVw/uyNVhbrT8EKsLsrO+4ghOTruLi+QUrwBaSrVztvWLxPY239G?=
 =?us-ascii?Q?w6EevASQcStWB4sVZToWVsOfkCQkxpzUk3oHtuQMuEmY1cMMEptY3ku4rWTD?=
 =?us-ascii?Q?dXif9C4fG4a4z7n9IQjLJnC4ju0hbdvFYdHmIskfSETOhHi6M9iEhhk2rckW?=
 =?us-ascii?Q?+CXkox6SmvjeUKq9NDDIbRaMFVeW6duJaadnEOmyCCd7Rs5r36VnYY5t7v5s?=
 =?us-ascii?Q?kxctbemVsykpfIOwvv9ZVZPO5I561buFPI0ilqNpC1n4XfmzhSJVG9OnmfZC?=
 =?us-ascii?Q?jiMTPbBcLI9ZJPKo5qyf/MxGiqdns4E0RLPZxkfoOGUH4xE2rAW4xQ+AWEph?=
 =?us-ascii?Q?UVzbe606PR2w0VqcD6kKE+bqNhqP4QWQInJTqjqTQiO+hGCpYNTVG2Hr6xBm?=
 =?us-ascii?Q?mWU6hbhKHGCIkN/3O831UYBiTuZxz8dXqLUpfq0jDVj3ECeG537qHpQmbDQd?=
 =?us-ascii?Q?dQV2UhWn95aSnFabH5GCB6g8/TNMZ6raPMW3lS1hdH9Mtt/9xAFxKW9p/M7E?=
 =?us-ascii?Q?xKeEkY+dbOodWDL/XsmPppYn6TiN17mW16uQ+8MyYogArbyDey6dvBoeRrGH?=
 =?us-ascii?Q?FjiK4k5cuz8jPxTWYcUQQHFiTr5l3ls+RWEvKiz+/Ll4LTNytgAvmA0413BX?=
 =?us-ascii?Q?Cw1WGv1mdg8MvIdk6FgTy8Cd7jhRrFyRS82upNoZD814yBi8BnZ0+/gmHws1?=
 =?us-ascii?Q?rekpDYGeNv/gng7YCk5gtkY7Sf+PLitBYpPqpw2eLvH0Sb5kVPlenMYgOJsj?=
 =?us-ascii?Q?wDPOsDT2z4jTUwmLKEUJGOU45EquUmDi6mdVTzlEIi4L8wJs4chdQ6aqWdG3?=
 =?us-ascii?Q?tcDbGy59CkIsyPulcg/JEpOLruvD9mwuiFiOlSUFl8D7HPU0MCzFMo+lWonq?=
 =?us-ascii?Q?vSvZ/+L7R99II0cc9Q7NkABUTNw6pg3vLWbbbH8W7k9juDQqCCzTaLPs1Nz4?=
 =?us-ascii?Q?gQN6YlrCq56YLNBxv4q8hx8PgvnPiEN3Nhy9bKhva8rSddSWSJCiGeCTzAwu?=
 =?us-ascii?Q?5gs2Ek5LpYPbzAoUS4SIU6rPZ8YAHScqD+3g1vgsv1s77Nu+3jVagthjBijV?=
 =?us-ascii?Q?03InhvT1SMHi0tarVX0vXT/GmiRzVe9qOYhnaARjHanCL0zULElowZSBqubP?=
 =?us-ascii?Q?qfuf4NIw0I/qNqGUZeHXADLW+OHMrtLF6SY63TazuyAK7v9lmVie+kX+gtg/?=
 =?us-ascii?Q?HOHVsOwIlSOHHt9369r6646/0N9WIPTOZLIfpisIBXhxafVh1FwV85pKNfuC?=
 =?us-ascii?Q?U9k0rGylUf8xeAo9Gr4dDQWspXhX23elHJCJnS5aoo4p4TRTiQ1xb0mOhiRP?=
 =?us-ascii?Q?RlL2yXRiQA59MCWpYSakezxeXAcu/igfo8+4uZilNwKaCr0B2dRzllDt7MKR?=
 =?us-ascii?Q?kURabBI3QLr1txxo8h80pAk+WincFXt9Ha6Q4UAk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edec8b6f-949e-4a7e-ce07-08dcd200eac3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 01:27:36.1142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymT62j3noNxSIALveEepsXl0jQljTNe6+hkFRLtRJOFhu8g2Lh9fL8JCNT5RoiDEPyimdTr0bZ5qcZOyu/lX5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8460
X-OriginatorOrg: intel.com

hi, Peter Zijlstra,

On Mon, Sep 09, 2024 at 12:56:23PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 09, 2024 at 11:15:31AM +0200, Peter Zijlstra wrote:
> > On Sun, Sep 08, 2024 at 09:06:55PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed "kernel_BUG_at_arch/x86/kernel/jump_label.c" on:
> > > 
> > > commit: de752774f38bb766941ed1bf910ba5a9f6cc6bf7 ("jump_label: Fix static_key_slow_dec() yet again")
> > > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/urgent
> > > 
> > > in testcase: boot
> > > 
> > > compiler: clang-18
> > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > 
> > 
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20240908/202409082005.393050e2-oliver.sang@intel.com
> > 
> > So the whole thing actually boots and works on my real machine, so I had
> > to resort to using this qemu nonsense, as such I did as instructed in
> > the reproduce file.
> > 
> > I build the thing using clang-17 (for some reason debian is shitting
> > itself trying to install clang-18 on this machine and I don't want to
> > spend the day fighting that).
> > 
> > Except, once I do:
> > 
> >   bin/lkp qemu -k /usr/src/linux-2.6/tmp-build/arch/x86/boot/bzImage -m /usr/src/linux-2.6/tmp-build/mod/modules.cgz job-script
> > 
> > The whole thing grinds to a halt like so:
> 
> Since I'm not able to reproduce, could you please run the thing against:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/urgent
> 
> and see what that does?

we did the same test upon commit
6b01e5a8c1161 (peterz-queue/locking/urgent) jump_label: Fix static_key_slow_dec() yet again

the issue cannot be reproduced. thanks


