Return-Path: <linux-kernel+bounces-408387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 503C69C7E27
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0A5B24FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D5E18C01F;
	Wed, 13 Nov 2024 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ze47lKjY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D033918BC1D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731536018; cv=fail; b=Exlb2PBIh534tV17jtJgeucQKsrId9tgHLWr0aleubm7FcMSFMzE5Cpzz8r+AUP1G2PzGE2Wy9fg8YO8yM/qPYFJ2qklyp9nkcyDvAQUgbLpH9qn3JMY4zlWWlXIyvIqwRjT8wDsz3dd0/Vk5A01j+bLjnRSaSY0WhBOAtGyneo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731536018; c=relaxed/simple;
	bh=vJZmddrdZbzYoAs4HBfNQCS2kXLQr/nP77hsQtj7ZFA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WOrrpDIGH+12acrwuWF4eXw/DKzsm3hxND3GbRflg8doPi6VBWpGQD3J950m09g41M7eyJYEZpE/UKc6TNwFaiJJzkRfw9BT2TRWWcK7E2xYxVq/k9iwOZzu4w0lXq6XCiodqpPDt+paHugBaFJDycTKjx86JQL/jcVOA23Qlhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ze47lKjY; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731536017; x=1763072017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vJZmddrdZbzYoAs4HBfNQCS2kXLQr/nP77hsQtj7ZFA=;
  b=Ze47lKjYUMqcs86cdVx7z6AtuRx7UE2vjExrfmcMgcB1CnVc7XWLhDHS
   7Osk0m8SxMDlxGm4bbWfx+k7DtBRne9sbdmpIE8EoKHNQb+vYIw2r7oXV
   UGdsHgsBNR2l6X9ZFngIoDV7WAFdtC22lT42zvD8R9MWx+awhPoQwQbhX
   h9I6bQlHO5dNP/y1hbZdwAODHe4n5XEQVMJoQPLGvdiqfNGisshSgvCAT
   O7fLoOl1ZOV3KUJBVJ+XKmbX/W/1w+XyL29O1nqsEtr7IMavNFxC7Vag4
   qOPyCvPU+C47LApzDR99C8NF50gNPgOrVg8B55dKELmLyVLCm31e6Dtn4
   w==;
