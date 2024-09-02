Return-Path: <linux-kernel+bounces-311321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4115E968784
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3AA28395B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A71220125D;
	Mon,  2 Sep 2024 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E5kRGeWZ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A819C573;
	Mon,  2 Sep 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280064; cv=fail; b=AI8k9ha1giEXNh8ktRZUDC5lzaBQGkOo/t53jMqW5RKtB8YlrapbGOGU7btdqRf++56zpYqwxPQw1LcAR8IynmFjo4OHTraH+xPve2GTmCC7pSwk9ROszdgFxrkcDAB+0VPOIpA5obqZCe5BtcYzxD6Uppny7MPveKa6e5GeRwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280064; c=relaxed/simple;
	bh=q4zrm5OdsY+oNRIlPn+Jqu61GzrGIFJ8SZXn6z/U+rY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WqUSl0td2dEfCKBkU5TZHOti+vSn8V5mhGjUjZggSiet15qHefyGNrlGLp+7RnQizK0Pny7Q8AOKF924VvWGsjwfp7Tc1p7DISp9U4/fzHHHklxfKZkRC9oIr0CdYeoE9185vXeeR+H3DaTxBPANKcpnVNMjbHW8iKrF8yyeoAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E5kRGeWZ; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAIHGVLlQOOwzYD1jiTEKIej7pJfWs18Xkb3RnrBvrxW+4cUfItCTPctRv48mxUvq3I7JiWM7FeXvKyKg4xPa620drwPgOtcSt3lUoAGC0MpiMY5wbL1/oirywy4PY9Hf6KppcD8xTHJad+6jarUiS+rkztLH2xaGqgSt5Bjb5x8MgN9Z4nyJOT0wE/vGfO6iSxBe6nLunAvGYA80BDtyuPwGxLRD726wJeOEe0yCGKaaBlOryA54EsvPumHIBtt1k8BiuN1atebXCW1xiQhvTUeI67fRD3JgrmF4PO++NJ+K78IEmN4WrqigxfawLvc8hp5SgRMSQpr6/EyFqMAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4zrm5OdsY+oNRIlPn+Jqu61GzrGIFJ8SZXn6z/U+rY=;
 b=jABZVMwMFe/biaQgSozrGZfklYVEEu1EjU/WtRS6Rva5giWXkUmCW/UV735xPj/g55Ju7VYEGA7Hq+JznCOcrjUtJ+jS7aSjB8xdBruUYLpjqKVXMFWi2YUMWcmD0No3I6fRDrMGvP+MQQdKWkSYzoyTutWV1Nu4IG3kNWtq6FTsgwZwk9Wd1Bvs7fteO8i38qL30VbxouOKrROfJOqa4FGyirjRlF1LqbbMb+OpJlkHCB5rmd+A2uk/Zy8JNjOyVv3JsK+GSziF6oa2qdrwsq0gZ7BaSZapCqciuzGwB/pLmn9BwuLHeFZBIYpGlzn6VLQy+SuQhO/7RxLGZJa+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4zrm5OdsY+oNRIlPn+Jqu61GzrGIFJ8SZXn6z/U+rY=;
 b=E5kRGeWZghAY1IlkxQfjr13M0iHx7V7sDuL7Q0ajf55VZ2f6sP58fCPtRtf/WgT607V+/eBzn8APQWv2b1jWbVm5OfDR4BpMVCevANQLsM+86Myfem7mlJKtW4QprDhL/2fOYbFQfCSzw7EEiJK/S7ApFuk21imoFX895m8Hx0RA19JjMu6txZiWYzCDfVJkc0j+PUSSXgBtAENwkdwz4LIqxz7w96asVnghukcVpOpDD9MuaFxqhUO1hoNW4YEAn/NX1xsrzbTZtDMd700gJFY88HUT++kciIBKltWxaSvBJRsHQ7DxJVM8WHEtygq1u5K6P6sZlLS8fD+T8Gv/Zg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10353.eurprd04.prod.outlook.com (2603:10a6:150:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 12:27:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 12:27:37 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] arm64: dts: imx8mm-var-som: drop unused top-level
 compatible
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mm-var-som: drop unused top-level
 compatible
Thread-Index: AQHa/Q0VmoKrC7xzgUmRx3O0sW6DM7JEbLug
Date: Mon, 2 Sep 2024 12:27:37 +0000
Message-ID:
 <PAXPR04MB8459DA7BD5BC900D4BC1159688922@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240902075220.27971-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240902075220.27971-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB10353:EE_
