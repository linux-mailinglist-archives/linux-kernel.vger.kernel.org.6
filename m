Return-Path: <linux-kernel+bounces-260553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AA393AADC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B301C2283E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3404AFC11;
	Wed, 24 Jul 2024 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzLAR7KG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C9D53C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786545; cv=fail; b=cFK8KITZyZiN9Qz5VL+f9tbwouuFjzC/HWW4WHPZKf+IZm58MWPRWQjisYIUoVD1SnVuVZzhtL1k5m8osWYUzN/eE9Suwxralv0bzlWIEh2BzLjjpjnY6sSIDA3bG86Sf3B3NJ72oOVNKShLBBFWpl9AVBh24H7ZkoARTjPW7yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786545; c=relaxed/simple;
	bh=hmxzhhQczBdWXGR6kVjAzBmXzAE+DB8hBPF3yZgIEf0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sJSAoebILZSF4G7U2ws7/olb/C4aGy6L/4zXgDL0eHEe0ukts8c3Vxzzkrye0j3dIvGh9App8DewAhLj8mOpj4ZJtP4gRS1d4U95u1xb68hJuSV5pqHYnG3aGLqEuP8b3Vdhg1x7+dL/WaB0P0w3KklWZu7NWI+45wxNi0OidNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzLAR7KG; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721786543; x=1753322543;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hmxzhhQczBdWXGR6kVjAzBmXzAE+DB8hBPF3yZgIEf0=;
  b=lzLAR7KGw53Ks0i9KYVS6aB0fSHWrkQxdSuT3RHHcKolmuv5lRCtPnfa
   aHXvqndeInTyPESLQ4KDvqMByjoKQdtq4t+DGTVwrraNFsnvuD/bmPUd7
   hCDZC360SloMXz/THXtuBhJB8big6rNAOl6iGgIc6mHbN9+upioPU6Ofj
   xN/E0bFLGq2xrbXxbbtBiEkO7qzpYqzbGzbuatQiX3xNl4+szYCFq4SIU
   CFmWV2NSF9g80jErvhKjwS8KK5FmdffMDisA/oiJ1HeZyKNMQ6oZXpeeB
   lu3DGSTUC3JpQLJ4TPUF4RoGMNFROMT+ysSd8vKVDG9wAzdsFVnrntFAR
   w==;
