Return-Path: <linux-kernel+bounces-334598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C758C97D974
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247511F22E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698C817DFF3;
	Fri, 20 Sep 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DB/iy8Re"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69180EBE
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726855052; cv=fail; b=lIor4bj8aMlxL4nUDhzsGPS6kJskc96yEc2MuZqlNWLpvg+T+OFqIMkPjqK19e55igdT51V5eFtW2Za7tL+j9g6cgdNdyDCw+/aMELmgfT5jNY7cIaMxeGm6mb354iy6Oy42PBywUnWiM487Gjwie3jG3u/yozEOdgVnWLibaoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726855052; c=relaxed/simple;
	bh=H+DPLL2es0+jhc9KSka0g9RSsKdJ0CVU+jhluM3KeIY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q9ACiGHFqDO06gEMzuiTvX/PR/8Mw+z0VTZs2p2KHmLyg1shM/x0T1IFibY/2+2kfI2LgflzZWKZj8bURb8Pz8irMeJnmgsjBvcU5a5NmYmcy3cttsI1UJl+Dc1nPAxP4vXQBC2BNIi4ZD36QsCDBsdo4J4xpP+3O12KoaJYFi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DB/iy8Re; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726855049; x=1758391049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H+DPLL2es0+jhc9KSka0g9RSsKdJ0CVU+jhluM3KeIY=;
  b=DB/iy8RefXeS3xNqrMWfHXmPaTOShts2fKctVLaX48Vp3AOdAMYsBpt4
   d3cVxk0XIeV+z1bTW2dS7vvHJTMnBBk8B4rKb3PX+IqMVixNmauk+Jtp+
   CqYRWEnzT7iJGdPiR3QBH3JY04iLlA47nHARdWb1EOzX4QDdGxXeD+GX+
   c+e2aZk1iUtIFDn0cNT+twIv02zRH5W35NmWWhNYug+Kk+F/QbTDAx8i5
   VXNaIGempnW47A9DxuRZ5xG9JbMWn3WuddF0mvKdhsdYJi0aRdT8mUY8I
   9yQI0LYl8zBzrVh0ylsh6qAtfnG/Oj0Yai6Lkv9GzWFgYvkEVdnEpyk5C
   g==;
X-CSE-ConnectionGUID: 7IkJbR+8SCGaato3Y4BsMQ==
X-CSE-MsgGUID: 12yT5s70RsSHvJoLuIrWFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="36445535"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="36445535"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 10:57:29 -0700
X-CSE-ConnectionGUID: YRHmAOK2TAu9vYIXHnHB+A==
X-CSE-MsgGUID: cj7C5zLtT7+M5fuWA5Fwrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="75172535"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2024 10:57:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 10:57:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 10:57:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 10:57:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 10:57:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLLvm78qQ0ciBoqw8C2LrJDUxBKfpknoAmvYCIR6kH5zohzYhCLZ/V/R9dR0++DAcKQeFk07oXve/gt2YYlkrOR8A1GQjO7ypjPnHQWJcDTv3Nqmz8gSb+oJMeQFjTtB9qSRB9vVRng0aq1ESO6JIHDJSy5EYueWutuBZb8oNh8xOl+9JvnJvz22G8rBHCiQexncuFwvpCDI3oiPtouIo0EGtaXSbNA+FxpdQ7YjK/8bj1MgOqOdeutY6CfG9NPgb+hqUM0kaKdvmcu2eBZCfQjJXwwIp/FeFTt7gGS7jsqnCAyhSaor/u/eJeK0Xiui5zx2NxFTWyseWV8RTVMRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QNH/RIdejUiS5UEXOjfPLIjuOJXXzk36RjBHqjH+zM=;
 b=U9NdGcVJKPpvagk3CCauluPnnTv6HcZ//dvWDFjD1D502uco9uDvYlzhdVWcm19TU12cIH0iMf0OF5ogASe/4YyHNViF4CDN9I2s5b9jScp/HilnnoRi1WWv/BJeNedDiAK6E/vHrikbjIRDCNFsnyavOi3nKF+QEPIwKBQgRXTHnnYTwKDqrrMZp6MKaV3dvzVce7Ryvp0iZJObx/SKRGvXz30/qkTmqBQOsFBGpK91Dv6DhJAfpmryUvkNLtLJ1fFmLR+UqPNySvSYDOfLm5p1uZ0fzsqGy4E5MXXSG1qxb2dVDYy5PrKBAhZhnk26hkXUqpV20sXAw9ZwuR8wLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA1PR11MB7728.namprd11.prod.outlook.com (2603:10b6:208:3f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 17:57:24 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Fri, 20 Sep 2024
 17:57:23 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: Yosry Ahmed <yosryahmed@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa+lo8ysIDIejPvUy4b6yFKhIRqLI+1o8AgCEmqqCAAI5WI4AAezJw
