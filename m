Return-Path: <linux-kernel+bounces-318425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C1896EDA5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D36D1F22C43
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F27C15748A;
	Fri,  6 Sep 2024 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zfq2mLRV"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD4E45028;
	Fri,  6 Sep 2024 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610798; cv=fail; b=aDapjmsBTvlKNBnmUopTH3R2GVtJjXl9Yj4Nr0iMYqqXUefgNhiCxl05XSb73VhqOHwR9H8uaohfp1yiwb3y33fXnv1LMS1BtxthU7c4cqcosmIVD69kM+IKpEzVox4QmJjK0d+nn6WGMYZmu3FM3AVKNBeWqWcFRxnLdIUtN6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610798; c=relaxed/simple;
	bh=GV1GfE4yc6PQppnRwFf6SmPXKVITGXVxKvlGoo8pxuY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OlufznlukouBir7kX6/Q+zUglOBAwfkOKxS280pk31U9m33j63n5xnepz1g6XrkMI6PyJDrth+g5BYE95vYYgMZlGD1qUQlVh/ncwtlvtk/NkXAZqujK0aNuTOwm3XYdHj0YxVD3eo2cQlCvyvbl+2XRyBrH71JKAnVx5u3pAP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zfq2mLRV; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfSuHr+VfMfJdonxHa4zMDupXGh5pEnaB9Epulg06/WZ+Vncp5wyPX4AiUGSKnpuoT2tay51ZlW0LxpyGn1wYvGK40szkvnM9BKvNYn8IZOk38LS+U5Ws0mFSktTvAdYTTSNq1atMs38Kg3kqwWWRl19JF3V8JqkNN7whjc28sDCcvZ50IDTQD/WwkfwrWZc5or862NvHuEWvS06eEQG+s4BqNE7dSXq1NCt+og8hydLYlpUDOWIK9cImQ3vRM6Tm3glAFecuy+g+Y5zkw+mVS0MHRuIxLKoAZ+0pq3662Tg/ykuJodrYkFmVRI0+ZM3J8kdxm3OtaN0hMbt0K0S5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xw26pdpcdTSncFq87h2Elxv6bgISCUA44TEmAD3sVQ=;
 b=nI6s/gNvJbomXWxsUNUL8FG2I9g5pz8An9rmaY1UM7Sv8BihXHxPDLsydEhI3QaD9og1mFXH1DHMIm599+CDxvajfqX2jQioSkp0XBFO3sIbk/9PrvuGHHgqkJh7/0lD8ba8eGB9Y9mOie3j9lIm0ujAdmaPjyVzX8slcXLsJAcssTcdnPNN9rdT/0MbYOAvNuq+Q0aZSJW25zpf1xysicS11yj55zQaDCWFufQ20MiTtndYXVK+I+FZ4qg8lKdGH1RPjKuWMLTLj5Xcm5bEm55wWloY+tLlBei43t4C25DbUVDjlXzeDPnR8p8fsKcUBOUMs2DBnE44vXRBBb+NWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xw26pdpcdTSncFq87h2Elxv6bgISCUA44TEmAD3sVQ=;
 b=Zfq2mLRVW+IPlFGBE+wHStkx9YYSo3Rt9VCIaOzLl8B+6vmQL+W/0hspYELVTpMSmyPzqeZuqU7OBndg8CCXEgKIJPvEfbNz+1ZP8eI2awpkmisewyrm6uzlEgLXqTTO6bwhYnZzLeIne8kkzbHskIayTqu76mFqxNax4u3RPIvdUJU8rRNPWUGjLSsomQadH91OAc3JCIngCeVZZeaulBoubeecwYG9frlqwWgmxeOsbGcTvGizzM9Qme/ul9UrJC6e5S7wCzIxCZtWcFZ2/JNbDq9EVx3miew1PezRtBokM9AxqERPEPWCwFcLLktO11yQRzAKKWAWAaXU3mr0Pw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7711.eurprd04.prod.outlook.com (2603:10a6:102:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 08:19:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 08:19:53 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: RE: [PATCH v2 3/7] arm64: dts: freescale: imx95: update a55 thermal
 trip points
Thread-Topic: [PATCH v2 3/7] arm64: dts: freescale: imx95: update a55 thermal
 trip points
Thread-Index: AQHa/dArnYvJQvD7jU6GTifRv4mAXbJJIWiAgAFNX3A=
Date: Fri, 6 Sep 2024 08:19:53 +0000
Message-ID:
 <PAXPR04MB8459114481B327DE1065ECF5889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
 <20240903-imx95-dts-new-v2-3-8ed795d61358@nxp.com>
 <3587078.iIbC2pHGDl@steina-w>
In-Reply-To: <3587078.iIbC2pHGDl@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB7711:EE_
x-ms-office365-filtering-correlation-id: e7b03740-b711-4114-3a2d-08dcce4caf92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?oVy7BCsbUurUzLSwTnWIh+fex5lWWPSDmjlQwhkA43BG+Otmbq5x9T7QZu?=
 =?iso-8859-1?Q?3SKZZfM/zyUs5OQ0YnXT8jy4i4Tnrb/PqVbR69n/QCmZO5GJX1TdmLMqpZ?=
 =?iso-8859-1?Q?+W4GDzoXGhujlr2g12GuZ0ZRZ5L4VIr8I2mtenmTfIpZYImteSKFWGUhTE?=
 =?iso-8859-1?Q?AtVNUvQBqMXz9m5jtwWwQaWJO8Qxnac2caN+chyeeCEnIWjnryocNotdPB?=
 =?iso-8859-1?Q?ECeeeKG2+mTueUjQF0wKqnaAJc90cBeTg4P2A4QcuHgbqCB/7L+qH4oa7G?=
 =?iso-8859-1?Q?raGWOSUSrV1GCB9qv3J/i65Gpn1XCjwi/FCAMsjXeECLhRyDtYo2N418Ha?=
 =?iso-8859-1?Q?fYtTX+WYBTflcw2Y/hiFq/+ggeq76iC/45lHp/BPx3ilVX7K5YP5eSidiG?=
 =?iso-8859-1?Q?AHBJLg8vssxeEdZFQ/rbG8i4WX6D6oVespTzhbbMbQlflzqIz5lGquj089?=
 =?iso-8859-1?Q?jPagFHIq1USLb1fMHNCnFCHgvMHLEIPqMFNa33EdR3hjhiowwi4XDTWO5I?=
 =?iso-8859-1?Q?wvErhkO9Lpu/cr1Boi5N0CzBt7V7N6GOvuCff6rUCh04VIurI8uTkYgBPI?=
 =?iso-8859-1?Q?UlOnagOcLrTxUd8tXos1w7+snSB4ZeuQ8bxG6MeaFwpplTQisWycMv5Ju4?=
 =?iso-8859-1?Q?LCvXn4BEPFvHOQ0NzYJk+qPh1hwS+npml8UlbMwqHoFPUbxCYy+Aa0YpMb?=
 =?iso-8859-1?Q?tzM71VoGRNCo4gclkLzsf7NxoXOwvQpcnUgTNS6j8YEvvZ2Z9e57Y1CnG/?=
 =?iso-8859-1?Q?+1EGUCPbyhg5acvVHp9o6mD5rmQpoVW+EI6adcaXB5BuX5PUqsuYdTgt9+?=
 =?iso-8859-1?Q?zIhW1eS0GlR4lfWYE7ETxLLWjXgjF+WulsI8jmOm+ibS9+sKuyKR+YaHTh?=
 =?iso-8859-1?Q?uktIZfeaA0+EiudoV2/sIsHvGDG588hVFMK75+wOCg54F+yQ+XZVMLHu8e?=
 =?iso-8859-1?Q?4wW2AWy+eVQvc9zYdn+Cwrq8QH4drXLs4J4cCY+3BlKpzJHAKX8P8Wwpz3?=
 =?iso-8859-1?Q?WXn76L6cqIaBiB/zCpehcwEEFi5pkuI10Ws7spxvh/GiMJCMS3JhLjto0G?=
 =?iso-8859-1?Q?ZGGObltVVUmDon7y9/UtxPNodXCZwXF6h/SzV6EBXM6l3sNYMvf7UrpvdU?=
 =?iso-8859-1?Q?0Be1URA2Cpzd9g6thp9Qk6ArCqJ5fggNjNcRWmYguFZDDHginZiisNq5VY?=
 =?iso-8859-1?Q?9jcobWui/p54tu8+t3tpQ5l9jwsSXpZyZjFMzcEb5yaNXC17Usb3e20AYf?=
 =?iso-8859-1?Q?dmh/QBMKcfMaPAj9SQa2w08xGwE7H34hrC2zVJuccK44aO+zx0/oyRLVOL?=
 =?iso-8859-1?Q?o9WGPWxpTzxRFdwMZqp5PXbX36XpTGNwh6dqGU06C5iwQ42e02Ly9xnDde?=
 =?iso-8859-1?Q?aPlLiZNIQBLNcJju74KzS1psHiasUuqnoC+HqLbmBBg4L3Kqkm9CI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uRhxRm0xesgxGdlPfhR1yxWz5RWaTFKA6QEDEUnSD253DksgmH/DxeQ4UI?=
 =?iso-8859-1?Q?DDmTQ3uYo7XeJIM6p1qBmiCqMZzqUndeDy63dFdNpEPnHlz65klJU4bRKY?=
 =?iso-8859-1?Q?yPMEQU3TAsp0frVto45PLBpNyp5DvvOz71l9T0O9dLx3DvitVRpQb4OKF7?=
 =?iso-8859-1?Q?79fsiqczekUFOiza8gOYl8AX55rzQlC+LvigaLNnmWLaCW660KA2tLprpO?=
 =?iso-8859-1?Q?Roy3uL4lpEwvJBShBZehFb74+huTLRoD9tDx6M7J5KZXX2d1eL2Bu59MEn?=
 =?iso-8859-1?Q?Rsr1h+DSsd//HqeV/GobjIrQH3aATBxVifphbLolFaD1K0psxYciVD5Ubi?=
 =?iso-8859-1?Q?RXcgANbyFGoz33p8Ebx2K+x6lIZI0tsGXeDfm2rfdX7Uq3++isnpVD38Lx?=
 =?iso-8859-1?Q?ZYFs7OzDb7ydOG3Nz1ZpMvguts3VHy6VlpCO14uTSST+eKqRuNRD3ZoMGD?=
 =?iso-8859-1?Q?uonxJiXJ+k/PhkxXV88O88pcA9Jz98zZhn0HVSGaynNE2cdLo3al9na7VH?=
 =?iso-8859-1?Q?m3LiQUNuM+2Yep6B2Nkv1MYD//EADi5uGkHigufyjd0Ip1kyXr6Yy1LrlH?=
 =?iso-8859-1?Q?hONxYOKRG5hCBrxDzMhtlHP8c98yEEGbBGLjL4Yzov0xRWxyMWkQIzRAFn?=
 =?iso-8859-1?Q?RpQFJV0W7/orPcxA0+v7Bzeziohprxs8rR/9Fc4LJYjgI0QJA/KJWrpmCC?=
 =?iso-8859-1?Q?On+qgOoN6+uWBOlLBoVd5p3WaXph7zQRlftOb/6P6enHANQyASnlftQC5I?=
 =?iso-8859-1?Q?o72wlL1F1iOGCYkk4PLFy1Sw/CAgtLO4el4L0KLxKKmTwLko9rCjJzXH4e?=
 =?iso-8859-1?Q?DHLgg0AUIIysoY19rnr4VHqmcGskwfdDNVrlqs2L2MghDsQknzNGLEF6BZ?=
 =?iso-8859-1?Q?2pNTJ+3iSC/qktfk7N9xaJpsUU/HJ5hff4vCksNRKpn3N1nJ+Xzog9OLSo?=
 =?iso-8859-1?Q?mmGfFtrrPKCPqH6/P5JW/gMuhRz7f168njWFLrVsSsn7FG3zMHRehVqr6o?=
 =?iso-8859-1?Q?qRPdfG0Jw9LrZzLlYvho2rcAr6lKceDaZaIdoGpQDnf++vjwVNGN2VHfMO?=
 =?iso-8859-1?Q?LsZIuvspo8t05/Z9mTkQHOSLaDUEmgdNIVCBDvQS3LSOkkyKHG1NpcGrT3?=
 =?iso-8859-1?Q?QyMT/T+2D6/nyK4RmQWDeuFNV/vBH/Pbmph/pJVhcHROJPKX2ajQW9ADaY?=
 =?iso-8859-1?Q?T7TQrCUcZszM5f0LcP5nvoXGkVQiMwBAkTDJjP/ARsXHIjPh55YNg41vAV?=
 =?iso-8859-1?Q?5AtLuyi+fcVVRAM6gMjprIHNDkaKBzDD9MC0kKmPo/fett3HoUbJSjT9aM?=
 =?iso-8859-1?Q?8CxoEwZ7A4TRYCmcRK+EtU9K0Y30FjVzRcVbpN9+e2dI70mg5sHZ8NVGj4?=
 =?iso-8859-1?Q?djT4NjCQOudE1VLKD6BC8ShLKy41AEcgIuO9HOrr2hBclakdAsOCDprCII?=
 =?iso-8859-1?Q?RS1LBNRPjVAUtWk3itZ0ubtUUSRpe+O40txgWzHOXXEwUE2DPLkItenJaZ?=
 =?iso-8859-1?Q?kSKUvo4vd9vq6xsG2n0DvXJe+PoBH4ZLP/RU1tl7Fke+Bs+pDSIGMNFKcX?=
 =?iso-8859-1?Q?ymNMhgcIjxCeS22wTUHMMFTauVQLL32Bkfv7nDZmlInbRtGGJj7mnIhYfc?=
 =?iso-8859-1?Q?1jx1OU4Zijbf0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b03740-b711-4114-3a2d-08dcce4caf92
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 08:19:53.7682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyfdPl5W/9jfBbGmMb9iYzEPy4eqj0xPGjPjuZMuX7lbFplOVxx4RtslCf9Mjsg57+aQBTTtDwfI9pDzoKP9FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7711

> Subject: Re: [PATCH v2 3/7] arm64: dts: freescale: imx95: update a55
> thermal trip points
>=20
> Am Dienstag, 3. September 2024, 09:17:48 CEST schrieb Peng Fan
> (OSS):
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Update the thermal trip points for automotive and extended
> industrial
> > temperature qualification processors.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx95.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi
> > b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > index 314a45e82c38..2cba7a889030 100644
> > --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > @@ -347,13 +347,13 @@ a55-thermal {
> >
> >  			trips {
> >  				cpu_alert0: trip0 {
> > -					temperature =3D <85000>;
> > +					temperature =3D <105000>;
> >  					hysteresis =3D <2000>;
> >  					type =3D "passive";
> >  				};
> >
> >  				cpu_crit0: trip1 {
> > -					temperature =3D <95000>;
> > +					temperature =3D <125000>;
>=20
> What about commercial and industrial temperature ranges? Can you
> detected this at runtime? Is the bootloader supposed to correct these
> settings?

Bootloader is supposed to update or people could overwrite in their
board device tree per which chip grade is being used.

It would be better if there is runtime update by kernel, but no as
of now. We may use nvmem to do runtime in future, but need check.

Regards,
Peng.

>=20
> Best regards,
> Alexander
>=20
> >  					hysteresis =3D <2000>;
> >  					type =3D "critical";
> >  				};
> >
> >
>=20
>=20
> --
> TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld,
> Germany Amtsgericht M=FCnchen, HRB 105018
> Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F
> www.tq-
> group.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C1787566
> 643e742d9965508dccda5ad2d%7C686ea1d3bc2b4c6fa92cd99c5c301
> 635%7C0%7C0%7C638611358666637887%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DvL3HTTjWm6F6dRQD4Oek0nj
> UiY%2FNnkqDv5z3k846EdY%3D&reserved=3D0
>=20


