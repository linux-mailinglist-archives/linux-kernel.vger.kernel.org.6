Return-Path: <linux-kernel+bounces-333135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DCB97C466
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA63FB226EE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C3118E033;
	Thu, 19 Sep 2024 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OnplDj4V"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125C18DF8E;
	Thu, 19 Sep 2024 06:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726728231; cv=fail; b=nyGf96d1gcqq9npGB/R5gHYW9z0FkHxqtnVA+/2g0XZqBlr7teiC7qsNaULk8J6wRfhh6IEdMyn8noMkPN2fbcWeVtTy8qObzHPv9/WLPaX6SUATRrN7bP9TbKYKV4dI7YJ5XI7ZAU1Fw2E4xXeVmeHcO0qcZVDH5S7r6+e4XZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726728231; c=relaxed/simple;
	bh=QIb2JNHKKsiJ++qm3RqeJ8R1iulhpSwsMviHGgqeaxc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hPZ7t5k04K2yCta1wT9kjcN7MicdWeLVgvjjrkgJMmY9cQ+xgDoJdp5peETEjP5dJPzeU7PPWZZE2LGNFZsA9tAwvQjpthMCzI2IBgadvR7nOoGYOxEjz94dANGerAobw8wnlB1BgfOlHN2Y9tEqDZsXcQkGjoGdKNwmmx8Doa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OnplDj4V; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBVTBb6KZXmkYY3b1/8emMMOftNeLR3tOtvnE6gmA/a/G2rCqJN8Wn/rFcrb90Ab6SGKOCsF8vFPphBYzUVTQtqxLNQWhQSZj49WuGmT6cyvo0eQBiDtwWpkdaYr3FQ95nCKFwoO1PUcwkiMBJ2TMNKxbwjwUYCCuVWRagjx5V/mIq2MbD4HxHhG8Y9r5S+QB9VcmABL1ywhIAeqV8BxemTghPy+6pL1s0UWB6xNQBgMCc9hL5Cmxo2UdId4B/JiRkelGlywcf+rUBTdKu37DZK7uerr9rRYmHgrogUqpFIlRvv9PksarFIboOzdfea7rAdmPEczXsWDFmGk+8kVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1RY7AbF9Y1QJmrvnSqF1/Z5eLsQwXFW3QpZ/p0AtSU=;
 b=Lv4EO5O0EN2EKXStjXIxdgxBMCkXh0NWJaQ0y1yiB4dyefPi3U9rCgSgxl6S7D0WfTjA941P1gqkyGWrE44RplSEqZZTMC0HnX3fNlqT2hF3GfwXIGIzyXNFueYxMCM6Mq5uPq2K9DPx+OS+rrIA3xhrgZRcYyq2uShXEbRTCj5+WPnIdkczaQwhg3Ze6qQd4eYLqe25KKjt5aPXGqfU/ZIkg5ACGSzHS4HynXYy/UTf0RGFJ1QPV3y3YGE43Z0eYC4XhfcfguSWqQAJrHCJx3fqOPibEGN8ILs7uGNpPzWePo2UdAVNHssu4dFCgzQ3wjGEFNOomDhSr26PrJLWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1RY7AbF9Y1QJmrvnSqF1/Z5eLsQwXFW3QpZ/p0AtSU=;
 b=OnplDj4VtL4XDvXJzeDQ2zXeQrKWeJperQILWl86B7jC08QcqJACRPMENFHHwe+TeYtFHIWcNtfAY3x3LHdcexSlEN7iHDoWdG+jm9hGyKfxFmRbvt+vIl21JSMsjBFgz7Xxo175NvSYRqRgfs3uc7boji319EggQ/R+xnn8ylPLecx1yuY28k6ItVFKxrZvOkkap4tCn2FvcIfApaxKG8R22kAxjer0c+LTYGROxjk4OQxuR4H/nnZiNimutpVml9eq+BAqZ2vUlK2NJ7zQtijFic6ikvJoJLvm7FynpED1vdymG5SqBIHDd1PbS9tQu1hE4a4p47qckgYAfqsP9Q==
