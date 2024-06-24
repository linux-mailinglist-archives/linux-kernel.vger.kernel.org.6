Return-Path: <linux-kernel+bounces-227305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8792B914F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E76B28362E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443A613E03B;
	Mon, 24 Jun 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m2Iu9YDW"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A15C13B2B0;
	Mon, 24 Jun 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236784; cv=fail; b=pA6bRTiGePaHg/6kgL+8WWxPkdDzhT2AY+LT1aN9T0NUbnuWzOthx0yIJGa5J6TxSD0R4C2GsGPaAsPVw5WqKBm2tuGe+Z8U1ZW45El4g4PzW/Zk9EKok7knyQfv4T1/n67RD1qVJ6fpFwG7Axaq/Uo6NRu/FV8yipkykhd3O5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236784; c=relaxed/simple;
	bh=V3t87TgXpfU91GLu/JrDwC++TjN5qd/n5V8wT9zfyZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eYqxgnAxTPtWOi7VF3+tzs82yMeCgSWk0CPN8kTMAu8/BLtxMy0JY7IMnnSFuQvEAW5hGLXuYQcYpd2m55AqHgeH2swY04nSahLGLMCiGPmR/L6F1DVQAxuKM6Yyk/I6A3k614z7zeg06liwoF32ssBBa5SfUttaD+AQga8vLOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m2Iu9YDW; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXHKvIskpVSuPA6hwx8cFqp/xYpy/+Acxsic9dB2IwpY6iZVO2ci4lebPV7sZzlJzbmal3bSIQ5yQnInEG/Mnuh+e/DBAv4WW6OBAgWtxjxHkA4N35s7tvAa7OJhvJ/6Cj1beRFamPD1EoXsUqc47+dPT5AJCzbPfX7kcTd4oIS5TUYtpzMssJ+JVTISVk18wRkF89DDTdnIK85WHYK6aKuGT6tyIfRpK/bxe7seYgFrCeZCTVwX8/Grl3zQQX68Dh0wpVmfXeKSh8rU60r+ifg0z5ZuTNaWxmpWczHt2nmMKueHnrotmylv/xcWm/IuYuDjHhaZquHpXCNXp17aOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVSOrgUQg2J/4HlnkeXibnoz1Yc9ByzfewjLCAskDsQ=;
 b=DtdZBseDZ1AbpP6m8Tw1K4Sl50tl+FtLGvDvqgQ8UaAbpZJHHKtNQqImAs+NnqNsosMvk5O+rncUPKmignwUN5VW5/0HQDLLJ25ywKZUoMIGK+/U12Z2+Rv5Z+p3QbrHvpfl00Is0zzKYFov2PcZyK5BAQ77EnCWw3BB9M15AhRcB5VDZ/hn4DBxIfMoUX24ydsKMA+RDezXBoS+EjHY63lUc+LSc562qiyjvz/1jt81i9ehijO155ei/n1pQtp3ycKdA9iCWO4ZLsaQx5QmmmJ8bYxC2ExKBeVlsJiSiCqM23wh2/OtBuRNdTc3BQuwlrPgGAu3qgormqJMzrDUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVSOrgUQg2J/4HlnkeXibnoz1Yc9ByzfewjLCAskDsQ=;
 b=m2Iu9YDWjQ1vJerokP2LwzhsMJGfAWCQ4GzKhMItnQkLsLn+ZqxaSIAqSRep2gRYt0JMhgSCqyf8YafFPiZVfws4YN5cdWhRAbSae0o4B/AnlLV05ME8hB4uaHbExHHvwEF6Cg5VWZnkBrNMjx7LFaMs4lIZBIAEIbZNeMyO5yI=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB7960.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 13:46:19 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 13:46:19 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Conor Dooley <conor.dooley@microchip.com>
CC: Conor Dooley <conor@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHawIiTY2uwWBJroU+O1Zn+P7i2k7HMKCYAgADPmgCAAGoQgIAJk22w
Date: Mon, 24 Jun 2024 13:46:19 +0000
Message-ID:
 <AM9PR04MB8604F9A6B01C3794CAAAF36C95D42@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-2-a7d28dea5c4a@nxp.com>
 <20240617-control-calamari-317f59c4eb09@spud>
 <AM9PR04MB86049915593D86599C67975F95CE2@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240618-antonym-tabloid-8f721ee752a5@wendy>
