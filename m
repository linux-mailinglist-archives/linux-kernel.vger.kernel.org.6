Return-Path: <linux-kernel+bounces-243856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FB7929BCC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 444F4B20B12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 05:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263D51171D;
	Mon,  8 Jul 2024 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p2luHbaO"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643B156E4;
	Mon,  8 Jul 2024 05:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720417827; cv=fail; b=Ine2MN0GzKep1thIC6ZfDqQOc44Gdqy01JWPVtJ4wSSISG3gZHXvEHNyjeNwLS7iaTo0Wb2OQL3voWF+qqLrs2K7QrFvIRe65h/ghSTE/FXelIyLUB60J4voQURLIsyHgr9KWoODSeuz12VVFjZ9h3nTKEW7DcSYP6c9ClvD1aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720417827; c=relaxed/simple;
	bh=LeqOBuwaV+bXxzF8ycZDVgpv1zjyY5bnzgNF8JF5DIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lINuCQOKfd0s5SCo00aFvXwxdi3pRzcDiB9Hv/a/1YDgF19KOWHRtXIW9sAu48DFvX3p/x3DHp64jIVorg+PDngHccF0pxl5LTy9Emn31uppebJMbnm733dXeaLFLQ0LbXqbdJjj+fcxvqJnSFFUIR4KdHsfUCM8betHyfUFxvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=p2luHbaO; arc=fail smtp.client-ip=40.107.105.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klsSiNOYldBGyBoTPyBMSE4GXBkajfK7XCLhiHYtiJy5VnId3D6DBsPOb5SSSiTUnacWaa0WCn8HEkhCx+K/qPSBhyO2azGU4Prc6dHQBY0tHVMABHLgkx1j0NBOmi91KL4QJK+hLi0CvGjsjjx2gIY7tzC4ggnb9DnO7s6kjWwxW5kEsDGD07vOecSz9uB1ff5NzrQgprPlCOp+HVCx+OzH5x8SCIP8h5atlpM9jDAuMK2SIujqhp3EePWHeiuyStDWYExPDbtwVAzAStzPYXzXsyaZJ3q0H/X5t3WTnqo8MAv10FVmXx+ZVaU2Ml1BClJq8jxmAlbeV6SvhdT40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7sm1YqeEh1t0zg7V7VCqI4p9Qzx7y4PVbrOdGYx5Qc=;
 b=dySjKrEJUIOwX/o0tiWshPAOxcCmnHitymqkz4hNb3YgS2sx+hqkPDmJ/5/Z4SFksYDYrYspMcNcdS41E5bIIkP+XayNo7FaQt5Aoi7RVUOvZhsjfq1N2HSd4bVB10oEFRCIuoYSeLwwzCQfUbUpkti9h3GXZSJSKQcrGKjl+iPXooFr2qTHXJuhtMMh7dSoeD81I+h6NlmerH8259LSAXDWOo6rod8x5HFH69OAD3rcDgvMbcBwBmVQJuRsnW4L7ya+0iy1JO+rx/rcQbgRTN9s7cA3mAIey6nnSVqdV/W/WR/hU08h2b7XNKDpUXI8YwIQYEg24tJ/0pc5nVoC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7sm1YqeEh1t0zg7V7VCqI4p9Qzx7y4PVbrOdGYx5Qc=;
 b=p2luHbaOOCvQnpC8IsbuPCvgRofxq8tN1SgwwY2PhbB6SiMrCFl5zVFfUVvtsH1nQVXMYMTvFK2yVbT9lC5Csmlb+RpnShxpvZFyq9szgTAmPjWhx49nPSvRLbhsvhjnCMwT2xvw73QnrKlnuLY03Beuw1pEfI8Q43HQCa5FFy4=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PAXPR04MB9008.eurprd04.prod.outlook.com (2603:10a6:102:20d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 05:50:21 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 05:50:21 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v4 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v4 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHazuMSrg3adK0l6E2Y9DEwTEglUrHrNmCAgAETJjA=
Date: Mon, 8 Jul 2024 05:50:21 +0000
Message-ID:
 <AM9PR04MB8604B9A9F3D22C35679AD1D195DA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
 <20240705-imx-se-if-v4-2-52d000e18a1d@nxp.com>
 <450d1575-c9b3-413b-bfa9-8dc4352fa263@kernel.org>
In-Reply-To: <450d1575-c9b3-413b-bfa9-8dc4352fa263@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|PAXPR04MB9008:EE_
x-ms-office365-filtering-correlation-id: 9ddc2123-b273-4a6f-4010-08dc9f11dabf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?10jXETw22UCVUDDDuyuJfB3y95aYIHZ4RDWQe1Z4LvxhFVZtQTg/TXk1M2Qx?=
 =?us-ascii?Q?GE7EaNlCmtgeu4ABeEdUsn9QnHDpO6G++rjytYJFXwwRrhihQCeMYGawI4EB?=
 =?us-ascii?Q?MDlMlmdV+CmvUKvx0kv8c/uwOOomKlB26bW+8TXVuX+XopbS/xPdr7eriQL3?=
 =?us-ascii?Q?xgCZBbB5KbY6xa6TU9PGF6uctMvWhQ8jCcUU1+e6ECytNbgODGCwotElzxnK?=
 =?us-ascii?Q?/WlTZd6VXB6ZOveUETGi6CrXWk4TZGjO9MmrZEPLMnJCPgbMqpyd6J/ZFmzj?=
 =?us-ascii?Q?Zfi9sjXKBeLFfqOvO5ownH1RtjIzvb3ih21+QL17IiOt8xybK2q721OgKyGy?=
 =?us-ascii?Q?IuepPERkV0XsTTIi/4mv70uIPQaxTCs57DIdJrJhktjkRrhCAzm8GR54BTc1?=
 =?us-ascii?Q?rGX0gaum/gONbohJfRAd/VR+aA0VSpbCcfQKR/AcG2oVZPkWsBzchHzJMP8Q?=
 =?us-ascii?Q?WLMRHjtftP0BwNkueAp/VlZTBArVnVVrbsq5JfmaFzGQZvS23GizHGwAXm42?=
 =?us-ascii?Q?0aC+jXjODbocnjYqY1/inGNJuMO8U5lPh37tgQepObSjv3F+CJmqrQVxnU0z?=
 =?us-ascii?Q?6zvzEgniMs1J/V60We/IOYCMleR8dvvOEIKI0SLRRsex04WrTDtlA5pQB5i9?=
 =?us-ascii?Q?YH1SJwADYyoAyjwmgnWRLCEJ0r78dSTSjljugnBUoFx3wyr6wFysh++o9/WT?=
 =?us-ascii?Q?I33QhqguOkQtdX+X+kATKZJwPZLQNyk1+HqoW9A6hfU+WUpepehLGIrLs1aU?=
 =?us-ascii?Q?/WjoYcmKaijcPAbrOedAbasLs5919dzDyXejoCx93+1o+p3A17QcC+MqzRak?=
 =?us-ascii?Q?B5CoOqPJ60BfJ1Do3318APIObCMa015DwvptEx+Nd41s0OOESqrZHVAMm84v?=
 =?us-ascii?Q?VGHXYJfTcm7PJ1sT8adg+2XlaWx/AHX5JTSFhYl1pntaWkx/FJkB7tKy3rxT?=
 =?us-ascii?Q?mjwxuDEQ8z0FNWkac/SOjyWz9TFAcRGdjcTgmjo0h2kPBCNd9aCH5oKQriRk?=
 =?us-ascii?Q?AqYPCnITzldy5nsuBo9mgaW7k5ejUHcxrt1B4y7oep9SYVf7RuFBpBSck1Xi?=
 =?us-ascii?Q?WtNnc89diSwCX9S2vgycYsFyMZCfPMod/wVOlBJWcOWxMPKV4oNGD9RIt5Vp?=
 =?us-ascii?Q?qAmXOoUfDqU2zExEuYyo0fPvLqwBLPZFs+I//dJyfafT5lMxKwA1bmULwrkt?=
 =?us-ascii?Q?ScAMbySUPlPFLRa86eaLQTlRUPRI6GZ5/ij7kON3lmqwILKG2MHSytmQMR20?=
 =?us-ascii?Q?r6OcnHiBuimDlBFRLUfstTbIPDERurW36nCndnUOIAjBausAFq0w8IEH24pq?=
 =?us-ascii?Q?IgDBKDCvbao/jsSEqBxckGFcYGgNCbEZHmz16iT9wqY0Rhv7vjsIQGctFQdy?=
 =?us-ascii?Q?/3iQ6K6qXiMmvB7EjNUFeN3m0WLnReGZpkxraReIjlIqEd50yC3yiZJl2Zfk?=
 =?us-ascii?Q?QoYAvP0XyFs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z0fRGsJfwz1Ab2EQGdQW+pPsCmEV17+jwvOsxzmHL3HPq4rMJz8e4G5Drota?=
 =?us-ascii?Q?v6BxzZy+kGxZD/+tYqmxJOyDFPg3Vgh2koxYMAXXCSh4+ah/jWkl3kkWSMjx?=
 =?us-ascii?Q?+BDTQkq9nU263oIFWrVVO8BWKGmVz0xX60tvBlmsqhl4H7K5YqLRVcWECepu?=
 =?us-ascii?Q?W/oQwihhGVbnZFtoD7V4fuZM6fHEV84dzhh6g0KFEQZmfvRiKWZgyZfiKClv?=
 =?us-ascii?Q?n1cBjrYjAlDqSU7cvcXMmqV2qQBUyCaZ+B9edl2arZ7JFjYNmhSYCe/ZntTC?=
 =?us-ascii?Q?JpJxYvOwFPYPAer0MS94uW1IjEV3WKKKPD+80oEaaOpg59kED19hUVTvCYk1?=
 =?us-ascii?Q?eRZAArN8WtiXWtYYhfij+K0tIHQN7OyKXXjQH59ZvoRXg/1xv5m9GknmUaye?=
 =?us-ascii?Q?lATD/WRpm2Pgm5ypLUwttimcFT+sNqcVN8Uxd4CkT5Z6ERwRBGBZg9A6RiDS?=
 =?us-ascii?Q?eZmzon98xOurH8nY0f2n2Wv14yjDe2F2yf/OUJs2fq3K7IJn256ZPXvGJ2mO?=
 =?us-ascii?Q?PEi3uaPt9fl1Ptsu4DTroa7p8EsnM1Cibghl5iWnwmy524z2OIEX3bm8Iek9?=
 =?us-ascii?Q?NFJqvrvyWyWSudKNX1WHSPBTzcoXBKBS2Q0PS2WhxxOXbPfOgtABI3c1ufFg?=
 =?us-ascii?Q?ys9co+TUf9XJWhvZglmSJHwRiGYGLuSU2N/biSAMPqDcFUXzMrcI8U2BHp+t?=
 =?us-ascii?Q?IclvlEw2fhAZxoAmjMpCayJtz7gx4hHEBV92OIvvBHx7LU5brK8yABcwaups?=
 =?us-ascii?Q?3yuXK8L838xBm+jXpTc5NYTaIyaex9gfkzpU0c8VwjXh1EKcWP/mYg982phG?=
 =?us-ascii?Q?Gr++NTM/muUuJ8YgJDYZ/cZJtCdcGP0bUZeQhw66C/bDWmmpvGaBXqDy+TOZ?=
 =?us-ascii?Q?dEamSx3Y51Ro55NaUAzQtfqkIpKq85TITiWuvwm2U5BdazowT+egExSqMJ/m?=
 =?us-ascii?Q?MfcmpTT0AbgE+x3VGAgnxu3eFAJjKJ7cXRHNuhikwVAAveMFC8wy2oXsACvs?=
 =?us-ascii?Q?/Mmnu4PcOTeoLbfTyF3swHVdFmWHioSqWRj84BEI5i/IBpPAGUgF5ZylXyUH?=
 =?us-ascii?Q?z3J409ONRh1GgpBq27Cwe44VsxCuNtLnjU5QKMkhiIw9pxu/sDxgiopI07p/?=
 =?us-ascii?Q?Cyn0kyOXPDLX8mDNySwvpFRmKCTx9p0WB803Phf1qjgLwVmCCuE7vtPExDxk?=
 =?us-ascii?Q?tLpXUmy/eqOwYKkUhN9iJGx4FP8V7dN63WY7VWLHf3RK7gMP4my5jBzEpDG1?=
 =?us-ascii?Q?2tUJrP3QlPzlc3drxJmhseXRgljU7X54mtZD3sI2a8IVmdjU1VOGiBTGxtu8?=
 =?us-ascii?Q?WfdSUPFoghplaaapRypfkksVGDxW4+KNd/GNl2mCBSpnaY5z+zsxbJ+lBX/U?=
 =?us-ascii?Q?4QjypklKCuAKrbSTiEtAu1iTmqVgCzDBU18AgR8NsrI6hC28Z7tG1cvI4Ih1?=
 =?us-ascii?Q?jX2+KrX2OMgJ1BhzB8YZZqjT0+1oUmE6qyh644vlPzCAxq5w8dy079VT9Wmx?=
 =?us-ascii?Q?1KcyvNJ/oO+BpcwhFpA6zedAFeEoODbk8EvA4EKi1FONm8Olxsmzaa3VfDHb?=
 =?us-ascii?Q?MlK8P7VoVRgymcsZvSXEWKKM2zimR3Z9gsg2QQkZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddc2123-b273-4a6f-4010-08dc9f11dabf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 05:50:21.2507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q1UgGJgNsYgApiB8/hMJMFVcXXFF47Vu1N2kQMPrkpZB8bRfy6UOmkJHE7GscfpSfZTLA0uSnktbP5GxluM6Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9008



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Sunday, July 7, 2024 6:05 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>; Jonathan Corbet
> <corbet@lwn.net>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v4 2/5] dt-bindings: arm: fsl: add imx-se-fw bi=
nding
> doc
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 05/07/2024 15:52, Pankaj Gupta wrote:
> > The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
> > creates an embedded secure enclave within the SoC boundary to enable
> > features like:
> > - HSM
> > - SHE
> > - V2X
> >
> > Secure-Enclave(s) communication interface are typically via message
> > unit, i.e., based on mailbox linux kernel driver. This driver enables
> > communication ensuring well defined message sequence protocol between
> > Application Core and enclave's firmware.
> >
> > Driver configures multiple misc-device on the MU, for multiple
> > user-space applications, to be able to communicate over single MU.
> >
> > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
>=20
> This binding is not improving, even though it is v5.

