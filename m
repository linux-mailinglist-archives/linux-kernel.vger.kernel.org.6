Return-Path: <linux-kernel+bounces-282241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439AD94E141
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC0D1F2176B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28D354724;
	Sun, 11 Aug 2024 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZgpNcGml"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD942595;
	Sun, 11 Aug 2024 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723380131; cv=fail; b=en8M+eU+2tLdg/bGd1Rp83tjc7UFBcQE0atJWSFpnQUZGLfiTn/YnJhUmVkFeozVJCrbhY5WOCE/rerr9wxL+qL0rHSG949RB+uCntoSOM0WcdIeW18OWG+jui59RQEDfnb9eeSShqLXPYhcZqijTBVaTx7JsRpA5ln68w282Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723380131; c=relaxed/simple;
	bh=OdBkHiL7yMUQmHALkq1Lz+jhlgXYw9F5gcxfF1BI+8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hCD/A3EZO39olLeJsDokPymAmd7ATfyFEmr9JgyeB6Ma/SgFlnbiFUvXWzPkU/ciQTOcn2uKxXLfxXxv54oTfFWnCXDKApBrUOSNNk+F3qkFFotiopnoqJN01F3GWss2sHTJ7gstSiJUnO09SUcke0SenIt9OTm2K5vvZk4yFSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZgpNcGml; arc=fail smtp.client-ip=40.107.105.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmEVnjPU1z6V7KILP7b0wNW2fyNb6rZxQmSEh04d4mtGC7mBl5h0z3i4KacaM5l8ZOCgrtxl4VyhwkDGNefR/L/pXJ9J4nt4ioyWMAns3Ox9wlGtLSPrT0sZ06i+uP6/1mdEn20Z78Y4JXB0QAII97PgULrn7FHyLPR0wa9v0K/92/EuERuHmaKxKq7ZOx+xI1rT5EN9ApCABOtalZw9cHd95eUgx/XCDzvjhHx4JIB5rPJmlFVMwhasQVZD1u7UaRumFAhYpyAJ7AwdlKykDtZeOMCQ3wNqd5jEiVBF3nr9PuRSF2NdaHZkdZjQXdO2P+epS+wMiLUSaAvZ+Tg9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n375k8RelbcL8h42NBA7JlWWzMoFA2n2gr0RI+0W+1U=;
 b=uYkWjQwp6RErkRT2Hd59zKiUQ+kWNCl6K+I0+axNQO81EaR3VVzRItJ9HJEHSMVbsRGVkmHZNk6wdYleyEmNDJyAzRy4gAtsXW8sqA2JhFDcRx0R5ZmulvrQZKzPSOivIwDeO8qdV+g1H2ilS4f63pFTMKSSnqYA6+Gr+lFiK7A9MmmMx3a56wNiEdTNCGcxlxpZiAXLOw4hHFK+GcJURBHtVLscnGv66np0cVM0dSYFh/xKcngkI1V65Ry9cS/lFZcSy0nYS1I1zUMe+/lnY4lE+eBLP/g+0erpAPugmZVCZ7D8ERuZVbK8kQSwJqRZAo2vLC/j2dXwNr103Q2hEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n375k8RelbcL8h42NBA7JlWWzMoFA2n2gr0RI+0W+1U=;
 b=ZgpNcGmlLLzCpaoCBsS6G7EQlU9ZyfUEESOqKbsUTCGhGsCFpwQn1VW0mZfGuO+UiNsBq6QT9DpytM/z6dsn0LVJbELBgNbMVzXcQAvz0I3dkQ3dCOjRNjXNOxAltOqAo61IFJY+WrlS0DmP8QsE0qEObnIC9AwxAbK0Cf1LZdHEttxuxsro+jlUPLWMHN0RaBon5NIvb95mOfvWH4yO07D3W5WPq2flFxCklwJWwhTvskPc7B/Diz1CFrQQIEwiIgIfG0+DROuP3PHw4H75RwVA8rnJ9VC98NcDy1Uy+CJoOwzA8WaNPCQikVW49bqd4XtVXS6Ho4ue9VXEfLmXQA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8812.eurprd04.prod.outlook.com (2603:10a6:20b:40b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Sun, 11 Aug
 2024 12:42:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7849.015; Sun, 11 Aug 2024
 12:42:05 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>, "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "james.quinlan@broadcom.com"
	<james.quinlan@broadcom.com>, "justin.chen@broadcom.com"
	<justin.chen@broadcom.com>, "kapil.hali@broadcom.com"
	<kapil.hali@broadcom.com>, "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>
Subject: RE: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width' property
 for shared memory
Thread-Topic: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width' property
 for shared memory
Thread-Index: AQHa627JRVHTpNn33kuKUlLvACWeArIh/6fA
Date: Sun, 11 Aug 2024 12:42:05 +0000
Message-ID:
 <PAXPR04MB84598FFA4F7D8D1287D220D688842@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240810214621.14417-1-florian.fainelli@broadcom.com>
 <20240810214621.14417-3-florian.fainelli@broadcom.com>
In-Reply-To: <20240810214621.14417-3-florian.fainelli@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8812:EE_
x-ms-office365-filtering-correlation-id: d8c0d234-8723-4bd0-b145-08dcba030187
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?A3+3LBZzeQ6U5mfCmUBV+AJMA8kLJuZihc7pur5lP2+Pkrxqjx0ERra0DtR4?=
 =?us-ascii?Q?6j+eyoTZ1EBzb2m9hQfxXIHFE0Vb6rK/LHm4W33d3ovsPjdaVDJMHx66/+7i?=
 =?us-ascii?Q?atG7yOfPuMMLnbiOMWIynWsZEywxodLBxFriuNQv7ylUb98VIuE0oCX3lU3i?=
 =?us-ascii?Q?RM6fru5TEVSMIwWLiYqE8N09vFZdrlbvs1Qe8dO/WIfEDpb4/1ucXXG7a/b4?=
 =?us-ascii?Q?OKZ8D0kSAXmXQyLWXEfqKFJc6299Pn+GqGXn5EFdsoQrg9X8KLbjVTKrBdnP?=
 =?us-ascii?Q?HOsSyOeJiGbzAOBuFbbvpkL1RAcTTdLSlAq4kGjaNHX0sjPmQJPSoafxztFQ?=
 =?us-ascii?Q?jSjTL+nqv4V9maItNAifI9UBjhbBlhvN2itGxgQ/oRksxiL2VY08JfugdQ0w?=
 =?us-ascii?Q?GyhYjHVTVM76nQoJcOQMlSDqIQdToQjONv1itFISczRSOG418gmd+lENp6zY?=
 =?us-ascii?Q?kKP9+58e6fhmTpOH72zBeIGQIE17l6g0eb/i4bWbubIYBS0oA+ZQEBxWHZ4z?=
 =?us-ascii?Q?Ts0oehkN4hmsvrwbUD7gyJYkRtbhbYCKUux8YX5WuG6X7Q8VsgdTVADilsyh?=
 =?us-ascii?Q?b4eMqH+C16ky0CsMJoweW8YIQp0pR9aujhgQyvEiwaOdJbhW8QRGwig9lwQr?=
 =?us-ascii?Q?+B0+ioH3yqP7vzztvZxiAB6vWR/zW1Y0SjHF/23N2BB0Ji3mpuQ+EZxAsWx+?=
 =?us-ascii?Q?8pi/8CSZVpnh6Euj+qepgE9Dne3QqAyiVnl+IgDWuAwKwdEkljOosbt+0TfR?=
 =?us-ascii?Q?K6PiK+4DtvunxUdfRYTtZvmHHTdHGTGwq4Y2lEAHQ2n+odoCsi/h3r8z5734?=
 =?us-ascii?Q?LCBKSASrH8dNZJgK+2bj7xtFTO++OoWlqrtDGuOTbo3BiEYGGaKAFLohd9m2?=
 =?us-ascii?Q?xzAjdnptwLRR3YsUQIS3K2hOM9WK4NEQgGm1Wiq3rHwsh46yKq/XeFAVtbLM?=
 =?us-ascii?Q?sJU+3lfFZxeVL4Qe9XNEOwygQQJvq7q8GKPpjRwkdTiNBQU1IhEVgfjMIEYa?=
 =?us-ascii?Q?U0DqGNn6qdIu09YPq9tX2NRLNbFVVQQHvkjmb13HFdNcz0nJFuc4Uacj+qO9?=
 =?us-ascii?Q?5uCa9n7OxaRJG95eKwEtkCYK6HWPeGpqIf3EeGUsFm2woU/FWHirHy/6CrBn?=
 =?us-ascii?Q?USyY0gD4rJ6FvxDFrFHijk2UM64ylLIymaA7T541y0YOK+e9T982GRXM9q0m?=
 =?us-ascii?Q?l7OM22IuAUKg4BoBqn2jyp4anUjnyqRJciYhtcvHMBqrZeRng+G6jI9qP5ZS?=
 =?us-ascii?Q?BawqMIezlxo6FcIRFjwjFvyLOUx7JsaUxMh+qONNto5TylSsFD5LKOi77/07?=
 =?us-ascii?Q?zgZknb04IAllin05JEjue+4wj+ZnvTzDhbLQNQOqwXK44tQnm+5C+snvD75M?=
 =?us-ascii?Q?Un1/UTiViXA+AjrincnT6/QDZ5C+1ShkxegwgMt4I69y42SYRA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MOkPHTPiXByQNuGjMbb0hpe6MMvyaalaz/uFIZZmCjF+/rDFANycSeLY5SOT?=
 =?us-ascii?Q?PCWJOc/YPLv8C+/tMLtsWxKiA7SvjKiHNQXEn+jbOiNkJopbBr9QFxpJxKrJ?=
 =?us-ascii?Q?SvoMFPHxWpkZ2iS+wd0AHf192l0Gu7wIEmk5WoDe8yD5hqh70UvcEZWLLqMt?=
 =?us-ascii?Q?s3la8IV/+BD6oPstLgt/E2DyfJmYiKAoWrSHd94MRlq7OwoIulK0z3TMxd7c?=
 =?us-ascii?Q?Pyhdduz/YOyQ+EoMuH1bivFjTPPa7AjgLZWrTZg2ijU6ME75CDkb35rK7cx9?=
 =?us-ascii?Q?rq29Tz/VZTsMB1U/HCClk7YmdC4pIYocewS27TokmbXu8D/HVs8DKCS50U5T?=
 =?us-ascii?Q?IwSyjM8Ll3KbGmLnlfzY636NCPJXrszVrs3oTIo1+y22uZkKwXe6PwkOmnZs?=
 =?us-ascii?Q?at377z/Q4xnbzrde9mObP1PJAa6AxiBVeA3cTxeGKXFvQ7kUb+xwW3MH99qO?=
 =?us-ascii?Q?4P+xXJy6K9EB+VlJfbA5ho3qndW0NfoJARx//L0Z52AtyZD106p2KDtSt7+1?=
 =?us-ascii?Q?HEX0aPf//y/MUv7hBadZGg3/3vaT5I+pWcoKGjxR7nig3QEfBuC64n9C1K4v?=
 =?us-ascii?Q?ayOz3Uw0LKD5ttKjlmlUH560jN/bRQVmb28Jcb1N9BK5B6nINYjoYnkY1c0I?=
 =?us-ascii?Q?/jSiVxFJxBW50ayd7EtxbDmZ3SiArOm7mZjvc2ygXxtHEa1Rw4mMilTvY+hZ?=
 =?us-ascii?Q?NwHirUCeNjfsEBVS23r7hzLUvBd/ToHPyKTC0EDpCLjZ09FojIEKnJSjb9Or?=
 =?us-ascii?Q?0JNL+bv37QtJ/P6lYF3oy28zJGdZbol7gGmhGxnGRG5m/3A3EAoi57+5cjtL?=
 =?us-ascii?Q?a6QVYcThdDmFo3MNGGBjxFYK0jcu7lpzWm4aNwLG2lA7JHZVjdQpAZ2KE/mE?=
 =?us-ascii?Q?mLYicxqB8JkijlwSkXpLsGjnJPsaz2lImkl8usU5F2yAIi/Dw6mPNsC3tExr?=
 =?us-ascii?Q?DPjbKv/t01WVHAa/VtRZTmM1W0G0sxN88wbapkXLGcRiS1eAWMm6H03QfoRp?=
 =?us-ascii?Q?Sra6CWDB3pWrzEAIldV+tha6sYqrKCHb8w7BRv9EkPHB409PBFuC/6fNhzTF?=
 =?us-ascii?Q?xsvBUp4CG9SzEjNjEFd3kjdsdZ43+cmFkd+wdDS/7Xkw6TacqvjKSKXXLhaS?=
 =?us-ascii?Q?t0++iXpuauCv6FRrk4YRiNv9laiQw/iAuZXB+P6gGTlqOI/HM/Mj19dmzn9n?=
 =?us-ascii?Q?n6wJyMso5kh46ez67LPyy2VMP4I8r5/aSBWC7UDEYSAXUPZzb/ZADbeKy/a3?=
 =?us-ascii?Q?BgqQH7ycYxSEqN5dG8S/0QB0F7Bj+mOvWP+MteapZ/Oh3IbkcqicZxHYPLjz?=
 =?us-ascii?Q?gZFeC5V10syq2YN6ZJzSLnXQqcvn5nMRQpi4yid/lRqdr+sNWHM6yrhQBgT/?=
 =?us-ascii?Q?lZVR4ovqIlvJHt8w8LYGcpDw09ymxrRj2bGjkLvgJYcuUxhkHHEv4EHThZjG?=
 =?us-ascii?Q?SRcRoz4jiSpgV/vXNyC7OdDTsWIjF++h4IU1EtRbj+buh4TKJmbijYaV2ujY?=
 =?us-ascii?Q?m+oSlY8iJNzSf/HwH+wVnlhS3mi5pDtkTOn/bXnBbwahhOHcxFInyhmMdRoB?=
 =?us-ascii?Q?tWTAn7FUPt4dTEhSIo8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c0d234-8723-4bd0-b145-08dcba030187
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2024 12:42:05.2818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rCFaqMqXjUolPUlPjfl70C0ejQyGS/J3TQ1fLMrkQJbize3CGVEqobrJ5z0XmZidnpO1AX1pzUMZUjJZllmcxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

> Subject: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width'
> property for shared memory
>=20
> Some shared memory areas might only support a certain access width,
> (e.g.: 32 bits accesses only). Update the shmem layer to support
> reading from and writing to such shared memory area using the
> specified I/O width in the Device Tree. The various transport layers
> making use of the shmem.c code are updated accordingly to pass the
> I/O width to the routines that need it.
>=20
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

[...]
>  }
>=20
>  static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret, diff
> --git a/drivers/firmware/arm_scmi/shmem.c
> b/drivers/firmware/arm_scmi/shmem.c
> index 01d8a9398fe8..192262d63baa 100644
> --- a/drivers/firmware/arm_scmi/shmem.c
> +++ b/drivers/firmware/arm_scmi/shmem.c
> @@ -34,9 +34,20 @@ struct scmi_shared_mem {
>  	u8 msg_payload[];
>  };
>=20
> +#define __shmem_copy_toio_tpl(s)			\
> +	for (unsigned int i =3D 0; i < xfer->tx.len; i +=3D shmem_io_width)
> 		\
> +		iowrite##s(((u##s *)(xfer->tx.buf))[i / shmem_io_width],
> 	\
> +			   shmem->msg_payload + i);

there will be a barrier with iowrite, use raw_write##s?

> +
> +#define __shmem_copy_fromio_tpl(s)			\
> +	for (unsigned int i =3D 0; i < xfer->rx.len; i +=3D shmem_io_width)
> 		\
> +		((u##s *)(xfer->rx.buf))[i / shmem_io_width] =3D
> 		\
> +			 ioread##s(shmem->msg_payload +
> shmem_io_width + i);

Use raw_ioread##s?

Regards,
Peng.

