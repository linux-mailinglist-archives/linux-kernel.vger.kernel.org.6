Return-Path: <linux-kernel+bounces-240887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE16927432
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DE1283785
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78D1ABC4C;
	Thu,  4 Jul 2024 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TZa27BEx"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3501ABC3F;
	Thu,  4 Jul 2024 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089598; cv=fail; b=qIGs872vxsO5cAjvrks6Ddw/uYTKEztvCxO/siYFeT53xYgnJrKAIKgRhu/C73u0LrsCnPx4/t4mJeVqFnqQJ4HbTbwRyWJEn0xV+frnOrKNWH/P0oawfXFYkwX+1YvOKT3tulShyDd8fVqz8vScVnXnZ0yjYGdz8Y76tJ1z1GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089598; c=relaxed/simple;
	bh=E7t6Jg4evrGmF6KlOCzdVNIY93z//Sg6oA4ok5lZ9VY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CNPnnW5zh8+8f0GE8zG4x4Bg4FU/xQxLV3H3IepmqULnKwKVEAZhbdq92H9pPTTTTfby2iiCfYtOqCSzrJOatr+figjPEMvdWl2qlS2EIbQioJj9gsM18PBRWE6lW/iMBhO1rrlnFLV9NFnGJJhGAwWSBJhGTGORcZ5vrh3fHjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TZa27BEx; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF4j2itgTfRMZPxZ851KcGTH1ZtPXSa/7g5fl1tKdcu1a0KdMUnflzOwNUF4U9/3Q/5XcgTivBTGcTGGwqBS8W9YIO0/PTThTHEJz3XnCI5L7sVB0GNbzil78cEBOP6Xv0h95wBhIE2hj/A2mPQ66I8YPVikJ2iG1nuqguEM+Uo7TK0c0fDCNE9xUFHw+GR/Ny3mCF9dBxp6ivIyjKmsTpD0hrAJpno3WFMvsVQhprt+lfT2lpaOk4GHSrjW5FdJRh8ipRJmlWtK3/fOcj2dE7Eh9acm/A00gOEx2tchgZywDRm/nkrVeXR6r4LfW9d3p1U6DhFtqawqdPN3vLR9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfIbA2zmUTbQ54xXQy1+DMJicFEF4nRHTELyzyhpjJE=;
 b=CJZ/5oImoiRBuqVI1CrfAyRGoV1lhvTiVcgXmc+ydn6MEVH4B5maO8fw2nAz4cdUdY8mC7qiBuhn/Y+JhATo7aCjeZR9lfXzwy5ddsHm8xFjJxoB58vSvWcBsjUWpWLUGgUwwzy2WeL6C3n1qbEqf3INRyEF2E2TFRdbO/iy9qquYFsOzyxmPMIcRctOPwPUAyZ5+T4trYA36qWCsd7RT3lqBnRIoOVgJoeoFteLaP5AGaMlgtq3VuAjtUlT3RviegNIeZGfHlMEgQnPX+wZJryOr9Sg/8FRKLXzhUiSkIredEg4wHBRFlkGcQ22OMVSOoYkliBXLxKRt3lEd9auTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfIbA2zmUTbQ54xXQy1+DMJicFEF4nRHTELyzyhpjJE=;
 b=TZa27BExC0Q57uEpXf+GJAuSHeNytis8JvDcpmNi91+Af1PWokYd2Qf9Prj4kBlFcGbBkFWqnqRbaMDddZvt0FyKEWWWwRKlkNXgdSJUpCgAU1dov/WMa4tdFuvquvQYQT8GuINMfRBbEvWrSGG0SNvAcU594zTVBLbWYZTO7nY=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AM8PR04MB7203.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 10:39:54 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 10:39:54 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "cristian.marussi@arm.com" <cristian.marussi@arm.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
 property mbox-rx-timeout-ms
Thread-Topic: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
 property mbox-rx-timeout-ms
Thread-Index: AQHazPZCUnP/ehpH2Em9HKMSjtmmz7HmYioAgAAAeBA=
Date: Thu, 4 Jul 2024 10:39:53 +0000
Message-ID:
 <AM6PR04MB5941A61736496B9850A3B52C88DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240703031715.379815-1-peng.fan@oss.nxp.com>
 <ZoZ7NCSaG0YRK-60@bogus>
