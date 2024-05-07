Return-Path: <linux-kernel+bounces-170790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D8F8BDC19
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2741F23BD1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6746D13BC29;
	Tue,  7 May 2024 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGN3wvFI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AF3126F10
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065727; cv=fail; b=lq7j3mdJA47vnto8OShH6zYAD9A8RUDV9WI93EPM3+7C/F/vZCpVVzDpHzanliez4bXJpbZ87lRwrrzAqe2IWrhyEUOWGcDXL4EpBvdFDzRZj3bBpffrg8/VW/xRM45s+l9lvVGEt7r5120XlEYQbwWFQb1wg1tAT06TQcdJIjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065727; c=relaxed/simple;
	bh=lzsSOJpsZZi8SPfyf1nk/9KX75RvJtngx9isepWijT4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gWQeC5JFiLDNuMSRY8vh3vgGuzzh0B3iR8mIFnAj9Y4PqzP+5VDQXWBtJAI7g/YJghu80RA4E/xZvzTpaAeZ18UzPvYK6ti0a2b/f++6JMmsM4ENufxPBDiPDSftSUwZRkSF2bOkskciL/Ii5T9r2TQT5Ty9pqs4LgyabSOxpSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGN3wvFI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715065722; x=1746601722;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lzsSOJpsZZi8SPfyf1nk/9KX75RvJtngx9isepWijT4=;
  b=YGN3wvFIi5eeejDkt1vURehNjEpxgcqkePQkr2pqJBfCMUQcikwFDu0h
   0y53qL6MxDGCd/fkot/rUTAgE0WAKLCQ+PaQ1j7FjDnKbIEZjGNSSuuMD
   VX2oQvdc/pvG0hFNzrSn9wiYZPJfpQlWgeoAfoo06y1QUgWUIdIwe7Utm
   uf1x09q1lrYsE7XkogWJCXUPDKoxePoNn94LRoG8KGTU2LuM2KLW8Ff9T
   bxH9BF96RB7Issy2Ca1la4RDzJiYPsVrTLJjq8vaFZu8fdLDGy4eX1mCa
   C2J0jvSjFIGDq6bp62Jjn/Z+HB9bprcI5U1o9qplCqZXwDcTx09EepsLg
   g==;
X-CSE-ConnectionGUID: 0ZZQiQJIRLWY7pGY55UW9w==
X-CSE-MsgGUID: GkmkWiCtRd6WpUTgV8eWAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10724535"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="xz'341?scan'341,208,341";a="10724535"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 00:08:31 -0700
X-CSE-ConnectionGUID: Ulia1aK5Q6utMBmXHwOpcA==
X-CSE-MsgGUID: NMHxcuOAQ7y4qrzyGZgDpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="xz'341?scan'341,208,341";a="33227251"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 00:08:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 00:08:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 00:08:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 00:08:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 00:08:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2XrkNsYVS+JP8KxWswMD9XMyrHEELbfRuyWzpSyY8SIu0ZqmIvW7HJBhVCNkM3AEEbl6jTUn9VLLkYlbXQMrD4h7Hv6CVBgFy2BF1/Bo3BDS9LLwmPx2LNn8cd1FN9Xc8z5Dg2fS8J4EAgsVgkaghRJ80xcG667/Lj5OQg+C/P/499EVy5f5F0tFGoQJkJ0Ajz1h/sqDXgxsXs8g4/Xa4Zgm0SRBfizUZRg6DD7GtpvdAV7vZNgufz5nn8AdyK+k8Xn5mTJ3iYn4Z7ZlcySXCf2wrxfoq2drtCgN3rCliTAXinzg++hSLfI769Nrer6n1FTVr8q9nN8TsgL3xPBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVQ7J4rwRta2R80WKLloFBV+6mS+bYjh0tPa6kp5tZ0=;
 b=BQCJ+cRSGzgMKLqgXwk5//OGK9fdoKlcCZ6Jzsh6VU9ln8ZHZG8QqKwkuWhP+FvbSpoh/kViDLLKLwWv7FL5Mr56Yvy0npOfnX2JWOGOI+WwQOR2SAOgPdqfX1prSGBesJ1iWNaobncjJkkSbjcTTe8rBMZWGY9WLa3Q7sX4sjBhHLgNlDdZ/NlryYhIP22DZ+Vz38HYTKkIAzsUZHpI+c/4hhgEU7B9vwXC8/ZjSSUI1NfoWszyEEz5v67XECVj+jW2vPycs3FlIlHzAxpHs3LVjCJBhv/vNsfRl9JLxDnCKF3YRc9H0T8ZiaXlMGpalxiIf093n3a6japaMrJvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6474.namprd11.prod.outlook.com (2603:10b6:510:1f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 07:08:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 07:08:20 +0000
