Return-Path: <linux-kernel+bounces-234244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7520B91C434
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFF51F22933
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5ED1C9ED9;
	Fri, 28 Jun 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjnRD5OG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A05158215
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593646; cv=fail; b=CFSd3s5P4ZDsYEZ6ql9zI4qD+fwj3gabDQXWdmAQL6XI/dgnTlnxvhQy2efLCxeJzIgMSv/PcpS25pkVRyjAtDH1Q+9FLV68XOlVortW4KkX1uGxy00snsRAcJKghAVOMkaxXE0G426XFFp9yDau7u2wM+Luuv9xOZpvPF56cL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593646; c=relaxed/simple;
	bh=M3YXQlTIyMAtF6/D+7rpbMF+R2T1d2Job2NHYNvS2dU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jg/KtF62U3g9qB0I/Hro8aXzC5BvkloXOojDpVZksMpBDUQhOB5DByq8ovLz4t8qhuu79EaVwpgUW4rbJUPNBmOE65s8cHI4lWDpvrchkM5XvUc+GWqdCDtFvDPZb+LSTq//611OPrMaG6nzg5euRhdDkTC562wSIJH3F/kFBgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjnRD5OG; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719593645; x=1751129645;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M3YXQlTIyMAtF6/D+7rpbMF+R2T1d2Job2NHYNvS2dU=;
  b=NjnRD5OG+NQoLpfVWi9H1gDAAmzrLqmUYdyKiBA3pGrmqyxYL0M7ocZH
   PmqTuWH0pB4F2n7ybc8FOpo48vf6xTQKLCdvZJXb+KbGoHvvrQ2AArQwQ
   S9nbcmBNlFMmZXvNa6EKSr5YEiKu8a+0Enyq9QWaqkx2Ng26hJUoudBk4
   aqiJJvu9NbJp/iWZBdyigATpcSXlUCqHiNHNS00N0uU6Lbb3m9cPe6o7M
   az4fA8Ldr+agfz0QYbuJdBO/ickEBwb2CiZd3Wygo22kpXRvUXyqBS/Fl
   /a9/gXpmJaiNHJiPFDM5k3YOh7FROE2m4Kl+EA/uGAZ/8qvFEJ2P7HRCO
   Q==;
X-CSE-ConnectionGUID: v/WhfoEYRO6dNQHzwJPIBQ==
X-CSE-MsgGUID: ZpRs87oATneEL2f6O2pO1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="19687114"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="19687114"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:54:04 -0700
X-CSE-ConnectionGUID: wlEayddeSFW6hyUX7HAt1g==
X-CSE-MsgGUID: MGfYFVVNS826NbUyij/grg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="45214740"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 09:54:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:54:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:54:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 09:54:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 09:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHnU0saz1dELAummwP5Ev0WzeaZTihnIsW6hI3qmmMuspCzuyXKkz9xCR0CWlpaBJzAPECVFgtrKR5WszimGBoQ/dlEqpy8mFJgn0YJljiNswYnyxo8TAzwhp9VWVWSOlRRYBAK1sfOg2sAqrSMxcA4/DRPyMdpdo7uQmrGk9mdzPZYeEbsQWGtLKQhmbX6k4TVVXnq4qv8JE79z8q9uHUUDq4LAKP8MyGNuFNjKPTU32+tqq4IG+qguDyIjnmTOOeKwW/q2cq+iORQRIIhUHYKj6+qenKou9YCZWQiMQj3IWIRlEqEvVGx89Q3+n4iwPY/uZUUkYUeEwq1GOKQpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP4GCCgMvLfRaGInpRBMgoVba0r1PJONsw8vKaa3hrw=;
 b=PFcX6zTKVupVqNvEpcSu04qLoLk28fzf/YQDdNiosBM+gtAMBXMhqUmDhO0LnhqWUYPeJnpoCkdRwyEE51fvf5H02hGG17dc4/Pxtv0eKHoUPlv3xBOJ8vpIFhrGBRIl0ubUEXdmH2kuvTwIoDvkJ9M8kMKBfIzFpZ5BuY4gpMYQEQa8U7P4T7b0q5zHZ46kCQWKLch8w5yPqmbwk7FGo7KMunvk3952y0+CdT2p6cNmhLBhg3iU9aJ3rFLhUvrzJYsRUcB23yTvpcY4RXzut5kPPD0iosupS1O+//kQSZB2RS3v1aRBJwf0Mlou298tdO+fU2OHNsJAnzFKyi0jog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7553.namprd11.prod.outlook.com (2603:10b6:806:316::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.37; Fri, 28 Jun
 2024 16:54:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 16:53:59 +0000
