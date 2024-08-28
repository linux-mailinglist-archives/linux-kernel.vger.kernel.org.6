Return-Path: <linux-kernel+bounces-304238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9C8961C68
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F6E285110
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FEF85628;
	Wed, 28 Aug 2024 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWyvXyIt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B401DA32
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813778; cv=fail; b=M0ROokSkRyeTTiky6gqvnJOJtsOCeyw3282gptnenTce33jrxKwWWb7M8kegWmYgmlF2GtLdwpWXekw906hexGgcuCHvTI5Ds6diPBlmD76mrxxIOsikqE8lPYCgAQ2Z7POeySPAVSRaF1qQoo97JHBINUlevUYbScqmqCNE2ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813778; c=relaxed/simple;
	bh=mjQ8l3Ij2L3SekrHc4l4sSsJYxpK8R/ueLyORnBCz7s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r3oDqOKe1eewf1qGczzTPhfzhMgf5yutpwh2zqok5NOpZDTM23vMwHlfOXxtxdo63CGPvO51VS73N9KgQ/qyWBFWbiWX9uxbseWzb4qMnwv1A2yw2tgV6k6moGwut1PFVReyDyNnl/DofsBCb1rnEXmXUyDnOdEAxv00ObcB42Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWyvXyIt; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724813776; x=1756349776;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mjQ8l3Ij2L3SekrHc4l4sSsJYxpK8R/ueLyORnBCz7s=;
  b=XWyvXyItSICY7M7QIYDk6e4cBSJfYYj4p2L/KRmklK6jphPbHqmF3OAl
   sELRtPiEP6FkT5lmVuN1XN/ltYPubqmDF5qe8WCMNKr9AOSD9LSCgomka
   nykb7nYW974dK6W2NvlF62kJ9uoJKOb7YU5OJVLZI2AEizF5EPR0fvSKA
   9AijHyLWA6pYYC1fvCvfwm1fh1D9wbXWFzYJtL25a5ryyWMLZ/y2Luv90
   A3ZdfwG8wumM0+qWWCuaEIzhktp5DLcK0VXXiALcqeMOuBCGW4DPfW/0b
   IqpbdlRaYMmEY1TFVsfLOCbNMO45jsFQWgPBcfNnnXWtfI80wpRDv+VRX
   Q==;
