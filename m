Return-Path: <linux-kernel+bounces-209221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6215902F25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56B91C21C99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8901916F8FB;
	Tue, 11 Jun 2024 03:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gmG0ROf2"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8E82A1C0;
	Tue, 11 Jun 2024 03:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718076768; cv=fail; b=IoSdu5fEhRl/S4HZoMWips0KBidOJX8XJ2M4fgKRi4o/haZt2CYjoaokhUGyu4gaEP8WIq/OlwJ/VlCzE9vgQQzERI5R2Tifc3nU49nCxykdZW6Bxe8iWZyYsMJfOnWJ+JZyw9npR6RneNiX6sEPWNEiRWOXUpHrs7dN8y4RlCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718076768; c=relaxed/simple;
	bh=jcBb3qZS6c/ePJputobjCs6bTQ79qJlZvRH0VA65nm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T3daCz2ty8oGGpW3D/kK3DjqAfYXuqPKc56npHRZqVuYvvzWhHv/jWyL+rBbREQxkZxRFbQAF781B3aONcgEhzzmO8RL/hC6ogVr1JjOZV9TQ+akDhG6oATMXm8DihclA2WojKX9RLJy7TTLYLNK7p7pLvn6lYKB228podsbYRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gmG0ROf2; arc=fail smtp.client-ip=40.107.6.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEehlCyPMe2OQerVtR0r+CmgTuTHXj8U4NdFG9VdCRjSa6IMGHhAMdUTUaNkmFyTMVsxcAV1QmEGK8dM0tOSLm1n4cbGRCh1UerRCVz+Pc6APXOmCW9mjDawNamZSk8oot1zqlISQPCfvfsm3Yag/tgV6RT8AQqO9zw+XZ5CKK5SgejYSfPO3zy38zjyxEZ5n9PbeZJNvajC9JZADJcu+dWooAo909trbDGbGdWu2vmRvZZe+sRtDDSKDB5HyGWdSO8JnyIEGG4dVnhWcCDxNWduZDhpkjPD4iDrELDnWNKX7cqsMDLh5F0Mbjjn84Ufdlp5mnmQFgACMn92hKXZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkD6Rdu3GLB65uytV/HXkA5QQRJvxKiHBbMOZ5jnHtI=;
 b=mlYW9cz2zHEkq7ykOcnBQtqH0+tBtWEFEpSUWOslQdodxbsWfanwqI6ncURiV/iIj1Pqfmt1u+XtPDxMbaqLke3d0kB7Wp4VGrn69/rmwX2mi+E+hd94lh870ZW+U3lZq40Ocr71koJwb5GhhyK1cF2aeTVzyiEppPY2b1TVA/DIHH7yKfdcvNvnKBH/DFP2CJJvgTXX8H9desnLlaYZ3JtpmYGNOflSOrtczZLR0+0SOj7VmR9pPdrZh9uO+zrfWQT7khJgN21cpq61f9CGgmuVE6m6+766jhii7S1XoQrjnPKeKCdiGBOwfZUAz38jz//28kAiyLkM0lbDcz8AZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkD6Rdu3GLB65uytV/HXkA5QQRJvxKiHBbMOZ5jnHtI=;
 b=gmG0ROf2+rLA0mlucGMcRljUQD8+CmaCYzVI9CjM1W8A58xsF2On1B4gfj6tzm1I+gsgJvWZIZ6GiAZtxl/rlHiExzllV7evMCoyzf5YELZA54sBjjdH1YTzMJkF3wJ7QocZ2U34QRrVajRv6NgVMb+t++V1IVCmURBTmdswcos=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8959.eurprd04.prod.outlook.com (2603:10a6:102:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 03:32:43 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 03:32:43 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Conor Dooley <conor+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Alexander Stein
	<alexander.stein@ew.tq-group.com>, Fabio Estevam <festevam@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 0/3] arm64: dts: add i.MX95 and EVK board
