Return-Path: <linux-kernel+bounces-304324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE82961E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0546B20E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F0914BF8F;
	Wed, 28 Aug 2024 05:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="beGq6D2b"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703D13D899
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 05:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724822252; cv=fail; b=FDw497NhwS/CBUJ3RDM4FsXMbB08HPdjek5ZsQz7HUfff7VwDH5gHObvmegSvZTGR63+V+nBidmJ222JC+It5I6wPfIC16S+jJPeMVRaDRWsAGXDg9pHa0PKAA22XFHNl8Nmp1lNru7a4Uwf1v13aarWPdkGd2FYJNh0IMeROhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724822252; c=relaxed/simple;
	bh=UfQMcSMMRouG0FX5bwrhpBx4P2npiK7uRA9EH0NWpLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RfysUP1TSo9YYphO0omRenz5vZRN5sKPYx0+DKFDU4N+YPYy+BbpcUsmJaVQYCdjDytlEC03bcUu0BgcHiPi7Zow2rFX3i4lzPlS9reCFeVIMLLBsvRqa4n0IMrirhwMYykGPm06sTVAToWrPAzTwHxr77Z+vbOgvr1fHauuk1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=beGq6D2b; arc=fail smtp.client-ip=40.107.104.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaW61XYQLlDQh4uuni45WzuADrXRN7Dw8QnB7Ueyf8LmoSfWVBRW0bkxIi3BTRisRfCYhPGuaT5brdwlKHIRiwVz76AzfVURrJfYITKrZJ7hZ2t2NaTZSiQMD/zW5O1ghfiBRQN3ASxiHS0VXdy79xl4XumfWZ07QL+kfpXhecY1lq1HQn9yqQGn5vgpzeBa3IHbnbxA36fkznzF7VvVO31kHCRba28zJC4p3ZRYsuAG051JidEe3+oYSY5OaGlUocvCL5CRLlYpgoe/INIooa3SBDUnAMi1mrUFxTtH90+asSYPF/UB2kvoqyua/sKyLHS1MC0Fxy3bGHGCU+9ZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECRzwP332iNKnlBXKDo5ghzYkF57wi0Ga2SfUT1ZHKY=;
 b=fA2ZTESHSbbYu96zlK7awulhFi/Xjz1rff8GO7p6SpgJkRKi0nMCPbnJxVJo8PYfWkCHatiT/BWgtIavudAKQxQIJo4Hbn9t7BGZXrX5GtYKz/CI4ZOdCqAci9FNd8j5tWIATA1ouEeoZq8tR/cvrGAV6Ih/8t/0TeY/+wgJECya0ykufm48rzI6bB/+aaErfmldL4uOz8823JqXyIlhzAM+lnqgqPzIyFcsouljuJDjx4T+zX+PdA3J0PlHKQfgXE8J6HTMN16st0CBtUcGhWLeOsTcjNYybEUAFEv44h1BJ5/QdH11QjaJ2LrDY1NdwmLj5vwqiQznKkO11UI8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECRzwP332iNKnlBXKDo5ghzYkF57wi0Ga2SfUT1ZHKY=;
 b=beGq6D2bh6gz1vK24SdtoojKKuh9ATFwdRxh2sPA3x8rmtoerXkK4p8QU1KQRNOFXCjAw7tFWYedVu057YUwyaWYRjijcO+Z8cmbeNcZsdTLbA/MmE6XoHoPvaPUrrh8uKCM1O+UVJngAqKfPzTnjhATq25uU8xG1SfjMm6qWNWsfwDnM2Uv3h8ba1pDHI5sRbbWimnAIiZFxlRlU1JKleua/bVj0ia0LaDfuBeRjaZbuadg2NU568rZPco10jdZ91Cu3dgQhdWK1H9BFj310XtnBTdO1m5inTWIrrsHHUOkQWoy7WZih/O9b0G6FcOXKM/17RMHaK1gKAMjNonJKw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8116.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 05:17:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 05:17:27 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] firmware: arm_scmi: imx: add MODULE_LICENSE/DESCRIPTION
Thread-Topic: [PATCH] firmware: arm_scmi: imx: add MODULE_LICENSE/DESCRIPTION
Thread-Index: AQHa+OsPgOB7um7KHkSqk+kwsYAo7bI8IU0A
Date: Wed, 28 Aug 2024 05:17:27 +0000
Message-ID:
 <PAXPR04MB84595AD3A570948EA8593ED488952@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240828014746.1713728-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240828014746.1713728-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8116:EE_
