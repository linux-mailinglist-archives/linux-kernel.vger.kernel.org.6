Return-Path: <linux-kernel+bounces-203506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DC18FDC36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE481C23549
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1D014AB8;
	Thu,  6 Jun 2024 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eObzf+w8"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2086.outbound.protection.outlook.com [40.107.6.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A304911187;
	Thu,  6 Jun 2024 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717637997; cv=fail; b=SEFHMG4dd7SJFakPK5n2eZ04zsL28tkRF47IS2kJGcTZnG4rBMSgq5rhrk6r8a94qTfXSTHGOp10hXC7bLxCQHWRIhSip45StpTTsRdo+FBGrz6lv0TVxkOaTV4NgrVPotdfJktviHxIXM45FRVJWwih/LLj/gHbtEzmNySClkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717637997; c=relaxed/simple;
	bh=0UJDOrx/vhtVtUP7brODY3gaqI1cfTyDu0SCJv837Og=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FJftoWA5o2VHDOguiSLieCjQABC0zfMG6ttTGnDayG8nkmZQQN5wkjVkNgJ0EnGtQNe86IVx+MbbocNeinyS/ErbAGxf+HfHe4hQEvM/DRqhKUCazn8DzaXDmTdSXnyoxbWFBv26qaEyM2rnAotgsjYwgYPpGRvQ1xnjL5bRC24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eObzf+w8; arc=fail smtp.client-ip=40.107.6.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqVsnHVfpjl4yXJ3B8bgXuhsvlHK+9KQkcF4W0UPvdkVqUUY7jrTy6q3YgYYrInuOlylnyuyJfSBtYl1FV08szdFCpdNXq8k/fAh7g9hBWrnUUAafNDtVanWKzjS/He4iRCShvJFdvjb1n4YV29Akxcv4nM7yFfVR3tDrvPtXWj5kXzoLTvHPFEK9mkvZF0pytiu/hlNI10Az8hoVbo1NIDqfzd6PnV/kP+7a9l8z4KaAdsYEp6H1bV/D8QTya1efqrUlO0kPrlK1611SAZhsqt1DTksDfRoaVuaUNBwQXfJV3JYAPwQFam+2wDT+o9z6VVOk/SUla5eizR0nfyz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2q8dQ9ME2IeE77zfYFnz9T2I1TZ0nI+XstzOepGsMk=;
 b=Men7cEDzEhLYYBk4rR2gg6ClYgiUW0wx0XsITMDsx3plok1HUf9Y2VSgo607EVIq7PTTGhLTqjryenv3DBrhJptcIPVrtrsRGK5d/rbUdO5tGzS07hyZArTSrfwOPbST9nBcvqozbEoYPjB7c9XIeSTPGFyn+3LRPgc9vMvAqIU4H/bYSnEb5V0Rnugt5dvX9BrYi5GSXRYU5GrVNDdzwZAvAbPvKb1I6XAHuq2p62qMpNakJr8YA5s05BYO6MJEMSBOWlMXoMZrEUCouDxIq4x45jBqkK6sY5AcEzcIVcSdMGWSo+S722OkAp0sT68FEBukQoJXTU8lcP/8zO+AWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2q8dQ9ME2IeE77zfYFnz9T2I1TZ0nI+XstzOepGsMk=;
 b=eObzf+w8navUrIQey7zmtoHuvqitAaUt5MWReEtMmRMh/N3sAyijssy7vvVZlz0qweNTvW1wNyPsY6HxxNjJepfKXoyr5Xe3RG6BYzvU9gsUbmVTUs3bQsZNNTkHvoxNBMBVbCa2p5EbXeldINhD0ifpNvQjHoL0szoIroZt9wQ=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 01:39:52 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Thu, 6 Jun 2024
 01:39:52 +0000
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
Subject: RE: [PATCH 1/1] arm64: dts: imx8dxl-evk: add imx8dxl_cm4, lsio mu5,
 related memory region
Thread-Topic: [PATCH 1/1] arm64: dts: imx8dxl-evk: add imx8dxl_cm4, lsio mu5,
 related memory region
