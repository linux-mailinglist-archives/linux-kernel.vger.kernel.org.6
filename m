Return-Path: <linux-kernel+bounces-235219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2F791D1BB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18487B218B1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 13:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A4713D525;
	Sun, 30 Jun 2024 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHds9SRh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369971DDEB
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719752984; cv=fail; b=AL8hW6IHapLbhb+RbJCQJwq6g7IH3hIwxOPRQeneXplkyBunfhdouV9+03LS5Ktqd7vIMyVVbbFZNTCinPvOKve8ngm8fj1altkEhI5lpXu4nuD/EJB7RrqXXVdPF4VcbWLVjaTMCodv4tMt2ZU4JFIi88jyC16Valo/8oWJCCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719752984; c=relaxed/simple;
	bh=twNPMLQp01Bo2vXXogp5BYmu7HQ0Fhpvi4oqZpYihgI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NFYJx0laew2iXD6ntuZdUvY7bteh4jdbPXqSF1F7MVJt75HuF9wwwteERkkEkkM6ZxWKL1xRjsY69JcvUxkRHZsEWr+vUrZC1oIknh5LMMOKGFZAHAyFgxMoVtM3dii6zJp+u0CLJ5ymYlTWeaec2B0zeSgzfnWjuKaKUtCLghg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHds9SRh; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719752983; x=1751288983;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=twNPMLQp01Bo2vXXogp5BYmu7HQ0Fhpvi4oqZpYihgI=;
  b=BHds9SRh8/1fhHr02vcoaDJJU9IC+mV9r5sqkwtAs3z8Z/b0qrZvBXAK
   HKAh/ai517XGvavTA6qd+wRAzXFSlnQYXDvqBIJZVCaoc7dWGY85v5OL/
   heS/xK1uvtdKtilTrCjHYohcW9+piurEZsdbWSPVJjATW7PK7dfNRn6sU
   x37ce3FxAmHOf6kdq1PSR9AstB2mg8Ex/kyIqpndWrLC+XiARe+ujSNJV
   n+48XpuzbUMb/xiheV+Kk7yy8Blp3w7j6QLa1/j4q+9zB99X0dJEUGs7m
   hm1IF9ugZFiSBM3HOsxD20nYwghNw9FBOC+mhzpIMXUohHbxMrtmCMH9W
   g==;
X-CSE-ConnectionGUID: r2ctcoQaSKWunACu593jyA==
X-CSE-MsgGUID: mgxF/ZvdS++lMQ/ZnZSNQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="17015466"
X-IronPort-AV: E=Sophos;i="6.09,174,1716274800"; 
   d="scan'208";a="17015466"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 06:09:42 -0700
X-CSE-ConnectionGUID: yuUaeoRLT8uX/znuO9rzBg==
X-CSE-MsgGUID: ZvN2CfQHQDCA2LTzesQYsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,174,1716274800"; 
   d="scan'208";a="45335657"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jun 2024 06:09:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 30 Jun 2024 06:09:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 30 Jun 2024 06:09:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 30 Jun 2024 06:09:41 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 30 Jun 2024 06:09:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kD+0H9VGPDRPapvaAn3an5L+whcYC5cAgbaIcwKPM12i7gOjYwDPy6nfMuXMGZ4QsBArK0lp8PGzTX8BS1JCgm4qQGQHpfsrPJPDJnQNFjZaKYte4Oj238Lz2P926lr+q2WkTBvilBFs2EdcjtZS/YQtCSZxytleqYfk2sx/lXD1lUiVKLmuApQCURZJxcry4qAcXDGcEMGTCF+RuXX2gNsdZdnYxx6g1wiceFZjal/R9Y9pFoLHfGeVq/VwZ2WkdwdW9fgqDCyfiVVP227suYhTRl9Ond1Ox79EeodIWaatHo4fnP1MqeeIwBwmI2LpeHLfe3EYcX4biyan2SguUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHYTVGGOR5Sup5FYUUwZFPhWna/jXtHozu+OLngsJMY=;
 b=T6IFpmDpTpSOYss9UY6S6kBc9vA6sK444CtbzdqTHElW/mOKma8kAs2NQgX2Va5D5vVpTRmClv/Kt+fbTUynXmGv9+cMfJoIKIkGjrUlAsGh9NyzuM4wlaYca/WsDdwnWPhbdIBw2WbLavvMJAOE5Wmwrr5Qslg2tdbFM46k8Y1QKbpzArfVhmbxDLEvAS15WKLZmKzJwtjpBaXI6aaErLuYH3aFxeVYKVA7XDV/jdYM6HRzby6arA/UZ6a9D8qm2PWjxJlO6lAVr9uxAAow9hj+G85hqeskC+qtpbTYet6SqurAZjfHSCggEaOx3c3ecL0CFTwfFfieNcFnI+sDjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Sun, 30 Jun
 2024 13:09:33 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 13:09:33 +0000
