Return-Path: <linux-kernel+bounces-388161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8492B9B5B64
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4334C2842E1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8571D0B95;
	Wed, 30 Oct 2024 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXBEvRJ2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B411CF5FA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266749; cv=fail; b=aRwmjKLLnxhLN+bOQURIKrkK+pbiza4Gck8+MuJ8wUXgyUGn6yo4xfHrAFfqgrdNmRkx5qJnjbwfSuDOoNmx5nXOkZOWGAH6yFwosbcVm7BbWNVtAyxhknkUy342SDKcCLwC87k5M05xoxSt3Kqbwjw9iRU8O08IZ+u7LK89NNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266749; c=relaxed/simple;
	bh=kU+PEuFrebbVBCFEARwHms0zKZyZlE9e3pbpYugLc0A=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=t6uOTS80nxUTbBdkjHt6kfDHzlubo5HPxtJo1Kimo3dX6s7TumlfSoVBLWLYpqOZheYDWP/w52N1rC0Hy7qmzvH7/EFDn3u/rozlZX/1ss2zpizLJkWcB1CTA+5Gl5Pq8vvuC3rus4bVixFgHHZiFvzhiZ3O+ZLLs1LPWkmeM9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXBEvRJ2; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730266747; x=1761802747;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kU+PEuFrebbVBCFEARwHms0zKZyZlE9e3pbpYugLc0A=;
  b=LXBEvRJ2+qs+FuUeOH6l4smnUD1PMOxXCxmVSx6UlhrylAlysGshJBD7
   XOThlbWI+d5aeWtgvNU4reQLoAkKUImSDK5kmuZhWca0FppLUj/xWSx2f
   w7ilUxD7WR7Gkq6eaf25TlpBfybqmRb5oZolY4LbQQUPD7tYaEYwl+E7H
   ZFQ999HZli2xRcLUMvy9IRV5BO351ejAtfAaX7llFur3ENNr/1uWiFkdC
   KXIzoFyV0Te6l5YI43ZH/VAFuLNHkwfAg7mIXwk3fPHfUxPSYUFQIE2Tt
   eHnNUA3xQ4/DuyYbYoJiNo7iCJYQzClhZEex0k8bYMk6UTpvaXUNL81hs
   g==;
