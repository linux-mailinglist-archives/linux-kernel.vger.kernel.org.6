Return-Path: <linux-kernel+bounces-203505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF278FDC34
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E6D1C23DF1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0164A1401B;
	Thu,  6 Jun 2024 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nDEs2rxc"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD201798C;
	Thu,  6 Jun 2024 01:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717637804; cv=fail; b=hkzMcIusfRT5VEJuW0myBO1X3/4YU+8iDClJ8AbiDUd8Yw8jTleimWoRklyKp2di2cj3zW8TTd0Js0OgguhEO9oGznkfVKWMHQFmwFjj6/ZL12Q920SggLBm/EUr1loWMCxYn37zYy3KlUHO9KRrAoUxIPYksSOnW1bmZCkA788=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717637804; c=relaxed/simple;
	bh=gp8TFH3m1uHPG4gQxNHmSxg2i7rMJE2xbOLDnZOvY9k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BHuEef1MMU5d7hipaGqJfjMCSuR0AP3M+oK68NkrrEWHBTXl6KT0MUSRqnYG93jX//HZWZv5lVQQ3VpxwZhJ8jUcgqdyKHc875GrsfRfHp9gc0TSfCYn/3vB40T3KSIQyKXmXV65Mr/M8lLqQXcSMXXI/Cz+jjdg5fynDVwg/bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nDEs2rxc; arc=fail smtp.client-ip=40.107.249.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1MX9wSn6zeNjwJUBmkXTmnkP2ug+1VrWQZ94uihwV9GwqwBRNmLHZQ9n5NmZVR0YuwNGweNUduTFmwxkUTdkH7Yk2ZNjCmxON8Sf7+cs+gCNOkT1dqjW1w5xcWRs/hGgcN2y0UUQS34OAuF4j4tkSDtKdx2jZMIxc75oP18tUoebLgWvI+NKaNADTXIOynkLB3npJsYNwZWEiWTuwdQKfmeAZ0UHJyOHhU5K7DYczeFm9xpAzbjJh+jKoOIyQzR3iZTzuRFhI9lueVjw91JHidXv29w+xlI3me00YMQxAGf1EAcBfIoEi4q6zWsrfDUe5UADeB8XKQh/fN9om7w1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jG9GUIPKYMpfAexQlfgC23EhTtFuCHAP3BVdwadhVNg=;
 b=SYdZq1KAwAwE1lznAnek/r5qUbRs7U+1iJPbiKAFVY9QG8jP1Zp2MdPb26+fNfDjs1gxblzCJhG+9zYd2Nqroa3gL3r9ua2AcMWnqEy6D4e5+TJXfw9iDanHFYAJIHflNZ9DutN0/H3jteX3psT018ngnIgswaQJwy+nfsvBdktCt5irPapOqiW7O1fZQNmFn+m5ID3ALiJO1xznCERVNHc4Ggx5Tw7erIoGUaKYwCNh8YhMsMOmyhzwKetHzdjCuFDxRTauTKwkIPLj/05ljkcGhCT7xHpSRoW0fe4nuf9qWmnmBLkLnP3r8r33si2eNaVZQRXQH/WelOnyOSyARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jG9GUIPKYMpfAexQlfgC23EhTtFuCHAP3BVdwadhVNg=;
 b=nDEs2rxclmpf8Bohpr7WupTOmryxHcTPe6fGmE/8h1lsA9RtmBSjGzF/nFf1uIO8IB8up2WWQ3g5i21dTJ8t9bGLerrgMypW4cEY15LNVxJh0trkW1oX6+CtPlVZKn8WR58mZvOagG6K3UO07CqV7caAYX7qyP6ezZcW5mZ4xJM=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Thu, 6 Jun
 2024 01:36:38 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Thu, 6 Jun 2024
 01:36:38 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Shawn Guo
	<shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 1/3] arm64: dts: freescale: use defines for interrupts
Thread-Topic: [PATCH 1/3] arm64: dts: freescale: use defines for interrupts
Thread-Index: AQHat11vkih66VawFEWwECoBg9yRQLG59ScA
Date: Thu, 6 Jun 2024 01:36:38 +0000
Message-ID:
 <AM6PR04MB594144EE748C5F61F72B63F688FA2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240605153020.104717-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240605153020.104717-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PAXPR04MB8476:EE_
