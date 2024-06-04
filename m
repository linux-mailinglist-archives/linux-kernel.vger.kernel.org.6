Return-Path: <linux-kernel+bounces-199891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC708FA74F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8FE1C224CF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265D68F4E;
	Tue,  4 Jun 2024 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eEOyGjCF"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A88811;
	Tue,  4 Jun 2024 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717463174; cv=fail; b=OSgxRxswLxXHtX88WseH9LkmqzEDgnjLwZ27b7zoveF0y2KXLc/xu9uZZdw9F9iRAguLrRe9VnVN01vIRty8slDkrzthwTvjYCCdnHh9mUpKqWX63NWzwiPZDuGOw+11S3uz7ZR+h34BoGxhnDWLu+MnaO1Sd/WLAJudlqYKyVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717463174; c=relaxed/simple;
	bh=/P25ly1s68JRn87aZi7doivI5I/9Ir7ruZzjC/5qwnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tdWRawPr8XhcT/IwyZ6HUww8iggXhgTYr2hx0/zFSDaSXwvDWGhThMQVqGG8IsH7l87Qq2P3ABsUC7VxR5Lshbp7/u4cJHAnWRik0lWHeP4ly+AM0IMKrxP6g08l6FW/wa654Btj/UpOQW901BMrxY4GWAG0FqIwLB2OOXi9epw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eEOyGjCF; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGtcqBKf1NJ5AfTGbmiqNmoOnOIL6hza6Oo9JClGpW/hDUcvZlKvCDcFjxgboVXR20KxCa7U8OR0I/1V3be5Z2StulFD612k3So4WAfCcAGv5/JOsRPr8tcAyDS/yVDaE0leqB4XdAwixjxsyfojCHUEriRkb3hYqMvMo7FhHAnhRP5eB1fQaocPqJ8SyIMXb0NlUfqiM87kG/H8aYUJDMm2VTO2iXhHyzQ/A7jjr7QNkUI5s16kWBP/wpg54/gYKxf1wJ5dxXnWIzQ/v5cc1G4Hm5qiubljWKScJvrlu+HBsqDyhse3tUXbiL57l67/gxTCHTyBtGQj1SI2inSgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0zcaSnIO/LDywco96erfXVafP/Il/tOxWFNVQsv+Lg=;
 b=O4h+yHSvRLunYRMA2suAz3sl3IA20MF/Nd5hF8ooTVMNStfCU6YcnmVpz/rCjDbI8bITpr4i9eNIyZb5Rp1yz9pRr74Zob9if8w+WBcp9k/P/AnK4CfhNflslNqHfNtpGDkDffgOAR28a+aGl5UjR5TKJ/Vrk9iLQ5WC72Qh8nUqkDjq9yWzODO9D9Qo+5sJRf1rLGJa7zXokwYyIFRLdZsmsePnLOO0n7V19AiB9w85/EPencuM6KYF5kctDxYcHD09FIWKEJP9EYw380mzUK14qPEpqHOSFSU7V9kTSTSIaFiimoWvGdUUAyiVe8ira+b5g5WmCYWjtCdqu/Ar+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0zcaSnIO/LDywco96erfXVafP/Il/tOxWFNVQsv+Lg=;
 b=eEOyGjCFO0mEE3+xlMOvaJpZwZrBdqFSNCRcIU96BFzJb18CKQxBgQ5S3lrUkFshTBFcibzRgAjuj9cu0fS1c3tf71rvksN1zm/8NlisqyeajdTRstc6qcZCaGZ6wN939m5zD7viAkDYq8LciP22aphJWra79y4DeFBA7qWfy7s=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7832.eurprd04.prod.outlook.com (2603:10a6:20b:2af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 01:06:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 01:06:08 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] firmware: arm_scmi: mailbox: support P2A channel
 completion
Thread-Topic: [PATCH v2 2/2] firmware: arm_scmi: mailbox: support P2A channel
 completion
Thread-Index: AQHaoofRWa1n3T/orEWTm/ueqFE+K7G2XDGAgACUZWA=
Date: Tue, 4 Jun 2024 01:06:08 +0000
Message-ID:
 <DU0PR04MB9417CED7DDF04A348792A7E788F82@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240510-scmi-notify-v2-0-e994cf14ef86@nxp.com>
 <20240510-scmi-notify-v2-2-e994cf14ef86@nxp.com> <Zl3rFTKrctdWcDBZ@pluto>