Date: Tue, 7 May 2024 15:08:11 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Sean Christopherson <seanjc@google.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>, "Ingo
 Molnar" <mingo@kernel.org>, Srikanth Aithal <sraithal@amd.com>,
	<oliver.sang@intel.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <ZjnTW4XQwVHEiSaW@xsang-OptiPlex-9020>
References: <202404302233.f27f91b2-oliver.sang@intel.com>
 <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
 <ZjE7DkTBSbPlBN8k@google.com>
 <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
 <ZjFLpkgI3Zl4dsXs@google.com>
 <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
 <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>
 <ZjiCJz4myN2DLnZ5@xsang-OptiPlex-9020>
 <Zjj3Lrv2NNHLEzzk@google.com>
 <20240506155759.GOZjj-B_Qrz4DCXwmb@fat_crate.local>
Content-Type: multipart/mixed; boundary="KET/l7Iij7oVuWKP"
Content-Disposition: inline
In-Reply-To: <20240506155759.GOZjj-B_Qrz4DCXwmb@fat_crate.local>
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ba2c0c-a16e-4fe7-4d97-08dc6e647987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G+zqhnVq4oKZVzHCGgYFickiot+LHQyrVEnk7jB9Vp2+xUh0DxToNYnVimD5?=
 =?us-ascii?Q?U7z2zChxNmA6s01cokA/Zs4UbKyjRVxBynGmv5NVWEdbt51fHdKN9a10I5Ca?=
 =?us-ascii?Q?bU2eVY5hbrwbyzEMYFPH/qokSDR7buvaiJWttNfc0R2h6B/Lm5awyEVghX0F?=
 =?us-ascii?Q?JLPmLZez2cIz2B04q3Gojc+XFjvL1kV8SASfNGWPUVeZKms6afOe7Q13pG1Q?=
 =?us-ascii?Q?vYmATETjTNKK9259NHBnlJc2fszZTz2b7QD+vlcL8rGCTHg/fPvUy1Cz8pfh?=
 =?us-ascii?Q?HPl7Bl6suOlPiWTLqCeygiLLFnSExXJ7dRAp7pafYi7WrJ3WxO0axufjEBaV?=
 =?us-ascii?Q?Us1R0HwDbvkWuMfwEOjymfTtxdxcR1MRijjaXsx6oKHlZC2cyLRpH0b1/Fqh?=
 =?us-ascii?Q?mFKGtKYy+L7viWp1NaM5DH/ywX1Bm5wSBUw3fUqqRvv5jAZRTnuIgrIMyLGs?=
 =?us-ascii?Q?hOEjsmf34NABXIlv8WBQtubwXK6LqCMW7vRtSTOo5K6VOzFD7iXJhBUuKRAN?=
 =?us-ascii?Q?BM3aw4LYJ5+Yf5d6NspXklxQ9tGLpJEARnDjrGRd/kTRuzGJl6lnlWY8g6U8?=
 =?us-ascii?Q?x2djWUcVWbt8mdVyZEngm5Tu3+7yYG/FJRpS+N5D3S6771v9SuxBIosCSvdf?=
 =?us-ascii?Q?X2Wlko3mvlhLDgRJAQlmntVOddzCik0TFwJW2vh5PQKe3Q/Sf1xI0kiHfvKf?=
 =?us-ascii?Q?9WCdRZOQTUWzVxiiQTWRxJXFQGP1YzH94+n9LWCVGEbGNGDVIHXGWZaL13FF?=
 =?us-ascii?Q?dkoI6MNkU+odrJgMs+hMWyuWlLH3XQIeHk2+n82FrgdKGTqYV0o/9aalXaeK?=
 =?us-ascii?Q?vehEuo7ZohtiwZBgii+qv6OfJ/LDVtLfmPE8a/q6hFqMJsPpVGGl7N8y2m8s?=
 =?us-ascii?Q?9ltJ830WEESpn0AhjEab/ppTNak35gATkkd/l6erlpzJwYJZ7LeoVzTzDiyB?=
 =?us-ascii?Q?DhLxYwlYGo8uVlwvHuPrQgiRiN1QBlHRc3C1JTzIunv39N/S/ZkmMnDxhD0K?=
 =?us-ascii?Q?JXYfE47uJhq08fDyrkvC6XCpVR3/zuBQkKFy3wmAQoTyPtzRlKth+GNQvhP+?=
 =?us-ascii?Q?NOJQtmzP77WPP9VQsUSLPzL23YrIyyJgAWJHmjWzWfhV4bUyoA5t5JhVpW8C?=
 =?us-ascii?Q?aTQSSK3u7OXhiW67CF/xjfTi5SDSvY4fjheYfjmCZnraINKdftGc1Tp+Nd1c?=
 =?us-ascii?Q?WHcxY9rmEyCbequvKP02c4bmG3qLc0pSt0pwFLVgGGxCwGOW1pBL0EC2h/Ty?=
 =?us-ascii?Q?mBmDNpGmoRznEcMQvDESxabqDxJnyXFbRmAaL7zgwA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L3kGSZcvAnsj8Y2uIa9AefJUGvnOBspA+1O1xJYtlzDhVN9CzBe2fyjxnTGU?=
 =?us-ascii?Q?WN+ILPFlTseieb4YZrP/9iHcrP8u41pGJ8nN6D+OCfnF0mKOo7Tip7u1NdEY?=
 =?us-ascii?Q?MwXBXp15+Mtw7/qUnoZqGs+TMF46Eh+qGmorcR6nfuKrb7FKs06tNb/UF+gU?=
 =?us-ascii?Q?R+ElRQavAfqOVNBR0lAxEGW5vrzL1HW5XeC+nrzcW0/yiiAl6XKw0IJ35HwN?=
 =?us-ascii?Q?D/WdozI5l45IVqnfEc77r2TuDriUotbqrWRHPUdtGH5j6lbfpT/xXoZcOEPf?=
 =?us-ascii?Q?tkqRnLFfGL4dLnUf5f0rausZmiSX4WiEPFy+E8q/WI0OI3TI1dQYFEdSm8mT?=
 =?us-ascii?Q?v8sB0LQFDIjSscFqcXFz2ZLANztusmqwkUeg/z4VxQa5C1uIdAPi8BIqm9GE?=
 =?us-ascii?Q?XuJAZ0X68on2eiD8f4LNy4d26EEbGqInkRooEn2tGOgCoWZolmJyx7TNrWJy?=
 =?us-ascii?Q?qSmc8MpnfblqWGf7CGPpyXrZib/cKi/OLuk3DHaG+RoQtBX8V2cH46nI10d7?=
 =?us-ascii?Q?fHmlIoW9h6E8mM+iTBe3DRzvDzsUsJRB1l0/5INRVJSp9Po0xzJoZgjpiIDN?=
 =?us-ascii?Q?4RU+PkMtnZk/PdWOb0JIxOLk59TpZNoFb+BV+cTOPPQNMVkWdZ+GjVB5eccN?=
 =?us-ascii?Q?Q/9Lmwc3VKDZH9ElfzuMqfAW3bQDQi5d04D5l5X86c3e0b9pgqQtnCki6R7z?=
 =?us-ascii?Q?yUGAQKTSUJSOj5aYsmopcGKh8y5wkxP2VDLdBqcO+rt9qXwLJStqjznNcTHY?=
 =?us-ascii?Q?YtCjVptnvnh3Kin4DCVUKGDV/8dkn3/r9IdXWzUtMqo2gyU12qHZCFrE6ouu?=
 =?us-ascii?Q?koSt051v2hrfnRIszbxoYsPOm4I0arlcwOqXFeX09X5YXggl3wOiIikhao0e?=
 =?us-ascii?Q?Uh72vsCSwBl7ZIukuKB99waBTgPsudeFDEZ9aJzHhB943brz+d2BB+p74sod?=
 =?us-ascii?Q?DgcnftfPtiOOah5GjrYqDp9N+virV+dTUBvEBr36GJIcZPuSTUWHlrMibZiu?=
 =?us-ascii?Q?bzcYuyVjt/jtunheu1mkAtx6x9PtfVSm77FUuUw++7ciV9RbYbYSwqQ8iElV?=
 =?us-ascii?Q?/rMtemvnhEN5X97Uh6Kx+KytfjUQRQZvzkgpTejTtDPyJ/ZX8xyDjQxPhhEO?=
 =?us-ascii?Q?uxGjl1Va9PPkQ6jFSG/XSU/uczkAzIwHxYQvflCXSpbwHR/wvqvxpR5kNZPp?=
 =?us-ascii?Q?/iJnGwzvjIIvMZB+IqKJ5TWkx3lMyATXx2uCGh0KCHrmVD1VPHmtdLGdWnUe?=
 =?us-ascii?Q?1zTmsVA2G7uMZBiCTZnKnhEeCZjPypZgJ77kGAZ44C1FI2T08cgkg7vhdZaj?=
 =?us-ascii?Q?yG0S5rNjQx2bBUogDvgTDvVoXVU2/bp2VJU4/xCWIl4NOR/7ZK4+SK5gD8Be?=
 =?us-ascii?Q?iWBpONSEfJd73nzna24Oy82/AzP/7gkNu9G1PvGJ2PFWI7z3nVOhzSc/VsFZ?=
 =?us-ascii?Q?BI6nq2WsxQkteyabPm4pGKi5aWqLeX2xTR1Vj7PBEQRWstITEyLwQwM/2fDZ?=
 =?us-ascii?Q?IIPEqKMULeie1NH9naWu4ipZ86G6IQhNRbZ9eUgPcoqVLsKuifrwqLtDDe2m?=
 =?us-ascii?Q?xugF/Q1rcxl33RJvHGICGONcXcyE4/mNhvjHzj3llQBMh+e0nkeHt1YBSA04?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ba2c0c-a16e-4fe7-4d97-08dc6e647987
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:08:20.0927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vJJNWR9sk4Mm8Vg3YFoaBEZOTgoRJ8kIAVx+3OSkofFCz4QOB8CkXnJO6tfRw+ZTLsLcKk2aJYcCSxm/8YLZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6474
X-OriginatorOrg: intel.com

