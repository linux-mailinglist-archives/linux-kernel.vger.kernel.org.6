Return-Path: <linux-kernel+bounces-177765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF28C4462
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69649281812
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7040415359D;
	Mon, 13 May 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lH8uLncF"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B55958210;
	Mon, 13 May 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614610; cv=fail; b=IGm5QJzp4n1aa0V4AqYeHFi42lShMtx5Pyigiabcu39La/F85saMuZYIK9/hp3MxHToIEAdO/Qe+g9erByKrnlKDl09GGhzUynO+065LdR0LsqWXasLM8vuSy4wk3aS9IbItRwUwvdlqJZs2LBErF4/ks+oUz4vtvBJ+yUIJOZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614610; c=relaxed/simple;
	bh=ndIFHRSFcu/r/uqDAMP1+G+lEH4+wGm6W5YNtYkY1u0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OiKnWp/SJs4Vi802xDwzjlta6bfxoLQgQh3bw7xHZRMhBvdlJdC74zF8gcRlJjI4guo1kiyCicbjKUHOysOn6q7yBwA7CzOmNY4G/rhvoQu+83EPCgqLw1/qRcFL8G3M74hSv99nIic5N7VO4OTZvEkGieciVUom3muF7DRhBhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lH8uLncF; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV0NuI0orVCKGvvEYqgtxbYgnnHWkiPDrBiPkQS6zZTNKzVU5lHkJxqv0oLlHARbI+d2tXbMASee/Ig1w3GJmLg/OY+iV4M3L4C346GsJvNRy9kj3NldfmPopT3fNNveKgmB9HmxOMhaqN49K3Mbx9roPM3JV8tRdW28Y1Sa+c/lxF7W9Y7FnGm8jgyT1R7hCFTV1LckKgqNrQzGtZvujPbw7mIdjHTEkgrtjNMVhARerNZGvpuj23ZU+osnXIC6yurlEz8c+R2JcSZrOAmb5wRcyzACc1fD0Me71R1tIQSurymHycg/qx1WWXTc8cj37GEqiSoGj7I99nGAJqRkyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcKNrw6k/axGcB0ocFKaEVBIGSlImXV9nqMzIqI/lL8=;
 b=nzzTFiwJZ0k36DAscHA34U+i3JB2ANDLdQxO3AP/NEYLpy0DH7QwZDtgGRM4OH1gdHU6Qpds0dWZ7aRPKp2JM0+t8lNA8qbBbyNCW8PhbbzW4uTcF/vrC+EdJBPdcR8YrUDSpNv3bljERmgZ/seovoPYbXE4PTs/sYXS29Xgntyl5cuwTuzQbzROrgVQ9g0HfzdbEBWhDI074eTxIXNCCCuU4jx0ATwrBYyuJK2tkZnjyrh7PwrQ7mX2wNj6LHqHDZONIfi77Dn3P6fsPtigRyXj8r5NGa+MZV9MkdpolF6Y57FKw26rv1lImOTlDFWGLHEQcXPQatP5R9OvFf/1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcKNrw6k/axGcB0ocFKaEVBIGSlImXV9nqMzIqI/lL8=;
 b=lH8uLncF+XZGUEzHzC7BkFCS7myp6Y5IeP/9hfswngNyqAJxHbotmTY32eMHG+/f2l62e+238t7YVesT78KO4TnQzDZleK9oZxLcn+DBNintNrj6UNtQyZo+cGjVqwO+3XYYtIVOxLQR8x3+cauHiZ+ny3WCQAmXNuCZcaCVpQQ=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM7PR04MB6854.eurprd04.prod.outlook.com (2603:10a6:20b:10c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 15:36:44 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 15:36:44 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 2/4] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH 2/4] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHaot4r694Tqoi2OkK/Xnn0LWMP+LGQ5hKAgAQVonA=
Date: Mon, 13 May 2024 15:36:44 +0000
Message-ID:
 <AM9PR04MB8604479439A3723792B865EE95E22@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
 <20240510-imx-se-if-v1-2-27c5a674916d@nxp.com>
 <20240510200903.GA628922-robh@kernel.org>
