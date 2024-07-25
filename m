Return-Path: <linux-kernel+bounces-262283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 321C093C371
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8360AB23C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3079B19B5B4;
	Thu, 25 Jul 2024 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDrZi5EH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7852A1E528
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915721; cv=fail; b=aqGPw7jGd4Ea7iLXpXmP1aITWaqD3ZOUmHx1tGsucdlSI0NgkkIedSFbut8eWu6QFYWBgdIKN95f47jHufokbqlPXxLuLEYF13DvxxAWFmkyI2L2KWJc1alGHdS0nhZ6RwyrUCsKNVDxbbg7AZORed64+q74T6XdgNA+j7Mg04U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915721; c=relaxed/simple;
	bh=lZQZ63baFoVHZAwKrm1hWxye0/izfDa3Ob8XkXtkZyU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QHBQJL94NkmUG4NAlGwdU9hrsuG7XdGk/F6sR0wXYNoxT60k4qOBA3F/5b5ZYYqc6bVei4RG7u9V0P57AFXloGJrT1gl5oWctDYmDXLvCsd3BxTS/vzZSyhDchlaqmbCiNnlY3W/3evL/4wB1effMPVyXowC0C9uQHAbGdUkoGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDrZi5EH; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721915720; x=1753451720;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lZQZ63baFoVHZAwKrm1hWxye0/izfDa3Ob8XkXtkZyU=;
  b=gDrZi5EH8QbmVVOQOj8ySCeG1zRdEWCcG9UmzyXxVTedmXM+p1oFT+Nw
   iq990BDTLGVA+hvv/loYn0nwkRZ7El6YGjdSpNfZt28SdRUQDLv7D2ksr
   kv4rdIE5tmRmikT3Gz4g5abaKVG84yu7LwwTRs/z9a37H1Be4yC3/MaJq
   PFuLXTP8clGyoMtftWabKqicHIDLxTLgIzaAXmbmH8fDkOBB9FplocbaQ
   DkApglE3ppHfz7ood+d0+Oqm7IKYj4wFxFdUtp821GYJIFesGmRhpqWOG
   lKEbsDln1O+GgrAUopAoSE7xdvzD3UOmUP+3pd6qa+xx52tONLVrGNpWW
   w==;
