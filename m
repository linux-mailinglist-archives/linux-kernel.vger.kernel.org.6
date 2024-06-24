Return-Path: <linux-kernel+bounces-227255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5313914E15
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038551C209A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAC613D62F;
	Mon, 24 Jun 2024 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aZjR2R57"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2067.outbound.protection.outlook.com [40.107.7.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016413BAFA;
	Mon, 24 Jun 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234748; cv=fail; b=nuCw1AfA0fYtn0AT7e3uZstsWr2dF1qNTbGiLnIhJLGgB08JUDPTKpT9WLuLZaDsEi3+FyWhnsiMo0NmzbU89FLgm4MYqdcXwmoxBn5yJbT8+TLBmfrvPI54mDSCNmFAkPSOAww0C6Y1jVl+JvymmYNzf8MFtqxXKVgpTYG8+xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234748; c=relaxed/simple;
	bh=4hokBicsu9BWESGGuhZkzDs3YqAhdiQ5ugarG2LuwY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eF8QGlTy6Fj+QDr1cLSdrksQ4bv/GAD+686YFSvq7YC2XTxBgXpiCp+gs011ivV58aYiJEfjeEgD+MvneuclL4tYLzN7ug6kIoYKbM4ileAYxV6wl5KdE0SA6ag+ePcW+TcXtKcYuwtAUbCe3WJREshosSLSi9N0Z9jSM4ACmL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aZjR2R57; arc=fail smtp.client-ip=40.107.7.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjeCbDIdoLJPQxXcCKistdRWRYk9y1U1WkuQC6Ng+mszGlGDKzEUPlOjUHxZ/N5LYw7s8sFT+sJ6JN2RdewIAJvYI4ItBLP+6Nuznd1M27ntJddCtvw/6YY6l3hvhhoOs1zqEU4c1iD3WS8YtHQjVJBUxxP7HM3O/easjsBQCPbSI+27ijGEVOjjjZAD/ZtEE990kuUqXVhXPgkI+2Y4ClXdZENn6oMebHbMYm37S++3fLNP7iP91+BBM4nEnWdFDM+SA+DzSl3o/x3NJ4sjFJWOjaMJ0/uR1vEwyrLHeIJONee1dRDHkenshH3OYp8Bg9FCZUxnwlVHwnnx+ehkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTBs//qBiOwFyvYTVbIPxjqniQkPCFWSzJ46qKz8SG8=;
 b=Wt0eKWwQ2m5DaGwcIYmquhLtwjvp43PujTFZBc9IUHZjYSvkgyJPB1mFpGpt/GK1GgrQIejbnKjVfwv/fatbJmwHLTjVP7zOh7J7P1UFQRRfCABeAKAnjO1lSE0kqKOrJKx6VEu/6NLxe5ZgDTDGbM4Sl9lZOnn+F9xJHR87wIt8LvTraLQk4hJjbJHfJy3gj5al0Hc3ZOXfGxdiDdQ5Mu5MOfVTXPwH3TNd3vPGMn+sQe/vaAYe9KnMukV8rWBfNnWCNiTfkK5asYSDZspaAuruzFRVSaq3tdsVCzlygo9c5xn1cnkZvRb6oxCAu8285aqxIdgZpI8Hy42lu73T4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTBs//qBiOwFyvYTVbIPxjqniQkPCFWSzJ46qKz8SG8=;
 b=aZjR2R57Qvl66K4KkxHkb4yRs+hgZvGw/bvUEUh/iYLdq2XhjmgpC783ibMffn2pqm/kxIpQtJXGtabkNKwDfITsYiL0oLQHRH2kxM0st+oGbK/F9HxCp2Re1o6yxv9Bs2AaIlvqRXisZNPOLYbE8L4Czi7D66ejG4dIkEaYL3s=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by VI0PR04MB10925.eurprd04.prod.outlook.com (2603:10a6:800:25b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 13:12:22 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 13:12:22 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHawIiTY2uwWBJroU+O1Zn+P7i2k7HMKCYAgADPmgCAA1JkQA==
Date: Mon, 24 Jun 2024 13:12:22 +0000
Message-ID:
 <AM9PR04MB8604DEB65CB32FF7D68013ED95D42@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-2-a7d28dea5c4a@nxp.com>
 <20240617-control-calamari-317f59c4eb09@spud>
 <AM9PR04MB86049915593D86599C67975F95CE2@AM9PR04MB8604.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM9PR04MB86049915593D86599C67975F95CE2@AM9PR04MB8604.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|VI0PR04MB10925:EE_
x-ms-office365-filtering-correlation-id: ef929dc5-a555-4cc4-c3f4-08dc944f48fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|7416011|1800799021|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N+GZGIerymnntWuF56p1yZp75ebb75Fd36xDZbU9FtYxI18bsLLhHDpbYrXi?=
 =?us-ascii?Q?OCyJ+SzUl9P5OLdiyR8JLWviC58RD3KNQnLWSrA50FlQnFaCwcWJlYVE9O8f?=
 =?us-ascii?Q?Pyj7cdncDlUNISwVk28cAGyBmnOajKx5tS+AUNigo0vrUFAvYtbhgV3zKIrc?=
 =?us-ascii?Q?ir9JOi+y+vBmvYI7jN9zwju02LokK3mqiv1wNMxdNmOzVbM3Vs7s72RW0VVg?=
 =?us-ascii?Q?Fjj2YhlDfJNijeGCrGISW13J5YrjoFw+odjgq2YjnI9gC3Ue2WbrVEbH7tpP?=
 =?us-ascii?Q?v+ztA3pdDLCRcTPVXaIodJmiyyEq22XtoW/Jv3H3Q5X4SigN3IZCiuckpfMn?=
 =?us-ascii?Q?PC9xjACqxk7z4qlchTEgaPlhKP4w5VeqwOzf0S0mVH6HLCAYA2gEpCobcc63?=
 =?us-ascii?Q?3aVr8t3jmvcgH7vJ48Tr3RaD6zhNQH/PeUBjDzv2gJEzsiOaoThE22WJFAdw?=
 =?us-ascii?Q?h4iklAEoL+3suv/wH8rrIWzzHiFF5PBPg98EmdAt/e86WZdb+3+bPGFw7yZv?=
 =?us-ascii?Q?U6qImnxl3tG+ScDAPPThoSULEv0gnWwZV70sBtcp3aR2JX4THuNbl64EjclQ?=
 =?us-ascii?Q?SOuXg/5xwqf4NCKx5HfurGGuY+ESgO6yJiR9Oy4dxYA7aTxqEhEYcMRjrffU?=
 =?us-ascii?Q?pTTyc9+eEN7mK1SBdCF70Vy11QHCZStx1mxOheZyROym4tQO/11rYMCYG6Y+?=
 =?us-ascii?Q?Pf4bvdXytDhnr+xk2thDpmX+kc18KUphMLw/0fcRiWxAAM8eOGCV2COKqb4K?=
 =?us-ascii?Q?bh0Cfp/qg7q0au1eW01U88tU3nnLJ87dBFfx318/0LTjsPyASxeXSIbzAefr?=
 =?us-ascii?Q?AU4M5QLE45aecXlEPxOdeaoQUScU5obNdgs8djXNKw/cTcuCO1n1fZuOcPZg?=
 =?us-ascii?Q?k5bVa44C1pL5D+SVJt2UCOlcWG4ySKa6SZhptATT4VBqOq4X+f66StQWd8YN?=
 =?us-ascii?Q?Q6DRSGELk88VpBgBwDOWcXR1mz4bfOwhW5hbQydBg4kci7gwo2vAoZJZTKh5?=
 =?us-ascii?Q?j2J5uKYZk9luC6UQPjzVe8eunMxnKRV5DogESdiiW2HsEWG1pm94BUriDCsP?=
 =?us-ascii?Q?Vrut0P0QbQoyI/YI/VSu8FPFYHO9kslHhLpM9G1NLpl0yIafCfjh8BE6Q2zl?=
 =?us-ascii?Q?s4Oo2hF2mckSSnN5oy9LLugmjfVHm8XNh0PVxVPzMJdtGG/HdzaD0CxFgCgR?=
 =?us-ascii?Q?XPPhZK5Eyo/WdISXCs5wV7nM50KPzAWb/CxZ2UHmp8jA0jjm4FRgX1z7Ff4t?=
 =?us-ascii?Q?76vVW0E64GPELvsTj2L900skuP8rXQejXohuMJw3kWl0yhZZeRuXd/MFRD86?=
 =?us-ascii?Q?+xPVA0wccuLGprrqx01xY7Ju?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oBbKlTFT5fWmItWjcL8hGQKne5aG9kxe1e4iPvlzPXkik2AbJ5IX/xfrabMj?=
 =?us-ascii?Q?HF2qUb3hlIiupH+e1UjdmqaW57LsoAiAdgSwmEGHY9Tz0IgX4JHZbCjk73Jh?=
 =?us-ascii?Q?c+YEWkafEGF4kWKhpsvqv5vKX7BHyq0YegXpUouA8QV7z82GqWQVFcQE1hAD?=
 =?us-ascii?Q?2b2YvtONGzH3q6QJPkxBzU8mPzR8qxdHI3ad5E3xNBwFBR3VMw1JInxABEXd?=
 =?us-ascii?Q?qXozrD76qCRx7DBiK4Zsp6fSctmTbsAv6B9QVHb19SriwXL5QCZgrsUE5EY8?=
 =?us-ascii?Q?tOODof5UbQb39XRqXw7Qey8ixq/WqdYMZsWyimvG1lXpAejKZOaH2B0xZAoD?=
 =?us-ascii?Q?enFfFjtezrdAdb2tjh4Eo1nxv+SY+/MXbUcjz+Zi/W6ZQhpWUObxce8GJ6ri?=
 =?us-ascii?Q?Pf0XHg/r9fs0WKbFKFXSKVza1cQKlENmpXZpZI4+VAkOsS46PYgPFwq2RPfd?=
 =?us-ascii?Q?U/mOSeS4Uf7O+9/ezDTDolp39ExAyNxf9voX35b07APoaHDFA194gr5YOSZ6?=
 =?us-ascii?Q?oNqeyVu3dORb4yEM9+ET9SLZjDdUSPBqXT+JZrkKwu2FjZVhLtJJi9/24cmt?=
 =?us-ascii?Q?EpmxTY/wd5aa4NAjw4biLBhd15Cw6WqJtHEUb64+SO2pw0oWNwamsA8Has5g?=
 =?us-ascii?Q?h0UG7dXtgcRJoyLQSMnGoJ/RcOHN0cfMKGNxfOKWzcvxgzYdBVnF7l7JgwVq?=
 =?us-ascii?Q?T2VYAQQABnvhZWRJzk5xJ99hFcfQKUpbVzbim5wtZzmStC80sqo6jM7WlPvO?=
 =?us-ascii?Q?T7K+QIARhmcD0q8u1t1152Mr8ajsePXBbIfU1dSQonONF1lhduVFxzq8vanH?=
 =?us-ascii?Q?QaFOFqm0rvWwiZsXFPjH1Y6ITH026eT4EMiuBjt2WErhtBaakq+I2wtbQG56?=
 =?us-ascii?Q?aBbSelOw0uOjdf8u+dROr5Jep9MHGIzQOZiRpTdDSC/Cmu+DpDmp2nrnm1wB?=
 =?us-ascii?Q?O346CylrHYLVtCktDRxGgaWTbi+1loWaF9Ui8rEXhdwYt8VGZJ8oNfFzNeuJ?=
 =?us-ascii?Q?uBDhcVKZNiJXDZXm4bPt3rMRn229E47gNc0cgJR6Umr30D8y/D811QMTiXuH?=
 =?us-ascii?Q?50nvXlAnocKnfetoPOTkHQY+hUqpRNkRpFbNX9QzhZyykSqfk152wdNz6+12?=
 =?us-ascii?Q?PUqLG8lh89EL3euMSQtkMHp1KDZc0+9431A0UyfEskiORpwi14xh1WeFDWJg?=
 =?us-ascii?Q?C9dn1IPUQXDbClV3090TsuhOENvriu0qgU2+05h7FgUhF+GbMlUS7pxqS2ws?=
 =?us-ascii?Q?witVHQfi7MV5T/Jmv2ZyZYWVKvuJmaOc5ART71XOdLWYLyRO8b9HOZz/rf75?=
 =?us-ascii?Q?SUubMjD1tcLk0ER1ggCPZuANzedWmsXgE1wDMncwq5tTkmrYsS7GNBfgRHfR?=
 =?us-ascii?Q?/Wb341yLISFjmKMXPTj4f/BquXuToRZ6eRY7HlauDwyopoYZAzMdnckFhTjK?=
 =?us-ascii?Q?49A25z3J7jOUzEIWf88vTwl1mQVRJsVK/AC/hVquZrl4wSSZDOwxpHyjR0+E?=
 =?us-ascii?Q?o1CslPgk76sO+JUR5O8TajclGnrhb1dIckp1HvwzToGLS4KA8phujktf6F4K?=
 =?us-ascii?Q?xl0hZyjtTLzZCbJHTquUk8Nc5m67qKssJsgdcEZL7U1OxV0ZOhXs3R3WrbeW?=
 =?us-ascii?Q?Sr9Znqw9Os0AGDk07erlwcujODKuA2Anw0nDuKWWIhMp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef929dc5-a555-4cc4-c3f4-08dc944f48fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 13:12:22.7480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4cQpe7zbAFrp3Zc2ZldjLHZbKXXJ//Fig0QJ5xKOGD9J2PTZHDbqwtwb2i99BwfgHTPQguy6Vt8TWzhJUv2MWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10925

Hi Conor,

> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
> >
> > Just "firmware@<hex>" please.
> >

Modified as per your suggestion,=20
-    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
+    pattern: "^[0-9a-z]*-if@<hex>"

encountering the following error:
/home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,imx=
-se.example.dtb: ele-if@0: $nodename:0: 'ele-if@0' does not match '^[0-9a-z=
]*-if@<hex>'
	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
