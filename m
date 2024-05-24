Return-Path: <linux-kernel+bounces-188662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BCC8CE50D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DA41C20FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9953185920;
	Fri, 24 May 2024 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HB0PoGGQ"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2047.outbound.protection.outlook.com [40.107.13.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745408624B;
	Fri, 24 May 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716552529; cv=fail; b=HuFLxR3/FLWclQuCatZhFv438SNiMbbOb+5di7lL3IWCNfsYpIU4K4fPGotLWDFp6sPmepOnIQ7duMGspoXzcorZ+WSioeMpH1tIiAW7DcJBYyqAuHgynaEoz5vmMw7ABBpYn/iStSUvv5hvfb1mHtXENKWGuzbm6r2dqAL/i1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716552529; c=relaxed/simple;
	bh=/jXkSZql8M0jGiX6xkMHwAOb0t8jKFI0hHNaD4POuOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zgxrsxhq8TGkr2Yx8KiNidvZcG/XQWwDFEXqsldvjoA7AJN+oZfmmNQJ6CcfgxtXzpzwj5WniaCChZznxl50r8ZCE6mSknyXQACLNflWCMA9+2sskCzjZQspzimEs1yVAb12VNKUuWT2+8s46JNXOt50tRp8C0KDr1bypqbrKmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HB0PoGGQ; arc=fail smtp.client-ip=40.107.13.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUWZYXf+sjiiX9XD6dQDrZdmxwIt0EKxYOpiNdsTfRLqVWWN6i97SurdNdGgVS6/D+iQInM/E3qeh1wVsrEpbozqHCf/5Wd9+X/2fwJFChgvbFpAwn2cTeVy5J2t7CJGYKGv6Y8mJjuuQasYuxp8man2M4wyulLCVodISkg3q/9ZFAvL8hQ+rlUAI2yXoEgqoOtrI/Gwy/cV2TvfVw0qRhzsukwrT0W3gfeeeyZ54uteJX8uTJ6om5x28bOvKaOT8PH086W+YXOnu902qCYX+gCNmVtHhkqdzOnidhooJL3cuJvHXbnFSmoYKNEMbDRn50uzyLbGNpspLhVwFcYtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE+OFOt0hiLRJCKAnFaXxagGL2kfw3QyMFxOQIK2lTA=;
 b=MNFoddeCmAusQ4MvCmMuRPSMkznUOlQDcDCDS8Sx8PFP8/4QnudqODZy1lBK+Jn2ogs9VxwAHDR9deKCOfd9LEVZiDC2FDSdtErNnKfew5eZDy0LhYjJ9qUArE/UAT5p5pEA7KUudAfS0yvheqcfWX1vphGBeQkNA5hXG2FVJRBDn/QG4CBxSPLRHZ7uqp86elNZnzbsPVNLvpEGg0TF99tt89XlyL93TNIvSWMU0QsTG1SH7f4DpI2U8orWp9Ir+n56u6WlyOLs4EZmnZvWkZGyiGkeHIxvIRvvsypzDT5dK1nQDsteV4nNmJKCsqdax1lLvfJ/cJCvyOO91zXvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE+OFOt0hiLRJCKAnFaXxagGL2kfw3QyMFxOQIK2lTA=;
 b=HB0PoGGQZgkIKlo9gVOAgeHgZPL4HekNIP5FaC5vyHf77h2ih3ulxHChxjSCYS3XPlpknLW2jbaASosySjv2Sgumq1Cl1+h8sUFMChSvo478auxgazh6qCudIn+IpXRownoSuEBoh7bhmeQPbS6YaC1vwLXAPmCkdPAT0DI+p+c=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by VI1PR04MB7053.eurprd04.prod.outlook.com (2603:10a6:800:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Fri, 24 May
 2024 12:08:43 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 12:08:43 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Pengutronix Kernel
 Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Topic: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Index: AQHarP9ayLdOqCtfLEqTQR0Rf+AVuLGmNX6AgAAVodA=
Date: Fri, 24 May 2024 12:08:43 +0000
Message-ID:
 <AM9PR04MB860484B8E16451E12AC18CE195F52@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-4-5a6fd189a539@nxp.com>
 <ZlBwNbkFV1fcnPKE@pengutronix.de>
In-Reply-To: <ZlBwNbkFV1fcnPKE@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|VI1PR04MB7053:EE_
x-ms-office365-filtering-correlation-id: 7a7b03b6-93a9-4e14-5e3c-08dc7bea41a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4lIsSo0ivWXho0NQlqj5qjsW9+kOONVzg6RRfuixsmwWwu1rg6cVLMZ4+Lc2?=
 =?us-ascii?Q?vYD/hM697NqJ0WHkBynOyEgcwj5XfWybT72w4fKYX54Bg4OQeUNzHiygp9bH?=
 =?us-ascii?Q?Ja3wGHm2Zg33mH82G36S4dKxWdYNHD+awYtZ4xdZh8RKA/hn5G74QD4ebyck?=
 =?us-ascii?Q?PyB1Y2LJtUo4n6CIMDOrxuCJ+1+M4LQUubIRKHVYX+DjW7wOO9IuOLgLPqY1?=
 =?us-ascii?Q?EbJ7uHsPS/nQb29ZBEX+eoVk8ty7PiKgItvOuJ8y/gHIhcIA98lChE48bcLz?=
 =?us-ascii?Q?fUIS3b0ZzIoZ3FfOfy/WLpbyRhPQuaeCYsWtyaryEBw7xe7i2wz1jFP5P0fB?=
 =?us-ascii?Q?xJc35k3tB4470USjztznVxt8sD+oPiGTXXbkbyNe8aB82jTdlXgJFHv3j41e?=
 =?us-ascii?Q?W/E34aIz9XxY2+vcQIy9uwn/SwtLwcYDjTDm+I6YkIXRzbqqN/KH7CzlyV/b?=
 =?us-ascii?Q?HW1la68t4glg3XJXzVNmzMLVbcoHa4IwMNTvLeBunHZjOKA+qznq3OyO75GI?=
 =?us-ascii?Q?dWI17C6fxeEqC36i5JtxIpCn23szD6tH9heUGZfdy2L78D3e5HpvcCbM0gq1?=
 =?us-ascii?Q?aW8lfLVWoMs7snBw/ZE4cXWztHObLN/PQ3zURRi0X1bJVYQasLZle9VkDStA?=
 =?us-ascii?Q?KldHTWsCNLoSrt3zlMyQXXuUig9aOh5IycPljDwKgr+lR/HeYlNa3wPoC90c?=
 =?us-ascii?Q?+VNeyWCh6+B/E0yzetRjoyQ/nlD25ZLcHTgvUoirI23hPN5tC8cd52Fl2n0p?=
 =?us-ascii?Q?K+PgAKElE2M7bxdfP6aIrH3RPAiAES8GXxlZ3Tw+hg8MG1HJYlnmrQmeDYNA?=
 =?us-ascii?Q?G7eouv5InCujdWL+VheyEId7U2jXp+YfayulqRxn7S8blBnYMtYrQccplsAS?=
 =?us-ascii?Q?IyfIN8IpdUGm/vSMQDkHjhoQixEimalf69mVsMaH+kNqFKE1rij9GM+2AJe1?=
 =?us-ascii?Q?qWZFEIrx8CT+i0iMT/XAC/Qg8WKzMpM2ABNapkIAB2/gOvE0ariDhjg4S8PY?=
 =?us-ascii?Q?uwlyEHclbKR4BXV5S/yk6NgDTMgVTYcf0O7CoU2hx/kKcLt9RNW5w6MTNeWZ?=
 =?us-ascii?Q?fmuxEdI+HMvayENoAQs0EKgyKOmNI6VhcwydN1IJwanA4BUHpTdvJZqGPYYS?=
 =?us-ascii?Q?qHh2zTBW4JMhQ/NrW46YaqlVFxAKifP5rWlfkWeJnzsx79tC/ct0BCmGW6Ao?=
 =?us-ascii?Q?Q7X7RBe+ZKOMXkWDtaARhioo/OQAvGtzrRjpAw4jNCng+U8UWw2OLQWWonGt?=
 =?us-ascii?Q?aklVk0iKdIGYXitF3n83WjY6VOVP8RHSGJ7gBrCJ2A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h/vDpYI54benleoOCxgvjH5p7TQ/uYnp7q62INyUpNdJG6+G+0F9RGWtJBhT?=
 =?us-ascii?Q?Mny/2MUPeOfzdpUX17r4+8eFDMo8VK4so0k3krNg2VNSVCNmWN9+0t9dWcyE?=
 =?us-ascii?Q?D3fwqfnIzI7eoVcB/z3mhK0rFx+aQE3/kwRD+t77QM/x12aCvxEovDPtLmSR?=
 =?us-ascii?Q?M9P/Qf8rY6OoTEO0Kfi35q27nnKStcpzNSudEsGsdIFr2lWpN90MvMgZOYPH?=
 =?us-ascii?Q?kgv/qr2Gphw4f9vSfef7+GnH/rPIMdYttvOfmM+ozXzAzM2ItiqrNAcT/kG9?=
 =?us-ascii?Q?adOI6unjv7cgJzDggQsZBRUMb4n0PkfTM1pZIdHiENSHDFaG+fkVdZMrlbJC?=
 =?us-ascii?Q?+UxARsQ1YrXlxdosKblCCTwHdxNmW8TUd3TIjoPNvAALergQMse3rN7U7EUB?=
 =?us-ascii?Q?qiSklB5Q78TPKOjazuMDjOnYKOox+PduIGV0S5EvAei0hzbb+eyrxbFjxzDu?=
 =?us-ascii?Q?tLmz4L1uYLcKczBXX8CLpgM9/kAFSejZSzcEmx4VBBNKX9MqR0SbRs4QRhki?=
 =?us-ascii?Q?DJuGV43kmbGfM9w9SK+5WNQn7azqPiyB5+kVxi5ZwkP413agFLkWtk3SC65L?=
 =?us-ascii?Q?/hsr1/NnsMw8snqtnoL8hrphmJE4qFvpcrp2UXxJC/92adnnYfeAQ3Ecb+G6?=
 =?us-ascii?Q?YCrTuBSbNzUHawcLolfaxDewSkPb2llB8oG651Oc+VHLSEYrMDhowSWsNjuA?=
 =?us-ascii?Q?+7NXmTvXMD2ag5mGPdHHglCrbP1gr30y40Ya7EeLSHX8ukFOe3g8wIMAlZMy?=
 =?us-ascii?Q?Z/fQ9DDjVeAWtgdhQGeEEjtwfqNvGscMs3ngm5bSoPdPpYKE2iUEyWU7JJye?=
 =?us-ascii?Q?yDY/4x1bvdemIEbkE1/sZLRpSANUkJeacc1VEXMzJsF+gL8rvkn311rHiP0Q?=
 =?us-ascii?Q?1KD4A18eW3Qho/WA4/An5RaEuSXame2lRk8Bnf3qB4kwlpC2ZcNKXIfiZD+Y?=
 =?us-ascii?Q?6NoHlenGVEm0Dd4+FTQdQ8xuhrISPwxXYXxWbInZh4XXoDXMb3fUms7MqvFx?=
 =?us-ascii?Q?BsqIsGgzLoiOeyRJK2+UJwkI6X5IYvsTXg4QM/LCR7mTYFUSd6lcZkKUlfa0?=
 =?us-ascii?Q?du3i7nI0o0rt6XDb81k3704M5Yzlg7IVdJum9xHIIlmhs7Iq/SWTR5B14tCo?=
 =?us-ascii?Q?Cz0hAQrRXCXtXVO92ciJ984SdL96N2NXX0LL7n7zUzU69nPHHoLb10P3nyga?=
 =?us-ascii?Q?vcfSgtMzLnd1xCti2mvFYw+60W+s99ZCQ0ShOsZXEjd9p+wUo+GEDiLp/yfl?=
 =?us-ascii?Q?ywjXPHjIDmJJse2HsOQINV7RpDmN+b/YOjqS4hj5KOLRh61tOWO+u5/AaX+3?=
 =?us-ascii?Q?wj7AEdCLVoE6LwmlNg4az5AyD+x4yl6YlI38qlzaSxe9sDSPynHWmtlv9Ydd?=
 =?us-ascii?Q?6VWY6N43t854KguH1QBJvY0DeYcH59MFlSrYVyd9RFnaELt6AP2d7CgkvQWE?=
 =?us-ascii?Q?Ui57bEVX88RpEzQAGvhw9LUqoKnLhQmX/SB4BhlQmdK8d2Q1akZ+9Jt2xs8q?=
 =?us-ascii?Q?br4gVUfwQKztMYAacSjUIkpfEVaotozDlj22lseY7EyaSOCtaWyV/dbhg835?=
 =?us-ascii?Q?PK1GA4U+2j3mA0QjR/Nl1G3IXQGS3uFPkeVlsUt1?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7b03b6-93a9-4e14-5e3c-08dc7bea41a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 12:08:43.3692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3+3RF1v1nMp1FzrXCc+/Mhp31xyW9/r/geFF9+SL7dZWvqiFqG0vxrzOj4ySZU7GteXFt64zcQuRKetPF0ENQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7053



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Friday, May 24, 2024 4:17 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP EdgeL=
ock
> Enclave
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Thu, May 23, 2024 at 04:19:35PM +0530, Pankaj Gupta wrote:
> > NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE), are
> > embedded in the SoC to support the features like HSM, SHE & V2X, using
> > message based communication interface.
> >
> > The secure enclave FW communicates on a dedicated messaging unit(MU)
> > based interface(s) with application core, where kernel is running.
> > It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.
> >
> > This patch adds the driver for communication interface to
> > secure-enclave, for exchanging messages with NXP secure enclave HW
> > IP(s) like EdgeLock Enclave (ELE) from Kernel-space, used by kernel
> > management layers like
> > - DM-Crypt.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  drivers/firmware/imx/Kconfig        |  12 +
> >  drivers/firmware/imx/Makefile       |   2 +
> >  drivers/firmware/imx/ele_base_msg.c | 286 +++++++++++++++++++
> > drivers/firmware/imx/ele_base_msg.h |  92 +++++++
> >  drivers/firmware/imx/ele_common.c   | 239 ++++++++++++++++
> >  drivers/firmware/imx/ele_common.h   |  43 +++
> >  drivers/firmware/imx/se_ctrl.c      | 531
> ++++++++++++++++++++++++++++++++++++
> >  drivers/firmware/imx/se_ctrl.h      |  99 +++++++
> >  include/linux/firmware/imx/se_api.h |  14 +
> >  9 files changed, 1318 insertions(+)
> >
> > +static int imx_fetch_se_soc_info(struct device *dev) {
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +     struct imx_se_node_info_list *info_list;
> > +     const struct imx_se_node_info *info;
> > +     struct soc_device_attribute *attr;
> > +     struct soc_device *sdev;
> > +     u64 serial_num;
> > +     u16 soc_rev;
> > +     int err =3D 0;
> > +
> > +     info =3D priv->info;
> > +     info_list =3D (struct imx_se_node_info_list *)
> > +                             device_get_match_data(dev);
> > +
> > +     /* This function should be called once.
> > +      * Check if the soc_rev is zero to continue.
> > +      */
> > +     if (priv->soc_rev)
> > +             return err;
> > +
> > +     err =3D info->se_fetch_soc_info(dev, &soc_rev, &serial_num);
> > +     if (err < 0) {
> > +             dev_err(dev, "Failed to fetch SoC Info.");
> > +             return err;
> > +     }
>
> This is called unconditionally but is not set for i.MX93. You should eith=
er set it
> for i.MX93 or check it before calling it.
>


Accepted. Will correct in v3.

> Sascha
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.pe/
> ngutronix.de%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C104138b
> e4be445f8222608dc7bdee29f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C638521444411216377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%
> 7C%7C%7C&sdata=3DMgDkY1PHo0qrLpw2IBCxVf4NVy3C3OInhb%2ByoUwib%2
> Bc%3D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

