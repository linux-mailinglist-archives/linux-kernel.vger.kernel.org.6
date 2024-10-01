Return-Path: <linux-kernel+bounces-346427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDCC98C4A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1F8286F96
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EB51CC170;
	Tue,  1 Oct 2024 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdzIBpds"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C921CC168
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804055; cv=fail; b=V/vPE6Q6XSQbcMjvFSOFIb1Zmff6AVrloLFabVHK8ksoiDys7EczbNoouulBzGLfo7UA4yycdiqv8p7974nvJu/O9AoFZJ1uNan02+a0RSOtWE5vZlpGyNfHWqc2zu82YkzI9FzVadQfQeGYbTMBTDKPmiJF3tMjSdq2bqaXTgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804055; c=relaxed/simple;
	bh=TZejwDYbIS+aeL9Zirdr0mNEBXLEGVAoMwzGeMipTuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XQpHECOYuwSfLwTK3kiudhbfw7uCBA0l92lAWfFQsiE/M22vEANkfoOI0m3qR/VjHnPDeC/rpbv18gM8c1TGtHh/TYP6iMOOIs+AttoHSYw3MH9F8ELYGj/NEe0k0kj58ytPwQAJGTAPUPGsppO3O1qq8bsb5133HexEKZreeVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdzIBpds; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727804053; x=1759340053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TZejwDYbIS+aeL9Zirdr0mNEBXLEGVAoMwzGeMipTuU=;
  b=PdzIBpdsyNbegNmOHvv5+yfeLpAeHoe64DYNHluFm6dRGHx2gQX039aA
   JsHcT8qbZgpgO6gyyy4fRTWoK7ZhlK8jLUfVpgshdAUEXiPDHNgos4FvA
   jkFjvb6oMfob1MVag3z958lg9gXfiOAaYynu7h7N9TnrWR2V302Jw25Lg
   c0TNeMzAGeletga62LS6P87KGPVAU6A/nVKGVoGq/RGbotYbq+7aVKwHb
   FUBzoazvhn8fojzAFdKa7rulhsh+5aIaqxAyipCrwHBqOE7PmalXMRnAz
   fvpkdJCuuhs9eyysUySGZ7PcyS8IXR8OqOFyYxlNWHq4ekqhcsIkNFAUr
   g==;
