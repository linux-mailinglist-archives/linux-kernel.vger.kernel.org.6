Return-Path: <linux-kernel+bounces-282189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C76494E0A3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 11:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F9B1C20FF6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AB5364BE;
	Sun, 11 Aug 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7YfHHft"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25BD1C6B4
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723368060; cv=fail; b=bS51y1He0u3gtJyQotbjF4wmMxIbKKw6HiX7Y4BuUoQ0va9MdmKoLrNwRG31Flw7TeJIouXaNSFTU8moJxwNyDj6A7Tm/Hh2xejMh5e6Ci7h5e8zIQknRVhGFTwwld9oDwqdJKktxvrU762es9Eog0aFwN8kLzwt5cMlTq/h5jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723368060; c=relaxed/simple;
	bh=Eh/nPTzoUBgLvxYhVRxrOI0sCzgZ6nKWAWuBzDsEhz4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dYlOL3SwTe1My5wTiBuC01POIU/dsaAytoJH1fGf25oqtz/p/ceN2g2sAAKIDvwSsQkZoCYx6HxZbg3d77fK+h9XZr7qhaG4vSdWMFWuhj9X0SVMtDDi/xSdynyhAcQuw/mlbXqxJ1moewNgB4ZFOxgodSUD10D4hOuA3StPwLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7YfHHft; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723368058; x=1754904058;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Eh/nPTzoUBgLvxYhVRxrOI0sCzgZ6nKWAWuBzDsEhz4=;
  b=C7YfHHftxp5tsGOCkOBTcyCtCYIFcMIFiMIw/b3w/tulirZ45PZzzWWa
   5i4h78XBsXokg4po42HUHb7jxFyQZmZe/TajwV9DWfHz0/ij5jLjsgDFW
   afR9N2hpVX+3q4IBBvOeOR+ka7sj5ldgBRjIiF4KdzgFYPmR0bQtD6yZ9
   LUtKoPHuKC1xku7acCQcjDQ5ca6JoAyqWuRUNAd7/SMF2gWgO8QqBZ5jx
   hlZS5Dro3dxrXA3Txc73tr/sxNaBq4DvPeAenRFWOXX5urqtZ7FejojHD
   nIh0hhUPK8quyEVC2uj6K7aXTEXMqEG/+WR7lsD26s1i2hmua/1CQAgZh
   g==;
X-CSE-ConnectionGUID: UEfhOW+aSiePPGPYVMf1yA==
X-CSE-MsgGUID: V7HLdCZzTi2zetjXQ7u/SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="25356078"
X-IronPort-AV: E=Sophos;i="6.09,281,1716274800"; 
   d="scan'208";a="25356078"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 02:20:57 -0700
X-CSE-ConnectionGUID: +7rTLz8DQZy5wEGvCK1PCw==
X-CSE-MsgGUID: T/cXjLAPTD64Z/EqftHYHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,281,1716274800"; 
   d="scan'208";a="57876369"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Aug 2024 02:20:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 11 Aug 2024 02:20:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 11 Aug 2024 02:20:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 11 Aug 2024 02:20:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlFNyTVMkohDd7YU6pycDNvHINHggRtn6sCEUKAbOK0qhJr7funBGTAwebKmwTFjZ7ZODy9hIsES1yuGr9BskuE8sqm7wfkOLlk0eRB5a0pTJXZKNmMLeRRaO/lgrOywW1TFT4bpc/+s1rW4T6GQvMg5OCyftwcmunxxTxZfJQrhNKePFJ920podzXILxikTUNw4VnZ0dBDFHpFJq3SzEWgy5TsCZm8dsj1VItfvKzUjEBj3PU7N9x3uAgKOgLx678IRDBbSW/Db7//thHWz48enif+p2M9nFnO8XmsD0alha+v7V9E8k7O/TiwsiXjyOfqN5qxkjWoR9U/koZcgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1e3w1H2JhSUsu5Lk+KoLWUiBlL2wdisuq2C4J8ikfw=;
 b=skrr00cP/4//KWG4poj5g89xUzeY0dT51D8tUt7E/MKvHig/YGh6bCm9jsdpxMhRFMS70qd6zeVDkbyTM+ZskBv/TpT/PiZ/zzV4sAWEnou3j8HIyTKhgjxXP5jr9Ap7vy6lU0n40Md3dxMNMWzmtIYhIsKft0NcyS6wng7Rri/aWxNZsJheDNTH3hpvUEOXplmj0yd++HteCVPkRaz4G3NoZ9FAav+7VeG17y80Nu7PJaO56BG1ybY5JQj3Q4faBp0LToZlnvrIC4O4O0q+DXTIwzgMamZRaEKNvwWpfaQqSriJsIfsCVziZ9Tcufb9ul+Gb2yI4pNAP/4ht1yfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Sun, 11 Aug
 2024 09:20:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Sun, 11 Aug 2024
 09:20:52 +0000
