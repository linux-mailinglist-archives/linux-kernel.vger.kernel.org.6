Return-Path: <linux-kernel+bounces-184513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1658CA7D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EDE28236E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0A444384;
	Tue, 21 May 2024 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gyclt1A8"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659076FDC;
	Tue, 21 May 2024 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716272201; cv=fail; b=Hk6eNVvjK+4j/SP6SHq3NxcxUQ8Kre4JgoOrXiHNKaLuq57Rzu6PEPgQHYRdpNKK2qcaMnTnjY846GpyJNaHLt8vY4pe5qI9tgj83bf3W9gdbuc7URg1LVLZg+7kPdKUSZkaXsH8kRprAUZwxCjg6JhZihBq5o10jWtKYIV//2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716272201; c=relaxed/simple;
	bh=llgvknnUSscsS945leOKYAE9OrEvd/BYcXXzkpQRgW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u7EN/X/S+x6+aotsmJhwrLaXiRJSjGjFiRRCGv+ByAOwNEMJDpCUGdhTRB40XhjWBgn/U7btnyjS+Ph5j/D/tWkG5yaIaDXDOMydhGIuSNcj/xe7sBGb18uE3mdQRYG6v3uaBOvgb4FexMa/kkCN86raXdiS3EqiWKsILwppf/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gyclt1A8; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRFR0kZgAdgUYKvlR8Gcf1/pxUPnBIRN1HYW20YTABaXMdCAinY8qOY3njv+lZAZPJuofTjaqUzYUxxv0YXfILBr8eXgnpMvWa34DH91HTzPbgZ1yYsYXWFuUWIwVBPcRRHIuNBZoY1wr3BUIcu9nes5Usd1MABt2J9aRWUONi4vd7e26IFEoaHptPyrX7sTvsqeImbf/xLbPR1TdAq1IESxzS5fgtG4QRVsNZj85EMoIlJ+Zi820O13qgzeA35rmCoBMF/ZwlMiyP2IEaVBN02p72h3UE6u0dtrXPTqJkw7q2BS3u/skhVCGaZ4pkPPBwMmRSrgxcRFqKp3MOuSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BJlh/vmiINWSJGXTVU/fi6b+czffPJjJ7ll5FYAzTM=;
 b=DMtMUtcAwuA0as/7LGl0Fij//BGSV7mdiGMTRgQt7GNw9mBZDiXo+dQq8oPJNM1oorXoxQTGps59iLKYeQ9gzvErnybeAN+ps1HZIymdThixGcY84BpYdbN7RAydFh/GO4s9wSbIDFgN5EGMOIzShRaxaIe14izGkHkm2a9Mxj95j18tV/aPYcUCLCRmaVU8w5WjpYJmNApAjLhPcgIJH1vMtmUm+1YSojw90Vi/hL7BR74xYTNuloulDz45LiF1g3xheALXzD+xvaZyOMr53b/KzKPPx+iO9okVX7GjA5o5vDHd36FVYHeTtwle68ybjQSzxWovz6+s91gvDx+jJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BJlh/vmiINWSJGXTVU/fi6b+czffPJjJ7ll5FYAzTM=;
 b=gyclt1A8l42psPPjwLHozfpDYAWXmzNF0jVe5etHLoy7V9cJWM9/8QLGYC9tGeMr0wrvARaNtF90k298ubQZTadcWev7lDY/s7+KjfvThAsQG7pRfpXWIZ7g/QWY0Z/LbsCL57YnHm0atEMiwCWBztVC0+kYZwBWPWTyf1hnP2o=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB10705.eurprd04.prod.outlook.com (2603:10a6:150:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 06:16:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%6]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 06:16:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Aisheng Dong
	<aisheng.dong@nxp.com>
Subject: RE: [RFC] dt-bindings: firmware: arm,scmi: Add properties for i.MX95
 Pinctrl OEM extensions
Thread-Topic: [RFC] dt-bindings: firmware: arm,scmi: Add properties for i.MX95
 Pinctrl OEM extensions
Thread-Index: AQHap2GnfejXD5kEE0+8BtjMQGjwtLGZ7zuAgAdOqrA=
Date: Tue, 21 May 2024 06:16:34 +0000
Message-ID:
 <DU0PR04MB9417CB7E2F36A56B0560B16B88EA2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240516073012.1699795-1-peng.fan@oss.nxp.com>
 <ZkYa3VAsLYkxhWP7@lizhi-Precision-Tower-5810>