/home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,imx=
-se.example.dtb: v2x-if@3: $nodename:0: 'v2x-if@3' does not match '^[0-9a-z=
]*-if@<hex>'
	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
/home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,imx=
-se.example.dtb: v2x-if@4: $nodename:0: 'v2x-if@4' does not match '^[0-9a-z=
]*-if@<hex>'
	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
/home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,imx=
-se.example.dtb: v2x-if@5: $nodename:0: 'v2x-if@5' does not match '^[0-9a-z=
]*-if@<hex>'
	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#

Please help and guide to resolve this comment, correctly.
Highly appreciated. Thanks.

Regards
Pankaj

> -----Original Message-----
> From: Pankaj Gupta
> Sent: Tuesday, June 18, 2024 4:29 PM
> To: Conor Dooley <conor@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: RE: [EXT] Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-f=
w
> binding doc
>=20
>=20
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Monday, June 17, 2024 10:07 PM
> > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> > Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; linux-doc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-fw
> > binding doc
> >
> > On Mon, Jun 17, 2024 at 12:59:40PM +0530, Pankaj Gupta wrote:
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
> > >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 160
> > +++++++++++++++++++++
> > >  1 file changed, 160 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > new file mode 100644
> > > index 000000000000..60ad1c4a3dfa
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > @@ -0,0 +1,160 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
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
> > > +    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
> >
> > Just "firmware@<hex>" please.
> >
>=20
> Modified as per your suggestion,
> -    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
> +    pattern: "^[0-9a-z]*-if@<hex>"
>=20
> encountering the following error:
> /home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,i
> mx-se.example.dtb: ele-if@0: $nodename:0: 'ele-if@0' does not match '^[0-
> 9a-z]*-if@<hex>'
> 	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-
> se.yaml#
> /home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,i
> mx-se.example.dtb: v2x-if@3: $nodename:0: 'v2x-if@3' does not match '^[0-
> 9a-z]*-if@<hex>'
> 	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-
> se.yaml#
> /home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,i
> mx-se.example.dtb: v2x-if@4: $nodename:0: 'v2x-if@4' does not match '^[0-
> 9a-z]*-if@<hex>'
> 	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-
> se.yaml#
> /home/yuktilab/linux_bkp/Documentation/devicetree/bindings/firmware/fsl,i
> mx-se.example.dtb: v2x-if@5: $nodename:0: 'v2x-if@5' does not match '^[0-
> 9a-z]*-if@<hex>'
> 	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-
> se.yaml#
>=20
> Please help and guide to resolve this comment, correctly.
> Highly appreciated. Thanks.
>=20
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
> > > +
> > > +  mboxes:
> > > +    description: contain a list of phandles to mailboxes.
> > > +    items:
> > > +      - description: Specify the mailbox used to send message to se
> firmware
> > > +      - description: Specify the mailbox used to receive message
> > > + from se firmware
> > > +
> > > +  mbox-names:
> > > +    items:
> > > +      - const: tx
> > > +      - const: rx
> > > +      - const: txdb
> > > +      - const: rxdb
> > > +    minItems: 2
> > > +
> > > +  memory-region:
> > > +    description: contains a list of phandles to reserved external me=
mory.
> > > +    items:
> > > +      - description: It is used by secure-enclave firmware. It is an=
 optional
