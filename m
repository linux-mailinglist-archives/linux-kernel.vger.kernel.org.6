Return-Path: <linux-kernel+bounces-293215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0A9957C19
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E0528205A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AC341C71;
	Tue, 20 Aug 2024 03:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEcK4nkv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C61798C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125970; cv=fail; b=Nmg13SvZeLFF1Qo/QQrQGDBzpXbds1ywm4DH2bSJsE6jI5HOAdRufSHDdEcwbPc0Ww1aU+thXOwS7tZprWiJUd84JBbKiydWlUT9mCx5diwDFfCPSnWnTTxTHdhGHTkr0IIpL+owB8F013gkwXotGu8jEw/SWJ5H9N2U9DrDeE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125970; c=relaxed/simple;
	bh=IVJFox61YOU04wnlDvY/tBbrKFYY3HBLcxRsx2K89NM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NSouuVKF9NmmEvYLiuRGZAKcgs5aJki+QQgfXNebdYzQfqriYd96dbeD8E7Q7qnV9u6ogRxLaHJZNQkbJOnx996LPM7snWeZNwqVDfri6rVTEOEKuRRf2m4eWy9h6r432Rhejb9dSK0PwYwomdM1ru2qdLGUOv9b49/pgkEVf4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEcK4nkv; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724125968; x=1755661968;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IVJFox61YOU04wnlDvY/tBbrKFYY3HBLcxRsx2K89NM=;
  b=MEcK4nkv7i8vlCU4/xMDa9xrk+4fYpDrAuSSm08nACTkRDDScYcWXgrr
   uurbwFjGn9bthHwYSMAZyLJldjEQ7jVbayNmFVCDeTbGMMKunNAElQqJS
   kRYddo7rAv7vXvZxX6AI3NelDDBx9b1xcO1Mu63tLQjSfp/UZFvQ0Gd02
   yJ7TUlagm30ZsL0waOBwVzuAWRff6j5f9Fn7v3waGl4nE5prTZ8klLjsh
   dm4P+icVrCkJPk+bZDz6yy0ZlP5moItvkEEXaG+KKsG/UaMfQ37k+/7jA
   MFs/1HUDXV1WMlGlwj8zpUovPXh9SMMWiLZTkrsnQDyunBuCXquMCNWUe
   g==;
