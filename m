Return-Path: <linux-kernel+bounces-250928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BCD92FEB6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF45284186
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F9B17624F;
	Fri, 12 Jul 2024 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnSzEk2u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26DE17624A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802539; cv=fail; b=Oa8IULtQpMR17Z8TMBy622HLCcSl7UPvLv/R4vSukHaBp9/lN4zQXOYGIm+YX7s5jF9P7Q8Izp/aJtW0rtDu73GKyKURvb43k4Qs3PApTDSCoX6tifrd4FFmUyF4ghcEwefoD/iEIB/rDsOVbcKbviQSxQPQB68SuYJl6fNQPq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802539; c=relaxed/simple;
	bh=vFPMJBLhPQoJCubw98iHNP90uPfh9D2lJwoyok5s7QE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t4SFIIdjlEquylZgB19XMQ9g8sOj03FLfSp8b3A5AlnY4orANt0AEMVqOz0nhdcym29+hnhcYISiAQtDTxU7EuvlkZzxXGdOJafYaMGwmtaMJ++CytWhVJ6GHobGYmJ6LN+/+SX4DC6j+Sm+W/U7cdhE8FCXgLPbsS6Txj1f4vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnSzEk2u; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720802538; x=1752338538;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vFPMJBLhPQoJCubw98iHNP90uPfh9D2lJwoyok5s7QE=;
  b=PnSzEk2uHUxbadYyNcBE6QzEI+Ke75XUOJoBfc/JvJbED9OuT7jIv9Bi
   XKYZI89PjjkHu7fpsCTkV9ijUiOEi24vJ4w+ZOCdcKnQv+bq7TTxOQfSc
   dTuFErfAFU++ql2bQqe1f1UYLq5+/Hf4togkRFQ+UXAyB9KTnJJ9eUXpY
   S9vjxLEk0BRmHTjYMIQbwtHmk9J3zCJnUgIG7O+yczG5AAx7CNbGChnkl
   qtHCBX2IxP+vpUiyvBk7daPL3PbI/di9NOpDkHng5Xyj9JyVNbwJFPRA5
   TfX2DPOx2bx+CfG5LPNAgUS/LUH6+TAvjFGtTmSv35QAOqvwJPuuLtiVi
   A==;
X-CSE-ConnectionGUID: XBJMX+KdQGaqiOMDVqnyzw==
X-CSE-MsgGUID: D4SEJxrcQeOjNSY4P/ofKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="29658660"
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="29658660"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 09:42:17 -0700
X-CSE-ConnectionGUID: rqq/UlyvScmd2UEAIYLWrQ==
X-CSE-MsgGUID: maTYai9ASxCDM3sbWP7Hmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="79663745"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 09:42:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 09:42:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 09:42:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 09:42:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQHMGkRN6F5KeVscRg/sKLV7nK7lYFNX4MKGaecvJWzZNy36ipMolNs2hTEPxBte3dRyg3UToVjSE36G1soFNEKVWRjtge+B2a/VKuN3DC6RHVQyqsteD7q+S87T3/vtWJKLJwXn0X2kAkhlL0uI9u6CypVUlXE5RxLvg66/nIWpGRvFNinUhA9aXiBLFln5vB2wczGPavAna8DwiC5nT5QjKj5xTLHodw1H86TgNajhg0BRL/xpb0DA84Lg2z2gXB/P7/6Av/GqvCftdSOpwE/UC3hDN7OfrhHaqRkT5y/UWZ9YYKwf21AhAqaHoYKKqyK1cNnR5dVoGJs19saWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnydsimnqjjroVMv7c+H+svHY6fAVRF/osc//WLTFTc=;
 b=Rd6UMlYS6hnImchK30ZLCpkExcaJ+317AfNfWNxwEnXc0n0hAq728tYVn0U6247U+oqsekNfE+wEfQhMOjoIrfeoYHxB0wMxB6MfDsJzsm+CNUroZp5T6x39JkXA0W9CZboLQyRMweRqq/+zhNOykH759itpXarpVl8EjSITNNUzcx1WsPBWCAcl1UzJEUiDP0f7AN76ANtj5oVNu5T/n/oMpAtOl61RiC3wMkEwW6Ut/7lOH9cREHTgqgQWVMjZVHxNGOvMKT9W+HBecR6cTAxjZSICM3XoE6fIFQcU1ZkxIyfn+LpmSctU+4lp1vkYJ7ZvYmssdMyo/fiwjeQ2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.20; Fri, 12 Jul 2024 16:42:05 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 16:42:04 +0000