X-CSE-ConnectionGUID: S4fRp/oITYK7kP+FfebkRA==
X-CSE-MsgGUID: WLWDF98OSvm7irPkev0EnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33748707"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="33748707"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 22:38:53 -0700
X-CSE-ConnectionGUID: b6pZ9ACISLa2BYxOewgyYg==
X-CSE-MsgGUID: /MmoP2o8TeitTxUsvmXR3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="86807698"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 22:38:49 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 22:38:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 22:38:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 22:38:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiF/eXR37gFdJpVtCnEHmDQlUkDfiOkVDTEEfTwARSlHdzYwc2f6H3oKwqI3bljBV0J1Z0Z37YWUqut+1oGyrqDsWg7T0RbqhXyaUiHzLELR0S9Og0OzJBskAPJ1rb4opk2qbRljNlAte3YUAhsZAUX+k2uqIz8IHSpNlf9UdQz2XV8cB+BlpEvcTQORcfpbeUk8BBRrdeKPzBu2tqd5PhilWWcmm+ctrsqYdnn5gZNqyJ8T7p4gAA/amXU8IfVQ5OGnd0osHjSD5g9Wc6uDV8myGcBdlNkNWXcGdroOzeh6eRKxA+OZbCJl6++WozbUHEHyjyoImlA6u6f2jEhUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnRIQVbME081KFF6T/yL8YOHXPE4OGU1pVm08Ob3UKo=;
 b=sJQu3a65Smz6Qm3DNrnRrKyoVgpDpq+7GeRVovD3RaSmgmC9KblzbdZlenUULW2v3ccCDJpbSJw+5JYUVo6bcf3xYECvtr9zdM0k+T56ymSkQEI7d7WqJs8FV+U8GhdF3giGnNPqeKFVOkTssc4nrlLw2m1aM1J6x3sGyWtMn0iabBHkZQ4u2UHdH582o8mylc+qMLEi7PqGLUIKq/wRVIfB2E6VUSd0izpe1L+/3tnhuzCjIfLQc7fCtRy0IQUTnW60iFxyrZ9gdv8oqeGMrjNVR1lpX21GCTvIfV8qJKpydZsOr7L7o3KbXhguFf74/tBIo+vb3z2YyMGQ4chF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4957.namprd11.prod.outlook.com (2603:10b6:a03:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 05:38:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 05:38:42 +0000
Date: Wed, 30 Oct 2024 13:38:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [timers]  fe90c5ba88:
 BUG:KCSAN:data-race_in_timer_expire_remote/timer_recalc_next_expiry
Message-ID: <202410301205.ef8e9743-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aabf092-de67-4377-4091-08dcf8a51d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CzfbL+1I3Kcz1r7pC3XuZpundT2WbpDOrSmbY900GUuCoR+N3T5GzpGlQjGq?=
 =?us-ascii?Q?w6ORf5kuEHUajffcJ2LBGQKVR2CbWpo7nlHIazf+rBaYQr+ZwKYi9Y8Do72n?=
 =?us-ascii?Q?VLq1VR9fk3B9fuiQueU7+WVOpO8206DLIUU59r5eUAqF7BwXfA6iji6V5OPU?=
 =?us-ascii?Q?1gTeVTs5Fq10NGMQAxgwC78k/FK3zmggHDhwJXy1xuCCK99f18TwhkOfno4t?=
 =?us-ascii?Q?j9AzZfl7/CBNHEpz+imLthClGYoxyjnh53oI8RZawkzNAJFhW7xNep6KEKAh?=
 =?us-ascii?Q?tzNhY+1x7kYDBHpezLaQ882I66xLLiqK0umI36sT9JOc1Dc+oMIy2ZYrWFnU?=
 =?us-ascii?Q?LYru2+Jy8S6mQ/J6Sv3yy5RTtTg+VKx1c9YgIa5Tqs8qWx0wbLZdlY1iXLfc?=
 =?us-ascii?Q?o+Yvql7O5tGejmvuTC7GAlf3wv2ivowCoV3oIH2g8ugCcUrGMtkcYSu8qDel?=
 =?us-ascii?Q?/5S3JIhCmSeTZkXz1ORxDOfMwj7dpGZJyetfif7n+jC0IjuR+7bmYW+1N0YQ?=
 =?us-ascii?Q?4Li8Vg+JClKD+gbwIriGFzT7HLQdIqkMLc+hl3eg262R2yox6qWhz4M1pklS?=
 =?us-ascii?Q?1vwpW3+WQBXCf50jLXca9xIVN+Pd5s3rq7IhLsNCk6/LAhR7hwAC7i6Mbmbd?=
 =?us-ascii?Q?WFfxSMeiCbjM75Oq/2jhsQSfn68Sa5igFTOFps6TJYugH/ZWx5ecLaa2qh91?=
 =?us-ascii?Q?vJ7tCNJJ3NMC03YYPnjEuvQmQvqA5wsX+A0+v7DfRT04zKCqcXDYQJwZHsiZ?=
 =?us-ascii?Q?jHSXmNUMyYWueJWxbMTzkePWKVZNMAfoCTPBlNo4vcwfriY6xCDCgUewC7Wc?=
 =?us-ascii?Q?v5S9pK9gtrl4TT8AFpDkIa5Ga9DzkEnQKeMcir8kD9tk1rpy/V+DJk9yQzvp?=
 =?us-ascii?Q?XDVmDvZNlyL8bGI+gmQsO6uMvKVGVLqZkkhP3BtHx7SovVEE0LkAVuVvpjuv?=
 =?us-ascii?Q?Nu9oAvv75a28+k4By2XEFPh1jWMCt9MbLT3NDVAGBMh59J7oR9bO5fR/e+gJ?=
 =?us-ascii?Q?KbAuWYbvjAbZl7FrFWa3nUUp2h3mRW2b2BImzO2bUe7tRpaqU11hCvme+eJG?=
 =?us-ascii?Q?vKH4yMGhjF/bP+DlXifQa+eQiWTFQDW6uOJ7FQGe0VotQJwnCO0x0rw+av9A?=
 =?us-ascii?Q?wzyidXvb98g0OGdieiRDp+6RFnBxhtAUJgWNc9acQ7A7VCUzu9tIC+zm50sC?=
 =?us-ascii?Q?IyOGG+4e2JOWuVFetYYIZPx5wMXqXe9F5mOEpr+6N+b+r/07DtTqE5VNnBA8?=
 =?us-ascii?Q?LhKVmlmzqKMITi9l1E+qqbqcWJ0c10L9T20VSkNKng=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hEmXQ4mWqykNAydzODmQEYIE7xm1vHVmrPJvp2iuZnzfKcFoikSjZY+MB8Bz?=
 =?us-ascii?Q?mtJcQQDczmHgunYPILFN958q3JvE1Zo5ZdsqKa5yJTWC2wG+TjGq0/XKH7ab?=
 =?us-ascii?Q?qUWZnKGZbku7DXrs3W+pw6QntvYMee9cN5CuJmgfn1vthHvrX0gKzMDkGNOo?=
 =?us-ascii?Q?w5p2QkPe6izYLo+ExsYEXuDSYWO64xPl9eDmWvGjUaN95tl5e+JkJWWQEDao?=
 =?us-ascii?Q?4ElgwBufV7uR4V222/XH0d83PvLRci5ln5QDtEmuzmtFhQcAw+/P0Y5FnnYP?=
 =?us-ascii?Q?Ze+9JErvQ/MFVm7BPzUyf9TczdEJK3JGWyH5r+6d/JxluBDmMMCQ2Al0Jswe?=
 =?us-ascii?Q?9UMjCU2ResFL06BU6DJNWEguTl4uXplO7r3DxUVP1ITYqybnb9EW8hLpdbnz?=
 =?us-ascii?Q?QS1HA6PV6NP2YvSzoOSAVDwSgy4pgSVrWQwg0HF51BgHsVjxBETNUK6+WpwT?=
 =?us-ascii?Q?84yibLTZtwroghdrQBIR53kN6xMLZs+/9Mg5JTWgrjh9ehajRBi6FLfyDOQq?=
 =?us-ascii?Q?qDko8U/JmQ37kYxXlhi0YjcVBiOmDCsWQQOkoNd5vVgmZTYx4PAxdYR4VvqW?=
 =?us-ascii?Q?ogooFbiX+J0psK65AFC1vqF/am25jCiRZSa85PS6X2GpDZJHhWNIX+3FBUSX?=
 =?us-ascii?Q?wbgPmSnLf51d7Jkg3r22AzH2pRTirKSu7Xcl/T3dt4WG3/SBzG1HHCK1lR3L?=
 =?us-ascii?Q?ee0fVs06gGcE4PJjLgal76R7YojrE3JLqUg9D7PANVBnPILWKbg7542VhUTo?=
 =?us-ascii?Q?Tin0od7MUXHMnsLzKm6GYZ0SUjLrkitBFIoxKkYgHxiXsKtraQNuQDP/5sbX?=
 =?us-ascii?Q?INMmljXX2yXUTHL5hqwvR0xW+DacFWFWJeUScgWQpTqkPlaRH89GSEkd4muD?=
 =?us-ascii?Q?TDs02Ku6QNwNrGURM9KYhbA9OL2/NTUP6p1FUiCvD4fU1NmpDcVJfIMtCj0F?=
 =?us-ascii?Q?2ijQkA6AtLbWPmlllceQeTLBmiThsf8gVoOzc5hYqhK1qVckWIC1w+cy1cEd?=
 =?us-ascii?Q?YNhfcKtAo0AzQ59ujDBlDmxOKxI7EkCOhULEXwWMFU5EA9UIczC/2eCmIKpM?=
 =?us-ascii?Q?Br7uq+j4uYtt7K43g0XKdQWyVTQzuUyOV9JQjSncLViu4mQ3jDm8Bb8XImEN?=
 =?us-ascii?Q?sI2dVAF7xuUQgEFIIfGjrMLCnUJiHzj7DnCdw9HcMooEMo7rz5ChbJ6euU6D?=
 =?us-ascii?Q?jNcchiwT0FEMDky9d3hM5rizSTmRSSOLcf5YVsomuVXRFxTxIQJOf7VFsGKc?=
 =?us-ascii?Q?EeMDHq0frJQooTRqZqwmE2qbgLqHWSumL80JMIT7tjVybWbhPLy+PrqrIVmJ?=
 =?us-ascii?Q?t2oZZueQ+xn6eE27etaHblMm65zcKvPAH0ALHL0Z6PdnkOiN7AYOFMLq4oJm?=
 =?us-ascii?Q?Tr/v37VqU61mcUWxQAehQMSKkx9tZSeyVinkLwh7dfWKFxFJTBWMtpUIG2/g?=
 =?us-ascii?Q?n88PjHYy6rLuj6lrdukZ2kUnLMehEKjfC2xUquAoAHRe+7HK3/mKBtVzd/WJ?=
 =?us-ascii?Q?tUMn6BtZmHZWkdgrXKXoHpUbd6Ljhk34dKsC3KCxNC4QT4AAtPWfubHpxUuv?=
 =?us-ascii?Q?8y/GYRdlVFdPEqmlJsfjlCVQhDD5zq6OkE3sCZiMEl6F/PA5XTCr0dFYMJVq?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aabf092-de67-4377-4091-08dcf8a51d47
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 05:38:42.5171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Aynv5nDcig5jq9b9nY/x93QuQpqWPDmAF2wToArkSKFvlzLJUnCNVI56CEavnlc00YTIr/z3RUySRtUPWnKUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4957
X-OriginatorOrg: intel.com



Hello,


we understand this is a renaming commit, which causes below KCSAN report
difference.

d7b01b81bd2dad57 fe90c5ba88ad43d42acefb21b57
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
         20:300         -7%            :300   dmesg.BUG:KCSAN:data-race_in_next_expiry_recalc/run_timer_softirq
         11:300         -4%            :300   dmesg.BUG:KCSAN:data-race_in_next_expiry_recalc/timer_expire_remote
           :300          6%          18:300   dmesg.BUG:KCSAN:data-race_in_run_timer_softirq/timer_recalc_next_expiry
           :300          5%          14:300   dmesg.BUG:KCSAN:data-race_in_timer_expire_remote/timer_recalc_next_expiry

we made out this report to let you be aware that the possible issues in
related code. then it's up to you to see if these issues need to care.

if you need us do more tests or test some patch, please let us know. thanks!

below is full report FYI.


kernel test robot noticed "BUG:KCSAN:data-race_in_timer_expire_remote/timer_recalc_next_expiry" on:

commit: fe90c5ba88ad43d42acefb21b57df837be86a61a ("timers: Rename next_expiry_recalc() to be unique")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      81983758430957d9a5cb3333fe324fd70cf63e7e]
[test failed on linux-next/master dec9255a128e19c5fcc3bdb18175d78094cc624d]

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5



