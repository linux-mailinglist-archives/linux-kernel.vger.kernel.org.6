Return-Path: <linux-kernel+bounces-219097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E81790C9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4161F23DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084B7156F49;
	Tue, 18 Jun 2024 10:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kpRSahQr"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2064.outbound.protection.outlook.com [40.107.247.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3792E13A248;
	Tue, 18 Jun 2024 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708334; cv=fail; b=J2SDEQA3vtZgmPUrzY0paAX1X4JjyYOZNPRwubu1dNXHqpygQv4NsD/3iWGuTiKjuekyJ/EqNr8cmkNxUMK8DgbSYTHUC13rBRoQb98UtaNrahbgw15eVL5BReeg0pAeW0a5N083sXLNyh8Cff2zdfwJI4CzI+GSpgY7xAtKHNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708334; c=relaxed/simple;
	bh=K9hCNcAKQp1V4eTUEHYNgLJhfTNFuMU8wUsvyidzUyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tMbK6GbJX7HxeRYn48pKvxlNcNZqIxriY9CtlLyPi6UtaHM9H8u6OxJiZfPlgslF/W7n/Kwd/7sTz7/O4P1SPZAZbRRNvflj3I/XhNzK3JqhcJzBRpsFGlhKDl7sHN2SBpgRIaFrikHrlFdZNAF9rPfS6SaieYkW9QoAvrg2/ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kpRSahQr; arc=fail smtp.client-ip=40.107.247.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARwTHTItws/cmQUTeJAxJeAD5iCdWZORRtDcclMj0GfHlAlPChzFPW1TCYGPKPYfiil4pWko1RFxwii/CK0hN+ezJR3kSyjRkTOsev39womMlg0Sho7HTl/0GlhJ/vxdYX+NADueSCvEA1Qj2MnVfMH5w6BJVuvk3mE/s2rS0u289klBAGq5dACnvOc3bLLb39LjkwLeqMR/8ARtez77UO60Z3BchaPxfVfUX7IxFrnHiHfgh1cfcY5hcNJVStbrfjPCG38++eEPVltTCaRenPrv9D+dYTSwk0adCccHh/O4N+9QSe52CISdGSBTQpI18i+QZkQhAchQ0Exb+IQVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fcqrqGbBWOc7wjP06itMY70lsFNodV9r/T828zxF0k=;
 b=G+UR4VQkqv+KOqALpjLEsGQmaLxMxjkYemdHYDNW8PbzNV/GiduV404GaVs8MSY7M23WpFg7/uygYvUeu9udJ+wuJOaiqJPaAIB3jGE3LOe7G1dREtLfiKTQ4L9JJmD1jeX/ij8Wm4f3IR1WQAnBURWUq8hNPbdiAyPnGjT9YcyICREk46KUBtMe4M2GLWHZRWofxzJgQ9bEMbis5vE5BwKkoM3ODs5zixzyF5wxDVRxO42mqWmxr0KOpPdpHTffSitUFKtSBaVljvUK/2P2K0mQ0Y7RD+wDat+fi1jnzQO0RbUtKp7/WO0tEmMMI8VH10HvtouBRlyhtbs1S1Ij6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fcqrqGbBWOc7wjP06itMY70lsFNodV9r/T828zxF0k=;
 b=kpRSahQrcHFN+iPC3BRxlp/E8k5rJcc6cJjKiq84OVxAqxtFOdhx35Ow64xjOomMmZImCrbYQYjGCEQT9kHyo8b4t6RjpPtlHlWcj7OICInzo6VfUGDKU3R0dsuV4n154KRfX91X0wQbQH136mvOlkjnCqNqDRdyTTSZQ5T88Dk=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by VI0PR04MB10975.eurprd04.prod.outlook.com (2603:10a6:800:26b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 10:58:48 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 10:58:48 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHawIiTY2uwWBJroU+O1Zn+P7i2k7HMKCYAgADPmgA=
Date: Tue, 18 Jun 2024 10:58:47 +0000
Message-ID:
 <AM9PR04MB86049915593D86599C67975F95CE2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-2-a7d28dea5c4a@nxp.com>
 <20240617-control-calamari-317f59c4eb09@spud>
In-Reply-To: <20240617-control-calamari-317f59c4eb09@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|VI0PR04MB10975:EE_
x-ms-office365-filtering-correlation-id: fdda19ae-1dae-451e-99bb-08dc8f85a158
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?njF4pStnw2EWBKZTsvTTg7wflZu55B2aGVb0BuAJ8aXVgzY4c6lW944bmc6q?=
 =?us-ascii?Q?me2nPMtPMRnuAq2Pmv08iJiY178lPeC/mWyZT7dL3Wf8vsTRkuhKABp84ViB?=
 =?us-ascii?Q?HcWK+INrlsDuO7HAhmIH4DvAYGhABBzW8hxH5cc0Tfd/ge6+kq4QdaihQKVn?=
 =?us-ascii?Q?h/N/Vz70LCVbT9XvBirrpFZ2PCaVIspf5qrcW+TGZyRqGZzGAhVgZd3zOVCZ?=
 =?us-ascii?Q?+vtcSw9IBXhEQ4CgmpAlwh0QDsnZmFd6gAZwzPfXZM9nB5Ix60+SCAEqV3dF?=
 =?us-ascii?Q?jiOgbyK35c1v0ho9XrX2xNS75GtsG778bqBV/cqeIg8t7rFjiFj/ZdrxkkNi?=
 =?us-ascii?Q?RW6QTEsfL0uLaO6fCzb/92PmM9JOk38hmXYBUQnnqBCaM+dH69gOcrE/Mks+?=
 =?us-ascii?Q?CBnopZP79MF/9yvNcUoFkoTsjPwct/zLQ3eLl+nqvpzRlXabvK+4BAu+0hRz?=
 =?us-ascii?Q?kBXYeCvwmAYDMAr7jBSyCfe8RdQKs2HPCpf/O1qU+FicSezQeCl+VJOWYi0I?=
 =?us-ascii?Q?mxCw4nLHddLlm67+DmVqpxKl7OP83mxhpFuBJWG/5RT/hV8SNnWTyEmL9tS1?=
 =?us-ascii?Q?bP7wF1P+awg9cBL08wSF1uQlQz4QMxruTuDneOVbWkr1WxsYyCsp7DX1X6+Z?=
 =?us-ascii?Q?qihCRj5ass7p5Wmel13u+5FFNNGyVdPMjj36qP9rXSsI7kR2nOKshN3Ip/yQ?=
 =?us-ascii?Q?DpKijRgnsYQzfceg/CeMCWdAOw9EFtHPiaX7YKf0/eqaugWtc6Jw7K6wMadm?=
 =?us-ascii?Q?2P3KyAaUbik/3nQi4Lx9R4xmkmEyYeGqp/Bhbfj+8bs+EZn7/xvhTnRvrEHY?=
 =?us-ascii?Q?3ls+FRXtLp7fHv//fi4UAuktesYSBLWv1ZDgv0feZrwz/7HufyGvg9YzSbwp?=
 =?us-ascii?Q?GbxBe1/zHpzBN1nT9G2BCE5fC/FgDK+w1HUBgjndKvaR5fL3kiPZynCEkN7a?=
 =?us-ascii?Q?/tWmsxzxq/Gqoa5FcwX69fqPAEKui2joASR3hJ534FrKJ7/szFOVAW89a05S?=
 =?us-ascii?Q?qoRSiMHFE0vGU4XPRoqx9qVrx8+M+m+XX3/u00+cB5Wcs38LPQoFTy4DXMLE?=
 =?us-ascii?Q?ui/ikfNGCXCWuU55AqTXHuBZf/BVZfXz9JumH2faEkdLljm88yVwWovCa9M5?=
 =?us-ascii?Q?VcTFV+u8UyEj1ZOppt1xjGz0o65DicqIfGkoVClfV19sO2GtX96SsKNrHO60?=
 =?us-ascii?Q?sjF+UnI18+a+v2z1E2pmZV0iXM6rn10pvpvvYmkVyYay5i0aQiXW0cXPAsmo?=
 =?us-ascii?Q?5wtHomSx3FWBZO3CLEIRTy1XwEOS6oGYxJqDTnM1PRGH6uYaWawjVmOvGv7h?=
 =?us-ascii?Q?YPNoTo9YX8YlETlU1rO7yCw7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3obMRv+pk6YgpwC1eW6nYIArMk/bDXHIGtGqJA2n5hT7MY5jDHCYQmgAiMhP?=
 =?us-ascii?Q?Izuf95Yz0G+cKncL2mdS0N08rPdltObD1rF+Hz1N/HoaMgLmQyiuMAYiHG0Z?=
 =?us-ascii?Q?4MyirzAGNacwbOGv9r4w8Lk8+R3egjGvK1/+Jy1lxFvC0QHaaf+/JHfK9NCL?=
 =?us-ascii?Q?lj8sKu/Jwd5TT/zVIxHqQYXxWpmn5sAixZLfrv7Gmxtzk1kdkH2yUSgdhuGy?=
 =?us-ascii?Q?JbPUrhRP8mubyRBtcoslCqXmYEbgu60U67c5/UZL3UdSXqDF94VFDnhDKkvw?=
 =?us-ascii?Q?eIwFT2FkzH9dA8a1vIP7enR8F9LQWA34Q7EWODn6adpMWJgy7CnBWOT6UE9A?=
 =?us-ascii?Q?9YFRk5giwHMf0yXM1J2XC5Dv15ad+HtmCX4xycRWu3YUy+RBH9DuhV2nSiCn?=
 =?us-ascii?Q?HlBDdlGMI2WPAmAjH8rwHw5wk01w5GgldHNfI9dMqsU/r0hq3l2kW+4U5Wl5?=
 =?us-ascii?Q?874oNJr3xurGWqc1jtwLNawui77QAIYcHvPUw7U8l4ZRXZCP2rL9LbO0ClVV?=
 =?us-ascii?Q?7/CXFz6WSsBz7IPWEeNlf5vEee9butyhRW/j/wHADlmlO/hY/yAHhVRvamJU?=
 =?us-ascii?Q?2ZqBs90VizXjoucZUPdw9AuKkKLRvkL7gY5KudpV+HXNxgPSEZCA/7Pl4ENS?=
 =?us-ascii?Q?K370YEnGKbongkoMLmozBv1KXEPSa5aKPXjOY0lTJLNidKK8N5aAWP9i4L+n?=
 =?us-ascii?Q?TbOGNyRxFUC85gCCI/vgFoW/ndcjGI9mmg4cNV4neuJoLWYBlCKyxgpgjZKW?=
 =?us-ascii?Q?CofyKOByj1lbV9tgEX0sCnMRzSmXuTvPHTA4fYFDj6FW+nl5RnvrilV3uWg/?=
 =?us-ascii?Q?bkUjHSRUxGjUw/Ozj5+RBGczeGEB2fB+7YnL8kOO9y2pCoCN/Oubg4FPNEQq?=
 =?us-ascii?Q?XE5P/+Pz9P0vFpuMP8MMxC7OOKLVW/5Ggwd4dhYEr71YERMc4XMdB1YuEmnH?=
 =?us-ascii?Q?1KEqXLXEeKbzZVumCi5NJPOU+YOZXOci2aPpeglIi09AUSrBNZEYcGVtd6hx?=
 =?us-ascii?Q?yrJu9Jt2hG72BQ3F/8rRVymo1e6QwL9TDAIRJTYSPd3caXFNo4hZ3SX80Ftv?=
 =?us-ascii?Q?+TqwXf9nE4S7qNX+xONzWBfoKj/dd3KhPuzZRQLw3534o9//Kv4xxIVRy9hb?=
 =?us-ascii?Q?68r7DjYcznd8z0CFow1WRwcn8Y2jgo3i6UcGS0y+XIF7pxndSup7ish4B/SS?=
 =?us-ascii?Q?Ps3mP9gF8hELfNj7CUF1j/1jfYFpUzm5HHj8HgVKwLHGZ3eWocESy6RSgD3x?=
 =?us-ascii?Q?+xq8DxKw7p2RuPCo5OimuFpnth1KIDI7xnrfdz0ndOta230JlUWdk10N7vWN?=
 =?us-ascii?Q?6qTK0ay1f796UKkcW17WPXjW7AqFp/dELyXTO5FybAfqKNlhRJG4hbyFcUcL?=
 =?us-ascii?Q?Pq0GlyGthiSpBZzACM6KrUuVFbRG64tzogWsNP/rV8j4C3PH9pOhbaM5nPmD?=
 =?us-ascii?Q?du+6zBBQiuE+aBh+67CNuISzP5JlCAGjGmLZbLppKUU9H2PJBi3OBXbc3JIw?=
 =?us-ascii?Q?LY5TVbgmEx3hPIcnsHdUSgfFQgfm2MwGVJTpeSZZ/xbCrWTsOsSH4YLilUsa?=
 =?us-ascii?Q?NYUIB/aOKQzp/IQXihl/HqVwAniUwR57DyGmni2X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fdda19ae-1dae-451e-99bb-08dc8f85a158
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 10:58:47.9623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJ6DiGhKYPgXV8qdn2oyiIQmNMXtQxgreursgmlurKqhSMqBfe1CymtjbysM77lbkTV2nmYqmBIeT8KRd1xKDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10975



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Monday, June 17, 2024 10:07 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-fw bi=
nding
> doc
>=20
> On Mon, Jun 17, 2024 at 12:59:40PM +0530, Pankaj Gupta wrote:
> > The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
> > creates an embedded secure enclave within the SoC boundary to enable
> > features like:
> > - HSM
> > - SHE
> > - V2X
> >
> > Secure-Enclave(s) communication interface are typically via message
> > unit, i.e., based on mailbox linux kernel driver. This driver enables
> > communication ensuring well defined message sequence protocol between
> > Application Core and enclave's firmware.
> >
> > Driver configures multiple misc-device on the MU, for multiple
> > user-space applications, to be able to communicate over single MU.
> >
> > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 160
> +++++++++++++++++++++
> >  1 file changed, 160 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > new file mode 100644
> > index 000000000000..60ad1c4a3dfa
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > @@ -0,0 +1,160 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> > +
> > +maintainers:
> > +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> > +
> > +description: |
> > +  NXP's SoC may contain one or multiple embedded secure-enclave HW
> > +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> > +  enables features like
> > +    - Hardware Security Module (HSM),
> > +    - Security Hardware Extension (SHE), and
> > +    - Vehicular to Anything (V2X)
> > +
> > +  Communication interface to the secure-enclaves is based on the
> > + messaging unit(s).
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
>=20
> Just "firmware@<hex>" please.
>=20

Modified as per your suggestion,=20
-    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
+    pattern: "^[0-9a-z]*-if@<hex>"

encountering the following error:
/home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,imx=
-se.example.dtb: ele-if@0: $nodename:0: 'ele-if@0' does not match '^[0-9a-z=
]*-if@<hex>'
	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
