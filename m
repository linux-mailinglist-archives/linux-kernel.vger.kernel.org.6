Return-Path: <linux-kernel+bounces-405081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136EC9C4CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CB528748E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE736205AAD;
	Tue, 12 Nov 2024 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2pBZ03X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5922C20493F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731379306; cv=fail; b=B6hiq4krbBcwlfEYy0SKt0CWNxJu0rVHdcPoERE29NzFVf/OBCTa0onVb2iOkz/qpIWxZv4tzoJ8KKdXMzS3yM3UXO3i4PlMbCj1ALzumwAr/yK4OpI+I1Fz4sduzcHjplLygIELHKep4kSHnyHl3Ns5HBo1ilZOE/BghgJlAPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731379306; c=relaxed/simple;
	bh=p5fcdS41mKeULaiLhzeUIu/sfAdXIWolPL2ifzK/Ln8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kwfna+GIt+nnCVIv36Fdj+Vv3n++NEcgC51Jp4qmOrwnWNAxcl9O/jCNlGEtSCXsADG0H6mxV+gHA6y81K0+W8K6fFVKtsP/W1xn/VJYmVWXexSCUVhXl34utXYKYYa6D8fl8yuWkrAhmb1cUbjkPRq0pyL/chJzIbJwdCTP+os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2pBZ03X; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731379304; x=1762915304;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p5fcdS41mKeULaiLhzeUIu/sfAdXIWolPL2ifzK/Ln8=;
  b=N2pBZ03Xs2AnybkclHNhF8G0J/V5iGoIETvHLePCWPJrb2iICOd/0iQk
   gXaBDU7DlAual+GHNAQzw7I0kQT8b0gBVUM8CiITXfawSY2XjdOCLgxcT
   OTf1iKxZ0Scze5RXzaCARJ6c3F2Zk/G+xX1gaZLh0ebxvKkdK0mN3plGy
   KUyjOlNcELvKy8RLJwf//SxoNfV7m0Be8a1vfXbggsEsmo8ejDFEPyE2r
   IInu3yopdWr18/uFV9eE9JuYzDuRuR3zlFCK9ckn31IFeQWqCeomdlAnL
   Qeu/fRibkZI9peTrPEJI/0ehSKIyyvaWLjhnTDc7Pzc+1wJ2QXP/Ekoqh
   w==;
