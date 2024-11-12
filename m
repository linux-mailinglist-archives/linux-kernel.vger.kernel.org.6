Return-Path: <linux-kernel+bounces-405495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AD79C5277
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65629B3013C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ECB20DD47;
	Tue, 12 Nov 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NbpZL9Xd"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375720E336;
	Tue, 12 Nov 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404018; cv=fail; b=L0L6ySHgwNTqSMzOC80G34NhPa/iiPpzRYXcOr6LkQ2KSAaHv2d6t7gw7Wlv4M/nJNPcQp5a251dh9gjYBGtDH7f5nq5YmQWpUp45MwkAsxG+sHbHVCs9g8sAt7mayZIX86bLyVl8SkDo6hLgYYBrnm3ogkECxbHhDy9Asj6EqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404018; c=relaxed/simple;
	bh=v0z6ARR/+RgWXT59JOrdamH3bBkGw9XqUSfHew3fQck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k4+S3lnW8WG93uMXtsgGN3Mb473zydUa6IZ8G/AA6oA4sneDuRZmXHKVNQQhDixa+jHrxqhPXrRJKEMiP3O07AHxhhFAcSG2c5/80Nc1yeor+wwd28Y2HJHA4H3I6FZyF8tLN0rtmnDvQroA4oNJdlm7oRhH4cca2v4I4enuF0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NbpZL9Xd; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nP5T56o2t+/Uk21J/PyTTCQ7fYMxd3XAlqBfNPeX1I6Cfphm8OmfLsNl9kgcIhPmc1/My5N3fL58qA7PYQCyI6WZKWSy6PK4oTSf3uoYmEjowy79v0r/CI9lVwWJ1KahITFPe3uImZARHiLZSB72T9dIUaIGMgoJCxsTIDkh8/o32lim/A4X/ilrfh4Jdcf8rppB2DH2uYYDIjdjKXtfNnKpyBTORTcxGWeEx50Mxjhhno+nJJgqo1Q3ibc/UtUwmtmQbrtZmw3cBOrXukyNYwPjiEtNBIRZ3IXlELBPqanFoTHmN/xssPwSYiLdJwEwVacNHpkz/AZToqfDSO1RYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0z6ARR/+RgWXT59JOrdamH3bBkGw9XqUSfHew3fQck=;
 b=jsrqPpIqjK1xNtFkdxJq3Xt2DbD/dFuDcYXG/TZpnagcfGvTcKcRxSB+Ct3X8O6Hi7PDmDBr7dMcdoXcDLgmhD20w2Fl4qjGSpayfG1Be6L6iFtnJGwIfIlTbYC8vDdXAO72ZokXsr0JK1qLfsPanFjyg9DAyZ8SPxmwZ1bwQZntYSbnlz574ddLz4CLkILGEH/q8Mc1gVqsOqJRGlD2vkkCVecJUfyui8RP0Qndr0WHLPcwGoFNBxy82lBeWYmiBABt51WtaQA3JNSdndUthH1ej5+Ukl/uZNoAQdrphj7Zi1Zlqt9cGs+lK+WYLiWHdR9S35ceL5Miofq1p/mqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0z6ARR/+RgWXT59JOrdamH3bBkGw9XqUSfHew3fQck=;
 b=NbpZL9Xdt5KICCJF0HfYnMf9oiUhKBq1oMvgERPbdulveWe3hCS4xaYMuqJDwvJdw29xNuTuxNw9G8GwGXNlrr12exDlDW0slhyTH58E3N8Q3CcDBsNAt0zegw7b2EgNCkqgQ/ywqgaxR6DVqzJorfhhp/3ZafCoVP8im7RPm/uYGjy6qryxs6X3uhMJshrjKJuSDsuVxAJ06AlVekO9duPfIFMmU2Q7JT4QzlQHr6dyGXeUj5kjay1uOBSqLdQsQkLYeQZQmDkQZVMLdm05iP14YoWSMtrci0kV1hL1lvXoPiakJR8mkxCZq3QrXDFIRcRRCmZI/TMQJKz3jfMSrg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10447.eurprd04.prod.outlook.com (2603:10a6:102:413::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 09:33:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:33:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
CC: Abel Vesa <abelvesa@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo
	<shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: pll14xx: Add 208 MHz and 416 MHz entries for
 PLL1416x
Thread-Topic: [PATCH] clk: imx: pll14xx: Add 208 MHz and 416 MHz entries for
 PLL1416x
Thread-Index: AQHbNKOP39wnhu10BEC3eHBnnadZzrKzYoAw
Date: Tue, 12 Nov 2024 09:33:34 +0000
Message-ID:
 <PAXPR04MB845972109A37C12DE7FF347488592@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241112013805.333798-1-marex@denx.de>
In-Reply-To: <20241112013805.333798-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA2PR04MB10447:EE_
x-ms-office365-filtering-correlation-id: 286ee810-4fcc-49f4-d98e-08dd02fd13fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/l3oG0FDVsJTCkyLx4wB33ZYfQTfgzUOrYY5CgxePX23Wjk/OJmXw0xq7PkK?=
 =?us-ascii?Q?jhfbQtckdqEysExhgiIW+nEB5vHcfxNwwnZbYu/jZmjHtxuEbvV2J9B8oltl?=
 =?us-ascii?Q?VU/1QlXHcA+u2FieA0I/vLf005de2e9Rah0dsKb4v+CnP5UxYGOOOxYhhElA?=
 =?us-ascii?Q?R7oi8hDgNWzHJy+JOD/fOK4ZDq4OMPIFUC/mYXswG6PAqr4zzSvNOM8ko4gg?=
 =?us-ascii?Q?WP+uuvq1NaVu5GnMuWjWPCOYkXN1+zYpdnzxDFTJ6cWpt0SAmbrtZF54awqq?=
 =?us-ascii?Q?BhrDzvGXoxUIj5guS5oKuJjXRZyEp9DwTnnYLGVXyfZOYpGxvMKseQwTzQci?=
 =?us-ascii?Q?YVhkcTozufjP4gPwM/RqyW0/I4a+gvOJzXbDcTECvDEflG26wHBooqgxUxHb?=
 =?us-ascii?Q?P3564eLCtJbmWM6tXC8x4sFLzDOvxOTKBgYtBb/jHom5jrg2vHIwWTHS75gS?=
 =?us-ascii?Q?tEJqM9cXtutkf3+2h3H9mVmAPbWaYxRjXfSC2XNt3+FT/57kt/hmP6MVe6Cv?=
 =?us-ascii?Q?Yks/4W0ba/tKyMANmkJWr6BU0RsrEg9rbCVGC7Ddb84+c/3N76EiLybFMRfF?=
 =?us-ascii?Q?i9Kvpn7LEGprA6Hu2y7Fw2iE2SvEpp76IdTmpTRVII57WhLVg2K9K9Y5l+bF?=
 =?us-ascii?Q?GGNmnc5BEI34SHXHGY55hpFhKRv6eRSkHb3bJglgV5cAu0JBTcEWniE8eiXH?=
 =?us-ascii?Q?ZWwmzN1ysySA/rD1MyOp/6CLU9GgjkqapjlkOcx8oQQQxatAHJRvUfmwfVFV?=
 =?us-ascii?Q?aDE8MNdRSSJDjGPcpYAlxeShKltC4OBTNqXi7w4eUrayb8WQDmSwZn8w3Dcb?=
 =?us-ascii?Q?YtAFw45VJMM/MdOX3NMSJsc4vClcXemU7AT5KuQkyNkKHtsNMkTimJ6xkpD+?=
 =?us-ascii?Q?x890UoMqCwrJeLmxLoMYZTLoSkw5mUZqnTfH2QcKnDFr7pKgfOUdsOWHQcpd?=
 =?us-ascii?Q?k1uE9Q7l3m/Vj8gBTzBLe+4WPSiwthDR/oemzXblOD/aeekrLCvXGxwxgcgT?=
 =?us-ascii?Q?/HnrMmbWRLjm8450DzWJo1G3DBhZZabaLdC//NBGPEWZoG5MvFBzpUVipEUU?=
 =?us-ascii?Q?d0IaA8MkmIRmHwD8OhM3YLDSWzdsvdq7zbCTXhN7WpZ5wpEV+Wnnedu3ihIW?=
 =?us-ascii?Q?SkAwgGe2LhejERnHL7s0MhJdF/fZ5Ay/1XGc3CWvx55CHogb6DxUR+cTJ33/?=
 =?us-ascii?Q?jdu4vvzD2Ey09vAqCxXYoFpZhuaAcRe4f7TtKvDHNMp37II/B6lEpkoDgAqP?=
 =?us-ascii?Q?ICuwhBQXnv1KEiKMLUSl6xxwYXB5PjTU3kELVF0NajKlDpR/Q31MaSAXPlJV?=
 =?us-ascii?Q?gg+7zf8SCl38vtrPpOAZbkNryRb1qsQRTaRhOrR/RiF1qE9bUSLctHMwI7sg?=
 =?us-ascii?Q?WS4cXvg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ud8+oVhsHHuR5XFZ6rXyUCwKPyeuKDR7KW4oFeSlwOeTXSFn7eN1lcTCiPZp?=
 =?us-ascii?Q?Pb3KLTPGp5KwIqy6uxBraZQ3HLGqajDimaMzDD8DOiXVYYHaEiD9spPSH17r?=
 =?us-ascii?Q?AtUMszG+LEGJ7UOQb68tPRXe8iq6SBqVVv5IH3GvNKi3ah6GFYfr9F8SkdlN?=
 =?us-ascii?Q?v9ohZqQ6w1tExC8InZ0CjCoQp37ARpJj2x//4eNNVj2db1cTGyHiVgkE6T2L?=
 =?us-ascii?Q?p2+kOT4Bzo4f4UfHQ/pQ2ZW0c0SM3tOE4lMsie+3Qx08fhbCyLC7FFlU36dC?=
 =?us-ascii?Q?NS88QsYn4vwQz+qH85mtLL+BC3rlt8xEWHFiMIGR7p4ofe2LNGfWtiW8sW7b?=
 =?us-ascii?Q?GXArnYSSQcuQNTqzuv4YJCcXEt50bkjQPlctlpI7RCz+q/3m7U1KEvhNxEX2?=
 =?us-ascii?Q?FT1gbqh+Wh5n1oMzEgkKzxFoqCqK/FFUUdRFjDYZfS6hT/1KwZLxTU/TdM0D?=
 =?us-ascii?Q?6Uo6RoBNndqPhr+OqsO6Xwa9BB7ndhymSfYPMbacIXwG2aXFuTSiPznBWMHs?=
 =?us-ascii?Q?kl30rUBKbogXc79tttisHOHqySw0VFcPEJuwtHnqzS0owF2x9U0ebAV30Uz0?=
 =?us-ascii?Q?s/etz3Qnw9O9ALhfMBoSOD4J12IsGO6ESX3RNT4bTD3upNXyeQrBr6xcz46N?=
 =?us-ascii?Q?0TpCT+EoXG1ux/U5RkdkEjEYSxNLfZKP7ALZnw36tzWkOjR1Yy9JR4wUkfu+?=
 =?us-ascii?Q?WvjIEd5LoiBe383ZoZUHW88XJ+xSbK9XeBzar/fl+R4vYO/Sl+e01ePQU4R9?=
 =?us-ascii?Q?yPLh3mcJ810x6ZATETcQo4ASPiOUsPxPSZfMZkaQilCJY1PJZQDx1H3+UwQ7?=
 =?us-ascii?Q?lzie7Vj6L2qvkx0srt0wfT+S+zKPqV2SLIRgSIim89X50Ab0KMxQ15MuWKEw?=
 =?us-ascii?Q?Qrpeod6oe+zOLKEjvw9523jrEVjiuZvvNPEO0mA6IdjCZcvBlDt3DFSZvMtT?=
 =?us-ascii?Q?dbgv5AaVXpXF1Yw6Re85hqC8pP2OU5rg7WTBTKY+i9j6fO6f0nzgKQHrQ5N9?=
 =?us-ascii?Q?9T3xdRO9zvJ6810eo+l8WoDjqZPmkCWtS7GsB1VkaGJvmLD6yFd1GCqKLMVB?=
 =?us-ascii?Q?N2Nde2CJegUAHgmx7N0DMzHeJxN+1bQk+y/KkRYCj3EeXo5aopQ6i8Y+OaRC?=
 =?us-ascii?Q?rjRSPNBerYvwDpWX8FQLL51vRH13ukuKIKfVAiv65HT05k01+mJY003r7rFi?=
 =?us-ascii?Q?EDczAEj/I6ww55MU8NTlU+D8UkFszfa88umXnJX0rYTZ0OrkC565DtBVJQsB?=
 =?us-ascii?Q?7fs7S+xKxvEuvEpRkdZ472GGkvkrF6ethSwUoNFv+nGLkIc6QCHMxeAyGahS?=
 =?us-ascii?Q?N1FkAB97/27Npb/j1HyQ3+SzK1ReLTfsKIzduwmnQfnlriFfHEZLuRaQrzPu?=
 =?us-ascii?Q?DBVr3YnQJtH09T6FhTMC+BEV0gvcc7/7NQVn/tkKOUwA+aQ2pq07oCfMh795?=
 =?us-ascii?Q?BJLR/b0PaqQX3zQO303D1jPtHdINreP72kB4PBOjlHjxv+wFNpjYvjma52Im?=
 =?us-ascii?Q?yQezzHmwXqE89s3dn+Drpo2RemT5Pn/UaiqsW14YOc0PAnXnuwC0MSuT2dKq?=
 =?us-ascii?Q?F6TWP0SByiqIADbtxcE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 286ee810-4fcc-49f4-d98e-08dd02fd13fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 09:33:34.1242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8QGAIAEH3fafsbwSef7e1l89W+o6kEhcvbiksLOXPBrD9KllXStOc8BnNoWfTV4BeuDacYYYSHxr7kJaJ6PRNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10447

> Subject: [PATCH] clk: imx: pll14xx: Add 208 MHz and 416 MHz entries
> for PLL1416x
>=20
> The PLL1416x is used to implement SYS_PLL3 on i.MX8MP and can be
> used to drive CLKOUTn clock. Add 208 MHz and 416 MHz entries to the
> PLL so they can be generated by the PLL and used to produce e.g. 13
> MHz or
> 26 MHz on CLKOUTn output.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

