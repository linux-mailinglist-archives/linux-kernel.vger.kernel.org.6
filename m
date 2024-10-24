Return-Path: <linux-kernel+bounces-379561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 640AE9AE077
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAA1283444
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C671B5EA4;
	Thu, 24 Oct 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=newgenag.onmicrosoft.com header.i=@newgenag.onmicrosoft.com header.b="eavNYlZ8"
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020092.outbound.protection.outlook.com [52.101.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51AC18A6AE;
	Thu, 24 Oct 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761653; cv=fail; b=WZX0v5UToScTH4eXjwQwTl0b1bRhT3dw3Sa5C34r6GQgKdpib4Q6+gCv4bDovkMLZiqOb68O3FbCf+/r/71LfS3t84FEWo6NgQeleJEXQ9KHFXCm6BF8sjgI1UqP45wgUxL6XsLnOdfCkD+rMAtHSFAKVaX1QW+zbARqAqXgj+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761653; c=relaxed/simple;
	bh=ku+6nrZVtlbf05U1dwZfm8Tl8svNMI0P6sk3kZKC/uc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iS6G9GhpJ/Lsq58TDeb/I0C7U3pIrWzruEQ0FrgV7sWQ6KBTu3H8G2BAy2XhgaWyrCjZS601ksYTRBTOpoc53yziy8Wtr9tMI1l/WJXbqYyhnjYWIvNHu7KSOR/fczqkw5k6WIkqThHTJUm9w9LL0ZeAXpz96sa4PmsogZ4/vng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbv.ch; spf=pass smtp.mailfrom=mbv.ch; dkim=pass (1024-bit key) header.d=newgenag.onmicrosoft.com header.i=@newgenag.onmicrosoft.com header.b=eavNYlZ8; arc=fail smtp.client-ip=52.101.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbv.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbv.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woWSvTJ24InsOeuwdUKDpDsFIF62u8RIaWgpRkbaH88B1I68uFC43uL7jaD/5JVSt1JfuhcJZqvPYLRYP16jpO8uCZtTNK550UR933KmjPDqnWpIV75wve5YEmSzIf9zf1qG0CzzCrf5fhplg1H+GOjATQuWrgOpizwDrgG+XZ3fIyrzmo7aQ/qxgKvFXqScpPkdpS0G48qH9wbQgbSHEkCobIANiCe4H6HZOnpPF9PkmDuULsJNI2DYa1bSbMLX5KaQ54RSNjZ7vtyVBQVzVp7cwkFWBrp+M4b1yakkVGTYsGFhqAtZhlrLMY+0aWF76/aumzrziBRc+gUKo4/uNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geB1xCO20845wfwSPqRj/Knkeb1P48PutwALH4VO8G8=;
 b=bzJ8lj1ejtxNCf31ryBSb4//QH/usOys55heF5eVLNGks7ngKsYDnJhfyr5P5s1O9xPTT9tuI2uU+HJNQClYqkUbCdW0Lg539Ak7CnFt6wjSm1ylII54la0jYfPF1qGDhWyWkFZD8MEJm1jIDKQ8JvNPBqo19yGjOk5sZMhmU+YN0/u23uZUs7uWK9XOoTAzw2F0nZpJInMu5YXH0dk3kv6UV1jQb3ImnKabof7SeW/36JFjC7OHomCWRPvLYywBxuFpQ7AIzHPr595u+WepFWb3fTJg9srUuDuK6CCcembP5Ua1XHQqTfLSILewph8xC+mNBLaNfrqnjVLaMY3Lew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mbv.ch; dmarc=pass action=none header.from=mbv.ch; dkim=pass
 header.d=mbv.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=newgenag.onmicrosoft.com; s=selector1-newgenag-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geB1xCO20845wfwSPqRj/Knkeb1P48PutwALH4VO8G8=;
 b=eavNYlZ8XUON9JdYT3FK/Lyy/dA6Cl75QVyW58RvBRJn3F9HUAu1UROLwKhVOXxZM8CGU6BTszkusEhOfRzBaCRQJBBklV8Yod/URUeEgiGWsxXUhlGA9DSwOzQF8yINoPQYhVtiwdCiU083RuW3IC4eM/YgUzJDWc2v8x7qTOA=
Received: from GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:49::12)
 by GV0P278MB0854.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 09:20:38 +0000