Thread-Index: AQHat4b0yuXmSw/0t0K1zNfThU4QA7G59Ynw
Date: Thu, 6 Jun 2024 01:39:52 +0000
Message-ID:
 <AM6PR04MB59410C8115DB22CA2CE3E30088FA2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240605202703.1220203-1-Frank.Li@nxp.com>
In-Reply-To: <20240605202703.1220203-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DBBPR04MB7786:EE_
x-ms-office365-filtering-correlation-id: 04e3618c-4616-42b3-4a37-08dc85c98fbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|921011|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y5TwpCNZKhh3nq6cV5piLpe0O44g455YrH3cNBWQhMl2WtkC6l8Ro8sZiIXZ?=
 =?us-ascii?Q?CXNO7EfF680PK+qlXYcVjX2i+D2V0vXsp/mTTnnoC6wrxxo+gA+opRJhxQAo?=
 =?us-ascii?Q?2E7uHwt8ZVlRHJ61HE4Ow4qQmPMCBqeTJxL5oSx4sg947LlePYtSncgv+0oP?=
 =?us-ascii?Q?7/+PR/DOMFCfUh9rfNDS83D2lJGcyk3O10yNPVdW/w6+RSo4/jL3hVuBLO4k?=
 =?us-ascii?Q?3F2iNCFfh7eIexHrVnFHnH15kOf4+nkuuat7uCtGNH3CYbml9vvyyXLXOkCG?=
 =?us-ascii?Q?oGfmbtiCq/8SHTyWyZv74SSxBUS1UJdyPdGKDqODwtFlLBQRzGJXK7BNHwYT?=
 =?us-ascii?Q?AsIGacAQDk+gNUKEK9A9fFI29rUKyqWNaBDJBrcADRHBrmSEF7tlYUZ1ezH7?=
 =?us-ascii?Q?IGlmXzgo91s2w43vDYPoapCNnyzH1SCNV0FOspPWOYYy1d0+Mfltzhycf1/7?=
 =?us-ascii?Q?5qN2lmxHUdB07nr7U5LQHq+IZeo9AliOmFaRu6Hw01vuCtmDRS6Dx4XK7wgs?=
 =?us-ascii?Q?7X/W3n0BA01aUW7RbnZVJ8S5LxGJRh6ncVJszCoFv/sabzn9Y36JtsL9h1aF?=
 =?us-ascii?Q?TvpBN4cALEyR1iGNqrd9/8bxskBglWH4fj6Jodt8cOV83FsEeF8OFlDx2o2p?=
 =?us-ascii?Q?aHkg3r6vepxhjECDUEOgOWSztQ/7KHeg+Mov0xy0OQvl+srAYCFEXcitQL0q?=
 =?us-ascii?Q?5O44kdqVnnEut9EMytwV+Ke5QRad1MQBq1/jFH/KQ9Byk5dwxdVIaUaZ4+Iw?=
 =?us-ascii?Q?qZde9BzxwzDUWOcpEW36J/ycUhKt+caCiSNUfSCkdYoZtToUMfnsu9+8piCO?=
 =?us-ascii?Q?OR/3mHG19OFVlHHS3ZlkwYj8UWnUHfP9YmOJ9k1wP1AE2mEXpNJ8JIDhudVw?=
 =?us-ascii?Q?onfuI4FK6ZBKPLy/rqwrK/9Uk/xoXj/2aZzrwWgizrCETwuOA6+KeQW/HiMk?=
 =?us-ascii?Q?ihDry8/q861xiUVd/Vp4Ex5YY21GMwcinEkW7eFB9QVSERa7kMKIFpz8QQb/?=
 =?us-ascii?Q?aukKYFhHjwomg92hDLBDLZbi6r3oOsGhGP110ZCmsCj3IXV1yomZA35oVDVy?=
 =?us-ascii?Q?ay8bfLu4p3dyxgNbXr2aVSRp0OW+VrjDZNfYNE0Hy8GtpWp92neOAnrK/Flk?=
 =?us-ascii?Q?Y8vLkfLd4HR2Bp4SWk9zKF9UDEMB1pBz0hBwJ4dmSWNnvQPTRFU2owf+eAoY?=
 =?us-ascii?Q?w4bRZJ0bHeDaCf4j2ja0p91b6UKypGmE2BsRHmz/1rjyUfnZg4iIkN5YmvzD?=
 =?us-ascii?Q?WKP1ZJM1wLPoaRH6joEob6R+Gp8rBe0GfQdgJljRpZIy+999Sve63BvJScUM?=
 =?us-ascii?Q?mBz5H1Sy0rtlAlBQTuCsJ1Rqj20XujdDY97DYISgR1i/EA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?seTzT3w4kRPT5OJl0i3eI0KRj+tkBU8Rk0O81UZxZEu9nMnS5btrEkuqzdxL?=
 =?us-ascii?Q?dZT5JKKIAJxqFcFSw+R2TbL1KxqISyt+YWCWaLAOUNrzHqdKu8AcnPWsk/o9?=
 =?us-ascii?Q?tN1b8F9JXS+TxIpnKSnzCRh2QToGVGa7TopJFEZwia2pJs4sxmkZjXdJv7f1?=
 =?us-ascii?Q?AVCPLgX8LJMk0acJ31CQKYLV5hLkyxh2e673Ut1O+4zK5zQY49ZrmhV2ITos?=
 =?us-ascii?Q?yAXodbquEEFl+RYbgBX2XY7iLyf6uNmO1wWAQ/L38XAz/fA4WMVwTW49gx0c?=
 =?us-ascii?Q?iKdBLs/YMyqTajz+twb1oTMgogFb2AmvRZNDrxan5tlq9tw+mqnadW+K7yke?=
 =?us-ascii?Q?f4HDik5jDCvbisi29wJQ9Ax/BJ0pcvYyFSujAJ+Xmc1q7HpxVrvU4EW1cxi6?=
 =?us-ascii?Q?fwKDXHbq4vsr32cNUAUusnMjkoHEuakYfJF9Sr5ANu0pz2eMGFFnX8C7ELcl?=
 =?us-ascii?Q?j8JEvfrs6ZSYHtycmIaeHupSFBmvOdh/kfB/yl414n6czaT/2c/zYs4yo8oK?=
 =?us-ascii?Q?JZk3/ftNXyioCsFE5weUWUQYKK0c9sJuDIxsSsU6Te6Hw9Lzv5+HC1gERcoD?=
 =?us-ascii?Q?88omqDGxnjQEKGCYRFk9Xd5Rx2ZszwHwf6oegpYI6RhBMJbyI+jGNAGQfC8S?=
 =?us-ascii?Q?ktcCjH19xd3bKOaXRsp+FjNszvVgT3aL/ClJEZGiNBg8cGC70CjcxymaBke5?=
 =?us-ascii?Q?bb+dcQWyh7z86hNHMBA7utmf0yhGsGlREW1FHP/wcoIlEQU4HtRJUOHUI8Xc?=
 =?us-ascii?Q?9WYpcN94a4GkN70fMXC+CiBq7hcbngBLLOtUfHj2KaehYqOmbRuMxaMK5C46?=
 =?us-ascii?Q?VxDOYxvV2p93neA2EzGRnutykRqmeoO1SpOC0rnE6wIR/P4j887p+Ne5VXiQ?=
 =?us-ascii?Q?Mq3yYMvZSpJeYj7hRS15KKqcBv2W/4Yv1XWKKGGCYfWe75Sj2PX7xUHB4aUE?=
 =?us-ascii?Q?DpnKOyT1SJj+2QNjDYgOS+udB95WSmwe/nAyvB2hgkVk15vW0GCB9Yp0rLv5?=
 =?us-ascii?Q?wV9ur2b2BGsCSEjRdoCwcO5rSGr9zLOb9nTPqiRxJ/susXgyJEVbFej34lNH?=
 =?us-ascii?Q?UrQYIHMyh4v3sRallvPeUZETeeSDdH5MVeq8lwr9WJ1nj/3DfXqWxlqnxup2?=
 =?us-ascii?Q?sZPvE2/eNLTclseMbHrVgmv5ScOyk78lI5QFiVZUZ+hoBxp1UPsm/fbX09Cc?=
 =?us-ascii?Q?FpscDbJ9bhuOZukIpjv8BvVwNLU7SmZUjYVkgfxBxhozpYl/aFSnybUj0n1z?=
 =?us-ascii?Q?pSm+BKc0arJNesBSgQIxpE/sa3cJ5sh0eaD8/1gASzZHNmelrD1ZxXlzcF20?=
 =?us-ascii?Q?NlWzBNCto49zdRhHVVc7HbHWqyLn3Xjff+YOcFtDqJ7BgtPCDoL4m5aqiPR0?=
 =?us-ascii?Q?o32O+J7It9p9exgmooxRmZHnSgqvC+b097Y+lO+ukaHCMeZ1paENRhkFLcUp?=
 =?us-ascii?Q?/23EbTX5jLvMGM62HHwRTrmaym/8NCtfoRJpv/39qlvC4u3pSkl7z1YcG1Gh?=
 =?us-ascii?Q?FvT6YbRzIcjnekSRnPKz1AC9Ub5yfZzg6CT3Wx7i7yDb2D7UcfRYcC09icgT?=
 =?us-ascii?Q?XFfAP2jx0C+wG/Jfo3M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e3618c-4616-42b3-4a37-08dc85c98fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 01:39:52.6083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fLyY2e3pDebj/OQRwJsLyJGjcPZDPus/Rptq8FdXRsL3dbix8ketEtq0zK9rMqNDC+q7jQKdA6yp/XzS8tnRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786

