Return-Path: <linux-kernel+bounces-322235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDF97261A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3283284A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2AB182AE;
	Tue, 10 Sep 2024 00:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ai5JERTa"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF2AD31
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725927480; cv=fail; b=qzFh9WrKkHYD1R2VyNcMlczrDQAyxipasLvl5UAALtqmNMqsCFgQToZ/4l1FeLaVwzazNKEmzh87aoIfknN82zpEukzEugOcO6DpIWrlhUxP/+jXuBwJObXRFC5VdPw5bzsxd0PONcTRg4vLrpA0pvtv6svDGroIYSg+BMED/cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725927480; c=relaxed/simple;
	bh=x6H4p6S8kLE1Y8pKG0Cw7w+/i3YOm1xr3qcouHBGoPs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rd/p+QmMaO3OMjqMhbcRcpN6aZuwS84iI3weJCnxG1m1jTnsXWaGLG57lRw5Iba70pzyxFLzZVZoSXS64xHqevK3PUkwL8UtcJhgdygkbp4U0n017fW4A7AQ7Vs4gUHUQCqGhAfAyEsmGL7S7cWt8A6zNdgoCi4QGitwtF/qC98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ai5JERTa; arc=fail smtp.client-ip=40.107.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJVGO7DxB6zKEbl3ZY2XX3jl1cKFUzfgZBYmV2TpuziSUEKC3yU95KRrFF/KYGWy0i6C0Pi/qhN1gcpHzwPhnKPsvBNs/90sRDL7Ub2yTbPq4akN7oUIHRWKNuD2Tq2e/QIoVDK2Gxt0LvLlz0XxEcn/uCrpDN/YOuqz3Zpl173J0oAoXIZ8C7en9tndtbglhBS5zhVaQ99O96a7fMxRqgrlb8dAUVhxmtV/By35QwTD7iAVroFL3rXJljFyoqrZNyO2DRBtbo9EL0IeaqEUZRM8FSSuDc8WP2UvQsNxb8iuHHRuczKgvhKpUDJL5UNlX7Q4PWh0pPuuaZQgtfhxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+0IRFbSnDxB0AjD+tcOGOUvKKvkRnLvC3XG/ulWL8M=;
 b=Dskg1+OnTTVC+j8OS3uj+L2uLNOJJiJyu8/FUvE3ukei2xZLp3MafhAeZkKCJcE4BppNAzbSbiA2PBDQ9jn2JJy9oJaYESys7GB9uATvccHsUgGO4KPzJwStkfrcAdGLQ8wXlSI6lBZS3jWyw1ZhlrJawD0+Z9Dxklq1QBu/ZT20pz+z5g9J5BKgz+fQ9WCxfINdpgP7Az9QvlX/yns9gFUh25hR5FPUSDnjl21LlEJlMqUJsirTmi0C7QhI6io0wiSLotv/gkNFHyEZaYhJjQj+D5Rt+GcLOlKKDoPKlWvsxHI9HK14h+JIycx3pdKe4W8xbpHMuib5CXQ36oyWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+0IRFbSnDxB0AjD+tcOGOUvKKvkRnLvC3XG/ulWL8M=;
 b=Ai5JERTajhZ4DhEBg82oGVdDezsiApYq8gctrmtU6htkQb/TT2B9Z9iDrHvnA+bsRwt6g4504n83L4kcKzNAfY2Qo5HS3uiDnmWXZjImCkk4rhQdxbIzbE47CPcLRrU9L4rplBOjdIXXVOwLkIkRtvxVcZup64fU5JjgRoUvCXD4zUaJe6G/LmbOVleqwd1lxpmf/Fm4YSlOsH4BlnqYMRveXoegnBgKUCVn+jCfdHHxknTtXep21mWGXLgT2/aQ9YCqFH9YCmR1ZZ1ajjknAlyIfMerqIja8Nu0Rx2iYsP6R8z4N6pbh/MNbkpBzpEkk6RMe20bsqeAYwSzKrEBAQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 00:17:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 00:17:55 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Cristian
 Marussi <cristian.marussi@arm.com>
