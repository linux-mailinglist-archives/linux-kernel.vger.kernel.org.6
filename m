Return-Path: <linux-kernel+bounces-233214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A46791B465
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2C11C2134E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852F1170F;
	Fri, 28 Jun 2024 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rg0Rt86U"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FB863C7;
	Fri, 28 Jun 2024 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536514; cv=fail; b=a56dvEA3by/SOS+Alfo9h3kqIcz0A72coHBD0tWoyknaF0aUaXxE63mbtTUPqA5q7Eyq7QWfmMUVZoZRCxRjqIkrUjl8/fApTeHVv7rsjAjFs58qed8cw3nskdN33fBi545SJBmTKpYC/6YyZDk4KKA8zLQ4pICXqLIFULiGQnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536514; c=relaxed/simple;
	bh=Vjt6Ylx/dfPYzTUQhwcqErtusofsVCJn5t9DInGcB9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LXxUnapgOrB9tw0/OHxmyFMyY/yuaWsjcCo4H1wWzOuIwJmtt7Brrk1IUzkToKyMd4TYBMp8w9QcKKB1Grhf1TGqenZ4KVsWLSF7R2fC8ZpqP3hI2XKICGv4kdJZsj36MG7jWhkL70dUTXn9RbzvyX6//NvWCTnU7r45Yq6UkdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rg0Rt86U; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2WmtAWL5IIBybM+xphro3aj9QrtSVbDfeBxs353wM99b1nKebLQK45smoXuv3YlxZrRV0aiHbqaZnLEMdvh1HEJDlBZszTh/NPLTvERizrhZQGvXELkfJFNwZkkqe0JIHYWoiRbjHtP8uREt6wxFBVZt8CSBVUYjUCDEfwV0/JjGhQ08EJmtJ0o3bObsXJNvRtB4Vid68ZPxdlpsr0+BHTq40iJ1QM+G2h8D/tED8/a/AGc6f+Fj/sTDe7YasVzGvzPG4DpZBTWe7468gbVG7LLlT4kSyUpwLT1/MYcwa4zY8e5m36Ri48of7bhrGfsVQnBohqrh4Hh72TNIAIAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vjt6Ylx/dfPYzTUQhwcqErtusofsVCJn5t9DInGcB9Y=;
 b=eTqMKw2gCUrrysn3UT3pPJJRZiv+prHzDZo9vOFqj3tN0SDhWNfLxB0puh1uAvDaJsUTfp72SseSMooanF04Ec52Bm5tdQ97Fgxsz3NORfIUc4Wo9itqT/6mW2BY3NjfgNtC1wQZ6Pi8BES/uY81r7LZoY0p/ovDS8M/D0qlVL3+NyB097gROFQoMRqmhkqy7m3vPpWU05slbIszYNirYShFGp9MwcMdRFJKtojpsOlLpxuU0qR4ny5YIRt7Rsi9i77WxmitD7Ne5a/o+Z1FTe/sytB0+iuCfuXrEFKdR127lqmraEmFLVIhlzjV8e7yl+UoR7baJgYsLlD9tuPGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vjt6Ylx/dfPYzTUQhwcqErtusofsVCJn5t9DInGcB9Y=;
 b=Rg0Rt86Ul9N+XWDA46ZIIQPnTTy91S4HBTTA4BDn74VonvLJIswbQVTZJD95i4AGLKr3hUgCA08Qw2nlfQ7QlndstjO+BNh1m/ANfzHy701Yby84KdtxeruXY5jD3Gy34mMi7EmrEdTtLS9/ft9p6ynJc2YAhwOjtokEXOwZem4=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AS8PR04MB7927.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 01:01:49 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 01:01:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, Fabio
 Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring
	<robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo
	<shawnguo@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@dh-electronics.com" <kernel@dh-electronics.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] arm64: dts: imx8mp: Update Fast ethernet PHY MDIO
 addresses to match DH i.MX8MP DHCOM rev.200
Thread-Topic: [PATCH v2] arm64: dts: imx8mp: Update Fast ethernet PHY MDIO
 addresses to match DH i.MX8MP DHCOM rev.200
Thread-Index: AQHayOomyddoi18fDUCfXuDmJ03vGrHcW5Iw
Date: Fri, 28 Jun 2024 01:01:49 +0000
Message-ID:
 <AM6PR04MB5941804BFE1CC6F72E776F9588D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240627233045.80551-1-marex@denx.de>
