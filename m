Return-Path: <linux-kernel+bounces-401434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7D99C1A63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF351F23D48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F3B1E283A;
	Fri,  8 Nov 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zuehlke.com header.i=@zuehlke.com header.b="qyPohfHB"
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021107.outbound.protection.outlook.com [40.107.167.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4E1E1A3C;
	Fri,  8 Nov 2024 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731061750; cv=fail; b=W0LQ1pVLozIIFVnECSCIytjNSKHRdwfDjqlKb5PSnIeB5lIHTCeCqkyyjZBjycVhqrf7v1q+PH6X546arWm2ykGd5fdst17RpnO5kPRGVKozIun52o4B6FQCLR7E5itJPOzub1c9MjjB2CdFh1S2dsf43yZ9sKzu/eISWTrV3kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731061750; c=relaxed/simple;
	bh=uj5g1LzU314sEybJuDb+Z7XvvwafZIh/g5r7hKue8nE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gVGRKtAfW9T5jN8QiYWRaZZ4Y5WktAUwU31FBdWm+UBlNQHZkt9CpHMuAWaypJX/mmNi20od2+B7bDVLBzEa39MFtmXY2tSnY0xVf5jNt6Jkwr1/XeKE0Mhk/fe2XCfY4v5l+f309e7pIscm9SPHtgt5bKazKn6N1P6SkQceStI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; dkim=pass (1024-bit key) header.d=zuehlke.com header.i=@zuehlke.com header.b=qyPohfHB; arc=fail smtp.client-ip=40.107.167.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=go8NzSCzAAXu8+8ydV6jb1fbCEKRV9dKTiIVnBxOA9918QWDDw51MJ2Jcyy3nXJODJC7RXp2ODb1N56lteAF8SBT7NGiGOiLSMccSOq4UiwtpcypeOrFPigHB4guFWuuZx+VPNFf5eRNdIXQxSJrpDBoK7hwzM7artbTgjMqFSz4bx+nHo0fqzeOs8NLwDH2nLJDaOAV/NqJyuRTAb/c0X6zWleyJujfFCxIXovQV81liJ+eJufz2DqOXYR2vjUQug/kFHFw4awQSm+5iE5nZ+GU/tvVZsGIVNZGLyPHQUKlNDPKTr3WAt0ZQngkXFYwZFX1C6Lvtv5eVzf2Ncqi0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOnn87gcSKZ9uoEVd18V1mSybkCB9wfS82IOvdFMUtM=;
 b=wUDU4qbh14eQl0nWFZP79JupZlNin/7wA90sEjCM51+BtFSuzgacgSsgwxmcto6hTOg60JcBWLViCaK8lAVWfE3uOWRpf8vJSl+fsxrGyo3OHuZSQEj5nnyayYwsW38NLuYB9xMuliZliLoDXhbLCSiJVAXpqIMNJb9AYqTHMBWGcikn0i7imEAP2GCvew8Fd66xjZNQN3wbmjtM7U9bI0L36GsW7HCpc46wEcvPwAEutHW6hpCIwxPJHeAPYAjzdQhPBygyhiGQQukuT73XqYAJKQ/Owx5DRKbr2mPphazJvRzjS8c7pm1tSlyhIL2kgDXhl9bTJhSWccZl7Es2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zuehlke.com; dmarc=pass action=none header.from=zuehlke.com;
 dkim=pass header.d=zuehlke.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zuehlke.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOnn87gcSKZ9uoEVd18V1mSybkCB9wfS82IOvdFMUtM=;
 b=qyPohfHBXVODzZc5nog+pHAFtEwTlSOrpA9jwbcCd+zN/rpajiJAxvnNSoZsdmZl8yry9Lqy4kBvE6m7gjeOT/H1Ce6ZaAafzYu3zU0TfT3hx7AinuhWiiYdhtzIAh9DO/xpoEUCXAs30gm1GLV/IoPwWOINWm30DUvRJu4xGms=
Received: from ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5c::8) by
 GV0P278MB1174.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.21; Fri, 8 Nov 2024 10:29:01 +0000
