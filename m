Return-Path: <linux-kernel+bounces-344933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C993A98AFE7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AACD1F21BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EADB188929;
	Mon, 30 Sep 2024 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNAGUgZm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204521373;
	Mon, 30 Sep 2024 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735737; cv=fail; b=hiXeayOYBvlqIeIbBTPaLlm/eiLAWK6JUQM8e/t+Zsh5wamEDBiUX09stMqSRS7wgARIgJGqGYC/GArlbjW5S7ASD+Nun5WjCcLYW0XnJv3X4V33JG9NyPp2RP5qV0j+PAFfzfySiC77TtJewkpyRCdpWV4NawMAWGGvVqEiGdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735737; c=relaxed/simple;
	bh=ATMfl0cT5peWQTPNAIjZUDDRx5aB0pcIYtmRKOxUEt4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jhvOBvBDZYlZx4LnANV253YlUzDUjuMflA/x58ABEqQ0REXxXOb4f1/8WytNJ6K4xEBfLyNYzb4gRFTGFZDAbARAgbEuDoIIcPZEo44tu8ev6BrqbHrI5NmJN3yUGav1Ngrfvad5uC7r7JleC1a+UhtgB0N72Ax/toGDT7z3o4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNAGUgZm; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727735735; x=1759271735;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ATMfl0cT5peWQTPNAIjZUDDRx5aB0pcIYtmRKOxUEt4=;
  b=aNAGUgZm2GDCid3tBA5QnMTp0Nqub2Q8Ans79N3vE5b3TKTaSsIYWoCd
   n9lYnhwyBSa7yAL3EzG2wWdcnRlJWQP9eyPk+su0V4GNb1G0ipyw7jJHP
   Mp6yn/vQqIEQnwTDAJJ+aA12cXCNMoSgON3vY5RF+K/CFy+mX2z+4b7R7
   SAIugxu2ikeTeZca/mYvFkB+rJvqd8CwoFA7OKlKYoT3HP1Zb2NOTqDmb
   vu3TKC6QsbnM+r0MlfVWCUhmndBipWIH0f3P+B9m/P9p3/9Eej1JCaEoP
   jkjJmgkX6r7fu2XtFR2++Zi3+ITdcFX03AwTtIvRcRphUfen011WDvcml
   w==;
X-CSE-ConnectionGUID: wY45JUa5Sle3KxXEi9Mgxw==
X-CSE-MsgGUID: nRK7I1aqRbu1y3hAm64jEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26980539"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26980539"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:35:11 -0700
X-CSE-ConnectionGUID: zMH/+oVwQP2SGn7PZjlAFQ==
X-CSE-MsgGUID: f/G5G8XiSYah5YXAhc7IXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="96792571"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 15:35:06 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 15:35:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 15:35:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 15:35:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 15:35:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 15:35:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6b3BL9Zh50ErTmpVji8oSOv/dbsO67h/v9cJdBLrQvyohU/V0R9kvWX69AJLWU/YY1U4ii80mtrLtIAzZlXCNrwQv2MLr/Muqiuc6yqDsZHun5AY/y63+JoHIXsoCTyV9LUDDDE8qOXGHngVhSgeDB1VqM7ctV1YT6+P43z1y2SI4MaaTZJ+4go4uwQHwHMHas/LplpLoMLUT3Xf31uCGOUoKIvV4YgUpO1jdFWDN7IR3c1P9boLm1bQw2t81wIfjyW5sNEjTEj3uDU/qHcEHR9te/2dqjY1ArJ8Ow3INJxMSxrHR0q7e0u4RvF4rDEXIEt1OlvbQPKmUZumlu6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLko8UNeAC416pDMT+koAInF8pQBQBSmrOvABHvZatY=;
 b=XF201sSAJMpW7DN0xN991f6pBZAUnsKiDe6S7JrRV80yxbQUCWZkUNLSpQVm7KAknODbr/+PpHSOj7l1//y2oejEjySKDrHpgqKZaZpLbVAHLfqS3FrdMvjqW/bn1WME2cIhNme4QtRtTPNTxshBq9UUjPquqHunvmHjqySewmY+CeSnTVkkrakdu3qZiqkPoGswhLS+AjN+IXp389dI272Vgj8L7cnG+QChReYtYOE4CQvu3+4Ovks4Z/I3zmyXdPMmzdee40YBvEXHS0mbBca1Cj+KcHXG2EqOjmntfxA6VSkrlnTBj+GjEVIqFq285zQijh7xdsY23rUyUtn6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB7951.namprd11.prod.outlook.com (2603:10b6:8:eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 22:35:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 22:35:02 +0000
Date: Mon, 30 Sep 2024 17:34:57 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: <linux@treblig.org>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>, <ira.weiny@intel.com>, <corbet@lwn.net>,
	<rafael@kernel.org>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dr. David
 Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH] drivers/base: Remove unused auxiliary_find_device