In-Reply-To: <20240510200903.GA628922-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AM7PR04MB6854:EE_
x-ms-office365-filtering-correlation-id: 0417b572-c2ad-44cb-7770-08dc73627eab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YB2L4CLaBw3dlM5pU2ccM8U5OYJBhd7x4JTtVxrkd3yek81xXk/MAN8rffdr?=
 =?us-ascii?Q?JOT6LLbINugN5zzJZXGTA/o9kwn9PnEzSG0cuEuFKbFl5o+dEDtgRGN/VO/h?=
 =?us-ascii?Q?ujUiups0Rqk2HT+HRETacedzvyqhqKMUhs1uDpdJGmCNBU/+llIDdcPFIfin?=
 =?us-ascii?Q?Bg1zrLHgBa0MQUEWChfcxLvlf2qvzLcWGPiWfItNcVule51Iadc/u1nRUeLV?=
 =?us-ascii?Q?IKX3OG52qcMvKciBBFVW3R49ODBq+NZh9miPzCxRDg2PkTcOjEk1cxIzwRJf?=
 =?us-ascii?Q?GvAC6MMjK9zpPB5JfQQlp0ugZeuTODZZqge/usT+7UBEHlDyKP8GRjYPXXTL?=
 =?us-ascii?Q?+WpTC/ReuNKGm8Wewo2IqiVbo8UZ7fdSPmK1IEGuyA1HrQZTsM43kEexmA9N?=
 =?us-ascii?Q?0HI8c4SHmXYM7POHRv9mbvQYOxh2nmxCO1CFcBBkUmnu30IBfxFYR0Ru8DIr?=
 =?us-ascii?Q?e/nV/wXjCLuidsAckm5uAs5k8w6Tpln2kNDH83ml8Oo4iEAOHDYwbPg6vRYt?=
 =?us-ascii?Q?NJ0U9VIkFU3QUuJeHYD0txqQ3XRvHwMs8nbbVJno6/o/Unafio1BF+3tzWQm?=
 =?us-ascii?Q?aXU+ZmzeUNAmtigmkcGbdm0qpk2Act0vvLTUeaqQG2AS4h1QwHkrpo1MR0Xg?=
 =?us-ascii?Q?ve+CW4ZN1OFhZIXdquuV/i6aL5SRHmSTOsL5GohSZOW1c7VVjxtV7tE/7RFm?=
 =?us-ascii?Q?ndrZRZP1nCmPlZwAuNbVFP2ppLz3HCOe7uuYXsR82RkK/pXGBqHKesNXFS1G?=
 =?us-ascii?Q?tv73LZOegTgRBDF8rWezme7EbY2h/t8dgRDdJslMJhY1+IsE7xBc9V+1g6dJ?=
 =?us-ascii?Q?wYrsF8F2Ckh6F3XtOZ0Rv5fvAnhY8qcX2SR3arTSULX3BrDnbBO5vcJkFVOy?=
 =?us-ascii?Q?O0N7/soWniuL+ejlDlEK/j+QwCksK9+BgYxCg6EYJ/fq1UkvpHY7l9VJRm4v?=
 =?us-ascii?Q?U6+YhUQdMhOdu+aUIJKdI1mjZ+hFA7I+7aW5brHx+Gjt6dfLif9VsdchKbiY?=
 =?us-ascii?Q?wVWF5sge71TYn5SYpx/Na7y+ciLNK1GqhSpjSDGvZIrnmEtNGZ0WzUKeWx7Y?=
 =?us-ascii?Q?UwufU7UHa3n8KbE6EOqOOjBeRLTDhfRAx05xdjrfYpTxTX6+DiJYEn9t2mCJ?=
 =?us-ascii?Q?BG6QnffpPnYKRm5cwS8d3G5SjY0sPn6SBgnKoM3NXAGQDR+an9VkK7ti/2ma?=
 =?us-ascii?Q?AqoKZdBGDUj7YCC/FwOOpVKV1UM6PvQvnpZponu4hvqyEioupGzd0rB3slE7?=
 =?us-ascii?Q?XZ8JcgjjpdjbyDUgt//IWbh6sCuSIJxvjDYOJiwmdsCUx5Zj0qZwoCP0BPHM?=
 =?us-ascii?Q?jQpYlIAXB9D8STYN5G8XI7v08c5rG8K3I1dpYgFPf0HL5g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QvvWtpsKJgVMlXxGVGnSKx2xqikXxOSx8mUEeCHFXOBono+dkp+j9B0Of86/?=
 =?us-ascii?Q?9U6D2PK9JLSDAzPgmK3GLahrBzSUdhSzaIDZnmhT9qeoaLZHtwqFGvPuqGa5?=
 =?us-ascii?Q?tEz8wpw8C+id49hA6o/fog9qK8tDe1HKGDz0+Ze5N6ztFs1AENEXtNV5phr/?=
 =?us-ascii?Q?IdSTuC+bFpTgBh6AHIBZE4vJ+V2j7eN49qc80Qx3b+cm9bg3VMSSOMCueJWp?=
 =?us-ascii?Q?0Yk3GhE23UnZBvJF+Tdo8KjzlNlI0XZhQjWeuH5L7bQM9wrQgQQ2OwY1nbdg?=
 =?us-ascii?Q?OBPRRBIyfZIKbdGwDzydQ+6CbqefJuqA0umSd4ZVaKRxSInf9V0dMvwoto6G?=
 =?us-ascii?Q?o0y29LbCwW7uC1STb9lbEPvR+OORUe2Tg3mTmsEq/dkDbAfxTZUTJ5Hg9ogb?=
 =?us-ascii?Q?3WEMjkgErLMQBpHxpJVhHjAdEYT1j3zmW/IWy7+FTOfgcrNuIHqdgnLDnqbq?=
 =?us-ascii?Q?V1UCQBS+b9oKiz2v074z4rnVihPAdF10IxVi0C1BW5o8uDrlNXJc2Llnfgt6?=
 =?us-ascii?Q?ja2pWbcZNNg4Uh8oDc5zQ1bbmn194Ra7MSdMYkut3G2qAu9tmYMs6vPze77n?=
 =?us-ascii?Q?uUSZ7m1msSKKlD9JQrl0LTJSVOj+hiNI223SxsNoIar4JlfR+Voyo/aFPncI?=
 =?us-ascii?Q?1+70vcOmqMfCipIKP3k6KLEbdsO7FDQXyZop8QBNTiptzTKwBgHCrGQsQ99+?=
 =?us-ascii?Q?VuiFpUInidlHaZWBb7xZmZXqTxC7lyUF825Kjo3GalxTwUzzfbP4so6nd6ak?=
 =?us-ascii?Q?tarx1lSYmto9P+n5FNZ9miqf5NaDITTJMeSGjPH41Ffl41AHg7t85js5xOe2?=
 =?us-ascii?Q?UjvrefFksTYC/kdpTUs2DHt8z+pkk5ohbnWECBD5OOWydmUdkQzPP/4A52fg?=
 =?us-ascii?Q?wD3Z0DwZ6BA3F7IntSd1T6WG/+8OcxrB7piT7h64evBJcnZ+lYxdgbox97Nt?=
 =?us-ascii?Q?Vl2gV4nsh6PT/mnijNALvNOFSbgO3I+BSy978C0pHwOP1/NcFbw2AnXBwIro?=
 =?us-ascii?Q?AFJAaw2YT7pspNrhvVdXuIST/No9Mzu2x/W0A0uxG0wqs8+YOpf7e8iPK1AI?=
 =?us-ascii?Q?T+bwBX5YXP6j57jpzdXeNYarbJbDoU6wmUtLwJssuu0iy1IGzvjEQnF2Nn9b?=
 =?us-ascii?Q?023XdsHfCyCOdGi/dyoiFxRYQuVCfi+/hvEaOzHnuMRDxFKwJanBCnKhPY0u?=
 =?us-ascii?Q?ReVMLwgVG5psdMCqfqFByguNK+S8H32z0fSv7fL/SRRcvFqRapRkaUvVboQ+?=
 =?us-ascii?Q?gdBS/ijQ16eCDEuUKamk7ORKaSmvhHepG8BhEKm8myDqjGO1nLzFnYN/ld8v?=
 =?us-ascii?Q?mLa37I0TsInqiGcGK5hMziEY/YQj265+1Miid/McrUD2z2jfmZwWo+UfLMDr?=
 =?us-ascii?Q?Fw6VOXq/Nd7vB/nfq3neaFeDrLkFUXzW+ogiAu9mKKwbf6P6HnlMSATX7oZv?=
 =?us-ascii?Q?TGwMNEDcEr/EIicT/oB07wEIf9XKeU3Tw6HG9017rwOCnpEbALxakVuhXzBG?=
 =?us-ascii?Q?z7w0QK/9BXhN0u28AlDQtE1zAgES5QP/2WkMBh7x8/pKz5iqU16/QOJVyxxE?=
 =?us-ascii?Q?L2KkLJ75rnPzjioqQhtuWAI6brW1TBSwYbycNg6or8br7Rr7nvUAb5UcBjE7?=
 =?us-ascii?Q?xRRhp8cjRMtD4tYDa5xPSbQOOjMwzoHgJQhiihO2YaaO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0417b572-c2ad-44cb-7770-08dc73627eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 15:36:44.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfXRpG0JczixuZpNCqTnCHbdv47TAUIFXPMPO5O45j3HH05D0VkB7gn2tSMMwCQKp8+j+Uo4hTPzPE3Bt8EQFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6854



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Saturday, May 11, 2024 1:39 AM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH 2/4] dt-bindings: arm: fsl: add imx-se-fw bindi=
ng
> doc
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Fri, May 10, 2024 at 06:57:28PM +0530, Pankaj Gupta wrote:
> > The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
> > creates an embedded secure enclave within the SoC boundary to enable
> > features like:
> > - HSM
> > - SHE
> > - V2X
> >
> > Secure-Enclave(s) communication interface are typically via message
> > unit, i.e., based on mailbox linux kernel driver. This driver enables
> > communication ensuring well defined message sequence protocol between
> > Application Core and enclave's firmware.
> >
> > Driver configures multiple misc-device on the MU, for multiple
> > user-space applications, to be able to communicate over single MU.
> >
> > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 186
> +++++++++++++++++++++
> >  1 file changed, 186 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > new file mode 100644
> > index 000000000000..a858ef6965cb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > @@ -0,0 +1,186 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fschemas%2Ffirmware%2Ffsl%2Cimx-
> se.yaml%23&data=3D05%7C02%7
> >
> +Cpankaj.gupta%40nxp.com%7C2c17789530e9431069b308dc712d0e47%7C
> 686ea1d3
> >
> +bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638509685520936926%7CUnkn
> own%7CTWF
> >
> +pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6
> >
> +Mn0%3D%7C0%7C%7C%7C&sdata=3DRwof3k3K1OWimcI5ApRMiyvD%2FPXgk
> b%2BRWrvx76J
> > +YBtw%3D&reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpankaj.gupta%
> >
> +40nxp.com%7C2c17789530e9431069b308dc712d0e47%7C686ea1d3bc2b4c
> 6fa92cd9
> >
> +9c5c301635%7C0%7C0%7C638509685520944809%7CUnknown%7CTWFpb
> GZsb3d8eyJWI
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C0%7C%
> >
> +7C%7C&sdata=3Daile3WnYE69fuJHvAOXQARlqLV9roZDuDK63fCj2ZTE%3D&res
> erved=3D0
> > +
> > +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> > +
> > +maintainers:
> > +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> > +
> > +description: |
> > +  NXP's SoC may contain one or multiple embedded secure-enclave HW
> > +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> > +  enables features like
> > +    - Hardware Security Module (HSM),
> > +    - Security Hardware Extension (SHE), and
> > +    - Vehicular to Anything (V2X)
> > +
> > +  Communication interface to the secure-enclaves is based on the
> > + messaging unit(s).
> > +
> > +properties:
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8ulp-ele
> > +      - fsl,imx93-ele
>=20
> You basically have 0 properties in the parent node. What's the point of i=
t?
> Either just get rid of it and define the child nodes independently or mak=
e the
> parent contain all the resources.
>=20
> > +
> > +patternProperties:
> > +  "^[0-9a-z]*-if@[0-9]+$":
>=20
> unit-addresses are hex.
Accepted.

