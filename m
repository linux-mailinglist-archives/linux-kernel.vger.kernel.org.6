Return-Path: <linux-kernel+bounces-259838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F15939E02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE91EB22D00
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E7C14A636;
	Tue, 23 Jul 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DLxchlRr"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D614D43D;
	Tue, 23 Jul 2024 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727377; cv=fail; b=c81tdfWa0egXrw/LrArWXxHvkUVnMpoNvMXj7FszdQwDvb2RYHjV3GLbFvex4XW5rThF4cp1pvQuidWOfzzeZAPCzVwfnDvZA2KjLYxkpETh1OSbvUAArv0v+efmPHjTma7Jafs/hFPnloj3PLX5zONlpmW0YUGfgrMVD0C73Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727377; c=relaxed/simple;
	bh=IVpIPbIDCG6BKq/6LEJ8+wenMNqZTCMWiF8kQ+EUzrY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MnL/gPia3zYa8IS73Cj5K9Hl/UCaLerO35O4ct8AZG6PCkS1xdYq0UCVfj0T69Fi2EwK4pcJUwyrUhkTQJmUw3+YAIGYW/aSj5x/mnyd+bnVOiVsRprsTmHUcJXfciH8ySEGUoxLVeYOQsNHNwTUdZbwRgw9xT/xthA+pJ4W1xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DLxchlRr; arc=fail smtp.client-ip=40.107.22.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwH2hgqzjA6kNr2oFBf3dIMIy91929mRXZlkZwohosfIG1mZu67rb/ycAkXm7/9xlJk7wn9J6LitDQCkADZu8GmCOawyWWxbJTrvF7nJ5sDixd6vLQHgTx9VyIh+wO2mJgmu6ogjdzJOV7Q68pR7D8cswQl29nMhvbXBwE1kzIWEfIgZ7fUMhQr9XRAWnAZUFTFb/lvGVpIQogpIST2u9DXa+5AVALGIhIG6W/O0iBAoOVgs3Ixq58BkyDXiBHegUTmutBIF1k6/Qq6ZH0+7W6dujBG8V2KEY0xP2J6H7T+YaoHt+Rn0jBgYEdAHpYxi1IEAvKsqU0c0WlKd/xPvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaoZIc7R2+BAeLtJpBAVjrJSAQhmEoVb7Eq1jCXYGRI=;
 b=Kg1D1edUdGtG1fNdvxV5oDZbiF5MH2Xia+B2PdcDuGnOmt+GAp1OpV+GzST6xg7Sb9IzMZ/HF4FNFpGCif2WcZoTxRLQMNJR62oaiNK+gEkR4tOy6NAPaEcnxymY6XPhaLj8ndn5goPDEcZ+uY/uCUSAsCEV7qoBgdFmNaeNXjtsHbdCJTLN4dy8e3NrSfw2UKPl6ZQdmAX3Uz/+fSpXffIgH7k0S8cstwBRmyf9z3Gig15D98br37zQxeqm12hWhl9c+T7zo494riUNLUH3PbXGXH4D+MYCamr3A/JPauwOJNb22ZQdZY2SZJsL2Bn4shguaDPW/Wf5b7/wceoFjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaoZIc7R2+BAeLtJpBAVjrJSAQhmEoVb7Eq1jCXYGRI=;
 b=DLxchlRr1L3vRv09t59AuXKdVhaY37pICY6zp+raMK8f0R6VlpjzdD08ENGh6L2fkHPG34GoYhSO/h4jR50t0jCMAetlHuJtc09dK/u88vTiam70m/JSumqcd8XhSF3fsga3Z3tBXaiaSMXDWn1Ta9myADRG5wrqg8CuZQO44qk=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DU0PR04MB9227.eurprd04.prod.outlook.com (2603:10a6:10:352::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 09:36:10 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 09:36:10 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Amit Singh Tomar <amitsinght@marvell.com>, Jonathan Corbet
	<corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Herring <robh+dt@kernel.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [EXTERNAL] [PATCH v6 5/5] firmware: imx: adds miscdev
Thread-Topic: [EXT] Re: [EXTERNAL] [PATCH v6 5/5] firmware: imx: adds miscdev
Thread-Index: AQHa2/NcuiznhUStfE6qn0+OVrPkAbICnyyAgAFuxZA=
Date: Tue, 23 Jul 2024 09:36:10 +0000
Message-ID:
 <AM9PR04MB86047F2B9B1C758C21B0490295A92@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-5-ee26a87b824a@nxp.com>
 <35f28f0b-1014-4058-a073-96464a278a0a@marvell.com>
In-Reply-To: <35f28f0b-1014-4058-a073-96464a278a0a@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|DU0PR04MB9227:EE_
x-ms-office365-filtering-correlation-id: 35b1f510-0ecf-47b7-58aa-08dcaafae300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SW18piJXhrsj2xDMXTwxxqAI07++XAqWE54cAerLceotlUvp0bJvfZlVg3vx?=
 =?us-ascii?Q?tCZ+VV274VQde7vf7kgBpp/8EKiDH35K7xcvtXdrslewS09z3qYJxZkYnjU9?=
 =?us-ascii?Q?su+lIZT1VAsgiZxpONe3rtm+Sk+h1cy73EUHyD8HX4sWRYaxLjzS/gYi6j97?=
 =?us-ascii?Q?ZEBNyE0PVdBoQ7fIdChqzFH4nTh2whtliFJlszwQ9j7qU0a1oeplRt5/nEnV?=
 =?us-ascii?Q?YNgiqvaaVMUc+uUhGdJt0y4n+p35jjJWGCqujBhtDgf7MoGS/JBBVkHhYXnS?=
 =?us-ascii?Q?ZMR71f58zcaBbIMItfwBiyVEFEnMoapnFQjkE1tBGHl9xZ377nqFRK0nmZVc?=
 =?us-ascii?Q?RdxI634CTqfa4tC12PFCs5ryNPTu5C34z1iPAEvBDQ2BSjyLL9F7bQh9IC3D?=
 =?us-ascii?Q?86TMjLCMBOE40Lf7h6+rHJxAPwdnNwQsT5KNkk+dIypqv1ifiaQplTNsQJcn?=
 =?us-ascii?Q?PY5BPZIo1U6Ps2nQLt5dB5JnatOK6Oi0EZa0Nc1F27AZn+FgVvsej3mEKRQ6?=
 =?us-ascii?Q?/b0LSWmgXPT0YlRWTiFXCXo4kHagaoAkPemJ8JqaqCTHR4WjvJSWFVNNdU9A?=
 =?us-ascii?Q?TXqT4MHCL8Ot1VfEO5bDzmJXUE0dW2Gpegc2iHfVK1TJbSMyjATuWKGiqS2O?=
 =?us-ascii?Q?fz+hpRvK1I3AXkmAStpP+GxojMpAoTP/EdcFDa4vS9HwIarE+Y4Y4oq9X81D?=
 =?us-ascii?Q?ao16SgVYsMyS6QThu9EQrliuzGahO2hpRPL0iz7jYjrQu7YrGmq6KiViGi6V?=
 =?us-ascii?Q?UHVjI/p+HThRnmaSs+35IsljIUc72bJsWwn+KAYXsiQop/fQSD8xoPS0piUG?=
 =?us-ascii?Q?dTbHhWIrwqI4go9SxADwPfpTzPOe2N+BwtnTewBm20pFMEYPndrgs+w9+2VO?=
 =?us-ascii?Q?q+uiYtlPPUKzNcdgVUGL8rsmQ3nK/zcaRIEznSYX/l1VXGzjMjAIvqD0p6PU?=
 =?us-ascii?Q?Yseou1Zlmxp+oJN9RS/gh89m0VhoJjIzOvXZNEFxC/rXxSLiebg/GGPFtusV?=
 =?us-ascii?Q?haBeP0jovEoTYXbmGq2RqDApOrtEBih51vEvFntbAh99ycbm44HEXT/2bvBe?=
 =?us-ascii?Q?4BVi6KQCdrrRuIiAaWhRNPQswnhFLJ/qTBbdqKD3RoY39Rl1x+EJd8+kMe44?=
 =?us-ascii?Q?uM056dBW0zGnOJ0edCX9wbmlkOmWvAZ0EQ6/aCeJldn62oQKI0KkZK3eTQny?=
 =?us-ascii?Q?rJD/UH9zftK6XVc7YBSZhAJSzePg4WsSVr5D4wQ5rbrAvPy4o7dWX+rV/ena?=
 =?us-ascii?Q?pAPa8s4OM8X6zbtuwhSyGbu8bUZMqEnBa6lMts7BReMFjBdRvkbxyGseQWLJ?=
 =?us-ascii?Q?iHv/HWAovPuUb34el5TSn84gF8Etmbs27vhncG3mu45Szw1zTAQSdRFU/3/d?=
 =?us-ascii?Q?F/5AJf785QR6LEXWjhzRJmUOGt6P?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?msdum79+UZJ37Ke2D9x41l63sg+ULuE/UFpASMQjIG17mlAD7Qerr0AcP8LN?=
 =?us-ascii?Q?463SmQhXdWUSw97ddt1MKPMR/Ool9o8W0hjjf+qYyABLgcnG98lcwz2dvsEN?=
 =?us-ascii?Q?jE4wciWJTnRsMPMnLiHQyvRhLTIoxakQrpSYGCnPjH5FnT69rI5ZB22oUrrC?=
 =?us-ascii?Q?GbAhFwGnvt+nUJ8SzFOsZFLJU91gBLLJdG+/Ku9FviytouXc2YSk1Fpvt0l0?=
 =?us-ascii?Q?NLwPfo/MzmneJKs+DJhN2T+vOEp90QK/s+jpD5u2oBO/H4TrDsPHok3fc3JO?=
 =?us-ascii?Q?Na69EPNisq+vglSS6sofJzjH57E75CRxZYSG+tu5fFVDWkMUnqauIsYvD+dh?=
 =?us-ascii?Q?2j6M5uzRHnBfly0KeNOfFG+Js8/MPsSOVCQZzmZok9ltKd/8w+5R1V0Ppm+M?=
 =?us-ascii?Q?Bcjkeeg9FUcYKui/ZrkA34ldW2lEC/JSpFjoGCCFqNsZv1cnlwAa2wFp+hXy?=
 =?us-ascii?Q?FnjPDK4yzzmzj6JyhZWV0rZ5zI9E8CjIYde3PCc0WHE/MlSWRis5USRiduIo?=
 =?us-ascii?Q?e1CHkvAQtCXJ7F1nYU87oQ5AxLcmB4kZW8rKA4uZq6Oau1xLHt5GxQFOsDy7?=
 =?us-ascii?Q?MO8NuxI4wKAL8FbO9LUEJ9r48ttcAXOuPruufD0AJy+yS+zSCSyOkEXDB4sX?=
 =?us-ascii?Q?LG57KWTglUGmF+g+hx4lmTlKjktAx1wAuSKXu9lpAzjcD/k3yWVAneJtdamD?=
 =?us-ascii?Q?fOc9PVRgK56wFiotK27wd3I04JbqZopO1s2OHdxWw3SQquxRgVRxaFMzQbnj?=
 =?us-ascii?Q?8bdFy02sd+7bp3cY5Ee46FeHrsX0GwGsPAT70WZUPkXdB9wpmnpHyBV3M0+n?=
 =?us-ascii?Q?E9rjh7pOXUXpjvAaO4kf2Om2L2MTup/tA5d1m88L5eEEtIk5GCLQbxSNn5T1?=
 =?us-ascii?Q?N+cY/7H8ejH19dSenCipKtaFscBsTOW8F8O9I5ooIiyimZTWUs9z8Kvejh5z?=
 =?us-ascii?Q?Qigm/mNYyjmDXQrE8g62KHdcjj/jcPxxDRsIrYVTDqknerAiuhxeEky/kg5M?=
 =?us-ascii?Q?pSZiJ8XxD8z7sRyE/4QQHSkj4C/hcCu/g8Ab3xrEHf0tu64xteG90tUYjKgU?=
 =?us-ascii?Q?yW941W704cguwUmXntkgaHFKo0rVeP6VBHewyD2IpF4O5Hy+15qzp6YrJGgZ?=
 =?us-ascii?Q?XqZ3eqPWs5QyWCJxa9JpqhTwyh50FuTFgfZ0U2RIZNNdKyApsFix890bvmw7?=
 =?us-ascii?Q?mXHx0fI68yWO4tcpIk205lRj23UKva43U504TU7Bm60nO04H5sm/S0VNxJcS?=
 =?us-ascii?Q?MqPW7303H/meuEsWMQRcTCHYe5z/glbXs2GyjOTa2tc3mcndHURBRquEB5Wp?=
 =?us-ascii?Q?BUD2Ox0CfNTjngGtsaWJPJgdYbn2gJ/P3U/llGeVkDm6dHqA/aUrja1xypZS?=
 =?us-ascii?Q?BjRQoOY5Tsu/k0WwMStH6cvrZYy01rPbrpsGjM4jXa2X96GreUJbfEKIunmO?=
 =?us-ascii?Q?EnTcjETDoWejKmi3aA6PZ3nqV2OwdAzltiGH0gocCnTa23TYHWDxT1YfCGI6?=
 =?us-ascii?Q?0qrjjmpfi+ZTKulQUdBoQlkhxU0gbTX4Wy++JyGWJpufpzA2GJfMiCYI/naG?=
 =?us-ascii?Q?49elHmsw17tuzFx3EDpL7PT0Z9xFBcmcr80g5lzw?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b1f510-0ecf-47b7-58aa-08dcaafae300
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 09:36:10.6404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBf2k8qcLArqSMjbNoNSfY8RE7Q0t/lN98Dc/WsG8XSIPPxtQitxDavLa6dBzXmq05IKRBMCVou4kZ7KttfsSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9227



> -----Original Message-----
> From: Amit Singh Tomar <amitsinght@marvell.com>
> Sent: Monday, July 22, 2024 5:08 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>; Jonathan Corbet
> <corbet@lwn.net>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>
> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org
> Subject: [EXT] Re: [EXTERNAL] [PATCH v6 5/5] firmware: imx: adds miscdev
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hi Pankaj,
> >
> > Adds the driver for communication interface to secure-enclave, for
> > exchanging messages with NXP secure enclave HW IP(s) like EdgeLock
> > Enclave from:
> > - User-Space Applications via character driver.
> >
> > ABI documentation for the NXP secure-enclave driver.
> >
> > User-space library using this driver:
> > - i.MX Secure Enclave library:
> >     --
> >
> URL:https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > urldefense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> 3A__github.com_nxp-2D
> > imx_imx-2Dsecure-
> 2Denclave.git%26d%3DDwICaQ%26c%3DnKjWec2b6R0mOyPaz7xt
> > fQ%26r%3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3Dhqz6ztDhob0
> > jujItfaaf7PHhtqSHj4aoWie1-b4nAGXTUrSyBQtV9W-
> WqLaM_utz%26s%3DC67hc24yMA
> >
> TzUglvGvywzpn0Efjurb6sOLm2V_9VpsI%26e%3D&data=3D05%7C02%7Cpanka
> j.gupta%4
> >
> 0nxp.com%7C5acd31c1cfc14661861c08dcaa42c232%7C686ea1d3bc2b4c6f
> a92cd99c
> >
> 5c301635%7C0%7C0%7C638572450920546605%7CUnknown%7CTWFpbG
> Zsb3d8eyJWIjoi
> >
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> %7C%7C%7
> >
> C&sdata=3DcV67vBSDb5uPaABT8RDTmtNOtqePRAALqo7QuUaV4QQ%3D&rese
> rved=3D0
> > <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fur=
l
> > defense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> 3A__github.com_nxp-2Dimx
> > _imx-2Dsecure-
> 2Denclave.git%26d%3DDwICaQ%26c%3DnKjWec2b6R0mOyPaz7xtfQ%
> > 26r%3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3Dhqz6ztDhob0juj
> > Itfaaf7PHhtqSHj4aoWie1-b4nAGXTUrSyBQtV9W-
> WqLaM_utz%26s%3DC67hc24yMATzU
> >
> glvGvywzpn0Efjurb6sOLm2V_9VpsI%26e%3D&data=3D05%7C02%7Cpankaj.gu
> pta%40nx
> >
> p.com%7C5acd31c1cfc14661861c08dcaa42c232%7C686ea1d3bc2b4c6fa92
> cd99c5c3
> >
> 01635%7C0%7C0%7C638572450920558539%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4
> >
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C
> %7C%7C&s
> >
> data=3DyrSEmLSlxZrIZG%2Bk4J%2BbDyvzdEams5ux%2F8nKhQBLq74%3D&rese
> rved=3D0>,
> > - i.MX Secure Middle-Ware:
> >     --
> >
> URL:https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > urldefense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> 3A__github.com_nxp-2D
> > imx_imx-
> 2Dsmw.git%26d%3DDwICaQ%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%3D
> V_GK
> > 7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3Dhqz6ztDhob0jujItfaaf7PHh
> > tqSHj4aoWie1-b4nAGXTUrSyBQtV9W-
> WqLaM_utz%26s%3DNACAFfnEzGKFI7FlqdL4kxl
> >
> t8PtxeXRorc3IWanqgtY%26e%3D&data=3D05%7C02%7Cpankaj.gupta%40nxp.
> com%7C5a
> >
> cd31c1cfc14661861c08dcaa42c232%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%
> >
> 7C0%7C638572450920566218%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> C4wLjAwMDAiL
> >
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdat
> a=3DvuTve
> > lCrdOFlGPGGpwpx0YgA6So%2BRIPJQRSzOjfo2LM%3D&reserved=3D0
> > <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fur=
l
> > defense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> 3A__github.com_nxp-2Dimx
> > _imx-
> 2Dsmw.git%26d%3DDwICaQ%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%3D
> V_GK7jR
> > uCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3Dhqz6ztDhob0jujItfaaf7PHhtqS
> > Hj4aoWie1-b4nAGXTUrSyBQtV9W-
> WqLaM_utz%26s%3DNACAFfnEzGKFI7FlqdL4kxlt8P
> >
> txeXRorc3IWanqgtY%26e%3D&data=3D05%7C02%7Cpankaj.gupta%40nxp.co
> m%7C5acd3
> >
> 1c1cfc14661861c08dcaa42c232%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0
> > %7C638572450920572062%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQ
> >
> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DE
> DDL3DFE
> > erSUqrBRGQchaAsN3L0H2nkkRw4AsoNBMqA%3D&reserved=3D0>
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >    Documentation/ABI/testing/se-cdev |  43 +++
> >    drivers/firmware/imx/ele_common.c | 192 ++++++++++-
> >    drivers/firmware/imx/ele_common.h |   4 +
> >    drivers/firmware/imx/se_ctrl.c    | 677
> ++++++++++++++++++++++++++++++++++++++
> >    drivers/firmware/imx/se_ctrl.h    |  46 +++
> >    include/uapi/linux/se_ioctl.h     |  94 ++++++
> >    6 files changed, 1053 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/se-cdev
> > b/Documentation/ABI/testing/se-cdev
> > new file mode 100644
> > index 000000000000..3451c909ccc4
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/se-cdev
> > @@ -0,0 +1,43 @@
> > +What:                /dev/<se>_mu[0-9]+_ch[0-9]+
> > +Date:                May 2024
> > +KernelVersion:       6.8
> > +Contact:     linux-imx@nxp.com, pankaj.gupta@nxp.com
> > +Description:
> > +             NXP offers multiple hardware IP(s) for secure enclaves li=
ke EdgeLock-
> > +             Enclave(ELE), SECO. The character device file descriptors
> > +             /dev/<se>_mu*_ch* are the interface between userspace NXP=
's
> secure-
> > +             enclave shared library and the kernel driver.
> > +
> > +             The ioctl(2)-based ABI is defined and documented in
> > +             [include]<linux/firmware/imx/ele_mu_ioctl.h>.
> > +             ioctl(s) are used primarily for:
> > +                     - shared memory management
> > +                     - allocation of I/O buffers
> > +                     - getting mu info
> > +                     - setting a dev-ctx as receiver to receive all th=
e commands from
> FW
> > +                     - getting SoC info
> > +                     - send command and receive command response
> > +
> > +             The following file operations are supported:
> > +
> > +             open(2)
> > +               Currently the only useful flags are O_RDWR.
> > +
> > +             read(2)
> > +               Every read() from the opened character device context i=
s waiting on
> > +               wait_event_interruptible, that gets set by the register=
ed mailbox
> callback
> > +               function, indicating a message received from the firmwa=
re on
> message-
> > +               unit.
> > +
> > +             write(2)
> > +               Every write() to the opened character device context ne=
eds to
> acquire
> > +               mailbox_lock before sending message on to the message u=
nit.
> > +
> > +             close(2)
> > +               Stops and frees up the I/O contexts that were associate=
d
> > +               with the file descriptor.
> > +
> > +Users:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furlde=
f
> ense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
> 2Dimx_imx-2Dsecure-
> 2Denclave.git%26d%3DDwICaQ%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%
> 3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3Dhqz6ztDhob0jujItfaaf7PHhtqSHj4aoWie1-
> b4nAGXTUrSyBQtV9W-
> WqLaM_utz%26s%3DC67hc24yMATzUglvGvywzpn0Efjurb6sOLm2V_9VpsI%
> 26e%3D&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C5acd31c1cfc146
> 61861c08dcaa42c232%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C638572450920577297%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C
> %7C%7C&sdata=3DFvSTP3MVF%2BSghK36fmJ8u%2FySJ80DP7VQjNYAytj9gws
> %3D&reserved=3D0
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furld
> efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
> 2Dimx_imx-2Dsecure-
> 2Denclave.git%26d%3DDwICaQ%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%
> 3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3Dhqz6ztDhob0jujItfaaf7PHhtqSHj4aoWie1-
> b4nAGXTUrSyBQtV9W-
> WqLaM_utz%26s%3DC67hc24yMATzUglvGvywzpn0Efjurb6sOLm2V_9VpsI%
> 26e%3D&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C5acd31c1cfc146
> 61861c08dcaa42c232%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C638572450920582198%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C
> %7C%7C&sdata=3D%2Fb342eydDBBpn451JY9h36udCBWaJmzMbMOQcJHWI%
> 2BQ%3D&reserved=3D0>,
> > +
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furlde=
f
> ense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
> 2Dimx_imx-
> 2Dsmw.git%26d%3DDwICaQ%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%3D
> V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3Dhqz6ztDhob0jujItfaaf7PHhtqSHj4aoWie1-
> b4nAGXTUrSyBQtV9W-
> WqLaM_utz%26s%3DNACAFfnEzGKFI7FlqdL4kxlt8PtxeXRorc3IWanqgtY%26e
> %3D&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C5acd31c1cfc146618
> 61c08dcaa42c232%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> C638572450920586967%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C
> %7C&sdata=3DsXtVRno2qOn6aGvIr2HpJrB0WbhexELpRMNQE8JPUxY%3D&res
> erved=3D0
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furld
> efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
> 2Dimx_imx-
> 2Dsmw.git%26d%3DDwICaQ%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%3D
> V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3Dhqz6ztDhob0jujItfaaf7PHhtqSHj4aoWie1-
> b4nAGXTUrSyBQtV9W-
> WqLaM_utz%26s%3DNACAFfnEzGKFI7FlqdL4kxlt8PtxeXRorc3IWanqgtY%26e
> %3D&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C5acd31c1cfc146618
> 61c08dcaa42c232%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> C638572450920591699%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C
> %7C&sdata=3DXVI6X7w5FBckyuDIklwBvWTvYQ69GJPvR%2FnIvgyWulU%3D&r
> eserved=3D0>
> > +             crypto/skcipher,
> > +             drivers/nvmem/imx-ocotp-ele.c
> > diff --git a/drivers/firmware/imx/ele_common.c
> > b/drivers/firmware/imx/ele_common.c
> > index 3a6584d6f6f2..8167ae201b83 100644
> > --- a/drivers/firmware/imx/ele_common.c
> > +++ b/drivers/firmware/imx/ele_common.c
> > @@ -78,6 +78,149 @@ int ele_msg_send_rcv(struct se_if_priv *priv, void
> *tx_msg, void *rx_msg)
> >       return err;
> >    }
> >
> > +int ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx,
> > +                     void *rx_buf,
> > +                     int rx_buf_sz)
> > +{
> > +     struct se_msg_hdr *header;
> > +     int err;
> > +
> > +     err =3D wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hd=
r !=3D 0);
> > +     if (err) {
> > +             dev_err(dev_ctx->dev,
> > +                     "%s: Err[0x%x]:Interrupted by signal.\n",
> > +                     dev_ctx->miscdev.name, err);
> > +             goto exit;
> > +     }
> > +
> > +     header =3D (struct se_msg_hdr *) dev_ctx->temp_resp;
> > +
> > +     if (header->tag =3D=3D dev_ctx->priv->rsp_tag) {
> > +             if (dev_ctx->priv->waiting_rsp_dev && dev_ctx->priv-
> >waiting_rsp_dev !=3D dev_ctx) {
> > +                     dev_warn(dev_ctx->dev,
> > +                     "Dev-ctx waiting for response mismatch (%s !=3D %=
s).\n",
> > +                     dev_ctx->miscdev.name, dev_ctx->priv->waiting_rsp=
_dev-
> >miscdev.name);
> > +                     err =3D -EPERM;
> > +                     goto exit;
> > +             }
> > +     }
> > +
> > +     dev_dbg(dev_ctx->dev,
> > +             "%s: %s %s\n",
> > +             dev_ctx->miscdev.name,
> > +             __func__,
> > +             "message received, start transmit to user");
> > +
> > +     /*
> > +      * Check that the size passed as argument is larger than
> > +      * the one carried in the message.
> > +      *
> > +      * In case of US-command/response, the dev_ctx->temp_resp_size
> > +      * is set before sending the command.
> > +      *
> > +      * In case of NVM Slave-command/response, the dev_ctx-
> >temp_resp_size
> > +      * is set after receing the message from mailbox.
> > +      */
> > +     if (dev_ctx->temp_resp_size > rx_buf_sz) {
> > +             dev_err(dev_ctx->dev,
> > +                     "%s: User buffer too small (%d < %d)\n",
> > +                     dev_ctx->miscdev.name,
> > +                     rx_buf_sz, dev_ctx->temp_resp_size);
> > +              dev_ctx->temp_resp_size =3D rx_buf_sz;
> > +     }
> > +
> > +     /* We may need to copy the output data to user before
> > +      * delivering the completion message.
> > +      */
> > +     err =3D se_dev_ctx_cpy_out_data(dev_ctx, true);
> > +     if (err < 0)
> > +             goto exit;
> > +
> > +     /* Copy data from the buffer */
> > +     print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> > +                          dev_ctx->temp_resp, dev_ctx->temp_resp_size,=
 false);
