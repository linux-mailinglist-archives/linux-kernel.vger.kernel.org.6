Return-Path: <linux-kernel+bounces-214587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E689086D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492611F25D41
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E261922C1;
	Fri, 14 Jun 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IARXllp5"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9501862AB;
	Fri, 14 Jun 2024 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355369; cv=fail; b=kcRyYUrL5rnBt4PfHMUaAl/5uBaHUbRpOuyf17L8kI7p7M/3uV5YTVRIqmhXUhqMSNcDpusppxs1QusnoCY1/LeSf/lweYhHpo6jy8s4Z55qdbWQjFlq5gIeCfCD6Y476DhThvT8XHV7T2psxh9eHbppbeAiHOkhuPmtDIRjtv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355369; c=relaxed/simple;
	bh=AdEZTfT+mgLepyahJuUpSHCpodSf6lYoOj9PkXvac+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YHsITzHOyhblKtIh8PznGHCMakgnT4VBjBhSlF51faxtoNmS04XkaYBG0fW2J2NbPSKX6oUCfAOLlTNfnVZmE6SIXbcie3RtR+z0uNc+eSF/bkfkth8p8awfoEP3dEx1hgtVDOafFHK/lW1ud9oblQNgIH9Bp0ynYC0OgwbA238=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IARXllp5; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi7i5ptq5/J05ElfSAxRXhHFXXHEkzd9MnxvUqYdf19HZdyevsVKiZVwvnMl7UXp1F31rB5NsQ+mnoeIXCVhRlXAQbKEdg8ZuHgzEXVhEs19s80DiJCd0n8Uuel5TbZYlsHWFdQy8lXboJ1NyXPsS1dl2LdAJ15ewwGoIJfQXZKwyL7tBYXBkzz01LYnPzbFwnlm7vqwYKHqW9+zF4v3wo657rzA6Xyz4j9DS7DWzTsG7R9NvPlvcRE80kkZgBEGfC3nJbw0sKrw3pF9q3oeNDde3daUK7sLC1I3jvHn+QBtxlQMqK1DXUolCYjNknXCdqksg/ktdob3Omym5Le1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hQnvntySvtUPloAz1hJDJyFJzsbzJI08ej1yN0skDA=;
 b=V9laB4cXuigSpNoByeK6QEBINYBhv7MjcrFwFQEc9XpdaQgoN83zlMz+HUkL6DbIiCw4rVEqwWfdbiNNsZJmbC8h8/Nnh6EUgKMaVfCXpq8/AgYbEYpktI2Y4hY9lAfSsRL/x99wxayTzT3lfgkmfnNII0smOnut1SUXwd9lJEQdvGeyOkNTZvO+3aQQhMaOnkCBrlZseBLxFuQt/9KD5i/JuDwwMLnFu4DjojC3upTV/TuOXhacdxaAtkQx7tIzzoyWwXECVjnXzyYohyPSCdUAiHjRP1PeZrQZaW56NRMqr/qihC/zwZl0KWKWXcAvWJyAfgL/sfVDL++6IFbpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hQnvntySvtUPloAz1hJDJyFJzsbzJI08ej1yN0skDA=;
 b=IARXllp56CIJ5dtTOH5Q+xUfjynBAtFiKLqi44+eApovScuPYOdgGh71GBi0P+Kk9xSDpW8mwOIaUqPm9QENYiKMCeM3frS4umuVuMP3sp+4j+QIf6KxDy8LK+qWu4bLWM7TTO319z51nNu/swTe7yrCgWg1KL3ZWgRc+eEw4Ic=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM9PR04MB8421.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 08:56:00 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 08:56:00 +0000
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
Thread-Index: AQHarP9ayLdOqCtfLEqTQR0Rf+AVuLGmGYSAgCC+kMA=
Date: Fri, 14 Jun 2024 08:56:00 +0000
Message-ID:
 <AM9PR04MB8604C70BF200C4A02E93971795C22@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-4-5a6fd189a539@nxp.com>
 <ZlBYvc0yZ7g4qnl0@pengutronix.de>
