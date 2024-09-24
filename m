Return-Path: <linux-kernel+bounces-336677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C6F983F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD232822EB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28E114601C;
	Tue, 24 Sep 2024 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbsgLL/v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E080C1C
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163097; cv=fail; b=sP/uNWZI8HoksKBhGkC3i6J5jVuZ6pOX8GzpW0jCTUkgp6yToNPZZXY0V37gBmoy2vRJhGtaOFImsN0RXqSIPs6JVrBzB5lelTvFO85Iyo5EZy3B5dqHB+tdart2UatSe5UB1r2KjFXvUkRVG85OD07X3wnd3pyeRSSVN0cS3B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163097; c=relaxed/simple;
	bh=PKtCiuZSH0KZqMjr/lAjGQuAerYS721Vs8wdda4AP6c=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gnrRc/eV3dP6C6QH30AE4+9elUPH2EnywPGM250wZNp37l8Q85KvK3Ute/BSsXOgfi6SdaF0Laev6daR1+QENavmiw/RL07y1aiKiSi8DAE8BghfM4YKD9l/iAz0e8+Mn8l/letMaicJcI/cVp7Nwr8LgzyXj8XXx56cclBbqyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbsgLL/v; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727163095; x=1758699095;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=PKtCiuZSH0KZqMjr/lAjGQuAerYS721Vs8wdda4AP6c=;
  b=FbsgLL/v6EphR8LBoZ1VEjRlZq/SolYbP5LZpJ9hxpgLn3B07bJ0kC6U
   mUXfkxwaOJX6UDyKHysXZgj0m+BxM7ZhRQzZs6PdzEW8h1Isncl/VmN+g
   8xiQs1vSC8G6K6O3aw6xelOq4QKpRuXja90oXLAyBMAzmXBanKjhHUSE5
   bMItUQJ8IkOs42NaC2BTFUM+iq4RholOuXTNTcEsPV7wOqGU+Qq5eyCQ9
   IlWRL0LYL0RqyUyjAhsYN+nJ279VVo/XhNlyzzivXMtVK20IDad3MixEn
   FXsgOym2tF7w1dQpbBnd92cLG5SCIKXYx2bwmB68umjxntPu8PPblHxXc
   A==;
X-CSE-ConnectionGUID: oIw+atXsQpaSonnrbdNbRw==
X-CSE-MsgGUID: sK3jFazwSDeOGGp6m1cSPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="36809820"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="36809820"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 00:31:34 -0700
X-CSE-ConnectionGUID: FG7lGZyGRGyNuRO3kLtXFA==
X-CSE-MsgGUID: 2FpgZdjrQLO9Wz3nGb7ToQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="70925738"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 00:31:34 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 00:31:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 00:31:33 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 00:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJpBNpjWREEU+8AEGF880nucpqcy8RDZ+EmwqtLZrFSx1DoXtenXghqnuzSFsor04cqMTo98wQ6N6X5SPCGseiSiUiB4J7ALpG9lXDPzzzY85HLgYoIeUzQFjToIw+2GPGccQGRkTfBtEKgCSyTMbQ6KLztbfC1xGfyqZHHEJWReEhwBpSiIPO7Sf4caDd0RchnDE1HpeB3Ml8WqU4LsTM1lsAIAbRIqc62k5yWMR1naLH0gCgPD7q3Wqu6VvSMZsum+qBO7/3xLyd6P/IOOuy755YLrpjHMSfgKHc/tNVm7Y7wvqouUHgnDzi9ww/+ywGH/6deE9QxP1m9J8/LvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gYvB5PSbLnqr1GqaG4II0ESrAw/chleaEw1/k+xJuw=;
 b=SqM26neKGqs5gEond369fuEEX56ix1IHSid1neKnLXETmK+rrdvj63P5wskSfA5FWGNUoqzysR2Pz+rEjQ1NeuncToRiKJ3WI3c+gL+vOZzMjB6ybaW+NIHxxKdpuyZImhLztZlW303hFQTBREcq/Pwp0vsRkGJLCXCVw7siwFcBX7G19ytS8gHNT5cZcdLRfeXFJJsge/FMm6or6gSZ45t22Lo98VBNvaNSK0V6g7p1m7nEGOQjtSb5iaqyf5p8iOiHDJZq4o59Lf1OoCcCWxJ4x1miQih7YUY3CKJmvK17quWTVSnckQOXcq+SjRcTGc5Cy+qv0t+wewmMPxBp4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 07:31:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 07:31:30 +0000
Date: Tue, 24 Sep 2024 15:31:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Aristeu Rozanski <aris@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song
	<muchun.song@linux.dev>, Aristeu Rozanski <aris@ruivo.org>, David Hildenbrand
	<david@redhat.com>, Vishal Moola <vishal.moola@gmail.com>,
	<linux-mm@kvack.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [hugetlb]  003af997c8:  vm-scalability.throughput
 -44.1% regression
