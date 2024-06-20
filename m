Return-Path: <linux-kernel+bounces-221999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A2890FB8D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0889283A30
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A931E876;
	Thu, 20 Jun 2024 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hm0IA4tp"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2052.outbound.protection.outlook.com [40.107.13.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114A2B9DA;
	Thu, 20 Jun 2024 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853038; cv=fail; b=piSwSAO+g6IWBmihc5RA66enHuVeQkCMxJoPmC895gPhYbKH16qI8lB3yC0BKr12ul3hk/In8jUffuLbk3BRlJLxQ932Zo88WnJsLz3waY2Pgfod9LBcz0jErTww+vvSzxNjXQ6GT6XZv51e3WYpMNwlGVybljO+ZaIQqWId1ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853038; c=relaxed/simple;
	bh=5kivzI+TUBG2tnFoVoNlYU/39PVAR1V6qfgXZRuJpO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tF/PbWJxeFqtosbzDA2toxx5oHz8HereuBRcOH0DnAZwIoh2U41LVr2sD8zc67pmiVu0Rll+zNKD8Veo+9u88YGhThRsfa9iLUHT0VDn5pFpxn3/AJZN9pQe63rZVIW3QOdLPTSUfkx+QF4I1d1Uz9oTLit/ARO4qBb1YMrpdFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hm0IA4tp; arc=fail smtp.client-ip=40.107.13.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR0MqHNCyDvR40nGwRQQ+6JtyUSH/UC0A4SvTBKfNApF4I8rgizdGv1jFht3mGLb6Te5kmPk8CnrOC1C9+aYnXtBz1BPL20I5uWVnBHcYPZ712mOCdJN9LHqmzfnvlb1MbsIS2P+HHhStpCV5ohGLNxLy/w6bTRkUf18fOHpZrLXY+HQDt3qQTf+3dFiTWfK6+Cw8nUwvpJbEc+IBHY3z5nsrzKZAIsi/WcS/2j33MPn1MjDkC9+MdMSHYV8JaMsiXRcCy2a43goSXTxiOTsXjerG5IVnlrjt8INXLx9V5u34WhxT8IWc9qufOgBFSJ8EPkgcPq2Pcn8jHQQh/+WOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRteQerI4r59rNG5YiJ5/UWYLEv9UVyu2UwSRTKuAMM=;
 b=kGlWw+6P2zJEdXL4WUroz2+7TLulWIai/PrG/0v8xgUudVje+RpCiLaGHycXpAyOWFIDVUsg/iZtI4dhcMJiAWuOuiYbRaQfHBVjBIxfWzIXOAIus6uogxgYxgNxfkJz4RdlPKXCnISJQMCW7uMOcXTjxqUhGWu+TB7HQHCyRqtR88fnQfCqj9cr8PknabJZV2n9fI/P8rYBWZTxgRK37L/SggOsFJU196Zlws1yQ7H3/livMBbabvKgkluRqbZL024udE4rlp/vYb9N+Pk1xl7/waw1AksAvCtNnpzS2VRsSAVTnk+CwUNe5TIuI5YSwDi7UBXArIVygztdPAgUQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRteQerI4r59rNG5YiJ5/UWYLEv9UVyu2UwSRTKuAMM=;
 b=Hm0IA4tpr1JmLEIpV6s7KkzwOZw0VD0PbEiEEix/vtRy2hZySXy05oILH/TIyzhw0XPQDwXM9yToD1wwFl2svKfNjaPfJNFeMHBNUEpK2QIagTp640iSTwmvbpaqK0MIYeboKfcwuSPGPu0ihOzt7PIzpv38mCvWPghqUw0BB7s=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI2PR04MB10115.eurprd04.prod.outlook.com (2603:10a6:800:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 03:10:32 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 03:10:32 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 1/6] Documentation: firmware-guide: add NXP i.MX95 SCMI
 documentation