In-Reply-To: <ZkYa3VAsLYkxhWP7@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|GVXPR04MB10705:EE_
x-ms-office365-filtering-correlation-id: ef5455d4-589c-4528-2753-08dc795d907a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CX8yVOPFO9mCjxXbEnEd8juTqvtZ9z8nBA/RaHiOlvEMLaGiwndS2BCewQyN?=
 =?us-ascii?Q?wvsJflWuFfeDZ4p8JoNIHiTBx11Enh4h8M0nlBzTYhQuIX5M5/nJvItCeG8f?=
 =?us-ascii?Q?W9X+0aHRDikJILVJQg8rMIyVaETWIE2VW4qFyjn8/HQ8bWtNhDicQvX/XOyd?=
 =?us-ascii?Q?oqE03vzf9xNe4P6qRGJZuVpYXpnb4UeDVqDIksXqkxzojE7zoo7OVzKFDB7p?=
 =?us-ascii?Q?3sfgFCZtG6bM4lXxPcg7bTG7mIeFci9Qc0NvbeJfkq56V6zD2cWc0EUnUNeB?=
 =?us-ascii?Q?q+Un4ob+B8pnKJmOTguv0QK9GGIlVjb6arkOM008d8aDyzHyOrF9/sPpB6IQ?=
 =?us-ascii?Q?X+c8By40+Rhxo2M94PDj0oavra9v5eLk2JJ8gv13yjHoMJzB2RxB/mXqdeBV?=
 =?us-ascii?Q?VP4mMelsqnUUqyo6VTq6VuY4DOjRNkyUPPzyDa5dLUYOO8GbeBkMtbBevdrT?=
 =?us-ascii?Q?oecdIqu8JbUTqn08pcvc9HCineglEdpEl3eIB/za+e6sy4Y9/9iEJYb+LwEX?=
 =?us-ascii?Q?6I45UPycrsOf9H4a7G7/xNav3wItTPwypXmRGqFgvzF3xl75DnJk3JpND1AZ?=
 =?us-ascii?Q?TV/q93YH6bwq9syK9pJ2x5DNrZL5YpPDIxIv2mhSnFw6jAis4/4u7RccWlhF?=
 =?us-ascii?Q?6ckL3d0Srn3Zp/2i41dUEiLbpXI9Kd48LoUNfm5nMIncYzE0aUFxSHminhVc?=
 =?us-ascii?Q?E3aqrEq3Y3JNUByYyNWiYp2TV3zZAJf8oLxlM352ZToqid5ym0X/66X4DHk5?=
 =?us-ascii?Q?bghkD3nSOeX7PI0V94dwxjMk45nTQ7J10Pi3kChzQ0k82d+5s19LxqL5BoJy?=
 =?us-ascii?Q?D04wpbgU0jhEpNo/KZaFccmrZELFGZApQOqz6dPOAvacnP7remLlSwG4MhBG?=
 =?us-ascii?Q?YOydgpgjtAzTawLN11jkgQLQ7QhR+YZMV2ANt4Ql+IGZi+J4NbEW/t32ZKpQ?=
 =?us-ascii?Q?siyqumpbXkxmHjnoJoSCjMlO9NbcmMG13y2Fbf+4/eLHgZSUJ7sZII5wRQkO?=
 =?us-ascii?Q?Jxs3QVALChxTJxOq48kDrTSlexgl1KRC+cNKklAYwUwCfY7DJdbQUy8O7WsA?=
 =?us-ascii?Q?hFYys/sOoY0Z8rptHu9qV6FH40qxiBHOXqdNlyE+CpHq0p8QAYsgNzti2K8/?=
 =?us-ascii?Q?RDeKVNLJTD7lE13cJJRPzvnqUs7L9LxcHvt70v71clqICjiEFx9Epehzv0GZ?=
 =?us-ascii?Q?Twbli26y5aNE4hWMx8kce3f1wy2RfQbtvUYWf0GIrxWqm5QWxhPu2/LWPwXM?=
 =?us-ascii?Q?ko1wHnq/eeTOjyE9U65LnC6tsR6rk3Rtrc7WP3hY0g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Wf6XAv7DK07Pq25BeAFyj+XARDJK7OKZ6WCjuXmKXz8kHYjKDCzICHbYWqGW?=
 =?us-ascii?Q?6uzPbT2EMjH0FeGLHNvmz45I6ErsuYDUwH/jJZU5cODOBdpbOmqUvrlIsCaU?=
 =?us-ascii?Q?rzKj2GjNu8JDl1vHKeIluKZu1sL1ml07qMToVM5IbqpZoh/0xvXKTj0paAkp?=
 =?us-ascii?Q?1z3t8vnMM1rGclYe+vM8U+F1/EVcAaWH8ZU73rncqzx+bL3Ahl4ssedBlHzF?=
 =?us-ascii?Q?4q2h+xRzEW5RVmR46+6Uy6qB7BJ12t+0cAMKFZIbpGdEf65glk8JdoZS2qpH?=
 =?us-ascii?Q?2wwYeJkKRWSLczHCxpih+2F5c7BRlf7OTubiJVrG+tVHQoazBX2gD3IAEEJN?=
 =?us-ascii?Q?sSzgeoWiJrORTu0VyzzxrX/en4A1Y39qYOL7cpA4VunNiDEzb2v7NRDyZ4wW?=
 =?us-ascii?Q?WU9Oj5pu7dOQeLG5FFcmjqXMeIUUIau0iPbzy0wcfbeyAQ9myRTWjZFXh+jO?=
 =?us-ascii?Q?ZOWXjunLE9C0HFllZlA93bkeZY6nRhWXSxUFyR5MVKtVfvZCPiicKKdFXkts?=
 =?us-ascii?Q?Tek+/3QNumh4TtlG5vq/ncUofzhtd71j+tDsazTt+gzxSt4Dk1GVcLB2C8gu?=
 =?us-ascii?Q?8eVQ60OWlGfEJqtGBFRyCX6XKnb/BIrBEOf3F9CWHCJ2P0kMT5/fKP5lNi8E?=
 =?us-ascii?Q?LVNtM2RhNhnw02aTsYHScCG6JjtGFkAZF5oTyjP8d9VOISNa9gOewzuQrcmd?=
 =?us-ascii?Q?ChBp86oJnY/SZ/AcFHdfIMV2xny7diemJe8yWfGLXrKe+xkX793f98xzzq8a?=
 =?us-ascii?Q?T12/V4OPGjROJt1d2G29Ao78gHLyo9UFeKIGNMiJ9qB3gn9jsSW63vCPphqI?=
 =?us-ascii?Q?u+marouIstk9a5k2ZZF01451Kjf1GYSvNqV2zjCOZq8+x7T567ZK2oBPClVe?=
 =?us-ascii?Q?vNNPnMW4G3m/EcxnjIculeNsro/yxrWPChMtKa66hsUq3aOV14jVIwZj9P/c?=
 =?us-ascii?Q?yu0dptADmzHT5sEEt3y3leCoiBuZKBtC9w0pYTzllKIxETMZia0Hb4FXgyPJ?=
 =?us-ascii?Q?3iB+UM+dwt2aI1ossDT1YUfhzyiVqoWPSNbmL/sk+ifiABkugiygmw3fs6w4?=
 =?us-ascii?Q?m3H8ibt1k4Uvi8G9kGKaCP33vyUWl5KrGidnCPIUJrt3KaUt1iKOK8ys6dQI?=
 =?us-ascii?Q?9UlyIRx9YZwSw/LWEGavABCt/3WtRaRmSzoO6QtsNWa0rCXXViTVhXo2r58Q?=
 =?us-ascii?Q?LS3PA3C8FbSXvT397NHw6/GtsVLoJeY9wndV/no6UwaXcmGCl11o9OokTem2?=
 =?us-ascii?Q?02FbJsrjh+sVfyjR8nkdpZXlBvNeqwIajUjzlQ6PmreM+eZhDdEJusgroIww?=
 =?us-ascii?Q?BdQQuyHAP2+KBXdfCJECi6ZQ+hY1vcDS8fiyiYTLP+kbSDSZFWQfx9wPMQuo?=
 =?us-ascii?Q?A976aGlb5SeU3IvLQYU+AkPprlbt7VoK9snG9ju03h2CGFdg3KiaW2rRCbIR?=
 =?us-ascii?Q?EvRJIQoYI3aZavnu5t4ZawnSNTRSwwKLSGGwWQx7J+iRoEa3ryJ3nIUtBWc8?=
 =?us-ascii?Q?EC9RX6J7n3eJYu47Pl7qaNln5eHXQ0CRda4K6/Y7/eBAewvjF5XPREJXUsvD?=
 =?us-ascii?Q?AhEdCwX7QTzv3VBhjd8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5455d4-589c-4528-2753-08dc795d907a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 06:16:34.2023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IhmGqngEKHoBlqcZ4xYUEH5g2+KGRLo9JAKkyPpydm6OSXbpiOS0xovcu2wZYXt+nXLhHUXIPinuichFSrjHtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10705

