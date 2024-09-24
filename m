Return-Path: <linux-kernel+bounces-337612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4C984C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8F9B21B48
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8703B13BAE3;
	Tue, 24 Sep 2024 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2XGBTIC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAB774418
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727211095; cv=fail; b=GnH326WPTGwLv9DKeCgT7wjG/Rjq4BKy4ysk/bjY5jLm02EV4o3vtBaepj0St1Pu5NepmMV7Qj0cvcCaOzQlT8NIQBMn50qXFG6GamEHB2KyLo052d+PH59dW4F76B45Cei171LNczom9v5HRAyN7IfBNawUAgK7nJcfabY0NrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727211095; c=relaxed/simple;
	bh=3zwtlDu5z1dy5LN2xoAfirYodMvw55FoFNR9nAiIDxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IflS87sn8bhWIjpUgYlDL6La0hfO/rG5RVsgx1MTs14+VZ/vWryc3r8CltxGZNBPcx5aWV4eOoK/r/bydFQFrBrNHRYYzxh7mxuKeznI52vNoN5jrapmSM2PmZmEZtfPKaJvl5hmEy6WWQL5T563LxPXIf/VsS4UNLExXfxzFqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2XGBTIC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727211093; x=1758747093;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3zwtlDu5z1dy5LN2xoAfirYodMvw55FoFNR9nAiIDxs=;
  b=i2XGBTICw1vr5zggfoivk+2vWGRO/BJST12+38r7IoqW+SxWZMdsmwhv
   5pdBwddUcPlFIf1J0F8pgUtsAt2tyfGj4HZ/dxY5H2ZpM39VduGfe4xbl
   OzZvaTVrn2//QNyvAQNXesZuoIjwQI2MoalvXCjZPGW6xoP1Zp0MAFfA5
   1H66QoTlObB9KPxdEpxkWHH5R2AFGo/nzSQUIfh7F+jXuR0Kf+EJmxJ4B
   ro4/REfHw+f3A7ZgvOZIvwn6HjpwWpYUTJySrdwIU5q0BlQ9WLtY7i95C
   75NKOyCG5pI8yUVV3PeE+1f9oMXBZ8Guj5z4EKlEmTSzcpVC7F0sI+Pd4
   g==;
X-CSE-ConnectionGUID: A1KsxGYxSt2zCLWfGDuRrg==
X-CSE-MsgGUID: WAVKjXsEReqXwpguHJsBXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="25706823"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="25706823"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 13:51:32 -0700
X-CSE-ConnectionGUID: FkzTQq1KQxaXnwHbV+YWrQ==
X-CSE-MsgGUID: eqPoZ9y+QJC6LjpKXbBLMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="76300729"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 13:51:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 13:51:31 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 13:51:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 13:51:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 13:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlZFl6Mle3u1K3yKSh87TJbd/+gMSNi1GpFFT3Tc+ylIFzn0KDF3cfVWqtat6jm8V0deokD8zRWFItFnE6WRqNgoeaauE2wAWHpf4prsPs284rWBmm+gKxnYT7KcC83FnIW1WmseczbOVIe/NcsijXTZdfLSVyZ7MtfKhwcJmfSe/JIO/CaBaV6e0P1AUHeHEcHck/lXRPTZGHcG1v9cJzZ1p6NNUDL7MMWJT9brvYyrZgfSBTcbrbch+BKcf+jwdGs6Mcl0CxqEsFURgdMOtK/zVvIwmkYYgMmbKTd0II8/F96g/V2tkKdlo0KbikopvXfYFb6LbEtWpCLb4+09lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zwtlDu5z1dy5LN2xoAfirYodMvw55FoFNR9nAiIDxs=;
 b=aaCMTwr5NK49yzDdVmNWHKuX6Re8zGdJHauuE/LszeTq3wfjBUmDA8TzOQ+/0DQVJSsgLRAXrWmd8NVVw+oCq2GrTIQhX7M+VJy9X8DEmyUJFxTzcuVWgfeNFECBu0GI9kqEREiZ5PeAoskJehtrZvp1z5q6iku0hdghh8uV/jRzd/bIf9CKQTG6B8RAs5tp2WNg3fRaaINVrs8KXo1XHmojElxwKcgT654hMaSGGt/ZTEZ8nYO3i3XBtSaGewJtsGADMhyb/KVmdtuGJMKCWYujEf1/9tJd5R/bNQDUN85o1HXCkM9G+N7TY5XhntRHlgR6SSkJ0JlKcz6EHoguTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 24 Sep
 2024 20:51:28 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 20:51:28 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Topic: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Index: AQHbDh+C+ZYgIzdq4EuvViy0xt7aPLJnM4MAgAA0ncA=
