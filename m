Return-Path: <linux-kernel+bounces-241755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC7927F30
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86031F229CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 23:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95A61448FD;
	Thu,  4 Jul 2024 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BhadKyjW"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E71442E8;
	Thu,  4 Jul 2024 23:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720136917; cv=fail; b=K7IRHUIxTQYhgKbyvHpyWembJF3qQyzdjdCSvAT6NbMPYoZ3vNXYWbD8FibyvnQ8JuzyLMSXa3PZ6xDBVXxflUiGFdEjN8BIdbaIQZQc9592iaU8NuTKZLfMD/BJcXP5wK21WoaAv9vuFsgQRbj/btkJOhT798YsvEn7CtfHDjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720136917; c=relaxed/simple;
	bh=KE4fN0wYUcC4ZZZt3Np9plYAV/3ybA4ez497nlkvrpo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SUUuW1jSjJrgFh5LtBjmbKxftjaJAtH0gbPnGoBLPYFjf1h1Rgl43hdlWBCyMljxQp5m95oZHzFkMHKIXlOhr3TwrsU/VZTIe0kfnYc6a/ky7OPjIBwqyY5fdOELmFhXdfLVHSx9YWJtFw+IVoE3BOV4HHEY+WhkEOyckfagGJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BhadKyjW; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsXQXDQuBER6az5BH2FjBOyE3VC+xaLtnfPMyoQ/3FwWh9AeN9MKkRIMck5GBuP/19dPNNUWgdRM21qOtafFtyg0B6L/iCgZwH+XV7eTL9JLXNAsNSqGboje+Eh44DKnI0EVUdexkT8IOcU4zhJVwPfXzARo1+pb51gOu+bfWojBAdSJgk7CIpp7hD/OYlI/rb3QDfWGqiw1KdA2BYvvGzvUKSf4YUl5gPMqBVUuU+UWl+4mTL5vtI8MsgmNwhAU9BiX6iATJ5RA6gnr5OTMYEIcLseCJHG68wGr+dDITBBp/UAtVH1yrZ0d6ZkIPbszU1UowefQ2u0esYEmrjkF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KnzgKQ7nADiQhqVEcWK0/cp0afiJK1D6LCg8p/LepE=;
 b=QiBJwWdn8bL5LUuXaovAs4yUkSf9Ls2ZQHNmfyaiphL+gctVmGX+XFP8dcc32bxyn9aWy6WkZqRXb7UtIU7ka9nZlP3WP5JQdAM2+DmWTb8ol1dGRaNOqvacKhk3iawzEltwat9SAjHSRHiGegMeSDXwlRYo+8qiRzUclvXBIWIt3CC5P7GBQr/S62MbmzNXe0ArovsjEk717tP1vlyQm1sWBS84cYiclFIJt9Nt2zMYMkJ6pZnV1mizZhdbcBUuh0ycHZhcGnOnF7TDRMizD5WaOnOA1vqokhB28JW9+9nglCrGsucvFaOYJ7/YJ7ud6MPPMgD2ZL2Z7eXGzZlYOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KnzgKQ7nADiQhqVEcWK0/cp0afiJK1D6LCg8p/LepE=;
 b=BhadKyjWyt+v9HAUtwLbTvS/e9BO4oQS2R0c0yJmSczVo2TYmQbSfDwY8vQsZcoB08LUaGtGH18arR3xepqcvneNZRDTQVAjsZ1rBSGPLRhqOekPT6ZsyUAi5XjETeUg2Yrv6KJUpCwcLY3ddo9ayPL7OkIq/WDikDQ5aFIO02U=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AM8PR04MB7890.eurprd04.prod.outlook.com (2603:10a6:20b:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 23:48:32 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 23:48:31 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
 property mbox-rx-timeout-ms
Thread-Topic: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
 property mbox-rx-timeout-ms
Thread-Index:
 AQHazPZCUnP/ehpH2Em9HKMSjtmmz7HmYioAgAAAeBCAAAFAgIAAHstggAAa2gCAAKEogA==
Date: Thu, 4 Jul 2024 23:48:31 +0000
Message-ID:
 <AM6PR04MB594199822CE1944DCE3F86D888DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240703031715.379815-1-peng.fan@oss.nxp.com>
 <ZoZ7NCSaG0YRK-60@bogus>
 <AM6PR04MB5941A61736496B9850A3B52C88DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <ZoZ8pfi5KZZGY1wd@bogus>
 <AM6PR04MB5941F61DFB15AFDA384C153A88DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <ZoatADKjBfpRCeLz@pluto>
In-Reply-To: <ZoatADKjBfpRCeLz@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|AM8PR04MB7890:EE_
x-ms-office365-filtering-correlation-id: 381f64eb-3928-4942-8577-08dc9c83cf8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5NvdNP8ZjyLacuTN5gRyOjFIlfzCJ7eUVm7trK9qj3CCiIqVqxvy19G3bE5W?=
 =?us-ascii?Q?cts4BGQN/s8k33veyltp1nMxIZbWajbc+XmSkukrAC7h+aeh9nsPF8XUmH/p?=
 =?us-ascii?Q?Va6/klM1RDAIc9s+ORqvX2up5OFwvJQNiuDwPi23mrsUCkt0bHFIjqOlBeoa?=
 =?us-ascii?Q?Wf/+C/41W8g1hh9xyKhGnPxYu00j9yI+vH2R8wCWn07KOWlQEZ3S0E6cdXTs?=
 =?us-ascii?Q?GC++fvcPgFLYgRTae36qd32OhVU7iDsRCuNat1A0VO8gQPVzGCd2qtyrUFMn?=
 =?us-ascii?Q?TXaxZMpmsZi1Jx2ILzF2OtFG82eqvhGHxKwpw0XKDWEZXOc4iIweWpuhC7ra?=
 =?us-ascii?Q?SeNzErwDjK5w0ejNP3iAhjNBy0dQVmuw40VfU7G1EQ4uCeJuj+A5gg1PjFxB?=
 =?us-ascii?Q?7h8+cDXynDSdHDRX63fLUKcinW+Ml4lZXBkxiQu8j3htp6OEXwTbbKNTOkeP?=
 =?us-ascii?Q?rtUmy1nomao8ndhn2FxdoQe2IDxruLrjJsRUCxB0AE5N5P5Vj574YCmpdE7s?=
 =?us-ascii?Q?OwhVl4xmoz5nZOIZYw9tUhfumDV7CLnEdqcG6xALKmPGC83T4YkZiXV0YFYG?=
 =?us-ascii?Q?CvoNVDH9TISPebV1vNF0mHxjE+PfxH5MqTIX6Po4B+//89GG2OI9MXEZpaGL?=
 =?us-ascii?Q?pF2i1OByBL8efc/UsvXm1y2F/4KL+7qFW33PX4gjCSaP3vNt3ouwdLHeyryQ?=
 =?us-ascii?Q?IzbOqagnYOn6dYahy6D6Ui6KFF2RXUloN7vNpXDAlW3LS97bfbyqsJRVEbP5?=
 =?us-ascii?Q?Dd4XTBj+Z2XErlnbrD6vMb7N3+WO9y3SZfn2EioxJPzA3hD5ftCma2TChy0M?=
 =?us-ascii?Q?SUqzSFOYr6ClhsNWwt2LFxGTkZEIR8PJ2YZTdCeVSdYwPPjWIlIE/W8cNeHx?=
 =?us-ascii?Q?xBE/85aMgKJG/40etK9sqDZP6sc/sn4cWsM++XIyvjF7G3Jzz6a6XEH+RJRm?=
 =?us-ascii?Q?hfrJlrBWECTVPSSHO9nOlm/CulpRI5tduyngZO8+Kh53LyAhc3ygXWgT46Kx?=
 =?us-ascii?Q?HT905/I2NGJt4s65niR04/wfK/YzhlIywyZE4YhVeQgYtAMZJfAEpXMWYK/B?=
 =?us-ascii?Q?pBrCmrpaHmwo+V1OWPHTfO9KQvfax8jzS0711LyFoNLt5b7kZy1NcYgY932T?=
 =?us-ascii?Q?JDEUxmMoAloMasPZO3Er0SAPZ7PnjAU9GRe0zPgaosKnZt+PgeuhVetJrtRq?=
 =?us-ascii?Q?RfeqhhcdGUwAb09ErTtvIMbFJszPRn3ylfqkgKQghIMExnjUNdJOpENcfPyP?=
 =?us-ascii?Q?SXpXyeCXsFTi2vXCHx9U+h2x5ybFdfsgmF6KgWKE6e23sY2mYv2x9++u1Lp2?=
 =?us-ascii?Q?2UL3tSeoPdoQows5ELn28ltroyx1FS+6JdxcFKeXvtuhhvHI8I9Rm6262oKa?=
 =?us-ascii?Q?GHpr9jze72kaMtBBXpjnlZyld3wmaPwt9kxXdcUBBJEIc/HnUg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P4Bpetvlh5tRtYb/diNC08guK9dvC5mwbAdUvIu0/kuC+feNx+8pFbLCopMG?=
 =?us-ascii?Q?W8M926E5HNp+JUG7Q+pl8I+/HR9jjeiJ3L1utL2bvQgybZrT4BNOAVjLvVpN?=
 =?us-ascii?Q?vKZTewRB77uMXRlkR6YWPgAsgTt9NSlPay6265PWYy2/hIMhLmy1EJnIB3z1?=
 =?us-ascii?Q?jqGehGhRCJKTbf4NhJKezwnRS4FVJpto1KoqdEor7rR8eoX11384ciNYsGGD?=
 =?us-ascii?Q?rwuabxX2PExTk1YdhAbSwSxx2wvTnWs9hNfWZJFnYEFwI5DA7m64DXWUBooM?=
 =?us-ascii?Q?KZCzyi7Qy82kKhHx6/mMdHUZwigvsoY5j7gRmLnUMmkkqQZWUO6u4kS8+5l5?=
 =?us-ascii?Q?vG7eWfXDLi+slRotsVczEkrltU8tdSwtd3x0S1PiDty2mHfrL68NmqOcyIAi?=
 =?us-ascii?Q?ggrB/e/ptuNycmRFPTx7FKbAZWpqR03nTHD1cwcp8lpojtoLrLWfZc6+RKL8?=
 =?us-ascii?Q?jfXxtraXjfM6xLamGr5byskelv83+1H/slPKoKb95JtVJ7oowsMR6jCxhd9U?=
 =?us-ascii?Q?Jv08+SRGHJS32joNL79LgKmHhRsdHkjlqulkPoxTYkoyZfzG8iHmazHLGJ3b?=
 =?us-ascii?Q?SBc07ovhs/2KKbTMTRkgLSj311o0mvFkaTyM+3mvtFRdCchdwe22grJcotFq?=
 =?us-ascii?Q?rPUQXrAJ7n0cM83HlwiCnF8HJpEMHkcJSU01ctjD83/wWgMafeNAFdHHO3Fa?=
 =?us-ascii?Q?bYIILZEpk0FgvijUxLQOdO+P6ZjkPUxvzeYbAXnwfXaGQVwgEfGSIqEhuEtG?=
 =?us-ascii?Q?e6YG6/QVHuJziXKX9enOC48iqqU44/zoIIFXhGSyutJSQemkt5VOql2R9SCO?=
 =?us-ascii?Q?yEDezjBdsnFP/0808gITM3gjtrWF3blT7mXNOcNcqic+Hh8QQp33/4PZ+7l9?=
 =?us-ascii?Q?EZcVgUnPAZC9m3bZPpsnQl3ElOm+XSq9UKCsgc1LkKOBV5eZcclId7i2LU0i?=
 =?us-ascii?Q?erQfi8bDdBoTULDdZ8saemGE7nwa/y0qdIVI5otvMRcl9khUfS75f7yafp63?=
 =?us-ascii?Q?P+42IVdHt1+GRhH40N6wRk3UOjtYHqZaxS8UnZXQEqn7buaeY1pZ/T1Sx7pu?=
 =?us-ascii?Q?e6vqF/Ti/Vt59pLdEhP5UbKtXhmLJpt6Wl2UAiOHdAi9vIvLHpu7msTqrQL9?=
 =?us-ascii?Q?FkZkRY2SLfiiMIaX8xlww0BNIbCO+NWJXUTN+Ea8dj/92Ah4BstWVVdVhJXe?=
 =?us-ascii?Q?T4Un3DJM//3FMxxAQ37rxdtLUS+25ce5vItYhRJbm+eFXsk+ZjreYJFhQmt9?=
 =?us-ascii?Q?zsgFOMfpBYjB4WMKbUXIdDuyzOLR6Nelq1O04C5lt6rDlTUFKLh3J7RjCGpp?=
 =?us-ascii?Q?XUHpIhqAKN8s3uuYvMWU4+yguWnBSTPtyQ/zYPZ5U5EdrjP8so2G58CQGqRl?=
 =?us-ascii?Q?zjQ5s7F5ITgXe2Z7egJ7LdYasa38C+SsfR0u+Cb+4ElcdRIORqieTeYgSqEA?=
 =?us-ascii?Q?IQaDGm+98KpenewvnDzuq0TNsV5AZVVyc+j7XFdfXPTq2pMwtG8xpgWuT2+d?=
 =?us-ascii?Q?tJ7dW2GuMt91fKVJHRWPqWGgL/el0Z31hq2oaQCYkpryBRiJFPPaEvDtWmlm?=
 =?us-ascii?Q?HUf0ce4PCc87iCtLuQQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 381f64eb-3928-4942-8577-08dc9c83cf8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 23:48:31.6302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UIN2BQSsKM3tTeRdLRMuPNXPXU3v9//UHsN24fixi5zbrjc0Apvcgb2HFt1dzA1IHUeVOrCynk3uj3NmBG6QyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7890

> Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
> property mbox-rx-timeout-ms
>=20
> On Thu, Jul 04, 2024 at 12:33:09PM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi:
> > > introduce property mbox-rx-timeout-ms
> > >
> > > On Thu, Jul 04, 2024 at 10:39:53AM +0000, Peng Fan wrote:
> > > > > Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi:
> > > > > introduce property mbox-rx-timeout-ms
> > > > >
> > > > > On Wed, Jul 03, 2024 at 11:17:14AM +0800, Peng Fan (OSS)
> wrote:
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > >
> > > > > > System Controller Management Interface(SCMI) firmwares
> might
> > > > > have
> > > > > > different designs by SCMI firmware developers. So the
> maximum
> > > > > receive
> > > > > > channel timeout value might also varies in the various designs.
> > > > > >
> > > > > > So introduce property mbox-rx-timeout-ms to let each
> platform
> > > > > > could set its own timeout value in device tree.
> > > > > >
> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > ---
> > > > > >
> > > > > > V2:
> > > > > >  Drop defaults, update description.
> > > > > >
> > > > > >  Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> | 6
> > > > > ++++++
> > > > > >  1 file changed, 6 insertions(+)
> > > > > >
> > > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > >
> b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > > index ebf384e76df1..dcac0b36c76f 100644
> > > > > > ---
> > > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > > +++
> > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > > @@ -121,6 +121,12 @@ properties:
> > > > > >        atomic mode of operation, even if requested.
> > > > > >      default: 0
> > > > > >
> > > > > > +  max-rx-timeout-ms:
> > > > > > +    description:
> > > > > > +      An optional time value, expressed in milliseconds,
> > > > > > + representing
> > > > > the
> > > > > > +      mailbox maximum timeout value for receive channel. The
> > > > > > + value
> > > > > should
> > > > > > +      be a non-zero value if set.
> > > > > > +
> > > > >
> > > > > IIRC, you had the min and max constraint in the earlier response.
> > > > > You need to have rushed and posted another version before I
> > > > > could respond with my preference.
> > > > >
> > > > > So there is no rush, these are v6.12 material. Take time for
> > > > > respining and give some time for the review.
> > > >
> > > > Sure. I just not sure what the maximum should be set, so I drop
> > > > the minimum and maximum from my previous email.
> > > >
> > >
> > > Worst case we can just have min constraint to indicate it must be
> > > non- zero value as you have mentioned above and drop that
> statement
> > > as it becomes explicit with the constraint.
> >
> > I'll use below in v3:
> >   max-rx-timeout-ms:
> >     description:
> >       An optional time value, expressed in milliseconds, representing
> the
> >       mailbox maximum timeout value for receive channel. The value
> should
> >       be a non-zero value if set.
> >     minimum: 1
> >
> > Put the binding away, when you have time, please check whether the
> > driver changes are good or not.
> > BTW, since our Android team is waiting for this patchset got R-b or
> > A-b, then the patches could be accepted by Google common kernel,
> we
> > could support GKI in our release which is soon in near days. So I am
> > being pushed :)
>=20
> Hi Peng,
>=20
> once the bindings are accepted I wanted to fold also this series of yours
> in my transport rework series.

No problem, feel free to take it into your series, I will post out V3 later=
(wait
if Sudeep is ok with I add minimum 1 or not), but v3 2/2 should be same
as v2 2/2.

Thanks,
Peng.
>=20
> Thanks,
> Cristian