--KET/l7Iij7oVuWKP
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

hi, Boris,

On Mon, May 06, 2024 at 05:57:59PM +0200, Borislav Petkov wrote:
> On Mon, May 06, 2024 at 08:28:46AM -0700, Sean Christopherson wrote:
> > The only way the WARN could have fired without this series is if VMX is enabled
> > in BIOS on the boot CPU, but disabled by BIOS on one more secondary CPUs.  And
> > _that_ is a bogus setup that (a) the kernel absolutely should WARN about, and
> > (b) _still_ occurs with one or both patches applied.
> 
> Right, that's my suspicion too.
> 
> > So I don't see how this series could possibly have fixed the issue Oliver
> > encountered, nor do I see any value in moving init_ia32_feat_ctl() into
> > early_init_intel().
> 
> Hm, right. I should've done this from the very beginning:
> 
> Oliver, can you please run the below debugging patch *without* any other
> patches ontop of latest Linus master?
> 
> Also pls send /proc/cpuinfo and dmesg.

I applied the debug pach ontop of lastest Linus master:

1621a826233a7 debug patch from Boris for ee8962082a
dccb07f2914cd (HEAD, linus/master) Merge tag 'for-6.9-rc7-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux

attached dmesg and cpuinfo (a little diff, so I attached it again)

