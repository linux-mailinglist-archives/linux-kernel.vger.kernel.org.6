Return-Path: <linux-kernel+bounces-265024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A5893EB7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D89281EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC027D3E4;
	Mon, 29 Jul 2024 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7Grt3Ld"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E277113
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722220964; cv=fail; b=fys7rqnI1oW+Hq0i5NfGONxITdfuM0ZDDdMraTDzdIKLHKHCYdSwlB9eNIhylAWn632dCAdQifnLI6makRWsFj+iBXACXONoKIrl7c0eyWowhhqCJ/JDxU1XvQAiR39L90GhdhEibG+IpOWMuabr6tUe/ctJrgd+qZEQx5Sa0z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722220964; c=relaxed/simple;
	bh=WteWs1kydSpQsIr617wfSEyR5kNd2YG1eVRYDKmbE38=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jx/XvRdQSKl9lsyvtBhk24XTdtbTw+VDC1Gnv4BC798Wzlt6iCAQYfzRvTOAQLHgPt9Wv4tfrFx/33L538miIJ1eUnDXNzbYjaHf8cC/Nqr7hiLJrpW+p5iUDWEWeDptFqYp7lxPjCRZUAmhKll4xbTkzO5zNHL9Wus3sNcOIs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7Grt3Ld; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722220963; x=1753756963;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WteWs1kydSpQsIr617wfSEyR5kNd2YG1eVRYDKmbE38=;
  b=R7Grt3LdnAlVHp/VfJYeG3mKB2CPoHBib33zFnVC/SJX+CeIRPLr14Ap
   2uPbVC/O/Ezb+A4+OqhBdkj42UmRJjIFBuhEJkI7LBwWV6SAB5o9ivZZA
   IR8ySd2hvB/IhN0oxpRDYfcw/SNBvOj+EIIhAf3D8I657GmbQXsImvH0t
   St8i960ZS8Bu2nLCEBagdFoTtJXnmAuNM6WsmBMiitZaQ7Hzvhp+FYBhr
   WVqIQ/QGUEXP9zsK4zAdjJjoMn0p673AjSqK6iMqt+rcygDCJ4xQ+3ngr
   ngwY31RvZg3eou/bLioivNluTBxNF+I/+WFDhQiGiIf4yDCc0tC422Al/
   A==;