Message-ID: <66fb2791aa93f_a31f2294b9@iweiny-mobl.notmuch>
References: <20240929141112.69824-1-linux@treblig.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240929141112.69824-1-linux@treblig.org>
X-ClientProxiedBy: MW4PR04CA0255.namprd04.prod.outlook.com
 (2603:10b6:303:88::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 986eb11a-a5e8-4232-2f15-08dce1a01fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JgpmEGK8/D3i39JQM/NEqNizPcYN8A5IWiAoXqU1EnT+3OQ4V9NMPQ2gJsDV?=
 =?us-ascii?Q?HWqBe0OhDVrkyO5QB6hEU2/yvXFi1+TSoQGdpQDpE+uXFNc2amsNZk1VU2Ml?=
 =?us-ascii?Q?95OESlpUDGQ4NZeH6qo+C7OhKcwqlgO82+tG8stUPFtPreUhfDfuyxtRe7Z+?=
 =?us-ascii?Q?3OfgD9qvN1hOQfxh2ahArn6+CIlSETk7wl1lPupndEzVITNPkOEZ1Pudlcz/?=
 =?us-ascii?Q?sZFklATTUxJhEtiY4S5PEGjo21kC2tNN5vQXj/y8cjrVpHi5FB8EPKtn5xlW?=
 =?us-ascii?Q?GMTV/2fN799rFJctDKV+zHquCoF77IgoVrYa6zWrmonI/Di3mliM6OcM6h92?=
 =?us-ascii?Q?NjMzAtK1DsCKzjBHxz9hdW4U9k3SetMPhg5NWiBXPwTpQS1Ht36310dXtjRD?=
 =?us-ascii?Q?UH3Z4v9OP8PtxdCht1tcBIErB75bebAhXW3sdq1K0LD7CV9WbYTyTSHcvIer?=
 =?us-ascii?Q?8HIieCrnEa6h0wIyy2oy9t59CgFOtjORjcYEHiRXCSALlu5xpcuKUitDxM1g?=
 =?us-ascii?Q?XzwNqOoX9pvc3+3AHmOjdWRtBNQPbPNepPkkbPBMxdNgadEYVjZ8VvCDMo/Y?=
 =?us-ascii?Q?i9gVVd7e+6PsGFjioCxpwB7BlwYw2i1DAAi7Fp7LPZEFxS8zglwK/kEvkVUE?=
 =?us-ascii?Q?EUltpXEcmsbk9ALqZJvAKHLyExox0/tALVTUhVPCVaug5yFiNX5DcGKUDVKe?=
 =?us-ascii?Q?a1jGamc/2sFmxsK7JIKnpwbx45nDdQbPzbZM2825uBmCMOsY5adC36x/vBrl?=
 =?us-ascii?Q?WkMYFjJc6JvPTuKdrpYNRThgNLc4JatpE0mmAIk7kda/AVI0fyC5W6R048yZ?=
 =?us-ascii?Q?43dPOfGzALuWmJInwaXlC1kkwdx8qjM/IcP86aYkxgEq1h1eyawfT7qvStxs?=
 =?us-ascii?Q?QG9u4uJAuMJQ/MIUMn1nygQadPeu/qMlRGgISjwEwj12EidQW+wnVKzIpWhT?=
 =?us-ascii?Q?a57Aq2pBfjsBv0hXFMfJ2D9lkURfO7fr8Lmqh9FVlNkwxNvQMZHse9erY2J3?=
 =?us-ascii?Q?sk//8Sh9Zj4C2IkhtFL2m2rmj3sDHFFyDrZh68cyhN8MqgwPQNWMM5pGwfvH?=
 =?us-ascii?Q?wNdiHUuvhmjmjkrTzDJ2keklPlokuoCsluxo9wh866KWnYTi2TAhMXiQdRTE?=
 =?us-ascii?Q?BhY3hmXyq9iL6G7bAd6Ip1z1ylyJFY/TaX6lHX3Npczr377NfINBV0pjwd/i?=
 =?us-ascii?Q?9EJJ4Bd0m6iK/U2e1vOUD3MO/TfXCedxMnj5NlCUcifng3nYq7rRVN8put3p?=
 =?us-ascii?Q?CfHUDPPsHsRD4Q6EWTXoscMeE91J0hkwmU0vcJsliA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LgCabZ6Xv/Qm+QPFOyUwBKESSanCqSX8PCbyjn0jvkHWRjMCqcl/Sl0teL7O?=
 =?us-ascii?Q?4TJNPEbsaEmcGYKaqV9CvzHGQcNf4HA9uOlHyDzeTKd4e425ISbkov5juFkn?=
 =?us-ascii?Q?QbGQGZtaIzQ4g52sDFYj4maM9e+2+qRbsYt+5pKQQWvjy9chofO6TIRGkyLN?=
 =?us-ascii?Q?0Ka/qU+g+0RFJuyP8E/Qi8RWQ3527/rzEtpLNcoSVAr6Yk5zAwYLMKzZx4Ym?=
 =?us-ascii?Q?gFDmG1tRAJN5aPoFNo5o6fcs+IMxOtRF7y3JGUx2FJWpRoGxEtjMgBnzc1aO?=
 =?us-ascii?Q?cR4AqOeXYph52sZ1t5YBm9VWsmsCYCHQQakacrIjxLVSkYr02ik6if0Obm5p?=
 =?us-ascii?Q?GslE2PfDO27LOgbLFcRXC+nnQTz8XOsJHVRO8gZiL0VZWmanyLYkfMp3GaUB?=
 =?us-ascii?Q?3zSrmMBQ5rbfLKx06xGSBSbbzQlaLkbat014wG9GKTKaGGeYT9hq30R+bU5I?=
 =?us-ascii?Q?ZuYGqox8qnB+Wn2VlOBWQfWhNhjF6xTeIfmLI3gBAEgOBNgGNXqcsAybivGU?=
 =?us-ascii?Q?gjD9Z8KzgPBibtBiXYSxOqzOFeypC4iDdTlpF+9/Fje4YnA2m82fh86wCifZ?=
 =?us-ascii?Q?yKvNSIohSSZ3CckjTqwCu5HYuOcqngJLpBU4OKl8b2+a9ZIzuO6BMhYhue2C?=
 =?us-ascii?Q?xLDnck+wuNtMsChgC0rCaJQpNbThZRbbQ34GOK/nbKZTdCLeOfjz5RMeaCMD?=
 =?us-ascii?Q?ZPAgxrLm3MgRme4QI3zqiHkfXnrMwoJtPHq41YrQgb8cgRGGjbzMJYUXNBkV?=
 =?us-ascii?Q?wb6GfN06A1fmjdLu3NSZKQ5QxhjMUuefb5qICLbHQ2ahMuYRG2yG4gPRzPKZ?=
 =?us-ascii?Q?EBKmioYTLhU1n078gj+j+/+8c7ouKPfiLcnwreQ5Q8GSR//+oLUFX3nJQv3u?=
 =?us-ascii?Q?cFaiEZHnow7AvffH8iCYXrdZGBzjvHITED7INeCIU/m4G3gckQ+umyhIrtkh?=
 =?us-ascii?Q?iyIBKyD90LUGuO1tKiaFrfJDqcoHzL10mgrxm2aZcwb+KxwLRCUu4VuxCxyu?=
 =?us-ascii?Q?yEOuz69az35eCm3ErXsQsEm9RKGePlVxMrCsq+mNlkJ7l/NiixZqwO618T+1?=
 =?us-ascii?Q?XIr6o5gh5BnJyPH4FRmLwQAivEJfi2htYYOLfHHKyYpPqmosO6jaVRAocaI4?=
 =?us-ascii?Q?SgSpiTZnJWhD3XWSo7xTeMNGIc3zAms7RIZ+NPe12CpaaAr2sOlwqHuitcHb?=
 =?us-ascii?Q?YcNxSzgxT4+su8w83lhXVqtDSvK9bqE0R7poqTFdJeFa7YA7ChdxqhwBs6o6?=
 =?us-ascii?Q?QAEx3qijxM7+J3C+lcQ6gQzgeCwpP35l0hhkR/3z3IX5vWXs9efQW0ZmWqRl?=
 =?us-ascii?Q?BEUX2SqyEOqNkdeYsQFWCn1ES/kPEE80v8Fu0/hBEJ1qCkAhKxeuOjUUE0EL?=
 =?us-ascii?Q?8jJonHYB7rSgLhANcOk1HyRUXJgCunwXFkgMq4S3tWPaM8s3Ok241MIF5eHX?=
 =?us-ascii?Q?WhjUmzqvmbYGiHnQ+i8FEGGqtYyUO87URwwQgCSB7GZgTh13e9bh6KObM5HN?=
 =?us-ascii?Q?WktXYGQtRzJCuEwNrCmFQVGBzC2+U+8Saw8fbVQiPhBby9RuACQys2mU9+EK?=
 =?us-ascii?Q?Scl0U4gBcsaN6im+FaoRIAiQ4fPim1+Psk7SCdex?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 986eb11a-a5e8-4232-2f15-08dce1a01fed
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 22:35:02.7284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 788rm5nSvAX9CVVuwk+HQCG8GTsbetfRIs5inuZNwNL5IeZsAAXXWOLwiPSW4dQ0U+X+JOylHql5xhW89wE6Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7951
X-OriginatorOrg: intel.com

linux@ wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> auxiliary_find_device has been unused since commit
> 1c5de097bea3 ("net/mlx5: Fix mlx5_get_next_dev() peer device matching")
> 
> which was the only use since it was originally added.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

