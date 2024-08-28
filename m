Return-Path: <linux-kernel+bounces-304973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE1D962789
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F7E1C23AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C3B175D4B;
	Wed, 28 Aug 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VmTlfNJv"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013071.outbound.protection.outlook.com [52.101.67.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D734815FCE6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849001; cv=fail; b=ai+nlmAj+DEe1jkQNdLdk/tUUXav9Km3NCYe/F1JZ/9xKQfSGH2CVIFaJM8gbFAegQ+G4jPFZfzsn1CmvJuKjKoCP9tRtvdCvlTLmbWHEQGigwTfraOP3l0VIcuxs42SZHxGXivi02uPY2LF1upKcQT1hNgRlpWgod5q0QucMK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849001; c=relaxed/simple;
	bh=wuYgHcoUiwIJR6kyDPz7mH0W+cujJ+SOY130s+x6zKk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LjxIgKb307ueqYB2L/XS56pV1rCuMFPvdHoeFEBDDayEaJ8XWXH8cm4aH3aD9kkrn2KBWak6TeFMK0/ha3dU+8rz4s/XwBS23RPq2J6dNxA9Iz1N8IJ4hUCsQRztp19A2rZd1ebndQ7T89M0Wg8GW45gSW62xkqaqCB0v0ak06g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VmTlfNJv; arc=fail smtp.client-ip=52.101.67.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOlobLDU9F/BL95taFtEHLftl1zsUy75EAJSnhLIs9gGEfhQkmXFJ5qeCKHny9D0rx/ObHVzypXeaDQyGF5DDDNJyIL17+lYJMAV/T+lwT25PQnFEkFygo4bs9NXd7UrEIRpDiZetM5B1iPL2uXII3vvmuklIZ8d6A2dguB99qG2U4SwRSYHaWo+KkPsl1BWlbG2RZxlGZSvAJkpSzwNMjhizkOn/0YcdQnRAy10yVQlPnbgoYtSjcp+Qy2K/K8W1doIfUTOYzfmp/IEYrLKLrkrj7FWo20zBkBvxV+CIqrrrRp+Zoxi32N9jsSpor15m73CEegh2lWSi/9yJnIrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4A6rCBDmQR4+DjfoLpUlHZZAiOnvXWB2L3sZdrW504=;
 b=Ky7qrp1CP531I/rYv9PvYLRfk/95fDnfjLFqAHyOh5eWZa6VpZ0EyYStCLJFiCohDUzY7WWI/CWP98L3aFFYaKBmv19VK27U/QqCGd1ucVVEBnBq9PbfRzKmVzqAsH/LNm0675lHWxVZhKj5ChI6L6AvLCO8pEPoZJkDrXBoRh1JpehUGBO9XSPqb6rHc3qGZArvC/ui0GBNDoIjajcL9TpZcTLuf51AujxIRBUh+hea1AZeCpZxv9cxTO1sIVAdUmbIe1xi+bjxSobDKVM17wbT2hGGKt2sm1tCH+jPCqUQ17cBvt0vR/lUZkMTtHIbtrFrmY2RYBL6pqM40mAVlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4A6rCBDmQR4+DjfoLpUlHZZAiOnvXWB2L3sZdrW504=;
 b=VmTlfNJvLVMUcq+eBb5znHlPcqalJvAPPtsukN3O8yzLex0PG7i1Szk+mXa1pxaGx4txGSTppKyJ0oSIGQS98WNKT1NNPLey3juXQqoVHpKnb27uUc3vwawCvK5ha6NTiulji3gXoLdHTPVrJSTm+LTdNz4JRcDxAJSP9nQiMuA4TU0O5du9y/9sioZcswwuhknct23+1/FeIoSi71Qa+CEXk/Y5mZVJzMrBUO9v2q3TgIPvXQE/D5Rh86raauWb8WtrTQenqWpHin4/O0cTR5/vxvKMBcVHWNVE5RbAMIH2NDlly9698hY6nadVhC8YEgmxK9I0sx50BHMQKMAUqg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8197.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 12:43:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 12:43:12 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] firmware: arm_scmi: imx: add MODULE_LICENSE/DESCRIPTION
