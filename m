Return-Path: <linux-kernel+bounces-270520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A029440E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF191F280F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D4E12DDBA;
	Thu,  1 Aug 2024 01:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L4rmxTy9"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3F1EB4A9;
	Thu,  1 Aug 2024 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722477295; cv=fail; b=qFg5NKoZouAN07JfwuNhbsmUVfMEa1L9qB6cCRRrMMLpT3xhV5MKAiNcbKmtBuDbIdgEVSBd3S3ksz1aD0Tu97va4N15rgzpmfafTH0KhfGvtK7ToG8tUW9lhLXBnWHv3eXryfZSqEaiDQBifh5qmgR/YgWk0niTwU+LgvRaWfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722477295; c=relaxed/simple;
	bh=38/yT1xMWvnA4r0UPfgBIIxhE/vlLmo3gE9qaVmpcEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aBdf18lpobvez1/GOA6HvuAHJi2+tAryxYRRQUtK0IZhoEx6T/Vb6iT1/l/PAuwDneEG9l0t8/n1L7LnHa46yW7ajFhaIn8GhR/4JZd0oibbaAYRxsahAgieT+V+ypX62j2WemlvmjJIAUMnDXBiTwkaSCxHPVZw7P1boZkhXuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L4rmxTy9; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1KmxDJ+zPXeX4VazvDJnXjhQO6dhi6D1qYu4m74AB/QS1+wm3NdYfAaNCMIQ1Pm3JQ9/AIIf7zPfhGn0/L7h77mHZgn1rAmMT6W7wy06xodZYMeV9T24yTq0aoRGnXPrDPPAgbAxc3wrB0YC42vPB7JqKzE/278yHVX6hdI0CGDMWrCF0ZBVKyUQR1xOigIgSbPPeZxk41syJCyb7ldasEwrgXC4EXMK3gt9WXMUKa0C05Apy6lNnaT873axMaiXFcNK6mDA5tDPWdmkvrEyDlE/aalGVggYgRVVheIEVPQND5RELc7TK+nkcrEjy6Q52o0J+4X3yaXwfw8lfr01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38/yT1xMWvnA4r0UPfgBIIxhE/vlLmo3gE9qaVmpcEc=;
 b=eHq1vOmnduS/Ed0gEayDNLcRbNz+QmeKxC10sqP54AxaW+pkd+NhEFrG/d+e7EWbe0PyUj2433zaiv68bHrE28s7x8v3iifFpCOarx/6YoewTOo0mirYQLxGveyU7KsIzwp8CLRqBMEfH+qv89mFxMrXo4Z278MTqIZ/n3f/uaYmPruAPmmW/GsDjr2bnp5OT27tFzOhm8/k0gFbHdBoE6A4pAN+qN1o1z8e2f/7RpVcUdYs+qd2N9iiw/J9AnfOXQ98KtSYz1eW9xpCEHArbU0OubF3HNYFXm/0AuUrV1gsN/QUSpZd9V4wZ7UZ86MOde7oqjcLDCXImvDGCW7ZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38/yT1xMWvnA4r0UPfgBIIxhE/vlLmo3gE9qaVmpcEc=;
 b=L4rmxTy9rHNTxzMJLt8h3hZ39E8uppT06mGhdfSlfrp7rXpr3EVz+P3h69CjVaMEwdPi0C9UotbhdQhA7nx9Bvibpzzkc+ZOeEnidG12nAXmp0PQmj8zQe8KvEqdFkbaRTcqDxL6QC90jddAONh04OA9aY7Y/X71TArcIXZhyCOFpvpyYN7Cocz7rR4dti0dgQRee0mqCajx3PP5e78ev69zvqCKoTE8E66e+CMn4apPMzkrxkRcKsWcFqpYTvdGMLQfjoABtlzny6r/w2NWchiEnVKgEk4/Jq5uVR1yw3bySM26yAXlbzy/pi5NLx9wdh3XMSUPd0g1GokKAXtXYQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9518.eurprd04.prod.outlook.com (2603:10a6:102:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 01:54:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 01:54:50 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] arm64: dts: imx8-ss-dma: enable dma support for
 lpspi
Thread-Topic: [PATCH v2 1/1] arm64: dts: imx8-ss-dma: enable dma support for
 lpspi
Thread-Index: AQHa4xBV7qA6ElWAsEuO2Z6Np3uIkLIRpUQA
Date: Thu, 1 Aug 2024 01:54:50 +0000
Message-ID:
 <PAXPR04MB84598449445F2677552B6DF688B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240731060959.897105-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240731060959.897105-1-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB9518:EE_
