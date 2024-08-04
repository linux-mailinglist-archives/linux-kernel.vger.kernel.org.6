Return-Path: <linux-kernel+bounces-273677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5FA946C1B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 06:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9A8281F22
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 04:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62A179FD;
	Sun,  4 Aug 2024 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRFMj5eA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF029B0
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722744375; cv=fail; b=vAWsINtn2qcevl1wo9URWzB2K8dow+ENGCa0h6tc8F+JHxMKBMa+MzkpyGM4HYgrTk/VkVv4+qTpcms6INQgbq21dXbNV7rNjwJsiJ6L9F+3H79VxAovqB8zGvxzm9BD1MqlpPkKe11InFGl2Hc/oM2SvUDpjwQQs3Ob+sBJg9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722744375; c=relaxed/simple;
	bh=Izu38lV++sHVA6UEMsdV4BFZIlJlVnaoHc4mCQBCE1k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZUgCwX3KILpJY2bfi51B/H1Ws+35L/JyWPa/5dGX8m3rF8Y2iNZcF/rJZt47L9tXCOQGZ4I4SMsjtU3SEcwt792nRpEdYvhLCq+jL1s2f+zoblDcVktK0+1iOIog9kNhJZIiX0zuslthL0BG97cBJfgtF1wj+RMpMl0bH2cWCvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRFMj5eA; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722744373; x=1754280373;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Izu38lV++sHVA6UEMsdV4BFZIlJlVnaoHc4mCQBCE1k=;
  b=HRFMj5eAM/pUrzqgGjjRy1smb8Kwtw0jLJxP8yERg5Kj9o1lKBtKewfs
   e9JriGOWelnKQb4XAo6sjVPINF3q+hcN8t+uuHr6elZtCKndEVnF3PdMG
   3bF5m5zqU+Af5+j8ABAcYPkr3zbzkCzPICrhcsHJ9oftBkoYLO8G4UFgW
   d9DEbPnjmFAyJlaMg0PuJIx57qjIItJFDq5f35FOfkePB25XqXeXhw6QT
   /YsWC8xCjDC/4J33KyDUyMxemihTupaHrChl5HuPDSrdzy3ng1pv/AbNs
   S78kGSdtC5zaher932G5o1e0zgaq+f/em+wrdexRhBI2juHjBdjhsOWgb
   Q==;
X-CSE-ConnectionGUID: dCP0nTvjSnuh7l+eHjyjTw==
X-CSE-MsgGUID: d+b3/OtUS4Or/TqkxSVcPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11153"; a="20881669"
X-IronPort-AV: E=Sophos;i="6.09,261,1716274800"; 
   d="scan'208";a="20881669"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2024 21:06:11 -0700
X-CSE-ConnectionGUID: oBbBb8oLQ/eafkoYkutyNA==
X-CSE-MsgGUID: SQguVY5gQk6l6M8m4FSeqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,261,1716274800"; 
   d="scan'208";a="86400588"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Aug 2024 21:06:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 3 Aug 2024 21:06:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 3 Aug 2024 21:06:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 3 Aug 2024 21:06:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 3 Aug 2024 21:06:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFtVmMWztoQ3HloFeznYpVjyENjzBZj8NVvg8UhvJNFNs8mGmL1Z7k8JYChnwnwp63zjagyJaA+/yywHpy5OGjMTlKlSPIZhOaXcoRbqj92PTAht7Itq7iAIWasc/28h+GyXc+Mur6Qy+Cw3skgRvHmyrtr7oqVzg01D+6p+xf5hHWbehGzdfXmVjuohtYsTtdNhRcQed8Oo384Xzrd0omSiDVxHIVOfkAAZ4Y3wHUE7fmRKFoQ3ZjbeDTkboCEjyVT64djGATeTj2pJxM8F7DkCoHzXXix5P7IPnBmIMCdAidg0VQflcq1AuT4JDWJNzHc7UcS/tMmxof3soElQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtJ5uEMIE9fKmF609OQ7XloJsX3/jBXrbUKsGqWBe3s=;
 b=onf0fq6z4ZgISOWT98WgKKA0TOE6fB15NNKkYebq9wvS3DH01LDwW0KQe6Rhhdt8DvIpxE4TAB9slo/NCXGVpDn0e5bAWFtI+DuHiu+1L0s8kNjKObUWO36YFJ882bSMX4S8oRfIYnuKDweK0cEDzSy4tFoW70xvTR597mA/7P/NSoOVDnatWofWHx3IlbcOjV9EG/t3k1g4CRteuoY2LLpn/TdU1dA+YEzE1IS0o06SITaToR0/R6UGDSjkAmAR3XZH1trBpugEQvSamZyVzY8D8sv7eUhOuj9PnOXiIsCGV0Y4QPqmtuesxvk/AqWKv0p9x6fSkbTw0rWeaZYEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA3PR11MB7554.namprd11.prod.outlook.com (2603:10b6:806:315::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Sun, 4 Aug 2024 04:06:08 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7828.024; Sun, 4 Aug 2024
 04:06:08 +0000
Date: Sun, 4 Aug 2024 12:05:47 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Daniel
 Bristot de Oliveira" <bristot@redhat.com>, Valentin Schneider
	<vschneid@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, Imran Khan
	<imran.f.khan@oracle.com>, Leonardo Bras <leobras@redhat.com>, Guo Ren
	<guoren@kernel.org>, Rik van Riel <riel@surriel.com>, Tejun Heo
	<tj@kernel.org>, Cruz Zhao <CruzZhao@linux.alibaba.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Zqiang
	<qiang.zhang1211@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, "Gautham
 R. Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH 2/3] sched/core: Introduce SM_IDLE and an idle re-entry
 fast-path in __schedule()
