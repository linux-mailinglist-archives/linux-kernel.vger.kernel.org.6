Return-Path: <linux-kernel+bounces-315526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5AF96C3AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05431F26AB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE13E1E00A6;
	Wed,  4 Sep 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SjwU9XtQ"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA01DA2FC;
	Wed,  4 Sep 2024 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466502; cv=fail; b=h1KR44n9kiD+4JUDbDL9ncRr50Fkgc9SlfXiCHhlF7jsNW73AbcBrw0871A44OkUHbY8XSL3Q85LRVrrE9tpDdB1O1P6ufPRveGeVBP2a7EohKXutgwGLWf97PoSIipBSB7nKhL/ALxdQw5rUOClv85HYVvzL0CT4zuJHFGDUU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466502; c=relaxed/simple;
	bh=P9bjTVWus6riN6QHL5BxvFrkO442xPFoeA3k4uh0QKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k9uuFH8v8ddS35FEfVsqEJQH2cu39Mtd9W8ks6susbDohn4QhSAiZY4Fkvz0KXcPLiXwLQ0fhXB2xVXztjq2QkzS0FtnhOEtN2HyEeSRooYfXI2QTBYS5xOp5zPqtScmMJrk+JUfjC1vggerkTduhENjTLmCXPkkOXHPUyhsOEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SjwU9XtQ; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D99F+rCEZYLkTpr0hMUl7f32Qvh3EsG5d1vgA8WMw/jAXTB7BfR3QZys0FNplQQnBKRZ5CjvoCDphTtdA57K2QWnqPsd6p5bueo0uFFzqfyRgj6QrkECg9OTxcx2FMxNAmjzFV15+LuKbapBVaLCxiL4It0ewpaQXzHX9EpQ5YR5ywqUL25dhWg7eGaPr0gVvaXoTqtV+B9LAm4rXCc6Dpy6WWBNGj5MDqkZUW3NNWy04cAYyCgot/Sq/vzRYo1WFmI7eMsFXsMzrY5gTdah+N/yTCqTZWwmR8fi4M/kjy3n6SxIhGiP1HCy+yMCf3tRYqHNLOxvcbErlfnB7ZN4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJq8GTPBH6NUE1Mdw2ok9JWYD1HxXdl5grR/r/8Rosk=;
 b=ueclqPnK+w7yrnZETw8EDQRBSVgVEkWNK3gMmAAkvGe197NvETCfduigRtxsD4ew7t8m8QB9tdoUoMks+KKDE0Aj9k55WPyc58o1iOCMraPu0mTt9o7WkPQ5rkYoji8R4jboJa/tvbRREyaLxD+rLHFDgBXAi96YtWMq4RNZ3c2SBZ5kktjFJebnb92OnM0IdTy1x1T+84AleTKrJ7swoo9zzBYpTxZm9cCLX92i0J4sGHWaNPFJIU82/94bmoMuEUYFxZ6epY9lGTyZCLedQLPq/5XsSQsw3aNgLJBeJBz75tvjd1cdpuUlWE5fiQ7EaIPwrmWXG1PYNigcPZYrxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJq8GTPBH6NUE1Mdw2ok9JWYD1HxXdl5grR/r/8Rosk=;
 b=SjwU9XtQApEiFIGnoChA1clkhPn1huToRbeVEfAl4zoAgwmIrq/joF8EgqBfe9KzRvWWkmNWvJ8GWlmgLdM8yZFNSYHGmfVYrtBJ244JH6ECDK6gtYHJKdYDcOFnmSu+bYL60iuOcsqumxnWeOSBynblnBS1uSGsWoKSXCPqYbvj0ZADk1RSPkabGoTTiWLi0MOo2uXWuefo4JYquuPZXnOz4rw8HKD1vfdt1+OrAe6SE+qXi3UoIO0Rq4fHCHWdKnIsStNBzKXUHAeOYEHcClORGJfWcS6BQ/JymtN6Gl77sg0HGLrtXJlayIiC6q+GCXjrAIeXubY1p/y+i3zbuQ==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB8235.eurprd04.prod.outlook.com (2603:10a6:10:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 16:14:54 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 16:14:54 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 4/5] firmware: imx: add driver for NXP EdgeLock Enclave
Thread-Topic: [PATCH v7 4/5] firmware: imx: add driver for NXP EdgeLock
 Enclave
Thread-Index: AQHa/rj+Xxal5gowYku20JmR9i3Hr7JHxN4AgAAHiKA=
Date: Wed, 4 Sep 2024 16:14:54 +0000
Message-ID:
 <AM9PR04MB8604E2E84530CFAD4049B8E6959C2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
 <20240904-imx-se-if-v7-4-5afd2ab74264@nxp.com>
 <ZtiAFDr0jkQagUOw@lizhi-Precision-Tower-5810>
