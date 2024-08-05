Return-Path: <linux-kernel+bounces-274754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11561947C4E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA72D2833B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897A87710F;
	Mon,  5 Aug 2024 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RpfkYSNn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2672C684
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866279; cv=fail; b=iBsF3bP0Kjbwuq4D1pq3WOM77U1WvWC5WvX9CEgOTXmuHGtks8JIFzW5kWj/KqihI0X5DjCn/RYGJtub9ZDmsY0fyvyRAA+JdCJcfSpG2aGesPdjzpHpxItK53wewv8t7S/bOF3R8VHErpO2ixD1Fl5PzlZd8bo3VpP8MlBOihM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866279; c=relaxed/simple;
	bh=Zswk+AZ5SDhfSENt8kWLvtNxPKKULfCuMdfR2HtH2TU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rlUYlDu68wVRjfWTy5A29gK82jHsQOU+Xp2rwd+TiJ38gOYcRt1jHgAVsm/lGkRujOlLMaabxbPH/RzG4T5I5IuiYL0JBKFRSYwrLGEmiv5C6LpGicaMG/kFkJ2v4PbgJsDAPZgRTyMgPS79e8pwzRu1cPFnIn8jul73LEAQ5go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RpfkYSNn; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722866278; x=1754402278;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Zswk+AZ5SDhfSENt8kWLvtNxPKKULfCuMdfR2HtH2TU=;
  b=RpfkYSNn+T/t9jYDYMlYkjyRtNvVDfOfGrSUSLy+hksJrYREDYovr9O2
   PUMiPk0Pea8uOxxlSf+yw6PPOBnntYqch4gvsBkPEIxEHqRBOhCGHRq6u
   TCQqo2WlmeLaxEEyfmso7goQ+CO8fAZ/9hk3B6ER/OWBGrgyLpZEQcAc1
   PKRn/CL2JPWfCh3W/zAdBh6s40gC2+Rivv02K27dKnMHrabEZsMeN0/hx
   JYcitOCxfH7C9N9mSRfmJQBSUFchs55zi+gCx4YmPsO0dpmyNvgwMXwMg
   WP/HbYgWUvt0oxIzbmuq5GLL2+M6s4nB6NFByuhwdciYVXmeknx16B+hI
   A==;
X-CSE-ConnectionGUID: 6C20RvX0RzaUZA+t+2v65Q==
X-CSE-MsgGUID: 3YgXfRs+Q6K68YGNwaO7Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20955815"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20955815"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 06:57:57 -0700
X-CSE-ConnectionGUID: O3mF0qHgRBemrl23Kw+F8w==
X-CSE-MsgGUID: k5qElWH6QXGJn5hvV36yAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="56394255"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 06:57:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 06:57:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 06:57:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 06:57:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 06:57:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXRFF8fq/7A9bNz4nT1+8g8vM1rWgZL6ovEbdHObDXk7r4OSinOkrke+5/vvnVDsQc+88IkmQgyvCQ6C4NkVslUuQZNQu4yORRNy12bVNDD0G3fpfHN9SAQpzB3AGBC105fvjICphrhH24YJDjYrYN3bfWt9ouZm36cUHeLoJIB8ubI7sMFPBZGwFoKS3kgGQPlvwGQTOJhghe2yc+nhq87KjUklWnDtgWTar9CdO0XTKprQkJxymcDrZX5r3+CZEK3Srbv+fWTyEIOY4KxSsyI73tnTN6evPIjwQtZdwaXcFdnxGcXMcKTulOg6e3y4flzS7CkcbzZgIKjd+FSX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUWtDKUalt6umwJ5f5u2Eg/YgjT/WguK+fkoibLLbuM=;
 b=bnhDcpmULq7Mjs5Vjn1KZx8iJmAUuhgZwgDSswLOATU7rp3YToJn5v1WFea3cAdQosU7dI9XsffU0PAe99bpG/CDoJRtVmOSisYfrVJs0M5GyYgsnRuoMOEit3fLaGU6nP5eM4l9PRZrLOuserBkTsKiISf9DWwp7tslS7frPJr4XjzXkAZ9GHZbvCuPLInua1y45Bm6VwiuAFJVOmfe+YK1j5AFkenqEGUtudPrbM2iRr1Am7KMPYSGYNEiLchhdNtGQ1DUJmBA5fl1s2WVJmDRdKlgtZKGmz2vBX4X9tBXX5SrOy28bd0VNFBbf37scH18V2PYs449Vr2HXXGHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA3PR11MB7626.namprd11.prod.outlook.com (2603:10b6:806:307::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.23; Mon, 5 Aug 2024 13:57:52 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7828.024; Mon, 5 Aug 2024
 13:57:52 +0000
Date: Mon, 5 Aug 2024 21:57:41 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli
	<juri.lelli@redhat.com>, Hongyan Xia <hongyan.xia2@arm.com>, Qais Yousef
	<qyousef@layalina.io>, Lukasz Luba <lukasz.luba@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] sched/pelt: Use rq_clock_task() for hw_pressure
