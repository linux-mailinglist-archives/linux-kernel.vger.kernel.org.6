Return-Path: <linux-kernel+bounces-228189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4551915C19
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9F22851DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F103399F;
	Tue, 25 Jun 2024 02:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H65+aE5/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79D5381C7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719281718; cv=fail; b=shkMCxTVDc4Cgu7Ap42gLA3opwgJj+UMFoBdWbMPyb3f0hCfOIuzrMwm1cxbGNe9N/sunvoNLnBj9i3o8/LYk9eyWRDv14Lwcx+vQoFLEoi7AlSaVfajGD1WWChI3H/kjLCL8Nq4Co3TK73L0kDmigD1wJV/3Xx7393I7yXcZGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719281718; c=relaxed/simple;
	bh=QgZFkYJtu9+tF+jcnUfhySToMShrYiX4KJ0eJ77lHCY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HIf2YnY7LlgzjbvIyaXv8U/B0AHxkqjI3FONSI5ehH2kqE8GdgzbsRDhtFbVqFKPU+Q//CCSpyILCbRdVOQ0YK8fFxzTFaZxyOL82YgcLGGPqy0RpfOJB8f1GZqSGCcjwJpKTQvFxtoz3bq8tf3FUUowUmcEm4z4FRx7ytuVJRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H65+aE5/; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719281715; x=1750817715;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QgZFkYJtu9+tF+jcnUfhySToMShrYiX4KJ0eJ77lHCY=;
  b=H65+aE5/4Zcn8Qw97RiFKqOODXWBXfGew2XGbUW0SdMdNj86KyU+2C17
   AGVFNZpcJqZUS63CUK6vKavwY8nzGrFZeE4lrkkohuOpzI1iz8n7KTe1w
   g2oDnhI0ezEceccszyTnewWNC0WR67ysqxZsxUa9+ZXfPsll+J62gSaF/
   V6xAxuS/U3MGZJLxmVB8JjKeYfhhdx2aJK29Q2hnI+5a8sonnbp58wrUt
   LudNGFDWLDGfs7pKfDTjtJmHXl2d8JUXDTSa3yyJgB8daTJZ8Shu86M5n
   7vrwz0nhkxXuxlVNtsSROxCDTLfMzcw5yj9gq9apOmkeD8QTmleHgG064
   Q==;
X-CSE-ConnectionGUID: 11ErfA6sQUqNDXzv+CLETQ==
X-CSE-MsgGUID: iFrNP5/5RueJT8VNPw+VDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16154938"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16154938"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 19:15:12 -0700
X-CSE-ConnectionGUID: 4sPXTF4nTwGyiGZ7EzyzZw==
X-CSE-MsgGUID: L+Q4gWREQxOH1r5khDRGsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="74695808"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 19:15:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 19:15:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 19:15:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 19:15:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 19:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9LnC0Mk8cniNasl2WK4/A0YO4avS1mh0hVAiWF0xJHqD+mhGNaVBB22jcYCtcUKA0e/zmUkIse4FXHtE82U27Eg2rl9l0CAMU/FeIaz3KYFnTte16FE4I5M8KwF2zzuTnaTVoR7bO+a5UIu3QlDWOA7h5QejhFtDQAmboG0Alw/okIzKAZojkVleJNGU+h9VvcIA5UmduKEWPGC6XuC/Ymr8CTlDRbjeP5hUo0Q722EzVpe7Dw35lGNKZ9YcO2l94nJt3Hfcm9TrNx7nmsGehiCz8JnUlp/dslQK7PdDWZdVoUJL+5VJ0m+RdoN/88UIWAnJzyK1o2dosEDWpD8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0PN499AbsZhb7puNtBWqRYvkBIl25Ei7SDqEVejycs=;
 b=AOdx+TN+YJTywc1dgBpFekOJfIT3O/d0HFbfWk1vF4VO5zxAz/SEbvk8das6wfKaxhhVvcmfspOE7Yrxq9UxCaOxDfX3FBleOdB0trYa2UV6vzjdQ1/I5LUMtj11HlSGCLBPEApmgv2LkdDs8bg8qd1cRHvfYUfxqXwWmVH+44LzBU2GHeeOyNJCSvSU0VmjjjtATCjoIz2a4TDKefGLf+IU37R/OsBLLPs3Qv79cCSbEAt4Si4ek9e8EGawuEp4OVpTcwzTky2PMZKWnGBvbP/dmyktlfghr6PrPWikXytKBHE0NhhNJmeRqo64tPJKwGUPrbGHd8164iEfvjNhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by CH3PR11MB7868.namprd11.prod.outlook.com (2603:10b6:610:12e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 02:15:03 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::b3b:d200:42be:fe4c]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::b3b:d200:42be:fe4c%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 02:15:03 +0000