Thread-Topic: [PATCH v4 1/6] Documentation: firmware-guide: add NXP i.MX95
 SCMI documentation
Thread-Index: AQHarbcWvQ6qnrsIjkGMWdfSXLY1JLHMSYaAgAPXkKA=
Date: Thu, 20 Jun 2024 03:10:31 +0000
Message-ID:
 <AM6PR04MB5941FC1BB606ED5A2A9FD19088C82@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
 <20240524-imx95-bbm-misc-v2-v4-1-dc456995d590@nxp.com>
 <ZnBip_XY1PAkTEbB@pluto>
In-Reply-To: <ZnBip_XY1PAkTEbB@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|VI2PR04MB10115:EE_
x-ms-office365-filtering-correlation-id: f2e55539-42fb-4159-37c9-08dc90d68bc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|7416011|1800799021|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uAfqiRnUh39Oni4sPdNjV9tb3WhOOUcEqeMZy6X+UACpStq+iiUNOrz/oAVI?=
 =?us-ascii?Q?IzHbU76pj74snwrlBBgAdFUQs8jLB9vY/Te7B+xQHENwnoGgBSEVqvkTG3Us?=
 =?us-ascii?Q?wBdyw9EriE15fFNeVQ2qyAvrJb0GZ+lEGlq1n88pv86J+UaARlrag/TzkI9E?=
 =?us-ascii?Q?liQ3IKhsc3uwYP69PsU8ZPcQkvjUGd8d5SwgDyJX4nVmkIPu67M99Uaf7PTA?=
 =?us-ascii?Q?NzxOWd4CQaQJlcmJpHXLaUZc9hw6nfeGh67VHJyzAfAV1H4MzREnS31w6TOY?=
 =?us-ascii?Q?2vXifl24uro97A+mrhtIiJgm9kGmG4POedu8eqRLXcopj2TjytJfVg3s1wgj?=
 =?us-ascii?Q?v6wGEuA6OkAUJMOhL+lvqKyy59CAUrZbFOEt+srMIQextNv5EyrxbdfUlTBL?=
 =?us-ascii?Q?4W7vJgPotPBwOyjbZy0Vqiuqkjt6Lbb0xdcPbJOromhNMY0ItlWm0REWLzQN?=
 =?us-ascii?Q?O/sYnaXFmq1AoYPepfQhkVjIzfuUN/iJVO6SSMBbmQZ0EpkZMGZG+eE+io9/?=
 =?us-ascii?Q?7TdyLBItnqOdaLtA3CUPiOJwI9sVMXX+8qhHz4c7xyy2pucFv+pZ4gbIlEBt?=
 =?us-ascii?Q?BSun8wUcb9lX+5P1K41nR8R56PYVDWpD9Rc/9GOm8Btj/iz3mCv9EmhvAZzF?=
 =?us-ascii?Q?MShWGsN2XZQQAYZfkK1Ncq5YtY6nV6LoVWgFvhxSJ9qJAZPJIp4RTkZQcFlR?=
 =?us-ascii?Q?vWC2PDDJ2Tl5lBTnXh/i+18RC7Iv3zhQmnmQuan7PwKbZXZvMTSoR4q9ega5?=
 =?us-ascii?Q?t1lzvGbtVi/Tu64YFTE7xTkdmbanJVe87LszYa5vcJZdvxdBRm7TPAXAMtIl?=
 =?us-ascii?Q?BWuqjSNe9rgdYGejB3g8yJX5cbOX0NPoXTJMj9TgZHHXMOB7Ay42ywdmoj5z?=
 =?us-ascii?Q?BqbmtFYC788poXozzoRm39mLlXaF1/bl8CXB96KlpjvJiOI/jdXfP/7a9FHr?=
 =?us-ascii?Q?lSJgqgcjbx8mMUaFP6+FdMs6BcVHNz6Wo/qlWyxbUivTdGlxGBYKlMSZskzn?=
 =?us-ascii?Q?3igN9kB2/G0OroK10/C2Ki09cvamcs7CCfIS9EHtazF4eI0X8sFjfO4eIuWZ?=
 =?us-ascii?Q?h87/ssAN5LSjiS/4803TmRSaEpXlDj1VK0ENnFRtsLvgDj8BppzAabBgJpht?=
 =?us-ascii?Q?y6hMSfle7o/uMTP9Mf0zh6AmsTQMwws3rMRMRlKrbUaiRKLv4US0NxbWQQtf?=
 =?us-ascii?Q?gtt33XX0sEok7/YtzAXrbzv8okcKh/69nRANljkUhxCAhzoLGn85ceRQSGGR?=
 =?us-ascii?Q?nIvifLGmcux6MP4OYLuAKEPyRBPn864gv+d15iEIbKXZZ9aoa0JxXV+p3ZHV?=
 =?us-ascii?Q?T4Ng6+oud2C9jPDsCpltyvuNKPNN8oAbQ5j7yUJfdIEwiOty5YXs/kpx7sdP?=
 =?us-ascii?Q?dMf7PP8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ezye8wCyRrZXu9bGveBxZIYPBkJOcSHuajKJ+hdolq6hn+yxpDNBAkbzT2es?=
 =?us-ascii?Q?hAUCjzAjLTxO3p0GmGRdQ1sXQ+8hF4fklmkiaE5Aoaa8Q2c/Pn3iQtfdOduI?=
 =?us-ascii?Q?SrTANWiZxNPjik5MewegzXe2JNrqVWTZHHnkayVSQ6Dbd7Un5GMtdCXsiwj7?=
 =?us-ascii?Q?CNhiqcZStV+9faKzHErzhQHO45SRYX2D/2qmcS4XoDmsQvx3+V4vCT/O88YL?=
 =?us-ascii?Q?Yo0k0SLEoe2WLacMMEha4xRwbrZWEc8/FESbcfgLdSJKAQb7fzBgdWre9+1+?=
 =?us-ascii?Q?A9ejaU7YxIbCcY4WrK25GOEbYwMzLJL0aZvCA4vuzK4B3vTEqOHOWlh/R/iI?=
 =?us-ascii?Q?u9aP0vNQpEZPQOuQVmldiXH2WRewO2IojZVDH5hjyUqRLjkwQqRdDL8oLY64?=
 =?us-ascii?Q?56RXP/WmfpGwVp+XWAw+IXnsJYcaqaKPvoJJ0xJISic02ygUoDHIHK7rda2Y?=
 =?us-ascii?Q?FJxLi5rE/Q2pyiKJDABoRzkXePUa5oY44j35a10dwkwHvk7weraNuutYucBx?=
 =?us-ascii?Q?M6fAet88NcMnQknCRx0LJzBp4J0XW0NtJkvXjz3muk1FZd/JRYziUPH8f7no?=
 =?us-ascii?Q?ao+IwtS10nNoNzuKXUqqM0emWHDDocRCYssUXBozDVIruWds1owELJrWCEqU?=
 =?us-ascii?Q?hVapVF7Te9atNzQRsYJUVqYu1IiUM0RWsqO3Mumuas75yt1TIz7Pj/jV3yKb?=
 =?us-ascii?Q?L6LwqBY79xX+YjURC0hv8k27ssf1cdfiHWwVdi4BPlMvIe1KUSkp13yxbqYI?=
 =?us-ascii?Q?QkhFmNGw61jLyyJd0Eu02bg+CkJjJU7nEhdomnxLbhlKaAOvJScmRe3Vwu8j?=
 =?us-ascii?Q?kNe5eVCZPJPZYPtZ7LZ+2r1N89jd9TFbtjbiyGE7mmntn5mR4sIQ+co1mfVk?=
 =?us-ascii?Q?9lxlMNshuDR7bkXIvNCcCQiIN+AizQKdHgQpI7BAMv64VuH7WYPRhwTRGlgO?=
 =?us-ascii?Q?ge0XyTraFD/5oTxyG6p9S2XWbhKuCrMXKKl/xWMgUGDnMbgZMcZbzHfGbhFX?=
 =?us-ascii?Q?LRqDbAYQlbAIc+akDpnluTtCz5WJ6ZpupjDwOXO98pugJNhZPbHmVxP1moAc?=
 =?us-ascii?Q?Bstzf6rimloa8DS1pmcK3wq1Tgs13gN6BzdswJdou7OqpMy9ZBZ305t6d4+A?=
 =?us-ascii?Q?S/ZkaOPCan5xsEheG9L7D/BJece8gMIbq/v3uQPlI26236YcobLNe95DVW56?=
 =?us-ascii?Q?AzvndVjKxsIkt/GexGx83G7Q3jw8BMlC7U6ixkMRxZtXhSqrlU1x2E/is2yv?=
 =?us-ascii?Q?lLL+551+eQpNmY+WymawZHCHmHu2KYlNOCLk6GfBP58OYaVnAXK2PQDoLp04?=
 =?us-ascii?Q?JLq3P9e3PUShQRHQ2DV2e9O3dCfbQzCIufsLFNANXAcUNcWrcf5r44m1qbXw?=
 =?us-ascii?Q?RBIizLFA97Xu2Ym+p42J8efkDNj6HhIH6z/5dYJywFqx/sD/6H1pEMCLJ3rt?=
 =?us-ascii?Q?LDKHvMuES3FqTfSi7q7d+wf4BuWQdBbL4UAlyMOtF5gS5mfK61MuyEOQMX2y?=
 =?us-ascii?Q?kcGHzQIDB/A9FSnfKdAQPOJ4QDNvRzG1GEKpuEApTOESHAtsD7UteCQiokA5?=
 =?us-ascii?Q?dcOAXT3dObJTXED3TWI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e55539-42fb-4159-37c9-08dc90d68bc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 03:10:32.1779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2e0z1IctFb0P3gNg1Yr8BwaLjs8po0LW0Dbwuc+0bF2Rr9XjbO5OwZ83M4NfI7cMbhj4Yn31rwrlja2zu9+Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10115