Date: Sun, 30 Jun 2024 21:09:18 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Mike Galbraith <efault@gmx.de>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Tim Chen <tim.c.chen@intel.com>, Yujie Liu
	<yujie.liu@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R .
 Shenoy" <gautham.shenoy@amd.com>, Chen Yu <yu.chen.surf@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Record the average duration of a task
Message-ID: <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
References: <cover.1719295669.git.yu.c.chen@intel.com>
 <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
 <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
X-ClientProxiedBy: SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) To
 DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: d05bba2e-c5c7-4b63-6b92-08dc9905e241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?FxsRyw3b6Erk7PLzX3Nt3XnMPQ8/xtMhhnKW8yE1d03Oz7TJ/9sSJLnyGH?=
 =?iso-8859-1?Q?T0dOZKsCF3CaOlP0pNjOy0dAsksJu0k+wqcveTBfAxmDAYzMhu0P9zrdYQ?=
 =?iso-8859-1?Q?DivpaMWKCdwkn5B6HHUSSyzIQYj8s29qJ4wKYDz3U1p4YOY+YF6eTuMWms?=
 =?iso-8859-1?Q?5ZDUtLvMX+DDtO9E8lIhLh3mZEpnOXuhlauhSyTF5tNly8uhi6+GwgbEZl?=
 =?iso-8859-1?Q?xZnqfctNnAfgejSajV7n+ZG/Q/kLCWTtjphOIggKg2BPHgNN/rgUFdbXTJ?=
 =?iso-8859-1?Q?OxNz3obG7O4ViYHoGZq9S7uT/TKE67usnEu+2YbpIxG5MrPNQKNvYJMCbi?=
 =?iso-8859-1?Q?99DIWnELsK4jMVu4E7NBu44lsYA7htxqp6ANuQ0DzTgmUtZK6XBFRturd8?=
 =?iso-8859-1?Q?bwjZi7whYiQtSMWyXXY3ayjQKG6VXeFq3oAulS56MNk18A59U8V5EsLIwG?=
 =?iso-8859-1?Q?Ri4i1rZYaJdxRWdnuWL8zmtmdH4BwUmCbFU6huOW5uSy9KSqqWyh1uRtA9?=
 =?iso-8859-1?Q?FzMvdQRyTY7413TZQIqkB+3bxBC/DqzNs+N1IdUTt1oALXGpJDU9715RYa?=
 =?iso-8859-1?Q?RCKwzXxknWQIrEr9R+Mknx0qAhMDRQOHZchI/5I9lBxLW6pe4BBCU27Kwk?=
 =?iso-8859-1?Q?p/5PIAEhc9DCDD87Poj5VzTiwP6RujEEvZzg+EirEXgJEUr9UYdzBsChqP?=
 =?iso-8859-1?Q?jy5ctJD/4s8o5CEwk/c0srg2PNeXPAX9vDg7+ZUQjxncbL2r65N1ig5Lzo?=
 =?iso-8859-1?Q?Ug+FXy/7t6rt3dCg70xPf9XP47hyeoZ868kbbWhH/Sh0+h7Ki9SVRuCp9i?=
 =?iso-8859-1?Q?VIM523lcndJmlDVz2hM/4A2B3HLN5QmweenWn3y7atoxNrRBewcIiYVLKT?=
 =?iso-8859-1?Q?uBEbO9bZEhx1TPv272JVrBwam8mdMdd00YmV3YTmROrsMmtTuQ0qxHkeBm?=
 =?iso-8859-1?Q?82sl6cwlgTHDcQNifZv4g6g3P/6ELt2YCqKxEdSBz5HoXKQMYu+XPR25OL?=
 =?iso-8859-1?Q?cMMOCabWAxgabD+1QMN0VLyWoQJsMzLGu+aJkGYupqXHxXpM4SOlcYYyD3?=
 =?iso-8859-1?Q?fUGoz6JPO/L6A3ybgPonES0x2CDxBVBAGl89RTl6ub9TNfksfaFXIOQ/88?=
 =?iso-8859-1?Q?U4G90iAmEGDxjtPY/aJtgHfB/QreUT4Pf5rkPPjLXr/xbIn7e7i6QprGWT?=
 =?iso-8859-1?Q?dxN9YvvuOJjVBU9yuwINEqUL/Py5MeVnqCyZa2qHYA9Cpffowuc+UAQBA5?=
 =?iso-8859-1?Q?w9Lx1SlCxyLEJPjfTUi86Y7m7YUgw8lNFz2jR/yHK+jI1VWb06QZADoPAK?=
 =?iso-8859-1?Q?wtvPBD6JoOJ5lBDvqa+XT+TiCeQl/xLak8+WY+iK+NIzm0o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8Wr+6kXoir3Y+Ud95wJ4N3+oFIQJvVjjNa3Y2x1SSv4/NwnuKeFXY10j0C?=
 =?iso-8859-1?Q?SF+WX3YbPigixsbL/lCtNZHqWIYyNXsW2X1LeyQ0spkMSXWXFbAwdiCrSu?=
 =?iso-8859-1?Q?efwoDHlo3k0w13zM+pJuCI869LRLD/8dlwFh3E2554IAmMPcSftHlHuFT6?=
 =?iso-8859-1?Q?PNPbJ1ReZTAJ7t0mH7G/6il4yhXObBvVwlp8NMcdxTsFOCfichAArA4skL?=
 =?iso-8859-1?Q?rCHqJpFExt0gBV04bexi7CNlRyiAZceqgUsvzEB/U6UWHUBUFpMQHgZYO2?=
 =?iso-8859-1?Q?hTWX572qwNvRwOuiHRZBSKwDtlNPut/vhm5DsKlN0iL/hYm5vUavtcv2W/?=
 =?iso-8859-1?Q?ivnwQ2x3cLlGawFR3etAPkAo8cVfp7lao52OqcKlXTN4Ps9i7o7OrtkSTY?=
 =?iso-8859-1?Q?SJVyaCOsWOZxWUeZVNFUFBgeh5P5PQQ9hDO4GOZyIkMmFEkxyZ8jPxnl8o?=
 =?iso-8859-1?Q?ly0qdksyu9nEJ+R9Mwku4o9bShBExmsdaalsYfyKM5mZUQ90ib8g3aJCB4?=
 =?iso-8859-1?Q?Te/S/LEu0BYLIsRcz/MOSddk2ZgC6nZAzGsOclA66bQgWQ53Ji12CwA5by?=
 =?iso-8859-1?Q?TtQG4KImrMxE6URqoxsPrHcGfQ9BvtT33IB1KoWLXEjPd+Pt2ZAVC+5i0b?=
 =?iso-8859-1?Q?9lCbDrmLc6NHO6D+ESZmMI6tQvcb0PDeJWqjsEE/j8SHgEfH+nOhIjwETZ?=
 =?iso-8859-1?Q?GdWpDgUj/NYZBMAcDaSTDo3anVY39ogsb2tRONyM2E4I34+sfP0mKEpdUP?=
 =?iso-8859-1?Q?QOKL70nysuIO8sk+ZyiZ+mLexgD1m2vMBtF/4e6zYLxReBYUyWlAZhYhkQ?=
 =?iso-8859-1?Q?YtK4FrlMle2KrygoJNKjqRSBM0hwcsAZU3FFXaAcaaGxVEkLfM+DWgR1Yv?=
 =?iso-8859-1?Q?htbYEirOGGNPcm58UX/IC/vb+nuXTOo6634/b9Wh2p2mzElOiZaBW+JIjS?=
 =?iso-8859-1?Q?HbcwPF1DufSQBsmpNigVFqImkEVweG3C27wsUYTLy9U6/koM1Ru1NCKVxG?=
 =?iso-8859-1?Q?V9e+A4bgEYd7uWQZGaupzW2qXstHcvtrRtSLBNGD66P9UNbMzNLKk6e0r5?=
 =?iso-8859-1?Q?GY4Th5FaCzOk81nh0+q/sK4pCPVGmUsKetWPXVBO1zOpyE9KHD7g30OJuA?=
 =?iso-8859-1?Q?rySNAwfvSZzYPfPzQL3l163RwRUNwh8iGT0ac+/pWjWA06hM7yVFvq876D?=
 =?iso-8859-1?Q?kEVqVd3Vee2mZ9NwwDFDszKkDlWMnFhUWFKNI5LpTiZCvCLHS/mLC0tIKH?=
 =?iso-8859-1?Q?PZGx4jPZNSL/7nEoT+/houd329qK5oysUL5IiZqkU/dcqQMvEyvtEAVVsB?=
 =?iso-8859-1?Q?E97iJmiMYxVYzZpkoxQaky+xGsrAS6UZaLdOtqFaWiv8s6ys0YtGi5Bif2?=
 =?iso-8859-1?Q?Vl84gFqOUThlg9iMhGUxKIpSMCipJiQesMMzevmmUZFn1xgdgB5gTXt4y1?=
 =?iso-8859-1?Q?GK5OX7pjTlTE14yLcS22W7kc1/wONQOdVfsmWFKuJ6t06Hco3KA0rymKhw?=
 =?iso-8859-1?Q?XJi22Pa8/8uiRinQzi+OjjgALP8VjjDYHH2W7/omCxNnKTOMgb1zKGh+40?=
 =?iso-8859-1?Q?XYM7Tldlls30nWzt4OPl/QkmWbJsFbST37Nzlx3KPp+xO+BOsB3QIZJdhX?=
 =?iso-8859-1?Q?cz14QeLj3rS7POJIy6qpwGpoJh04sEeOHF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d05bba2e-c5c7-4b63-6b92-08dc9905e241
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 13:09:33.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsZb4TvaOVWKtGE4UR7Cddo8mHBqZhFQhDqXHtGIcPz/OG/lcKbksfUnqiIxNTBVv2TQX39yqdPXBIfcP40ZJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
X-OriginatorOrg: intel.com

