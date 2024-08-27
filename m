Return-Path: <linux-kernel+bounces-302998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 252579605E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3226282048
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECFF19E833;
	Tue, 27 Aug 2024 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjoXcWQX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA8919E7FF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751620; cv=fail; b=MN3cNInId0vudGWXG/MJeCPjOMDNYJvAleRfzjTTdqIPRFXIA9zs9lM+TBDgWkfV9sSE1J/9sP4AeJ6rwBzrHlcmcUoO1mnoi1diDGO96zHEOfzH0DgXbZylFvIPXzNFP7P1N7FZiiwjGZamTYbeNhY6wcjOmTjAKy0/KZGx+3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751620; c=relaxed/simple;
	bh=FpkObhujm1XUvtgiJUQUorc64G6htY0Jpny3ZIPwMkg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eAtkQuqF2Rqg9nf3cuQge8p3aWgUXGKjNWkuDUgg2JKrjznnSBM3d/Z8d+PQX0vYYApQ7f3K5jviP57sLrZX5vtn8IjDBF/wPA3S6zPPMdhuZGitutVz1KJIW3UZvYGO3xD7CbYb1uNKugdvSj7DWgK4JjHn8kbAcd0syKrqFOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjoXcWQX; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724751619; x=1756287619;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FpkObhujm1XUvtgiJUQUorc64G6htY0Jpny3ZIPwMkg=;
  b=VjoXcWQXSaVHu7S9XWR5PrZYjzvdNcaByvbmj+MBncz3D2F7mIlbQwln
   E89WgrlVabCqoC5JxBq/lfWuhmm//XBSbXn2rn8EcuqmyEBgRzd+m3nz8
   +JzdzJKJlGW+3ABq5viFyoS8B58Qf0YYbJ3CMzLww7/zvrcAT7ZJkyNQt
   5mnntPXHBc33NSuNh0mUCXEAuGcxqHqZWXQW2E2XBDmnzBTiELcJtG972
   aHn4AiOgc7aUeIHTzoqnZBizGodofUP2Tl/WeF6MBrflWca5zJXtKluWg
   eaqoXFf8oAgvD8LcD3VepJukKV5aCxHn0UlAS+ZONpTKmfaA09nL8RVov
   Q==;
X-CSE-ConnectionGUID: Q43NK6RpSEWMxCcsILYOMA==
X-CSE-MsgGUID: cfDl4eJTSH+5I43g7Hh6Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="27013408"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="27013408"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 02:40:19 -0700
X-CSE-ConnectionGUID: Rf1+p5VbQ5OJnY6Q6dZ6Fg==
X-CSE-MsgGUID: pjc4WuBsRHaoUuMjFZ5V7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="93603686"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 02:40:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 02:40:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 02:40:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 02:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+WKf5Ub7ukcsXcc5kJ1I4jYB1RaxlOn4CPx3CDB2y3ed49Rscz9DRcshJgQYMmK+NqW7ETSjK0raqnd6OU5kzUowg4T5xQ5XqgISWP2AiS9WeN4wWfUFwicoAXc31sDe+sOoAjRI6lAvYEkklyph3ZWk2LAA6CHoFi2nPiy4JGAfjr7/ReOuHn5Oe1tCNoBQR5mVJoWzgQPuuXTLzOLboN4FcQdbJZhdOwrHJQnVDFyo/AhzkJZOrwWeiRu1qGNsl3pl1G5sNEj0tFqXaIhdt0Pc2svEXUPphWyktgeNCPrRQmSCWzgQRu2jYiRDo7KqwE0AGaXIz8OJhOWdBeW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pjk8xQ9iorbFE0m7+6LIBpWt8s9WmexKY+siuiBS1tQ=;
 b=uBNJcXAEuyMkCNXGdtCCVeQr8xzaC7/zsDAuGUV1JT5LejSiD+U5kq7UunB0tYNS5KHdfDKLXqRqZgx0RNBAjaXJBgvEFVeIlxkTxNTtBuqhvn2Zb7pQySZK3chZ3fySnOOPYlQrS6piBZgsK2SlMATybA7hUhwJLFlch15rVKzl7U4eMDuC7KwjowZ9gwR+fCF9VTWTbgTReLSKHvsikzSyh5bfPARrxymYJyrT5lEQklE9oV7/9wUCmvRVVpJ2fq/rslVAfIN/r8RI82Oh/Ytr774qkoxC0GD/IXby7x7nTO7wXQ+fzX40YeQqrw/VKVVGUIdKTEvlhAJNGhyYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 09:40:16 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 09:40:16 +0000
