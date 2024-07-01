Return-Path: <linux-kernel+bounces-237116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB62691EBA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 01:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DED1F222A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA44173335;
	Mon,  1 Jul 2024 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZrleqRSL"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A138DD9;
	Mon,  1 Jul 2024 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719878141; cv=fail; b=Fmenh6d7tfGgCyGqog+sBU8K9vvcXaloNfb2xZMnUyAuN7q1kIyHdh1ZOCi+skgkb09fvgZ6l07AV+5CyUpw7RnssX8fR+UxDxdJFtxuwo58LaxVVRMgfA8Ct7jE1xoNRS9QX8mOvD0eKNCUC+ULD0bvaxDHFy9f3wwAuHukrEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719878141; c=relaxed/simple;
	bh=tINBMyYrZAU/cUKViS4RxTveR3hY8xJ/cuPjh70lJjE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G4XP2b4qz/xph7F9dzad9ocXgqwRKjv13puIaFA9WP/8NlRVoo0mcJY5zkEYaCxGU4dypVRzmtXJgJzEs/3mUM/zdbluBoUQQLIP+stwWG33FwNtfj5cYgMMO1wsPiXIGOAouV/cRjvtlsey1Owog+9mSIDPrrVgMph/bKUPTbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZrleqRSL; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdswFfr/hmE7n0Vxe+l8MWUXDlJz3MfMxALWyZ8hiLIjEfRVGHbP7A81OpraJihl+knPfuAwBqXTHDu5eVYoHJMZa/lpNLJm4mX53j4gMVpjXT0ZmekJjTq7kig3M7rSIK1W+jzhoDmSshjSvPQaOsa618/Wx845dReusH1A4RlrNYIV6DynCqKMl48BPZyhI/ZBeWXZktRM8nve7eTV6yg15xlWnbdD/6EGVhUWlx0NsbgpqeCBxd68c+hUoZXCZ3kfxGOV6EOdXqkO3qNSRqDYTrTzSzNfiyC8XZm4WjMobW/4qSWZ0DCp7aKMOUAFnkdHdwCSG7yL4xmhcel9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/9houyJfCN6MOXW0NX54j3foJ3ZH+RKWLFoLEclhOk=;
 b=mwDlm8cb+0MwukqgyMioUDRAlDDH5etPi8S7tXEHQAu2jrxkTaAtLXUCVMQ+Hyy1xXHpyw7rgJxeDUcfqJeUxLYMAF6DRoChhRDBVv29ZF3DaqeGPRA0ORxMFiYOMPKCkJfWzQ2WM/5lZm4uvfPznYqifB9UcdhkM26qo4PONMm1S0peWQQVVa0B3qE8sviILhhI5wEq6UhHg3Fc54go3pNeSMvSXgTuU3QgQJPhXDWECjoaC3To/CPgAJQI5dRBSDzloXrTVgL0J1zQEmPpKCghBkgjDOrG8hi0yU264x2LuxmYSstO7sn21owrMjhcbiBHrMIRjA5mBpp3bo4OZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/9houyJfCN6MOXW0NX54j3foJ3ZH+RKWLFoLEclhOk=;
 b=ZrleqRSL+SvECTG7kgGsImwyZImaIh3zWcKn30q9UWx7kRxzXkVD8djzDpWEbiscAFRK4YSKFX76N7dlXzFW9y4fyYpSG8rbTgClDoJ3u4zqjvzAxDTJiQpwVBqTKTnGkMyJa+2w/x0sfIv6RNrN7IRAc1iGeRkCh6MxLnPlWuY=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DB9PR04MB8364.eurprd04.prod.outlook.com (2603:10a6:10:24c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Mon, 1 Jul
 2024 23:55:30 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 23:55:29 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Diogo Manuel Pais Silva <diogo.pais@ttcontrol.com>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "EMC: linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx8qxp: Defer instead of failing probe
Thread-Topic: [PATCH] clk: imx8qxp: Defer instead of failing probe
Thread-Index: AdrLqtcnJw5WiRwIS5yj3rdrX17wMwAZwsXQ
Date: Mon, 1 Jul 2024 23:55:29 +0000
Message-ID:
 <AM6PR04MB5941651E3920794104B3D24F88D32@AM6PR04MB5941.eurprd04.prod.outlook.com>
References:
 <DU0PR01MB93828B0E6808E33C608BC0E29DD32@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
In-Reply-To:
 <DU0PR01MB93828B0E6808E33C608BC0E29DD32@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_48ac2777-9b6c-4bb5-936f-abd66d5117c3_ActionId=0780da09-e070-467a-9fca-39c6d5ee4255;MSIP_Label_48ac2777-9b6c-4bb5-936f-abd66d5117c3_ContentBits=0;MSIP_Label_48ac2777-9b6c-4bb5-936f-abd66d5117c3_Enabled=true;MSIP_Label_48ac2777-9b6c-4bb5-936f-abd66d5117c3_Method=Standard;MSIP_Label_48ac2777-9b6c-4bb5-936f-abd66d5117c3_Name=TTControl-Internal;MSIP_Label_48ac2777-9b6c-4bb5-936f-abd66d5117c3_SetDate=2024-07-01T11:34:07Z;MSIP_Label_48ac2777-9b6c-4bb5-936f-abd66d5117c3_SiteId=5638dc0c-ffa2-418f-8078-70f739ff781f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DB9PR04MB8364:EE_
x-ms-office365-filtering-correlation-id: 91c80a49-3fae-4678-88f1-08dc9a294958
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nsx68a9R0uTWHSLEeEtBmLjYyO+AO6k8n1hlm3izUxXibLHDBbMpzCNC/id1?=
 =?us-ascii?Q?f8L7euIdx9Z0uVUvfGumxBEIZaA2kmmbD+TqdZk9d5dmWaCuWAU3WoB7Bsoi?=
 =?us-ascii?Q?sUhtwsVzW8x2WWuoKmQq8DA7XSNN2BBAiDHKQno9tFMiUtMvZZljm4we8jTy?=
 =?us-ascii?Q?TD96lxIWyR7yMY7wfhCoyv3PamqC1+qFYobxOSZDdyNC2hN1hcVFpeooNaxW?=
 =?us-ascii?Q?Y8xOdbKR/7NmPI70Qxovwd0NIOLM/1kcT6aOnNNAvQaFbA9ZCkHuB9PDHoDd?=
 =?us-ascii?Q?89DGjmCfbNlwTGHFhJgJGBsfl2Nd1lkVB9JWVdL5weehJO8S+fDGGKBTAIJS?=
 =?us-ascii?Q?2efvWqIsn+I1hzMNbVvLv4LHaG0dhw9ySoDe7zwj+LML2bzUw7qFVJiO7ZXf?=
 =?us-ascii?Q?1dZNP7gheCnNsQHVJEhWcIKLqCQOHfyXceEj6Phx+Qa4y/DuZ8vVa7PGxATV?=
 =?us-ascii?Q?Oso84z+jGeI62jIiJmdkMve3YCyigvG74x/hD5rHBK466WCE3fjLvWPrWup2?=
 =?us-ascii?Q?6ZZXnFdfoQufymFNBE9QD8f65+PEC3WDtBUABJM8SMG5+dW12hGuAkTwlqkj?=
 =?us-ascii?Q?bGIpNKW6GQJgmPA49UI1s9ZGI4UznkLQe6kf/I5KSYsQjD7GZeHnqFwjv0TK?=
 =?us-ascii?Q?24nEW4bgelGGjGVCqBO+cFCHSiMeKZXr6vkKW1aW1JT++3bGqK2m5vz0njdA?=
 =?us-ascii?Q?A0pQ7CSajWrfI9vnH3DwcVyoXqhM6/jsrNE3mg1TdGkv5zh3wUAI17kiNjeC?=
 =?us-ascii?Q?Ezuv2zjGNvyjclUwxK+/+X8TbGxixrWBNaO8mm9XrrU66qkmjBkI8Qugm859?=
 =?us-ascii?Q?nTEHmDNZlJ2WeajqjQigeoEGMFBOmOOe3GoZ2LNsVhCMf4yT/XwmB7aEcHuZ?=
 =?us-ascii?Q?PFJO/wP/Em68OcpwQ80oP2m68N71TvXsZQEj853LR9P+JVxavXZtZJhby8vY?=
 =?us-ascii?Q?RA3pUvgH4/SMFOHEr25VNHqRaV21S+TrmijY5ca2MDTQGlLoi0mh8PMC7DCp?=
 =?us-ascii?Q?qSgyKUyMB9JXiywwolSvsPG4o8SVOgaqZeKdGqVKdRuk+CgiO0XDNBv/N36C?=
 =?us-ascii?Q?gFqioPzQcTgKQs+oHEkpdjM9OI/YSVnKBEdUt4yKj8mRuxkI4OeP1FQLW1wR?=
 =?us-ascii?Q?va6uzQ5THk/0XmzChUmyum1QIDXWuQvAQ3b7c9fGBTQFV68Gc5e3wZ7griT+?=
 =?us-ascii?Q?mynxBkVWbKsBViE7YGESETtOhuJ3KI7FKHVDiTyafAtnQ6q+ThQhrbmkNDxK?=
 =?us-ascii?Q?OmT6MXI8xLxTfDVMoxY3egqNvbW1Iq/yq3/yj4eDSFrDbv8Osj1X4AdvIcSO?=
 =?us-ascii?Q?pwbWISG8Xd6mwRdvFUmaLIPE/l6W/aM2sZgaufrz69FvjOb+SX9IqYHqV4oU?=
 =?us-ascii?Q?t/4lfY4Ki3lFiq6si289zUEEGJvSTlah2RW7ijCLw2PJGKxhBysr1qdHetfc?=
 =?us-ascii?Q?IUVDkGhEDFA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rPxIKAeEL/pIDYjTXI+zBB4y+CIwkBqbiRXQ6ZvZOaIwiXZrRfbnSjOkVWTK?=
 =?us-ascii?Q?FaCBFfSWjBok9V8M5CI4hUZImJillMcvTr1z6JmUUiRPVxbPS3Wb7FQoDYJr?=
 =?us-ascii?Q?RyrmRfoJUEnyt0mKvHjROuZmuDu8l8j1vKpsWic8uo0oJWl7fFd8CA9+zLyJ?=
 =?us-ascii?Q?ORfEItrcZ/8kli0VYS6dp2BX7PzqtyAx+ohQTrkq91svF8PEcY9Id6ec9Vbu?=
 =?us-ascii?Q?oX5Nh1koLmKgWyhujrbbUobt7aZFnC+o7J9RR6SyPswkXfPj3oF+9ATzWYVO?=
 =?us-ascii?Q?MWwr/2u2i+kNmKYMFdbEVGQ16g66il12MEJcPuM/XCDPgsfjPu+LfW9PssU4?=
 =?us-ascii?Q?zywhZX71pX8qP7EqpTeZAq1YCuQOpJgu+hSENUB8npDB2ThvoBY1LKEVDNCv?=
 =?us-ascii?Q?TKpDahvWb5JEnCfHj4M42gIGQypR1ihW33KyI7ebxs/Vp2Zi70I9za3ffWsI?=
 =?us-ascii?Q?cANSfporvo0fGLzFIOsRwKtPTyD6zLmvPSRJtMpgs0TTx5FijVNjClHky/1T?=
 =?us-ascii?Q?QKFqNRnqgEx2XKrWZd30y9F0o++TPcZFGSo7/hMqYbKalFXBCNxyCViX15Bf?=
 =?us-ascii?Q?YcPPqSbylnlx22AQw4diK8vZr2dBMztrY2FZ59n2G5xOQLnaNAp+TmD7ECA+?=
 =?us-ascii?Q?c9SyUzFW2DbWM/STZVIzzeXzKd7igP6otsYzsQeEGlTn9JWqL5P9lqkyeSm4?=
 =?us-ascii?Q?eaKVTQrHNHeCC668H4NBGcP7w7lZfKtz8OtFKU4AOSf44Pc6AS49zrV+0DHh?=
 =?us-ascii?Q?9KhEMPvpiSE0DaSKiNgAtknYY0VmEfbOhAE1+tvSCse7IBgWXEac65RF/4+P?=
 =?us-ascii?Q?Kn9LAAfeusJh3RNwlCC0IQTzGK+ZhzRq/faqHG8E6SF0qh3CtsDALT6md1ad?=
 =?us-ascii?Q?F4u0x2bGjrYnif3H2KILOU5bsmXV0RxU59eOTz0q73IXn8F8If2Jn4wON0aK?=
 =?us-ascii?Q?t3+K+9M1lhDZCs5Lp8viMYgTVrBq9PuhIAKxIVaqlidPDZxdifUlEgYj1Vl/?=
 =?us-ascii?Q?JLrNy30ITEdRPgPGMckSmAb43VawgRGClP64jNOtxvEfEoVTuj1Xi+WU5+ux?=
 =?us-ascii?Q?2c+fFt4EE2aEe3otj1wQVMHtIJXeoK+o1UDHC7BcNHnyY8LmQV4YJEdjE4xj?=
 =?us-ascii?Q?eZKYvhU65OKvjf7s021hQTU2dJOMf/sv601P6Tb3+VRmkeH09NPoKlX6GDNI?=
 =?us-ascii?Q?hvxtrnna9HBgX7dXb68dWwNiZMQPpY2VrXOBGr3j68XMzue4VIh1FjYBS07H?=
 =?us-ascii?Q?mL4nB6NyYu1D5ZcsTKbvzQrkoeZUI+TwFSQ1VcQNdKCjpR5fg71HBon0uHv/?=
 =?us-ascii?Q?nKdmqYwOZnhP8+7Nt4nkpKwwSMQEOBR18UtwQYZYafwHLkKyefcpv1rsG/ts?=
 =?us-ascii?Q?3yZIuPc0w7wsiA3B/6xspdEhGRPVitPULULx0f9gcg3ANYXuHJHrj1smdrSX?=
 =?us-ascii?Q?2RLweIpWO9svrslOoHqZS/8FoaWstxSMu0pj7bLpJO7qyNtOnX94RdkQfj5i?=
 =?us-ascii?Q?KdK/6o9mdety2Ir6f2JQjtrCOAYQaC+kaEFi5XXL/9uoOlawDtooLFgO62eh?=
 =?us-ascii?Q?PvI0mqk0SfQ5jbtJIPk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c80a49-3fae-4678-88f1-08dc9a294958
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 23:55:29.4538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDjdZEKt8LOF1DESoffPEWS3j4ep1Zh5TjhUDAdnCpgutbMhizm656vLGLhcaFbpqyInDhksKkcOszH/bAxiCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8364

> Subject: [PATCH] clk: imx8qxp: Defer instead of failing probe
>=20
> When of_clk_parent_fill is run before all the parent clocks have been
> probed then the probe function will return -EINVAL, making it so that
> the probe isn't attempted again. As fw_devlink is on by default this
> does not usually happen, but if fw_devlink is disabled then it is very
> possible that the parent clock will be probed after the lpcg first attemp=
t,
> and the lpcg clock will not work.
>=20
> Signed-off-by: Diogo Silva <diogo.pais@ttcontrol.com>
> ---
>  drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-
> imx8qxp-lpcg.c
> index d0ccaa040225..520a05ea0bef 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -225,8 +225,8 @@ static int imx_lpcg_parse_clks_from_dt(struct
> platform_device *pdev,
>=20
>         ret =3D of_clk_parent_fill(np, parent_names, count);
>         if (ret !=3D count) {
> -               dev_err(&pdev->dev, "failed to get clock parent names\n")=
;
> -               return count;
> +               dev_warn(&pdev->dev, "failed to get all clock parent
> names\n");
> +               return -EPROBE_DEFER;

Use dev_err_probe?

Regards,
Peng.

>         }
>=20
>         ret =3D of_property_read_string_array(np, "clock-output-names",
> --
> 2.34.1
>=20
> CONFIDENTIALITY: The contents of this e-mail are confidential and
> intended only for the above addressee(s). If you are not the intended
> recipient, or the person responsible for delivering it to the intended
> recipient, copying or delivering it to anyone else or using it in any
> unauthorized manner is prohibited and may be unlawful. If you receive
> this e-mail by mistake, please notify the sender and the systems
> administrator at straymail@tttech.com immediately.
>=20
> TTControl - Internal