In-Reply-To: <20240618-antonym-tabloid-8f721ee752a5@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AS8PR04MB7960:EE_
x-ms-office365-filtering-correlation-id: 12115f92-f810-4a7b-d977-08dc945406c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|1800799021|376011|7416011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jzbDpYT2TczeJ0z8+ZRkbrtSnLFpyJZikgbbNz6p6K2jfqx5d9cw8iPYt0Vc?=
 =?us-ascii?Q?TwDGQQshtY5xXwl4/EdmZgdS3xBifPq4FJEUJEvuHMPKs0+tVAg9DIbOXubt?=
 =?us-ascii?Q?dshEAo4TrOM5XIiBc/NgXQX/sn3k//sNAV5yY8w4iE4FSTypNf+l4DmTAdHK?=
 =?us-ascii?Q?DUbg7QTyJPpHv0LqHOx40hwQS/jSmerJEl3FrPE4hHkZsx0hdM+A5Him0r31?=
 =?us-ascii?Q?qgUR11WZQPX8wuFYTvx/LDr4h5n9pODiahU7DNWmmj4QCm0H3o33ERbxU4mi?=
 =?us-ascii?Q?eVP+GWhBeHJAtDt1UXDiPjazJw6tkwYkdu3E5oBKHQEGIOh1EaWF0vx8TBcQ?=
 =?us-ascii?Q?sxmYkHEJHmj9hD/TU3WEBfqhTt15kvXBV7Zl11VQgXY0NKmRMU28C04LjUYw?=
 =?us-ascii?Q?CrLFPaUQjd/J3EKIbt+C67FVBpwQQIDsVypOaKbhW0cGObjSlkiaODSaRnO4?=
 =?us-ascii?Q?gNHPFSk1LX3PGJetcoDykfWQvmyt/yLzPWsB/KyTVHlCt5c9pSJeS2wEC226?=
 =?us-ascii?Q?2lZX5ub7FU8ktKOuLdWMyaNEHwSw61tZOCFO2neZOBjeCFZgdf5KJcCZeOXG?=
 =?us-ascii?Q?m5UEy9+tZem0s1+MQ78X4fGsHACR3Vck66pQ2EWz2j3cGB2Kqv7ateZq+9uK?=
 =?us-ascii?Q?WnK1Vw9tDmAFARfxH+M0FxwkvisYl6itZfBpD1Q6fNm+yOMfS8LFqrr2M/jQ?=
 =?us-ascii?Q?eRLUZt9IN+CMHuwBHZRxzJnFVhTdixhjJ9mrfgJQnLanchLBNK0XHmYjXhoM?=
 =?us-ascii?Q?pt+w5nrztl5mBtkpqXnF6JqFCDVGJBPWDAWlcad4T1K7w6Vf7tBnonkiS33/?=
 =?us-ascii?Q?MtDhYJNO/tMiMtqOIKPHcntaq3L59l1kAlhsXNHFFksI88mu8PIDeogQXI2+?=
 =?us-ascii?Q?TQ4esfUDU/+SeAMsLYXzRnzZrc0T5qc1NtxcKl5jgnRSpo6gQNrh80Vxae6e?=
 =?us-ascii?Q?37nkYpjYV7LUn+P+z+plHVSL2aJ97+hOcXU2X+2xWo0YCIh4YKEO/XOwk/jn?=
 =?us-ascii?Q?BIrdX4Ec4ewLM+feuSYv4sRCjKBjmXhLW8D1cOARZvs+eXytgWuMuYHh8T8c?=
 =?us-ascii?Q?WRiX6/UbHoBYWbzH4cF54NDeLwntFE3OI8x5p1Z83QaNhO58R7sodqt1N36Z?=
 =?us-ascii?Q?pe5P0JkiD7fN0jXsc18lnxYASBWz2duNZA9mmWmRlrX9Lzyn3fxgQ1Qn00LW?=
 =?us-ascii?Q?FKWimlIP6GqgIUAHUDz7v0JlbIzAmqGWV7fZG48WaJc8fNAjx3tCNK+YPBtV?=
 =?us-ascii?Q?AN5++cgcRvUyeBGzIEGDrDMUv3nMqJ4C3Au7LQfe3v7TP0291+3HG4Xqd7Fl?=
 =?us-ascii?Q?7A043ZIni6TIafI/x3YFi0Ya?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(7416011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YUd8uBgrF41r4lRDpAQqJlT+WxrtD8tULjY8oU/YLC2SNGFhERDkTT4RQZzV?=
 =?us-ascii?Q?6OtND35giKb6XNgWrr1Ku1MAHOZfxHsm0UgZErHNtPCG7c7r8rw+VbjFJ8KU?=
 =?us-ascii?Q?L50k7sbw5dqW3plUBh/N9G2yz4N2Bq7SpXSKuU/imbTmcGVkGF6MzrJ0JJso?=
 =?us-ascii?Q?RUbC8/nVd+Xcerc13np7Ow2nOR1m4sPQwkz9mmCFvAeWD5jEa1tmzM+MM3wl?=
 =?us-ascii?Q?w+oy0dJsGoNFNRYVfNGc41bmT42MPqcxr2A9Vi0Lho/gbXILkj2miT/qkpav?=
 =?us-ascii?Q?tWB60HNN265edixkh7tdCmz1gguVR/pEP+lqLCOvxzilZ5p2kQ4cBcozjg38?=
 =?us-ascii?Q?ymoL67mauUmP10DB9IuDuv2wt9CqwvpvKRNeU31XTvLh+RJwFBzQju+0aw/Z?=
 =?us-ascii?Q?DoxF/x0aEXB0j1ZdSXaNPiGPD6ZP96OgEBH3ZTOREy7qc7sXfNC/+sDCJtHQ?=
 =?us-ascii?Q?39TAfzf2RO3uW+oFjz3IWtmGsiAL9tN+uYIg1MYc8PO62xLQVG9xPsD6HoGc?=
 =?us-ascii?Q?Mj99+Lt1zrxYWDJf+sZ/zEeODfHkyUDvnEhVvLBkCXhcpeRmUZCCDVIY7jgE?=
 =?us-ascii?Q?LPsXjLIAZXB7/OpZkDuyVfp+6MH5KrrWNpnf2IfwLkz1HCHHVNyxOPLLQYnX?=
 =?us-ascii?Q?BA5GaOwb9NNEt3YNQmiUk472FPCOLMOUJFHe3BPfErRTuhgboMYva02zVEmj?=
 =?us-ascii?Q?2T5OeOmamw5q37KPrUkASr7oW0ACNlsTUDOpvoN3UwpJ2BTDyfmqkPlTwxhi?=
 =?us-ascii?Q?je+jNOaVK8QJVjRjYOJqGC/+9HrpeCNG/JIMzr0gcdidGIQbq9MCEaqQhgNS?=
 =?us-ascii?Q?Cj1uqdiJm8eANv1GfSRLTj4w7YAbvnGBtGgsnk512cd99DEC46Ndkm2sQQPL?=
 =?us-ascii?Q?CQJQBRuZI1xHOW96W2TgohCEdOgZd5cplEjy4h7Us6R6v5KvSxMkCTp0OW9F?=
 =?us-ascii?Q?ydp/OzaY2SSOkjLimM76liNEqAQeRchuZn9UgwBlCngfb2LOsmlYads3Rw4t?=
 =?us-ascii?Q?JJ8rU/qcKw2xc7+HEvaMOpySnUn765Fw5qFo48fk9R+nDfzgy1bIT2wgI/k/?=
 =?us-ascii?Q?S1r9bObdaXfCSbNf8Od5mwmxUUZmHq4UjUYdzBO9eN+vxR1CkZcYQ5AjXx6S?=
 =?us-ascii?Q?i6FPAtbrJsE0yE7r7lpq+9KjyVbU1WgED/cGgSIkz4jW1nDCARgs9mV8Rq/m?=
 =?us-ascii?Q?r99u3Q2XozWdnLL5LZdyCzYha1z+FR3B81UvcAGVKytQy21bVZ56FvB8lscK?=
 =?us-ascii?Q?Cr2/wMHVDP1okbgMIMRdgNI0n7A62f8FABz9zyFnaW97PjtcswmoYLox3EZH?=
 =?us-ascii?Q?F7GjIt9z0BqnNoVDdrogJTU1qOtFmqT1S9KOyTqt5gmUSxH+n5Br+QIfkXow?=
 =?us-ascii?Q?E+rLfP2BejGKjHp+M+fozmDzRkBj2Oxy/vVvGbYH5olChgxV26H+TiTK4Lk/?=
 =?us-ascii?Q?tQRQ9TepxmyFtGRUYOYv3TJOpBy6UXxTh2ljKcMtg2cgUFRi9PSdSQ0ldIF8?=
 =?us-ascii?Q?2toVY7JZfIy9cpxPUNNpZiasJdqmFZay8TuXnTpIRFrHrDh+xsvV5B50T2DC?=
 =?us-ascii?Q?fcBL5tQQb4JhyljoZcy0UYxfOqztiwrgvCeGqWAMjlERtSEGxiaunV/Zc4IO?=
 =?us-ascii?Q?SpVyVVR9GnKCEA2i7GpDHh4/bDFhneepLvl8up4qty+6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12115f92-f810-4a7b-d977-08dc945406c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 13:46:19.1384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYaxL+M9Eo8qCqcLQ+fT/CqpzGNNI/t9uJpRyl/VwQofzLkLpYicRcDYGjJHLUmAzXhtIq/45A8RKaNpOXR3UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7960

Thanks Conor, for the help.

Sorry to miss out this mail reply.

> -----Original Message-----
> From: Conor Dooley <conor.dooley@microchip.com>
> Sent: Tuesday, June 18, 2024 4:50 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Conor Dooley <conor@kernel.org>; Jonathan Corbet <corbet@lwn.net>;
> Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> Conor Dooley <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev; =
linux-
> arm-kernel@lists.infradead.org
> Subject: Re: [EXT] Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-f=
w
> binding doc
>=20
> On Tue, Jun 18, 2024 at 10:58:47AM +0000, Pankaj Gupta wrote:
> > > From: Conor Dooley <conor@kernel.org> On Mon, Jun 17, 2024 at
> > > 12:59:40PM +0530, Pankaj Gupta wrote:
> > > > The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X
> > > > etc., creates an embedded secure enclave within the SoC boundary
> > > > to enable features like:
> > > > - HSM
> > > > - SHE
> > > > - V2X
> > > >
> > > > Secure-Enclave(s) communication interface are typically via
> > > > message unit, i.e., based on mailbox linux kernel driver. This
> > > > driver enables communication ensuring well defined message
> > > > sequence protocol between Application Core and enclave's firmware.
> > > >
> > > > Driver configures multiple misc-device on the MU, for multiple
> > > > user-space applications, to be able to communicate over single MU.
> > > >
> > > > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> > > >
> > > > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 160
> > > +++++++++++++++++++++
> > > >  1 file changed, 160 insertions(+)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > > b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > > new file mode 100644
> > > > index 000000000000..60ad1c4a3dfa
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > > @@ -0,0 +1,160 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> > > > +1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> > > > +
> > > > +maintainers:
> > > > +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > +
> > > > +description: |
> > > > +  NXP's SoC may contain one or multiple embedded secure-enclave
> > > > +HW
> > > > +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> > > > +  enables features like
> > > > +    - Hardware Security Module (HSM),
> > > > +    - Security Hardware Extension (SHE), and
> > > > +    - Vehicular to Anything (V2X)
> > > > +
> > > > +  Communication interface to the secure-enclaves is based on the
> > > > + messaging unit(s).
> > > > +
> > > > +properties:
> > > > +  $nodename:
> > > > +    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
> > >
> > > Just "firmware@<hex>" please.
> > >
> >
> > Modified as per your suggestion,
> > -    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
> > +    pattern: "^[0-9a-z]*-if@<hex>"
>=20
> Firstly, that's not even what I said verbatim, which I could understand. =
<hex>
> isn't even a valid bit of regex for this.
> What I want to see is something like: "^firmware@[0-9a-f]+$"

These nodes define the interfaces(-if) to the "secure enclave" FW(-fw).
Will replace "-if", with "-fw".

There are multiple NXP IP(s) for secure enclave(s):
- EdgeLock Enclave (ele)
- Vehicular to anything (v2x)
- SECO (seco)

Having "ele-fw" helps identify the FW IP name.

Will it be fine to use:
-    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
+   pattern: "^[0-9a-z]*-fw@[0-9a-f]+$"

or

-    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
+   pattern: "^[0-9a-z]*-firmware@[0-9a-f]+$"



