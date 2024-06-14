Return-Path: <linux-kernel+bounces-214367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B23908354
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE2D1F23054
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F8146582;
	Fri, 14 Jun 2024 05:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dmW0xBgv"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A142064
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718343062; cv=fail; b=luBjdNYnrLEKCoaAbBZwUrv4TX7KywlGi5csAu7mHBdSSaxGI8qnHSMxiTO+8CzcvdC08yzjeqVnCvcFGJnbKFPYdK8E7cGMdhOFYeaDsjChGFS0DUND3Pf/UjKTbtQhyHQcCvN3mCPGAQO6p+FItaSVDIfWcTottjQOXuVs4nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718343062; c=relaxed/simple;
	bh=w/+bootN8N/EWihnpAF7SAHVTnEyFuP8TDsvbh90g1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OaT8PH+pRfMcWZWJ/dXSuHR7umGHERKJceNkXVkg/mMj1x5LB8qqVjEYrRtk0bljmjxO01OphlJn3vyeC/HKBcsAPbmqwuaA8hQN0h7wJPWVW+4jZ0BWyPk0Ec5PZSARwzt/JeGoYFtL2ZjEHjcg/qiPMoCNdSCLSArxSnczLjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dmW0xBgv; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0iicvpa2bBeb6xMWuwIfQx+EUNpTDHEWh8rjeFsj7vhgdlIQRdFabQAmyPHyH76Hl1AKm0emyG6X/Euwg9VW/jEySjUya9t465+fkSVefTPEm0+VFGUwINcBFAU1lltZ/nueAlothukksJF8RkgWAf16UilxzC2z880WkYHy3i2K7bCwS2UWMlsEsr61F9Xtf/YUCrREjQXVNW4T+4Dq1vf9BfYLydy9/nUoKioKcfXupu6Uj0ElGXLkXo2l7suqLyTYzFqv2WLu/0n4yW7kRM6PKcKAzVRo1bcvrerRk51nMhZCVAsiRVbyUvvoAS9omr22ziyUcaLDSBuQwInuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQiB4u9gZWWkPufoxGECoKRQQwjUXq2O8VV2pYq0/Es=;
 b=i8gVS0kZCuCMidrnSvw7FKSNVDxiAY7XN2RG1xvlJcDgepU0I7/3ttau9Z4jvEbAV8TSBu+Z0tsD/1hLVef84heGlKavU3S8HkPX+kjBPTeeNHLs5uxumH/xYqPbrRRGAhJP27CLFQ8e59mBFal1lbjUHRU/X7CZ/rs7TwUyFo5HZ+lgzNV1Er24qhOZ4w2nlAxigSXJ0+H3kOtBIVOGLhg96b1t0nlbJnbeMgMGuZJoucGlOSzfe1eh+5TpsDYf4l6OKqtHZ+ZMmnPone4RMc576EJCSa0/7wTrkEdJChAKsPqq3jL6jKhgswp8U8x02ZGnb8q3wIlFV+gxY5ovOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQiB4u9gZWWkPufoxGECoKRQQwjUXq2O8VV2pYq0/Es=;
 b=dmW0xBgvqs/geySMPAYUHxv1xwsPOMhfwvb90wyYMqYtmvkp3fGEBR1XpbVf2jusfcFNhQH2AbnTa7BdPqfM93Vo/Ut5HApQ2R/o070k64uErT4R9fb3zBPcNK+t0jMUlO+6J6yU1hxwtSl5xHrhZPuaX2NW7vmYvDdoVfnAs2U=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 05:30:58 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%6]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 05:30:58 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>
CC: Vinod Koul <vkoul@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: RE: [PATCH v2 1/4] phy: zynqmp: Enable reference clock correctly
Thread-Topic: [PATCH v2 1/4] phy: zynqmp: Enable reference clock correctly
Thread-Index: AQJ83aedMQVFXzZR+sovobCavopdtgHJ/l3WsHQqluA=
Date: Fri, 14 Jun 2024 05:30:58 +0000
Message-ID:
 <MN0PR12MB59531E522EC62B160EEC35E5B7C22@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240506170110.2874724-1-sean.anderson@linux.dev>
 <20240506170110.2874724-2-sean.anderson@linux.dev>