Message-ID: <be5bae3d-a192-4ca0-9474-809774011f25@intel.com>
Date: Fri, 28 Jun 2024 09:53:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/38] x86/resctrl: resctrl_exit() teardown resctrl but
 leave the mount point
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-32-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240614150033.10454-32-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0354.namprd04.prod.outlook.com
 (2603:10b6:303:8a::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 16449d4e-d322-4f7a-56ec-08dc9792e844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M09nTHFrQ0JjaHNtdmpZWDdtcjJUd1ArZGJ6MHQrdmFtVkVNVXlVdW9xYmFD?=
 =?utf-8?B?VWVYT3R6dkx1V0lYRllNVnR6SE9zWmxZajVJZER4ZVNJbW5wYmlQUzVEaFFG?=
 =?utf-8?B?UmJEODM2VEpIN1dhOFVBQnUzM1JZY2NvQ2daNVYvZWFONUsxS3ZXdzFnb1Vo?=
 =?utf-8?B?LzcwRC9GYWxyM05RSlkrd1FsaWVJU1dRQkl0cXRsYXhFa2c3NWIyVENSRlJR?=
 =?utf-8?B?cXlsNUlBcmVCWVJ4SVQrdkhTeFJjalU4ODl2NnFtMi81ODZyZjBQZjJkb2xC?=
 =?utf-8?B?T1N2VFlaK2dJL1hrejN2dHdWVXAxeDVlY0t5ZUFOMC9XVXBWWFhob1FxaVBR?=
 =?utf-8?B?bUMyNFhZeC80cnloKzNaY3FQa2xESTFKcHQvWFI4RFA2c3k1U3JudVFPYSty?=
 =?utf-8?B?b3gxRXdSVGFUVnlTczhjU1pXSWFidTRhQ1NwWlpOQWZoeE5IbmJEVU1TWktF?=
 =?utf-8?B?blBpZDFKY0tFOE5ZZTQxQlZBc3REU3BOZ3A4L1B4bldWWGNmZFYvNldsSHFo?=
 =?utf-8?B?YVRpSEJKNFg5UmlJT3MzUkNqU0hacXZnUWVQUzhVWWx4cEtPRUZhWVVSYXho?=
 =?utf-8?B?aTh5eGZhUitzdDBFOTVnZXNpclFHbUUveE1IUWYySWhxb3VmNStlam1xUVBI?=
 =?utf-8?B?cVR4ZUhZSjBSMGcraXdacGYxTFJJN091V3gxRkZLMHBQdndVMDdwaUJwcFlL?=
 =?utf-8?B?NzFOMEQ1djF0aUxVdEg5Z2VhWTBYdzFPQ1Nuejl5WEd5T2FPNk1vVjRCeGVt?=
 =?utf-8?B?anI3cFZVR3IwZ2psblVEaDg2anFsR1Jidk12QVhuYmd0SXZ5OUY4dHVXWEYz?=
 =?utf-8?B?ME9DSVk5L05waURPUVBITWtkNDJLcG91MnowV0ZKTDhlQkdrNWhNVmRPak1J?=
 =?utf-8?B?OHRQZ2FSblNWNEhucjlKalFSMVEzUnZaUmZDb202RVhDc09NRmhZVmxlN0la?=
 =?utf-8?B?ME5wRWc1Z3Q3YnVmcFp2V1NwU1c1cUhLMTNjdTZNVXpNQS9aWnJ0NE5KenZI?=
 =?utf-8?B?d1J4c2Y2NlZmWTVPeEo5MmZWZ2NMc3Bzb3RldlFiZG9MTzBLNXNiUG80OHhp?=
 =?utf-8?B?RHZqYnRsOVJCTVR6WUlodlZPNlhYMlRIRE5IYXM3Uks5cEMwSWRVUlpvNG0v?=
 =?utf-8?B?NTB5U0dUd2Fxdm8rL21IZjh0Sk5lbWNKekloMnhrS25NeXlKZ1RNaU1vSTl2?=
 =?utf-8?B?TjlKdkhpMUZFT0xvSXZlY2o0ZjN4cWZiMHd0clROZjdTZjI2T3FCS2tJWUtC?=
 =?utf-8?B?dUU4NkdTQ0pwTjNQd2V0czFJeW9ScDFYQThKOG5zSzdJK1d4NmZhWmdid290?=
 =?utf-8?B?QmxDb3JCc3dCTksraE94NWdublpVQjd2eFRjTmVyRWZkME9XRUZNUE5kUWhC?=
 =?utf-8?B?WHR6WUpSZ3l3blFhOXBZci9weVNBKytkU2l0aHllZzRNSmlkYkwvZi9SS0ox?=
 =?utf-8?B?cnMrMytyK3huNE9CVzAwdW5nYS9Qdi9sY0RzVHFkZ01oSVNSWUtQVitoWjFN?=
 =?utf-8?B?TWtMdWN3U3ZPZFRYMFZiZWFwNlZ6c2Y2YTN5aWtWcGkxL0Y1MVdzbTA4WjdG?=
 =?utf-8?B?Sm1BTzJjanlzSEhNNGIrVXZDZ3NOQUlLb3VzZHdoeTRvSTBZc3B4d3RVTkth?=
 =?utf-8?B?enBMTDNiNmh5Q3hYbUdNU2F5eVRzcFhGVFFyS2VTSUN2VHhNTzNPdnl4SXRL?=
 =?utf-8?B?NEY5YnBoRmJtcGV5S3NienRRV3lSU3RhaTFBenFnRXA0MXdxMFdaNm9IbFFl?=
 =?utf-8?B?R0RaeFBMZUhUWXpTbzUxbUlyUGJ0bmR2TzZna2NEbFlUK0I3dzA0MVhJcjhH?=
 =?utf-8?B?THVmMmxHbnQ4VnQyeU1odz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE9GL08ySDZZSXkxRVBYOHIrVCt1UTlOcW03eHoreitKZUluVC84OWwwczlM?=
 =?utf-8?B?a1BXaWNlbE9tVlUvYkdUWloxYllUQThmclZQaHNyR3FvVmRrN1ppT0dTT2RZ?=
 =?utf-8?B?YmxvbmE1RUhyL2YyTWRSR3BnVkZwQ1I4eHZEaCtPZ1RHVkZscGlVaVdiRldD?=
 =?utf-8?B?TCtGNDJ2dEc5bUlzMmhVNDdpZGJMWlZKRGlBZng4TWdEQklESGlhZUFWZkZq?=
 =?utf-8?B?b3IzMmdvSjBxbFZrRFBsTlpEOGI0TjZpc1Z5aXBtQ0NuVEVvb3IybXpzMGtm?=
 =?utf-8?B?dGJkWndHSlpEUmlkUW1XZHhReGE2NGppMFdDd0FYdk1mTGhNcjdITTh0UURR?=
 =?utf-8?B?MGxLVWNpdFE0UnlWQUQ3c29GWXdKRW95WDBORCtrVldQN2RhVmdWVGlQV0RF?=
 =?utf-8?B?TWJmQWVHSUU0S3Fuc2FzV3FEUmc4aFViWm1ZcjhxaytVMnd4UWhzRnFQT3dm?=
 =?utf-8?B?Z05ibkFOYUR2MnQ0UkdNaTFRRXJUOGxobFd4cXg5VVhOSHo1aXg4S3Z0VVZK?=
 =?utf-8?B?Y1E1L0FlTHZOZXNRUjJjVXMrejQ0TTNPUnp6bUNVRnV5bVRMR1RaWWZWdTFx?=
 =?utf-8?B?MEIzK0RvYjBtdDVxYnlWUDkwRWtQb3c4VUdiT2FHckkvb0dDNHhvc2FiQlMy?=
 =?utf-8?B?aWZNbHBTTFZudWlUeEJudTUvbTVzMVlMWmFINGtRbzNuOWZ0VzFVUU1MWUth?=
 =?utf-8?B?RFp3Si95dW0wT3BsQlVnMEhFU0xoNVlvRlBva2VoWWdXcExiQ1NNNWdHWk0y?=
 =?utf-8?B?VUoyTW9MM1BIYjVmd25QSWlqazlhQWV5bU9ZV0srenM4dzJCQUZ6aXQwOTlj?=
 =?utf-8?B?RWFnaktYQVVhT29aMXRsY2RBdlhkSFE5NEtGZElIN01EN0lIRzMxSTE0SXFR?=
 =?utf-8?B?TzJWQ2hMZVdTN3FTZ01IS1JMQTN1SW9nVGZENGZrQWFTK2VFRllDSjAwa01L?=
 =?utf-8?B?cFVmT0RSM2t3ZFFBQVFvTDdUVDZkUlN0UEllQkhHdDBlTzhoVmQ3TVlhUitO?=
 =?utf-8?B?YURFQllFSWdKYy9PVmgwUXB0YndmMnB3Um83LzNaSXNsQm0zYkhUbGFFbWpp?=
 =?utf-8?B?cWs2OFl0Q0tNeTFoU1ZFd3dkbjMvWjcybUd4YjBQamY3dm4yYk91bnlXYWJJ?=
 =?utf-8?B?dlpuM0FKYWdLWGRybGRuclVWbTNYQlM0R0RLdHh2bytHU1Z0R3ZQNkhsQkZZ?=
 =?utf-8?B?QkxhTzRWd1lLZUljbGJYV2JSZ0lESEx2NWlwSjFvL0l3cVg1L21HSEpLdkYw?=
 =?utf-8?B?dERjQlJEOHR1V0tNZlorZ25XaHZMcmhIR1BLUHdsSXRHNDBBeTQyblBYdGhv?=
 =?utf-8?B?cG00U2JZMFBkNGhybzhmeXJGT040VTNTQ0swTXFlSlp2MUZpY0oxWkluUHRS?=
 =?utf-8?B?SU1LT0lJOEJrcldJVDRaTElMNHRUa2phNGdEcjNVb0FHNHRFaWM1WnJveGs3?=
 =?utf-8?B?dUFyY3M2UDl5Y2JGRGFsL2VTNWJja041SnhZa2tNdDZNVUJHWVJMSWdHUHQv?=
 =?utf-8?B?QzU3eHlPU0lQcGltOEtqckNwS2swYStHRXpOMksydnV0UEIrbTA4bDBScU4z?=
 =?utf-8?B?L2Z3ckxKNXU0dTBZRVAvaE9QZEJtK0pGVHk2eDdxdHBnSThpVm1MN0ZnN1pj?=
 =?utf-8?B?K1RGWDF3SUo1dDhWRG5VWEdodFZqUHMyTXh5dDdYV1FsYlE3ZVdOdEFzbDlw?=
 =?utf-8?B?OC8yb2h6K0NUQlR1akprNTlSeGtyWDJRQjBXZEtmMzk0LzJmU1RZVllWSlBM?=
 =?utf-8?B?RGprN1BwOWFFRVU4UVdZNEhQL0pTY2R4ZFRCYk5TTkx6M3J2OGVDZEVEVEx6?=
 =?utf-8?B?M1hXc2R2V0VyUnBQK2tlVms2c1VOOHRSUkVXdmlFN00vMG02cGc2MnJSUi9w?=
 =?utf-8?B?cnF4Tnk3eDRXY1p6YzY0NTdsYUpGbXRQNkdjQ05zdkNpbUREQmdCanpFa0g0?=
 =?utf-8?B?dHBkM2RsaTF0Qy9pb1IveEdxNzNWMU4yb1FhWXczR1A4VHZSZ2d1MlNoS3E5?=
 =?utf-8?B?R245Qy83Y3dmQzYyMXdxd08wbVFudDJZOTRUMmhqYTI3R3Vla0FrREpPeGRC?=
 =?utf-8?B?OERSbEtXeVY2Z1VBdEQzZTNsOXZBMFZkZFBVenZTN29PVGMvNklYdDAvVmN0?=
 =?utf-8?B?Q1FwOERrQXI4NFh5czlQaW03ME5NcG1Ed1dZNmNKTWVHcVZMblF6Sm01ZVhX?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16449d4e-d322-4f7a-56ec-08dc9792e844
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:53:59.9000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW1VPRKhvYjnKwoIOU00VpK5msSDF2KejxxuFurlC4uVru2AMjeTkF6XfWYi3Ow7xr6pQIlQokzkwteFkEbsGMj2IGDqR4nYV/BVw8ZFySo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7553
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 8:00 AM, James Morse wrote:
> resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
> resctrl can't be built as a module, and the kernfs helpers are not exported
> so this is unlikely to change. MPAM has an error interrupt which indicates
> the MPAM driver has gone haywire. Should this occur tasks could run with
> the wrong control values, leading to bad performance for impoartant tasks.

impoartant -> important

> The MPAM driver needs a way to tell resctrl that no further configuration
> should be attempted.
> 
> Using resctrl_exit() for this leaves the system in a funny state as
> resctrl is still mounted, but cannot be un-mounted because the sysfs
> directory that is typically used has been removed. Dave Martin suggests
> this may cause systemd trouble in the future as not all filesystems
> can be unmounted.
> 
> Add calls to remove all the files and directories in resctrl, and
> remove the sysfs_remove_mount_point() call that leaves the system
> in a funny state. When triggered, this causes all the resctrl files
> to disappear. resctrl can be unmounted, but not mounted again.

I am not familiar with these flows so I would like to confirm ...
In this scenario the resctrl filesystem will be unregistered, are
you saying that it is possible to unmount a filesystem after it has
been unregistered?

Reinette

