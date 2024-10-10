Return-Path: <linux-kernel+bounces-358791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC19983B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9AC285FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186001C578E;
	Thu, 10 Oct 2024 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D3gDTVyU"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C131BFE0E;
	Thu, 10 Oct 2024 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556369; cv=fail; b=RFZ04tO/NTDmCnpF7Up9oW0c9X7ur4JCcKH7QEh3Y2QZOTK5Q5WKcH2UacCxgZ2RpLcIcmLsd+YwGIqUz734/1xgkU/AfYwfE+eQII/TblkvPB/FBrT0qIZxs5vmuuCieQVO0AMZE24JTPTpxajmK8VecHVyDO+yd5NXBRucP9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556369; c=relaxed/simple;
	bh=OwEh22fgPbRVJf6Bx08MY5xnz6dA3j2xvebAt2B4Inc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bglYaMr4Dd/IbVvqVW1s0lwJ1N/JUEXz95DYRcbKCVcokG3+odJfifuVSPyGFKlI9P+BtNO5ib0ag0BtCwgWj03ofCrBv+a3tEd10z3rFX/FJQlwsj7csSzqM6f6gD/GJ3QoR/jKZjLnnne7f+9djXcUgguNA2PEL+44rNOznH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D3gDTVyU; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPf7c/zmZjSyAn1nmn2u0xZwu6orlmDOFP/jtUr46vwiZXdhkbUQo6e1AVNmAzw9iQ9aVpt7yi35Lpit7D74XtQcoyThOC3E9QPwotVHpOXNnaAYozmDo3aIgv1PFKmgv6BQ4qcjo69Y1lcyFBJUCa8naLyK0Hww9GbLnFyHy1sWNS2j6bKXJs0Gdk4OPAKxRtRIhSzDVx2tAU8a9RkrlaUPOG2OaPLVESnk0tF4bP0dBX+/67MNFngYlrpDjCIgRhuSljH93NN72RCNMi0wno3w3aHD+9e4/h7QgRr6Cx4Ptxg5LL9wAeL5CG4Fg5IvUWvft6ulbKdbAKd2mTH5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqWPGydy/oL0hPvFDiOx5JO/S70QWGILJLfd9f2hHHU=;
 b=YpmL88m8dCyZmAVQnkDH+0ZI8ZbWaIM22Z1xhmRPEec74NRB3/V8lreKEmYOvIG+RKEE5lCF0mZmuaAxsQ7QltKEMvZw38saevTF3nuYGDSAJGwzgwL52pZ0gYqauCbUpyRH4YQ1ZeAGmSUE/VTCZaw7/MtOXe3UQSBEkEzMuAkk0lN19EzdszT3YmXRLKRP+zNSDzBIthWeRChMWPHAQjXg06CTlHuhzuMPx+GY2MgFbzfbgl7QMrIkZt591lFpYkWKyJP3o4jWGxK0MfilLOV0kZ9GxfA1psKGEhHxC4AAmOuRkVGB+Ba1uPXN4JTl0bGw8cBx0GfuYIG2zGYXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqWPGydy/oL0hPvFDiOx5JO/S70QWGILJLfd9f2hHHU=;
 b=D3gDTVyUOeLxl1KD0G1K5CwdJWLwO5XBx+Dy3xM1M+cK2n5xOAjX35bsi7ZES121cfKpJgYt2aFfvxiLHaLDzFe33xrO015M1g1XTNadpn/Y0hgEXrEDTT1OJCkdWkbs3bdIEQgp6NBUupz7fnWkjnwF2CK5T8usyzl7Sycc841dMLmTQwbI42XgX1gPqkd01VljyJbklqH87c2RqZ96yd9UnoMdl3ryk4IQRh0JWl5Uo+WQSNV7BizIEPlwjldpO6/NsKfttx2fcaMDqxX3POaVO818ZrML1hmVu9RCZkS6i2jWFccxYucmkQsoSS0gy1kp1/siC1JITQF1ktXhVw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8462.eurprd04.prod.outlook.com (2603:10a6:10:2cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 10:32:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 10:32:42 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/7] arm64: dts: freescale: imx95-19x19-evk: add
 nxp,ctrl-ids property