x-ms-office365-filtering-correlation-id: c66f4be5-23db-43e9-8469-08dc85c91bd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|1800799015|7416005|921011|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hEBkMfFBR1/s8u104RpoYy1mgimWczDy9TZwvctrdI6mPtbx7KZkc7zeg4Fj?=
 =?us-ascii?Q?Vkw3KmSj/fYSST1u97YmUWJH8PtwgBcY6CBlI1KCZAZ56Qhm/HLbPyptlgXr?=
 =?us-ascii?Q?QmhviQgmMSyEbfBwP8d6Y4ZKRLCxbY/9AOtLECAj2MgO9tjp2k1HnI2xuMvv?=
 =?us-ascii?Q?/kNM8Xg9T2fe8WqyHR420t8dSzDUDFL4Ungfk0Lxeosbf9HI5+IPZGFRrpYb?=
 =?us-ascii?Q?WBEw9GGZCV9hDu59sPeuN4Iy1cAW0qSwgFtm1m8pgJkNNLXjI2tjkv7RWI5G?=
 =?us-ascii?Q?5N4oNNPBzVZRLWMypMxua84VLtfwbr+pcGiiUIsVBgp+S+WCc941EAzjl6W8?=
 =?us-ascii?Q?kJ3+JRjYU1x43kB+JvCM9cP9ugRkUbzEhYyqtmnETP72qXIhkJe5MgshApRZ?=
 =?us-ascii?Q?449T1F0rmCLca48ULWC5kZT8HnS+vn3JSu2bY2jCf2M8vhbpWolkuihwHeDr?=
 =?us-ascii?Q?HTfyAvBTkAdbK0JGE4x89vEHmd6YkIAgKRkcx2ABCA4FCD6OsmFlmsKb1zrD?=
 =?us-ascii?Q?wrJgXFZu/Tfje5GEo4QTDWRxhC65yuSF/Gopyk0rcpIDFlBGgDZI+prOfKiR?=
 =?us-ascii?Q?wy1ncplSIh1tFCKdlXQiNM4X2OKVPfLIHkr23b93LafBqTFhpRApMwPKZS6j?=
 =?us-ascii?Q?SjacQNyvqumy2NdKE0bhIjzVaGP83IpZS16a4MUcIGrUSUHL0imN9hQ3J7iY?=
 =?us-ascii?Q?Zfododo8CBgZIValqcbUPYz4guoryHVUk9N675q4PdnRGN+KPw3FffacB0b1?=
 =?us-ascii?Q?btrYtbuoJAbPc+i6wpJGsJKwjCaTIuN+nzhOImPDdWKgLJ7ahLPstBo5RIF7?=
 =?us-ascii?Q?qcoOZ61fQiio1pcmUEnrlbc9iWxBjaI7TYoCWl9nHO1u8Jqgy6Bfo94GnAVh?=
 =?us-ascii?Q?fKcMqxza+oXCwVrJaMiCch0rCI0Gq/iddMIwjPav9S8JS4zkfV2UD0TFA1do?=
 =?us-ascii?Q?wwk5VJ7GvewVJbidhdWGwOi2jHVwvT/+36U1nksVUBhDp6SEGh4Hp+CzBdGU?=
 =?us-ascii?Q?o9xxK8itMGyxI9rFoc4XTFkq7wNX7UmqpUKZ1f7eJ3h+HuxaueOzL6EFyWPt?=
 =?us-ascii?Q?Ldfasbp157O3IrgXp6N6sKq3uKVERqTXE2vUxjuon8F6fBTTo7st0iepgwgq?=
 =?us-ascii?Q?4I7vK9Xjv8DD37+Sio8wpWZfQ7H/dtfhKqC9FG+ZD5JOvv9+eQLamNmM7jgc?=
 =?us-ascii?Q?AkIX/2DmnDzd6a4tLRzDZYNMNR2z7Bm1O+ccYQjIH9iPfUUOuK+GvzV41jw7?=
 =?us-ascii?Q?m26PTkY2rPBh/jiEp9vaQAhlUdMPAD4iQxABF8xHW6wQojcKtS+mse0u5yXD?=
 =?us-ascii?Q?vI+8KcwLyiY5kFlDknRfAox1PCvndL7RiIzbnq0jganIVPujE3L5zPhzmV1g?=
 =?us-ascii?Q?Rv26vDI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DfYSxD8AMvHudXeyy0XWl4OcmfY7IkSKGkr6PQtX3UJBBOrIOplbi/AwY2Hs?=
 =?us-ascii?Q?4pdr/0mkARvLJ6FmRK5Hfz2hJKhTcJUN1ccPbyjfDFthvjGt0jhXFoCRXjoR?=
 =?us-ascii?Q?QvKOe1dLgryQLlfikEEOIJiGQPSAvPQ2yESQ6I2je5HyRWKjTJVChv5oct9c?=
 =?us-ascii?Q?14RZZ2QwFtogSIun7DBcitysavbValFh8Hpk9wT0oGFGrajsqNpwIoktJ7Bs?=
 =?us-ascii?Q?bqZGN7pOCVDMRDdALX4qL1s4ZSqNQw8h3ZvNB/GDjflvgeWoR7O0dokyDpSm?=
 =?us-ascii?Q?Fy1Wtu/K5kgKwcmvxGqnaCB5WAf82fLBNWR1iBZaMf7wFwAkOGY5+jhSW5ot?=
 =?us-ascii?Q?IpN1LjXqA0VOGhFFix/dSUgUaZ/uNYsO+tLXt2yCYSOJ88C1DKfumh1lgMQv?=
 =?us-ascii?Q?tz/uPw4CG5rs8wTD1H79U4SurorNvsEFQHzXd4DrmLOUE6Ud2Z8F/aHj/LU0?=
 =?us-ascii?Q?+ku49dgHT7fcWxEbByJvneRUIXy0pU66F7wAAT0UBjAI9eb3u/0YhB5OVa0u?=
 =?us-ascii?Q?SCsDR85Skvb2q3WjI4FzatPjcKurJZktLlY4SiWZvJS583XWI0q08JBpRxEV?=
 =?us-ascii?Q?p2RCYDS4DHpjWH/3+7/6p5J5kyUs3fypvuF6j6MHE+vkHPT3jMVoAfw39xLf?=
 =?us-ascii?Q?AfnHJHUoRgrCyFs3WOAoGa9j2MiVTA73LK4ppAwMEI9P85n0yDSpgFdMhbtd?=
 =?us-ascii?Q?7NJK/BtJ2AopcI2b2sXhJqS2TA04aoZu/Dd5S9KT507JiM3xUeT/398NOX6B?=
 =?us-ascii?Q?agalY+mgzIWSJbL59lrogzBI3oTB49KVz8QY8lDNBHcxQZllEuwVc3olKlLJ?=
 =?us-ascii?Q?a8iUDzCPqS3vZl0sGZvx0BSKFYYNiywXdVIpWxqLZeSltCorMnghcZcFWL4c?=
 =?us-ascii?Q?3JpVNFmZC4ULyB5bsJdzjgiwz/4/xLpspvP5b2mUJu9hhE/HB+VURXP4BoCR?=
 =?us-ascii?Q?/1SDT/3zIhdwj1Mw9l8cyZDgEQUYH6K5zXTqnfUYQWxE/VlavMl3bTj6IQJl?=
 =?us-ascii?Q?fgi7cpO5zKHTfwrJUq+6gQhr38+PTCMem0sDpFg+znjdxwSnMWKwd00r6Zte?=
 =?us-ascii?Q?ZCUXbgPMMvDQ2zsF3aGBPjMFa5RdGIHqXM02RuhM4q6o3zjJ02zhybXwrMWM?=
 =?us-ascii?Q?WbOLOAEvjTF1GFKpsGxSVl3ulEhd+RwV8P6tUNTvoh01VXovPQTPDqJeT7sf?=
 =?us-ascii?Q?xktSgraAoQKYAIdLnkpmAx27xFrYHc374POSXZhb/qcPM+gGsJv65y+I+Suo?=
 =?us-ascii?Q?0Jhk8vUVxPLGFhWaRz5l+tDuAiOEF8hxG54AALw1txok8B7H1P7YIBl5mwsS?=
 =?us-ascii?Q?nm2wqAskyEMi3beIKahncj9FirExvDoeKao7Yx8IPg/mRPBOqzMi/b9u3wON?=
 =?us-ascii?Q?k5Gc0s+J1uC/OKhXPwl6C5qRa9FLPfifSyvN/Dg2iRSMCX4G7QsgF2YmL5GW?=
 =?us-ascii?Q?YWLetpiGg7HRjLV5WPp0a7sipWKGjUpwfn8WLB8yD+RZtgrD32kZlZq3sWMS?=
 =?us-ascii?Q?5/aV6VZa1n+1MDR6Egs0DBIXjlb5S7JhgYqiaitFsS4VkMZytjdr9qhreVRv?=
 =?us-ascii?Q?VQeItv8FtP/opKtvBnE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c66f4be5-23db-43e9-8469-08dc85c91bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 01:36:38.1475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Y/ZHIcE+Ael9iq2/Y9lAXU5QPl48IxHpxWWljShGpawfBSBR1CSmXJzt+EjX5c03NU0mYkpFCJfCCwgcWXSfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476

