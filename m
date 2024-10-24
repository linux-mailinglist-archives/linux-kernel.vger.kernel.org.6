Return-Path: <linux-kernel+bounces-380741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24BD9AF565
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D512824A4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95853218585;
	Thu, 24 Oct 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=newgenag.onmicrosoft.com header.i=@newgenag.onmicrosoft.com header.b="Rtf5OrZX"
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020083.outbound.protection.outlook.com [52.101.188.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F71C4A11;
	Thu, 24 Oct 2024 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808979; cv=fail; b=SfT3vpUnDtUazSke/BY6dESFgln5zoxqfSLMxOM9w/F2EWd2X8xBTMcHqCH3DiKGh+IvADiJE3mHMNZGAJLwignTKQpyhT5SwoKaOsodIdJ5jvIV3OG27qAlVDBFihVWenz2BMVP+gi3Ayz4AH5o9E2z9rqrA13Yd3NydGmW5Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808979; c=relaxed/simple;
	bh=3XjJOYbPglquQpQzazFrWQCKDZ9oPYO2I0dfHZTiJxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XCkuxIkAK+LF7GuGIzFXQ3fmeIElWZLEo9dlz04vPey12uF6pf51/409yYNA2RAfYbzFoRu0083PJee6j8aAXXwZBS1STYYQPHaeySJVf1CI5YvghOf0pja9G87Yx8tlIYeXLqFXVpRBk+POizwwfVEF4DZUqVa9IZ6NfQeMAW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbv.ch; spf=pass smtp.mailfrom=mbv.ch; dkim=pass (1024-bit key) header.d=newgenag.onmicrosoft.com header.i=@newgenag.onmicrosoft.com header.b=Rtf5OrZX; arc=fail smtp.client-ip=52.101.188.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbv.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbv.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOBhIYDBaP9Tr+0+y6Xt3nhWuvc6rgqupYPp6PyabMmh7sm2dp9FWbY01UTES70HYjlZOsCDS5HCWWL5yizX0VjnbFZblqcrsNcunoZBasZY4AQ3QsgOOYlPAI3TNX6Kc5mHkPB9yg3BcxewQoqa0eo6TdLrtY7tT2ftypt16uIcLCZFfTnJLPPBMm46jSWtUXRoxmb4avwxT88CAgGHa8NohQ/zU/bVhoYLQuHYPcBMQzPhTrDu5iGU5q+wFZGY0J80qVnUO/q67YRqMVi8orh7Xiddiw/TidS1m6C3zcFvpnAYT4lLrD68ZKW7Q2ZecbTmnabUss7Om4HXM3MdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0oZy+0+QXxiH4UjNJWsQKKIpRs16ir1ziojIEw34S8=;
 b=uyIxbdyrWh00TfHqpO4s3qN+VNOo/G22OyS9Q1OeB0aos6Ui1RhzAxixbaVEZeHzLsSmOlIEMu9ajtkJ+8W+PMpT9rSlraJyC8/5CDD7feXjcF4Pfk2/SWjZaAyrhVyCCGILPb/d8CzuSwSqmy21O2LQwJ3QkngI0D1z216lizgNeOOyG9x623p2vG46z78C0ziCldJ/c1z2C+LVu77w2Ugxtr597tuLJJxvtKLc+ioYUPKUsdCIjX/ly5GnlNwHe9TGzKax7bAO4tmzbo2w1IJYfElS3Yj/6CzyL1HPTj41hCgLbGL4jTB3073p8FBwmqs3uZLlWfWGgr3p8EFV6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mbv.ch; dmarc=pass action=none header.from=mbv.ch; dkim=pass
 header.d=mbv.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=newgenag.onmicrosoft.com; s=selector1-newgenag-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0oZy+0+QXxiH4UjNJWsQKKIpRs16ir1ziojIEw34S8=;
 b=Rtf5OrZXjC3/SQVXdOVeEsyGwBWTdFotEbghwqC82ABcGaMVBmQnS8bC63c87df6+uWqAl3SsT5qzFBOzO8Pdsaz9At1OmAnrDp/pa9MSRgTd6HCkpKu/vKIrEiSRb56jE7DwvrhG/ZyP24IUs1JbWGtTH6yJY373iDTsKyPWVU=
Received: from GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:49::12)
 by ZR1P278MB1689.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 22:29:31 +0000
