Return-Path: <linux-kernel+bounces-548204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AA5A54197
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F3C3AB96B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B1319AD48;
	Thu,  6 Mar 2025 04:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMmWYhn/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A401F95A;
	Thu,  6 Mar 2025 04:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741234649; cv=fail; b=dXQo4DJL+zkMMc9SoEKYSPT9UWWotIlTfoK2C9rQo4KKKqMCOnCWPFwqZD754EX7sJvxAB8A6yr1EibbiGIoNIyIIxTjvitfIcc7BSRjhtq3ztdKWScV7GPx7K/YJbgb1QYX+ONMtrJeiCoWhQONKt21RZBRdPiZ1TcxO8B/1Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741234649; c=relaxed/simple;
	bh=90/0/hdwSiqAEuTAi+FVCyMq7WrBeesD5VAO2TJQoF4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WhH3raMzJLnBRODlp0ScyU3R6Q6t6Gbqc1Mz5cvgd921O8YHW8UgaPjPCWsxLUNX/0TGHhxGqZAPsZ7IY/PF6eIv3GinWiAR7oyNu1BJi67Ca+RxkaCXuttFBkvRPgn9tHSwXeIxAs5pmms5Wm//Z5G+nsi531fsLeC/n1zC46U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMmWYhn/; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741234648; x=1772770648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=90/0/hdwSiqAEuTAi+FVCyMq7WrBeesD5VAO2TJQoF4=;
  b=UMmWYhn/IzcdxTf+LXGcCqDHzjjs+ryfD4CIklBdX9A83dbj/IM8LNwD
   nxoj/6OZV+3dr/AFbfTeZMyw4Q0Oy89pJe6WQjnk3HzYBkVcF0nqFeqAx
   j/LpO7WEHWgD9Vp0J9j7bUHbn8Z0/G6KxjpJ5I5ZuOPr+HtMmgRB+Jvfb
   k/DzEX64gjFeefNSq0AzPByxGl5qlG7Jpfxb/ozbnmumzByYoMWU/RXeF
   jWhS+iS4U3QBcwnSOUaOSA5a7zeN58kr2pQgfG+CCbJxkhm9xOoki/ic1
   UrtvuhbxSWISq5Gf/RCQs13xJ7diPsmRfDmIY42V9GtnPCBnnSAoIoaPC
   Q==;
