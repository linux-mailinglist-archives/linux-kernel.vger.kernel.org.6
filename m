Return-Path: <linux-kernel+bounces-233209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FFF91B458
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C466282D61
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC12F6AB6;
	Fri, 28 Jun 2024 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ONJdOIxk"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D512E6D;
	Fri, 28 Jun 2024 00:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536348; cv=fail; b=NjvXw3Jn8d8SyFGdpBDLtaJ5pVb4jUHQGUvIU9rCI/kOSaUBQcC0vm09/oIPcnQ0eJt8Ia9RuWkY15HteA7/3P3JaLtaeQPi43NTxvr5bgKVDRMRJOAv/5gbejk4448fWqBJX9DiAbxa1IMZM25qQufougoVDYssizds6Dq4wAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536348; c=relaxed/simple;
	bh=7RYCdcKwbk6RoQRV1QqvzVvYS3QplE/bszhUW92kNPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kM6RQQLUFtQjOqQa8I0uhISvZKhHRDnqGzXWBwaW0yHFVb8oIo1AnKCiLc/i/z65PaHpLPFHgFLrAciWDgVIZfqn14r0cM7uy9bhIHdR2xmhD6oDSbz4Xi1GgGgCX9TanDUKovzRDaW0P/74oKgkj7j5MgbcQGJyH0Ebz+MH8/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ONJdOIxk; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO5z2lvAGIwnRwgPZ8eNiR3q90Zxjn/qDceE3375lVJRecbL4uMsfjTisnekn7Xg09pFV+8GVw7HLg07C30oVE6mFNul/2nnjoKO4w0vniBn/xA1tKzqJJ1ljj8v1OdOtAl+ysjcrI5tB5xJOV0XuV/KFUwPBIbbPN6811IlaGhiDhzu4jBt7dkUIaI5dtvWJRYGk/e3wqyJgvPLViC/fTEDnHJTj/qshLCxCyS2i24JCszV7GTjFhQYjynV7Qtgpbdo9VUm07lucgkNRz9K3uLTLQGtcWlRjYn4xDrF0a4RkfEipdFR6dsVnZA8LVkt7rE71ILcpyAfiPbNB7UN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RYCdcKwbk6RoQRV1QqvzVvYS3QplE/bszhUW92kNPU=;
 b=mY7MzVivMeNbA59eUlpj5ZwM3HyNOpi8l0jp8UGTEcWXnXVzOFXQ+ty+olZI2+QIwg2HkrHj+1t0+QW6waHz5kV0x35rLm2U0rvZVgtFAVRjBOyaZ75gz78kwieRtZ7n0VBWg0jPTbi57yXfCMbmbZV2BJTK/+uMFwCax4EIUpBzzwAK1eF1CO/nU0i5i+ct9c8HXaa8w8aAUxPt3fNqFCIjkZiH/9/NnlDeDMs6QPJA5DzAKIrUUkpAgH62w+SO9ft32gGu+PncKymmRDtmE1KxjVPdh25UlITjf+gB01RjSyADryad1AP5WsOcrh8eBVT3xGjbJCFIUbg9lgdzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RYCdcKwbk6RoQRV1QqvzVvYS3QplE/bszhUW92kNPU=;
 b=ONJdOIxkek6YwQ2/EHn2FA/scDOrx6/MQRU2u3o6R5vjOIQwV3N2crZlPbIHRCeKodVK7IAGnP7uCFeeVn7A+k5C96ike26CGOhaZtztQX3uSyNvd3HZRRDNCxuj1NMvoiswZfisbPueTgRPsnk23H2hvjdMlyUjysYr+k9CxuY=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAWPR04MB9933.eurprd04.prod.outlook.com (2603:10a6:102:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 00:59:04 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 00:59:04 +0000
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
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 6/7] arm64: dts: imx95: add thermal_zone label
Thread-Topic: [PATCH 6/7] arm64: dts: imx95: add thermal_zone label
Thread-Index: AQHayN2SSC5eBAju2kmAqqC1kfxTlbHcWuzQ
Date: Fri, 28 Jun 2024 00:59:04 +0000
Message-ID:
 <AM6PR04MB594143186B629282032C565888D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240627220001.692875-1-Frank.Li@nxp.com>
 <20240627220001.692875-6-Frank.Li@nxp.com>
