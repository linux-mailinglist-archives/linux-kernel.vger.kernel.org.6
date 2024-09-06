Return-Path: <linux-kernel+bounces-318414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE8B96ED80
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D516D282D0B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC121581E0;
	Fri,  6 Sep 2024 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PBb0KAE9"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AEA15699E;
	Fri,  6 Sep 2024 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610557; cv=fail; b=uB13W6q3mcqs/FEAJmy6cxTDQJMFFS0VI3EGn/QoH7rVMC/zibI6zRS+hsRjV1x9J1njG0TxzM9C+vPcEC9CbRdiDCIwxF82l/4w4aQN0kOMlWdX789OMF2Y6n419htfyq/3GzedqwPzTBj2mnhtDLXhoCQ694eT2n3kAs6eEWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610557; c=relaxed/simple;
	bh=RY+HP+UTcWSbHzLCpSSjf0YvU42aIVhm4GOkHlyDwXQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gh6MnKkU6LPa76QAfJMQdTeUbBJLrFS6iSYZ0q97Pyopr2A5yljgZ8nq7tsM87fdziRYuVEFZB3GJUOU74P8K1Mw64et7+hEXSBf69BnxdE0FHAs3K54CvbbJk2sDxysF+nF5jOYznVXGnUEsLBJ1vJHq0wjGOvnz/Cbkd8L6f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PBb0KAE9; arc=fail smtp.client-ip=52.101.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ybp+JKofKGZlqo7W4JmMAey+6SB8DNA8nm56V+pnEXvZYfd4c/EYUgep6vvM/Q6L1Ikw64FyR8pTV2NtZhR7A+L8Xf2VL2PYgllWEZwGcnvC4y3Gdq+tBrAJVKSfjbCIlMI457QZqom1+9L+L9Qol+7CfO5AsacWkhDaTAtVYeM7F4HGqUyB06hVLixq+yDKG95DZQWk+zrLbdtKgNNJJ/duNj3NcL6mygfJAjSJbLrj8TVXjEVOguqc+aLu0ycvC3BVrxmvzgIXFNTh9U0Qu2zHshSYOi+ZcOIjF+6h/Vf0MUYjGCZaUlx6b4Ao0X8d4ZoiwTn3V8RBA3N1F+60Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RY+HP+UTcWSbHzLCpSSjf0YvU42aIVhm4GOkHlyDwXQ=;
 b=ceU0vFaisVTf1s/NP1QcUws64dvfw6qPqzgE94v7XXm2YVmn4KFCUfv0G1skf3yfRMJzxUeUqU9KiXpycwUk8ELiwbXZO9M7AHMW+KaPhQYccSNxBnMB/hTqaKEbny5SXXGD1DkE9ziIc9yaMf32WRY0Y1VPAzs65dzj1pGgnTbcWeLtdisu5ccecAEX0mNLEiyjlwo6VfUALf3kobL176ySGq4Jxgp9o06D+M7TsNeRCtEvvuUEzs3lPqcuOUBJaiuFrLS1Yx41iRGNi1gT4LCdXeO6QIv4dPfPXVwKWmDjlOio/F5nCsSWkJhRKc1anWl7NS5Fm50rMzLYYpybug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RY+HP+UTcWSbHzLCpSSjf0YvU42aIVhm4GOkHlyDwXQ=;
 b=PBb0KAE95XN9NrUFC2X9up/2cgEJZ60LocCzrO9xC9TfzJMXNnsvwqkRfnx45CB069IySk+MlkoG0ehmkguRacApSkdNHJ2wCcLIuiqnaufT9HEKsQ9FF9+6lKbbqHo0xqNWbBjWgvONOPsavyasqjx6AlHFf1TAgNTY5NLqHodu74LFs8N96XSi5TJ7MNi050pH6thcPM3QoLU2B9O5j3jiuFaJLBuLy7vdzZgTPllfBne/DacTIIc2U6/SsdXAlrKKuzEp086y7ajT2GBN1gCjx9kgPrUMXMUpB59vaAkcD/iQ1kgQAnhmXMPN8taK6Uz8AC/tbgx67SvkpRNp0g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7711.eurprd04.prod.outlook.com (2603:10a6:102:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 08:15:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 08:15:52 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: freescale: minor whitespace cleanup
Thread-Topic: [PATCH] arm64: dts: freescale: minor whitespace cleanup
Thread-Index: AQHa/6p7dyitC6bCMkGXVlaSV0abh7JKaoUQ
Date: Fri, 6 Sep 2024 08:15:52 +0000
Message-ID:
 <PAXPR04MB84590E491381B1C63A5B90C3889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240905154410.423991-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240905154410.423991-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB7711:EE_
x-ms-office365-filtering-correlation-id: f637c9ff-a6f2-4d5b-937a-08dcce4c1ffa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sywit+/aIeHULAq9m82SQPh7TA3g3QsU/5U9oU1NB9BFKNOdb/PjLdBtYwlt?=
 =?us-ascii?Q?vBpbKO+r8uy23eyF+aKWWN+xf6s3t4Qb0uqy6gcGPcC87/RtktRPwk8rFx/z?=
 =?us-ascii?Q?Ao+QHz6x3AHpBnwtIxCZvHQIFbnY9rnE0LfSz1RCD+1OTHb7JUycRyJAhS++?=
 =?us-ascii?Q?z/mCwnmJI2HlwvCtlDWVtIYBQojbXhFjT9ZOzX6WiBNvbvzQUY1qY9dWgXq4?=
 =?us-ascii?Q?ytSzvp5qUbOSNbOCPfgowuyqM3yBl50osYU3dEDYBahkbYP+HwFmOGcmmxhF?=
 =?us-ascii?Q?XpTyerxasopxCCfep/5yn8JUeFn4UfKJXaIadD4J485XA2xbe93r6ZxZoAIQ?=
 =?us-ascii?Q?v3uSUNRmvGgVJjyRMg+XpP/KkngHA1rCW74RtBA/vM0sPpQk+ipP2Jvp2FMg?=
 =?us-ascii?Q?fPhpxMDP/kniN5cxO82OjumyVITzmBzWxj9BRHYHKo2fZ+S3onLHb4Ij541u?=
 =?us-ascii?Q?isQELkqhFXTBVxiEHZJqi//6KAQBs+DnA2LK8btwpJaTNRS/HVmv/np5Mjf7?=
 =?us-ascii?Q?jgejmQRNApK38VywGxK+AeF46ceV+trCpDre69wXQJbJ5U+OhO0ZXOaepFK/?=
 =?us-ascii?Q?/bSnUX4KdyS1G2Acpo9n6lC6JRZuaaZ5EmSAxFKspClWhl9WctXrm81bpIbc?=
 =?us-ascii?Q?kfvrnlBuhi5nOMQyYffmyz7z1Wg9VbFyR2QiCmP/Kxe2etGnlIzXDGZq15f0?=
 =?us-ascii?Q?bKFGjK8e8tSP+maDAUxNxKRJrCD17JwcUCvUzH8fyUkYs7OWtoe8f7GH6BxJ?=
 =?us-ascii?Q?0hNVRvFY+GUWYGDsv8/xzVlFlcwTBn03VrUTiSXrcXxfDVZrjfRSEc2ZFQ1H?=
 =?us-ascii?Q?Ds9PX8zlENzqi8Qu/HfeVKwHKlfxyO21LkicR5cSwu1MtPJBpK+DIwXirk5+?=
 =?us-ascii?Q?pGM6LC9wYTZwgDsT4pBQwoK0rlb44D9oM53bjWteMBsSNBl60nJjtXyYhLyG?=
 =?us-ascii?Q?5sgUOJ/osaTZfmSNZrEQ2UadPqtgqc8fVcDYqgctQzCNJPFsm6zsnNVc56GY?=
 =?us-ascii?Q?6tom91n62j6NBC1iRJP04UKltIOqxWPAsQbjSl4xdACRpjOkwJttUJbGI6bl?=
 =?us-ascii?Q?4peJ3xhOF5b2/YDyGiUnO7znlzmwVxHXmFsPLuzbIhPHY8nvvRRxLq5evwLz?=
 =?us-ascii?Q?EShQT5f+OLhoI4B2HhTHB7OBHyqACuz28dbPYj3K+wc2SfFR8lTJvt61ADaQ?=
 =?us-ascii?Q?srvGwlKaRvgD2Q6lVLmM0fNjCfxabmza2bXHbi+ieWlLiBOxtvm7ws/2QpRP?=
 =?us-ascii?Q?o0La7AHvTvhRJwMTqgBBfWoqfcZI7RsNDflMkin6RLYzOF4itsFDOSwrstfX?=
 =?us-ascii?Q?95jX7P1pDzkw74kDu/pr5ND45yDq9m4zyomRyqkG7oQqp5Wl63cxxaiYzCCz?=
 =?us-ascii?Q?rYRBSRV2jphJJI0qYNEi75219VfR7RU7qCZ7MwwBNOYVj0uJCRn2uxHCS3+0?=
 =?us-ascii?Q?E24gqRd/ZnI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yVrsVIl/pN8DzGHlDb42iMXS87+/pqHx7E/0lLKsUQKIDPh5bQQJMEn7NsPW?=
 =?us-ascii?Q?3qQ8E2027d2ntU1/BXiisBlrbBpYTzp7XfRAkDsJ4nFwJxiUdc5Rf6Y2vRfK?=
 =?us-ascii?Q?1+QUAiVMnniCJ8pbh3H/HCNI80JZWShlpL/EF5Pvk0vY6/B9Mm0lPva9UGrf?=
 =?us-ascii?Q?S9CJA9O0+FMl8BKbVosP41zlBgXZZNMKHjsDFTVC2VyOVDteNBzw8yE555Vc?=
 =?us-ascii?Q?dhUwtAheGb4Ah+xKm6r28mWJczsCFxrsNlTa4p0mp3io+TCqeNEodHGB0zSo?=
 =?us-ascii?Q?AL9NXmHS8eV09RveBquOpHX+ZyGBfSfLuT8zkMb0ISzFbGaam+zBrXu0sX56?=
 =?us-ascii?Q?ZoxyKB/jzqMJpsGSH7gE6sLexN/pLg36bXZeojWFkvsS9xzrslPB7CA6nA0f?=
 =?us-ascii?Q?vAaFJWmfRqESzmFgBtjy96mn7C/lYrYRYncuIgXkQNgM09qHgoirw3sXqN+6?=
 =?us-ascii?Q?EgpYsF3ys/8F+OkHTZ/C8g2QdGZbx9M5Z98rrFRJcK3D1D6iQiJjNQJjSZSJ?=
 =?us-ascii?Q?/SipVUMWJ0T1A1ph45/FAeCI+ouepS/ikIwqjBoEn+2XYoe7vWREfIVLYj8c?=
 =?us-ascii?Q?+d0INGgmtXRKnWUhyIR6+iZhj072Wi7wruH5D9kI+UPDe4UEtnFYfdZFkdmx?=
 =?us-ascii?Q?vGu+aVd1mfZPYh7xTZ1PPLSPwLukuve5CbpkRr5ZGYlt8S+bbt2t01sqOYrl?=
 =?us-ascii?Q?amQWHaoIWCfIEF9i59+r6AOx+WZaXjdjddmlOlYPVb2ulsrhvDBqFcxsFH0F?=
 =?us-ascii?Q?a2ZJxtSSyQ0cUXxM7PDy596kyPzpp3Y2u3ph+uEYeK9R3M3Xr1lflIhtQ7yt?=
 =?us-ascii?Q?IgZybqT3C/JCuap0t1Ev9+9lyEApLR05SQvwjMGCMf1ubh9CZNipjZ4/0K85?=
 =?us-ascii?Q?Iceon7AXhe5Z+a2GJ/NYSzIPNNKh6kWifqH4rjP59hOy70SewHqkTKrhszA7?=
 =?us-ascii?Q?H2Fb7GQ78TLqrVtIrxLcR2uYnzlJguZyz4JkDJydM1n80L/b1z3rCECEOtgX?=
 =?us-ascii?Q?keIoN1mqTVXEZPrdmWoHqIfGCv5JsmrXp8/7Qe9F9ZzHamlmT4w990Hh9JBs?=
 =?us-ascii?Q?KoO3nKcWOdo9RSosl50JAYQ4ntPhsRuk9Z/xadNNO07h0GOkxl1huUsb2h9D?=
 =?us-ascii?Q?Kfrg+A4UhEIgEyq9RyFqLU+Y5W+ziWThFbUOV1ClgGV9fzLMMMW3J0kRE37+?=
 =?us-ascii?Q?DwXYxZtMJtgn652KiqhRJfHbegkUQAZlYnFlH5xrbqVfPdHqZo4vFRQNxAQj?=
 =?us-ascii?Q?V23eUbLwhoLvzsEEwTKVUuE4wd6QQVRbr1Z5oS1LITQI8C+YfFLoWnoH64uq?=
 =?us-ascii?Q?W7khBuSWTGQo61KdcHEcE/DugOnewRW9GsIHOfLJme+32CKWMboCn0TeyMyF?=
 =?us-ascii?Q?DevImIjQNJhPuOyTVxeALcNCpKaMXnJgjSvwAkJTjKsKjaBHferHe04FT/rb?=
 =?us-ascii?Q?Zxy8Bdn5TTAQbcqGCnPkTRDYaCpVKm/F+8hzBv8Qtd14di/87A43I/HFVgeQ?=
 =?us-ascii?Q?c5/6+zgOs/aKOh/P6YDAITBUiaTG4Y2E0aC9hWNbmeTdMQFOvEaD3AYpAmDC?=
 =?us-ascii?Q?mAOBvlEN2z+pzx/AzyM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f637c9ff-a6f2-4d5b-937a-08dcce4c1ffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 08:15:52.8494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XFb6lHUPqVRhrQCKIVkbYWu9N6IxDySNBfuACvbl3tBdxbNu/424YJtWNhk5pjXwmRglOrPYiJDoSC7jVJGWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7711

> Subject: [PATCH] arm64: dts: freescale: minor whitespace cleanup
>=20
> The DTS code coding style expects exactly one space before '{'
> character.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Peng Fan <peng.fan@nxp.com>