> 
> Thx.
> 
> ---
> diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
> index 1640ae76548f..74d2f0a351aa 100644
> --- a/arch/x86/kernel/cpu/feat_ctl.c
> +++ b/arch/x86/kernel/cpu/feat_ctl.c
> @@ -117,8 +117,14 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
>  	bool tboot = tboot_enabled();
>  	bool enable_vmx;
>  	u64 msr;
> +	int ret;
>  
> -	if (rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr)) {
> +	ret = rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr);
> +
> +	pr_info("%s: CPU%d: FEAT_CTL: 0x%llx, tboot: %d\n",
> +		__func__, c->cpu_index, msr, tboot);
> +
> +	if (ret) {
>  		clear_cpu_cap(c, X86_FEATURE_VMX);
>  		clear_cpu_cap(c, X86_FEATURE_SGX);
>  		return;
> @@ -165,6 +171,9 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
>  			msr |= FEAT_CTL_SGX_LC_ENABLED;
>  	}
>  
> +	pr_info("%s: CPU%d: Write FEAT_CTL: 0x%llx\n",
> +		__func__, c->cpu_index, msr);
> +
>  	wrmsrl(MSR_IA32_FEAT_CTL, msr);
>  
>  update_caps:
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 

--KET/l7Iij7oVuWKP
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AAAAAARZWg==

