Return-Path: <linux-kernel+bounces-278800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D6D94B504
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AECFB21CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BD1D268;
	Thu,  8 Aug 2024 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DoUQMJkd"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D2C2C6;
	Thu,  8 Aug 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723083635; cv=fail; b=TMNm43ZmjZ4C6m0dHtbgUykO18De4CX/kUoQkZkKu6r/SrgQp2Mwc+z8WdyfFUufzIxWLsDm7w9Wy76HNnKYwHzxU9GO6oNAUwsQ54f1xNOsLXT4j44PPTHzhKd926yGxJfu/lyZA4BLICv2AnbXcwHFw0nSORXCByQtcR8ozDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723083635; c=relaxed/simple;
	bh=aNLtX1v9wiIQjx89ngvw3nC/GP9K7PZZ4DsW45ODE0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PCYhL6AcbD6T9Flc1dCvu7GzhIdX7hKqCHL4/ro9fi2vIZp7u+29+cuSHgaUjvfW4m75biCC2Y/OgkFwYzea/UArMlHXomPWJIgpMS0ZZDvd7wXBw2mVx8Q9hnpjgf1aRBTyLeV6lAZ9f+WX6vQ8BUHhpT78WopGYnyPebqWLIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DoUQMJkd; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWYO9+aikjEIsVYATNtS71nUcVdztWC7bWaoB96r2vJyv0/odjz9HHiSnm5t/v4OW47CUXcdWagyHdYyKsn4mhBcfPaSSpkJjMotxGjAst3X/b/61HRMYxfohHy35Bn80QkuqfD4YuO4wxqMH/1PGjDkSv3uKOVPPPjyOw3zsITeRs2n32L+E4V69Ia03rgXpzeFxaiucUkz7AMzcM0M9y2xJPwEnjcmLEhzo4v/ubBb0KlU4cWdK1ngHhJy8Cp8toHrRS9ayvIM8E5DLOd3MvW8Av9WQN+bHzwG5th7GTMB1rBjBl5O575ERTIeped1RjJPzQEkpqWz5gbp7Wv3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNLtX1v9wiIQjx89ngvw3nC/GP9K7PZZ4DsW45ODE0c=;
 b=CLQcjs7FQCMEw97pzGckEJeSwuGPloMSkpBVme36PGxPy0sZF6XarUerlR4BOH3eCCvXGZ6dbF4j6EC3d4GWeRVSUpyxKGKCusU2jVafX8WaBsvmO7cPAI3Eg8NDjzD3urdTyvcLdOqodh9PI3/g4yIEd9SwIABP8ha/MEXrwbTWdQCMbOv3v3Hpzm5Wf/XPXXIZNDlSQpC08LeCAcVZpW4KAPJhEY3PQNByBfFE8X8TCfTxalBIJk5++rZUnc45nNII70HcvE7h/NHpihQ2vQ468GSOFfbFO/tnnpQ9FMa2xYsO1OIdKS9Z4cgMReAlU5wEBEqNML/mfohmbPpZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNLtX1v9wiIQjx89ngvw3nC/GP9K7PZZ4DsW45ODE0c=;
 b=DoUQMJkdJEJ+5gp3cw3GrxKs+Tkj41pOuSPzW/1RYr6tWiWWaa6uIspADSnbb9/BGykkhK9z29NyiHEMJh9LFdosfP5i4sGQwb3IoLD5jGZKKrRd5r6pwHnbvHYSkjo6kvYxj9ojspJErk/pjQDq96wEm6MC+Fr1HTc6Mjn4UTIvULT5nPiL/3Vi7i2aWOCFcpWMRzI88mSN0uLNMMISNYUY1xwgxrkMweOc6uo1xocvW8s8qywfU2jQN8rWrkvtW+KNIrl7/92qF3e+oPQLF1dNWCainMoWtUr7WbcTTBc9p9YJRVYNyP42gdaZjxvqKx122WVucLgrQhUvpFhTPA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6934.eurprd04.prod.outlook.com (2603:10a6:20b:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 02:20:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 8 Aug 2024
 02:20:29 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] dt-bindings: memory-controllers: fsl,imx-weim: Fix
 "fsl,weim-cs-timing" schema
Thread-Topic: [PATCH] dt-bindings: memory-controllers: fsl,imx-weim: Fix
 "fsl,weim-cs-timing" schema
Thread-Index: AQHa6R2UyoXyAUgFpUCeTPSlyIXD77IcoK9A
Date: Thu, 8 Aug 2024 02:20:29 +0000
Message-ID:
 <PAXPR04MB8459DC3C8D1030FD216756CA88B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240807225959.3343093-1-robh@kernel.org>
