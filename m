Return-Path: <linux-kernel+bounces-219218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AFD90CB70
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099B81F2281F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D856C26AC1;
	Tue, 18 Jun 2024 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oA5//GFl"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0922139A1;
	Tue, 18 Jun 2024 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712968; cv=fail; b=lSmtooRrSdKyq/bJl/hLPUebzksKnpQqBxhGkrsEv5bjR3DWR3QgL9U+UbwehmDaIFZQxnWxFo+EkUbGv890rMAqwN6Epg4NGD0vF/mpi79FqJjWHsymjpmPr9V09wUyJuVBr1eEJqBcRIUK+c9mOyiy81JT5FkyDRdq8uCMJ0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712968; c=relaxed/simple;
	bh=jMKGW2rqbt3BW16MQwO5ZmcpL0kZMn/p1zQNu3X32wc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BBStBye3jmUfqCHS+gn9ukNgZ4XLCVJt2IonCMoV5Ql01zMGbknKQocvT4qS2lLmffOscVJNijXtIaQajJMNmrnEbIpoigBNRmdku3wlZvcKenrzv5qkyjd02aW9GPenX0KathO7Ny54PNhcFN4Q+YW/XhnOJh4MGIlXJEDJxME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oA5//GFl; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X31yrV9czw/7y6FlWtJzNjV88jb82N0znIjEKOKy85hBHh9NfUbNqO+qNjxxUdBj7q+kFbanvZ3onZZfPNSp03eYLm06QgKC35xI/K4KjI8h9RLtRyQqNMg7XHKQGkmGB+kuFUpmoCbXuCYHuveH9TE6Xxae1C7J6kMIks4FebBOoQBrwy5zGwC6927gPQNQDG80Y2TbWQf0ROfh7OwNHjrrj1UhMb/IGRc6cRTkcq0wW08wu+kKlsT4sAAOZOLueyNT58obtoHQ2clIK0mpHccSS8qogqzNOKxpLQXR0m0n33z/use/IX0rh0jlQMh8S+AMVgjGG0idhaLGrCZ5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAEz/thcMVYj/Tm8zvS/3aCQvcpp4DoWg3M4AkPHobQ=;
 b=IGtqTofe7PKN+B3b09lMq579bGYoG+hUq6+9I4bLVhmD4WOkI6plAQrjjfW3NIpWdxfKblaf2OL6hQeMdwQP/xsZwrk2YkMd8sp+rThJxazwkQKz/KYBm5ci2uDov5dtRYQDqC2lc7t6YCg8xr653bcip2qBWJnKpva4ZaRdCBsWcEDUP88n/8Df4j5N/DJUMeJMOcliwivZ4gJnwEjMtU3UcQGFuCR+rsHt/x9N+9l43VwdUqsY1aoMSUTNCbcopAOmZAPLuxWrywwDXAfx2BwaJWgV0vs17Ul+IffvyqU7fkbWgEw2sWnyCSKZEgXvL+w15okswljdbJJ7WaiBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAEz/thcMVYj/Tm8zvS/3aCQvcpp4DoWg3M4AkPHobQ=;
 b=oA5//GFluhFnKXRLY8hfbfQT6ZsSLm646u4cLdEsof9opPj/753SWEmK7iBvtEBbwaiO0cP9XrgVgMnzJh/yJJL0ePvc1K8wUe9uBiCvTkCI6PH/AUoooQqDYTtww8hhyutUsD+dDlO0nTEKg9+E8OD2avWiyQzRjaqpMxC7mvY=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DB8PR04MB7052.eurprd04.prod.outlook.com (2603:10a6:10:12d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 12:16:03 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 12:16:03 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, Abel Vesa <abel.vesa@linaro.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 00/15] clk: imx: misc update/fix
Thread-Topic: [PATCH V3 00/15] clk: imx: misc update/fix
Thread-Index: AQHauN4XcjwIBHuybE6Q1Vf3YHovf7HNgNUQ
Date: Tue, 18 Jun 2024 12:16:03 +0000
Message-ID:
 <AM6PR04MB5941D774343D0AE3D812656F88CE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DB8PR04MB7052:EE_