Received: from ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c887:bd2f:4c91:3d13]) by ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c887:bd2f:4c91:3d13%3]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:29:01 +0000
From: =?iso-8859-1?Q?Facklam=2C_Oliv=E9r?= <oliver.facklam@zuehlke.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "von Heyl,
 Benedict" <benedict.vonheyl@zuehlke.com>, =?iso-8859-1?Q?F=F6rst=2C_Mathis?=
	<mathis.foerst@zuehlke.com>, "Glettig, Michael" <Michael.Glettig@zuehlke.com>
Subject: RE: [PATCH 2/4] usb: typec: hd3ss3220: use typec_get_fw_cap() to fill
 typec_cap
Thread-Topic: [PATCH 2/4] usb: typec: hd3ss3220: use typec_get_fw_cap() to
 fill typec_cap
Thread-Index: AQHbMQpZRMDOf5Sy+EeARSygMyuP/rKr3nQAgAAHWRCAASLQgIAAJwkQ
Date: Fri, 8 Nov 2024 10:29:00 +0000
Message-ID:
 <ZR1P278MB10226D24060AEAB29E3E7E2C9F5D2@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
References:
 <20241107-usb-typec-controller-enhancements-v1-0-3886c1acced2@zuehlke.com>
 <20241107-usb-typec-controller-enhancements-v1-2-3886c1acced2@zuehlke.com>
 <ZyzMzEHA9DPMc_z9@kuha.fi.intel.com>
 <ZR1P278MB102298AE3011962AEE1BC91E9F5C2@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
 <Zy3G6dyvvpU4A6NO@kuha.fi.intel.com>
