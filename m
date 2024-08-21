Return-Path: <linux-kernel+bounces-294748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C170E959200
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E231F23C50
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806231DA26;
	Wed, 21 Aug 2024 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jQwSWAwe"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013040.outbound.protection.outlook.com [52.101.67.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA2A55;
	Wed, 21 Aug 2024 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724202095; cv=fail; b=Y01oLdPQc1x20lvqTtnIU/6IiM44Ixnco2iz5t3urmCh3Q3EjYybFs7MfviQoY0a0Y7WjYUAJS5tvob4gTqef6jRe7wXW+RuUxXF8YL6YjEuHYtwbjKynyERpkeDeFoBZNDguO8S4Vh6LK/lBAXYp1aekTKrpNYwp8WECf7L9WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724202095; c=relaxed/simple;
	bh=ud5M6HwWx/G+y2166zpzF2jJiKllFaPtbcXdRkVhkHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mr9mnLU37hbk/BwcGOuAnaULqjFSNSOt9tViYJk4qVg8tCe0JAIUaOMpY8RXhCCI5mI3evPs/71nQTF+4s9UVugug8Umh4triVoMzIPEjUPKhhuOcBk4gU7TivHmUBNcYZeqRc5ju9GFg8q9XxbQ/k9gq4sOD8VISF/LdzUq8AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jQwSWAwe; arc=fail smtp.client-ip=52.101.67.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xi6zNqDtkrgyxBLPi65m/5lj4sCQqcyQ5rl5LpTSX0jQh7b7dT0x8vHH5MAUfV7e5JME8yG9nMAvvhxlHFBJRL/10qzv1asfp5G10kKFJrlnMTxeqlPSz1DnfWq7pM7zsmtR/zKFF27k0LlQSebl0kjiXxBCjiq/3OD3sAJW3WRtVYwcOKjXHKP+SXLWHF6KFnLVp6oDG7oyBOri3+kDDK4xMNhPQ9zckJObHKW+BmW/RVPk0Bcl1HRsKOLnTp20vEAKpO2senVe9fzbC7voriY8MRpicrO6jH7Co+SP4UU6EbFJ8cxUuWicKZKApgWkrMlgfeuarzlL2Wgy5WoIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEsEwqLaugX0T16ZG701ReZvqNGhk+Qc1pbLnDFFL4Q=;
 b=oQKzt/oGFZ3+pTiuV03eYCdQSq1irBldPB9LHs+RgNVLaWjvPDf13SHEV4fl1wOVjqWIK87w6jtZVtAQXyFRReRuWoQIIpNqFGkJF4pfV2a/zy+SREIAnenoDP2ejprduhyUBW+tmcE9jt6fC2zEbYrC+TRaz8v83tyGL9mRlYzPS8nTwHnZWRCCFQAZnMzzBrmexOqJbYznpJV738O1Y+3Fi2VTWeTp+AG8iPsZBX0Bk8Wgk5QqvGWv625/SdFy+dvQ3Q+f96jmMZWeCptacmyUAuYMhBSgg8nQ7TOJ9xMlco4tvT+zk+/PlJzgoGWTUzJHkHgV7Cr2rB31sb9f5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEsEwqLaugX0T16ZG701ReZvqNGhk+Qc1pbLnDFFL4Q=;
 b=jQwSWAweXR30YnCycO8e6xNSpj/VCgcxohlAMOalnkiKSFvQc70xzpQbwx+6EpHbCTB1RrnOdrWuan37dwdYzb8qqIkYLd85gHfG41A6X4/hvXB/iJtn6Co3YLJjmc9qV9aJPHgccNLDihC+BJmiwcXmJB/jTOxn713A2nrszrC26MmXVJdd1tONOjIuWzG8XljgxblYsCndiANdYP8jodaRCjkLoi/nfERTtxOUaBMxvLHvLw6XB9ol3tbckNyqCQjHCgVuRA2mJBb+LqlRzDpLit4eG/l/xxLgG3hYunnx50I+twbxKvjKLcyt9y4oAw4EELbFHDwBH2rcoeiMPg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7450.eurprd04.prod.outlook.com (2603:10a6:102:8a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 01:01:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 01:01:29 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>, "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:SYSTEM CONTROL & POWER/MANAGEMENT
 INTERFACE" <arm-scmi@vger.kernel.org>, "justin.chen@broadcom.com"
	<justin.chen@broadcom.com>, "opendmb@gmail.com" <opendmb@gmail.com>,
	"kapil.hali@broadcom.com" <kapil.hali@broadcom.com>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>
Subject: RE: [PATCH v3 2/2] firmware: arm_scmi: Support 'reg-io-width'
 property for shared memory
Thread-Topic: [PATCH v3 2/2] firmware: arm_scmi: Support 'reg-io-width'
 property for shared memory
Thread-Index: AQHa8C2aCnkHs0PaIkOBOegG7uwPcbIvc2GQgADqD4CAAIxr8A==
Date: Wed, 21 Aug 2024 01:01:29 +0000
Message-ID:
 <PAXPR04MB8459C55E5FEA010193F79C2E888E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240816224221.3256455-1-florian.fainelli@broadcom.com>
 <20240816224221.3256455-3-florian.fainelli@broadcom.com>
 <PAXPR04MB8459322CED779885532BD852888D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <1a486ead-3a65-4ef9-a562-c23ea7026b9e@broadcom.com>
In-Reply-To: <1a486ead-3a65-4ef9-a562-c23ea7026b9e@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PR3PR04MB7450:EE_
x-ms-office365-filtering-correlation-id: 8bb24309-0490-4913-37ad-08dcc17cca59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sUoSnddmbwuJCNOrAKxCIhSOl3I+bOwlDdjPzcfP72OEqk0WdnrAvPZm1z+S?=
 =?us-ascii?Q?mi6MM4ZxR9+H5EJGnxyhBc5pKFaW9MdE2pRwCjjsy13DW7EafLtsrGlTCrx0?=
 =?us-ascii?Q?nACB7mfVdqmZrxU749XoL9ZcgN3ihkcj/LZ2VXPDJ87lMldwRyeqTWcD09e7?=
 =?us-ascii?Q?AQ8P08GnYPbrJHH22x58clJ7brQRYipMRQAqoS9LhfYWnjWsgHhtNchX72Yp?=
 =?us-ascii?Q?ddAOWKN+3stY3GS/ztU+O1LYGzUE0xAgOrydK0tmEFpur/Yk6gU13NHJH/lM?=
 =?us-ascii?Q?BD0JESUFaXgV2ekE5DkjMVhHUNxG9Kq1noD+L2CshDanm0YEqxp9HztKSca+?=
 =?us-ascii?Q?TIzUsNetm+us24BaRvjjFyiyHNDllSCFjQ0gEVgoqiE7Sby9E3lbUurmMCo7?=
 =?us-ascii?Q?0FOs/3aWxAGe0aqmKOJW+NBSLxU7RLuoD+YEGcAYUQnLx8M/fdHbW1JqdRt8?=
 =?us-ascii?Q?zovU/knshP6rdBQ/tx6JYn1tcQFew8BZgxb9Nv4EEz0Ba102hxiYVDbU9tKs?=
 =?us-ascii?Q?/N70yJ2ZzJTL+5Jn2z1GKAq5tMcXR23r8eO9ODPv0VVQsZFZGKlljj7bxda9?=
 =?us-ascii?Q?cVkEgzFY3fkRNswpodIJYZP4FvkVaeIegxsSK3epbgXjI7Vrd44TnOwRbZx/?=
 =?us-ascii?Q?f715Xriz9w/agv5Tvpxrc6wATSZWtA754EntU2Cy+jdBX74mu81wwrXMpqtW?=
 =?us-ascii?Q?rRzDsez9idTzrhrcwDgx+TJejerJ7w31/M1e9hfpFcviTlP4XBefeJxNRYNq?=
 =?us-ascii?Q?hmDs70OtHHASokFNHHqj8RH1Y1oLTjyx/BWI4f5m2TmVOMyWkpWVbRJOGMoV?=
 =?us-ascii?Q?YxiUuPfcMTRbiH3tKYYXIz45SO4ocrUKpaYa1iUt1fWpYvAz7g6nMC7e6m8Z?=
 =?us-ascii?Q?ux4RgSYK5KGLI2Nbf1Dx+yAbqlSA514wmkbHC0ndSkpzd0d99tbemv+pw4hP?=
 =?us-ascii?Q?BwIXTrxCESiLUdofB1KUQ2TmWvvBr5qR5vYOh0fzuXVrXv7buQzxjVFKdLGL?=
 =?us-ascii?Q?1fMKu7ww/U0j5Fi9Tyw8ea+GZwHzZE8zSPyjte+4cBY0wC+wvZ5R76s+gV/u?=
 =?us-ascii?Q?FEgr67ETuqnlGZvrs0VraOQZIIoxyNff8M7BLXoCGwokp4z6/JYvCM1BDLtS?=
 =?us-ascii?Q?d/b+7CCavltXYJ1qgeHfkCcO3HBxzPPQQg0Qx9KW6+mdtGmoeNK8MXRQRjxX?=
 =?us-ascii?Q?6RHwSgzkLaqPBoLXZ7CQ6dkgIK4bQzdZMtVfiyvaFrNy0x+229Afdtk9tVh/?=
 =?us-ascii?Q?rs/ElwHWDyiCf0eZVSZTiTv6tsu7vff9Mg7kgMFb25eZPKwV/FME98GYHCIQ?=
 =?us-ascii?Q?gxzNot2KoYnA8DDNzjLnfm1Xos7hWePNd3IJ/VFtfxDZs1zjlItE0E6aiEW/?=
 =?us-ascii?Q?uSUwQHW87hfr9thwqW4zEGdj5Q+AI0d+vFmrPKtHXESymP/8Fg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QB6WExQ+J+unYQ/xA/cVUm3CUp8+Gdngt0ZBh56eYkV9tAJeFoStLLuuOktM?=
 =?us-ascii?Q?pWcTa2wXv4CARVg+A7xOklc1WUBfQyUE+u2mtfW9e502z7S9ZhK09yvJAaCq?=
 =?us-ascii?Q?uOaEm2+zOpmEpYHouq0uRdqRBc5PEzNdFwUNf6axZVG60R7dHerpjDpHFhwi?=
 =?us-ascii?Q?VRdvnAf55n6HOhTqw0w9vyrpuKK7002Jyz3Tf7iLHgfwcZ+bWYKYJpHTSMCE?=
 =?us-ascii?Q?RHdNpQf5BkLEvxVDuyCHTkM9ffXC/P3T/j938GN8GjGI/hY39hQ1fPfqVG6R?=
 =?us-ascii?Q?enq5VhV7p11ohlkc6qDabYGcYqVq6HQU/iCoL1Inf/gsyBbjDiYGJw8NPvdX?=
 =?us-ascii?Q?0YkTghTUGv1p5x06qK9b4RJwXtLGRRgK/G68QThKu/asPjFtgsO0JaFkPhrZ?=
 =?us-ascii?Q?3DghrOkkKWdMnDbt6SyuyEcZ/cXWuzzNkbYphBnsEv3cuxtQFHxIeUVvktvo?=
 =?us-ascii?Q?2FZqiJWYBSAJtgOdDQScJ8y7MY20m+DpNWG/8tgNzrC0kwwS8yzK9xZ6wnCs?=
 =?us-ascii?Q?i2DaIibd/i0IAhoRYrRnsmwA1F3DFh+jUxfFxQ8WQBsu4qCNoXTiIETFbd5v?=
 =?us-ascii?Q?CKxwMyQPlKMDGfyeMaWFRO5NBIdfGw/8S4/VUMCUz7yQOYDzrdcmUwpMIU6d?=
 =?us-ascii?Q?VAtppAV9yeYXF5GIBTezdY/fhTyLgNPSo9g0XGPBjIZv+M1sfT8lX3gOBXHt?=
 =?us-ascii?Q?U4HKlvnh1g7tfPBVRznUdQU41IeFYS7OuSOim6Y95d9B86YjFKFtbn7jdQVb?=
 =?us-ascii?Q?wM2X7Cfxy/OGjH1iSLwq2ghdhOI/AXyhTU+pkjwzyKiq8VZI7Ke05klJDKOj?=
 =?us-ascii?Q?hwf+yg3HjPrhXcD6nm17DghSQ8IsgjmRGQ2ALS/U0OnX4+ykuXxLypj2e9pH?=
 =?us-ascii?Q?vprnsksZLT4TJ6BQUHw3zwwd49KWIo9nmninP8twF3cVTcuvsagABgwGEnLG?=
 =?us-ascii?Q?rYsRRuJ9zg4IQ96a7KY41oOOyX5rn0sBJ17k4FTImoNE7hfISO9P8YisOIcg?=
 =?us-ascii?Q?Qw08gSE87kooN93l63GHRFRL14jFzexjapZVHus7HYdKS0Il30wrGCGcxCCc?=
 =?us-ascii?Q?rloH7TCKF2McvN3ogI1Tww+L4DdzwMBypvHig6Z2wE7n6i6ysQkMGPZ2xH6m?=
 =?us-ascii?Q?IyP4SAThFhndjW2oAyZQUZiiHQIAJev9kAurJHtClqPGDzofWNDnXloGSpa7?=
 =?us-ascii?Q?Ls4Vem02go1ENDbFDTlVnA3pJDNHcnnXY3TEctXEb2myy7IVoytN45EWQh7d?=
 =?us-ascii?Q?RqvFjRYSwjuTqmg71qcO4WrT5/e3H6PQo+sjTLoYYPFpCfZ1sFW0+62i6POC?=
 =?us-ascii?Q?t6HwUj/p4O6irWRnGtdA9FjiILJeqkmJOPfEHFxhUf7Axeq2W2vrbztVzqxp?=
 =?us-ascii?Q?5Y3XSAvxO36zrwIZ8pTivnTtVyjSnrAhDPcp+d5u2M8Bi9P8c5R5xxfEdusv?=
 =?us-ascii?Q?FSSES3iqk1TsPL4lTKrr4HuKARKYSI1pKJlPx8kNK+7idjHFgAz6X+ZrmR1w?=
 =?us-ascii?Q?r4HHuHDh9+rqug7t8cG+M7ZptS3VJCOHHQ00hWvM95HrHEE8E08bVSJmSkv0?=
 =?us-ascii?Q?S+1qCFh5ARGtuTSwGr8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb24309-0490-4913-37ad-08dcc17cca59
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 01:01:29.4541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xk3jarBOBkCKyl0h0tubXBpq7i6i2GyjUkYMMJL5NutCR2+1XIRjBcUarfjgFXMiXX6Kv6zoMVD3h8DwiyFBLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7450

> Subject: Re: [PATCH v3 2/2] firmware: arm_scmi: Support 'reg-io-
> width' property for shared memory
>=20
> On 8/19/24 19:49, Peng Fan wrote:
> >> Subject: [PATCH v3 2/2] firmware: arm_scmi: Support 'reg-io-width'
> >> property for shared memory
> >>
> >> Some shared memory areas might only support a certain access
> width,
> >> such as 32-bit, which memcpy_{from,to}_io() does not adhere to at
> >> least on ARM64 by making both 8-bit and 64-bit accesses to such
> >> memory.
> >>
> >> Update the shmem layer to support reading from and writing to
> such
> >> shared memory area using the specified I/O width in the Device Tree.
> >> The various transport layers making use of the shmem.c code are
> >> updated accordingly to pass the I/O accessors that they store.
> >>
> >> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> >> ---
> >>   drivers/firmware/arm_scmi/common.h            | 32 ++++++-
> >>   .../arm_scmi/scmi_transport_mailbox.c         | 13 ++-
> >>   .../firmware/arm_scmi/scmi_transport_optee.c  | 11 ++-
> >>   .../firmware/arm_scmi/scmi_transport_smc.c    | 11 ++-
> >>   drivers/firmware/arm_scmi/shmem.c             | 86
> +++++++++++++++++-
> >> -
> >>   5 files changed, 132 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/firmware/arm_scmi/common.h
> >> b/drivers/firmware/arm_scmi/common.h
> >> index 69928bbd01c2..73bb496fac01 100644
> >> --- a/drivers/firmware/arm_scmi/common.h
> >> +++ b/drivers/firmware/arm_scmi/common.h
> >> @@ -316,6 +316,26 @@ enum scmi_bad_msg {
> >>   	MSG_MBOX_SPURIOUS =3D -5,
> >>   };
> >>
> >> +/* Used for compactness and signature validation of the function
> >> +pointers being
> >> + * passed.
> >> + */
> >> +typedef void (*shmem_copy_toio_t)(volatile void __iomem *to,
> const
> >> void *from,
> >> +				  size_t count);
> >> +typedef void (*shmem_copy_fromio_t)(void *to, const volatile void
> >> __iomem *from,
> >> +				    size_t count);
> >> +
> >> +/**
> >> + * struct scmi_shmem_io_ops  - I/O operations to read from/write
> to
> >> + * Shared Memory
> >> + *
> >> + * @toio: Copy data to the shared memory area
> >> + * @fromio: Copy data from the shared memory area  */ struct
> >> +scmi_shmem_io_ops {
> >> +	shmem_copy_fromio_t fromio;
> >> +	shmem_copy_toio_t toio;
> >> +};
> >> +
> >>   /* shmem related declarations */
> >>   struct scmi_shared_mem;
> >>
> >> @@ -336,13 +356,16 @@ struct scmi_shared_mem;  struct
> >> scmi_shared_mem_operations {
> >>   	void (*tx_prepare)(struct scmi_shared_mem __iomem
> *shmem,
> >>   			   struct scmi_xfer *xfer,
> >> -			   struct scmi_chan_info *cinfo);
> >> +			   struct scmi_chan_info *cinfo,
> >> +			   shmem_copy_toio_t toio);
> >>   	u32 (*read_header)(struct scmi_shared_mem __iomem
> *shmem);
> >>
> >>   	void (*fetch_response)(struct scmi_shared_mem __iomem
> *shmem,
> >> -			       struct scmi_xfer *xfer);
> >> +			       struct scmi_xfer *xfer,
> >> +			       shmem_copy_fromio_t fromio);
> >>   	void (*fetch_notification)(struct scmi_shared_mem __iomem
> *shmem,
> >> -				   size_t max_len, struct scmi_xfer
> >> *xfer);
> >> +				   size_t max_len, struct scmi_xfer
> >> *xfer,
> >> +				   shmem_copy_fromio_t fromio);
> >>   	void (*clear_channel)(struct scmi_shared_mem __iomem
> *shmem);
> >>   	bool (*poll_done)(struct scmi_shared_mem __iomem *shmem,
> >>   			  struct scmi_xfer *xfer);
> >> @@ -350,7 +373,8 @@ struct scmi_shared_mem_operations {
> >>   	bool (*channel_intr_enabled)(struct scmi_shared_mem
> __iomem
> >> *shmem);
> >>   	void __iomem *(*setup_iomap)(struct scmi_chan_info *cinfo,
> >>   				     struct device *dev,
> >> -				     bool tx, struct resource *res);
> >> +				     bool tx, struct resource *res,
> >> +				     struct scmi_shmem_io_ops **ops);
> >>   };
> >>
> >>   const struct scmi_shared_mem_operations
> >> *scmi_shared_mem_operations_get(void);
> >> diff --git a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
> >> b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
> >> index dc5ca894d5eb..1a2e90e5c765 100644
> >> --- a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
> >> +++ b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
> >> @@ -25,6 +25,7 @@
> >>    * @chan_platform_receiver: Optional Platform Receiver mailbox
> >> unidirectional channel
> >>    * @cinfo: SCMI channel info
> >>    * @shmem: Transmit/Receive shared memory area
> >> + * @io_ops: Transport specific I/O operations
> >>    */
> >>   struct scmi_mailbox {
> >>   	struct mbox_client cl;
> >> @@ -33,6 +34,7 @@ struct scmi_mailbox {
> >>   	struct mbox_chan *chan_platform_receiver;
> >>   	struct scmi_chan_info *cinfo;
> >>   	struct scmi_shared_mem __iomem *shmem;
> >> +	struct scmi_shmem_io_ops *io_ops;
> >>   };
> >>
> >>   #define client_to_scmi_mailbox(c) container_of(c, struct
> >> scmi_mailbox,
> >> cl) @@ -43,7 +45,8 @@ static void tx_prepare(struct mbox_client
> *cl,
> >> void *m)  {
> >>   	struct scmi_mailbox *smbox =3D client_to_scmi_mailbox(cl);
> >>
> >> -	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo);
> >> +	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo,
> >> +				smbox->io_ops->toio);
> >>   }
> >>
> >>   static void rx_callback(struct mbox_client *cl, void *m) @@ -197,7
> >> +200,8 @@ static int mailbox_chan_setup(struct scmi_chan_info
> >> *cinfo, struct device *dev,
> >>   	if (!smbox)
> >>   		return -ENOMEM;
> >>
> >> -	smbox->shmem =3D core->shmem->setup_iomap(cinfo, dev, tx,
> >> NULL);
> >> +	smbox->shmem =3D core->shmem->setup_iomap(cinfo, dev, tx,
> >> NULL,
> >> +						&smbox->io_ops);
> >>   	if (IS_ERR(smbox->shmem))
> >>   		return PTR_ERR(smbox->shmem);
> >>
> >> @@ -298,7 +302,7 @@ static void mailbox_fetch_response(struct
> >> scmi_chan_info *cinfo,  {
> >>   	struct scmi_mailbox *smbox =3D cinfo->transport_info;
> >>
> >> -	core->shmem->fetch_response(smbox->shmem, xfer);
> >> +	core->shmem->fetch_response(smbox->shmem, xfer,
> >> +smbox->io_ops->fromio);
> >>   }
> >>
> >>   static void mailbox_fetch_notification(struct scmi_chan_info
> >> *cinfo, @@ -306,7 +310,8 @@ static void
> >> mailbox_fetch_notification(struct scmi_chan_info *cinfo,  {
> >>   	struct scmi_mailbox *smbox =3D cinfo->transport_info;
> >>
> >> -	core->shmem->fetch_notification(smbox->shmem, max_len,
> >> xfer);
> >> +	core->shmem->fetch_notification(smbox->shmem, max_len,
> >> xfer,
> >> +					smbox->io_ops->fromio);
> >>   }
> >>
> >>   static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
> >> diff -- git a/drivers/firmware/arm_scmi/scmi_transport_optee.c
> >> b/drivers/firmware/arm_scmi/scmi_transport_optee.c
> >> index 08911f40d1ff..2be4124c6826 100644
> >> --- a/drivers/firmware/arm_scmi/scmi_transport_optee.c
> >> +++ b/drivers/firmware/arm_scmi/scmi_transport_optee.c
> >> @@ -114,6 +114,7 @@ enum scmi_optee_pta_cmd {
> >>    * @req.shmem: Virtual base address of the shared memory
> >>    * @req.msg: Shared memory protocol handle for SCMI request
> and
> >>    *   synchronous response
> >> + * @io_ops: Transport specific I/O operations
> >>    * @tee_shm: TEE shared memory handle @req or NULL if using
> IOMEM
> >> shmem
> >>    * @link: Reference in agent's channel list
> >>    */
> >> @@ -128,6 +129,7 @@ struct scmi_optee_channel {
> >>   		struct scmi_shared_mem __iomem *shmem;
> >>   		struct scmi_msg_payld *msg;
> >>   	} req;
> >> +	struct scmi_shmem_io_ops *io_ops;
> >>   	struct tee_shm *tee_shm;
> >>   	struct list_head link;
> >>   };
> >> @@ -350,7 +352,8 @@ static int setup_dynamic_shmem(struct
> device
> >> *dev, struct scmi_optee_channel *ch  static int
> >> setup_static_shmem(struct device *dev, struct scmi_chan_info
> *cinfo,
> >>   			      struct scmi_optee_channel *channel)  {
> >> -	channel->req.shmem =3D core->shmem->setup_iomap(cinfo, dev,
> >> true, NULL);
> >> +	channel->req.shmem =3D core->shmem->setup_iomap(cinfo, dev,
> >> true, NULL,
> >> +						      &channel-
> >>> io_ops);
> >>   	if (IS_ERR(channel->req.shmem))
> >>   		return PTR_ERR(channel->req.shmem);
> >>
> >> @@ -465,7 +468,8 @@ static int scmi_optee_send_message(struct
> >> scmi_chan_info *cinfo,
> >>   		ret =3D invoke_process_msg_channel(channel,
> >>   						 core->msg-
> >>> command_size(xfer));
> >>   	} else {
> >> -		core->shmem->tx_prepare(channel->req.shmem, xfer,
> >> cinfo);
> >> +		core->shmem->tx_prepare(channel->req.shmem, xfer,
> >> cinfo,
> >> +					channel->io_ops->toio);
> >>   		ret =3D invoke_process_smt_channel(channel);
> >>   	}
> >>
> >> @@ -484,7 +488,8 @@ static void
> scmi_optee_fetch_response(struct
> >> scmi_chan_info *cinfo,
> >>   		core->msg->fetch_response(channel->req.msg,
> >>   					  channel->rx_len, xfer);
> >>   	else
> >> -		core->shmem->fetch_response(channel->req.shmem,
> >> xfer);
> >> +		core->shmem->fetch_response(channel->req.shmem,
> >> xfer,
> >> +					    channel->io_ops->fromio);
> >>   }
> >>
> >>   static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo,
> >> int ret, diff --git a/drivers/firmware/arm_scmi/scmi_transport_smc.c
> >> b/drivers/firmware/arm_scmi/scmi_transport_smc.c
> >> index c6c69a17a9cc..04e715ec1570 100644
> >> --- a/drivers/firmware/arm_scmi/scmi_transport_smc.c
> >> +++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
> >> @@ -45,6 +45,7 @@
> >>    * @irq: An optional IRQ for completion
> >>    * @cinfo: SCMI channel info
> >>    * @shmem: Transmit/Receive shared memory area
> >> + * @io_ops: Transport specific I/O operations
> >>    * @shmem_lock: Lock to protect access to Tx/Rx shared memory
> area.
> >>    *		Used when NOT operating in atomic mode.
> >>    * @inflight: Atomic flag to protect access to Tx/Rx shared memory
> >> area.
> >> @@ -60,6 +61,7 @@ struct scmi_smc {
> >>   	int irq;
> >>   	struct scmi_chan_info *cinfo;
> >>   	struct scmi_shared_mem __iomem *shmem;
> >> +	struct scmi_shmem_io_ops *io_ops;
> >>   	/* Protect access to shmem area */
> >>   	struct mutex shmem_lock;
> >>   #define INFLIGHT_NONE	MSG_TOKEN_MAX
> >> @@ -144,7 +146,8 @@ static int smc_chan_setup(struct
> scmi_chan_info
> >> *cinfo, struct device *dev,
> >>   	if (!scmi_info)
> >>   		return -ENOMEM;
> >>
> >> -	scmi_info->shmem =3D core->shmem->setup_iomap(cinfo, dev,
> >> tx, &res);
> >> +	scmi_info->shmem =3D core->shmem->setup_iomap(cinfo, dev,
> >> tx, &res,
> >> +						    &scmi_info-
> >>> io_ops);
> >>   	if (IS_ERR(scmi_info->shmem))
> >>   		return PTR_ERR(scmi_info->shmem);
> >>
> >> @@ -229,7 +232,8 @@ static int smc_send_message(struct
> scmi_chan_info
> >> *cinfo,
> >>   	 */
> >>   	smc_channel_lock_acquire(scmi_info, xfer);
> >>
> >> -	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo);
> >> +	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo,
> >> +				scmi_info->io_ops->toio);
> >>
> >>   	if (scmi_info->cap_id !=3D ULONG_MAX)
> >>   		arm_smccc_1_1_invoke(scmi_info->func_id,
> >> scmi_info->cap_id, 0, @@ -253,7 +257,8 @@ static void
> >> smc_fetch_response(struct scmi_chan_info *cinfo,  {
> >>   	struct scmi_smc *scmi_info =3D cinfo->transport_info;
> >>
> >> -	core->shmem->fetch_response(scmi_info->shmem, xfer);
> >> +	core->shmem->fetch_response(scmi_info->shmem, xfer,
> >> +				    scmi_info->io_ops->fromio);
> >>   }
> >>
> >>   static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
> >> diff --git a/drivers/firmware/arm_scmi/shmem.c
> >> b/drivers/firmware/arm_scmi/shmem.c
> >> index 01d8a9398fe8..aded5f1cd49f 100644
> >> --- a/drivers/firmware/arm_scmi/shmem.c
> >> +++ b/drivers/firmware/arm_scmi/shmem.c
> >> @@ -34,9 +34,67 @@ struct scmi_shared_mem {
> >>   	u8 msg_payload[];
> >>   };
> >>
> >> +static inline void shmem_memcpy_fromio32(void *to,
> >> +					 const volatile void __iomem
> >> *from,
> >> +					 size_t count)
> >> +{
> >> +	while (count) {
> >> +		*(u32 *)to =3D __raw_readl(from);
> >> +		from +=3D 4;
> >> +		to +=3D 4;
> >> +		count -=3D 4;
> >
> > This may not have issue, considering the 'count % 4' will be 0 and
> > 'from' is 4 bytes aligned.
>=20
> Correct, this cannot possibly happen today by virtue of msg->payload
> being naturally aligned on a 4 bytes boundary.
>=20
> >
> > But I think it maybe better to add check if 'count' and 'from'
> > are not 4 bytes aligned.
>=20
> Humm, what would be the fallback, or should we just WARN()?

This is just to avoid potential issues if there is change in future spec
That some entries are not 4 bytes aligned. I maybe over thinking
here.

A "WARN" is ok from my view.

Regards,
Peng.

