Return-Path: <linux-kernel+bounces-270816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD859445AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03391F23F32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEF416D9A0;
	Thu,  1 Aug 2024 07:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JD2GUNQo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E911607B2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498019; cv=fail; b=Z+eBugy5H1Fd+OraxY35HnqT1S/VU5pb1DXWUhMdZrSTIFVDOrlf96Z0rQHfOyOOYRvrVkBwp/5j/iJgsuU/VaFooC/z6RdpZJ+wM8KEJhoNynVb0crHS3ERfn0/e3+G3KEAkHtW2m8Kz0SJJ6V5Vo9irvkOqwalqwaWb2sRoow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498019; c=relaxed/simple;
	bh=jOWXP+YVPfKKZXKJ0ZrAIAFDvjLC9Dr34/lnWDCW0r0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KyDU9GLshWybyc26qJFbxw3vnRsRKEyY0M556Z955+S+so75CjhM5/sz7KOweWVPEp0QxKqZlCriJONuAQQ6CU6kjlDmFo/vagtNr+fgClFJChwPVofhdKuoq0cB3cifil/PP+R78IuVBET/meHan2p02oV4xW7/gxwCvA3rYMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JD2GUNQo; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722498017; x=1754034017;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jOWXP+YVPfKKZXKJ0ZrAIAFDvjLC9Dr34/lnWDCW0r0=;
  b=JD2GUNQoM9L57wjB2eyFjjnLZGv7mDZ2AhPzSMjN9Tmy0orRySwdO1Or
   jvE76G845jsJEox87s1m7yS6deSd4r5EM6ZmOH4CUSgqm/tyWXDnXZ/8H
   Laq26F8qLqx3N3OsDgMkSajoAYT+wTP/6Au4/eZGQPXaDv5aIxt9aaSsf
   J4glFWpyYV8sHQ0ij+IkgC/gjw9Ga/xmqEH3+K5QoFiF7zyi/8gWL/46f
   6LESrluQhKF/zdh9IvF30DSD/+O+VVDd5AqeHV2w9umQF/HhFCQpXpw2Z
   ZojT7lngiPGARAGIgIOlTT8+nomo63aB4djk7xg9J8DOEcLwxQUJkpATL
   g==;
X-CSE-ConnectionGUID: 84eORcPQQyaFuTrmkUzS4A==
X-CSE-MsgGUID: 1hIyrlhlS3GDwLZYuEy8kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20114674"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="20114674"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 00:40:16 -0700
X-CSE-ConnectionGUID: VXybFjjaQs2MdEknaFgyhQ==
X-CSE-MsgGUID: uH6OhHTUQ6yWSP+9Fye3WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="59757570"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 00:40:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 00:40:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 00:40:15 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 00:40:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGb25VDoc5vR7y6JNKegAOGgkmUsgRGxVzQojVFZZEQ4MlvIbmfo/Y9BKA30WCGkW/mEj+DiiAWF8+1kJMzMYu49bzYsFvz3GOezFkUVU6IA55TK2cdOVg8DWY7toaIl107HJUtLiqacZxStv5HktvWKTSI56MswhMCatLjLN2+OtyrR1joD2/P/7cc0U6RYaHFAuNqiyzwGTxwp8vpq718E/w4//ZWjfMp6eEJf8twywMNEjZWb/WVKnnZ2TvRJdzN3dlk56UyJ3Ij+rPkSAPxWmsvLhpgOOiJrl8yHULbQ8f6bEJu3A5cIabwx2qoI9Z8cqrI2d3JcFZuy5zdahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvI87un4Ok5gBT5Vv2my7MMO3gtdhRQdNW4OAc0Yzj8=;
 b=may3h/WNu7X3OKXJSfYi8gAuUeTFyotosXf6BjJMTNlHjiZyl/DnTjhsrBHHDKjNqNBHBVJYXJvmAaU1qXTBtUHcc3iFOew2nnjUT1fV14KjVXsnxya5nPNd94BIYZA4o6fPFmEcnq2uh1JOPyv0nQGDV8qtuzXSuxQYtn+TyAbjTFwdAppqbjo8RNDeuacW7Anx3asYAkw0KdsKgzVQ3vUoL6L05A2ySaNdVwuTpdTA8yI36dgP52RINrHVIiisb7PZSg3uFrI0r4xc+EYxWWhiAHhYTIZdYf7MLndfk9UF+VQqjpkpfZDx9P7imzxMnuJ0l3TJ/JrbLnHK4LAwnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 07:40:13 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%6]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 07:40:13 +0000