Received: from AS8PR04MB8593.eurprd04.prod.outlook.com (2603:10a6:20b:424::14)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 06:43:45 +0000
Received: from AS8PR04MB8593.eurprd04.prod.outlook.com
 ([fe80::7649:d0cb:11f6:e55d]) by AS8PR04MB8593.eurprd04.prod.outlook.com
 ([fe80::7649:d0cb:11f6:e55d%3]) with mapi id 15.20.7918.024; Thu, 19 Sep 2024
 06:43:45 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v7 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Topic: [EXT] Re: [PATCH v7 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Index: AQHa/rj+Xxal5gowYku20JmR9i3Hr7JPZ5YAgAqyPAA=
Date: Thu, 19 Sep 2024 06:43:45 +0000
Message-ID:
 <AS8PR04MB85932B4E47EFC519B0EF6D9A95632@AS8PR04MB8593.eurprd04.prod.outlook.com>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
 <20240904-imx-se-if-v7-4-5afd2ab74264@nxp.com>
 <Zt7n0AxGEw-ZXbui@pengutronix.de>
In-Reply-To: <Zt7n0AxGEw-ZXbui@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8593:EE_|DB8PR04MB7020:EE_
x-ms-office365-filtering-correlation-id: a0ec66f9-e49c-4056-1dc4-08dcd87668c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FTYAVGdThf1Z6IIW7onod65pJwSxLjqyBOkl76vMmcOyGeL/a8r8tZjw1gQ3?=
 =?us-ascii?Q?CKdCwE5hCuiYo2BikuuRhg0uWZu0NHPYW9ugLGvx6P5QGSlGi7v1rwHLhnqn?=
 =?us-ascii?Q?FCBsjxpO+hdwlcALS2cL9sBtFKMyxH3KG/UXsMbPCh7WDOFvhgF25bpXJxQW?=
 =?us-ascii?Q?xK6zV1floPJkEC5qW3klLcgD1C1cXl0bLzyL6TNipIzPJP2g963ws/eoviXA?=
 =?us-ascii?Q?BpZdmfUPlivxkpEH0li4MdpFXFp8i8uNRyywhFZ/IMH2LPCXZCvz5yJKrTaj?=
 =?us-ascii?Q?iGl9cqhiFP8MwPlueMwzaUaVZWOuHWsttyQ8/gwidnCiADtdW3OTUqBNxrT+?=
 =?us-ascii?Q?llMdg7xDzly5iDEsJhXrMEnNnFJNiKsKEAlRQdWp+vFq6YBC1xplj7uhA+nc?=
 =?us-ascii?Q?yL3kuhoyO4csstZ1D5ZHSFHfFboPm+/iEyn6+/iWFHzBd/eVaZpU5nXUwLHb?=
 =?us-ascii?Q?hFtXfWU9HUO7N6ndrwB68WrNzbyekziILbtld+cn1WAZqYLTER5YT65VxVCw?=
 =?us-ascii?Q?F1+lenrYfnHUo+zoUUI0p6i+nUxrqkxg2R6PceoFXg3gKYhaRCbNuN9KXF+M?=
 =?us-ascii?Q?ChYs5SCFHyec0qhxlj5pIXoa5wAlVaSvn/7esYh8J7XUbqesQGxs5CewPCxA?=
 =?us-ascii?Q?353qlqIhqD+8wLOjdjlPIehFl07cudxfVACAiRk+YLs2Mnn+/kkFL5CeGNqb?=
 =?us-ascii?Q?+eBWZFT98LQPQ+a+xaL7WgoGV2TbknUy/ksCpDrLi3ClQmRxuEMIyndru5kw?=
 =?us-ascii?Q?8DSrup97ormTbVjxHp5Rb4Atw6hABCNRIOTDrxBeMrF2UE34lVRKncdFVhfs?=
 =?us-ascii?Q?btU1P1TRxI4zjN/2S+nbtdoZPmwkk9vPqd6K3f9H6iAMRvFxrg84I4dMPnkV?=
 =?us-ascii?Q?TGi7VWk8zw87t0OBhFBzlf6hJpTyYNzqs6ris+HzI7DQEmd399vJBefwTBto?=
 =?us-ascii?Q?CBknnrzYOvwUc+3Ovuu4Fl01G2woyQeT4dPtzqclEGCFwPN356RPPcgWwBIL?=
 =?us-ascii?Q?n6EdFQ4KCHSeIl8pzTq2KHLAlhCfnQLYLfYtbP5yvBxo9UbasF9Vjxp31+Es?=
 =?us-ascii?Q?eheZ5ehDnarPDxPxa7rqGuuuC893F1v9x5Zj9/GEDeBJAlHeRlQBHi0iPprQ?=
 =?us-ascii?Q?Ik4bpsWOBedG3rtAXMwNcFJMSbfHobc82RNT+7QItvXn+c3dlKNhbdM9IWqt?=
 =?us-ascii?Q?/BnwIS57955AyVJScd0piF7yGPBhsQeghJ/NTBnlPe4bzlLHNLUZSSCZS1K6?=
 =?us-ascii?Q?prFLxW3cNZAfsnQ+UA913HuEMZ/1ZZowd1rj+CsH23mE7xyoS31wloCsD1jL?=
 =?us-ascii?Q?3FsKxqpcshD2mamPvkm3k/zfnZUm/VfYtymQLIbAAFr6Gvhc/TfJ5RcTFoZH?=
 =?us-ascii?Q?89ttnDo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8593.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ox1wo8jlJGNmIXtxNdvNJmIV/oO3WfoBk+yUqNJH60q8bzl/Glv/xubE8TJa?=
 =?us-ascii?Q?ZrC8vfMEzqUE3bihMcCg6CdEnLDWmZGY2om2DzE+yadg1y1QUEWAvDDjATO+?=
 =?us-ascii?Q?CBauZjuLMmf3nQ+OYKI0PplBU0SOuNHsQJlfOGSaJVDD2JrbdiyYrg93vUf0?=
 =?us-ascii?Q?Y8zfDSGP2t8f3crW1cavfI+CghMyricjdvoxvzZUWXULIhFEneRqrQ5agt7/?=
 =?us-ascii?Q?2GYBtqhbAPDV/wsFB0U55Ajrip3ej75uradCZ+N8m8hQOWg1ZYG4nChOhZgq?=
 =?us-ascii?Q?CE42nam+HSr4y3P2iafickwQuhldysw/egFMzcdnJxezqpk6GRbTIWfb8616?=
 =?us-ascii?Q?NSZNRnuSfzPnx/YUrSVBXhOjlGSAtB9af2y+Ct16fdSNPHRSSa2BiGIIwbLs?=
 =?us-ascii?Q?S3j3NgytUX7dB92KGbsRFTLm+82yJ5+6P62leVJiXcxLOnSpC/v2bn7Ijm87?=
 =?us-ascii?Q?dDEh31hhpogUyETrUPMiIkxqeI1+sQLO5Ap9adSjp9s4z3So0wa1DA9a8+QS?=
 =?us-ascii?Q?NoxsvQDBE4Ru4NfbSwQ8KWyWEEPdG5d9FAJwL6YPTrxeA5l5riXRyLF/YAVd?=
 =?us-ascii?Q?j0ENESAdADUqFN6eO9eOyZcTBf208NHfazVqPWBp3aCdrWJ6Lu7OkzRxuzOJ?=
 =?us-ascii?Q?a76rFIcsm9E1s46mgr3+kKowCeSedEEs3tamlZrtMuqN7ke1uwRyYr4vPmut?=
 =?us-ascii?Q?lf35etmR8I5Y3sdmRwv9FiN5bWSk4PxFbjZ+AZILZvRUy0LLlcUX73vI2V11?=
 =?us-ascii?Q?pRshJzQpYgp8h/uydEfa/3Sb6UvMtjo483IEt/nsODJvSGVmPgXcRvUlsT1y?=
 =?us-ascii?Q?0k9GTaSWgQwnSBmOVTpmvGsT+PnZ7PN4G2kLlcNhWpLAf5YHWCNvVNBLiVFX?=
 =?us-ascii?Q?biECIaVtppwPaeu7yMz5NFWWbMw2VLxT3sLq/xkD3j1cfBGffk/UMOvgfKn0?=
 =?us-ascii?Q?3Irsi829MbBVyuw28DmSCz0togml2BwShiMacrkU7lKwHpL7DdHdVLBK2b5Z?=
 =?us-ascii?Q?IMoLZ0hQRHjwl3ZEPJC9Dq+Jk4zJUX5jjnJmPPqDH2VN3Jje8S4l1f2nKmA4?=
 =?us-ascii?Q?6YgwJRUTpMdyoPtaWgY2XEyg1WYi0S+dl01+R5ePa0QPmPfU8u6fLlhVQfRm?=
 =?us-ascii?Q?siWJy77OMOH8F5GaapQ3Omw95gHLBPbq2guDnF6HIZR0V+fVDP106y7Aj7Pq?=
 =?us-ascii?Q?mhZnMNkiCNKsj95RiUWOumZ91SRAr9l7u4NpFHWwB1tdzQtTWOjboLWlIBMZ?=
 =?us-ascii?Q?qoDFNXsXE6W63GW58funA9THFgOzNVcteDQ0GH/zmFYn5UWXNRWpRP2N2qXC?=
 =?us-ascii?Q?c9gEMK1COERsjkLqiSsqZWAvcBqL4bMhcW85dBrnC61iPpkmW+RhlIxJBK/7?=
 =?us-ascii?Q?7Uxhn1OCFx2Qazi5oAcKcxtwIgbTFQmyGnT/ccCTo990/J5l56tI/4hJrBj8?=
 =?us-ascii?Q?TkELRIrrDrmExTU2TPNmAKnG0gsXSjrSn5OzMLaPft7H+oV5IlWcMIiVsfez?=
 =?us-ascii?Q?hF0e/RQYeb+ryrBb9g3ogLJEAyLagkNuJUMNDKqvcuPgDQdZA18ByTjuXSeB?=
 =?us-ascii?Q?VSg+ejkoYSNbDIPnEUjV+8OoSqOTiTa/KpHXuNoe?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_005D_01DB0A8D.5DE2C210"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8593.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ec66f9-e49c-4056-1dc4-08dcd87668c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 06:43:45.4754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNz/5Nzk8ueunzpNqeqUZ8Xo4v46Du7ux6m46bI6EIIvQy2tX4wsPcSv6DLx2AXpSZCEmlEj9uk8uFxZbu1h1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020

------=_NextPart_000_005D_01DB0A8D.5DE2C210
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/firmware/imx/ele_base_msg.c 
> b/drivers/firmware/imx/ele_base_msg.c
> new file mode 100644
> index 000000000000..e3e570a25e85
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_base_msg.c
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/types.h>
> +
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/genalloc.h>
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +
> +int ele_get_info(struct device *dev, struct ele_dev_info *s_info)

I repeat once again:

The context pointer argument should be struct se_if_priv *.

Do not expect foreign code to pass in a struct device * here from which you
blindly expect that it's the right one.

> +int ele_fetch_soc_info(struct device *dev, u16 *soc_rev, u64 
> +*serial_num)

> Also here and all the other functions in this file.

Accepted. 

> + *
> + * Header file for the EdgeLock Enclave Base API(s).
> + */
> +
> +#ifndef ELE_BASE_MSG_H
> +#define ELE_BASE_MSG_H
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +#define WORD_SZ                              i4

> Unused.
Accepted will remove in V8.

> +#define ELE_NONE_VAL                 0x0
> +
> +#define ELE_GET_INFO_REQ             0xDA
> +#define ELE_GET_INFO_REQ_MSG_SZ              0x10
> +#define ELE_GET_INFO_RSP_MSG_SZ              0x08
> +
> +#define DEFAULT_IMX_SOC_VER          0xA000

> Unused
Accepted will remove in V8.

> +#define SOC_VER_MASK                 0xFFFF0000

> Unused
Accepted will remove in V8.

> +int ele_msg_send(struct se_if_priv *priv,
> +              void *tx_msg,
> +              int tx_msg_sz)
> +{
> +     struct se_msg_hdr *header;
> +     int err;
> +
> +     header = tx_msg;
> +
> +     /*
> +      * Check that the size passed as argument matches the size
> +      * carried in the message.
> +      */
> +     if (header->size << 2 != tx_msg_sz) {
> +             err = -EINVAL;
> +             dev_err(priv->dev,
> +                     "User buf hdr: 0x%x, sz mismatced with input-sz (%d
!= %d).",
> +                     *(u32 *)header,
> +                     header->size << 2, tx_msg_sz);
> +             goto exit;
> +     }
> +     guard(mutex)(&priv->se_if_lock);

> Drop this mutex. All it does is to protect mbox_send_message() which
already has its own locking.

Accepted. 
Since the TX buffers are dynamically allocated. There is no chance of
TX-Buffer getting over-written.
Will remove this in v8.

> +
> +     err = mbox_send_message(priv->tx_chan, tx_msg);
> +     if (err < 0) {
> +             dev_err(priv->dev, "Error: mbox_send_message failure.\n");
> +             return err;
> +     }
> +     err = tx_msg_sz;
> +
> +exit:
> +     return err;
> +}
> +
> +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg) {
> +     struct se_clbk_handle *se_clbk_hdl;
> +     struct device *dev = mbox_cl->dev;
> +     struct se_msg_hdr *header;
> +     struct se_if_priv *priv;
> +     u32 rx_msg_sz;
> +
> +     priv = dev_get_drvdata(dev);
> +
> +     /* The function can be called with NULL msg */

> You already identified this as a possible case...

Intention of this comment was to give the reason for checking "msg" for
NULL, before using it.


> +     if (!msg) {
> +             dev_err(dev, "Message is invalid\n");

> ...so why print an error message here?

This will help, know that there is incoming message with no length.

> +             return;
> +     }
> +
> +     header = msg;
> +     rx_msg_sz = header->size << 2;
> +
> +     /* Incoming command: wake up the receiver if any. */
> +     if (header->tag == priv->cmd_tag) {
> +             se_clbk_hdl = &priv->cmd_receiver_clbk_hdl;
> +             dev_dbg(dev,
> +                     "Selecting cmd receiver for mesg header:0x%x.",
> +                     *(u32 *) header);
> +
> +             /* Pre-allocated buffer of MAX_NVM_MSG_LEN
> +              * as the NVM command are initiated by FW.
> +              * Size is revealed as part of this call function.
> +              */
> +             if (rx_msg_sz > MAX_NVM_MSG_LEN) {
> +                     dev_err(dev,
> +                             "CMD-RCVER NVM: hdr(0x%x) with different
sz(%d != %d).\n",
> +                             *(u32 *) header,
> +                             rx_msg_sz, se_clbk_hdl->rx_msg_sz);
> +
> +                     se_clbk_hdl->rx_msg_sz = MAX_NVM_MSG_LEN;
> +             }
> +             se_clbk_hdl->rx_msg_sz = rx_msg_sz;
> +
> +     } else if (header->tag == priv->rsp_tag) {
> +             se_clbk_hdl = &priv->waiting_rsp_clbk_hdl;
> +             dev_dbg(dev,
> +                     "Selecting resp waiter for mesg header:0x%x.",
> +                     *(u32 *) header);
> +
> +             if (rx_msg_sz != se_clbk_hdl->rx_msg_sz
> +                             && !exception_for_size(priv, header)) {
> +                     dev_err(dev,
> +                             "Rsp to CMD: hdr(0x%x) with different sz(%d
!= %d).\n",
> +                             *(u32 *) header,
> +                             rx_msg_sz, se_clbk_hdl->rx_msg_sz);
> +
> +                     se_clbk_hdl->rx_msg_sz = min(rx_msg_sz,
se_clbk_hdl->rx_msg_sz);
> +             }
> +     } else {
> +             dev_err(dev, "Failed to select a device for message:
%.8x\n",
> +                     *((u32 *) header));
> +             return;
> +     }
> +
> +     memcpy(se_clbk_hdl->rx_msg, msg, se_clbk_hdl->rx_msg_sz);
> +
> +     /* Allow user to read */
> +     atomic_inc(&se_clbk_hdl->pending_hdr);
> +
> +     wake_up_interruptible(&se_clbk_hdl->wq);

> You are rebuilding a completion here, why not use a completion then?

Accepted.

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sys_soc.h>
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +#include "se_ctrl.h"
> +
> +#define RESERVED_DMA_POOL            BIT(0)

> Unused
Accepted will remove in V8.

> +static void se_load_firmware(const struct firmware *fw, void 
> +*context) {
> +     struct se_if_priv *priv = context;
> +     const struct se_if_node_info *info = priv->info;
> +     phys_addr_t se_fw_phyaddr;
> +     u8 *se_fw_buf;
> +     int ret;
> +
> +     if (!fw) {
> +             if (priv->fw_fail > MAX_FW_LOAD_RETRIES)
> +                     dev_dbg(priv->dev,
> +                              "External FW not found, using ROM FW.\n");
> +             else {
> +                     /*add a bit delay to wait for firmware priv released
*/
> +                     msleep(20);
> +
> +                     /* Load firmware one more time if timeout */
> +                     request_firmware_nowait(THIS_MODULE,
> +                                     FW_ACTION_UEVENT,
priv->se_img_file_to_load,
> +                                     priv->dev, GFP_KERNEL, priv,
> +                                     se_load_firmware);
> +                     priv->fw_fail++;
> +                     dev_dbg(priv->dev, "Value of retries = 0x%x.\n",
> +                             priv->fw_fail);
> +             }
> +
> +             return;
> +     }

> Are you continuously trying to load the firmware here in the hope that the
rootfs is mounted before your retry counter exceeds?

Yes.

> Don't do this.

Shall the retry counter to be removed, to make it predictable?
Or am I missing something.

Thanks.

>Sascha

--
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       |
https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.pengutr
onix.de%2F&data=05%7C02%7Cpankaj.gupta%40nxp.com%7C332a105e5ed24741d3b808dcd
0c9a781%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638614811726643343%7CUn
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
VCI6Mn0%3D%7C0%7C%7C%7C&sdata=AzbLQ4wpSte4lA2myKQBDYRzSxhc72EcbVq42CcRo0M%3D
&reserved=0  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

------=_NextPart_000_005D_01DB0A8D.5DE2C210
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIImZTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
ggEKAoIBAQCsljsxzffby7IAt42e7cJH7K+49RL+7i56h3ORt8dS8WNVSdDlejp6uS6mLk/UX0wn
sSxDK1S5KquGJQzaT/3gxE8tdgvfFNBVdrgr48DeCVwWDr1o/UF3RmGcMdxqRz1M/oLDJ03C8n6h
L/0JXiwsNx0KZJoqDrN/48yX5TkoeKJmHFftZ5Op57xV0WkZJ/yLxSC1Om75jOG/UPdqsDzl+wi7
YVj5egV24hoaXgHBxtCeJzUgsHcJlo9nFtGe11j6H1vqFzkPzN9ydjRmhQATV/WLqpG8uot79u0m
6n7Mjwsd/HmJf+8xpovMcHPO2a0axppssKso/3APP6mR1FuVAgMBAAGjggORMIIDjTAOBgNVHQ8B
Af8EBAMCB4AwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAwGA1UdEwEB/wQCMAAwHQYD
VR0OBBYEFLNr0DCWM1fCXv4ubOt/elkvcoiaMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRw
YW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFua2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAU5TJ6
9GbBR5Ykf/wngDlY3ysX4rswggFKBgNVHR8EggFBMIIBPTCCATmgggE1oIIBMYaByGxkYXA6Ly8v
Q049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1ubGFtc3BraTAwMDQsQ049Q0RQLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2Jp
LERDPW54cCxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNz
PWNSTERpc3RyaWJ1dGlvblBvaW50hjFodHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFAtRW50
ZXJwcmlzZS1DQTQuY3JshjFodHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFAtRW50ZXJwcmlz
ZS1DQTQuY3JsMIIBEAYIKwYBBQUHAQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049
TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2Vydmlj
ZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jQUNl
cnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTA/BggrBgEF
BQcwAoYzaHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFAtRW50ZXJwcmlzZS1DQTQuY2Vy
MDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUuaklY/hMbNXILljX4C
AWQCAT8wJwYJKwYBBAGCNxUKBBowGDAKBggrBgEFBQcDAjAKBggrBgEFBQcDBDANBgkqhkiG9w0B
AQsFAAOCAQEAWS4IrHXWhCGNWk5vn20xV7mlLkM7JPwltVJzB6MRzwUB438upbyUMwNHcEgAmHcs
xL9hafErN+n9rLL00wEqZsCV732s7YOxSRRjZTE3CmZQ2+TYjXR7A6AzQKo0fv/x43bpSes8ttQ6
Qtt8nzIbGBkDAcI7wfXsUPF5o0NwLOxre+Z+JCPNH0eaOj2J7EKD2ERLCClmvohrYdlmu85iXfyi
nJo42eq9g08FtnxTXVQSIZCtiETiGtXA7+t2Aa8429XXunsijRznaYw2SwI/s4sVmvaK3XHaif0D
QaUYxQp4s2ctzgz3eU6hK68OnNzbhBtF/lx6PHbifqHDzrtUbzCCB+8wggbXoAMCAQICEy0ACwRu
JYOozH+yQuYAAQALBG4wDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMzEyMjAwOTIw
NDdaFw0yNTEyMTkwOTIwNDdaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAklOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
ODcxNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL2JT+kRihW1mBdeZFOoCLGIl4DZ
VL7FWt3V1iFFJJe/bZDw/SUf5z1HeA8xv9+S8rqMyybjlSRHFLgiMm7qrGpVEDniKe8eiqP8Un4Y
3fHgK5FKZIVVn0KlaMuD5G30AMk9HyUdc2MkVRL8YSQCewkQDEVjB8gnx/e6xfbWEVHf5+dOWJoR
aket5+0JKV0l/dPV7cT4hL3BFtiBhq8976Li6rn8gxIi63u0G3qvm9Scqk+EHzemDhw/W+eMmGR4
nwKVLKzumxko8l6EOnnvqqF4vj2hKTpB+2lsEXH1giireMEsvB2RY40lnRUXVQ0FDklOIQV4Qdgi
EJfUdq/ZhCUCAwEAAaOCBA4wggQKMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/gbeCPIPthzICAWQCAT4wEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwHQYDVR0OBBYEFMJ81PK4p3H8Q7gn7u/5OwWx
uAwGMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRwYW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFu
a2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAUWJVg7k5072Uiqr3tGakreo4XnQcwggFGBgNV
HR8EggE9MIIBOTCCATWgggExoIIBLYaByGxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENB
JTIwNSxDTj1ubGFtc3BraTAwMDUsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENO
PVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y2VydGlmaWNh
dGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hi9o
dHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybIYvaHR0cDovL3d3
dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmwwggEQBggrBgEFBQcBAQSCAQIw
gf8wgbsGCCsGAQUFBzAChoGubGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENO
PUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0
aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1j
ZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3LnBraS5ueHAuY29t
L2NlcnRzL05YUC1FbnRlcnByaXNlLUNBNS5jZXIwDQYJKoZIhvcNAQELBQADggEBALwIIuww1PaF
EbpQoy5vgJ/4N3xS+niIpFTKyYNAD0Ar38FcUlSnj0FIHKRj8rUmZP9WTky3U8m5B3LOyhJ14FPh
iy1EwkhZmds9fJiZyEEFiwQWYDG/uknu6zIKOTlLmtlYPfbzfi58keGcjD3T5H8D8DpCGWI1lAwe
clR9fJCbcYnQSQnuicSCfrHjjXiDZ2O8h7WbE1CC6Cj/qwo5nmS0lMv7yoG94rTNBvYe8iqOkcav
7KiZA6SdhXms3ppvFmBukI6pTheMvT39SM0S6E0dgeqZSGSxHrM7dcxUdAL4fnYMv3Sa+GAgyXB6
rihWC11+goz2eawt5TRU2w45TmcxggSzMIIErwIBATCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVy
cHJpc2UgQ0EgNDELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5k
aG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJ
kiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhM/AAV1goSs
wyqoLYNbAAUABXWCMAkGBSsOAwIaBQCgggK5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI0MDkxOTA2NDM0MVowIwYJKoZIhvcNAQkEMRYEFAJY07vtN/HKbTY9K+Tz
8T02OlvEMIGTBgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggq
hkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIaMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMIHfBgkrBgEEAYI3EAQx
gdEwgc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjCB4QYLKoZIhvcNAQkQAgsx
gdGggc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjANBgkqhkiG9w0BAQEFAASC
AQCnUktIb6lzoxTNdqesGI58BLPmzMFlsMAzQA2fG4q7BiwD+2ML/FzNH6w5qKpdPJ2QZLdVMFGc
7rUm89JnlaGo/8MhmhVETVYDARFZaioQ7tU3akqz2robN1I/5c/XZ+R1/BRgr02Fl7MjHLMjK+Ly
x9iX5N3+lESlWvOHtSLSpJr6CjwqieLWYFGmkiZv3hsLkJOMu7vJVA1kpRvG7dE40OYjHNafUazJ
U/ad3ORKQxN8D7Llt7cx6MsU4FvHH4lZbWRzgSP5/+xpOhxguymWBEIwescI6ha3reCjpQnb66z+
y79qHsnCADancdeJ41wEYaH99O1QWRk3FiSwU8PGAAAAAAAA

------=_NextPart_000_005D_01DB0A8D.5DE2C210--