In-Reply-To: <ZlBYvc0yZ7g4qnl0@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AM9PR04MB8421:EE_
x-ms-office365-filtering-correlation-id: 22e84b85-2828-44b9-fbe0-08dc8c4fd017
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230035|1800799019|366011|7416009|376009|38070700013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ilQGE6sQuugxu4GPsfzHRAUPKTyfVhBJP4aXCq9NcwoSyD4M3WeqMTKLAtdP?=
 =?us-ascii?Q?CV+USjrFA5Eo+nRrOSqPQ8ERJ0wDk0gKJvLRUkpEWbwkGFZGh3q+D1D7lGD4?=
 =?us-ascii?Q?StxTKECXG1S4CyZs1KYwWQBAQ87L/watH+UeUX/2ZABEZ8hgkCnIan+OkiDC?=
 =?us-ascii?Q?Qt+0Gb67B4nBqh60rncokLR4kKCLOzvQpPGIL6jIWAruNQnxfEvsjqit+/Sz?=
 =?us-ascii?Q?H1lGmBZhFicN4W2im2S5nwpQyEjNj3/AjBhxd/Ll616f88DCEcBRd8b5eIx7?=
 =?us-ascii?Q?8K3OFIjtNsusx0Q8WiPlg06Sr1JAmTxaNCGQ+So8ipdyAByBH63IW65A6PSd?=
 =?us-ascii?Q?/WcJnO63OFw2NXpKULX/F8YZ2OXom9gwKBERkLIX8GsNLPCLwOUoCJ0tgWIL?=
 =?us-ascii?Q?WextNImzgtnqsSoGrPeeo3PRHt+ZENY33+Vi5dgSU5OPpgTq2XciEqKIBD4P?=
 =?us-ascii?Q?PWYiU1hNktKr0bpY9JIr24qx8dJlbzq5naQPmJWwIwySGnDthhf0JrQrhNxM?=
 =?us-ascii?Q?OnML9Y4O9w5bxtK2TU+nWtyUk6El5jqrJADqgExFrulFfXqFo00rVi/Bjfsy?=
 =?us-ascii?Q?22+3MpXeFcr4nCXout5xiljmSnRUVOl3U6sf/2PWLofQjcN+mRZVu3OTECqj?=
 =?us-ascii?Q?24qS0NY7GgTiQVqCbiMEiAH5JM4Fa70XMnHP0hYKHrcsj/Z9m9gh8DedrwCg?=
 =?us-ascii?Q?B9giLvneas0YDE+z0y/hB0eYYQVbkBfjiQz5fjuhKjxaXXwYVUXTzO1wu9IS?=
 =?us-ascii?Q?Rx7YbKfpELQLaosHfxJtnMiCkBhSYBiHymVeLg5BsYO5hReW9hQJCZLACoba?=
 =?us-ascii?Q?9uGAUS8AUaJWOJ+7LYvg7o1Rrsq+Y2s2+5zzm+1M+42LjGFi5XzmdJ/bqbgR?=
 =?us-ascii?Q?DXVZgJ271tTfW8ok0dATxezmzg/wm4dGLHNZKrdZiX97e0hWEPvBMhjlnl3A?=
 =?us-ascii?Q?+kcxvtoZx+2PkvtTGPJ0JZILnlVCi4liajThHkuC2ZEdspd3lu7IBpcst1Xe?=
 =?us-ascii?Q?U9ZHMt+os9iXvUscouEwC0ofePMN8sNrqmQI2s67N0WeUB5XCxJmVGcq1k+1?=
 =?us-ascii?Q?LTv7ulOrqhuV9LyXiibo/YSHUpbxD5t++HkwjLFzpB8lw4hX0EB3iaT6qddA?=
 =?us-ascii?Q?7PIh4HwaxThfBXhcD+2oxoefKD3xLnqU6OyGWpgxe3kERbvnDFS6Koa+jiES?=
 =?us-ascii?Q?Bjv3RFTL2jalL13W5o+dsViVxx4tb8sS2qA8uW8RRE8cqlsIuhyMqqNF0eL/?=
 =?us-ascii?Q?y4UsAprYM8ioI2Y891WCZxZmQ6mQbeiLPp404dtWcv6CoivNblnuQ05a5H9I?=
 =?us-ascii?Q?9ISZVixOQvqzWFwMSbdHLxNn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZVmDCMI3Hr12Xh3WaXr1VpFsAwrnN/q9TCWr5HqqS2slWtUYR89TCej5Hxrm?=
 =?us-ascii?Q?CVJAZocyQ59rTjf3q6YbgVaURrOTMypFPq958VlEgfEEtbnG2/Mm+r7yOmNb?=
 =?us-ascii?Q?jhTXuIfWnFSnE0zLhL8/jkfs7/1T+9eaPAdOeH20xlt1fEaex20o7uijxGb+?=
 =?us-ascii?Q?o+b3VvWAFdhpRAJKPh6aKdYxtxLdY66S23+4mfj5v8zj4cSKB5RIQ1O75vzT?=
 =?us-ascii?Q?np/ncB7Tl2iqqsSGMit1klcOUkmgcDgEX+uNW6AYGSIqE+S8voM3Llyue0NU?=
 =?us-ascii?Q?+jkltpByzMNx6l/gCcQW8I3zxlkBTWnSBgjI/kk5X+n6eOaVjeZK6X6rug+m?=
 =?us-ascii?Q?o/UnkEP4nFsi/nllqjfI0f3Dp6UG+2esQnK4SdNOw/28hi5otAHP8IQS5dQT?=
 =?us-ascii?Q?vW6EmnQ8PwkxiLicIKHHDOQ5h8G0tB0uvVhDcAyyB74rZbgHZMOfvxFVH5xt?=
 =?us-ascii?Q?nmbCU/8u/QGH1kH/KablqLwfKpwDZ9g4gJVShcdV7PP2lKYcqNi44gOhILS1?=
 =?us-ascii?Q?tYfQ0TDiLp9eZx2wqV3VtvD+i1+c07SzjNllXMGj16WZnjkvBs7rpgEQ7qzi?=
 =?us-ascii?Q?XoaVJYokZ3jyrdatlyQC7Rli1tNXSrEdbwMxIJVr093RI+QHWHuCZpaaG4kd?=
 =?us-ascii?Q?z62UKcwsE+WyIup1W7NwDdEO8KTkFEPOwOWT3JQiXkRMJNNLsuuGjI5OP1pi?=
 =?us-ascii?Q?FzPvwq0I0YO/24mylgDAqiHITzZMqvUURKAPSa478s0wNjl9jRAKSDpfYGsg?=
 =?us-ascii?Q?/Rs43JIJpyNdOICaYeB3GJT0id/YbPvHnBEUwab9R9VBgsgWKPMJEmR/OUL+?=
 =?us-ascii?Q?YJABDFikfvdw0dcZZmKSMnfP5U3hPWkMXPRn2BL7bBoYuOq+8DKk9YkyJY4j?=
 =?us-ascii?Q?PLWe2XF62MpPAhiIrsnbAyCAqpV6qkZPy4pk0FDmKudFe+Lv09tLMLmN9fNT?=
 =?us-ascii?Q?H3g4HIip/Op6+nvFBSnVOiE09LY61S6UTSokV49Wl0N+7Km/5uekMSrPcH6q?=
 =?us-ascii?Q?V+0Meyq+2P30W/KoXbdQlerQU93N/jAhfFiXLsaAb3Hh00zh0PYC6OCt/UZm?=
 =?us-ascii?Q?gbzPn/Prc1ehIccx8xmVFZwHFPhnoOZ2vxLQTLvMZUSra6GEn7woe5NeEBlM?=
 =?us-ascii?Q?sfdDrQgFiGvp7785AK3bkfYtXAduJRpZUDE5wiVXultWqhjLZzSB+TxT6fb9?=
 =?us-ascii?Q?trZgcpbmrFuSIDZm/C2hnUTMuM7rnjM8TOupEln6f4V2OeJDMPjFJ54Gz73a?=
 =?us-ascii?Q?8Xzb8xhuJfEUCKc4Z1II4+/EcQQAjpa2mT6U6BuZSZcG8Xb7/wOGAjg5lr0v?=
 =?us-ascii?Q?Tm6fIAczej28QNKfScV8c+zGPt4rh00hOVjDnloZkf3EPtixBPEKeoQMiRtg?=
 =?us-ascii?Q?FaNCN+UdbEiR2OIMJDJKvbnTUUv5VjslqVRgFz0kc4R/9zJLEoNK0ki1ny03?=
 =?us-ascii?Q?By5QG1v14XGj1r4/boEGi12nQ8YAwz+LP0lkpObsp1SOzYFZUgH3NthVAdQK?=
 =?us-ascii?Q?2P/LgDShJEtNl2NYqhAZcRaTexgyHA+dFef9+7r3RM6clKBPVUYkRzPB6GqL?=
 =?us-ascii?Q?9iFvY+A7XDg7aKsyF+/99Yu+2W8F1G3EKdoZFxbP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e84b85-2828-44b9-fbe0-08dc8c4fd017
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 08:56:00.0825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Bx4ZG1no8UlXLaaPrzu4aRt+Z++Lpv9CP4G85ZTCDi+y8jwRyJHIATioPhrrCk4LdBuKDGH7zew9cYGGEv89g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8421



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Friday, May 24, 2024 2:37 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
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
> > diff --git a/drivers/firmware/imx/Kconfig
> > b/drivers/firmware/imx/Kconfig index 183613f82a11..56bdca9bd917
> 100644
> > --- a/drivers/firmware/imx/Kconfig
> > +++ b/drivers/firmware/imx/Kconfig
> > @@ -22,3 +22,15 @@ config IMX_SCU
> >
> >         This driver manages the IPC interface between host CPU and the
> >         SCU firmware running on M4.
> > +
> > +config IMX_SEC_ENCLAVE
> > +     tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmwar=
e
> driver."
> > +     depends on IMX_MBOX && ARCH_MXC && ARM64
> > +     default m if ARCH_MXC
> > +
> > +     help
> > +       It is possible to use APIs exposed by the iMX Secure Enclave HW=
 IP