Message-ID: <Zq7+G1YmKG71WIQ5@chenyu5-mobl2>
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
 <20240710090210.41856-3-kprateek.nayak@amd.com>
 <ZqkRNGLEHIsgxtSt@chenyu5-mobl2>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqkRNGLEHIsgxtSt@chenyu5-mobl2>
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA3PR11MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd02e51-2c51-47f2-add3-08dcb43ac45d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?0SfeKQbhFJ8MKcMZi2WphTxdpxDklQR2q5ZnFdoCXoNoYORyvAixC9EhZ6?=
 =?iso-8859-1?Q?0hGnJAIE8LZ4hrEIhOBWkS5O/9FsBT4ZqqZBls2SqxoPGrSbKCaI9eUtS3?=
 =?iso-8859-1?Q?a7k21xKOQ25JEz8hBDu7FstbRCoRYoYkvNIKDum7J2ENTQ00bAeVh8YO8X?=
 =?iso-8859-1?Q?RY+8DWu9RZnww6OHkQciw2ikYb0f72BKwZQylMjwWV17R/JndgkhKa+Ab4?=
 =?iso-8859-1?Q?loK9JjeqrdxtKAdSRalWtHhycYMf6gOIvi/yumTda210p4dHFLdzdqeV29?=
 =?iso-8859-1?Q?wmXnbzEYM8WLRM258T/mt/6pGTQhh31q37W1hS2no1dcZ2O+Wg1nFRG7Dy?=
 =?iso-8859-1?Q?CMvY2IpmOjiBRbadCV0gBPXcmjRmPkMafyrm9AhBLMzuTuUwDxlEDgxxkU?=
 =?iso-8859-1?Q?BvK2gXx2Oqp60HI5aCbi04+bMOIyGHJzrWnaQiGsB8ptZIcPKlUbf+bCk9?=
 =?iso-8859-1?Q?sIWtyaA2bqXXfV/JHmfqRd7bj6s9T8ZF+ELwTG1eGg+d/3vQKKrEMZmmgw?=
 =?iso-8859-1?Q?N7LziIjXfF5zRnMeu05BbCJ91iX/zw936zo70DYIqNYpnbzaMqyuCNyC9T?=
 =?iso-8859-1?Q?OLTmfPMTd6aI+bSukVRAW0GKyTvZRg80zdwQjBf7bxSc7OtnietWqYuaGE?=
 =?iso-8859-1?Q?4gtZysl3K7fO1RK0gHWgiN8Fa2HpoMku6s7CQUMd6H7cO+nSdFOENMsmNu?=
 =?iso-8859-1?Q?NTP21cYDLFhb/HVWgvor+a8H8kyy3orOf/HUAKSgvxMgEyrv0pF0T6gDZG?=
 =?iso-8859-1?Q?+HmYcW+5XeKFHoMtIf/iTlzt4k8aeer9iBMCCwOZZrzr+mPhpgBKFT1oe8?=
 =?iso-8859-1?Q?cKoWQeTueFxK1SzqPYhuDt6n5BWQ9aLwKnQFbUgOOXaYsesjVMPLuijIZb?=
 =?iso-8859-1?Q?TDwvvSB+V1KULi3EDo1MoPynPZAqFpCbtSKVTZYgX7RF3zZAbuPlw9JfAZ?=
 =?iso-8859-1?Q?dgwvXHob+38yd9R6fspJcro0PmHeZ5yefgnwVUl2mXFi+iNEkfM4BK3dbc?=
 =?iso-8859-1?Q?lGM57T6Fnzf4QlVVOD+zHa5Mleggc4KKPtlAiZiCGW6t+o7f9y5tfMTJ6E?=
 =?iso-8859-1?Q?nTSWrnaRfjFmoIDPUi7dJKoEMMa+RTVj/mjS1Tw4SLws7aC+4gBONdOa3Z?=
 =?iso-8859-1?Q?/xQl3MhLAauk1qfpi/SQDcSbpPle4WAGFmxLkG6PxXDyCu1b7PY9TUT/aq?=
 =?iso-8859-1?Q?cJCKcqFcU5O4SXzcE2V4xBhe1IPxOffjYoeny+1n6xNs/1OrdXDC+8K4iq?=
 =?iso-8859-1?Q?aYbJGkZZfltiHCL9J5pGqwZbgpW3n5//U/b7WD/dgVupHeaSwCaZEVo7Hv?=
 =?iso-8859-1?Q?4YQD0Fu52tZRWTFsR2XCPbCQhM9bD3earJiJLO/fs0Vod3s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vK12UaFTm6Ou9A03msmY6/gRBlt4d9Oe+W0Fe2rH22+ru/PYTiomil1J6O?=
 =?iso-8859-1?Q?ETHinGRiOlhQUlONERJtGAVlImTFJAmqeXGogKOoi1OzslgpGq9mW1mgZJ?=
 =?iso-8859-1?Q?Wn6yLEEE3CK+93pnFiVvFw+ZOkgAAFLXktoDk130pElV7JgzJ2TPdg/UaU?=
 =?iso-8859-1?Q?uiWdVoJ5U90c43fWWt+zszRh5oUMqYwkOL2Thv8lXu71zH0nwLlkuHNN/c?=
 =?iso-8859-1?Q?i2iJbpN8tZEfDlOIsNVSOlUE9VeRjZGWsIZGfB1uwxwAlnPbaupsDKK6hT?=
 =?iso-8859-1?Q?Nbr1VDFaSaage24IfpP9EJ/tfNgM5i1cQxeEUC+1+DhgwfZW4u3E7BLRus?=
 =?iso-8859-1?Q?0Um4SAITYf6KQg/xDh/soAe08UZ5vlbuRMgpbReVlK6WT7pF1PcFCk+R17?=
 =?iso-8859-1?Q?tEo/ATZYH5Jotqst7GCVkzgbZWECGPL9sMKHDROeNCTi2Ab9pKrkhXYDyl?=
 =?iso-8859-1?Q?D681OdrEKAYEPwjzO2yx4dwv+4aC7QJrzZ3z2astAVflR8DIeVdC+BEai/?=
 =?iso-8859-1?Q?21zJcGkB6p3xd3NYWwcB0529euHs4tydtIDuw6nIrgBAswMxHKjlLWRE1k?=
 =?iso-8859-1?Q?s4Y5bpvoyWskK+FgKxqT8k8n2pCPjPRa8ynUoVZ2YTD8VTX8ejiS4uo8u4?=
 =?iso-8859-1?Q?Bxgwijfy8OsWjWiyeu/Bijmv/4Fr9CxdG2+QcRjfQiH9vVChojYJHjuykV?=
 =?iso-8859-1?Q?kB9K7X6ys/Np2t+j0xSiqsZlwpaQuXedo3jPXbWvKbbF8puAdXVBnrSx6Q?=
 =?iso-8859-1?Q?LvgbhYBlYLqMTetzgPXf72xTPQESUGkDedlw9f/EMMqG+xUwQuamCdGdvw?=
 =?iso-8859-1?Q?kfCvR2JpgWxyrMp9Vg9EPn2xRpuvFwAAxc8hcLY2RrEpSwIe5QGtcS73M/?=
 =?iso-8859-1?Q?Jfr8cFXDIcNCkPTfqgX7aERlMY3t9JYs0arPo3ghKUEtsYibWGXU9Nn3rZ?=
 =?iso-8859-1?Q?6OnbII5rTTC2O1YHTun3bx/zI/b543p0ANNwgJ2xkDcKVhg55LzVfBwuw8?=
 =?iso-8859-1?Q?taf2Gogu7/uFlZDcvRj2vDTObWdo2lU2V6B+3EGPdn5WFFF6bqNJNiBs1X?=
 =?iso-8859-1?Q?D9UkLMI846y4QwzHyQeFnJAPWPnTt92OF2WkZV3esKlC3er/pt2+earDJO?=
 =?iso-8859-1?Q?T7X/NEM0V4KOBlpmhLI2nxAGYJDp5A+FcD91eFzxgNAdjFOTKLn2mr4r/g?=
 =?iso-8859-1?Q?JkYVdJQHiI6qgsuCQVR0qrKyAJp0mbLJSx7YgCYjunGNwfVJtYhvhoBqKb?=
 =?iso-8859-1?Q?aUN61+oHZfpc1nbponjcc0A6fia5F/DHXLqLT+zM7zDCPfVYPzcVYLyI4I?=
 =?iso-8859-1?Q?jUYX4Dzpxyl6eo3TOxjUy7SJazEaojQbaarP5GzHQ9l0+wnmwTphws+kLx?=
 =?iso-8859-1?Q?D2vqJ1s0LBEps1Rn2O+Mq7YxFO3E46sYIqEB/RaaIyuXh4rp4oDJhnDKBw?=
 =?iso-8859-1?Q?xEBuTKPUcLDJFSKqRK4kUE1vEZlTi2V7itcGyDMyEshxSezKjqFxZbw2W3?=
 =?iso-8859-1?Q?wlA/L8tVb388YXWXxAYvMYn+kc8VX/woD45E3LpTyTuhXa0ghkQoop3mku?=
 =?iso-8859-1?Q?p5RCZaW1jBC6PWW8dOnVc8IZFJ95JmIHkNj0X+VkBuZSb9GO3DPFOfy8yL?=
 =?iso-8859-1?Q?Pp2kluK0QFO/0IOKvIl1KIRUw+jWWdIh7/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd02e51-2c51-47f2-add3-08dcb43ac45d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2024 04:06:07.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hKRl3rAYRjiF28ruju0kBHuDArLLYyguvbN35+WJq5f7tUUJfC6bQdGs7xKQgyuaoJKyrJgTzIbgZj9Lbe5+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7554
