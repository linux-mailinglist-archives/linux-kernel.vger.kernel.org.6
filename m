Return-Path: <linux-kernel+bounces-254590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC7C933504
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B577D1F231F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17691859;
	Wed, 17 Jul 2024 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSMbVvyU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7384138C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721180445; cv=fail; b=ILgaoUJhSjk8SMvE1OdyyAqanKDzsVnEMik6FMkPjEjbjqDVbWWu7uGMdJidWLxCUJ7NqqFUdOM4XG85f6O/xosndP1CXbRrZzDEugFKrrA7o0H0rVUMA3HGEK9MZW7OvQMApV+RFk3087bzsYDguQotTpuDRDd/Wb7Q8Qs3cU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721180445; c=relaxed/simple;
	bh=jR8EHCuLRmkxIhI58YNKgRVMZEaUyNGzLv01WrnUzww=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AZN6owI/FToYZKYw09BnMunLkakW2ZkkXgXWbV32eG9T5fAEd4wOP2J8TUuwMz8qLO7J9gE0qyXwHBzWYB5TP/63dc1xdUs5TDwJ+ytp2ZlAOLY9GXWvspYcYmZ9PQOqQPhU/V/6RUQNN1j/3tSmt6lg+x/icPOmRQbKirNRtgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSMbVvyU; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721180443; x=1752716443;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=jR8EHCuLRmkxIhI58YNKgRVMZEaUyNGzLv01WrnUzww=;
  b=DSMbVvyUuMbdT2Fcj5526OpmzUycvytAJVhmf4L5YpfeAd3xbFGfF07A
   z0ep0y2aLIW22j2PVGCqiMh+27bjJhNlssh5oCC7VQQT3DNc/IlF0ra2K
   s1ixwC8w+O6gHRXcXK2fhAFeC3gLo/x8MmWNhKz82StjsMMhEdRLPAPzq
   Qf7EPXr0Uqeqhbrx5GhJi9l1lo3xOsVoSK+pDO9kmd+5NunPSwtCz7E2Z
   sedQFybo5S+jhclsxHW+Qz7qcmwG9jmloep5UHjBzQklH3C0RMh3OgPDc
   YfIhiAo0JabnmRxA/mxY+EUxGX+gkeJd5O2vPLfG8M2Fl4BgIgVhkAB4I
   g==;
X-CSE-ConnectionGUID: 2wGwAIkEQN+3r7pFd/dfLA==
X-CSE-MsgGUID: xqkZidyQQ2ad2dMaQcs2Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="36199904"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="36199904"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 18:40:41 -0700
X-CSE-ConnectionGUID: fro8q3KSRrO4ZCFNqi2RuA==
X-CSE-MsgGUID: VF39bqPmSUW06zZqRjC+dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="50285308"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 18:40:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 18:40:22 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 18:40:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 18:40:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 18:40:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6C8Jio1A20PT+bdnrNXlC0CH5BQgN7ZZd13eMCk2faxUFx2pH9AJ0FY8LVsBZCOkKdz41X/g5DCHc9UncGFlR6iXrU+7KfdvH8RRJBNT6yi/1nQiyUJs2Upb+cQ3Oop0iS9YBDgcd15u3crzRIKsYLPhygZaabT59ogtcfW/dUIMP4rB3Dx3g5I+hioNLhPHt/4zqamvtmqs2D3w61tT7mS4ufxTlLQ3B5FoIHfqdveSB7K5VH7l3oKtPq+/xircPvggCtJlrv7vmNCsBgZOjr8tMg1rVo8FKY76trsO7D01t1X1ks6za7rvBe5oLtEX/hB7FQ1hIPQHeXsO1A7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLkondrb4sJXn9mLjP3rZ1EVcbUubskH3owdfE6+PVM=;
 b=H4Lg/qEcyOFFv39sRMWn/QisW4Bu49MBFgVYRZo48M+84as+4KC9H5JX9gIGb3UlaNFdYjDQZ0uBk0MPHB5cvTKmqTs4UfZhOqJO5y+ZSc8g0cI29vhmfec5ZGf9/lyBtpN6nNpqXdAAxuphfW8WITJYLySBTFJG4rS/+WqjQCmMUbn7qhT1sB73NCOhKP7PoQpJ/M3ihl5KVY6R35MsOpWhvmBhsBkjZjHecLUFyKUStAzOU+6aTY+Sf1QIwnWqtier99321v2jRC2wBfchLlxLDqPIQvtBXfuTp1LW33J7Bl++KH4oWrRQ3QEHg1UQpPCP/ojaHrv8XkK6S5Hovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Wed, 17 Jul
 2024 01:40:03 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%2]) with mapi id 15.20.7784.013; Wed, 17 Jul 2024
 01:40:03 +0000
