Return-Path: <linux-kernel+bounces-374065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35DD9A6191
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC3B284D06
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513431E47AE;
	Mon, 21 Oct 2024 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V79mpZgH"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810761E376B;
	Mon, 21 Oct 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505250; cv=fail; b=GA2pAakmne7Kxro4MK6IgN3tLzmeGUGKTs9y5a5oThKYWyOMZyFuK7aSjFcl8KZuJggl3LCCVALr4Ay/dVG8KvQw/bfI2In/TYrM8kgfs+ty/rUjPuTRrrwGYtU31LnRohZzmgFANWZ1PJCDvnvu+l2EMuC+k1l+Q9JBJ//h5j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505250; c=relaxed/simple;
	bh=+1yILLbvsdLhk06soI+sQYTIEsZDusJKB5Ma60xhXBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CcjLyZJvtuvB9HF+1DdXq3J0AIh6mH0HpHJyLXdFd1qDI5rZRBG+XD6jb5zUIiPxMKr/QZHuNBbkFNASgWkqims0FGY7chgjyW7vkXTmwsgJue/HLck3VLA/tKRicZ+mbJfJn/iuKU92sOfpp7bkROgFY8NeRKEDE/AEjasVpuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V79mpZgH; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5UmAZ++vHV+o/dT3EkjhQB2suB5ETs9vb4JUnFRVWs0BkyELsL1myJaBFbFVruM3zJCAeWNsMrOdSTPrjQyUZOIgOSI9Ow1g42aGYfI115CpCQCHKWMLBBC5rBxSb/gx9R0wSlcgkMpcWc+Lru486gHN79n+UNZ/+vFDjWGXP7QgkNhx0II6CjQ+s//l6WxLPuhe8VgVvFjWJA6QXaxAuit/lsWOj5668S6vYzVTAC9kF5w/wkouLR96uEMMH9lmfkfS4AFhyexixCoe1NJgNVZvQtX4MrrlX2ELM5P/QcxwqmfPiBEABGYR6eQTbWZltIJosAcSABchDVtPhIMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvsIi/fYegroTgJASyNOm7ct/za9edI6tRD/wFW5Hz8=;
 b=J9/03sOM9rZHGCYEIQbHYkdcxREv2of5FRj+SuDPFat3DiAVd9O1v4qzEhHRol26FAl8kFidso/MdjEhB2IqCsZevoS375/OuGutWLY36FsW9LoE0pzLoa5JSzmrwSDYQXDnzAef6q1bBlgAEhaYe9iFbWgpIOGXFTwRcLXYLGVqY3cwf0FHDKweWRuZQR4izJSk84AtEPinEHxyhkUNoxSSVDQ+On3qtNn1Wurn6T/4sToQPkM6Wjc8ZerwEmPA06SqXctM5S2ZLLlXuSo8d+GjnWPYn4AjZoLAcIfyj3SeszAVyRDM/fO/B2sCw90f1Iw3TiZSBkXVeo2UQ970VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvsIi/fYegroTgJASyNOm7ct/za9edI6tRD/wFW5Hz8=;
 b=V79mpZgHT7MOFq70C9Um4g2lpyPzFjtF4DgCzkrrj257bBzOIcaypVLcTW9q/mY+EVSDZp+exRplFXQrQDbotusaffLLDUxVPDK++HTooTrvHFGirX/gPMAzP/2DUBYdHvTZ5nEfEP26wCCis7qNX1e3yx2vo50hTcDfh2DDX7dR2IGRZS39hvrwCXYamXSC6GAE5IVSqcwBj/T/KMhB4RD5bZ4FZBSD6bZcXn56fS/7i39/JTSOm7GKRozR/gWIlXEPadhzKjggDbwWRh/9rCG5OpidiMRW52eKWuNblEiUw8C0HfnQ4Jd2CcgcvoUtf4eXsrOc8+I11fYcxtT5ZQ==
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com (2603:10a6:208:5::22)
 by GV1PR04MB10488.eurprd04.prod.outlook.com (2603:10a6:150:1d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 10:07:23 +0000
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0]) by AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0%4]) with mapi id 15.20.8048.020; Mon, 21 Oct 2024
 10:07:23 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, Bough
 Chen <haibo.chen@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: imx7s: change i2c compatible string for
 applying errata ERR007805
Thread-Topic: [PATCH] ARM: dts: imx7s: change i2c compatible string for
 applying errata ERR007805