Date: Tue, 25 Jun 2024 10:15:34 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <andreyknvl@gmail.com>
CC: <elver@google.com>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
Subject: [Syzkaller & bisect] There is BUG: MAX_LOCKDEP_KEYS too low! in
 v6.10-rc5 kernel
Message-ID: <ZnooRgso2Y6RKwp9@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4844:EE_|CH3PR11MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 4287253b-5bf4-4603-ac11-08dc94bc9fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y54RSfL6FR16gYRYZ7SYQn0JuHxgtqupMS8ICzDBzMyRJxUACaRp33qe6iWh?=
 =?us-ascii?Q?rbL5T/EeTj1NUNaUVHbAoqDqmhWW2+AODRoJd999cILiACmFajpcduS7BsuF?=
 =?us-ascii?Q?ve9GpwhkiNmHy4rqbd+7bFZ8P2NHzyiWBA8B2G6USCKuzFaFAsbOluIH58dD?=
 =?us-ascii?Q?HGTULlo750tNtuxvc9AvFxkHgrRury2wLtNMJpnmG3o8n6k4HBrIO+pUFp4i?=
 =?us-ascii?Q?DnGhIoIdKYXp5AwJXrrghmP6upNYPMViDdjfnHMBGlQKjJOz4+EkYUrLSHZ3?=
 =?us-ascii?Q?ytpzfj9/TMmnz5TgTh3csQjK4Mmb1d8rlPIHZBwQUiuu7HzFqE5QTybDq1HI?=
 =?us-ascii?Q?Dyjw3c+44kY1t/ObZTYm/Bgg9ozPPOkD5XL64R3l1xxg9QsCoBZioeInzZFd?=
 =?us-ascii?Q?ISgHJ44a+AVf5IZ35eRZicghjtIzPrzMQoMJLtLYC+j0dZsD7UQkNXDeHbT0?=
 =?us-ascii?Q?k/BYYF+Ky14IHGX36w+eWqrl9JDWVpJTt1t/CNGLKwHIdV41PsEJD0n5kfNU?=
 =?us-ascii?Q?EWEQT0p3MKLFYP8nbxv/T/KLcl4MT59fVljeMR7WbEyCuTlY3ux5AlfshR/u?=
 =?us-ascii?Q?orfYutqXNrWic+q8dkxNl4rdie5syfnQsLNyZRk+wIuy0dLhWR6p6HKWyq7R?=
 =?us-ascii?Q?h8F3ROD76YHSIHnoS3syuC1Fu32vqUM/llYfK4JRDEU9LKIQ/Lvz2vRKU9PG?=
 =?us-ascii?Q?nfL/I6HnAx91wvCOeIacz/t3w0pE7on5O7GYl3IPEMK+mJFeq2j6q+mAVbs/?=
 =?us-ascii?Q?OzDt1ENJC/gXP4QhL/GVZE50leY2Hvq72bsdIlbCLe6+MdnububPunV0P9h+?=
 =?us-ascii?Q?Xxt7gEFlqNImb6oBIq226/rNPs4DnYlcy+nFfexNiOPzYVwFW6MWaBwdpAiM?=
 =?us-ascii?Q?/inSmxRRtfiaVfjoJnGCqc1rS6oJoHeXPOh0Cgd5e6dlTo66gWR2gbYD8/hN?=
 =?us-ascii?Q?CbvjLlE/HhFOzz8dPEI4AkLXhdUdOOgTQ7JHi93cuaxpNrcN1GAYQYo5zxnW?=
 =?us-ascii?Q?xSax77vMg1fciXDvLgoCjxos+eNsz3bl0ByrrTzo0tnqIcsbnSP98jcYJteo?=
 =?us-ascii?Q?3uFWp2at5bTb3tL4aXSDjNs11bPSgverjrqG/WefLEuBuj5AOrZfNHBwb9fe?=
 =?us-ascii?Q?1mTzoC0eRD/OczaVQTRWr6VqNsEqZUoVd+jUFQhaClo6Ur4K8s6BGGAaGXRb?=
 =?us-ascii?Q?8ZdQiiClMcFxs7MnlGSVsb62i56UsGLwWyBQc43cSR2Eg59Sn3HtEx213vM3?=
 =?us-ascii?Q?Z3Excum8WZuIesaj9wM2KMej8ljS57vXRBvqFDPOjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xP5c6VcXt4Fb70Lsml9edF5IQ7LWa7qaaIhl/Y5rPqELaqpRXAwFE86rRasm?=
 =?us-ascii?Q?rxo3b6LEPNlBo/aTeDyM10xFIGHkXBWgFYmnRo7MQSronL/l3JJzWnORTz2G?=
 =?us-ascii?Q?6JcPGbGbuIGlU4ulJms3U90hnQrZw6T16f3/MAtZPn2aYToBK3aIIU0f/3Jr?=
 =?us-ascii?Q?zhBMYZo6YwIa5x22WcGQ3WoVH3+g/UdkIxcCkl3UEN0kK9JVvW/efilt4saO?=
 =?us-ascii?Q?SlfPC8MuOE2E+IO9n/JJMOdAaUqPa1ag5WIBasGUXAxl3FdgrO0kmikbyTkL?=
 =?us-ascii?Q?6F6WXA3Clmzl9P84uiwkkzR5KDMla2FYJi7qtCugUt8RRO80gHR9bigwZvEB?=
 =?us-ascii?Q?wGSMeXUVv2UvDjwhuK9/GK19qa6Ty6IyZ68ww/6Q6ez+nKFHyEyuF5lJ6B3Q?=
 =?us-ascii?Q?4umTXz+d1n3CcMBQELC67prK5XQRiImncKPLJtAlKXJZ7jfYd4xJfmh9LckF?=
 =?us-ascii?Q?vLb8B2KlueL+5pEA+WFfeAGkCAgoNciowQ287lbd779jbHSqhkuARYJ9rO/0?=
 =?us-ascii?Q?ziLwILPe4ye4oyGeGGgY69/W+tUPGL+3YbfUppjQfw6nXSrv1PhguK1vVrRY?=
 =?us-ascii?Q?j2YFBSAaLSg0iKRc57/CtbsqRibpfUhJYgKAx8G9n4K0fc4CDKoU2CMnI4w4?=
 =?us-ascii?Q?mgUac3PeZIP74QUhzuo5M7/F8CP3DMkNRbOIY5gioY6gd6RWNAi65n628lo6?=
 =?us-ascii?Q?xXAG+3agLvF4/J9nZOMoBMrX1y6urjHRkanJ0eElITuWG7PSPt9ByM0G9N22?=
 =?us-ascii?Q?uUZ87ZhUWf/bUNlAKzk51sjHGZbEWy3pYF64zurhvsIVsfesXxlG57VV8EVR?=
 =?us-ascii?Q?5zhr9DmRLZvd6Tz8KfbcVzwzIWYy7gJEHp9b5MLzMuhXV3CNCW7a+BmwHfH7?=
 =?us-ascii?Q?uFfYC9ioCFbRNW5JEwB8wmiJuucyMmJgpnFxLY4ki+dPmqxq72ZUN4lGELtU?=
 =?us-ascii?Q?+CxrXbi6+lkmXtONUJcw/AuiO1e5Rh8SqGvMNxbJK95wb0HOgUppgpzExXPa?=
 =?us-ascii?Q?n2C5ZBI7FDcuVSPu8BQKhj0ncAbk8fdFk30cwtAvDjs+RGJDN3cx37fexRTV?=
 =?us-ascii?Q?Eq3Mk79qEXxTcAs0EBLpXLJs8+V6L5Pbaa6/a9UG1u2VY7LA1aSUIaV5u/w8?=
 =?us-ascii?Q?oZDTwEe3oelqheIW1eLUCnPWRnb35e9X1YcfxdDzNEEyb6WLrEDOvWxVKyWH?=
 =?us-ascii?Q?vX1DXJYhQnuNfTNnelwK9wab3JYQaDfDOhhhdMh1cIfWDWfbshtepZJCHcgf?=
 =?us-ascii?Q?y6LsHyCgeCMTqWiNX7/MBmCUnD6183hb8iuLOwyxmuKPXcIVRfpxEy4uyXDu?=
 =?us-ascii?Q?XFI8cxATmaVROnOFVA+q/PeG6dmQTB5WP7cusJER9V88Cia/7qehaq2D/XJd?=
 =?us-ascii?Q?oONqJoZL68OwfaM0BpQd4x+D3xQ6OPF9noDX6NB+aVVpgll5MFWA8VbHlChH?=
 =?us-ascii?Q?At07UouREQh5jTGhfHiROyF4kPhkpAT92iXGWG63Ve20eKNilCTZNvXDO8+b?=
 =?us-ascii?Q?5Wi66HsBhRWXw6mg9yoK7SPuBWR15tjtX52Ft2sZyXw0Zdkgb74965kcwQIz?=
 =?us-ascii?Q?SFDUCfQEBRhUZGTKb+5PvXfMn9oA9TG//8aWA5sp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4287253b-5bf4-4603-ac11-08dc94bc9fe3
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 02:15:03.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mLP29pRZSYJFkokU5sGwYM1p0fNfHSb1a5H0mf90hCim84TU98VNbQVL1rw9HQrNzCtodhdpjf6SM1P0kwR7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7868
X-OriginatorOrg: intel.com

