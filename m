Return-Path: <linux-kernel+bounces-336645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF2A983D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8637FB234A5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EEF12C465;
	Tue, 24 Sep 2024 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gnxnDoJ7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60982D66
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161294; cv=fail; b=hey2fIX0QbNaZqRQSmHzvZBOFeJ7eEGgQ/jnHIwk/o2fag0WTeNvYqgvC93YUBIs45XFQfnxzketKeKQC+9/J0CBRJmRsicP+CEBs6KSgEVbUuu/5Vo4X26y2GuxyErsJbPJ+6KmoR5xaTgFp7fWUDbvErmh1mW1OXRlbkxuvvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161294; c=relaxed/simple;
	bh=IxwDQLZtkmi4yJzIfbYlW8ahRMU95LmI8+tLoNQPyFM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IhQ83tZ8B1CxSsiV9J5mxDRoIRCNR1Qi9L507PieiF71O9c6HYQBX+n6UUdQBatOcEqdP+PdIMbm8UZq3DPFw2zwa3rxJAvas4RB6jtVfIeFcZ9+eiEOCoSl8svMxJ3kqS8vAA6PHh3n9T28L0I5Y+fnunrP466ssj5n/iV7s38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gnxnDoJ7; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727161292; x=1758697292;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IxwDQLZtkmi4yJzIfbYlW8ahRMU95LmI8+tLoNQPyFM=;
  b=gnxnDoJ7ZAiobOXaYS8K07CLUhXzbxTB888KWgZEIcs/U8fkTPi/nwba
   hLkyB0A/xDpfQ3/LZwiQMQ2C+rD4nSmlIniU0lx4XoBOpPAhPtFh6bl2b
   vAPSvf/3oXn68P+zZENHHXmO1Ys02120Mjx1ulgoIm3Yn+424zUTLvn6f
   HymTKDdnnmJeIDewiAEuQ9s7vYf7gf0XlFrQcZWZuEN31FRbzWC2uMR88
   uOtlaLflgauUtR7o6H9gs4p0zgwFE7rZT0Oo4D4Q8+DZo0bK16f31BhgN
   VDM43qJyO6zC640NbQyRAxxYE3wQiX/L5VbFUbDy5BM4MNySbIgqvsif2
   w==;
