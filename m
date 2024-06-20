Return-Path: <linux-kernel+bounces-222002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 510C990FB96
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AFF2839FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A8C1E52F;
	Thu, 20 Jun 2024 03:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="joC4J50Q"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2050.outbound.protection.outlook.com [40.107.13.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDDC1D52C;
	Thu, 20 Jun 2024 03:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853217; cv=fail; b=QVKWd+soXOmJgE0jPx7/q0K+BFo4hhPTR492LZUAqgUIjEN7hapL/l8afzQIlYTlRgFzCsp+WOemRFmScE59Nm203KmHhr0PbiQJq/Ey4KaFQ9DCgbvMuTLopYjSmUU1saB+2I6fdIbl7wK9gfRG0T9XXuxgI+Og9TpIdQy3DCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853217; c=relaxed/simple;
	bh=4B6Hlm1MamZLZvFfP/V0GlcoDRxmuo8AhB6cUfLZslE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ECE7+SHCFpw+v14a4hLies///6nm7VuluZRgQLmXgtBfXyTkLm2OMwzI9kkHgY9QrLydM5gw3LD/JvWkP4Lz8Twb3PnMGoLMX0yvyz1Mq4RGj6OpELM9WAget5sfVcD+xy3iwOvhHCiVwjWGR28HeNRApKC5bfPjvt/a5mApCGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=joC4J50Q; arc=fail smtp.client-ip=40.107.13.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBFkt5hLwvet/vLpP3Hvw1x55/Q9KCS8Y6MYGokLUrGTbkHU4HbxL+nGi5xCu/iR14V3Hhihwq5GQ9YYnIAnYaGLjBHZ3eOJnQ/Wcj0C7QkrunQoeLor2+UMLmwziQapuzmLpFATi+cUdCPGauAgosxLeRg4mVbjs9wnlUfLb5VH6vx5PDXZ8Af3EDCclO//BlSTrfFGfexMIHHx7NYfkxtS4ALMN+herOAIXTGmREU9eOFcD7M+Flma00i2s4KbPi3elxIxvdfB+kpav77syMrL7gPxRNbK/WZW9jHZnHAxkDz65kGMsjWPcPG90IRfnLklowPU7n71+cLNnNY1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fPG+vCG5k/Bbnen6txM+atTIjoMXy+yHS390e0g8JA=;
 b=l2xV2Kq2vUooecy05KalQKyaX48VNXvp2LeGSy6r/fnM2h9LfjbaM8bMpNRvctNuoiZ9uxt2MZ7DJoo9aP4YPufzkUFJpSlgt8o+7laqQaBMfv1EklkCSY53ko1O023zPtQAPPsQMHtw76imD0i0uOIGFb9IknKzP4GPKZPvnTDu0ZCPvSvy9OrhzCy4q/U+H2GshkrLi2XXZvvHsL0bKTMsFgYa0o8EsyyWCPUUOa7yFqnRfvhbvm2mmmY3nMWJqCWDL9eRQOYvhUXjF+txzuW6TaHndf00OwLIjr2nhL3dt8a6Xjf4fTsfGh0A6GfrazmAZylg/wHUv1fVTw84Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fPG+vCG5k/Bbnen6txM+atTIjoMXy+yHS390e0g8JA=;
 b=joC4J50Q//YMkiwU1v94ObPNNHkZeoBbSQfqV1ReYlEEANqmBXZezauNu0UiHD5vV1sCLZ8zh/GmSbXn0myXikB3gtvgdHMOCa0g/i8M3J4A3sptjgHZwdwF3Kiq8gKCMPT12bX5QQWa3644ql+WziCpvBr7pf5Q3eCfqWDjllc=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI2PR04MB10115.eurprd04.prod.outlook.com (2603:10a6:800:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 03:13:30 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 03:13:30 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Thread-Topic: [PATCH v4 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Thread-Index: AQHarbccidDC6+VloU2+tTCstejtpLHMUQiAgAPSZBA=
Date: Thu, 20 Jun 2024 03:13:30 +0000
Message-ID:
 <AM6PR04MB59419D538B85A3FF0C79821088C82@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
 <20240524-imx95-bbm-misc-v2-v4-3-dc456995d590@nxp.com>
 <ZnBo84P1Av0pZ324@pluto>
In-Reply-To: <ZnBo84P1Av0pZ324@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|VI2PR04MB10115:EE_
x-ms-office365-filtering-correlation-id: 144592c0-4f22-43c3-77c4-08dc90d6f610
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|7416011|1800799021|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hGpPU4txDgrR0X18CKEsCO9GA+4CP2tdKJ+oLPV2X61xetlhkyBwsjUIvzGm?=
 =?us-ascii?Q?k13XBnh+HRDn7/4S4OOBfdbXpEqIxS1+Y/R0LqtBHZ8Vkh8CvYo1C/1amnB0?=
 =?us-ascii?Q?/6w6q9XbV183Nncn6UTx/9zzjRxumVbXLhJaUYQpuFuT/fZ8e3RYRsz7AULZ?=
 =?us-ascii?Q?IRsOUXcrmMHDEqdC7Vx0HH8sPCqfICw3TFBHRxwqokcgIqqmSWuHtSaNkDs4?=
 =?us-ascii?Q?NRHx2L768/kYSVfSw8hQlLOWpoPfMChsWRXO9P6L8Z/6h5neSXi8W2rXUSMI?=
 =?us-ascii?Q?DwjTFHWnYoQ8l0MvhFOfkh8Rwyqqj2N6+cC/JNfDnOZkpl7nu/YrTgQ24kuj?=
 =?us-ascii?Q?LtJ+LUnHd8pMjWH+09lyATh9nPn7nI6P2ARPCMiFApaLaotsg4RMVTYGSQ7Q?=
 =?us-ascii?Q?GSFREe0Nl9cLmYn0b1XhxbGKXZuqoXK2tr4f6tWHZFvxOAyKddQlq0HP8R+m?=
 =?us-ascii?Q?bpE+ctCnfVr4dnVIhjmAaOYBM3JGUeOpGlvCtwlKXFn8hTzAPy4ezYcdNc3s?=
 =?us-ascii?Q?AtCO90Ql+qfNyQ/IxlpoPQ6Zn6XSUkYZ8K2+myZ0h7VpNR3E+rubjlwxRUWT?=
 =?us-ascii?Q?C44ul0sF8struKZDcN3uzZQEymte4XWudoW6A00qzM+d7SowlfO6Kr7S0Z1p?=
 =?us-ascii?Q?RwIxOlj/IS5Kp2vXfbjMK8DwjXj9dLp4Qg2NlpCgMJ5zprCPNiZZfz3YNCCp?=
 =?us-ascii?Q?+y4mFWI1iARgELj+70XlAxKEbT+HYcJKA2Uw/FGnHwCsb20QfGMRKLIL2i5Y?=
 =?us-ascii?Q?HY2qMVlofsxlgxFQOhpKUz0iNRPF+EJr2jjpLJldUD0UJIO24yu3syawhPnX?=
 =?us-ascii?Q?pvBglmR3GMBcczouijK1HCjHGcXtUG3C4fv7CjA41eOC/vAYIOejNmv7TuDI?=
 =?us-ascii?Q?Yp4lWFdV19lK8Xu3jmZSDj/49NP8jYVp+FU3jlEC1lhqEifZAXqA3ehNyjpU?=
 =?us-ascii?Q?1CxAD0oFnKrJrBEUalxOO1gOC5jnJCN1foQOUdsLmYKBfgY6+erK4ttN7ogD?=
 =?us-ascii?Q?+KUiZgRCqivZ9f1peiu6CT6Q+TbobyCkH3u3XmFy+bIoD5uuJI0JaWc1VGAJ?=
 =?us-ascii?Q?4jUp7H+PbSzy7gNEr3vB8VzCyJXBKT0NfosfNHlKKoxI3PGyYb5MGNOp+cPs?=
 =?us-ascii?Q?5S/G3PCW6cvpKYuK4ILJ2F5bLzJYD74EZVRPH2gy2Ap/py0xzCdZtbmSicOu?=
 =?us-ascii?Q?2V8HqgTAQAQBD1S/RwhXvFZ8M1U6Z+6QY+YJl5C+hOowZHfiOViVcakco4Ej?=
 =?us-ascii?Q?qiVg2sALZAbKzXZeKjji6upbBEAaoEJrlp8dJVH6aGl41m9gBFd/5W3AwZ+Y?=
 =?us-ascii?Q?nF2P18ki4OTJ5lKmtsAHvkrfarMldSlvgmwbBpnuQ34taTbZH1tsv8uV7DMZ?=
 =?us-ascii?Q?XZggNw0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WYHV+AVBL0RmPuQqGCv4Rqti51k/5zkbSj1/U/ShW0eqCzTWp5Oh8vdggerS?=
 =?us-ascii?Q?7H/ZwANuG20AXpIwYDlhkNirpBhcRxTnXoR3/ZTFPGnTmPB/dNdymnt6Rw/J?=
 =?us-ascii?Q?RXdokia+CHdHZ2eKKyJfwzgRDAxGg2FXA/BkFlJoNL5OiIiKQOnZZZULUzSm?=
 =?us-ascii?Q?uSWIVmsLZaOIcpy7XztjebqFPd8bSdyDF+00tHVJa6/yE4jH45ldchyCUBkE?=
 =?us-ascii?Q?/VdbIXSazokeoQSDgkQKSVCV/gSLxNVJcvZX9AkUT5xCRxqv6uMnFZ2YEM88?=
 =?us-ascii?Q?zB3pqo/rmdmaq6pIuZusHd45mYVvlTPJQEZZaXrzs0/6ShT+uHFwnoRKBgey?=
 =?us-ascii?Q?0VLXx3qWL2CDJjIqlgtBjpHAr5Kwz/TB+PT2tVTgQjEWjc0NjSOZCmy5Px2F?=
 =?us-ascii?Q?lBpvsvb8XEtw4WkfF2Qr4JDQMRRrk0JYhN+TW0VJwAakREX0xDxnIRCulQIy?=
 =?us-ascii?Q?qHexHDlQlseJhAJGFoi8ZM59z6qOhlTWznIxhZtTFjYEFxWBp4OtxhgFdJj2?=
 =?us-ascii?Q?w5/sfgjHssnSqvVNdx2U6Ako4gU7Gxpci4qXGW1wVGXsWoowI9HCU7FnM/+U?=
 =?us-ascii?Q?bXmqADeI3xKOt06ht0LZcWUiRgPay9fTwlRomiHmLk1fqECQmvVWHq3asw8J?=
 =?us-ascii?Q?YChM5n6oYHCL8wryT9Y1DfUZbTc+vr4gD2j+mrIkkczKhJw9Yu8os0Xs+8hs?=
 =?us-ascii?Q?XNh6S+ZE/QDdz37Mmcip88cVkFBe/D6VHPmwNw10y3VI820Pg002QnPq22+5?=
 =?us-ascii?Q?XHNhByw4iTMoaHbws88u2OL2RRfLIoSid0DUfvzrhdC7688bDGTaAlucvkaO?=
 =?us-ascii?Q?5uXVLSDr4ouHlcR9JrRL5kIWUmA7zywS9suPo0kksyX/7KdfHTDdQ7nAKE0M?=
 =?us-ascii?Q?0g1zA43/uiVVIEJN0QRIx6tg8K+yU4e2oYzsH/e2nuZS7+8xOCi9LumwxG4w?=
 =?us-ascii?Q?TII3gbwzCbYh0+tsAGlKhwnSRTAn6iNuIfcn4xzCMCYwo0q+ROV2SO5XLGRk?=
 =?us-ascii?Q?bG/RDhtZT9HoSZaM9kSZAO4FEvRx9bjxK2MvM3p341Hi/dBFfh8bgmVoIp+n?=
 =?us-ascii?Q?2IEx11YBVWLMILcgyY1yRo7In635bE0WEJc1I3STAiuJvhPUlV5s1YZyMjIy?=
 =?us-ascii?Q?tApvbF2TRKM65Kuqr18PI4EdM3fynfK45c1dQXhh1XUZUuU6TDqBhjJeOt32?=
 =?us-ascii?Q?REBr7xJMnkkO5dTzOsjDBZ8voU1r9oJ5avm+Jaw489TqER3xHfLV8sVK9Qgh?=
 =?us-ascii?Q?7YFC6Xk2jRsSR9+V7Nj6MCjUNu3Z3C0kOMzMJkYuRf0TPYFp9gFUsMhr9z1B?=
 =?us-ascii?Q?UdJWcBw89BpWAB940KRst1dJ9v59QEUWYkjRRcA8NmUuRdMVf4PZ+1LkriCa?=
 =?us-ascii?Q?Vf7KMF3FPa6HaeDb82GHcCbnmAMXVv5OLxjco1fdajgpRGgDdNheVL0g4AOK?=
 =?us-ascii?Q?LoW+/KUCfJNl+ru2gfPuCW66fBlxNwohwJ/B0A5zX8gqvSmVcfKJ/Okjk0aZ?=
 =?us-ascii?Q?4VDMHZ4uUV6epCzHeklWFXmn1B1y7Pweva+g0f3vh9ffWW2BzTZaLrqGRSmV?=
 =?us-ascii?Q?9LId3fak3oIduVu4DJk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 144592c0-4f22-43c3-77c4-08dc90d6f610
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 03:13:30.5033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JD+C16K8v1mCLsm+4GGPjrd4WoPflgUNo7dPmHUascHPlX/XJ50vXdLg4gldHCK5FsDIqJk8yoBcRqhXKyJc8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10115

> Subject: Re: [PATCH v4 3/6] firmware: arm_scmi: add initial support for
> i.MX BBM protocol
>=20
> On Fri, May 24, 2024 at 04:56:45PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX95 has a battery-backed module(BBM), which has persistent
> storage
> > (GPR), an RTC, and the ON/OFF button. The System Manager(SM)
> firmware
> > use SCMI vendor protocol(SCMI BBM) to let agent be able to use GPR,
> > RTC and ON/OFF button.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/firmware/arm_scmi/Kconfig          |   2 +
> >  drivers/firmware/arm_scmi/Makefile         |   1 +
> >  drivers/firmware/arm_scmi/imx/Kconfig      |  14 ++
> >  drivers/firmware/arm_scmi/imx/Makefile     |   2 +
> >  drivers/firmware/arm_scmi/imx/imx-sm-bbm.c | 380
> +++++++++++++++++++++++++++++
> >  include/linux/scmi_imx_protocol.h          |  42 ++++
> >  6 files changed, 441 insertions(+)
> >
> > diff --git a/drivers/firmware/arm_scmi/Kconfig
> > b/drivers/firmware/arm_scmi/Kconfig
> > index aa5842be19b2..79846cbaf71b 100644
> > --- a/drivers/firmware/arm_scmi/Kconfig
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -180,4 +180,6 @@ config ARM_SCMI_POWER_CONTROL
> >  	  called scmi_power_control. Note this may needed early in
> boot to catch
> >  	  early shutdown/reboot SCMI requests.
> >
> > +source "drivers/firmware/arm_scmi/imx/Kconfig"
> > +
>=20
> It could be that we fold all the Vendor drivers under
> drivers/firmware/arm_scmi/vendors once it is merged...but we will
> take care of this reowrk/refctor...still not sure about this details.

ok. Sudeep may comment more on this.

>=20
> >  endmenu
> > diff --git a/drivers/firmware/arm_scmi/Makefile
> > b/drivers/firmware/arm_scmi/Makefile
> > index fd59f58ce8a2..fb9407fef60c 100644
> > --- a/drivers/firmware/arm_scmi/Makefile
> > +++ b/drivers/firmware/arm_scmi/Makefile

.....
> > +
> > +	ret =3D scmi_imx_bbm_attributes_get(ph, binfo);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ph->set_priv(ph, binfo, version); }
>=20
> I would move this init down below, right before the scmi_imx_bbm and
> after the proto_ops definition,  for consistency and readability.

Yeah. Fix in v5.

>=20
> > +

....
> > +	.button_get =3D scmi_imx_bbm_button_get, };
> > +
>=20
> ...just here the init
>=20
> > +static const struct scmi_protocol scmi_imx_bbm =3D {
> > +	.id =3D SCMI_PROTOCOL_IMX_BBM,
> > +	.owner =3D THIS_MODULE,
> > +	.instance_init =3D &scmi_imx_bbm_protocol_init,
> > +	.ops =3D &scmi_imx_bbm_proto_ops,
> > +	.events =3D &scmi_imx_bbm_protocol_events,
> > +	.supported_version =3D SCMI_PROTOCOL_SUPPORTED_VERSION,
> > +	.vendor_id =3D "NXP",
> > +	.sub_vendor_id =3D "i.MX95 EVK",
> > +};
> > +
>=20
> Beside this, LGTM.
>=20
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks for help reviewing the patches.

Thanks,
Peng.

>=20
> Thanks,
> Cristian

