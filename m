Return-Path: <linux-kernel+bounces-218618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A2390C29A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098FB284205
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4878A4EB37;
	Tue, 18 Jun 2024 03:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WH37IzcO"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2062.outbound.protection.outlook.com [40.107.7.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E6B4C6D;
	Tue, 18 Jun 2024 03:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718682822; cv=fail; b=Gm4+zYIt4sgR5s0qaE9SCxg/c/K6p+qSibG5eBtVsrvmPnZwOk7V224nREfuIIkzCs2h5IoMHctHfG9EH9dEh37aiR9ZBmNT+DyXRM+3aMNZ6LkRehIHs2VY00UmwgX4Rl8jo8Vjh9JlQHoexQ5wUvPfyIeXR+LkHnhA4f3ky+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718682822; c=relaxed/simple;
	bh=t9tgrCxFvW6tQx7yuEKqMNCDBtAtudsfclxZMuiVg24=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4KHOtWgZRu3CaEO0xXf6V5ErKrdzMtNnmT5WT+8ijeoEEmeLkmAcDLHIvYiqWgTe0nZamsoRA+Lp9CjSsErIwobHhvJ/ou1wh/juEP6IiAtGI2sEo6XYi2+lDLrGUDDLxtlMn8aK2392HX2s+3Z/gPn8/uAJi/xFqx0hdco7/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WH37IzcO; arc=fail smtp.client-ip=40.107.7.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2hWHqDEd5EAysIasj0XZeiPW6iw6jO/6bh9EwAymkosjQr8iyq5PFgRgnLjEllw0ZW6n0J9Vz5SeTRm/UqgV87TNRenmMJHztnSfk9gzpHehnRASyOdWSRvKlMly2/yndoybHqL3zkUMg/JfqqRe4+NpWn++GKvK0breamrV1cQ42RzDd7JQNpEYxc5eb5OYiMbQbFing4YZedzTpiXh02DRiFh+pg5dHn49tCCDjmUH6lL/56VVB/o0PyPqeR1Nu/Cj2HPaMrW1AphB+NNPLeOv34ze7qR9SF4Q12YHpYE465Kn2L9b39HKECAMn3nVSIKJ7+mmhDmdmv+/8irpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9tgrCxFvW6tQx7yuEKqMNCDBtAtudsfclxZMuiVg24=;
 b=BH21hWZW4igDtruATWGEtaAHkb3LehsE7JT+HEv8IMM2a2u+b6btd2QlCt+S12i5d6hW9OzIm5Q3e0iA2LqkhXCNrrnIVTwf4jhkk7rhwoq/PkDHUn7GoPLQrg8QpY0jK4F6AbTT4ffkYdB3GN1WGCqyQMbpq6FGJDof3ZqLQVWvMS7UCsy1NCDA2gAU7UKky2T2IEfxfCTmNrsF2plwPrOT/dY9NGo62562awWiLp8BYtdAYX8UJ4ou4io6ye8i9aGLDsF6hiSNklPWRHGo67chmVMEFIN1hCcCBBcY+MDgppuaQU9Nbg+AJiIJEFmwL8OYjiRBw4jjUql20Y3LGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9tgrCxFvW6tQx7yuEKqMNCDBtAtudsfclxZMuiVg24=;
 b=WH37IzcOns+dpQGDikyuwmnXLhEthKciHircgP444xcYE/BUd4pl+m3dQGftLn/R2kDDvRzZZZd6j2lzbDquZqS+yNO5mYHh4AzzniH17jBoX3nVr4MIjrIkOMH4aGbNVV2wt8Su+8wORkr9gOJaipo40befsgEoNOrO2zPd02Y=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8832.eurprd04.prod.outlook.com (2603:10a6:102:20f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 03:53:37 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 03:53:36 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "open list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] arm64: dts: imx95: add '#address-cells' and
 '#size-cells' for all i2c
Thread-Topic: [PATCH 1/4] arm64: dts: imx95: add '#address-cells' and
 '#size-cells' for all i2c
Thread-Index: AQHawQYaJfwSMMgdFEC4Q6p1NOG50LHM5ACA
Date: Tue, 18 Jun 2024 03:53:36 +0000
Message-ID:
 <AM6PR04MB5941AE774D78C2E76DAF6A0188CE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240617223100.1539796-1-Frank.Li@nxp.com>
In-Reply-To: <20240617223100.1539796-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PAXPR04MB8832:EE_
x-ms-office365-filtering-correlation-id: 561d98da-ddda-4526-3bab-08dc8f4a3b7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|376011|1800799021|366013|921017|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Xu+JcaMxC21YfU9oefR3DWgmlhEEKU3IYqHxU13gmIuNNNujzLz9S5kR4Sjw?=
 =?us-ascii?Q?xCVu6dXXN++MuQA8P5GgQhk5F9euz/n29svo2Q5NqQq/LSL5vrk2BGKMPf2E?=
 =?us-ascii?Q?w66MTx9hcxWWLfJxb2akpNOojDQECn3Z7ntPlz925rc53OEfrxnca4d7hPKI?=
 =?us-ascii?Q?Powmatv56npPHaNiEcUYY6aLXr+yFl/6kfvp6WSr3RvwcYGbZa8dVJWlw92k?=
 =?us-ascii?Q?ykq6okN0F3NAKtniduoRc3LZOp3avP4YdiLkGS4Io8z2Wk8T+H/bY61m/ZLN?=
 =?us-ascii?Q?JOSn5146rVil06pGlCN40VZgHxc46sS4c6XdInygB3ghXJps/iZdcwDRRs8m?=
 =?us-ascii?Q?R2qsj7pfSvNUCceeijpV3Oj76RdWyMo3/mKxJhP+mTgRc5scilWVCEh9oD5X?=
 =?us-ascii?Q?6OKPRcbhqVbT/ld2S68oOcv4g/QQwdo2dFImF9shI2FY4UGTYpQlOuwMKtV4?=
 =?us-ascii?Q?H5Hrm74PV2LzeW3oOUUkzCIC7m1iC3fYF+eWC+eHC0vZStMkzDlXAHXf/d4M?=
 =?us-ascii?Q?W27BtnZ1W841hsrUFaRDZaCC/NNJak+inqJLyBDC9GX7MX3Mf70k2gKPhyl2?=
 =?us-ascii?Q?z50fi8YCD5O1sMF6tWs2/UIwDIq4t/a+UOnnE4wBT8mUIZhyhLnbWI/wpM9E?=
 =?us-ascii?Q?M86UyZhQMSVHSBWsBNE4cGHd18sL55U6NhbdIYzt4nM3KGle5KU45+uTmxga?=
 =?us-ascii?Q?4egfoPUV6DM0WTKPw2EXabl/RM38zirO7WviGBbyXvS3jOPA5xgL+UDbIttx?=
 =?us-ascii?Q?bEfjg34NDfORkzabNkNs4tM7M8m3d86phhL3sarspyjOhG62mzLBx4ZxQjqB?=
 =?us-ascii?Q?o8HyxvIezsLpGze7+moaWUxsa2GfmzDptb3T7PgaAShLfEgUL56OPMEWl19T?=
 =?us-ascii?Q?2On+Z5x9ixcQkeLfrUgry41EOIkpS+b/xRz7xyAnTUKStfIIfPTCjLpaf5bh?=
 =?us-ascii?Q?BmSoiNpn6GtU7P351pNl/VmnCoGSBPtkYoBAijslY/wlo+NW7bGF4KNC8h4y?=
 =?us-ascii?Q?vUznrVzuwvcJHQCsUwbQs8uq1jQp02Kex8wYKbhXkRMv6G7+EGKdpOD7aNRb?=
 =?us-ascii?Q?QvXQ/G40zu6GDfCEf9oMp7GtGwQwgyQLOWUT0ipRxhwRxghzDNLP/iBAdr4H?=
 =?us-ascii?Q?uhCDfHtZfmQrbKhxqPjv559+IckbRJgI4JWJoliT6rMgRqXuGGTe8or9BxP2?=
 =?us-ascii?Q?2Bh8maXK/5EvM5NIa2o8QIzl8KcQdD/UFCgy0N7CmSPadSsHJWME0eILcYim?=
 =?us-ascii?Q?BRdXJG26BF1QI3ekIfepBAlHkzaThF0bAOCazll6kzS6L6o9WjbipI2xgin9?=
 =?us-ascii?Q?cG2CIw471LilZhkfd62UdE2X9Cu+GCVWqdufYffp/S5n+CROkHPkpg6GVbKO?=
 =?us-ascii?Q?mTElxEhxq/xR7sNjaeDzt06jX8Ft?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(921017)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?a+inoM1N6yoUiYOQE/hP1ShpLRTrJpUq/GZDQhe9ZsB6QyA0InDO5+6+guzA?=
 =?us-ascii?Q?OWXNo6SPm29ZqhznGx4mIAFDcQE7PK3JTWSUeI09k6s3e+O4vQe0enOGADKl?=
 =?us-ascii?Q?REXHb41c2J2iaMIdozGP4b044eLX59XBGAk/5qQbc7oSPEx6ZbqipP0JI7fg?=
 =?us-ascii?Q?DkeDTTrk1/t3FgrgFuDd480sUAGmC574vbl/mQsW5dCtm1F6cW9p/e4jMCcW?=
 =?us-ascii?Q?mlgA3OS+7apdjzOp2XbR7MjuZuETrzuegZ0T+GVHlHOip/rZKAZo4vkdCPKG?=
 =?us-ascii?Q?KMvfWGtZVE8Yl8KY6/sMiQyaYsufd7JBLiSsH/Fh1nB4ACgHQWrRkRcfVzqU?=
 =?us-ascii?Q?ewTz4Xb5by3wDf+WyL65PV9OeOpnbv+wlUgtF+9WStbRA+bl6SrUzNl6j9k1?=
 =?us-ascii?Q?sdRHB+Ted40Mpd0OAKe28Ug7MHF9K3EmguGvnWvIKBdjoN46TECDMJjh0PlV?=
 =?us-ascii?Q?gstodi8fkaqS+tyr9OtyJSI6Tq7DbTx8n0RE6zy/I+gtwQoapEegUKZwh8iI?=
 =?us-ascii?Q?oZg7HX0duCJU4/u6UrAhO2ATcirbHr5Y/0gLdkNfD+fj5rvcC3SArbDjFknC?=
 =?us-ascii?Q?NzO5enA7Z+93J3Cll8btdXSykSfJltSb2nb/GLnS72wzwKtW7aYiZu1P8XR0?=
 =?us-ascii?Q?vtywMiE4gS1Iu5L9Py7KJEDNHf8E5j7M/y2JDOqGvM3GIgdir/vNAXbNmT3D?=
 =?us-ascii?Q?hz15pm2j+07tg94jKlfHy7vZemuwr42+I3m8Nse8EaJnI7sp+INo7Fh2kTcD?=
 =?us-ascii?Q?KjDfjHgqp2y5SqLht+TrWc5JNAs3qYiaU7Tv2SwvaEciyo+HD8M69pV4m774?=
 =?us-ascii?Q?L2A78vnZULBuFMyfY66BIJILb1zzFlv298KMZMU92UlyeMwoV5Hcjm+oe8b1?=
 =?us-ascii?Q?F5JzE4pv5Sn6H79g5q4zydvvVHcTaHynseLxwGKNHFZ9O3Vy6JiZQVCmRgv8?=
 =?us-ascii?Q?lmICBmxdL7eYmezwDcAabLgF03c4tzqZ6x2YsiB0VAei8MyXKzd9eEa4igGC?=
 =?us-ascii?Q?bhR8nvyFMRfYroXWmuI8ZXiuj0UufVUJTDtGsS0kNGIGt3XTpRpTYKY3Fr3N?=
 =?us-ascii?Q?8o4ARxM/4jQ8FxulXN74k9URjMAc93S3ZiPb+eu73TyGQoBbGS/KV8kLz7An?=
 =?us-ascii?Q?+fGxMxXg8aswCa6FlYA6+cMHpHW0OoqxoZWspUMFXYcBvXtEJASV6BFFxQni?=
 =?us-ascii?Q?XpOQfCMMTKVAVJl4u54wAPnaelFra4ccNvdLh0uy+vzKhDuC5qDREUYWMtU9?=
 =?us-ascii?Q?6cxhImLWTJaSI0b5jf0QE0TmNJqrbtFiOTP1EYd0mhc6TXMqg2jo7w4k5y83?=
 =?us-ascii?Q?7uusOlJGvmqg4r5JF+EFx6WROMbhUepu4OcdSRJ84c2XAj3DbaadnyS/7Nk0?=
 =?us-ascii?Q?y1e0o6Q9S4CaXP1PSiDbWFo/KVIcBTDwF4e+jyPZnycde5x4x8O6Wj2zO14B?=
 =?us-ascii?Q?mHPwAf6WPgNA5HJrJ69dFuMVajgb79QpHLmsPF6sRf42cbM7SEtu7+9shQjm?=
 =?us-ascii?Q?X4mhfPDHWVuL+8lbrlb0Fv9F3ov/kzeChrKJes2FbmlDYETD7PE+cR11b8gm?=
 =?us-ascii?Q?P+Y+MOqtpzeEh6+zl5w=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561d98da-ddda-4526-3bab-08dc8f4a3b7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 03:53:36.7820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NhjV7F4O7XbkgWRG9V1h1BceLFkFgR5mFkCZCO3h+QilE/hAoJykNTlGwg957ujKx4uIuo8DbMr4doIm+sUUJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8832

> Subject: [PATCH 1/4] arm64: dts: imx95: add '#address-cells' and
> '#size-cells' for all i2c
>=20
> Add '#address-cells' and '#size-cells' for all I2C to avoid duplicate the=
se
> at every board files.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Regards,
Peng.