> called:
> > +          - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> > +          like base, HSM, V2X & SHE using the SAB protocol via the sha=
red
> Messaging
> > +          Unit. This driver exposes these interfaces via a set of file
> descriptors
> > +          allowing to configure shared memory, send and receive messag=
es.
> > diff --git a/drivers/firmware/imx/Makefile
> > b/drivers/firmware/imx/Makefile index 8f9f04a513a8..aa9033e0e9e3
> > 100644
> > --- a/drivers/firmware/imx/Makefile
> > +++ b/drivers/firmware/imx/Makefile
> > @@ -1,3 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_IMX_DSP)                +=3D imx-dsp.o
> >  obj-$(CONFIG_IMX_SCU)                +=3D imx-scu.o misc.o imx-scu-irq=
.o rm.o
> imx-scu-soc.o
> > +sec_enclave-objs             =3D se_ctrl.o ele_common.o ele_base_msg.o
> > +obj-${CONFIG_IMX_SEC_ENCLAVE}        +=3D sec_enclave.o
> > diff --git a/drivers/firmware/imx/ele_base_msg.c
> > b/drivers/firmware/imx/ele_base_msg.c
> > new file mode 100644
> > index 000000000000..f072c613dba1
> > --- /dev/null
> > +++ b/drivers/firmware/imx/ele_base_msg.c
> > @@ -0,0 +1,286 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/completion.h>
> > +#include <linux/dma-mapping.h>
> > +
> > +#include "ele_base_msg.h"
> > +#include "ele_common.h"
> > +
> > +int ele_get_info(struct device *dev, struct ele_dev_info *s_info) {
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +     struct se_api_msg *tx_msg __free(kfree) =3D NULL;
> > +     struct se_api_msg *rx_msg __free(kfree) =3D NULL;
> > +     phys_addr_t get_info_addr =3D 0;
> > +     u32 *get_info_data =3D NULL;
> > +     u32 status;
> > +     int ret =3D 0;
> > +
> > +     memset(s_info, 0x0, sizeof(*s_info));
> > +
> > +     if (priv->mem_pool_name)
> > +             get_info_data =3D get_phy_buf_mem_pool(dev,
> > +                                                  priv->mem_pool_name,
> > +                                                  &get_info_addr,
> > +                                                  ELE_GET_INFO_BUFF_SZ=
);
> > +     else
> > +             get_info_data =3D dma_alloc_coherent(dev,
> > +                                                ELE_GET_INFO_BUFF_SZ,
> > +                                                &get_info_addr,
> > +                                                GFP_KERNEL);
> > +     if (!get_info_data) {
> > +             ret =3D -ENOMEM;
> > +             dev_dbg(dev,
> > +                     "%s: Failed to allocate get_info_addr.\n",
> > +                     __func__);
> > +             goto exit;
> > +     }
> > +
> > +     tx_msg =3D kzalloc(ELE_GET_INFO_REQ_MSG_SZ, GFP_KERNEL);
> > +     if (!tx_msg) {
> > +             ret =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     rx_msg =3D kzalloc(ELE_GET_INFO_RSP_MSG_SZ, GFP_KERNEL);
> > +     if (!rx_msg) {
> > +             ret =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     ret =3D plat_fill_cmd_msg_hdr(priv,
> > +                                 (struct se_msg_hdr *)&tx_msg->header,
> > +                                 ELE_GET_INFO_REQ,
> > +                                 ELE_GET_INFO_REQ_MSG_SZ,
> > +                                 true);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     tx_msg->data[0] =3D upper_32_bits(get_info_addr);
> > +     tx_msg->data[1] =3D lower_32_bits(get_info_addr);
> > +     tx_msg->data[2] =3D sizeof(struct ele_dev_info);
> > +     ret =3D imx_ele_msg_send_rcv(priv, tx_msg, rx_msg);
> > +     if (ret < 0)
> > +             goto exit;
> > +
> > +     ret =3D validate_rsp_hdr(priv,
> > +                            &priv->rx_msg->header,
> > +                            ELE_GET_INFO_REQ,
> > +                            ELE_GET_INFO_RSP_MSG_SZ,
> > +                            true);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     status =3D RES_STATUS(priv->rx_msg->data[0]);
> > +     if (status !=3D priv->success_tag) {
> > +             dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> > +                     ELE_GET_INFO_REQ, status);
> > +             ret =3D -EPERM;
> > +     }
> > +
> > +     memcpy(s_info, get_info_data, sizeof(struct ele_dev_info));
> > +
> > +exit:
> > +     if (get_info_addr) {
> > +             if (priv->mem_pool_name)
> > +                     free_phybuf_mem_pool(dev, priv->mem_pool_name,
> > +                                          get_info_data, ELE_GET_INFO_=
BUFF_SZ);
> > +             else
> > +                     dma_free_coherent(dev,
> > +                                       ELE_GET_INFO_BUFF_SZ,
> > +                                       get_info_data,
> > +                                       get_info_addr);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +int ele_fetch_soc_info(struct device *dev, u16 *soc_rev, u64
> > +*serial_num) {
> > +     struct ele_dev_info s_info =3D {0};
> > +     int err =3D 0;
> > +
> > +     err =3D ele_get_info(dev, &s_info);
> > +     if (err < 0) {
> > +             dev_err(dev, "Error");
> > +             return err;
> > +     }
> > +
> > +     *soc_rev =3D s_info.d_info.soc_rev;
> > +     *serial_num =3D GET_SERIAL_NUM_FROM_UID(s_info.d_info.uid,
> > + MAX_UID_SIZE >> 2);
> > +
> > +     return err;
> > +}
> > +
> > +int ele_ping(struct device *dev)
> > +{
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +     struct se_api_msg *tx_msg __free(kfree) =3D NULL;
> > +     struct se_api_msg *rx_msg __free(kfree) =3D NULL;
> > +     u32 status;
> > +     int ret =3D 0;
> > +
> > +     tx_msg =3D kzalloc(ELE_PING_REQ_SZ, GFP_KERNEL);
> > +     if (!tx_msg) {
> > +             ret =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     rx_msg =3D kzalloc(ELE_PING_RSP_SZ, GFP_KERNEL);
> > +     if (!rx_msg) {
> > +             ret =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     ret =3D plat_fill_cmd_msg_hdr(priv,
> > +                                 (struct se_msg_hdr *)&tx_msg->header,
> > +                                 ELE_PING_REQ, ELE_PING_REQ_SZ,
> > +                                 true);
> > +     if (ret) {
> > +             dev_err(dev, "Error: plat_fill_cmd_msg_hdr failed.\n");
> > +             goto exit;
> > +     }
> > +
> > +     ret =3D imx_ele_msg_send_rcv(priv, tx_msg, rx_msg);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     ret =3D validate_rsp_hdr(priv,
> > +                            &priv->rx_msg->header,
> > +                            ELE_PING_REQ,
> > +                            ELE_PING_RSP_SZ,
> > +                            true);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     status =3D RES_STATUS(priv->rx_msg->data[0]);
> > +     if (status !=3D priv->success_tag) {
> > +             dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> > +                     ELE_PING_REQ, status);
> > +             ret =3D -EPERM;
> > +     }
> > +exit:
> > +     return ret;
> > +}
> > +
> > +int ele_service_swap(struct device *dev,
> > +                  phys_addr_t addr,
> > +                  u32 addr_size, u16 flag) {
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +     struct se_api_msg *tx_msg __free(kfree) =3D NULL;
> > +     struct se_api_msg *rx_msg __free(kfree) =3D NULL;
> > +     u32 status;
> > +     int ret =3D 0;
> > +
> > +     tx_msg =3D kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ, GFP_KERNEL);
> > +     if (!tx_msg) {
> > +             ret =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     rx_msg =3D kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ, GFP_KERNEL);
> > +     if (!rx_msg) {
> > +             ret =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     ret =3D plat_fill_cmd_msg_hdr(priv,
> > +                                 (struct se_msg_hdr *)&tx_msg->header,
> > +                                 ELE_SERVICE_SWAP_REQ,
> > +                                 ELE_SERVICE_SWAP_REQ_MSG_SZ,
> > +                                 true);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     tx_msg->data[0] =3D flag;
> > +     tx_msg->data[1] =3D addr_size;
> > +     tx_msg->data[2] =3D ELE_NONE_VAL;
> > +     tx_msg->data[3] =3D lower_32_bits(addr);
> > +     tx_msg->data[4] =3D plat_add_msg_crc((uint32_t *)&tx_msg[0],
> > +                                              ELE_SERVICE_SWAP_REQ_MSG=
_SZ);
> > +     ret =3D imx_ele_msg_send_rcv(priv, tx_msg, rx_msg);
> > +     if (ret < 0)
> > +             goto exit;
> > +
> > +     ret =3D validate_rsp_hdr(priv,
> > +                            &priv->rx_msg->header,
> > +                            ELE_SERVICE_SWAP_REQ,
> > +                            ELE_SERVICE_SWAP_RSP_MSG_SZ,
> > +                            true);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     status =3D RES_STATUS(priv->rx_msg->data[0]);
> > +     if (status !=3D priv->success_tag) {
> > +             dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> > +                     ELE_SERVICE_SWAP_REQ, status);
> > +             ret =3D -EPERM;
> > +     } else {
> > +             if (flag =3D=3D ELE_IMEM_EXPORT)
> > +                     ret =3D priv->rx_msg->data[1];
> > +             else
> > +                     ret =3D 0;
> > +     }
> > +exit:
> > +
> > +     return ret;
> > +}
> > +
> > +int ele_fw_authenticate(struct device *dev, phys_addr_t addr) {
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +     struct se_api_msg *tx_msg __free(kfree) =3D NULL;
> > +     struct se_api_msg *rx_msg __free(kfree) =3D NULL;
> > +     u32 status;
> > +     int ret =3D 0;
> > +
> > +     tx_msg =3D kzalloc(ELE_FW_AUTH_REQ_SZ, GFP_KERNEL);
> > +     if (!tx_msg) {
> > +             ret =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     rx_msg =3D kzalloc(ELE_FW_AUTH_RSP_MSG_SZ, GFP_KERNEL);
> > +     if (!rx_msg) {
> > +             ret =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +     ret =3D plat_fill_cmd_msg_hdr(priv,
> > +                                 (struct se_msg_hdr *)&tx_msg->header,
> > +                                 ELE_FW_AUTH_REQ,
> > +                                 ELE_FW_AUTH_REQ_SZ,
> > +                                 true);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     tx_msg->data[0] =3D addr;
> > +     tx_msg->data[1] =3D addr >> 32;
> > +     tx_msg->data[2] =3D addr;
> > +
> > +     ret =3D imx_ele_msg_send_rcv(priv, tx_msg, rx_msg);
> > +     if (ret < 0)
> > +             goto exit;
> > +
> > +     ret =3D validate_rsp_hdr(priv,
> > +                            &priv->rx_msg->header,
> > +                            ELE_FW_AUTH_REQ,
> > +                            ELE_FW_AUTH_RSP_MSG_SZ,
> > +                            true);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     status =3D RES_STATUS(priv->rx_msg->data[0]);
> > +     if (status !=3D priv->success_tag) {
> > +             dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> > +                     ELE_FW_AUTH_REQ, status);
> > +             ret =3D -EPERM;
> > +     }
> > +exit:
> > +
> > +     return ret;
> > +}
> > diff --git a/drivers/firmware/imx/ele_base_msg.h
> > b/drivers/firmware/imx/ele_base_msg.h
> > new file mode 100644
> > index 000000000000..f00414f9d86d
> > --- /dev/null
> > +++ b/drivers/firmware/imx/ele_base_msg.h
> > @@ -0,0 +1,92 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2024 NXP
> > + *
> > + * Header file for the EdgeLock Enclave Base API(s).
> > + */
> > +
> > +#ifndef ELE_BASE_MSG_H
> > +#define ELE_BASE_MSG_H
> > +
> > +#include <linux/device.h>
> > +#include <linux/types.h>
> > +
> > +#define WORD_SZ                              4

Will remove this in v3.

>
> This define is unused
>
> > +#define ELE_NONE_VAL                 0x0
> > +
> > +#define ELE_SUCCESS_IND                      0xD6
>
> This define is unused, instead you have hardcoded 0xd6 constants in your
> code. Either use this define or drop it.

Will Replace 0xd6 with the above macro in v3.
>
> > +
> > +#define ELE_GET_INFO_REQ             0xDA
> > +#define ELE_GET_INFO_REQ_MSG_SZ              0x10
> > +#define ELE_GET_INFO_RSP_MSG_SZ              0x08
> > +
> > +#define ELE_GET_INFO_BUFF_SZ         0x100
> > +
> > +#define DEFAULT_IMX_SOC_VER          0xA000
> > +#define SOC_VER_MASK                 0xFFFF0000
> > +#define SOC_ID_MASK                  0x0000FFFF
> > +
> > +#define MAX_UID_SIZE                     (16)
> > +#define DEV_GETINFO_ROM_PATCH_SHA_SZ     (32)
> > +#define DEV_GETINFO_FW_SHA_SZ            (32)
> > +#define DEV_GETINFO_OEM_SRKH_SZ          (64)
> > +#define DEV_GETINFO_MIN_VER_MASK     0xFF
> > +#define DEV_GETINFO_MAJ_VER_MASK     0xFF00
> > +
> > +struct dev_info {
> > +     uint8_t  cmd;
> > +     uint8_t  ver;
> > +     uint16_t length;
> > +     uint16_t soc_id;
> > +     uint16_t soc_rev;
> > +     uint16_t lmda_val;
> > +     uint8_t  ssm_state;
> > +     uint8_t  dev_atts_api_ver;
> > +     uint8_t  uid[MAX_UID_SIZE];
> > +     uint8_t  sha_rom_patch[DEV_GETINFO_ROM_PATCH_SHA_SZ];
> > +     uint8_t  sha_fw[DEV_GETINFO_FW_SHA_SZ]; };
> > +
> > +struct dev_addn_info {
> > +     uint8_t  oem_srkh[DEV_GETINFO_OEM_SRKH_SZ];
> > +     uint8_t  trng_state;
> > +     uint8_t  csal_state;
> > +     uint8_t  imem_state;
> > +     uint8_t  reserved2;
> > +};
> > +
> > +struct ele_dev_info {
> > +     struct dev_info d_info;
> > +     struct dev_addn_info d_addn_info; };
> > +
> > +#define GET_SERIAL_NUM_FROM_UID(x, uid_word_sz) \
> > +     (((u64)(((u32 *)(x))[(uid_word_sz) - 1]) << 32) | ((u32
> > +*)(x))[0])
> > +
> > +#define ELE_PING_REQ                 0x01
> > +#define ELE_PING_REQ_SZ                      0x04
> > +#define ELE_PING_RSP_SZ                      0x08
> > +
> > +#define ELE_SERVICE_SWAP_REQ         0xDF
> > +#define ELE_SERVICE_SWAP_REQ_MSG_SZ  0x18 #define
> > +ELE_SERVICE_SWAP_RSP_MSG_SZ  0x0C
> > +#define ELE_IMEM_SIZE                        0x10000
> > +#define ELE_IMEM_STATE_OK            0xCA
> > +#define ELE_IMEM_STATE_BAD           0xFE
> > +#define ELE_IMEM_STATE_WORD          0x27
> > +#define ELE_IMEM_STATE_MASK          0x00ff0000
> > +#define ELE_IMEM_EXPORT                      0x1
> > +#define ELE_IMEM_IMPORT                      0x2
> > +
> > +#define ELE_FW_AUTH_REQ                      0x02
> > +#define ELE_FW_AUTH_REQ_SZ           0x10
> > +#define ELE_FW_AUTH_RSP_MSG_SZ               0x08
> > +
> > +int ele_get_info(struct device *dev, struct ele_dev_info *s_info);
> > +int ele_fetch_soc_info(struct device *dev, u16 *soc_rev, u64
> > +*serial_num); int ele_ping(struct device *dev); int
> > +ele_service_swap(struct device *dev,
> > +                  phys_addr_t addr,
> > +                  u32 addr_size, u16 flag); int
> > +ele_fw_authenticate(struct device *dev, phys_addr_t addr); #endif
> > diff --git a/drivers/firmware/imx/ele_common.c
> > b/drivers/firmware/imx/ele_common.c
> > new file mode 100644
> > index 000000000000..c286c3d84d82
> > --- /dev/null
> > +++ b/drivers/firmware/imx/ele_common.c
> > @@ -0,0 +1,239 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#include "ele_base_msg.h"
> > +#include "ele_common.h"
> > +
> > +u32 plat_add_msg_crc(u32 *msg, u32 msg_len)
>
> Please use a proper function name prefix.
>

Renamed to imx_se_add_msg_crc().

> > +{
> > +     u32 nb_words =3D msg_len / (u32)sizeof(u32);
> > +     u32 crc =3D 0;
> > +     u32 i;
> > +
> > +     for (i =3D 0; i < nb_words - 1; i++)
> > +             crc ^=3D *(msg + i);
> > +
> > +     return crc;
> > +}
> > +
> > +int imx_ele_msg_rcv(struct se_if_priv *priv) {
> > +     u32 wait;
> > +     int err =3D 0;
> > +
> > +     lockdep_assert_held(&priv->se_if_cmd_lock);
> > +
> > +     wait =3D msecs_to_jiffies(1000);
> > +     if (!wait_for_completion_timeout(&priv->done, wait)) {
> > +             dev_err(priv->dev,
> > +                             "Error: wait_for_completion timed out.\n"=
);
> > +             err =3D -ETIMEDOUT;
> > +     }
> > +
> > +     return err;
> > +}
> > +
> > +int imx_ele_msg_send(struct se_if_priv *priv, void *tx_msg) {
> > +     struct se_msg_hdr *header;
> > +     int err;
> > +
> > +     header =3D (struct se_msg_hdr *) tx_msg;
> > +
> > +     if (header->tag =3D=3D priv->cmd_tag)
> > +             lockdep_assert_held(&priv->se_if_cmd_lock);
> > +
> > +     scoped_guard(mutex, &priv->se_if_lock);
> > +
> > +     err =3D mbox_send_message(priv->tx_chan, tx_msg);
> > +     if (err < 0) {
> > +             dev_err(priv->dev, "Error: mbox_send_message failure.\n")=
;
> > +             return err;
> > +     }
> > +
> > +     return err;
> > +}
> > +
> > +/* API used for send/receive blocking call. */ int
> > +imx_ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void
> > +*rx_msg) {
> > +     int err;
> > +
> > +     scoped_guard(mutex, &priv->se_if_cmd_lock);
> > +     if (priv->waiting_rsp_dev) {
> > +             dev_warn(priv->dev,
> > +                     "There should be no misc dev-ctx, waiting for res=
p.\n");
> > +             priv->waiting_rsp_dev =3D NULL;
> > +     }
> > +     priv->rx_msg =3D rx_msg;
> > +     err =3D imx_ele_msg_send(priv, tx_msg);
> > +     if (err < 0)
> > +             goto exit;
> > +
> > +     err =3D imx_ele_msg_rcv(priv);
> > +
> > +exit:
> > +     return err;
> > +}
> > +
> > +/*
> > + * Callback called by mailbox FW, when data is received.
> > + */
> > +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg) {
> > +     struct device *dev =3D mbox_cl->dev;
> > +     struct se_if_priv *priv;
> > +     struct se_msg_hdr *header;
> > +
> > +     priv =3D dev_get_drvdata(dev);
> > +
> > +     /* The function can be called with NULL msg */
> > +     if (!msg) {
> > +             dev_err(dev, "Message is invalid\n");
> > +             return;
> > +     }
> > +
> > +     header =3D (struct se_msg_hdr *) msg;
> > +
> > +     if (header->tag =3D=3D priv->rsp_tag) {
> > +             if (!priv->waiting_rsp_dev) {
> > +                     /*
> > +                      * Reading the EdgeLock Enclave response
> > +                      * to the command, sent by other
> > +                      * linux kernel services.
> > +                      */
> > +                     spin_lock(&priv->lock);
> > +                     memcpy(priv->rx_msg, msg, header->size << 2);
> > +
> > +                     complete(&priv->done);
> > +                     spin_unlock(&priv->lock);
> > +                     return;
> > +             }
> > +     } else {
> > +             dev_err(dev, "Failed to select a device for message: %.8x=
\n",
> > +                             *((u32 *) header));
> > +             return;
> > +     }
> > +}
> > +
> > +int validate_rsp_hdr(struct se_if_priv *priv,
> > +                  struct se_msg_hdr *header,
> > +                  uint8_t msg_id,
> > +                  uint8_t sz,
> > +                  bool is_base_api)
> > +{
> > +     int ret =3D -EINVAL;
> > +
> > +     if (header->tag !=3D priv->rsp_tag) {
> > +             dev_err(priv->dev,
> > +                     "MSG[0x%x] Hdr: Resp tag mismatch. (0x%x !=3D 0x%=
x)",
> > +                     msg_id, header->tag, priv->rsp_tag);
> > +             return ret;
>
> Just return -EINVAL. Drop the variable 'ret' entirely from this function.

Accepted. Will correct in V3.
>
> > +     }
> > +
> > +     if (header->command !=3D msg_id) {
> > +             dev_err(priv->dev,
> > +                     "MSG Header: Cmd id mismatch. (0x%x !=3D 0x%x)",
> > +                     header->command, msg_id);
> > +             return ret;
> > +     }
> > +
> > +     if (header->size !=3D (sz >> 2)) {
> > +             dev_err(priv->dev,
> > +                     "MSG[0x%x] Hdr: Cmd size mismatch. (0x%x !=3D 0x%=
x)",
> > +                     msg_id, header->size, (sz >> 2));
> > +             return ret;
> > +     }
> > +
> > +     if (is_base_api && (header->ver !=3D priv->base_api_ver)) {
> > +             dev_err(priv->dev,
> > +                     "MSG[0x%x] Hdr: Base API Vers mismatch. (0x%x !=
=3D 0x%x)",
> > +                     msg_id, header->ver, priv->base_api_ver);
> > +             return ret;
> > +     } else if (!is_base_api && header->ver !=3D priv->fw_api_ver) {
> > +             dev_err(priv->dev,
> > +                     "MSG[0x%x] Hdr: FW API Vers mismatch. (0x%x !=3D =
0x%x)",
> > +                     msg_id, header->ver, priv->fw_api_ver);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D 0;
> > +
> > +     return ret;
> > +}
> > +
> > +int se_save_imem_state(struct device *dev)
>
> This function is used internally by the driver code. It should take a str=
uct
> struct se_if_priv * directly here. Same applies for several other functio=
ns in
> this patch.
>
Will correct it for:
- se_save_imem_state
- se_restore_imem_state
- imx_fetch_se_soc_info

