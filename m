Return-Path: <linux-kernel+bounces-440853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2789D9EC56F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531161889E21
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA571C5F04;
	Wed, 11 Dec 2024 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ml6ImSJ2"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1562179BD;
	Wed, 11 Dec 2024 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733901393; cv=fail; b=YUxfhzXgq7MsrFdj/p/OgzzCB6hA6sbvn3rxb3oFc1Xgrf39DvgE9SEjG6cKAe0BC6dtvJVSthBBsP5YuUB1jqgd7YeziDP0DYNZfRjNTdeoIdg3mPmJ7HcXVpyf4hspDm3ixlOhn2ggrkyqoROPzk/qwSAvaWSMzvew0NlZ54A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733901393; c=relaxed/simple;
	bh=KaY12B/bIOA8HPg8EbQdQEdQ3aTWPBzNDp4nAWH+jT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nbPsA532gVvvkc5VgC4TpFtoj6Mto7iXqX9WfiiEoAxkJJI9NntslzzlN11Z3loQmt0FiH/gzy82pDtvP5wm4XNyGo5Dc/IqxP2uPbUk+iRdLnJdUrZ4JQyRiRRkJpvDB8U1ZJ+16sH+tpxkhc4WphQJyTxwHMimSHiPbuvSDRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ml6ImSJ2; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W16Y3mcQYmwvshyq6t+A+p5DFMyqTRSQyOKu22EXRp9qpGzZxKkJWG6JcTfoSWWdw71PelKbaC+QGQxlZIhRsbwKUjjRy9Hp0JLdm+EmUdsqwS9dwPOLi0Od2GrnDFoLqxikCbjgJniZokWP5f0Z3gb2zAJhA0AfrALCDCTkrEhcyniUnjvihOhsFrBPaA8iLSRWBjVEWm0IWBn+1rL6fchEHF6qiEWTzQlFfs4Ua7dYnZ1tdBytVpJlqujZB7QcuMY7kyOrXFlVUD8ZjcJpGFsNxo1LKbOJfBGbXBlLkQOnj4NEs0XBFoHIm1cCRo/ZT/S1HlrGtwaqvr9ImTjoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QygHbGGjkkAJg+0oV1DbE0Zr6oWYw3PY8BvFLqPE1RA=;
 b=XJ80JjMy6xTvxR3mvX7z/8bKhryCYYBhr/49EL5x7wx0NfEeghoFLDOQ7izPnEfSyFOV8g5iG8VtfnYn55US90yQ04QEMJ5f7giRtfb6g4pJMJR8V1tNb6nN3KbFkn9R5xjGyX0om/b/qmavWv0642CWLV28/Vm+WytA1t/cxryHd+EuUE28H6QWsqr4oxrovvtERQmmiLex3ganD69Jh5eLBgygYhn47ezGqTDbxl2/+Kb6Dcpoh7nWGJnURdd5lUie8dkY5D8PMD+Akzuwm0xy3GXgTPAKvgy9YmDe3GcTqtrW67hUialez28UnMHc1gGJ94V7R4fPvGbovfkrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QygHbGGjkkAJg+0oV1DbE0Zr6oWYw3PY8BvFLqPE1RA=;
 b=ml6ImSJ2+dENzp4+ZWI6vcV6Ut7enTuknvhyWOSD9CfbhnBD5mXJjNiXF9dObja1xXjKJXQDnCyMbpCsnOYp4LZASni4X84LqqhMDhKUKC5/H3xV8rrYMgPEk82qK3uSRij2NuWZsoM/+H7PSCykOf0mvUS0pxOicUPXRZFAWgWFC279dWmCLXfLGfTGihRBs8vC9tr4haf7tla/XCEMdiKQxIDe1CSnE/SM7fIqDuKRFF+IFA4fv9SQn/hGLGcadINtfjxbU4/3qmyzy/zbFGAgoRYo7rMELGjabUDRIPvGBrW3XZBeEpKy6PWRp3a3G1cp033XGok3LVrDs2N95A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7944.eurprd04.prod.outlook.com (2603:10a6:20b:28a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 07:16:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 07:16:28 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Daniel Baluta <daniel.baluta@nxp.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "robh@kernel.org"
	<robh@kernel.org>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Aisheng Dong
	<aisheng.dong@nxp.com>, "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>, "S.J. Wang"
	<shengjiu.wang@nxp.com>, Iuliana Prodan <iuliana.prodan@nxp.com>,
	"a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>, Daniel Baluta
	<daniel.baluta@nxp.com>
Subject: RE: [PATCH v3 0/6] Configure imx8mp dsp node for rproc usage
Thread-Topic: [PATCH v3 0/6] Configure imx8mp dsp node for rproc usage
Thread-Index: AQHbSwKjgzf9fNnyq0+KlAzVFTP+krLgov6g
Date: Wed, 11 Dec 2024 07:16:28 +0000
Message-ID:
 <PAXPR04MB8459FE7FA7114C0F272E3FD1883E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241210125338.104959-1-daniel.baluta@nxp.com>
In-Reply-To: <20241210125338.104959-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7944:EE_
x-ms-office365-filtering-correlation-id: c80fe1ff-78ce-42eb-0734-08dd19b3bb1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lGF41hixcZ2qA2xjrPVyett+j312MCxiu7Y6ya43+Po0GSNcH3sOja7HWHA9?=
 =?us-ascii?Q?xqRAouu+w8+4441xjV+Y0m+YOROcPKJ+BVSFwlaBNIJaL1a9LUc9xRTn50B7?=
 =?us-ascii?Q?DStuhAs+ZPd3hLJhpck+KAAZOrmYYxQWVmiU7L4otPmU/nxAWfbXFqd7w00N?=
 =?us-ascii?Q?4Lydi+ewxGap1ZJ/jeWkSpFOTp7+t3P7qOwZoQ98Jyqc0rQdoP1iah+skvky?=
 =?us-ascii?Q?Brb5n+esrob8/GFchxB9RVSw80Lq0s36EqTVCGo+Mepkiq7IcfjHncW5v/h5?=
 =?us-ascii?Q?BVlZEFC+iQere9TYoAfOYp5yZNr57bSZg9YXzopJQU3fBKmc3EgE5xG3kut9?=
 =?us-ascii?Q?8ayP9ZcscIEndXK5Jhg7WQ5l3yHWXAJZLtQV51e90vP8OErHvdTWoWlV+sj3?=
 =?us-ascii?Q?v/rkqIJ7rj06OIWu1t5mAgIm37pzFZg7n9UVrWOHX7REPpgEcCBrBkPMiqCC?=
 =?us-ascii?Q?TdPncp8J5sfxF7DnLny6lHZ+W/f9cntEb6ha/FR7p2EwF3NjJB3bthA3YkSI?=
 =?us-ascii?Q?olXhmE1nPgCMdSoJNc8vDuch6NGSofCPwQzm0xzpuawFD+xXSGu4S2udYZRW?=
 =?us-ascii?Q?EAYKyp2T1RMdUH0amzb9kFjsvl9Vfsa37MWDZpIckBZsAXuoW6XtC1IInQRX?=
 =?us-ascii?Q?olAMtxOKhtsW8cdVLCuv3I+LGRWc7V/eBDWKmD9IZ4Z/pEjiCs53odTHc2zX?=
 =?us-ascii?Q?DWUsETnYWDiLDV0NJChOTuovJOLq8DVnoK9uS7MyGOBKZQRZUekd1ya7SV/W?=
 =?us-ascii?Q?AxH77F+6Nn6qAzCzl9uxmqMHBg/fqlab1AL+e59BQsVWN4VQC0lUoYhsm34N?=
 =?us-ascii?Q?avDNWJcLNqCFKxKeKxb09LWEdCwu+47dIWt1qk9l5TXf7ndakxQVMsd4Hh7l?=
 =?us-ascii?Q?Q86tf4094qQq93JNPuKpL2rqjDnVJKndc7OQ1T4qHNa5Ao46RK5etRLSRiNZ?=
 =?us-ascii?Q?atKcAw21Q6znJyA333KcNEl0CYarlaJ8Z+n5cRVg1F1sWQYRbRORl+rGrQOE?=
 =?us-ascii?Q?MuH2/Yhi2Z+250By16zC62bzba32JiJuGfaaRJzl+wwT6oxUBEHgig/hGbKi?=
 =?us-ascii?Q?w+1jMquVl+Z3QE+iJCHsTD8yFXPnLXCL50YU1CGsGnJdbA6HgxL4ezoflDu2?=
 =?us-ascii?Q?g4hV/X5eFhLa7QJh7x8CjxKEohRksDBqquRaiVp0WPLKTMNv0iD/qeASZ0bd?=
 =?us-ascii?Q?iHFJhGag69VltX/sbEOgJlqyUrBbjjhizU4K0e7wRIbtieMQ+EIQ1SrJwFnO?=
 =?us-ascii?Q?/16sJ9Bc2L432F22LVaGQHlGNiaIgw5hm+gyJPVmBSbynrK5g/PLNmBS0+nJ?=
 =?us-ascii?Q?RqhtPFE7R54+G3pwjUzL5EpIE6rD0eV6a+R7YTX0LPJOwhKDBK3PWQEPwKK5?=
 =?us-ascii?Q?cfwbT6qt/8IlRiCB5nFaK9s9GOw/cGxF2KPU0I5E+NU0FW1MHg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WqtVSTKBJhrJp7TcSqrGt4Gu0YRKb5aPQjBWgZpRhDd2dr4CpWMbhg3aji07?=
 =?us-ascii?Q?Mjn7NRQqs9mXK/IY4Lth5A4XYvN9Jl3ukB4dQm+eMW5YBJyC2zA5IHxOz0oy?=
 =?us-ascii?Q?5tHg/Ha2OGOMwKnNxyOvcNXfIK97A10n+VUlWttKt4qLv4Ramwq1DZnwd0a6?=
 =?us-ascii?Q?D6QLuPgbdvc5Kx2GkphhIF8IORiccXzHkJrO0SH+zkiiGXNVopP7xp4DWcr3?=
 =?us-ascii?Q?kLw3xZJ10Q5dc7y+fFl1m4vIIX6YfQ8IljUXGJdgSSOPw/QUeiubdywemWl/?=
 =?us-ascii?Q?nvL6o0lRrd5jCrPrwZVDr46AXqQ2Y56V0tOvyemuGkxRhHjWqYBMST7+D4Ck?=
 =?us-ascii?Q?kCvVdWtzIbJABeAo3ysKCCdNomgkM27c5VzU0ksSjYNF14t/Fppaup+ok7TK?=
 =?us-ascii?Q?nTWJ6T6s18Bjjypq4wJmY1sj6Atf+NjjtFW8ciQ4tUIuKzi0oV6nQE0A0kkF?=
 =?us-ascii?Q?pUA13HVyBdLUnNAA6GkqsWJrKUHFpfzjtMMhn4NID+afM/cCO6lrTk1ng6ZP?=
 =?us-ascii?Q?wOD+gx+nkWCzMiie8bkioc90Xpfm8SoSVhdMwlJROeenSGaxxzpwuxDLPZ1S?=
 =?us-ascii?Q?8S45x2ZLPfpv89eFQIu/vH/gqpCVa0B6Zhhr4GLUs1SYB6lGq/yBKL15uyIy?=
 =?us-ascii?Q?dBAyESKNmJ4Mus9I/RqWlXApPrsJl9JTZ8PL3ZiHxLuagmq1kc/d3fyd9BxE?=
 =?us-ascii?Q?f/seB2CIj2IWpnrI6QabyZps6eJIkNMkcC6oQvfkMJvivZ69TVYnhoDnd6ka?=
 =?us-ascii?Q?GfntMbtIklIgOWhfDkMbX417XtDeXj4o46O6A7Rgrc3q1KK2CWppjXrKdWwq?=
 =?us-ascii?Q?X6LfQ7h7yaaz9AKsACFjqK+7wnQNy0V1IzwI+SreEeqH3Nm70bKhd3OL8SPJ?=
 =?us-ascii?Q?rXLnSn4S7VAsPEYumKATAawnnzvpVj+EmCtb4KYAhGmRoKvzuqgUaQmzVh0/?=
 =?us-ascii?Q?vQc8MYdHeYrSA+8SvjFbIx2pdBXmCyI6rzhMpJ7H6hM4KhMdUvloovg7EGCL?=
 =?us-ascii?Q?JPJwthjCjbrLXenLpo/Ot4J3+AiFmR52vgkuhMW4FbVXaTsdWnGBdUHEDRQv?=
 =?us-ascii?Q?kcK9b4zJLgKYZKvs0tgNok3MRUx3S7OmeWAdfLahEJPe8i4W/sTkkp9s/U55?=
 =?us-ascii?Q?PhxHdkNMxhoeCwE+iAjPA+OwI8lGtVLYgUrDf+9MfgaX2k555ePhjHAidHCp?=
 =?us-ascii?Q?+2PYH9/Kv6jeebA5dSSYaBl1NBYtW3punTQWMtJauC2FxhQtUraXSfVEd03W?=
 =?us-ascii?Q?KC001JmikoRGoG0xZyV59ubs+qDgBbMyEKLXmjZUn0Ib09jFa5LtObrpSLH2?=
 =?us-ascii?Q?cKGMFu+8FmUuobSu++tLkeH4Jc6s1ysDDLA/1HpimRuKE8jgQFF3SWVReobp?=
 =?us-ascii?Q?yYkOV1NQzZYlglIhJkhHQ1vjokDRJrDlD+F9/v77Dp3W/6sqMM5+0lunGPuy?=
 =?us-ascii?Q?Bg8fs+Wg6tvaLOi7DoeSeaeCR2xnEqheMPk8QvPTDAMAUtcN8U6/wqrQ1w5/?=
 =?us-ascii?Q?43OmrdAPcvlRYV0qMU4yleXk8pEiOAkjw3t1nUnjvHAHuevjtJaD/MtGJcfm?=
 =?us-ascii?Q?2U40fIy9L+Ehqg39rsQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c80fe1ff-78ce-42eb-0734-08dd19b3bb1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 07:16:28.5464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fA5eefgauMiXmkAGFFkgEpCEGHzoeuhZ1Mq10p3jpSfrXC0bt89zGW18FMyJqxLXWSZrfJTnRcpItcCxN9s8+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7944

> Subject: [PATCH v3 0/6] Configure imx8mp dsp node for rproc usage
>=20
> DSP found in i.MX8MP SOC can be used by multiple frameworks in
> order to enable various applications:
>         - rproc/rpmsg framework, used to load for example Zephyr
> samples
>         - Sound Open Firmware, used to enable various audio processing
>           pipelines.
>=20
> Current dsp node was configured with SOF in mind but it doesn't work
> well with imx8mp-evk dts. SOF controls audio IPs from firmware side
> while imx8mp-evk preffers to control audio IPs from Linux side.
>=20
> So, configure 'dsp' node to be used with rproc scenario and later will
> add a separate dts or an overlay to configure the node for SOF.
>=20
> This patch series configures and enables dsp node to be used with
> rproc.
>=20
> Changes since v1:
>         - document syscon compatible as pointed by Peng Fan
>         - do not disable dsp_reserved node in the dtsi file as pointed
>           by Ahmad Fatoum.
> Changes since v2:
>         - Fix dts example in patch 4/6
>         - Frank Li commented that we should handle the reset using the
> reset
>         interface. I have two objections on this: we are using some bits
> from audiomix
>         for reset together some other bits from DAP region. Also, the
> implementation is already upstream!
>         Frank Li agreed that it's up to Rob opinion on this.
>=20
> Daniel Baluta (6):
>   arm64: dts: imx8mp: Add mu2 root clock
>   arm64: dts: imx8mp: Configure dsp node for rproc usage
>   arm64: dts: imx8mp: Add DSP clocks
>   dt-bindings: clock: imx8mp: Add syscon compatible
>   arm64: dts: imx8mp: Add fsl,dsp-ctrl property for dsp
>   arm64: dts: Add dsp rproc related mem regions
>=20
>  .../bindings/clock/imx8mp-audiomix.yaml       |  6 +++--
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 10 +++++++++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 22 ++++++++++++------
> -
>  3 files changed, 28 insertions(+), 10 deletions(-)
>=20

Patchset looks good to me:

Reviewed-by: Peng Fan <peng.fan@nxp.com>