> Subject: Re: [RFC] dt-bindings: firmware: arm,scmi: Add properties for i.=
MX95
> Pinctrl OEM extensions
>=20
> On Thu, May 16, 2024 at 03:30:12PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX95 Pinctrl is managed by System Control Management Interface(SCMI)
> > firmware using OEM extensions. No functions, no groups are provided by
> > the firmware. So add i.MX95 specific properties.
> >
> > To keep aligned with current i.MX pinctrl bindings, still use "fsl,pins=
"
> > for i.MX95.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V1:
> >  There is already a v6 version for i.MX95 pinctrl with binding got
> > reviewed by  Rob,
> > https://lore.kernel.org/all/20240513-pinctrl-scmi-oem-v3-v6-1-904975c9
> > 9cc4@nxp.com/  But after NXP internal discussion, to keep "fsl,pins"
> > for i.MX95 would make  it aligned with current i.MX93/8M/7 bindings
> > which people are familiar with,  and easy to understand.
> >
> >  Sorry to bring back so late after your reviewing in previous generic
> > binding  patch. This is not to reject the v6 patch, just wanna to see
> > whether you are  happy with "fsl,pins" for i.MX95. If people are happy
> > to accept, I will post  out driver together with this patch in new
> > patchset to reject v6. If people are  not happy, we could continue with=
 v6.
