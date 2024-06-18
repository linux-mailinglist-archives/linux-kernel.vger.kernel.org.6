Return-Path: <linux-kernel+bounces-218677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB3090C39C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 08:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9FC284A72
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD8822EE4;
	Tue, 18 Jun 2024 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cxYxj9xZ"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE81D9527;
	Tue, 18 Jun 2024 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718692409; cv=fail; b=aB2nP6cX/3LfSX1b4vKdHcB/QUV78BGEUJtS3qjY1/qT6FAFEhv8WTlvuiWKLL0YWAFpO2CK3KkwArZhO4iSwKX57j3SOp0jfCGht7AxV3lk/tioWbH/SWBhW/mheAgMvkzkaSMv8q9VPf3H838RkFtlI7wO9SNotr6fiWeKioc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718692409; c=relaxed/simple;
	bh=6QGkufvQtZ80Vl5CdLyey9aLxuZmce6UNkm6KSwvhgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T53pd/ktqDFn/GpxKM32LWekkHlV1AMhsEt/IKzuAi+YGp7phZ5naxYFPb/WxpheexGtiXb/L3hS2AVtGBOT0b1qMSt7tPIL9rfEDp7cOu2VXkSitZSxL8pPi/4wbMuGThUD06wnQ83tITm/3fOTyXpq+r+K95/FGts3O89xOKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cxYxj9xZ; arc=fail smtp.client-ip=40.107.14.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dv52/AifD8lTDmvcXFQEPiadNAN7et3b21GVjtp3jldS2XvS/rv0DdIsPPnfHmwV5haCMel9/YIIg0UwHy/+aVJDD/54PmHUcjLnmbXhMLxVjUc3OH+BmquXbNhUjqywV8VkpbwaChStFozH/+RFEBNy6oP/+JFBleJevc036443spwl/zwKr02Yn6dNHAaMuBsPoy7OUciptXvQUsZ0eR6ambil15ml7f/IWHKprl9soWZIRtxP9LJAByipptUKxNRRw2i80eIAswq3i8VJiy1jH9uDYJ7z1jc/Jr3lom+vo/DtvfKy8YnCx5lMJHW2nJn+F1hNlqZiMPGus756Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QGkufvQtZ80Vl5CdLyey9aLxuZmce6UNkm6KSwvhgg=;
 b=KebESQM2/qIT9ooFyI+R+8RZQQibIZZNHv+8kFdMIIoO/zfxCZE5n8BrM8fr53pf8DbCyXW+df8/o0h8nlwO4GSOMB/2eeU9NTwZwNqUX+JEWjIBSE1LHwdSvQ4zzNP8WRRqDPgDMHzVKaImcYgLqOsKSpy+gZIdKjjODOc6ZlErYcyDUrr/UZxUD7D7Ahgij1HiuucZXVQ0EFpJNW7j4APzL5tmhPCN/M/ln1TBVVuTRkHO8laGLjmK1EPuocmefpUrItEinWZJDVNI2pzCVD/VpLMt/jtbw5MVdS9MFbJVNUFRVc9ruQUs8QWjfPNdKIU4qmdNqNwxJ1a+ZZyRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QGkufvQtZ80Vl5CdLyey9aLxuZmce6UNkm6KSwvhgg=;
 b=cxYxj9xZaospUMAIhZO8AHUaXSRcdDawoG2eI/qNxmP/OlMnlJQhoPtqSyKgyECT6vlTAMfNACXc8VadRkf+i13Pqa0//XWg5P3ZtDFc02Da5waH8iZwyjx2lDsd5+tTdHnmn5KKgH3u9ng7ryHl7KQw64cRrP4zLYtxhyRGu/0=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DBAPR04MB7397.eurprd04.prod.outlook.com (2603:10a6:10:1a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Tue, 18 Jun
 2024 06:33:24 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 06:33:24 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Adam Ford <aford173@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "aford@beaconembedded.com" <aford@beaconembedded.com>, "marex@denx.de"
	<marex@denx.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Marco Felsch <m.felsch@pengutronix.de>, Alexander Stein
	<alexander.stein@ew.tq-group.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: imx8mp: Fix pgc_mlmix location
Thread-Topic: [PATCH] arm64: dts: imx8mp: Fix pgc_mlmix location
Thread-Index: AQHawQdJKwQR+YFtS0W+nwfUtahmerHNEKNw
Date: Tue, 18 Jun 2024 06:33:24 +0000
Message-ID:
 <AM6PR04MB5941DE4CEAC995F6E6328ECA88CE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240617223952.1899201-1-aford173@gmail.com>