Date: Tue, 27 Aug 2024 17:40:07 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Oliver Sang <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <aubrey.li@linux.intel.com>
Subject: Re: [peterz-queue:sched/core] [sched/fair]  420356c350:
 WARNING:at_kernel/sched/core.c:#__might_sleep
Message-ID: <Zs2e988qjFLpAnxX@chenyu5-mobl2>
References: <202408161619.9ed8b83e-lkp@intel.com>
 <20240817093329.GA32430@noisy.programming.kicks-ass.net>
 <ZsLNtymGVe5wk5vP@chenyu5-mobl2>
 <20240822154923.GB17097@noisy.programming.kicks-ass.net>
 <Zsw8FEPMHFe4yoaA@chenyu5-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zsw8FEPMHFe4yoaA@chenyu5-mobl2>
X-ClientProxiedBy: SG2PR01CA0194.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::22) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SN7PR11MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: bc74981b-da64-4bee-8d59-08dcc67c41ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gK290eDLZgb10jgaC5tDEpZJEln8K4uUuxmfR0ekQ9ihoxX3AbAXOYoW2MX8?=
 =?us-ascii?Q?7gV8tTW/YwVMCwk+WhcuqTxsxyDIoEClHyQKGsCehTxBNZxeG54EN/VYy8Qk?=
 =?us-ascii?Q?4YW2VcFt9/sZFg7m1XWvcO02PbCHGbRvMePX1ac5nvQnVMLEfhmWE5gVqPD2?=
 =?us-ascii?Q?aSFfAGQ7SFb60DIjn3iamaHCqDOSJ4VadTENjJ8mP10g/Mfbm1ZKIMe1iDUD?=
 =?us-ascii?Q?sz7vzl8KUNrgfwMPBqV2eXYct0O3ILSUlhAdC3sXXmsH2RPsM/+k4rOr8LAo?=
 =?us-ascii?Q?J76yP1zkO9IOu0DiDkCJatGweG89BlIUxjKfwkgzb8DT5+sJBJLWqqEBItvv?=
 =?us-ascii?Q?KtEw5/CYISATiTcczoSWxq4ZOc+JyBai1J3f83EaMgu2hMKEeRkXIZ1lA684?=
 =?us-ascii?Q?k+4hC0NWA0l9UtWf5FmpQJdPQuhWSXZalJAUFgk55mc1PWlGfp/Ys7kEnWtr?=
 =?us-ascii?Q?ShhftBwIi8Ah7GOSLtZOYK6Zaz82Uwoilaws5FyUrEf0b9BClbtocmQ54bIR?=
 =?us-ascii?Q?m14tAaYOXf9pfYPiJqhNZ9ujVPRtpkZTkO9C1IHiQTSi0gc8YNBMtAARF+G5?=
 =?us-ascii?Q?y1NdWJRIRxoYirAMOOSYTni2rpS1k90odPXM1xFVb/H3WllrdmrACyjNRJBD?=
 =?us-ascii?Q?7LBFDfEbto6H6F2aBrGfuitn/jGjbUJ9iLtcKGFHO/O522lH0YMJB+Y5+f27?=
 =?us-ascii?Q?ed7mUWb6kW5aVUxinQ1RUYDWX8lxyibT0goMjvaPAf6Z9O9w6OID1PXdw5/F?=
 =?us-ascii?Q?FouK2MDYa0fmIGd7441WJmvn5o+QjES9Xe9UvdJLsjaR9o/iNnFz1AgqxsNE?=
 =?us-ascii?Q?IRkAZgCAleRZ2Z2qOMM1/5GyLAhLSGYMOGuTU+o0k1+U9DJonTwRH3h5dfCO?=
 =?us-ascii?Q?jKHh86nN8rt/UWCd69BHRF7+EXPH3OWzeHNa/pVDkmFBajaAFPJb7/iw/g07?=
 =?us-ascii?Q?BEApLloIz7N2RCBFQgSTiFrMEv72Y8nLIwAzMXEiSUiHvrzupJk0u/xZTa9x?=
 =?us-ascii?Q?j6ryxhFPZMXF+eJbZ9IEYW0UXe9dDpLL0YlG0CDmZLc77XunDAXpLFfrTB7x?=
 =?us-ascii?Q?aOc0aE6bkosfGEPQyWQXwPBLzw3Ase2tGEn1VTanrsRfBxJt548KIW/n/+Ip?=
 =?us-ascii?Q?zM4qjToq4coZkWQ6J8ZNbcHO/lDwr8JrS09eeNvRwUhisth088/dOBsBth+7?=
 =?us-ascii?Q?6UrKWH4jAXq3JCx2S6Zs2KLwT3+nWeq5BQW6uxWia6rOdBJE23nTgCgqIhnP?=
 =?us-ascii?Q?4A0L9mvYYxiKnkdLpsFyrA3rGbrqCdae5unscGQ/apIUIW0GK+ZMB+ayDfP4?=
 =?us-ascii?Q?sfg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OwW+2BH2AdU8ztxROWYwz18rryyqM452JZ1r27v+Az5JQ+IYqcVoZ5tQdL+q?=
 =?us-ascii?Q?V1Xt8AOy5B/Pp4j/x6JUxLSHTgAvj2smzkKxmNInWeesP/sawlI743IrvV9d?=
 =?us-ascii?Q?uja46u37T69AsZVsS5WH+DZJH5cyEL2irQZHbCU7t2YmcKY6A7AaaDcCXY9d?=
 =?us-ascii?Q?CmBE+peN1OpBdwZFbALiy2ZE8lhpxAmTJoERKGU52c88LMhzHpdqSCRmXJv5?=
 =?us-ascii?Q?5Uor0X4nu9hCAY8M8ZMHWDF0gLZDl3PvMuPPWUe5sNx9mcWGk2eUL+W3yxEE?=
 =?us-ascii?Q?psVo9qDz/IpDNPv9GicqDKKD8clbrZv+iImVvJ4A/OermsM9MLqappcw4Lwf?=
 =?us-ascii?Q?+qw/egKw71f6pKVW5TGT8jAwABVS+EGmBLuuckyjgq1qIvE7Gvc/Wyvrh/zk?=
 =?us-ascii?Q?JBmNTz5gLi5sBovRzjYaZkOpTs2a9e4+s3CWFe62IgHorOAT7/aHchT7DcKb?=
 =?us-ascii?Q?ZmWJrKtJoDHVYTz4Ediut0Jr6OHuWoScAjzhv8W8mtL2UTFvnRjrOIRGlY5i?=
 =?us-ascii?Q?VvQCTMpV3GGHXes8vK/vhJkxKmCTzYlUT7yzJQ9F36Ltf88CpALiUII4GY3Y?=
 =?us-ascii?Q?3oleLCNKjEAC2Vi3HZD9lLHpwQEPDsGUdQJzrq4Zv+HvmXL+RRyg0/ox9255?=
 =?us-ascii?Q?IFdyRVlhhJty6aiJdyBekqxxKEU3Ig/9FlhKbuLGqkS1YMdSdec6POO80RXo?=
 =?us-ascii?Q?N58YzA+SjjO3VVicGS5RIHCFf6+3SRQzR2XX6casceA1cHH5JJQefldfh/5f?=
 =?us-ascii?Q?HSmGHjDu18TnBcGVu6hTEdB32vSACMXORqSW346Ah4OwYQHXYLAtaVEoeaEu?=
 =?us-ascii?Q?loN4fk2VhJ2drbuz/Jv3FDVmHEa6nFZhKKRkNQcKAY2dwgdt1KlX70FWSkiK?=
 =?us-ascii?Q?LF464eaC+wSlXlfXaCY7KbjrP3gLpZu9rEU9mv7amMzx7CzBqnHvGFua989L?=
 =?us-ascii?Q?zCm4IGuw9PhY82B3zFIfVKLaxI+0hZgh4Q9MxkkJIBkRreSWfrCY/ejdidGq?=
 =?us-ascii?Q?Gh37d33fcZlHfYrdv6+T+4gjGT6UFkG0rswYGHX6yzqTL5T7VooY9eyPEvZq?=
 =?us-ascii?Q?LyPQwhVfo5isExwrhoIrW1HtQ+zgbFNm5yCIT6MXVOOHhAPkhC4z/xAuNTB9?=
 =?us-ascii?Q?w2epK3zzMDIivWVEHX5QJrX++3no3wMRXG8R7xpIa3jYMuLqlHTfJSK6FKi7?=
 =?us-ascii?Q?0mZG8VO7t37t+dQakJkdN/PaCw/7KPfqkBgdD6vEecCfz828IFmLYuQdaAmD?=
 =?us-ascii?Q?vPg8qbrCpBaFBOmWQnh8sC9ZXxU9Idcg3EZ+lJiuLCM745SL6ByH/CdibQ+Q?=
 =?us-ascii?Q?WqaRXb2B8hhunI6fxdaCtX6YRQspAVqN/PYMd6nThiEhjJ0MtMLBG+ugiqAi?=
 =?us-ascii?Q?6usv9wrBF57umQ2WVt0VmmpTdj+Ir+Sq5BoiCIHhqSLSF7NaequeSrO7QXaE?=
 =?us-ascii?Q?kUlc2t1fnN1lv9wZzOA34m+Q8soKkw9TA/AzJTjKQQ1lx58PX3VlbzKhTcTH?=
 =?us-ascii?Q?fHVsTmiNeguVFtz37sN21yYXSb5gzqXqDT412Kv8zZJTpAT+eT7PGBIMpI6i?=
 =?us-ascii?Q?brpIXNpi4ULYy3xeXfE0366vtH33qTU4vpUANXz6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc74981b-da64-4bee-8d59-08dcc67c41ae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:40:16.1027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OFSZWpP+Q8e6la9eyeVG080bIZ/BsDN//h2k9Dqsmvwn7XiC1Sm7vZmbRJVD/PDZw7nxwRHI90iwLA7cJdxtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7589
