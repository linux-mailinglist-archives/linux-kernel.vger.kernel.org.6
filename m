Return-Path: <linux-kernel+bounces-260905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E2293B00E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EB11F22C32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6468B156C69;
	Wed, 24 Jul 2024 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FQ/zPnGZ"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F31C6A3;
	Wed, 24 Jul 2024 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721818948; cv=fail; b=pl8Gnk8TVMf9JoElNJzrLZsIgHkp8XL7ly1xVkSzQhcA/+1a5yoFT/Y+z9FbERXsVr06qzh9YWktjhUqtn3vFRxPszm9Ww2/KAhhUQZ9EeIPfLyPe+7czHraa0DX4x6GZ28icUKZ/skzws+R1CG18BnBY5wXlcvd0On6mKdHFb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721818948; c=relaxed/simple;
	bh=nlBkID7V5o7oyv1N3hz7uTP5O2uOLiHyEOpDLUhnuwo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMLIxC/jWoKqqrfsfYCm5j+9v2x8AMTWBOixpkSWur8fDZTUCAlJRDYeKafLUEPcpPmJTApBXh1A//faCTZRZGZR8jSq2luCLlUifAYYiUFxmUeZqmNQsz90EZMs07vwuCWEVj3ZFedj3y9jWRYrPSkaXLp++2iDjFu3Vl0esrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FQ/zPnGZ; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuRwODUebwBtnPYCOrxLnyRonWsSX1MUUMwRyknhGBzNacDPJa9ZkE5wqU2ypKPHHhms+7MupvN/IKnYIWM4kPuzpH1CEf7WCUPC4CYH4OQ+hLwbmgVKwcKigtexT8BcT7nAbV/8vuLLIGrdNRscWIEVYJ7fuU/idl/ivLKKgnUNXDdqnfJ7vgAGg9F2Wh1Nz0fw2do2ssoSzvhfi8gNY/qJrJNu5ww5TkRfbwZgyWf4vnNXvX0oLuR+ITIXXqXux6uoB0fZXHXQWO+lgwBn64VNu2GjY3QTJth4xMKp83TTbj7YLkmqzzPL6hA4xbmPEerqgvLNa/DPgWJPcl6VDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cXUDe3X0wkUE6RzD0O8v0Uch0GCJq5VFj8SaN7VcVY=;
 b=t0/Vxytyzw5zuckvYxLSaccfCtNYxY32VEvmLUTKxxIEDHQStplPYcj0UXsvln1pgCVaePwp12HRszhEHJEs146k/Cjq8hNXuwlCbqRKnZBHdBqzxRLcnGAEo1LA80M0rvWVFyAV2bGI8YWPnzImLJGHxJ4+umUpxPwjQIn4Gf418TGkrMp6qpH9Q8pWF7qfO12kdyr8vmppuNkZVQ6+6CaSxIuV0SLG3ljGjCoCiLjdREWUS7OCsguDoCsu8rCzLi/lcBuAZDNLABGeOwbVlz3tY2/eJ1E1RLJGcsckbNguScSD/Rs0XiqKRqnQ7cMfFCwbWQIiQmofV5GvOxscCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cXUDe3X0wkUE6RzD0O8v0Uch0GCJq5VFj8SaN7VcVY=;
 b=FQ/zPnGZtUxvO0chMD6tee5rJTygIsIWaH5J8Uw/kWZX27leVT6IEGAJl7rQ4m7LwA8em/6uDs8UpKwCKNxs9wIboEsLTOFedjAh3xvHoJcNpiXWh0kfWCG2u8qYe3c9KA5KyC4Kjax+3eMIHj+qlrFXGicyMCZkyEcQlYN0lFw0Ke7AMR/5P+EHOH8xEI6KJt+9wNtwbiztLdPrCgY1pSniElQ/rTn3EBAKhwBBteo3d+8cJPmKLXM8j2fm9NYyhw70Sw+0RvPkZQp/4pyeak+IWf0DVNE/Kqaj7DXwQMIRvUWsGEoMIKLivj06M/ZjbsUpUKqZEFf+illWASb1Gg==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB8264.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 11:02:22 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 11:02:21 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHa2/NU1sJztJxAoEWO7LSlO6AOebIC9paAgADLMzCAAJnWAIABTu8Q
Date: Wed, 24 Jul 2024 11:02:21 +0000
Message-ID:
 <AM9PR04MB86043E4B4B2FB206BF9223C695AA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-2-ee26a87b824a@nxp.com>
 <20240722-popper-comfort-7538ea70c77b@spud>
 <AM9PR04MB8604123E065315093347F66C95A92@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240723-smitten-shower-1d15c0f3cf97@spud>