In-Reply-To: <20240807225959.3343093-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM7PR04MB6934:EE_
x-ms-office365-filtering-correlation-id: fc968a83-7bf8-43ab-1fc0-08dcb750ac3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wUWYibcxR7RxBh4iwbn3Ie4CrJHoIsf8SnBcsmc6c8IzgxSp1xrDs+/FHRvS?=
 =?us-ascii?Q?/kyAibBGbQrN2IfqL34d1okFnH67f4JSXe85yUP9Caco8o3eSFoCjQSfnsNS?=
 =?us-ascii?Q?ZoMzNyYTwPr5OxMKGEnNqD/UgUutUSZyPYyD5Bt9nqAuzXIugMu9YBO16PZD?=
 =?us-ascii?Q?Uz5A2592PUIZjerbIiFhp3BP7Zc3HiZCOfRyzD6bEtURkmvo0O06neMr4cFS?=
 =?us-ascii?Q?uF+jk8Yh+Gs8sHUZpqRpgyOxIWZmPxjCpUgTJKCeOt1iCtGF+33x3yaQxPcq?=
 =?us-ascii?Q?VDAcRr5c6HUP0Svu9YhqHpFPwihZpjqVUvN0u5fBgJll/oC5XlGq/qPAU0dE?=
 =?us-ascii?Q?DiLv+dOj6C/GpQcH6VQglyIPoCl3N+b5HM5evKiNbiMaC71FZTDDGviI5OPX?=
 =?us-ascii?Q?BSoX6bJO3HBEvJO+S5ghudjQ6gxVNo5A3H7Ar2tAhot+ShkiqTUuN787jPN1?=
 =?us-ascii?Q?jd+c6xTbsMFu4zHFTwVzPJqVXSBXfwl5GiEDfAN5wVcXUsCwoSIxC5E1SbGI?=
 =?us-ascii?Q?p3MsMUeuXqNZFttGTFijebJ5RoONVINzWDOfeRVQ3jdCa6nV5rK7KiaPxlAQ?=
 =?us-ascii?Q?xDkDhdBg5df62gN6zDfIVWne+0LOeQ1I7BGg8P2AIx7Ve/t/nMRTTbfSbeNd?=
 =?us-ascii?Q?TItMgezJbmK9djFgHf4K6S2N3fwEwKNKTT+pEww20yOO0NBdE4lHxin5JCnG?=
 =?us-ascii?Q?K7r4Av42N4yd7jS6NFtILSAK+r5+3WypRoHj2MrTmSFKtg6J9NPRNtz3ne+3?=
 =?us-ascii?Q?RPO+vdX/UNsEmCArOseY+hcWCpjt28nLyDuI7L24syIuDtawWzfPOm6/RlOy?=
 =?us-ascii?Q?Gkmfs41qD5Y1Nkma1I+Y/zFL6jF666oQfciabeOjDJEUABIrKqQhgcIuNxg/?=
 =?us-ascii?Q?HF+3RdMcAFqlK9gi/EyzWl3NP2DpJN3BELRqcua+rEJYY/NBGeOeZJsmHWl9?=
 =?us-ascii?Q?FlQSY9hAjhlhAH+DGP8FFsg6Y84kNl3cMEZSqNV8CcxZ6MsFT/SsKItMcAAR?=
 =?us-ascii?Q?xs7LRxtVZmbWZZ4aV+v+y0BBZoVycUVY9u9yV+1OEjLPe+PVrNj8UVQ1qTwN?=
 =?us-ascii?Q?lWSwrKsEVYYoCszExFAi726ipENq5eFwK3uEpjR2EZ34Lle0I8/iCLfeODEy?=
 =?us-ascii?Q?sSNcfnesRmfBe5NKe1mJfaI9bQ+wa48HJLjORTRB5aRfnAYTdk9+R7qO8gq4?=
 =?us-ascii?Q?A/8RnFWRor5y3HRLJ6kT1M73ZNaI9mTnFT+bzPDUNflNybkYjkQyVx8I9CFx?=
 =?us-ascii?Q?QMiZEudGFAIFJUm2Ff1VECsed0+XkMdempS9WqgI8yXOE5Q29Zs0iupAtAuB?=
 =?us-ascii?Q?MeAKaUiAWtiF+7KbyPZWMbrWZvQ9aTrRcuLKSe605wY8+vx45GrjF0rCQDlG?=
 =?us-ascii?Q?3aQhWio9MTXAy7rhkFsIMsFS3Ls9xtiy3TAX9fX1TtXTexQ/JQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sPPFHN4PAUVObuUtFDxGy9NG7qMq8p+669U6uDFCqhMWDMizzaZ++PPgGxyB?=
 =?us-ascii?Q?OJIGyFRqLcWmDGXgWd0RfysiPs3aDQhH0tkb3K8nE6377bAG0lurvtg3YWtZ?=
 =?us-ascii?Q?lhMDcY9kv9V0nNbKcZ9VsJcrbAN9xHSFbYa5KzoD2P+bKYwEkG1KhHH8LyCO?=
 =?us-ascii?Q?TD6ekN4y6L3yREO2nkJvm4qjvNH+y/j0QgGsecJrMNC9loRrlkNWPg43YCLr?=
 =?us-ascii?Q?1zar9qwkYHlMnToLqp1VIGyYlhg3DH74CL4dBLGi8In27DeVBukoY4/jLIKT?=
 =?us-ascii?Q?66sgkPPIQ+nkoT5LsLaSOvr4fLoPPgKk5hPHLy6tCFm0bvYk6BNYmXHrtOFR?=
 =?us-ascii?Q?ypy0GCRovfP5qssKbvtI5iTzRlujVmCq0lfPmBT+qG7BH9/aWCtlVqlpJ2rX?=
 =?us-ascii?Q?SlnFVgYWuQZkCdpoc7xtcsBl96x8jwHlqVCFRrP06nwGtJKxzSz3RKJ9gOM1?=
 =?us-ascii?Q?r699Mq/FnjEzAAqk8RRtwv0WRvNk1Aqf9pPcgl52UazJizcUF2RDSaDTyaSp?=
 =?us-ascii?Q?WaHWFymHzOLTjuzRS7OIvTEUb4fU5nLDpe9eUVa6lJomSHvtYvMchOwqPtI+?=
 =?us-ascii?Q?yfAARi+urophVHj3ILKILDmrTqjJIb6xq4zh9b/0GonAl0hjyYGN1nzsSomL?=
 =?us-ascii?Q?35CACu/EmBBWD/ek4Eo+8wbgFtS5dd2PN1XuBNKHqbOHWFCW2NlWmm+DtCKx?=
 =?us-ascii?Q?qj+O4cC4GCEzef11I1t2EqKyM3jFfQscjUXdwTUj4L+zeRMymObgtBEmpCdp?=
 =?us-ascii?Q?2lAOmEyF0dRvuOjIH4+hXqygae8gexjfLjrg4p+qGWrKyePFC2BlNi8JVUiA?=
 =?us-ascii?Q?b/81vK7SvgQBmwL/QvJAklisnIFj0XrsZbPfhyjymbtCEPdLbQmGAqOPTA05?=
 =?us-ascii?Q?MSEfevllpJCcIW6xA4Zy8UdlG3EVKTPg6ZxAT5uNMt+/EdpfybjpXQMbNO+j?=
 =?us-ascii?Q?mJuSaNJre9zfozPeqIoCWHIYrVSKMYCucN62Z76wy1K58tixUyfTB4Cmlu3V?=
 =?us-ascii?Q?hJYz7qKbe0YWaNgMfWLDJJRe1stnJefr1+qi7ndI2eMoKXJZ4LVw9e0d9VDo?=
 =?us-ascii?Q?S0+egqwwj3yiUFPJAF1ls64PoGluf+OFuQI+6uOSVRdNnr0zsgdUCnYzI14l?=
 =?us-ascii?Q?n+2pdB/dCO/ScYBXJuGLKf613xQxBcRYwEwgu1KaInRAup8MU2jD74nPcKwq?=
 =?us-ascii?Q?PfxQwDZCyonIfeYTjNkh3snCojS3IlVSONXT/bLxnKbuOGUowzz1cr2HKCAk?=
 =?us-ascii?Q?xyPn2VYTmhVxK/+z+QHXJYYcP/fU9YIQYo6Yrev2eSjjXtGTS/OFkiKg7zeA?=
 =?us-ascii?Q?eRs0KJifbt8krAsDmn/nqxGDwGTEVa7UMdKqGxvObkap9N0p0U24f7pRwtjz?=
 =?us-ascii?Q?0QljI7zWYKrFfF6tQdqN8+FJGeU9xC830oT6zlcCGxHwD62U5NpIZB8k7his?=
 =?us-ascii?Q?x9c7RGrRQ3fbRn2QK2p9HOmmEyfngJlA5S5BWJ8xO3tNHeKXvm2uhMLRkib+?=
 =?us-ascii?Q?mNCUE+tObfYR6nuJoN8gGZKrbphi0bnttO1p3GH6zZupYK19Dyri6xo0Yhyt?=
 =?us-ascii?Q?+KQEVm85Tomg7PCXiyk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc968a83-7bf8-43ab-1fc0-08dcb750ac3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 02:20:29.4424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBq9Zy5BugaVHIsXVSJMGPJGJq+2f5Xb4SFipgCVFIG5UIuEItFm3v1SR1ARfI4k/mxkMseF3QIUpAkIo6MY5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6934

> Subject: [PATCH] dt-bindings: memory-controllers: fsl,imx-weim: Fix
> "fsl,weim-cs-timing" schema
>=20
> The "fsl,weim-cs-timing" property is an array, but the constraints in the
> if/then schema are for a matrix. That worked fine when all properties
> were decoded into a matrix, but now dtschema decodes properties into
> scalars and arrays based on their type.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Peng Fan <peng.fan@nxp.com>

