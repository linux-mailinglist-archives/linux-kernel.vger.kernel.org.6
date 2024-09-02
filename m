Return-Path: <linux-kernel+bounces-311054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B01B96845C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3551C228FB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7886413E8A5;
	Mon,  2 Sep 2024 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bVQ6ltYe"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013039.outbound.protection.outlook.com [52.101.67.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7A13D521;
	Mon,  2 Sep 2024 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272114; cv=fail; b=S8/PoygfbDFt3JmX3WNWSg/W3eSK89LUeo5C1amr9kQ36cBpfDAjeHOoocOPXkEfMDJgeFSFiXhsoL1y9W5le/SWH8Br6fGOgBN2paQ3RciokUOsIdVq8GOZmQEI0rV6cCWJf0L0lorg2WW/SC1v+YlzVYJevDdtnO62GPvSXW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272114; c=relaxed/simple;
	bh=4/ZbbNE4wqIyrmu/P+d2Xz0z0ULoNLTPkOML/7fBwkE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BbxYKEhzthmDdTLRbypOqwEWE5CMs9QrGgmfPlVxZhSzGkgLblBzoSotkO0HC3PjG7QffrQC1eCzIWai8a5oddrvTfVu/yT0aYi+unn2PRf3NTuutoJJZ/rgHL59qu5FQ59ySEzzDLdl5o995qQ0pt5ChtBUvGo67Tw0XnqSFeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bVQ6ltYe; arc=fail smtp.client-ip=52.101.67.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzrcR3JkAcTWkSlCmuvvvn286o1uuwkrgFrq8SNbtuGldFqXolTEKuQTp7A3/vcACvw4VMmD6Pzm45xkmMDPiqrUMMHWMkK6ekLkFY1KFmIS4ZrgFlZPfvpPyYHnztfyxQY6ymPHCbPgbi0yS+uaeskJdNViGBeUZjT8qRpWhkWYyErQX93Pgb4WIKQZ5aOpFu36QMjZwuBXwvWO09dhfMNfhYpBVF6OUQBRtNn91D+2E2FZpXH5JE0kRIDl/3zWVLtJCg3TVMbl0qy745y5gkv56mYqBUIkDr9qefX2fiXmrq0hG1M6QTNDRAmLFNzzF+iIfANIAymluDkxqgCTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHfhkW9z3xkmBL78OSrx+dKpVx84X8QGW+9xmYnvVW4=;
 b=Vpu7lR0wgweCmDUxAY/rTYejWQpF3i9WPLDFOLjU+xXzZipnNehDvjTw4ASnpMP86knGcjQocNPOQasxXwsinF3ZFbQqSPIbYhg0Ds1sWJXQG9MdEsyDyULMA+hTlNLzs5l4ktkeIgg/hjL7KVlFIM4vMvpZg0xxE55nWaY8tBSXKs6nXI4bQSwvqCn7hRTXlkh4khnkvYyCCsWWiojHPKUovTF240a4fsQcEepyjLIGfTekpsDJ9Labq1r7axLgiwgKFaxBv+rbouE32v//S/RuaJ2C5AbBkvghby7CPRAv8FJ+RJQd0Twc/irpUs/PnKQ53f2+NVXiXWv+/zIK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHfhkW9z3xkmBL78OSrx+dKpVx84X8QGW+9xmYnvVW4=;
 b=bVQ6ltYe0bVs4uGF6jCdvOq8SslJI8NGyMEYAP3aE/wo8UOY6TGpU/iBak9RTshvsoZvAeSrm/G3FH4Q3zaWFFBh4XshBD1j0SHYFWO01DHPvE+di0dOSq5hw4hCpOW9fq2RSsZTKuKb0Ab+4uZZz8ibG7Pfk48SSDw3d8RyAlQ0SAAB/aTf5zgzGCVURLpW8NVr1ylH+2bC8fNRzwl7Xwn3Dr5uRzOUCELIYNk2MYbcRn2WuAkcSWx4aErlJtZ7NRPAM0X7XLZgAQD7UrcxwZJQRFhfWAGGtvhwFPBTWhinqvyePvUgnERYIN90gDaaEma9DxShi5C5loihUGpdPQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9096.eurprd04.prod.outlook.com (2603:10a6:20b:447::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 10:15:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:15:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/2] dt-bindings: arm: fsl: drop usage of VAR-SOM-MX8MM
 SoM compatible alone
