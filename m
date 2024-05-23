Return-Path: <linux-kernel+bounces-187593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B298CD4FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543591C213AE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D479F14A62D;
	Thu, 23 May 2024 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jmcH9P+Y"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E802113C80E;
	Thu, 23 May 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471833; cv=fail; b=luqteJC9tvNq6cFvPpTdHDlKefgVw660cHSeq8bzJA7dzBcsOi3UPbEVmshSxTsQOmM/m0VqKt5kHfU4VAQ2d0qhv5skg/RdeXEDxtKpoiNnCskHMa6504QBkuXncswOEUqmTeEbQ7+dPpieGSuIZC3e51dW35T+J67vbLYUpfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471833; c=relaxed/simple;
	bh=KmIohq93iaYVBv+4XtRrdpqLG4gOMBJZOEVIQoxum9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eJWGJsKvveGfPrX4NnEwtgZd1LQZfWElcWU1k4Sj5nTtrQdCsgASmmqmmr2aUuqQJGT3LswQxx/Nc2WCzxhUj1e0PCI4pnQBGBu/DKeN7E2hHgBXnuRH4hT34zpk02o6IUqgFEqMtBFTPXWhY7zKV+5z0xdUfSXcRPw/H2evAyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jmcH9P+Y; arc=fail smtp.client-ip=40.107.105.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iALMQBVgy+IG/IByeDbJjJFMusUhnzwF9OSKvXgi3psnTkG2AzfuzwXc6ffQBeAzYYp6ObI01coVcOnpYNebABfV9INESPsHUQoQJZG0uU30YnaiV7TPtyE+D9QM8QVYVJaTHaJPFLn47EMJlARDrZnSTcxkGAf+JEP5bpErLqi3lwNKVmFT8JFc4Zkg3LEWhCfXJweiZY6d1lNR6HrI1faet0/E1FBEVUB3GPf7Z75zuUhlaL/cxbYxL+6xeSwgEOUCb6THp6t8Fq6Vwep+UORjCVRSZbE9J8y7yEPJ7y26/8drvzQvzDTFTp5KCT6CASSqYgOaK3TA5e+hIIi9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrWJeae89CsBHouHo+EeQIRU5tNVcq3gj4Vfy/vv7kU=;
 b=iR06mHrnPeZ20j+uaK6zgQ5CZeN/s7wTA5e9sfTndnxgpaCexhc5J/2dhu7wm9xXhdiELyzNAjwD/8H0aMqyUnHiXTupAUfu/LfqL30EkvSpMrMJznSMW3xbkvp9iix8ns/9mRZoxa07rvuK4AOrKENZQiekDQ5xy1BMmUcXPSRorGSZItJSz2jEFBuvg4r6UtYguC6Vf3A+7gKImBZbf6kNLXzJxkIO9tTLLztaYM26AN2H9vdd8nAsZmHad3v4eEiehClX8/1Hv++hGeo3ZwPl8ehYbCNSNMf/s0Djti11mvAQTX8VJ2yS/VEzidekx04hg86N8XbeUW37KmsrTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrWJeae89CsBHouHo+EeQIRU5tNVcq3gj4Vfy/vv7kU=;
 b=jmcH9P+Y7gcZGITR/bMs+Ahud7V0qjNwAoMYkQR+OKhU/fj/F2FmET5TWOICTFT7wWHvHS44fHjKCmANg7BPgW6QZpwBpfItFkqYKfilRvEyeRIRiWEPovqCGaTavCb7auCIATEZ2cJp/eFN7ZCdaaIE4iEcOi4ShhioksvzMxU=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB8884.eurprd04.prod.outlook.com (2603:10a6:20b:42f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 13:43:47 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 13:43:46 +0000
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
Subject: RE: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Topic: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Index: AQHarP9ayLdOqCtfLEqTQR0Rf+AVuLGkztWAgAADNvA=
Date: Thu, 23 May 2024 13:43:46 +0000
Message-ID:
 <AM9PR04MB86047218A243EEB5BA79F69D95F42@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-4-5a6fd189a539@nxp.com>
 <Zk9DV6Ko-KO0kym_@pengutronix.de>
In-Reply-To: <Zk9DV6Ko-KO0kym_@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AS8PR04MB8884:EE_
x-ms-office365-filtering-correlation-id: 11782e91-b808-4947-896a-08dc7b2e5e57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LSx1z05ijJj7dC805hKqONXAfHI1C3lnDVlgnj347J2FDtlJPQkKLzcQdphZ?=
 =?us-ascii?Q?adcSqzyDJCwodQE9SggV0dmCaXVlSmK9VhkgCruJ7S7RxSv+lZPa03aL8Ufb?=
 =?us-ascii?Q?SjXY1k1KnLYzS7TjdHIvqp2m6yzfx5zKGfTWmuu+QwhWGZlRC1PSGXeKnS4x?=
 =?us-ascii?Q?Kb0aqgVUUn0o8tGm/cz//9HFJvns/0gW5lfpkK2Rxh5kngfjnJThhGBcLF8m?=
 =?us-ascii?Q?4V2NZhWBYS0xMFD/wDrOD2M7IjN4CkAO7GFIiuG38CQln7Yvqmjsg9IXH1u+?=
 =?us-ascii?Q?VveELjGO5gsd+dY3CeZR0LyLYwj8253TVpgmEu1ftQ4/ysRHRaN1ostQOqJd?=
 =?us-ascii?Q?8KU1+iNsljNzyi4jFYPxJtjiFci4lUWJSazXjAbIAprb18fDUhPVAklJjUUi?=
 =?us-ascii?Q?jCtPvZXocbzOSoVQx4gavxtnzUxoCE6G7pyVqy+vlrPui43KEvx8UQXCQp7a?=
 =?us-ascii?Q?M1hgQHW3ZREY9EKb3X42kktH3XCiR0xOXyJ8lSL/C6lkId22N6hIgGs+4WJo?=
 =?us-ascii?Q?yTB7ZAyc3fJutPgNnkJ0mk/i71cEwJ6lTiZQb0QXaOTNQ3G+R856hWLAXEIv?=
 =?us-ascii?Q?MVlNPfuJmepYxttMsJiUMChG/RdcbJTfHpYIauvF4kFkhuC7RTpVeaq54Xe+?=
 =?us-ascii?Q?xwTKWMXckQxnoYP1R9cpbGhBrOMdzEozBZ7tKnVB89eSywj71pendJLesalY?=
 =?us-ascii?Q?X/g2z7klf/9eTUKJC27KNB0WZWPEEIeS7bw5mifJAchraZ+np+/L5cux7WVv?=
 =?us-ascii?Q?F5IRpDUHFVQArgAoKPrmmMLIwJFxnR5/c+dmZTk1C961/miFxZ91t1DIgt7f?=
 =?us-ascii?Q?osdk1P03+P0RtdRGuMe/XFLf+P5nni7uDrlpwpvyM6Ddcw2ffRKTrFNNHgDJ?=
 =?us-ascii?Q?LG+fw7CPIkJLoOUmDbR/+FbucD/b89zLMy/BizC3FGK7uc7Rf4nQtGJjglva?=
 =?us-ascii?Q?kwv3kcEhEkiv/CKWt/xULQvr5Iy1kTH9QXxDBAtnBaDcufvWZhArFjLTl96/?=
 =?us-ascii?Q?YQDoawpDi1pTqCvTu06vTVrS2Wm3oJ0P2I08aax3B6z67rwLtyF8yj5ml8Ro?=
 =?us-ascii?Q?FiUkfov5+TcprVeOkxgzshXfGyLlp2GZ67rv6WgpYQc9A2/rxbhBQc5dO6BH?=
 =?us-ascii?Q?5LEfg3DfEjs0bMUzwYwfB5urZH9XP5BSZrad9l6cc+pkwQVBZf5qGLp4cEeh?=
 =?us-ascii?Q?D7cgRtKXdmyLgJcNcngeuqvZ+P8IHkxfvdeeJR15WQfi84mFsfPI32742cC1?=
 =?us-ascii?Q?dHhXFYH4RSeN6seygG43WBVGJ7QDcmAKGEjkIPE51w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dCs3iXFZJZR/xWHIhE1AvsfU7nw4zD0j0pJ5oKXcAIuP94203rOyuZleoMYk?=
 =?us-ascii?Q?wte5uJnj6ER/amPueiQiKAmj+g2PegQuiWYk5/MXTYrphK9OLtCPjZGRhpIi?=
 =?us-ascii?Q?8KNhiRsy8xlIHYP5fz0Y/gQFiiwyiFODA+MuGuADjKe+g2+tWIcb3pLT+obt?=
 =?us-ascii?Q?RM5lRZmoGzksQR8jPfuXhjWJPq7KJaxUshVCn6cfN/rjCfVJffnC7mVwIiNg?=
 =?us-ascii?Q?WxuMDbQUc3frkjNPcuZyi8WYA6h6pUEyfSJHhiBXM5vB8iAmuwGXqDdrLTu5?=
 =?us-ascii?Q?T5s/2EnHbV6rxQhsgvHDkOjhqAo+R44/FBIW1bFs4B5eUtcXnYw5DRAe/Ll7?=
 =?us-ascii?Q?ItYC5VrAZ5iryO6xxvizFJESnr1SWto8l30EpRjwJn50L6Lt+fKn6NeayMSU?=
 =?us-ascii?Q?c/pXMbnpvNhCpBCbkDY1cxHaHqDeBnRHTmLeHppoI7x52om7rifx4WF55iWB?=
 =?us-ascii?Q?pGlblWcezkpewakLzZRnpYv0gq7N10zb9W3JCfBrF9tbyqlOy3de/TnZ7JI4?=
 =?us-ascii?Q?Ve/pDz2kHnVVQRmIELN0kqjBwoAYWRP4H7pJEWozkdzQrNL0sl3HE+7U1Bzk?=
 =?us-ascii?Q?dL2s/poR3Zpr8iu4+l/puIl/G89h5P8i8DyEvoQfobW7caTYU8e8b28XImXf?=
 =?us-ascii?Q?xyuf5jpOUThJHDTsvjxKHxwqQ0LxdDSlMxT1eZgAd6wFCR0bM9GHkJcGFSvQ?=
 =?us-ascii?Q?7rEFe3PcavCRS1OCPo0WH9WC6NEbKMXvSZuA3eLieew3ILMhmTIWDvm8vryn?=
 =?us-ascii?Q?9851AdLT33t+w5UsLIqov/c9tXrNNqDOz6TTQ47LYbifJPUN+/hGT+d5vXLm?=
 =?us-ascii?Q?CFMuZW6wEZzLcopuv32o0M1wVfi/dgajMaQ0z4G8DYNGLDXrR4KZAlxa8BrY?=
 =?us-ascii?Q?JLofBu8SwAkVBbDYQmPU3mpums3Kv7Sj8VWFvMDkp0O1l3jkmme1fX9DKTJq?=
 =?us-ascii?Q?z1ZcSraPaF2HuhP1QnMx2k0hOuoSB7YgSrIeSdzFy1ibo6nuL2qjbCSC6Llk?=
 =?us-ascii?Q?O1fgFZgBK8YObRaw0EvVj0dX3F0i079ga9FQwvOvIRLcfvoRB7YpvZ3MWQsW?=
 =?us-ascii?Q?pOzQo2+9mcqh3iaR8tlVQkC18YhkxjfIvl9k5acY8EPXdHMf9Ck0aN6KTl8X?=
 =?us-ascii?Q?IhNUU6J8y17rGBzodXiHsUL6tHAVaGRF0h3hRIAjyh7Vs3vGUKDFFKsLe/xZ?=
 =?us-ascii?Q?RcfKo6T7p5kbbNLaIcuQ92riUOAw3PGYztUhsLUJFLGWyjY/2nRBemLZAnLI?=
 =?us-ascii?Q?Ah+SRYOnGqIw7o8hlmXqPRuLcAhtXbPra5sh1X7MktUNNchgNpaknRpcbtUK?=
 =?us-ascii?Q?Sc780Pr5uvFGLlClEoENt3Do7/lWRusfqWK0AvgOYLO/b2WViZbJgjPdbp5w?=
 =?us-ascii?Q?lhmHDISm6xz6MdLLovt3znvrvSl3SeKkg9lPf3WB/artzCAgkiRKJZV+5sC3?=
 =?us-ascii?Q?jFFuxN9j2fMZSCgMBJh+FT03lJfXyt+kCdMn0mH3Ywx+hS+WOO+1Dc/pVrvV?=
 =?us-ascii?Q?JilVabASqEBWQ1Of/wVYApsRPv0rxJ/1qfYk1Wf8+Z/LVIfHtbBbj2DCH1cj?=
 =?us-ascii?Q?Ju9uMFPmaxx7TXYMqljnvoU7uXGejmxFGrVPGLvI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11782e91-b808-4947-896a-08dc7b2e5e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 13:43:46.1004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7yWGzJfBqsj7tEEEypXpWCVPeIsiNu7HVIRwfGtw1m3FOOMg5e2NTsudSljEQ0c4HKfBepAz7h+AREyfdbUMNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8884



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Thursday, May 23, 2024 6:54 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP EdgeL=
ock
> Enclave
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Thu, May 23, 2024 at 04:19:35PM +0530, Pankaj Gupta wrote:
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
> >  drivers/firmware/imx/ele_base_msg.c | 286 +++++++++++++++++++
> > drivers/firmware/imx/ele_base_msg.h |  92 +++++++
> >  drivers/firmware/imx/ele_common.c   | 239 ++++++++++++++++
> >  drivers/firmware/imx/ele_common.h   |  43 +++
> >  drivers/firmware/imx/se_ctrl.c      | 531
> ++++++++++++++++++++++++++++++++++++
> >  drivers/firmware/imx/se_ctrl.h      |  99 +++++++
> >  include/linux/firmware/imx/se_api.h |  14 +
> >  9 files changed, 1318 insertions(+)
>
> [...]
>
> >
> > +int imx_ele_msg_send(struct se_if_priv *priv, void *tx_msg) {
> > +     struct se_msg_hdr *header;
> > +     int err;
> > +
> > +     header =3D (struct se_msg_hdr *) tx_msg;
> > +
> > +     if (header->tag =3D=3D priv->cmd_tag)
> > +             lockdep_assert_held(&priv->se_if_cmd_lock);
> > +
> > +     scoped_guard(mutex, &priv->se_if_lock);
>
> scoped_guard() with an empty block doesn't make much sense. Either use
> scope_guard() { /* do something locked */ }; or guard().
>
Need to allow send more than one message at a time. Hence, done it after ta=
king the lock.
Once message sent, scope of lock is over.
Thus, scope of the lock se_if_lock, to execute the function "mbox_send_mess=
age()", keeping the "se_if_lock" locked.

> Sascha
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.pe/
> ngutronix.de%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7Cbf79ff917
> 442406e454308dc7b2b8ef2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C638520674210595147%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> C%7C%7C&sdata=3DUUYK6KTYzgxY5kO4McFy0%2FGrXxTrf2MG5g4cvJ6E4Qk%
> 3D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

