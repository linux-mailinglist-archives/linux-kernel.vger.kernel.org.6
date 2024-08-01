Return-Path: <linux-kernel+bounces-270544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F37194412D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30521C23005
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E6A1EB490;
	Thu,  1 Aug 2024 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C6p8782j"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0742C9D;
	Thu,  1 Aug 2024 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722479270; cv=fail; b=rB+4mB23Hc7gY5dzLQvjuHMigF0tmg+kVrQwhrZ3E23bqQQ4OLkhq1oQ2BROE9kOZDtxtUaP6d+a1wBbFuVbNgqh550FP7Ys4hICwFggNsqd1P+H70/Xluvto51Ro2WO89bnNVlwas9Y/xEOJFWxyHQRmjDjm13E4dfGO1Myxdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722479270; c=relaxed/simple;
	bh=i6i/2kekgo5DA3wcFoZJfLyKlLaKzbBZrJgxuWnoEI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EOjaDpsl2GW23AWdKO+gttBM3MPXGXxSUcZ9SrG/KQ6zIJNPieyeZxs3lRqbTPEn2Gx41OzTqbQ5GE5WsWgo+iGqDgZoUwKZgan6MAhmgcQIqjX0ckfO3zrfh9+vIU1ajmHzBs8KUZhk448ebWGU8BXZcQc2ZpTtwax3TIaWtdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C6p8782j; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3QXfNpEEMq+V5j2ibIvjN/VDVeL250vQ5Vs47zCtvAMohl6XMKA0W3a9crUERBS9SoK0qNPYfuWxhUTNSON4GTPSeE417pLwXhWIgrTJ4uBfVcbhT5xPMlP9fe0mJoksjnn8SPMowhpRagEPJ3pTcQgauNeOQw0xuZxLDNi5eokyVqlvvdbx77cvEDcbKvTZb4Z56bicZvwUx3NMHJo6alM59IPGXK63q2bmZPQkrqbGig5GVoO9hCzwQunkSSdDNPCjGunQumYStJoTC5Srffq/DipgTHRdMxGgGvd13c244AO8DilvyhcnfzpBvE+jpqZGfLmGn5p+3PdvnhlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBpYIEFWTXggEfjn68iqZNPsVpMX3EfKInZ/l+lVZYI=;
 b=Z6NeMqmTqYvTu5gKS5VvAJCQHxPG9L+lTvWX7kA0X60IH9z1ugRv6dmwfYCuxGLaeU9BO8/Hk0BEEE5aipYHosXoKPkjPxys08lMzQeaKikEQYPxvBZUren0SGY0otGr9J0D3POEAJQX3UOtfS13MtbRvBYPVhQIlnG62sJjmEnVPpB6YeysX62JMmOWEv/c5vgKWsmzo7ehcZ0BykiKMLKN0elYWWi+QK3yTa0v5UjY3e2vrdfOHO3iITEzsVfzTgV6YjHOs0DktL4m2jMIU/ineMUJd5F8GYo9TIS88OU1hWPOVhiLOkZFUhUQ3/6aLHgEDQQYaBttn5c/4i6aqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBpYIEFWTXggEfjn68iqZNPsVpMX3EfKInZ/l+lVZYI=;
 b=C6p8782jd2OVSfyJi63s73JnaUKxRRM6SKUN6/Zr6ziuWUO9IjQsbEZCVP7wAIaVz3XWf6jGulfZOvRL4OT4/BNMouD3ec2H/ldB1x8SuRla8nAMopbCeI9N6ghMoPeGKMW5deRiIJ90yoJKhPnx76OCJO3V5HTIxcB7cGomtbhBARX6CxJi4gcD9y3bdI5QNE7O4kod3/a/eYid+96A09XfPsgCob09ludCRRLB9v2LKRhhHcuVBCWvkTSB0zR4WYB4kSh+AEEjQW+Z3H3EnnrlGwFDSc9YhuIRedWQglDesh0pBt/u8VHxSVZDhn2Tt+KHGdd4LgYTIC+yk8Nsow==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10003.eurprd04.prod.outlook.com (2603:10a6:800:1e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 02:27:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 02:27:38 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Yashwanth Varakala <y.varakala@phytec.de>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "upstream@lists.phytec.de"
	<upstream@lists.phytec.de>
Subject: RE: [PATCH 3/3] arm64: dts: Add phyBOARD-Pollux dts for rpmsg
Thread-Topic: [PATCH 3/3] arm64: dts: Add phyBOARD-Pollux dts for rpmsg
Thread-Index: AQHa3nebqYEsgOX6LEC/YqoJ4w4XrLIRth1w
Date: Thu, 1 Aug 2024 02:27:38 +0000
Message-ID:
 <PAXPR04MB84593B109878D86B72DEB4AD88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240725094457.37739-1-y.varakala@phytec.de>
 <20240725094457.37739-4-y.varakala@phytec.de>
In-Reply-To: <20240725094457.37739-4-y.varakala@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB10003:EE_
x-ms-office365-filtering-correlation-id: e9b3f64f-a8a3-4558-ab40-08dcb1d182d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vrUGgkfFSIOtHMyMKzejh5yV7s9VPLy/9lJMvxjTYyIGE5sRXSjxKW8m/5PX?=
 =?us-ascii?Q?4bCZFOtNTMrqZKA2J1JxNHzC20HaDfgPugvDeu/CIORa7RepUF9eT0AHiM4b?=
 =?us-ascii?Q?K+ooS0Iya7+3F4/VxE7+hY0DvNjsWEzyYo1Fq5mN2o8UqVhKBmksmckAlPve?=
 =?us-ascii?Q?wpGTV0W2+bmRn9TcVXiqIclldxOz7+YlAXShsuzBy7n0eTMKAWhJZbGLtxKg?=
 =?us-ascii?Q?ilL4/Gpey2z8HbQX0pCeovnUPBVJ9cRsDOUIV711uQi/evsp9ThpwcZwziKP?=
 =?us-ascii?Q?iSNkuzSViuM5zVzyP1YIbM2HeN9/H5dWK8LLAOBmxcqPK8pxLoxPAdOIU4nU?=
 =?us-ascii?Q?vgxYrcqEpD3xlVWux9mC/kPtDB1FU4NKeqBPADnAqdFPSmJD5L9T6lYaYxK3?=
 =?us-ascii?Q?FQmz+UCl9BvHplSN5k0Xv2ToMzZKoz8Yn+P4HI6eneFq2eknJeWZxaqMHohT?=
 =?us-ascii?Q?K65MudvxUGtuQ+/yOyFMLwxntAuW6NRJgUf9yfv9E84tmD33FR+RUGZPJ1p4?=
 =?us-ascii?Q?kH3OZqhmwjQ4l8CGcqLTXnVCn+1ZbdstCY2GPpLyQ4D5XpVYdo5kYnzr/trw?=
 =?us-ascii?Q?UvA0z4HRV1pemE82mGvvkNbUYYwoO9KPp/rMB3d5Wod+89mN/9/2POvGW5j0?=
 =?us-ascii?Q?QupCJh3oWSO/fTe2bRbRuexAHV9edElq61hfBqa77ahMb3uyAG+vqWIPr8yG?=
 =?us-ascii?Q?uKUF2ArnZa0IeSCHyNuRF6imUFEGBVcMtLQJ64YpoCPEYemFTad1WX6WVhUq?=
 =?us-ascii?Q?scE9o0KRXdiUYq3ZS40hI6+KUh0jOyZL0bxca+bCp3khq1gZFIZPeBJztlZz?=
 =?us-ascii?Q?Ci4zYXnq7Lzdnl4dqbYpKvx5aRfufyqBU9szuqGREXnLFoGMsNIgH4Kaa0Br?=
 =?us-ascii?Q?KNUZITx44PUZgSmAKS1csL/5WpcsmPSpiG2dh8UfNO2qMl0DBhW7kkQE0qC+?=
 =?us-ascii?Q?Rhw3A4nsXP7usx7j0WO42p3KV4MW3oANk8mUEGBKcgAGAtvJJJLZhrKJFv+P?=
 =?us-ascii?Q?hoJnFSLHTG5/sC3XxfiUJ4Q1ekxTEOR9amwgcZAXnAqaj1kMFdGBPKBwWuJQ?=
 =?us-ascii?Q?hWW89emn1qRCMqhzy53t1eDbFcyuTgfd7mT9oN1Ym+Ekp1HLPrfdKMl23CnX?=
 =?us-ascii?Q?P/cIB/LRVsIw/ZDST86iGeKkS8qnInmaUEX2CErWxyaCDvEu+vFgSiMLslSx?=
 =?us-ascii?Q?ZDRV8fsDutD2jabvCiLR4kuORT+fvUY1wM2IDf1NKAye6upE8Bys7ZqFn9Ua?=
 =?us-ascii?Q?Z4Ns2P7lvxht1T7KB19KYAqOV50qfnfb9l2H4TmxFdJA0Qlr7aLVkW5daoF/?=
 =?us-ascii?Q?0KU2AYCPzIuX7nNqo6g4JCp+d/Empw7Jv+yYs/TWCgYTqw1ZCJedh53aQtRi?=
 =?us-ascii?Q?Bri0qVhTloUA9KHbxU5O+FEaLwC+Bq8fs24aPCvtIuOOI+Y12Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SLg0ziFwGol+DlgTSRaCrafl9zb7tfXK5SNJdwqceiyjukLJcDm96BaMQys5?=
 =?us-ascii?Q?/se7wIkTz3ga7ciktV3DJyO+OOa+QM538A+lpAlXm20t55YdOlceN7LyPLd9?=
 =?us-ascii?Q?axC+oR4Xlag6nkFhrxZez8wvV/YA+WuEwmPUTRoodgZzQbM6m6ZyxiqM1la5?=
 =?us-ascii?Q?i0JxeBLyz/4KmISQ90obALC7B/IjOq2DgD/wQySZ+jjT1sI/iRD6WGazd26u?=
 =?us-ascii?Q?jqSC+edPKGeUsG8dizT5uB61quCkswLxoUPOtFYk7kuByf5vcKs2lpKTLsON?=
 =?us-ascii?Q?9IwecaPaAiezeqE1aayKeg2nA5cL8/1h+dNxnFIv18Pv2I/L7Piba1m/v7m6?=
 =?us-ascii?Q?1sSHXhBX2WOZG63B/5Ufs5Ug6tTmG6Oaz6g4X3v89VE+p8qWjh011A6Ag/Am?=
 =?us-ascii?Q?3juCKJzkD1WTjnQAwGjNyO7XEd5Dj73rXabBH+7dtMxtNc1iotY/DlZ1VZi0?=
 =?us-ascii?Q?Rmt/VrPFKTR9Jjs6JvuO6UcNl6vo3C/pQNSy8CMM+qB0rFJ9Pd2319ER1ztO?=
 =?us-ascii?Q?l/wn/L7NcGz+uRgJWJG93KntdTt0bxwcARz83c5QH5CalB2bWtDM94fya2ey?=
 =?us-ascii?Q?sbBJ4dEn5E+oYMiO4KP3oDkATr758gAAzPvB0xBb2dCCiaQ7JD/qQnXeqd2u?=
 =?us-ascii?Q?uiomnL1PXBvfOJ7mUkFKzRH3By208B0hof/nLjAep67VG+1cmjQ2LI4vfn70?=
 =?us-ascii?Q?q+SRFjWDPY8d1AVbRnoGkzbQ4BD3MN0KgcdD/2xRZtk8dPEq6QI4HHhWBRut?=
 =?us-ascii?Q?B0Ldy7YYc/hd0tl1Sqzsh6yS/Ehubss5p9X1R1msxuAGpegcMPvGkFKqH/P5?=
 =?us-ascii?Q?ah5doG4Q4gkOUdawvcs7YrkFOEFlDzv62Cux+IsHYeUetaLOUmyrmRWsHYVd?=
 =?us-ascii?Q?pua0ibx5WE/ArhJrjNrrzXfPQxsTQw7I26EeFgMbbk9ZMxJbNdbpuehaEZ/I?=
 =?us-ascii?Q?GFYyfvshxWjQli/U4ez5jGIXyQABlDm7Y43BmGnK6NKkW+H9BmxVP8zD2oRV?=
 =?us-ascii?Q?F9qopIwy7I3rmLd49xIwFGWyQyyu+GX6GDPOZmZfOtS7ikP3n25BmN+54/1r?=
 =?us-ascii?Q?3KEZVaPtKR6eRHPIGMEqlYgSI0lalpnOe+9KvnWf2odh5SXqj9Q7uNDxH2nl?=
 =?us-ascii?Q?kGOiGnQ8VjVXxpI5Y6C8KHh9CqOJ5tLJR/yyKkBLt5jiAAorYLEtXn/f2qD/?=
 =?us-ascii?Q?Eq2P5xT2VJ8lpy17v6lxjLXtF9b8mFR8nYXnitEOCOIBb+OLIhdkZhlTGcM/?=
 =?us-ascii?Q?WjeVJg5CvYJDr9BwvPXSgdhk0JBlFi47i7w0cXayDpmG8rvFKURg/d8P/PxR?=
 =?us-ascii?Q?tqAVWSTvurFAyYxIqnrbdyv0kgSCaXkOZ9X04LYI0PE5EQF4wku63/lWFo63?=
 =?us-ascii?Q?uTyQMNq2a+BRUJJd91rFrB9J2Q9udOsB+vyAyj5sHO0NZwTSh4i2lLZCj3Zv?=
 =?us-ascii?Q?XV+8ijuFXc3A4AkaEmKoi/H/1Rxtb4gCm6CoxMo63n69mO9rawBM5Bdj45kD?=
 =?us-ascii?Q?CxmCaQcKLIT3jykpMnCDwRNO8Fpl/+ScYh/clv+1Dm0QJo43FipJXZK+wGO+?=
 =?us-ascii?Q?zaYjLAUcxX/Wnfco0F4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b3f64f-a8a3-4558-ab40-08dcb1d182d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 02:27:38.0849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3EBhc8g/5kowwwjqqEHc+njOfWQGppnZR+RXlesm7wRCIfuGw1eCpaSocV1oTzEBgnzK2FcFZ8QVtYS3JdL7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10003

> Subject: [PATCH 3/3] arm64: dts: Add phyBOARD-Pollux dts for rpmsg
>=20
> Adds a devicetree containing reserved memory regions used for
> intercore communication between A53 and M7 cores.
>=20
> Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  2 +
>  .../dts/freescale/imx8mp-phycore-rpmsg.dtso   | 57
> +++++++++++++++++++
>  2 files changed, 59 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-
> phycore-rpmsg.dtso
>=20
> diff --git a/arch/arm64/boot/dts/freescale/Makefile
> b/arch/arm64/boot/dts/freescale/Makefile
> index dedea4b5c319..80cc87d50301 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -177,9 +177,11 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-
> phyboard-pollux-rdk.dtb  imx8mp-phyboard-pollux-rdk-no-eth-dtbs +=3D
> imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
> imx8mp-phyboard-pollux-rdk-no-rtc-dtbs +=3D imx8mp-phyboard-pollux-
> rdk.dtb imx8mp-phycore-no-rtc.dtbo  imx8mp-phyboard-pollux-rdk-no-
> spiflash-dtbs +=3D imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-
> spiflash.dtbo
> +imx8mp-phyboard-pollux-rdk-rpmsg-dtbs +=3D imx8mp-phyboard-
> pollux-rdk.dtb
> +imx8mp-phycore-rpmsg.dtbo
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-phyboard-pollux-rdk-no-
> eth.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-phyboard-pollux-rdk-no-rtc.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-phyboard-pollux-rdk-no-
> spiflash.dtb
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-phyboard-pollux-rdk-
> rpmsg.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-skov-revb-hdmi.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-skov-revb-lt6.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-skov-revb-mi1010ait-1cp1.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-
> rpmsg.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phycore-
> rpmsg.dtso
> new file mode 100644
> index 000000000000..a5694f3aecaa
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-rpmsg.dtso
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0

Dual license is better device tree.

> +/*
> + * Copyright (C) 2024 PHYTEC Messtechnik GmbH
> + * Author: Dominik Haller <d.haller@phytec.de>
> + * 	   Cem Tenruh <c.tenruh@phytec.de>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/clock/imx8mp-clock.h>
> +
> +&{/} {
> +	imx8mp-cm7 {
> +		compatible =3D "fsl,imx8mn-cm7";
> +		clocks =3D <&clk IMX8MP_CLK_M7_DIV>;
> +		mboxes =3D <&mu 0 1
> +			&mu 1 1
> +			&mu 3 1>;

        mboxes =3D <&mu1 0 1>,                                             =
                          =20
                          <&mu1 1 1>,                                      =
                                 =20
                          <&mu1 3 1>;
> +		mbox-names =3D "tx", "rx", "rxdb";
> +		memory-region =3D <&vdevbuffer>, <&vdev0vring0>,
> <&vdev0vring1>, <&rsc_table>;
> +		rsc-da =3D <0x55000000>;

Drop this "rsc-da".

> +		status =3D "okay";

Drop it, default is "okay".

> +	};
> +
> +	reserved-memory {
> +		ranges;
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +
> +		m7_reserved: m7@0x80000000 {
> +			no-map;
> +			reg =3D <0 0x80000000 0 0x1000000>;
> +		};
> +
> +		rsc_table: rsc_table@550ff000 {

"rsc-table@550ff000". Seems you not test this patch with linux
remoteproc, otherwise you will see vring not set up.

Regards,
Peng.

