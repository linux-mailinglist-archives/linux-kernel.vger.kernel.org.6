Return-Path: <linux-kernel+bounces-343289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD243989934
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E3A1F219F1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0410417BA6;
	Mon, 30 Sep 2024 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkJQQqlZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836CF53AC
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727662957; cv=fail; b=aDfvzLd+WBiLm3Q++LROhqgedos4wivAgPgLBvH0n5X/qFNMh7A10FHynEqwP0TSMaqA68jExMEQoWsFJIA2f4zSzJduimVnFZmb7azzxt4gswxl37tjVxLSdHKEk3Lzgc6rV1jsLwn2oRseMiDHj9Yt+jgzHbW1qOizgJKaM+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727662957; c=relaxed/simple;
	bh=gfI/fokQ4J42eHYjJruZGcCdqLp2hwclD87YdRBY4Ts=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LdQwSmp/6tLs1OR3/HJbvWJokGzKUkEUbXMhPgnCo1DVMeZCam0n7xIjCE5S9iYB3pHkibMKRJKvgSsm2kwuXy763LOWin5xEMHF/dTgTTl2wrm/if17kRA2Ez8Ub8DSnRkWRCjXsivtL4QjmQ5BTMCNHcbrmxcwf3m7OxvKUMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkJQQqlZ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727662956; x=1759198956;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gfI/fokQ4J42eHYjJruZGcCdqLp2hwclD87YdRBY4Ts=;
  b=NkJQQqlZmMenkDU2stRI5w0vVR5CBamFc0bnLdE0T8Qj3fn84dE+uC6q
   fSy8R5bzrAGXhMOAZQfBMXWD274BtcIsBYzFwcbY4sxlYUsINg3a0IYAL
   n2WP5NaJ7lIyr0dCyFRIYpnJTH+tsDBBsZQlmWlOA1olAPPputzL5h7v1
   rhXxewvdxRrC+LAXJz46cBMK6ehnX5UuwbBWyYiSmfWGcVUH93+QIVIKN
   mqakzCrvTrJrjZjJkfJkFpsWgbmQmc4OAPmGuodaHZnb9TGifqLTAES8x
   kNSCsQhL1B8WiyxVvqIlPUoonBWPxA1IqpHLrWY09ybw34inOCWI3CSG/
   Q==;
X-CSE-ConnectionGUID: LN++ercuSl6a/9hLPUE8LQ==
X-CSE-MsgGUID: 1GEM32u7QSKuT7N3AFH9Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26200666"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="26200666"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 19:22:35 -0700
X-CSE-ConnectionGUID: X0Qmyx5VSvCmnDoMvBS69Q==
X-CSE-MsgGUID: W+k4iyoRR5CHaMBzapo5rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="77960033"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 19:22:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 19:22:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 19:22:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 19:22:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jal+oyJ2DEdzHIkqz2Qnvncr/R1vTYgoBHlD+himsq2kHU/kme6msyAXSo/YJ8FZlKtRWEIyjvBFDrVOhGIQqNiqJCQkybFgetSSgnGEsr766LVp0wUigGfIXKk46ABp37xPZD63DMua734pV4SOfqC0Vab06w0ZOrHbSTERYE5+GdrWtcJ41//RWLcTPOtgfxpUdxS0oaOpBbiIT0OEOQFxxTdGKOzo5qF+PWRFps14xkAIdG708thGXsAFNRSb6wxFLK5vN4o69hQSWgXvKTOb+guVVZHMEqIDH2cMTcBwLDyJUz1HoNAJlUfWtX3ZqGhhSFEUtSF0u9+7SUH86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rlde5njpK8DOBcQktyevTDG0onn79rdmCV8aU0AUee8=;
 b=PFF7ynyhdjmeE8YRtyp5uaxtXZtV7D0FI9p+RoTVzc7lZdzyCtoI8zjKS8Rc+SqGJ6txsxMOwqzIQ6BO73VJTphTehpR6Ds7owDivUj1q3VMlQgMvfY4wsTHr+rWbnMCyPamABf/xkmNVp5Fcjkc1H6PUsVp7E28wTCTKe45NkvcnmWqVeBpQupWwPxgijeNZk6GPAWhs7LUJJiGwRhBD1SGhvKCuOqUECTPNIAMIlXuKeJZrnKpXWZQEywKFbJYBeW4iqLYt+0j7FBhPaL/fzzn93+Vtm+NVTriosJjPu77skh8ddel6kazXa2bgYE9a+NxxPc33/szgcj7VQMFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 02:22:31 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 02:22:31 +0000
