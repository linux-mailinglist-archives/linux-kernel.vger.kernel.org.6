Return-Path: <linux-kernel+bounces-186385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330AE8CC384
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12961F210CB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3FE1C6A8;
	Wed, 22 May 2024 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7/3BHm1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D92D51E
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389352; cv=fail; b=B2KV2y0VHVmk60hjwOfC8G5tSH7NJbVrlrAjilnCb1/Eu/beOAJKmNXuCPgXohCTzgLwI1IrSrzjPn+cksUv5CfhNemSKsEg0tWnRYP6r4PSqJXLyMA9I1KRYeF1NiTmW2D4NiQxXM3gmFb8rY+suJB1KDpTf1QOSmFqvmuAIjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389352; c=relaxed/simple;
	bh=AaZ25kyhIbcE6SSgAzYOd3OCPkG61ooUJX4JSJPRDus=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bmx7sAggTOEY9kj7PxQ4JMHxBk12fG2jOtWU7i4rX1o62T5M3s1RZ5X76DU5XYL2dqAh4G9T2O/wgUpf+8KgdsWe8jtIzxGWoM9/RlCNZQf0J5rjEwHC37i65xbEuzA9RkX3HG0GBYxHrhzrcUQlGNWNwgYrvz1OoYF23qR+uzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7/3BHm1; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716389350; x=1747925350;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AaZ25kyhIbcE6SSgAzYOd3OCPkG61ooUJX4JSJPRDus=;
  b=W7/3BHm1vuKd2x/xI7t/GuX4osTOaSup0WdndVdY31Mo6Pl3zxrjvVmw
   NN7Qg77g6mN0SlQ7Qoir0n37SpypF60A1I4Cjpf7nx82mOqhrnDTnu1EW
   yE3YV3+1YpGF3kCbFvIKjJn1IJlwuni7fwizW4A56OHwU1UTEnWSuiLse
   O4Yp6Y88NF73sKvOhTKiwsFkQEdFmqz1x22ht4RqiRZVh9+NmjH6xUBUH
   Efo/wr+yrpafOoOO8xI2eAr243O4LlyiK5I2Gy0uu1cVpQMEx823n3Zic
   S0Rp49qnnCQahlLmCwMygorJTiqeriWSD8L0TbummVe2GvDOOaqGIjfz4
   g==;
