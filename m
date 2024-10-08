Return-Path: <linux-kernel+bounces-354371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6800993CBB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC9FB228FA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F051E868;
	Tue,  8 Oct 2024 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NkhOyYQQ"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347E2AE72;
	Tue,  8 Oct 2024 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728353664; cv=fail; b=cjAxwVkjODdR7eHcJQjFlmToo+jhU9rcq9zqS4Y6ToWnGyYtdsIsKUkQaHt3rDeCCwl3Xe5bCBAeyNlv/di3ygyOtAIWTdrWRWMqw47XUxyjZVNdibZTdWEirOzGSaNGjYaJKuN+XACjN/w57BnFboHoJK2CEpc1VHJnohwn4xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728353664; c=relaxed/simple;
	bh=cQ7YI9yygp2se5+9UFLXsRmydJFR06xQB/VWK4c3GAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pfQOmjcA3M+dEM3qkcu9vDZifTGOn9m1GC5I+I7t3heUhB8T7mT+3ZYRb+Ic3jyTn4bzhkXyJLOkNVqIJaDPTVf0kwJoUZhYrm5tXNjHArwxiFFpCUS6RddVeOPo9NxtBH4iEhL5jXgGMG2O3KBZG3MuYs2TA4i8tInLxfMm/KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NkhOyYQQ; arc=fail smtp.client-ip=40.107.21.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sG7K0RlqrCpDdhFy9k1F5t+RNV9MYGCkQvcwGocrF7P2tyxwoDU01blYGYPDle+aOhyVeJEKv63cSMTAQocOwaC8/7PSeSHF+teJJBKjhRawQPpaaSAI//5eNqIHVoiLee1m1MTgpShGXR81pqV/C+hR28XeRugfahYPI1uwCl1dg0zTK3PS0MB2xqrsnAbGL3jrtVH+Oj7/uWbIZyZVjL8+Eq4RjOW2drBgCZup3nbstRMFjoSuV9vtmhi/DdT3zhxt+dZXaf4tNa9pMdDWE+gSYD/blrv8z7TiBQ5DRIZlE2ZGy5DcRYB1Y9NRzuWS8GfyfwMcnAdcWL3Rjo/Lrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bivROXw36sa4GUeiF1zftjhCDnG/Gt1m7SYUnQjOCWc=;
 b=KaXKiw1IpGGif/ptU60vDT0Q3sLefkjaHxvP2vDaPdxaipsC64miraWYnu0xHy9HNpE1orEJckOo5CQ49U7lUOrYlS50QnIWkHGAnM4rAi7381Mdj5f7wp6iHSWM8FkE/PKrJtcdRKkvZmKwfsxQZtibEr/eHuBDnvxRdBfJZDx7FrnigHGQY21LBaMoQcp5limioJCcnY4dD/VoFr2Kxsx9Ub/enxiCxfgHrYbB/lTkxx9zDDw4UnlNDkUWcrQJi6M7AvkQn4UpghPl9AyYLSpC5bbsDJ5JUBafgliKMQycRm8dNkgiAE9AIM2qqyRc1ctMs9JYIXYug6NHSdIeOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bivROXw36sa4GUeiF1zftjhCDnG/Gt1m7SYUnQjOCWc=;
 b=NkhOyYQQ9H680TWN55MSbeYbWA+7pKViDjboIjFBlrrImJyj0Eg+F2gx29sMPWxl6SuKtzhXXSLTFEjEEFnnpmKoIvgR9pxN7zG2BoBk5VGWAIJB0SDm4++vFPRBKjfG+2/RXwJZ5MpxT5l/mHOpxoeX8WsCAK5hO0M2qrwMyOWA9LLvvzmWTmPFjPGD60u+L98+jOfD2pDpy4YtxnFFe9oMFDItPgs+J1R30vHUVBAFUNuhCzhekjv/aAxn1WnAuxxmQ+i0aw+OmCv59n15w99as9pE+0Nn3c+6wyesFL3G6GJhbP0DzhR8ulBMaKD0jat/1ruD1p4+xPzT0tHPNw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 02:14:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 02:14:18 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	"linux-arm-kernel@lists.infreadead.org"
	<linux-arm-kernel@lists.infreadead.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>, "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:SYSTEM CONTROL & POWER/MANAGEMENT
 INTERFACE" <arm-scmi@vger.kernel.org>, "moderated list:SYSTEM CONTROL &
 POWER/MANAGEMENT INTERFACE" <linux-arm-kernel@lists.infradead.org>,
	"justin.chen@broadcom.com" <justin.chen@broadcom.com>, "opendmb@gmail.com"
	<opendmb@gmail.com>, "kapil.hali@broadcom.com" <kapil.hali@broadcom.com>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v2] firmware: arm_scmi: Give SMC transport precedence over
 mailbox