> Subject: [PATCH 1/1] arm64: dts: imx8dxl-evk: add imx8dxl_cm4, lsio mu5,
> related memory region
>=20
> Add imx8dxl_cm4, lsio mu5 and related memory region.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> index 4ac96a0586294..c5e601b98cf8f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> @@ -24,6 +24,19 @@ chosen {
>  		stdout-path =3D &lpuart0;
>  	};
>=20
> +	imx8dxl-cm4 {
> +		compatible =3D "fsl,imx8qxp-cm4";
> +		clocks =3D <&clk_dummy>;
> +		mbox-names =3D "tx", "rx", "rxdb";
> +		mboxes =3D <&lsio_mu5 0 1 &lsio_mu5 1 1 &lsio_mu5 3 1>;
> +		memory-region =3D <&vdevbuffer>, <&vdev0vring0>,
> <&vdev0vring1>,
> +				<&vdev1vring0>, <&vdev1vring1>,
> <&rsc_table>;
> +		power-domains =3D <&pd IMX_SC_R_M4_0_PID0>, <&pd
> IMX_SC_R_M4_0_MU_1A>;
> +		fsl,resource-id =3D <IMX_SC_R_M4_0_PID0>;
> +		fsl,entry-address =3D <0x34fe0000>;
> +	};
> +
> +
>  	memory@80000000 {
>  		device_type =3D "memory";
>  		reg =3D <0x00000000 0x80000000 0 0x40000000>; @@ -51,6
> +64,37 @@ linux,cma {
>  			alloc-ranges =3D <0 0x98000000 0 0x14000000>;
>  			linux,cma-default;
>  		};
> +
> +		vdev0vring0: memory0@90000000 {
> +			reg =3D <0 0x90000000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev0vring1: memory@90008000 {
> +			reg =3D <0 0x90008000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev1vring0: memory@90010000 {
> +			reg =3D <0 0x90010000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev1vring1: memory@90018000 {
> +			reg =3D <0 0x90018000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		rsc_table: memory-rsc-table@900ff000 {
> +			reg =3D <0 0x900ff000 0 0x1000>;
> +			no-map;
> +		};
> +
> +		vdevbuffer: memory-vdevbuffer {
> +			compatible =3D "shared-dma-pool";
> +			reg =3D <0 0x90400000 0 0x100000>;
> +			no-map;
> +		};
>  	};
>=20
>  	m2_uart1_sel: regulator-m2uart1sel {
> @@ -505,6 +549,10 @@ &lpuart1 {
>  	status =3D "okay";
>  };
>=20
> +&lsio_mu5 {
> +	status =3D "okay";
> +};
> +
>  &flexcan2 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_flexcan2>;
> --
> 2.34.1
>=20