Date: Mon, 30 Sep 2024 10:22:17 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Honglei Wang <jameshongleiwang@126.com>
CC: Oliver Sang <oliver.sang@intel.com>, Ingo Molnar <mingo@redhat.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>,
	"Chunxin Zang" <zangchunxin@lixiang.com>, <linux-kernel@vger.kernel.org>,
	Chen Yu <yu.chen.surf@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2] sched/eevdf: Fix wakeup-preempt by checking
 cfs_rq->nr_running
Message-ID: <ZvoLWQICLdTonRE/@chenyu5-mobl2>
References: <20240925085440.358138-1-yu.c.chen@intel.com>
 <fea9b64f-4ede-475d-8788-73bce88b2e3a@126.com>
 <ZvZXEqNLcJxq+8Aw@chenyu5-mobl2>
 <c15e2f07-5a0d-4e48-b7f4-83e4689f9299@126.com>
 <ZveiDh2/ztZTP/fH@chenyu5-mobl2>
 <ZvlbZYQE5Slf2YEb@xsang-OptiPlex-9020>
 <8282e4e8-6d71-4402-9eed-38865a3fc6f3@126.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8282e4e8-6d71-4402-9eed-38865a3fc6f3@126.com>
X-ClientProxiedBy: MAXP287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::32) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bed60e0-268d-4e4d-6736-08dce0f6bcf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFpYRVBnREg4Y2VpWnZtRzc4M3VOZ0Fab1VNWVV1cWx4OHNNcG56L0k3SGZQ?=
 =?utf-8?B?VnM2eGpYTmtIcnYvNkZaSGtscnJGaHJ0SFVPOWo0V016YUVtb2x2YjBnek1M?=
 =?utf-8?B?WTZ3MERJdnJ2VWd4OHorT3NZa1A0aWNGQVR3a2tYMUxQSVIwSmc4TlhBR1Jl?=
 =?utf-8?B?VWpaL1NYOGQwT3l0TDkzb1E4Nk1Fdi9VeFFZa1pYQkVtUlJGODZSNGVRV0NC?=
 =?utf-8?B?VzFza1hGQ0ZxaGMybW1xc0R3SUZyNUY4Y3pEeUNCS3orR3NlUDFTSUVxaFFp?=
 =?utf-8?B?U256RHRjWXcwakEyZnUrckpCd3N0aSt3Vm91Zmp3NG0zMU5XRmdTNWVxWGJu?=
 =?utf-8?B?SjB5UDQ2RUw4VW1kUUFuZTFvam5pWUtUZFlGZUQwelZuUGhNSjd1UmZQMjdT?=
 =?utf-8?B?YWliVjFhYkR1TUpFTk5Yb3JPUW16Q09pREJkZ1J0U290dGp2MDRQdGhkVmdU?=
 =?utf-8?B?ZkY4dExzUHEya091NWV1Sm1tZVVldERqd2h3TFYvZDQ1cytvRUs5UytleEpP?=
 =?utf-8?B?b1NrenZEMXNGa0VkTmFwOTMzTTQ2eG1ZZTZuTDFvekhadGdsNHhSQW42aW9O?=
 =?utf-8?B?TDhycEJnbWNzVndqMmFHME9Yd0V3RDIwWmhxbU5OL3ZoR1RpUDJqWnJjRlVR?=
 =?utf-8?B?a2tHTm1ubFIrZnIzaUM1WjVvTkxzQUlTclljbzBYYlk0bmtaWnhlNkRRSmxP?=
 =?utf-8?B?d0dqSVI1UHkrZUFFWnBQNStQQk1jZENoTG1GNTlPWS9XSUdiVzZGQlZhc0ow?=
 =?utf-8?B?OUtBR0RKOENsVUliVVFXTW5jTlRwQkRvUVhUbUQxYVBFNzlsQXJmTVZhVDVH?=
 =?utf-8?B?TkF5aEJ1QVNKa3NTRTZmUkhNV3RRL1c1M3o3blF1cTVLUFBaVjV3ZndKLytj?=
 =?utf-8?B?Tm9NLzdVaFdtVkR5OTJJNjg4QlJSalJsRXRHOTE1UUV4MXdoLzZzS2VObDEy?=
 =?utf-8?B?VVRlOVlibFl2VW9Ucm9YVEszZVE2VEppbFVHeDAyblc1bXh3Zy83Q0NqSlVr?=
 =?utf-8?B?N3pmaWZ0aG5WMkJ5N3g1WXBJY0hhb1RyNy9WSSt0Y2xkenYya3VFeFF4YW4w?=
 =?utf-8?B?bE1UTTFESldqdnlEVE5pMitLdDh5YTM1YzNDeHYzQnV4NmU5cVRYZUpDQ1Ns?=
 =?utf-8?B?OURpWDdkV0t4dHl5a1FhVVRkWWpCTGFsb2dZQk9wWURSRnVHUmJ1WTFKWEhj?=
 =?utf-8?B?QlY0TVlpY1lIeUFNaUt0cjhXenlCbHNJRWk4VkhVYWRqZTFpS0JtQTdCUWZl?=
 =?utf-8?B?RklOVHlRc3pLRVB0ZkdZRWxsWHRQNWZMMzNzcnppak9GRmNVY1U5M1BMaVVW?=
 =?utf-8?B?UURZZ2ZqK0dIbGtNQm1BWU91dWF1NFI3bkZUWFRQaFhQaWgrRDdSNDlScUVB?=
 =?utf-8?B?YXhVTUU1eUoyRzZkUXFZb2pkSWM4R0pQTXQ1QVlsTzhVeTFZY2t5dGk4WkNr?=
 =?utf-8?B?S2x2aGNGQ3ZkbUh6QW5nZ3IweVhySVEvbllXanJZYW1kOXU2SllXaWZtMGZ1?=
 =?utf-8?B?OUVCSmZQWjh4emtmNXBQNUdJRjA5Mlc5cFYvZFVRT2dzemRCR0F0VXFNN2xz?=
 =?utf-8?B?UDVoODcxZkZ1ODVIR1dpL1RxbGlBN3FSdVJxUzhLTk5pSEd5RUE2NkNIckJW?=
 =?utf-8?B?Vytyc1FVR01USFBPM09qTHh0RkhkcExCdWxMSjZlRTNiY3J0YnB2Smgwek4v?=
 =?utf-8?B?cTY0cmIxelM0N3VqOGI0c2JUSkVpVFRxaER4NXBDMjEyWm1WS1Y1SG9qZnEz?=
 =?utf-8?B?OHFXcHBqM3pHM05NZVJXTHVRWW4xYUFpNmg0OFdEb096UVRsdVVQZkZxMlZJ?=
 =?utf-8?B?RTIwUzBzS1pGWEIrNURYUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVY5ZUJiOS8rZVJFaHArRkNyZjQ4MVRseFpJMVNHRVRyVTVVSTlZdGdlOVdk?=
 =?utf-8?B?KzRvVTlTeHpXY0F1SEp1WWFKdWV0MVpPWGNrVng3LzFjNzR6OTlidFA3MkNB?=
 =?utf-8?B?YzFpN3JpLzR3TFNkYXU2MHJ0Q0dtU2xwbzM2YTBEVEFpQmxnMjdiS1lCQnhk?=
 =?utf-8?B?SWNicWNuZThaWUl0ZnppbE0ya2tSWXZISXB6N3pNTThIckplcEo5ZitxRGFt?=
 =?utf-8?B?RW4xbFR2bWhVOTIvRzFuNWt3RTVTSUFhTHFRU2JxaU9UT0duSnNSeTJvc1lz?=
 =?utf-8?B?YWR0Qkx0aHpQMU5HMFMzdGpWZU5MZDErYnNPS0hVb1lvRVgwbm13ZmtrWjBr?=
 =?utf-8?B?aWl1YWZFSnZMdE1MNzRSVGYrVkJSRFpqR1ByUFEvRHpQdCtVTkV2Zi9UYnNH?=
 =?utf-8?B?NjhNeG96Q29DVWdVUSswOE5ZTDlIWTVMRmpjKzZmM2RlWVpoa3FMeW9VTVpn?=
 =?utf-8?B?QllvenZOSS9sMEJldmgxOXFSQ1dzTDUzS096UjZvVjBOWkhLQlg5VTM4end5?=
 =?utf-8?B?RW8yS0FEQzZxdHdZcjQ2Y2c3R0Nya1FMWWtOZlR5OVZ4bnE0YTlPZE5HdDYr?=
 =?utf-8?B?S055Qk53Uzk5eEtaV1dnL1REN0N1Q0twLzJocnZCNHdMRG01VDFPU3M4NW9h?=
 =?utf-8?B?NHc2RThndE1XaFd0M3RYQi9kVHdTKzhLSHZEZldScjU0RWUxWWFPeTY3SXVl?=
 =?utf-8?B?WHRzWHJRNXVDVStHU1BCTU9pVEJad243aUpySE9nc1lidkxWeG1sVVdGUGsr?=
 =?utf-8?B?WlAzWC9tV1ovMjlFMyt2cGxYWTNmQWEwMkdjVm1KVjBZaHZxVU8ydzh4WVAy?=
 =?utf-8?B?ajBYUWN2UXMxenRjUGx5TmNrZjNnTU03Znc0NkI4L0llVUhWbWUzQ29YajE1?=
 =?utf-8?B?Y3NoMUZ6OEpOU0pLcTJBYTFtZTVPMHpLTzkwendZUkwzV00rNHB5djJCdDll?=
 =?utf-8?B?UlBDNnI1MFRzNXVOZDJUdHpWU1VIRFBqOHdrdDlLdTdrMStwNmpsdEZzZks1?=
 =?utf-8?B?TVRDdUp1ZkxaNjYrVHFaeXFqb3gvRkJQMituRHJURTMrKzZzY1gweE5VTkFC?=
 =?utf-8?B?WHk4UFFtMkwvMmFzS1J6cDc3NVhmSU1KNmpib1Y4Uzc5b1NJaEg1M0JPUFdl?=
 =?utf-8?B?dlA1Ti9ZUWx1WHRKWWN3ZlBmQ3pQKy9uTkN3NXhRQ1hOTytZcFpncURZU2JQ?=
 =?utf-8?B?MXlBaG1hYTdONEtjNUozRmFFanJHa3ZyaW1UZnZWTnhFWS9PNG9qVi92dTlO?=
 =?utf-8?B?UEozTzVNWlZhMzBucUFkR1RCZ1FCWitVOFNtYXJ0T2doLzlFZGtCdElCZDFR?=
 =?utf-8?B?SUZNekNJK0xqTjVoTXE2UGY1SnNxaStLRFJOc0s5R0FtNVJLemFqbTBUNVY2?=
 =?utf-8?B?c1VWSVV1VzNtTWgyS0JiSXZEeVRIVGVMSWZiVE9uTlY5aUpsblUvZWFqbVJV?=
 =?utf-8?B?ZFVwQ3ZOc2MyelVnbnM1SWVzZkJaTWFidm5ER1loYXhacWVtc0tqaDRKamhh?=
 =?utf-8?B?ZEtlQmNzNkN5TW4zWFpwUzU5REhZQ2N2K0ZNRk0yWlF4d1RUdVFnU09PeTV4?=
 =?utf-8?B?azlTVkcvWVprdDF1VDN5TFdlUGVIeENOSXJPTXFuNWxEajJLY2hZajhOZWd3?=
 =?utf-8?B?dis5YzBrcldDb3VRWGhvMlVEOGVCWmgyVkVaN29WdHl1UHRWeXhuM0o4NGFq?=
 =?utf-8?B?RjdHODFXcDFNRDlwM1FOTU5zcDRGMFBUVTMrVldhUXBhRDA1WithTEZTcU9K?=
 =?utf-8?B?S2tad1pDKzVNQ01Db29iOHlkSnBDVW5NZGV6WkNsNHQ1Nnl1QzBHVG1hMWcx?=
 =?utf-8?B?aVNmdEZKbmNhbk1ScGpxcDFFREQxNWp1WVdLYm84L0dKTFFMQmdBc0pFcVZ4?=
 =?utf-8?B?VzNmYnZZR1J4TXJhWFBPRzI2bGZQSDdTdC9IZkJTMlJHZ2EwSjhrWGQyWTJF?=
 =?utf-8?B?UThnQlpxaVZpVzdxUkJuV204dDdQOWVMV2FjeXBMRERla3U2ZCtQNjc5d2RB?=
 =?utf-8?B?V3k3WEgvNVd5blgzYlhEYU5MOElVSGQ1eURNS1dEUkxHcVUxZUNma0gxSjR1?=
 =?utf-8?B?RVhlNFdhUkg3MGw3bDNRQ3ZZdXg2cm5JQk90SGJkSE9pQnoraXpPSXY4c3Ja?=
 =?utf-8?Q?dPa/XK07uEx4Smtp76BqRLhVc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bed60e0-268d-4e4d-6736-08dce0f6bcf7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 02:22:31.7882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4lcJI3eJlEzyRnE4hLUrURhnBwqJf7IQFg12Y0iG2DWcO9agIT1z4r9qRdvhb3GP7RP6kOAs9WVvyy+s2iYbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472
