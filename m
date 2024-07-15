Return-Path: <linux-kernel+bounces-252103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB08930E71
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9521F212CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B91836CE;
	Mon, 15 Jul 2024 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAgY8aqb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AC813A252
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721027432; cv=fail; b=fku1gucsnYZWoqjLm+vzFTT90PKKV77YQbhntO5U/piAvz723VUeYQi/4YESGzV7zO2AwekW6JsojskbEMac+DefF4odad9py59xKxpPIAEj/1stM9IKLek3RCbkTwhYB8ccmW/EQ2geGFV9kDXN0EMq6CgeWL5in9mJYx18mbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721027432; c=relaxed/simple;
	bh=vXYY5ZOnVU78D24TaeXI2kKLF0zIZTtp8ag0ikf9v0s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CTCOEOrlDnOEtwdKzZ8spbTjrA5xp71NQRryPbscDEDFeTN1fPt7akg1yD1R2gCk/Cmvvkc4fzufgQDZRKR5goUpy+QJuEh04yd6S7EvvrDFssIFsXhnSWPd/0esGWwmYer+LmWrphsemCMRzt/eVNkVRGQB3jiMo5tOXvhaO4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAgY8aqb; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721027430; x=1752563430;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=vXYY5ZOnVU78D24TaeXI2kKLF0zIZTtp8ag0ikf9v0s=;
  b=HAgY8aqbfIj8FJNGUyWOHxsbP8HwdatCMLdS+5e6zOFxHT3cIWK5K0ne
   OrrlMWLq2Ga2lDZ/K8rkFVDc5QqXPUAIYospdh8wZhEivR7eiJ8wpU4z7
   nCu7+JpEYCF35OdOxr0tqhvwv6D35SUNSy9wOyiwNAyTOPDzC0uocqeMi
   FCKyu+4tggESSg++o7vQ5pzeNS7VgTKPO08YgvpE7QyFLxVGZXCihfueI
   seQjdvjzRMYO990w+Fs6tRDDcOrrQbUY2rN3qSvE4J/R176pD/qErnMFb
   CztRPi8m68IbbKo5SiEjFIXXzPFfLJqmnQCykYcliLZT0TDU1wTiCRhMy
   w==;