Date: Fri, 20 Sep 2024 17:57:23 +0000
Message-ID: <SJ0PR11MB5678836189CB92C7D36372D3C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
	<CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com>
	<SJ0PR11MB567893E61CB522991ED1379EC96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <87ikuqvfkl.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ikuqvfkl.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA1PR11MB7728:EE_
x-ms-office365-filtering-correlation-id: c07391b2-4a9a-4726-1a43-08dcd99dae63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?LR2JpKeP/gRV+p5fkM/1dKasYMeeCqknH5A+3dxKYA3NHAwWc9mvzcP9eCyk?=
 =?us-ascii?Q?GkqHtHtt+ounkQfVJf4KiSo8kQ55ZclnDmXCQH5JiQwmE2hHy1UG7v4dUHDD?=
 =?us-ascii?Q?RWsjnoiL6LNNlfZglIQFHVCOMYhkr9PS/wg7hFfq5XLWvga3jm1yhC1fIDqs?=
 =?us-ascii?Q?CH8Zl8fmcYHR5d9+mbbIhUTr4PlflNtR3wg40phpvu3vuanzYrhof3mnJF74?=
 =?us-ascii?Q?gsvxP4v1ZC9wl82eweRsoYOlXfyZRTOfdRM5ZcqJjUGnmhYuCIxKpt9lfyjE?=
 =?us-ascii?Q?NgCogLDeKj3fnP0a4WwdpsKOO7jnyP0hK6d4ir1D29r2ntrM8tdRLiRLqE+P?=
 =?us-ascii?Q?/lG5/KGHuECkiILnhQExDK2KiPvCsJzQ2T4uDX61UrMQ9Bz4fHyCYeIqhMVb?=
 =?us-ascii?Q?svDMgHT4EYubRuQvsbmwjTvuuRyPDqOPlQDiY7MSJP3K/tpm/Nn2B29pxp3B?=
 =?us-ascii?Q?K14Ac13v0C2lZncIQrybHV67DOllJ6wY3LdPJCE+cijWcLz8fmlpd/C887ma?=
 =?us-ascii?Q?IkI4u9KOygnIGuTZf9B7St82lk9ILEmJdxTqyX9I14dJWXoJeo/IfozbXodj?=
 =?us-ascii?Q?8UlTx4uh1DEqisx2fKe505RIMfSXkWSVVnP68nTQCVVX7aiVQ2MHslNU/gIv?=
 =?us-ascii?Q?frrlZh2C4ZVAFgf7Ui4Ia9Ng+2qgbBuD5egkEa1ssDY3QML6s7F+Jv7+26Sv?=
 =?us-ascii?Q?c1nLcNMypmZr73SW9yy1w//oRDdZOP+K2aMseE0NwuYyubbDuEQY3hU6sHOT?=
 =?us-ascii?Q?ZBX84NsMVWYVMYi1pFWbaevj5pIyzh2o9C+3nSpxTudFXuARShyx31wMTR3Y?=
 =?us-ascii?Q?2bA/MehAhubK6rV/yAnaGGGeLyNj86tWf+TMsAty1jp5Bczk3DaY3uaV0WrL?=
 =?us-ascii?Q?GJXuGzkl0JWN+Lx1xmmIBzScxuVCbj4U+XFZXxS14sJrA36qGRd3RPXy3mmC?=
 =?us-ascii?Q?uBczwCOVCSKdSMxXVVDaVo8IXeaxodObPxaIwIBAOiZZ9QonM6SQgg0Ctrhn?=
 =?us-ascii?Q?Nwh2oR19Rhc1h1pRRizVmeluNgQjRAh25Y1FSbnQ5NKsiWJmc+qvL9LIimnY?=
 =?us-ascii?Q?CAPPID1vMenkcL/gi2VYkD0afZHRNrAIJb5WTkob+ADP/5+KgbWYvVfCwC1i?=
 =?us-ascii?Q?H7qS+CW7cdtW5FtCKq9utgey/x/N87Fk3Hw3BzoqvfX6QYb10WvQNpdCx1aA?=
 =?us-ascii?Q?nQD59E5jsYN+hfA6GS7Q1Aqm0MKZkrSZcReZwURNFnFMlLHp9f6iAreDP1Kk?=
 =?us-ascii?Q?axxyVsP42zToH6RixqGcpEuLcT48DwmY6BVgsjAj2bB7+YqU4s+How3jLYcV?=
 =?us-ascii?Q?OtgCeOeqPFSutJo0q2bbj9K0ch+M+UI7uBMVuY10yrN8o+XeTtX0DIRBPqHN?=
 =?us-ascii?Q?MC0pc2GNq8eAd1ClY+UhoMYbAQI4dgz8WsdGlBuF5l6QDuwbQQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lkXZl2VDdLaWUNofRvfN56rs5MRH/ziptLBX0XIGeXfPKN5e9sNM74A/Xvub?=
 =?us-ascii?Q?e9+9wGD2aeQ3+hsnt+q1FP+WHYL4UdoRORjPqcH2b4s2Rc3fbRDvISIL7GFQ?=
 =?us-ascii?Q?Ie9GuLts+nmXWQkSdbLACbjBbXPjzgTmEXFIr6s/LCyc9jW4xa4Z1nHte7dO?=
 =?us-ascii?Q?+P1C/LxNFqmqDcxR1EVjXZrbdeWri7UHqlhbEhpHkiLdGWvmMpnui0Y0CjiF?=
 =?us-ascii?Q?XVwfO3OzwJZ2ZbaroSNgmWfqLzShcglAWbZVeB/XMGuj69y+246nLVUi/CaJ?=
 =?us-ascii?Q?V+mVkOi0diL+1Fit1jS0KbFG5T7cj06foWobIfOdx515+FXdWhq+2M7qL7Aa?=
 =?us-ascii?Q?LkxrIXoPY1PHCINlrJxEBCh3At9G6BQEPMxZzZo/ONYdpjFRUpHGM/324dgW?=
 =?us-ascii?Q?6Yp8mjGMFAZcZEdiNcIlVbixGWazL7dmA4Hj4bCoLGzXRwBfbQAgVujKdVZm?=
 =?us-ascii?Q?QWTU8twwTupH7GIAJ8flS4FkIPZluP41/UPOX/7kjl5fOMnl3fkbLSLdwDqo?=
 =?us-ascii?Q?ipKAu2iYQgcSxky7NEwXqQuYByA3wF+hOXGgbTX5kHJ8ASDvCWFb3zjlaMcf?=
 =?us-ascii?Q?zlchsp6Z4HQef3CdEOZDnIS/Tkh8Dc4r9XhXbfFOMczbscLthkbdGR58o+9u?=
 =?us-ascii?Q?9jj7VjeVRdDTiJSkV/8c18FxeuVhGbw7+vKnMmjl1h5YFJDGeGENQdzPUFyh?=
 =?us-ascii?Q?textel/BJY+HlLqzMuaJ2noNCcST9345CdFweDAO2d796IcLC/hzjsHjBtIt?=
 =?us-ascii?Q?446ZWlwiKv0UUvzqsIexR9jELFS62U74oHUgm0fIT3xZvkhBhShY2YYEW/dv?=
 =?us-ascii?Q?OVfP+816Oy21uCXkURZmei1qMO3j2+00TOELHYeoLS7/2O/b7jfqIAR3zyi5?=
 =?us-ascii?Q?bW5KcFV5Vbi/zQ7dTeHk86LxbEhTwMrUrzk1qzTRGcS5uW2QhBzgbFCd2kdy?=
 =?us-ascii?Q?TzWgH+RvRMZ4LdeODKgRDbXuB/frUNL3iTSn1hrPdRLUHj0zJeYYTpTQX2MC?=
 =?us-ascii?Q?hjYlLv6I5Md/QiCqHViyYNn0v9ZvSlLfwCKpArL87+5GdSWqiSkO37NnxSBT?=
 =?us-ascii?Q?oAzHlR9i4hkZcg47ufysqHNac0lxo8xtMAkxlodn9vH6E0WRaVr4V/xHrXy1?=
 =?us-ascii?Q?4hdWwkcMryDXUbugeJrVz/+r91fIFoXPg8Gdwmjs7bH0KvqETf6PGQ/5qPWZ?=
 =?us-ascii?Q?Am2Uj+zDqmpPHOTomlbNa9Rzxw/L7P+shE5bng7m2jfPb4wV2aehtYC3LLYk?=
 =?us-ascii?Q?ltTHUJTMVIlNu5UiU+NeOt8UAiOGoDOZ1bAbn7AaaqttfiegJ2hd77lUVrqE?=
 =?us-ascii?Q?NvSC54zqnROM7DzJZ1eHpqoRzL0LDgosA7btLhFET5T4vfN8BUMNFeHfHi7m?=
 =?us-ascii?Q?9V2mFqd0ZNX9P7SHzQIyeyEytik9BsGiWSy3YCiDlulvob7giqjDktImoAg5?=
 =?us-ascii?Q?qgdikLE1+89Ts/TctsxiiO2KX3hIBm6et1+wwpMV8+F8SgzPqMpqi9rk0Qer?=
 =?us-ascii?Q?qeVqL3r4ZKCaik8zdvhN+e5g5nWi49WNuBQ77YRVFuvWlURxQIIAx+zb1uUR?=
 =?us-ascii?Q?M88TvxZ3kAVRSMHY2tjOaIiA0mKVeNfvvgw2JSHRZn0KfigaBCBiZnsoqY2I?=
 =?us-ascii?Q?zA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c07391b2-4a9a-4726-1a43-08dcd99dae63
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 17:57:23.8009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/Q4tuYyAFgROWZzWPiz8yib7Y5H8z0ZV6js3EFW1oUW81XXFdTtWcGJcugY2uN0HK7NZwxRAVEc5uWN0EWsXeBCqwF1T/409Y9faIol8Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7728
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Huang, Ying <ying.huang@intel.com>
> Sent: Friday, September 20, 2024 2:29 AM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>; linux-kernel@vger.kernel.org;
> linux-mm@kvack.org; hannes@cmpxchg.org; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> ryan.roberts@arm.com; 21cnbao@gmail.com; akpm@linux-foundation.org;
> Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
>=20
> "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com> writes:
>=20
> [snip]
>=20
> >
> > Thanks, these are good points. I ran this experiment with mm-unstable 9=
-
> 17-2024,
> > commit 248ba8004e76eb335d7e6079724c3ee89a011389.
> >
> > Data is based on average of 3 runs of the vm-scalability "usemem" test.
> >
> >  4G SSD backing zswap, each process sleeps before exiting
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  64KB mTHP (cgroup memory.high set to 60G, no swap limit):
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  CONFIG_THP_SWAP=3DY
> >  Sapphire Rapids server with 503 GiB RAM and 4G SSD swap backing device
> >  for zswap.
> >
> >  Experiment 1: Each process sleeps for 0 sec after allocating memory
> >  (usemem --init-time -w -O --sleep 0 -n 70 1g):
> >
> >  ----------------------------------------------------------------------=
---------
> >                     mm-unstable 9-17-2024           zswap-mTHP v6     C=
hange wrt
> >                                  Baseline                              =
 Baseline
