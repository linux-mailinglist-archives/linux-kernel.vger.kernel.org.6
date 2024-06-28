Return-Path: <linux-kernel+bounces-233230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CA891B48E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8271F220E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE3411711;
	Fri, 28 Jun 2024 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zm3gI/D2"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2063.outbound.protection.outlook.com [40.107.249.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5321DDBD;
	Fri, 28 Jun 2024 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719537224; cv=fail; b=cZW1tMZ4FzDIh4LrTkEh9goxv1b1SflbkTa9KXaa2YGcSFnWYpofzH671iQ1obI8yglm7vgAQo3dL3MTen1llqW9Pg8nXNexTwg0w9yVK62YUkzKu9ayVANw4sMxFtew3RK4wpRX/IVfEY7YN5vc7Y7ey8UgaYWWsTX+FoBaFyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719537224; c=relaxed/simple;
	bh=5SRMUaevRHHV/7RvAMgalClq+08IeD7CT1vuxL9JXdM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q9XRgz0taPk3W6qhGU3gyyYHkyOD+FzdfgBHIN65TU7/zonRHSx4Z6WLfJrdGuaLOSSI7cFIpyoISljdzON2RrpY+a7zFvMiygku4zvQlbM7WSfWHdVK54JA07J4wY6IfZ6qvw+mQ0Ezq+Euea2oi9u2yPfSBWOqKiwplCWywDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zm3gI/D2; arc=fail smtp.client-ip=40.107.249.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZhVt00PK1q1OlIrd8yr1NbcQVb9NzSjMluEa4ICajOxm9h1HOvupvtB0bXXY2KEWXffBXbXm5wPGx+XMQzjt+iFccrzLDAOsep0WFYwfp58evIYn126lAowfFuOQgYNM0RZa9yjETGIjQI+vW3bY8e/6vVPjR1XhDJi/I9ef9n/9bpPeyASKD4LdsnyFSI7Ma8BQIHHoplQJKJ9WdBEC7Om2IXcGb1h83QhBEUkyM/k16pJ3pewQzSEEKp5DMsoTpombtiAMAd1GEl67eUhTwmWUfJocQ0qdS4r7dh7dtecKP0JqO37BnazFqSqAW31o01gQDyJe7iE48IO9Wr4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CR6wYfDzSmIIikoFIU+W9Iamss9SWhq+F3u49GWIVg=;
 b=ETvp5C/jsf6lACq+hUgxHpt/WuLZZU16KsZIC/QT7TQJsaPEjSekvCadKlBIzfNlXblMdZkwbUl/MTzYdk5ITjeLhHblPAn3rBhkqDApfh3JJMRgKxVky+fg41OdS8ApxZ++N0xcD7e8g577/XMkbYNK02tozH3IfaSeS/YhWxwFNuxuXrhPPWgjeCtopaIIN9mIR16M+0Td75TGpIgrlHlrupOF07UU8zV+2+wvxbu9zJ/p285p0TNlCyamAJOJ0uuzTv3ihn9myPg+cZTLNRG8Za8RFf3i/38uBElk9Y23EZAwmOTxjyfZKJHhWWLzRJmVwH+9hTs5MA3ja19L4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CR6wYfDzSmIIikoFIU+W9Iamss9SWhq+F3u49GWIVg=;
 b=Zm3gI/D2N0AUVXy4tHK1ffdI5+sAVVAnQhLXuklXcknwNqWIhclODaoOi4EFGe24ie8YkiS3IQek95UShuto/q20pA7KHufxEN0UTwgcfMUay5urm8AZlo5fvnw5JvgdouLfuZdTkgVNqFn1FIt6k2TuNZpx34mUgOUYUdtR5Ws=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PA4PR04MB7856.eurprd04.prod.outlook.com (2603:10a6:102:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 01:13:39 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 01:13:39 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "S.J. Wang" <shengjiu.wang@nxp.com>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 3/3] arm64: dts: imx8mp-evk: Add audio XCVR sound card