X-CSE-ConnectionGUID: mjO54kCBSzOHiKZwpdZ3XQ==
X-CSE-MsgGUID: OjBNVIV0Q2+EEvBbg+rR+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="22260654"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="22260654"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 00:10:29 -0700
X-CSE-ConnectionGUID: AFgSVgFIQBaptKzWM1LXJA==
X-CSE-MsgGUID: Nnwj6/8YS3mHEPhPjAkCCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="49907688"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 00:10:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 00:10:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 00:10:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 00:10:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 00:10:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Le3I/X+ulbhXLAFL0hTlDm2l3Hiz07PZa78EyA9o3qQGweNXieGMomRUg4i29zNm6DiPTpiIgIAMy9CTlytEIt1bpmnnQqJuqEDH0hCN7B0bN2qYmNEtOdP3nVKoaYeQ8V9PyBw4wKvkL4iHoujMDxu8NqTiwxYT7bN4r7K7UAPF3+7S2r4gKoQC/pFdkumlrhCArLC7mM6EdRij4hqIiytwjnXMJF4URTydYgHuW6kpWwt2qsEmfX8bsS6aOcXQtBSPpfUUg3+3bclpMvt+U6xGTE/BZScrbx2fq8nzfZM0F1vX6268BGz7IDxfb7DrrcqKqc4z1XvmoPkv7iKNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbCJm+SixSY0BBQayzwYJOQbxDgna+ds0VtNj+xDIE4=;
 b=Hgkec2ym5tg3cQLgJ1wqx4VLdx4ZJCwgTmgRymZyH+Lv/cLvqbghu9YHLr5Io0AsjQyyKS1lVU/R7YlYiuHrQXcyz+zLqQnZKe89doCYtx1tGDH2PAZpknosxmc12Vw/gadGnRcecCLFsL+ZlMxA4R2k+zLsEXQ6OPIAepphxVNz8LKtoXOnPGRkUoXQyX3yvp2LVfP+/oRmGC3oLIdvRNc5cCF49gNeHIuvgOUumjYe8f/Ecy3Ik+Pj5w0xc7+L4oebZxts5I53Sj08GgYE4dbST72WPCzkl2xNXcvVyCVijti/0swLfdz8TBOtRteiGA1+R7VlIpEzfkQNkuzNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SJ2PR11MB7599.namprd11.prod.outlook.com (2603:10b6:a03:4c6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Mon, 15 Jul 2024 07:10:24 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.7762.025; Mon, 15 Jul 2024
 07:10:24 +0000
Date: Mon, 15 Jul 2024 15:08:58 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>, Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Kirill A .
 Shutemov" <kirill@shutemov.name>, <x86@kernel.org>, Kevin Tian
	<kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>, David Hildenbrand
	<david@redhat.com>, David Wang <00107082@163.com>, Bert Karwatzki
	<spasswolf@web.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <ZpTLCscCFGtsrEjC@yzhao56-desk>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240712144244.3090089-1-peterx@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240712144244.3090089-1-peterx@redhat.com>
X-ClientProxiedBy: SGXP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::28)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SJ2PR11MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: d132b1da-1cb3-423b-48a5-08dca49d3281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7DMb2j89f1QLzhLtVd0JSRHP2UiZnHBozrfrgiy6dcCkRaAnwIhnUh58nVtv?=
 =?us-ascii?Q?aHVGgE+JA+gYu/Eo9ttJNx6JrkN12KF6q8PqZyt3q8byxZxppRitmHVNzM+V?=
 =?us-ascii?Q?bU5mnVOmyc4O6E7gRO0a8RTsICEHQPKvtxE48CmtuvrMZM0b1h68aEH9CXUx?=
 =?us-ascii?Q?DJj1Dwo2o9wbEI2kusMu7rEXosfjc6cwINVfjQcW0ga9CPaMnsKxHOPlzIQ+?=
 =?us-ascii?Q?PE1BynpmIQv75Djo1Yt9Xm3Z6sTVnDhNP8u/6xS4ytmled7yTTtza/cffa3Z?=
 =?us-ascii?Q?70gJXW+3BVGQ4CITqCKpTdPnsAshAhY0sXSItT+tcjIEho03GLjHCWcQTIwi?=
 =?us-ascii?Q?e5MJbBeTwZ7FnPe50XmYTHpFhtmcYLoNdO0HZs31JODI48rdOxSzef26w1sJ?=
 =?us-ascii?Q?QJUS9A09QI2jS2pTl3DM8Bl6PXyeayoCxsdyNshjmMmR/9JPAspMpesxO3lG?=
 =?us-ascii?Q?NY2s1ft5d4S9m3Fukvt9O5KpP42L+3fSytV4PTdLtaucArPcswi3MLufYMXS?=
 =?us-ascii?Q?r4JIwNfmJoWTvFgSv5C02ALqp6nO0KxjGVO9Wpsc09fgr949OLFOgzC8Uxm2?=
 =?us-ascii?Q?FZhqiZAdMbWxldTU/G/hboIc9r6/Hj4aWhyZAujkdcPKNFEfKirBXEf7cHx0?=
 =?us-ascii?Q?eo7M/RuDXN7NPntoX5dTlwNnkiN6Gi52LIy/v3HdDXxS38zfGSGQZG9eqV88?=
 =?us-ascii?Q?HRcO6LQK0O8YMUUoS0BNumKeQzLOR3JFl7nUkB1hRTM3YOXUZuCqEH4sr3dg?=
 =?us-ascii?Q?n7u9eZESLQGGyNFGe+UlyFFxwjivG3+DIVy7P7wGOdiSODHmfN8Ix4a6V23A?=
 =?us-ascii?Q?eY7VTEjGU/l8DZO62WE6RTvaGT63dx0inhzNE7Ov4ZUTqofiXFM7SvWx2WPx?=
 =?us-ascii?Q?IolT804DOb9swX/g8iBjuUFfXv9KaL4seCvetDi85BAU8QASNA1tlF2GjV6M?=
 =?us-ascii?Q?x+TJUYVvdeQJMDEthSSn3sDPodPVuhnEy5I6gujeqRyAMulsIRnOvrkfnXLX?=
 =?us-ascii?Q?XOoh3cLedmTi7DVKK6z48wVS4sEpnaCqu6zUKNy94Y190RZ9VGakF1YvGTKW?=
 =?us-ascii?Q?IXODE4hk4WzK3+r/+P9S6xH0sj7GelRSApR94+a64CCiGkboh8B5Zz5eVVRj?=
 =?us-ascii?Q?WTf8LhNBxOQ19zbjxaejKXPqCGOeV8VMS39imNk1/3OvRt6dRBJSGpwXpgMu?=
 =?us-ascii?Q?Nojv/4/bN2vFwC3+ComJCb0PeE1FUqoFVu9DinQ84JRJboeNzEY5CaA+jCUc?=
 =?us-ascii?Q?PqOskJMK6gqjuIIjJCI3YDsE81nemoND908yYEMfLYCwKxpWtgybDuCo/Xxa?=
 =?us-ascii?Q?yQg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDtyXuxipgtfeqCfzJYbF+KtTjYal7+ulJ8djH9Bhh2SttEHQIxq91LbU9ux?=
 =?us-ascii?Q?/BItyeMYqkkV1wLkWvQvA/chZI/LGSMeUalJKibO074CQXRb6ybJ3+xqlOXS?=
 =?us-ascii?Q?3wfymIF8eXgFopf4wK4abkskrkU2q0cazMvNZjEvojR9TyY8eE3aMLAAYVEP?=
 =?us-ascii?Q?Yp25ahzBYu1w0wmTMbZ4i3u6g9rsahvdd3wvT34leqNsQB0ApBMBmjLIZtH6?=
 =?us-ascii?Q?7+ntnPOeifEhS89G8g+8UligOsGi2tFIl+2hmw8EpCDpAC7fX7ye0/c/mEA6?=
 =?us-ascii?Q?8Ct71S15sl89b8XY3tg9kSgMny76TsxdAFVcoXIdoVWUc/q6DoA6+wumpS2E?=
 =?us-ascii?Q?yduEbBpVSJPcRBYh9X2eO3sgtMPguRn4alJOh3/9sKwpq+6B0VQeV8LBOgxe?=
 =?us-ascii?Q?mtpLjUoWBz6ipLm0IMU6Q7cjCeJNEAUEZ3Kq0/nEv3K8yeSzhvtaOQDhYCdl?=
 =?us-ascii?Q?m+3i+sx11UamkSih49dbB4XSlIOTfGynzYHtFlMOCWsAIfRcWe9c07Q/nMWo?=
 =?us-ascii?Q?CRwMhBvfW0EE6vw3S+R/eUDRo2rbCdQdNuAjB/XpGy9CSbmVk4jHTk/b32n1?=
 =?us-ascii?Q?iGtW5jXxyGhwV7wZwDkEMleI/HwiPbBpryuTn1RVr2XUvd8X65M0JfNok95k?=
 =?us-ascii?Q?c+WutFgfUr4nAI9TpV+z0iw5j9bero5MyUB4QQ/LZFcqCAxt4HjlP+EgyH+J?=
 =?us-ascii?Q?7kG0N7DZK1iSWSlmCIQlHE0S/RT6d+DLpcbfPQLPxIMv8SKlF4ehqIc9QR3q?=
 =?us-ascii?Q?I9s3fW/hUNPe66WC/wHK+z9OsqZZzWFM7v/p4sy4x7BTvQiH95z92ZZDEBW0?=
 =?us-ascii?Q?3Ps27+TPReSEx1KbFxsmiHIRjewBGJxgbby8McSa0UATpSRhep67cgJ/d5gn?=
 =?us-ascii?Q?SLvQ445UH0FOy0BLrQrp0virCbNjFRRi7iA07dHZ/F1bOd0PEw1ac/LiQcdE?=
 =?us-ascii?Q?7kU9VxCwOZ9Vk/grOraeJ1sRhd1Au1WgB6sWFQNWZyy/NoE2PQyFf90PxBjz?=
 =?us-ascii?Q?T9+ffsys/VqUflcbz/Kd6uoHFOrzyCOe/vmL9g0P0tmdfbxgULy5DFHH2Gfa?=
 =?us-ascii?Q?FXMYQ1aKKcA/TSq5LoB4kUvkbWah80IRytGpWXz0gje26ViO3Eq+qoSV4oBY?=
 =?us-ascii?Q?mAzybUfJxaNErOtJMCJfvpECVTDx9t2vVpKetGYCBz7TPWzKAdU25AgXahV7?=
 =?us-ascii?Q?056Q8WzIwwBrr/EG0jC0ws3UNUR6yLvbdae1bCyopy7FoJjKJYugomFR08Pm?=
 =?us-ascii?Q?lnSIoFWtxcJyS5JCff/KxAGWx9HDJfAo/wEXLqR6sYzbZbQL9SSenLiX9iXl?=
 =?us-ascii?Q?Yg6Q7EA8BFApW5BaTtGWVeUYbraQCzfZ5+u5RTvBi3SULlRXNrKGPl2FOFrU?=
 =?us-ascii?Q?XhMSOBK9ox/pgzbskBHGXYzVoqDyWBrULAcVdBlr6dV30sRlZsv4ufv+OGE7?=
 =?us-ascii?Q?95PKox4w6LLivnYdJ5/esUrhpeFvniuhaXcmqM84BLBl2vOQFBBr+8q/MnpD?=
 =?us-ascii?Q?VvDaq0QFyC0BDq2Bd40Wn87bHDbsyfwt2kwurJbx6hFdVtLTk9ctrwnLWZ4f?=
 =?us-ascii?Q?VsKEuAghcAFHwK5+GFpRzMXvJ/KK4Xd8aLHHInJ5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d132b1da-1cb3-423b-48a5-08dca49d3281
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 07:10:24.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndoftzm4vb5mi6/JuZgSQxklheK9QOhPb30LYtRYHrQ0vyRrv3Jr0su3Hfsszdd/O6Lgn9JIsl6jZHwPoQawkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7599
X-OriginatorOrg: intel.com