/home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,imx=
-se.example.dtb: v2x-if@3: $nodename:0: 'v2x-if@3' does not match '^[0-9a-z=
]*-if@<hex>'
	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
/home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,imx=
-se.example.dtb: v2x-if@4: $nodename:0: 'v2x-if@4' does not match '^[0-9a-z=
]*-if@<hex>'
	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
/home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,imx=
-se.example.dtb: v2x-if@5: $nodename:0: 'v2x-if@5' does not match '^[0-9a-z=
]*-if@<hex>'
	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#

Please help and guide to resolve this comment, correctly.
Highly appreciated. Thanks.

> > +
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8ulp-se
> > +      - fsl,imx93-se
> > +      - fsl,imx95-se
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: Identifier of the communication interface to secure-e=
nclave.
> > +
> > +  mboxes:
> > +    description: contain a list of phandles to mailboxes.
> > +    items:
> > +      - description: Specify the mailbox used to send message to se fi=
rmware
> > +      - description: Specify the mailbox used to receive message from
> > + se firmware
> > +
> > +  mbox-names:
> > +    items:
> > +      - const: tx
> > +      - const: rx
> > +      - const: txdb
> > +      - const: rxdb
> > +    minItems: 2
> > +
> > +  memory-region:
> > +    description: contains a list of phandles to reserved external memo=
ry.
> > +    items:
> > +      - description: It is used by secure-enclave firmware. It is an o=
ptional
> > +          property based on compatible and identifier to communication
> interface.
> > +          (see bindings/reserved-memory/reserved-memory.txt)
> > +
> > +  sram:
> > +    description: contains a list of phandles to sram.
>=20
> There's only 1 phandle allowed, don't describe it as a list.
> Same for memory-region.

