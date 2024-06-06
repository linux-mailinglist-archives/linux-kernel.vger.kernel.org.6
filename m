Return-Path: <linux-kernel+bounces-203502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4312D8FDC2E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD424285661
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64FE12E5D;
	Thu,  6 Jun 2024 01:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VwFfR0NI"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2079.outbound.protection.outlook.com [40.107.249.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157EC10F7;
	Thu,  6 Jun 2024 01:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717637738; cv=fail; b=RRbQpsFfVbV4w+53nsHVFdxFX08pwIs3hH3Io0z6aQbUE2YV+xQf2CJW1F3Y9lMEAxSlDhDnV664XR5hHaNNJ/icn+vmZlwRx7dpAjEnhq7fX+DkO3PyqvPXjLnz1+e52dnpu6g6wNThl5ZYixjLcQrJ3tfuAvRS90BIRYuEBRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717637738; c=relaxed/simple;
	bh=kpZlSfTJ5S7OkgT/DpW0WjTR59u37ir8DjdRXHQb3RQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eLoDb8bsSNxg5Zf+D5l3ByOB3hzrpL0dSm5UiclW/ZUPv+A8zv/sEa06+wdt7Nvcj9viKsWFA5q6perk+xcAc/WktlMYmZJtExpUFxKvJUJSFR8AIwXDWmHrdG43DXARovzDgsG6Sxg0JsBz3WJrqdqwltXeoqUo+D0NUCckv2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VwFfR0NI; arc=fail smtp.client-ip=40.107.249.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuQ+rb9D9muAaykUZ0LOQxmt2xQGNM4THwXuI7qbcMOFsiGVgjnPVpc/Byy52syuNw0SIagCzy5+yefkJxPOYYi0EfymfTwPuk4AzbcqnWFUIsnVKx8j/h3SAA46B06TvXhPqZiSJc5NC03nyz2FtvUe6NRPOdr8cF0xYi6CcmYea7015D+NqgA6lCA2rl0QJlhmVAoSAriQvT1NGmVhQa9MpfRIjm2IpCLhzMN7jPFJuokPolMVqFDsYL2F4+qjjIw0OGy02gWexsOOolkH5UcZDpAd18++m08fWEt/W1qyIpjguHa8pzziwpagJ8RNzSjjeYUUs1v9dk7GqwzwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bka6or4ljsvZdRW8c5v8iYRwb4aOHKGKpM8nmHtEEwE=;
 b=Y4amrjeiQyhYkwpdB5R0fD1GIOPB3wgB3KY5FpftSu0qvNmoTWEo0ePXdcqZWMwleLezf0Zm1lnji8Z4rpVwLovixs8EqWGqaQwwgTvrY2Rz3DC0rhAAw0jKBqPYGJY9zL4nwk24F2+wAbymnyK2GYmRcDe6dDXAqeflqEQh8EITAprczeBpX1f8yZMzJ9tDgjWotZrwix+U7Sn31BgnrLXNrEO82Sj1BKGLhsTLD5x/9s1FyeiBLCF7/S73wKl/la6RPpxLsY3ivqEB+kbFbsyAcKuRpI7jIHfi4A/yIoiMn8h793tjf7UwxSfRPXBFeGJ7IB/vbtfW3Z9iw8WtQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bka6or4ljsvZdRW8c5v8iYRwb4aOHKGKpM8nmHtEEwE=;
 b=VwFfR0NIzKYGGYG9xYIX2DkAzL4V350vxAmQ3yMe1XebxdsSR/UcnS4wZDnT36OLK7Ce5yjEmCctTELkuZPedFmqZRIRB2YjKWU04zTL2F0gK3jSbLxBW6IVt5zyk4YPMjs0XUwB2+0H2Qn4V91FmS/3s69MqV5Wy1xBdRlPuhQ=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Thu, 6 Jun
 2024 01:35:34 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Thu, 6 Jun 2024
 01:35:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Shawn Guo
	<shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 2/3] arm64: dts: ls208xa: use defines for timer interrupts
Thread-Topic: [PATCH 2/3] arm64: dts: ls208xa: use defines for timer
 interrupts
Thread-Index: AQHat11PCxo8mkOSqUq1hmTP0k1Y37G59LcA
Date: Thu, 6 Jun 2024 01:35:34 +0000
Message-ID:
 <AM6PR04MB59416C0123F3102652DABC5A88FA2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240605153020.104717-1-krzysztof.kozlowski@linaro.org>
 <20240605153020.104717-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240605153020.104717-2-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PAXPR04MB8476:EE_
