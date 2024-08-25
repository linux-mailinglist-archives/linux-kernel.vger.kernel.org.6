Return-Path: <linux-kernel+bounces-300420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A7095E370
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 15:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883F1281B61
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E8A140360;
	Sun, 25 Aug 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/9/23Wj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C68B1D6AA
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724591144; cv=fail; b=Gwy0xfWs2l+8xgcTfV74SFSb2jsv4caMTvakYzksm16NIho9qYS0u8Rq8aJo7JNVoi4IHPt4ND9gXc6+LupM4yyl7txvBWRxzvDMZY6b09olCT7PDL8pnYdjCTq7DGid/iQ+UwYDcvY5FlqlOsJBt+whjpMv5IeYz4id4m8pU9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724591144; c=relaxed/simple;
	bh=bZmCo/i6ABi8YAN+H+HAJLE0uOwE9csJd2bjFTujObU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bEwuN9JU6bshtAHaqJrKEG90DnkurwL5ZMCZzT7qtF/KEbDckmRLhUio3sk/fnYEZrBTXJgl1uBBH9u60HiIHTB9ajJKQ+W+KWfDTN8C1oDuciw1NTjrV2+ZgARDMbffHPmHmrDPwyj/3oXD+QHsy9jZgevONh7zrgY1XHYHYt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/9/23Wj; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724591142; x=1756127142;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bZmCo/i6ABi8YAN+H+HAJLE0uOwE9csJd2bjFTujObU=;
  b=E/9/23WjRK5J2fmmI44Ke1frPiDjZkgQiE3003E3Xl+nVNrAr1DuBovr
   1h77abK/xSrqOyeBQyVeO/LiXS7LPPnNtUyNBS6M2CjxubD7+leoVcyMg
   /63nY6Hw+xux6BI8NMS36hOMI1GHsq2LercoQNrzKq7gonX64frDTzoOd
   SgVIJ6x2Fsn2QkPAqnFF2Y0NwY/UV7RqgE4y+a/lU0tKD8p9lgcYzbpHZ
   QwDb/vcoqbwcqH5r+SZUJ0+M3v1nTUIJ+lHYI5BTHFsqZHhbCJLVeb3pc
   /HpNgSswovDsh5pxQLcJAhZQ6S6+NgZR+IFQ+tMEr/ygHllFT6JyJXcXC
   g==;
X-CSE-ConnectionGUID: gauY7/WlQ/yNEHiJuWlJag==
X-CSE-MsgGUID: KU+v/GerT62eOBsF/hagYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="23169212"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="23169212"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 06:05:42 -0700
X-CSE-ConnectionGUID: Q2SkwE/yQ16LfjludAYPSg==
X-CSE-MsgGUID: XwGnHf/eQ8mR9uDU9LqjQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="99752502"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Aug 2024 06:05:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 06:05:40 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 06:05:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 25 Aug 2024 06:05:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 25 Aug 2024 06:05:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkzLqdxIC8CH7/NlSNV96weSpRhSAGj1hJdCFWhW25/S0pzYeOPiL2TSlPtsZdl6TNy71TqBYyj4aFH7bhRccEJAMaEfmrwmjI2bfSQ7N66PTQOFxnZ+6UxXQurYwWnl07iGAcXKUMTrPrUhnl8PaO728Nhy4rWZKJmAXu4h7769eYUIbLt1kTOUMCJYJD+QqYggXRAVe233L+WNhriCM8g2RoBVZ6vbimVGfSyUmPBd1UQk61Buu+1ImIujZ+nOYXsbD0Ubz2Xu8ChmcW9HuQqh78exaUUnAhC5IqtUdI7q5aKCaEobOjXILVBM0gBr+e2s7JTvhMWPIA2qnLgx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5AE4FIxONcG0gxG8DMj7MeAE/K/2IslJ7ANPXQHc4M=;
 b=mU7M/ogj20tKZxTmvYa1Hy4FPdcyWcKQl5UqMt9RBl/oV5PZgfW/cfIli1uIJFu2U2fZiDjrxONaB+OqlnoqI1+BAOnqAnIi6qrY9J2koSalwudW1xIBVtm7zM8nyp2pMdUGAAyd2lg9jeXWOk/i95KWxWoYEs701hC/L9aMzEqe+z5Yz5hPXUcdPJdwOUeAHzzfuuRSZnDr48LxbLSCEm21y5MrEYuwSGG2wsL9NKpXEnQQY0RIDUYhorDG/yda5EWvYo/xrHOSKT03Gwp86Ioqv1wiFdkeFq/9JU2LFvet9DQ6LijIiFbtidk4UfySx8ph6RndTSQrUR1/MCf/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Sun, 25 Aug
 2024 13:05:38 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%6]) with mapi id 15.20.7897.021; Sun, 25 Aug 2024
 13:05:37 +0000
