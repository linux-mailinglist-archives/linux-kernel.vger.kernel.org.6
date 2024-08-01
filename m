Return-Path: <linux-kernel+bounces-270567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E4944183
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4072840AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE7613CFB6;
	Thu,  1 Aug 2024 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JIoNboC1"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9371EB48E;
	Thu,  1 Aug 2024 03:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722481494; cv=fail; b=fvPt6Ck00IiomCvmkkrVH3Rl8uYxs5MLzP1nqO//mt+I1u01K2xMJD+5t2TpXDP5uGvBSgcJ8cM2dZSxcCAcT8saQhv0t9A0KpNWyRl+u7tIZWau7dmU4/MIbQoCD0p1yCMmdjT+uDi2jS95bwPaxRTqCc+0+zNDBx5QJU7n5hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722481494; c=relaxed/simple;
	bh=NMq8UtyRpXeCQwY7DZ5KcVEs5qS9DSdBqXh2d6KlrBY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m5hS/SVx2TONmJM1l+cZSsFVAzVWVrZ3r0RhpQdHwXNwkkTGz8m/l7gTo1dp39JrIMDoAUxTUsNOeRWkEtPUffSdgxTcr44d+wfTQnx2xKoFcYmzrvu2SkTgiA82mpJN0c8BL3maIOGeDkd4eC/XjuJLmq6/Z43uLUz89VQReAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JIoNboC1; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pF9vwuwDNd6MxP6AhII8XV4mfoEfUKr6xOHx5gGWvjSQ7PprU89lhyhaXtXFlI1AA+q7gKr0cqnAjO098JzRiEXQm8c6JfcMJAws3eermI7MW6ZEU2Yyp/8gSuWbCtIrvgBszjwY3nCCwE/kfwlvWV9gP0VQKKgqkGx8i0NOJL4hgIv+MygxG+39u8c01sld6o4avyPECXeNdVy6ZS8sjW/Sg1RLVbvappyBnFMlN35l8EkvgCaxo60IDvtSx2Dxfe/7//yLCBVSYQ41h/54mgjcnQPc9XCIHbg3zNYIerJj/fa/lzMgxnNuiEy3J4G8sKIUMW/Svm9/YQnSZlNKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuD5v2joQYFy1biv1v0laz7ICj8UTzBV5Q6q0qwWrSk=;
 b=TsFOo1jPWudNw3WH99VFkGTr3dybB/MSipP0Gfx3kDlaxJoJk1WTHDDMOAq7bwos+ZLqu++Zj2Eh2P0yRXUNDYdG0v7PbrfH8zqn9YPE1YO4bc5JoVYq6J7TTSSR8O+Hi3l9tM05kaPUEWp2ielZlJABfvVJcIJ/Ec/LUm5wA7pR02EF6uFsIpfBCChccfVrKcwJSsGIQDrXut6wN8dL7dDJduFpSDhwP5a26izIht3DjvwiLuz01SwO+u02Td96MQqvfuZM6PDeFqXnz83snzXSacGW2LZsXmqKi2+W04NmwLl4sdDJ+pM1j2RXLfR5/1qjzNpg0lFn8oywQ1rHxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuD5v2joQYFy1biv1v0laz7ICj8UTzBV5Q6q0qwWrSk=;
 b=JIoNboC1NK2AGpCkU/J0A/SrPSDP9LgZTk2Z0vS5u5S7WPg5yHZntRVLifUj0LVZW+pRG306bNihGxX03b0rwNKxhZh+gie4uNHMNrTGOnRM96Awbm5mzY44yulqq1yoBJ1q7+hqsgTRGh4M0gaDwE8DfuKTsivF5FkoztmxcpvjbYKpP4gqx0S2sZHl6BMosDY1aoEva2NIG8yyWt2UhU8xj+mx52MERvEHHbWjYNzeVBEnS0mxVglF+YJ716v0IamfsELKvTtv+/j4VBcMHTvd2XfmoceK02IHDYORrVPYBPP6AMmzAdBizTP62BLH9Pq4TrLUvhK3dzCMLjZt/g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7925.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 03:04:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 03:04:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: Markus Niebel <Markus.Niebel@ew.tq-group.com>, "linux@ew.tq-group.com"
	<linux@ew.tq-group.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 06/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla:
 improve pad configuration
