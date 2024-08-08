Return-Path: <linux-kernel+bounces-279458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A24C94BD88
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EA6B212E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF38C18B47E;
	Thu,  8 Aug 2024 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gss4l3o0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07018A94D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120338; cv=fail; b=C5HrE5ZEpvW7rhy4+ruDkNOjPmzmEd5hjyNYLNkdnaeWK+lKvw1IwwMer45SKYcGNW5iTOlyZXi77w3qcZtF3b10LEJXgRiIHXiYv+C4B/K9DKUFR2b7FcsHoI9sIq9tdGPmkAg6uE/GV+MzJZcW14KjvQp79GuTRv40Pssbb1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120338; c=relaxed/simple;
	bh=l857Hg3Ucq2hnBbGz8E2uRJR9pB/YZqX/5x1XnZRLxc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L9BuNVAlG8qZhJdwT2f49j5Sxbd+mVkpqngqwehaAeQSKpDdl7EW/acp6UC0h/y+rwW9UD3qcVrIB6Lk93afpVkg+yILMWyZyFLcR5hC6hn5+pQCXVfZiB8PxdZ/+FmWwAK9ap0Dvvc3XOaRDaBL6dNJQWXEdEnceDa7bNVCLjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gss4l3o0; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723120336; x=1754656336;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l857Hg3Ucq2hnBbGz8E2uRJR9pB/YZqX/5x1XnZRLxc=;
  b=gss4l3o0wXLFMRmKhFokHDx6K8/JX29oUhdFJCGXAv9cWgQrkqFKJ88H
   SdeE+1YflvnlsEFYL51Ez7Xv+ZvFoCv2JVfFVVujy74wNRfCqAKDdxjJ2
   /q/OlK4zL0Eq0Kvz7+0SUjk9bF9qQe5gjZr3joRrN4b4CYyRPAAJynlX9
   5fhtGGz2mZZ0aDy2ZeRpgxDa4u3Gd/xWRMZ6QguIGoa+LSPybOQHT+KAr
   QlSUfiYxl52N2z+oGM19YgtAZXLBBpzl7bTPbjy2FebL5ro3JHp4Gadat
   yDD2mQff+AgFeqF65dLMv56WJ4YlkLSOqodBdDjTFXLXWoNGCGBNCR9Jl
   Q==;
