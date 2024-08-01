Return-Path: <linux-kernel+bounces-270563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B02B944179
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48701283B06
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA213C9A3;
	Thu,  1 Aug 2024 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iIIlGGlN"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013059.outbound.protection.outlook.com [52.101.67.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8942B9A4;
	Thu,  1 Aug 2024 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722481127; cv=fail; b=j/HLMvGtieywTxj0GxSWWDGrzwWfEdx1tK2HVOeYOEt9CfdbSO+wIsE1MpXjWmdP/O54mH9yhxHEhktaowkLBj8B+KHfRZKTH+GhtEFYwsGxcmoQiuXaoXPnAHTcouXykVJSleBLdOu6hTE9YTQlf7RqKZz9l9kac5EM0MmHMwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722481127; c=relaxed/simple;
	bh=c7pfnwCYU25BHiT5jrYkKhOz99TSmgunLG02hIJz5aA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AiIncUdtZJzIXOG8Ozif/6hFQ3KOg8LUaOrAXbW93wMuNKyInDK8J9tL9qwxMbnVlI3NeD1PaGb2ywb5PkFKvWiOA2wb9lkTnjcz+NBWJW1BNctrtdC9zVTzeNkC1bOJxecdGEq7nYpaspZhUrdFMy8kNwK+SbUnKwepWDbOyyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iIIlGGlN; arc=fail smtp.client-ip=52.101.67.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZksHZDs9vwidJyvH7RpNbcvwU8trK1xnIfu8u7m3ONNAf24I/hc4NSaxfnaWA+RrUFZ0Fn1Q7wJfS8wj0Y3X/7Am5ALQqIvxYtX9zNl6iP395h0jm0fmbMtw8PqfsVQx2pd5dF4wgXM4Ddl1tPm4BhD0vKgWaFFYdJmFxxwX+xTP8GXvW7qY9dYlzY9b3cTYMpOQBu35LqvirpizcGoIuRjO1yH+hDbAz8JfIXc+fLc+IqynuI9YyXdskacQvEVO/Arqmr4j6HcSDdXVRoTX1MlDGZz2XsggMsAm1YgX4Z64Q7kZZHW3TMqnfcTM9C+3VCJopk1gOYUgpF3h4omiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7pfnwCYU25BHiT5jrYkKhOz99TSmgunLG02hIJz5aA=;
 b=APw4VFzsXqo1m4f6HlJXZg3xwMWnn0RN0sUmBWIXAv02RUMcuogsbkWuo2MydmDs1eLn+tTkJBMyK0qYDO2TT3rvVhZ1XtW2Z05LvEA4FeJzLf2h74pTl6Q6IlPY5viSPQF1apWUoSDaH7IjJUhOAojRVazhEj6G/q5JOT7F822MM7mJ5y1h76WLqVr0XURp04fNNgTBjSiRQ7aq3aJ4eAkSBmcIwsd6OA5GMQk02DlEJxlqi4XZXGRgzh3N3EAJ3/4j83WxQzuweS3fKLNekOQM4mrG+iGWEzw0IJGC6OiVOTe6NtPcyHUm1XpR9ggx8yOrNqS0crLMpFAZKGJXvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7pfnwCYU25BHiT5jrYkKhOz99TSmgunLG02hIJz5aA=;
 b=iIIlGGlNd2IFGjj5pbd+bvcgIQrpy6ZFqx/wKKyEFu5tJsoJ1zn4qf2BC8H54+/GTkRNwmMt8Xny/q0sFd8wK3s3s6fO0ASo6HgZck6kjl96fUDiY3KivTApgonCPsVyc+hmus25aBa7BXEgKkIzDRin0UtU7AjniO+e7BBw5tZYNZC16Fnm4F9+YGR/5OnWLwahtFuhY4Blz/IUTB74x227LfeUusDc28asozAPg9zXLo6uL9t0g4yxT/TVbIpBBEg5ZX6zmaFgh0SHpL/WHRPwGb5RJFZ0KkLfiSvcA1NIS39O8gVte2i9llY2J2d6UaMCfwyUyNVp98M6U4MDlw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7925.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 02:58:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 02:58:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: "linux@ew.tq-group.com" <linux@ew.tq-group.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 03/14] arm64: dts: freescale: imx93-tqma9352: Add PMIC
 node
Thread-Topic: [PATCH 03/14] arm64: dts: freescale: imx93-tqma9352: Add PMIC
 node
Thread-Index: AQHa3clnIB76jJPaG0ySGnY07j39JLIRwZ4w
Date: Thu, 1 Aug 2024 02:58:35 +0000
Message-ID:
 <PAXPR04MB8459449FB2EAD2E07A45289488B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
 <20240724125901.1391698-4-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240724125901.1391698-4-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7925:EE_
