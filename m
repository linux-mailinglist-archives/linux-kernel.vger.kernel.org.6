Return-Path: <linux-kernel+bounces-518497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06459A39000
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 01:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097C03B2C82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0471EEC3;
	Tue, 18 Feb 2025 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7tUw487"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5083E79E1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739839175; cv=fail; b=T8ePjtSNG0X7LgbR356dMUZ69fvkqcxFQNHzRlw9/ZlV1VEaQJrQBqlI+JHCyk/4RJOUi2IkdZd2JVwaCOMi7ddiCw4joOtPyxX36bz5yc6zagLFvH2af+JgZGdfTZD4kpFq57h35pMbawBqYYYQCVNlWo25TO5JyVFklfp5JXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739839175; c=relaxed/simple;
	bh=4vm2P/r/uOvEJ5aEyEuMCH3uda8EPMQFjEqJqmIETNQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B+/BDmDXBqUj2/84n5gWU4WBuVNB79yH/eShla5TBvLRlIgLm3UBTRngu04A+hmQ781Ntev85OjgTVdDtWZP+2rASOH0AQXhkLb3kFXtCN5EqkNZ4U4aUxtbgph1oCWpUqkyUzk7/m+7/SRG2rUapyi4oI9CJuoAV+D3JU72bW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7tUw487; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739839174; x=1771375174;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4vm2P/r/uOvEJ5aEyEuMCH3uda8EPMQFjEqJqmIETNQ=;
  b=a7tUw487YA+OiGfeA7bXmWeVgAvsv2vM9uH7QuGSW9Dmf8OIYMQpI9Qo
   +QvgnmnseID5TonFVVFcmcGuQSBKavf4coMVT8Ho6ZmMiDpPP+NRYIYTb
   4841s2uqRhgk9PXDGerci7m3D5N8sKvhMbjdWWrkP6uMPTO/uZ+TPGySD
   iKc3erCT1Joh8o4r3zQkotQp5AcfUwZAgvqRsib6waZPjCsKo7UCEY8wb
   RMmW3OG5eZH2FwJq175i1g6DFfY4TtWnh2OpunJbCV7huN2fzStcQdyXy
   C8VFkho42qeTjmjJqOG6NAtmb4jZnYcc128rD082cnexs1z4GbGhYrTyE
   g==;
X-CSE-ConnectionGUID: 1B5nyqawQ0e+C9DGsVZcyA==
X-CSE-MsgGUID: iq1WHoCETqSERyeeGzit0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="43354655"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="43354655"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 16:39:33 -0800
X-CSE-ConnectionGUID: p5DwMHdCT+KDzz8bfNS2/g==
X-CSE-MsgGUID: 13MOZszpSC+zVtwKKtY8lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137480533"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 16:39:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 16:39:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 16:39:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 16:39:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkXEl0InrIKSIbcjEXUszToLYNf8P03sHmh8M+5ZhLg5dAuWf/c/1cOYuW/FOJ/4R53ZM3oDd2LHwe/1MYzY+FBxWouUGzYaT5CVj/26ca+fCOHNjxVG8iCgWduuhzQ/I2qpfmFgVo/sjrHJskRHTtLyG0A7+hgUIZ/hE8NP+hT8veAIXKII8ETzKde//0yWlFeDgP0AD5EChCYxRqVbTcaIs+f7O80RP+j/WQiRBDGum8xuPWVnYGnzn4ROcl+qa/CBF27EsfyP0FfQ2Ryexs8BXv18YjaLfLR6gIUczMxjas6C3YHQIUDZ7kxFTD+GlS7WVU6Runjbc52QkrUB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfq6dzxsTDxmwn6YVZD0PMgWhVcgOvW5Dwb/tqWJSpo=;
 b=rVPiLV19ySuLuBLUJNIOVaxqCtv3HHXW6xJOLvUcmWd01EG37wfyTPoht7iz3LIoLyVXIEYeQxUSSCNQQBInNP9pz3wO8CwMU5vO39bNUIUDOe+KdC12gunlXv5K1uXlpiVqU1GnIZbXpEcJRrP8EFYJ2W8yu/VWxWTcADLC7ctnMBQdrCZyC7SZTYtTmC1wyZeBg/vqY5Vwzae2O0H0u3Cl0akYH0b0HY/Db3f1QqzwVyiO83qwUWFxSPzapWDyclaHNLrCv1F/atHfwJb9kJLcLPkXYLqsRzdrPk4qNGLGH176j+qKvKon+eQJ4P9kdjPJZ1jlrMvojBBTgeHwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 00:39:30 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 00:39:30 +0000