--KET/l7Iij7oVuWKP
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="cpuinfo-2"


root@lkp-csl-d01 ~# uname -r
6.9.0-rc7-00013-g1621a826233a
root@lkp-csl-d01 ~# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 3902.505
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 0
cpu cores       : 18
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 3925.074
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 1
cpu cores       : 18
apicid          : 2
initial apicid  : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 3900.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 2
cpu cores       : 18
apicid          : 4
initial apicid  : 4
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 3897.902
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 3
cpu cores       : 18
apicid          : 6
initial apicid  : 6
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 4
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 3898.269
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 4
cpu cores       : 18
apicid          : 8
initial apicid  : 8
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 5
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 8
cpu cores       : 18
apicid          : 16
initial apicid  : 16
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 6
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 3903.478
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 9
cpu cores       : 18
apicid          : 18
initial apicid  : 18
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 7
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 3899.618
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 10
cpu cores       : 18
apicid          : 20
initial apicid  : 20
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 8
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 11
cpu cores       : 18
apicid          : 22
initial apicid  : 22
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 9
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 16
cpu cores       : 18
apicid          : 32
initial apicid  : 32
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 10
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 17
cpu cores       : 18
apicid          : 34
initial apicid  : 34
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 11
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 18
cpu cores       : 18
apicid          : 36
initial apicid  : 36
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 12
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 4227.642
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 19
cpu cores       : 18
apicid          : 38
initial apicid  : 38
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 13
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 4223.856
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 20
cpu cores       : 18
apicid          : 40
initial apicid  : 40
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 14
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 24
cpu cores       : 18
apicid          : 48
initial apicid  : 48
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 15
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 25
cpu cores       : 18
apicid          : 50
initial apicid  : 50
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 16
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 26
cpu cores       : 18
apicid          : 52
initial apicid  : 52
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 17
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 4156.267
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 27
cpu cores       : 18
apicid          : 54
initial apicid  : 54
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 18
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 3915.093
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 0
cpu cores       : 18
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 19
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 1
cpu cores       : 18
apicid          : 3
initial apicid  : 3
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 20
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 2
cpu cores       : 18
apicid          : 5
initial apicid  : 5
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 21
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 3
cpu cores       : 18
apicid          : 7
initial apicid  : 7
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 22
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 4
cpu cores       : 18
apicid          : 9
initial apicid  : 9
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 23
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 4164.216
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 8
cpu cores       : 18
apicid          : 17
initial apicid  : 17
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 24
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 9
cpu cores       : 18
apicid          : 19
initial apicid  : 19
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 25
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 10
cpu cores       : 18
apicid          : 21
initial apicid  : 21
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 26
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 3900.196
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 11
cpu cores       : 18
apicid          : 23
initial apicid  : 23
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 27
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 3900.001
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 16
cpu cores       : 18
apicid          : 33
initial apicid  : 33
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 28
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 17
cpu cores       : 18
apicid          : 35
initial apicid  : 35
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 29
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 18
cpu cores       : 18
apicid          : 37
initial apicid  : 37
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 30
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 3900.020
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 19
cpu cores       : 18
apicid          : 39
initial apicid  : 39
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 31
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 20
cpu cores       : 18
apicid          : 41
initial apicid  : 41
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 32
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 24
cpu cores       : 18
apicid          : 49
initial apicid  : 49
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 33
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 25
cpu cores       : 18
apicid          : 51
initial apicid  : 51
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 34
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 26
cpu cores       : 18
apicid          : 53
initial apicid  : 53
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

processor       : 35
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz
stepping        : 7
microcode       : 0x5003604
cpu MHz         : 1200.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 27
cpu cores       : 18
apicid          : 55
initial apicid  : 55
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l3 cdp_l3 ssbd mba ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb intel_pt avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts hwp hwp_act_window hwp_epp hwp_pkg_req vnmi avx512_vnni md_clear flush_l1d arch_capabilities
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid unrestricted_guest vapic_reg vid ple ept_mode_based_exec tsc_scaling
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs taa itlb_multihit mmio_stale_data retbleed eibrs_pbrsb gds bhi
bogomips        : 6000.00
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

root@lkp-csl-d01 ~#

--KET/l7Iij7oVuWKP--