Thread-Topic: [PATCH v2 3/3] arm64: dts: imx8mp-evk: Add audio XCVR sound card
Thread-Index: AQHayHpr+10zgt9Nl0S0PN87Omcg8LHcX6GA
Date: Fri, 28 Jun 2024 01:13:39 +0000
Message-ID:
 <AM6PR04MB59411A2B4E63B0562BB652A288D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <1719481981-4069-1-git-send-email-shengjiu.wang@nxp.com>
 <1719481981-4069-4-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1719481981-4069-4-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PA4PR04MB7856:EE_
x-ms-office365-filtering-correlation-id: 42c51b1d-8499-4e30-466e-08dc970f8b1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+WHJKoflEtnbQxItFKgwSUQ2zqQXEwMsySLFiPnTFK3QwFEMFoq3QShz3FuS?=
 =?us-ascii?Q?sVlnKE4oIJyPYfSeDNJVLRs2JLnadXIlIC9CeU6SYHDrblWK9EjYy+Mws+J4?=
 =?us-ascii?Q?oL57mdZqsqLEnHaABluGKe0FSHQUtJ5Sntfh457TomEyI0NfdL7JLT9s8yNI?=
 =?us-ascii?Q?fHnwFXGQ91+YYlm1e/LicArCYj7+FdJGcLeoGQpY77WYM7YtlBNMV9qRbh+y?=
 =?us-ascii?Q?ryZN/LvS+PAar1axQsiAfTvL+G7UB/OsCkPgbsYiWKVTR7XxQpEcAGF4xv1B?=
 =?us-ascii?Q?4tJBZnDbl6fvSzGu6cw1TuU2KgS56MD+lsUpCCAvdYFN1TygFMG10jEw4J0d?=
 =?us-ascii?Q?AaxTyPBOah65EQEg0ep+oqD1B6UlPFNekMylN9vPNBcOxc2TS0BGZ3g/KCGD?=
 =?us-ascii?Q?MfbSy0Q7e6hwcedEb04TOHtuq/Kf4JgGoyrb462EE5dFRfMRep6Li0cAj+Cn?=
 =?us-ascii?Q?bhSCjYTbDSZfZUZiqPMhpEtZdFcIGq2Z89azMR7dKjSaRAueQUM/NpcmWh5C?=
 =?us-ascii?Q?z6oaHJFAZAGbxR8TNp3Txp/XeX7fKXrcXD4amQO3uGdottcsYlAYulqpjhIO?=
 =?us-ascii?Q?Lb482C2nIVgWQtxOZrWbDni4FPqZ1BgK1ngi7BV1aaMb/dqtOU+xs1ZNyicD?=
 =?us-ascii?Q?hHT2JQo9TZsvUbOU/3xEJJUs2UsI8Db5wupmf8cCjW0rn9uV9/uJqLDImVZY?=
 =?us-ascii?Q?8un9qfit3FChn8NZZ5XWdtt8xShkxNC/jEf3TWpttNDxk9aPPC3RvY2kl6Ur?=
 =?us-ascii?Q?XPFrs6t5Q5OWQsqAyUWNjUO9LjhN5ngV4W/6T+u1v19WzPAv6utlUPmVMMKj?=
 =?us-ascii?Q?1vS2PkUusnG+nK/wXZuinEs2AiqvoY1jOqcmE0h48jlqZqLgQol0bEwOy3Z1?=
 =?us-ascii?Q?60CqGWb5tPSBumdBcf6YJxja9+wN/ac4v/UKbOpyWrVjXvOhS6HyvtoERZiR?=
 =?us-ascii?Q?LFidCXtOlpOh9CHM92f6FCsB/mFWHwa3nDR5/nRaHSEicaDpTummAon0mXAO?=
 =?us-ascii?Q?efEAmRlBtSrFe6oaCgHpjRNDDzekfCXsTsuNcKWStJ2Vd1r+8/c6GNtK4Blq?=
 =?us-ascii?Q?MLBXlbUH+7bzkzba5kcNpPovsROVDV11FKTrU1ANwCxdM12mKE/WZYQ+rwQY?=
 =?us-ascii?Q?SkdlHMRq2550R99CkR85bHWSq38kAxJDmvE/JLRpmvjZYr510w4dqXhmQyfz?=
 =?us-ascii?Q?54p/uy1p5HL0ULzfHAmb02i6Ihg63pzlDS0HzHauhyx2KUXzc6YbPDQtCIuK?=
 =?us-ascii?Q?wQInNyB7NXGfenC98jKJKZ8hxXBd+lIlSJmA2p18Wtx385QOMKox4+5ffVEp?=
 =?us-ascii?Q?WhoGIq7Fik5EdG3aXQF1uHyfxZSNgpf9MP4gWE3W6FrCLJ75eGLOA64d2gW3?=
 =?us-ascii?Q?ZBy/4Z8kS5BkyFd9ZhLl5NQbBp7QKpvKyG7MqOQxSBjlYmVcEx+DLn1n384J?=
 =?us-ascii?Q?z2fuP3G0W8Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?H4g+n9FqcKMrc+aMfAKjXC0zmfE0Nt+0Mvaduym3HSQrnXhRhC4C7iatGSjt?=
 =?us-ascii?Q?ljcuxqOczOeDp3ZWLAHAUu/EbnOFHYfGF1h7N92AIN2jibDUMmEWcqrZrGFX?=
 =?us-ascii?Q?N7TA+21XbCfB6oQogg+uzHpXYYzepkKtg9EZIdYAavYXJMP9qHxZmYrcLa8F?=
 =?us-ascii?Q?UbscL/VGk+OZxQzL02Tf7aC46g2pGjVhTSGVzuUKL2vvm5G9QEn4zmSJL0+I?=
 =?us-ascii?Q?UAzq7su5GDNLnBMDLls97L0m+N3ks+zGTlhgg9bV3MHEnCLY9ndP2tdvVJU6?=
 =?us-ascii?Q?/Ur1FJS+n81wpQP9A5Bha8BQxCUOEcgxPQqpJgA7QhPiSyCLoPSn3ksRhtGD?=
 =?us-ascii?Q?uUurs+b85YTOs62T6VPcKkL+hf5CUlK0w2LDEBgGosCqygn2WoVWg4tqyQIe?=
 =?us-ascii?Q?PYPuo3xkISAQZYQpmyTUKalxQ3oMu0Xw7k8xviZbQtnn2q3KrLmEuOhj4iJ3?=
 =?us-ascii?Q?b8oyd541WkPCdJXzWjN7j7VmW+Ge41FYxioX5UZt/O+8MWdvRNp4K/u7zkU8?=
 =?us-ascii?Q?lap7XrW68Cai0KYocK0mb2wa+J2RcvqNcY/b5bFIC9OOfoffcwDgdr2UT2UH?=
 =?us-ascii?Q?FKzWoMWcSm8mWmQIMt3YmvuAjlqxHRn8bpyod+X7bQ95o+yTRWyPYD+2LQsc?=
 =?us-ascii?Q?tS78gaNGgGvzrQLKbA+YFTKyfx6JrXux7EMkbtrnkRs5WnDK8V4m2+/c8CIf?=
 =?us-ascii?Q?K5nZK6WdGbV9WKxZBya7ypV+Y5xXKU4fbyDM+aQB5foyU3KNlPI1YiY/3P4X?=
 =?us-ascii?Q?Hf6i2jgJtkqayHP/TpDX2+xCAVaiVQsXHSArHXu/I0sOEGh7rpcIUCzIdEBT?=
 =?us-ascii?Q?Bjh6mUDUQZJvbmH1+thQqWzdSR0UGKAiywBTpMcgwaUUjYdYeEQfYYPE4xlX?=
 =?us-ascii?Q?pVmb/xD17z4KpOj5vmJTQXHYSgPUwz6zGjOfr2eVV986/xQlieOWW7Lc+cGo?=
 =?us-ascii?Q?CJ4zfVVwp9D85uaJjP6otwhULgBsZf4gtMjx+VNCcBC1v1Aq9wYwZ86fBzNJ?=
 =?us-ascii?Q?9mGpSl/IBVTTpyL4/G1B+dsd7gRo6G16rDt7y+nEGewBg6XugvFna3+ucfnT?=
 =?us-ascii?Q?Ija0f0Gv48Z+sipT53ANFBjqgN19OXnpYZvbyLxaR54dJxOlSaEg8Tm7nrr9?=
 =?us-ascii?Q?KgEc4WJTfWNwA936fs/sPkqSRuRe7KFohL30gg8j/Ufm6Q8BfXUSHn2+zJgR?=
 =?us-ascii?Q?lEk24wu1o78BwUd77gQ/+t1lOeCVj7AAz5L2qQYxAzALwAhOm+14kPTK4446?=
 =?us-ascii?Q?IIG9Q54stCMhBhpgkeeRFkxdqMBG7CShuX3Ez7MxJbdhojJwh5R3yvRB4X7M?=
 =?us-ascii?Q?am4K9XJ8JU7h9H5UisRwpMU0TaHmpZLTTqWtyScNCfLGn1PJ5wsjY+erSVJT?=
 =?us-ascii?Q?zQethVOvd4aJQpTg5xKNP3Mn/dv3YZA7OVwFRi47pZoo/bh4vt4KTMSds5jY?=
 =?us-ascii?Q?owO0eD+r97u0ZPfvaTNFfgoTO61N2jX6BQKUh9UDI+cu0ofQ+903+u6Q1jE+?=
 =?us-ascii?Q?U590w0e+EitlrcPFOgOZLxgNLe5zQ5GqoqgbhLZF8PdbCgXFFEMfvs59+39e?=
 =?us-ascii?Q?I/sQu1VtnxKgoIUk2w8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c51b1d-8499-4e30-466e-08dc970f8b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 01:13:39.3622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfkRp04TZvhZa50aRx00mUKVhxVqE0qCbCucVuUXnnd2gQuzp8EaIziYafVlF9alNI5TYGrbeNomT72NY9E5+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7856

