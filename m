Return-Path: <linux-kernel+bounces-423148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331799DA37A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B471656B0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38D01714C0;
	Wed, 27 Nov 2024 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zuehlke.com header.i=@zuehlke.com header.b="SQ0Yl6ID"
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021083.outbound.protection.outlook.com [40.107.167.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2181272A6;
	Wed, 27 Nov 2024 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732694584; cv=fail; b=kkf9wmgJDfrHI+UJq6e+uhHm12jO7QbliagsUVf+ZFiQFca0k+c63H2geXA6t8GU6Qo2enmCf9cagIs/Ev0CVTt1PJqK9ZqPdI9qQpQTc+TmZkvo6/vP0TF5Viiam0MdTzBw/va5Y+dUW5AVgifO2TTiaj4w2uOg1m8765h1pMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732694584; c=relaxed/simple;
	bh=2OD9xDhRAb6MdIINUr8mXqWbXLONnSlvjVUrnXfGVB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IOeiVPmixj1TfLM2lKcn90SlwNyI1meENMnAdyTRYEfgoMncggV4HgoTgXzEK7ix3k0abZrpX4kPBItWOorwirASYbFPqdjJ+KFx/nPR7gdWue7+AgSW69jx41vNlaPkJ8thmSMavh6jU5dvmcN45D2pXboJLQCNnK84uFf+EL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; dkim=pass (1024-bit key) header.d=zuehlke.com header.i=@zuehlke.com header.b=SQ0Yl6ID; arc=fail smtp.client-ip=40.107.167.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMdJHBkbAbrEszfVi0ReYszWWCspW6rKHH/9Bs81jzbXn2/UAGsoTzlH4KL0XQwFAeNdFZmK2/VYccVcZlorsmmkhRb/w5KtP2VBmP2ABT4qT4+kJcl+APanBpi4ZHHrzH/beIm9DyUsLsUPkyXcZo0fIrTJ/mCYHM/HZD9BvQMqr9jmoegYQobxseQcAqrO3m+/OTBDqOLUHXcxAtfZL0HL/KAP+poEZ4GfGg7s3pNfJ2P5oVijTwEHCXo+/F7t+CfvSE4f5lmdao+TR/0uulehv6zdb17NXlZ6LymI9pBwb87nWTC+uXsrQLQijzCwIO6DJ5NYEotD1vA7yBxIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjIpro7rWVBCYyCj7ADdP43WVnMpDlz2W3/a4OrEnSk=;
 b=pTxdpUMwX/NpLU2XU2bl6798QF7tCWjROivuPZUA5O6LGSHvoTSAGBOQSiA5fXV2hsBDRM+iItQbPE0lvQAVz3/p+gz29q695MUjFr024oIJ3ThQfN+eCT2Kzfh5EiXOfwDtY7w8CdQNSi8CpyJjYSm7IN+xZM2N/ZY54WbPoo4CHnqrwJ++QeHY82wQty6qEgci5bdiIlqqrZ+ZrjXIvjyrgFJFrd/f4LkZMT6OtDj/bH12fZhczjFT9a8OD4nvvUiZFLsoOlPz1J+jS/CHMBjhtDMHUfGFCuDZOPIEWQWEYMkEjNV6NNp5Ei5W/6YQPo8U5BWbaDng6lmoNPnbuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zuehlke.com; dmarc=pass action=none header.from=zuehlke.com;
 dkim=pass header.d=zuehlke.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zuehlke.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjIpro7rWVBCYyCj7ADdP43WVnMpDlz2W3/a4OrEnSk=;
 b=SQ0Yl6IDqSfrN278aMd5/tsdwSvmx9DaxxRozI4gPc7Zs+sbCykke0COXxkqhUB+Hv9xKZTjUqxbpHxNelYxo1h3JyqP5cacAaIvCok+nQyzpFSRFr6oIYu7ay3YSW04dY5kTi/TpdZfjIFGuLle0YhDnHHj/JJy0N30Emr0348=
Received: from ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5c::8) by
 ZR2P278MB1055.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:60::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.13; Wed, 27 Nov 2024 08:02:55 +0000
Received: from ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c887:bd2f:4c91:3d13]) by ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c887:bd2f:4c91:3d13%3]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 08:02:55 +0000
From: =?iso-8859-1?Q?Facklam=2C_Oliv=E9r?= <oliver.facklam@zuehlke.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: Biju Das <biju.das@bp.renesas.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "von Heyl, Benedict"
	<benedict.vonheyl@zuehlke.com>, =?iso-8859-1?Q?F=F6rst=2C_Mathis?=
	<mathis.foerst@zuehlke.com>, "Glettig, Michael" <Michael.Glettig@zuehlke.com>
