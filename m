Return-Path: <linux-kernel+bounces-239529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC019261BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B644BB25B13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE9217A591;
	Wed,  3 Jul 2024 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kO7bRQ94"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885821791EF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013011; cv=fail; b=g+eoKPJStmCPB+XIe/a/eoDH05bPTqvOMaRiFbzIc/bDE3CtmUVtnRlKf2GRdCNenEnNhdlYer9T3GSkg/V7zdqpoBlH97KmZqM3BqdimgJQhO4TL/0FvhC4dH+J5Z9sq3vuVCRb/rNyP53rqIUWz+PoXk1AT42wBagSqlfNicM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013011; c=relaxed/simple;
	bh=uJMwH8rQE4rlTNTyS7c0kDEsL7ZOIua1WSnH4JNwWwI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TFoF0neLOdMRU2UHZRZwaZ9rOD9cjodNQgdO/QeLfQiMn5HCIJYNTA8DDEOgRqbIlannLcgBYUUsysdriv6nVaOtsOWNuynd14usa51eBH1IfpfjTUZrcZgJXGUj5WBqPdxQkyLd2l581IEmLEiiKaoMd3bd+H5bnOc8Z5fftis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kO7bRQ94; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720013010; x=1751549010;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uJMwH8rQE4rlTNTyS7c0kDEsL7ZOIua1WSnH4JNwWwI=;
  b=kO7bRQ94C+bwTJ5fjOnNTYvVDvcfPdFxV4RBwoya2qQBizrfAvDBSpr3
   eXKGVvFxOlzgpBUIoIUD+ncCAgTu/WIFYv6gymrEAm/NzdNi/i7EMMiJ8
   CTIOu+aAU25eznJfwxQBseqHCRYRKejka6693WOfo2VeYCHnU5ypIpNfo
   A2+o9yipOUJqW1typVWdybHGAcbklbTz8hxyU0jHLCeg0SJJDtfRcPb+l
   M7I9NsjQtoReAW2BUgu/R1P9OGL+Og8Pmr79WwsdENqk2u2aAGrRcxpl+
   zMfRq06Glu1gRCS2/R5gS0///klzEYdQ8MGjGDRmq6Y/KFrD3XCFpSJU3
   g==;
X-CSE-ConnectionGUID: tom9iw53QyaWkAaBI0bU8w==
X-CSE-MsgGUID: eeG8nhGyTCmWnqNGC4mf2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17111714"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17111714"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:23:29 -0700
X-CSE-ConnectionGUID: N0gN2qFQSG2GpV4xXCOTBw==
X-CSE-MsgGUID: 6ZTvvCYDRQKOF9EezPGShA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46172450"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 06:23:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 06:23:28 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 06:23:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 06:23:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 06:23:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWWCaQkxbXVmM4u/yQtT6kfJu3Q/YubZZbdAklG17NHxvcrvvd2e4edegx+NHePVkYF8kzoHrXBa5gAd0ODhb6fSOWa5u/LPjEBSWye+CWbS2hMkXYfzl+0TCuVjoA78DNhC7s5B036weuo2HO05rVnVTWHPsnT5jb2AXpYZjook6OaK5u+qfCGcmTzuT+6fdSkYYUtrd6t7/GpU+VLTCQvedVVFE2om5u6j9PseBmpm6keNl5f3IyXQFr2wUy2vLpNImBACekHAe3XB56m75Ye5JvKiDZXN0KO2mg8SK7vWlVBCNCaLxymuxuGZqnmMjm27IPXvjaNj0k60+1a+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX5Kpps0XfFTSVkRbvDCXx8UgRcA62+WPmuwYbaIaUE=;
 b=FihCqRWVnyGWBKBGF3xyfEdPz1rYNKgdzCQszkRyJoGw93zbChXyQmajB8TPWrujbnRNIIUHkLOY3XYAD+dxK1c//+Tm12FGA/lyRgoXR2UbdxQmVwzGDBxLaxGB+gPS1o/aRmQVvfvZHwGo/SCdXEdJgPjIIzHuDlTq1zZXt4emmhcyWBwwvbkdfC9ZPjJoYGXkJGD2geN6qtmEwBao3R3Egbj+y8klKvXnGJaMtSz12ubvUAwoMbxBtNiWn9+BLcnBazwL5xovgD2CVPm2F/j/afZD1QmAzTTkutdds+hFiPr7gbSJLUwVUIC7gtNNxwCtbtiaEmd4sZDzwxoCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MN0PR11MB6208.namprd11.prod.outlook.com (2603:10b6:208:3c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.40; Wed, 3 Jul
 2024 13:23:23 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 13:23:23 +0000
