Return-Path: <linux-kernel+bounces-358783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11CE998395
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69FE1C234D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A2218DF81;
	Thu, 10 Oct 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RdXxoVKD"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B831BBBE5;
	Thu, 10 Oct 2024 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556295; cv=fail; b=soh0c7/7Nh2dKlemCN1/GTMxs3EDobNRcSJ2zgi8vTPpULBzOUMc7TZjcgQYk7IonrubkpJcBShnQ78gDgyZaMC8BCNLVOqEQ1NhjUjYM0dFdWhKeQkxzcc6h9ux7W+GfGolBzjS3WhJO07YoeiFPIv6QL4qZj/I0DBUHrAqRIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556295; c=relaxed/simple;
	bh=96xW+ldI5NYLXwerR2C0xeObOvUh/5zs3yBd8PPQxuA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=giXFO9pBVcNVV2Z7aiDDAaYxM6U5v2EG/czVLMUqLayXfU+AFWgBt0fAHf0suJ1xvKbc6WxUi3B5zE3Yfchm6sSR3u+EDypb8iuwosvkF23iVd8Gps8rf8ey2Kx3c5aWP+qk/kYQR+qw4ExMQT5aDgr9U+4eV8MUKK1NZ0CwjR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RdXxoVKD; arc=fail smtp.client-ip=40.107.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=li3kOLI9pb2EgM2hyOYOP96SaNlm5E5yxW1daI0VdPESFui9oOMat1xMcAbRmntmmckh8dPS5KhPt8M7dk2huUaffE2YhfmzwDP4YNotG9pN5MKMudOtbDoj+rntZH6xhRUCSocstdjztRzPOciGRgwPWIp9cK3W33U1xTw0bIQY6AOYqz2NmXPzHfbRdYSjKFN846D7zh5Uoz+nsnaXg1KbwZ++0T/VbW8DMjCgSkgTWjKMCQgapVkP74TkzKVr8MfE+BOMlB0manFGWM7V5G6LVqSG8/JzDl4zmexiKcFWVQNb4BWq5TPCdAUDPtkipHt1aVkNuCTeGonjyYYFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oUnrOxy0MPtEGZxiOwPkz6xqqHsnEVxYdPSQe7z9T8=;
 b=IR0jCYtG76FKSCD+PdAwtvGvDdA3lAVkDjZnUNjnQgYANutbu7kfENgiBcZGuadaykmIDZedTEcdTRTN61guqSUXiRb6//pbwzgJy9HvMfJ1wN0WgG08UVBhtAyZQKEdYD5b7ngmyUDw4FgEP/2OG1GjPSVy/GwxjlHKSUGohXtuq7ZPk1pkug+B+LTtlwAP2zw8J6RZYzKtkvORH+n3ly3yUD2W6TUq4IJCK8YB/0fFEKOLOEwLMQ2swb6zJkJGYg98xq8eqTGCKoSu7xUU/38IXZJwXWz7QnTWMXjDOe8k9qsTM559QEOxMz0LPc9+Qmn7tl0UCSNItIwO9UpsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oUnrOxy0MPtEGZxiOwPkz6xqqHsnEVxYdPSQe7z9T8=;
 b=RdXxoVKDVEn+0Aov1fdivpwaFUFHLEcPSDQs4EsmOc/MRNVN2bxEnQ5lKk1WEoLum9JFuYvdbP/gAR/VIk3eUursnb0vXwba2bkGI1LdvMXJ/aSg+mNVVow7DCLsiigYgdn1JMEAlxP1xQcIQ+ynoHUE2KucN0puKOHpTR1TZUPMeCfBg4qESsrOuHlfJUNtVBpVE2TV26SJdABsj7juURdBM3URqpHuabG3aSqu1htm09V40nqEiFWoesNDBUX27zA7sKHiNUeyB6rztbbz3JmoFnlJtlmGxlhzf1vgwpR3xx+t5wtWvYjfXetGlTJWCBOwKRyhhJ3RQ+k7XnCVbQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8462.eurprd04.prod.outlook.com (2603:10a6:10:2cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 10:31:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 10:31:27 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/7] arm64: dts: freescale: imx95: set
 max-rx-timeout-ms
Thread-Topic: [PATCH v2 1/7] arm64: dts: freescale: imx95: set
 max-rx-timeout-ms
Thread-Index: AQHa/dAmgIqhllF3PEyNax8jIP/dQrJ9BhSAgAL8lNA=
Date: Thu, 10 Oct 2024 10:31:27 +0000
Message-ID:
 <PAXPR04MB84598DE03F6BD7B4DC0C3BC588782@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
 <20240903-imx95-dts-new-v2-1-8ed795d61358@nxp.com> <ZwUq6/YHyRphZc6Q@dragon>