x-ms-office365-filtering-correlation-id: 0b378505-41e5-44af-3e3e-08dccb4aa18e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DCJIdGIfeX10N6Ax4I+eDi6mM2XJSWSfTapRCml4TldIOnX2t3z8Zfwkj43e?=
 =?us-ascii?Q?Hbctrerbnv30njC3GVFwhfx667dLv8dYn6jJbXeSW4L+j1ULv0m0VzNnSNYh?=
 =?us-ascii?Q?AGYtDaV3pbucH3NgazBxsSV4JdVVKRPzGkvql5hc2nFV7KrldjDdm0trnL7Z?=
 =?us-ascii?Q?MmJu/WMIf9UNuZYsIa4vr0bq37aN6+Tdi35xfs+maF8mAhImGdbWi4dEOe9c?=
 =?us-ascii?Q?0yvKupcRsZCqdJOWVUgfGHuyvYpV5NDwqc/zs7WgpbiKJQwu4y2SFEfQRR+B?=
 =?us-ascii?Q?GHlko2AzIeh4gSToe1QJK/5l5GgosOqVMSsoS3Rr+mxtCG/t3weoy8E1aOS0?=
 =?us-ascii?Q?yCpLLqo3Jz/9jhnMXBQj+pg/1l6iOXuwGgF/iLkVScXv2d9ugawR8z+saCtN?=
 =?us-ascii?Q?xcyi1C8hbhcTQ1gnMmMVX2LhAInEPKPu6mHroRNWgEMMuIjcSB5hLXUvTEB9?=
 =?us-ascii?Q?N7XQBdGMhXgwdA9mo5dapO9p/zK4dNYRNC4dFeVRlCxlF+CBPCLfRs9rSz4l?=
 =?us-ascii?Q?Vd467HkEukrrMAlHGniJXOvkkQ5cgdkoQZ5vgLzu7JVKWeWmmFrLk7XORbZW?=
 =?us-ascii?Q?FJauQaV2wFHFflXX7EZADSdYG9eYiizecGF7Nmem6nJ2hnqNDR1ezpGPnLmS?=
 =?us-ascii?Q?eeMxE8SInPKZVuiQag6dwXNp2QzOZ+P9pdqDHR2ZpMYfzQYgQAwGt36Fl0ti?=
 =?us-ascii?Q?2BDkgr2y7e3V0sFbF2rDhxMfgyj2DsOGKoBAPv9kL0h7XEZtkfZsT8I6pIVr?=
 =?us-ascii?Q?tkMXqfcKV1zCm7StR0c8RGEmsAghxiPgALsdzmB7fIkCFwD4uvHFDRy8uSXU?=
 =?us-ascii?Q?B+gnVbaFjEs1cAOlve9H42h6xJ7JbM5i0E/gvF57mE09ekFsvJR8spMdsqtr?=
 =?us-ascii?Q?RN+89dy/mBtxKW7r11h5sz/9lNnV2EAExtten4XyoNvUsz06gL9xGSphgkwz?=
 =?us-ascii?Q?Io5qvAaJye3CuVXDuvcRcr3qHbds/RY1GHBGlkXHnhuPjpPmjsrz7H0Fylu4?=
 =?us-ascii?Q?dffu2OvkwVkfzb6P8Dx6WVJ0DBpxvwYwkGYSoJI+63pvF3yasRMqhzCj9dXc?=
 =?us-ascii?Q?Fh+VOnSC5xce7A3AknxDNViKhG45Uwpsf/DeBJToGK8sK8M7Ms0ALDJkpmD6?=
 =?us-ascii?Q?FwGtvtcz4fvsWKo2SLPufAU3UtC3Z1mvgm0dRlvt//cnh8CBeOBkbbZfu45I?=
 =?us-ascii?Q?wM29IXo46Sh0hYxFGYok8YSTqfFbgnAFd9XA9rxXOJ3GR50vUDzTZ7oEJARy?=
 =?us-ascii?Q?bXjrXK7lrb3jmJ0zJ0SQwzSCFo5aiT45+77mfZH9TLAVEL9yuAbFzsEH8lEF?=
 =?us-ascii?Q?hIERCvT3EFyVtLuLKkdT8zTBnKxsN22IuScjfvuEPvmQbqyrod6Rpv9xSt99?=
 =?us-ascii?Q?rnIWbpQVqbE0hUalgtAi7ipcL045o+i0vWSRJbqvKAlF6DDNGRCiFHULyUET?=
 =?us-ascii?Q?BOsyUX7ANw4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GVXN3SwI0B8jQtTsc34KOpwznv2evMpAZMbhmKuj+J1OcVC3BUO45eYwY1Iz?=
 =?us-ascii?Q?q+8pXhCUmLyiZiz+QBTs0yfwGKu8/GUW4Wc7bdD+g4x+LxaJeHPm6+j4/fLy?=
 =?us-ascii?Q?ONXinc+E4HFBVpO04iAZrk7pD02uUZGNIkTcU9KuUk5WbKB+kSKp7lUCNB57?=
 =?us-ascii?Q?7OrX8kgHL1CIdWimJOOZBneHYwQ9Q1PUoIAvdbNYVTRU1BgUuR2UTK1sayNl?=
 =?us-ascii?Q?0iKFo1ff04Hi7qjjzgLlFrYICVyTb36d+5Fh3H3IMibadKHVj6KFj95LCSpv?=
 =?us-ascii?Q?ve5LE1m3MTdNw95dW7VGrMPOOhmAkWVMk4eStEWPtQd92+WfpHCskXvvwbnR?=
 =?us-ascii?Q?oHsVjxbyXBIzRr2maaCRdeDx43fAcaNCykJZw11Wk6YH3ck8QFB0aABrVKqp?=
 =?us-ascii?Q?vB8Y/xi3NrdJqfIFhjXQNbzoLPnJ2cLtep9GtzWFwd1yZwR/jQTzGFtNP9oI?=
 =?us-ascii?Q?dGKrOexgrFrND4sXAvWmXNtC/Nn8mzXaxbA1mLr4yy5eIzuOjC7mAx+ahYjx?=
 =?us-ascii?Q?WawVyI8fx2SoOGF14yriSF/zJeUu3nEjl29t/7HoNyD/cZ6H/9WUa3Kv7+lp?=
 =?us-ascii?Q?Yi8X/9JlHmac8UY9R36R8n0dLEA7hDTHj8iSJvYP5A6opOAK+AjkQauqfR5Q?=
 =?us-ascii?Q?oBV2sESheLQqDpqB2Nv9HtWch5e9PPH5wi10QcU3YTDm+euEpGLHOKVUmRrt?=
 =?us-ascii?Q?pihxm9uzfrjqWOh3y8fk+Z6mQsZcQnkHU7SHY347tWztm9ly1cjpiNJ57mWj?=
 =?us-ascii?Q?OWhycBObmhca7enhAs50OopokwfkAoRW3bQznpvsSOFx4Gronf5v6zCsC71+?=
 =?us-ascii?Q?X4nLJMfhPBDNsS3tBJorbuhWpOLAMW2tAjVAib3wZTmU2lYgmW3FEU6tgKHD?=
 =?us-ascii?Q?9GlYFwydIuj851CQ4HeR4OoLIw0rcATKMKDm+zfWPNnNob5qOfd7ezV01hkJ?=
 =?us-ascii?Q?e9a0uUll7RnfxVFxVkeBM8gXc+9VoA8BfZiwAJRucLwIeuDgIK3UlTvNae83?=
 =?us-ascii?Q?NS5VWPR9akKrOK2y8pSvQ9MI5yB6nwdX0dR8b0OwCa0Z9OG/oLUUSDRGeHR/?=
 =?us-ascii?Q?ZFy7Hz/t4T1pwSKO9/IdM0WUWKNgLa+y8/NnqtmTbAlbC0skAAbIaVoB1q3X?=
 =?us-ascii?Q?8l/3FXbDOLJnVxIecU+EoElcbewb48htk0JeNyFRfkzZn0Zg7fH/DfrHgeSF?=
 =?us-ascii?Q?yWwGlkc4ySAgivk9ck2jrSc5e1ANisglLM8lmiZn3x6rHX70HafxDzi23VBA?=
 =?us-ascii?Q?JR9WIWXQocgHT1Gx+AgO/if3rOG5L8r7qP07Zt2lazFhOIWQcfGv5ENXovEZ?=
 =?us-ascii?Q?p1q9YQoW91Mexja9sC9nzBQreYPuikiiEfpTdG+grKSdiSojTgkgy5SX9kSm?=
 =?us-ascii?Q?uE08ghmct6tNeE380sXUKiCOxTSJ5C+Ve4pSKmgtGPAWDof4luWUyJfU0voA?=
 =?us-ascii?Q?jLuiip5ugqEre1A1KExhpj66ad3N6QIqlxBAyBHX/DAbGPVdmIkpzyUgTe4J?=
 =?us-ascii?Q?3RV2d/MxlDRn6MBEX1eH17euJflTBYNyPn0ILGjj3hzl4jgezhpKz91H1TlQ?=
 =?us-ascii?Q?Juclit5cgcOwOc/o2NM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b378505-41e5-44af-3e3e-08dccb4aa18e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 12:27:37.7955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hlstsrry6y9PyUyLjQE+a2IFm/sC2r1MdLYrOzR8RwqEPNt9CQ0hLR/pq2SycL8+P/bCj0JvqDwK1j5UfOcGNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10353

> Subject: [PATCH 1/2] arm64: dts: imx8mm-var-som: drop unused top-
> level compatible
>=20
> The Variscite VAR-SOM-MX8MM System-on-Module cannot be used
> alone without motherboard, so drop the top-level compatible field to
> avoid any false impression that such usage is possible.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
I got a mistake in my previous comment, so

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Thanks,
Peng.

