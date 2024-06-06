Return-Path: <linux-kernel+bounces-203503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FCC8FDC31
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC2B2855D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C261429B;
	Thu,  6 Jun 2024 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U5ECbzRJ"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9740710F7;
	Thu,  6 Jun 2024 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717637760; cv=fail; b=qY0YmpfUVitgml0Txx4OVgVJsbU4xfMLXcQPlBPQkJk/pyThF+4yUxV48vfBtBXo80yTqoxEaH3U8xhR6hgFkLGi9WcKGWVvoPXNJVmG0k9xo10o7/rfZCVc61DMDty5ADeulnE8CdPGMytZq8oaDryQiKOXa/p4mBM66FoS7I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717637760; c=relaxed/simple;
	bh=IniGDAlgyf0Q1J1B8cQA0gJ+7Jyxe1j7yNwHUT3rULo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=trYrQin3GTKFLVGJOPCrnsl0HdJEhgzGBsm4HGo6Ql/Bfos8zaE5Cyyyi0l1Y7CJNk21Dfx0B6XC0T8RPhH1yuzWoZjIpke4EAuV5NWlR3wkbhLdXZ2YbIl2AUvLlYSdPLWmrdzeAX+rEOTOVTJ95xbmOaJLFFZMmeAmgQNLCVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=U5ECbzRJ; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwggS6UOD9unqliZT+sKIBVYj2454JHWljGkgTeMxWL2AlRZg+PHcriyQPERbFy15ezL9xxMhIrhVcjoRxRACCx+6xKKYEUBG27XhcfpJar7aXw83Ba2R4TL1myVg74cSOD4HkCaFSPonTbjnRIsuG12e7BmLPgkkVaiKqC9iRgENdjSZepAH6HhdjeA14bfH6PVEsErFDYtRUuAm9yXQFO0All1dqXnW21ZjQiMw9H9G0gJZIa/GUpPVUIKdPlz0MtiBelFws37cBzYrScNi1c5AtSFB/IfZQ1+8Ae5Z46/+IwmtMoiKQwqPdfRQD35hAYMWd37xSXK+oBJBepZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdSUjbhlpcV7jis86g1gc49oUdfxXCebzDsrSOGHRxc=;
 b=VnsSGnPLW8G3HgKAMxd/0xBsbN9iE5thDqDIAnhZMUSWl82LFwGscoem/WM5ioDud2cDjHzpDh4pKBCXbFR3z9C9xT7gdSGnMYYM4lMl9ol4CbLUgeHVB3m3QA5FGyDEJvGjPEJI+M/aRXXU6WaYh1gGOlqN0Cj+Ry+7B4xJIW9GbYgkT24gXn8FTfd5DQrxTZ24e0mdYsBDcEMPLakRz7Jt+QmGzlfeg3wK7pZZKQ8e0es8ZyyCiKL4YsfvZSgJmsYVoVLs78qVJrx4bPiB/GKGtVrEE3dLN9nEPqQXotdUedUQijIxqR+GX8XXKTPl6DH2vVPlQtujYVNRQOVq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdSUjbhlpcV7jis86g1gc49oUdfxXCebzDsrSOGHRxc=;
 b=U5ECbzRJA1uukwlcL+JcNcOWLHoKHEKBI1iW+JP2+5JGIZXFBBSsAJLzv3pRBcbHuzwiNJQ4Pi5YdtWKgMZuwSzThgB/6hDQITE2V3xWtJALBN3px8Mk0XrR9m1tJns2kzFeNHUi+FpauxOn1QH5YU8Lqlf+MUEEdCRifRHdXzk=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Thu, 6 Jun
 2024 01:35:56 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Thu, 6 Jun 2024
 01:35:56 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Shawn Guo
	<shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 3/3] arm64: dts: imx8: use defines for interrupts
Thread-Topic: [PATCH 3/3] arm64: dts: imx8: use defines for interrupts
Thread-Index: AQHat11T7EiEfZOOmkmcJk8dFBTKD7G59Phg
Date: Thu, 6 Jun 2024 01:35:55 +0000
Message-ID:
 <AM6PR04MB59417CBE9E5C6E296A2FB62B88FA2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240605153020.104717-1-krzysztof.kozlowski@linaro.org>
 <20240605153020.104717-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240605153020.104717-3-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PAXPR04MB8476:EE_
