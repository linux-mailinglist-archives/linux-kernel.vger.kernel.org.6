Return-Path: <linux-kernel+bounces-343833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B809198A010
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7877C287C00
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3314188727;
	Mon, 30 Sep 2024 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjvK76Rj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4F913D52E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727694149; cv=fail; b=ZBMrQR3hA8kI3lTQO6JKMN7ymO9Vm2DZAwoFB8M8ZtR0VtSqUl8z5wyEiJtTZU16qtVHGzy5V0NP1/6W1dyRaLywLP5TuXW+sAcKM9ftmN110Rjh1faWnSNCriNL3LhFNPv2ylvLiH3MIR934u+Sj+yz8FeE57PJIIbABp7dpl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727694149; c=relaxed/simple;
	bh=4LpEbXS18ZoQOymZxJaSWJ7WFuxBciyFbutb2QeY61g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=td4jIZnPe9WUDWal9/uaLQc5dQHPCGv+KKTM5/SyjCX9flKprSDHn0Ma0RGoXhEBUeEkBbs1bRZQVDlMwDxDNA7TJ8fPQiWBoPfmHkF/o/LziQarVPGTEpjtm9TSyjTcjJBzzeerdggS/1Xuf8WE1UcrG8UTA5rzQbbOfDGHX34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjvK76Rj; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727694147; x=1759230147;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4LpEbXS18ZoQOymZxJaSWJ7WFuxBciyFbutb2QeY61g=;
  b=UjvK76RjvGd0TfUav2cxbhTJYWdQBsX6RCIEp9dqPkDN1dXAX2uUR23L
   sw0gr1z7g4pqXG3XWdN/BA8ZAMjCx+9WmmRy/l+DuLY7q66xZE44HhhGG
   762MnMTR0C5gCWh3QaN9EIsKaRsQePuws7OyDfTOR1Ol+GzbdKt5Kw3Em
   c7cb5XjUUxYGYWKIn/7jcaoCQfhFiV73Qaf2HT0DIrxYaPhT1wlP7vzOr
   RF9nzCOlFNxTeAwZWXT4gLDm86DG+iikocb+OyU15bAZtn5TzQmITymPg
   cGCCXXfC+8oKDJqIQV0/gjFu2oS5t95O6p8dP3MFziXdRu3322hDECdAx
   g==;
X-CSE-ConnectionGUID: 4FBhHZsQSHG1Pu+n99wxhA==
X-CSE-MsgGUID: mt7DaM+gQ9O3UG9BhuAauA==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="37917238"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="37917238"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 04:02:26 -0700
X-CSE-ConnectionGUID: vMb+lpG8SD+a5q+UiH7maA==
X-CSE-MsgGUID: NtPDQu+5Rf+BLxrirXuFHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78220602"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 04:02:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 04:02:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 04:02:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 04:02:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4er4R5qhvjUSgRBnn5t14Pbnwc6KaN5mNEPR8/+dWyYHTKtK7L5fEgh2jBouyT1zQuZYOdeOkUINCAQr5TzMQyn9nAs7Fh0qYuSt3xf7MWHHPIQ0yfMMtIKWKgg23L96wtae3s/uigcano1VuFdz+cNoTN3hGg7b0o0el/9i1OQn5yW95HVRuPdXQP/6Ix142BnoZlGctgK2UoTTYOM7LPiagJwERP9gY0o6L5KPpBQk819xHOIetIDsi13e02z72QhHLyUAXnEUaq0Sbiiihe11rJ3jZU/rc3jrUiSZFoglmLCzyzc6b8q1vl1WX37Q20WZ5EQsSaHYB4izIocWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjIL2CyKrxdi4d8RuGkbLvj2RxgBy66GZtG9xY34X9Q=;
 b=vans6vipi/K5mbvxfdYjdl/p97YYPoiRmQIwd2BS2a7CB7rWU6lXloz1N7BX8zxJsGa8dgPfxPm5Xq1upmev7/YXfIsTDKL+Bv95eMiFMvS0D3k7iQOg9KCSgP1BydzXSOITbgkEfQ2DwEd6OYCiRWEO7Tigz74wySemgNQkB1Lj/vg5LpN2wqB74j1x08pEuN3nCSuXfi8woFvWFn7lvwCvuLa/3sWsQ/7TTdNi2CBBTTXP0+KI1iewFt/cnfEyFzyMhXiF5cbCu2JLHy0uLnlMK18nmJ+BGZxaJ5nlAtvVOD7M03EMRzl8E8m87vpfkaGBbugPkNObLMVHYZTWWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19)
 by BN9PR11MB5259.namprd11.prod.outlook.com (2603:10b6:408:134::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 11:02:23 +0000
Received: from PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::39d2:ae29:6e3f:1b6a]) by PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::39d2:ae29:6e3f:1b6a%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 11:02:23 +0000
Date: Mon, 30 Sep 2024 19:01:04 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>,
	"Chunxin Zang" <zangchunxin@lixiang.com>, <linux-kernel@vger.kernel.org>,
	Chen Yu <yu.chen.surf@gmail.com>, kernel test robot <oliver.sang@intel.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2] sched/eevdf: Fix wakeup-preempt by checking
 cfs_rq->nr_running
