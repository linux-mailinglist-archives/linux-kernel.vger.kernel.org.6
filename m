Return-Path: <linux-kernel+bounces-256104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BF9934900
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81D12810A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDFF770F6;
	Thu, 18 Jul 2024 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l+azEmp0"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3FE48CCC;
	Thu, 18 Jul 2024 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288293; cv=fail; b=J+xdtgwA1ZEEvPt90l3GaoOZGRqkaMd8ZjghShKU9bbVtU0sj7djRbl3lqXXjV+hcz0zOhFgqvrE8UkEPwttVTW37mRjBJTwLXFG7NbA8pUUmJL2gBLczer3Q7MNPEXKNV1pTSyXFgZZ7YIkv387pRydaMpsn74hV6w1ADH1gNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288293; c=relaxed/simple;
	bh=4CKSvGFQ9UUIsWFlAFjyRt0UGTmJM9j/KjMMNmkBAAk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dcpUzKnGaIj95j+7hU0CeTuMNoECctox9FjSB9L9u+hLqHlp65860iEDJcFum5XC1iOHIqNGspkwaMB1LHTSKnWMcajUHt8ya933d1nXTwYZEZIkuSpcEKyddnVpL1BoUJZNcqk8odG7v5ETkvKL2rReOoDbK7NlsK2BLdHR3Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l+azEmp0; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puoGZ9D83NT2o24+Cl6Zvtb6z4YMpXVTAQOGgiLLVOXzdtu4B8ZJBFuwJ4TWEegoa24dNsTgq6VaaY2hfOsr5VQendQWP85yCS9DXHP8eJN6fLpgTFWl45/sEKWLXJeR2J9Igo13T9XF82FG0DXRhPVyRHeAr3ZVVzylHVZwsyf1gI7NuyfYMz+RdZbMC79YHauGaycI03c5Oz2LP/M6pE+e835mdpUMovOHu7HnkAOW/TzEXYZOjo8GJsUlIiSIOcWS9VDQVVmfZi1+ZBRrigna3xgmngkHyF2Gk6BYZN3ngZOlrrXmTNeG2X0kvjv9bjLMAXRr6wUG0YaDR1G5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CKSvGFQ9UUIsWFlAFjyRt0UGTmJM9j/KjMMNmkBAAk=;
 b=ezY6oJXkbQ7JlTBYBlG33rRrIQdVOFLerAX32me0UPJDDiMHiXrbsRdLvKhh6S+GSdHShQNZPVoMEXFyVP7J42HObrbCpVDBI6HyZVUBD/csIXztmzP3cGoBTcvE4id3laora/QeK5w2GmDzuk3aV4O/ehJoZg4zJHG+N5Sp42+mxZVIwWKWP9z9HtwF8WhauyWuVwGNY8oTuTogeJIuRGRac1DCTPvAOemMb+pWJEZ9jlFcSNvadcsUSwXwTCmfELG38j2w9Rv4wwVBhsjKWW8hAkhWbuYUAEGSb1yLxDuMoOpjD2vyGUgEvdYJJcVFgH/PdnGCMlY0cryYcvfSWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CKSvGFQ9UUIsWFlAFjyRt0UGTmJM9j/KjMMNmkBAAk=;
 b=l+azEmp0ZTERxE09ZW4iWp7QzVtDgZ+YDQfpjlfYEjXsyS6l81fH6Wpiick0kEsXjl9tmsgN9jIyhZp23l3FyOFU+n3IlimA7eTRS9RszNpCYheulGE2wZ8gVvn0uUm0m3/Pi1BckQoDRFyDDxyFRGyU2e9FcO3XxXhPhiJ/yJk=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 07:38:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.020; Thu, 18 Jul 2024
 07:38:08 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "S.J. Wang" <shengjiu.wang@nxp.com>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] clk: imx: imx8: Use clk_hw pointer for self registered
 clock in clk_parent_data
Thread-Topic: [PATCH v2] clk: imx: imx8: Use clk_hw pointer for self
 registered clock in clk_parent_data
Thread-Index: AQHa0qdzsDaOl4UD60OM+OSbGyrv5bH8JWJg
Date: Thu, 18 Jul 2024 07:38:08 +0000
Message-ID:
 <PAXPR04MB8459C498844527407412CD5D88AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <1720600860-18866-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1720600860-18866-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8898:EE_