X-CSE-ConnectionGUID: +oVUR38EQKOj0nkLe3MWyg==
X-CSE-MsgGUID: taVkLTS3TxevX62Ybpcj6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31424675"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31424675"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 14:13:36 -0800
X-CSE-ConnectionGUID: VKCNdSu9QhSE5BGORc6ysQ==
X-CSE-MsgGUID: NK8QWItnR46lM0/co5Am7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="118944681"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 14:13:36 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 14:13:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 14:13:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 14:13:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMFNpmsp3MMvRaQF8KY4UXKKcqR05HuHPqYckvaobagoEbVN9OXVYIIXXKFIrq+s4putzI/9KmS9PHGLr4XGCYlrrFlGy+O23+/vz7IWX3u7yCeqcZLcvmSvrYz8qS0kWe6cP99xm8lreYgFcCLjRtb3FNf/65IRXfYjxwrFga2Ta9cG4bLe0YyMRgiiRBFlv/lJx96iR3Gxj71/mMlh/YkcWvf+Zj0M9OiWS13PxjxxmlB7e1aAg8BlZuLtCKFUVUsdtPakW8omJjtdYAhDX1kWLTUgrFLSTIT6ccaNosJfGARXeWqGeI4fjJCDE3hRXDOPp9MJGGnmcHGVK7/ZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vvp6TkyVPEXdjvVh7YSX35ckrvvoss5MPvtt3f+R504=;
 b=J8IydW9JuRKYFkVvncrRadx9HEzxOpyExGMiyzi7iBjumlkwkPRB7pboY3/9Q/zCw+UwDmJ8uDjNjquO8mIhyMRRN+6Pcw05qqGPk4GvF5K5s6RF9jacE1aoSm+pUqF5vuIhV8zHdfyxrfIKlsw9R7aAUEKUQdv1v0JC80HflIAajTUMH8b4+GkdRQeH4ASWaTn1VFPgrUd8OPILbQHrJpx9a/M2oJGTKEynkask9rVIdKq9LOTMJsGh/CeLdDVorTHQx4qifnUaKZNCBJ56/Lo7F88VRksqN6fJz+/SuEpuD234SWtgRxKThji/fWpVq5Mr4kC7/8V7qsmjQdzBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SA1PR11MB8279.namprd11.prod.outlook.com (2603:10b6:806:25c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 22:13:32 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 22:13:32 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: Yosry Ahmed <yosryahmed@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Topic: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Index: AQHbNYxgo97ShYNp0k+eAlG8E2BdYbK0sGWAgAAC9UCAAAo2gIAAydcggAAz64CAAATjwA==
Date: Wed, 13 Nov 2024 22:13:32 +0000
Message-ID: <SJ0PR11MB5678C24CDF6AA4FED306FC71C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241113213007.GB1564047@cmpxchg.org>
In-Reply-To: <20241113213007.GB1564047@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SA1PR11MB8279:EE_
x-ms-office365-filtering-correlation-id: b69bed4c-4f14-4835-cf8b-08dd043068e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3TM31KWPKFpXIwLgNFYjckhjQLGVZu8Dr3CLwymPnD/aj6XaZC50t0BTYJxI?=
 =?us-ascii?Q?kd7lRlHw3wOgLTGVSxgo2TEtVEPX08Z3fCtt7EZzYiPba6XNZRiCd62Ir1US?=
 =?us-ascii?Q?d60UjMlXfoQWZnn3JIhQJAcF9rIs26Ykqq2TmD6+V2d0kjP086ePx9jlU2QB?=
 =?us-ascii?Q?86oTHeKM78oQStqB0Dy58ulH9FXJpJgxPW7CBYSviEs7D7mDW4TgU6rS4UEw?=
 =?us-ascii?Q?fJ6bNz4qBftmpSqhQL5W0ZkClFC+KUxkRUTWTlMrNJcd1UcVdTvGXVJeURkC?=
 =?us-ascii?Q?4nt3FMV7yYyMr177+7GafQh05hvy7D+LGjRgSvrsTJIj9qY6uf6/VXp0Tbq3?=
 =?us-ascii?Q?YASnt0WqntEZ6pldV+Mx6m2jsdjn9SnzuJ/Ei+SKbCwMAoSLzlaFI4BIpcMM?=
 =?us-ascii?Q?aPn6XxvbxYDFIapMyLvfIaZu15+nP5ZA0Li7ZUEStljT9+oKzHT1g6Cfgh1l?=
 =?us-ascii?Q?dDWPLnBa0p+QnhmrHfqED9GKbC/sc2xXYI6w8mFSAwUHN8bZACJiy8d5sDvn?=
 =?us-ascii?Q?HKe4x/+wOFBQKR9GhiqMx7AzQPxmOxJ3aVCP7jxxKgU8+nIOI1x5fdl6tBkE?=
 =?us-ascii?Q?BtNDrReNz9/qBU4YHf1wQ9ToIK4Ksx2POFV830D258rQ5A/ttW+inpYzhF8P?=
 =?us-ascii?Q?bcFQc0y+T9aZmNbz7xYOVcNu/CE2CUsrIri3WtFLVReCowEI0G6+2dRc3BUR?=
 =?us-ascii?Q?m0qfFvSjeYV3GWz+ytgFiKhZopKytmPhSG+4vypGEbgKJezZZCcaMbSW23nZ?=
 =?us-ascii?Q?t70QWO4mDRv57lRD6eWy1Y4D0yE3QjtC9HX3wOAgIkv9t//vf+kYYleTkp9F?=
 =?us-ascii?Q?CMMfAe43Tq0Hk7xuNAiWiervw4NT55a/cpVsqgCe/WckQ57PDVmBheEuI1P3?=
 =?us-ascii?Q?NVETp34Ym74dCep2XvHJz6EFcvGb0VuGxduld1QrykEkdrwdfND6+pKNZI7U?=
 =?us-ascii?Q?JknYO3CMPNWdfSo63lcJhhQZ+h7W73sLX8cggmjs3hk6cM8V0rY34lL84Aho?=
 =?us-ascii?Q?qqQve43SF/6QzqIaA7PgmOM2mwyuYC763v3gysIsORM5LGAZa/JxUumKTYyy?=
 =?us-ascii?Q?aXdWaxIPRjr9pxOC+ntkJ8J7dHAvZ21ba2EiexiPEGHdtcrHLwPHsUXb4a7S?=
 =?us-ascii?Q?6Q2L74x9QU6mmAAKIG2558r4hPQvOa1clnnGRnnR2Gd5icDKnN1/T9sgibTU?=
 =?us-ascii?Q?27LMM59yKi6aWtlCkqpS3MvYNd8PNuEvix+46y57YKT5jPX5lmuj4S+ZoTj+?=
 =?us-ascii?Q?cApzh35OstfcjVX3zNktWr8ALBUlq1vD2tsbPhuiDBRG+tacBUuGxv3mw0TX?=
 =?us-ascii?Q?d4WPxjMPY/R//VmbmeAf9H1cPXtMxyP6+V4yIsklsO8wzrzfT4T1RSZHbpK0?=
 =?us-ascii?Q?wAQrh3g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7mfa03mwavLwFRP3YqdejYyf8nd/ftB3ALWbW3dbB8Wj83IqbSf6U9Vpx1Sl?=
 =?us-ascii?Q?2RmTGj5lCvOc0+nm4b2lBb6BpJmgHa3o+3FfbrTk9hnb38L32QaRtJko2/3U?=
 =?us-ascii?Q?5Ouky2nDufdSGDTWFZymT0RpnODVrYSrSCzqGOJPEzmSNfMn7ehURJU4pNNs?=
 =?us-ascii?Q?w4R7uJHKwbmSLwXEFHUKKtZY7SaHBc4rCjm/YMid16C1+yySRnltPU4ZfXPn?=
 =?us-ascii?Q?uenOwuVECAKqlX+Qz67MexfYn/C9c0ON4oL+C2QCdatDRX9ZB11ATz0tytsS?=
 =?us-ascii?Q?vScoAH91dc+f8abFVhp8pywBbqF9Yn5vzS2OdyvR4aipFtDycwM39oCXivlF?=
 =?us-ascii?Q?7ozlJXVt2i4YPnHnm5Lso9s8HVqTq1rkwjd5MYWNlKTobl9GGozdUXU5OUzd?=
 =?us-ascii?Q?R2Hg8fzVrkD5RR9U3r2L1zyqToaHGsJv3v8o932Q2tL6yApmRfH2+tax+h+j?=
 =?us-ascii?Q?LK7KZ88cGRJ4xqjWkJ3qlT2TG/Zjeof1epLyZAMaxY3LzzzoDhxjXRTGsmUs?=
 =?us-ascii?Q?CKOhapvJRASz/4pJ0rvLSBONKFrZ6qPuRW7kgUuwtpyBcpl0Zzz6dho8EtUT?=
 =?us-ascii?Q?DfiUDpID5qt2JFMasiEUYQbzlrCJzUk5pSKqDgLvxzQ6GWfVpwo8qBUeDKEB?=
 =?us-ascii?Q?nTo+9bEcfL3WAXtEkvg55q6drEoS847jYB/dMPZccJig7eHz9zGv2zELQWOX?=
 =?us-ascii?Q?6zAIAmT9ft42hfgnWMgZUqYmZUHat4Yfje1OikxwnwhbVxE7250qUGGj9Jd6?=
 =?us-ascii?Q?An4764hXO2Z3ZNEPsyPcNr+sO8zqp15nfNPcCcRRNcL+k1NDkymXVHa4HEnQ?=
 =?us-ascii?Q?U80NzyEMt3cLiUAoKY9cAwSTp5Ge5p69dh9EwRPWnbiSYFliDlhPqKB0RytE?=
 =?us-ascii?Q?ZFMm0UP+PxnV/5uFksjE1kx6hAZ174KxjdPalfy05Ahki9nshH94PAJnK1qD?=
 =?us-ascii?Q?1pzt1sngBZTiMNfKhiEhBj0OugU8UohUUgbhLxyAMgGOzpDtYkbMvN1Tj/+n?=
 =?us-ascii?Q?PcQp+8gNLhsFyqcAQRmzJhHbKFsUV4JNXPetKrkTYbAQCCXQU0K92H5Cu52I?=
 =?us-ascii?Q?uaZrJN2S9ILb1kx1YlykB7t4jreFgesnZjqkeJYXd37ABZ19XD1JWBXEIask?=
 =?us-ascii?Q?IyGY0HvMlfRdCbaOkyPZLp6yvjIrZBTITDTTLVp7nLOQTf5Z2xn/298LgnxU?=
 =?us-ascii?Q?xCaC2V5nPLfLAn8AuMuvZFIC7eGVH1hgLd9ugflrfromk+ItNBJX7bAEIKh/?=
 =?us-ascii?Q?8Ds3I1sbUR5uM03hoLxvrySWAJSui/e5uYnz0v90eKVBUgKzAjm9azNgxV41?=
 =?us-ascii?Q?3ZL1+nzvl+Cc1+gY6/bkjCpJGdYvSANKvyb3x/Gjxln+KNQpLTOIiFP+X06J?=
 =?us-ascii?Q?UYCXOVyh9NJYBGmAlhoJkgD9JTmy+e/qMp9WhXb+8TNj6jEnP0xeIqOiFKmz?=
 =?us-ascii?Q?UPRq/dlZdZzvopqnsAEyl5NSgJ+n57oLmNnKuZZFQR/qxmhLvhf4dkD6rWYb?=
 =?us-ascii?Q?KhuzyI99R2I3xoaVMifp+jbfRIIviDsXTKglkX2QflugefUEpgwlxw6mnfTM?=
 =?us-ascii?Q?WoTL47Q2rd1f1wr2/pYYdb5atoW2D60+wTpgMWTAEgeQGu+OSZsQ7tqHMnTt?=
 =?us-ascii?Q?JQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b69bed4c-4f14-4835-cf8b-08dd043068e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 22:13:32.0627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jq6UqyhI//E5+iGgPzOlmIKbSWxu9mmV7zjDB7U+yNPk3CLu93NRY2amen2jQD2+7dRNQN2hwmXT5FDlhaSEyN8V+/jFZWy5J6RfUmxYHvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8279
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Johannes Weiner <hannes@cmpxchg.org>
> Sent: Wednesday, November 13, 2024 1:30 PM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>; linux-kernel@vger.kernel.org;
> linux-mm@kvack.org; nphamcs@gmail.com; chengming.zhou@linux.dev;
> usamaarif642@gmail.com; ryan.roberts@arm.com; Huang, Ying
> <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-foundation.org;
> Feghali, Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
> zswap_decompress().
>=20
> On Wed, Nov 13, 2024 at 07:12:18PM +0000, Sridhar, Kanchana P wrote:
> > I am still thinking moving the mutex_unlock() could help, or at least h=
ave
> > no downside. The acomp_ctx is per-cpu and it's mutex_lock/unlock
> > safeguards the interaction between the decompress operation, the
> > sg_*() API calls inside zswap_decompress() and the shared zpool.
> >
> > If we release the per-cpu acomp_ctx's mutex lock before the
> > zpool_unmap_handle(), is it possible that another cpu could acquire
> > it's acomp_ctx's lock and map the same zpool handle (that the earlier
> > cpu has yet to unmap or is concurrently unmapping) for a write?
> > If this could happen, would it result in undefined state for both
> > these zpool ops on different cpu's?
>=20
> The code is fine as is.
>=20
> Like you said, acomp_ctx->buffer (the pointer) doesn't change. It
> points to whatever was kmalloced in zswap_cpu_comp_prepare(). The
> handle points to backend memory. Neither of those addresses can change
> under us. There is no confusing them, and they cannot coincide.
>=20
> The mutex guards the *memory* behind the buffer, so that we don't have
> multiple (de)compressors stepping on each others' toes. But it's fine
> to drop the mutex once we're done working with the memory. We don't
> need the mutex to check whether src holds the acomp buffer address.

Thanks Johannes, for these insights. I was thinking of the following
in zswap_decompress() as creating a non-preemptible context because
of the call to raw_cpu_ptr() at the start; with this context extending
until the mutex_unlock():

	acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
	mutex_lock(&acomp_ctx->mutex);

	[...]

	mutex_unlock(&acomp_ctx->mutex);

	if (src !=3D acomp_ctx->buffer)
		zpool_unmap_handle(zpool, entry->handle);

Based on this understanding, I was a bit worried about the
"acomp_ctx->buffer" in the conditional that gates the
zpool_unmap_handle() not being the same acomp_ctx as the one
at the beginning. I may have been confusing myself, since the acomp_ctx
is not re-evaluated before the conditional, just reused from the
start. My apologies to you and Yosry!

>=20
> That being said, I do think there is a UAF bug in CPU hotplugging.
>=20
> There is an acomp_ctx for each cpu, but note that this is best effort
> parallelism, not a guarantee that we always have the context of the
> local CPU. Look closely: we pick the "local" CPU with preemption
> enabled, then contend for the mutex. This may well put us to sleep and
> get us migrated, so we could be using the context of a CPU we are no
> longer running on. This is fine because we hold the mutex - if that
> other CPU tries to use the acomp_ctx, it'll wait for us.
>=20
> However, if we get migrated and vacate the CPU whose context we have
> locked, the CPU might get offlined and zswap_cpu_comp_dead() can free
> the context underneath us. I think we need to refcount the acomp_ctx.

I see. Wouldn't it then seem to make the code more fail-safe to not allow
the migration to happen until after the check for (src !=3D acomp_ctx->buff=
er), by
moving the mutex_unlock() after this check? Or, use a boolean to determine
if the unmap_handle needs to be done as Yosry suggested?

Thanks,
Kanchana