In-Reply-To: <Zl3rFTKrctdWcDBZ@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7832:EE_
x-ms-office365-filtering-correlation-id: 417d2eb4-1ec1-4e94-a9cf-08dc8432848b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vNlp7xGPRdzZ+IMVPyd8ppjEwHqI+yRHQ1T0rAwc7UIRSoHc+44GxOgjzNWw?=
 =?us-ascii?Q?sEeWCAl+Qel1b5w38HmF99H/JRGu0CGesvHkD1Inq/sEnbPoHKLpeezwEFUV?=
 =?us-ascii?Q?kB6Lg3A7G/wE754O+m7WxltEr7ZfAeig0f1yx4t7/UCBm2lcKOlSVP+tvquB?=
 =?us-ascii?Q?n+hZlc0udVExdr3AY2KAh4qWzM3fdgzENqxxhET4XSV1KeIpDiYD4UPzXj+O?=
 =?us-ascii?Q?QJEqU/zImZPbnroqq/HdhTgyNnnvBLQGtypadefI2fd29Aj+XBy1Mmft95Fy?=
 =?us-ascii?Q?7ppOcyfYdn+UdukRnlDjg7vBaja3/HX8Ovmhxy4tPqmLegwiI69aLkMYhx3T?=
 =?us-ascii?Q?0/LmkfFbOz3+MYiyrgL2hXf+lnZBeVU0s05aGvdmKWhUow71Yyz7WgWUf74f?=
 =?us-ascii?Q?6kQzZd+7Lsi/MOaitvhSCbsHGd7cpb2eN9/HGzbwLsL1gGVrGyczbR0VhEG/?=
 =?us-ascii?Q?oB7TI0uoNUtTkGcwigwbZ0q7cFRwWACNl2S6XZNKMS4KyoQPfvE5ianpXYkh?=
 =?us-ascii?Q?xjY+l/XQH3mOm5trCEyIoa4p7R7Z13vJ8gRpyups64vwf5ptDjgQG84dubWs?=
 =?us-ascii?Q?UBPqqymLsy231vdRzg6+K/fcsqrJX0JL9Xd3IFD9OMXmTOPL6WJ4tAD4i997?=
 =?us-ascii?Q?YE7Wcv5vvDZ4U/p3SzlFB+paNvxEsHSg/aEIRmTHD+VgC7BxqEoKggWA1ryG?=
 =?us-ascii?Q?ppOE9JI/U+ecjloMgkDNm1fbHYBKnzgcRwFHaulzPIW6i6a3qczaedBi59XC?=
 =?us-ascii?Q?gv0vbCVKod4fD4VEXBCUiMNGxcDOquRZovsbUhdcAO7GsvVSxedawMKckSAj?=
 =?us-ascii?Q?yXbiXFPpYlUvCk5fx6E0fnOYqTqEv2u1U/KzgMv3abhru1jqL2x5TjgznMZ+?=
 =?us-ascii?Q?2kp3Y9MSTrkelpyVcddZmUQZU08uw6mWUlqmsFKPJB+fSB7/G5wZj4bQ2fxd?=
 =?us-ascii?Q?+Mt/tfRY+CPfRyENrA+o/vd1XiYEty4ynjrGmOdDcpfPMccsqw7O6aJxnhy5?=
 =?us-ascii?Q?5fru+2sJTEm5ZxA39EpMtz4i0Qo4OeZy4mYEY5pl03v8vcWX4AOqD0sNfQeH?=
 =?us-ascii?Q?/t/NguHJ8FmfacXkfN9RXx0lBpEh0rDov/tas6Jl5eUIgugDyezDQAp5MWs1?=
 =?us-ascii?Q?VTP6jd7cusBwydvwMw2mxh6F1yP7MBbjPrPgjtgqWA72EHBcASzLiHjvaebZ?=
 =?us-ascii?Q?YfkQbrvJi/jDbjnSVOVihgeQgNmP/OgNifM2Wu5daape0SfhYD59Gr7wUv0u?=
 =?us-ascii?Q?wuYs+JbX4B3VTuOBIrkq8aDgxrlCQz7qgF94njkovreu6Ff7Vgaxi6qqiobv?=
 =?us-ascii?Q?JjpP7nbN83hydbfD1bVXcaslrioQELizzWE2oTuEsZrVEw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i75CbqLxIZDleTexmWEtzc+GxRCvbpeg8OnawYv9u7+jkvMXJ7O0UV9Tk2KZ?=
 =?us-ascii?Q?igJ9UC0V+JJs4rSEPrOV2/tk4y8bbxzmdvfQFzUKl6DJxL2hVutbi9JNnqgu?=
 =?us-ascii?Q?FymheSWdLabe4LK5XM9+aXz4WWDnzkKbATPVia4XGurB8ypl3Mx28kkY282y?=
 =?us-ascii?Q?dPQX9gpiOSw97Jk2BhmvLvferQ+BgMFYiKEKEBjhNqumaG/PrEec7Z84hTyR?=
 =?us-ascii?Q?A2Fs6FaDswfFD+ENPBa5HAWAH5L5HfthnPmDSdhegGu7lceAyCYg4LH+PxFc?=
 =?us-ascii?Q?jdBuuGFnNis+ywYiJHfOmDeE98ZPEwI5WbDOYP3sdRxtawoUr+PRaqr9Zlwi?=
 =?us-ascii?Q?5Ti3Js4HNhiiBJjm2igdR0BBrlx39/p3S/1TSeKol+HlR63AnAyYZE4aUIUt?=
 =?us-ascii?Q?UwcELOlaSoR3dJ7MPxVrm2h9gpm5KIaeoIe/Km8mA30wvyKZ/1mQLU8iWrKD?=
 =?us-ascii?Q?X6wpazajeldpbhMsV/w9NFCWu04dG3kghJ+kutKWcHgQRVLjLI9xRi5Qa55t?=
 =?us-ascii?Q?OuACTKQPoFpoENb54X6VlmIKijC4LofKukaSgwuvat9yuPR3pIdaJDZtmgg2?=
 =?us-ascii?Q?nTgw+95tnvSv6Z/rsAiGZ+xoY3OFtBw6vGJpzL2gIT8FwKXWOb+iQzzTBo2S?=
 =?us-ascii?Q?R2c9Z7TttmMSasIifxaeK58p+EDUDz0tziCft9IX45B28HB+ARZBe/89Bhb9?=
 =?us-ascii?Q?k8XsCffwKwFqNk+ZTYsTuSzqUawC5BKe2ebd2Pk6cwq1iz7uqJ4lUnNvEDXk?=
 =?us-ascii?Q?qiExo32y4i3PBsgz5Riga/xOWagLzXWK9wV3CF9eEfYVFp+uweoszzlQ7Dyq?=
 =?us-ascii?Q?OUu+4cjZGeNqe2Q9IbWdQCBRj+OOsZQH86qgdzBXsLV7i5UNWkauvkm43H5o?=
 =?us-ascii?Q?hnr/8/IsTihWihXr0QxN3SP4ur4zMWljm3fORIGlEPf/VeM/1PhZtPDDfU2u?=
 =?us-ascii?Q?3mkydc7Zi1OjcmPsZSnG5JywAP1xzEYGvbAXgMN3VCdWFGjZK/uvUWgqLsXz?=
 =?us-ascii?Q?FmNZor/qF2tco2ek2PZXAkCAwETeRdZSDdk5pz0r1TINwE9jA1m9c2nz9jnV?=
 =?us-ascii?Q?c0rDDLaPArW83qijym1GHd/bkcoZlaZTY34yRgWJOvFpCMw25uM/EymIkgdT?=
 =?us-ascii?Q?ELgg+tQ6YfeWg6RctaeubTOLusR8Lg0U6pv4ATUPOanUtKz1SZJf7+tFaLiK?=
 =?us-ascii?Q?GyBgRakaC2OXL0aRDq5++Zmglcxo4VVHZbaOHVYo3QlGPrXsAXnU7qjtLk17?=
 =?us-ascii?Q?+kGGeMiudfoja7Unk2fifXoq/185FWPsdY1KVzto2Hb/tYZkyAKTEWwNKJDs?=
 =?us-ascii?Q?Lap5G1ellTlFhIuw8+EjW3p6mRB+vjAW2GZtbkBCYE4Z9DpBgSSwt//7uMYy?=
 =?us-ascii?Q?TzLW3/yQ29QlDRZuVUNzkQCSgdrMUUMS8vkW/7KdeI7QRF5IarOUhtqkjerf?=
 =?us-ascii?Q?kqMdOT8DESA4kvqR1f72C3PQn7m56J71Jn1KW22q8tcyRU23lwquBSwVshOR?=
 =?us-ascii?Q?ZZiQh11atisvZwz22AXEWddZ7K/bbuLH79LBi/FyIvVFUL9PGm5hQMsc6ZKO?=
 =?us-ascii?Q?5Q6HIUgNGPISTg/EtOI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417d2eb4-1ec1-4e94-a9cf-08dc8432848b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 01:06:08.6508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6K8j6N05TDvOXXBZgV9324xx9OweS3sN98fc7DqBeIQaSleNUQIHKhc5cPmMbkk1Ojh1LcNbuxc9HQMP0M9CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7832

