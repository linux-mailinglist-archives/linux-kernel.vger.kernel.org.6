Return-Path: <linux-kernel+bounces-228195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E36CA915C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA011F22599
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08247A64;
	Tue, 25 Jun 2024 02:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYXS3hLi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84754652D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719282414; cv=fail; b=WE1kg38hh8dSsm/x8vRDsVJaLq5pqTbriAuyDSDgwyeP7S64jnR3dN1wuEgGzzCCru5h3rZjW85suMdYaCUpbFOpZ7/X4UDEwamciSOkcIQIdxQE4IptMr/D0U8ceEJdRvriqyhn6lClf28blmYwA9l4fyEjtzLp6UJIt2j/+js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719282414; c=relaxed/simple;
	bh=CdQhQINoFXpudilbd/sFxVo6w7kiAtuZ4btg68XJan4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DwwuukKXK9ifMtL9zz/XQr8FrQxmR3KvFkLiMqmZoEomtHYvRQh/kSHaRNFL7/cIcnAv+Oymlor58+4d9AeS2mc8LYumXbMxXxDOCGzty/DkoS6gKDyqjp0ZGiXuHThUt2w8+iVJPA1Bc7036PhLd2naOSDp7Juxy/a3uOv0jdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYXS3hLi; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719282413; x=1750818413;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CdQhQINoFXpudilbd/sFxVo6w7kiAtuZ4btg68XJan4=;
  b=IYXS3hLilBPI0ollwTdGP8qisnO8fQwETea4pJ1ALe89MrlqqpDXi03L
   IGazoXHXoC3YQI5UIeywaWq6NARAo3Vdahc7jX5ttytjD4hY/IjhX0CpE
   i/FFcaMxluWYBm2572uHkTpvhKtaRyz3rD8ZEkc9Lu1XdcCS2DSvDr7Dj
   PT7megkd+MY3XtTjNCcKDQhfj0gBS/xcczmlZ6XVBynGGEbo1BUC+1xGd
   PvRSfW6MvrO2ngauLv4nh/S34GtVjZQgAfyzp89t8wtr6Ma61rpKixKSS
   R85nDylNfW9yd8wSjRTw4u7WVpTofwTLb3RSwKjSfw+dS34PARHDinEIa
   g==;
X-CSE-ConnectionGUID: RGfiFoZTRmGOTddEEyUvKg==
X-CSE-MsgGUID: SRRnWYHjSkuFQiNznmADdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="41697680"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="41697680"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 19:26:52 -0700
X-CSE-ConnectionGUID: oJKGKhvOQzudbsc0EKIj5w==
X-CSE-MsgGUID: jIsveGG7RmuP630mWD8R/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="48662842"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 19:26:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 19:26:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 19:26:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 19:26:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLSbUQrRi2Ksq1kUvbnNCC6ktq5dvC7O4UjwrEhKT5zL1TSdgONhQiaMqOv7mwL7xshNOzOGjB2dWB1ERoCCk4QC6mJcclfD20w7gXzdgI3OZA3tgxdbf8Xerv8LkuclMp777ZsV1FaiutHyy1vbblQb6++q/UAKa65Z6TcRKB4VaEXrdzp7n3yiLER7xsadOMgW8YlqeVGD6zq/xnA92W7ahFrOMRG84VsAVmhBLjDj/VCcWoHQvJk/FpSqFO5iCYDEf+581bn9Y+6qZ5Z8IkXdoh5qXQS467q1G8sPjRS0c3XNg3ZHCxdxSoPX/Y8VsNsCQHVTN6yZ8T1GVarPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzXlYMTHlWKgFycP8K2uusnWXL+MchytELtWG3VuanM=;
 b=U9HESsjEhPGcscliEpODnMdGk+kDxuIk9VseBGkquK7MDXTZGOEdfAc/G8e1GFF7dyEstg7JgNdiNCOztwqS7NpAJaKubJnYqzq96/vK7gH4nQRSoOBHBQGEyWMbVTB/3mMQetROgfBeT2kXUifRSqGbV4M/KKSwVC0kpT86f4V14y+X5FFJANXtpSBieyd50HhHZmqY5ZFzrcP5LSVtWaAlStJVJWCZSCSR7laCOzAvHfQxDSSdRW+CQQ4b9jf7f1FoeZbmkNLwrjU9iVTuhQYLCPB/TrgZrDQxtEkEtDbM95gRgUmqipZiByCgTeK1I1yC1kRTYvKUwDShuxOxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6248.namprd11.prod.outlook.com (2603:10b6:8:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Tue, 25 Jun
 2024 02:26:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 02:26:48 +0000
Date: Mon, 24 Jun 2024 19:26:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzbot
	<syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <tj@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Ashish Sangwan <a.sangwan@samsung.com>, "Namjae
 Jeon" <namjae.jeon@samsung.com>, Dirk Behme <dirk.behme@de.bosch.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [kernfs?] possible deadlock in __kernfs_remove
Message-ID: <667a2ae44c0c0_5be92947e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <0000000000007de4c3061ba8ca57@google.com>
 <5aa5558f-90a4-4864-b1b1-5d6784c5607d@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5aa5558f-90a4-4864-b1b1-5d6784c5607d@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: MW4PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:303:dc::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 699afefe-775c-421a-dacd-08dc94be4395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|7416011|376011|366013|921017;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H9xdzsNgprqcyHCsDeWO0JONfqcdd9+FKyUtlx1gG2O6q9TQqoSkWeFaWXcr?=
 =?us-ascii?Q?H5IJBhRWPCfQd+a5CkmmaclTx6YY5dwoiYjLQw7vCTQ5x7FP7u+pLRJcaDX1?=
 =?us-ascii?Q?jPSMQNOTD5ZoTr7ZiZ/EpAQPWas0k9qVaOUxcbNRNL2prXRIH8lTfXNFlyVu?=
 =?us-ascii?Q?tF74GIK5PDu5OGQxSa1APU1cYfRXKThvfa45V67cm39Q5DooSEcpXSRgc/23?=
 =?us-ascii?Q?S0aei3e0XOPU4xnbkdJE6dFA637geCLdXHQP3ECGE7um00LtSACAJfA1FrZ8?=
 =?us-ascii?Q?vG9dIKvEMW8zICL+WyByEXpmATUQwZ4AFM5+IQlXCvP+ry35r2w6NZy2WjwU?=
 =?us-ascii?Q?TdTq5QKqf5lC/lzVduOoUN2sn4Cahr1Oe6DDxcGhPrulRZoos0HqEEA38yjZ?=
 =?us-ascii?Q?tgzrBHBMT6/T12K2vjlBAb+INufm1EiOQF+kgt5CwgESzQBDFuEQ2Api7Bab?=
 =?us-ascii?Q?poSunOp45rHqh6wNx3y7v+Z/b7skXxmj9NH3B7WXwE5tEWtEPeMCMGAhJgkJ?=
 =?us-ascii?Q?9HHvob1vO5NiAxCVoG9xxLS9+Ut34zYOS+FhUmC2Tntjrden39XJar08OPvF?=
 =?us-ascii?Q?JlDecEZSmp2eeKcwPXNBXWQ5VuGUCNzY3sORyju4sm4TSuYo5cLb/b/YrvUR?=
 =?us-ascii?Q?2e9STsct3Rsf4HAh6tw5rvGLYyOz2KgfamsSUVepCS+d1gXUZVcrws+Q9vK9?=
 =?us-ascii?Q?hpup6AfVcn94ij81HOxxOlQm3s8lK5XyGhVmww6z0qv7iBBgM3OGA5SNRi3q?=
 =?us-ascii?Q?sc4/K25pgf9VZdhwUG6p3PVfUkO1t9RLzu1vFDNWOB7/SRFg/GPst43skrha?=
 =?us-ascii?Q?ONI1o0Axbm1F8an5pB9gYlgGNsA1p/yBpaCehWpHyz3+xv3tITt4Pha235Nd?=
 =?us-ascii?Q?+Xuk3wh77kiqVPx5M8HO2DgWoD0vO8i1l1hgiLOuNluuglPRfXCTc8H1Yms0?=
 =?us-ascii?Q?aS3OvBYl/GEavno662CjOX59hJ41/QllEgmog/GmJ/tjBZeB6iKWPQeTclj7?=
 =?us-ascii?Q?0VcUtrA93KxsUdLUCVfMwkenmgQdiHQDGPNxSyzY8q8fwQ1cS9IOxAhsLaEQ?=
 =?us-ascii?Q?hKmibVHpZTygSvZKSC8fXW0E8SpmVUl6DNfYLYO7OnG8JVbZdWY0h2iukF75?=
 =?us-ascii?Q?IT4TWy0g/f9yhQfp664VoBAop5EXktt1b5HxibrkTmWqX2li0NAFc2Zpuqzn?=
 =?us-ascii?Q?gHBkDzpx8LP72MY98oMsTUzLrnyQZ71dvZJAH2oXJd2sAeDcJxWUH7Fbcp4u?=
 =?us-ascii?Q?Bk05VNwk92viGVtM/cnkjnEsP9/yVEJxVI1R58DQ+KkB6DUc73yGPuCa+TLy?=
 =?us-ascii?Q?jaStYK+R3QJCovD5Hqn8SWVx9exVGnI19UbytbhelLF3SwxFWmUm36PdORr9?=
 =?us-ascii?Q?om+Hx4I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(366013)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mu5KuEC9ky6BNNFZYPb1CySZnCZrMKFwllx68LZHrI3XGtgAKelklpRXgAZx?=
 =?us-ascii?Q?SfJ1V/z5UkoWuyvfAbdAV2HMALXNRSx1K9qpY8DD8jXYxua1A6cHDTqGlo+E?=
 =?us-ascii?Q?vQrE+4O/QKTN8/cLuJY/C45Fx1PqCzNskg9pEnT3UD+BCY7uHxAEllgWBgB3?=
 =?us-ascii?Q?U7OL8Lfu5Sbp9epZ1FRnLdYOwbfX+gZ6IzwA0H07IUZ3CKwma7zBfl0QWvw7?=
 =?us-ascii?Q?tVjhQAzKubnPlIDJzrB85TcR/FGi5dn2v6rANOOKG9jfyJfk/h6zWpa6gn9i?=
 =?us-ascii?Q?7tO7VRIP3evbRtMbsFK4B+MY+OJTn55LuUxgwfHEV6OwgUtZWNsjm6Mg+DS8?=
 =?us-ascii?Q?O0S9CV5K7dgR3ZUE3W2JFRmLn8Shmcf2gGjBLGfYo/y6Bqzhi9mOczgiK+qE?=
 =?us-ascii?Q?OmxHM93tc3SghYBdv2h4q2BeuOeqyGfiHFn4149v/5SumrFIiIEhfGAV38WC?=
 =?us-ascii?Q?fVMWVPX4tR9VrwvWhemZIvWookQunrE98wryjQIMoMTQaey3Gm0VczCS+lsC?=
 =?us-ascii?Q?lxzsz7AR/TRUmvb2ymu+l7TSUXq7qI0zBDZf7U26Oiu2gDyQQ9iplFIqn06R?=
 =?us-ascii?Q?McFeQl6W9ene8x4eWyFCpu7sZ/sgTvNzzIsW3C4mMQ2tMXhpmYn2W0njEZKx?=
 =?us-ascii?Q?A5eEiXw0T+4JQpB13zdeLog+CCNilgFgXLp7X+6X+CPZkharg+s9u4n9S4By?=
 =?us-ascii?Q?3Dnms6mFATZgylCoY68W7dI00AJTSj/WnbfA1cEM//xhVTaxRbTAIIpZ20M7?=
 =?us-ascii?Q?BjOdmmW/WpYFXxRQyN9x+AYgl0TtkejkGKgGilenzhu6JT0r/TtDSBlfBH3e?=
 =?us-ascii?Q?IlYTO0fUUCV0pMDSydzJ6jTGRlgPj9ZWmCnuyrbMGpJcMm9llD4xVdQ1CPcE?=
 =?us-ascii?Q?50mgVx7TKJds9GHVRvgXKr8nFS9GhhjTKzNFkIwLoXl65mAeb6bpgGn0iAXg?=
 =?us-ascii?Q?sj/gIaFaWPp9PwMzZc/nweg6KFwHXWSbUnzHm1PLZcx7xdIvKbfRntlzPVZ+?=
 =?us-ascii?Q?V/QOLEhvPJznv5YG3K8U2H+QqBDYhJTGdY2OA7um21ALA+8fXBT334HhxRcm?=
 =?us-ascii?Q?8MVKQn4jgj7YKJPWSOU7sWLs5of0CWVUYmrZjeqxlUgdBm+DNCyVlwt/dgXp?=
 =?us-ascii?Q?uZTtMhISI7bioqLEDytIzjxJznWYdfjZnEYNyalMsT0xCwbiihDUufORGKuv?=
 =?us-ascii?Q?PK4yT1hGTEl3SWxAUBObZApycniYOawxGX2BXh5qQRbOgIS1Wi3tH9BuDhuw?=
 =?us-ascii?Q?ef2hLGod1WFD7Bbwr4I3lie+mOZC4ejJcup6cqptPYro9VwF6FR7ooW+HwOS?=
 =?us-ascii?Q?YegU1G7kD5nJQcqUBXCA10rxqU1TzEbYfb02vTVKnT+M0tI831WNLk3N8jZ1?=
 =?us-ascii?Q?w+LmFimVOVzRiHpwDd3epmT2ZMPgjblS8UvfA9tOCVr4OFcgJWWvMM98jHiq?=
 =?us-ascii?Q?LA+N3tzvcpFoO6ByIzv9ZlmnEwuOwUt4Yv+N7WCSaChTmMdKX//4NIlYAGWw?=
 =?us-ascii?Q?LDpPu5hAMAMp7iXJTmgTFKInFvJDWsPkSClirMtOyCoL3WxRL12e9OnZ0+b6?=
 =?us-ascii?Q?VP1PAxWf4wizFKd1mosFqGeS5LytLJa9CriD5BeJwPQBLpL1BZz8nse8GN6n?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 699afefe-775c-421a-dacd-08dc94be4395
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 02:26:48.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpT8OeNC7v0GTdNeUmOikstuRyksHGv0IPQTwttiEvRcH94i51Dh1BI7R78nRPJ/mhcDoB0q367qEYmgWDOzZ9X2jlf1+CW502LhcKqWpwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6248
X-OriginatorOrg: intel.com

Tetsuo Handa wrote:
> This dependency is added by recent bug fix commit c0a40097f0bc ("drivers:
> core: synchronize really_probe() and dev_uevent()").
> 
> Commit 4a0079bc7aae ("nvdimm: Replace lockdep_mutex with local lock
> classes") changed to assign nvdimm_namespace_key on dev->mutex instead of
> __lockdep_no_validate__, which made lockdep to report this dependency.

At first glance this looks like a true positive lockdep report. One
observation is that attributes that depend on dev->driver being stable
are typically more appropriate as a driver lifetime scoped attribute
rather than adding locking within the attribute handler.

So a rough idea for an alternate fix would be something like:

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 83d352394fdf..a0536e6eaea3 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -672,6 +672,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
                goto probe_failed;
        }
 
+       device_remove_file(dev, &dev_attr_uevent);
+       device_create_file(dev, &dev_attr_driver_uevent);
        ret = device_add_groups(dev, drv->dev_groups);
        if (ret) {
                dev_err(dev, "device_add_groups() failed\n");

...where the only difference between those 2 attributes is that
dev_attr_driver_uevent additionally appends the "DRIVER=" key to the
uevent.

The problem with the above though is userspace may not expect that it
needs to re-open the uevent file over a driver attach / detach event.

Either way I think c0a40097f0bc ("drivers: core: synchronize
really_probe() and dev_uevent()") is potentially more of a band-aid than
a fix.

