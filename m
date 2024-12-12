Return-Path: <linux-kernel+bounces-443427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798D69EF073
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F14189B1E1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B332343A5;
	Thu, 12 Dec 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ihJIcx4+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0441F2336A9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019596; cv=fail; b=Uc2VxGryZdmrTxrrOXqCuvPtGYIRYGOCJ1aiRa/PROOk7/KuHhdUhUfcUCtl3eZhpxrm6GR94mMZOde8O3VUiomOyDodg8DIV5L0fcf0MwHaEMKf6Ll0TIJo4Lp0tTuCYsZZ8aKces0Q38wbig0aoKtg7oUwTcCu6Cq9ADg1ba4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019596; c=relaxed/simple;
	bh=Y1UrRZ03s2v8IR0sCqdjJHr0urH93tNZ0rPRwlN4FG8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pwOfewG00jEIxccZoD2KChXRoVNYfKhch8cQXrvZyTB4zioa1XGI5BnAmBZE0Fx5TpvxyldkWpxve3J4VAVbtaLTeV6ULehNg3ZFConbJvb/nT1tElpRTNXAXoDyj1MdfpGndkLHq+0xQPf9+n8ht5Yvx0Y4EvrqyGxSQrh7kMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ihJIcx4+; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734019593; x=1765555593;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Y1UrRZ03s2v8IR0sCqdjJHr0urH93tNZ0rPRwlN4FG8=;
  b=ihJIcx4+R6gSu63GHBavl8CYAfruX00NUBbBbC6maNQ2uMt6D3qf6ME9
   ZjqBpdhELN+owQBFg6k6tXGVP2Mazjf4aLtswOP4Fqt7CHeoIxoq+dPfB
   C9DuRbDAkrQeWioSpeApczoWy7RNREGdseNSC5JSBuBn8Yae8Cd3BGuwy
   /IrWeG8nHi6g/EXecSXToaUYBzLq6hdQ2Vp4roH8DFxVvYTNEwlCCqzpT
   opV+NFrdCPYT0q9OG44/k+wRKiYPSUPeN2DGuVwQUBeRW69JVDJsFOJwA
   sig2nGASmyEMnf17VKOotl1qvdaASQ9kLLgKe51mbXsrRhBmd3lJxLtSy
   A==;
