Return-Path: <linux-kernel+bounces-205232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1728FF9B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E07C283096
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD012E47;
	Fri,  7 Jun 2024 01:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nae3EmNg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313111184
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717724893; cv=fail; b=dw/3KDJdlBPWzS33hfO9xwupOfMlNLrmsOxYSiN5qSkKZgKYoaic++EewiZCmLXP+M/tZknFT03Dd5dGEWNl4fXAZ2uFadjz1qUHwySnBect1iECHO+HSeXUn7afct3AtA5EpwczzaP3arvB2Uosl2GLdTKUSsij86U7tuIHb1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717724893; c=relaxed/simple;
	bh=CyUblz4npdbzaV54Xi3BcwlyE6+XGkRvy7AkBceAhtc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iEOL6sBqXZrExvGKj3Gpe8LY3mjJZbhUImlBl7YHaqivHd+56rawF2VPALGjh78hIdSIbrV9FsD/tMXqlwbN07qpc8/nSKSLskYe0bvfY6QB7wWrxz1lY+BZg0Gr8PApHEZlnG/J70Mqz4QQhpLDUTa8kZ1t4fg0bvGVySPlJWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nae3EmNg; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717724892; x=1749260892;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CyUblz4npdbzaV54Xi3BcwlyE6+XGkRvy7AkBceAhtc=;
  b=nae3EmNglsYGIICepIEDHVQxfx3u2nJVCulYDB9UnW1vS7l7dV7jmyl5
   Pz3OsGd8FRjawW6Av/QwxSkV7iqyAGmBc6Jm39zHvmByFn55LkYx5+6fX
   KgyORWCsDUoCENtcSviPRfmeGxawW1uCMONVult8OCsMUitrl9MUh0mlB
   w8bbnAn89soS31lYnpSy/tbfnNoFfEm82oRVLGmwIpYm0etMieEKIX+To
   gzvCEGGAhHxbBnbELMhsv58SuZRGMG+8hPg+gL6Gh8XmoEhHHXixl32/L
   6Byp4iVKUhfBF7qEUb3kH5w1FhG562wtLyu7oqRozJGRqE36VJlmibbg/
   g==;
X-CSE-ConnectionGUID: TQtsvjkMTHK/6zka5L+CfQ==
X-CSE-MsgGUID: gUP8J7AkTwOtE79+7b+YNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14263309"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14263309"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 18:48:11 -0700
X-CSE-ConnectionGUID: yXNs4JdOQLu2o3PeAZEC8A==
X-CSE-MsgGUID: +DN1yZ7tTYKYTXgur2cXKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38228494"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 18:47:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 18:47:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 18:47:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 18:47:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrJvYP0QbRrGSXsxC9CrvpkdB2QbVdLm3TWTQsFtViyw1L0Ue35dYU2bSJuepUTgcaalFnb6VWO0kddHVuFoDYD9POhYQjjAtjay3cfCPneJ5pA5s2/2qyn6N8vgtYW4hsa79MQ6bnYT7UeH0NufTz00IgTqPB+wG/IcF0fPKuICD2dg1126AtJHVsgVJzq0Ldvypnr2BQWT93NPZl34Odcs+cazqZYkfk/f1srTRadf6+syfHOmV+pSmj47zvOZh8pojhWdLB/agyuzg8wcEQHgh6WCz9wqsIJY1yYZs6pGBNMqeNuKQLOb+4cf2cxHvV4T3NIzcmgtBJvky0YUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEuszPVDJTTxY8Bqf/7dVeVTITZHJxsbCdc8KZBDumI=;
 b=a8vhcp3cF9TjbYooYF4jIFb7Jh9mCNkKBFtDbYepAIAr1I9Y5dag+/y3JRym2XBwxQpNessTtDelyytoiPFXKHMiLAot2PhkmoqW923bVpCc6gt8Kbw7z7FPDuABE8HZpzzGrqq0Nkk7elHDUfRu50shiO4wbvebhSlLc2Dd3h7YxhZINfQvsRwUUs0v3mAwgmZ6A6B25U5V/6m2QffPIz2bKZJBJaC5208w0ETUzMYrk25hMMfWaFGBqpx49Nq3oDQiiSPcGaCk1fM9YmUpZfBmL7Y0UBW27YfoJrbqoDetwaNAEzA4SOBWvRVZ+gvYHPJ//cd3oTVy5DSd1wNvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
 by PH7PR11MB7662.namprd11.prod.outlook.com (2603:10b6:510:27d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 01:47:35 +0000
Received: from SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::c2dd:7cf8:6008:b690]) by SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::c2dd:7cf8:6008:b690%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 01:47:35 +0000
Date: Fri, 7 Jun 2024 09:47:27 +0800
From: kernel test robot <lkp@intel.com>
To: Rob Herring <robh@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>
Subject: arch/powerpc/boot/dts/ep8248e.dts:101.13-190.5: Warning
 (interrupt_provider): /soc@f0000000/cpm@119c0: '#interrupt-cells' found, but
 node is not an interrupt provider