Message-ID: <202409241539.4b10c59b-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: f86bfa5e-75c3-4220-3a91-08dcdc6ae804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?4KGFSf66Q+KYJVNw72W2uJcV11Jo3GBRnk/q+5gArkRhSeff//BDxnSEaL?=
 =?iso-8859-1?Q?j81VUGc1eXrkr7XN4I5raFuNBuNIPWm10I9Y7vixR6v3lNGcouBhdAY+Kg?=
 =?iso-8859-1?Q?B0GyokONJjLZ1UsNXet2aEdRScTlX0TpevecL1jjx+vZ6orEDZ2ae4yhha?=
 =?iso-8859-1?Q?MBRR8qLC/sr1c2Ke8JyuZIVfO2rmUnPO8h8dIAuAwd5Js8Degk34bRXvbo?=
 =?iso-8859-1?Q?X01eS4aNzvQXffmsD5/mhyjFXkb9vQWdkTwzZMjw36YaEHlVF4/LEFiWNP?=
 =?iso-8859-1?Q?XP7FSOVBMtcRqHJorIGgw8OyIhl4biGJ4s2uZRwotWgOpEVztpb0VP7KIb?=
 =?iso-8859-1?Q?iHUR4CrzBAVyZHLgqVUvuJpbdM2kHb6KoQVf3GpGcKmuj5EWiM/mhqRsus?=
 =?iso-8859-1?Q?m4zGpe1shlaEnH7q+upxBhYB6ua2xxCvZAanrTnunVS0DwVrNEUTjidkFI?=
 =?iso-8859-1?Q?E2Bcv4fwhSQvZEytNWUvhzhquyzEX8Xg3Bowkow6N02uekl2pHRIeEpSxr?=
 =?iso-8859-1?Q?lySiKJISUG0JJt4ZKNI3AWBPI/XJO4xKafJhr7fdhVzwzc2MccOZWCegvW?=
 =?iso-8859-1?Q?VmaaPMEXEQwgO+mDPKbG2qmWxrB9HPFGYKKvFIzLI2vcCJ74tpjUPTSrBg?=
 =?iso-8859-1?Q?ge8x/8fgiboonmWZwwY+CA3/Uy4hlvxinof0me44fE5sZwH75HsO+avPyR?=
 =?iso-8859-1?Q?17VUwXojkwEvv97zatuI8VhGBYYOg0ROn6aGy21SNzOES+2JdJGcV9KD9g?=
 =?iso-8859-1?Q?/Qu/XqIiLU2wwZQ842dioM/MTjOoC0SV7iI1/i7YDQwPkiofiUONi1lIag?=
 =?iso-8859-1?Q?1d9jTtI5Fm+bq/RzkMW8WlCkllcjnF1f8ek/SvUYBroXL0mZ5SEK3h0lR9?=
 =?iso-8859-1?Q?EjklVLJKxniiS6l8phkFwIy+w5u1U2ICBuhkzNpPY1HrapPmFeRrCKsOzF?=
 =?iso-8859-1?Q?+LjEPqWuajBe9C4fWx3yDjUvoch4y4uu3YhOxNFyB0KNuT9VDhlOAkx0x1?=
 =?iso-8859-1?Q?P48nbw71Pqq/eonsc2FEv4/3yCyeMpakUGCJARXkoixo/77qs0Vb2nVAKR?=
 =?iso-8859-1?Q?VsiMI3tTQR/1O3KDu4KpIgqwG4nJnRSjhQnNZv734+SZ1VXqelZosAfGaa?=
 =?iso-8859-1?Q?64GJ5EpGStzrVpYSsqEjoSLGGaaz7tdOMI4XbtLXws3bIDlkIoau/48kke?=
 =?iso-8859-1?Q?fOMkb2Z8CjGGqMJBMiFC2Rj9O8KdrzHqxe2UvTSYx0gqLMIql+RuHf4YFr?=
 =?iso-8859-1?Q?j58wkABwsPTWjZjF/0A3z1DXfwG8H8NM/aDd4zRwqn3gALoCIP7JHue50+?=
 =?iso-8859-1?Q?TQOPue/7YQR49bSX651frC9ZWWJD8NvKXmJhacbRxE3qiaFdmNUL7A8lgm?=
 =?iso-8859-1?Q?cUlBnx0P3NxKTASrLjZN/Ezh7b//8A7hLb871/A/7V6BvCmLbxg8A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?shofdDBc/ByWkQ4S9R4wLScGlJw0TAxzUA/wbFNk7Dzc5sSjikK6m5FTEy?=
 =?iso-8859-1?Q?zHXPsFBGly799XzHog9c1ibaWnmSxDm51fUWtvDoE6JipizWkMuIWZXPN1?=
 =?iso-8859-1?Q?96s2fof68dUzNIHIvLc8EVfceBLHlbXI+N0DJFkwDexHhwv5PWjHJEj+5T?=
 =?iso-8859-1?Q?rICDHm3liz8b9YaD6EMggZ4TzK3RCRHgzh94QnCS1F87LYNRcagbI1R+ap?=
 =?iso-8859-1?Q?iDsx0rs8ngF0ev1PfDl4Cn+VKWuCRvc3DgmzCiQn201CrMfRqSV/9HMu2c?=
 =?iso-8859-1?Q?3QfTuUVUbFUpTg5YtKzZoQjHokMcoEtkr11ad5X6Aqva/jgLsoNplv7zTH?=
 =?iso-8859-1?Q?zBT+KgaRe+/L3uFAWXmZK8wx8IPQwOIw8Up5xjY52YVNesbLhhLTvKaB4A?=
 =?iso-8859-1?Q?McnhUkE7KPguIZSThbPKAH3uARruZLy21wv0dnlFNgadUcX/qdx9Vh2TrA?=
 =?iso-8859-1?Q?s/aViKPxnLzz9QAFz04c2iNhMdYDFGgRd5eE5GHYcWcr0QNLa3rZl6OVLh?=
 =?iso-8859-1?Q?DUNe2YiwKfUPOtSdDJanuVza/wC2mh6XCFzSs5CjP73EhhkRADpeFrmkx2?=
 =?iso-8859-1?Q?AvzsNLbOoxf8uMyXINBhw9vmWV11VPdKiuHAPa4vJDjf+ZWcFfuf5lGNSt?=
 =?iso-8859-1?Q?sLcYrFfKFnAM8KZeI5uuSe06glzuh+JxjyI86cGhdpTaUz0s+nLfodAVYr?=
 =?iso-8859-1?Q?+h01GFWG/aW3MDxahkE/gmLFARqNabBSIK2hKJG9P8ovfAzWE6n3mKzf2w?=
 =?iso-8859-1?Q?NIaOqtD+ARpPOz3syrhU/DoWiD7xl4i4ALNL3HgKntlgUqSH/07g+HzZG7?=
 =?iso-8859-1?Q?ToddDAtCtlyzuCPI2G/CFkn6IVNhLZqW36Wd8gPQuibr5iPBcROWBNCSgr?=
 =?iso-8859-1?Q?99YSjM1zpeX8ldHlp2NU/GFP4NsFJsdeU3uKt5r/RcY1lkmVxzMJu+IWPC?=
 =?iso-8859-1?Q?OGIYBFwaZWv9HXkJiJ8L2kj9xxAsuwND7wonN9ueXC6HhPakf46YxUwh8f?=
 =?iso-8859-1?Q?iyhBKpKNde6/S/kEUcSgvPnPhNntDIgOz+HYFvJ1Jaigy6GU5HdCk+QSDn?=
 =?iso-8859-1?Q?YjFP/Bl1O6k//ynNJkN8KQ97C4DjsnW0akC2fqeV57A6KjJMSnW2CIHJE3?=
 =?iso-8859-1?Q?9Jlk03WGW/vmjSlaHHZJMfyF0LLa2NIX1EoQAkJhM1fxLoZeU28sCO2izr?=
 =?iso-8859-1?Q?DhSZk/i5KotUYEDSk8a0q1AGH6myHD6RhvFozfqJFBuv+dtMOiP5ltwNuM?=
 =?iso-8859-1?Q?EPca1wEIJYAJGaZHU5R7QUHy0bT3kjT7SNQ9aZrlOI1iRZdfa7CSDJMdPA?=
 =?iso-8859-1?Q?+BTaX4VFh/EMelTeuc2MvZRXhSfQxcRf0my7DKqEuvqSL5sp86alZY77ta?=
 =?iso-8859-1?Q?MQR6FD09zaUQrNO9KulMuzBzMFv7iqnTTU560ileD5pXSXgxCCuEgmluAi?=
 =?iso-8859-1?Q?xDy6r4GXx3+dn8LMN7e1oMyss+KQGBwDXlrAGTetiBNz2kbLq+VNLWJZr7?=
 =?iso-8859-1?Q?3n4UF6HmnkyCXsP2FjdBkwu2r6USl/lETP0fqiq+XDVf7MTLUqYE0lcVAi?=
 =?iso-8859-1?Q?vavBvhzm4GBiD09qS4D3fISj5bx/Xl3SPOCEA2wUNInJA7cEIJbwOtT9yo?=
 =?iso-8859-1?Q?jsj2Ftxo+l08UfkyHs6C8uhedhfAmQO+qZ3ZcPfEudq9GncPcAmld5hw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f86bfa5e-75c3-4220-3a91-08dcdc6ae804
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 07:31:30.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Kll7b/2lnt4ZPHfT+f46ExeJxeW084qiREz4S2a9PkK74rqqVsEuJCNsnjFuKvyQUJ/U//Bl9kKtugk3E9B2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6469
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -44.1% regression of vm-scalability.throughput on:


commit: 003af997c8a945493859dd1a2d015cc9387ff27a ("hugetlb: force allocating surplus hugepages on mempolicy allowed nodes")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: vm-scalability
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	size: 512G
	test: anon-w-rand-hugetlb
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409241539.4b10c59b-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240924/202409241539.4b10c59b-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/300s/512G/lkp-icl-2sp2/anon-w-rand-hugetlb/vm-scalability

commit: 
  64548bc534 ("mm/damon/paddr: initialize nr_succeeded in __damon_pa_migrate_folio_list()")
  003af997c8 ("hugetlb: force allocating surplus hugepages on mempolicy allowed nodes")

64548bc5347bd051 003af997c8a945493859dd1a2d0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.539e+09 ± 10%     -48.1%  1.836e+09 ±  9%  cpuidle..time
    244.26 ±  6%     +39.2%     340.02        uptime.boot
      9914 ±  6%     -21.2%       7808        uptime.idle
     14.40 ±  8%      -9.6        4.81 ±  9%  mpstat.cpu.all.idle%
      0.02 ±  2%      +0.0        0.03        mpstat.cpu.all.soft%
      6.61 ±  5%      +3.3        9.87        mpstat.cpu.all.sys%
      4.00          +129.2%       9.17 ± 30%  mpstat.max_utilization.seconds
      3.80 ± 80%   +2470.2%      97.67 ±  7%  perf-c2c.DRAM.local
     27.60 ± 31%   +4957.4%       1395        perf-c2c.DRAM.remote
     22.00 ± 18%   +3278.8%     743.33 ±  4%  perf-c2c.HITM.local
      9.20 ± 40%   +6387.3%     596.83 ±  3%  perf-c2c.HITM.remote
     64.40 ±200%  +63684.7%      41077 ± 20%  numa-numastat.node0.numa_foreign
    662185 ±  6%     +50.0%     993375 ±  5%  numa-numastat.node0.numa_hit
     38632 ± 70%    +825.8%     357657 ±  9%  numa-numastat.node0.other_node
    723573 ±  7%     -19.4%     583311 ±  8%  numa-numastat.node1.numa_hit
     64.40 ±200%  +64112.2%      41352 ± 20%  numa-numastat.node1.numa_miss
     15.17 ±  7%     -63.9%       5.48 ±  8%  vmstat.cpu.id
     78.08            +8.3%      84.58        vmstat.cpu.us
    110.68           +11.2%     123.04        vmstat.procs.r
      2778 ±  2%     -11.2%       2465 ±  3%  vmstat.system.cs
    142558 ±  2%     +11.8%     159336        vmstat.system.in
      0.00 ±  6%     -28.7%       0.00 ±  3%  vm-scalability.free_time
     57226 ±  5%     -41.4%      33548        vm-scalability.median
     15.32 ± 36%     -14.7        0.58 ± 20%  vm-scalability.median_stddev%
     15.16 ± 43%     -14.7        0.42 ± 48%  vm-scalability.stddev%
   7692177 ±  5%     -44.1%    4299393        vm-scalability.throughput
    189.12 ±  7%     +52.1%     287.59        vm-scalability.time.elapsed_time
    189.12 ±  7%     +52.1%     287.59        vm-scalability.time.elapsed_time.max
    142450 ±  7%     +63.3%     232670 ±  5%  vm-scalability.time.involuntary_context_switches
     10933           +11.2%      12161        vm-scalability.time.percent_of_cpu_this_job_got
      1574 ± 12%    +128.3%       3594        vm-scalability.time.system_time
     19105 ±  7%     +64.3%      31384        vm-scalability.time.user_time
      4986 ±  5%     +41.0%       7031        vm-scalability.time.voluntary_context_switches
    107334 ± 18%    +140.2%     257850 ±  2%  meminfo.Active
    107199 ± 18%    +140.4%     257707 ±  2%  meminfo.Active(anon)
   1060745 ±  2%     +13.3%    1202096        meminfo.Committed_AS
      1593 ± 17%     +88.9%       3009 ±  4%  meminfo.HugePages_Free
      1593 ± 17%     +88.9%       3010 ±  3%  meminfo.HugePages_Rsvd
     54941           +11.5%      61250        meminfo.HugePages_Surp
     54941           +11.5%      61250        meminfo.HugePages_Total
 1.125e+08           +11.5%  1.254e+08        meminfo.Hugetlb
      1203           -50.3%     597.80 ± 82%  meminfo.Inactive(file)
  1.44e+08            -8.9%  1.313e+08        meminfo.MemAvailable
 1.451e+08            -8.8%  1.324e+08        meminfo.MemFree
 1.186e+08           +10.7%  1.314e+08        meminfo.Memused
    255862 ± 10%     +58.6%     405684        meminfo.Shmem
  18068249 ± 12%     -90.6%    1706023 ±  6%  numa-vmstat.node0.nr_free_pages
    179.13 ± 56%     -95.6%       7.82 ±105%  numa-vmstat.node0.nr_inactive_file
      1479 ± 10%     -37.5%     924.24 ± 20%  numa-vmstat.node0.nr_page_table_pages
    179.13 ± 56%     -95.6%       7.82 ±105%  numa-vmstat.node0.nr_zone_inactive_file
     64.40 ±200%  +63684.7%      41077 ± 20%  numa-vmstat.node0.numa_foreign
    662831 ±  6%     +49.8%     993007 ±  5%  numa-vmstat.node0.numa_hit
     38632 ± 70%    +825.8%     357657 ±  9%  numa-vmstat.node0.numa_other
     25754 ± 19%    +104.8%      52745 ± 20%  numa-vmstat.node1.nr_active_anon
  18214205 ± 13%     +72.3%   31383668        numa-vmstat.node1.nr_free_pages
      1266 ± 13%     +48.7%       1883 ± 10%  numa-vmstat.node1.nr_page_table_pages
     43011 ± 44%     +80.8%      77760 ± 25%  numa-vmstat.node1.nr_shmem
     25754 ± 19%    +104.8%      52745 ± 20%  numa-vmstat.node1.nr_zone_active_anon
    722032 ±  7%     -19.3%     582363 ±  8%  numa-vmstat.node1.numa_hit
     64.40 ±200%  +64112.2%      41352 ± 20%  numa-vmstat.node1.numa_miss
    763.05 ± 34%    +287.1%       2954 ±  6%  numa-meminfo.node0.HugePages_Free
     27885 ± 15%    +113.2%      59456        numa-meminfo.node0.HugePages_Surp
     27885 ± 15%    +113.2%      59456        numa-meminfo.node0.HugePages_Total
    716.02 ± 56%     -95.6%      31.28 ±105%  numa-meminfo.node0.Inactive(file)
  72184008 ± 12%     -90.4%    6907510 ± 11%  numa-meminfo.node0.MemFree
  59500944 ± 15%    +109.7%  1.248e+08        numa-meminfo.node0.MemUsed
      5935 ± 10%     -37.7%       3696 ± 19%  numa-meminfo.node0.PageTables
    102909 ± 19%    +104.9%     210848 ± 21%  numa-meminfo.node1.Active
    102855 ± 19%    +104.9%     210789 ± 21%  numa-meminfo.node1.Active(anon)
    756.97 ± 40%     -99.9%       0.99 ±223%  numa-meminfo.node1.HugePages_Free
     27143 ± 16%     -93.5%       1757 ± 33%  numa-meminfo.node1.HugePages_Surp
     27143 ± 16%     -93.5%       1757 ± 33%  numa-meminfo.node1.HugePages_Total
  72746397 ± 13%     +72.6%  1.255e+08        numa-meminfo.node1.MemFree
  59311794 ± 16%     -89.0%    6524390        numa-meminfo.node1.MemUsed
      5070 ± 13%     +48.3%       7518 ± 10%  numa-meminfo.node1.PageTables
    172326 ± 44%     +80.4%     310895 ± 25%  numa-meminfo.node1.Shmem
      0.01 ±122%    +311.8%       0.04 ± 79%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.01 ± 84%    +998.4%       0.16 ±117%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.01 ± 98%    +669.5%       0.07 ± 51%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.13 ± 86%    +329.8%       0.54 ± 54%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ± 50%    +248.7%       0.05 ±  7%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±200%    +1e+05%       1.04 ± 35%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.03 ± 18%    +531.6%       0.18 ±151%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.41 ± 76%    +103.8%       0.84 ± 18%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.02 ± 19%    +639.7%       0.14 ± 61%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 36%    +216.9%       0.04 ± 19%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 81%   +2492.3%       0.44 ±133%  perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.02 ± 87%   +2603.1%       0.52 ±106%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 50%    +509.5%       0.17 ± 14%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±200%  +3.7e+05%       3.66 ± 14%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.04 ± 45%   +4905.2%       1.94 ± 72%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.20 ± 68%    +215.9%       0.63 ± 47%  perf-sched.total_sch_delay.average.ms
     60.34 ±136%   +1104.4%     726.77 ± 77%  perf-sched.total_sch_delay.max.ms
    306.32 ± 61%     +57.1%     481.25 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      2.24 ± 49%     +79.0%       4.01 ± 20%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     11.87 ± 29%     -37.8%       7.38 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    434.40 ± 29%     +51.8%     659.33 ±  8%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      6.37 ± 37%     +62.1%      10.33 ± 22%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.01 ± 84%    +998.4%       0.16 ±117%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      1.97 ± 47%     +84.7%       3.64 ± 19%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     11.80 ± 29%     -38.2%       7.29 ±  8%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.02 ± 81%   +2492.3%       0.44 ±133%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      3.28 ± 30%    +147.1%       8.10 ± 45%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     17.20 ±  2%      -6.0%      16.17        perf-stat.i.MPKI
 1.569e+10 ±  7%     -33.7%  1.041e+10        perf-stat.i.branch-instructions
  10996521 ±  6%     -32.9%    7383042 ±  2%  perf-stat.i.branch-misses
 8.129e+08 ±  7%     -34.7%  5.307e+08        perf-stat.i.cache-misses
 8.307e+08 ±  7%     -34.6%  5.436e+08        perf-stat.i.cache-references
      2701           -11.3%       2396 ±  3%  perf-stat.i.context-switches
      5.62 ± 10%     +70.2%       9.57        perf-stat.i.cpi
 2.884e+11           +10.8%  3.195e+11        perf-stat.i.cpu-cycles
    374.61 ± 10%     +60.3%     600.58        perf-stat.i.cycles-between-cache-misses
 6.744e+10 ±  7%     -33.7%  4.472e+10        perf-stat.i.instructions
      0.25 ±  7%     -40.2%       0.15 ±  2%  perf-stat.i.ipc
      0.20 ± 57%     -72.5%       0.05 ± 97%  perf-stat.i.major-faults
      6025 ±  4%     -20.3%       4801        perf-stat.i.minor-faults
      6025 ±  4%     -20.3%       4801        perf-stat.i.page-faults
     12.13            -1.2%      11.98        perf-stat.overall.MPKI
      4.32 ±  7%     +66.7%       7.19        perf-stat.overall.cpi
    355.77 ±  8%     +68.7%     600.33        perf-stat.overall.cycles-between-cache-misses
      0.23 ±  7%     -40.3%       0.14        perf-stat.overall.ipc
     10566            +1.3%      10705        perf-stat.overall.path-length
 1.543e+10 ±  7%     -33.6%  1.024e+10        perf-stat.ps.branch-instructions
  10668497 ±  6%     -32.6%    7189782 ±  2%  perf-stat.ps.branch-misses
 8.043e+08 ±  7%     -34.5%  5.269e+08        perf-stat.ps.cache-misses
 8.224e+08 ±  7%     -34.3%  5.402e+08        perf-stat.ps.cache-references
      2686           -10.4%       2406 ±  3%  perf-stat.ps.context-switches
 2.845e+11           +11.2%  3.163e+11        perf-stat.ps.cpu-cycles
 6.629e+10 ±  7%     -33.7%  4.397e+10        perf-stat.ps.instructions
      0.20 ± 56%     -71.7%       0.06 ± 96%  perf-stat.ps.major-faults
      6139 ±  4%     -19.7%       4928        perf-stat.ps.minor-faults
      6139 ±  4%     -19.7%       4928        perf-stat.ps.page-faults
 1.254e+13            +1.3%  1.271e+13        perf-stat.total.instructions
  12803673 ±122%   +2705.8%  3.592e+08 ± 20%  proc-vmstat.compact_daemon_free_scanned
    188006 ±147%   +2684.0%    5234004 ± 55%  proc-vmstat.compact_daemon_migrate_scanned
  12803673 ±122%   +2705.8%  3.592e+08 ± 20%  proc-vmstat.compact_free_scanned
    188006 ±147%   +2684.0%    5234004 ± 55%  proc-vmstat.compact_migrate_scanned
     26765 ± 18%    +140.9%      64490 ±  2%  proc-vmstat.nr_active_anon
   3601411            -9.1%    3272731        proc-vmstat.nr_dirty_background_threshold
   7211629            -9.1%    6553464        proc-vmstat.nr_dirty_threshold
    837964            +4.4%     875032        proc-vmstat.nr_file_pages
  36351167            -9.1%   33059841        proc-vmstat.nr_free_pages
    300.91           -50.4%     149.15 ± 82%  proc-vmstat.nr_inactive_file
      2743            +2.3%       2805        proc-vmstat.nr_page_table_pages
     63967 ±  9%     +58.7%     101505        proc-vmstat.nr_shmem
     28763            -6.7%      26832 ±  2%  proc-vmstat.nr_slab_reclaimable
     26765 ± 18%    +140.9%      64490 ±  2%  proc-vmstat.nr_zone_active_anon
    300.91           -50.4%     149.15 ± 82%  proc-vmstat.nr_zone_inactive_file
    506.80 ±170%   +8005.2%      41077 ± 20%  proc-vmstat.numa_foreign
     19032 ± 45%     +77.0%      33682 ± 16%  proc-vmstat.numa_hint_faults
   1393599 ±  2%     +13.3%    1579111        proc-vmstat.numa_hit
    506.80 ±170%   +8059.6%      41352 ± 20%  proc-vmstat.numa_miss
    133133          +232.2%     442280 ±  8%  proc-vmstat.numa_other
      8765 ± 63%    +271.3%      32545 ± 17%  proc-vmstat.numa_pages_migrated
    124049 ± 35%     +69.0%     209637 ± 14%  proc-vmstat.numa_pte_updates
     69397 ± 14%     +41.1%      97902        proc-vmstat.pgactivate
    512.00 ±200%   +3700.7%      19459 ±  3%  proc-vmstat.pgalloc_dma
     80179 ±200%   +3713.5%    3057605        proc-vmstat.pgalloc_dma32
 2.651e+08            -1.0%  2.624e+08        proc-vmstat.pgalloc_normal
   1229462 ±  2%     +21.5%    1494275        proc-vmstat.pgfault
    154.00 ±199%   +2344.7%       3764 ± 76%  proc-vmstat.pgmigrate_fail
     20244 ± 71%    +221.2%      65033 ± 19%  proc-vmstat.pgmigrate_success
     33783 ±  5%     +29.3%      43678 ±  2%  proc-vmstat.pgreuse
   8518493 ± 21%     +89.5%   16143327        sched_debug.cfs_rq:/.avg_vruntime.avg
   9012023 ± 20%     +83.6%   16543009        sched_debug.cfs_rq:/.avg_vruntime.max
   7203984 ± 20%     +98.9%   14327528 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.65 ± 12%     +27.0%       0.83        sched_debug.cfs_rq:/.h_nr_running.avg
      0.30 ± 13%    +133.3%       0.70 ± 14%  sched_debug.cfs_rq:/.h_nr_running.min
      0.26 ± 17%     -35.6%       0.17 ±  6%  sched_debug.cfs_rq:/.h_nr_running.stddev
      2410 ± 14%    +133.2%       5621 ± 14%  sched_debug.cfs_rq:/.load.min
      2.27 ± 11%    +122.1%       5.03 ± 11%  sched_debug.cfs_rq:/.load_avg.min
   8518493 ± 21%     +89.5%   16143327        sched_debug.cfs_rq:/.min_vruntime.avg
   9012023 ± 20%     +83.6%   16543009        sched_debug.cfs_rq:/.min_vruntime.max
   7203984 ± 20%     +98.9%   14327528 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
      0.65 ± 12%     +26.5%       0.82        sched_debug.cfs_rq:/.nr_running.avg
      0.30 ± 13%    +133.3%       0.70 ± 14%  sched_debug.cfs_rq:/.nr_running.min
      0.21 ± 27%     -61.7%       0.08 ± 21%  sched_debug.cfs_rq:/.nr_running.stddev
    702.48 ± 11%     +24.0%     871.29        sched_debug.cfs_rq:/.runnable_avg.avg
    282.30 ± 22%    +136.3%     667.03 ± 20%  sched_debug.cfs_rq:/.runnable_avg.min
    240.81 ± 22%     -47.7%     126.02 ± 15%  sched_debug.cfs_rq:/.runnable_avg.stddev
    696.46 ± 10%     +23.9%     863.11        sched_debug.cfs_rq:/.util_avg.avg
    227.72 ± 38%    +140.3%     547.27 ± 28%  sched_debug.cfs_rq:/.util_avg.min
    219.06 ± 27%     -53.9%     101.05 ± 19%  sched_debug.cfs_rq:/.util_avg.stddev
    503.97 ± 18%     +53.7%     774.51 ±  3%  sched_debug.cfs_rq:/.util_est.avg
      1047 ± 14%     +28.5%       1346 ± 14%  sched_debug.cfs_rq:/.util_est.max
    279.14 ± 11%     -37.2%     175.37 ± 16%  sched_debug.cfs_rq:/.util_est.stddev
   1111522 ±  7%     +15.5%    1283701 ±  5%  sched_debug.cpu.avg_idle.max
    351610 ± 23%     +48.8%     523030 ±  6%  sched_debug.cpu.avg_idle.min
    126692 ± 11%     +35.4%     171555        sched_debug.cpu.clock.avg
    126710 ± 11%     +35.4%     171591        sched_debug.cpu.clock.max
    126672 ± 11%     +35.4%     171515        sched_debug.cpu.clock.min
    126285 ± 11%     +35.4%     171003        sched_debug.cpu.clock_task.avg
    126456 ± 11%     +35.4%     171228        sched_debug.cpu.clock_task.max
    117086 ± 12%     +38.3%     161970        sched_debug.cpu.clock_task.min
      4361 ± 16%     +44.0%       6281        sched_debug.cpu.curr->pid.avg
      6032 ±  7%     +20.8%       7284        sched_debug.cpu.curr->pid.max
      2157 ± 26%    +118.4%       4711 ± 24%  sched_debug.cpu.curr->pid.min
    992.57 ± 24%     -58.1%     415.92 ± 40%  sched_debug.cpu.curr->pid.stddev
      0.64 ± 12%     +29.0%       0.83        sched_debug.cpu.nr_running.avg
      0.30 ± 13%    +133.3%       0.70 ± 14%  sched_debug.cpu.nr_running.min
      0.27 ± 15%     -37.9%       0.17 ±  8%  sched_debug.cpu.nr_running.stddev
      2936 ±  9%     +22.6%       3599 ±  3%  sched_debug.cpu.nr_switches.avg
    701.50 ± 18%     +43.1%       1003 ±  3%  sched_debug.cpu.nr_switches.min
    126673 ± 11%     +35.4%     171514        sched_debug.cpu_clk
    125408 ± 12%     +35.8%     170282        sched_debug.ktime
    127719 ± 11%     +35.0%     172457        sched_debug.sched_clk
     16.02 ± 41%     -14.3        1.75        perf-profile.calltrace.cycles-pp.do_access
     13.69 ± 51%     -13.7        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
     13.66 ± 51%     -13.7        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     13.66 ± 51%     -13.7        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     13.65 ± 51%     -13.6        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     13.63 ± 51%     -13.6        0.00        perf-profile.calltrace.cycles-pp.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     12.86 ± 51%     -12.9        0.00        perf-profile.calltrace.cycles-pp.hugetlb_no_page.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     12.60 ± 51%     -12.6        0.00        perf-profile.calltrace.cycles-pp.folio_zero_user.hugetlb_no_page.hugetlb_fault.handle_mm_fault.do_user_addr_fault
     11.75 ± 51%     -11.7        0.00        perf-profile.calltrace.cycles-pp.clear_page_erms.folio_zero_user.hugetlb_no_page.hugetlb_fault.handle_mm_fault
      2.29 ±  7%      -0.7        1.55        perf-profile.calltrace.cycles-pp.nrand48_r
      1.15 ± 29%      +1.9        3.05 ±  7%  perf-profile.calltrace.cycles-pp.lrand48_r
     44.16 ±  7%      +7.7       51.86 ±  7%  perf-profile.calltrace.cycles-pp.lrand48_r@plt
     57.17 ±  9%     +11.6       68.72 ±  3%  perf-profile.calltrace.cycles-pp.do_rw_once
     16.34 ± 41%     -14.4        1.95        perf-profile.children.cycles-pp.do_access
     13.70 ± 51%     -13.7        0.00        perf-profile.children.cycles-pp.asm_exc_page_fault
     13.68 ± 51%     -13.7        0.00        perf-profile.children.cycles-pp.exc_page_fault
     13.68 ± 51%     -13.7        0.00        perf-profile.children.cycles-pp.do_user_addr_fault
     13.66 ± 51%     -13.7        0.00        perf-profile.children.cycles-pp.handle_mm_fault
     13.63 ± 51%     -13.6        0.00        perf-profile.children.cycles-pp.hugetlb_fault
     12.86 ± 51%     -12.9        0.00        perf-profile.children.cycles-pp.hugetlb_no_page
     12.68 ± 51%     -12.7        0.00        perf-profile.children.cycles-pp.folio_zero_user
     12.00 ± 51%     -12.0        0.00        perf-profile.children.cycles-pp.clear_page_erms
      3.04 ±  7%      -1.0        2.07        perf-profile.children.cycles-pp.nrand48_r
      1.03 ± 49%      -1.0        0.06 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.02 ± 49%      -1.0        0.06 ±  6%  perf-profile.children.cycles-pp.do_syscall_64
      0.64 ± 13%      -0.2        0.39 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.45 ±  9%      -0.2        0.28 ±  8%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.42 ±  9%      -0.2        0.26 ±  8%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.41 ± 10%      -0.2        0.25 ±  8%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.30 ± 10%      -0.1        0.18 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.29 ± 10%      -0.1        0.17 ±  7%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.26 ± 10%      -0.1        0.15 ±  6%  perf-profile.children.cycles-pp.update_process_times
      0.14 ±  9%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.sched_tick
      0.08 ± 17%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.ktime_get
      0.08 ± 15%      -0.0        0.06 ± 16%  perf-profile.children.cycles-pp.clockevents_program_event
      0.94 ±  9%      +0.8        1.74 ±  6%  perf-profile.children.cycles-pp.lrand48_r
     22.76 ±  7%      +4.7       27.50 ±  7%  perf-profile.children.cycles-pp.lrand48_r@plt
     79.53 ±  8%     +15.3       94.84        perf-profile.children.cycles-pp.do_rw_once
     11.89 ± 51%     -11.9        0.00        perf-profile.self.cycles-pp.clear_page_erms
      2.73 ±  7%      -0.9        1.87        perf-profile.self.cycles-pp.nrand48_r
      2.33 ± 12%      -0.6        1.75        perf-profile.self.cycles-pp.do_access
      0.33 ±  8%      -0.1        0.23        perf-profile.self.cycles-pp.lrand48_r
      0.62 ± 12%      +0.9        1.52 ±  7%  perf-profile.self.cycles-pp.lrand48_r@plt
     78.68 ±  8%     +15.5       94.20        perf-profile.self.cycles-pp.do_rw_once




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