In-Reply-To: <20240617223952.1899201-1-aford173@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DBAPR04MB7397:EE_
x-ms-office365-filtering-correlation-id: 4ec64edc-e434-4602-0bc2-08dc8f608e0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|1800799021|7416011|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7eOFxIo0JuyN8Of6BF8qq0mJwoqdbABmYdolwA1J/tWrrnUFtn/usnanPY/T?=
 =?us-ascii?Q?IVHKgGKG7jSaKtugU267MzJAGhc1PRVT1t1ov2fIAYplcXL2M5fcj3jp7puw?=
 =?us-ascii?Q?zRoYQt+o8HrHMIEhBlIukLJLB65f/EHLKyd1obNBA1AjYaLBiEXmc0z20tLv?=
 =?us-ascii?Q?poOW3dMBPLFTHc1rLkPtFuDqhIUFkkKgzhRQaYy4E5BnvTMKkJSFLuoOri29?=
 =?us-ascii?Q?8K03oraC3hq2srJU81nCWF8B/9fRJ2osBDZZ2PUkyCqk3dMCIgxHxlEVO/JX?=
 =?us-ascii?Q?buRGGKYss15BtwOWc9ou3Nu1pSTRrUfCYFRrW101dnBNB9VOxzxPyjJo9k9a?=
 =?us-ascii?Q?suri77FtbwmdeGtEmpSYbUhOpRpvXlduiGpd3of/yX4PMAzPRu6ROdvaeRjk?=
 =?us-ascii?Q?1EIWTNsMw4qzNugP9ehftTQG8+h6lLU0AexceCbR04jtuc4SE6FRncyOLEP5?=
 =?us-ascii?Q?PfP8HA2loAnrR5TFuruVhLLJ5B54lHfkxjWKLs8hqfTu0+lmhn1gYtT6+loW?=
 =?us-ascii?Q?8ALPGiyrqak9lgGBVP6IBm20rLfQjm6k/7TjzU6aL/etjWNqlYB0fVYwAxs4?=
 =?us-ascii?Q?WPq73g3Xrndmu/qioe7j8aaaHoulB8PUf/CIUEFOE/2IlVmfKqGJWqThgf/A?=
 =?us-ascii?Q?UgoJfPXlh8ckq3wZsyEaqzf/jYBpDIaSYPxIblC+s/S/ucBN/6OmOGJDZCj+?=
 =?us-ascii?Q?C0rQ9MI/Ii5dOXj/6ZbkCBkzmDlDvSnoyZY+h0yoF2rdClQVhaHStyeJxaqw?=
 =?us-ascii?Q?QQp9e4yLb53Yn47+vM4uk9JvqkvEv1LVcELN3A3Ue+szNGZOQChkArveyTVa?=
 =?us-ascii?Q?wi42hojFPI0aEvKpLKPACchBLWIehfRKrDdLRL3KiIbfi5UG8tph0gcj7pO3?=
 =?us-ascii?Q?aEQ/xSadMS5nr5hErUYGvNGSlhWD7iMdKsJDxQiELZoWMR1tuYxmTspW0mGO?=
 =?us-ascii?Q?wo0tERJZLq1y4ptzx95Fh9rOEskiG/224Yj/DBE1PTfgat1vhkc6T9rTUruZ?=
 =?us-ascii?Q?/gSmiva9yZPatgvkDM6jwgoXQaLQbFoYOB0PHQarhM5NSA5rzcziYr+kinbL?=
 =?us-ascii?Q?uh/DvmSWCaIoyjqW1+HTwOhHw/1Nx0wOPu+oA9Mph/I1AD8TX80QyfJ/PHDh?=
 =?us-ascii?Q?J72QU/EDz+XdAPqOMbejp9SFntnNLxY5985q0RyD18N+w7hseNdBQxlRC5O2?=
 =?us-ascii?Q?QXnSXCTraWZB/FEq6cf9Bjh+rRDE9AGuoazoU0O0Km9+Xwuf//WYfQaGJTFL?=
 =?us-ascii?Q?esM+ZUguHC5GJ8OZIoeOXy9vtpGc4VStg1PnktOEKFI1XFG9yvKbMTwehgKT?=
 =?us-ascii?Q?/T0mEZGfhRpDyXPo3whloSfazNhkMAqmtn/W415hmaxlHwGh5yWZBQkv9yev?=
 =?us-ascii?Q?mtKkCEY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(7416011)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3Ig3xs5COkwLbuS0fR6GnSvVZ1vdiwOABZMIyCAe5XwbAu/l/34fy+66+opI?=
 =?us-ascii?Q?VFwJRbh87YFXZ/CAvKeQtqx8AoURGx98Mp8SPcsgVzmHZ3T6qdumPzaFopvl?=
 =?us-ascii?Q?KBzKC5RJcu4XF1xJ4Zfc8LquFjThKfKXCOrm7xdzJN6S5suAdsL24Q23RqI4?=
 =?us-ascii?Q?/6LejG1VqZuYoQqDPhPSMFFGvKilxsPdwtcKX2DbG++0ESWKtn8fa9aUakk+?=
 =?us-ascii?Q?su/GgDHpfcsTDsKjp5hkrGMcIaoTDEbe10zA872H+GdgxoWKopWD102LYiXw?=
 =?us-ascii?Q?RNxVLUdvx2U8NIn+IfgpzJlPZ9vH3hfCB5iZzOfNiVKYZR9VxeYVPZpnoZGm?=
 =?us-ascii?Q?q7FDrngUpdPt8PftriUGQmu7vtWa8/mXH+r+BI7RHAgNxQwnaz+Sic37V4sa?=
 =?us-ascii?Q?reicw4PyFK9I4yyFT+a2E9Dz2GkmdLqpMQFmC7nkX5cpqj1My7mDM/PFFzB0?=
 =?us-ascii?Q?u9rwmBRGUoxyBdJQTxzDU+0LmPMlW/GxShZZ3IX/NFFtIJNWfIQaMF3Tfglu?=
 =?us-ascii?Q?WA+DfO1embY4e9Bx47VEPqXF8V1GfZM618tQd7RAURBpTlLsFIBDvVeIp0sS?=
 =?us-ascii?Q?gq1jl7+5mgm7UH0NTGj55ErrpxPXomHlGP3UMJ6Ks4qSXtB1cNj9Kx8Me617?=
 =?us-ascii?Q?M8wQJao1Vh1Acr/kpNq0ed3vhUBmwK+K6sDdtR6sQVoXJS8kSxbHjo3zIFN/?=
 =?us-ascii?Q?aiaFlzi+mps+j9UH5p92xl4E4bto2ascOHUxoSj720rCJq4umdTOReQeXcP0?=
 =?us-ascii?Q?z1vvV91tJks/Xf1RJKY+eROchcjaAXKYWLIOkuMeqZf029ZCC8IVlOQ4pbhq?=
 =?us-ascii?Q?mcOjK2Mcpou/LtyZIPtspEkVP2sNRVzrmWyYSUa/3b9XAGKfYiIZ+tGRahFM?=
 =?us-ascii?Q?t1a/SRaCVHuVhegvWq24BvOQAtz7xfKdPqZNBG21dtP2TGXVBGkU80+dnusz?=
 =?us-ascii?Q?34UF8iLbPPltm7Lu4egh9QH4uDo1Zk+UR7UAar5896mfCkNFYz1yPAg3qMnT?=
 =?us-ascii?Q?Un53FgkRC23TVrv53zsndk84O2D6M2tOQRj4N0cT1Q5BRjvMkzZpP4AmXzIh?=
 =?us-ascii?Q?sSIYnGI/zARBfbOl6elc+/gnH2VMNzu40EMSc7fb7GXkDI0Nhxors4urKDSs?=
 =?us-ascii?Q?bAAdaui2ZCbu6ORTadRUipMBQj+nxw5jM8h2zZqpA0gUPBtxURb/eBGQFg/h?=
 =?us-ascii?Q?aATnu4ZgLHTKum6bqt4OTH8UKfHsIBAbKNcbo848WLqZoQ6HjHnmjY/TY8hj?=
 =?us-ascii?Q?7W2krDGJssZMuJSoh6W1waT87msblID/voRsOp0itZRfTaeaGiDpd6ZmqlC0?=
 =?us-ascii?Q?2j6nFCnxKOdHQ4XNyYs0JdORYebLyQFVszd17yhNBKsHK4kHqoGaUUA6LZLc?=
 =?us-ascii?Q?tqRlaN2USwSTKHI2zQuFbWBCxKhLDSy1amSTEPP9Zo+cw/VL2os9bBJdsalN?=
 =?us-ascii?Q?7Z0OBW2/Rj32MRlyN8geRu5sFfKObZaTuaEVd9bf2Pjtwy4EMfCJn/m8nsZg?=
 =?us-ascii?Q?V75ms7w5+R4p3OlH4+FYNH1D38wawWF6J+Et9xpW6C4OgE4FOLRkCczRvjkL?=
 =?us-ascii?Q?LcKPSMwVdZrIp+5VcA4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec64edc-e434-4602-0bc2-08dc8f608e0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 06:33:24.2171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/y9kNXImGCvZAmJXN3yacwitX9pkq2cDGpm8fjgOy5jYxKLtqyFoNAKvesIGanPkZjJq6RF0PWx5Tdlqw8GUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7397

> Subject: [PATCH] arm64: dts: imx8mp: Fix pgc_mlmix location
>=20
> The pgc_mlmix shows a power-domain@24, but the reg value is
> IMX8MP_POWER_DOMAIN_MLMIX which is set to 4.
>=20
> The stuff after the @ symbol should match the stuff referenced by 'reg'
> so reorder the pgc_mlmix so it to appear as power-domain@4.
>=20
> Fixes: 834464c8504c ("arm64: dts: imx8mp: add mlmix power
> domain")
> Fixes: 4bedc468b725 ("arm64: dts: imx8mp: Add NPU Node")
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
>=20
Reviewed-by: Peng Fan <peng.fan@nxp.com>

Regards,
Peng.