In-Reply-To: <ZoZ7NCSaG0YRK-60@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|AM8PR04MB7203:EE_
x-ms-office365-filtering-correlation-id: a25c11ce-f38c-4cd5-680a-08dc9c15a409
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PhF0lx8dxGgCJsgHAGVQFueo4w4E74c3qKt7cxw/1yKelFkfPGsmDTPhVpco?=
 =?us-ascii?Q?EpGVBuBlwE7Hc26qJoAQSWjcgWbBzDyP+13wheAcwia0+JzpcHHR4xsUummm?=
 =?us-ascii?Q?vTgday6LljcEgb12dk/f3UFlnhrXBHO0af9E74Xec1PornJqGHqancauEhLb?=
 =?us-ascii?Q?weWFjvyqfRRHFXnEb6Mq9nsdxwVGInYjQk4z8SM4Ios25J2WhpKndvLXA6LQ?=
 =?us-ascii?Q?32iPvWb/ix/Ef42faedB40ROY9tuzUB1tT8Z3y0ssWuMaD0dI/XjomB0QDMA?=
 =?us-ascii?Q?UGOKYh7nfbzJqXTVZJ4GC+ilH/LzFAosl48CnPWyEUgQwu4gBYQ0WWeVKXer?=
 =?us-ascii?Q?fqY5d1tkCpwVvqB1LdBNZhRqoc8AmKF1i2znZ8yi+IiRtnaOGq57vZxHCWYJ?=
 =?us-ascii?Q?8ZLt6/TXLMwsFlmtZn0fCKr85UgopLQnx5kqcxm6UaoIPPmhJMaiDNdIwrXU?=
 =?us-ascii?Q?OvuzArLZuLvNEjLYcCS2Vxb0jA72aoErm7wcpOzTREsvXvNt86uccw5T4rH/?=
 =?us-ascii?Q?vNtgC6etoisvrxswRKqAHPqS2fIK80cSJupLDAaGw+VTJJ0BitPoJr4tL3F6?=
 =?us-ascii?Q?lA5ZAIopOAfwfCx/iLKl+XRWRBJczAzx3fJS3W/TmaQVJL5rOyDg7LRf8pCf?=
 =?us-ascii?Q?hDjygSXoNG+Uv+TaL8QN0OJxv+yX80f98jy17bdtm0YGlwBGiMkqL+B1qSAZ?=
 =?us-ascii?Q?/Y2AofX6yg3pLxT5vxx3atRxbuLs5dEkEJFc2O+z0VlRsL/l3YDwqKQjrp9G?=
 =?us-ascii?Q?TNALwG2GSvFPBEwKUslbuGbr+bXseIudh0m3oUARDRZnXnsaVaGsYrH2lqap?=
 =?us-ascii?Q?jjC0OgxPi+fKnap7x4hCf8F9pRQkDl4gvWmDxALbDMrlVeidUiI/D+RWXIdb?=
 =?us-ascii?Q?ptEVAb6ExuHjJ/Pvz++r9YUCgtURbjmvR2AZPjBGGzV71LJ/hfPwtY++d5R2?=
 =?us-ascii?Q?ey5Ofa2yZnhM9h6SLsIyzHpZGHv3/pBPzEX8IRy/g8V//8tzAHbPSwuZkRuD?=
 =?us-ascii?Q?+g1OXwIta2gwDuzQEnL46DYtffn4q91qMyvc6WFKp04kz6W8dSvWtHaNr6ly?=
 =?us-ascii?Q?uPYg5zHB1v2/IRCc1w972YtDm4OgnX1N/26K/M77FMZzkIdb0f3QJ4zrueA+?=
 =?us-ascii?Q?SFc57cIDW8qaxzRTTYyLNqFoth7n2mmEaCBe/Q44vCirPX2UZxZux2xf5fBK?=
 =?us-ascii?Q?AnvSlSn4arNWuYpbG5XqnTjrxYVBFJj/u5eR6/NjV6UUVEEIiIPM9MhiHZmX?=
 =?us-ascii?Q?q1QgM09budCn+zjaVm5r4ltkyXUyoHuoLCOYvUygclWDCHumBrWySH+Mi2xJ?=
 =?us-ascii?Q?p+XfsgFBOC7gldXPIxhcGskoyYW1trGbk5UsHC8BK+H6SDW4dRle59aRrsGG?=
 =?us-ascii?Q?CEZOqD7TN/9X/7QyeJdGIEIn/asluImtAPx92+Ol1Su4yONsmQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UPiQDbrJm9NpVebDjyK9ANQSiAo+YZOAUQfntGxcjP+S81ICQRr9C4pxLf7L?=
 =?us-ascii?Q?PxO90S8udGRs4TCVvIIfquZpPOp0QNofo9XOylb42+6PXSDMkZ4cVE0AGSiH?=
 =?us-ascii?Q?5bc6tt9xgSYjcf0sMyp7zK8DL0nw/0SAPxpUzOFN137pQGj6bGv8t+f0uLM+?=
 =?us-ascii?Q?w/2/th0t6h0Gsqfvm5iWbr66+YL86Iu/LEgxkLX6r120c1zkR712VbciDDCA?=
 =?us-ascii?Q?3R96GOwb68K5kREmesx9JYjXDVLJuCupUbk6FAvzYDAEVX3torRXN+3Oqo9I?=
 =?us-ascii?Q?28T5fwOQJbrAgu+Djwvz5tVVj0OPuzEo5TC1UmuuX9NVIPBF4MPxuNvbMFVA?=
 =?us-ascii?Q?enrsT5iLQ1HCLuJJD8E1BIyqNkdTNQ/sBGgn9V5aSXW47oHnw/Ok7nkjEB3S?=
 =?us-ascii?Q?XbcoqaE8Uk2Z4MbjqM7dubT1fG4pOmnKSauijqJSChmHOEl/xk1adDIllDUR?=
 =?us-ascii?Q?ieMi5eledX1bGr3AyAP+sTIeie8SG1gtwVkZM8YJ/mWO42xUdLXf/aCEwTmu?=
 =?us-ascii?Q?RPEtMTeExgfg5KpEqcyOEFB8cmeFypbgzFpYrHtGF9idpbTLGyNzjAIlCHHF?=
 =?us-ascii?Q?KVHXlPS4hh3lGeInT0YUf/i+srAyPTAGaeUSNbwyz7ZeJsiMTA4+aR5ruSYs?=
 =?us-ascii?Q?VuG7r1l2GY7F7N9TPkYohmF/6Q2PFi1TFfflIdUVswIQKgKeaTXYZ8Pdg6GD?=
 =?us-ascii?Q?SkoYJQbGxA6xDPQjdhdzxNmta9J9RP1Mrf6HhgrS+T9Z8hCu+rSQANfKU7rv?=
 =?us-ascii?Q?hFqSlzGOHW97B+eKbseKQykfJh03V4wxNWpnaJ+CJS5Zoz5JZNkehM7rVFXs?=
 =?us-ascii?Q?JExLBbc2s9CFn8YxrI3YH1Rr/mmT+6G1vssRjCatZ/PgTAtgv6x7biLFIFBG?=
 =?us-ascii?Q?UYEWV25MVGqph0L/ulY+qcUdcW/GNKU7GfCboy7jzTQD6ZGY27xnk2giPLbv?=
 =?us-ascii?Q?esjv/BfcGifuRqjyM+e7EidRM5UHRvqkWhmA+hI9rkhrp/rXSyv01pDV9NlU?=
 =?us-ascii?Q?Y12I+sNVQUHreYFnxJbNa6qII00IVeCrzf1T5w+tXIbSM9fVDspyinx35sJr?=
 =?us-ascii?Q?zKz8yIm6yLGVkM5vk/Q1iIVRRsGWVTPs/MhTLkmjdJ710nq8BkdOr/kXE26+?=
 =?us-ascii?Q?9dIOaNFYudzv4iG9udSnmomAKFZND5W7xPmfNrCwtFPTr1ERGipdgOhmUWmI?=
 =?us-ascii?Q?+Sey8rGnddwDBTLNxGlfTGZ872UsRje5a5FxMixDES0AxuIZNL4kxGfG+zRz?=
 =?us-ascii?Q?M+ugUcUApwLMHvsBIujBLxnQmj3gw5RSpCyrGBsnxZBZYuQADQAhYYiXMte5?=
 =?us-ascii?Q?rZ/o7XQyhCl8WBMlicOoPv5/C+YAZbxekfwyEJgwH+uPZv9hl6WFICzZKR8y?=
 =?us-ascii?Q?8HvjOZIIZL6aysTyKC9S8VJr9s61bElRZFEGhbU0XFxc1MI/1o4aEWVFVvA8?=
 =?us-ascii?Q?1DNztYYwQfd9d1ZGcOhoW0/uOAUt4hMlOyHrqjxQfrd8kxJU89whBiT4Miwe?=
 =?us-ascii?Q?IPnbXxlj6h2bKXDXXtoyOCJ/ZTE5EyGleyz8m/PsnIhtNNQW/ueewULfZHas?=
 =?us-ascii?Q?72Kuvz9QJJotVgmV1n4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a25c11ce-f38c-4cd5-680a-08dc9c15a409
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 10:39:53.9812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzQ7RYHnKrS3deJ/FFFTCoB99+Hil7bx9RHO6tkHerSxEgEUGfHDETsZCDcYV5C6W/VvcWXH7h6n3b2y1xi6+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7203

> Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
> property mbox-rx-timeout-ms
>=20
> On Wed, Jul 03, 2024 at 11:17:14AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > System Controller Management Interface(SCMI) firmwares might
> have
> > different designs by SCMI firmware developers. So the maximum
> receive
> > channel timeout value might also varies in the various designs.
> >
> > So introduce property mbox-rx-timeout-ms to let each platform could
> > set its own timeout value in device tree.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  Drop defaults, update description.
> >
> >  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 6
> ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git
> a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > index ebf384e76df1..dcac0b36c76f 100644
> > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > @@ -121,6 +121,12 @@ properties:
> >        atomic mode of operation, even if requested.
> >      default: 0
> >
> > +  max-rx-timeout-ms:
> > +    description:
> > +      An optional time value, expressed in milliseconds, representing
> the
> > +      mailbox maximum timeout value for receive channel. The value
> should
> > +      be a non-zero value if set.
> > +
>=20
> IIRC, you had the min and max constraint in the earlier response. You
> need to have rushed and posted another version before I could respond
> with my preference.
>=20
> So there is no rush, these are v6.12 material. Take time for respining
> and give some time for the review.

Sure. I just not sure what the maximum should be set, so I drop
the minimum and maximum from my previous email.

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep

