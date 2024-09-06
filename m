Return-Path: <linux-kernel+bounces-317989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580796E6C7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E9F1F23114
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893601BC20;
	Fri,  6 Sep 2024 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="COJTktD9"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013021.outbound.protection.outlook.com [52.101.67.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E0BE65;
	Fri,  6 Sep 2024 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725582341; cv=fail; b=GyE0WXXxL/232QMUCLFb8JGAFjrB9EwZlss6ysiCmvgePLGN5DG11tGbkHpRJCjguWbWuwXOWnf7GlIfhyl8+cQGCpHQfFUXL4/3naWpuoRGA5IWNi7NknIlYnI7xLO8pI5q/50tkWhJejkRuICcr5vY5Sv9cm0OsS0yGzbjX0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725582341; c=relaxed/simple;
	bh=44prLi4MEE1/srBgLhr3McMrsQEYsMc3cewUBD8PHuo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PApPsacu+vBgCF1jIdx+CRLHPU5lZqQFysFJ5KM+sp2vewEXnZW2oWI9QdjciqBy6PQcLxbnBMHWxYKWMrwlP6KKU5Flus7swi39jDIJHSRukXWR7j8eAbAy4XRg6dGn9XDQpRyuAZXwjn7iEkfDFnq5JXY1IxCfHL4DE+fFpUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=COJTktD9; arc=fail smtp.client-ip=52.101.67.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yP9HfZgVamdeOVrL7OTbqTWfYv0o8xN+OXdni80jYYlIFWRNdrcupy8Y9YSLNsXJW9CABKIS40LZK58z3wEUe82wpl3DrZ5P7RVkh8QlRv2hh58cfqATDSDarxEOQz17dHFGBc3WTyXM0CT598914AaSXVAl0gkXNhqiutvvYgqvUGmDu6ZVLb7jINfVcAVZHNP9Om8OprZilCGAJHccYEd98t4KzzGNREpQyjIjZRgS1kOUzCStEF/laYlqAODndoT+0jzoU1IZqhHLe5PO+P4lJhS20dCA0amYAo799uKz46AkLfvc61OrrqB4As1Bs3AI/Jc04bBMpw1T36jVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3HN5KPFFEyEsF8B7clXN8DEU4DfXKLZ2pYcIq7B020=;
 b=Pujp7iLnQVq09qQ8Mx/oNTZNtOh2EwNP4p9HVT+bGyOw7vRErlYUas6pAzO508JVpHqBmz3acBi2o7kQIzAHNnOlJutN4vN05UvqdLDgRidQY0z+SQUGS5SHIaCW2fpkmvpQYi6FELRTnHaAaCu5Q5h64YgnlXUgCXyIdczW/K0inyPiA+pB6baf6zHsjRM/AdcHrqPPQlghbpQ+6a63Hz/RYJc9xw4CyjoiHjt3jMdzj+UP+WMnyNUMLLvVPwB9vD4rOk5Z/D4iDl13O9eFsubhET/E8iKUgIdtik52cOr2zE6Pa4q2r3RulgmpNaEmwVfkBzjfEWj8lGnYUxAAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3HN5KPFFEyEsF8B7clXN8DEU4DfXKLZ2pYcIq7B020=;
 b=COJTktD9Q2+Xb8LMLYU3xPcx17rrn+TOID9F6euT7XCYcwxvfQ2RSTG2PvIqMRY9tZc/24AGeOfarzE+YUVQrZhNFBroN0BlgKtEVVzLvNZJ/9VX4nIIpURZkNV8ZWesn7zkYKcUufwMA4EziKp75KZN7oa4bIVCP6+dvb8d3xD/BXvqYUx+jDU/rPPDB64PQymZKDz//EIdZ01tw5Po0rLLTk470mmcLbF/TVrppjN4k1yUcIrd9rnqVbSua/UhGl9KNDtEu/+/hzUVOqCd4/5iXliOJcDY4FiyJVBu/kJzQSpL09oiZ1/iOBymx9VRavi79geGcBIigXfkcjMZjA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8288.eurprd04.prod.outlook.com (2603:10a6:102:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 00:25:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 00:25:31 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Nikunj Kela <quic_nkela@quicinc.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@quicinc.com" <kernel@quicinc.com>,
	"quic_psodagud@quicinc.com" <quic_psodagud@quicinc.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH v3] dt-bindings: firmware: arm,scmi: allow multiple
 virtual instances
Thread-Topic: [PATCH v3] dt-bindings: firmware: arm,scmi: allow multiple
 virtual instances
Thread-Index: AQHa/8/6VwwTiEy0F0Cp8zYKcM2FCLJJ5sHA
Date: Fri, 6 Sep 2024 00:25:31 +0000
Message-ID:
 <PAXPR04MB84593380F220DEC7974058D9889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240905201217.3815113-1-quic_nkela@quicinc.com>
