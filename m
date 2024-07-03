Return-Path: <linux-kernel+bounces-239518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CEB92618D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F341F219CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CCB17BB27;
	Wed,  3 Jul 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CS+EtX55"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872617A596
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012365; cv=fail; b=hCttNgnT/2xvbi7vHwzyhasTPoiBPbLN9KaqwTlYzAk6gmuLVG1S93CBd+6Ldt5DR0cQX6RBkWP7MyijyngFDdR0Qb0yligUQm24m3Ks9hRyFzWjHb8LjJLr6ycl+QMqXg+0X5ZZ/Kt1NmzCgAqP/TCcBi8e3JkZDVpPdKMa6jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012365; c=relaxed/simple;
	bh=mgYM94S0ouZSPtQ8KzFL2cu+gm5QHEvhBl3zJLFYy9Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HMvP7lp0JGXTKowsmtii6cziQNXnSL4Kj18BAOdddK4sJ4/I9jSGUqo9gKdbB9Nb7GXgKlxzSqUrWYXlNUkgSQfLZYICgsOL9IH7Pi2xFsdZhVKKjzebkawoQK5fOb9s1w3si/r10rfVHl2XIKXceU7Fvw0DNtnIuyi9KGKrIDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CS+EtX55; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720012364; x=1751548364;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mgYM94S0ouZSPtQ8KzFL2cu+gm5QHEvhBl3zJLFYy9Q=;
  b=CS+EtX55xtHgBRU92/JBkuUszGcipDOpUbOttFQBj9fZ98l36/+wZPct
   upGyMCK/vKyE8xQVI/gnJsbQffYGD5VIjtYRlzWjT3c6O1b0tdtc3z5We
   kGqS/ZR+uha7YAfuQv7drXTv6Bq8MJ0YMdQ+ZflzqR6hchPJEZiLdTgYE
   SVJ0lZRyMkWcUP6SIObjK87YXkAgnPAZUbL/eebH2FS6WkfRfDLCSOD/v
   4DioQCff5t+zm0ktraipc1otcTwSCiGP2B0u3OEOur8PQ3t9tykmAEJOj
   AGzwJ0+bqc/8yXF4y05FS0+2/LCxcz5nMLc2lGozlhqXjZkrNAiRgLxk6
   A==;