X-CSE-ConnectionGUID: Pz0XWifkQ36xoNNw1Xw9Fg==
X-CSE-MsgGUID: fRkdZVbNR4Wo4EFC1Tm6WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21212546"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="21212546"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 05:32:16 -0700
X-CSE-ConnectionGUID: mIyLFSFTSYivDTcDGCFk9w==
X-CSE-MsgGUID: i42Q7La7TKWOXLDTpb98gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57125329"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 05:32:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 05:32:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 05:32:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 05:32:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 05:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpbV5QVStWgaMDP8u+ZJxa6zSyLkeIx9Apoy82ynfQJs/ov29ymKRajpAUc2HDRm1bY1C+/RvBoisoBc59sIcksofuIxPhrWrV9OUbHifgE94p27L7qQoGuM+joa22Jq/g9YOpXzsF4s9374jst/rcf/VZ+V0rsl8ojeWI1mm19r4E+a2TrsBn+CN5JpoBjNQlJ4mjJk4kvEnSofJDeXv34a2he2fZjsBRijwcg0usEbEY/lp2qG4UwTu+ZisEg9Ivh0naI9KJy/baWKOfiNSkwB55bh1gVmT+EZFK/GqRbejb0hcBDDELkN60QXJZ/jqaeiVpeNs51xOT60bslq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPseV5w6XZFNAGSQCPi6I6WE5LG0IszyXfykqKLJLVU=;
 b=i1cAL+VU6dXrHSHzryA7h613/KglKz+4sRbkm7O2+tuZnDgxeq+M79Ottz5wrl+4s74XbqUkM5G6fWUHDnHmYpoZ8lWj7H7HFGu4yVGf7MkoF9yM2ilb4fA87oB+B6oH5oKbUFcHcd9iQ7zPFm7FsDFM2yb6hX3ihS+HCAd0BOYnXrhumkY+dcSzZqbWHMzcqH4McrHenjjL5K9fIZ3yB1Ww6GQzlZJ/Xk7bcx9JAVMMjOnpp7GZ1bqGoYFp8Pg3XZsiSfNoIaxe9ghWdinrgzMWG3Q/SkMUzNjBiDIjv2vZRUhSlBaQ5dy4n0qEcEKo4QnH3CHeVTMUHnsXxAqpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA0PR11MB8336.namprd11.prod.outlook.com (2603:10b6:208:490::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 12:32:11 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7828.024; Thu, 8 Aug 2024
 12:32:11 +0000
Date: Thu, 8 Aug 2024 20:31:53 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>,
	<youssefesmat@chromium.org>, <tglx@linutronix.de>, <efault@gmx.de>, "Mike
 Galbraith" <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH 21/24] sched/eevdf: Allow shorter slices to wakeup-preempt
Message-ID: <ZrS6uQfSfTtq96t9@chenyu5-mobl2>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.735459544@infradead.org>
 <ZrSa1uxiL7G8PnWm@chenyu5-mobl2>
 <20240808102207.GH31338@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240808102207.GH31338@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:3:18::24) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA0PR11MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 556543ec-e39e-4c41-3c46-08dcb7a62061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r6D622YuFy9o3SLrD1KWBZPrmGjqNSorloxxw/2Oj4E4b5VQKoocpZXIqPns?=
 =?us-ascii?Q?xPB53hj8A2z1P3/A2KHnRJFbF8dHwH2tJRlPn6b3Uv5bc7/zEfrwEiGSy1gF?=
 =?us-ascii?Q?ixve7NKBKlWbZY8uU8+HONTLslUUMZweMYstkpT98jQX3KvBOX8MD4ZvG5P6?=
 =?us-ascii?Q?yh7i3rP40SzT+5XHyH4M0aJQkXknW+J7wHkqhPhRMBEGc/zcDwk3iJWFJ9x2?=
 =?us-ascii?Q?CSfPfDRGLakffU98hKH52a5N39i5PbGoCsdwihoyVwW+NhsLP8GRQqRD/bum?=
 =?us-ascii?Q?XueHC5YxDwpQZm7PJiJoUL18fqoX23VUDXIG2Tu0DKaWLn0mSG+DbuNaItkh?=
 =?us-ascii?Q?meb2qm+YEJP4ONL2e1E5rhjz8G+mx4bGV3hSLKes/mLL2xximrULowzdIx7r?=
 =?us-ascii?Q?W8TutGCgls4DXPguA5KfSjaZGrh/Iu4M4ci+eI7I4VKVPVDe9NNn/k3f712C?=
 =?us-ascii?Q?FGnep9NShpIAtzKj9e8n99Eysx+ZN7OzIzUZRFukRnnPZ9BaEAEwJlTrrzNF?=
 =?us-ascii?Q?IooJ4zGaU5hGu3cGjDPLqhipJe9wSxIGgE1E974+1q7acYXK1UcROmFgy9Go?=
 =?us-ascii?Q?5PAPlMDkTRk+wy+0KQimiA91Xp0iluJP8/QtZhH6BWX75/lAxJgA52YfQ2Ay?=
 =?us-ascii?Q?jEpgeY01w+9CCIXsS01hGi8Hg/S/TbY+w1kkCEkqvi9FtRqny2NdpBY9+6v0?=
 =?us-ascii?Q?hFWnnYvMyOqHFVWlj+5HglLIz/DPT/6IA6Z6J6pHk3GHHAgod7/hf2m19w6l?=
 =?us-ascii?Q?uDn+1LDhazR56N5cI9/bYyN/hcrxvXAeNrCEP9XRXB1qkfo4VHigxtTnZKfG?=
 =?us-ascii?Q?V3Y+ulxIeCLZb9Y3M3UJdE3Jml12LDCcmbATRdEijjWLfb8Por/3YmZbGCuf?=
 =?us-ascii?Q?mLFaVYAYSDYR4p5t6uodTf8ihJd6zvQugIY4VEOt6bbj6WKlnw71c23ycdhx?=
 =?us-ascii?Q?EX+KxioUYjkMKTp80rsJuYFmcCJODc5f9u0W2FspUOewrgxjeGjDyRtDe4mu?=
 =?us-ascii?Q?bUOOvh4WbxSEYQhnB2B3pS1ii3cdtZS2FI1yR5C3Dcv9BG8PLBODMUJaL0X9?=
 =?us-ascii?Q?C9uM6swHsOiVW/5lt73TdJDzLmFkUV/buaJBpBEn6xSK80EEV9Q2Pjz+9SWp?=
 =?us-ascii?Q?5WymJSHZtWrQUnpm9rg7VpDhWAemlJ9p3tKOBMNn6wKqEZ1G3aBPlbQ4cGHp?=
 =?us-ascii?Q?7WrIprMR3gvAoMeEkCDxB7su095x7A88lMMg5e2cprLw/Y17SZjMtiPIiunM?=
 =?us-ascii?Q?fv/r3Q6vCxa6ztRn1m2MmOXuE+nSNxAYnt4XLONwS3/rvei8FDNM81iPc4Ar?=
 =?us-ascii?Q?0Pg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M3yV+4x2IzR64oreuspmoI+fHvt8mNRY4WXY7LMiZqXYjKTuQ8MoxLBT9ruY?=
 =?us-ascii?Q?nSXyPCymKTeOOQNsMDX4MhnEWGZezttPUfiVJ5/B5PJsNas7Zc5+hiW2fZBc?=
 =?us-ascii?Q?k5XORZbXkPNj6TnwG4DH1YUNR/mlWF0Gf0ZgB3ugWBvmg0VrUhEVqF52bM05?=
 =?us-ascii?Q?hwdqeVBLAGFeZOhjsdWXmSJGcojeBtxrYTbdcqdET5XexWsLRvpd/SxAFOlI?=
 =?us-ascii?Q?B1UEFmEqRBjUHjVU+T2L93YLjjFsYFKetqRa16e5wtAk0mKO7koHmp4aFUxe?=
 =?us-ascii?Q?a6a1XR5nJVSnK0XG9aurETyBc2SbeOy9xy5hVH3ssX5sw9clcrymMloJ5mbt?=
 =?us-ascii?Q?d0wWUhhuP899KQWbLQSCVMSlS7SiKviB1XHTZL1adSN/LYSc5ZQa51TR7pxh?=
 =?us-ascii?Q?xYIKKmEZz9Ebb22aWMEHMn3esX5ofbh1T+8GxYyeZJZjye327J4MJEalJSlX?=
 =?us-ascii?Q?HbB5bJ0W5NEbZeF1Ptv8+ShQyNAtUMGHLnzH+YFRFCBJ0dXKTxCLHcsa2pVs?=
 =?us-ascii?Q?8OWZG7eSTzxElVsKF8KXOeWVLCHAJTJSyGMElEX/LiQHcA5JgOLzMat/k4WN?=
 =?us-ascii?Q?TGLnqbQIyYLIBuigNkUILdLnUyLPc77sVDbtNDVAkJDFnC9x/FhiAw3gkhXU?=
 =?us-ascii?Q?u0gBOooGaMOWND4QsmP8P5Os1cALNAcg2LZ/eOxqVNDRl/nAQoh5o8uAUjK1?=
 =?us-ascii?Q?A0tRNVHA6i8l4zjcjSevsouUuYVUv5QKsAzWp056ltsnBuQ3tyUslcDTE/hR?=
 =?us-ascii?Q?Bjit9gReCmz1PahPPr8fVVLOM7p3x/jQT6+5KE0Y/PSOI6xchOJE8SmD1H3a?=
 =?us-ascii?Q?8OFPRmvNN4DniLqnBKH/vMkD/7Lip5v0fbVCfR1LiCn70oOWcQ85CtYjkBnW?=
 =?us-ascii?Q?CvKE1Usw99jd5oVQawHk5YpZl3OhnzrYA/yx8yNNGy8oBqJjWXS3WJW6jdoy?=
 =?us-ascii?Q?sx9E950t57UzHungca/6geg/SqBbqwU7WHwqXXesjfuDftoR5/zhK62jSZ7Q?=
 =?us-ascii?Q?DP68m3jahc3CmVcAazJ64KNEOYRr1z3xRHA+E/tCb4w0mVavrNhqdpiLYj5S?=
 =?us-ascii?Q?awT87I2NbFF6pK/zSgPiSM+PgxArZt61iManPLjnfw5yEZbB5lDufyWlLhKn?=
 =?us-ascii?Q?yfI/remVDu9+wrZnT4UNor5BiDWPbZI9D29r5pNuqRuuRvjrl3arBfHDXC32?=
 =?us-ascii?Q?9cgEP93k01CMXdJczkbAbZDEugjBZrctMWAuDzvavJtv8XcnuvEXBVZDxTky?=
 =?us-ascii?Q?PPkDFQulgCKNxnII3djQera4cqbeQ5wY6pgKBSNpac3Et5vPFYyjnNZFBlXr?=
 =?us-ascii?Q?A/t63NhOVafOPKvQYMJWeopkJENivD+qMJfXeayijG/4H5Ax5bphGUao5WAo?=
 =?us-ascii?Q?EmY1PSN9zBV31LCSLuRMGr9pYL1x1yAb8mNaaZMbOQCHmGdgU3tQ66jmUf5u?=
 =?us-ascii?Q?ZSuGSwgH2CbB8uCcKh4rLBvtk6YZqWnqzFdxj11tv8itJ+P+fsvyd87hfv4X?=
 =?us-ascii?Q?fIY+F69GWjBHmMqB4gjEOQa2sra4ly1gpK80RjaN6RNtlHwlDlPTFWjbJXUb?=
 =?us-ascii?Q?ZkeiYBvn0z7IEABJJpboXHo/XRvmuQULahYL3Jpj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 556543ec-e39e-4c41-3c46-08dcb7a62061
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 12:32:11.6832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApkKzURpHm/TMu3rr850BAz388N4hQyvHG2X87n/fFfo8bof1wcgkOUu+lgSmJDaXT4PogndY/yJN5Zfnnuf6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8336
X-OriginatorOrg: intel.com