>=20
> > +    type: object
> > +    description:
> > +      Communication interface to secure-enclave node, that defines
> hardware
> > +      properties to required to establish the communication. There can=
 be
> > +      multiple interfaces to the same secure-enclave. Each interface i=
s
> > +      enumerated with reg property. It optionally defines properties
> > +      depending on the compatible string and interface enum identifier=
.
> > +
> > +    properties:
> > +      reg:
> > +        maxItems: 1
> > +        description: Identifier of the communication interface to secu=
re-
> enclave.
>=20
> What are the identifiers based on?=20
Identifier is used to identify a particular secure enclave interface, withi=
n the multiple secure enclave interfaces under same compatible string.

Secure enclave interface is the combination of:
- messaging unit (hardware), and
- memory constraint applicable to a particular interface.

> Is the value significant to s/w? Kind of looks like you just made up indi=
ces.

For the below example:
    v2x {
      compatible =3D "fsl,imx95-v2x";
      #address-cells =3D <1>;
      #size-cells =3D <0>;

      v2x-if@0 { // if it is not @0, then what identifier to be used to ide=
ntify a particular node.
        reg =3D <0x0>;
        mboxes =3D <&v2x_mu 0 0>, <&v2x_mu 1 0>;
        mbox-names =3D "tx", "rx";
      };
      v2x-if@1 {
        reg =3D <0x1>;
        mboxes =3D <&v2x_mu6 0 0>, <&v2x_mu6 1 0>;
        mbox-names =3D "txdb", "rxdb";
      };
      v2x-if@2 {
        reg =3D <0x2>;
        mboxes =3D <&v2x_mu7 0 0>, <&v2x_mu7 1 0>;
        mbox-names =3D "tx", "rx";
      };
    };
