Return-Path: <linux-kernel+bounces-245218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0881692AFD6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91D6282AA4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D213A89A;
	Tue,  9 Jul 2024 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NCJGeXZO"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901B7376EC;
	Tue,  9 Jul 2024 06:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720505476; cv=fail; b=FZe/ZEPhYEwp7pn59RHyeYnRoeyV9du/2Y+h+qt9Ervd0tW2B4sU27x7knJEW9lrk0iQFnsJr54J5rKTDKvhvWGRIK+pFTbQqykivQ3dxIEwLWFgQ+D5CQRv9Hkkz5IIsn85E3wc7q7ijFmlEoqBT/wK9Wd3iK03aro1fqgrxwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720505476; c=relaxed/simple;
	bh=IgYOzuMKR5cr7dIFiJ5ZwtfEojjtu/hcvotp0MqWKks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WlFybbahBypJVzErrNSBf4+4qCoz40Vo0gxmgXAbxZ+06w1mnFCY1EuFqDd8Xi/RcRk20/9SrXNeA1Y8xDix5/hi3mDraWUWnXkVX/TLuODX4owtmUM9Dg3QQmVD8/Faib0BTvVvi6mUC1VcFxhqqkgSG41/4aezIhRe529LkNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NCJGeXZO; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0ObGqTRe1ConIM+qiK3lbcqtoyPlIOEaSHh1XgAbFEb791HAQKaFF5/PawglM1LWfhhsanoFuA3KIGFcyJf85g/oHpDftQQe1X6WMAUEazJ3vV9+ksyzw5jrwFMYqOspKt9aZoeYdyuffNRqNuE9D4G6bU8bKisgd5JlDge5x0t1vcfeujOzcmKzy1htv+jpSoCQJctWRU5T0Aqv2c0S6T3iTzw2grt0dmlfeOmWdhQyfGNORc6gSXcbMKTyU881SG0dB2jpGQOzS4Sk0kaFGC/hBwiXLOzxzgD68RbNEaq0DkZMDKh+1hTCoDhyQ7qtnqC63qQjbTYMknnbyZsnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3q5CIewp1Iqsb/6Or8N9aLfH7ZaOXZ4EWf2k74AfH4=;
 b=LhWOZRKnIS3hozNZ5Exs1ejn9uBitkpI940RfQniJYXKONnCk1D7oLGUm7x3lWAPTV7ct7aJcbUSY4FL52yJZEKzeKe3Qqr8K68qgZf3sPrhMu9Rts2mGdIpRd0L/DeHenz/IBVC57Han9K3DLLhcxUvNhuuF+mL4uUQ/lsZb14n4T+ubJY/HUCLsj26WY9uEweLOfB6uXO6KcSbdlLqHkGnmVsM/nUaoNuI7PTysC5plmmEA7t0EWxhQYnm2NDDTaVfVJQTBlv/FVe6Grj+oFtIXc/pw4+bnY5bmE3MhUFLU3u16RIya0zWXEgbQQqzNWhKMo9IcMg7V0Gs5WvWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3q5CIewp1Iqsb/6Or8N9aLfH7ZaOXZ4EWf2k74AfH4=;
 b=NCJGeXZOIdNk+hVF+tz/JDsPv6BcD0LjAKwP/zk3EAkFVI3rY6c8G4VjQt4D5FXh6LXe/gULWAoUKCX5GQ2RSweFueGHFo7LfeWBFLR9SpSNOoIv5nZAhGXNJ4aAR/TFcr3saY+cS2pjqX5jNk6uL4chUV7FKMEz2FDf8AoyouM=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS4PR04MB9691.eurprd04.prod.outlook.com (2603:10a6:20b:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 06:11:11 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:11:11 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v4 5/5] firmware: imx: adds miscdev
Thread-Topic: [EXT] Re: [PATCH v4 5/5] firmware: imx: adds miscdev
Thread-Index: AQHazuMaW6O/AO44ZkGR+7lF1ox0ArHom00AgAVT9yA=
Date: Tue, 9 Jul 2024 06:11:11 +0000
Message-ID:
 <AM9PR04MB8604BFB982C535C8E9C6C0F095DB2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
 <20240705-imx-se-if-v4-5-52d000e18a1d@nxp.com>
 <f7c62def-cba4-46bf-aeda-829d2c378ee3@infradead.org>