Accepted. Will do the following changes.
   memory-region:
-    description: contains a list of phandles to reserved external memory.
+    description: contains the phandle to reserved external memory.

   sram:
-    description: contains a list of phandles to sram.
-    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: contains the phandle to sram.
     items:
>=20
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      - description: Phandle to the device SRAM. It is an optional pro=
perty
> > +          based on compatible and identifier to communication interfac=
e.
> > +
> > +allOf:
> > +  # memory-region
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8ulp-se
> > +              - fsl,imx93-se
> > +    then:
> > +      required:
> > +        - memory-region
>=20
> > +    else:
> > +      not:
> > +        required:
> > +          - memory-region
>=20
> Use
>=20
> else: properties: memory-region: false
>=20
> Same for sram.=20
Accepted will be corrected in V4.
# memory-region
-      not:
-        required:
-          - memory-region
+      properties:
+        memory-region: false
=20
   # sram
     else:
-      not:
-        required:
-          - sram
+      properties:
+        sram: false


> Sort the allOf after required.
Accepted. Will move allOf after "additionalProperties:"

>=20
> > +
> > +  # sram
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8ulp-se
> > +    then:
> > +      required:
> > +        - sram
> > +    else:
> > +      not:
> > +        required:
> > +          - sram
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - mboxes
> > +  - mbox-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    firmware {
>=20
> You've made up these firmware "buses" here, what purpose do they serve,
> other than allowing you to have a reg property?
True.
Additionally, these are firmware nodes, these nodes are semantically put in=
 firmware "buses".

>=20
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      ele-if@0 {
> > +        compatible =3D "fsl,imx8ulp-se";
> > +        reg =3D <0x0>;
>=20
> What does the reg property even do? Is it ever more than 0?=20
> Can this information be provided as a mbox cell?
Yes, there are more than 0 nodes for i.MX95 platforms, i.e., total of aroun=
d 7 such nodes.
Reg property will help to identify the node id, by other kernel management =
layer like NVMEM (patches to follow).

>=20
> > +        mboxes =3D <&s4muap 0 0>, <&s4muap 1 0>;
> > +        mbox-names =3D "tx", "rx";
> > +        sram =3D <&sram0>;
> > +        memory-region =3D <&ele_reserved>;
> > +      };
> > +    };
> > +  - |
> > +    firmware {
>=20
> These examples are all basically the same, drop all but one.
Ok, will keep the example of i.MX95.

>=20
> Thanks,
> Conor.
>=20
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      ele-if@0 {
> > +        compatible =3D "fsl,imx93-se";
> > +        reg =3D <0x0>;
> > +        mboxes =3D <&s4muap 0 0>, <&s4muap 1 0>;
> > +        mbox-names =3D "tx", "rx";
> > +        memory-region =3D <&ele_reserved>;
> > +      };
> > +    };
> > +  - |
> > +    firmware {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      ele-if@0 {
> > +        compatible =3D "fsl,imx95-se";
> > +        reg =3D <0x0>;
> > +        mboxes =3D <&ele_mu0 0 0>, <&ele_mu0 1 0>;
> > +        mbox-names =3D "tx", "rx";
> > +      };
> > +      v2x-if@3 {
> > +        compatible =3D "fsl,imx95-se";
> > +        reg =3D <0x3>;
> > +        mboxes =3D <&v2x_mu 0 0>, <&v2x_mu 1 0>;
> > +        mbox-names =3D "tx", "rx";
> > +      };
> > +      v2x-if@4 {
> > +        compatible =3D "fsl,imx95-se";
> > +        reg =3D <0x4>;
> > +        mboxes =3D <&v2x_mu6 0 0>, <&v2x_mu6 1 0>;
> > +        mbox-names =3D "tx", "rx";
> > +      };
> > +      v2x-if@5 {
> > +        compatible =3D "fsl,imx95-se";
> > +        reg =3D <0x5>;
> > +        mboxes =3D <&v2x_mu7 0 0>, <&v2x_mu7 1 0>;
> > +        mbox-names =3D "tx", "rx";
> > +      };
> > +    };
> > +...
> >
> > --
> > 2.34.1
> >

