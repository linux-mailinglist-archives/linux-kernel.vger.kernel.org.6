Return-Path: <linux-kernel+bounces-250138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D63D92F496
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07571F22E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1C312B71;
	Fri, 12 Jul 2024 04:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pisal5Gr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53517580
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720758010; cv=fail; b=YtF55blV+MMM9vSiRLVVIhoEqXzoz8+KXDv0iyxU/zbK3tAneHB4t8tApEFC6qs0QrFrsROHlM3nKqvKG8Yg6cDAGnbcdfMKGgd3v/Gyq4LTNSni0Z3Wb+z5fDnwmCwqkCr2ojebwRB6QpVDPTWDwDTLNlGJPk4hyqSam8zMqHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720758010; c=relaxed/simple;
	bh=PAwDjWOo6Vd+Iju49v1jTE0xu/WlFZv6buMSiWzenJ8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=DJ6TEA68XkxlusR2t5zauViC0Lzs7XtnaerMze/6Mllz/mZsjzHV3Z4TAjVa0bwcHj9wGppu21lhylXtw1r7BfoJgBowfHY+4c9oIaJ+gaQRQBHnSGPzcADwCrbz7LMOmYo+cpgUsEJnsPkHIdBi7BDEcZktpBqfAQPgKvXJkoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pisal5Gr; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720758009; x=1752294009;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PAwDjWOo6Vd+Iju49v1jTE0xu/WlFZv6buMSiWzenJ8=;
  b=Pisal5GrOHBx6ao+nrsKk7RdOo+C5dhiFz/CrJNZR3MPx2/IG15a2AvM
   qCJ8aMSY7P2nepnl3YnjrPkjSKEpVvJ7VqDOvYXn4rslf8jAmdEIT7Vg5
   vPAHNa5uzKGTfY4Dj1FzzofWNV3YBVx3y2S7a8JKUoopPwtz++aT02s97
   hY+4vmMs97CwXYBPDltyvv2Rd4/tPCHhRgsdBaa/UC0v+c3MpV+eCrRUA
   GrLIAFe6uQWIxtnCeOhxFgRuLIGFD6ZvdK04a29MUsNW+muw+mjEhgkN5
   ZMICERfNwgdKFDMxqedfa2jULIXiB6t9F6G2S4Vtxzk/xi4wzp64oMSr3
   g==;
X-CSE-ConnectionGUID: NC12/05ET9CbBTofnHs64w==
X-CSE-MsgGUID: lb1FuJkkQsKTnYiZFK3ELQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28858180"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="28858180"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 21:20:08 -0700
X-CSE-ConnectionGUID: Zp2ttPAmTwiZorscHKTQ/g==
X-CSE-MsgGUID: HiVk5kgKStqEkbSPf9wYNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48877587"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 21:20:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 21:20:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 21:20:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 21:20:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 21:20:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEmZOtBH6+f7uG12vKjw+tPW8V2OBfnHshW96uP6NlvWvdNej/komsGdFcDaBcQFGt0oJxKrtvmaevQaas7Kb6OgAdJgWIVFkucrKGyEohUCGS81GCdfittnDElvpUnB1dvTovBHhtOX0f16PCUCQGUMyg1/qw/HcnaldWWmHJTtmXeuwfEF60oGIDkyu8HSWGF/P1LmiIqqSkLS7geg4ukuA9IyRuwAOikn36GPyi+AluD4UhRVnbwK/mlLdZAPbPOdeIHD0zAYYksXW2z9WwTkO1zbVNM/TxbYAIDMPETnw1ECbXczGm3bASY+Lwh+A0k4cvwrHsgExoekHtF3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBH5VoHmLBrAfH397PIJrAVxXl0rEEuwSIMG2SejoNI=;
 b=rhNCcdJIh1KrgTb7MlOZJDwgXq73W9BPzDMev2HP6RA402qV4aXOmWDUXq3O9Ku/7nY7mvu6X+Aq6Jl0VzgHHWnl4nl1UWbAT3KfBUn6nDWzYMzplES3FZROa0oY58ubpqSAxGQJVprFbuf4bVcUCXIf0bgGnc0cx/S4kCXSJP2dBYKA9VncKJ21nWEZd52Y7TLVeo9lQHXsIeFzfg63j3PsdCkkF7pS8vHxdpSHN1HNaLnoNU5VrPmjOFwQ5QlaEdSs8/z7wUznPNvnLt1KqiXqVWSKClAKnwoqqE6o7/G1Mr4n3wGPpWzPfknLNwGEYDdwLTz4iEVlHh4x4b8R7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 04:20:05 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 04:20:05 +0000