In-Reply-To: <f7c62def-cba4-46bf-aeda-829d2c378ee3@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AS4PR04MB9691:EE_
x-ms-office365-filtering-correlation-id: 68432436-66b5-4a2c-1184-08dc9fddee5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rnhBltbnbBrE7VUmiq50XNq+8LlxBEjQGXCDHbvLRnLNTO7rPWHbwK4SD8qJ?=
 =?us-ascii?Q?HzePdTvxADylg4yv2yoBQYqA+m5hd5VR/Hq76+Ld6jDDnFIOSTP3m2jipAZ7?=
 =?us-ascii?Q?7Taw0/wESefAUUbxulAh7MAE1demVyS01drsttAnss4z0IOnsAW2OMkJ1Wkg?=
 =?us-ascii?Q?6yiO2Rl4qT2o711cmmRb9GbEyvxAhJqxwxApAd2zWBursv+Ypg5woTKc8HM1?=
 =?us-ascii?Q?w/McU/y4VThqqzj7a+3gO4E9Ft7PBFKN+4iOnoNq+s9fLX7Ydrcqamyi115S?=
 =?us-ascii?Q?8r+qtyEa1vu4fI8Iv0zrqZ6S7LbzSo/t1RJQ5fG45iZ2xJ7IpHdxet2r7Sny?=
 =?us-ascii?Q?nBkCCV0PS9sTYMfzseXf5evOBAOMP9bOPD4tEmkcs+FfcjusGnB/iaQEizwf?=
 =?us-ascii?Q?MrbK2XsUPraR3ulXHfPPwlA2BEzH195kdFaZ35N/ZZl+xLeWzygPMgbTl6Ll?=
 =?us-ascii?Q?wuglamXzpL6Qbwik2cDqNc3T37wi/z4rG/FoKBmqkGkF1komJ/ACwysLqGvk?=
 =?us-ascii?Q?pZIuzmAQv2hVmzauUBl5eNMqqCLbTdp422PiqGi9fR6Bni3h8QDSDRnsTWIp?=
 =?us-ascii?Q?x6Qfq21A4td79LV+J312UbRyyes5HvOYpTUuulhnMJbTWjb/w0XBUwUNKagN?=
 =?us-ascii?Q?Mj6ZcvWaHPaSOs0no6nhSggtMeOtdKQjVudhGwPRHLWM3Tp3yMAmpwRPbR8u?=
 =?us-ascii?Q?t8WuBp9EROGO6L9uWMCksMoXalPyXA6Du3G4Q/PmobHxLTo1PgzSpVcupwsg?=
 =?us-ascii?Q?EiCavE1BJU4qN32z/4dbBIhgl9DC9lQoM+1Hn65PeeYmHYjW+NeHrcYUm9Q4?=
 =?us-ascii?Q?wNBKUJv95l4kbL/56l5UcOlgsIKDsBv3emZuvrxMAk0AHKO/yo89sZZNt2NQ?=
 =?us-ascii?Q?AzQTMamUiIBBdIDAI99hCbELw9VOYpt1qWb3w1iPB2GfCus9tcB1Aew7G3Uy?=
 =?us-ascii?Q?J7pVNcX7oHSxSmzrbOqwKvoEI2sUlgB+8+HVFm+ZXN4djlEURLk7PpcTzSRr?=
 =?us-ascii?Q?GrjOrYzFZqrXpNzmZlRhb5cr1ZqYGry+piomCosC8vx92OEOphZ+ORkdyHW+?=
 =?us-ascii?Q?NgnGUQbq5RlE6eF5f+bQRqqCMl6FYNYK/lQxxzmARTg2lPegOcnLJemxjB93?=
 =?us-ascii?Q?InJtCBLJhFauYW1lDg4+YPfzBH0EeNfWLOaBIhMEMDkCI9WfIOSW6xDcQD9A?=
 =?us-ascii?Q?vup50+pgzL9id1ub3ZXaARrJenVq93sXlk2y2DOb97G2T/KY85TLdVNvyDA2?=
 =?us-ascii?Q?xBLHarbLe/Xnb9wY8CQeKgQZaGMKqcKn7Jr7dJqNKSj+LVxA1UYRD3VfCtxJ?=
 =?us-ascii?Q?adHcBVjurB+SRM3nerAu2xDrOSl5E0QLBsyHNB1NE5fZ2MnoQ9fphzHag+rV?=
 =?us-ascii?Q?7mTFVktOZkPwl4GCR3lfnsUhpu6/2q/g/6msRcUUgvIlO7fxlFooWaUxXbrv?=
 =?us-ascii?Q?p5uQ47QBznA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mAh5nDv5QgjdhviSf3up8p3dKNdF2/YYYTzk06sG4TGQ62T94ThZc8DVmCNd?=
 =?us-ascii?Q?mLQuYgZIvyKDPqtHpe9cxDKOBbZq8iF88guwM6NEmx7HEMPqCPTlALqS+Vr4?=
 =?us-ascii?Q?vl5Lts3EHQGJwiU098FqG1hhYMn1zzHDrnHWUKPzCI9X1Vqfak+2VARcCcKO?=
 =?us-ascii?Q?XhtR5MOZkfIa98JtZEg05dswry1m8N/3Z4JrVNiO3KwtKVDRGPoD5z9uwpYv?=
 =?us-ascii?Q?BbTUFv/fWLE7Jylo19zNIkO5w0DZuxIAcAI2yZCknjnj6CxBoAX+w6F6pGtq?=
 =?us-ascii?Q?PBRiT512jAeVaSmkSQ0YB8Vjll5wmddOAJuGJJitO3ezPrEPagE2W/BYVBxD?=
 =?us-ascii?Q?57DX3gIYL7JuCfZJwXaPfTp1ztP/eeukU8Lg32IJ0L4uwqNAI45KMZv/d3Y9?=
 =?us-ascii?Q?nlMM9tzbak3wkqld24c31wYk4+T/44MF0eKcEjUdQOnxWqTFM+QJWxv3LmHe?=
 =?us-ascii?Q?zieR0dUCkJ7ckIx0aJ3wzinMwVDTpkww/DQYGh+kNIiD/I2qXm3crwpGezng?=
 =?us-ascii?Q?fkVtABU3EPUa8u+qEY5/rVqv2FaRhiyGbEeMh5Q9kPBJmprjxfWaNlpcYZ/i?=
 =?us-ascii?Q?jXZyyJN/FrgZHTCw/KMTZvvwwqD2GfZA4sCX3O992JsAdrTDjwBVhbdWECj4?=
 =?us-ascii?Q?W5LRCkYFEhsHDY4emAcZwjAN08XsTW+KNt5GaoyXqUt7TZ3Z9QXU+dJUrySO?=
 =?us-ascii?Q?oIoKe6OzWN8Oda8vZEq4951N74eIE1COpzW0Y/z3b4pKpsrjOMOvpA7As7pk?=
 =?us-ascii?Q?QJeEyHBzpAYr7CmxiNCWcvNBh3wf2uv+hTROQ9VOb2HcZPz+nstqCHxnctHc?=
 =?us-ascii?Q?JAf3MnZp1SosaYHezLiUUeUZhUSYdQ/p2yYK7df1+fp36GNQ1r7Tk5En9NB7?=
 =?us-ascii?Q?+FVqxnNNjpZRuXHW7KeKBaWiMT6jE7SaHJi9FpjMBEc53n+DWhDGOwRDBdFA?=
 =?us-ascii?Q?c71k8wuKaSaKwhUSYyzbrSusGuTE+uhtcQCR3EY/bPPsruKBH47W6+sW+Cmh?=
 =?us-ascii?Q?7pS5Me295n+kLfgdtTr7/9P7D+0bikDDuID8B5Geus1JT6DpTsrxbB8H9/Tt?=
 =?us-ascii?Q?BA0sD78WfNGcVF7LAZaMBj2hEF0pacjfue0M3+JH9g70UDzmpCgKMU6x6k3q?=
 =?us-ascii?Q?FnaJXwHImIMYPuCTMlMT+8WqQ3SGjq76X/kxkLdBNsU6R5GYDpwAzIYoTcm8?=
 =?us-ascii?Q?g3824bjhua4XnPS2GwZRkVArrwVQIcaz4CLStNMMxbEN7mNk98Ufx7ai503H?=
 =?us-ascii?Q?m1vOY1WjBk6apCzTd+1+whgOsbvECkW2EPy5fjWB7XeM0AuP0aJ0E/yxFWf8?=
 =?us-ascii?Q?wbISRBaO5K8Bx5rzbBIpoyTnge1CFuChjW7JTZKQv4yWL1bobnjOaoeAc0OJ?=
 =?us-ascii?Q?DoMSQ+ZU5mjhsSnbb0dNWOe/AxXFFHEUctEpxFsMFq2zBun53bwO2T587Ben?=
 =?us-ascii?Q?oHKkeIV1D/YRxVX7y+3O6R9KJRGPLUijghDXh+m645vJB6hJ82Kg9GL8OULe?=
 =?us-ascii?Q?r2C+qpsLruGdYTB96LVmC/+gRO+XIEuloYKtJ2tWzztt/gnFVt8/xpYZSRMc?=
 =?us-ascii?Q?KIBxoPHrvLkU2D7cAsIENQzice+ZJkDY6WdSptRU?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68432436-66b5-4a2c-1184-08dc9fddee5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 06:11:11.4842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W83hTTYnm7pbLwh5hRO7CBrOZ8i8u5UKRsiFp3LQdXUtPBnjE7uBxGECqsWCVjDXUuuu+JRQvzyxGTo5SXfa+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9691



> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Saturday, July 6, 2024 2:17 AM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>; Jonathan Corbet
> <corbet@lwn.net>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v4 5/5] firmware: imx: adds miscdev
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 7/5/24 6:52 AM, Pankaj Gupta wrote:
> > diff --git a/Documentation/ABI/testing/se-cdev
> b/Documentation/ABI/testing/se-cdev
> > new file mode 100644
> > index 000000000000..97a5b2ca115d
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/se-cdev
> > @@ -0,0 +1,43 @@
> > +What:                /dev/<se>_mu[0-9]+_ch[0-9]+
> > +Date:                May 2024
> > +KernelVersion:       6.8
> > +Contact:     linux-imx@nxp.com, pankaj.gupta@nxp.com
> > +Description:
> > +             NXP offers multiple hardware IP(s) for  secure enclaves l=
ike EdgeLock-
>=20
>                                                      ^^^ one space only

Will replace "for  secure enclaves", with "for secure enclaves"


>=20
> > +             Enclave(ELE), SECO. The character device file descriptors
> > +             /dev/<se>_mu*_ch* are the interface between user-space NX=
P's
> secure-
>=20
> Please use "userspace" or "user space".

Accepted.
>=20
> > +             enclave shared library and the kernel driver.
> > +
> > +             The ioctl(2)-based ABI is defined and documented in
> > +             [include]<linux/firmware/imx/ele_mu_ioctl.h>
>=20
> End the line above with a period.

