Return-Path: <linux-kernel+bounces-363464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BF899C2D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA84284284
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D712414A60F;
	Mon, 14 Oct 2024 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDusLHGQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A279C14E2E6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893836; cv=fail; b=XeAncpMJERbNwnx5sy0YU3Nx8fLFpK2CtKfurF1iBmGFA+WgpJMZmZ/GXACk/JgPPXxvcoEnxKivP27dfTj5rAp37QcZzqWFynJySz3+RY6mV8iMZnpROGT5w8JswGhF40Dkp2XB2+6eDdPkIcR1+csMmANabeOaWvNXdOyIgH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893836; c=relaxed/simple;
	bh=qEM1fWN4maubDpa5GPqKG2+bFRmIjZGZja3aprg+688=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pwjZ2R0qaMJxmeSUTjnMVR/gD5PVfGMo/jMURYTKaJIhym5RFYGkF52IXo+TuU38hOGYXTDP4lo8SrZHF1OoqW36/cvMnPjIDDldBmM+vXYLmhdcdF7zcNGBcNNIBteGH6wel0D9+y7BEI0FlQCV4xAHdd5Cl++51yQ880Ejtxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDusLHGQ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728893831; x=1760429831;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=qEM1fWN4maubDpa5GPqKG2+bFRmIjZGZja3aprg+688=;
  b=DDusLHGQQlNw+p3I3AWW1WfSelD1nzsejLvczQBtGLNLp2lcoevALSbl
   uMrxQXzzLocwZmWmtYnFDLB7+xH89k0PgerQ0E5rGaJPatu/zX+iS/GYT
   rHpKKfMV6xJ4allrYoCrFHCJNkRP8XrHdgYtuWmAuXDtIGCllXOc5U12Q
   PZQ/GOYis/Do4rHwbhxzUjQmWE/RI1LU5xwO4dFny8zQct3I71AMKPl3p
   zAHXHoQu84xO3o/GDn9SvIyHC8X8PMApbiyBTXkLDFidF/peWh73J64Gb
   I505XjmF4PNXof26eqQ44cCoLc5lpZqCwLIN70oOBvxPJYDKRicIzwb1c
   A==;
X-CSE-ConnectionGUID: iyEUHuyiQ4+aPEQ2VkgRkw==
X-CSE-MsgGUID: curwUSVFSJ2abtOHi5wnrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="50758192"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="50758192"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 01:17:11 -0700
X-CSE-ConnectionGUID: 6rGXdoloQFaBu5wDvivuDA==
X-CSE-MsgGUID: kg7f1e/pSJSU5oJ4V7GJhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82290798"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 01:17:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 01:17:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 01:17:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 01:17:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 01:17:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MstZ6ApMJmHtxaZh0igTvE6VDrwQvR+u/1a7whzwAoJjwJqugCmwDMiLT9lVk1mMMlhZg1ZEF9QMCQvKdSGWbQ70LEBWQLhrR3ufilUeYXDK0AYVQ/WuSDThVxjvPeMNF6nGrkC7bj4HY9wiEx25XC7Zc8nxCWPVCkUDR3bItFt24GATPyZnWW1yzUtTb/Bs0G5CGttD4kZkWsgFiufTaW+qXZ2Kt2YtHyVtyhMOqPotBfUvgHXhOyYJO9Oj26cQupb+TZKuQsPrPVN0ffRSeeifofwT8R7t7KPfYorcrvUtgmRWpdWQy9m/9NbkU67fkhyIpuzHuE5XkIp6+jQCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SevbBA5DrH5BljVTkA25e3jhtK4HhLc6iLcvPDdSDzY=;
 b=e3EiGYacGIkaKIGLG5dAUjuHoVpOosKbDtGcYREhs2D/0+6Ec4i7qR/2ux+QBLvS1wWfEaGMo6w2udbefjjDMTAAwu+NLDJvMg0kawZ6GfCRB/Cfb4BaLViCU7BNyHANR97gSp8/Rac4oDxjcCApzPPv9of7+zLwmaii/jO3Xk41RL2PNLpMqnTqvLjzTkYzWrndS2xipcaT4Indy5DUDrPgDF53/7EdAiaUXqC1MqKwDt+vUth+aOXB7i8EiT9gFD58nCMg/BKSqU1Y3qINOXpv6Zw9OvS89E0TvAnE65GlYjsIc9HumaC7i32MzVmcX021vcAIHV1+Jg1Ll0VAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7199.namprd11.prod.outlook.com (2603:10b6:208:418::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 08:17:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 08:17:03 +0000
Date: Mon, 14 Oct 2024 16:16:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched]  436f3eed5c:
 stress-ng.schedpolicy.ops_per_sec 50.3% improvement
Message-ID: <202410141525.96031bca-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU1PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:802:19::34) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: fdac060a-9ff1-4c21-6911-08dcec289577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?MJCTCLQlX9Z19ppEvN7qfKxSGp9d3CehGTz/ibrMEgtbPAwYT0ayJGS1Xf?=
 =?iso-8859-1?Q?2dv/3johTGGgHPJkw0MctKTczSQnswdJZkxAiAV33WF8m/CFS6sEexFuHa?=
 =?iso-8859-1?Q?1wsl2GdCIugX+qVMUDhopMZbgUMzhtCEpjIxcK4JCnAmAIwURyAoKQN3jT?=
 =?iso-8859-1?Q?BdSfnDFt8zdqsaJpF2vqMb2UoKJ6Xv/xPpaDUQ/Po86REPCk7Iwv/Ka3wz?=
 =?iso-8859-1?Q?4Y8vXheIkwLcU9KQuGUtIXuD7XDk4tcNTCx03k3hIa6oIyrMtGHfDMZ/IW?=
 =?iso-8859-1?Q?nmtd7L/RJVnTT8zfKnfIL9AmJIxE1q1U6sFI/LprSfkQER99VqyhJbkF0o?=
 =?iso-8859-1?Q?CummzHzcNsJaeLuLRAlRHg6Q3XENbHQaY1nIyxq/cA+EgLAmKY3bIYalc5?=
 =?iso-8859-1?Q?t9d+zXNUBELE12jL1lJUeaWcwSDTLiB9Net40HKxdAYoLx/uZRb4YuULii?=
 =?iso-8859-1?Q?dmQxK3Hr60hFjWz1TJ/N+//OoGv4gqu55XyWKbljJAckD8kJPvzsmA8Y9Q?=
 =?iso-8859-1?Q?pt6bVTzBHJHigNpETmoAl+5KuvsJOXFx9yKFppzAtiutdtfIiDJB/mAdWT?=
 =?iso-8859-1?Q?VTkAfH2AA3trOToKfLzjAXEX+wnULTdBUZYfdpPI6Hce2O84VlP/okWSUU?=
 =?iso-8859-1?Q?Io6YAG9cyrVFcp1urJRMox91vXj10XVmISwM8Xg21eAXHwVGgk6BTVcQoX?=
 =?iso-8859-1?Q?q6JpGhLnxdx5HLAdmqtMGPOqgfopnKzbQ6cjuzplUuSl8D6pdoTLjqggRp?=
 =?iso-8859-1?Q?o1Hc2q8vlfTD+1j0HEg9uVl26I+MNuHRujKEBW5m8CkvlOmD9TCXdExMOC?=
 =?iso-8859-1?Q?3tWcSWp0C+73WS54ufvOa7H6C1sJgl+Wtjm0+LwLR5+blGRc5V1TNxW2jX?=
 =?iso-8859-1?Q?gv0tYOrbjkFUUELhS3dr6BwRd0CRrYoHzTs9V3YLBrPDRKZU+z4cJpmViV?=
 =?iso-8859-1?Q?bVuqAbcE3LhclfWU3pbUegrQjDqwF1bFbcfTsz5lQ9MC+enxUOdH1/NurD?=
 =?iso-8859-1?Q?yMbgLuupJR2Qp3UiFPqHElJibYm/voAsQteQfecG8LQbFhHmAMbygl9PSW?=
 =?iso-8859-1?Q?2IbYxWqcKdqU7sAdH8Yp91/jE+r2tQnetWhHIxsGiL108LeAleZuhPU7uL?=
 =?iso-8859-1?Q?eF48/ze5Rxd55TwdpLA2E+jY3jlaNdgEMllZr8ObR98MgN+EnkPC/PRY66?=
 =?iso-8859-1?Q?rp+OOEZNMFkxXnBs+f57sGG5LzXK89+q4225PnAckOpcZ5hMHvxjNJy/5Z?=
 =?iso-8859-1?Q?DcxFUBNeLyilVwvUBx5Kwm/udc9WmwGBOQmiLEQUY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?N75SS8b2a1cJ40wEbIU/vxgk9CL3fwmoJb+IwjZzpHIsDpJxEMMzC+GEYL?=
 =?iso-8859-1?Q?C2kXo5b978SrhkluAqIEZpO0jWpMMAd/AKf0StJkQmugUL+M23XkXewKr/?=
 =?iso-8859-1?Q?1wqyybn+moQSAN8cZhP4u8W/Rq5EziBPsb1rs8cmGvOKNzMUeANhbrMCb2?=
 =?iso-8859-1?Q?I5G65/Vs2FHYeLa9jCjZLgraNaUGJLRwtLiB/1oYWNBtFkjZA9x+33PFuy?=
 =?iso-8859-1?Q?lbKiAbA/SmDZiO8pOrj0XImALrGf5iJ3cTlLBsPipRWbBZC/cX7oCnf7VU?=
 =?iso-8859-1?Q?PywoXuDUZjFmSGGXm9ggf9lsyy0cVLIMzu4F/Ul2GVjrUrVAf9oLJAH6CU?=
 =?iso-8859-1?Q?RB+XawGLdoU9EIZmid+ebR/pNTD3pK5Di8hZnC/Zxrt3BvSCEeUtG7Dvhf?=
 =?iso-8859-1?Q?JBJFs4e58lDnjcyw7dOnKOGWHgmq6t6Ni3zSSWc3GSP9n6ae6F2Ys8VFQ3?=
 =?iso-8859-1?Q?8pp4JY59a2jEnZ4Kntvbqy7g8ReILH/DMGKlrpI2E7UyX9EUX5Gqav4w5t?=
 =?iso-8859-1?Q?FSHInSOH6kXOOxSKIMTowU6kqTNRM5tRdRdVim0mgr/xXjVJzCrx9PkpS0?=
 =?iso-8859-1?Q?+xaBOcyaxD6LhA+Z1joinZJrvQ7wqqC3mM09Fech1NQ6iWJfwrI4udvghI?=
 =?iso-8859-1?Q?7gsVFP6jNVfCDPc3K7KT7cmCHuKv836oKKCOrS1GNrUOBCK6ALTAnt/BNP?=
 =?iso-8859-1?Q?iH3eY0zuzy4aIBw2SB081ssJe/YXv056AKuNhZML+a3TdAWcj7N32F/CgO?=
 =?iso-8859-1?Q?1gMt3YxCSTaKi5945y4isWRNQ81UXNZ65ZyenvRHFXbhdbx0uFiLvrtDXd?=
 =?iso-8859-1?Q?kA1L1sVHUUOv7lZaII5HpSwE47FgZCcr+aCBwyeO2WrB0qMM04qfct8GCw?=
 =?iso-8859-1?Q?Uk+iOgV5kLBNs2nhIFE0RNjd2NXY1t7Nvtt72JeAbXfD51pQEfRVWd4Y8y?=
 =?iso-8859-1?Q?1/dUVL/Ipf6fz2IDxFbyZzLncO6CxiA+ELkpZOWPkXbRs/oaOcGyZb568l?=
 =?iso-8859-1?Q?T6FBcI29SbzsAua/4aMLQyC7FXt3q70Wwg71Qk7Y8+DASrtLDmFypo2Ics?=
 =?iso-8859-1?Q?8Iq9p7myBFimjgzSzGdUtz6DCXpOCsoweiawIKarrA1kbPSEhWs242NdI3?=
 =?iso-8859-1?Q?D1F9n9LqSxu2zjyFG7afiH29toyX1QSyc0n/oY3BbjLxMQ3JJZi2B/wcdU?=
 =?iso-8859-1?Q?/AzsM8KphHuc5vjINQrlXoaHV8zVs3nAteC4VCsnvY/+vcCfUfi1yICNVz?=
 =?iso-8859-1?Q?VG/9LfLPBiKdX9sRSyOc6b9b1IQiz9DzJfijtCdqYISUP4w/wR6V8sYQ8c?=
 =?iso-8859-1?Q?QC5aasOwzJ4/0sD+hc5LrYbV09bbYX+BUcs9Oqcr7fx5Uq7qhw+cBuN+rg?=
 =?iso-8859-1?Q?VTqNmXYEZX3SncnDD0S199CqWr4OyQ5NxnShbOHLkYu5in55OPE+lDATJv?=
 =?iso-8859-1?Q?/aj6yffFne40EZLeVuWvmL2KdVyvSNbelBY2LEQRUYbmQ1MGp1ELmB+UA0?=
 =?iso-8859-1?Q?RT2b7eMZcvRPPxqmB0YMx+K0W71AlqI6GkLKP1bjGJAFo5v+SQv7nHx3jY?=
 =?iso-8859-1?Q?ym67MfZ50ZAZd6+vWzAD445VoZ0f3lY8TEeXmBWW6M4xrnNhBfjdcZ5GJa?=
 =?iso-8859-1?Q?4wUfgt1JIFOY+PoDz7joqjOMFOccwgbyevmv7e2VsRMaxrWu1SZ0coJw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdac060a-9ff1-4c21-6911-08dcec289577
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 08:17:03.6535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWgj8eklPiPkrcMHTePsgvjVr753uSnjVq4eYUrJdaLPbXKS5LP62nIYU7/QpxHGOae6VEqHNX+TyyEDC2oSew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7199
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 50.3% improvement of stress-ng.schedpolicy.ops_per_sec on:


commit: 436f3eed5c69c1048a5754df6e3dbb291e5cccbd ("sched: Combine the last put_prev_task() and the first set_next_task()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: schedpolicy
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.schedmix.ops_per_sec 194.5% improvement                              |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | nr_threads=100%                                                                           |
|                  | test=schedmix                                                                             |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241014/202410141525.96031bca-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/schedpolicy/stress-ng/60s

commit: 
  fd03c5b858 ("sched: Rework pick_next_task()")
  436f3eed5c ("sched: Combine the last put_prev_task() and the first set_next_task()")

fd03c5b8585562d6 436f3eed5c69c1048a5754df6e3 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    531129 ±  5%     +48.6%     789373 ± 21%  vmstat.system.in
     26659 ± 93%    +310.5%     109440 ± 28%  meminfo.Active
     26611 ± 93%    +311.1%     109391 ± 28%  meminfo.Active(anon)
      0.72            -0.1        0.57 ± 10%  mpstat.cpu.all.irq%
      0.04 ±  5%      -0.0        0.02 ± 12%  mpstat.cpu.all.soft%
      7.19 ±  2%      +0.7        7.89 ±  3%  mpstat.cpu.all.usr%
     21603 ±119%    +392.1%     106300 ± 29%  numa-meminfo.node1.Active
     21579 ±119%    +392.5%     106276 ± 29%  numa-meminfo.node1.Active(anon)
    625525 ±161%     -87.0%      81185 ±140%  numa-meminfo.node1.Unevictable
 4.254e+08 ±  3%     +50.3%  6.395e+08 ±  6%  stress-ng.schedpolicy.ops
   7089967 ±  3%     +50.3%   10657401 ±  6%  stress-ng.schedpolicy.ops_per_sec
    898.76 ±  2%     +17.2%       1053 ±  4%  stress-ng.time.user_time
      5392 ±119%    +388.5%      26340 ± 29%  numa-vmstat.node1.nr_active_anon
    156381 ±161%     -87.0%      20296 ±140%  numa-vmstat.node1.nr_unevictable
      5391 ±119%    +388.5%      26340 ± 29%  numa-vmstat.node1.nr_zone_active_anon
    156381 ±161%     -87.0%      20296 ±140%  numa-vmstat.node1.nr_zone_unevictable
      7698 ± 15%     -73.9%       2010 ± 54%  perf-c2c.DRAM.remote
     13754 ± 17%     -72.3%       3813 ± 54%  perf-c2c.HITM.local
      5326 ± 15%     -74.4%       1365 ± 55%  perf-c2c.HITM.remote
     19080 ± 16%     -72.9%       5179 ± 54%  perf-c2c.HITM.total
      6644 ± 93%    +321.2%      27989 ± 30%  proc-vmstat.nr_active_anon
    178967            +4.7%     187327        proc-vmstat.nr_anon_pages
      6644 ± 93%    +321.2%      27989 ± 30%  proc-vmstat.nr_zone_active_anon
    674206 ±  7%     -15.8%     567947 ± 11%  proc-vmstat.numa_pte_updates
     54529           +28.7%      70156 ± 29%  proc-vmstat.pgactivate
      0.15 ±106%     -76.3%       0.04 ± 45%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.25 ±134%     -81.7%       0.05 ± 45%  perf-sched.sch_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.11 ± 50%     -64.2%       0.04 ± 22%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.06 ± 39%     -77.1%       0.01 ±143%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.20 ±179%     -92.9%       0.09 ± 56%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
      1.66 ±153%     -94.1%       0.10 ±  9%  perf-sched.sch_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.07 ± 50%     -79.7%       0.01 ±135%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5521 ± 13%     -36.2%       3524 ± 47%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.15 ±106%     -76.3%       0.04 ± 45%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.25 ±134%     -81.7%       0.05 ± 45%  perf-sched.wait_time.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.11 ± 50%     -64.2%       0.04 ± 22%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.20 ±179%     -92.9%       0.09 ± 56%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
      1.66 ±153%     -94.1%       0.10 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      2753 ± 57%     -67.2%     902.38 ±104%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      5521 ± 13%     -42.0%       3200 ± 42%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
 2.689e+10 ±  8%     +69.4%  4.555e+10 ± 16%  perf-stat.i.branch-instructions
  1.29e+08 ±  7%     +65.5%  2.134e+08 ± 17%  perf-stat.i.branch-misses
     24.41            -1.3       23.12 ±  3%  perf-stat.i.cache-miss-rate%
  33778121 ±  6%     +31.4%   44396499 ± 18%  perf-stat.i.cache-misses
 1.374e+08 ±  7%     +39.9%  1.923e+08 ± 20%  perf-stat.i.cache-references
      5.47 ±  3%     -36.9%       3.45 ±  5%  perf-stat.i.cpi
     19807           -17.7%      16303 ±  5%  perf-stat.i.cycles-between-cache-misses
 1.296e+11 ±  8%     +69.4%  2.195e+11 ± 16%  perf-stat.i.instructions
      0.20 ±  4%     +61.1%       0.32 ±  8%  perf-stat.i.ipc
      0.26 ±  2%     -21.0%       0.20 ±  2%  perf-stat.overall.MPKI
      0.47            -0.0        0.45        perf-stat.overall.branch-miss-rate%
     24.64            -1.5       23.11 ±  3%  perf-stat.overall.cache-miss-rate%
      4.95 ±  3%     -29.1%       3.51 ±  6%  perf-stat.overall.cpi
      0.20 ±  3%     +41.5%       0.29 ±  6%  perf-stat.overall.ipc
 2.559e+10 ±  4%     +39.2%  3.563e+10 ±  6%  perf-stat.ps.branch-instructions
 1.207e+08 ±  3%     +31.3%  1.584e+08 ±  5%  perf-stat.ps.branch-misses
  1.28e+08 ±  2%     +17.3%  1.501e+08 ±  6%  perf-stat.ps.cache-references
    523.92           -14.0%     450.68 ±  7%  perf-stat.ps.cpu-migrations
 1.233e+11 ±  4%     +39.3%  1.717e+11 ±  6%  perf-stat.ps.instructions
 7.843e+12 ±  3%     +40.8%  1.105e+13 ±  6%  perf-stat.total.instructions
     47134 ± 26%  +20618.9%    9765832 ± 44%  sched_debug.cfs_rq:/.avg_vruntime.avg
    243804 ± 31%     +86.2%     454012 ± 26%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.05 ± 19%    +588.2%       0.37 ± 37%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.22 ±  8%     +50.9%       0.34 ± 14%  sched_debug.cfs_rq:/.h_nr_running.stddev
     84350 ±  9%     -38.5%      51865 ± 28%  sched_debug.cfs_rq:/.load_avg.max
     47134 ± 26%  +20618.9%    9765832 ± 44%  sched_debug.cfs_rq:/.min_vruntime.avg
    243804 ± 31%     +86.2%     453999 ± 26%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.05 ± 19%    +575.0%       0.36 ± 37%  sched_debug.cfs_rq:/.nr_running.avg
      0.22 ±  8%     +43.5%       0.32 ± 12%  sched_debug.cfs_rq:/.nr_running.stddev
      1118 ± 12%     +80.7%       2021 ± 25%  sched_debug.cfs_rq:/.runnable_avg.max
    105.78 ± 11%     +78.1%     188.35 ± 20%  sched_debug.cfs_rq:/.util_est.stddev
      2427 ± 13%   +6271.6%     154692 ± 53%  sched_debug.cpu.avg_idle.min
     43015           +59.2%      68480 ± 16%  sched_debug.cpu.clock.avg
     43030           +59.6%      68674 ± 16%  sched_debug.cpu.clock.max
     42990           +58.8%      68278 ± 16%  sched_debug.cpu.clock.min
      8.31 ±  4%   +1283.9%     114.96 ± 44%  sched_debug.cpu.clock.stddev
     42854           +59.1%      68167 ± 16%  sched_debug.cpu.clock_task.avg
     42999           +59.4%      68558 ± 16%  sched_debug.cpu.clock_task.max
     28459 ±  2%     +80.2%      51272 ± 19%  sched_debug.cpu.clock_task.min
    201.46 ± 20%   +1373.7%       2968 ± 41%  sched_debug.cpu.curr->pid.avg
      3991           +46.5%       5845 ± 13%  sched_debug.cpu.curr->pid.max
      0.00 ± 17%    +767.7%       0.00 ± 41%  sched_debug.cpu.next_balance.stddev
      0.05 ± 19%    +621.2%       0.39 ± 38%  sched_debug.cpu.nr_running.avg
      0.23 ±  8%     +59.2%       0.36 ± 20%  sched_debug.cpu.nr_running.stddev
    641.31          +299.9%       2564 ± 36%  sched_debug.cpu.nr_switches.avg
    114.50 ± 11%    +132.3%     266.00 ± 21%  sched_debug.cpu.nr_switches.min
     43001           +58.8%      68277 ± 16%  sched_debug.cpu_clk
     41946           +60.2%      67219 ± 16%  sched_debug.ktime
     43844           +57.7%      69128 ± 16%  sched_debug.sched_clk
     22.00           -20.4        1.56 ±  2%  perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     21.97           -20.4        1.53        perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.74           -20.1        3.63 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     23.76           -20.1        3.66        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
     23.59           -20.1        3.51 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     23.98           -20.0        3.96        perf-profile.calltrace.cycles-pp.__sched_yield
     10.47           -10.5        0.00        perf-profile.calltrace.cycles-pp.enqueue_pushable_task.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      9.13 ±  3%      -9.1        0.00        perf-profile.calltrace.cycles-pp.set_next_task_rt.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      2.78 ±  2%      -0.6        2.18        perf-profile.calltrace.cycles-pp.dl_server_stop.dequeue_entities.dequeue_task_fair.__sched_setscheduler._sched_setscheduler
      5.64            -0.4        5.21        perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      1.58 ±  2%      -0.4        1.21        perf-profile.calltrace.cycles-pp.__hrtimer_start_range_ns.hrtimer_start_range_ns.dl_server_stop.dequeue_entities.dequeue_task_fair
      1.78 ±  2%      -0.3        1.44        perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.dl_server_stop.dequeue_entities.dequeue_task_fair.__sched_setscheduler
      2.86            -0.2        2.64 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      2.95 ±  2%      -0.2        2.74 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setparam
      0.74 ±  2%      -0.2        0.57 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      0.71 ±  3%      -0.2        0.54 ±  2%  perf-profile.calltrace.cycles-pp.pick_task_fair.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      0.52 ±  2%      +0.0        0.57 ±  2%  perf-profile.calltrace.cycles-pp.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setparam
      0.58 ±  2%      +0.1        0.64 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setparam
      0.64 ±  6%      +0.2        0.80 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_getscheduler
      0.44 ± 44%      +0.2        0.61 ±  2%  perf-profile.calltrace.cycles-pp.dl_server_start.enqueue_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      0.72 ±  5%      +0.2        0.89 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_getscheduler
      0.35 ± 70%      +0.3        0.60 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_dl_entity.dl_server_start.enqueue_task_fair.__sched_setscheduler._sched_setscheduler
      1.55            +0.3        1.83 ±  5%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setparam
      0.36 ± 70%      +0.3        0.64 ±  2%  perf-profile.calltrace.cycles-pp.stress_schedpolicy
      0.62 ±  3%      +0.3        0.92 ±  6%  perf-profile.calltrace.cycles-pp.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
      0.81 ±  2%      +0.3        1.12 ±  5%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
      0.58 ± 11%      +0.3        0.92 ±  4%  perf-profile.calltrace.cycles-pp._copy_from_user.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.57 ±  2%      +0.3        1.92 ±  3%  perf-profile.calltrace.cycles-pp.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      7.86 ±  2%      +0.4        8.23        perf-profile.calltrace.cycles-pp.sched_setparam
      4.06 ±  3%      +0.4        4.44 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_setattr.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.73 ±  2%      +0.5        2.28 ±  8%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      1.62 ±  2%      +0.6        2.21 ±  5%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      0.86 ± 32%      +0.6        1.46 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.12 ± 24%      +0.8        1.95 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.syscall
      3.05 ±  2%      +1.3        4.36 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
      9.62 ±  2%      +1.3       10.96 ±  3%  perf-profile.calltrace.cycles-pp.cpupri_set.dequeue_rt_stack.dequeue_task_rt.__sched_setscheduler._sched_setscheduler
      3.52 ±  3%      +1.4        4.87 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
      9.64 ±  2%      +1.4       11.00 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_rt_stack.dequeue_task_rt.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      3.56 ±  3%      +1.4        4.92 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.kill
      1.90 ±  2%      +1.4        3.29 ±  9%  perf-profile.calltrace.cycles-pp.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
      0.69 ±  7%      +1.4        2.10 ± 15%  perf-profile.calltrace.cycles-pp.apparmor_task_kill.security_task_kill.kill_pid_info_type.kill_something_info.__x64_sys_kill
      1.33 ±  4%      +1.4        2.74 ± 11%  perf-profile.calltrace.cycles-pp.kill_pid_info_type.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.69 ±  8%      +1.4        2.12 ± 15%  perf-profile.calltrace.cycles-pp.security_task_kill.kill_pid_info_type.kill_something_info.__x64_sys_kill.do_syscall_64
      4.08 ±  3%      +1.5        5.62 ±  5%  perf-profile.calltrace.cycles-pp.kill
      9.72 ±  2%      +1.6       11.32 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_task_rt.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      8.78 ±  4%      +1.6       10.41        perf-profile.calltrace.cycles-pp.syscall
     15.11 ±  8%      +5.1       20.16 ±  7%  perf-profile.calltrace.cycles-pp.balance_callbacks.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
     14.93 ±  8%      +5.1       20.05 ±  7%  perf-profile.calltrace.cycles-pp.pull_rt_task.balance_callbacks.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      0.92 ± 15%      +7.4        8.34 ± 21%  perf-profile.calltrace.cycles-pp.apparmor_capable.security_capable.capable.__sched_setscheduler._sched_setscheduler
      0.98 ± 14%      +7.5        8.43 ± 21%  perf-profile.calltrace.cycles-pp.security_capable.capable.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      1.00 ± 13%      +7.5        8.45 ± 21%  perf-profile.calltrace.cycles-pp.capable.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
     44.23 ±  2%     +14.9       59.16        perf-profile.calltrace.cycles-pp.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64
     44.34 ±  2%     +14.9       59.29        perf-profile.calltrace.cycles-pp._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.39 ±  2%     +15.8       62.23        perf-profile.calltrace.cycles-pp.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     46.34 ±  2%     +15.9       62.19        perf-profile.calltrace.cycles-pp.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     47.33 ±  2%     +16.2       63.52        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     47.53 ±  2%     +16.3       63.79        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     48.22 ±  2%     +16.5       64.76        perf-profile.calltrace.cycles-pp.__sched_setscheduler
     23.16           -20.1        3.06 ±  3%  perf-profile.children.cycles-pp.schedule
     23.11           -20.1        3.02 ±  3%  perf-profile.children.cycles-pp.__schedule
     23.60           -20.1        3.52 ±  2%  perf-profile.children.cycles-pp.__x64_sys_sched_yield
     24.07           -20.0        4.09        perf-profile.children.cycles-pp.__sched_yield
     10.48           -10.5        0.00        perf-profile.children.cycles-pp.enqueue_pushable_task
      9.15 ±  3%      -9.2        0.00        perf-profile.children.cycles-pp.set_next_task_rt
     92.05            -2.1       89.97        perf-profile.children.cycles-pp.do_syscall_64
     92.53            -1.9       90.63        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.78 ±  2%      -0.6        2.20        perf-profile.children.cycles-pp.dl_server_stop
      5.82            -0.4        5.39        perf-profile.children.cycles-pp.dequeue_task_fair
      5.65            -0.4        5.22        perf-profile.children.cycles-pp.dequeue_entities
      1.73 ±  2%      -0.3        1.41        perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      2.05 ±  2%      -0.3        1.76        perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.42 ± 13%      -0.3        0.14 ± 26%  perf-profile.children.cycles-pp.generic_perform_write
      0.42 ± 13%      -0.3        0.14 ± 25%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.42 ± 13%      -0.3        0.15 ± 28%  perf-profile.children.cycles-pp.record__pushfn
      0.42 ± 13%      -0.3        0.15 ± 28%  perf-profile.children.cycles-pp.writen
      0.47 ±  5%      -0.3        0.20 ± 13%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.43 ± 12%      -0.3        0.15 ± 23%  perf-profile.children.cycles-pp.vfs_write
      0.43 ± 11%      -0.3        0.16 ± 21%  perf-profile.children.cycles-pp.ksys_write
      0.81 ±  9%      -0.3        0.54 ± 33%  perf-profile.children.cycles-pp.__cmd_record
      0.43 ± 12%      -0.3        0.16 ± 22%  perf-profile.children.cycles-pp.write
      0.43 ± 13%      -0.3        0.16 ± 25%  perf-profile.children.cycles-pp.perf_mmap__push
      0.43 ± 13%      -0.3        0.16 ± 25%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.32 ± 11%      -0.2        0.07 ±  8%  perf-profile.children.cycles-pp.put_prev_task_rt
      0.30 ± 12%      -0.2        0.07 ± 26%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.39 ± 15%      -0.2        0.17 ± 25%  perf-profile.children.cycles-pp.handle_internal_command
      0.39 ± 15%      -0.2        0.17 ± 25%  perf-profile.children.cycles-pp.main
      0.39 ± 15%      -0.2        0.17 ± 25%  perf-profile.children.cycles-pp.run_builtin
      0.38 ± 16%      -0.2        0.16 ± 25%  perf-profile.children.cycles-pp.cmd_record
      0.57 ±  7%      -0.2        0.42 ±  6%  perf-profile.children.cycles-pp.__remove_hrtimer
      1.05 ±  2%      -0.1        0.93 ±  3%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.18 ± 15%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.update_rt_rq_load_avg
      0.40 ±  3%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.35 ±  4%      -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.28 ±  4%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.idle_cpu
      0.14 ±  5%      -0.1        0.04 ± 44%  perf-profile.children.cycles-pp.__x64_sys_sched_get_priority_max
      0.22 ±  2%      -0.1        0.12 ± 15%  perf-profile.children.cycles-pp.task_work_run
      0.40 ±  8%      -0.1        0.30 ±  8%  perf-profile.children.cycles-pp.timerqueue_del
      0.21 ±  2%      -0.1        0.11 ± 16%  perf-profile.children.cycles-pp.task_mm_cid_work
      1.21 ±  2%      -0.1        1.12 ±  3%  perf-profile.children.cycles-pp.pick_task_fair
      1.30 ±  2%      -0.1        1.21 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.23 ±  2%      -0.1        0.15 ± 12%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.34 ±  4%      -0.1        0.26 ±  3%  perf-profile.children.cycles-pp.update_curr_dl_se
      0.15 ±  7%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.cfree
      0.21 ±  3%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.task_non_contending
      0.46 ±  3%      -0.1        0.40 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.36 ±  2%      -0.1        0.31 ±  3%  perf-profile.children.cycles-pp.reweight_task
      0.32 ±  2%      -0.1        0.26 ±  2%  perf-profile.children.cycles-pp.__sched_get_priority_max
      0.26 ±  5%      -0.1        0.21 ±  8%  perf-profile.children.cycles-pp.cpuacct_charge
      0.31 ±  2%      -0.0        0.26 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.14 ±  8%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.check_stack_object
      0.36 ±  3%      -0.0        0.31 ±  4%  perf-profile.children.cycles-pp.update_entity_lag
      0.37 ±  8%      -0.0        0.33 ±  2%  perf-profile.children.cycles-pp.sched_attr_copy_to_user
      0.48 ±  2%      -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.reweight_entity
      0.18 ±  6%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.shim_sched_getattr
      0.25 ±  2%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.18 ±  2%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.26            -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.16 ±  3%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.15 ±  3%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__enqueue_entity
      0.08            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.sched_tick
      0.07 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.12 ±  5%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.attach_entity_cfs_rq
      0.10 ±  5%      +0.0        0.11        perf-profile.children.cycles-pp.dl_server_update_idle_time
      0.10 ±  3%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__get_user_4
      0.09 ±  5%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.security_task_setscheduler
      0.44 ±  3%      +0.0        0.46 ±  2%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.12 ±  5%      +0.0        0.15 ±  8%  perf-profile.children.cycles-pp.update_min_vruntime
      0.16 ±  4%      +0.0        0.20 ±  5%  perf-profile.children.cycles-pp.stress_get_unused_pid_racy
      0.20 ±  7%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.propagate_entity_cfs_rq
      0.15 ±  2%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__dequeue_entity
      0.20 ±  3%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.place_entity
      0.38            +0.0        0.42 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.13 ±  4%      +0.0        0.17 ±  3%  perf-profile.children.cycles-pp.avg_vruntime
      0.02 ±141%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.syscall@plt
      0.10 ±  4%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.read_tsc
      0.13 ±  5%      +0.0        0.18 ±  5%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.28 ±  6%      +0.0        0.33 ±  4%  perf-profile.children.cycles-pp.get_params
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.shim_sched_setattr
      0.09 ±  5%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.update_curr_se
      0.08 ±  4%      +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.calloc@plt
      0.03 ±100%      +0.1        0.09 ± 12%  perf-profile.children.cycles-pp.security_task_getscheduler
      0.02 ±141%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__setscheduler_prio
      0.22 ±  3%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.native_sched_clock
      0.14 ±  9%      +0.1        0.21 ± 18%  perf-profile.children.cycles-pp.yield_task_rt
      0.17 ±  4%      +0.1        0.24 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.18 ±  6%      +0.1        0.26 ±  6%  perf-profile.children.cycles-pp.update_curr_common
      0.25 ±  4%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.sched_clock
      0.42 ±  4%      +0.1        0.50 ±  3%  perf-profile.children.cycles-pp.start_dl_timer
      0.42 ±  5%      +0.1        0.51 ±  4%  perf-profile.children.cycles-pp.__x64_sys_sched_getscheduler
      0.40 ± 13%      +0.1        0.49 ±  3%  perf-profile.children.cycles-pp.rt_mutex_adjust_pi
      0.31 ±  3%      +0.1        0.41 ±  2%  perf-profile.children.cycles-pp.task_contending
      0.34 ±  2%      +0.1        0.44 ±  3%  perf-profile.children.cycles-pp.set_next_entity
      0.41 ±  4%      +0.1        0.52 ±  4%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.34 ± 26%      +0.1        0.46 ±  5%  perf-profile.children.cycles-pp.process_simple
      0.38 ±  2%      +0.1        0.50 ±  3%  perf-profile.children.cycles-pp.set_next_task_fair
      0.26 ±  6%      +0.1        0.38 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.31 ±  3%      +0.1        0.43 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.32 ± 28%      +0.1        0.46 ±  6%  perf-profile.children.cycles-pp.ordered_events__queue
      0.32 ± 28%      +0.1        0.45 ±  7%  perf-profile.children.cycles-pp.queue_event
      0.64 ±  5%      +0.1        0.78 ±  2%  perf-profile.children.cycles-pp.stress_schedpolicy
      1.00 ±  6%      +0.2        1.16 ±  2%  perf-profile.children.cycles-pp.__sched_getparam
      0.49 ±  3%      +0.2        0.65 ±  3%  perf-profile.children.cycles-pp.find_task_by_vpid
      0.70 ±  4%      +0.2        0.88 ±  7%  perf-profile.children.cycles-pp.update_cfs_group
      0.89 ±  3%      +0.2        1.08 ±  2%  perf-profile.children.cycles-pp.enqueue_dl_entity
      0.90 ±  4%      +0.2        1.10 ±  2%  perf-profile.children.cycles-pp.dl_server_start
      1.01 ±  2%      +0.3        1.28 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.80 ±  6%      +0.3        1.15 ±  4%  perf-profile.children.cycles-pp.task_rq_lock
      1.58 ±  2%      +0.4        1.94 ±  3%  perf-profile.children.cycles-pp.do_sched_yield
      0.86 ±  7%      +0.4        1.24 ±  2%  perf-profile.children.cycles-pp._copy_from_user
      4.07 ±  3%      +0.4        4.46 ±  3%  perf-profile.children.cycles-pp.__x64_sys_sched_setattr
      7.96 ±  2%      +0.4        8.37        perf-profile.children.cycles-pp.sched_setparam
      1.84 ±  9%      +0.4        2.29 ±  3%  perf-profile.children.cycles-pp.__sched_getscheduler
      1.89 ±  2%      +0.5        2.38 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.19 ±  3%      +0.5        1.72 ±  3%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.76 ±  2%      +0.6        2.32 ±  8%  perf-profile.children.cycles-pp.enqueue_entity
      1.18 ±  4%      +0.6        1.75 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.28 ±  4%      +0.9        3.14 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      3.19 ±  2%      +0.9        4.06 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
     20.81 ±  2%      +1.3       22.10 ±  3%  perf-profile.children.cycles-pp.cpupri_set
      9.47 ±  4%      +1.3       10.78        perf-profile.children.cycles-pp.syscall
      3.26 ±  3%      +1.3        4.58 ±  6%  perf-profile.children.cycles-pp.__x64_sys_kill
      9.66 ±  2%      +1.4       11.02 ±  3%  perf-profile.children.cycles-pp.dequeue_rt_stack
      1.95 ±  2%      +1.4        3.34 ±  9%  perf-profile.children.cycles-pp.kill_something_info
      1.34 ±  4%      +1.4        2.76 ± 11%  perf-profile.children.cycles-pp.kill_pid_info_type
      0.69 ±  7%      +1.4        2.11 ± 15%  perf-profile.children.cycles-pp.apparmor_task_kill
      0.70 ±  7%      +1.4        2.12 ± 15%  perf-profile.children.cycles-pp.security_task_kill
      9.73 ±  2%      +1.6       11.32 ±  2%  perf-profile.children.cycles-pp.dequeue_task_rt
      4.30 ±  3%      +1.6        5.90 ±  5%  perf-profile.children.cycles-pp.kill
     15.12 ±  8%      +5.0       20.18 ±  7%  perf-profile.children.cycles-pp.balance_callbacks
     14.93 ±  8%      +5.1       20.05 ±  7%  perf-profile.children.cycles-pp.pull_rt_task
      0.92 ± 15%      +7.5        8.38 ± 21%  perf-profile.children.cycles-pp.apparmor_capable
      1.00 ± 14%      +7.5        8.46 ± 21%  perf-profile.children.cycles-pp.capable
      0.98 ± 14%      +7.5        8.44 ± 21%  perf-profile.children.cycles-pp.security_capable
     50.32           +15.1       65.46        perf-profile.children.cycles-pp._sched_setscheduler
     46.40 ±  2%     +15.9       62.25        perf-profile.children.cycles-pp.__x64_sys_sched_setscheduler
     53.30           +16.0       69.35        perf-profile.children.cycles-pp.do_sched_setscheduler
     99.83           +31.7      131.54        perf-profile.children.cycles-pp.__sched_setscheduler
     10.46           -10.5        0.00        perf-profile.self.cycles-pp.enqueue_pushable_task
      9.14 ±  3%      -9.1        0.00        perf-profile.self.cycles-pp.set_next_task_rt
      0.47 ±  4%      -0.3        0.20 ± 16%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.29 ± 12%      -0.2        0.07 ± 26%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.78 ±  2%      -0.2        0.58 ±  2%  perf-profile.self.cycles-pp.__hrtimer_start_range_ns
      0.18 ± 15%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
      0.40 ±  3%      -0.1        0.28 ±  2%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.14 ±  5%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.__x64_sys_sched_get_priority_max
      0.28 ±  4%      -0.1        0.16 ±  4%  perf-profile.self.cycles-pp.idle_cpu
      0.20 ±  2%      -0.1        0.11 ± 14%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.23 ±  3%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.reweight_task
      0.24 ± 12%      -0.1        0.16 ± 10%  perf-profile.self.cycles-pp.hrtimer_try_to_cancel
      0.23 ±  2%      -0.1        0.15 ± 12%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.24 ±  4%      -0.1        0.16 ±  5%  perf-profile.self.cycles-pp.update_entity_lag
      0.25 ±  6%      -0.1        0.18 ±  7%  perf-profile.self.cycles-pp.update_curr_dl_se
      0.14 ±  7%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.cfree
      0.18 ±  8%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.__remove_hrtimer
      0.26 ±  5%      -0.1        0.20 ±  8%  perf-profile.self.cycles-pp.cpuacct_charge
      0.17 ±  2%      -0.1        0.12 ±  5%  perf-profile.self.cycles-pp.task_non_contending
      0.14 ± 11%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.check_stack_object
      0.12 ±  6%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.timerqueue_del
      0.48 ±  2%      -0.0        0.43 ±  2%  perf-profile.self.cycles-pp.reweight_entity
      0.16 ±  4%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.16 ±  6%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.shim_sched_getattr
      0.23 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.kill_something_info
      0.16 ±  5%      -0.0        0.13 ±  6%  perf-profile.self.cycles-pp.pick_task_fair
      0.18 ±  3%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.__enqueue_entity
      0.15 ±  5%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.stress_mwc32modn
      0.15 ±  3%      -0.0        0.14        perf-profile.self.cycles-pp.find_vpid
      0.16            -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.task_rq_lock
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.start_dl_timer
      0.06 ±  6%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.timerqueue_add
      0.10 ±  7%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.pid_task
      0.06 ±  9%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.set_next_entity
      0.24 ±  3%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.__x64_sys_sched_getscheduler
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.place_entity
      0.05 ±  7%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__get_user_4
      0.36            +0.0        0.38 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.03 ± 70%      +0.0        0.06        perf-profile.self.cycles-pp.check_class_changed
      0.11            +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.__dequeue_entity
      0.10 ±  6%      +0.0        0.13 ±  7%  perf-profile.self.cycles-pp.update_min_vruntime
      0.13 ±  3%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.avg_vruntime
      0.13 ±  8%      +0.0        0.17 ±  6%  perf-profile.self.cycles-pp.stress_get_unused_pid_racy
      0.11 ±  4%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp._sched_setscheduler
      0.15 ±  3%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__calc_delta
      0.10 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__sched_getparam
      0.10 ±  3%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.__sched_yield
      0.10 ±  3%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.read_tsc
      0.11 ±  4%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.sched_setparam
      0.12 ±  6%      +0.0        0.17 ±  6%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.07 ±  6%      +0.0        0.12 ±  7%  perf-profile.self.cycles-pp.update_curr_se
      0.02 ±141%      +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.security_task_getscheduler
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.security_task_setscheduler
      0.28 ±  5%      +0.1        0.33 ±  4%  perf-profile.self.cycles-pp.get_params
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.dequeue_rt_stack
      0.15 ±  3%      +0.1        0.21 ±  4%  perf-profile.self.cycles-pp.find_task_by_vpid
      0.07 ±  6%      +0.1        0.13 ±  4%  perf-profile.self.cycles-pp.calloc@plt
      0.14 ±  4%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.32 ±  2%      +0.1        0.38 ±  3%  perf-profile.self.cycles-pp.kill
      0.21 ±  4%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
      0.14 ±  9%      +0.1        0.21 ± 18%  perf-profile.self.cycles-pp.yield_task_rt
      0.32 ±  2%      +0.1        0.40 ±  3%  perf-profile.self.cycles-pp.update_curr
      0.25 ±  4%      +0.1        0.33        perf-profile.self.cycles-pp.dequeue_entities
      0.00            +0.1        0.08 ±  7%  perf-profile.self.cycles-pp.__setscheduler_prio
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.dequeue_task_rt
      0.00            +0.1        0.08 ±  7%  perf-profile.self.cycles-pp.update_curr_common
      0.36 ±  4%      +0.1        0.46 ±  4%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.74            +0.1        0.84 ±  3%  perf-profile.self.cycles-pp.__schedule
      0.39 ±  4%      +0.1        0.50 ±  4%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.25 ±  5%      +0.1        0.36 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.32 ±  3%      +0.1        0.44 ±  3%  perf-profile.self.cycles-pp.__sched_getscheduler
      0.31 ±  3%      +0.1        0.43 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.39 ±  3%      +0.1        0.51 ±  3%  perf-profile.self.cycles-pp.update_load_avg
      0.55 ±  5%      +0.1        0.68 ±  2%  perf-profile.self.cycles-pp.stress_schedpolicy
      0.30 ± 28%      +0.1        0.44 ±  8%  perf-profile.self.cycles-pp.queue_event
      1.44 ±  3%      +0.1        1.58        perf-profile.self.cycles-pp.__sched_setscheduler
      0.37 ±  3%      +0.1        0.52 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.51 ± 12%      +0.2        0.69 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.68 ±  5%      +0.2        0.87 ±  7%  perf-profile.self.cycles-pp.update_cfs_group
      0.57 ±  4%      +0.2        0.78 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      1.13 ±  5%      +0.2        1.36 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.83 ±  2%      +0.2        1.06 ± 20%  perf-profile.self.cycles-pp.enqueue_entity
      0.46 ±  4%      +0.2        0.71 ±  2%  perf-profile.self.cycles-pp.do_sched_yield
      2.14 ±  4%      +0.3        2.49 ±  4%  perf-profile.self.cycles-pp.__x64_sys_sched_setattr
      0.84 ±  7%      +0.4        1.23 ±  2%  perf-profile.self.cycles-pp._copy_from_user
      0.92 ±  3%      +0.4        1.30 ±  3%  perf-profile.self.cycles-pp.syscall
      1.16 ±  3%      +0.5        1.68 ±  3%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.10 ±  6%      +0.5        2.63 ±  6%  perf-profile.self.cycles-pp.do_sched_setscheduler
      1.16 ±  4%      +0.6        1.72 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
     20.81 ±  2%      +1.3       22.10 ±  3%  perf-profile.self.cycles-pp.cpupri_set
      0.46 ±  8%      +1.4        1.86 ± 17%  perf-profile.self.cycles-pp.apparmor_task_kill
     14.67 ±  8%      +5.2       19.82 ±  7%  perf-profile.self.cycles-pp.pull_rt_task
      0.92 ± 15%      +7.4        8.35 ± 21%  perf-profile.self.cycles-pp.apparmor_capable


***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/schedmix/stress-ng/60s

commit: 
  fd03c5b858 ("sched: Rework pick_next_task()")
  436f3eed5c ("sched: Combine the last put_prev_task() and the first set_next_task()")

fd03c5b8585562d6 436f3eed5c69c1048a5754df6e3 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1329283 ±  8%     -55.9%     586475 ±  7%  cpuidle..usage
    501.33 ± 23%    +441.6%       2715 ± 38%  perf-c2c.DRAM.local
      3504 ± 12%    +144.8%       8578 ± 27%  perf-c2c.DRAM.remote
      6.15 ±  3%    +169.5%      16.58        vmstat.cpu.us
   4460484 ±  3%    +269.6%   16486639        vmstat.system.cs
   1072137 ±  2%    +106.4%    2212987        vmstat.system.in
    901633 ±  5%    +176.2%    2490109 ±  2%  numa-numastat.node0.local_node
    930030 ±  4%    +171.0%    2520501        numa-numastat.node0.numa_hit
   1786077 ± 16%    +151.9%    4499452 ±  3%  numa-numastat.node1.local_node
   1824169 ± 16%    +148.6%    4535494 ±  2%  numa-numastat.node1.numa_hit
      5.05 ±  6%      -1.1        3.97 ± 16%  mpstat.cpu.all.idle%
      6.55            +2.1        8.62        mpstat.cpu.all.irq%
      4.90 ±  2%     +10.2       15.09        mpstat.cpu.all.nice%
      0.07 ±  3%      +0.0        0.07        mpstat.cpu.all.soft%
     82.02           -11.8       70.25        mpstat.cpu.all.sys%
      1.40 ±  9%      +0.6        1.99        mpstat.cpu.all.usr%
   2112125 ± 47%     +64.1%    3465012 ± 25%  numa-meminfo.node0.MemUsed
   4262703 ± 24%     +49.7%    6382065 ± 13%  numa-meminfo.node1.FilePages
   2505515 ± 25%    +128.1%    5716279 ±  5%  numa-meminfo.node1.Inactive
   2505469 ± 25%    +128.1%    5716160 ±  5%  numa-meminfo.node1.Inactive(anon)
   1032373 ± 19%     +94.4%    2007340 ±  3%  numa-meminfo.node1.Mapped
   5479287 ± 17%     +36.4%    7476197 ± 10%  numa-meminfo.node1.MemUsed
   2080788 ± 31%    +160.2%    5414423 ±  5%  numa-meminfo.node1.Shmem
   5253201 ± 12%     +63.7%    8598493 ±  3%  meminfo.Cached
  11935679 ±  5%     +28.3%   15311437        meminfo.Committed_AS
   2927263 ± 23%    +112.9%    6232579 ±  4%  meminfo.Inactive
   2927030 ± 23%    +112.9%    6232341 ±  4%  meminfo.Inactive(anon)
   1191997 ± 16%     +82.9%    2180565 ±  3%  meminfo.Mapped
   7602808 ±  8%     +43.8%   10929787 ±  2%  meminfo.Memused
   2138071 ± 29%    +156.5%    5483341 ±  4%  meminfo.Shmem
   7718502 ±  8%     +43.1%   11048660 ±  2%  meminfo.max_used_kB
   1023045 ±  2%    +193.7%    3004809        stress-ng.schedmix.ops
     16996 ±  2%    +194.5%      50050        stress-ng.schedmix.ops_per_sec
 2.148e+08 ±  3%    +303.8%  8.672e+08        stress-ng.time.involuntary_context_switches
   1699888 ±  4%    +187.8%    4891548 ±  2%  stress-ng.time.minor_page_faults
      5770            -2.5%       5626        stress-ng.time.percent_of_cpu_this_job_got
      3296           -16.1%       2766        stress-ng.time.system_time
    208.03 ±  2%    +204.1%     632.61        stress-ng.time.user_time
  70560494 ±  2%    +175.9%  1.947e+08        stress-ng.time.voluntary_context_switches
     34866 ± 26%     +33.1%      46408 ± 15%  numa-vmstat.node0.nr_mapped
    929273 ±  4%    +171.1%    2519710        numa-vmstat.node0.numa_hit
    900876 ±  5%    +176.3%    2489317 ±  2%  numa-vmstat.node0.numa_local
   1067042 ± 25%     +49.4%    1593726 ± 13%  numa-vmstat.node1.nr_file_pages
    627262 ± 25%    +127.7%    1427981 ±  5%  numa-vmstat.node1.nr_inactive_anon
    260039 ± 21%     +92.1%     499606 ±  2%  numa-vmstat.node1.nr_mapped
    521564 ± 32%    +159.2%    1351815 ±  5%  numa-vmstat.node1.nr_shmem
    627261 ± 25%    +127.7%    1427980 ±  5%  numa-vmstat.node1.nr_zone_inactive_anon
   1822280 ± 16%    +148.8%    4533894 ±  2%  numa-vmstat.node1.numa_hit
   1784187 ± 16%    +152.1%    4497853 ±  3%  numa-vmstat.node1.numa_local
   6366589            -1.3%    6282930        proc-vmstat.nr_dirty_background_threshold
  12748745            -1.3%   12581223        proc-vmstat.nr_dirty_threshold
   1309610 ± 12%     +64.3%    2151524 ±  3%  proc-vmstat.nr_file_pages
  64043965            -1.3%   63206172        proc-vmstat.nr_free_pages
    725461 ± 24%    +115.0%    1559454 ±  4%  proc-vmstat.nr_inactive_anon
     30950            -1.8%      30397        proc-vmstat.nr_kernel_stack
    293234 ± 16%     +86.6%     547292 ±  3%  proc-vmstat.nr_mapped
    530827 ± 30%    +158.6%    1372735 ±  4%  proc-vmstat.nr_shmem
     25670            +8.4%      27818        proc-vmstat.nr_slab_reclaimable
    725461 ± 24%    +115.0%    1559454 ±  4%  proc-vmstat.nr_zone_inactive_anon
    106246 ± 18%     +54.7%     164313 ± 14%  proc-vmstat.numa_hint_faults
   2756177 ± 10%    +156.1%    7058084        proc-vmstat.numa_hit
   2689688 ± 10%    +159.9%    6991649        proc-vmstat.numa_local
   2985527 ±  9%    +147.4%    7387201        proc-vmstat.pgalloc_normal
   2199862 ±  5%    +149.8%    5495072 ±  2%  proc-vmstat.pgfault
   2149300 ±  2%    +147.3%    5314173 ±  2%  proc-vmstat.pgfree
    161585 ±  8%    +174.6%     443757 ± 13%  proc-vmstat.pgreuse
      0.78 ±  4%     -42.9%       0.44 ±  2%  perf-stat.i.MPKI
 1.976e+10 ±  6%    +145.5%   4.85e+10        perf-stat.i.branch-instructions
      0.63 ±  4%      -0.1        0.57        perf-stat.i.branch-miss-rate%
 1.277e+08 ±  3%    +106.5%  2.636e+08        perf-stat.i.branch-misses
     21.58 ±  3%      +5.2       26.74        perf-stat.i.cache-miss-rate%
  61139920 ±  3%     +39.3%   85164865 ±  3%  perf-stat.i.cache-misses
  2.85e+08 ±  4%     +13.8%  3.244e+08 ±  2%  perf-stat.i.cache-references
   4977196 ±  4%    +249.3%   17384625        perf-stat.i.context-switches
      3.11 ±  4%     -63.5%       1.13        perf-stat.i.cpi
     72568 ±  2%     -11.0%      64602        perf-stat.i.cpu-clock
 2.411e+11 ±  3%      -8.6%  2.205e+11        perf-stat.i.cpu-cycles
      4025 ±  2%     -35.1%       2610 ±  2%  perf-stat.i.cycles-between-cache-misses
 8.256e+10 ±  6%    +138.8%  1.971e+11        perf-stat.i.instructions
      0.35 ±  4%    +153.4%       0.89        perf-stat.i.ipc
     74.99 ±  2%    +268.8%     276.54        perf-stat.i.metric.K/sec
     38873 ±  5%    +127.1%      88279        perf-stat.i.minor-faults
     38872 ±  5%    +127.1%      88279        perf-stat.i.page-faults
     72568 ±  2%     -11.0%      64602        perf-stat.i.task-clock
     17.63 ± 44%      +8.5       26.11        perf-stat.overall.cache-miss-rate%
      0.29 ± 44%    +206.3%       0.89        perf-stat.overall.ipc
 1.525e+10 ± 44%    +210.3%  4.731e+10        perf-stat.ps.branch-instructions
  88234830 ± 44%    +190.8%  2.566e+08        perf-stat.ps.branch-misses
  44697585 ± 44%     +86.4%   83314631 ±  2%  perf-stat.ps.cache-misses
 2.113e+08 ± 44%     +51.0%  3.191e+08        perf-stat.ps.cache-references
   3836753 ± 44%    +342.7%   16985331        perf-stat.ps.context-switches
 6.353e+10 ± 44%    +202.5%  1.922e+11        perf-stat.ps.instructions
     28537 ± 44%    +202.5%      86319        perf-stat.ps.minor-faults
     28537 ± 44%    +202.5%      86319        perf-stat.ps.page-faults
 4.026e+12 ± 44%    +199.3%  1.205e+13        perf-stat.total.instructions
   7170794 ±  7%     +68.5%   12085665        sched_debug.cfs_rq:/.avg_vruntime.avg
  16990617 ± 15%     +28.5%   21839905 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.max
   3592295 ±  5%    +174.8%    9872621 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.min
   2813087 ± 12%     -23.4%    2153945 ± 13%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      9.11 ± 14%     -25.5%       6.79 ±  9%  sched_debug.cfs_rq:/.h_nr_running.stddev
      6.83 ±  3%     -10.6%       6.11 ±  3%  sched_debug.cfs_rq:/.idle_h_nr_running.avg
      8.75 ± 14%     -27.3%       6.36 ± 10%  sched_debug.cfs_rq:/.idle_h_nr_running.stddev
   4024534 ± 10%     -36.8%    2545261 ± 15%  sched_debug.cfs_rq:/.left_deadline.avg
   4066114 ± 10%     +25.0%    5081531 ±  9%  sched_debug.cfs_rq:/.left_deadline.stddev
   4011141 ± 10%     -37.7%    2498715 ± 15%  sched_debug.cfs_rq:/.left_vruntime.avg
   4039705 ±  9%     +23.2%    4977858 ±  9%  sched_debug.cfs_rq:/.left_vruntime.stddev
    124146 ± 46%     -82.3%      21963 ± 34%  sched_debug.cfs_rq:/.load.avg
    291917 ± 17%     -49.9%     146292 ± 33%  sched_debug.cfs_rq:/.load.stddev
   7170854 ±  7%     +68.5%   12085679        sched_debug.cfs_rq:/.min_vruntime.avg
  16990677 ± 15%     +28.5%   21839905 ± 11%  sched_debug.cfs_rq:/.min_vruntime.max
   3592299 ±  5%    +174.8%    9872801 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
   2813100 ± 12%     -23.4%    2153935 ± 13%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.51 ±  4%     -35.8%       0.33 ± 11%  sched_debug.cfs_rq:/.nr_running.stddev
   4013446 ± 10%     -37.7%    2499469 ± 15%  sched_debug.cfs_rq:/.right_vruntime.avg
   4043763 ±  9%     +23.2%    4983635 ±  9%  sched_debug.cfs_rq:/.right_vruntime.stddev
      8483 ±  6%     -22.3%       6587 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
    399.78 ±  9%     +48.6%     594.04 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
      0.08 ±223%  +61700.0%      51.50 ±105%  sched_debug.cfs_rq:/.util_avg.min
    191419 ±  6%     -13.4%     165768 ±  7%  sched_debug.cpu.avg_idle.stddev
      2730 ± 20%     +71.7%       4688 ± 27%  sched_debug.cpu.curr->pid.avg
     24693 ±  2%    +165.6%      65597        sched_debug.cpu.curr->pid.max
      4139 ± 31%    +209.7%      12820 ± 22%  sched_debug.cpu.curr->pid.stddev
      9.07 ± 14%     -24.9%       6.81 ±  7%  sched_debug.cpu.nr_running.stddev
   2201723 ±  3%    +270.0%    8147459        sched_debug.cpu.nr_switches.avg
   2719688 ±  4%    +228.3%    8929555 ±  2%  sched_debug.cpu.nr_switches.max
   1671126 ±  7%    +275.0%    6267006 ± 10%  sched_debug.cpu.nr_switches.min
    221514 ± 10%    +118.2%     483395 ± 11%  sched_debug.cpu.nr_switches.stddev
      0.34 ±  4%     -65.3%       0.12 ±  7%  sched_debug.rt_rq:.rt_nr_running.avg
      1.00           -50.0%       0.50        sched_debug.rt_rq:.rt_nr_running.max
      0.25 ±  2%     -14.5%       0.21 ±  2%  sched_debug.rt_rq:.rt_nr_running.stddev
      0.00 ±223%   +2516.7%       0.10 ± 76%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      7.01 ± 88%     -71.2%       2.02 ± 57%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.03 ±139%  +27937.4%       7.62 ±217%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_file_alloc.init_file.alloc_empty_file
      0.04 ±191%   +3206.3%       1.39 ± 84%  perf-sched.sch_delay.avg.ms.__cond_resched.migrate_pages_batch.migrate_pages.migrate_misplaced_folio.do_numa_page
      0.01 ±223%   +4897.1%       0.28 ± 72%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
     10.20 ± 52%     -80.5%       1.99 ± 36%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.24 ±120%    +546.1%       1.56 ± 46%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.exit_mmap.mmput.exit_mm
      2.17 ± 22%     -77.5%       0.49 ±  4%  perf-sched.sch_delay.avg.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.01 ± 33%     -80.0%       0.20 ±  8%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     16.19 ± 99%     -85.8%       2.30 ± 52%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      8.70 ± 61%     -80.6%       1.69 ± 45%  perf-sched.sch_delay.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      3.20 ± 28%     -64.3%       1.14 ±  7%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      7.61 ± 44%     -88.6%       0.87 ± 43%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      9.80 ± 91%     -81.2%       1.84 ± 97%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.02 ±106%   +3666.7%       0.64 ±109%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
      1.77 ± 77%     -76.6%       0.41 ± 89%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3.20 ± 15%     -63.7%       1.16 ± 12%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.10 ±103%     -70.0%       0.03 ± 18%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown]
      0.00 ±223%  +13241.7%       0.53 ± 93%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
     10.41 ±109%    +715.3%      84.87 ± 77%  perf-sched.sch_delay.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
    651.52 ± 81%     -70.1%     194.70 ± 29%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.20 ±170%   +1669.2%       3.56 ±152%  perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.51 ±118%    +461.3%       2.84 ±118%  perf-sched.sch_delay.max.ms.__cond_resched.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      1.67 ± 87%   +1018.5%      18.69 ±135%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_dup_alloc.isra.0
      0.39 ±110%   +9499.0%      37.74 ±148%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.copy_fs_struct.copy_process.kernel_clone
      0.40 ±223%   +7995.6%      32.57 ±214%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.seq_open.single_open.do_dentry_open
      0.08 ±171%   +4478.9%       3.79 ±121%  perf-sched.sch_delay.max.ms.__cond_resched.migrate_pages_batch.migrate_pages.migrate_misplaced_folio.do_numa_page
      2.81 ±126%    +522.6%      17.50 ± 96%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.02 ± 35%    +243.0%       0.09 ± 84%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
      0.01 ±223%   +9764.7%       0.56 ± 91%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
      1.70 ± 67%   +1664.0%      30.06 ±129%  perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.exit_mmap.mmput.exit_mm
      2.41 ± 38%    +178.4%       6.70 ± 40%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      1590 ± 72%     -84.2%     251.19 ± 52%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.35 ±185%    +676.0%       2.72 ± 83%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap.mmput
      0.34 ± 93%   +4033.8%      14.17 ± 59%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.exit_mmap.mmput.exit_mm
      0.01 ±114%   +4842.1%       0.31 ±131%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      3736 ±  9%     -25.8%       2773 ± 14%  perf-sched.sch_delay.max.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2854 ± 19%     -51.5%       1384 ± 43%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      2450 ± 48%     -54.0%       1128 ± 37%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2599 ± 24%     -59.3%       1057 ± 16%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1808 ± 41%     -86.9%     237.44 ± 31%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    716.17 ± 96%     -77.7%     159.51 ± 96%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.02 ± 91%   +8601.7%       1.71 ±123%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.anon_vma_clone
      1167 ± 53%     -73.6%     308.17 ± 44%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1328 ± 57%     +81.9%       2416 ± 23%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.77 ± 22%     -75.6%       0.43 ±  4%  perf-sched.total_sch_delay.average.ms
      3.64 ± 22%     -74.5%       0.93 ±  4%  perf-sched.total_wait_and_delay.average.ms
   2114061 ± 30%    +409.3%   10765934 ±  5%  perf-sched.total_wait_and_delay.count.ms
      1.87 ± 22%     -73.4%       0.50 ±  5%  perf-sched.total_wait_time.average.ms
     14.23 ± 87%     -70.3%       4.23 ± 58%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
     20.41 ± 52%     -80.2%       4.04 ± 38%  perf-sched.wait_and_delay.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.34 ± 22%     -77.4%       0.98 ±  4%  perf-sched.wait_and_delay.avg.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.06 ± 33%     -77.8%       0.46 ±  7%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     11.18 ± 26%     -66.1%       3.80 ±  6%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     32.99 ±104%     -84.1%       5.25 ± 46%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     18.04 ± 60%     -78.6%       3.85 ± 38%  perf-sched.wait_and_delay.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      6.45 ± 28%     -63.0%       2.39 ±  7%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     15.51 ± 44%     -89.6%       1.62 ± 58%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     19.66 ± 91%     -81.4%       3.67 ±101%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      6.45 ± 15%     -61.1%       2.51 ± 10%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      7.83 ±142%    +506.4%      47.50 ± 15%  perf-sched.wait_and_delay.count.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
    128.00 ± 39%    +187.4%     367.83 ± 32%  perf-sched.wait_and_delay.count.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
    158.50 ± 24%    +344.0%     703.67 ±103%  perf-sched.wait_and_delay.count.__cond_resched.down_write.dup_mmap.dup_mm.constprop
     11.33 ±223%   +1779.4%     213.00 ± 22%  perf-sched.wait_and_delay.count.__cond_resched.down_write.free_pgtables.exit_mmap.mmput
      7.83 ±113%    +780.9%      69.00 ± 13%  perf-sched.wait_and_delay.count.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
     96.00 ±100%    +641.0%     711.33 ± 18%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
     60.00 ±112%    +463.6%     338.17 ± 61%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
    413.00 ± 26%    +156.8%       1060 ± 16%  perf-sched.wait_and_delay.count.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     73.67 ±178%    +982.6%     797.50 ± 51%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
   1335170 ± 33%    +518.5%    8257668 ±  5%  perf-sched.wait_and_delay.count.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    722734 ± 27%    +223.2%    2335566 ±  6%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     23.50 ±130%   +1339.0%     338.17 ± 83%  perf-sched.wait_and_delay.count.do_signal_stop.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
    450.50 ± 25%    +190.5%       1308 ±  6%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1315 ± 76%    +270.1%       4869 ± 36%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1102 ± 57%    +208.2%       3396 ± 29%  perf-sched.wait_and_delay.count.futex_wait_queue.__futex_wait.futex_wait.do_futex
     13884 ± 36%    +253.4%      49061 ±  5%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    453.83 ± 75%    +441.2%       2456 ± 27%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     82.67 ±113%    +297.6%     328.67 ± 88%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.67 ± 77%   +8112.5%     219.00 ±134%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.17 ±115%  +11557.1%     136.00 ±166%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
     10034 ± 19%    +244.5%      34566 ±  8%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     10506 ± 29%    +154.9%      26784 ± 12%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1303 ± 81%     -69.1%     402.46 ± 30%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      3181 ± 72%     -84.2%     502.37 ± 52%  perf-sched.wait_and_delay.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7472 ±  9%     -25.8%       5546 ± 14%  perf-sched.wait_and_delay.max.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5708 ± 19%     -51.1%       2789 ± 44%  perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    983.04 ± 25%     -40.7%     582.93 ± 25%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      4412 ± 33%     -54.7%       1997 ± 39%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      5199 ± 24%     -59.3%       2114 ± 16%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      3617 ± 41%     -88.3%     421.69 ± 54%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1432 ± 96%     -87.4%     181.14 ±123%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    337.98 ±112%    +422.9%       1767 ± 63%  perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00 ±223%  +24379.2%       0.98 ±134%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      7.22 ± 86%     -69.4%       2.21 ± 58%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.04 ±132%  +21316.4%       7.64 ±216%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_file_alloc.init_file.alloc_empty_file
      0.04 ±191%   +3222.5%       1.40 ± 83%  perf-sched.wait_time.avg.ms.__cond_resched.migrate_pages_batch.migrate_pages.migrate_misplaced_folio.do_numa_page
      0.01 ±223%   +4897.1%       0.28 ± 72%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
     10.20 ± 52%     -79.9%       2.05 ± 40%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.24 ±120%   +4003.8%       9.89 ±192%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.exit_mmap.mmput.exit_mm
      2.17 ± 22%     -77.4%       0.49 ±  4%  perf-sched.wait_time.avg.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.06 ± 32%     -75.7%       0.26 ±  7%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     11.18 ± 26%     -66.1%       3.80 ±  6%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      9.34 ± 60%     -76.8%       2.17 ± 34%  perf-sched.wait_time.avg.ms.futex_wait_queue.__futex_wait.futex_wait.do_futex
      3.25 ± 28%     -61.7%       1.24 ±  7%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      7.90 ± 44%     -88.9%       0.88 ± 43%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      9.86 ± 91%     -80.7%       1.90 ± 98%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      3.02 ± 97%     -77.1%       0.69 ± 87%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3.26 ± 16%     -58.5%       1.35 ±  8%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.03 ±154%   +4011.2%       1.16 ±142%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.00 ±223%  +59258.3%       2.37 ±120%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
    651.54 ± 81%     -68.1%     207.76 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      0.20 ±170%   +3202.1%       6.64 ±114%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.51 ±118%    +461.3%       2.84 ±118%  perf-sched.wait_time.max.ms.__cond_resched.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      1.75 ± 80%   +1000.8%      19.28 ±129%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_dup_alloc.isra.0
      0.40 ±223%   +8001.3%      32.59 ±214%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.seq_open.single_open.do_dentry_open
      0.08 ±171%   +4478.9%       3.79 ±121%  perf-sched.wait_time.max.ms.__cond_resched.migrate_pages_batch.migrate_pages.migrate_misplaced_folio.do_numa_page
      2.81 ±126%    +270.6%      10.42 ± 58%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.02 ± 35%    +243.0%       0.09 ± 84%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
      0.01 ±223%   +9764.7%       0.56 ± 91%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
      1.70 ± 67%   +1648.4%      29.80 ±131%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.exit_mmap.mmput.exit_mm
      2.41 ± 38%    +178.4%       6.70 ± 40%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      1590 ± 72%     -84.2%     251.19 ± 52%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.35 ±185%    +676.0%       2.72 ± 83%  perf-sched.wait_time.max.ms.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap.mmput
      0.34 ± 93%  +51286.6%     176.08 ±209%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.exit_mmap.mmput.exit_mm
    166.62 ±223%    +599.8%       1166 ±103%  perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      3736 ±  9%     -25.8%       2773 ± 14%  perf-sched.wait_time.max.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2854 ± 19%     -45.5%       1555 ± 42%  perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    983.04 ± 25%     -40.7%     582.93 ± 25%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      2599 ± 24%     -59.3%       1057 ± 16%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1808 ± 41%     -86.9%     237.62 ± 31%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    716.18 ± 96%     -77.7%     159.63 ± 96%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    834.18 ± 82%    +140.3%       2004 ± 49%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    253.74 ±152%    +530.3%       1599 ± 56%  perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1312 ± 51%     -75.6%     320.16 ± 41%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.15 ±128%  +2.3e+05%     335.61 ±140%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     64.29           -38.6       25.71        perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
     64.64           -37.9       26.70        perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     72.02           -34.3       37.68        perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     74.74           -28.2       46.59        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     28.02           -28.0        0.00        perf-profile.calltrace.cycles-pp.enqueue_pushable_task.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
     74.98           -27.6       47.42        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
     20.77           -20.8        0.00        perf-profile.calltrace.cycles-pp.set_next_task_rt.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
     79.08           -16.1       62.93        perf-profile.calltrace.cycles-pp.__sched_yield
      2.78 ±  3%      -1.3        1.44        perf-profile.calltrace.cycles-pp._raw_spin_lock.raw_spin_rq_lock_nested.do_sched_yield.__x64_sys_sched_yield.do_syscall_64
      2.82 ±  3%      -1.3        1.55        perf-profile.calltrace.cycles-pp.raw_spin_rq_lock_nested.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.67 ±  2%      -1.2        1.51        perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      1.12 ±  5%      -0.4        0.74 ±  4%  perf-profile.calltrace.cycles-pp.set_next_task_rt.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      1.05 ±  5%      -0.3        0.74 ±  5%  perf-profile.calltrace.cycles-pp.enqueue_pushable_task.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues
      0.73 ±  2%      -0.1        0.58        perf-profile.calltrace.cycles-pp.irq_work_single.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      0.63 ±  3%      +0.2        0.86        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.76 ±  8%      +0.3        1.04 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_task_rt.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues
      0.72 ±  9%      +0.3        1.02 ±  4%  perf-profile.calltrace.cycles-pp.cpupri_set.enqueue_task_rt.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup
      0.63 ± 10%      +0.5        1.10 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.63 ± 10%      +0.5        1.10 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.56 ± 10%      +0.5        1.04 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.56 ± 10%      +0.5        1.04 ±  3%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64
      0.56 ± 10%      +0.5        1.04 ±  3%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.56 ± 10%      +0.5        1.04 ±  3%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.21 ±141%      +0.5        0.74 ±  8%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
      0.22 ±141%      +0.5        0.74 ±  8%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
      0.22 ±141%      +0.6        0.78 ±  8%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.native_sched_clock.sched_clock.sched_clock_cpu.update_rq_clock.__schedule
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.__switch_to.__sched_yield
      0.00            +0.6        0.57 ±  2%  perf-profile.calltrace.cycles-pp.update_load_avg.set_next_entity.pick_next_task_fair.__schedule.schedule
      0.00            +0.6        0.57 ±  3%  perf-profile.calltrace.cycles-pp.update_rq_clock_task.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.os_xsave.__sched_yield
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.26 ±100%      +0.6        0.86        perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1.07 ±  3%      +0.6        1.68 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule.__x64_sys_sched_yield
      0.36 ± 71%      +0.6        0.98 ±  3%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.exit_mm.do_exit.do_group_exit
      0.00            +0.6        0.62        perf-profile.calltrace.cycles-pp.sched_clock.sched_clock_cpu.update_rq_clock.__schedule.schedule
      0.37 ± 71%      +0.6        0.99 ±  3%  perf-profile.calltrace.cycles-pp.mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      0.37 ± 71%      +0.6        0.99 ±  3%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.00            +0.6        0.64 ±  2%  perf-profile.calltrace.cycles-pp.__get_user_8.rseq_get_rseq_cs.rseq_ip_fixup.__rseq_handle_notify_resume.syscall_exit_to_user_mode
      0.00            +0.6        0.65 ±  2%  perf-profile.calltrace.cycles-pp.___perf_sw_event.prepare_task_switch.__schedule.schedule.__x64_sys_sched_yield
      0.00            +0.6        0.65        perf-profile.calltrace.cycles-pp.update_load_avg.put_prev_entity.pick_next_task_fair.__schedule.schedule
      0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.setpriority
      0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.__schedule.schedule.do_nanosleep
      0.00            +0.7        0.70        perf-profile.calltrace.cycles-pp.native_sched_clock.sched_clock.sched_clock_cpu.update_rq_clock.yield_task_fair
      0.57 ±  6%      +0.7        1.28        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.00            +0.7        0.71        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.00            +0.7        0.73        perf-profile.calltrace.cycles-pp.sched_clock_cpu.update_rq_clock.__schedule.schedule.__x64_sys_sched_yield
      0.00            +0.7        0.74        perf-profile.calltrace.cycles-pp.__getpid
      0.00            +0.8        0.76 ±  2%  perf-profile.calltrace.cycles-pp.rseq_get_rseq_cs.rseq_ip_fixup.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64
      0.00            +0.8        0.77 ±  2%  perf-profile.calltrace.cycles-pp.sched_clock.sched_clock_cpu.update_rq_clock.yield_task_fair.do_sched_yield
      1.11 ±  3%      +0.8        1.88        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      0.00            +0.8        0.81        perf-profile.calltrace.cycles-pp.__enqueue_entity.put_prev_entity.pick_next_task_fair.__schedule.schedule
      0.50 ± 45%      +0.8        1.31 ±  2%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      0.00            +0.8        0.82 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule.syscall_exit_to_user_mode
      0.00            +0.8        0.84        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch
      0.00            +0.8        0.84 ±  3%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64
      0.00            +0.9        0.85        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch.__schedule
      1.05 ±  8%      +0.9        1.91 ±  3%  perf-profile.calltrace.cycles-pp.cpupri_set.dequeue_rt_stack.dequeue_task_rt.__schedule.schedule
      0.00            +0.9        0.86        perf-profile.calltrace.cycles-pp.__switch_to_asm.__sched_yield
      0.00            +0.9        0.87        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch.__schedule.schedule
      1.07 ±  8%      +0.9        1.94 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_rt_stack.dequeue_task_rt.__schedule.schedule.do_nanosleep
      2.47 ±  5%      +0.9        3.35 ±  2%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      1.16 ±  7%      +0.9        2.06 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_task_rt.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.00            +0.9        0.91 ±  2%  perf-profile.calltrace.cycles-pp.sched_clock_cpu.update_rq_clock.yield_task_fair.do_sched_yield.__x64_sys_sched_yield
      3.12 ±  4%      +0.9        4.03 ±  2%  perf-profile.calltrace.cycles-pp.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.9        0.92 ±  2%  perf-profile.calltrace.cycles-pp.__dequeue_entity.set_next_entity.pick_next_task_fair.__schedule.schedule
      3.12 ±  4%      +0.9        4.05 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.9        0.93        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.finish_task_switch.__schedule.schedule.do_nanosleep
      0.00            +0.9        0.94        perf-profile.calltrace.cycles-pp.vruntime_eligible.pick_eevdf.pick_task_fair.pick_next_task_fair.__schedule
      3.26 ±  4%      +1.0        4.22 ±  2%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.72 ±  6%      +1.0        3.69 ±  3%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.00            +1.0        1.04        perf-profile.calltrace.cycles-pp.update_rq_clock.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      0.00            +1.1        1.12        perf-profile.calltrace.cycles-pp.getpriority
      3.41 ±  4%      +1.1        4.56 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch
      0.00            +1.2        1.17        perf-profile.calltrace.cycles-pp.update_rq_clock.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64
      0.00            +1.2        1.18        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__sched_yield
      0.64 ± 10%      +1.2        1.83        perf-profile.calltrace.cycles-pp.switch_fpu_return.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      3.46 ±  4%      +1.2        4.68 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule
      0.00            +1.3        1.27 ±  2%  perf-profile.calltrace.cycles-pp.rseq_ip_fixup.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.51 ±  4%      +1.3        4.82 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule
      0.00            +1.4        1.35 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.4        1.36 ±  3%  perf-profile.calltrace.cycles-pp.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.96 ±  4%      +1.4        2.39        perf-profile.calltrace.cycles-pp.update_curr.pick_task_fair.pick_next_task_fair.__schedule.schedule
      2.80 ±  6%      +1.5        4.28        perf-profile.calltrace.cycles-pp.update_curr.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64
      0.00            +1.5        1.52        perf-profile.calltrace.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.22 ± 11%      +1.5        2.77        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      1.24 ±  4%      +1.6        2.80        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.00            +1.6        1.63 ±  2%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      0.44 ± 44%      +1.8        2.28        perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.00            +1.9        1.87        perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      0.77 ±  3%      +2.1        2.84        perf-profile.calltrace.cycles-pp.pick_eevdf.pick_task_fair.pick_next_task_fair.__schedule.schedule
      7.19 ±  3%      +3.2       10.34        perf-profile.calltrace.cycles-pp.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     10.07 ±  5%      +3.2       13.24 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep
     10.12 ±  5%      +3.3       13.37 ±  2%  perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1.34 ±  3%      +3.3        4.67        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__sched_yield
      3.54 ±  5%      +3.4        6.95        perf-profile.calltrace.cycles-pp.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.97 ±  5%      +3.6       14.58 ±  2%  perf-profile.calltrace.cycles-pp.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64
     11.07 ±  5%      +3.8       14.89 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.08 ±  5%      +3.8       14.92 ±  2%  perf-profile.calltrace.cycles-pp.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      1.64 ±  3%      +4.1        5.72        perf-profile.calltrace.cycles-pp.clear_bhb_loop.__sched_yield
     11.21 ±  5%      +4.1       15.32 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      2.04 ±  3%      +4.2        6.27        perf-profile.calltrace.cycles-pp.pick_task_fair.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      2.07 ±  8%      +4.7        6.73        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      2.27            +5.2        7.44        perf-profile.calltrace.cycles-pp.stress_schedmix
     12.51 ±  4%      +5.8       18.30        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     12.52 ±  4%      +5.8       18.34        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     13.12 ±  4%      +6.9       20.04        perf-profile.calltrace.cycles-pp.clock_nanosleep
      3.07 ±  4%      +7.5       10.54        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
     72.10           -34.2       37.91        perf-profile.children.cycles-pp.__x64_sys_sched_yield
     76.12           -33.4       42.76        perf-profile.children.cycles-pp.__schedule
     76.02           -33.0       43.00        perf-profile.children.cycles-pp.schedule
     29.65           -28.1        1.54 ±  3%  perf-profile.children.cycles-pp.enqueue_pushable_task
     22.29           -20.8        1.53 ±  3%  perf-profile.children.cycles-pp.set_next_task_rt
     89.28           -20.4       68.83        perf-profile.children.cycles-pp.do_syscall_64
     89.64           -19.5       70.19        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     79.37           -16.0       63.38        perf-profile.children.cycles-pp.__sched_yield
      6.89 ±  2%      -3.0        3.89        perf-profile.children.cycles-pp._raw_spin_lock
      2.87 ±  2%      -1.2        1.70        perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      1.03 ±  2%      -0.9        0.09        perf-profile.children.cycles-pp.put_prev_task_rt
      0.85 ±  2%      -0.7        0.11 ±  4%  perf-profile.children.cycles-pp.update_curr_common
      0.95 ±  2%      -0.4        0.57 ±  4%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.40 ± 21%      -0.3        0.10 ± 13%  perf-profile.children.cycles-pp.common_startup_64
      0.40 ± 21%      -0.3        0.10 ± 13%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.40 ± 21%      -0.3        0.10 ± 13%  perf-profile.children.cycles-pp.do_idle
      0.39 ± 21%      -0.3        0.09 ± 10%  perf-profile.children.cycles-pp.start_secondary
      0.54 ±  4%      -0.3        0.25 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.32 ± 20%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.30 ± 21%      -0.2        0.08 ± 10%  perf-profile.children.cycles-pp.cpuidle_enter
      0.30 ± 22%      -0.2        0.08 ± 10%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.29 ± 21%      -0.2        0.08 ± 10%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.29 ± 22%      -0.2        0.08 ± 10%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.38 ± 26%      -0.2        0.18 ±  8%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.59 ± 26%      -0.2        0.40 ±  6%  perf-profile.children.cycles-pp.perf_session__deliver_event
      1.32 ±  3%      -0.1        1.21        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.18 ± 25%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.threads__find
      0.18 ± 26%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.machine__findnew_thread
      0.86 ±  2%      -0.1        0.76        perf-profile.children.cycles-pp.irq_work_single
      0.17 ± 11%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp._find_next_bit
      0.19 ±  2%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.16 ±  2%      -0.1        1.07        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.39 ±  2%      -0.1        0.31 ±  8%  perf-profile.children.cycles-pp.kthread
      1.18 ±  2%      -0.1        1.09        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.42 ±  3%      -0.1        0.34 ±  8%  perf-profile.children.cycles-pp.ret_from_fork
      1.19 ±  2%      -0.1        1.12        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.32 ±  6%      -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.rto_push_irq_work_func
      0.12 ± 29%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.thread__find_map
      0.51 ±  3%      -0.1        0.45 ±  7%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.17 ± 20%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.select_idle_cpu
      0.28 ±  6%      -0.0        0.24 ±  8%  perf-profile.children.cycles-pp.worker_thread
      0.12 ±  5%      -0.0        0.08        perf-profile.children.cycles-pp.llist_add_batch
      0.13 ±  5%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.resched_curr
      0.13 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.15 ±  6%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.08 ± 10%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.handle_internal_command
      0.08 ± 10%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.main
      0.08 ± 10%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.run_builtin
      0.12 ± 16%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.available_idle_cpu
      0.10 ±  7%      -0.0        0.08        perf-profile.children.cycles-pp.up_write
      0.15 ±  2%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.wakeup_preempt
      0.10 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.09 ±  8%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.09 ±  7%      +0.0        0.12        perf-profile.children.cycles-pp.filemap_map_pages
      0.10 ±  9%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.do_fault
      0.10 ±  9%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.do_read_fault
      0.05 ±  8%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.handle_softirqs
      0.05 ± 47%      +0.0        0.08 ±  7%  perf-profile.children.cycles-pp.wait4
      0.03 ± 70%      +0.0        0.07        perf-profile.children.cycles-pp.sched_tick
      0.03 ±100%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__do_sys_getpriority
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__libc_fork
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.error_entry
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.switch_ldt
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.16 ± 10%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.03 ±100%      +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.mas_find
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.16 ± 10%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.handle_mm_fault
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.rb_erase
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp._find_next_and_bit
      0.07 ± 15%      +0.1        0.13 ± 17%  perf-profile.children.cycles-pp.copy_present_ptes
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.11 ± 19%      +0.1        0.18 ±  7%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__x64_sys_getpid
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.nice
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.update_entity_lag
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.09 ±  6%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp._sched_setscheduler
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.avg_vruntime
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__vm_area_free
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.__set_next_task_fair
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.cr4_update_irqsoff
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.tlb_finish_mmu
      0.08 ±  4%      +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.10 ±  6%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__x64_sys_sched_setscheduler
      0.10 ±  6%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.do_sched_setscheduler
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.perf_exclude_event
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.set_one_prio
      0.18 ±  9%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.18 ±  9%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.exc_page_fault
      0.09 ±  7%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.pick_task_dl
      0.10 ±  5%      +0.1        0.18 ± 14%  perf-profile.children.cycles-pp.zap_present_ptes
      0.05 ±  7%      +0.1        0.13 ±  8%  perf-profile.children.cycles-pp.delayed_vfree_work
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.min_vruntime_cb_rotate
      0.05 ±  7%      +0.1        0.14        perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.perf_swevent_event
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.09 ± 22%      +0.1        0.18 ±  6%  perf-profile.children.cycles-pp.sleep
      0.09 ± 16%      +0.1        0.18 ±  5%  perf-profile.children.cycles-pp.task_work_run
      0.20 ±  8%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.05 ±  7%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.vfree
      0.05            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.__rb_erase_color
      0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.pick_task_stop
      0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.place_entity
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.__do_sys_setpriority
      0.10 ±  5%      +0.1        0.20        perf-profile.children.cycles-pp.__irq_exit_rcu
      0.11 ± 11%      +0.1        0.21 ± 12%  perf-profile.children.cycles-pp.copy_pte_range
      0.29 ± 15%      +0.1        0.39 ±  3%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.06 ± 11%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.05 ±  8%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.06 ±  7%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.vm_area_dup
      0.13 ±  7%      +0.1        0.24 ± 10%  perf-profile.children.cycles-pp.zap_pte_range
      0.00            +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.__hrtimer_init
      0.07 ±  5%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.pick_task_rt
      0.05            +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.stress_time_now
      0.05 ±  7%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp._copy_from_user
      0.02 ± 99%      +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.08            +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.06 ± 11%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.clock_gettime
      0.01 ±223%      +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.hrtimer_init_sleeper
      0.00            +0.1        0.12        perf-profile.children.cycles-pp.mod_objcg_state
      0.07            +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.clockevents_program_min_delta
      0.15 ±  6%      +0.1        0.27 ±  9%  perf-profile.children.cycles-pp.zap_pmd_range
      0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.12 ±  7%      +0.1        0.25 ± 10%  perf-profile.children.cycles-pp.copy_p4d_range
      0.00            +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.update_cfs_group
      0.07 ±  5%      +0.1        0.20        perf-profile.children.cycles-pp.perf_tp_event
      0.13 ±  9%      +0.1        0.26 ± 10%  perf-profile.children.cycles-pp.copy_page_range
      0.08 ±  4%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.yield_task_rt
      0.06 ±  6%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.get_timespec64
      0.16 ±  6%      +0.1        0.29 ±  8%  perf-profile.children.cycles-pp.unmap_page_range
      0.00            +0.1        0.14 ± 28%  perf-profile.children.cycles-pp._compound_head
      0.00            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.sched_clock_noinstr
      0.00            +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.mm_cid_get
      0.08 ±  7%      +0.1        0.22        perf-profile.children.cycles-pp.read_tsc
      0.16 ± 21%      +0.1        0.31        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.02 ±141%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.dl_server_update
      0.12 ± 10%      +0.1        0.27 ±  3%  perf-profile.children.cycles-pp.__nanosleep
      0.17 ±  6%      +0.1        0.32 ±  7%  perf-profile.children.cycles-pp.unmap_vmas
      0.15 ±  7%      +0.2        0.30        perf-profile.children.cycles-pp.kmem_cache_free
      0.30 ± 15%      +0.2        0.46 ±  3%  perf-profile.children.cycles-pp.select_task_rq
      0.07            +0.2        0.22 ± 15%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.15 ±  7%      +0.2        0.30 ±  4%  perf-profile.children.cycles-pp.cpuacct_charge
      0.07 ±  7%      +0.2        0.22 ±  4%  perf-profile.children.cycles-pp.dl_scaled_delta_exec
      0.04 ± 44%      +0.2        0.20        perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.06 ±  9%      +0.2        0.22 ±  2%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.10 ±  6%      +0.2        0.27 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.23 ±  4%      +0.2        0.40 ±  2%  perf-profile.children.cycles-pp.__sched_setscheduler
      0.22 ± 16%      +0.2        0.41        perf-profile.children.cycles-pp.free_pgtables
      0.12 ±  7%      +0.2        0.31 ±  3%  perf-profile.children.cycles-pp.ktime_get
      0.06 ±  7%      +0.2        0.25        perf-profile.children.cycles-pp.raw_spin_rq_unlock
      0.06            +0.2        0.25        perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.13 ±  4%      +0.2        0.32 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.08 ±  4%      +0.2        0.28 ±  2%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.25 ±  7%      +0.2        0.45 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.11 ±  8%      +0.2        0.31 ±  2%  perf-profile.children.cycles-pp.stress_time_now_timespec
      0.10 ± 11%      +0.2        0.31 ±  8%  perf-profile.children.cycles-pp.shim_sched_yield
      0.18 ±  4%      +0.2        0.39        perf-profile.children.cycles-pp.native_irq_return_iret
      0.08 ±  5%      +0.2        0.30        perf-profile.children.cycles-pp.sched_update_worker
      0.11 ±  5%      +0.2        0.34        perf-profile.children.cycles-pp.set_next_task_fair
      0.15 ±  8%      +0.2        0.38 ±  2%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.12 ±  6%      +0.2        0.36        perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.25 ±  4%      +0.3        0.52        perf-profile.children.cycles-pp.dequeue_entity
      0.15 ±  3%      +0.3        0.45        perf-profile.children.cycles-pp.lapic_next_deadline
      0.11 ±  4%      +0.3        0.41        perf-profile.children.cycles-pp.rcu_note_context_switch
      0.19 ±  4%      +0.3        0.49 ±  2%  perf-profile.children.cycles-pp.clockevents_program_event
      0.12 ±  8%      +0.3        0.43 ±  6%  perf-profile.children.cycles-pp.sched_yield@plt
      0.22 ±  4%      +0.3        0.54 ±  6%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.18 ±  6%      +0.3        0.50        perf-profile.children.cycles-pp.put_prev_task_fair
      0.45 ±  4%      +0.3        0.78        perf-profile.children.cycles-pp.enqueue_entity
      0.12 ±  5%      +0.3        0.46        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.11 ±  4%      +0.3        0.44        perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.40 ± 53%      +0.3        0.74 ±  8%  perf-profile.children.cycles-pp.queue_event
      0.40 ± 53%      +0.3        0.74 ±  8%  perf-profile.children.cycles-pp.ordered_events__queue
      0.39 ±  3%      +0.3        0.74        perf-profile.children.cycles-pp.dequeue_task_fair
      0.11 ±  4%      +0.4        0.46        perf-profile.children.cycles-pp.__put_user_8
      0.42 ± 52%      +0.4        0.78 ±  8%  perf-profile.children.cycles-pp.process_simple
      0.25 ±  5%      +0.4        0.61 ±  4%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.52 ±  3%      +0.4        0.88        perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.70 ±  3%      +0.4        1.08        perf-profile.children.cycles-pp.enqueue_task_fair
      0.39 ±  3%      +0.4        0.77        perf-profile.children.cycles-pp.dequeue_entities
      0.14 ±  5%      +0.4        0.56        perf-profile.children.cycles-pp.blkcg_maybe_throttle_current
      0.33 ±  6%      +0.4        0.76 ±  2%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.14 ±  3%      +0.4        0.57        perf-profile.children.cycles-pp.mem_cgroup_handle_over_high
      0.53 ±  9%      +0.5        0.98 ±  3%  perf-profile.children.cycles-pp.exit_mmap
      0.54 ±  9%      +0.5        0.99 ±  3%  perf-profile.children.cycles-pp.mmput
      0.54 ±  9%      +0.5        0.99 ±  3%  perf-profile.children.cycles-pp.exit_mm
      0.18 ±  4%      +0.5        0.66 ±  2%  perf-profile.children.cycles-pp.update_curr_dl_se
      0.57 ±  9%      +0.5        1.06 ±  3%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.57 ±  9%      +0.5        1.06 ±  3%  perf-profile.children.cycles-pp.do_exit
      0.57 ±  9%      +0.5        1.06 ±  3%  perf-profile.children.cycles-pp.do_group_exit
      0.16 ±  2%      +0.5        0.66        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.23 ±  2%      +0.5        0.74        perf-profile.children.cycles-pp.update_min_vruntime
      0.21 ±  4%      +0.6        0.76        perf-profile.children.cycles-pp.setpriority
      0.17 ±  4%      +0.6        0.72        perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.17 ±  4%      +0.6        0.76        perf-profile.children.cycles-pp.os_xsave
      0.30 ±  2%      +0.6        0.89        perf-profile.children.cycles-pp.update_curr_se
      0.24 ±  3%      +0.6        0.86        perf-profile.children.cycles-pp.__getpid
      0.28 ±  3%      +0.6        0.90        perf-profile.children.cycles-pp.__get_user_8
      0.20 ±  2%      +0.6        0.86        perf-profile.children.cycles-pp.__update_load_avg_se
      0.31 ±  3%      +0.7        1.03        perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.25 ±  5%      +0.7        0.99        perf-profile.children.cycles-pp.___perf_sw_event
      0.64 ±  4%      +0.7        1.38        perf-profile.children.cycles-pp.__switch_to
      0.39 ±  5%      +0.8        1.15        perf-profile.children.cycles-pp.__enqueue_entity
      0.38            +0.8        1.20 ±  2%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.34 ±  2%      +0.9        1.22        perf-profile.children.cycles-pp.__calc_delta
      0.43 ±  5%      +0.9        1.31        perf-profile.children.cycles-pp.__dequeue_entity
      1.08 ±  8%      +0.9        1.98 ±  3%  perf-profile.children.cycles-pp.dequeue_rt_stack
      0.30 ±  3%      +0.9        1.20        perf-profile.children.cycles-pp.__switch_to_asm
      1.18 ±  7%      +0.9        2.09 ±  3%  perf-profile.children.cycles-pp.dequeue_task_rt
      0.91 ±  7%      +0.9        1.83        perf-profile.children.cycles-pp.prepare_task_switch
      0.35 ±  5%      +0.9        1.28        perf-profile.children.cycles-pp.getpriority
      0.78 ±  7%      +1.0        1.76        perf-profile.children.cycles-pp.x64_sys_call
      0.46 ±  3%      +1.0        1.46        perf-profile.children.cycles-pp.vruntime_eligible
      0.49 ±  2%      +1.0        1.52        perf-profile.children.cycles-pp.native_sched_clock
      1.15 ±  8%      +1.0        2.18 ±  2%  perf-profile.children.cycles-pp.enqueue_task_rt
      0.36 ±  2%      +1.1        1.49        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.54 ±  2%      +1.2        1.72        perf-profile.children.cycles-pp.sched_clock
      0.49 ±  3%      +1.2        1.71        perf-profile.children.cycles-pp.rseq_ip_fixup
      1.01 ±  6%      +1.3        2.27        perf-profile.children.cycles-pp.switch_fpu_return
      3.69 ±  4%      +1.3        5.01 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.45 ±  5%      +1.4        1.84        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.62 ±  2%      +1.4        2.01        perf-profile.children.cycles-pp.sched_clock_cpu
      5.10 ±  4%      +1.4        6.55        perf-profile.children.cycles-pp.try_to_wake_up
      5.10 ±  4%      +1.5        6.55        perf-profile.children.cycles-pp.hrtimer_wakeup
      5.43 ±  4%      +1.6        6.99        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.64            +1.6        2.23        perf-profile.children.cycles-pp.update_load_avg
      0.69 ±  4%      +1.7        2.35        perf-profile.children.cycles-pp.set_next_entity
      0.69 ±  2%      +1.8        2.47        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.78 ±  2%      +1.8        2.58        perf-profile.children.cycles-pp.update_rq_clock
      5.72 ±  4%      +1.8        7.56        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.66 ±  4%      +1.9        2.51        perf-profile.children.cycles-pp.put_prev_entity
      1.93 ±  7%      +1.9        3.80        perf-profile.children.cycles-pp.switch_mm_irqs_off
      2.14 ±  8%      +1.9        4.04 ±  2%  perf-profile.children.cycles-pp.cpupri_set
      5.79 ±  4%      +2.0        7.74        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      5.91 ±  4%      +2.1        8.02        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.77 ±  3%      +2.2        2.96        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.96 ±  2%      +2.4        3.31        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.93 ±  3%      +2.4        3.33        perf-profile.children.cycles-pp.pick_eevdf
      6.32 ±  4%      +2.7        9.02        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      4.77 ±  4%      +3.1        7.90 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      7.29 ±  3%      +3.3       10.62        perf-profile.children.cycles-pp.do_sched_yield
      3.58 ±  5%      +3.5        7.10        perf-profile.children.cycles-pp.yield_task_fair
     10.98 ±  5%      +3.6       14.61 ±  2%  perf-profile.children.cycles-pp.do_nanosleep
      4.46 ±  4%      +3.8        8.26        perf-profile.children.cycles-pp.update_curr
     11.08 ±  5%      +3.8       14.90 ±  2%  perf-profile.children.cycles-pp.hrtimer_nanosleep
     11.10 ±  5%      +3.9       14.97 ±  2%  perf-profile.children.cycles-pp.common_nsleep
     11.22 ±  5%      +4.1       15.33 ±  2%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
      2.28 ±  2%      +4.7        7.01        perf-profile.children.cycles-pp.pick_task_fair
      2.00 ±  2%      +4.9        6.93        perf-profile.children.cycles-pp.clear_bhb_loop
      2.35            +5.4        7.71        perf-profile.children.cycles-pp.stress_schedmix
      3.56 ±  4%      +6.6       10.15        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     13.21 ±  4%      +7.0       20.22        perf-profile.children.cycles-pp.clock_nanosleep
      3.78 ±  3%      +8.3       12.11        perf-profile.children.cycles-pp.pick_next_task_fair
     29.56           -28.0        1.53 ±  3%  perf-profile.self.cycles-pp.enqueue_pushable_task
     22.25           -20.7        1.51 ±  3%  perf-profile.self.cycles-pp.set_next_task_rt
      5.89 ±  2%      -2.7        3.17        perf-profile.self.cycles-pp._raw_spin_lock
      0.58 ±  2%      -0.5        0.05 ±  7%  perf-profile.self.cycles-pp.update_curr_common
      0.95 ±  2%      -0.4        0.57 ±  5%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.53 ±  5%      -0.3        0.24        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.56 ±  8%      -0.1        0.43        perf-profile.self.cycles-pp.switch_fpu_return
      0.19 ±  2%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.17 ± 12%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp._find_next_bit
      0.21 ±  6%      -0.1        0.15 ±  2%  perf-profile.self.cycles-pp.do_nanosleep
      0.12 ±  5%      -0.0        0.08        perf-profile.self.cycles-pp.llist_add_batch
      0.13 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.resched_curr
      0.12 ± 13%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.available_idle_cpu
      0.10 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.up_write
      0.07 ±  8%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.enqueue_task_rt
      0.04 ± 47%      +0.0        0.08 ± 12%  perf-profile.self.cycles-pp.__ordered_events__flush
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.dequeue_rt_stack
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.error_entry
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.pick_task_dl
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.zap_present_ptes
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.zap_pte_range
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.hrtimer_start_range_ns
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.nice
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.perf_trace_buf_alloc
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.select_task_rq
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__set_next_task_fair
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.05 ±  8%      +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.sleep
      0.19 ±  8%      +0.1        0.25 ±  2%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.avg_vruntime
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.dup_mmap
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.perf_exclude_event
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp._find_next_and_bit
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.common_nsleep
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.rto_push_irq_work_func
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.sched_clock_noinstr
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.00            +0.1        0.07 ±  8%  perf-profile.self.cycles-pp.enqueue_entity
      0.06 ± 16%      +0.1        0.13 ±  8%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.pick_task_stop
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.__hrtimer_start_range_ns
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.min_vruntime_cb_rotate
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.06            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.perf_swevent_event
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.select_idle_sibling
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.setpriority
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.shim_sched_yield
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.dequeue_entities
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.anon_vma_clone
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.clock_gettime
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.mod_objcg_state
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.timerqueue_add
      0.02 ± 99%      +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.perf_tp_event
      0.06            +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.pick_task_rt
      0.00            +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.00            +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.__hrtimer_init
      0.05 ±  8%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.__x64_sys_clock_nanosleep
      0.00            +0.1        0.11        perf-profile.self.cycles-pp.stress_time_now
      0.08            +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__getpid
      0.07 ±  8%      +0.1        0.19        perf-profile.self.cycles-pp.yield_task_rt
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.rseq_get_rseq_cs
      0.03 ± 70%      +0.1        0.15 ±  5%  perf-profile.self.cycles-pp._copy_from_user
      0.04 ± 44%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.hrtimer_nanosleep
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.dl_server_update
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.mm_cid_get
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__rb_erase_color
      0.00            +0.1        0.12 ± 30%  perf-profile.self.cycles-pp._compound_head
      0.01 ±223%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__nanosleep
      0.05 ±  8%      +0.1        0.18 ±  5%  perf-profile.self.cycles-pp.dl_scaled_delta_exec
      0.08 ±  4%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.read_tsc
      0.13 ±  8%      +0.1        0.26 ±  5%  perf-profile.self.cycles-pp.cpuacct_charge
      0.00            +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.balance_rt
      0.00            +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.sched_clock
      0.05            +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.03 ± 70%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.getpriority
      0.05            +0.1        0.19        perf-profile.self.cycles-pp.raw_spin_rq_unlock
      0.07            +0.1        0.22 ± 13%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.10 ±  8%      +0.1        0.25 ± 13%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.08 ±  8%      +0.2        0.24 ±  2%  perf-profile.self.cycles-pp.stress_time_now_timespec
      0.08 ±  6%      +0.2        0.22 ±  5%  perf-profile.self.cycles-pp.raw_spin_rq_lock_nested
      0.11 ±  3%      +0.2        0.26 ±  2%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.11 ±  6%      +0.2        0.26 ±  2%  perf-profile.self.cycles-pp.clock_nanosleep
      0.06 ±  6%      +0.2        0.22        perf-profile.self.cycles-pp.rseq_ip_fixup
      0.06 ±  6%      +0.2        0.23 ±  2%  perf-profile.self.cycles-pp.sched_update_worker
      0.00            +0.2        0.17 ±  2%  perf-profile.self.cycles-pp.put_prev_entity
      0.06 ±  6%      +0.2        0.23 ±  2%  perf-profile.self.cycles-pp.set_next_entity
      0.06            +0.2        0.24 ±  2%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.00            +0.2        0.18 ±  3%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.08 ±  7%      +0.2        0.27        perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.69 ±  8%      +0.2        0.88        perf-profile.self.cycles-pp.prepare_task_switch
      0.08 ±  6%      +0.2        0.28        perf-profile.self.cycles-pp.sched_clock_cpu
      0.18 ±  5%      +0.2        0.39        perf-profile.self.cycles-pp.native_irq_return_iret
      0.09 ± 12%      +0.2        0.33 ±  7%  perf-profile.self.cycles-pp.sched_yield@plt
      0.09 ±  5%      +0.3        0.34        perf-profile.self.cycles-pp.rcu_note_context_switch
      0.08 ±  6%      +0.3        0.33 ±  2%  perf-profile.self.cycles-pp.__x64_sys_sched_yield
      0.10 ±  5%      +0.3        0.35 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.15 ±  2%      +0.3        0.44        perf-profile.self.cycles-pp.lapic_next_deadline
      0.13 ±  2%      +0.3        0.45        perf-profile.self.cycles-pp.yield_task_fair
      0.09 ±  6%      +0.3        0.41        perf-profile.self.cycles-pp.__put_user_8
      0.12 ±  4%      +0.3        0.44        perf-profile.self.cycles-pp.update_curr_dl_se
      0.39 ± 53%      +0.3        0.71 ±  9%  perf-profile.self.cycles-pp.queue_event
      0.10 ±  4%      +0.3        0.43        perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.23 ±  4%      +0.3        0.56 ±  5%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.17 ±  4%      +0.4        0.56        perf-profile.self.cycles-pp.update_rq_clock
      0.12 ±  6%      +0.4        0.51 ±  2%  perf-profile.self.cycles-pp.blkcg_maybe_throttle_current
      0.24 ±  2%      +0.4        0.64        perf-profile.self.cycles-pp.pick_next_task_fair
      0.12 ±  4%      +0.4        0.52        perf-profile.self.cycles-pp.mem_cgroup_handle_over_high
      0.11 ±  6%      +0.4        0.51        perf-profile.self.cycles-pp.__rseq_handle_notify_resume
      0.23 ±  2%      +0.4        0.65        perf-profile.self.cycles-pp.update_curr_se
      0.18            +0.4        0.60        perf-profile.self.cycles-pp.x64_sys_call
      0.19 ±  3%      +0.4        0.64        perf-profile.self.cycles-pp.schedule
      0.20 ±  2%      +0.5        0.66        perf-profile.self.cycles-pp.update_min_vruntime
      0.15 ±  2%      +0.5        0.62        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.24            +0.5        0.74        perf-profile.self.cycles-pp.update_load_avg
      0.15 ±  5%      +0.5        0.67        perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.24 ±  3%      +0.5        0.76        perf-profile.self.cycles-pp.finish_task_switch
      0.17 ±  3%      +0.6        0.74        perf-profile.self.cycles-pp.os_xsave
      0.66 ±  7%      +0.6        1.24        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.24 ±  4%      +0.6        0.82 ±  2%  perf-profile.self.cycles-pp.__get_user_8
      0.19            +0.6        0.79        perf-profile.self.cycles-pp.__update_load_avg_se
      0.21 ±  5%      +0.6        0.82        perf-profile.self.cycles-pp.___perf_sw_event
      0.29            +0.7        0.95        perf-profile.self.cycles-pp.entry_SYSCALL_64
      3.10 ±  6%      +0.7        3.77        perf-profile.self.cycles-pp.update_curr
      0.30 ±  2%      +0.7        0.99        perf-profile.self.cycles-pp.pick_task_fair
      0.62 ±  5%      +0.7        1.32        perf-profile.self.cycles-pp.__switch_to
      0.31 ±  3%      +0.7        1.02 ±  2%  perf-profile.self.cycles-pp.do_sched_yield
      0.34 ±  6%      +0.7        1.08        perf-profile.self.cycles-pp.__dequeue_entity
      0.38 ±  4%      +0.7        1.12        perf-profile.self.cycles-pp.__enqueue_entity
      0.33 ±  2%      +0.7        1.08 ±  2%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.28            +0.8        1.04        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.31 ±  2%      +0.8        1.10        perf-profile.self.cycles-pp.__calc_delta
      0.37 ±  3%      +0.9        1.23        perf-profile.self.cycles-pp.vruntime_eligible
      0.29 ±  2%      +0.9        1.19        perf-profile.self.cycles-pp.__switch_to_asm
      4.24 ±  2%      +0.9        5.20        perf-profile.self.cycles-pp.__schedule
      0.48            +1.0        1.46        perf-profile.self.cycles-pp.native_sched_clock
      0.36 ±  2%      +1.0        1.36        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.40            +1.1        1.50        perf-profile.self.cycles-pp.do_syscall_64
      0.45 ±  5%      +1.4        1.83        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.64 ±  2%      +1.6        2.22        perf-profile.self.cycles-pp.pick_eevdf
      0.66 ±  2%      +1.7        2.39        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.91 ±  7%      +1.8        3.73        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.73 ±  3%      +1.9        2.62        perf-profile.self.cycles-pp.__sched_yield
      2.14 ±  8%      +1.9        4.04 ±  2%  perf-profile.self.cycles-pp.cpupri_set
      2.04 ±  2%      +4.8        6.86        perf-profile.self.cycles-pp.stress_schedmix
      1.95 ±  2%      +4.9        6.85        perf-profile.self.cycles-pp.clear_bhb_loop





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