Date: Tue, 18 Feb 2025 08:39:21 +0800
From: Philip Li <philip.li@intel.com>
To: David Laight <david.laight.linux@gmail.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: Alexandre Ghiti <alex@ghiti.fr>, Christoph Hellwig <hch@lst.de>, "kernel
 test robot" <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>, "Darrick J.
 Wong" <djwong@kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x'
 is never less than zero.
Message-ID: <Z7PWuSA4jtZnxp5J@rli9-mobl>
References: <202502171326.j4Xd3I0j-lkp@intel.com>
 <20250217092445.GA29568@lst.de>
 <a14347d2-6189-49bc-a1cc-e5959e76e6c2@ghiti.fr>
 <20250217131203.2657cc4b@pumpkin>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217131203.2657cc4b@pumpkin>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|MW3PR11MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: 23580d80-4ab3-4c7c-daf2-08dd4fb4b4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?y23Y+kbkYSs28spCSmVKxuGf+rKTNpvQkfNX4qOdzD5ZAoemJozLFiPRKJ?=
 =?iso-8859-1?Q?uMTz7lgEdeP6z4QyNZ6apzitVw4k4X/skQWhRarJAoeXHlHrr8oSvgKElk?=
 =?iso-8859-1?Q?vENuMrk+bPze1enEKgAuSWauBKOOInLzYLcESOqzW5Vaox8s0ZpNLtSbQf?=
 =?iso-8859-1?Q?E+dqiz0Jzq0gXb41Yawp9CvpLfa7Y770CwxNz4sd0yPfDDSsA+Ev+mBkos?=
 =?iso-8859-1?Q?tgwijJVOdv1PvoD6YAtvRlqXoPYq/GrRN5x0ZVF2aQuB7ZPV3hFwD3Bhse?=
 =?iso-8859-1?Q?W1jLVaumOhZrWrzgwjegGMv2LbjCwo4gpQtudO6dJmTHj3Q+5pN8V5GHxa?=
 =?iso-8859-1?Q?2CP55SbTcnd6gW554NVs8hVtpHnyWnQbB0zfaYrzipaO+VNgzpWhBdShXP?=
 =?iso-8859-1?Q?cEG2bhcgvIZ2LQwyQtW9R0vsue6VvVtY3jvsjXYgdjkZDcuMkXxB6lWlVk?=
 =?iso-8859-1?Q?6cJSOEQ4ra6+pgGG67VvkltIUcZtYA2dJW+6oangGl2Ix+u1CBtvsuo0CF?=
 =?iso-8859-1?Q?t4sa76g7lP/U170rx6MPwk+2Y+lR13pN/hdsSQt/V1xFw4/3sxoQRd6ZXq?=
 =?iso-8859-1?Q?C3FWKuTOLttexlTlvaAe7eJg/uP9yVLu65tEvqvy/4Gp+V0+69XO3dJlkN?=
 =?iso-8859-1?Q?dY6gskJ+43RovAFX6CkAzg+5sFPv3tErZWLgXNTXlwuThnrMoPwLDvFifX?=
 =?iso-8859-1?Q?UYU9y1mmJx1F+y6xMm3NtAR1OkEm62V4uLxUdNexmQb5vlciqdVwOq0xmk?=
 =?iso-8859-1?Q?7KnS1LwyM8uOpOuKUEMj2qk3byPWKhwWn4QIEbPFV6jgD+7WUDmL1xNzK7?=
 =?iso-8859-1?Q?WGKqq4MW1T5PKyopUgprzCIscn4MZNZqfKDrqf1Gb9X30ho8NIjIF19M1a?=
 =?iso-8859-1?Q?jfg4sTVKG6PW6+w/9HUn669O4Sp0NncdrtECWlvuiUiy1WpY/rtZaCI3wQ?=
 =?iso-8859-1?Q?5R5egGlF241RMO83HIPYE2LaFtBiJs8lQr0NJdbcdKIaUefsjrM6qfd/p4?=
 =?iso-8859-1?Q?cPC9uoEgEHu1VEDy4sJ4AB8ZaC6qym8ytQ1iT1heq66KywhzJMr1aqnYem?=
 =?iso-8859-1?Q?OHRqKE+zpinU2ZJek4Egg+IK+o3NiCONoPvdu34VgOpYTXrbVIjtqzwkbo?=
 =?iso-8859-1?Q?tHRUdp4XbXEsxu6anuK6WQGfGQqqMQ7higowWn/06rQr4FNTiPh3RfRRzg?=
 =?iso-8859-1?Q?UIrux8VZaiZ1LjMU2fi6Arh5SEOynf0i77JcNSAFMsk+OqVKRFu3irhxFB?=
 =?iso-8859-1?Q?s5C9R0EDOFTO60fMbWOa40UMARvqus2GRCZevlZ8bPP9tThlTEUztUVpMM?=
 =?iso-8859-1?Q?nM4pu/EB6zYHED+cR3PjY7WqMqItNehbAU1FDs3afOj9/xB8iWXaEtYn61?=
 =?iso-8859-1?Q?D+zcK5Uee6iE2ocqB66UOlpill2qQc0aAfu9GKZSP3SXAXLB0hJ0yZUUmn?=
 =?iso-8859-1?Q?iZAGHnf/eXFaxEtn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6N/6gfKcLFjJ0tBwXhcYFAeTHSK2uU3+3NrUmdnGpUFimM+JPoLr6fu9jA?=
 =?iso-8859-1?Q?9E1IlI47Oytw+eB6VFj2wTfCWxf3N+XIy2oIiWU4m8U95/CWjxxIJex2nM?=
 =?iso-8859-1?Q?Gp07IQ3Eq6u6E1/lOUkFcDzDUB/5U2hPwXwtr9liCcHwV4y69La3ptmuMX?=
 =?iso-8859-1?Q?ML98IyNZxK+VZKsBjfsNJj6VLG5c0wOORY76aqd1S9Lo3M2UtqdsyZQmR6?=
 =?iso-8859-1?Q?4MdbLZzAtcrszuufQhK7BvhAuESb1g+l7tXjfbGaTxepk4cRYocEjA7++f?=
 =?iso-8859-1?Q?Q+/zHK+7CblG6u8ecspPs2k6pj5hsblu724xhxUjA9/x9C6q9R1y4Svs2b?=
 =?iso-8859-1?Q?ovFk6frOLWbEz2Nixx+FJqSRfe3zbqu6IKihlzGM/F2OtgjFl4FmeXcPuJ?=
 =?iso-8859-1?Q?bPboapu4U29zOS2EOthmGjAnrdFHFRF0e7GykIk4d6CMb4vqHz2ga/71Pa?=
 =?iso-8859-1?Q?arpq2WJFeJGXAOiuKeVoYcSkXrdpER4jf3Wq56WTGcfIbot2PBVrJW80yu?=
 =?iso-8859-1?Q?vgW7C//cdTSaOxTpv+wvG2I+WpRG6Y5VZe3lMB75E/A4WjQm51Wz6fSLpC?=
 =?iso-8859-1?Q?W8BZqTPdKWc4ycQXr2XZRhp0t814bkEHrbUyCeNGrPUfIdzY23j8eHRRtK?=
 =?iso-8859-1?Q?KPy+8syFSZKKY5RTpXJXsU+w1ZP1P9n74carYFTWbBG4Lr/v5k5AsN4S8Z?=
 =?iso-8859-1?Q?H18+df8Ls+jHn7WkCRUA8pVNWvH5J+mMOTCRd/ZJ9xuuM2XNMXlmOzmZdR?=
 =?iso-8859-1?Q?Nw2bwzQMHEoY6F0o6pAjTtZN4sBYYd4ZcCR0BQ6btCs5+yxmH1aogwhtFh?=
 =?iso-8859-1?Q?ntXzBvSQn5zpSUCoL05tD7EGRFKppUgJKPgsGm1cdZpiHopICyN21XIY60?=
 =?iso-8859-1?Q?QalbDWQX7v/lNPMNMyAZrGOHmqaGEpPmb5t4nx+wcoHTiWaG2O0OKxmG4n?=
 =?iso-8859-1?Q?as1Kn3d7ZIN9sdol2FM9R1BZGFPz0OQAK6WZI/TWABtg9ZlbjpH7vJn0nA?=
 =?iso-8859-1?Q?EZgD/EoWn9aLUEsJiIAbc3OtvRN34fhIcGPNxP0q6gN9PCdFDPwNIUzfeu?=
 =?iso-8859-1?Q?XVQQg/kL7KWYgByxCfkANfgn6s7vzwVVOzVt/zxGkXpjI/aqSF7uhSuwMq?=
 =?iso-8859-1?Q?RmEaPdksBEPhxV4onB3wArD9btWKV3dNBJaIWAacldTWJbPIhkIattekhs?=
 =?iso-8859-1?Q?kNDmowVfGZQk+zsDCyabJFV7i9Z5ma1M2QE/6qC8rk5SyjNjY+ck74hn7B?=
 =?iso-8859-1?Q?YCp90yJYmxGBu4UwrmgqSL/d28O3qWe28W0qK+End0dLzTfRgnTpig6xrW?=
 =?iso-8859-1?Q?33+ywtFvHwhHK71kUadOUIB0Z7xAD9pa4o7gFlJmttRX9bfyvzubaHbtir?=
 =?iso-8859-1?Q?TsEXQjO6o9CtegIouNwtTZqm/0x3ZjbAgr7G42de77Vnv84x8SId53LDx/?=
 =?iso-8859-1?Q?hb2W199Ipg1zpC66OQdczQuMRkwpYzsSXqqycEz+VsGW3O89rNjEi/xnh4?=
 =?iso-8859-1?Q?TY5cgW+ZaLD1SjTatTGa5Z4ks87l/3hZgoXWvRS2kfU1rfcl8C8S+n2nZV?=
 =?iso-8859-1?Q?tWxV+bMDRLV6GsSduA4KfOHDeCdbmHTuxafqT9cL0megUt2AFDH4+TLdaS?=
 =?iso-8859-1?Q?bPbm3PXHV0s7QRWXrfAI3EpL4gdB4Pe7po?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23580d80-4ab3-4c7c-daf2-08dd4fb4b4cd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 00:39:30.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfmMZIrX0QT4VKJe8J2fqCTu4WAR7OIAEDYBNg4e6IDTlAeoCbRxeu9wiCacNmSoVjGWSMMqYzuVxGPoNrxYwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4539