Message-ID: <ZrDaVXXgId3psGiz@chenyu5-mobl2>
References: <20240729070029.407884-1-yu.c.chen@intel.com>
 <CAKfTPtD4Vg8rjWVAp=WnaCoMXkee6y2Vd7LT2FyMMtHGtORa5w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtD4Vg8rjWVAp=WnaCoMXkee6y2Vd7LT2FyMMtHGtORa5w@mail.gmail.com>
X-ClientProxiedBy: SG2PR06CA0226.apcprd06.prod.outlook.com
 (2603:1096:4:68::34) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA3PR11MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: d156b07a-a61c-456a-0d5a-08dcb5569939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1z4fUyptjejwvFrxBLJxLROOwZIoG0DnNMS3fdxSVsQfNYTWES3tjBtwRv7a?=
 =?us-ascii?Q?3CbKgEvLxXf/2wUpfaHGR9Ysz0zD4e0wVy1tgQq/JUTu0BuIlTt/dEzWRq4C?=
 =?us-ascii?Q?YM/QlWwh9wEdy5IEQj/PTLVV2aa3ih5Iz+l3OMuvtTk2NOaByaI4ggW77H0J?=
 =?us-ascii?Q?D/7PBGY2pehud0fhqtVqvt1e1kyIFrO7UVApKqsiQfbNNlFXIox4WTFe79jv?=
 =?us-ascii?Q?QwAt80NeA8S6mGZKQy3MWutglpvwXeAsUaxzvEcebbzYkE2FykVGP+uh0tNP?=
 =?us-ascii?Q?j1u1KKp25c74P+ogv6aZjjTe8sCljxw3Whf8+W8JTq4yTB/kilfl4YSSd7gT?=
 =?us-ascii?Q?bsDB06Kz7iKpa6nyZ9rojypiseBvZcJtFp0RHCMpJV0E8JSumY4+dGT0poaJ?=
 =?us-ascii?Q?lHw6FnlMtxnAYwbv1DAGzAzpPVtNS/Dto8iI5MykiMC8K7eunpLaxQZ8X9hH?=
 =?us-ascii?Q?5r+5Fd/PO17AACN0fqyg6zSXW1Ufu6HnrGy4WqyRY2KcBUXI6JACqoXYe3oJ?=
 =?us-ascii?Q?NvYvu9wFiKulWv8xWybXrEtstOop75XdBcbT8DjO5MvQKLB/GxwXAfnJNZWS?=
 =?us-ascii?Q?786WOu0VXS6A7EcklmE2be8KvVGu/heh0ad1TXcCHSw0spGAM9m6S4YxGbn1?=
 =?us-ascii?Q?nr0iYzch1J64bfvfCDNstZPj+7D9S+nXsV8DHoGa04vsj4yROF32qgEXuZ7m?=
 =?us-ascii?Q?dkAc96OAP8HI7CmOwihA6pNvCIweNeSOYnvf6DhtqGAoRpm92jdO2HUjYPoN?=
 =?us-ascii?Q?zyUG7Mgx8MC49tVAX6OA3YDcWPskaMIngPY7rsOwQPMuaAyr7Xco6Zmss9EC?=
 =?us-ascii?Q?n4joMpnbX+Tb7B7cU+mZ+RI7Junjsqy8wv95K2YQ1mpm/93gx/bE2D5Iy32U?=
 =?us-ascii?Q?nI6NtljxP5tQ/dvl0p76QEXMEPtL9jxuPq+56L846JwH75AZd6uBx/5Hx5lS?=
 =?us-ascii?Q?OUMfdSkgaUiK6VrJ/O3+Cbe2vjl45wpNhMm0W853ATDCazTaU+IZtIySbBlL?=
 =?us-ascii?Q?rYTTtl0+cqXgY+YZjNtHpjRzrFMFhU3+QIpWT/UMtXm4g4SbiQR8+AnEziny?=
 =?us-ascii?Q?GjmGMMEOo5NFohZgtL7rBo+/vccKg2i0jUhspDn1hqAHPi5636CQVJW68EWC?=
 =?us-ascii?Q?dk9dp40dwHVBBj+fTxp50gP24cpd0+5mQ8MWgzw58hqZcmVSTvHpUXkeM4JF?=
 =?us-ascii?Q?mJDyLjJcQd2fBSv1+Jk+Y/AjpR/CUt5lD20quZPSsQ/ySb73IetirDdcaD/K?=
 =?us-ascii?Q?5Jud47K6BR94+kuu/Zf11gSwwD6emRrdlvIr4oMCVG/D++dmfIxdYt/hCMNw?=
 =?us-ascii?Q?IU4aNL06tG5UdmKyKg1InSwLy+y6hPuPpXPalAZAVSKCsA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kBS4tBOIqlvQ77pB6E1mw63CXetFf6EBs0i4p0SDPgtmeWB+1Qzm8yJ63EM8?=
 =?us-ascii?Q?h1rRW0YBd/9FhI4tIUUusMDWBw5rW1jVeEASEd2lz/84vcjlc8Yj5EZNCvxv?=
 =?us-ascii?Q?dC43CnYaQRMR+X6RJRiYgrMJUlU4Gnf8h/PbZKGU0SnPHZktvH03ZANx8iAW?=
 =?us-ascii?Q?x0s+OIkyKEeJibWbbE9l0023/iT68q+qddtr2h4FPykKaQFkMeprH4+eRzKE?=
 =?us-ascii?Q?8P63oIeeWZZM6ELUGk6rc+bfq2o0h6aU+2du/7EGOIn+F1GTvpEKf2JuGTJG?=
 =?us-ascii?Q?PS7V8HdrqnW/Q4daGQK77umE4qNGO2u0LnD8yLhDJXNJs32K5Bgs9KU7+Tfi?=
 =?us-ascii?Q?zuFyrGabmkiSkvCG0oo2WcdgOj15UDwomI9GlQxM2u3VOyJw/yXlEzNdJt5c?=
 =?us-ascii?Q?xTd7Z0D1VTwjdL7iWtjeSCadUfEJiFjht0ihLLU36s3Zc/1v6PsUGtrPPmLe?=
 =?us-ascii?Q?Q2ErHsIRXcV7WshDNzyQRvSnhA9hd2HRw7e7DVUoFFUV6EeF5fSgVSzJi2kq?=
 =?us-ascii?Q?4SAuTKML3Og+bwiwHcSxNEsi+jhUi8R6T4pMQo8vTY2hGbwCGmidlYWCzeBC?=
 =?us-ascii?Q?+x+QIWt/utFUBT6s5xNNzIhH1pcWquPpvuXYgx1DDlf77VEgqosziHdO8HC4?=
 =?us-ascii?Q?Ia3poS1ZtZLOmOr/eTn/BS9u4G7EjQpJm6WyVthsqcdDcwvxbnDwXsV/y84c?=
 =?us-ascii?Q?oOpdOvDPCqqne16OQB1aVaUW8+fsNX8sxOkib/EloD+DY8RFHYYgVNMRH/TZ?=
 =?us-ascii?Q?2waMn1v5aQ+kJLu/5LWLpLggwRV9BM7hvwFysWs71DpaOs2bXiaGrnQPgDBB?=
 =?us-ascii?Q?mbSQD7Bw104v75QM3PQ8L0kx7nWxTitcwl1SkeigOUMY27vIQZETxlqNPlmO?=
 =?us-ascii?Q?mKT+UMfzmI6o/zjnI+KdsENVaXsqv0ihpRSwN3AJa8UeJVzPr+VMDUm5H2eP?=
 =?us-ascii?Q?Utz6pfzOBhuijfhOhXqOd+4iplYL6LwDZVp5OfAwWWTcl8QtwDlKC9ZKtpBF?=
 =?us-ascii?Q?3bsGZkc3locVUN2/ldwUKkrX97rs3Ovscm1YBK9dOxRx94doUbl+0hgFgJTW?=
 =?us-ascii?Q?XQJn3bW+Eo1NO8NR+aekwNBbhWS2GZR3xMBbFZKry2rspSUdul69a8FEccC1?=
 =?us-ascii?Q?XboE/wyMwfEVfvLZrqzbCZlplliGRCyvArgyyl0SRK3IZAi7owlzFn8qz3T8?=
 =?us-ascii?Q?i+khg+Kco5x6OuV4KM0lddvaJQVCUFVhIP8css4ZzQyeO5abRxMY0nEhenQ4?=
 =?us-ascii?Q?0WCcyWE9xxtD+L1VZJ7ucuUt7oc2MB6a+ljJ39Wu1uejyj9DnudAviJitAUx?=
 =?us-ascii?Q?wsKMLgFWSkx6pXB7uhLdXC+njG3FcdryRPwcQz442Bi2oqmqqvqj2CxLNoTq?=
 =?us-ascii?Q?xg0sVrT+lFKMS/7+vS5z9zFqzwY2NcsIYOnU5Xd/tZX8pdZf08YIznocSwHR?=
 =?us-ascii?Q?/vFPD55PVLbrZQvFxU3X0pHKzBRwkxQ5b54awELKeTcr+zxunBvBiGdJCGoe?=
 =?us-ascii?Q?loVyAEoOVGl4lhvIfTjttnL4SUls7svieJRrz5ghKKaxu7Pidk0teRglzXKl?=
 =?us-ascii?Q?ld0m4/Hj5IRsEBoRsPlyCXmI4o1dCZL+cni45R/b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d156b07a-a61c-456a-0d5a-08dcb5569939
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 13:57:52.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfwBqYR5Un7JeJQgdNoEwFBjuNzEe2VfqG2lOZ8Jvu+1w3ejbV2rW+S+vjsYWXfngOBaueOkld0639idEolMwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7626
X-OriginatorOrg: intel.com

On 2024-08-05 at 12:56:09 +0200, Vincent Guittot wrote:
> Sorry for the late reply on this
> 
> On Mon, 29 Jul 2024 at 09:05, Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> > removed the decay_shift for hw_pressure. This commit uses the
> > sched_clock_task() in sched_tick() while it replaces the
> > sched_clock_task() with rq_clock_pelt() in __update_blocked_others().
> 
> Good catch, it should be sched_clock_task() everywhere
> 
> > This could bring inconsistence. One possible scenario I can think of
> > is in ___update_load_sum():
> >
> > u64 delta = now - sa->last_update_time
> >
> > 'now' could be calculated by rq_clock_pelt() from
> > __update_blocked_others(), and last_update_time was calculated by
> > rq_clock_task() previously from sched_tick(). Usually the former
> > chases after the latter, it cause a very large 'delta' and brings
> > unexpected behavior.
> >
> > Fix this by using rq_clock_task() inside update_hw_load_avg(),
> > because:
> 
> No, don't call the rq_clock_task() inside update_hw_load_avg(), keep
> it outside. V2 was the correct solution
> Nack for this v3. Please come back on v2

OK, thanks for taking a look, I'll refine v2 and send v4 out.

thanks,
Chenyu 

