Return-Path: <linux-kernel+bounces-176398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4E18C2F28
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9911F2282B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6224205;
	Sat, 11 May 2024 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dxmq5oQf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5721345
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 02:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715396010; cv=fail; b=LpozVZ2GY6xSzPP22dr6tv6K+V986vTwU71CQncN/50ZEVYYlhiA+bIBImSq1a3Qw8YttmJ6/+bwu6b09vIlv+rnlsQpuNgdMbfTXpcJGQ85YJ0kv99CWzRsJ1JqZMGXGmhYGbHicJQizW6oriW+lYYZ5M1Oq1xFMT1M2Sr8lp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715396010; c=relaxed/simple;
	bh=eeubMadPFO8qQAwDJM2D55AzCgS938eFs+ccovkHBdg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AZxY1Vnh27wekSD7sbo6N1fzRhRFTskfqEAvE7Bl3OaF7BB3dl7hanuDjcBvgROK91U9rjCSbtkimRLFCaEUUN7L2ocW1t5Gnla/EB/apflrF+FU9p4cb/MbiA11NNPA6Jh0qJRhzPslbmk5PnqiQ6hx4CLO5BucDOXYDSl/nbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dxmq5oQf; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715396009; x=1746932009;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eeubMadPFO8qQAwDJM2D55AzCgS938eFs+ccovkHBdg=;
  b=Dxmq5oQfFjkGFehA+qqf88BtJM5F0GEu3IcYFADNRl0BMvIFagY+jsn0
   QK+c+q+Gdl/UUtI/B+lg+z/ts6qCddMTULHPlK1gJ3zFvKu7ohQlkmYHz
   /5Ds/7m0CeLOJen3VHIkA6pPMNAjgLoVt9nQ6Tg+mqvL6zuXHx70g2iHb
   ForeGUnq36At/cbZSIR1f4TwjvMO14L46fvA0jUIET+iUn0SB6K4PuClI
   2hl4dmnXyewSA2L0n6OQ1Knt69gg7Pyl8DRQfUic43kxJHupCeGDWj6PY
   bz+19Ah1yQXilUQFPx2bxCGX1wwzIOzKIhAqvPQ9JnRF0an7qqHJvNFQO
   w==;
X-CSE-ConnectionGUID: pJkmjPHaRKaT4IDeOfULKw==
X-CSE-MsgGUID: e9bEfs3ERCWSGbyzu1UBdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11253135"
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="11253135"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 19:53:28 -0700
X-CSE-ConnectionGUID: 8MzaikyzSNGY8xe4S3K8bw==
X-CSE-MsgGUID: g153mAOIRFahFhwfjV+kOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="34318723"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 19:53:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 19:53:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 19:53:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 19:53:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 19:53:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwPWKH3AWi84/klrK64r1TLRl//3eF6S+JBpthBc4DOsaPuG8NWfOMHsijyDZhTkiBOIvEE90Nd0Nyt888crAS7tksIsQdDkMzYRqf5qPKRsM4K1jYjflhzAO7SfO7tNi7qBIbYRUUq/cUZ/hQIYSSINPbu7WyTktWEs3P+Ngi93Gp9QY4vy6ipNd9ClTe8ugkekD5jmSOy2GCDWXbP4GPl2hjFoHfKiYLjY1ecP+SwPlrOznDZ62aN6+OTgwJ98wdwXA1lifVe4+cmdn6IeSrKo7iL8XQZhDqvNHHBTfrIhx/AR9ToHaSaFGncoqHuDL4FWalAML+cfUosDNE/7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUptCJnlhO/+gBIlk1ZkHzhEUibd3SS78iY4ZcQJl4E=;
 b=KwRcd2kwfpy/EGBcMBCVRX3n6hVb+OfZm0uLA5N8Owf3UYqsAC+WTSnkSL6PpGI57i8J/gl1T6jcngSanqIcawv/RggCqptNV71Ye3U1UQ3Dvfib+4R5akUVzS/6zAE/q6TNIbXR9OPZQI69tiCwfe8J8zR/pvXGk1a38iT2v231cF+JQQ8iyuRJW2E8nwSgxGBjMHyYIkziL+zz2/opCLEoLwcXFhnkQiGDy4KOvNPIuwyiZy6UAg2hdMYQhKMEUwEXhKRbNEWT6yB5gK5//WJT1ha7IEix/hPqFCub1owzX9sh6Vvcp7SNZntulQWzGivAIxwOOMRHL1ZbFC+9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by MW4PR11MB5869.namprd11.prod.outlook.com (2603:10b6:303:168::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Sat, 11 May
 2024 02:53:25 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%5]) with mapi id 15.20.7544.049; Sat, 11 May 2024
 02:53:25 +0000