Message-ID: <ZvqE8MBYdGwHBkVh@chenyu5-mobl2>
References: <20240925085440.358138-1-yu.c.chen@intel.com>
 <20240930075045.GB5594@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240930075045.GB5594@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MAXP287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::25) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6005:EE_|BN9PR11MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: f848f5d4-9972-4fa1-77bf-08dce13f5aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AO8//EFf56xSEn2HgnGz7xpOz0pDVQlOc8CG77lXoJjBIyzQ6rcrFV7JAHcm?=
 =?us-ascii?Q?4ICd34ssF3fLUeyNV/JYMJXOzgaPnJKli/0z6QmDz9U40dbznLKETw1DWi7j?=
 =?us-ascii?Q?8LGI78SA+oH56Xx3dvZMED+i0zcAob4ONwdDIcYZrxpU0HydrgSwRETC1nI5?=
 =?us-ascii?Q?6J1isfK0fJeAY21EPh/QfelO2JHBPe4rqMuzbL+WtWB6XofGUlbDqyY5QNhM?=
 =?us-ascii?Q?u92TgFhTt8k/9q3ttGnKeloIXf01QYhzV84s0HuYPgJzWuFWCaQl0pEgvqyX?=
 =?us-ascii?Q?l1uKcN7WqTXQ/ImkrFEhkEcLX04TuD1QAZ9zR6kDLVm3JW8bkvqHmAcVfBcr?=
 =?us-ascii?Q?um1J706Ove259H6BxkezNL4hgAIK6vhCdp65wFHpftaUsmkclDoffuVV6rJr?=
 =?us-ascii?Q?pCUJ14zGf70Fhk2NAXu2nBpaZZub6v8HdHhvLnFIgXsca7eL1ODpEDSjVaCZ?=
 =?us-ascii?Q?4vJKg3nVFMUoxg8AcNBKvTNtxFFd5eOI9M2NazPP7soiVm4Iz4/qBCWvbT5l?=
 =?us-ascii?Q?p3cdqTg0Xc6dz6kmys/c6U6AOPU0WbsINwmVNKqMh/j6irJ+vw/Vdx1m0UGL?=
 =?us-ascii?Q?DftKWsCM6wMxpyMy4GVY/rnq96vq72xSlpfv3oCvnSYEmPA0BVyF0oYGN2/P?=
 =?us-ascii?Q?Nt9i0mHlwYYocb0y0NHv6chBOgynbne4ZRf1pjSnUsWpm1Y3p+L8NwDr6mrA?=
 =?us-ascii?Q?5vj9BQj7HzzqHtCERWQxDkOz0s6TMw25Wexo7MpIfrpB5O7zIEUX5W+iNe3r?=
 =?us-ascii?Q?DuxKsJerHK18Hoy+VWDxoi9pTV4RZiRyttt15N7e+XekAfwM5524UVz/NC3+?=
 =?us-ascii?Q?qP6Vc+EInMqY+1wx2Rsuxe7IVrWe1/3UHuTM3cFhw6x8C1a48ALN9+ZG5xqX?=
 =?us-ascii?Q?GgTn2g/cVlmgr/Qzx7JZ670RWkeKmh8JwSoXIEPvGrJurchRPP8MoY0fqbio?=
 =?us-ascii?Q?2BmN7BTozt928UnNDmDu48Brdb0d23hZgmjjfMaxc8KA4qxCb74tiJpepoNc?=
 =?us-ascii?Q?i93NcRazZre9jOhuR4xM0PMauxaBpm0Ry7TelD+6BPxk5YNEfnaCPc8lvS6M?=
 =?us-ascii?Q?ckJygjEIfBLLLCXVkD8X54qFVB/kkZbV7letw62RnuyNJRpm+jGaHgwJdgJ/?=
 =?us-ascii?Q?HCtOYrV2nW/BZJZPkY9R6F3Q0eJ3bzqPJBX8Agbnq+A78HmkqZzATh9OrAg9?=
 =?us-ascii?Q?CKN/OkQkDrwQY/2f8otpzQa4nqfxkGh5CSZcBV69y3jgshjZ2EMc4XEBN7jt?=
 =?us-ascii?Q?cu2JuNogy4tSf6afBcrK4Js3/IV2g2M7wqdbMPzgdi5XhqfxgqLt7sqkSGdM?=
 =?us-ascii?Q?7Flq2Tv1XxF20WojWRZaLB+RfjMw3UTM2WqUwvALowL1XQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WVQFKDbvURaOC13bGXRI1NkhXXrJAYVnyiamOAbeoElfkQ5T4I6EKFl2RVGH?=
 =?us-ascii?Q?3H6ESYhswYT1tJ/xcXXUGzClXpvJwLJDL00QASlJl67CdIH7z8vn+X3Kf6ZF?=
 =?us-ascii?Q?kGohaWip+nRprLJpO11ISik7SwcOB6Zf9sn/ZvzGBnqdZjAOHy+KJW6+z0q6?=
 =?us-ascii?Q?Ck0/1XmN0zIBNwIefmX9tDoFM8NGEkpNceVi1UcueJui12kXFRXyfgUXNSbZ?=
 =?us-ascii?Q?MBV1/Vteiy719jo1zS8ZnRTz9sZRPXlJAs7DHUNJkxk+8ZKv7l36SgVcSbTI?=
 =?us-ascii?Q?xAk8JFBRiCewjSZywOG1DJePc1KUbOs/S2kQP7EBsBLTYINctUgB7pHyxDq2?=
 =?us-ascii?Q?cgxduCmHh167i4vnhKwa7HI0A6EYx+Okpviey+d8qu+iT9gKgvcDh+eOPwdK?=
 =?us-ascii?Q?YeoQ2UBCdpCwXsrR80IY1ybOlbUjPqthnoDbT2qTF17gGl50alqlhwIHeKh7?=
 =?us-ascii?Q?kvpuJcAyW63iNRpRoPSyAlp+H6SQMPmglVsy4RWoenGNR8iL/Y/VeIP7aTnK?=
 =?us-ascii?Q?vJkUZ290fd3Evv2bQ5EGgevvC+CCd/tSXzWvP9iYajObGutfLsp4E3oVeMfm?=
 =?us-ascii?Q?fbQJena2Yrgy1YVNdhrAyk/EBZLgBIEZknE3A0AUA+W24bXdkZx8pI6/JTZY?=
 =?us-ascii?Q?liN149vz/HEJLt6YvahxMKrNjLgZwVPbaMW3ZAZYAl65bhCeh1XiRURjlz40?=
 =?us-ascii?Q?gNGDsOjN6VjJBLBfm6Imaxgv+higitQMhi15WxorwTktzh41a9EWKRvPwnBV?=
 =?us-ascii?Q?+0drfhrqJTe+3DX4KjSFPkjBWi1gQlnXhcl6223JtaGW2qkNcr9wh+CXGrl3?=
 =?us-ascii?Q?sxJIzD1UtJt/WOVRrie7P+5Akzn92YCu5BomKjsTpn9uiRA1w84FRisTP/1b?=
 =?us-ascii?Q?3gmbO3uavj8DzPCf/fjER2meTmB9BjH3TYd+3RP65po1jn/1t8+uL9OQ0yy4?=
 =?us-ascii?Q?JpJ3aMtn6DHVkfKf7ezvmPOmqarrtb8bHDiPEohDxUcue5erSWTSZtoEJjEs?=
 =?us-ascii?Q?WgICERRXVF+3ttPU3FLvhKHKwlgVmCSo1HSBYnoAEjQ0rDfnbecQUDZzs9wL?=
 =?us-ascii?Q?X54pgvxSrIL7/FXQJkA7Bunm9oEyBJmGixxflaTKtWqIbAC8wochHr8otTWw?=
 =?us-ascii?Q?fCkk0NyPwt6ROOYz0QyqZ7rUrGwlCcnI/5kJMNPqZKnoB8eNKr0XkapGOPmH?=
 =?us-ascii?Q?0n3j8gacG6kUhBfDr81mr9bGPiOaptHPqp/LcXkAMpUZITvHk74sJ8s0tgCS?=
 =?us-ascii?Q?4l+wEP9t6mfeD2AAFIVTC7hrHZ4eE/MH81/0/5xDzCInnPDIXtnFv2TqydCS?=
 =?us-ascii?Q?hbXkLsKqRNptT1Ad+lBlm2GuJueOmbhluDydjRSlUCU3MRRIjED8u4PJGwNE?=
 =?us-ascii?Q?0QVluh+zNzxmRAbmyzEOfcoehNHYpqHDerS1eWomf0AYwhVe0yRYZcO7svOF?=
 =?us-ascii?Q?X5ztEbxCVmNMCgeNl2TAugJe0c3DNzwy++5jVRYV0ASKlfzBzkUt00C+q20a?=
 =?us-ascii?Q?Dm6eMFNUzJ3Q2DUu7x8KgRQMkHdTZAum62uRjfsgxU5O9Z9DGnJvQ7wviVXj?=
 =?us-ascii?Q?c2vWSgAfqQ3m4R7qYnldLCKfSm/I91MvGJtZTJrZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f848f5d4-9972-4fa1-77bf-08dce13f5aa6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 11:02:23.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbXZKkM98awhGQW8Pv2VdO3/wDah7iAiD13r+4qbmzw950/MkQXC4W7G8WuFkahzY8w7nFZ1bU7up/bisTmJbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5259
