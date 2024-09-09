Return-Path: <linux-kernel+bounces-320508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917CA970B5E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937101C21621
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A5712E48;
	Mon,  9 Sep 2024 01:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gMod8Gr3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D914A82
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845847; cv=fail; b=coZ11/L639mCGgKPxZHqwvLH27xStqd0jtKUxEx3c4fPQdxVELuw6fUa0iH5Vi/aIxHr4GTmhdijlrJt34I3fpl4Gi/8q2pWL4pdNcn51XwuuXZn2ptNoQAATMyP58I64/1AHGkrUXJehYqSOe4XkptoW4EEqUynhqaURogF3iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845847; c=relaxed/simple;
	bh=Iq+QGF7LuY6UkO8sArdMyVyJWdN+mjbT2aJ3rdYnA+w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ou2UU+2XgUHcf76TzIPNN3KhFTB94t7S8j24uuG71IeMmMoVoPl2DQNTpuPIERMEqydWWHRGlORh8EpH+BXjZN3WwMrMmX8xS5JPFOBq7Jya4ctAe/Bl1EE7FnIqAe3g50hCAINvO/fuqtEAeULLJZ6Z1C50RrUDOPNNYo/DXbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMod8Gr3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725845846; x=1757381846;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Iq+QGF7LuY6UkO8sArdMyVyJWdN+mjbT2aJ3rdYnA+w=;
  b=gMod8Gr3M5WvVp/rYW0T72HrGiKNpAxx3+mV0htvzgHGK1Qjz6IkIbRi
   Ra2jcFJfylIQIgUdX8rVIPa8IZMgYcyQGQhC6n7UmZHZWdiR5bHI/znHT
   07qr2Zzc2puc/KPqhJ7Hjj6RzFcL5yQ2bZ2VaZbAWYaUDbG/Y/rua7vEG
   IkPVESbx9fxtYlrLcRstw5gfuoM+/4flboQI4n1q9gYMkniCDxhB+GfGt
   QunDWw4b+lR2YFoJRA1jNH7a6Ai2xK6nJifoZYhgJENGLuU5/NTbO777L
   gjLnyxeaL5eEaYXxKVSj6azoqth1EmRioKHu7s8I1DCA4CvUHbY2/8BMe
   Q==;