x-ms-office365-filtering-correlation-id: 0bf53317-49b9-4427-28ca-08dcc720b51d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ak0sxheDlZDLkkSWKVCywY0yVg5kh2Dme+ZMUBS2q82NOgl8rjS/yI2/lEFe?=
 =?us-ascii?Q?wrdVky/plhMSg1wm0AxtI/MEiRlhmHqy04kmn47m1hHoB9FetohxWMXzK9Mk?=
 =?us-ascii?Q?+9aHmSVz5w1eD9wgXrtjasJc9TOIWzUrStkuI7xt18QEDeHRSubha5n+myQ2?=
 =?us-ascii?Q?/ic4kp5uvCPEPZTUZJw7RTgSRcXJQDDAdmmQLMmq9Zab2qWItCq3Ag5SyFIs?=
 =?us-ascii?Q?GXRctqyZ6VhW4hYChGc5W4DrpR2nTqWkzlK0+ILqaFGcEwMGKn8IRndUdnGD?=
 =?us-ascii?Q?wgZ05MljrqghujrDxBKDT15kveDcNySop3eogxdAeUE4QBkrZ8ogotlYjCaS?=
 =?us-ascii?Q?OXmgIAE6JsQgEpGAFdFrJSBrqOkKf9E1oaNTJPlh3QNVsCj/1MReoPHmw7Vq?=
 =?us-ascii?Q?hEhvULBlQB3dgwpWyjGO1EMpIO4OTMc1Lvg26hWGkWq6DVYhDm2g2NVvk24F?=
 =?us-ascii?Q?pU2/sukxjII2hKYmMnht05CvC8afhsV+nZAjrz6shzaQj8kVl8LroXygwAJQ?=
 =?us-ascii?Q?egj0Ff3XBVPKauq4LS8xlPnUFhJhhCUxtVB7qWoDFWJxKXG83Vr2d82r5mhE?=
 =?us-ascii?Q?7eNbsD2vSkNuQGSFA4ur3RKiLPN9Jw7c22rkaQJFrpxxAcsSxYjyCx3bnzZx?=
 =?us-ascii?Q?2OMuRLixxUFQuaVTS1fmouMEWFd7u61vWggG930CRYvprdZJcoUVePLqonCJ?=
 =?us-ascii?Q?X3ii8++Xj+1gUJeh8oYzYtvewW68/+WSlQxBfLQa6kwu0ua2PUwGt+Gzj+4P?=
 =?us-ascii?Q?DKHje7pqs6wgCFZc3Tifca1bObBT6OmYefqMvlWRAyn70rlY8vU94Wr7LyiJ?=
 =?us-ascii?Q?XsMLqoZbEUIwkvzQwxJX8kuKalqi0FXBGLTzfJfumDJCjg8XrgY0wJ3cEgpx?=
 =?us-ascii?Q?TxmLxo4MsSkB49kK2mrbFVPtAFu0muexg2gl4GBuldnSkKuymnP6XDNE16ZP?=
 =?us-ascii?Q?j+p4+UvQk0j6wwoc8+SlyXzB3PapUjAfcLno9v8CIvCYbjg86Qt0wSh7peBm?=
 =?us-ascii?Q?z+vXBW72DKEFjxoE+QILdiItFNRyKH99wjRc21Pq40aFV7u/BZ5ZmOiSiU03?=
 =?us-ascii?Q?2To8iCGJa9hnxy7kYtTY3m35H9Ol+hP0vDXyfeVgTSUJF4FOdN4stkWaTXq8?=
 =?us-ascii?Q?hYw8RrOkH2/r+KBERqtPpoShY/9Yg2ave/BKYIeiUaVee5OhjJm4Fsglqasg?=
 =?us-ascii?Q?5HOadVpGzrTYONQSHoNffYKXq5cLjt0L2qlqv3h55NWtRqha3HVjUNxjp678?=
 =?us-ascii?Q?ql44EMM/+DaTMw4uH+Cpv8agQV2XCI9xrNCQM1Ib1N9YaIv6G2PsN/c39wAS?=
 =?us-ascii?Q?esXSP1on0b/Jmi2Ehto4lGZIP2DYM/lg2XAK+cn2pcO7VOuznS0px33rphl8?=
 =?us-ascii?Q?18ScfqjkhFHzLC3pQsg1Zx7mwBoRp+hV0MlTRveZGRixzJGIBw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6Ei8rvu17X/Bb2HssrA+4MXw/mh7O09ytBGXg6zmstO0t2ZuBs0LroQprEQi?=
 =?us-ascii?Q?jDBbs1EXTaRjhRd8tOwjob8mOkxIA0KufmUnViBu9FcuPx1/nMTzIujkLk6G?=
 =?us-ascii?Q?aTvopO6ud/FA4OmxhIXo0ErYyS0mtrLJAb6WQrDfMubwxwXvfb8vesAPwXN9?=
 =?us-ascii?Q?zYptUDNMch2U+02WrXYzNfL1AlDaz77wV+ZOWNsD+9/XKG2L/ddJYgqvc4YV?=
 =?us-ascii?Q?aHpPAEBRfnNrxtq+MAEtNi/pE7leeOfSn7TvCX54TKm1aeDKIP9Jtafg5YaQ?=
 =?us-ascii?Q?x5Fggx3Wub4Okl36pSWRiCBNk1wVgvwQTnjhoAn3zpm3UEQ4YNajHMmJuu5e?=
 =?us-ascii?Q?5f3Gpbsvpee0B6udTKBXdrM/x+h2un27sMrhVsptiqbDYJrRvKN1t59VER4v?=
 =?us-ascii?Q?uE3IWfbybmPJ9IfkuUuHgnY0Pp1Xs4qp/m++He/0JH8/UeWNC90zKHPfIHlx?=
 =?us-ascii?Q?Wp6O4HhLoE+rBaz0podsNUnfzYoHpjWGy4QnWf8VIurmjeB8BD3E30ahqiKJ?=
 =?us-ascii?Q?8lzAU7842kwQTfZwvNLlq5yjybe8fTMuyinMhXMu8ixpT8kSoUSYPC+Od0zR?=
 =?us-ascii?Q?SPbpqhzopc/zlTaq7Bp2YGX/N6W00kVYJ/Gh3RcAU5PGBZ9iJ+GhDCARDPPj?=
 =?us-ascii?Q?a5xE4R06vO1iomnFITcFKzt5VhIX2kZXVu8LlNRSk95+W2e+IiYp1acWft6V?=
 =?us-ascii?Q?om+e6flrgCfu+1DAIqR/Zt4OYuS4RL6Xvlyi2L5Hoa958wpwXrw+sJe04RoR?=
 =?us-ascii?Q?uoWqlIGfQz4+RFrr4vGt0OUn3YtjuFQuL8aXuGf6YJG2gbQ/UHZr1AzxuCCd?=
 =?us-ascii?Q?3KIplbIG0DzvI39B32UQpzVC34cx+KHtqTbuARuRA0U+FU0LfBbwPNA9KwxD?=
 =?us-ascii?Q?iG/DJpyRLCMP7aRy4v5421yDiRRl+2YIi92f0SV0uU23NUDkjCoHa9lKtyDE?=
 =?us-ascii?Q?p5aXZrwoXwxEJ5vjXPuEFUI+dmz2B2rcUcqwU3n6h8Nj3srLsy95TgbknVPL?=
 =?us-ascii?Q?1t1xe/Lq/m4y3LhaMpz95WwZqsr5v0e3UhtRr0QwRMJwNsh4L+At44n3uNSE?=
 =?us-ascii?Q?aMTNv9kCl3OcqMjh/nKFQ9rTplmgZ3w7zC5o7jzaNgFtot2Mk7YpbAVWWB3c?=
 =?us-ascii?Q?VSQotF3U8dmL6c3oUToje13rXMnLEZgRbt4p4KXUtXYx+WyoBgOGOp0v66UY?=
 =?us-ascii?Q?RykTxcmlFQSTryUm59TpqSotMzQhbc74sJi+V2B7em/Yo/8bX+dJiSsmQkO/?=
 =?us-ascii?Q?nAPf0i8l7mSwu3lnHZZH/zEaRk/cU74a6jXUDfBxYkBZUDwV5lLommxddys5?=
 =?us-ascii?Q?h+SGJaO/d/WhmVhgzfa9xHCwqUtDgaBPKkXgEiKX+NMr/+1IgEK/BvOmhzIx?=
 =?us-ascii?Q?XCClE7Lu3ob4uY1UyPlyLptXXbJAlV845g1xXrA/X/MzRc9yBb7+h1591RVm?=
 =?us-ascii?Q?cdNC2L5elnVHm9o+q/fxCfzXVRyw1VXyHt6bZM/p3INaLC96Kc3/eeCXRhzM?=
 =?us-ascii?Q?sG51aKyJkVH6pO8o3Ig9WLElI4pjRBAu+jPqnMMyxHCjDD7SLTT+mpRvOGtM?=
 =?us-ascii?Q?fKTv7E1NHeH5rsZnoBU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf53317-49b9-4427-28ca-08dcc720b51d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 05:17:27.0737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWh2M41NCRbNO5Hp62K005YuEqbCtdsi7ji/5vSaMGF5EqaFlV0nPWxJcuQt87nXgwi1obkWRUfScEiQSgXSPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8116