Thread-Topic: [PATCH 06/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla:
 improve pad configuration
Thread-Index: AQHa3cmF/FragxSRa0ClKsbzpJFz8LIRwqJA
Date: Thu, 1 Aug 2024 03:04:49 +0000
Message-ID:
 <PAXPR04MB84593B8DF03B5CFA7CA2D29F88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
 <20240724125901.1391698-7-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240724125901.1391698-7-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7925:EE_
x-ms-office365-filtering-correlation-id: d787b5d9-bbbf-403d-20dd-08dcb1d6b49c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qGEjwpGOMPIA3ia6N/13MBWKm01WJtpgKvqKDEJJuMS0ksmzfbPQCO83TVsI?=
 =?us-ascii?Q?+sQ5H+ShyFGI2uEDlXqLo2WvzcgLjAUHZ99YbN4fxzAuCBpdeht2gitqX7Ve?=
 =?us-ascii?Q?oBOjac1GEfTdQWiL23qu+iRP76BKqPdblWmW6/610mCJB1w0WXTiFDu1w3oK?=
 =?us-ascii?Q?6tadCgWBXJBag4rWww7mgx0qbQlqwtVp1feZF2qPRMg/+AcK8JJ4pZQud5lx?=
 =?us-ascii?Q?JjrN9xWERl02RgJ8nKWx+mRYLWP5D7DDE58DdaDIk5vUCYBasRShebwqc226?=
 =?us-ascii?Q?PObQO1pimGOSrESpUgrTH3QlsLE3PL74kODvwP1qv6AdML2slTaipJqdar8i?=
 =?us-ascii?Q?UHUo3Pr6lGlAGf7Sr+yoODB0tBe4stB78urtuEzV5vBdFFswOjyq8jVTdWZZ?=
 =?us-ascii?Q?XTRcqrpHTJgSqKghkSM5ZEs7Zok2uWfW0HtFydNhNgwr+/xjJqlnSlpyCWFz?=
 =?us-ascii?Q?kpSrjbftIA3zAN8Q1PdMomRWJzeSMWNW1GTt3/hzFYMGDzzcUkS2GWZtx7Fi?=
 =?us-ascii?Q?vWDCFtT/8mkC23krLCI6rClNTlQqYMWrCPcd0KVHNGFAt/wVizNW2jvkOzJl?=
 =?us-ascii?Q?jR2WrrFhFNg+46ExFTvXH5AoEKCVqjzwdrfFp5YPnHCJefwLrygEJsLl8JGd?=
 =?us-ascii?Q?KQ/0/CuyKoH3dkKINRM3DKg+AittV0pvvGl7lniiQnI1Ixb1kmAFz+rTQvtS?=
 =?us-ascii?Q?Z+XSAhPLFJQUzbIWc+Ub5fvXYEcbz/HGQkgDny3NRsUGRTS1oIGqyYr01bEm?=
 =?us-ascii?Q?uH3NrGxZQA3OA0unlGBoGoaxQLENG4Ckg0B0fOBR2zdeb1lbXNhHJ7p6cT2q?=
 =?us-ascii?Q?72lccpONJC5rtNvokQ/FK1vteKyWpNVyZLDqhcTdzmERO70vnYinGLrwZ2BQ?=
 =?us-ascii?Q?/pfuTNSasPUDVze0EY872rowgabpkbuJjkc0HKCQUjAFnLTKRUi9kpN/mhlI?=
 =?us-ascii?Q?PkfGGiJDf7Z6mkcSKVbwVJS+7c8MdnKleK2ZAv5N1lcCZCWu/PuomZuot3vW?=
 =?us-ascii?Q?Kz0d5lizBEVpjuOLOQNMCt5WRRPwWVUjnofuBKhXG/aue95koUp5UyynSFVN?=
 =?us-ascii?Q?XE8j0EMj7N8+HVAU4bbR7sIfWkLqsoKFqzuY5mmK0HxYmay6Z/paiAyh2YbS?=
 =?us-ascii?Q?G8LAhl2eA+0t4uEqPu4lV57a6LBEMl0bSXPU0Wpf0hBWKXFGmepBrnv/ZVjd?=
 =?us-ascii?Q?HtVkbc2Aa9qZ0Mnsa5GocrJhyTWIv/X4psxidMPcluEWNkpmyE1imk0xmyyv?=
 =?us-ascii?Q?/1p0t0C4JADhnZ+dUCiwJf5Rjw/zNxSoVqOHr/jnfn8b44cfVqyWqDyT6Vd1?=
 =?us-ascii?Q?CRdNHF5lcmIBvYuLXgi9bmmxOolmJTM08aQ+MUl/OJdP7UZ+d41l+5orl93E?=
 =?us-ascii?Q?vCJhp0Utw+LgId1KK4qaVg5LBDVX/SPGIs+POqqjX+AnrAIyTA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6mB2i9Z72WSfTZBWb1gfTZcHzIO88I6mCchqXMAjAEYE/M9VBUh/c993PeSz?=
 =?us-ascii?Q?bFWz0+aSglYypMbFev25IJ/PkANrvEpJAuu92wS8cpjbJN+2jbdGpFi2NW88?=
 =?us-ascii?Q?tlHHGp3eGcCkPAB0goC+bfVZNLukmZEmZqBOvbmpTEvLUTHOow+CUY81SA3J?=
 =?us-ascii?Q?g4Sq8SZcMQq+WYzMS49EypE3xWW2CvhmutkvrjiStQRWfF7C9LEErhYo2chw?=
 =?us-ascii?Q?ZpWoziMMjE9tr8ROm58n3j1+5uKOKfMdY5mMQnZHm1aWeAoI9p4Q05OFcTDc?=
 =?us-ascii?Q?VLD3MCMTboPiJmhZsJkjcnm+C9ejIj+8oSXX9xC99PFtvuCuFdclunbBp2IQ?=
 =?us-ascii?Q?dbd7HM451CPgg8wNOb+os881zw2rqkAWtt8WpC/h2rb9X3hY0469N0lWSrJw?=
 =?us-ascii?Q?Us0z5KNyPtPNUE+TfkGjP+M0UPHGrS6FMiYD1QRvfy7LVfNBQHdjxhH8DeeL?=
 =?us-ascii?Q?xK0tZghPxH6wlqcGxx9jmt8QiicU+zdkzt2QDlf1g9CxY0YjM2iMv+2QdWmf?=
 =?us-ascii?Q?61nOtWQM/vNHaCsumuIms+5WEoUrLddkLnGoVJeDb/m49d+bH+KEi7AViCuv?=
 =?us-ascii?Q?mlaktYYdQ+/P3N0r/lPl6xXlkcaaSqfSOsqMu8DZOPBY+0g6g5wLFUb00xDf?=
 =?us-ascii?Q?e1h/ctI6E4a8S0cnSowFHSoLsH2KaPMYnM4dhYk9xAutnJ12/4q+Egw2hTUY?=
 =?us-ascii?Q?YJbZXx5U38gJqYMKiMwm3oZSosvUcEIytWErwD32y/d7JyGRecPOfmE3TS08?=
 =?us-ascii?Q?wmK1UC3X6WoF+DaGhnj+b1EGGecRttr3YRSLIiMpAx7oAemcWmri8zw0VU9m?=
 =?us-ascii?Q?tXdqUo4YN0UOqH939nO5GUr9aX1kcyWWW9OsC1FpQaWst/Hcr33OWnykcvq0?=
 =?us-ascii?Q?PujUHFb1hD6/dT9B2jIJQgLClhTyHkWHWzOtO8RPlpmcY69WJ2Mr4WcfBRtr?=
 =?us-ascii?Q?LS1dwvTcOnp7eOzzXzfP5yAzamLPl/cc/etlQljDgsNySBT+cYwpiEdvW6Xt?=
 =?us-ascii?Q?tTiYZLxALB48vS/KLaLEIzZ4dc970OJXnikZsU61IMVyFjQ9AczCgRrdovnO?=
 =?us-ascii?Q?Rg2nqbh3LNqpd9R65WLByHIK64yOl1YY3A1e+D959AKks74eNNVNC8THhVj9?=
 =?us-ascii?Q?LVBawThUvdBuM4CFMLKTTLV/bu4716Zkf5x50SUFz4X3bQ3wTxWToflsHKSE?=
 =?us-ascii?Q?eWvUaWSN9qgbV9RqhaFOqqKFXjV1in/hL9Sq/BpTtyQL/4KNpfNupdoTc47V?=
 =?us-ascii?Q?iaPyLkZnB2S2kXlgpbI5kWZf5Ap8hnfTWSDITfm+1xyEoNAcoA99UDstspZn?=
 =?us-ascii?Q?0j3JMInDUW8rHY4hFlRP0oDcGapz65LmeKGEzTKfZpCV+ZsnezL0hgOL2F+T?=
 =?us-ascii?Q?DzfL8nRP4DN42bFzVvxVHl0mGYgUIa4Bu2nzS4Ghxqur0FrxBa6D6CKRSEk8?=
 =?us-ascii?Q?sbvKzLS2XnpVyK7d3f4niYgUg6RYSi+qY4mLM4Wpdbs60/ImoPVXegqAx9UJ?=
 =?us-ascii?Q?YuuAJK2p93dnVaoEQ3g0eqabEF1siDxjO2FF3JbRcuY0VRNSGSsWKfsU8IJs?=
 =?us-ascii?Q?kACaC31o+/MfXjzjw1Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d787b5d9-bbbf-403d-20dd-08dcb1d6b49c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 03:04:49.0951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60Jj+3fACdzCxNZbtun9jZDgFIwj65e0EoZuAANen0285pMuR9nd3VvQpCuQhTOMqQOzfWlRrMRFICgmFqDMNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7925

> Subject: [PATCH 06/14] arm64: dts: freescale: imx93-tqma9352-
> mba93xxla: improve pad configuration
>=20
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>=20
> - disable PU/PD if already done with external resistors
> - do not configure Schmitt Trigger for outputs
> - do not configure DSE / FSEL for inputs
> - add missing pad groups
> - assign muxed GPIO pads for X1 to gpio2 node
>=20
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  .../freescale/imx93-tqma9352-mba93xxla.dts    | 237 ++++++++++++----
> --
>  1 file changed, 164 insertions(+), 73 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-
> mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-
> mba93xxla.dts
> index e2ee9f5a042c..c663b6585c3a 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> @@ -222,6 +222,11 @@ rtc-irq-hog {
>  	};
>  };
>=20
> +&gpio2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_gpio2>;

I am not sure this is correct,  what are this used for?

And this is new, not pad improvement.

I would prefer the other improvement part merged
with patch 2.=20

> +};
> +
>  &gpio3 {
>  	ethphy-eqos-irq-hog {
>  		gpio-hog;
> @@ -509,25 +514,39 @@ &usdhc2 {
>  };
>=20
>  &iomuxc {
> +	pinctrl_afe: afegrp {

no users?

Regards,
Peng.