> Subject: Re: [PATCH v4 1/6] Documentation: firmware-guide: add NXP
> i.MX95 SCMI documentation
>=20

......
> > +The SM implements an interface compliant with the Arm SCMI 3.2
> Specification
>=20
> I would not specify the exact version, since the SCMI protocol is
> anyway
> completely discoverable and in case you evolve your support you will
> have to update endlessly the doc.


Sure. I will fix all in the patchset.

>=20
...

> > +- Set an alarm (per LM) in seconds
>=20
> what is an LM ? maybe a worth a note about it above in the intro


Logic Machine, it is i.MX SCMI firmware specific.
I will add in v5.


>=20
> > +- Get notifications on RTC update, alarm, or rollover.
> > +- Get notification on ON/OFF button activity.

....
> > ++---------------+-----------------------------------------------------=
---------+
> > +|int32 status   | See ARM SCMI Specification v3.2 section 4.1.4 for
> status     |
> > +|               | code definitions.                                   =
         |
>=20
> I understand that you want to mention a specific table in a specific
> document for a well-defined version, BUT I would drop here and all
> over this
> versioning and refs and just generically say
>=20
> | See ARM SCMI Specification for status code definitions.
> |
>=20
> to avoid all the future churn in keeping the refs updated here, since,
> as said, all versions and features are discoverable and the Linux
> kernel SCMI stack takes care usually to downgrade to match the
> detected
> protocol version.


