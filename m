Return-Path: <linux-kernel+bounces-255982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E254934764
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC5C28388D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4718E42067;
	Thu, 18 Jul 2024 05:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NVmBY/ry"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634AB1DA4C;
	Thu, 18 Jul 2024 05:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279488; cv=fail; b=cy4vnGU6yblV2Qy1qycuGwjAIaWonwwfBHWmDpM9usSpH+mJqWszaJNNJmGXLbVOWBRcnf/bQI0YC+/BrMWmQg1besKeDAdWQu6Pm/S5ezZ7VGIX2GmyRb6/IxtTFSXItd95xxxzbg/ZaCZhfDW1ZGpe5Ltxz+SPOfHOFV9LcbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279488; c=relaxed/simple;
	bh=BtMQe+j1b7fiW8WjfVakYNxtL+xCjhoYQlsOn3VdWR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZaklqyFkYwV0BW1FIi1DbuLLpxekLi0KA65pxGxUyXzr6SzsSksvpIZx47OiU5NRrMQgCrfLXyWixikbnFPF3bbMlWhBx1MhHlcYGZv1Ple9vcoPJHVXebwwTC6rlSVVRk77JTqBOYc7U4/5Q2nJwOu72ZuqmXmdwzi9qzTD6D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NVmBY/ry; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbImePrqOJNxdv6XV4BEVi0JJu2qayiUAz1ST9Nq6IXmEzigjHjVve/+y3cKUY0vJozDb0UIR3Sos7Jb3rMzbzyVjkQCCNSpcdlaACSD8xJPbdWBIKuRkA/RgdExyeAIs/4s0rWpVngtHSSwfG3egmKar70/KCHsFwwe8aRrK/Yk+DEkdnqeSD6rh8iJF4SSzrSq+kxa+Dk8cKCP6sSxZe/oarZ29BsgOLjUMepyd/o4usGmEm3RdEwzPi4AhrdrJ9XXr2hRHMnxkoYkwtztu9dWzPA4UwuAzwbOqDOyUFxLvE5E/h7L4fclQi0VFkOmHFaKdQsCz9A4aZgRHFU5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxGmB52+uBr3qvi39s3ADvQKNxscwYjciiXhTWt31zI=;
 b=tPWeJVxGexSTWqMAZqJJQpXVjXRL2tc3+uqM67hN9IHoJt5luUoWgnyAi5CZfh1EhYtPC2G8nEqwHyMtUZsmllEQM4fNeIxxWp60a8Dnx+sIye8breGrpewNIO39/vYmN+LGWxikNc4yKk5SfB/CXhihTXiG2g8Ojk9nTNqSRRZ8ODCY/ejzG9nFO3oipE//2Tx1liqTDE3qxCSMeuieR8vu1O2Mw+tn2Ozl0dT+hzW0OSIOzENHVYsPeObobWBO4WsHZNWFbHRyQMIqbns6H7zi8Nkz1FzBnuLPl0z2LqbX4vvzbQXl/1A+Zxg3gqx2Sm2K0wIuq8Kh1+Ok00+bMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxGmB52+uBr3qvi39s3ADvQKNxscwYjciiXhTWt31zI=;
 b=NVmBY/ryMHC/SlUuU3Lk/Qmqs7Md8TKWHAjScnBCTH5zHIyT8Ps0u9f8WwXzqZQAJQ6bMCFchSWmmELG5ptDSS/Orby61bKUMZcSbzNrZ0LZfB4ELscNFUt20IU2HJSf0wQV1jI4K0QU7w3+zrp6pTnxD8IeHBOqEyMNTysnn0A=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by GV1PR04MB10276.eurprd04.prod.outlook.com (2603:10a6:150:1af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 05:11:22 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 05:11:21 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v5 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v5 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHa1CP/sfbwKvfpdE6YN2bMfeC3aLHzY3MAgAPbVACABLir0A==
Date: Thu, 18 Jul 2024 05:11:21 +0000
Message-ID:
 <AM9PR04MB8604A204F35B79DC299D6C5D95AC2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
 <20240712-imx-se-if-v5-2-66a79903a872@nxp.com>
 <20240712180358.GA1286437-robh@kernel.org>
 <AM9PR04MB8604BA0B01612B38D9282CF795A12@AM9PR04MB8604.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM9PR04MB8604BA0B01612B38D9282CF795A12@AM9PR04MB8604.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|GV1PR04MB10276:EE_
x-ms-office365-filtering-correlation-id: cc8b6069-842b-485d-6a2e-08dca6e81077
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?d4z4TFOGu/ujVj9otMzFsDPqKvrJ/xipJkNsm7A+4aN84TAmceh2D1HnbWV1?=
 =?us-ascii?Q?0Oi6+zsIMIubnD1qa6c5pE+3o0jEeU+MjSbH0Cohu+yXF2A5zsmVNDKQZInW?=
 =?us-ascii?Q?gSLvgRZKG9n0yz5d51X7ySqDayXgXApgNG5i+M/gFrTcpE35OQm5bGu1OjOQ?=
 =?us-ascii?Q?qJk8VHPYthKe6qwXFTfwvt125dCqluU1rlkOuhZTuG87Dmr88bhylVUzIjdu?=
 =?us-ascii?Q?PAnI/ibDJbaWwBUaA3PludfuRMOyknP9MAI/Jjxp2lQyXtQmY2OiyYGzjCbk?=
 =?us-ascii?Q?GgdpLgpFOlo8mYlGWiqcuxAb5KkmpdjLtt9a23OrNRBi2jh/9CoIXzNgifsL?=
 =?us-ascii?Q?gAMI43kB/ME0TBCgxHYRy1xKIMeTFTnKv0AMV215109R4jB8k2mSe9MzCyIT?=
 =?us-ascii?Q?/V3ufR3BrGw2SEe+c07JVcqK9rNqJFghS6gv4KCLzY0ilztTB4dIoVdqcO7H?=
 =?us-ascii?Q?qSi9gj1meAXX41NoVlDkuCiUEGxZPBBHAaAUUef5yeNDrJ4reJ1te7NTxUap?=
 =?us-ascii?Q?0sXoFCuwKxmx8oPzFqwSKdchGqYj0SzdAiMBWBnEWohqFPD7uR9jildfEErU?=
 =?us-ascii?Q?S1pVYtbUA4rfPe2vSA2xNa6Ucs2QA8vryiXeWwUV+IBJO6wQ3HOjt16s4leb?=
 =?us-ascii?Q?UG4Sagd8Dk1PBZlIGNvO123VZumVAs2cWPQKypGgIqs1adqov/WrgGB0tZCO?=
 =?us-ascii?Q?RAgrM4Ityc7gOEfTd2MA9FttozAuRYjDeLtouLAARmXlYkfqw7iBE2EIQuR+?=
 =?us-ascii?Q?uSHpoayBLobtj0lzWwmyXbDwkskKduuDpRyr0EeGTO7HAbWIit2/PQR2NzF4?=
 =?us-ascii?Q?EpzJ376Qto/DdNOnBrgcUloTotagD33WNR9As/9EsoWqUTrcnFSbl8WsDIgy?=
 =?us-ascii?Q?AJQfLEjq3suGNgLNJLDsGaqPxugi3Ck3OmMQxxQKCb8ulNXKtou1+8Xfgu+L?=
 =?us-ascii?Q?gklYChz/w1xINfq99RVEPcst55cDnwDmv4fzaoq5T5LZ8J5FO+EhjsVPO4Be?=
 =?us-ascii?Q?fukAdlQk5QdBAy5n/AuEDcNQs50r+bMlcKIRGXqw3+FlQMzXa6dVG8klu0m6?=
 =?us-ascii?Q?rmIz2+XRjHNoQxK8WApO+gvkM4tUxsROmeOmREFVr+5w6HP9Bp2k087nMuMg?=
 =?us-ascii?Q?rR7PjcgHQljJeK1v6MZWzg6Fhs5rD4yM7A8RH0fyUo7y7c3Tzw/JOBMLxo9v?=
 =?us-ascii?Q?ubcp6OlEWK8SPSW76ip9u7OqKcf6gJdE5zRpA2m6TM4y1+XK5ZkOO1Yk6NVf?=
 =?us-ascii?Q?+uNfWWTC/5U5tJad+ThutxcfLTIegXEZnITAtT2X4CljB1IfNJ2O+opWXb1u?=
 =?us-ascii?Q?woOMxJzNeBGW/VpVziu50/B3yXmEojMLPGZWJWqOHzKb4b3XXeKIy5IsSWDD?=
 =?us-ascii?Q?NiYu0jbDxiASLuOtJwW7/D77FGeReCVDkmGg8EsYqk505lBckA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8SQmuXVghG3CqJRNZy6f99ch75Ip4AxNjq3JqWSS2QL/1Z2DLSRHInLU1nW1?=
 =?us-ascii?Q?qA6YSP4noK33ORCeMKmMYawsg8SdbejNwkgb07ZQruUFbSepIWEghoitQ+/9?=
 =?us-ascii?Q?Q3084RbY8tiAmSSZUmXBV/MmaicMr16hq3NWVKjMmSXJjS4jsf2D1lW08G+4?=
 =?us-ascii?Q?3S5jbU23UMsCXJeGIReJJuu/59Yz6n8gdFpY+cRiltbmJxRPSfKHr3S/mbka?=
 =?us-ascii?Q?ZDf+gYLgoPNs2hYkDyakAXjmEvYln5m1yIHdAuEfohy4dBd/jwF9qxyUMzhO?=
 =?us-ascii?Q?FyU6dfyI9NwhCX5reMYBeLyEbXOs4s2KWAmohxXQrlgVfwlXkEzlpspFEPS0?=
 =?us-ascii?Q?mq2t5sM0vwTiBpd3ze8JTlwYurbi3+NvA5Ide+alyt4V/qrnr511yNaEFPoj?=
 =?us-ascii?Q?GKvVPyh2TZLPHhPNio0UcwVjQcusghsjZowHGXGA4NdmW5QjXAXVuKNlg/h/?=
 =?us-ascii?Q?sH5r22361Xr0QGWYJtH++E6TKb9i5t/LjdnU3/n1eowbJ9yQMG6x89v/wDq6?=
 =?us-ascii?Q?TF8nBKBoQ9PkuhovJJsJi/puYc9JcG26Ew7j4x/ItcANUzkq5M27qEyvdH9j?=
 =?us-ascii?Q?QkHKtSKChaSV96Eg1vvKra0/bU6LwLICFvGnCX4SmPPXxL67XNJWqh0ulCnR?=
 =?us-ascii?Q?DgaBF4BksmU8DjBo126diHid8uAZeIcFTfQSKhd2FjUGsATJJw+Ml01XxyC6?=
 =?us-ascii?Q?BE2PEb0AtaSL4mKvhgz/nEasWJlD63K2/xE2SHKXsyoKzNiMBwQ5xCX3/A0T?=
 =?us-ascii?Q?2Rg/ase5HGWAY4h7j1OFfhorjNCh0cKc10DrFbkhczu4pgxTaV/arfzLFHry?=
 =?us-ascii?Q?FWOm3jEkiACkMY1590utslqiI/WZJrpwp6bWU15Y1dlDWA32cNQGmCajTw42?=
 =?us-ascii?Q?+CL/LO9COwpWilKavVRVAaY5yErqB7T/K7Iuihzu3hU5EgLwJ5YWzSRa2ywc?=
 =?us-ascii?Q?VrNhpc6aJ1d7yKxivksu0vTPB04AB9YU0TMI7N9EeHj0W9xt6CM+T5YJzIBZ?=
 =?us-ascii?Q?U8gSOW1fAf24C9S0S4BT2Zu/thbbz/9ozsXNjrepUixq+cMofqBQWhJOMtyw?=
 =?us-ascii?Q?TCJY11Ep4Kp5fEBdS2LqUMAbLZpQw9e444Pj6jgqU7mSwZk4YYq5xQXPMP4N?=
 =?us-ascii?Q?QAWvCGZeR2V1CphZLqkZPLUy94+Sfc7+J1bCA0wWRodwYXDiCqkebQtBoYar?=
 =?us-ascii?Q?qMtCzbrOV3Il28FKU8HWAvWHqVqAIkYg8hhNw7tyqFVnNBGpp9GzYktXaFc4?=
 =?us-ascii?Q?oK+DZH/ioStv+kCu0CXNre1V+c4seObQK+9nMuQKDvyFJrVyU9YBtdDcac5c?=
 =?us-ascii?Q?mSmX6LfSpepX9B8TRoYwA0+/L3woH7nwkSavPhSVe2v6qwKqouBvB4AbjZiF?=
 =?us-ascii?Q?YqZbiTiEJClAqgkAItfwF4UMMsGVlxEEuuhHxX2kp7insU9sdB02cYUE/KCw?=
 =?us-ascii?Q?2pgmigEvcBnplNWqWOHiCUp7Uvwc+uMzNZzBm40Q5YNN19xjk9sMI7w+VgRC?=
 =?us-ascii?Q?M26fHB1sPCqZ+kKCdvl/mEBhnna2x+WEerVkePlrixOaEt69mAgqOljrZ6Ky?=
 =?us-ascii?Q?T5lC7O21UwgO4rNG6KfUvQ5HLE8VBbMLSssmno9O?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8b6069-842b-485d-6a2e-08dca6e81077
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 05:11:21.8221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgJANPtSfX8t4WhWdIRlWzEMJctIgNmjRl/qeBhP9/ZNHED4HmozX48VoKaIDYbrrnkP7FWtPtUn7mXhCtja0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10276

Hi Rob,

In case of the i.MX95 SoC, which has multiple firmware nodes, two firmware =
nodes need to be differentiated.

Is it correct if the following entries were added later, without 'reg'?

         firmware@0 {
                 compatible =3D "fsl,imx95-se-fw";
                 mbox-names =3D "tx", "rx";
                 mboxes =3D <&elemu3 0 0>,
                          <&elemu3 1 0>;
         };
=20
         firmware@1 {
                 compatible =3D "fsl,imx95-se-fw";
                 mbox-names =3D "tx", "rx";
                 mboxes =3D <&elemu4 0 0>,
                          <&elemu4 1 0>;
         };


Regards
Pankaj

> -----Original Message-----
> From: Pankaj Gupta
> Sent: Monday, July 15, 2024 1:26 PM
> To: Rob Herring <robh@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: RE: [EXT] Re: [PATCH v5 2/5] dt-bindings: arm: fsl: add imx-se-f=
w
> binding doc
>=20
>=20
>=20
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Friday, July 12, 2024 11:34 PM
> > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> > <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > <festevam@gmail.com>; linux-doc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH v5 2/5] dt-bindings: arm: fsl: add imx-se-fw
> > binding doc
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message using
> > the 'Report this email' button
> >
> >
> > On Fri, Jul 12, 2024 at 11:49:57AM +0530, Pankaj Gupta wrote:
> > > The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X
> > > etc., creates an embedded secure enclave within the SoC boundary to
> > > enable features like:
> > > - HSM
> > > - SHE
> > > - V2X
> > >
> > > Secure-Enclave(s) communication interface are typically via message
> > > unit, i.e., based on mailbox linux kernel driver. This driver
> > > enables communication ensuring well defined message sequence
> > > protocol between Application Core and enclave's firmware.
> > >
> > > Driver configures multiple misc-device on the MU, for multiple
> > > user-space applications, to be able to communicate over single MU.
> > >
> > > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> > >
> > > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > ---
> > >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 111
> > +++++++++++++++++++++
> > >  1 file changed, 111 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > new file mode 100644
> > > index 000000000000..bd99505de6e6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > @@ -0,0 +1,111 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id:
> > >
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > > +cetree.org%2Fschemas%2Ffirmware%2Ffsl%2Cimx-
> > se.yaml%23&data=3D05%7C02%7
> > >
> >
> +Cpankaj.gupta%40nxp.com%7Cf1bfd437edfe4dcc6c0b08dca29d0434%7C6
> > 86ea1d3
> > >
> >
> +bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638564042462565488%7CUn
> > known%7CTWF
> > >
> >
> +pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ
> > XVCI6
> > >
> >
> +Mn0%3D%7C0%7C%7C%7C&sdata=3DUxa8Cb3W5imjH%2FZGUEaGGO4VYFO
> > oeVwzJmeFd6SbJ
> > > +TU%3D&reserved=3D0
> > > +$schema:
> > >
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > > +cetree.org%2Fmeta-
> > schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpankaj.gupta%
> > >
> >
> +40nxp.com%7Cf1bfd437edfe4dcc6c0b08dca29d0434%7C686ea1d3bc2b4c
> > 6fa92cd9
> > >
> >
> +9c5c301635%7C0%7C0%7C638564042462575447%7CUnknown%7CTWF
> > pbGZsb3d8eyJWI
> > >
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> > C0%7C%
> > >
> >
> +7C%7C&sdata=3DbhF5HZ655JjWQCaTu3BP5rd1kXZLSb8PKNsle7aWRq4%3D&
> > reserved=3D0
> > > +
> > > +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> > > +
> > > +maintainers:
> > > +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> > > +
> > > +description: |
> > > +  NXP's SoC may contain one or multiple embedded secure-enclave HW
> > > +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> > > +  enables features like
> > > +    - Hardware Security Module (HSM),
> > > +    - Security Hardware Extension (SHE), and
> > > +    - Vehicular to Anything (V2X)
> > > +
> > > +  Communication interface to the secure-enclaves is based on the
> > > + messaging unit(s).
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "firmware@[0-9a-f]+$"
> > > +
> > > +  compatible:
> > > +    enum:
> > > +      - fsl,imx8ulp-se
> > > +      - fsl,imx93-se
> > > +      - fsl,imx95-se
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +    description: Identifier of the communication interface to secure=
-
> enclave.
> >
> > I don't understand what this is. How does someone determine what the
> > value should be? Are there constraints on the values?
>=20
> I will remove this. This was added to differentiate between multiple firm=
ware
> nodes.
>=20
> In case of the i.MX95 SoC, which has multiple firmware nodes, I proposed =
to
> make the following changes in .dtsi file:
>         firmware@0 {
>                 compatible =3D "fsl,imx95-se-fw";
>                 mbox-names =3D "tx", "rx";
>                 mboxes =3D <&elemu3 0 0>,
>                          <&elemu3 1 0>;
>         };
>=20
>         firmware@1 {
>                 compatible =3D "fsl,imx95-se-fw";
>                 mbox-names =3D "tx", "rx";
>                 mboxes =3D <&elemu4 0 0>,
>                          <&elemu4 1 0>;
>         };
>=20
> >
> > > +
> > > +  mboxes:
> > > +    items:
> > > +      - description: mailbox phandle to send message to se firmware
> >
> > "mailbox phandle to " is redundant. Drop.
> >
> Accepted.
>=20
> > > +      - description: mailbox phandle to receive message from se
> > > + firmware
> > > +
> > > +  mbox-names:
> > > +    description: two names are to be listed, one for rx and other on=
e for tx.
> > > +      The name can be any of the below list.
> >
> > I think this can be dropped. The schema says all this.
> >
> Accepted.
> Complete description will be removed"
>=20
> > > +    items:
> > > +      - const: tx
> > > +      - const: rx
> > > +
> > > +  memory-region:
> > > +    items:
> > > +      - description: The phandle to the reserved external memory, th=
e only
> > > +          accessible memoryregion to secure enclave(SE) firmware. It=
 is an