Date: Sun, 11 Aug 2024 17:20:44 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, lkp <lkp@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [paulmckrcu:dev.2024.08.05a] [rcuscale]  0b85a3ea0a:
 WARNING:at_lib/alloc_tag.c:#alloc_tag_module_unload
Message-ID: <ZriCbCPF6I0JnbKi@xsang-OptiPlex-9020>
References: <202408091019.8ed98238-lkp@intel.com>
 <045374c6-d969-48f6-acd7-320031961bb2@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <045374c6-d969-48f6-acd7-320031961bb2@paulmck-laptop>
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe4309a-dcc2-484d-4341-08dcb9e6e5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ti44vuyC8d0zC1UeRlxZEh2mORDL+jQ1kIwWbJHYBgu5P9e8Xv6o1HkhsnKe?=
 =?us-ascii?Q?FNJ7eXh15rms7D3kGTFix/EGjq6J/N/A70n0a1l4Yp+NPt6k2aybKO2OfTV5?=
 =?us-ascii?Q?ITCr3BYt6EC3+kMCXly/GcldkBjmd4leKDWz++J7U1/hWovs3xlJZGCHNTdl?=
 =?us-ascii?Q?MMadenI8VrAbO/GvVYn1lLd9hcGN3o+LDcQDabvKYb2099UwAjF368OkFEQ6?=
 =?us-ascii?Q?fLhZ6BlvlPNpuoCkCLz1rTZX5KqJyULJwZTuX/RLAiINDm++YU3ql6fJYXYt?=
 =?us-ascii?Q?YkgvyYlgjDxHEkMgNwmqddqBDQYTHoKTK5PqwL6Ae/SeiUc5IdbJnkFqUonn?=
 =?us-ascii?Q?I3laIX4phiBvA4YIhOUhYaA2cyjzbQpJAVKHzX9v7PMMsJvuTQyW42jc1DlE?=
 =?us-ascii?Q?nYh/M+mFrNV/1WLlRanu+CPr8FT/X/1JQRfi9CBf77dVV0qc06myEbHFwwAG?=
 =?us-ascii?Q?y5c/yzfYVfCjB8SY9eFvX3HlcoApZc7H6tg56vnA09aZOzX/K3GbsC2uh0pf?=
 =?us-ascii?Q?eVTEcylG+wEqWOI8QW5JiWdYNYU2ZCxP8K0c2oYQ8qZyZ3Sn5ppTyPkpADem?=
 =?us-ascii?Q?zISxzAqRmjPBvaYkmuReMCB67XUu+TL79pUh+CGDIkafI5Lr7fn/ExSK6q3w?=
 =?us-ascii?Q?DpMH8HJfMo3PpVyQj9BW9mAYS3fdH4GU5H/KbddtTwCl5px2+EsJidgHT9na?=
 =?us-ascii?Q?B/ijyD1gizP6JA9tX/cbXNfWDF8bCbCnCfhlSSXN4sXldLjynWhvKSfhuoGr?=
 =?us-ascii?Q?w8/oUW+tqYMJ3bbw553YlvkreHRZhcB/i6In8sBF/t436w0OYUEF/JZEpKcT?=
 =?us-ascii?Q?Iwxyx167C0tZvjkbAR9etYCnLcwmJYqyn9k9iOH+o4D2KaZ8a6DMnqoVNLo7?=
 =?us-ascii?Q?QF3uz4nRu6cxjPJKhhZAPBiSIfrz8DAYJSi+5wi9S8KkxmeweWF93xN9AcNs?=
 =?us-ascii?Q?F8rziMf2ou6pva0t4mWYqC1HNK/BFmJY42ivpzYEHWw6rCbRChb3u/Iv01VJ?=
 =?us-ascii?Q?dlnDtSspDBE40Q1JUq5JXrfMSvG/cCJgVbs07+f53S4PfBHfKzuzu0QTzeCH?=
 =?us-ascii?Q?MJiDReCSf6bPmybZ2qBN09kwkVicPCZJaYmvvtbwpqw0cZNSizCeRVYIb+YI?=
 =?us-ascii?Q?8LLwxpE71T4YjKKRGdA8OJuS/iaKWTknSrw+UWAu8va1M338WwGyGr1/5lJD?=
 =?us-ascii?Q?wPDXhhatHod9ptavxpeydMKrIf10crZuE6YXjTwBt5MSqMmz2Hu+UBmZ7+ak?=
 =?us-ascii?Q?tlt+shPREr/euJU03Vxb+amRioGTxdbKIM3OTDol0reC5tQmidjiIjcGvMvr?=
 =?us-ascii?Q?v2g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f/9fr1I5NrMKe5f5LCZoaD+l/9V6O4+E+0MHFVUfLbd0TGT+khYeOLIfhHfR?=
 =?us-ascii?Q?N7Q3JqzZ4oBuuoWaRA2aYwYf+3OMTQqbyY4akm1JUuUE+7tUItY9NIQYACTN?=
 =?us-ascii?Q?TN9FZecTc+eLfvuylHl4HNHU/uL48gsV9r2XeDZzFe3d8dvWHBWJTuw8jeiN?=
 =?us-ascii?Q?DQWX6fsJZVHo7jJtAXkey3kX9z9MRgar4lAGprrMLb4kK/z2fFRxoy210ujE?=
 =?us-ascii?Q?KY73CMUuC3p0rey3pLXGPRZGaVNUNM8/oOBFOvvm+tKf3Nj4zIPKi+wfIHWi?=
 =?us-ascii?Q?t0/JwCRLnz054IL0+fkyDT5BB8ymJB3vgcGll6pQiUgAw/KYnpGTxztyoBWx?=
 =?us-ascii?Q?vNylmvOtUOaEeC74BndmAehw+imCDJRtLGlhXBx6fQeCBxvcXwnTEB4/dVTa?=
 =?us-ascii?Q?q6DRnt4ru9l8XX4XnupvceMH9iwvzZ/8KaDKLp4I1FT72YTpm5Tiw6k/MH1n?=
 =?us-ascii?Q?ocEDoFykIbPvP/PvwmfsLUmATPsm8X+hHIOzMv/4tTl9jZMBwMsPx71fvlCK?=
 =?us-ascii?Q?i5zu+q+bRvlw2J98QD3CsVe8GSrE1ibOw8g2jz+ln4MUK9EYlBwwnMdWu4O/?=
 =?us-ascii?Q?U6jSZGOqULRzxBJSPrSEvhnlNJ44HZjB8sspD7s9xTRjITzpWE3e+H5ckPNY?=
 =?us-ascii?Q?UDyDpdIV/fBJqdIENAX/YeV3nxllw571XlHNWYhpxEOJ15aJKolaqXBFnqU8?=
 =?us-ascii?Q?eXTZ4bNkrslzyubK6saawKRi6z4sv0emFNmTYD+u/4L/R+wBmO0Gywu1B/wd?=
 =?us-ascii?Q?PR3ObhteYZ8ghwYGQD/eSXGw7nGnLy2Q3sdqD3dg9Fy2aE+3YmdRQcRMqh9O?=
 =?us-ascii?Q?gbPHhW7ixaPyjSpK2Rd6+PbAIVAXTsNUazeAJ/TSqw3OfMgTYdHOOwf4+mFw?=
 =?us-ascii?Q?02Rn6l1VT+2T52zme7bDveS2bhlEibhY+2/v2Bq+TEFMy1nlvXkcNLpVah8E?=
 =?us-ascii?Q?XpTWi40cAYpBn/a2TirVrFmwPRP5UE/ZaC8+kaMwWFOQlJ9odj97FexorZgy?=
 =?us-ascii?Q?jgzrodGtTB8HughsDZ+R2W+V+3dna4VB/62+F3TAf8PHZsai97MkpLzdnznW?=
 =?us-ascii?Q?6/TwrlLcsNY3ZnkhxZgwPw/u28AQFRxVkNlzAXc7hmFfhmSJ5l++KryIitYu?=
 =?us-ascii?Q?Hy0DyqK3eBmI8zXocTzHg1lsxHc6vDtv2B1Jtq6FS5gK477QrFovSEL8Omg2?=
 =?us-ascii?Q?LGQChR45HsdUn75pJfCVQI6Q4hRu0+kGeT5GNXIcOyWwt3iMqEIYE/9jYxVE?=
 =?us-ascii?Q?o2aJGdIfWNzBKnP9Qfl/404Jgq6CcZtWDaGVO579IgPskEU/IwB4GIXJdaar?=
 =?us-ascii?Q?HkxlJBK5KC3HYe0raC4/PQbvXI4YcBfolCJDlNpRvWZxPkNieup8+0z/sU8/?=
 =?us-ascii?Q?HJ7ZNqe0haNCpm+4V3AdbkAfn7Q9wJR/JScTRedXiWOrLyfEuFbUxcPLgQhg?=
 =?us-ascii?Q?JdJMx1aRfVqmMZGSaG52KgPbcyvoXL5tNQLKfxx7P0CiPf++gLVeLSEyuLSQ?=
 =?us-ascii?Q?7ZFaQqOs0paYIWl2aAO/Kk0U9PGd8ttpKjaOdPxPzsngxoo0xXiTTlCga2RQ?=
 =?us-ascii?Q?P5f/T4YcAM77lSgqF6+yRlwV7m0OlBWYaufspsIKCve3abq/KBbxogNeuooW?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe4309a-dcc2-484d-4341-08dcb9e6e5ca
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 09:20:52.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jXgj4wYwzANhIGb7I3YuOVYRqut3voUnw19hsXqgZ4rEFLsftFto2v+a3P9UWuBUNLDWa38afzXvZCQysJ7Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5816
X-OriginatorOrg: intel.com

