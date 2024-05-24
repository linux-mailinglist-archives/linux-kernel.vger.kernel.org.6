Return-Path: <linux-kernel+bounces-188661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BB18CE50A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894281C20B04
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB8686266;
	Fri, 24 May 2024 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GVTGvE4u"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2047.outbound.protection.outlook.com [40.107.13.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F355B85937;
	Fri, 24 May 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716552500; cv=fail; b=aaCoVuwVnvUoHoD2TUyiBFoV/LZR7HS8b+C9pwNw2hH5g/5h2BGIvCaxzoSILMpT6R2VFhZLu9R6ugK2bokIpbI1rcDdwB3Yz4XsvVdDcFv6U91QwQVwV3AuZCvqxyFn9eTrYN+nesJGtzF6MQ3+IBQ+MaTdRIOGNWf+O0rfw0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716552500; c=relaxed/simple;
	bh=pl5jpx1RjWoa2L8hglVJxVaM+8N+GqotFGMlG+8w5iI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AKVd/mXmnlSqmkjDaXef5swhJ2tW39leYPgUQLDDOjvOrzmsazQ7cwJPy2WJ45eB3CurSwIRWYr8LREL95fFzypKXMwYCVZH4So6Hv2KiEvh9xXjT8h48cV1I2mbLhHeINqkwTQ0nN1ElXwjl0KON26FdADZ19xA4eKqr4UB/dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GVTGvE4u; arc=fail smtp.client-ip=40.107.13.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFHKHR3fKztVfaI2vZtHIBlJ78y81vlItlunst1KpgUH6FJQ3LvE0lXsRTNvrcvdLGgESR8m/ZgwwLhtw2W/y+hzZ1iUmXVvKuDkkR+Ce/YOcVYq8kLirJ0u95SJeW7pCSl9qZHbKPtGPkK7WHKRf8dfuOfDEc25FqyH3eGxieM+a26ils1N3WOz3Bo+BtwhcicfEUnQZJ0mn6puf2xB2YUDeU6b3XodMXVuCtqEwYjm23Wdj/jodYqpRFz7L0SxXw4ZkefataIzHpPxMrdwYyBC/BF/5nNqvskJ0P+2SORgpK+Tn79L9digMCA0GONCZg41mXHtv6GgZWqdSIR0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CveaVuEYH74N/r94bLYrHRbfmpUDQg0ZbZHsqMrrr2U=;
 b=TfHeYCSziF0Ede0lqDEGyOfUvcjXUuaRwtI/z/2MBwT60alvAKgQWbjQHjeCn0DQAjXousf/88r3VkjKi/As/52mxTZGF0HKOaWpYqKe0/+MRQzXplsIz5ov40JB44p9io/FUWExjd1HyGJqv4t1/hbLP4QuIXcCQbbsXHm55KA/57oEvrQdmEemoPZ7ocKW2ynvNp5abQTOVDVjgb7biZ8zcwPTvtWwLw+38TFV0u85zxGQtuL3i2wZxnx27WOQGtaicRa/BCXBTFzpjbbq2whgRKedssLOGQSUgrVB83rxt4W7kQr454ezMoqodt6n30XQvvHFJcML7q8ijG877g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CveaVuEYH74N/r94bLYrHRbfmpUDQg0ZbZHsqMrrr2U=;
 b=GVTGvE4us6d4H2/0Jw9mzIBdTItqk99J8mGCqlSRnEtdVD7Lk8N7k3KE5Kvrmm23Fl1bbQ0VQ8hnCYr3WX8S5BxrTi/GDnjs7wdQdDkQyKuUr191oqiNZReg2yfLjx9FZ8VvLes8iHVjNQLwWvCfZGBGcqV+mihq66utOZapOZE=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by VI1PR04MB7053.eurprd04.prod.outlook.com (2603:10a6:800:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Fri, 24 May
 2024 12:08:14 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 12:08:14 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Pengutronix Kernel
 Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Topic: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Index: AQHarP9ayLdOqCtfLEqTQR0Rf+AVuLGmMeuAgAAZRgA=
Date: Fri, 24 May 2024 12:08:14 +0000
Message-ID:
 <AM9PR04MB860424A71753DBB56D2CEF5895F52@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-4-5a6fd189a539@nxp.com>
 <ZlBtNSeh2VyZsVxq@pengutronix.de>
In-Reply-To: <ZlBtNSeh2VyZsVxq@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|VI1PR04MB7053:EE_
x-ms-office365-filtering-correlation-id: 922cebb9-82f2-41d2-e615-08dc7bea3082
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HuGrXLzTzCJJWTpg284DbTzyZWpaG4gZFOKGbP34Jv62G/Wuw2ew88bdf+gU?=
 =?us-ascii?Q?3GJ80Oz7JwDyq01VTKBIdHTc8cpKbpIo3UdKf+w8xK/yqS3/EQJWyX2r4njR?=
 =?us-ascii?Q?37hMupS3960gkYAC0iceQYV3pkgc5cXPbs/8YSNG456mGwsuXtQ1Tk7oV+mi?=
 =?us-ascii?Q?aQqKwe6F3GHdOHibDdsCVfJnHhyNDLVFP0iTHxoQDtBTGiIzmDasoa1dSYGJ?=
 =?us-ascii?Q?5dEjRqClm9szi9wH4vW26VHR0BAY7M8G5qlsSmNfYHYnnUFpq3QC7hva4/V7?=
 =?us-ascii?Q?GbygWdX2CmLbpfKbio8e0LEufxnGqKx4jgF5ZomaHZYTKtj+D2yDwxFeuyZ8?=
 =?us-ascii?Q?qtkcwi+PPJscNYzntvKw3sWOfhplIQqP5cHN6RRDjc9/JkCy5/oj0PucQOSl?=
 =?us-ascii?Q?mgLDjzpOkFvWFo4j4lXYx2jbNMc3SyR1ol5I48OmuIS6acKN3kLsD/GXl+q7?=
 =?us-ascii?Q?XLpCH+0IwI2JuoWV0IpzOzL+6ZIMi0B6YM/7IWMLgO/gnm0FcPhgMP/xvyju?=
 =?us-ascii?Q?WJ99G9dwK4wR2TAyhoiYhQ6AJYHVYE/61amxyNJcs0PMCRRdnkwXWclESZKC?=
 =?us-ascii?Q?8JI2hfcYGDbAJGU3uMzQghB/dwEc6FM0T0YX5OqjxPC5Tgn/U/KulbbUWbwr?=
 =?us-ascii?Q?mvLnxzd4NCWScCLuMxEj5jXh9NWh3PRisPcLrhNp9VtTCposTDKGpd5/qJyf?=
 =?us-ascii?Q?nUJAsweTA81Ita6SrO0J5av4eWY7MNGFUua6eKmDcKeNo/yqZBZeKNgZB+iS?=
 =?us-ascii?Q?SskOmoO2X32NX0Du63ppEcl1jluiylN1JNvqVLxxwNQ1AuxlFZakTYoa303b?=
 =?us-ascii?Q?7275FO4XueJTFo8R3+Poe/GusZztmVM/jmZNU/XkbJgGoXgh+C3Z49ISikUy?=
 =?us-ascii?Q?UtHhTFD/s4blmXA98dU9otjMX9z5g92pjc3ggwV7rBAm9ajH2SQTi5S6ngtv?=
 =?us-ascii?Q?mgCqvwk3gIga/sWLHcmsLyLdE3+h1X/8So9i2t/+0UQk0zY+r+WvjG9Tq79v?=
 =?us-ascii?Q?zyh4r9LDOEy2tQnNheQLr/zskXF5pYhmM8seQESg2v1sG58xKRDe7ZyNFvvO?=
 =?us-ascii?Q?1BUQm9mMP0PBwqYY3p6JL0uy9xLxHuggKewCH1IjZzs71y5zsO8drqXNJ8+a?=
 =?us-ascii?Q?UuGYeZpKGtt7MRe2o1LdexZ8N5ZRCDxLn+pDj293QIkJN7gGSVMPM1Q6PIVV?=
 =?us-ascii?Q?iJdn/HTiGRLMyHCeiyCaWcWs2cgCRGigc9lb9levn14kix6O4yBMkpb5c4rR?=
 =?us-ascii?Q?cjCWpPUx1y4KG7nbiNBMEWY4uIV1pUJ3UNfbMMGdIw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PGCPzq4jf4ERanDcJ+aiCCYq1ij9u7LbpTkPGZlEdz54T6RSLyYq8JzFXiur?=
 =?us-ascii?Q?Gn09oTtPLndPQ661Ag2PLHfR7tRRvgNucDd7I5zIncjn55JU3Rv0zDUJH39L?=
 =?us-ascii?Q?ZXc5indJFXedhlDyws1eJqYl6nTLEOIdKlrNpTxJJZ1eQ8YYCB91XSxMFkdn?=
 =?us-ascii?Q?MlEe2TmyE9J9zZ1AFcFCbILvUiwbMH/lOj/f8X5U0RT+Nbj4+Qhfxxc6rGbU?=
 =?us-ascii?Q?gVhqAzLGaKtYBEZYPVfWmKyIXjrLqoSe3r5OunaADCpalsMX+CjTUbpBgkOM?=
 =?us-ascii?Q?gi5Y7RC69+6UILa8G70NeBJR+TTyY1HTmuziM2XFM6J6OkOM7/hrwYBgc7cc?=
 =?us-ascii?Q?9G9CQvfYpCGJ+f+rQHg+XIazRgY/+Nn5S9ZMWeJT0XlBTdgLtGlbYoUvcX7T?=
 =?us-ascii?Q?9vX6HDbDlPRnmDK7eQMFI4OXgt4/m+qCqO6t6gtUhzweIRNwDE9+M9pJhLZn?=
 =?us-ascii?Q?0BRNcucXVXS+dwa0D7yb9maAuUbst32sZr5h8CDH6KtYAT4VOyicDI5ZY59C?=
 =?us-ascii?Q?jdLHfxaNB6zoectq1iOdRCbXJF+XPLwe4D9FNcmyAJdNypR1SQV0RFu2e2FN?=
 =?us-ascii?Q?o1e0fygK+0WZJ9bE/5nAGyB8D1I8MQpg2pDIxfFB9Z78NoFa2jMJOjuZeX3M?=
 =?us-ascii?Q?J7Lo/1HoLVF7FSCrzC0OCUdL9MZ1g6AKqQWlO15LPUqORRQWmMX7sYn1aGV5?=
 =?us-ascii?Q?5WNgMnZM4crEW78gfBbaXu4kuwvTomYBrs/1d4Ajb03JSViXgusE1T4akkHH?=
 =?us-ascii?Q?0yi7fF2sP05CtWceSgURuG03qyAKlvazZAT1yRlPaGecA0nl2tq0sGnlCkHT?=
 =?us-ascii?Q?q28sZo3Wuc+tcgCWZm09JDGflL6vNK7s3UtVes0T5YLHuxKwAyRimdv+y2Id?=
 =?us-ascii?Q?O2VrCqY0qAWfVsYd7dgXMZ+nOTh8SoP+MkqALvrUjoT91M2W2HG4bvnEnFUF?=
 =?us-ascii?Q?NCfcqcOr5FLOq85ntf8n64i6ahW+kCcByhDoFzojPtR26msvsSO2kjCQNOV7?=
 =?us-ascii?Q?5K2EIhbAMPpUj/l5Alw9vs5UXyWMm/qDlX0cC04zhkCD2WK9D8loSigpNhhz?=
 =?us-ascii?Q?C7kwrbgGLNHbIrBofsdvjMLH/NjpVY104EQUzdWjRXCJyyPLg1O8rfveym7h?=
 =?us-ascii?Q?8z9ndXztjnQ59ZQvQmVlt2w4IpTDIj90d0MIi20PGQZMjLQi2ZsM856ANumQ?=
 =?us-ascii?Q?aV2iVX96ZerCGloBqXwNjxKW46BwFIPuzGW64DNqvY9b+RJ6GQJuajvqewz5?=
 =?us-ascii?Q?XnGpae0DxRHhl7zK2e2tpIgtrDVoOd7UVPGTwjcLDmVUrkepq7VoBpGJeB0G?=
 =?us-ascii?Q?15J06y0bryy+pGn+OV+WpR8JIdJQ/FmdB531J+RHjD/H5sH+xNHoDXerAL/v?=
 =?us-ascii?Q?gM/4NzsvluQZaI/JIxdl0FgzkppFw34yDAhQ71SoRr7Sj+5a0cRo5uunW6kO?=
 =?us-ascii?Q?HdbpeiQwm2HWjxgtOViMsymf0CwumadrjECJEQpxjpSp7KRv1B2GhAIDYgdE?=
 =?us-ascii?Q?/70xsdhLhI4QpU1FV32hiKX+t61A7tbasMaFgl9TAoac9zdGDmXKA6OvjU7u?=
 =?us-ascii?Q?0NLBe1Zm9OhheR8Sx3PDODONzSVSN9dqjyaN4sig?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 922cebb9-82f2-41d2-e615-08dc7bea3082
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 12:08:14.5660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5bdTFi7DkdjCgG7aladGCC0sFKf4ES8FlIeacVhm8EIkL5wja8YwpTgz6VjndYoH4bl+vz7aCJ//1lllvt3qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7053



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Friday, May 24, 2024 4:04 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP EdgeL=
ock
> Enclave
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Thu, May 23, 2024 at 04:19:35PM +0530, Pankaj Gupta wrote:
> > NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE), are
> > embedded in the SoC to support the features like HSM, SHE & V2X, using
> > message based communication interface.
> >
> > The secure enclave FW communicates on a dedicated messaging unit(MU)
> > based interface(s) with application core, where kernel is running.
> > It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.
> >
> > This patch adds the driver for communication interface to
> > secure-enclave, for exchanging messages with NXP secure enclave HW
> > IP(s) like EdgeLock Enclave (ELE) from Kernel-space, used by kernel
> > management layers like
> > - DM-Crypt.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  drivers/firmware/imx/Kconfig        |  12 +
> >  drivers/firmware/imx/Makefile       |   2 +
> >  drivers/firmware/imx/ele_base_msg.c | 286 +++++++++++++++++++
> > drivers/firmware/imx/ele_base_msg.h |  92 +++++++
> >  drivers/firmware/imx/ele_common.c   | 239 ++++++++++++++++
> >  drivers/firmware/imx/ele_common.h   |  43 +++
> >  drivers/firmware/imx/se_ctrl.c      | 531
> ++++++++++++++++++++++++++++++++++++
> >  drivers/firmware/imx/se_ctrl.h      |  99 +++++++
> >  include/linux/firmware/imx/se_api.h |  14 +
> >  9 files changed, 1318 insertions(+)
> >
>
> > +static int se_probe_if_cleanup(struct platform_device *pdev) {
> > +     struct device *dev =3D &pdev->dev;
> > +     struct se_if_priv *priv;
> > +     int ret =3D 0;
> > +
> > +     priv =3D dev_get_drvdata(dev);
> > +     if (!priv) {
> > +             ret =3D 0;
> > +             dev_dbg(dev, "SE-MU Priv data is NULL;");
> > +             return ret;
> > +     }
> > +
> > +     if (priv->tx_chan)
> > +             mbox_free_channel(priv->tx_chan);
> > +     if (priv->rx_chan)
> > +             mbox_free_channel(priv->rx_chan);
> > +
> > +     /* free the buffer in se remove, previously allocated
> > +      * in se probe to store encrypted IMEM
> > +      */
> > +     if (priv->imem.buf) {
> > +             dmam_free_coherent(dev,
> > +                                ELE_IMEM_SIZE,
> > +                                priv->imem.buf,
> > +                                priv->imem.phyaddr);
> > +             priv->imem.buf =3D NULL;
> > +     }
> > +
> > +     if (priv->flags & RESERVED_DMA_POOL) {
> > +             of_reserved_mem_device_release(dev);
>
> You can call this unconditionally, no need to keep track if you called
> of_reserved_mem_device_init() successfully.

But it will not be called for each SoC.
The memory is not reserved for i.MX95 platforms.
This is required.

>
> > +
> > +static int se_if_probe(struct platform_device *pdev) {
> > +     struct imx_se_node_info_list *info_list;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct imx_se_node_info *info;
> > +     struct se_if_priv *priv;
> > +     u32 idx;
> > +     int ret;
> > +
> > +     if (of_property_read_u32(dev->of_node, "reg", &idx)) {
> > +             ret =3D -EINVAL;
> > +             goto exit;
> > +     }
> > +
> > +     info_list =3D (struct imx_se_node_info_list *)
> > +                     device_get_match_data(dev);
> > +     info =3D get_imx_se_node_info(info_list, idx);
> > +
> > +     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv) {
> > +             ret =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     dev_set_drvdata(dev, priv);
> > +
> > +     /* Mailbox client configuration */
> > +     priv->se_mb_cl.dev              =3D dev;
> > +     priv->se_mb_cl.tx_block         =3D false;
> > +     priv->se_mb_cl.knows_txdone     =3D true;
> > +     priv->se_mb_cl.rx_callback      =3D se_if_rx_callback;
> > +
> > +     ret =3D se_if_request_channel(dev, &priv->tx_chan,
> > +                     &priv->se_mb_cl, info->mbox_tx_name);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     ret =3D se_if_request_channel(dev, &priv->rx_chan,
> > +                     &priv->se_mb_cl, info->mbox_rx_name);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     priv->dev =3D dev;
> > +     priv->info =3D info;
> > +
> > +     /* Initialize the mutex. */
> > +     mutex_init(&priv->se_if_lock);
> > +     mutex_init(&priv->se_if_cmd_lock);
> > +
> > +     priv->cmd_receiver_dev =3D NULL;
> > +     priv->waiting_rsp_dev =3D NULL;
> > +     priv->max_dev_ctx =3D info->max_dev_ctx;
> > +     priv->cmd_tag =3D info->cmd_tag;
> > +     priv->rsp_tag =3D info->rsp_tag;
> > +     priv->mem_pool_name =3D info->pool_name;
> > +     priv->success_tag =3D info->success_tag;
> > +     priv->base_api_ver =3D info->base_api_ver;
> > +     priv->fw_api_ver =3D info->fw_api_ver;
> > +
> > +     init_completion(&priv->done);
> > +     spin_lock_init(&priv->lock);
> > +
> > +     if (info->reserved_dma_ranges) {
> > +             ret =3D of_reserved_mem_device_init(dev);
> > +             if (ret) {
> > +                     dev_err(dev,
> > +                             "failed to init reserved memory region %d=
\n",
> > +                             ret);
> > +                     priv->flags &=3D (~RESERVED_DMA_POOL);
> > +                     goto exit;
> > +             }
> > +             priv->flags |=3D RESERVED_DMA_POOL;
> > +     }
>
> Can't this be optional? Why do you need to reserve memory in the device t=
ree
> for it?
>
No, on i.MX8ULP, there is specific reserved memory region that is accessibl=
e by secure-enclave.

> Sascha
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.pe/
> ngutronix.de%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C76d3450
> b718d4ae732e108dc7bdd1878%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C638521436738802427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%
> 7C%7C%7C&sdata=3Dlacl2GCEAG8iTW9DpwwsrcaS1LbYqg3fw6BJwSUStKI%3D
> &reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

