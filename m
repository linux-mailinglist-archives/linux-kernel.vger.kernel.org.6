Return-Path: <linux-kernel+bounces-544103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78048A4DD62
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118A63A5974
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC81F3BAD;
	Tue,  4 Mar 2025 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NgGEJJRh"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249820102F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089725; cv=fail; b=S2K/zAmfKEjDNeT7a8NJmUS0q9OnZh9ijtE9ml/SM+qNCuUZ/4pMUnE6QAkN4quIjDGaCh7Y0jF15PzVvGrz82/t01Ss6n1OmRxNK+e0oodXYE+IWk47FfDffJA/vRQ3DDmOe6KZz1ObvXPHeF2fNEEwv8gJzdT5aVgde/F+0/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089725; c=relaxed/simple;
	bh=8o5BfgDT/Bl/6s7kY/LGId4VxNPxC23ttWujk7sj9xs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O8b5uW5t95OTB3zaPM3nWDTUgZLPHvZ7xBPXDh+2TkSWFr1sK2pw5KwC/dVf76zDfUVKsRZ4oMMtyoOyJukFVfS474aF6OmaZriO5ysnzPdL/mP0FZNMoozdhgz7C2iXNLTqc64ouF0uYZKe55qH1pav7O8Px8NNguw4VPdYI98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NgGEJJRh; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9d4E5jqtsIZ5m9k0Hj+YFCyXa+xZhqrTJb6VA2hMkdOpi90CWUlzl3W90ky9tXU6f5ko3ScqklqHqpq/KnWlzNNpQDrve1b4dpIW8E5FlSo/bkei08oNczutjLXyRAesqSoVzH8Jl2H6kaQMXp3grgEwsXcFVvgVkjDBRDJFppHDRZug5FVrpyTJXSykrQHux52tohYYSf8UMghVtly0fUapf+lyBcei6Sm0pvl9Kn59v1o33Z7b/AymIsHrCJNz+WPqmL4KBD51Dbm0X0dxJYxBWKrhauVs26bV5BnXjYTZZPmo+iIX1yCGwvwU71NyomFNj0bg7WYrFdE0FYjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4aaskmcDiiGlWNXKNw3X6Qvf9tpKQ0Jue1BQ0vH2F8=;
 b=vNl+GYtOaNjodAkSi/YLb1z4YtL0lBuBf8+StTVpRx0mJpvFtm28DREWYsYwIKZPqHMT50uLbcyr3eVFTGtBTZ3HCNfDyoMylx+FJas55bnLUo13XIrK6z5I/sj53h0z5gHddUWOEqDa37Lrd5bv8guYSA03X3LUBK6XH3gyDsZ6IW47Ogaj82dpjk1ZfyZ6Dim7kp0mc4t4ewocdygjIj9Re4isjR1+ad8CAkItMPWS17opiOkQADO3dcR/86hPMwCEHo2rD+Zf3AnlL8aPdG2lnSnn+EnWJXfAwuEB0x9hqSKbIRkIzgXMd1PSI2pjv3ixPehE4a1bEAGrzk/BHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4aaskmcDiiGlWNXKNw3X6Qvf9tpKQ0Jue1BQ0vH2F8=;
 b=NgGEJJRhOVcVrPUMd92MgK/SaY5cLrgPuwyqdBkRjTLkEbtvUu9akhPOwISIVQac+i5KGj03z5JptNrdopriopsQ7S68tJix5HwQe+RxoU7xrRFaC94miBOAlspzUwBY+QZ9BnVXjX1yLhILmg4TFLEd8/QBy/K7lyAM2Pa7WnzNKtX8jKrUfdRvbTTabcPb1/az3rKk3dGjrhfarFMGV/nV2A+Tl4GZ9pnBetEmWSd5mgni4G/t/L4m+lzaBD6cui/MewETeg+ldtEJCNzOICmd+GYaGFG80prKLSHve2J1OHkDBY0klno3jy903SYUyn2FnfUHLoqXApM+GLUxVA==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by DBBPR04MB7546.eurprd04.prod.outlook.com (2603:10a6:10:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 12:02:00 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 12:02:00 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Aisheng Dong <aisheng.dong@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Frank Li <frank.li@nxp.com>, "S.J. Wang"
	<shengjiu.wang@nxp.com>
Subject: RE: [PATCH] irq: imx-irqsteer: irq_count can larger than registered
 irq
Thread-Topic: [PATCH] irq: imx-irqsteer: irq_count can larger than registered
 irq
Thread-Index: AQHbjOn4IgHKsrBBwUqLLU4QWAWAzLNiwVCAgAABMUA=
Date: Tue, 4 Mar 2025 12:02:00 +0000
Message-ID:
 <AS8PR04MB8642733D81F0A37FBB70902E87C82@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20250304094513.1964356-1-ping.bai@nxp.com> <87bjuh6r9q.ffs@tglx>
In-Reply-To: <87bjuh6r9q.ffs@tglx>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|DBBPR04MB7546:EE_
x-ms-office365-filtering-correlation-id: 41a576d6-3153-4bce-fada-08dd5b145ef6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DDliPtDXNEd3F1mPnYzpEdpDwka28xCbZ5ovt8sk5ct5x9A1uZ3OAeAjN0tR?=
 =?us-ascii?Q?lbAD43Bwj19Ru0UOwusWltNfF8IbJ+UMaBaijyLjbH0MkSEgP8ZpuFVBRjun?=
 =?us-ascii?Q?krqsfgnJZiYXLvUq1UDJ/Qm2bvA3r8a+eRD/7QtifX5os+WrOLtys/x2Ewn4?=
 =?us-ascii?Q?ryyL5+jPjuow221VH8y8aHJYmdpDifV7CzavgI4iotsh1xMH5hEuKAf25Ira?=
 =?us-ascii?Q?aRvIwzY+rWAKrFDzmbXzrT7AX2rkQ8PiLgpmnYvlRz3LnI49dL//s3B2yWn8?=
 =?us-ascii?Q?NqsXFpuE960hLq++FApD6C6voKtCQP4okLj0JCbY5DkwWgUBOJ0FEqRiWgll?=
 =?us-ascii?Q?Zby+6PIWmkhv+JVodkbJGMh3v778pgG5npsjAhqYHjwl5NakbwGmlBezOuSV?=
 =?us-ascii?Q?6Go6kmOssbbm4CC96wPRv0u3oYiThS+W85PWpRUCnonIcultVPlHaEUCQI/I?=
 =?us-ascii?Q?RrUqUNaj+CbaWEotw0wmGDnjiwy885NbH03kMBBId1gwp60BGto3XHntCysm?=
 =?us-ascii?Q?5sjLUcxFk990VlJ0auxVm0mlzxx9KO++VC/bIpSxUGIu8hbuWhsa3IK1Gp9U?=
 =?us-ascii?Q?9sHJtKOozdBcPHALfDc+Zy3PMdT5xYv9VlIQLG2TximoWM7Y8zwFgKOx/iSB?=
 =?us-ascii?Q?8wDW6LVs278v2TXvFtpRnAwaQsD+BvBglMXs1W/NEz7PtZQjo+WEHoBGyiFw?=
 =?us-ascii?Q?CvsgVpNKRg5W+2Zj4PghM1pOwb6LCC215sC+MRbhIGainVyqsswy1wgNohaw?=
 =?us-ascii?Q?2Iy2inKX6dQkOqMUZYmo7x/YQm1xV7EYQh0Z3z7MJkV/6yG0HG8Bt/w8XDMe?=
 =?us-ascii?Q?jQ33D9VO6Goo6vVxfNDJdDtyTuKfl8aYj3JG9JnakKTreLHY/b7unQymvUm4?=
 =?us-ascii?Q?Y+yd59FRf7UD3KxXeCnnqv0l5Rkq/bHRMLq/1Tg+7G5ak5nXel8C2teXnE+N?=
 =?us-ascii?Q?n3ezjndADifJo/oJsLY6Js+tID43xv//dA3Pq+HCjvtBAHGix8r4RVWKqVyO?=
 =?us-ascii?Q?0iGq0uRxkCxzBas7zvLH3Kjr+50MCl46qn+0Un6sOfitQTwwPIR0ubUG2FdZ?=
 =?us-ascii?Q?iSXAVLqYvMFKzuUozjsXtWC+9SsjmxaSBYIw3gn2bFzjIYnuiEnA570yEwBx?=
 =?us-ascii?Q?XzPaMMBw5DEST+pBHhJpNk+j5jFLwz5OBnCmQUw1IcuIuvj+W7+YdbKfqUon?=
 =?us-ascii?Q?eR1LW095w60wfpQgfgp7E4/f/2sixYshbiggWu36t3fesQ7fGqTQAIcUvKlx?=
 =?us-ascii?Q?4SGn7o1CZLZIncQ7wZaZJn6zqGjwJj+Qqjyn+/YSDmVj0OmdcvqzzrKa5pK2?=
 =?us-ascii?Q?fK7jAiLZ0E7E1SUVsgHAron5CAPAoY+OxOYN8FwxIP67/gEQ60HagQ/nMG0q?=
 =?us-ascii?Q?MfL5xTnxjS/1pk/ygKd0Gjqckfx+efpNFDl87gmZlOcWOfMwSIS5fg0q2FEV?=
 =?us-ascii?Q?3VLN4bFiDDy+rWK5LJgj0PpM27DRTk6p?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9U5FU7a+4HSCDvI71TiEQYxMT3VIoctyME/Mrykt9/YVP7jbcHtWX9Jwx0vQ?=
 =?us-ascii?Q?oTrpLMgRHygwHo4J+kkD9dseVvb2VK8BoFgh4O4hUjT6VlbBqUtDXniAsFfR?=
 =?us-ascii?Q?lmq188QFbHbgdNwtOLhBBG8hldCuJc50cC8F9ba9vlFb5F29eOfaeDT9d0uW?=
 =?us-ascii?Q?3gz2GyjVcxPnCO5a4wElyzWpyiR6d8A3qeyFcggAx7/T/jo50v2exFYW5JpC?=
 =?us-ascii?Q?CH3dAhCSCIhxayX1U0ans431FOchpHh6O8SOcIqSmouvIDb4FvakGqum5oqR?=
 =?us-ascii?Q?Pi2+EOkTExfTiWqo3LJVA41YO1trnewQS44UrsESICRFobmHtiqejy0QBTaK?=
 =?us-ascii?Q?UqzDoLPXTPzP6oOoNgQtt+E7BQAv0k62lqqUi0svtHR5Iei3G3feofv//TgT?=
 =?us-ascii?Q?gY+mrYOowaoy95lqEYX2+4OJvsYmi0yl0xq2GihH00VLI20kTqi85sh5u25X?=
 =?us-ascii?Q?n9lRWPU2TJSYaA9mnOurQ+AI9w1kTc/OakAQ3fNyxgfm3c5WcskS5XKBn6QR?=
 =?us-ascii?Q?I0mgxAQnX4VFhmljVN+ysNdm9ZXLuUEcn0CPjIR6GS3Z4OREiGl5p8rrwoOP?=
 =?us-ascii?Q?XYczYl/+NX4wiphvjRO17E/it9YIUi1zjOprVe3TT8M3DTZ/3lz/xpM23f+e?=
 =?us-ascii?Q?ED9NKQQcij16qsn3gbn8BbqEdFyWaK1dWvl3ACJE2L92wd74d6Bnnfc/yoeZ?=
 =?us-ascii?Q?j78JC2Zg2mp5C8f9J3o+lJs/z9A50W8mmidOSG4z4vgorR/beBe01GQHV8aA?=
 =?us-ascii?Q?WXpjPcsOAC+XMU4eSDVZe2btKy59Ubpc1Nw6te+yON5p1Y0t9mBuVo3GNIdA?=
 =?us-ascii?Q?v+cYma6MqFSNgB8JhvGc4g89XOX4Ti2nZozE+es58Fb0SGAOT+WwJ8QgMBOq?=
 =?us-ascii?Q?2XX0AQ6MDfPKnFEzTiowweH5pbNqtUwg4zoXQT5J9DWdRCny4ZFuC+RbDqbb?=
 =?us-ascii?Q?IIFkOuVl6SJRwSAjUMtZpgq1A7uEnYGw3ljyHBI/YeCLYVz6Q57vGl1fB2Bl?=
 =?us-ascii?Q?tUnelqT+7AHUhUhOMpMN9IBQv6Y2puSrA7jCHjN0x2/yca41vI6hATM2gfMN?=
 =?us-ascii?Q?F5nRR3t9iHl9s8pY0L0rwQkq+QnPrUE6+Bgqt0W0LLzwq7TNkxrhX1LQwXaO?=
 =?us-ascii?Q?CKSHtf2xMWBPgWzLRw3YmOHAqKVrsx1mWqoop2rMh/DYmOJYIWvnrINokKHy?=
 =?us-ascii?Q?otznIUrZmvBSAFaqRg6SkELIn0pTHfYFHhHI71XtsSzpne4fS2k/mXb5JHbD?=
 =?us-ascii?Q?YFjnGH1zmLjSN+c/z6gDFHrY8n7LZqQkCZFyK6lVPol3XXBMMTx/j7R7Xr14?=
 =?us-ascii?Q?L7kyiOFA0iQTy/PZgDSv3h+PYw+YBkb9SfuBhunmcdMttlNilSBXUJXFldq2?=
 =?us-ascii?Q?ZNgh0CQRek3xYPyRq15jTmjCGvv3Did7Niah5inYX+kV1YAEOiGrcDN/0qXq?=
 =?us-ascii?Q?odgJTdWZRKSrhTMtIiHYf6Zi9maoGOfX8Ajmvu/3wq8jG6NuHEbaEzwWTXar?=
 =?us-ascii?Q?j4ErfURZE41onNosCa1HQd6dnAA5EWnwzPyOH1xm/iOT/mV1jVG3WrodKHP8?=
 =?us-ascii?Q?xC+oyKPk9jJ7GwGavK4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a576d6-3153-4bce-fada-08dd5b145ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 12:02:00.7127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QiH1ehXrbpzFYTkb3q+o1linl7GjmHc6lIQGKT+cBOh2csV3YI5nJP/IAb7icF1MUdsxhsDKRJWkuLIA5hTZ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7546

> Subject: Re: [PATCH] irq: imx-irqsteer: irq_count can larger than registe=
red irq
>=20
> On Tue, Mar 04 2025 at 17:45, Jacky Bai wrote:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
Hi Thomas,

>=20
> Please use the proper subsystem prefix as documented:
>=20
>=20
...

>=20
> Also 'irq_count can larger than registered irq' is not a sentence and tel=
ls
> absolutely nothing what this patch is about.
>=20

My fault, will fix it.

> > The irqsteer IP itself can support up to 5 channels and each channel
> > can support max 960 IRQs per. The actual number of
>=20
> Can you please write out words, i.e. interrupts, hardware etc.. This is a
> changelog and not twatter.
>=20
> Aside of that: 'per.' does not make any sense. 'per' wants to be followed=
 by a
> noun: '...per $WHAT.'
>=20

Thx, will improve and fix in v2.

> > channels and IRQ per channel implemented in HW is SoC related.
>=20
> > For previous i.MX SoCs, normally only one channel and max 512 IRQ is
> > implemented, But for i.MX94, the irqsteer HW is implemented for 960
> > IRQs, even it only has 384 IRQs connected.
> >
> > That means on i.MX94, the 'irq_number' is 6 but the 'irq_count' is
>=20
> What means irq_number and irq_count here?

For irqsteer, the interrupt inputs are divided into groups, each group has =
64 interrupt
Inputs and use one irqsteer's interrupt output line to raise interrupt to p=
arent interrupt controller.

The irq_number means how many interrupt output lines from irqsteer are real=
ly
connected to the parent interrupt controller, while the irq_count means the=
 max
interrupt input line groups in the irqsteer instance.

If the irq_count is 15, as each group has 64 interrupts, it means the irqst=
eer
can support up to 960 interrupt inputs.

>=20
> > 15, so we need to increase the CHAN_MAX_OUTPUT_INT to 0xF(960 / 64)
>=20
> What kind of math is 0xF(960 / 64) ? And what has this to do with
> irq_number=3D6 ad irq_count=3D15?

As mentioned above, if the irqsteer is designed in HW with max 960 interrup=
t inputs,
It needs 15 interrupt outputs: 960 / 16 =3D 15. Even if we only 384, 512, o=
r any number of
interrupt inputs less than 960 are actually connected to valid peripheral i=
nterrupt.

For i.MX94, In the SoC design, the irqsteer is designed with max 960 interr=
upt inputs, the
irq_count is 15. But only 384 inputs are really connected in HW. For these =
384 interrupts,
it need 6 irqsteer interrupt output(384 / 64 =3D 6), the irq_number is 6.

In other world, the irq_number means the number of used interrupt outputs, =
while irq_count
means the max interrupt outputs that can be supported by an irqsteer instan=
ce.

I will refine the changelog to make it more clear. Sorry for the confusion,=
^_^

BR
Jacky
>=20
> Thanks,
>=20
>         tglx