Thread-Topic: [PATCH v2] firmware: arm_scmi: Give SMC transport precedence
 over mailbox
Thread-Index: AQHbGRWO+sCmOcvWQE215V76FhqXAbJ8HKKQ
Date: Tue, 8 Oct 2024 02:14:18 +0000
Message-ID:
 <PAXPR04MB845905073FFB3B0967C7263F887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241007235413.507860-1-florian.fainelli@broadcom.com>
In-Reply-To: <20241007235413.507860-1-florian.fainelli@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB8599:EE_
x-ms-office365-filtering-correlation-id: 65753735-95f2-424c-db9b-08dce73eea84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8mCLTagvAcDZ4tF03Eh0nyunI9MaDZ3ONK+giA+wd7Fu7+svhpmGDz8o+kmM?=
 =?us-ascii?Q?evJx+EkDJjpdNmNg3+zGHNp9mK1wRqMZitJi0IpK5VVIRz5iLVky+joueUBJ?=
 =?us-ascii?Q?noGvcMlqEa7QvH1I5DC/VEFChe4P+MPFjcUZ7XYRiNT5r/vwG4k0jgU73wOJ?=
 =?us-ascii?Q?bNSRWF0DZIBqkpFaNgx89wYweRWw9im4A8ghFFRZgZyfQabQxLSau5AbVtYR?=
 =?us-ascii?Q?O/10RuhEwUP5J2Vn2MR3/diUoFm641LX5L0ph7VWSaAg8FwEh3tENxtXj4kb?=
 =?us-ascii?Q?gulJus8L64VRHHOs0LYkQvCLNnNGvTuc2CVyLXbnalua6rvpEX0xinNLA6se?=
 =?us-ascii?Q?lf/2MEzd7yUKxp30LDZwk3nDzDKnq+ZE/+UNgsAsPPNBrPht86aSelXeaxKP?=
 =?us-ascii?Q?W19tSiBU6I46zyrmin9nqkRSwqiO+p2ljYpt0zQFPuwl2xUjz/NqpbrLm6tn?=
 =?us-ascii?Q?khLy25pUF3Xk4SX1rfGnUa1TMRDsUPoRj01qGipwIHpChBtGNqvdyjS9gMEc?=
 =?us-ascii?Q?llt99k1RB9zzOHYF++HliweHYrdegMN2HFNw6wCRe2xBUoH+hp4fL86RAroC?=
 =?us-ascii?Q?RzQFdYRiwWBsOvRzr50CFxPhoagoEpIVQv2ZAzW9/cCz5+oUmo9LDAyHj9qp?=
 =?us-ascii?Q?vSYUw71ClNuJiL8FKFusH4Bq+zzbGj187vV9EVTC725qNooT2fE+Gv0OUKBO?=
 =?us-ascii?Q?nUGcfNy6IweD7O2TAVwtbdNjP+QAKcbbcCxXmwqlc0Z6zaC4UGDCE4FyP6gQ?=
 =?us-ascii?Q?RSvMPd2kdNG+2z1QBxbR+2W7HmYJCe9p/PB2Pt6FOivNMfDDDr2DRfkMhGuH?=
 =?us-ascii?Q?YPwpIFMIOoE+jsEAL3t0McIsXk+4OP7DoMTIGRRcHptNT+iZGvo/iw4kTt3H?=
 =?us-ascii?Q?JzfCzrAyuijWlsefRM/I+czMFaZnvxu4hu0mencU+KHDT26FoeM/2V+uy8mF?=
 =?us-ascii?Q?gBaDk3ThN+qhkYCKhL6BoV/vpZcIXI32oZUSY5lUgP0c0mXkpQ/SKxxurYrH?=
 =?us-ascii?Q?NoKjAnB9mSr3UbhvDwtFv7cvELVqaBXTVyhEDPjzu2wdWsuEAFohW/QorYZE?=
 =?us-ascii?Q?FJ3m2pLwbgSv4aYVSzz6DdNrK+5Rgor2NNXlb6uxuEcaXDAnoBHOkF9rNqeO?=
 =?us-ascii?Q?RA/PKfjHrRt662IsxWNWj4ZN9pIHePWpyspnulk51on0sXk9AccicfFW46Ri?=
 =?us-ascii?Q?ZfrG7cHqlg3bZc/SybxjZi66YRUxvxCSIvhK2/YcWrRUiH1sbT2wRkEMIY6T?=
 =?us-ascii?Q?W/gWcatUanF5MBZXFhEeGS7ZhTz+G3eOxoDCMMuB2bpzIwey9pW16hfxIRju?=
 =?us-ascii?Q?WnnISHfgh7aI7VgOymc61zSz2uphEUPXOU3NnsV9k1GjgA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RPwURD5CH4+8JS3Hbq/NMgFAkwA9/yHUvPyrPkZKsG2lr87ZJyXGjcCiWd4C?=
 =?us-ascii?Q?x8tF6J6PkTVYn8blj8EQNgNaOjihEdNFv83BWwGI53T8OrppB4tprVBYQ6eU?=
 =?us-ascii?Q?waSLextPcqNk5ffEvonT74AMVxvTEX0QJQCjIhV3i9aoIE9ntoZovAn30Uvp?=
 =?us-ascii?Q?QLTArWXcmWv9ENi6nOTnHwerH289rTgvwl7SJ8OMFscqiBbXBG0cNqkzfuwo?=
 =?us-ascii?Q?mfyvynut1TqHZlf/tZpN47xKRsWjiWeKozs4lY3QVA0YVYDhpnO2hTmObFow?=
 =?us-ascii?Q?ol8wtOZWAdBZfuinHP5SKY9OsIqoiWKbQ0707y8fQmXEo7huy680cq5yfrtL?=
 =?us-ascii?Q?LJ6hMM2ly69UP+SAwqa2+0BZMuzghntMhrQAi++OeWbO63O27DnsEG6F69bO?=
 =?us-ascii?Q?gOamVQEqzFBtYdc3vpzReJkQp+RukS5R5rKkGeN0drS+K/kGImIufUuyWjMW?=
 =?us-ascii?Q?dxaLtynVZ1ugX1E3HIBcTIOJG2aQMzrUNCLLvhLZ8bRmc+zoZvOA/VcXeE/a?=
 =?us-ascii?Q?dOg2V7OB1Zs3xWMlIhS/b23z1faXQy8Bv82yqvDzdLM4bIQYspWM+AkFs+6W?=
 =?us-ascii?Q?M/JeK8XPxqzlAx2v6jS359K7WZFkrQXHgiutDWYgdclIG6OCrpQWrdldLclT?=
 =?us-ascii?Q?nfLxAvvZy/eZsPL0rbqyTlfLDgIHqaWlTNHKo3xB4c7/PlaYK2kpuOBkw3tW?=
 =?us-ascii?Q?yHCdCNUyRW2f9vzq09cxi89O3Md4sM4adtTahi/tBpc1HcP2Je0Mq2LwIOyS?=
 =?us-ascii?Q?KYQw0Noel9WHRKQHLisavK3yFb0+smPsGgKOIjyKPNe6H97XG6WJlKkw8lm0?=
 =?us-ascii?Q?8iMBURy2nTS+DXhgJNNBmE1gthw0lfkyXK+QTXdMinO4dOHnYwqhWAPWRSED?=
 =?us-ascii?Q?92bG7BjUtHqooObfkxhnrGstr+98gMLQuH34tNr1+GslRrMFvgfx7579qk9A?=
 =?us-ascii?Q?NaEfJzCy7qWC192uy4FxIJggrWh8uIRs4Unb63Y0XbUhIV7xsRj397jrNdc/?=
 =?us-ascii?Q?OHoIUTrOX97fWAxoOMPbQIwzkT9cjhq0f/v2d94LjKtrIqzOXicA2eQ3z6AV?=
 =?us-ascii?Q?oPF0Tm2IJwA/ZGyxbrOT+cG6kb94w6Tvtzl4x213iAHL+jhSWEWPcK8NDifQ?=
 =?us-ascii?Q?LL8JkMoB80lWHl8MTRdv61FP9npHtC5elL148Rtwu/560BdsalwSVWyGltLx?=
 =?us-ascii?Q?DDdFzgmL5GuDd3CCWLRmnpRyYVVmZAigCVi8/Jz0kjKLVWMpJo59EEEhsHKC?=
 =?us-ascii?Q?Tn3vALax8kUkCwVLr+L0d+F7iw6R5kmXhiGCndZIz0jbZ7omGNCcVEXQrR29?=
 =?us-ascii?Q?8SDro8f8FM+uR0aRpvcngo/jOZn0UZ4NjkFEtbBQ8aknJUSy2M3s8ynyG0rH?=
 =?us-ascii?Q?QMJwv/iWYmFW7X/DQs49vJEMPTsSZcjWBb8gRtHwMASgf9E7J5p5z1KuQM14?=
 =?us-ascii?Q?wQpY5fL7Qhg4smsyLJC0Ea2NKC8pXvpvHlwtnLe/A0nojhpTdGQzrEpc1FdT?=
 =?us-ascii?Q?K158YN66O0cwd3kkAAGhOGJ/d4OjlCGfwfr1VqogBUMevI62+MsPnH8Sera8?=
 =?us-ascii?Q?xpM5w4rtIpRIduHfxIY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 65753735-95f2-424c-db9b-08dce73eea84
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 02:14:18.7802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pHdaST8c8+sHcJgu44N4VyThqinuFWSMcke1U/x+tuytPb5uNyuMvnSmWRF0ySXzUERKPq8i21B+pso5qVFew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8599