> Subject: [PATCH 1/3] arm64: dts: freescale: use defines for interrupts
>=20
> Replace hard-coded interrupt parts (GIC, flags) with standard defines for
> readability.  No changes in resulting DTBs.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |  54 +++----
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   6 +-
>  .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 108 +++++++-------
>  .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   2 +-
>  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  48 +++----
>  .../arm64/boot/dts/freescale/fsl-ls2080a.dtsi |   2 +-
>  .../arm64/boot/dts/freescale/fsl-ls2088a.dtsi |   2 +-
>  .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 136 +++++++++---------
>  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   4 +-
>  9 files changed, 181 insertions(+), 181 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> index a0f7bbd691a0..cfb77a76a240 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -74,15 +74,15 @@ coreclk: coreclk {
>=20
>  	timer {
>  		compatible =3D "arm,armv8-timer";
> -		interrupts =3D <1 13 IRQ_TYPE_LEVEL_LOW>,/* Physical Secure
> PPI */
> -			     <1 14 IRQ_TYPE_LEVEL_LOW>,/* Physical Non-
> Secure PPI */
> -			     <1 11 IRQ_TYPE_LEVEL_LOW>,/* Virtual PPI */
> -			     <1 10 IRQ_TYPE_LEVEL_LOW>;/* Hypervisor PPI
> */
> +		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,/* Physical
> Secure PPI */
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,/* Physical
> Non-Secure PPI */
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,/* Virtual
> PPI */
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;/*
> Hypervisor PPI */
>  	};
>=20
>  	pmu {
>  		compatible =3D "arm,cortex-a53-pmu";
> -		interrupts =3D <0 106 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts =3D <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>=20
>  	gic: interrupt-controller@1400000 {
> @@ -93,7 +93,7 @@ gic: interrupt-controller@1400000 {
>  		      <0x0 0x1402000 0 0x2000>, /* GICC */
>  		      <0x0 0x1404000 0 0x2000>, /* GICH */
>  		      <0x0 0x1406000 0 0x2000>; /* GICV */
> -		interrupts =3D <1 9 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
>  	};
>=20
>  	reboot {
> @@ -159,7 +159,7 @@ QORIQ_CLK_PLL_DIV(1)>,
>  		esdhc0: esdhc@1560000 {
>  			compatible =3D "fsl,ls1012a-esdhc", "fsl,esdhc";
>  			reg =3D <0x0 0x1560000 0x0 0x10000>;
> -			interrupts =3D <0 62 0x4>;
> +			interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  			voltage-ranges =3D <1800 1800 3300 3300>; @@ -
> 178,7 +178,7 @@ scfg: scfg@1570000 {
>  		esdhc1: esdhc@1580000 {
>  			compatible =3D "fsl,ls1012a-esdhc", "fsl,esdhc";
>  			reg =3D <0x0 0x1580000 0x0 0x10000>;
> -			interrupts =3D <0 65 0x4>;
> +			interrupts =3D <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  			voltage-ranges =3D <1800 1800 3300 3300>; @@ -
> 305,7 +305,7 @@ clockgen: clocking@1ee1000 {
>  		tmu: tmu@1f00000 {
>  			compatible =3D "fsl,qoriq-tmu";
>  			reg =3D <0x0 0x1f00000 0x0 0x10000>;
> -			interrupts =3D <0 33 0x4>;
> +			interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>  			fsl,tmu-range =3D <0xb0000 0x9002a 0x6004c
> 0x60062>;
>  			fsl,tmu-calibration =3D
>  					<0x00000000 0x00000025>,
> @@ -355,7 +355,7 @@ i2c0: i2c@2180000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2180000 0x0 0x10000>;
> -			interrupts =3D <0 56 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
>  			scl-gpios =3D <&gpio0 2 0>;
> @@ -367,7 +367,7 @@ i2c1: i2c@2190000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2190000 0x0 0x10000>;
> -			interrupts =3D <0 57 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
>  			scl-gpios =3D <&gpio0 13 0>;
> @@ -379,7 +379,7 @@ dspi: spi@2100000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2100000 0x0 0x10000>;
> -			interrupts =3D <0 64 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names =3D "dspi";
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
> @@ -391,7 +391,7 @@ dspi: spi@2100000 {
>  		duart0: serial@21c0500 {
>  			compatible =3D "fsl,ns16550", "ns16550a";
>  			reg =3D <0x00 0x21c0500 0x0 0x100>;
> -			interrupts =3D <0 54 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  			status =3D "disabled";
> @@ -400,7 +400,7 @@ duart0: serial@21c0500 {
>  		duart1: serial@21c0600 {
>  			compatible =3D "fsl,ns16550", "ns16550a";
>  			reg =3D <0x00 0x21c0600 0x0 0x100>;
> -			interrupts =3D <0 54 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  			status =3D "disabled";
> @@ -409,7 +409,7 @@ duart1: serial@21c0600 {
>  		gpio0: gpio@2300000 {
>  			compatible =3D "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2300000 0x0 0x10000>;
> -			interrupts =3D <0 66 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  			interrupt-controller;
> @@ -419,7 +419,7 @@ gpio0: gpio@2300000 {
>  		gpio1: gpio@2310000 {
>  			compatible =3D "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2310000 0x0 0x10000>;
> -			interrupts =3D <0 67 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  			interrupt-controller;
> @@ -430,7 +430,7 @@ wdog0: watchdog@2ad0000 {
>  			compatible =3D "fsl,ls1012a-wdt",
>  				     "fsl,imx21-wdt";
>  			reg =3D <0x0 0x2ad0000 0x0 0x10000>;
> -			interrupts =3D <0 83 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> QORIQ_CLK_PLL_DIV(1)>;
>  			big-endian;
>  		};
> @@ -439,7 +439,7 @@ sai1: sai@2b50000 {
>  			#sound-dai-cells =3D <0>;
>  			compatible =3D "fsl,vf610-sai";
>  			reg =3D <0x0 0x2b50000 0x0 0x10000>;
> -			interrupts =3D <0 148 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>,
>  				 <&clockgen QORIQ_CLK_PLATFORM_PLL
> @@ -459,7 +459,7 @@ sai2: sai@2b60000 {
>  			#sound-dai-cells =3D <0>;
>  			compatible =3D "fsl,vf610-sai";
>  			reg =3D <0x0 0x2b60000 0x0 0x10000>;
> -			interrupts =3D <0 149 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>,
>  				 <&clockgen QORIQ_CLK_PLATFORM_PLL
> @@ -481,8 +481,8 @@ edma0: dma-controller@2c00000 {
>  			reg =3D <0x0 0x2c00000 0x0 0x10000>,
>  			      <0x0 0x2c10000 0x0 0x10000>,
>  			      <0x0 0x2c20000 0x0 0x10000>;
> -			interrupts =3D <0 103 IRQ_TYPE_LEVEL_HIGH>,
> -				     <0 103 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "edma-tx", "edma-err";
>  			dma-channels =3D <32>;
>  			big-endian;
> @@ -496,7 +496,7 @@ QORIQ_CLK_PLL_DIV(4)>,
>  		usb0: usb@2f00000 {
>  			compatible =3D "snps,dwc3";
>  			reg =3D <0x0 0x2f00000 0x0 0x10000>;
> -			interrupts =3D <0 60 0x4>;
> +			interrupts =3D <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
>  			dr_mode =3D "host";
>  			snps,quirk-frame-length-adjustment =3D <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> @@ -509,7 +509,7 @@ sata: sata@3200000 {
>  			reg =3D <0x0 0x3200000 0x0 0x10000>,
>  				<0x0 0x20140520 0x0 0x4>;
>  			reg-names =3D "ahci", "sata-ecc";
> -			interrupts =3D <0 69 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  			dma-coherent;
> @@ -519,7 +519,7 @@ sata: sata@3200000 {
>  		usb1: usb@8600000 {
>  			compatible =3D "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
>  			reg =3D <0x0 0x8600000 0x0 0x1000>;
> -			interrupts =3D <0 139 0x4>;
> +			interrupts =3D <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
>  			dr_mode =3D "host";
>  			phy_type =3D "ulpi";
>  		};
> @@ -528,7 +528,7 @@ msi: msi-controller1@1572000 {
>  			compatible =3D "fsl,ls1012a-msi";
>  			reg =3D <0x0 0x1572000 0x0 0x8>;
>  			msi-controller;
> -			interrupts =3D <0 126 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>=20
>  		pcie1: pcie@3400000 {
> @@ -536,8 +536,8 @@ pcie1: pcie@3400000 {
>  			reg =3D <0x00 0x03400000 0x0 0x00100000>, /*
> controller registers */
>  			      <0x40 0x00000000 0x0 0x00002000>; /*
> configuration space */
>  			reg-names =3D "regs", "config";
> -			interrupts =3D <0 118 0x4>, /* controller interrupt */
> -				     <0 117 0x4>; /* PME interrupt */
> +			interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> /* controller interrupt */
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> /* PME interrupt */
>  			interrupt-names =3D "aer", "pme";
>  			#address-cells =3D <3>;
>  			#size-cells =3D <2>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 70b8731029c4..18aa02a0ebff 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -859,8 +859,8 @@ QORIQ_CLK_PLL_DIV(16)>,
>  		malidp0: display@f080000 {
>  			compatible =3D "arm,mali-dp500";
>  			reg =3D <0x0 0xf080000 0x0 0x10000>;
> -			interrupts =3D <0 222 IRQ_TYPE_LEVEL_HIGH>,
> -				     <0 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "DE", "SE";
>  			clocks =3D <&dpclk>,
>  				 <&clockgen QORIQ_CLK_HWACCEL 2>,
> @@ -1024,7 +1024,7 @@ dpclk: clock-controller@f1f0000 {
>  		tmu: tmu@1f80000 {
>  			compatible =3D "fsl,qoriq-tmu";
>  			reg =3D <0x0 0x1f80000 0x0 0x10000>;
> -			interrupts =3D <0 23 0x4>;
> +			interrupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>  			fsl,tmu-range =3D <0xb0000 0xa0026 0x80048
> 0x70061>;
>  			fsl,tmu-calibration =3D
>  					<0x00000000 0x00000024>,
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 8ee6d8c0ef61..1f5ae061e7e3 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -268,19 +268,19 @@ sec-crit {
>=20
>  	timer {
>  		compatible =3D "arm,armv8-timer";
> -		interrupts =3D <1 13 0xf08>, /* Physical Secure PPI */
> -			     <1 14 0xf08>, /* Physical Non-Secure PPI */
> -			     <1 11 0xf08>, /* Virtual PPI */
> -			     <1 10 0xf08>; /* Hypervisor PPI */
> +		interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
> IRQ_TYPE_LEVEL_LOW)>;
>  		fsl,erratum-a008585;
>  	};
>=20
>  	pmu {
>  		compatible =3D "arm,cortex-a53-pmu";
> -		interrupts =3D <0 106 0x4>,
> -			     <0 107 0x4>,
> -			     <0 95 0x4>,
> -			     <0 97 0x4>;
> +		interrupts =3D <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-affinity =3D <&cpu0>,
>  				     <&cpu1>,
>  				     <&cpu2>,
> @@ -295,7 +295,7 @@ gic: interrupt-controller@1400000 {
>  		      <0x0 0x1402000 0 0x2000>, /* GICC */
>  		      <0x0 0x1404000 0 0x2000>, /* GICH */
>  		      <0x0 0x1406000 0 0x2000>; /* GICV */
> -		interrupts =3D <1 9 0xf08>;
> +		interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
> +IRQ_TYPE_LEVEL_LOW)>;
>  	};
>=20
>  	soc: soc {
> @@ -352,7 +352,7 @@ crypto: crypto@1700000 {
>  			#size-cells =3D <1>;
>  			ranges =3D <0x0 0x00 0x1700000 0x100000>;
>  			reg =3D <0x00 0x1700000 0x0 0x100000>;
> -			interrupts =3D <0 75 0x4>;
> +			interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>  			dma-coherent;
>=20
>  			sec_jr0: jr@10000 {
> @@ -360,7 +360,7 @@ sec_jr0: jr@10000 {
>  					     "fsl,sec-v5.0-job-ring",
>  					     "fsl,sec-v4.0-job-ring";
>  				reg =3D <0x10000 0x10000>;
> -				interrupts =3D <0 71 0x4>;
> +				interrupts =3D <GIC_SPI 71
> IRQ_TYPE_LEVEL_HIGH>;
>  			};
>=20
>  			sec_jr1: jr@20000 {
> @@ -368,7 +368,7 @@ sec_jr1: jr@20000 {
>  					     "fsl,sec-v5.0-job-ring",
>  					     "fsl,sec-v4.0-job-ring";
>  				reg =3D <0x20000 0x10000>;
> -				interrupts =3D <0 72 0x4>;
> +				interrupts =3D <GIC_SPI 72
> IRQ_TYPE_LEVEL_HIGH>;
>  			};
>=20
>  			sec_jr2: jr@30000 {
> @@ -376,7 +376,7 @@ sec_jr2: jr@30000 {
>  					     "fsl,sec-v5.0-job-ring",
>  					     "fsl,sec-v4.0-job-ring";
>  				reg =3D <0x30000 0x10000>;
> -				interrupts =3D <0 73 0x4>;
> +				interrupts =3D <GIC_SPI 73
> IRQ_TYPE_LEVEL_HIGH>;
>  			};
>=20
>  			sec_jr3: jr@40000 {
> @@ -384,7 +384,7 @@ sec_jr3: jr@40000 {
>  					     "fsl,sec-v5.0-job-ring",
>  					     "fsl,sec-v4.0-job-ring";
>  				reg =3D <0x40000 0x10000>;
> -				interrupts =3D <0 74 0x4>;
> +				interrupts =3D <GIC_SPI 74
> IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  		};
>=20
> @@ -405,7 +405,7 @@ dcfg: dcfg@1ee0000 {
>  		ifc: memory-controller@1530000 {
>  			compatible =3D "fsl,ifc";
>  			reg =3D <0x0 0x1530000 0x0 0x10000>;
> -			interrupts =3D <0 43 0x4>;
> +			interrupts =3D <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>=20
>  		qspi: spi@1550000 {
> @@ -415,7 +415,7 @@ qspi: spi@1550000 {
>  			reg =3D <0x0 0x1550000 0x0 0x10000>,
>  				<0x0 0x40000000 0x0 0x4000000>;
>  			reg-names =3D "QuadSPI", "QuadSPI-memory";
> -			interrupts =3D <0 99 0x4>;
> +			interrupts =3D <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names =3D "qspi_en", "qspi";
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>,
> @@ -427,7 +427,7 @@ QORIQ_CLK_PLL_DIV(1)>,
>  		esdhc: esdhc@1560000 {
>  			compatible =3D "fsl,ls1043a-esdhc", "fsl,esdhc";
>  			reg =3D <0x0 0x1560000 0x0 0x10000>;
> -			interrupts =3D <0 62 0x4>;
> +			interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-frequency =3D <0>;
>  			voltage-ranges =3D <1800 1800 3300 3300>;
>  			sdhci,auto-cmd12;
> @@ -438,14 +438,14 @@ esdhc: esdhc@1560000 {
>  		ddr: memory-controller@1080000 {
>  			compatible =3D "fsl,qoriq-memory-controller";
>  			reg =3D <0x0 0x1080000 0x0 0x1000>;
> -			interrupts =3D <0 144 0x4>;
> +			interrupts =3D <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
>  			big-endian;
>  		};
>=20
>  		tmu: tmu@1f00000 {
>  			compatible =3D "fsl,qoriq-tmu";
>  			reg =3D <0x0 0x1f00000 0x0 0x10000>;
> -			interrupts =3D <0 33 0x4>;
> +			interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>  			fsl,tmu-range =3D <0xb0000 0x9002a 0x6004c
> 0x70062>;
>  			fsl,tmu-calibration =3D
>  					<0x00000000 0x00000023>,
> @@ -518,7 +518,7 @@ dspi0: spi@2100000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2100000 0x0 0x10000>;
> -			interrupts =3D <0 64 0x4>;
> +			interrupts =3D <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names =3D "dspi";
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
> @@ -532,7 +532,7 @@ i2c0: i2c@2180000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2180000 0x0 0x10000>;
> -			interrupts =3D <0 56 0x4>;
> +			interrupts =3D <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names =3D "i2c";
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
> @@ -547,7 +547,7 @@ i2c1: i2c@2190000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2190000 0x0 0x10000>;
> -			interrupts =3D <0 57 0x4>;
> +			interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names =3D "i2c";
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
> @@ -560,7 +560,7 @@ i2c2: i2c@21a0000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x21a0000 0x0 0x10000>;
> -			interrupts =3D <0 58 0x4>;
> +			interrupts =3D <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names =3D "i2c";
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
> @@ -573,7 +573,7 @@ i2c3: i2c@21b0000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x21b0000 0x0 0x10000>;
> -			interrupts =3D <0 59 0x4>;
> +			interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names =3D "i2c";
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
> @@ -584,7 +584,7 @@ i2c3: i2c@21b0000 {
>  		duart0: serial@21c0500 {
>  			compatible =3D "fsl,ns16550", "ns16550a";
>  			reg =3D <0x00 0x21c0500 0x0 0x100>;
> -			interrupts =3D <0 54 0x4>;
> +			interrupts =3D <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  		};
> @@ -592,7 +592,7 @@ duart0: serial@21c0500 {
>  		duart1: serial@21c0600 {
>  			compatible =3D "fsl,ns16550", "ns16550a";
>  			reg =3D <0x00 0x21c0600 0x0 0x100>;
> -			interrupts =3D <0 54 0x4>;
> +			interrupts =3D <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  		};
> @@ -600,7 +600,7 @@ duart1: serial@21c0600 {
>  		duart2: serial@21d0500 {
>  			compatible =3D "fsl,ns16550", "ns16550a";
>  			reg =3D <0x0 0x21d0500 0x0 0x100>;
> -			interrupts =3D <0 55 0x4>;
> +			interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  		};
> @@ -608,7 +608,7 @@ duart2: serial@21d0500 {
>  		duart3: serial@21d0600 {
>  			compatible =3D "fsl,ns16550", "ns16550a";
>  			reg =3D <0x0 0x21d0600 0x0 0x100>;
> -			interrupts =3D <0 55 0x4>;
> +			interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  		};
> @@ -616,7 +616,7 @@ duart3: serial@21d0600 {
>  		gpio1: gpio@2300000 {
>  			compatible =3D "fsl,ls1043a-gpio", "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2300000 0x0 0x10000>;
> -			interrupts =3D <0 66 0x4>;
> +			interrupts =3D <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  			interrupt-controller;
> @@ -626,7 +626,7 @@ gpio1: gpio@2300000 {
>  		gpio2: gpio@2310000 {
>  			compatible =3D "fsl,ls1043a-gpio", "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2310000 0x0 0x10000>;
> -			interrupts =3D <0 67 0x4>;
> +			interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  			interrupt-controller;
> @@ -636,7 +636,7 @@ gpio2: gpio@2310000 {
>  		gpio3: gpio@2320000 {
>  			compatible =3D "fsl,ls1043a-gpio", "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2320000 0x0 0x10000>;
> -			interrupts =3D <0 68 0x4>;
> +			interrupts =3D <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  			interrupt-controller;
> @@ -646,7 +646,7 @@ gpio3: gpio@2320000 {
>  		gpio4: gpio@2330000 {
>  			compatible =3D "fsl,ls1043a-gpio", "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2330000 0x0 0x10000>;
> -			interrupts =3D <0 134 0x4>;
> +			interrupts =3D <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
>  			interrupt-controller;
> @@ -721,7 +721,7 @@ data-only@0 {
>  		lpuart0: serial@2950000 {
>  			compatible =3D "fsl,ls1021a-lpuart";
>  			reg =3D <0x0 0x2950000 0x0 0x1000>;
> -			interrupts =3D <0 48 0x4>;
> +			interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_SYSCLK 0>;
>  			clock-names =3D "ipg";
>  			status =3D "disabled";
> @@ -730,7 +730,7 @@ lpuart0: serial@2950000 {
>  		lpuart1: serial@2960000 {
>  			compatible =3D "fsl,ls1021a-lpuart";
>  			reg =3D <0x0 0x2960000 0x0 0x1000>;
> -			interrupts =3D <0 49 0x4>;
> +			interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  			clock-names =3D "ipg";
> @@ -740,7 +740,7 @@ lpuart1: serial@2960000 {
>  		lpuart2: serial@2970000 {
>  			compatible =3D "fsl,ls1021a-lpuart";
>  			reg =3D <0x0 0x2970000 0x0 0x1000>;
> -			interrupts =3D <0 50 0x4>;
> +			interrupts =3D <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  			clock-names =3D "ipg";
> @@ -750,7 +750,7 @@ lpuart2: serial@2970000 {
>  		lpuart3: serial@2980000 {
>  			compatible =3D "fsl,ls1021a-lpuart";
>  			reg =3D <0x0 0x2980000 0x0 0x1000>;
> -			interrupts =3D <0 51 0x4>;
> +			interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  			clock-names =3D "ipg";
> @@ -760,7 +760,7 @@ lpuart3: serial@2980000 {
>  		lpuart4: serial@2990000 {
>  			compatible =3D "fsl,ls1021a-lpuart";
>  			reg =3D <0x0 0x2990000 0x0 0x1000>;
> -			interrupts =3D <0 52 0x4>;
> +			interrupts =3D <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  			clock-names =3D "ipg";
> @@ -770,7 +770,7 @@ lpuart4: serial@2990000 {
>  		lpuart5: serial@29a0000 {
>  			compatible =3D "fsl,ls1021a-lpuart";
>  			reg =3D <0x0 0x29a0000 0x0 0x1000>;
> -			interrupts =3D <0 53 0x4>;
> +			interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  			clock-names =3D "ipg";
> @@ -780,7 +780,7 @@ lpuart5: serial@29a0000 {
>  		wdog0: watchdog@2ad0000 {
>  			compatible =3D "fsl,ls1043a-wdt", "fsl,imx21-wdt";
>  			reg =3D <0x0 0x2ad0000 0x0 0x10000>;
> -			interrupts =3D <0 83 0x4>;
> +			interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  			clock-names =3D "wdog";
> @@ -793,8 +793,8 @@ edma0: dma-controller@2c00000 {
>  			reg =3D <0x0 0x2c00000 0x0 0x10000>,
>  			      <0x0 0x2c10000 0x0 0x10000>,
>  			      <0x0 0x2c20000 0x0 0x10000>;
> -			interrupts =3D <0 103 0x4>,
> -				     <0 103 0x4>;
> +			interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "edma-tx", "edma-err";
>  			dma-channels =3D <32>;
>  			big-endian;
> @@ -815,7 +815,7 @@ aux_bus: aux_bus {
>  			usb0: usb@2f00000 {
>  				compatible =3D "snps,dwc3";
>  				reg =3D <0x0 0x2f00000 0x0 0x10000>;
> -				interrupts =3D <0 60 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts =3D <GIC_SPI 60
> IRQ_TYPE_LEVEL_HIGH>;
>  				dr_mode =3D "host";
>  				snps,quirk-frame-length-adjustment =3D
> <0x20>;
>  				snps,dis_rxdet_inp3_quirk;
> @@ -827,7 +827,7 @@ usb0: usb@2f00000 {
>  			usb1: usb@3000000 {
>  				compatible =3D "snps,dwc3";
>  				reg =3D <0x0 0x3000000 0x0 0x10000>;
> -				interrupts =3D <0 61 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts =3D <GIC_SPI 61
> IRQ_TYPE_LEVEL_HIGH>;
>  				dr_mode =3D "host";
>  				snps,quirk-frame-length-adjustment =3D
> <0x20>;
>  				snps,dis_rxdet_inp3_quirk;
> @@ -839,7 +839,7 @@ usb1: usb@3000000 {
>  			usb2: usb@3100000 {
>  				compatible =3D "snps,dwc3";
>  				reg =3D <0x0 0x3100000 0x0 0x10000>;
> -				interrupts =3D <0 63 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts =3D <GIC_SPI 63
> IRQ_TYPE_LEVEL_HIGH>;
>  				dr_mode =3D "host";
>  				snps,quirk-frame-length-adjustment =3D
> <0x20>;
>  				snps,dis_rxdet_inp3_quirk;
> @@ -853,7 +853,7 @@ sata: sata@3200000 {
>  				reg =3D <0x0 0x3200000 0x0 0x10000>,
>  					<0x0 0x20140520 0x0 0x4>;
>  				reg-names =3D "ahci", "sata-ecc";
> -				interrupts =3D <0 69 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts =3D <GIC_SPI 69
> IRQ_TYPE_LEVEL_HIGH>;
>  				clocks =3D <&clockgen
> QORIQ_CLK_PLATFORM_PLL
>  						    QORIQ_CLK_PLL_DIV(1)>;
>  				dma-coherent;
> @@ -864,21 +864,21 @@ msi1: msi-controller1@1571000 {
>  			compatible =3D "fsl,ls1043a-msi";
>  			reg =3D <0x0 0x1571000 0x0 0x8>;
>  			msi-controller;
> -			interrupts =3D <0 116 0x4>;
> +			interrupts =3D <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>=20
>  		msi2: msi-controller2@1572000 {
>  			compatible =3D "fsl,ls1043a-msi";
>  			reg =3D <0x0 0x1572000 0x0 0x8>;
>  			msi-controller;
> -			interrupts =3D <0 126 0x4>;
> +			interrupts =3D <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>=20
>  		msi3: msi-controller3@1573000 {
>  			compatible =3D "fsl,ls1043a-msi";
>  			reg =3D <0x0 0x1573000 0x0 0x8>;
>  			msi-controller;
> -			interrupts =3D <0 160 0x4>;
> +			interrupts =3D <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>=20
>  		pcie1: pcie@3400000 {
> @@ -886,8 +886,8 @@ pcie1: pcie@3400000 {
>  			reg =3D <0x00 0x03400000 0x0 0x00100000>, /*
> controller registers */
>  			      <0x40 0x00000000 0x0 0x00002000>; /*
> configuration space */
>  			reg-names =3D "regs", "config";
> -			interrupts =3D <0 117 IRQ_TYPE_LEVEL_HIGH>,
> -				     <0 118 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "pme", "aer";
>  			#address-cells =3D <3>;
>  			#size-cells =3D <2>;
> @@ -913,8 +913,8 @@ pcie2: pcie@3500000 {
>  			reg =3D <0x00 0x03500000 0x0 0x00100000>, /*
> controller registers */
>  			      <0x48 0x00000000 0x0 0x00002000>; /*
> configuration space */
>  			reg-names =3D "regs", "config";
> -			interrupts =3D <0 127 IRQ_TYPE_LEVEL_HIGH>,
> -				     <0 128 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "pme", "aer";
>  			#address-cells =3D <3>;
>  			#size-cells =3D <2>;
> @@ -940,8 +940,8 @@ pcie3: pcie@3600000 {
>  			reg =3D <0x00 0x03600000 0x0 0x00100000>, /*
> controller registers */
>  			      <0x50 0x00000000 0x0 0x00002000>; /*
> configuration space */
>  			reg-names =3D "regs", "config";
> -			interrupts =3D <0 161 IRQ_TYPE_LEVEL_HIGH>,
> -				     <0 162 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "pme", "aer";
>  			#address-cells =3D <3>;
>  			#size-cells =3D <2>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 754a64be739c..e5fcfc690ffc 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -441,7 +441,7 @@ clockgen: clocking@1ee1000 {
>  		tmu: tmu@1f00000 {
>  			compatible =3D "fsl,qoriq-tmu";
>  			reg =3D <0x0 0x1f00000 0x0 0x10000>;
> -			interrupts =3D <0 33 0x4>;
> +			interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>  			fsl,tmu-range =3D <0xb0000 0x9002a 0x6004c
> 0x70062>;
>  			fsl,tmu-calibration =3D
>  				/* Calibration data group 1 */
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 604bf88d70b3..91589b907ec8 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -118,7 +118,7 @@ gic: interrupt-controller@6000000 {
>  		      <0x0 0x0c0c0000 0 0x2000>, /* GICC */
>  		      <0x0 0x0c0d0000 0 0x1000>, /* GICH */
>  		      <0x0 0x0c0e0000 0 0x20000>; /* GICV */
> -		interrupts =3D <1 9 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>  		#address-cells =3D <2>;
>  		#size-cells =3D <2>;
>  		ranges;
> @@ -183,10 +183,10 @@ soc-crit {
>=20
>  	timer {
>  		compatible =3D "arm,armv8-timer";
> -		interrupts =3D <1 13 IRQ_TYPE_LEVEL_LOW>,/* Physical Secure
> PPI */
> -			     <1 14 IRQ_TYPE_LEVEL_LOW>,/* Physical Non-
> Secure PPI */
> -			     <1 11 IRQ_TYPE_LEVEL_LOW>,/* Virtual PPI */
> -			     <1 10 IRQ_TYPE_LEVEL_LOW>;/* Hypervisor PPI
> */
> +		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,/* Physical
> Secure PPI */
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,/* Physical
> Non-Secure PPI */
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,/* Virtual
> PPI */
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;/*
> Hypervisor PPI */
>  	};
>=20
>  	pmu {
> @@ -280,7 +280,7 @@ sfp: efuse@1e80000 {
>  		tmu: tmu@1f80000 {
>  			compatible =3D "fsl,qoriq-tmu";
>  			reg =3D <0x0 0x1f80000 0x0 0x10000>;
> -			interrupts =3D <0 23 0x4>;
> +			interrupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>  			fsl,tmu-range =3D <0xb0000 0x9002a 0x6004c
> 0x70062>;
>  			fsl,tmu-calibration =3D
>  				/* Calibration data group 1 */
> @@ -347,7 +347,7 @@ duart0: serial@21c0500 {
>  			reg =3D <0x0 0x21c0500 0x0 0x100>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
> -			interrupts =3D <0 32 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>  			status =3D "disabled";
>  		};
>=20
> @@ -356,14 +356,14 @@ duart1: serial@21c0600 {
>  			reg =3D <0x0 0x21c0600 0x0 0x100>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
> -			interrupts =3D <0 32 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>  			status =3D "disabled";
>  		};
>=20
>  		gpio0: gpio@2300000 {
>  			compatible =3D "fsl,ls1088a-gpio", "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2300000 0x0 0x10000>;
> -			interrupts =3D <0 36 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>  			little-endian;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
> @@ -374,7 +374,7 @@ gpio0: gpio@2300000 {
>  		gpio1: gpio@2310000 {
>  			compatible =3D "fsl,ls1088a-gpio", "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2310000 0x0 0x10000>;
> -			interrupts =3D <0 36 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>  			little-endian;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
> @@ -385,7 +385,7 @@ gpio1: gpio@2310000 {
>  		gpio2: gpio@2320000 {
>  			compatible =3D "fsl,ls1088a-gpio", "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2320000 0x0 0x10000>;
> -			interrupts =3D <0 37 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>  			little-endian;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
> @@ -396,7 +396,7 @@ gpio2: gpio@2320000 {
>  		gpio3: gpio@2330000 {
>  			compatible =3D "fsl,ls1088a-gpio", "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2330000 0x0 0x10000>;
> -			interrupts =3D <0 37 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>  			little-endian;
>  			gpio-controller;
>  			#gpio-cells =3D <2>;
> @@ -407,7 +407,7 @@ gpio3: gpio@2330000 {
>  		ifc: memory-controller@2240000 {
>  			compatible =3D "fsl,ifc";
>  			reg =3D <0x0 0x2240000 0x0 0x20000>;
> -			interrupts =3D <0 21 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>  			little-endian;
>  			#address-cells =3D <2>;
>  			#size-cells =3D <1>;
> @@ -419,7 +419,7 @@ i2c0: i2c@2000000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2000000 0x0 0x10000>;
> -			interrupts =3D <0 34 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(8)>;
>  			status =3D "disabled";
> @@ -430,7 +430,7 @@ i2c1: i2c@2010000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2010000 0x0 0x10000>;
> -			interrupts =3D <0 34 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(8)>;
>  			status =3D "disabled";
> @@ -441,7 +441,7 @@ i2c2: i2c@2020000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2020000 0x0 0x10000>;
> -			interrupts =3D <0 35 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(8)>;
>  			status =3D "disabled";
> @@ -452,7 +452,7 @@ i2c3: i2c@2030000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2030000 0x0 0x10000>;
> -			interrupts =3D <0 35 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(8)>;
>  			status =3D "disabled";
> @@ -477,7 +477,7 @@ QORIQ_CLK_PLL_DIV(4)>,
>  		esdhc: esdhc@2140000 {
>  			compatible =3D "fsl,ls1088a-esdhc", "fsl,esdhc";
>  			reg =3D <0x0 0x2140000 0x0 0x10000>;
> -			interrupts =3D <0 28 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-frequency =3D <0>;
>  			clocks =3D <&clockgen QORIQ_CLK_HWACCEL 1>;
>  			voltage-ranges =3D <1800 1800 3300 3300>; @@ -
> 490,7 +490,7 @@ esdhc: esdhc@2140000 {
>  		usb0: usb@3100000 {
>  			compatible =3D "snps,dwc3";
>  			reg =3D <0x0 0x3100000 0x0 0x10000>;
> -			interrupts =3D <0 80 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
>  			dr_mode =3D "host";
>  			snps,quirk-frame-length-adjustment =3D <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> @@ -501,7 +501,7 @@ usb0: usb@3100000 {
>  		usb1: usb@3110000 {
>  			compatible =3D "snps,dwc3";
>  			reg =3D <0x0 0x3110000 0x0 0x10000>;
> -			interrupts =3D <0 81 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
>  			dr_mode =3D "host";
>  			snps,quirk-frame-length-adjustment =3D <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> @@ -514,7 +514,7 @@ sata: sata@3200000 {
>  			reg =3D <0x0 0x3200000 0x0 0x10000>,
>  				<0x7 0x100520 0x0 0x4>;
>  			reg-names =3D "ahci", "sata-ecc";
> -			interrupts =3D <0 133 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts =3D <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
>  			dma-coherent;
> @@ -565,7 +565,7 @@ pcie1: pcie@3400000 {
>  			reg =3D <0x00 0x03400000 0x0 0x00100000>, /*
> controller registers */
>  			      <0x20 0x00000000 0x0 0x00002000>; /*
> configuration space */
>  			reg-names =3D "regs", "config";
> -			interrupts =3D <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer
> interrupt */
> +			interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> /* aer interrupt */
>  			interrupt-names =3D "aer";
>  			#address-cells =3D <3>;
>  			#size-cells =3D <2>;
> @@ -604,7 +604,7 @@ pcie2: pcie@3500000 {
>  			reg =3D <0x00 0x03500000 0x0 0x00100000>, /*
> controller registers */
>  			      <0x28 0x00000000 0x0 0x00002000>; /*
> configuration space */
>  			reg-names =3D "regs", "config";
> -			interrupts =3D <0 113 IRQ_TYPE_LEVEL_HIGH>; /* aer
> interrupt */
> +			interrupts =3D <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> /* aer interrupt */
>  			interrupt-names =3D "aer";
>  			#address-cells =3D <3>;
>  			#size-cells =3D <2>;
> @@ -642,7 +642,7 @@ pcie3: pcie@3600000 {
>  			reg =3D <0x00 0x03600000 0x0 0x00100000>, /*
> controller registers */
>  			      <0x30 0x00000000 0x0 0x00002000>; /*
> configuration space */
>  			reg-names =3D "regs", "config";
> -			interrupts =3D <0 118 IRQ_TYPE_LEVEL_HIGH>; /* aer
> interrupt */
> +			interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> /* aer interrupt */
>  			interrupt-names =3D "aer";
>  			#address-cells =3D <3>;
>  			#size-cells =3D <2>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> index 8352197cea6f..e9bc1f4fa13c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> @@ -15,7 +15,7 @@
>  / {
>  	pmu {
>  		compatible =3D "arm,cortex-a57-pmu";
> -		interrupts =3D <1 7 0x8>; /* PMU PPI, Level low type */
> +		interrupts =3D <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>  	};
>  };
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> index 245bbd615c81..60c422560e33 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> @@ -15,7 +15,7 @@
>  / {
>  	pmu {
>  		compatible =3D "arm,cortex-a72-pmu";
> -		interrupts =3D <1 7 0x8>; /* PMU PPI, Level low type */
> +		interrupts =3D <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>  	};
>  };
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index ccba0a135b24..cc305e629bdc 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -58,7 +58,7 @@ gic: interrupt-controller@6000000 {
>  		#size-cells =3D <2>;
>  		ranges;
>  		interrupt-controller;
> -		interrupts =3D <1 9 0x4>;
> +		interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>=20
>  		its: msi-controller@6020000 {
>  			compatible =3D "arm,gic-v3-its";
> @@ -314,7 +314,7 @@ extirq: interrupt-controller@14 {
>  		tmu: tmu@1f80000 {
>  			compatible =3D "fsl,qoriq-tmu";
>  			reg =3D <0x0 0x1f80000 0x0 0x10000>;
> -			interrupts =3D <0 23 0x4>;
> +			interrupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>  			fsl,tmu-range =3D <0xb0000 0x9002a 0x6004c
> 0x30062>;
>  			fsl,tmu-calibration =3D
>  					<0x00000000 0x00000026>,
> @@ -362,7 +362,7 @@ serial0: serial@21c0500 {
>  			reg =3D <0x0 0x21c0500 0x0 0x100>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
> -			interrupts =3D <0 32 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>=20
>  		serial1: serial@21c0600 {
> @@ -370,7 +370,7 @@ serial1: serial@21c0600 {
>  			reg =3D <0x0 0x21c0600 0x0 0x100>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
> -			interrupts =3D <0 32 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>=20
>  		serial2: serial@21d0500 {
> @@ -378,7 +378,7 @@ serial2: serial@21d0500 {
>  			reg =3D <0x0 0x21d0500 0x0 0x100>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
> -			interrupts =3D <0 33 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>=20
>  		serial3: serial@21d0600 {
> @@ -386,7 +386,7 @@ serial3: serial@21d0600 {
>  			reg =3D <0x0 0x21d0600 0x0 0x100>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
> -			interrupts =3D <0 33 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>=20
>  		cluster1_core0_watchdog: wdt@c000000 { @@ -883,48
> +883,48 @@ smmu: iommu@5000000 {
>  			#iommu-cells =3D <1>;
>  			stream-match-mask =3D <0x7C00>;
>  			dma-coherent;
> -			interrupts =3D <0 13 4>, /* global secure fault */
> -				     <0 14 4>, /* combined secure interrupt
> */
> -				     <0 15 4>, /* global non-secure fault */
> -				     <0 16 4>, /* combined non-secure
> interrupt */
> +			interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>, /*
> global secure fault */
> +				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>, /*
> combined secure interrupt */
> +				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>, /*
> global non-secure fault */
> +				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>, /*
> combined non-secure
> +interrupt */
>  				/* performance counter interrupts 0-7 */
> -				     <0 211 4>, <0 212 4>,
> -				     <0 213 4>, <0 214 4>,
> -				     <0 215 4>, <0 216 4>,
> -				     <0 217 4>, <0 218 4>,
> +				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 218
> +IRQ_TYPE_LEVEL_HIGH>,
>  				/* per context interrupt, 64 interrupts */
> -				     <0 146 4>, <0 147 4>,
> -				     <0 148 4>, <0 149 4>,
> -				     <0 150 4>, <0 151 4>,
> -				     <0 152 4>, <0 153 4>,
> -				     <0 154 4>, <0 155 4>,
> -				     <0 156 4>, <0 157 4>,
> -				     <0 158 4>, <0 159 4>,
> -				     <0 160 4>, <0 161 4>,
> -				     <0 162 4>, <0 163 4>,
> -				     <0 164 4>, <0 165 4>,
> -				     <0 166 4>, <0 167 4>,
> -				     <0 168 4>, <0 169 4>,
> -				     <0 170 4>, <0 171 4>,
> -				     <0 172 4>, <0 173 4>,
> -				     <0 174 4>, <0 175 4>,
> -				     <0 176 4>, <0 177 4>,
> -				     <0 178 4>, <0 179 4>,
> -				     <0 180 4>, <0 181 4>,
> -				     <0 182 4>, <0 183 4>,
> -				     <0 184 4>, <0 185 4>,
> -				     <0 186 4>, <0 187 4>,
> -				     <0 188 4>, <0 189 4>,
> -				     <0 190 4>, <0 191 4>,
> -				     <0 192 4>, <0 193 4>,
> -				     <0 194 4>, <0 195 4>,
> -				     <0 196 4>, <0 197 4>,
> -				     <0 198 4>, <0 199 4>,
> -				     <0 200 4>, <0 201 4>,
> -				     <0 202 4>, <0 203 4>,
> -				     <0 204 4>, <0 205 4>,
> -				     <0 206 4>, <0 207 4>,
> -				     <0 208 4>, <0 209 4>;
> +				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
> <GIC_SPI 209
> +IRQ_TYPE_LEVEL_HIGH>;
>  		};
>=20
>  		dspi: spi@2100000 {
> @@ -933,7 +933,7 @@ dspi: spi@2100000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2100000 0x0 0x10000>;
> -			interrupts =3D <0 26 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
>  			clock-names =3D "dspi";
> @@ -944,7 +944,7 @@ esdhc: esdhc@2140000 {
>  			status =3D "disabled";
>  			compatible =3D "fsl,ls2080a-esdhc", "fsl,esdhc";
>  			reg =3D <0x0 0x2140000 0x0 0x10000>;
> -			interrupts =3D <0 28 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(2)>;
>  			voltage-ranges =3D <1800 1800 3300 3300>; @@ -
> 956,7 +956,7 @@ esdhc: esdhc@2140000 {
>  		gpio0: gpio@2300000 {
>  			compatible =3D "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2300000 0x0 0x10000>;
> -			interrupts =3D <0 36 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
>  			little-endian;
>  			#gpio-cells =3D <2>;
> @@ -967,7 +967,7 @@ gpio0: gpio@2300000 {
>  		gpio1: gpio@2310000 {
>  			compatible =3D "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2310000 0x0 0x10000>;
> -			interrupts =3D <0 36 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
>  			little-endian;
>  			#gpio-cells =3D <2>;
> @@ -978,7 +978,7 @@ gpio1: gpio@2310000 {
>  		gpio2: gpio@2320000 {
>  			compatible =3D "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2320000 0x0 0x10000>;
> -			interrupts =3D <0 37 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
>  			little-endian;
>  			#gpio-cells =3D <2>;
> @@ -989,7 +989,7 @@ gpio2: gpio@2320000 {
>  		gpio3: gpio@2330000 {
>  			compatible =3D "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
>  			reg =3D <0x0 0x2330000 0x0 0x10000>;
> -			interrupts =3D <0 37 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
>  			little-endian;
>  			#gpio-cells =3D <2>;
> @@ -1003,7 +1003,7 @@ i2c0: i2c@2000000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2000000 0x0 0x10000>;
> -			interrupts =3D <0 34 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names =3D "i2c";
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
> @@ -1015,7 +1015,7 @@ i2c1: i2c@2010000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2010000 0x0 0x10000>;
> -			interrupts =3D <0 34 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names =3D "i2c";
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
> @@ -1027,7 +1027,7 @@ i2c2: i2c@2020000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2020000 0x0 0x10000>;
> -			interrupts =3D <0 35 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names =3D "i2c";
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
> @@ -1039,7 +1039,7 @@ i2c3: i2c@2030000 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0x0 0x2030000 0x0 0x10000>;
> -			interrupts =3D <0 35 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names =3D "i2c";
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
> @@ -1048,7 +1048,7 @@ i2c3: i2c@2030000 {
>  		ifc: memory-controller@2240000 {
>  			compatible =3D "fsl,ifc";
>  			reg =3D <0x0 0x2240000 0x0 0x20000>;
> -			interrupts =3D <0 21 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>  			little-endian;
>  			#address-cells =3D <2>;
>  			#size-cells =3D <1>;
> @@ -1077,7 +1077,7 @@ QORIQ_CLK_PLL_DIV(4)>,
>  		pcie1: pcie@3400000 {
>  			compatible =3D "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
>  			reg-names =3D "regs", "config";
> -			interrupts =3D <0 108 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "intr";
>  			#address-cells =3D <3>;
>  			#size-cells =3D <2>;
> @@ -1099,7 +1099,7 @@ pcie1: pcie@3400000 {
>  		pcie2: pcie@3500000 {
>  			compatible =3D "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
>  			reg-names =3D "regs", "config";
> -			interrupts =3D <0 113 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "intr";
>  			#address-cells =3D <3>;
>  			#size-cells =3D <2>;
> @@ -1121,7 +1121,7 @@ pcie2: pcie@3500000 {
>  		pcie3: pcie@3600000 {
>  			compatible =3D "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
>  			reg-names =3D "regs", "config";
> -			interrupts =3D <0 118 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "intr";
>  			#address-cells =3D <3>;
>  			#size-cells =3D <2>;
> @@ -1143,7 +1143,7 @@ pcie3: pcie@3600000 {
>  		pcie4: pcie@3700000 {
>  			compatible =3D "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
>  			reg-names =3D "regs", "config";
> -			interrupts =3D <0 123 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names =3D "intr";
>  			#address-cells =3D <3>;
>  			#size-cells =3D <2>;
> @@ -1166,7 +1166,7 @@ sata0: sata@3200000 {
>  			status =3D "disabled";
>  			compatible =3D "fsl,ls2080a-ahci";
>  			reg =3D <0x0 0x3200000 0x0 0x10000>;
> -			interrupts =3D <0 133 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
>  			dma-coherent;
> @@ -1176,7 +1176,7 @@ sata1: sata@3210000 {
>  			status =3D "disabled";
>  			compatible =3D "fsl,ls2080a-ahci";
>  			reg =3D <0x0 0x3210000 0x0 0x10000>;
> -			interrupts =3D <0 136 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(4)>;
>  			dma-coherent;
> @@ -1192,7 +1192,7 @@ bus: bus {
>  			usb0: usb@3100000 {
>  				compatible =3D "snps,dwc3";
>  				reg =3D <0x0 0x3100000 0x0 0x10000>;
> -				interrupts =3D <0 80 0x4>; /* Level high type
> */
> +				interrupts =3D <GIC_SPI 80
> IRQ_TYPE_LEVEL_HIGH>;
>  				dr_mode =3D "host";
>  				snps,quirk-frame-length-adjustment =3D
> <0x20>;
>  				snps,dis_rxdet_inp3_quirk;
> @@ -1203,7 +1203,7 @@ usb0: usb@3100000 {
>  			usb1: usb@3110000 {
>  				compatible =3D "snps,dwc3";
>  				reg =3D <0x0 0x3110000 0x0 0x10000>;
> -				interrupts =3D <0 81 0x4>; /* Level high type
> */
> +				interrupts =3D <GIC_SPI 81
> IRQ_TYPE_LEVEL_HIGH>;
>  				dr_mode =3D "host";
>  				snps,quirk-frame-length-adjustment =3D
> <0x20>;
>  				snps,dis_rxdet_inp3_quirk;
> @@ -1215,7 +1215,7 @@ usb1: usb@3110000 {
>  		ccn@4000000 {
>  			compatible =3D "arm,ccn-504";
>  			reg =3D <0x0 0x04000000 0x0 0x01000000>;
> -			interrupts =3D <0 12 4>;
> +			interrupts =3D <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>=20
>  		rcpm: power-controller@1e34040 {
> @@ -1236,14 +1236,14 @@ ftm_alarm0: timer@2800000 {
>  	ddr1: memory-controller@1080000 {
>  		compatible =3D "fsl,qoriq-memory-controller";
>  		reg =3D <0x0 0x1080000 0x0 0x1000>;
> -		interrupts =3D <0 17 0x4>;
> +		interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
>  		little-endian;
>  	};
>=20
>  	ddr2: memory-controller@1090000 {
>  		compatible =3D "fsl,qoriq-memory-controller";
>  		reg =3D <0x0 0x1090000 0x0 0x1000>;
> -		interrupts =3D <0 18 0x4>;
> +		interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
>  		little-endian;
>  	};
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index 96055593204a..eaa7d8c70964 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -928,7 +928,7 @@ dspi2: spi@2120000 {
>  		esdhc0: esdhc@2140000 {
>  			compatible =3D "fsl,esdhc";
>  			reg =3D <0x0 0x2140000 0x0 0x10000>;
> -			interrupts =3D <0 28 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(2)>;
>  			dma-coherent;
> @@ -942,7 +942,7 @@ esdhc0: esdhc@2140000 {
>  		esdhc1: esdhc@2150000 {
>  			compatible =3D "fsl,esdhc";
>  			reg =3D <0x0 0x2150000 0x0 0x10000>;
> -			interrupts =3D <0 63 0x4>; /* Level high type */
> +			interrupts =3D <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(2)>;
>  			dma-coherent;
> --
> 2.43.0
>=20