Subject: RE: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Thread-Topic: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Thread-Index: AQHbNmuKAbQgSYuDD0+aIkfTlZwMRLK88xQAgAAYJXCACtFsAIAC7fPA
Date: Wed, 27 Nov 2024 08:02:55 +0000
Message-ID:
 <ZR1P278MB1022EC72C26F483A416DB1979F282@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
References:
 <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
 <20241114-usb-typec-controller-enhancements-v2-3-362376856aea@zuehlke.com>
 <Zzsp2JOhnnPPOWvB@kuha.fi.intel.com>
 <ZR1P278MB10224924F48419CA813402309F272@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
 <Z0RRQoRN7721FF-Z@kuha.fi.intel.com>
In-Reply-To: <Z0RRQoRN7721FF-Z@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 9.16.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zuehlke.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR1P278MB1022:EE_|ZR2P278MB1055:EE_
x-ms-office365-filtering-correlation-id: 6a9185bc-278e-4e6d-6739-08dd0eb9e693
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?59UmNsShY6dyJbpeNYoPKjNmF8hiMkEAiASasXWuY+sRPEcgujFt3ZdSFW?=
 =?iso-8859-1?Q?xiuRAUugGclbE/P8uBKUGsrNdVSSuuZGAleYcQR+Q55VRcG28lOeFBF1cU?=
 =?iso-8859-1?Q?ulMMm/9jUtwuQ769l4OOegUkD7UpdR49netRnhJhMWhmrzkrYPn2bQHoW1?=
 =?iso-8859-1?Q?wKOjffYcT1/PHBBGIYvQoU1clSs6TPn1Dqvy6jl0PZXBlAMw9x3O9/vUdO?=
 =?iso-8859-1?Q?XxtvM2dTcvsWhI7eGI6VOPUjXNAPoQFBb3GQuk8iy54RvGXse4a5i/TRWJ?=
 =?iso-8859-1?Q?KGZcvSTHaJeLPk4/6TCjk7D0mh8bfZ+A5Ks0e+AcEvSkSTefXXaxYwJH1U?=
 =?iso-8859-1?Q?xQ3Ms+qJ1Jd9f06D2nv5drtIZr9upt9grXOqgI5vpNMnAODvKsYF1vWzaL?=
 =?iso-8859-1?Q?D940jAqT8OAYrI/eYXCvHpqir6JyqeBS2PYqE2prKc1cW1uuYzvJVY+Qtg?=
 =?iso-8859-1?Q?lU15gmAcAro8+PwzSf8KBbAWkrc//Lp3UDEE/hVmDyTEALxHuMnLVbpQUv?=
 =?iso-8859-1?Q?TbQIFIUig9hxz1e/CfE/aMt0Wa+oqm+QpFcLBPCuhY49XkJKcP5fSV8/c5?=
 =?iso-8859-1?Q?Nu8VNAezg4pi++8MGGFn1fp4sdt1vh8gA1WZ+6h+FjLyAB57vVxx5TWWzG?=
 =?iso-8859-1?Q?kFSWLjn6G8gFQACRp/sESZAJ7rXLybjj+mTwudtUP8vZ1TteTBxIFfEp0I?=
 =?iso-8859-1?Q?T3TBHwEuRWI1RCECNkiGlZTmklg2gGC9qShhzTuX11qQBZmIUfEXKEefbo?=
 =?iso-8859-1?Q?uB8AyikJajP7hqM6RmQrge/1oFyA/e//5Vim1EN0aOJRvoexpTNZrh//T2?=
 =?iso-8859-1?Q?FCymz2OpafSWOoqp18yxj0mcUB4btXn4TBvog0Y/76X/IV2M24J/vooCOC?=
 =?iso-8859-1?Q?c10i7cbBb4jExdPfaeEpz5oc9yPTP6rFTOfONztq61Y39JMI6sX8YowOIY?=
 =?iso-8859-1?Q?4W5WWcBx0hsdC6oVtYmv5XfbgcVQoE4tJRo/S3sOpJxEtzJdXmxeK7Cu4H?=
 =?iso-8859-1?Q?9AzIaKiujm2Slb1cbqxe2rO+M+OMD20EPKVpbrz98olQ1DM1SjzQcf5sgA?=
 =?iso-8859-1?Q?zrcYtYpQrtwaPxw5uvzfLIWfSO7wXRkfp2m1Y1Ai+kDffu82CFBK70D0GG?=
 =?iso-8859-1?Q?uDId+at6GEACskUVkpPbYqc30hA0/uvMd5Kl/cOAmK6QqQx0f0Ke+10DmE?=
 =?iso-8859-1?Q?4jLcAa8x8xODAct6FmQ5ZwOtjCSITVF79mQr7/WC6AXzQM6Mowntagv1gB?=
 =?iso-8859-1?Q?wixoCXcrexzHUEOngJSmB4/ayEv6uMAEL+b34kSaWIa8OQDl4LXRqaRNDf?=
 =?iso-8859-1?Q?7AZg4IA230i2wY3/cFHgV9IBu50yPvQuFvPNj9Ku0U379HlEluvAC0+XUX?=
 =?iso-8859-1?Q?+1enZAWFgClkLm9gitNXn7JDHZpzpb8Grv/ikHpNo+zVXOeceBtKA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iGM6VYSxw/ujGohNk6FPIaEofF1f+UwLHZbN9BxyP/NI64VJ8vYGF7ne2Y?=
 =?iso-8859-1?Q?iJtHrz0wwg22FH/wsRo05HtB9g8yB9aySGzE7adcmWC/xEZXkGdToR3FpK?=
 =?iso-8859-1?Q?R7Br42mInEVNuw2AinoOdysw1qMzMPHbNM8juWdUNGp2QDsc6gTsw1NmcY?=
 =?iso-8859-1?Q?yyZHxnbGvOLWrkN950WGVCYQxUwf16Fz/jlMCawBKNTy/2xMmaqlVfJQ79?=
 =?iso-8859-1?Q?18l01+z6Yz+HcP6wIofV2mntxaaEDPXuoRLcXkFwHJ00JyuxhOPNOS1dGl?=
 =?iso-8859-1?Q?RTBYCCt6JIrZ3bgBMNw/5WyDRErvat6zdfx1tW2u7kxQOYXe7uSGoXO4Vu?=
 =?iso-8859-1?Q?qev/D17EMMRF1yqV3HWeN+ZgbJ6JzoDCRExJIay5HL4zuc9oNUVC4YPTj2?=
 =?iso-8859-1?Q?V0xCids2jyDbJtkeNMsUJmetsUPKE8DIBpE+AxWXEWj7Wao6gsCdIK1B8M?=
 =?iso-8859-1?Q?m4TsTNCDdKWebn7oysUvbsOWT2yyoSQSkAtwubsaxTFmPRZL0arbF+862q?=
 =?iso-8859-1?Q?XpS0feVyTjPxlDC6k+sLawhrLvkmoIcegsA1wz5txzySLE5mfz8Tidp3M1?=
 =?iso-8859-1?Q?DS6pOpcMIFP5yWP6uQAQ+mbZwqwFKoWhee9EKdE0vV7l+WlClDIvJ/4LKL?=
 =?iso-8859-1?Q?pwNBQD/4O+WqPppAN36GpVQLMhyf8aqFsKJcZfXcPsIWOIu2QSfyhoBtwo?=
 =?iso-8859-1?Q?rt055TmhKUQb9TuTWkn3lGopJaM18ojnrsku9SY6cZab7jP/asLDhJoeWy?=
 =?iso-8859-1?Q?n/m5hjfsQQhUiDjOFo2hhGdtce8xE/nn/lk3VjfgSpUrKElbqzizY55R+w?=
 =?iso-8859-1?Q?GJwVVdXX/mtSX5mjqiM3Lk8P86/TN63UwBJGOkwGuSW//L2D4ptvXBt5m2?=
 =?iso-8859-1?Q?GsG5NBCm1q/fP0VLv4/1o4kY8+PdVYgsF7q+ASBmAdsweI0E1kezDeEH8K?=
 =?iso-8859-1?Q?ciSV4W1zPs2uNB0SzbaMIceyUvcxbO9MQP2ECMLju4UehD67/f9O3w3ekA?=
 =?iso-8859-1?Q?6qkLTl/HLt0BxbcH/OJns3htAb8tdfSSPTEyGPLNbC+6ZoxO9KBaV7vN8z?=
 =?iso-8859-1?Q?q+G966ZTC+2njy72NAEyHEuFalUJSJ3/ohXCCsvhiV5ffsRcTurdbK4Xiq?=
 =?iso-8859-1?Q?dwPr26sTY13p+bX931Yn0L8fQSdzDXjV+yCvh5SD0AJkIDOYc2+oegJOWU?=
 =?iso-8859-1?Q?IiLAtThA/wQ5dej1rfKlOn5MhTpYA90MsXZo1QBEh04Pr2h5x3k1bWXi4P?=
 =?iso-8859-1?Q?uJyoyeWgJ4pMkiyQOAunDJ4ZbKVcr5AzLPUlf99erMoC9dealezKh/oyh1?=
 =?iso-8859-1?Q?UEWiblyiNP1UJy/e/uPIy28foXk+xyiv5TAuU/wpXD3U+A1hAFqR/NGb6p?=
 =?iso-8859-1?Q?wa5rqnw//jpqSwaEtdeNGNmm6uu2wt97PnY27EIWAuPdX1LfXE04EwcpC9?=
 =?iso-8859-1?Q?dk6MPUAguz0NdIn/H4raU9NPjV81xieiyI0qyb6+f+1iL6mOe0/mqWtBab?=
 =?iso-8859-1?Q?F7Su3OwOIILYT0mew/RPTmI8y7o7WrwVfPI253ca7wgyL7rtWPHXZAiJIB?=
 =?iso-8859-1?Q?AK1Cf4h+dszVQEa/fxUw3c9GzK+oJICpYS5yAWmfGSsCdV70b1/YDuJeZv?=
 =?iso-8859-1?Q?HJLW489y4amrb9+AxCvkcP3aMlPbhq4pea?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: zuehlke.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9185bc-278e-4e6d-6739-08dd0eb9e693
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 08:02:55.6567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccce7f5e-a35f-4bc3-8e63-b2215e7d14f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwupsSPAt1GR8Jky/CanNv0UwgDsUqzZO4nwf1NKQFRJ3pNAvJRBldUgYcBkCuLtUZAXVs81hR+kGJxpGSMgdgeY+NpwiZoHGi2bxLo6TfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1055