> >                                  "before"                 "after"      =
(sleep 0)
> >  ----------------------------------------------------------------------=
---------
> >  ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd=
 deflate-
> >                                       iaa                     iaa      =
      iaa
> >  ----------------------------------------------------------------------=
---------
> >  Throughput (KB/s)   296,684      274,207     359,722     390,162    21=
%     42%
> >  sys time (sec)        92.67        93.33      251.06      237.56  -171=
%   -155%
> >  memcg_high            3,503        3,769      44,425      27,154
> >  memcg_swap_fail           0            0     115,814     141,936
> >  pswpin                   17            0           0           0
> >  pswpout             370,853      393,232           0           0
> >  zswpin                  693          123         666         667
> >  zswpout               1,484          123   1,366,680   1,199,645
> >  thp_swpout                0            0           0           0
> >  thp_swpout_               0            0           0           0
> >   fallback
> >  pgmajfault            3,384        2,951       3,656       3,468
> >  ZSWPOUT-64kB            n/a          n/a      82,940      73,121
> >  SWPOUT-64kB          23,178       24,577           0           0
> >  ----------------------------------------------------------------------=
---------
> >
> >
> >  Experiment 2: Each process sleeps for 10 sec after allocating memory
> >  (usemem --init-time -w -O --sleep 10 -n 70 1g):
> >
> >  ----------------------------------------------------------------------=
---------
> >                     mm-unstable 9-17-2024           zswap-mTHP v6     C=
hange wrt
> >                                  Baseline                              =
 Baseline