config: x86_64-randconfig-073-20241025
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410301205.ef8e9743-lkp@intel.com


[  131.612941][    C0] ==================================================================
[  131.614221][    C0] BUG: KCSAN: data-race in timer_expire_remote / timer_recalc_next_expiry
[  131.615526][    C0]
[  131.615932][    C0] write (marked) to 0xffff88842fd1d4d0 of 8 bytes by interrupt on cpu 1:
[ 131.617229][ C0] timer_recalc_next_expiry (kernel/time/timer.c:1969 (discriminator 2)) 
[ 131.618104][ C0] __run_timers (kernel/time/timer.c:2399) 
[ 131.618818][ C0] run_timer_softirq (kernel/time/timer.c:2431 kernel/time/timer.c:2423 kernel/time/timer.c:2439 kernel/time/timer.c:2449) 
[ 131.619581][ C0] handle_softirqs (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:555) 
[ 131.620321][ C0] __irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637) 
[ 131.621036][ C0] irq_exit_rcu (kernel/softirq.c:651) 
[ 131.621719][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 arch/x86/kernel/apic/apic.c:1043) 
[ 131.622596][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 131.623523][ C0] default_idle (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 arch/x86/kernel/process.c:743) 
[ 131.628342][ C0] default_idle_call (include/linux/cpuidle.h:143 kernel/sched/idle.c:118) 
[ 131.629091][ C0] cpuidle_idle_call (kernel/sched/idle.c:186) 
[ 131.629892][ C0] do_idle (kernel/sched/idle.c:328) 
[ 131.630536][ C0] cpu_startup_entry (kernel/sched/idle.c:423 (discriminator 1)) 
[ 131.631318][ C0] start_secondary (arch/x86/kernel/smpboot.c:224 arch/x86/kernel/smpboot.c:291) 
[ 131.632082][ C0] common_startup_64 (arch/x86/kernel/head_64.S:421) 
[  131.632864][    C0]
[  131.633255][    C0] read to 0xffff88842fd1d4d0 of 8 bytes by interrupt on cpu 0:
[ 131.634436][ C0] timer_expire_remote (kernel/time/timer.c:2425 kernel/time/timer.c:2182) 
[ 131.635247][ C0] tmigr_handle_remote_up (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 kernel/time/timer_migration.c:947 kernel/time/timer_migration.c:1021) 
[ 131.636092][ C0] tmigr_handle_remote (kernel/time/timer_migration.c:533 kernel/time/timer_migration.c:1080) 
[ 131.636875][ C0] run_timer_softirq (kernel/time/timer.c:2455) 
[ 131.637671][ C0] handle_softirqs (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:555) 
[ 131.638358][ C0] __irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637) 
[ 131.639083][ C0] irq_exit_rcu (kernel/softirq.c:651) 
[ 131.639737][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 arch/x86/kernel/apic/apic.c:1043) 
[ 131.640600][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 131.641494][ C0] mtree_range_walk (lib/maple_tree.c:788 lib/maple_tree.c:2792) 
[ 131.642226][ C0] mas_walk (lib/maple_tree.c:265 lib/maple_tree.c:4907) 
[ 131.642874][ C0] lock_vma_under_rcu (mm/memory.c:5996) 
[ 131.643627][ C0] do_user_addr_fault (arch/x86/mm/fault.c:1330) 
[ 131.644422][ C0] exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 131.645154][ C0] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623) 
[  131.645911][    C0]
[  131.646292][    C0] value changed: 0x00000000ffff5991 -> 0x00000000ffff5bc0
[  131.647367][    C0]
[  131.647755][    C0] Reported by Kernel Concurrency Sanitizer on:
[  131.648646][    C0] CPU: 0 UID: 0 PID: 518 Comm: run Not tainted 6.11.0-rc1-00042-gfe90c5ba88ad #1 cf6842c5d2875ed08b01af3196bb8a34c3713203
[  131.650536][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  131.652009][    C0] ==================================================================



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241030/202410301205.ef8e9743-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