> Subject: [PATCH v2] firmware: arm_scmi: Give SMC transport
> precedence over mailbox
>=20
> Broadcom STB platforms have for historical reasons included both
> "arm,scmi-smc" and "arm,scmi" in their SCMI Device Tree node
> compatible string, in that order.

If compatible =3D "arm,scmi-smc", "arm,scmi", smc driver should be used.
or I missed something?

>=20
> After the commit cited in the Fixes tag and with a kernel configuration
> that enables both the SMC and the Mailbox transports, we would
> probe the mailbox transport, but fail to complete since we would not
> have a mailbox driver available. With each SCMI transport being a
> platform driver with its own set of compatible strings to match, rather
> than an unique platform driver entry point, we no longer match from
> most specific to least specific. There is also no simple way for the
> mailbox driver to return -ENODEV and let another platform driver
> attempt probing. This leads to a platform with no SCMI provider,
> therefore all drivers depending upon SCMI resources are put on
> deferred probe forever.
>=20
> By keeping the SMC transport objects linked first, we can let the
> platform driver match the compatible string and probe successfully
> with no adverse effects on platforms using the mailbox transport.
>=20
> Fixes: b53515fa177c ("firmware: arm_scmi: Make MBOX transport a
> standalone driver")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> Changes in v2:
>=20
> - removed downstream Change-Id
> - s/SCMI/SMC in the second paragraph
> - added details about what changed and how that affects the probing
>=20
>  drivers/firmware/arm_scmi/transports/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/firmware/arm_scmi/transports/Makefile
> b/drivers/firmware/arm_scmi/transports/Makefile
> index 362a406f08e6..3ba3d3bee151 100644
> --- a/drivers/firmware/arm_scmi/transports/Makefile
> +++ b/drivers/firmware/arm_scmi/transports/Makefile
> @@ -1,8 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only -scmi_transport_mailbox-
> objs :=3D mailbox.o
> -obj-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) +=3D
> scmi_transport_mailbox.o
> +# Keep before scmi_transport_mailbox.o to allow precedence # while
> +matching the compatible.
>  scmi_transport_smc-objs :=3D smc.o
>  obj-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) +=3D
> scmi_transport_smc.o
> +scmi_transport_mailbox-objs :=3D mailbox.o
> +obj-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) +=3D

This seems more like a hack.

Regards,
Peng.

> scmi_transport_mailbox.o
>  scmi_transport_optee-objs :=3D optee.o
>  obj-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D
> scmi_transport_optee.o  scmi_transport_virtio-objs :=3D virtio.o
> --
> 2.34.1
>=20