X-OriginatorOrg: intel.com

On 2024-08-26 at 16:25:56 +0800, Chen Yu wrote:
> On 2024-08-22 at 17:49:23 +0200, Peter Zijlstra wrote:
> > On Mon, Aug 19, 2024 at 12:44:39PM +0800, Chen Yu wrote:
> > > On 2024-08-17 at 11:33:29 +0200, Peter Zijlstra wrote:
> > > > On Fri, Aug 16, 2024 at 05:15:12PM +0800, kernel test robot wrote:
> > > > > kernel test robot noticed "WARNING:at_kernel/sched/core.c:#__might_sleep" on:
> > > > > 
> > > > > commit: 420356c3504091f0f6021974389df7c58f365dad ("sched/fair: Implement delayed dequeue")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/core
> > > > 
> > > > > [   86.252370][  T674] ------------[ cut here ]------------
> > > > > [ 86.252945][ T674] do not call blocking ops when !TASK_RUNNING; state=1 set at kthread_worker_fn (kernel/kthread.c:?) 
> > > > > [ 86.254001][ T674] WARNING: CPU: 1 PID: 674 at kernel/sched/core.c:8469 __might_sleep (kernel/sched/core.c:8465) 
> > > > 
> > > > > [ 86.283398][ T674] ? handle_bug (arch/x86/kernel/traps.c:239) 
> > > > > [ 86.283995][ T674] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
> > > > > [ 86.284787][ T674] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> > > > > [ 86.285682][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
> > > > > [ 86.286380][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
> > > > > [ 86.287116][ T674] kthread_worker_fn (include/linux/kernel.h:73 include/linux/freezer.h:53 kernel/kthread.c:851) 
> > > > > [ 86.287701][ T674] ? kthread_worker_fn (kernel/kthread.c:?) 
> > > > > [ 86.288138][ T674] kthread (kernel/kthread.c:391) 
> > > > > [ 86.288482][ T674] ? __cfi_kthread_worker_fn (kernel/kthread.c:803) 
> > > > > [ 86.288951][ T674] ? __cfi_kthread (kernel/kthread.c:342) 
> > > > > [ 86.289560][ T674] ret_from_fork (arch/x86/kernel/process.c:153) 
> > > > > [ 86.290162][ T674] ? __cfi_kthread (kernel/kthread.c:342) 
> > > > > [ 86.291465][ T674] ret_from_fork_asm (arch/x86/entry/entry_64.S:254) 
> > > > 
> > > > AFAICT this is a pre-existing issue. Notably that all transcribes to:
> > > > 
> > > > kthread_worker_fn()
> > > >   ...
> > > > repeat:
> > > >   set_current_state(TASK_INTERRUPTIBLE);
> > > >   ...
> > > >   if (work) { // false
> > > >     __set_current_state(TASK_RUNNING);
> > > >     ...
> > > >   } else if (!freezing(current)) // false -- we are freezing
> > > >     schedule();
> > > > 
> > > >   // so state really is still TASK_INTERRUPTIBLE here
> > > >   try_to_freeze()
> > > >     might_sleep() <--- boom, per the above.
> > > >
> > > 
> > > Would the following fix make sense?
> > 
> > Yeah, that looks fine. Could you write it up as a proper patch please?
> >
> 
> Yes, it should be a race condition in theory and I've sent a patch here:
> https://lore.kernel.org/lkml/20240819141551.111610-1-yu.c.chen@intel.com/
> And Andrew has given some comments on it.
> 
> However, after I did some further investigation, this warning seems to
> not be directly related to task freeze, but has connection with the
> delay dequeue. I'm planning to add debug patch and investigate the
> symptom in 0day's environment, will send the finding later.
>

The root cause is replied to the delayed dequeue patch set here:
https://lore.kernel.org/lkml/Zs2ZoAcUsZMX2B%2FI@chenyu5-mobl2/

And since the race condition mentioned previously is real
(although not the root cause of the warning reported in this thread),
I'll send a v2 patch to get that fixed.

thanks,
Chenyu 