X-OriginatorOrg: intel.com

+ Dan

Hi Dan,

On Mon, Feb 17, 2025 at 01:12:03PM +0000, David Laight wrote:
> On Mon, 17 Feb 2025 13:06:49 +0100
> Alexandre Ghiti <alex@ghiti.fr> wrote:
> 
> > Hi Christoph,
> > 
> > On 17/02/2025 10:24, Christoph Hellwig wrote:
> > > On Mon, Feb 17, 2025 at 01:53:08PM +0800, kernel test robot wrote:  
> > >> New smatch warnings:
> > >> fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x' is never less than zero.  
> > > Looks like this is an issue in the riscv virt_to_page implementation
> > > which also shows up in various other places.  Any chance this could get
> > > fixed in the riscv code?  
> > 
> > 
> > To me, the only test that could give rise to this warning is the last 
> > part of:
> > 
> > #define is_linear_mapping(x) \
> >          ((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < 
> > PAGE_OFFSET + KERN_VIRT_SIZE))
> > 
> > But given that the config is a 32-bit config, it should not be evaluated 
> > at all.
> > 
> > Could that be a false-positive and then an issue in smatch?
> 
> Why is smatch even looking.
> The equivalent check in gcc has been moved to -W2 because of all false positives.

Can you help check this one?

Thanks

> 
> 	David
> 