X-CSE-ConnectionGUID: VnoK8PTaRYmF9+8CqvjN3w==
X-CSE-MsgGUID: cT4UqYr/RkuSg4yGUdOheQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33787181"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="33787181"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 20:52:47 -0700
X-CSE-ConnectionGUID: J/J7KvMzQXiWSvZ7sBtN2w==
X-CSE-MsgGUID: dwOXbM6GTASQtbcdgUirXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="60558962"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 20:52:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 20:52:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 20:52:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 20:52:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 20:52:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mw118WjAFj2Nx5MbL4dh28/xdoUzHIYvqV4k0VujVtzXZbX+due6H9FMV7SeoZlvpIPxpQCLvoVnFZijBwcb96ibCCxDOD8wpMVr6x9wtnETWaNHpbELoExc3UWZH2Lqkr3dLKNuMQjylQHjuHUMz4xiuU+r6cDzexkgojj97hvtsVrCdyYXmXwArk79HPBgpYDhIdiZLPj2NeB1Jgz6Laza6EBXx+XKtpDK1Bc4UDE8imYRooan5JIr15Cm/SkplViTu08ETE7LqtPuzeMKJhEvZ76MEo9Jl4rySpe3vy07/UtZSq/f+cPRMF+W48KZAxhhkLrO7UnhBdtUt6aZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bDP9bDahUJUo3/0qgulT6J+nxt1dSSDbwabnfrWSuM=;
 b=I27KXmoA5MjHGhPYvoPS2i8RkuKIpkiRozxQJgWlxgOBhS94hwv7+Mp1lJ05tbT95uX+0t6H69kjyPIJ7/XUirp62AOgIkBsv+mVPKGTFIQh2Y7rKCJpFE3/cTQsWMBFjC87UQIN6wT6faMgOlRhmdMjxXL3+Wf8TfYqM+woWQd/AKLMgM590j8zrQoQsJb6nGO5ivBu5oSy/m496GrYnAH838GHzmcjZDai2QaXk/k1EtQ7z1dFrlAcUhQX8OaPsd2AnnG3pjPqusZMq0TCpygHxz+W57ccoKmhqaH6910Xhl9E5RcoR+wYneo6rK3r3+wl7YzyIpNB+1dSz2kFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ2PR11MB8513.namprd11.prod.outlook.com (2603:10b6:a03:56e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 03:52:38 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 03:52:38 +0000
Date: Tue, 20 Aug 2024 11:52:29 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Peter Zijlstra <peterz@infradead.org>, Andreas Gruenbacher
	<agruenba@redhat.com>, Tejun Heo <tj@kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, Mickael Salaun <mic@digikod.net>,
	<linux-kernel@vger.kernel.org>, Chen Yu <yu.chen.surf@gmail.com>, "kernel
 test robot" <oliver.sang@intel.com>
Subject: Re: [PATCH] kthread: fix task state in kthread worker if being frozen
Message-ID: <ZsQS/cRhRH4MOof8@chenyu5-mobl2>
References: <20240819141551.111610-1-yu.c.chen@intel.com>
 <20240819185807.ff5004ade2661c46740fc459@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819185807.ff5004ade2661c46740fc459@linux-foundation.org>
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ2PR11MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b666fd-54fd-47ea-5e3d-08dcc0cb8892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GTt+cZPQkm5XvSsmAU3XiYRcm7qmy6ENTGd39afwVxilolQpzII1p49WgwsM?=
 =?us-ascii?Q?kpSpBOdXFklNgWsPx2MK2zw7Njcj04TLxhav/BMcQWmZmFv/lpqDXQNDKs7G?=
 =?us-ascii?Q?CxyJWKcx855nYM32tqk5/TX+aMbLWVzsXrFhYh/2UFQ2dnHQG/CeBx2Kv+6R?=
 =?us-ascii?Q?oh4GENzAfLTKQip6qvWluWi7Cdr5XbZuYBr6CtPG9C6/E2jKDAbmofjyfKgh?=
 =?us-ascii?Q?K+NNFjltOWF+UBgx3skVJzUGlR55Qn5s/3aNvlG3cg/hE7mlJbWvsmShQ11V?=
 =?us-ascii?Q?6RXFiOb+Wl+MWDrxHkVBDEDrSnEIaPFAnDe/RkbUqPuMe4SPf2+UOTnsKOYF?=
 =?us-ascii?Q?yjuR++BKaCnReKzYrb52DvnOTiSo4BZIB5kmByc7Iu/Smoza8ALtB+BR2pj1?=
 =?us-ascii?Q?XoQ5ODT+9JXDQoRcTyBmwzUNb6rvO8lz7EjHo3mmBI09nXuIG9pYrUE7GH9F?=
 =?us-ascii?Q?E+JJJMFtpRpL7RZEePqTUKDr1KZJrysngo/uvLcKgSwn3F2knbLYqyebkTng?=
 =?us-ascii?Q?mMy+F4jYYTILVChf0W5B5LAe5rLwODckeetaAGHDu8zgajT/q69PsxxYCLxG?=
 =?us-ascii?Q?bnFmWB51/Cua5gAZyR9oWVBtrA7ADbBgK837eHfB8vpCl3Cx9tePeo+fUHt8?=
 =?us-ascii?Q?36p7uTkPO2CBDD5bwxBQ+PtfmkqTinuejdnrfgovLwt1VHuAuucqDYYmCv//?=
 =?us-ascii?Q?jpjSvmhsufzhiPbUWwsLd0f58WJFsO+clhdRCQgQTHBGwI16Ct3NAeSjI3/s?=
 =?us-ascii?Q?a6CME4Bm0glg/Jf0IAb/iEKWuUVgaUgmFj4MRDZ09x715UQBmc6Hwxcuq4wL?=
 =?us-ascii?Q?Z3tdnSzZyFnX0Fw3hAZr3x2uNfVwyN+ckdcN4qQsor/pZr0Q8TROWryWLzz0?=
 =?us-ascii?Q?ecOmFB/VrKEGnz+y6g5FuetdRUjMyft9lJOdev83WwnaaEk8prK35t86pw0D?=
 =?us-ascii?Q?/rqKO0CFjGf2RnSNd8EtiBtdJKcqOsc9kYV+ntmAdSPdjumUXTAAVeQBkmLK?=
 =?us-ascii?Q?ZKvODveXOPIQRv/rtLkCCfArbSHiWiRqbYYc59Bl+xbdZ73GeJi9t64URF2N?=
 =?us-ascii?Q?5UlDn+R8AiEr+a6T0Y5xgZPimEVIhc/dfA1j/2snMBlA86tT9kEF2aCALTbW?=
 =?us-ascii?Q?kmQuE0JqIf08HJt39IV/IiBsy0B/9tmXV5GeWW+WLXxd9zisnD4lHbCcak97?=
 =?us-ascii?Q?KqzOFTdA8yiUQi7qfP8gUHoWFMMaMYF98ongnmASTpEER6/z0HBvjU/vrpEm?=
 =?us-ascii?Q?4YXW0esT501F1zY3DuI9KFsPMJy8S1im1jZaZR7gY0L/yTw1SbVaDinYL4Zp?=
 =?us-ascii?Q?xn4YScMlqXbdTvFmMnO5m1y1wrAqeng1i8AHXnPWrveuZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1/BnYI4TIVl799t/rDiKdneJJKNhfWl7ECfHejJW/MrGy2NACNI3QZCeM5su?=
 =?us-ascii?Q?xN7Yxxli9opMr0va4P01sTnlGVhOqP6MFOT3tH0TULe1BiBjeJF28pwegSbd?=
 =?us-ascii?Q?QFaM1jfRADknMVf5dFSoTmwnbu6cLANMFRUfTW7/SUm9QsVlGhEYrMdox73p?=
 =?us-ascii?Q?my5OGmxRyXKAhCyI6TnrF6RRlOqN4/ZmfKJtBnnyKBKmWcmrkuvjPwwPTxoB?=
 =?us-ascii?Q?X4bxNAbfE6881t8IISoiyFWrYV8zoxqPghkCOb/y5iAtF3ptAgQO1hwx+OVZ?=
 =?us-ascii?Q?T7qmUZylJe9100Na4HN8TbxSWSpYkVw9g489c4W1NAVpwc5Cz5mjx6lyAgMV?=
 =?us-ascii?Q?8t4hgK40TqESNYhZF5JD5U6+WJGeH1eKfmnAd9kd5YzUIw7p1C7ycJUjgkIH?=
 =?us-ascii?Q?Pf0anl43VbOauLZQ53yY0Gp+H1t0kwFAv9JUkjl5PlicM7n45OWjJ0WSx46i?=
 =?us-ascii?Q?bN+xX7un0ok6pFPEBkwQPfHlMrA7CRdZBdJJIJ6M5BFThbE1UPlxRrka8Cy4?=
 =?us-ascii?Q?jBw63muljLiwOWWCFYHEQ1MHsbt7/YkYbqvTmEMmtwrbUw4sOwJl6zp7Dasl?=
 =?us-ascii?Q?81SVWq6a9vBI2vHUaGrIeadncu/l/vc7NKdCYfxYBhtXtRT5Yq8/iCMgPzNi?=
 =?us-ascii?Q?Z9jDI7tAint4hP8VJBO7zZ8XnQt1WmT4Dow4nIZefjWacofSEXUZUfTy7qeg?=
 =?us-ascii?Q?wqU/gAyn1i3h2EUpmxYqbWPIojyNafnws38SbTEeCHSQw+SO/vPmoXQrwrY9?=
 =?us-ascii?Q?QWON/KBLD3nj+AT+0lMY6tRI5kjAKTeQNsQfnVk2nE0KZ0WNEFSiqja+9diX?=
 =?us-ascii?Q?/+y/nxXJdso44k5oRH/DrvAnCyhPYdObon75cnDGUwx3/Yu8l0+zltwg46ZH?=
 =?us-ascii?Q?8Y/s7oq8ITd0XXzK9f0t3KKSKBWSL4qXGKDWQMPbI3+FBruVuRZZ8aW9kogo?=
 =?us-ascii?Q?nM0+AgTD4Ux9F14LZM7V7GY87p3UU7NiqQ9/2VYJ6Pouv4zt2InHcmrX/ii6?=
 =?us-ascii?Q?hManaoeWMmmVMHL8l07VNamo+VYsvEDKdM79vT17txeu5fQKepWyg2u6KEck?=
 =?us-ascii?Q?/RiM3/3+DYLk1U+RACr3DrkQlaUdIzf5uj82SSgRAII30eBMQEOMn99GOXPg?=
 =?us-ascii?Q?HPzwNDPHb2EVIOaCLtbvX1D8xJkf2/4UpKcFdHgYNeVRUTbbCY5nSxjcQVyd?=
 =?us-ascii?Q?KqI8LncLGj/yYaVequiu4NxLGfBGaX67SGW5/DxF0ATVuOluVKJGNP3qwBx6?=
 =?us-ascii?Q?n1s6qF6jv8EwIIHF6NKAirRjM2Zfshacn3zmpggpM3mupsoybcCSEIxVxCqY?=
 =?us-ascii?Q?pO8bi6A1sm6oIlRbd1zaItHUinLFteH/iwalZ4fyshe8A8myFhsuU0SIuYom?=
 =?us-ascii?Q?s8Es2aVQ8dLC3srWZqi2EP/ZJfPnJ3iTrMJJXGRXb+5sHZjOEvsxAu6ejFBd?=
 =?us-ascii?Q?36j5XmVvtIUnpKddBpZKFBSm8K1A7g9cWA3umL/huc0+6L2xZWI7QY6OpHS2?=
 =?us-ascii?Q?w12HVdNYIJl07sJw7FVgtR4Eiscl5268GqrFLmS6zbrjmm9sx/PJC33zbDtD?=
 =?us-ascii?Q?58SNFhc+sVCbxMjk7nyENkPJHhDgexcIV+hoHpMQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b666fd-54fd-47ea-5e3d-08dcc0cb8892
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 03:52:38.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3Vj9htqmM0K4S38dJmq1y/mludyTVfVov3C7ZUvECn3MRLt+8e6zrkm67MZqYWPazJJARB318n4JZQKsXRRVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8513
X-OriginatorOrg: intel.com

Hi Andrew,

On 2024-08-19 at 18:58:07 -0700, Andrew Morton wrote:
> On Mon, 19 Aug 2024 22:15:51 +0800 Chen Yu <yu.c.chen@intel.com> wrote:
> 
> > It was reported that during cpu hotplug test, the following
> > error was triggered:
> > 
> >  do not call blocking ops when !TASK_RUNNING; state=1 set at kthread_worker_fn (kernel/kthread.c:?)
> >  WARNING: CPU: 1 PID: 674 at kernel/sched/core.c:8469 __might_sleep
> > 
> >  handle_bug
> >  exc_invalid_op
> >  asm_exc_invalid_op
> >  __might_sleep
> >  __might_sleep
> >  kthread_worker_fn
> >  kthread_worker_fn
> >  kthread
> >  __cfi_kthread_worker_fn
> >  ret_from_fork
> >  __cfi_kthread
> >  ret_from_fork_asm
> > 
> > Peter pointed out that there is a race condition when the kworker is being
> > frozen and falls into try_to_freeze() with TASK_INTERRUPTIBLE, which
> > triggeres the warning.
> 
> OK.  A full description of this race would be better than simply
> asserting that it exists, please.
>

OK, will write a description for this.
 
> > Fix this by explicitly set the TASK_RUNNING before entering try_to_freeze().
> 
> OK.
> 
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -848,6 +848,12 @@ int kthread_worker_fn(void *worker_ptr)
> >  	} else if (!freezing(current))
> >  		schedule();
> >  
> > +	/*
> > +	 * Explicitly set the running state in case we are being
> > +	 * frozen and skip the schedule() above. try_to_freeze()
> > +	 * expects the current task to be in the running state.
> > +	 */
> > +	__set_current_state(TASK_RUNNING);
> >  	try_to_freeze();
> >  	cond_resched();
> >  	goto repeat;
> 
> Comment is helpful, but why express in a comment that which can be
> expressed in code?
>

OK, will do in next version.

thanks,
Chenyu
 
> --- a/kernel/kthread.c~kthread-fix-task-state-in-kthread-worker-if-being-frozen
> +++ a/kernel/kthread.c
> @@ -847,6 +847,12 @@ repeat:
>  		trace_sched_kthread_work_execute_end(work, func);
>  	} else if (!freezing(current))
>  		schedule();
> +	} else {
> +		/*
> +		 * Handle the case where X happens
> +		 */
> +		__set_current_state(TASK_RUNNING);
> +	}
>  
>  	try_to_freeze();
>  	cond_resched();
> _
> 

