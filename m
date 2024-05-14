Return-Path: <linux-kernel+bounces-178539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF0C8C4F30
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1D41C209BE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595FB13D24E;
	Tue, 14 May 2024 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vk835J7x"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D5F13D24A;
	Tue, 14 May 2024 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680995; cv=fail; b=VyypaVASSDWf6t1Lv07fgNY+sy5+uCbwFWA5qO9Q5cuseo/URW51ibzGlTBQkcy+hUbhlCOlnkAv20/s5/51GfRPBe8DoY60yKt+JOh+WEHJuLq3+InpHO6ATiEFjSZCU2LQD7qqAUtC9uUQE62bcgMsP3aIT1JKlNoUBBYLXRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680995; c=relaxed/simple;
	bh=E5YnQFz9rFeX4FnSBLiKmunX99sPxV2HiJdsRMec1ME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kuUjP/FeKygiOhpkFS+uKkepd9loZkvIwRsgJHX8EP0lRQDmcKlMp+odmv9EGjtkvbNgKOU64LO4InymzT5XYhtu2PC8xboitlnPVtRfX2OJbsXTSRTdaxyntdOqoFTgxPstkeZhgpOE/H3b+bA6NMkoX7btP2WHDovP4IJMCq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vk835J7x; arc=fail smtp.client-ip=40.107.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC5MhrET0Tv+GJS6HMjh8h1dORQI7sA5voMAbdTj9JbaRXFN6RuR/OBqmE9BLP1D1cT+QeQ23m0IINrCnLooSmlvhIqlrXVKz8lkYRYWwePRfZpH9kcG+3bGUAG2ccIakree02tqHkIki/kJhyUu+W0HC5fYLgWXmCr5h1NI847L5ToFZ3AyGA11X9qQjOzSsa/FabvTD/OKIxa1FoohhA2AybPC6UBA3dd4/XDnppJj5Sg3Rw+d7wMNF2iNb+m4kUMZ3MQtHeegm2Z6Kcgb8eoPVSJC6e/iFQyMwDy19xQylcLqnpfJJR2W4vQdk/A1xSaOekZGiQqsp+EC8jfDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlPRPQk02jc3ph6tldk9ypKPw9Ykrdh6eClMuMeZobs=;
 b=UKcdnpI4829Qld6K8hCuqHQQhkMZMJ1iNNHRVXThHeQOKt96x7blxdqbOgRmykQsQUbPFAXtYbrDIZyrR4FSgnOV+ngkeJMNV52ykyFXjwZgrGoYUFaawXh1WJ3sDyCWFcNhTng6O98FJycwD0uu9c09dBpJBX2wNYtP/C1urwNrhzerTXeaVhbCsvpZ40VD4DDit7pFFJXVg+wkGRgNZCMI2X9Rren7e8fh3hpn4uvUZe9m3JYLiH4mleV5TEtAREbKddzZuApiMXPSgWCwwLnV6jhGc/ZLcO1FGbt4giPJ4ZZ6xuh+yXOtWslCyOfy6mgcx1VPvWCfmniYFlmbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlPRPQk02jc3ph6tldk9ypKPw9Ykrdh6eClMuMeZobs=;
 b=Vk835J7xK7slaWoROTsE8ZPG98Pqx6HcqNHdA8iOY94HH0ZytNDvK2kO7hSxCY9l8t4uxottsPuTR2WqUMBYyHO9sStDY6t3T/117t8CTYKbUWR5HcU339daoDQH+3qK0+zUoZNJhTQc/mfQLOKpTHa8ePoL1YxQkVhSzsD5stI=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM9PR04MB8211.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 10:03:06 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 10:03:06 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Pengutronix Kernel
 Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 1/4] Documentation/firmware: add imx/se to
 other_interfaces
Thread-Topic: [EXT] Re: [PATCH 1/4] Documentation/firmware: add imx/se to
 other_interfaces