> > > +          property based on compatible and identifier to
> > > + communication
> > interface.
> > > +          (see bindings/reserved-memory/reserved-memory.txt)
> > > +
> > > +  sram:
> > > +    description: contains a list of phandles to sram.
> >
> > There's only 1 phandle allowed, don't describe it as a list.
> > Same for memory-region.
>=20
> Accepted. Will do the following changes.
>    memory-region:
> -    description: contains a list of phandles to reserved external memory=
.
> +    description: contains the phandle to reserved external memory.
>=20
>    sram:
> -    description: contains a list of phandles to sram.
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: contains the phandle to sram.
>      items:
> >
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    items:
> > > +      - description: Phandle to the device SRAM. It is an optional p=
roperty
> > > +          based on compatible and identifier to communication interf=
ace.
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
> >
> > > +    else:
> > > +      not:
> > > +        required:
> > > +          - memory-region
> >
> > Use
> >
> > else: properties: memory-region: false
> >
> > Same for sram.
> Accepted will be corrected in V4.
> # memory-region
> -      not:
> -        required:
> -          - memory-region
> +      properties:
> +        memory-region: false
>=20
>    # sram
>      else:
> -      not:
> -        required:
> -          - sram
> +      properties:
> +        sram: false
>=20
>=20
> > Sort the allOf after required.
> Accepted. Will move allOf after "additionalProperties:"
>=20
> >
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
> > > +    else:
> > > +      not:
> > > +        required:
> > > +          - sram
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - mboxes
> > > +  - mbox-names
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    firmware {
> >
> > You've made up these firmware "buses" here, what purpose do they
> > serve, other than allowing you to have a reg property?
> True.
> Additionally, these are firmware nodes, these nodes are semantically put =
in
> firmware "buses".
>=20
> >
> > > +      #address-cells =3D <1>;
> > > +      #size-cells =3D <0>;
> > > +      ele-if@0 {
> > > +        compatible =3D "fsl,imx8ulp-se";
> > > +        reg =3D <0x0>;
> >
> > What does the reg property even do? Is it ever more than 0?
> > Can this information be provided as a mbox cell?
> Yes, there are more than 0 nodes for i.MX95 platforms, i.e., total of aro=
und 7
> such nodes.
> Reg property will help to identify the node id, by other kernel managemen=
t
> layer like NVMEM (patches to follow).
>=20
> >
> > > +        mboxes =3D <&s4muap 0 0>, <&s4muap 1 0>;
> > > +        mbox-names =3D "tx", "rx";
> > > +        sram =3D <&sram0>;
> > > +        memory-region =3D <&ele_reserved>;
> > > +      };
> > > +    };
> > > +  - |
> > > +    firmware {
> >
> > These examples are all basically the same, drop all but one.
> Ok, will keep the example of i.MX95.
>=20
> >
> > Thanks,
> > Conor.
> >
> > > +      #address-cells =3D <1>;
> > > +      #size-cells =3D <0>;
> > > +      ele-if@0 {
> > > +        compatible =3D "fsl,imx93-se";
> > > +        reg =3D <0x0>;
> > > +        mboxes =3D <&s4muap 0 0>, <&s4muap 1 0>;
> > > +        mbox-names =3D "tx", "rx";
> > > +        memory-region =3D <&ele_reserved>;
> > > +      };
> > > +    };
> > > +  - |
> > > +    firmware {
> > > +      #address-cells =3D <1>;
> > > +      #size-cells =3D <0>;
> > > +      ele-if@0 {
> > > +        compatible =3D "fsl,imx95-se";
> > > +        reg =3D <0x0>;
> > > +        mboxes =3D <&ele_mu0 0 0>, <&ele_mu0 1 0>;
> > > +        mbox-names =3D "tx", "rx";
> > > +      };
> > > +      v2x-if@3 {
> > > +        compatible =3D "fsl,imx95-se";
> > > +        reg =3D <0x3>;
> > > +        mboxes =3D <&v2x_mu 0 0>, <&v2x_mu 1 0>;
> > > +        mbox-names =3D "tx", "rx";
> > > +      };
> > > +      v2x-if@4 {
> > > +        compatible =3D "fsl,imx95-se";
> > > +        reg =3D <0x4>;
> > > +        mboxes =3D <&v2x_mu6 0 0>, <&v2x_mu6 1 0>;
> > > +        mbox-names =3D "tx", "rx";
> > > +      };
> > > +      v2x-if@5 {
> > > +        compatible =3D "fsl,imx95-se";
> > > +        reg =3D <0x5>;
> > > +        mboxes =3D <&v2x_mu7 0 0>, <&v2x_mu7 1 0>;
> > > +        mbox-names =3D "tx", "rx";
> > > +      };
> > > +    };
> > > +...
> > >
> > > --
> > > 2.34.1
> > >