On 2024-08-08 at 12:22:07 +0200, Peter Zijlstra wrote:
> On Thu, Aug 08, 2024 at 06:15:50PM +0800, Chen Yu wrote:
> > Hi Peter,
> > 
> > On 2024-07-27 at 12:27:53 +0200, Peter Zijlstra wrote:
> > > Part of the reason to have shorter slices is to improve
> > > responsiveness. Allow shorter slices to preempt longer slices on
> > > wakeup.
> > > 
> > >     Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
> > > 
> > >   100ms massive_intr 500us cyclictest NO_PREEMPT_SHORT
> > > 
> > >   1 massive_intr:(5)      | 846018.956 ms |   779188 | avg:   0.273 ms | max:  58.337 ms | sum:212545.245 ms |
> > >   2 massive_intr:(5)      | 853450.693 ms |   792269 | avg:   0.275 ms | max:  71.193 ms | sum:218263.588 ms |
> > >   3 massive_intr:(5)      | 843888.920 ms |   771456 | avg:   0.277 ms | max:  92.405 ms | sum:213353.221 ms |
> > >   1 chromium-browse:(8)   |  53015.889 ms |   131766 | avg:   0.463 ms | max:  36.341 ms | sum:60959.230  ms |
> > >   2 chromium-browse:(8)   |  53864.088 ms |   136962 | avg:   0.480 ms | max:  27.091 ms | sum:65687.681  ms |
> > >   3 chromium-browse:(9)   |  53637.904 ms |   132637 | avg:   0.481 ms | max:  24.756 ms | sum:63781.673  ms |
> > >   1 cyclictest:(5)        |  12615.604 ms |   639689 | avg:   0.471 ms | max:  32.272 ms | sum:301351.094 ms |
> > >   2 cyclictest:(5)        |  12511.583 ms |   642578 | avg:   0.448 ms | max:  44.243 ms | sum:287632.830 ms |
> > >   3 cyclictest:(5)        |  12545.867 ms |   635953 | avg:   0.475 ms | max:  25.530 ms | sum:302374.658 ms |
> > > 
> > >   100ms massive_intr 500us cyclictest PREEMPT_SHORT
> > > 
> > >   1 massive_intr:(5)      | 839843.919 ms |   837384 | avg:   0.264 ms | max:  74.366 ms | sum:221476.885 ms |
> > >   2 massive_intr:(5)      | 852449.913 ms |   845086 | avg:   0.252 ms | max:  68.162 ms | sum:212595.968 ms |
> > >   3 massive_intr:(5)      | 839180.725 ms |   836883 | avg:   0.266 ms | max:  69.742 ms | sum:222812.038 ms |
> > >   1 chromium-browse:(11)  |  54591.481 ms |   138388 | avg:   0.458 ms | max:  35.427 ms | sum:63401.508  ms |
> > >   2 chromium-browse:(8)   |  52034.541 ms |   132276 | avg:   0.436 ms | max:  31.826 ms | sum:57732.958  ms |
> > >   3 chromium-browse:(8)   |  55231.771 ms |   141892 | avg:   0.469 ms | max:  27.607 ms | sum:66538.697  ms |
> > >   1 cyclictest:(5)        |  13156.391 ms |   667412 | avg:   0.373 ms | max:  38.247 ms | sum:249174.502 ms |
> > >   2 cyclictest:(5)        |  12688.939 ms |   665144 | avg:   0.374 ms | max:  33.548 ms | sum:248509.392 ms |
> > >   3 cyclictest:(5)        |  13475.623 ms |   669110 | avg:   0.370 ms | max:  37.819 ms | sum:247673.390 ms |
> > > 
> > > As per the numbers the, this makes cyclictest (short slice) it's
> > > max-delay more consistent and consistency drops the sum-delay. The
> > > trade-off is that the massive_intr (long slice) gets more context
> > > switches and a slight increase in sum-delay.
> > > 
> > > [mike: numbers]
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Tested-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> > 
> > Besides this short preemption, it seems that an important patch is missing from
> > this patch set, that was originally from Prateek and you refined it to fix the
> > current task's false negative eligibility:
> > https://lore.kernel.org/lkml/20240424150721.GQ30852@noisy.programming.kicks-ass.net/
> > 
> > The RESPECT_SLICE is introduced to honor the current task's slice during wakeup preemption.
> > Without it we got reported that over-preemption and performance downgrading are observed
> > when running SPECjbb on servers.
> 
> So I *think* that running as SCHED_BATCH gets you exactly that
> behaviour, no?

SCHED_BATCH should work as it avoids the wakeup preemption as much as possible.
Except that RESPECT_SLICE considers the cgroup hierarchical to check if the current
sched_entity has used up its slice, which seems to be less aggressive.

thanks,
Chenyu