X-CSE-ConnectionGUID: kEw6NHUPTAeYh54sXvvYXQ==
X-CSE-MsgGUID: dAloBwyaQ7+Glqxs/kydYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="44479566"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="44479566"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:34:12 -0700
X-CSE-ConnectionGUID: 2Ut4jfYKTvWHU1Bjiqyaeg==
X-CSE-MsgGUID: WpwC2AGHQLqnXOXuMO5vbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="78156339"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 10:34:12 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:34:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:34:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:34:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 10:34:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 10:34:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxvZDE0a3g5z1MwtP7aS72ux/WXCpuRF9NbFAag2yu6ondOBToRfElAp9VjM7+i2gVpZ4+K9NkL8DvzAho9NVgGQeoN4zyuFzG2PxXdJ9nqIYZzdRAvesTtNkGwfzzI7Oc8UBtZlZo9F0f0U3xF0rYpDIEgQbDOsgC7jHig9cWDhoL8/V19NE960EbCiwNL4r8NG2+Fl0yolHzLlOS6CzDA3d7ZuFWihW5ZXcAx7tdfMgowK3or/hggHArxfYTbJLCvrWgv6TaQH6tVvBVLzd7m6TA8ZJayRKn+G9Bn33AOM0TtzVq5GU+GFibhQ/r0VQTIoxh7UFzyki9csPIIfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PlGn/PqLwkjPqu1Rretn3fDZ9ZNvMXXYyYh2VZs6ZA=;
 b=uTYUbJ0exKV4hHZJR9oucV+loSBJqXNAyyGYcPwRAJRq7Dft0dgW0Evf8Fy4hX/EdfjUkhGnsVhIi898R/NxRyfgggo7BBGFGOz3mBPAFxw8WMHKX+AjNLc9KzA6Pqqh6h0M2vcrkKpK68+5S0kijauSsKu8fe2IzPpAARiujyqG+vMHjlRJXMYssV6Z7XE/FZCzzJxghdFp1WuTY1B8p98JAdZ+zUSE3532K/sMbZj2EgH27I9Pm6Fbnpi0/ESmW4Eo0PVyPOZ15iBXuVI790pcRWdETE+SmW1nso2QgDMsFpDfhvKxXaLN81A1gSkQMeK8N9Hb66h3x/ZLmPTi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SN7PR11MB7975.namprd11.prod.outlook.com (2603:10b6:806:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 17:34:08 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:34:08 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "yosryahmed@google.com"
	<yosryahmed@google.com>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"willy@infradead.org" <willy@infradead.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v10 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Topic: [PATCH v10 6/7] mm: zswap: Support large folios in
 zswap_store().
Thread-Index: AQHbE8NS/mzK7ddAdUGteugGSqw7kLJxvZiAgABpsIA=
Date: Tue, 1 Oct 2024 17:34:08 +0000
Message-ID: <SJ0PR11MB5678A8B0774E6742AD68F8A1C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
 <20241001053222.6944-7-kanchana.p.sridhar@intel.com>
 <20241001111045.GA1003400@cmpxchg.org>
In-Reply-To: <20241001111045.GA1003400@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SN7PR11MB7975:EE_
x-ms-office365-filtering-correlation-id: 51558153-75a2-4ad6-7d97-08dce23f4176
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mYS3Q3Kr2HQlVNEU6itHSOACbAsiJA3/fck8qnR2ooeO6YTySTGy3jIqI+Cw?=
 =?us-ascii?Q?tmOnWAg7kgyU+f3g1vYtL2uWTEjSAPXBEBBAD+BtgyEYtGmflIEcpGCYBDne?=
 =?us-ascii?Q?n8XhhDfUf8/SNzmcs+hUEuBuxFGgzt7jh2V0esHdKmIblfAH338dW8p+GEKW?=
 =?us-ascii?Q?k0bTLtQO5O3ZjbwiMvVrvESBhXrrl0+KID0cEpG89q1v0aM4I3+G9kt7R5Gq?=
 =?us-ascii?Q?8DJGcRcXaxXDDgQJerwXfjuP6NxDuyaBBs+jZquNf1JGzx0nrL1oIe/AxZll?=
 =?us-ascii?Q?vyajNGOs+0tQGmDlBUfIX8AyHLNbOhaS5APRfmegqsAbFqwNMv5EPwgzQk2N?=
 =?us-ascii?Q?xOMXT7npf4Kus03NkStOAKMd9H/e01HZ+cU7U8km1k5Yg/PMiPp927AxEB2Z?=
 =?us-ascii?Q?fWUr6pJBgdb6Kj8k29GmMYdCbybEMMUlg83/Pl8npAGLATVhd35GysPJaCHi?=
 =?us-ascii?Q?xBCVmUh2lnNcYPAcjfQ580Uw9NHokPfR3nZsE9reC2AedFSVrgOnxh6nW5/c?=
 =?us-ascii?Q?LZrYyNLVYoBr5iJqqZMXZ/88opCU0/FLe68iUF1U8NqzhmTUCClbLOmvCOUs?=
 =?us-ascii?Q?eRFxgtCRNbX5cJ1xYuz2rqcYbvkzPKiiSkHvuRFcwQr5uHfYk4FsTFY0Y3GI?=
 =?us-ascii?Q?Ssl6j1fg+aRY4iC/+3KctgkI9Y7H6pt1d7ttUJlPIqprCQalfIh1SFqdtr5z?=
 =?us-ascii?Q?jO2AOpnxH2q1KRGHB/2JxD1VgkDOzzPs3/0XpvmEjEctG+ns2VkybpmjRT0n?=
 =?us-ascii?Q?852ursqfTv4nDYtAmmXJz1aRSS7s3wm+eASbVcQZUx4Kt3TOZ71hCpgKwiXn?=
 =?us-ascii?Q?mVDIzMF70GPLpD0gLAp5CmkiL8qzUd9I5fppf0HKheRfDXckBM8Zu1zwuZ7w?=
 =?us-ascii?Q?3/GR/upykMZ2ucoJIn5FR60md/thMxdkVJu+pHqxZwaTv68wCm5Rho1v104y?=
 =?us-ascii?Q?zBlyf87SaWh2v6d3IQ8hZD/bIL5TQt7iQ5buPRB7hRL+xE96weZoCSyKJZd9?=
 =?us-ascii?Q?4NfDpG7O00enMCep8pASVcSxucPEui1sDyT7yMeWD7RlzBz5F5sNoBoC6sJ5?=
 =?us-ascii?Q?9RG8kdOdi/lNHnU2Mxk0YNeoElEIRQKajQtZ3Euc58eFTkG5WlW5lO03q39Q?=
 =?us-ascii?Q?XvSYDFoySz8DAH1k+s6iPFJAjzcER0jBsKdpaILaJlJhpO2kwq6+jkwlv2XT?=
 =?us-ascii?Q?4k9uJ5yZHv5b5pXb0keuh2Fpy08oXOaeSHiotctIbhtoFWEa0Oec6/7jLg/a?=
 =?us-ascii?Q?Fn8k5ZfYFo22d1HpVWtDxGRqHjXqki3BoPKREPFm4DUUxj988lrmN7f8nQdS?=
 =?us-ascii?Q?FGvma0Bm8wd1x1ygPXapvVQ6+jYnVyB/R8AotY677EEivGPZwdMaAtscLIHZ?=
 =?us-ascii?Q?wUL4vTY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gWjr2ql/gD5HmjSHWz8/eu5D9LCBrnt6GaetkBmgMSES9S7yk7rWNoKPVjn2?=
 =?us-ascii?Q?FGHuAYnf65WlKav7V2gY6Penlnmt5nDlFW58BEkX94aDju956ctIBSwnBmFn?=
 =?us-ascii?Q?b4Jkq21RE1mC4KCIhoagZZFTipNLFvB3m2BFEmTuAC50IUOi089/2zTaczxt?=
 =?us-ascii?Q?hpUuRN3TlsbgLzzwBJuHf5ghZCtUKjehUpI+khJewctbk7ccg76GQFlaSjag?=
 =?us-ascii?Q?qs3eZoDX52Oety1Me1hVCj1uy9h+sr85x+QM7a21Mg5hvNNRDGR4XyHxpnue?=
 =?us-ascii?Q?KrMavr1ri4LlBt3nI2ExljlkbGEIg4kzN+/e7kUR5lRdJm7ux5HIhrjjK1dS?=
 =?us-ascii?Q?vnqQ1r5rqNn2qLF9Y/X6809GtTe43fZdtkGfR4bj+CyXZ4CPus1x1/8v/n/D?=
 =?us-ascii?Q?AVUGPRmm5jFjoKJ5zot86+inc3LWAkKY0S33NEAN5gLtqzJkGK1tZzorEome?=
 =?us-ascii?Q?ggpbvBYMGFLCumk4A/pTLTFiApT48uoJwFhEtGMZY2dqqgQDlDrFCIzmEEvR?=
 =?us-ascii?Q?EUUU8spBbx8KuxIPpN0/9st4VB+cRgBvXu+OST8U8EZXlvIRasQI1FTRdCZ+?=
 =?us-ascii?Q?ol+pyBKcHO+UUc/0N6gplcmQla2+DvMnoBhr7GmjRGTlVf/XY8au/WRj0lsb?=
 =?us-ascii?Q?/uLsD9Tr0LuM1la4PoqEe0wuLy/TuwwajwqDN5ngw9NDUMU6gl7HEiuBZLDn?=
 =?us-ascii?Q?pWt46MClg46oa6nQUuG/582Tim0PSHYUZ2GN8rDG5YdQQh7lGOgZKodiPk5o?=
 =?us-ascii?Q?ovgmAIdto8qis473TVCqWazs6EmRsde3Oe7dnL0ArqkEFGSMg4cbg3D4Ctxt?=
 =?us-ascii?Q?S7zgOR2tq8Ix3IOA5DDkXQJuLzvmDc9INedxQWHntMCE/gz5sa5k272eKgrD?=
 =?us-ascii?Q?BHO1K5pqpsATq3/j3t04vthylO44QHPdh4hS5bjbQzUbXE9bjui4uLpEq3Ho?=
 =?us-ascii?Q?VugPTGvl0OmmgRfR+AKZ7ECorU5m7laiVF4N4qVOYvMkOEluz7AkzTSB0dZu?=
 =?us-ascii?Q?PM5WI/D8Lt+ALXJh3mw88mIdu0h3AB5PQmxi56dSzUBmtqd57ry0TbFmw8Kp?=
 =?us-ascii?Q?jOo1eBJb3cO+jAfRTp//R3Sa6A7Bd76Hwt3XIye6RR1wd9iz8YFWLS9e7ua1?=
 =?us-ascii?Q?tdVTvEXn7C6/0jVxzbUCga3klUvtd3jWE1O6uk4UjqIjYPkLIiAu10V98cmO?=
 =?us-ascii?Q?X4yEaZhqXf13zrnl6dLToEGjx3n34Ql7Hx10AZAl2k7EaiTiuZy0Q+1IBDim?=
 =?us-ascii?Q?Xhp2Zt1l9Jflfa7eWZp1VbRFFTJAFTzOYtPbPFgRtPgqAJ+oBchAheUGdRe2?=
 =?us-ascii?Q?dZrzH/4u9f27uCcRTpMCg2q4wFbxjiRRB0NZ/2Xbdnf6GGgwSzyzVlnIE3hp?=
 =?us-ascii?Q?NozmQsdIbEv5rzjV/QOIXKtBkcUGw/DbPkAMnakbUCtFQVP8ccByhuD1PtJy?=
 =?us-ascii?Q?s7w0MvNR1yIlAZjEvGBKBa2v/SfHrrBSOUp874lnxvaNTH6iKBNAqqM4Huzb?=
 =?us-ascii?Q?Ha76YlsBsGSCo8l8uFb8hEgU0KtGYdCU5L9n0CJ3jGjiqSGIk2tNXxiDtoFe?=
 =?us-ascii?Q?u84f/7XM9Qy3nFYWbfrjL52UV8ErQWD1NYxgg1qEZ1sqcNXBniVvuRLKJ8ma?=
 =?us-ascii?Q?0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51558153-75a2-4ad6-7d97-08dce23f4176
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 17:34:08.8812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NEPLa30OKXZGH13jKYsFenxBY/tIAMANBsMf8MilDGujTtBTI09wr9ngmsjmAdu/K+cxPadAOXSSDTQchT5YCq48RYragWmPel0KrHMke2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7975
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Johannes Weiner <hannes@cmpxchg.org>
> Sent: Tuesday, October 1, 2024 4:11 AM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> yosryahmed@google.com; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> shakeel.butt@linux.dev; ryan.roberts@arm.com; Huang, Ying
> <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-foundation.org;
> willy@infradead.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v10 6/7] mm: zswap: Support large folios in
> zswap_store().
>=20
> On Mon, Sep 30, 2024 at 10:32:21PM -0700, Kanchana P Sridhar wrote:
> > zswap_store() will store large folios by compressing them page by page.
> >
> > This patch provides a sequential implementation of storing a large foli=
o
> > in zswap_store() by iterating through each page in the folio to compres=
s
> > and store it in the zswap zpool.
> >
> > zswap_store() calls the newly added zswap_store_page() function for eac=
h
> > page in the folio. zswap_store_page() handles compressing and storing e=
ach
> > page.
> >
> > We check the global and per-cgroup limits once at the beginning of
> > zswap_store(), and only check that the limit is not reached yet. This i=
s
> > racy and inaccurate, but it should be sufficient for now. We also obtai=
n
> > initial references to the relevant objcg and pool to guarantee that
> > subsequent references can be acquired by zswap_store_page(). A new
> function
> > zswap_pool_get() is added to facilitate this.
> >
> > If these one-time checks pass, we compress the pages of the folio, whil=
e
> > maintaining a running count of compressed bytes for all the folio's pag=
es.
> > If all pages are successfully compressed and stored, we do the cgroup
> > zswap charging with the total compressed bytes, and batch update the
> > zswap_stored_pages atomic/zswpout event stats with folio_nr_pages()
> once,
> > before returning from zswap_store().
> >
> > If an error is encountered during the store of any page in the folio,
> > all pages in that folio currently stored in zswap will be invalidated.
> > Thus, a folio is either entirely stored in zswap, or entirely not store=
d
> > in zswap.
> >
> > The most important value provided by this patch is it enables swapping =
out
> > large folios to zswap without splitting them. Furthermore, it batches s=
ome
> > operations while doing so (cgroup charging, stats updates).
> >
> > This patch also forms the basis for building compress batching of pages=
 in
> > a large folio in zswap_store() by compressing up to say, 8 pages of the
> > folio in parallel in hardware using the Intel In-Memory Analytics
> > Accelerator (Intel IAA).
> >
> > This change reuses and adapts the functionality in Ryan Roberts' RFC
> > patch [1]:
> >
> >   "[RFC,v1] mm: zswap: Store large folios without splitting"
> >
> >   [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-
> ryan.roberts@arm.com/T/#u
> >
> > Co-developed-by: Ryan Roberts
>=20
> I would change that to
>=20
> Originally-by: Ryan Roberts <ryan.roberts@arm.com>
>=20
> > Signed-off-by:
>=20
> and drop this for now.

Hi Andrew,

Just wanted to check if you can make the change from
"Co-developed-by/Signed-off-by:" to "Originally-by:" to acknowledge
Ryan Roberts' contribution, when this patch is included in mm-unstable?

Please do let me know if it is simpler if I submit a v11 for just this
specific patch or for the entire series with this change. I will proceed
based on your recommendation.

Thanks,
Kanchana

>=20
> > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
>=20
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