hi, Paul,

On Fri, Aug 09, 2024 at 09:44:40PM +0800, Paul E. McKenney wrote:

[...]

> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202408091019.8ed98238-lkp@intel.com
> > 
> > 
> > [  465.251143][ T1160] ------------[ cut here ]------------
> > [  465.252395][ T1160] kernel/rcu/rcuscale.c:1037 module rcuscale func:rcu_scale_init has 32 allocated at module unload
> > [ 465.252492][ T1160] WARNING: CPU: 0 PID: 1160 at lib/alloc_tag.c:170 alloc_tag_module_unload (lib/alloc_tag.c:168) 
> > [  465.256072][ T1160] Modules linked in: rcuscale(-) torture ipmi_devintf ppdev crct10dif_pclmul crc32_pclmul parport_pc aesni_intel parport serio_raw loop fuse [last unloaded: rcuscale]
> 
> Good catch, thank you!
> 
> Does the diff shown below help?

I applied below patch upon dev.2024.08.05a branch tip, which still has the
issue, confirmed the issue gone with your patch. thanks!


> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index b1c50df142eba..6d37596deb1f1 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -1052,6 +1052,8 @@ rcu_scale_cleanup(void)
>  		writer_durations = NULL;
>  		kfree(writer_n_durations);
>  		writer_n_durations = NULL;
> +		kfree(writer_done);
> +		writer_done = NULL;
>  		kfree(writer_freelists);
>  		writer_freelists = NULL;
>  	}

