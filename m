Return-Path: <linux-kernel+bounces-279311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BCB94BBA5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4805E1F221D1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B69918A943;
	Thu,  8 Aug 2024 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dfEsnSXB"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013059.outbound.protection.outlook.com [52.101.67.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A518A6AB;
	Thu,  8 Aug 2024 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114179; cv=fail; b=nfYel44egGvXDjWXX8PD39lnZgao/HeDf0UJVL5KPB+pHK0UUD98V46d1CZ/cJOBwPNCfS7ZPpCsO2+usBFpy+6k4rLTY6CtXhK380Zazr3UE+c8XEsopvtf/VAJXof7nabODAUk5PJn97ZXhTLu4C5oy4rNoL7AXnBST1+PuuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114179; c=relaxed/simple;
	bh=JeBO1cqAICDnNq/oerF2gd6gQMk2aS4ZT1BBOkZFzzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ki7uYC9yyu1JPv4tVZo8ghlNktUPS4myA3HouAQgv9hCtladoBKtUEtTKTgw36mi8Wl/PswauvAaC8VNQgTA+y8IPlzSVq9LJN5ZIp3LoqiqOGxxo9A3LTFNO2+V4hjJydYP5o9dDIQnYUVsKZX/vkL4p4/+LmOzGzJ2jrpUrLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dfEsnSXB; arc=fail smtp.client-ip=52.101.67.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LK1avXdyJYy/qdI1VerGf5wjSw7c+94UrbgOucCGIZ3yHew/qsVRkHM9kSsudPC9aTo0yR+ZHdwkdmMOcwuLz6o4SKBUpIbBNZC2bPCl8QbX6JU9gAHQwsb+HkuxIhzUUzDy8MvnOSRiGfqP8ZfjZnU5cm3HX4v7RbaFDG5TIt+p/RE6R4bZ712uFdBaMcjqh7xJBqGQ3KiPoWEaHW0RT56fgJ9SEvxJVo6U0olrsbjq/odXj7qB5+baFYsxzGVbJhY0XQ5MdTnjf6pgMp2oP9mEAV9AZuOumh8SwfEBufoVvQbLUQJFXOYOVsgnGVI2QeqVf60q8tue+KT6SFzrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgPHw6+VUJoSEUcAewOpewYIUtxotL6LlO4El1TfKcU=;
 b=dSywtHDlFksGjhS/lo2VYLJO6uhEOaJJWEPa/YeSpCeUQJEpdA5kyGgKhiWFWojUzWwyh5/Q2W5Nt+3q5OlWBk+GLj1k6KZfiTN96PatHiejqudrTWmUwC95GYhQ4slDA6fIyV4amk03BtYQ8TmUrl90Z5VW5/s3x5cZ5izokifkby2xUaWSn/u17938zQ0QyDv+x7YrjU47lCuLF6+fsbHpHAUAYy/UmtuD/uAmqT9AD50SkKR125ou/iyXdIWfXU9RUgS667I0SI66i9wMS8YuhgeTDovuxnCQmp5reE15SXR5h43aW/nTuDsX1vbi5jyEUayszSHXk4lPkYfL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgPHw6+VUJoSEUcAewOpewYIUtxotL6LlO4El1TfKcU=;
 b=dfEsnSXBgokHS15O56IIUTjgAlE3Ohjz0D0w1ZZNhdj9e014a2T4bOXRUc4+Fo4UJg1IyRbCZpUw9OJw+X/1FOQgaj4vdKITk9sx8Cusn0LthrBAnBP7j2tA0fDlSnEFHNZ4/Tdjno2Gwsnz15JrSAICeJlWZc0ibu3VSyKytkq+Xj7qq9FOpMjvL2fO9WlZUdIsIc3CV1MW5WuX2B69EKAb6AUtCnEPyt7qJn11Vz6eOIJN+PRbCbRh3rycHgOvZqXtUao7KhU2oWHp/ulrr+6qAz3qO/1/ne3RieVZjNGB/388WaS+/3X7jiFzAkk1+48Ig/+5OJuRrfj6ITElAQ==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PAXPR04MB8752.eurprd04.prod.outlook.com (2603:10a6:102:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 10:49:34 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 10:49:33 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v6 5/5] firmware: imx: adds miscdev
