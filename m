Return-Path: <linux-kernel+bounces-197688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CBA8D6DF0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED911B23AE3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 04:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCB3B67F;
	Sat,  1 Jun 2024 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I8fOz5b0"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B1F6FB9;
	Sat,  1 Jun 2024 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717216691; cv=fail; b=uIyZuyQjqm6PktD/8MJ9RJm5JRE6/Wwwt18blyszJdTPZEGcmpNvdLPOPtd6B+kD0NQzY9bMqHyyqCSKUWFtuREH6LX9F9Wzr9RinVWxkz8ZSSbgipMsiwMO8hXzcD8an1Mi4GC6eXqHAjlZQnpg9qcC9rmSkXSpnbHir5WlK2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717216691; c=relaxed/simple;
	bh=n9MpWvFwJn+68636jWFGyuTtpev02TUqr4onAFXbdnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oOjDVkfCdvRryON68Lj6MIjzv1aK+IBacCEW5amw8jGkWdlw2NN/Dqt/08yirhtQcBWUhWVcqTYKHA4g28L9vL3BfT/U306QPNt4TczYmCVJD8Kwan8KHrrwRoREDykzXUQj5FRBUcTy4x0RlUZWszmMfY+a69L/SHhQ+ZS2QCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=I8fOz5b0; arc=fail smtp.client-ip=40.107.105.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHd1HFyhvfob6quNruxxoxfjAh9wzn+nOnP6lVAUN11HFllx+2dlPDeEoTm1Z9z7HtJGp9/UCRvITabojbIqKMZNLx6Zop3NtYKbdLMixWdKIX3EYrzpLXdTXdD6lkpyHGoFKFA9+tsqOPswxN7SS9Xq9aWGNbtCZ0v45PHYULh5lEIF0XiiIQmXX949/OF521zS0pv8GtvRk8j/Z4r8/NeU16DnDYnmNY711Sd7BvVfNqTZ5OZ0kKw5vBrlxj5r9pk506gskcbT9fG+BplRibM5ryO8xaiZp7a1p43AcCZKuhuXwrzkpQBj9vW5XFQuyTzqR4tja03D+jCEMvvGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/0o4x+fLG6FJtv3V1Iv45+x4FNLpAI/jsLKOIvCH+Y=;
 b=U2twfz8TfkVeU/VJkSCsjQUFogMa7XehZ6HQFcSWHFvHviQVqtnPgKK+nsg/aUNBO0sRSEXE+qH5YlhJyzVrv9ZO7DS9h3lk+1D0lmMFNnxh8v8xDM/2m9KJgCQVLBDtsLfOevhxzmTmKp23sHuAfCcX1eCZh7bVmiu/mtCjUSP1w9i4OcLZFEXpbrTF8F/iDTnGwiOoFQu5ZGjtcgEcLP758b6sSu+86jquiL2iYsM8vwNH4gFaX8l7hrex7tQAw9JLENv6PDKKWcswWkcVGAIZYA2O5QveHkeC8CdieM3SDo/q9qVwft48McqpihHwbUsBgH2++FY3usBF+3HqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/0o4x+fLG6FJtv3V1Iv45+x4FNLpAI/jsLKOIvCH+Y=;
 b=I8fOz5b03IIYSXriHshjIKXf+B08qAx+VFE8C2tT9IQTV5ZLe+CTJ6/7cmsJlto0EqZfczph88MmRas7C0SoylcOs+BR0o6SorM+TKBtXd2WkEqNWzZDIPpFEZCW7XxmYAURpacVoEADzbpWX8QvI9Qf8+EEXCkKSUlW7Wa9Ovo=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM9PR04MB7683.eurprd04.prod.outlook.com (2603:10a6:20b:2d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Sat, 1 Jun
 2024 04:38:06 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 04:38:06 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Pengutronix Kernel
 Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v2 5/5] firmware: imx: adds miscdev
Thread-Topic: [EXT] Re: [PATCH v2 5/5] firmware: imx: adds miscdev
Thread-Index: AQHarP9e6ZcFPGAJSk+wtTuaFLEKr7GmDUYAgAAXzHCAADD6AIAEW7Qw
Date: Sat, 1 Jun 2024 04:38:05 +0000
Message-ID:
 <AM9PR04MB8604E13D3A283F2E9AD7445895FD2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-5-5a6fd189a539@nxp.com>
 <ZlBOeAnkrn4ki7Wv@pengutronix.de>
 <AM9PR04MB8604C000F464CF1F5788901995F52@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <ZlCLhPzLD6ox7iB3@pengutronix.de>
In-Reply-To: <ZlCLhPzLD6ox7iB3@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AM9PR04MB7683:EE_
x-ms-office365-filtering-correlation-id: 50f21bc2-567d-41f4-ba7b-08dc81f4a19b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dBNmUDL2jT0mesONQaaDqyBS1h4p/62ADCYf24kGYlS/GzuYRvYAfMSGonaF?=
 =?us-ascii?Q?RsyzUg5svfA3enmOaqa/tef2guENbgpfCbV5xyCAEt5xFxitGSsdJafaVh65?=
 =?us-ascii?Q?Sp6RkLp8es2H9DFh5bwItxmn67iuJQK9LBi7ecq1kdMCf+Ao68dAzLS1KeK/?=
 =?us-ascii?Q?S79uZXYqOgR9H2bKX5qUUEZkw3bwum1emqgya8bHVsnoIXdnbDnzSLee/1TQ?=
 =?us-ascii?Q?Jg4f2LHePdLVnTNplhJxSLqd1yp3q3wFwqFUIuUqFZcgGXMq9VP+S5JjYhVh?=
 =?us-ascii?Q?2eviK7iuHP7Zp7jZKQHafwERaSCHKkfLWuEoMP8S1xPwy2F32I0Vb029UoKH?=
 =?us-ascii?Q?LqG54wzMZDNH333lRd68WiqtTFisfi40lpWtoXswmOEOVdvUIN5mvDRCbA3i?=
 =?us-ascii?Q?DoF7m0WPMy6gzb2opXvNGMuJ56+pbpUF4VPcFpSqtdr8GuStUBIclnGvojPc?=
 =?us-ascii?Q?N75hKlKWbSJEJhJsCKYgxDr4aXNHhNKAKxVgkcpx+vOnt2QAReZ+v/GEDpvg?=
 =?us-ascii?Q?IJeJI9cTrNbLH8GSp+RuZimoi9cMhYr+BixmwsUNw+4gP+eMIwpowsbsu/OE?=
 =?us-ascii?Q?VRX440c6ker5rdR41TaVKR5OopPn35/EAENYUBmuyn1/eiWkfW+555WH+6QO?=
 =?us-ascii?Q?8e45tuxniobl/993UpjM/jufPCJgRsNE/ufN3dh3xVQ5vZoVzh6UtqhOs0RL?=
 =?us-ascii?Q?mDjJP/Z7HUNSTVCMjnJQMMm/6USlyi9JxeISZqg3StkgibNuIrOJvV4ZSnsi?=
 =?us-ascii?Q?h6HESyZQPVZUJweBStNxOf5VpxOHl3v7CDnbx5/fJ+aAo6w4LeIWGq6ynT3f?=
 =?us-ascii?Q?sJW/8uko3DOBO9ie9SARQ5n5bM0fyxkleiik862Jl4s+b1MYfRRoRHB5IX/w?=
 =?us-ascii?Q?xPoJi4YHJkQjEFzsFINaWbp9fgeZAi0qqv7w1KocBwDUU/yGm1Lk5PWTMEuc?=
 =?us-ascii?Q?1l4x24bJ4TXZ2YcKXxFj1WeS7PYVBb54vesJkbOaDNah/xBOMj9XchjK2PD8?=
 =?us-ascii?Q?KdvjqUmS/uvjOR4TCYXgnzyR12Pvxbk0hE84hISK2dZuwFjVv1kSvfPE1vfH?=
 =?us-ascii?Q?o9fGjVslTmhEUkXDECa9W3Ax+0+c2wQjZOjuyY2cHHGr/jsxhVqxjMOOJh4/?=
 =?us-ascii?Q?lz7BmiAY7x6iNPJpNCZdtFUO05tOrVo27229eTWXvMt0fANK3dK3ZRQ0miOO?=
 =?us-ascii?Q?1LG7lY9lfzpJ2aLwGobjhCP50MzjdeQTlT8t03G9U/+h4PNyAo5WEjN2yX/N?=
 =?us-ascii?Q?jTBzM+7pp2biwGvz3ehaiFhEtUCcZbWdXCr0dMqBKA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZDSMlAvbsSzGVxa7df2hyvHjeo3fJ8pwnUMUZLsYeBdnrFc4We+S4hWEj2xb?=
 =?us-ascii?Q?DgIIqa/f4lkcoRb40nugzpGBXmzcEN5s7KGR3V2nRNl4tOHOgdfyAwMHfa3N?=
 =?us-ascii?Q?xGEOUiADZaZvlBR1ZUuMuZTHR2+E5uFaUSdT10TgiBvTQyh5ODbyelb6U24T?=
 =?us-ascii?Q?Us/gcoJ22dufFUQkTtu5dX1ORNlfLYYFl6fTvZtLd+BnKTEOBFEqUs9QOwxl?=
 =?us-ascii?Q?pLAeveau88h+VRG28t6qZMU1IdxeRD5D0ZtpXEhZ8kG6cw95qQYT4+ZNFfkG?=
 =?us-ascii?Q?Y/80fUkA43zbgQUcMo0vRskCwBWvXxqSZnNFhg1/j46ZGrMYhe29oM47Mihh?=
 =?us-ascii?Q?2nYsQkNF9VLNH/PN4+tr28a86uCEnIOV4wWrBXiCpgEIdiGqtckilIvJMw/H?=
 =?us-ascii?Q?5M7vGBih+gHqpsuqRMz+xhuFsFe2bzkjJguZSA2NQ3ad//Z0pxZG8OCjKxrR?=
 =?us-ascii?Q?L5HKX6Xn1CBg/f1kc1mwLkcnVKo7l/e869S7u3AuWM+UteSQn4dYV11L23Fk?=
 =?us-ascii?Q?JFUxC7dZfgwJdhopJBBGf8cltQ5+4b9C/LNZTeCMUg5uct91YJIH9nhjZ6hE?=
 =?us-ascii?Q?EiYOQqoUVZ6pRz4qyGsEFrXBOLJ67kubF/wIRmyFizBGRhOmV80RnPwUPRhV?=
 =?us-ascii?Q?mkP/uzwIKNlQvMR/ugAgAGs5qmqJ/pSGQaYrMxyVQZgu8Qsf/a9SXF/1Wl6c?=
 =?us-ascii?Q?VvqIQkizypSwGx29Rf8wZ3pQz0x2x7Vd3QLJyivVsR3L/59Pc/6WGGMD+8ZM?=
 =?us-ascii?Q?Zj7LTiLso7BRM8N0ayOXMg40hfgGdYO/NBxHFYBnPcQT/iD35c9v6b+w2nwr?=
 =?us-ascii?Q?R4IOohKkpr+2nqOh7kieUD1RDXgftrdfnYHw4wk662HgqsSmE5QptFTZUv7P?=
 =?us-ascii?Q?QCrz7b4RYoPTiFcTjN5YNjJm5Mox+EEGWY4GzQiE8R1F+BZFvYRxGBuKdGDq?=
 =?us-ascii?Q?1sTwZNCsr8BjT3aWklnQBtLIQHXY0fxk8zeOU1uC6Obl1Jqud6UKBLsd4p1d?=
 =?us-ascii?Q?Vg2cZf0X64xHTiMsq8q60DBtuQvdAhJ3c1nCl29DL6mFhMSfh+nyGPmMqg8x?=
 =?us-ascii?Q?IMlIMlKnIdYYL49chhhmZC/h1FocMdNJOzKa959HQH//5JbO56xIDn74Qssi?=
 =?us-ascii?Q?1Oms8MjRxnOQWVKH1QWaCDQdV3A3/q1Xy6H16WrrGfIIzqvgolD+wzwRW6Ep?=
 =?us-ascii?Q?0AyxIsYOhbfovm3OQ45bb+X8AKTf+OSybQxLfHbSCTwkbiK2LA+JWKqrlyBH?=
 =?us-ascii?Q?5HFdFdQLn9S2vAyWpr8FJrzkwHGvvpTz74pN9S6cGhGDiJVoL4OK6anYJDjk?=
 =?us-ascii?Q?ZIEaRo4q2YU2moROCP1eBa4Ud7KRKMKoWYzdS5KkZj1Rf3wKSaJWhrw5N5uv?=
 =?us-ascii?Q?r/x/bM3rWiuLLapJMtkpufAFLDV4w/XSgG8VowBiiwOEay6u5/jj+RP6xB/I?=
 =?us-ascii?Q?E6zqBuyfFTjh3HH/8lvjDcH6XI1+4w4y+gGujaN7rz67N8zauSZ8wv1I5BRg?=
 =?us-ascii?Q?wjo2Ph9fKuMI11qW5rYagNM5LlbOkBBhw4di/qHHYhyixDQfa+r09QNSPvGB?=
 =?us-ascii?Q?kx+Be2N1YiHcjkGJECwZzkBdTdRfYRmSZewBg897dWsccW5kA8VV4DNSjOjV?=
 =?us-ascii?Q?drEuVGoQi0kwsfJjGlqVSswWngJ5e22vn9GyDYpEQ/j5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f21bc2-567d-41f4-ba7b-08dc81f4a19b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2024 04:38:06.2988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mz2VeUSlmy7p9hN84/13Fqst48NFLgepfL6t1KFO14o8QKIj3qRT+vYbJQ5mPVUMiiNYQCX1U+Btn4K80/1W/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7683



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Friday, May 24, 2024 6:14 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [EXT] Re: [PATCH v2 5/5] firmware: imx: adds miscdev
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Fri, May 24, 2024 at 12:03:35PM +0000, Pankaj Gupta wrote:
> >
> >
> > > -----Original Message-----
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Friday, May 24, 2024 1:53 PM
> > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring
> > > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> Pengutronix
> > > Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > > <festevam@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof
> > > Kozlowski <krzk+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > Subject: [EXT] Re: [PATCH v2 5/5] firmware: imx: adds miscdev
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Thu, May 23, 2024 at 04:19:36PM +0530, Pankaj Gupta wrote:
> > > > +int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> > > > +                          void *tx_msg, int tx_msg_sz) {
> > > > +     struct se_if_priv *priv =3D dev_ctx->priv;
> > > > +     struct se_msg_hdr *header;
> > > > +     int err;
> > > > +
> > > > +     header =3D (struct se_msg_hdr *) tx_msg;
> > > > +
> > > > +     /*
> > > > +      * Check that the size passed as argument matches the size
> > > > +      * carried in the message.
> > > > +      */
> > > > +     err =3D header->size << 2;
> > > > +
> > > > +     if (err !=3D tx_msg_sz) {
> > > > +             err =3D -EINVAL;
> > > > +             dev_err(priv->dev,
> > > > +                     "%s: User buffer too small\n",
> > > > +                             dev_ctx->miscdev.name);
> > > > +             goto exit;
> > > > +     }
> > > > +     /* Check the message is valid according to tags */
> > > > +     if (header->tag =3D=3D priv->cmd_tag) {
> > > > +             mutex_lock(&priv->se_if_cmd_lock);
> > >
> > > Grabbing a mutex in a character devices write fop and releasing it
> > > in the read fop is really calling for undesired race conditions.
> >
> > Condition is:
> > - Only one command is allowed to be in flight, at a time per interface.
> >    -- Second command is not allowed, when one command is in flight.
> > - Duration of the flight is till the time the response is not received =
from the
> FW.
> >
> > Command lock is grabbed and then released in process context only.
> >
> > >
> > > If sending a command and receiving the response shall be an atomic
> > > operation then you should really consider turning this into an ioctl
> > > and just not implement read/write on the character device. With this
> > > you'll be able to get rid of several oddities in this drivers locking=
.
> > >
> >
> > It is not an atomic operation. It can be pre-empted.
>
> I didn't mean atomic in the sense of being non preemptable.
>
> > But it cannot be pre-empted to send another command on the same
> interface.
> >
> > As only one command is allowed to be executed at one point in time,
> through an interface.
>
> I meant atomic in the sense that only one command may be in flight: Send =
a
> message and do not allow to send another message until the answer to the
> first one is received.
>
> Using an ioctl you can just use imx_ele_msg_send_rcv() which takes a mute=
x
> during the whole send/receive process and have no need for such a strange
> locking construct.
>
> > > > +     /*
> > > > +      * We may need to copy the output data to user before
> > > > +      * delivering the completion message.
> > > > +      */
> > > > +     while (!list_empty(&dev_ctx->pending_out)) {
> > > > +             b_desc =3D list_first_entry_or_null(&dev_ctx->pending=
_out,
> > > > +                                               struct se_buf_desc,
> > > > +                                               link);
> > > > +             if (!b_desc)
> > > > +                     continue;
> > >
> > > b_desc will never be NULL because otherwise you wouldn't be in the
> > > loop anymore. The usual way to iterate over a list is to use
> > > list_for_each_entry() or
> > > list_for_each_entry_safe() in case you delete entries in the loop bod=
y.
> > >
> >
> > Will remove the NULL check.
> >         if (!b_desc)
> >                continue;
>
> Please don't. Use list_for_each_entry_safe() which is the normal way to
> iterate over a list.

This change will add few more cpu cycles.
Will add this in v3.

>
> > > > +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> > > > +                             u64 arg) {
> > > > +     struct se_if_priv *priv =3D dev_get_drvdata(dev_ctx->dev);
> > > > +     struct imx_se_node_info *if_node_info;
> > > > +     struct se_ioctl_get_if_info info;
> > > > +     int err =3D 0;
> > > > +
> > > > +     if_node_info =3D (struct imx_se_node_info *)priv->info;
> > >
> > > priv->info is of type const void *. You are casting away the the 'con=
st'
> > > here. Either it is const, then it should stay const, or not, in
> > > which case it shouldn't be declared const. Also why isn't priv->info
> > > of type struct imx_se_node_info * in the first place?
> >
> > This struct definition is local to the file se_ctrl.c.
> > Declaration of imx_se_node_info, is fixed by adding const in the whole =
file.
>
> Add a
>
> struct imx_se_node_info;
>
> to se_ctrl.h and you're done.

The scope of this structure will remain to se_ctrl.c only.
If you suggest, will replace the info structure with secure-enclave interfa=
ce index(u8 if_idx).

>
> >
> > > > +             err =3D -EFAULT;
> > > > +             goto exit;
> > > > +     } else {
> > > > +             /* No specific requirement for this buffer. */
> > > > +             shared_mem =3D &dev_ctx->non_secure_mem;
> > > > +     }
> > > > +
> > > > +     /* Check there is enough space in the shared memory. */
> > > > +     if (shared_mem->size < shared_mem->pos
> > > > +                     || io.length >=3D shared_mem->size - shared_m=
em->pos) {

Will update this check to replace io.length with round_up(io.length).
Will correct in v3.

> > > > +             dev_err(dev_ctx->priv->dev,
> > > > +                     "%s: Not enough space in shared memory\n",
> > > > +                             dev_ctx->miscdev.name);
> > > > +             err =3D -ENOMEM;
> > > > +             goto exit;
> > > > +     }
> > > > +
> > > > +     /* Allocate space in shared memory. 8 bytes aligned. */
> > > > +     pos =3D shared_mem->pos;
> > > > +     shared_mem->pos +=3D round_up(io.length, 8u);
> > >
> > > You are checking if there's enough space in the shared memory
> > > without taking this round_up into account.
> >
> > Yes. It is initializing the local variable 'pos', with last store value=
 of
> shared_mem->pos.
>
> Your check is:
>
>         if (shared_mem->size < shared_mem->pos || io.length >=3D shared_m=
em-
> >size - shared_mem->pos)
>
> Afterwards you do a:
>
>         shared_mem->pos +=3D round_up(io.length, 8u);
>
> This invalidates the check. You have to honor the potential padding in yo=
ur
> check as well.
>
See the comment above.

> Sascha
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.pe/
> ngutronix.de%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7Cbd91341
> 92f06423be17c08dc7bef290e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C638521514310084478%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%
> 7C%7C%7C&sdata=3DiVTkihKZ0F9ATk%2FTXpXMqmj8tJq8ufKijglcPWegjA4%3D&
> reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

