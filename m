Return-Path: <linux-kernel+bounces-203492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 538738FDC0D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290A3B21BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F51D1094E;
	Thu,  6 Jun 2024 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AspaAq4h"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2084.outbound.protection.outlook.com [40.107.249.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C110A11;
	Thu,  6 Jun 2024 01:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717636398; cv=fail; b=tUHAzuAETKN59t7EbaL/SS2RT3fnSgXgtzDTEtHrxZdY2i+7AaLVNRtHkruDP2PxWlDfAMkRgKskXoUcKlPH9cMiRb+hQebkKgmWVCFOrnEZ10K0LKn8NRxpx8eQNml9wvVs6bPUuYZdPqEY8FGsm+I6GoGFDkdQsdhgmDRYn/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717636398; c=relaxed/simple;
	bh=qxlDuTjZZxTiJSIEHsvo+uvRFZU9GTMK51xgZA5CjK8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DGcfrxWLy50h18Hr2CS8/myiTRpNwbuf3U5pz2IDGKtHfM/qKoUNDh2ZsPiadv5vAodLN/9yJaDsPdTEymULTxHJcwQQf7sfqUg/ov9uIj2sjOVRFS1H9qMEqRJP2JALWgS9rDJ3Mj1jI5w+ARN940bIWWmNpC9wAkVuF/3NFao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AspaAq4h; arc=fail smtp.client-ip=40.107.249.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mo5XSuNDBx0yc6BB3ZF55lqhEY2tdH+r84gSjupTfabGY1nJ4Jpc3lpi6p2SRAVZLfuR+iNCsqTF+loJcFOha4pvgStGuX7deU9AexrD9V0xjcLBN3EcY72mHfhGIlYiAoHeyMZIGxfNdZfT2fC0LsCZYZbJnnZIDhc5xr/iA8ZdWZJHL39FWI6NA361HDjmcdIFbrfB1NtMOEaIfDGWJghR6EjgCmOmp7jPoM0FigXWHZ02qv3K5Pv8AGpHRcR8AVgIF2NAHrJXDQ09sA+CjfUVOUw3RFp9nyDhOWE4pWTdCiNZ5i3N8YFY+BoLThdWlDAumZrBVzK/qHKZFy/S2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1mnXSox3qtlCQDFAvyatpLw9rqcauXnfO8pdg5l9Kk=;
 b=I/HqM+LdPdU834Qe4ihs86JYFVBxuAKjWNEMWx/5DK9ikrJOBSaxzbFqIpXmMWs9rvAkYM5dExSKYdDLF0s59dVhqm2LrYcYqF+OORJOhPdG+QKdGniZI3WLNCxlXPG6yehyMm0QgjgJXNz4Q1DdN4rE20ac0zBlPhE6V681o1/R9YQqcxlyMFZahH3Wmg+u21PSO6oh3yOFgUqe545x2iYjfgRwQJUK8z1i2TuBYfAgvDWLAIwNZutrH3KXR8o/tCpkFhz0AL91SjKDJUv2yahb+/E03T6bwn0HVaRb32n+i0zxAA355RTKaozayaUl/4Rw4V7GwIAvbF0xcgrkXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1mnXSox3qtlCQDFAvyatpLw9rqcauXnfO8pdg5l9Kk=;
 b=AspaAq4hMQP2wLbCUAmomTDIPo2a55UNTMIr3Serjnab2Vlsu9XOrxlG3LO8S7yuZ44vRGVsvx4BWTl4HJYCSMxuO5TE+lzJdbpbIlkpmsKE7g8o/NLDSJP3z8vL0yG37tstmAoyK1VUTsQi8ZweAqQgTh1dqyif/pA8kTrcUKk=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI1PR04MB10049.eurprd04.prod.outlook.com (2603:10a6:800:1db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Thu, 6 Jun
 2024 01:13:11 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Thu, 6 Jun 2024
 01:13:11 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Andreas Kemnade <andreas@kemnade.info>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: e60k02: fix aliases for mmc
Thread-Topic: [PATCH] ARM: dts: e60k02: fix aliases for mmc
Thread-Index: AQHatyP2pb4f5uHCtUaEY/Ay97PuPrG57vtA
Date: Thu, 6 Jun 2024 01:13:11 +0000
Message-ID:
 <AM6PR04MB5941F890A8794132C5C911CE88FA2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240605083950.134479-1-andreas@kemnade.info>
In-Reply-To: <20240605083950.134479-1-andreas@kemnade.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|VI1PR04MB10049:EE_
x-ms-office365-filtering-correlation-id: 6c1f8d03-e361-401b-f646-08dc85c5d52b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|921011|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fKGfNJz5cgWjjXJvavgOFnT/jpUBo2TOj/90a5PsCF0m9JkJ/jOjolqhXaDA?=
 =?us-ascii?Q?qm95hOIIcfkiZw1wOzIQ5tH0JyJJc0WxyAfpqbuKvnyWLhY/LkULvUpwmzod?=
 =?us-ascii?Q?1q4iaPF7z5VoGbHQ4MYDXjTl/jEJvEcnSQALxNoMUrncmJxsJXFjHf47YPCb?=
 =?us-ascii?Q?iyjbJhsRfwggBbZe3E/jtf8J81CWb9AoKW8HRtlOtTDXxFflvRRp8VcmSC6l?=
 =?us-ascii?Q?kWMUa2/5nc139czIyqyv4Ecl1GaDxwdQU/kEfRjACby/zY+Dj3b4sYUvBcVJ?=
 =?us-ascii?Q?wNTm31NF/NRQEUe8sqwLXUkYZlfH7jS3my3/E9faXnvYuvcWQqbGxUjmlqli?=
 =?us-ascii?Q?xgVe/ZYglnG4ZTCb1KbcudZWyGm8OOGmQ16zDImYx2vGDX32K2t5FHBIo5ft?=
 =?us-ascii?Q?R3J1AMjgwEBZUmb3vJtYsQh/PbXnLpXi2ruueinym+WMd3XkhdsKNn4445FQ?=
 =?us-ascii?Q?cTdmdNsx9fomZqxt/NUfQ0QYpOsvPUkso/RQltM7RTXjxsNJpfHVa0lNA9Gj?=
 =?us-ascii?Q?mI8BlDD/YubHehezN1Fy3Wa+8OxFBht22jFI7xi0B9uQTsJu6zRu26RgAYx+?=
 =?us-ascii?Q?xPP7cLKhNhW7EtdjQdGmPG64T1JXiydNk+kj41OvLZ9dTqhSan78086BDAL8?=
 =?us-ascii?Q?1GmcfV8KXOJG8un63KciqW7PrRfb+kfXLN0G43Mq0puF0sq2sXVFRbZ2JKTh?=
 =?us-ascii?Q?7pLtVy6j8WLa5fo94RpSEV0nrdGccl12FuHwt8CvdyGeWtXjMowOrnjOI0uE?=
 =?us-ascii?Q?anLCvaZ4NBwTmczlVRB57kPbkvZzpgo8mWdoBDFalWZxA4h+FiSefx58Y7kd?=
 =?us-ascii?Q?sOsEBgOXGISUsMxIozcZ8gMZNtwC1eXvkHqw6RcqpMJ9BKVExZTA1shXzIEY?=
 =?us-ascii?Q?todUF8eJC62gIbkH21x3C4XzEXx1ZQF4H2OuN3Fr8cq5v9a+oUb2WcM8NlfT?=
 =?us-ascii?Q?GSKdlTesLDmCpSKf29yAcU4jKuJ+/KUWPKpXS+js0Gq5i3SDblwpyBz3e97H?=
 =?us-ascii?Q?dcIEmGC6tWqU2EJvDUIcTZu31FxuhMMAuU/i30zFleJhb0ChlH+G6e+dSHeQ?=
 =?us-ascii?Q?F5PTsoFew0y5lIJy9Ae3pR2L9Bozt2PcOXTKTi6tCOsw+xHu4EmUE4NQXg4S?=
 =?us-ascii?Q?xP/ogALIlchSj+kppaC5TH7Wifg1q4SsJtt0L8egGj7phCrVNO92YILnAjvz?=
 =?us-ascii?Q?MNzSPym5CZc6QwmUpjRjme6QjiIf73M4hOoorVKnAcS1tYQswFGbOtjW7hf9?=
 =?us-ascii?Q?iddA3ilmNghQRxwiLbGWzmCD2iRqQhRGBah3nzyRxUt/uZDNDCLYu20ptkHi?=
 =?us-ascii?Q?20eJOP3fEXTmyEIYhO+UsvSh6SNitCTM5o8s2+89CNvXiWYQsQ+7uT9XLG4h?=
 =?us-ascii?Q?swMR/Tc13Td0eiSmFXPKAO3m0PJA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XrLxCMuct96XxVxToQQnAmY2PVC4Sqa5nrUZ5WBq4vWIQ50ZQV932824yOeW?=
 =?us-ascii?Q?XiP3oYjO5Jy5DZxRqVgAwfpUfEbjpjx4tiR5ZAE7Jw8borkDccW2j39FqsgP?=
 =?us-ascii?Q?MG/pvG8jJnSMA+xXb5KwuwPXDtmLR16jEirBcVjvK0HjJGYB4hrkB5jTRHvN?=
 =?us-ascii?Q?uJvuUolTfvgSY5K2loMxux9/5vffxjucBcJgZPELIlCyp+SDC6JO578maHKV?=
 =?us-ascii?Q?4f/OkhLR74tpugeIQErlD2T7OdYR6tRERXPmJnOqEd2IPt9QZq/3pR+tvsvC?=
 =?us-ascii?Q?JcLTIyGUAovlVurwwA1b8QS9bseqs/R3HGC1ME25JxdDBN9UFiut+l63dd7i?=
 =?us-ascii?Q?Clh8yRTHt7f6Rq+jw+fdxB4ST2RyUnQdrkgVURiUoiSCIrxXb0gOnNYBtP8w?=
 =?us-ascii?Q?xQjWcedB4qw5K5E3npTiVPBW5MFZTpbmvgV26brLlT7pY06abuFub77dftSz?=
 =?us-ascii?Q?Cyt6TifZHavaciETZ+QL9f1ZLtJoej6Okj2/L3gip8xkaKNwYFR/ZoWTKGgp?=
 =?us-ascii?Q?5UnhlcV/jyUbev3ZzbjaTwok2BtfhdkSk8TDTMyIRluuviypQ8AzSUFv4+HE?=
 =?us-ascii?Q?wogN7ecGauha8nQRptpKO3XJYtSK5kDDu2rI12xek8QeiNs2mVG3h0vjtbbK?=
 =?us-ascii?Q?+klzwx8ALUCB8n6N6po348qK2TNk3aF7FL7JFKNPSEcKkwjuF2r0Ms0dayKA?=
 =?us-ascii?Q?03X+eXzm670gcfgmwknxH7TVa45sTS1N3ksAdv57mJfkEs+LfORP5m5Ym78A?=
 =?us-ascii?Q?koQyJS/2O9CyUgKPWB6O+cp6+n4k/KACUWgRTJuoJVidMz/0gKnOhWQUJ8pj?=
 =?us-ascii?Q?udPbHxAr/UVHDG2QqZAm7eTAjZkvZ+47FAr8en713oQO9M/7cAH1t+SAq1t1?=
 =?us-ascii?Q?lRS4ikf6zmxSBiYTwgBHx4tKpnRwxFDvByCQM1LTiebXKNrOWrFC4yab3BJr?=
 =?us-ascii?Q?DWyv9OWKJU/GKxal9+mlD4tcb8G0pCHpTYJGwtPq5g5oC/tM/IBOYQADBXbn?=
 =?us-ascii?Q?IK3OApUAyOur7DOdlTThfdpnF1aGMDUSU0LbPmevn75XLvcO17PYNFnIcwIm?=
 =?us-ascii?Q?vrlzBxyhczqOojnP9gTnwGabTKZtemQNEDDbg77VGd+1uwYjkmKIpifhZH+X?=
 =?us-ascii?Q?L/nwBNOzVD/WpslC6Wn7RWI26ui04oeoQimScUwegBlylNGn4lGZURiFArP9?=
 =?us-ascii?Q?NmDd0xMRr8yOJNs3+eH8/rJb1VK+D26aNvcxv9UdEFNOBvFBlh1h8tJDq+Pw?=
 =?us-ascii?Q?JnBKdFQADfOeA21PRQyYtjFNuz18dRCaCCawHVfOwS7fUxHL7cqP+LQ9g/zd?=
 =?us-ascii?Q?uvFnjCO7W+eTo+s2KNXcQqjvT4L1tVstekPyxqu1AG5/G7wQyUQ+2rud7yrj?=
 =?us-ascii?Q?tUsJUeO6EoZTUQf4n5Aw9vW1XPvDLyyv84BNqUprwWnTTcQr59/6ZpC9FnHb?=
 =?us-ascii?Q?LRboCDNRGvIM/xWd5F5PURWZK/Si1B0os/I3DIGIAFb1h2PpUtr6ARVmg9Lp?=
 =?us-ascii?Q?lEUT56YQ+YykCh/F+W4NmdfhTeLZkyw080a9jQ6o5L4eP9xeiAk3AlDYviup?=
 =?us-ascii?Q?YhxkOZuXA2ePeVpH5GA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1f8d03-e361-401b-f646-08dc85c5d52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 01:13:11.0976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fk1MVPRaajWuIhvjvyCb0F9ry/nk/Mo54UVscvU8aNzzzg7dQUYtdFwZzPJvF62LaO18s4CxBZF8fyrYJw2dAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10049

> Subject: [PATCH] ARM: dts: e60k02: fix aliases for mmc
>=20
> Since commit fa2d0aa96941
> ("mmc: core: Allow setting slot index via device tree alias") mmc numberi=
ng
> are changed, confusing boot scripts. Fix that by adding proper aliases
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
> Well, this has lingered around a long time in my branches and probably us=
ed
> by virtually everyone using this devicetree.
>=20
>  arch/arm/boot/dts/nxp/imx/e60k02.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/nxp/imx/e60k02.dtsi
> b/arch/arm/boot/dts/nxp/imx/e60k02.dtsi
> index 13756d39fb7b..0029c12f16c8 100644
> --- a/arch/arm/boot/dts/nxp/imx/e60k02.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/e60k02.dtsi
> @@ -14,6 +14,10 @@
>  #include <dt-bindings/input/input.h>
>=20
>  / {
> +	aliases {
> +		mmc0 =3D &usdhc2;
> +		mmc1 =3D &usdhc3;
> +	};
>=20
>  	chosen {
>  		stdout-path =3D &uart1;
> --
> 2.39.2
>=20