In-Reply-To: <ZtiAFDr0jkQagUOw@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|DB9PR04MB8235:EE_
x-ms-office365-filtering-correlation-id: 8ea4edd5-715b-467d-cc5b-08dcccfcb69f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kBx17CposKlyHT4QVk8YQMAFNyavgeaj6iUZ1meefJ0ooHMrWWnel9voh+Yo?=
 =?us-ascii?Q?pJcob5T4FxrHnBpZU1E0SMy34N6ZsnXWgefZDn6HcVneuivmF74Gv0y7wM7v?=
 =?us-ascii?Q?9a8J35AUtoBIecEuVIiVry88k06hFTgabFuuy4wbzBpmdfFiSX0YlPxBpHd1?=
 =?us-ascii?Q?MKhUVV9QII6dWyjMXdXsCG93JJeGpepZ3viRjzNfZx8wJNQshOPWJaDjiUOP?=
 =?us-ascii?Q?rXMxg2pS7QFDJbVI7Qmeiw9T0JKuEqptxWV2DEt2g6F9k0J9rbmqdA6OXVPI?=
 =?us-ascii?Q?03HRTGJuyh///qZOy6OyDzqiPh0h6KE2LYhVYa3Qh7w0DvGydi1ISIVkAuwk?=
 =?us-ascii?Q?IbfvX8ZZT7XRuRafjteOEW9vPnc+Dm+kW9htKlQFL+t+FBGIKkAFR/CTnsfI?=
 =?us-ascii?Q?Pu9YQU47Oza/99TTksF4MaENCDiWV7KqkH9h/3x6kE3cHK5I4Cwfscfr3snJ?=
 =?us-ascii?Q?YgFslj1ODJQdWmB+fgG0ydzl6V0DeLwHvhsCvG1R+sVWjaPeRc2f2CHM2biE?=
 =?us-ascii?Q?xwHXX3KAQ4J56+IV99ywwe96+K7mQMUl+Ivu2TKlbrMbNOeHPd3QisYJ4/9C?=
 =?us-ascii?Q?FG12WuTWgdZzXjGWsozJC/v1MGOt8sSaOL3w9KmdcjcCz4gL3w38EIFp/PyI?=
 =?us-ascii?Q?7USf1Iz05hPKV1I6CjYT99eqV+YFweUBrgVizIR1Bf1EQ/VHYpXvfta6PV1J?=
 =?us-ascii?Q?8cnpBUes+0KeaEqfqY+4VQdEdPYto2++kLZ1GtAVuIvNFQT4ZNO8oplED2sj?=
 =?us-ascii?Q?p91NuHWbUyUykldseVl8FMzZ2wNqWEJXtV4ucWAJQ8W8DO1+r7tzUopNSE/C?=
 =?us-ascii?Q?iTiHM/uqZ8qw1qWN6E/mxd62NkFWqLh22f947qNwzsHc+bY38wAU23kwYrsi?=
 =?us-ascii?Q?wR9hE38cWuAU3kOBRLJ0KILtoZQmvuP81Vvt5ADIZ2jNwU6cebvAT65c3m3i?=
 =?us-ascii?Q?6Q2smcyHjoqzXKyLy6ODJIino4iNSVtyeCQvMAfkqG44adK2VfOFAB/7Zx+7?=
 =?us-ascii?Q?wq1EdQq60B/iLDpSe88BvQh55auY8ysqlkrUVlNeyPAVPYdTIMNq9uWaYDZe?=
 =?us-ascii?Q?hRrq5c6UoOmg6Mtpz7JlZNPauSKmR/LepLx9WFCipHMJ/W6PtfZi4Msux4Nv?=
 =?us-ascii?Q?8i0C2et2e3HJT8TU/NV58fljojk5nhU5SYq+I/wBPeLeyGPmaaUTRwmbkEfA?=
 =?us-ascii?Q?IcuV+q49O1u1o5RvC5gs3AT5Uw9BKlPxQyqN59CTBiwzOYSs35bOJJL7sUvM?=
 =?us-ascii?Q?hOvdfczaOLLN4qGfwyg/TsQhQFQeHsFALQ881QJaSR0p/XNCIFp7Q0v/dzLb?=
 =?us-ascii?Q?4caccY/MbjkyNSmfQHsV55McJuhXGhNpwAfVZ9Fd1R2I1bQCBEJHs5tybIkb?=
 =?us-ascii?Q?qhpHTu7qy2NQX2nv7sV4ixQaxqtHVS1fDXteEdmdJYwGlUacsw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aLkk02NsV7Pn5n/03ARBd7It6efGxkTEAtNz0QDXGnxyjxt2X6bgRIiQspVn?=
 =?us-ascii?Q?sZ2jGxP7wsKp9xA6xbxzfwkQWyp/n75HUZWVLtd4lKVcI454Y7k/jO2xXTgz?=
 =?us-ascii?Q?ck2HuVBXVlUZxEdTZLslLymz2f12dcxQ1ib6pJMQtEFRB/RsuWMVisNLmpot?=
 =?us-ascii?Q?mucTShL8gO2naoTt3LgDYC/XiqlZLshWVFMqfnPYwHmlYCb9F7DUwJ9Hp24f?=
 =?us-ascii?Q?bEmnz+HG7dNv/fXeJN2QRCWZvKPxa29hDIVmycmstTaAGV28LTzmMDiOy4vQ?=
 =?us-ascii?Q?aGLVkW9QZL4p/vc+ItckyqzwL7oegZZlv2HCwXJjxgLKU5ZYV4vp0AQTPTNf?=
 =?us-ascii?Q?OQ7jwLLHLJGmUvy9TH8lYVT3B9oGePXJ0n32bLyEruZb2hIlMQXqTnHRjf28?=
 =?us-ascii?Q?ZFhZnl1hd81h2Fy512zjsfAFjGhHuKADfErlSku87y8HKkthzPpkAmU57yV6?=
 =?us-ascii?Q?AQFXFsNdXt2qz8YKt1bpaitfS/wfo7QH8pINVPgCUsguKwOuzSaKkx4CEGFO?=
 =?us-ascii?Q?zVGkqg0oPzbJTV4MZIMxpC7rxJ4v7F92M9s4jl6J4xDHLe/bWGtru94KviMZ?=
 =?us-ascii?Q?HPtJdATVRLcS8dzU9vTaJxBarRsJmPXYfQyQn8RXG0V68to+Yt8FVowAFvPG?=
 =?us-ascii?Q?7k8+43SiM+gumf4f1If35nqsVFMCtrKNhOXYcOLeaErb1aA+gvvxGqx2IktA?=
 =?us-ascii?Q?a2MGxRTcUxZAIUC5dfLkVWlumwyXcE6vyEGekh9hQ3h+Mv25l9F+fMV7O5Vj?=
 =?us-ascii?Q?bmywryC0BBCzOBrtgk/RBvIFC/S+j5NcDGCPFelHUpDEM/nxtyFglja93i7w?=
 =?us-ascii?Q?ZkqnC3Ot5BEbcdjKs1QWu6yYchIMUCGNhrQcL9vuBGdbN1STKTZPu2DT5Bhn?=
 =?us-ascii?Q?i9jZU1D6sTd656cUMvU+HSz8QLsfV3+O/LMeLyGy24BXNq4pZG+DpqvoDT/T?=
 =?us-ascii?Q?zFiaM/AMi3uJ0B7B+ArJUPsVFzyprH22xX2jFmYGO7Ta2w4KG1PJJaW7gQgA?=
 =?us-ascii?Q?ED8D7EE0FfdI2oRy1u1HEL5bLxVKE6LfKcG23K2SrjtXLkHfBU0HNGVWw1Iu?=
 =?us-ascii?Q?LCXNfZiU8jQntVBi4zwy/V22tHUsvwK4+mN4WBqpwIcY/Ly5qoYjNMNt9s4u?=
 =?us-ascii?Q?ZgMn64TY61yLt29pmf5uyEVx6nB8JLF4YjOkJFuvDV3th8ZtKy7aRyTL+H/8?=
 =?us-ascii?Q?uld7fTKHmQS53yXyekuvgxPuIWVzCjm86yoyx+AQhuYOzQ6I/jOw1kIEh5wP?=
 =?us-ascii?Q?sgSKc3PZozv3PfAS6aCS/ZavfTLU46HRO5ie5f2tG91tszyeVeFtHmdvMOG/?=
 =?us-ascii?Q?Z8qxJ+IGouM7u/58btip32SKyaAbJPH+C3sYARsTvZVQZFxoCQDAUcgRl3hL?=
 =?us-ascii?Q?p98HWGyVBSnJ/vXG5/toOSMDT3t0rBAD6DVJPMTthXAA/r73vzwa2Y/qoJi8?=
 =?us-ascii?Q?qD3uz3CfqAoJbAWNqb4xzQCS0OB4DKO5Xi+/VeiZ3sega++EByNpL0MzT0je?=
 =?us-ascii?Q?PdxTla8tqrB7ILN6q4lcjryGvZAwx9jgy2nAl0NTUu7CfqqyE57fRy/IE98L?=
 =?us-ascii?Q?T9+lJZk3g6Tmr473LGf6iMfKbEaYjuOkaxfQcMn4sIt+9KfqSz6s0T2MZ0Sh?=
 =?us-ascii?Q?DpwjHufaJ3tYh08zikd6ELXqeBDVJllZE+MIZrgH/Cc/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea4edd5-715b-467d-cc5b-08dcccfcb69f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 16:14:54.7046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKIbw4mXxJtmWPbs/Bmoaryhe6jLT79k9edXJADvPF17+JpwQbyBJ5/PGUcbsA9uGtHIQIky+mo3TxJb+RuY/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8235