I have disposed-off all the comments received by Conor and Rob.
Expecting there Reviewed-By on the v4, if they had no more comments.

I will ensure to address your comments on this mail chain, in the best way =
I could.

>=20
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 133
> +++++++++++++++++++++
> >  1 file changed, 133 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > new file mode 100644
> > index 000000000000..b9018645101d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > @@ -0,0 +1,133 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fschemas%2Ffirmware%2Ffsl%2Cimx-
> se.yaml%23&data=3D05%7C02%7
> >
> +Cpankaj.gupta%40nxp.com%7Cb43d043a91934c0c094c08dc9e813c2f%7C
> 686ea1d3
> >
> +bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638559525096552364%7CUn
> known%7CTWF
> >
> +pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ
> XVCI6
> >
> +Mn0%3D%7C0%7C%7C%7C&sdata=3DzmZkwos2LRrAdtPBr0pCJxCrztncKCQS2
> 4ECYMIjSnw
> > +%3D&reserved=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpankaj.gupta%
> >
> +40nxp.com%7Cb43d043a91934c0c094c08dc9e813c2f%7C686ea1d3bc2b4
> c6fa92cd9
> >
> +9c5c301635%7C0%7C0%7C638559525096560485%7CUnknown%7CTWF
> pbGZsb3d8eyJWI
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C0%7C%
> >
> +7C%7C&sdata=3DWNl9M3G%2BPIl4xPx4w74Tsv7OIBkTRiR0Er5uj7PAt5o%3D
> &reserved
> > +=3D0
> > +
> > +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> > +
> > +maintainers:
> > +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> > +
> > +description: |
> > +  NXP's SoC may contain one or multiple embedded secure-enclave HW
> > +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> > +  enables features like
> > +    - Hardware Security Module (HSM),
> > +    - Security Hardware Extension (SHE), and
> > +    - Vehicular to Anything (V2X)
> > +
> > +  Communication interface to the secure-enclaves is based on the
> > + messaging unit(s).
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "firmware@[0-9a-f]+$"
> > +
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8ulp-se
> > +      - fsl,imx93-se
> > +      - fsl,imx95-se
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: Identifier of the communication interface to secure-e=
nclave.
> > +
> > +  mboxes:
> > +    description: contain a list of phandles to mailboxes.
>=20
> Drop, obvious.
Will remove the line "- description: contain a list of phandles to mailboxe=
s."

