Return-Path: <linux-kernel+bounces-446656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890599F279C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF09B188589E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687773FD4;
	Mon, 16 Dec 2024 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3pnx6za"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16047182
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734310001; cv=fail; b=hvHgAJ/uKuc79DMwT6/frT9Y/Ka89wREx5mOkw51u7pyp2JLHSygCVlevLJVtranxVCYoSUilFzXNLemUdm6iTcSxP2IVkH21TFTz7OFvoFvNZyjKM4nkvR2IYFx2ea3WHWJzOJVXd+ez6VRP9C/pBmMU7cnMBE3N5mG2mbYS/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734310001; c=relaxed/simple;
	bh=aQAD7CCn4NLgX2tLmruajB9GR4P4HopC21eqkDllyqk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sFU514UQvu9GkgfUIDqsfYOju7aRi5gPb9dOsnBPPIKcOLjmf1qyL91u3X0MN6U3O/OZwBb1LhCHlRV5CYy1Hd/+NeleGofofx6L7kPFUxBvYA6OwCrre/ag/1GL/EVc9GyIrzQ43Ur9mGD2j2G5QD5ZR28Puq7UjwYPfjFylCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3pnx6za; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734310000; x=1765846000;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aQAD7CCn4NLgX2tLmruajB9GR4P4HopC21eqkDllyqk=;
  b=l3pnx6zatdApZsIC55fi78t+II/7Ac6dDdDorTX0KRcFl2lp+2BodWdj
   NgKdNBk8aDFfFWIkMjfIPMWT9slF2fhPxIZf7zvB/pqyvbkjaqz456ut4
   XCILBDAtl3my1pdSlDYdV1h0cqZXfLLCkB+Agl+GXZtAligWZiMftGF95
   Eut4TIbuxEYs+gjMFla6F1/nGyo9TPhWqu01WhDWUKivMZAP+T1AL99ip
   z+gOgjzxfkQ9uElShzbSs68AMPRsegW6T4eNNXjrpx06lvIM2P3jGd//L
   0Z9z9Ots5RJWZh7FZaELUVupsKnLn9hy62MnFwGspc3Zn9njnCjR3JFnW
   g==;
X-CSE-ConnectionGUID: VyRIdf1TTsWhPFqbhXRt0g==
X-CSE-MsgGUID: QvGZTzqsRsuqBUWOQBmkQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="57166302"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="57166302"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 16:46:40 -0800
X-CSE-ConnectionGUID: 6lTBkuvTTlSWCZCSjq65Eg==
X-CSE-MsgGUID: NgJffejGSMiJXUSmEeqv3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="96949135"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2024 16:46:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 15 Dec 2024 16:46:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 15 Dec 2024 16:46:39 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 15 Dec 2024 16:46:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRF2cQJ1X4313IYQnuT83NAdF7JIh0p4KrFSCKi+7hLsWBxtUSBbmB/VCH/Ga/uJtzjLd0qS6P4dm6sHeAYdemnPtwDOQpEZzkdAGPPpmlgI9vy73S+/b61pxwfGx5XBOEIWr/BOCeWgx0abrDkZjcF/PIMFtGF2VcQP1SMBQ8RLQRRZJhmvWnxMhdVclIlvZSTjbJ+mWmwNNNhaE/LqTV0aPB+m12S7zTpjH0rrEVW/jjHDbl90WmhGR5W4Uc//9/P7t0csaEYnNPmqK4jXy6TMMagq3JY1cuTXb2T9T1R3G4z5x/8EU4vd4hgk60cqsFg25iUIRPDG3PEScV79xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3MADLzJvqrTqc637cOqenQrxD+wsqJLz/7262ZBPkk=;
 b=WzM/5+3T2NeC1JK9m50fH7giFxFesTg56bg4Adv4Jm4YpHSMbbokyv0wsWFmORWtfbhRECOag+Yj/aKinnN34pZIAFfyca1mS0Jpwb77hZ6nifUgtdUhV0z/aj9MRBkHFcRS9LDgiIMWjRX/JyziEK4iFuy41/MlvVFyEPNB04Xe9gm2/TkdZsMVU0/GGWu1PneKn+svEAPvM7KL87ZwYqT68cTRJhY3YGtK4PPV9N0faSPAHA+drHHNOCoOTspEEsWFPrJ/Swt0q2VRs1U8cLFVYAYjnLF7PkW7/Rad48azcooVTj+rOK4mLRgJdMocIewP3EqWJwFpsiCcfPCb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CY8PR11MB7921.namprd11.prod.outlook.com (2603:10b6:930:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 00:46:37 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%7]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 00:46:36 +0000
