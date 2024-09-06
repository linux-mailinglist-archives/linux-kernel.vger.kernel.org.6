Return-Path: <linux-kernel+bounces-318417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9894996ED8A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535B62834E3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE503156F54;
	Fri,  6 Sep 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MjqsaQvF"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1721553BC;
	Fri,  6 Sep 2024 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610639; cv=fail; b=uNTQ1li1K3pW/8CRvnIWbqI57lFkgdjlcK76V7kvlsrWFHr4RToL1Oq7Fi898JtqAK27XaLxBQqabWMsypic7g/3qkDrh7gTc/cFQiO3BS5pmKwrNKfIpgLIFmFOPJVgu0w1zPkBxagrEiQYVTmuzQYZRX2yUCx6Dlzz5YGdIow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610639; c=relaxed/simple;
	bh=G0pgBkyQzb+CeFB+50bY0eHGPu6kxyAwS/ULX4PxFJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lc4eEppeQpUVLazIAfE+H/D4lhMaRXcaA9HPRmWBi/Wi1aB0ud7wKshhhOFVq2B8++0DXfBvj6ApMOYOwVnXnIxFbfq/P15O2di1B3c5iOwhWx8bxS4HPjxVoDZyRvE3KgxduVx0FG9+i6JeCt2QrxaMGTL9JmunV1EkyYvybOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MjqsaQvF; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u259QSiMjXh/48ZEil4//luxryDkgr1wtECZV/KXqXw/Pukckhx0S8ki+Xgrp7VmrXu2DqFjTI0EuxjmF29B+NDDehZRgwqn0GGB+s5/WB1n2iPWw+hhiQccGEHiR/HylXVT/swr09l4YYHv87SkwfZIQ0HKmpVp9/ZL8YQq5IieaQWhTubvdSV/wAB9JNz1V1qQIjUu40iUCKB2DRActFviUD3xqhccLnROsMGiwrrdVvkUTq7dan5OjmB+MHG69kClc/M3XQenGvehMK83+9I3udrfhlFSIE62R0dT82IwEIoI6IpEp4k6RfRQZJT1K29E0gKfUGsTpiI/oCm4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYinxlTkSiSLXwmRBZCYEbVoOxsYtOIthQYM3buHN+g=;
 b=f3q0cvQMw7A/K+WnYpfTgkXJ2hXw+3QAiLN+srQXUCwco/zr+kpo+0dRczBxLctG7Vm/n2ONyw03kiDU8gAD6sLM6Rsbdv2RIpVwp8otbOVKFfn4NRy0dGIZ9UsHKy5AAh6MQj3sO6fcGos4pVPDZak5mzUZFGgV4YrNofSS4VvoQ20W0QaO0jtfRttrVaM7V3dHJD7S5+SsQzL+FtXnRI16IsUwL5qbyVUJrO9kzfmkOXbKu1bxzKuQtJNB/ktv8wKAz/PJDUzbAU9Cig5IIbv3FNhGJg6Pj3XyGXjHa9G9Xcn9ccV+jAa6ZkZlf/dSgJhRBSjAIkKQKOwURAjtgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYinxlTkSiSLXwmRBZCYEbVoOxsYtOIthQYM3buHN+g=;
 b=MjqsaQvFyr8qfd/+KQYAyTq06LejcJxNBejgt5rWARZV/C1sTKsggVd7qg41kD8ERRlgtfQa1sRgRVvCJRxp9sZZS8XFLPeUW/eg2HiEbvEv2ne8vHjjHAWh4VwwdBqrbx6VNsArkckqZAFlEHibrBCLyem4ESiXvTH2H/g2DXWajQHgd+d10qAZUr69STN/TfbGPwBMUpuqHgC7xP96mHEM2h2wQ2IgK3iOhVjKIDbb5e2yPAGH1P8k9vdHYZDe4EACDp3vvyNmZCKJG39hSbtJ+Y4kokEdmvvbDYY4YSMDiW1k92LnEm3a855aBm/SpY2YzW5uQv6dxpkvo+lCPg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 08:17:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 08:17:13 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: RE: [PATCH v2 7/7] arm64: dts: freescale: imx95-19x19-evk: add
 lpi2c[5, 6] and sub-nodes