X-CSE-ConnectionGUID: pk8kSQK2RN+oP7G4ew7AKg==
X-CSE-MsgGUID: zVLOlqVqTk+oKOIFtFXN4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="45053056"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="45053056"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 08:04:56 -0800
X-CSE-ConnectionGUID: 0LryfXSdRZylkFcrFvtfsg==
X-CSE-MsgGUID: ax+V+KelTtWC5jKFh0upKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="127067876"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 08:04:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 08:04:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 08:04:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 08:04:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=so1ObGoeQOKQo9olrKCMVjda7ZjIQ9nyE0nnrkNWmAaWNsB2nz43vyBydD1qMBlw8hAa8FIW9To+pybV3B9GO5xtDkl8YeA023rBfe2ke+7eYaDrM19iGBoOvzkSg3ruy8jh1sZUJyKt9baC//hJ/Sld7wgVQBtUylEtcGft/HZPKXzCRLWpY0biu4VzaAyrZnG2OXEReOVLiym71uE3MM1l9o/WndICSllAIh2YvrJQY0ag0tBuCrp4yFjKo2BIvS0fEPFPNeY6cmsefWmZ64+OOw1G85sd0UJmo2aqbHjZ2vB+4UmWvJKdUGs/pvcQwxH5pNm2JIg+E8r2VvrPag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3B4gBd5pyvMCQxcrGRISn7vJ5qpSV001CxpG+uFXUE=;
 b=yEpt2pR+a/znVzQafICno1hPJp6vYaaYGac45dLgdaaP5JZxLaavQAtLsG7eh4ij238bNMfn1QjFd3hn8ZTv5W+gT88LD5B/x5HfH9CydDa627Gs/gm9PfiF5q3uG2tHk8pO6cRwVZSX25LR3xSQyp8aLmixWX5eZ05+87DM4W744dhsFZF1GyUWsNXW7rYimaLlP0B/2xs46RxW1M+jaTNUc0E4apnA0iEZSmECEydVkUqOiGueWoRU6u0TcSA3UOrIJMWR3W/KMtU4djzrGH/JdQOIktBsDdGZk207tlt4OaKoCERvBuQ6v05AUjs0PlbM9Kt1K7GAp8P4HwZP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4758.namprd11.prod.outlook.com (2603:10b6:208:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 16:04:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 16:04:52 +0000
Date: Fri, 13 Dec 2024 00:04:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kalesh Singh <kaleshsingh@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Rik van Riel <riel@surriel.com>,
	Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yang Shi
	<yang@os.amperecomputing.com>, Ryan Roberts <ryan.roberts@arm.com>, "Suren
 Baghdasaryan" <surenb@google.com>, Minchan Kim <minchan@kernel.org>, "Hans
 Boehm" <hboehm@google.com>, Lokesh Gidra <lokeshgidra@google.com>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  249608ee47:  will-it-scale.per_thread_ops 50.1%
 improvement
Message-ID: <202412122346.ea54d461-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::27) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ae1725-1566-4cde-933b-08dd1ac6b631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?bjiXOLHNsnwzZEdl+8SMZCr2B8iql/TMDTnx3WLvpMmXC6aN2/kaCNiJSg?=
 =?iso-8859-1?Q?BCE5/C7HS79J89pVvRomt2ZFTfpz/j2G1w8hL8aR8t8X3a02VjPQY3oEur?=
 =?iso-8859-1?Q?AOW7sVwZjTLBsFtmE7ZZxJUDD7kx3SdAFVWDBRDnCBf0OSLgQumYV552Yj?=
 =?iso-8859-1?Q?etOsU78EgpsN4uV4lJHkC/Ezwz1a0foTb6wUAnhTFJXOxImXLauYUPYF97?=
 =?iso-8859-1?Q?wxsnt6Qb9P2u6l1rRQmkVzw3b5vytaB8BXlU2FPcc8G1t3a6mAOb59MPa2?=
 =?iso-8859-1?Q?1PPo0Coy7yNqyMs6tz8/KVEYqhFzxZXkXT6wxzqJyFLkboZgbFBDiaMBt+?=
 =?iso-8859-1?Q?aH2nYrXLhxZ9NFlEbYXw8gaOR+qFLYCfR+X6zLeqv5ONOYjW4HvEucm/jV?=
 =?iso-8859-1?Q?WutWWQJDRm0oPDoH+kebL2oGCHbZ38gHpsiIldNQyKrBuR0gr2nv+VIRCB?=
 =?iso-8859-1?Q?dcI014alW53wAseI+VQN8UDxaq06N3Z6liU5jlvK8aM8QFLWsaOTg1ZPHn?=
 =?iso-8859-1?Q?sYCFyyVxkoGvg4CEOVbKXGGCx7eMR34vRxRVFPom52fY7OYuQ3vsbMeY9V?=
 =?iso-8859-1?Q?6+fXP1P11R/faWXOT6P/UL5c6n3BCDoSMlO2oDnfSeLRXKgCRMcYnGdJdN?=
 =?iso-8859-1?Q?1nFLNjms/uaVVpKa8vr6WhrER7dprYphZXVAxbkyLx5iZNnEeliv+nbRQB?=
 =?iso-8859-1?Q?Cc1JHNHxqKHSXfoWihOjaYy2Uxlmkz7rLdg7NAfAC9jvwPZ+R9HU2xbWGM?=
 =?iso-8859-1?Q?oi4Kgt31PQQC8fia/YHPwgcVEiMBEZzETpqat9frtqXa/xYcbVJ4s+/ZVg?=
 =?iso-8859-1?Q?w3gYz/oLSLpNQajl39BX0rZja9/GlFYuYSAK3LHPfQNkW3LxMM0JmiR4FM?=
 =?iso-8859-1?Q?q8lENoLu99Sua9iMuIXc4BizYxlsvByysojXW9jz9vdk7i60tOaBVcGfKj?=
 =?iso-8859-1?Q?W4ZwXC/OTdQzM06zn4Hk22oZ4pNYy3kk7hQw8AT1BLoN+6VPlf5I15+3Ae?=
 =?iso-8859-1?Q?tviWnF9IuPKmc0+Ine5TZOy+lIY4Ssl+d5US5mT5XHUaHWcTTaiSMyADNA?=
 =?iso-8859-1?Q?lh/lbkf7hlzNiphUf+zc0oUVda689/ZMBrwqpmJyg58JuFmNgDxa0zEbw/?=
 =?iso-8859-1?Q?Ea322M06xVgI3btl97xG13SSlcyihPEui9JPq8OsZJF7uOgwEYWJYe2D1y?=
 =?iso-8859-1?Q?6r3+7cGT789QVbed9I2l8t9LPBrEEK9BI74BuVZ7DyFcxQicR/A5jUnMIg?=
 =?iso-8859-1?Q?+f53TzAnYIR0ECV8UmaBbHt9c1jHtqk7+9+2xSGHF5R6gFuP+Zuh5EJjFT?=
 =?iso-8859-1?Q?erjeKIAEdeQOgDKljBOR7XP4ykOvSlZ1aTIxffsSMezixnY/GxyTVq4ZG4?=
 =?iso-8859-1?Q?qZwtgftwMm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5KXX7Mv5AHcjv/tEKhdlCG0V32mIBr/Csn+73FDhdWFI0gaLo2cMvQ2aeu?=
 =?iso-8859-1?Q?JY2S23U+cyqEFRYU0K5C026S6lM3zVXfUlbLZMLqyDg43TAEIRFEypZglN?=
 =?iso-8859-1?Q?0xO9FqBlq98CCJnFhxfc4uDcma05Yo7cEZ6tDfvSGiQYiyUXZtG3xKkeQm?=
 =?iso-8859-1?Q?QU1NiI7P9Myjxq/c2r9+qwPwtYv+4uu6Z6Ug+9scF5sF50zPsNLMslKKEx?=
 =?iso-8859-1?Q?t5P4JYl8KuFMu6g8odsP8pMhvptD4OkmmShPfCvAgHG2F7VLkd5u0X2KEe?=
 =?iso-8859-1?Q?t0f5r0ehJgfyEy04Jp9wwrq5YFIcnGBvwNDM25cocMQWiVR+TNtE5/h+qt?=
 =?iso-8859-1?Q?U7GGmsK4tqoKO7Kcv0e1FQU45F76L+pPqi94Gi6LOmgwk9PaJ0dPXAGdAi?=
 =?iso-8859-1?Q?/Vz82LCPmYgrrNXhjayifa2j8wUtPDuHu3q0+AkwHuJwfpLRaQqL6AXfPJ?=
 =?iso-8859-1?Q?KKdmy13jhHYeyG0UFMGD+lF88jBofm5CoX2GhaI5ZdHaV2vZK+v8UjmPB5?=
 =?iso-8859-1?Q?1/9SmEzS47FEL+DKxm/hDJ9SOkSjK8ErFEMMZKZy9SqY6+Az3+DYlgzy0O?=
 =?iso-8859-1?Q?JO023q8mLhJhAVqV9daOsD0sh+DNgm1gM1s/PCaXcyl7lkadCJUJUhEwfD?=
 =?iso-8859-1?Q?p0YiVe+MssdhGcbyvunPK84g3h9Uj811r6oXJGjEreFJ/tScqC/tISrimv?=
 =?iso-8859-1?Q?2Pkn0hyam89B3tk9Ekfwk7sM7vo7/+w/Kzq5zmxNlv8mKqmeG43UldiTPP?=
 =?iso-8859-1?Q?rOvS4SpvgMsdVPnoS1MUElRsOOMb3rzDX3gHboDw97Io1lY0QHeN2m1SSa?=
 =?iso-8859-1?Q?oeAsJy7hJoe9xepkIvSb9tfKrASh6LuBL07zmQPnr+R66AP+hYRkzBJSEn?=
 =?iso-8859-1?Q?kP2n5l8ctQcwqENIff4VBe1QVCErkjh5xaRsl9TXbIzt5VtW+GxKjBoPSQ?=
 =?iso-8859-1?Q?3/J4UUl3GXz9oUdjo+tfw5ZbYKQzfLZDXfnLzXADUwMtSFlTtbWzHrZeAA?=
 =?iso-8859-1?Q?dxpVbIxljpi6y014THYsd2Lt2anSJJ2fVRchUhVFkNhZGVpjfc2loDhwjU?=
 =?iso-8859-1?Q?AOv4vtw06X9r9r+HWcJ/TeR/DK2j9rQYijSicWZyhv3c3ytDDRSEh5gY9e?=
 =?iso-8859-1?Q?MASmRB0E1/8IuClj4/Wc/n5ROViB3Cb+63LWxA3D543HFkPyn25pUT2Q0h?=
 =?iso-8859-1?Q?mFTNFYf0+O1j+xaexSi15UmpbBlIxGkE4TxlddvNkZuBLy/CqkECEXK4CN?=
 =?iso-8859-1?Q?9D18fK08JTDHrf4GBsnEc+LV0XfCZ2q4KlKWvIfcfMQIzK39ifUW7CSPG4?=
 =?iso-8859-1?Q?7X4gdzdxrTQJNhnEx2f9KJpL3XxldlbItNa1VKNDxZwbIGkLw4jSctos/S?=
 =?iso-8859-1?Q?NUDb7wDKFxEJ+LslK6j1XC0cC5jWmfvAA10DAiyj2bzUKHHc0EQ48eVPAj?=
 =?iso-8859-1?Q?MzVxy4SwWAZKEddRlvWQc7rDSbAqx0zKNTRHVy6AuyBEJyEvlCVnG4Q1Gv?=
 =?iso-8859-1?Q?bD4XaPyutPEfG+vDYQFIITcZBod9Dyx9iwtJLmSszugtwBLitwx6f6Nar9?=
 =?iso-8859-1?Q?ggzb+L99O77Z2S8M8tGNKm+JlEA7SlV010PvlDQ2m1PfNgrhlAIGqazIc8?=
 =?iso-8859-1?Q?Jr+hXkJHar1wZCQOesCSUSLUUcdGNe3FaHxCkJw7JSUKpW4OLrUMiCig?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ae1725-1566-4cde-933b-08dd1ac6b631
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 16:04:52.3012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ki7CGwewAUaYL5f9Cnv82K74gDUK8K7irCYKwfhF1fnNTF+PzutkDRwT7GzZ0JDyx1dN/VNGiev7ggPEyEJbRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4758
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 50.1% improvement of will-it-scale.per_thread_ops on:


commit: 249608ee47132cab3b1adacd9e463548f57bd316 ("mm: respect mmap hint address when aligning for THP")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: thread
	test: brk1
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops 51.6% improvement |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory              |
| test parameters  | cpufreq_governor=performance                                  |
|                  | mode=thread                                                   |
|                  | nr_task=100%                                                  |
|                  | test=brk2                                                     |
+------------------+---------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241212/202412122346.ea54d461-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/brk1/will-it-scale

commit: 
  89dd878282 ("mm: memcg: declare do_memsw_account inline")
  249608ee47 ("mm: respect mmap hint address when aligning for THP")

89dd878282881306 249608ee47132cab3b1adacd9e4 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.271e+09 ± 11%     -23.6%  2.499e+09 ±  4%  cpuidle..time
    534782 ±  3%      -9.8%     482625        meminfo.Shmem
      7292 ± 10%     -16.8%       6068        uptime.idle
    117230            +3.0%     120705        vmstat.system.in
     10.21 ± 10%      -2.5        7.74 ±  4%  mpstat.cpu.all.idle%
      0.10            -0.0        0.08        mpstat.cpu.all.soft%
      0.30 ±  8%      +0.1        0.38 ±  2%  mpstat.cpu.all.usr%
   1562083 ±  5%     -28.9%    1111214 ±  6%  numa-numastat.node0.local_node
   1600171 ±  5%     -27.1%    1165935 ±  5%  numa-numastat.node0.numa_hit
   2469533 ±  5%     -36.7%    1562269 ±  7%  numa-numastat.node1.local_node
   2538689 ±  5%     -36.4%    1615104 ±  7%  numa-numastat.node1.numa_hit
   1599764 ±  5%     -27.2%    1165290 ±  5%  numa-vmstat.node0.numa_hit
   1561676 ±  5%     -28.9%    1110570 ±  6%  numa-vmstat.node0.numa_local
   2537854 ±  5%     -36.4%    1613883 ±  7%  numa-vmstat.node1.numa_hit
   2468697 ±  5%     -36.8%    1561112 ±  7%  numa-vmstat.node1.numa_local
    517.00 ±  6%     +44.8%     748.67 ±  5%  perf-c2c.DRAM.local
      5599 ±  3%     +22.8%       6877 ±  3%  perf-c2c.DRAM.remote
      5356 ±  2%     +17.2%       6277 ±  4%  perf-c2c.HITM.local
      3995 ±  3%     +12.9%       4512 ±  2%  perf-c2c.HITM.remote
    207757 ±  3%     +50.1%     311758 ±  4%  will-it-scale.104.threads
      9.27 ±  4%     -19.6%       7.45 ±  4%  will-it-scale.104.threads_idle
      1997 ±  3%     +50.1%       2997 ±  4%  will-it-scale.per_thread_ops
    207757 ±  3%     +50.1%     311758 ±  4%  will-it-scale.workload
  20771245 ±  7%     +19.8%   24875862 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.avg
   6013540 ±  9%     +29.6%    7795227 ± 15%  sched_debug.cfs_rq:/.avg_vruntime.stddev
  20771245 ±  7%     +19.8%   24875862 ±  5%  sched_debug.cfs_rq:/.min_vruntime.avg
   6013540 ±  9%     +29.6%    7795227 ± 15%  sched_debug.cfs_rq:/.min_vruntime.stddev
      5286 ±  5%     -32.3%       3580 ±  9%  sched_debug.cpu.avg_idle.min
    304791            -4.4%     291399        proc-vmstat.nr_active_anon
   1009858            -1.3%     996889        proc-vmstat.nr_file_pages
     23935            -4.3%      22912        proc-vmstat.nr_mapped
    133626 ±  3%      -9.7%     120653        proc-vmstat.nr_shmem
    108257            -1.7%     106463        proc-vmstat.nr_slab_unreclaimable
    304791            -4.4%     291399        proc-vmstat.nr_zone_active_anon
   4140560           -32.8%    2781620 ±  2%  proc-vmstat.numa_hit
   4033316           -33.7%    2674065 ±  2%  proc-vmstat.numa_local
   7314624 ±  2%     -37.7%    4554492 ±  3%  proc-vmstat.pgalloc_normal
   1102175            -2.4%    1075842        proc-vmstat.pgfault
   7136742 ±  2%     -38.5%    4391328 ±  3%  proc-vmstat.pgfree
      0.49 ±  6%     +23.1%       0.60 ±  6%  perf-stat.i.MPKI
     37.67            +4.2       41.92        perf-stat.i.cache-miss-rate%
  13495545 ±  3%     +26.4%   17064915 ±  6%  perf-stat.i.cache-misses
  36075782 ±  2%     +14.0%   41135363 ±  5%  perf-stat.i.cache-references
      9.29            +2.5%       9.52        perf-stat.i.cpi
 2.621e+11            +2.5%  2.685e+11        perf-stat.i.cpu-cycles
    212.81            -1.4%     209.80        perf-stat.i.cpu-migrations
     19736 ±  4%     -19.1%      15958 ±  7%  perf-stat.i.cycles-between-cache-misses
      0.11 ±  2%      -3.3%       0.11        perf-stat.i.ipc
      0.48 ±  4%     +25.9%       0.60 ±  6%  perf-stat.overall.MPKI
     37.35            +4.0       41.40        perf-stat.overall.cache-miss-rate%
      9.33            +2.0%       9.52        perf-stat.overall.cpi
     19440 ±  3%     -18.7%      15809 ±  7%  perf-stat.overall.cycles-between-cache-misses
      0.11            -2.0%       0.11        perf-stat.overall.ipc
  40994713 ±  3%     -33.4%   27301203 ±  4%  perf-stat.overall.path-length
  13453027 ±  3%     +26.4%   17009626 ±  6%  perf-stat.ps.cache-misses
  36008186 ±  2%     +14.0%   41056969 ±  5%  perf-stat.ps.cache-references
 2.612e+11            +2.5%  2.676e+11        perf-stat.ps.cpu-cycles
    212.16            -1.4%     209.13        perf-stat.ps.cpu-migrations
      0.00 ±143%    +614.3%       0.01 ± 38%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.00 ±223%  +12311.1%       0.19 ±115%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.00         +2575.0%       0.05 ± 92%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.04 ±175%    +275.8%       0.15 ± 89%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ±120%    +669.0%       0.15 ± 89%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 32%    +657.1%       0.07 ± 51%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.15 ±114%    +559.8%       1.00 ± 19%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00 ± 55%    +229.2%       0.01 ± 22%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.04 ± 61%    +378.2%       0.19 ± 15%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.01 ± 15%    +160.3%       0.03 ±109%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 30%    +216.1%       0.02 ± 12%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk
      0.03 ±163%    +448.7%       0.18 ± 24%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 30%     +96.7%       0.02 ± 11%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 86%    +234.6%       0.05 ± 60%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±143%    +700.0%       0.01 ± 33%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.00 ±223%  +50788.9%       0.76 ±137%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      1.05 ±141%    +326.0%       4.46 ± 67%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_expand.vma_merge_new_range.do_brk_flags
      0.60 ±186%    +271.1%       2.25 ± 74%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.02 ± 97%  +14710.9%       2.72 ± 47%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.17 ±208%    +228.7%       0.54 ± 80%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.10 ±150%   +2829.8%       2.93 ± 34%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.73 ± 99%    +137.5%       4.10 ±  5%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.05 ±162%   +3038.5%       1.62 ± 72%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.18 ±174%   +1759.9%       3.30 ± 41%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2.19 ± 69%     +74.8%       3.82 ±  6%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      1.16 ± 95%    +211.8%       3.61 ±  8%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 25%    +200.0%       0.02 ± 11%  perf-sched.total_sch_delay.average.ms
      5.20 ±  7%     +55.1%       8.06 ±  7%  perf-sched.total_wait_and_delay.average.ms
    338197 ±  7%     -43.5%     190977 ±  7%  perf-sched.total_wait_and_delay.count.ms
      5.19 ±  7%     +54.9%       8.04 ±  7%  perf-sched.total_wait_time.average.ms
      6.72 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     70.88 ±162%    +311.9%     292.00 ± 22%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.91 ± 15%     -43.6%       0.51 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk
    279.25 ± 11%     +24.7%     348.09 ±  5%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    607.00 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    328796 ±  8%     -45.0%     180683 ±  7%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk
      3211 ±  6%     -20.9%       2541 ±  7%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1001          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%  +52555.6%       0.79 ± 31%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.00 ±142%  +1.2e+05%       1.79 ± 90%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.commit_merge.vma_expand
     70.88 ±162%    +312.0%     291.99 ± 22%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.91 ± 16%     -45.1%       0.50 ±  3%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk
      0.98 ± 11%     +43.4%       1.40 ± 25%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    279.22 ± 11%     +24.7%     348.08 ±  5%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±223%  +1.5e+05%       2.21 ± 63%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.00 ±145%  +2.2e+05%       3.74 ± 71%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.commit_merge.vma_expand
      0.05 ±161%   +3018.3%       1.62 ± 72%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.59 ±  3%      -0.3        0.27 ±100%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable
      0.57 ±  6%      -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.intel_idle_ibrs.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.70 ±  4%      -0.2        1.49 ±  3%  perf-profile.calltrace.cycles-pp.common_startup_64
      1.61 ±  4%      -0.2        1.40 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.61 ±  4%      -0.2        1.40 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.62 ±  4%      -0.2        1.42 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.68 ±  4%      -0.2        1.47 ±  3%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.68 ±  4%      -0.2        1.48 ±  3%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      1.68 ±  4%      -0.2        1.48 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      0.72            -0.1        0.58 ±  2%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.81            -0.1        0.70        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk
     97.96            +0.1       98.08        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
     97.98            +0.1       98.11        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
     96.80            +0.1       96.94        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk.do_syscall_64
     98.01            +0.1       98.16        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
     96.91            +0.2       97.07        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     96.94            +0.2       97.12        perf-profile.calltrace.cycles-pp.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
     95.81            +0.2       96.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk
     98.17            +0.2       98.40        perf-profile.calltrace.cycles-pp.brk
      0.00            +0.6        0.59 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.53 ±  6%      -0.4        0.17 ±  8%  perf-profile.children.cycles-pp.intel_idle_irq
      1.00 ±  4%      -0.3        0.70 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.70 ±  4%      -0.2        1.49 ±  3%  perf-profile.children.cycles-pp.common_startup_64
      1.70 ±  4%      -0.2        1.49 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
      1.63 ±  4%      -0.2        1.42 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
      1.63 ±  4%      -0.2        1.42 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
      1.64 ±  4%      -0.2        1.43 ±  3%  perf-profile.children.cycles-pp.cpuidle_idle_call
      1.70 ±  4%      -0.2        1.49 ±  3%  perf-profile.children.cycles-pp.do_idle
      1.68 ±  4%      -0.2        1.48 ±  3%  perf-profile.children.cycles-pp.start_secondary
      0.21 ±  2%      -0.2        0.05        perf-profile.children.cycles-pp.mas_store_gfp
      0.72            -0.1        0.58 ±  2%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.82            -0.1        0.70        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.17 ±  2%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.17 ±  2%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.vma_complete
      0.58 ±  6%      -0.1        0.49 ±  9%  perf-profile.children.cycles-pp.intel_idle_ibrs
      0.64 ±  3%      -0.1        0.56 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.54 ±  3%      -0.1        0.47 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.54 ±  4%      -0.1        0.47 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.45 ±  3%      -0.1        0.39 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.41 ±  4%      -0.1        0.36 ±  5%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.35            -0.0        0.31 ±  3%  perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      0.32            -0.0        0.27 ±  3%  perf-profile.children.cycles-pp.__split_vma
      0.36 ±  2%      -0.0        0.31 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.14 ±  6%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.handle_softirqs
      0.23 ±  2%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.sched_tick
      0.13 ±  6%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.rcu_core
      0.13 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.rcu_do_batch
      0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
      0.06 ±  6%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.06 ± 11%      -0.0        0.05        perf-profile.children.cycles-pp.kthread
      0.06 ± 11%      -0.0        0.05        perf-profile.children.cycles-pp.ret_from_fork
      0.06 ± 11%      -0.0        0.05        perf-profile.children.cycles-pp.ret_from_fork_asm
      0.06 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.smpboot_thread_fn
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.__slab_free
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.vma_expand
      0.07 ±  7%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.08 ±  6%      +0.0        0.10        perf-profile.children.cycles-pp.vma_merge_new_range
      0.06 ±  9%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.anon_vma_clone
      0.08 ±  5%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.up_write
      0.06 ±  8%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.05 ±  7%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.08 ±  5%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.vms_clear_ptes
      0.12 ±  4%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.do_brk_flags
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.vm_area_dup
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.free_pgtables
      0.16 ±  4%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.poll_idle
     97.96            +0.1       98.08        perf-profile.children.cycles-pp.__do_sys_brk
     98.02            +0.1       98.14        perf-profile.children.cycles-pp.do_syscall_64
     96.80            +0.1       96.94        perf-profile.children.cycles-pp.rwsem_optimistic_spin
     98.05            +0.1       98.19        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.45 ±  4%      +0.2        0.60 ±  2%  perf-profile.children.cycles-pp.intel_idle
     96.91            +0.2       97.07        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     96.94            +0.2       97.12        perf-profile.children.cycles-pp.down_write_killable
     95.84            +0.2       96.02        perf-profile.children.cycles-pp.osq_lock
     98.18            +0.2       98.40        perf-profile.children.cycles-pp.brk
      0.50 ±  6%      -0.3        0.16 ±  9%  perf-profile.self.cycles-pp.intel_idle_irq
      0.81            -0.1        0.70        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.58 ±  6%      -0.1        0.49 ±  9%  perf-profile.self.cycles-pp.intel_idle_ibrs
      0.06 ±  8%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.06 ±  7%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.13 ±  2%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.up_write
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.poll_idle
      0.45 ±  4%      +0.2        0.60 ±  2%  perf-profile.self.cycles-pp.intel_idle
     95.28            +0.3       95.53        perf-profile.self.cycles-pp.osq_lock