X-OriginatorOrg: intel.com

On 2024-09-30 at 10:04:13 +0800, Honglei Wang wrote:
> Hi Oliver,
> 
> On 2024/9/29 21:51, Oliver Sang wrote:
> > hi, Chenyu and Honglei,
> > 
> > On Sat, Sep 28, 2024 at 02:28:30PM +0800, Chen Yu wrote:
> >> Hi Honglei,
> >>
> >> On 2024-09-27 at 21:38:53 +0800, Honglei Wang wrote:
> >>> Hi Yu,
> >>>
> >>> Yep, I understand the preemption should happen in the same cfs level. Just
> >>> not sure the purpose of the 'nr_running check' stuff. Perhaps its role is
> >>> just to judge whether it’s necessary to do the preemption check. If there is
> >>> at least one more ready (cfs) task in the rq and current is not eligible, we
> >>> take care of the waiting tasks. Thoughts?
> >>
> >> I got your point and it makes sense. Whether the preemption check should be triggered
> >> seems to be a heuristic trade-off to me. I'm ok with using more aggressive preemption
> >> strategy as it depends on whether that workload prefers latency or throughput, and as
> >> long as it did not introduce regression :-)
> >>
> >> Oliver, may I know if you happen to have time for a test if the following change
> >> suggested by Honglei would make the regression go away? Thanks.
> > 
> > I applied the patch directly upon 85e511df3cec, the test found it can reduce the
> > regression but not totally reovered
> > 
> > =========================================================================================
> > compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
> >   gcc-12/performance/socket/4/x86_64-rhel-8.3/process/50%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/hackbench
> > 
> > commit:
> >   82e9d0456e06 ("sched/fair: Avoid re-setting virtual deadline on 'migrations'")
> >   85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
> >   8079496d311b  <--- patch from Honglei
> > 
> > 82e9d0456e06cebe 85e511df3cec46021024176672a 8079496d311b6b0d4dae973f4df
> > ---------------- --------------------------- ---------------------------
> >          %stddev     %change         %stddev     %change         %stddev
> >              \          |                \          |                \
> >     623219           -13.1%     541887            -3.2%     603080        hackbench.throughput
> > 
> 
> Thanks a lot for running the test. The result is as expectation, as the
> strategy of short slices tends to favor more frequent scheduling to help
> delay-sensitive tasks acquire CPU as early as possible.
> 
> I suspect that the current test environment does not have any special
> configurations for slices. In this case, a 3.2% regression is still
> somewhat significant. As Yu mentioned, this is a heuristic adjustment.
> In this particular case, it seems that Yu's patch is more effective in
> solving the problem. Let's delegate the preemption opportunity to the
> higher-level update_curr() function.
>

Thanks Oliver and Hongwei.

Hi Hongwei, do you mind if I added your Reviewed-by tag on this?

thanks,
Chenyu 