Received: from GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM
 ([fe80::373:3184:90d1:31b6]) by GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM
 ([fe80::373:3184:90d1:31b6%3]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 09:20:38 +0000
From: Yanik Fuchs <Yanik.fuchs@mbv.ch>
To: Amit Sunil Dhamne <amitsd@google.com>, "heikki.krogerus@linux.intel.com"
	<heikki.krogerus@linux.intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "rdbabiera@google.com" <rdbabiera@google.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "kyletso@google.com"
	<kyletso@google.com>, "badhri@google.com" <badhri@google.com>,
	"xu.yang_2@nxp.com" <xu.yang_2@nxp.com>, "sebastian.reichel@collabora.com"
	<sebastian.reichel@collabora.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never
 low
Thread-Topic: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never
 low
Thread-Index: AQHbJKZBKbAlUNbL60mUuxGGz7rdE7KVPCEAgABe/ZCAAAaxqg==
Date: Thu, 24 Oct 2024 09:20:38 +0000
Message-ID:
 <GVAP278MB0662DAEFF3191D7EC01730BF974E2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
References:
 <GVAP278MB0662F98EAAFAD95645E7010A974C2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
 <d6bbd32a-6de4-492a-8965-c0bc3dbddcff@google.com>
 <GVAP278MB066241A50CBD35448CB11DE7974E2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
In-Reply-To:
 <GVAP278MB066241A50CBD35448CB11DE7974E2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: de-DE, de-CH, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mbv.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVAP278MB0662:EE_|GV0P278MB0854:EE_
x-ms-office365-filtering-correlation-id: 9ef1f682-d5dd-4396-d277-08dcf40d1fb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?muyZbszJVkWSC+iAZeyl8dOoeJZ/9tFS6DD6isxSFm1z9pO7Lg3BzeqebY?=
 =?iso-8859-1?Q?qgKm5pFhvyNUoIOb8GkUAPzd5uta4+f5Pe9z6601AzrOhjZ2I4DkORYlVy?=
 =?iso-8859-1?Q?7XJvQcoqoNr2h/UaZYfNAEdW5f8yWrutIkIt255IxxXfmRUKNo52fTsfZS?=
 =?iso-8859-1?Q?IT9DHh8A4Gr+4Z6jZJWHfh3G0I72f2SzqveQiUpgxGU862V4I9PC9JR0/O?=
 =?iso-8859-1?Q?j2GZl5YWjQArtpKRlFV5JKGORizdrweixMHZfxdMljSYxHELcV5a+o+QkZ?=
 =?iso-8859-1?Q?kKNKddEqgUyvg9ZAjxFVnY92ESUVpGI61PaUtTgO4cmnu+IiWAXTgkFKvL?=
 =?iso-8859-1?Q?uCZ62Oqh4IU6WWqAj0bVPGr4iv55KcDo9XBbz2Z+smTEhezvM2WbH4wLlt?=
 =?iso-8859-1?Q?jpc0ahqLciNgAxfOABA8lJEInaVAsqTbRwWyyA5sCqX12Pj56XDYyPzEn2?=
 =?iso-8859-1?Q?F+zExXt8MB0KrOCrWb4fwE80E9B1rk4OeJ6e4JBt7uayb4T9WtoNqo8zqY?=
 =?iso-8859-1?Q?u+OEJgPGtCGAY5y9lIIHj0JE+DOpOxh30zyAUr611GwIl7OdSJuKWF+jVO?=
 =?iso-8859-1?Q?LS0M32/oLUhth8C27wblWgS5q+jtbft1ZE89TDrE944inyJSpaDMnFSpxw?=
 =?iso-8859-1?Q?F6fl9nLa9HkojES8Q6zjLo8oUGYPFMh3dSRjVv72QdLVHOp3hBFehJyiiN?=
 =?iso-8859-1?Q?tcTLT5UVu9lPk+2tRltsEMTAFzp9kilBFIY7Lj1mh96x6/12wBzLrZ7RpS?=
 =?iso-8859-1?Q?9KzWQRTIpKR/qM+EXwFw44zVDzB9JOyfnO8PQ5H3x6Q8TUaxw89irdv+sq?=
 =?iso-8859-1?Q?1+OgNDnzjm905kvmLsiSeriIv6Gi8VHIasVUD6vmL7mP+DL4C+sYwlcnop?=
 =?iso-8859-1?Q?UZ6G1qiUAUvXkdhZIWK9z3CrS1o7rmUU1EdkVNZYuRVgwrCpxTwDQzR82F?=
 =?iso-8859-1?Q?7LpT6Mi/SRsJfoKSxA1+5+u3mmKHhNPjyVWpT9B+JyOlNREaT1qbqwUYPG?=
 =?iso-8859-1?Q?wTvRUnWqAshL48nNtj38gKh7WkCifiD7fRMUenSwYaLv63/hItD+17vatH?=
 =?iso-8859-1?Q?W6cWe59/byzwH0WAhRF1ScQFPJLr3gLBrLFaJqqAu2XauZrDhp5rXdq6qm?=
 =?iso-8859-1?Q?+xDugrKcEsQ9BUgCvlmJ+OtPG8wegV43dAQ8ZRqxKMIO5K3A+AEin896VG?=
 =?iso-8859-1?Q?1fGAyrmwvgPdDRt1sOhkjJsTYCoeCsJTEykGmgN0WiKz1QYqzXYlQ4GimQ?=
 =?iso-8859-1?Q?O1evBxzFzPVUfG9hySziUiw0jS3vopYNVY93oLlNrxPTrhR0I76UvQWHme?=
 =?iso-8859-1?Q?fP0+VWWrOU649x2J34cCP67V32zXCroXCCSHfcdsx4EON0po0sqAJMpDu3?=
 =?iso-8859-1?Q?1TuJN/Xue/OkDY+abXsbHilcns8DbL102o+2UmdERaDKuxMG1jNmqYI0y6?=
 =?iso-8859-1?Q?Xk8nAz+QnP1FQgnX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?raI5IMkW8+QDRXI6Q+ES99afGiV33jqf94ZtnZAVduHxu62nPyPufwySXq?=
 =?iso-8859-1?Q?TDe9KzKnIUVSzmUgGW7PyausDMBcxzXHu+qOxelXUGK+WBT04LslgDjG8o?=
 =?iso-8859-1?Q?wqXSZpjvAJx5lA329qKLT7sSNYCt66XSX+TM7bQEcNSxRAQTcGoOfAVUdG?=
 =?iso-8859-1?Q?Q+vXI5TTpiSnyHKxhNLdJvToGlh46K8RjQCw87CdguuBQlpGYFPsY/pZbn?=
 =?iso-8859-1?Q?N+0GedqLlJqqNxxQkfaFj3y3eBMdTv1pZT/BczIosaWU/ddaurg2CAoxFx?=
 =?iso-8859-1?Q?BpDEjEBGFhc//mSMukl9Gb28pkk3cXVQFCq6SMXkUe/yVOVn9447+OaMSC?=
 =?iso-8859-1?Q?bI59wlbIAgMLSClKUIysrby9opLCT0BzQb2/Fd5NXpJLInSSy9QoftMu/6?=
 =?iso-8859-1?Q?WfyyZKQBQWL4TOnRcbs0d6Jl3cjhiJdHZASZ7PRmJlKA0FheY5mR1zCDFs?=
 =?iso-8859-1?Q?NrNPp7CrdYhCPOffSTIssN8zCnAvVb/uHrdSXG9tFKEHbDkDxJsoFKvQo8?=
 =?iso-8859-1?Q?zqE7Gx0cKrYd+s+anXmIfDWduKJKyiTCL74SIBi8el02OOeLrI8GXaydsU?=
 =?iso-8859-1?Q?pXujzJpUuKRCUOXBF9FH1PAwGluZ9s7yf1OD8CKvt9rQW7bXHbLMe6D6xE?=
 =?iso-8859-1?Q?Kmb0Euw74p8+02Yv1ANy0bgaFjkIYTmr4HPqt/+O1hvbdJIAVk1tOKp1Rl?=
 =?iso-8859-1?Q?Y6xd4FGNulamOFkyvtAjMOaIBIOZ0ckVNaAZOnTZvGo9dJ4r1pPlQGrcw4?=
 =?iso-8859-1?Q?AFvR+ZDwQ/x+bW//L0wpZBxJv8zFLaCRfLx61/YvsDIkE3s4bfh0ESt7+p?=
 =?iso-8859-1?Q?/Uw4Kz92ULqYVNcd41/uC3nCJ+f0CwSr6fpvwwRhi18pJZjTV4TuLoWiyO?=
 =?iso-8859-1?Q?dEPGV6NnerzjCFv/jUHonxZf4SubG34sndQ8laNORy7mni4zB/1VhmGWWo?=
 =?iso-8859-1?Q?7yc0oEaMIBpXsC18SRBIcyE2N5moq6w8Bv4Th9G8etS9EGLFq5A9jRT658?=
 =?iso-8859-1?Q?uzEQ4GGMJayi83Vu60x5ig0pEh3qPArHvh7FLqtDJXwvtpsO4dQRiQgjxQ?=
 =?iso-8859-1?Q?YS/b9l2eD9krodIuXr29oKbbhnKGTpPb0cs85TsPrGqgcdeADYpJHVFisn?=
 =?iso-8859-1?Q?Mv8sEap/lPrnarq2n7QRwzo0kwtxokIFEeRdZNpXPUDZlE6So58mwvgqSi?=
 =?iso-8859-1?Q?7Slqbhs15F7kKq+DUAX4YSiErjNlRhbGrVGB9T3yZjKfaqwYu8bSuVqVRy?=
 =?iso-8859-1?Q?9HK2IFoeJppBeby77BwPq+g0fdgKPDacL2Mn0B+Bq5kvt/uiXiDoYTWiqN?=
 =?iso-8859-1?Q?2c0tZkQcStM1FRDaQreTzWLlf5mls6z194MkYrAGPKT1A9qH6KkxWHvo/U?=
 =?iso-8859-1?Q?os+02iOrunMib8AZY5CQGuSwYV6hwM+yT8CO4qTs7Mxqq4xxOXR3jmF9rm?=
 =?iso-8859-1?Q?XrzMs15U+T3mJODxkA1fEEua/RxOm9EQWs4w+2sUPTTFWkOu0fwl/yhugW?=
 =?iso-8859-1?Q?ZcrMHN25oQopX0h1bGNFs3PgIo4GoeOb3W8RdRMARZRjvZYKzcuFdRuz9f?=
 =?iso-8859-1?Q?EpBUhEywSzrZo2V4RHPTFLmSBmS0nyrD47gtVEubb++d7kMX4xL0ppq6HE?=
 =?iso-8859-1?Q?fSPTMFrvJ8c4w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef1f682-d5dd-4396-d277-08dcf40d1fb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 09:20:38.3115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b9c2100-a992-4d02-9349-895ecb1a1527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fhbr4yeChEZKGJCOauKkAjYYAxVTAaYG2BTdz+mMqVwqEFGH81sVrmWotPVZcI+Oik0tuWuOR5kL+xazB8Wkhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0854

Hey all

Does anybody see a problem, if we in the function hard_reset_state() not ch=
eck for the state it was send, but check if Vbus is present. If Vbus, we go=
 to SNK_READY and if no Vbus we go to SNK_UNCONNECTED?

Freundliche Gr=FCsse
Best regards





________________________________________
Von: Yanik Fuchs <Yanik.fuchs@mbv.ch>
Gesendet: Donnerstag, 24. Oktober 2024 10:54
An: Amit Sunil Dhamne <amitsd@google.com>; heikki.krogerus@linux.intel.com =
<heikki.krogerus@linux.intel.com>; gregkh@linuxfoundation.org <gregkh@linux=
foundation.org>; rdbabiera@google.com <rdbabiera@google.com>; linux@roeck-u=
s.net <linux@roeck-us.net>; kyletso@google.com <kyletso@google.com>; badhri=
@google.com <badhri@google.com>; xu.yang_2@nxp.com <xu.yang_2@nxp.com>; seb=
astian.reichel@collabora.com <sebastian.reichel@collabora.com>
Cc: linux-usb@vger.kernel.org <linux-usb@vger.kernel.org>; linux-kernel@vge=
r.kernel.org <linux-kernel@vger.kernel.org>
Betreff: AW: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never=
 low

Hi Amit

If the setting "bus-powered" is not set, there is only one way, that Vbus d=
oes not go down in init (where we force a Hard_Reset, which sets CC to Open=
 if not bus-powerded). The case where Vbus never goes down and setting Bus-=
powered is not set is only with a legacy cable/adabter. In that case, we do=
 not have PD compatibility anyway, and have to end up in SNK_READY eventual=
ly.
So we do the SOFT_RESET if Vbus was never down out of historical reasons an=
d is not needed anymore since tcpm is sending Get_Capabilities (the only re=
ason we send SOFT_RESET if Vbus was never down, is to get capabilities of S=
ource, and that we still do, if Get_Capabilities does not work).

As you correctly have pointed out, I have to fix a issue I spotted yesterda=
y as well, that with this Patch, after two hard_resets and then after 3 Sof=
tReset we seem not to end up in SNK_READY, but in SNK_UNNCONECTED -> I have=
 to find a way to check if we try hard reset in SOFT_RESET state after leav=
ing the WAIT_SINK_CAPABILITIES_TIMOUT and in that case send it to SNK_CONNE=
CTED (same as if we would be in state WAIT_SINK_CAPABILITIES or WAIT_SINK_C=
APABILITIES_TIMOUT).
Maybe we have to count softresets after requesing capabilities and reset it=
 as soon as we are in SNK_READY

BTW:
I have a patch which I use in the 5.15 version of the driver, where I can g=
et ptn5110 to init correctly without forcing the Hardreset and the manual C=
C_Change trigger (I changed default state of sink to SNK_DEBOUNCED (where V=
bus is checked and if not true sends us to SNK_UNCONNECTED) and added a del=
ay of one second to be shure that IRQ is running when state machine starts)

Freundliche Gr=FCsse
Best regards


Freundliche Gr=FCsse
Best regards


Freundliche Gr=FCsse
Best regards





________________________________________
Von: Amit Sunil Dhamne <amitsd@google.com>
Gesendet: Donnerstag, 24. Oktober 2024 05:13
An: Yanik Fuchs <Yanik.fuchs@mbv.ch>; heikki.krogerus@linux.intel.com <heik=
ki.krogerus@linux.intel.com>; gregkh@linuxfoundation.org <gregkh@linuxfound=
ation.org>; rdbabiera@google.com <rdbabiera@google.com>; linux@roeck-us.net=
 <linux@roeck-us.net>; kyletso@google.com <kyletso@google.com>; badhri@goog=
le.com <badhri@google.com>; xu.yang_2@nxp.com <xu.yang_2@nxp.com>; sebastia=
n.reichel@collabora.com <sebastian.reichel@collabora.com>
Cc: linux-usb@vger.kernel.org <linux-usb@vger.kernel.org>; linux-kernel@vge=
r.kernel.org <linux-kernel@vger.kernel.org>
Betreff: Re: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never=
 low

ACHTUNG: Dieses E-Mail stammt von einem externen Absender. Pr=FCfe Anh=E4ng=
e oder Links sehr genau!


Hi Yanik,

On 10/22/24 10:28 AM, Yanik Fuchs wrote:
> Good Evening
>
> Here is a Patch to resolve an issue with TCPM if Vbus was never low.
> Please consider that this is one of my first kernel pull requests, I may =
have missunderstood the process.
>
> Freundliche Gr=FCsse
> Best regards
>
>
> Yanik Fuchs
>
> ---
>
>  From 604b97b6394b5643394bc63d4ac691c098c99c40 Mon Sep 17 00:00:00 2001
> From: yfu <yanikfuchs@me.com>
> Date: Tue, 22 Oct 2024 18:23:18 +0200
> Subject: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never l=
ow
>
> Before this patch, tcpm went into SOFT_RESET state, if Vbus was never low
> resulting in Hard_Reset, if power supply does not support USB_PD Soft_Res=
et.
>
> In order to prevent this, I remove the Vbus check completely, so that
> we go as well into the SNK_WAIT_CAPABILITIES_TIMEOUT state. There, we sen=
d
> PD_CTRL_GET_SOURCE_CAP which many power supply do support.
> (122968f8dda8 usb: typec: tcpm: avoid resets for missing source capabilit=
y messages)

Please refer to
https://lore.kernel.org/all/20241024022233.3276995-1-amitsd@google.com/ as
122968f8dda8 is causing USB Type-C PD compliance failures.

>
> Additionally, I added SOFT_RESET (instead of Hard_Reset) as Fallback solu=
tion
> if we still not have gotten any capabilities. Hard_Reset is now only done=
,
> if PD_CTRL_GET_SOURCE_CAP and SOFT_RESET fail to get capabilities.
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.=
c
> index fc619478200f..c7a59c9f78ee 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5038,14 +5038,8 @@ static void run_state_machine(struct tcpm_port *po=
rt)
>                * were already in a stable contract before this boot.
>                * Do this only once.
>                */
> -             if (port->vbus_never_low) {
> -                     port->vbus_never_low =3D false;
> -                     tcpm_set_state(port, SNK_SOFT_RESET,
> +             tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
>                                      PD_T_SINK_WAIT_CAP);
> -             } else {
> -                     tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
> -                                    PD_T_SINK_WAIT_CAP);
> -             }