Date: Wed, 17 Jul 2024 09:38:34 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>, Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Kirill A .
 Shutemov" <kirill@shutemov.name>, "x86@kernel.org" <x86@kernel.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>, "David
 Hildenbrand" <david@redhat.com>, David Wang <00107082@163.com>, "Bert
 Karwatzki" <spasswolf@web.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <Zpcgmk6wexTKVv2E@yzhao56-desk>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <ZpTLCscCFGtsrEjC@yzhao56-desk>
 <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk>
 <ZpbDnoQxGubegtu-@x1n>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZpbDnoQxGubegtu-@x1n>
X-ClientProxiedBy: KL1PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:820::13) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SA1PR11MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: d003c8b7-abd6-441b-376f-08dca60160c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KnwqT3ZCiNIqZY73Cq0AmFaLhebcWS/0e0kVbuUqMnsyC8UrKTYt+RJD14sW?=
 =?us-ascii?Q?HAB3JPd62X+rSgvDLNyZ8chCIQ5rGOJpuwmudFsaqBpjoySHR4eRLRGBMfn4?=
 =?us-ascii?Q?nc+Nltsz5aPTBLrSIrFXP4Zozi4dfBZ8bgljW4nUfBxyixl5TVQdWy9AgWXA?=
 =?us-ascii?Q?62m4rrm48TtC7FufiNKsRc+Z1BIs2SL+qendvg1q3DVA/ZuYGp7SKJM2itRb?=
 =?us-ascii?Q?/El+vKHwpPpOqeRQS5ETYikl+tXSW1S+amNvDaQpOfTq54PhoffjnKyAuUFk?=
 =?us-ascii?Q?k0VOJxtnP+bFmKNc/szj83+NkRk3yUb7HmtGXZiKSP0pspylI0kjnSCH4HHN?=
 =?us-ascii?Q?1du7kGKTmSFnam0/g16iJqwCHyWFX1yl/+t6rm1oZq5eBXNR7t95PVRzcoRc?=
 =?us-ascii?Q?Nx0H8lPjoCG4rOCzSCdQIGBCR9HqyV306PMCL5QniLIZKrFizwT8p7uJKiZ0?=
 =?us-ascii?Q?WmKNOQE7IKnAuySdgU+FddTWBxfCNGxbzdBERo2isqfuP2G+VxAMnMrmMKuY?=
 =?us-ascii?Q?Arzqmgy+qS5Y0xHCcJaWGxGvYu79vukY5+59pcYql5cwJL808j8pqLz4VfEp?=
 =?us-ascii?Q?GnHyvzAmLCi0gUgctxe3mpWNz8fcJZ0rF9hS5Jpf4YxnKYSUipyJr0zpM8GY?=
 =?us-ascii?Q?i9RSEVGCD03rFx/WKyXk+v/JU233JOttV4NZU/ttatAN7rmjspXuKOraJSsZ?=
 =?us-ascii?Q?8Zn0tnE1SUTjybfFTdw5QNtLJvshk556zGa6yswgEQKKwwOuIC77rauNkYdp?=
 =?us-ascii?Q?wQ1U4E53v3YBlssRfA0eKOsQdzTQui5DZkRpnH5ipH+fHaZK88gthSMllDdN?=
 =?us-ascii?Q?mjbju9LDAAh7zRsN4SR7+LZvF8tpqM1PvgQmFOedU3oLdSRs1A8anDvJH2xr?=
 =?us-ascii?Q?Bv9j9qPIukAv+P7mXItjzv8gaxFQYCWQUVzXHf2IWtN3J0kI2Pxlaf+7Ixjg?=
 =?us-ascii?Q?bqK2CW5HMbKHsgbmyAfzJL38T/5tqUg6ddFQIK7hGf6ls9Y4FAoyUpzDnCdy?=
 =?us-ascii?Q?9vyH/Fw1WKTUAHJBaKyp0VkJCyq5t9glIreBjU2yIiy1DTdENVyrZdcXdZkz?=
 =?us-ascii?Q?ReAcA2eEVcD4RqjwiI363BoR8G3uZFgsiW9trldzNPb3t8WIlzQKjPGWw3Dh?=
 =?us-ascii?Q?axgjPEjX8omQ2XBIS66tj1NttNRshXPfhu0PFLT1d2wg+b36TAUUrRc3iXM0?=
 =?us-ascii?Q?BJB3LICOCDs8JKwnIVZXjl9RzGdJf4ymhPPf/oPpRykP8IX+KKPZIB1iMxrL?=
 =?us-ascii?Q?8ogw5Tu9EgRzG/YKBrG8/XxNL2STlnneRUy+vwWBEkmLlxVOfZ1D1SOeRk70?=
 =?us-ascii?Q?zRM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HXLQQguHkczLMdr1EbeEOM4eBNJ24bi58258ELjMLaynl7a2n5/HlstxFFMj?=
 =?us-ascii?Q?1XyvqydvbMy4/5HPv8GhAvKWDjv8QgFG6zOFkzaSV8xa9JaJJy1S2lZHz81b?=
 =?us-ascii?Q?U4B2YuUwUf1X19NhQ0hLU9a/AFQcyzO7yOfqoUTdWIi+Ya4Q/k1/ph5T92DN?=
 =?us-ascii?Q?Lk55h5XhRlJi+iI4EWFIJNU3Fj60u9TZRFsViKkrC355cQgHhqMyUAP0cs8K?=
 =?us-ascii?Q?UGBlTCHLCkrgYv9juLPDl3zAyXOs9X01J4N3S6kI3CCi9W0vQm6aRyjbrP5M?=
 =?us-ascii?Q?IZa5iAQWAAW5bxiL2wON8Z0LlKDuRKO/Hk3xjwoPq/n61k5NsVcP6WV0jE+n?=
 =?us-ascii?Q?xq8PnMBm4SDN0dMsHfqsOST6pJrBm22V9qR8v7FcOYfU7jG6IAeQuuTiBN/e?=
 =?us-ascii?Q?J94MHuiTfQeakA6JFDrflvLgCslXdSbTM62OdY/S34qMspgz1QVr3ODvqvcx?=
 =?us-ascii?Q?rQHE4nNc2kofDWJC7NebME+yi3la+9ufFMAGc2S2wAclT1C0deMOOSh2sNpz?=
 =?us-ascii?Q?zda364+DwSRfDiMg0Gnz/55uDUbRPeA/XTsowgsYtntomp0NexhoDZPLaeAZ?=
 =?us-ascii?Q?lKl3xMEte3KHkKHFFmezDy707KX0HoyMo13CWAe4QrTdgTlwBRJIzROQQZAz?=
 =?us-ascii?Q?r1apVwaItW8E6k6t0B0EJf+OC89/NO/dstdznzumg8onlMAWnhCUaRBP/Y6P?=
 =?us-ascii?Q?ueUCkY9Hbk60M8ko++AFA+MQBK/8s6b9DSljWWMIncSo7obbAm7+4ib4OIAb?=
 =?us-ascii?Q?wGgj8iSGdwckmTAZEK8SrWTBK8e3Tk37frjJFpYnhRXF2XdpexPZCfuk92ws?=
 =?us-ascii?Q?0EI8VSBw3IwkfuumFbtDQB1YbhqFHPZpl6QqJgmKV5q7Er7s4sKI20hIzouh?=
 =?us-ascii?Q?vTAvxt3ss4l5/3gf+qhKvUf3F+HL0TjfnSry4n9qZj4eId7lcrXPXJQUJkVC?=
 =?us-ascii?Q?JVH/z2Cj2MM6Ts3P3XCK2XCBX6kTeH7kyPqb25uGgEk82UN6LFWV/z+w4eqS?=
 =?us-ascii?Q?EjCItOwHSCyFrB4TgzVuw1lddR7XyCrLY6qBspnGC8v35WVv3xkiL3HgFiZv?=
 =?us-ascii?Q?gFVVkqTuL0aZXmmdRByxgQAlM6VLj7p4x2oje5+fpKRKrGfvl2JSE3fUgkWF?=
 =?us-ascii?Q?UsfGhty37QZriEm42s2ITsCCIl2t3eG2Qrs3hgBbNIRyY0/1UrLVnC3Zu1i1?=
 =?us-ascii?Q?PYO5lGh5KJKy70ROYk4P8avGv8W+8E+L3PA0F2UtfxaN4F4hqSQac/DUa1k+?=
 =?us-ascii?Q?P+Xb1lBW9b3ogqrmS82LQSua0kDu/iMSvvOS8QpriTYZpQMXe+j1mBrS5Pxs?=
 =?us-ascii?Q?9f5jrRaGPHVyGBpapw0jwJPuaNA4QjhkFVjC/GCAC6W0pQbDmLCqrYxi1QOp?=
 =?us-ascii?Q?BXmgOY7GfUrifSUOqfP3JsARCS5LuMnaHkYpz5HP8CSDAeYPk3KA8fJ8iE21?=
 =?us-ascii?Q?6bp2LSt2T0sMgPGqZbCuPSdy7ZjE/rSk6Nq3tJQ65Fsyv3Jbx7OqUZFk6byw?=
 =?us-ascii?Q?8ZXIv/g+SW35ioyZ3nDHgtryQ9C3HK8ZL62SdsjBTrRhCqrW+LKz/twaDqiz?=
 =?us-ascii?Q?wr+XqyeUjNHMmKf90Scy+mVBUWlSTQnoC7zH7eic?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d003c8b7-abd6-441b-376f-08dca60160c2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 01:40:02.9412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UW/DEtozhAIVpjwTA2Ee9K3N+UjCzEpIHcDP3KOVct1OT3D+RmWh7XfdVI0tr9mvLCPBLeuwa39vaWQmkG10rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