In-Reply-To: <Zy3G6dyvvpU4A6NO@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 9.16.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zuehlke.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR1P278MB1022:EE_|GV0P278MB1174:EE_
x-ms-office365-filtering-correlation-id: c320df4f-7569-41da-e18b-08dcffe02948
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?FEzWK8+FwO9qRy8pKdY45y+KisMV4WQUDRfDTOCPVv78dNfIlLxyzSwvgr?=
 =?iso-8859-1?Q?2aqvs1Jeg3z/eaXYNfwzhSrl17KQOwx5YC2OewdLTMSi4uJVAY5UXT/DZj?=
 =?iso-8859-1?Q?oUGB2XdBVHIQd0PTPBTfOG4m7IS2LnaMNt5EfFo1IrK3R8IKD5IcTSZ0tb?=
 =?iso-8859-1?Q?4uRO/Fu4NpThsfPBSnaFA1zGWsOGkWhIJ7wu6yAMOoi+ZkEV3Vujyate8H?=
 =?iso-8859-1?Q?tfxkrS+zFXbPV6XLDuohbBfwq1VJvkTkfJron4mL4elGBx4myyiiqkRv4j?=
 =?iso-8859-1?Q?5Wzt4WxLylwwb8BwNrfyojHOqYZYl/XTZer7ANig0yQ5Hh+y/DUHCPcNaP?=
 =?iso-8859-1?Q?hqarNTNxCnZh86VM3+xqvHmcu/hkZQdlSwNyOqeNvnjgBvfE2x/Qcu5s3z?=
 =?iso-8859-1?Q?z9XKMbvhAwNrvgBCezuyxL340UBdVUgYUquiVwwuLUTuFjWUW21zPMiqvC?=
 =?iso-8859-1?Q?5XI0uYg6hcHXSrmbOeHUknoXd36R+YEcFFvFdeOkJbT28H7+kRrWK1OtcR?=
 =?iso-8859-1?Q?1IiekbyuplVBxtCXH9hkeKTCFkgegHiPpLRngKbxOCbfS42LmGxEJPLoGS?=
 =?iso-8859-1?Q?4SdUIH3+XdXV+m4hUzEbnHBCUTYEiVMtje4gM9tMECkdtzFfQuwFtv6WHV?=
 =?iso-8859-1?Q?jEB6FoMzNq84fsupC0c/6C5eobU3bnZSI51hOKsxlcUrudXhKLYbVHWdCC?=
 =?iso-8859-1?Q?XxZV+TwW26Mpw5BHl/UMOsypnanWY6QCcrA56Jk+oNbOtCXtE2KWLk7HU1?=
 =?iso-8859-1?Q?AqIasF930rzxlSXAC54rkr0EHp2N5pyeSsnTndfKujgxYv4Ot8i+pKPrXu?=
 =?iso-8859-1?Q?FR1DLeuNt/sTrRRtIyStRTiMkSaNfh0xZ3RT50i33FRa2qsjHwpv1RZCit?=
 =?iso-8859-1?Q?sN0TmUlPgwP3WmQ1uzdmH6ksjDZVr32QmS4zHTKzJzdhimSnK92CIIToDo?=
 =?iso-8859-1?Q?rKNCUqkTrnprkAEaIcXIVLQnTb5YVI/9CAJD4Cc1SXgNbHOLbu2ji50LGh?=
 =?iso-8859-1?Q?hYvKnKSaFTRJfDahLaet7S+XCw/8mMXkTSHIhSIjKdehZJokekXoP5Hm56?=
 =?iso-8859-1?Q?x9kbfHNzpk06ZGFGcevsuArZ0lZ+gICfqwI3RhyLp8/uoOnoxjt+IewqZB?=
 =?iso-8859-1?Q?XHOMn54XAxIa+Jm6Yg/2XV+2gCx/ypN1zh4ZRUiV0q0VeDLubv7eedpVsf?=
 =?iso-8859-1?Q?U4YCpBoH1dq6s3pLmaO8DmEdQVmTp3FGntaAY4zHC7Xp8TRyORO/y2aeFc?=
 =?iso-8859-1?Q?HPurBEeeRmIJ+F3sNgLSF+WimynHGL2R6SwJFH7qTehFPHbFTdpmTU9eBO?=
 =?iso-8859-1?Q?o0rqMMmSUdBbdkDTlrR70RgCe1Rf3lnbixow51X7JC8QQEUbGyO4OS0jdT?=
 =?iso-8859-1?Q?NmIBvoQ5kduk29BGRGWIHc4S3NiE8iWQ2/7zMSjiiwdFq9aTaucf4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dBypjLuJrKAGyqewpFyzSi6Njk7XwAwhoCO3FdLdiAza+xfbIX+//H7dtb?=
 =?iso-8859-1?Q?Rps0MKqV3pUYt3JROXx1hbM1Mk13YYC/c9ieC8jNZLQZAdninwm7XLMQ7Y?=
 =?iso-8859-1?Q?fdnud+SJ8VANjyGJVZuydTKBHYy1P3+7aU6JfJf/l9dZ9OaRY5w7upBA6E?=
 =?iso-8859-1?Q?AYfMFCCv0dvSI07rQnObIX44M78VkS3xcOAjc42Wf+hK5U2EH0/8LgYQ84?=
 =?iso-8859-1?Q?E0OgVa2tmcwZPVEaqecICSQM8LvGboLdgUpene/EadWVotuczOCP2TOkWi?=
 =?iso-8859-1?Q?8XjdEDUltC+DFxhCiMogBezIXLnTMtaK2HKBDeS/5T5A+nXNz4B5RC17XW?=
 =?iso-8859-1?Q?svHP3NBfbQ0ypWATZXsNnhJ3iE4kdWj4/DbFFaM7wyU9fAuYBqJh2eK33Z?=
 =?iso-8859-1?Q?ccH0fSFASUxqW0FrQJV3k5oy+f15FfQV6x3ZpnL4X2NAWHIcqpJL1gfew7?=
 =?iso-8859-1?Q?gPg+9RAp3aoteVPkvEPmOe10HBWOrFhRQ/rYlgSv1Xm3nEsRZ9HvLdT6Gt?=
 =?iso-8859-1?Q?vhnls0TIbYftVy2R7dRzhryXYqDH8EZnhVs677u9pzkDcaRPu2EtV9cXyY?=
 =?iso-8859-1?Q?NdP+AAKD2wpXmLkQAs2KwH2ZPq33suwzIxVNAUQRFCsyUh7OxGJwtNiB2J?=
 =?iso-8859-1?Q?cUMHSu9Z0i+Qx++CxaImoEb+7wNjmuXLBtn1rze8Cktv8m+n3iuoKd3y3B?=
 =?iso-8859-1?Q?UV/UhJ9Q2MYuLR2Y7pSZbgvQw8gQAed1qvMuz9pKmIQIQeqjleBKqyljJX?=
 =?iso-8859-1?Q?wpg7AuLE2x1BmyexQ09Dhds4hbmm/grzwq823+NyEILCVS2hYwHplufGu6?=
 =?iso-8859-1?Q?fkO0fdzMVM9tNXg96tpqJ91QaShujMBD48zAVZcRzrM1dEXl4diV8xnoUt?=
 =?iso-8859-1?Q?NGF5sEvlxn5e8n1KoIsKQXVO46idJC33JxgdT8qX1PGvHqJZAiObZeSr7I?=
 =?iso-8859-1?Q?6Y+DzcTEvkSSp8GwUOAxeAAdrE1jX9pmttCzo+VgRhKTmzpHCguZoscMJn?=
 =?iso-8859-1?Q?D8P4pkOVBrZMOQ3xgDONRTyXM6c4ONbT8FehljqPGdrhYwbU+tdJAoo2M5?=
 =?iso-8859-1?Q?kcEUKKTj9AMbK2SXWgoxgx8qWpzIRaSoz5xWhlfTqZRZQ/068GpQTRPFjk?=
 =?iso-8859-1?Q?HY3bQMdezaD+z+orfi5aO0kxck42s1lOdiihG/1RaiSQpkP5WtxpQlfRc1?=
 =?iso-8859-1?Q?AwPTSrVxcS7AVdSr9NMi3uEbVacwpbXoo1kfsTwArSZQGGSLXNj2SEr2dC?=
 =?iso-8859-1?Q?ZjKhkQp2YpvyPbnILBBS9HKtZgdgpg8bBp4Ia30t6aqMSdObyfFNAP4BhE?=
 =?iso-8859-1?Q?DkpjwmH0FV0wf5IXK2Um1EkLLVaNlfdVQLya+E54a/EUqlVtfvVSfR76we?=
 =?iso-8859-1?Q?fi9X8Fs9nqc0ydakyMFwNGDkNeKj69x1NQRBu5sFpluCkqanONjymZ+NvC?=
 =?iso-8859-1?Q?ih8576Q12FD6iN26MS6CAOFhb2U2QfyIqfipq2W+qd0zi38AG2OwJ3RT7W?=
 =?iso-8859-1?Q?XEV6LmxnTCoV0MUN+BBgz2PqaFROvAmLEpf7pTIkqzhBwu0l9FAbS5Truy?=
 =?iso-8859-1?Q?RIdbQk22OBeWfu2oPEYmp7gbr8UY67AaWdZKrolRCEqtJXD6KTzxhIYyM7?=
 =?iso-8859-1?Q?4b7KCgbOEdXRbhAMQdLH8tWkNAHYYhisalTTVZY3frE7dshgvNJ9QxfA?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c320df4f-7569-41da-e18b-08dcffe02948
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 10:29:00.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccce7f5e-a35f-4bc3-8e63-b2215e7d14f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUvUG5Ai9TZVivhB3AZfELcRg06CfZmGC/d72kaaRniZM1SF0Az7sIe90VYX3bSuFTfI1zW9KcEVAtk3YTQ8IkKcCNpOLMaQmy3a60INob4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1174