In-Reply-To: <20240905201217.3815113-1-quic_nkela@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8288:EE_
x-ms-office365-filtering-correlation-id: b83d93da-5b12-4546-0173-08dcce0a6a7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jYcbliQGhNcDc7UDHfThXexyMJG87saALKQ5cNVOpETC1CpECQPlpjqFeNjN?=
 =?us-ascii?Q?sDAs7FgRbIpmPweKXy7jwxkLCKcUwZGQUuA611DbwvztsvV6rQ1NljIvJXn5?=
 =?us-ascii?Q?Aj4nyq3soNFdR+e/kjL+EMlequQ1I5T7WD7HyYuGdsZ6gMjJerFes8Wj9/xO?=
 =?us-ascii?Q?huAwqYNg1TXriTfCDjW04PLHF9cpvInfLpmfqDdBZlAcK0qIMwE+SX6oDNj4?=
 =?us-ascii?Q?LjeX9e6oQIKv+E8vcXJxBzsAyKSKFQxB3Y7wkTOtdjCneaqlF2fpL5S2/ldb?=
 =?us-ascii?Q?FwwDfEqrEMLCIBc65XR0IajJNbpqevjf+u7HgaoSt3Pns+yiZ0CKjwVGHK7t?=
 =?us-ascii?Q?a9c97de43e4etU3eI8NWcbbyxk96D8pzAmyU8OEnqdydbLYaLxHD8wa5hQh4?=
 =?us-ascii?Q?p23cmuKyf3BcTfUcvhtEuy69o1mLjOtj8zmQiLCXZoP4/k0pzHHRYwh7aQUP?=
 =?us-ascii?Q?QvN5lds3sZbV23wXLyysMDvWAl4yAqShnevi09uhYE3nkox+n6Ww5rhTAple?=
 =?us-ascii?Q?abmMBlV/eMelPYTMsqgvjMnd20DDCryJVNfWHoSUfUXyomT1C40Z3HSThYTD?=
 =?us-ascii?Q?2QZaNCP33tjWvMmQm/TxwAVCnGG1RltAewWVLvEtgE2AOeCNMsfjpbEufCKh?=
 =?us-ascii?Q?70sHQXo2ci+jp4wqo6H956NkQXlFOZB1fDZgh8/gxhAW4yTXKc3qOaDdXMuw?=
 =?us-ascii?Q?eHymS8CrNX+6Jygaq4nelUnu0AyEYeTPczLHbg+lQIgrC94TI+PVSJ0yKhmQ?=
 =?us-ascii?Q?9M5hTHbuHTRzeKM+k70NmhukxWs/59AmMAhRBeRHgaili2zG92XW9ygqlqg0?=
 =?us-ascii?Q?NQveU1ks4S854q63ZJy2CfTeoyaLZDYJcB9pqVAJ2cJwhn9M/vsky4S7voe8?=
 =?us-ascii?Q?iOHjhChV5VRQPCceV+edKr5lhdnEBpU1yQkNMWD3PRVZqS7C/RyZect1h6Do?=
 =?us-ascii?Q?74Wvp5l06/0x2qbKUPMcG34I3o4r2E/nA0C3Akl5zDexvj18XRTIN/FkPfn9?=
 =?us-ascii?Q?Sg1RyH847PUoahJU1+FHt4kjqLioj/vAT1oQcT76D+pxJdBd/TebyrL9rOcH?=
 =?us-ascii?Q?A7I+XpvJ1YiBzL8JCgiH1rLt7cxajSNnT24cDd0LrGKy12/hU0+fojuHtRx5?=
 =?us-ascii?Q?nvIK+TPVQ+MhG3ZqjJA7eoDAsD2HoP86R3OZZMPhk8wsJA8A1+zR8nZouQpl?=
 =?us-ascii?Q?CgFZ0ZjplGLE7gVhvQBRw1wjAn6VDRhwyrVt3r8RcoPJuzU3uNWN8s1CxmOM?=
 =?us-ascii?Q?J+vr4XYVqxmGizqS3y8eoXwXgQAQOIsfwd6KsLXuqcyl1uwPGe99hgFufINe?=
 =?us-ascii?Q?aQTQ9N17JLTe3RDwGLbAlbHdZmPDJ8YYcDRmVAIquy5TllxV7OvCRuyP0beH?=
 =?us-ascii?Q?qKcouK0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d9oMmbjEnYDffOeJRpPNHNuWRWfGDw98KNU197nCH9YlFzfXgchE9G6C+khC?=
 =?us-ascii?Q?hk1qYdniA1EATf9JGXEqEiwytW5GYIFqq3YNTwdiRjvp6FEys9zLIyJrDqKC?=
 =?us-ascii?Q?ql4amfIRKfk3IBJVGnEtZJXO2FLxtmOoXs23tEvCmRb76NDdAzGK/SkiER1A?=
 =?us-ascii?Q?oLitwfzWuiUYcQu9VIyB4u75lTdlxF123OV0PWbH4uxWXUjP0HQcMfCGvYh0?=
 =?us-ascii?Q?Tkx6p7maNcF2rS/KngN91SriHJXoYcR91HY70f1KDVZ5wV18lbcuLPQmBvwK?=
 =?us-ascii?Q?RiQfPDp+gaiQHmIvl4gfg+HzH/OfP3MTPR6vRw9pIOCzd66BY2d37PMfqnwn?=
 =?us-ascii?Q?LU4DcTSMp/EJ0SZ0aswDcmyYlHuappcFEKbz5cqiR4B/cj8piFDYgEKu91zA?=
 =?us-ascii?Q?oqDvLvWdOFOtAE9Ai84AHsxV+3yr4dOBeZ0EwppPWVLlEfhs4O6GGQ+6Zkcd?=
 =?us-ascii?Q?hikMchWwU3x6hR2YlAC3iV65dCw3ImdMumV9eJKl6vlqFuPGhBBdcI6kV/RM?=
 =?us-ascii?Q?vfK2QVy9v1d67Bj4Unmn4C2Q/nn1dfaGVZrDP6doCZiGEnRbLywIjy/L5YWc?=
 =?us-ascii?Q?/60XoSpCjEx9i23xDMzX90Kg4qhvOi7CgBi7FJu/iQEs/HttGMYmUX4hP1cp?=
 =?us-ascii?Q?w5XLtO7OfQlpUmzNX3teDa4VR4q9qGgX1XQRQTA87MB5pBYG83aBMBcmn8G1?=
 =?us-ascii?Q?icGKX5+UaGz/BnnSc1HzhBfX6EzqA6VqtqUca8gH71iPRJQJCH2c27zuJoXk?=
 =?us-ascii?Q?4Slx4F861PIckDS7MZEZEzBmPgHc/P4Hc8K6U4HrETza364Zf0HcAtsiQau3?=
 =?us-ascii?Q?dnC91mVRKbHPYEB518moQ2wnjd0926UGJZ03Hue2WBN+hNoorLGeLN8nSrwu?=
 =?us-ascii?Q?Ra3C0Pkz0N/2VA7tdOtZi4YBUDNFoP4IqW21jrtmJ1BeVdRffeJXacsCqTuj?=
 =?us-ascii?Q?zSKe3DejDLDhUur+rKaSjdJu8TNqETGwePLusJobq+afNICyq4lMzUKTbfoX?=
 =?us-ascii?Q?+emwLOKszod+C5zF8F+HSd5XYe6z4IhjiqzAgmwCgflTKUw/qqySpSgxEcAR?=
 =?us-ascii?Q?xAVYkq4AsjqfsIAshQY83fKKDfk4HjGofm1SRytrd0Ye/wDDPg2NpuU4SUS1?=
 =?us-ascii?Q?8a0AhKbPHgA5wlCL8SbRQFvcJ19A0PjFMhvRrpCdCghIdg+2stKG9Kmuw3je?=
 =?us-ascii?Q?sKOsaPgejmi20SBf0DWNwsVMB8HNWhgDLNkb0DpgphEznk84HlW43VahlPtS?=
 =?us-ascii?Q?E1F+USH4Gfb0zRezVPFbVFFm8kz2jno1HNtrQo/LE4FX0cUmWCe1m80xtvft?=
 =?us-ascii?Q?q0uEBMcpZY/l8RxWYFq8SktaQjxDKdIWUe9bdxIVffrZOCz6LQqOlO1sNJbE?=
 =?us-ascii?Q?vALKREISMvlq1eALhPtNbtKRUUk3qcR4sf6ejHvimmGgXOAqevd57mer9gqq?=
 =?us-ascii?Q?LurxdkcqjU3tiFlpnDiRxY+kr1gkesnAGSSCcaIj44dZmjc+GGVxwh6Frkle?=
 =?us-ascii?Q?nf4Eyjf4oqkUUA9kWRdeItE1potvHg/17AiVsCCv6zVcNm50cqqV4/6AOUlr?=
 =?us-ascii?Q?LXSMGQXBZdzeT1lXsfk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b83d93da-5b12-4546-0173-08dcce0a6a7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 00:25:31.1258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrHVq25gUOXHa2rRMYhSiL2W2MIN5T3UiCRv/PUaWw0WHNj4S4Grhr7Lq5HTsEFZFLjAnGDpw4p7PYLgvPVWDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8288

> Subject: [PATCH v3] dt-bindings: firmware: arm,scmi: allow multiple
> virtual instances

Just wonder, what do you mean virtual?

Thanks,
Peng.

>=20
> This change extends scmi node name so as to allow multiple virtual
> SCMI instances.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
>=20
> Changes in v3:
> 	- Added Reviewed-by tag
> 	- Removed the patch from original series[1]
>=20
> Changes in v2:
> 	- Fixed scmi nodename pattern
>=20
> [1]:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> lore.kernel.org%2Fall%2F20240903220240.2594102-1-
> quic_nkela%40quicinc.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.c
> om%7C350f57ac3042490bed0808dccde71b35%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C638611639683033003%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DzYYNSdVovTG
> h5BBUqW%2BRNyxoO7EXrUtTppk4MiywowU%3D&reserved=3D0
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git
> a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 54d7d11bfed4..5d79b15a1610 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -27,7 +27,7 @@ anyOf:
>=20
>  properties:
>    $nodename:
> -    const: scmi
> +    pattern: '^scmi(-[0-9]+)?$'
>=20
>    compatible:
>      oneOf:
> --
> 2.34.1
>=20