X-CSE-ConnectionGUID: IgqMv3jdQzqoUkisCdc5cQ==
X-CSE-MsgGUID: B9F4RXtyQlGIx0m7OghJ0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12825198"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12825198"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 07:49:09 -0700
X-CSE-ConnectionGUID: QgB2NCGqR7WZFAlKy6yXbw==
X-CSE-MsgGUID: KwEi2yvHRESVvrAUvEjLWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33181457"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 07:49:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 07:49:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 07:49:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 07:49:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPYCn4Ai8xHctCi2Xh2BRbCPQ13vbloN4WQS6uSbZFN9f+/Uiax7/2xTHQQwel+wnHdIxG8B0VO7lmQ8L0u8ZAy7MiYlJIXgccsd8Mq5/DMm6I7489mef+lbrBE5UNnk8aQizdN1B553j1XmrVov4ygPJfgtc14ou+MmFCyZUX2KH9Akqf86VKjSrBcrrE+PUR9lSVbEhY7sK6CRvT0+Xj6h2WxSzFbnjugIm05sOajdSIZX14heRTMnWb2oYpy2LrkBc4kHhBMtw5zCi/024fs5ON6upocaY4OIWhIXoNjkt6MfZFWV8ETY0JFi1p20vfM5j6fMUHEXESNwTQS3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poz65z4ZXZ5/GDBhojPo3WuBC4/gsZ73beRktpbvZ2I=;
 b=ZNnABrj9gBe0F0jPqWp6b7GIOfPXvP0fc/iU1ArQTSegm34wiRmtKQzP+Gh2tPsSNU3+QQ9pLc60ujcmyucI8Vrp3oERnbEj9j0smfU0kmum9payq247eQYE+KJD3QZV98tJwcFv6IKGK93T56lfhs6emAGRB3c+6dWpZ+/bSu+CNFDPb6KXBRKDnhbBssMtIwn7BZOTO9u/ACysCa53z98x+eF1en8RG2BFbHXRuE4W6d0TzN1cgh7d8O2UlviayWfTZIkh5FWsrd7oZvfQSw+nvbyC5iXNUQQJPTJraWfUZ7/Vkx8Dk18xC2xM+/M32DBn2/aq4BQ+5FPac4cskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 BL3PR11MB6313.namprd11.prod.outlook.com (2603:10b6:208:3b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 14:49:04 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 14:49:03 +0000
Date: Wed, 22 May 2024 22:48:47 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>, <wuyun.abel@bytedance.com>,
	<tglx@linutronix.de>, <efault@gmx.de>, <tim.c.chen@intel.com>,
	<yu.c.chen.y@gmail.com>
Subject: Re: [RFC][PATCH 10/10] sched/eevdf: Use sched_attr::sched_runtime to
 set request/slice suggestion
Message-ID: <Zk4FzyUImFy7DwWc@chenyu5-mobl2>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.934104715@infradead.org>
 <ZjpFruUiBiNi6VSO@chenyu5-mobl2>
 <422fc38c-6096-8804-17ce-1420661743e8@amd.com>
 <ZkMsf4Fz7/AFoQfC@chenyu5-mobl2>
 <f2eafde3-b9e8-afc9-8934-ca8e597c33e6@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f2eafde3-b9e8-afc9-8934-ca8e597c33e6@amd.com>
X-ClientProxiedBy: KL1P15301CA0058.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::18) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|BL3PR11MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c5acbe-6e06-4b0c-6b47-08dc7a6e5299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6uow2lXMh63xvoj9ShtFVB/WCb2EqghQE8+VvAbpEjmYwwxmzb6pyBK35fCE?=
 =?us-ascii?Q?oTV8tyY6sUP457Mr1UjbIehjjxyMfeyxHZwKYAFDpr8cAyWt8MtDn62aX4QB?=
 =?us-ascii?Q?lvTgzS0koYJcCGVIHhjx/aaUKxiQilU/cXQPPLGbroXwfH0fbuZGgdUv14u4?=
 =?us-ascii?Q?IQl+zZ0KpS+KKaDlxEPpqhF4F0Ucqhsn8eUvoUu8bYFND5RAtkDYRmgCs3kO?=
 =?us-ascii?Q?FYLZZsZz6Gtv1GLRIsWxt4JNdSmjg6PXOk3wDH11dzH0ryEteSxTRI7iB/bn?=
 =?us-ascii?Q?D+Z+yWPXHeBTwvjhbRHbF9QRlejwKgagk5+nqIb7cly0+Fi+g7pqRFUuserY?=
 =?us-ascii?Q?7d9i+80MFaIM8FLInZu+die/CxNZXmyzjnfoTRrBOuucXUA1BMkOek3wKJyX?=
 =?us-ascii?Q?ply4+NHlExN+ooGtHs2nyR5Jrzgv9sJZWg3N59F542zDrOEjhe6KISlfOJtk?=
 =?us-ascii?Q?v0CGg98GMOL3BP3zo0SpXLFLTS8c9G9sIcHkGZImBuJzbVufAz/s3g5anPGA?=
 =?us-ascii?Q?/uTFnDnunMFnzWk0uYqYa+VqbB6nMji3NcQxJxn7Zgfpprg+2z1vy4rPh27Y?=
 =?us-ascii?Q?hSu9HXiRc5li9TCcLK2MD9BmMljwpTAq5ze7Z7AJmDWzRPH7lQPHC8tMDRvA?=
 =?us-ascii?Q?D4cDla2qOby1tHfRsz/JoqFqdZLvS5WdGm/JnGworSwTzbTN4+n5QRKg/drk?=
 =?us-ascii?Q?a6CcvZ3xjq523MOIAawmD2reujTbFL6ag2B4vZiLMvLc/E7TvsP2oPaoTep9?=
 =?us-ascii?Q?vumMbCQb2qHvNWhVmGfQqOY3bG7MHH0dnxmS4/WI4XNg/no0jo81aPs5rK+P?=
 =?us-ascii?Q?YQpH+oEifMY96gi9rcStFf2xCLRDH5fWtM1MXNRcfhJDDs7mo/fPjGflbzIt?=
 =?us-ascii?Q?u2kF606SiU+rEhSrbPMe4p1pISNT3/MUr/7Bqe/H/OYKwT5YpLs6NlBUvUr2?=
 =?us-ascii?Q?z+lenKpQrwBn0LzZAobtvGIagU1bBIKTvjmPurRil5IFjNThZrp9FlrcqUGB?=
 =?us-ascii?Q?P1H4V/l3VyoF8PEVAla4nI7ErbyHCkltioh+pLa937BHvjoUenCCpcosLJVw?=
 =?us-ascii?Q?UflaA2wFROT55sqX4bjDX9YV5CjRRfk0ggWQ2MHgL5MxqedAKfbDHOEY5Tyl?=
 =?us-ascii?Q?U71MmLvm4J3mrQFFu0rridy3cP0q3AjHC/PqJkTADPWY15MwDWeIckGScUAx?=
 =?us-ascii?Q?DVmYF1LuaybwhJvKHxf3ZnSfv6ghHFAxYTHYKfWVfsD3n7gK+/oYRF1GbgmO?=
 =?us-ascii?Q?T/b4l2PXU9mm72jrHCNntUS8GZr9tIciXjbpBA5e1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?206qElRnPq1R7g6vxuoVbfFkitlc9AvduUhoFeFXTQETzOIvFsHSqwCXUSPJ?=
 =?us-ascii?Q?qfuBR+haH4obNJoGFqxz6QzjA7qAlxMAHPYuys9m2fcPRI23eoQ8h8h40S3j?=
 =?us-ascii?Q?QSb24bkICcHsqkuNrvADD477ZgGc4gX1Tnw8l/+4a6o6u0KPBCcRcuFlXWt8?=
 =?us-ascii?Q?Z6l3MwSjY65UkGCrrJCrHR59mlzMyIa1chTfPwUyIl59m9LPXkMy+c4Jc2L0?=
 =?us-ascii?Q?bcGsr1PV+wAYiI43Oon+WKo2SSKput1H0dAPCG+8J51W/qR+72R1wUDjwTx/?=
 =?us-ascii?Q?Z9asmNY4EKqh2wy66IGTTmsMzhz4wWe/YqbwPYP35F/HlvP8xvV6zwMYv98B?=
 =?us-ascii?Q?hTmPh3SbYkr4e/2CBTnLrVqxgjWbI7v5A1Ee2Uky8YCPM8UtsxpJvE1MtEzJ?=
 =?us-ascii?Q?G/q00LEHkbWVNZu+zHDXCq0Bx8CLTEGs6vrl3qUYiBnSb9KEfw6Zo9krnK3k?=
 =?us-ascii?Q?1L3bvxvgo5/IqvguUP3099/vnrmxUVwSEug5x2jKaysrMHuCAIne3FFP2Wla?=
 =?us-ascii?Q?5MztcT4S+RM5q+k61istV5wNDH6Txbf+DIoB1x5mp9ddHm1ShTQSoGqeo87N?=
 =?us-ascii?Q?bptEhxT57X2tVGqY/osK9EQEdkl1Ef0OnTpcIlb88jsw2Zbt1wMsBo6ClDLo?=
 =?us-ascii?Q?dXssriyrVXFzuRehLqf+bBZo/EtCtv4xYtpUOCQfhkGwNGw5dVp5e1nZGswz?=
 =?us-ascii?Q?SXYkNcc2gzFq71QN8UfSuTZxoMBynTDNBmJEPKId6Z89c6d/PrGX1UFCLcvI?=
 =?us-ascii?Q?5/qpAjsPcNza9aw9v6xFdrB6M7Kp1+iRlY8sKLuw44sUGpjXwZ3FGsrIbhCh?=
 =?us-ascii?Q?FYIEXNPWn0kwSFDMGFwPNqJwxv5+uJxUlFrJuPbVUXqiYUQ06GEz8l3pgljK?=
 =?us-ascii?Q?7/fJjmIzlxiXMw+wu37pFA/K5PuHKQ4f1eXGkSh5J+TIt6U/AIszZU7xmLPK?=
 =?us-ascii?Q?iiqkkHdCrKLnptapDCfpLPpDroQVg4o7gtmUsxFg1LuXu/RT6IeiEos95H67?=
 =?us-ascii?Q?C3b9zRWkG5L9fnfWSER6/HeAZ56FNip0j2+AQEN6Rdfnj8gA+INPYiZfVcUp?=
 =?us-ascii?Q?iM3/70qW+Knu6zMg8ZyYKhu+SOGMHmYsksRPbsI93VpkisPAKyWWKArH7KX+?=
 =?us-ascii?Q?lsLfaVq0GI9VmGAMUnaIaf8WTzw8aQ8+ocjJ1LG3PHAnSEZfsXrZ4hudi6pe?=
 =?us-ascii?Q?0MutGFKqBO/x2YeEPYYDcerIzBm7LZXBk1QSPrhzY5Jtg0FYjZs4cOQFq9/X?=
 =?us-ascii?Q?JBJbIqzFHQY6rp9nBFdI2r3cHxP/OGwEyTKJpIH7KdJBmM+sb+yfn3f9t7Ke?=
 =?us-ascii?Q?SSQBXHsVnljBDfREfMZw2+p4KsDdTTcHQThWFbCMikWozdAc+YzG3cx+9V87?=
 =?us-ascii?Q?tPOyQkWayUaM+OFy1/sIpes4n+CjSOyizGkkFXkRzplORGGg+wFuSoRbRtd4?=
 =?us-ascii?Q?hzZhqSO9MFuDWD7dERXSkoOu4/lKpEWEc6pw14LZbAls76VCalJOsY80OKb0?=
 =?us-ascii?Q?7Qfsm5rV1uiZLwVfnVisvIYibgIoiRmEvAYhqZFtFbttg7w91iURbtl6NxIq?=
 =?us-ascii?Q?7xRtdDe6/gpT9vpBxoKdb45XEFxQ/Nq6/l2FYSOn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c5acbe-6e06-4b0c-6b47-08dc7a6e5299
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 14:49:03.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcanvsrVFxa5+Wd7dWNqvqtD6kkWmywkn3Pd8huZHdR8dGybYWaZz73sO1mjqKQG8rDAz3ZSI+5M5jHwwAgeig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6313
X-OriginatorOrg: intel.com