X-CSE-ConnectionGUID: QkPgpZLyTfqL43WF8koBWg==
X-CSE-MsgGUID: ub+w1SypQyKFsvKMZt+M3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="31353207"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="31353207"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 19:42:41 -0700
X-CSE-ConnectionGUID: lIm/aShwT3+OXtIcgkq7vw==
X-CSE-MsgGUID: Q/HWIvYlSsuZysajBivc5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="58646734"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jul 2024 19:42:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 28 Jul 2024 19:42:40 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 28 Jul 2024 19:42:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 28 Jul 2024 19:42:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 28 Jul 2024 19:42:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LA4dL782umtc32cN4FowZzGiInJyCI/KX8arqoO5tOWxRcaf0Ve5LxAZkCNhC8MAEBs4JV7d1Zp1muNk52SI2KRtwUzPTB3YmwpJUlrBBMVpJ5aEGVw9rxEorXrD8Jz3nxolMv1WsGLPRJVJLPwfZ+pHQQqUNa7G0A5l/mUyqp97Ldt+kVO7t0rAOftZkpkPjf7iaxyipLOHRIO5fux1R+ywB9WXC8ONcRjzMG93+DtvxFs3540Baq0wTiRL7/eN1SrT9DJOThaa7EKPkVK9htT9ZdGE9olMX7/H+wwT25lRfWqMRb63Amfv4AmsYCJlb0rdhpreFrOBXJdHJZ4K+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9upahtSULLDlC6APKr952PRs8b7nXbeSbNsCpMVPQI=;
 b=V1A0Z4SWAlHTs2zvccZmcj8Y5MrS1BghvGMmEvMhdIAs/emZ+hUaJy9RuCGNVWRb44qjur3djzts1yFoxJw+Esw3rq3yMQ3e+wRp1fC/aGHEHSvaSF9kYfXTI+tzIYfOdTL0rVnYi9qnzsRdIQxpAY/1UB5LsGPuSnVl5QIMks6z4LEin7jz24fn2uPRE7liHtv3OiS2XwQLEqvb9Y2CL1C23SsHxUyZA0uvLg+KTAS3g0pYyz4Te7ksbiurUjksSywknD4BgjCeyG5LrizT6ibKcj6wBEqIVebw+9O4v5dGK8ain6YITBe4KA0PA8KR7wKDFOjQKT85kHNZ582RJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB7766.namprd11.prod.outlook.com (2603:10b6:8:138::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.27; Mon, 29 Jul 2024 02:42:37 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 02:42:37 +0000
Date: Mon, 29 Jul 2024 10:42:19 +0800
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
 R. Shenoy" <gautham.shenoy@amd.com>, Matt Fleming <matt@readmodwrite.com>,
	Yujie Liu <yujie.liu@intel.com>
Subject: Re: [PATCH 0/3] sched/core: Fixes and enhancements around spurious
 need_resched() and idle load balancing
Message-ID: <ZqcBi9w1tGiMAMxu@chenyu5-mobl2>
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240710090210.41856-1-kprateek.nayak@amd.com>
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e083d5c-e3ae-45fd-86b4-08dcaf781ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R9u+SBLAgmxzzFCZPh1btQg0JgQz9ROLiSo34/KxsC+TuMAxqqAz9EdNZfoT?=
 =?us-ascii?Q?BkI4PdpcZRAgUpV3+WtKWSQD4pYVYUlKo6YWb+n7bB9gudUG/bYyDypbAzZn?=
 =?us-ascii?Q?kuvQu89lFJFLXaNa9j5KgxgJfBknyZL9OQGsABUfAhgorCta1yt0YA0B4qvr?=
 =?us-ascii?Q?3J1C7FlzM56rY8WKmSdTBzurI6NoXCY2LWEYxKmQkvnYwkoys/xRVu60pge3?=
 =?us-ascii?Q?Tex4p9IWU2SC1vYrCJHrXtpywG2dPD7MKVBBXGZd3ZC9ZalNHOIUfyHV5K0m?=
 =?us-ascii?Q?B3A6RCmbWl7LWlMSlqU14RjgN1vKijkEhXHhorMcM4c0kpaBkHzvDQjSbcyh?=
 =?us-ascii?Q?hAH9ZMUBKqMrobdaMRJh4mVXCN+WxFFw/e9+REqhejR7Z/ZDwV/zkSMnArX2?=
 =?us-ascii?Q?5gYAO/T0wR4o6Y6ZngiYpmncycTJUW3PVMgPKDtwDSqI4J1wGV7+BVsrRSI/?=
 =?us-ascii?Q?c3BOvYCNe1i1V67CmhTgkzEqMoQBKrwvJrucugE9gZ6WsXd44D47zDRxy97P?=
 =?us-ascii?Q?L1CrA68/gF/ooetSBcetKa7Df4ePZ5fWq6YN9dL0VXPqDYVWFzJgAbrG3i2w?=
 =?us-ascii?Q?S+RdLUfBBCiS9A5YZlXIvhS7EvKjasHA9VnMJVLdrwB3PKIFgea9YMpgm/+F?=
 =?us-ascii?Q?AnJthy/2HYHyV0mbJW15pzDCtGwu9NlDYLU67oh+ZJEVxD0ufDMgJwsJwWGa?=
 =?us-ascii?Q?jBVRqgVdO/aLAx3/MOu8+VKPFLBXPed5/A14xQsbjft0mtXQx7q2YGBwzoNu?=
 =?us-ascii?Q?j3Xk1EmmHZWU+lrIIXX8X34f7EGJ0Tt8tPRjTj3c8SQETOl9RASLKLXZ4v44?=
 =?us-ascii?Q?DIoY11/no3aywACtFKAjySPPq/0SVFLOF3faUxMPil0ULDc1zQhmruTJjOCq?=
 =?us-ascii?Q?wNIQ9BKlY2yJgxszREF5ITASbSzRwUVvUvfc4OU2MDM87GKS9qoAaUWS5yhb?=
 =?us-ascii?Q?oSEgpwqM54f/+xI5SJVSkODmmXTu3ANl7Wr9htPaigoak/4QoPmifAXpY7q7?=
 =?us-ascii?Q?i4eAiaYdIiS09p6xEmbYjyFkWYK3xizsop/j5PIMFZgu5ghF6drKti7Wumt0?=
 =?us-ascii?Q?frROzUF/tO6ErWBL6m0HnQBjWiRKkycOy7FxlrDCUJS8jVfOLbv2WY0TLSW7?=
 =?us-ascii?Q?ShOG1sPEk0T0MvnCAKjB6I+sfonVba0lO8SRfY03tsKPT3ml687w50XDFJjZ?=
 =?us-ascii?Q?1jFgeIR4xgA9cp3+BcmNP0LqaN+MQWa1lRNIJyUMhWEH8bkYlVrYnBeyB9TP?=
 =?us-ascii?Q?T9WqKw9YvkS0L2eeyhg3vb1OxhNLNcs+Vu+3wSkKAcBvPAh/FMZc6PgdmE0D?=
 =?us-ascii?Q?rbumcVQ2iHe47CYR5muYWAds?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?THGnM/b6ZZoh8SU0S9uv73Ga24T4d1HoKNfO7bgdd1v3i4XE7eYDJnKEt6gX?=
 =?us-ascii?Q?kSGiwyYp49OG6iftGkEAbgZpXhKhrjIsG+ubG9Gkn82gjn11mDKzJ/zeXIdG?=
 =?us-ascii?Q?llgmiP+Ue+RqKek7VZAYlQmzJgW4N0AJjd519tAg3IeGHsteTBTyOALgJB5T?=
 =?us-ascii?Q?KI5ZWGnWDBBEwDeClfzws9yBGwUYJAOogVeWqGaIrZHIhzl+Zu+F9IP0mzrB?=
 =?us-ascii?Q?2s6322sTdnP/bf8RUWHWwOE7IQIdSrcEEm2nPMQN/+pqhmPG7Srsbys1km2M?=
 =?us-ascii?Q?PObkp+ryw8Rbh8seISQzpoVsMJdTp9UWnJ8Utbpm3Or0P2tvW1vLGlngnBnE?=
 =?us-ascii?Q?Q+O9tP4of+xMPwhrd5XRwvirXqoxbZa3BYEWWW0lMUlcE5/6eR+xjzlSrMv8?=
 =?us-ascii?Q?JbjRsCy5EnezQVlO+H9td8GTWpGZ5E03hoxhE/sSVYy6EP57ZYSWQCgLmg3C?=
 =?us-ascii?Q?mUIr60vELeCMl5XkrQuIn7j4uYijfEeRK+lEN1sa+P0H3jvmEeCmkuwV1BbU?=
 =?us-ascii?Q?5JqxNNAb19Md3CbWFrmkWu4tZkUbjXtGQ/BPjSQNn3YTobpU+gETMU8pUOKm?=
 =?us-ascii?Q?MZMeSkEhiMVW4GUTBD/NCf7294qBwKqlSG3xq33LBq73YLadYr+TvjoUJ4aw?=
 =?us-ascii?Q?L28b1Y0G92y23NSkSW63y7lSh81yU+Oc05trvE5siiTCHAeDA9yOR6/T20yF?=
 =?us-ascii?Q?s63Ad/D8n/Ii7LRH9rotQOGN4qJvdPVCYgsv/ZV50R6IECluimgFYrAR35xG?=
 =?us-ascii?Q?dEB+jEJ01vYDSPJ2WJx3qOZVQK3IThQ4KY6YlIjn74bkPOwCAWoRjKVqEbhO?=
 =?us-ascii?Q?AI/BXL7k7LJTXmfTHuALpq5VdILKe5fywYpapPjA37jL33CMakenKk1tbkHI?=
 =?us-ascii?Q?9hB/EpPdpTF4nLh95yGys8E9IP6ewJDlZsmAx0+9+omzbMcdDa2TZ9FKxk/2?=
 =?us-ascii?Q?l9QFBnq42SDdNmcqY+imNDfePfyGo4SGfputhVfHZXFZWOo1puAjx+wmgzWL?=
 =?us-ascii?Q?4t5Nt1sXECq0U0GTf+oNYgs5hyg3CVQ0Jm1ZX4Qyxzh5Syz8heE/EExiQoZc?=
 =?us-ascii?Q?krLWxIcKt+NCM/8cQ6+8Xpu8iQqMacykWY+iNCaWGfroJXu3y+1C6BblgrC8?=
 =?us-ascii?Q?Okwd0HHcB2jtCTpdJMYKgj5fR0DYSAvwFmylBRFyWX2KkxHRjhVYQDxege/6?=
 =?us-ascii?Q?7j9ZEy5o20tcmw21xI70PBddHjKYGC8gaXbjN6N9dwjob8Rrv0XQUh1ySeh0?=
 =?us-ascii?Q?vbMQWpgyh4M2gULkDCLRETahGVXymD7BnCN3Z3LrGe9DsvnbjBvr3BF3LTab?=
 =?us-ascii?Q?6t1Hvhcii/GDWh1WpH4estXLlaBcywVL+HRBvMZz9ylUOAY54BeL3WQUxrcu?=
 =?us-ascii?Q?nKJJ936FNwlfVpWI2ukTrxc/KII1bXDmCVZOGUlDuSTUDTfPLgWmueEKjYzV?=
 =?us-ascii?Q?cLLGpkzV5OJ15DypHHwO/jcJK9PAvqrLacLhLEIqA5Z6chAMqRlD2BiEdzbT?=
 =?us-ascii?Q?LyX4djkcP+Zb12K7Fnk4x2umErt8+nqoPTHrDB9DSdXmra2ISu1HpEKaFrXT?=
 =?us-ascii?Q?tMkTxQ3MG3DEswJbFT8r+xjnYd94gr8oNXeqvZmz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e083d5c-e3ae-45fd-86b4-08dcaf781ba3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 02:42:37.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4eUPs5OA4EDB/tx0zfFQ1YYFHleWEX9MyKG0l6f9L3hpD1idHnsx5IbZVZu1K7SuNI6E7MOAnjl6AL+d0C/Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7766
X-OriginatorOrg: intel.com

Hi Prateek,

On 2024-07-10 at 09:02:07 +0000, K Prateek Nayak wrote:
> Since commit b2a02fc43a1f ("smp: Optimize
> send_call_function_single_ipi()"), an idle CPU in TIF_POLLING_NRFLAG can
> be pulled out of idle by setting TIF_NEED_RESCHED instead of sending an
> actual IPI. This affects at least three scenarios that have been
> described below:
> 
>  o A need_resched() check within a call function does not necessarily
>    indicate a task wakeup since a CPU intending to send an IPI to an
>    idle target in TIF_POLLING_NRFLAG mode can simply queue the
>    SMP-call-function and set the TIF_NEED_RESCHED flag to pull the
>    polling target out of idle. The SMP-call-function will be executed by
>    flush_smp_call_function_queue() on the idle-exit path. On x86, where
>    mwait_idle_with_hints() sets TIF_POLLING_NRFLAG for long idling,
>    this leads to idle load balancer bailing out early since
>    need_resched() check in nohz_csd_func() returns true in most
>    instances.
> 
> o A TIF_POLLING_NRFLAG idling CPU woken up to process an IPI will end
>   up calling schedule() even in cases where the call function does not
>   wake up a new task on the idle CPU, thus delaying the idle re-entry.
> 
> o Julia Lawall reported a case where a softirq raised from a
>   SMP-call-function on an idle CPU will wake up ksoftirqd since
>   flush_smp_call_function_queue() executes in the idle thread's context.
>   This can throw off the idle load balancer by making the idle CPU
>   appear busy since ksoftirqd just woke on the said CPU [1].
> 
> The three patches address each of the above issue individually, the
> first one by removing the need_resched() check in nohz_csd_func() with
> a proper justification, the second by introducing a fast-path in
> __schedule() to speed up idle re-entry in case TIF_NEED_RESCHED was set
> simply to process an IPI that did not perform a wakeup, and the third by
> notifying raise_softirq() that the softirq was raised from a
> SMP-call-function executed by the idle or migration thread in
> flush_smp_call_function_queue(), and waking ksoftirqd is unnecessary
> since a call to do_softirq_post_smp_call_flush() will follow soon.
> 
> Previous attempts to solve these problems involved introducing a new
> TIF_NOTIFY_IPI flag to notify a TIF_POLLING_NRFLAG CPU of a pending IPI
> and skip calling __schedule() in such cases but it involved using atomic
> ops which could have performance implications [2]. Instead, Peter
> suggested the approach outlined in the first two patches of the series.
> The third one is an RFC to that (hopefully) solves the problem Julia was
> chasing down related to idle load balancing.
> 
> [1] https://lore.kernel.org/lkml/fcf823f-195e-6c9a-eac3-25f870cb35ac@inria.fr/
> [2] https://lore.kernel.org/lkml/20240615014256.GQ8774@noisy.programming.kicks-ass.net/
> 
> This patch is based on tip:sched/core at commit c793a62823d1
> ("sched/core: Drop spinlocks on contention iff kernel is preemptible")
>

As discussed in another thread[1], I did a simple test to stress the newidle
balance with this patch applied, to see if there is any impact on newidle balance
cost.
 
This synthetic test script(shown below) launches NR_CPU process (on my platform
it is 240). Each process is a loop of nanosleep(1 us), which is supposed to
trigger newidle balance as much as possible.
 
Before the 3 patches are applied, on commit c793a62823d1:
 
3.67%     0.33%  [kernel.kallsyms]     [k] sched_balance_newidle
2.85%     2.16%  [kernel.kallsyms]     [k] update_sd_lb_stats.constprop.0
 
After 3 patches are applied:
3.51%     0.32%  [kernel.kallsyms]         [k] sched_balance_newidle
2.71%     2.06%  [kernel.kallsyms]         [k] update_sd_lb_stats.constprop.0
 
It seems that there is no much difference regarding the precent of newidle
balance. My understanding is that, the current patch set mainly deals with
the false positive of need_resched() caused by IPI, thus avoid newidle balance
if it is IPI. In the synthetic test, it is always a real wakeup, so it does
not cause much difference. I think ipi intensive workload would benefit most
from this change, so I'm planning to use ipistorm to have a double check.
 
According to the scenario of this synthetic test, it seems that there is no
need to launch the newidle balance, because the sleeping task will be woken
up soon, there is no need to pull another task to it. Besides, the calculating
statistics is not linealy scalable and remains the bottleneck of newly idle
balance. I'm thinking of doing some evaluation based on your fix.

 
The test code:
i=1;while [ $i -le "240" ]; do ./nano_sleep 1000 & i=$(($i+1)); done;

int main(int argc, char **argv)
{
	int response, sleep_ns;
	struct timespec remaining, request = { 0, 100 };

	if (argc != 2) {
		printf("please specify the sleep nanosleep\n");
		return -1;
	}
	sleep_ns = atoi(argv[1]);

	while (1) {
		request.tv_sec = 0;
		request.tv_nsec = sleep_ns;
		response = nanosleep(&request, &remaining);
	}
	return 0;
}

[1] https://lore.kernel.org/lkml/20240717121745.GF26750@noisy.programming.kicks-ass.net/

thanks,
Chenyu

