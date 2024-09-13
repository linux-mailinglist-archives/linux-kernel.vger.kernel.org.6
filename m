Return-Path: <linux-kernel+bounces-327524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820F0977720
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4645B282826
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66171D2F69;
	Fri, 13 Sep 2024 02:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="joXLh5Gm"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2043.outbound.protection.outlook.com [40.107.103.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66731BD503;
	Fri, 13 Sep 2024 02:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726196087; cv=fail; b=Sdr7opAZRxves8XhWgcp+OEnGHtcHHS3WxigU5TagTyvw+se0d5WrrUNKiD98Y4qnb4e+JEnWXOpgN5A/MKurQNHhrCdZsmnDIOqTQBo5xzoh6g7x/DRQVQgmGmawYkfV5//Ll93yb8wOf3vdZk/72f02f83h0AU9i5hMXqKpY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726196087; c=relaxed/simple;
	bh=tq/shTKP6cvUIhGDKdXF9tPJ4obrB2CeqzCMvmwjd6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N9N9lHoCp/b1qokBX/EIBImpD+rDud5q66g0mJ1M6pV/Dv1VQZhp0tgTpOFZo1dez0OHXf1Qb68DqOhlb3l5h80SJ8JSNm56P2aX0Hm5sA/Hv/wczWl9QvSwia8FigHqvnGLXB2Qx2Cz1SA+2TJodheY6KVtCgqIoKWX+R7rgf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=joXLh5Gm; arc=fail smtp.client-ip=40.107.103.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2WyjGmJ7QfNchCU3VblzYPe9uCkgnHSd6vcixb+JEFKp4hR7rHyKWEgQ1+xQmNOLczM6AUcpq6avIGqF49id1WgM9EWFuQAy6vO49vnrfi78F3KmrumVcF8ZtiDeaMCZZZVP8k7Hc3isXApQbZ8Jve99sWh1yir3ufAaZcLLe+Knha6t2CpzfX0pGaZMeN52Gg8m4042tud/2gPGcrvnW1Ljc5u9q0Ez9quD1dt5QcuvGRD4D5CpmO6GFcrHzA7smHHnfFPDqfkDF6iGhLpBlW6gjW2CG8dKp245fpaWbs5jV3tNWjhCaz+ajOg//UP2HBfKT0HHT/ZpBX1kc8xQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mnty920cT9w/Qa4/ZnzYPi+3pFIp0Y0oiB0Dt1R1FCY=;
 b=t0VegmflfBHRJl8LB06rx/xWwVMX18W/xPYjluph+WvThBZyIBVThXdR6J5caHp9QY18IqvHSNYxMSVnD7D747RPA7FXZTUbp/JkO7s5nk0QCuxutEEdxpPJSBKRMTfiaBOXsOJGo0rt0+CPdRz9TshK01z/iBwr4A6cLiyfldmeMWv+66UTf+MlCah/WAu3gN0cC37mOFVHzPBOjadFM6LtkKxQlQGcta1tpCF9jpP+gq3YlHPMhQmv58FXnt9Q73T759Rf3tXBa6BNI85EWfBYNik4qtJ7sIRJqSH1K63lYnVkB9MPuWlTzok/5fpDOh3dIt9gYu8UacRoALjGFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mnty920cT9w/Qa4/ZnzYPi+3pFIp0Y0oiB0Dt1R1FCY=;
 b=joXLh5GmQI9fhxSciSndZsQfyzgdkEjrQNZunUcAjRq+7Jtcj3SNzCdIGcRLxCpc3O5pK/1Pe6ATDDuGfqtZO78hrFbhddQe1cPGc96LI4r+AJrTp5eu0eTSg0JOAGBY3a5aDftM1MO4wDwZjACVUU3cGi1zb7SlkyW1w5czNRaSOVi98gMiywhBmBv4jjDcxI0Tm71ERFpa4lJdsGzfzT3RFulo+vD4N6zB8Z3gVXqTjLDzIupEVCaZBQ42cUCDjz4f/4ieLPdx+7odvBzOiAZUyoFqlvMXrOukrQt/oL4hgIk+C7EbucfI+aD1z7fz2/re2yWleh4bgVmfBaXgZQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB9732.eurprd04.prod.outlook.com (2603:10a6:20b:672::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Fri, 13 Sep
 2024 02:54:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 02:54:41 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: Markus Niebel <Markus.Niebel@ew.tq-group.com>, "linux@ew.tq-group.com"
	<linux@ew.tq-group.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] arm64: dt: imx93-tqma9352-mba93xxca: enable Open
 Drain for MDIO
Thread-Topic: [PATCH 1/2] arm64: dt: imx93-tqma9352-mba93xxca: enable Open
 Drain for MDIO
Thread-Index: AQHbBBo5rAWvTjk5kUaFZz6ncDuYzbJVAy7g
Date: Fri, 13 Sep 2024 02:54:41 +0000
Message-ID:
 <PAXPR04MB8459AEC9C8D156EF23FAF0A688652@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240911071359.2971191-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240911071359.2971191-1-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS5PR04MB9732:EE_
x-ms-office365-filtering-correlation-id: 23e415bb-c906-4159-73de-08dcd39f6a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hPCkEsalSSVIZhYhFPUCqE0PVUCbGt73hcx5HQTHf7gwtSpvilJQfV5N2Y3+?=
 =?us-ascii?Q?JgjNF+QoRa4hwEvbYGzRb4WaedxtlikUzsndEPxEJ19y6f9PLnzIt9TIuKSk?=
 =?us-ascii?Q?DqHCYAWT7hRxVBGNhUv6RW60Wc/dw0MEAlUU7XQlkIQSnPYEFIZ5NGThKWLb?=
 =?us-ascii?Q?eSfjk33yH0kzKxu2k6rv4iMrDTaTkfRtq7Iu7L1uGefpIqkhb+Ao7qNRlP/i?=
 =?us-ascii?Q?gjgvvX8Yq4X7IFQD2qpjkFfeOOemWW4lKL0MtioaUrdbpd4yjs9vJmlL3cOo?=
 =?us-ascii?Q?EYDmUFRE2dg2GJjqc45HOBTUvjjz4KwmzlHsh9hwpX9hDOjrareT5MCTR8sS?=
 =?us-ascii?Q?tcK9ilSvIj+dtH90lDX7iir/MI6LJrRj7caCgqRQylqv61t63vNQX4GjfSwk?=
 =?us-ascii?Q?ZCPMhmxXFPpt2Ox15vUmgXq2LorY1bYhbvveMBZJscvj/izraT8wrkNrsWqk?=
 =?us-ascii?Q?RwaqV+hMV2m3LL03hT42rWGF7YvDJimdoSk74UWpklJiWZNjMq9NM2e3RqQl?=
 =?us-ascii?Q?bwr0HmFZMJlGjFIVvBtoom/jVNcPCgE1C87qEYIYbf74lUwDW+Tak2N1tSou?=
 =?us-ascii?Q?RtsJn20sCBrFgS598BeEyh+AjOUD+oXwkfin4GFgEMKCpW9+KwajMtHpAKhC?=
 =?us-ascii?Q?rwVZmVvNFa95V5wB8pzxayFcL1TSTDk3dn2ks0cwVZeBAZc8QofQGNeXfgsx?=
 =?us-ascii?Q?xGlnmU4zkFP0eK9fX+i6R4pm7tJ5iqrnWrW/iIuT0PectiSvbiyMlu9xX0Ll?=
 =?us-ascii?Q?kMe0mwgo97wrvo48r43eLasnhy80qUQ6M3cmurFXIIGer2NTmFbbbYsznhq1?=
 =?us-ascii?Q?GPjq+WexcA4EEh6iMnQQrK/x0OerrTFc9S3IPSM3E+yU5ebvwhXXQqNwaQFk?=
 =?us-ascii?Q?xevGYQAMWoPG/3PQr/8jgLLeqKs2CIA1YG53X3yiTGRMYwBmcCTdZsiYVj6q?=
 =?us-ascii?Q?LBzbWHLo87/m5Vd+QFLeZ+lZB6kn+0ztlMLecPN2+pSX6gMbkiTXQ2jLVGRC?=
 =?us-ascii?Q?DYoCwirdiHMlRjMSY32PnbWC1J5FKrVotJsx3lQAkgD/XWxCOYDxB/Wn8WPV?=
 =?us-ascii?Q?zFgkVMYPNERjp0PtAG8ptTM9rqCvmA9MxJIHxfsgDoQNKeYgHRYzlpnGKva+?=
 =?us-ascii?Q?njJDLR/OoP+VppkUCQ3FiatlOKcXZTbdyY6TysCu8okTz/jZKG9Bk/ADaFEM?=
 =?us-ascii?Q?SHbPBw4Caf73Ib1PDnJzQEWhg4enDT2RotatI5+aicic3hWzV+VR7yvbeuIQ?=
 =?us-ascii?Q?Ax9ZyosgYBtR19OXZrUKBsdcRSqrXdE+I3CNR+dwo+XSB/OTSP9QvBHJiB15?=
 =?us-ascii?Q?75s7Qpn8I0HScuLUAuF3Y+7fuK6gYH3q4WkGeolKL38i7oANrr+Q4O4OjbhN?=
 =?us-ascii?Q?EfHqN8py6nA3NJh8H31y8yHSaXf9t9vkRPELyF1rnjvm6QsAWw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r86ElhmsEDwZ2bN8SR79MbSd82WtcwNplRmzb2XQghrdYb1Ii/NlZlTxrwpl?=
 =?us-ascii?Q?jG2YsFKRyeh7RsrGbHiRqKOAcSjoONfagpdJsZfq2GWrpg3r9AqqSBJmfIb4?=
 =?us-ascii?Q?PX/Mb2vgQ69CJfRXLhUZKMrVSvUzCkr9D6X6vDsV9a8CCHdKnxoDIMdp5NPz?=
 =?us-ascii?Q?T41FIgK5rc96BFP9T47VB9YN2sPeQ8Ui4QdBxrBslxe1yefBmdrsKog2rNXy?=
 =?us-ascii?Q?JivhtpMI5Dv91IjvxlqwkIZQIBTpH1f/U2JYzWp8h6z9VO4qT7mwsaum08/E?=
 =?us-ascii?Q?n0+vMXvIk4LKc4/dJbBh3jGSYVDdE6oM8QQ6KxGMo3NrYPMtrmkAqtTvi/9A?=
 =?us-ascii?Q?hGf+GAecqziWwMx6yO0z+VkkftXTQ/UeBWIcSkYyRmv11wiawAoa/jLP8SXT?=
 =?us-ascii?Q?vs/X/LLfcWwc8cKWs27wEA7o9kH3Bl3fEIvCL5yh2r9FfawtUZeMv5+9cA2/?=
 =?us-ascii?Q?LrBM5C/F2gQYFei0of3pRRvOPtes3KCMCc24UWvkgxqUcmFgchnWPokN0tD7?=
 =?us-ascii?Q?ElgxMd8cze8duGu0LiIx8sC4bJIAe5IUxM6fmiPAChcy4Q4KCA0iSqlBj3JO?=
 =?us-ascii?Q?Zd3rFl+EoxfmzKFvVgeNxsp+ExUw5XzyQ5HIInbawS+JncQlSQOkwOWz9kyn?=
 =?us-ascii?Q?M/WM0jxz4awjIhPkX2s9DgXG/bQMw4KCR6VhAIz7NRcEfm8yxa7pcrVxNIlT?=
 =?us-ascii?Q?2RGyCv0ZTgyJvYg1jvF1OkFyuRZerOaPVPC8CbKJ/Ur6rJd/c0NtRjiQg1HE?=
 =?us-ascii?Q?4BCe67kyxlp5pZaJyYWzp4Kz36Lb/9/mtorT0Idfql0Uk4ZHoRS3lw5IheIb?=
 =?us-ascii?Q?rfdSmNv66kUhcBnLrdOfMGswDGAqQPQ7zVGcoNZjIIdMBPBTRzBbcMICIWhW?=
 =?us-ascii?Q?njqp2lQFGNnWrxmGiumLocOMJI47zOdwxt9Lva7tOabF0Vx5xuWew9bi7OXr?=
 =?us-ascii?Q?5S4Ur4BcKC4q6+B9G2OMoVysX95Q84NaPEtGkei88FQQ/Z93OL+wxc8RYAGw?=
 =?us-ascii?Q?qN64ZxCDM2i/sTUbBTqfFLJdgwedIOis0pf6HvyYpqDcF1ZfDFF/g0fAost2?=
 =?us-ascii?Q?lEWO4h5TWyW0kYc7Mgq0DkjwzQQBGUyo2W5ED5UIULCFUxbCaLpKR0vM5cxo?=
 =?us-ascii?Q?itue34dOeUL+Lg50Y5wTwWZsUGrUBCDEIjEMXtAxTLbQqtfIIxUlBjyg3INW?=
 =?us-ascii?Q?1oglctF+Yl5+JpgLDsnNZwtl6NGChhYSbk6MeAcX2T+40gOeHrse1NHlsvK5?=
 =?us-ascii?Q?wEn5/5eK/kNonKkcXfG2amelcsLC01MEPDERy7sNwHooxnjvDNsVWcKGtp2m?=
 =?us-ascii?Q?3ZLjnY6UtFFkWWWJNsEAMp/ZYio+5roCMEdpm1Cs8CH0GK587YAl+g6Du1+L?=
 =?us-ascii?Q?dlJH+qKWHCPSeAaCumjKKuZadZ3L/QYplNmCI2+sCcg+EbZzKYFMW+t9g8N3?=
 =?us-ascii?Q?HXRmMn9kD9vHN+Hzl3ZEU7DZxSEkiilVSwBws0rWtqEo74Itmyz7apZoHweP?=
 =?us-ascii?Q?Y+FpBq0BsKAUD2b4ndenFBhouvNQI8+qKpSS/tD+grWg7AVmxbUDzy4ITy7N?=
 =?us-ascii?Q?NkREWpt3SOcc3ZEXQic=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e415bb-c906-4159-73de-08dcd39f6a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 02:54:41.2661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqtwiQ4kF9uBB7pbwXE2RipRYUDXvsWsmBHSoFG9qKNMaF98zi397sXCwAOAym3bakFKKHn9JI+7sCZZCYDa4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9732

> Subject: [PATCH 1/2] arm64: dt: imx93-tqma9352-mba93xxca: enable
> Open Drain for MDIO
>=20
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>=20
> Follow suggestion from hardware team.

This is a bit vague, my guess:

The board has a pull-up resistor for MDIO pin per PHY design guide.
When MDIO is idle, it needs to be high and open drain is better
to be used here for power saving.

Regards,
Peng.
>=20
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  .../arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts | 8
> ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-
> mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-
> mba93xxca.dts
> index 599df32976e24..8e939d716aac8 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-
> mba93xxca.dts
> @@ -627,8 +627,8 @@ pinctrl_eqos: eqosgrp {
>  		fsl,pins =3D <
>  			/* PD | FSEL_2 | DSE X4 */
>  			MX93_PAD_ENET1_MDC__ENET_QOS_MDC
> 			0x51e
> -			/* SION | HYS | FSEL_2 | DSE X4 */
> -
> 	MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO
> 	0x4000111e
> +			/* SION | HYS | ODE | FSEL_2 | DSE X4 */
> +
> 	MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO
> 	0x4000191e
>  			/* HYS | FSEL_0 | DSE no drive */
>=20
> 	MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0
> 	0x1000
>=20
> 	MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1
> 	0x1000
> @@ -659,8 +659,8 @@ pinctrl_fec: fecgrp {
>  		fsl,pins =3D <
>  			/* PD | FSEL_2 | DSE X4 */
>  			MX93_PAD_ENET2_MDC__ENET1_MDC
> 		0x51e
> -			/* SION | HYS | FSEL_2 | DSE X4 */
> -			MX93_PAD_ENET2_MDIO__ENET1_MDIO
> 		0x4000111e
> +			/* SION | HYS | ODE | FSEL_2 | DSE X4 */
> +			MX93_PAD_ENET2_MDIO__ENET1_MDIO
> 		0x4000191e
>  			/* HYS | FSEL_0 | DSE no drive */
>  			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0
> 		0x1000
>  			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1
> 		0x1000
> --
> 2.34.1
>=20


