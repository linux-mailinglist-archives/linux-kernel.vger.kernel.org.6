Return-Path: <linux-kernel+bounces-278803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D2094B50B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7411C213B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7740DF78;
	Thu,  8 Aug 2024 02:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RV0fHHVh"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A881C2C8;
	Thu,  8 Aug 2024 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723084018; cv=fail; b=Wj1NBzNd6l5jr/XS9pRI8Nho7zsirumGervN18BjrtPkYSg7SgBuvGh2IjGwZNNReohNzapfkvoYdqJFRD8s5XbzLuAxbbDwjxutak7fGrpFOtOX24WA+1w3eqYxPLgCQFB0YSlTjcQrBiPpK/HHW8HYJO1ARhXeFCrQOSmj/jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723084018; c=relaxed/simple;
	bh=Vgn7uB1rv/Z/bHcLTIOw+llsdwb9qaKKO9PpXm97imU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HviFXIA2kq5hPRLB0vXMrc1Z+2bd0/rNwIPt1aboFlJ2PS/DXpSXrc/zN96i8Sh4Bv0fnSpwHIeA2CMDOIHbBleTW/ekcnq5AFFP8R8JQFUKYDCISaLdyqiX2KL1e9p5yXdWuprcJTu81vhtyN2XgVG5+FcIUioxCDhp0se8WfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RV0fHHVh; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ic3oM7ImrfhUGkCs2YcY22PaqB//yY8fsWbyvch6hhkYroGJ8C71w8BoiwcZMfPq0xz/AlCDnkbyzokOUx93dXVzNsOzRT644J7lnGXYUnEjwzKXDn1F6B7eg5A9n6QX1dJijsrVJdUKUwr2oJM/YGO3jgkDojpCT64oChP/CPsICwinQPAd5MVqg9dUrqmdfeBNGKqvIBBFn60PG0bUNuICQZEZruXRCI9fCaB6987VYiRWlYm6duQ+wdpJTubN6PZUl+IG8V8lW70e4CnX82r8c/Dh5b481DdbSM5N1scUZ93ENDWgnBJE3DmJoPXsE46HfnsLyD6kYLIcQ5EF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5e/vLxlBIucmQr/fvLWskDVO7TULVk7Z2RfH/tYYLo=;
 b=xl1ZZMFXAKbh0Rfn1scGWnMMIlwA6ts6VeW4MRXEXxAIFnibsmLvDvo5LbaQhEi1CJL3OkgizMS99I/ZAbt5+tK9D0ddMiLIHn6BWP6Orc0yrcs0MejeH6SpZx5nnosfzffN9oe8J+TaD/EXoLGf6mLQXrW043Ex55aMflx2zxKEbXK3bN8xTyCVnSkgJ2JAgMxJ/FHPhjetCu2J3oEZ0oIVsrMTfxMM/Qo+2tix4ZWgbFxMhoN+Rdq6OkBeM86FpmdeXoUAtIulwFCEMWZnCVUrTPnRN8y+SDGObKhnj/SOx6IFrN0sRtQhMCSBhou7Tgd5ERLKsRWZDBkEaE5Mdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5e/vLxlBIucmQr/fvLWskDVO7TULVk7Z2RfH/tYYLo=;
 b=RV0fHHVhnPcY7WbpXmspSb3KmPvaMYwMyy5n92b76BaNdfT/iFJNd4EYRc9liFqnEb1NIAjQh1Cc5vKKce+m/VftnvUe2NcoOl7qikBxUfoanIASsKSokcG6ULOSaEO1+KYjUjHCVHQkUqkIKOuJzWqnLWmoIyfCbSBKr8gzqOlotmw20A22+tgJrOVqTrzgbpwsOWd3Ky4osSKAYyXNS25c+hdp6OrDOYHRWUfG6pMlUgSiyZupFvfSJW5CiOCrjRdmFhD6W2atptE+OcSOib4BH2sRHDSvYh4RDlCs6mvFsrEtpExU//qpwsn2REZd8rpXjBMfyhdm6RYlSpSrKw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7858.eurprd04.prod.outlook.com (2603:10a6:20b:237::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 02:26:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 8 Aug 2024
 02:26:52 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Benjamin Hahn <B.Hahn@phytec.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"t.remmet@phytec.de" <T.remmet@phytec.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] arm64: dts: freescale: imx8mp-phyboard-pollux: Add and
 enable TPM
Thread-Topic: [PATCH v2] arm64: dts: freescale: imx8mp-phyboard-pollux: Add
 and enable TPM
Thread-Index: AQHa6N1qXqRNSouPLUGPDD56nNJnK7IcohRw
Date: Thu, 8 Aug 2024 02:26:52 +0000
Message-ID:
 <PAXPR04MB84597C283ECCE79229DF61BC88B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240807-imx8mp-tpm-v2-1-d43f1e8f70ac@phytec.de>
