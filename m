Return-Path: <linux-kernel+bounces-205407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D70888FFB1A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1B51F26B78
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 05:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FAC38F96;
	Fri,  7 Jun 2024 04:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m2q7S5MM"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2060.outbound.protection.outlook.com [40.107.249.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205F41CA85;
	Fri,  7 Jun 2024 04:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736340; cv=fail; b=I4VY2EikTl3Dfp7rnhK8RKRQB63vIyxVW1SUNgrXyiKY9+nkcTyt5/oDzS9wdokW4nUivGf32hBQ76t5eR1Mu49lm+NuwAC6KcBDZFsA8rsV2H+G5tMKVIQY4OdTdvvnkQQvdGZn/bgbIF/U25m8gDfU2ajHmOk/7da1pSkHD60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736340; c=relaxed/simple;
	bh=+rsKcmeN5MHF9MKNxgvSm3kwzcvQDdlUTuj8PJhec3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eVxmiHcwrI/TwS4YlvfWzCouZH4ThMuJ5xs/0UWITuXH1AhbIeIx04pFuPNRCoXzWlc1aEf9Pbt1M7r8MVfnM+ef09nnlrUu2p1idmb05v+UJRqj/Si/9Dx3N5ZDq21jkCbFWej2M5YYKXmFg8J2FCg/b15FNU/DvjGDvOM1iU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m2q7S5MM; arc=fail smtp.client-ip=40.107.249.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVlKCMhaCZmGI2tnI21z/X25jGhdDezm2qCsTk2u0sj/k0pyV1uNroFupcOgQUQeYo2rz2AhSwzshQxAPtiiKkkkIz5y6tEj8Kgefm8myVLHpKxMmAxPO16DFg6qOGjD15hdg578zRZUi/+dzUacSkOJ2cFto5QPnvhmtw/qpMNwYBzU8y/XCoS2yfNtNFj+GkXmdKE7CDZxzURsbvXMPb4qVr4paWlc3UW/HgrdevSbbCotJTlLDw4YnlfGJB6ftwH+k/dzokR/R8Y1BusCb89+Nxq9q+BcVXS2HzaWYo5LlVa6Q80LsHdKf2lG8sdgBQZ0h9714yRxYG3UnQdkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8KqMnGpDG6AGf+cmyVEwAfb+FJsZhZU1D1JlI4AxNg=;
 b=mEdYtzxD8s+RxIVGe/DG4elljqsuM60dsBVRaZmX6wJl/PHt3OwgVzR5xofVtboh1dh3f+qqwE1+77DMNi1Huj4WJjov2M2dsWDbTGAVG4yhYXwQKgLU5N4nCp8yGoVu/2K1Q0YlpnwXdksZJiN+98tLi0WahCDVhEvOazCxthh9WpxypVvCU3ewNPrkyZ1BYDGF7lkLcXoDojsaEcrXheydTMxhqYLafNcSU4N7+RwoKIZ7Bfhdt23sQKMD1huWS9dH4azg0b3y8TRkBQRaYN7Co8jLyRAcliNbFlAxLp5FmhTqvNAdab3NAUMd5cCPQh8ZA6CLbBmuC244tLDwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8KqMnGpDG6AGf+cmyVEwAfb+FJsZhZU1D1JlI4AxNg=;
 b=m2q7S5MM3ug+2dzVLtlZ0XxDNDqM6FYSQVwcqCTBKtp9oOtrfBfs0LNQV5cjm9/j7/koVdUMJjxYVTbc7R2U/oYNUIbMFfSx+N8ufcYVr4p/JKYwblTNbIxOT/00lABpauVCnHAMbIlr9MWsAVhHs2tGW2yT5npuIEm0k7Y+f9k=
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by DB9PR04MB9283.eurprd04.prod.outlook.com (2603:10a6:10:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 04:58:55 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 04:58:55 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Franck Lenormand <franck.lenormand@nxp.com>, Aisheng Dong
	<aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Varun Sethi <V.Sethi@nxp.com>,
	Silvano Di Ninno <silvano.dininno@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Frank Li <frank.li@nxp.com>, Daniel Baluta
	<daniel.baluta@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add device
 tree bindings
Thread-Topic: [EXT] Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add device
 tree bindings
Thread-Index: AQHaoao2jC57TZpcF0ePF6O5Tvr8yrGOZykAgC2ClzA=
Date: Fri, 7 Jun 2024 04:58:55 +0000
Message-ID:
 <AS1PR04MB9358A2457AF05553457DE9B0F3FB2@AS1PR04MB9358.eurprd04.prod.outlook.com>
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
 <20240509-secvio-v1-1-90fbe2baeda2@nxp.com>
 <750f5388-20f9-45a3-a1e6-ceac4b91329f@kernel.org>
In-Reply-To: <750f5388-20f9-45a3-a1e6-ceac4b91329f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9358:EE_|DB9PR04MB9283:EE_
x-ms-office365-filtering-correlation-id: 18ee4bbe-ac0c-4656-7beb-08dc86ae8874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|1800799015|376005|921011|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AcOgyLxnFEP3R5JZ4aY29tkrxTYsPZnFbMUU2XFz/PUtQSzc3nIL7APfmrr9?=
 =?us-ascii?Q?v0wLaGLFxdggca21Fp9BkQC7UL56/r3A4qMkWm2SU63cEYYbBQC0Y1tyYWh7?=
 =?us-ascii?Q?vjYIPll/Tz4X+JX1JpeZ2OQyJ/l6XyHvXv2zS5+SspdYDMI9PG5QBKDlt+1F?=
 =?us-ascii?Q?u+gm9AYl9bbg6ppVemsn4XqWXKrFWUeCOP6u3kbvb1gFT800vIVceJJq0zmZ?=
 =?us-ascii?Q?XR8tbYXizIgYsDfJmUBrKfvLSa7PYiK9iIWR8i+ln7C+q4LPZu0WBKZKZkM6?=
 =?us-ascii?Q?hUy60yIYjkZ4aueFsCaoDu5UqEvK9EcPmYBnCoG3sPQepcocxc4hurGcas9L?=
 =?us-ascii?Q?gqC5XVlldq3i6BlBY33a5rv6haNoj3kzm6tQrL3xOfOUZ0MM/Jg7+Fn3m0ZW?=
 =?us-ascii?Q?R60fexcI+WIcs3r0eZfRUEFXBoh8Utju74NqEUHDa66/RoR/iw3dh6shSOGV?=
 =?us-ascii?Q?76nM7jTWPC/SzMXpJvPCI2d+HTbUZZU45BfC5BAKC2sH91/1mOnDEaGxW2z6?=
 =?us-ascii?Q?XzG50xDbX3jKt4btasIoHCorsoVSI8nLWkE228gNfWCTEWa+jQerbS0Zklgh?=
 =?us-ascii?Q?/VQoalCdvOgOgUDeOrXTZvlRD18kQIMIQob14cftj7iU4bn6b1cbZIk7OSyJ?=
 =?us-ascii?Q?RssNvCtxdITVSCdQ2NkzorIVyh7BcJB1Lfy0Jm5Q0jnuhFQGHAjmxW1mB/mp?=
 =?us-ascii?Q?aBN3o+rxM4l7SQtSqYIGaP7w8X10JStt6xyU9xi4LQujPOE8u3LuRtW99WHV?=
 =?us-ascii?Q?jeXMV8CcFN+TgwqD6OBx4MxGcdhZ022oa6G+PygmvJYe48KGXG5fiKr4NcvS?=
 =?us-ascii?Q?JRSgELemN9pCaXE58YAL2x0l1YeYHODwiNvKS53pf66d1RzuNgNoOc3MzT9e?=
 =?us-ascii?Q?OMuzzf+b0E/dJNA8uKu6lSvhZg96rD6KgvdThcty3+h4HoHMwDKv8tvVKBX0?=
 =?us-ascii?Q?Oni9q4bteQmpyBcuMF+efwfW41cBBFT2oBBBFKGs+139OrHrwM1pKwfobEn7?=
 =?us-ascii?Q?CamQvYK3cbrHZ2tUceIWaE9ISp3PO/c1eO2fYXBRQtGZLSUjA+7htf79W/yD?=
 =?us-ascii?Q?vEBwcwm/stCR8mxxUK0IMdBrZlXSBIGaFMkkSX9xln6FI+sLyws4LJ1BiBCY?=
 =?us-ascii?Q?nnSwcdYEoGzWSQjXQdzPmPvskfFN0HJxS6XuNaHdwCgPOPyDood2mYD2sFap?=
 =?us-ascii?Q?0oGzjk2m1PKhZ+rRCWjxVBmX+Cv7YTmdvC8aLzHFu9YN2gg+64aAggdeWAwq?=
 =?us-ascii?Q?QXJXHK/cAHmbcLHrZEtGo8lgs5HoEwH8AErytF7ltfxWSRWKvyFxEfLH1FWB?=
 =?us-ascii?Q?4CooFj7MAlhUlXr+CI891QjpUpq4bVB/42SxdyxoBjwr/IQeG6+LsW9f5ZhN?=
 =?us-ascii?Q?gIeHq2F9Ch0ZfuVPINn5C1X+hCtM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qjgOzfd+N08Uq5n6GTLJysR5OljpmRLomJ6W1yWWSTyOR8Z8vx2wgBqidK1b?=
 =?us-ascii?Q?zAKZFfgcWh6+5DMNdFlC+6THKCG4g/jOI/lKLX9IY7Q79Nmt6UWglORVK294?=
 =?us-ascii?Q?K/QlXNpBXnrfCNbsdmIk7+z/J+nC2Vbmz0IhyA6SvNlUKpRPE2WfzQu/7ZM4?=
 =?us-ascii?Q?H4HzOSjTG4BP4ioVDpwy9VcgQaoUZcHYK9IeL4Mcg8JzGossP+QSUdhcJl5n?=
 =?us-ascii?Q?TgIuGvZxu9nuyBd8nHJehSupeJGhqF61aNgL3C/jyU+EaVruMMnfzCo/6C7O?=
 =?us-ascii?Q?halaQ7FiPzRWyYinS5a0t7IEluN2L2lukzcJAxaoTZ4DBXr3yp0pbKbZc/n1?=
 =?us-ascii?Q?/uPAVZEUIgLCUgEW/4tMMMS/MWTEN4aWkI63NQmZUMR6XlJnfyQcr4MM4ZcF?=
 =?us-ascii?Q?z2jr/3dePLkV6oOU9JmkYu7mCPrJQ/849eWT6ffvMGZOLzCArAcJ5kMOVEUX?=
 =?us-ascii?Q?PrrGAbV1e2bD23esNtcrvMh7qLyqasdBNdFQATR6JH1nLEetpWyAsO0ht8Va?=
 =?us-ascii?Q?zmRRoU+qxEZ7+HjNcFtKgSfExPYWiSq7og2i8YOdaLgrY/Od94H2IUjZZ05T?=
 =?us-ascii?Q?wRRSeCD1MRkpKdDNnSmPEFQvUviwwWwZiV6Oguh29qFG8oQtuyOSk7X7QJ/X?=
 =?us-ascii?Q?bB7OM6HK54WLdKeUVDume10CQsUoUuxuUbyIEh7Tk6DbYdKnnfHiyAAkb/vF?=
 =?us-ascii?Q?GUg2AyY7bR8VYKPOFJpgloE/urRmytyCrME736EvnwB+jIs47mfTNP8L40ho?=
 =?us-ascii?Q?Q4EPq/3DSmykAh7WR/hVovioBRwQP7yPIDDDl2mXxHbVX0ChkUzlVt+IEUHr?=
 =?us-ascii?Q?7C4CUHtgY09our7SBZ/aJ33BsaV/vkAx2yaBVP3RlJ2Dz5fChB0Zie7EchA9?=
 =?us-ascii?Q?C04yH1C+ShK8n6DXk2OlprJvo73xWApJSGYKsGJmrYgBzg3kS0RkJjThvnAo?=
 =?us-ascii?Q?RetD+duo245kKBu4Y3f3aVxulpJCCMss7bBJiCsJAOWc7KbolnEVfOEN9MoA?=
 =?us-ascii?Q?asGSDvAk6AZ1m6BN6EONqBtm2p5TBsvmq89AelyMsRK45KjVjZ0MoUk5CGRP?=
 =?us-ascii?Q?9uTLbZB7mbX9EJ+aeb1EDvusnfNuoOEbhwGlsJ6oPAJ/2LlFOdOcvJRsyyof?=
 =?us-ascii?Q?dzX4MD4W1EvZ2addsfjpk9sTkv0UeBexzgJ6PQJ1lLbkB/8N/N3SNmqVbA+J?=
 =?us-ascii?Q?LJGVhHLFoblk84JdwadX8/h2rlaO0I3Pmc6NfkQSKBvBWY7kwDefyVmj8oWw?=
 =?us-ascii?Q?Vb+OPgqZDAeDj/dozJbykTwscbj+kNFnc1KpCpFT/jdnB+ZTdeyASEli5iWm?=
 =?us-ascii?Q?v2f4St/IXp1O9m6H2tC3krCYBVT9lhHr2U0f7FJMtTWr4HeuNny30mlbjrUi?=
 =?us-ascii?Q?WNL1qsN9IfLbE1mX5dJ5rrX+XVkC9e68wtoX8gm9i6O6Q5+goe4kQZmqVm5H?=
 =?us-ascii?Q?YTAMdu9BD3cI1p9L8NgdSKl6g1yBI7sXqT0QRFxbQrcjK/iaB5+u8oEhtP1x?=
 =?us-ascii?Q?px3Q6aQVXIgjijk/6cFKLV55jMqag48uuaKGeje2ohMOb4y/L6cMbxKL2Y+3?=
 =?us-ascii?Q?oeV7xyG1tkkXUTXv93sHeRM+KppH5sQ+4Rxup6On?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ee4bbe-ac0c-4656-7beb-08dc86ae8874
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 04:58:55.1381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fYiDG6xOHCCMoFiZ8EV49yQugk81CkCxB4qLHWs2DEyfmt2C/B71JIyt/rc4aO6fVcVapktAX+QqoOF4gxhO+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9283



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Thursday, May 9, 2024 11:24 AM
> To: Vabhav Sharma <vabhav.sharma@nxp.com>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Franck Lenormand <franck.lenormand@nxp.com>;
> Aisheng Dong <aisheng.dong@nxp.com>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Peng Fan <peng.fan@nxp.com>
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org; Varun Sethi
> <V.Sethi@nxp.com>; Silvano Di Ninno <silvano.dininno@nxp.com>; Pankaj
> Gupta <pankaj.gupta@nxp.com>; Frank Li <frank.li@nxp.com>; Daniel Baluta
> <daniel.baluta@nxp.com>
> Subject: [EXT] Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add device =
tree
> bindings
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 09/05/2024 02:45, Vabhav Sharma wrote:
> > Document the secvio device tree bindings.
> >
> > The tampers are security feature available on i.MX products and
> > managed by SNVS block.The tamper goal is to detect the variation of
> > hardware or physical parameters, which can indicate an attack.
> >
> > The SNVS, which provides secure non-volatile storage, allows to detect
> > some hardware attacks against the SoC.They are connected to the
> > security-violation ports, which send an alert when an out-of-range
> > value is detected.
> >
> > The "imx-secvio-sc" module is designed to report security violations
> > and tamper triggering via SCU firmware to the user.
> >
> > Add the imx-scu secvio sub node and secvio sub node description.
> >
> > Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > ---
>=20
> That's not v1, right? What changed? Why do we have to guess this?
Yes, correct this is v2, I will provide changelog details in v3 for v2 and =
v1
>=20
> This is thoroughly documented in kernel process so read the documentation
> before posting.
>=20
>=20
> >  .../bindings/arm/freescale/fsl,scu-secvio.yaml     | 35
> ++++++++++++++++++++++
> >  .../devicetree/bindings/firmware/fsl,scu.yaml      | 10 +++++++
> >  2 files changed, 45 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
> > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
> > new file mode 100644
> > index 000000000000..30dc1e21f903
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.y
> > +++ aml
> > @@ -0,0 +1,35 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fschemas%2Farm%2Ffreescale%2Ffsl%2Cscu-
> secvio.yaml%23&dat
> >
> +a=3D05%7C02%7Cvabhav.sharma%40nxp.com%7Cdea3ecc999444d8c3f7108dc
> 6fec67e
> >
> +b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63850830837113
> 8503%7CU
> >
> +nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> I6Ik1h
> >
> +aWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DNl9F3A9%2BTraZboxg3KXT
> 35pIPAyYZ
> > +51URq1wff7XCmo%3D&reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cvabhav.sharma
> >
> +%40nxp.com%7Cdea3ecc999444d8c3f7108dc6fec67eb%7C686ea1d3bc2b4c
> 6fa92cd
> >
> +99c5c301635%7C0%7C0%7C638508308371152796%7CUnknown%7CTWFpb
> GZsb3d8eyJW
> >
> +IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 0%7C
> >
> +%7C%7C&sdata=3DdwOG7uVGtO8rccW7vcRwvc2%2B9gyDroIsWnFlXyFxbOM%
> 3D&reserve
> > +d=3D0
> > +
> > +title: NXP i.MX Security Violation driver
>=20
> Bindings are for hardware, not drivers. Describe hardware.
Yes, I will use "security violation detection hardware exported through SCU=
 firmware"
>=20
> > +
> > +maintainers:
> > +  - Franck LENORMAND <franck.lenormand@nxp.com>
> > +
> > +description: |
>=20
> Do not need '|' unless you need to preserve formatting.
Ok
>=20
> > +  Receive security violation from the SNVS via the SCU firmware.
> > + Allow to  register notifier for additional processing
>=20
> Notifier? That's a Linux thing, how does it relate to the hardware?
Violation detected by HW will call driver API to signify the violation.
>=20
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx-sc-secvio
>=20
> Missing SoC compatibles.
Ok, I will use fsl,imx8dxl-sc-secvio
>=20
> So no, that's just abuse of DT to instantiate driver.
>=20
> NAK. Drop the binding.
I will detail the dt binding to describe the real hardware
>=20
> Best regards,
> Krzysztof


