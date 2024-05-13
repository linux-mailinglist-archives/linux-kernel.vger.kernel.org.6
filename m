Return-Path: <linux-kernel+bounces-177348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 120498C3D33
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DACE1F21C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2F4146A6A;
	Mon, 13 May 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EO18oQo4"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A8517F3;
	Mon, 13 May 2024 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589087; cv=fail; b=iTrmmbn9FobTO/ZWuOWgH1jiqRtLlZHpEHG5DYCnR6KIpixMZ/GijPrthPT78CkcQUE9gWHc29G/KeuJkimIEgS/H7qVPccb/DjpGkhh9pvo0OU07kKMOLDu8IbRCSA88gm1LbdwJx45GbtxjaIREzf1d1kTMM0qBJVo+Z+vWbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589087; c=relaxed/simple;
	bh=CpTbhBbB/GIlQ+4kCmBkLcYUeNQZvGJL3ob+0GK7blk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eDqdrgoOjPmBkLJ4kBBVlp9eh+rKM3ql2Ih3KQtSjN1xLbGTE3hx1m60oroXg4NLMbfhyLWNahnXBYXge8w/nzT8sQM8Zg8LgtZfmWFsmgS/sYJRdQXWEac2TQTlerNZWKuSXJaaWLgqLyrsszkQXJRpWre2ovjiQRaSv/eW/mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EO18oQo4; arc=fail smtp.client-ip=40.107.6.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brNSGC3Bp5rdms2oZ5syI8S+IiUIJmS6DhmdEN6s2dgaBmq+7iYrgCP0Q5tog2CGwm6lluhTJ84163rj2nAtSFU0VWITWqLneIJ8u6eE3r7/sj712jNN9nEzWKtjQU6mWnCMS9y0QbwF0/v99kYol26VWuvBlBFrfNM3r8fSYYaEMY+iP33uCmV6dr0OcDOSNq3T0C/TBdttf5AcFgiMydY6WtWo5Aa496Wi9izA0O+x6ReHNUrvdBL8WpEeplOW7nvIJ0K2UUvDOJDMHnSKXF5lhPRTIwqF2TbdpxW1o152/GNSYiF+zJ7mJ69vQwJ9K7vPLPtiHmGelfu8di/pTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYOQaoEGXePCQFhA/OW7SOjT02okixGvZEM85LXLF90=;
 b=Mp4/5EnIcYzD5wYhshL5ucLsMQ+HADgHll/p4+leNjdxUl8hKRVYLBg3MeM4g4W7CgjOOv/D1c2dl++UEtuHlEUCloTnF5IUfwpSfiPns19HyLayba0AjmSMmRAld0CzRZj7AjajHllBf2v539EnRzLKT7SglqMx+yxpXC8HdHJDqYepMMlO2RxbLM6/Wqz+Mgkj5ApWHRbs0Q8Cq0PigNqw8zn6hGn/VanBHHQQpfou5+OTAAuHDDXfg6FnCI+BNElN/JM9L8EFfCa1eHu+IVny0qgUw8RfcNp7dDBtTEEsp6/n39Vp1DSHf6ehKxyNkUp/3Ji01jNPDQ9+3sheDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYOQaoEGXePCQFhA/OW7SOjT02okixGvZEM85LXLF90=;
 b=EO18oQo4hC7DtAfv2EaWYhurTDSeXHle91g7Uj6zeJndyn13maX0fG4idMX3NSwy/n9o4s9UIt6J6l2TfXMwfRgQnW7dUhE+aK7aP8koI6nsQy7nT2TanRG65Sv6ypp4eMtw39cmfj328AlO2xIchwoVNnhDNA2GhuKisjnUEUs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8258.eurprd04.prod.outlook.com (2603:10a6:20b:3e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 08:31:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 08:31:22 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, Ye Li
	<ye.li@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Subject: RE: [PATCH v2 01/17] clk: imx: composite-8m: Enable gate clk with
 mcore_booted
Thread-Topic: [PATCH v2 01/17] clk: imx: composite-8m: Enable gate clk with
 mcore_booted
Thread-Index: AQHaorn/IJcAguxNukGP/b7YV5Q9pbGUuy4AgAAe3+A=
Date: Mon, 13 May 2024 08:31:22 +0000
Message-ID:
 <DU0PR04MB941709208F206C9CADF320A288E22@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
 <20240510-imx-clk-v2-1-c998f315d29c@nxp.com>
 <ZkG1put2k33K4c_b@pengutronix.de>
In-Reply-To: <ZkG1put2k33K4c_b@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8258:EE_
x-ms-office365-filtering-correlation-id: fa03e10b-d80c-4262-aee5-08dc7327125b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nendKFzJ6SMEnqhuWtaTNOhbRK56+8u7ylte5eNpOo02/5ZtTE1Qq+IdnwLT?=
 =?us-ascii?Q?zN7WYoVQFlEQ/Cb5cGhcg/V/uHdY6onXNQ5pdHATnlOg/FmApt0yPmTX2BDG?=
 =?us-ascii?Q?IYAvWMxVwsGcCF4qcFx+yWJsl2uZ06LWYl2XI63PrpN//CdB2tpHoNCvICoy?=
 =?us-ascii?Q?JVGhSQyObRJNb4WBr51qsiJ3cp4WO407n4gmU3nqO/UiehXfrHchoMEYf5DL?=
 =?us-ascii?Q?Nv5x0zfmY3+exozfM3lzjqRw43sifNj7oNVq1I/IHQClFw8+goVTC6LjnaBA?=
 =?us-ascii?Q?fD1S6ftn3C/in7o03q8P9HCOjMLz+Dm07gnUKZgTUdgpuYtzokwGxISyanYk?=
 =?us-ascii?Q?yPzT2jiwE3iUEwP2V12nkjERT8H3F/OxYu4Gm3y9Pk2usOK0w16uI6zDv4IH?=
 =?us-ascii?Q?y5ySKPVVEBzTfB2OyTv40k4sNhVvoe5Sdi1YzAENLp8t6iMOlEFjtdrVWJVi?=
 =?us-ascii?Q?5evn+kLIMXLjjwNzp2NpQnUoFZF70f6UPxKJywmfJsD8FmQ3TQ/ldCelMShu?=
 =?us-ascii?Q?WOZhmKkCW1jwMAx9iqPLqyNn5f0kkFY3/+d/Z2P6I4qruKVpABXtTemaVdJu?=
 =?us-ascii?Q?+loGZVvg66+B8a06qTOpkB4IHAj3rS9nU0Nror/HAfkDFTYoo70KRcH4BEfH?=
 =?us-ascii?Q?BzYEJGYk3RJyTNwyfjs0KCwVbbSjSo+Y2UX3fcyQh8FXTzTULx1ot/rtVTG5?=
 =?us-ascii?Q?0wZSKT3p/Y6h0G5hI++5Yx6KWMP7TsdOmGVY8afyg4qvXE9C7MMLAE4Nyxi3?=
 =?us-ascii?Q?pWGvG7OuPWTpdm9n4owJtECCH8nrXvfg3nzndh2wQRc4RnBDGKDFCwGt++aw?=
 =?us-ascii?Q?wf3IikwIWppV3TAAXq99bx3Fg0qDDl5igOp3lpjnigzdVTS7XO00y91D/DA+?=
 =?us-ascii?Q?KLWqCE9ZCNP0Tl0BXsC85pLjSrY6rRSyWH6TQxmintjAk7zJ+40WGJg5BNSr?=
 =?us-ascii?Q?1ka1dQG9TqJv76a5ca/36BH8Ueu6wgpyl4nwqU2GI5RROBaPXSKkjcEbTUK4?=
 =?us-ascii?Q?7OsWTowFI1mW0uKy8+0Wcfr4Jg6oIBpdqlAaQXGCbP+kEcd60NW8BpSybg8k?=
 =?us-ascii?Q?lOb0ryLgwwy9k+qns+liE1OeGZgKhgFKilWkM3M5xGASrsng2i3Mp+HCyWZK?=
 =?us-ascii?Q?fY8iV+VHosz83QTRPJWVQ4hjXo6Fmjm5why6m5ZjhC05qDyZcFHYZ0IQVx8i?=
 =?us-ascii?Q?sIuaOc+ljAQwoFaMi088HWPsy/AeHhLNvuHOlmSDDsqwI8KPy6igsyOJJXYw?=
 =?us-ascii?Q?OL/NkZNQjjqrVDL/yUzZTTcyWwoKZWkucS6scIRNRg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n1r7v8NLsws1KuvMBUJbtfB1lr5u2z/r577dUfzdwYlDXvtH4JvvvBBteE95?=
 =?us-ascii?Q?0ZF+5ApYc4UR8M+x4xMjGELy06KGaJURroXvzx+z4RyPyFBfJpNWEAiIfjCT?=
 =?us-ascii?Q?Z5bqAbmgb0ARXOsaf0IPeaLLL2OLrZ5q8RNMwS6z8ogDLvgXNSNWteV7zpcv?=
 =?us-ascii?Q?Wf/WktDI0IJCl35c70MItP7nr2kensutqH+WY3rXItG+/geDZgFQQR415msG?=
 =?us-ascii?Q?XlgaUCqjcWxQLVLpg7tqEtKwu/QDhfGmKycOwOEThSsouu0UQVpJBiulxGu4?=
 =?us-ascii?Q?8/BtFz9aVn+Cw9TeLqzH9I07biFbKl+urKBxUH+7hVGvkG1t5sj60dkB9Pkl?=
 =?us-ascii?Q?eQQfewIVmlkZnP/dzYSm9HmKsuiSGnAC8B2RbIcbcdSXMBBGrOxEKxdPCZtu?=
 =?us-ascii?Q?iug5+ZDefMClPgaU6LjFt9u/PbpM/pf4wSQsLu9z9qlEbnQGy6fIWXF8+xYj?=
 =?us-ascii?Q?k+cKhXRsXf37s0eLD2Qn8A9gflTcq1r/RuyZ99tUsXXEAXfDRd2Do9cTDW2F?=
 =?us-ascii?Q?h7j1BM73ktL7/GddcpmlwzQHSy9SLfJyaHd+uRMDDuO//aSU+BSKdXI1UM+a?=
 =?us-ascii?Q?1xbj1uAnYd53kxhuTisDAFZJe+bdcCaIx/9qP0JgMIsV+4sTSVe8vKO+CLwY?=
 =?us-ascii?Q?zt5kQOjVuE+GS3XWyGvhhICqgGCU+Wd5ftK2dV7FH81aJVpxhFVqkf7ovxAc?=
 =?us-ascii?Q?vCQa3G2QU7D3xmdf44DDYQSZqaq/IbnxV1N+RYdG+YD//AmIqhI/ays7x/LX?=
 =?us-ascii?Q?OZXmns7ZV7yAQZw/B0RZPysBqgBD8YXMfZ5jMqTmqb6AxBMiECF1U6CdS9RT?=
 =?us-ascii?Q?ZPkV1fQJX7sGu5kPL5zWbtCMkIXeyjj7UEV8KgO3hcuoh0MYw2oPhfJr4dW4?=
 =?us-ascii?Q?iDJ6+sVedgbQoEEequxrgNdeRmnXU1tWUoGOV5wbif8geP+vFg0zgjLf6N5x?=
 =?us-ascii?Q?ZaU8KVVVLy+G3gMCpyjFbT0YOYK6lULiF3NU1cHkBpsSE1k5H3TPKTNrEmNz?=
 =?us-ascii?Q?VermrfEzSgqRBOdSTXDYkPoPUGXrV0QNlb5BekzjeVhJITx1ZX5qwT+U/iiV?=
 =?us-ascii?Q?vbV/8BnqIrNWM+tCfrnnUkA+kkUsIzehYXL979D579MQTXpp4OPo5U66tLpG?=
 =?us-ascii?Q?55VmSBqNH6UbVuxWc7SZQ0YSCOaNs2bNs+0D27/aWPzxXBD/+AZBjSSTdzK4?=
 =?us-ascii?Q?qM/uXK4ma9Y5bu7b65MC/sfwQieJf7gz6xDMvFWK+nc5LHV5tWxdTG1CHSZk?=
 =?us-ascii?Q?VEJIBWHYlXNR7qUKQyUaz/CJGL50ZRDrJ0oKNdHwMYycqlPaDk2qc03bUiVL?=
 =?us-ascii?Q?qNl6xMASCUSIHkUN1NuwbCoFWpeFx32eE0XrhMDy9XRci+52jIsc7r3f2u3K?=
 =?us-ascii?Q?+0YhgtwFTjXanYVYOcVVEOrJGYjSEmhplo3WbZ3Xq/56BjkunQdCL755QBHx?=
 =?us-ascii?Q?hu3CNq0BIunahBY7jLTRhoXg/31NsIkEI7e46wxh1kMjshnRQjpzVfXEsips?=
 =?us-ascii?Q?9+1tYYzIZNW1Lp9Vu8EFK9bqWBFc+wKwcoPkUWZ/TQrN61/BJ3HFOtiKPNxj?=
 =?us-ascii?Q?5cbFeunrNj4QK8vgMRY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa03e10b-d80c-4262-aee5-08dc7327125b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 08:31:22.8186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UTw9F6amFhYJFUzAprMocJ69xKxYwcvb+zmUr/7Bbp4e4t+OIlGDXpYaUnpEoTLHUgmlD6zDUyvZ0mnTaN50Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8258

> Subject: Re: [PATCH v2 01/17] clk: imx: composite-8m: Enable gate clk wit=
h
> mcore_booted
>
> On Fri, May 10, 2024 at 05:18:56PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Bootloader might disable some CCM ROOT Slices. So if mcore_booted set
> > with display CCM ROOT disabled by Bootloader, kernel display BLK CTRL
> > driver imx8m_blk_ctrl_driver_init may hang the system because the BUS
> > clk is disabled.
> >
> > Add back gate ops, but with disable doing nothing, then the CCM ROOT
> > will be enabled when used.
> >
> > Fixes: 489bbee0c983 ("clk: imx: composite-8m: Enable gate clk with
> > mcore_booted")
>
> I can't find this commitish anywhere, also the subject looks like this pa=
tch
> fixes itself.

My bad. Picked the first commit when I use --pretty=3Dfixes.

>
> > Reviewed-by: Ye Li <ye.li@nxp.com>
> > Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/imx/clk-composite-8m.c | 53
> > ++++++++++++++++++++++++++++++--------
> >  1 file changed, 42 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-composite-8m.c
> > b/drivers/clk/imx/clk-composite-8m.c
> > index 8cc07d056a83..f187582ba491 100644
> > --- a/drivers/clk/imx/clk-composite-8m.c
> > +++ b/drivers/clk/imx/clk-composite-8m.c
> > @@ -204,6 +204,34 @@ static const struct clk_ops
> imx8m_clk_composite_mux_ops =3D {
> >     .determine_rate =3D imx8m_clk_composite_mux_determine_rate,
> >  };
> >
> > +static int imx8m_clk_composite_gate_enable(struct clk_hw *hw) {
> > +   struct clk_gate *gate =3D to_clk_gate(hw);
> > +   unsigned long flags;
> > +   u32 val;
> > +
> > +   spin_lock_irqsave(gate->lock, flags);
> > +
> > +   val =3D readl(gate->reg);
> > +   val |=3D BIT(gate->bit_idx);
> > +   writel(val, gate->reg);
> > +
> > +   spin_unlock_irqrestore(gate->lock, flags);
> > +
> > +   return 0;
> > +}
> > +
> > +static void imx8m_clk_composite_gate_disable(struct clk_hw *hw) {
> > +   /* composite clk requires the disable hook */ }
> > +
> > +static const struct clk_ops imx8m_clk_composite_gate_ops =3D {
> > +   .enable =3D imx8m_clk_composite_gate_enable,
> > +   .disable =3D imx8m_clk_composite_gate_disable,
> > +   .is_enabled =3D clk_gate_is_enabled,
> > +};
> > +
> >  struct clk_hw *__imx8m_clk_hw_composite(const char *name,
> >                                     const char * const *parent_names,
> >                                     int num_parents, void __iomem
> *reg, @@ -217,6 +245,7 @@ struct
> > clk_hw *__imx8m_clk_hw_composite(const char *name,
> >     struct clk_mux *mux;
> >     const struct clk_ops *divider_ops;
> >     const struct clk_ops *mux_ops;
> > +   const struct clk_ops *gate_ops;
> >
> >     mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
> >     if (!mux)
> > @@ -257,20 +286,22 @@ struct clk_hw
> *__imx8m_clk_hw_composite(const char *name,
> >     div->flags =3D CLK_DIVIDER_ROUND_CLOSEST;
> >
> >     /* skip registering the gate ops if M4 is enabled */
>
> This comment doesn't seems to become inaccurate with this patch.

Right. Drop it in v3.

>
> > -   if (!mcore_booted) {
> > -           gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> > -           if (!gate)
> > -                   goto free_div;
> > -
> > -           gate_hw =3D &gate->hw;
> > -           gate->reg =3D reg;
> > -           gate->bit_idx =3D PCG_CGC_SHIFT;
> > -           gate->lock =3D &imx_ccm_lock;
> > -   }
> > +   gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> > +   if (!gate)
> > +           goto free_div;
> > +
> > +   gate_hw =3D &gate->hw;
> > +   gate->reg =3D reg;
> > +   gate->bit_idx =3D PCG_CGC_SHIFT;
> > +   gate->lock =3D &imx_ccm_lock;
> > +   if (!mcore_booted)
> > +           gate_ops =3D &clk_gate_ops;
> > +   else
> > +           gate_ops =3D &imx8m_clk_composite_gate_ops;
>
> Please use positive logic. It's easier to read.

Sure. update in v3.

Thanks,
Peng.
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.p/
> engutronix.de%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C86a2a0908b
> 83408401af08dc73178043%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C638511791969660985%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%
> 7C%7C%7C&sdata=3DeJJ8rdenU2ACBFUBX0CKKFzhkIQA999b7rpOuMkqgoU%3
> D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

