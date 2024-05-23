Return-Path: <linux-kernel+bounces-187472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB048CD24B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E54E1F218E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402A11487F0;
	Thu, 23 May 2024 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jd4EfRRU"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C4E13BAD5;
	Thu, 23 May 2024 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467464; cv=fail; b=QEcu1hpekwKd18Juww4FkJpst7ia30nAC06/XXu3GNqK9d7l53bFl2Nt86QHn+Q3phydaQOCbp9RKoWv3JN7/4PvOZKaUsB1uGkC09KeF9wZZo7Shi9JXPtaI6r2AXZhgxfN5velMvqanQUVVrN7mD2wzRXtVInn6xkBkxdkRjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467464; c=relaxed/simple;
	bh=k1fh+pRxP1lRUc3PmAAU27wqu9cU17dyXMgAO0fyx/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PiAFcKkz5AHc4uDXvxdtC0GnnsCRpeuLx4ttGu/8pVEJwjs6kXvs1/wYh/8vzm8VFV27dT5EWQCn6qXqGT6EiTqFxKyC2xqUB5KQ9M8c2uiLddzbFDl+mBc9ycdgaqbldlqBhBES9bDf1fVvIS6dXx2SbJ5U5Gen50U0aiHopSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jd4EfRRU; arc=fail smtp.client-ip=40.107.247.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbQMl8ogVJqZvT5mnw6GaS6oplDsSj8mEQC0ESMSLnGxDRWYgHOUrwvy0ip1espbvbVLAMPigttZOVA920PP6HJn6pnbZEIMOSiQGQuLOIeuHAhqd9EH0jr7DnyMgIzaBwApe/Wb65cGln5gg1h+ChHyuGpjhEuPDT13j6Ke5wbJw+W3ZG962Qke8uCGLqVta6yPwqhy4O99YeSMEPvvbg0Zl5kkjAh8rsLw03g7DIIEA6PoWjk9Ve4wHq6g5Y9Vlqng9cKDhQaiTv5uF50s+myYqhC9/170J4UbU71kZEDnWkVsV/cF9C3sK2fTY+7nejrR7MqkyanTMG3bNS53Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WhhBEG9+XEVsMS8zJpTanS63MRD1KudmLKoScDpNoA=;
 b=IyKDG9V664XiAMCuL/zJrdizQrIPQ9VzHQG/lMK0BtLbnX4sWnnPdE3X2yaRwK4Z0NWNb21ICmXXOykovv4czLbVH9QoDkfFzQaDSspD5weQHzmOuiNT+RnTV4Vl0PyCOTFkg/LQEpBDyfhTHDo0lkRaJR6rFOXp8sdKPPoOu+Y88rf5SmrfccUtlPQKiLthg3g7U0LO3ji4beabVWEKhUj+//ibm3kfnp7TTlmTiKOHDlmfWyCgLWAMvBD/FroPY5IXevODuiKaQ9Ik5493byaIEz4ofwae1k1SUj5gIgSZIS+8rJVrD/TjVU9Qek18VqIx2k8ouaVyhchwrjhlkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WhhBEG9+XEVsMS8zJpTanS63MRD1KudmLKoScDpNoA=;
 b=Jd4EfRRUNevT8/MVybN1XDT1b/5Fcy405mlS9urbdoZQvkt0kfm1ZgHZsqtkD2vwwo1Nj2fsuqBKgi7ljqhkQu0s8Cle57EwZ4g4RMSLd3EJ9IDsdoQA3uaVJ64NaoVYCpqe1cTBubosNoBnpnhzeqpp6NmipcLoUJL0kH5THCM=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by VI0PR04MB11069.eurprd04.prod.outlook.com (2603:10a6:800:266::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 12:30:59 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 12:30:59 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Pengutronix Kernel Team
	<kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v2 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHarP9S3VQaTkhgFEm8Z/1nPFfSbrGkvpeAgAAA2TA=
Date: Thu, 23 May 2024 12:30:59 +0000
Message-ID:
 <AM9PR04MB86042A999B5A346B011FD97595F42@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-2-5a6fd189a539@nxp.com>
 <171646712724.2026308.5404698488082776575.robh@kernel.org>
In-Reply-To: <171646712724.2026308.5404698488082776575.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|VI0PR04MB11069:EE_
x-ms-office365-filtering-correlation-id: 6faff1aa-b2c6-4540-12ee-08dc7b243364
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Xcwcv9RWDCMuC78S0dT7MvGDEptxjaX8V2oMQMUxT8qk4Jfx9AHLSuSscylQ?=
 =?us-ascii?Q?kmZIIfPoaVYNo4889/BZN21aE95/1LA9soqBlvB5ojjVMjrbDDR/x0vi23u8?=
 =?us-ascii?Q?XAa88CiK6XRJOmwUnt7C95HeBMLrZcguXMXnhEICXXmWEi7jeptc6naFb7Bw?=
 =?us-ascii?Q?5m6eG0Q8NhjRWkps7Wv6VAJ3S3vqt13xDGyjpTcr79ZONJCX+GYRTKYIdm/8?=
 =?us-ascii?Q?fDZ/GxsW/8UtwGkd1JOV9SVdvSuqdBvbRehDoH/tWZl14Jk6xhv23yKfd/lu?=
 =?us-ascii?Q?uvqYM2kVh8TcQpnevBBa7lmx+diDbprg5JZmY8q7/P+v9R2PSLYvNHKgINy4?=
 =?us-ascii?Q?cLiiU/JwH8S2wSb9S/eBg1Z7eu7rAXBMBMIfE4OxliAYsenoA6JIJdzBhSQR?=
 =?us-ascii?Q?j7F5+F+PDC1nlXVOh5wsZq9xOR/TCFGovZneNl0/jDV7zHrLkEy5lnGjijAi?=
 =?us-ascii?Q?AcR3TVP5PLzpy7g/XhHenZRjDG2/5/xLFY1oxXXEx0wdSv0yu0NJneowi6CX?=
 =?us-ascii?Q?SoUdyfQOuQaTTAv4vp2a7Wk1u5iMmK8qKevwEGpikB48NLutNGLBS77C2tVw?=
 =?us-ascii?Q?V4L5QgfiZXx2KdXf0lhQWf9jbeLTtdoNsAXqeDxG2SdQveFdJkUyDkLeN5/D?=
 =?us-ascii?Q?mrtpZ4nhJtzJ20HdUfVI07zEOCbfZwUbnY/0YP6lV5g5jEJTCR5SOAezNS0i?=
 =?us-ascii?Q?BD2Y8BWWhSP0KxmmOUA91FKCYk8KOaAfTLEDH80xwagAiWY/02CP9gvyKDjG?=
 =?us-ascii?Q?4zACyLxi3SJ/+C0cm96TfE8BxuGktY+zjN9h04d+81YgPsfwQ+XJMQBtqUsU?=
 =?us-ascii?Q?mPDGCtzGg2/jvbolFrsOIZGiJLPsSG6dlfXO8wPTahAj7rGsWDJPJ8KimG6y?=
 =?us-ascii?Q?JQh1j78eAoRqtJLxzkqV4lOhm+rUbPiiiViNKIigNnscIzYyR4ARCg/vntbO?=
 =?us-ascii?Q?Mm9upsWbbnbx3920wleIcsMrmkvCOZ9mAbW0dJ0P81Xb7eIviX+sVeyq7xNz?=
 =?us-ascii?Q?uEchgJfs+VK8QqODsaK2v5GJuuJmc4X2dSad8AV3VepO72FOWjS3a7py6oO0?=
 =?us-ascii?Q?ODUgF6Pr1dtZuIJ1FBYqWAkqlDUNmP7kNviRdF81QBnDPo7PJPW0K7VCSV3D?=
 =?us-ascii?Q?WC0Pg5G/zkDFEfgNvrCpbhZ34xwIB0PtC+wAjpIInd2velqChv+eh52qDiLK?=
 =?us-ascii?Q?aswIyG+FgZBefBTvv5H/kvppcZRh9AAf/0kzL6LzDf63br4mE8kpeHYoirgX?=
 =?us-ascii?Q?58VmyzhbIBIWgg6tnCorNn3UvtKtJOJzy9ZzoDLFIITof2MlfIBxYsyeijq6?=
 =?us-ascii?Q?t1WN9KntSGlqu1HZnRexfRBSYmbcDBeSfCKWS1VUuw+wzQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bM+STiQXbGEXbBH6uqor/nIvaeQqGvez/fxzOJFhZY5A37eZwo2PFnIZmq0b?=
 =?us-ascii?Q?aba7z9kMGIj5v97CanS/CHjCTY+6m8PPgVasG2DGuEdLJfs+1WWkgTgiiBF7?=
 =?us-ascii?Q?g5GF4RxLlHpbxfSJJcq8Gt5l6iZdxu1pqglWt25/OFB966ymsYMCQnM6FD04?=
 =?us-ascii?Q?ygXJ6n3U8ghQzKenYX11w9nviy1oNr4SCgbLm5UdRP1pjfWbZvJ18UdapgWy?=
 =?us-ascii?Q?ZXEhk5dZ3fqKNW/K7gUstrBxByN0xyZab5+jkCg4o/R8XBtlIraxUSjJAnSj?=
 =?us-ascii?Q?HYtLhuYs4fb9RlfrLiOl8S7Lk5S1yWylHxgDqxnfUo5QmyyCu57Z28CLWNxF?=
 =?us-ascii?Q?i0PdpUfGFJkYoVUGgtPk3fkSuEWRbSFOPjsy8IInfcalNgCdmSuMD4SZpNZ5?=
 =?us-ascii?Q?/LDjGjmHDFexSGUasTZXkBYYwJa8F0DKVSJYHMMMpu3fUN72QgmabdOOloPr?=
 =?us-ascii?Q?utJTxO37yFgiF3W2/V9wmOWPN3fV18wa6XGfqdOByfoYdTT/8ybhOGjlujbA?=
 =?us-ascii?Q?/6ONnj8TKMH4wcQk6M4OctF1eACZuDTePHFjLkmZkWtvRzi3PM5HAIz0yvhv?=
 =?us-ascii?Q?OQucFVMCOnHTG7aDXaT+q2CaRoFfwVTEnNC0OUaJHvBpmX2NwfuzF3xlVreD?=
 =?us-ascii?Q?FUqRyx3iQiSrCPIo8fdYr2BuAHv4Y6YgohPwmbtxP4xIbrJGlEPb4bGRJJjS?=
 =?us-ascii?Q?EM1Q9Hdt/ZeNFyUsAOvU/UlKT79TvacxrN1L1epCET6DPYoDTHMDnvmFSai8?=
 =?us-ascii?Q?pw9jEkNRujx+AFGX/0MRPG2aSAllYtGdCfTKGG8sp0Uy7U0A/RAz4qQSRJLA?=
 =?us-ascii?Q?qvh5Ohy37cmc6Tvdi9IbJBxA1JCW6k7N4NRYdIZD0QnDVAvCDtJhPhCWlVQv?=
 =?us-ascii?Q?JawuBm+suF3cdepzfVrviX8RIucm1Iwqau3s0w9d7oT2luANrkqidGcJqTCQ?=
 =?us-ascii?Q?k1ec2GHIve0OhVtHX8hdjxxhiLr1Zdf66I7eQVUEDy7KIPdNEm9o2OnvgaRo?=
 =?us-ascii?Q?AXxm34yRirvlwGWwTfA09ddcnFIemNxSOZiasQocpQfQUyDvXSIwVF9C4FK6?=
 =?us-ascii?Q?KeRNODYS6NleveLPHzBSiFqwmcrOqkdnHXY4zHDZfoGIJR8PxOlBFqRxg4P7?=
 =?us-ascii?Q?ORj9zdOUhDLxCHNEH3bzCcOdgpcF+m308Iv8vwVMhi6NGOmDdsIrtX3Zroz5?=
 =?us-ascii?Q?n12oyeYHV5c4KFeW6e3OMHqJT+gdqs7GaU4uGuTihhLhFSUzIiPGcz2y/HP8?=
 =?us-ascii?Q?PYvc1UacFpgrLyu/Nzj0SBB75wAIyWWBO5ReoRvKxhZX4aybBghes6m0Mbx4?=
 =?us-ascii?Q?yU5O15Cleaca0a+GOrVbZptwvU1IjKE6Qn1gQhfAXNLEv5h1zQiC1GbVDwL1?=
 =?us-ascii?Q?wgNSCaub/dJGmZkTUGnmO/x/rBRT1uzcNX7TOby1+m/8fytoapuMwuc6llPk?=
 =?us-ascii?Q?1iudA1QBPkjpLNwA29vOjXkzcTCa2oIDRZ71XdaDEPG4aGmcqavY+lvKx2jE?=
 =?us-ascii?Q?Ltb/raWxRZt/tk72Cu7tt54IN87w7+kpk8I/19+VR/s/j4k3cBqvscFku+xC?=
 =?us-ascii?Q?6QDQ8yiwt3vgRD7UsgZpN/CNPBFO0bM7NqYcGR3e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6faff1aa-b2c6-4540-12ee-08dc7b243364
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 12:30:59.0475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7neWHGEzMM1VQnBlAZAenXdJjWoDR0himAGBscsnBUPnIaDZ3dfPT+WA8hn1ioU3SH5Kz5UmfMr6P8LhEOc9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11069



> -----Original Message-----
> From: Rob Herring (Arm) <robh@kernel.org>
> Sent: Thursday, May 23, 2024 5:55 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: linux-doc@vger.kernel.org; Jonathan Corbet <corbet@lwn.net>; Krzyszto=
f
> Kozlowski <krzk+dt@kernel.org>; imx@lists.linux.dev; Shawn Guo
> <shawnguo@kernel.org>; Fabio Estevam <festevam@gmail.com>; linux-
> kernel@vger.kernel.org; Sascha Hauer <s.hauer@pengutronix.de>; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; Rob Herring
> <robh+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Pengutronix Kernel Team
> <kernel@pengutronix.de>
> Subject: [EXT] Re: [PATCH v2 2/5] dt-bindings: arm: fsl: add imx-se-fw bi=
nding
> doc
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Thu, 23 May 2024 16:19:33 +0530, Pankaj Gupta wrote:
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
> >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 154
> +++++++++++++++++++++
> >  1 file changed, 154 insertions(+)
> >
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/firmware/fsl,imx-se.example.dtb:
> /example-2/firmware/v2x-if@0: failed to match any schema with compatible:
> ['fsl,imx95-v2x']
> Documentation/devicetree/bindings/firmware/fsl,imx-se.example.dtb:
> /example-2/firmware/v2x-if@1: failed to match any schema with compatible:
> ['fsl,imx95-v2x']
> Documentation/devicetree/bindings/firmware/fsl,imx-se.example.dtb:
> /example-2/firmware/v2x-if@2: failed to match any schema with compatible:
> ['fsl,imx95-v2x']
>=20
> doc reference errors (make refcheckdocs):
>=20
> See
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
w
> ork.ozlabs.org%2Fproject%2Fdevicetree-bindings%2Fpatch%2F20240523-
> imx-se-if-v2-2-
> 5a6fd189a539%40nxp.com&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7
> C102225d4215b49f9e1e308dc7b2370cd%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C638520639343681926%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C0%7C%7C%7C&sdata=3DBO%2FhtixA%2ByKfjN2UZdas2VzEj9Aoq1I%2F%
> 2FH7m5pLAqPc%3D&reserved=3D0
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade

I have updated this. But still not able to see the above error.

But, I know why it coming. Following change will fix it.

In the compatible properties:
+  compatible:
+    enum:
+      - fsl,imx8ulp-ele
+      - fsl,imx93-ele
-      - fsl,imx95-ele
+      - fsl,imx95-v2x


Will correct in v3.
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your
> schema.