x-ms-office365-filtering-correlation-id: 7baf30bb-01ee-4b8f-dc9f-08dc85c902b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|1800799015|7416005|921011|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bPc3GylsCcKoBoIO7WnpONm7+U34B+7gBdcv5apBkodEKNDMfBNvYGoH+/zm?=
 =?us-ascii?Q?hUuwovrTfWE52vQQsBj7OHrhoS8lQZPPVBrzbw22LsTavjTNygTjRbsIEAz3?=
 =?us-ascii?Q?qpfb4guWvVmj3kcnG/RIfS0LBp7r4cR0tXWVJH5z8oRkuW/gPg+3qBon6kiL?=
 =?us-ascii?Q?AVSVBGV0SwNnYwdmgS5A0JVIDp3rwiIVOlDNf5uesm0TcpmebRQ7fDmKJTWY?=
 =?us-ascii?Q?ouV7V95UjkZgi0soKlcXtnZzjAcTSNzZkNlw7ZbicvdL/JF/ZfXo8lmQiVt7?=
 =?us-ascii?Q?uFl8LpBRm6TBvf2Qgi0yPIgKJxMBqPadBBcojSBsgDnrLDf8k0v3xQxUVT3J?=
 =?us-ascii?Q?yLbQTglPObQ0LO+leCPtwAfKPZ8MoqtzllNrJXXXTzGhB90M59SmsQZyHOHm?=
 =?us-ascii?Q?RHacXU0QFN8YpKJFCo6vy8wHEtFPT1khdy0t9lObACqV4Zm6+grtES3pZfGH?=
 =?us-ascii?Q?x59UWxajAp0UzDf2tuGZhMPReW3rN7nsZmusKBuK/8aROK/Nzsj5q/15dDMG?=
 =?us-ascii?Q?tlKS3hDFJ3gJEPyqw45VrKV+UHgW93+3DFGPkCkHppdJWJLw1cHNaYXtOAJE?=
 =?us-ascii?Q?goeTddVxCc50PyZp7UHAcBb+rrBGFOzmIyTdtz4c/JPcaXAd9R1ZDzUBmSi/?=
 =?us-ascii?Q?58deoFapPRXZIt3qw8eWQJc6/Z4Htn9KHHSs/4iuKC5jz7LfJj2Ytc2GjFhO?=
 =?us-ascii?Q?Hbh6+njpMtpm3QNc2MaJkFMnZYCYN0B4VMeru52s8mVDWI3HLwdKymlAymKm?=
 =?us-ascii?Q?8Xpl0w0DASTgpzIcAvbpNuTviWmc5D93pIPGk1bOHOxhdbGkF093Q8s279Xe?=
 =?us-ascii?Q?K5Kle7SgELRknOaGzPhVlaKlJLHfNg0h2sVMsmXmLlLLgaDczdnOnnQant55?=
 =?us-ascii?Q?lbte+MKgOx34uezV4QeNFpCyMaPgFPIduAwYJun8ifNfrhbnUxLeMAHLlR0k?=
 =?us-ascii?Q?8BvUFHFRI4b5kctaHPQU78zM7wuXr06AUAUqBDQes51sjtvL6E2CYR82iiwF?=
 =?us-ascii?Q?zAKylIQ7tr9U6GhbujMOB1GcZL3kxigns7uY8Qnh1fvEsRiR5X0furjHdljH?=
 =?us-ascii?Q?oRwteb5YYCSEctje66QRKLJYFzJMm1+sZqo7qzVcJ3Hns+3rxQ7iG50dPE/9?=
 =?us-ascii?Q?G6oqLx19uHn4aQYWSz9OLfn3jfrccPdOHlwuJ0P9q3jFplGK/r6e4xMX2FAx?=
 =?us-ascii?Q?cqDar2seMJPFcBhTRV9SOaM+Dv5NrMPjJA/90GEfd6j5siXIkYjVVhIqOMUc?=
 =?us-ascii?Q?NSW5OdEi6WDVZXLyxWa22NvrqMbCqfmAtdA9u/rpq+BzcxuakQH/mFI3gc8x?=
 =?us-ascii?Q?8q798uXFRYiQkh9G6xw6BdZk1r7df4vGqK0uPdqQclrqFJBVgq/xavYSQdSk?=
 =?us-ascii?Q?oyu5/V8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0rnsNXduFpIicIeeKYERswerwycVVfm+zFXjWeHm1S1bRvrShLf/K+sBggVZ?=
 =?us-ascii?Q?lUaO8HUAGjiYSu29pnA4wiK0hSrISABDoOC6Jj0znUjWopmiHHovyom+ucGd?=
 =?us-ascii?Q?ze99IeUzIg4PtEfENffyx78eE2GBkhKDkD9RtSozg6T6HcujNDwQKZ/KFvng?=
 =?us-ascii?Q?5iumPuYRnsEGJCnnd0gN3F0iWQT5ado424o9VESUURxAl1ltWRsqFfnU1OUh?=
 =?us-ascii?Q?6MMq1LDXxt2tOlLSEoWltNHazwT6AY5n/qILUSRHV5dOfykEB40rocC2JPvS?=
 =?us-ascii?Q?D8PVSHKq3IIyKljZ2ieT2aRdG5XgRZccbPZ5bpf9s/aG9CiHQkXlljA3mGLp?=
 =?us-ascii?Q?MiBUv1dpzFtZRPkpKESv7nQFJM/BHpkkR+GBQ9UsQ8OYM5vfoyAWJv746GTc?=
 =?us-ascii?Q?yvwUUgS4GndZXTziTPNtRJF/ozdWMo+2Zsav4YUtSDLPMx+GE5k4jNVceNNZ?=
 =?us-ascii?Q?X4mbLqeAYoDFpIDTSlTkokPdG4cCnsWT2Z8hzYpj6sKki+Xj/PXtOLwq04K7?=
 =?us-ascii?Q?XOFagRlrLON+wDYkT/6N8TN7b0agNrBpDZOEQ6DuM6xBrQjvc1qyxar0JKti?=
 =?us-ascii?Q?6c4TkPIeNkQt2Z5JU9tI+KNHkalnZzUxkkICJezF/McNoj2g/m5rpUUAjmjk?=
 =?us-ascii?Q?9P751EwXt1FgUIJRZ8RjToyMX/cXgJI0Ltj2MK9TS8pWfBuelG30nQuxMV0Y?=
 =?us-ascii?Q?6tuBG4TyNFDgmgE8qJINRXKfQ4zGCDBduSgCvDvYDNAC5ZKj8yuwVX8VKavk?=
 =?us-ascii?Q?MoV9wk1yUFb+bvjDvN1kLVF/BrGZS19e4cDHAYPVONhwMSyX7VUA8KySBAKI?=
 =?us-ascii?Q?5WHH4V8/iNO+ZSz1uZ/OsElTP5at2D9nhLBcYWsZxw5w5YHz8FNThPJTIpbg?=
 =?us-ascii?Q?zY3Qus4vrl1yDlWlTwZS1UOORnQ47rrOJgpmsZ1dJbwdpbm/eDld0OExfPrh?=
 =?us-ascii?Q?UxAGYpmtYH0v9Rr5oR/ttG1yfdejCq0+jj83TRKknFkM4ya/iTOH3jAS31qx?=
 =?us-ascii?Q?gafT3qdzEeAv1ZERJppysRXX+xISof5f3hhxMc51p0P/7q9mu1z9g4pZ/Dhk?=
 =?us-ascii?Q?GhByLyzvqkdjddpdJngBLAKXt5etwY/jZpeBuIUQ4NGgIXYCRHCLil6GS6VV?=
 =?us-ascii?Q?yfGLUr68wQgHrastGfa8gC2tfhwVcchQpfBkRv+0BsVze8/+rx3VhehwbR6o?=
 =?us-ascii?Q?r2mK+5PJYcMZtPSq6AhFKNcITSZxyzkZ6TzMFT5VN+vgnLsgoX58PnZwjld5?=
 =?us-ascii?Q?J8+S+UC4DxD5Qr8/ZLg0tWVw1dKTK+VSM7fEE391kGs46iz28XHkIGfDqDOC?=
 =?us-ascii?Q?UMXQK4Xa4SjKFJNsp6MRiQXKfmM0zZa2E5yJgG5Shp5kJ5g7Y+5MZNCgtiCg?=
 =?us-ascii?Q?Kgj3wftQnnoOPsci0ASj5868EAIn8VJXdU0PKKiwkA3wA6eSyrhN0lwKljg/?=
 =?us-ascii?Q?O4iZXBErpbRUvyyKutZDOkaemZZJM2bTL+B35juQOVMixbXbTqL0Ax0JLwWO?=
 =?us-ascii?Q?zv5Z7qVzC/gigazaB7id2PqdjuzrE5okJ2pzLQB1DQoQr98R+HsqlkKu/cZU?=
 =?us-ascii?Q?mm9wc+OlQir/nVoXeZI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baf30bb-01ee-4b8f-dc9f-08dc85c902b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 01:35:55.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pz5eAcA6eRSWNJA4HfbFBUSfUHhhtdfmwxJfVZP+aAuRGlNd69xMD3dS2m9Ct+KM8vfvtMBN/mVCqeQT9VRrgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476

> Subject: [PATCH 3/3] arm64: dts: imx8: use defines for interrupts
>=20
> Replace hard-coded interrupt flags with standard defines for readability.=
  No
> changes in resulting DTBs.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 2 +-
> arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index 90d1901df2b1..930e14fec423 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -400,7 +400,7 @@ ptn5110: tcpc@50 {
>  		pinctrl-0 =3D <&pinctrl_typec1>;
>  		reg =3D <0x50>;
>  		interrupt-parent =3D <&gpio2>;
> -		interrupts =3D <11 8>;
> +		interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
>  		status =3D "okay";
>=20
>  		typec1_con: connector {
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> index c024be33fbcc..6d002fc1b2be 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> @@ -193,7 +193,7 @@ light-sensor@44 {
>  		compatible =3D "isil,isl29023";
>  		reg =3D <0x44>;
>  		interrupt-parent =3D <&lsio_gpio4>;
> -		interrupts =3D <11 2>;
> +		interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
>  	};
>=20
>  	pressure-sensor@60 {
> --
> 2.43.0
>=20