Sure. I will fix in v5

>=20
>=20
> > ++---------------+-----------------------------------------------------=
---------+
> > +|uint32 version | For this revision of the specification, this value
> must be   |
> > +|               | 0x10000.                                            =
         |
> > ++---------------+-----------------------------------------------------=
---------+
> > +

......
> > +|int32 status      |SUCCESS: if the button status was read.
> |
> > +|                  |Other value: ARM SCMI Specification v3.2 section 4=
.1.4.
> |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint32 state      |State of the ON/OFF button                        =
         |
> > ++------------------+--------------------------------------------------=
---------+
>=20
> How the states are codified ? 0/1 ? with the remaining bits reserevd ?

0  or 1 for now. other bits reserved.

>=20
> > +
> > +BBM_RTC_NOTIFY
> > +~~~~~~~~~~~~~~
> > +

.....
> > +|uint32 index      |Index of the control                              =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint32 action	   |Action for the control
> |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint32 numarg	   |Size of the argument data
> |
>=20
> Max 8, it seems...please specify
>=20
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint32 arg[8]	   |Argument data array
> |
>=20
> arg[N] with N in [0, numarg -1] ?
>=20
> ... a bit of formatting issues too above...
>=20


Yeah. Fix in v5

> > ++------------------+--------------------------------------------------=
---------+
> > +|Return values                                                        =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|Name              |Description                                       =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|int32 status      |SUCCESS: if the action was set successfully.
> |
> > +|                  |NOT_FOUND: if the index is not valid.             =
         |