In-Reply-To: <20240807-imx8mp-tpm-v2-1-d43f1e8f70ac@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB7858:EE_
x-ms-office365-filtering-correlation-id: c16259e1-b359-4f0e-530c-08dcb751908c
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Nl9F+dpuY4VPjYUgODheHz5ioZX+Ekban+OuPHQktR1xMZ/JnlY/OUTh4P6f?=
 =?us-ascii?Q?ordBEVBgrYbe6OWmHMRlPiGheuwGg+rJ29MCcAKQtXnKe8FDkJ1kXBeOtvJh?=
 =?us-ascii?Q?iscGThHry3GcDwoz7GxldfYWcyi46GCjkXLD4q1wAfJIHFuZGMABx0a+otVw?=
 =?us-ascii?Q?RzqtyYO70u+C7ypJc2cNUUe0DNn5Hktej8nKV1YVfsyOjMd9HNIsEIy/pANd?=
 =?us-ascii?Q?jcUlJMI3/3i5G9pVroTTzrcyc7Ws+SGqf5bJq0nLVd8nXdIfh2eqsn+vBl2O?=
 =?us-ascii?Q?c2v0axvKM/i88ubCV6SJdOdjhZPOOiVAZ26RLzkeUkK0ategyiMGJCk0flHD?=
 =?us-ascii?Q?QwwGJ5paK73zlaQMhtGZRmONxd5oxq3dU0FnGE9EF7hnxnHJJe1V8b75TGlK?=
 =?us-ascii?Q?ZGInGEAGkj93LNIskJWm/2BO0Wmc+9pt13hmzqJI74/z5URu7nxRKBwdlxW6?=
 =?us-ascii?Q?WyKx7t+mIgflVbqYQe5EZOOh9R+qOAxxRH7eWGRGhWuinPszvi3wzaLeYSHn?=
 =?us-ascii?Q?iTVMnN8Fi9TNk1Fwjpq2OEIrAwQUAtMWgzkvzJyIc8/TaJAxhxRktpmsQm0E?=
 =?us-ascii?Q?EdT4+5PqHh3PBwS7mau0zWZmWla4zCrOkqGuZpWtwZzdfAwvR6we+rl9pJkE?=
 =?us-ascii?Q?gV00+WSlMtFQrSn2Dv60Mk0/PfuufrYQ3UetD9Q/WrAVI8vkJ+ghgyENGuY3?=
 =?us-ascii?Q?nz98nuIliFhwKo6c54lwi4YbC+liIQQgkpum/oaV2XjIP2XkL5NwOlKMttvs?=
 =?us-ascii?Q?Rbcoo8WOZe2Wk0jxsurVpfbpXn//mVv8tfr2snwlKTIs7jQlXBQhH1BYwJ1B?=
 =?us-ascii?Q?Tdzl3frC8Ow+ql4Qvf9TIRcG037PtxRyryX6IPyuDwjouALybsDPGcHEkvAi?=
 =?us-ascii?Q?f1ZFXMkEAQ6YY5lwu+suXjnCY69dUFEUBgtY7gffzOJbQHZwcICkVlseULfS?=
 =?us-ascii?Q?njrKUVeZjhQJrn/HfqlBuMJU2CcTJ06fYy3FwpY3RNhRC8wk7GKLQxBenkKA?=
 =?us-ascii?Q?Bet4qGji1hu+W/6COpEHN/mcPzE/fBMgO05Usa1yjy6m/uzsw2nAxFfqg5Mk?=
 =?us-ascii?Q?wQfLm/z1qs0ySPdmnEde4intJWii1KavWF03UoiT6OOg212oIaxFIfJWAwux?=
 =?us-ascii?Q?bdl9i3qmG6YzHgz3hfCvUdSzk++6A3qFprk728gl8K/rn0o3Q//uy5tI++oP?=
 =?us-ascii?Q?MYQ/MlBDAMXOPq1Din5kNhpap1K+7Kkkxw+llosa2vBLWXvivVzpMV991T9/?=
 =?us-ascii?Q?YWmwoqoS8cIeutl9V1nsjqRzqXH+Ancx1ksiSWdUXDI7h7zlYPppr+2pu6kT?=
 =?us-ascii?Q?Isl+vxcH+hHkr3bXQuoRLV/G+hVc5mb5RD46qwByG8L5oWT0CRiFhaIr22JI?=
 =?us-ascii?Q?AS9PneMkVMGSJV4nbhwWTRokYpMEu3UpvzPyfuBIEa/vhQjBrQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?y/3/T4dcFDRpW6ILeDsoXZRb0XqJj9JrXNC//w7BFl22UyNJtpzhNtq/S8Jm?=
 =?us-ascii?Q?TdJbpKvxDN+pYca/7Q+RdQNNewxEL/WyQWJg2iiIt7VPZptZsJyrWTWAKxbI?=
 =?us-ascii?Q?FDbOsBLxbA964iW+83ly5qML/W7W7YOOOkKFOqrGEV9EYAD2lSTD3gLumu7l?=
 =?us-ascii?Q?cOsmeQ6ecPpiHxFa866WoDTTQMNR7hkoFRMHMTlUvchuzp1GH55KM8VALmj9?=
 =?us-ascii?Q?eq/amADHWh3fgDrQgbcfnJlBuwF/yUUwcyAMidu/CR6q+ZncDasphohD8Ghw?=
 =?us-ascii?Q?gaz1nm/yR3Icnc3xCjHiKbyJq8Jjj95YUae+NZsfCVbJ8hAzy/s6OZ22Q+SV?=
 =?us-ascii?Q?HdHKCfDCzDGqEK/Ap5AFZd7iYEeWw5Lv2Y2rDetRL8iNqOZd5JsqigkiNryY?=
 =?us-ascii?Q?CcPT8r/wDgz+4KmZ8kprPYTXpwOy8RtUkmu6jbz2nLdJCQtiKMDrQIZCpqx6?=
 =?us-ascii?Q?fpyyWRJzkp+QPgrF8FAdiCLzoplsZPTmmYDvreqKf436agmye6k9H/q1ocv8?=
 =?us-ascii?Q?aV12623JYPfSmgChOzuJKUxFEgrVN8V+0rczB9eU0XZ5F/95BE+MuGmdncRb?=
 =?us-ascii?Q?vVfJIPMgz+9p9VpzFO4DYCEXzHNtVXAC0KgPz50QB7YKUU0TSsbOmqJkWKK1?=
 =?us-ascii?Q?8eGwrWCEoHA88a9V/u61GEammN6earJS+yOh7TJD17CtlrvqjD3YtuvyBYzd?=
 =?us-ascii?Q?x5RNOjNOymnvmbHXykobjsk4p7/PICkr0mCcZcCf9lFPrmdiO9cuAXpGeIeo?=
 =?us-ascii?Q?4fNVuuVOQ1w48yU3RPjpZOlgIa9lLO/8/BwFbcwCN9tOoevttJlkCDQmb4/p?=
 =?us-ascii?Q?sHr3PE3Cqx0zsVKFKhSxflUfeXkr6zGeZUqonyC86pa7kkC4P9JFY7hcD+rk?=
 =?us-ascii?Q?3AWygxaqWjfOkD9VvWvg0X9YVGOZWJhUbmbwy8NygOg0swTyuMRjgMzqFXok?=
 =?us-ascii?Q?zHuc1BPqumCvVjeZ50UBecEzyEifi6dlefWmLfRzWqRrot/1iyuRUxOWQVZg?=
 =?us-ascii?Q?n4pxcNhDJbCnViugy5rzjL9zNi6Mp1l6MX+gDy+G9QmN4Mjj+Ti4FAgZ4rVz?=
 =?us-ascii?Q?Ao/QBBeph3jD2AeMBX10kVvxN4+MvNUX8fbDmFrrZALxRxgeEmbzpxde0AL0?=
 =?us-ascii?Q?IKtkeuIUFi4cXz8YpQhqvsn/5Zn1s16bCysW0zxuwoEDt/eRpF7sipgZO6CI?=
 =?us-ascii?Q?aVVlfyjScVkdsd1gURSmRHz0GGHX0taHXV3FZ2WZEnwiyTDqL4+jOUwyUw5V?=
 =?us-ascii?Q?Y5Y7aEUxAkYs88Kmj1fdrryLtSNZpWJXFH30aNbMGgoLAZbecBigIQ4qHZ66?=
 =?us-ascii?Q?5VMhzORA1FZFXKFFqEfl847WUXB3vWuitCW+kwp1EAFQTn+DXlmazSQ0Bob8?=
 =?us-ascii?Q?2PR1E00FitF6Zs8BLcGDBpCPzQ6ZRKJXYm4BCfaFumQ+klYV9vpICzGIIYPO?=
 =?us-ascii?Q?li7lwiqb3ZYwp17AUKZPOnI7DzXW/19CEDUjb2v/LVKwUC8VjpYCaAztcvye?=
 =?us-ascii?Q?LbXLMuYNpOxfkN9DRzCHKPRjhjqh2QJog8jIElTWwJl8PDT7uG0s3zW/LWG0?=
 =?us-ascii?Q?QOrz8WnZd+5MK6cekz4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c16259e1-b359-4f0e-530c-08dcb751908c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 02:26:52.4968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ff1BjBBWnsNyLttOhw/SFx8GRowvnlJc46bj7GV5sQwZTNphTBH6JzzyFI3WlUjIgo3VGxlGFWgKqFwJJ5cqlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7858

> Subject: [PATCH v2] arm64: dts: freescale: imx8mp-phyboard-pollux:
> Add and enable TPM
>=20
> Add support for TPM for phyBOARD Pollux.
>=20
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
> Changes in v2:
> - renamed tpm node to tpm@0
> - removed num-cs
> - cleanup pinctrl
> - Link to v1:
> ---
>  .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 26
> ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-
> rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-
> rdk.dts
> index 00a240484c25..0e8200413557 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> @@ -103,6 +103,23 @@ reg_vcc_3v3_sw: regulator-vcc-3v3-sw {
>  	};
>  };
>=20
> +/* TPM */
> +&ecspi1 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;

Duplicated with imx8mp.dtsi. Other than this:
Reviewed-by: Peng Fan <peng.fan@nxp.com>

Regards,
Peng.

