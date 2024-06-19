Return-Path: <linux-kernel+bounces-220624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACE090E485
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3A81F21FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC4E763FC;
	Wed, 19 Jun 2024 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UKUgD2LR"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA9558BC;
	Wed, 19 Jun 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782258; cv=fail; b=tqqZbgLPI6QG6auPxUw9xqC4aUoqBPs1ijpF9kbRYoEhanFTDVvOO+KhNLNdHqjQ0gi1O+6mp+PcQAl9dR3uMjSOoHnLCjwSBEpXsANESxPa7IIdJQeNLwFtWCFIhtOSiPZX2JJeukCjOy/JMTbWzn5w6QfQ0PoGEDLGvRu4iCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782258; c=relaxed/simple;
	bh=fj+or6Y4zigCnXNFXVQjxsHWP6ZpsRrnhkVb+uuhr4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aUTs6ttPiD+k3pHZbEUQ3Svs1KZTahYgl3ec28wU7mKIHJbjoSlNLkHBewL1vMyItreewXWYGHwMueU7WXPpFxvRYl7AJXpcwkBGBz4maLhyGQKw46ZDHHpy0LCcQQmsnfTb4X/g2Qk+0dRBhx5WuG8ojeEDRaGyC4nnQH9BVQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UKUgD2LR; arc=fail smtp.client-ip=40.107.7.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVS/VKpSbNEnngYPzUWVcev6zmiaE16uUtWNDGUXxoSMTqnrJEDsW5drFr3LhwFFTAq+8NfvGO1M0DJ4IcdBskrlVM/FoDJ0ORfZ1W35jUIPFKTc/owLapP0ZiGQFvXd2PZ3xTRIwiyv7R5AvqhSdo0jckCx3093pat5ksRMeK2xudpoXtVpWZXqUVtWqQamuaa94lZ1NRM3l8pRtPyJnVSZz4VINDmtW6nRppzisax4O2nz2XN7UoHZQpY7FMQPGupgu421zj18HoztMX1GQC2ysxrw9EZGjgQyx5EfmEl8JcuW1PGO9KXpPDznpGMyAqUYtmFbo7cx/oaxDgIhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vB9axU7bBMtYGUlxrILIwSVC9wgoz39Sh2Z4YDW9Zg=;
 b=nxdc+TU9carBndTQ2iFnDFBUHPVu6XhjvJYJuz2+2AmsYaep+T7RJp7nGTbGAn7fEA7enFISW9uGWbcfeO14HAaAT8oINamrFmyJn3ZXDRxsru6TE6P4sFesRF2kado3DJWCJQWNi1bDz+6gMOZa3by5UtxxGosCf5NyJSONvzVTQ53MFmkRChvBul5yvo46C5vIxInVhyXAzFXDnqnQp+zTasRNiTzcyb9nIsIizon5ox7woph5HZDzOxFBBf3CtWW5HZ3iJOlZ17uZGrfOoE62Vi4CBTFA7UYZ0UJMmSzZlBUNE4+hhMRIlJbpPggY5g/mLYFg4DB5Z4+scQ8tmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vB9axU7bBMtYGUlxrILIwSVC9wgoz39Sh2Z4YDW9Zg=;
 b=UKUgD2LRA27/K9yFjG5wnCTLyCtx2vJyyG/TR2YmgkQzAjSp8mtmIOZvgMjbsYSVGKJWsCNPLX3vti4poxl17+0Uig2sGrPvpnOlu9YHzI9ydSGgNO6ybA1Bzpu7k99o1NbRBL36b1OgLPXIQW4jIa8TFXACB5Rlx5dYGsMo7As=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM0PR04MB7121.eurprd04.prod.outlook.com (2603:10a6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 07:30:52 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 07:30:52 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v3 1/5] Documentation/firmware: add imx/se to
 other_interfaces
Thread-Topic: [EXT] Re: [PATCH v3 1/5] Documentation/firmware: add imx/se to
 other_interfaces
Thread-Index: AQHawIiQSYtsITSno0mKmnaypEJjdrHOB5eAgACIGmA=
Date: Wed, 19 Jun 2024 07:30:52 +0000
Message-ID:
 <AM9PR04MB86044E7488C90A97EB4BC3A895CF2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-1-a7d28dea5c4a@nxp.com>
 <c786ad0d-2a25-4066-b0df-04decc037c16@infradead.org>