Hi Cristian,

> Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: mailbox: support P2A
> channel completion
>=20
> On Fri, May 10, 2024 at 11:19:48AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX95 System Manager firmware is fully interrupt driven. The
> > notification channel needs completion interrupt to drive its
> > notification queue. Without completion interrupt, the notification will=
 work
> abnormal.
> >
>=20
> Hi Peng,
>=20
> Thanks to have addressed also the case of mailbox controllers with
> unidirectional channels for P2A completion, but I have a further observat=
ion
> down below, which I missed last time.
>=20
> > - Add an optional unidirectional mailbox channel. If the channel flag h=
as
> >   INTR set, and the completion interrupt channel is provided, issue the
> >   mbox message to Platform after the channel is freed.
> > - Support bidirectional channel completion interrupt.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/firmware/arm_scmi/common.h  |  1 +
> > drivers/firmware/arm_scmi/mailbox.c | 60
> +++++++++++++++++++++++++++++++++----
> >  drivers/firmware/arm_scmi/shmem.c   |  5 ++++
> >  3 files changed, 60 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/common.h
> > b/drivers/firmware/arm_scmi/common.h
> > index b5ac25dbc1ca..4b8c5250cdb5 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -326,6 +326,7 @@ void shmem_clear_channel(struct
> scmi_shared_mem
> > __iomem *shmem);  bool shmem_poll_done(struct scmi_shared_mem
> __iomem *shmem,
> >  		     struct scmi_xfer *xfer);
> >  bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem);
> > +bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem
> > +*shmem);
> >
> >  /* declarations for message passing transports */  struct
> > scmi_msg_payld; diff --git a/drivers/firmware/arm_scmi/mailbox.c
> > b/drivers/firmware/arm_scmi/mailbox.c
> > index 615a3b2ad83d..adb69a6a0223 100644
> > --- a/drivers/firmware/arm_scmi/mailbox.c
> > +++ b/drivers/firmware/arm_scmi/mailbox.c
> > @@ -21,6 +21,7 @@
> >   * @cl: Mailbox Client
> >   * @chan: Transmit/Receive mailbox uni/bi-directional channel
> >   * @chan_receiver: Optional Receiver mailbox unidirectional channel
> > + * @chan_platform_receiver: Optional Platform Receiver mailbox
> > + unidirectional channel
> >   * @cinfo: SCMI channel info
> >   * @shmem: Transmit/Receive shared memory area
> >   */
> > @@ -28,6 +29,7 @@ struct scmi_mailbox {
> >  	struct mbox_client cl;
> >  	struct mbox_chan *chan;
> >  	struct mbox_chan *chan_receiver;
> > +	struct mbox_chan *chan_platform_receiver;
> >  	struct scmi_chan_info *cinfo;
> >  	struct scmi_shared_mem __iomem *shmem;  }; @@ -91,6 +93,8
> @@ static
> > bool mailbox_chan_available(struct device_node *of_node, int idx)
> >   *		 for replies on the a2p channel. Set as zero if not present.
> >   * @p2a_chan: A reference to the optional p2a channel.
> >   *	      Set as zero if not present.
> > + * @p2a_rx_chan: A reference to the optional p2a completion channel.
> > + *	      Set as zero if not present.
> >   *
> >   * At first, validate the transport configuration as described in term=
s of
> >   * 'mboxes' and 'shmem', then determin which mailbox channel indexes
> > are @@ -98,8 +102,8 @@ static bool mailbox_chan_available(struct
> device_node *of_node, int idx)
> >   *
> >   * Return: 0 on Success or error
> >   */
> > -static int mailbox_chan_validate(struct device *cdev,
> > -				 int *a2p_rx_chan, int *p2a_chan)
> > +static int mailbox_chan_validate(struct device *cdev, int *a2p_rx_chan=
,
> > +				 int *p2a_chan, int *p2a_rx_chan)
> >  {
> >  	int num_mb, num_sh, ret =3D 0;
> >  	struct device_node *np =3D cdev->of_node; @@ -109,8 +113,9 @@
> static
> > int mailbox_chan_validate(struct device *cdev,
> >  	dev_dbg(cdev, "Found %d mboxes and %d shmems !\n", num_mb,
> num_sh);
> >
> >  	/* Bail out if mboxes and shmem descriptors are inconsistent */
> > -	if (num_mb <=3D 0 || num_sh <=3D 0 || num_sh > 2 || num_mb > 3 ||
> > -	    (num_mb =3D=3D 1 && num_sh !=3D 1) || (num_mb =3D=3D 3 && num_sh =
!=3D
> 2)) {
> > +	if (num_mb <=3D 0 || num_sh <=3D 0 || num_sh > 2 || num_mb > 4 ||
> > +	    (num_mb =3D=3D 1 && num_sh !=3D 1) || (num_mb =3D=3D 3 && num_sh =
!=3D 2)
> ||
> > +	    (num_mb =3D=3D 4 && num_sh !=3D 2)) {
> >  		dev_warn(cdev,
> >  			 "Invalid channel descriptor for '%s' - mbs:%d
> shm:%d\n",
> >  			 of_node_full_name(np), num_mb, num_sh); @@ -
> 139,6 +144,7 @@
> > static int mailbox_chan_validate(struct device *cdev,
> >  		case 1:
> >  			*a2p_rx_chan =3D 0;
> >  			*p2a_chan =3D 0;
> > +			*p2a_rx_chan =3D 0;
> >  			break;
> >  		case 2:
> >  			if (num_sh =3D=3D 2) {
> > @@ -148,10 +154,17 @@ static int mailbox_chan_validate(struct device
> *cdev,
> >  				*a2p_rx_chan =3D 1;
> >  				*p2a_chan =3D 0;
> >  			}
> > +			*p2a_rx_chan =3D 0;
> >  			break;
> >  		case 3:
> >  			*a2p_rx_chan =3D 1;
> >  			*p2a_chan =3D 2;
> > +			*p2a_rx_chan =3D 0;
> > +			break;
> > +		case 4:
> > +			*a2p_rx_chan =3D 1;
> > +			*p2a_chan =3D 2;
> > +			*p2a_rx_chan =3D 3;
> >  			break;
> >  		}
> >  	}
> > @@ -166,12 +179,12 @@ static int mailbox_chan_setup(struct
> scmi_chan_info *cinfo, struct device *dev,
> >  	struct device *cdev =3D cinfo->dev;
> >  	struct scmi_mailbox *smbox;
> >  	struct device_node *shmem;
> > -	int ret, a2p_rx_chan, p2a_chan, idx =3D tx ? 0 : 1;
> > +	int ret, a2p_rx_chan, p2a_chan, p2a_rx_chan, idx =3D tx ? 0 : 1;
> >  	struct mbox_client *cl;
> >  	resource_size_t size;
> >  	struct resource res;
> >
> > -	ret =3D mailbox_chan_validate(cdev, &a2p_rx_chan, &p2a_chan);
> > +	ret =3D mailbox_chan_validate(cdev, &a2p_rx_chan, &p2a_chan,
> > +&p2a_rx_chan);
> >  	if (ret)
> >  		return ret;
> >
> > @@ -229,6 +242,17 @@ static int mailbox_chan_setup(struct
> scmi_chan_info *cinfo, struct device *dev,
> >  		}
> >  	}
> >
> > +	if (!tx && p2a_rx_chan) {
> > +		smbox->chan_platform_receiver =3D mbox_request_channel(cl,
> p2a_rx_chan);
> > +		if (IS_ERR(smbox->chan_platform_receiver)) {
> > +			ret =3D PTR_ERR(smbox->chan_platform_receiver);
> > +			if (ret !=3D -EPROBE_DEFER)
> > +				dev_err(cdev, "failed to request SCMI P2A
> Receiver mailbox\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> > +
> >  	cinfo->transport_info =3D smbox;
> >  	smbox->cinfo =3D cinfo;
> >
> > @@ -243,9 +267,11 @@ static int mailbox_chan_free(int id, void *p, void
> *data)
> >  	if (smbox && !IS_ERR(smbox->chan)) {
> >  		mbox_free_channel(smbox->chan);
> >  		mbox_free_channel(smbox->chan_receiver);
> > +		mbox_free_channel(smbox->chan_platform_receiver);
> >  		cinfo->transport_info =3D NULL;
> >  		smbox->chan =3D NULL;
> >  		smbox->chan_receiver =3D NULL;
> > +		smbox->chan_platform_receiver =3D NULL;
> >  		smbox->cinfo =3D NULL;
> >  	}
> >
> > @@ -300,8 +326,30 @@ static void mailbox_fetch_notification(struct
> > scmi_chan_info *cinfo,  static void mailbox_clear_channel(struct
> > scmi_chan_info *cinfo)  {
> >  	struct scmi_mailbox *smbox =3D cinfo->transport_info;
> > +	struct device *cdev =3D cinfo->dev;
> > +	struct mbox_chan *intr;
> > +	int ret;
> >
> >  	shmem_clear_channel(smbox->shmem);
> > +
> > +	if (!shmem_channel_intr_enabled(smbox->shmem))
> > +		return;
> > +
> > +	if (smbox->chan_platform_receiver)
> > +		intr =3D smbox->chan_platform_receiver;
> > +	else if (smbox->chan)
> > +		intr =3D smbox->chan;
> > +	else {
> > +		dev_err(cdev, "Channel INTR wrongly set?\n");
> > +		return;
> > +	}
> > +
> > +	ret =3D mbox_send_message(intr, NULL);
> > +	/* mbox_send_message returns non-negative value on success, so
> reset */
> > +	if (ret > 0)
> > +		ret =3D 0;
> > +
> > +	mbox_client_txdone(intr, ret);
>=20
> Looking at mbox_client_txdone() implementation this call is allowed only =
if
> the txdone_method is TXDONE_BY_ACK, which in turn depend on the type of
> underlying mbox controller that you are using AND/OR the SCMI client
> configuration (knows_tx_done), so I dont think you can call this
> unconditionally without the risk of hitting the related dev_err() in
> mbox_client_txdone if the underlying mbox controller was instead supposed
> to issue an mbox_chan_txdone() on its own.
>=20
> IOW, if the mbox controller is operating in TXDONE_BY_IRQ mode or in
> TXDONE_BY_POLL (and that would be the case if polling is used since the R=
X
> channel does NOT set the client flag cl->knows_txdone to true, so
> TXDONE_BY_ACK is not used as an override) this should hit the dev_err()
> mentioned above...
>=20
> dont you see any error ?

No error in my side.

>=20
> which mailbox controller do you use ?

drivers/mailbox/imx-mu.c. The tx channel is IMX_MU_TYPE_TXDB_V2
>=20
> does your mailbox controller NOT set txdone_irq and NEITHER txdone_poll ?
> (so defaulting to TDONE_BY_ACK in your case ?)

Use TXDONE_BY_ACK, no irq and no poll.

i.MX Message Unit(MU) supports many types, but for the i.MX SCMI MU,
we are using GIR(General Interrupt request) to the other side.=20
And GIR will not trigger interrupt on the local side.
That means Linux write GIRA will trigger interrupt on M33 side, but no
interrupt in linux side. M33 write GIRB will trigger interrupt on
Linux side, but no interrupt in M33 side.

Regards,
Peng.

>=20
> Thanks,
> Cristian