***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/brk2/will-it-scale

commit: 
  89dd878282 ("mm: memcg: declare do_memsw_account inline")
  249608ee47 ("mm: respect mmap hint address when aligning for THP")

89dd878282881306 249608ee47132cab3b1adacd9e4 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.415e+09 ±  5%     -18.3%  2.791e+09 ±  8%  cpuidle..time
    117810            +2.1%     120255        vmstat.system.in
     10.66 ±  4%      -2.0        8.69 ±  8%  mpstat.cpu.all.idle%
      0.10            -0.0        0.08 ±  2%  mpstat.cpu.all.soft%
      0.31            +0.1        0.37 ±  2%  mpstat.cpu.all.usr%
   1679216 ±  5%     -30.5%    1166751 ±  9%  numa-numastat.node0.local_node
   1728543 ±  4%     -29.7%    1214908 ±  8%  numa-numastat.node0.numa_hit
   2318360 ±  3%     -30.9%    1600917 ±  6%  numa-numastat.node1.local_node
   2376686 ±  2%     -30.1%    1660471 ±  5%  numa-numastat.node1.numa_hit
   1726631 ±  4%     -29.7%    1214257 ±  8%  numa-vmstat.node0.numa_hit
   1677304 ±  5%     -30.5%    1166100 ±  9%  numa-vmstat.node0.numa_local
   2374815 ±  2%     -30.1%    1659314 ±  5%  numa-vmstat.node1.numa_hit
   2316489 ±  3%     -30.9%    1599760 ±  6%  numa-vmstat.node1.numa_local
    198860           +51.6%     301493 ±  2%  will-it-scale.104.threads
     10.10           -22.5%       7.82 ±  2%  will-it-scale.104.threads_idle
      1911           +51.6%       2898 ±  2%  will-it-scale.per_thread_ops
    198860           +51.6%     301493 ±  2%  will-it-scale.workload
    506.67 ±  6%     +50.9%     764.67 ±  3%  perf-c2c.DRAM.local
      5447           +27.1%       6925 ±  3%  perf-c2c.DRAM.remote
      5367 ±  2%     +18.6%       6364        perf-c2c.HITM.local
      3830           +17.8%       4513 ±  3%  perf-c2c.HITM.remote
      9197           +18.3%      10877 ±  2%  perf-c2c.HITM.total
     23736            -1.8%      23303        proc-vmstat.nr_mapped
    108712            -2.0%     106548        proc-vmstat.nr_slab_unreclaimable
   4105528           -30.0%    2875907        proc-vmstat.numa_hit
   3997875           -30.8%    2768196        proc-vmstat.numa_local
    236448 ± 14%     -25.0%     177254 ± 12%  proc-vmstat.numa_pte_updates
   7242851           -34.3%    4757136        proc-vmstat.pgalloc_normal
   7071106           -35.1%    4589946        proc-vmstat.pgfree
  19917807 ±  2%     +24.3%   24752419 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.avg
  38832674 ±  6%     +31.8%   51167079 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.max
   5538759 ±  3%     +56.3%    8659607 ± 16%  sched_debug.cfs_rq:/.avg_vruntime.stddev
  19917807 ±  2%     +24.3%   24752418 ±  3%  sched_debug.cfs_rq:/.min_vruntime.avg
  38832674 ±  6%     +31.8%   51167093 ±  8%  sched_debug.cfs_rq:/.min_vruntime.max
   5538759 ±  3%     +56.3%    8659606 ± 16%  sched_debug.cfs_rq:/.min_vruntime.stddev
    894.81 ±  7%     +11.9%       1001 ±  8%  sched_debug.cfs_rq:/.util_est.max
      5560 ±  6%     -40.7%       3294 ±  3%  sched_debug.cpu.avg_idle.min
      0.52 ±  3%     +21.7%       0.63 ±  3%  perf-stat.i.MPKI
  17623556            -6.6%   16458641 ±  3%  perf-stat.i.branch-misses
     37.96            +3.6       41.59        perf-stat.i.cache-miss-rate%
  14340737 ±  3%     +22.2%   17528616 ±  2%  perf-stat.i.cache-misses
  38069590 ±  2%     +11.5%   42445235 ±  2%  perf-stat.i.cache-references
      9.24            +2.6%       9.48        perf-stat.i.cpi
 2.602e+11            +2.4%  2.665e+11        perf-stat.i.cpu-cycles
     18443 ±  3%     -17.1%      15286 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.51 ±  2%     +22.2%       0.63 ±  2%  perf-stat.overall.MPKI
      0.32            -0.0        0.29 ±  2%  perf-stat.overall.branch-miss-rate%
     37.63            +3.6       41.25        perf-stat.overall.cache-miss-rate%
      9.28            +2.4%       9.50        perf-stat.overall.cpi
     18154 ±  2%     -16.2%      15205 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.11            -2.3%       0.11        perf-stat.overall.ipc
  42574383           -33.8%   28187632 ±  2%  perf-stat.overall.path-length
  17580646            -6.7%   16398374 ±  3%  perf-stat.ps.branch-misses
  14294844 ±  3%     +22.2%   17469729 ±  2%  perf-stat.ps.cache-misses
  37981661 ±  2%     +11.5%   42347645 ±  2%  perf-stat.ps.cache-references
 2.593e+11            +2.4%  2.655e+11        perf-stat.ps.cpu-cycles
      0.00 ±147%    +500.0%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.11 ±  8%     -32.5%       0.08 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%  +10641.7%       0.21 ± 55%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.00 ±179%   +2890.9%       0.05 ± 53%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.01 ±135%    +390.2%       0.07 ±100%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.00 ±223%   +1475.0%       0.01 ± 71%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.00 ±223%   +9837.5%       0.13 ±121%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.00 ± 14%   +1830.0%       0.06 ± 97%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ±  8%   +2452.0%       0.21 ± 64%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 16%    +870.6%       0.08 ± 84%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ±  6%    +823.9%       0.07 ± 31%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ±100%    +411.1%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.02 ± 34%   +3178.5%       0.71 ± 32%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01 ± 75%   +1602.7%       0.10 ±143%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.12 ±150%     -87.6%       0.02 ± 45%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.00 ±150%   +1047.1%       0.03 ±105%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.00 ± 30%    +346.7%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02 ± 68%   +1050.0%       0.19 ± 27%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.01 ± 14%    +376.8%       0.04 ±105%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ±  9%    +138.9%       0.01 ± 12%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk
      0.01         +2033.3%       0.13 ± 33%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 11%    +216.7%       0.03 ± 83%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ±  5%    +172.1%       0.02 ± 11%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 61%    +173.4%       0.03 ± 46%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±147%    +787.5%       0.01 ± 37%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.03 ±223%   +4840.4%       1.24 ± 64%  perf-sched.sch_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
      0.00 ±223%  +41625.0%       0.83 ± 60%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.16 ±213%    +813.2%       1.48 ± 78%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_expand.vma_merge_new_range.do_brk_flags
      0.00 ±167%  +43144.0%       1.80 ± 59%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.00 ±223%  +22188.9%       0.33 ±216%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
      0.00 ±223%   +2458.3%       0.05 ±154%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.00 ±223%  +68268.8%       1.82 ± 71%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.00 ± 11%  +15918.5%       0.72 ±101%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ± 12%   +5779.5%       0.72 ± 50%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 53%   +2545.4%       0.48 ± 73%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.02 ± 18%  +15675.3%       2.45 ± 11%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ±100%   +1100.0%       0.02 ± 76%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.22 ± 70%   +1725.7%       3.94 ±  4%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01 ± 72%   +3737.3%       0.33 ±114%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.00 ±141%  +25095.7%       0.97 ±144%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.58 ± 79%    +423.4%       3.03 ± 43%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.91 ± 75%    +324.0%       3.84 ±  3%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.02 ± 49%  +18885.6%       3.51 ± 21%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.06 ±  5%   +3199.2%       2.01        perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.93 ±115%    +238.9%       3.16 ± 52%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.53 ±  3%     +35.2%       7.48 ±  3%  perf-sched.total_wait_and_delay.average.ms
    330090           -37.0%     207837 ±  4%  perf-sched.total_wait_and_delay.count.ms
      5.52 ±  3%     +35.2%       7.46 ±  3%  perf-sched.total_wait_time.average.ms
      6.70 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    167.82 ± 96%     -92.4%      12.75 ± 78%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.20 ±  4%     -58.9%       0.49 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk
    280.09 ±  3%     +36.1%     381.15 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    606.50 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    320972           -38.3%     197924 ±  4%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk
      3118 ±  2%     -24.6%       2352 ±  2%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    693.67            -9.8%     626.00        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1000          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    167.82 ± 96%     -91.5%      14.30 ± 56%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.55 ±223%    +762.9%       4.74 ±117%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
      0.61 ±  3%     +24.0%       0.76 ±  8%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.26 ±221%   +3041.2%       8.22 ±129%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      1.20 ±  4%     -59.9%       0.48 ±  4%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk
      0.91           +45.7%       1.32 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    280.07 ±  3%     +36.1%     381.13 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.43 ±223%    +525.8%       2.69 ± 57%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      3.29 ±223%   +1258.4%      44.70 ± 98%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
     29.75 ±  9%     +42.0%      42.24 ± 16%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.52 ±222%  +67466.8%     350.90 ±131%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      3.60 ±  5%    +106.8%       7.43 ± 11%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      5.04           +36.0%       6.86 ±  4%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.72 ±  3%      -0.2        1.47 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.73 ±  3%      -0.2        1.48 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.72 ±  3%      -0.2        1.47 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.82 ±  3%      -0.2        1.57 ±  3%  perf-profile.calltrace.cycles-pp.common_startup_64
      1.80 ±  3%      -0.2        1.56 ±  3%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      1.80 ±  3%      -0.2        1.56 ±  3%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.80 ±  3%      -0.2        1.56 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      0.63 ±  3%      -0.2        0.43 ± 44%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable
      0.73            -0.1        0.59        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.82            -0.1        0.71        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk
      0.63 ±  3%      -0.1        0.54 ±  4%  perf-profile.calltrace.cycles-pp.intel_idle_ibrs.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     97.85            +0.2       98.02        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
     97.87            +0.2       98.04        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
     96.68            +0.2       96.85        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk.do_syscall_64
     97.90            +0.2       98.09        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
     96.79            +0.2       96.99        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     96.82            +0.2       97.04        perf-profile.calltrace.cycles-pp.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
     95.68            +0.2       95.91        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.__do_sys_brk
     98.06            +0.3       98.32        perf-profile.calltrace.cycles-pp.brk
      0.00            +0.6        0.60 ±  3%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.56 ±  4%      -0.4        0.16 ±  4%  perf-profile.children.cycles-pp.intel_idle_irq
      1.06 ±  3%      -0.4        0.70 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.73 ±  3%      -0.2        1.49 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
      1.73 ±  3%      -0.2        1.49 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
      1.74 ±  3%      -0.2        1.50 ±  3%  perf-profile.children.cycles-pp.cpuidle_idle_call
      1.82 ±  3%      -0.2        1.57 ±  3%  perf-profile.children.cycles-pp.common_startup_64
      1.82 ±  3%      -0.2        1.57 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
      1.82 ±  3%      -0.2        1.57 ±  3%  perf-profile.children.cycles-pp.do_idle
      1.80 ±  3%      -0.2        1.56 ±  3%  perf-profile.children.cycles-pp.start_secondary
      0.21            -0.2        0.05 ±  7%  perf-profile.children.cycles-pp.mas_store_gfp
      0.73            -0.1        0.59        perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.69 ±  2%      -0.1        0.56 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.58 ±  3%      -0.1        0.47 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.83            -0.1        0.72        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.17 ±  2%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.58 ±  3%      -0.1        0.47 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.17 ±  2%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.vma_complete
      0.49 ±  3%      -0.1        0.39 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.63 ±  4%      -0.1        0.55 ±  4%  perf-profile.children.cycles-pp.intel_idle_ibrs
      0.44 ±  4%      -0.1        0.36 ±  4%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.39 ±  3%      -0.1        0.32 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.32            -0.0        0.28        perf-profile.children.cycles-pp.__split_vma
      0.36            -0.0        0.31        perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      0.24 ±  4%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.sched_tick
      0.19 ±  7%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.task_tick_fair
      0.06 ±  6%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.12 ±  4%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.rcu_do_batch
      0.13 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.rcu_core
      0.14 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.handle_softirqs
      0.08 ±  4%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.get_jiffies_update
      0.08 ±  5%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.14 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.kthread
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.ret_from_fork
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.ret_from_fork_asm
      0.10 ±  7%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.update_cfs_group
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.__slab_free
      0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.commit_merge
      0.06 ±  9%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.06 ±  6%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.vma_expand
      0.08 ±  4%      +0.0        0.11 ±  5%  perf-profile.children.cycles-pp.up_write
      0.06 ±  6%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.05 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.anon_vma_clone
      0.07 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.vma_merge_new_range
      0.06 ±  9%      +0.0        0.09        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.08 ±  5%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.vms_clear_ptes
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.11 ±  4%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.do_brk_flags
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.free_pgtables
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.vm_area_dup
      0.17 ±  2%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.poll_idle
      0.46 ±  4%      +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.intel_idle
     97.85            +0.2       98.02        perf-profile.children.cycles-pp.__do_sys_brk
     97.90            +0.2       98.08        perf-profile.children.cycles-pp.do_syscall_64
     96.68            +0.2       96.86        perf-profile.children.cycles-pp.rwsem_optimistic_spin
     97.94            +0.2       98.12        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     96.79            +0.2       96.99        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     96.82            +0.2       97.04        perf-profile.children.cycles-pp.down_write_killable
     95.71            +0.2       95.94        perf-profile.children.cycles-pp.osq_lock
     98.06            +0.3       98.32        perf-profile.children.cycles-pp.brk
      0.54 ±  4%      -0.4        0.15 ±  3%  perf-profile.self.cycles-pp.intel_idle_irq
      0.82            -0.1        0.71        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.63 ±  4%      -0.1        0.55 ±  4%  perf-profile.self.cycles-pp.intel_idle_ibrs
      0.08 ±  4%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.get_jiffies_update
      0.10 ±  7%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.update_cfs_group
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.06 ±  9%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.06            +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.13 ±  3%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.up_write
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.poll_idle
      0.46 ±  4%      +0.1        0.60 ±  3%  perf-profile.self.cycles-pp.intel_idle
     95.11            +0.3       95.44        perf-profile.self.cycles-pp.osq_lock





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