Thread-Topic: [PATCH] firmware: arm_scmi: imx: add MODULE_LICENSE/DESCRIPTION
Thread-Index: AQHa+OsPgOB7um7KHkSqk+kwsYAo7bI8IU0AgABLlYCAAC+T4A==
Date: Wed, 28 Aug 2024 12:43:12 +0000
Message-ID:
 <PAXPR04MB845929FBE17BEBAFE9B9A04288952@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240828014746.1713728-1-peng.fan@oss.nxp.com>
 <PAXPR04MB84595AD3A570948EA8593ED488952@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zs7yTYSb1OeV2dc1@bogus>
In-Reply-To: <Zs7yTYSb1OeV2dc1@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8197:EE_
x-ms-office365-filtering-correlation-id: e3438713-5a0e-4ec7-a083-08dcc75efa9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QLNR6w3R/Rvh/jzttpuzrtJXM4WkztQqKKNPCAV7/JcugiLYwWunAPTBTX+C?=
 =?us-ascii?Q?8hGUC/j31G2Oml4FkBLVKaZtSqLduX4ztn+oMrzjx3LdmT+5OhvghgvjnUku?=
 =?us-ascii?Q?SO/l6jJ6+2g+web4W9SdFvmuVnkcQUW/YAWqVxKOvyjyZPoKtaOge+nCdfwo?=
 =?us-ascii?Q?rmvK6O5g5V6pBrfcNdnPHDIcJiN5yampaAWjGi11JE239YT2pSdElGvEcElu?=
 =?us-ascii?Q?OE5zlebLb/vwdJAlRgmFuLFjkP5snCnDX/QtQkYqdSWayd7chaM4v/lfu83S?=
 =?us-ascii?Q?bLegls1fq3CYNvMyl4V3jSRETIPGIP5po1+BHTZU0rl2/z+0oN5vgL4J3uNM?=
 =?us-ascii?Q?QcmrhyVnnV4EfYyK8MoOEXKgKL7Ho0EfoIPWypdVn5M7Bdc/6HXAN222oUI5?=
 =?us-ascii?Q?0m5TVdKEZBlOrcFiiwO8EJo6+SbOzITwKoqFFDJ7XZI8J0nuE6mLG2pZSddL?=
 =?us-ascii?Q?Rl5eCGVewb2wxJ1mUB/EdFp6hGwe0BPi1pJsTDGNp9Frijdpj5GWAP4xFBxJ?=
 =?us-ascii?Q?o8e/M/D8P46fON6G0etmfXoyre5nJswaqQ6cjCejliVpKTtLihAxBC0JUHrm?=
 =?us-ascii?Q?d1/PMkJF8MQe7zQy4mKyA5geAssixe8dWOzCSkd7TeDEdbaEbQDXIuzjAH0B?=
 =?us-ascii?Q?lMec5UZndX5G8JoEGlmNLGI6cRt+5sSKv+qO1LKDQgEBZthLHcFKFSOobTyQ?=
 =?us-ascii?Q?Fxg9yKTpTP4u74DebWSRDZffC69bBgsZIw0VjvvprgCD8qqWGMOX1xRt2z/F?=
 =?us-ascii?Q?kNwQ5N0d/dTRso4/wsZ/7XenklHDEQIQkAMsala1VaBbIL3BBUOkl8H6m/0B?=
 =?us-ascii?Q?h4jkOv+4cSYrnC3BP/LTcOgh81wmr0C/cdRiB00IZtrs68A4COgMqsVaom/B?=
 =?us-ascii?Q?FAy5HjhCAg566HmkpHUfmjuiNlNdWXv1gAL6oIxCFSqffBhC/RO45W3oe6Qm?=
 =?us-ascii?Q?iPkmBb7IB4qY7KGZSoCOOf8heoggngTf3mwZQkoO7/P9IJvRwUNeRW3oYgIC?=
 =?us-ascii?Q?HwoyyR5f6Bq9Lrx1owGu4M+kP1KAiR4uM4I8Mj998C79kfRjGngdrq+EWg0U?=
 =?us-ascii?Q?/++YMv0kcQxTIYTuNi68Y3dATh9FrXBt//gyDjmJ7gelS2UvFvc5oP0csDKH?=
 =?us-ascii?Q?/og4CHS28qwJQ9uFL4jhBZGLbIa8EsV78i6ofPb3XeFVj6IxgX+BRJw3E+AQ?=
 =?us-ascii?Q?tHOyfA4QKk0/O1f0iweQnFEukjK9w3Zxb8HEgbS+a1HBUHpd4jRWHy3MAer5?=
 =?us-ascii?Q?GAbnn/b5U7b8RYTbY9OD9NsHoDlI4vuf+f6/yL/8p/zIeGAIthIBtlmMFIUF?=
 =?us-ascii?Q?zIJGlw4WiAA4x/TlHnNazzevtwvjyn1YzqoLKP7PuLWrqa1wcmOVrtKaoOMl?=
 =?us-ascii?Q?HvP2aqNxHaVntMI6i22EzSjpaZZnMF1FQbmiJbrdGFdjJZedUw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8wgxT+GN7m+T6W2Drr+ProCZ0ru0jYIIWuLIcUOO2S7J2r2VCAKeNz02Dz4v?=
 =?us-ascii?Q?cK29ats89TpUuC6J5mOUy7ONd/HMEZGuNynsJDhJYGQadIyMR61OlNudOGDb?=
 =?us-ascii?Q?bVslO6O3cP1cLxTVEyKq5c6irD4Nrp5MGxsJH1x7enUjsKyElq4rx4R8CkYl?=
 =?us-ascii?Q?725UWR9/UzBmTBVOxS6/lXI+G69mk2SM0eDGUnqY7oGzIMjOK4YlwbcRqM67?=
 =?us-ascii?Q?Q9aG+fOD9PSTLqAPZOANPfNaQLZuJg/So3jB740EKEyDm7lpRFsU+Mm1GpKn?=
 =?us-ascii?Q?AwjlHEGez9tBjp9uF2x35ZDSpUdFqKjRWfGmNxoTotSuSR6aoo77IsTlJhKw?=
 =?us-ascii?Q?w0XuX6fzUNnyCIIrm4rUYoHU9FTmAmtFgjuQ7XX3IinGX4aVO9EKjqVZutgP?=
 =?us-ascii?Q?Hjo0d/2HhcfxyAh+KVllLmud1Oa7vPMxaEmrzs1gv1kRk4dIwFUgkUIQ2YEs?=
 =?us-ascii?Q?3X9eXjsZCxWDcxf8ei4Pif0AqR50tiBgOg3cVuo5/MLNcjlgU168LThM72f2?=
 =?us-ascii?Q?92WZPythgQMJX0oLIqjXT8n5Gj1LU1JsPe6xKD4FZyQ6ES9i5c1Ov706lb6q?=
 =?us-ascii?Q?JWPXhO7ceFa4whHu+yIJTGK2itBt4td2KJSS69RJOkMIYubQjlzGxEHt6Mm1?=
 =?us-ascii?Q?8rqN528/SMsXWRI4ReUbcAEopYhB0XDytMd57EltzqjaV/AjKTXg4UA+z/OZ?=
 =?us-ascii?Q?wI0MVgGF4r66bmX+R83tVWN4B+hAplNW3yyZMalAHFVzCJoso9StpKnlnoiq?=
 =?us-ascii?Q?8Qu/1zYhRkqIc9U7X94jIdTmEAAcF+SVS2qHIscUgMfTMw9fHXL+lNRxJpVX?=
 =?us-ascii?Q?u1kW4S02opKc+IxdVivB6aqfhWSVLSPk0F2g7oe46oQkEpGOxqV75zrB3HUn?=
 =?us-ascii?Q?lX+BXN2sIcU8TV5MZAeVo/ydwkF2nZX8GzZwepILox5BnTiI5kY9d0Mzcyq0?=
 =?us-ascii?Q?sDGTFaHGCztax8qOg7EAfyOdrD1XEHkJbuWEpmzJa26KjVN6FvppVRViVdmZ?=
 =?us-ascii?Q?AxCYxA+Da+YmIaFwdpUa3MvJcliLa7Ma5s/VPp6vFyo2jDPzv1/7ji2sPaQW?=
 =?us-ascii?Q?l1W5uPA0WUQ5moIMZfTkw0H/tmPDKmFnR3ZzWEfjnfJy4qJbfl0oQNEHNiem?=
 =?us-ascii?Q?8Kw5I97u9K9Z3H1TTEfcUyRu/fiejyvKIjoJCcsGVDhCEh6SySpvmdhy7vZd?=
 =?us-ascii?Q?f/N90mK3hEUUNWgBmkgTHW998tizgfNC4DXWq4lQdsSbfo12usA+0qKqCAEi?=
 =?us-ascii?Q?eBs68fYdb0pYcnOwsueSVdXfOXkpnHeAzLpq9LxGgI6s/vB5TckeVQajB1Gi?=
 =?us-ascii?Q?DJb5pSJ8H5sFnsndPg1zegGxll3nNo36jltOyFW6HgBrBlEBY1kQe6VLSTeU?=
 =?us-ascii?Q?yvK3zgOmwFsuERT8SWXh+kwl0//iwlf71LFkCXqll6AMNjdvJFkJs+vamWb+?=
 =?us-ascii?Q?CYXeIgUxM/Md1yiQoHyiWpvivAoLadG0HCeJ0ypVe+09Cb2F84a0cLE46Z1t?=
 =?us-ascii?Q?MR44PSzIo+b47kXzKPfRG/+E1S+Pk2lgMv9s43uxhvJZ6B8uGMbd1k737YUj?=
 =?us-ascii?Q?/iH5zTtwm5i2EqLs20k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3438713-5a0e-4ec7-a083-08dcc75efa9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 12:43:12.4704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5k2UnRLYR5Yajw5adpX0YuFpIN2bb/+16FXb2wWlnI+TvYSe1RCtku0ek+RGNP0SmKQtkNtak2v9pcRQsHHk0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8197