X-CSE-ConnectionGUID: 9lqcLZsTQaa4+i1ueBr3Iw==
X-CSE-MsgGUID: 0BuuUxmbRtCl8rCgIUddNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="27443457"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="27443457"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 18:37:25 -0700
X-CSE-ConnectionGUID: POv02EzCTf6rL6LH6CT2jg==
X-CSE-MsgGUID: JJ4RHwi3QOS5BIvfzBWPAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66302630"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2024 18:37:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Sep 2024 18:37:24 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Sep 2024 18:37:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 8 Sep 2024 18:37:24 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 8 Sep 2024 18:37:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgDwYt5vh9IwwAQ6HAHJBoWxy62e6OxEHOsXWytVNvocmSadZ4FBnQd6xxjBvDjAYl3ynMkx3c9GgeTuwFFOMO5CPiOwDWAJ7609DGvpaaWZcefHKgV+rTNTuL+60wnub4/xeSU3IgSKUq7P/sZNEZLoTY/U3lP8RlnwjAXVxBtpOTWQ+zG/br3lzuZ5ZQ4Fg0pXXkylwlYVFAfP5CyJavTGpz/9R38YRogF9q0ucOsn0MNXBW50Vov3d4u06cMcUu+/nZTaTs1J9KtJYjGjaNwyO8IXmrEr1ICtsAx+ND3XBELdfTkiCEW47U7cOzucwgCJvc2OKhEQae91Xdtxpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nj8BIBr6z/f4btfN9Xnq0bRxJNxOMYRH62bfZDr5+Pg=;
 b=qIS+rDbqO3jETyWwZ1JHQrmbenfGL2l57Wht5fVOf0GBeWOHghtaU060u+Vrp3G4qf+Q1rRTVNsuJQmGT2P02VdTkAIRZZHsdcjMiilGSq3+4rmbAozLL6FZJfS53Mn8XMPSS8eIXCDDBKtoFVYr30KEHK4wW6SAwXRSWLUbE5hWpMKTtVomCPYaidTOZSj391DybZRRxAd8XcHL6dR2zEzK66cEpK8oFVol+G2tMRKIDT5VJVHLxFr2mfhVzr3RMbiVpzAB5dmcTYNum+GpoGY/5a68nWqg6v2ZJ/6ORkeqoAq37iYMy0TxZC5I3cxQWCJOzQB7sXjZ4p1bUv7rxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SJ2PR11MB7504.namprd11.prod.outlook.com (2603:10b6:a03:4c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 01:37:21 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 01:37:20 +0000
Date: Mon, 9 Sep 2024 09:37:11 +0800
From: Philip Li <philip.li@intel.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
CC: kernel test robot <lkp@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: Re: error: ABI 'o32' is not supported on CPU 'mips3'
Message-ID: <Zt5RRxFLi2Fcm3Hv@rli9-mobl>
References: <202409062003.wDQ7fEq1-lkp@intel.com>
 <alpine.DEB.2.21.2409082231560.60835@angie.orcam.me.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2409082231560.60835@angie.orcam.me.uk>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SJ2PR11MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee65c10-3441-42b5-a9a1-08dcd06ff1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MiqseQqu1hQhYS1ch86dQYAc2lIvTTB9PfFVjOA5qXdlWU/RhC4HI4ys87iL?=
 =?us-ascii?Q?UVf3r5JMKhUnkyN7EFzVfCncGtXfaPqlU/3vRZFXF7piyrUBFL9GvP92myzj?=
 =?us-ascii?Q?rkXOKRsvXAeeiJMRmikkQEyTWowWMbXE5YnMhboUpXuxek6ueu2wk2Sf7CpS?=
 =?us-ascii?Q?jYV2kOJUOBiRUo7gac9SZG3uQ+TvyrkxIWJv+Ji/37jOc6rdTZGp5LXbuheb?=
 =?us-ascii?Q?hcIsKw9cOu1J72L0iIGnsRhfDXt574Ty5K+q1n9rxkJviw8BgilDul2BEj5/?=
 =?us-ascii?Q?P+JVpYjgA8eRuFS+OpGyEBW3/UovIcfAamE4p9ciBrpPt66daEepORJgC9mD?=
 =?us-ascii?Q?za9Gx7f30YRZFZXANrgtwrHB+Y0p1pnhgYCnQHLbr3LKDadYmZ3p0n9ayeHU?=
 =?us-ascii?Q?gyJvl+fzKkB6UQ9e7DgVVzcCM5b3MnIJeUY58tyVNwM5P8EAd7o8+VUgLjvv?=
 =?us-ascii?Q?kuHkUxroUO+mZWRmI4U7apz/PkHEg8VPVjNeYzfVQSNE1sYdTI8zWuzKeIpu?=
 =?us-ascii?Q?hvJp//cphLly9814Uuer9g3lzdk1Us03WcuGa6PQDH60flm2hrvigZ0sV4QP?=
 =?us-ascii?Q?VY5fWYsCfdZsIdn+IvRxUXH2TRCxec7SyH4jZFclqOFTeRkK1yvQN8bjMSLu?=
 =?us-ascii?Q?5YdUeLi+Q5vXw7aiIbYFNtvcWhWzHiAV7yF3wCVQAea2SUD53A/a2GQSht7n?=
 =?us-ascii?Q?Ryw2B07aGHVGFtb2UPW6RghIknn8tnNC6fFu1v8ZsUkB7cREqGdNpZy2UgFT?=
 =?us-ascii?Q?YS/voZWkWUOVTAG+xLqrpMh84/6lgH8gwtZsFVsjvknH354wsV28Xn8AKAy4?=
 =?us-ascii?Q?876UPTNIpP35j3lWLiQwwUX2jtRMU40XsbOl8iikXLhRZiF5ben0AkJKS2rR?=
 =?us-ascii?Q?eWmSzA7TBj9wmOTPl7BlsOAfJTgTPWDwXVpAMLvXvsQnlrgcpu5OFVCrD+Ws?=
 =?us-ascii?Q?SRHlmO/12Bzj7gwEvFRpR+Z2qKe6eeKmvhsUhzh812fqd02jRra17q9Ngm6t?=
 =?us-ascii?Q?HlaJi7wRcUr7sDDYTF/WFapQX9GaV6ZLnpI0uxkBJvHJnIaiA/dUnydvaE92?=
 =?us-ascii?Q?JarIKYZ866p3PJinuYBbMWu+HG0Mbdgf5ir4FIShyDdc59JIQV+HIKSDpn4P?=
 =?us-ascii?Q?0zWbnr7Leuili70jzK9tRZAMr9hswvT7R6oI1qS8xKSDk5L3OvJlY2Hmqbui?=
 =?us-ascii?Q?87hs+FbjB3i/J2E4zl7xWhaqPG16cKBCmirmUflV+Gzff2t+JDP1Zc+RBpkt?=
 =?us-ascii?Q?IItDn+eQ5JjXk1XBnQTzY9ap8gIZ5RH5DD59gfvcBtL1zmi3OYlkX2/8NrnG?=
 =?us-ascii?Q?eis8GQYOfDWRfdnHDWLCsA9jcDyi9MUJtDY8FRpUNxEXvpAiumpN0V/C/Lnu?=
 =?us-ascii?Q?j5WT1Qc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oFAcQ2Kvmh3omqIOxj4MeOpJKtt/4A0HOR8LS0DBIq3mv9u8rFJi+S8QKeHe?=
 =?us-ascii?Q?UBqp/SM+3RoxPFBLa/PxMZ6k117CDCVOQ5wazR+Zt+2E5YhGYtSOVnPN+KFA?=
 =?us-ascii?Q?fSCSx5fZgPQAIzRJa5pij7WaNLqxiQec/v5n1/3YKHkwF7+9hQ/pMcxesgac?=
 =?us-ascii?Q?AzO3et6/ULcLSYzocODbLuXh5CRn5KxzbxJlONjASVwnFFzTdDRGKSKVq8zu?=
 =?us-ascii?Q?Wi2ppqwUuYTfkTs1CX+ewtJ/kbirRR0JUEbEzSVixVnc8R6bglhDZVSX8zNg?=
 =?us-ascii?Q?OGO9L7uRLvXmBGX79y3H5yq0END/JQoHEUEuRH48NhgrxdVZ3jvtXyhKUm/E?=
 =?us-ascii?Q?OqVh2+2z9ZVrs/vR6FcIGT3MyEjmevlZtmcScv3IedmrIsW0YG1MxAvQkACR?=
 =?us-ascii?Q?3F09SM5G2ybVikpQFmRg5TcBZJu8WNf1KpsebJHfrd3lS3TdOzEu4lpnOp/q?=
 =?us-ascii?Q?9PRkfq5+n0Zs/W07oOfPq23YVcXAOfDwJcl94/AB5i/DJM6I+pLxnPCyaMgs?=
 =?us-ascii?Q?8Bq/jGmbQwDo5hpY3Hwal2kO6YIHBAqqEG8jEJJyWD2zXCIKt3YqLj39E2io?=
 =?us-ascii?Q?EZLDPPx0sebRnRZI/YR0l7qCC4v00mblzuZgiIdmXnEfmFxpPuJULfSDQjNn?=
 =?us-ascii?Q?aDaeCutH1CidgXkCzmcTEJYDpgd6ChUl6i1IV4tjjWJOdQbFCnmcq1W++j9y?=
 =?us-ascii?Q?3IZug9QZ5oNRJCwqDYTe1W6KqGlB/AZzBC98YK5nS/40/dUGzG30fg+rhVcM?=
 =?us-ascii?Q?3O+AsqcJnLxFrhIuy5SXAfR1PMQT2LIEfVBo6k6Bpf/QHMnoBjh/2Vc0p/kT?=
 =?us-ascii?Q?Gn0LsikPTpFCT8wkHs7DEJq9tkn2Ihcam3gSkOqF1QwxbJF49QaL99B1Ues9?=
 =?us-ascii?Q?o2XfZQa8dj+5SkPM2ll4zslhx0W7fneXEzg0sDoEizRkEebfvzsdCkwX0LtM?=
 =?us-ascii?Q?sw+H5b8ar5P0ZT7dkumU0ocOIA/rjDaGBcususNJtt02aG/5xMSZxuMsl5ax?=
 =?us-ascii?Q?f8baMpDGDM9LxwcoN/UiRGjk9wsggUxCpgQPC9kXhE958s12oBaih+/fmbRl?=
 =?us-ascii?Q?Rbnlll9Yw4N9aOxB/X57kduE0zi2ubKsjSssaMDZOBFJRWN1ov4IMYAlHkR4?=
 =?us-ascii?Q?8zj6eY06CIz0ZlYhIOan752g/vPeLHD3jyX2vLjkME+wFV2RMpWnURaAJ5QL?=
 =?us-ascii?Q?oiR5cYebjkNfkQZlbhRknQrqfILGlunLxPzGWKuPsFht3trfUKSn8NvQFt6G?=
 =?us-ascii?Q?WB+0sGkWsYzlKZy9hzRNtJhDq5RGRw0NtYe0MyME6F772zE9Z4CQmhhMZ+Pz?=
 =?us-ascii?Q?GBYWoxW5GahS10dKbQejg8M7AwYcFuR5azNyxsoltNoDfhkYaVr6P6ukB9s3?=
 =?us-ascii?Q?YH4/aJs1V8PvCePKWJYUzAbuEShA/HBfVAW8xQMR1z1W+2/sOqSpJtBvqqYS?=
 =?us-ascii?Q?utcXHY+vt3Y6MhXdpyTHw0Bidk2OAxEtpjSfSvJhRCpmr4QRWU7QlZ48jyn5?=
 =?us-ascii?Q?MogSOC57AliPwfE0l+94qzcchaF6dUSRc6MMDKtPgnqDWewqKMIeGqsj+jBM?=
 =?us-ascii?Q?UVifwFzDSX9eLdu+mg188yAHh6LWPnP0pS9esBw0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee65c10-3441-42b5-a9a1-08dcd06ff1ee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 01:37:20.1670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2vGPkADaN9H8kkWwNhmhabEAQIAoQ4aYu4ZEsJ+Ni74q7BYd44Q2tZv6VE+SgA9SWEvhoGsFa/Urn9N6GZAuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7504
X-OriginatorOrg: intel.com

On Sun, Sep 08, 2024 at 10:34:21PM +0100, Maciej W. Rozycki wrote:
> On Fri, 6 Sep 2024, kernel test robot wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   b831f83e40a24f07c8dcba5be408d93beedc820f
> > commit: bfc0a330c1b4526b88f6f9e711484b342cb00fb5 MIPS: Fallback CPU -march flag to ISA level if unsupported
> > date:   7 months ago
> > config: mips-randconfig-r111-20240906 (https://download.01.org/0day-ci/archive/20240906/202409062003.wDQ7fEq1-lkp@intel.com/config)
> > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > reproduce: (https://download.01.org/0day-ci/archive/20240906/202409062003.wDQ7fEq1-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202409062003.wDQ7fEq1-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> error: ABI 'o32' is not supported on CPU 'mips3'
> > >> error: ABI 'o32' is not supported on CPU 'mips3'
> > >> error: ABI 'o32' is not supported on CPU 'mips3'
> >    make[3]: *** [scripts/Makefile.build:116: scripts/mod/devicetable-offsets.s] Error 1
> >    make[3]: *** [scripts/Makefile.build:243: scripts/mod/empty.o] Error 1
> >    make[3]: Target 'scripts/mod/' not remade because of errors.
> >    make[2]: *** [Makefile:1198: prepare0] Error 2
> >    make[2]: Target 'prepare' not remade because of errors.
> >    make[1]: *** [Makefile:240: __sub-make] Error 2
> >    make[1]: Target 'prepare' not remade because of errors.
> >    make: *** [Makefile:240: __sub-make] Error 2
> >    make: Target 'prepare' not remade because of errors.
> 
>  This is analogous to the same failure for "CPU 'mips64'", and presumably 
> also addressed in newer LLVM.

Thanks a lot for the info, we will configure the bot to ignore such error
on old clangs.

> 
>   Maciej
> 