> Subject: [PATCH] firmware: arm_scmi: imx: add
> MODULE_LICENSE/DESCRIPTION
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add missing MODULE_LICENSE and MODULE_DESCRIPTION
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> Hi Sudeep,
>  My bad for not build this as module. If you need me fix the previous
> patchset,  please let me know.
> Thanks,
> Peng.
>=20
>  drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c  | 3 +++
> drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c | 3 +++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
> b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
> index 0df7ca135c34..ad8734d2aeab 100644
> --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
> @@ -377,3 +377,6 @@ static const struct scmi_protocol
> scmi_imx_bbm =3D {
>  	.sub_vendor_id =3D "IMX",
>  };
>  module_scmi_protocol(scmi_imx_bbm);
> +
> +MODULE_DESCRIPTION("i.MX SCMI BBM driver");
> MODULE_LICENSE("GPL");
> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> index 9ee2d204d607..1d339cfa6ecf 100644
> --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> @@ -313,3 +313,6 @@ static const struct scmi_protocol
> scmi_imx_misc =3D {
>  	.sub_vendor_id =3D "IMX",
>  };
>  module_scmi_protocol(scmi_imx_misc);
> +
> +MODULE_DESCRIPTION("i.MX SCMI BBM driver");

Just find this Typo. BBM->MISC.

Thanks,
Peng.

> MODULE_LICENSE("GPL");
> --
> 2.37.1


