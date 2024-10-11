Return-Path: <linux-kernel+bounces-360864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D840D99A0B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B881F25072
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D044621018B;
	Fri, 11 Oct 2024 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Azt9RJN/"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA0C20FAB5;
	Fri, 11 Oct 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640967; cv=fail; b=XdGCLeoV2/dTMGxp5Eeo7xKhaBinTehoo1AWDW2TghZspUO2YBLsotp+DrKiO2+LgAlw2AycLfDAJKdF37AHN6OFEp1RtPtQSKVevPvOAaMxPaWaZpAFny9DrqcHCg//07qWbjHwvBuG2SVC83/g+8s+PpfPaRd5PUc6qju/yhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640967; c=relaxed/simple;
	bh=1SjvM32HUxxgnnyss/g5+DZd5kBaq2zKaXSPvIxFb1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gSVsvxHADRJ+eE2cDldfqQ+ohvqImSUZJzOKcKp589LW4o/oDIaSs//Zb7TeyQzha3AJZqmfeCMfy7mBIl3nc8vwio0bQjFnTagUzvsQIPQA0wszCuBlx8fLPdOT+iUHDwrL8Qv3lK5Hbn/r4fz1iFzbRyuqNg7s4vT9DY6CEUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Azt9RJN/; arc=fail smtp.client-ip=40.107.255.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/5TdGgxVhHh59nHpzazXSu+6r3+mHBWzQAeROWSUwfhxByRYVb81rdsVuJx1P6v684cvUv6KkjgR0Iz/d3S5YQ1DKnSaPHdt+4F6hi1BDcKjch43bwkr3iXiIYvmebByMaPLxbsQ9YNitbpCAyLD8M4Fs6/6lL0/L7k55h7CDHKFhBTLu1+A7mQxELFXFH1TjotkG/AwPTcpSZ8/j3wrUXBJ+aD5wsaJBuznVowhHx224C845XVTB2djmG/bl9pK5A5gbXlqoqQrF583bzIaQyiM9w8A5rOJu0FyxO3xjVwyPsRdIZni1bBxDaiwFiv3/TCAM5UiKbR3dJxIOQB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIFVITa7NsdPWoyi5FV9fKECb6Mo0XaGWnEzFG234vo=;
 b=q/G7Uom7eotI8Me+FAyMnCD7ppHWSiyQBwDqS/tS7PQ0aMJYzgwqD6G79uyEtAZ/G16ADLpgj6JEtFphrpc81gV5s4O3EKgTisBPLSq5lSzvRwWel9FDcQxfOEd8cqBT+OmczsfTn5juOFBnBqPpuV1684GDWNINUIVEsFQsfkzX+tvkJAinymrZom82rxX/vSTrPtYACatOX28R/3uSH5FLojeSC0tyJhGXw2g8gcuc+9WAslh7P30Chb92MzLt0Ru5mG8tcFnwxo4DzDgjaeCcrHk85PinAyJq7rhyIc4n4b9JmQOR76vzEV7PtQwtOq5dbes9njMKsp+xtmjExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIFVITa7NsdPWoyi5FV9fKECb6Mo0XaGWnEzFG234vo=;
 b=Azt9RJN/TBCqgrU90wp5GIcrNaGmen0QFv2MQrWqttYxRLfBE+bJfEGx2hE5/3rQsxjmA6rDLMErTVk5viT5oeeb8Fs6sAPO0u/Djq3LvFEAkXMeYIY1jK10ZArW5teWNaf4PdySs2w+fXUlMmiIwnZARqwWJmH369gOmYmAW0Y46nt4Ewnm+Pqm05e2hyaxI091cwZ/ywz3LYD2+0k5KWfOK1X8NxyOUw7JjZxiTZMVb+w+iJdE2d1HiFYhlTELJ70OqiTjcR+t+4o2Q3WSZwnD9YnBI5XPWaP4/JGw/QHyvw7y2/Y5+PNaVCYrsTHx8qkDDezTtJQ1BeMPYUVmxw==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by PUZPR06MB5588.apcprd06.prod.outlook.com (2603:1096:301:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 10:02:40 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 10:02:39 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Rob Herring <robh@kernel.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: interrupt-controller: Add support for
 ASPEED AST27XX INTC
Thread-Topic: [PATCH v3 1/2] dt-bindings: interrupt-controller: Add support
 for ASPEED AST27XX INTC
Thread-Index: AQHbGkKLT5xnpna6+UWdbJnjHl6CdbJ+6wkAgAJpE3A=
Date: Fri, 11 Oct 2024 10:02:39 +0000
Message-ID:
 <PSAPR06MB4949705F99984E6FA6C2CAE089792@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20241009115813.2908803-1-kevin_chen@aspeedtech.com>
 <20241009115813.2908803-2-kevin_chen@aspeedtech.com>
 <20241009211116.GA676770-robh@kernel.org>
In-Reply-To: <20241009211116.GA676770-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|PUZPR06MB5588:EE_
x-ms-office365-filtering-correlation-id: 40dfee7a-27a1-4c26-ae98-08dce9dbd714
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kcC4HM5FNA6RioCArmuS2xwFrfKAHg863Tv9XkrTHoBVDS7KyCETItQLd/Ys?=
 =?us-ascii?Q?DEWd374OVtxo86ytuymNwOCf8lmon76Pec7o/4fEXsWOGtlOUOu6Rp0q3iTC?=
 =?us-ascii?Q?9B3sw3ptZvZVCBnWSHLqdP/rnVDcvcjUnHde+YL8z18JU48vwxZPpb3aGDxo?=
 =?us-ascii?Q?K0qkG9IGhyr+fcAzM95tjVeoxmr5e/OX1qIjhgRiIC3mH0oC5go1sw+2LQCs?=
 =?us-ascii?Q?u1ey4DPlLoe7izom5l7YG+2oxLbRz9F9+kAE76iGhxG9THpbGqutCT9jfEXY?=
 =?us-ascii?Q?/TKZw6b5tVZZDCNedKLu1VPxOUP2FmyktHy9uFvWd7CLwAv8ITbI5ke/gl4G?=
 =?us-ascii?Q?+mHolVOzISDHEK67AdP04WyI6MW8omnT/skFOL0srCkVtdDLbkHsITWvl3xY?=
 =?us-ascii?Q?rADcKbfd9eaQAbHe2xa/jTMzufC88b2t4eOV0b6wlI5LwnpZafhzTCZZfzDl?=
 =?us-ascii?Q?FLVFZa/VsheglLttGCux8T2thfEG0i5kKLo68WGN+O/fyabIW6dtm+nvEvOJ?=
 =?us-ascii?Q?8xuGhnkga9JdkdiVYCyIbNXHsUq1Us6a8PUDhle1D9y3h+ye36RSnZFeUpZe?=
 =?us-ascii?Q?rlSIMhJVDmta3Vue2fSweOk8x9x/5FqnU8Ug2VlxoOxlPYKg0baLeP5k72qJ?=
 =?us-ascii?Q?ie+QJKcRXY/S50SWz7FzD0WCpGDrLTxgnRUD8D3E4D6xGONXvUjyJasPrDrY?=
 =?us-ascii?Q?64iFX1tMs1WzlNG0nxLOCOqfZmGCrIuLDncJTCCplF/X1WZiegNEA3dUYW2U?=
 =?us-ascii?Q?XFxd1hY9xj9q4wWoDCwSk7Yn2xNwsQ/zhjvzMIuNxUrWzI+xyLWnssNVLCxQ?=
 =?us-ascii?Q?1EOBrbWA85sNoUF0KGkXQZ/j95xrnnJrwb0ZiZHAHP8FFDo8LDpxIj62VZfW?=
 =?us-ascii?Q?3MIqLdMfBzxOlvnzAlxj6915TuZufN7gO9N8v003/VjfAWIt9t+zfVOZe4hh?=
 =?us-ascii?Q?ybSDlnXbjOj2xwwT4ERFe4ikYFRNgfxjMvtL7uhwgVEOJ6dUryCczqeNwi4M?=
 =?us-ascii?Q?hTV+zhVGQmbG53oVCR/RL1bCEPniagvPXQzxIBnOcA3oR8Q2pkKxWPQgHB8q?=
 =?us-ascii?Q?C8NMiQ2Xer2UuHBPJ6GB18GmycmKFCWPl/mhMkmaGJ+sBmQbkaXe2MWIEj0z?=
 =?us-ascii?Q?NnuPPWj9MCCJep7T+h5PVNqmjdmArcgFPBFYbwxzhJIx2UvCnBuDK1XdrSxN?=
 =?us-ascii?Q?/Fj2EPBq9vXrV7DC43QOWCxFYA//+jQLvBopyH+b+SBkeXcrJYdXQrmJIdn0?=
 =?us-ascii?Q?V53MIErR6F949++t4iOI2sALeRLqvBoRTeUy7nHlLg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?toGbAN8FvmHKELdu/JYf3qYj+hyFmTag6/kZIc0c0N52tyMMSs/71q//U7Qe?=
 =?us-ascii?Q?YoQNramK8bbgxKE97PCcnS71owxP25/V36+oSQ3h/KniuKm4GNE8f7CvM7aV?=
 =?us-ascii?Q?b+tVXtYFfrkCoMOm/GlG6bv6LgaTOEr2CM4toporiGCrPbuvEVk4i6CIRE4q?=
 =?us-ascii?Q?jWCZExi8qJiKxGCcsxWsrngzPlvz3ur96WCWn3taGGmYhxt7hGv7UEmbqf6j?=
 =?us-ascii?Q?GI9Zew8IYe3OyLcSKlaC0cW9f1LF2gQsKmmFIFcRTJvowlwFjz/SKPgqXfmY?=
 =?us-ascii?Q?J6mE6S37QAUg1RTpBN5UCTRWdJoIuE7iqKmyM1A4XID7zR7wsyaGBxGFphe1?=
 =?us-ascii?Q?f1A+SA3XwdDHSb19FmO3h6LIROzgEEO+E1/BIuwxk0//raHPcX6V1gYAbz7y?=
 =?us-ascii?Q?0BRw582bHL2OuNut4QrboOm6XXiR1bh9XKsL5tAZAyWwO77kxVcHoUOGdjUN?=
 =?us-ascii?Q?98haMhPNlF1Qgmapa4qNrmpKcM+xxP0y1xXjaqBRdvXt5OWbPiMFxivIW5er?=
 =?us-ascii?Q?28fHOlKu06MRf8veTGrjrPJpsAMTkzIilBDlyEIr3WdNx9uoJ4JO71SuKiwC?=
 =?us-ascii?Q?jVaFdvHZbltrHMbYcz/MYnXnFJ4exFeGrLx72c1y9aYw5bD54zEqqT/tzbrh?=
 =?us-ascii?Q?icZ+M7Nq/FtSIci43UmxfX8z6KnJkfnT+/kPIuBG7NRS7Smk0w4J1gMlYsnL?=
 =?us-ascii?Q?Mlm04fQzOLjHoRngRvlp2Ckq8weQQRI1yww/s6Ih+08QfNs0Dtf+Sn1Vn7Ci?=
 =?us-ascii?Q?E8kcpyGMk9oeKHWRPbqR4WFfPhQvm0FsirGnp/r+JbzjQtCZaD11+igs0dq9?=
 =?us-ascii?Q?OAOi9e9qwePfsYmy/4rvgOx+9oyb6Gul6/mqfI/wlKU4xoQM4lvxTDLV7opF?=
 =?us-ascii?Q?LY56rS95WGinPgfC8X+0mJRAnsd7t6PmDaplFxM4dYFEP3Lquh4ngKTEjMJ6?=
 =?us-ascii?Q?B+Ls7c/fNLpzDea7wIObcQ7N7gRgjVzyY0U3I9VU0vs3zsCTtAL/PBLm3WY4?=
 =?us-ascii?Q?oKqXlD8AUzTW9mPf6dGRluBYamAICh3h05z4GfnR+OrHunznGDYXbii8/nUi?=
 =?us-ascii?Q?W7vswuVYT/Fl87Fpg6mWNwHSb6Twnx0ZD+LD7QK8q56bqDPwr80jSv3J+wKs?=
 =?us-ascii?Q?Li+ZJqsU1iN/Keo17Dxam7FbSJjnhExVmZ8gbB10WXwvHa2LRu7BX4iCpAiD?=
 =?us-ascii?Q?SeQa6qNIlgYXZO38pG5nzFHPsl4AtgIQy56pY1+B2eWhNqvytnOkLtP4Xaa1?=
 =?us-ascii?Q?G+6KJFt7DM77BlDhYnv3pK4ubFLJxjtjxjbeqLzk9caFR2czgLurtWsZiOBd?=
 =?us-ascii?Q?PzF4YpdzunptP3UEWh+tUtgAFNU8+zq7hkXR2JQVr9K9bajDupyVwKn8RRrT?=
 =?us-ascii?Q?9hmlIYMrstaVilJHabiNxw9VoyICyPF6Pxn8mnNZ2bx9EdK/kYnbYfl0jEvn?=
 =?us-ascii?Q?7lN8Awpn1N07gCKHt6GQjuHvK9KVbJdqk2lTmVRKQJ627FKnLWyUKxY9jvYg?=
 =?us-ascii?Q?EzjdvtVGN4EzaeQ9AlXQx5ayz9nhDyZNJd15gQFkzMbmKpECz7lt+O65pz7B?=
 =?us-ascii?Q?wyJb7cqmRhRXRIRJ/HRJPjwZMvRklifLQk2FwMmq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dfee7a-27a1-4c26-ae98-08dce9dbd714
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 10:02:39.5040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: js+XIne4QMh9UD1CZ5EGk1D5Srrr04DLGofREEeqdN/Jo/7AHdhjvBaZXRJ5VerCOFFwb6ubN4U8rKz6UXYwsLT9rFrXzUQ72VpT70467IM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5588

> > The ASPEED AST27XX interrupt controller(INTC) contain second level and
> > third level interrupt controller.
> >
> > INTC0:
> > The second level INTC, which used to assert GIC(#192~#197) if
> > interrupt in INTC1 asserted. There are 6 GIC interrupt
> > number(#192~#197) used in one INTC0.
> >
> > INTC1_x:
> > The third level INTC, which used to assert GIC(#192~#197) if interrupt
> > in
> > INTC1 asserted. There are 6 GIC interrupt number(#192~#197) used in one
> INTC0.
> >
> > Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> > ---
> >  .../aspeed,ast2700-intc.yaml                  | 87
> +++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-
> > intc.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast270
> > 0-intc.yaml
> > b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast270
> > 0-intc.yaml
> > new file mode 100644
> > index 000000000000..650a1f6e1177
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,as
> > +++ t2700-intc.yaml
> > @@ -0,0 +1,87 @@
> > +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause %YAML 1.2
> > +---
> > +$id:
> > +http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-int
> > +c.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Aspeed AST2700 Interrupt Controller
> > +
> > +description:
> > +  This interrupt controller hardware is second level interrupt
> > +controller that
> > +  is hooked to a parent interrupt controller. It's useful to combine
> > +multiple
> > +  interrupt sources into 1 interrupt to parent interrupt controller.
> > +
> > +maintainers:
> > +  - Kevin Chen <kevin_chen@aspeedtech.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2700-intc-ic
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  '#interrupt-cells':
> > +    const: 2
>=20
> Describe the meaning of the cells here.
I would change to the following code
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the IRQ number, the second cell is the trigger
+      type as defined in interrupt.txt in this directory.
>=20
> > +
> > +  interrupts:
> > +    maxItems: 10
> > +    description:
>=20
> You need '|' to preserve formatting.
OK. Thanks

>=20
> > +      Depend to which INTC0 or INTC1 used.
> > +      INTC0 and INTC1 are two kinds of interrupt controller with enabl=
e
> and raw
> > +      status registers for use.
> > +      INTC0 is used to assert GIC if interrupt in INTC1 asserted.
> > +      INTC1 is used to assert INTC0 if interrupt of modules asserted.
> > +      +-----+   +-------+     +---------+---module0
> > +      | GIC |---| INTC0 |--+--| INTC1_0 |---module2
> > +      |     |   |       |  |  |         |---...
> > +      +-----+   +-------+  |  +---------+---module31
> > +                           |
> > +                           |   +---------+---module0
> > +                           +---| INTC1_1 |---module2
> > +                           |   |         |---...
> > +                           |   +---------+---module31
> > +                          ...
> > +                           |   +---------+---module0
> > +                           +---| INTC1_5 |---module2
> > +                               |         |---...
> > +                               +---------+---module31
> > +
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupt-controller
> > +  - '#interrupt-cells'
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    bus {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        interrupt-controller@12101b00 {
> > +            compatible =3D "aspeed,ast2700-intc-ic";
> > +            reg =3D <0 0x12101b00 0 0x10>;
> > +            #interrupt-cells =3D <2>;
> > +            interrupt-controller;
> > +            interrupts =3D <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
> > +        };
> > +    };
> > --
> > 2.34.1
> >