Thread-Topic: [EXT] Re: [PATCH v6 5/5] firmware: imx: adds miscdev
Thread-Index: AQHa2/NcuiznhUStfE6qn0+OVrPkAbIEXw0AgADp6iA=
Date: Thu, 8 Aug 2024 10:49:33 +0000
Message-ID:
 <AM9PR04MB860410277C8329271E12963F95B92@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-5-ee26a87b824a@nxp.com>
 <Zp-8MPdWdAhGG9de@pengutronix.de>
In-Reply-To: <Zp-8MPdWdAhGG9de@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|PAXPR04MB8752:EE_
x-ms-office365-filtering-correlation-id: b7af59e1-9f5d-4017-80b7-08dcb797ca11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?c2iovBd61+Op/l+6zejTHtafTe2QFUwA5HT1nJwNoH/gbXBFMxFA9Zd0pu9B?=
 =?us-ascii?Q?+sdP/KuEjhevcyQY9bIeWEkTWZjISHUyTZWnjaboyivoMGy8yROrfsjemQ/n?=
 =?us-ascii?Q?+BRahUxTofPV8ERO6t/8H/PzfMgfEm+JYx0S9axtqnLGCJ2dEQPqFAiU3QH2?=
 =?us-ascii?Q?wVwt2v3B5BroF8Rsdi1JYlKTSEWbfg87nyvipg5SsLIY8Uh9DH+MY24kJAE7?=
 =?us-ascii?Q?3YCJoGDF8e3Iv8TmV84ZDwRCViViNzVVPtpS1/fhZQ5CUz0yS0xnTbuuee6X?=
 =?us-ascii?Q?CO3JXTxyqloQw43KXzNvKjv8012MWzONEm6hIVfWVpN2Kf+7VIzRhGLsfgP3?=
 =?us-ascii?Q?xHoasQjGDddaR364/1tFR4JQzA0KzEjgdyCQ2ywPmjQirc63NOzvgoxTfTih?=
 =?us-ascii?Q?8+i7L61ID3UqcC5EVQMLDJQgQE+5JY3hsOqVuoAQDzzUrn6gWF8XT42uoAPB?=
 =?us-ascii?Q?9241CZ3MPysc08d1QBuhFK4y7OeTBREX9PztyDR1btIiAxoYFJvjDFCHtRNg?=
 =?us-ascii?Q?K1soepjo6J7rRvyRLuMIqVxZyoD72er3ER77I8UGTIff6imwxOKBEkIMVA7C?=
 =?us-ascii?Q?hO1DlLYNfg4xQ7a/AsWCPdiWZQmdAVmv5jw0+niBCCNwkJa8CDAl3BtW4K/0?=
 =?us-ascii?Q?ArequLPQ6dA01O3yPgKealNZN1e2y51iy0/EdHPyGC4zJ+77sLq8jzzRhjIa?=
 =?us-ascii?Q?z7rw62RoZJ4lmWQUSdk6t1pDHFACOI7+dLh/BowTzN6++/663lbhiVs7H8oF?=
 =?us-ascii?Q?IZ9HeSV++bsLup+oazCpYel0+hSrVVMZgM0sAy62ePTq10OK8QCf0n21ND6W?=
 =?us-ascii?Q?Pw+aFsrxUVfy4kWKsy2bqJd2J1aRzlr6S7a2G611Z38RRL/P9f89fEFyCPW1?=
 =?us-ascii?Q?iq9xBEAi/GfkIHav2VmGpB/j0Tf+KuKWM1T/qw4sZRU8EdnVuiW+wCH4rYEX?=
 =?us-ascii?Q?BtHn9lcwBIqtxjTRF5GsFY+IHJnEsiMmNtB8F8kEsduQ9dDbD8usjQ5s4Gb8?=
 =?us-ascii?Q?Fd0mavv3gSJbErR7CrlgMGEAkNwqr8DVdDnxvhDWAZWDZ9ePOFpLMdbHV/lC?=
 =?us-ascii?Q?LdLArsyCqmFrNWiJ7b2EHow/PwqU2s1RjyDS82u+S+bIejwF3ShRtFvVW3YJ?=
 =?us-ascii?Q?nHnD2KoCNbpyswLeJLzsb6Eg1w9nBQTsSIYF2fUQC9CZhSNKZ042OltsVTzk?=
 =?us-ascii?Q?7kEz1CdpYCQMJE/n1Dld4WAFi3/Y2yYEdirci3shKveOPNBkTE2OlfovlLo5?=
 =?us-ascii?Q?w6xbIDqfHHM+OA7NNJpzhrAX02BtyhTihcmvFHO42whm75lSzAcNuJpodfdJ?=
 =?us-ascii?Q?fwiaBvyKuj641+HEZsNJxSIAuhqD6ryCeyH/8ZT6Ef2acXBN95FvDmbic2LZ?=
 =?us-ascii?Q?zggpz5id4eA+wrYZQ603NcyNtYOb0mM46g9E+x4lxHKK+xPjZQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JeK+KEn2T6sSnxHD6d84oFtZW7HfeYZ+O7tVkjdXe6UiNrJEfhLqjOrXgGKn?=
 =?us-ascii?Q?OGVfY7Lq6T+JyWrokK6KIabjLHzmvt8Zrbojzt6zxGM+anXdn5/T21UB0uXM?=
 =?us-ascii?Q?oqRqRa0+ohlxKTAzHoqjlxlD38ZmrB7gs4zcD5NdZ74I/eBM4sJyayvk7yv4?=
 =?us-ascii?Q?TsHCqzlDoc9TVXtVqxN4siV47hQDCzMw8bC5FdI1cozvDjp1GCz7mrUfsDy3?=
 =?us-ascii?Q?wuGnraojoYzEdgr+dPMp7xoAct1s7JppOpI/x8fPcFk9ouqPqXgfRVe3oRMZ?=
 =?us-ascii?Q?mOR6IIewN/Vfzlhu7A07OrCIlGIJ6S6haLwKdWoyhCLBLENQFW5HMiXLlKfc?=
 =?us-ascii?Q?oLe5FbMyIkkFzm2YthBWtnSKB5bJKDb+CvJCkwdP4HPWhON6As31TDISz4RN?=
 =?us-ascii?Q?0A8MuK3MZ4tW5mjFYuway0Wz46KI5x3N/AKf54U2HjUlUfjll5GlXnIgknwz?=
 =?us-ascii?Q?8roZDBrd52o5IWa7rhH8Jt8zV1EgJn9TRcW8XOtc57igSAsUPUexWgmJzgzp?=
 =?us-ascii?Q?AT3gSidVg55ieX5ChcJn7ZcXtreNuOH7otSBN2Ty5ju9Fn8Mlv6eHDrWnvnc?=
 =?us-ascii?Q?o5OnfWT+wESPV/N4frsipLTq1ARhUfCszPbCJmKdTcCPW4OL2p8hBJ266w7R?=
 =?us-ascii?Q?Z8is1wIcRn21Y7y270mLZKT6lSCHkItm5KIvxRQp4nlosJG8qunNawTLx80q?=
 =?us-ascii?Q?ujph2AgvuvG+m7YKIvyMa8TmLikDEhQtFHONUy50SqU2iVOIGkMYzPpXEe3+?=
 =?us-ascii?Q?LpKaSAcwV2rqfTtPJ8NWJLrgTvg9c8SWj8MHvuSz/yzLZd6y5yrHWBMdKZjM?=
 =?us-ascii?Q?kIrgV6wyqDgwcENyFfKk87r+wRfPBwVueKuIdJJALAvxhvquAfW6qwnOYlf4?=
 =?us-ascii?Q?xpfavGspSZUSu1t10C2kXNeYTPYsWnVOmGQYkz5NnZavu3ypwCFCS0eHHzBp?=
 =?us-ascii?Q?yMUU6Q4CDTpORnMADjHHsSDTv13GSC1vaNz8ZUXnwEjsrXIiBrP0AoM7OxDw?=
 =?us-ascii?Q?oucAE+sa5AH6XOqIl2T2j2zAkpTV6wsuEqAJ0v4+IOsWxEy57LgTI6W8uLAN?=
 =?us-ascii?Q?02xjhbOVLvTIGl0V0BMjzX/KGzl5P2KwhWUN+FK30QC0iDM889HoFxa/UL7u?=
 =?us-ascii?Q?X0LhDQg0WziHAVE0zTm1jV2REB7s66hikT+HB5YHe7dz7SdhVww3pP1EehEs?=
 =?us-ascii?Q?TSAsOv4BGC/+Gwt6gonS8dCfviOkfQOAyi4alhBQS5/IDT7mcN/lJwxcLIHZ?=
 =?us-ascii?Q?SQ3KQ7lGjszqSlC0VNjuLNgSRs9tanpuZW9vCnFbonyTr1zZlr33TM6oO1yk?=
 =?us-ascii?Q?BUpIkulOwgZTVaqkW377Qaxd0eUDzVP+P6W1s13oxQft0q2j97a4sP2JZFO8?=
 =?us-ascii?Q?+XGt9N1NNTnPW3fOFplbUG31b1ULlmPWFkgBiae1mSgXjoAygA6/8p+PN3Go?=
 =?us-ascii?Q?BvFtJNogy6fAT6y6T+CHcsWf2fkAMoA4RW1giIhxIumrEiNUEXSR/F+cdLn5?=
 =?us-ascii?Q?DRXmZ4gFn2oskS9sLdtRm1i3jSi4sc/rhSpIHS8FmZmTSrqSHyLBGi5nyZcq?=
 =?us-ascii?Q?jL1oaKF96zJNEHZ09v0yGeQo6JFXkfiPXbzkxoSP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7af59e1-9f5d-4017-80b7-08dcb797ca11
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 10:49:33.7417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yru9DCumwV3B8FxeFlGfIfoqiH+piKagobmV8tKbD//IXtbCkVg2JHi/isyATVzw6eVxrVVs3hSOQSoI+WDIWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8752



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Tuesday, July 23, 2024 7:51 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v6 5/5] firmware: imx: adds miscdev
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hi Pankaj,
>=20
> On Mon, Jul 22, 2024 at 10:21:40AM +0530, Pankaj Gupta wrote:
> > +static int se_ioctl_cmd_snd_rcv_rsp_handler(struct se_if_device_ctx
> *dev_ctx,
> > +                                         u64 arg) {
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev_ctx->dev);
> > +     struct se_ioctl_cmd_snd_rcv_rsp_info cmd_snd_rcv_rsp_info;
> > +     struct se_api_msg *tx_msg __free(kfree) =3D NULL;
> > +     struct se_api_msg *rx_msg __free(kfree) =3D NULL;
> > +     int err =3D 0;
> > +
> > +     if (copy_from_user(&cmd_snd_rcv_rsp_info, (u8 *)arg,
> > +                        sizeof(cmd_snd_rcv_rsp_info))) {
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Failed to copy cmd_snd_rcv_rsp_info from use=
r\n",
> > +                     dev_ctx->miscdev.name);
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     }
> > +
> > +     if (cmd_snd_rcv_rsp_info.tx_buf_sz < SE_MU_HDR_SZ) {
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: User buffer too small(%d < %d)\n",
> > +                     dev_ctx->miscdev.name,
> > +                     cmd_snd_rcv_rsp_info.tx_buf_sz,
> > +                     SE_MU_HDR_SZ);
> > +             err =3D -ENOSPC;
> > +             goto exit;
> > +     }
> > +
> > +     rx_msg =3D kzalloc(cmd_snd_rcv_rsp_info.rx_buf_sz, GFP_KERNEL);
> > +     if (!rx_msg) {
> > +             err =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     tx_msg =3D memdup_user(cmd_snd_rcv_rsp_info.tx_buf,
> > +                          cmd_snd_rcv_rsp_info.tx_buf_sz);
> > +     if (IS_ERR(tx_msg)) {
> > +             err =3D PTR_ERR(tx_msg);
> > +             goto exit;
> > +     }
> > +
> > +     if (tx_msg->header.tag !=3D priv->cmd_tag) {
> > +             err =3D -EINVAL;
> > +             goto exit;
> > +     }
> > +
> > +     guard(mutex)(&priv->se_if_cmd_lock);
> > +     priv->waiting_rsp_dev =3D dev_ctx;
> > +     dev_ctx->temp_resp_size =3D cmd_snd_rcv_rsp_info.rx_buf_sz;
> > +
> > +     /* Device Context that is assigned to be a
> > +      * FW's command receiver, has pre-allocated buffer.
> > +      */
> > +     if (dev_ctx !=3D priv->cmd_receiver_dev)
> > +             dev_ctx->temp_resp =3D rx_msg;
> > +
> > +     err =3D ele_miscdev_msg_send(dev_ctx,
> > +                                tx_msg,
> > +                                cmd_snd_rcv_rsp_info.tx_buf_sz);
> > +     if (err < 0)
> > +             goto exit;
> > +
> > +     cmd_snd_rcv_rsp_info.tx_buf_sz =3D err;
> > +
> > +     err =3D ele_miscdev_msg_rcv(dev_ctx,
> > +                               cmd_snd_rcv_rsp_info.rx_buf,
> > +                               cmd_snd_rcv_rsp_info.rx_buf_sz);
>=20
> Ok, here you now have serialized sending and receiving messages,
>=20
> With this you no longer need priv->waiting_rsp_dev, dev_ctx->temp_resp an=
d
> dev_ctx->temp_resp_size. Drop these for further cleanup.

It is very much needed.
- priv->waiting_rsp_dev, help identify in the callback function that:
	- the message is targeted for dev_ctx(user space) or dev(kernel space).
	- the message is targeted for for which dev_ctx.
- dev_ctx->temp_resp, this buffer pointer is needed, to receive the message=
 received in call back.
- dev_ctx->temp_resp_size, is needed to compare the size of in-coming messa=
ge.

All the three are needed in callback function.

>=20
> > +}
> > +
> > +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> > +                             u64 arg) {
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev_ctx->dev);
> > +     struct se_if_node_info *if_node_info;
> > +     struct se_ioctl_get_if_info info;
> > +     int err =3D 0;
> > +
> > +     if_node_info =3D (struct se_if_node_info *)priv->info;
> > +
> > +     info.se_if_id =3D if_node_info->se_if_id;
> > +     info.interrupt_idx =3D 0;
> > +     info.tz =3D 0;
> > +     info.did =3D if_node_info->se_if_did;
> > +     info.cmd_tag =3D if_node_info->cmd_tag;
> > +     info.rsp_tag =3D if_node_info->rsp_tag;
> > +     info.success_tag =3D if_node_info->success_tag;
> > +     info.base_api_ver =3D if_node_info->base_api_ver;
> > +     info.fw_api_ver =3D if_node_info->fw_api_ver;
>=20
> This really shouldn't be here. You pass cmd_tag and rsp_tag to userspace =
just
> to guide userspace how to construct a message.
>=20
> This shows that the messages should be constructed in the Kernel rather t=
han
> in userspace. Just pass the message content from userspace to the kernel =
and
> let the kernel build the message on the sender side.