Thread-Topic: [PATCH v2 7/7] arm64: dts: freescale: imx95-19x19-evk: add
 lpi2c[5, 6] and sub-nodes
Thread-Index: AQHa/47gaICini6KM0iTpfpvfeF20LJKavkQ
Date: Fri, 6 Sep 2024 08:17:13 +0000
Message-ID:
 <PAXPR04MB8459C841FB2CE36DCAFA0CD4889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
 <20240903-imx95-dts-new-v2-7-8ed795d61358@nxp.com>
 <3244531.5fSG56mABF@steina-w>
In-Reply-To: <3244531.5fSG56mABF@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8893:EE_
x-ms-office365-filtering-correlation-id: b794ca68-f122-42b1-dfcb-08dcce4c5012
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?f5jU1KuK6AtR7F7b22WJC2rvmQmo8+UN2zskuDSalp/bGtnRvVJ0cVCNKC2D?=
 =?us-ascii?Q?ViQlC4N8vPEuYRDfwVKYwbPBlyFLCcl2iqBSYyBbkECUPx6dl7/rUKt5aTfN?=
 =?us-ascii?Q?DeB1+XAvgBy58q7y0yppctdSoKMQKTf1op42jMMWS3WpZ4Wu6kUTnclXakyy?=
 =?us-ascii?Q?cosyC1IaW67fa1hRtuvhV8CGhvcTjawrSRcJYzZo1fm9y9cKQVJIPSLkY7ia?=
 =?us-ascii?Q?KNFf8IExi8HjJMG/rf1h4zOjInffjoKBwgW8nb3r3Ggc++QAe4prO/EZ4Yxu?=
 =?us-ascii?Q?T1KRq/AoSL44tmptTisOSiDCg7xCUbgNcYZVLGVtLG8enAJ2VsdM3rF0oQvj?=
 =?us-ascii?Q?PdE3UQik9BcAsUBn2uXu8TJhdmNh13nW4+AVYqcmVFTTtHdhn3PF3No+vVq3?=
 =?us-ascii?Q?tyOxaj+TG3OhPknXtAnqHOSBbGUOzMaaYFEhP+5Hd9cG4D76mKHkmGEGvCSt?=
 =?us-ascii?Q?wEOXB+g9hR9tqVziKVRhGxHKLpUdFtHGluwQPOgzumSREs5GtANfcFBriYzo?=
 =?us-ascii?Q?PT2ITJ2z8SvM6aPDvJrnragTD23OoFi2nC9PB9MO93WgUy+NnStRdelP/QnQ?=
 =?us-ascii?Q?zOZWpAQiSHqvnJLv33UzAT7bxOxRt0fUwKTQVeXWTdNhFpQBFHvDt3c7Fi2D?=
 =?us-ascii?Q?JHOxJ3O1DjN5qgrT10o5bk37gXdPiP0QkQmzn/GQfvxL3TNJtyeaFadXydq+?=
 =?us-ascii?Q?QsMgYWVnkUsjCsLfavfo/KAqtO5QO6sta2yeJcn/RAL+A5Um3tY9DgRmc8DX?=
 =?us-ascii?Q?aou1V2HH8E8kovXnKSoZ9ecjMZipM4P3bKHPu7V7ts7qEEklhZgxA/nrg2Fi?=
 =?us-ascii?Q?SB9cywFj3pwZs8+DfDmIo9RIbI2QimVrR2SLuy886empDTtvbxMlTXk+ghPE?=
 =?us-ascii?Q?pnwiil1DJZZQ043A2mr4lQzTMmAtIiRYDMS+8WURTY6mZnaqUlN2IIy+RRrt?=
 =?us-ascii?Q?X918KZClJhYFZuUV2sI3ovVutb4RcOGUlKP0u5zSIdRvN++fueVH5SdPHhzM?=
 =?us-ascii?Q?mIfUaPiDp5OYZLwRtLNF8SIAeYNnaHwFwJlg1Db0YpylIMoHGERWsMV3o4np?=
 =?us-ascii?Q?3Pw1ICmj8jm7S0vwUZB+bMX/+Cd+BjzMcHu/ARDKstPY1L4pU9SKHovOe9VJ?=
 =?us-ascii?Q?Iff28gyhu+TKEQvQ8TmNnM09DGFyjxhlxl2IlcEBW02hBIDlF5pDwF+FgHtD?=
 =?us-ascii?Q?N6zbZ1wm5DvaixfWcspjcjyIQZmHDZfg0Ebl9o3QUSKUPj3o/NVYo8pPPvNU?=
 =?us-ascii?Q?6Av/1Q2f3nZlRBArnc5ti6UZRapVDdn/ruYKKzEbvjsGziuEzAPIbjK0/9ob?=
 =?us-ascii?Q?vVn2GkVLuiMvjKSGarPRAzSXHa4wTX8Kn8Uham4sLr08bd1YQxZjQiF3yg7x?=
 =?us-ascii?Q?vPj9ZXETJubbUxnY8Y4Dph95QbokCm6m3X8OJoJgJWEAPnBFHw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+OnlUfMolGgIDJ/8Y6CADXJw/ie2oGWdsBbLDEu5Uc0eNYoF1GynM9/tdMVg?=
 =?us-ascii?Q?cBvPaknmL3NEcCy/AlM/C8SI633i3xh6HDJL0jPWup53gxoDxJF/265Zk90G?=
 =?us-ascii?Q?P/Lw82AY4jN9jftHV5zOmmeHyh2zTt5lI99k1boXA/KyL73ppp2ZvODiaOqe?=
 =?us-ascii?Q?5byYhnidWdLEzr8GYHjPYeyaBR6CF2dCh7r8mDUFmy5SprsCuK0ddrxTaWqJ?=
 =?us-ascii?Q?KQPMjkmd/pxpxRbBAKX14msUXnU37vao7NpNLQhXX/J2dNict3vNHoZrlp7/?=
 =?us-ascii?Q?CVW0y9/dkZtg0Sqp0cbPd5Dco1O70MU/Xmpz7QVOhvpWRjafw0pLbPvrv+KO?=
 =?us-ascii?Q?Ewo8TfgFfH2XYfLPezGHztA+hFXvPAvZ9hqDrxtMVI6PybBgg0iIjM6gSkwD?=
 =?us-ascii?Q?GLN8geKevFz5tgKBs434cxfw2kYbrly1+gPwaNDC1A2FNwgWVnAWzvYYBBii?=
 =?us-ascii?Q?lD43lCe5JX/DzuOP03d9sHoIHlhmH3dCAXMRDL4ps0QOAx+RbpZF1LX+V71t?=
 =?us-ascii?Q?vjbZ4mxpfzVUpF6hCxQBren4pQQqF2/b9S2z7WmrJA7WgdAQ9ICt7RjOZmjI?=
 =?us-ascii?Q?WZRk0ZqghugGzMlrPJGmaqJrO4d8sUmFyJ3YE+h5WiohkJi+IylkMssjpIDh?=
 =?us-ascii?Q?j6pls4gAK9C0LhxEjjym0VSz82vTo0ptWOZSiEQ3xUIksGrp0nAErjuUdjbq?=
 =?us-ascii?Q?SrtliBl91vN73S/XKNXZFq8GRDXaOfFgj+W7zkUkOknMuR5DYFwRYOXCX0YM?=
 =?us-ascii?Q?0cN25F61UFDYyf5yOG96Sca57S8BJgRl+xaDG9aMltKeLGPR+gZWl1uFYfDO?=
 =?us-ascii?Q?KN/cux+pYvD5orO6qu2L1LMQ4BS36GNNsAyhIbpD2iB0NQx8L0rT17M9PL7T?=
 =?us-ascii?Q?mPj8z6UhdXezzPXTWzaKcu1EqS+Omp+OHQ1MhmX0MZnGWau5LJFeS2COJdGE?=
 =?us-ascii?Q?FxDduGcgpMQhc0WFGYPody5qeu5kJrnURlZRWicyA1IC/8YiltpJ5NezL1RZ?=
 =?us-ascii?Q?wen4r4mPyIcLkpS3k7ykF1xO7NHFU9Olhk5nnARm6E33MH1CIcpVED0kkaIt?=
 =?us-ascii?Q?lTenfkIYwSOWkONsS5gBxLWjbSjQgHbKvrNyshb9j36i3DQvihrNAmYzfoi4?=
 =?us-ascii?Q?lJONeP6ciRm9oIXeXdYimJmgyAMe9ESK/Z94K2F2k/iYV1A83GLLoMHJJ8p4?=
 =?us-ascii?Q?PqD0y9Ta/0j/DFzqKR0ZPHKhogFXRHKCAjF+WdYvCNtpZmtZ6V0cE0JDfp3b?=
 =?us-ascii?Q?UtOsgS18nX0Vi7Z9uO0v3Svr110DNakyb+yWGYfb6V3djMNKXpQ81gdLwDVK?=
 =?us-ascii?Q?uL9R5qM7su99dczwFiQNj3qL1hND9lgKgx8dja60L4IjNGpy8eS9FWKVfc5Z?=
 =?us-ascii?Q?Y8PsA5yZwULEi2OJ/mbHqfLZ6ycZxYl49oGYcg4fJJg0ErsAuAERyOxtwAOW?=
 =?us-ascii?Q?KVtwclVib6a1yT10rt/a93LVmuCEshqMaBkdBMSxXU8kF/uSLGEiQgncaFO3?=
 =?us-ascii?Q?6WRk6octNzR965wQjSjxIaa4zkv0vXf0duFvjqpf8RbZJG7n6NUIb7I6IxtD?=
 =?us-ascii?Q?SAxMELYviyXyX3DA5cQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b794ca68-f122-42b1-dfcb-08dcce4c5012
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 08:17:13.5870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lc4qb+wqGYWCXOVOmjsRVktTBbPGjbkXGkTC3b59LZtL0sBfGRNekxLBatAG5CVWILI8/Mev5++ee5uRJ74sjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893

