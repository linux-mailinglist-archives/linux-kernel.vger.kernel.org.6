Return-Path: <linux-kernel+bounces-298242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE1C95C455
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D226A1C21CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 04:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC5B47773;
	Fri, 23 Aug 2024 04:42:31 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2130.outbound.protection.outlook.com [40.107.222.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED4376E9;
	Fri, 23 Aug 2024 04:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724388151; cv=fail; b=FIgNnXY/80EPGwPRc9w1isTEvZg6GoHzha9xwOTVJf+ovsrXn4yoWxk9BatdzfBZ094SOigzC7cO7zA6Kh0PQ4Z4rMmAn/cQkwgKCV+6K9mbfg5YDYB55Xsut14bJPMLks17tqHVChL9jEangZiCOtyE/RlCygqCe+xm0C3tMzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724388151; c=relaxed/simple;
	bh=SIgY5yDPxziBZOLp1eYHefwaDtfHAxaZ7cX/JCXxNxU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jbOq3+xbg2SEJrz1+jpA2On5VmITCuw1QmZ6JGbLcHWKgig3RwV4au12RnTVU3r8J4PWiMRVG6/+SYG9iol2in/6l/Yd2HxwVr7Q58G82HU+Dwt7HnfvKpHheEb1611hPw+dHAkOnKHeBYFom7LU3ntoT3IGwV9FOed54c1rcUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbQ+Mt1TvOG4nJVehC2m4m/WIDt37nvlItmiBkHgepDJyT2xOYKjmi0DGSe6pR5bTDCg+v+Od9ndRbKj6rAej3oaPUcTOlkWPn6dSamqWN4vk5h26GfGTmgfH7zCukkG6gjGWo1TNKsNoLu0BVMZb/0XnJ6oWx5R/cUhpj2q2jzAHiyftKO7YpUQF5rEoLJHTV/jwVSRKFQP1iAnb4CI5nEThj6o1wB3VZguJQpFTsSekRhC3W/tJSezyMy5kF/Lu4G5nWVWq7j6lVywo9FH41vZjJeG8mIIgM6qTKYcyMKpZHuykscS1xJA4t4HtYJ8Q3KtlYxypRWg97iM0Bm1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIgY5yDPxziBZOLp1eYHefwaDtfHAxaZ7cX/JCXxNxU=;
 b=j6i3JiYJ0YX8vg3r98Q7xyNx6dVk6wuoxum8U/nr1u4UhnCgXuhRRRXcvAzTuERyUakCLGTzEqVz+2sp4Zfebpj86w+HEgdZIBakipDZLvLQ1y9jjF/tUiTMTf+SzDAlHIX5VwmeDpkNp82qTgpSmXS2kK4oHgJfPn5Hsk7PKWmyuxQc5hj1fMXwcPzM7+aSUVNcEbPsv4hYYYvWnveof+JkqW3L6FdZjWO7e0X/hxxEebhAKhWOBjJTw358effqZucQuuW3313byQBFZdxKGXuALZReJoumTYoeLbzTasnHs5kmmurHsdNHPYWxPhn50Nzb38G9nKaTSuT7egEuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by MAZP287MB0437.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 04:42:25 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 04:42:24 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "festevam@gmail.com"
	<festevam@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Thread-Topic: [PATCH v2] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Thread-Index:
 AQHa89I5BbwXUGmzXESMOglvow2nPLIxxPAAgAEJg7CAAAsPgIAATOYkgAAD0wCAARbrOw==
Date: Fri, 23 Aug 2024 04:42:24 +0000
Message-ID:
 <PN3P287MB18296998E37E061AC496F2D58B882@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20240821135817.56393-1-tarang.raval@siliconsignals.io>
 <20240821-cute-cougar-of-atheism-3a9121-mkl@pengutronix.de>
 <PN3P287MB18298292CD27FD9D8365C9178B8F2@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
 <20240822-holistic-fearless-bloodhound-e9095e-mkl@pengutronix.de>
 <PN3P287MB1829953DB0BBC5423672FF728B8F2@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
 <20240822-calm-dinosaur-of-music-33db22-mkl@pengutronix.de>
In-Reply-To: <20240822-calm-dinosaur-of-music-33db22-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|MAZP287MB0437:EE_
x-ms-office365-filtering-correlation-id: 252aa570-47e8-4dd1-1a66-08dcc32dfc03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?N4kqun9hUSAUay6O5QFzEUeGv4a9XMLOjcj6+yjvT4YLFk4M42FXv146?=
 =?Windows-1252?Q?+9WeEOOB4ZSU8Qrb1wususvNlLIz3QUtxpQ0rx7fNo7z+shP0AhAnKrr?=
 =?Windows-1252?Q?XXk++G8J5XRa2hDqqaTRXM6GSw5POAA1oeUJP6Rjh2/U889FUIgLfVqm?=
 =?Windows-1252?Q?ql4LP0SYkY8Yee2geSGTm7zopS5BAVbmoKlXGIR6lUfVUSXuydtxEeYJ?=
 =?Windows-1252?Q?3GwJ4QngVFKg4zxqB5isR+C7VSVYMWiCe7Lr9KGI/mYz/SrgQcCpSwKh?=
 =?Windows-1252?Q?9tVZK1OlBk1U60gEx+oau+24oeqHi0apHJugEgyQNJnmVOiVVQczjVpw?=
 =?Windows-1252?Q?ervL0OkC81lxOR8H87+3YE153DvQpfLPozMyan6EVj8c8hQbs0G3P1MB?=
 =?Windows-1252?Q?Q5YZGo+UbQBvjg6ya5LiswIVVtoFhbafpBa2jg0WyUposEXZh6o14826?=
 =?Windows-1252?Q?zqHYuzItU8rQasdnsExrVXowTYgz+KZVxwOgn9Q5tHfuPqd+0EaRxtpG?=
 =?Windows-1252?Q?nyKtmzcIl4ZjiiD5L5FlGvSnrVgCJP8h5oMUm/FqgavUUvvWj6iaEMN5?=
 =?Windows-1252?Q?OA/5pDk9JZts3zFN+UVnvENhecxiJLFXxbnbYW/1iOunLavojfuLiNvZ?=
 =?Windows-1252?Q?CtpMK+HMoUpmQcKyzIT6BTr+lkg7kw9/QXWIyhDLFGZ4nGtZLGdO/ZbJ?=
 =?Windows-1252?Q?E3Ulm+VLT6Rt+mlhHhFmjhG4rfQb9p5hpKn9c1Br0RNfgV1ikGYBiE0Q?=
 =?Windows-1252?Q?PGWTsemokgbD78QL8wDY5XMdFu3zZBSPtwN1VHsDl4ovhUgLZjaqFLU5?=
 =?Windows-1252?Q?O7eT5y8HXygUGA2Qo3PVYlHnmsAA4nYFSSrjD0NnsrGQukei/wPN2QIm?=
 =?Windows-1252?Q?jrx1nwGtH5Vl8Z7+j12CNqCxMZqCLbqMKSEHRSEJEokNzwZjQTP4252X?=
 =?Windows-1252?Q?JlW+elVY4RqikWWcjgJIwHk/+lwVj7jaoQ7cGYx/jM6/TqK7V7IvBD2e?=
 =?Windows-1252?Q?R2WmiuN6KeKgfyr3H1+Qa+FLYcNzQqriAAihkwWk/luhDxGVo0sZXLJo?=
 =?Windows-1252?Q?osVVxYmZACHW9eDR2zHgk/FemMr65tM3EpNfiZWfGcp2CIom+lz3gY1X?=
 =?Windows-1252?Q?RlLZjSdH7WzjWyROn2MVCpjgZ8mHCcxiju+njQy+wZ4m1pDa0aW281xc?=
 =?Windows-1252?Q?bKW3z1FO2J01nK5GD8SSHC17OBH21QAUioOVqaXA7I/XNc45ilpH2IU3?=
 =?Windows-1252?Q?+jG/SSX8W7Nj1H4jRgI3Qbk0Oe1tXj6Z6lItnIiO+7rSpOF9olt9cAXk?=
 =?Windows-1252?Q?nYOfTDSGsSSXK9mEHfkTAzLDdDHD6FjftIx2XP33dU5CdJwm5nX4Ca8K?=
 =?Windows-1252?Q?UNdomyUFXDjzPMhVLIR89TAU7rDqhf0kplvbD1HMZ7Fp13PQGESrrd/R?=
 =?Windows-1252?Q?b2+zokqCuod61DVzNZREvbJNsgjRPDokR8di6TTLM6R9eoxZrisoSn9P?=
 =?Windows-1252?Q?V2gtIoRMeItANi4UoQeCbJS4GGw1Vg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?lc1Nf9JSa6untczHpsfnmqCnzHH/5zLwoVkGOP6ZU1LFr3apNOckEkmW?=
 =?Windows-1252?Q?zXeV7vV5TvA2wVVD6LhfTzV3/t78NuT2lrT+n9eDW5YjNIpcR3pW9+pw?=
 =?Windows-1252?Q?thhWf4hOqtahadOWMBv4KM8k0mzTSGSZAdpd6FYz+7V2bwkTzgBXcDMS?=
 =?Windows-1252?Q?FdZxtSRrORQGLQK3pQKvPNUDPdTf26xvwbYgMFH5E1SnRnDbVwil0PxN?=
 =?Windows-1252?Q?4j7wG7E1pgXfQCH4CufdFYdVOblF31JWpQ6Xi2+3t+Gy5uC002Yrezc8?=
 =?Windows-1252?Q?p9z/osIAcp0nkDfkK9aYBSDWna0zlXLXCfCFApKnFv31YZH0ffiZwvP9?=
 =?Windows-1252?Q?epBPJQ7pzJP22g9MPz54Hhzg/1vvdQtofFejhb4UTU/yJFaIHzWzPBVz?=
 =?Windows-1252?Q?Ks1WD9+yyU+/rvQWD1oMb7tNx3cxncQzOrB2n5j5x5SNvLkLWLV+v94E?=
 =?Windows-1252?Q?wE73VNA96d1p4ybB1ycqL6v7ajeZigbl0Rz/KvKY7mHdTH7PmL/U6S9I?=
 =?Windows-1252?Q?y9sB2GxHJ2xbTIZaQhc564CX5JsqRlIpkr/fF39W314+DKu6Oyv1dShX?=
 =?Windows-1252?Q?rjNAtoDtH+oU6cPMyuhcsKWKISvV9SqdZyL9msSzVT+DY2z0nF/eYn9H?=
 =?Windows-1252?Q?2I/4mMPEETySbAGWcawq6EUuqPO+3CWo7FXHs/IaAjeUXWC9TPN08a0m?=
 =?Windows-1252?Q?QYrKQerGdMP6loJ1YK0F7JgzunHEtZbY+e0A18a0sl4CfC1eqB2euBGp?=
 =?Windows-1252?Q?Rxjh5IMCWGr7YtJxGcNQkD2NCf8Efr9KLyMOsZKS0xM5/nheUJtKBUuV?=
 =?Windows-1252?Q?bwQAioi39jV4MUo+o++duP3VFthH29MDbuMR2wRujB+MxpBLpcpymuCS?=
 =?Windows-1252?Q?+buAh5zX7vCMYuK1akraQO+ac84rmIDyQKEiLlb7PBjPpROUpAaYjkDu?=
 =?Windows-1252?Q?2A27WAQy3PGEyu2SMGCUcqgwLls1NRt8axQhm5crSslZNxIb/7UH2XNu?=
 =?Windows-1252?Q?zICmpHCSm8UQUQ3OwtS75gSCGw9zUOm0u1T0K2+TcnUn3FzcMvGRnA5/?=
 =?Windows-1252?Q?DqjW1216+wl96GuvTnSa6V6ABX28nPALlqMBUvGg2rFHHaDu/qzjeC1/?=
 =?Windows-1252?Q?w50j7inarFAua5Fv1UFoMLldjRwomBaR0DXXr7+WbBAf5kc25SABZrBj?=
 =?Windows-1252?Q?tf5ZAmQCdEFtRJt48SqPx9gkkAaqeXlpihFrVmAkpUpw4RZkRG86KHYE?=
 =?Windows-1252?Q?QHFDBPR/6vIHQhMkbLxU+DwELB5CVl94LowJ9QIZf8HVeIYDiMZDvjSe?=
 =?Windows-1252?Q?AWr4ZkTpn5+0iiJbe5Dmiyg+RHrnwNCOcmEWQLY8iOm7Nh5jt8Fe/G9+?=
 =?Windows-1252?Q?sJuemFD9vsiSwjbV9/i1wK+m84S5P8yAY73c2Dx+OvnmcYEsas4+lhWG?=
 =?Windows-1252?Q?VVtIwR84Jl2UhUQvt5x6sdDJ+D1uLvyNGjKlS0xMhAIxl0ItTh/IMC1T?=
 =?Windows-1252?Q?tdPhUoiK0BMhoo6l+OAMRefTApuij7+sHThCt2FigYdYjrpQUau0VdVu?=
 =?Windows-1252?Q?ZCFegjVaA+BZmwUYm7jA1YBOUpH3qH/JhS6jz5pE39LmprwiQ+JnqnuL?=
 =?Windows-1252?Q?GfBFOeNPDjL/1EjOO4FX3L2PMmYnmt9mcMnreh1fKR49qeYmMoehJ4UQ?=
 =?Windows-1252?Q?VB7/F5XVSuGnEJJ17+MFHKuLiiJ9AYpyestfYb39RKvj2QVEYZxcteXV?=
 =?Windows-1252?Q?/jVjKNMl5etO8F8HD9M3pvk9+MEHFQKixEaZKE6YelfkpRxK0U9jbl3Y?=
 =?Windows-1252?Q?kOjdcg=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 252aa570-47e8-4dd1-1a66-08dcc32dfc03
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 04:42:24.8193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86bL/sayEs9l5fgZsDJ4FmqX01LcZUvfwZJO25P2OuEhmoCWR+7m+os+CokiK5Fg0vwWn9D+HG1RAS5FurFkv2oO9hHBzzVB2tCqSEEMX3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0437

Hi alexander,=0A=
=0A=
Thank you for your feedback, Regarding your suggestion to switch to the USB=
 connector node=0A=
=0A=
>> +=A0=A0=A0=A0 extcon_usb: extcon-usbotg1 {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "linux,extcon-usb-g=
pio";=0A=
>=0A=
>Please refer to Documentation/devicetree/bindings/extcon/extcon-usb-gpio.y=
aml:=0A=
=0A=
I couldn=92t find the Documentation/devicetree/bindings/extcon/extcon-usb-g=
pio.yaml file as mentioned. Instead, I located the extcon-usb-gpio.txt file=
, but it doesn=92t contain documentation about connectors.=0A=
=0A=
>> Deprecated, use USB connector node instead.=0A=
>>=0A=
>> deprecated: true=0A=
>=0A=
>Switch to connectors instead.=0A=
=0A=
I referred to the following YAML file:=0A=
=0A=
link : https://www.kernel.org/doc/Documentation/devicetree/bindings/connect=
or/usb-connector.yaml=0A=
=0A=
Could you please confirm if this is the correct file to refer to?=0A=
=0A=
Best regards,=0A=
Tarang=0A=