Hi Heikki,

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Monday, November 25, 2024 11:28 AM
>=20
> Hi Oliv=E9r,
>=20
> Sorry to keep you waiting.
>=20
> On Mon, Nov 18, 2024 at 02:00:41PM +0000, Facklam, Oliv=E9r wrote:
> > Hello Heikki,
> >
> > Thanks for reviewing.
> >
> > > -----Original Message-----
> > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Sent: Monday, November 18, 2024 12:50 PM
> > >
> > > Hi Oliver,
> > >
> > > I'm sorry, I noticed a problem with this...
> > >
> > > On Thu, Nov 14, 2024 at 09:02:08AM +0100, Oliver Facklam wrote:
> > > > The TI HD3SS3220 Type-C controller supports configuring the port
> > > > type it will operate as through the MODE_SELECT field of the
> > > > General Control Register.
> > > >
> > > > Configure the port type based on the fwnode property "power-role"
> > > > during probe, and through the port_type_set typec_operation.
> > > >
> > > > The MODE_SELECT field can only be changed when the controller is
> > > > in unattached state, so follow the sequence recommended by the
> > > > datasheet
> > > to:
> > > > 1. disable termination on CC pins to disable the controller 2.
> > > > change the mode 3. re-enable termination
> > > >
> > > > This will effectively cause a connected device to disconnect for
> > > > the duration of the mode change.
> > >
> > > Changing the type of the port is really problematic, and IMO we
> > > should actually never support that.
> >
> > Could you clarify why you think it is problematic?
>=20
> It's not completely clear to me what it's meant for. If it was just for f=
ixing the
> type of the port to be sink, source or DRP before connections, it would m=
ake
> sense, but since it can be use even when there is an actice connection (t=
here
> is nothing preventing that), it can in practice be used to swap the role.
>=20
> And in some cases in the past where this attribute file was proposed to b=
e
> used with some other drivers, the actual goal really ended up being to be
> able to just swap the role with an existing connection instead of being a=
ble to
> fix the type of the port. The commit message made it sound like that coul=
d be
> the goal in this case as well, but maybe I misunderstood.
>=20
> Even in cases where it's clear that the intention is to just fix the role=
 before
