Return-Path: <linux-kernel+bounces-301060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6698395EBED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE322813CD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FB213D2A9;
	Mon, 26 Aug 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOZvcY70"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449DB139CEF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660773; cv=fail; b=ZmHUXC/SB4Beavu5k6Pxw+CgSy0TwfwUXXHIp7mhGlIGhBFZ0QUr577go0vDTszDA3EvfnqNICJD2cQiGNbrNAIUYnortPDDaL/M1jdH9aYYoTJ0URlypvPOlLkXk/bTz9toTySDsVWbDtSh//ahbDowZOL3JVvODGDzGPC5pNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660773; c=relaxed/simple;
	bh=fhyQ5PsNpiVzcdDKVfIczU0e4hcNr6JeiKSoQZunYak=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hi4UvpK9rzP+n8EDdgHVy8gSHK2b8oiMjM9NZR+8cRkl6Pinc6+KgonIpDn5vXK4mF51J86adqfEslrN1izNJmpmcmdBn6Eva49eEYCOIm+L36QnYjeCOCwCpiQTORaQJX0MmO/EXeqU9cg1HnW3P4DAX4JoYzChCoRH4bynRak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOZvcY70; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724660770; x=1756196770;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fhyQ5PsNpiVzcdDKVfIczU0e4hcNr6JeiKSoQZunYak=;
  b=EOZvcY70PH0AnART1uf6sGj+d5a83SiaYhy1pPjK+sUYXjuWntk4YpUB
   aMiCMDnsbXTOCIOcY2hifnOCYA1WYEwVJxEGspWNh4rXoqci7FfyeTt0M
   w/qpLj5OjEbLzqUhe0Ddb67LNcp0tRH+AZCoRmO55AKLCfJVFeJQTPbG/
   dFN3AExxY5wGkHpW+JqMByx7mcGfiz7Qxi4FhIINkaM6VfhIp2TFXjHZy
   qsLlSzstCxSxMS+J33qfn1qorP3uZmAKWhvjcCpe28eiWgyHQpWmU9ca0
   kz3aWb+cZejIyKiC5af4HTHUvc67W/J5+Z0RnFYcP6qoaOf/ptZUDYwYK
   A==;
X-CSE-ConnectionGUID: mHEwQmP/QoKSRrVC5hFp2w==
X-CSE-MsgGUID: jCTbqVUJRQKMRqJPK9ShQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="23222499"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="23222499"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 01:26:09 -0700
X-CSE-ConnectionGUID: Ex48lOw1QwusbrXokkl9VQ==
X-CSE-MsgGUID: I6iWrtY8RVeJ6xehj3nkOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="67134877"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 01:26:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 01:26:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 01:26:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 01:26:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=augtZsMpcpjJnoQyYE/AmlzMRrnS34gY9I9j0WIrYBZiAGg+E3CrzrbMnQik+pAnZTqfNzYOh99OLrOjS/6mykAuuhhn9vfUaa9Cy2yVYuiHV3SiRY2lnJ4XYfXeN+R1wfxEIZWTz5oKNnfHwZAa9LS9eZ4SZgYVM0Kf/JY1GQQaUzLeY9WxtBJT8AcXpE7ro1oO/Y7t1nCUfVs9As8DfCibvMnjx2OgfTCNmt5F0HGbjeoniiH9ebKGZpCxaUX8BEWFQgr5HDtDv/Hr7rGHPPx9YrVJV6TUyPv0hCpti5lUbTt07THTmWc0hps4BHGUk21fVn/QWFMYn1nnNKzPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0e/oqcd26xH6QkHFjy0hd1X0C6iejHVgaKvS9QOs+A=;
 b=qB2MUEAx9f9MBmv6B4Wt7afvT8Qn6kJKrPK9W/BJ2whqhmyHODgU5ndEgWsDcHeIh2kKfgMeG/Vjqi1F487xOUDeB9pJp5eiHCMK6Xo61W2pDmfwmrL1PR+pKPgMxtCb1VMjB3JmCE8TenAB9ksHTuZip7s0CH08/caKMvR4w4pHcpS1dKfoew3K4pFQZoKSxldrekuVHmSiDLvKDMJGpDC/KGQ7OmKXTbTEJ1Opopxa0plT1rb5bdwFxKFo7CYTLF6jd33Zp5UYSsT7U5V80gRqOHtWa6BDFGULchIfl2FpSdHHWGKzqMheu5DXOMzroRVHwVTr/wjb6xxdIWpRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.24; Mon, 26 Aug 2024 08:26:06 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:26:05 +0000
Date: Mon, 26 Aug 2024 16:25:56 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Oliver Sang <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <aubrey.li@linux.intel.com>
Subject: Re: [peterz-queue:sched/core] [sched/fair]  420356c350:
 WARNING:at_kernel/sched/core.c:#__might_sleep
Message-ID: <Zsw8FEPMHFe4yoaA@chenyu5-mobl2>
References: <202408161619.9ed8b83e-lkp@intel.com>
 <20240817093329.GA32430@noisy.programming.kicks-ass.net>
 <ZsLNtymGVe5wk5vP@chenyu5-mobl2>
 <20240822154923.GB17097@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240822154923.GB17097@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CY5PR11MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae5c3af-779d-46ee-bc0e-08dcc5a8baae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mSycnVJWAteBXlD1ldai4ZMEWXfSjZ/ShcgMlf/7Qt7GdrBe55QGsfweXMDg?=
 =?us-ascii?Q?kpcUTHQfQukF4QuVyCeDlMyxYRqpEXCHHrP8GgeldRjbYMJwkEmTxE6VuTCC?=
 =?us-ascii?Q?5AW6aEPaolijUWmVpsUOerl/VMq48xUsYB8oCHNUvfgHElt7QYbSWSQy9uH5?=
 =?us-ascii?Q?EDO+xXDqSJ9W3xiqfUBnsxwUjFplk6L7Wu0B4DlBeHSQ1GsyveSPvNoKmfEE?=
 =?us-ascii?Q?VO6M+lV3jNT8iFjnte7jdV1blEAxJWqLMGPsjKqzkSer/Qmc5lGma0h+oJll?=
 =?us-ascii?Q?svsgSYeI+S/7eSm+gASgku9I8C80kB4yjFtIcMMvSNpMd6XrqwsCfy55XTA+?=
 =?us-ascii?Q?zTzSvy9l1l1RLxd4m2Pt2cjltYtakdY08OVz2M0xBQcOsF8QAY+S/T7KU+Xv?=
 =?us-ascii?Q?0JWWfLuQzACLy6l2kSv1pyxrxsFrJeAj2iqvYgJPiI1kZxfcwvrdql4O+QRV?=
 =?us-ascii?Q?7fEnNGOfr8yedzJX1XNokPcxgu5C3iaH3FwLj9t6QuMPQ3RQi5iuOoENd5y+?=
 =?us-ascii?Q?iZ8/2z86amChYH/wwq9O2eXqQrhJDJf9n+Xkc+DcgCDtBONAREAdxe9NV0Z0?=
 =?us-ascii?Q?VpAJVjEdebZ0MvFxqRJ0xd4KdKZ4HFaRSVFn4fuotsfeP74e5yrtobHsD/y9?=
 =?us-ascii?Q?colYgzi+ib4Ho51iJ3BnBDUjCOByZ7j8xLww6osSGSXGO9lhN1cjb1z82+Dj?=
 =?us-ascii?Q?alw938E4XdMFtHu30ufiILBoAPy35T2mpFbx5s7Db4AZtD9Bi8HEF+o51Cwx?=
 =?us-ascii?Q?vgemT17JQ3dAPfGxhLLn3E8gcoN4q8QeBy4XaCONpcxkGWGVsS/s1kGUHgS8?=
 =?us-ascii?Q?YmvGS5kKcmILBFwaeZJO3CyDxZZff7b08a2cjQeh5KZhtUCdsYNKquREL8M6?=
 =?us-ascii?Q?OlqiK/cAZyX5trKR57UULiU5hbdNgBH4faQqHVLYGJdTA5WnRsk6xDj1J9T5?=
 =?us-ascii?Q?y8CgrCidFtbwFd+oISfTgtuCDQoOyyGUCHxx3qOIBcqagJFWOuEeIzgbSLfO?=
 =?us-ascii?Q?rWHNAb+4J4hXeRx9OTHrHbzB9UFDHc9BZ8mZV1TLXDtm1wi4E2rz4aBaK78l?=
 =?us-ascii?Q?3ywLboFcPnbCrWWicfNjAKbnvJggSR8XeemtNTadfLYF747iPDeJxU4oUH5+?=
 =?us-ascii?Q?RYn5MSXgSf9dnhn/yGskzx5vUIwQQX0m2Ze94C+V8mUo3K6lC8zoqhDTaStS?=
 =?us-ascii?Q?iTH7LmSuidc7Qb+kXqPNZOYQ6gW0aJAB1gwcSMDi/4DaVBKiNuKOGJr0SmU4?=
 =?us-ascii?Q?9erT0nPcX1z3ebuMQKHcMwR2AR7MOloz6b30fZJQW8M7w9PUnulz88dBwgDc?=
 =?us-ascii?Q?wZ9geEbErsA1j26xGjRVdO5zvAkjLdrD4a3QU4d/LUTv4RMdzPAjiqDt8K0L?=
 =?us-ascii?Q?xiveLAw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fr52T0Gdhtb1E8rw5osoIo1iid8PwDr0WJ3ENWYo8HKs7KoVO7LB2rwWHMH/?=
 =?us-ascii?Q?ioftgxIp4LoG1Pg4UTD5ahnjcXwUm6gZpP+wLLbz+y5jaYm5JiHseh6f9mjy?=
 =?us-ascii?Q?Xwmbyp0gN41fPoFe5lwDH+C25ga9AwyFWeWKozuODQ/TSyiqeLZshCABX6fw?=
 =?us-ascii?Q?PoBjNjvlh9V5eWucTxJRXOOhpv7A3Tu5d/JVpXjdHWgNVfdUS9sAC2T+felT?=
 =?us-ascii?Q?Mn0pm8e3JO1146Br931YwFfL6D+YDed6PQBzT4ho7YfMcBt1mXt86vIhG/Cy?=
 =?us-ascii?Q?0QiH5jkqIbl2t2X5p7Sd3Hvl7G4N0hZwZMf2wImxYDro/UtIi6cR9+uw+v9G?=
 =?us-ascii?Q?HBF3BeBG2gdUv5DqeQUzBF95orEtKGU1U1xjAifnBLCPmfYxSFpBg7/WFhcz?=
 =?us-ascii?Q?Jmo2TeNHqvpk9xcv9EYoXp6TuswBUYC3ajAbr46k2xWdQ1Tzmg8lpnIqqU6c?=
 =?us-ascii?Q?kv4H9FGLUChV0iwLDoZ/oiu7BJYljJT/wi7MIRtg51yuqd0k0MjQ+FeIDAw3?=
 =?us-ascii?Q?42U6FsLy9JBj9auA/2DkiO3BTbt9l8UGQwc74x5K6tGkKDGm5ZuwO2EThKo+?=
 =?us-ascii?Q?YH6F9YqzDY4YQnE08l5FOpC38PyEvun++lJ0Cjl5e0YtLLf9JQcuJDZ6N3ZX?=
 =?us-ascii?Q?5y6YtWjdrzfETX1xojjEZviW7i1ej2fUp5aPa8PGMJh5hzp/+KQ4DPBzjetU?=
 =?us-ascii?Q?Z7z4++70ftHrObCYzDd0Jj/xxfWua6V6XEMveSj5MpCbj6+kdCnnAiTzHO5n?=
 =?us-ascii?Q?d4MWM5A9SgrVEix/yn8pJpXKCt6wakzqxdbhy16529u45WX3dcWTkOl29kWj?=
 =?us-ascii?Q?K5j4S6/dZdPCK0x7M3Oxb3PcSCZ0qZQPfs66ger5XVBluNK1zo1TH81x/8at?=
 =?us-ascii?Q?iQU6/wcZitGGGshSWM64KH82mzN8hq8QnKRseQFGnwoYuL5XlZGVWkj7uvyw?=
 =?us-ascii?Q?zqy12LItFPIi1AyVcuXPu6OsyqRK2BkjMRy/F30/H5yz/g7Fd1XEy+5/Wk5Y?=
 =?us-ascii?Q?SqOuuHMNuWZ4itmBfp5dniwFxVUWvbmYhF8RQ/huc2W2dSNkMHZMv5AU1+66?=
 =?us-ascii?Q?/egD8COga2LIQN8lIZqh4TP9ZOR+ZhWd/qC9Pqrf9QmZeL/PdaBDABFY21jE?=
 =?us-ascii?Q?bLvDHrZITtj5p5DRfh1FuYBhrwv/Rj/LGrI+vbBv4p+OSF1WQa146GOlHIFs?=
 =?us-ascii?Q?cwwfXNswqR+IE+QANyQwSxRKC1LNEoUjxSuNgmIW4vDZ5rntc6CeYfKOB9Fb?=
 =?us-ascii?Q?3PM1OdYnJzrou3P68u7Zvc585QX6v55RsG63PHCSua+l2jvSNRGEfFIMyzSf?=
 =?us-ascii?Q?2a9EIMcVF5eCCPAV8idNJ2S2SSLUkjpmLRi6qoBODMu2aDG0Yak9yWBCwLOg?=
 =?us-ascii?Q?8UF5HBfOpP9o0btQCLc01h8QRhlRYpJgJOBwq4KYWcdd2HUnHVMnO0ZljsVO?=
 =?us-ascii?Q?S3xA2nAU/8NbylEZPaQ9iu7+QIBg0BYsyr5KrxO1ueXNvQTOXEoe1CBUdYWj?=
 =?us-ascii?Q?fRJxuj+sXnDqg8HzA5LFuuki4rK9KvOIxmjV1Gim3662WZvwQZgfDqNDSJ9M?=
 =?us-ascii?Q?CJR0GxvoJFBCXHUPjcNk41UPJdEjlrDBO50Qaylo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae5c3af-779d-46ee-bc0e-08dcc5a8baae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:26:05.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfQx1X8Qb7M8DgVjMiBO8v+KLSgnm6XomYvGNQzjd+/mDkhunAgd48rcqavpdiMb4V7Jf7gAqJwdRbic57dTqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6258
X-OriginatorOrg: intel.com

On 2024-08-22 at 17:49:23 +0200, Peter Zijlstra wrote:
> On Mon, Aug 19, 2024 at 12:44:39PM +0800, Chen Yu wrote:
> > On 2024-08-17 at 11:33:29 +0200, Peter Zijlstra wrote:
> > > On Fri, Aug 16, 2024 at 05:15:12PM +0800, kernel test robot wrote:
> > > > kernel test robot noticed "WARNING:at_kernel/sched/core.c:#__might_sleep" on:
> > > > 
> > > > commit: 420356c3504091f0f6021974389df7c58f365dad ("sched/fair: Implement delayed dequeue")
> > > > https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/core
> > > 
> > > > [   86.252370][  T674] ------------[ cut here ]------------
> > > > [ 86.252945][ T674] do not call blocking ops when !TASK_RUNNING; state=1 set at kthread_worker_fn (kernel/kthread.c:?) 
> > > > [ 86.254001][ T674] WARNING: CPU: 1 PID: 674 at kernel/sched/core.c:8469 __might_sleep (kernel/sched/core.c:8465) 
> > > 
> > > > [ 86.283398][ T674] ? handle_bug (arch/x86/kernel/traps.c:239) 
> > > > [ 86.283995][ T674] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
> > > > [ 86.284787][ T674] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> > > > [ 86.285682][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
> > > > [ 86.286380][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
> > > > [ 86.287116][ T674] kthread_worker_fn (include/linux/kernel.h:73 include/linux/freezer.h:53 kernel/kthread.c:851) 
> > > > [ 86.287701][ T674] ? kthread_worker_fn (kernel/kthread.c:?) 
> > > > [ 86.288138][ T674] kthread (kernel/kthread.c:391) 
> > > > [ 86.288482][ T674] ? __cfi_kthread_worker_fn (kernel/kthread.c:803) 
> > > > [ 86.288951][ T674] ? __cfi_kthread (kernel/kthread.c:342) 
> > > > [ 86.289560][ T674] ret_from_fork (arch/x86/kernel/process.c:153) 
> > > > [ 86.290162][ T674] ? __cfi_kthread (kernel/kthread.c:342) 
> > > > [ 86.291465][ T674] ret_from_fork_asm (arch/x86/entry/entry_64.S:254) 
> > > 
> > > AFAICT this is a pre-existing issue. Notably that all transcribes to:
> > > 
> > > kthread_worker_fn()
> > >   ...
> > > repeat:
> > >   set_current_state(TASK_INTERRUPTIBLE);
> > >   ...
> > >   if (work) { // false
> > >     __set_current_state(TASK_RUNNING);
> > >     ...
> > >   } else if (!freezing(current)) // false -- we are freezing
> > >     schedule();
> > > 
> > >   // so state really is still TASK_INTERRUPTIBLE here
> > >   try_to_freeze()
> > >     might_sleep() <--- boom, per the above.
> > >
> > 
> > Would the following fix make sense?
> 
> Yeah, that looks fine. Could you write it up as a proper patch please?
>

Yes, it should be a race condition in theory and I've sent a patch here:
https://lore.kernel.org/lkml/20240819141551.111610-1-yu.c.chen@intel.com/
And Andrew has given some comments on it.

However, after I did some further investigation, this warning seems to
not be directly related to task freeze, but has connection with the
delay dequeue. I'm planning to add debug patch and investigate the
symptom in 0day's environment, will send the finding later.

thanks,
Chenyu

> > 
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index f7be976ff88a..09850b2109c9 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -848,6 +848,12 @@ int kthread_worker_fn(void *worker_ptr)
> >  	} else if (!freezing(current))
> >  		schedule();
> >  
> > +	/*
> > +	 * Explictly set the running state in case we are being frozen
> > +	 * and skip the schedule() above. try_to_freeze() expects the
> > +	 * current task to be in running state.
> > +	 */
> > +	__set_current_state(TASK_RUNNING);
> >  	try_to_freeze();
> >  	cond_resched();
> >  	goto repeat;
> > -- 
> > 2.25.1
> > 
> > Hi Oliver,
> > Could you please help check if above change would make the warning go away?
> > 
> > thanks,
> > Chenyu