> >                                  "before"                 "after"     (=
sleep 10)
> >  ----------------------------------------------------------------------=
---------
> >  ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd=
 deflate-
> >                                       iaa                     iaa      =
      iaa
> >  ----------------------------------------------------------------------=
---------
> >  Throughput (KB/s)    86,744       93,730     157,528     113,110    82=
%     21%
> >  sys time (sec)       308.87       315.29      477.55      629.98   -55=
%   -100%
>=20
> What is the elapsed time for all cases?

Sure, listed below is the data for both experiments with elapsed time in ro=
w 2:

 4G SSD backing zswap, each process sleeps before exiting
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

 64KB mTHP (cgroup memory.high set to 60G, no swap limit):
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
 CONFIG_THP_SWAP=3DY
 Sapphire Rapids server with 503 GiB RAM and 4G SSD swap backing device
 for zswap.

 Experiment 1: Each process sleeps for 0 sec after allocating memory
 (usemem --init-time -w -O --sleep 0 -n 70 1g):

 --------------------------------------------------------------------------=
-----
                    mm-unstable 9-17-2024           zswap-mTHP v6     Chang=
e wrt
                                 Baseline                               Bas=
eline
                                 "before"                 "after"      (sle=
ep 0)
 --------------------------------------------------------------------------=
-----
 ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd def=