Date: Sat, 11 May 2024 10:53:23 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: kernel test robot <lkp@intel.com>, Frederic Weisbecker
	<frederic@kernel.org>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, "Joel
 Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: ERROR: modpost: vmlinux: local symbol
 'rcu_set_jiffies_lazy_flush' was exported
Message-ID: <Zj7do9o265Rrm1HD@yujie-X299>
References: <202405110230.vcpgN5vz-lkp@intel.com>
 <965221ae-620a-497a-9a80-5725e3fe3f7b@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <965221ae-620a-497a-9a80-5725e3fe3f7b@paulmck-laptop>
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|MW4PR11MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdee99a-031c-4a10-cc50-08dc716586f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Gt9v0xSTGfQoiJxAneKRi3CMmzA40j+GGJFerGsuK8gLohp+nka3XjSRDNn?=
 =?us-ascii?Q?IWySwGr1aESth6gnAIvdZsK5OKZM/eHHSRGrTc2htdukLcykOy8T9WcSMQHh?=
 =?us-ascii?Q?WsUTXhucnDMcWYzNzfzmbWAvXejcFNRU2YOnZLnQ1Ej0hPLbuSADL337557/?=
 =?us-ascii?Q?IRE3hmb3JmvSCcGjBJrOJbkk5EwXB5OTfASaYbJt1OSOCy2DTTD1/L+f0HLw?=
 =?us-ascii?Q?0sVe6e2oZ18LmZVYbYMueBXJzFs0kVcCxZrjDNE1h0yAPTrCTxR4F0djyTN/?=
 =?us-ascii?Q?+JksQSeQsqtwPfblSZHKLg3w9CBFnNS/akb9nmNr+qxcxyQtDtqqOhWtjI/N?=
 =?us-ascii?Q?oqei6vN6uloiF6VbptFnOXDbPCqwv7BY13YP5XhI0QPF6Bdiis3EVaIN1+12?=
 =?us-ascii?Q?SozWulLVL1OkzSBs1KajG6lt9Anm+5q8tHJDCsNQoPON5HRT9ufwmoLh3tRe?=
 =?us-ascii?Q?Lk6qAsM1RkhEPJ95SU0OQvuuDmCLnEh+9bzOGiqlFjtkhbgfuM5RHQ3dC8oG?=
 =?us-ascii?Q?Mwo7hInmMMGrQBCr4M9idSjx+hCpkvryLG2ZBxd71gdN3MJI1b/wENe9gags?=
 =?us-ascii?Q?AYi47K7NW8h1BJa5TZv65lZpquOc55Eyr/kLO9n7oClRcPehBrLtB9Y9wq7+?=
 =?us-ascii?Q?uCHPSE6fpZrRFrSzrcReqb4MSMB5J2NpgeyGhQ/h1gqRK0cZ06sY+QqCS1bD?=
 =?us-ascii?Q?yq6k8Z9trEHRX3FeYW7gHsDf4l8dznjfdvz97ZKFCM7xUUjhhUcpoobvw39C?=
 =?us-ascii?Q?oikQ7AbBvJMi51iwbS+FzokaKN0ZFQk9g7PJqyRxBmHSM6sZ40b63ocIwjo0?=
 =?us-ascii?Q?kdLtJMYQsegIz84xaENc6z8/nLiOl07vD6AN/0tfapHgPpl7vpHN3cV7cP39?=
 =?us-ascii?Q?qX7IAkZ5WQnSjnV1LW+81v3n4C2HMsV6RVZIhms321e7IhZfJPlgzrNtJ9NX?=
 =?us-ascii?Q?qI/r7Kfy52NlJvg59HiqlLFKPt6wu+Rsc0Urn5SqviiUPNQBkUnely170NTd?=
 =?us-ascii?Q?pxmNHpJ+FTnRriu19t0YFRpJuR2RfKG8bYMeMJ8dF1y6xvA3Aa0j1mwrGxjS?=
 =?us-ascii?Q?pHQYor1cLKbiPkEvnEfWBiQ8upg4kuGG9jskWuBIahrJ85shPdobB0/xhFEY?=
 =?us-ascii?Q?iz7YPgj+4MaHgQ/ixgsNU11+lPFCxrlvS+YvdcZLfgctl1Vb0grCPEto+M+U?=
 =?us-ascii?Q?SIw3SrSK6VsBR2AcdeHvGHEhhJN8XfsOZcFw0NPVOlLRd/YTZtfOqWCQFho?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZGa0n3oMPPQpPXDFckawJUntct0uYcwRAMHFsmGAOvoLLYATTgxujgwMOghq?=
 =?us-ascii?Q?OOJzZ4tpMKjpqf2pbpWD8Qx8j761izCwQV63DoyByAA4eYl8Z4dU3UTjRtGt?=
 =?us-ascii?Q?ahx9IKgMLWHNbrQvQJnQ4jsoAx1X4VIzM3ZISOOm6+56zXJg9zGsONkHOmCk?=
 =?us-ascii?Q?0f02Ez/HQzaazRC4vvYyzOEKt0rMzjZAMoEKgPGf5hwtuZi7KrL9kV/TYPPe?=
 =?us-ascii?Q?mcWCXOfUo6N0/8Gn5+s6iLcdJxuhb6bNZIUgf7qwj3pj+D9k0bd4/GKCuY6J?=
 =?us-ascii?Q?RI1afMLrGXw9RSUH7f5Vc4iclfGBWlPa7RlCARq+fmxS9Uza03ZzK1ekAHBp?=
 =?us-ascii?Q?gveuTqVmkuVrxvhJehRhRBTwOhKqIUTKw57xEtlYX+SxdPv/z3OKCzVilii9?=
 =?us-ascii?Q?IwgTXmsLdKzsVgYuv5Eh//Eo4TUbvW0Ft2liRJ79PhroKP3jcfnCTU/59i23?=
 =?us-ascii?Q?NSnBtzPRjPpF2FiTP7EOSZ6iUG2Upb9EqME0zqSDlno174pHoLFXEfekA6R4?=
 =?us-ascii?Q?XYWB/PcpeAmzoFuE67ETJ2L0h6WZhbJefetb1fQfOUsF20c2asru7pVzxJ9P?=
 =?us-ascii?Q?n+BdLio/FcvKM69ZNe570T61Ah1R2GwlHynHiB/7MZEfoAgpxASWCPIeLTNa?=
 =?us-ascii?Q?wfgT5u4CW+uBH+sZRg/sw0WBO2XheYpObuZkjobwJcZjoBVxLMfpq5CKAJGX?=
 =?us-ascii?Q?IVB+FoGnGV0LSKretiQZ03mGVHdToEqbQqJq9V3k2Bvh8g8zOl+fGPEJRGy4?=
 =?us-ascii?Q?lRbTy4cz7UWC1wrf2D0jtbSt9K8hzI1mqcIdnXsAZLg8hjTsKGd6sT/dsu+e?=
 =?us-ascii?Q?y9fHuFHluceWMZ38kmBc2tabMaL3qinM6xfQEuefq4P7nMiwewZOCnLjs4Fc?=
 =?us-ascii?Q?Wf6ZcaiaqYoxfqje1yW9yr6WEDr/IlCdAWYnkOtme5bSLawUbdReLtHXkEpi?=
 =?us-ascii?Q?tfeC08wZCTx1f3YEqKWxmhBwZgn71yVO9FU3bpyVvb0tUAZyCjavOYso9eys?=
 =?us-ascii?Q?oJLZzuc1GSK7aWY7XoZSs0UXbtj9OfcQ2lvyiIH9iwDs3VsKqaY2SlmirBIV?=
 =?us-ascii?Q?W8ENu6rZ9AErkakls8iBGi59IeYNkrbQP7C9LcEoPpR1iqUzy3co21WeKaLP?=
 =?us-ascii?Q?1/BN56nxtwMJ8gzgdu/OxQtlMfT4TPpbT8fO64LZhTQ6K2UmN24cmj1CQppy?=
 =?us-ascii?Q?hHMhZEh9SoDQJ1ezN2QERZMrLB+W7+VR3LNjashjHChPn5rH0MtM9ZCH578+?=
 =?us-ascii?Q?zKAXOtipjYIRiTBDfJNel5wZJ4JIn+Lcl9oFo27tTspRyJBIOb//3S6jymxz?=
 =?us-ascii?Q?Y+8LcCdOlfhaaKxO2HtMHV9PDJg8gS4PtJmUkb1ZNrDB7HzsDcnFDuLREMqS?=
 =?us-ascii?Q?asyGUOc8MFdPiA0cGv7C+wDI9GcW03u3+HCWf2CTUbqUJDZb0X4huAh43uzg?=
 =?us-ascii?Q?y30SN9NZl5yr70f1DGYcetQiOhG6YzQX41qG/QPp6hd4lfLb/v44X55plpl6?=
 =?us-ascii?Q?GHXdYwR5VmaprEfpt+PADDDwF4CGxLHZIK/SAOwHUBUWlB2USFAFbJ9Uk6m4?=
 =?us-ascii?Q?ecykzhqDUp6NrJ+d5yW2vHehicyVwljxm9jDi2pC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdee99a-031c-4a10-cc50-08dc716586f6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 02:53:25.0600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eELOCU3KCv4ibE+Nwna/PUU0FrqH298QhLLi2BGkptMWE9nE6nUjib2y2gfEoLXAAf8aiRtsdAYogwENsaZnDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5869