Thread-Index: AQHbI6EF0Q7IRYkuwUGBQLPIPQQGVg==
Date: Mon, 21 Oct 2024 10:07:23 +0000
Message-ID:
 <AM0PR0402MB3937F54EF17F80B80A77DE07E8432@AM0PR0402MB3937.eurprd04.prod.outlook.com>
References: <20241021031148.2682015-1-carlos.song@nxp.com>
 <20241021092743.GA21104@francesco-nb>
In-Reply-To: <20241021092743.GA21104@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR0402MB3937:EE_|GV1PR04MB10488:EE_
x-ms-office365-filtering-correlation-id: 3db42adc-714f-4c48-ba51-08dcf1b82871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?y+owGmiEJx7VgJpUB68fAdnjK3j1xo0Cd8Wc1oSyGyj4bIFnidZDSrYXVhhv?=
 =?us-ascii?Q?H2Wu26PgvEBfEgnY9zJ62/wR7ADXqlRlowA+esLe+s1MGZQxgUI8JN5hA5KP?=
 =?us-ascii?Q?Mbd3whfOqdmCsi85eKltAO9ox1xGp4llpga2f0N7PT0wnLCsb3ziMEBmaXun?=
 =?us-ascii?Q?LX0v3uDpN+5dJNt8VAbBn7oZ8MFbnOUboLvCcKkfFtiTRFhnVcYbEopPAdRn?=
 =?us-ascii?Q?PVznrG7t2EU7ElEkWnZpuwBwUx12xuMduG3dk/5PC3Zh6Q1UvJ9WAVQyThMt?=
 =?us-ascii?Q?VI+WssrMq0He+bH8rskoHplGZ78crAtqhDzGQJC+p1tX1SFZbs887xwVXpt2?=
 =?us-ascii?Q?epi7obBFDREYTsHAsmqIAmsLxFLNsx1Q4Gqp75Nsneg4VH/45N5ox8D7zjO8?=
 =?us-ascii?Q?/D86Y2DCKeNeC9pwSwJkrvCQNJh8YF18HA/di47kAy6Xhsr8qkwWIZi6EMDi?=
 =?us-ascii?Q?UuVgd9ar29M4XLz9mCyLJvvus/pIHqwleYvfJW1DxGp9mzEXZZml9X6viGZH?=
 =?us-ascii?Q?NsokZiJ4fSH5l6N38T4R/JKhHGb55cdeITHKj27ZTEpDe9+ymsS3e9t5uvul?=
 =?us-ascii?Q?GcXkv6tOvZBVBnQaL7tqOMHdvfBvy2BSH54b8dLJL8vH2GO5WLuKvWhrbkqa?=
 =?us-ascii?Q?W6vEFkYOoWKZBYc/8VY+1sQaiqzYwem21CymjakB8Ut9huZEbmY1sxJ2l3JF?=
 =?us-ascii?Q?rynWcupF9MFa97VxC3hUI80BSfYztQ5MZVZXhQQbIef7p3JPqTOzg4CeQ9gK?=
 =?us-ascii?Q?Ue+u/QAxnnYsuE5siwAeNOVZYFUTDpXiU5uGHRO7BU8eivCnz/kqIr0agJkm?=
 =?us-ascii?Q?r5IHspDgduqX1vFEoLEY9nhRoxW+JqYmW1Qwar9ztPp9MC4oh2vl6hYPHjFV?=
 =?us-ascii?Q?yr7d3dCD0BZmxXO/bt2kLGeBLvrpaIdEjfeGYgwwhUTe1lMCTtFMBWxtM4Uh?=
 =?us-ascii?Q?QSScG1iTOhf77PPxNpNZkgelOVv5coUGkwEnRxuKJFLNeuXu1XP7GfEDCOmb?=
 =?us-ascii?Q?UYfQmcU0U5ALUtZiE4FTjf5TC6w5G+p/CMWSuItGQz6LHAVwEkW5uTp5/6i0?=
 =?us-ascii?Q?en7jcjln/XmJociDlRsJmh+CBG1aPO9N4RLjj4MAYJdaovh4IuUH8/2uayVS?=
 =?us-ascii?Q?ZO7PqHnX/FCQ+9PqXMzw2HQf/t9rizqj5z0h23C0LLeuH6zaE5XV5Yvb+R2M?=
 =?us-ascii?Q?rhLRo2SKr0SsVTWbjsxqTBlwq1mQBlTvfvx4Rl2UydwgIVstt5tvLainZn18?=
 =?us-ascii?Q?ikfi1zcl/R6Pd1Nz26HLJfpQwBjf1K6JChlCY3TMHNgNE48fpQqhexBFBy5k?=
 =?us-ascii?Q?DFbISdQMs2XvhG7uHC0GP54vQCzCJXPzQF77qkkSwSEcVX+e6M710jWTTxOW?=
 =?us-ascii?Q?Ha3+EEE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3937.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9W4zmiw0B9MaCuo4KK3Ege2rEJafO1gxuQMA/S8tyZsEl0D5noGDgnfpTy/x?=
 =?us-ascii?Q?Q3la1esjsC1wBl/j1cHtG49o1beUypS+uq9GJwAMe8G3fnmlnX5d3/iYM9y9?=
 =?us-ascii?Q?QTQZQA86Q99XilZd0Vu95BG93BX4l60gK+nsqCvgZ8EirTSox9sxxkVAzUKa?=
 =?us-ascii?Q?nO/0HtAIevDPKotxBIE1dbQkTH1zdXN/rGrzC2rrZMBNylWHIbx19VI/aCp5?=
 =?us-ascii?Q?AVT3zYKm8ipmPYtUajGPuzXebt2cQi21EFzFt1Kkj1THSOX3FNetLMCLdAjm?=
 =?us-ascii?Q?Xh5OkgBjWXA5WXnjbeFQKGl1xjRqrIzEvSQpHYpAtiPQFeQKYKtQpuo835XM?=
 =?us-ascii?Q?U3rbRvUTJKGZ+U6xP3ScdaeGiTtQ5/f/skhG1oqtOXunFrkoZPOhoMvHbE6g?=
 =?us-ascii?Q?1Zc9tG4hRagiRIWAZYCyu+n8tKdqlUOG9/bwlb8AI4bHjsxHQ+on4S8rGz24?=
 =?us-ascii?Q?69J5eZ6ZiAv8rRDJV0pjfd+FdpZ2Xp6Cne1VN+s2jqOfRKygDWfdmRb2vNbZ?=
 =?us-ascii?Q?pCOEXLBGMtWCGYwcczpHnVqLi841f3vUQmZDZGcdIXzZyyGelsa1dL/MZ69t?=
 =?us-ascii?Q?EqFQsBGz5wB8qhp/6C8TcVumhEvUGiXXUwqoY3MYebDPuV7SAekA/jNpMBTp?=
 =?us-ascii?Q?oiGJ2H2dQGpGEtM7V5fdoCIKUx2UmX0odDS5IC9iKw7Ev15Nmdp9pq+hGbeO?=
 =?us-ascii?Q?gc/cGZh79foJrtPV+VHmaLA965Leg7R9+nCgs5YMZm0DbQQY2DPP5DpMeeTr?=
 =?us-ascii?Q?M8CCX4dgro7ukXdhcQDpdFdFhvP6y82ycu9SfebWBbnLajlYp1RBVoHQECcz?=
 =?us-ascii?Q?9N6M64gmiXHRNYgSj7XCDbul+voFqRotmknbRRRef00DyrMDM3qc7bjwZDzM?=
 =?us-ascii?Q?sRLZJY0pChp7ZZdPhHcp8fWkB8rv95HHBfbRwJH14f5ab+zjXl5Q0xQDH4bS?=
 =?us-ascii?Q?YmYuoNDyw490iTEXDfwmwei9dcucQoXHm9tLdUWA9km3okwO9xpgYynfTWLi?=
 =?us-ascii?Q?l5xuxjtxAfW6gUjSOdwKmi3xGHOECu1OT2wsSBChn6kEMnMJHr0KiNzyfRjT?=
 =?us-ascii?Q?RAirYlA8HOF2b6rVmOVufgldiIxx+cWlZsTCcbAlmhwrDK/mkNBWBKr7AR/3?=
 =?us-ascii?Q?Zv8CRQ+TGKoAYGLrZcKWcvo8pJ6wQNHcEWije7PPJiSm24PnU1QPkcToVpAT?=
 =?us-ascii?Q?7NGiHGFo7xx4j9HDtWOCuooYTDsepZtO/zRbGdCtHxfhXW63P7+VE7K/6eN0?=
 =?us-ascii?Q?XV5hQDSLOqBquwdie41guiH515f8mlHVqj3TIU6ixGWJOpzFwVD7zjNGbWW5?=
 =?us-ascii?Q?HzsllJpAXbrakCGFQvt0X2mEuItUYM2bEfpW2qi8ZkVw/O3FnOHMoGVtgf2h?=
 =?us-ascii?Q?/UnPtjlOtzi3QocDuxPSrQfvpbGssqJSRaenMQ5uGtCF3FM6xV116Y97XSdW?=
 =?us-ascii?Q?DYOr7ro4V2wDxE9OVxfKnqjJLyZBmpkJ780hJipJWuUNNUYauVM7lWru2mLB?=
 =?us-ascii?Q?USohc5jnEU+xaQ0pLwHGsQ4OcAQuLwp6xBmnHTsuA0Tvnk0fMHz67xAVz7cV?=
 =?us-ascii?Q?1kz2rox+ytELjG16VIs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3937.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db42adc-714f-4c48-ba51-08dcf1b82871
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 10:07:23.4443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4+65Sw27nlCVgKM1CYrd/K31YTsr5C5FppdXaIA3HzJZ+3uzOwplOqeQcGqrVoXIhaQYzVsOrAD6gXVYVZk+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10488



> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Monday, October 21, 2024 5:28 PM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; Frank Li <frank.li@nxp.com>; Bough Chen
> <haibo.chen@nxp.com>; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH] ARM: dts: imx7s: change i2c compatible string =
for
> applying errata ERR007805
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> Hello Carlos,
>=20
> On Mon, Oct 21, 2024 at 11:11:48AM +0800, carlos.song@nxp.com wrote:
> > From: Carlos Song <carlos.song@nxp.com>
> >
> > Compatible string "fsl,imx7d-i2c" is not exited at i2c-imx driver
> > compatible string table, at the result, "fsl,imx21-i2c" will be
> > matched, but it will cause errata ERR007805 not be applied in fact.
> >
> > Replace "fsl,imx7d-i2c" by "fsl,imx7s-i2c" compatible string in dts
> > file for appling the errata ERR007805.
>=20
> Did you considered changing the driver instead? If I understand this corr=
ectly it
> would be a better solution.
>=20
> Francesco

Hi, Francesco

Thank you for your comment.

This errata fix patch has been applied on i2c-imx.c driver:
39c025721d70 i2c: imx: Implement errata ERR007805 or e7805 bus frequency li=
mit

The patch commit log says: this errata is found on all MX7{S,D}, MX6{UL{,L,=
Z},S{,LL,X},S,D,DL,Q,DP,QP} and MX8M{M,N,P,Q}.
So imx7d and imx7s both needs this errata fix. "fsl,imx7s-i2c" was added in=
to compatible string table in the i2c-imx patch, this is the patch diff sna=
p.
So when "fsl,imx7s-i2c" is matched, the arrata fix will be applied.