X-CSE-ConnectionGUID: IMj4peTrQhupvZfpizj8pQ==
X-CSE-MsgGUID: TNAt1YgbQUemHNebL3AgeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27116696"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="27116696"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 19:56:16 -0700
X-CSE-ConnectionGUID: y8EGTPcwRR2mTOU9WytXrA==
X-CSE-MsgGUID: tPVmB5ffSlyQ3RyczxEzuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63034631"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 19:56:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 19:56:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 19:56:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 19:56:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtzLboKJoTPEKZhW7fPcQRxDhNcX4bUicRz1ZUJXdQjpJo7SlTg7dDogvnU5Y5jtsEDqGQuRsyjdsQuCo4F3vJ7ptKflYJMII0+0T2G+IHVDnNlE8B5zdrvFwVbmDwqkBe+S9XWs1FoYUTqC8qH1RtDy7h1jrcEsyskKiUeYGXUSCTlzSj6k624AK/1JjjCXWYcgDKzDbE+Non+QqzCnswH6RqhyYJxnA3V7YwFnoO6I8D32J5kZ9tGm+gVM3O5uhJy9DzBu4oQDPxNqp7FL0byLJ2GJOUCgD72oNApCjww2WRKce9H1LG7T9Lj83GPdwexoWgoI6EQIHoShWf/XqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx4hczDQEOc1sx+YEx8iqyG/okOb0ObTHIL9KT7rA9U=;
 b=CH29mrMTRx1vHb7PV9peiHoA4rmaNDIksieRmf3qYsk2Mj0F/wkvye6vmsBLc7oJdhVbp4C4/rWiX+AOPcawgnjSj1hy4MfUZDgMg0fuyvT/CqL0sn7w2vHeSUK9Zd1dWJWwbZ44XxWS/szZ85j7SFDSIe1MVBMNdNPdTxUOVWWLE1COTXCuPcwyPdpeOJBmYXo2tLVVxn7bBG63x5GoTdEbAbm+JlIiEVMKH+6jx2dlUyQuuqFXBvucx4Ej4wCZcYFQ2UTTaZnO7tCAmviWQelpyctcTk0gvVr2WccFiYHUkBgYkLn3nhF8LaGQxuUCrkJqCGm8kpDZQkXm7w40cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CY8PR11MB7171.namprd11.prod.outlook.com (2603:10b6:930:92::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 02:56:07 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 02:56:06 +0000
Date: Wed, 28 Aug 2024 10:55:53 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Valentin Schneider <vschneid@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <linux-kernel@vger.kernel.org>, <kprateek.nayak@amd.com>,
	<wuyun.abel@bytedance.com>, <youssefesmat@chromium.org>,
	<tglx@linutronix.de>, <efault@gmx.de>
Subject: Re: [PATCH 12/24] sched/fair: Prepare exit/cleanup paths for
 delayed_dequeue
Message-ID: <Zs6Rue1ebxWyjnLx@chenyu5-mobl2>
References: <20240727102732.960974693@infradead.org>
 <20240727105029.631948434@infradead.org>
 <xhsmh8qx0y4n0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240813215421.GA10328@noisy.programming.kicks-ass.net>
 <20240813220757.GA22760@noisy.programming.kicks-ass.net>
 <20240814055330.GA22686@noisy.programming.kicks-ass.net>
 <Zs2d2aaC/zSyR94v@chenyu5-mobl2>
 <xhsmhed69ogjl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <xhsmhed69ogjl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CY8PR11MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 107a37c1-5ca9-4c2d-5386-08dcc70cf611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dGo8FISiXrGsxHaHgHcbIyKHjcOI+79Vpnm7lDlMKe/TcDSp604zDxzaWA44?=
 =?us-ascii?Q?4WvLaNuZSoPgR6Xk5RPeTDl64IjzT+zL6f+EA3+5oxa+Mm0aXH+XNWdLrYAh?=
 =?us-ascii?Q?sD5TnQArwB/3AXRf7YOb1lB3hQ8PhBw7i+tB/kjAUH/GVDWgDLR+ywSOkybY?=
 =?us-ascii?Q?f4Z0XjZ6UaP91UTT2eXeewch4o7p0Mlcp0PHtKQbl3DgDCJxTuQyJGtnvqka?=
 =?us-ascii?Q?D3vLMw6aUP0gBLtOPjvIMWmd9hoM5qZgQHiDMZN1lcPdvTpJsXuHdEef8o5E?=
 =?us-ascii?Q?XiA3lC6I6HpWMenk8KiIYYWcwDq/tsboc6rH0HGLDlItLAQY2N9wC+08eaSI?=
 =?us-ascii?Q?fDzezkcQVNA5iLptXj+xqcwuGMJhW5U7ZzDh9tqMNXUf8LPEkFVb6PBQUmia?=
 =?us-ascii?Q?OdixAzZznEpkFQicX/+2ywtMW1OiZFiC5kRnANK6KLauQhhJAYKTuAgTjgmz?=
 =?us-ascii?Q?t5MNGnsPF1WiAtLv8C6NL0WTeUZOoRYlp4RD1r3M2iH1zXEA/acN6DTMalpW?=
 =?us-ascii?Q?s6YKhb160JuXIUsgJX8jtn+YarEnxjpVpzB2nxQJpHbHvLCF+PrvzGrhgu6v?=
 =?us-ascii?Q?UcM4GrY2A3HBSgmGjce5UuYgT8XMPPUbyXmsCYqgicFC8uUb8jhk50p9hl75?=
 =?us-ascii?Q?Eph0XdM65zHNMIgpJx/t0npSSDEp3YEyrbKt3DZ6S0b38+wltE5Niuhf6qGZ?=
 =?us-ascii?Q?lZKxwjM/QjKBPyC2czmzLsFYEyUFRxSNynDMndiaA2kB1Z4A9lIVCF1GPzQ1?=
 =?us-ascii?Q?qxWUT3dfaKfMF0hcXiznud/7MaioTWFLgK4xZ66oZhtZDxTY8KsanpdKmY5q?=
 =?us-ascii?Q?c8N/ktHU8pDVoOttxLUWZP+7u4QwfxqDnu19EEOf5PRyxot5C8uH90M4gvY2?=
 =?us-ascii?Q?KaDloleTeMKc0je8mbEem4ee33z4+mqthD+8f3ZTvjDxGel7kQQ/BA5GXOHH?=
 =?us-ascii?Q?+MlSzhjy9TDVjP1tHGsrIUJPG7LyWwlaqJ9cSZWsakB46F01OWOrsdOV7hLc?=
 =?us-ascii?Q?LpB219YWtD4Ay+5KpyLEaDrn9BeJkXRvhLTn38Z52XUXduQrW38fedjwxE1l?=
 =?us-ascii?Q?VJ9foGlbaswl9/7/HeFNQkJ4XBUxtw/ZcZAp0VFK7c+C9ndOkETj1OehoXDV?=
 =?us-ascii?Q?nZAGaM7oB3xl9DcZ7FpBGxibT3XFeYPliMGK2203qbH+kzlakpsyV9J2lIho?=
 =?us-ascii?Q?IKayFZxf8ZgJMQQiq/qMkrAJ8kZ5UkJ0FjOcC729gLTjHw7DkjHcOeIWdkTa?=
 =?us-ascii?Q?dorCQutISDfoYBuyj+md+/zA3aY9Pw9Iv0mNqKJJBZN5OpKF2IbMfkCCD//8?=
 =?us-ascii?Q?CxY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vX+RgkTpyFrOZZz7GMXTloCcFt6jJDSuJKpgpVqAKK3/D5juk4/RzPDEF/RO?=
 =?us-ascii?Q?eTHQcv3aGOs23+DJZ++ccT9Z/qqGq21xB4RMtjFD7IiOi1lOtQpv+DtevSvs?=
 =?us-ascii?Q?Zg/xFLEfwckeNhAztF7gf4Fj6l7SAhSRVTxw6+NJbJ4/TueB0u4LG2eV4+Em?=
 =?us-ascii?Q?j1HNcotyt2dDOUXOuEWwSnfRs+Aljjk48Jq1lqavvUIq8mQWeTcpqfupbdJT?=
 =?us-ascii?Q?HCCo5Kr5dqQSKhuMiK0Qr8CUzR/Qegt0pnWmY9uOdiby9ClG6JbwNrjL6H3r?=
 =?us-ascii?Q?Y8m87Fw7seauoaL+bX0Lbcedy3LwkhVzHOsPYNxf4rDQpj6fIBRJPQiv+WJk?=
 =?us-ascii?Q?p//pkLgKuLLY79i3IdVfSi/6JthqZGLx5bANZajWkZ56kDCqAZqKV6+8J3LX?=
 =?us-ascii?Q?8qd/VCFnHZrBlQ0g5ZWAV5bK1WzXXBfNoUttC4mxcBwp/6VfEyYQTebfAw3E?=
 =?us-ascii?Q?O3lI2Aa3lUJvwvkW9/HFV0UqUgR/PHmq1aIdHbhDcUXK63PWk8CwMqELdeDY?=
 =?us-ascii?Q?1Li9u6ADSX1lIlm7WE96M0BJ5bao0jbV0mGMScChZUigP7w2eSJX9VFqY/AY?=
 =?us-ascii?Q?Euphn2L8Lb0tb08p6kp6HOqksmsGz8Pe73RAjjFD0MdFacpU+UVw/XmGU1yQ?=
 =?us-ascii?Q?CA1qSOMVvWbN06qTSE4MwTwKRA8ZH/7JuWLnLJ6Jlm6R+Ntxn1MWnGPHoJnj?=
 =?us-ascii?Q?Q8LpJZbN27nYzBl8riZgXqS7gRaSDj8XugOy0m47R2LWO+w3dF3OSh4Z+k0M?=
 =?us-ascii?Q?sFi4ikP3Te8/0gEHm44dH/VJCumEGDmKuHbYoWq1a7SpKaXBlmuEuOI2P8V3?=
 =?us-ascii?Q?k5l/IpdmrIUOURbXtSFIPzs2XhjIoMj2wZH9XhRyn0n4sXjkVSwsnrF9ctri?=
 =?us-ascii?Q?31HiJnGY3msEAchQoRVKxQ2mFjMq3fXbtlRclAUaaDtrO4nA29elSsDxmimi?=
 =?us-ascii?Q?KteDMGJK6ZYqww/IHENOFEPhzR2whj47n5i+Xo8GdFvRMccoC9R+oXISXpt/?=
 =?us-ascii?Q?1Au6gktdILUFL/7BdNz8LKpFXrCVfP3NLPuxIRkyjTD7YCNegY89L9lbggBZ?=
 =?us-ascii?Q?SgxI/dcbWxQBa3c0ssJXXnu0ON8SYRuFgP8aPi7WpuPKV35e/8RyodXhAEpe?=
 =?us-ascii?Q?a2xAuUHPKqS3amqHbBvG2vELeEvbypd2bfLo/LsK6Lutfy6U2C/vhOzL8vOe?=
 =?us-ascii?Q?9Bzf04zLDJwziO8DN1cfBrjqnlhU+THasPv7ICXYxJ2TgyteaTppBK+5UHwd?=
 =?us-ascii?Q?PpBRdJO0EvwW4fjrX7rwNZJCECABrwoJg1QZ9WGcJ+qG6yX6grovtsfvTDQI?=
 =?us-ascii?Q?yx2z7J1sPggQ7y+CECH7ci3E3Z6uJ8Il61zvLYO1WklcQcDbwcYXf9+jRnHL?=
 =?us-ascii?Q?CXQqhiliLUn/WwnmGu6mWIwRgzmq37Wf6++1qYSnIeXcOpppjCwkW6+n6XD7?=
 =?us-ascii?Q?dNSC7nAJs6AH+IhUwsgepSwj4qKJPSMZUdIL+Co8fHfzWL90aluDED0vfnaB?=
 =?us-ascii?Q?GUxAK6JG7NJeQsRGS79dm22DYLQV6PcZfH+evcVa/E8xzXVWEguTaGWVEe/m?=
 =?us-ascii?Q?0rs8Qw//8O6HdKKF6h9Wsh3jqlA3o+FvVCrgnqB6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 107a37c1-5ca9-4c2d-5386-08dcc70cf611
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 02:56:06.2814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsQ7lgbn3ev0ybYzCCC+84/7LMkNEFJRF6bfMx9d1ao6xuJmZMWW2jha2TJOH7Os/MTLMuiwL44SJXOE1WlD7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7171
X-OriginatorOrg: intel.com

On 2024-08-27 at 22:29:50 +0200, Valentin Schneider wrote:
> On 27/08/24 17:35, Chen Yu wrote:
> > On 2024-08-14 at 07:53:30 +0200, Peter Zijlstra wrote:
> >> On Wed, Aug 14, 2024 at 12:07:57AM +0200, Peter Zijlstra wrote:
> >> > On Tue, Aug 13, 2024 at 11:54:21PM +0200, Peter Zijlstra wrote:
> >> >
> >> > Obviously I remember it right after hitting send...
> >> >
> >> > We've just done:
> >> >
> >> >    dequeue_task();
> >> >    p->sched_class = some_other_class;
> >> >    enqueue_task();
> >> >
> >> > IOW, we're enqueued as some other class at this point. There is no way
> >> > we can fix it up at this point.
> >>
> >> With just a little more sleep than last night, perhaps you're right
> >> after all. Yes we're on a different class, but we can *still* dequeue it
> >> again.
> >
> > Not quite get this. If the old class is cfs, the task is in a rb-tree. And
> > if the new class is rt then the task is in the prio list. Just wonder
> > would the rt.dequeue break the data of rb-tree?
> >
> 
> On a class change e.g. CFS to RT, __sched_setscheduler() would
> dequeue_task() (take it out of the RB tree), change the class,
> enqueue_task() (put it in the RT priolist).
> 
> Then check_class_changed()->switched_from_fair() happens, dequeue_task(),
> and that takes it out of the RT priolist. At least that's the theory, since
> that currently explodes...
>

I see, thanks for this explaination! I overlooked that the task is already on
rt priolist. I applied Peter's dequeue patch with minor fix and did not see
the warning[1] after several cycle test(previously it is 100% reproducible).

[1] https://lore.kernel.org/lkml/Zs2ZoAcUsZMX2B%2FI@chenyu5-mobl2/

thanks,
Chenyu

