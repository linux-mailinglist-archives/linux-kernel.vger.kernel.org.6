Return-Path: <linux-kernel+bounces-257192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4431937676
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0681C20C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E52D82C8E;
	Fri, 19 Jul 2024 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EiL/u94o"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A441C85;
	Fri, 19 Jul 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383699; cv=fail; b=DZggaAJZITPqRxo405+dY7QXi7rof+yKSExV4ZjgkqhpFVKwBrkQjRC6vq5nkfvKBxdeY0wb5QNS1Fy/ZVm7/B6I/FBVGVIUrqWiI/CJjHURqMVHByw84/WtSSVZ5VYEA66mUxoqLOxgMeISfoUqjXDim0PJLhsKNnjduCJFp8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383699; c=relaxed/simple;
	bh=tbpwndwnr9SQeUREXx8obvFOnR1yusx0tcoMYJ9fIsc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TF75q7nIVqflxHjF5Hwp/VY4dhUiOgmFx1hD+VcGrcCQmVq3eT6vG3EH+sqiedbtDoAyFCvXrpg/79mKUwjB8zPRLKQqPMVqW4VarAdlflcfI3MwXk/t/S684lHWiY0x08XkKHClBBZbS+qNMFs97dfOpZlefk8QKTl33jbe0co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EiL/u94o; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dy8EsYwJah0HJIczFA2f7NPSflMhED45v1FVN6qCmoZK2JrV1uzhrDdsBM1kL/zRrRe1jtas1jkyEWC91otxWc32/ujoiP/fxMY1xddad97r3q4jGonNs+ZlH7NvJ+WTrbg2TjMJ0GvMiKdsIyq/z7T/Rn3cDbPQEAA/c9+jITbuUpFw3RtWYTEMaAO6uvgkDlV6oz3xOvsf1b9yEwV/fndyzpjvDa/vwOs+jYibMb8zKrT2Vz6tCl4EEhv9MFCk68aeLbTy+lKwbdp8Z3kHAkK6yKUd6CRk5oRGEgqtGoNEXUIWpS/iYhqjYZY9/FHan3SUDavZQVSFZSOIkOTuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9CKsrge4e4sTzyBng9brfxcccHDiARAUmrN28H40PQ=;
 b=UTwvqALrI7IGoBtNELdT8UfPN7ha0N2DUU6pv0qq1+70SBH3XBUF7nDPHnI7O9Xbxn0ZbC8zfCkH36eDOLp8qJxmeLyFSTdMyovbvxM4msL1iATzAffF7bMeoCOBMGq70Qd99X/xFsaXHwK8uMse/lUzqKH2gciN19UaDs4DxqOwb/8hirkO3u/mApgwECnLB8AsGaPL/Y+7+8LYaQgBy+5ssq3srazZJsSjbx4z7bfH//fMeGEqsGSq4x/Bd75W0Q7yrA2u2Uch8GfaKxKkh1Ij2NyKwvaM3PvZKW9ot8RZYFrt6515MJ1VFgqaIRK8/0OEBP5kVfz9fuInzMuZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9CKsrge4e4sTzyBng9brfxcccHDiARAUmrN28H40PQ=;
 b=EiL/u94oG7/0Ye9zbPaKNQWVIjJejqF8dGRkYniWBhqry8jhDP4vHQe703xB+B91N7RGsbUotTHyA5d7Z7c2W0Vg8gY6YJzGq5KkVM9QTsNaigvTfdzDpDX8h+rM5asVREH6u38SybFbgYU9Wb+6NgNA7XyxkRNXvSEhRombldU=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 19 Jul
 2024 10:08:13 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 10:08:13 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v5 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v5 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHa1CP/sfbwKvfpdE6YN2bMfeC3aLHzY3MAgAPbVACABLir0IAB4UkQ
Date: Fri, 19 Jul 2024 10:08:13 +0000
Message-ID:
 <AM9PR04MB8604317B3F4EABEDA1299D1595AD2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
 <20240712-imx-se-if-v5-2-66a79903a872@nxp.com>
 <20240712180358.GA1286437-robh@kernel.org>
 <AM9PR04MB8604BA0B01612B38D9282CF795A12@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <AM9PR04MB8604A204F35B79DC299D6C5D95AC2@AM9PR04MB8604.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM9PR04MB8604A204F35B79DC299D6C5D95AC2@AM9PR04MB8604.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AS8PR04MB9142:EE_