x-ms-office365-filtering-correlation-id: 66b24c2c-2ba1-46ed-448d-08dca6fc91d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CyBG7VDl1OmSdeAZ0SbUxfF8B3HY0XouEMcR9hn7yIh41mE14gaRt5+t9Iwb?=
 =?us-ascii?Q?1c4m9xspes6wbdhFHFXOXZ8so3gIm1SEwjvA3WXeyE7PBqN2ZbA99CML+21h?=
 =?us-ascii?Q?Ft9Aw+XsPAAcB+Y7xV4ZtaTdiIi994eZJRk8HHb+TIOnEuExoWiFXytRKYNl?=
 =?us-ascii?Q?yNjh1EJu6OKUui9BdZO/Ix5LKLSWvKNEqGngLl4uS04BXZc9sSW6aEdllawg?=
 =?us-ascii?Q?V9H01f07JNteuhTcTPTk6UT64lorRROteWePdECU4FvsbTqf+V11ZDjO2eWh?=
 =?us-ascii?Q?v8ZcNq3YxwYFZjB39gCOsQTefQusXgsjGB/lW1+iDCK4RrttWgdBcIUviUrO?=
 =?us-ascii?Q?JsJJaH/dK7/ERQtSnqJy9iYGByJ4wwK09VrKfHUBCsrL5gRvki5Gd9L2cnjX?=
 =?us-ascii?Q?rGxEYNfirudiQDdSaXMTqr83GUH9SrBl0C5UapsGZg+vGi7I8N/ZXGOmp5wb?=
 =?us-ascii?Q?0I3QfTzae6LMZZy4W2FpbE8OlQOtW8PtGHzw8gxQibKm/ToJMNRmPW7kTFvX?=
 =?us-ascii?Q?YG2ax0tP72eFvHaxnYn5y0Mi+yU6p2ZBwgvz9KzHZ6qw8chZso6a0+qFzV6y?=
 =?us-ascii?Q?U7FkPyknRfZROwCm5EuyCdMykuSehZM6FzqXMDpji0xTnam+uioMI0Mb+XgI?=
 =?us-ascii?Q?3lz5fh5B3tPw+JcEggyI4LBptFzzoUBhG/BgQjIc14UL9ATZMHH0ONjJeW1w?=
 =?us-ascii?Q?yUWv71EKUHBfUEG1f244g5IuEMfJ3Igdjp0CRuFNG17gwu6Km4YDOfAXd6nc?=
 =?us-ascii?Q?hyfTNuG61uTNCOyVCE70IiYArrbW7yYxORn376RAAHyzGfYgu2qiiYk8AtTr?=
 =?us-ascii?Q?/ADuYz7MieG2nJmq8vxdBF7kSDp4qt4/xaaP6BFGW3eL0xNWGMewX0aSiCRU?=
 =?us-ascii?Q?MGmYv2OKmKYUya1Ql0nCaVTg3VaCwN6fRzJMJjQOFDVExcJ2YGNn4pj8joaS?=
 =?us-ascii?Q?L56czqLQ1MD8VBcPoOVVVqw578XimMHzi9/VcDQo8BI9vNaQ/adroVgesWF3?=
 =?us-ascii?Q?vVVC5lDhC+BK10KeyOt4vaTZJ/Ke6EhSXPjD0iM9Q5W9u591fbIoMp38gO0U?=
 =?us-ascii?Q?F1MhFlMyxATjjBmzdZwHbljR5V7KPeXMn0P/TvIihlWg7KTa8GerF5YXcE9F?=
 =?us-ascii?Q?mYHTbb7kHNwE+uMZV30U7szEBiMb2TMW7apipXqbuTXb03nERmB+LwQNNf0a?=
 =?us-ascii?Q?ov5Nya5vTgWpORPRvytjME/0jyg3X2mcFDA6Iu7FfmT32btrlpcrTwlThiwg?=
 =?us-ascii?Q?VlPfjwB75Jwfj+wgamRcFEDhq+Sf5ZuKytudzeRjDSiEdnjcaJMEQfRCtNbq?=
 =?us-ascii?Q?5FexTs4NH2z9caBxorxdvWY8TTH0cFW9y4vbfHWGwPNBkTp4scKZaJQEzmlH?=
 =?us-ascii?Q?N8TQkKhjO1RIxRre1xmJHZlTQy2WjongjLxnK7OgTDRmJVcksjAzVYNW3Cuv?=
 =?us-ascii?Q?cAXAqOFs8Rk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wFjfQUXf/A9kvw7Z64f+QOVBvI4gJ6sqCxP9M/q44MJnk8+NwpxFD45wCRaf?=
 =?us-ascii?Q?2coAQbqK1Op74ljcxizec+m0Tj2YfYeKPizSX41k9jvCNVi7RuqQPAxdXk1q?=
 =?us-ascii?Q?7UqlTlUpq7iqn9zB99TuaY+/FhsPDcov2wslGpBoCciOtdPF/LJUAifGQoVm?=
 =?us-ascii?Q?O81RTvNKQhFULPlKRxPXgSMV3o2HzHoC26UJAO5QLiFC9TjEtRgzaxAhXtvc?=
 =?us-ascii?Q?ou9HWGDyNCybV8jguDyNoYAnoF/P15dVwLijoVUqiUR/UG0dhfTU5eauxo9q?=
 =?us-ascii?Q?hdbJhOCooEN6bl95Lic6K2KBFt/x8i4CGaB1tIe/y/I9eZWCf9zV2RduDTXU?=
 =?us-ascii?Q?HuDExJiLKdSGzxF/+iLRLdacLOu9UBgowJt3dfebjiRadgbsE4KtU3TW2U92?=
 =?us-ascii?Q?AKYFkf1pobz2gftE2N69APe4gnvS7Y8vCwVF3kxt33bv82iPjjpiig37XvvB?=
 =?us-ascii?Q?YmGDgIkPd4FCh3xLFi72c6/JPAY4A6BgBTDBInDGmDnLA3ELVRR+pw0zleXM?=
 =?us-ascii?Q?lqW0Pz4kX4qJEnmWSMtoVYBk8XHkxaYtogCqJ7ZZBmKm9siiFN0LIz4YNLIW?=
 =?us-ascii?Q?fUY+5NZGaxBl4jBdCCScP+KYQzMcNx5FLOyEfLwz0a5drE1T7KD252sw7jXd?=
 =?us-ascii?Q?TK84LvM9Ls5eEc1Dva9SlX/VLqaOFdXQMy7es8hyJ4xbRCm9iQI4m480fFZS?=
 =?us-ascii?Q?LhN1XjRLWP4RDVWW0xMSiE/cR4J91+MUs+CiQA+P98R57xA4Zv2htqXXGUAc?=
 =?us-ascii?Q?qWkyeY15dQMZtKf6YkPKtgbJHnWIoQGRAvlybwSIh8VWWWo7cYOCCx+ar1KT?=
 =?us-ascii?Q?Hclfhahgg5xzEflH4u3u9D6PgjAg71XnyBgxBxD9zZPf8eqLt7MxGhXkAgtG?=
 =?us-ascii?Q?zeza9my+CqxYKVFaXuSxLMUqfsszPwcIc6WSkUuRRaIgvzlgY1FdteG2ALTD?=
 =?us-ascii?Q?OLnK0jZvijjYE3qsQAPvf7GtVoDo7FxPuJIxLCCkVRrlVCZUM349sFAqwlmy?=
 =?us-ascii?Q?xbRMzTjtRemgx5hdHCYiUO+EtKdp/aQXH/SotnmLDQnkRLAVeRogECk5liv2?=
 =?us-ascii?Q?bLjWN6z5Md+J9GJvTjG8Fgzny9g7tE5f5SLlesQ2mQx9H8iT+bSxRoKrBW57?=
 =?us-ascii?Q?VJtkVIfpIrsooQSDVMsrRP8g2IavNj7twAUet3Gx8T+B5Ei2KBDHHXDSWgVP?=
 =?us-ascii?Q?lJMUOvjgNvhfboLTepdhebIytCFsjV6hDOkjrREfMQkIt9h46KzVW9259e8n?=
 =?us-ascii?Q?+dDndP/Ew0KZ8SrWWYQ/ACljBzteEG4klXTHag8w4K3mDNYihLHtNB9e9tPc?=
 =?us-ascii?Q?8EHUOC6OeHYzO9pstdcgGCoHe5MTmIaNQ7ep7BOSbKMMHFSMdMmC3y/GJAb3?=
 =?us-ascii?Q?kzcypLsfKHFyDUcZpLNzMjSypB1lZPpt/24qZvQ0WJ6RnCS8JNNzekhT7NOk?=
 =?us-ascii?Q?j0PDdigiVP1WovsokI/vbgRSOBoW6fCftZbn4t17PLRGgd63qUTjmezxBngj?=
 =?us-ascii?Q?sS+fcdMLaUpeOlleT1lRgNjn4S1gCPnua3FYGojDwllf6L1mgNZPIS6/Rz57?=
 =?us-ascii?Q?A9c4x7eAEMFA9rDfMb0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b24c2c-2ba1-46ed-448d-08dca6fc91d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 07:38:08.8275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xs9lP/oc4LRe4HOOb5GfH2wvKDrAToRprX9N0mLtYioLim/ihBkwFH6p9PF1bsxQCdCm+cv5JtcIixQlQ152DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8898

> Subject: [PATCH v2] clk: imx: imx8: Use clk_hw pointer for self
> registered clock in clk_parent_data
>=20
> "acm_aud_clk0_sel" and "acm_aud_clk1_sel" are registered by this
> ACM driver, but they are the parent clocks for other clocks, in order to
> use assigned-clock-parents in device tree, the ".fw_name" can't be used,
> need to assign the clk_hw pointer for the imx8qm_mclk_sels[],
> imx8qxp_mclk_sels[], imx8dxl_mclk_sels[].
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>


