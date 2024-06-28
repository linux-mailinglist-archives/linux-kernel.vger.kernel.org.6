Return-Path: <linux-kernel+bounces-233211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DAC91B45F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9BC28430E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1DA17556;
	Fri, 28 Jun 2024 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZLPdVCZH"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB9125AC;
	Fri, 28 Jun 2024 00:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536393; cv=fail; b=V2+LxCxw/bFAyEmyUZTyXkkVCYQAGE7sm+y3kgfVBg4zAS7P8sogy27T8xTc28cTULUZ5Jh2q9N73hZI42eZTRbpvoK9K4wsP3KZ+VZEAilMykfS3yjNgegXdwGcSKfobzl5gXG9fvZT+JEob1wwBblshut9UJOg5buAIL+ELfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536393; c=relaxed/simple;
	bh=mADTsOX+yf2waOl9cljMNnpftU78Q4JOAhqIxnrJSJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hGiEPUcZYd+aXs2O/58q/sIOe1gIzo67PHLqb+hdXMpl+o86uu2QWfePoiTsivVn7+h7ce+GOICU7QzZKxOb7DKwXPJ+QLWw5MJurLMnXcIgyWbb71nZwqniq0uAVLZOyuojTc2hTIxZurCUtgO220eoNwaOPb4Eg6Gq5h1f6Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZLPdVCZH; arc=fail smtp.client-ip=40.107.20.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GP/feqvhhv7lOwKhm6WjxIg9ubidKa8N5VXMKz/VNLiIZsQPHIIA6xCKpT19GzPCC5Td0fJF9K+suvJDTZYi9IkOrZLO0TtulsZ1J7afT1iM6m5U3qGFZAKZ9xL34x/445bGsH+Fo437XfVnnKo6QJckmltqDNtkIoOkvEDRArv+ZyyGAbvc99kgvCtvDD7N1ZAmrKoRI6vnmudKejfT3iC1gr9mROQahsQ+pRoXAZVXhNH8AlXHvWzH+61FhNYBhuN+YTklulyy2bEeu05d11Oia8Dc0nsYRjnRu+SmFDrppNTmTV4uK//GXXt9aTq061a2fJf5Sb9bj00rgASmDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mADTsOX+yf2waOl9cljMNnpftU78Q4JOAhqIxnrJSJs=;
 b=Vw3VWXzWyUJg1WeFVnp7xk7MDbKQEsBuUwmzFv5S9+83cNsIxDWoZ0SpObAqHujtSOEOrHP5bVqHRnW3qKcUULp8BmK0jrioTlR+b6dDUkIEYNnp+UVhYGA5O2leoRdMiuVFUWhBMI5Nh9uMcVeI12gLJZnxh0QvKr8uoS6klTLSLV2cts4qduaLf6bTjoWsLOi4zt8tkaM7RELBFClOdmWafZvUBuUoDIruVDIpVAmieetDDnpjTVj50+UC96aJ53COYY1NbNxlIEazSHh+7iNn2kUap71FzNv/m95kPjgNjrHmeVVv82GJTTwe5Lc8xk0auQ5h4LOwZ/tUAHCJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mADTsOX+yf2waOl9cljMNnpftU78Q4JOAhqIxnrJSJs=;
 b=ZLPdVCZHVV1pWTZm+RqOa/KWNT5XlGIJyIjnQJOpQj8JgfC8DPiJPpw31x/CwWa/2rizmOSaITg6o9KhXF2l/zmCNN/wCvfjoYG3kZiGmBFToBYWUMT+rvLxbc00EhiMGrhrc883waKLzu3YvkdLxyGF/nh0lLydG6OhGFBx/V8=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAWPR04MB9933.eurprd04.prod.outlook.com (2603:10a6:102:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 00:59:49 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 00:59:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "open list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 7/7] arm64: dts: imx95-19x19-evk: add pwm fan control
Thread-Topic: [PATCH 7/7] arm64: dts: imx95-19x19-evk: add pwm fan control
Thread-Index: AQHayN2hHsBSu4/Ql06sgFiypv87f7HcWwuQ
Date: Fri, 28 Jun 2024 00:59:49 +0000
Message-ID:
 <AM6PR04MB5941A14C59816F435D6AEBE388D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240627220001.692875-1-Frank.Li@nxp.com>
 <20240627220001.692875-7-Frank.Li@nxp.com>
In-Reply-To: <20240627220001.692875-7-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PAWPR04MB9933:EE_
x-ms-office365-filtering-correlation-id: 9f9dfb7f-8c9b-4a85-5799-08dc970d9c55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zI9bC5NKFspnhgWbfn7yvjyJOdzQj7raPGayRQqjtiLUgobqJMVEAjPqinjC?=
 =?us-ascii?Q?kRTi4DXJwPx63IDnaqcA0uEJp5XXd5dMLeDKGrVaiPftIbyEYBsugqvUVMyi?=
 =?us-ascii?Q?hmzhgmalEPItRLjYDojCe8nJ/Y0y/7xjHrg1X3O6Cagp8nD50AAAuoXXpzrE?=
 =?us-ascii?Q?uFiP/enws3hHzh79QnOFOEnE2SPl/vUJzHq2G1XPvq/+CAtSR5mYE7v+M/Rs?=
 =?us-ascii?Q?mkbWIZWF6Ajpho9wrYY1WIoQiwqcZ4uHMG2RJDAf9YLI32BRxmCZZy2ewzjc?=
 =?us-ascii?Q?FOlwytIPBEkdqUT6bftOcit5GiKQkyxegTdkTj3eVyv5Wg33mmtEPQNECusK?=
 =?us-ascii?Q?edCHHcGvsItDvzS/Tx0tA2nFbHkyqPL5wgysLbHeuQVxw77gNeTFvS+7krhC?=
 =?us-ascii?Q?5WYz/hsV1p6oywIWMqWGzzrcXd1iLfK7+8O8Lvy5wVn6ANbGfxw8vijSoanq?=
 =?us-ascii?Q?UA3MZfBLjc2TKoHeshfQz6SNGU3IaSNyL3eel8cJJmXcq91MDCz6SS9HPu60?=
 =?us-ascii?Q?+9uY48JSGosZ3huE8s+6KBN9TO+edmI1JceYwx40UJrBDnR9332Nx8h/y/h8?=
 =?us-ascii?Q?YeVCjsSJtzBm/NeOAbUagvoN60VHcECPeMUqc85I/sILHZPIeilY83CVmfZE?=
 =?us-ascii?Q?NTFu2yye0o2AwOwa5531GPQ50dpodOBzx0+uOXQAzrEsJdB0+y/bOLieoiOd?=
 =?us-ascii?Q?htnelbInpZlMuZm3nJVhu564IoDmqwVnefyISD+AD7tonYCFiqKZ7tKiEP3e?=
 =?us-ascii?Q?3RzgN9jplZ69yj9c7j6+NthHoE1gxpS4eQ0keiMQSdGWNMFjosbdgLwTez6c?=
 =?us-ascii?Q?WV8Qlzk4TqvmloKcLfbgUlrIp2P8imQj+SxVTFT+tKlkEdNnOePveGJgHC3+?=
 =?us-ascii?Q?EYyYH1PuvWB4Kd6RswnveJ7+33XvLyeSwxq8CyfYQc1B+aX/74VXrkIw0cR3?=
 =?us-ascii?Q?yyGmRPBmHZRJm3KSrFAtqqa7Ho4d4EpalDwH94LDqb6E+6V3XQa2cJ9twWCy?=
 =?us-ascii?Q?lV53ApId3FH0OqL1sHwspNanIXR2PfucQxEED2hNkAuAY/dv5xU8G4I30l/Q?=
 =?us-ascii?Q?mhk4oT/aBL1/+9Py8n6aCP78imBhH+0ADmrHd/KRA+rZ9gEFJ8sjN563ZfVu?=
 =?us-ascii?Q?AsRq7CvYhKfjZTjxT4yRExXSmZoOMxvym93Nfu9oPogiu4PzInBNXiRXICf3?=
 =?us-ascii?Q?FushafI4B2YYIr8iJTaoutHqMbIDjUZJr+tawUVYSUW4ynOROeztsKKIFPtl?=
 =?us-ascii?Q?dsWGiAgft2RfPIPh+jSr16lont0+5NjYmtZdhZtv2c5ySN4DRP3M8Ij4c6QX?=
 =?us-ascii?Q?xnypxKXZkPu4Js7vV974a1vAhT5uM61ECghnQqvS1s1o1sz0gijpusNiH807?=
 =?us-ascii?Q?f7YLpo8JSrlDZTrq2lfODwr6wU2XNlVgyzpgwzKLXAddDU83SHF/TqVDjn/I?=
 =?us-ascii?Q?m0MR72F/Dk0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ngCQ3s9TtNfIeskoGuEh9WjJD91HKE5adMUb4ZCp6MqJT443YJBrL30+z1xW?=
 =?us-ascii?Q?64lMV164U6M448llpkQcf+MW3M/fkUzP9bPpury045fQuYbboTSryzZNKLMa?=
 =?us-ascii?Q?JeFL2l+Oe1/0HmhkRjDTUzFnnZIEzApggigCFshZw8Es8HpVrKDebtJcj7Qw?=
 =?us-ascii?Q?5u6RqpKok42MVYUa+9RoDU0Nd8Lnw1hKg1gme6EUHUenU/08k1kkVu44uXPc?=
 =?us-ascii?Q?FEXblo+dbzSuhjSBgvoFR5JvSmnrmnEair5s9o1CBtfCxwsH0qSZE+KDM5Zi?=
 =?us-ascii?Q?5GWAwFkZF7OCHgxd6l9wFTdCeHjoFiV0YD2rpgwrK+FMzecsbIdsBTMH4clj?=
 =?us-ascii?Q?CdM+FcSdIqb2AxBU0WnmkidvK4ldE75x1Ph0k1ZPZcBDPYM4dKVUrYg8NKzQ?=
 =?us-ascii?Q?t6b9/4140mBQ57/ZHWovzEqMp+JSnULHUhhQFGBCuTejYnV/yhP5M3hlNaTQ?=
 =?us-ascii?Q?tcIdsmgVvQW50wCo0PcqyZuRpOKDUlRytooz2wpnwJj1CqoKJoOO1Q2uI2Wf?=
 =?us-ascii?Q?6QaJSENUm/o9b3BGe9mCpoqDuUWYEFFnCEDdY2dC1O58/G7/YHu0gQkE/Yai?=
 =?us-ascii?Q?YSFhe9OKBajXGvjkcrebncE3f/tlUiID2q5QsPbDnTMHpJ4ETOw7FDlnN28e?=
 =?us-ascii?Q?B1e5ak8F22Dg+GEMnP5EyLiDomYncm10d7qgvhL7gYYMyZULbBaXBvhUi3sI?=
 =?us-ascii?Q?lji6uW9yqqfw88v696gA5XmiXA2q6mVzYES/kx9+tOFbtX7kPVxGh+WDN8nI?=
 =?us-ascii?Q?UeRqvfayGH7olXIgZm2r8wfovU3IBNu57h6aEoJKxjWu0DCM11iHysFMj7gw?=
 =?us-ascii?Q?iqhlf6f5QefDzYlBgB4YUK4qAb/i9r2G1XSBppFoElJWGhQWjuUCA6qr1NH7?=
 =?us-ascii?Q?BA7DsL4v4r6BmbdyRZxLg0+qz/YW1bS+rXdCKDQI9siFc/JY+hdIISm2k46P?=
 =?us-ascii?Q?BKfsqp87RyQRPc+XewyzuvW0VR24fEqhQNZWGYX/Wyse8Psdrliss3qXJOfW?=
 =?us-ascii?Q?4oq+wdX3FMka+HiV6K4v0FyrvzqzO80efdHfWzKJ+zNluRgxFWV30K4vpP8m?=
 =?us-ascii?Q?73OtIOfa9qu2fOrta0omQJB0req60Cpd/LnT7mHyPtOMccun7tCNtqDwveUi?=
 =?us-ascii?Q?DqZrOJbxj84SeJ9W5QAfgvU1xEyTs6nAvudlvFw2lAAV27uHNBjxRXgPViRP?=
 =?us-ascii?Q?cgqDitXmGacjvsKJVYhtmnhSHWTOQd25K81Xa3/q9d5g/AySx+DD4on45knr?=
 =?us-ascii?Q?CZ24NWjfygiUhI2FAPz1VH+MB2cz2UwcmqmciBhhY2IC/sQ6dGRN2nOu105s?=
 =?us-ascii?Q?rHZg1oM/mcnsqzOrK39d37B6Dg1FgGGC4dnkiEtjz3Uakt9SNMlIrPXNJ4Yg?=
 =?us-ascii?Q?dLiYfnmYjQKLPx5Z+tT7UUZpm/yt1PxfLP6krz5Ylc+6+Z2+8+stObjC8X5c?=
 =?us-ascii?Q?TJMv47fNVy+NdCf4ZLAnlOHOTB2wL1dAU0Is0igABzOLNbLHzkdUiTJhbFXV?=
 =?us-ascii?Q?Da1F1282XzzAIo0Rgj+P9d0d/M60YHZSRL7Fp3/0aJxYg1pj5DH646cN3EM4?=
 =?us-ascii?Q?uf2zvogFSGH0ockVlbw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9dfb7f-8c9b-4a85-5799-08dc970d9c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 00:59:49.2683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yYH38DmGiJ3Xn+oXHbgoDc1ze7hrwU1UhmbsgT6M5BTwHGicoECv7yoawZsjcfUHWnyH7ST/zY36xR66jJUZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9933

> Subject: [PATCH 7/7] arm64: dts: imx95-19x19-evk: add pwm fan
> control
>=20
> Add pwm fan and overwrite default thermal nodes.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

tpm6 not enabled?

Regards,
Peng.

