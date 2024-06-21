Return-Path: <linux-kernel+bounces-223777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A742911810
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA241C20F78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7668249A;
	Fri, 21 Jun 2024 01:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H7c+XXED"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2061.outbound.protection.outlook.com [40.107.6.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E037E110;
	Fri, 21 Jun 2024 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718933793; cv=fail; b=XR92zWB/mz00w+srjxaeSKqYcfMPWmi+GW8pUr+SzGSzjIl5/LCJNoQHY74V07LzCp6JbZ7wMEGeMgVVM1uwVwh7Unq5l0BN4HGa6XGEWiPhFnppDkDcgGE8lERJ6jf2zGSmPzjPcZ43zp0o78pdC9QYtrbvIX6rUFErpSurJEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718933793; c=relaxed/simple;
	bh=H7wtZu8f9S2YF3hbkGeoH+C5muM8VSy6k5nIrwzBEhs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tU2CjUVS41T3rLsRCi5p3H0Dn70BbILOpsGmBZQSQwobqlHkucc/E3wrlI+Y1oSRLm7jOdy9BLikBMaBWNu6/S0w/Z8otxb/hcuIgjyF7npOZKZZEC+MLo9ZoaqGHq6bsbXobasMvXWzFmOl+KZt+zP0pgOrR7JcELyOq/ufgPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H7c+XXED; arc=fail smtp.client-ip=40.107.6.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN35OYy9yxBr9DmBfHB5xteMb0sv2/pUs1lsrIPR1P+vE4wN8uM7WifdHUSXXjFav+jJyXbhAK5n/kgM9kls3wGzdAHktptCVFkfdHiz+c/NWeNwl81qzIHiCNMbvXIAdPudZRf+iriCSzWx7zznDKDzx2LksTvr8Sdj3vziVv9Fj3GgOnrwhyLawxjMzFTPAZAEaWHn4HQQmtRCHoORbF/q5mhixAMfCM8jp5CC/2HkZANeHw/H6H98zcW8wvk6+8s62WzqiIkikIQKXb7HdYR9OoDwTzHAAiCCxRqlkRPQANV5ob1kheJlDhDJX8ySZXodGthtnLXWxzir20FdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7wtZu8f9S2YF3hbkGeoH+C5muM8VSy6k5nIrwzBEhs=;
 b=G66yoFv+PFtoG7x6UUKwRyNB4DL9vgxXOVME1tQmBUPN9KmVx6Rd4F3HlvMFsvawAhaJInBo6s19wu2hVk2e3d31lGlvlpyP8jJIk4nTDuJy6dbK0V6Hb39iPHbVyuJAn5qht8NHQuJltkokYkz4D9W0+EVEtVIoOxlJgjk687SaZdFnRAwYEZAoHmvGwm6Enazr+gjhBuxslCPJNE1pbC/BX0gDpCaW7aF3GDMO1cQgzTFfibKDLNUpwMi9czJONUYWLBXYSwBiLefY6GeEu182wIM/w+1DjiHotsOIzmeLarXv1XAyjWVkHVCZHPZffcfWTu938sfy7rCL5dAY9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7wtZu8f9S2YF3hbkGeoH+C5muM8VSy6k5nIrwzBEhs=;
 b=H7c+XXEDWCL7H5e7glkFQiq6Q08v8s1S1j/kdSEQYFt8YYxQqOKOkx7t3iQc47vLDGIZStN0Mz0H7/NtqAeNnceOq0N5aJXYCeoLIRtjqDyK5B+QH0zC8nSMUFPsXPOKJxqRhABwdtu+eWVcj/dKIoXsHQcF4AibC41AVpoSkIk=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 01:36:28 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 01:36:27 +0000
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
Subject: RE: [PATCH v2 3/4] arm64: dts: imx95-19x19-evk: add lpi2c7 and
 expander gpio pcal6524
Thread-Topic: [PATCH v2 3/4] arm64: dts: imx95-19x19-evk: add lpi2c7 and
 expander gpio pcal6524
Thread-Index: AQHawy1hpmY8bScXJEC+62K4A3HworHRcF7g
Date: Fri, 21 Jun 2024 01:36:27 +0000
Message-ID:
 <AM6PR04MB5941DE0CC49993C143BC304F88C92@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240620161622.3986692-1-Frank.Li@nxp.com>
 <20240620161622.3986692-3-Frank.Li@nxp.com>