On 2024-05-14 at 20:53:16 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 5/14/2024 2:48 PM, Chen Yu wrote:
> >>> [..snip..]
> >>>  /*
> >>>   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
> >>>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> >>> @@ -7384,10 +7402,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>>  	if (sched_feat(SIS_UTIL)) {
> >>>  		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
> >>>  		if (sd_share) {
> >>> -			/* because !--nr is the condition to stop scan */> -			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
> >>> +			nr = adjust_idle_scan(p, READ_ONCE(sd_share->nr_idle_scan));
> >>>  			/* overloaded LLC is unlikely to have idle cpu/core */
> >>> -			if (nr == 1)
> >>> +			if (nr <= 0)
> >>
> >> I was wondering if this would preserve the current behavior with
> >> SIS_FAST toggled off? Since the implementation below still does a
> >> "--nr <= 0" , wouldn't it effectively visit one CPU less overall now?
> >>
> >> Have you tried something similar to the below hunk?
> >>
> >> 	/* because !--nr is the condition to stop scan */
> >> 	nr = adjust_idle_scan(p, READ_ONCE(sd_share->nr_idle_scan)) + 1;
> >> 	if (nr == 1)
> >> 		return -1;
> >>
> > 
> > Yeah, right, to keep the scan depth consistent, the "+1" should be kept.
> >  
> >> I agree with Mike that looking at slice to limit scan-depth seems odd.
> >> My experience with netperf is that the workload cares more about the
> >> server-client being co-located on the closest cache domain and by
> >> limiting scan-depth using slice, this is indirectly achieved since all
> >> the wakeups carry the WF_SYNc flag.
> >>
> > 
> > Exactly. This is the original motivation.
> >  
> >> P.S. have you tried using the slice in __select_idle_cpu()? Similar to
> >> sched_idle_cpu() check, perhaps an additional sched_preempt_short_cpu()
> >> which compares rq->curr->se.slice with the waking task's slice and
> >> returs that cpu if SIS_SHORT can help run the workload quicker?
> > 
> > This is a good idea, it seems to be benefit PREEMPT_SHORT. If the customized
> > task slice is introduced, we can leverage this hint for latency related
> > optimization. Task wakeup is one thing, I can also think of other aspects,
> > like idle load balance, etc. I'm not sure what is the proper usage of the
> > task slice though, this is why I sent this RFC.
> > 
> >> Note:
> >> This will not work if the SIS scan itself is the largest overhead in the
> >> wakeup cycle and not the task placement itself. Previously during
> >> SIS_UTIL testing, to measure the overheads of scan vs placement, we
> >> would do a full scan but return the result that SIS_UTIL would have
> >> returned to determine the overhead of the search itself.
> >>
> > 
> > Regarding the task placement, do you mean the time between a task is enqueued
> > and picked up? Do you have any recommendation which workload can expose the
> > scan overhead most?
> 
> Sorry for not being clear here. From what I've observed in the past,
> there are two dimensions to slect_idle_sibling():
> 
> i)  Placement: Final CPU select_idle_sibling() returns
> ii) Search: Do we find an idle core/CPU in select_idle_sibling()
> 
> In case of netperf, I've observed that i) is more important than ii)
> wherin a placement of client on same core/thread as that of the server
> results in better performance vs finding an idle CPU on a remote LLC.
> For hackbench/tbench, when runqueues are under high utilization (~75%),
> reduction in search time ii) seems to be more beneficial.
>

