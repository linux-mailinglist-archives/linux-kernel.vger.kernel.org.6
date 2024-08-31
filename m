Return-Path: <linux-kernel+bounces-309925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057DC9671F7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED551C215D7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652CC1400A;
	Sat, 31 Aug 2024 13:52:06 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2127.outbound.protection.outlook.com [40.107.222.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E20A111A8;
	Sat, 31 Aug 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725112325; cv=fail; b=G0VLh8gXBInfQ52E0apqPUzSvEdGuldwAY17YRiEAmbh+X1Iv+IQsk0aEesIuem4lISWUkfhHusOa4XJMS+FogVKMYBeK1V8eGx4RN8iIueKEF9RTFK5WWZbBF/15kF13Xrm3L0FVRiYTdyxMeS3Pe5KApM/Qf/zmmB/xBsidMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725112325; c=relaxed/simple;
	bh=TZEieQQ7FB3pB3Qs+sSh0ZhZqosFaX+d8cFf6DUKGlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n0yNZmlqdgBJSx0RSL55gGPXwHM/ZUiSzMrVFykx6f4ozLGEKMTckaAQjJgUoo0jYlJlmW5gSBLAbXr+aZFgnNZcpEfi1MNSDzvhs27V6TCnwgM+0AZDzmbpLXnbHjJjfTj2OV9IJIOGDtQGS2/SZ/+QRoyKO8eftkfT6Iw0C4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LN3Q0hovEmtEdcG/CkB1ZUECGyaKnsa7yz88eWwLC1eAsyUpC9w9H9qlyyRwIM3m2Cf4gl94Dh3vGrnxpfOUjin3VR/oYhzFn2Kc9neByCJKs9eNlCOIFvg7rLwxvP6br6VSV8TTz/veeiPAEC7fl3o+4N0Yqfh+6IpCa8aD8wOWAnKFqm8D1o5yzS77dKZE59Lyq5SSSXEh99RO5UPCWXVXWSAlST+IdYAdEn4yMgzwRVl/UHUwtaJvj3QJGK9CzwFuLQjGLi+ePusvzCkFTUUi+Vh9KxldPJqT7sieRXwPgjVcEWRMkuKGoIjSO2Ee4yTceS+AxiMGxm7XaMqGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZEieQQ7FB3pB3Qs+sSh0ZhZqosFaX+d8cFf6DUKGlA=;
 b=ylMYsjnGH/doE4wMZTAQATKWjyR/TTSRjfs0cm8O26ex1ttsg+XliQ6HYqKFTuTGuvEu8oOre9/E3DVgFCmrB/oLgR+4UUF4txn2o/HLIOnuC+YyOT8s9OuTFlyn/LFgVFg3etmN8awJOjlpiNF8kZbT2YQ+9V+HeTjoHt5b/jAEITYwVj0JVLsaoR27cmxW3HLv3Zp64f8ZrMQdp1wyDY0EY5KyCgFsgcFTX75rJN0DesMDLRJcWaCT8X3RBiAPgF4uoeZ2/68YrYjrthqI4okTYdhTY6P1kIPhDsHwzt4/hle7htM//VU3x1/Se2XHEftTgcKLNFElH4R1et+WnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by MAZP287MB0560.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Sat, 31 Aug
 2024 13:51:59 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.019; Sat, 31 Aug 2024
 13:51:59 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: Krzysztof Kozlowski <krzk@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Gregor Herburger
	<gregor.herburger@ew.tq-group.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Hiago De Franco <hiago.franco@toradex.com>, Joao Paulo Goncalves
	<joao.goncalves@toradex.com>, Mathieu Othacehe <m.othacehe@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>, Parthiban Nallathambi
	<parthiban@linumiz.com>, Yannic Moog <y.moog@phytec.de>, Josua Mayer
	<josua@solid-run.com>, Li Yang <leoyang.li@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] dt-bindings: arm: fsl: Add Variscite Symphony board
 and VAR-SOM-MX8MP SoM