In-Reply-To: <c786ad0d-2a25-4066-b0df-04decc037c16@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AM0PR04MB7121:EE_
x-ms-office365-filtering-correlation-id: e60dff5f-58a0-4b84-4ccc-08dc9031bfcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|1800799021|376011|7416011|921017|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qY0jR2pZ9ju5h0srkEku8dbMsAxgywbeRq9A0h7pGkay95LIe8DV9sgAc+0z?=
 =?us-ascii?Q?1waMDeVtEhHO3ftrB0yv5jCZI/GLyn0dRp6kV+KSvpzZbf+0nlBrdEYWjBJg?=
 =?us-ascii?Q?XKxhpnIllVfnONOOkUceaAVDRoyM1/d11Hr+CR1nDS0q3ag9NnHvGlMRlIjy?=
 =?us-ascii?Q?te9nX56cupVQG3PfAJHQrcZlePnFABM5YhyQlGflS5cuiP3way9NBRwP7P/O?=
 =?us-ascii?Q?sRIrX2Uoj486wjROCPvwt0WJ15YuBXncyukyCFye7IJn+gBKgFl6KcOSmgrY?=
 =?us-ascii?Q?URLHczzKqB0yPu8MpKBwhEuFiqmjf0vrzX9dmIf87lQiFk2a2PTR+bPJYX2b?=
 =?us-ascii?Q?/AOIBU5LDDENNPV3i8aV4gN5Xvc11xQeEX0MhEMj6EhiA9+WIha5XSVlUvsN?=
 =?us-ascii?Q?35M5BGNDy4C/Pns2Fcml4km53f55UAr+qbdLGWcmXnqVCcG5aFuZE8B9Q+Sd?=
 =?us-ascii?Q?w6/g+Js1+VhPMyNdQbtdNISFFcK/dTrzxF2m8j8yrTSXidg1S7eavmKT9h6x?=
 =?us-ascii?Q?BNCAt3lHWF5N3qUW1MlLd5vN2wdQUh2WPpNS1pP89tt9j/Y9bAHWgJJW1lOK?=
 =?us-ascii?Q?1ZgTs4WyJuw9gF1CI/NS11E1DG1kLGQx7tS3Q4KmkhVczXxrUI3mPV2cQeDr?=
 =?us-ascii?Q?HXzFwpULTDZL2Goi1hMZkqvNRm3hqWFbFbbLqzgmyXdWOnu5PkvqvQa4aoWF?=
 =?us-ascii?Q?sc6B6yVF8ExkzEQtkhFymrINLK1lWAotWAxRY1+PWEtxXJgXMkCjaPTayLw5?=
 =?us-ascii?Q?krNkcVd0dwSzFSKvwA1PiY36FKmgi6p2rDZn1WSG7ozZyymYp5PcYwrwHbWz?=
 =?us-ascii?Q?FHUYpA4ZEPU0Pf3sInn7INQdbruH3hrPDu/H5Oc/jndKZ0M12cZgQa+EMAd6?=
 =?us-ascii?Q?Gsn6bbvAoG2/+c13p4AP2d8jB6X6oFNO0UDfEUOe1ZQAPb9QRV/4iajD0g0u?=
 =?us-ascii?Q?qFbv6QTDgVtmHjdfxmGFj5FvDzuXyk7W1K3cGuhWOyifo82zrgUO3URonJUC?=
 =?us-ascii?Q?szTOPk348XviyyiQ23GZob9144n1YLZFirXMG8hU+Y5poYn1MkGSBDkWvKnc?=
 =?us-ascii?Q?XGbv45aK6UIf7ICYIn2uj7Gkck6ZCOPVW5yYg4fDPwu7KRhFwWqXM24FMLz6?=
 =?us-ascii?Q?ftBzQAIAQFPivPWGN/JQqVNgfHDAnqHb9jF77F/EKZWBKCaLv4dnZJyom6Xw?=
 =?us-ascii?Q?MeyJsJUM7SYd0I3Iq1+D/Tn8/Rm43ZSkdZ7H0KPfjCXpLH6VaFpeq5e5ZQ3I?=
 =?us-ascii?Q?yj9sdF2KfvETe7LYlODX+1lAOeMf4f/fRmra3FP/OU2S5pB7e18AAHEjxNoI?=
 =?us-ascii?Q?/N4X69vERv4dN7CV4zS+ktiS9+c5MUVroKafggPEz2BXBg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(7416011)(921017)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0Ca5+XueszPHWg4AX1SblBEmevIIqmtO95cril0/VHSMjUqyvan7VNyDmY5y?=
 =?us-ascii?Q?nydq4TZRkbWibYflK/fsgzZSUvI7I+RupMgMK0n1lU/s02mQ2nn7j/MF3CTZ?=
 =?us-ascii?Q?9dAeeTwis2EFINXip4rnF0gOXxRfs6VvT8RFQ22O3FskyfyzvQ2CAWK+UVvN?=
 =?us-ascii?Q?sUJBOR8rb+W61n1IjALrapxoLCpS4N1DjwHdnGpbafRSi87ufwZv6xOzg4uB?=
 =?us-ascii?Q?u+Z2SUzzPDojoq+9BqaB+49uT7CBTG70ssBxktjihZe5chiaiwOZjszbV2Rp?=
 =?us-ascii?Q?rF0HJKpLqeQZVe4hfzFQtf772X0h9AJHfINJNpP78p55EX2qarTP7YezzsnJ?=
 =?us-ascii?Q?KFRkKF+9u3oMB3MarBki5z43g4ougn0GAFhTkKMjmQDx0zu6huYUP9d+ptC4?=
 =?us-ascii?Q?2yDk9s6vBBzBWAGynr+9L9dCmRfDUNBfI9Vsek/88LaPvBQwVCynjon2ITDU?=
 =?us-ascii?Q?HYwCD9NhHUpG4urYL/vTqnX8fobtAOlEjFke3bwGh+W1c9Le9c1chXNLZg97?=
 =?us-ascii?Q?eYaXeCaAiQM5RHwlkoLO3W6g6DqD1EQVnQwsXl7HK35Xq+U8zbTugOUnpGbX?=
 =?us-ascii?Q?0PRjNJU/L9v08dsj37e68YhfHRakVQX7lB6QCWnBpoT940Bvr3WD0EoRiYJU?=
 =?us-ascii?Q?Qx15SWB1lSe+jmKM6I8j2P9Uk6cop9iXLdgppQWUVwr/kLAFqAoNYBwNjllj?=
 =?us-ascii?Q?6UfDr3+p7kSXolhcjQtH6ijAM2qdJTWeW+Sc2Qajd7NYHGxfR9rxdVvXYRuG?=
 =?us-ascii?Q?h7NA812IK/4m2ojKs6xuc/hq404lc3X2/72fJ0DFBt6TpJUMLibqnugFgUeg?=
 =?us-ascii?Q?fT2lVhfuQqhTGNwHaJQ8UUlXoQgB0f8wxJ1LfjBueps5QsfuMa8Ir4EGaltj?=
 =?us-ascii?Q?u1TdeWRMY2LtK7Z0k3XDFEwm0tKsJf10yFZPIdYfF+u4FV+zRo1aROgtZfdO?=
 =?us-ascii?Q?1+7TOi9BCZm1h1gBKeM541ASmOVL7X/kbM8XuS7Zr3qBHW6UDtADhq5QEI8v?=
 =?us-ascii?Q?d4bvxFYHXnAIygCy/pzJULKy7+CdezYkl8kMV6M1WwGioNdwaV3OjHnOXRSA?=
 =?us-ascii?Q?j88OkZLQZtl68rZQ/hAI2PPSGIziBC8rQB4hvsM0hrypmy2XnWpmOcDfSDzO?=
 =?us-ascii?Q?E8FAgGobIoD5TnVCN5j6HAWmON42j39CwHPfrJjaxxl7a8NOZ95zjruYKoXg?=
 =?us-ascii?Q?nnAGbhm0vu7fhDG6GSRyIDZvboe5SjS0Y+NJtrU3jb/NCKkpLnfqiOK0j6s8?=
 =?us-ascii?Q?uTDpDwwywZZDajQxW2M0Q/uwONWNK3e6x+nGeGmvFipAz7suxf1cKlp2ABG8?=
 =?us-ascii?Q?I03JrcaPRIqL0XOPmtshTw6sJk87FKGbuv9vg5rZmv0ILnaiy7ZECsVOhDQP?=
 =?us-ascii?Q?pmXRGao8qjF36HNHSSoVeJq2wCbh6j52PJbWNWrXiA6jZhFNd7jLDE8sOeVR?=
 =?us-ascii?Q?VT4s7b+h1mpjQLh9AnYoO4LXHKj1f43UHe9GoMGZHgcI2Pi2+WtG0PadcbFJ?=
 =?us-ascii?Q?Lxo6EjLtrn6inGINTYDEK0qWv16Dzuc6ZuW4/7lUXb/qAJVfy+Jkqroj/JF3?=
 =?us-ascii?Q?Zp/PdA9LRoi3UQeYE8cc6oBkVrVaLOTDoiJ++heP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e60dff5f-58a0-4b84-4ccc-08dc9031bfcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 07:30:52.4764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbGm6ex1nTF/Z0t+/Bc6gpchGs3Pl5N6QTq+U18jLAHPk9upCM3lsNuWxwgobfFUXtvAjBqpd5jElkCgl5OTiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7121



> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Wednesday, June 19, 2024 2:43 AM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>; Jonathan Corbet
> <corbet@lwn.net>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v3 1/5] Documentation/firmware: add imx/se to
> other_interfaces
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> Hi--
>
> IMO there is an overuse of hyphens (dashes) here.
> Please consider the changes below.
>
>
> On 6/17/24 12:29 AM, Pankaj Gupta wrote:
> > Documents i.MX SoC's Service layer and C_DEV driver for selected
> > SoC(s) that contains the NXP hardware IP(s) for secure-enclaves(se) lik=
e:
>
> Is the product referred to as "secure-enclaves"?  If not, "secure enclave=
s"
> should be sufficient.

Accepted. Will change the commit message to secure enclaves.
>
> Hm,
> https://www.nx/
> p.com%2Fproducts%2Fnxp-product-information%2Fnxp-product-
> programs%2Fedgelock-secure-enclave%3AEDGELOCK-SECURE-
> ENCLAVE&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7Cd2c1bbc9dac94194
> 038208dc8fdb78f1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> 8543420025533954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D
> KvsDrZLWefqpJ2%2FjMvOydr6T0xnZWhv0QhFz1cHa4kc%3D&reserved=3D0
> just says "Secure Enclave".
>
>
>
> > - NXP EdgeLock Enclave on i.MX93 & i.MX8ULP
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  .../driver-api/firmware/other_interfaces.rst       | 119
> +++++++++++++++++++++
> >  1 file changed, 119 insertions(+)
> >
> > diff --git a/Documentation/driver-api/firmware/other_interfaces.rst
> > b/Documentation/driver-api/firmware/other_interfaces.rst
> > index 06ac89adaafb..65e69396e22a 100644
> > --- a/Documentation/driver-api/firmware/other_interfaces.rst
> > +++ b/Documentation/driver-api/firmware/other_interfaces.rst
> > @@ -49,3 +49,122 @@ of the requests on to a secure monitor (EL3).
> >
> >  .. kernel-doc:: drivers/firmware/stratix10-svc.c
> >     :export:
> > +
> > +NXP Secure Enclave Firmware Interface
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Introduction
> > +------------
> > +The NXP's i.MX HW IP like EdgeLock-Enclave, V2X etc., creates an
> > +embedded secure
>
>                              Edgelock Enclave
Accepted.
>
> > +enclave within the SoC boundary to enable features like
> > + - Hardware Security Module (HSM)
> > + - Security Hardware Extension (SHE)
> > + - Vehicular to Anything (V2X)
> > +
> > +Each of the above feature, is enabled through dedicated NXP H/W IP on =
the
> SoC.
>
>                      features is enabled
Accepted.
>
> > +On a single SoC, multiple hardware IP (or can say more than one
> > +secure enclave)
>
>                                          (or more than one secure enclave=
)
>
> > +can exists.
>
>    can exist.
>
Accepted.
> > +
> > +NXP SoCs enabled with the such secure enclaves(SEs) IPs are:
>
>                     with such
>
> > +i.MX93, i.MX8ULP
> > +
> > +To communicate with one or more co-existing SE(s) on SoC, there
> > +is/are dedicated
>
> hm, "co-existing" is a (UK) alternative for "coexisting" and since we acc=
ept
> British spellings, it is OK.
>
> > +messaging units(MU) per SE. Each co-existing 'se' can have one or
> > +multiple exclusive
>
>                                   why not       'SE'
> ?
Accepted.