In-Reply-To: <ZwUq6/YHyRphZc6Q@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB8462:EE_
x-ms-office365-filtering-correlation-id: 066cee64-81f6-4cf3-b12a-08dce916b2b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?U1hL2DdWq7bOSHKKk8EUz0pkBKq3mwToATP1Bi4sPNbsjmlkzYN/GP0NuJJb?=
 =?us-ascii?Q?n55TsgNbs8NLOu5oAzBnlW6okJelB+aFpdCzP7LlDsXWF5p5bHlWl2mrPJmO?=
 =?us-ascii?Q?tmj8Rx8B8V+Qjj6Mr1mTEbyZEOf3b8smPV7Zv+AnquS57zbbU77bzXL7tVRd?=
 =?us-ascii?Q?oH0nY6/o5Fau7oDGzRXibIuqwfyDO6KZkj/CF2CC6D005G95No3Xy4vLoskD?=
 =?us-ascii?Q?ZyBuOBzZinplET53w76hCvCQiD/tq0yaMP36HJFnO/3xQWw9hSLrqb70bhyQ?=
 =?us-ascii?Q?vxsCnjWLXnRug1SvdZJStvAchMSH6b0o/QwbMv0T1BX5TiSP22yELsu7xICj?=
 =?us-ascii?Q?RLbQJNadN2vVV50eeV3k75nlMhVB3fDFfRaIllYCzDPX3cQfV9qF0tWMbDhS?=
 =?us-ascii?Q?lsI2wC8yCuAmMJCdSZJdpkg1wg1HWAEHnHuqlg4V8xX151SyqKAz7F+siXor?=
 =?us-ascii?Q?LTxF2Tr0Lt0fjE8KMZBtXZBYw8Re8GiCInBKULjCmVIRRyvJNysLKTdWs3oh?=
 =?us-ascii?Q?eg/rB5fHF5xjFDkazMj0+Y7Xu8/+OewM8w6Md6LENaMkD38P5ivjlTogsAnX?=
 =?us-ascii?Q?MwbVeq7kRnlN2sYNUIpziSj7ULsbsTLNxGaOubp9P/n+RSeg7LIjeMDZcScD?=
 =?us-ascii?Q?awdBuQWJfbxdsfkKKOl6Kc64GdqcZR2FHBuiSR7w0zu0be2etAr996Ixdkt/?=
 =?us-ascii?Q?pUm42YzD2XvUkTMSu/HAxSDCqPe7/5H6Vg13xUqmZ6oEkxSEfmeB+B+kKfej?=
 =?us-ascii?Q?gE+a4rTngYlH84i7MIvsPYkPuPlMJ8uDTleoYmM2XEXowe/GGU6Qn1yoNoin?=
 =?us-ascii?Q?YLD2Nr4ud3+imSS+suvo9STyI7eE/ROVvzvDEl9OsRfcsj41dSYrTaleOYhl?=
 =?us-ascii?Q?qRk72r0zH51trRtC5sG5AKEQ/7duaQbLp7kFLyoUc7LvnR2dtc3G1os8b0L8?=
 =?us-ascii?Q?MC9Pr+8qdQSCRjhhHo5xFYko4d/fKBpE+wLqb4HRWR5DsBmxvDvJlt0jTnXm?=
 =?us-ascii?Q?y2sj9iDAhzyDNCLR2FBCEIMrHpT0W7FSBp6K96hUKTEqH7vdfBAGbix5bu59?=
 =?us-ascii?Q?PibOcFS9NeuZZ9q2MJcBB8E5J0JclIwr/s4HZLe9NCwC0rirC+s1tFgL4HMp?=
 =?us-ascii?Q?Bk9fcHKKHHDjzpD1ivwelDvRDLeeWKQRAx4736wh/DGKMbnjB96RQyCVTkGx?=
 =?us-ascii?Q?O+6aPQN9nTNZJH5SWVt/O6YnlSUk1tDxPRURTht16uG8BjgdiyfpSY6qTOU1?=
 =?us-ascii?Q?9CW0AvuQ5OsPWdDImQz5KKc2dDiAL4wIwBgBnQsXs1mtP/ReG0vXRaW2zQcv?=
 =?us-ascii?Q?WXBN7fZY2aSBXzEBgRGAKCuES+TD/tgPRgYIjESF/j9YEw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gzhui6sSDq3Kb92QfaCY1udcMG5Xl4NBjZxP/edC36hd0LcX0LzQh9mcbLYE?=
 =?us-ascii?Q?4LTGMq9K2tF1+sC4Q25N6NxPhOcWgxxVLILZvXKYJrxl9b5ldVwYhvbzMiTa?=
 =?us-ascii?Q?8BnGmB7hZsWHE9v1AMB5F3jL606MTswW6PCmb/nRLvx8J3CK3jMs70E9pRLk?=
 =?us-ascii?Q?/fmnjCCk2dUufCi4tzWqcTBQMARJ0tM9MQQ2cos2NxMh6ruCgHCwYPpH4J2/?=
 =?us-ascii?Q?YW8IpP3O1O6Btlhk+NfB/nsqeQ1TlqXnh5HUpN50gjQQ9NgSlM0N6unlrn2K?=
 =?us-ascii?Q?479XY+HkJ77cldITLkPkv2f6SG4XvkkP5+Yz1KG+MiOVGyB7Ki6jswgjXgC+?=
 =?us-ascii?Q?IDrJUoFFqQwrrZ32jnMpi0gyVjcaFaX0NNKB/sg/FRrP3BeEuibwR/f9GuK/?=
 =?us-ascii?Q?aotNSNfgzSnMW3HbTPNXHQJabQatFDCF7FIzYEkWiZB/Dj3aGwpk8wfpNnJ9?=
 =?us-ascii?Q?G1QXu3LCvZSpik2JDRxfhVTVBwEEI/6jCuq60NIN1ie8Lgo4k52uou2JXYJ+?=
 =?us-ascii?Q?qYsUm5xBkCPvleorXj5k4hJyGAD9+ajm3pdLuuGNqdMrjYvHyrQHu3RjCmui?=
 =?us-ascii?Q?ziKL6AivYMJCtlMHap3x4hgrn8xEdBS8L72XCWpQ2pnRq05WnXnEgChfdF21?=
 =?us-ascii?Q?5KESwcXsvZKtEYvqFT7mCr5VgX4un18iq9fCtNAKKR2kSN5HYhohlx5AGoDt?=
 =?us-ascii?Q?Snc+1+6KLWahyvN/Qd3b9VBvZ4c3QVyGFagOfjVojBNymx72c8+kdKDEgECA?=
 =?us-ascii?Q?ynQeIFWY74J9mYGDYqnyImDYNKouPP6P730LYz72k1wjoX5FmfDGOa5kSu36?=
 =?us-ascii?Q?PgVNxs7XvyUclg0kr3uL6is3vTWD7EJuWgL4B/2HvDI5jrXnpxRlnKt5UAQu?=
 =?us-ascii?Q?S7A0+WllaD+xXLo+skF81/rBSx1bs6y7JAk/QhMAaVMZzZeRGrt/q12ClI5M?=
 =?us-ascii?Q?0Lr8VLY7LE96swYn8xNRVB0kkrmh2Ffj+lKR867nyYnmXz+zeWYbIvxrrDD8?=
 =?us-ascii?Q?qvbzfAT28xZbPJsljW7CB4o1sMUNsVe4NZ16BQC/HYophqbY+xnhT619BpSt?=
 =?us-ascii?Q?g15SkDN7Jc/4CD9tk0S40kPPw6lBpF/W4QMhCSFSStJFDasFJiTePmEZtymC?=
 =?us-ascii?Q?WYoJspXXGxgd1kQ3DIklfKW6PKcck90rzvuoVY4rQeipYB9TCU2CIg9PftYy?=
 =?us-ascii?Q?7GKtfg+HdiD4riDCU6uUxcuXMOuzK6GuJ7hMwAlSn5sMbai/L7dBkR+OyZZj?=
 =?us-ascii?Q?s88IVBE6AzVeAo/GvwRkZk7H3fcWNJZOf2gHgD1DfhgS6hi8UCmRjfd09OEz?=
 =?us-ascii?Q?4m87RfbMj38OBxgdQRafj4dC+QErLSBQcNU5PYoCKVCnrx45cYfz1cHhbrA+?=
 =?us-ascii?Q?JSSnKMSEYs4Xr6Wcs1fmftc4qaH0dSyKPhhuYBoKy7pAIOTLq8WgxVuTqZDH?=
 =?us-ascii?Q?+ceOUcvfRgN6zTa3RzpZswX+1S7vOTxo1vsApZytIbuLcEM7FD6QUaObjSGk?=
 =?us-ascii?Q?xD+rMpJOyzwP9srxNTw1ogEhKltVPpU6/PXIeta6fWrhAt5phpLrjQhPT1mG?=
 =?us-ascii?Q?/8ohVL1jqJAz1Pop2rI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 066cee64-81f6-4cf3-b12a-08dce916b2b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 10:31:27.6248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9lI3f1WI8x7qh3Oj/1m+J66YCRahV5bPhtL1Snfc3042Lx5vPeHKJN+GX5XwLDOBYPMfIrfNxcHNT+U+KZjPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8462

