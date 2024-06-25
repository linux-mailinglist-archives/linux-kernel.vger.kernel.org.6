Return-Path: <linux-kernel+bounces-228185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3947E915C09
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C3928432F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F813A1B6;
	Tue, 25 Jun 2024 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iqeF+3qt"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA22940D;
	Tue, 25 Jun 2024 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719281253; cv=fail; b=mROan7DMZJLG+fI/xGfrj/CANDh0KWKtuZv/QDjSDbkCG36qqPGzmzl0RXhALzGkw/IYWQFJey+wyYH4PIEAIMJ8hHF4Us9TGXUWWSJh+aMM50OUK03Wk5R2X/43hm4atb6GSEzAHNRLuEIbHL16OOFQmtweeNqzRpgg6lauC5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719281253; c=relaxed/simple;
	bh=7fYPJDUeZsHCZO2Gs/fuX0QeZ18NRxwZSkgvJBv7ILQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HDN3RW4+f8ilEkfy9qIe2URY02aicEkghAfAgm5lUQtqKHzsW3GLAEShsmD/6cPbalXvVUPM/wJbdr8gjDHHeeautdgu5QGdQPvO5PNQ/IzsloX++PSXyLSY7BPcMFN12La60sn2/go8sEFT0Aas2sE5FsiZImNFmZqa4+2wGPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iqeF+3qt; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5XxMD0rcabX6cajS1JX9gDQTb44nCgUFCIexFO8of01Po3Thd0CpNpuIHBCliycn1uuZIc1BDSwFl42sCreFFN/xCOraaNICCaSCtdkqo/KCAnSvwMS0RqM3x+zNk5jF8G0uTgWDW08GujmX8iaUHoPN6pfDZUdtu1mEK7EfXnSJHdOXqUwZnzEzdHQqpkedJp0oa0f7KzAaSFRiBizhoL0OEg7TF7DnBXOYWhWUc7biQ4/i4stldMrxfNxs+lPJPWbDZ1F2hrr0Kxunmh94wfq3Yoj55iBlurEnqOpCJeO/Kb1yUVXI1jcB2dPOblvI+TN1162v15QSLiHlsfXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fYPJDUeZsHCZO2Gs/fuX0QeZ18NRxwZSkgvJBv7ILQ=;
 b=YUcNNJ2woAHFhkAGFW5H7qIVgkrNqe00Rz/T6mOiyl4yMr1TiI1sHBvksJvt+rMEGiIq+4OdXGENeE+4KauBdo72Jy9tjgoLKKwDraTs5tlEG3d+eGTCOH3I6lA9cEe/9G/fs8Jkcy5FZGm3rXWJ3+6785FF6tsB0myz1iPyo0qLnOLFFmpC01aUnzExNKVYeWQOvrGyLJfK/Vtxfbf6jjI17xzuzCtX/QvIc4NlEfADxaUxdVIv6VB6TxvXG6zGAJwmwkvGg1ArhX0Z028LtC155+zIbX2F8rNzQGXZJN8zE+bqpwMrxNZZaf7UXo3Wsn7WiPRKBGBq1ZDjzaB6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fYPJDUeZsHCZO2Gs/fuX0QeZ18NRxwZSkgvJBv7ILQ=;
 b=iqeF+3qt1LjHFl6tGpoogVhOTLroFXiZz5wAX7FXirYahbVHtYwLNNXBFRpNBoN79RHhbx6IveqPS04qM4iUKFvxfor7+on/GCDZvJqo6KFPb+lBdY//7Y6WTB6C25NCM3kYlC5v/kt9590mc6If+2wsWNPOUrsWnLhQBhIOvVY=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8426.eurprd04.prod.outlook.com (2603:10a6:102:1ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 02:07:28 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 02:07:28 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Pengfei Li <pengfei.li_1@nxp.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"abelvesa@kernel.org" <abelvesa@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>, Aisheng Dong
	<aisheng.dong@nxp.com>, Frank Li <frank.li@nxp.com>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] dt-bindings: clock: imx93: Drop IMX93_CLK_END macro
 definition
Thread-Topic: [PATCH 2/2] dt-bindings: clock: imx93: Drop IMX93_CLK_END macro
 definition
Thread-Index: AQHaxqII8Q2Wu4dKnE+BUckBnLjogLHXu2SQ
Date: Tue, 25 Jun 2024 02:07:28 +0000
Message-ID:
 <AM6PR04MB5941073C130929AF1596BCD288D52@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240625175147.94985-1-pengfei.li_1@nxp.com>
 <20240625175147.94985-3-pengfei.li_1@nxp.com>