Date: Wed, 3 Jul 2024 21:23:08 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Mike Galbraith <efault@gmx.de>
CC: Raghavendra K T <raghavendra.kt@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Tim
 Chen" <tim.c.chen@intel.com>, Yujie Liu <yujie.liu@intel.com>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Chen Yu <yu.chen.surf@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Record the average duration of a task
Message-ID: <ZoVQvDEme3CBonHI@chenyu5-mobl2>
References: <cover.1719295669.git.yu.c.chen@intel.com>
 <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
 <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
 <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
 <db81ba7fba622e2a1b7186e66471cfb9ad8490fd.camel@gmx.de>
 <ZoLDxQlTR7fxoXWs@chenyu5-mobl2>
 <683663e3-cef0-bb45-e1c7-5bf1cf44209c@amd.com>
 <4e28fd17d7a2f7146aae10a76982f0e58b22befb.camel@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4e28fd17d7a2f7146aae10a76982f0e58b22befb.camel@gmx.de>
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MN0PR11MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2bb7ca-b0ab-4453-2083-08dc9b63509a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9rR4lGqP3iOeAgNXVOcpwp6fUJdBHn6TgaCPagny49kA4Dbkhj4MI7Ugkw/b?=
 =?us-ascii?Q?6J7TztHHQHOfYGiAtiQjHVgBEnB6H3zAPPqbdeHaZpzKE8AQmWULjV4B5rD+?=
 =?us-ascii?Q?6vCg9oh/ROt29iJVEEt//2s8WQa2nDkNikiiQ+Hezr4wotfz/Q1vGMjiC5mY?=
 =?us-ascii?Q?/lrbdIQlmXihT56TQCiRY4oafsfBjsqdJGrZ1eZ/OPXy9Y0/61qjxzy4hJeR?=
 =?us-ascii?Q?fA9P6J1kAM2HuYE5UlfDd3JhtWzSvjRP+6HzR2CYfPDxuuUZPz8u+OsGAuuz?=
 =?us-ascii?Q?1iP7MoVmmk/O49BMl2SH6UBr9bgzIYPNfzwELPJCdo1ZI1yeGj4s6Zpf4+uM?=
 =?us-ascii?Q?tqMG7pwmDUkT7BJ/Ngp4uCG/lDpzpsd/YSzXY/RGrm379CifkYyoC/YSZR55?=
 =?us-ascii?Q?OrbIOMXsFMrAffPR0cCgZ5IfFKuXDJG/V+VND8P+Zks5uWcHYZqiQpACFXwG?=
 =?us-ascii?Q?FBHC+w271yWEyu8KIij8ATcmLLo0a8YPWpNvYa1jgBT2LbnNjOvWdkVDR0hv?=
 =?us-ascii?Q?I5N2z+5MopkR8/pKdTanjRTnU2B0tVKnQfc0qFg+AU6kLGChiJumQZVk8oxX?=
 =?us-ascii?Q?DZfPn4jPN6mZyTTaCpKMZY3qMZ2L3ctkbCGhLelM78DekqaV8fW7cwR+t5RZ?=
 =?us-ascii?Q?5Wi8OY4/kgPHP41zoPAmbP4v6bcfIlCjqMhf738B/Jjm1Txpa2vxhWbs4VDz?=
 =?us-ascii?Q?k+G3pspIIlzRfDaPADXQbC3ILweEpdgM32NU9j3l7ZM8S9mz6moZb6DwJSr8?=
 =?us-ascii?Q?aoyaiIU0KiEDbhkgaj14YW+Dkqw6zOe6rxTSQvopXeRCnBNDnwIV/7Xu0e2j?=
 =?us-ascii?Q?fVe4yt6fqXEP6jFFNaheooqLJi3OMdOUr8det/k/fq5azXiZnPewJMq+67Iw?=
 =?us-ascii?Q?1tjeTi/w4tokq5spVQSvQEKHwAK7Oa7c94xu7XDPjYUHQw2bMalocXOGh2Nd?=
 =?us-ascii?Q?2auxnzr3Lqd5OYzZ8SF8itx0Ur3vdTYdCKKwvmEqnWSq5YtDYMidjD+r6iv5?=
 =?us-ascii?Q?+U455y0mJXgvv8a4QodSB9qhMdZMruuRia21IvKkr4myOg36+tR/Y/60Yl2t?=
 =?us-ascii?Q?VT0DwJpLOgSWNwns8KClDJOKg55RhFW6vm1LAoIgxX/Fmhy7kWfjh0tHd0uT?=
 =?us-ascii?Q?rUI/RsEUfpPI1xNwrxpa7fG1GHoHiq2sTLeJznB1oHHPNCaGVh8qFWq0+9VH?=
 =?us-ascii?Q?bqNC4dPUQ4bQGKxP+h6YHYDG2SDXkDw5CQs3WtnrmAd2oRHwCubFMuXNoE5J?=
 =?us-ascii?Q?7AfsWBtD1CVsYrjyoRRsumCBzlEuyoKNLONCjI2B8PnsXWmdIoJp/vqKVPUA?=
 =?us-ascii?Q?okxmD64naH8pApcAFi40FTy7zIGCJ0syL2Obb6QtipTVQQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VAjeXJivTQAe+ojbAdnivCIgav3IPBbx96Xe1kIfZxLift0V7WZtrWwd5BAJ?=
 =?us-ascii?Q?j5aSbPdbjbifiWaP3U7EGgwMwUetq2H7RnhhVsQ9DWKb2JMPeRIC2netZszP?=
 =?us-ascii?Q?FTzQOHgzIQfjrupLxpnI/OtzRK7uiejbQZJVGIEvb+m1LGpfNABA6CtHv4px?=
 =?us-ascii?Q?yD+CXXnlmFMlSIN/XhPOmWND13m94Uc0ctp6posncbRremPXoMqv+k6WrRGH?=
 =?us-ascii?Q?E/ysH6ebtUV+AS5Mn3MTmlC9BJp1ZDIFrsY5VHSigz3ZLQb1ZQXWaZT/adKD?=
 =?us-ascii?Q?UisBQEnLjvbDrTaeA25Ap6KFJhTnGij3xcvHboVBpgwb4RjXSiPHuXgEoyjL?=
 =?us-ascii?Q?QgWTYHwGDp+q87cN8vQusZXP+h+oxBQz5Gyk9XLVLWgnFssMIc3Qul7V8z/R?=
 =?us-ascii?Q?lBcepyTgsFxhxNEwpR1Up8qKfSZI3QDGqsxb2CStbkRwxDrZYwnMJWSTZP1H?=
 =?us-ascii?Q?hGZURPIAoPE2OfgeGFICX6Q6p/akTnIrWS/dfedFexUzpEKTmjviRKGMG8hn?=
 =?us-ascii?Q?+U2L2UnpYCz2xbHIpK/+Y2Q0FN6vm92JBBpj1rOBVToERsQLN/1wupZ3fN4f?=
 =?us-ascii?Q?GpHYEBV4aVhrNzc0EeF9bISUTu1c0OXZTlGTAO67w06FG/fOnvIBD2u06HTq?=
 =?us-ascii?Q?V5Ph7SBuptM+l2slMUf0JdDGZl1qECvLmtAcF+gSGxywlBjiI7d8qOiVHOkB?=
 =?us-ascii?Q?qrDAwDu1fQEJq4pwnFGh8/4SM1GAWffQaIWYEhVEBm0KbzbtSZbW+u2RcATs?=
 =?us-ascii?Q?c3F9swraHDNfv20ys9QJ23HBa13kThJYKXMI57uv8nIHufMPNdLXruBBGiQx?=
 =?us-ascii?Q?leQ4Gy4zzbHtSU5wey62N1TSZQ/MehJUMrXZ/pyxSNEA45/7pKqLPapvlU26?=
 =?us-ascii?Q?d21bfcvQ7nSAoPHueJfSCTgQo0I8dZA43eq508OWGpcbgVDXM9/AU/BjAf3o?=
 =?us-ascii?Q?NY+/P21Lk5FJ2iywXqdk8oSGyjmk5AZIMHCqKprKVzGiE3NHonm5LBamuAiq?=
 =?us-ascii?Q?4Mei9IygtFtD3olRJM95oQEHv8y02//cIZjG/h3Ynfsfm2q/hFAMz4E4uSJd?=
 =?us-ascii?Q?vMuFEfdlrQg3Ynei7VpPgaJ6Lsd9tAfV2RdlAgureRogUvT7LIpHIwX6wSkl?=
 =?us-ascii?Q?2E8lmpjexPFCLo3Th3ElpTUAku+lE/k1te61dZSxID+6FTtjqHw4P2tx9oa9?=
 =?us-ascii?Q?1TgRXzuIqlZM9B4ZYR8IgMPXWWBPUj8VMcfm4g6lbgwRytLKgLUkWoICnuaI?=
 =?us-ascii?Q?ZIhntVdzLt55TB4XRF5XOWm9V4th2sQFs78Jap2VZuc4yfpmrYl3E1eJl4QN?=
 =?us-ascii?Q?EHtBfjgRWzIzHF6Z6zDkr7TcRYblOkePSXSgZSegvSKnR9xfaGypmOxGeRRB?=
 =?us-ascii?Q?e2eXX4uIcYlVVXELdOlXDSx7k0tvcvt1/0GWw9/jm8EV0BEd2fBDNGPiPZGz?=
 =?us-ascii?Q?R6en/wDUIg39GSv+6BbzpiTMmuC3CLLGifb5ZtIU5AiaXdrbKsa/SpFrBKy+?=
 =?us-ascii?Q?x8RZ/tZrd4PIsaiGUu2WpH660hJzacQZrNDvJI6fvgQtRMl/CYm27JVhbumS?=
 =?us-ascii?Q?weuOR3U2ZDk+At/kjFsed2IKbvGEKi+BkLq9DrLv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2bb7ca-b0ab-4453-2083-08dc9b63509a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 13:23:23.8206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXD8Ffng3TP2toD1yc3dMYFUQ8wUixM1Xo5CX468oZoMDpzq7cN8vJ1Vizc6gZt76LDtGpLP3aUnlDcCEMeADQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6208