x-ms-office365-filtering-correlation-id: b864640e-00ff-4d32-2fe4-08dc85c8f5b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|1800799015|7416005|921011|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?piVAp4NK0AzGJM06qiaAq5t5eHrfuD0cFLm2qj2wvkDbd02vS85JEho9R77p?=
 =?us-ascii?Q?zBebr5/WicBML6cuDURpo5AsV04INIYiLYb/1boz956EXi1eafy/CRG/7Rc9?=
 =?us-ascii?Q?B/q+Q5Zc9QkYyfu+5ydxcnnTAWcCPzuJOXi66gvDfnYJRcROEGLmZvrFBcWC?=
 =?us-ascii?Q?dpwYAX29k6AsWSi3R64rjI+AQLINmbN8MneDxleMcb04iaD70r5+K9s8bM6p?=
 =?us-ascii?Q?Ai9FdQGg4C+3xBFGneA6p8EQ303xVtmcMcDS1xObB2VkMcrASZYXD1Y5bpMw?=
 =?us-ascii?Q?duhLxMJITA2qGh3fDDQltpIJSXMeB1zUtvmzQ3VDBVUuEUovypmxG/uHnFcE?=
 =?us-ascii?Q?UcbFLNGlqCdGlySNkNMg6grOKWkPhW6ppGpu4BvuI97oZX2CXsjgV7fwQuc6?=
 =?us-ascii?Q?g0xgqZVSL8AUy2gYBqB6hp9TcijwfVn6Bjr6vh8d9rdNlpfu8LnCkHaOW/qS?=
 =?us-ascii?Q?t0A17tXfObq345xugXyFvR+UK+TjWgHqUoSY7z3GRUTQoEenEq1Dv/V7ZlXP?=
 =?us-ascii?Q?9rTnrw2aEEwTA6+HYtVpZUtt/233jt813q/JOnupe3XtqPbqYYZkGISxw9Hm?=
 =?us-ascii?Q?ZqaFFEPGzurpI4xfYsVWUtU16h6IE/ajo5xxn5jPHdo/tEte2w5CFZxDWkCH?=
 =?us-ascii?Q?yNpQGQ5eTTKgxN5We5njzDmuT8lDzMWbpMqojhKlXQ91NR/rP1v9my/9HtFH?=
 =?us-ascii?Q?4mrQ9hUbKhfy2wNk7nCKXZHMJS9cn2w6a0pMVieVXj8GrsjU//WW/q2/fS7l?=
 =?us-ascii?Q?R1A2yzbKwYz5TejpVHko3D4l+TQJHj2qVfVkZ0BtI5/ZeF7OQFKOMOXxSUVD?=
 =?us-ascii?Q?bVy9CoIexK9CK8bYDBwU3KcK2kf7u8vhEA/v4xqHzwAgoUuMW/v5OyLs8vzE?=
 =?us-ascii?Q?6MpyIB2m/OmIJ/Ug+LJd2g7XXSiO9ouyV56Cwy4J8aUiYq0zbLP9a3lKp9XN?=
 =?us-ascii?Q?LGUGz0IZZSENoFmw1nwL0+SB/rTt+cXX1k+YbBu30KIZqU65ncB4KrwYJ6Bk?=
 =?us-ascii?Q?gvEOafREx+7iUioDa1hUFq07xV6O9AEnDOq7OnqYFD2ajMz2SeNK1f60NuOS?=
 =?us-ascii?Q?DIhm4ZRkQKyji7ToJbZctzpEDAAxBCKBL2RcwPmZdE615SvmtwpFbYWaQpDa?=
 =?us-ascii?Q?hlT2lGChUR4xIMeb3C4bgNjPqDmfUB63PHDoN7hbFpL53rEKrnQZlWhSMK6N?=
 =?us-ascii?Q?AKfgTR0ahp8WiSNQ9afduN6rlvttRv4EZXcCcQhwdZVsyC63OZ2pjHORVNBi?=
 =?us-ascii?Q?HCNCQczhJpA/MdvmoLlYYA6PZ9ZVbyg9T8r3O6M2SmFUEC+vv4V3gGWTt6nJ?=
 =?us-ascii?Q?ZG+cPBrw3wT9T09MdVOxs+SqDlW/Iy2qLN2mw4Xf8buzDnVQWYDO1GfQd9H+?=
 =?us-ascii?Q?qPVYavM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N2aAVppOfTvJ7TzN3ED7hn3hw3WrVhTHB5Yl/OyjyFmbwbbVVt2jWfJRSh8v?=
 =?us-ascii?Q?0smqictYA6vcl4JTpXRuLTTLqQMkNYPxdMy1Ku+RrmpNNL3W/GtmIwFkg9Ud?=
 =?us-ascii?Q?83Ce22pTTjAC0r5zm3arvDzlAJ7XZhb9OItbjDju7CxKqexvoktV+nhEOk9V?=
 =?us-ascii?Q?ICzD/q27+FBuCzdxskT4ehZ9m/LqyDzfGKERjqnVmqdFNZEGDB981Icfw2bK?=
 =?us-ascii?Q?OhPmHmRL/YtcqwrkTv0Sb45tdcGKH24ynAexzYIeH3NO/sqXz07t/k+8qRqk?=
 =?us-ascii?Q?9JMo6YrzG2vIIN8xIUobyH0Jy6sEGPAbgpCAjRcjFZVwe7aFxo0PnaMmj21v?=
 =?us-ascii?Q?6EYd93X/9qxBb97SMKjoyrt2tV0LPo8D9Bwe/x/DggmbrsX8r9KCgHc1Qrvn?=
 =?us-ascii?Q?xbI2ewNYnmfVq2iCbFqAgeDKKtb1lz09yneS4U4PrJNZcItPyZuwJe/kwQ8W?=
 =?us-ascii?Q?q3rzSlPlVejN9bDts0wtFpios6Pb7f/gHG1CS14m2jGxOYw+iq4UZRSJRe1b?=
 =?us-ascii?Q?sPOFFJ7K3NifwHaO1Q/I2KaL0RTaSNnmyaowhAYryYg0bMBSQGwMvg+iVoJt?=
 =?us-ascii?Q?N/Hj2KgizEjrWWU7+KxjWsWto2Q+wND7bp3CXSkpWeM4CN3zR55VHJ6lEaud?=
 =?us-ascii?Q?kzFKUnWXH66Ciu9sxc7KRJXeViBPKWo5sIlrCplwYks64bHtgF/Fa9TXcqDV?=
 =?us-ascii?Q?D+s8nxBW70375SGqJEAr4fu+PivXn1BMLZ/QlFsaP9UIpVavDEDxmgp9dGh3?=
 =?us-ascii?Q?7a0CNWGtQXE8X5Bcj5nNBbFC5wUeKQw4VEpGZ+GovkbwEwUMajX/amuDhX+V?=
 =?us-ascii?Q?MMWdmG69Q2dI3iNjZzav+kM64BmLtWA0E1YUa6X91T/7c/6zj7tYiF8lTvFp?=
 =?us-ascii?Q?4g+C7AJr4nnSV4fFPGbv+AJOiVCVnkK2vIr+divVjdEuYANuuLYHt+PaSJ3v?=
 =?us-ascii?Q?H8duvcD9tT2bh2UMvdaaUWp+az8p0LoCAYW4YkU31HDXWjwbtyfjEgWMIa/D?=
 =?us-ascii?Q?HCa/bn0DPL439bG6/dLOl7IGYaMRUlt6j8ABqpKKPGbWqw3SoMJXSTvqDS+i?=
 =?us-ascii?Q?9O34pIvDZ2RKZ2VxFMbaMw+86O2P5Kvl3pdq1J/kRZjFA4RllWNveHvfYwMM?=
 =?us-ascii?Q?wNyl83pHiinZ3yYw4rmYxjsnbw9LfioAnrAhcIvvKhsD/iY233MYrOI4905n?=
 =?us-ascii?Q?CirodR0ZuQFA/kGAZ35oNviJ5qLSTdFcAQY/gsNpmgvChHLSYiE5hShTgRLN?=
 =?us-ascii?Q?HBF2kWGdvNlTtQ42pzFcP9C/iLwxchHHQ0joOGdEg7gGa8HCm8aE+PHUGyc1?=
 =?us-ascii?Q?fhFBc4T0zOs58AuoB9cHgkDPsK3ohxvBLldtS6mtoOh0gnYBgfVWbgoI78Lw?=
 =?us-ascii?Q?FN1WWbZY7lBqDY0c+Qh2Bj5pBsfrFXwBv9syjonFPFlpaQ3s0Zko9kDfbmDT?=
 =?us-ascii?Q?XWaIqpVxFjuTkTjR2Cg8re88ZjCXgcrUpIEQKhr2s4CgowTeGVj6edpxsmyB?=
 =?us-ascii?Q?sJQ6Pd3axY/tTcrsVG1pfxHl3UUfwDfNfgh7VFyrkEoS/hk42HAAEsLYoX3V?=
 =?us-ascii?Q?6303+XBxnsi9QjtRlRU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b864640e-00ff-4d32-2fe4-08dc85c8f5b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 01:35:34.1969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QAatBDEAcNIWjsrZEzqplTFN2TMFsvLOM6Ek2oCtPQZ3MxoU1NifnxEFAWyk7RfOLqZIyx5qF/8K0O7T5dPRxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476

> Subject: [PATCH 2/3] arm64: dts: ls208xa: use defines for timer interrupt=
s
>=20
> Replace hard-coded interrupt parts (GIC, flags) with standard defines for
> readability.  No changes in resulting DTBs.  The comment was saying inter=
rupt
> was active low, but the actual used value was active high, so assume that=
 the
> code, not the comment, is correct.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index cc305e629bdc..040a48c88fab 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -241,10 +241,10 @@ map0 {
>=20
>  	timer: timer {
>  		compatible =3D "arm,armv8-timer";
> -		interrupts =3D <1 13 4>, /* Physical Secure PPI, active-low */
> -			     <1 14 4>, /* Physical Non-Secure PPI, active-low
> */
> -			     <1 11 4>, /* Virtual PPI, active-low */
> -			     <1 10 4>; /* Hypervisor PPI, active-low */
> +		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>, /* Physical
> Secure PPI */
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>, /* Physical
> Non-Secure PPI */
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>, /* Virtual
> PPI */
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>; /*
> Hypervisor PPI */
>  	};
>=20
>  	psci {
> --
> 2.43.0
>=20