Instead of deleting code, please restrict this behavior to non self
powered battery case as this most likely break compliance and

may break actual use-cases for other users as a result. If you want you
can move stuff around after

https://lore.kernel.org/all/20241024022233.3276995-1-amitsd@google.com/

gets accepted in the following way:

```

if (!port->self_powered) {

         tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
PD_T_SINK_WAIT_CAP);

         break;

}


if (port->vbus_never_low) {

         tcpm_set_state(port, SNK_SOFT_RESET, PD_T_SINK_WAIT_CAP);

} else {

         tcpm_set_state(port, hard_reset_state(..), PD_T_SINK_WAIT_CAP);

}

```

This way you don't have to execute the SNK_SOFT_RESET flow for non self
powered use-case.

Thanks,

Amit

>               break;
>       case SNK_WAIT_CAPABILITIES_TIMEOUT:
>               /*
> @@ -5064,7 +5058,7 @@ static void run_state_machine(struct tcpm_port *por=
t)
>                * according to the specification.
>                */
>               if (tcpm_pd_send_control(port, PD_CTRL_GET_SOURCE_CAP, TCPC=
_TX_SOP))
> -                     tcpm_set_state_cond(port, hard_reset_state(port), 0=
);
> +                     tcpm_set_state_cond(port, SNK_SOFT_RESET, 0);
>               else
>                       tcpm_set_state(port, hard_reset_state(port), PD_T_S=
INK_WAIT_CAP);
>               break;