On Fri, Jul 12, 2024 at 10:42:44AM -0400, Peter Xu wrote:
> This patch is one patch of an old series [1] that got reposted standalone
> here, with the hope to fix some reported untrack_pfn() issues reported
> recently [2,3], where there used to be other fix [4] but unfortunately
> which looks like to cause other issues.  The hope is this patch can fix it
> the right way.
> 
> X86 uses pfn tracking to do pfnmaps.  AFAICT, the tracking should normally
> start at mmap() of device drivers, then untracked when munmap().  However
> in the current code the untrack is done in unmap_single_vma().  This might
> be problematic.
> 
> For example, unmap_single_vma() can be used nowadays even for zapping a
> single page rather than the whole vmas.  It's very confusing to do whole
> vma untracking in this function even if a caller would like to zap one
> page.  It could simply be wrong.
> 
> Such issue won't be exposed by things like MADV_DONTNEED won't ever work
> for pfnmaps and it'll fail the madvise() already before reaching here.
> However looks like it can be triggered like what was reported where invoked
> from an unmap request from a file vma.
> 
> There's also work [5] on VFIO (merged now) to allow tearing down MMIO
> pgtables before an munmap(), in which case we may not want to untrack the
> pfns if we're only tearing down the pgtables.  IOW, we may want to keep the
> pfn tracking information as those pfn mappings can be restored later with
> the same vma object.  Currently it's not an immediate problem for VFIO, as
> VFIO uses UC- by default, but it looks like there's plan to extend that in
> the near future.
> 
> IIUC, this was overlooked when zap_page_range_single() was introduced,
> while in the past it was only used in the munmap() path which wants to
> always unmap the region completely.  E.g., commit f5cc4eef9987 ("VM: make
> zap_page_range() callers that act on a single VMA use separate helper") is
> the initial commit that introduced unmap_single_vma(), in which the chunk
> of untrack_pfn() was moved over from unmap_vmas().
> 
> Recover that behavior to untrack pfnmap only when unmap regions.
> 
> [1] https://lore.kernel.org/r/20240523223745.395337-1-peterx@redhat.com
> [2] https://groups.google.com/g/syzkaller-bugs/c/FeQZvSbqWbQ/m/tHFmoZthAAAJ
> [3] https://lore.kernel.org/r/20240712131931.20207-1-00107082@163.com
> [4] https://lore.kernel.org/all/20240710-bug12-v1-1-0e5440f9b8d3@gmail.com/
> [5] https://lore.kernel.org/r/20240523195629.218043-1-alex.williamson@redhat.com
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: x86@kernel.org
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Pei Li <peili.dev@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: David Wang <00107082@163.com>
> Cc: Bert Karwatzki <spasswolf@web.de>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> NOTE: I massaged the commit message comparing to the rfc post [1], the
> patch itself is untouched.  Also removed rfc tag, and added more people
> into the loop. Please kindly help test this patch if you have a reproducer,
> as I can't reproduce it myself even with the syzbot reproducer on top of
> mm-unstable.  Instead of further check on the reproducer, I decided to send
> this out first as we have a bunch of reproducers on the list now..
> ---
>  mm/memory.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 4bcd79619574..f57cc304b318 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1827,9 +1827,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>  	if (vma->vm_file)
>  		uprobe_munmap(vma, start, end);
>  
> -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> -		untrack_pfn(vma, 0, 0, mm_wr_locked);
> -
Specifically to VFIO's case, looks it doesn't matter if untrack_pfn() is
called here, since remap_pfn_range() is not called in mmap() and fault
handler, and therefore (vma->vm_flags & VM_PAT) is always 0.

>  	if (start != end) {
>  		if (unlikely(is_vm_hugetlb_page(vma))) {
>  			/*
> @@ -1894,6 +1891,8 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
>  		unsigned long start = start_addr;
>  		unsigned long end = end_addr;
>  		hugetlb_zap_begin(vma, &start, &end);
> +		if (unlikely(vma->vm_flags & VM_PFNMAP))
> +			untrack_pfn(vma, 0, 0, mm_wr_locked);
Same here.

>  		unmap_single_vma(tlb, vma, start, end, &details,
>  				 mm_wr_locked);
>  		hugetlb_zap_end(vma, &details);
> -- 
> 2.45.0
> 