In-Reply-To: <20240627233045.80551-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|AS8PR04MB7927:EE_
x-ms-office365-filtering-correlation-id: b1689b8d-f41a-448a-08e1-08dc970de3fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/DSQLbCRJshPRVqLRQJIMhymvsW7HXmvnzqAahEGzM4PHmBWzsGBuAx+lA0I?=
 =?us-ascii?Q?hfs4bOYOA2Xb5AnfTx7v7OQdEV8GRxkg18F2RlSgNNofVBl3oK/ebL1Jj3hW?=
 =?us-ascii?Q?PuWWvu7JtcEobkKKdoLQhqegjQGZowTJAwma06luP2sIhv7oq5j5j34ie77s?=
 =?us-ascii?Q?uv8O0ew3YTDmPfFiblAcpahCpONhpbbUrSPPqTHjyXJaLPT1a8Ate1XqLiz/?=
 =?us-ascii?Q?zQIRuz0nsxzpVRW9triUvoOPhx96GCB2EpnZFrlnKOe1gdw6lhF83h2HqIDN?=
 =?us-ascii?Q?qw6ZVLjUPjZlUU9cTCkEwahsYGcJyOT4zHuthPmvPCXLf43+EEbhWbNhAkrW?=
 =?us-ascii?Q?RhKA7wNAcFLME9BoWyFn4qORE8n3V0WkSwO17aQu3bM+VDsovHw/v8ANxLhH?=
 =?us-ascii?Q?fSI5muUFFeZ6zoueAWe9OjxTQteBnS8YkIj6xSi+zKE/MmXhj+S6jUuwiHlo?=
 =?us-ascii?Q?rfm1/wWGzy3FaapfzoYGiuv8eWo8649Vi5wh/7pDz805CjE037peJlx4vLU5?=
 =?us-ascii?Q?+vw/pTvB15qRMQFLE0dxN/7m2kOPHsC4u7UwWb5RnZI+tZRxxcoQ/I5RIbFW?=
 =?us-ascii?Q?oX6hVTjQy++f6499LAoNOZSJz9Ioql1F94CVujQCVjy5d2EEiA4uUG9bnwvV?=
 =?us-ascii?Q?OZIcHS2FC6g1JKwLifaApitLXgkCj7RuFWCWu5/3D/njNvB2m8U70uaMT0YV?=
 =?us-ascii?Q?Xo7a8iTq0ok3dxlqsNNQeisi30IsUXapRWxtOiQQqt9Bsa5kBWoLxb7nShI9?=
 =?us-ascii?Q?wEdndjCj459bQV8gNuGsTYMBfzaGCTk/39kVuzi+mgdSNfEIh4yzCysLVynw?=
 =?us-ascii?Q?v1/EXoHv5woZTB17kHknKXHz1UK9LMvR+DilXvpBHNrif8cIo1aiK9CmGzMr?=
 =?us-ascii?Q?Eov581yzL6R6tHYc+qDgUme63DY5dC1cEmQfEQIyLCccwxmO7vyMoLz7yP8Q?=
 =?us-ascii?Q?EBgZ7FY0UsByvyJz2fnXrBgOe1D7NHUBru7Gp0OMF3bavvY93Z1HC6hSHOr5?=
 =?us-ascii?Q?S5kUx77PqhLfRAt5NIp9563WkWBMsV3gix5wzAX53yA5eBIAlIVHc8Q4YD9R?=
 =?us-ascii?Q?P8QtSppxBR645XEJuAEfiwA0iqpfUjbioNHJdLhhk7e89FhvZje+VVTQcIIe?=
 =?us-ascii?Q?qB3jX0V3YlXdAGdsZdCaxhjdA2NmDvFaK5JW+I9AIhkqy3erlak0EY5n7OgQ?=
 =?us-ascii?Q?3TiRGulYW4YeJPfDcTHgKG6NQQ2QEekiYXmhjtfJhuMQj3ugtzCQtWtUWWah?=
 =?us-ascii?Q?aclnNf3+AvM0Fn9ACqttIj2r8xJgGnaz7poPXk/R0ngkQ9U156FFMz7gTbOI?=
 =?us-ascii?Q?2nV4oZcVKo0UNOtPESTff5G3QWMgy1Zg7qZF5hiLzMPV9G9/R+9clmogo/XY?=
 =?us-ascii?Q?83WGqYmVhOewzzOtr4j5f6OO0srA+6iMZX0X2vMhtowuqRgzjQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7RAvTs63We7Gp6PU33I7dODO5aNULpN7mWh6etcDeb1LKzWFwQ0Zr47QXk5w?=
 =?us-ascii?Q?loAHfvCZ+3tIRDPbNguqs+TGrw6luhX5Lp01eptm8fNKnClMDMim6gTlytpF?=
 =?us-ascii?Q?wlR/pTBVb3soSWhyEJ0r2nKEm9G9tF2f4bieggpv5vdCAYugrov+ux9w4dat?=
 =?us-ascii?Q?DjNpbLrJFHEZN02Fr2GiHlmUWfuUWB0nuzhgcxB+V39P7Y/wrh7ycWeB/jh4?=
 =?us-ascii?Q?+V3FWrrjmQJspc11+TC7A4iWAG5RGV/PL0JUNHAW7gocvwsbnnZCBmYI2Zli?=
 =?us-ascii?Q?tMreXRnqTidvpVrfOoKWwaf5vM+GAjb/HzVBmtZFZRifMKKN7a6RtsFQb3Uq?=
 =?us-ascii?Q?4zz9Jo85T/1h/3g4Avq0oENq6JbPmpz95greOv8FLBjn0DTVB1Nlzd3ETkW/?=
 =?us-ascii?Q?rxANoJBFbFTz/uQ2BoL0h0Tvz8Z2qSM/vjwZjW6zIJvOM5tXetNX8xycQ2KH?=
 =?us-ascii?Q?O3gI8mfbYMtZIsv11nw7IyHqZy1Oymlv+4CxQey2QpLbMc4G/QwYqrO5+Yo1?=
 =?us-ascii?Q?UF/O0n+RpfqSIseM27pY9/BMBGOM1/xQIdEpfZoq257KQrBPx3cTxPqFMN+L?=
 =?us-ascii?Q?0j9nk8xcXFMbc5RhxXAgxqRsSq7OjdjyZs56gTTQ6zj9SmypTInxncJ3e0JK?=
 =?us-ascii?Q?kXDlRp5oVy1hcXajEYLI+xLtrFFmuJ8sAAI62H2GHyhS6IoqGteYtJKb12ud?=
 =?us-ascii?Q?fN4V5EQpeGxMxDyNy6OdcxkL6Ez8i4TPEsRVfRBzjbbZb2SzNWgR1/dB+Eab?=
 =?us-ascii?Q?V5b3Rs56I/nyNbSI1XPcMRfrmFkYNaxH+5do99zXQAj/Up/0JheqTPWONd9Z?=
 =?us-ascii?Q?boKsRVVsOPnG80ONBffAaKgR5IaTXjTFVh8pyD2KI1qnKiIQGqY/JYzUSKtf?=
 =?us-ascii?Q?CMWE1vmdbRCV5NDaFYYpIWX+XtbhtZcvhdvzDbKSxr771WjQsiOWYT3mImqz?=
 =?us-ascii?Q?/5752MMbeFTf/CJpOguCi2fj/23quxXB7hBUUTmenWmQ6k86NYZMQzPkWyrD?=
 =?us-ascii?Q?A3YudJv946wVBscsyVjEn2noAmO7YR2AIdlSssZqqUc9TPs/VpFYXdj2XTuR?=
 =?us-ascii?Q?MlkW2dMaPK5q1Lezci2NxEdW+zVAX/mh4mp6UuRFyVzcb6jV9NW9PGbz5Nor?=
 =?us-ascii?Q?JQ3XhN7T4QHEgHVv0Z71tpqrfCJ4C1qAaTMo3A2PTCthbfl3Ww5Z/n55ebA8?=
 =?us-ascii?Q?BUKOGAFKTbWxjLs+KBNngknQH3dOdjXNuPhktrGCfIJWe4S/0/lRSbgSXTNo?=
 =?us-ascii?Q?C05O9PhdczGchQ9MFkGed4ASoBj90mb3mMyEUj2wtnfNBlUGAQQGGqMYF8sz?=
 =?us-ascii?Q?YYrgQslGVlgAvUoqoMwD1rypXhxjncn1V1f4fVf9NEXHm5xpTXAAOH3qz9ok?=
 =?us-ascii?Q?1njLqJpgDSqG61gA/TgkONnbeccF+YsJQw2NXFHJJ/JDsHGl9BmWKLoeAERA?=
 =?us-ascii?Q?FF8cuI6gUq9qIQrSkYcjDEig3nbTQUbe33cLswmClBNnobDhNEFb5ZuxKnzS?=
 =?us-ascii?Q?MMWGqL1nuWS5YpX4g9SmWm/VAWtlMnqnWuZVKb0OT9CSUckAPWeJnHVUZGAN?=
 =?us-ascii?Q?xPHS1LjkRXO/n4DuGsA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1689b8d-f41a-448a-08e1-08dc970de3fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 01:01:49.5014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynOExrm9r2buYj1Fr0iE0725UVegjnLVKleDmhKO9XQ4CH/9NoDNudSo2YOwnfz6irf9Y6iS19Iu6PD1uX62Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7927

> Subject: [PATCH v2] arm64: dts: imx8mp: Update Fast ethernet PHY
> MDIO addresses to match DH i.MX8MP DHCOM rev.200
>=20
> The production DH i.MX8MP DHCOM SoM rev.200 uses updated PHY
> MDIO addresses for the Fast ethernet PHYs. Update the base SoM DT
> to cater for this change.
> Prototype rev.100 SoM was never publicly available and was
> manufactured in limited series, anything currently available is rev.200
> or newer, so it is safe to update the DT this way.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>