Usually task stacking is not preferred because it hurts latency. But as we
discovered on AMD and Intel's large servers, sometimes the overhead of task
migration offset the benefit of running an idle CPU.

Inspired by your description on SIS_SHORT, and also Mike's feedback, I respin
the SIS_SHORT patch, to consider the task's customized slice:

Leverage the WF_SYNC to achieve better cache locality.
If both the waker and the wakee are short duration tasks, wake up the wakee on
waker's CPU directly. To avoid task stacking as much as possible:

1. Only when has_idle_core is false, SIS_SYNC takes effect.

2. Only if the user has shrinked the task slice, SIS_SYNC takes effect.

3. The waker must be the only runnable task on the runqueue.

4. The duration threshold is based on the CPU number within the LLC.
   The more CPUs there are, the lower the bar for the task to be treated as
   a short duration one, and vice versa.

   threshold = sysctl_sched_migration_cost * llc_weight^2 / 256^2

                             threshold
   LLC_WEIGHT=8               0.5 usec
   LLC_WEIGHT=16              2 usec
   LLC_WEIGHT=32              8 usec
   LLC_WEIGHT=64              31 usec
   LLC_WEIGHT=128             125 usec
   LLC_WEIGHT=256             500 usec

5. Honor idle-CPU-first for CPUs share the L2 cache(Cluster). Only
   there is no idle CPU within the Cluster domain, SIS_SYNC takes
   effect.

