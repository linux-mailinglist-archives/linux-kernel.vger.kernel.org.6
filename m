Return-Path: <linux-kernel+bounces-214609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADDD90870B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004DC28488B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDC21922D0;
	Fri, 14 Jun 2024 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UmeI5ZUj"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC54183071;
	Fri, 14 Jun 2024 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355955; cv=fail; b=b4kqCpQIjdM0ZqDpTgfsEF7EddAD18cgHgY6NLs+FtfzwrnsQyNotNaSx3SN8mmk+oNQli3NszHhhSt4BPrQscz+c8FFsNxuUctviHM7j4vtNxUDm9kmcxQRCVwVvv/ZAFpUpJZbsfKfixEWRUNPyGWYYdFsNITFvKzQjxx06UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355955; c=relaxed/simple;
	bh=54+l08JcQHmvxGyxsG2Fdp8DswR3ULfT4f616/UsL4c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DaUPnbhqQld8iIHFcG/SoBn9DIeZW7kdF1jkI8Y0rfl7wsqnuUBLsy4MuEEZR/N0VRKQgX67zeSPPNv+L/1wbx8EHM41YXbHRkTHMq1Y5kBGeTzfW1Txlix6BiLue1dr/LQ4cqJQLpjE3l2DuiUlExjECS5K/Pg8lzi1mWzK7Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UmeI5ZUj; arc=fail smtp.client-ip=40.107.249.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELy1ZAmz3qjravvIcMswYxtqT8cHv+IUDTiesZMxYh9rq3Wp0j6mQx7BrkiwCfsoHLFb8L5WQwDUbBRG/13EKcldPLiarGUO3X51aLcV+N7aotd80G0zVa2asC+xWEt9tY2vHlxSsNztCuYgmg8E7Ds6/YSipTylSqf1IvEzYAKe+rOKHkltAERyeEzoD5zt7PWgSvUY7HI5pO3zeg7WNAjFFO/oXvHXpeWEwRhmn3nx85xCeGE1pKGLMWaP0fVIq0Z3mgK52H2G1GL2NIcBJIlJtHMbJ1F2bT3z1RrHVpJOdI/uC2Y0rKS54hOizipZIqKyH97LDpZSH/MlsNh5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRCiNgoZ5/6rI0dAl7KIm90PxaeKYFOBgLNng0VIq2k=;
 b=WQ7g/Ho3xHXN537U8neIuGBHHNrF2zamwLsjStBnBw9ymzKBfsIbRc3VqefyBwUbADeuMPQvBnwEhUcCC4ZfrtHg9PFe8Q2vPg+smxGiIs5B7AAwJ0rlgo0Vjy4RF6heQ3JNrekwrn36xxCjZB2vIefsfaVBI5OaFwXV+IV4SqccX4UbIhV9xf0OgdJsECX7nls9jpLei96VvaS2LN+ylyEs+WEOuAYQ06QY2JeLfV7HhqXWPKc9PdPm5uDix0BrOONJLSGBY4LIWzwRFtVukV1mLYPn6o/wdOomwEV/OZjtfzTsxUbPE3SQnSYsyWJtdBqGmZSYW1taEmkzaGIZdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRCiNgoZ5/6rI0dAl7KIm90PxaeKYFOBgLNng0VIq2k=;
 b=UmeI5ZUjnyiBdedMbQ4uBlR23InzTJBH7w9khhj7xnIvYf5m4xTQjfucteouh60I3hAnxB566lkr4g4Kq3R36CIRififpiO/n2Lj3YZLQIF1WBkiSt6Yx7L+7wKyrC2VsdCZXFrnvL5zSFLxL+DCpw6W3NRMqPB6RIrd6Yk+H84=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM0PR04MB7171.eurprd04.prod.outlook.com (2603:10a6:208:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 09:05:50 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 09:05:49 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Pengutronix Kernel
 Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Topic: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Index: AQHarP9ayLdOqCtfLEqTQR0Rf+AVuLGmMeuAgAAZRgCAAAXWAIAgyBqQ
Date: Fri, 14 Jun 2024 09:05:49 +0000
Message-ID:
 <AM9PR04MB86047886B5191D94C3E68C4C95C22@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-4-5a6fd189a539@nxp.com>
 <ZlBtNSeh2VyZsVxq@pengutronix.de>
 <AM9PR04MB860424A71753DBB56D2CEF5895F52@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <ZlCHTqJ0Umgh3LCw@pengutronix.de>
In-Reply-To: <ZlCHTqJ0Umgh3LCw@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AM0PR04MB7171:EE_
x-ms-office365-filtering-correlation-id: 2e90997a-5e33-4421-ee7b-08dc8c512fa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230035|366011|376009|1800799019|7416009|38070700013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3F6xUKsIbrfjdu5b2SI6Cvypi6a2j0S+6sBr2P4w/4s6ALo2qOc2b5G2W/Kw?=
 =?us-ascii?Q?UhXi2eMYOiyGvfeEsm0QwCAM4xsJCstqii5SAU2NpqgWIeAD0I5CMHbPCrdy?=
 =?us-ascii?Q?vcAjZ26N2FY2H+y7OHSdTfTuyb/S0UXjJlz66tXsYtiujrzadQQ995GikDKu?=
 =?us-ascii?Q?zIXb9XW4HZjVolqPEpbkTKLhIwK9U1cGPGVvod+kyvM1SckSbDZxuwJW0Do3?=
 =?us-ascii?Q?aCiURV9hteu0gPwHT7IRBHQyJFeSPr6XuEOK2sYZRg7b0EwDNOnsPlBRoZBI?=
 =?us-ascii?Q?mt6/LrXPfsQO8X8Ds2gRZz7I0Bz4l1f1JZ+ngqeKq11PRPx5lnWJ1UuRP4ty?=
 =?us-ascii?Q?1rxbxOPYh1igTbInGpXXRxNgLQZe00RKTT5sVQKwxErT6E+0x7gMnGO+Ib+5?=
 =?us-ascii?Q?HiMWeRILbVJ3/29WwOj9xhYnMsOyTmCVFO43MODByyVa5gihr6w1SwkcIXjo?=
 =?us-ascii?Q?UG0z/bEPDWdlIANtD9+rNpgcE6YoENQ7YKHnH46S0wJfj48v4GBvCBL9SgYg?=
 =?us-ascii?Q?wwCq43ZAmgBpqXKlbjidkytd4/Ke5nZXwwJ7cA+nrpE6yp4yoI55oLt1evEA?=
 =?us-ascii?Q?Fu4/F1Ii8I39hgN6GMDg1yd75U7zuwAE78EurR1U9PwsvEo0I0wn1U095uAU?=
 =?us-ascii?Q?9VOOBDU+VtSU8pz+jME+GWxZSYCHeNFuAYXiDD3bAby1pSLCpZVpy04DudY2?=
 =?us-ascii?Q?8SZUPXq3SR+F684v+1PbGfNLG9Mx5zo+BznzvB8V6s35qffUZt8WX9EIEk9+?=
 =?us-ascii?Q?K4dDHQmUEf+3gYpnBleHzp5NiKxPUGK7odcRF+Ayl9tAL9kbfKGfV5K3mMwg?=
 =?us-ascii?Q?D+Ou+l5TzStNpvXh/71uhl0iQumiEL7mmUQ/zexRrLyIQe9n5yemNPzpsBAe?=
 =?us-ascii?Q?3YoAJzb5xm9LQLRbI1ZeJbWytmpWIii98eOYGkBbekq82I66TYNZwfS7SnRg?=
 =?us-ascii?Q?I5Y33sLRhMNif5AORdMmQFsiI8oy/hOyau3WgyxqqN6893GngkTejj8P9brf?=
 =?us-ascii?Q?f0H2VzItX5gopr+lgd1sDyW6TpIE80e8tc16SVAbbGJcYsQjjE8lq2b4CQfu?=
 =?us-ascii?Q?496CFHzSBtj4f1C3I5QZeLIHBWhw+Ilp+VbwnAG4rlbAQdnQd5X57cv9pIpZ?=
 =?us-ascii?Q?+T/6VsIfbuleokpn2Df/eN1douWRAFVCY4ZMy6jcCDZ2q4xPxEmFQJdnvS4i?=
 =?us-ascii?Q?R1eNaOU58FAEEI+Oyywa8/9Rj/YkheyyHfWxGxZsJAEPK+aXhvcTPHQucHAk?=
 =?us-ascii?Q?ROiMtV526hSHNfaOYbJhZHKm6TuswqOR0NA614qVgeGp5rBuLLVvR31TKbzT?=
 =?us-ascii?Q?NdSzMQPhQbBipDgsr7JzaFdC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(366011)(376009)(1800799019)(7416009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+ej4eAQhntdhORZXeWN53wFMvILO6/kah7D5WQXb48euG8dG/blNRHeo0The?=
 =?us-ascii?Q?GAi+3R9NBtrnrH7W6OsUHqoJGfYn4Lj8DjfWlBpg3KoZMZJjRqqDfRWZgby2?=
 =?us-ascii?Q?aZkL0dyp2S0CyKNNmSutNUsk6AnpGMeUA5ADySyZsn018Y06DVUuJaL/Htpq?=
 =?us-ascii?Q?pv1ZGcoxRTIjVh6hdYn0UGQZEBw548fMhUMsyXKPw+/yGEIN7SRlojHSf06q?=
 =?us-ascii?Q?SxreArXGdE9Y2YFPFE89XPVPpuM7OeHrFD7gxEtt3meiY806riK8XT6LLR7/?=
 =?us-ascii?Q?sDADPolnJ4NWdfdjNs50RaMgtzGo3Jh4ueSSUlI1/5ADEqvnDAn5YWZDzB/y?=
 =?us-ascii?Q?wP5mqn4TKPlBKQOX7Z3jVQsSREGbfg1ahucvuco0etfqbEP7I9oWqSZFk4DL?=
 =?us-ascii?Q?rOMrsMqaCMpuBfMVEiTQ1Y+FwXuUa9Nd+s0ANlfF6fZ8LRpLjXAVYWg5z79v?=
 =?us-ascii?Q?+MJzDZh0xXe+MGXqiO8AYGXxSKSGoCu27SIvExJcH0D+Z9VfuYY6aahXuAen?=
 =?us-ascii?Q?rBHW3thDdlADVT8g95OUI76N2dV5vTKVN/rSzjyFcenS+np0d19WMmdmfTWQ?=
 =?us-ascii?Q?b8nTIKzPlz1J7MHjyFTI9gM7B2nlGDJ/PXZPwrUbYj5Ot5BG1GOZMFUxCzsS?=
 =?us-ascii?Q?Gql/OmDPYdOm/jImdjxsenA4M0lLXNfOH2BRE+gjKju9GbjphvvsWDwEKenC?=
 =?us-ascii?Q?Ova3KAhic0DKfXI8uiFTweByF47Iy0Q9AMuNKor8k0dHkdcmqnenrfzm6Gsg?=
 =?us-ascii?Q?ZTx9Ogdm8MGJ0Z103StsC3XO3pJ7uTVW9bLwI3CijdVSPzgfaHU6v3veWBIi?=
 =?us-ascii?Q?iu8vghxMVyDueynjUAf5w6jKDVjjKAqMbErBbxZYqgboHUDmUVAE1Zg2bg1Q?=
 =?us-ascii?Q?DoDFQqWcI4+iyiapT1jVB4PdfSuKRz7FkiffBQs29fE3KcKASxU1qaTfQjbF?=
 =?us-ascii?Q?3Dq4uE8jqp/4KT+w8COuS12v0SuAOkpypSRMbpXe209+N5UWqGeSwPVy9IZh?=
 =?us-ascii?Q?W11dbG+bcCae35EchF9Qe/EL3iIeg4ibN1k8JRi8yX7TwJMBUS/QNbYc6cQ4?=
 =?us-ascii?Q?wWPUIRFj444QG4V9eTa5XIiqw2DSi8qBTIcrX8lB73ThHevrg+IpFptXfmKs?=
 =?us-ascii?Q?LGrYL58sRMmw2taHB/bBooQaVahJd+7jgYpzIBRB7KS3ZdBbRtx50lyVG0yp?=
 =?us-ascii?Q?J312rk8J8dGajUjh4P83hqEHlJk0UzdR203GgceDb7kH1gDyzcIkNNI7iSex?=
 =?us-ascii?Q?KqV2ne2lIgGhDgm/pzEg/VIKuGhbFh3Ygbe9yHoQyyB6MBEDKvXBGsZ7NINm?=
 =?us-ascii?Q?sRmfpxzsAKG3s3EN1zp4U6i8un/p+fpEnVN08yvIvNRrNRe6UTjUzbAreWAa?=
 =?us-ascii?Q?wEokLrEshPeB1e+mw9pONC50GlMZIl/oJ/ActAsE5HA2oDg3j5ms60Kbec2Q?=
 =?us-ascii?Q?/aq06WQLAkoooHmDhGKe3SAjhGfAi9cRhwTGZj1Qokc8t5soDQUbQsAMDGkE?=
 =?us-ascii?Q?lu1rSQiixLgnHcATWV8tmvWflRU12BgfV5HURN0+h7F/zMDnpWdOpGlnmatV?=
 =?us-ascii?Q?QtVguexkBCTepUS4vRxkVXKY4cQ3tdWJBtzbBxFI?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e90997a-5e33-4421-ee7b-08dc8c512fa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 09:05:49.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BHwN3FG3VBxVP8Eafn94DYw2fc+ACivUKk8WVtbq/fL0Ex/lLOVanQ19kJMjsLzcHe7efDpmM+I1qIoG3zKlcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7171



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Friday, May 24, 2024 5:56 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP
> EdgeLock Enclave
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Fri, May 24, 2024 at 12:08:14PM +0000, Pankaj Gupta wrote:
> >
> >
> > > -----Original Message-----
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > Sent: Friday, May 24, 2024 4:04 PM
> > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring
> > > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> Pengutronix
> > > Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > > <festevam@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof
> > > Kozlowski <krzk+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > Subject: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP
> > > EdgeLock Enclave
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Thu, May 23, 2024 at 04:19:35PM +0530, Pankaj Gupta wrote:
> > > > NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE),
> > > > are embedded in the SoC to support the features like HSM, SHE &
> > > > V2X, using message based communication interface.
> > > >
> > > > The secure enclave FW communicates on a dedicated messaging
> > > > unit(MU) based interface(s) with application core, where kernel is
> running.
> > > > It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.
> > > >
> > > > This patch adds the driver for communication interface to
> > > > secure-enclave, for exchanging messages with NXP secure enclave HW
> > > > IP(s) like EdgeLock Enclave (ELE) from Kernel-space, used by
> > > > kernel management layers like
> > > > - DM-Crypt.
> > > >
> > > > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > ---
> > > >  drivers/firmware/imx/Kconfig        |  12 +
> > > >  drivers/firmware/imx/Makefile       |   2 +
> > > >  drivers/firmware/imx/ele_base_msg.c | 286 +++++++++++++++++++
> > > > drivers/firmware/imx/ele_base_msg.h |  92 +++++++
> > > >  drivers/firmware/imx/ele_common.c   | 239 ++++++++++++++++
> > > >  drivers/firmware/imx/ele_common.h   |  43 +++
> > > >  drivers/firmware/imx/se_ctrl.c      | 531
> > > ++++++++++++++++++++++++++++++++++++
> > > >  drivers/firmware/imx/se_ctrl.h      |  99 +++++++
> > > >  include/linux/firmware/imx/se_api.h |  14 +
> > > >  9 files changed, 1318 insertions(+)
> > > >
> > >
> > > > +static int se_probe_if_cleanup(struct platform_device *pdev) {
> > > > +     struct device *dev =3D &pdev->dev;
> > > > +     struct se_if_priv *priv;
> > > > +     int ret =3D 0;
> > > > +
> > > > +     priv =3D dev_get_drvdata(dev);
> > > > +     if (!priv) {
> > > > +             ret =3D 0;
> > > > +             dev_dbg(dev, "SE-MU Priv data is NULL;");
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     if (priv->tx_chan)
> > > > +             mbox_free_channel(priv->tx_chan);
> > > > +     if (priv->rx_chan)
> > > > +             mbox_free_channel(priv->rx_chan);
> > > > +
> > > > +     /* free the buffer in se remove, previously allocated
> > > > +      * in se probe to store encrypted IMEM
> > > > +      */
> > > > +     if (priv->imem.buf) {
> > > > +             dmam_free_coherent(dev,
> > > > +                                ELE_IMEM_SIZE,
> > > > +                                priv->imem.buf,
> > > > +                                priv->imem.phyaddr);
> > > > +             priv->imem.buf =3D NULL;
> > > > +     }
> > > > +
> > > > +     if (priv->flags & RESERVED_DMA_POOL) {
> > > > +             of_reserved_mem_device_release(dev);
> > >
> > > You can call this unconditionally, no need to keep track if you
> > > called
> > > of_reserved_mem_device_init() successfully.
> >
> > But it will not be called for each SoC.
> > The memory is not reserved for i.MX95 platforms.
> > This is required.
>
> Again: You can call this unconditionally. Look at the code,
> of_reserved_mem_device_release() won't do anything if you haven't called
> of_reserved_mem_device_init() before.


Agree. Accepted and will removed in v3.

>



> Sascha
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.p/
> engutronix.de%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7Cead7b9
> 3ccacb404124bf08dc7beca6b2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C638521503534570049%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%
> 7C%7C%7C&sdata=3DU0BX68CpPzJg%2B9IytihYTcmivJhfn7xbfIQpMp0R8o0%3D
> &reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