In-Reply-To: <20240625175147.94985-3-pengfei.li_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PAXPR04MB8426:EE_
x-ms-office365-filtering-correlation-id: 256475d7-b1a7-4efd-0c0f-08dc94bb9086
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|1800799021|7416011|376011|921017|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?C5QLlTAovmpJNvbZFrQ9n78OwWmS6GUdlO0iUnbbFgAC+kbGAOGJsm29OPvU?=
 =?us-ascii?Q?OE3VAz2OlH3ilSfmF30/v0QLgdyymWRN+e46fydMZi5+IfGOzbwy0DyZE9/j?=
 =?us-ascii?Q?BWLescVSYQ7ArKUP1CvSzoJxMDT3sUdjyTGTpNeHGp6vU9gPk/gFXmaWEdyf?=
 =?us-ascii?Q?PF3BkDLJnUYggryFpoqmglo+04NSjLiUxFoCqAgByFtGTlL41Gm/8L4sHCax?=
 =?us-ascii?Q?5shKEAAu8xl3UU5M/yjG1QwCS6XwKbctoRE9gk+buSlXTILtWeN1oG5kRhna?=
 =?us-ascii?Q?YGmbXOzw4wIxadXQrBt6BGUCh5ST4nmGG0C/uAs3Yr+Mm7wjuQqGJ+iaGjUJ?=
 =?us-ascii?Q?TUBwLeEJyn1RGWyKxHoy8wdh6miUgAuoNfMLmzQ+E2hnTRQorFgUO3eEPyF6?=
 =?us-ascii?Q?hBWANOM6g0MI5Lg65XKJ8cWSYhAZM5SW444ourNWwGyA/eYFm08vm/BovQer?=
 =?us-ascii?Q?2lMN0TXZM7tK1dFNXcZf2DcuGkRUakJKedCVp+SnAGhFvmwGcaHW+YCAdPWQ?=
 =?us-ascii?Q?N0yTjuS/nyRi6QwMoOtlKSYmD6THIAqbs+UZIe+jI03PP/BWq4Yw6R1hrdRr?=
 =?us-ascii?Q?or08F7ACZmGNKvsx3uH/D4inMSGcVZOAG7r0euEPEN4cG7/gCXg+lisRXhaE?=
 =?us-ascii?Q?Ahtb+/RYbYkFbMsy8FsVjBRCai10qU+rq+b3Fc3kyR7xKFY5neqkMoBKWUYj?=
 =?us-ascii?Q?Drg4kkjn+fjuT4ZjM80T2HXl+0C0KYMGQF5VKz2Wg5pjJII24KS1U/LM1lEG?=
 =?us-ascii?Q?TDI8IjqOxxy2Vl+NzKHTI9QlUBWm1hLlCoLNg3+BTMzj6PTDWBo5+Zhg1pzD?=
 =?us-ascii?Q?Xlx52Pf32F4pYEUSdYiDvaGZasLgD3jxnU6SHSjZbN49VfiY7PvHGC7wOon5?=
 =?us-ascii?Q?ZLouJiz4IjA1njDeA0xyeDQL0Qx+YdSWN/jiuH0sR6vxS7aFOssGfdze4KAH?=
 =?us-ascii?Q?vaGafGBB3zfMHrWSftpdCO1/2u4NG1ZZDSxY4OWv96Dgd1nu3W7Oi4jgflqZ?=
 =?us-ascii?Q?/suCLBHkRD4Klj6mFOYBQEmsSOobEV5ww0Tj7/FQuI8e6GHBEBZuv9Odmmak?=
 =?us-ascii?Q?XLvv415qS1/cg6j0jYYpXcnFbWeoJ4U8rOorxENhsfyjBly1nKAhfM3sYM6i?=
 =?us-ascii?Q?A4NpTXUE0Ej4QKbSdCHdxEbNf23wwIS7CKgwpIjDw9M2ZulgiidopnLR302L?=
 =?us-ascii?Q?55zap1Z7URAK7OIXgj1odV/fMUTZslrcdFiFnNXLSPrIcn8dCVJQ/7xifURz?=
 =?us-ascii?Q?3iuPKhS0taH6Kz5uIbtJymhsIWW4Kev/Laraeiim40xrh5EwwTmDlW+wzQCA?=
 =?us-ascii?Q?8cP2fNP+Y/QQLBQyJPOBQguXf4jg65nAtKrHfM0c2Q9ZO2lNaHCBiNlQn/zI?=
 =?us-ascii?Q?Q4CCZV3zdgGQ0Ho7xu5/QWa1k+OK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(7416011)(376011)(921017)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TrlP/w/u9KZZ/hK7Y9M3iZAcJptxX5Gmifpf0svsHrdV2qQ/ywGx+3inUdlY?=
 =?us-ascii?Q?3ruRyY1O3FNlbsXZybbpzyDpkQqK4gFMK5OmRxeaIRHGbff0BFX9d7O9r6Se?=
 =?us-ascii?Q?mex0MeWXMLnI7zwJnBDO30HqZy0zfynVL8Luy3Gojg82s1hTpT52bg6rP9wr?=
 =?us-ascii?Q?KBWyfabo1iBIUwvJenX0nlmImsW6hdQvZpWw5hGt6pNDq/mRHfbU+jCofHVC?=
 =?us-ascii?Q?h26jDj1sYsY3SkIjs5CaiREr6Fm/j0G+5/f6KSM+tdr+91lWgSExlsOXyMks?=
 =?us-ascii?Q?xDaZf6oOH19liKxyDV/L39gIutVgF3KyZw+VWXTnWr+7OFHPormOAR6z/rJ8?=
 =?us-ascii?Q?L/5drgVNlLv38qbyfWw/7AqXJsIJpg1aP9VUzh5OK323GJ+7/Zx39Jtd6war?=
 =?us-ascii?Q?yCjWn8onHISFeov3RCoCv0F/9SyyTjEcgghfYCku8+sE+qpP2/fUNbMgV9jz?=
 =?us-ascii?Q?NXDM++yObASmitoJ86oC/NTINiu/3v1EgSU7OJd0/yNMXg/TQsFs98LiF1e6?=
 =?us-ascii?Q?jPvpWgHRot/tZEAr92pj13NanDW5XKt+lvd41Crzq+5B0rLdb84KCLwG5yHL?=
 =?us-ascii?Q?tavl0wQrdDotsMljLEtUmAhReqR/nnJSv+68zKpEmrRZmHHAONoyD+9AvSdn?=
 =?us-ascii?Q?k/MMgMGKuaOZhl0ugNbiA7eF9bjnn6+kvucKY/hUQ58Z3EBFT38a+uyRMfTp?=
 =?us-ascii?Q?6lU0XwTg2KfO0C/2reHKq4/k/7Vi/IEwR0upLAc9u9+64giadfLrDEBHCrF8?=
 =?us-ascii?Q?CxyZsaG7V9QR58I486tlNUU9Lhg5YsLt4ydo3yrF/G5rPe2ZV0C41KISQObw?=
 =?us-ascii?Q?G6mMvrla/7oust2OHB2OT4oxBPELbmHBu0rQlihYCEIrJQl65f7QOsFU64YN?=
 =?us-ascii?Q?0J/fC0igtkExbHgx9AUD1q64CzIDsSXKJcudPXiCvJj/hJRHI4SzSJZgKi50?=
 =?us-ascii?Q?Nv1GXWgMGqPJ2XJ1f4TLj5JUYhnZRgMQWKhuud8UCn9vvXtmw/Re8DIH/YjP?=
 =?us-ascii?Q?r6NqNeXAk9wCrHZsiuIP9ZbrWAZtZEP0L8Wr4QM2uUXg89nhltVIQI5IOoSE?=
 =?us-ascii?Q?lzhULqnDInWiOZDL5oNcZNywcowDMsD+8vO5PhPwsXa1pkTbuXlbLZpztUtF?=
 =?us-ascii?Q?VlVRm1GWl55LztaWReQmuR5s/quOCQI/px0rEhLCae8rducdfovWKHZ/r0au?=
 =?us-ascii?Q?H5Ui2aielJMGfO9iJiSgbXzO7NxeL8tvH2Msv/xUa5LyKZN9jyTQPrNe98XS?=
 =?us-ascii?Q?RjY/eGdCxRwu07KPKvvogOo55IdnesMhFq5LUZkBXDsxb2PVBKtxIir3qUex?=
 =?us-ascii?Q?DSAD2+7AxDgQMgKhHhQOtqOuhJIxv7YNMt8DkW95spEHZR3IS/8iuMc6Dt63?=
 =?us-ascii?Q?GBlbUlA5p90VKEoMlqQYue9dzAatgLNbpJlx2xB5WS9TDIaNmUIDGw9c9vq1?=
 =?us-ascii?Q?N/t1MKnBa2Q1kRydxoev8OwZa5+t4qGsDJSk3EGMgUpApj0gmvNUsVeEcc3R?=
 =?us-ascii?Q?QRcBFysfmwW5cQ9LESVFFVFKXtVIzIPH/1uPIWTTFWiDAuNu92RmHv1TWBtM?=
 =?us-ascii?Q?nofQgWWTo5qUt+BcXb8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 256475d7-b1a7-4efd-0c0f-08dc94bb9086
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 02:07:28.4174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dzybv9cRe4jh16Zdmtzv54w0cN1YWMrDCJFwyKEb8jPpoc6OyS6LiOlO0X7wb0KPsd4mgN/Y89OTPJq0AmWRPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8426

> Subject: [PATCH 2/2] dt-bindings: clock: imx93: Drop IMX93_CLK_END
> macro definition
>=20
> IMX93_CLK_END should be dropped as it is not part of the ABI.
>=20
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>

Acked-by: Peng Fan <peng.fan@nxp.com>