Thread-Index: AQHaot4pUxH/KYeVW0C3Uhpnuh5nmbGUyQWAgAGsGRA=
Date: Tue, 14 May 2024 10:03:06 +0000
Message-ID:
 <AM9PR04MB8604E157633A20CF0AF82CA995E32@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
 <20240510-imx-se-if-v1-1-27c5a674916d@nxp.com>
 <ZkHBf9o522w0E2jR@pengutronix.de>
In-Reply-To: <ZkHBf9o522w0E2jR@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AM9PR04MB8211:EE_
x-ms-office365-filtering-correlation-id: c6bc50dc-92f1-4fe4-7d71-08dc73fd0d17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nRdvyHsH5JjuhI4Ekr6wEGsuxuUSSGM55tbo9w04qQACL6QaEjMS35xy2v6Q?=
 =?us-ascii?Q?c4A3UUSZIvI4JhtTjd6aJq9vQnSGF2AJO8hzFECtHLdHpAGBK0S11Ot9liEx?=
 =?us-ascii?Q?+KPNkGYVzoJUmu9OhAGN+TSGgjcqe1u4sjSf43OkCM/QBQYG2JGnrVhpQEKq?=
 =?us-ascii?Q?g4Zi93BcQ5VzOEWNZjVrkasl4GI/d0isfrYEiIfPf58YCES8kUIpjcXgxxU8?=
 =?us-ascii?Q?ciTtAKTs50ha8kTywjbgLD0CbsHb/urVcGMJ4AOqzmAzLE/KoG+/0N9uk+aW?=
 =?us-ascii?Q?YZr0O+FbkkYX/rdCC/B3Hcn1f9IQA0TTg7RSF/eBm0kQV4YNaAM4Tip5/NqK?=
 =?us-ascii?Q?zTQhQgpr/RRsJTz0oKB0rLw7e9/+lzeUL0Z5VNr98m4qTGzA8/OEpGCmmno5?=
 =?us-ascii?Q?41RveCA67CCZLPTLlyjkJWIWbZjAZTkC5W5AHyPAOOezV1ypXDaVMB45Fvhi?=
 =?us-ascii?Q?38Ds7ffQukLjxZrRW2rI71phk1xxWp+K5a4JZR3ZRPNHjmhM6m9LdZqFUl+I?=
 =?us-ascii?Q?OR0SQSbXtGBicVfYxyJqHclQw+8DI/iPHFcpC0DSjSAueDf6XDr/B/l8jJat?=
 =?us-ascii?Q?JB3FuaJR+XJT/V0gYyiqtz6ZhvytTeu0TN+nKBJ+x3HOoz5WywTjg8pr9Ihd?=
 =?us-ascii?Q?OsOuNL2cpQh2T+mAYjgdlffaqNeRf9U41X4P8HtWbNzL4k/NFTQaGFQykZ5l?=
 =?us-ascii?Q?R17+TVk8uq69IG29X4L2EmQ4Kz1qwFEfLytFaoI+qCo1GbaBAMIRI8gszCqf?=
 =?us-ascii?Q?ee5U2xRPpjJuj41nkhaCNhSpWJiY84WQ/cbzTcR/nAElCPdDJslwmzHlGSa+?=
 =?us-ascii?Q?aZIntrx7RBelq0lhJTL8QrkaerzuRs3g+qXir983o/tu2m83ZbM2NSsBljCj?=
 =?us-ascii?Q?We59chwI32hNwXJVqtjxN4P/31buBa4OWTtVA9Z0BprhPuI5c3UjeiVqdhHB?=
 =?us-ascii?Q?+rII/gXLjagddvEISGve1LSMxIq5MS/7SJ1wfZPt7dl/+xLRcVfeh3GqWuxo?=
 =?us-ascii?Q?YU9JdW3++xpTxMdLSHMYOCAliz+GZZ/rb0i1MmoI5YoR4nBNotYnkJucXYf0?=
 =?us-ascii?Q?xtViiubFY1TyuQjMMOO+Kz73sHuuuWvHZstMYnRZR6owrhWPQ9bZO+dUB+Pl?=
 =?us-ascii?Q?Fgde1/cGQ1IbXoenRNoeG4ku8mmpmEcPnPBIeq+MZMJ0HDMTNPCO3wOSVBvS?=
 =?us-ascii?Q?Ah/Tc/Zj7lq3wrC0iKQBXbchUOKg2QZtw+oIDlxJjxhqi18KsUi4z4EwgA7x?=
 =?us-ascii?Q?fhwEK5Z+0ZjDPMBYpRoaCfQUPNFOpaNSgGgTfFyTAg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jDXDxBkIuUDn9fF/aTfa4nOiHh/SpQHci8qsRPFqpBNbyR9NWHUlL9tzjDWg?=
 =?us-ascii?Q?e8Dwl1ZeDnQIVilAoH2uM31IA29RdwwpGDWCBw2CSF+1wVTdOFBd1rcbP30i?=
 =?us-ascii?Q?Iax9FVIMQ/w8+paGe73KGqv9BwMWSiDl+RDltrrulcXd8ZGakditUO4enEyp?=
 =?us-ascii?Q?1uz2R7iB6xbUtDIJW9IGS4kBAaRjBmyYlFQXFvx9tm2mcY/AwFmxr/+jHGN+?=
 =?us-ascii?Q?5Jj+/u6Z5Zs8UKja/+cI121vySJW3hKUgHEVhQWAKszhvArqGpqzXE8yiorN?=
 =?us-ascii?Q?dxX2L/VjAUQGFDEk8bagao4wR5zyzJsgUVfJOqSY3xI+mQ0lT5sVBiEQBwlY?=
 =?us-ascii?Q?vNg28gui9ETrWiF9cwDRqixlp0eE81XqVbhYhEN3CrvhIAhLlJ1Fn4mTawoo?=
 =?us-ascii?Q?0dohKLHTIpcIqN8iYL5dDxwPNEWlVCreDs0wAY9EkVdDG2Ze8gpK5TCA/KW+?=
 =?us-ascii?Q?dHMT+MGSQVTchPTt8OumgjAK2oz0ntNwI2NltpZnMIBhYIb1LTpn8XfMR/Mn?=
 =?us-ascii?Q?ewbTi6osaimu4uYpWKsiNwq3AH/vAG3fkSN8TM4d9wlF2d89R31JJJJVvMgw?=
 =?us-ascii?Q?5Az90gLFrNT35XG+ifp4qyrTJq2UgaAdqLt+e3lUPXwIJtFz0CBdxj00rjg1?=
 =?us-ascii?Q?iRBaLL6UQevF2B6eeMA0bW+mRdU0r0rA0ved2ydN472udoM03Uu++FmS+Lsb?=
 =?us-ascii?Q?9UNjEYs/r0oi8/gv+qtL+5YAH36SBUXUWw1De9l9UIRKXiSfjgpaXktG/Hzb?=
 =?us-ascii?Q?H8DdMnX66eeTn++Y58wd0/4nbCT9Pz7NTllbPyJs8FUiOQP6fQNn1+EuJgP+?=
 =?us-ascii?Q?MoeBamFDy0D0zckodJBy7b7wSaYnrJlVGdgUycbNGULDoRu0YIhmJE3jUO2S?=
 =?us-ascii?Q?L555Kei/hOMdeL/q7JN+TbhfLy6IwYkwfse85vviaNL8rstO1OuUs/eBBR3y?=
 =?us-ascii?Q?dLvE15CuW0F1bCy5XllS7PJILNME6oeQBKeK8KVMi28+Bz1UeyWFLdaNDNZo?=
 =?us-ascii?Q?Drj+fq5aNCsVJ8yktYZ/2MGyI2gDQika9PA2zNofA3eiaCszzgcgbYTfTMPX?=
 =?us-ascii?Q?cTXQdMB5VGd7tJ+lJheBMRP797/o9Px9JxxZWz6aAqs00bzH1uJkYC0c/Y1Z?=
 =?us-ascii?Q?8A7Z3HVBTwOJCabjz0MGQOKIkM37a/5X3UNW/0Sg5BKpVNZpNDmtrmtj/rCj?=
 =?us-ascii?Q?faNK32jNmS9+aDwV2bAtIwsF5VT4FZcMAcGgADzyNiaD7AwnbYrYOuGP+kJu?=
 =?us-ascii?Q?Oyzz0io+UYlaVGqp4ps8du7eY/3j0DeLkSUCscc3Hl9QxY5hNzy8G/457hCQ?=
 =?us-ascii?Q?Rfs+zG4EaqsqujF5efz6PknuGy3KzZt6TEOM8cj/o2OGBzc1GEywKjN64k9B?=
 =?us-ascii?Q?IML4pr8C3Vm9OlLCsKfBYo6FkgvuuXmHt1sL1ImVC/8g3sWzjYiTVknJNvbF?=
 =?us-ascii?Q?u+Xgb1SPuASgv8jqZpQuUpLQ9R1HHDgUqIYesKOEr99t9M5nPIGsboyUzKyc?=
 =?us-ascii?Q?C8XXOkqOxHVDg7cuR56cGUjBA3en2kGajjcNkI9AqhfirQ7jnVX71cuo/QIq?=
 =?us-ascii?Q?ua50w42sgRaJhULmub3eYo8gxzk+flblYqR0TPHa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bc50dc-92f1-4fe4-7d71-08dc73fd0d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 10:03:06.2795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxxzPeNkmfRa41v73VzLh8WoaGduSdn8jFW1CLKkrZwl+fkorGvabhAmJkwlalxWJOwnmVkrVxQCyecglbwtOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8211



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Monday, May 13, 2024 1:00 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH 1/4] Documentation/firmware: add imx/se to
> other_interfaces
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Fri, May 10, 2024 at 06:57:27PM +0530, Pankaj Gupta wrote:
> > Documents i.MX SoC's Service layer and C_DEV driver for selected
> > SoC(s) that contains the NXP hardware IP(s) for secure-enclaves(se) lik=
e:
> > - NXP EdgeLock Enclave on i.MX93 & i.MX8ULP
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  .../driver-api/firmware/other_interfaces.rst       | 126
> +++++++++++++++++++++
> >  1 file changed, 126 insertions(+)
> >
> > diff --git a/Documentation/driver-api/firmware/other_interfaces.rst
> > b/Documentation/driver-api/firmware/other_interfaces.rst
> > index 06ac89adaafb..c18c2d3e6e08 100644
> > --- a/Documentation/driver-api/firmware/other_interfaces.rst
> > +++ b/Documentation/driver-api/firmware/other_interfaces.rst
> > @@ -49,3 +49,129 @@ of the requests on to a secure monitor (EL3).
> >
> >  .. kernel-doc:: drivers/firmware/stratix10-svc.c
> >     :export:
> > +
> > +NXP Secure Enclave Firmware Interface
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Introduction
> > +------------
> > +The NXP's i.MX HW IP like EdgeLock-Enclave, V2X etc., creats an
> > +embedded secure
>
> s/creats/creates/
Accepted.