X-CSE-ConnectionGUID: 8+qOMxZ7QNegQ+xFJ7Nc3g==
X-CSE-MsgGUID: 69Cf29lpTAKE/j6fzr1TOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42470042"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="42470042"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 20:17:27 -0800
X-CSE-ConnectionGUID: q6oscn0hSqec5KobeAPClg==
X-CSE-MsgGUID: GP2levbiRHyhW9NXr2k1Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119409140"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2025 20:17:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Mar 2025 20:17:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 20:17:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 20:17:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4sZIk5XXsaQ4rhto0w8PIVoLb+9FQwjWEhVBvZpZcVI7ZSXeWbxGQs63IPzNci1N7UEnIpOTSxPgMDkjjZFD+eYWM9vHu4CCoZzU5TSnsbobi9P8KPz2vzQCOvE1aFOfwk6se0Uwrs5AZ3aToHHIdVI4KgebqgMfro2wk9ZP6zu9yKO5i6vAVMg5s98D0GqqJ8gDz0UNRlusCFD7fXoxu9zJc0iDQiUICdWN8K4RYMLAaOyG0k31qbGhoXwR8Wl9o5zYQgt1sFkQRJ/o7hR1ULTyX13z910cn/SEY+21Do1pGSOPCOJU6PI7pBvoSwSkgE+yb8Jmhg/dvcrR8uDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90/0/hdwSiqAEuTAi+FVCyMq7WrBeesD5VAO2TJQoF4=;
 b=DwZWZFhm/0KK64sDoTibuYTS2LXnUNSA2Tc3v7f3ydOyyq8UcyBxU2pwi2zQ+7/NJP7QMiRCyRzipLop3FFMiaroyQfawzB5RTduWr/CZ+xZP6P32R3zopymy3/R6e5o7Hh+HcKLLg7/HwmTYPl+ANAzU3rnPzoO2Xk7o13i/Nw5K+jrb0dOFcPUHj4dlSTyMfgW0mEbu9BwunRKyANf+w+Ol/0Ksf2+8lBoMxnJzFnN2qKdIebH9yBq63wrUysEhxYiW8JC9ncBZ5VahPp1IoSITLQ6erJFDVWgyuKIGd8Tj/q34bzXGYy/Wx0PGfN+wncv5P6q7WcUKeSsZI5bWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 CH3PR11MB7916.namprd11.prod.outlook.com (2603:10b6:610:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 04:17:09 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 04:17:09 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Johan Hovold <johan@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ang, Tien
 Sung" <tien.sung.ang@intel.com>, Tien Sung Ang <tien.sung.ang@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: RE: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Topic: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Index: AQHbdhhxthJ4AiCvMUCJLGSIXsfkL7NkyIeAgADAZHCAACejMA==
Date: Thu, 6 Mar 2025 04:17:09 +0000
Message-ID: <DM8PR11MB57514E4F21C343E90A580816C1CA2@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20250203084822.18356-1-boon.khai.ng@intel.com>
 <Z8hetcRinFXXVAdy@hovoldconsulting.com>
 <DM8PR11MB5751D2151A9FAC30E8647389C1CA2@DM8PR11MB5751.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5751D2151A9FAC30E8647389C1CA2@DM8PR11MB5751.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|CH3PR11MB7916:EE_
x-ms-office365-filtering-correlation-id: 9435717f-1160-478c-055b-08dd5c65c358
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?iakmkgy//a0bBc3aexmn7/aduYoR42jP4jnKG7q7X+UCpCgBgaSLUCoM0rs6?=
 =?us-ascii?Q?i3/CxhWmZFd6VFyfDfMa1y+0NkFGTPFubEF7OnvFXV2CWzkq+Us1ocuUQFhu?=
 =?us-ascii?Q?gcnt5x/xD/dq2OKPPPGZfj3M9ZsGcHYu/SQJ+mIkcjecyZ4QDb16saKEzMKo?=
 =?us-ascii?Q?6eVnWTVATsRokKvTSxoCzERkfdN4vENEsuuaIKE8G6z54K52R54KZqaBzeZd?=
 =?us-ascii?Q?vlsU0OX+b/bPDxczT9CXcrJLrnqv2B1hyYDcxBYPTfDhLS1OMXGuCsuDHYjw?=
 =?us-ascii?Q?zufRe8UFh0sx1f2DlvdcIi1EPIhlyMvWcXQDeXHJernKO+bmOyUtmBMs54fJ?=
 =?us-ascii?Q?8Kv1t/v10MjIhl36vrEgfrgkpuyqCoXyBCXt39y6qiR7rCD/VHgkQSqWwlZ9?=
 =?us-ascii?Q?NAlmMQqW2kSzpVVDSvkpYZelA6AqmGy/jnqBxqYxueZwPtmhk0pZIaOfLXpE?=
 =?us-ascii?Q?GG4eedWmcfTfkxfr4ICIMhqAYFLQddDu3W1XP/nhjT5A///XcVdQ8C/bWzgx?=
 =?us-ascii?Q?CdtgVhEnxMUi9TrbM7WQ1wUP3MCcHFqyT6IHPCMpwBD3L63hseK7Z0zwPEcl?=
 =?us-ascii?Q?MartqqeANjF/4S83JXto3+9NULzL26EU/vX5Jr/KTGzaB61OXPMZJm4WCTkX?=
 =?us-ascii?Q?9k13vq55Q+nQ6ccWqY1MPuqdaOjg+gaJPs4hb745Ej3Anjefc+j3e2YMwEAy?=
 =?us-ascii?Q?Uasp2VX3kJt4qgGOl/Je1jLcL2UfcnLxWf39BO+6kMkhM8WBIDO7PGPdegaN?=
 =?us-ascii?Q?uZr8YV7AIKbAIl5UvUUnPg2UzDNZbUHlZuIrBWSz/B5s+jF1WY/KcrCWETVG?=
 =?us-ascii?Q?F4qzGZXVC+wGslczGRS5HIM9BvDOl3A2aXZkMXFlMBWo1yxd+MTw2AdZLWbc?=
 =?us-ascii?Q?0pXhX7+rAaUqG+UxdhvQV/PokQFftRhgEuckMpcncdCfFlNXAXQ0PyvdmVT2?=
 =?us-ascii?Q?o6grJnm0IVzDJgTawC1bE1/Vpn3WLIR0kVVGfFLpO2d7KFG0jvrD8gVDcS85?=
 =?us-ascii?Q?96Aqw/niMPJ5fBw7/Klz4P/exkaw0SrlrwOfWQpIZfZxSDUDClH4xy9eeIPw?=
 =?us-ascii?Q?u8zmuH3DGmUjXYcj6m2Mi2Zc7tu1XRt2fmY54V9OhenhhuVxZVQntOlrN7V9?=
 =?us-ascii?Q?vilGK1DUc6APO65B/gccC5QrNb/Rf2M99cWvBLNOaEwKeKThG4soXlEqJ4dZ?=
 =?us-ascii?Q?rdL1ru9vAIs3Z5eEfLyadYbr6cMerouyZz64Z7nkbzIF5X6FkKWuMS9YulRX?=
 =?us-ascii?Q?T3K4o8o9ahZGD/hM4c4nYgxPOPafczQNrvNwYddjc3b8z8vE3iRlC2hsZ5RE?=
 =?us-ascii?Q?fyBht63ly9PBYdCHkR8VKYJA+b+eZXJc7qqPufES7MN6eXA99bJSM9ABZitp?=
 =?us-ascii?Q?rgj3GYnsYRa16HyCvFSKd5ODeqbJXi8WVJ8qxijrz5/0p0H7Jmj9nbaaOlPP?=
 =?us-ascii?Q?iJKZRsTkdFqlOhGgCgjOgW3FpWNUaqDF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XTmMFm049/toESatWgzV7DPrA5BG8YiaW+EcH64joBxXUj3t+A8uSlC/d861?=
 =?us-ascii?Q?Uuvc5748PxsaL8PDcfMe19ntSo5ZCu7Hj5VaEmFwb49VFJefo5Aamg7R1QoH?=
 =?us-ascii?Q?6Ea1w62P1727bfcvcKeEmeKMDI9vWbFR/HERAfXC0dhWhdgyBvRK5hdPWR4a?=
 =?us-ascii?Q?zYvsGipyW1bKJe+Mry80ueysw948eHnHUELwLrZsOKqhFyU5Ib7raNtG2PhM?=
 =?us-ascii?Q?r1VYNQSAT9c94TDoJwEd/YO37m/i57C3OR2Pcr70k2oIGcS85WYhqTApFRRG?=
 =?us-ascii?Q?wYIzbatpE9ovHUsCBkKfgvB40vYgLqxHB/qfh5XWEU2Lpmv8LjyeTql7e/IF?=
 =?us-ascii?Q?t/PJVZ/fVpBSIfiHZdku9K2cTROyn7+O7pBqxh1eJTkt2aLAV95HyLLkELff?=
 =?us-ascii?Q?9t+Ln4Fr/xXOp9lZ2BRJWjdbM+Lu3rOkk91zfG6N1TCT4/H/6j0e03rERfBl?=
 =?us-ascii?Q?JLHrn7UMYLGT/NGakuopDb7xrGt3ud7L8AS9JX4uGb7H1oSoAJqaRyJzFW0M?=
 =?us-ascii?Q?6fdke10THhrwgpB6jhO346TW0c7SrGtZS3tHBpz+4zdAA5GMZyLxmh8aUkG3?=
 =?us-ascii?Q?9zpS1sy01uEC/I+9o/nVLfZQqX1JLmF4Qtw3OUfSpsOKvXB0H7xKK9XWBWLy?=
 =?us-ascii?Q?kzdHmxmGcxx8DgMVuYEp39v8sjN+oOmoLn4KJhI2ad/RMvP6n5+s8qZXELFT?=
 =?us-ascii?Q?QSBUb1dJ+82xVNZH8fHFk5miTMHBz060BYX4VRMrEFkimCbbEX7HQfrA4J5J?=
 =?us-ascii?Q?VOfW2+AK0H1GvRsHcRIe+9ZgcBzNMrrQvHTS6RLVOeRsxSvmgnv/Aq1tX4B/?=
 =?us-ascii?Q?g0e/K3NztorpT0/tj3nJeHTgN0rPiQ3Qqyayn6c1pfc5X+Mre6yQQcT63oiM?=
 =?us-ascii?Q?M+BO0YoWlzPi0iaJH9razuYd/fzr/fawu25A5elxM3ARTno2H7aKAu1matUu?=
 =?us-ascii?Q?phDtIm2C++h55P36+kVo57kvLtwDdnDh4njHuJuSmCZSe4mGOQobtIBlORLi?=
 =?us-ascii?Q?37kBA6agmDp504l2y/E7wVVVkF1/HdlKGi9QTnmK1Jyo7q+eyNxpsjhMN49q?=
 =?us-ascii?Q?csZaPOsnPJo2pbX3xeq1x8VfEgJJtKHckQEU+f75rCncRLg5pW6Z3VTWvSXt?=
 =?us-ascii?Q?bvvBQGOoaNsPEhatZZ9xTKmJOOh544MknsXRedbXRZP15wGqx87VH56X/V43?=
 =?us-ascii?Q?N2q/xaelMNlGHjDLh7634E8RdToEbrHrTDOswZJuQntqeU/yPwtpbu94XEjf?=
 =?us-ascii?Q?UopU+Qg8ipjTEhiTKO32SgeUtiSOUO4jU+Jp8ZqzFv+FNxQRL+2/Ony42Hhc?=
 =?us-ascii?Q?jBInGdrVnRAtzAoW90+dOSVxHMShQh+/hjeoiFkkj3JMAyQkanlrO9olPpdO?=
 =?us-ascii?Q?ANQmof4bzzaDn9LP4N/Sye3HQYIXDB3FgzqZdw6kTVGtdg7ppLmLKlfsggYd?=
 =?us-ascii?Q?EibJ9UyIgLdcBSB2qeNuztGCBETJ0x9tsxnuaKqyPLsWQjMNbgmiGaFy7nYl?=
 =?us-ascii?Q?QvAzFSSs7fGkhmx3Ubr+i/qBZ5qXm7+1E4ANaepVIlDqmOpq2SwwxoY9AJAW?=
 =?us-ascii?Q?fMlYeojGEewMXyaD+jRM/GEtqI9Tazd2yv3BNUz2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9435717f-1160-478c-055b-08dd5c65c358
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 04:17:09.4680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxtfuLWZ5pMG+GpQhjc5B2VUCm7dM+3KznArhv7TlkTkkEq/vuGmjSydJvCwbOthVXuYy1GtoTjtjUPqvU5MWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7916
X-OriginatorOrg: intel.com

> PID: 0x602E
> Description: One JTAG Port + UART (Port B, C, D)
> FTDI Chip FT2232=20

Correction: FTDI Chip FT4232

> Port A: USB Blaster 3=20
> Port B: UART=20
> Port C: UART
> Port D: UART