> > +{
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     /* EXPORT command will save encrypted IMEM to given address,
> > +      * so later in resume, IMEM can be restored from the given
> > +      * address.
> > +      *
> > +      * Size must be at least 64 kB.
> > +      */
> > +     ret =3D ele_service_swap(dev,
> > +                            priv->imem.phyaddr,
> > +                            ELE_IMEM_SIZE,
> > +                            ELE_IMEM_EXPORT);
> > +     if (ret < 0)
> > +             dev_err(dev, "Failed to export IMEM\n");
> > +     else
> > +             dev_info(dev,
> > +                     "Exported %d bytes of encrypted IMEM\n",
> > +                     ret);
> > +
> > +     return ret;
> > +}
> > +
> > +int se_restore_imem_state(struct device *dev) {
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +     struct ele_dev_info s_info;
> > +     int ret;
> > +
> > +     /* get info from ELE */
> > +     ret =3D ele_get_info(dev, &s_info);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to get info from ELE.\n");
> > +             return ret;
> > +     }
> > +
> > +     /* Get IMEM state, if 0xFE then import IMEM */
> > +     if (s_info.d_addn_info.imem_state =3D=3D ELE_IMEM_STATE_BAD) {
> > +             /* IMPORT command will restore IMEM from the given
> > +              * address, here size is the actual size returned by ELE
> > +              * during the export operation
> > +              */
> > +             ret =3D ele_service_swap(dev,
> > +                                    priv->imem.phyaddr,
> > +                                    priv->imem.size,
> > +                                    ELE_IMEM_IMPORT);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to import IMEM\n");
> > +                     goto exit;
> > +             }
> > +     } else
> > +             goto exit;
> > +
> > +     /* After importing IMEM, check if IMEM state is equal to 0xCA
> > +      * to ensure IMEM is fully loaded and
> > +      * ELE functionality can be used.
> > +      */
> > +     ret =3D ele_get_info(dev, &s_info);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to get info from ELE.\n");
> > +             goto exit;
> > +     }
> > +
> > +     if (s_info.d_addn_info.imem_state =3D=3D ELE_IMEM_STATE_OK)
> > +             dev_info(dev, "Successfully restored IMEM\n");
> > +     else
> > +             dev_err(dev, "Failed to restore IMEM\n");
> > +
> > +exit:
> > +     return ret;
> > +}
> > diff --git a/drivers/firmware/imx/ele_common.h
> > b/drivers/firmware/imx/ele_common.h
> > new file mode 100644
> > index 000000000000..76777ac629d6
> > --- /dev/null
> > +++ b/drivers/firmware/imx/ele_common.h
> > @@ -0,0 +1,43 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +
> > +#ifndef __ELE_COMMON_H__
> > +#define __ELE_COMMON_H__
> > +
> > +#include "se_ctrl.h"
> > +
> > +#define IMX_ELE_FW_DIR                 "imx/ele/"
> > +
> > +uint32_t plat_add_msg_crc(uint32_t *msg, uint32_t msg_len); int
> > +imx_ele_msg_rcv(struct se_if_priv *priv); int imx_ele_msg_send(struct
> > +se_if_priv *priv, void *tx_msg); int imx_ele_msg_send_rcv(struct
> > +se_if_priv *priv, void *tx_msg, void *rx_msg); void
> > +se_if_rx_callback(struct mbox_client *mbox_cl, void *msg); int
> > +validate_rsp_hdr(struct se_if_priv *priv,
> > +                  struct se_msg_hdr *header,
> > +                  uint8_t msg_id,
> > +                  uint8_t sz,
> > +                  bool is_base_api);
> > +
> > +/* Fill a command message header with a given command ID and length
> > +in bytes. */ static inline int plat_fill_cmd_msg_hdr(struct se_if_priv=
 *priv,
> > +                                     struct se_msg_hdr *hdr,
> > +                                     u8 cmd,
> > +                                     u32 len,
> > +                                     bool is_base_api) {
> > +     hdr->tag =3D priv->cmd_tag;
> > +     hdr->ver =3D (is_base_api) ? priv->base_api_ver : priv->fw_api_ve=
r;
> > +     hdr->command =3D cmd;
> > +     hdr->size =3D len >> 2;
> > +
> > +     return 0;
> > +}
> > +
> > +int se_save_imem_state(struct device *dev); int
> > +se_restore_imem_state(struct device *dev);
> > +
> > +#endif /*__ELE_COMMON_H__ */
> > diff --git a/drivers/firmware/imx/se_ctrl.c
> > b/drivers/firmware/imx/se_ctrl.c new file mode 100644 index
> > 000000000000..0642d349b3d3
> > --- /dev/null
> > +++ b/drivers/firmware/imx/se_ctrl.c
> > @@ -0,0 +1,531 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/dev_printk.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/errno.h>
> > +#include <linux/export.h>
> > +#include <linux/firmware.h>
> > +#include <linux/firmware/imx/se_api.h> #include <linux/genalloc.h>
> > +#include <linux/init.h> #include <linux/io.h> #include
> > +<linux/miscdevice.h> #include <linux/mod_devicetable.h> #include
> > +<linux/module.h> #include <linux/of_platform.h> #include
> > +<linux/of_reserved_mem.h> #include <linux/platform_device.h> #include
> > +<linux/slab.h> #include <linux/string.h> #include <linux/sys_soc.h>
> > +
> > +#include "ele_base_msg.h"
> > +#include "ele_common.h"
> > +#include "se_ctrl.h"
> > +
> > +#define RESERVED_DMA_POOL            BIT(0)
> > +
> > +struct imx_se_node_info {
> > +     u8 se_if_id;
> > +     u8 se_if_did;
> > +     u8 max_dev_ctx;
> > +     u8 cmd_tag;
> > +     u8 rsp_tag;
> > +     u8 success_tag;
> > +     u8 base_api_ver;
> > +     u8 fw_api_ver;
> > +     u8 *se_name;
> > +     u8 *mbox_tx_name;
> > +     u8 *mbox_rx_name;
> > +     u8 *pool_name;
> > +     u8 *fw_name_in_rfs;
> > +     bool soc_register;
> > +     bool reserved_dma_ranges;
> > +     bool imem_mgmt;
> > +     int (*se_fetch_soc_info)(struct device *dev, u16 *soc_rev, u64
> > +*serial_num); };
> > +
> > +struct imx_se_node_info_list {
> > +     u8 num_mu;
> > +     u16 soc_id;
> > +     struct imx_se_node_info info[];
> > +};
> > +
> > +static const struct imx_se_node_info_list imx8ulp_info =3D {
> > +     .num_mu =3D 1,
> > +     .soc_id =3D SOC_ID_OF_IMX8ULP,
> > +     .info =3D {
> > +                     {
> > +                             .se_if_id =3D 2,
> > +                             .se_if_did =3D 7,
> > +                             .max_dev_ctx =3D 4,
> > +                             .cmd_tag =3D 0x17,
> > +                             .rsp_tag =3D 0xe1,
> > +                             .success_tag =3D 0xd6,
> > +                             .base_api_ver =3D MESSAGING_VERSION_6,
> > +                             .fw_api_ver =3D MESSAGING_VERSION_7,
> > +                             .se_name =3D "hsm1",
> > +                             .mbox_tx_name =3D "tx",
> > +                             .mbox_rx_name =3D "rx",
> > +                             .pool_name =3D "sram",
> > +                             .fw_name_in_rfs =3D IMX_ELE_FW_DIR
> > +                                               "mx8ulpa2ext-ahab-conta=
iner.img",
> > +                             .soc_register =3D true,
> > +                             .reserved_dma_ranges =3D true,
> > +                             .imem_mgmt =3D true,
> > +                             .se_fetch_soc_info =3D ele_fetch_soc_info=
,
> > +                     },
>
> Indentation level is one too deep here.

Accepted and will correct in v3.
>
> > +     },
> > +};
> > +
> > +static const struct imx_se_node_info_list imx93_info =3D {
> > +     .num_mu =3D 1,
> > +     .soc_id =3D SOC_ID_OF_IMX93,
> > +     .info =3D {
> > +                     {
> > +                             .se_if_id =3D 2,
> > +                             .se_if_did =3D 3,
> > +                             .max_dev_ctx =3D 4,
> > +                             .cmd_tag =3D 0x17,
> > +                             .rsp_tag =3D 0xe1,
> > +                             .success_tag =3D 0xd6,
> > +                             .base_api_ver =3D MESSAGING_VERSION_6,
> > +                             .fw_api_ver =3D MESSAGING_VERSION_7,
> > +                             .se_name =3D "hsm1",
> > +                             .mbox_tx_name =3D "tx",
> > +                             .mbox_rx_name =3D "rx",
> > +                             .reserved_dma_ranges =3D true,
> > +                             .imem_mgmt =3D true,
> > +                             .soc_register =3D true,
> > +                     },
>
> Drop all fields from this struct that are common to all currently support=
ed
> SoCs. You can always re-add them later when actually needed.
> This will make your code easier to review.

This will be double effort of first removing and then adding them latter wh=
en the patches for SoC i.MX93, i.MX95, will come.
Patches for I.MX93, 95 are ready with me. Once, these patches get accepted.=
 I will be posting those patches.
Request you to accept this as is, till then.

Thanks.

>
> > +     },
> > +};
> > +
> > +static const struct of_device_id se_match[] =3D {
> > +     { .compatible =3D "fsl,imx8ulp-ele", .data =3D (void *)&imx8ulp_i=
nfo},
> > +     { .compatible =3D "fsl,imx93-ele", .data =3D (void *)&imx93_info}=
,
> > +     {},
> > +};
> > +
> > +static struct imx_se_node_info
> > +             *get_imx_se_node_info(struct imx_se_node_info_list *info_=
list,
> > +                                   const u32 idx) {
> > +     if (idx > info_list->num_mu)
> > +             return NULL;
> > +
> > +     return &info_list->info[idx];
> > +}
> > +
> > +void *get_phy_buf_mem_pool(struct device *dev,
> > +                        u8 *mem_pool_name,
> > +                        dma_addr_t *buf,
> > +                        u32 size)
> > +{
> > +     struct device_node *of_node =3D dev->of_node;
> > +     struct gen_pool *mem_pool;
> > +
> > +     mem_pool =3D of_gen_pool_get(of_node, mem_pool_name, 0);
> > +     if (!mem_pool) {
> > +             dev_err(dev,
> > +                     "Unable to get sram pool =3D %s\n",
> > +                     mem_pool_name);
> > +             return 0;
> > +     }
> > +
> > +     return gen_pool_dma_alloc(mem_pool, size, buf); }
> > +
> > +void free_phybuf_mem_pool(struct device *dev,
> > +                       u8 *mem_pool_name,
> > +                       u32 *buf,
> > +                       u32 size)
> > +{
> > +     struct device_node *of_node =3D dev->of_node;
> > +     struct gen_pool *mem_pool;
> > +
> > +     mem_pool =3D of_gen_pool_get(of_node, mem_pool_name, 0);
> > +     if (!mem_pool)
> > +             dev_err(dev,
> > +                     "%s: Failed: Unable to get sram pool.\n",
> > +                     __func__);
> > +
> > +     gen_pool_free(mem_pool, (u64)buf, size); }
> > +
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
> > +
> > +     priv->soc_rev =3D soc_rev;
> > +     if (!info->soc_register)
> > +             return 0;
> > +
> > +     attr =3D devm_kzalloc(dev, sizeof(*attr), GFP_KERNEL);
> > +     if (!attr)
> > +             return -ENOMEM;
> > +
> > +     if (FIELD_GET(DEV_GETINFO_MIN_VER_MASK, soc_rev))
> > +             attr->revision =3D devm_kasprintf(dev, GFP_KERNEL, "%x.%x=
",
> > +                                             FIELD_GET(DEV_GETINFO_MIN=
_VER_MASK,
> > +                                                       soc_rev),
> > +                                             FIELD_GET(DEV_GETINFO_MAJ=
_VER_MASK,
> > +                                                       soc_rev));
> > +     else
> > +             attr->revision =3D devm_kasprintf(dev, GFP_KERNEL, "%x",
> > +                                             FIELD_GET(DEV_GETINFO_MAJ=
_VER_MASK,
> > +                                                       soc_rev));
> > +
> > +     switch (info_list->soc_id) {
> > +     case SOC_ID_OF_IMX8ULP:
> > +             attr->soc_id =3D devm_kasprintf(dev, GFP_KERNEL,
> > +                                           "i.MX8ULP");
> > +             break;
> > +     case SOC_ID_OF_IMX93:
> > +             attr->soc_id =3D devm_kasprintf(dev, GFP_KERNEL,
> > +                                           "i.MX93");
> > +             break;
> > +     }
> > +
> > +     err =3D of_property_read_string(of_root, "model",
> > +                                   &attr->machine);
> > +     if (err)
> > +             return -EINVAL;
> > +
> > +     attr->family =3D devm_kasprintf(dev, GFP_KERNEL, "Freescale
> > + i.MX");
> > +
> > +     attr->serial_number
> > +             =3D devm_kasprintf(dev, GFP_KERNEL, "%016llX",
> > + serial_num);
> > +
> > +     sdev =3D soc_device_register(attr);
> > +     if (IS_ERR(sdev))
> > +             return PTR_ERR(sdev);
> > +
> > +     return 0;
> > +}
> > +
> > +/* interface for managed res to free a mailbox channel */ static void
> > +if_mbox_free_channel(void *mbox_chan) {
> > +     mbox_free_channel(mbox_chan);
> > +}
> > +
> > +static int se_if_request_channel(struct device *dev,
> > +                              struct mbox_chan **chan,
> > +                              struct mbox_client *cl,
> > +                              const char *name) {
> > +     struct mbox_chan *t_chan;
> > +     int ret =3D 0;
> > +
> > +     t_chan =3D mbox_request_channel_byname(cl, name);
> > +     if (IS_ERR(t_chan)) {
> > +             ret =3D PTR_ERR(t_chan);
> > +             return dev_err_probe(dev, ret,
> > +                                  "Failed to request %s channel.", nam=
e);
> > +     }
> > +
> > +     ret =3D devm_add_action(dev, if_mbox_free_channel, t_chan);
> > +     if (ret) {
> > +             dev_err(dev, "failed to add devm removal of mbox %s\n", n=
ame);
> > +             goto exit;
> > +     }
> > +
> > +     *chan =3D t_chan;
> > +
> > +exit:
> > +     return ret;
> > +}
> > +
> > +static int se_probe_if_cleanup(struct platform_device *pdev) {
> > +     struct device *dev =3D &pdev->dev;
> > +     struct se_if_priv *priv;
> > +     int ret =3D 0;
> > +
> > +     priv =3D dev_get_drvdata(dev);
> > +     if (!priv) {
> > +             ret =3D 0;
> > +             dev_dbg(dev, "SE-MU Priv data is NULL;");
> > +             return ret;
> > +     }
>
> This can't happen. Drop the check and let this function return void.
Accepted and will correct in v3.
>
> > +
> > +     if (priv->tx_chan)
> > +             mbox_free_channel(priv->tx_chan);
> > +     if (priv->rx_chan)
> > +             mbox_free_channel(priv->rx_chan);
> > +
> > +     /* free the buffer in se remove, previously allocated
> > +      * in se probe to store encrypted IMEM
> > +      */
> > +     if (priv->imem.buf) {
> > +             dmam_free_coherent(dev,
> > +                                ELE_IMEM_SIZE,
> > +                                priv->imem.buf,
> > +                                priv->imem.phyaddr);
> > +             priv->imem.buf =3D NULL;
> > +     }
> > +
> > +     if (priv->flags & RESERVED_DMA_POOL) {
> > +             of_reserved_mem_device_release(dev);
> > +             priv->flags &=3D (~RESERVED_DMA_POOL);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static void se_load_firmware(const struct firmware *fw, void
> > +*context) {
> > +     struct se_if_priv *priv =3D (struct se_if_priv *) context;
> > +     const struct imx_se_node_info *info =3D priv->info;
> > +     const u8 *se_fw_name =3D info->fw_name_in_rfs;
> > +     phys_addr_t se_fw_phyaddr;
> > +     u8 *se_fw_buf;
> > +
> > +     if (!fw) {
> > +             if (priv->fw_fail > MAX_FW_LOAD_RETRIES)
> > +                     dev_dbg(priv->dev,
> > +                              "External FW not found, using ROM FW.\n"=
);
> > +             else {
> > +                     /*add a bit delay to wait for firmware priv relea=
sed */
> > +                     msleep(20);
> > +
> > +                     /* Load firmware one more time if timeout */
> > +                     request_firmware_nowait(THIS_MODULE,
> > +                                     FW_ACTION_UEVENT, info->fw_name_i=
n_rfs,
> > +                                     priv->dev, GFP_KERNEL, priv,
> > +                                     se_load_firmware);
> > +                     priv->fw_fail++;
> > +                     dev_dbg(priv->dev, "Value of retries =3D 0x%x.\n"=
,
> > +                             priv->fw_fail);
> > +             }
>
> What's the point of retrying this? It won't succeed when it failed once, =
no?
> Besides, calling request_firmware_nowait() in the completion callback of
> that very same function looks strange.
There is a secondary firmware image part of rootfs. It will fail till the r=
ootfs is not mounted.
Hence again calling the request_firmware_nowait, in the call back.

It will pass, once rootfs is mounted.

>
> > +
> > +             return;
> > +     }
> > +
> > +     /* allocate buffer to store the SE FW */
> > +     se_fw_buf =3D dmam_alloc_coherent(priv->dev, fw->size,
> > +                                      &se_fw_phyaddr,
> > +                                      GFP_KERNEL);
>
> Use unmanaged dma_alloc_coherent().
Accepted and will correct in v3.
>
>
> > +     if (!se_fw_buf) {
> > +             dev_err(priv->dev, "Failed to alloc SE fw buffer memory\n=
");
> > +             goto exit;
>
> No need to free it when you weren't able to allocate it.
Accepted. Will correct it in v3,.

>
> > +     }
> > +
> > +     memcpy(se_fw_buf, fw->data, fw->size);
> > +
> > +     if (ele_fw_authenticate(priv->dev, se_fw_phyaddr))
> > +             dev_err(priv->dev,
> > +                     "Failed to authenticate & load SE firmware %s.\n"=
,
> > +                     se_fw_name);
> > +
> > +exit:
> > +     dmam_free_coherent(priv->dev,
> > +                        fw->size,
> > +                        se_fw_buf,
> > +                        se_fw_phyaddr);
> > +
> > +     release_firmware(fw);
> > +}
> > +
> > +static int se_if_probe(struct platform_device *pdev) {
> > +     struct imx_se_node_info_list *info_list;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct imx_se_node_info *info;
> > +     struct se_if_priv *priv;
> > +     u32 idx;
> > +     int ret;
> > +
> > +     if (of_property_read_u32(dev->of_node, "reg", &idx)) {
> > +             ret =3D -EINVAL;
> > +             goto exit;
> > +     }
> > +
> > +     info_list =3D (struct imx_se_node_info_list *)
> > +                     device_get_match_data(dev);
> > +     info =3D get_imx_se_node_info(info_list, idx);
>
> get_imx_se_node_info() can return NULL. You should catch this here.
Accepted and will correct it in v3.
>
> > +
> > +     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv) {
> > +             ret =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     dev_set_drvdata(dev, priv);
> > +
> > +     /* Mailbox client configuration */
> > +     priv->se_mb_cl.dev              =3D dev;
> > +     priv->se_mb_cl.tx_block         =3D false;
> > +     priv->se_mb_cl.knows_txdone     =3D true;
> > +     priv->se_mb_cl.rx_callback      =3D se_if_rx_callback;
> > +
> > +     ret =3D se_if_request_channel(dev, &priv->tx_chan,
> > +                     &priv->se_mb_cl, info->mbox_tx_name);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     ret =3D se_if_request_channel(dev, &priv->rx_chan,
> > +                     &priv->se_mb_cl, info->mbox_rx_name);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     priv->dev =3D dev;
> > +     priv->info =3D info;
> > +
> > +     /* Initialize the mutex. */
>
> This comment doesn't provide any useful information.

Removed.
>
> > +     mutex_init(&priv->se_if_lock);
> > +     mutex_init(&priv->se_if_cmd_lock);
> > +
> > +     priv->cmd_receiver_dev =3D NULL;
> > +     priv->waiting_rsp_dev =3D NULL;
> > +     priv->max_dev_ctx =3D info->max_dev_ctx;
> > +     priv->cmd_tag =3D info->cmd_tag;
> > +     priv->rsp_tag =3D info->rsp_tag;
> > +     priv->mem_pool_name =3D info->pool_name;
> > +     priv->success_tag =3D info->success_tag;
> > +     priv->base_api_ver =3D info->base_api_ver;
> > +     priv->fw_api_ver =3D info->fw_api_ver;
> > +
> > +     init_completion(&priv->done);
> > +     spin_lock_init(&priv->lock);
> > +
> > +     if (info->reserved_dma_ranges) {
> > +             ret =3D of_reserved_mem_device_init(dev);
> > +             if (ret) {
> > +                     dev_err(dev,
> > +                             "failed to init reserved memory region %d=
\n",
> > +                             ret);
> > +                     priv->flags &=3D (~RESERVED_DMA_POOL);
>
> priv->flags is still 0. You just allocated it.

Accepted. Will correct in V3.
>
> > +                     goto exit;
> > +             }
> > +             priv->flags |=3D RESERVED_DMA_POOL;
> > +     }
> > +
> > +     if (info->fw_name_in_rfs) {
> > +             ret =3D request_firmware_nowait(THIS_MODULE,
> > +                                           FW_ACTION_UEVENT,
> > +                                           info->fw_name_in_rfs,
> > +                                           dev, GFP_KERNEL, priv,
> > +                                           se_load_firmware);
> > +             if (ret)
> > +                     dev_warn(dev, "Failed to get firmware [%s].\n",
> > +                              info->fw_name_in_rfs);
> > +     }
> > +
> > +     ret =3D imx_fetch_se_soc_info(dev);
> > +     if (ret) {
> > +             dev_err(dev,
> > +                     "failed[%pe] to fetch SoC Info\n", ERR_PTR(ret));
> > +             goto exit;
> > +     }
> > +
> > +     if (info->imem_mgmt) {
> > +             /* allocate buffer where SE store encrypted IMEM */
> > +             priv->imem.buf =3D dmam_alloc_coherent(dev, ELE_IMEM_SIZE=
,
> > +                                                  &priv->imem.phyaddr,
> > +                                                  GFP_KERNEL);
> > +             if (!priv->imem.buf) {
> > +                     dev_err(dev,
> > +                             "dmam-alloc-failed: To store encr-IMEM.\n=
");
> > +                     ret =3D -ENOMEM;
> > +                     goto exit;
> > +             }
> > +     }
> > +
> > +     dev_info(dev, "i.MX secure-enclave: %s interface to firmware,
> configured.\n",
> > +              info->se_name);
> > +     return devm_of_platform_populate(dev);
>
> What is this good for?
Accepted. Will remove it in v3.

>
> > +
> > +exit:
> > +     /* if execution control reaches here, if probe fails.
> > +      * hence doing the cleanup
> > +      */
> > +     if (se_probe_if_cleanup(pdev))
> > +             dev_err(dev,
> > +                     "Failed to clean-up the child node probe.\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static int se_remove(struct platform_device *pdev) {
> > +     if (se_probe_if_cleanup(pdev))
> > +             dev_err(&pdev->dev,
> > +                     "i.MX Secure Enclave is not cleanly
> > +un-probed.");
> > +
> > +     return 0;
> > +}
> > +
> > +static int se_suspend(struct device *dev) {
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +     const struct imx_se_node_info *info
> > +                                     =3D priv->info;
> > +
> > +     if (info && info->imem_mgmt)
> > +             priv->imem.size =3D se_save_imem_state(dev);
>
> imem.size has type u32. se_save_imem_state() might return an error code.

Accepted. Will fix this in V3.

> You use imem.size as third argument to ele_service_swap(). This looks fis=
hy.
There a flag associated with the ele_service_swap(), which suggests the kin=
d of operation: EXPORT or IMPORT.
imem.size is used in case of IMPORT only.
This is correctly implemented.

>
> > +
> > +     return 0;
> > +}
> > +
> > +static int se_resume(struct device *dev) {
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > +     const struct imx_se_node_info *info
> > +                                     =3D priv->info;
> > +
> > +     if (info && info->imem_mgmt)
> > +             se_restore_imem_state(dev);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dev_pm_ops se_pm =3D {
> > +     RUNTIME_PM_OPS(se_suspend, se_resume, NULL) };
> > +
> > +static struct platform_driver se_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "fsl-se-fw",
> > +             .of_match_table =3D se_match,
> > +             .pm =3D &se_pm,
> > +     },
> > +     .probe =3D se_if_probe,
> > +     .remove =3D se_remove,
> > +};
> > +MODULE_DEVICE_TABLE(of, se_match);
> > +
> > +module_platform_driver(se_driver);
> > +
> > +MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
> > +MODULE_DESCRIPTION("iMX Secure Enclave Driver.");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/firmware/imx/se_ctrl.h
> > b/drivers/firmware/imx/se_ctrl.h new file mode 100644 index
> > 000000000000..7d4f439a6158
> > --- /dev/null
> > +++ b/drivers/firmware/imx/se_ctrl.h
> > @@ -0,0 +1,99 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#ifndef SE_MU_H
> > +#define SE_MU_H
> > +
> > +#include <linux/miscdevice.h>
> > +#include <linux/semaphore.h>
> > +#include <linux/mailbox_client.h>
> > +
> > +#define MAX_FW_LOAD_RETRIES          50
> > +
> > +#define RES_STATUS(x)                        FIELD_GET(0x000000ff, x)
> > +#define MESSAGING_VERSION_6          0x6
> > +#define MESSAGING_VERSION_7          0x7
> > +
> > +struct se_imem_buf {
> > +     u8 *buf;
> > +     phys_addr_t phyaddr;
> > +     u32 size;
> > +};
> > +
> > +/* Header of the messages exchange with the EdgeLock Enclave */
> > +struct se_msg_hdr {
> > +     u8 ver;
> > +     u8 size;
> > +     u8 command;
> > +     u8 tag;
> > +}  __packed;
> > +
> > +#define SE_MU_HDR_SZ 4
> > +
> > +struct se_api_msg {
> > +     struct se_msg_hdr header;
> > +     u32 data[];
> > +};
> > +
> > +struct se_if_priv {
> > +     struct se_if_device_ctx *cmd_receiver_dev;
> > +     /* Update to the waiting_rsp_dev, to be protected
> > +      * under se_if_lock.
> > +      */
> > +     struct se_if_device_ctx *waiting_rsp_dev;
> > +     /*
> > +      * prevent parallel access to the se interface registers
> > +      * e.g. a user trying to send a command while the other one is
> > +      * sending a response.
> > +      */
> > +     struct mutex se_if_lock;
> > +     /*
> > +      * prevent a command to be sent on the se interface while another
> one is
> > +      * still processing. (response to a command is allowed)
> > +      */
> > +     struct mutex se_if_cmd_lock;
> > +     struct device *dev;
> > +     u8 *mem_pool_name;
> > +     u8 cmd_tag;
> > +     u8 rsp_tag;
> > +     u8 success_tag;
> > +     u8 base_api_ver;
> > +     u8 fw_api_ver;
> > +     u32 fw_fail;
> > +     u16 soc_rev;
> > +     const void *info;
> > +
> > +     struct mbox_client se_mb_cl;
> > +     struct mbox_chan *tx_chan, *rx_chan;
> > +
> > +     /* Assignment of the rx_msg buffer to held till the
> > +      * received content as part callback function, is copied.
> > +      */
> > +     struct se_api_msg *rx_msg;
> > +     struct completion done;
> > +     spinlock_t lock;
> > +     /*
> > +      * Flag to retain the state of initialization done at
> > +      * the time of se-if probe.
> > +      */
> > +     uint32_t flags;
> > +     u8 max_dev_ctx;
> > +     struct se_if_device_ctx **ctxs;
> > +     struct se_imem_buf imem;
> > +};
> > +
> > +void *get_phy_buf_mem_pool(struct device *dev,
> > +                        u8 *mem_pool_name,
> > +                        dma_addr_t *buf,
> > +                        u32 size);
> > +phys_addr_t get_phy_buf_mem_pool1(struct device *dev,
> > +                              u8 *mem_pool_name,
> > +                              u32 **buf,
> > +                              u32 size);
>
> This function is never defined.

Accepted and will be removed in v3.
>
> > +void free_phybuf_mem_pool(struct device *dev,
> > +                       u8 *mem_pool_name,
> > +                       u32 *buf,
> > +                       u32 size);
> > +#endif
> > diff --git a/include/linux/firmware/imx/se_api.h
> > b/include/linux/firmware/imx/se_api.h
> > new file mode 100644
> > index 000000000000..c47f84906837
> > --- /dev/null
> > +++ b/include/linux/firmware/imx/se_api.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#ifndef __SE_API_H__
> > +#define __SE_API_H__
> > +
> > +#include <linux/types.h>
> > +
> > +#define SOC_ID_OF_IMX8ULP            0x084D
> > +#define SOC_ID_OF_IMX93                      0x9300
> > +
> > +#endif /* __SE_API_H__ */
> >
> > --
> > 2.34.1
> >
> >
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.p/
> engutronix.de%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C5e4780
> ad2664458113a208dc7bd0e533%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C638521384332012351%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%
> 7C%7C%7C&sdata=3DtlQs2x2iDEeXKgyuB%2Bk5vI0rWh%2BbZQENACup6IhmhH
> I%3D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