X-OriginatorOrg: intel.com

On 2024-07-31 at 00:13:40 +0800, Chen Yu wrote:
> On 2024-07-10 at 09:02:09 +0000, K Prateek Nayak wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Since commit b2a02fc43a1f ("smp: Optimize
> > send_call_function_single_ipi()") an idle CPU in TIF_POLLING_NRFLAG mode
> > can be pulled out of idle by setting TIF_NEED_RESCHED flag to service an
> > IPI without actually sending an interrupt. Even in cases where the IPI
> > handler does not queue a task on the idle CPU, do_idle() will call
> > __schedule() since need_resched() returns true in these cases.
> > 
> > Introduce and use SM_IDLE to identify call to __schedule() from
> > schedule_idle() and shorten the idle re-entry time by skipping
> > pick_next_task() when nr_running is 0 and the previous task is the idle
> > task.
> > 
> > With the SM_IDLE fast-path, the time taken to complete a fixed set of
> > IPIs using ipistorm improves significantly. Following are the numbers
> > from a dual socket 3rd Generation EPYC system (2 x 64C/128T) (boost on,
> > C2 disabled) running ipistorm between CPU8 and CPU16:
> > 
> > cmdline: insmod ipistorm.ko numipi=100000 single=1 offset=8 cpulist=8 wait=1
> > 
> >    ==================================================================
> >    Test          : ipistorm (modified)
> >    Units         : Normalized runtime
> >    Interpretation: Lower is better
> >    Statistic     : AMean
> >    ==================================================================
> >    kernel:				time [pct imp]
> >    tip:sched/core			1.00 [baseline]
> >    tip:sched/core + SM_IDLE		0.25 [75.11%]
> > 
> > [ kprateek: Commit log and testing ]
> > 
> > Link: https://lore.kernel.org/lkml/20240615012814.GP8774@noisy.programming.kicks-ass.net/
> > Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> >
> 
> Only with current patch applied on top of sched/core commit c793a62823d1,
> a significant throughput/run-to-run variance improvement is observed
> on an Intel 240 CPUs/ 2 Nodes server. C-states >= C1E are disabled,
> CPU frequency governor is set to performance and turbo-boost disabled.
> 
> Without the patch(lower the better):
> 
> 158490995
> 113086433
> 737869191
> 302454894
> 731262790
> 677283357
> 729767478
> 830949261
> 399824606
> 743681976
> 
> (Amean): 542467098
> (Std):   257011706
> 
> 
> With the patch(lower the better):
> 128060992
> 115646768
> 132734621
> 150330954
> 113143538
> 169875051
> 145010400
> 151589193
> 162165800
> 159963320
> 
> (Amean): 142852063
> (Std):    18646313
> 
> I've launched full tests for schbench/hackbench/netperf/tbench
> to see if there is any difference.
>

Tested without CONFIG_PREEMPT_RT, so issue for SM_RTLOCK_WAIT as mentioned
by Vincent might not bring any impact. There is no obvious difference
(regression) detected according to the test in the 0day environment. Overall
this patch looks good to me. Once you send a refresh version out I'll re-launch
the test.

Tested on Xeon server with 128 CPUs, 4 Numa nodes, under different

      baseline                  with-SM_IDLE

hackbench
load level (25% ~ 100%)

hackbench-pipe-process.throughput
%25:
    846099            -0.3%     843217
%50:
    972015            +0.0%     972185
%100:
   1395650            -1.3%    1376963

hackbench-pipe-threads.throughput
%25:
    746629            -0.0%     746345
%50:
    885165            -0.4%     881602
%100:
   1227790            +1.3%    1243757

hackbench-socket-process.throughput
%25:
    395784            +1.2%     400717
%50:
    441312            +0.3%     442783
%100:
    324283 ±  2%      +6.0%     343826

hackbench-socket-threads.throughput
%25:
    379700            -0.8%     376642
%50:
    425315            -0.4%     423749
%100:
    311937 ±  2%      +0.9%     314892



      baseline                  with-SM_IDLE

schbench.request_latency_90%_us

1-mthread-1-worker:
      4562            -0.0%       4560
1-mthread-16-workers:
      4564            -0.0%       4563
12.5%-mthread-1:
      4565            +0.0%       4567
12.5%-mthread-16-workers:
     39204            +0.1%      39248
25%-mthread-1-worker:
      4574            +0.0%       4574
25%-mthread-16-workers:
    161944            +0.1%     162053
50%-mthread-1-workers:
      4784 ±  5%      +0.1%       4789 ±  5%
50%-mthread-16-workers:
    659156            +0.4%     661679
100%-mthread-1-workers:
      9328            +0.0%       9329
100%-mthread-16-workers:
   2489753            -0.7%    2472140


      baseline                  with-SM_IDLE

netperf.Throughput:

25%-TCP_RR:
   2449875            +0.0%    2450622        netperf.Throughput_total_tps
25%-UDP_RR:
   2746806            +0.1%    2748935        netperf.Throughput_total_tps
25%-TCP_STREAM:
   1352061            +0.7%    1361497        netperf.Throughput_total_Mbps
25%-UDP_STREAM:
   1815205            +0.1%    1816202        netperf.Throughput_total_Mbps
50%-TCP_RR:
   3981514            -0.3%    3970327        netperf.Throughput_total_tps
50%-UDP_RR:
   4496584            -1.3%    4438363        netperf.Throughput_total_tps
50%-TCP_STREAM:
   1478872            +0.4%    1484196        netperf.Throughput_total_Mbps
50%-UDP_STREAM:
   1739540            +0.3%    1744074        netperf.Throughput_total_Mbps
75%-TCP_RR:
   3696607            -0.5%    3677044        netperf.Throughput_total_tps
75%-UDP_RR:
   4161206            +1.3%    4217274 ±  2%  netperf.Throughput_total_tps
75%-TCP_STREAM:
    895874            +5.7%     946546 ±  5%  netperf.Throughput_total_Mbps
75%-UDP_STREAM:
   4100019            -0.3%    4088367        netperf.Throughput_total_Mbps
100%-TCP_RR:
   6724456            -1.7%    6610976        netperf.Throughput_total_tps
100%-UDP_RR:
   7329959            -0.5%    7294653        netperf.Throughput_total_tps
100%-TCP_STREAM:
    808165            +0.3%     810360        netperf.Throughput_total_Mbps
100%-UDP_STREAM:
   5562651            +0.0%    5564106        netperf.Throughput_total_Mbps

thanks,
Chenyu