In-Reply-To: <20240723-smitten-shower-1d15c0f3cf97@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AS8PR04MB8264:EE_
x-ms-office365-filtering-correlation-id: 562de309-336d-4c81-0358-08dcabd017af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bc3z8CLt4fMA+7e3Lo25ZsH6x9InbJupvpedjRz5f23E5SyZHaqhRmDaADIL?=
 =?us-ascii?Q?ZRFBB7gIQFHEcCv/J5PwaKKDzEf0lLuIF8j6T9ZqbCtje0SB5h1FvEUtF2Lc?=
 =?us-ascii?Q?SD6j1/VyuH0rmyUdH3pc5FQhooG+IYCiOqHJgbj7hNJ1Fo5zu9ucgR/nTn4T?=
 =?us-ascii?Q?QS5bkaTC9WVJVRXZD78HjNkN8K68RiNSeMPgABt6M5pC2eYwPNyinATj11FN?=
 =?us-ascii?Q?uH/If0jhv0exdZdVmIPCE/4bCPpCE6uDs/SiC++NUC/+LMCQKYhloo5Ednlf?=
 =?us-ascii?Q?aMgR+20YB6DgqEWLB3p/s0dZxszaoobTq5U6B3TwW1Jviwr7oH+VoVp3pgf/?=
 =?us-ascii?Q?lsGtJy54g2JX23g2AO/l0a1QYf4qPETqUqptwfX3HmsicfLo3pUDHYBm5LXi?=
 =?us-ascii?Q?3N1JmpJvgTddaX4m1S8qf+6e8Qtt8vpY5lai4tS7xPJ2GtKqSDiJHVs3PMPZ?=
 =?us-ascii?Q?STHhmnWsEdLUgbDdpUPb5nS3EFDKXY7xksnsk5AW5wPyUa1Tj4kd5xSk0G43?=
 =?us-ascii?Q?ACpKwBigjFJmEtOflL8PWnO7hsYg7BwjDpIp1SeluOTqJfLDvOtj3nHlInb/?=
 =?us-ascii?Q?ZbEz7aBQI4X6fqk6C5pDjm/4xdo7lSUqZKDTh4Zw8pQSwPyVENsGgy2o7OsM?=
 =?us-ascii?Q?/8oGn2vhMI/c+5BLskJLOBKRQqkCfPhlR4VGUnFHiTvTsz1BLSXkYxxbyEdq?=
 =?us-ascii?Q?7MJL2gbdWgAFSeZszORx5XC8Q3L9419lWir5b3yqgvVzrRPRFRTtHgyZ+X/Q?=
 =?us-ascii?Q?HIBDse8k42YFcCpr0sofO3x1Bzat+ZjiXpVIAW4xYTjcHYPBEBVtReosfw+C?=
 =?us-ascii?Q?qXo8l49FkD74FRoYkE45XUpDw3fvoCvdx98M/2NDtmlVARMqO69+hcgyzH6v?=
 =?us-ascii?Q?uEkBx9pGuPSoUUoC3XfNSXey9/n5qM4tVDztLFYPO+I1YrcIoCZxyGyC/QoG?=
 =?us-ascii?Q?dD68ywQFT1s/6n9t8iH0AyFNfsSiwFuTgTu+94lIxJ256EDurTegKxMbYzL3?=
 =?us-ascii?Q?mdMKH5qmD9ZwC5KkZlpEBqE98L2rg930OOk3YzqyW6fj7bYh2h4QYoani6FH?=
 =?us-ascii?Q?9aLGE63tEPCGt79AQulU5ibYDOcWvUlwFTqzKTBuYTXpgQWb2DyGiw/Yag2A?=
 =?us-ascii?Q?7euxKn06kpat0GAovKLEy2St1wMZD7k0iQZ0dD4L1Dp9V/TXiCeJGkxIi7qg?=
 =?us-ascii?Q?CqVDP8EavMfGBbpUx1Q2OBike/hSNAVg4amEOwEzQZ+NSP4BzRUqQ6CCBmwn?=
 =?us-ascii?Q?QDBEX8LHL9ZJdYtGuuril05YCLyRGkYyb+vQO1msm3ioGlZjV4ZTDyXWvdxk?=
 =?us-ascii?Q?hg4QdactV0Dmx6X2bnyQUxYodnVViKq24qWH+tvYRoZOtneKjnZWe0oyAjEK?=
 =?us-ascii?Q?XQ1pcN8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WGL1fq1Onnp62VSQGX381FmIOZmTBq7Nboxc5cTXl+NNn//bWw6YqBejVbsn?=
 =?us-ascii?Q?jL8aiE1njgYAgQNfbtB9t31aHhbvPjZK5ebvzHk2LDEoZJLJeZkLzNwSJCB1?=
 =?us-ascii?Q?rK75fycpvLsI1t2iREybOI2QKicle7RUc1RrmZrb0rH8jyK+SkQh5wFQ4UYO?=
 =?us-ascii?Q?UtCFgs5a4K3JXrgcerXhVlq+z7PdP5iNpF5r8uBXKpmOlgMnDs/Y8JLQYF9v?=
 =?us-ascii?Q?naWKIJ0yzwbVAlzt606jLA14fVkXhZyOA7rozcitAkdS5EniLeIc2En8s7Hb?=
 =?us-ascii?Q?7Kxv2SCn5sn+Ugs1EC0zHLWaudAJhu5AICqcrXX6gcTL5GgPnTIZrtatTxPp?=
 =?us-ascii?Q?CWVoOwtwf/vEODG39T/YK7xnT/43S6yvPysf1/piJaAJejBX3oE+OPzN7f4S?=
 =?us-ascii?Q?zJB9wnOL64JHxsajRZYKVM5cc7isPzDR8TYpwqIOabnto/pf2e7PNJwTPgQB?=
 =?us-ascii?Q?ejFx3E5mplwWGPVKClH6uJPDe+X3d8LNrPrSvlymnOr4/MW3es7KYevvRRMC?=
 =?us-ascii?Q?8jb254RdquC+INxz8s8s27tiTROE9RpV0uKCvoQzpoTIpvodTp2OEVSv3MHN?=
 =?us-ascii?Q?GUpxRrkpNGw0q7q2Sdt1tM1kMmGrWElkc9I35fMNyypnvz+lhKMGZWaDTTO+?=
 =?us-ascii?Q?heQb2sS8iDYGb21dya2Kj5YR6opR1q4C5aYF80B5VpCOPla8qU3CVSRh0Rmq?=
 =?us-ascii?Q?iTQsNNLInmcf9Xt2cV6xDsGlPkTHBs2yGlD4Mj9yTE89JXtQOpsH26+ef0Gj?=
 =?us-ascii?Q?CNPC6wZO059/yeQcIRs7WUS5X5aMzxp6BTf6r8BSPekae2ZXvbwYYXI/yOu8?=
 =?us-ascii?Q?FqScrXq5fl2+z/eBDR1SBBD3jVs9pna7HgwrJWrHNFTnKA1n60pNKnuhJvOq?=
 =?us-ascii?Q?E5/FLD73WRewTGcnAZfftN202FKHUxrkkJSKoytLN/D/nkU3pu/NwgWkyrEj?=
 =?us-ascii?Q?50LiSx9YOQgoJjQPEDUdjFkLVMeV2RWynx0IHxbhcHOs+upb67i0v4nNJUSM?=
 =?us-ascii?Q?HvnrEKWoYD+183HyjRud9g5SON24Lir5zu1yMf55lgHqrVqLXFYz0bPuA3c7?=
 =?us-ascii?Q?ReYT0V2NNzrTgg6cCfZjSuIPSErrk5Naa7wy+VaLjPbRqpQ1vo6Jnb6c6Ds+?=
 =?us-ascii?Q?1ya5Lb9idWr/bkUmawJ0wkan130t8IwHze4MdXo+YDhcNtBrITeybJayg0WW?=
 =?us-ascii?Q?y6U3XowXlirp0sdI2gSXwqkfngRfvkKtCxQ+AVP00UPcCynNsV7zZUvqTnbn?=
 =?us-ascii?Q?DMnG/fplpHUnllMEaZuHHA9Hx1dK4AOQekB+GnDeEMa7WH0npZucUDHk3wzA?=
 =?us-ascii?Q?i3l2HAQczqtNvvmgOGVgaou8CQ47lXy+nt5eDmN8gU9pIZIV/PSrohhmLqRV?=
 =?us-ascii?Q?vFaW7/Vp2MqzRCUlIB95z8+4LR+zP2kMmGYLlo2kPqn6TcsjGtFiOmtfutR9?=
 =?us-ascii?Q?QplGG1T99WYmzreeSa44Tvxf6ycyvkpAvQSeL393b7v3905xVjFDApXIYIYU?=
 =?us-ascii?Q?a8EnRCliYMkj3y6L+6HM5LJfVpjLkTZp+oFkT0sns1IJnjc9Wle80kFp1oSV?=
 =?us-ascii?Q?Yuv5sDAeLKuFpE1Hs3vYJrc9w3BvXb0yx+gfssIC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 562de309-336d-4c81-0358-08dcabd017af
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 11:02:21.8515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWSA+tYiAhQGy3gjXD7UFey9yrD+vZlN0kphJsnFuD6zdM/EU+kQfjT3UlZQ1TOpcYRsRGBwPhmavjHMAi7a/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8264



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, July 23, 2024 7:38 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-f=
w
> binding doc
>=20
> On Tue, Jul 23, 2024 at 09:28:31AM +0000, Pankaj Gupta wrote:
> >
> > > -----Original Message-----
> > > From: Conor Dooley <conor@kernel.org>
> > > Sent: Monday, July 22, 2024 10:20 PM
> > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> > > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha
> Hauer
> > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> > > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > Subject: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add
> > > imx-se-fw binding doc
>=20
> Please fix this ^
>=20
> > >
> > > On Mon, Jul 22, 2024 at 10:21:37AM +0530, Pankaj Gupta wrote:
> > > > The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X
> > > > etc., creates an embedded secure enclave within the SoC boundary
> > > > to enable features like:
> > > > - HSM
> > > > - SHE
> > > > - V2X
> > > >
> > > > Secure-Enclave(s) communication interface are typically via
> > > > message unit, i.e., based on mailbox linux kernel driver. This
> > > > driver enables communication ensuring well defined message
> > > > sequence protocol between Application Core and enclave's firmware.
> > > >
> > > > Driver configures multiple misc-device on the MU, for multiple
> > > > user-space applications, to be able to communicate over single MU.
> > > >
> > > > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> > > >
> > > > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 91
> > > ++++++++++++++++++++++
> > > >  1 file changed, 91 insertions(+)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > > b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > > new file mode 100644
> > > > index 000000000000..7511d0e9cf98
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > > @@ -0,0 +1,91 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> > > > +1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> > > > +
> > > > +maintainers:
> > > > +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > +
> > > > +description: |
> > > > +  NXP's SoC may contain one or multiple embedded secure-enclave
> > > > +HW
> > > > +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> > > > +  enables features like
> > > > +    - Hardware Security Module (HSM),
> > > > +    - Security Hardware Extension (SHE), and
> > > > +    - Vehicular to Anything (V2X)
> > > > +
> > > > +  Communication interface to the secure-enclaves(se) is based on
> > > > + the messaging unit(s).
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - fsl,imx8ulp-se
> > > > +      - fsl,imx93-se
> > > > +      - fsl,imx95-se
> > > > +
> > > > +  mboxes:
> > > > +    items:
> > > > +      - description: mailbox phandle to send message to se firmwar=
e
> > > > +      - description: mailbox phandle to receive message from se
> > > > + firmware
> > > > +
> > > > +  mbox-names:
> > > > +    items:
> > > > +      - const: tx
> > > > +      - const: rx
> > > > +
> > > > +  memory-region:
> > > > +    maxItems: 1
> > > > +
> > > > +  sram:
> > > > +    maxItems: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - mboxes
> > > > +  - mbox-names
> > > > +
> > > > +allOf:
> > > > +  # memory-region
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - fsl,imx8ulp-se
> > > > +              - fsl,imx93-se
> > > > +    then:
> > > > +      required:
> > > > +        - memory-region
> > > > +    else:
> > > > +      properties:
> > > > +        memory-region: false
> > > > +
> > > > +  # sram
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - fsl,imx8ulp-se
> > > > +    then:
> > > > +      required:
> > > > +        - sram
> > > > +
> > > > +    else:
> > > > +      properties:
> > > > +        sram: false
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    senclave-firmware {
> > >
> > > Last revision this was "firmware", but now you've got something that
> > > appears non-generic. Why did you change it?
> >
> > In case you missed, there was a previous email requesting your view on =
this
> change.
> > Having node as "firmware {", is very generic that has wide interpretati=
on.
> > Hence, replaced firmware with "senclave-firmware".
>=20
> Which I came across after reading the updated series. If you ask me for m=
y
> opinion on something, just wait til I reply to you before sending another
> version.

Sure, will ensure that in future.

>=20
> > Why "senclave"?
> > Like sram, for secure RAM, I proposed senclave for secure enclave.
> >
> >
> > Moreover, there are plenty of examples of YAML(s), that were already
> committed; that are using this:
> > linux_bkp$:> find Documentation/ -name "*.yaml" | xargs grep -r "\-
> firmware {"
>=20
> Just because something got in before doesn't mean it should now.
>=20
Ok, understood.

> > Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.yaml:
> zynqmp_firmware: zynqmp-firmware {
> > Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml:
> zynqmp_firmware: zynqmp-firmware {
> > Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml:
> zynqmp-firmware {
> >  And more...
> >
> > If you any other suggested word to pre-fix , that narrows down this bro=
ad
> referenced word "firmware".
>=20
> > Please suggest.
>=20
>  I already did:

In case of imx8ulp, there is a single node.
Having a same node name for both parent and child, is bit strange.=20
firmware {
	firmware {
	};
};

Request you to allow to re-evaluate this point.
Thanks.

> > > The normal differentiator for multiple nodes is -[0-9]*, why can't
> > > you use that, if you're worried about multiple nodes?
> > Thanks Conor, for the suggestion this. Will use this. Thanks.