Thread-Topic: [PATCH 2/2] dt-bindings: arm: fsl: Add Variscite Symphony board
 and VAR-SOM-MX8MP SoM
Thread-Index: AQHa+5Y0Xilg0c9VlkCNrQI4DInL+rJBWcOAgAAFMuM=
Date: Sat, 31 Aug 2024 13:51:59 +0000
Message-ID:
 <PN3P287MB182994A2AA56868084D70CC28B902@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20240831110743.14280-1-tarang.raval@siliconsignals.io>
 <20240831110743.14280-3-tarang.raval@siliconsignals.io>
 <3b28a1e7-586d-452b-bb00-4473d82976b6@kernel.org>
In-Reply-To: <3b28a1e7-586d-452b-bb00-4473d82976b6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|MAZP287MB0560:EE_
x-ms-office365-filtering-correlation-id: d1a9c8a8-ef13-4253-eb62-08dcc9c415a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?fNucnrh8gZ4F/dZ8Sl0HrceVDxcMI2hbFBMa4ucPtbmBXypPoNzJKZptOG?=
 =?iso-8859-1?Q?EtNAkIxIhfgTvUf2uNPz/NfbFpzV6gdG5VfUYpvzKyhFF4cZ2trd/v65NK?=
 =?iso-8859-1?Q?yOxqvqwbnMAIPixByZXI9dq6etzvAA0HlU6nYDuOF2C4YAoE52W3IDWDTH?=
 =?iso-8859-1?Q?Jh5pVXydXzrYVnmIyENIWIyNOACRlsZ4q2USrShxnFdl/ll+/Jek2jNL8B?=
 =?iso-8859-1?Q?1jCtDas6z+dP/g9yGudLVPlnGJ2o9etfL7rQv73eNM+HVud8yJb2brUZmS?=
 =?iso-8859-1?Q?rkfTU5jZ83xaw57qXRTihz68ypCw1hMGifzrpm5HY0POWNtEPgHkf/dWAN?=
 =?iso-8859-1?Q?e5YRRRLI6ffuac6VRvnSaIDTdaUEUvUBd4WJ1y/3lGQqlXOnAXozWP4LRL?=
 =?iso-8859-1?Q?lLTT6c3KDRVkfKCLncgVqq36w6njcrlR+rqCPOV4G1/7y/Yabt7BrcwiZk?=
 =?iso-8859-1?Q?BNoAJ6UyPbWMBpqdhuSnvFbn14/VJmmu4cJgMYBQ9g0lkrJcqAycw/fjch?=
 =?iso-8859-1?Q?fqsGGwbB47ptbcYtl0N8aTT5yh71DVWDUu0vlv5M/eeEqHCBjb3Lylg0H2?=
 =?iso-8859-1?Q?6jpwoRxDo4PX/31LXgMJcBmjtTQWI8oa+wg7V50vCTTc/K/sE7Bd9Wz1hZ?=
 =?iso-8859-1?Q?pShK0w5scp8Gg49mih6qGrF/t+39fSp4q2w+qF/VFBVrvCNTA9q/nTGccJ?=
 =?iso-8859-1?Q?EVYaChulvE4915h+ld14lR6GGrkWKWQKx/9avIUJ6xmSk30QYqEYw9cMmW?=
 =?iso-8859-1?Q?vxjuBwbTCQSsRuOlad0AXMOc2Q+X19hcT+iu1WegVEFXe2yjbPG4JkmKXo?=
 =?iso-8859-1?Q?yBKiwQ0tftXerbaz3F6A12Lsbu240CUFAqD32d5vWcQNJuRgRHilFprLQj?=
 =?iso-8859-1?Q?x1n4mUQLhjX1wTBJHy0ONm0JQIS9n1MTlyY9jHzN7+h7SO+KwmXHG4Dhaz?=
 =?iso-8859-1?Q?GcPudgl6FaGIWHKNsvk0DXCp0dfwHUZEBcHqMvnbmWAEJ5Y14zgKcvlXc3?=
 =?iso-8859-1?Q?ArqwINzL6of1vXWjNjt/fofI0GXHG7CKIqcHuvq1++CvfMiSuTqNCU6U1z?=
 =?iso-8859-1?Q?8INOWxm4ddumKrY4hobzEGTvMTjYvyyjGPAK92kVvq5pEviPQuRfjnCEMz?=
 =?iso-8859-1?Q?oXbK276iLwtHncxEAVVGhNLrMTfkb3TEvJJcP0cLFxYZSiOg8k5v9K7UKs?=
 =?iso-8859-1?Q?ugLnir64s9n8AEBd445kUUB0yB54vSFoqwGb0sEMO6WDkPYiyn2fUxu44L?=
 =?iso-8859-1?Q?AXftcmmpth24DziWxWhzRgIMPG0p13DZtmA3OE7pKF/wgKjmgwjaLI5+s0?=
 =?iso-8859-1?Q?3MdEk5duNbRyxaDFxUQK2vPskGeboH2EhgFHwhkSZJbI3+v/fyqYVz02Bq?=
 =?iso-8859-1?Q?y54JwMD9JLHUZ4qFmK/wxidvqNuNZWKB9ls9fddDt2aYcYEkEinughMuAL?=
 =?iso-8859-1?Q?+onz2epuY222TkYl6I6zFB2l8UeTorlw32J2DQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qMzWnh9V2TtJUIyxdrlBLbrmUUCpMUePaRl2gn72SiIgst81L0ALTySZbn?=
 =?iso-8859-1?Q?kjH822Ewfxc3+eWVDRQJ8HQHVMiuawDJ/4cauu6qlrlm4mZ1FhRbjFbwV1?=
 =?iso-8859-1?Q?9tM5LQ8V77Mfh4zUDbYeKqoH0O180B6QKZ1i+aE1U/XA8pYVJBJOEW/+eh?=
 =?iso-8859-1?Q?MH916gqfe8ZVBP+qVuiJ6xzCOt04A7YaeiHt4l2qL0AfbieZVrbWa9Ag0D?=
 =?iso-8859-1?Q?EGstxsiQCdHuMa9kb2x9vE1yl9QiIP9UKfZCXoQAl6Oaw0pT51IKK8Is4I?=
 =?iso-8859-1?Q?6EvsKtdLZJm5umNZzd5kXGzyMuigfw446VOymIRVM0vd0gm3IxRFWkPKWC?=
 =?iso-8859-1?Q?TkbQae4p1QvxIc9iOlDQWVoVzGDeVpJj7iGZ3MRLM0usaYOg/w8Zme6971?=
 =?iso-8859-1?Q?lHekuz6pfuiaq+zAczuKeOKmu2IcA878q/Cw1osx4JidVEFHMLbWj+R0oX?=
 =?iso-8859-1?Q?yBuYTnkrSCCOSaUImr1e2bN0V7P4L2NcsuCkpcPPtGOj/CrXzrIDig/qkQ?=
 =?iso-8859-1?Q?1ZbJ2eXbeXjcikOTKf/aRI6LTY91ryMh8vAzoJFqyc1ux7n0IKQdWRntgQ?=
 =?iso-8859-1?Q?xxTZIXZK7z53ip3SVs7ger5Co9UDsAO/sBuQexqxQOtqWbNM5WwoxZxG6a?=
 =?iso-8859-1?Q?N6pNxKjmnAh2lXMir7APGqmt+pT3kwNaejXVDQQxCKFsDhdGuLtKoQYriT?=
 =?iso-8859-1?Q?zDY65adnkeyCyK8wOG+zUqi67pMRyXHDDmjlVdV0+14J4imdQQmmdMoGbr?=
 =?iso-8859-1?Q?f0Q3I9EyvBDs0jTW2a3cFufK3jSTJHazgHYIqJe0ZJFQ4EkJ6/HjXq/1y5?=
 =?iso-8859-1?Q?O9HiqKr059MNinCVnp7VCPoV+w5Wpt0c094JF6uR3nOEem2Ti2qyBGhIpf?=
 =?iso-8859-1?Q?SQmLr+xoGuFR0oq/f574EJ0yH2KvHEP5HQUrh9Ub/c8FZpdBPqr2Y26j3F?=
 =?iso-8859-1?Q?s9EelOKNNzzoNFIgZlvAB0UXWUDM1oCTCJc/JfjSjjsqiIHwvqTe1v5uvg?=
 =?iso-8859-1?Q?NTtpKoD1Y1gD3GueLMAeKVZuxKlbwL3KWQXXuvc3UeIrYU9+AzQ/xPgZEn?=
 =?iso-8859-1?Q?nAmrI+0X0neX7u4XXnR7ooidpvwA4wj9+W11AgkCRHVUm1a7qLVeEVSEhg?=
 =?iso-8859-1?Q?P4zuZ0bnKUggWbbPQh77Zwnkfqh4JV983aUHltUL/rR55GiWH7b00ixAuH?=
 =?iso-8859-1?Q?NVPa2CskdBcsqZnJs7D27Vg3ESFty/xVo5yXs88st+5UdMocNaAJkCFJXB?=
 =?iso-8859-1?Q?bmyD5f/hOYrEL+s8mLIswTyqk00kbG4hWnqYJ7QxfdV2zqraY81gXXvJua?=
 =?iso-8859-1?Q?Mvc8pPntWA1Sdh542eybvFLfQFZX2izDXNLRZrg7mR50NgXt9GByKdLQqp?=
 =?iso-8859-1?Q?+K2qK13OgOpn1ythNLv9MQoIzp7sg3PYhqnd4pdmyy0SLK0iruS8yByPyV?=
 =?iso-8859-1?Q?a0X4PMB+cWblosBV2n0UiNSctMK5iDDCs6huY9HqdxMcQ1rotE59k8Wzsh?=
 =?iso-8859-1?Q?ZKj0gGFKDiwKCAVP6Dz5rD+KYABBNhCv5KHRjWJb7oQZB0YTKc83r6V+CT?=
 =?iso-8859-1?Q?RtgEDpQgo+P4KZqNQ+GM2oVKZv19HoC7mav0EncHBQM3U5aaE6YU4kfe5L?=
 =?iso-8859-1?Q?D6c6yvLV/7CF22h80DK+l/jpxloDjNVwZrDhDo7o9YUHN1m4iI7SV78w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a9c8a8-ef13-4253-eb62-08dcc9c415a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2024 13:51:59.3862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZzB7McqtgypOSWMBIUiBODQEvPJbWStujZRJ1NhHUCl0tJzPwARpW8KcwgJS9kbzfb8FfTn73ro6QuhURUghkwKS03gcvwpU6La8IKPVbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0560

Hi ,=0A=
=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - toradex,verdin-imx8mp-wif=
i=A0 # Verdin iMX8M Plus Wi-Fi / BT Modules=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - variscite,var-som-mx8mp=A0=A0=
 # i.MX8MP Variscite VAR-SOM-MX8M Plus module=0A=
>=0A=
>That's not correct. You cannot use this SoM alone.=0A=
=0A=
I took the reference from var-som-imx8mm, where they use "variscite,var-som=
-mx8mm" in a similar manner. However, if you still believe it's incorrect, =
I will change it.=0A=
=0A=
One more thing: should I change "VAR-SOM-MX8M Plus" to "VAR-SOM-MX8MP" in t=
he DTSI model name and in the YAML file as well, or keep it as it is?=0A=
=0A=
Best regards,=0A=
Tarang =0A=

