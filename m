Return-Path: <linux-kernel+bounces-358823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E4B998447
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02764281E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B31C244A;
	Thu, 10 Oct 2024 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DgrBroEy"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013070.outbound.protection.outlook.com [52.101.67.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F7E1C2442;
	Thu, 10 Oct 2024 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557912; cv=fail; b=c619S4QG2BZ0c+4cNssg4kGXika9gtKyRkK9TcQNZ9jMk6PPlcUUaI4krsKniFoBjuFUmSq0pMys4h2QQBjo+E41F3AEUshNbtzvEOnjKmj3YtDCrtWwbCHiD/3H7FvhTTI03g511GqClxE+tUs8jwiKQhqwELl1sHxpwpwH0OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557912; c=relaxed/simple;
	bh=3IQn80MRBFat0jdXoXOkfJu99DLLEno6SlZka/sukhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eM8B6lrfeBiU2dJbixZFspIlBBNWbETTX9v+H4yVcf3nHQ5/KqmywcjY/MMdqb+V4nF86pLLn8m4AGmAQE45yy84hERbQtcVu8KNshjF6Dfc/ZHno/Q3NXtf2rNTE5eWDWpyuJbatGXBTio5zgVq0svvZk7qygiYPEp+CGqD1iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DgrBroEy; arc=fail smtp.client-ip=52.101.67.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ech2RzN8BV71A0HMOJeyhLXB+LqefxAUe9cvXufQaatY+3wMpXgRf2lBbfIyDtsZOAuB11nfZtrvtCk8iN/6qjvz6Wsbn1ke13zuxhnxZzUPRNTvJC7+EozCuG6dGO35AoWQIfDDDmij6yBeuNRKTrDho8rYQ5XX0pXBxwXYq+T1dHWUZi/xUTzLKLX8Z6LRLhx9ZSN29SvtwMnRgEpFMIZylg2aXKmG+2QTDIjScCuu9OnnQEJTeSY/54RMhkOn0J0s0JZGDUdzTeT9eNHS1svtCw+g44Ea3vnIa9Z4Gs1olOMB7kE98C9eDjC23+w27IEyguv/4O3s1RaY7jZmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnyN99tuUkq+8UFEUcxDPiVuAvvaR4yE5WIQ6HBUBf0=;
 b=X3hlDaKGUks13guk5iY5HF7t8GvHMsEvm7T7yZHYAq1Pm1+QpVkGOUZLe+6HfYMtZA6os1iUd2cz3yXmir4xB052v+RjY0T8DMbmiq4sVcfeyl9SUe9eg9xL7Pt13rfyyPwUECV+C+2KCsjlkzx+vCsUoiGEFN1GpgwpIzxgYF9lzkOtZ2JY8HS5zBUDbZSqPwS6wKkuP8Rh2JrZTG4A4BFJ1EYtCa30c4eBMdwSZprZUFJYHcDCiCPhA4ABaCGAv0955LyeR9GYNHZz9bK5M7Vk/mcU2ybWbJurBhrKk1c7VB3Qpj8Qs/cWByvPB/TUiC2xmenBlONhSU1ZCUEp4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnyN99tuUkq+8UFEUcxDPiVuAvvaR4yE5WIQ6HBUBf0=;
 b=DgrBroEyqOwIeeTX917APMUdH0m44jrGNJ4eT4EsDq6r05dgO6El6MgtnOoGYaq3RBE5QjcHvVc+OfhvcfG1OLB0CoC14zCCaRDixOoVbvGxzKywvdh08DHhGFm824GBogsxXt6dXdNM8AIKnM53NGTCjRkZzixAqeo3MFSSynKAWEQ3gR8VeMC5k+1ZcA3mw5dencbQ+8yXbcuxzXh7Da/Ig39t4bnkbtjoHJUiSq+PHKRNZ8LsMICGTE7MbmirNUWVWPobGetrkzUPi4og/zR/qqVAh3i0J3K6Bgp4wQAHtKRLA5T93KFELAJBTGJmLF8//fi4Bnpl6aIyiyPcgw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6978.eurprd04.prod.outlook.com (2603:10a6:208:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 10:58:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 10:58:26 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Pengfei Li <pengfei.li_1@nxp.com>, Abel Vesa <abel.vesa@linaro.org>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "abelvesa@kernel.org" <abelvesa@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, Jacky Bai <ping.bai@nxp.com>, Ye Li
	<ye.li@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Frank Li
	<frank.li@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] clk: imx93: Move IMX93_CLK_END macro to clk driver