Accepted.

>=20
> > +              ioctl(s) are used primarily for:
> > +                     - shared memory management
> > +                     - allocation of I/O buffers
> > +                     - getting mu info
> > +                     - setting a dev-ctx as receiver to receive all th=
e commands from
> FW
> > +                     - getting SoC info
> > +                     - send command and receive command response
> > +
> > +             The following file operations are supported:
> > +
> > +             open(2)
> > +               Currently the only useful flags are O_RDWR.
> > +
> > +             read(2)
> > +               Every read() from the opened character device context i=
s waiting on
> > +               wait_event_interruptible, that gets set by the register=
ed mailbox
> callback
> > +               function, indicating a message received from the firmwa=
re on
> message-
> > +               unit.
> > +
> > +             write(2)
> > +               Every write() to the opened character device context ne=
eds to
> acquire
> > +               mailbox_lock before sending message on to the message u=
nit.
> > +
> > +             close(2)
> > +               Stops and frees up the I/O contexts that were associate=
d
> > +               with the file descriptor.
> > +
> > +Users:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
> b.com%2Fnxp-imx%2Fimx-secure-
> enclave.git&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7Cce675eed648
> 24848da5308dc9d33ae7f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C638558092493138985%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> %7C%7C%7C&sdata=3DfJ97U1mUja7gSpb%2FE1GOx6JdsYpfAUf9rnTuul4TOHs
> %3D&reserved=3D0,
> > +
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
> b.com%2Fnxp-imx%2Fimx-
> smw.git&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7Cce675eed648248
> 48da5308dc9d33ae7f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C638558092493147090%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C
> %7C%7C&sdata=3DoH0zIc2YQeERpc8lDXuyvQsGMtKjKZSp46t6X9irntU%3D&re
> served=3D0
> > +             crypto/skcipher,
> > +             drivers/nvmem/imx-ocotp-ele.c
>=20
> --
> ~Randy

