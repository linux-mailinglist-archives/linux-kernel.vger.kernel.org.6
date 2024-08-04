Return-Path: <linux-kernel+bounces-273875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F89946F17
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684D1B21244
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEA73FBA5;
	Sun,  4 Aug 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmxpkzu2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78C208B8
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722779148; cv=fail; b=VFGC2ZZcJqXXMtALuQi+Mf/ThFEtuPuMeYpw/Asxx79NrSynG/nvIdP3Gl1GH+Ivs/cFMcpOU7mh1R2+1ZTTji9WwwBofJFrZ/d1u/eAdwNKouxBDbzsZ5Ae0f6dBRIi0y2iXrJzhzzLZ0KxnTyJobnj2GxRv23vzbJ4l5I301g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722779148; c=relaxed/simple;
	bh=6FVs+5HlqQf1MDJzIMcIdpPw9sHIniUarg4PlVFq5Dc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=IMaAHnFJ+6yRDTX9BSN1ftFhfLJa8DJgrwwnkJlBuMTf+xJa0ARRWYqefonOy6sjESRdRDdOfjz7H0LFBuqOwxSDJZr3qOP4j+706FtTgJ/jtF5JyLo/K00cjx47zR26+BTAV+Vc2NLvsqe4WUp3BHkQZhijI0mWd+jMjwNfnV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmxpkzu2; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722779146; x=1754315146;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=6FVs+5HlqQf1MDJzIMcIdpPw9sHIniUarg4PlVFq5Dc=;
  b=bmxpkzu2ZpvUfVqtst/+Efk4H8TFyUXDTvUnDVgzQjpmk5IEf3u7APtG
   mB7Tae2vrmpWdG0qN1kamUvGgGuCUSl80DIAcvEGVU8LWJ2T2btI10EC7
   rBJlwn/SECngPhBPtUlZok25eafKXVheu0H8aJsh2iSoEhsr0VEc7124u
   dW+cLMKwerdmJXpinQVvOfNNlEv8lP5coyVRmhYyaqI7Y81m4sWUGPhWQ
   Vz8/radReZKA+gaTg0Rm0jR9bpQgluSKlqVlBkhcmqQQTmKHprerHM0EF
   C4hJhAYW+X/XrIHLYpBKmGi/ubQq+P9EACeyfmui57RQl5IM53fAnQpH6
   g==;