> Subject: Re: [PATCH] firmware: arm_scmi: imx: add
> MODULE_LICENSE/DESCRIPTION
>=20
> On Wed, Aug 28, 2024 at 05:17:27AM +0000, Peng Fan wrote:
> > > Subject: [PATCH] firmware: arm_scmi: imx: add
> > > MODULE_LICENSE/DESCRIPTION
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add missing MODULE_LICENSE and MODULE_DESCRIPTION
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > Hi Sudeep,
> > >  My bad for not build this as module. If you need me fix the
> > > previous patchset,  please let me know.
> > > Thanks,
> > > Peng.
> > >
> > >  drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c  | 3 +++
> > > drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c | 3 +++
> > >  2 files changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
> > > b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
> > > index 0df7ca135c34..ad8734d2aeab 100644
> > > --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
> > > +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
> > > @@ -377,3 +377,6 @@ static const struct scmi_protocol
> scmi_imx_bbm =3D
> > > {
> > >  	.sub_vendor_id =3D "IMX",
> > >  };
> > >  module_scmi_protocol(scmi_imx_bbm);
> > > +
> > > +MODULE_DESCRIPTION("i.MX SCMI BBM driver");
> > > MODULE_LICENSE("GPL");
> > > diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> > > b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> > > index 9ee2d204d607..1d339cfa6ecf 100644
> > > --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> > > +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> > > @@ -313,3 +313,6 @@ static const struct scmi_protocol
> scmi_imx_misc
> > > =3D {
> > >  	.sub_vendor_id =3D "IMX",
> > >  };
> > >  module_scmi_protocol(scmi_imx_misc);
> > > +
> > > +MODULE_DESCRIPTION("i.MX SCMI BBM driver");
> >
> > Just find this Typo. BBM->MISC.
> >
>=20
> I was about to ask the same. Please take time needed to push out any
> patch, no point in rushing and churning unnecessarily like this.
>=20
> Anyways, I did hit the issue last night and fixed it locally but didn't
> push out as it was late for today's next. Please check if
> https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/co=
mmit/?id=3Dfor-next/scmi/updates

Your fix is good. Thanks for helping on this issue. I will take care
next time.

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep

