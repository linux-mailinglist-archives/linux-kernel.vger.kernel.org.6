Return-Path: <linux-kernel+bounces-430436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008839E30DB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFF62847DF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2685FC08;
	Wed,  4 Dec 2024 01:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZoyaX2/H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97FEADA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 01:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276520; cv=fail; b=ISNvx1OHGVdcZPvoyyXdFWRLqFDCZ0Gt4ExgvPLIR1dXBhfQXh6LmPgtCAy4ebOvim33SpYhZCglJ75fX4OZ0ycCwDFaOQpMJu5KLXiMQuL9pqHw/L25PUatPJWhrB1DEi28jbhghWeIxgOpdz2R+H0dYoGFdHLIeTWwBIyAop4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276520; c=relaxed/simple;
	bh=h/6p2X/SnYLyD0DHlh23/feJi3C8ExwCedLua196QYk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O9ro6Vl0zuiKcSwJBZE6wv5IIi+YFEKMuCx35DgnhNU48b5Pf7KgkEAEts/tvBGlcsBuNjpwTnw3NlqJGwy7B3FoeOf4dXtUkPXze1JfiSeCMx6vCDt12k10uokiMpj80Uhaz8tZtZPNPF/stRocFJHO2OEDQJ8/QgA1NFeLJX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZoyaX2/H; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733276518; x=1764812518;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h/6p2X/SnYLyD0DHlh23/feJi3C8ExwCedLua196QYk=;
  b=ZoyaX2/Hh32pvJ8/YSNsBqywoFLQ4N1HVovTrdCUZ1YrjxBeyz+beySz
   b4cX0gWOHl6qOyb2TI9SdZr7Qq9BmgainMcMdyYGusvHBmkdzwTjtcBsj
   CAB0CdGaHZZ65s3cQ2nuY+HPw939QqH12qFnSUoMEV5hM5DkW1vVxj5u6
   nhRuiNMw805cjyyS9J61NV6ZYLQev5pAZ/gbaaEOu9muywDinaFST8CET
   /xtYsYJZOR0rbnRGDUptiIjX6gHQ38J4y3WW5L+KDLBSSDcxFFn74rcvj
   LcgrtwkpTjhewi5S7POA+RR+C0fc7LNQcEdg95nQ3386mh3FqCJx7OgMu
   Q==;
X-CSE-ConnectionGUID: 1waE4w/GRd2UuQuhOGN5MQ==
X-CSE-MsgGUID: bY1Rsm+2T0KazireMGthTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="50937273"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="50937273"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 17:41:58 -0800
X-CSE-ConnectionGUID: rp5I2h5zRMG7KRnEKkiyrw==
X-CSE-MsgGUID: vNowi1PZSoeU3gN0RYlfug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="124556823"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 17:41:57 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 17:41:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 17:41:57 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 17:41:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjsewFeynrt0H0SrbMZzKZO0liniM8XtBFOyncmyrqlxZhOiZZGRPwyAlPZwhqZd6k8v+wt5I0T0K7w7Cxv7epLMGFFh20/CCSISqLFlUbDjqK+qTg0JcRsKzNBIdN/ox1BP1TI80wNgIG4AyuAe5MIMdCRCVWcWmQpUXopD975E1J5eHSHU3Qhj+biUI4LFRGVVbOXfu+e3FZ6LWP8tapwylcgSRqeFNH1j9UOOcmAfv4bIHYv3nEN0fOJT8dTpPVgX28HqpWjn0CH97V55NSs2ZN5iwB7f/gNVOBM7l+m6edMh24CFShjjBq5N/9j1AWAVdRBFD6bUiUAvfJMzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/6p2X/SnYLyD0DHlh23/feJi3C8ExwCedLua196QYk=;
 b=mwwPIsev1yxkoIhCLE142e3Vc2h7KJcdt+TXBcTt3bo8SgfsokZcPFFikZvS8dToOuAOF1Dx30b/hYhPymhlmHFq6P2AlQulJ06kigtCY/tyvT6w783BYgbq4dmFpbSdr1d4mi15okxdu6xjL/ACffmp0s1g7zNawaGSvd6anjGRbUtcUwQZg5VHBHFNLI4P9Yewjqmx6PayJu6tToKGl3aJLveov9ID08+kQkIsogW8OhudaE5nl02h+QdzxiTtlnJL4xGbwL53pY8C+mBI5wd7YQrbXvxj3MNLNn5NRFDQFzsLXeT/cVCIs1B1iKOJEmSMrBmoMn4tK2obF9l4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 01:41:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 01:41:50 +0000
Date: Tue, 3 Dec 2024 17:41:46 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "Kirill A .
 Shutemov" <kirill.shutemov@linux.intel.com>
CC: <x86@kernel.org>, <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Huang Ying <ying.huang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Kai Huang <kai.huang@intel.com>, "David
 Hildenbrand" <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH -V3 RESEND] x86, tdx, memory hotplug: Check whole
 hot-adding memory range for TDX
Message-ID: <674fb35ae5108_3e0fe29466@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20241031085151.186111-1-ying.huang@intel.com>
 <674fb148d58aa_3e0fe294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <674fb148d58aa_3e0fe294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:303:b8::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d15eb3-8ea8-48fa-53f7-08dd1404d24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/738CiVf04k2yU0qRg9Ckim/J7XpCRltWCcz6nDCv9qTCdhM2zVHqITtWXbm?=
 =?us-ascii?Q?MZqdNH1jcZiMQVIhhj+IU71u3wWF1v8pQCC6JE9qHXMnZPR0Q3wjHWi6IwPd?=
 =?us-ascii?Q?jmKPWdr4gs0QVhRi/qk5O5OmmrgzzCQ7tu/xXL4EyjQaw60iKKH4WAa1WjxH?=
 =?us-ascii?Q?77hpPsoFMWoA7s6dp7ba8aOPdWgs7+gGnKYoPXTfGKVqHjVJAV7S2acIBeFi?=
 =?us-ascii?Q?w0MJTVOqUTXNEXpFsH7DFikEOG4YgseqsyXFmvQS43kskpTE6S9CJQIjQLlp?=
 =?us-ascii?Q?ISSx/viFG7ueXb5cCmS9CX4RSubjbk4LI5MGr/V/pxwSogKvibav8oEeBXZ4?=
 =?us-ascii?Q?FM3JcY/r4jMiKPD7Jxzzi59s6Ug7DJkqm33QJV6kv/g0nDvVVQabkBUIrVKP?=
 =?us-ascii?Q?sSMucdUuBNqCyQuv0RnAxh4NJXTgh11CSfG3V9zFQ+NJ9k/aQ9Zq2ionqasC?=
 =?us-ascii?Q?Nr7QF2hEOyrNEZvd8vSxPZ2S9NxgT15ycqCTV87CGDXkhx7dAwOOFOzGmDX0?=
 =?us-ascii?Q?aSGiiVWpQT/ehdPTfRsvjU1uqcjQEYBwuKUzeaW7LfqhIoMWSl1pJ1yiEuOH?=
 =?us-ascii?Q?/uDejbHhRnQHlgzYEzL9XRfGtX71rIhh35bcocPV6F/mQdbhhgs1etficrY6?=
 =?us-ascii?Q?HeU3vaL6atsEXuLNPYWBUCmMYJlpIY5H5qv1yEjokr/l4l/jWm338zZ3mi4m?=
 =?us-ascii?Q?1tJChLcg6R7CgQKPaBmRyPXy/+NYF4nWWLvmVDietzc7PH/uorgXJGvyPk16?=
 =?us-ascii?Q?PHbaxtx/gN813WjDNdS7c88iN+HMVUEGFu35crzzf4lca97C9DlGp5OmBaoB?=
 =?us-ascii?Q?x+GIYBXrk2xrtRFeF1csUFN7QyYSjOHBhp21gQoBDrIpAaKhVPlt45Zhj8lr?=
 =?us-ascii?Q?isrLUdd083XfRVJbCFb8Gn0ngS9R+o8XQPSr+yldWCr7h++zlOOG1xzWspuC?=
 =?us-ascii?Q?osDaupgxlfv0TtFJJoZS7DBlwvLBQKQUekrqb3+HYaw6DrnxaarhDA/jreQs?=
 =?us-ascii?Q?gFeto+WIJgIYIBARpgA5SVueVniNrdVpjjQzJG3MWUv45hxE52auR2r1ApM3?=
 =?us-ascii?Q?OQKt6eqVLBYH80GLUrsWQlNtRAChhkztO6q/DiSM+fH+yMdQNCVQFTPtejZn?=
 =?us-ascii?Q?R0Mje3Ecp6OYZIguZ3koYcxAhS0UwaOKIwYKoU/E23emT4Q0DNIjGXYTf5BU?=
 =?us-ascii?Q?JICuf6ll4gpbOxs688LCoUyC4jmVTW41eqVsJU7AGbvvXvqexW7ybjjp2baM?=
 =?us-ascii?Q?eHSlDzHIxFuakV8vkHBWzW3JgbOjEdCPlBRv/nFvOqZyyvP8cjYhwMVb5KsI?=
 =?us-ascii?Q?/yqvOH53PGQH8ekf5lANmFd5oWMfKGG5bF0M1f581wIKnVZGPsugGIcoWGnN?=
 =?us-ascii?Q?CbKhwBY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rS8RMt7XeckzyfKelE6okjw4bs3pTWchxKFvbWx57HMCdDooKkf9iW+LpCbA?=
 =?us-ascii?Q?VYLZmFzrnmJgEdFl5Rd/1ngm10K4glC58WXMHOFLmNjotOceozWEFWFPrcMZ?=
 =?us-ascii?Q?pZuQdasH72wy2iPIOcoWPRDiV80TqE/6sqG2ZjK/fTWEP6+EL5NHLX4mfwDF?=
 =?us-ascii?Q?QvOkWRPh7wo2da9t/LwM1HdfU9pK4p33fmKxmYHwoYMwMH4tlDzQ8Yhofl7k?=
 =?us-ascii?Q?aH7MWHPh2rDsGZSWuJg4/7WBV39Dr57sMa9RHPwXkjrgeFsRrR2EGGBaCXL3?=
 =?us-ascii?Q?iRiKfiTBbDpko06kBPYmNh2LJOKJjo1d1Vyp+YBtfY19Dk/C5x2h299YclrI?=
 =?us-ascii?Q?BGWsalFiAm7wdxQbQngU7rqY6Vum/xe3H8VqnAvsDWV/Y3Evnex7/f4ZcOtR?=
 =?us-ascii?Q?4CizY3SUNn24prRl+oLEQdY2ZuXSmF1iD8GM5NZqNCIrROT9AJPUQtSxjgq1?=
 =?us-ascii?Q?/Zy5u6xLV4WPXXNLwl0TGctwprCgATUabz0pIPUMcTAU/hX5E0cjJh82GDmH?=
 =?us-ascii?Q?jJBQQvocXNQvjP1uTPnt1EE8fSzSQ4TWdrQJgmRh9bDrcMGMsOjSPVniken+?=
 =?us-ascii?Q?KxDJ0T3K8wYoAaf8Teyi1qeh1LiAHWd5Px1gKx871cAiK9dD2cDDdyVtizio?=
 =?us-ascii?Q?xtF1TcePd9GKPAeApm0j5uWy6SH8WAEmrEtaf83fNsCV/z72eLNgPe+TKUHT?=
 =?us-ascii?Q?39LHwMtPv2AjcYGNKpjE2mhIqHmTAAQ3j/ERlqSR8GQoeJrT4tctPXvD62sE?=
 =?us-ascii?Q?L+ch1EZuBSt6GTyoGp/aCeH39GMJMZW02MieX8LQGZLcDvWWy6KIXQmrCnSG?=
 =?us-ascii?Q?Dzd5NBF/ZRUFqySs3cl2gFFzBYTbMkkcDiuLBFHa2ZUya4G/dGi2vZ6BcR73?=
 =?us-ascii?Q?MKTRIE5KpH1cK4Y+X7UUn9YgqeXjtAknO1nSoM2Ebr63fB/gzR3OtoIPIc8+?=
 =?us-ascii?Q?AxmvxLV2ypbR9877UNkLHkXyQAa570fYkQr0FMXrpQFWbD4JQcoFDTDbh6g2?=
 =?us-ascii?Q?CmLK+tCdUuGSGrutScDAS9bcXiPAA//h7goFxAF4Hf6c5sXvISYFU9PyZGPi?=
 =?us-ascii?Q?PuQ39NaK3UoJcvEbLpSjjPzkLodlvHpklRPyNWAXI7jwX1vNkI64hPTwbGDa?=
 =?us-ascii?Q?mGj3xyjyr2E5d9aXMIwFELbtUA47V4qbb6c0La+PKuv1VpPWLEVgGvUPdSTB?=
 =?us-ascii?Q?R3jWSpgdehhESDVx2oVOZBx4sMshbdbxKaBeOkXEptzKT4FxLyFNogVKS23q?=
 =?us-ascii?Q?vtqHV5uggFNeAXfyfxQZGHDbADR4XP8p0L79Y+mkqjJLLvILu0z/vd+rLTQp?=
 =?us-ascii?Q?mLx+ktBBz2diHon6dgFqRqazpih56q5Fq3h8V9lrn5Ud/ScmfqrbdfVce9Tv?=
 =?us-ascii?Q?vPiGa1xEgKWr3exop74AgDqI1GOlVLWKA+iLRkQaH0oTCwQq3vc58p5/ez8D?=
 =?us-ascii?Q?EspZzSREx2QDT4ox1ALA25Qt0TyEQLKWPfX0RbqKGUsaI/0VYRaruFv8xbLa?=
 =?us-ascii?Q?ffWNKSHux1m6MVAbh6EYaVgvzUjNIq3pbNUsV/kzxDRv8NrFft2ILzjRj//b?=
 =?us-ascii?Q?hzs8UVkoS7YgbgvdyQ7im5LKW/8RmiVDTfrD4hGOjuonFxnNm2fiY4Mn09Pd?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d15eb3-8ea8-48fa-53f7-08dd1404d24b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 01:41:49.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAL1GQ+vekmNL4LHvH63KP4zS/aaODDbyqsc830SxS6MbHtogSB5O4nNswvjpy7NH4Uj8PHQySxASFwLqL2O2IbmBygqLp4oQU7/tgAWBD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7784
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Drop my Reviewed-by as I now realize that my reading of the changelog
> for commit abe8dbab8f9f "x86/virt/tdx: Use all system memory when
> initializing TDX module as TDX memory", and the presence of the
> "is_tdx_memory()" helper lead me astray. If the changelog had said "This
> approach requires *but does not validate* all memblock memory
> regions...", I might have been spared.
>
> Until the new "convertible memory ranges" (CMR) enabling [1] is settled the
> kernel just takes on faith that anything memblock thinks is memory is
> TDX compatible.

Missed a link:

https://lore.kernel.org/b152bd39f9b235d5b20b8579a058a7f2bdbc111d.1730118186.git.kai.huang@intel.com