X-CSE-ConnectionGUID: hHQd+FE3SG65qffi39xd8w==
X-CSE-MsgGUID: NkxEVwDITwepSY2czGgyYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29032688"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="29032688"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 00:01:28 -0700
X-CSE-ConnectionGUID: 6RoirQ3ASuOT+EMVLtzsAw==
X-CSE-MsgGUID: 9nkp2mAASESovYAh7lcPHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="75420129"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 00:00:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 00:00:48 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 00:00:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 00:00:47 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 00:00:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5puXpXOVvFsq3olv1kvvM0HK8BvlqfL6tt4Amgzeq/M5nVap0L+/8YByfi4sRaBQM8GnnDIHCrvBQugg8TW4jSiNCrqcM1IGNO1o7Oz8qD7PXcXZA6oGfdjwOwhwyYvIM7cbo5cjj4n7BCG+5laJIHBK6K38w9uXww8tIgNt3A3Pbee8he2rMUyhd6VuU6sD7IeADJElVpWnkhVH1B8TRVm9Rhl+dCa8RW1BOrEOOJxRdMm1M/zy9CdzJfntiyxFLqi7G08kD5yRHZmke7r5WCJYnD/yop4NH5KUj9rmGJnZUblqQdiKviTJPwp1TfeUdZCxRsWsjRLG/8qQ6zcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOI5/c/+FnFotOBlmjdSSysEr+YrbBIsLR7NV4ed9aE=;
 b=hK4YHMNoVYBfUAPKQvVFP46XtQojvnxwUFB9GPOiu49Vd19I0bxtxjygsfOKOxfof1miarNfRdiOh9xM7kCz4ikxb8q3HCJ58hOC6NnNgijP/D+FbLovYfE3EMNOeBptoaiK48UQbP9Ral7BzFLHdVj8WNae346kJnqJq4aYsT7TqzPOh15ffptxaFa+oI5bDlNoyRUQu/MAU/IaL8sPNrvlSm+y4hbI0PJGD8VLhy6Wn6BABEi+g2zvCFx5Fj6ZWiH5L+Z180Cco7nNueGfCMkamlndVYiKFYLx9idxwSuejw0x5f62sjbSkIl3wiG6iatpijXOfew1ZaX+gvONAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7169.namprd11.prod.outlook.com (2603:10b6:930:90::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 07:00:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 07:00:39 +0000
Date: Tue, 24 Sep 2024 15:00:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: John <therealgraysky@proton.me>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Unknown <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
Message-ID: <202409241436.b37a069e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me>
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1e6c69-1739-4671-f191-08dcdc669920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yPqr/Nh+MhfHGIYnhu0Gs3Snfcnp8GDtszW1Kyw5z62UJhIVAQOpyAMFuE4F?=
 =?us-ascii?Q?Hs6K55NSGFsPY2s18dr4sLl0oOoFcKv/iZPu9sDhI1ejPaOMPk9V+2I77TKa?=
 =?us-ascii?Q?Gwo6TLuG+W6iJ+AfVmN2BFc+CC97rNWzsylQVq9PEnLnCj1+oMc9ty+FH6dX?=
 =?us-ascii?Q?RUpZNSUtkABal6xHiKclcsBnurX3GMi0lYZHqmYKrRaIv+sqIFhlJpq0y0R8?=
 =?us-ascii?Q?qI6ParMqikpWeAy2qUP9pAJWrZKUfVYjbLn99+bz3d/k0HEQurW+xFaGtqMZ?=
 =?us-ascii?Q?F2bbC8ppKgsceoO2jTKafM6hxzoBCxGDxmYkyCqMKzbu2lifGYsr7igGivQW?=
 =?us-ascii?Q?B20tKahSRgSv/rtnhtiisQaNqAGsdFZln3iNfy/FKRMtTM7VwDSQ7/LgYOLB?=
 =?us-ascii?Q?KR7+LGMY7a+ctocWit08PrC/4n7YVSS1HNjM88fx6JkVd5vhHnWGQc+a5wfo?=
 =?us-ascii?Q?r/ZZ4Iq8w4exKS2UF1skjvZrjKO/EDGPrQGPvgP0uXeZAKxb9Kz+BM2DoL/w?=
 =?us-ascii?Q?Tr8+K222VHRbnsUaAMwsBg61aKTEl75BNs5YrMgv7hQ9uPgloftMkakLZIJN?=
 =?us-ascii?Q?raRixlwPxuBSooxOjLGt4qKdFYMb/2aPnIY0+cftXmmBvYKoX9F3jWEq7eB0?=
 =?us-ascii?Q?g2RSJjSD1LxDLNI9pmIiUMbLTwvHfomRb+SvF/7RMCeNrT8g/kp/tnk/znT9?=
 =?us-ascii?Q?Z49YcbZ3Tm4guuFTi9FTvL04hU7hGhn0QwpeG1TAs48RRDHNe0YqFi88uj/t?=
 =?us-ascii?Q?k2RcXclnkCx4Knn8+CtIsfutf5JtN7QAFl7dER+xIyoLYpO1ySchD00cVIyp?=
 =?us-ascii?Q?8peZS4C1F3d48/mDzw6zpUm/bQoP+p8bNFfXWnGy4FtMdRj615c4a1B5pOU4?=
 =?us-ascii?Q?X2ywarCNqgSbBy68gsdjmxNJkuQFVFGLPesD2peZNPAzMGRI87mYUeS/J+dm?=
 =?us-ascii?Q?00Ixz6Bxk6OAheBd/YG9NoRxFXROD80lxMl8N7DsYB4v9p0o/ANgifsAsVcd?=
 =?us-ascii?Q?Lle6iTQUeh9Bp7HIgrl5pC1UCuYBjncZ8BZRtzIEPSlJHXaUo97Um9w8Kmj1?=
 =?us-ascii?Q?qExIJhg0yyaZP6bx+Q3CWjwe4ViWfzutDtSkPxESdUqOHIohAW1JY1mVktIj?=
 =?us-ascii?Q?Jmxq5xo1+1lnl3nik24Zg9whuf4xXVCT5W/pTk2qMDl1M7jyhg7XBCAjWQFI?=
 =?us-ascii?Q?dWeZkMSDnBL1U9aoLfcu/p8a1Pa3alrASBrTq75AM2Vm4npbHxVRMahBxqFz?=
 =?us-ascii?Q?WJ+LNXDBOd74SML0X1+0U4TixFTl/jSWCK7MbULct0CejPMqn/XhyqBk/QEM?=
 =?us-ascii?Q?DL8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0AkLx543BRuDvvyoMfR93ITfxg838c7rnX/3xc7rTVKS+U8Pru6RELCT36L8?=
 =?us-ascii?Q?0zr/FzPEKqhAWWWDwd2dMDqOeQFif5GUd2w5z4VkfuM1Hmx4SruFEAz6nT5d?=
 =?us-ascii?Q?Ojco2XsJP3vki3TrRow/EcVt6LJIs3vIGK2jUOOZjuVmRQxwHf2qx5OB8QMO?=
 =?us-ascii?Q?VJUDDVFWMM4wPbY085m4mKjmdY2NY2AMW1AxsRAX/V9BX5MgKXwRi2A9Chgu?=
 =?us-ascii?Q?OcHVbOJuQsMZhfb2+g2UB0KUO1Md0JyK8QDVnr1ONJhgSe1rRotvFO4h98gR?=
 =?us-ascii?Q?/I6aNv17UfVLGXgUeRrtjlFqkGTsm/23esYrwRv0vknJXzx3VeZWDLXvemKM?=
 =?us-ascii?Q?A4EUdn8MK3MHgxN809yc8e7xWBMjLY8bvemXTpZxeYpHAkaUotLNwiMY9dzR?=
 =?us-ascii?Q?yPi+5CYcUcYNpVvHRml6lIFYrZr1jqSFRzyUBB/YNGRpnE5o84oLnbmQ3XEn?=
 =?us-ascii?Q?8H4OPjzLk4Hil4djCaVQj0wZ5JAgFwbiUu9JoHBV+EvELo5Dj0uZkpD+qvYP?=
 =?us-ascii?Q?O+EVb6GIAKL2InKqJKbIyONZjomPo2SEpBQEi3bUSrPuuF5hKdHiPL5KWLie?=
 =?us-ascii?Q?D6c0VZRJcPKSEq2yeYaa6TP5RPnlOr0VsMgdlv1p9hCr6KUkwKgAvNKf3b/F?=
 =?us-ascii?Q?TC6hbS3ZJMYObzOOpiHpzqezrgQuUfd7JCW6CLe6Qz4CUH2mbXAQSNFJSQYj?=
 =?us-ascii?Q?UM4YjI1cm99YJc625Pf4bHvBh9uLHY0m4f8vGFwJZeUIA7axg2sHkZ+NE7c0?=
 =?us-ascii?Q?mz8M+fd+H4GdIJm0FcwcE/hRKhK59RBh7h42HunRAJsEmLl5lq1pj4oUFs8o?=
 =?us-ascii?Q?mm9u9hKvV9G6Yf9htaE7K+2nBU7r3uwVGFXsNy/bIeKW4yqsGOp493aAZkMu?=
 =?us-ascii?Q?W3jZ3TYPJ2zhqG3etNLZiVAhJTAgl8o1Fv08cZaaTCwfKYLMqtqr3GX7EHta?=
 =?us-ascii?Q?w0iXjM5wOFvw7U2z8N6YeSFYO6aTk8QzDPdtTGFLt0y26zQqOIX7BJ2uy8sy?=
 =?us-ascii?Q?OV52LYU9DpCpqKfpVvE6gadCOCdXM5+qCmolMeb0NtUT2PpPc3xwrq5+zQ4M?=
 =?us-ascii?Q?ZhbDWyqr90qFU9mKDLYZ12GQSQ4suvi049HUuC3frwHKh/jYkQKfaLOVwmN3?=
 =?us-ascii?Q?DWtIa4JPfnc5zyiSDBdfPPK3oSywu86zW0qyE4//ZUXzvjentlPtRfl1IirH?=
 =?us-ascii?Q?ZCIIY0NDiZRMCF5fXtBOQKIW+svIL1665ivcMnGAz7zXS5E1mD7pz+gP5eh7?=
 =?us-ascii?Q?ErCXoN43HNVsxz1fMPv7Erwysytr+zhakW9T4GgrI9im0M0E8mBGGAtohAjg?=
 =?us-ascii?Q?nGKk46HHNHllWYgddPLXPY5EYzi13l/DxzSKvFFsrjnJlwQPAOcnv9M77GU7?=
 =?us-ascii?Q?64Ie54ranLge2d33sTbe3+oj6xrJxNM3SkO3D37a1b3mT6IeDnIg+caoa0PP?=
 =?us-ascii?Q?SsJOmNkeN8bfg5DaoNSFdaFk8JhxPWoJaJn3NDg1N6xOqY7uWfAIhdb8BDg0?=
 =?us-ascii?Q?Q91YHh+z0Byu7t6bI5QESCHPnxoyHaMHc0GknM4XlwSIhI8t1hlkLfFQb4/H?=
 =?us-ascii?Q?g5EmTbpjESri+Kj19a2XhTh99bIjDqnf1dfiYerLqNJzj7RAkKFcfFtNarSU?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1e6c69-1739-4671-f191-08dcdc669920
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 07:00:39.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNutle8I3m05nbIoaxsfUa2m89YKvbSgTtUFjQBc34ZTapE4qp+xNSnY0l/dHyM3N7YKgT4Ab0o5J+4j1ue80w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7169
X-OriginatorOrg: intel.com


hi,

we don't have enough knowledge how this commit causing the random early cra=
sh
issue as report below.

we noticed the config has below diff comparing to parent.

--- /pkg/linux/x86_64-randconfig-016-20240921/clang-18/70ad4cfb4d4a9f97afd7=
ba12ae5c4a62e719aa44/.config 2024-09-23 14:10:14.423097567 +0800
+++ /pkg/linux/x86_64-randconfig-016-20240921/clang-18/178c2862ab0388f7de1c=
a23b7b4718e09d8acc24/.config 2024-09-23 13:13:36.831871815 +0800
@@ -350,14 +350,19 @@ CONFIG_PVH=3Dy
 CONFIG_PARAVIRT_CLOCK=3Dy
 # CONFIG_JAILHOUSE_GUEST is not set
 CONFIG_ACRN_GUEST=3Dy
-CONFIG_MK8=3Dy
+# CONFIG_MK8 is not set
 # CONFIG_MPSC is not set
 # CONFIG_MCORE2 is not set
 # CONFIG_MATOM is not set
 # CONFIG_GENERIC_CPU is not set
+# CONFIG_MAMD_CPU_V2 is not set
+# CONFIG_MAMD_CPU_V3 is not set
+CONFIG_MAMD_CPU_V4=3Dy
+# CONFIG_MINTEL_CPU_V2 is not set
+# CONFIG_MINTEL_CPU_V3 is not set
+# CONFIG_MINTEL_CPU_V4 is not set
 CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
 CONFIG_X86_L1_CACHE_SHIFT=3D6
-CONFIG_X86_INTEL_USERCOPY=3Dy
 CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
 CONFIG_X86_TSC=3Dy
 CONFIG_X86_HAVE_PAE=3Dy


early crash happens 70 times out of 500 runs.
for parent, keeps clean when we run same tests almost 1000 times.

70ad4cfb4d4a9f97 178c2862ab0388f7de1ca23b7b4
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :991          7%          70:500   dmesg.BUG:kernel_failed_in_ea=
rly-boot_stage,last_printk:early_console_in_setup_code

just FYI what we observed in our tests.



Hello,

kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_print=
k:early_console_in_setup_code" on:

commit: 178c2862ab0388f7de1ca23b7b4718e09d8acc24 ("[PATCH] x86: add more x8=
6-64 micro-architecture levels")
url: https://github.com/intel-lab-lkp/linux/commits/John/x86-add-more-x86-6=
4-micro-architecture-levels/20240915-190636
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 70ad4cfb4d4a=
9f97afd7ba12ae5c4a62e719aa44
patch link: https://lore.kernel.org/all/W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPO=
ZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=3D=
@proton.me/
patch subject: [PATCH] x86: add more x86-64 micro-architecture levels

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-04
	nr_groups: 5



compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409241436.b37a069e-oliver.sang@=
intel.com


early console in setup code
convert early boot stage from hang to failed
BUG: kernel failed in early-boot stage, last printk: early console in setup=
 code
Linux version 6.11.0-rc7-00546-g178c2862ab03 #1
Command line: ip=3D::::vm-meta-98::dhcp root=3D/dev/ram0 RESULT_ROOT=3D/res=
ult/trinity/group-04-5-300s/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-ran=
dconfig-016-20240921/clang-18/178c2862ab0388f7de1ca23b7b4718e09d8acc24/454 =
BOOT_IMAGE=3D/pkg/linux/x86_64-randconfig-016-20240921/clang-18/178c2862ab0=
388f7de1ca23b7b4718e09d8acc24/vmlinuz-6.11.0-rc7-00546-g178c2862ab03 branch=
=3Dlinux-devel/devel-hourly-20240921-005829 job=3D/lkp/jobs/scheduled/vm-me=
ta-98/trinity-group-04-5-300s-debian-11.1-i386-20220923.cgz-x86_64-randconf=
ig-016-20240921-178c2862ab03-20240923-37395-1iv09pj-434.yaml user=3Dlkp ARC=
H=3Dx86_64 kconfig=3Dx86_64-randconfig-016-20240921 commit=3D178c2862ab0388=
f7de1ca23b7b4718e09d8acc24 intremap=3Dposted_msi vmalloc=3D256M initramfs_a=
sync=3D0 page_owner=3Don carrier_timeout=3D60 max_uptime=3D1200 LKP_SERVER=
=3Dinternal-lkp-server selinux=3D0 debug apic=3Ddebug sysrq_always_enabled =
rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don pa=
nic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdis=
k=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignor=
e_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200=
 vga=3Dnormal rw rcuperf.shutdown=3D0 rcuscale.shutdown=3D0 refscale.shutdo=
wn=3D0 watchdog_thresh=3D240 audit=3D0 kunit.enable=3D0 ia32_emulation=3Don=
 riscv_isa_fallback=3D1

Kboot worker: lkp-worker22
Elapsed time: 600


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240924/202409241436.b37a069e-oliv=
er.sang@intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