> Subject: [PATCH v2 3/3] arm64: dts: imx8mp-evk: Add audio XCVR
> sound card
>=20
> Add audio XCVR sound card, which supports SPDIF TX & RX, eARC RX,
> ARC RX functions.
>=20
> HDMI_HPD is shared with the HDMI module so use pinctrl_hog.
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 27
> ++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index c2c708c492c0..a64e8a6c830d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -209,6 +209,19 @@ cpu {
>  		};
>  	};
>=20
> +	sound-xcvr {
> +		compatible =3D "fsl,imx-audio-card";
> +		model =3D "imx-audio-xcvr";
> +
> +		pri-dai-link {
> +			link-name =3D "XCVR PCM";
> +
> +			cpu {
> +				sound-dai =3D <&xcvr>;
> +			};
> +		};
> +	};
> +
>  	reserved-memory {
>  		#address-cells =3D <2>;
>  		#size-cells =3D <2>;
> @@ -748,7 +761,15 @@ &wdog1 {
>  	status =3D "okay";
>  };
>=20
> +&xcvr {
> +	#sound-dai-cells =3D <0>;
> +	status =3D "okay";
> +};
> +
>  &iomuxc {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_hog>;

Could this be put under xcvr node?

Regards,
Peng.
> +
>  	pinctrl_audio_pwr_reg: audiopwrreggrp {
>  		fsl,pins =3D <
>  			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29
> 		0xd6
> @@ -838,6 +859,12 @@
> MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
>  		>;
>  	};
>=20
> +	pinctrl_hog: hoggrp {
> +		fsl,pins =3D <
> +
> 	MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD
> 	0x40000010
> +		>;
> +	};
> +
>  	pinctrl_i2c1: i2c1grp {
>  		fsl,pins =3D <
>  			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL
> 	0x400001c2
> --
> 2.34.1
>=20