>
> > +MU(s), dedicated to itself. None of the MU is shared between two SEs.
>
>                                            MUs or
>                                            MU(s)
>
MUs, dedicated to itself.

> > +Communication of the MU is realized using the Linux mailbox driver.
> > +
> > +NXP Secure Enclave(SE) Interface
> > +--------------------------------
> > +All those SE interfaces 'se-if' that is/are dedicated to a particular
> > +SE, will be
>
>                                                                no comma  =
  ^
>
Accepted.

> > +enumerated and provisioned under the very single 'SE' node.
> > +
> > +Each 'se-if', comprise of twp layers:
>
>       no comma ^             two
Accepted.

>
> > +- (C_DEV Layer) User-Space software-access interface.
> > +- (Service Layer) OS-level software-access interface.
> > +
> > +   +--------------------------------------------+
> > +   |            Character Device(C_DEV)         |
> > +   |                                            |
> > +   |   +---------+ +---------+     +---------+  |
> > +   |   | misc #1 | | misc #2 | ... | misc #n |  |
> > +   |   |  dev    | |  dev    |     | dev     |  |
> > +   |   +---------+ +---------+     +---------+  |
> > +   |        +-------------------------+         |
> > +   |        | Misc. Dev Synchr. Logic |         |
> > +   |        +-------------------------+         |
> > +   |                                            |
> > +   +--------------------------------------------+
> > +
> > +   +--------------------------------------------+
> > +   |               Service Layer                |
> > +   |                                            |
> > +   |      +-----------------------------+       |
> > +   |      | Message Serialization Logic |       |
> > +   |      +-----------------------------+       |
> > +   |          +---------------+                 |
> > +   |          |  imx-mailbox  |                 |
> > +   |          |   mailbox.c   |                 |
> > +   |          +---------------+                 |
> > +   |                                            |
> > +   +--------------------------------------------+
> > +
> > +- service layer:
> > +  This layer is responsible for ensuring the communication protocol,
> > +that is defined
>
>                                                            no comma   ^
>
Accepted.

