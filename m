Return-Path: <linux-kernel+bounces-233165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A6791B31D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F86283B16
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40C6A55;
	Fri, 28 Jun 2024 00:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cM1oE3ji"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2082.outbound.protection.outlook.com [40.107.103.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE544A1C;
	Fri, 28 Jun 2024 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719533013; cv=fail; b=V1cxXbKECRkeT3UlYBzWZlm7fY6pk37CFm0/Y1R6VkkmbQbIBseKfWfS0Iv82SdKAzLD9sSzAxY9Q+FgpLzR3lgDp0BOaPI8zQeFZZCirsvwt+JQQy1HF6LQLXGXsUYZUXTpTyepUCMA3M3TaZigc2aZvP+OhIci9d8ryFAgKzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719533013; c=relaxed/simple;
	bh=GJG/GDDRkeiO0/A+lj8MEJ+4j4GOPK0zt3YofyCU5/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p0dT6x0LA0iR44TwXDc/KpVwDG/jQHkdoRJbKHyip43Qe748Fnim2RXlQtACHl+hl8DkrxE2kKZVFWXHQw/9Kae+y/DuROxfEUmtEF+zJ9AAaTjPsEcDxzIFpFXOMAZv86/RIY+3ogBBdmrjyVwgkZrPo1FKCR4E8OjtnoLGlqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cM1oE3ji; arc=fail smtp.client-ip=40.107.103.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/mnsMYNrL7foY9X3ZelU/tZMCp0+c70f/MQPleiuWKSx0md6dXRJ4Tpduv08v3lY1d5eoEpQ8za1fhyitG4jIwaToYu6j+0oHShHTk/TuU9ec6vz8/YLPVUFknJ861b0u4vnqTkn+60rLIiBNx7n98GkVEjbl1BqXvNkV45cnB2nA6zA5UttmTnwW267T7qKanW06WdeRlQleMNklh06AiU6ZeqJnf5GROaYr+4vvETOKnsyviHeK5MgF8WyjF34/+vHtcPdcXQsbbON5ceP0bqdEDHZsLvjSMsZF5WnlXrXVCzVKbSN7zQh9JAs9MYzhmjBVWiPbxPHUpkbY9bqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG4BOrp8hn+uZ3XJSK+3VCUWT/WTi090fHJTOc9fhls=;
 b=OtwFYETdRkrUQY6XddVV3b2JNBOVIdWTA7Vq9ZSh/wUo++wtuGvmk9T7mUh/S6yhopoXNe/eU45nNsUEfGJAFHjtNzUGiWQWf3UmpXUMlc84D7ecf26FkOAfKs01mHVzQ6Gg1B57iuaGgkp5ozaSR7sVhpidP+QDFgp0tXbNsvxVAVEOyhZxkpjqPRnLG9dLi1PArJiXudVd2YAFagkr8FzbdY4c5dl6vPW/4ffCzOD/1ukxh1XPnKUDXtYuIbGBM7kS57Wz3QxvU+hroh/vH3Y8bBc5lxTs+3JhYSJWXHS/K9KaI3OIXsEzajNaIBNTZEHFU3JB5DBo9hmqyKdB9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG4BOrp8hn+uZ3XJSK+3VCUWT/WTi090fHJTOc9fhls=;
 b=cM1oE3jiv/HWNm9n03hs/e2EM2zM0ZEJO5aJionXzd/zlAcGS8Ijb5BfbDlOHN5sNtqzsLd9jFK5B16LZbIWrrbORR675Ma6eN4dNKbhDEzooapB8PPpyNvRsXjozopRImWzzLgTW1XEp7Des67BlXlCet16xhS64hgc7JR4Vqc=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DBAPR04MB7237.eurprd04.prod.outlook.com (2603:10a6:10:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 00:03:27 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 00:03:27 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "open list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 3/7] arm64: dts: imx95-19x19-evk: Add audio related nodes
Thread-Topic: [PATCH 3/7] arm64: dts: imx95-19x19-evk: Add audio related nodes
Thread-Index: AQHayN14VGZNcpI1iU2oSBWPCVBY67HcSzYg
Date: Fri, 28 Jun 2024 00:03:27 +0000
Message-ID:
 <AM6PR04MB5941C1138E4F33AA3FA49AA388D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240627220001.692875-1-Frank.Li@nxp.com>
 <20240627220001.692875-3-Frank.Li@nxp.com>
In-Reply-To: <20240627220001.692875-3-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DBAPR04MB7237:EE_
x-ms-office365-filtering-correlation-id: 61209e2a-70ad-4c1f-d50b-08dc9705bc61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NFM+htWQunXlAAm/1QPW4gsY90S0Md7bXKld+SgOmzzB3yVpPkV+cf3o65rL?=
 =?us-ascii?Q?henLy8m3mP8gNQqeu589s/xZn0vccZlE1Jv4iv0TmS5j0N08sv41IgYFnqz8?=
 =?us-ascii?Q?6UxxJuTvrGCYn1ddhvFn6OTfCf5CoW8iP0Tm6WXzSWCIK/gfnHfrrnClsEY9?=
 =?us-ascii?Q?qhAEEHSavTDMAAfMJXuVVb7IY7QaEVfpvNXLJYGxvI5q0MXJmMumzTx/zmrd?=
 =?us-ascii?Q?3VpG0JnU2/5qa1evVytQTKAMuGl3DU8i+7hgvHDuR7Qvwy///+bJudh72I16?=
 =?us-ascii?Q?sFbE+wJuhAXJmwy85KAYZ64jWOS3L5hOArrL6HbY+6DcmbZ5n1lfKVjrLrCJ?=
 =?us-ascii?Q?ENhZ/IPfN1E+6pW/H8GKI2rQ4nXrmFIIv4j51spAZYVRhcLdEZrwPEQnqd+Q?=
 =?us-ascii?Q?G91uG8vVB7L2Tm39/EESpJFecG/RKI7EHufk4J5istL6M4Kx/32hw3Yah1sV?=
 =?us-ascii?Q?URJjDGIqb5ZtjbF1qRhteaWbZTYZVVb/MJPHowz2KKnGGVfBdsxmDPAc+BOf?=
 =?us-ascii?Q?PNCuN94TvY1qH7O96EODjCh9gJgb6UyM86XStdMK1x6/NCAXNaHp0QMIgWAN?=
 =?us-ascii?Q?662nEteNRj3ET00QmHfclQJ6U2+Gl1fi3jg9mKIh5z0epmDvtQgzodOm4Ibi?=
 =?us-ascii?Q?7ORrVMaaXk9mex1QvGmR1exnoqOrAn1mTDwOOvh6cdJZZYN+KDHDwHoWRncR?=
 =?us-ascii?Q?guO0PaLH+3XLNUvd+Rd+Rnp1TJ38q8HK3HP0WQhtSEAKALoJNlQdue2uXaFd?=
 =?us-ascii?Q?f7rJ3dMxBkCij/XIznYqqgx3S/h6zx80kNInK9s/DnIeEKxEyC/iLpZ0Oc6d?=
 =?us-ascii?Q?ECCT+CL1Y6WbiU4plbjMrR/Pn1vSSGWbpIrYLd2nvvmSUoB4g649ywQ7su51?=
 =?us-ascii?Q?rUQFl2JpxpEqyaN5bZtuUb+9GTGxfCGJyXh5nW0PrcuhEQrDa5lV5zRHbyjw?=
 =?us-ascii?Q?djCg+ZUdlvvUjCT+6arhJUYus96fVd5StMNjPAnja1bD0nz+M1o/lWlAJnCe?=
 =?us-ascii?Q?++I6R2oVTNijo54aDdvthTsHeF4edfHgcVKRsGVxVejDSZ6D3708Gn6hIPil?=
 =?us-ascii?Q?EDrj9CCkGihe6fQFkEkg0VP5zu0B+WKDiA6WUG/yjwtUK9H7MyQLi+bA+lGS?=
 =?us-ascii?Q?WZsLYK2cLhDhXihWO8s7xvEE44VLX9P9YA+WwLB5H+NeRr30R/5WzSMILfuX?=
 =?us-ascii?Q?RFXpQ6cV6qAfeNjJpDRPrxubCZ428GRB+Ii+3oHfF9Jlv3S81lBk2j/YLeCn?=
 =?us-ascii?Q?4Bc+kf6yM8eoZbQR/xc7YHMNTEQposqfz4qNcJE9RDAVHLyN9dW74Cho+so8?=
 =?us-ascii?Q?ycrBFJmxCkhIpOgsFMwnzbUoTvn4bS1pcqjFNxqZVlQOKcvn2LzGvNnYezZ9?=
 =?us-ascii?Q?+QVTmzyJo+7imbQrJqaoUHuqL8LvDaPWIei212mK6u6iIFdTyfHbt00IC9Dv?=
 =?us-ascii?Q?MmfmfCC92ew=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?V0XR1NCC0GnchXqAAuy7d7LlwyySKHqg1NMTa/hTk95Xjq5ZPSuYhvIyu9VY?=
 =?us-ascii?Q?OtclKWuyCcuiY3GMG+KrJV1fS9VGi/lxLyAi4moSL/EolgencSllQftD8YoB?=
 =?us-ascii?Q?RiY5BrfWUvzgfoLMTkt9LgaX6s6N/immgoZZ3z/QHnPm72jBNmnHEq/IGN3V?=
 =?us-ascii?Q?pThiXGo0Gmc1GkhIc4eJbwGbHT9Y8ScMgYXItkXS/qz76lzhDO1nxUpyHmBd?=
 =?us-ascii?Q?EG+1zI/369hI3eGzMgsYa1wX0tdOhdGHHHFpIUDcQMwPw0FeLnP3FLQzRdlF?=
 =?us-ascii?Q?fDNgKZKRl4KoOBPuWRZDuy53R0mbHQUIwT9U53KFk2tEHW6fC+/zh8s1ohKI?=
 =?us-ascii?Q?NS9hcY2HpCfBwsRmHxx/LLv1r1WrVysqhkbDhFMBXJap2ZE2O6g9w/JBDGVr?=
 =?us-ascii?Q?qCOwr5gWAuMqb/AiG8CtUp/8H15YUshImwayWD0DAlvpUwa+PQGmt9U70B/H?=
 =?us-ascii?Q?Vwp3i0+Gm1T7MzngGm+CXahdBgbhzJ+ddApW3HbvH4VHy4e1rYw6u6OAJ3sI?=
 =?us-ascii?Q?T+vvETdjfB1+7cllwD0CyK2z9q04VN32/yDk0Imuog03XlGqKp+bVdo7WRUY?=
 =?us-ascii?Q?kfTg3CN3gdNoJ5aqJpjmcpzY3/mu6Bw9dN6cMNwKTuIEog2TnLKwS3rYUszG?=
 =?us-ascii?Q?YGcJZTZ1kVdfK3vDBzVAggaWbSKCqAsELeS8PUyQl0y/3AzzVk/W6MQND2jo?=
 =?us-ascii?Q?IctyN/xSN13M9j2UsY1msDR4ba3Q1rtqxFMVHTXJavgo9pcludTuJ/AcupNH?=
 =?us-ascii?Q?pINy6Xxn9b26SOzheo3M6ZsawJY/hUCgoN6O1S7K2gy6UsLzpiwfBmLytfyj?=
 =?us-ascii?Q?1AAtnoIoKjvFA5h5RRlBQiISON0E2UlY7J4jmugXqCd6thVPHOubnNhJXz0S?=
 =?us-ascii?Q?AbkzFYrOWVAvzkImOK+lJyQMsT7CUsrJN0jgFcRV6LKLjGPmW6fBm9fgBWDb?=
 =?us-ascii?Q?FWbqSgQz7u5OYbKEtu+kzoqQKJogFzJB8/pJZNc8qBVEPxetxuV8omE9WEJF?=
 =?us-ascii?Q?of6GZVKNKT5/kN4WogZQwqAOjuWZpSuCqTVEm4Ns2X64OwK+VFitPK3qW/oF?=
 =?us-ascii?Q?VHKcU5LpMx28GsLEIFVvGa0wZ0+3QO8qs4JResg+BsYr/HBDoZao1Eg5bEHO?=
 =?us-ascii?Q?oB8NgpF2eOLlLJ9RgxoBnFcXNeQbGY5T9b3TyD/mMRoSv1ixVuoMp+zjDZId?=
 =?us-ascii?Q?UzOOHDBluc9u9U7ePGG8vKgkvJWnD0Rzs7fvP0VuYTO8MfT/cx8VKQ1ZrpST?=
 =?us-ascii?Q?bpWZGaDt4d95maYFVcIOAnVmdoMUhNpPASFTgemSlQS4xXackI5qEa0HRldS?=
 =?us-ascii?Q?1PNshelxRzeoh7Q6DlSaJJmNnpRDQCwXxtcRVlbZ8clR/KxW4GKSoMhdyjy9?=
 =?us-ascii?Q?LYOPkbP2YzfXKzyzyGdhYrTVylPBvRToXmeGPB8fhy6X8Oc0ddDij5YZOTn7?=
 =?us-ascii?Q?aLpmDhpz/MUujUafWjitZQt8TNGT4FtKlUQG9ECYcWnzaCXCZbeRbYAvS5/d?=
 =?us-ascii?Q?PumFjEg1V9VmwSTzdbEvs++tqp+T8mj/I41Homg0oPrd1DNMJpbGbXBJiJP2?=
 =?us-ascii?Q?wgoI4RWdsg4uPq6oBII=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61209e2a-70ad-4c1f-d50b-08dc9705bc61
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 00:03:27.0840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jo7vonqkHxElC5pHSHmdpK7B1GmABSJvSL3S4XVZ/kCYo840iJKXBTJbCn9cqRpp/nXtEpK4FAZiF6/SELfpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7237

> Subject: [PATCH 3/7] arm64: dts: imx95-19x19-evk: Add audio related
> nodes
>=20
> Add sai1, sai2. Add i2c4 and wm8962 and other dependent nodes.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../boot/dts/freescale/imx95-19x19-evk.dts    | 238
> ++++++++++++++++++
>  1 file changed, 238 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> index d14a54ab4fd47..660e623f4f964 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -17,6 +17,11 @@ aliases {
>  		serial0 =3D &lpuart1;
>  	};
>=20
> +	bt_sco_codec: audio-codec-bt-sco {
> +		#sound-dai-cells =3D <1>;
> +		compatible =3D "linux,bt-sco";
> +	};
> +
>  	chosen {
>  		stdout-path =3D &lpuart1;
>  	};
> @@ -40,6 +45,34 @@ linux_cma: linux,cma {
>  		};
>  	};
>=20
> +	reg_3p3v: regulator-3p3v {
> +		compatible =3D "regulator-fixed";
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-name =3D "+V3.3_SW";
> +	};
> +
> +	reg_audio_pwr: regulator-audio-pwr {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "audio-pwr";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		gpio =3D <&i2c4_gpio_expander_21 1
> GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	reg_audio_slot: regulator-audio-slot {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "audio-wm8962";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		gpio =3D <&i2c4_gpio_expander_21 7
> GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +		status =3D "disabled";
> +	};
> +
>  	reg_m2_pwr: regulator-m2-pwr {
>  		compatible =3D "regulator-fixed";
>  		regulator-name =3D "M.2-power";
> @@ -79,6 +112,97 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  		enable-active-high;
>  		off-on-delay-us =3D <12000>;
>  	};
> +
> +	sound-bt-sco {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,name =3D "bt-sco-audio";
> +		simple-audio-card,format =3D "dsp_a";
> +		simple-audio-card,bitclock-inversion;
> +		simple-audio-card,frame-master =3D <&btcpu>;
> +		simple-audio-card,bitclock-master =3D <&btcpu>;
> +
> +		btcpu: simple-audio-card,cpu {
> +			sound-dai =3D <&sai1>;
> +			dai-tdm-slot-num =3D <2>;
> +			dai-tdm-slot-width =3D <16>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai =3D <&bt_sco_codec 1>;
> +		};
> +	};
> +
> +	sound-micfil {
> +		compatible =3D "fsl,imx-audio-card";
> +		model =3D "micfil-audio";
> +
> +		pri-dai-link {
> +			link-name =3D "micfil hifi";
> +			format =3D "i2s";
> +			cpu {
> +				sound-dai =3D <&micfil>;
> +			};
> +		};
> +	};
> +
> +	sound-wm8962 {
> +		compatible =3D "fsl,imx-audio-wm8962";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_hp>;
> +		model =3D "wm8962-audio";
> +		audio-cpu =3D <&sai3>;
> +		audio-codec =3D <&wm8962>;
> +		hp-det-gpio =3D <&gpio2 11 GPIO_ACTIVE_HIGH>;
> +		audio-routing =3D "Headphone Jack", "HPOUTL",
> +				"Headphone Jack", "HPOUTR",
> +				"Ext Spk", "SPKOUTL",
> +				"Ext Spk", "SPKOUTR",
> +				"AMIC", "MICBIAS",
> +				"IN3R", "AMIC",
> +				"IN1R", "AMIC";
> +	};
> +};
> +
> +&lpi2c4 {
> +	clock-frequency =3D <400000>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lpi2c4>;
> +	status =3D "okay";
> +
> +	wm8962: audio-codec@1a {
> +		compatible =3D "wlf,wm8962";
> +		reg =3D <0x1a>;
> +		clocks =3D <&scmi_clk IMX95_CLK_SAI3>;
> +		DCVDD-supply =3D <&reg_audio_pwr>;
> +		DBVDD-supply =3D <&reg_audio_pwr>;
> +		AVDD-supply =3D <&reg_audio_pwr>;
> +		CPVDD-supply =3D <&reg_audio_pwr>;
> +		MICVDD-supply =3D <&reg_audio_pwr>;
> +		PLLVDD-supply =3D <&reg_audio_pwr>;
> +		SPKVDD1-supply =3D <&reg_audio_pwr>;
> +		SPKVDD2-supply =3D <&reg_audio_pwr>;
> +		gpio-cfg =3D < 0x0000 /* 0:Default */
> +			     0x0000 /* 1:Default */
> +			     0x0000 /* 2:FN_DMICCLK */
> +			     0x0000 /* 3:Default */
> +			     0x0000 /* 4:FN_DMICCDAT */
> +			     0x0000 /* 5:Default */
> +			   >;
> +	};
> +
> +	i2c4_gpio_expander_21: gpio@21 {

Use gpio-expander@21?
It is easy to duplicate the node if other i2c bus also
has one.

Regards,
Peng.

> +		compatible =3D "nxp,pcal6408";
> +		reg =3D <0x21>;
> +		#gpio-cells =3D <2>;
> +		gpio-controller;
> +		interrupt-controller;
> +		#interrupt-cells =3D <2>;
> +		interrupt-parent =3D <&gpio2>;
> +		interrupts =3D <18 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_i2c4_pcal6408>;
> +		vcc-supply =3D <&reg_3p3v>;
> +	};
>  };
>=20
>  &lpi2c7 {
> @@ -108,6 +232,23 @@ &lpuart1 {
>  	status =3D "okay";
>  };
>=20
> +&micfil {
> +	#sound-dai-cells =3D <0>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_pdm>;
> +	assigned-clocks =3D <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
> +			  <&scmi_clk IMX95_CLK_PDM>;
> +	assigned-clock-parents =3D <0>, <0>, <0>, <0>,
> +				 <&scmi_clk
> IMX95_CLK_AUDIOPLL1>;
> +	assigned-clock-rates =3D <3932160000>,
> +			       <3612672000>, <393216000>,
> +			       <361267200>, <49152000>;
> +	status =3D "okay";
> +};
> +
>  &mu7 {
>  	status =3D "okay";
>  };
> @@ -128,6 +269,42 @@ &pcie1 {
>  	status =3D "okay";
>  };
>=20
> +&sai1 {
> +	#sound-dai-cells =3D <0>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_sai1>;
> +	assigned-clocks =3D <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
> +			  <&scmi_clk IMX95_CLK_SAI1>;
> +	assigned-clock-parents =3D <0>, <0>, <0>, <0>,
> +				 <&scmi_clk
> IMX95_CLK_AUDIOPLL1>;
> +	assigned-clock-rates =3D <3932160000>,
> +			       <3612672000>, <393216000>,
> +			       <361267200>, <12288000>;
> +	fsl,sai-mclk-direction-output;
> +	status =3D "okay";
> +};
> +
> +&sai3 {
> +	#sound-dai-cells =3D <0>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_sai3>;
> +	assigned-clocks =3D <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
> +			  <&scmi_clk IMX95_CLK_SAI3>;
> +	assigned-clock-parents =3D <0>, <0>, <0>, <0>,
> +				 <&scmi_clk
> IMX95_CLK_AUDIOPLL1>;
> +	assigned-clock-rates =3D <3932160000>,
> +			       <3612672000>, <393216000>,
> +			       <361267200>, <12288000>;
> +	fsl,sai-mclk-direction-output;
> +	status =3D "okay";
> +};
> +
>  &usdhc1 {
>  	pinctrl-names =3D "default", "state_100mhz", "state_200mhz",
> "sleep";
>  	pinctrl-0 =3D <&pinctrl_usdhc1>;
> @@ -159,12 +336,31 @@ &wdog3 {
>  };
>=20
>  &scmi_iomuxc {
> +	pinctrl_hp: hpgrp {
> +		fsl,pins =3D <
> +			IMX95_PAD_GPIO_IO11__GPIO2_IO_BIT11
> 		0x31e
> +		>;
> +	};
> +
> +	pinctrl_i2c4_pcal6408: i2c4pcal6498grp {
> +		fsl,pins =3D <
> +			IMX95_PAD_GPIO_IO18__GPIO2_IO_BIT18
> 			0x31e
> +		>;
> +	};
> +
>  	pinctrl_i2c7_pcal6524: i2c7pcal6524grp {
>  		fsl,pins =3D <
>  			IMX95_PAD_GPIO_IO36__GPIO5_IO_BIT16
> 			0x31e
>  		>;
>  	};
>=20
> +	pinctrl_lpi2c4: lpi2c4grp {
> +		fsl,pins =3D <
> +			IMX95_PAD_GPIO_IO30__LPI2C4_SDA
> 		0x40000b9e
> +			IMX95_PAD_GPIO_IO31__LPI2C4_SCL
> 		0x40000b9e
> +		>;
> +	};
> +
>  	pinctrl_lpi2c7: lpi2c7grp {
>  		fsl,pins =3D <
>  			IMX95_PAD_GPIO_IO08__LPI2C7_SDA
> 		0x40000b9e
> @@ -184,6 +380,48 @@
> IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B
> 	0x4000031e
>  		>;
>  	};
>=20
> +	pinctrl_pdm: pdmgrp {
> +		fsl,pins =3D <
> +
> 	IMX95_PAD_PDM_CLK__AONMIX_TOP_PDM_CLK
> 		0x31e
> +
> 	IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_PDM_BIT_S
> TREAM_BIT0	0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai1: sai1grp {
> +		fsl,pins =3D <
> +
> 	IMX95_PAD_SAI1_RXD0__AONMIX_TOP_SAI1_RX_DATA_BIT0
> 0x31e
> +
> 	IMX95_PAD_SAI1_TXC__AONMIX_TOP_SAI1_TX_BCLK
> 0x31e
> +
> 	IMX95_PAD_SAI1_TXFS__AONMIX_TOP_SAI1_TX_SYNC
> 0x31e
> +
> 	IMX95_PAD_SAI1_TXD0__AONMIX_TOP_SAI1_TX_DATA_BIT0
> 0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai2: sai2grp {
> +		fsl,pins =3D <
> +
> 	IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_SAI2_RX_BCLK
> 			0x31e
> +
> 	IMX95_PAD_ENET2_MDC__NETCMIX_TOP_SAI2_RX_SYNC
> 		0x31e
> +
> 	IMX95_PAD_ENET2_TD3__NETCMIX_TOP_SAI2_RX_DATA_BIT
> 0		0x31e
> +
> 	IMX95_PAD_ENET2_TD2__NETCMIX_TOP_SAI2_RX_DATA_BIT
> 1		0x31e
> +
> 	IMX95_PAD_ENET2_TXC__NETCMIX_TOP_SAI2_TX_BCLK
> 		0x31e
> +
> 	IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_SAI2_TX_SYNC
> 		0x31e
> +
> 	IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_SAI2_TX_DATA_
> BIT0		0x31e
> +
> 	IMX95_PAD_ENET2_RXC__NETCMIX_TOP_SAI2_TX_DATA_BIT1
> 		0x31e
> +
> 	IMX95_PAD_ENET2_RD0__NETCMIX_TOP_SAI2_TX_DATA_BIT
> 2		0x31e
> +
> 	IMX95_PAD_ENET2_RD1__NETCMIX_TOP_SAI2_TX_DATA_BIT
> 3		0x31e
> +
> 	IMX95_PAD_ENET2_RD2__NETCMIX_TOP_SAI2_MCLK
> 		0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins =3D <
> +			IMX95_PAD_GPIO_IO17__SAI3_MCLK
> 			0x31e
> +			IMX95_PAD_GPIO_IO16__SAI3_TX_BCLK
> 		0x31e
> +			IMX95_PAD_GPIO_IO26__SAI3_TX_SYNC
> 		0x31e
> +
> 	IMX95_PAD_GPIO_IO20__SAI3_RX_DATA_BIT0
> 	0x31e
> +
> 	IMX95_PAD_GPIO_IO21__SAI3_TX_DATA_BIT0
> 	0x31e
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins =3D <
>=20
> 	IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX
> 0x31e
> --
> 2.34.1
>=20