x-ms-office365-filtering-correlation-id: 0142d53a-9c56-401c-7ba6-08dcb1ccee41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kdWr81swTZQw26IZhmNjvHRZReLWjvOA9Mf6w8WNBoVAERwMbiSEAl/Jbb8n?=
 =?us-ascii?Q?VsPHj7jgp3rACuYxRAXHc4ML4QNDZFlxSHjmys0tYTlXytne/ZZz2r4KlFSR?=
 =?us-ascii?Q?XB81tctI08NwaTegeFQo7OyZiJKuFAvOao3R62UlhRssuWkfepLXwZ8/2Y7X?=
 =?us-ascii?Q?+BtglgBbJHBEO+oCwJZRGPO/BIrF5N2ZgP1McsEpwU+V+qZHl9Z89+PcKUs5?=
 =?us-ascii?Q?gsqhZ/NGS+XqT5cvvGArh3Q+I2ynmqhTPVVXWp9O8VJdt4zByi0Vj/6Dhu8W?=
 =?us-ascii?Q?GKznEh37yySXYTx/hjZJn6diu83SuHGqdL4DjW9yNhulftGkgmcXPbOh8a/W?=
 =?us-ascii?Q?uJSPfvg/WnNRGtpme0L9amI/b2jrARKIhNJrne5EWdIjGp/bYw2NqZtpwd/D?=
 =?us-ascii?Q?H9SjoWtJbqm9mzwh1KAsxUG4Cn8UNHL1QFaHx3SETbjzqygUviX/ZS3SwpHi?=
 =?us-ascii?Q?bSzoUfd0JcboKYcWo4NkbOu6aqi51DCqieBXG7O8b415WbKnEqwbLJ4e4aWD?=
 =?us-ascii?Q?B14/3OSYq2NxdzAy0/Hq/yVfQpg/64ZzVN9hNn8G61MPFrjDLjatx4R0VjXg?=
 =?us-ascii?Q?oclme8T6PpR5X5COMtranrkAk8qVkPookCjADv1ms1VAmqgfHrpENN72thvR?=
 =?us-ascii?Q?tZprXgBB0TJzWzSyPwlk+VJ0eoBM+60vRyoVHAS+4mspGVscIHHbmLrbpltd?=
 =?us-ascii?Q?XTZoi/dJlndxoaqg5DcGiKtNTb2dvpn2VKf/gzuDEbthE5cLbB8wWKFBN7MP?=
 =?us-ascii?Q?FEpIrBQhIKnmlWC7FzcSi9NHVkiCNDDoHnU0uxYAzYjx1b57HXtNBsHvlwcu?=
 =?us-ascii?Q?2aNwKjQhsTdG6/BDbt8nvcJvtAajE4907bdxINH7FhNTuN2pmkohhijOKU1w?=
 =?us-ascii?Q?NNTlGcasweAgi4eDc4pi89vDJJ8c6U3dxJYUOTlWXRIrhF0mUS74P4tvAP/V?=
 =?us-ascii?Q?flBbSCRqwgYotLc3eFMWrECoM4XjmzBleFKYvg0lmLLt0OwEm0aVQo1eGZOy?=
 =?us-ascii?Q?x4WtRnroZc0CSJ0Mu7oSS0Eu6pV8SKNOhV0uZivVSb6H6MsAFDpqb3Ht7OKU?=
 =?us-ascii?Q?ocGqCbFJ8FsbXICxRslxGGqjUGsBvEJTodGQNA57T2CRzPb1j9L+gX01FBDS?=
 =?us-ascii?Q?zKTkIdoZu3dYXqxvRHUmROJhRVWGuZilenpvkTXDR4/moCoZFbAS3toWR1py?=
 =?us-ascii?Q?ZOCpEAZM5mmPQFMDzPjR3uYbevTcJvArELe/9LRC3GbgyIihNm2mqqVmNQfa?=
 =?us-ascii?Q?s2mspjpUJVWTpjPlsssYmVxvLLq8DrotKcu2YDHkcs1YphzHRp3WC1hEfhgR?=
 =?us-ascii?Q?F57WppPcRNwpguUpQ+naPkNpviTc/KZJ53rbZWxGbBdmBXYPnWEdl/Odyl8w?=
 =?us-ascii?Q?rBtRhpSqmzErgiMM8BQSxngdu0j9jUBCXx47jMUff0PgWTU92g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NQLC8KxMF52dy7Rzpsj3UHCmc8WBeA4GwmbQKH/2Q7W2UtIi1r1DCV3gnPDm?=
 =?us-ascii?Q?2mal8k1qes7gNk4Qs71kaXmZHv3Pse6hSwxLGmn971toO+zbHIUPJfoBqIxu?=
 =?us-ascii?Q?dzULn/Drv8aARnAiYNHT3hHcrS6SmgxxSCwDV3aqy8rwh5TepK2MeZEiXxyO?=
 =?us-ascii?Q?zVT97MNiXbGY/I2ZO171+haEFaQ5nhmMV3aQV98CsBUs9s1Adi3+CbC4CSLr?=
 =?us-ascii?Q?yGmJ/sKZT0j65FD2XtYrO+ckdONlubQWofGqpB7HYmOwz1Ruz5pnf1raNzIZ?=
 =?us-ascii?Q?kS2p+F5Vr9/kMAbDIV/uaLH2REV74zVYDwikKu9iUzY5QZI5mIcNP9Epyxpk?=
 =?us-ascii?Q?SH60AKAkWc5LSuaYiPR7khLJ/C/gbYkEA5pC1svhTOLHdwBeY5l3wOpoJL5d?=
 =?us-ascii?Q?1dbsMe4hjmE5PvBSENfK+m+jGVE74gOuTskHvjfvodjsWPh8JEcW5Zm2Z80Y?=
 =?us-ascii?Q?9D7rKNcvggMrTlbHAe/VbaiWSYpz/+N3SW6JQrm8Bb4qnPrWEcBu4EjMwdSr?=
 =?us-ascii?Q?4YNUYEP4O7JYOtQgSSySEyCN/bBcLIG3qw9XZt+TuGeupELHXZH/MbAXx3ex?=
 =?us-ascii?Q?c9Utz2GyrNlhW/6VujMHA+XDkKbzyXigk9PbgN7/wKwAjo6XW2hkJvJ03QM6?=
 =?us-ascii?Q?z2zLzsx5ItsfIbeRrcA/d5eNMBVKW1/N8yOKl6EVuMTOa3Cq8IV+j2XWuZJ+?=
 =?us-ascii?Q?hmQWg0Rtypqlp7p0Nu57kX5twkhwcAckXYUrsG8t0j/lF6XGnRFzstNd/l1W?=
 =?us-ascii?Q?GGbjhaGppgzC/fvra3BFQVexIBVtMnDGpYyT6moBsKW/nqx1ORd+Ar6+ljcY?=
 =?us-ascii?Q?rtxGXO50Nym0JkxIN5vlnUwgTE0DLHTbLTtai9XkZAtj2aNEsrs0wd3s5p55?=
 =?us-ascii?Q?ELDbdzhA2B6L9+WUCn5/oXvRbXRuhluATExIXXiizAer5f9eJBAuYlKJ7jxU?=
 =?us-ascii?Q?U3BqnGfYRRW4Vl5I2MIQVM6PAauIQuGuGQ98fOX/G8Saq4j1uGUmE62mRgQc?=
 =?us-ascii?Q?jbCEQ1jSlxvhC6wMmCaNbRwbcRg7CeOcwOV9/srd/XLib6uewHnV0yaRo7GT?=
 =?us-ascii?Q?KYLbTECuKadkbrn7spu4QF82cJOuoK4FMvX6fGio+OJtenes7Ye464fgNibm?=
 =?us-ascii?Q?kGRsIsUWyahlbpIb8DD1xS3qqlvd4KZlmbTatPdvabLM7JJwOMtNyie5ikDO?=
 =?us-ascii?Q?gJsmjFGRG47sYberpB9Ol7HFEmupR7bxu8Y2SXdbY+Edy9nVTI+NYUxpf0Qx?=
 =?us-ascii?Q?qUoEgKQzFfQ756Z5O9sHQXLNszh4qkHPgZOBOC0sBdcID9xEM7CV9nzBo9Ck?=
 =?us-ascii?Q?EaQ/d8TXBfmRUYVOdaubtmfI/QaxQuTNhxc2SUGQy+S90ZuVRQiODuhRjkdC?=
 =?us-ascii?Q?kSqIFshxUNri9RKVPVcCvQPqMhFUNr/JAgJKGs18DUgRXwv8cSlfqNijpass?=
 =?us-ascii?Q?5IaiQTEQlJ5sMOHzUV7Ibo6o3goyTcWGISXoC6LFlDkQ/UsBVYkD79ejrE80?=
 =?us-ascii?Q?1+RDMf563l2/S6ghB3vyZ2AeOp2b2ratpQwdTsgb/4NfIsy8i7cxSv34Uka8?=
 =?us-ascii?Q?yzOMWbCubO8wOEgnzUY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0142d53a-9c56-401c-7ba6-08dcb1ccee41
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 01:54:50.7952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Q4VNubllHzRhuGHUDO1Rv+/uPkOPfmpRSaqhU7WpE2jiyOy6bhFDHYhb60nX48XJpxPkaOBjJ9Ch3Wr+afxig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9518

> Subject: [PATCH v2 1/1] arm64: dts: imx8-ss-dma: enable dma support
> for lpspi
>=20
> From: Clark Wang <xiaoning.wang@nxp.com>
>=20
> Add DMA configurations for LPSPI nodes on i.MX8QX/QM/DXL.
>=20
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