Thread-Topic: [PATCH v2 6/7] arm64: dts: freescale: imx95-19x19-evk: add
 nxp,ctrl-ids property
Thread-Index: AQHa/dAxgDaifdKMl0ylrOUrTqiWKbJ9CKcAgAL660A=
Date: Thu, 10 Oct 2024 10:32:42 +0000
Message-ID:
 <PAXPR04MB84591F09684CB69CECFD48F388782@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
 <20240903-imx95-dts-new-v2-6-8ed795d61358@nxp.com> <ZwUtFKhB3R2geN1D@dragon>
In-Reply-To: <ZwUtFKhB3R2geN1D@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB8462:EE_
x-ms-office365-filtering-correlation-id: bb30c595-36f5-4070-65ef-08dce916df84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5iqDrdLHsZHD3VZwrW3C+Lj5bHxUJ0KUboRNKGtYeAqNiLb1uDtPvHs/oNtN?=
 =?us-ascii?Q?Gwl9y2Xpw1GRa4vwaKQvMeLAHQjSD6Z/18gQRl3A+g29dw6/DK1rUqQ36Z31?=
 =?us-ascii?Q?66Mj6Yi3Rj7Y/5myw5GpYgIDnkVC04S0OFcv9nQdq7pINemifD2TCPzHgV8o?=
 =?us-ascii?Q?PO//7Z9dJhOakw2xvkKCNd2tfp6GhiU+ABrIsZ1uG2BI0arO4750lX433uSz?=
 =?us-ascii?Q?uBNk8Dze6I8qUBYQ0jQ9VlA2+UfAgLjmKQETzipQkUTpRGGaZeubfgFEDFSY?=
 =?us-ascii?Q?F2pJr9fcGAZOwqQssuOX3mxbUzHmdV4C1iCaE8qz3ACzr/riIPWb0EUrKTm/?=
 =?us-ascii?Q?pB+7Yjy11pYGZ2wemt0LDhllr4vlbFyY+4F8evvH0btZNIZ5fkk37zx0GV2p?=
 =?us-ascii?Q?8fABXNOKQnKxyoXILK0Uxqm0IqCF8udlSow+glqT9yWi6kaGq2Pa+N3x8sND?=
 =?us-ascii?Q?j+GmcB9N7x17FHshhFFzHt5spm2PBUvuHCcnGkBM2+39ShONCXH999sgjGVT?=
 =?us-ascii?Q?jSsGo56UqrBB9yYfYfEpn9a0zpkB9gJfBvV9SeCsUi9SETrLIDmfgHu0TdYP?=
 =?us-ascii?Q?zRE4FsG1731sfDJhxdAcAbc1WTnK81y4F30MBsMWpdKLbrSd5MXNMnvmBPGC?=
 =?us-ascii?Q?uFmcouuGRvNO7P0F9D1lgsTgxv45kP/SJSAOabtdmsjOVQTroUTO93/25oMb?=
 =?us-ascii?Q?IXdyGZ0pavCTFm9vhbhql+HdeZgtYEoh79LJdqHvSdzWfjBbpQ/X1OojNL9z?=
 =?us-ascii?Q?Cw0uQw/QxyKBkfYOvCcRpb02U3y1MiMbnmohrM4SAbf4SiNWSiQgfVqY7hPu?=
 =?us-ascii?Q?NKgCMZkaJJiaWs/GGwBc0RFvDSiDCx6WQWCUVIFJsqUycfmBNUzG4+FC4TSj?=
 =?us-ascii?Q?JbQdR0SdNC3qIZ0x8zNstaUpB/jQJaOoOth3NMY0I9uV8Zdn1T+mVivZOhZR?=
 =?us-ascii?Q?XoKfIetREejyx32/nJcDujINnFWXgT3HP984IK5S6Grdrv0fj6B7DExKNkw9?=
 =?us-ascii?Q?LKZdSVxQCYz9wXSXOGC7vkgHiK0plEs2ATfW4Dps03/6tEREtnMfqwHBzy/A?=
 =?us-ascii?Q?5FuUVmISBRgk8BIhh/AFGnS9eVT6hmTfxCQG9Cm2Bn/enR9NLAHFW7XSbhlO?=
 =?us-ascii?Q?rojjqYYV4EksbrxhY3B87VHhklUjSG5enSv2JrK+QCwHShNbt94TT2UJXHQE?=
 =?us-ascii?Q?KNPQ4la2lc5aoP+MYTsE576Ap5TLRKO49LmYqt10N1jSq07B/KTQSk4AIgW1?=
 =?us-ascii?Q?oanf/iBjHc/3ZWqsUno+CNaCUGYh436xfGmckOdISU0quSkFjqHss2tBpyRx?=
 =?us-ascii?Q?IQsi+GtiI7jOah5PkSQg63yp0eEhbU19frmPCb5MH9Kx9A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UcxKm9Xp3pvq0WRIh0t25DKxkVKFJX/5ezCZAJIoDvKldKyUBI4tfko+HyIw?=
 =?us-ascii?Q?beNJtt/CpHCkIC7ICvXjqzExTNvgUh+ZHxuQDnqQuKq7/9jmSmLAXQhd8img?=
 =?us-ascii?Q?mGOLoVIOLO1rVO5fffjojsfbB8thZsplYJUN0Dd6urt37NA4LSSUgFC4N39l?=
 =?us-ascii?Q?x6Z2Fn5qjREVxkZ5+CJghGgx7a6NmpBn2fL3x4D+aCZ9NlATYl9Q3cgBOCqR?=
 =?us-ascii?Q?P5aFMJZL80jeOg5A075tawyASLKO7kzZ2tDAkRjxCMTnXt+qt29FZRFWImSv?=
 =?us-ascii?Q?cCg9ZKcaJMalaflDZeN5I/QxIxL5E4Hf9CUMO84p3RkDcxJT7gNPJJ7UdbNK?=
 =?us-ascii?Q?1pYI47joCyU+GuCOETExbf7eVFfyf8W5UMIh1mUgn25msMj+Ee9/fkx4jNpe?=
 =?us-ascii?Q?6N23Hi5sJaXqEyfqr3no9hlsLTMmxQvbD/ztbOXtjhnYVqyhobLxob9sMg1u?=
 =?us-ascii?Q?29OIxV4sc9lUBNhqd9rfz0k/lG1OHtgEYTxTb7Z84kAniOWjUSVKXOjUZwPB?=
 =?us-ascii?Q?ewBuJPvFyApKVqRZ/SWCthbg2VAqGM7697fOlj5OZ7H8a2yxziQJVq7roLOX?=
 =?us-ascii?Q?mqXhoslx7oPt87/9XxxhYNqmmfgBe26UHei25G6xdY1aJ89IgIe874EMjBo5?=
 =?us-ascii?Q?lb3gjcgqnDi12Q/PcQqP7T6Pky21LhHDUBW3+CSvF3/4eb6eIb6bpVCcy4m3?=
 =?us-ascii?Q?LENGfHdMDnePvlCAJroSfzhTbmlr+ftfUZEr17BAA2ISfi5pbEPENekDQ4Ul?=
 =?us-ascii?Q?DhHZSaLmpflcsJLYuuzYT3Lu1wChNyyWT/wosv6dNGixXi4xlpgNyOkQfDXX?=
 =?us-ascii?Q?mo3v74D8g0oH9mb/bczMTDLzxrCxpgJQqQLS250gRpKQJ2uo73yl4Y9Y01A6?=
 =?us-ascii?Q?m3mq8TsK0x90JdjUn0HUNcmW+flGbOx6/RUNDon8c9pO2Tm9SRu+1tuVzBs/?=
 =?us-ascii?Q?bN7pZVtd0Df0LzscS8vi/m5L24Wx+yDtIKmbzIGazMw+WFXwnLemClNGDvr8?=
 =?us-ascii?Q?lcmGIIqCvO4UFx/wh2UdkavHtAn6Ey5MLpqYiOSzUidXUHVw3bZR+GXa4GCK?=
 =?us-ascii?Q?AuWhso92OH9PxQiGZwRPIoNwwXZyp8VIMfSc+WY5piuSaqHCdVVz5HTRIkp5?=
 =?us-ascii?Q?87pGFEzx3vjH0NAZLkgCBCpU9TWgAEF8hSAjFat6JSse58lwa/dWnt7VYxQX?=
 =?us-ascii?Q?TZV/RHbQiXz1hMmBUsf7dlnNyTwDqpKnWDksaJf4uTwy1rRGn6JINCPfR5HY?=
 =?us-ascii?Q?awgV7DoqqB/H6SYClZzknVxeuxmFqZtXryiSscT5cA8/lv/wzW6C4WUFOpYR?=
 =?us-ascii?Q?LwhCvdB7YMehLljecYfaW7qGsRyCC5p12fjSc9VIBGjBR+vAlZqwMJMbtalT?=
 =?us-ascii?Q?rdeP/sRYHsxXLAZ3yXuBcmJvc0mw/hF7M8720IrFPuQHt80O3zTno30LJSzW?=
 =?us-ascii?Q?gFUUiDMzILCYX+3duPKfRWQP86z6ombgIonG4sW9sjhufSpjYrdWZP4iyPfJ?=
 =?us-ascii?Q?mhu5ixZAT2wZ8Cgr1EyVaZaZzx8KUE3JAZ2ItsUzddPuCg8cdoODlMEokvHX?=
 =?us-ascii?Q?q1ZShrovO/nCT0uIbrw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb30c595-36f5-4070-65ef-08dce916df84
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 10:32:42.7880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0eFObASdciJOIs5ylx0ukcXa5YbkiyLEvpusIom+nF7ze/EPo/OdQOB1dsKkfeW1TNwQQuLQntFMxmfzLfEiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8462

