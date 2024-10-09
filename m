Return-Path: <linux-kernel+bounces-356271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2171995EDD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140F91F2307C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC02155A52;
	Wed,  9 Oct 2024 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EGuBi/to"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF15145A0B;
	Wed,  9 Oct 2024 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728450915; cv=fail; b=TMB0f8/lILTh5d1GpcHEaCFe539hZVXA8yRIYiEHBMTHihyWkgOwKhB1d7Fskr48GHdVSePzLlGDUkPi4u7uvo8N2JqhHa8BDY5zguyc8VTqEJ05nNHtpEZZ0VuVcF44o31WHxacc3Vp+LRwfi1RZLtbIO//sGsXs7Jb8F83Crw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728450915; c=relaxed/simple;
	bh=eHMtvw8q+6H8IT3kCkFS38/3P+w6KH4TnOGmdI1Jxd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=asTCdq3KvMkh/nwC/zMdgYYPpYEnVOIw2dn0kSp+zjWxEEO6lBsQ1JsL2GRMdfuCKyrA/9wOIFrZOrJJfsluogGk3WwmgXi9jgGhtcyP7RxiMDWF8lEVskGwpdVpBGVqcAfC0eVhSthobATHXMM0V9V34ObrcsbMRFktZsukM2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EGuBi/to; arc=fail smtp.client-ip=52.101.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlDMvQc7A5TrwcH/CxXVyVbISqWxUjdt+Yfxxgl3/2OsaS3706tP9laSsdJ/DgZIJ5fC55D62GAuvZXoxrQgfciq6nYU39bEUQHkQOSuEk3aYhiHd1buVlHjgogNdObbv8ABuJegexJ02HFOPQ8ZHcf9nmviz9uzcUAHp/gevPpLS1OfGwRqkqqyKWYH3cn3PjULfAK9PypXpq2+Itb35Vl2NgGEZH4urrTYbA/hiEosSsQDfZER1CdcjTTAQg1alCH2ZupSedjFz4+aod3MIzRMsg9l5oyK96B3cTKIAr8K5UXalNGvO3GA2GopUBgXJnFedwErUO/bZ9rFodYYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VBhGCMxKx8avnhb9XBl8r9WtLHT+79ipSRzjXJHxAQ=;
 b=pC6Uk5VKsmRZ6GC8Npp7ZSBxsPjKNBX34npP9+40WYNP8ha2LQxHG74pDVROVKIEK5YAIWzLpUnA3rqp/H7SN2zg7KtSvXzn/0ISForw9GL8ShFIEbAXNmkMA8ajnOoEDMm2XJLcxspF4yt77ICrGFdt457V0PbrVsPWERYgwqosqtM7ua8q4wjlURd2a0wau9DSS4XWHWoiI+5Gy9l1YHzFUEQ5nkgknW/dTtOZS8A1Sjpt97leJtRzBFqDtFcWbkOi/s3iVm2HhO7oe/jpJOPg9NkY1aItTFeF/KiZFr9qe+KwQXgSJKlxQhlvcnN0jfgikPALDBEAO8NmriRivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VBhGCMxKx8avnhb9XBl8r9WtLHT+79ipSRzjXJHxAQ=;
 b=EGuBi/toerP0CpdDLg2iYGPj9vf5YMkHF3p7IpLfw8hgqPWksuD2e/jDLSR2wHdb5n9ZPYOkF1QkN9uNY0xF1ANYyo5EHqhk+SCBniGAa/54xWqBkB5tXYEgtJLd3wY13Gc8eHeiMtx1B9CH3fhPB17IK95Iai0fJ06orrbjelt2mNo0SVaFptN6HkHf7ZgQ7sK+Nz1TxFnpFewOiw//NKYkwTP6o1PjgLQWgBN0aIHQsndG7eo5NKXIHvYhMBnDnN7dQfxTm1CVRST258qPQFU+xvWfBQPYWfQo35UTvmWAPprE7PbxM2sgLemgm3OzqSxz709iOMTly/kwF7aumw==
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7)
 by PAWPR04MB9909.eurprd04.prod.outlook.com (2603:10a6:102:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 05:15:08 +0000
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72]) by DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 05:15:05 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v7 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Topic: [EXT] Re: [PATCH v7 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Index:
 AQHa/rj+Xxal5gowYku20JmR9i3Hr7JPZ5YAgAqyPACABpKkAIAH1ffggAFzdgCAAAGcwIAH5ZCAgAlT6OA=
Date: Wed, 9 Oct 2024 05:15:03 +0000
Message-ID:
 <DU2PR04MB85998229EC5087957F5185EF957F2@DU2PR04MB8599.eurprd04.prod.outlook.com>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
 <20240904-imx-se-if-v7-4-5afd2ab74264@nxp.com>
 <Zt7n0AxGEw-ZXbui@pengutronix.de>
 <AS8PR04MB85932B4E47EFC519B0EF6D9A95632@AS8PR04MB8593.eurprd04.prod.outlook.com>
 <Zu1kUDb5dfB5dRbe@pengutronix.de>
 <AM9PR04MB86042C9BF315EF130FF0408A95692@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <ZvUupApT8q_TRJds@pengutronix.de>
 <AS8PR04MB85935C0146A9393E6D75456A95772@AS8PR04MB8593.eurprd04.prod.outlook.com>
 <ZvvPzfUHUK9gbYMi@pengutronix.de>
In-Reply-To: <ZvvPzfUHUK9gbYMi@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8599:EE_|PAWPR04MB9909:EE_
x-ms-office365-filtering-correlation-id: 434c20ae-9d75-4c10-e71a-08dce82155ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?r2DauXjazvFRPyhvmKWttHWbslcY8mZSqbQXUw1PwuDs+oVF2cP5PknLNY7J?=
 =?us-ascii?Q?JMtZLX5zAMQ4aYESwcmsSTdEx1QRQZyYcRVfM3sBBNHFVhd3+lR1KqkGiMvX?=
 =?us-ascii?Q?+33UlAM24+N5fB2wd+Q/3y23tyTfTDb3CKUwX0Np6kDmkjOhTEHC82va/UD3?=
 =?us-ascii?Q?mhODBjCcI9EV29f60p85RKU6RMh6KBtQcnzUSguDaXY2YQafXkaaKA+LoHDd?=
 =?us-ascii?Q?3R2eiRnMXnkqzKb8r8tUU+ltRXTN7fz5CVqOO46LuOmNsNCkmzrZTc9LS44y?=
 =?us-ascii?Q?EOcREZtDvX5W9NstUw04dt23wmjmdrryTk2VMLLpNqllT2AbQ811z36kF4Hb?=
 =?us-ascii?Q?Uwff8r8Uz8qZaRGuVxR5ozvX7nJsPAhv5CDxytWXLiZfF2oaWuC3KJ09K7ce?=
 =?us-ascii?Q?zQHN5W03wQdEIPOthOMQc7xlvl+5gMD58rbjkkgSCDUd0c822QpXXx/sLL0q?=
 =?us-ascii?Q?uaUjzoNxyfsPnwWRBnzr2vhXNhrBfKZvPDZhRtvIvlE05lc01eCt9xkuQIyS?=
 =?us-ascii?Q?lceI+E70Q+jlgTz9BDS/MJ2KEXO8lJQrWOxgiDdmTjq8QnHvktCi/i9uNTMT?=
 =?us-ascii?Q?C4X6kWEJizzqS+rClBdwc7BZe7nPrPuuFok0hhVD7mrCebTC4V3MTAukZPQ4?=
 =?us-ascii?Q?LQywCXuaoLAxqzfj4a2fwdAKpdX+mzHnELy82sCfrM25Z++ieOkjsP6EkaoJ?=
 =?us-ascii?Q?ezQeFf4dbnRu1RelcdwI/YlO5aNjIW3qUjeuvUs34ZEsyFw/yrLY4aTc5YDU?=
 =?us-ascii?Q?Z816URyQ6ErPClXD+p12pFewNsYPxBIKlpILxHtGvUGfx9ejM8qdPi4tC/dx?=
 =?us-ascii?Q?BUJaWeFWSAW6yIJ+vMqINHX0YUtkFSIE8ruUXRKX3YHDGl8NOWY/22y/Bcs6?=
 =?us-ascii?Q?4YgKk93bmwJ/BwChlboerOu4j3CqPpKUh8aLfQq1+PiaORnyQNehrIXpgJUa?=
 =?us-ascii?Q?c8AE7gMxrGimHk9d4m1EaRpNuDjGLi21hpg0yFzS7kiOcXWMMftzLvOQuYko?=
 =?us-ascii?Q?90TXpEP91B5o3sCnNnyLgFoe93dVdxXdcCwWpdZskFV6Y3nl5sUuvo0bBGHX?=
 =?us-ascii?Q?2NStq0O4DoyAeR5y0oXh+rcBa1UdSO4PgLP6DggDy5oSI5vDbvIrqnfrxczf?=
 =?us-ascii?Q?qhRjXdYuGM+cI2r4fEvWWp/u0NcvNOqVrr8wVRQGvEQdwRxCFhpYeRx1y0DZ?=
 =?us-ascii?Q?4d13eufgdeDjowXEAZDEGCuzlXk10VJFiE2o/k1UpMXa6yUTOHmn1XVkHq3R?=
 =?us-ascii?Q?pYAAdm2OiiwWpDnGUwHECztzhnuSHrzFYAtxXMYYUg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8599.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yoXr1xwhmTW7aOuLf4lO3lAfUOE4mCySCyJF2JTq+Xx3Qlwh5iynN4CXfMNU?=
 =?us-ascii?Q?NOhbqQu83F3ZVpl34BZ+ea7eTgopBoU3FnfYy0AuZnssVm0CP0VXbLP/G+oH?=
 =?us-ascii?Q?bAZTkHXi9HP/M0kBfC246e9IAvyUannpRhfY3q3XpxKU3Azc8iXYuF16GIdE?=
 =?us-ascii?Q?cLOmmoaX0wnVgiV64edNCnXpEPvrIDQjXwoLTovYGoFZIs6qEcyeNFBSfWoi?=
 =?us-ascii?Q?PjHMUSKNSwkZs99V0l1h8D+xhK2VL7aLU5iAtwuMI6bFU7qRUpUlHMFlIZRo?=
 =?us-ascii?Q?beZZgqcSzkqrCYLWPgV3qP8mw3E4sjIKzlWuLya7agNDs6A+lD40GrVdnXhb?=
 =?us-ascii?Q?REEJ44hxIRKicgW/QzNdduDk1PgZqT/TU0NAAG0xOhb2/Sm6R6imPb5yJEvx?=
 =?us-ascii?Q?Hs1u5zsN7GJDqhyGPuI+HC8w5Ylx0OV/V+HK3kyM3yQWTGpelSZHV1e5FEKo?=
 =?us-ascii?Q?LDCdBqUy+eObWiX14uSlp3b+0GLRncFjUn0NsoOdogliYa1SmpVfw9L51ePi?=
 =?us-ascii?Q?FTU5j9AahCFvMH99sAjH1pXhs481eaQT3JiTg+xQo+X5BunwyS9BGgnYUxFU?=
 =?us-ascii?Q?3cBscl7Dtwz9TL0Dc3TX3PC7V3Is1QFhafCRqxCcLXgCnPco69EVk/b+EIy6?=
 =?us-ascii?Q?5nztmQZT7eYNLl6Tj1AF/jixBIMBKVoDS8p9OvR3MJK1qq84QmKqHVhiqbEq?=
 =?us-ascii?Q?lkAeWsTZmguY3KMoMv7luATwYds4a/IAadQNPnENDD3riETcB0rfnQrg2MGe?=
 =?us-ascii?Q?R2qgAFPzMLy571QPJX1cjJSIhFKvm2IW0oOGJrr3jTYwI5QpsGpW5lEEZ5Y9?=
 =?us-ascii?Q?dMNGc+j4JVk0RV2t/EMQLVnI7oTLkYkVPrFRXqAxvileQPNbxESZbb+LZJNz?=
 =?us-ascii?Q?0iZABjKEr5vb8LiuDFAMkWnmUAHEuMXGPSXngcRqyiqjRnKGDtcaO5gpkx1O?=
 =?us-ascii?Q?UpVBCrMP/XVBL8KLxZQamxAWlTLL2ljmBssEKlH9BCVb9+UGouoU4KxU0rAj?=
 =?us-ascii?Q?UVojJlUPTidbydm6Y0J0h54+PJUCpYt/belQ8bFAHFY1fO8BX3bukziJ4QiR?=
 =?us-ascii?Q?40EDIDNq0YPivl1Mf/8ZOB6+g2WdI+DKLY5YZv7/p1N/zncE2dW0KUdurH1s?=
 =?us-ascii?Q?ZqJYIIoCMMBjp2LAlR+BIMgYaegOWec+s4nPb/R7jdrMZtsbvUFub+ojrLW9?=
 =?us-ascii?Q?O/0w1h4bO/HNUKbdQaNZItueqAb8YTUMpHscoYu778o6jtIeh6VHqp7E6Jpf?=
 =?us-ascii?Q?0OtZ7VY+3nxmWjVwdqWpSS+6p77mME2bXSQVlRcuO2w1MeiwHTFu6f838D5a?=
 =?us-ascii?Q?VM79Ld0/0Td7dG64DLiRLvAcw1Ph9uJfcX6HJXShAavI7+Ha/nNwUrAsZnlo?=
 =?us-ascii?Q?LOQm1EQU34qcy+CX6Ce92Dz9n82AxmOVSlxL6shb/yZc68z3eAXWvzzTzdw7?=
 =?us-ascii?Q?Kb2OcM7O5PWXz3mwyGQN25QMCpJbAEc68/PIiQh5RJ4dRC8A2+FDa12pxunN?=
 =?us-ascii?Q?lp5euH5VaZ/AFKC1Htb81i+dRVtEi8lsXdgTyar9RZb3lCFDS1owlX0vFNWT?=
 =?us-ascii?Q?3HIcS/019Li0KJIPdfTttFDVpM0cmNz9lg3qXHqT?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_0137_01DB1A38.47F8CCA0"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8599.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434c20ae-9d75-4c10-e71a-08dce82155ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 05:15:05.2615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LggenrZs09Qnx3TN4XzYuQCLmfKhvFo5D7zkwTzB8vvw9rTIMXKtgzAiCMzC/e1o2y9B7vgUY2cDZG99hoFZnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9909

------=_NextPart_000_0137_01DB1A38.47F8CCA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit



-----Original Message-----
From: Sascha Hauer <s.hauer@pengutronix.de> 
Sent: Tuesday, October 1, 2024 4:03 PM
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
<conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix Kernel
Team <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org;
linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
Subject: Re: [EXT] Re: [PATCH v7 4/5] firmware: imx: add driver for NXP
EdgeLock Enclave

Caution: This is an external email. Please take care when clicking links or
opening attachments. When in doubt, report the message using the 'Report
this email' button


On Tue, Oct 01, 2024 at 07:49:39AM +0000, Pankaj Gupta wrote:
>> >> >Either compile the firmware into the kernel or the ELE driver as
module.
>> >>
>> >> Cannot compile as part of Firmware.
>> >> There are OTA scenarios where the latest FW, that is downloaded to 
>> >> replace the image in RFS, and FW needs to be re-init with this new 
>> >> image, by putting the Linux to power-down state.
>> >
>> >> ELE driver is compiled as module only, by default. But if someone 
>> >> like to make it as in-line to kernel image, still it should work.
>>
>> > I am also not very happy with the situation that we can't compile 
>> > drivers
>> into the kernel and just get the firmware later once it is available.
>>
>> Driver is enabling the ROM API supports at probe time.
>> And, once the rootfs is available, and the Firmware image is loaded, 
>> then it will enable the complete set of FW API(s), along with ROM API(s).
>>
>> Hence, Driver can be compiled into the kernel to enable ELE-ROM API(s).

> I see what the code does, I just don't think that it's safe to assume that
the rootfs will be mounted after the 50*20ms timeout you use.

> I also think that it's a valid usecase for builtin code to retry firmware
loading after the rootfs has been mounted. This should be integrated into
the firmware loading code though and not be done as a driver specific hack.

> Anyway, it won't be me who merges this code and I am just telling you that
you'll likely have a problem getting this upstream as is.

I have another way to predictably handle in the current flow.
 -  Will add the check in the "se_ioctl_cmd_snd_rcv_rsp_handler", when the
first FW API,  is exercised, the FW will get loaded.

If you agree, I will make the change in V8 and send the patch.

> Sascha

--
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       |
https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.pengutr
onix.de%2F&data=05%7C02%7Cpankaj.gupta%40nxp.com%7C7ce6df77007f47dfa74c08dce
2046437%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638633755716236681%7CUn
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
VCI6Mn0%3D%7C0%7C%7C%7C&sdata=YU78kbX%2F9JXaI9WFN2RcIyvV23qU8TvqCjqDv15lO%2B
c%3D&reserved=0  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

------=_NextPart_000_0137_01DB1A38.47F8CCA0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIImZTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
ggEKAoIBAQCsljsxzffby7IAt42e7cJH7K+49RL+7i56h3ORt8dS8WNVSdDlejp6uS6mLk/UX0wn
sSxDK1S5KquGJQzaT/3gxE8tdgvfFNBVdrgr48DeCVwWDr1o/UF3RmGcMdxqRz1M/oLDJ03C8n6h
L/0JXiwsNx0KZJoqDrN/48yX5TkoeKJmHFftZ5Op57xV0WkZJ/yLxSC1Om75jOG/UPdqsDzl+wi7
YVj5egV24hoaXgHBxtCeJzUgsHcJlo9nFtGe11j6H1vqFzkPzN9ydjRmhQATV/WLqpG8uot79u0m
6n7Mjwsd/HmJf+8xpovMcHPO2a0axppssKso/3APP6mR1FuVAgMBAAGjggORMIIDjTAOBgNVHQ8B
Af8EBAMCB4AwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAwGA1UdEwEB/wQCMAAwHQYD
VR0OBBYEFLNr0DCWM1fCXv4ubOt/elkvcoiaMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRw
YW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFua2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAU5TJ6
9GbBR5Ykf/wngDlY3ysX4rswggFKBgNVHR8EggFBMIIBPTCCATmgggE1oIIBMYaByGxkYXA6Ly8v
Q049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1ubGFtc3BraTAwMDQsQ049Q0RQLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2Jp
LERDPW54cCxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNz
PWNSTERpc3RyaWJ1dGlvblBvaW50hjFodHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFAtRW50
ZXJwcmlzZS1DQTQuY3JshjFodHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFAtRW50ZXJwcmlz
ZS1DQTQuY3JsMIIBEAYIKwYBBQUHAQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049
TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2Vydmlj
ZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jQUNl
cnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTA/BggrBgEF
BQcwAoYzaHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFAtRW50ZXJwcmlzZS1DQTQuY2Vy
MDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUuaklY/hMbNXILljX4C
AWQCAT8wJwYJKwYBBAGCNxUKBBowGDAKBggrBgEFBQcDAjAKBggrBgEFBQcDBDANBgkqhkiG9w0B
AQsFAAOCAQEAWS4IrHXWhCGNWk5vn20xV7mlLkM7JPwltVJzB6MRzwUB438upbyUMwNHcEgAmHcs
xL9hafErN+n9rLL00wEqZsCV732s7YOxSRRjZTE3CmZQ2+TYjXR7A6AzQKo0fv/x43bpSes8ttQ6
Qtt8nzIbGBkDAcI7wfXsUPF5o0NwLOxre+Z+JCPNH0eaOj2J7EKD2ERLCClmvohrYdlmu85iXfyi
nJo42eq9g08FtnxTXVQSIZCtiETiGtXA7+t2Aa8429XXunsijRznaYw2SwI/s4sVmvaK3XHaif0D
QaUYxQp4s2ctzgz3eU6hK68OnNzbhBtF/lx6PHbifqHDzrtUbzCCB+8wggbXoAMCAQICEy0ACwRu
JYOozH+yQuYAAQALBG4wDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMzEyMjAwOTIw
NDdaFw0yNTEyMTkwOTIwNDdaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAklOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
ODcxNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL2JT+kRihW1mBdeZFOoCLGIl4DZ
VL7FWt3V1iFFJJe/bZDw/SUf5z1HeA8xv9+S8rqMyybjlSRHFLgiMm7qrGpVEDniKe8eiqP8Un4Y
3fHgK5FKZIVVn0KlaMuD5G30AMk9HyUdc2MkVRL8YSQCewkQDEVjB8gnx/e6xfbWEVHf5+dOWJoR
aket5+0JKV0l/dPV7cT4hL3BFtiBhq8976Li6rn8gxIi63u0G3qvm9Scqk+EHzemDhw/W+eMmGR4
nwKVLKzumxko8l6EOnnvqqF4vj2hKTpB+2lsEXH1giireMEsvB2RY40lnRUXVQ0FDklOIQV4Qdgi
EJfUdq/ZhCUCAwEAAaOCBA4wggQKMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/gbeCPIPthzICAWQCAT4wEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwHQYDVR0OBBYEFMJ81PK4p3H8Q7gn7u/5OwWx
uAwGMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRwYW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFu
a2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAUWJVg7k5072Uiqr3tGakreo4XnQcwggFGBgNV
HR8EggE9MIIBOTCCATWgggExoIIBLYaByGxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENB
JTIwNSxDTj1ubGFtc3BraTAwMDUsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENO
PVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y2VydGlmaWNh
dGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hi9o
dHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybIYvaHR0cDovL3d3
dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmwwggEQBggrBgEFBQcBAQSCAQIw
gf8wgbsGCCsGAQUFBzAChoGubGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENO
PUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0
aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1j
ZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3LnBraS5ueHAuY29t
L2NlcnRzL05YUC1FbnRlcnByaXNlLUNBNS5jZXIwDQYJKoZIhvcNAQELBQADggEBALwIIuww1PaF
EbpQoy5vgJ/4N3xS+niIpFTKyYNAD0Ar38FcUlSnj0FIHKRj8rUmZP9WTky3U8m5B3LOyhJ14FPh
iy1EwkhZmds9fJiZyEEFiwQWYDG/uknu6zIKOTlLmtlYPfbzfi58keGcjD3T5H8D8DpCGWI1lAwe
clR9fJCbcYnQSQnuicSCfrHjjXiDZ2O8h7WbE1CC6Cj/qwo5nmS0lMv7yoG94rTNBvYe8iqOkcav
7KiZA6SdhXms3ppvFmBukI6pTheMvT39SM0S6E0dgeqZSGSxHrM7dcxUdAL4fnYMv3Sa+GAgyXB6
rihWC11+goz2eawt5TRU2w45TmcxggSzMIIErwIBATCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVy
cHJpc2UgQ0EgNDELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5k
aG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJ
kiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhM/AAV1goSs
wyqoLYNbAAUABXWCMAkGBSsOAwIaBQCgggK5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI0MTAwOTA1MTQ1NlowIwYJKoZIhvcNAQkEMRYEFEpV14JRe/pd54KCsrMr
fd5nuvbmMIGTBgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggq
hkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIaMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMIHfBgkrBgEEAYI3EAQx
gdEwgc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjCB4QYLKoZIhvcNAQkQAgsx
gdGggc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjANBgkqhkiG9w0BAQEFAASC
AQBUHpLS5bwhhT+NcO1xgwjQefRjFUE0wFsfqYVihf13wxcQPAO1sGIqeZLJoSOLhDijqrGUJMq2
SWgKFzLUYO14ngJYDjhZMYrVni/htX6YovQfLz4FhPx5lyXk0R7fndEfmkvDyWAzfgdlISr8sqTS
7OVl7L8jfIQ9tJcajkmkD/LHPZC/DtAzavQmmwlwrifArq2oxVu7cChI+v47ERselj4JTy+DuFbR
M/dM7TvRK4AwwFpX/GLkWV4OzRDYWbmJbadxgIIlVS+Rt4tdGa5Ci1h++BH9qPOOhHOosns3DahF
rH1TT/I3qSL839rfvYUa774Lk1PxvMUMj82muZ0aAAAAAAAA

------=_NextPart_000_0137_01DB1A38.47F8CCA0--