>=20
> > +    items:
> > +      - description: Specify the mailbox used to send message to se fi=
rmware
> > +      - description: Specify the mailbox used to receive message from
> > + se firmware
>=20
> Drop redundant/obvious parts.
Will replace above two description line with the below two.
      - description: mailbox phandle to send message to se firmware
      - description: mailbox phandle to receive message from se firmware

>=20
> So two mailboxes?
Two handles of the same mailbox.

>=20
> > +
> > +  mbox-names:
> > +    items:
> > +      - const: tx
> > +      - const: rx
> > +      - const: txdb
> > +      - const: rxdb
>=20
> 4 mailboxes? This cannot be different.
mbox-names can have any of the above mentioned 4 values.
And  two values are minimum, required.

>=20
> > +    minItems: 2
> > +
> > +  memory-region:
> > +    description: contains the phandle to reserved external memory.
>=20
> Drop
Will remove the line " description: contains the phandle to reserved extern=
al memory."

>=20
> > +    items:
> > +      - description: It is used by secure-enclave firmware. It is an o=
ptional
> > +          property based on compatible and identifier to communication
> interface.
> > +          (see bindings/reserved-memory/reserved-memory.txt)
> > +
> > +  sram:
> > +    description: contains the phandle to sram.
>=20
> Drop
Will remove " description: contains the phandle to sram."