Received: from GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM
 ([fe80::373:3184:90d1:31b6]) by GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM
 ([fe80::373:3184:90d1:31b6%3]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 22:29:31 +0000
From: Yanik Fuchs <Yanik.fuchs@mbv.ch>
To: RD Babiera <rdbabiera@google.com>
CC: "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>, Emanuele
 Ghidoli <emanuele.ghidoli@toradex.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: AW: [PATCH] usb: typec: tcpci: Add FAULT_ALERT handling
Thread-Topic: [PATCH] usb: typec: tcpci: Add FAULT_ALERT handling
Thread-Index: AQHbJKMgIbuGNr/loUWfgfmWPEz2J7KTD5oAgAARR1eAA1rkAw==
Date: Thu, 24 Oct 2024 22:29:30 +0000
Message-ID:
 <GVAP278MB0662AB612A31C98AD252046E974E2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
References:
 <GVAP278MB0662D8077733604B9B103187974C2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
 <CALzBnUHxA8MTHyuWhOOF8GOoohsSz9KN54Aw=CiiJiu9Jz_Bew@mail.gmail.com>
 <GVAP278MB06628A1811E2DE44BAE6AC8D974C2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
In-Reply-To:
 <GVAP278MB06628A1811E2DE44BAE6AC8D974C2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: de-DE, de-CH, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mbv.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVAP278MB0662:EE_|ZR1P278MB1689:EE_
x-ms-office365-filtering-correlation-id: 74bc387c-85da-4c03-eb6e-08dcf47b5416
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?h2qgwt0qgqILSqU4vH6vf5qg0yHD71ydRJUoB4bm45ozbbJT8W5Ew38iLG?=
 =?iso-8859-1?Q?Ba6BDDvwk5ErTV87hby5GLPpu/nXkeoIupH6EmEwe2GkXn8Bb1BFmUHqLk?=
 =?iso-8859-1?Q?AyBKaKIZzKO+hOjBbQ3DKi3h0O5JSIAmx8R8Mf77fknnpntcbyQF7TfZ3w?=
 =?iso-8859-1?Q?8NEKnEVD6inDCiiFduyeTJJrid1qSfX6X87UttNqWA4WxRrbLG3oYp3E9V?=
 =?iso-8859-1?Q?aCQuft/deJtsNjzssODil6y/tehf+NDWSHN61u2rNiWIcfrfDxBwLWmKCG?=
 =?iso-8859-1?Q?ltY4nYzoiDPj/5qJIHA+nG3YMUTeEJ6xjkb8dp3AxVaASjmXIKZo1DwwbE?=
 =?iso-8859-1?Q?LtsLZQGlBnNmxIlK5ojrtYOxjr0z+G1O4yaJNZ2EfU/9Zk7RC/IZ0gamav?=
 =?iso-8859-1?Q?8T8SacoXDGV4KWKSDA8T8AfULNtHpoLZQJUl76M+mVxZfNTEnuWMQlsIen?=
 =?iso-8859-1?Q?5xyUruE2jIYOK9EhHyBXXJwCfWwmm2owPQxHNp7ZiQSp7bJ++eH7Ts2fO/?=
 =?iso-8859-1?Q?cSL0hqXwBKrI6i4pkUnx7fpucRH3JzL6dNzMorCPPwwato9Ie99BKlByUp?=
 =?iso-8859-1?Q?xUsKIKwRn7QU0bNsPSYPJcilG2E8CiFugFnQ8WlEeN6NGV+K9rLkTzOKxf?=
 =?iso-8859-1?Q?fVwzAug5Az3RsYJAwiOWyMenCQD/gU7a6VQz6MOr4V1HBafvLzIbo0H51P?=
 =?iso-8859-1?Q?ioNpahJKHOM/ftKCOsf/JiRoL4RD6feqLL5NRvFWGTLSsU9gbC1tBiFtnb?=
 =?iso-8859-1?Q?0aVQY0xkPcOWSW21x652oC9C2IVYU3K1Jt0FGH/nyCjNkrXZKc3giGKXZ2?=
 =?iso-8859-1?Q?9+O+P6qrlOxaVBvXXKn2/GIh+PkbgaGu0/y89sh96vRrWXUbKfMKOgbtR3?=
 =?iso-8859-1?Q?IpWtijheom7dikpA6ODw9EVxf7BZUPlrDhNYouB2BhtIPc6eRqFZzBuIID?=
 =?iso-8859-1?Q?ZebQ4C/jskdY/h9gXNR53rgBxvl19VypIiiqbo2GBF5Lcd9h5WzS3bkwYZ?=
 =?iso-8859-1?Q?gcn8ywEeP9svrmXnqqApzgLlA7jBl8ZKF0LAcSQFozHZq7JNbO7uOGhCfD?=
 =?iso-8859-1?Q?cPxQ5DXO8w80S9mTnBIdwNGW8bAAq96MxtyR7FC1NmPlA73UCiFjxzOMcx?=
 =?iso-8859-1?Q?A0wYRj7oXcoXEJqr3xH9+htGezo317ww6DQ7ZLNKAsIDyupd7gTsKoRg8s?=
 =?iso-8859-1?Q?6HvKFroYvKJrwyrUR5Nr2hpR4F/fdhK31Og6nVemZesHmI9WtXRSQ/hEQX?=
 =?iso-8859-1?Q?VImAmLIbARiA5CJYjCFDk6J+WHMGwDHkYMdadwI+Iebb78HJYefSEaXB+L?=
 =?iso-8859-1?Q?YuX5pyK9L2dmWHy4iK4+Pp5GAGYZ/+NfpvUuq3G8Vzzs0I1wRQF8QMyyIX?=
 =?iso-8859-1?Q?zaTgM74iyhbmhvX7t2elnTMnu7r8yAM2nXSUfQcG7V+HwMmPgJF8U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zVBjBschDzpZDby8KWpLpjqUBqwT8BbGe825vfFKEA+i1YKdWrlawcxcOY?=
 =?iso-8859-1?Q?QllmQLG9PLFy37081b+Hs4aBxPkx7v1YzIQx2Wt2AATZDZR1R7rrUI93e5?=
 =?iso-8859-1?Q?zJM8KOYs+O5fr/zdmKfzMdftX/MIEJsQQe7rV6WWyGb8uWgsxE8ibP9X2l?=
 =?iso-8859-1?Q?WiadmwhbRPwp9azC96W2wZcybwWX0c4Bzdgce5YCW/Da981l/h5FSN36c7?=
 =?iso-8859-1?Q?46yLYLkCqaEdoSGm7/YZVWryO6+wGFSz5mJJBxDxYkl32k0TZrhJlCFrml?=
 =?iso-8859-1?Q?4DfzTH/W/x1jkszJ4s5O5a/oHuevZE+2YzjP4P5QWFmhuX/6zQfZlPLdfX?=
 =?iso-8859-1?Q?ynWcY+l9O84hK9dd/eaUbP5VjHeS+9kN396brJr7zCsm3iMRAJ8CAxgQXH?=
 =?iso-8859-1?Q?V1s+hmR+ToWZ4QVWaxLCaDGFruNLp66iqmxp9hmcTp1Qoa+L+J+ABGQwkB?=
 =?iso-8859-1?Q?K1o4vXp1F/gVWWptcEKMLHIhTof45QZkIYyLNp3MbP69F8qaBNBEIAXbRy?=
 =?iso-8859-1?Q?tkkSDeAaYD//G6PkvNlS/k/6tugZliE7lbJyIyHKEpkSP2uBD4ASaW8nWz?=
 =?iso-8859-1?Q?i6Su9/Fp8+7DRP3bgrN5QxNXdsid8cD/mrpaxRZd/YdKe3ApxJNbSQzkE1?=
 =?iso-8859-1?Q?Y3vjQEWdAfyahha/AO3HiYURcPmmaGnu+uFR5eKyOJ3H09OWp+pZgQTKj3?=
 =?iso-8859-1?Q?vmg7H/xIbOAp4RYReTlx7qPjk5B34OnLJJe5dmVn+xdwO+vVKzfR0NfYL5?=
 =?iso-8859-1?Q?DU7x/Q82Zeoql/gwYO5DDerEz4CjOnjw1qpKn4vlgALk1AGrbw2rjgTmMh?=
 =?iso-8859-1?Q?C/S0CMTTlIxMT1pdRzFZ/46Yk0gtTrLuwDxZTcw7yiAOu0KYufwDdGike4?=
 =?iso-8859-1?Q?0Vi8JXHp9riEDFCI0IR3YqXOVjYGJjwNTE5eacJsAZs47E8zuMOivtz6Vy?=
 =?iso-8859-1?Q?R0cXGaxHzFpPWhEfFHDNpfzBnU2rvzlqExGnDPP4vR88ghmbCq3mE7m1NA?=
 =?iso-8859-1?Q?vyXYUMw0JtCkxhIZkcx35eAkLhzwOWfJ8gTkEmp6lhFgZW7hSwMqbR3y+Y?=
 =?iso-8859-1?Q?hsANIkQCjfvTnwmTpNtYw5k3OHqpscN55YnlJ1rFFQVmYyMEDmPAhLix4y?=
 =?iso-8859-1?Q?Nsi+eYyS3fgBL7i686XjcgpibZdSFtK+w7rjBlJcWV3/ui6SmvqxujZgMU?=
 =?iso-8859-1?Q?XB6sVK0uwHD/r/iXZHzxnsU4ebKkbD7Hv2BUvTEV2GhM+vIEW8pPUCWVkL?=
 =?iso-8859-1?Q?TRuDdDTwzl1wiOuXeyzVA+1iphM+5Nj7V0LFy/GgBh7UNnpyMk6H4RJDFc?=
 =?iso-8859-1?Q?1haq9RKOpRHTnRrFiEK6GvYUOoGSXSlmibvKtbJCtKnT03F6ngkFTPID/p?=
 =?iso-8859-1?Q?3pHDVaKUkhn/o2P8FQVsb4DkgyzfJoTn3UdXqPwYcWvOYAXKl6RSwA7b7W?=
 =?iso-8859-1?Q?PTVVbLGbjYb/pVeV2eQA5R7zgnPksYzn/usVkCwNLjaQ/h3y3H1JljwX74?=
 =?iso-8859-1?Q?ef55+akiRShorCFI50MNjFCo7/10N5BBo8HNC44iSx5FU4wWZ3rTgp2yEW?=
 =?iso-8859-1?Q?hFtt8NHL2rwTYm6BVOuArb3ghN+66iIgYF2q5AcK3EZ7amVhMtGPSFy1zR?=
 =?iso-8859-1?Q?+OegVQHndp248=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mbv.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bc387c-85da-4c03-eb6e-08dcf47b5416
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 22:29:30.8379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b9c2100-a992-4d02-9349-895ecb1a1527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L0In1yFG7wCODsiDdEm1wxNJrWhgTEs8XMGc0R8lEe2Ah1G2hPrAItNpKjP4Geky7G5EMDvRgHAEuXngDoUC7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1689

From 031c09076392422235fc79b982cc4ab052a565b9 Mon Sep 17 00:00:00 2001=0A=
From: Yanik Fuchs <yanikfuchs@me.com>=0A=
Date: Thu, 24 Oct 2024 23:36:25 +0200=0A=
Subject: [PATCH v2] usb: typec: tcpci: Add FAULT_ALERT handling=0A=
 message=0A=
=0A=
=0A=
Good evening=0A=
=0A=
Thank you very much for the feedback! I have now=0A=
updated the patch to register the fault pin.=0A=
=0A=
Changes since v1:=0A=
- added TCPC_ALERT_FAULT to pins to unmask in tcpci_init=0A=
- Added missing "{}" in if statement=0A=
- checked patch using ./scripts/checkpatch.pl=0A=
=0A=
Conversation:=0A=
=0A=
>________________________________________=0A=
>Von:=A0Yanik Fuchs <Yanik.fuchs@mbv.ch>=0A=
>Gesendet:=A0Dienstag, 22. Oktober 2024 21:13=0A=
>An:=A0RD Babiera <rdbabiera@google.com>=0A=
>=A0=0A=
>Thank you for your fast response!=0A=
>=0A=
>I agree, since the Chip seems to need Fault alert acknowledged to work pro=
perly, it would, in my opinion, make sense to unmask the fault_alert at the=
 init >phase prior IRQ, where the others alerts get unmasked. But I do not =
know if all, or just some faults trigger the fault_alert pin even if it is =
masked and if that >then would be an issue (like uneeded traffic on i2c).=
=A0=0A=
>=0A=
>Best regards=A0=0A=
>Yanik Fuchs=0A=
>=0A=
>________________________________________=0A=
>From:=A0RD Babiera <rdbabiera@google.com>=0A=
>Sent:=A0Tuesday, October 22, 2024 8:01:38 PM=0A=
>To:=A0Yanik Fuchs <Yanik.fuchs@mbv.ch>=0A=
>=0A=
>Hi Yanik,=0A=
>=0A=
>> +=A0=A0 /*=0A=
>> +=A0=A0 * some chips asert fault alert, even if it is masked.=0A=
> >+=A0=A0 * The FAULT_STATUS is read and=0A=
> >+=A0=A0 */=0A=
> >+=A0=A0 if (status & TCPC_ALERT_FAULT)=0A=
> >+=A0=A0=A0=A0=A0=A0 regmap_read(tcpci->regmap, TCPC_FAULT_STATUS, &raw);=
=0A=
> >+=A0=A0=A0=A0=A0=A0 regmap_write(tcpci->regmap, TCPC_FAULT_STATUS, raw);=
=0A=
>=0A=
>Would it make sense to register TCPC_ALERT_FAULT to the alert mask as well=
?=0A=
>If TCPC_ALERT_FAULT would be the only alert to trigger an IRQ, will tcpci_=
irq=0A=
>still run if it is masked? i.e., can this patch only read/clear the=0A=
>fault status because=0A=
>it piggybacks off of another alert?=0A=
>=0A=
>Best,=0A=
>RD=0A=
=0A=
I am looking forward to hear more feedback :)=0A=
=0A=
Best regards=0A=
Yanik Fuchs=0A=
=0A=
Signed-off-by: Yanik Fuchs <yanikfuchs@me.com>=0A=
---=0A=
 drivers/usb/typec/tcpm/tcpci.c | 11 ++++++++++-=0A=
 1 file changed, 10 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.=
