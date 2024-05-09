Return-Path: <linux-kernel+bounces-174114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E410A8C0A55
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764881F23107
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739C1147C9D;
	Thu,  9 May 2024 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CwbSLbq4"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614CD13C3F6
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 04:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715227474; cv=fail; b=RNvQVneP9awWiAOh2lk5kBWawQHpfNg//JQLSfFXeyXFDl56jthYE5JlV43cDX/QPDIQIZTUN0iQ0digfmrD7fG/YetRjTIJvIpeRgwP5V0KKWD+2nnzC+46gFUmvo+5CgWvMfLNAutP4adXwmZ7FyR1Szp/1hsP6w5nNofwtcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715227474; c=relaxed/simple;
	bh=Ab8ii2MgeGExPC/sfpL5qmQvXBXyCfripOZMTA2wl0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=byBZw9zScWgdC+S3UqoTbuJsM4bL0LmjQGnAH3A/bWbsB1glLr0+0VNgOpMhRCEr6V+2y967L6sL3r0ApOlYtRa/wzh7arkZ9LDgXew3GxnA98b4mMcohRMFvnEXThp32MRQcKW4Dv0QOg+MdaWwYZPwYF5Mt0uCowUILyzReK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CwbSLbq4; arc=fail smtp.client-ip=40.107.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8G+y+tNHvXmRlyr42PYasSm+DUjjCHRNLxFieimX0MJsniQ6NwHMUumIT9aplNLjDoDrkaVncCCTgTN1PMgtLdp/nRymWyIuKyftL/K6rUuLWcpzLAXIxCrMXcQdYJFDopFwWuTmEFNm1KABbQi0jRAR36J8KoYX7wEU4QO/07RElH76vsZMvi5UlmeX+ZsB0F+rd225m92B4XdWdWwtDTWoQHgUPGjYCPxg/AEbJWAhJkh1DrxoTcgdsI23Ok0gxyxPmqCZ1yQF0S8oKCqPwUrANEq0fZ5bks7XAFcKdIywEmfYZ1nU0sM0NVMaLjrm3ot4zSXS4m08nxMVa5kfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ab8ii2MgeGExPC/sfpL5qmQvXBXyCfripOZMTA2wl0c=;
 b=W7hRI94kPFJkiFnNhgW50rL67Ey9wjl0LE1HkHufWingdYN2Ez2T0a/QG79HL/JFl8LCl5LAhQYN6AhttatHj3rew+EgiF2MsxnuBV/RoPJqKNjFrVu3FemhMBntRazkV7TrHM54nIzo3DdCINhhToiqb5lcoUC+we2KLyJzeQmG5ImXguKe9WQdtWvcdMhT1GlueQ7/3wE7pjAVm/rrRMmblkoo6Rl4wHxWARBewFUDFuMdm8itlDRBWGYKxtNtKAxyTeY2iBcKTKgomG8628iP0J6swlPRG+azfSVTNl0jv31yuiW+ZGAZMhG0VmdjZIdMp1dlUJJFVOUDjspKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab8ii2MgeGExPC/sfpL5qmQvXBXyCfripOZMTA2wl0c=;
 b=CwbSLbq46SnPtm7Kq2uJq8fUWHo7syQl47+/ByU/ocjGD9C2IqO9jhtX43qwC/hg9RQePM2AOoQWOhOzaZA75SSYd64ypkk7N3vxKFSAIcDioenvi2/cja1zEbdUCoe6iTx5ahUGz5lsMvBAbKVF7etmCmfCrGd84/YAHF/dPzA=
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by AM9PR04MB8843.eurprd04.prod.outlook.com (2603:10a6:20b:40a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 04:04:29 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 04:04:29 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Iuliana Prodan
	<iuliana.prodan@nxp.com>
CC: Silvano Di Ninno <silvano.dininno@nxp.com>, Varun Sethi <V.Sethi@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>, Peng Fan <peng.fan@nxp.com>, Aisheng
 Dong <aisheng.dong@nxp.com>, Frank Li <frank.li@nxp.com>, Daniel Baluta
	<daniel.baluta@nxp.com>, Franck Lenormand <franck.lenormand@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add
 documentation
Thread-Topic: [EXT] Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add
 documentation
Thread-Index: AQHam4j/tJCTK9tQiUWZU25vCayiarGCIcAAgAwypBA=
Date: Thu, 9 May 2024 04:04:29 +0000
Message-ID:
 <AS1PR04MB9358617BF0A5BBFA886F8CDDF3E62@AS1PR04MB9358.eurprd04.prod.outlook.com>
References: <20240501053205.1737248-1-vabhav.sharma@nxp.com>
 <20240501053205.1737248-2-vabhav.sharma@nxp.com>
 <bc812026-bfe7-4733-ae9c-444f1a64382d@kernel.org>
In-Reply-To: <bc812026-bfe7-4733-ae9c-444f1a64382d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9358:EE_|AM9PR04MB8843:EE_
x-ms-office365-filtering-correlation-id: be80a322-9a8e-42b4-6072-08dc6fdd1fe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009|921011;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AIP8CQmc+DC3e/GNpyUZq1oYK6NkadxyFS4yfeYw8h6ffBcW5+NE+BEv7km8?=
 =?us-ascii?Q?wfxXWZC9ugnvmTl+21O0JEYFRWowGaz9RfSUy83TA1EJFcbnDAhVWyGH1zNP?=
 =?us-ascii?Q?7SsEMLgX1MjpKsGcl0l/aa3hDj/F4N3raD/ApfJ+XRxgHhD9mgN/5tUswWY0?=
 =?us-ascii?Q?aYwcPTyEwcVUCmC5H5XZ4H3Q2T/vVoispksF6sby7lg0N9sgTRJ7S42C1xrq?=
 =?us-ascii?Q?LkPkd0bn8JdKxchjhClONnM+K8xCL9WjLuQDiC3I8DW2EX5yVFrHOGos6uCi?=
 =?us-ascii?Q?N2GhvxdPtXNsaLB3S28HmnOIvDC2BJ8L6ZdEkaf+CNwjbPg3MDexNPVR16IK?=
 =?us-ascii?Q?KMF2XwJQB7ej94zBEfuOsZbNWM081l2GJcHnUjHl4vrAMK23bJc/AOap2bYG?=
 =?us-ascii?Q?C9PylnuAE68g5C3X49Wr0IUfDlFHxZLMParAf0EX2waiOu3wV85N+KcWUT0m?=
 =?us-ascii?Q?vy2YrNAvQeeWO1CzrKsVAQeL4jTBa8cFcr2GatrF8ycCMqxGnD38ox0Fadlm?=
 =?us-ascii?Q?ELs2VTUh5YfyGyhQdeNhFs97zyJBiSotdxwnTVT2xmFYhqM79J4X0nGQMqxG?=
 =?us-ascii?Q?enfMcqc7Kz6E+7p5E7HDCFGimi4toPmDLDQCj12TBrr+UuEUtEN6rjISNSG3?=
 =?us-ascii?Q?HtsHLumZGuBkkJ070ezD/wIvFH9uwI87e25NEkpYXk8xHksV8ZclEKw44M53?=
 =?us-ascii?Q?RubIs888x+VhnIEmrBp79hVrXGM93yJ288Tje4gVay75weT1SrisWZwKhM8e?=
 =?us-ascii?Q?/CUS/NOI4TPS8MrPnX9BJqA2R0xsZpA11upYNSDRkYf1omklKmP52saN/9t6?=
 =?us-ascii?Q?+Q5cKEqBgRlrSCZ9zyPd4V6etsQw+sbRJQqZ4n+JlnNK1Ikap0Pqclj4iKQ0?=
 =?us-ascii?Q?dwaB0Hy7jhNl7BW/BqknVJgtpjAqkiaLRDF+KNlbveLh0PvN5JSMtZdr8Bir?=
 =?us-ascii?Q?zy7THoMsZ7ZnKx+naF4nSoP+OD0FAejZLyoVtQQ56ozT9Ei6YnkrV3uWsMO2?=
 =?us-ascii?Q?9h4fm4G4+6433aZYBKTxiFedzjfoQC48lTJV6cs5WF1J8mtEJ6y8AsAw18As?=
 =?us-ascii?Q?NjZuznc+IMnLiy3t+3AAQhXkJ6lLelAPGM7rAavIw61YD01NBlD1wAJAxj1k?=
 =?us-ascii?Q?M4l+pPFnnAziVhUT/SjYOHt2odPg695YsZCB8pFj/BpZGAS4VBX3H+/QIJhn?=
 =?us-ascii?Q?9GrnNNRRCXC5qFfuD0QEij4KzjSjpvh9FkPUHYggk4/isj33MpJ46ahkM+r+?=
 =?us-ascii?Q?Dtvex/IMLvwWdCFaCdjnG+iOCeFDIOHnkWjXZIZWqfPCiUpnuad+DwvUoDK+?=
 =?us-ascii?Q?xh0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gwMsP/kKL51qMBOFIUaHvezXk3ZLPMDDpGTANLV3nJq+f4CTiLij8tUbV7bU?=
 =?us-ascii?Q?wnCIyTFLitoEr4qLbJM6fiU0tRKA5M5eRYR+BzeubncpB+U9yV9sl0k1cWwQ?=
 =?us-ascii?Q?10NfYv03rbOoNtP72doBGxRMoy94v+IAR17eAtgh+A5ehOStc96K7O+m2L3L?=
 =?us-ascii?Q?OoG05hk3etQi2InmgKXozRG/m20lCdiirPGddoBtI9kGBIDLfqN31JgG0V2T?=
 =?us-ascii?Q?UA+5t+MJF8AxqwsjqFwx7smEJ6x8o+FeaeVtcCV+KKGdn5pQNKPXURZx46e3?=
 =?us-ascii?Q?Z7yD4cbgNzKhMFi/LgR+oxNnPzzu4nxdmemGOUlZUvYO90HlYnd2YhsryOaF?=
 =?us-ascii?Q?bzW/IGDtTgn43b/UnunWdLrKdpLhwMVfZvy/Ud8SCiMg3hjROSt+CQCPgaR0?=
 =?us-ascii?Q?6Ig1bJi6qgvg6bG5tuHnpu+3Xujz+wZzCPvcHqO+z62cNwXEdeU6PNU26H6y?=
 =?us-ascii?Q?CN7qUZk2eXNDzZhQEoNZyMN25/G3GZQPo7uPmy3PD3TmSOWTEs3z7DSFJRkx?=
 =?us-ascii?Q?1BV+6KQ5f+nJkbo2TFuzUA+/nhOwN5vCnBrTQTTy8I5gXtP6kYQwJ0yYuLw8?=
 =?us-ascii?Q?EF9CLkJb1sPbfqfyBMjDcm57xFN44fnvfHRYJdHng2XhXSFlbLvOnE4Q02cC?=
 =?us-ascii?Q?zR+QyAUfuO7dnnATkuHirovdsHqyPAA1HTm9V3fmGHiERwrDINruQeMyNk61?=
 =?us-ascii?Q?btEQtJEhyBAsjPr6LVi6NEBCemFd1H6FauEagkgJ9waDEsaLR0QTtez4IwUa?=
 =?us-ascii?Q?BOE9OJG9mqg84WKMvqTlnU2r/B8ML7T31FblUMqtHGGyqJHnpJIEuR8gwUiF?=
 =?us-ascii?Q?Mt71EuKVDWqzg2Q4tizwkWO00HQMka/ENJ5UKqppHourrSD93muiCK6aOUPI?=
 =?us-ascii?Q?i5InbJkF+8nBPaupsV+uyMUCYaAhpALZUQrZX2fr/sBQs7l6OPqsEHPw9DeG?=
 =?us-ascii?Q?A8rqOUHrTCX5OEpTOATMA8fvkomXgXwIlszXSHkyyoPsHIeyFBkiSKgoyB63?=
 =?us-ascii?Q?R+kj3eGsJcuZfSSuKpINMHxLhfDAOFJ0Kj3HQg4kwQHVtA2ziEpehcrKy/ku?=
 =?us-ascii?Q?EqCRrgjCze57yZfGjhZ90NkmcYMwzi1Qo6/T/JLD9L90picGioBit6eGdM94?=
 =?us-ascii?Q?6dAhNPAOcyP+xIcNLOeakCzlWCBeC74FKIVEGSZt6+3GwiOVzFt2ASDFzzbR?=
 =?us-ascii?Q?F5A44CTfSyXpdCCfXkFAM/WWTFZ0Imhxuar+I2PcQDVHaUj2Jp4rMO25rWZn?=
 =?us-ascii?Q?Jy+5cTBelfvgq+tTZFtuoZqOSEEATA1kP0nO2QKrcnaeg77NoSGnWbY8KFc3?=
 =?us-ascii?Q?ImzLok+qH3NnBoobt2/8H5ddySK0pgifDRoKThFRb2Ihld2oy+5e7E0kgufl?=
 =?us-ascii?Q?nlgol8eMZPOWHdxvPsTRaglP+VkzByZuXUan05fIbnwGi5ws3ufFFKnEoghX?=
 =?us-ascii?Q?S5zREnmwgZrpOEcrDEIiXn2CBPv87DeV7qN3vAzU4mOzFgc5DjsQe2j/bElA?=
 =?us-ascii?Q?TxexS3UPuQ7qKCOrIrAFPMIF5KhJ1ChrGebUNkO0CJ/HuEvBo9n4n44TM7Yn?=
 =?us-ascii?Q?P1cdcodbIXBAmhSIbwgp4TIkop00IpBmfyim3H8W?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be80a322-9a8e-42b4-6072-08dc6fdd1fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 04:04:29.2882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AzZR3R9CYqRpbFdeyxd477xAdfZVOmrBithChcsNXtslqI7j3ZYxyvyEZZ4B11uCqgbHWbkYyFxyYJ4yNMU+Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8843



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Wednesday, May 1, 2024 3:16 PM
> To: Vabhav Sharma <vabhav.sharma@nxp.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Ulf Hansson
> <ulf.hansson@linaro.org>; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Shawn Guo <shawnguo@kernel.org>; Sascha
> Hauer <s.hauer@pengutronix.de>; Iuliana Prodan
> <iuliana.prodan@nxp.com>
> Cc: Silvano Di Ninno <silvano.dininno@nxp.com>; Varun Sethi
> <V.Sethi@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>; Peng Fan
> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Frank Li
> <frank.li@nxp.com>; Daniel Baluta <daniel.baluta@nxp.com>; Franck
> Lenormand <franck.lenormand@nxp.com>
> Subject: [EXT] Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add
> documentation
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On 01/05/2024 07:32, Vabhav Sharma wrote:
> > This patch adds the documentation for the SECVIO driver.
>
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.b/
> ootlin.com%2Flinux%2Fv5.17.1%2Fsource%2FDocumentation%2Fprocess%2F
> submitting-
> patches.rst%23L95&data=3D05%7C02%7Cvabhav.sharma%40nxp.com%7C4e698
> f57f2be4e4b419c08dc69c39540%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C638501535958415388%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C
> %7C%7C&sdata=3D7NB%2FbjnqJStL2QBVTwGflgSSViD9n8TL78X85OtQX54%3D&
> reserved=3D0
>
> Describe hardware, not driver.
Ok
>
>
> >
> > Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
>
>
> Please use scripts/get_maintainers.pl to get a list of necessary people a=
nd lists
> to CC. It might happen, that command when run on an older kernel, gives y=
ou
> outdated entries. Therefore please be sure you base your patches on recen=
t
> Linux kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of peo=
ple, so
> fix your workflow. Tools might also fail if you work on some ancient tree
> (don't, instead use mainline), work on fork of kernel (don't, instead use
> mainline) or you ignore some maintainers (really don't). Just use b4 and
> everything should be fine, although remember about `b4 prep --auto-to-cc`=
 if
> you added new patches to the patchset.
Thank you for feedback and used b4 as recommended
>
> You missed at least devicetree list (maybe more), so this won't be tested=
 by
> automated tooling. Performing review on untested code might be a waste of
> time, thus I will skip this patch entirely till you follow the process al=
lowing the
> patch to be tested.
Added the required list
>
> Please kindly resend and include all necessary To/Cc entries.
Ok, done
>
>
> Best regards,
> Krzysztof