X-OriginatorOrg: intel.com

On Tue, Jul 16, 2024 at 03:01:50PM -0400, Peter Xu wrote:
> On Tue, Jul 16, 2024 at 05:13:29PM +0800, Yan Zhao wrote:
> > On Mon, Jul 15, 2024 at 10:29:59PM +0800, Peter Xu wrote:
> > > On Mon, Jul 15, 2024 at 03:08:58PM +0800, Yan Zhao wrote:
> > > > On Fri, Jul 12, 2024 at 10:42:44AM -0400, Peter Xu wrote:
> > > > > This patch is one patch of an old series [1] that got reposted standalone
> > > > > here, with the hope to fix some reported untrack_pfn() issues reported
> > > > > recently [2,3], where there used to be other fix [4] but unfortunately
> > > > > which looks like to cause other issues.  The hope is this patch can fix it
> > > > > the right way.
> > > > > 
> > > > > X86 uses pfn tracking to do pfnmaps.  AFAICT, the tracking should normally
> > > > > start at mmap() of device drivers, then untracked when munmap().  However
> > > > > in the current code the untrack is done in unmap_single_vma().  This might
> > > > > be problematic.
> > > > > 
> > > > > For example, unmap_single_vma() can be used nowadays even for zapping a
> > > > > single page rather than the whole vmas.  It's very confusing to do whole
> > > > > vma untracking in this function even if a caller would like to zap one
> > > > > page.  It could simply be wrong.
> > > > > 
> > > > > Such issue won't be exposed by things like MADV_DONTNEED won't ever work
> > > > > for pfnmaps and it'll fail the madvise() already before reaching here.
> > > > > However looks like it can be triggered like what was reported where invoked
> > > > > from an unmap request from a file vma.
> > > > > 
> > > > > There's also work [5] on VFIO (merged now) to allow tearing down MMIO
> > > > > pgtables before an munmap(), in which case we may not want to untrack the
> > > > > pfns if we're only tearing down the pgtables.  IOW, we may want to keep the
> > > > > pfn tracking information as those pfn mappings can be restored later with
> > > > > the same vma object.  Currently it's not an immediate problem for VFIO, as
> > > > > VFIO uses UC- by default, but it looks like there's plan to extend that in
> > > > > the near future.
> > > > > 
> > > > > IIUC, this was overlooked when zap_page_range_single() was introduced,
> > > > > while in the past it was only used in the munmap() path which wants to
> > > > > always unmap the region completely.  E.g., commit f5cc4eef9987 ("VM: make
> > > > > zap_page_range() callers that act on a single VMA use separate helper") is
> > > > > the initial commit that introduced unmap_single_vma(), in which the chunk
> > > > > of untrack_pfn() was moved over from unmap_vmas().
> > > > > 
> > > > > Recover that behavior to untrack pfnmap only when unmap regions.
> > > > > 
> > > > > [1] https://lore.kernel.org/r/20240523223745.395337-1-peterx@redhat.com
> > > > > [2] https://groups.google.com/g/syzkaller-bugs/c/FeQZvSbqWbQ/m/tHFmoZthAAAJ
> > > > > [3] https://lore.kernel.org/r/20240712131931.20207-1-00107082@163.com
> > > > > [4] https://lore.kernel.org/all/20240710-bug12-v1-1-0e5440f9b8d3@gmail.com/
> > > > > [5] https://lore.kernel.org/r/20240523195629.218043-1-alex.williamson@redhat.com
> > > > > 
> > > > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > > > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > > > > Cc: x86@kernel.org
> > > > > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > > > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > > > Cc: Pei Li <peili.dev@gmail.com>
> > > > > Cc: David Hildenbrand <david@redhat.com>
> > > > > Cc: David Wang <00107082@163.com>
> > > > > Cc: Bert Karwatzki <spasswolf@web.de>
> > > > > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > > 
> > > > > NOTE: I massaged the commit message comparing to the rfc post [1], the
> > > > > patch itself is untouched.  Also removed rfc tag, and added more people
> > > > > into the loop. Please kindly help test this patch if you have a reproducer,
> > > > > as I can't reproduce it myself even with the syzbot reproducer on top of
> > > > > mm-unstable.  Instead of further check on the reproducer, I decided to send
> > > > > this out first as we have a bunch of reproducers on the list now..
> > > > > ---
> > > > >  mm/memory.c | 5 ++---
> > > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > index 4bcd79619574..f57cc304b318 100644
> > > > > --- a/mm/memory.c
> > > > > +++ b/mm/memory.c
> > > > > @@ -1827,9 +1827,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
> > > > >  	if (vma->vm_file)
> > > > >  		uprobe_munmap(vma, start, end);
> > > > >  
> > > > > -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> > > > > -		untrack_pfn(vma, 0, 0, mm_wr_locked);
> > > > > -
> > > > Specifically to VFIO's case, looks it doesn't matter if untrack_pfn() is
> > > > called here, since remap_pfn_range() is not called in mmap() and fault
> > > > handler, and therefore (vma->vm_flags & VM_PAT) is always 0.
> > > 
> > > Right when with current repo, but I'm thinking maybe we should have VM_PAT
> > > there..
> > Yes, I agree.
> > 
> > But, currently for VFIO, it cannot call io_remap_pfn_range() in the fault
> > handler since vm_flags_set() requires mmap lock held for write while
> > the fault handler can only hold mmap lock for read.
> > So, it relies on ioremap()/iounmap() to reserve/de-reserve memtypes,
> > without VM_PAT being set in vma.
> 
> Right, neither vm_flags_set() nor io_remap_pfn_range() should be called in
> a fault handler.  They should only be called in mmap() phase.
> 
> When you mentioned ioremap(), it's only for the VGA device, right?  I don't
> see it's used in the vfio-pci's fault handler.
Oh, it's pci_iomap() in the vfio-pci's fault handler, another version of
ioremap() :)