x-ms-office365-filtering-correlation-id: fff3acd6-c57a-4a1a-f626-08dc8f906c5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|7416011|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vkrM0OHVjRv1tXLXSUdeSIAWfm4Zfq6K7vUYPPMbgfNWF72qJB6vGK3aMvND?=
 =?us-ascii?Q?iUqQJ60PozzNm7iA36XkzwYb2cJBQZSr5ThPyTA7zCXFjoaCZ0AsORPicMs+?=
 =?us-ascii?Q?DXkq5NDUosoDJn85OvWq0U9tREauKZYCMt5P1r0iJsR3djhkYZhgpekgDuMj?=
 =?us-ascii?Q?1zVrPgaG5GjIla6+3BWOfcFScYyobyB8YzQwapYpKHqADAVDAfNmFsrOLNaD?=
 =?us-ascii?Q?FPsDW6cl1w6jHl0NZfQTzxmppq2yPimUStHTjN9V2EyL0uOOgXSWHB1UyaPD?=
 =?us-ascii?Q?AutfYMwTiKv3HlAXwZX90Zue9ZPIysoTgrJo9hnjGiEFCtOxTwOrbHsQ6E1y?=
 =?us-ascii?Q?GFniojCUQZ7TNXTERXcisa+e+bsVQ7o3nX3g1iqOJ804TQ8dpw6BkhLllzYQ?=
 =?us-ascii?Q?ocGq+Ew1xIXd+Lx3APEUvKIYYQMrOmbzHHG94bv4Ptt4gCIRDvY493GGolgX?=
 =?us-ascii?Q?A5sr7vJvPhf6odP3/qgRJ/KL2LLRTmIEI8aU3M7C026qc5gK++w1h8p6IkW/?=
 =?us-ascii?Q?Wf6inX7/ze8eHclD5kSz0PJR/DzZuKxiV7U6haMUtVgrRji2tro6yCB0axd8?=
 =?us-ascii?Q?9aaqs5e5an+Yh4j+7L6xNVa7ZIR9OF2PL6TY9551byWqEpmQ1e4iqpOK9uES?=
 =?us-ascii?Q?1JgsmAdxaKeGnQrdlkd7j6E6ePXHlyoK/+X5SP1rdnv/afpTee2JwwbtYTnw?=
 =?us-ascii?Q?RsFN4iRKqjymq9J9fc4nKbsV5qKT0laZPu5KYKVcXMkyvJQ4TzFAX7TWvBep?=
 =?us-ascii?Q?SfBkO20hj/S9iWgZRthKOs/qG10OuA3/JQTqtA+rHrUWcLP2wV1i9+aQQxms?=
 =?us-ascii?Q?d5dZbdKZ0MkvnDnyIAjOFbSbB7xq+1Xr11FIl5QHZsI3/G095797b1HrEu25?=
 =?us-ascii?Q?cT57xzdmVmhMudViYJDcB4YH/BfjXXiAJ0q/r74AGSpuqc2IiIYRZ2AP8oYD?=
 =?us-ascii?Q?zJPI3S4QyDT/v60M7QTgYctN7Knc6m1UAB9tkcKCWxMrD1DXilBAbXsKgmtQ?=
 =?us-ascii?Q?67tl6j/pO5FqL4uB2nzCRZSk6Tl+nTbLPku0/6qwnXDf1IC8MAsZpS88ZH4m?=
 =?us-ascii?Q?LOC60O7fBSWkGSciJmJFc59OBwLEoX6/riwd70/Wsqi2DE+A+b5YYsmEiHgF?=
 =?us-ascii?Q?3UW4OsUPbIJybh8BGUxWiZv1qVjY1bu4WlQXp15O0g5VrW0GJgODUCokhd9v?=
 =?us-ascii?Q?cxYr+gibRnOm8KzNBWuaTBTMq5HPuKR8SXFsZiqrR1IBDNdZ8bdYKihm47IX?=
 =?us-ascii?Q?w//dmu865BYSXsEv4GP/iZyr91TCHqCqb66K8LRQDS+ImSm+kfSurqs6itrh?=
 =?us-ascii?Q?UAYFmbsPKXJiAQm2SsSyxjO8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Fm1Hn9Nohe2zsB1OaQK3HSF7YSmZevgjH1oLcgFlObAsF7IRLyqX9f1IZnC5?=
 =?us-ascii?Q?rN9IuXoaTg01giMY9XoRsb6koPoE2jAbLQfCp0bkt1YwqzbZ+xFMZ/sLOt8N?=
 =?us-ascii?Q?owQT86aCGXL03IJ0P2gEwCO6eNnrrv0mRjNPkI+mO9VO6yja3L3voMWmZnW/?=
 =?us-ascii?Q?LKxBMJHfKZ7K0hVqUyBKwfoF8Bn63NbAPEvmUSNx8ShDdktPd0t8cWaQwENg?=
 =?us-ascii?Q?kTywkyWcMWmqYyLKRBvptO1H3RMu1ehNkZj6p9Wtpj8IY8lMIHITPjCTRnuf?=
 =?us-ascii?Q?mfoj3EE+K+FRKQ9Mhvhyut5TeSBLuyKYaNXIuryuYiZHNfxk3qW58sweyTD5?=
 =?us-ascii?Q?lb9XdrxNbyDC7ofZqk9vyWLV1AREIljWCH4rTqDviRnHYWrnw66jSRECmY9L?=
 =?us-ascii?Q?dzo47qsLE/X6PD7uUl9sCD6zFntnBYw8+dx5RJJuI/AZBa7omWIS8UQBdzJp?=
 =?us-ascii?Q?UiRI0P1uZcAHZfdtWtTvnAdqSTtR/lBynkuRMqfpgotcAKeZXXeWbly5heLA?=
 =?us-ascii?Q?8Zn6bfwi/0hr34PNd+dxOS+Zklk5bbKhY4k3TQgNxn/GMU7flLCO1oM9d9e5?=
 =?us-ascii?Q?ue6Y+wLH2pwuD4YXDTlC1NgAT5Lt1C36KgqfDZH9FgYwRWw2JWnLQgOHtr1d?=
 =?us-ascii?Q?Ah1ATZdHsmGJMqFSX71CVONA69mZN/jeQT/gZ4n5qMGUpaVfvyg7o+E0CdjM?=
 =?us-ascii?Q?EZBB+1HxN7Cax9IPsjjo2Ssaz4JZ5LfAnuNpJr4DfoaHD1d2h2A96Cg6t1Ao?=
 =?us-ascii?Q?jVVV/G2nZccjXUz9Zkpw6yV3ILCxSlpXRdzqDRePIHpA6GGMoqejNV89ayvs?=
 =?us-ascii?Q?0wXiVm/3/4WDGs+6IDWoNiiKR48yb2gd+s57tZUKfgBUaAacoX8Aw/RXrO7C?=
 =?us-ascii?Q?sJnYafobYzxF9Rzn6K7kCgAfqe3r2g+JQBsOPskhaAvc1HnBgEr+p5LXzAQ2?=
 =?us-ascii?Q?NMOreaODZVZcNg5I2bfEU/tt+nNN8SDeDTRXw4HcbPyiC0fMXOiWcGaUxTQ/?=
 =?us-ascii?Q?Odf9dORF1xWcewOueZmpEp4QOWpZLEpLWwNPIyzOgxSS242te9GRymiLoEo3?=
 =?us-ascii?Q?zaJ1vPOWReTBcGUhwYfZXpFqMjcoanBOqafVBsXZwffsajKkvSG9mfeyaUTr?=
 =?us-ascii?Q?tJwaLkrltOI8NetqQKwpZg6z4xC7v7MeyChNEKWJUMrQDvOoBrHKPyeMrNAh?=
 =?us-ascii?Q?cBYk4pd1NV7nkhfAXvqOBoCz34fdC/JGsksgOkK5AlVYaIocEttzKviSZDWa?=
 =?us-ascii?Q?szZTSUYBvv5r56eo+GfJHC0Tgi84yF2vKRSyYrzOqscF4aNWe/xRXiS6N8se?=
 =?us-ascii?Q?G7aSjGrmBKGOIPUqhsLZC5BzqAMLNXnmNWKrYexxKInJgnnW9mdir2SOoy7m?=
 =?us-ascii?Q?Mf9OXLt0XkCa7rpdXAWwAr4y+dn5U3wdaYvIXpJ2KJHfy2bmRLvd/wGSYaJp?=
 =?us-ascii?Q?Di/CuUdonMZolZvitT/yuJAzYGoeG6tmwKkQYusnMUkFYZeA/ECrG/Eqz/uU?=
 =?us-ascii?Q?Qof5sT6dOqGfx+/QawpwZ2x2Nm+Q6mPTV8m4lRFW+1tJhw6FQiBJP38j6w/V?=
 =?us-ascii?Q?94J1FEzvqdL4X5yIRSA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff3acd6-c57a-4a1a-f626-08dc8f906c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 12:16:03.5542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +gzhYIYlaYBXCqmMfgU9qGfFwgTJjYGeE05DoK56+BVwPvTSEmSClVpzth0gKoE81LhrLKjcxDKw7zpLIFMLCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7052