Benchmark:
Tested on 4 platforms, significant throughput improvement on tbench, netperf,
stress-ng, will-it-scale, and latency reduced of lmbench. No performance
difference was observed in an Online Transaction Processing (OLTP) test.

Platform1, 240 CPUs, 2 sockets Intel(R) Xeon(R)
========================================================================
netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	60-threads	 1.00 (  1.11)	 +8.22 (  1.06)
TCP_RR          	120-threads	 1.00 (  1.74)	+38.71 (  0.74)
TCP_RR          	180-threads	 1.00 (  1.21)	+108.12 (  1.07)
TCP_RR          	240-threads	 1.00 (  4.75)	+160.98 (  4.01)
UDP_RR          	60-threads	 1.00 ( 11.70)	 +7.17 ( 10.89)
UDP_RR          	120-threads	 1.00 ( 10.82)	 +5.54 (  7.17)
UDP_RR          	180-threads	 1.00 (  9.77)	+10.29 ( 10.87)
UDP_RR          	240-threads	 1.00 ( 12.38)	 +4.45 ( 16.69)

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	60-threads	 1.00 (  0.22)	 +8.67 (  0.12)
loopback        	120-threads	 1.00 (  0.20)	+42.12 (  1.16)
loopback        	180-threads	 1.00 (  0.16)	+96.36 (  1.34)
loopback        	240-threads	 1.00 (  0.23)	+122.68 (  4.87)

schbench
========
No noticeable difference of 99.0th wakeup/request latency, 50.0th RPS percentiles.
schbench -m 2 -r 100

                                  baseline                       sis_sync

Wakeup Latencies 99.0th usec            27                            25
Request Latencies 99.0th usec        15376                         15376
RPS percentiles 50.0th               16608                         16608

Platform2, 48 CPUs 2 sockets Intel(R) Xeon(R) CPU E5-2697
========================================================================
lmbench3: lmbench3.PIPE.latency.us 33.8% improvement
lmbench3: lmbench3.AF_UNIX.sock.stream.latency.us 30.6% improvement

Platform3: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480
=======================================================================
stress-ng: stress-ng.vm-rw.ops_per_sec 250.8% improvement
will-it-scale: will-it-scale.per_process_ops 42.1% improvement