X-OriginatorOrg: intel.com

Hi Mike,

On 2024-07-03 at 13:57:19 +0200, Mike Galbraith wrote:
> On Wed, 2024-07-03 at 14:04 +0530, Raghavendra K T wrote:
> >
> >
> > On 7/1/2024 8:27 PM, Chen Yu wrote:
> > >
> > > A thought occurred to me that one possible method to determine if the waker
> > > and wakee share data could be to leverage the NUMA balance's numa_group data structure.
> > > As numa balance periodically scans the task's VMA space and groups tasks accessing
> > > the same physical page into one numa_group, we can infer that if the waker and wakee
> > > are within the same numa_group, they are likely to share data, and it might be
> > > appropriate to place the wakee on top of the waker.
> > >
> > > CC Raghavendra here in case he has any insights.
> > >
> >
> > Agree with your thought here,
> >
> > So I imagine two possible things to explore here.
> >
> > 1) Use task1, task2 numa_group and check if they belong to same
> > numa_group, also check if there is a possibility of M:N relationship
> > by checking if t1/t2->numa_group->nr_tasks > 1 etc
> >
> > 2) Given a VMA we can use vma_numab_state pids_active[] if task1, task2
> > (threads) possibly interested in same VMA.
> > Latter one looks to be practically difficult because we don't want to
> > sweep across VMAs perhaps..
> 
> Oooh dear.. as soon as you mention threads, the question of who's
> wheelhouse is this in springs to mind, ie should the kernel be
> overriding userspace by targeting bits of threaded programs for forced
> serialization?
>

Do you mean the threads within the same process should run in parallel
as much as possible, regardless of sharing the same data, because the thread
is designed to do so? If so then we should probably skip the 1:1 task stacking
if the waker and the wakee are in the same process.
 
thanks,
Chenyu 