> > +|                  |DENIED: if the agent does not have permission to g=
et
> the   |
> > +|                  |control                                           =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint32 num        |Size of the return data in words                  =
         |
>=20
> max 8 ?
>=20
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint32 val[8]     |value data array                                  =
         |
> > ++------------------+--------------------------------------------------=
---------+
>=20
> val[N] with N in [0, num -1] as above ... I suppose
>=20


Fix in v5.

> > +
> > +MISC_DISCOVER_BUILD_INFO
> > +~~~~~~~~~~~~~~~~~~~~~~~~
> > +
>=20
> Which build version this refers to ? the SM fw build version and
> metadata ?
>=20


Build date, commit hash and etc.

> > +message_id: 0x6
> > +protocol_id: 0x84
> > +
> > ++------------------+--------------------------------------------------=
---------+
> > +|Return values                                                        =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|Name              |Description                                       =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|int32 status      |SUCCESS: if the build info was got successfully.
> |
> > +|                  |NOT_SUPPORTED: if the data is not available.      =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint32 buildnum   |Build number                                      =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint32 buildcommit|Most significant 32 bits of the git commit
> hash            |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint8 date[16]    |Date of build. Null terminated ASCII string of up
> to 16    |
> > +|                  |bytes in length                                   =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint8 time[16]    |Time of build. Null terminated ASCII string of up
> to 16    |
> > +|                  |bytes in length                                   =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +
> > +MISC_ROM_PASSOVER_GET
> > +~~~~~~~~~~~~~~~~~~~~~
> > +
> > +This function is used to obtain the ROM passover data. The returned
> block of
> > +words is structured as defined in the ROM passover section in the
> SoC RM.
> > +
>=20
> what is a ROM passover exactly ?
>=20

It is ROM stored some info in RAM that could be used by SCMI firmware,
such ad boot device and etc.

> > +message_id: 0x7
> > +protocol_id: 0x84
> > +
> > ++------------------+--------------------------------------------------=
---------+
> > +|Return values                                                        =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|Name              |Description                                       =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|int32 status      |SUCCESS: if the data was got successfully.
> |
> > +|                  |NOT_SUPPORTED: if the data is not available.      =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint32 num        |Size of the passover data in words                =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint32_t data[8]  |Passover data array                               =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +
> > +MISC_CONTROL_NOTIFY
> > +~~~~~~~~~~~~~~~~~~~
> > +
> > +message_id: 0x8
> > +protocol_id: 0x84
> > +
> > ++------------------+--------------------------------------------------=
---------+
> > +|Parameters                                                           =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|Name              |Description                                       =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint32 index      |Index of control                                  =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint32 flags      |Notification flags, varies by control             =
         |