Hi Abel,

> Subject: [PATCH V3 00/15] clk: imx: misc update/fix

Would you give a look on this patchset?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Changes in v3:
> - Drop two patches
>       clk: imx: pll14xx: Add constraint for fvco frequency
>       clk: imx: pll14xx: use rate_table for audio plls
> - Update 8ULP PCC check to not return Error
> - Update commit log and Add R-b for
>   "clk: imx: imx8mp: fix clock tree update of TF-A managed clocks"
> - Link to v2: https://lore.kernel.org/all/20240510-imx-clk-v2-0-
> c998f315d29c@nxp.com/
>=20
>=20
> Changes in v2:
> - Drop "clk: imx: pll14xx: potential integer overflow eliminated by
>        casting to u64"
> - Add Fixes tag  "clk: imx: imx8mp-audiomix: remove sdma root clock"
> - Link to v1: https://lore.kernel.org/r/20240504-imx-clk-v1-0-
> f7915489d58d@nxp.com
>=20
> Upstream several patches landed in NXP downstream repo for some
> time.
> - i.MX8M/93/7ULP composite clk update
> - Fix Fracn-gppll MFN got lost
> - PLL14xx update
> - i.MX8MP DRAM CLK fix
> - i.MX8MM/N misc update
> - Init i.MX8QXP parent clk before child clk
>=20
> Downstream tags are kept for the patches got R-b
>=20
> Although there are a few fixes, non-urgent for 6.10.
>=20
> Adrian Alonso (1):
>   clk: imx: imx8mn: add sai7_ipg_clk clock settings
>=20
> Jacky Bai (2):
>   clk: imx: composite-93: keep root clock on when mcore enabled
>   clk: imx: imx8mm: Change the 'nand_usdhc_bus' clock to non-critical
>     one
>=20
> Oliver F. Brown (1):
>   clk: imx: imx8qxp: Add clock muxes for MIPI and PHY ref clocks
>=20
> Peng Fan (8):
>   clk: imx: composite-8m: Enable gate clk with mcore_booted
>   clk: imx: imx8mp-audiomix: remove sdma root clock
>   clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D
>   clk: imx: add CLK_SET_RATE_PARENT for lcdif_pixel_src for i.MX7D
>   clk: imx: imx8qxp: Add LVDS bypass clocks
>   clk: imx: imx8qxp: Register dc0_bypass0_clk before disp clk
>   clk: imx: imx8qxp: Parent should be initialized earlier than the clock
>   clk: imx: fracn-gppll: update rate table
>=20
> Pengfei Li (1):
>   clk: imx: fracn-gppll: fix fractional part of PLL getting lost
>=20
> Ye Li (1):
>   clk: imx: composite-7ulp: Check the PCC present bit
>=20
> Zhipeng Wang (1):
>   clk: imx: imx8mp: fix clock tree update of TF-A managed clocks
>=20
>  drivers/clk/imx/clk-composite-7ulp.c  |  7 ++++
>  drivers/clk/imx/clk-composite-8m.c    | 53 +++++++++++++++++++++----
> --
>  drivers/clk/imx/clk-composite-93.c    | 15 ++++----
>  drivers/clk/imx/clk-fracn-gppll.c     |  6 +++
>  drivers/clk/imx/clk-imx7d.c           |  6 +--
>  drivers/clk/imx/clk-imx8mm.c          |  2 +-
>  drivers/clk/imx/clk-imx8mn.c          |  1 +
>  drivers/clk/imx/clk-imx8mp-audiomix.c |  1 -
>  drivers/clk/imx/clk-imx8mp.c          |  4 +-
>  drivers/clk/imx/clk-imx8qxp.c         | 51 +++++++++++++++++---------
>  10 files changed, 103 insertions(+), 43 deletions(-)
>=20
> --
> 2.37.1