Hello Heikki,

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Friday, November 8, 2024 9:08 AM
> To: Facklam, Oliv=E9r <oliver.facklam@zuehlke.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> usb@vger.kernel.org; linux-kernel@vger.kernel.org; von Heyl, Benedict
> <benedict.vonheyl@zuehlke.com>; F=F6rst, Mathis
> <mathis.foerst@zuehlke.com>; Glettig, Michael
> <Michael.Glettig@zuehlke.com>
> Subject: Re: [PATCH 2/4] usb: typec: hd3ss3220: use typec_get_fw_cap() to=
 fill
> typec_cap
>=20
> On Thu, Nov 07, 2024 at 03:24:44PM +0000, Facklam, Oliv=E9r wrote:
> > Hello Heikki,
> >
> > > -----Original Message-----
> > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Sent: Thursday, November 7, 2024 3:21 PM
> > > To: Facklam, Oliv=E9r <oliver.facklam@zuehlke.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> > > usb@vger.kernel.org; linux-kernel@vger.kernel.org; von Heyl,
> > > Benedict <benedict.vonheyl@zuehlke.com>; F=F6rst, Mathis
> > > <mathis.foerst@zuehlke.com>; Glettig, Michael
> > > <Michael.Glettig@zuehlke.com>
> > > Subject: Re: [PATCH 2/4] usb: typec: hd3ss3220: use
> > > typec_get_fw_cap() to fill typec_cap
> > >
> > > Hi Oliver,
> > >
> > > On Thu, Nov 07, 2024 at 12:43:28PM +0100, Oliver Facklam via B4
> > > Relay
> > > wrote:
> > > > From: Oliver Facklam <oliver.facklam@zuehlke.com>
> > > >
> > > > The type, data, and prefer_role properties were previously
> > > > hard-coded when creating the struct typec_capability.
> > > >
> > > > Use typec_get_fw_cap() to populate these fields based on the
> > > > respective fwnode properties.
> > > >
> > > > Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
> > > > ---
> > > >  drivers/usb/typec/hd3ss3220.c | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/typec/hd3ss3220.c
> > > > b/drivers/usb/typec/hd3ss3220.c index
> > > >
> > >
> 56f74bf70895ca701083bde44a5bbe0b691551e1..e6e4b1871b5d805f8c3671
> > > 31509f
> > > > 4e6ec0d2b5f0 100644
> > > > --- a/drivers/usb/typec/hd3ss3220.c
> > > > +++ b/drivers/usb/typec/hd3ss3220.c
> > > > @@ -259,12 +259,12 @@ static int hd3ss3220_probe(struct i2c_client
> > > *client)
> > > >  		goto err_put_fwnode;
> > > >  	}
> > > >
> > > > -	typec_cap.prefer_role =3D TYPEC_NO_PREFERRED_ROLE;
> > > > +	ret =3D typec_get_fw_cap(&typec_cap, connector);
> > > > +	if (ret)
> > > > +		goto err_put_role;
> > >
> > > You are not leaving any fallback here. Are you sure all the existing
> > > systems supply those properties?
> > >
> > > There is another problem. At least "data-role" property is optional,
> > > but that will in practice make it a requirement.
> >
> > I missed that typec_get_fw_cap() was not setting a default if the prope=
rty is
> absent.
> >
> > >
> > > I think it would be safer to use the values from the device
> > > properties only if they are available. Otherwise simply use default v=
alues.
> >
> > I'll add back the previous values as defaults before calling
> typec_get_fw_cap().
> > That will make data-role and try-power-role optional again, as intended=
.
> >
> > However, "power-role" seems to be required by the function. Is this
> expected?
>=20
> Yes.
>=20
> > Or should I write my own fwnode parsing logic?
>=20
> No, don't do that.
>=20
> You can check the return value. If it's -EINVAL or -ENXIO, the properties=
 are
> not there, and you can safely use the defaults.
> Otherwise, consider the failure as critical.

Thanks for the hint, will do.

>=20
> thanks,
>=20
> --
> heikki