This will help collecting user-space application logs, with correct tags.
This is already used by the customers, for debug.

>=20
> > +/* IOCTL entry point of a character device */ static long
> > +se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg) {
> > +     struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_dat=
a,
> > +                                                     struct se_if_devi=
ce_ctx,
> > +                                                     miscdev);
> > +     struct se_if_priv *se_if_priv =3D dev_ctx->priv;
> > +     int err =3D -EINVAL;
> > +
> > +     /* Prevent race during change of device context */
> > +     if (down_interruptible(&dev_ctx->fops_lock))
> > +             return -EBUSY;
> > +
> > +     switch (cmd) {
> > +     case SE_IOCTL_ENABLE_CMD_RCV:
> > +             if (!se_if_priv->cmd_receiver_dev) {
> > +                     err =3D 0;
> > +                     se_if_priv->cmd_receiver_dev =3D dev_ctx;
> > +                     dev_ctx->temp_resp =3D kzalloc(MAX_NVM_MSG_LEN,
> GFP_KERNEL);
> > +                     if (!dev_ctx->temp_resp)
> > +                             err =3D -ENOMEM;
> > +             }
>=20
> cmd_receiver_dev isn't locked by anything, still it can be accessed by di=
fferent
> userspace processes.

It is not accessed by different Userspace processes. It is a slave to FW.
FW interacts with it when FW receive a command to do any action, from users=
pace.
Hence, it will be executed under command-lock.

>=20
> Besides, when already another instance is configured for receiving comman=
ds I
> would expect an -EBUSY here instead of silently ignoring the ioctl.
Ok. Accepted.

>=20
> > +             break;
> > +     case SE_IOCTL_GET_MU_INFO:
> > +             err =3D se_ioctl_get_mu_info(dev_ctx, arg);
> > +             break;
> > +     case SE_IOCTL_SETUP_IOBUF:
> > +             err =3D se_ioctl_setup_iobuf_handler(dev_ctx, arg);
> > +             break;
> > +     case SE_IOCTL_GET_SOC_INFO:
> > +             err =3D se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
> > +             break;
> > +     case SE_IOCTL_CMD_SEND_RCV_RSP:
> > +             err =3D se_ioctl_cmd_snd_rcv_rsp_handler(dev_ctx, arg);
> > +             break;
> > +
> > +     default:
> > +             err =3D -EINVAL;
> > +             dev_dbg(se_if_priv->dev,
> > +                     "%s: IOCTL %.8x not supported\n",
> > +                             dev_ctx->miscdev.name,
> > +                             cmd);
> > +     }
> > +
> > +     up(&dev_ctx->fops_lock);
> > +     return (long)err;
> > +}
> > +
>=20
> ...
>=20
> > +static int init_device_context(struct se_if_priv *priv) {
> > +     const struct se_if_node_info *info =3D priv->info;
> > +     struct se_if_device_ctx *dev_ctx;
> > +     u8 *devname;
> > +     int ret =3D 0;
> > +     int i;
> > +
> > +     priv->ctxs =3D devm_kzalloc(priv->dev, sizeof(dev_ctx) * priv-
> >max_dev_ctx,
> > +                               GFP_KERNEL);
> > +
> > +     if (!priv->ctxs) {
> > +             ret =3D -ENOMEM;
> > +             return ret;
> > +     }
> > +
> > +     /* Create users */
> > +     for (i =3D 0; i < priv->max_dev_ctx; i++) {
> > +             dev_ctx =3D devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP=
_KERNEL);
> > +             if (!dev_ctx) {
> > +                     ret =3D -ENOMEM;
> > +                     return ret;
> > +             }
> > +
> > +             dev_ctx->dev =3D priv->dev;
> > +             dev_ctx->status =3D SE_IF_CTX_FREE;
> > +             dev_ctx->priv =3D priv;
> > +
> > +             priv->ctxs[i] =3D dev_ctx;
> > +
> > +             /* Default value invalid for an header. */
> > +             init_waitqueue_head(&dev_ctx->wq);
> > +
> > +             INIT_LIST_HEAD(&dev_ctx->pending_out);
> > +             INIT_LIST_HEAD(&dev_ctx->pending_in);
> > +             sema_init(&dev_ctx->fops_lock, 1);
> > +
> > +             devname =3D devm_kasprintf(priv->dev, GFP_KERNEL, "%s_ch%=
d",
> > +                                      info->se_name, i);
> > +             if (!devname) {
> > +                     ret =3D -ENOMEM;
> > +                     return ret;
> > +             }
> > +
> > +             dev_ctx->miscdev.name =3D devname;
> > +             dev_ctx->miscdev.minor =3D MISC_DYNAMIC_MINOR;
> > +             dev_ctx->miscdev.fops =3D &se_if_fops;
> > +             dev_ctx->miscdev.parent =3D priv->dev;
> > +             ret =3D misc_register(&dev_ctx->miscdev);
> > +             if (ret) {
> > +                     dev_err(priv->dev, "failed to register misc devic=
e %d\n",
> > +                             ret);
> > +                     return ret;
> > +             }
>=20
> Here you register four character devices which all allow a single open.
>=20
> There's no need to artificially limit the number of users. Just register =
a single
> character device, allow it to be opened multiple times and allocate the i=
nstance
> specific context as necessary in se_if_fops_open().

Accepted.
>=20
> Sascha
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> pengutronix.de%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C5bb7
> 0a0c3bcb437e2e3808dcab229d77%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C638573412358069325%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C0%7C%7C%7C&sdata=3D97GKp2ydNvQz0oOwGp0dM3eez3L8IAE1sOqC
> 3bhAxd8%3D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