> Subject: Re: [PATCH v2 6/7] arm64: dts: freescale: imx95-19x19-evk:
> add nxp,ctrl-ids property
>=20
> On Tue, Sep 03, 2024 at 03:17:51PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add 'nxp,ctrl-ids' for SCMI firmware to confirm the board ctrls as
>=20
> s/confirm/configure?

Fix in v3.

>=20
> > wakeup sources.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 17
> > +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > index 37a1d4ca1b20..5101cd171e09 100644
> > --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > @@ -8,6 +8,15 @@
> >  #include <dt-bindings/pwm/pwm.h>
> >  #include "imx95.dtsi"
> >
> > +#define FALLING_EDGE			1
> > +#define RISING_EDGE			2
> > +
> > +#define BRD_SM_CTRL_SD3_WAKE		0x8000	/*
> PCAL6408A-0 */
> > +#define BRD_SM_CTRL_PCIE1_WAKE		0x8001	/*
> PCAL6408A-4 */
> > +#define BRD_SM_CTRL_BT_WAKE		0x8002	/*
> PCAL6408A-5 */
> > +#define BRD_SM_CTRL_PCIE2_WAKE		0x8003	/*
> PCAL6408A-6 */
> > +#define BRD_SM_CTRL_BUTTON		0x8004	/*
> PCAL6408A-7 */
>=20
> Are these defines board specific?

Yes, board specific.

Thanks,
Peng.

>=20
> Shawn
>=20
> > +
> >  / {
> >  	model =3D "NXP i.MX95 19X19 board";
> >  	compatible =3D "fsl,imx95-19x19-evk", "fsl,imx95"; @@ -357,6
> +366,14
> > @@ &usdhc2 {
> >  	status =3D "okay";
> >  };
> >
> > +&scmi_misc {
> > +	nxp,ctrl-ids =3D <BRD_SM_CTRL_SD3_WAKE	FALLING_EDGE
> > +			BRD_SM_CTRL_PCIE1_WAKE
> 	FALLING_EDGE
> > +			BRD_SM_CTRL_BT_WAKE
> 	FALLING_EDGE
> > +			BRD_SM_CTRL_PCIE2_WAKE
> 	FALLING_EDGE
> > +			BRD_SM_CTRL_BUTTON	FALLING_EDGE>;
> > +};
> > +
> >  &wdog3 {
> >  	fsl,ext-reset-output;
> >  	status =3D "okay";
> >
> > --
> > 2.37.1
> >