> > 
> > > 
> > > See what reserve_pfn_range() does right now: it'll make sure only one owner
> > > reserve this area, e.g. memtype_reserve() will fail if it has already been
> > > reserved.  Then when succeeded as the first one to reserve the region,
> > > it'll make sure this mem type to also be synchronized to the kernel map
> > > (memtype_kernel_map_sync).
> > > 
> > > So I feel like when MMIO disabled for a VFIO card, we may need to call
> > > reserve_pfn_range(), telling the kernel the mem type VFIO uses, even if the
> > > pgtable will be empty, and even if currently it's always UC- for now:
> > > 
> > > vfio_pci_core_mmap():
> > > 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > > 
> > > Then the memtype will be reserved even if it cannot be used.  Otherwise I
> > > don't know whether there's side effects of kernel identity mapping where it
> > > mismatch later with what's mapped in the userspace via the vma, when MMIO
> > > got enabled again: pgtable started to be injected with a different memtype
> > > that specified only in the vma's pgprot.
> > Current VFIO relies on pci_iomap() to reserve MMIO pfns as UC-, thus
> > no VM_PAT in vmas.
> >  
> > Calling remap_pfn_range() in the mmap() will cause problem to support
> > dynamic faulting. Looks there's still a window even with an immediate
> > unmap after mmap().
> 
> It can be conditionally injected.  See Alex's commit (not yet posted
> anywhere, only used in our internal testing so far):
> 
> https://github.com/xzpeter/linux/commit/f432e0e46c34e493943034be4cb9d6eb638f57d1
>
I'm a bit confused by the code.
It looks that it will do the remap_pfn_range() in mmap() if hardware is ready,
and will just set vma flags if hardware is not ready.