>=20
> > +    items:
> > +      - description: Phandle to the device SRAM. It is an optional pro=
perty
> > +          based on compatible and identifier to communication interfac=
e.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - mboxes
> > +  - mbox-names
> > +
> > +additionalProperties: false
>=20
> Keep it after allOf block

In V2, it is after allOf block.
In previous comments, it was commented to place allOf block, after required=
.
I am little confused.

>=20
>=20
> > +
> > +allOf:
> > +  # memory-region
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8ulp-se
> > +              - fsl,imx93-se
> > +    then:
> > +      required:
> > +        - memory-region
> > +    else:
> > +      properties:
> > +        memory-region: false
> > +
> > +  # sram
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8ulp-se
> > +    then:
> > +      required:
> > +        - sram
> > +
> > +    else:
> > +      properties:
> > +        sram: false
> > +
> > +examples:
> > +  - |
> > +    firmware {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      firmware@0 {
> > +        compatible =3D "fsl,imx95-se";
> > +        reg =3D <0x0>;
> > +        mboxes =3D <&ele_mu0 0 0>, <&ele_mu0 1 0>;
> > +        mbox-names =3D "tx", "rx";
> > +      };
>=20
> One example is enough.
Accepted.

>=20
>=20
> Best regards,
> Krzysztof