Thread-Topic: [PATCH v2 0/2] clk: imx93: Move IMX93_CLK_END macro to clk
 driver
Thread-Index: AQHayGu6kynBhnOZXkasZ/WWCBKKBbI+M0SAgCOvgICAHAJFgIACkAEg
Date: Thu, 10 Oct 2024 10:58:26 +0000
Message-ID:
 <PAXPR04MB845917B9D27300AAA5FF3AAE88782@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240627082426.394937-1-pengfei.li_1@nxp.com>
 <ZtAeGWtJDMyTVkjc@linaro.org>
 <Zu4Ng6DAYcQHCqPJ@pengfei-OptiPlex-Tower-Plus-7010>
 <ZwWMX66RCfxzCkkO@pengfei-OptiPlex-Tower-Plus-7010>
In-Reply-To: <ZwWMX66RCfxzCkkO@pengfei-OptiPlex-Tower-Plus-7010>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM0PR04MB6978:EE_
x-ms-office365-filtering-correlation-id: 07b5b516-759d-4506-aecf-08dce91a7771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?h+dVXkSZai64AykQ24W5p8eUTK54qnuFyV35U4Ro7woSuk65REbNwHwri/M8?=
 =?us-ascii?Q?RTB0uDcvZ4lZSK3yoB9sr7RG9dSw5JtdMiBpt4kYOMw1ZGkehZ8o2pW+2zOJ?=
 =?us-ascii?Q?vyLI3Hp75kvf5f9HDEXRYGAy7dxNSgS1Lmk44P6M5S6gwwkY0+yoN2lxRh8n?=
 =?us-ascii?Q?9i8iZG/K1Qn+iHpta06iWNekNN7hnp4yehkarpRh0fG+/wKxCUDw9MEzvGKL?=
 =?us-ascii?Q?hOvZwEZQleqTrqHX4PqcftYLqsBf5l63SP0/hGywGpHwHsWvoCOu4pm+IiGz?=
 =?us-ascii?Q?eZQyrvJkAlLMBnnakcM2dj+z+o+em258Tn1Qe+VnCnqEuJ02eCviu/YCDpq8?=
 =?us-ascii?Q?usevUNi2jmbudwNtQDuX+pqDOUKKnnh6zXIfIOUAL17EsEitF5Q725DDEpyp?=
 =?us-ascii?Q?bP0NBZSZDtQuAlbnYfm8EUlujHBjQiHPtG5HGuhNIdN7BHf7j4iG6XC71AJ1?=
 =?us-ascii?Q?WXKu94cItiuUnRrj2dNA04AXpyv5WT1YDcHygIP2Xm5kKSdPdW450u/AxHBh?=
 =?us-ascii?Q?e0iHJFbz6LDVUXZPyDlJgvCaPqh5vFT/A1TvNTMCr4Fif/wQTEDet12yBd18?=
 =?us-ascii?Q?yBWttR/qI+5Zkx3xiEZtwHvZnlVt+xkVD4zNe0/sgeZtlj2TsG1+98nziUIS?=
 =?us-ascii?Q?GOUUpScWmII6jYaQgFQndcShVjSA19Embw7ebVgozHfloYsY6EcH1/cDJeTL?=
 =?us-ascii?Q?TC3sQjruNIF1/chS7q9DtzO+MaM2oc2ywKgNtLRfa4PrnU8q7BCx5IwDecpn?=
 =?us-ascii?Q?YnCU2iwVo+ANuO4p14wF1E5IcVRwHyOLWs4JphLmXcXixSSlHlSU2cIB2dnW?=
 =?us-ascii?Q?mo6AiC4mG5F9OBKaxM3RyzPs4Pd3gMixVLrTc6gLv3AMUfBQRTpXuFXOZwYZ?=
 =?us-ascii?Q?F/72Hfr2tZd29BULbGiHslAlM01xJ+AeMhrYjOhRNCvHMUHYqB8iQcz+hf6d?=
 =?us-ascii?Q?IdvidRg+J31lPUHiAZ6lSfncfQwfdnUmoaoWCpo3DH25YEOaoIvJ3WaI9dNY?=
 =?us-ascii?Q?EJfe1CLUGFNMny7sT0dMB5K2iCh7rEQBCkSVAZyW667y2HpezI4XP6bSONGA?=
 =?us-ascii?Q?nkKISwTjXeIah+MNGWCzjQKQPNAqjYZZsDl+tKp6TSylmNOTm7pKTSV/zj2K?=
 =?us-ascii?Q?BmG6nSCXVzb28YRGB6boGNTdywvSqnbjbWBejNaUY/tL6aOr8Pvnxm29Ou35?=
 =?us-ascii?Q?oFoF3ZOOrLckcj9RB9tEYVqx+ihGjsHOHmaS8oF+k3Du6Gl0sduLqNEiFaEJ?=
 =?us-ascii?Q?G8MMoRTjQtpdu9EnsnI+j9RXa6gHf0Nd9Ug65wduRDBrGPTjHCW71QCcmk1z?=
 =?us-ascii?Q?q5KgnKg7gz7QnGse/AV58Qa5KtvjlRc2+/HodNFyqAPJqQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2fFm/UcWvNV64tgAqTPq9PBP8NVeKXcgbOIYxn5LYlgf3DC35Y7TNhf3w2cq?=
 =?us-ascii?Q?d+WEtkeMu8r4pui1gJ77jkGAQ5Rhv1AxZKqnee3dbVLwQEseKcdcRBCISOWX?=
 =?us-ascii?Q?S8wkf/jl5W1XqSLaxt2DGrqkhnLt4aU2RhOEpaU57dFV9n0MQ6e/U/ApqwEl?=
 =?us-ascii?Q?/DtLmIR1r2L1jlkI7k9V0bG0+ZsI8uh4G1/O/Xe50McTeAeih4UPDZyBqChb?=
 =?us-ascii?Q?V8FHalMXulWJ9VMJ0N8UJAw8Q7qK9dGw4s71hriq0eZMmiSOtqS+965cs5qT?=
 =?us-ascii?Q?itXo2Eul48B4SWyyctN0JK2+nydG/DoG4XLU4JrqzznOIQcngB9aHId5MJhy?=
 =?us-ascii?Q?z0TcqIL5HQ8gRJiT6mMSSNu5oREcyKLcd5210YCQvliDou19jmliF1ICsF8x?=
 =?us-ascii?Q?/jiPx1ZJQzNjMYZN6ais9w/y/AYtWyRARoiXZ9YlLGe+fxQtBhouwbQ99nxr?=
 =?us-ascii?Q?8AoA/VJKsEqQPiNw52WCL5DvNvKjEA4fAO1xmD5+IBSCnll+PY5gN+Am/pDy?=
 =?us-ascii?Q?9zUAknv5v2kFRt+D5w+/GS9VgJbT8joonAVFGR/SrSuu0WbRHeQYnBVMiiom?=
 =?us-ascii?Q?1nSw+9Spx+SUfkLRB7QEA3Bqp0xvoR7+EuWzD8ZssGbznvPr9H93HItfcfwl?=
 =?us-ascii?Q?EaK2eyPMlxa1qxNhz8AzJXph707quJqley63QVuB3NJg2EG20uAYI6L102E5?=
 =?us-ascii?Q?pfd0V+lJNKvqYKm9b2NhEPDICHK+WL3cmJQOrrzm4tPKghohSvYgOICi3Ayj?=
 =?us-ascii?Q?YWM5SXDkg740JfhK8ogg00t7oWrqnxvMaQ6DpWFT6Or4ghesUB+6/WGV0U9e?=
 =?us-ascii?Q?GwbJ801qC8X6INxaihAoD02oD2OQ59hTskcXXIXSE012ZGnBk7GB2DVZStyo?=
 =?us-ascii?Q?ls1aeN4dgMkVbi1PLBPYdpSWOJNuBRRcic7Z6zKVvjBciZKsvw8z7Hqxsv1F?=
 =?us-ascii?Q?csvwyMy+jmGrFMpkaYez65izSl460rasG14ZMbRhSdpx7fIg9mvAUcKlMOnd?=
 =?us-ascii?Q?HwEIe/pKVBDSPzVCpoQvZTbrWWVukqM+oymIoeJmZ6NTYwrgj6KZ8T7pcYVh?=
 =?us-ascii?Q?dz7g3p/o+A0K8jPoDwu2Nhd3f3KHgcePVcLyDPBrKCbiQdYKUEpjeN6HEKEF?=
 =?us-ascii?Q?zQoDBJZBuEEZywmIcBTNCI2Q7yfetaj62vv6eL6pjBNQvOQOHR1xy/12AESH?=
 =?us-ascii?Q?A9rkcUdf6jv4XvrgdoYIsIP3+JWjjm+TkmaCL5CSBSnTgGButsEk9GObi4D3?=
 =?us-ascii?Q?kbn4k646g62TRX5rT3EtHtufRWm1qJloYOBgKyu+znTde6JBW+ge+X/GiT2Y?=
 =?us-ascii?Q?Rg2Of5nvZ75ZcbmWeukIvROhA9y0G8AM9W/9yIRNHEyoUtGKNP6+yVrc6czL?=
 =?us-ascii?Q?xMlaBs0R8s+wN0AeCB4mCSw2bhbG9exQ8zkECS3WAuL2HVof1EYQtDwt4UOu?=
 =?us-ascii?Q?blej39maAmbJTDMIVjTJLHSP2bHXWLTXv0D+9+n0uTZigSvnmFUHU5FnS7az?=
 =?us-ascii?Q?gE0Mk7Dk8PhwQZPfh7WXEnXAsCoLOzNx3uvvr2kkVlwwxyNXY2MwjkxwI2s2?=
 =?us-ascii?Q?sXNlW5Rayw+Sch6KYTg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b5b516-759d-4506-aecf-08dce91a7771
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 10:58:26.1621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNjdop5cXwhbz6xWdzwtKctkihu9IaffMFkqanRNqDilnVKktNcJwno0cQMwvNcDKBfaRbyEFkE0cK86mz+ECw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6978

