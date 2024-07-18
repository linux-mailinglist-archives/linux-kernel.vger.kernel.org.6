Return-Path: <linux-kernel+bounces-256365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533F0934D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D401F236FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A3913AD2F;
	Thu, 18 Jul 2024 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QMlqCoGZ"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE8E27448;
	Thu, 18 Jul 2024 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721304927; cv=fail; b=XFpjK09oE3xmqDcIZB6XfjPUFfEFeqU1GJUfsn6fxFz4A9G9juZZO6cMkgGbtg1QgI562CqN7pDELSgl1Z8SrtpxZZa5rsH18p4laYX1cyhueqJlj2ZT2CxyJDA7XStwK1eweyEDYq3Mtrl8YIJMoc4ZWOtiSFxv0KABKbKAwbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721304927; c=relaxed/simple;
	bh=frLy7iXN0Kr7rZiuiPyJhN9A8v2gAMZK7K0GQc1ylOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cA5uOvidHqTtEB7ArnS0LZkGtbc0NwxhK7daeVqvm954KGq+nZ5A03x1xCTxnSVPLNZ4ufF1XiJr4ZRPqkUloZ/TbYrtkCsPvriolRyjpa0l34Sgf/fouzsPk1DtdBXeh49nNCEpBtDKeKxSC8OdxbKRcF6AtgPffWp4efQThFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QMlqCoGZ; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp1yHhO87leMskKU4oRO4lp4atDG0wYkkCPmmRLkLNLM/687oOAqbK4J3yvLDzqCqW832YY+AnaIjgpkwgwvcgTPW0rZbMirw8H8BmVxFLLE4jCePRlbadgj1+ZLYe5/luV+RoVw6PGNK4k2BoLYF4nwvEdGVzMnJ4nfm9OcX1Eo565QsyI3/v2aJpRoEbaW1FQTKywI4j4Dz4bnjXGOCrmXOPObAwONDdU+r5hmzAZh36JLyU5bS3kteQ5jrqcKuLUqIMIXfiA65hcenTaBxGuT+cBG39KOF3zj5HiGU/Jm3UROQJj/S0viZlH+49k/QmLkANxHzHHWKPKe/d6zJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frLy7iXN0Kr7rZiuiPyJhN9A8v2gAMZK7K0GQc1ylOg=;
 b=j5S1aMKqhZCBPnqBkt+IDQxiE/zEhnwZKvE5/Pn7OOSinlvNcAUBDVIX6QajUM4RcQwVOaxPG0vzoFSi6hFTdg3TOALtFhOcIYCtOf9Za2TzkHNP7H4EJacwsekb27oJSKrE5MuiQKcg1/czp6Yr3WSrllY9/y/+p8xgphzXWsLI+VVTAIx3sAC72gW45jjslsoE44aJzoAA4gAowraCAXPV0P5oVqYY4ZHKd2PeWD2ZSDEceTQZjQ/z2Ta46uKxs9HBMFLecwE1rXB1/Lb/BjDOPrL+xHcP2HgvIldGuQZLeS1uROWRU3WPhjIkVmmK0yWBB9oS7g4RMiSqrbde0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frLy7iXN0Kr7rZiuiPyJhN9A8v2gAMZK7K0GQc1ylOg=;
 b=QMlqCoGZuZj9enZAYITZHqm8hd0u1ptCAaxdy3LPj2dX7G35XMYxeZhnv9NQIatnAbXWT7LSW/ojqc0Yh3onmH+EBKpLtggO9hqeOQ8jv3eJVHS0Mtke0x0HiaalKZw4sKPVDtGgA5VAVZqESZah/TwsO+jQzNZqy4EiYfmfw0s=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10687.eurprd04.prod.outlook.com (2603:10a6:800:25e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 12:15:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.020; Thu, 18 Jul 2024
 12:15:20 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>, "Peng
 Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "cristian.marussi@arm.com" <cristian.marussi@arm.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
Subject: RE: [PATCH RESEND] dt-bindings: firmware: arm,scmi: support system
 power protocol
Thread-Topic: [PATCH RESEND] dt-bindings: firmware: arm,scmi: support system
 power protocol
Thread-Index: AQHayQZ1IfM9c75gwUa881/OgdwbCrHmazqAgAAAwWCAFhnOYA==
Date: Thu, 18 Jul 2024 12:15:20 +0000
Message-ID:
 <PAXPR04MB8459EB8FC25AFF6D7C912F2A88AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240628030309.1162012-1-peng.fan@oss.nxp.com>
 <ZoZ8Mxjv9cIzivtk@bogus>
 <AM6PR04MB59419639315434DBFF2F13B688DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM6PR04MB59419639315434DBFF2F13B688DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10687:EE_
x-ms-office365-filtering-correlation-id: fb39db1d-7fee-467a-1537-08dca7234aed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b/7obT/U31CZ7iV+YhmSwRFcx2tu++WH6Jzy+XiH2uwP/4ol1pSeVJcPTAf0?=
 =?us-ascii?Q?KrZI6/Dnwp8NLNEm8vpZpFu3+SCSfV/FdkLJ76EdpbjauLchDfNlp+cDQzT6?=
 =?us-ascii?Q?iEyUE2OI5XCIzEIRqnKM1Ag+oNwf/c9NX1I+zMDa8qiSmOhgvl8TykjwSDPL?=
 =?us-ascii?Q?FauXTUprs05a9WOKJrngGZHgaLMC+MKEiW3U4LJ6Qw3nuuMytagduYHgZajR?=
 =?us-ascii?Q?yXgy/6cG6hrfXKjk8viOc1s6ryCAb83u465HUS4eQ/eXDPM+jnHAoDmnfOE2?=
 =?us-ascii?Q?qxOfO7HAPsDQnVD5Q/aq/qg2C2VyBnOyQJU7BEo0KwACLpvnpDrYY+E89i7v?=
 =?us-ascii?Q?75n7ltJrF3dzFRdYBG6zbvbDTc+HRnKeIkxvArQV76FF+yQLeD0I4Lbe1eSc?=
 =?us-ascii?Q?0uwhhinBc1C6ZtfY4d5LFJDIURR58TAmxH9F61jsigoVipes6VuFq9V2wQIw?=
 =?us-ascii?Q?d5Y4esgJlJTzut18T2GET/iwPqkRN3mTKa1Rw+GvFaRnv6x5KjzHcAhEQZnp?=
 =?us-ascii?Q?FET77pc3hO0CwIQfXz+79cjqJ2+NmVq0HZlIXXxU9arDMAGqRqlmdMpAp6O3?=
 =?us-ascii?Q?r2QcRGrUfMFuLPM8Skt3LSHtusC8oq+I+nTbb+JtWJ9uLDpfDP4tgqIvK0mX?=
 =?us-ascii?Q?CLSlGNBDwEQjvix8WqAwiGCy6rF/y6RRM8VTyoJ8ZGGyxdwmbPp8krs5VGT/?=
 =?us-ascii?Q?LhAyBZs+ahZUGxRSony7Ncu8Y8LOWAPchrNVsFDHz1hLUQdvTQ8H2+RaslF/?=
 =?us-ascii?Q?Z6AdbMMn77692VCh7VkZfx+4Opxt7Ec368Pd2nj7dAQq7DOlLHd4FzdahFKW?=
 =?us-ascii?Q?aKBueapldlFqygVABaCwy4OkwVgrMrFP75KKQauJQNFR59oKS4Bvb00Ex4OJ?=
 =?us-ascii?Q?ivcIR8EKfk0z9GwjsFnfQZEl36jnO1t9x7r0OBApp9g9B+l9SKAdngVlNfYX?=
 =?us-ascii?Q?lxjxxRANWKVxm3JTMDzStlMxVFRzCKBm2Jmk5Tltm/Z3dAz68gNbtotBtt8N?=
 =?us-ascii?Q?4RAxcTlxh0MqLVVDRaJZdKNNbBlHlGJio16B1ZATVQAivperpMlsGnpZW32E?=
 =?us-ascii?Q?pvAjcdChyHiErPEEuejvU73VvdBzORAa9tQRf754ah2TFdu/GyOr/DhS3N+U?=
 =?us-ascii?Q?n0cJaiipmh9eIgEniQ8NHeih+Y/IgC9zONfKj9T2CujOvheEbz4/45r5PANK?=
 =?us-ascii?Q?/uIkflpRke/H0wZWn/Gv+EQ2X74K9n7MpMFmc0s2naVsTiXQvo85UdIUfjdr?=
 =?us-ascii?Q?4u0Xs7cPqhP9nCjW6Zl2CCiaD23GfKxTSuibzWNpC+6WJUrtuGB2ntJ+lDs4?=
 =?us-ascii?Q?R1tG+1E8Uze3bfzc5tPfkHxKVOdZbekl+P0TaUFKM/a8sDRLrOn2CtK1bPRJ?=
 =?us-ascii?Q?7mOusPU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VlwERhrLVKaHYZlgXqX0ceOb8ByMtsvw7McQU7AaXOgaTr5GJw1lib2u+XJl?=
 =?us-ascii?Q?4/gkFIKRAcDY5Hwx5mQJm80RP9dx3C850qMcGiRWpnZJIpdfNpa0iNnsX3Nt?=
 =?us-ascii?Q?97GmrHQfP8lg+VwEUKduWI8hrudMtA4ubZIkKgGFmWH2QPc/rcb+wLkClZBp?=
 =?us-ascii?Q?LRsY97EXcyOFqGaHWmEIsMNeqxziOY5Ls5q4VVX8oGSmJnZd82CVKRcKJaCs?=
 =?us-ascii?Q?RyJkJJr8STA+soGmbgAtEPP0o3L87UKcNmax8MvBVSsBdgbvNd+OGh1WpMPs?=
 =?us-ascii?Q?WuwwAMS7oszFiX4NXpdyhEF/mAUVj0R8X/lSuuZUevxkM8lNcHKMDXkigF/y?=
 =?us-ascii?Q?/ip1vKDXJX+y7jx9hmX1pkQdbpk8OhfS+LTzr1AFF1vKkY92Hxp/YsjQqEYj?=
 =?us-ascii?Q?rS7ipXTaeYHNU4uSL47XLJ2VD/g/ayK+zXpyysCwYZRxaxhiEFhmXOH0gO+S?=
 =?us-ascii?Q?M7tw27wKz0c3PlJllEF5NI/dLlwNRQ/qA4PfzTlYJBTK30X3ACpSZ7mLmHWg?=
 =?us-ascii?Q?iGg2cukqkK37ni3OAeW4oEsu0UO39Z/5+7Sss3vb/8o+Wu2HF8V3EDTOO5v7?=
 =?us-ascii?Q?IxTq0UqLex+oL/PG96XHgNkYR6sBFAo2Z/EGf1TA1XJBdq9nyCTpR5TeLHfR?=
 =?us-ascii?Q?sypOdB2vckXC9j+ycbGIe+ct/Jh33wJkP0cNFBW8YH1PMEGNIfrugLiRaEAN?=
 =?us-ascii?Q?DxJTrSOfHswBE4+32EXNQ/0/+x8tjmNzdS8OMZ8WHZMYQelzAldktEKQId4B?=
 =?us-ascii?Q?LkD3pk8cl14Ev1lv3aWRh9IBbePKg8Qj4VteXedu1oiVNtcRF2CeN5q8Bx1T?=
 =?us-ascii?Q?PutbDcY5WoYxR6UEMQRh/eDR3yoJGSsIBIR82tCoVNRj6dJKRwWGXKF2VC8A?=
 =?us-ascii?Q?ZEOBZm/J2JLb16lGI/29Hq232LU565yg2A9iUWvXv+AohFYaODWDn+rrC5hS?=
 =?us-ascii?Q?RqPKDgG3EmQydht/rzpT8h7xQnVY14dPbMg+u+7/jGR2eg4fL+VWTROtqa7f?=
 =?us-ascii?Q?fJWw6I8EK+wef/5TjYktbgN+hFasj57tThV2eDBaupzigbcKezucndZnD8L8?=
 =?us-ascii?Q?EnGDdZTIRkS823acVIWKVTUgiINrjNqoToY/+9sMjG+8hvu7FaJBPtg2xBcu?=
 =?us-ascii?Q?Wg94vziqPdudBHFLbC0rhz3OaDkrAZkyz5qDUf8+SCrFYl4FTttIxN4JvgI3?=
 =?us-ascii?Q?i8d5uJylaIX0BOVpGuQGkHVzkzHP9vikckBcxgFp4j9/94zYSkRyt+FXxDFn?=
 =?us-ascii?Q?mp4Q5BXNT6tmajPtC5yXaiXh7llK35/1o87UgZqLC10nXw7dY3tQMe2twrC2?=
 =?us-ascii?Q?r6H316I04V06AGru56G2/oCjE+R2FaZyLIKCEV7m7qxr4Bs8jqYqqOrjouqV?=
 =?us-ascii?Q?HJSlAP8wGpLWw+aqYy1+ksGwNxpx5fDaO2SB2QFG4Z6Ep48cggqYPDIcm4na?=
 =?us-ascii?Q?x5a6Qa7rsQfe2KrqAJtvUWYdJbQC4Bz/6w0ZED7wNLVkHMmdrqSRDECVel2M?=
 =?us-ascii?Q?saornPl6DmTRWmsFeTT3a9U0zw6Il5h55t4QTFVUjDNv2n4toGcSBHPnCznu?=
 =?us-ascii?Q?+OQMPXzKVoKPszsOTsg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb39db1d-7fee-467a-1537-08dca7234aed
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 12:15:20.2327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0B4r/hNVo0p3ft61UEz1rMkd3WtGTwOfGQnH5XxaVdSIgH1+uRK5Nap27AheFxmkXQsje28gd29/P7NKf5QVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10687

Hi Sudeep,

> Subject: RE: [PATCH RESEND] dt-bindings: firmware: arm,scmi: support
> system power protocol
>=20
> > Subject: Re: [PATCH RESEND] dt-bindings: firmware: arm,scmi:
> support
> > system power protocol
> >
> > On Fri, Jun 28, 2024 at 11:03:09AM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add SCMI System Power Protocol bindings, and the protocol id is
> > 0x12.
> > >
> >
> > I think we must have this node only if it has dedicated channel or any
> > other required property.
>=20
> I posted a patchset to support nodes not in device tree. And Cristian
> gave some comments:
> https://lore.kernel.org/all/Znv1p3FDiPSUNmBM@pluto/
>

Please suggest what should I do to avoid the dtbs_check issue.

Should I switch back to=20
https://lore.kernel.org/all/Znv1p3FDiPSUNmBM@pluto/
or else?

Thanks,
Peng.

> i.MX95 no need dedicated channel for this node, but others may have.
> So I repost this patch, and with this binding change, the dtbs_check
> could pass for i.MX95 dts.
>=20
> Thanks,
> Peng.
> >
> > --
> > Regards,
> > Sudeep