X-CSE-ConnectionGUID: 4HhXorfBSsCzcnW56+ct5A==
X-CSE-MsgGUID: 6m8mUZcVRc+8Pg+r6Ee3sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="12862990"
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="12862990"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 06:45:45 -0700
X-CSE-ConnectionGUID: xxtErxH3S9+ZMnzIEmuzQA==
X-CSE-MsgGUID: R6nGVKkbQ4ajjszO8Y9+dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="86855099"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Aug 2024 06:45:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 4 Aug 2024 06:45:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 4 Aug 2024 06:45:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 4 Aug 2024 06:45:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 4 Aug 2024 06:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONgErmqaCCVjfNg9G23nVF2nQOW+nQSA3kgoNoIkJbyH7lJlE6DzJYAP/VEwowm7+vz/nboFl/LkvrB7bZqu7dS1YfQvWWEa2YC5DdU3bnd65yhzaNt5VAsX7AHtn/dqC2+mHvmbUlff9HhKORTMmXw+2URhaDkDgy5txfQopeARpIeHb+qH61L/bL5PZhAWaxMn33FM+uOSdMdvQQT7bdSH/nFoW1U7LQIXlWaOFZIn1giLuICcYpKa8kfsLEyD7dpOTDZuAENx1R2DDX3bxof3FIcBG+LIoaZ3s+CRm2UvAu7v5jzUG3GSzZOt4NUmE/dfenN4Anx+QzGVw5bYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs6PVgw4VAt8Q08kcOcM9oU6Wdpvoyhc/xknuZ2GzHI=;
 b=i5Qz6r3a/P6Y5nlbnm31UoCn1Qj0N/gckcd3d3UkUUPW1w/MDdRwOGC6bCF3U7RO894LFB1VMKklauFWoZM2YlZizB0mL+AkjlN2n5oABh6DbgLoIGCPPGoMWxeiKwnyR7ZtcqwK2B0UyoazhkHiOmr2rhJ8OCtwTT9G+n4ie7itLHi1hw5WkgfTVhme+Q2g29e8hTBMa4lzdHXDO5PY+sxVy/covJMwnJ9evYhkVjj0b1GCb6sW3FwNz/EJuNH8KdevRQrHnA11UFCKu8Pz1JmO7wFvSXUbmQ8pno1+tfCceHA7xPgQt5VWG7Ii+suk7Qxf8CQLLnxreIoBKC+k2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6437.namprd11.prod.outlook.com (2603:10b6:930:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Sun, 4 Aug
 2024 13:45:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Sun, 4 Aug 2024
 13:45:41 +0000
Date: Sun, 4 Aug 2024 21:45:30 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Daniel Bristot de Oliveira
	<bristot@kernel.org>, "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Juri Lelli <juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [peterz-queue:sched/prep] [sched/rt]  2cc53c6bfe:
 rt-app.rt-app-thread2-1.wu_lat.average 25.9% regression
Message-ID: <202408042135.26c3555-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c93a9d-03cc-4e56-3d68-08dcb48bbb4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?W0C+zw42GE3twx2g/W+dZd2Map5rb2BZ3KDI04Hc1TOgMND7DXojnIJ2NI?=
 =?iso-8859-1?Q?JyPnVFKZ96N9dhGyLyZmheuim+4yuW94czf5xsDMBfPYsx49jZAuhnM4rX?=
 =?iso-8859-1?Q?918jlM8NGFR3Dh4A3Hm8+rg62cUpJ5qCK0CQpNdlgW7l7j1s6/VDKVf0NU?=
 =?iso-8859-1?Q?VJI64A/b2D9Cl6GuDaxftYlWIbR2yd/MVWzrFulXs5MYh6sk2JdyAIYAj3?=
 =?iso-8859-1?Q?ixGT7JNdYqILX3A/dPcAkPDpgcOVOI+u95wgDFAwDvHJQhq98tZBisSiPW?=
 =?iso-8859-1?Q?K6izMfBQSdYdntWlkZhqdq9qU5FFHB8tKGTFA8sHEkF67QNGuv5pbRPUBP?=
 =?iso-8859-1?Q?iizwk4BcthjEYO0Ef+Hy8mbtocjVHntN5s6Gkfq5PB/8MGdasUv6SHIcY4?=
 =?iso-8859-1?Q?iBQsE50hsAKALd3DkVvDeqgVGj4KI+W8r37MUDh8fFEFc9d2/bsvGSv4/B?=
 =?iso-8859-1?Q?qJzPXeRWtzuhGuRoDY2a1lxZ7dflbuu+mx5IM11VNkgDa9sMjwdd68HvFu?=
 =?iso-8859-1?Q?9iAjZA/HLs2oiw7efy9OfM4zdZsY4Di8LJ1i/JNX5IfnasGKlEjCIMz9qQ?=
 =?iso-8859-1?Q?GB62xoObnvvYLHPiDMsBp7e0OFEt7okMJrhpHn5kdyFgbTqThVCOwEQeUw?=
 =?iso-8859-1?Q?4G8dYpf1Chd11d6t9C440DjX9EngbkMMMKem22nel3AmKz3M586Txjv5sP?=
 =?iso-8859-1?Q?NQlHN7IFEHCyP5LqAov8VdAdPfxd3ES0Vrj5Cav7b+v9KGvyfHrcYdyb3g?=
 =?iso-8859-1?Q?Rc4J89HKum/JRL1TymDzTY+5jgC9pQMnvReoD6YUNvBrqu8X9UJ/KhpWVx?=
 =?iso-8859-1?Q?rdXNg+tZX70HEbdVXKe3Y2m5f/IFLiW6NTc1YafJmImDq4Lz5z82SRIn7/?=
 =?iso-8859-1?Q?FQEnOwzT//7pmG81LjyPST6dlSDmZoiqKGA8NyiqDP7REOITlTSwyecnx9?=
 =?iso-8859-1?Q?Twgr+boEMaRbg0q4hMDyrJ0nhYQwb1piqNP37k00+ehnwn6Jv9kn62+1eA?=
 =?iso-8859-1?Q?/9QcHG1RnzJkgn22DHL+jnufdEZT7h50S5Ig8i5zjnvcs5X3Wp0BGCPKXK?=
 =?iso-8859-1?Q?6fv1uN2BNMZsYnwW2M7Jz5Wk27YJshZBMKMOVKwZbMh0fGfxyqiqLWrflr?=
 =?iso-8859-1?Q?Pa+WMBpD5hnLOQaQlta+8uELIlE7QnGvai/AO536T82a9UpNovfuWAd/ni?=
 =?iso-8859-1?Q?iFteYIvqKp0ebMGw4HYAK0nl7Lf9Y2XzxEMh5z+Tw7UR+qVGp4+2w3ATKb?=
 =?iso-8859-1?Q?y8Z0eqPd2ZoXP08sQK/MNw1D2U6wVS1najEGYCYbnwts5nq2IZgbyrvi5+?=
 =?iso-8859-1?Q?R+lgdgZ7BgubKfEXlMGGjItThksQfp31XqbRKFxyhD3sEYb9TVzQEZqiTO?=
 =?iso-8859-1?Q?NkdHDvBD/v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ngosKPoUDPcsUEQBeUVujgdSSxjEhGHIVF6ekR2eXFZ1bRYvQRi80iX8u9?=
 =?iso-8859-1?Q?siRnmyx2KE+GaHeOh816gDW7i7hhbCebNccqDdsEGip8hqsDWJn37sxjO+?=
 =?iso-8859-1?Q?2Af1JqSBpDGeZcphurcEr/f9nz9WkpfcpfpWtrLi/EAuzl5/AUqnVe5dmP?=
 =?iso-8859-1?Q?/grJdGzBBWBykeTNkCN8R6QI47IqQHWhzm9srpcFRBcPR2n9QbqiCdW1Hm?=
 =?iso-8859-1?Q?3H1Bmyefh5gaXt3BgmeCYtmUrtfQqs5EZs8IoRC2jaZy0QO+U4mqvnN1Vw?=
 =?iso-8859-1?Q?P2FCLyGD5rUSdITYNP1Ol6tOxgUKKPlOvBrA43jyHBmKdD2m8hTjxN9sG3?=
 =?iso-8859-1?Q?TxHHBkFsQEuL+3v2+0S2VVykIj+A2/CspDGPrEN5ixWmS5eHMRI7xFMDIu?=
 =?iso-8859-1?Q?FuN1CAx3G8lA808S3IJXdWRV4qBfuoT4v4ZEfU1vckg36y5udY0TyBrOMM?=
 =?iso-8859-1?Q?+yI63HXEktf01PynIQPErwjxYkl/UGgblW10feehV5/5YKss2dlNzL5BB+?=
 =?iso-8859-1?Q?8MYBxHDVRz+406QKCbNtP6Ay6zMR5bJ8/7LNeSODHz9kXfLXFm8NH1RH6X?=
 =?iso-8859-1?Q?gHf8pu2XlnpFEURVzAzwY5MWzNRiagJcp30cxEnsULF2zFXm0+eq3vCsj0?=
 =?iso-8859-1?Q?mTbYQslhet7iFWrk9hsy9yhmDAn1NWXhjsDLXRiNXePLWKBmgIZcvfSkdU?=
 =?iso-8859-1?Q?d1dZ++4JCDobcKQIJJuXQsgA1175rDLSwMPXj8fI7dzjVSLrpERFTNM8V8?=
 =?iso-8859-1?Q?e3de3QC7XjUx5MGJ28vGGrs4zICTxL0UgORx+1vrc+JGurmRLC4vUJHw/f?=
 =?iso-8859-1?Q?sN4vVHTlPzHAgt7VfwCoSePkaG+Lf84dngNePMEF3U54psqYlrn0YbNHc7?=
 =?iso-8859-1?Q?usITmWpZJo+YkTvt39Mez84APDaqtBqPbiG6RU0Qyv60FUhs2sGPrcMUxK?=
 =?iso-8859-1?Q?+7PyptT4rEs6w019aNkjLLp9Q5t6PK5kIEL8zqrAwLUUaBYupAowtDxOMM?=
 =?iso-8859-1?Q?ScXsjRHm5rEept1ZcUazuOkzJF7KwXPxlKT1rCxGtoBFfxvzYQ2rndBUp4?=
 =?iso-8859-1?Q?dwwUDWgbAbvncdsJXnK4i1btMUnXoNiYGhPIUwh8lnHF3IoFJ6Dv5UysB0?=
 =?iso-8859-1?Q?RPJlfPVJk5TMRTm4sJxRbdoOp0z7sMJ9Y267ed+P04urCbx3ZKo1fnbYtD?=
 =?iso-8859-1?Q?Lhu/1MKOrT+u4yPNGqKv+CEedYeAruwLQn5D35s0TFWRcsiGsH0YywEQjr?=
 =?iso-8859-1?Q?J48Wrf3fNJ9obp982OvR3A0OOill60tli62p4PwDEo3d78nXxUG/Pr2JNr?=
 =?iso-8859-1?Q?1iRDCQl2L0NIB/NGZ742CuR2NG9RBOGELp82vYqTNZvMQzEk8HLFlA1V1l?=
 =?iso-8859-1?Q?02GSX0hvVQSIkDLEDrOAXHBXoo4T74cMat/ui3n9E2RoWttzrNBoT0R3y3?=
 =?iso-8859-1?Q?VpuoqiEraeiobmts0OwxeqMIJ0vJ6xlskofwRlbhigPhZwMZCrJUbVbmAJ?=
 =?iso-8859-1?Q?ylpKffGp4dtj1N3XQt6GKZjBpJNBcvlRp6CKNu+Faa5WI+TygSs6wyw+lg?=
 =?iso-8859-1?Q?gYIG+lnF37s9F18cHR+2YYOrd9VAcaRkPUXqezXpXzlR4yWVLI7/fLa+dP?=
 =?iso-8859-1?Q?9nP6snNIhsXMnMUXtr6Zmwi+hDIGQZ0AlTi5AZ7E505a9vRZDjTj0EsQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c93a9d-03cc-4e56-3d68-08dcb48bbb4c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2024 13:45:41.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9045IMTUS454HFtc88Vgt88E7somaByszGb5s/Ybr6KVN6ry2OpqMJ40iR5Jtevssub9DN2/Z0hYLKIRGKPntQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6437
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 25.9% regression of rt-app.rt-app-thread2-1.wu_lat.average on:


commit: 2cc53c6bfe4bd6a39e9420e5b416e43344bb4482 ("sched/rt: Remove default bandwidth control")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/prep

testcase: rt-app
test machine: 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory
parameters:

	workload: spreading-tasks
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408042135.26c3555-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240804/202408042135.26c3555-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/testcase/workload:
  gcc-13/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-srf-2sp1/rt-app/spreading-tasks

commit: 
  add53a6969 ("sched/core: Fix picking of tasks for core scheduling with DL server")
  2cc53c6bfe ("sched/rt: Remove default bandwidth control")

add53a696923bee0 2cc53c6bfe4bd6a39e9420e5b41 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.03 ±  3%      +0.0        0.04 ±  5%  mpstat.cpu.all.irq%
      0.01 ± 11%      +0.0        0.01 ± 11%  mpstat.cpu.all.soft%
    950.00          -100.0%       0.00        sched_debug.rt_rq:.rt_runtime.avg
    950.00          -100.0%       0.00        sched_debug.rt_rq:.rt_runtime.max
    950.00          -100.0%       0.00        sched_debug.rt_rq:.rt_runtime.min
     33.55 ± 16%     +37.7%      46.21 ± 12%  rt-app.rt-app-thread1-0.period.stddev
    137.70 ±  9%     +34.2%     184.83 ±  5%  rt-app.rt-app-thread1-0.wu_lat.average
     30.18 ±  5%     +72.0%      51.89 ± 31%  rt-app.rt-app-thread2-1.period.stddev
    146.41 ±  2%     +25.9%     184.29 ±  4%  rt-app.rt-app-thread2-1.wu_lat.average
     25.19 ±  9%     +67.2%      42.11 ± 26%  rt-app.rt-app-thread2-1.wu_lat.stddev
  10482415 ±  3%      +8.7%   11390605        perf-stat.i.cache-references
     16774 ± 14%     -19.1%      13565 ± 15%  perf-stat.i.cycles-between-cache-misses
      2.46            -4.5%       2.35 ±  2%  perf-stat.i.ipc
      0.12 ±  6%     +12.5%       0.13 ±  9%  perf-stat.overall.MPKI
      2.30            -3.9%       2.21 ±  2%  perf-stat.overall.ipc
  10315907 ±  3%      +8.6%   11200002        perf-stat.ps.cache-references
      0.54 ± 45%      +0.3        0.81 ± 18%  perf-profile.calltrace.cycles-pp.sched_balance_find_dst_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone
      0.54 ± 45%      +0.3        0.81 ± 18%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64
      0.45 ± 71%      +0.3        0.79 ± 19%  perf-profile.calltrace.cycles-pp.sched_balance_find_dst_group.sched_balance_find_dst_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone
      1.20 ± 28%      +0.8        2.03 ± 19%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.31 ± 20%      +1.2        2.49 ± 26%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
     19.35 ± 23%      -6.4       12.98 ± 22%  perf-profile.children.cycles-pp.get_signal
     19.40 ± 23%      -6.3       13.12 ± 22%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
     21.78 ± 18%      -5.7       16.12 ± 14%  perf-profile.children.cycles-pp.do_exit
     21.78 ± 18%      -5.7       16.12 ± 14%  perf-profile.children.cycles-pp.do_group_exit
      0.08 ±141%      +0.2        0.24 ± 38%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.22 ± 54%      +0.3        0.50 ± 48%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.22 ± 54%      +0.3        0.50 ± 48%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.05 ±145%      +0.5        0.60 ± 10%  perf-profile.children.cycles-pp.update_rq_clock
      0.22 ± 75%      +0.6        0.84 ± 60%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      4.62 ± 17%      +1.6        6.24 ± 10%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.22 ± 54%      +0.3        0.50 ± 48%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.03 ±223%      +0.5        0.56 ± 15%  perf-profile.self.cycles-pp.update_rq_clock




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