Date: Sun, 25 Aug 2024 21:05:25 +0800
From: Feng Tang <feng.tang@intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: <nicolas.bouchinet@clip-os.org>, <chengming.zhou@linux.dev>,
	<vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, Pekka Enberg
	<penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"open list:SLAB ALLOCATOR" <linux-mm@kvack.org>, open list
	<linux-kernel@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V1] mm, slub: avoid zeroing kmalloc redzone
Message-ID: <ZsssFS68lfFR2yJU@feng-clx.sh.intel.com>
References: <20240823062415.3632189-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240823062415.3632189-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|MW3PR11MB4650:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aeb2ae0-30a9-4792-c0eb-08dcc5069d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3c7zl1WQLONEQNa2TrZdGUpl43gX+LhLNk9c4BAZE7XIxgJ7nJPwlGhVgzr8?=
 =?us-ascii?Q?bQaaoZFmJHrY7q4JgS80Sys3OiIY06cu8zlGIrQCT9EX1TlbqdcaG5ac3Rv5?=
 =?us-ascii?Q?5NZ5ljFECxGpxIrINUbaFQyrYhIWJ6rSZ233mzUIER6KkvW78vZoZ5zYMcR3?=
 =?us-ascii?Q?wV5BthlvaiJQe5QSK7XQOtAYGe6WyFWIQ1g29NSqoyMyF9om2UUlh6+hzado?=
 =?us-ascii?Q?RT/wmN6H/JNhHRVixAijKjHmgsieUJf6bUpfqcfNfztyGs2wPf2mJ86ootGy?=
 =?us-ascii?Q?qBKv6D9lZapwstd4HbTbJH3opXAa/+DgnW4osPlduFghnviDAhO8NsM6nCbl?=
 =?us-ascii?Q?sc/17fluNfuElJHlxkcObpL+7KJpha+flfjRNVvttIvYoRiU/m6aBJwuTqdQ?=
 =?us-ascii?Q?qgmpr7Hc0g1FSXgsFzDYHR7gOqq2g8ZKKPH0f71c8SSuvMOBFO9JNnUhngyz?=
 =?us-ascii?Q?i0ajcjm04ixXK/V6Kb+INJsF4isJKswKuNPwwaYpXc4hqdzZPDd7uxKkavBo?=
 =?us-ascii?Q?pNxtG7GGkAftgokFBOxE6XIGo2vI0srB7zGKZu5iYLzhXAmSO+1geyaChCR1?=
 =?us-ascii?Q?CD9lIjMK6JXTK7NPcqeJR86GjPo3+diOBmsIWBEE2UexKcr9++FTx2uU4+c8?=
 =?us-ascii?Q?/rageoIKbNrfdcGEXJ/SNX3PIjY1YXP1zJ9uFnZQahRofcIBAXWKq/YYVCe6?=
 =?us-ascii?Q?/9xTSRx9CbccpHKXw+7DTQLFzB/G/BgBUBh5dXmByB/mFBHmrKAHfw1jvE6F?=
 =?us-ascii?Q?2TyfekDTKgtdb/r6dbeTri80a+hKQEyhGPkYDOruDhiNgFAJ8fXpn1K+/tkp?=
 =?us-ascii?Q?os05FCCR54OnlLqRS/D5ucFwVWHCCFzv5rKFPOuFqAF3gEh+4NWBiTkrfn3G?=
 =?us-ascii?Q?G9pmkH5VZvzNSM8qy3Js1oDuMOJJZeTqjvuT8u8rMa/MADeDdY8T6NmdbwYg?=
 =?us-ascii?Q?gFEF2KlWTIUPr7hJiamhaUdp18eZX0GoOlTChgpiCG02HUMgcVTxNxIYXaIP?=
 =?us-ascii?Q?FNSeSysOFoEAq2te5lhFWMUs+Qyp6lpFU5H3h9i9KpYLPKaMFl1jjOR8bour?=
 =?us-ascii?Q?Eng2Pxvx3j4dQANE/Aw6OzpsJdq5xj8RthSijWzEYNDdlzg4y3U9fRBa7Lqa?=
 =?us-ascii?Q?x5elGJy8xCwot1a6dHXFlWans0phXoZ8qRAr9zX5K1VPCFmk1fdFkWENT6GX?=
 =?us-ascii?Q?eWSlaaQyZ6JlAMVSp3P0uJpvnA780HFMfanTTPPNxnli58ZQcQyFWG0YbZDA?=
 =?us-ascii?Q?r/Z4jfAPjLWteXgoc9Yu9tR9IjG0c+6XDrnPUbaH2GtvxvGXU39D8YRNIe/S?=
 =?us-ascii?Q?xyFn8wAMmoy6kbRZwjkBLUejy3YTZCkuXFcQ9g2KMO8MwhSKig2tsT76bvn2?=
 =?us-ascii?Q?xAEVSME=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GdSD9KdvNWppo3xPXaQ3+RuEkgoCPI1T1L+LQTILHtFKTcLnv5YyA1duQSh?=
 =?us-ascii?Q?e+N0c9Z0kqKgeE+yNY1YL6uTfU1NLtV/A9z8HIO7JeJJ1CCJi7QMXGdyBnXt?=
 =?us-ascii?Q?b8GHx9LpfFAzpzwZUUHEW1isHw2fYzITmZfdqnsQAZuB/S90ZA1XtghN62pS?=
 =?us-ascii?Q?GdLJzzTHG3smuf7IwEkghMKoIoRTlTaEgzDNan4LAvfRZcIOxWaKQ15o14fn?=
 =?us-ascii?Q?TRI+gpc3UuAXC23KPjrm41S0DEv/2z7FvbCZDZFJIMqJ81iVzWuq7ksnO0K1?=
 =?us-ascii?Q?vMURuTu7N9maFV3raZkxhI7bjsKzHUhBpoKNgCy2rgd5WM5lFbG6j9Ojaslm?=
 =?us-ascii?Q?d/ou8SlDzDgzMXlBoTxt92lIJ/EzfIk9luq1XErajC1hnLEAv1KrHbKDMUNx?=
 =?us-ascii?Q?ks7+athaUQYziLDUgMFS0f42UQONPExPQ7KwZyMuup1BkTt2AK1f1yXiwg3N?=
 =?us-ascii?Q?+eS5vEagd14UjnAm5sO3M/I3GqRNBsI9YC7GlmcOz1ruBCKUgCpCTICrsguM?=
 =?us-ascii?Q?a3SPcb98FtOMTPDiJQbhIMJ1Ej0SH7bmA0FRDSu152tTygFp7Slx5xBB79kA?=
 =?us-ascii?Q?0JY3FHes0Mnn8pabIOE/Fy3eRJB0wSaNNylXngCbI4U7svEJw5cgYtxXGfxs?=
 =?us-ascii?Q?WrxiQdWKCEVN5QS3+8fVnJgHOXfKVjGtIAdVdNzmtD/pQ7qKrAx8TWRPRTcb?=
 =?us-ascii?Q?yFlqmQHc5u0Vgze7rKU+OHZtJJnhCBls94kzMO6aq/uoG52z4dofaMC8djmG?=
 =?us-ascii?Q?RjPpNipAs+xlT+aNNlbxL2MgiUxTp8F3Kyf+QfAMg8fSc6Q9bGvJUMkyS1Ap?=
 =?us-ascii?Q?Lc8g0bKmVu+diZ9t5LLTw/wbYQDxHihxurpttID+JvqcMzsmTBxyVHBsRlh4?=
 =?us-ascii?Q?cwSo7xU3iSCYP73pr5IaoDpTAcPSSpeT1fBJkxZ5982YmMgbAfbLkPabX3ap?=
 =?us-ascii?Q?AZEvgcvjtQg1XA4pILSGsmgVLFoQjWbyD0yPr5EnYzJ5FyNptbZQK3Ccbi+N?=
 =?us-ascii?Q?cHmezvA/Iv+Vlt3FnvsGnLCOtZEXQNS6aOwgL0Fzn8yXaj1rT/nb6Hyv4MPV?=
 =?us-ascii?Q?C+zmXj7xQ10gE5gCgObodhiHA9UKcivyezrDGGvOZOWIA+D6bemy3LDxHk/M?=
 =?us-ascii?Q?toFEg9/BHGiXxA5MRemUq0CEgWPdh5kJfsdaRcPWhEoUiBa16cRJ/CgXrd1P?=
 =?us-ascii?Q?1Xm/pX/vQCJudYLorCM29FeSOwhZiaHbyPXDFVtQ44KLh7E6g5tes+zxeeQu?=
 =?us-ascii?Q?YJiXVCVub3JZih/wmf1EH67CbWDtLE1nAJ8k0yXQDCgc5ZE+GqQ1iCeDj6i/?=
 =?us-ascii?Q?jEzELi6WxnbhsCvylybPYKTwJg6A9iGTsnlLuoSLLniCU9q4HEXuWq7+4+wE?=
 =?us-ascii?Q?2wXcmCNEijRpdcPp26i1HOMkxm1nGNu9WsWYGe5PF/eM6oqYQTvBL+Dyc8jw?=
 =?us-ascii?Q?QIdLAQxrVmnaR6Rc7rqeR07JrELcCvWL+nqRHELtffBdaVn8erYGoayge+CR?=
 =?us-ascii?Q?EAXxF4wGV107DMxW6EiHvHt+iVFu9U/tfibHAp3+C80HHbWebH+KtHSzUnUq?=
 =?us-ascii?Q?H72y2PF5YtmqbgQgK+VDTmRby8ME5iDm1tTkX1Ke?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeb2ae0-30a9-4792-c0eb-08dcc5069d04
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 13:05:37.8108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G824zODSEib6bYhpp+7mnLRx9Kv2eqOgAZ2jlAMvcFUoIqFtt+QEYIU6RuTJ5Y5f77lGeqHro89g7r/BNnFbcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-OriginatorOrg: intel.com