> Subject: Re: [PATCH v2 7/7] arm64: dts: freescale: imx95-19x19-evk:
> add lpi2c[5, 6] and sub-nodes
>=20
> Hi,
>=20
> Am Dienstag, 3. September 2024, 09:17:52 CEST schrieb Peng Fan
> (OSS):
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add LPI2C[5,6] and the gpio expander subnodes.
> > Since we are at here, also add the alias for all lpi2c and gpio nodes.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 69
> > +++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > index 5101cd171e09..6086cb7fa5a0 100644
> > --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > @@ -22,6 +22,19 @@ / {
> >  	compatible =3D "fsl,imx95-19x19-evk", "fsl,imx95";
> >
> >  	aliases {
> > +		gpio0 =3D &gpio1;
> > +		gpio1 =3D &gpio2;
> > +		gpio2 =3D &gpio3;
> > +		gpio3 =3D &gpio4;
> > +		gpio4 =3D &gpio5;
> > +		i2c0 =3D &lpi2c1;
> > +		i2c1 =3D &lpi2c2;
> > +		i2c2 =3D &lpi2c3;
> > +		i2c3 =3D &lpi2c4;
> > +		i2c4 =3D &lpi2c5;
> > +		i2c5 =3D &lpi2c6;
> > +		i2c6 =3D &lpi2c7;
> > +		i2c7 =3D &lpi2c8;
>=20
> This seems to be something for the SoC imx95.dtsi, no?

No. alias are preferred per board usage.

Regards,
Peng.

