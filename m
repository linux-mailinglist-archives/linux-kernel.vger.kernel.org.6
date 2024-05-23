Return-Path: <linux-kernel+bounces-187335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 345DB8CD060
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E531F23E50
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A5713F001;
	Thu, 23 May 2024 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0SDdgzz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB513C9CF
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460222; cv=fail; b=bUV3oEavfAHFp9IeuSMClfNx0ROdzHzqf49LNcOBzK7rhZOPQW7wa5OyUtYiZPDps37UjezP8Nea/JT32xy13k+pos3ghTCSSxqu7TOI26HPmJxOG4W3iwJnhhJOTQWwS5o4f53ZTr6jpZmNg0HXlA6atTWkuDRjxp/BFctBVk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460222; c=relaxed/simple;
	bh=kpoF1JK1Kcr2wGyp+5bSDWrf9SuYPg3JZBVZIfV7118=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YtcCU6SjMRvfADFJHE4vD1dfBBExP4QoH2u1hQJJX+G2D9AffZAGh0UUSihZAco6IVCpV0TRAcnZVsJTLWPbo8j0yKuO6zpc84oUIJVd6yQJ6ocLqyjG8dO5IpWAbyRUZZadNKoAJc3MxVMj/5N/jq4dl+cu0oQIBglLbSVFFHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0SDdgzz; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716460221; x=1747996221;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kpoF1JK1Kcr2wGyp+5bSDWrf9SuYPg3JZBVZIfV7118=;
  b=O0SDdgzznqPj69ckgCAAntXwY9LAtWXbouXMf7N7+09406Q3wAv1kTlb
   6/zgD/P/5abEU75t1kX4kJwRFoGNAr/IACHfUsRwruOtS0tW8fv2cH4et
   fJfixlhWMDtvVoO23ILMD8eZj60OA/HahEnbKnvwYt456EWd6UwJ32uQB
   Hqjwt7bkvXsaUXmF+wRnWartHLAsMeqnW5SuoYewl4F9HF3Qw5PmtQSiL
   2Q9dMDGSlCtoBhyeW4Mn8pWI3BZq85KrvzRpruNHe1pE/Ma7ZhX8rahfk
   x59tUUI6+HX2oF25UVUFuF5L9nb9T9QlGlavM53g1vbL8arYrqQ7lt0Tf
   Q==;
X-CSE-ConnectionGUID: GZdIgrDVRHG+SYmS8pcZCA==
X-CSE-MsgGUID: S0fxTmbOQrCRRuIVf9z3Fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23341999"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="23341999"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 03:30:21 -0700
X-CSE-ConnectionGUID: KYOzRgBNQ/W9PmGozPGWBw==
X-CSE-MsgGUID: 4MfM2Ht6RNen6OXG4lmPvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="38603023"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 03:30:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 03:30:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 03:30:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 03:30:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 03:30:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JT3pLh9uvEGIJsaY4dJC/Q1D808a4gwqgy3+q9QpHbxcj1c8akJW/pOhejhyvmpFFAM8X+MQBNX4V/iQdEPQwH6G5XlCzrQ7JHs4l2fhY0LvynDJNVOGHOHjzvmcPJZBjdsNm5Z/hjT5GBJy2aSa9sFg6IBsj+eJbqaC5gnxrjSmnG2Iztg+ySoWf33kgDAT0TL4oQOPRYMJBPV7x+95ccCd8yvgmmtd9B5Sac2J2XnYogLkYQEx9oXE4OlidwvEY6XU3/uVA+ZzDsaDCi9NAl8XP7GSd9rdE9bANnfA4r2PBg1L1/qVUwZC40fdmXH8OC8qyc2WMfH+lt4m7LKqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpoF1JK1Kcr2wGyp+5bSDWrf9SuYPg3JZBVZIfV7118=;
 b=BPli5hkynbeogTk1KFuJ9+7djboMlYBPd0H0HY+B+FbX6T5P0uEhyGmNDxLpAjTLVhrhIpUvCT5iciqsiUZGdMx9IRa/oFR6eUkcU3wSstLje1/dnfKRfEy4AYbHbkU1oH3ZWvcdve5p4nluUjNYy8OJuIBonrlhTTtVLOZSHrw7U4dPbvnLaunpch4iErToqT7M2hr7LVqZ4HwqWdHoPNz51fAHfY6KyRHnXHQGYgkwPyLXh14XelPU91LR2V+iippSAU4HWJT325BhvF54tBFyO9OkJi3f35EFD1HgLc746EzAkxqE06v55qCsVmEJtZPZsdJHxPYKLZiSKrJdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 10:30:17 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 10:30:17 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"jgross@suse.com" <jgross@suse.com>, "Hansen, Dave" <dave.hansen@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