Date: Sat, 13 Jul 2024 00:41:51 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: kernel test robot <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Ingo Molnar
	<mingo@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Qais Yousef
	<qyousef@layalina.io>
Subject: Re: [linus:master] [sched/pelt] 97450eb909:
 INFO:task_blocked_for_more_than#seconds
Message-ID: <ZpFcz7s+R7ay77Js@chenyu5-mobl2>
References: <202407091527.bb0be229-lkp@intel.com>
 <CAKfTPtBMdLRN8WVUmvXXZQK5fE_rZEFJenujrxpqWYAQ7b-jBw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtBMdLRN8WVUmvXXZQK5fE_rZEFJenujrxpqWYAQ7b-jBw@mail.gmail.com>
X-ClientProxiedBy: SG2PR01CA0169.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::25) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MW3PR11MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: 3baa75da-3041-4bed-81b1-08dca2918fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0njbWpFZtm5C/2AbqpVgc5ubpQKdLgTNye3o0avnCctpG79X2P0hhcOc9iNj?=
 =?us-ascii?Q?KoXv+GOCbIJGshAzoeCOzoitsYPjPlZmagC5mTN82MLPK3KSp+WCp1RksLyt?=
 =?us-ascii?Q?h7JAkGjFhkTDw68ktJ4AWZqkUYqyhRyvRCxSdCR+sWKzvcRIiyE2CFBXHCek?=
 =?us-ascii?Q?qWLutOI8IHvqMeE6up8v6TjvUxvphDa3mY5s1WXuz42gWbVct8K+dVdPYE80?=
 =?us-ascii?Q?+N/ITVdnCmCMI14jwM2zTrHOqd47OD1OqIIix421qRvDtwjkEaZRgeLNvOXc?=
 =?us-ascii?Q?oplonnA/bCOdLKqB4DRAC9fTtIFINCpoJ7ttDgSPekEXoGRfFPouxBs9LGaC?=
 =?us-ascii?Q?zTpvLsR8o6Gk4uIJoliHJC7e7y/kRiPM9dxXBKNtOR94YPtpn0zbHIMSVq3H?=
 =?us-ascii?Q?nH31ryWInetEPMWWWvXQOcXV3/Vkv1jqLmQJ7/9UutgHm3BNe9FeewDfFJfJ?=
 =?us-ascii?Q?+UX3c7xS5qMheJos3E7eJ45NS2tKH8EBP1fRdmFoILhsl7R3pSOkb2kjT+E4?=
 =?us-ascii?Q?U0BgpnH5EWSlu85GVtoNktLQSNp7864afIaVvSyXzDP8DiUOqHmPtsUf8BPi?=
 =?us-ascii?Q?WzHYFjmMKUGHdw/REBlgMjN62GEZOEHZUWlB8AtTXsVTvNYGRZWrUx8taCW2?=
 =?us-ascii?Q?PRCc2DTTRgPLgmCsXAto+lXd/f/YQ3zc9nBCqek9mdXqp2+UUCPoTEWs14ya?=
 =?us-ascii?Q?MW2+mleZGdzBtPftLOD2+Rd+Ctk/ndJtciuVfZaYNX0EEQFfBIt8lffW2ZCA?=
 =?us-ascii?Q?rg0AE+vScqGBNbsuSwwqSy+tkJanNK2D6f1VPY2ks4rRWqsZCPlqfms8L1BV?=
 =?us-ascii?Q?BoHc0mgsTE/ZzPtXAO/0Fyqr8bkiUjmpTg/tAdaC2uPs38HOZv8BlcZ7hjV8?=
 =?us-ascii?Q?0HP0/AOLorIo4wumCw2YWD+TLWLYIJfEzAe91C896sJoVLGjtlFFonTkVJDJ?=
 =?us-ascii?Q?AFhfQZPSfajAnCKUkVF3R8cXNDikXgJ5I+Yu0y1P9eFOQb9eubpimtlvBcsa?=
 =?us-ascii?Q?HcXkBbhJioBMqY0nUa+m+KuqiPnREQ+yFofJg9hVGntRJvyAZpPoCrixkYkr?=
 =?us-ascii?Q?nXPcV/+yjFhu1kLlhnUtM2uMOGf6ta0Kms0dCSewiozgNsx1udFGM4gqTY02?=
 =?us-ascii?Q?V3ojpEIxGdwnsODycmYeqe5W5dR3kGEeIAVQ9juQIlSEUU8eQdnTl768OgDW?=
 =?us-ascii?Q?jF8TZNXoa0qWQ3C5Dd/PUdVrUvGJnK8Bo77Y7UxoqA1q0vJL6KXR8bvIb22N?=
 =?us-ascii?Q?WILXQgJAjMdXttChW/MVzYqkeP9ZU30dKDHbzZFCMbb0V/6AITmMLpkTQzic?=
 =?us-ascii?Q?BEVKbe+WpWyfiF/rT3aopvDB5eq3ww1d8O9fbm6kc5XQlA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ErhtFBQ9DycPevP84R+sAv/dq7huUJs6XXP+DfvUhQpdfRH2TXbGILias1xx?=
 =?us-ascii?Q?TM29VpuiBbizQXnA24B8XebG8EbMUz/Tqv3uGf3JcCJ/2O1zJetypjFGBoom?=
 =?us-ascii?Q?DM3IBdVXPQfGsd7nQI2fGJMUC6It1XdpS7KXP2GwOd1NjehM30VMxPyZCgXB?=
 =?us-ascii?Q?55Bu2MBRdgJ3vCr+WvHBxvNjyffQ9SCUbDHFiQ21u6f4YQxHOrzURJ449F08?=
 =?us-ascii?Q?p6sye0VVGzDbbTFqqUnQDSGvogTGKC5QcGoprST0FvM9wa8RbP3dYCh5m4oC?=
 =?us-ascii?Q?TuobBrhXx8V1wED3hPGcJ4LK2OFnCrcPITpl+WQxDj+Md4COK78xH9c5qaEl?=
 =?us-ascii?Q?5UsO6UjlOsrRRyJMIGZLKezqJ5AAN9WdxnbHUxM861zNBeyKPdet23oaiDe8?=
 =?us-ascii?Q?keGwwTMBEEdfX3eejskaII6pTIMoYBdP8lMXoYo+p1HCF1Z+22tPAt5BSYui?=
 =?us-ascii?Q?askJEaNhC2u4SGwmx+LS8Xjl0kde42cnP4glEryNih7K4Lff4aIXCRs3GroA?=
 =?us-ascii?Q?8b5I+hMzkMW/K59vpkx1AC2CKObOWbwdgArHsAmXmqduX4RaZ4d1HseefXd+?=
 =?us-ascii?Q?TquEVwdtAlu6GA3G6plINiDpYWbsQfSgku/pf/H5I8thnqauMH1eXW9+uFj3?=
 =?us-ascii?Q?/iXmM3+EhrgW+YmgrD3COcs/dLc4bVuA98gniRXjqlHNNam02Z1IZLr1FJS4?=
 =?us-ascii?Q?XNJyOE5sUk9T1HjTJKc/Do/vmK76gSY+B3PFMTGyfuU6qlGGYNlTOOMWMfRJ?=
 =?us-ascii?Q?j2cA+72b0B2Z92UtTnOPpwjb5buhChjY85DhIInlJZCakOkVcgjJm8/ftugb?=
 =?us-ascii?Q?jM8ah2LRv8+mhDtHulFpi0aITISaj1G2gLYP0fwH3EjYJqBcNgn1WCmJiQu4?=
 =?us-ascii?Q?qkEHCG3AuxZWVtTqQmw1fLhDUbR4QPJLp54QR8pg4a+4eDxB5j7bwwz7bw7M?=
 =?us-ascii?Q?p11rH43A8xipFP+ahL7BMOHG6GEG9ZtdM9ImsIhWSPK1x0avklsK3TTFTlJA?=
 =?us-ascii?Q?XyzWVobbjR5wNAbwhuJBn6GHBvgM2g8GP6H436/DFdlH8ihqq4XBDFv0Lohq?=
 =?us-ascii?Q?ZZxtIyZMFw/h4rwqUHDfkY5Amy/zrKvmvcEBeLeXyulmSOsQV0aKd0Tf3RXB?=
 =?us-ascii?Q?YOhjErOHmmRXN3ZwAaE1cA7pmGqkncnE8hv4SqyXnPQyJbCzQj3FlZ+r55ye?=
 =?us-ascii?Q?iqwY8SuIxfcKUk5nWbCzuaEUy60MLiTeVYIiu0XxesFC5zC4+qJEbI87lILQ?=
 =?us-ascii?Q?r0nSmcLMznm8IEqjYwd9P605kXct0/U5tlgb09NWCfRtu4BwbKycJSpmrdga?=
 =?us-ascii?Q?Pa1SNRYrZ7Wz0Ev9MQX0SfRVElnfAQPuSUIvKxoL89F2oXV++C0oO3yeT5tS?=
 =?us-ascii?Q?+V5z2bnB3D+tXpcvHw/seYVf9er2G6QXx9QPcBqVffT4H6UvhPZ1vLFzldNK?=
 =?us-ascii?Q?ZDNvhEaVNOZfRZ9Z3J0sBBVWt9Nm4tU1xcpB7C8l8HdZn5Nv+p69UFN4UFYT?=
 =?us-ascii?Q?REJRJG7eYoImM0Z1a0S4n2HRA2Xy0lE6G/aZE9s/1nZCblaETNv9LvSjI0/j?=
 =?us-ascii?Q?xYmEyvLz9mVKTSI4eo1kumJ76L2S7hjoUrA8QFLd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3baa75da-3041-4bed-81b1-08dca2918fec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 16:42:04.9367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GebnbVie/hPRuyaTHpGys2DtbKUTapWlS6kahhW3Jee4ViXwt2h7sHzxQ4DfYSSATe5k17Sm6GW+3MivJUswsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4539
X-OriginatorOrg: intel.com

On 2024-07-09 at 12:03:42 +0200, Vincent Guittot wrote:
> On Tue, 9 Jul 2024 at 09:22, kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:
> >
> > commit: 97450eb909658573dcacc1063b06d3d08642c0c1 ("sched/pelt: Remove shift of thermal clock")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> First, I'm surprised that an Intel platform is impacted by this patch
> because Intel doesn't use it AFAIK.
> Then, this patch mainly remove a right shift i.e.:
> instead of:
>   return rq_clock_task(rq) >> sched_hw_decay_shift
> we are now doing:
>   return rq_clock_task(rq)
> 
> Could it be a false positive ?

Before trying to reproduce it locally, one question is that, should we use
rq_clock_task(rq) in __update_blocked_others() rather than 'now', which is
actually calculated by rq_clock_pelt(rq)? 

thanks,
Chenyu

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d34f6d5b11b5..17ec0c51b29d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9432,7 +9432,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_hw_load_avg(now, rq, hw_pressure) |
+		  update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
-- 
2.25.1