@@ -266,6 +282,16 @@ MODULE_DEVICE_TABLE(platform, imx_i2c_devtype);
 static const struct of_device_id i2c_imx_dt_ids[] =3D {
        { .compatible =3D "fsl,imx1-i2c", .data =3D &imx1_i2c_hwdata, },
        { .compatible =3D "fsl,imx21-i2c", .data =3D &imx21_i2c_hwdata, },
+       { .compatible =3D "fsl,imx6q-i2c", .data =3D &imx6_i2c_hwdata, },
+       { .compatible =3D "fsl,imx6sl-i2c", .data =3D &imx6_i2c_hwdata, },
+       { .compatible =3D "fsl,imx6sll-i2c", .data =3D &imx6_i2c_hwdata, },
+       { .compatible =3D "fsl,imx6sx-i2c", .data =3D &imx6_i2c_hwdata, },
+       { .compatible =3D "fsl,imx6ul-i2c", .data =3D &imx6_i2c_hwdata, },
+       { .compatible =3D "fsl,imx7s-i2c", .data =3D &imx6_i2c_hwdata, },
+       { .compatible =3D "fsl,imx8mm-i2c", .data =3D &imx6_i2c_hwdata, },
+       { .compatible =3D "fsl,imx8mn-i2c", .data =3D &imx6_i2c_hwdata, },
+       { .compatible =3D "fsl,imx8mp-i2c", .data =3D &imx6_i2c_hwdata, },
+       { .compatible =3D "fsl,imx8mq-i2c", .data =3D &imx6_i2c_hwdata, },
        { .compatible =3D "fsl,vf610-i2c", .data =3D &vf610_i2c_hwdata, },
        { /* sentinel */ }

However, there is no "fsl,imx7d-i2c" in i2c-imx driver compatible string ta=
ble, but imx7d and imx7s both needs this errata fix.
Also I find imx7d.dtsi is including the imx7s.dtsi, so I think compatible "=
fsl,imx7s-i2c" is more reasonable in imx7s.dtsi.

So I add the patch to change i2c node compatible in imx7s.dtsi.

BR
Carlos