> connections, why would user space needs to control that is still not
> completely clear, at least not to me.

The idea is to give the user the possibility to control/restrict how the po=
rt is
operating even if they have an actual dual-role capable port.

Let me clarify. In my use case, I have a DRP port, and in most cases I woul=
d
like to use it as such.
However, there are cases where this operating mode causes additional
difficulties -- for example when connecting to another dual-role port=20
implementing the same role preference (e.g. 2 Try.SNK devices connected
together). Then the role outcome is random.
Since this chip doesn't support PD, there is no way to switch the role from
userspace.
When I know I'm going to be working with these types of connections, it
would be better if I can restrict the operation mode to "sink-only" (for ex=
ample)
for that duration. Without needing to change my device tree.

Sure, the mechanism can be abused to switch the role on an active connectio=
n,
but that was not the primary idea here.
I would even argue that calling a port type change during an active
connection terminates that connection, and starts a new connection
from scratch with the new behavior.

>=20
> > > Consider for example, if your port is sink only, then the platform
> > > almost certainly can't drive the VBUS. This patch would still allow
> > > the port to be changed to source port.
> >
> > In my testing, it appeared to me that when registering a type-c port
> > with "typec_cap.type =3D TYPEC_PORT_SNK" (for example), then the type-c
> > class disables the port_type_store functionality:
> > 	if (port->cap->type !=3D TYPEC_PORT_DRP ||
> > 	    !port->ops || !port->ops->port_type_set) {
> > 		dev_dbg(dev, "changing port type not supported\n");
> > 		return -EOPNOTSUPP;
> > 	}
> >
> > So to my understanding, a platform which cannot drive VBUS should
> > simply set the fwnode `power-role=3D"sink"`. Since patch 2/4 correctly
> > parses this property, wouldn't that solve this case?
>=20
> True. I stand corrected.
>=20
> > > Sorry for not realising this in v1.
> > >
> > > I think what you want here is just a power role swap. Currently
> > > power role swap is only supported when USB PD is supported in the
> > > class code, but since the USB Type-C specification quite clearly
> > > states that power role and data role swap can be optionally
> > > supported even when USB PD is not supported (section 2.3.3) we need t=
o
> fix that:
> >
> > My interpretation of section 2.3.3 is that the 2 mechanisms allowing
> > power role swap are:
> > - USB PD (after initial connection)
> > - "as part of the initial connection process": to me this is simply ref=
erring to
> the
> > 	Try.SRC / Try.SNK mechanism, for which we already have
> > 	the "try_role" callback.
> >
> > Maybe I'm misunderstanding what the intentions are behind each of the
> > typec_operations, so if you could clarify that (or give some pointer),
> > that would be appreciated. My understanding:
> > - "try_role": set Try.SRC / Try.SNK / no preference for a dual-role
> > port for initial connection
> > - "pr_set" / "dr_set" / "vconn_set": swap power and data role resp.
> > 	after the initial connection using USB-PD.
> > - "port_type_set": configure what port type to operate as, i.e. which i=
nitial
> connection
> > 	state machine from the USB-C standard to apply for the next
> > connection Please correct me if any of these are incorrect.
>=20
> I don't know what's the intention with the port_type attribute file
> unfortunately.
>=20
> > > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > > index 58f40156de56..ee81909565a4 100644
> > > --- a/drivers/usb/typec/class.c
> > > +++ b/drivers/usb/typec/class.c
> > > @@ -1535,11 +1535,6 @@ static ssize_t power_role_store(struct device
> > > *dev,
> > >                 return -EOPNOTSUPP;
> > >         }
> > >
> > > -       if (port->pwr_opmode !=3D TYPEC_PWR_MODE_PD) {
> > > -               dev_dbg(dev, "partner unable to swap power role\n");
> > > -               return -EIO;
> > > -       }
> > > -
> > >         ret =3D sysfs	_match_string(typec_roles, buf);
> > >         if (ret < 0)
> > >                 return ret;
> > >
> > >
> > > After that it should be possible to do power role swap also in this
> > > driver when the port is DRP capable.
> > >
> > > > Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
> > > > ---
> > > >  drivers/usb/typec/hd3ss3220.c | 66
> > > ++++++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 65 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/usb/typec/hd3ss3220.c
> > > b/drivers/usb/typec/hd3ss3220.c
> > > > index
> > >
> e581272bb47de95dee8363a5491f543354fcbbf8..e3e9b1597e3b09b82f0726a
> > > 01f311fb60b4284da 100644
> > > > --- a/drivers/usb/typec/hd3ss3220.c
> > > > +++ b/drivers/usb/typec/hd3ss3220.c
> > [...]
> > > > @@ -131,8 +183,16 @@ static int hd3ss3220_dr_set(struct typec_port
> > > *port, enum typec_data_role role)
> > > >       return ret;
> > > >  }
> > > >
> > > > +static int hd3ss3220_port_type_set(struct typec_port *port, enum
> > > typec_port_type type)
> > > > +{
> > > > +     struct hd3ss3220 *hd3ss3220 =3D typec_get_drvdata(port);
> > > > +
> > > > +     return hd3ss3220_set_port_type(hd3ss3220, type); }
> > >
> > > This wrapper seems completely useless. You only need one function
> > > here for the callback.
> >
> > The wrapper is to extract the struct hd3ss3220 from the typec_port.
> > The underlying hd3ss3220_set_port_type I am also using during probe to
> > configure initial port type.
>=20
> Ah, I missed that. Sorry about that.
>=20
> > One point worth mentioning here is that if the MODE_SELECT register is
> > not configured, the chip will operate according to a default which is
> > chosen by an external pin (sorry if this was not detailed enough in
> > commit msg)
> > >From the datasheet:
> > -------------------
> > | PORT | 4 | I | Tri-level input pin to indicate port mode. The state
> > | of this pin is sampled when HD3SS3220's
> > 		ENn_CC is asserted low, and VDD5 is active. This pin is also
> sampled following a
> > 		I2C_SOFT_RESET.
> > 		H - DFP (Pull-up to VDD5 if DFP mode is desired)
> > 		NC - DRP (Leave unconnected if DRP mode is desired)
> > 		L - UFP (Pull-down or tie to GND if UFP mode is desired)
> >
> > In our use case, it was not desirable to leave this default based on
> > wiring, and it makes more sense to me to allow the configuration to
> > come from the fwnode property. Hence the port type setting in probe().
>=20
> I get that, but that just means you want to fix the type during probe, no=
?
> Why do you need to expose this to the user space?

