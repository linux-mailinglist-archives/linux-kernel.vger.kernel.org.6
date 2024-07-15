Return-Path: <linux-kernel+bounces-252289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6545A93110A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D491C21F50
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E063185E5B;
	Mon, 15 Jul 2024 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jmn7i8Sm"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A65C185E76;
	Mon, 15 Jul 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035171; cv=fail; b=mZXZSLTwL1/8ndJq+wPWrLfq93ZGPr74DcaW0WMUX+Tjot4/CAvMBPnLrRFHCZx0k46jeSc9wJtDEuX3gXTBi9z+N5XNX4MD9TfNbbRQTZ7BFluQ/DhmHJyY9HX+BEq8zUo/VPlOcQELH64dbzV4c/WdzoWvvI8b/fr9veCvXZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035171; c=relaxed/simple;
	bh=zSdvPu6V56eogM4WDUxoRoQiY7SpT1JIA2IklNALq4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=scYYxBi3cYxEGo4/Xpf5A+rGbf/ZZHfW1MqrF93DD6yKJO3b8xwn17c9KBqN40zzWpZxH7G1age5etSRoZNMku28neBuMWVVq2J0VBYSOMgdPaxuwMpFeB9JtFq9dtW7aGqCwRt+QD6BIdEkKjEbDedkzQHJYgp83y6R+KHgd9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jmn7i8Sm; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+JufgICZSvYmWLBp4MkbBT6RxF/U7+KcFVQ9kKsA2qeGHbnN40oJXRoOzVePKzc73iUBAwGqIzxZ58uOVh6dI4Q2o8NkM1hiutTyE7ChdOp/9O17UdFdSgbkrU/qZXn0wvG7GXwR5lRofnUAn7CrozknmYJr3LqUCEXjJyUxdOJfH9cQh3sZzRRTt0CRyRkZJ31+LGbJUWC9OeBHdSyPQnmHkM8cJcGRnc9/TPU88d2ZENlcRsxteISE7QyZ2m4qyBPaJJDtQXhaUlpCLm1gE2qePq2V5tLsFnenTWoVAq/j3oAyB4Cl3Vf0pJtniWLZRLSkAY68tJ3lM3XlMIIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAHUZTO+yqzZ77a7R3ErUbcanQrvtFEqalMslzPwYHs=;
 b=LCD8T6Wa0D7K3GmPMpmIeZW+5VM51sE7p63agixyuHQ7p59DXbF8t+AcA3Na7i9BlFeV1QLZMiEVFOUuq8KPqZrTO8tZ6wxIkJG9sReacEEWPad2EfEHZhHam6G7OQ2t+yUw1BAY2V7YzH4tQgw6CUAuR+6Ko9CbUopcaNwCLTprRmv7l8HvNalrKIhdoadZweseKdBXvHkw74uwP1VpSAuDm8nsG7MfJeI+TuldxDNawlx2XQnHmOVlr8ajTGHrXiD526JNHSQ8QJInxgWNZbbXO/YZ1GT87qZXOc3HPPGlBe2WgryiATjB/QehuLhVi+QL0Ekh2fU1i5Sym86s3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAHUZTO+yqzZ77a7R3ErUbcanQrvtFEqalMslzPwYHs=;
 b=Jmn7i8SmroQx+VokOXNHWWmgeBARapcxPtCycfI0kf2TiVXYj49aX8tELb+M/MpNlbZIn98Hf0yN8TT7EZQ0HX9DUg/9abeVmFPx6x4ZDVHlJYugaC2r8kHqAGkt53iTPAF7IIob753jOnatPVW0iivyiJ7KvuW3DR4bDce70+Y=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PAXPR04MB8189.eurprd04.prod.outlook.com (2603:10a6:102:1c2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Mon, 15 Jul
 2024 09:19:26 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 09:19:26 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v3 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Topic: [EXT] Re: [PATCH v3 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Index: AQHawIiZBQsZ0s8620ykCNsfnd2JyLHNMuWAgAm9QpCACrVJgIAWBn9w
Date: Mon, 15 Jul 2024 09:19:26 +0000
Message-ID:
 <AM9PR04MB86044449C38D1EDBF308491695A12@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-4-a7d28dea5c4a@nxp.com>
 <ZnFF_Z48qzpNvPtj@pengutronix.de>
 <AM9PR04MB860446165A0826362E7AF58195D32@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <ZoJtC-fgyVWQO57C@pengutronix.de>
In-Reply-To: <ZoJtC-fgyVWQO57C@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|PAXPR04MB8189:EE_
x-ms-office365-filtering-correlation-id: 5224c321-e596-4f63-96e7-08dca4af38f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ivnREp37sQd6XdDo/KTbOs45S1xE/CQRcPr+zHEHw5H9nqA4538yDBqxekxm?=
 =?us-ascii?Q?wr12dGCFFWi1B2p0nQr0vS64K6xRyBTvoyRmMu6Zta5iT9GNjwtezwpGiP4y?=
 =?us-ascii?Q?6/s0LBCH5PKB10UDpNfAwFDsTpghhwgMmvvT1ZSpEjGRv1ddvsgFoZXKPmVQ?=
 =?us-ascii?Q?tu9z9XajLms/K4b/tvkek+kiv1uh4CKyc9dCFVtXn0taAHttpd1ETrFum61y?=
 =?us-ascii?Q?nSH+G4hLhfrsNXYx2VEC/k7FJdjtj2b8VwVvkODydVctJ9j5oFCs2xPiAEU7?=
 =?us-ascii?Q?ve1xjMtw21N+xo+z7MDLqB36+Ork1KLvlsfk3MfQoasvP8iauGrLi8bMtNVV?=
 =?us-ascii?Q?NOye5ub8BjMEjYikBwK1kWKqmbjf5LrhNEnb6+1TrxFfl8g08AyuE2x3flFX?=
 =?us-ascii?Q?AzyUj8qu4iAs9PeN8RBKQKfUhXBxEHfBj/2h0zpwOjtTqRiJNUTTJj7llwjc?=
 =?us-ascii?Q?BuefJ4w0kcrVjWgtsKplXj+s5ijmzSYZCkVB0T8X+aw9Ge1aIDuf/Mb20YcW?=
 =?us-ascii?Q?f1qz5prl97LOGW6d25RxfbJAdr7gVTcO9mPEB8ucAS1bKi55sHmhNb8uLu1N?=
 =?us-ascii?Q?2UCE9/hOwOz64kE9jy1uwIqlo06r8xVga60f1x6AQyISwsKQKGGhfsug7S3S?=
 =?us-ascii?Q?JOWKVdEsAPGF3N09PpKib+gzrV4GSdiM/cr9z5LDX7L7MB9bI1ysl2J+7Iaq?=
 =?us-ascii?Q?k1EuIH2cOP4DlD8DvZ4FfAM72lkrLhu86ZsygLzjoSI1nzSUKxRIGPgJ0xxU?=
 =?us-ascii?Q?WElFQty2LOTs5vqcDKzx2o/gUQGpzYon+Fxdnp7mCIklq2/8L/JUpyJKVTFj?=
 =?us-ascii?Q?WtMATpjNKvc4WxQJ+9mq9xgOJGrpTD/b0vTnQQ4qx05mdmeKlu7IE/MQFYt5?=
 =?us-ascii?Q?WneADZGRYftzBGjviFN2kozMgihlNDks+lqMfkfmcnjj+WoAFX/aHghO0mRu?=
 =?us-ascii?Q?hhwAWXus1cf0MbzpbyOy9QmBEaYBBjaGx43InSpoIms1kbnHSEDFf4mFL27R?=
 =?us-ascii?Q?EJ6ON3TTDdeDDKE1TFdK3yiFpeV/ucdwpKX77evWqJHxPthhg9T6PCrnpwsU?=
 =?us-ascii?Q?rBoMNPhZH9zwiFIfp+jdHzMcSDnKRaBMb+0BgWVD3JHjKpBil82F+CTw+gdC?=
 =?us-ascii?Q?OgS9QVrVd9TOm5ufyIvp+60GcjOp3B71oeSep3fmoT2b8NbbFyPTXzrTtY7X?=
 =?us-ascii?Q?4aD35hdYhcpDJWPmEeMG33pD+GAc3dFHAJLPuT76R7KcpW8wlD1KcqlmidNu?=
 =?us-ascii?Q?Scybj3btNrwMbizpSxkbcDYH7j1BOQB+jXHWieVrwTT/yILlcOVj86fJAh6J?=
 =?us-ascii?Q?E5vaR3VZLxA6SjPoheZfv+CoDyFFAwpiYxK56a5K7mjnTK1OZrzL94n34hld?=
 =?us-ascii?Q?GTXhS8QIrR0UoeMs3/zHT6c+B3oE0hIPwsGYSvHQOWCKfDaLWA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lnkq7oagE+jU39Cl3XwZii5VezlFd9fo6X/tmFTUwsZezE0I8fjznj7otlae?=
 =?us-ascii?Q?wSW12ad+BLJERYbc/Si/DyhvpTG/eu6qm6L3aTnuTHr2vrnQzBEpyO2h4fc0?=
 =?us-ascii?Q?H18Mh23blfEl2F8RzciNVfiPvsB6byyHAMGscABzQuE1fmhRYIV889RhdBaG?=
 =?us-ascii?Q?htWbe9WQQNEcF1QrDSzB6la2JiEzep4NmtXOw9VGgvTpb88vOYUQ/C0fSzt1?=
 =?us-ascii?Q?vzA+x062gGfH9KsVVyYmCIDbX24GJv7GSJzs9tKX0BBFd/3GnViTthfO7wDi?=
 =?us-ascii?Q?qM5Ec0ps7LFGF0wgfApoQjbQnfJYgh9PxVNCtVoUT9WWFczzUoaa3FOnY8Gm?=
 =?us-ascii?Q?eNoj7/bQcs+ArnZfqDxVZIgV8W57RuuAv/R+SYeAvP0WjpPQ3ZV1tI+37sAL?=
 =?us-ascii?Q?m1qoSKwMzGSZjYqSNP8XbraW4HuqnqM61+J4NBwUfrBIcWuoG+ezd0J8aObO?=
 =?us-ascii?Q?V/76JqJgBX551ckqPBlpnMll8HGrfGCBRTS4Ej+CKlKjhvJqUdRqCP2eR/D0?=
 =?us-ascii?Q?Ll+2NoqV6BNx3VrCSXHXxq25hEaJUvfNk4BlEDtpV1yOwZG+hqZTRsjslnQt?=
 =?us-ascii?Q?TX+0KfaCpv0GBdzcZrtQN7yJPHNYs3Lccqp5ke7mjAKJ1slxj4oy1itK3vZM?=
 =?us-ascii?Q?uc689dbiCw3aDOhFpYXIDrpph/qESUj3iZ6yCbWB7RYbcgFiA/XEnBTDRsmv?=
 =?us-ascii?Q?eyo6DolQlRkqxWjHS/lMswDkg1JQYQGXyF2Lbbq4IGsahO0CFd6RaRoli/Iz?=
 =?us-ascii?Q?zcniYJlXjg8jXCb3pyqUagiangxZB0XLa3a17qZLx/4RaVxUKDishVqLYCzH?=
 =?us-ascii?Q?5yytxNw+VqFk3zrm3u3PFV9gSbuIHAFjrgBgcE9Eve26JdcuYTTfIOm+LcdH?=
 =?us-ascii?Q?RNPAZmLyzAIDwFiYLk/9fkRGDvekvrQp4vH1iTS52umzWKrPn99khD/lsQTk?=
 =?us-ascii?Q?PIHvqP7qtQhNJU+dIL1jUMRQSNgao1enIlTGKzHHHvKAtzUiwtGgme3Pzz7i?=
 =?us-ascii?Q?Cfqvjo1XEbCJ78GLDs0mCVbKJtpJs+HfAMp3kChVd9MixDctsGZrjRjLNpMp?=
 =?us-ascii?Q?dFh1L1RJyC2hDB5+3bCuWSfY9DVPzpMcY9QyHyijMU9sF/+lax1gefJ282Fd?=
 =?us-ascii?Q?6uHMyiQ0vVeXi6S9lyW54purS45kwbp2ABE28nLsgsXm+MiKbzRodc5TsBQK?=
 =?us-ascii?Q?xC4qDCniydZVwz030ntstJGF0dEhYbZekVypJqh8VmqtNO3S/8xrEhxvFffo?=
 =?us-ascii?Q?AoKuhCZr+q/krXBKgvnun+lQGiAn1C+I1xv3j589riLZ2sCK/z/Dki4ostlH?=
 =?us-ascii?Q?sMWxTd1Zc0BqpVAaSJ9ZTRj+D5kV+0eXzIJuedNWbzPVZ94tEPX1IgJtxG3X?=
 =?us-ascii?Q?Q9ffgf5kMVc6sgmbqjbnZ5cncUdn+Zi5NAe6nteVafaoJ1cdy8bSCpUcjFha?=
 =?us-ascii?Q?pbRjAcfpwdbeKC9PaYoZRp4J6p8D8z1V7xd4vZWnmDytyuO8XZoyCdk2EMiK?=
 =?us-ascii?Q?OxOU02gLwJFc9rGSk7qhjuYUIgrC1AxxBlaLTBcaQz8GylRRHTQ7L1scDn0e?=
 =?us-ascii?Q?B8CdBgL7C3aRhVtMFO+2Hg9Bd0nF+IiwI9qAopDD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5224c321-e596-4f63-96e7-08dca4af38f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 09:19:26.1250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DO/JJKcXSGtThcVqImyhGw1FuxCNhUQ6Y3Vlsvu7ySuS+oIUx+Z5CwqyyZB/wirFi8qeqlWtuHy3vLa4jUT6tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8189



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Monday, July 1, 2024 2:17 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; devicetree@vger.kernel.org=
;
> imx@lists.linux.dev; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-doc@vger.kernel.org
> Subject: Re: [EXT] Re: [PATCH v3 4/5] firmware: imx: add driver for NXP
> EdgeLock Enclave
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Mon, Jul 01, 2024 at 07:45:20AM +0000, Pankaj Gupta wrote:
> >
> >
> > > -----Original Message-----
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Tuesday, June 18, 2024 2:02 PM
> > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> > > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> > > Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > > <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> > > Kozlowski <krzysztof.kozlowski+dt@linaro.org>;
> > > devicetree@vger.kernel.org; imx@lists.linux.dev;
> > > linux-kernel@vger.kernel.org; linux-arm- kernel@lists.infradead.org;
> > > linux-doc@vger.kernel.org
> > > Subject: [EXT] Re: [PATCH v3 4/5] firmware: imx: add driver for NXP
> > > EdgeLock Enclave
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > Hi Pankaj,
> > >
> > > Here's some review feedback. I think it'll take some more rounds to
> > > get this into shape.
> > >
> > > On Mon, Jun 17, 2024 at 12:59:42PM +0530, Pankaj Gupta wrote:
> > > > NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE),
> > > > are embedded in the SoC to support the features like HSM, SHE &
> > > > V2X, using message based communication interface.
> > > >
> > > > The secure enclave FW communicates on a dedicated messaging
> > > > unit(MU) based interface(s) with application core, where kernel is
> running.
> > > > It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.
> > > >
> > > > This patch adds the driver for communication interface to
> > > > secure-enclave, for exchanging messages with NXP secure enclave HW
> > > > IP(s) like EdgeLock Enclave (ELE) from Kernel-space, used by
> > > > kernel management layers like
> > > > - DM-Crypt.
> > > >
> > > > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > ---
> > > >  drivers/firmware/imx/Kconfig        |  12 +
> > > >  drivers/firmware/imx/Makefile       |   2 +
> > > >  drivers/firmware/imx/ele_base_msg.c | 284 +++++++++++++++++++
> > > > drivers/firmware/imx/ele_base_msg.h |  90 ++++++
> > > >  drivers/firmware/imx/ele_common.c   | 233 ++++++++++++++++
> > > >  drivers/firmware/imx/ele_common.h   |  45 +++
> > > >  drivers/firmware/imx/se_ctrl.c      | 536
> > > ++++++++++++++++++++++++++++++++++++
> > > >  drivers/firmware/imx/se_ctrl.h      |  99 +++++++
> > > >  include/linux/firmware/imx/se_api.h |  14 +
> > > >  9 files changed, 1315 insertions(+)
> > > >
> > > > diff --git a/drivers/firmware/imx/Kconfig
> > > > b/drivers/firmware/imx/Kconfig index 183613f82a11..56bdca9bd917
> > > > 100644
> > > > --- a/drivers/firmware/imx/Kconfig
> > > > +++ b/drivers/firmware/imx/Kconfig
> > > > @@ -22,3 +22,15 @@ config IMX_SCU
> > > >
> > > >         This driver manages the IPC interface between host CPU and =
the
> > > >         SCU firmware running on M4.
> > > > +
> > > > +config IMX_SEC_ENCLAVE
> > > > +     tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave
> > > > +Firmware
> > > driver."
> > > > +     depends on IMX_MBOX && ARCH_MXC && ARM64
> > > > +     default m if ARCH_MXC
> > > > +
> > > > +     help
> > > > +       It is possible to use APIs exposed by the iMX Secure
> > > > + Enclave HW IP
> > > called:
> > > > +          - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> > > > +          like base, HSM, V2X & SHE using the SAB protocol via
> > > > + the shared
> > > Messaging
> > > > +          Unit. This driver exposes these interfaces via a set of =
file descriptors
> > > > +          allowing to configure shared memory, send and receive me=
ssages.
> > > > diff --git a/drivers/firmware/imx/Makefile
> > > > b/drivers/firmware/imx/Makefile index 8f9f04a513a8..aa9033e0e9e3
> > > > 100644
> > > > --- a/drivers/firmware/imx/Makefile
> > > > +++ b/drivers/firmware/imx/Makefile
> > > > @@ -1,3 +1,5 @@
> > > >  # SPDX-License-Identifier: GPL-2.0
> > > >  obj-$(CONFIG_IMX_DSP)                +=3D imx-dsp.o
> > > >  obj-$(CONFIG_IMX_SCU)                +=3D imx-scu.o misc.o imx-scu=
-irq.o rm.o
> > > imx-scu-soc.o
> > > > +sec_enclave-objs             =3D se_ctrl.o ele_common.o ele_base_m=
sg.o
> > > > +obj-${CONFIG_IMX_SEC_ENCLAVE}        +=3D sec_enclave.o
> > > > diff --git a/drivers/firmware/imx/ele_base_msg.c
> > > > b/drivers/firmware/imx/ele_base_msg.c
> > > > new file mode 100644
> > > > index 000000000000..5bfd9c7e3f7e
> > > > --- /dev/null
> > > > +++ b/drivers/firmware/imx/ele_base_msg.c
> > > > @@ -0,0 +1,284 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * Copyright 2024 NXP
> > > > + */
> > > > +
> > > > +#include <linux/types.h>
> > > > +#include <linux/completion.h>
> > > > +#include <linux/dma-mapping.h>
> > > > +
> > > > +#include "ele_base_msg.h"
> > > > +#include "ele_common.h"
> > > > +
> > > > +int ele_get_info(struct device *dev, struct ele_dev_info *s_info)
> > > > +{
> > >
> > > I think all currently exported functions should take a struct
> > > se_if_priv
> > > * as context pointer.
> > > I can't find any place in which any of these functions is called
> > > differently than with priv->dev.
> >
> > All the API(s) that construct a message to be exchanged over the
> > device-interface to FW,
> > - will be the exported symbols in the next patch-set, to be used by oth=
er
> Linux kernel modules like: NVMEM driver, linux crypto framework,
> security/keys etc.
> > - These other Linux layers have to choose from multiple similar devices=
 per
> secure-enclave.
> >
> > Kindly Consider these API(s), to be the EXPORT SYMBOLS, in later patche=
s,
> when used outside of this driver.
>=20
> In that case you could still add a function which translates a struct dev=
ice *
> into a struct se_if_priv *.
>=20
> > >
> > > > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
>=20
> This function should also include some sanity checks. It's not good that =
an
> exported function takes some struct device *, blindly assumes that it is =
of type
> se_if_priv, and if not just crashes the Kernel.

Will add a wrapper function over "struct se_if_priv *priv =3D dev_get_drvda=
ta(dev);", to add some safety checks.
Will fix this in V6.

>=20
> > > > +static int imx_fetch_se_soc_info(struct se_if_priv *priv,
> > > > +                              const struct imx_se_node_info_list
> > > > +*info_list) {
> > > > +     const struct imx_se_node_info *info;
> > > > +     struct soc_device_attribute *attr;
> > > > +     struct soc_device *sdev;
> > > > +     u64 serial_num;
> > > > +     u16 soc_rev;
> > > > +     int err =3D 0;
> > > > +
> > > > +     info =3D priv->info;
> > > > +
> > > > +     /* This function should be called once.
> > > > +      * Check if the soc_rev is zero to continue.
> > > > +      */
> > > > +     if (priv->soc_rev)
> > > > +             return err;
> > >
> > > Just return 0 here. It takes one step less to understand what this is=
 about.
> > Replacing "err" with "ret", in better understanding.
>=20
> What I meant that you should return the constant '0' here instead of the
> content of a variable. It safes a reader from looking up the value of the=
 variable
> which means it's one step less for the brain to understand the code.
>=20
> > > > +
> > > > +     if (info->se_fetch_soc_info) {
> > > > +             err =3D info->se_fetch_soc_info(priv->dev, &soc_rev, =
&serial_num);
> > > > +             if (err < 0) {
> > > > +                     dev_err(priv->dev, "Failed to fetch SoC Info.=
");
> > > > +                     return err;
> > > > +             }
> > > > +     } else {
> > > > +             dev_err(priv->dev, "Failed to fetch SoC revision.");
> > > > +             if (info->soc_register)
> > > > +                     dev_err(priv->dev, "Failed to do SoC registra=
tion.");
> > > > +             err =3D -EINVAL;
> > > > +             return err;
> > > > +     }
> > >
> > > i.MX93 doesn't have a info->se_fetch_soc_info. Does this mean it
> > > doesn't work on this SoC?
> > >
> > Yes.
>=20
> Will you fix this?
For i.MX93, SoC registration is not done through this driver.
This is implemented as this only. Nothing to be fixed.

>=20
> > > > +     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > > +     if (!priv) {
> > > > +             ret =3D -ENOMEM;
> > > > +             goto exit;
> > > > +     }
> > > > +
> > > > +     dev_set_drvdata(dev, priv);
> > > > +
> > > > +     /* Mailbox client configuration */
> > > > +     priv->se_mb_cl.dev              =3D dev;
> > > > +     priv->se_mb_cl.tx_block         =3D false;
> > > > +     priv->se_mb_cl.knows_txdone     =3D true;
> > > > +     priv->se_mb_cl.rx_callback      =3D se_if_rx_callback;
> > > > +
> > > > +     ret =3D se_if_request_channel(dev, &priv->tx_chan,
> > > > +                     &priv->se_mb_cl, info->mbox_tx_name);
> > > > +     if (ret)
> > > > +             goto exit;
> > > > +
> > > > +     ret =3D se_if_request_channel(dev, &priv->rx_chan,
> > > > +                     &priv->se_mb_cl, info->mbox_rx_name);
> > > > +     if (ret)
> > > > +             goto exit;
> > > > +
> > > > +     priv->dev =3D dev;
> > > > +     priv->info =3D info;
> > > > +
> > > > +     mutex_init(&priv->se_if_lock);
> > > > +     mutex_init(&priv->se_if_cmd_lock);
> > > > +
> > > > +     priv->cmd_receiver_dev =3D NULL;
> > > > +     priv->waiting_rsp_dev =3D NULL;
> > >
> > > These are NULL already.
> > For code readability, it is good to know when and with what value it is
> initialized.
> > It will help review the 'if' condition based on these structure member
> variable.
> > Will covert this information into comments.
>=20
> We already know they are NULL because you used kzalloc to allocate the
> struct. No need to comment that.
>=20
> Sascha
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> pengutronix.de%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7Cc8b7
> b605e99744ccf94e08dc99aa66f0%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%7C0%7C638554204358183687%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C0%7C%7C%7C&sdata=3DNl8R%2FcwuT69VVUxe00AichgoSEEJexZ0TfhjfuI
> BqoY%3D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