X-CSE-ConnectionGUID: oAJ2D7FJTQaPw+Of69qSkg==
X-CSE-MsgGUID: 6bpmqLs1RcCkMOWQPh/yEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48655336"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48655336"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 18:41:43 -0800
X-CSE-ConnectionGUID: dT+94Y1yQ5KSB8SPf3izgQ==
X-CSE-MsgGUID: 8HwHiaueQHWe25yDpF5Vfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="91213990"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Nov 2024 18:41:43 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 18:41:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 11 Nov 2024 18:41:43 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 18:41:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GryvvpCMvW1PQs8IPTGacKcD0b+GaGO7kHO28BQiZ83MSK2SSG7vly9FtLPaQX/C/HDtfg0j49egGe14U8CMrnisV8QyRTvk4k/sia2YQXfMbC4JfdZdMEe6rqnnqMedTpoKmwnGVye5tEisW0RsQc9grnPUWkl6sXuSM4NmgFoa64Mr3NDOW4ELGZvU4XDYSTVSTwACvk9XmiSuY4Ol4dV6S+UqEkR9dfNno0iyRZAKbrNe8PkprgN9tvqO2jFhaHxk7HBxuYK21SfLcHJ5R8ff3TMpQjBF5ovZVoIGV9X+6Dlj6I2o3vnmEPWcjyMxfyI5jJWu8YkYvELNuirPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM8co0LFv/akaXAUvMq4fKZMA9gSPT8hcNGsCrRY2/M=;
 b=XXCfrWnmPZT99lcFAXoP3kXN0kDyVcu+xSuGhXGkscUuJkNmPnOQGLj47Ksp8F76CBAQCWlZzDignMnlO+MgeQk2uyHWDjNqXaQ0CnS2OYRdsguh+vDWHJnWYXQxlFGdH7LGWzROSty4iICa8btzIhk/FdVRK5CWygDvwBaVeGGKSc7ugdg1WVJZ0rbsNHwUi3PkGTGpivycXk/eoJCbc1wYaCiESQq3TT/VyK9krKVMB9boA5LyHn6+sQyHYWY23kuzxDkZCElIHNQGD/CeBosLZJHrlZgYPwAeskEc0qx0BIPOpfhzodQUDHl2nF4wNQejIsCsth2ZdR6GEkEt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SA1PR11MB5900.namprd11.prod.outlook.com (2603:10b6:806:238::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Tue, 12 Nov
 2024 02:41:38 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 02:41:38 +0000
Date: Tue, 12 Nov 2024 10:41:30 +0800
From: Philip Li <philip.li@intel.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC: kernel test robot <lkp@intel.com>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [gustavoars:testing/wfamnae-next20241104-inet-sock] BUILD
 REGRESSION 12b3f0eabce902acc13e01d76d9fd848474d4654
Message-ID: <ZzLAWrERdt0ijgpJ@rli9-mobl>
References: <202411101800.RWcjKBGj-lkp@intel.com>
 <94d65b73-9c64-4bb2-a60b-74ac558acd0e@embeddedor.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <94d65b73-9c64-4bb2-a60b-74ac558acd0e@embeddedor.com>
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SA1PR11MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 4513fa66-f45d-4972-45e5-08dd02c387ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GBr89hzxquhj6dLNIy6zLNdn6+t0RiDIgla6hnmBx9GjQjeuTwIdpirw1qEE?=
 =?us-ascii?Q?7bq9ukVwUMiK/uruQuhdfcQQTcmaGuVBqNpll3AY2awiN25IBsaGxHnpJ3cU?=
 =?us-ascii?Q?FS9i4Uk4WDQGGi/dwOWNoT35k/DjUtdBN7khWcquDA5dkVsnT1JAmlhrnnLW?=
 =?us-ascii?Q?FJ2Vzd5x4Ys/85k8HqcRWjVtBM7eQ8ot0QqqVbpjQqZEriisA9s/9kKgTMI6?=
 =?us-ascii?Q?DO9YODNW30PTg1OJ9ME5P67mGQoCM5ze+q1YgOrMVRF1GYO8Sz4SLOcCVKaL?=
 =?us-ascii?Q?okMq+FhqpHSXF8t9uneE8kNtg9DZCWzPImFAZ9pppEHl/aCBdwd6p97O5aYa?=
 =?us-ascii?Q?o1nUCBF0upbrGnlv1QROCKdH+ReO5KlMLmDZKXwTZUVN26BzIwfCHlPx7jSp?=
 =?us-ascii?Q?2gLsihV6Xb0/jnyXZLpkdJL9eMXX2wjzjdisuHSV6EPv6Ky5PyQXlrjtoiE7?=
 =?us-ascii?Q?5oKBwCpVcro+V1SSePGioAu2Y+9XX+bJcA4mROYfxBRUMjKzLW94GKB9h1/q?=
 =?us-ascii?Q?VF7wFs42PHF7o8vn5n10SmIjL40te2rVSTzVFfjo1GU8ppEU6NiUFl2coDqR?=
 =?us-ascii?Q?g9QaxYeWmo9ybGSJFWGdMT/msNIoMzpacqJvpGp8BV790+050TNw4Nrrsa4M?=
 =?us-ascii?Q?rAYvkZm3aIEgCrKMP7Ugn5HUKDuNwaQFCfZUJK/doZ/TOkw7BmWPeFjthCpN?=
 =?us-ascii?Q?gjKpetTTZLHaAoQAKCIUDzgrfk0iBU0/o3POj/74EJZ9DpftaOtJ+zckBorY?=
 =?us-ascii?Q?bBx2ZyHNVkIMKWd92CQ16OMCu7TdeGfWalfh/PLY9wY+tyHqexi68oM97w1T?=
 =?us-ascii?Q?X6FT4kDDlB3ylhhlcrxa2uhQ1k0y6LBwvqpNKkTaLDE2goqx0tKCiSg78gVy?=
 =?us-ascii?Q?+Ji5ZFzsPhbSR3tXCde/9c21xAzPzQ29a1AYBuTHjJWHSXByApw+M5KCJ2ht?=
 =?us-ascii?Q?Ng5FMHSWDA1gInLzmKytGzrtXxUbOI2INua8toL8vzKkN6sl0ZR2jCsKE/Js?=
 =?us-ascii?Q?n/cAgX5pBkd83BzIJwiYlgiS1dow5azAClfoi8ywssFUX+qdiJ0UDnSf0X+C?=
 =?us-ascii?Q?WmknHspuaK2QQcevE4QXpwLfB9r0PhdyBpTgrt8mx9AzsMPxocYN/HsHH6uj?=
 =?us-ascii?Q?+DyAzzZZCCTswMsx7DnsJK/FqmGei5+tWRdepNEcd+Hgu3S97gQ9fKLT+HKW?=
 =?us-ascii?Q?m6fGgFzxRgvzX0B8y+35bviL81ilIVzjZ8PjKt66LF8t+O61ArNyKZVti2oj?=
 =?us-ascii?Q?V8gsO4GrrvEghvTh93Se1l102s8gJaqKUP96lR6+oTBq6DGw3WuRU+jqifip?=
 =?us-ascii?Q?uagB0zGc3HWYGTOPrwYGdOiC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0tXwkcV8O9kb5NZiTHimGR1JGybcNRNKyCe1Lo5wVLrF228NcCUvSlRDJaq7?=
 =?us-ascii?Q?SbT+Py4ONRREO5Fvom1oz4jB7UI8mTVUqJi/pIbmG11zKSG4T0HUFnO2hZPQ?=
 =?us-ascii?Q?jxQXUPX/0jvWynroW3kjuInK20Imrfu1jQSiEIyj7lEXSIejjxpCb70Ya5E5?=
 =?us-ascii?Q?2p4AufRQW6+6qMbXFPibDY+bD03xGvJNI9YLtuF3YyOhoC4oZjTTLOAGkaMH?=
 =?us-ascii?Q?+7euLaUqGzDmgKiqkqggb/YdJ2bG2CpZ5fytrdjActBQEPOTzCwG8nmvbOBO?=
 =?us-ascii?Q?1+959pdJA37KUI2/We0OiS20Zem571688z1Zcf4I2YUpxq80mmZdL4C7RTpA?=
 =?us-ascii?Q?ULLZzWtp6rdVdtaGHscln1E8Vw4kgCJOxc29R/S6LxqJUFufOn+NP4Ex9+YX?=
 =?us-ascii?Q?lB9YZafFWrzxrrjFiyeXsT9pZ7P/XXtYbzTcvQGZTQtMcR68wxpgfiTjDPxw?=
 =?us-ascii?Q?8r+IaI48PlhWNpsHSCah1kIlaAo2c8l7wCxdSYLRSperGyxIG7rAtEYiqKE1?=
 =?us-ascii?Q?cwHpnHnIhmGWVVQEdHoxtc8Ztumaeq8UTDs3SxpHDnbBFTgFDnLfXj9xMl76?=
 =?us-ascii?Q?e9zxgAqPIry8G8rzeBdhdqy2ixgrMq5lutEE+rah1xb2/yGS62dVsAlBCj+2?=
 =?us-ascii?Q?gh3IsYazUW8xP4VU56CNHmiuVpM7K0+uKPVM82KfnfqQSDFgTXWfbAhp0ZTj?=
 =?us-ascii?Q?YEfsonbVGwL22eXDSoEPnMKmpjGLPNSvmNq9wuSprzk1iuA1xDkdLMxWdCRl?=
 =?us-ascii?Q?7Bc/0lk1TeHl1Y4SbM8dzpXMcD18LnsPC61knc4MJj+uOjwrsUMH52WA6X2B?=
 =?us-ascii?Q?UacO6SvKdmitTl4IaxsYkeAo94n2YfClt5B00yZtTb6AMigL+E/wloTnN/6Z?=
 =?us-ascii?Q?iBIkdeBr96VGx5a0mdrQiYgfXYIvKnIJlVi6XglEltL2DS8Xw2YEyAzraghT?=
 =?us-ascii?Q?Jc+J/AIb6+FKsNq6zCRbbt/My+mdhSge7DHKjjF95HoGdqp4RFsvQEk7lpa0?=
 =?us-ascii?Q?k4pFXB/iCKY422H8GiuMRRgXsXZXqq8SOD7uCNL0j8yGUlH8dvG6omOByA7b?=
 =?us-ascii?Q?qWUwN9RSfvkmksH+iY71PK86oEHKkfy47qzMkqz1Bg+0Up+qaI6itih5Ctiw?=
 =?us-ascii?Q?NPrjQdWN/SdTq02LZ6pt00mHXcpCwXb7XTElmdGYXEZj74aGrzr3jzXGkN4U?=
 =?us-ascii?Q?3NpaJOkOV8kkR9IdOUUunM4A6r8n3DPVHtRd5PPT6oG7Z2pWAQyuSD2b7Ta0?=
 =?us-ascii?Q?yuTOmIHEhH6onSjc48tE2JrmoWI3v4rn1pkakgR0q6/UXJ/7bmGbZ+lMxQGz?=
 =?us-ascii?Q?4526u2C1F7vkdJuX8Y2S6tXlahvlZ5I5R2dcr8AcdRirbMyrP9vYxegoF6e8?=
 =?us-ascii?Q?UIqZGMEifEf6tv8oGgc/DwU8HXw941cap14AswrM/6IojKehrxbmokWJG/jO?=
 =?us-ascii?Q?cewP0eRtn9QZfX/kqsWfCPkfGzuG4jjN0LP1Mwckh3hW4gXHCxTy1A1dbG65?=
 =?us-ascii?Q?vDGjPjYANM4+wdkn+407CC52dIGSdzriEt16FvAThrTBdiYCA5wPmOCH08bF?=
 =?us-ascii?Q?oxDjApYejH/j9abDzEMK4xksUME3aSHl+bkgD7pq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4513fa66-f45d-4972-45e5-08dd02c387ee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 02:41:38.2079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvvQ9hX7wtcB3+fdT9jtURifT7pKFjd4QReVM5au9p79KhIU802as9vZ35V6PCnWmvjd7SOatDrVQwPN2uP5Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5900
X-OriginatorOrg: intel.com

On Mon, Nov 11, 2024 at 08:29:39PM -0600, Gustavo A. R. Silva wrote:
> Hi!
> 
> On 10/11/24 04:10, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241104-inet-sock
> > branch HEAD: 12b3f0eabce902acc13e01d76d9fd848474d4654  net: inet_sock.h: Avoid thousands of -Wflex-array-member-not-at-end warnings
> > 
> > Error/Warning ids grouped by kconfigs:
> > 
> > recent_errors
> > |-- arm-allmodconfig
> > |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
> > |-- arm-allyesconfig
> > |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
> > |-- mips-allmodconfig
> > |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
> > |-- mips-allyesconfig
> > |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
> > |-- parisc-allmodconfig
> > |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
> > |-- parisc-allyesconfig
> > |   `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
> > `-- xtensa-allyesconfig
> >      `-- include-linux-build_bug.h:error:static-assertion-failed:struct-member-likely-outside-of-struct_group_tagged()
> > 
> 
> Which compiler was used GCC or Clang? Which version?
> 
> Including more detailed logs for these Errors/Warnings
> would be of great help if possible. :)

Got it, this could be related to an earlier failure, would you take a look
at https://lore.kernel.org/oe-kbuild-all/202410171308.VlSadp8v-lkp@intel.com/

Sorry that the link is not shown in this status report.

Thanks

> 
> Thanks for reporting this!
> --
> Gustavo
> 