Thread-Topic: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
Thread-Index: AQHaqFPdLMzPjSCDnUWFW5WKWhmq5rGbczCAgAADa4CAAAjjgIAAAV6AgAAI3oCAAAMfgIAABI8AgAABLYCAAAEwAIAAAZCAgAAOJYCABGSsAIAEUyeAgABMcYA=
Date: Thu, 23 May 2024 10:30:17 +0000
Message-ID: <2e07ebc774bf176ebfab40e6ba8bc14ae6a94e0c.camel@intel.com>
References: <20240517121450.20420-1-jgross@suse.com>
	 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
	 <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
	 <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
	 <03d27b6a-be96-44d7-b4ea-aa00ccab4cc5@suse.com>
	 <fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com>
	 <c0067319-2653-4cbd-8fee-1ccf21b1e646@suse.com>
	 <6df4fb48-9947-46ec-af5a-66fa06d6a83b@intel.com>
	 <86ca805d-7ed7-47dd-8228-5e19fbade53f@suse.com>
	 <f7edef9c-5eb5-4664-a193-3bb063674742@intel.com>
	 <f02d9ebb-a2b3-4cb3-871b-34324d374d01@suse.com>
	 <4b3adb59-50ea-419e-ad02-e19e8ca20dee@intel.com>
	 <c7319c0614c9a644fa1f9b349bf654834b615543.camel@intel.com>
	 <e2d844ad-182a-4fc0-a06a-d609c9cbef74@suse.com>