CC: "soc@kernel.org" <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] firmware: imx: remove duplicate scmi_imx_misc_ctrl_get()
Thread-Topic: [PATCH] firmware: imx: remove duplicate scmi_imx_misc_ctrl_get()
Thread-Index: AQHbAvcdavEX91qRcEqWPKT0Exd0LbJQJtUA
Date: Tue, 10 Sep 2024 00:17:55 +0000
Message-ID:
 <PAXPR04MB84598499F93BD1708804B2C4889A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240909203023.1275232-1-arnd@kernel.org>
In-Reply-To: <20240909203023.1275232-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB9142:EE_
x-ms-office365-filtering-correlation-id: df6347be-4976-4cbb-0f33-08dcd12e0459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8KOuQvIiVaW7PpBYTtQ4qg55c8K8aoCyhM5h0krRvihrckORRzNBgaN9Uau4?=
 =?us-ascii?Q?l0BvjQPox+1hypSGGZ2o1MxcU+9eUAryRkXLo0dVtFHt27ANnWc8EX2OZ7lF?=
 =?us-ascii?Q?gssbHUPtaO0ehiql07/veez3EgcIoe8SYSw2MSXNhBHAs2FvBObXWpLZSJAZ?=
 =?us-ascii?Q?FWXeBVbySK+zcK9aNBdzI+ruguj5EGabZcFvmHMg9Aj5HiGz4lNqw/GDwnOC?=
 =?us-ascii?Q?VNE0LEa5c+0BRFEMpEj4bux+L0HRYvUWgRSL9Qy2CLMrkH7z0Na1fKRoQ+VP?=
 =?us-ascii?Q?dIq2phL2FuKaHZDb1wFL51E+GbB/y9ZCBUyHGbiMq8EswANwgsvZtm16V6VS?=
 =?us-ascii?Q?TzH0up5BoEaOwgFqD5R2Gn5jtb5LUEtDkkjOb8g+Y83BMp1LaOIIAIHL6KN+?=
 =?us-ascii?Q?CQwrl++wTnSYtAXJAU2FWdmZkW632/lut4e5nMcaRi3K+Db4bSaupH5rg9Tl?=
 =?us-ascii?Q?9sV/d8snD2QdGIv2QBAI+HoUA9TZoRZwAHjs6K7kXQjjv8R2i+KdYqaOx1vu?=
 =?us-ascii?Q?7sXGAb50pYiOBwbXE9pc94tOiDKzZNpR5SynhVRtZI0+gLVNFtwDhdmeICWT?=
 =?us-ascii?Q?D6rT5XQJ+l+6xJ1xWVq6YF9z/ktV2zr6m6H0SIme+m2gtqmwIZYBDQpDeoeg?=
 =?us-ascii?Q?7ul7FZsr2YwDfZyIjKRddziSMmfa06WrCfEDjO5Mua8w3SdOLDw9ag86NC9G?=
 =?us-ascii?Q?h4YQFvrfwGS1Df0Ka/FdYnQJuaLoUgEB65iy95VTbV/OBlOaUxnTA+Eaghrq?=
 =?us-ascii?Q?cZXVUhLoXFEG+YzSaTMWOVlmYDvZyl35lj6VRKVm2xdO8lpmHT1tFjWcWEgI?=
 =?us-ascii?Q?gw3IG7H3qjlLsO3KUS28AVsTBSEPBY5Bh6jJVAvWA2dhDPV2yVKwsMADc0iG?=
 =?us-ascii?Q?DE8Bhn+i89IENrIuzEEpLsHPz/9BkiTwvOY9CrhZQpEa6ba3mB1nNSZP7OFM?=
 =?us-ascii?Q?C7oxWi/Pg8e0SaoHJljtti4Rda6dK3xR4etpiJDlw1Nerg0QSZvSBXfTI4Wd?=
 =?us-ascii?Q?FQV+sUWkWO4ZY+j9MUvQqVA3jBbf6IRntV/on2Rmpi9svad2UmoFB4HINcq7?=
 =?us-ascii?Q?eldI0+8k9HqSInEXaEwj0fgFuTZq99lN7DaVwYtM6jxKKkpWwekkFZYKUWtw?=
 =?us-ascii?Q?BVpAtXE3rUPFGh1HCNvNYdcAwYPn7iJMt9OKqWxEL4x2rXYtLi7QnRE/lx5z?=
 =?us-ascii?Q?H5hkGHYaMdFgshhaf3mKnQsKhhNLi2IHFY03DsGlZPCjM91PWdiRtlQ9jIpQ?=
 =?us-ascii?Q?erF0+2GIYipGp+fMyN/r5JTeteXJ/JVKRWkq+id+vXfxnbzC6ocKk+K8WOyz?=
 =?us-ascii?Q?Dugw47tgXTI5k5Sgjy+yCjKz2e0a+udYQd08MXsYxwSa8efRPA5lo92lIZLc?=
 =?us-ascii?Q?pxsmgrg69tyNyllM0+05bYWVjVk552fJaYQ+NEFMuWNMPwqjXw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PRHMA5nUPQaPbXRt7NCiIo2ni2NpLBAv8G/0YS4mcyKslRxUEWp68CFHJjSg?=
 =?us-ascii?Q?vlmvkAQkndIWDIwzVNZ5pYyOe1tNi4c7PJqIB5igrmfLBddmQsQA1L1OZHA1?=
 =?us-ascii?Q?xMgJol0wtJOHrd5k7GbxEUh8c9PK2ze6JrNB/JiIlqxeR7iNwCf0btHnvJO0?=
 =?us-ascii?Q?Eh4XYTa0bcilOmdKADmtwk0e6RK5/zeA+D1xUcPFXL42IU1/bhwz1t3J46Wz?=
 =?us-ascii?Q?7A17KnTPivHLIDqwm8Rr8ftzH1yf5qgn8YG2dSIEpxX4EWSwLE0Ki1xPUltK?=
 =?us-ascii?Q?M0PpYqEJPgJYWTMW7f7HBMbmWfvej901H46tU/5673IIt3K+z9bVIlELWzyV?=
 =?us-ascii?Q?+k7sINaBA7UCRbn4PtOmppxmP3I4ERkyujzK3azDvuoYG2G8J3ctzwYLjv0b?=
 =?us-ascii?Q?Mk0ar/JHENEdrXdIq7mmQFzZXYPqIpjjOuYzEHr2LLdAGxjhIXX6lnEaeA6i?=
 =?us-ascii?Q?vh83dLtpaVVEIe5VlzcriXeEuvXpJqlKfNsEesyqgoeQPd8uUGZs+S3YvESG?=
 =?us-ascii?Q?IUcrO3QvBrTRNPeXdoPcV55/zrg7dcCV01Ea9PZp3Kig19diebkEzLy48wdx?=
 =?us-ascii?Q?2bCW4IYQ9zBUMrOI+tbZRu5M+mUvOcjE1GWUIMwST5vWYdTQMyUlnGb5YFJl?=
 =?us-ascii?Q?u6045arXXRXA1rL1m16whrNzzRidftTIJb4tKibyv64oVtLBN5Ib60MMsF7r?=
 =?us-ascii?Q?7V9XuHUPLev+J5ZBBeF97eReC21Ra9JSNrMdZmNqi14lEsivOLpcIgPWve2h?=
 =?us-ascii?Q?coAsl6uGqa+u07+/9Tw5nKKDnP715qGPFykOoDvacy3NydBy02X33RTMWkSz?=
 =?us-ascii?Q?4As87Fvg2euplFNUzHyOx0LGGFtCQXG2DBG8xcCl+otkZKciGRnyC8F8w7qJ?=
 =?us-ascii?Q?sH6go5zAGNV1knzdyjEF7tS2TuLN97FVixuI+DCoAuh8uoA+sr9R58DgVM6f?=
 =?us-ascii?Q?+dYK+duJp79A4HWG+dVZjsjrHotp1gqs6QMUUOHED42JGf33HrGR9PYaVAnE?=
 =?us-ascii?Q?QBb33PXN8csJ1ow7+tZ4weokqxlujeU0dtoO6zv7J9gdbHq0ZQICyNULaZaY?=
 =?us-ascii?Q?2QyQxhesOBLj5psqrSML1DjTb5j3btgju+ZOybZpD179SiMng5wcgjPYSXVr?=
 =?us-ascii?Q?yCxXn6CxuWJqrQbZpNuAfuTlNh9Hf74Usp8ZZ04J6u1ArrRNYtDvK86H6fjE?=
 =?us-ascii?Q?1MFyQ6+bwuhBPlBIjmIpJEMhGe1SFn7AqmgNsoFw8aS5QKT70zpZ3XU/7OSF?=
 =?us-ascii?Q?9xne/lxXwsSABpfyuhYAACPy4SRihEx1WwixDo+tWGJuQeCS1cyj9VhcQUFz?=
 =?us-ascii?Q?hKO8gNhQc+ipE9PEo7wMXHH7QRl4mNzQyRB9rVB5po1TSr8f1bz23N4YJTLk?=
 =?us-ascii?Q?u+V84DLnrBYoSLH8Zhm8hPVp7m37QJIvhZXhKmOjfl94151lZAXRSfJVMtsm?=
 =?us-ascii?Q?cT+JRMicyBsk248/l7rLyoIHZE9LtJMiFg8eFO9lYG0Z32kR+nTcFKa5UVmc?=
 =?us-ascii?Q?Avs3u3E37K1aYmwnjEqhERLoRTX4hiQdHrFhWGVbvF0scIM+pCliqoEoJYgc?=
 =?us-ascii?Q?CMrNg3megcHmpb8JpfE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df6347be-4976-4cbb-0f33-08dcd12e0459
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 00:17:55.1273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 97OFtxkpNBlQMKftPwarLAbBk6Z5oYcbVg/SCQTbzOeG6GqZ1zIREA/RiiF6tZmwTS89UlYOY1vmU8ZNMmFlqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142