> >
> >  v6:
> > https://lore.kernel.org/all/20240513-pinctrl-scmi-oem-v3-v6-0-904975c9
> > 9cc4@nxp.com/
> >
> >  Thanks,
> >  Peng
> >
> >  .../bindings/firmware/arm,scmi.yaml           |  4 +-
> >  .../firmware/nxp,imx95-scmi-pinctrl.yaml      | 54 +++++++++++++++++++
> >  2 files changed, 57 insertions(+), 1 deletion(-)  create mode 100644
> > Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > index 7de2c29606e5..f7a48b1e9f62 100644
> > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > @@ -251,7 +251,9 @@ properties:
> >      type: object
> >      allOf:
> >        - $ref: '#/$defs/protocol-node'
> > -      - $ref: /schemas/pinctrl/pinctrl.yaml
> > +      - anyOf:
> > +          - $ref: /schemas/pinctrl/pinctrl.yaml
> > +          - $ref: /schemas/firmware/nxp,imx95-scmi-pinctrl.yaml
> >
> >      unevaluatedProperties: false
> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.ya
> > ml
> > b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.ya
> > ml
> > new file mode 100644
> > index 000000000000..3f28c4a171c7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctr
> > +++ l.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright 2024
> > +NXP %YAML 1.2
> > +---
> > +$id:
> > +http://devicetree.org/schemas/firmware/nxp,imx95-scmi-pinctrl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: i.MX System Control and Management Interface (SCMI) Pinctrl
> > +Protocol
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/pinctrl/pinctrl.yaml
> > +
> > +patternProperties:
> > +  'grp$':
> > +    type: object
> > +    description:
> > +      Pinctrl node's client devices use subnodes for desired pin confi=
guration.
> > +      Client device subnodes use below standard properties.
> > +
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      fsl,pins:
> > +        description:
> > +          each entry consists of 6 integers and represents the mux and=
 config
> > +          setting for one pin. The first 5 integers <mux_reg conf_reg =
input_reg
> > +          mux_val input_val> are specified using a PIN_FUNC_ID macro, =
which
> can
> > +          be found in <arch/arm64/boot/dts/freescale/imx95-pinfunc.h>.=
 The
> last
> > +          integer CONFIG is the pad setting value like pull-up on this=
 pin.
> Please
> > +          refer to i.MX8M Plus Reference Manual for detailed CONFIG se=
ttings.
> > +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +        items:
> > +          items:
> > +            - description: |
>=20
> needn't "|"
>=20

No. there will be dt binding check warning because of quoted string.

Regards,
Peng.

> Frank
>=20
> > +                "mux_reg" indicates the offset of mux register.
> > +            - description: |
> > +                "conf_reg" indicates the offset of pad configuration r=
egister.
> > +            - description: |
> > +                "input_reg" indicates the offset of select input regis=
ter.
> > +            - description: |
> > +                "mux_val" indicates the mux value to be applied.
> > +            - description: |
> > +                "input_val" indicates the select input value to be app=
lied.
> > +            - description: |
> > +                "pad_setting" indicates the pad configuration value to=
 be applied.
> > +
> > +
> > +    required:
> > +      - fsl,pins
> > +
> > +additionalProperties: true
> > --
> > 2.37.1
> >