Hi Mike,

Thanks for your time and giving the insights.

On 2024-06-26 at 06:21:43 +0200, Mike Galbraith wrote:
> On Tue, 2024-06-25 at 15:22 +0800, Chen Yu wrote:
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 0935f9d4bb7b..7399c4143528 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4359,6 +4359,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
> >         p->migration_pending = NULL;
> >  #endif
> >         init_sched_mm_cid(p);
> > +       p->prev_sleep_sum_runtime = 0;
> > +       p->duration_avg = 0;
> >  }
> 
> Beginning life biased toward stacking?
>

OK, so I should change the short_task() to skip the 0 duration_avg, to avoid
task stacking in the beginning.
   
> >  DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 41b58387023d..445877069fbf 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> >
> > @@ -6905,6 +6914,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  
> >  dequeue_throttle:
> >         util_est_update(&rq->cfs, p, task_sleep);
> > +       if (task_sleep)
> > +               dur_avg_update(p);
> > +
> >         hrtick_update(rq);
> >  }
> >
> 
> That qualifier looks a bit dangerous.  Microbench components tend to
> have only one behavior, but the real world goes through all kinds of
> nutty gyrations, intentional and otherwise.
>

Understand. Unfortunately I don't have access to production environment
so I have to rely on microbenchmarks and a OLTP to check the result. I
get feedback from Abel that the former version of this patch brought
benefit to some short tasks like Redis in the production environment[1].
https://lore.kernel.org/lkml/36ba3b68-5b73-9db0-2247-061627b0d95a@bytedance.com/