> > +  for communication with firmware.
> > +
> > +  FW Communication protocol ensures two things:
> > +  - Serializing the messages to be sent over an MU.
> > +
> > +  - FW can handle one command-message at a time.
>
>                          command message
>
Accepted.

> > +
> > +- c_dev:
> > +  This layer offers character device contexts, created as '/dev/<se>_m=
ux_chx'.
> > +  Using these multiple device contexts, that are getting multiplexed
> > +over a single MU,
>
>                             no comma     ^ that are multiplexed over
>
Accepted.
>
> > +  user-space application(s) can call fops like write/read to send the
> > + command-message,
>
>                                                                          =
command message,
Accepted.
>
> I prefer 'userspace' or 'user space' over 'user-space'.  'user-space' is =
the 3rd
> most used of the 3 spellings in the kernel source tree.
>
Accepted. Used userspace

> > +  and read back the command-response-message to/from Firmware.
>
>                        command response message
>
Accepted.

> > +  fops like read & write uses the above defined service layer API(s)
> > + to communicate with
>
>                             use
>
> > +  Firmware.
> > +
> > +  Misc-device(/dev/<se>_mux_chn) synchronization protocol:
> > +
> > +                                Non-Secure               +   Secure
> > +                                                         |
> > +                                                         |
> > +                  +---------+      +-------------+       |
> > +                  | se_fw.c +<---->+imx-mailbox.c|       |
> > +                  |         |      |  mailbox.c  +<-->+------+    +---=
---+
> > +                  +---+-----+      +-------------+    | MU X +<-->+ EL=
E |
> > +                      |                               +------+    +---=
---+
> > +                      +----------------+                 |
> > +                      |                |                 |
> > +                      v                v                 |
> > +                  logical           logical              |
> > +                  receiver          waiter               |
> > +                     +                 +                 |
> > +                     |                 |                 |
> > +                     |                 |                 |
> > +                     |            +----+------+          |
> > +                     |            |           |          |
> > +                     |            |           |          |
> > +              device_ctx     device_ctx     device_ctx   |
> > +                                                         |
> > +                User 0        User 1       User Y        |
> > +                +------+      +------+     +------+      |
> > +                |misc.c|      |misc.c|     |misc.c|      |
> > + kernel space   +------+      +------+     +------+      |
> > +                                                         |
> > + +------------------------------------------------------ |
> > +                    |             |           |          |
> > + userspace     /dev/ele_muXch0    |           |          |
> > +                          /dev/ele_muXch1     |          |
> > +                                        /dev/ele_muXchY  |
> > +                                                         |
> > +
> > +When a user sends a command to the firmware, it registers its
> > +device_ctx as waiter of a response from firmware.
> > +
> > +Enclave's Firmware owns the storage management, over linux filesystem.
>
>                                                         Linux
Accepted.
>
> > +For this c_dev provisions a dedicated slave device called "receiver".
> > +
> > +.. kernel-doc:: drivers/firmware/imx/se_fw.c
> > +   :export:
> >
>
> --
> ~Randy