Thread-Topic: [PATCH v6 0/3] arm64: dts: add i.MX95 and EVK board
Thread-Index: AQHatuWaNpa58GNnAE+tz7U0TpMpsrG5JgmAgAjK5OA=
Date: Tue, 11 Jun 2024 03:32:43 +0000
Message-ID:
 <AM6PR04MB59419EE033E7952042B902AE88C72@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240605-imx95-dts-v3-v6-0-2ce275ed0e80@nxp.com>
 <171759285255.2201583.2972532239106295355.robh@kernel.org>
In-Reply-To: <171759285255.2201583.2972532239106295355.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PAXPR04MB8959:EE_
x-ms-office365-filtering-correlation-id: 53e1dd8b-ae08-4f51-2120-08dc89c727c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1mZefLV3LIOHEDRqbaScSyPjZkfWQRTLBEOlhfrfpJMBCWZay+8pJkZzXi0P?=
 =?us-ascii?Q?7uVRaxxjF7Z/UTOnKGaTjYNlhc7lA8Tup2+YjInbQhVwM+543vQvoFcoMrvq?=
 =?us-ascii?Q?o4WSm3WfTax5ERSBCdWLgUEEsemsSo53E1woMFcmZwnx10Ttaq36EKL76Qq3?=
 =?us-ascii?Q?yH2iQ2NKmVW35dIZNeu36Mzr6+nCV30cohCTyy4eVi2dqIRrn2bUfdFYfNAK?=
 =?us-ascii?Q?aY14BX7drOCzWG5pqEyYDvdv7hMnNINzD6KwmRW5IESg3vj+6fc39sx28awa?=
 =?us-ascii?Q?DK9jxvWQr/CgC/J8bdbryjz9Z61W3ayXoWr4AIJiq67sPlKPqWbNjQaK53HW?=
 =?us-ascii?Q?jl+R4jqVDsYX7EQQrGM5IT36FAhAHWwUjk+zPPVdCthaXIyBSjLME4EpBSx1?=
 =?us-ascii?Q?oO1PV5qR/I3T3Tvp1uO928zFzFMd29LDw3Hmgy1nU56uZeKoPd0PDi3mmx7F?=
 =?us-ascii?Q?CozPf94dSvAuXDykysAWciX1E8YicLOI55iD7yxXC0oIdjIHOqCrkGxTdSxZ?=
 =?us-ascii?Q?tlehyqoaZ4xA+Nj/sX4eg5TSBhgJEGKl4rCsZ7CVHhQGmji/f8pI3sasAHmc?=
 =?us-ascii?Q?z4hOMvJ8ZK/uyowImqRZVlC9r2bbF+oCxAx+07kqRrvN2B+NYIQ3TMj0YSRm?=
 =?us-ascii?Q?twp5GkuGnmMJQQEGTCljeclMI0+PajcIo4W1GNYdYJYcu6/QQOQHMjHx+Dpv?=
 =?us-ascii?Q?5ykDAsQLQNpvjXYFIfJF+gCeb3sSswqGfLIEm3Jt9z4RFGUa8AskoS2Cb/bu?=
 =?us-ascii?Q?megUjqn95Pn3dFeN8Pj2R3XX4HdILROL+b8VmH0+5BiZm586DsGgff+N/Hpd?=
 =?us-ascii?Q?Km4TbyWKFVaZDEq0EGpoWlS/ajJwj1HQerBh3rRlC5OUPY1bteftp7IA2C48?=
 =?us-ascii?Q?auJ44RbXGQEcieJ+HFmLT17tSjC6yRXfefM6aW1Wqm8CFChfmBxLacEwjBC4?=
 =?us-ascii?Q?//s+/l9dccjfKQ93l4oMxo2DIYXt1UXwnDe5/tl04tqxmum82OfcUqmNBIgp?=
 =?us-ascii?Q?tcBHCpwV2CEkVB+WjlKEI4fOo57+fjT8S9hDUu7waKVPjtcFa4fqbyb2wNlo?=
 =?us-ascii?Q?b7xOIEtyUTZlXYa4n2YRTfDQl1A5k+JtTrA3WA0WXeLiMRa4C1/f1/w/PZOI?=
 =?us-ascii?Q?TrPKYPepOUSMUkbiucP5tFKBCrGq8Svus+eT82AoKUqut+BHSwbLpkAVJ0DR?=
 =?us-ascii?Q?BPwY/K/2mHoNuepo4kOjK2moQu6qfokMtnt+ed6eaQTuxJCQbek08yFhioJX?=
 =?us-ascii?Q?emPaYWmJDtMpMmeL+L7+FTRxlcPMYG7FR4kuHi1ppbIDMNQZki2GuclGdDuH?=
 =?us-ascii?Q?YPtPLg0klG/3se8szPfaR29ntHAcs+MB5Aubp2PWmchB+446w+ipCHWZ5e/s?=
 =?us-ascii?Q?pO/ItPQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6jXUSvasbQTkuy2FTlvpKjYBAlK9qWhWTjoWlFnLES059GzEDLs3G0cxTWpm?=
 =?us-ascii?Q?2/Ig2bca2UQpOFU2cVw+/ZJJeeak44/uupj7Cvye2V9uEiEDA0zayjD69Map?=
 =?us-ascii?Q?+UF6RV9fJsNq19qs4eOaoHYhcMqgcoVxpMIHh9j61+kpXhsESinVUllrJrL2?=
 =?us-ascii?Q?sjOeI2Y+eysHDDLzpZTnRj9lJbpPI2/xbZbQz4GCPVclueqv6rMFV6szWdOB?=
 =?us-ascii?Q?YcXUKZOhVk0r+ZnobzDJuTWGcdnqvbH5b0PcMmYu8to+J0xqbhN8sOERm/iU?=
 =?us-ascii?Q?9l9ZaUe8c80LLI7UhH0zw2OZIK6iOnngcWrH9ykYcBvjkDoMzoi9YuQhXwm0?=
 =?us-ascii?Q?JZzmMKzJ/OWQEGz0b+l0P1K2T1B+s21miY1Ezl6oAZ4wqA90da2r+f20Y0zD?=
 =?us-ascii?Q?DKrfDs+pqAs9iq03NmbKpk7pKvbieu43r8LJTVARV9FmP7EjcISPOR6kIx2Z?=
 =?us-ascii?Q?5pk3nKjLikSli5uDNN1mLQIa2OzOPNCsitYRT8a0De7vQX4tLPFjILs8bBVa?=
 =?us-ascii?Q?FaqDhSPtEBFh0STlrlvK5EtuWXIJkf6IeR4TiOEJ7t+k4L4hpgxlV12ZGt8D?=
 =?us-ascii?Q?LlZ4h9TwBGXkOwKbtpvsisFrOg6JvBd2qHE7R1mPKlZdmIPJSkJh/gNzj5cC?=
 =?us-ascii?Q?ZcAGBDOPuD0YOaStSO5jMmFNUz+3ZlIaJ/ENMg+uuhl9Ywe9ghMbx0/WLT4o?=
 =?us-ascii?Q?yEwpQ+6pjzWglj7xaXCSUu9pX7Q3TZylDr76sck13QEO0gZvUH5PQKNA+j86?=
 =?us-ascii?Q?V5PyMc0w8BJQ5ti844Gmar63mGP3JE1BkWGzfTa0ScWYFQwJeX90oJMGdxRx?=
 =?us-ascii?Q?GLh9dKBfamTriVGibhseLG+lNRaHCfmbH7HfGE7L2tENM5U1eIRvw4S5BO0o?=
 =?us-ascii?Q?ShnD+twyaBpyhwpAXK9MLR5gFFDP7R/yw8ZkYKmgtNyiQKDj0z9JJuHDcRyr?=
 =?us-ascii?Q?QJAOMBtiYUhpc0xrLlbsWalxQSsk1blElmYy52WUYBdM3HhPYfi9LGoHfcA+?=
 =?us-ascii?Q?7SSAR7S6qfMvLDx07oH2BN1PorKMggBx9lBxI2jBiEGVArI+0CoIFFYWMwNv?=
 =?us-ascii?Q?zGeddUrOKr8jZAhnn/s9838BU1O5cCC6mQ3JHDMmEHN8pvtt2Hsfwoo1EN1I?=
 =?us-ascii?Q?YroQCQu3WE2IdX5jdIVuZzfQLKujQS/Ho+YC3iG9Om09ltXXTpuMdJzehYQV?=
 =?us-ascii?Q?o+YB/w8B8TdlR3SuqUX8h4tLG09TcVrmXbDAVkn3H+7LqjuivxQjWrZ1M6SU?=
 =?us-ascii?Q?IL2QjhkgunNgKJaljgFukddl8KO0mwcqQPnMgpvL7LO2QJnemC0wOUQQeO74?=
 =?us-ascii?Q?0eyawaNjUOGWUKjoZgkuPljH6OVs5Urg4nrHW8suEqLKj63Y7FdcsQEdWoMT?=
 =?us-ascii?Q?L/p58a7jaz64sHXr62ldsrZrg1CLLcv0/2Xd0bbdcucBz94uM+fwUmZrzFDK?=
 =?us-ascii?Q?LJL+b2Tc4O1WeoVKnh3d6AC66g+nEEryE3ohy0JbuP92a7laYKmQ6mEoQ5Dn?=
 =?us-ascii?Q?Ygd79w/S3tWpKL6m2ODMDRRFoxcTcidE2EmAIhmlwv43cqXHm6J/pe2u3DUJ?=
 =?us-ascii?Q?Si6+kZAgdpGGnAXlY4A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e1dd8b-ae08-4f51-2120-08dc89c727c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 03:32:43.7723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llfOrOVNtqQEhJL6n6sq9o7xBQF1lRBSkIN+btrQ3MwaJ/h1EQL43rPounM4h931+746UWAtwBjiZg3uZovyNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8959