s/w needs to differentiate one node from another node, for the same compati=
ble string for the SoC.=20

>=20
> How many child nodes do you have? Is it fixed per SoC?
It is fixed for a particular SoC.
While number of child nodes varies from one SoC to another SoC.

>=20
> > +
> > +      mboxes:
> > +        description: contain a list of phandles to mailboxes.
> > +        items:
> > +          - description: Specify the mailbox used to send message to s=
e
> firmware
> > +          - description: Specify the mailbox used to receive message
> > + from se firmware
> > +
> > +      mbox-names:
> > +        items:
> > +          - const: tx
> > +          - const: rx
> > +          - const: txdb
> > +          - const: rxdb
> > +        minItems: 2
> > +
> > +      memory-region:
> > +        description: contains a list of phandles to reserved external =
memory.
> > +        items:
> > +          - description: It is used by secure-enclave firmware. It is =
an optional
> > +              property based on compatible and identifier to communica=
tion
> interface.
> > +              (see bindings/reserved-memory/reserved-memory.txt)
> > +
> > +      sram:
> > +        description: contains a list of phandles to sram.
> > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> > +        items:
> > +          - description: Phandle to the device SRAM. It is an optional=
 property
> > +              based on compatible and identifier to communication inte=
rface.
> > +
> > +    required:
> > +      - reg
> > +      - mboxes
> > +      - mbox-names
> > +
> > +allOf:
> > +  # memory-region
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8ulp-ele
> > +              - fsl,imx93-ele
>=20
> What else would they contain? Those are the only compatibles defined here=
.