I can launch a combination of microbenchmarks in parallel to check the impact.

> The heuristics in the next patch seem to exhibit a healthy level of
> paranoia, but these bits could perhaps use a tad more.  Bad experiences
> springs to mind when I stare at that - sleepers going hog, hogs meet
> sleeping lock contention, preemption, sync hint not meaning much...
>

I see. If I understand correctly, the scenario mentioned above
could bring a false positive of 'short task', which causes
task stacking.

If the sleeper task:
1. is preempted frequently. This should not be a problem, because
   the task duration is unlikely to be shorten by preemption, and
   the short_task() is unlikely to return true.
   Because the task duration will span the time from the task is
   scheduled in, to finally scheduled out due to sleeping(dequeue_task_fair()),
   but not by preemption.
   This time duration should be long enough to not trigger the 'short task'
   case. But since there is a delay queue mechanism under development,
   calculating the duration in dequeue_task_fair() in current patch might not
   be a proper method anymore.

2. meets sleeping lock contention. This would be a false positive 'short task',
   which bring unexpected task stacking.

So consider 1 and 2, I'm thinking of moving the calculating of task duration from
dequeue_task_fair() to wait_woken(). The reason to update the task's duration in
wait_woken() rather than dequeue_task_fair() is that, the former is aware of the
scenario that the task is waiting for the real resource, rather than blocking
on a random sleeping lock. And the wait_woken() is widely used by the driver to
indicate that task is waiting for the resource. For example, the netperf calltrace:

    schedule_timeout+222
    wait_woken+84
    sk_wait_data+378
    tcp_recvmsg_locked+507
    tcp_recvmsg+115
    inet_recvmsg+90
    sock_recvmsg+150