x-ms-office365-filtering-correlation-id: 50b3e55c-aced-42ba-0135-08dca7dab378
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zuiZL/QphGaFE5X4P4sndbQfutxy2GsVz/qNRgeQuYLfVxIzikIZ1qVuO1Ac?=
 =?us-ascii?Q?VaRv/24UQ3KDJe8E0vuVEyaZQJ4pVkyMSwaIRcFsKoMLu5TFy2OcjjoUWUKJ?=
 =?us-ascii?Q?TRxXUmwEbTshmMHWdtIX0IpD3hEVMmzrVc/+OYLkepzDxImILycqtaCFJ4jX?=
 =?us-ascii?Q?N39ayW9RepaH16FclzLm4o6R2Tbg4pefIi3OXBZmUkF1orCXLw2XSY1h0zsc?=
 =?us-ascii?Q?oPa5BcB/TCzAYLxriVKVDtJ3pbtOsB6FvvWsIHVlG7eR+LrfOZmtq/k0vonF?=
 =?us-ascii?Q?9xzLsM6K+WX5n8oAX+DLrLCKMZ357jmiUpQOjsA1fNvG++IweG/kCeCnPhUh?=
 =?us-ascii?Q?i8F64sO0F8UqDFl71SZ0BidWlK4a+yeuMLMCUmT04AB66O/2DDCxB0oeFnT/?=
 =?us-ascii?Q?3svKJP1gY5RNjg/vvB9LkzsC55k3yp5jG+hRFr+GFiu/ggfrg83aH8l69PWb?=
 =?us-ascii?Q?AYqT9qtZO0n8+LQ6wY/OxOWktK51B33fGeiTOQOWYahDPlNuejwjoi7PjNuc?=
 =?us-ascii?Q?ERiBg3aV+xxbxkGL7HuY6kENckLwRvRIzDo0La2hw8ggEywkZY13d2R0Pg0E?=
 =?us-ascii?Q?RGsjgwWBvwSHSrIKgn+XeCbHYjrZopENZFE0p4yc30p6HvYAF9NAMiX4XzMP?=
 =?us-ascii?Q?JpuBe44M8esX6jmyLgP2lsV2AIjhzp+F2l2ph63ZApblyakT5Zb/uDoq41v4?=
 =?us-ascii?Q?/nnBFck6hKQaJ1O99Poi8Dofap3h9FhCMLVVxrGK6Xou4l3RT6gSMjOr9XkF?=
 =?us-ascii?Q?zZw3U+ZsAwo3F0MKf39jE09IMmVwNCkA1ckRFR3IVMZgoOOGQIrMHxh50OqX?=
 =?us-ascii?Q?Tw6e2Olc5rTCoNhZzrTg+YkiE0MNpTX8MW6ztmIY6j1Zr8UEr/MGdqnS5csW?=
 =?us-ascii?Q?RxFQPyTdoRBkgQpemI9BuCHJHDl8AXqlhN4Uqp0fJnAWMBb2GCOV/GMgTvzp?=
 =?us-ascii?Q?HQPhaEg7mm7qdkdX3FuQaYrxuTW5M6To/cZh5J4j1KxVxi1P7LKSMOhJYqfv?=
 =?us-ascii?Q?RyHo3XFMuvfIho20IG5PKrCBjjaFVHChSQjzuWusF503vA8j7WSKLNj95Hwi?=
 =?us-ascii?Q?ejpz7X5/S/+ZLOG/pT/G9OavAdwnNPLMm1iytYHcqZcrNYYhnHkbWvCNiqWp?=
 =?us-ascii?Q?NUc7wCKT4Z57KhAan5eKnyXxhSDD3cQ2UBgmWAg+wNfGrmH5yyThTgahfOQU?=
 =?us-ascii?Q?+NkwQQD1mqa4TnXfAvszNVM42+clXJrVdccSkQIYU3yy2Mu0lryiEyLKAQNC?=
 =?us-ascii?Q?WLaj2mx7l7Vj+D3hXZVem7SJLB5duSmkqorIAVoRHZHBxwmex17zjcr7C/hU?=
 =?us-ascii?Q?Tw/R48km6W9EKm5cIF4ivpgH8Ev2HjtDKQuCL45yug5+B4s+/uhDf87fE5iO?=
 =?us-ascii?Q?pTuOaQfVmGk/WRiOtYWQDYF/uiBhXr8ejnbU9pSC+JsA3MyP5A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f5886hHaK8EktL7wMbw8LyEdN/SRJVJReZ/NFip4Ww53qCMEXNqoGVdqxunJ?=
 =?us-ascii?Q?jK3RZ+ecOTh+zdeusTzLfKyzK/qGoTGSsVjjn8K1so2INF+qrtmMrLU4l21o?=
 =?us-ascii?Q?VPDuZEawxa5BvUQNSbD97vJTcabsT+2zHecvkWOqEGxw2w94YF0BhfzjlFWS?=
 =?us-ascii?Q?gFLLxKpygqoC0JLIJsr/c/rcSnjNLKcRf+q85PGMQcLV0jBOF3ejaJCOwBY1?=
 =?us-ascii?Q?4S2sknfNcefPbI+KQnc598jbGhHdJvYqwI9deno4A/EmSwA+nOPDrAB5yVRN?=
 =?us-ascii?Q?jbjz2GeuyAN/OY20LGnH63+z8M3oBi5UIuBFhCdhHpy0dCSh+GScd2u6troD?=
 =?us-ascii?Q?+K82p6EqRdMCEM0FlrDVOy+cyPSBknguYycsUT6xvnFG6TyOLfgaaZvFN8r8?=
 =?us-ascii?Q?lRLmArKomyhxeOagc5EOt8eaguJz7drF8BnwV5790UDEOJugcakBesBhNq+2?=
 =?us-ascii?Q?ra9dClFoI7Qta03YVnsv7TdQB16f35ADyfc2aAHmnMScueRVu72tFFOrS1c7?=
 =?us-ascii?Q?t16c4eAQ2RcK0MfXopFOIxeUxijKFw2rIVy3iihc9GIbXRqLNhSGJLOemY5g?=
 =?us-ascii?Q?gYkN9Q50miPGaBnfZrqOqBAw4dsWZbbL+88r72D6T1yknzhL0Co0WYlAuyFf?=
 =?us-ascii?Q?xfKsotq3Ndzm/m9528Q+/CBZRE9fVtpRz0tsV0qTYMiqbI/08uYIlieJtBHc?=
 =?us-ascii?Q?rv+/vEX9E6LwmvemGOXWshH1MQQkt82rsRh1mSFJEsAfyZ6kTHPwvskFVghm?=
 =?us-ascii?Q?Y/3F2uOdFc45FxYHAndARk9YwXY2t+aflS6iG6GxeSTy0hfk43uFzgT1S1ux?=
 =?us-ascii?Q?SpBv7RJj1GnAcfHWRHFBk3Tcx38F0oKpxXeh60MGzXi5DAqa2+fWzuQPw2+u?=
 =?us-ascii?Q?ki5UsYx5aCPiQfoeywz6Mzg2yLjSrUulvf40ESoq7YxeOdKhFoJSzN7/aQ4J?=
 =?us-ascii?Q?1r0KmCThz99OSFM2mVg5O+4gvmAreyvFh4x0/88ZjWcNsUC5EvrG6h6L1ZEB?=
 =?us-ascii?Q?LkNfHkpDFjCxTckpzEmsLP8N4IOJ93vAgFZHU1AUcuspp7hju9U1iwhBHZiA?=
 =?us-ascii?Q?aKnby33iwj/INlNA1qvyNdNMhC9snr+QSC9EveDiXiNCNOrG1GmU4HBHpo0+?=
 =?us-ascii?Q?eg6+Z34+kro3PNuG2M2BDcutO0IsklYkBIliMRi0TMRDvPakbnBgSMvLyQ3u?=
 =?us-ascii?Q?DIX7Bfg25gjPpuBh5Prk7eiBUYhCcvwXVKZ1WHOS47C9pyOs3QLJBlEl7H3r?=
 =?us-ascii?Q?KJRZUdP5DVQZUosaYIh+T14uVcqFwWOxJGPt1EN+PxfLj/chun4URioAHBE6?=
 =?us-ascii?Q?Gy99hmuKoAQ92/6cUgv3I9zjZsUay6B4h1tGAb4igWQxuYTxcKSNOD3oa3Lk?=
 =?us-ascii?Q?tex25z4tqwBZopKjdLnQSEwFd7Ox6bTvK/NaAPeh4VFXVhxE50ndblhnHAeJ?=
 =?us-ascii?Q?kEqN2Z07jb2L3nbXrAqXqb5twc6NYaT7R/e8FQ1cX0zE+qzAsYfl/+ZoVJKP?=
 =?us-ascii?Q?WTUenOy+JLEMdeD6+M2hIP1A38/CQcfzaCdYL/PTUe6jsU9PTX1dAStVdtc5?=
 =?us-ascii?Q?hZWKlkYPOrBjQRxXgRG06NQGnfXyL6HgEtfv2aUH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b3e55c-aced-42ba-0135-08dca7dab378
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 10:08:13.5072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3+oKIShGt0PTwZtQMTwcm6AKm1Kyec0JG12WZhsQBKd6MiJj2PDLVMNekNe2OOBcTZd9ZJ60DSky3TClY04Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142

Hi Conor,

> > > > +properties:
> > > > +  $nodename:
> > > > +    pattern: "firmware@[0-9a-f]+$"

As part of removing the reg property, it is required to remove the variable=
 node name as well.

> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    firmware {
Since node name "firmware" is a very generic name and broad reference.=20
It is a request to revisit the last suggestion to replace it with any one o=
f the below close suggestions:

- se (Stands for secure enclave, already mentioned in the description).
- senclave (like sram: secure-ram)
- senclave-firmware
- se-fw

Kindly suggest.

Thanks.

> > > > +      compatible =3D "fsl,imx95-se";
> > > > +      mboxes =3D <&ele_mu0 0 0>, <&ele_mu0 1 0>;
> > > > +      mbox-names =3D "tx", "rx";
> > > > +    };
> > > > +...
> > > >
> > > > --
> > > > 2.34.1
> > > >