Date: Thu, 1 Aug 2024 15:40:01 +0800
From: Feng Tang <feng.tang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@intel.com>, "H . Peter Anvin" <hpa@zytor.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <x86@kernel.org>, <paulmck@kernel.org>,
	<rui.zhang@intel.com>, Waiman Long <longman@redhat.com>,
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4] x86/tsc: Use topology_max_packages() to get package
 number
Message-ID: <Zqs70V2qVGfzFsoG@feng-clx.sh.intel.com>
References: <20240729021202.180955-1-feng.tang@intel.com>
 <878qxh5r6w.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <878qxh5r6w.ffs@tglx>
X-ClientProxiedBy: SG2PR01CA0161.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::17) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: f7350c1d-542a-4779-52e1-08dcb1fd2d9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EuknqJazzN3wSuAJpYHHji1Ud57xSHfoXwrQs/i+sflnAThrdTx6S3TpBj9y?=
 =?us-ascii?Q?4DpVFXJLkaTMwu2zdOYsdJw9Q3aySE2+jChysAyANvXHjWPLubxaNjwmfbHB?=
 =?us-ascii?Q?cI9MH33GQKYfU1hiQjQv9IYBjUWf2fSZWgZItKxaTyKN1Xc3ji8K9aNROloK?=
 =?us-ascii?Q?8KSDbWPEXyf+OsvrEX/znOsprIvG2Rp2ZfzEhJMd6fILNbwF7WI/lxe70kXw?=
 =?us-ascii?Q?6haYKKM4B1uGYdid7SXcYdsDPZ1f+98O8I8URNWUyJtxtSmMGNoeHpwmTnVH?=
 =?us-ascii?Q?rdCKdNrXrhbcO6S+Prx1spm4T6xxD/wdvV+K0finzr8ErcPtmmYA9TneT3gJ?=
 =?us-ascii?Q?WcmifU567g5VZDpzAsb7p7F2SD+f5Ho4eTrNmJUgVLHPFCxne2n1NxSt+Hmk?=
 =?us-ascii?Q?T3NH6B5pRP6vMnbPk4K9hwPk2c4Se1JkVdcOM/X1x18HrzPrBJnL+pXCQQ5N?=
 =?us-ascii?Q?aFgEDcFRcwmc0Ax1YPXfE9mRXj+qp/NPeqj3hv3pDZwrqBYZ9USZSU1izTh4?=
 =?us-ascii?Q?QFztLnSzi9wk0wAf8UKM4iB7exWM9CphhryE7UI/iN/2bn0B9LDIhngotjR+?=
 =?us-ascii?Q?CMF6tPLITTaHFH5nbCxucVRe5ouyfJa767Dv73tU0DV+6sDhgrMT7FG/g9Hg?=
 =?us-ascii?Q?sqv3X8CNGX/rTETbYNCLznBRKwfjK1+uCPOileykJBgYKQuvavqkXH101IZv?=
 =?us-ascii?Q?9NKQDjZ1TXx5HyVylzisickjb5SSDLh9aSnqJafIrGAJCEp8xnsRnwB/obto?=
 =?us-ascii?Q?ofiIO/dEmNFpbo6dXZa8hxpK6q63SZj9KeKuNr8547zDcRvgNca9e/CISBzZ?=
 =?us-ascii?Q?2jWfQccDf+G+2ryInUfcXVlgZBqkKx4h9Ohe0bLTscTWERypvwKdPZ5YVMam?=
 =?us-ascii?Q?XTSB1b7Wh6tve2X0C4b03kMBkwl04VK/ha2n6/7UFOq+BU6Q79tZOFgZkPpN?=
 =?us-ascii?Q?0/V84zW245q7DEzlRrTtUc6yMNuMDqRiZhe6lv8H5ELKGjVG8Hz26jBnyR4y?=
 =?us-ascii?Q?Ofw1bFiK6WEADeydWDbC1WDZ2mNCpTm5HQ/JueTh6wCCzkxSZ+7fB9PQUUD8?=
 =?us-ascii?Q?My8mvyVGiu8MZj2ujpDPOJTuJORaoDT12VA+JqJVmtoze8TcfmhGXB1lvwAg?=
 =?us-ascii?Q?rbCfJG747Od7zZ1HW3UcKrGZK61+J7LdmIMdf77n2TU1ojigVgbFyicnsf5d?=
 =?us-ascii?Q?Jt3moPSJqErwPMc9DdJkrEaU4GBw/fuucc0LAoJA2MvVQ7PWQ5npK20kppnz?=
 =?us-ascii?Q?RzmZ+q2PsMuTt1Wuy4U84SDqJMguUPUDimFyCK5TxrQpStY2Zx4hV5Q4xeC4?=
 =?us-ascii?Q?YxWMjwSnYewF6+GAkzu1/t+uCyfIEznpWMwfRyjiw3j75A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Zjv9SsD6lAADd0W6mtSZsSQ08zjGvb0+deodAWoCczuF2k/felHY6W9tEKv?=
 =?us-ascii?Q?r8ApGhwXCLiRh2ciftWItJLiEUlkHm8rq0kSZUynIqDynx88fAF7to5gcccc?=
 =?us-ascii?Q?kgSBD3LJlZrwiEmV6xWz9Rn3SDXahzswzKNFEC2CMAVFgJcsF9whyFyEfKsR?=
 =?us-ascii?Q?2FVrBV20xjqRjm6y1ewMfGi+IQYup1biI9EkASJbnBAKNHNpRU+k4k3UP8zE?=
 =?us-ascii?Q?2NtvB3f6E0klBTbSnEYX4Sx3k/ol5R+UVHE3Er6LStN/P3wWrg27/0y9Ilka?=
 =?us-ascii?Q?LlZQCv6JaVn48/d8ZfLYmmrJvVObYXhP8Q+GBcwQhCqegeeJA3vTxIWcLbz6?=
 =?us-ascii?Q?BGhpNopy6lvDjFZssS6GgwToppzBDz1LC9eGS4SO6vVFlRdPGDY56nZQyS8X?=
 =?us-ascii?Q?9kCFM8d0t2MLUEB1QagSGtTSGFFc72oWGFLzfrUpvb4My2N075GeKRvAuolU?=
 =?us-ascii?Q?kjmLx1VZtiS/71XW7LSAo00OzfYGStGlHOENc5gBELfZgmrWhjzohZb6pPPQ?=
 =?us-ascii?Q?10LDKI8snm5/Uv5RULHEkLgUUW/Q9hOj4D5YuLsgORf+w3lwo0uSYfPn392v?=
 =?us-ascii?Q?CzlVljVBTmQT0Hwbmn9+mQi8o2ntg+34yglNRz7/RtT5SmSi6BnhIbjxZUMI?=
 =?us-ascii?Q?KDXZiS2mLWsHh2/vcpJb3XIZHfilXlsMjTukOazjE3AhDy/lsiVQPbHzfiOl?=
 =?us-ascii?Q?DxmKNJNtdInARX7zmQLnWPEsjgaK6KjvNcXv+F++wSTYtyHpIPd5I/lLYgs+?=
 =?us-ascii?Q?UHFnrVdfDHOUr9MuaygsWOGV2LKGFC/3FqRQSw3IaSt20B4FjI4buFVJbu41?=
 =?us-ascii?Q?xSqhKB5holUvGk7S4ukimQVOj5IBxtJRrfAycukc5E6irCdoJL6PI1r+N4HN?=
 =?us-ascii?Q?YCViQvJ0BFZxYeXr18HqIbxwyKq/KzKTvclJ0xuZYQiBdCReH7iiA3nWk3FC?=
 =?us-ascii?Q?M7Y6QQ/ofaG6NE9rc4IKSdXEjl0LkDceiPYPrvOcZz7TiizAx5PlVxBu5Cug?=
 =?us-ascii?Q?8PCxK7GOZyRTvpVm5xtSXz023Fzd/i2vhEQumgOy30pulygx+OvBvbixNteO?=
 =?us-ascii?Q?GPaQyYmT8JscFq35yqOo7eQupfPaTpoFvz7p5HtT/xQA/nufB29Bu+AyUkfd?=
 =?us-ascii?Q?53ypcQMhCeKfpdx+VZkCXwe+CN5D+B3aCWkVGOJMbKESDvugQGyp5dBEe6yY?=
 =?us-ascii?Q?xEE4KIh7Op5A/qDrcVaKzntFkHqwjyutbm+3PdkR2B1hpUuEtYT7UOHPIkK7?=
 =?us-ascii?Q?M4rp8aD+wpmhfpDkWI7bXVip3tXQ77ZMLPGd2+Rpgbb1xc02hNQWeehFUGE2?=
 =?us-ascii?Q?giI8ixQ5Gf32rHtJEPZ83rLHOTBDbrHjrAcBM+a0elqDhlH1Kqniys8W0R7q?=
 =?us-ascii?Q?+A7ry7tWrp6gJKe4EviGmAM0STkujAQRSO33QL43PGXXSkGHf5ly2ltr0UwK?=
 =?us-ascii?Q?Yat6Fq99MaK8VrFAuPYL3n2jn637ojtBxaI6UOV/WcYiqz4BRdYyipp6TFoS?=
 =?us-ascii?Q?A8rySLRSm2va3VIyj8Gh/tuf+efv60RP4difmTYNXmRNkW7hBPlmkjRcga3m?=
 =?us-ascii?Q?8ypdAWhNkrA3s3fovPOkzFUcYX4Je0pEOJ+putmo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7350c1d-542a-4779-52e1-08dcb1fd2d9e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 07:40:13.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7JYAosfguHRvopi5DriCa7xgQ1g91RKjhZcfMxkYiyfrwb9mLVvd7V9/tcan04bmOWQY3Z17/IcATB3Csx0rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-OriginatorOrg: intel.com

On Wed, Jul 31, 2024 at 08:53:11PM +0200, Thomas Gleixner wrote:
> On Mon, Jul 29 2024 at 10:12, Feng Tang wrote:
> >  	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
> > -	if (topo_info.nr_rejected_cpus)
> > +	if (topo_info.nr_rejected_cpus) {
> >  		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);
> > +		if (__max_logical_packages <= 4)
> > +			pr_info("TSC might be buggered due to the rejected CPUs\n");
> 
> I'm not really convinced of the value of this message.
> 
> People who limit their CPUs on the command line or at compile time
> really should know what they are doing. The kernel already tells that
> there are rejected CPUs and that extra TSC info is just annoying and
> confusing noise for people who run that and have a perfectly working TSC
> on a single/dual/quad socket machine.
> 
> I just drop that noise.
 
That makes sense to me, thanks!

Before posting the patch, I discussed this with Rui and we thought the
message was not that necessary and it was kept only in case some user
may want it. 

- Feng

> Thanks,
> 
>         tglx
> 
> 