>
> > +enclave within the SoC boundary to enable features like
> > + - Hardware Security Module (HSM)
> > + - Security Hardware Extension (SHE)
> > + - Vehicular to Anything (V2X)
> > +
> > +Each of the above feature, is enabled through dedicated NXP H/W IP on =
the
> SoC.
> > +On a single SoC, multiple hardware IP (or can say more than one
> > +secure enclave) can exists.
> > +
> > +NXP SoC(s) enabled with the such secure enclave(se) IP(s) are:
>
> There are already multiple NXP SoCs with a secure enclave, so you can dro=
p
> the braces around the plural 's'.
Accepted.
>
> With (se) you refer to the acronym SE for secure enclave, right? If so, p=
lease
> write it in uppercase letters.

Accepted.
>
> > +i.MX93, i.MX8ULP
> > +
> > +To communicate with one or more co-existing 'se'(s) on SoC, there
> > +is/are dedicated messaging units(MU) per 'se'. Each co-existing 'se'
> > +can have one or multiple exclusive MU(s), dedicated to itself. None of=
 the
> MU is shared between two se(s).
>
> between to SEs (the plural 's' is not optional here)
Accepted.

>
> > +Communication of the MU is realized using the Linux mailbox driver.
> > +
> > +NXP Secure Enclave(SE) Interface
> > +--------------------------------
> > +All those SE interface(s) 'se-if(s)' that is/are dedicated to a
> > +particular 'se', will be
>
> interfaces (no 's' in braces).
Accepted.