Date: Fri, 12 Jul 2024 12:19:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, "Gustavo A. R. Silva"
	<gustavo@embeddedor.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240621-CbC 1/11]
 arch/powerpc/include/asm/hvcall.h:697:48: warning: structure containing a
 flexible array member is not at the end of another structure
Message-ID: <ZpCu60T5pgm1LT5n@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|LV8PR11MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8a40ce-03f2-48e7-e380-08dca229e7e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0uiFrIjV7fdsVKjlEhYmZAAjqKD01X36ZaNdquidVCPss2fjjZ96/f2qFJ1b?=
 =?us-ascii?Q?phLyLabykICzF0KGYJ2MqR0bDY7o+snc/a/6EITWG8ZLmCbCGDs38ZSWMTNZ?=
 =?us-ascii?Q?LMrvlrZTAwKBeSZYxLP4YCiLM8t8+gLQIZ51uwr9E3mIW50b9sa1flfP3LWU?=
 =?us-ascii?Q?NlWp72l/3s5FhA2yO9EDbQ4VwgIwT/oqwLGZ64wNLqViBpDQ7sJhCGH5dXZ3?=
 =?us-ascii?Q?m5r0LA8Yi84XjQpSEn/Ed2WkD6flpysiarrLF0I/40+PqKxI5lAfARYp5kKj?=
 =?us-ascii?Q?UMuXMwGtAQxTRrU7/infDTs3yKfnqAvU35He5upVryhnE+7dy6p2GfnAVHUG?=
 =?us-ascii?Q?wgRjzzT4ouzs29VOqEgUjXXme7BmY8E+b26slcJG/k4TmZPy1NF7uH6fkO4s?=
 =?us-ascii?Q?OXqEzF3X1xzNZAjxmPcIiW4cA/T9TkhuMfF+dCFpD5GysHt7L22MFXomSUrw?=
 =?us-ascii?Q?2O1uT3VcFheZHChGGAlm9FKQ58l7VTxQmrUw99bwuzk0KrFLIl9D/y7JaoaK?=
 =?us-ascii?Q?1rpU15wlnV+22BNot3o6cGPVSUDaBw8LMCQGHDQaFIoD52zuRhEFXgOR/cCi?=
 =?us-ascii?Q?wGwrpj+wJK1vMrfTLCtL0uH9z7EpWnNYc+S7aZvdPgBRXIk2RF27PSVgNbfZ?=
 =?us-ascii?Q?0Yn+PA+PuSVsshNZJ1xWheb/ypEMNUXZVjEeJhdaXu84StZtAKrxUXwLieyj?=
 =?us-ascii?Q?+WoYKYvPctUSlC1Kk9pr3Y52pMRj63SiINw1ggDBUl9q7SYGgq+cy4bKVdtW?=
 =?us-ascii?Q?mEzJJtReY4ab36PDnFunshMh0/ugcvBIdZBz6PKLLox4Z3JddEduQ4edfIiV?=
 =?us-ascii?Q?7cgQuzLxOjRnUfE7kIpyGhe1zo4th2Tn+04pyyAezrwPiDnYJ0EzmVyUPlrD?=
 =?us-ascii?Q?xPs2Z4XVqVK1PaBYccDo2YgRepJeTcBelRZnuZCUGZ5R1gKZ4c+/tmKZSBx9?=
 =?us-ascii?Q?BNgSs5vSw9kS57uWcF+OX25e3D3LJP4Af8S2wr/2b2GTvA1xssPVFsCjb+s4?=
 =?us-ascii?Q?WjE6IeEWOypsnJvuzhcnPVpz0vxBUzrE38pik1UhLv2BYtR8zsFMHxy5MDLi?=
 =?us-ascii?Q?uVML6S9wDwuThFdBx935hNdtqIS2vbPfdPY2SoD/kWvLvMv2Wz0ujIR1ZntI?=
 =?us-ascii?Q?8LP14yD9fcF9fsugxqjTE6lYYwxWD5Mwbg0Uo6mrErAPkyGHzogpv2eTDhlh?=
 =?us-ascii?Q?+O7xre3rDGITryTesjrZXns1mLcsc0zU6FFkfkow8pxqtPTBmS0BuZ3HW9mN?=
 =?us-ascii?Q?pO42jyV3VyiXpa1O7J7W88+ri8oZ/oMIjTIrlqEJulo1+CZS7M/CxBZ9K6AG?=
 =?us-ascii?Q?eFJ8p35HQ6RyCGxV9HBJ6HbT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FnpYtX22ue6I3LvyMfZJ2GksU8wHsZR/+IUSihDhIwaNd7bIM+1wH2vnZCYX?=
 =?us-ascii?Q?teNJpijB8eicK3mbP2D+fEZ3E+9yYzeKyBWb4sW0IQNco/ES6ZekmzV1JsFk?=
 =?us-ascii?Q?aQKwMkKYNdYuVpDDdHJ+hYWbTOIK2HbFL4toqvTqVcVQpY9RmRLFkom/Nmc9?=
 =?us-ascii?Q?9hGyVBLlZWw+KtNeXb26lHCWtbqsY37Mc9fSUYYzsg2chBZEAzI0BGKhFbNw?=
 =?us-ascii?Q?TFeJtPfXfJSENTRg0kXQTeStO4orXrAxRsfm8ENR0vCAENd0XD9BN1X1PxdM?=
 =?us-ascii?Q?I7F3NfsTrHuPc+tt2wQ0QkxcBrx27T3T9FkNWzHAW6ZYWgKLrfUCTvSc2U0h?=
 =?us-ascii?Q?3Sj22j27bflwsx139Rs9KmqbNaFzPoqon/X/Kl3oFthkqmY/KA+0tUH1hrdB?=
 =?us-ascii?Q?XQCFbiYrOADMfN7T4utAbKYlnZzqJdqTwWoqKGFy/UOOtMiPJkhDPwCdS9P1?=
 =?us-ascii?Q?pvq3dXf0ADwk+hypPsNRaKf8rlFGISr8TZ8JOwyFJB+O/WXZDU8BbLuPQJo2?=
 =?us-ascii?Q?St/Bgpw61ssM6k0jrgRtbM5FP+w9Ms1Yf+EHprLupJgbZaFAP0U/3tJbfmBo?=
 =?us-ascii?Q?LPX656qhnAZnPWUVLqJIcoLsLdqjVKRhPkfDpOrRleUzKP0j2umkIkqQjBiB?=
 =?us-ascii?Q?qlIUsyy7dMQfoii+5mTBPqCb/Hi8nwkWBR3oWHZfAGFi/ZclIssTF8ziLE2o?=
 =?us-ascii?Q?mopfceGGYBJn+RjYbcyAWxSO6VNmzarlc46/hAoZeIsieHE4lxUSS1hICiWE?=
 =?us-ascii?Q?Kog9zIZHbgbq8z/Gz1usSlmJG003yB1TfQF6bWZpVYRyHydG6DnerkAvoVJ9?=
 =?us-ascii?Q?w1til5bANRZVti3sdhViFtJKjnTtDDSiwAqW2mESqyI246moWELLu4YLbx/g?=
 =?us-ascii?Q?y9RBcJUYm4939aCeJQa3cNKXPv07QoGezya47wiDcAChz0dYRSyjcdnAOzY+?=
 =?us-ascii?Q?yY27TlTR/37zG4YfWNAwt0q9vFDRD5D9pjf7+OEpmdGNu+yOu2tdOf/LGBa6?=
 =?us-ascii?Q?QLl8AE02Jz+DVRo+gmT8FKW/+ENtb5aRowvfcHYuHss6YL+1tcS5btYwrjao?=
 =?us-ascii?Q?pqjXnsSAUZgja3Loay0jAJuj6Z0W9Kgdk3XIcZNwwkiFf54A93JrNwuZYfRr?=
 =?us-ascii?Q?rdwgQ17Gc5/Fdkg3jw4cNoP7b6YRvAFNsRfOV090CsFq57X8XOSvkLdtgpD0?=
 =?us-ascii?Q?G89LaTzYRKeSzh568F84OYhdSpzDU7jfP/+AT1Rq768Bnoie7p9+48YgkjnC?=
 =?us-ascii?Q?OhAHyWc71MxT68xcOHUHQG7PZJ5Py/glUtrzUHLf3vWV/7HtpAaBNtav74MM?=
 =?us-ascii?Q?A2uJMWlpA14zXTxsfVWMn2x0cf/SUM4dCAFbz0mXkOHwUT+OOAbF15qFJ6hT?=
 =?us-ascii?Q?BCUJZYWKvMg8k9Syuf4jPaaCmxDa3sByBnAYX5qlFfzCcPoPpEYwe4NXrhEV?=
 =?us-ascii?Q?aOaqOXd16jbjH+aTmdpCAsZRXULhseg2fGYXQ8augeUFa/JXw7wEi+6H41xX?=
 =?us-ascii?Q?jv9CEms0kpEvyVliv7G3n40/UvpL2DB2aJjbXvd1Hmcomtcl9AX6aotyG+2b?=
 =?us-ascii?Q?jsAuiwQMtpdMzUaM/Dzmp9xLC5AzGESb99lwZ/7CK254Q6xpUMq2+eHHm5wS?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8a40ce-03f2-48e7-e380-08dca229e7e7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 04:20:05.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omdj1J0Er8MDWAYKjG7vqh+lZhSoBj1I2FIbpXcj8qHXny8zi71O1NMqM+rMlex9CHrzBjtBYrjOrw6PmzJNyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240621-CbC
