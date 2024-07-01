Return-Path: <linux-kernel+bounces-236257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A900791DF94
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FD01F222BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5942158D95;
	Mon,  1 Jul 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dn0lbRHw"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2050.outbound.protection.outlook.com [40.107.249.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CF0155381;
	Mon,  1 Jul 2024 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837676; cv=fail; b=UiytbghosG7SsPSUXbIUtkqO1f3eTFK8GgHRKvSzOigJDSdmnzRSCJiaeV6q088jGXwZMMcq43XeKFKl2tyJK9ZYhxkkkXs7oAXZgoyAks7Qwf5tESjQIZh2upYoPaCYDj8py6krFWlWpyq6IBfCTunFCBwhAtQoLKrfc2nXTL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837676; c=relaxed/simple;
	bh=LWx/zCY4g+P+snW7xxc3INMF/9SLSOwgR3D2ShJNcNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NPq4bzS1HnBQaAQCQooMqKH9791R0H1rr7Ub2kXCKMDfX0GY8o1Zumb0Pwn0QH2LUIcXN26VUUi69rAm/e6A8r+cuVWfryGKRDoy9uexYN1IkrncaaD2C3JS/PgV/eoQTP1HDzbKkPitGTnzRByDqHDM7SQ3yITjDjRNfHfhnhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dn0lbRHw; arc=fail smtp.client-ip=40.107.249.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWfc82Lgt9LzKaG3NS9IHRmtSizq6T2tFD6W4eYqC68mOaSYIDjiCy7lU+UWyD2XBbXudpL7eMLqd3WMxZHC6woyU5JWu7Dw7W3nB6I08njb4TLS3N7JzFqVATKhEB4Q09iqOyAW1eqHhSMNVU6EuZC/rrhxMytPQaXOoENHBaL0YMuqpZcBHVLyHKlUOcAK8IIgp6cYBVwgK29ciMTk+iccsXOteam6r6thOyu2WH5eopgs9k823vFy3qPjuO5bUtpuYM9p/1Vuh+6u7I4RzPb/KfwXpotcCMugDScjgq+Uu4Sj4bQNqaWfQ2Nh1+D9AxVjo2nXl3PKBWXQJHZM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gGPVhYoTehWvEpKZcQnNXioC7v9j5iGvtI+8yrh8yw=;
 b=QDVNNTZQbauA3PfV07P9Ljhk98F0Sg9jmOs8Kk95Pyzsg3e9LsKl5Nf1xfq2r9sZqWBL4U0J3z/0ZbfeRju0xQfeZynLTAjiOVGLDUbktnXZQ5M0GEecFXXNpx04sno2h89krC43ijq64jWGPpbkf2ua+pW9AKN5W5vBUe4DChG5MVOUlfj7UtGZGXdSy8try2E1VkUmhMOjhDeUKyyUzbE3b7n/rAG0htJAiMmsWm/pccjYze5rbE6kL2TG3S66jJuXmHUhv3xCv+MXUIy9Gh3m5wLX+YeG6uSSrMyekSYgfzLKi17uRu+W2X/CEDrQ/Ks0A/55u8Qmjv1b5VWRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gGPVhYoTehWvEpKZcQnNXioC7v9j5iGvtI+8yrh8yw=;
 b=Dn0lbRHwK6bdsKZVcXNgGg+jOU5pyLKyDhGhEUGASf4M/FOOu1U73mh0fBIMmqCwJIFFSHbj5kHGFP6WJLt0YNMu6RoWwU8oBZ8NSdgWQL9N4KYNz02Lhv9A7h7E1dEHZOGzxedNBp8yLpn1NYEg5td3LFVU5we5iIiZRNevySA=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI0PR04MB10104.eurprd04.prod.outlook.com (2603:10a6:800:248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Mon, 1 Jul
 2024 12:41:11 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 12:41:11 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "robh@kernel.org" <robh@kernel.org>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Cristian Marussi
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
Thread-Index: AQHaw9fWVQ0S04HfBU6k/eA0824dGrHcL1KAgAAZJZCABVuhAIAAN+bA
Date: Mon, 1 Jul 2024 12:41:11 +0000
Message-ID:
 <AM6PR04MB594103F1F6F08258132982D188D32@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240621-scmi-mailbox-v1-v1-0-8ed450735f46@nxp.com>
 <20240621-scmi-mailbox-v1-v1-1-8ed450735f46@nxp.com>
 <20240627214645.GA614300-robh@kernel.org>
 <AM6PR04MB59415F7793F4D15CCCB7388B88D72@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <ZoJxeFxErmM8Gec3@bogus>
In-Reply-To: <ZoJxeFxErmM8Gec3@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|VI0PR04MB10104:EE_
x-ms-office365-filtering-correlation-id: ab0b2910-a47e-4731-799a-08dc99cb1686
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GFUQw250ncdlmPCA/CKyMKKsZiIk5rW5Yk0eVaV8fJddkxDD8B12dhYdOYMm?=
 =?us-ascii?Q?87g0x7FXmak+JCpoHoQzgZ2YeCATuANyLfoYaxz4Z1C4jTbvKT+tKXqcf+E/?=
 =?us-ascii?Q?qJPQB5OHRo5wug8scERYZRQtxd7WRTTF/K1QAhDsf0Z23grUEBv2WrG/YxTE?=
 =?us-ascii?Q?2lTb2o4bQrPd2JXlDMY5JsunrXQhsT/z2TRteo7CBICfHUAgOPCl02Kby2aY?=
 =?us-ascii?Q?t6dr9P6F0VuduH4sWnwXljEK5T4udL8z534Y/fwYra1B4PcEqxM+7ej6Fsb4?=
 =?us-ascii?Q?TN0yWMf7myGcPNOFPo4ygdTTGx+B0Zjz5OKxWP/xoKwgW/ltXsJkKx3rTvrD?=
 =?us-ascii?Q?Bp4eWMrv++pxk5QE4f1J4A9E13IbocN7vLXkCtPjO5Fnu6e0QCfmMX4Cgmrx?=
 =?us-ascii?Q?ed+Z1WdJQ7T4ronvKgrF4qFRSw35iZ/WfQKUR6cOrTxoBBo52nXSetheyQse?=
 =?us-ascii?Q?G15uly7jYUgg9j2bKHVTHjOj+eU1KQfohBqLRzbWpe9MxfMdl4gnjAqM+pDA?=
 =?us-ascii?Q?rBwyZ3fZlWdjXLAX+BXBaIRPWDSbgmo8dcLUtDd6po4eObrxeSoVaxoTW2OE?=
 =?us-ascii?Q?qTuPKs5zTuKFXmEHHAC6in+vsBTLFghVCIKfKkALFNyPC3tkAr+25055LzCv?=
 =?us-ascii?Q?cDt1T3Ck4SUZtxi9ylBP/6Y6cF8NDqTXj5I3hNc+bxVX4jmZik3T7iHoy81b?=
 =?us-ascii?Q?0n6PGzPLmvWH10cL9Ndb72hAGKF1AChoZtcXmNCCVI5JOk6OWoOMcazApTD2?=
 =?us-ascii?Q?sHbFvTvR+XgqBeHMsyyALwaf5Tp+Jpsg7e7dyfhQgu+hqzjll9h42TZiQWo+?=
 =?us-ascii?Q?MXkvS+RP340+6ZGfs1+W0hA9ww6fUXujQqZGp0FWpT9fBCB4/1a7v4trJRbm?=
 =?us-ascii?Q?C5x8nctxkl8FEF5vqEdpLaO7IPnXcZovcx1D69X2BAO+2VGbiI2VOGqlp+LP?=
 =?us-ascii?Q?aiefs81+W8wUM0V5Q4k5OQwQfTEtqCKXiEY16dDUh2R9xhhjJjP3tzJQr36n?=
 =?us-ascii?Q?bugIh1bWN15FXoeKNDVlE07kFmJIgz9omildb+UIDWzf+9kjWe9U7RRrnD1R?=
 =?us-ascii?Q?Gp0M4NlDmGgKfWGY/xIZtj2PFSmiHIH3k/T04G7LQEA3TnHFZigj+Z0B80eo?=
 =?us-ascii?Q?1pYRUXxcfyGB+kEIPgWpljCmJBS40CibvC88JtgyAnmQ0p5gwFmhfZ+gMRVE?=
 =?us-ascii?Q?TiuVxek/X6l0hwMUJT7svjLITEMen7MuPqDADEG+HyTbLsslDjXdi41LlDrH?=
 =?us-ascii?Q?tYdOhhybuypVoHZdlyY4ppiDHjZ9N0e1S4ViL/U6MqfUyBdz5Mr/1qN2G/bO?=
 =?us-ascii?Q?/GEY4bhWOWTXZH8d7BBNqaHSXPilaZicq/O9/6Mt7KbrOo2aPIYJhIJ47mEB?=
 =?us-ascii?Q?s84eM9phO3tGYUQwzXPsuv7cPBd6O2nS2h1KgE+izaVUEFvnRg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QVcONFTA9bgP86Z2YygpNxrz1fXNacemVBVOxZxsH37c0MdFIUNFPHF6YZf5?=
 =?us-ascii?Q?r4OrQm8QgRE6h5OyAodxaicYPRnI/bRmLze2FNB/Zbmt88wK3IwFz6nkZvxJ?=
 =?us-ascii?Q?98jj46dPWT6nUyFe2Fv7vhMOyDPq0Hbk9b002/RKrrVqRDjXid3+E2O07OvA?=
 =?us-ascii?Q?+8pdprLOfF6uce1BwEqePXFS28HjL7qxxXCfYZHSPuvaxOccXmoNrrzYuTCU?=
 =?us-ascii?Q?RcQHX6cF9nttmUFPbDm3C/uk0EUGzLqZn9drUps0VaT26Fu9TFUXKJ85bgk1?=
 =?us-ascii?Q?m0sN/AxZ0Pr44tcpW7zR3UNFV0JjsjBeU173433nJrfArFcO6RnTn0qv5gCH?=
 =?us-ascii?Q?mLqLnWVPnnv7ekSmGwymlVW+fu9yo1AwxQRKGT8UtERJjDsfdAJ13YfbKhJI?=
 =?us-ascii?Q?3Bim68VSXlfFWQo2hCMRy97+9H7O4faEh5Ruv2ejlx6+jVcCOjHvZ2lxtVGh?=
 =?us-ascii?Q?7JqYrzRRJtTMSMB6NWTyfzgm8p1e+Sk7NFPp/s8e9i/mcvKpwJljbAgGBV/i?=
 =?us-ascii?Q?DF1giOruXTMcXG0tS0aMdMBkfLZdNurLs5EMM0G2TPNjcLqS4gPGTcDEHP8n?=
 =?us-ascii?Q?SDOW3kZZlq3DWqXrUoMuM1S8ECdME/qliEy/dPgZjVrTlj15lT+YrwAQ5UTx?=
 =?us-ascii?Q?jj2MzhNukU1I8aRRmB8iejuNgHn3ssRmx07/jiTsgdidgJQ39Gxzd4xJoSOS?=
 =?us-ascii?Q?wmxpuSfWoHRw+dm+S8U4KWVI3jMUp3a0CzMqJQcWvYAna8p6lCwV6dCce742?=
 =?us-ascii?Q?udemuI0a9QKlN9SjXbbFt3tR9obnJ72dwpFBCICmX+WQH3aM0VCtFOUszW5o?=
 =?us-ascii?Q?SwGm5fX9pnMVE1otKbnTzCxMOy7ObN8UbkFtTtMLtOd8rAPPj2cm3imXaT9B?=
 =?us-ascii?Q?WNFZ6F4L68qiG93zJNus7E0S2gpgWZrX0Dw0gOOYEW39dqNEZL5eFUVEfEg6?=
 =?us-ascii?Q?nMt+f5GAaIFrvIkj1OI9fQSGvY3gKQQq1868O4rJkzx9jiU6BEujf7/ItXfo?=
 =?us-ascii?Q?GmQ+dRqr6JE/8q8wh30S+8XCQjmk2/5GuGMJVW2zdfgStfj5eGq+FepKXceY?=
 =?us-ascii?Q?+T8VOyapulJslG0zpxICYjX5ix+dyLK0WphvF0tUoYhfIFZGPwVVAch66oQv?=
 =?us-ascii?Q?OroSiHysuORDA8qLKb2OZMKM7LoeJaGgw3TnDOueluTHTCXQdpw4GQUu4GSD?=
 =?us-ascii?Q?fwi2b2npGY8yyxkwUZrq9JJQuCzVEkAqK0VxwDPTkEn1R8CZ8EJip4XJNjxS?=
 =?us-ascii?Q?6NsvQ/mPYCldGm8TcLrIoJhbri0Z/OnYYoP78I5ZDSJdtMQI/dFW3HhS+xn0?=
 =?us-ascii?Q?V9rXettv5aVA23qZWcVPKYOC7p42My3kazF33JsOmBHx+uRkGg/btkRyeWf7?=
 =?us-ascii?Q?QCypvLjvNnILaaRJOawTGOtrV/rJjgDgG1LicCdfE4YMn3q1BSWKqFCd+OrY?=
 =?us-ascii?Q?cxKijhqzVIcIFu3p+7hpTu/XrZIBkGsB3T2jkQT5kj5V/h9h66yr+GzDN+jT?=
 =?us-ascii?Q?MubgT+NvXkbMjfPsupicN//jda/4IxKFkooyWVEv9lkmscoBMCaW9afHufmq?=
 =?us-ascii?Q?BzcoAMN7Lv0THQUmdb8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0b2910-a47e-4731-799a-08dc99cb1686
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 12:41:11.4518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tl485VSHIhcQVNrBbM38rRa80Dy+XWqIj4CrK9XMLa2nOttvRwvR+xjlS8ortFmIOHok0LaD/tyZrDtj1NbdrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10104

Hi Rob, Sudeep

> Subject: Re: [PATCH 1/2] dt-bindings: firmware: arm,scmi: introduce
> property mbox-rx-timeout-ms
>=20
> On Thu, Jun 27, 2024 at 11:17:49PM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH 1/2] dt-bindings: firmware: arm,scmi:
> introduce
> > > property mbox-rx-timeout-ms
> > >
> > > On Fri, Jun 21, 2024 at 08:46:57PM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > System Controller Management Interface(SCMI) firmwares might
> > > have
> > > > different designs by SCMI firmware developers. So the maximum
> > > receive
> > > > channel timeout value might also varies in the various designs.
> > > >
> > > > So introduce property mbox-rx-timeout-ms to let each platform
> > > > could set its own timeout value in device tree.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 6
> > > ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git
> > > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > index 4d823f3b1f0e..d6cc2bf4c819 100644
> > > > ---
> a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > +++
> b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > @@ -121,6 +121,12 @@ properties:
> > > >        atomic mode of operation, even if requested.
> > > >      default: 0
> > > >
> > > > +  max-rx-timeout-ms:
> > > > +    description:
> > > > +      An optional time value, expressed in milliseconds,
> > > > + representing,
> > > on this
> > > > +      platform, the mailbox maximum timeout value for receive
> > > channel.
> > >
> > > "on this platform"? Doesn't every property apply to the given
> platform?
> >
> > Yeah, apply to all the use mailbox.
> >
> > >
> > > > +    default: 0
> > >
> > > 0 means no timeout or response is instant?
> >
> > I should use 30ms same as what the driver currently use.
> >
>=20
> That sounds very wrong to me. The binding is independent of current
> driver behaviour. How the driver handles the case of default 0 value is
> different from what the default value in the DT means IMO. You can't
> just set a default value in the DT binding based on the current driver
> setting.
>=20
> We can always say since it is optional, absence of it is what driver
> handles as 30ms. 0ms is impossible or incorrect value as transport
> involves some delay even if it is in terms of uS. So I prefer to set a va=
lue
> of > 0 in DT and make that a requirement.

How about this?
  max-rx-timeout-ms:                                                       =
                        =20
    $ref: /schemas/types.yaml#/definitions/uint32                          =
                        =20
    description:                                                           =
                        =20
      An optional time value, expressed in milliseconds, representing the  =
                        =20
      mailbox maximum timeout value for receive channel.                   =
                        =20
    minimum: 1                                                             =
                        =20
    maximum: 5000

or?

  max-rx-timeout-ms:                                                       =
                        =20
    description:                                                           =
                        =20
      An optional time value, expressed in milliseconds, representing the  =
                        =20
      mailbox maximum timeout value for receive channel. The value should  =
                        =20
      be a non-zero value if set.

Thanks,
Peng.
>=20
> --
> Regards,
> Sudeep