In-Reply-To: <20240620161622.3986692-3-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DBBPR04MB7737:EE_
x-ms-office365-filtering-correlation-id: c98f21d4-d8d5-448d-8d62-08dc91929199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015|921017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?r9yepJF30UXueDYfi4T6C8d2j2Gt2xoyaAglyeOi8vKafB/qXqeuFMqg9Dnz?=
 =?us-ascii?Q?h7uEY34owwtm+tdqcb+TzqRu8Jt+QmZlFk0mTOEz88dqM1A95k8JbOV5I8WR?=
 =?us-ascii?Q?bdEPptXvreS7mcKZcb6yi2IkVeVqbIXt/fc98JVdV39oB6pgFyGNTsdJMJJh?=
 =?us-ascii?Q?jqT4ZuhEza1ATreO9/G10o3ELWnGgLA6ex/oZKSjb1BC5lmiBZrdPHbxjZmT?=
 =?us-ascii?Q?kxpNKzuv0mQM0zGKGPJVFPtobOQCreXJvoLAkArML4uGQk1KKZO4fx6rzs/f?=
 =?us-ascii?Q?EL/Zj+7dX15gkwLhoWp6wzSiVltAAUTyNZFlO/Z44Q1fnoP7648soeLSkdYb?=
 =?us-ascii?Q?W2UIWtDim5s5xGyVMHd+L/1RX6DAjVJ6ie4P5tyvRCjgHV0mn3FE2gfHa9ke?=
 =?us-ascii?Q?NyT3r3Ajku2kri8JOf8YNJDMFZeLAqzRPNngGH7GEV9EeIH8L3shpZAPouBh?=
 =?us-ascii?Q?yelxgSfkPx8quQiI/c8ldWXC2A4CvorBafYgFUvtnTy6Y6eVwuouiAHOAgId?=
 =?us-ascii?Q?nVPeUEablaxFZ12cO4rKcyefM4a9BiBHsrvMHyN15OsQ9jXdBpNEIzfViYhs?=
 =?us-ascii?Q?cvtrlv3ri+OqPnkPKsHKAXI9+LNAVVtCDp1GR+dVgnASsx8sirYiab5faOjQ?=
 =?us-ascii?Q?bc9zFw3Xw92n6fxGJ9tlE1pGHgHJ43ZNg44nmxURvq3UOORBC/RJ/ebt5jE4?=
 =?us-ascii?Q?OCdGJxAtfl+NwLBwQRdmi9pC/SnjuD5e5QsqdpWfB02DtZMPav/ZSBVizUeC?=
 =?us-ascii?Q?/XdP0AqfvzrZtfpi/pFNI7/H/PtnHj0h8LgJU0Z16khs8s4jeNBeWzGSinva?=
 =?us-ascii?Q?MtOMK1gPzLlP9iKoOpDwqvZUWQ38Jwr5iLyMJ4IrKs/qp8iF7PN8Q2VkeVKD?=
 =?us-ascii?Q?5wRRe5LghEr/zdc0RJV0YbfnKANROWjB9/owtV34HjEVFV++f15SIPar1P4W?=
 =?us-ascii?Q?k7dpat7nuvKXpFR6O8xkscmZVMSLwmdQs4S7l447EqhwBU0I7SDg7NfWnDDR?=
 =?us-ascii?Q?yj2YSCiVhJAVEQlwKH3Ov59I0IhRS8rmA/7lERe3mEjN2X6y1VUwg2UJA9si?=
 =?us-ascii?Q?WhiWg5rNu+u3BI34lfQ10hY6Ez5mrrGg/z6xJ37r7FY+eG0omerp8CskKTJz?=
 =?us-ascii?Q?pTRELyzp+XEcA4oNdtPnHJgrQDzhkSE6fqbKo3QfcMHQGQfM2vzzZUZ3UMHG?=
 =?us-ascii?Q?HRHIntVCI4l+dY0lo1P7VTqf2VwpOC110gKt/RdhYOPmQR9OtI6rEH7gkCws?=
 =?us-ascii?Q?EUZEOemExpbNkmJK414GTXt3fGoeAlIugCujiYoXA0O+HEtmIPmfUQTYUQ/Y?=
 =?us-ascii?Q?JoVLL2elRvXDa7u47HPmr+6Xf04NyWPMn55hvBK42t20Rd9jkGOdzhPqhyPR?=
 =?us-ascii?Q?VNiN0ftPw/uJfhJhxsWJOLPs7RLB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8MD+ixYJYQlP0y8gQ6keCqT0LCJXIGEl1SympuCaqORa7glI3+iJIjtVHUmc?=
 =?us-ascii?Q?xIkv2PK695bba8toTDFTToVwxXVikE/v1ivt+F52hoG4zYEMrNxnKAYuc35m?=
 =?us-ascii?Q?xAd/wpfE/pcP7TvhqtROYf2WHKCK11mo8sqTIpruG+/ue7WNnuFhJXEv8brg?=
 =?us-ascii?Q?JUgP7fpLQUn06KiVPPRyz7M3iVPlMrQQgB8ujq45cjkNeqHhhrJLnJUhHssp?=
 =?us-ascii?Q?OziZt24rdsaTGi17jNPpsGrZMqsktvZCh4l7Rq42utf/8KZlBjNWYZYg7FtE?=
 =?us-ascii?Q?j72ml2nrD71rDFgQktNk9yH2wIO69h6d4aGzJuVhCtvaFlTW1gczhUt0i7kL?=
 =?us-ascii?Q?U+cd6F467+8lDcM4EDQXmlSo4/EhyySoL/pbrwjeGWVEhI0U1y1EQYNHBkJK?=
 =?us-ascii?Q?ovdZEmlYCjUr6WLkEYo/ili3JwVB9tUunLSUZ8G0t6uFZah1QOcpZzExvHLT?=
 =?us-ascii?Q?TOOuR9AOthgVFGhXK/VP2qQH+61zW/+RqHXhn1Ph+p5HT3mlcx4Bstytk7XU?=
 =?us-ascii?Q?xjhgFh2vRF9tdUiXQCU7sBR9UiYW/K0/qq4o6moeSFATiQ4t3sASC7JKgpte?=
 =?us-ascii?Q?VrSSWLlVy+RSZPAlgnKf7pEMRnPSPRoUTqvpHwiVKQVe1+iUX2YHHrhBzoJ9?=
 =?us-ascii?Q?AyfDAUH5RXv/fQLnD1l1xP46OJuGgCrjP8d4D+4GHh/EaoK0yZ1d9lCu6PIW?=
 =?us-ascii?Q?UxQfMrmdd2Y2AiJc3bimJxd3GS5o9Whn2qcjVxiH+0ZcCwfis6wFf+RQvOjp?=
 =?us-ascii?Q?UzT0PcDfc+Dr/uYmngc8O/5WGguNXIIPNakz6PO2GnvpiGHcDdZkqh9zwfuJ?=
 =?us-ascii?Q?CE3nwkSkl3WXx50NoiKfeWubAH0OK0ANKuGp6QliPGUL1LncujUuFuU9VaXe?=
 =?us-ascii?Q?JVcpoKr7zKEcCl2BAyQr6CzbVJrWf5ZRLaUy5qAxm/ansze5ZF7OTvE1DxWP?=
 =?us-ascii?Q?FAnSqOadb2drneIcmTQb10a4dxEu/KhUTRc2BmG/5BaIIA99dgP0Zw7nMmK0?=
 =?us-ascii?Q?UvRIBoaPvr5RGWcO59CjXvykrNfwkL8juQSaL+o7vt877SyqNICrk0tFAiQA?=
 =?us-ascii?Q?8ZvmvhMc3NN1xk8Hxf0SmYgCR8Ogmh1rFX+w2WOBuqXthtG6K7bBg172lpxa?=
 =?us-ascii?Q?UhHSJlNBwuVpxpEAJTEFzaSXCRDX+NHH5KC0r21caKbZurUZxMbxOLP/0Adn?=
 =?us-ascii?Q?ipe/PjdOWTiMMrCh4I94PDE+TFg06xo9PeovLAb/o+jE94yNn0eLqnL2D0UI?=
 =?us-ascii?Q?pygPwVaOuPNNknaZYqfH7IZ/r/m1c7tSm5aW7dhc58DWV0wTniW03m69pZBM?=
 =?us-ascii?Q?mFwyu/zsEUBK6pYkJ4WrbHXwJdChSqYzGHfhahP3mP4PdparkxpJXmBc7hra?=
 =?us-ascii?Q?/o7ny2Ait0a1fRP+QS+nR5XaMsheQhG6UI2Aw3I4apd62J8xNpFc48/31vhD?=
 =?us-ascii?Q?yFlH6lZabtbDe1TL5b3yFQLgJnu0JDUpuJvf0Z5BJWrKaMRRHTYBr5OVqzbU?=
 =?us-ascii?Q?11lIzI/30WfX6YDxdzIghowkvfAwSCLjQXOZ42RPhXKw06UwJeJudl4qvNPs?=
 =?us-ascii?Q?Mb0torBBi+tMPmQuJG0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c98f21d4-d8d5-448d-8d62-08dc91929199
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 01:36:27.3313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k2OgI9lenkJ9T5OhNMxlSA+osFUOjIBaFnl+ogS/bc7FiI3HMbJjjiTY/8YEfCy8jUwRr5EtQCCACx4c0QhZow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7737

> Subject: [PATCH v2 3/4] arm64: dts: imx95-19x19-evk: add lpi2c7 and
> expander gpio pcal6524
>=20
> Add lpi2c7 and expander gpio pcal6524.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

