Return-Path: <linux-kernel+bounces-269256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4693942FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531FB1F2B09D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8051B1414;
	Wed, 31 Jul 2024 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lTrRfryo"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166BE1AE871;
	Wed, 31 Jul 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431604; cv=fail; b=AKNhVO3wP3cHJ81wpcrrucR0YMF1XPHUJRH3N4uyY0ixH17Y4OptwJVL2oaFGFZkPcKSKoU6kR8xCx6J+CslIKMff4A/Ju5kvbCRVSgefa1/jZMw0I8UTixFfaZeN18fJGpeQD16J24V4suXzthB/OdjJLwzBa8S9telwRcJuTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431604; c=relaxed/simple;
	bh=t+Jlebyb+h3DhfbaZSoQNcovZ/xkgHEGt5vbRRcl2BI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I9FSF9hdBHNPMASPcn1redg7h8cKo80+TGwD02GoshlJYe0lg3+W12U3NDC8J0eGpU0EBIn09wbMf2taHOTXBGL3Cryzk1t+ERM0AA1326z0hM+yK98ACKh5+9Z+MooYaXwlAh0VceDKirlCQ1YqOyAPBVcSyJROIRFuQTinrR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lTrRfryo; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfHmNBZfgv1AM71S3eNzqlpaJ6FZd3RKHmS2gTnk4C7NvY5DMqStOkL0d4uuINS/sTwifgejfaWxgicDARDWurECu37eb+hcL98l/QId4Lfu2ilMbJjsh+ceWYjFM1dzosKQha82JT0uOVqrNssUPeWPIkGQuGyb2yc7vuRpPfMH+9leznG3cReGZhvl/r897izayJRsZqQK+ettsKP+1Eu+VcPcM5K+OW7UOegrghT1qzugXl9buiGVHbJi6JHJD5NDm0i6PaHkdN4YXWVt1by2gh1ta1WSwhXnvSFxaeBBFHQNv5y66ZBhun1g2uKzGDjBgfPwHGafgoKXvX6VDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRi6hOHkEs7NFW2+5nl8d8n+dsktgfAPIi3dkj7pF0k=;
 b=r4mgjMO01wZyaxsJplTU1YlNi889EJA2a/6JzfTC1bJrU7m7pwW2xYwRBZH3ltK0QyuwLaV3ivE/JfajKoojZfJTOUOM7BylUXGSAoUNJX8f+YgZdhDosjd3INvA6HguzJuHKzo1XYNSu5likVAP74ulyRnfBnhTESYMcE9mGuMSbihfW6XaVP3GJ6KPc0qSWkRHkGRPgonwW/3f+p10MRI/jAZWHuKVDOOq0BbfsjAXR1hpxw67WiSRkXsuGN1AoUpIpvJ2eArn1vBYbA8T8Smh+cqLPrJT57Qcsb8cnIpJIApKj0eZ+v+pTMDpl7co5jk9YDuW+pLL6my1f34x+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRi6hOHkEs7NFW2+5nl8d8n+dsktgfAPIi3dkj7pF0k=;
 b=lTrRfryox+E/Taw33lcW08A300zQ/8epqOldXY96DV+sl2Cnq0NKYTRabFW1EhKXb+kU0grZvZQV4uJIp7BbXdNXf+18Zy5MzWSJlAO5mnQnrf87yQ7Jol8oGTaEGIEnFIVOhJOOateuvGEKflMLdaJSMt6jJmFTi5+f6RqBT4t8jHuLkBuGiY6OtpjQ14KpycHkI8WzHKnJwNr3389cyN1WGQuon1mLvO1lVFqg68GMUhvgv8CTqbK3mrq++XS6ZXr+Cw4fsTcHpaMU5uEaYrANSv3FLvbwkguNE4trlfHnEG/2m1o00honPb3EtCD08CZsI/xvTp2L5ezWrSzVdQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10370.eurprd04.prod.outlook.com (2603:10a6:800:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 13:13:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Wed, 31 Jul 2024
 13:13:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "etienne.carriere@st.com"
	<etienne.carriere@st.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>, "quic_sibis@quicinc.com"
	<quic_sibis@quicinc.com>, "quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: RE: [PATCH v1 0/6] Add SCMI transport descriptors
Thread-Topic: [PATCH v1 0/6] Add SCMI transport descriptors
Thread-Index: AQHa4o96gdLDJQTk2UyEYJRE51UKzLIQ0Ysg
Date: Wed, 31 Jul 2024 13:13:14 +0000
Message-ID:
 <PAXPR04MB845979C704A02CF0DCAEF39D88B12@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
In-Reply-To: <20240730144707.1647025-1-cristian.marussi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10370:EE_
x-ms-office365-filtering-correlation-id: 803aeee4-c77c-4b30-db52-08dcb1628946
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fUhZGjObCrBmSeVsRM46DQ0N86zdMkgF7H3jdHcNX121Ms/Dh/9bCxbZysBR?=
 =?us-ascii?Q?D1ruoAfP4lCebuSaYAkPujZRFMWNfFypDCQ8Fnw9dLyHMwe6JRURyJLuX/2G?=
 =?us-ascii?Q?t/w35CfzlS/kKTiGk39hWMzalv8HvY/l/J1dHonf2M1DEebwxmMNpAZKaII3?=
 =?us-ascii?Q?9B//eOWwzNnoQS036ZnpBTTyKX3CSt7cXemddMA1b2bYvEgBvy6wQuNhM+v6?=
 =?us-ascii?Q?VkyxOoykCTx14e8skq7r4mQMpm7TF3RiIkpONb8Uv2lQCMJDO7H378xZTA/e?=
 =?us-ascii?Q?ysysnkI1KxMGcuflqaX8x9Q/WLydcY1W+fbS+od2TOC26fgMO53F37vH+bQ0?=
 =?us-ascii?Q?SlMvakHHOBhndxho38NZPLPuiR90aMqBsjui6AlNXgMkU2qkQtQI40fVrRCr?=
 =?us-ascii?Q?7ak6KxEfbyojSb2umGnmNlMUb7QDbgVUP1AFgoZAceZutkawmx3jiDFDTP2Q?=
 =?us-ascii?Q?EPvY/xVfzGog6F81B3y7FEISnRnSnay72TSYRprsC0irhsfPPYLS98BV1zBr?=
 =?us-ascii?Q?tTs8S2x+epZm6BojEXGncj0r9Fc6DyT1zUTW37DlZpZPrYJ3YHT8DDFwqUhN?=
 =?us-ascii?Q?8BSQR5L5KpkUSScGfoXR6GtUJ+voDJE4ZiKmDR5+5CmF0LLl96sLssFkRb/W?=
 =?us-ascii?Q?ArTC/h91AHoyzdL3NNu/UyfzKppDrImb/iAR8lrRcd1DOJeAb62E3PLbHRZY?=
 =?us-ascii?Q?JRXTzFQioc2h7EMX9ruqHtOntvr9h1BcFGESJLzQFcrGVuBcf29C46TUHLVx?=
 =?us-ascii?Q?tybpKQB8M9PPV9Ff0Tp0xDWpwyCpipSbVUHSQEX3Vo1RX4YR3pa6LCQ0J4wE?=
 =?us-ascii?Q?kqjJaAkn6zOVsaGZC3cjoVxRT67AZitogfZctoPpYzGwFl10WuyMRNd2z9A7?=
 =?us-ascii?Q?5I4PVJZv9qFAbkdYjBzeDJi1CcrFPsBcMEmef8cdrRlfOXkZfeckWnzGKL6k?=
 =?us-ascii?Q?q6FCZBr1ua8icWFc2484cEL0XrVjEKdggi1pGG8FeU/2Rm2AtoKXZv5LUlYM?=
 =?us-ascii?Q?F7TjhmQzre2JnMAPCQ91GJBCf3eGhzYJSxuaFH0bPPKuYG0eryDSCwVTz2YH?=
 =?us-ascii?Q?5zbV+dsdQf3flfxDIjeXT1HIMzHStf3MLouBdbqhIIfFufbus2otpe3dvMuf?=
 =?us-ascii?Q?RyrbR83nzo1iZ5lDX4bAcbuLhWdGkUHPP9qSFY1SNbUogvh3NG1UtYoN0Zlt?=
 =?us-ascii?Q?EuNo33KHDi3RwtQQuhZAAEUeFW0r/Vc2RVfsuvdT5BMIjNWS5323S/+OL9WY?=
 =?us-ascii?Q?xtpcO2F+SQUkH7liPuqRj087X9pdbdZoGZ4t8WWOI7mBLV24xKs4MK6aUMEW?=
 =?us-ascii?Q?mU9bS4LZxYEklYA9WqT5iDctRXrMeZSPBvqTml3y7T9B2Lxgrb+0jawlu7n5?=
 =?us-ascii?Q?THFld+OfOo+s/QQ8qOInq/GZDfB59WRmpeXOCN44eE7QP2IE4Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/zY/uCziRMLh7FJpeU9mknBc0PWbXlcVTc/LEdN+3TNXWdMTCR/IHNwizxJR?=
 =?us-ascii?Q?HrR9yKlYYH3pbnIzDbkVK4KzDssLo2dC0cwn1BrfOoXh3CUW/aeZoPOqCvUO?=
 =?us-ascii?Q?qnvRI/dfNEV5CDfLt6mqyZtCV8Tyefnk+suVmyd81GqR0KoUXNpXvX2xeVAk?=
 =?us-ascii?Q?CbgqNInYDbzftdtAsG7JI1tmbQiQ54yoKlZEjGgTUWvKg92e7qfRNkVIsif9?=
 =?us-ascii?Q?akql6Yg8ePGbycZOKcQCKnfLXyHyT8quFowhAzMDtmuvgg++6/XaeCXEzRJ0?=
 =?us-ascii?Q?7Lhu2UGzzq+xYJew506XlwMNOGrP5tlKbngFf3IoMbaGLPNjDv4Lu7vLgjyW?=
 =?us-ascii?Q?pWxIWlvEDuZpAP7mlcK6d/oYzra+hdBm7K7xNUqxB0sjcaBsIOHAW0RyHX+p?=
 =?us-ascii?Q?VBLHP55ZtGEKbMIM326Ocjy32FaT+gXon0HW03gltAehsJ09Hdy/VmBIW7+5?=
 =?us-ascii?Q?jat1gGy75bgQpvXzGFnw6uZOWEX60nF+EB2zKVa8jdkj6j2Q4HJ7U7M3t8YC?=
 =?us-ascii?Q?ZeRHR0/qgGFEwYSdWv53t+GLMymhWGXfI55zccRpCzRXNOSM/Tidd/L2v/rf?=
 =?us-ascii?Q?YYFrPvPot3E6nKACqvqMeoB7H97cXrNpDHbw6ycxWdyfbaNX/Zdl6A+MxQiB?=
 =?us-ascii?Q?uDiGG7HR/7mS1yxwJfxOJBnBTK4drf7v+L+B2p9LklbMVnS8jAW+EbB+3Omf?=
 =?us-ascii?Q?rPPrlMQSAEXBvwKerM952TQytwrWR4zpBh0hgHovJQVxMgsv0DDg+TL/h7qD?=
 =?us-ascii?Q?sd9sL4gtt4OBXjhDr1IJCRmu2U7i9J49VIMYqU+GDDmyf470HbNZnIq1+d1y?=
 =?us-ascii?Q?pZmc8YNUTgA6ztd8uZlIBSphlgKwMSrgpPHmsKPWBknZDCTw2iWd3pKgzCq3?=
 =?us-ascii?Q?qhdEwCigyaKgvgJFl4boveRse+Gj1X0xhb2iyllHq2/5x3b3dsoHTvlAax+f?=
 =?us-ascii?Q?nURB1mv4eLoA58DLB0ec0eGyKOMmvM08mvqKRdQ5Sb9/xO4AV5cVVkdrN1J0?=
 =?us-ascii?Q?yGGADrveq3tUK1+SeFKjkhJttWI8MiqO6U2Tk6Gp51OmR760dWhyPAl50zb7?=
 =?us-ascii?Q?0DG9F/7GbTKN9sO15GcozUCC3yfLlpInGz5AcOwOqJDlbcZUA/csoE9x1R8v?=
 =?us-ascii?Q?f+cTVlK1PhHx7uC7a7ErMYT1S2l1tdN81+TtG0M2Gv82qTcq1bTyHHgLYDAx?=
 =?us-ascii?Q?BsvgNMnIGDs2M4RViYSVslDBS/HC7bzlrpo/IOHZw7IAqMZvznL0KTfdWZGn?=
 =?us-ascii?Q?ROxMq8bkixRmFoq2Lzdsjib7QGSDQItVsX+kfULzf3IdzUWSWcI2xG7+TaqV?=
 =?us-ascii?Q?adhxMONjIIo3P/nHjc7wxbH+Sc821OvuULDIUFOIiHlVzB0x6YDyPG0TNe0A?=
 =?us-ascii?Q?tORzeKey+xXPUrwt2K69LLGCYD14WeM9KSt3bBKlX9lbG9CvuKO0nsQWB90c?=
 =?us-ascii?Q?Nz+0y3pAJQzr6HasJUbE6kd9QSYMp09EWqiTlnnhe1FIRPTx6PZptOqjwscT?=
 =?us-ascii?Q?OAyFruai+x8CQ6H1Z9bhOuXfwnfbBgoVJmf8oAy3TH1lG4lBB9o2ox8S6dJ7?=
 =?us-ascii?Q?7znYZETSHD+au/7r/cs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 803aeee4-c77c-4b30-db52-08dcb1628946
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 13:13:14.7373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVGt2kZcJk92CBvBL7NB8EaD9hGvIg9RkQFO0sk5HY0KhM99C2NCh+qlUmgqENZCv3pMrCxPxK3gOsnxZscMcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10370

> Subject: [PATCH v1 0/6] Add SCMI transport descriptors
>=20
> Hi,
>=20
> this small series is an extended version of this recent, already reviewed=
,
> series [1] posted by Peng to add a new arm,scmi property to describe
> some platform-specific SCMI timeout constraints.
>=20
> On top of that, this adds 2 more properties to describe a couple more
> platform-specific transport characteristics.
>=20
> To minimize conflicts, the whole series is based on top of another
> recent series, which represents a rework of the core SCMI stack to split
> SCMI transports as standalone drivers. [2]

For the patchset,
Tested-by: Peng Fan <peng.fan@nxp.com>  #i.MX95 19x19 EVK

Regards,
Peng.

>=20
> Thanks,
> Cristian
>=20
>=20
> ---
>=20
> Cristian Marussi (5):
>   firmware: arm_scmi: Remove const from transport descriptors
>   firmware: arm_scmi: Use max-rx-timeout-ms from devicetree
>   dt-bindings: firmware: arm,scmi: Introduce more transport properties
>   firmware: arm_scmi: Use max_msg and max_msg_size from
> devicetree
>   firmware: arm_scmi: Relocate atomic_threshold to scmi_desc
>=20
> Peng Fan (1):
>   dt-bindings: firmware: arm,scmi: Introduce property max-rx-timeout-
> ms
>=20
>  .../bindings/firmware/arm,scmi.yaml           | 22 +++++++++
>  drivers/firmware/arm_scmi/common.h            |  9 +++-
>  drivers/firmware/arm_scmi/driver.c            | 46 ++++++++++++-------
>  .../arm_scmi/scmi_transport_mailbox.c         |  2 +-
>  .../firmware/arm_scmi/scmi_transport_optee.c  |  2 +-
>  .../firmware/arm_scmi/scmi_transport_smc.c    |  2 +-
>  .../firmware/arm_scmi/scmi_transport_virtio.c |  2 +-
>  7 files changed, 64 insertions(+), 21 deletions(-)
>=20
> --
> 2.45.2
>=20