> Subject: Re: [PATCH v2 0/2] clk: imx93: Move IMX93_CLK_END macro
> to clk driver
>=20
> On Fri, Sep 20, 2024 at 05:04:19PM -0700, Pengfei Li wrote:
> > On Thu, Aug 29, 2024 at 10:07:05AM +0300, Abel Vesa wrote:
> > > On 24-06-27 16:24:24, Pengfei Li wrote:
> > > > 'IMX93_CLK_END' macro was previously defined in imx93-clock.h
> to
> > > > indicate the number of clocks, but it is not part of the ABI, so
> > > > it should be moved to clk driver.
> > > >
> > >
> > > Right, why?
> > >
> > > All other providers have been using the _CLK_END from the
> bindings
> > > header. What is so special about this ? AFAICT, nothing.
> > >
> > > > ---
> > > > Change for v2:
> > > > - Use pre-processor define to simplify code.
> > > > - link to v1:
> > > > https://lore.kernel.org/all/20240625175147.94985-1-
> pengfei.li_1@nx
> > > > p.com/
> > > >
> > > > Pengfei Li (2):
> > > >   clk: imx93: Move IMX93_CLK_END macro to clk driver
> > > >   dt-bindings: clock: imx93: Drop IMX93_CLK_END macro
> definition
> > > >
> > > >  drivers/clk/imx/clk-imx93.c             | 2 ++
> > > >  include/dt-bindings/clock/imx93-clock.h | 1 -
> > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > >
> >
> > Hi Abel,
> >
> > This is a modification based on previous comments:
> > https://lore.kernel.org/all/20240604150447.GA604729-
> robh@kernel.org/
> > Actually, whether this _CLK_END macro change is added or not, both
> is ok for me.
> > I just want to add some new clocks to bindings header.
> >
> > BR,
> > Pengfei Li
> >
>=20
> Hi Abel, you are the maintainer of clk-imx93.c, so if this patchset is ok=
,
> could you help apply it. and then I will send subsequent patchset to
> add some new clocks.

There is no good way here. I think you v1 patch is fine:
https://lore.kernel.org/all/20240625175147.94985-2-pengfei.li_1@nxp.com/

Moving END to driver indeed is a bit weird.

Abel,

When you have time, please give a look at upper v1.
I not find a better way to drop _END from bindings.

Thanks,
Peng.

>=20
> BR,
> Pengfei Li