I've been thinking a bit more about this "fixing the type during probe" fea=
ture.
My current implementation always fixes the type, even if no device tree ent=
ry
for "power-role" was found. Could that cause issues for people relying on t=
he
configuration through the PORT pin?

I could consider a solution where if the property is absent, the type is no=
t
reconfigured during the probe. Although then I would have to do manual pars=
ing
of that DT property. With typec_get_fw_cap() from patch 2/4, I loose
the information about individual properties being present/absent.
Would be interested in hearing your thoughts.

>=20
> > > >  static const struct typec_operations hd3ss3220_ops =3D {
> > > > -     .dr_set =3D hd3ss3220_dr_set
> > > > +     .dr_set =3D hd3ss3220_dr_set,
> > > > +     .port_type_set =3D hd3ss3220_port_type_set,
> > > >  };
> > >
> > > So here I think you should implement the pr_set callback instead.
> >
> > I can do that, but based on the MODE_SELECT register description, it
> > seems to me that this setting is fundamentally changing the operation
> > mode of the chip, i.e. the state machine that is being run for initial
> connection.
> > So there would have to be a way of "resetting" it to be a dual-role
> > port again, which the "pr_set" callback doesn't seem to have?
> > 	This register can be written to set the HD3SS3220 mode
> > 	operation. The ADDR pin must be set to I2C mode. If the default
> > 	is maintained, HD3SS3220 shall operate according to the PORT
> > 	pin levels and modes. The MODE_SELECT can only be
> > 	changed when in the unattached state.
> > 	00 - DRP mode (start from unattached.SNK) (default)
> > 	01 - UFP mode (unattached.SNK)
> > 	10 - DFP mode (unattached.SRC)
> > 	11 - DRP mode (start from unattached.SNK)
>=20
> Okay, I see. This is not a case for pr_set.
>=20
> I'm still confused about the use case here. It seems you are not interest=
ed in
> role swapping after all, so why would you need this functionality to be
> exposed to the user space?
>=20
> I'm sorry if I've missed something.
>=20
> About the port_type attribute file itself. I would feel more comfortable =
with it
> if it was allowed to be written only when there is nothing connected to t=
he
> port. At the very least, I think it should be documented better so what i=
t's
> really meant for would be more clear to everybody.

After researching some more about this operation, I came across the driver
for TUSB320 [1] which seems to have a very similar behavior (also from TI).
[1] - https://lore.kernel.org/all/20220730180500.152004-1-marex@denx.de/T/#=
ma7a322bc207414e4185c29d257ff30f5769f5d70

For one variant of the chip, the implementation relies on the CC disabling =
like
in this patch. A different variant tests the current connection status befo=
re
proceeding.

>=20
> thanks,
>=20
> --
> heikki

Thanks,
Oliver