X-OriginatorOrg: intel.com

On Fri, May 10, 2024 at 12:09:02PM -0700, Paul E. McKenney wrote:
> On Sat, May 11, 2024 at 02:53:06AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   f4345f05c0dfc73c617e66f3b809edb8ddd41075
> > commit: 499d7e7e83d25fcf0fa1a8c0be6857a84cbf6a4a rcu: Rename jiffies_till_flush to jiffies_lazy_flush
> > date:   3 months ago
> > config: riscv-randconfig-r021-20230817 (https://download.01.org/0day-ci/archive/20240511/202405110230.vcpgN5vz-lkp@intel.com/config)
> > compiler: riscv32-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405110230.vcpgN5vz-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202405110230.vcpgN5vz-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > >> ERROR: modpost: vmlinux: local symbol 'rcu_set_jiffies_lazy_flush' was exported
> > >> ERROR: modpost: vmlinux: local symbol 'rcu_get_jiffies_lazy_flush' was exported
> 
> These do not look to me to be local:
> 
> 	void rcu_set_jiffies_lazy_flush(unsigned long jif)
> 	{
> 		jiffies_lazy_flush = jif;
> 	}
> 	EXPORT_SYMBOL(rcu_set_jiffies_lazy_flush);
> 
> 	unsigned long rcu_get_jiffies_lazy_flush(void)
> 	{
> 		return jiffies_lazy_flush;
> 	}
> 	EXPORT_SYMBOL(rcu_get_jiffies_lazy_flush);
> 
> What am I missing here?

Sorry this is a false positive. We will fix the bot to handle
this case correctly. 

Thanks,
Yujie