head:   30867ef8ad076c11ed274d76f99e8bb0346790af
commit: 18c8dad6dac24de88b5379ad4e367e50d06a96ec [1/11] Makefile: Enable -Wflex-array-member-not-at-end globally
:::::: branch date: 5 hours ago
:::::: commit date: 2 weeks ago
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20240711/202407111827.iLqomSUr-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407111827.iLqomSUr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202407111827.iLqomSUr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/kvm_host.h:26,
                    from include/linux/kvm_host.h:45,
                    from arch/powerpc/include/asm/kvm_ppc.h:19,
                    from arch/powerpc/include/asm/dbell.h:17,
                    from arch/powerpc/kernel/asm-offsets.c:36:
>> arch/powerpc/include/asm/hvcall.h:697:48: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
     697 |         struct hv_get_perf_counter_info_params params;
         |                                                ^~~~~~
   include/linux/kvm_host.h:1838:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
    1838 |         struct kvm_stats_desc desc;
         |                               ^~~~
--
   In file included from include/linux/security.h:35,
                    from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:94,
                    from arch/powerpc/kernel/signal_32.c:26:
   include/linux/bpf.h:2002:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
    2002 |         struct bpf_prog_array hdr;
         |                               ^~~
   In file included from include/linux/tty_port.h:8,
                    from include/linux/tty.h:11,
                    from arch/powerpc/kernel/signal_32.c:33:
   include/linux/tty_buffer.h:40:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      40 |         struct tty_buffer sentinel;
         |                           ^~~~~~~~
   In file included from arch/powerpc/include/asm/ultravisor-api.h:11,
                    from arch/powerpc/include/asm/asm-prototypes.h:19,
                    from arch/powerpc/kernel/signal_32.c:44:
>> arch/powerpc/include/asm/hvcall.h:697:48: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
     697 |         struct hv_get_perf_counter_info_params params;
         |                                                ^~~~~~
--
   In file included from include/linux/security.h:35,
                    from include/linux/perf_event.h:62,
                    from include/linux/hw_breakpoint.h:5,
                    from arch/powerpc/kernel/process.c:37:
   include/linux/bpf.h:2002:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
    2002 |         struct bpf_prog_array hdr;
         |                               ^~~
   In file included from arch/powerpc/include/asm/ultravisor-api.h:11,
                    from arch/powerpc/include/asm/asm-prototypes.h:19,
                    from arch/powerpc/kernel/process.c:61:
>> arch/powerpc/include/asm/hvcall.h:697:48: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
     697 |         struct hv_get_perf_counter_info_params params;
         |                                                ^~~~~~
--
   In file included from arch/powerpc/kernel/sysfs.c:17:
>> arch/powerpc/include/asm/hvcall.h:697:48: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
     697 |         struct hv_get_perf_counter_info_params params;
         |                                                ^~~~~~
--
   In file included from include/linux/tty_port.h:8,
                    from include/linux/tty.h:11,
                    from arch/powerpc/kernel/setup_32.c:14:
   include/linux/tty_buffer.h:40:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      40 |         struct tty_buffer sentinel;
         |                           ^~~~~~~~
   In file included from arch/powerpc/include/asm/ultravisor-api.h:11,
                    from arch/powerpc/include/asm/asm-prototypes.h:19,
                    from arch/powerpc/kernel/setup_32.c:45:
>> arch/powerpc/include/asm/hvcall.h:697:48: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
     697 |         struct hv_get_perf_counter_info_params params;
         |                                                ^~~~~~
--
   In file included from arch/powerpc/include/asm/kvm_host.h:26,
                    from include/linux/kvm_host.h:45,
                    from arch/powerpc/include/asm/kvm_ppc.h:19,
                    from arch/powerpc/include/asm/dbell.h:17,
                    from arch/powerpc/kernel/asm-offsets.c:36:
>> arch/powerpc/include/asm/hvcall.h:697:48: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
     697 |         struct hv_get_perf_counter_info_params params;
         |                                                ^~~~~~
   include/linux/kvm_host.h:1838:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
    1838 |         struct kvm_stats_desc desc;
         |                               ^~~~


vim +697 arch/powerpc/include/asm/hvcall.h

59562b5c33d6ff Scott Cheloha 2020-07-27  691  
59562b5c33d6ff Scott Cheloha 2020-07-27  692  #define HGPCI_REQ_BUFFER_SIZE	4096
59562b5c33d6ff Scott Cheloha 2020-07-27  693  #define HGPCI_MAX_DATA_BYTES \
59562b5c33d6ff Scott Cheloha 2020-07-27  694  	(HGPCI_REQ_BUFFER_SIZE - sizeof(struct hv_get_perf_counter_info_params))
59562b5c33d6ff Scott Cheloha 2020-07-27  695  
59562b5c33d6ff Scott Cheloha 2020-07-27  696  struct hv_gpci_request_buffer {
59562b5c33d6ff Scott Cheloha 2020-07-27 @697  	struct hv_get_perf_counter_info_params params;
59562b5c33d6ff Scott Cheloha 2020-07-27  698  	uint8_t bytes[HGPCI_MAX_DATA_BYTES];
59562b5c33d6ff Scott Cheloha 2020-07-27  699  } __packed;
59562b5c33d6ff Scott Cheloha 2020-07-27  700  

:::::: The code at line 697 was first introduced by commit
:::::: 59562b5c33d6ff3685509ed58b2ed3c5b5712704 powerpc/perf: consolidate GPCI hcall structs into asm/hvcall.h

:::::: TO: Scott Cheloha <cheloha@linux.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