Platform4: 288 CPUs, 2 sockets, 4 CPUs share the L2 cache, Intel(R) Xeon(R)
=========================================================================
netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	72-threads	 1.00 (  0.89)	 +6.14 (  0.95)
TCP_RR          	144-threads	 1.00 (  1.53)	 +5.18 (  1.24)
TCP_RR          	216-threads	 1.00 ( 10.76)	+23.31 (  1.67)
TCP_RR          	288-threads	 1.00 (  2.28)	 +1.72 (  2.10)
UDP_RR          	72-threads	 1.00 (  3.44)	 +0.42 (  3.11)
UDP_RR          	144-threads	 1.00 ( 14.53)	 +1.40 ( 16.11)
UDP_RR          	216-threads	 1.00 ( 17.30)	 +1.18 ( 23.00)
UDP_RR          	288-threads	 1.00 ( 21.30)	 -0.15 ( 20.14)


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1437c276c915..b2b838d499ea 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1003,7 +1003,7 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #include "pelt.h"
 #ifdef CONFIG_SMP
 
-static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
+static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu, int sync);
 static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
@@ -7410,16 +7410,36 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 
 #endif /* CONFIG_SCHED_SMT */
 
+static int short_task(struct task_struct *p, int llc)
+{
+	if (!p->se.custom_slice || p->se.slice >= sysctl_sched_base_slice)
+		return 0;
+
+	/*
+	 * Scale the threshold by the LLC CPU number.
+	 * The more CPUs there are, the more likely the
+	 * task is regarded as a small one.
+	 *
+	 */
+	if ((p->duration_avg << 16) >=
+	    (sysctl_sched_migration_cost * llc * llc))
+		return 0;
+
+	return 1;
+}
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
+static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target,
+			   int sync)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
 	struct sched_domain_shared *sd_share;
+	int llc_weight = per_cpu(sd_llc_size, target);
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
@@ -7458,6 +7478,20 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
+	/*
+	 * When reached here, next step is to scan idle CPUs that do not share L2.
+	 * However, the Core-to-Core cache latency could be large on big system.
+	 * Give target another chance if waker and wakee are mutually waking up
+	 * each other.
+	 */
+	if (sched_feat(SIS_SYNC) &&
+	    target == smp_processor_id() && !has_idle_core &&
+	    sync && this_rq()->nr_running <= 1 &&
+	    short_task(p, llc_weight) &&
+	    short_task(current, llc_weight)) {
+		return target;
+	}
+
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
@@ -7550,7 +7584,7 @@ static inline bool asym_fits_cpu(unsigned long util,
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
-static int select_idle_sibling(struct task_struct *p, int prev, int target)
+static int select_idle_sibling(struct task_struct *p, int prev, int target, int sync)
 {
 	bool has_idle_core = false;
 	struct sched_domain *sd;
@@ -7659,7 +7693,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		}
 	}
 
-	i = select_idle_cpu(p, sd, has_idle_core, target);
+	i = select_idle_cpu(p, sd, has_idle_core, target, sync);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
@@ -8259,7 +8293,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		new_cpu = sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu, sync);
 	}
 	rcu_read_unlock();
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 143f55df890b..7e5968d01dcb 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -50,6 +50,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
  */
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_SYNC, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
-- 
2.25.1



Preparation patch to record the task's duration:
 

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..9e8dfdc81048 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1339,6 +1339,9 @@ struct task_struct {
 	struct callback_head		cid_work;
 #endif
 
+	u64				prev_sleep_sum_runtime;
+	u64				duration_avg;
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 
 	/* Cache last used pipe for splice(): */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..c4288d613374 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4566,6 +4566,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->migration_pending = NULL;
 #endif
 	init_sched_mm_cid(p);
+	p->prev_sleep_sum_runtime = 0;
+	p->duration_avg = 0;
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..1437c276c915 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6833,6 +6833,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 static void set_next_buddy(struct sched_entity *se);
 
+static inline void dur_avg_update(struct task_struct *p)
+{
+	u64 dur;
+
+	dur = p->se.sum_exec_runtime - p->prev_sleep_sum_runtime;
+	p->prev_sleep_sum_runtime = p->se.sum_exec_runtime;
+	update_avg(&p->duration_avg, dur);
+}
+
 /*
  * The dequeue_task method is called before nr_running is
  * decreased. We remove the task from the rbtree and
@@ -6905,6 +6914,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
+	if (task_sleep)
+		dur_avg_update(p);
+
 	hrtick_update(rq);
 }
 
-- 
2.25.1

 