late-
                                      iaa                     iaa          =
  iaa
 --------------------------------------------------------------------------=
-----
 Throughput (KB/s)   296,684      274,207     359,722     390,162    21%   =
  42%
 elapsed time (sec)     4.91         4.80        4.42        5.08    10%   =
  -6%
 sys time (sec)        92.67        93.33      251.06      237.56  -171%   =
-155%
 memcg_high            3,503        3,769      44,425      27,154
 memcg_swap_fail           0            0     115,814     141,936
 pswpin                   17            0           0           0
 pswpout             370,853      393,232           0           0
 zswpin                  693          123         666         667
 zswpout               1,484          123   1,366,680   1,199,645
 thp_swpout                0            0           0           0
 thp_swpout_               0            0           0           0
  fallback
 pgmajfault            3,384        2,951       3,656       3,468
 ZSWPOUT-64kB            n/a          n/a      82,940      73,121
 SWPOUT-64kB          23,178       24,577           0           0
 --------------------------------------------------------------------------=
-----


 Experiment 2: Each process sleeps for 10 sec after allocating memory
 (usemem --init-time -w -O --sleep 10 -n 70 1g):

 --------------------------------------------------------------------------=
-----
                    mm-unstable 9-17-2024           zswap-mTHP v6     Chang=
e wrt
                                 Baseline                               Bas=
eline
                                 "before"                 "after"     (slee=
p 10)
 --------------------------------------------------------------------------=
-----
 ZSWAP compressor       zstd     deflate-        zstd    deflate-  zstd def=
late-
                                      iaa                     iaa          =
  iaa
 --------------------------------------------------------------------------=
-----
 Throughput (KB/s)    86,744       93,730     157,528     113,110    82%   =
  21%
 elapsed time (sec)    30.24        31.73       33.39       32.50   -10%   =
  -2%
 sys time (sec)       308.87       315.29      477.55      629.98   -55%   =
-100%
 memcg_high          169,450      188,700     143,691     177,887
 memcg_swap_fail  10,131,859    9,740,646  18,738,715  19,528,110
 pswpin                   17           16           0           0
 pswpout           1,154,779    1,210,485           0           0
 zswpin                  711          659       1,016         736
 zswpout              70,212       50,128   1,235,560   1,275,917
 thp_swpout                0            0           0           0
 thp_swpout_               0            0           0           0
  fallback
 pgmajfault            6,120        6,291       8,789       6,474
 ZSWPOUT-64kB            n/a          n/a      67,587      68,912
 SWPOUT-64kB          72,174       75,655           0           0
 --------------------------------------------------------------------------=
-----