In-Reply-To: <20240627220001.692875-6-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PAWPR04MB9933:EE_
x-ms-office365-filtering-correlation-id: 0268434a-2484-4365-cb22-08dc970d819a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?T41MLuQGFmXPw2SHK2w4f/zQqbLZCjyhZ0ws/u4JiJZ/rw5bUUX8YXHJ7Evu?=
 =?us-ascii?Q?dfZM00/dwNRKGhEU4GVSQHyEMEE2JnTiFYJy/Qx04xw7ZAXONZdepOFWCujl?=
 =?us-ascii?Q?aNYApKZFZH01josuevCD0FhuLZA0kMWV3D2BHvocjo8PitYm3owoOBeL76qp?=
 =?us-ascii?Q?LjX44Cy+eKINknQ7PS4xmzr+zYao3p1bKzt2709x5eK15AH5vtHqfHLsyREL?=
 =?us-ascii?Q?a435JVbStC3IFN11hTaLleeu+BA6aV9CpCr3iDPGgk5Nhj9ozt1zM+00DNGZ?=
 =?us-ascii?Q?xoD5BjPCi3+/orBUWejy9yRyVXatTataITOMHEfIHQBzLW/ooDROrKp4Hg6x?=
 =?us-ascii?Q?o6ceQtl0AxdktXQSgWNG+GBQjzXapUSUjWi0SPCeFdcierFmh1PsipZYhzaT?=
 =?us-ascii?Q?Mu5D2Qwf2S0xS9uh8fm0UuzonZlreN08BGcTreUKEBoEB/LqVTBUz4aEwcS8?=
 =?us-ascii?Q?0Lktg10ocbSWJUtYXSVHD/kf/ckqqC/7t2qdKBjHMQgQbHatfFAXd/eetei8?=
 =?us-ascii?Q?iH8fKQPlk8McR/bUX/Pth5KVHBBT0OmYle8IIYy792slJYe/3dzOlNLlNal/?=
 =?us-ascii?Q?oKRJc/bVebOQcRosCEs7rzAd/AbTt3DboijK/WXgqxQmmSl3IpMUTN6WhMq5?=
 =?us-ascii?Q?BX+u3kNpSbL2/vtp1Gew9tNY9FH3fx4odUE9mOtSeyj4iUaTnIUxIzb4cDTE?=
 =?us-ascii?Q?fNVTjJADEuAGNTfJNWsFemCnGYNZp+a6JxvML9tPbPnwKnfbptxV5oKxq+Ju?=
 =?us-ascii?Q?gXxr9ENND1cOleTd9wsN1ddp2CYp0eNKcH9hYEJj9Fe9Wvm+/Sgxizg15dCg?=
 =?us-ascii?Q?6U+Kin7YWI8azTNI5COnobGwgPusdrRF1FQncb/AlZHvxuwNmOfOV6ZlSM9A?=
 =?us-ascii?Q?Ar0kcxsQ5JIdK4OE8FY3JLge0SD+X4RyMc+dXtpGFA4TouhE4/eMyXkZELEc?=
 =?us-ascii?Q?loAsAa76A4s/+on9ZnuIkDiFbnrjPBLaflRTGzPEAvOnpmLGeV65eGwknvcx?=
 =?us-ascii?Q?TjL9hgtPbKmMasttdZo4Nw7bvuO69xgChlU6SO3leKgxQuRZJpXDFXaXKVbl?=
 =?us-ascii?Q?p1KCm6rIdiFO5xaemZLzaIiQiwUUhJs1Ig78fEVOGstNCBolYz2yGx4BXHCR?=
 =?us-ascii?Q?L2Rcy++YqsloL9pbh8zQ6O0U9/iR9GO+zvdIRfgHCjYC3c3aO03nK4roLKAM?=
 =?us-ascii?Q?ziZC7q5Hr4TU4vx5KwHjYxg5zMx2ho957aUDFnVB4/RvbgFMmJJ5/gzTpmkH?=
 =?us-ascii?Q?cRNOuNOrHDDzJefeWqRKqyOUrXEnTIrZGNH1Wd0JmdnFpMG04IDd3oQ4gbEl?=
 =?us-ascii?Q?0J9FqI80Ts7JwLASxpeqtkKFlHbRAHi3jafDJjwNzpm3Zfw+xJh14pIO1PC8?=
 =?us-ascii?Q?YzdMLNM0pR0NiXOZ2Ei5kw692ByrTSqJ8m48IU5XrZ/t0b3URHJv6Bt4dRew?=
 =?us-ascii?Q?DRa9rUpmEXg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f/boJxmt9rLp4RmB3sys8sGc7YxP6HoOnSenZmLvPmFBh20+VsqQ2/ll5t5I?=
 =?us-ascii?Q?FVBCuZg7CTBfnkpLNjGozBXZ/mgmlcpfq50cR3fMM1/ZRgR5Qr7AlxG8wj4g?=
 =?us-ascii?Q?lqE0+WKOo0N7AcRJ5lTVDjHYVMGjjnqJxFcvlzwWWhz08HAdsZazIjM001Hv?=
 =?us-ascii?Q?NXE3HBAGXLVGJJCLSQxAR71pqZS4j6x46QJLR+7gOfweX3DX3WAQTvgaNHxw?=
 =?us-ascii?Q?nVSP0JqWQu8ucs0VvjktzWOVjidfcN4dHWKuhaEhW/Nj6xqJdwePeSjRz5zZ?=
 =?us-ascii?Q?PfaM8+/cp/2BV7kICXXPL7fZMkOii3iu3bme8p5I6+riB6lpM0cUI2z8cqjJ?=
 =?us-ascii?Q?FZVSsLMXuo64xnyK8hHYwLcDFnQV4rJTsKpaQ1Gw3Mf2NRj0j995ljWgfdZY?=
 =?us-ascii?Q?6LBJ3YMfhylDlHG8DfnxfLOaDsVaHdnBAAU7ITx7Kt2xindsCOyKN6fZ1PxR?=
 =?us-ascii?Q?5nCvlZXd4KO0Ymk00AfSlX9sTj6gxZwMLyPX0EBjt+WegMnPS8T4iWGHoePX?=
 =?us-ascii?Q?0rX7jPjGo8rooDektrou7rEs5ccnrrch/KxKAuqoPuJ+Joe/sEXcW8U+DrNm?=
 =?us-ascii?Q?30elrwTbGIKmfKdgRogE4kFIvQOFcV76bc4ckpPR64sd3WOF9MUtMhN9wHR9?=
 =?us-ascii?Q?53odLum5P1ruv+sH1P/DNyDhuAUiEhbsAqCQo0mQHmyGN7kK8X36uFBl2R9V?=
 =?us-ascii?Q?rMfBhPOIZOEzL3vmuchvTmrN5so2L1PCL9ytjmCli+LeZoRtvHDusYtyPFfX?=
 =?us-ascii?Q?j4b75PQ8/Tx+857LAEeBZ6KwwayShCSl7wNs6H5v41r1zY0esEhZA7pKJyT4?=
 =?us-ascii?Q?F3wO1GmvlUc9pm/2HBvmuqRhQwjgAqUN5wlVuK720q5F4yiPmmoT6nZ8OROU?=
 =?us-ascii?Q?q1MkQ23THau+Jw1+9GCYjRTpalHMMWbSmXy1gcewwVrqltESBYDN75hgplJX?=
 =?us-ascii?Q?xfdBuQPdLv+HF5oE8HiesVDi2FeKO4T7iirXIfFALnZeOl827Ti+WhV5VU/2?=
 =?us-ascii?Q?S959X9oMZIX6oZ7x+fCdKI6cA0L8ZGwKz7Nlp54MGZN5KNOvW9/rmOVeHa+D?=
 =?us-ascii?Q?eOtkIO33Huze6VrDKq1HvJEEQNdPQSPFLpIRWyz3rKbFGTYpYGzjzSHRKewJ?=
 =?us-ascii?Q?FgHA114V2y4nAmi7IP96ooi9CKuZ3zjvWRp6WvQvQyVLsbMEqDgRcCKEqxf2?=
 =?us-ascii?Q?OmretQfCID2Zwp1vi2X/mUWxDV6GlrfJoVwdXCL+ModSfv3F2m727pNxo7I1?=
 =?us-ascii?Q?kQAsX08bXDxvPzCX5qJrttX6at3Lg1hzP0TVfo4NDiuN4XMjpf91CKq6CtVv?=
 =?us-ascii?Q?5t4Aj80PehJ/HRS/EhtWHk8amJozlzX5RmYBXNmi2hqXAYqvbK+0IetSeUmh?=
 =?us-ascii?Q?A8+4aOArDz/EPJIWdjuzKINW8zjfY0nMrL8VdOuYr25pmU9zVNi2iIEdVv+Y?=
 =?us-ascii?Q?VBYUciXycanfGf3lEZXJMtZfxiLDAXcm7HF/XnuukOwVIMg7NJEvbdEE15jE?=
 =?us-ascii?Q?f21HqO/A3W3y6F1fR/QY7i188dEOHQUaSdEHIWrxhXCyp9n7CKEcRGNlTtvV?=
 =?us-ascii?Q?mJJ3wl5bKEfTN/JCKuI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0268434a-2484-4365-cb22-08dc970d819a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 00:59:04.4295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8obXXTNdtoFhNfgPBHGz2/ph91wTHhdlP53G4Aq1Ojg86XB3YX3FVnT9FB+IqLK9L4a/iUgNE/eptHbHpzXLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9933

> Subject: [PATCH 6/7] arm64: dts: imx95: add thermal_zone label
>=20
> Add thermal_zone label because it may be overwrite by board level dts
> file.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

