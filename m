Return-Path: <linux-kernel+bounces-570617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF80A6B2A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8AE466C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 01:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D441BD014;
	Fri, 21 Mar 2025 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gebQM3WL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5F1B0406
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742520298; cv=fail; b=jZIaN4+EjxU+LKG3w9ZH4eXqQOH4J0Yi5PJoogm3jq8W9nzL9oSVu1AfZBR/QR2XG4yF246ssdRd167GwxoIxk09FAbWCo7IkOieE1loRSPz1sL8JklU9ghqTVgS/V6xW6Dat4hjPs/WB8Or+kgt9/qjMeoiTNeUqosKkG/QmG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742520298; c=relaxed/simple;
	bh=mngooqWEgKcvdSLkcxhbPvmd53SV3zIxhtX0fvaggZQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hVv0kpNGz22d/W4Ez+FPsDszL4XuWX+vU9cC0kgqX2grwoF5s5mn0PmtWmn6bVce8iTJbJ2ui+6UWPjGudhUUNqtF33WmaUAo1319/zeuK8d9Al1DriSqD4TITKwyYskQMvE0Pk4vOOjeYvbcn+RPsueFNxKEgMsk4EcEG88J2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gebQM3WL; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742520293; x=1774056293;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mngooqWEgKcvdSLkcxhbPvmd53SV3zIxhtX0fvaggZQ=;
  b=gebQM3WLLevkr5vUrzX/EZWFyyFtm7GSn3ts2MDrc0R4b9RvHiE8oF5S
   gu0Ov0ecE0LjuW81ddXSMfs9UhtqZJNVkVrYF7RWTnfKUxAqHYJ942k/7
   MpaLrKcpiJ3i1ao1Czf9j5oJDzfDTt/uiZL8KskICMMkwN2nlBbVSD3t6
   T1LKvBWxqTdL4UEUqdemIBwjnH1TDuDsJbIb+BdhySyGK83wJGzBGd+RS
   p/YXYnuR6O0HuS9pcLDBVlrG4/jNtFjgwHdEVabbzi4RzueRJV9r1cqQ4
   SA2cgCtDVDF+TNgEh7OVc66oqYAEHRwIBTlvrDalX9GfK/0u8XzOwDKJt
   A==;