>=20
> >  memcg_high          169,450      188,700     143,691     177,887
> >  memcg_swap_fail  10,131,859    9,740,646  18,738,715  19,528,110
> >  pswpin                   17           16           0           0
> >  pswpout           1,154,779    1,210,485           0           0
> >  zswpin                  711          659       1,016         736
> >  zswpout              70,212       50,128   1,235,560   1,275,917
> >  thp_swpout                0            0           0           0
> >  thp_swpout_               0            0           0           0
> >   fallback
> >  pgmajfault            6,120        6,291       8,789       6,474
> >  ZSWPOUT-64kB            n/a          n/a      67,587      68,912
> >  SWPOUT-64kB          72,174       75,655           0           0
> >  ----------------------------------------------------------------------=
---------
> >
> >
> > Conclusions from the experiments:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1) zswap-mTHP improves throughput as compared to the baseline, for zstd
> and
> >    deflate-iaa.
> >
> > 2) Yosry's theory is proved correct in the 4G constrained swap setup.
> >    When the processes are constrained to sleep 10 sec after allocating
> >    memory, thereby keeping the memory allocated longer, the "Baseline" =
or
> >    "before" with mTHP getting stored in SSD shows a degradation of 71% =
in
> >    throughput and 238% in sys time, as compared to the "Baseline" with
>=20
> Higher sys time may come from compression with CPU vs. disk writing?
>=20

Here, I was comparing the "before" sys times between "sleep 10" and
"sleep 0" experiments where mTHP get stored to SSD. I was trying to
understand the increase in "before" sys time in "sleep 10", and my
analysis was this could be due to the following cycle of events:

  memory remaining allocated longer, any reclaimed memory per process
  is mostly cold memory and is not paged back in (17 pswpin for zstd),
  swap slots are not released,
  swap slot allocation failures,
  folios in the reclaim list returned to being active,
  more swapout activity in "before"/"sleep 10" (372,337 zstd) as
   compared to "before"/"sleep 0" (1,224,991 zstd),
  more sys time in "before"/"sleep 10" as compared to "before"/"sleep 0".

IOW, my takeaway from only the "before" experiments with sleep 10
vs. sleep 0 was the higher swapout activity resulting in increased
sys time.

The zswap-mTHP "after" experiments don't show significantly higher
successful swapout activity between "sleep 10" vs. "sleep 0". This is
not to say that the above cycle of events does not occur here as well,
as indicated by the higher memcg_swap_fail counts, signifying
attempted swapouts.

However, the zswap-mTHP "after" sys time increase going from
"sleep 0" to "sleep 10" is not as bad as that for "before":


   "before" =3D 4G SSD mTHP
   "after" =3D zswap-mTHP

 -------------------------------------------------------------------------
                           mm-unstable 9-17-2024             zswap-mTHP v6=
=20
                                        Baseline
                                        "before"                   "after"=
=20
 -------------------------------------------------------------------------
 ZSWAP compressor              zstd  deflate-iaa       zstd    deflate-iaa
 -------------------------------------------------------------------------
 "sleep 0"  sys time (sec)    92.67        93.33     251.06         237.56
 "sleep 10" sys time (sec)   308.87       315.29     477.55         629.98
 -------------------------------------------------------------------------
 "sleep 10" sys time          -233%        -238%       -90%          -165%
  vs. "sleep 0"
 -------------------------------------------------------------------------


> >    sleep 0 that benefits from serialization of disk IO not allowing all
> >    processes to allocate memory at the same time.
> >
> > 3) In the 4G SSD "sleep 0" case, zswap-mTHP shows an increase in sys ti=
me
> >    due to the cgroup charging and consequently higher memcg.high breach=
es
> >    and swapout activity.
> >
> >    However, the "sleep 10" case's sys time seems to degrade less, and t=
he
> >    memcg.high breaches and swapout activity are almost similar between
> the
> >    before/after (confirming Yosry's hypothesis). Further, the
> >    memcg_swap_fail activity in the "after" scenario is almost 2X that o=
f
> >    the "before". This indicates failure to obtain swap offsets, resulti=
ng
> >    in the folio remaining active in memory.
> >
> >    I tried to better understand this through the 64k mTHP swpout_fallba=
ck
> >    stats in the "sleep 10" zstd experiments:
> >
> >    --------------------------------------------------------------
> >                                            "before"       "after"
> >    --------------------------------------------------------------
> >    64k mTHP swpout_fallback                 627,308       897,407
> >    64k folio swapouts                        72,174        67,587
> >    [p|z]swpout events due to 64k mTHP     1,154,779     1,081,397
> >    4k folio swapouts                         70,212       154,163
> >    --------------------------------------------------------------
> >
> >    The data indicates a higher # of 64k folio swpout_fallback with
> >    zswap-mTHP, that co-relates with the higher memcg_swap_fail counts a=
nd
> >    4k folio swapouts with zswap-mTHP. Could the root-cause be
> fragmentation
> >    of the swap space due to zswap swapout being faster than SSD swapout=
?
> >
>=20
> [snip]
>=20
> --
> Best Regards,
> Huang, Ying