Hi Rob, Shawn

> Subject: Re: [PATCH v6 0/3] arm64: dts: add i.MX95 and EVK board
>=20
>=20
> On Wed, 05 Jun 2024 09:22:47 +0800, Peng Fan (OSS) wrote:
> > Add a minimal i.MX95 dtsi and EVK board dts.
> > i.MX95 has a M33 running SCMI firmware that supports
> > pinctrl/power/perf/clock and etc.
> >
> > imx95-pinfunc.h will trigger checkpatch error, that is expected and
> > same as other i.MX platforms.
> >
> > In v6, I added back a dependency on pinctrl, because [1] has got
> > A-b/R-b from Maintainers, so it would be soon got merged.
> >
> > There will be dtbs_check error before [1] got landed. With [1] merged,
> > there will be no dtbs_check error.
> >

....
> >
> >
> >
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform maintai=
ner
> whether these warnings are acceptable or not. No need to reply unless the
> platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then make sur=
e dt-
> schema is up to date:
>=20
>   pip3 install dtschema --upgrade
>=20
>=20
> New warnings running 'make CHECK_DTBS=3Dy freescale/imx95-19x19-evk.dtb'
> for 20240605-imx95-dts-v3-v6-0-2ce275ed0e80@nxp.com:
>=20
> arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: scmi: protocol@19:
> Unevaluated properties are not allowed ('regusdhc2vmmcgrp', 'uart1grp',
> 'usdhc1-100mhzgrp', 'usdhc1-200mhzgrp', 'usdhc1grp', 'usdhc2-100mhzgrp',
> 'usdhc2-200mhzgrp', 'usdhc2gpiogrp', 'usdhc2grp' were unexpected)
> 	from schema $id:

Since Linus has applied the pinctrl patchset[1], the check will pass.

[1] https://lore.kernel.org/all/CACRpkdbpL=3DHUXj0hFAo+JNki_R
A9aix2sW1cg13g9=3D89d93PZw@mail.gmail.com/

Shawn,
In patch 3, there is one minor comment, do you expect me to send v7
or you could help update it?

Thanks,
Peng.
>=20
>=20
>=20