X-CSE-ConnectionGUID: KuKugACxTYWGVpXJMLhOqw==
X-CSE-MsgGUID: 7RU/IgoBSnyMkZNs/gp+aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27857129"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="27857129"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:12:34 -0700
X-CSE-ConnectionGUID: 7CRE5cUpS2mMSzGopnMrvQ==
X-CSE-MsgGUID: x1gZR4AhTY+HH+pvrTy7qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46321584"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 06:12:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 06:12:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 06:12:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 06:12:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAASQ6niCtreC0tEzw+/9h8L3MphZ/aFK5xjpLXnqcvsWz6ywTuTUZcwI3YQQTnwFY8sBwVPbu3RE8K+gSk4reK1lIFZDiDJ85y0LNVhOt56DUq53Aw88LApFZZvHZ5BSVK7/QIFX2dBIDp57MzCQJ5qpHBlQN1h2z3QXw3w0z2iffC63HR31OANsMp7jX+FHyxaZvYOoKhDJYwy3Ej615psDYSoLlFoGiBXSjvI6O1xZciuzshOK7Ecx2WTCBBpiQJzqWSKhDkicGAlNyX0RNRYf+arqClNj4+oE5J2gzQFZ9/N6R2UQs/t33iKUWdMrZxmwpHM1cba/kq/5sCGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sygzP2NECoBh22h34U3aWjuLQoecnf3kerJWlS8AN1o=;
 b=kgsiacDfeV4Oy3m7l9L6K2QQHAwowXq9NHuafumr5MnhCm3FTlUqGgBn6bg+xph/WVdB0kwIM+iaQUTe/UEGkaQ0yVyeFkoJjjruwRgwunid66eu8ziBS7HgEI1VJ+ISnDY96AcdLBrmU+LX4xRwLhDBsxDcT493dkJ3Wny+fW0nSJnyRlQRNQPOSC1SORBnBAsISmoXglB9rRjupmdN19VOJLGH/fnFKk+q3PXEIBfp+pAdH3jrrgBfBmdzZo2WG1rO99So/De4NrWbc9u8JfBFJ8mN/ijrHtvD/uEuYPbNMQI75MvXkcr9JKku9fWGMObs6O2li4xJLWwFutI0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA0PR11MB4670.namprd11.prod.outlook.com (2603:10b6:806:9a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.25; Wed, 3 Jul 2024 13:12:31 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 13:12:31 +0000
Date: Wed, 3 Jul 2024 21:12:15 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
CC: Mike Galbraith <efault@gmx.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, Tim Chen <tim.c.chen@intel.com>,
	"Yujie Liu" <yujie.liu@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Chen Yu
	<yu.chen.surf@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Record the average duration of a task
Message-ID: <ZoVOL3mOVFAGEmZV@chenyu5-mobl2>
References: <cover.1719295669.git.yu.c.chen@intel.com>
 <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
 <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
 <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
 <db81ba7fba622e2a1b7186e66471cfb9ad8490fd.camel@gmx.de>
 <ZoLDxQlTR7fxoXWs@chenyu5-mobl2>
 <683663e3-cef0-bb45-e1c7-5bf1cf44209c@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <683663e3-cef0-bb45-e1c7-5bf1cf44209c@amd.com>
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA0PR11MB4670:EE_
X-MS-Office365-Filtering-Correlation-Id: 42cda6e8-44ef-411a-37c8-08dc9b61cbae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y0SqKuoj9KCk0PIK6JzGnq9mNmC2iVLw8cOEQRmmtaPYsJbXI6ce8y5Bqy78?=
 =?us-ascii?Q?KdflVU3iiNf1OC+AOrPM9nxB2xwXm4mkncPKbLmFvAi/rkHf39FLU9hQmZxb?=
 =?us-ascii?Q?IxcXj9VjdVea7s5TBQSigN9fIozHU77KelDs0W9gYB7vlHUpmO7H+756FUHy?=
 =?us-ascii?Q?G6XeXjVL0ZR/BJEpCmEFJ3SuR8FuxjxJPCpBZL4FYf2zudtDpu7dnWBC3PhL?=
 =?us-ascii?Q?PBLYXiIvWQZKgw+nLth1TmhX1C3R2j00HkfudXuwo4Bq57iKoqTVIJFwdSg5?=
 =?us-ascii?Q?jtanzcjrJSTZSI9r+yOB2pyVVnH0VAy6GZpCpHfLro5jtnEiquZOLdagr3u9?=
 =?us-ascii?Q?o6ow5L/pAkkV8eEQgkOTZbRoh2TOgOZtOwx+iek5NTaE6aeUkiTvWuqgLyIT?=
 =?us-ascii?Q?ogJeJeoil/KAFFn7n+KJmxHhH+gRiQdaLhWGxSC1nSnod4xyvGr4+Hknw+vn?=
 =?us-ascii?Q?/piF3RFbVVmxvD9OxJlhmjSf/ckMPPbVuXB1KSSDU/xGHhQkAvPNXMgpA5JD?=
 =?us-ascii?Q?/aL7UyckdynFf/6eDe+7zKpvb48n4VVIrO2g1TFi2rBY4Ff7ieGW1X420imd?=
 =?us-ascii?Q?k3kQQzRnQwpx4MTASYrOTtSNnb62QIstXAXeYF1brvmCLM2jbyhTiE7BsVQ2?=
 =?us-ascii?Q?aBn6qeVzCNL/UN0myaafPTL3arHnG14ag0+m+VpJUgbGtjo6MxG71EVx2tt4?=
 =?us-ascii?Q?+HHMTyK0ki/gljgyHul1znXkh+ZpDK6Z3iaH8YGxlEN7d4ouP7NsFAculwiJ?=
 =?us-ascii?Q?7CvTqitx29gnmJUQBfjin4jNgIDx8djlAmaLBcBMuUpVktGPfXc1xFuWRq6a?=
 =?us-ascii?Q?DANaIceEoUyxpCDGxVpX7XjrWqj3BUC3npNMji1uDJhAiQAVrpXmlV16YdpH?=
 =?us-ascii?Q?WrG4CyVn0Gc6HpXHW0Rv6JDH30+c0uajz2qFFuLKmMRoV/i3CaWvA/x2wdg/?=
 =?us-ascii?Q?3kr6Sh4eK+WIWg7NWqNjrVq3FuZkjiAdBb3f54eYva7JuoZ/1Sl4WuuJA6Yy?=
 =?us-ascii?Q?1Y7/b7Tucgy/g3RfWhZFh8BB6kKV5chzYzH4/IMnzfG8DEEsBAMaGrtF0320?=
 =?us-ascii?Q?HiYaM9Al+nteSuhC7IF3JBEi5XhsJhMoJvFDobDVIX/Sq1qSiIqdyTnQo+Pb?=
 =?us-ascii?Q?pnQw7IALQnlll1EfzNueMqO/FYqdqcbH1+b5umqjoMHbRgQY9RO3BBu+ibS5?=
 =?us-ascii?Q?O7EFQTuReaduy/nanXlGnaDj9JHCtl6i3bhjN8+7/oo/xoyjAMcNmKUlZOdh?=
 =?us-ascii?Q?2UPp0j/gTs9qNKwt/ATgMUnHJiIxqZPOTp9IvdygaCFFyDUwOYIk9CbNDWNV?=
 =?us-ascii?Q?OkH6ObXKVuJ32n3GyVFGF21zIsCtu0bJwIb/Hd706VZ+ug=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CnahBmppTVgwISB+TeYYM6OKfSjPV3ba4jMkmU+UDqvhTLKuyc4L+12OrqVs?=
 =?us-ascii?Q?i0tt62I9H7MnyENOp/LufKthbOVPnotSmFxA1ZZmGtG4zZg0LX9nwn8e/GBi?=
 =?us-ascii?Q?jqbqvD6mOGtLyzsE2p0GhkWyf3MSc95J4Epp/6DPE98zMRr8bNby8pcxQr4D?=
 =?us-ascii?Q?SZ0TgOwMckl/S95cLcETpmeNcz3uvIkd0zatGaB8/2EMavgXW5XnRGnYTE/N?=
 =?us-ascii?Q?hUN0Tmh443cgEwGL0WigE6tR5UXukUOGORPdMiKD+cYticqth41p0/2SOHQx?=
 =?us-ascii?Q?OXyvOGklaZ4cI9wi1E+GNLVazL722IEv8yMxNYiMHAa9oJNJxDtLJ4PbLgUR?=
 =?us-ascii?Q?sOcTxB1vL4VtDl0mc0LCqo9V96agc3UAKq442SW71XTLKDTw9sk3DChZ649w?=
 =?us-ascii?Q?OWdnrcgzJmHl5rR3YeNa6PmKCNkwLJEqrIL6zb26rH1s6da6w2/xKrbXjuKi?=
 =?us-ascii?Q?Kt3OAHLo2GlY3/wGDVFhekaXKQKDgyqgpEh+3/82SB6vYTxm1XgEyclMw/ed?=
 =?us-ascii?Q?gQIYE0PgKNkjAhmYhvSQkLynR10IStDszO/uzLI7pofXPhe4wwNgWNqogAtG?=
 =?us-ascii?Q?4zPwcwb1RpAWAJ14armZgIlhAAfpLbZD3edppdEmhZ60+SuETVRdK7F0ynuW?=
 =?us-ascii?Q?QIhCGyeJn4f2VrofiSrfUeTf08eZl/b7tmpUJzUvxVfqzCcN1nqX6A6VvFxu?=
 =?us-ascii?Q?g4LnYjXO1b1hoVqMoLEkkI6D2k+Y6amjXuL4B2NcdnCddfYyRwU7cElh9iIn?=
 =?us-ascii?Q?L8/v8JnRihswxc/N7mP0AAWHgdjuRI+ZLj0lg57TPfDqy8R1Pb3Ics/byE2F?=
 =?us-ascii?Q?4WK2JioKzE/OeI62GLIVVlg1YKVyo0Z1Gci7QRsCBrt+fIs/CT5iRoeFoKc9?=
 =?us-ascii?Q?YPy07gyzavrV+bqpF2ACPEKPpbATJwwCikreKf1bZxVxyA++a4IxVtULOa8L?=
 =?us-ascii?Q?W4s0YUfJp39/OQglYqKhfIO4ZE6UtsCeBnBW94sEoJRinjFSZVtyGVBZ12un?=
 =?us-ascii?Q?PGefOva77Zoxl3VlSPsI8L02WBDCxXl4vu3lU7YIrdW0Kbqt6JZx2WUtuaK5?=
 =?us-ascii?Q?RCNfihRoonmTxo8YgnTRdWJn+bMwxHbO9NErAyMzZCBwtTkoOD/2KluleIBN?=
 =?us-ascii?Q?L+UIzDOvzQZhU1wupeAAfAKPbFhiDmYQhnpYHFR+DUtzjR8i8TQhw7+lAvgw?=
 =?us-ascii?Q?1ofqs2b+0rI/qqgbSP0YZcG6UI+G8FGz4N89l3RMHARg4DimhWuhHs7OukZr?=
 =?us-ascii?Q?qgaGlbtwteucE1X/w6tMi8x2QYA7nTQEh2UK4xRpTNb1bg5CtruZXy4vOAZE?=
 =?us-ascii?Q?VnsOJdeKtfUXWOPWOxTEt3wzAATRFveo6zOPZbPWNc3QUZnOStoExw9W2hXe?=
 =?us-ascii?Q?GvGucMShp17Zb5EsEZ2gjwsS25bb0ttHStHLiRYCK/ZE/veooxtqI+F/cz1w?=
 =?us-ascii?Q?NaNQ8gXUo9gpYAZCP8eMdWf0hzkZbNnd7BXZDcS4S228jMHfgknpseVvPa5l?=
 =?us-ascii?Q?oSSMSkQbJBWy14zXQRxSDZ4JTYlWx5jl+yxD5CSz6ykUqMxRiAGRUebgNAXQ?=
 =?us-ascii?Q?gWFxfujWhTL8VEdxp+5VRkNLjrby2uRszPrbd0ws?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cda6e8-44ef-411a-37c8-08dc9b61cbae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 13:12:31.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DHyu3d+ijb5f0H4KC1Tr94hqHbKSNPdHMV64LhBBreuVgz8uTWV4Lr9OnM5d0rBGphWGr5pNioCPQzb8wmxyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4670
X-OriginatorOrg: intel.com

On 2024-07-03 at 14:04:47 +0530, Raghavendra K T wrote:
> 
> 
> On 7/1/2024 8:27 PM, Chen Yu wrote:
> > Hi Mike,
> > 
> > On 2024-07-01 at 08:57:25 +0200, Mike Galbraith wrote:
> > > On Sun, 2024-06-30 at 21:09 +0800, Chen Yu wrote:
> > > > Hi Mike,
> > > > 
> > > > Thanks for your time and giving the insights.
> > 
> > According to a test conducted last month on a system with 500+ CPUs where 4 CPUs
> > share the same L2 cache, around 20% improvement was noticed (though not as much
> > as on the non-L2 shared platform). I haven't delved into the details yet, but my
> > understanding is that L1 cache-to-cache latency within the L2 domain might also
> > matter on large servers (which I need to investigate further).
> > 
> > > 1:N or M:N
> > > tasks can approach its wakeup frequency range, and there's nothing you can do
> > > about the very same cache to cache latency you're trying to duck, it
> > > just is what it is, and is considered perfectly fine as it is.  That's
> > > a bit of a red flag, but worse is the lack of knowledge wrt what tasks
> > > are actually up to at any given time.  We rashly presume that tasks
> > > waking one another implies a 1:1 relationship, we routinely call them
> > > buddies and generally get away with it.. but during any overlap they
> > > can be doing anything including N way data share, and regardless of
> > > what that is and section size, needless stacking flushes concurrency,
> > > injecting service latency in its place, cost unknown.
> > > 
> > 
> > I believe this is a generic issue that the current scheduler faces, where
> > it attempts to predict the task's behavior based on its runtime. For instance,
> > task_hot() checks the task runtime to predict whether the task is cache-hot,
> > regardless of what the task does during its time slice. This is also the case
> > with WF_SYNC, which provides the scheduler with a hint to wake up on the current
> > CPU to potentially benefit from cache locality.
> > 
> > A thought occurred to me that one possible method to determine if the waker
> > and wakee share data could be to leverage the NUMA balance's numa_group data structure.
> > As numa balance periodically scans the task's VMA space and groups tasks accessing
> > the same physical page into one numa_group, we can infer that if the waker and wakee
> > are within the same numa_group, they are likely to share data, and it might be
> > appropriate to place the wakee on top of the waker.
> > 
> > CC Raghavendra here in case he has any insights.
> > 
> 
> Agree with your thought here,
>

Thanks for taking a look at this, Raghavendra.

> So I imagine two possible things to explore here.
> 
> 1) Use task1, task2 numa_group and check if they belong to same
> numa_group, also check if there is a possibility of M:N relationship
> by checking if t1/t2->numa_group->nr_tasks > 1 etc
>

I see, so do you mean if it is M:N rather than 1:1, we should avoid the
task been woken up on current CPU to avoid task stacking?
 
> 2) Given a VMA we can use vma_numab_state pids_active[] if task1, task2
> (threads) possibly interested in same VMA.
> Latter one looks to be practically difficult because we don't want to
> sweep across VMAs perhaps..
>

Yeah, we might have to scan the whole VMAs to gather the PID information which
might be a little costly(or maybe subset of the VMAs). And the pids_active[] is
for threads rather than process, stacking the threads seem to not be good
enough(per Mike's comments)

Anyway, I'm preparing for some full tests to see if there is overall benefit
from current version. Later let's investigate if numa balance information could
help here.

thanks,
Chenyu