> > > +          optional property based on compatible.
> > > +          (see bindings/reserved-memory/reserved-memory.txt)
> >
> > Drop. 'maxItems: 1' is sufficient.
> Accepted.
> >
> > > +
> > > +  sram:
> > > +    items:
> > > +      - description: It is an optional property based on compatible.
> >
> > Drop. 'maxItems: 1' is sufficient.
> >
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - mboxes
> > > +  - mbox-names
> > > +
> > > +allOf:
> > > +  # memory-region
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - fsl,imx8ulp-se
> > > +              - fsl,imx93-se
> > > +    then:
> > > +      required:
> > > +        - memory-region
> > > +    else:
> > > +      properties:
> > > +        memory-region: false
> > > +
> > > +  # sram
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - fsl,imx8ulp-se
> > > +    then:
> > > +      required:
> > > +        - sram
> > > +
> > > +    else:
> > > +      properties:
> > > +        sram: false
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    firmware {
> > > +      #address-cells =3D <1>;
> > > +      #size-cells =3D <0>;
> > > +      firmware@0 {
> > > +        compatible =3D "fsl,imx95-se";
> > > +        reg =3D <0x0>;
> > > +        mboxes =3D <&ele_mu0 0 0>, <&ele_mu0 1 0>;
> > > +        mbox-names =3D "tx", "rx";
> > > +      };
> > > +    };
> > > +...
> > >
> > > --
> > > 2.34.1
> > >