Thread-Topic: [PATCH 2/2] dt-bindings: arm: fsl: drop usage of VAR-SOM-MX8MM
 SoM compatible alone
Thread-Index: AQHa/Q0X9mOzJc/GHUKwPUHeDPzdobJER67Q
Date: Mon, 2 Sep 2024 10:15:09 +0000
Message-ID:
 <PAXPR04MB84596E0C1F9ED62F6A5B5FCE88922@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240902075220.27971-1-krzysztof.kozlowski@linaro.org>
 <20240902075220.27971-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240902075220.27971-2-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB9096:EE_
x-ms-office365-filtering-correlation-id: 5bf61134-7457-4269-83b1-08dccb381fec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?W8D6mbYnNxuJpyEJzcJKtCq2WQF219kICJqQTK6LeB6P0QvX47rvFvpvy7+P?=
 =?us-ascii?Q?5Gzum/ROYPux5U+2LQEJLmp0XNePKyYdQ+8eKivKcyr80HuPAPHmvs76UXu0?=
 =?us-ascii?Q?mU5MRvwPmqlZQbBVdbDBBKTm/tkCYzAB5s+mAMJH7flsdat/pXLPf7byJAGq?=
 =?us-ascii?Q?ZyAMB+ZB/4J83vmPscnm6XMd5wu3Xd9rhgbY9vQZRFULnIJPr9n5auzHeGnh?=
 =?us-ascii?Q?X9R7zqOVJgZxQNsfcSlUBdUxTvcYB9tTbQdCnFsT/9cR4G4qTj8M4WiXyzWo?=
 =?us-ascii?Q?XuxRNUHEjZeyJAHwBvTtHigYgmScQE/BvFaMP04sG0zVbSDXG91As8cU1eLx?=
 =?us-ascii?Q?OFC92vmJmsgPEw7Ze3+uUeUpyh4gBBjCdbrF7HAdMO+eCkcqRI72VcDG2vi/?=
 =?us-ascii?Q?4v+qNnOY5QdqqMhKI5VE2kOholUhqvTAJgTwh80gSyTI8SSG3QXYOiE2u7Ij?=
 =?us-ascii?Q?MSoLCfdwFqoK/mN+yyzzD+d7kvuxicvLPrDSvMes1lL4mESlXXPLbf56Z2Mb?=
 =?us-ascii?Q?uzI6cd/zUnJPOXIfAQs+sUzrv3xKWcBj+67dvO+kBsMK7ZLoiE26xhJPNnyg?=
 =?us-ascii?Q?hmYpIO8Z/FqzZtQ3T4vl46tcK1pyFlR6XY7sAXt1Aidgjt+6ooh0Mm1Fe9oX?=
 =?us-ascii?Q?3lDy9VtvKA+2Wurd9N6J4RJce/23RLxmZPa8nJ8IeBZftd9FfGPuxirnxi2t?=
 =?us-ascii?Q?5hfYI9GS0yIDNY58JR5TP0ctyD0Mk99xPdOotM8eY4Z2+wgzDqGu4rycxXfI?=
 =?us-ascii?Q?uqa7YZRI+zfeKK+HXc2GRKcl3l6VK3obmnN72Fq1MhQrCNlsHJE+ePm1jUdj?=
 =?us-ascii?Q?/aAsWT4zTzVjvTB1OXX3uEWlvxFaKndLxpO9YPy7BGlTkSmqs7BCaL+lObOI?=
 =?us-ascii?Q?2CJ9iRhoDwcYbCPhYE1ZwMo+bxTSWOTrxl1fUThor7dPbmtx+N429FoHcjNw?=
 =?us-ascii?Q?3ojCNd7F1ytEWGfwlgjmsbMNRS/ZHdqlXtDExqY11B+rwsEct6VixoOu6r3n?=
 =?us-ascii?Q?bRJSROWtupw+ryZHjzvYHQsZ2295JCgNm604SPQ7aDWWI2k1gW2TJimu7KJn?=
 =?us-ascii?Q?+9nWwzLwnre22B14j3zhMIMHzvvtJWHO/hkqa/KpCCjCYcVjfEolpaGW6lTF?=
 =?us-ascii?Q?7R2UUgprW6Lvj8dcO7NBLAmy1tnDJXoXINY6Rp9WiPgkdAuJ9tDXYZebvgM5?=
 =?us-ascii?Q?JPONj/Y4yuwPkilIr+UJ7mLR11KOd4ZV9IDEjiQRxYEOpMcJd7peZ2PZ46gG?=
 =?us-ascii?Q?TsxwQMz5Yp+rDlk04MtfLPpHjSw9jIpfjHn/STBKMhn8VVBv3OcXjmhOlYZ2?=
 =?us-ascii?Q?j5ZF719rQqcT8wrFr00iwMBE0HSrmDUBpqgCB+sFF1l5ljDdwIJLrNEAisV6?=
 =?us-ascii?Q?esH/j1AsrXFdEWU4AHoRYhbA9t+7WFUzPz/0NYG2rU92AEg/Ew9xf4ICSgYs?=
 =?us-ascii?Q?MefRs2DZIpk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BY7NP5n74QU9Rv4Pvta7SVBEiD4DaSe+8wfk6ZhPrgAErBz4T3FHkokx+Eg0?=
 =?us-ascii?Q?+dM4HV58X2ZHQWC+k+5Oju5zWitHveki6bMputy0uyW3BUMXM4XHcZumBasN?=
 =?us-ascii?Q?pY+xKWZKn6JadqC8ime0m4LcDK7/Crrp/V1qCmgW0rrX8azVY39DKRjMkBnb?=
 =?us-ascii?Q?W5g1UBSJXtIRljkqYscRoqx3eU1HhS/Nsywxx1BcQNcJVI4TVrw2ASfF9rlU?=
 =?us-ascii?Q?akOkMqD2zDnAZ+AIve1aEnp4Y3FLN2bbTCq1PtcGihNO+QhD1b/FLVDK88YD?=
 =?us-ascii?Q?lZRMTa29XREJhW3O7q9xXDmVjKZkrnGxmXtd8tUwvfEqhpzY/9gxbaEz4SiV?=
 =?us-ascii?Q?t4i+Br3cn3i6t4OetvsE/+Sp7JHK/2EsoUj6rjEsbIxFayD4QBa1aN9ZubfZ?=
 =?us-ascii?Q?WFq3AynxDOzLEv0XoDXZ2Cj9PMRwtF1xdKSIm1Jk+m3kFjZUnhwpZfRYAgAJ?=
 =?us-ascii?Q?77HQBK4f2FbzjK1kL1zmWl/X6FRZw/gDQrQ8lFatkqUVVnsdJDC75p/jvsuy?=
 =?us-ascii?Q?7wtD3xHRNzdzCBRjQAOmmrFGLGZ7hB9A+5zAvpur2Z9BP5l2VB1wotwULkUg?=
 =?us-ascii?Q?TLNHIz+wuSahmoLhGlg5SkWBamTL7jpnth2IiOhUpRA5yLjuTgvMyI9AT9SA?=
 =?us-ascii?Q?Ly/9z26w2ZUM7w8x7Kiu6AHmVlG5TCWDQ6R2kvN9H4Uutvszxy0aSE1vtlmt?=
 =?us-ascii?Q?uwZA2uZmnx6f9sDBV7bC4ZuhnOauyxD1AB2javscGt7+eIRkYVhoVNsFcnlO?=
 =?us-ascii?Q?aF/o8DIXFnhxFi+UCJluvugHlasfD4UdINozgWKbC9axL08tMbhyVCjLY0D4?=
 =?us-ascii?Q?OoAceA7osWKWBa/vtgg0immwqveaY4h/l+G/h9oxgDcLeTWWGW8Onwt/kejU?=
 =?us-ascii?Q?1HGy2Jfyai+ksgGAYXxqNw8zaYo9XCKEFhDyk/rTK9tI7+lYfcl181w/qOGZ?=
 =?us-ascii?Q?xhXNdGTXH/O76+xmNKvVdAC33zm3EmME64QXJ1WTd/SyK7UM/nUr5UzvvIv0?=
 =?us-ascii?Q?GQj4iNErL4AHodLBarW4VHmSEh1Jlx+LRldfmllgh0mfjeAbdhQDavXobW5t?=
 =?us-ascii?Q?MU3Hl+1OZUI3k3ibwEyneQrdapkranPY7ToA2BZGOrKJFs979si+yWn1lntV?=
 =?us-ascii?Q?brCAoXkgGxHfLn3bkemkHaWI4VyeRSnwWzQP1eLALJMu1hv6bqcKv17DP62g?=
 =?us-ascii?Q?fRHt/5/hR1jDuYXsJkX62BYXLtuZc9MUlkwnMKtad/LMt+Dz9Mx0Adcs/FXs?=
 =?us-ascii?Q?7o5rHAB4dsvpOSb+j8TxFy3bkp9HQWO8DFRUe4n1r+oGBqQyMbVgbBP7aYJ6?=
 =?us-ascii?Q?7SkN9vlPWwMbUkfl6LlxoVlL55VEKZ2tyFe47H+qUm388NXOlUBGq5xdWJja?=
 =?us-ascii?Q?T1UOHyza5QiVj6s074m3By6Xsm+9F2MYrti+OVG2G6Vy3BPRNq5s6HNXUzXj?=
 =?us-ascii?Q?Lm+jJW+VZRqukc8KFs+ze+qHRgBbH4tA80YG36GEZUNoRgjGz3uAMqiHLGtt?=
 =?us-ascii?Q?H/ab7KvLpnbiuxhpYLWjSm+tLJnwh8Axh9e9PRlNscHYrRvKS/baUMPdRJLx?=
 =?us-ascii?Q?RqMNj6vP9b/CO47DPxI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf61134-7457-4269-83b1-08dccb381fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 10:15:09.3782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b93T7DLzNNkClsKMs4MywIRmHGHzPt3rb3Ngut8IUwP9dxAqrA3j5Bx7NB+s1CuDrzIQiFObQR1Trz1JVBZFNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9096

> Subject: [PATCH 2/2] dt-bindings: arm: fsl: drop usage of VAR-SOM-
> MX8MM SoM compatible alone
>=20
> The Variscite VAR-SOM-MX8MM System-on-Module cannot be used
> alone without motherboard, so drop the usage of its compatible alone.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml
> b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 1abdeb804468..e5f982fa750b 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -953,7 +953,6 @@ properties:
>                - toradex,verdin-imx8mm     # Verdin iMX8M Mini Modules
>                - toradex,verdin-imx8mm-nonwifi  # Verdin iMX8M Mini
> Modules without Wi-Fi / BT
>                - toradex,verdin-imx8mm-wifi  # Verdin iMX8M Mini Wi-Fi /
> BT Modules
> -              - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-
> MX8MM module
>                - prt,prt8mm                # i.MX8MM Protonic PRT8MM Boar=
d
>            - const: fsl,imx8mm
>=20

Line 1072
"const: variscite,var-som-mx8mm" should this one also need removed?

Regards,
Peng.

> --
> 2.43.0
>=20