>=20
> So basically this is to somehow enable notifs on the specified index
> BUT the flag field syntax is completely opaque and varies by the
> control type...
> ...how is this even used in the code ? there should be at least a bit
> dedicatd to enable/disable right ?

Currently the flag is in board device tree. Our current usage is
board specific.

>=20
> > ++------------------+--------------------------------------------------=
---------+
> > +|Return values                                                        =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|Name              |Description                                       =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|int32 status      |SUCCESS: notification configuration was
> successfully       |
> > +|                  |updated.                                          =
         |
> > +|                  |NOT_FOUND: control id not exists.                 =
         |
> > +|                  |INVALID_PARAMETERS: if the input attributes flag
> specifies |
> > +|                  |unsupported or invalid configurations..           =
         |
> > +|                  |DENIED: if the calling agent is not permitted to r=
equest
> |
> > +|                  |the notification.                                 =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +
> > +MISC_REASON_ATTRIBUTES
> > +~~~~~~~~~~~~~~~~~~~~~~
>=20
> ? as above said... REASON ?
>=20

It is reset reason. Such as WDOG, FCCU and etc.

> > +
> > +message_id: 0x9
> > +protocol_id: 0x84
> > +
> > ++------------------+--------------------------------------------------=
---------+
> > +|Parameters                                                           =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|Name              |Description                                       =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint32 reasonid   |Identifier for the reason                         =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|Return values                                                        =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|Name              |Description                                       =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +|int32 status      |SUCCESS: if valid reason attributes are returned
> |
> > +|                  |NOT_FOUND: if reasonId pertains to a non-existent
> reason.  |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint32 attributes |Reason attributes. This parameter has the
> following        |
> > +|                  |format: Bits[31:0] Reserved, must be zero         =
         |
> > +|                  |Bits[15:0] Number of persistent storage (GPR) word=
s.
> |
> > ++------------------+--------------------------------------------------=
---------+
> > +|uint8 name[16]    |Null-terminated ASCII string of up to 16 bytes in
> length   |
> > +|                  |describing the reason                             =
         |
> > ++------------------+--------------------------------------------------=
---------+
> > +
> > +MISC_RESET_REASON
> > +~~~~~~~~~~~~~~~~~
> > +
> > +message_id: 0xA
> > +protocol_id: 0x84
> > +
>=20
> So is this a GET ? MISC_RESET_REASON_GET ?

Yes.

>=20
> > ++--------------------+------------------------------------------------=
---------+
> > +|Parameters                                                           =
         |

....
> > ++--------------------+------------------------------------------------=
---------+
> > +|int32 status        |SUCCESS: reset reason return                    =
         |
>=20
> ??

Fix in v5.

>=20
> > ++--------------------+------------------------------------------------=
---------+
> > +|uint32 numLogflags  |Descriptor for the log data returned by this
> call.       |
> > +|                    |Bits[31:20] Number of remaining log words.      =
         |
> > +|                    |Bits[15:12] Reserved, must be zero.             =
         |
> > +|                    |Bits[11:0] Number of log words that are returned=
 by
> this |
> > +|                    |call                                            =
         |
> > ++--------------------+------------------------------------------------=
---------+
> > +|uint32 syslog[16]   |Log data array                                  =
         |
> > ++--------------------+------------------------------------------------=
---------+
>=20
> This should be syslog[N} with N defined by bits[11:0] in numLogflags,
> by
> the definition itself of multi-part SCMI command...the number of
> returned
> entries is limited by the platform dinamically based on the max size
> that
> the configure underlying transport allows....it could be more OR less
> than 16...this way is seems that you always carry around 16 bytes max,
> potentially with unused bytes if returned words are far less...


I need check firmware design, but your question is valid. I will check
and fix in v5.

Thanks,
Peng.

>=20
> Thanks,
> Cristian