But if the hardware is not ready in mmap(), which code in the fault handler
will reserve pfn memtypes?

> > 
> > Also, calling remap_pfn_range() in mmap() may not meet the requirement of
> > drivers to dynamic switch backend resources, e.g. as what's in
> > cxl_mmap_fault(), since one remap_pfn_range() cannot reserve memtypes for
> > all backend resources at once.
> > 
> > So, is there any way for the driver to reserve memtypes and set VM_PAT in
> > fault handler?
> 
> I must confess I'm not familiar with memtype stuff, and just started
> looking recently.
> 
> Per my reading so far, we have these multiple ways of doing memtype
> reservations, and no matter which API we use (ioremap / track_pfn_remap /
> pci_iomap), the same memtype needs to be used otherwise the reservation
> will fail.  Here ioremap / pci_iomap will involve one more vmap so that the
> virtual mapping will present already after the API returns.
Right, I understand in the same way :)

> 
> Then here IMHO track_pfn_remap() is the one that we should still use in
> page-level mmap() controls, because so far we don't want to map any MMIO
> range yet, however we want to say "hey this VMA maps something special", by
> reserving these memtype and set VM_PAT.  We want the virtual mapping only
> later during a fault().
> 
> In short, it looks to me the right thing we should do is to manually invoke
> track_pfn_remap() in vfio-pci's mmap() hook.
> 
> 	if (!vdev->pm_runtime_engaged && __vfio_pci_memory_enabled(vdev))
> 		ret = remap_pfn_range(vma, vma->vm_start, pfn,
> 				      req_len, vma->vm_page_prot);
> 	else
>                 // TODO: manually invoke track_pfn_remap() here
> 		vm_flags_set(vma, VM_IO | VM_PFNMAP |
> 				  VM_DONTEXPAND | VM_DONTDUMP);
What if we have to remap another set of pfns in the "else" case?

> 
> Then the vma is registered, and untrack_pfn() should be automatically done
> when vma unmaps (and that relies on this patch to not do that too early).
Well, I'm concerned by one use case.

1. The driver calls remap_pfn_range() to reserve memtype for pfn1 + add
   VM_PAT flag.
2. Then unmap_single_vma() is called. With this patch, the pfn1 memtype is
   still reserved.
3. The fault handler calls vmf_insert_pfn() for another pfn2.
4. unmap_vmas() is called. However, untrack_pfn() will only find pfn2
   instead of prevous pfn1.


> From that POV, I still think this patch does the right thing and should be
> merged, even if we probably have one more issue to fix as David Wang
> reported..
> 
> I'll need to think about how to do that right, as I think that'll be needed
> as long as pfnmaps will support fault()s: it means when munmap() the
> pgtable may not present, and PAT cannot rely on walking the pgtable to know
> the base PFN anymore.
> 
> Thanks,
> 
> -- 
> Peter Xu
> 