Hi Andrey,

Greeting!

There is BUG: MAX_LOCKDEP_KEYS too low! in v6.10-rc5 kernel.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240624_120854__MAX_LOCKDEP_KEYS_too_low
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/repro.c
Syzkaller syscall repro steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/repro.prog
Mount img: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/mount_0.gz
Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/repro.report
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/bisect_info.log
v6.10-rc5 dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/f2661062f16b2de5d7b6a5c42a9a5c96326b8454_dmesg.log

Bisected and found related commit:
cc478e0b6bdf kasan: avoid resetting aux_lock

"
[  157.974013] BUG: MAX_LOCKDEP_KEYS too low!
[  157.974233] turning off the locking correctness validator.
[  157.974459] CPU: 1 PID: 736 Comm: repro Tainted: G        W          6.10.0-rc5-f2661062f16b+ #1
[  157.974864] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  157.975392] Call Trace:
[  157.975502]  <TASK>
[  157.975600]  dump_stack_lvl+0xea/0x150
[  157.975786]  dump_stack+0x19/0x20
[  157.975937]  register_lock_class+0xaee/0x10d0
[  157.976136]  ? __pfx_register_lock_class+0x10/0x10
[  157.976351]  ? __pfx_mark_lock.part.0+0x10/0x10
[  157.976553]  __lock_acquire+0xfe/0x5ca0
[  157.976727]  ? __pfx_mark_lock.part.0+0x10/0x10
[  157.976929]  ? __pfx_register_lock_class+0x10/0x10
[  157.977140]  ? __kasan_check_read+0x15/0x20
[  157.977325]  ? __pfx___lock_acquire+0x10/0x10
[  157.977517]  ? __kasan_check_read+0x15/0x20
[  157.977696]  ? mark_lock.part.0+0xf3/0x17a0
[  157.977878]  ? __kasan_check_read+0x15/0x20
[  157.978059]  lock_acquire+0x1ce/0x580
[  157.978221]  ? touch_wq_lockdep_map+0x75/0x130
[  157.978416]  ? register_lock_class+0xbf/0x10d0
[  157.978610]  ? __pfx_lock_acquire+0x10/0x10
[  157.978794]  ? __pfx_register_lock_class+0x10/0x10
[  157.979000]  ? lockdep_init_map_type+0x2df/0x810
[  157.979201]  ? lockdep_init_map_type+0x2df/0x810
[  157.979403]  ? touch_wq_lockdep_map+0x75/0x130
[  157.979598]  touch_wq_lockdep_map+0x8a/0x130
[  157.979786]  ? touch_wq_lockdep_map+0x75/0x130
[  157.979988]  __flush_workqueue+0xfd/0x1040
[  157.980164]  ? __this_cpu_preempt_check+0x21/0x30
[  157.980370]  ? lock_release+0x418/0x840
[  157.980542]  ? __pfx___flush_workqueue+0x10/0x10
[  157.980745]  ? __mutex_unlock_slowpath+0x16f/0x630
[  157.980979]  ? xfs_log_force+0x1db/0xa30
[  157.981191]  ? sync_filesystem+0x1e5/0x2a0
[  157.981386]  xlog_cil_push_now.isra.0+0x6c/0x210
[  157.981588]  xlog_cil_force_seq+0x1d4/0x790
[  157.981775]  ? __pfx_xlog_cil_force_seq+0x10/0x10
[  157.981982]  ? xfs_fs_sync_fs+0x1ed/0x3a0
[  157.982157]  ? debug_smp_processor_id+0x20/0x30
[  157.982358]  ? rcu_is_watching+0x19/0xc0
[  157.982532]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
[  157.982767]  ? sync_filesystem+0x1e5/0x2a0
[  157.982944]  xfs_log_force+0x1db/0xa30
[  157.983109]  ? sync_filesystem+0x1e5/0x2a0
[  157.983287]  ? sync_filesystem+0x1e5/0x2a0
[  157.983464]  xfs_fs_sync_fs+0x1ed/0x3a0
[  157.983632]  ? __pfx_xfs_fs_sync_fs+0x10/0x10
[  157.983821]  sync_filesystem+0x1e5/0x2a0
[  157.983990]  generic_shutdown_super+0x8c/0x520
[  157.984183]  kill_block_super+0x45/0xa0
[  157.984349]  xfs_kill_sb+0x1e/0x60
[  157.984498]  deactivate_locked_super+0xcb/0x1c0
[  157.984694]  deactivate_super+0xc0/0xe0
[  157.984865]  cleanup_mnt+0x2fc/0x460
[  157.985023]  __cleanup_mnt+0x1f/0x30
[  157.985179]  task_work_run+0x19c/0x2b0
[  157.985343]  ? __pfx_task_work_run+0x10/0x10
[  157.985528]  ? __this_cpu_preempt_check+0x21/0x30
[  157.985734]  ? syscall_exit_to_user_mode+0x109/0x200
[  157.985951]  syscall_exit_to_user_mode+0x1ec/0x200
[  157.986160]  do_syscall_64+0x79/0x140
[  157.986322]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  157.986536] RIP: 0033:0x7fab3634e87b
[  157.986692] Code: 0f 1e fa 48 89 fe 31 ff e9 72 08 00 00 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 71 b5 0a 00 f7 d8
[  157.987430] RSP: 002b:00007ffc181e2598 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
[  157.987742] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fab3634e87b
[  157.988031] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffc181e2640
[  157.988321] RBP: 00007ffc181e3680 R08: 0000000000000000 R09: 00007ffc181e2430
[  157.988611] R10: 00007fab363b13e0 R11: 0000000000000202 R12: 00007ffc181e37f8
[  157.988761] XFS (loop7): Ending clean mount
[  157.988901] R13: 0000000000403138 R14: 000000000040fe08 R15: 00007fab36460000
[  157.989407]  </TASK>
"

I hope it's helpful.

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!