X-CSE-ConnectionGUID: hubt0O+ZRQSSWIC38hRKhA==
X-CSE-MsgGUID: MwPtoCZTTaiHKK0C5F4cxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19610432"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19610432"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 06:55:19 -0700
X-CSE-ConnectionGUID: OmxfL+ypQbCAmen4TllR9Q==
X-CSE-MsgGUID: 4x1MCdBySbSw+6ekr3KG0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="57509057"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 06:55:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 06:55:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 06:55:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 06:55:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chPB9ewQSX8QmEkQr3DQlDtLJPPUY6g1oBKs7R3Mr+Ljj0/bEM7ZsIpJgJ63cYicfcYsqtyUBAeCkAcnclSYNi8++u5lhJxzft2l1vOqog08BtCGi2oxmRkMfTVuPW2fOmCiKzdOYbiVebfNGNLk71fUGyUgHGID9rN6q/jjT+tGQh4ajbBtvwHGXSoFLguKRGb6sUGrk+5ihfSHZiLMzsQLwmKyXNbgK9opxnGYFgSR8TcDslTR9PL+em+4ny8zHT7S1EZlgLZIdkdKEDId67g3z6bXeuZOuoS/QPq6LdQGbab1pHgZ/TbbgS+umF1N3MQ/i9Zmztpkhe0Dxy9pdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vL9Gt4IXmRwP8d+CeKITqYQtbFZP9hE6aGLw5+4YPc=;
 b=YlnZvVjBx9CnWWRDx+VJr2qJUK0Fj7qyewCBhAAUKdAB5aboOfuv5kpNqpqwhWsdsD4IscdEBTtwHQvCyRigMlCPcnEm+uG5SERtbOyVXnOoCg8ZXpjschHItMhaIxEfaXTIYhBaOzRRGGNYU0hAII7OzluJgN619eJLjeMwE1zw7AIA+SNcqPqxDoyOEp9I1lomBikT0DSr9fw67VsKQ8gWlO0UZjY/y1cZfvQGzQWF2HHe1I58Z5IulJQ9CO/ChtDq1eUfVSoRREqe8A4hgtM6b2omnQICPvndVFhyWBHT5jVQKFlx8V4ms6bSh+IhnHa85aHTEX/AWYhWM2RKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7843.namprd11.prod.outlook.com (2603:10b6:610:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 13:55:12 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 13:55:12 +0000
Date: Thu, 25 Jul 2024 21:55:02 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Alex Shi <seakeel@gmail.com>
CC: Alex Shi <alexs@kernel.org>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: Re: [alexshi:mmunstable2] 934c05f8c5:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <ZqJZNqq74NSAI8vS@xsang-OptiPlex-9020>
References: <202407221607.49138a71-oliver.sang@intel.com>
 <a634bf58-9195-4c6f-b3d8-468d47e71033@gmail.com>
 <Zp8h/ZZTQ0lwmcJa@xsang-OptiPlex-9020>
 <bd36db00-5464-4eb5-adb1-0ddfd3be1cfa@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bd36db00-5464-4eb5-adb1-0ddfd3be1cfa@gmail.com>
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: bebb0c47-c3a2-45dd-6fea-08dcacb16747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JUFI+0hwS4uHdqNtAicIaxNDGZNnpGLjOkfQReoE9rFP1RnxRX2hXYh766go?=
 =?us-ascii?Q?O6LqxaOLqyYdIOAAjSio1CdwHpu0r4yqTqrx33RVH5xFmmOpwq6rcCZVP23e?=
 =?us-ascii?Q?XYFC0A+iYOxS71Gr/FGfAulscGQOKZU/Ynfs4zR6ToDRIHt+kgEn6KIh1b0T?=
 =?us-ascii?Q?oZUhL77ahECjY9rFpCekmMCgzEnX7Kh5r2YEjdvjBExKMd3cQFluWmRYrpDA?=
 =?us-ascii?Q?Ouhv7X9JUpn0/y8KrwblpzvJboTuT1A6NMeM5yQhloMLhpPauXmaH5DIb2mB?=
 =?us-ascii?Q?Vd5xajfSGs3NodDSgtipAxHNwFvnDraGyhebs01KIEguwDHcFawaOc3w1JM4?=
 =?us-ascii?Q?hScWXjZoj+Hurir3uCPWJwLoL9Sk5HGlsn5uFzbm/AIYzdAGg9F+4KNfBlBz?=
 =?us-ascii?Q?PHBCYXvrW6HnnKPMosOnkugkDh+YvChK26Bbc+zRkbRl9oWMGoNRcQShW+xa?=
 =?us-ascii?Q?QJ3nhqFcOlwM1BunViO2kIQTQjYR4JpJsGeg5ZBS/Ux0faj2TReKVemLt0U2?=
 =?us-ascii?Q?vwPB110VYMx9xE/uOIG1Yjp5adMg8CQnbQyXfBRpdcFNlcyFydL3Ahbwoy1q?=
 =?us-ascii?Q?RZm/nyjuHzf1qUWv/b/mQo9sSJulda5A9E8xfe7ekXZUV7/lmogG3ipqUeJP?=
 =?us-ascii?Q?cwM4TcCF8YONigsL5JXD4temOgjjReQIecjq2G5QiuwRNDP7gemsl/LRQkHd?=
 =?us-ascii?Q?gBOZPoud0rQYvW6fInG7xsWjBAGAbxGXfRc/PYr3TSU5D98BYYpec6lJFydZ?=
 =?us-ascii?Q?qx/2kM9zobpzeQ6JPTQrx28qzWVXOY7g7d3J1tJVMOqmf73HWfhC/ZD4m2oI?=
 =?us-ascii?Q?qtJ0Vh84muXSiL9ABhU86xSp1EiycLn/NSLYCfrZxlmqEKpdzX3WS0LSl6Mf?=
 =?us-ascii?Q?rB0E5tzJLXDBOUFSLT03EckxZK/AY71LtHyR71YB7TKbzk1bnEIZ/NFoMvn3?=
 =?us-ascii?Q?Dt9zi5MqqmOjq110TGLclvB51EUnTJeWcp5mAeITFbYeVnxcMLoCbVIJ3U6D?=
 =?us-ascii?Q?UONzEh7IbNQvRhAwecgndiAMTGeq+7G6yL74b5y6azg6+UEIPGqP/k99OP0n?=
 =?us-ascii?Q?APF/6eJZ9BSkYllNsQY+gtqmZ6poasZF6/uYuSXSqypv3lsN6CJxSGWMsbGD?=
 =?us-ascii?Q?GfuDz3zQbcfNd5GvuPPMmh9G+10L911pnrFgzPEh9eeKmbjTNh41NGCnrr/+?=
 =?us-ascii?Q?/mvJhg4CZM3+XwfXbtJjCPpoBxiJLyiX9jvAg9z5wEAzbxxu+1s40CHoB/TX?=
 =?us-ascii?Q?Z1lJQKH2k09sJZs8EG10HBtR5a3cu+D08/WwGpfmMHBbsjxvXDGcKDilZ3Jn?=
 =?us-ascii?Q?G9M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y9J7+BDYbpV5+B8QYobDCc29mjQ2gm3tsCWj5djlqS059u7QmKkI/YyJjkNw?=
 =?us-ascii?Q?urc9zJ1gUXIxjhxqtpGh0PZZyIbU5gz6+2e2bXkaZ4wrf/2XfN5vHYHU5Yd9?=
 =?us-ascii?Q?tOKVwiS3mzCZaib78VkXkJNW+oPKxoX1ya/HeECp2n7dx63MvuCxhY+NBzlB?=
 =?us-ascii?Q?ziKsM1dwQF+NyzTq5Fj84D2z4vjLGvSC1vQDbCd2ci9Ko/UhTa2HuD7s7SRG?=
 =?us-ascii?Q?YAKJMhv4rwDQsiyyp8wii3GqZq0k5P/LoXS19XJHaymhVxcjJqGZot+XZX+U?=
 =?us-ascii?Q?vQGFhXctF6yQTikf6qS9iqRrcsTW9dpEGp6fzpJcK9bEb62eHMBSOTwcHZW6?=
 =?us-ascii?Q?UgPg91tLZQK/QCqt7xUT7dTyTHzCXu+P/f9JrZbOtFibs2pIFQjnl1sOBefP?=
 =?us-ascii?Q?p0Kg7nVfZ5dThKHuKTKgMBMdUQEFqw7slvpGx6dXjxgdwnJ8CZ+FhSb+KMYb?=
 =?us-ascii?Q?ZsDDmBI07LrKLJ6DS6ZCL2zL08sH33HBV6mCxnMwKiNRUMMaFK/Q4jDIpUiv?=
 =?us-ascii?Q?yrir+DYnxDdl34v2mqyTgWJ7d+rb5D454+0Zb4bVTq67OZvfRerFlEfreSIY?=
 =?us-ascii?Q?qYA4AN5/df6Q2Qmq5qgCR6yAw8uFr7Sfx8jV34cy2Vsd8AOZo7+Az+zKTxsF?=
 =?us-ascii?Q?/7iD54SuBVTSj/JMAV6WUbrk9ULKBsQfO5oEyh9UlrYjbBt17hfldNOY31HO?=
 =?us-ascii?Q?fkDvFMYfTSkrafqT1YMJXTY/BwObC9dQjvVTQxWoFi2D/UbnhdSVhOJUWsP7?=
 =?us-ascii?Q?754+WsY8sp0d3CwnhFKAdqMvslw7Vfg57krzy8FO5/usKZ3yezYARuvcyCVg?=
 =?us-ascii?Q?vTRuW8Axht7fbgZV9NVJP5b6yTfQbode013wt+1Z490tpwJ3TWt20tIXyLog?=
 =?us-ascii?Q?W6oq+VFteJAD1YCJM2vitci9IcomUwA7HRM+XEcxmjz0Bj2C5l1nh28bKdWk?=
 =?us-ascii?Q?kI74VbdUnFmfCZb0QRyltnMWKdQeaf9JHAKnSMMpdo9siWrLBkyH1peaYPy/?=
 =?us-ascii?Q?bV6aHTE/GtW7NyxWsO8Z/N0B+AjIYdA1fuBHUM/5vDRvtdDpbd8u/tm31aFX?=
 =?us-ascii?Q?43HqIisqbx6B+9sW4kOfQ5xKVkeSNveRCnFDB5QndJ/4+h6b2bRIyqkHLd8P?=
 =?us-ascii?Q?tHx3oD/oKvXNt8XnfInofVzzI+rRfQWpoFl7ixwiFb8uKQX8Z/K1sb4azcIb?=
 =?us-ascii?Q?1JrgWxWKV/KSaM6qMPfsJS9+sy5r1U0NAm3niB+ErZ/o/q4HnDjxX/JanWrO?=
 =?us-ascii?Q?Pr4vh6TamxaT63J6kfkpLCt3lyQPcS56PSf2WaiUefqlmWu6TumJoxwWrrDQ?=
 =?us-ascii?Q?Vt1mgPpdG/ujFaAo2izwFyzZcGvlgkXSkpuwhcQGFZ84nhhRy8EwnkDc1A7M?=
 =?us-ascii?Q?ErGDc9F9I2rApwhZbAh42niMZolAlEqXCtYy5LA29dOdCrM1DicUXeBVQ+wA?=
 =?us-ascii?Q?H2hlvFXisbr8/ppUtWLSBAts2VWJV2vtMGq/G5PdcwkpsxmA7C/SoRc5ha+L?=
 =?us-ascii?Q?kQy6YtQJiTNrRKgdBjNF8CvEFmMZIShbu7oouz9/0SAYHIKYDWayKq+C8QOQ?=
 =?us-ascii?Q?CdMxM3U7iRs7aMtgsQh6Jjurg1JlHku2OmFxsPZleB7gGPgfwq4agzlUphg/?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bebb0c47-c3a2-45dd-6fea-08dcacb16747
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 13:55:12.2456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REmiDwdzNI2YP9Es8Y8c4PKxW5s1HxwL38ztnVeG5DqYxnlOL9gndmEdQkCylPJpdeBUgDt8KcV+og545gmcdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7843
X-OriginatorOrg: intel.com

hi, Alex,

On Tue, Jul 23, 2024 at 04:23:00PM +0800, Alex Shi wrote:
> 
> 
> On 7/23/24 11:22 AM, Oliver Sang wrote:
> > hi, Alex,
> > 
> > On Tue, Jul 23, 2024 at 09:58:25AM +0800, Alex Shi wrote:
> >>
> >> On 7/23/24 9:05 AM, kernel test robot wrote:
> >>> hi, Alex Shi,
> >>>
> >>> we noticed there is a mmunstable3 branch now, but there is no same title patch
> >>> there. not sure if this report is still useful, below report just FYI.
> >> Hi Oliver,
> >>
> >> Thanks a lot for your testing and founding on my unreleased code branch!
> >> The problem should be resolved on my latest code yesterday.
> >> But multiple archs maybe still are fragile in the branch. Are there bootable in virtual machine, like arm, s390, etc?
> > we did boot test in vm, but only for x86_64 or i386.
> > 
> > you may notice we also send another report
> > "[alexshi:mmunstable3] [mm/memory]  f6ba7ce983: kernel_BUG_at_mm/page_alloc.c"
> 
> this problem was fixed too. Anyway thanks a lot notice me of this.

thanks a lot for information! just was wondering which branch contains the fixes?

I ask this because we still have some bisect results pointing the commits in
  mmunstable
  mmunstable2
  mmunstable3
branches in https://github.com/alexshi/linux.git

are they still useful? if they are out-of-date branches, we won't send reports
to you upon them. thanks

> 
> > 
> > for both commit, we made some further check and cofirmed they cannot boot
> > successfully on both vm/bm, again, we only test x86_64/i386 for now.
> 
> Thanks a lot for the info!
> 
> Alex