X-CSE-ConnectionGUID: tlxlBHntSdyTRBp34N0vJg==
X-CSE-MsgGUID: o5POwGvvRxCVHvG+F2KS9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19404130"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19404130"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 19:02:22 -0700
X-CSE-ConnectionGUID: L6Xuq3kfQSCmKQY2KB7RTA==
X-CSE-MsgGUID: OfspGT3EQwifk4FJdvVeDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="83059880"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 19:02:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 19:02:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 19:02:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 19:02:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 19:02:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzr3G4S9tD5vSaAGr69etwmvtdRokYetBmWFFrkIKvnFcoDjQMoxyUZUGWNwu1dFKnuyKydSkYx7jvQsnOLZF61xUdt8BzOqpG8iTRFwioSuVh25vCnwKO/XU0EKYMvlrzE7A8fjfC5N2yXM93oTmBKc4CwQy/boYEwo5tRvqe00F3O9AO5hzzvV8KzbZijF0qL1QoC1NKTUDQqDy5BL+xp0YUb30uh/3B2cvu/NjOZ6kQAptVuDVPGzRkuVWCaFU4JsAlKcFmih5m0Tu7trorIYgz38SoNOmmwscNORTy8WGMNDpiQs4IqwYUTAaFsmV/yc5k4Qlk/Xctxz8RnCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brolCQHjvGEhQMXfL93y57y9t6eJTJ8wlxQs4h0tzTg=;
 b=a5AQy/5BdxoWuqsRgEDI5VuIVDGmlpgtUzgqf4trmymjXFJpYoElWYl6lCRyEYSL9rf4+ew4gi1pVLibFOMSKuoQP4zMRqxVXhChVqA06z3IagXdTmhPYD3uQUD5OZJ4s1ZbSA3RPLSanKoNM7LfdKLpBj1ceypDYcS3yHe3wkQu98NnwYulmenW5FCTlpjE007rsMZhgp0MWJsRXjX50l8iu+3NF1QPgX71qwVP5Hg8LLck5S5mx0gYEAlKDDIY70d2tqYpP7KzSLqlw2O6jZmnURx4Soi8ZJ9w1unj8b+krkxaH8Peh9WZaOsARwfbuNxjy83mUD6gWO9qidiDfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 IA0PR11MB8304.namprd11.prod.outlook.com (2603:10b6:208:48b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 24 Jul
 2024 02:02:18 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7784.013; Wed, 24 Jul 2024
 02:02:18 +0000
Date: Wed, 24 Jul 2024 10:02:02 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Josef Bacik <josef@toxicpanda.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.com>, "Filipe
 Manana" <fdmanana@suse.com>
Subject: Re: fs/btrfs/delayed-ref.o: warning: objtool: add_delayed_ref+0x1ac:
 unreachable instruction
Message-ID: <ZqBgmtx5XUHHK2PZ@rli9-mobl>
References: <202407240323.OFy29s1f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202407240323.OFy29s1f-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|IA0PR11MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: da65fc38-9ddc-4775-1b2e-08dcab84a547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NVwC/vIBzlMAUWnHX/vuhgsKqZ1io9kY4QuYHeBGZYxfwaGP1AlLGpJ+MfdQ?=
 =?us-ascii?Q?IMqI/hy4Mpa5/Fyzsmkkot58xZVztXt3nJcok/c8/oIqBD1idHB58sLkSz4+?=
 =?us-ascii?Q?Owqh2zIyUBnRA/6OHtPxSnJsiNNjpOI2MbS5B5FBPFzjH5AlBjMZRuYWzmcC?=
 =?us-ascii?Q?q96VECZuYd+BKAna9c19YvO1bPnnOcLWEcl4sMQa15waPqrzK32+cdxfGpqy?=
 =?us-ascii?Q?A3yUPLli4X/O504ibVUqXDvsX8msFICAopeTY8mG9zWtnMYdxWnFnOWG9GQ6?=
 =?us-ascii?Q?KKoCrk61pl9qYisPdyEVspWJlZj9u3InxLr+pDZP8VrC7KyT50lw8bFqZMej?=
 =?us-ascii?Q?OIOuYau9GhLgq9XRUPBqbS0hEvWyv3pHUm6lGPu6iSue9xVsobDS5pgnik2Y?=
 =?us-ascii?Q?CJoEqZg7zUJ0hLFWNPfkicfostDmhaPSPqiyKmeXFMLielBI891UpOaTzeZS?=
 =?us-ascii?Q?R9Vqwywp1Bh/kUY+ABgV+zpN2tJX2l+sr16KnkHvULlFmNGJ2ztx1zmg2VnL?=
 =?us-ascii?Q?1bPPkO550oNd6gMHKaIHIvEMzm0ZghDFaywMlN+/fKU2Ej+ID0WA4k6gjswO?=
 =?us-ascii?Q?apEtqgCaz9qZ0zwDseRgG9d09adYA/D1Uv4w+sUKAN0lR/of7invYCExfQzc?=
 =?us-ascii?Q?38nylt31ne2KU88G93S2YYnLxkEylz0mv8DatiRSw+xdPITNySsRUuc8bIrs?=
 =?us-ascii?Q?uLDE050WJsuoD9u1GJ2GFNkB9ue7r+Craf1sQHV1ycoMM4EsWf2PWIEVsV9a?=
 =?us-ascii?Q?sE9p9JYpsMyCccbAIqDe1BI+baRj5AHzTJDXQCaIxUJEjArQlG9M6khAQZcm?=
 =?us-ascii?Q?xybXHWawJg9HX2Hc0BRhdrt5tdqC69V4Ew21qjXKR8K/2ghz7ZbXaeHI+U1n?=
 =?us-ascii?Q?PI4W0cePCsxYNDv81UKxSl+L73FlBDGYnSTVNbPik1MaEjR12wzXlXv2D7V8?=
 =?us-ascii?Q?2TjHxYUW1UzlK24KnXO7tgw6+G7zml8ZfPQ8mQJR9G+8hS9SQLF2XJWjk7bG?=
 =?us-ascii?Q?xOTFAZ4jPltfKM7Q7iOwsRexTARJgWmN06JbXK4gIHqO0FKJQj2P+koIRGow?=
 =?us-ascii?Q?mLU7iN9dGJIt4hOD5Ix541bCdVI9OE3bTPpRhbPGGFRbRQslm6bQol7frHyN?=
 =?us-ascii?Q?PNcm9LpEUzvOEaQgwlY/GD3cii7ntOnBrWiSQied7i8KijgieagrIWy2Kc/1?=
 =?us-ascii?Q?UhZ2TXw+Ri3WG79e3wkIr2aNDNiJgAsZpUQIZd+NqnqwabWEOeY+DcusfaWc?=
 =?us-ascii?Q?FsiEtGcdOyHat6w9TzH3tIsH6ZxqBDKHeGphTSUVSBV21wKBK6HcoxgIw1UI?=
 =?us-ascii?Q?6cjXrOyu+zbMsPHL/iRhLchX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qsXH1i1X/pccLU2LeTrOkatKJsU2blm8QmIkP7b/OmA3FoiY+7SBFR6EHQIH?=
 =?us-ascii?Q?6NdlinM8/+r6GDnbKq/qbQ1x9MckyxyiHQv3UX16V8r/uj6pWSdKhq+F7wXJ?=
 =?us-ascii?Q?WAfbEF4ukbmui0ij4BBVJGlIDeA0QVf5sUa+nU9q1inWbGGQ76a7PzItFej/?=
 =?us-ascii?Q?m5l3sCSsBnii11k+q8PqYWt9h0GIpn+Zeezk+1R7enVllLnj/YfhdmPR4h9y?=
 =?us-ascii?Q?y/ZCwXLrxlB9YUheXRuqSIK6Agq8oOVIEZFcO/cMOWHWv/B78eP9wy3annX+?=
 =?us-ascii?Q?7gwNXHi8su6AbT1YuRaMDZ9wlk7wdsp31tB4LMKRDGGuo7VkLLEVhk99Vh9u?=
 =?us-ascii?Q?WIJiFygFotfDxdvqtku9rID9xrZCoDO4kveTrvh9JyGFZnMq0RJvv0XxOexk?=
 =?us-ascii?Q?YGtKXqVb0EYRsFk6WRD22GRFlaqXd7buHgqQWq7gypW13W/H8YBdT8cr4jc/?=
 =?us-ascii?Q?VHycojsVHUNhDlawQlKXK0DOb/ayfi6zhXcIgneNdEhRRy+pxnQ5No0KlWlY?=
 =?us-ascii?Q?AWun49DzV3+VS8Iltf+gI/VVVc4BrcK5uBOoKHY+hCu2sqhI5Wn4DhucjkrG?=
 =?us-ascii?Q?IiEBZ7u7yAysF7KaweeZ2ppp4/kIGH/kY/X/rrMGtNWLijaYTG8SiHhHF3FN?=
 =?us-ascii?Q?blK/xjFZxqM1yIEsfDYvsQ+H5XYs9lsqB9L1tv1BL/NNuDRihTWSt3zNsGLz?=
 =?us-ascii?Q?et62AzK69DR4blD2MO4MVNrYprwwEaO4Rv9Z55Ax0gx/GxYCZKo3wJZXtimQ?=
 =?us-ascii?Q?4zzgZ4TRpSj/zzEAwbTol9JcpMa2EFsgDNtb61yhbYO+7wHIiBxNb0Wvve2k?=
 =?us-ascii?Q?SMntNXBE8XicAslpYe95QV6O+iv3ixxu9ef96VsAHqw1h1S0xRmT4hAB2BzW?=
 =?us-ascii?Q?Sltqj/B8e4tbCfMf8gtkpEpvh5bNE7CWAlaaqotXpDnbGnWLRtzet/w+Axol?=
 =?us-ascii?Q?3bJwnF4hiACgRXtxGTNHrgfBFthl5I+Otp9Dy/hU8BCgqJVVpOmhW4WaYnGi?=
 =?us-ascii?Q?zekzbd3+mpYby2tM7UnhWy9bss8TuK2rB6VZKNggGWo8KBun5xsH7jpKmyeT?=
 =?us-ascii?Q?nIFWygPvZn0uWbhqp8nuVdAeKMIy7lJMfLxd02/vf87tjPF8lTkhy0fY2wVs?=
 =?us-ascii?Q?WE/C19djAg+bdGzhQtl6PWhltwi6BgTDv9lLD+DT3Xf8XX1+NzCfnwlCuxJX?=
 =?us-ascii?Q?ygx1ZifSJEYrlDIzYpSVih9mmlV0U6NRT6mWmIM0V7eevYn99ZizkvRfLACG?=
 =?us-ascii?Q?vdXhQJ3u424Fpyzz0zrqcQyluULK/EjH8V+RGHqJ8aOYa1o2h2AXZpys6tjg?=
 =?us-ascii?Q?y7LnsDndnhQZqGW6i+1w47hJbBwaxGQCGdB6mlU8Fiap83jCHKtrqBqXVt0F?=
 =?us-ascii?Q?kdelDflagK2YW1REoc4RRPq00y5oHxFUbxPq87JTmyxcZWXCrWGD7k6pKUa4?=
 =?us-ascii?Q?qNr80jfSiF4SjTsoBqGwwxInsCRwzCyRSdZYqkgtt4cTUAfnHagat2DunQLI?=
 =?us-ascii?Q?OggGWd0rkZ3CZmNRXS4LdnCiUUWqbxp31CAGLIRnPR8px2494GEVvAohFScG?=
 =?us-ascii?Q?qGKlIb2Ue/vfqw1MsJZ9Ar4Y5hdsoHB77pGPjyoN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da65fc38-9ddc-4775-1b2e-08dcab84a547
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 02:02:17.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+y+jm2bbjZvJ/Tz9gnx9Ow6fe2DH1ISCdy/MDHhu8/vWphU9b4xWsywsMPkfJTF9tDJhxzrNc+7+FNCCKPSkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8304
X-OriginatorOrg: intel.com

On Wed, Jul 24, 2024 at 03:02:29AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   28bbe4ea686a023929d907cc168430b61094811c
> commit: f75464f7bbbdd3bd63b91a1f023e26ef85e348c3 btrfs: unify the btrfs_add_delayed_*_ref helpers into one helper
> date:   3 months ago
> config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240724/202407240323.OFy29s1f-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407240323.OFy29s1f-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407240323.OFy29s1f-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):

Sorry, kindly ignore this report which could be related to tool chain upgrade to
loongarch64-linux-gcc (GCC) 14.1.0.

We will further check whether the issue can be reproduced on gcc-13.

> 
>    fs/btrfs/delayed-ref.o: warning: objtool: insert_delayed_ref+0x1cc: unreachable instruction
> >> fs/btrfs/delayed-ref.o: warning: objtool: add_delayed_ref+0x1ac: unreachable instruction
> 
> 
> objdump-func vmlinux.o add_delayed_ref:
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