On Fri, Aug 23, 2024 at 02:24:15PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> With commit 946fa0dbf2d8
> ("mm/slub: extend redzone check to extra allocated kmalloc space than requested"),
> setting orig_size treats the wasted space (object_size - orig_size) as
> redzones. But (in check_object()) when orig_size is set to zero, the entire
> object is perceived as a redzone. To a valid allocated kmalloc space,
> when init_on_free=1, the wasted space and the orig_size should
> not be cleared to 0, otherwise there will be kernel dump:
> 
> [    0.000000] =============================================================================
> [    0.000000] BUG kmalloc-8 (Not tainted): kmalloc Redzone overwritten
> [    0.000000] -----------------------------------------------------------------------------
> [    0.000000]
> [    0.000000] 0xffff000010032858-0xffff00001003285f @offset=2136. First byte 0x0 instead of 0xcc
> [    0.000000] FIX kmalloc-8: Restoring kmalloc Redzone 0xffff000010032858-0xffff00001003285f=0xcc
> [    0.000000] Slab 0xfffffdffc0400c80 objects=36 used=23 fp=0xffff000010032a18 flags=0x3fffe0000000200(workingset|node=0|zone=0|lastcpupid=0x1ffff)
> [    0.000000] Object 0xffff000010032858 @offset=2136 fp=0xffff0000100328c8
> [    0.000000]
> [    0.000000] Redzone  ffff000010032850: cc cc cc cc cc cc cc cc                          ........
> [    0.000000] Object   ffff000010032858: cc cc cc cc cc cc cc cc                          ........
> [    0.000000] Redzone  ffff000010032860: cc cc cc cc cc cc cc cc                          ........
> [    0.000000] Padding  ffff0000100328b4: 00 00 00 00 00 00 00 00 00 00 00 00              ............
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc3-next-20240814-00004-g61844c55c3f4 #144
> [    0.000000] Hardware name: NXP i.MX95 19X19 board (DT)
> [    0.000000] Call trace:
> [    0.000000]  dump_backtrace+0x90/0xe8
> [    0.000000]  show_stack+0x18/0x24
> [    0.000000]  dump_stack_lvl+0x74/0x8c
> [    0.000000]  dump_stack+0x18/0x24
> [    0.000000]  print_trailer+0x150/0x218
> [    0.000000]  check_object+0xe4/0x454
> [    0.000000]  free_to_partial_list+0x2f8/0x5ec
> 
> To address the issue, use orig_size to clear the used area. And restore
> the value of orig_size after clear the remaining area.
> 
> When CONFIG_SLUB_DEBUG not defined, (get_orig_size()' directly returns
> s->object_size. So when using memset to init the area, the size can simply
> be orig_size, as orig_size returns object_size when CONFIG_SLUB_DEBUG not
> enabled. And orig_size can never be bigger than object_size.
> 
> Fixes: 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated kmalloc space than requested")

Thanks for the fix! I missed to test the 'init_on_free' case back then.

Reviewed-by: Feng Tang <feng.tang@intel.com>

with one small nit below

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> RFC->V1:
>  Update commit log (Per Hyeonggon)
>  Use orig_size to do memset(Per Hyeonggon)
>  Add get_orig_size and set_orig_size when CONFIG_SLUB_DEBUG not enabled(kernel test robot)
>  https://lore.kernel.org/all/20240819064115.385086-1-peng.fan@oss.nxp.com/
> 
>  mm/slub.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 94f5a4143825..a5fbeb2835b1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1895,6 +1895,15 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node,
>  static inline void dec_slabs_node(struct kmem_cache *s, int node,
>  							int objects) {}
>  
> +static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
> +{
> +	return s->object_size;
> +}
> +
> +static inline void set_orig_size(struct kmem_cache *s, void *object,
> +				 unsigned int orig_size)
> +{}

Current get_orig_size() and set_orig_size() are protected by
CONFIG_SLUB_DEUG=y macro, and with this patch, they will be called
in both ON and OFF case. Maybe we can just lift those existing
functions out of the "#ifdef CONFIG_SLUB_DEBUG" protection?

Thanks,
Feng

