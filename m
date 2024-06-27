Return-Path: <linux-kernel+bounces-233128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E018F91B29B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 394A9B22611
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB1A1A2C3C;
	Thu, 27 Jun 2024 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="igTJlcZ/"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1BC19A2AE;
	Thu, 27 Jun 2024 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530275; cv=fail; b=npPxpBX/HVudwEjOYKn9yUPSHlFO7mdche35Yn0TlQp9WwPlmj4k2n8+VRazPpVxlLr0Bpv/LpQo2+MH1Wnklbyxks2+cOs9yZqM8CXndJAR+FzlXZt0kq7Lgj3ZQ4ABZZUk4XDVutPyruS85f6FK+3oQM2Soll3imWv4E22VGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530275; c=relaxed/simple;
	bh=CFKhxKSgUPkRWDtt5WRHu5ORRIPhfc71Dcyn5xV2oeg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sTOhNBaZSLDYChzVnemzMORrhG3sWGkPRCbM5bk9UA63LS9uqP1FIOQbS7aokRE00s0f/3eefN2VfG+/5nTTDZQFWe3yCND1M+wJ0HqTq0ISy/EAatYhlQabnUjK/RbY1S9LeN+HIwR7NQr1Wk3zKrilWquVWFTc/SsyUckegoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=igTJlcZ/; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6KRJMXFQDtjA9KYUzz1mH4PrXZgKm/wLeiI33XzU3i1WJG45HxgvZ6OZjoSM0iPs1KyfaQhGKSuzxZzC3lM+B/rjmvvxXmyVJtLmCFxGPkPiUPNA+XJ1VPwjqTgyvynpQgyADXvRoMK16ytb4CKPI44OQA+Gy6A8vEtPCFbt+nwZ9IioZsTu575zffi0V6WovZ3G0xZiAHOc4XZAa6lDYpeb17zZT9IGfDJQbrgtzBYZmI1liZ+x9R4N8wX43qjlap3piTaFl6gT59TMZmkyJ900EcAqMx9+avu9HFqMN/op/5z4LGjCjcEauzln0f6vq24FLXo2N8rq36zQxHKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7E4EwxO9+2VHzWwtpeZBOgb30mpRyJVuZ9X/u04QC14=;
 b=GJHCxEFKvZISAM4e3UrDPtTyi+6OROGV48+I4ie1pQ5F6vsHNWGDKlZ1/7FOXIZ4puJ4tIvypkS7/HNcxbE06j1oPLukmHQY6+x+TfHf6tBOSS9JK8QPEs8hLjEc5cJRp3HhGVZ4+lW0pSiuNzFeK4aEdb+P3jhj+xUMyNfC2sJSwCmL+Da9RlNZlmVyxpHmA/PEm0SxxhjvBnRtp5sRsaOkiPXiSqN9CMKwicSGGv09Y8Ji5SIiaS4JrsGWcq7HILeysJFG1XqD/1eGPHAKEP2irlS3fNpEjVPx11D04C78mAfCbAPtlAbILIIrkrM91uqvTJqj6uYeoGBelFDZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E4EwxO9+2VHzWwtpeZBOgb30mpRyJVuZ9X/u04QC14=;
 b=igTJlcZ/WFITPjzbETmPTCrJEbzzvgv8Ree5h3ljeHVdw2dJjk0Bn3+xFhUNFDDI+Qgrn+X4BLulc5UfKuoK18j9VToDzWmJkuI9hB+9Ff5guBTM62oJ24rH7t0wPkgWtrwdao+dMLwQlqmH/Njnlh8kvyKUstiwAfPVmUCtQqY=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI0PR04MB10300.eurprd04.prod.outlook.com (2603:10a6:800:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 23:17:50 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 23:17:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: firmware: arm,scmi: introduce property
 mbox-rx-timeout-ms
Thread-Topic: [PATCH 1/2] dt-bindings: firmware: arm,scmi: introduce property
 mbox-rx-timeout-ms
Thread-Index: AQHaw9fWVQ0S04HfBU6k/eA0824dGrHcL1KAgAAZJZA=
Date: Thu, 27 Jun 2024 23:17:49 +0000
Message-ID:
 <AM6PR04MB59415F7793F4D15CCCB7388B88D72@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240621-scmi-mailbox-v1-v1-0-8ed450735f46@nxp.com>
 <20240621-scmi-mailbox-v1-v1-1-8ed450735f46@nxp.com>
 <20240627214645.GA614300-robh@kernel.org>
In-Reply-To: <20240627214645.GA614300-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|VI0PR04MB10300:EE_
x-ms-office365-filtering-correlation-id: 6f6dd8bd-dfcd-47aa-701c-08dc96ff5cbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FVpXs4lJx/f1fGwWSNqZt6v0mHyQuY473Qlu2b3HL35kixbidlFfSTMU8xdn?=
 =?us-ascii?Q?0Gn2oZveb8eIeYxJsX1+4iyBD2uSFGCMIHzQKjxc2w6B5QtB/0vWWlWEH90U?=
 =?us-ascii?Q?e6OtHE2dxh8wb+YQDk3caFd9wdODlnca/8LAjcnNIJetis79gIl6CmF638m0?=
 =?us-ascii?Q?xO8XqWD5IaxL4Izhauc3TgDA4lyAnAwCeBdlpKYhtRL7Yrj52R/FGs/KteHk?=
 =?us-ascii?Q?oaB6V8WYR0Qb/V8GI3gV7wxRNGZO4g6W2w3HVq4j3QVGgn+M6+uHQ+jqN7qD?=
 =?us-ascii?Q?eaDO1jWTgS7BF/VCHfAsD47gUPJlGzVTpZa2wKG0MsFFksxrYNm0N3V5Yu/Y?=
 =?us-ascii?Q?+MCmSfqGgDYDOPc0hgbQeg8pVViKQg4p6RPMHTWk3V7JfDWILLvaLAzDLXOR?=
 =?us-ascii?Q?WgPvNTF0CPM+K0xDFqgLTJps66Y5FNnBhz8SxBau0BaWCQNtRHP6RAiraHkS?=
 =?us-ascii?Q?iM9FR2Pu+VEcCsVTCvrXuxyKphXJNMv1NmCFfVPx8lre9JhI3XzAZtnvu6lK?=
 =?us-ascii?Q?I1wqonv/2E/cz2naB6BOZRz3c+Tnxh+WOukxuGbr2gDEF9UxbywzQr5W0fE1?=
 =?us-ascii?Q?zI2etgoyFeURul9T2BqEJ5EXrf02ZFMxeu854rBU9f4+tGfBtYOffg8JUqhc?=
 =?us-ascii?Q?4ux6g+SAHWZEfGHttmdrvFBVWizR+WEoBd6r91S/pyLdIy9MG0W1EqhcbWCs?=
 =?us-ascii?Q?Vz53o6wwX8VNAKTHllzSPmmwFWm9T+u1Fvoj6TuZX9IROnafSniGvwAEQxTz?=
 =?us-ascii?Q?lBAZumjxxGq4FYdr53EC6fUsLDScVyygkt1bpycj2wCRSpwtlWtJ/LnACo3r?=
 =?us-ascii?Q?0H/hutY3xXtPQls06kPme2W0JBG68ha/AAFnJ9ilUwkm40d9z3DpiAr1MOBo?=
 =?us-ascii?Q?f2Hc0xjTipJOUG/B2CcSH0lZXKQJvChWIggt4q9nZHe1/LvjstfMF/pbuI4w?=
 =?us-ascii?Q?J9j98FJRRBoFqbeUp5yDEnCjsX+Lm9MQV5uaI7w7VJI10y/PD6D6X2GU6XV5?=
 =?us-ascii?Q?35tcUe6n6gUN0s9/qOHmCCciKGNB+HpPjYa51eZANi3BZntzGkeHB8G8Df6g?=
 =?us-ascii?Q?Uc49V4SXeqx0m4oVbBHEetmx+qJxca1nnISV9yaRenZ3jEtOCDdAMebPmsRM?=
 =?us-ascii?Q?gaO2CMaxSclfWlo2CNRSAp+mzizj7hEUgPuQ4EVAwa8eF5ZnNq7CAERW5F9s?=
 =?us-ascii?Q?ZsLmTh80PXl4qSohsooE2jo2xQBZgRYi6APT9YX9duCka5V/uGkJTvNxAeQi?=
 =?us-ascii?Q?rtO3NbuApJjgG7Db40nN9M7XRgdZqi/2geNDbH2tNRFOcOqv1yqmJrpNkXN7?=
 =?us-ascii?Q?EWtsOxjF4S1P4/cUlUg2xfXNT5suAAFRkFpqgJwtRBIRBvd2pwe9SLCthjiC?=
 =?us-ascii?Q?soo6pIi8OjlNuxf+edHt21m5GoO8+CmuBHD3EO+zkMltXocwNg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XHqeZc2anN0/mNqtCN+ZcRTG3m1pBGiL2QN6AeVbPmZmiSqAkWkXc2lGt/xZ?=
 =?us-ascii?Q?HyrLz3vRnyVWb4jhY5W5/tAUv//Dofqd4ZXGTp70igy1yGvW3Jgm9ttScfaT?=
 =?us-ascii?Q?FF6UrNmTb8ZGiUrK1zqneHoc7suUzcSu10p7zEjQEGr/D++rv2UOie62Pl5v?=
 =?us-ascii?Q?MDLKuRHhkGtRnGQCgDpbxUOB4/UleBZj0AveTtWx12kz2mCARSCQ1vvVQ8Lv?=
 =?us-ascii?Q?I9zkXfBlWGK8OjkD0nMU9qnFEhqYVQV2dL96CTlAoMPXs29NAf3Pv5/6Z/ij?=
 =?us-ascii?Q?F2kSB69Mx97yLWKDTfDv0TZpkeHfYYqPPTpcb8UF2kB0ydaMpot/fJRDzX/S?=
 =?us-ascii?Q?XDsSk9EZWJCNKiF6sF8luan7giyZOiyZkf8yWRQQap9jmEnLtpMN99GxH3It?=
 =?us-ascii?Q?s/5jPCy/dvi6lPvZqxpnz3n/OW3d9DtGZwOo/qGWkl0l8xALBNJVLDdpTRJW?=
 =?us-ascii?Q?6lWmoPyRwOt/rbpPtgZG+mV3Y+uIoTbmeHt1fYR6+fWsEfcU9/S20diHBFDP?=
 =?us-ascii?Q?G4dDFoSGp+Q9d5YrGcpKAZJk4tQCkzunXM61FvRW70cugufMz8B4o9AHA2oD?=
 =?us-ascii?Q?qKTqtlykeL7apH+HywoHkRZBNnXdkuulPBmJndR7gVA6pXulZQ9tpVd6pkcn?=
 =?us-ascii?Q?vby0aETsBkj7RSB/AZcyMKC3Qdcac3B8KPRVfrKF209mx533LJmn0maYsEaN?=
 =?us-ascii?Q?dpDid2k0bmnxMcVOHRjNgvakVjc2sICyQ+dLwZqjMP9YyVlLCkoegCeDaBVj?=
 =?us-ascii?Q?Gv5igflseCpxtxbHDqUZD5iDYc36di00iHpzqnxP5PQmC22oDZgb8f8+Z9pA?=
 =?us-ascii?Q?Bgf6IYScEFd/NaG7uIo2d35hKWtA6JjmYO5uryNS2qOBYqgHHixYcuwwxBOA?=
 =?us-ascii?Q?HhLpOz62ddEeFQvQ97cN4j0nhBH1EcodNG6jFsodIts8kA/UaTWA+p8e5Ttz?=
 =?us-ascii?Q?flUgOVK58ct+raGMeqDkQbsPbZ5h+Z4XtnLg0doBVIgTpQpPpgtpLRHdhxT0?=
 =?us-ascii?Q?BgsRXIF7n0wOb34qRfLJnFXVhittTOKTgGvsuVIZZjeSogL6+DfvfP/ghdYx?=
 =?us-ascii?Q?Dwuzz2GoMC6xnQe+LxC2cxm6g4ZlThpLj6u4LgGCRTxG3AIS1sNdsCkQNQg+?=
 =?us-ascii?Q?iltWNp87UqnnXkG5yg0ogbkwaaLaiwaqIQ1rfDnIBOoLV8PV1zj0X6kwZhxC?=
 =?us-ascii?Q?FZszfb3z5335bZEf/4Btjnu4Us1EEmEerFb16ayG1hgvweuIPLN5wkNGt3TT?=
 =?us-ascii?Q?oYcWiYiq6B/ff0IzgVtt8ojVl29LRpWNdWILsMTNUh7hLAAYqeiRP52Fj6/J?=
 =?us-ascii?Q?u/lt8t3tRSRnzbavUQbjwFbUGbMIwHGW0bxbPPwqoR+Y6eg5cwXeoCQxK6Ab?=
 =?us-ascii?Q?vb3h1/gLHMvEbdDp1/Ew8bPuf9NJ0GNN5ctMDA/lL/ix7aCxY8q1V/FXQCto?=
 =?us-ascii?Q?NrCTG2TUTkkxeBPBqlD8vmifmvvnLZ0lpDuSGO7GnaVAL/pd4nmgiXg17Waz?=
 =?us-ascii?Q?T/t7yOuVjIEvGFYzz0IEYaa+q17LN7i+9WY/5tt66u0U9YAFNAIOFMRUYtvl?=
 =?us-ascii?Q?s0e+I6Z9PC+BW/Pdd7Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6dd8bd-dfcd-47aa-701c-08dc96ff5cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 23:17:49.6091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzLfqUsRFr8OnLv1Q/PNx+CbZJwZXwmnjq4fAVo2yAIoazJMp6zGfHBfZZU8ZxghSVM48my7FRkREUqg3U7X8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10300

> Subject: Re: [PATCH 1/2] dt-bindings: firmware: arm,scmi: introduce
> property mbox-rx-timeout-ms
>=20
> On Fri, Jun 21, 2024 at 08:46:57PM +0800, Peng Fan (OSS) wrote:
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
> >  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 6
> ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git
> a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > index 4d823f3b1f0e..d6cc2bf4c819 100644
> > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > @@ -121,6 +121,12 @@ properties:
> >        atomic mode of operation, even if requested.
> >      default: 0
> >
> > +  max-rx-timeout-ms:
> > +    description:
> > +      An optional time value, expressed in milliseconds, representing,
> on this
> > +      platform, the mailbox maximum timeout value for receive
> channel.
>=20
> "on this platform"? Doesn't every property apply to the given platform?

Yeah, apply to all the use mailbox.

>=20
> > +    default: 0
>=20
> 0 means no timeout or response is instant?

I should use 30ms same as what the driver currently use.

Thanks,
Peng.

>=20
> > +
> >    arm,smc-id:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      description:
> >
> > --
> > 2.37.1
> >