It will have multiple child nodes, but fixed number of child node for a par=
ticular SoC.

>=20
> > +    then:
> > +      patternProperties:
> > +        "^[0-9a-z]*-if@[0-9]+$":
> > +          allOf:
> > +            - if:
>=20
> These conditionals are hard to follow. Probably a sign some of this needs=
 to be
> separate or simplified.
I am ready to separate and simplify.=20
Please help by sharing an example on how to go about this change. =20
Probably an example that helps me understand your point and then will start=
 to work on this comment.
It is highly appreciated. Thanks.

>=20
> > +                properties:
> > +                  reg:
> > +                    items:
> > +                      - enum:
> > +                          - 0
> > +              then:
> > +                required:
> > +                  - memory-region
> > +              else:
> > +                not:
> > +                  required:
> > +                    - memory-region
> > +  # sram
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8ulp-ele
> > +    then:
> > +      patternProperties:
> > +        "^[0-9a-z]*-if@[0-9]+$":
> > +          allOf:
> > +            - if:
> > +                properties:
> > +                  reg:
> > +                    items:
> > +                      - enum:
> > +                          - 0
> > +              then:
> > +                required:
> > +                  - sram
> > +              else:
> > +                not:
> > +                  required:
> > +                    - sram
> > +
> > +additionalProperties: false