In-Reply-To: <20240506170110.2874724-2-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SA1PR12MB7409:EE_
x-ms-office365-filtering-correlation-id: 22e0dbdb-2149-460a-ef86-08dc8c332b78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RK2WueHp7K8bIbjUyHTq3FSpIFzbqowHdyoS0DXLxhtzog62dUcC50NOh15z?=
 =?us-ascii?Q?V6Vjjf+sZN7PPHGAErV6Ilj1I0CFUx81fCM7cCZsSoT0KnW/4Np5U2RW5V/I?=
 =?us-ascii?Q?cxWh7OoNztwFRKNkuOWcV7sNvR/CZjhqEaEI3m6PBco1AYevSu9CNF/94g9v?=
 =?us-ascii?Q?f1bRjOJXUv89OyHpsHDO3aGrTnoZ7IhaZqCDTuOfHs1bwG4hLl/8OaxfX2wf?=
 =?us-ascii?Q?Shlcfv0r6VEEXglSxl6iixnpbgNbH7ZgVySGeYsS9v1xvAnCwX7hHKzos/cS?=
 =?us-ascii?Q?JRADGCnbMRSVnNpWEdTmL9x+a2uuE61mwongmOcltm8HAbRvizlOi44XefGb?=
 =?us-ascii?Q?V4+MYj0UfHO7GQ+LWVtj6eqMsYGLGFD7jpL7kMBh6EsiiMOIRp57A8p+6tuK?=
 =?us-ascii?Q?5IG6XGAn86zq8+e6IU2/uM9l5eDS18zNBBR2HHhtPWd7Yr3kPhk3zaVCbwOD?=
 =?us-ascii?Q?2PRdW1NpibVfX9Y1SqzoJyMEg5E8Wo+CqrcpGGWSGG6OWws9oCDZDaY5OxzP?=
 =?us-ascii?Q?CRa824KBfLdBXB9gsFKOYvkgwY/XyHREzzqKS/914om++zMEh59wzZrADwUW?=
 =?us-ascii?Q?FoRXH8iNlMLuYjlNj6EV2NmhGSvPmASRqht4++QKLiOpYjAkVOVpUAzUgMKI?=
 =?us-ascii?Q?WYmGcF+eH0UhZSqfXbcOCEEKTZSLjyu1tlQpxRmkUULDvS8qeIZ8oVh5s5np?=
 =?us-ascii?Q?5nxo509iKbAYQNi7x0S0JtZrlU1IfZD/XVttnNQHM5UWZ5aBMNRnc+DNP9Kk?=
 =?us-ascii?Q?/0zDUaWkEX2IDEuG8EstqXSBfMmKhGMj/+/PtAbeoDuzSadKJnUyrEycb8Pc?=
 =?us-ascii?Q?eRvu0zMnoE8LqIMTx4rNDlefRaGpJTJ+mrejXzDIyRVQU+0Gv0LFubOkV4AT?=
 =?us-ascii?Q?CHLe9SJ7znjhc8AfBQc9iTWZP8m8JxAEBSumaL1RK85fjuwkpW0pGc1jqkYo?=
 =?us-ascii?Q?OEyqlzuZYCA4GTqISuxhuZNtxPyjPZqvLSkuQ7zj/iz9jcfDkyUuhVfaDVr5?=
 =?us-ascii?Q?x+YndzLnTpSdLfFpGTMp1ggqACztrlCo5QFj933qHtkO+XXV7Kcy7YGQSIIy?=
 =?us-ascii?Q?3BzKpQUUXWoMqHnLSZqNGUuGSjbnxWOmUAhcoVnMrWxvW/HFy3iCip1NkRml?=
 =?us-ascii?Q?ERXpGSbySpB8xX4xwgPO9/D+klrrbTy0y8Itk1UdcuU8HMxyiJeow6Xplf4Y?=
 =?us-ascii?Q?vsgC7QafjG2gNTkt/766kYYoRGpEG3mEgN88/gQmqqW5RIEV9gzO9/Is42jw?=
 =?us-ascii?Q?Fuv09Ubz1owz94TeGtGJfMcH0nfdCUg0X+b/d/msoqBWJvujTo7tafabk3pp?=
 =?us-ascii?Q?1RSU6rg8/CMeBqq5FgcvOB2fkNvRo7cas1Xk2s3bCk8q4HQRplW9HO3pJW2C?=
 =?us-ascii?Q?Dh3Bz0w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NZ91BTHrvjqQ3N89ejJc9gwTBLpqAlGDU1CEwKqBM6QkErr4WmYmvX+2ZgO3?=
 =?us-ascii?Q?0eIei0w42Jt5AIXPse83yF4sxEeXmHNc6adXE1OZPRWu1lRuM7PgNf3OZexR?=
 =?us-ascii?Q?1QFWpqfK+4WTmFpKLFxrDVgVHfuHZn32m1f0HJiCGtHGupnS07r0m+66sG+E?=
 =?us-ascii?Q?PW0elhXaCDf6fTTOEt+Qg1JPIarHGeRozCfdPQGuAI0y2yBLyxrqcSyvT6/E?=
 =?us-ascii?Q?hnceT/zVItam0eAlgE1VtQ4OYg5nTwYk+JAl5NB7S+F9JA15nFzpbUIKMwr6?=
 =?us-ascii?Q?sf4wLioZHTHNAbzeUmj1A9Wo1ruFmQLgG4LNTtKbJRKDdynf/SW+ciYampZD?=
 =?us-ascii?Q?CVme0zAAKZAy7MyR4YP0eZqRGQ+Ug2yGZtuETD3qmtetT8Nj20jRVntZlC1x?=
 =?us-ascii?Q?fbz+eUYWhlxpqcJyspTVFeIEWZGAtCv7yKmcmuRmEfVV2MezE3h9Ch8t0tTw?=
 =?us-ascii?Q?M3I79n62PGiCymnDsE2Fu+9hgU0tvIDqlg54Ej4jLAVQno47+AB3IqalZVSr?=
 =?us-ascii?Q?pIKeDeCshVTMIsa6xLWcqsIWRFex8+M99inypmQdOUBYnK9PYPpwCaiwGr9y?=
 =?us-ascii?Q?5AYfaTZ0dYvf+FI6nqGwlgF5CRDSttIkWrJe8Lx4kwCSCpTmqEWp2XNGl7kC?=
 =?us-ascii?Q?m+xui4PBeqkKEnJbHiN51Cj4usGeqNpl0ulaQNIOkXs3FjIJGEaeieCP+L8y?=
 =?us-ascii?Q?kdawPcUJ6D33N6NHDOCVF9rhv0+hrcaBmi65tSG91NpVljYqtR5ACufiA79q?=
 =?us-ascii?Q?R3PkW9sQhnPAK767vpuWbBv+46XqI2BaOt6O5AjRiUwsVfAK2Ro6vzUO/PkF?=
 =?us-ascii?Q?ZpnDTj+3ancp1XqLN5/1MFtcLiFftKGk/fA1YIib3vO+D+KQqle+w4c3ujji?=
 =?us-ascii?Q?OYqsmZGbnFlYBt2lK80bHtWrlgPaFLZP3badFBKpmtHEWsZrHbidqYu0mI5f?=
 =?us-ascii?Q?apzoDLbKw1/oQR/OZrNKBDPQB1+Soy/8KoCzX9hlBEUBjLQB/MD1FhR3tTHI?=
 =?us-ascii?Q?XtS63xa+DK18y0JhIXmrF3TFr8aLnEuNjLwy0dtdS0l1rFW3O29gD52sdSFp?=
 =?us-ascii?Q?mrlPX+Gm5CpjCbZLkrZaD/3Ke5AzaElMWt90A1oSm9ACUg90AKSxnEQTvL08?=
 =?us-ascii?Q?Vt541ctEaEWiJzLTZo7hWK8LBoyayjDgl39Htp18kHNGvGdLnZ/BuY7uFw9D?=
 =?us-ascii?Q?uCTNwAlcCgsnHYZZq821AEvo/YMjFoV7XqJaBr3UJLAlH8RoBPKWfNu1HW7Y?=
 =?us-ascii?Q?6CgyGptCLSeUIf6aBR5suSP5lYRIfQDnThmuMEc2pqop5VFFq8m5SAI9TP9M?=
 =?us-ascii?Q?kd8PdsHj7ijwdFicpcZObrJwLxX7VxI257DGv1sXbK88Amf+lzfqBn1zJoLK?=
 =?us-ascii?Q?lWBAYPqabIIXeVfuwZ1EmXXdBSe+VQT2xSpV+wbKsg9zLCIR/PEMC2uzpXDo?=
 =?us-ascii?Q?rBV8wh/P0Wch+m357uuL9eElycDqy/lHZmRXKPNZDlGoSeh/v0pBn0CLofKE?=
 =?us-ascii?Q?+rsV0yauacx8NT4QIN8fJw4qU5Zvm9RgKsxpDDMs1Og8UotiVsZX4+GaIRnC?=
 =?us-ascii?Q?Heez0y5V5FNY2PEkbAA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e0dbdb-2149-460a-ef86-08dc8c332b78
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 05:30:58.0256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VmmjW6xqb/VKAL4l0XijhtJrHNU/34KLOgxfGHDvXFoRRspY3AROe9DSvUG2ebzs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Monday, May 6, 2024 10:31 PM
> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>; linux-
> phy@lists.infradead.org
> Cc: Vinod Koul <vkoul@kernel.org>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Michal Simek <michal.simek@amd.com>;
> Kishon Vijay Abraham I <kishon@kernel.org>; Sean Anderson
> <sean.anderson@linux.dev>
> Subject: [PATCH v2 1/4] phy: zynqmp: Enable reference clock correctly
>=20
> Lanes can use other lanes' reference clocks, as determined by refclk.
> Use refclk to determine the clock to enable/disable instead of always
> using the lane's own reference clock. This ensures the clock selected in
> xpsgtr_configure_pll is the one enabled.
>=20
> For the other half of the equation, always program REF_CLK_SEL even when
> we are selecting the lane's own clock. This ensures that Linux's idea of
> the reference clock matches the hardware. We use the "local" clock mux
> for this instead of going through the ref clock network.
>=20
> Fixes: 25d700833513 ("phy: xilinx: phy-zynqmp: dynamic clock support for
> power-save")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>=20
> Changes in v2:
> - New
>=20
>  drivers/phy/xilinx/phy-zynqmp.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-
> zynqmp.c
> index f72c5257d712..5a434382356c 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -80,7 +80,8 @@
>=20
>  /* Reference clock selection parameters */
>  #define L0_Ln_REF_CLK_SEL(n)		(0x2860 + (n) * 4)
> -#define L0_REF_CLK_SEL_MASK		0x8f
> +#define L0_REF_CLK_LCL_SEL		BIT(7)
> +#define L0_REF_CLK_SEL_MASK		0x9f
>=20
>  /* Calibration digital logic parameters */
>  #define L3_TM_CALIB_DIG19		0xec4c
> @@ -349,11 +350,14 @@ static void xpsgtr_configure_pll(struct xpsgtr_phy
> *gtr_phy)
>  		       PLL_FREQ_MASK, ssc->pll_ref_clk);
>=20
>  	/* Enable lane clock sharing, if required */
> -	if (gtr_phy->refclk !=3D gtr_phy->lane) {
> +	if (gtr_phy->refclk =3D=3D gtr_phy->lane)
> +		/* Lane3 Ref Clock Selection Register */

This is common ref clock selection and not lane 3?

> +		xpsgtr_clr_set(gtr_phy->dev, L0_Ln_REF_CLK_SEL(gtr_phy-
> >lane),
> +			       L0_REF_CLK_SEL_MASK, L0_REF_CLK_LCL_SEL);
> +	else
>  		/* Lane3 Ref Clock Selection Register */
>  		xpsgtr_clr_set(gtr_phy->dev, L0_Ln_REF_CLK_SEL(gtr_phy-
> >lane),
>  			       L0_REF_CLK_SEL_MASK, 1 << gtr_phy->refclk);
> -	}
>=20
>  	/* SSC step size [7:0] */
>  	xpsgtr_clr_set_phy(gtr_phy, L0_PLL_SS_STEP_SIZE_0_LSB,
> @@ -573,7 +577,7 @@ static int xpsgtr_phy_init(struct phy *phy)
>  	mutex_lock(&gtr_dev->gtr_mutex);
>=20
>  	/* Configure and enable the clock when peripheral phy_init call */
> -	if (clk_prepare_enable(gtr_dev->clk[gtr_phy->lane]))
> +	if (clk_prepare_enable(gtr_dev->clk[gtr_phy->refclk]))
>  		goto out;
>=20
>  	/* Skip initialization if not required. */
> @@ -625,7 +629,7 @@ static int xpsgtr_phy_exit(struct phy *phy)
>  	gtr_phy->skip_phy_init =3D false;
>=20
>  	/* Ensure that disable clock only, which configure for lane */
> -	clk_disable_unprepare(gtr_dev->clk[gtr_phy->lane]);
> +	clk_disable_unprepare(gtr_dev->clk[gtr_phy->refclk]);
>=20
>  	return 0;
>  }
> --
> 2.35.1.1320.gc452695387.dirty