In the future, if there is requirement other scenario could also invoke the newly
introduced update_cur_duration() when needed. For example, the pipe_read() could
use it if the task is going to sleep due to the empty pipe buffer. I change the
code as below, may I have your suggestion on this?

thanks,
Chenyu

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 90691d99027e..78747d3954fd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1339,6 +1339,9 @@ struct task_struct {
 	struct callback_head		cid_work;
 #endif
 
+	u64				prev_sleep_sum_runtime;
+	u64				duration_avg;
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 
 	/* Cache last used pipe for splice(): */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0935f9d4bb7b..7399c4143528 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4359,6 +4359,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->migration_pending = NULL;
 #endif
 	init_sched_mm_cid(p);
+	p->prev_sleep_sum_runtime = 0;
+	p->duration_avg = 0;
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b58387023d..bbeba36d0145 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -744,6 +744,19 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return vruntime_eligible(cfs_rq, se->vruntime);
 }
 
+void update_curr_duration(void)
+{
+	struct sched_entity *curr = &current->se;
+	unsigned long flags;
+	u64 dur;
+
+	local_irq_save(flags);
+	dur = curr->sum_exec_runtime - current->prev_sleep_sum_runtime;
+	current->prev_sleep_sum_runtime = curr->sum_exec_runtime;
+	update_avg(&current->duration_avg, dur);
+	local_irq_restore(flags);
+}
+
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 {
 	u64 min_vruntime = cfs_rq->min_vruntime;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 62fd8bc6fd08..7beb604ca76b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3574,6 +3574,7 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
+extern void update_curr_duration(void);
 
 #ifdef CONFIG_RT_MUTEXES
 
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 51e38f5f4701..a0004cc7454f 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -419,8 +419,10 @@ long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout)
 	 * or woken_wake_function() sees our store to current->state.
 	 */
 	set_current_state(mode); /* A */
-	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !kthread_should_stop_or_park())
+	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !kthread_should_stop_or_park()) {
+		update_curr_duration();
 		timeout = schedule_timeout(timeout);
+	}
 	__set_current_state(TASK_RUNNING);
 
 	/*
-- 
2.25.1