>
> Please use uppercase letters consistently for 'SE'
Accepted.

>
> > +enumerated and provisioned under the very single 'se' node.
> > +
> > +Each 'se-if', comprise of twp layers:
> > +- (C_DEV Layer) User-Space software-access interface.
> > +- (Service Layer) OS-level software-access interface.
> > +
> > +   +--------------------------------------------+
> > +   |            Character Device(C_DEV)         |
> > +   |                                            |
> > +   |   +---------+ +---------+     +---------+  |
> > +   |   | misc #1 | | misc #2 | ... | misc #n |  |
> > +   |   |  dev    | |  dev    |     | dev     |  |
> > +   |   +---------+ +---------+     +---------+  |
> > +   |        +-------------------------+         |
> > +   |        | Misc. Dev Synchr. Logic |         |
> > +   |        +-------------------------+         |
> > +   |                                            |
> > +   +--------------------------------------------+
> > +
> > +   +--------------------------------------------+
> > +   |               Service Layer                |
> > +   |                                            |
> > +   |      +-----------------------------+       |
> > +   |      | Message Serialization Logic |       |
> > +   |      +-----------------------------+       |
> > +   |          +---------------+                 |
> > +   |          |  imx-mailbox  |                 |
> > +   |          |   mailbox.c   |                 |
> > +   |          +---------------+                 |
> > +   |                                            |
> > +   +--------------------------------------------+
> > +
> > +- service layer:
> > +  This layer is responsible for ensuring the communication protocol,
> > +that is defined
> > +  for communication with firmware.
> > +
> > +  FW Communication protocol ensures two things:
> > +  - Serializing the multiple message(s) to be sent over an MU.
>
> Just "Serializing the messages to be sent over an MU"
Accepted.

>
> > +    A mutex locks instance "mu_lock" is instantiated per MU. It is tak=
en to
> ensure
> > +    one message is sent over MU at a time. The lock "mu_lock" is unloc=
ked,
> post sending
> > +    the message using the mbox api(s) exposed by mailbox kernel driver=
.
> > +
> > +  - FW can handle one command-message at a time.
> > +    Second command-message must wait till first command message is
> completely processed.
> > +    Hence, another mutex lock instance "mu_cmd_lock" is instantiated p=
er
> MU. It is taken
> > +    to ensure one command-message is sent at a time, towards FW. This =
lock
> is not unlocked,
> > +    for the next command-message, till previous command message is
> processed completely.
>
> I don't think such implementation details belong here. They are easily
> changed in the code with the documentation update being forgotten. I'd ju=
st
> leave the bullet points here and add the detailed description as comments=
 to
> the code.

Will re-visit and will try removing it.
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.pe/
> ngutronix.de%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7Ced22fbda
> 8a3143c2e6e708dc731e868e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C638511822140912745%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%
> 7C%7C%7C&sdata=3DF4NbLNX37%2FB75Dv2q7e1DTRNaq6XZuAAMDdx9JFZ4U
> s%3D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

