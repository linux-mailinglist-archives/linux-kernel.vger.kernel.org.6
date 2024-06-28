Return-Path: <linux-kernel+bounces-233163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2173D91B317
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CBAB2278D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E33D1860;
	Fri, 28 Jun 2024 00:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fc+jaR8t"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2041.outbound.protection.outlook.com [40.107.103.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A598037B;
	Fri, 28 Jun 2024 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532857; cv=fail; b=WNEgi9NFm4fjsDzKvh1ZTo6zLa13g+DBz2okDvvNg3mEkwgXdVSAMSRqvdavU29gzY2iSd50H6Vx5fZpl3QNP1Mg/b/Z9H5JjE1w/LeZZyk/bHMDHJJbFKSWim8MakkVnSYSq7b1usUq8egDYJe6an1jMwcUK+jvpaDcvxKF+40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532857; c=relaxed/simple;
	bh=pLLVukG7NpkuxUMj2RufKEn1bq3j9QuE7CPvE8eaN2A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PiMcMYRw98xa48KI/i7doFKF8UB7p2oKnCaa0IeD23YhqCLD3V2NUMUV0yivyNty8bqF47TOFRSPNe0kQsWZQily7NnNNM2sJC7G8/zBFLzoRvbVXt3mi9PPPe+5f4SlvzNPw+x/8DHLyACcs91w8RHUN/6fyvyskU25eZNxqwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fc+jaR8t; arc=fail smtp.client-ip=40.107.103.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4vLiICOknLSnVgbC4OMBfKwyBM21sRB3Ku3k7MaaE5zaRiH2GDviWoCkDtt28HFqIVlIqK3ZNXT9cfIGc4w4ok8RnQHe8VMdkE/OV5uyqZCWDSdQfZl5N+5OlCH+nJJLjCy2HrJXsIiyoWPLYzcAXC62BEv89L8Qzhjv5yeOplSG4Tjpkx3knOZ/xDWzV+JDZBtJLWePEk7kY6B2UKjRloR8FWCA4czmJ7s2CPHa4+8A1tUpnv/eh+f9yW/gkO+wXfywi2wS2MCYq85NuZUwC2EW/9CGvJHor67e++VJAzvxgnC/NEkd8wJ4DfWKvYMrMfC/ybhGZD7QfV0w5XitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcyFbEVX0BXR0x+NmgfJc6g35SUFWcBUbbyIqLKF4BU=;
 b=bwrtK0YTJBvarx96cbwRno8SEL/onUjEZqaErW3d2zcWZjuDauI3WjfzmXwNW5igrsDd3vnj5Al5W3KDhOL7Rgams2j98z4w7oWGuxrddbTGqcKhelf+C60Dl+Y6YzDYttGwFSGHCijhvtnEZ+r4j63lbZ/tJ5tjQW5XQXkezJg99udLKHjHotIrZE6SAeVuhcqVmZqT2wL/OaCUXp04nZvueWeNxHRi3IV3qSWL9Moo+JnQ15wg4/9vP/Xko53PcH1MpT23lbrwT0iyVZcQPaJZcx2HIUKIbFMUSU6pZVxc7z0s84bN7+kPafhgiX1+n0boe2JBuZhpiSwR4I4WSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcyFbEVX0BXR0x+NmgfJc6g35SUFWcBUbbyIqLKF4BU=;
 b=Fc+jaR8t7Eis4djltdOGEwQKvjqA7Cz8a8cI2OV347ylAxAi6W5Iqc4veaucIsGK13UhE1+ZPkb6LmqQzCyvbwnKway4hecKgHJ9IWMiujZPx6mxmJUWzRRIarE4aUwO/v4tHIaUHyGyZjNUTdkwwqcgdJFHcR3tBbHnKDufwUU=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DBAPR04MB7237.eurprd04.prod.outlook.com (2603:10a6:10:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 00:00:52 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 00:00:52 +0000
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
Subject: RE: [PATCH 2/7] arm64: dts: imx95: add sai[1..6], xcvr and micfill
Thread-Topic: [PATCH 2/7] arm64: dts: imx95: add sai[1..6], xcvr and micfill
Thread-Index: AQHayN1vJTE1OrAXZU2LQQ/LP2FrT7HcSqRA
Date: Fri, 28 Jun 2024 00:00:52 +0000
Message-ID:
 <AM6PR04MB59410670DBC0FC74937C801388D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240627220001.692875-1-Frank.Li@nxp.com>
 <20240627220001.692875-2-Frank.Li@nxp.com>
In-Reply-To: <20240627220001.692875-2-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DBAPR04MB7237:EE_
x-ms-office365-filtering-correlation-id: 7d7de789-eb38-4f3e-7772-08dc9705604b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UKm89XvyvrbScIGeiItWRt5bQ2x7I70LcnmK6VwPx8KJgCjFyrC+hIV5NuRh?=
 =?us-ascii?Q?tFQjTbo73Bjs/R+z6zbROs71ypjZEllgn9uMUw2nMIlfMcbZbLbz6WMvhhK+?=
 =?us-ascii?Q?QQJgTPd+tzi8WJrgtrRnlS3IS8RQaLAeyPe+tK65R8J01WjDGasENUKUy2Np?=
 =?us-ascii?Q?Z1S3ZdojFyXBvA1gNKNLOdRyeIeOZDVjubTdVTSYDUxN6H2f6KRnVubnLGTB?=
 =?us-ascii?Q?BbN+3v/M9rh8fTB2aX+Qsww3dlcn8DUiHJ+2LpnekTrAI6iQkziBcSLTl47o?=
 =?us-ascii?Q?7tBeLcRrx5jqzQQNvPT70FRpgNKLTxxaRP1s1Kg85409GPKAwBaTC78xCXzS?=
 =?us-ascii?Q?PcJ3jx56mwsKomopIepGcC/IREi5RvaMnWKxWOV1WiDdry9iHOGqdXTrziJC?=
 =?us-ascii?Q?F6Eijf9EG7X33SQ775BEcNFLo9DsaAVm+XwsqkVhASuQbNTUcEibltIqGYAG?=
 =?us-ascii?Q?1949mf2CD5Gmg3f7PXUH/ZActnfwn0QSUa4YfI/asgkzrwfuLS0I01zarcPg?=
 =?us-ascii?Q?9X7pPBn82Q6F7UrXa7c+Et5kXzlQsh/UjH8LuBCSZ89PkMTDLDktPfTHWUQN?=
 =?us-ascii?Q?c1lk98zwd26PWZqhgkp6RL6wdw8io9iw86R49L4p8M/gxvWtr6XFmxXQZTF0?=
 =?us-ascii?Q?DspAYzjlOe50m+xZbhrIXm81EHUFp/MaLVDF+wCTQt+sJsOohDe5U1U4g+F/?=
 =?us-ascii?Q?uP1SHCwW+OZjM8f/oSNp10sBcof4IwiBNpHoWL43C1vDPi7IuVZdBmuJrL1D?=
 =?us-ascii?Q?7qe0UCwZEvLB9IpyFNAx1L8he0W/n5aDVQW5K3P3+6zEz17U8j0+WZBYvOf0?=
 =?us-ascii?Q?WfmXijalzO2QfD9wq2/xFi09wHYDomHmbol6G6vyXcSawlFbLvXf8I/i8Hur?=
 =?us-ascii?Q?TUr0K1xIUN5HruXW/3HwSsqluKmcyTj+78JiVY4fPp4ZAeso0WFrOcYodW9+?=
 =?us-ascii?Q?DBADUpaaHptBX50ebGnpqDne+Ol1b64MY0FQROHC4k1aAcO36No/mFYvc30n?=
 =?us-ascii?Q?EflYeaSr1XnTmLFbYflPdvbpK4fiPwVlhB0ejCvSr/Pmerq1nTlqxUyFybu2?=
 =?us-ascii?Q?sCW6wVe6YRSCHDaIY18qsqWKXmFlAoUsnfsrjgCdhoZPXCPS+Nx3gV3iDDvu?=
 =?us-ascii?Q?ENZM3KXyd0ctubiGzH5jqo9p5Wl/SCb2M+19F9mAjglz6YNS2d7MPHRmZOCQ?=
 =?us-ascii?Q?mL69W1yC82x7+zTCHU/14fFolHk/q3HGw9B1L1CLXF74XW4Hcz7I3OqE91cj?=
 =?us-ascii?Q?bKO2p4wiEG8vmOuACUV6YWtXNINqXdHWq+CI1lxf/AxWH2g9LmBn4mwJ6vxD?=
 =?us-ascii?Q?IaW95bRJu/Hh4pLhKO70qFSldprfCnH/dNOVVRc0zz3qjUtw4K7acRLtR+Sv?=
 =?us-ascii?Q?UIFcxxh5Q4zfcYh+ulmdBy/iTGRlhhJ/Qixg8J+XtnjCGotz/qDeP5HO4Lij?=
 =?us-ascii?Q?//WmrW4cR/k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Skm9YuU63iLIGwIKRxjqIXHZMIsA6wRbSQpJUURDx6wC3JWhLj+df4LfJHaN?=
 =?us-ascii?Q?2CZnQ6GJhJs2zrYOBw48letnf6K0kk2XgbVn3IpuT5VIPDvVF0CZzj/lH06H?=
 =?us-ascii?Q?BP3bap7+cNqSQTVnancgTHW6AsIqOvLK0EwMYt9EHNtTzseOsgp2nTy7W9CZ?=
 =?us-ascii?Q?EVbW6+3ehJSLr+a+LBu3dlsI7MTnYtPlvncpZSgyDQUC1VjpBSp6ewhYGJlf?=
 =?us-ascii?Q?aV5BeX2d2bzWnRnWKyVa5LQRuyrvS/RedqcfTmmVmL5wvjY6ZW706vTe89G5?=
 =?us-ascii?Q?dLN+smHs8+m6jTEzgSb259BE4l5XCkyxR9TNeHvfyzOOHnWZZhcfuUHPepoi?=
 =?us-ascii?Q?L4gLZ6g637t9ag4hjnWW48ViEW/nOG4UZul5ygu5yZA7fe2pfLytOgvNliQ4?=
 =?us-ascii?Q?wtjcxPXZMLQIdUlZzFI1DGDHIA6P/ylcLV5krxina9Zrfh+HSAxOfMGpaSFO?=
 =?us-ascii?Q?XjXVoBfx8frjMoW4uHwddZNHkPEO/waW5cn74+aUs6aAgm1EdVrcyZIH1ORv?=
 =?us-ascii?Q?fBiuwXVKS3DfikjgNveSf/+7gTAZWv+AaxYNUtd2gNJolX5Qp9bLKHDsbzUR?=
 =?us-ascii?Q?o2nZ+25/3EUa3VVav3Tmhv6nhctWWXdkcz2I7dVMyZ6PvnI15ARYir4DdTsD?=
 =?us-ascii?Q?r/Mko6fqIdL2akotbVUCkyk4GqEmdd7YZ1nX1nW8pPranBUP09aYuvv6QqLV?=
 =?us-ascii?Q?kIU55Fw1p/KY/DJuzQ+xPkGeEl2JeKTj+N0SSQ760lpUnQ2nM7quoyNk6eZf?=
 =?us-ascii?Q?y90uePUVbkvgQaYNArFtZmG3rpC2fXjKIgg77TM5UZ+hS7cf0SiHqSy8GHOG?=
 =?us-ascii?Q?ToyGIHxlChRQ0O2ZLun6x0CLHbG62pcevsgztBF7vpjPi+hF55egIDv2EksT?=
 =?us-ascii?Q?EUQ8R4+CjEOYnuGla2T9opftbBOaUQb3TfvaGoTDXpRhDRusuSeV8yeK8u+O?=
 =?us-ascii?Q?4ILhhUQxNj3QTtGqBlxMRc7F0GiQ50c6NTUroSRBQjymdWwT1O610Y3Xe+Oz?=
 =?us-ascii?Q?42jvg6jx9tCOr1LtOJmatOaAvixjDYUig0BjLeP5cAi+WuGWBuTVWqUdAZDe?=
 =?us-ascii?Q?GWwP7qjt3KsuPkJso04whBj+ZWYJrg5ZCzCG5AckBOgc4WBpp2ZA5k+DZE8P?=
 =?us-ascii?Q?3JTXqzEhuOtKAGzgpIKVIYNm2JwTC9KqzwLuj5r9NWVMlr3HsDqboNwL3qBm?=
 =?us-ascii?Q?0NsRfY0QnqfwyjPEvRSwRSKuVaCxhAOobpQnO2rCSlSeLGSNuPdTFlh/84/2?=
 =?us-ascii?Q?dHdwR7KJT2VH0zNWyvHLhoT8iY+xONRdvOws3p5TYzaROZlPcjjY1YoDiPqN?=
 =?us-ascii?Q?nEI5neyzUhybmsOzri5sDRrqEGCICjI9quOxwRxVU90PyqGu/GC5zPlumpGr?=
 =?us-ascii?Q?aavbFxfxosFWrta95ZHKgkT4kEzpJFKr9+UYQBPpp2Vlc1jiEvfxyYruaX6l?=
 =?us-ascii?Q?97WQf2Br4q/e0e2Gcoao34XyVmGEs+pKp7rPtXFz5WPVIAcH64nIxm42av+1?=
 =?us-ascii?Q?OtDc/RQ2ezd/vHK6TZVJ2uAC3BLxE9AsroCuZQvfBU4tjegYEWuDz2FZmDCQ?=
 =?us-ascii?Q?FFdEcIDQxP/Xo/a0i5I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7de789-eb38-4f3e-7772-08dc9705604b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 00:00:52.5769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdk8XXT2zAY9Mj2qIHDUCR38V2a+g7GYOZfWa7AAH8re3xtOma02+IRtgn1lNCnZ4WjA6kMJdu6P7L7etzWqHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7237

> Subject: [PATCH 2/7] arm64: dts: imx95: add sai[1..6], xcvr and micfill
>=20
> Add sai[1..6], NXP Audio Transceiver (XCVR) Controller and  MICFIL
> Digital Audio Interface (MICFIL).
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