> > +     if (copy_to_user(rx_buf, dev_ctx->temp_resp, dev_ctx-
> >temp_resp_size)) {
> > +             dev_err(dev_ctx->dev,
> > +                     "%s: Failed to copy to user\n",
> > +                     dev_ctx->miscdev.name);
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     }
> > +
> > +     err =3D dev_ctx->temp_resp_size;
> > +exit:
> > +     if (err < 0)
> > +             se_dev_ctx_cpy_out_data(dev_ctx, false);
> > +
> > +     /* free memory allocated on the shared buffers. */
> > +     dev_ctx->secure_mem.pos =3D 0;
> > +     dev_ctx->non_secure_mem.pos =3D 0;
> > +
> > +     dev_ctx->pending_hdr =3D 0;
> > +     se_dev_ctx_shared_mem_cleanup(dev_ctx);
> > +
> > +     return err;
> > +}
> > +
> > +int ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> > +                      void *tx_msg, int tx_msg_sz) {
> > +     struct se_if_priv *priv =3D dev_ctx->priv;
> > +     struct se_msg_hdr *header;
> > +     u32 size_to_send;
> > +     int err;
> > +
> > +     header =3D (struct se_msg_hdr *) tx_msg;
> > +
> > +     /*
> > +      * Check that the size passed as argument matches the size
> > +      * carried in the message.
> > +      */
> > +     size_to_send =3D header->size << 2;
> > +
> > +     if (size_to_send !=3D tx_msg_sz) {
> > +             err =3D -EINVAL;
> > +             dev_err(priv->dev,
> > +                     "%s: User buf hdr(0x%x) sz mismatced with input-s=
z
> (%d !=3D %d).\n",
> > +                     dev_ctx->miscdev.name, *(u32 *)header, size_to_se=
nd,
> tx_msg_sz);
> > +             goto exit;
> > +     }
> > +
> > +     /* Check the message is valid according to tags */
> > +     if (header->tag =3D=3D priv->rsp_tag) {
> > +             /* Check the device context can send the command */
> > +             if (dev_ctx !=3D priv->cmd_receiver_dev) {
> > +                     dev_err(priv->dev,
> > +                             "%s: Channel not configured to send resp =
to FW.",
> > +                             dev_ctx->miscdev.name);
> > +                     err =3D -EPERM;
> > +                     goto exit;
> > +             }
> > +     } else if (header->tag =3D=3D priv->cmd_tag) {
> > +             if (priv->waiting_rsp_dev !=3D dev_ctx) {
> > +                     dev_err(priv->dev,
> > +                             "%s: Channel not configured to send cmd t=
o FW.",
> > +                             dev_ctx->miscdev.name);
> > +                     err =3D -EPERM;
> > +                     goto exit;
> > +             }
> > +             lockdep_assert_held(&priv->se_if_cmd_lock);
> > +     } else {
> > +             dev_err(priv->dev,
> > +                     "%s: The message does not have a valid TAG\n",
> > +                     dev_ctx->miscdev.name);
> > +             err =3D -EINVAL;
> > +             goto exit;
> > +     }
> > +     err =3D ele_msg_send(priv, tx_msg);
> > +     if (err < 0)
> > +             goto exit;
> > +
> > +     err =3D size_to_send;
> > +exit:
> > +     return err;
> > +}
> > +
> >    static bool exception_for_size(struct se_if_priv *priv,
> >                               struct se_msg_hdr *header)
> >    {
> > @@ -99,6 +242,7 @@ static bool exception_for_size(struct se_if_priv *pr=
iv,
> >    void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
> >    {
> >       struct device *dev =3D mbox_cl->dev;
> > +     struct se_if_device_ctx *dev_ctx;
> >       struct se_if_priv *priv;
> >       struct se_msg_hdr *header;
> >       u32 rx_msg_sz;
> > @@ -114,8 +258,50 @@ void se_if_rx_callback(struct mbox_client
> *mbox_cl, void *msg)
> >       header =3D msg;
> >       rx_msg_sz =3D header->size << 2;
> >
> > -     if (header->tag =3D=3D priv->rsp_tag) {
> > -             if (!priv->waiting_rsp_dev) {
> > +     /* Incoming command: wake up the receiver if any. */
> > +     if (header->tag =3D=3D priv->cmd_tag) {
> > +             dev_dbg(dev, "Selecting cmd receiver\n");
> > +             dev_ctx =3D priv->cmd_receiver_dev;
> > +             /* Pre-allocated buffer of MAX_NVM_MSG_LEN
> > +              * as the NVM command are initiated by FW.
> > +              * Size is revealed as part of this call function.
> > +              */
> > +             if (rx_msg_sz > MAX_NVM_MSG_LEN) {
> > +                     dev_err(dev,
> > +                             "%s: Msg recvd hdr(0x%x) with greater[%d]=
 than allocated
> buf-sz.\n",
> > +                             dev_ctx->miscdev.name,
> > +                             *(u32 *) header,
> > +                             rx_msg_sz);
> > +             } else
> > +                     memcpy(dev_ctx->temp_resp, msg, rx_msg_sz);
>=20
> It is categorically stated (in the Linux kernel coding style guide) that =
this rule
> does not apply if only one branch of a conditional statement consists of =
a
> single statement. In such cases, you should categorically use braces for =
both
> branches of the conditional statement:
>=20
> if (condition) {
>          do_this();
>          do_that();
> } else {
>          otherwise();
> }

Checkpatch.pl donot throw either warning or error, for this.

Adding the braces to else, do not throw error or warning, either.

Thus, will add this change.=20

>=20
> Also, made a similar comment on the earlier version (v5) as well:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch
> work.kernel.org%2Fproject%2Fimx%2Fpatch%2F20240712-imx-se-if-v5-4-
> 66a79903a872%40nxp.com%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.c
> om%7C5acd31c1cfc14661861c08dcaa42c232%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C638572450920596406%7CUnknown%7CTWF
> pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DnnkWdELMd%2BaYqAcqFoeTaSOib
> VnSoMBegxXsn8PMePc%3D&reserved=3D0
>=20
> Thanks
> -Amit
>=20