In-Reply-To: <e2d844ad-182a-4fc0-a06a-d609c9cbef74@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB5983:EE_
x-ms-office365-filtering-correlation-id: 2585c1c6-b013-45db-818b-08dc7b135703
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bkk1UUptbVpJVVlLa0kxNThUMjUyZXF2UXhtdHMyYmR1bmVQSFJvanN0aGRr?=
 =?utf-8?B?U0JRbnZiTFdDRXc0WURDdE1HY3MzTVAzcGRCb0pwZ0xwdnozZ3l5ZGIrLzFN?=
 =?utf-8?B?VndlWFovMkFOKzNyNVNPeGVBZ1ZBaXFuOCtFdVRqWE1xcXhSTnBZMk1tZVVo?=
 =?utf-8?B?cGtEU3pHWW1hYXp1UWlPdGJRZWtqb2piMmhQOExtRXpuSWxNRy9DanpPR2tL?=
 =?utf-8?B?ZWVVOGl0aGwzQTlaNkVHZ3FyMzdGWFRDcVFNWjhTZE5YL285R0trVzJXUEdV?=
 =?utf-8?B?b0pnckgzLy9XLzZkcUtzcmQyZnFia0ZiNVlYUTUwbE9tM3owVEgvQTJlQnRy?=
 =?utf-8?B?VklWNm5nUkxUL09HanlqaUkyMmpVempuR2dCdEdpR3VlaDhGbGV2VlZzVFEz?=
 =?utf-8?B?MU4vTEE0UHhweG1nSTF0cnpxL0NWaUl4TC9OcHdHT3dxM2VTOEl3UjJPQ24y?=
 =?utf-8?B?THFKcTZXbFkyaVVtcTJRQkgwUUt6dlIzSURPeUl3UzBSTXo1RkFwTW4veGVv?=
 =?utf-8?B?RHdBbzVIR3BVRG5zbnk3YUtRdWwwZEFZUWFhTkxSdkZ0M2YxR2FSWllEVVJ6?=
 =?utf-8?B?NWMvUzVOY2VMazBYbkdIeFJVbWtOMDM4TVFyeHpWUGFoSkJLSE5NQ3FBa1Ru?=
 =?utf-8?B?ZTF6aGZ0MzcxRUpxWVluMVBLTXNzNVNqSzNvQUorVFpwZmZ1d3R3a2YzWkU5?=
 =?utf-8?B?bDJ4YlJiTHNDSlBaN0N5Q2VsQjhwNnpSN3RKREpUR3VrQXg0K3VBRFZuUDRL?=
 =?utf-8?B?K0NJZG5DUUErUmF3OE14SytRWm1hMVVVcHVjSE9qeWVnWEs0TTVnV3BQcisx?=
 =?utf-8?B?VU54U1FWUk9KTFpsSVFaWUtXbVB0ZkVUdGNxUi9RaGtBRXZwZGM4NmoxWGNo?=
 =?utf-8?B?QjF1b0NsTnNDZ1ZuL3BCOEZiVHc0Vkg1Zkhja2w3R095eGtwUnFGdUxLVUs3?=
 =?utf-8?B?SlpKeGNKY3BudzJzYnAyeTVleTFPS0FzMm1ZM3hqMVo2RTdVVVdhQjg0c3JR?=
 =?utf-8?B?U3JzQUZBUXVEZkNkTHZ3YzgyZ2s0bDlaalFoa3lISTAyUDVMVGZJV0JybjhD?=
 =?utf-8?B?Mk14ajNPMHJBZklTZjZXYnN2Wm52L29obU5ycTdITWVxOUhGZnpJY1dwNnFn?=
 =?utf-8?B?RERMemMyU1JTZ2ZCZGJYdkd6ckI3dUVTT1h3d2llajZKMEdEYkYxbXNPMWpN?=
 =?utf-8?B?cS9IZUEwTFFsc1lFL1Q3VGFOeUxuTE1WYkRmNDhQc0RsdFRPTmlmaTE4bU5Y?=
 =?utf-8?B?ZE53T0drOE5NUHQ1dVBUcEthWmdvZ0tJVis5NnR6dHoxVnIwT1F4OFkrL1FZ?=
 =?utf-8?B?Vi9IT0Y1M3VZSDExNVRMNTFiMFY3d3BwZGJBWFcvdXIwWEtYTkg5ZHBWQ3ZB?=
 =?utf-8?B?dFc3dEZIM0RhQXFwc0VZT25qYkprK1FWSWZTRE1JZFJ1azBWcDFOcjAxUzlV?=
 =?utf-8?B?VGdTaWlZMGhHc1hEaTBMMWhmeHd0SGNyZ2lVckZWZmd1NFlFSWhKRXpmb2xH?=
 =?utf-8?B?YytOTWY3QUhydGdNajhRd0NlQzZseEZzV1o5VjZUU09GTWFYUXNwd1RTSzFO?=
 =?utf-8?B?UytKbHJUOEwvRzRiT2hYK0JFbmZFWWhsdE9VZmdLZ1dXNS9LRXlxL2hBbkdI?=
 =?utf-8?B?U0h0cEo0OGJzZEFjY1pzakthTW5IQzlPanJTNHpQMXhId1k5aXlka3pCQ3ZP?=
 =?utf-8?B?ZFBwOU0xUHdublZTZlRGRVNnQXlBMGhRYXBmcmkwUitZU1hXSlpBL0UxcW5B?=
 =?utf-8?Q?TurZjKasu2P6GJGfeU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjNzRlVJUjVpckc4L3g3RWNscEtyL1BxYlFLcFhQa1h5VGZOd2NHWGNraFUy?=
 =?utf-8?B?WitQZlltQUVoa2JWNWZQSEQrTTJ0QXl3c0k3VUpGWUlVejVuazNhREZBYWhv?=
 =?utf-8?B?c1BZazB1eVl6YTRmamhWZHZScmdZTGlTYjVWWnF6alk0SExHUHkrdGlodTRI?=
 =?utf-8?B?ZURTc2FLSmE3N0VJMVVzczF1SnpWUTZkYXFPSlFTMnVkYXZCWXBZRVlOejBX?=
 =?utf-8?B?UGR5ekI2RnE2RVVURUZvdXRnbzNhWXhkYmRvd3F0VThiclNFRGRrYUxEc29X?=
 =?utf-8?B?NmQ2Q1hCS1FCUzArYUtVT2xvZnQ2NEFvcmtOOW1tVHVRS2dNR0dSTy9EZUhh?=
 =?utf-8?B?SCtrVVZodU1NZyt4R1JNSzl0bys3N0ZTTk1wVE4zOGNEMmpvQmlvTW9yYTJ5?=
 =?utf-8?B?SFFpNnZLc1dRVDhvZEorWCswdG9Fdmk2UGlhYmlDbGMxTHoyRHorNnFta01x?=
 =?utf-8?B?K1E3UVowNmszQ0ZUOTM0Vy9Lbno4cU1iMFBpTFdYdW5NeFJ3WmU1NmpZM05i?=
 =?utf-8?B?K01oQjNiNXlWL3Z2cGFkVldJYlRjZGZST3BhZ3NpaTFlUkZlWVpRakpUWnR5?=
 =?utf-8?B?Sk1wN2RyajlFalRVemwxdXo4V0tTWHRCdGZ2ZjVwbnZFTHNPN3l1OG5TOEdZ?=
 =?utf-8?B?azZXM1MyUHVzeVQ5aEJHWTRYNitJZkEwUUJTTW1tV0RmSE45SkhtUExlUGFj?=
 =?utf-8?B?RktvTnJWV0g3Qkx3QTNldXppUjVCNlc3Yzc0cE43ZXV4a0lSZ3lDYis1UUhO?=
 =?utf-8?B?N29Pd0FHdUx0WWpVR01VNGhiK2VDTWNwVmJJRHltR2o0Y2RJNlFFV3R4R3cx?=
 =?utf-8?B?K3NZU1NYNkNYY1M4T1pmdERuZFBCRG5Ma2hxalltaDdTWWNvUVRQV1FDT0xB?=
 =?utf-8?B?b0R0K3VzUithMjJiZkt4eHdhdGpRTW5ZM1FxT2lpLzc5WTNDS2JMTDRoQ3dv?=
 =?utf-8?B?TmtCMDcwSGY0Lzc0WmhQOW9seXdMNDhiTlhHR0o0bzNoVEVaZlV0U0dWWThz?=
 =?utf-8?B?ZFV3blNUY3FDTDM2VlMrODJJOU4yWVJ2R2VRN3MwSFA5NFQrd3BrUDFHRGNk?=
 =?utf-8?B?RDk1UFkySWVneCtwZDFPT1Vpblk3eDZVbWJ3UTRQYWE1M3ExcTkrTFFXZEp3?=
 =?utf-8?B?bzFSSXVEVk5FWWdQRXpqR0pvRXR5WklNdDg3T3BsUUgyZzNKM2FycFQ0TTJN?=
 =?utf-8?B?azYyVDVPdlFOME1jdCs3aSt5MU00ckZNcVBvM1oyQ0p6Tk9rQmwrSUFaWmNF?=
 =?utf-8?B?WWN4MDQ4Q0pSV2pYNjNGUm9qK0tMYjFQSk5TTzFDbURyY2NpclBDMkhTMXlC?=
 =?utf-8?B?TU1aa1Rua3dWd2ViVytyTnR4aTUwUVkxYzdTUkpxZmxOWXVpY3U1MFBySVV2?=
 =?utf-8?B?ZlZWRFRDRGFrQnVwOEhTUWdHTXpkemVkWCtJVzJoSlFBQXE0cUFSdldTOTVQ?=
 =?utf-8?B?MDZoNG5yaUhVZnd1ZHB5SVpOYTE2eUp5b3ppdW05OElReFh1ejM2aHZMLzll?=
 =?utf-8?B?TTNZQ1AzaldvZldlUVRMVDh3c2RSMWxBU3kxSTZXN0JoMGtPWkFMQk1jdi9G?=
 =?utf-8?B?akFHT2F5bzFBaGFBelhaSmtwb0d4eThqbE5BcFBTdU95aldnUm9nTVRYdHhK?=
 =?utf-8?B?OXFuZ1A1WjFQZ1FBanE0MHYvMXpRMTROTld2d2Q3anI5WkxwRmRnRXA3V0xX?=
 =?utf-8?B?aXc1MnM5WTU2ZWdIdE5aSTFZeURwRjU1ZFBneGRJd2t4Vmd3RnQvTTFZMzNN?=
 =?utf-8?B?Sjc3TU5ZekE1clRQTG9kOFdlTzBhQ05FaTBrSkhxNzRnWSt0M1padGxob2Fl?=
 =?utf-8?B?RzBpSGYreUFhWlppdkpEMUxNYnBkS0ZVRlNqYmZ2U0xOV3NERWhLSVRFcXpY?=
 =?utf-8?B?NEpPQUlucjVOUElndU9VS2hjcGQ0dnUrdi8zSi84YXNSZWRJOFZ2N0IxY0hT?=
 =?utf-8?B?bVM3SnlRa1d6UHNZNncwR2JxU2pha283ZEtkdjI3c0ZzeUdFa3BxcklKZUNq?=
 =?utf-8?B?QUZOenN1Mm1hQWxNMkJ2MmFBZlhoVVBHZjJQWWNXZGxqMnZqSkVsRStJd3Bv?=
 =?utf-8?B?Q3I0Uno1UXYxRnNCRGk4VzJGYzVkejJJRmpWU2hHdDFhbVVwRUxCWk9ITElW?=
 =?utf-8?Q?sI49T55kVLf5vRfcU1PMz+sja?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AD0BD0A98B7754F973D57A6739D5527@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2585c1c6-b013-45db-818b-08dc7b135703
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 10:30:17.3569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDxHnKRzek6Y0XPR/EDPo/2jbjKvfiFjrq0bSPo6uhJncQgmFADcgC4L9gYLFEXakercXedyf9eX8o27BBFdgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5983
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA1LTIzIGF0IDA3OjU2ICswMjAwLCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0K
PiBPbiAyMC4wNS4yNCAxMzo1NCwgSHVhbmcsIEthaSB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjQt
MDUtMTcgYXQgMDk6NDggLTA3MDAsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiA+ID4gT24gNS8xNy8y
NCAwODo1OCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4gPiA+ID4gT24gMTcuMDUuMjQgMTc6NTIs
IERhdmUgSGFuc2VuIHdyb3RlOg0KPiA+ID4gLi4NCj4gPiA+ID4gPiBPbmNlIHdlIGhhdmUgdGhl
IHNwZWNpZmljIFREWCBtb2R1bGUgdmVyc2lvbiwgd2UgY2FuIGdvIGFzayB0aGUgZm9sa3MNCj4g
PiA+ID4gPiB3aG8gd3JpdGUgaXQgaWYgdGhlcmUgd2VyZSBhbnkgUkJQIGNsb2JiZXJpbmcgYnVn
cy4NCj4gPiA+ID4gDQo+ID4gPiA+IE9rYXksIGhvdyB0byBnZXQgdGhlIFREWCBtb2R1bGUgdmVy
c2lvbj8NCj4gPiA+IA0KPiA+ID4gWW91IG5lZWQgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gPiA+
IA0KPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzEwMTIxMzQxMzYuMTMx
MDY1MC0xLXlpLnN1bkBpbnRlbC5jb20vDQo+ID4gDQo+ID4gVGhpcyBvbmUgcHJpbnRzIFREWCB2
ZXJzaW9uIGluZm8gaW4gdGhlIFREWCBndWVzdCwgYnV0IG5vdCBob3N0Lg0KPiA+IA0KPiA+IFRo
ZSBhdHRhY2hlZCBkaWZmIHByaW50cyB0aGUgVERYIHZlcnNpb24gKHNvbWV0aGluZyBsaWtlIGJl
bG93KSBkdXJpbmcNCj4gPiBtb2R1bGUgaW5pdGlhbGl6YXRpb24sIGFuZCBzaG91bGQgbWVldCBK
dWVyZ2VuJ3MgbmVlZHMgZm9yIHRlbXBvcmFyeSB1c2U6DQo+ID4gDQo+ID4gWyAgMTEzLjU0MzUz
OF0gdmlydC90ZHg6IG1vZHVsZSB2ZXJzb246IG1ham9yIDEsIG1pbm9yIDUsIGludGVybmFsIDAN
Cj4gPiANCj4gPiA+IA0KPiA+ID4gLi4gYW5kIHllYWgsIHRoaXMgbmVlZHMgdG8gYmUgdXBzdHJl
YW0uDQo+ID4gPiANCj4gPiANCj4gPiAgRnJvbSB0aGlzIHRocmVhZCBJIHRoaW5rIGl0IG1ha2Vz
IHNlbnNlIHRvIGFkZCBjb2RlIHRvIHRoZSBURFggaG9zdCBjb2RlDQo+ID4gdG8gcHJpbnQgdGhl
IFREWCB2ZXJzaW9uIGR1cmluZyBtb2R1bGUgaW5pdGlhbGl6YXRpb24uICBJJ2xsIHN0YXJ0IHRv
IHdvcmsNCj4gPiBvbiB0aGlzLg0KPiA+IA0KPiA+IE9uZSB0aGluZyBpcyBmcm9tIHRoZSBzcGVj
IFREWCBoYXMgIjQgdmVyc2lvbnMiOiBtYWpvciwgbWlub3IsIHVwZGF0ZSwNCj4gPiBpbnRlcm5h
bC4gIFRoZXkgYXJlIGFsbCAxNi1iaXQsIGFuZCB0aGUgb3ZlcmFsbCB2ZXJzaW9uIGNhbiBiZSB3
cml0dGVuIGluOg0KPiA+IA0KPiA+IAk8TWFqb3I+LjxNaW5vcj4uPFVwZGF0ZT4uPEludGVybmFs
PiwgZS5nLiwgMS41LjA1LjAxDQo+ID4gDQo+ID4gKHNlZSBURFggbW9kdWxlIDEuNSBBUEkgc3Bl
Yywgc2VjdGlvbiAzLjMuMiAiVERYIE1vZHVsZSBWZXJzaW9uIi4pDQo+ID4gDQo+ID4gVGhlIGF0
dGFjaGVkIGRpZmYgb25seSBwcmludHMgbWFqb3IsIG1pbm9yIGFuZCBpbnRlcm5hbCwgYnV0IGxl
YXZlcyB0aGUNCj4gPiB1cGRhdGUgb3V0IGJlY2F1c2UgSSBiZWxpZXZlIGl0IGlzIGZvciBtb2R1
bGUgcnVudGltZSB1cGRhdGUgKHlldCB0bw0KPiA+IGNvbmZpcm0pLg0KPiA+IA0KPiA+IEdpdmVu
IHRoZXJlIGFyZSA0IHZlcnNpb25zLCBJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvIGltcGxlbWVu
dCByZWFkaW5nDQo+ID4gdGhlbSBiYXNlZCBvbiB0aGlzIHBhdGNoc2V0IC4uLg0KPiA+IA0KPiA+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS82OTQwYzMyNi1iZmNhLTRjNjctYmFkZi1hYjVj
MDg2YmY0OTJAaW50ZWwuY29tL1QvDQo+ID4gDQo+ID4gLi4uIHdoaWNoIGV4dGVuZHMgdGhlIGds
b2JhbCBtZXRhZGF0YSByZWFkaW5nIGNvZGUgdG8gc3VwcG9ydCBhbnkNCj4gPiBhcmJpdHJhcnkg
c3RydWN0IGFuZCBhbGwgZWxlbWVudCBzaXplcyAoYWx0aG91Z2ggYWxsIDQgdmVyc2lvbnMgYXJl
IDE2LQ0KPiA+IGJpdCk/DQo+IA0KPiBXaXRoIHRoYXQgSSBnb3Q6DQo+IA0KPiBbICAgMjkuMzI4
NDg0XSB2aXJ0L3RkeDogbW9kdWxlIHZlcnNvbjogbWFqb3IgMSwgbWlub3IgNSwgaW50ZXJuYWwg
MA0KPiANCj4gDQoNCkxldCBtZSBjaGVjayBURFggbW9kdWxlIGd1eXMgb24gdGhpcyBhbmQgZ2V0
IGJhY2sgdG8geW91Lg0K