X-OriginatorOrg: intel.com

On 2024-09-30 at 09:50:45 +0200, Peter Zijlstra wrote:
> On Wed, Sep 25, 2024 at 04:54:40PM +0800, Chen Yu wrote:
> > Commit 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
> > introduced a mechanism that a wakee with shorter slice could preempt
> > the current running task. It also lower the bar for the current task
> > to be preempted, by checking the rq->nr_running instead of cfs_rq->nr_running
> > when the current task has ran out of time slice. But there is a scenario
> > that is problematic. Say, if there is 1 cfs task and 1 rt task, before
> > 85e511df3cec, update_deadline() will not trigger a reschedule, and after
> > 85e511df3cec, since rq->nr_running is 2 and resched is true, a resched_curr()
> > would happen.
> > 
> 
> So I'm applying the patch (that change was not indended), but I'm a
> little confused by the above description. If we already have TIF_RESCHED
> set, then doing resched_curr() should be a NO-OP.
> 
> At the same time, how can we have an RT task and not get TIF_RESCHED
> set.

You are right, the curr should have TIF_RESCHED set if there is
RT in the rq, because after the RT task is enqueued, wakeup_preempt()
should set TIF_RESCHED for current CFS task. The 1 RT + 1 CFS task
was just suspicion when trying to figure out why commit 85e511df3cec
increased preemption. (besides the suspicion of
did_preempt_short() -> entity_eligible().) and the test patch
seems to recover the performance 0day reported, so we did not chase
from did_preempt_short().

Another scenario I'm thinking of to increase preemption regarding the
nr_running check might be(and per Honglei's feedback):
There is 1 cfs task p1 in the current cfs_rq1, and 1 cfs task
p2 in the parent cfs_rq2. The rq->nr_running is 2, and the p1's
cfs_rq1->nr_running is 1. Before the commit, there is no preemption
on cfs_rq1, after the commit, p1 is set to TIF_RESCHED and the CPU
reschedule from topdown and pick p2.

thanks,
Chenyu