Message-ID: <ZmJmr/4N1Mb0ik8h@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3230:EE_|PH7PR11MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9e19e1-6800-4695-665d-08dc8693cd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nm0oyoBF7hHt8yR1gSorA8wI/84kH23O+cBeXcJ0IRgLSLnFw128xKlkB8O+?=
 =?us-ascii?Q?pBRKisDib1LIFIQdPKxIQs22tjJNtGzHLdYd6FlbQQcF0bF0kJujAJ9IqfQt?=
 =?us-ascii?Q?V1pjwNKZyl9jck44BjsKFHXCtw9xHbw/hKtNO015Ap5tIFTtO781MQLWtN8i?=
 =?us-ascii?Q?dlXDRyq7/vac8wRsTgMFJmxiomZu6PmIBOrPkVthDKLntf/vKrULxBwxhGyA?=
 =?us-ascii?Q?pGeDpNvCtuzFm/Wd9QxbJZWOWt/AXYjnfQmWDvnbpi0E4CpUEl33LFrrqzrV?=
 =?us-ascii?Q?hDrJ5LB9V8f1Q3dJZ4yqp52ceVdnAEdoWJRukzNDWC+k6QJLvq5maLJ2pA63?=
 =?us-ascii?Q?Ah46dsfjDTqpTXfRzTpJi84uF1+KLd9oQ+QKSduIlntlWOQbB+EaRUqxmflu?=
 =?us-ascii?Q?NoDYfda9LCLOJFY2c7wf0dmaM/QoNgZaIGbtCKv2LiFmKsW9ayjtuCkfgetD?=
 =?us-ascii?Q?K55GhRGavzrEC8bU6dxc5F0tVgIAKeap9iasj0mW5T0Pi6ywEkQWHiZs8H99?=
 =?us-ascii?Q?/2h50WLNi026tXsXZ6eTRujwvwZJISmBONtmQlu+4gPkV/tQm4ikFwOJyDpw?=
 =?us-ascii?Q?luzPJ2f37mp8bB/u/a+ijWaiywXgAu8BhSuicyY8HOGqRuFUqcx6NFB+toPc?=
 =?us-ascii?Q?z9LoTPpqaZ0SToMd1+ykT/d17zSKX4DvTylCb0qwnsSsQBJ2IetrQXMOqZt8?=
 =?us-ascii?Q?vzX/EOMXV8CfJJRCHqNfZCwvmexiklfYzbwzOKVvxXhgQFe/sqBSb1WusAIH?=
 =?us-ascii?Q?2SS685lry3INCYNfYvwZ2+oHg6gG7kn2ZzEFj29G/w1XR19ADtuS7XNjir3S?=
 =?us-ascii?Q?mR8mOhFoKRm+KgSVUDWElQlVJ3/SgJ6b37yN3QZJZvPGJSoIMxLth4mTyhgI?=
 =?us-ascii?Q?XEC7AwpGW1+FlvergnhHgljipnv7K6vZyeD4R6tF1cosy1jDs/KOTabsRE5h?=
 =?us-ascii?Q?ZCowV25rIuWM5kwrI9ikGLDJBBd7YXrnt/u/uWtdS5C5vnM8VbbToPIIYzCy?=
 =?us-ascii?Q?sHiD2IbD4WJ5Jx5wBYHw0Qj3EnbzAGOZlFWRu0mdRKC/860mZTpYQIrqEt7i?=
 =?us-ascii?Q?jXBSUL/JtDsvdy2aQR9rYXlkaLqEiVJgkR1BwD1+em1O5ILhFkJvNJa8lCvo?=
 =?us-ascii?Q?usyT2pkik4dguCtX7BbisbToi3HzGxHf9chYqybqIVug2DU5htZMp4d35Dje?=
 =?us-ascii?Q?PTodjbntrl0xMw4MKLHzB5DLIgJvGS0I+1W/FwB9TBuon8rbIQHglQVDTFuD?=
 =?us-ascii?Q?gtNJ6cx/9uATyBWxPMnkd5KV0Mex9pdXJL2NxjbQhaKvA5ZISzZVjkbYlboN?=
 =?us-ascii?Q?Tm/hr9Yc3KMpNcCjGxPmLrPc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t7wSwwmf1kyvSUhI1WGfuVRqi1X9KxpcCXuQgvK06ws7tMCKb+guQXDP1Fep?=
 =?us-ascii?Q?3BwJjSC1oFY943TDB4zKoyA+Iv43E9G09RTKE5QOOkhW/sLx92Mn3AOrVRTo?=
 =?us-ascii?Q?pH+BZx0OBzadk9viJaDvCL6kTr4C3gPiutZ5VlXdUI/FBGDKsi+UJRqq82eJ?=
 =?us-ascii?Q?7gYXhRO8MbUkJtc3ZHeSaM8A+hsVoOJbOnofx5GzPVczOBhfdLoDMpE9/3AX?=
 =?us-ascii?Q?O0ZQmm4xthuT4RJCJvZ31Mj0yteQRcQWe8dA5jeC2prDWC/m2mS+T8/JAT+5?=
 =?us-ascii?Q?tWZSS1flpbP5nwdTrqLw73vzaJ73gG0/0sMndTqToV/Dq7o7bKSvjxAFI5da?=
 =?us-ascii?Q?fv5vEXFwPTccpojQ2YIjpVZjcqmLLXjqVCPf+h2+t7C5Ac2k9b9KWbUYWCWX?=
 =?us-ascii?Q?Rxqq2VilETUu6I0nIqMRuDZB61Olma1j2luQtJ+XWL+dzNpaJM1GsXJGn839?=
 =?us-ascii?Q?3ZA8+qKzufI1BFLsT4tLxuD10uSXuoNQbIEuazjKdMGAElW/ulgVcXJRW9a5?=
 =?us-ascii?Q?vNNvNIGgj1Fu8kx7EVTmWqCMlbYd1OKj5mBhIr+zLFTz+IK73qVGloW3aqcN?=
 =?us-ascii?Q?7o4nnancqaUJwuM13d+3DU1LanEWR+gFRRpjYBL5YS2/kE7iTSy90fXaX9ZU?=
 =?us-ascii?Q?/yBGCGL6+rjiGZX8H1AL6bZeuRtsbn33DJ04FBsy4/5uDtPKGYAWBV/tDmAu?=
 =?us-ascii?Q?uGdq7QExcHoNsQQ5/E5HTN6Base8KzXBXGBcSk0xxKNREgETW9CVX2Sbiy0B?=
 =?us-ascii?Q?Mb0HMltOu4l5P7468YSRSbgxLuDnDBlt9LNHoJuFT0CHQfecEwpxuHhq4hoq?=
 =?us-ascii?Q?9HFzo9eKHz4BVChhQXnGbmvHLiv6gXswQMcOWPDgAdt9djitKLoKdzyXuc6F?=
 =?us-ascii?Q?zio15eocKwffsdmfXntuoZ9ryhf1dmu1YbUeJhRfuAxwLjs6fm8bXM4WNVgr?=
 =?us-ascii?Q?vY6oR8qTV4iOw0YsMuvPHwPJ7dFvb1fYL/M0JN+R7cNwmtNPctiSk3ibg7bM?=
 =?us-ascii?Q?LGn8/f51s+6oXpjSD5kbFdm1qtS4KvlMCuUrETTP1a9AZ+GyLNRhNy3LzCtu?=
 =?us-ascii?Q?nEKzC4HORm61w5QKaJUJ87dOy0VMQAoAuTiZvVWTQ58sqc4dhXrha7nOMJkK?=
 =?us-ascii?Q?4+EHuwZAwo0XGKPvd8g0HUHX2ypzf/Z/ZffNDbIX41p1ELfKmevKKNFGzCQC?=
 =?us-ascii?Q?uX17p/Dn5O5CGzf2uAZ6Bw/by4a3TT9d1qEi2LwIfeovfv3F8mmGjZE6+fwi?=
 =?us-ascii?Q?dxEFMAoNGdQzfzSiRqzA2ZMEGUY1FyJsAdZHIOXADuUE1kI4XLhvdJq8Rx9y?=
 =?us-ascii?Q?8nk+fn/GFZrX+FaVBhmF2GKTRGCjuY2giIs6/my6LDulZwUyAlqceDZzcst0?=
 =?us-ascii?Q?6B2yfRLiVTbDQ76DsJOqQZk4INUnmLvhntUncZTSI4J8wI38LTkL9ncfUs6P?=
 =?us-ascii?Q?AFUnZuG7Lb7693U2PhSEiEbEbkLpJcr9Pv1Iszk0MYp15xFG22XRCMQ8i/Ub?=
 =?us-ascii?Q?ZZA7qnl+K6h240h6j1FA3wBe7yBioIXh1dw26CFgbu2XKjeaTJf0rXkuO/pm?=
 =?us-ascii?Q?tx38K7h1tFYUZvvJDjBAC5O6iGY87HOEYJ5XNiPW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9e19e1-6800-4695-665d-08dc8693cd95
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 01:47:34.9740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju/yZoG8rI4xZHZGQk0VnTG748suQ2thb20UBud2+TE5UN4P8CVhKK+KEvcqEkFvygK+MWer+Ejfa3H9UAY3AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7662
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d30d0e49da71de8df10bf3ff1b3de880653af562
commit: a8528f7f31abf792f188d3f397b15aae7ed8564c dtc: Enable dtc interrupt_provider check
date:   3 months ago
:::::: branch date: 29 minutes ago
:::::: commit date: 3 months ago
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406070146.xwA9ooQC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202406070146.xwA9ooQC-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/powerpc/boot/dts/ep8248e.dts:65.9-80.6: Warning (unit_address_vs_reg): /localbus@f0010100/bcsr@1,0/mdio: node has a reg or ranges property, but no unit name
   arch/powerpc/boot/dts/ep8248e.dts:84.9-87.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
   arch/powerpc/boot/dts/ep8248e.dts:110.10-119.6: Warning (unit_address_vs_reg): /soc@f0000000/cpm@119c0/muram: node has a reg or ranges property, but no unit name
   arch/powerpc/boot/dts/ep8248e.dts:51.19-56.5: Warning (simple_bus_reg): /localbus@f0010100/flash@0,3800000: simple-bus unit address format error, expected "3800000"
   arch/powerpc/boot/dts/ep8248e.dts:58.12-81.5: Warning (simple_bus_reg): /localbus@f0010100/bcsr@1,0: simple-bus unit address format error, expected "100000000"
   arch/powerpc/boot/dts/ep8248e.dts:110.10-119.6: Warning (simple_bus_reg): /soc@f0000000/cpm@119c0/muram: simple-bus unit address format error, expected "0"
>> arch/powerpc/boot/dts/ep8248e.dts:101.13-190.5: Warning (interrupt_provider): /soc@f0000000/cpm@119c0: '#interrupt-cells' found, but node is not an interrupt provider
>> arch/powerpc/boot/dts/ep8248e.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'
   arch/powerpc/boot/dts/ep8248e.dts:15.10-22.4: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
   arch/powerpc/boot/dts/ep8248e.dts:15.10-22.4: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'

vim +101 arch/powerpc/boot/dts/ep8248e.dts

0dde1a1df9ab06 Scott Wood 2008-01-17 @101  		cpm@119c0 {

:::::: The code at line 101 was first introduced by commit
:::::: 0dde1a1df9ab0615ed08558fb7144e7739e9f565 [POWERPC] 82xx: Embedded Planet EP8248E support

:::::: TO: Scott Wood <scottwood@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