> On Wed, Sep 04, 2024 at 04:21:20PM +0530, Pankaj Gupta wrote:
> > NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE), are
> > embedded in the SoC to support the features like HSM, SHE & V2X, using
> > message based communication interface.
> >
> > The secure enclave FW communicates on a dedicated messaging unit(MU)
> > based interface(s) with application core, where kernel is running.
> > It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.
> >
> > This patch adds the driver for communication interface to
> > secure-enclave, for exchanging messages with NXP secure enclave HW
> > IP(s) like EdgeLock Enclave (ELE) from Kernel-space, used by kernel
> > management layers like
> > - DM-Crypt.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  drivers/firmware/imx/Kconfig        |  12 +
> >  drivers/firmware/imx/Makefile       |   2 +
> >  drivers/firmware/imx/ele_base_msg.c | 286 ++++++++++++++++++++
> > drivers/firmware/imx/ele_base_msg.h |  95 +++++++
> >  drivers/firmware/imx/ele_common.c   | 306 +++++++++++++++++++++
> >  drivers/firmware/imx/ele_common.h   |  51 ++++
> >  drivers/firmware/imx/se_ctrl.c      | 515
> ++++++++++++++++++++++++++++++++++++
> >  drivers/firmware/imx/se_ctrl.h      |  99 +++++++
> >  include/linux/firmware/imx/se_api.h |  14 +
> >  9 files changed, 1380 insertions(+)
> >
> > diff --git a/drivers/firmware/imx/Kconfig
> > b/drivers/firmware/imx/Kconfig index 183613f82a11..0f6877a24f0b 100644
> > --- a/drivers/firmware/imx/Kconfig
> > +++ b/drivers/firmware/imx/Kconfig
> > @@ -22,3 +22,15 @@ config IMX_SCU
> >
> >  	  This driver manages the IPC interface between host CPU and the
> >  	  SCU firmware running on M4.
> > +
> > +config IMX_SEC_ENCLAVE
> > +	tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmware
> driver."
> > +	depends on IMX_MBOX && ARCH_MXC && ARM64
> > +	default m if ARCH_MXC
> > +
> > +	help
> > +	  It is possible to use APIs exposed by the iMX Secure Enclave HW IP
> called:
> > +	  - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> > +	    like base, HSM, V2X & SHE using the SAB protocol via the shared
> Messaging
> > +	    Unit. This driver exposes these interfaces via a set of file desc=
riptors
> > +	    allowing to configure shared memory, send and receive messages.
> > diff --git a/drivers/firmware/imx/Makefile
> > b/drivers/firmware/imx/Makefile index 8f9f04a513a8..aa9033e0e9e3
> > 100644
> > --- a/drivers/firmware/imx/Makefile
> > +++ b/drivers/firmware/imx/Makefile
> > @@ -1,3 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_IMX_DSP)		+=3D imx-dsp.o
> >  obj-$(CONFIG_IMX_SCU)		+=3D imx-scu.o misc.o imx-scu-irq.o
> rm.o imx-scu-soc.o
> > +sec_enclave-objs		=3D se_ctrl.o ele_common.o ele_base_msg.o
> > +obj-${CONFIG_IMX_SEC_ENCLAVE}	+=3D sec_enclave.o
> > diff --git a/drivers/firmware/imx/ele_base_msg.c
> > b/drivers/firmware/imx/ele_base_msg.c
> > new file mode 100644
> > index 000000000000..e3e570a25e85
> > --- /dev/null
> > +++ b/drivers/firmware/imx/ele_base_msg.c
> > @@ -0,0 +1,286 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#include <linux/types.h>
> > +
> > +#include <linux/completion.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/genalloc.h>
> > +
> > +#include "ele_base_msg.h"
> > +#include "ele_common.h"
> > +
> > +int ele_get_info(struct device *dev, struct ele_dev_info *s_info) {
> > +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +	struct se_api_msg *tx_msg __free(kfree) =3D NULL;
> > +	struct se_api_msg *rx_msg __free(kfree) =3D NULL;
> > +	dma_addr_t get_info_addr =3D 0;
> > +	u32 *get_info_data =3D NULL;
> > +	int ret =3D 0;
> > +
> > +	if (!priv) {
> > +		ret =3D -EINVAL;
> > +		return ret;
> > +	}
> > +
> > +	memset(s_info, 0x0, sizeof(*s_info));
> > +
> > +	if (priv->mem_pool)
> > +		get_info_data =3D gen_pool_dma_alloc(priv->mem_pool,
> > +						   ELE_GET_INFO_BUFF_SZ,
> > +						   &get_info_addr);
> > +	else
> > +		get_info_data =3D dma_alloc_coherent(dev,
> > +						   ELE_GET_INFO_BUFF_SZ,
> > +						   &get_info_addr,
> > +						   GFP_KERNEL);
> > +	if (!get_info_data) {
> > +		ret =3D -ENOMEM;
> > +		dev_dbg(dev,
> > +			"%s: Failed to allocate get_info_addr.\n",
> > +			__func__);
> > +		return ret;
> > +	}
> > +
> > +	tx_msg =3D kzalloc(ELE_GET_INFO_REQ_MSG_SZ, GFP_KERNEL);
> > +	if (!tx_msg) {
> > +		ret =3D -ENOMEM;
> > +		goto exit;
> > +	}
> > +
> > +	rx_msg =3D kzalloc(ELE_GET_INFO_RSP_MSG_SZ, GFP_KERNEL);
> > +	if (!rx_msg) {
> > +		ret =3D -ENOMEM;
> > +		goto exit;
> > +	}
> > +
> > +	ret =3D se_fill_cmd_msg_hdr(priv,
> > +				      (struct se_msg_hdr *)&tx_msg->header,
> > +				      ELE_GET_INFO_REQ,
> > +				      ELE_GET_INFO_REQ_MSG_SZ,
> > +				      true);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	tx_msg->data[0] =3D upper_32_bits(get_info_addr);
> > +	tx_msg->data[1] =3D lower_32_bits(get_info_addr);
> > +	tx_msg->data[2] =3D sizeof(*s_info);
> > +	ret =3D ele_msg_send_rcv(priv,
> > +			       tx_msg,
> > +			       ELE_GET_INFO_REQ_MSG_SZ,
> > +			       rx_msg,
> > +			       ELE_GET_INFO_RSP_MSG_SZ);
> > +	if (ret < 0)
> > +		goto exit;
> > +
> > +	ret =3D se_val_rsp_hdr_n_status(priv,
> > +				      rx_msg,
> > +				      ELE_GET_INFO_REQ,
> > +				      ELE_GET_INFO_RSP_MSG_SZ,
> > +				      true);
> > +
> > +	memcpy(s_info, get_info_data, sizeof(*s_info));
> > +	priv->imem.state =3D s_info->d_addn_info.imem_state;
> > +
> > +exit:
> > +	if (priv->mem_pool)
> > +		gen_pool_free(priv->mem_pool,
> > +			      (u64) get_info_data,
> > +			      ELE_GET_INFO_BUFF_SZ);
> > +	else
> > +		dma_free_coherent(dev,
> > +				  ELE_GET_INFO_BUFF_SZ,
> > +				  get_info_data,
> > +				  get_info_addr);
> > +
> > +	return ret;
> > +}
> > +
> > +int ele_fetch_soc_info(struct device *dev, u16 *soc_rev, u64
> > +*serial_num) {
> > +	struct ele_dev_info s_info =3D {0};
> > +	int err =3D 0;
>=20
> Nit: needn't set err to 0 if following set it unconditional

Accepted. Will correct it in v8.=20

>=20
> err =3D ele_get_info(dev, &s_info);
>=20
> Frank
>=20
> > +
> > +	err =3D ele_get_info(dev, &s_info);
> > +	if (err < 0) {
> > +		dev_err(dev, "Error");
> > +		return err;
> > +	}
> > +
> > +	if (soc_rev)
> > +		*soc_rev =3D s_info.d_info.soc_rev;
> > +	if (serial_num)
> > +		*serial_num =3D
> GET_SERIAL_NUM_FROM_UID(s_info.d_info.uid,
> > +MAX_UID_SIZE >> 2);
> > +
> > +	return err;
> > +}
> > +
> > +int ele_ping(struct device *dev)
> > +{
> > +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +	struct se_api_msg *tx_msg __free(kfree) =3D NULL;
> > +	struct se_api_msg *rx_msg __free(kfree) =3D NULL;
> > +	int ret =3D 0;
> > +
> > +	if (!priv) {
> > +		ret =3D -EINVAL;
> > +		goto exit;
> > +	}
> > +
> > +	tx_msg =3D kzalloc(ELE_PING_REQ_SZ, GFP_KERNEL);
> > +	if (!tx_msg) {
> > +		ret =3D -ENOMEM;
> > +		goto exit;
> > +	}
> > +
> > +	rx_msg =3D kzalloc(ELE_PING_RSP_SZ, GFP_KERNEL);
> > +	if (!rx_msg) {
> > +		ret =3D -ENOMEM;
> > +		goto exit;
> > +	}
> > +
> > +	ret =3D se_fill_cmd_msg_hdr(priv,
> > +				      (struct se_msg_hdr *)&tx_msg->header,
> > +				      ELE_PING_REQ, ELE_PING_REQ_SZ, true);
> > +	if (ret) {
> > +		dev_err(dev, "Error: se_fill_cmd_msg_hdr failed.\n");
> > +		goto exit;
> > +	}
> > +
> > +	ret =3D ele_msg_send_rcv(priv,
> > +			       tx_msg,
> > +			       ELE_PING_REQ_SZ,
> > +			       rx_msg,
> > +			       ELE_PING_RSP_SZ);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	ret =3D se_val_rsp_hdr_n_status(priv,
> > +				      rx_msg,
> > +				      ELE_PING_REQ,
> > +				      ELE_PING_RSP_SZ,
> > +				      true);
> > +exit:
> > +	return ret;
> > +}
> > +
> > +int ele_service_swap(struct device *dev,
> > +		     phys_addr_t addr,
> > +		     u32 addr_size, u16 flag)
> > +{
> > +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +	struct se_api_msg *tx_msg __free(kfree) =3D NULL;
> > +	struct se_api_msg *rx_msg __free(kfree) =3D NULL;
> > +	int ret =3D 0;
> > +
> > +	if (!priv) {
> > +		ret =3D -EINVAL;
> > +		goto exit;
> > +	}
> > +
> > +	tx_msg =3D kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ, GFP_KERNEL);
> > +	if (!tx_msg) {
> > +		ret =3D -ENOMEM;
> > +		goto exit;
> > +	}
> > +
> > +	rx_msg =3D kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ, GFP_KERNEL);
> > +	if (!rx_msg) {
> > +		ret =3D -ENOMEM;
> > +		goto exit;
> > +	}
> > +
> > +	ret =3D se_fill_cmd_msg_hdr(priv,
> > +				      (struct se_msg_hdr *)&tx_msg->header,
> > +				      ELE_SERVICE_SWAP_REQ,
> > +				      ELE_SERVICE_SWAP_REQ_MSG_SZ, true);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	tx_msg->data[0] =3D flag;
> > +	tx_msg->data[1] =3D addr_size;
> > +	tx_msg->data[2] =3D ELE_NONE_VAL;
> > +	tx_msg->data[3] =3D lower_32_bits(addr);
> > +	tx_msg->data[4] =3D se_add_msg_crc((uint32_t *)&tx_msg[0],
> > +
> ELE_SERVICE_SWAP_REQ_MSG_SZ);
> > +	ret =3D ele_msg_send_rcv(priv,
> > +			       tx_msg,
> > +			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
> > +			       rx_msg,
> > +			       ELE_SERVICE_SWAP_RSP_MSG_SZ);
> > +	if (ret < 0)
> > +		goto exit;
> > +
> > +	ret =3D se_val_rsp_hdr_n_status(priv,
> > +				      rx_msg,
> > +				      ELE_SERVICE_SWAP_REQ,
> > +				      ELE_SERVICE_SWAP_RSP_MSG_SZ,
> > +				      true);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	if (flag =3D=3D ELE_IMEM_EXPORT)
> > +		ret =3D rx_msg->data[1];
> > +	else
> > +		ret =3D 0;
> > +
> > +exit:
> > +
> > +	return ret;
> > +}
> > +
> > +int ele_fw_authenticate(struct device *dev, phys_addr_t addr) {
> > +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +	struct se_api_msg *tx_msg __free(kfree) =3D NULL;
> > +	struct se_api_msg *rx_msg __free(kfree) =3D NULL;
> > +	int ret =3D 0;
> > +
> > +	if (!priv) {
> > +		ret =3D -EINVAL;
> > +		goto exit;
> > +	}
> > +
> > +	tx_msg =3D kzalloc(ELE_FW_AUTH_REQ_SZ, GFP_KERNEL);
> > +	if (!tx_msg) {
> > +		ret =3D -ENOMEM;
> > +		goto exit;
> > +	}
> > +
> > +	rx_msg =3D kzalloc(ELE_FW_AUTH_RSP_MSG_SZ, GFP_KERNEL);
> > +	if (!rx_msg) {
> > +		ret =3D -ENOMEM;
> > +		goto exit;
> > +	}
> > +
> > +	ret =3D se_fill_cmd_msg_hdr(priv,
> > +				  (struct se_msg_hdr *)&tx_msg->header,
> > +				  ELE_FW_AUTH_REQ,
> > +				  ELE_FW_AUTH_REQ_SZ,
> > +				  true);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	tx_msg->data[1] =3D upper_32_bits(addr);
> > +	tx_msg->data[0] =3D lower_32_bits(addr);
> > +	tx_msg->data[2] =3D addr;
> > +
> > +	ret =3D ele_msg_send_rcv(priv,
> > +			       tx_msg,
> > +			       ELE_FW_AUTH_REQ_SZ,
> > +			       rx_msg,
> > +			       ELE_FW_AUTH_RSP_MSG_SZ);
> > +	if (ret < 0)
> > +		goto exit;
> > +
> > +	ret =3D se_val_rsp_hdr_n_status(priv,
> > +				      rx_msg,
> > +				      ELE_FW_AUTH_REQ,
> > +				      ELE_FW_AUTH_RSP_MSG_SZ,
> > +				      true);
> > +exit:
> > +	return ret;
> > +}
> > diff --git a/drivers/firmware/imx/ele_base_msg.h
> > b/drivers/firmware/imx/ele_base_msg.h
> > new file mode 100644
> > index 000000000000..88ccfce8c8f7
> > --- /dev/null
> > +++ b/drivers/firmware/imx/ele_base_msg.h
> > @@ -0,0 +1,95 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2024 NXP
> > + *
> > + * Header file for the EdgeLock Enclave Base API(s).
> > + */
> > +
> > +#ifndef ELE_BASE_MSG_H
> > +#define ELE_BASE_MSG_H
> > +
> > +#include <linux/device.h>
> > +#include <linux/types.h>
> > +
> > +#define WORD_SZ				4
> > +#define ELE_NONE_VAL			0x0
> > +
> > +#define ELE_GET_INFO_REQ		0xDA
> > +#define ELE_GET_INFO_REQ_MSG_SZ		0x10
> > +#define ELE_GET_INFO_RSP_MSG_SZ		0x08
> > +
> > +#define DEFAULT_IMX_SOC_VER		0xA000
> > +#define SOC_VER_MASK			0xFFFF0000
> > +#define SOC_ID_MASK			0x0000FFFF
> > +
> > +#define MAX_UID_SIZE                     (16)
> > +#define DEV_GETINFO_ROM_PATCH_SHA_SZ     (32)
> > +#define DEV_GETINFO_FW_SHA_SZ            (32)
> > +#define DEV_GETINFO_OEM_SRKH_SZ          (64)
> > +#define DEV_GETINFO_MIN_VER_MASK	0xFF
> > +#define DEV_GETINFO_MAJ_VER_MASK	0xFF00
> > +#define ELE_DEV_INFO_EXTRA_SZ		0x60
> > +
> > +struct dev_info {
> > +	uint8_t  cmd;
> > +	uint8_t  ver;
> > +	uint16_t length;
> > +	uint16_t soc_id;
> > +	uint16_t soc_rev;
> > +	uint16_t lmda_val;
> > +	uint8_t  ssm_state;
> > +	uint8_t  dev_atts_api_ver;
> > +	uint8_t  uid[MAX_UID_SIZE];
> > +	uint8_t  sha_rom_patch[DEV_GETINFO_ROM_PATCH_SHA_SZ];
> > +	uint8_t  sha_fw[DEV_GETINFO_FW_SHA_SZ]; };
> > +
> > +struct dev_addn_info {
> > +	uint8_t  oem_srkh[DEV_GETINFO_OEM_SRKH_SZ];
> > +	uint8_t  trng_state;
> > +	uint8_t  csal_state;
> > +	uint8_t  imem_state;
> > +	uint8_t  reserved2;
> > +};
> > +
> > +struct ele_dev_info {
> > +	struct dev_info d_info;
> > +	struct dev_addn_info d_addn_info;
> > +};
> > +
> > +#define ELE_GET_INFO_BUFF_SZ		(sizeof(struct ele_dev_info) \
> > +						+ ELE_DEV_INFO_EXTRA_SZ)
> > +
> > +#define GET_SERIAL_NUM_FROM_UID(x, uid_word_sz) \
> > +	(((u64)(((u32 *)(x))[(uid_word_sz) - 1]) << 32) | ((u32 *)(x))[0])
> > +
> > +#define ELE_DEBUG_DUMP_REQ		0x21
> > +#define ELE_DEBUG_DUMP_RSP_SZ		0x14
> > +
> > +#define ELE_PING_REQ			0x01
> > +#define ELE_PING_REQ_SZ			0x04
> > +#define ELE_PING_RSP_SZ			0x08
> > +
> > +#define ELE_SERVICE_SWAP_REQ		0xDF
> > +#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x18
> > +#define ELE_SERVICE_SWAP_RSP_MSG_SZ	0x0C
> > +#define ELE_IMEM_SIZE			0x10000
> > +#define ELE_IMEM_STATE_OK		0xCA
> > +#define ELE_IMEM_STATE_BAD		0xFE
> > +#define ELE_IMEM_STATE_WORD		0x27
> > +#define ELE_IMEM_STATE_MASK		0x00ff0000
> > +#define ELE_IMEM_EXPORT			0x1
> > +#define ELE_IMEM_IMPORT			0x2
> > +
> > +#define ELE_FW_AUTH_REQ			0x02
> > +#define ELE_FW_AUTH_REQ_SZ		0x10
> > +#define ELE_FW_AUTH_RSP_MSG_SZ		0x08
> > +
> > +int ele_get_info(struct device *dev, struct ele_dev_info *s_info);
> > +int ele_fetch_soc_info(struct device *dev, u16 *soc_rev, u64
> > +*serial_num); int ele_ping(struct device *dev); int
> > +ele_service_swap(struct device *dev,
> > +		     phys_addr_t addr,
> > +		     u32 addr_size, u16 flag);
> > +int ele_fw_authenticate(struct device *dev, phys_addr_t addr); #endif
> > diff --git a/drivers/firmware/imx/ele_common.c
> > b/drivers/firmware/imx/ele_common.c
> > new file mode 100644
> > index 000000000000..a06d7015d3f1
> > --- /dev/null
> > +++ b/drivers/firmware/imx/ele_common.c
> > @@ -0,0 +1,306 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#include "ele_base_msg.h"
> > +#include "ele_common.h"
> > +
> > +u32 se_add_msg_crc(u32 *msg, u32 msg_len) {
> > +	u32 nb_words =3D msg_len / (u32)sizeof(u32);
> > +	u32 crc =3D 0;
> > +	u32 i;
> > +
> > +	for (i =3D 0; i < nb_words - 1; i++)
> > +		crc ^=3D *(msg + i);
> > +
> > +	return crc;
> > +}
> > +
> > +int ele_msg_rcv(struct se_if_priv *priv,
> > +		struct se_clbk_handle *se_clbk_hdl) {
> > +	int err =3D 0;
> > +
> > +	err =3D wait_event_interruptible(se_clbk_hdl->wq,
> > +				       atomic_read(&se_clbk_hdl-
> >pending_hdr) !=3D 0);
> > +	if (err < 0)
> > +		dev_err(priv->dev,
> > +			"Err[0x%x]:Interrupted by signal.\n",
> > +			err);
> > +	else
> > +		err =3D se_clbk_hdl->rx_msg_sz;
> > +
> > +	atomic_dec(&se_clbk_hdl->pending_hdr);
> > +
> > +	return err;
> > +}
> > +
> > +int ele_msg_send(struct se_if_priv *priv,
> > +		 void *tx_msg,
> > +		 int tx_msg_sz)
> > +{
> > +	struct se_msg_hdr *header;
> > +	int err;
> > +
> > +	header =3D tx_msg;
> > +
> > +	/*
> > +	 * Check that the size passed as argument matches the size
> > +	 * carried in the message.
> > +	 */
> > +	if (header->size << 2 !=3D tx_msg_sz) {
> > +		err =3D -EINVAL;
> > +		dev_err(priv->dev,
> > +			"User buf hdr: 0x%x, sz mismatced with input-sz
> (%d !=3D %d).",
> > +			*(u32 *)header,
> > +			header->size << 2, tx_msg_sz);
> > +		goto exit;
> > +	}
> > +	guard(mutex)(&priv->se_if_lock);
> > +
> > +	err =3D mbox_send_message(priv->tx_chan, tx_msg);
> > +	if (err < 0) {
> > +		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
> > +		return err;
> > +	}
> > +	err =3D tx_msg_sz;
> > +
> > +exit:
> > +	return err;
> > +}
> > +
> > +/* API used for send/receive blocking call. */ int
> > +ele_msg_send_rcv(struct se_if_priv *priv,
> > +		     void *tx_msg,
> > +		     int tx_msg_sz,
> > +		     void *rx_msg,
> > +		     int exp_rx_msg_sz)
> > +{
> > +	int err;
> > +
> > +	guard(mutex)(&priv->se_if_cmd_lock);
> > +
> > +	priv->waiting_rsp_clbk_hdl.rx_msg_sz =3D exp_rx_msg_sz;
> > +	priv->waiting_rsp_clbk_hdl.rx_msg =3D rx_msg;
> > +
> > +	err =3D ele_msg_send(priv, tx_msg, tx_msg_sz);
> > +	if (err < 0)
> > +		goto exit;
> > +
> > +	err =3D ele_msg_rcv(priv, &priv->waiting_rsp_clbk_hdl);
> > +exit:
> > +	return err;
> > +}
> > +
> > +static bool exception_for_size(struct se_if_priv *priv,
> > +				struct se_msg_hdr *header)
> > +{
> > +	/* List of API(s) that can be accepte variable length
> > +	 * response buffer.
> > +	 */
> > +	if (header->command =3D=3D ELE_DEBUG_DUMP_REQ &&
> > +		header->ver =3D=3D priv->base_api_ver &&
> > +		header->size >=3D 0 &&
> > +		header->size <=3D ELE_DEBUG_DUMP_RSP_SZ)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +/*
> > + * Callback called by mailbox FW, when data is received.
> > + */
> > +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg) {
> > +	struct se_clbk_handle *se_clbk_hdl;
> > +	struct device *dev =3D mbox_cl->dev;
> > +	struct se_msg_hdr *header;
> > +	struct se_if_priv *priv;
> > +	u32 rx_msg_sz;
> > +
> > +	priv =3D dev_get_drvdata(dev);
> > +
> > +	/* The function can be called with NULL msg */
> > +	if (!msg) {
> > +		dev_err(dev, "Message is invalid\n");
> > +		return;
> > +	}
> > +
> > +	header =3D msg;
> > +	rx_msg_sz =3D header->size << 2;
> > +
> > +	/* Incoming command: wake up the receiver if any. */
> > +	if (header->tag =3D=3D priv->cmd_tag) {
> > +		se_clbk_hdl =3D &priv->cmd_receiver_clbk_hdl;
> > +		dev_dbg(dev,
> > +			"Selecting cmd receiver for mesg header:0x%x.",
> > +			*(u32 *) header);
> > +
> > +		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
> > +		 * as the NVM command are initiated by FW.
> > +		 * Size is revealed as part of this call function.
> > +		 */
> > +		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
> > +			dev_err(dev,
> > +				"CMD-RCVER NVM: hdr(0x%x) with different
> sz(%d !=3D %d).\n",
> > +				*(u32 *) header,
> > +				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
> > +
> > +			se_clbk_hdl->rx_msg_sz =3D MAX_NVM_MSG_LEN;
> > +		}
> > +		se_clbk_hdl->rx_msg_sz =3D rx_msg_sz;
> > +
> > +	} else if (header->tag =3D=3D priv->rsp_tag) {
> > +		se_clbk_hdl =3D &priv->waiting_rsp_clbk_hdl;
> > +		dev_dbg(dev,
> > +			"Selecting resp waiter for mesg header:0x%x.",
> > +			*(u32 *) header);
> > +
> > +		if (rx_msg_sz !=3D se_clbk_hdl->rx_msg_sz
> > +				&& !exception_for_size(priv, header)) {
> > +			dev_err(dev,
> > +				"Rsp to CMD: hdr(0x%x) with different
> sz(%d !=3D %d).\n",
> > +				*(u32 *) header,
> > +				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
> > +
> > +			se_clbk_hdl->rx_msg_sz =3D min(rx_msg_sz,
> se_clbk_hdl->rx_msg_sz);
> > +		}
> > +	} else {
> > +		dev_err(dev, "Failed to select a device for message: %.8x\n",
> > +			*((u32 *) header));
> > +		return;
> > +	}
> > +
> > +	memcpy(se_clbk_hdl->rx_msg, msg, se_clbk_hdl->rx_msg_sz);
> > +
> > +	/* Allow user to read */
> > +	atomic_inc(&se_clbk_hdl->pending_hdr);
> > +
> > +	wake_up_interruptible(&se_clbk_hdl->wq);
> > +}
> > +
> > +int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
> > +			    struct se_api_msg *msg,
> > +			    uint8_t msg_id,
> > +			    uint8_t sz,
> > +			    bool is_base_api)
> > +{
> > +	u32 status;
> > +	struct se_msg_hdr *header =3D &msg->header;
> > +
> > +	if (header->tag !=3D priv->rsp_tag) {
> > +		dev_err(priv->dev,
> > +			"MSG[0x%x] Hdr: Resp tag mismatch. (0x%x !=3D
> 0x%x)",
> > +			msg_id, header->tag, priv->rsp_tag);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (header->command !=3D msg_id) {
> > +		dev_err(priv->dev,
> > +			"MSG Header: Cmd id mismatch. (0x%x !=3D 0x%x)",
> > +			header->command, msg_id);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (header->size !=3D (sz >> 2)) {
> > +		dev_err(priv->dev,
> > +			"MSG[0x%x] Hdr: Cmd size mismatch. (0x%x !=3D
> 0x%x)",
> > +			msg_id, header->size, (sz >> 2));
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (is_base_api && (header->ver !=3D priv->base_api_ver)) {
> > +		dev_err(priv->dev,
> > +			"MSG[0x%x] Hdr: Base API Vers mismatch. (0x%x !=3D
> 0x%x)",
> > +			msg_id, header->ver, priv->base_api_ver);
> > +		return -EINVAL;
> > +	} else if (!is_base_api && header->ver !=3D priv->fw_api_ver) {
> > +		dev_err(priv->dev,
> > +			"MSG[0x%x] Hdr: FW API Vers mismatch. (0x%x !=3D
> 0x%x)",
> > +			msg_id, header->ver, priv->fw_api_ver);
> > +		return -EINVAL;
> > +	}
> > +
> > +	status =3D RES_STATUS(msg->data[0]);
> > +	if (status !=3D priv->success_tag) {
> > +		dev_err(priv->dev, "Command Id[%d], Response Failure =3D
> 0x%x",
> > +			header->command, status);
> > +		return -EPERM;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int se_save_imem_state(struct se_if_priv *priv) {
> > +	int ret;
> > +
> > +	/* EXPORT command will save encrypted IMEM to given address,
> > +	 * so later in resume, IMEM can be restored from the given
> > +	 * address.
> > +	 *
> > +	 * Size must be at least 64 kB.
> > +	 */
> > +	ret =3D ele_service_swap(priv->dev,
> > +			       priv->imem.phyaddr,
> > +			       ELE_IMEM_SIZE,
> > +			       ELE_IMEM_EXPORT);
> > +	if (ret < 0)
> > +		dev_err(priv->dev, "Failed to export IMEM\n");
> > +	else
> > +		dev_info(priv->dev,
> > +			"Exported %d bytes of encrypted IMEM\n",
> > +			ret);
> > +
> > +	return ret;
> > +}
> > +
> > +int se_restore_imem_state(struct se_if_priv *priv) {
> > +	struct ele_dev_info s_info;
> > +	int ret;
> > +
> > +	/* get info from ELE */
> > +	ret =3D ele_get_info(priv->dev, &s_info);
> > +	if (ret) {
> > +		dev_err(priv->dev, "Failed to get info from ELE.\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Get IMEM state, if 0xFE then import IMEM */
> > +	if (s_info.d_addn_info.imem_state =3D=3D ELE_IMEM_STATE_BAD) {
> > +		/* IMPORT command will restore IMEM from the given
> > +		 * address, here size is the actual size returned by ELE
> > +		 * during the export operation
> > +		 */
> > +		ret =3D ele_service_swap(priv->dev,
> > +				       priv->imem.phyaddr,
> > +				       priv->imem.size,
> > +				       ELE_IMEM_IMPORT);
> > +		if (ret) {
> > +			dev_err(priv->dev, "Failed to import IMEM\n");
> > +			goto exit;
> > +		}
> > +	} else
> > +		goto exit;
> > +
> > +	/* After importing IMEM, check if IMEM state is equal to 0xCA
> > +	 * to ensure IMEM is fully loaded and
> > +	 * ELE functionality can be used.
> > +	 */
> > +	ret =3D ele_get_info(priv->dev, &s_info);
> > +	if (ret) {
> > +		dev_err(priv->dev, "Failed to get info from ELE.\n");
> > +		goto exit;
> > +	}
> > +
> > +	if (s_info.d_addn_info.imem_state =3D=3D ELE_IMEM_STATE_OK)
> > +		dev_info(priv->dev, "Successfully restored IMEM\n");
> > +	else
> > +		dev_err(priv->dev, "Failed to restore IMEM\n");
> > +
> > +exit:
> > +	return ret;
> > +}
> > diff --git a/drivers/firmware/imx/ele_common.h
> > b/drivers/firmware/imx/ele_common.h
> > new file mode 100644
> > index 000000000000..b05d62090337
> > --- /dev/null
> > +++ b/drivers/firmware/imx/ele_common.h
> > @@ -0,0 +1,51 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +
> > +#ifndef __ELE_COMMON_H__
> > +#define __ELE_COMMON_H__
> > +
> > +#include "se_ctrl.h"
> > +
> > +#define ELE_SUCCESS_IND			0xD6
> > +
> > +#define IMX_ELE_FW_DIR                 "imx/ele/"
> > +
> > +uint32_t se_add_msg_crc(uint32_t *msg, uint32_t msg_len); int
> > +ele_msg_rcv(struct se_if_priv *priv,
> > +		struct se_clbk_handle *se_clbk_hdl); int ele_msg_send(struct
> > +se_if_priv *priv,
> > +		 void *tx_msg,
> > +		 int tx_msg_sz);
> > +int ele_msg_send_rcv(struct se_if_priv *priv,
> > +		     void *tx_msg,
> > +		     int tx_msg_sz,
> > +		     void *rx_msg,
> > +		     int exp_rx_msg_sz);
> > +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg); int
> > +se_val_rsp_hdr_n_status(struct se_if_priv *priv,
> > +			    struct se_api_msg *msg,
> > +			    uint8_t msg_id,
> > +			    uint8_t sz,
> > +			    bool is_base_api);
> > +
> > +/* Fill a command message header with a given command ID and length
> > +in bytes. */ static inline int se_fill_cmd_msg_hdr(struct se_if_priv *=
priv,
> > +				      struct se_msg_hdr *hdr,
> > +				      u8 cmd, u32 len,
> > +				      bool is_base_api)
> > +{
> > +	hdr->tag =3D priv->cmd_tag;
> > +	hdr->ver =3D (is_base_api) ? priv->base_api_ver : priv->fw_api_ver;
> > +	hdr->command =3D cmd;
> > +	hdr->size =3D len >> 2;
> > +
> > +	return 0;
> > +}
> > +
> > +int se_save_imem_state(struct se_if_priv *priv); int
> > +se_restore_imem_state(struct se_if_priv *priv);
> > +
> > +#endif /*__ELE_COMMON_H__ */
> > diff --git a/drivers/firmware/imx/se_ctrl.c
> > b/drivers/firmware/imx/se_ctrl.c new file mode 100644 index
> > 000000000000..82b9fcf25535
> > --- /dev/null
> > +++ b/drivers/firmware/imx/se_ctrl.c
> > @@ -0,0 +1,515 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/dev_printk.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/errno.h>
> > +#include <linux/export.h>
> > +#include <linux/firmware.h>
> > +#include <linux/firmware/imx/se_api.h> #include <linux/genalloc.h>
> > +#include <linux/init.h> #include <linux/io.h> #include
> > +<linux/miscdevice.h> #include <linux/mod_devicetable.h> #include
> > +<linux/module.h> #include <linux/of_platform.h> #include
> > +<linux/of_reserved_mem.h> #include <linux/platform_device.h> #include
> > +<linux/slab.h> #include <linux/string.h> #include <linux/sys_soc.h>
> > +
> > +#include "ele_base_msg.h"
> > +#include "ele_common.h"
> > +#include "se_ctrl.h"
> > +
> > +#define RESERVED_DMA_POOL		BIT(0)
> > +#define MBOX_TX_NAME			"tx"
> > +#define MBOX_RX_NAME			"rx"
> > +
> > +struct se_if_node_info {
> > +	u8 se_if_id;
> > +	u8 se_if_did;
> > +	u8 cmd_tag;
> > +	u8 rsp_tag;
> > +	u8 success_tag;
> > +	u8 base_api_ver;
> > +	u8 fw_api_ver;
> > +	u8 *se_name;
> > +	u8 *pool_name;
> > +	u8 *prim_fw_nm_in_rfs;
> > +	u8 *seco_fw_nm_in_rfs;
> > +	bool soc_register;
> > +	bool reserved_dma_ranges;
> > +	int (*se_fetch_soc_info)(struct device *dev, u16 *soc_rev, u64
> > +*serial_num); };
> > +
> > +struct se_if_node_info_list {
> > +	u8 num_mu;
> > +	u16 soc_id;
> > +	struct se_if_node_info info[];
> > +};
> > +
> > +static const struct se_if_node_info_list imx8ulp_info =3D {
> > +	.num_mu =3D 1,
> > +	.soc_id =3D SOC_ID_OF_IMX8ULP,
> > +	.info =3D {
> > +			{
> > +			.se_if_id =3D 2,
> > +			.se_if_did =3D 7,
> > +			.cmd_tag =3D 0x17,
> > +			.rsp_tag =3D 0xe1,
> > +			.success_tag =3D ELE_SUCCESS_IND,
> > +			.base_api_ver =3D MESSAGING_VERSION_6,
> > +			.fw_api_ver =3D MESSAGING_VERSION_7,
> > +			.se_name =3D "hsm1",
> > +			.pool_name =3D "sram",
> > +			.prim_fw_nm_in_rfs =3D IMX_ELE_FW_DIR
> > +						"mx8ulpa2-ahab-
> container.img",
> > +			.seco_fw_nm_in_rfs =3D IMX_ELE_FW_DIR
> > +						"mx8ulpa2ext-ahab-
> container.img",
> > +			.soc_register =3D true,
> > +			.reserved_dma_ranges =3D true,
> > +			.se_fetch_soc_info =3D ele_fetch_soc_info,
> > +			},
> > +	},
> > +};
> > +
> > +static const struct se_if_node_info_list imx93_info =3D {
> > +	.num_mu =3D 1,
> > +	.soc_id =3D SOC_ID_OF_IMX93,
> > +	.info =3D {
> > +			{
> > +			.se_if_id =3D 2,
> > +			.se_if_did =3D 3,
> > +			.cmd_tag =3D 0x17,
> > +			.rsp_tag =3D 0xe1,
> > +			.success_tag =3D ELE_SUCCESS_IND,
> > +			.base_api_ver =3D MESSAGING_VERSION_6,
> > +			.fw_api_ver =3D MESSAGING_VERSION_7,
> > +			.se_name =3D "hsm1",
> > +			.reserved_dma_ranges =3D true,
> > +			.soc_register =3D true,
> > +			},
> > +	},
> > +};
> > +
> > +static const struct of_device_id se_match[] =3D {
> > +	{ .compatible =3D "fsl,imx8ulp-se", .data =3D (void *)&imx8ulp_info},
> > +	{ .compatible =3D "fsl,imx93-se", .data =3D (void *)&imx93_info},
> > +	{},
> > +};
> > +
> > +static const struct se_if_node_info
> > +	*get_se_if_node_info(const struct se_if_node_info_list *info_list,
> > +			      const u32 idx)
> > +{
> > +	return &info_list->info[idx];
> > +}
> > +
> > +static int se_soc_info(struct se_if_priv *priv,
> > +		       const struct se_if_node_info_list *info_list) {
> > +	const struct se_if_node_info *info;
> > +	struct soc_device_attribute *attr;
> > +	struct soc_device *sdev;
> > +	u64 serial_num;
> > +	u16 soc_rev;
> > +	int err =3D 0;
> > +
> > +	info =3D priv->info;
> > +
> > +	/* This function should be called once.
> > +	 * Check if the soc_rev is zero to continue.
> > +	 */
> > +	if (priv->soc_rev)
> > +		return err;
> > +
> > +	if (info->se_fetch_soc_info) {
> > +		err =3D info->se_fetch_soc_info(priv->dev, &soc_rev,
> &serial_num);
> > +		if (err < 0) {
> > +			dev_err(priv->dev, "Failed to fetch SoC Info.");
> > +			return err;
> > +		}
> > +	} else {
> > +		dev_err(priv->dev, "Failed to fetch SoC revision.");
> > +		if (info->soc_register)
> > +			dev_err(priv->dev, "Failed to do SoC registration.");
> > +		err =3D -EINVAL;
> > +		return err;
> > +	}
> > +
> > +	priv->soc_rev =3D soc_rev;
> > +	if (!info->soc_register)
> > +		return 0;
> > +
> > +	attr =3D devm_kzalloc(priv->dev, sizeof(*attr), GFP_KERNEL);
> > +	if (!attr)
> > +		return -ENOMEM;
> > +
> > +	if (FIELD_GET(DEV_GETINFO_MIN_VER_MASK, soc_rev))
> > +		attr->revision =3D devm_kasprintf(priv->dev, GFP_KERNEL,
> "%x.%x",
> > +
> 	FIELD_GET(DEV_GETINFO_MIN_VER_MASK,
> > +							  soc_rev),
> > +
> 	FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
> > +							  soc_rev));
> > +	else
> > +		attr->revision =3D devm_kasprintf(priv->dev, GFP_KERNEL, "%x",
> > +
> 	FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
> > +							  soc_rev));
> > +
> > +	switch (info_list->soc_id) {
> > +	case SOC_ID_OF_IMX8ULP:
> > +		attr->soc_id =3D devm_kasprintf(priv->dev, GFP_KERNEL,
> > +					      "i.MX8ULP");
> > +		break;
> > +	case SOC_ID_OF_IMX93:
> > +		attr->soc_id =3D devm_kasprintf(priv->dev, GFP_KERNEL,
> > +					      "i.MX93");
> > +		break;
> > +	}
> > +
> > +	err =3D of_property_read_string(of_root, "model",
> > +				      &attr->machine);
> > +	if (err)
> > +		return -EINVAL;
> > +
> > +	attr->family =3D devm_kasprintf(priv->dev, GFP_KERNEL, "Freescale
> > +i.MX");
> > +
> > +	attr->serial_number
> > +		=3D devm_kasprintf(priv->dev, GFP_KERNEL, "%016llX",
> serial_num);
> > +
> > +	sdev =3D soc_device_register(attr);
> > +	if (IS_ERR(sdev))
> > +		return PTR_ERR(sdev);
> > +
> > +	return 0;
> > +}
> > +
> > +/* interface for managed res to free a mailbox channel */ static void
> > +if_mbox_free_channel(void *mbox_chan) {
> > +	mbox_free_channel(mbox_chan);
> > +}
> > +
> > +static int se_if_request_channel(struct device *dev,
> > +				 struct mbox_chan **chan,
> > +				 struct mbox_client *cl,
> > +				 const char *name)
> > +{
> > +	struct mbox_chan *t_chan;
> > +	int ret =3D 0;
> > +
> > +	t_chan =3D mbox_request_channel_byname(cl, name);
> > +	if (IS_ERR(t_chan)) {
> > +		ret =3D PTR_ERR(t_chan);
> > +		return dev_err_probe(dev, ret,
> > +				     "Failed to request %s channel.", name);
> > +	}
> > +
> > +	ret =3D devm_add_action(dev, if_mbox_free_channel, t_chan);
> > +	if (ret) {
> > +		dev_err(dev, "failed to add devm removal of mbox %s\n",
> name);
> > +		goto exit;
> > +	}
> > +
> > +	*chan =3D t_chan;
> > +
> > +exit:
> > +	return ret;
> > +}
> > +
> > +static void se_if_probe_cleanup(struct platform_device *pdev) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct se_if_priv *priv;
> > +
> > +	priv =3D dev_get_drvdata(dev);
> > +
> > +	/* In se_if_request_channel(), passed the clean-up functional
> > +	 * pointer reference as action to devm_add_action().
> > +	 * No need to free the mbox channels here.
> > +	 */
> > +
> > +	/* free the buffer in se remove, previously allocated
> > +	 * in se probe to store encrypted IMEM
> > +	 */
> > +	if (priv->imem.buf) {
> > +		dmam_free_coherent(dev,
> > +				   ELE_IMEM_SIZE,
> > +				   priv->imem.buf,
> > +				   priv->imem.phyaddr);
> > +		priv->imem.buf =3D NULL;
> > +	}
> > +
> > +	/* No need to check, if reserved memory is allocated
> > +	 * before calling for its release. Or clearing the
> > +	 * un-set bit.
> > +	 */
> > +	of_reserved_mem_device_release(dev);
> > +}
> > +
> > +static void se_load_firmware(const struct firmware *fw, void
> > +*context) {
> > +	struct se_if_priv *priv =3D context;
> > +	const struct se_if_node_info *info =3D priv->info;
> > +	phys_addr_t se_fw_phyaddr;
> > +	u8 *se_fw_buf;
> > +	int ret;
> > +
> > +	if (!fw) {
> > +		if (priv->fw_fail > MAX_FW_LOAD_RETRIES)
> > +			dev_dbg(priv->dev,
> > +				 "External FW not found, using ROM FW.\n");
> > +		else {
> > +			/*add a bit delay to wait for firmware priv released */
> > +			msleep(20);
> > +
> > +			/* Load firmware one more time if timeout */
> > +			request_firmware_nowait(THIS_MODULE,
> > +					FW_ACTION_UEVENT, priv-
> >se_img_file_to_load,
> > +					priv->dev, GFP_KERNEL, priv,
> > +					se_load_firmware);
> > +			priv->fw_fail++;
> > +			dev_dbg(priv->dev, "Value of retries =3D 0x%x.\n",
> > +				priv->fw_fail);
> > +		}
> > +
> > +		return;
> > +	}
> > +
> > +	dev_info(priv->dev, "loading firmware %s\n",
> > +priv->se_img_file_to_load);
> > +
> > +	/* allocate buffer to store the SE FW */
> > +	se_fw_buf =3D dma_alloc_coherent(priv->dev, fw->size,
> > +			&se_fw_phyaddr, GFP_KERNEL);
> > +	if (!se_fw_buf)
> > +		goto exit;
> > +
> > +	memcpy(se_fw_buf, fw->data, fw->size);
> > +	ret =3D ele_fw_authenticate(priv->dev, se_fw_phyaddr);
> > +	if (ret < 0)
> > +		dev_err(priv->dev,
> > +			"Error %pe: Authenticate & load SE firmware %s.\n",
> > +			ERR_PTR(ret),
> > +			priv->se_img_file_to_load);
> > +
> > +	dma_free_coherent(priv->dev,
> > +			fw->size,
> > +			se_fw_buf,
> > +			se_fw_phyaddr);
> > +
> > +	if (priv->imem.state =3D=3D ELE_IMEM_STATE_BAD &&
> > +	    priv->se_img_file_to_load =3D=3D info->prim_fw_nm_in_rfs) {
> > +		priv->se_img_file_to_load =3D info->seco_fw_nm_in_rfs;
> > +		request_firmware_nowait(THIS_MODULE,
> > +				FW_ACTION_UEVENT, priv-
> >se_img_file_to_load,
> > +				priv->dev, GFP_KERNEL, priv,
> > +				se_load_firmware);
> > +	}
> > +
> > +exit:
> > +	release_firmware(fw);
> > +}
> > +
> > +static int se_if_probe(struct platform_device *pdev) {
> > +	const struct se_if_node_info_list *info_list;
> > +	const struct se_if_node_info *info;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct se_if_priv *priv;
> > +	u32 idx;
> > +	int ret;
> > +
> > +	idx =3D GET_IDX_FROM_DEV_NODE_NAME(dev->of_node);
> > +	info_list =3D device_get_match_data(dev);
> > +	if (idx >=3D info_list->num_mu) {
> > +		dev_err(dev,
> > +			"Incorrect node name :%s\n",
> > +			dev->of_node->full_name);
> > +		dev_err(dev,
> > +			"%s@<index>, acceptable index range is 0..%d\n",
> > +			dev->of_node->name,
> > +			info_list->num_mu - 1);
> > +		ret =3D -EINVAL;
> > +		return ret;
> > +	}
> > +
> > +	info =3D get_se_if_node_info(info_list, idx);
> > +	if (!info) {
> > +		ret =3D -EINVAL;
> > +		goto exit;
> > +	}
> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv) {
> > +		ret =3D -ENOMEM;
> > +		goto exit;
> > +	}
> > +
> > +	dev_set_drvdata(dev, priv);
> > +
> > +	/* Mailbox client configuration */
> > +	priv->se_mb_cl.dev		=3D dev;
> > +	priv->se_mb_cl.tx_block		=3D false;
> > +	priv->se_mb_cl.knows_txdone	=3D true;
> > +	priv->se_mb_cl.rx_callback	=3D se_if_rx_callback;
> > +
> > +	ret =3D se_if_request_channel(dev, &priv->tx_chan,
> > +			&priv->se_mb_cl, MBOX_TX_NAME);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	ret =3D se_if_request_channel(dev, &priv->rx_chan,
> > +			&priv->se_mb_cl, MBOX_RX_NAME);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	priv->dev =3D dev;
> > +	priv->info =3D info;
> > +
> > +	mutex_init(&priv->se_if_lock);
> > +	mutex_init(&priv->se_if_cmd_lock);
> > +
> > +	atomic_set(&priv->waiting_rsp_clbk_hdl.pending_hdr, 0);
> > +	init_waitqueue_head(&priv->waiting_rsp_clbk_hdl.wq);
> > +	atomic_set(&priv->cmd_receiver_clbk_hdl.pending_hdr, 0);
> > +	init_waitqueue_head(&priv->cmd_receiver_clbk_hdl.wq);
> > +
> > +	priv->cmd_tag =3D info->cmd_tag;
> > +	priv->rsp_tag =3D info->rsp_tag;
> > +	if (info->pool_name) {
> > +		priv->mem_pool =3D of_gen_pool_get(dev->of_node,
> > +						 info->pool_name, 0);
> > +		if (!priv->mem_pool) {
> > +			dev_err(dev,
> > +				"Unable to get sram pool =3D %s\n",
> > +				info->pool_name);
> > +			return 0;
> > +		}
>=20
> why return 0 here? suppose should be goto exit?

Accepted. Will correct in V8.
>=20
>=20
> > +	}
> > +	priv->success_tag =3D info->success_tag;
> > +	priv->base_api_ver =3D info->base_api_ver;
> > +	priv->fw_api_ver =3D info->fw_api_ver;
> > +	spin_lock_init(&priv->lock);
> > +
> > +	if (info->reserved_dma_ranges) {
> > +		ret =3D of_reserved_mem_device_init(dev);
> > +		if (ret) {
> > +			dev_err(dev,
> > +				"failed to init reserved memory region %d\n",
> > +				ret);
> > +			goto exit;
> > +		}
> > +	}
> > +
> > +	ret =3D se_soc_info(priv, info_list);
> > +	if (ret) {
> > +		dev_err(dev,
> > +			"failed[%pe] to fetch SoC Info\n", ERR_PTR(ret));
> > +		goto exit;
> > +	}
> > +
> > +	priv->se_img_file_to_load =3D info->seco_fw_nm_in_rfs;
> > +	if (info->prim_fw_nm_in_rfs) {
> > +		/* allocate buffer where SE store encrypted IMEM */
> > +		priv->imem.buf =3D dmam_alloc_coherent(dev,
> ELE_IMEM_SIZE,
> > +						     &priv->imem.phyaddr,
> > +						     GFP_KERNEL);
> > +		if (!priv->imem.buf) {
> > +			dev_err(dev,
> > +				"dmam-alloc-failed: To store encr-IMEM.\n");
> > +			ret =3D -ENOMEM;
> > +			goto exit;
> > +		}
> > +		if (priv->imem.state =3D=3D ELE_IMEM_STATE_BAD)
> > +			priv->se_img_file_to_load =3D info-
> >prim_fw_nm_in_rfs;
> > +	}
> > +
> > +	if (priv->se_img_file_to_load) {
> > +		ret =3D request_firmware_nowait(THIS_MODULE,
> > +					      FW_ACTION_UEVENT,
> > +					      priv->se_img_file_to_load,
> > +					      dev, GFP_KERNEL, priv,
> > +					      se_load_firmware);
> > +		if (ret)
> > +			dev_warn(dev, "Failed to get firmware [%s].\n",
> > +				 priv->se_img_file_to_load);
> > +		ret =3D 0;
> > +	}
> > +
> > +	dev_info(dev, "i.MX secure-enclave: %s interface to firmware,
> configured.\n",
> > +		 info->se_name);
> > +	return ret;
> > +
> > +exit:
> > +	/* if execution control reaches here, if probe fails.
> > +	 * hence doing the cleanup
> > +	 */
> > +	se_if_probe_cleanup(pdev);
>=20
>=20
> Suggest use devm_add_action(, se_if_probe_cleanup, ); so all "goto exit"
> can change to
>=20
>  	return dev_err_probe(...);
>=20
> Frank
>=20
Accepted. Will correct in V8.