> Subject: Re: [PATCH v2 1/7] arm64: dts: freescale: imx95: set max-rx-
> timeout-ms
>=20
> On Tue, Sep 03, 2024 at 03:17:46PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > With 'max-rx-timeout-ms' property added in
> 'Documentation/devicetree/
> > indings/firmware/arm,scmi.yaml', set the value for i.MX95.
> >
> > NXP i.MX95 SCMI Firmware designation does not allow timeout, it
> will
> > not recover if the Agents use timeout design. So set a large value
> > (5000ms) here.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx95.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi
> > b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > index ecdc6b7b5129..7880d3efbd7e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > @@ -294,6 +294,8 @@ scmi {
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <0>;
> >
>=20
> Can we drop this newline?
>=20
> > +			max-rx-timeout-ms =3D <5000>;
>=20
> max-rx-timeout-ms is an optional property.  As i.MX95 SCMI firmware
> does not allow timeout, I wonder if absence of the property will just do
> the right thing?

The default value in driver is 30ms, this is not enough in some cases.

Thanks,
Peng.

>=20
> Shawn
>=20
> > +
> >  			scmi_devpd: protocol@11 {
> >  				reg =3D <0x11>;
> >  				#power-domain-cells =3D <1>;
> >
> > --
> > 2.37.1
> >