Date: Tue, 24 Sep 2024 20:51:28 +0000
Message-ID: <SJ0PR11MB56785712C0EF98B7BE558720C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <CAKEwX=Nw_ax0RRSaD9n3h1vqbu+5PEuur3RqXrMrYyvOPuzB3Q@mail.gmail.com>
In-Reply-To: <CAKEwX=Nw_ax0RRSaD9n3h1vqbu+5PEuur3RqXrMrYyvOPuzB3Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH0PR11MB7472:EE_
x-ms-office365-filtering-correlation-id: dad54e0d-95f7-4c7e-c2da-08dcdcdaa975
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SHhXNlJ6NTgzMEhHRklSZlBmKzZMQnNRbGNGdWNxRjhmZm4vNCtLazhiS243?=
 =?utf-8?B?ejRHNWFlNHZKR08vOGp0VDI5aDZORGx3dVlxaGQ0KzQ2bGdBUHh1OEtpenly?=
 =?utf-8?B?V1l2VUtLZGRlbEJIbnFacFdFeUtkR0tyeTYwaklScUs0cGk0U2xWVnhRSEF0?=
 =?utf-8?B?Z1hQV1kvTVNuSFV0SEVDN1BjQmJCekhYbVFRd2pCS1NhdVhIY3JxRzBNbi9a?=
 =?utf-8?B?ZDcxeWRuVFh0czdVNGJwR0ZWZ1ZSQ1MwVFhVaDkyaDNOVFdQREZ1djVBdG5V?=
 =?utf-8?B?MXFpRS9XUEFsRjd4RFY5Z1NzWll2SWluU0dKZUZudEErK21weTZoQXJlZzlz?=
 =?utf-8?B?UmFEOTFCbUNVMHQ2U3NYZ0d0V012VzQ4aUNOZG5DWE4yTUdDSUNQeG42WDNU?=
 =?utf-8?B?NVdCWC9hM1llNEt6c3Z5RlY1bDVUckFDd0t6K0JiQW5aQkZXTFozcjNsMC82?=
 =?utf-8?B?bUtJdythQjM4L3pleGx5SEorWHdnbkFuVzQyTnpjUEtBbzV3N01YaXRuczNh?=
 =?utf-8?B?Wkc2bnBmOTd2Y25xdHlYYkN5VzY1WDlOSUZHZVQwWmQybzdiRXovUmZvWi9n?=
 =?utf-8?B?NVd6RFpoK1lReTg2cVNuYzNuNXpNNWZVaFliTHZyT3FKV0l3SkY1Sm9la0x6?=
 =?utf-8?B?Y01vQUo4cGlheFB4NU1nb3pjZ0kwcjVPaml4VWVDR3hTWHVOcE1QUnpLU1dr?=
 =?utf-8?B?Mml0eW9DY0IyMndhUVNOZzdJSDdWd1VsWkdUMmZzMG9yTjhpcGZJZzVvK0pL?=
 =?utf-8?B?QXNJVGVyNUFsQW5uMnlxRkFOa1BFdWUyeFBoKzJCalFDUnRCRkpIMUoyZHpH?=
 =?utf-8?B?SGc3L1BvN29CaERvVVdRQkZ3UE1jUXQ0SXAwd3VwZ2szSndLUzF2eHduRC9w?=
 =?utf-8?B?YTl2NkZlNlZOWVhBVXMvWmEwZUpSNFRxaU9UMVNhVFZ0K1VhdytUU29JVEF3?=
 =?utf-8?B?ekV0SGhSTHdWM1NNbS9VL3oxWVNCc2NQVlFJQXBoRzh6VG1EUWxDb1NzNGJ1?=
 =?utf-8?B?YXpmM1czaXE4NThOcTdYQlY0Q3IvN1lGU0gzamRkZlJwTFNiQlB0RXU5bmNw?=
 =?utf-8?B?YTJtTjV5S09xR3FqbjhxaGZaVCttNEt5cU13U0FaSkFrc0JhV1BvVmFjSHd4?=
 =?utf-8?B?SUFOdThKVEEvU05jT3E3VVFwWGhRWHZvZVpLVWVXZnNsUXRocER6MGdqSHJk?=
 =?utf-8?B?Qk9aa0lYL0FCMGhDdkRJZS96NXQyNEl2OWsrblQ1aGdnb3JwdmJkc09kRGlD?=
 =?utf-8?B?dHNTNDE4OUdvMW9sN2UzaTF6OW9pVEhyMnF3cElPNk9DcFo0czhUaHlySkZD?=
 =?utf-8?B?YXlpeXA2MTJxbGowZGFmaEpjb1lEdlBDbEVrazlKaHNsMDRqbjJScXJSemFQ?=
 =?utf-8?B?U21pRkQ0Z29Vc2tYMW9YU0JXYUc4SysyQkJuVlZXd1c0ZGdLSFlhQytwejh1?=
 =?utf-8?B?cDIvOGlmWG8rOTI5RjVNMzJoNWQvK3hlNGZwajFLSGczaStpdVlzUXQzeG9w?=
 =?utf-8?B?VWNWdE9MSnlHM3NiNjMxS29Hc1ptN0p3M3Mwcy9iVGZzaFl4SmtEa3JhSlBu?=
 =?utf-8?B?dmZHWWc3dTc3djVyaDRIQVBlTmlXY21OTmd2aDM0cXRobTJuRm15a0FHM1Ju?=
 =?utf-8?B?cmNvREE1K3MxTU1Sd21SWUFQV3hqdHRzZjcwKy9hVTh0RGFWanljSllJL0dn?=
 =?utf-8?B?MCtWdGdtZWo0dGNLRHRJL2kveTN5UzZyU0FFdzhEYXV3ZHRneHhwcGhHNDlV?=
 =?utf-8?B?TmhEMWxpK1g3TjI1Nk10eVFOMWUwSjRuUkpBSy9ObzVnbnJQb3B3WkZmVm9N?=
 =?utf-8?Q?BDEl0jGWfHQEpOKwjeyPALe9fIGtSYfYDJUV0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGNaQlRCTWlDVWhxUU5pek5tTHNTM29vd3c1REpubWtpR1JSSlU4bUJWTVRW?=
 =?utf-8?B?VUNjQks1WXlUZWMyczlGVktscVlLYnJZb1VIaGtjRXJ3VElPS1hkeEI3MHI4?=
 =?utf-8?B?dkJleW1aMFJRbmsvek8wV2pOdEJtcWxmK2NFbnBRUUpsTGtDbFRyZDhWZUdK?=
 =?utf-8?B?Z2t0QVh3bGxCN1FYd2puUm53TEZVKzhUUEgzcURBRjkyODh2SThxMENqc2Iz?=
 =?utf-8?B?Vm1FcnFNMUVReGlROVlocUdaajBITzc1WWhGcFBSdC9qaE5hcVVQZXk5d3gy?=
 =?utf-8?B?Tzk0WVcwZlZRbVdTdWF0MzVJOGlzS0V1dnU0VFdMcjZGN2FUUStVQ3Z6WDNl?=
 =?utf-8?B?UUNzMnVZN1ZXTTliVzJSd2JoUmRKaVBQSmxzQi9WeERXR05Ca0JLQlhxaEJt?=
 =?utf-8?B?dTN4bGpJZ2dBWlFtK2h3MVVVd1d4eFhocUREZzFCd09vaDRxbXEyOEdOcFdV?=
 =?utf-8?B?RStrRkpKRVRyYnBiUjg0WnVVNjgwZGVxa0c1MFpNaE9SY1psUkVwN2loaW85?=
 =?utf-8?B?YkFSckorVk05c3J2RTVNT2xLdXRHeGtNZHh0TWE2Y0ZHRTh4aE5aY2V4bHBs?=
 =?utf-8?B?OHM3eFBhMmcwaVlvUmdlVTcvSkVsUGlyYVRWRHdhZytUb1JoOG9xbWhDdU9l?=
 =?utf-8?B?ZHppMG1NeEZZSzBkYm5GTE13US80WW4yOTQvL0l5Z25nUjRuUnYzazIrRGlS?=
 =?utf-8?B?Y2s4azJmU2FVMEFCTG9GWW90c2plK2xSWmRwUkhvUlppcU9GWXV5Sng0RmlG?=
 =?utf-8?B?WEdCWjlNVW5DcEpoWlpWNHBKVkhaMkFKdzRleHUzc3ZUVFZiREZTSVlDMitT?=
 =?utf-8?B?b2FlVm1Eb3hFV1d6TmFRdGliYVNiWmFNbTRTdW1YWVJkOWp4MmszSU9DZk92?=
 =?utf-8?B?SVd0VFIrZnZockVXUnNCWXFrNWliMUdXcmlHc3dpRm1MYVFnamxHODZFNE1E?=
 =?utf-8?B?WW1SbExDRGJsMXRScmFrRElPT0w5RXY1SnpZV0hoY3cwWEpJQ09TVFd6R2pU?=
 =?utf-8?B?L3YxL2FXUUdsdUFZVjVsV3FaNFZaNkFYVmtRNnU2WlVzWGV0UEtKaDRzQjk4?=
 =?utf-8?B?d1V6SG5XU1kvdGNtSzhtNVJhejl3OTZhRldHKzVsZ2szVEwxNUdxL2xyWkw3?=
 =?utf-8?B?YnRlN2orbTdBdnNsSStrTEVpZzRkMjlCSVBObDJRK2V1UEgydEpjTS9JUXE5?=
 =?utf-8?B?djBIcCtqUXNpZzh5cHdHeFE0enZmeGV0a3FQU0FMMmRYSTRtL01zKytCengx?=
 =?utf-8?B?bTBCeE14MVh4MWdEMlBTOXo1RlUrOFhKY3ZiR2NyWGZSOTUxa1RKNHZRd2h0?=
 =?utf-8?B?eW5UajRIcmQwNWF5V2dudzNFZDJKUXh2NmlNeitRc3FzVTQ4T3Z3YTFnU1NX?=
 =?utf-8?B?UERTSnFkdzR5RHVYdXN4enk5T2s1aElnN0xiWUV1QUpYSUdiNEhtSCt0R1Nv?=
 =?utf-8?B?UUo3ZUpDZUZJQVRWenFRVWQ4VXp4TjljZFJqWjZVeWp4a0prbmNyaStDME0z?=
 =?utf-8?B?TktxZU1DZmdCbFo5eFJtTnRuRnFvZHZCbFZoNytsbzQyMzQ0aTZzUzU1aHlo?=
 =?utf-8?B?d285Ym5ReGpMeXQ1c0N4dldFOGNTQWdXQUI4b3pBTVF6TEFHUGNhTDc2aTFy?=
 =?utf-8?B?bU9oUHJNTzZ4MmMyYVU2azFXNUNyYVEwN0F1YWtBbUFMcGllV0VRb3BvQURQ?=
 =?utf-8?B?TDY0QytSd2E1UmRKTjJLa2FsbHZkUmNEZERLWFFsVlFKRGR1L1lyVjhubUVy?=
 =?utf-8?B?MDEzbjNVMDR2QVhPaVQwVnlHUHdHUjhnV2k1UEFudVJ3Wk4vYUtCNVBrbE5Z?=
 =?utf-8?B?M1diUWhScVdZQUlPRUQ0MXFJem5XdHF6YkxscC9wVzZTYXRqajBhVURMaHVn?=
 =?utf-8?B?UWdPWW5rSllBdy9ab3d1bEhEREJnNGxPQUhENHF2UkZyU1BXeEdSdmtqV0pq?=
 =?utf-8?B?Z2t3SmM0ZjRpT2UrMi82aUxVMVh5S0VzZHRuYU1lZEtwc2RlN01ROFZlWDZu?=
 =?utf-8?B?TUpQdUd0dGx5ZjAyQnJzbm5ITnRoRll1STBXTHRTcTVmd0gzNURsTXVGdmhj?=
 =?utf-8?B?bTcrRjk3c2Vhejl4UjFMbFV5d2dQLzkvV1Z2SE9DbGRKQzNTZGNoMUdBUWdL?=
 =?utf-8?B?S0R5cUFDYlJPRmZPZkI1Wk1WSytvb1dDOUFKbUs3TnlSRlYyOU1tU3MweDFu?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad54e0d-95f7-4c7e-c2da-08dcdcdaa975
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 20:51:28.3261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcvwWxvFLPS9cOqV8xjv/XtsG6337gYV6/+REvtgh1ej0ANiEthPDT6E/JIKRVHtHdRAOicGgBqK8NSkajRb7qah8v2tgax7o9s7TmhuF8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NA
Z21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjQgMTA6MzQgQU0N
Cj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+
DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7
DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgeW9zcnlhaG1lZEBnb29nbGUuY29tOw0KPiBjaGVuZ21p
bmcuemhvdUBsaW51eC5kZXY7IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207DQo+IHNoYWtlZWwuYnV0
dEBsaW51eC5kZXY7IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyBIdWFuZywgWWluZw0KPiA8eWluZy5o
dWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9u
Lm9yZzsNCj4gWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2Fq
ZGkgSw0KPiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9k
aC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgNi84XSBtbTogenN3
YXA6IFN1cHBvcnQgbVRIUCBzd2Fwb3V0IGluDQo+IHpzd2FwX3N0b3JlKCkuDQo+IA0KPiBPbiBN
b24sIFNlcCAyMywgMjAyNCBhdCA2OjE34oCvUE0gS2FuY2hhbmEgUCBTcmlkaGFyDQo+IDxrYW5j
aGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IHpzd2FwX3N0b3JlKCkg
d2lsbCBub3cgc3RvcmUgbVRIUCBhbmQgUE1ELXNpemUgVEhQIGZvbGlvcyBieSBjb21wcmVzc2lu
Zw0KPiA+IHRoZW0gcGFnZSBieSBwYWdlLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBwcm92aWRlcyBh
IHNlcXVlbnRpYWwgaW1wbGVtZW50YXRpb24gb2Ygc3RvcmluZyBhbiBtVEhQIGluDQo+ID4genN3
YXBfc3RvcmUoKSBieSBpdGVyYXRpbmcgdGhyb3VnaCBlYWNoIHBhZ2UgaW4gdGhlIGZvbGlvIHRv
IGNvbXByZXNzDQo+ID4gYW5kIHN0b3JlIGl0IGluIHRoZSB6c3dhcCB6cG9vbC4NCj4gPg0KPiA+
IFRvd2FyZHMgdGhpcyBnb2FsLCB6c3dhcF9jb21wcmVzcygpIGlzIG1vZGlmaWVkIHRvIHRha2Ug
YSBwYWdlIGluc3RlYWQNCj4gPiBvZiBhIGZvbGlvIGFzIGlucHV0Lg0KPiA+DQo+ID4gRWFjaCBw
YWdlJ3Mgc3dhcCBvZmZzZXQgaXMgc3RvcmVkIGFzIGEgc2VwYXJhdGUgenN3YXAgZW50cnkuDQo+
ID4NCj4gPiBJZiBhbiBlcnJvciBpcyBlbmNvdW50ZXJlZCBkdXJpbmcgdGhlIHN0b3JlIG9mIGFu
eSBwYWdlIGluIHRoZSBtVEhQLA0KPiA+IGFsbCBwcmV2aW91cyBwYWdlcy9lbnRyaWVzIHN0b3Jl
ZCB3aWxsIGJlIGludmFsaWRhdGVkLiBUaHVzLCBhbiBtVEhQDQo+ID4gaXMgZWl0aGVyIGVudGly
ZWx5IHN0b3JlZCBpbiBaU1dBUCwgb3IgZW50aXJlbHkgbm90IHN0b3JlZCBpbiBaU1dBUC4NCj4g
Pg0KPiA+IFRoaXMgZm9ybXMgdGhlIGJhc2lzIGZvciBidWlsZGluZyBiYXRjaGluZyBvZiBwYWdl
cyBkdXJpbmcgenN3YXAgc3RvcmUNCj4gPiBvZiBsYXJnZSBmb2xpb3MgYnkgY29tcHJlc3Npbmcg
YmF0Y2hlcyBvZiB1cCB0byBzYXksIDggcGFnZXMgaW4gYW4NCj4gPiBtVEhQIGluIHBhcmFsbGVs
IGluIGhhcmR3YXJlLCB3aXRoIHRoZSBJbnRlbCBJbi1NZW1vcnkgQW5hbHl0aWNzDQo+ID4gQWNj
ZWxlcmF0b3IgKEludGVsIElBQSkuDQo+ID4NCj4gPiBBIG5ldyBjb25maWcgdmFyaWFibGUgQ09O
RklHX1pTV0FQX1NUT1JFX1RIUF9ERUZBVUxUX09OIChvZmYgYnkNCj4gZGVmYXVsdCkNCj4gPiB3
aWxsIGVuYWJsZS9kaXNhYmxlIHpzd2FwIHN0b3Jpbmcgb2YgKG0pVEhQLiBUaGUgY29ycmVzcG9u
ZGluZyB0dW5hYmxlDQo+ID4genN3YXAgbW9kdWxlIHBhcmFtZXRlciBpcyAibXRocF9lbmFibGVk
Ii4NCj4gPg0KPiA+IFRoaXMgY2hhbmdlIHJldXNlcyBhbmQgYWRhcHRzIHRoZSBmdW5jdGlvbmFs
aXR5IGluIFJ5YW4gUm9iZXJ0cycgUkZDDQo+ID4gcGF0Y2ggWzFdOg0KPiA+DQo+ID4gICAiW1JG
Qyx2MV0gbW06IHpzd2FwOiBTdG9yZSBsYXJnZSBmb2xpb3Mgd2l0aG91dCBzcGxpdHRpbmciDQo+
ID4NCj4gPiAgIFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS8yMDIzMTAxOTEx
MDU0My4zMjg0NjU0LTEtDQo+IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tL1QvI3UNCj4gPg0KPiA+IEFs
c28sIGFkZHJlc3NlZCBzb21lIG9mIHRoZSBSRkMgY29tbWVudHMgZnJvbSB0aGUgZGlzY3Vzc2lv
biBpbiBbMV0uDQo+ID4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IFJ5YW4gUm9iZXJ0cw0KPiA+IFNp
Z25lZC1vZmYtYnk6DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FuY2hhbmEgUCBTcmlkaGFyIDxrYW5j
aGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBtbS9LY29uZmlnIHwgICA4
ICsrKysNCj4gPiAgbW0venN3YXAuYyB8IDEyMiArKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDY2IGluc2Vy
dGlvbnMoKyksIDY0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL0tjb25m
aWcgYi9tbS9LY29uZmlnDQo+ID4gaW5kZXggMDlhZWJjYTFjYWUzLi5jNjU5ZmI3MzJlYzQgMTAw
NjQ0DQo+ID4gLS0tIGEvbW0vS2NvbmZpZw0KPiA+ICsrKyBiL21tL0tjb25maWcNCj4gPiBAQCAt
NTksNiArNTksMTQgQEAgY29uZmlnIFpTV0FQX1NIUklOS0VSX0RFRkFVTFRfT04NCj4gPiAgICAg
ICAgICAgcmVkdWNpbmcgdGhlIGNoYW5jZSB0aGF0IGNvbGQgcGFnZXMgd2lsbCByZXNpZGUgaW4g
dGhlIHpzd2FwIHBvb2wNCj4gPiAgICAgICAgICAgYW5kIGNvbnN1bWUgbWVtb3J5IGluZGVmaW5p
dGVseS4NCj4gPg0KPiA+ICtjb25maWcgWlNXQVBfU1RPUkVfVEhQX0RFRkFVTFRfT04NCj4gPiAr
ICAgICAgIGJvb2wgIlN0b3JlIG1USFAgYW5kIFRIUCBmb2xpb3MgaW4genN3YXAiDQo+ID4gKyAg
ICAgICBkZXBlbmRzIG9uIFpTV0FQDQo+ID4gKyAgICAgICBkZWZhdWx0IG4NCj4gPiArICAgICAg
IGhlbHANCj4gPiArICAgICAgICAgSWYgc2VsZWN0ZWQsIHpzd2FwIHdpbGwgcHJvY2VzcyBtVEhQ
IGFuZCBUSFAgZm9saW9zIGJ5DQo+ID4gKyAgICAgICAgIGNvbXByZXNzaW5nIGFuZCBzdG9yaW5n
IGVhY2ggNEsgcGFnZSBpbiB0aGUgbGFyZ2UgZm9saW8uDQo+ID4gKw0KPiA+ICBjaG9pY2UNCj4g
PiAgICAgICAgIHByb21wdCAiRGVmYXVsdCBjb21wcmVzc29yIg0KPiA+ICAgICAgICAgZGVwZW5k
cyBvbiBaU1dBUA0KPiA+IGRpZmYgLS1naXQgYS9tbS96c3dhcC5jIGIvbW0venN3YXAuYw0KPiA+
IGluZGV4IDhmMmUwYWIzNGM4NC4uMTZhYjc3MDU0NmQ2IDEwMDY0NA0KPiA+IC0tLSBhL21tL3pz
d2FwLmMNCj4gPiArKysgYi9tbS96c3dhcC5jDQo+ID4gQEAgLTEyNyw2ICsxMjcsMTQgQEAgc3Rh
dGljIGJvb2wgenN3YXBfc2hyaW5rZXJfZW5hYmxlZCA9DQo+IElTX0VOQUJMRUQoDQo+ID4gICAg
ICAgICAgICAgICAgIENPTkZJR19aU1dBUF9TSFJJTktFUl9ERUZBVUxUX09OKTsNCj4gPiAgbW9k
dWxlX3BhcmFtX25hbWVkKHNocmlua2VyX2VuYWJsZWQsIHpzd2FwX3Nocmlua2VyX2VuYWJsZWQs
IGJvb2wsDQo+IDA2NDQpOw0KPiA+DQo+ID4gKy8qDQo+ID4gKyAqIEVuYWJsZS9kaXNhYmxlIHpz
d2FwIHByb2Nlc3Npbmcgb2YgbVRIUCBmb2xpb3MuDQo+ID4gKyAqIEZvciBub3csIG9ubHkgenN3
YXBfc3RvcmUgd2lsbCBwcm9jZXNzIG1USFAgZm9saW9zLg0KPiA+ICsgKi8NCj4gPiArc3RhdGlj
IGJvb2wgenN3YXBfbXRocF9lbmFibGVkID0gSVNfRU5BQkxFRCgNCj4gPiArICAgICAgICAgICAg
ICAgQ09ORklHX1pTV0FQX1NUT1JFX1RIUF9ERUZBVUxUX09OKTsNCj4gPiArbW9kdWxlX3BhcmFt
X25hbWVkKG10aHBfZW5hYmxlZCwgenN3YXBfbXRocF9lbmFibGVkLCBib29sLA0KPiAwNjQ0KTsN
Cj4gPiArDQo+IA0KPiBIbW0sIHNvIHRoaXMgaXMgYSBydW50aW1lIGtub2IuIEFsc28sIHNob3Vs
ZCB0aGlzIGJlIHpzd2FwX3RocF9lbmFibGVkPyA6KQ0KDQpBZ3JlZWQsIHpzd2FwX3RocF9lbmFi
bGVkIGlzIGEgYmV0dGVyIG5hbWUuIEkgd2lsbCBtYWtlIHRoZSBjaGFuZ2UgaW4gdjguDQpNb3Jl
IGNvbW1lbnRzIGJlbG93IGFzIHRvIHRoZSBydW50aW1lIGtub2IuDQoNCj4gDQo+ID4gIGJvb2wg
enN3YXBfaXNfZW5hYmxlZCh2b2lkKQ0KPiA+ICB7DQo+ID4gICAgICAgICByZXR1cm4genN3YXBf
ZW5hYmxlZDsNCj4gPiBAQCAtMTQ3MSw5ICsxNDc5LDkgQEAgc3RhdGljIHZvaWQgenN3YXBfZGVs
ZXRlX3N0b3JlZF9vZmZzZXRzKHN0cnVjdA0KPiB4YXJyYXkgKnRyZWUsDQo+ID4gICAqIEBvYmpj
ZzogVGhlIGZvbGlvJ3Mgb2JqY2cuDQo+ID4gICAqIEBwb29sOiAgVGhlIHpzd2FwX3Bvb2wgdG8g
c3RvcmUgdGhlIGNvbXByZXNzZWQgZGF0YSBmb3IgdGhlIHBhZ2UuDQo+ID4gICAqLw0KPiA+IC1z
dGF0aWMgYm9vbCBfX21heWJlX3VudXNlZCB6c3dhcF9zdG9yZV9wYWdlKHN0cnVjdCBmb2xpbyAq
Zm9saW8sIGxvbmcNCj4gaW5kZXgsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3Qgb2JqX2Nncm91cCAqb2JqY2csDQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgenN3YXBfcG9vbCAqcG9vbCkN
Cj4gPiArc3RhdGljIGJvb2wgenN3YXBfc3RvcmVfcGFnZShzdHJ1Y3QgZm9saW8gKmZvbGlvLCBs
b25nIGluZGV4LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG9ial9j
Z3JvdXAgKm9iamNnLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHpz
d2FwX3Bvb2wgKnBvb2wpDQo+ID4gIHsNCj4gPiAgICAgICAgIHN3cF9lbnRyeV90IHN3cCA9IGZv
bGlvLT5zd2FwOw0KPiA+ICAgICAgICAgaW50IHR5cGUgPSBzd3BfdHlwZShzd3ApOw0KPiA+IEBA
IC0xNTUxLDUxICsxNTU5LDYzIEBAIHN0YXRpYyBib29sIF9fbWF5YmVfdW51c2VkDQo+IHpzd2Fw
X3N0b3JlX3BhZ2Uoc3RydWN0IGZvbGlvICpmb2xpbywgbG9uZyBpbmRleCwNCj4gPiAgICAgICAg
IHJldHVybiBmYWxzZTsNCj4gPiAgfQ0KPiA+DQo+ID4gKy8qDQo+ID4gKyAqIE1vZGlmaWVkIHRv
IHN0b3JlIG1USFAgZm9saW9zLiBFYWNoIHBhZ2UgaW4gdGhlIG1USFAgd2lsbCBiZQ0KPiBjb21w
cmVzc2VkDQo+ID4gKyAqIGFuZCBzdG9yZWQgc2VxdWVudGlhbGx5Lg0KPiA+ICsgKi8NCj4gPiAg
Ym9vbCB6c3dhcF9zdG9yZShzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPiA+ICB7DQo+ID4gICAgICAg
ICBsb25nIG5yX3BhZ2VzID0gZm9saW9fbnJfcGFnZXMoZm9saW8pOw0KPiA+ICAgICAgICAgc3dw
X2VudHJ5X3Qgc3dwID0gZm9saW8tPnN3YXA7DQo+ID4gICAgICAgICBwZ29mZl90IG9mZnNldCA9
IHN3cF9vZmZzZXQoc3dwKTsNCj4gPiAgICAgICAgIHN0cnVjdCB4YXJyYXkgKnRyZWUgPSBzd2Fw
X3pzd2FwX3RyZWUoc3dwKTsNCj4gPiAtICAgICAgIHN0cnVjdCB6c3dhcF9lbnRyeSAqZW50cnk7
DQo+ID4gICAgICAgICBzdHJ1Y3Qgb2JqX2Nncm91cCAqb2JqY2cgPSBOVUxMOw0KPiA+ICAgICAg
ICAgc3RydWN0IG1lbV9jZ3JvdXAgKm1lbWNnID0gTlVMTDsNCj4gPiArICAgICAgIHN0cnVjdCB6
c3dhcF9wb29sICpwb29sOw0KPiA+ICsgICAgICAgYm9vbCByZXQgPSBmYWxzZTsNCj4gPiArICAg
ICAgIGxvbmcgaW5kZXg7DQo+ID4NCj4gPiAgICAgICAgIFZNX1dBUk5fT05fT05DRSghZm9saW9f
dGVzdF9sb2NrZWQoZm9saW8pKTsNCj4gPiAgICAgICAgIFZNX1dBUk5fT05fT05DRSghZm9saW9f
dGVzdF9zd2FwY2FjaGUoZm9saW8pKTsNCj4gPg0KPiA+IC0gICAgICAgLyogTGFyZ2UgZm9saW9z
IGFyZW4ndCBzdXBwb3J0ZWQgKi8NCj4gPiAtICAgICAgIGlmIChmb2xpb190ZXN0X2xhcmdlKGZv
bGlvKSkNCj4gPiArICAgICAgIC8qIFN0b3JpbmcgbGFyZ2UgZm9saW9zIGlzbid0IGVuYWJsZWQg
Ki8NCj4gPiArICAgICAgIGlmICghenN3YXBfbXRocF9lbmFibGVkICYmIGZvbGlvX3Rlc3RfbGFy
Z2UoZm9saW8pKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+IA0KPiBIbW0g
Y2FuIHRoaXMgZ28gd3Jvbmcgc29tZWhvdz8gQ2FuIHdlIGhhdmUgYSBjYXNlIHdoZXJlIHdlIGVu
YWJsZQ0KPiB6c3dhcF9tdGhwX2VuYWJsZWQsIGhhdmUgYSBsYXJnZSBmb2xpbyB3cml0dGVuIHRv
IHpzd2FwLCBkaXNhYmxlDQo+IHpzd2FwX210aHBfZW5hYmxlZCwgYW5kIGF0dGVtcHQgdG8gc3Rv
cmUgdGhhdCBmb2xpbyB0byB6c3dhcCBhZ2Fpbi4NCj4gDQo+IE5vdywgd2UgaGF2ZSBhIHN0YWxl
IGNvcHkgaW4genN3YXAgdGhhdCBpcyBub3QgaW52YWxpZGF0ZWQuLi4/DQo+IA0KPiBPciBhbSBJ
IG1pc3Npbmcgc29tZXRoaW5nIGhlcmUgOikNCg0KVGhpcyBpcyBhbiBleGNlbGxlbnQgcG9pbnQu
IFRoYW5rcyBOaGF0IGZvciBjYXRjaGluZyB0aGlzISBJIGNhbiBzZWUgdHdvDQpvcHRpb25zIHRv
IHNvbHZpbmcgdGhpczoNCg0KT3B0aW9uIDE6IElmIHpzd2FwX210aHBfZW5hYmxlZCBpcyAiZmFs
c2UiLCBkZWxldGUgYWxsIHN0b3JlZCBvZmZzZXRzDQpmb3IgdGhlIG1USFAgaW4genN3YXAgYmVm
b3JlIGV4aXRpbmcuIFRoaXMgY291bGQgcmFjZSB3aXRoIHdyaXRlYmFjaw0KKGVpdGhlciBvbmUg
b3IgbW9yZSBzdWJwYWdlcyBjb3VsZCBiZSB3cml0dGVuIGJhY2sgYmVmb3JlIHpzd2FwX3N0b3Jl
DQphY3F1aXJlcyB0aGUgdHJlZSBsb2NrKSwgaG93ZXZlciwgSSBkb24ndCB0aGluayBpdCB3aWxs
IGNhdXNlIGRhdGEgaW5jb25zaXN0ZW5jaWVzLg0KQW55IG9mZnNldHMgZm9yIHN1YnBhZ2VzIG5v
dCB3cml0dGVuIGJhY2sgd2lsbCBiZSBkZWxldGVkIGZyb20genN3YXAsDQp6c3dhcF9zdG9yZSgp
IHdpbGwgcmV0dXJuIGZhbHNlLCBhbmQgdGhlIGJhY2tpbmcgc3dhcCBkZXZpY2UncyBzdWJzZXF1
ZW50DQpzd2Fwb3V0IHdpbGwgb3Zlci13cml0ZSB0aGUgenN3YXAgd3JpdGUtYmFjayBkYXRhLiBD
b3VsZCBhbnl0aGluZyBnbyB3cm9uZw0Kd2l0aCB0aGlzPw0KDQpPcHRpb24gMjogT25seSBwcm92
aWRlIGEgYnVpbGQgY29uZmlnIG9wdGlvbiwNCkNPTkZJR19aU1dBUF9TVE9SRV9USFBfREVGQVVM
VF9PTiwgdGhhdCBjYW5ub3QgYmUgZHluYW1pY2FsbHkgY2hhbmdlZC4NCg0KV291bGQgYXBwcmVj
aWF0ZSBzdWdnZXN0aW9ucyBvbiB0aGVzZSwgYW5kIG90aGVyIHBvdGVudGlhbCBzb2x1dGlvbnMu
DQoNClRoYW5rcywNCkthbmNoYW5hDQo=