Date: Mon, 16 Dec 2024 08:46:28 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Jan Kara <jack@suse.cz>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
Subject: Re: make[2]: *** No rule to make target 'install'.
Message-ID: <Z194ZHgvlcXiA9S+@rli9-mobl>
References: <202412160224.YwRnvCXq-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202412160224.YwRnvCXq-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CY8PR11MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 367ea89d-3189-4254-ffc6-08dd1d6b1872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RP6y8t4c3GkBS2gocru3VPbMGhR2LQ3okdABrIe+AUCsyTOYIJKq2yhAVA8x?=
 =?us-ascii?Q?C1fmfNsQQ72wwKGQ+M/dgoXft6o7RKN0wsOmdxnctvp60Ng/ISgjIJTiYaxh?=
 =?us-ascii?Q?oVa3WlnAkdHa6zBf4bUVhmxZU2ITlTE+jiljoR6Zf8KzSmd3QbTtc39B3QrM?=
 =?us-ascii?Q?RI+ACfLPnoG0VYVUa/C7VvVzmd8Zn/J2jSYn0HdoLm0lPMO72Z2gTZIagOQH?=
 =?us-ascii?Q?tMrMwywrm7wDUKH6XKuMevpvZzjVNrkJ+x9jxNuPNJRERIMzk14aCrwZYNwA?=
 =?us-ascii?Q?QJbU25xrQIo9hKOApf0pfjCL/9qOtuyB5cI6dumqmMvjLd0/5xHG9UoKJD1W?=
 =?us-ascii?Q?InpKDIHwRNpAd3X4nH5mkDGO+MQcDAKjlDsyfJEEP68Nr2cmOin6A+aDTWIf?=
 =?us-ascii?Q?T64YUwaaGY6ABNvyN29cBgJWgSknBz77DrBhYT1Z1HwTMr3/aFpOLzJQDojj?=
 =?us-ascii?Q?jzJ5ltHs7IchRVgeWJn1CCFG5M+c2lkypil9H+iNVyurmCCSDU5phVa0HJbK?=
 =?us-ascii?Q?KJkqf4Zw0d5s9QZMtDEcuLvZM8SMK0n6Uc2FZQB6H5/2cq8mXeJY3YS/ORVz?=
 =?us-ascii?Q?HBBr1ZkW66XB+y8IBr4IhoZARwQBrjmXmpiQxVxQ3w3lpkJz+oXW44GbjkzA?=
 =?us-ascii?Q?q1AF62mMJezud6K7tMyM/YnHVM3Ze8YMKyjHQ3lp2aZYv6ybpaSDplLA9xLt?=
 =?us-ascii?Q?aMW/RZybzk5h2IYpUf149W+H3kBVgMRrX4EF7crlgG99HxaRQKlxAtywu3mc?=
 =?us-ascii?Q?UPg7dIOJ21miehbFAf2K6E7C+LquLQbQNAd+z0OdnwwfTUeol12pEcvED8cd?=
 =?us-ascii?Q?erBHahORog/wKLBngdpReoNPd7Az+d3ZaJg2CqQ7mKtF3KxvdEp/bD2SJ0z0?=
 =?us-ascii?Q?dE+wzeeyho7lumzAizCkVewvox7Ubi76lRvY6kCWR7DAlJuy4UlBk91eC1Ph?=
 =?us-ascii?Q?ZdBfIK9FJJTdhwoRPjKJ4/bWhE0/AS1G3lFAsJU4WYnVE7Ql4zldu+aa/+ER?=
 =?us-ascii?Q?dotMat6PQgClZIhdOa+PrEgj6932BF/OXE89iZaV3Rn8RhIpaGeXCW5/FuIv?=
 =?us-ascii?Q?07okn8YaFoLA2lGQmPlqDZd1Rr43PccWzdac1pC0lCGy8Ktb9092JUNx46Pd?=
 =?us-ascii?Q?C+45/dcAdESS5Icuwd3ll+g7BS4YFTCxcQyK3ZvmYWXS9VcS+Z0wcNmSog6R?=
 =?us-ascii?Q?Yh/OjshDz7b88qBPyM5k5N8RgXQ8NfUWEYi1tja7qkSPeJprWJbkmG8Xaxhy?=
 =?us-ascii?Q?ESWVvY4dMFuPMRrBEsp+PkR6NpKb2PeSQtKXjDDepdKKc7myuK2kMENHQIHg?=
 =?us-ascii?Q?gUUxFATQrCl8qOM54GMGc2hTbom64+GRfVo4/499P2wuqQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZlYVXKfXLMpp7djm5DT+nZxWncbM7XOd98d/L5qtZZyLxcFQiRNJf9eu41Sj?=
 =?us-ascii?Q?0CbBd2WhusTU7TSdfp67vCBVVjapsOVFf9JL94VLOzRoIxkNOlN8wLgCNZBW?=
 =?us-ascii?Q?BIUFkb2rD1GkU/iha92lPm3P3vswIT8URTTx4fVZuAUQE+D7sWQ1XaYBM/8C?=
 =?us-ascii?Q?JFV/MuwkRH0SHzTGxeOWaC4RPyhZ5INFsTi3sdHXHOpYEMBj/OY+byuai6XP?=
 =?us-ascii?Q?/ltXTPUEt/tpllWeoQT0YobyZb+d9rSIZiREVvHJOOkVtnktiFUBPNOqjfv7?=
 =?us-ascii?Q?9abaoStmuUjVMmzNBpZ7IcfPLz8PEJ7a/6tKlW0N6NYZ4RiHnBxRD8ClylGt?=
 =?us-ascii?Q?ll0ZC80glXpFQ8x0r6E6ghB9VcOJZZV3MuFmex4MNP6aec8ya2DRdm0PBivh?=
 =?us-ascii?Q?G7m9b9WyZb0HL0dDKe1t1unvZK3RQlz49FpWCztOJER7OtuC8pvyoXl3g1Sa?=
 =?us-ascii?Q?gJ8y1n6eIlYjoeFkn4HJmAVHhC95fmpiqBKFFUOrpwOYdOLQVZc/LgzetrYB?=
 =?us-ascii?Q?jDfo16F6rRJyxVLXfIVma9Dr78HpKJQiECYdviVPmPLTI/gOZyLbJ68HdZbt?=
 =?us-ascii?Q?anrwhS+pxLfzMPD+bNU3b9FHhvcWAQDHFGhDnVIi2GQnczxBKFAD2vqNG5yQ?=
 =?us-ascii?Q?lKwSQ4ANB06dLhJmYArZn7izLt53q9LE3LY+SILuT268kIXrezSm/TPe0/gi?=
 =?us-ascii?Q?w6Iay2+2cPVPBZwcm7qUIrF5ckmId+QOXtavce/kFDCsp6WLrgvqGmOM2gYM?=
 =?us-ascii?Q?4or38FRN48xNtZB0BcK/utWJBCl6U7L21NI4Y6CreChkpUvmDa7Qy3eXEZFt?=
 =?us-ascii?Q?BHuEWEUWFntJ0MuBMmD2BA9xje3XTrzAamg7WFvcuQrGjE1stCy8UxD7xX2i?=
 =?us-ascii?Q?GnuM9vW9HRcsIU8r9BalroPYJqWVtfdqkHNJ7DVJBXIQNHn2FbA+jBVZUfvu?=
 =?us-ascii?Q?sKacfNsKCgTNFqC8Pg6Hx4He9Dk5SwLxsqqghfFsuYdD4aZWir3/CO3qw6O9?=
 =?us-ascii?Q?dtTsDlJz6eQ6fbJL9PyU9oAxU4nrVn7eXrT3yqP9z0yIUjs3qsKW/9DYZ9y3?=
 =?us-ascii?Q?4qkZ/4bDDYx4ibccgf6oGx1OVSgQ41Fei4oCHV/nhX8UDmnPFDX9F2I4wYWF?=
 =?us-ascii?Q?2fWfoERirSgcrjTyzMAeCEJIp1EAU1UCefIlYSLe1rqcB45iFe5gtH0pDLSj?=
 =?us-ascii?Q?kKvtIAR8EeQyPQg4pEg7NFhkVMBNsEwhwqr2BbgNlr8yyl0F6oRQILT4UGnM?=
 =?us-ascii?Q?i7eUhajkgsTcNurequFJumHied7zi9YenoiJxbihJ7Apt79gXfBSbmKbhPgg?=
 =?us-ascii?Q?Y0ilFJPVdwuKchnw8Gs061Fm/UIWtv4amhd+V3E8B1Ft4vo6mcJTVH6lNLgh?=
 =?us-ascii?Q?h0b6nPLI22Lo8Uv7aL3wwJlC9h4lUmmiYVRyhQA7N87giKb9ieO8P7Tl59rO?=
 =?us-ascii?Q?l932DXWkN+Gs/uhrVCJSihzlW8X8sSR6dsNGJ0aICWSoc3fiPYzQyGf7to2b?=
 =?us-ascii?Q?h/dlpZssA4pvTP4e8M74BriuBRabww4UcIZYo/nfdfM1/hTKGOcwGZ5W/ENf?=
 =?us-ascii?Q?COEaifbo2MuALRfj+GCDY7ctLsctBEafVzyZwUkC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 367ea89d-3189-4254-ffc6-08dd1d6b1872
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 00:46:36.8582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoMLkeIgrcc+UN/EEEzKtVuWv11wQwSuK1SnHlYjoOQvZyuXCulMi+f5XePGtb7pc8Nc7r6RvWwUGSfEQUyf8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7921
X-OriginatorOrg: intel.com

On Mon, Dec 16, 2024 at 02:32:45AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2d8308bf5b67dff50262d8a9260a50113b3628c6
> commit: e719b4d156749f02eafed31a3c515f2aa9dcc72a block: Provide bdev_open_* functions
> date:   1 year, 2 months ago
> config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20241216/202412160224.YwRnvCXq-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 12.4.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241216/202412160224.YwRnvCXq-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412160224.YwRnvCXq-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

Sorry, kindly ignore this false positive report. We will check and fix what is wrong.

> 
> >> make[2]: *** No rule to make target 'install'.
>    make[1]: *** [Makefile:234: __sub-make] Error 2
>    make[1]: Target 'install' not remade because of errors.
>    make: *** [Makefile:234: __sub-make] Error 2
>    make: Target 'install' not remade because of errors.
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