X-CSE-ConnectionGUID: 2YMiAY1cToS2nZKuX78Wcw==
X-CSE-MsgGUID: /lffPNNLQKGbAjJ8FH5J6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43894442"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43894442"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:24:52 -0700
X-CSE-ConnectionGUID: vcJaQScFTlycEKNTxULFnw==
X-CSE-MsgGUID: Vbng0oYJT761J4fDbWJ85w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="124027892"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:24:52 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 20 Mar 2025 18:24:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 20 Mar 2025 18:24:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 18:24:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QURJcrPZ6nirDvS864It7ICBp9ElIccxRh2t6rJ5WhS2BuN+uox6aLcT+vK8Zz/iY27MHnsiLGtwQNwCqMTNinmBjj0v8dfslMcSAK6YrE3faRDAOyb0PKVD//7hUlSnt7pCDIfi/1Q4EOQH6oqWJ7fUBhVG4bLYWGj0hOqHZa21Ejc1a+eHNWUsU8c1AqtD9aE1MAfkKR1L7Q3F0vuFMJQcJxGI63Wz3esPL4I7irexu+UuXa2UU81yazj/HdhMVlryTOay9F/wcQT6utbYhrlypgIIx6VZ7kAHV0pQCACrMnyDxYhGl2DTK5AmL2Vf8oRCExlh+XUfjX8L35BiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsLnHVgBS0YZNAVj8jWLSIaL/5H4DGtO3vqOwJJ80Xg=;
 b=Q+Qg6dxQcAM2ITjHNDQB9mdPDc4Sus+CILmMna54VNs1wevjFJ3aTNBT9k5SfcbNI+Q4pv3qvjEeYj7qlbU6wAsJeOf7HLeHZKWxdxBqHrRGDsB5tTXI8o+vOGztG01iua/oUL64p3RlBrKuWnjMJXOrTWpMN2QiAy0fSCo9CQY1RsiWKcJej6HjWcOQH9KeF4HSNJSjksWbMBbyp7mqMsV+7a+u2fG8KwKgPS5Ju7GyOv3wiLmYAP9tCXFZ9F0XhMHJotO7kNDHSnCUvK++86tiGz/RVScLSdp/kh2n9138bW+3s3qJ/tVaO9F8AEIFYCnJRlNoQF/a0byzDWFjmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6887.namprd11.prod.outlook.com (2603:10b6:303:225::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 01:24:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 01:24:48 +0000
Date: Fri, 21 Mar 2025 09:24:39 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: sound/soc/codecs/snd-soc-wcd934x.o: warning: objtool:
 .text.wcd934x_slim_irq_handler: unexpected end of section
Message-ID: <Z9y/1xAN/08UFp9h@xsang-OptiPlex-9020>
References: <202503180044.oH9gyPeg-lkp@intel.com>
 <80b1351d-3860-4849-b18a-0e736fe458fc@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <80b1351d-3860-4849-b18a-0e736fe458fc@kernel.org>
X-ClientProxiedBy: KL1PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:820:f::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 878bd6a5-1519-49d0-810d-08dd68172b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z+hA2ozDi/Ltav8kOKezLRgCJpYCE3WjkIu2mQTmYJkCh3wr62+2ZtVRLngr?=
 =?us-ascii?Q?KXvrl1jN7YYchJSihCtows7Vty9Dt6c01EashG+rLiWnpBH8pFaMm9UjiDP9?=
 =?us-ascii?Q?r3z6IRBfPeW/8UXRrO/Mxq69HfCOo8+9LGXNdHnsQW4QwUKEr6XMKjPoDI7M?=
 =?us-ascii?Q?8RS5bDZMB9l7c9EAcE+QWKmLAU6TLSZ5GSocxx8L+14gJo+BBU6d0NlxpxJQ?=
 =?us-ascii?Q?qZCC9uZRS3Wphw9E4n0XmZ9SGOeWRNw26icJvojL/2yhmoZKWtc0lEvW+UQ4?=
 =?us-ascii?Q?XNcUirvJ8LKGuo+RYMN/E9nkdi8QYQMg9mCsqpP83B69yJw3OiTA3iLu+JAN?=
 =?us-ascii?Q?0tsrPirT+bOZfCHoPSdFO+kKx4YHJ0mWsDKbCxkgA0wIGGxUnJbir8Kw6dw9?=
 =?us-ascii?Q?4iDJwqE4ss6X8azD8K5SDiJHhPbdxJZyTqfE/pf2PDzbztdzgWOpvGuhX7hE?=
 =?us-ascii?Q?nCKIwwGtsuvwj9n6RNOqZW4KizxlOQOpKwCw+u/nizk9OKpUFQihUeC3yfm2?=
 =?us-ascii?Q?32aHFSfLE8jM5CIswFnYA7ou/7QzHoVr1x45ZK+n1XFmK0DnfDhuNiIEpzy4?=
 =?us-ascii?Q?R83MfTv9/841xv6L6GLkkJ/NMM5m/vFunBp/mSTjYEr8p8VpAFBq2u3VunDI?=
 =?us-ascii?Q?mcdTs9f+dk5DSwoyICT8Epb3sWD0C5YNwBBYNqH3DxBdG+W//rVDgSg8vwEx?=
 =?us-ascii?Q?CdkopYgie7ftkSg8/fLvBjo+ZHxizmGNAKbG2OkuD7xjZ7za4seZrbOUxc5j?=
 =?us-ascii?Q?DMaZDQ02eot0ixCgOoPXzPu+Hvoxxyr8jGMirs+j3GvtdPdlvSIr6e/pzxRn?=
 =?us-ascii?Q?KUafUnhxlV6gbemTILamMLNNpsfqjPaQQNoo7vaF4zoBAT2/IAeBlKJrBCc7?=
 =?us-ascii?Q?x2RijgPhRgTbuMXlwGdkns4h/qHZ0pdI/b6FPWG49529SqssdoSkwJBcf2Ff?=
 =?us-ascii?Q?V6SIimXaIMbUAdqlAei3jMtFecwNWgzl8iYZvwh0SF5HCsXyD+J00YxMoiGo?=
 =?us-ascii?Q?jsOBQSfyiAVRWelMW7MgHhqlNxKlsCkhqoIGYbxM1DF4qU9Y+fv9LqYxvDwp?=
 =?us-ascii?Q?Gp7Hw+FiduPfWfL/B40JbletrDwNgFWoAEsHd0nkJlLqcphVKTjOdUpseyxD?=
 =?us-ascii?Q?JRD7MC79Tplfa6jQkgg2wdNXyMezSTw+phU01PH2C4A20zo5VBZrjoPWeYFA?=
 =?us-ascii?Q?2QELmIrjqzziWh0nUFpVHBEGJEhJbke5qFUgThqv8dZr7qdiAJ8BsuA0hYbi?=
 =?us-ascii?Q?VNNKDeoyBBTQ79duhpApAkher040rDi/rISepkoLhPFrWpZ+hoyN2XXtZ+34?=
 =?us-ascii?Q?J1enBX4rXgjvrRKcaVE/6tpJt58YOWXPjiTqMtIHkFBdkA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GKBwDz5A9jdj61xmEVNI5EM2A/Crb9rLO3414KTgDobUqMOFcHLbjheSZV+7?=
 =?us-ascii?Q?9FQ5lvr6Q+vDBTwkeoH6NPioKPtsepVWkGr6GOBWmtROMxeAvkwWtpFVKQl+?=
 =?us-ascii?Q?YfMsgybZfKMz6plbymPCKWPqmyncOMUM9o++bf2iU766ZWA3vKWRNPM0y6qV?=
 =?us-ascii?Q?P+ScewHR81+CN4Jz8a8cNB4KfWXmMoQFsUSuqvPc1Dh1XwYMf5+SRDt7WejC?=
 =?us-ascii?Q?VQjOntZPRchI6g4H0sJtDM4VXCHSTTZb+H7v9Pxk7wKy+9Mz737QPqgkCjTB?=
 =?us-ascii?Q?1X3bt9kuQaIhn4esYtdgi8uIWniWz6cru5BCnIRo55r8RtUWI0LH2/gz1Vtz?=
 =?us-ascii?Q?RAxVooPFLszIm1MxHwcfaPfaVNIo8NH3IS58txYzOMwzTCSckwPst3wfiUbv?=
 =?us-ascii?Q?tCxdMtqRNQ5AzJwhYAvCKZj76TVzclOKA+BdCAnzvK1YiLMRRliOhsEX1zW6?=
 =?us-ascii?Q?iBDdKjBUz4XsninWwXE7FxbWFmTBpyv+vAHE/9LC/VSgoZH2WRxpcmYo8HeC?=
 =?us-ascii?Q?P8TToJG4+0BNA8dwwbgZIrkelShJpMlbicT9cDl5WLLOkqxsRtb/QQPvQJE1?=
 =?us-ascii?Q?4yXnGLb+CAFL+tJMOia12PLT9SpsJkXIwFdZuxoCh+g+64NCopSH2wWf2dEg?=
 =?us-ascii?Q?4j0OgUWGKVBs7NqTi660lXNyqvnuWKRuqN1ob3morAAQhva8y28i8H7SiHMt?=
 =?us-ascii?Q?e2/BIwtmpHyN0RGVu0sT6N1aDexzh2DyOVngNVuZPSVY+z8ozjmIS1g/sXMD?=
 =?us-ascii?Q?9XtHI7n43e0fceokF9OdUp0HbpPGS0J95Ku7mjM1RdLVi2g94FjXNdR6O4j+?=
 =?us-ascii?Q?xrJxaYSRqWktOxfEDKo/+D8TjCAzIUssX7sc4y5Gdx2CGji/QTxPAmEdARGj?=
 =?us-ascii?Q?xnCgtrRiM6Fe/j1s2gvbB/7VvMtgkGKDgBEOaFnKmhBP6gMcTh7nmo///omb?=
 =?us-ascii?Q?x9qHHsET/ab9iZoGifxlhjsWidRqEM4AI9NIphRo9G+JoWD2ERtijZ5GNtYn?=
 =?us-ascii?Q?YMmd6L6QAQBaVql3z5ybQCd+rEVEgR2H26yYwZt8tkTVYwWTxYFG7CFIQJAA?=
 =?us-ascii?Q?c8er7eI76C3ObD35XA6WCoyFCyx9tNAIkEhrqJ6E830H6yedPI88wX2AgSTl?=
 =?us-ascii?Q?dU1eZoH80jv9cZpb+F4qmZbNKfgsdF/CUtV0kyBwD5xUgvXdq4/uiTgnXfVM?=
 =?us-ascii?Q?8HRW+WUZwkkYfo/5kyZZ0HUbW/qXGNUvBR1/lJuC9B90N62p6n8YYRzG9rpp?=
 =?us-ascii?Q?kMCZ9OW4p5XNHue/TmWLw8Mwbejwhj+k7zeU/6MyhaSgXKVsWXjQInlup1DN?=
 =?us-ascii?Q?oKAnPyU3MrV+s6YqqTBteDaBVxFer/KX2s7YNta42bfdXpppE32ocFUeG53O?=
 =?us-ascii?Q?V63UpG8yTG9TSzwS6UYb9VQIUiN20v0fKxhJ2RxBJpa3b3yG4ahAIjNvGahU?=
 =?us-ascii?Q?t0RL/kamwrkhF7Piz5JD4egcmG4YnBO4IACVvhZmB9OvGnCDN0DMWGBdpMSL?=
 =?us-ascii?Q?qZ0efNvkcj+G1OZos90DGVnMmiliWtIKF8Xx5hftWFH/st9rsSaktsbXimLX?=
 =?us-ascii?Q?XOhqS/V1Bs1fZRurItYiuQn/l0sB3+fiICmAurxOlEG41xNuM5GiMxHCZHz0?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 878bd6a5-1519-49d0-810d-08dd68172b76
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 01:24:48.1243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOykcSHOmZDNdPZFv/XRO/LfVIhFGIauLfjCaDVSJZyOzE/ce5QztQ91Ope3l2sjIadysv4vqv+fX3dJ4xV6gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6887
X-OriginatorOrg: intel.com

hi, Krzysztof,

On Mon, Mar 17, 2025 at 06:02:14PM +0100, Krzysztof Kozlowski wrote:
> On 17/03/2025 17:24, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   4701f33a10702d5fc577c32434eb62adde0a1ae1
> > commit: 9ea22713227397b56a2b36a68c8bda13f0b43d70 ASoC: codecs: wcd934x: Handle nicer probe deferral and simplify with dev_err_probe()
> > date:   9 months ago
> > config: x86_64-randconfig-102-20250317 (https://download.01.org/0day-ci/archive/20250318/202503180044.oH9gyPeg-lkp@intel.com/config)
> > compiler: clang version 20.1.0 (https://github.com/llvm/llvm-project 24a30daaa559829ad079f2ff7f73eb4e18095f88)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250318/202503180044.oH9gyPeg-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202503180044.oH9gyPeg-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >>> sound/soc/codecs/snd-soc-wcd934x.o: warning: objtool: .text.wcd934x_slim_irq_handler: unexpected end of section
> 
> I cannot reproduce it on clang-18 and clang-19 (I do not have clang-20
> in my distros) and I do not see how original commit could trigger this
> warning.

we double confirmed, the issue is really only reproduced on clang-20

linux$make W=1 LLVM=1 -j32 ARCH=x86_64

...

  LD [M]  sound/soc/codecs/snd-soc-lpass-va-macro.o
sound/soc/codecs/snd-soc-wcd934x.o: warning: objtool: .text.wcd934x_slim_irq_handler: unexpected end of section   <----


but cannot be reproduced on clang-19

linux$make W=1 LLVM=1 -j32 ARCH=x86_64

...

  LD [M]  sound/soc/codecs/snd-soc-wcd9335.o
  LD [M]  sound/soc/codecs/snd-soc-wcd934x.o     <----
  LD [M]  sound/soc/codecs/snd-soc-wcd937x.o

> 
> Best regards,
> Krzysztof