> > +
> > +	return ret;
> > +}
> > +
> > +static int se_if_remove(struct platform_device *pdev) {
> > +	se_if_probe_cleanup(pdev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int se_suspend(struct device *dev) {
> > +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +	const struct se_if_node_info *info =3D priv->info;
> > +	int ret =3D 0;
> > +
> > +	if (info && info->prim_fw_nm_in_rfs) {
> > +		ret =3D se_save_imem_state(priv);
> > +		if (ret < 0)
> > +			goto exit;
> > +		priv->imem.size =3D ret;
> > +	}
> > +exit:
> > +	return ret;
> > +}
> > +
> > +static int se_resume(struct device *dev) {
> > +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +	const struct se_if_node_info *info =3D priv->info;
> > +
> > +	wake_up_interruptible(&priv->waiting_rsp_clbk_hdl.wq);
> > +	wake_up_interruptible(&priv->cmd_receiver_clbk_hdl.wq);
> > +
> > +	if (info && info->prim_fw_nm_in_rfs)
> > +		se_restore_imem_state(priv);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops se_pm =3D {
> > +	RUNTIME_PM_OPS(se_suspend, se_resume, NULL) };
> > +
> > +static struct platform_driver se_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "fsl-se-fw",
> > +		.of_match_table =3D se_match,
> > +		.pm =3D &se_pm,
> > +	},
> > +	.probe =3D se_if_probe,
> > +	.remove =3D se_if_remove,
> > +};
> > +MODULE_DEVICE_TABLE(of, se_match);
> > +
> > +module_platform_driver(se_driver);
> > +
> > +MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
> > +MODULE_DESCRIPTION("iMX Secure Enclave Driver.");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/firmware/imx/se_ctrl.h
> > b/drivers/firmware/imx/se_ctrl.h new file mode 100644 index
> > 000000000000..95050d3c7c88
> > --- /dev/null
> > +++ b/drivers/firmware/imx/se_ctrl.h
> > @@ -0,0 +1,99 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#ifndef SE_MU_H
> > +#define SE_MU_H
> > +
> > +#include <linux/miscdevice.h>
> > +#include <linux/semaphore.h>
> > +#include <linux/mailbox_client.h>
> > +
> > +#define MAX_FW_LOAD_RETRIES		50
> > +
> > +#define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
> > +#define MAX_NVM_MSG_LEN			(256)
> > +#define MESSAGING_VERSION_6		0x6
> > +#define MESSAGING_VERSION_7		0x7
> > +#define NODE_NAME			"secure-enclave"
> > +
> > +#define GET_ASCII_TO_U8(diff, tens_chr, ones_chr) \
> > +		((diff > 2) ? (((tens_chr - '0') * 10) + (ones_chr - '0')) :\
> > +		(tens_chr - '0'))
> > +
> > +#define GET_IDX_FROM_DEV_NODE_NAME(dev_of_node) \
> > +		((strlen(dev_of_node->full_name) > strlen(NODE_NAME)) ?\
> > +		GET_ASCII_TO_U8((strlen(dev_of_node->full_name) -
> strlen(NODE_NAME)),\
> > +				dev_of_node-
> >full_name[strlen(NODE_NAME) + 1], \
> > +				dev_of_node-
> >full_name[strlen(NODE_NAME) + 2]) : 0)
> > +
> > +struct se_clbk_handle {
> > +	wait_queue_head_t wq;
> > +	atomic_t pending_hdr;
> > +	u32 rx_msg_sz;
> > +	/* Assignment of the rx_msg buffer to held till the
> > +	 * received content as part callback function, is copied.
> > +	 */
> > +	struct se_api_msg *rx_msg;
> > +};
> > +
> > +struct se_imem_buf {
> > +	u8 *buf;
> > +	phys_addr_t phyaddr;
> > +	u32 size;
> > +	u32 state;
> > +};
> > +
> > +/* Header of the messages exchange with the EdgeLock Enclave */
> > +struct se_msg_hdr {
> > +	u8 ver;
> > +	u8 size;
> > +	u8 command;
> > +	u8 tag;
> > +}  __packed;
> > +
> > +#define SE_MU_HDR_SZ	4
> > +
> > +struct se_api_msg {
> > +	struct se_msg_hdr header;
> > +	u32 data[];
> > +};
> > +
> > +struct se_if_priv {
> > +	struct se_clbk_handle cmd_receiver_clbk_hdl;
> > +	/* Update to the waiting_rsp_dev, to be protected
> > +	 * under se_if_lock.
> > +	 */
> > +	struct se_clbk_handle waiting_rsp_clbk_hdl;
> > +	/*
> > +	 * prevent parallel access to the se interface registers
> > +	 * e.g. a user trying to send a command while the other one is
> > +	 * sending a response.
> > +	 */
> > +	struct mutex se_if_lock;
> > +	/*
> > +	 * prevent a command to be sent on the se interface while another
> one is
> > +	 * still processing. (response to a command is allowed)
> > +	 */
> > +	struct mutex se_if_cmd_lock;
> > +	struct device *dev;
> > +	struct gen_pool *mem_pool;
> > +	u8 cmd_tag;
> > +	u8 rsp_tag;
> > +	u8 success_tag;
> > +	u8 base_api_ver;
> > +	u8 fw_api_ver;
> > +	u32 fw_fail;
> > +	u16 soc_rev;
> > +	const void *info;
> > +
> > +	struct mbox_client se_mb_cl;
> > +	struct mbox_chan *tx_chan, *rx_chan;
> > +
> > +	spinlock_t lock;
> > +	struct se_imem_buf imem;
> > +	u8 *se_img_file_to_load;
> > +};
> > +
> > +#endif
> > diff --git a/include/linux/firmware/imx/se_api.h
> > b/include/linux/firmware/imx/se_api.h
> > new file mode 100644
> > index 000000000000..c47f84906837
> > --- /dev/null
> > +++ b/include/linux/firmware/imx/se_api.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#ifndef __SE_API_H__
> > +#define __SE_API_H__
> > +
> > +#include <linux/types.h>
> > +
> > +#define SOC_ID_OF_IMX8ULP		0x084D
> > +#define SOC_ID_OF_IMX93			0x9300
> > +
> > +#endif /* __SE_API_H__ */
> >
> > --
> > 2.34.1
> >