x-ms-office365-filtering-correlation-id: 5da931ec-c5b9-499b-7a36-08dcb1d5d5d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iabfHB4MQBQLBimDjDsl0ptDIxOJPPQtTd67Icyr5G0H8gkOkYpAtAB4SJHz?=
 =?us-ascii?Q?uMPuXHvZOzNzP/A4+ayJ8GYG3AO3giRJSUe9hMIXLz+pED5Vls/LmxNwl3qY?=
 =?us-ascii?Q?d51khDUk0Rwcwrg5JGz180oww7hFv6naJuF/zcqp1oapUUCWLDVb3Yit7H21?=
 =?us-ascii?Q?eW+CqF+OkUhKz+2sUlvyaBcORGAFSrwCoxo4oCphm8epDe245YZw245CD0GM?=
 =?us-ascii?Q?lEvGQsjHQLp4vPhIorVPcXP43S1A1KrUOzCx/QJaS9v3FfQCNR5GJ6S5LrnA?=
 =?us-ascii?Q?6J0YT2Rv8d5djJdW3SLeLuDCPN+mmhh2YDJOuQYQOc7XWg3lbdXPxWWdfU1G?=
 =?us-ascii?Q?OE8sNo7avuqMJqdiUMRi1oWmF2RI+wW3+TuLNlsrGsw5pgC4Oel7rCqGniiR?=
 =?us-ascii?Q?AMADYn1WinBEXLWoTutg/b7eY+CkPE3oGvEhpRDHlD4rvHI2AqS1mhdQvdpZ?=
 =?us-ascii?Q?pLK5toy5fCSDq4cDn6ZCHnbM37L+PzjxKw9P1Leeh0JnaPEW56QmfGqOApDj?=
 =?us-ascii?Q?m3AusFd/0hPDsQSwRRng5L37G2lApbAXKZdchdShTId2JPYtBfpOKU7GtvcE?=
 =?us-ascii?Q?e4mr0EWRTo4iNXfX8YSV3F13lqDYWaxeMS2+1JE90wjOni804CMgDYb+xscV?=
 =?us-ascii?Q?1qtXPGEqlqdcjjq+Y/0PrRfrlVmrslwdQp2+7Rhm5qAsCXkEkk54jY7yQB/t?=
 =?us-ascii?Q?I4Er2HL7b3cn6H/tpsimbPCeJ/AEPycUw+q5l59FhaNcauaIOw9Y5mpL/1Zu?=
 =?us-ascii?Q?+iUDGenkWMSotEOCVtQQE6UfSkYV+d4b+RoLKoKnM+FanCBOzOMPwngJ0YXd?=
 =?us-ascii?Q?+pf1rCjxP2DZjNf3XIYxa04/4XH84wPORKrAk5Pxh6ANM+yyyG5IqCSseYmR?=
 =?us-ascii?Q?RLYdzc59mHK6wUwvNxnrJaxpxg9XZo8Mh64qglcTQeCUC/PbSvtCBgyG9GEE?=
 =?us-ascii?Q?tLYFmMHXPNLb/uRByaFeBTpof0asEPQKfWl2x7NGUgYLE1s1HvBXGqus37J7?=
 =?us-ascii?Q?WqfzkvWJIrTU+zq/F1lR48mzrM/vSVFniwneOil0ilNDnZj32vYswS+WO9MO?=
 =?us-ascii?Q?mDR5kpdvvSBx0GVirdpmzUz+dvByxsqMWXdjf4qwsS60P1if8UDVcb7x4f7p?=
 =?us-ascii?Q?ZkyrBzRZLHcPHC7kq5KRaelKlFwveHAfAA3Sbus+cNpouu+DzPVns64hD+Tw?=
 =?us-ascii?Q?tz8nsAzxPb32n0C0enB2z7ww0Y+74L0iNvBPoMJEnVRa61o4cJx0speuCOhv?=
 =?us-ascii?Q?UwMrSpSpOKQyAomxg5Hu9SIpc4MA5h5wdmbrg2alhdnkK8eems+kSOCt1MlJ?=
 =?us-ascii?Q?SvjpFkn3wyynv6K5otytDfR650QzhIQtiJO4StexH85Ugmz0Yw7oupMLPIRL?=
 =?us-ascii?Q?WU0v++N0LBBv4xqQnSfyh3o7iUq7FA2Qvbv3yDjktAf3Xt7A/g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JbgF10/73UtPSStCG5pL6BT7F2et2JPlnKNOP6d92/qw6ra4IDVfSHZqTYkK?=
 =?us-ascii?Q?PrQ9YOckcv+oD4iHQu47NRzfkhu/NmWIOJSsrmXNbFqUIRwdNSJrG15wKIgj?=
 =?us-ascii?Q?tQ2JQ2g+L3z3hqxi8RHs1+Q79fCdV5LIFzMcDbpzgoo5LTc8jjPsAFtePRNp?=
 =?us-ascii?Q?pH44iEfAg6iWahnYFknLzhdLJSIP7rLtMbvKH1KtDNRwYdBjRiThtgulpgDo?=
 =?us-ascii?Q?e5MA5akwp85ldfAVsfTmkTHun33xgO0ID9Qd4+1j6Nb9YIBIk1j51T2PwOcL?=
 =?us-ascii?Q?itH/Zhns4d74dcT8nwVHCF4XTWhpJRHf/dkzChhwUwwwBSjQw+PUa/PHZv81?=
 =?us-ascii?Q?DUZgvjPZ+gip2M0pEVEyNzvHklM3cH3axTIMdLsmYzreD2yBiuibr//EIpjf?=
 =?us-ascii?Q?bZdA1BN38l6UPhKKLlcdLbRwCN9xlwEp5ysozozHQeGOgYuZ+BbLpS84EAoT?=
 =?us-ascii?Q?HvDPNFMH8nkcIXqgrMWdNeNG5nAHHsoqIsnPmMPlD1bwA3j7QqC58aaC6d9f?=
 =?us-ascii?Q?pQg78Ef1RWB02488mUW2Ad7p7qKApI2bdNbDU0qxx2iL8e/Z1ZDlT4aHoPu5?=
 =?us-ascii?Q?4hac2X6Fg8OXhtr6IY/9UvJMq7nflMQfxGboulCAc4b2P9ZQq0j+osb+8MM3?=
 =?us-ascii?Q?TrkaqWqo0M6arJ5tTH6chTE2RIAYxxTtXUTiMRsyMwxvrAAulwkPoIZBlUt0?=
 =?us-ascii?Q?WaOD6QSCtcjGzKI1IM4w+QlhsXIDsWOCaPn0+iy5cnImk1oB2ezb807T6Yxj?=
 =?us-ascii?Q?yw3eM6jlRKHGl8HJjAblgsYDsspSefD3vw1SMFBfMNPxOqXzjg9rSNEWIHhU?=
 =?us-ascii?Q?BxBZNb+JmP0TIMEUHnNHNtQHmRgRi19xL6IgLcqNxM41VV867xG38WQ/nsp7?=
 =?us-ascii?Q?nOyLk0Jejhcc/pPKXEwDtTc6WmUr05rWyoj3Ou0iIQk7tni9mmLuCKHR6WOV?=
 =?us-ascii?Q?zp9AiEqXPTbqDFOXYagfbu+eSvNQpIhxm2QII+92xrXcO2Sla7QTYzFHfMp9?=
 =?us-ascii?Q?7aHzaiSu68sRH2wMcM3APb2P83JbTcHsC5dWajNFKs69zEwVTo81dgEwmZtm?=
 =?us-ascii?Q?IYo16z6q0VWSQK4F2K9aiUNzhnTMoCEq7nahv6I0pYM28vsa/DCSNwLqu9MN?=
 =?us-ascii?Q?3XqpsQ1q8MyIhgb7ARZCc3e1jvY/iZr00qOdITcs9OXnSRkcunWUaINRC0sZ?=
 =?us-ascii?Q?NbkDgDLVu0QrYn0/WFyyk5EpOJamAduLZaEQOnwcVxxZyY7pTb0jNR2YpWYB?=
 =?us-ascii?Q?gragKXaEpDwa4FQ5+u2K50uvmNEeaGabb/cJFHI55Dpfyn1yTlDK/r4qpGsc?=
 =?us-ascii?Q?F8WaGV4hwsX9qhKEySjE2vLI1nVLE+r6CrY4kjgs1fdvWtMGR6nbtMz546bF?=
 =?us-ascii?Q?84n/y+krmm4c3ZAswt0fKaC+8aZ7rDnnhzGODwGK44fKbvyKzgLeOFBjHf1I?=
 =?us-ascii?Q?Oub0wbM/PyRe+76RJnv1+MWoNPi9P18oIzO2mWhZY2p5YiPkWi4h3SkvwsNq?=
 =?us-ascii?Q?fEzTLk/AZuGI8JgrWHILq8mgiDUwFvO7NVSWmU/gYVUQxOteIMNYyishHigW?=
 =?us-ascii?Q?BbQnzU83f0WnUjGT/8M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da931ec-c5b9-499b-7a36-08dcb1d5d5d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 02:58:35.3357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ha81BrhD2qpawh9rFaLgpeB34OI4RjIjuqvWueXBJ7blLVOZTfWHlD+N1vCZTdEmnKc3ayE9ce8xc2a0stA95Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7925

> Subject: [PATCH 03/14] arm64: dts: freescale: imx93-tqma9352: Add
> PMIC node
>=20
> With driver support in place add the PMIC node and remove the fixed-
> regulators for rails provided by PMIC.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>