Hi Arnd,

> Subject: [PATCH] firmware: imx: remove duplicate
> scmi_imx_misc_ctrl_get()
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> These two functions have a stub definition when
> CONFIG_IMX_SCMI_MISC_EXT is not set, which conflict with the global
> definition:
>=20
> In file included from drivers/firmware/imx/sm-misc.c:6:
> include/linux/firmware/imx/sm.h:30:1: error: expected identifier or '('
> before '{' token
>    30 | {
>       | ^
> drivers/firmware/imx/sm-misc.c:26:5: error: redefinition of
> 'scmi_imx_misc_ctrl_get'
>    26 | int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
>       |     ^~~~~~~~~~~~~~~~~~~~~~
> include/linux/firmware/imx/sm.h:24:19: note: previous definition of
> 'scmi_imx_misc_ctrl_get' with type 'int(u32,  u32 *, u32 *)' {aka
> 'int(unsigned int,  unsigned int *, unsigned int *)'}
>    24 | static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32
> *val)
>       |                   ^~~~~~~~~~~~~~~~~~~~~~
>=20
> There is no real need for the #ifdef, and removing this avoids the build
> failure.
>=20
> Fixes: 0b4f8a68b292 ("firmware: imx: Add i.MX95 MISC driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/firmware/imx/sm.h | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/include/linux/firmware/imx/sm.h
> b/include/linux/firmware/imx/sm.h index
> 62a2690e2abd..9b85a3f028d1 100644
> --- a/include/linux/firmware/imx/sm.h
> +++ b/include/linux/firmware/imx/sm.h
> @@ -17,18 +17,7 @@
>  #define SCMI_IMX_CTRL_SAI4_MCLK		4	/* WAKE
> SAI4 MCLK */
>  #define SCMI_IMX_CTRL_SAI5_MCLK		5	/* WAKE
> SAI5 MCLK */
>=20
> -#if IS_ENABLED(CONFIG_IMX_SCMI_MISC_EXT)

Thanks for spotting this. But I think this macro
should be replaced with CONFIG_IMX_SCMI_MISC_DRV.

CONFIG_IMX_SCMI_MISC_DRV is the macro to guard the driver.
CONFIG_IMX_SCMI_MISC_EXT is the macro to guard the
scmi protocol.=20

So just need to use CONFIG_IMX_SCMI_MISC_DRV here should
be ok.

Thanks,
Peng.

>  int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);  int
> scmi_imx_misc_ctrl_set(u32 id, u32 val); -#else -static inline int
> scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val) -{
> -	return -EOPNOTSUPP;
> -}
>=20
> -static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val); -{
> -	return -EOPNOTSUPP;
> -}
> -#endif
>  #endif
> --
> 2.39.2