c=0A=
index ed32583829be..eb6dee2f0c53 100644=0A=
--- a/drivers/usb/typec/tcpm/tcpci.c=0A=
+++ b/drivers/usb/typec/tcpm/tcpci.c=0A=
@@ -686,7 +686,8 @@ static int tcpci_init(struct tcpc_dev *tcpc)=0A=
 =0A=
 	reg =3D TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_FAILED |=0A=
 		TCPC_ALERT_TX_DISCARDED | TCPC_ALERT_RX_STATUS |=0A=
-		TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_CC_STATUS;=0A=
+		TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_CC_STATUS |=0A=
+		TCPC_ALERT_FAULT;=0A=
 	if (tcpci->controls_vbus)=0A=
 		reg |=3D TCPC_ALERT_POWER_STATUS;=0A=
 	/* Enable VSAFE0V status interrupt when detecting VSAFE0V is supported */=
=0A=
@@ -714,6 +715,14 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)=0A=
 	irq_ret =3D status & tcpci->alert_mask;=0A=
 =0A=
 process_status:=0A=
+	/*=0A=
+	 * some chips asert fault alert, even if it is masked.=0A=
+	 * The FAULT_STATUS is read and written after to acknolige=0A=
+	 */=0A=
+	if (status & TCPC_ALERT_FAULT) {=0A=
+		regmap_read(tcpci->regmap, TCPC_FAULT_STATUS, &raw);=0A=
+		regmap_write(tcpci->regmap, TCPC_FAULT_STATUS, raw);=0A=
+	}=0A=
 	/*=0A=
 	 * Clear alert status for everything except RX_STATUS, which shouldn't=0A=
 	 * be cleared until we have successfully retrieved message.=0A=
-- =0A=
2.34.1=0A=

