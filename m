Return-Path: <linux-kernel+bounces-334292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED47C97D531
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4D2B21683
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6829114A611;
	Fri, 20 Sep 2024 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dnFlexd7"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C85113C80A;
	Fri, 20 Sep 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726833885; cv=fail; b=AyTisPIx2QY8DbRe8wBUVf4njibbHOpVA+WGhe53IoqFJsF5lj779aEdrCS3wLsRi9iRAXLparPCHgVJUz9nULmG1emJZ73Tv5rvNqcAGao/14vbe0zDULsRIWG13F9hcY3GxjATqWeVa9X8ejbSPnzmrRpHQ0QIodbyDTpyuac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726833885; c=relaxed/simple;
	bh=s27LdHT08Evi7vjfm7Qk69cHHQM4FJNs2uchrrm9HPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GhJpFHsro3wGsJNTNiHvg1Ham4wo9L0q+BE864adyyILluTObNI540Os3IAe6WDQa719cxUMKTqCoN3+C4OlOiuX5huol2yGmBwdmLnqTUI1mzXkH7VouWB6/RyOgiZpNbn5rokfTAWk1UXo18zPJVbv1PX6E3PV95td/Jtfo8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dnFlexd7; arc=fail smtp.client-ip=40.107.104.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnL7/Lsawe9eAjc07BLPf6lXY+uhKGZSb4aOEvsq6jHCm6mqxn9tKDI6cN+qbMo+Iu2r9lEFbFve5VyzT07w3hXJyA7xiZ3J3Pugj0QKOOHaDV/yfwgOGYuSc2LC3kA5+3tzC+ROHl03wiJw6Dz9mE2pXbWAUrGLSMw0mK3DVISwaLpRg6czTOlLXJIlGH2ED1PFczPCDDrVFE3aMdJEfTVfDlRJ3N2p4jOaH/BsaX7ST1bE8CRcmKBb8H0fWwTm2f0riIjxiwSq3AITrs2/9XwdzMMhq/zPjQCBP0wXzemNUiGBSrTunlvsSQg1I3G6EqzF5xGsR7Q87NSBprUoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4084ik8O35jTJdQemZuSbdO5+KQWaObd/jHixwHV/dM=;
 b=mBZaeKMzd6YxjYNP8/+UbHH6oNG8MxOacntGfg8xYG9V763aUKzZq9qaWPNJngCWLolm9OuvfGD0nTMygGtb26I9oiRMAnsghM/lj3UFeJrAa/UspIBOe1KvPnn2hUPT01Nagk7xEDtu1+P/1Blc4nzdDyw27y0TeR6D1s4j9XtCxJy/43qbuP2jx2B6mRcPfZNXX0Veh2bCxk/1K8Ek1kscqKQW3hLQXNMBMY4HYmZyW9xV4P9h4Gca5PFo+IwR3q7RcXCMfVTQ33o70q5lT/nAMCRSeekpSMEwgbrXxMa3DkmosIj6b/cptZF3r9Ivn0ubC05Dhp/W63TvrO+vuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4084ik8O35jTJdQemZuSbdO5+KQWaObd/jHixwHV/dM=;
 b=dnFlexd70R1TvWx0ldhsuufhTlpi38RidXKNSIx67EjszMn2b44vKlR8j7PqvD8re/cN0+erc22uCIIsUigZRs/kXFKoJI52oV4WHF4r1WsMcFssJVQ3BUdVGgX54MaFYMEch2HPlXEyPxdSOmffbmIbm/HsLLAh2CWGT0EqqkXu9FDvHHgAndks7/HVUMzOobKHA3738N1u2I1kXpsega/PpGEupQnx+lsRxXXhV731ksu2hIf+hemXIzhkKo90Inv81dR5NW3+U0inoiEQNPiBRA/0AX1QhVMFGseA+HQ1mr9rrmL04AWlQ3a/SMAnhOhesp2QcJXRgHOwdaKKvA==
Received: from AS8PR04MB8593.eurprd04.prod.outlook.com (2603:10a6:20b:424::14)
 by AS8PR04MB7509.eurprd04.prod.outlook.com (2603:10a6:20b:23e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 12:04:39 +0000
Received: from AS8PR04MB8593.eurprd04.prod.outlook.com
 ([fe80::7649:d0cb:11f6:e55d]) by AS8PR04MB8593.eurprd04.prod.outlook.com
 ([fe80::7649:d0cb:11f6:e55d%3]) with mapi id 15.20.7918.024; Fri, 20 Sep 2024
 12:04:38 +0000
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
Subject: RE: [EXT] Re: [PATCH v7 5/5] firmware: imx: adds miscdev
Thread-Topic: [EXT] Re: [PATCH v7 5/5] firmware: imx: adds miscdev
Thread-Index: AQHa/rkBuwLh9JiQbUqVbaH6YR+/XrJPaF4AgBCv7fA=
Date: Fri, 20 Sep 2024 12:04:38 +0000
Message-ID:
 <AS8PR04MB85930340FF8977746C4F8E35956C2@AS8PR04MB8593.eurprd04.prod.outlook.com>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
 <20240904-imx-se-if-v7-5-5afd2ab74264@nxp.com>
 <Zt7oeCcag5LKKV3N@pengutronix.de>
In-Reply-To: <Zt7oeCcag5LKKV3N@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8593:EE_|AS8PR04MB7509:EE_
x-ms-office365-filtering-correlation-id: 2a511284-2018-4502-2c0d-08dcd96c670d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HcRXeUCsX+APJtO8c4nccRjth7sJZB3Sh1o8pfXRIQLG/Cickb+E5nVZDn5t?=
 =?us-ascii?Q?4EqsbloPgKbw/JtdjyGskyHd/DhtuFRGYzNgq1UH0XCmunj/ZV8WhqUVRgOV?=
 =?us-ascii?Q?oPqTniwwO2bVl1Unilre8YPXB1ca/Q3Q1nEbblvsBaSXpCEL4TWZzgRG6025?=
 =?us-ascii?Q?WDk+eroyUrj2CqREFOvlK2K2LgSKrwChk0MYB9pL4+8DTXE0dFADxjMkEJ8G?=
 =?us-ascii?Q?22YUsB87v73ZW5TFHaaQy/U8XLgLEBGdRGQbgeZtXBUaioP4ymKApuUic0AM?=
 =?us-ascii?Q?QKYlsUslmooJAafujRK33nVph3FllglqKlmidvtRJdMnbQPJltUS1ToTicEt?=
 =?us-ascii?Q?SbZMaoP5PTvwYZvaOXWCoz370mfbCC4u/1RmGOEJRfm6u9BsPaoq2ESa4hMc?=
 =?us-ascii?Q?i2k/9xl3R2VahHRefaq75LZTr/j2uxgK2SeZY9PbOYOWEmkEKOy1a/cTqcCy?=
 =?us-ascii?Q?KGiIkc9wPR7W3R5Q7o8KlPw8c/pk8wpXWznINunfwdXd2V7EOv8f0coxqLRn?=
 =?us-ascii?Q?RtxLlCg4yRocV4tF2DL3mWEl+jvZhGsgC/871g7BKmqtlSX2XyZPFhvBjhCV?=
 =?us-ascii?Q?YeGrgu4QxJSWT0gsaUGz8OH4Pe7fHFicyV1Xx/vc+4ovyJWUe8/PaaGaquCi?=
 =?us-ascii?Q?O08aJc0LrU/r02ls0HUgP3ePcV4Xs9amCBKxaHU7Y1W3xLFNp2vwoqFNRXVm?=
 =?us-ascii?Q?sIv3KLNYNb1JJlWlH2hTvD53JqmBygqkQ5S93iUmBxjAAlPeaMs5+L/owtR7?=
 =?us-ascii?Q?QwYctfYlvmvu1zXi0xhAFs2Ft6GWM2rDOyzHL2MNi0CImoOzplk5jBlxKUdL?=
 =?us-ascii?Q?FOUB9mdtRL5hlysmcKL7/EanZP04sL8x8c9QAqxEDwDilqkVQ20fpDN3UQOC?=
 =?us-ascii?Q?nUrQq/sCT+Jd8sMom83aFMkosr3AHwzORjwUa1vIuxLF67VRTpqPYc5mhsa7?=
 =?us-ascii?Q?suw6oBjX/6qvVeWYW9tBV42eoTjs3sD6yaFEE1G+eZQXRgEPZUvdatZfJkpK?=
 =?us-ascii?Q?rCF5LLvl/q0I08xKyPrJQT4YwRt7SM6ohwdI29sPlqSI2tyaylhZLRTFOd0S?=
 =?us-ascii?Q?ke7xgmISMRBlzKBoZJpG/pNFk8uimIlRl2WdRuHSWzPpTcpymDKYkvG53JHl?=
 =?us-ascii?Q?EiiGlhHwohQFUCbtF1fdYU1n4pKhwbn3Q5915p/vmvF4exuNbqURDbMXExKN?=
 =?us-ascii?Q?Ux9/VMV+xePu73SCYUarbXXmvTCjQVR7oqDgtSn+Zr08CvnGrp26EamsFDg2?=
 =?us-ascii?Q?Zwbwnczw6eyWzB7ZDXOJes6gc9AEkjGjdK8sMFKk1w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8593.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9rdpkSmqcpPneiILfa05xeQV60hcGtVHpVKbaBQopNSsOejIt6bHoE6krp6Z?=
 =?us-ascii?Q?BR17Poc4pvSlQn2+I7OfVd7tz6KnaNeuXgqcUpb8wy1D69Bk4XNesZcNV+f5?=
 =?us-ascii?Q?sCq3CLbn/4x3khgYAZw5pnzUWZQnvPNtydAuKIR3oBthUyDqdYYsiLZRX61f?=
 =?us-ascii?Q?hFAn+eCL6uYSIVUKciz+a1qf2nRJbY0EweSvSioovsopOk5JZTwgVskMAlga?=
 =?us-ascii?Q?nKVu86+SkknXdmHGII6qwlPYFHJUi/cXE77HbkLPDW8YjRhhowXwbrqN4ewB?=
 =?us-ascii?Q?/nDp2KzrSMnzWM5JQssUZtvjFaL1QmXykLNV+Y7qRrhKCTeZPAb7EFctT6jZ?=
 =?us-ascii?Q?mjvLjOoVEdh8Jm3ZUW8wVh9sDCAxBfQhcAiMwUj1utyLGCPGYfNBApskk9GP?=
 =?us-ascii?Q?+4g03CtONZGGg4lwSJL4xASUIrpMq8DpNJQ+0jkxxeaLZv5r67lf3hnepIC+?=
 =?us-ascii?Q?pn71YzyZLN/DTzwYu8ietlXwfiwGvUhX2oOKdsQkYvAGw1/3jEiiWfGPPO3Y?=
 =?us-ascii?Q?jH8pAnSIjp7Ov4dRDfb9X0YJFJ91fS5htVDRsrXg7DCIGYYsg56btDrvq+me?=
 =?us-ascii?Q?UnmwQMSF2vd9yUfoZvn+yJ+XNpmdwS62DaLt7PSODq+NLdMO/r7SEsOWCHAu?=
 =?us-ascii?Q?c7pKvc8emoysReGXMBYzBIV+HVzi+7iF4nZikuDqnH18JseGn/ZBSXNQpssO?=
 =?us-ascii?Q?ZNYpr6iL4oWooD/3u5LOkkzvSrujzQMaS6EWFzDaDhC1zC2p/4P6QuJpossY?=
 =?us-ascii?Q?WpGH3LNrN1ChgAWD9Hp+gDvU87sz6BIwtgOu9GTdM4aq7mro0/a+GZ9P7Tyz?=
 =?us-ascii?Q?pdJ6l45DrCo2V0YpVuBPOqTl7jc7h14hblgYQlyW6QgCGKt6/dRu+7lblG3Y?=
 =?us-ascii?Q?Z6MeKwXNUsk43W82kXcW0cWzRyQ852a9ebSFEivGTuYSQFIQviX40DSHlt8H?=
 =?us-ascii?Q?FTn51dm1Z9+AiMXFf+PSUul9XyMqSJXvmRpeVwBVe6As68G7TjMRHami8459?=
 =?us-ascii?Q?QxLTKtqF0HPA6vBve8mdZM8uKqUTkl8sMU6hfd8eeJElvtmzZbsHBb3triIj?=
 =?us-ascii?Q?gI4UiQaOqoPg+m2FaHy/x44Ep7YPywSthyotVJui4pgVKTHM18ePlSIkTZVk?=
 =?us-ascii?Q?OoXeVuoDALndrBsRpKYgHM2ndKmwev6/h5Emo8mJYIcq4JEFY3QxWM5ZAhPJ?=
 =?us-ascii?Q?5LKDnFz4BeTLQ5eo98drK79Jdqze2FjHtrf2rPWa1vaq/XN3TqK1xXQsb+jx?=
 =?us-ascii?Q?xqKDQjrIibg+f9TcncyzQ969OaG3EIiqWVSUswI6u9TcgL1JhlW5PaeolOGz?=
 =?us-ascii?Q?YlP9aUsNQTb38WgEnpFJ5tFdtwSjt8g9cJ9lrbMELMoGWhCWgTSTnG1PmkBQ?=
 =?us-ascii?Q?N3ds67Kae3imTOXTVMP2X4/4/nDldvoHbyuPnAgw7lGOSf+s/OK6dMxVn91C?=
 =?us-ascii?Q?6MVinYo2BBgfoDSxLsokseDdr2up588su8NGj8AZ5DihP6U2BKFAWTKlohdI?=
 =?us-ascii?Q?F8zjDVcKRSo4x6ckuo0fKrfu0gBpz3MRY9tK9wpUSQcNVCE3Cl3zs4B8bmwv?=
 =?us-ascii?Q?BWjUzXpMjR5VAsaA88a7VIwr0rwavPeuNhSFJlc8?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_00A7_01DB0B83.5C39E140"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8593.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a511284-2018-4502-2c0d-08dcd96c670d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 12:04:38.7782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUtFBuQfnI3ifnxcUpzaSshNn0DzkXjoAoLXuEKNjizuRpxx8z2BS3nkf8o/ImceriNmcM+9aSHFY4zMynv8Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7509

------=_NextPart_000_00A7_01DB0B83.5C39E140
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit



-----Original Message-----
From: Sascha Hauer <s.hauer@pengutronix.de> 
Sent: Monday, September 9, 2024 5:52 PM
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
<conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix Kernel
Team <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org;
linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
Subject: [EXT] Re: [PATCH v7 5/5] firmware: imx: adds miscdev

Caution: This is an external email. Please take care when clicking links or
opening attachments. When in doubt, report the message using the 'Report
this email' button


On Wed, Sep 04, 2024 at 04:21:21PM +0530, Pankaj Gupta wrote:
> Adds the driver for communication interface to secure-enclave, for 
> exchanging messages with NXP secure enclave HW IP(s) like EdgeLock 
> Enclave from:
> - User-Space Applications via character driver.
>
> ABI documentation for the NXP secure-enclave driver.
>
> User-space library using this driver:
> - i.MX Secure Enclave library:
>   -- URL: 
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgith
> ub.com%2Fnxp-imx%2Fimx-secure-enclave.git&data=05%7C02%7Cpankaj.gupta%
> 40nxp.com%7Ca61c8211ef7548dfde0008dcd0ca0bec%7C686ea1d3bc2b4c6fa92cd99
> c5c301635%7C0%7C0%7C638614813421798949%7CUnknown%7CTWFpbGZsb3d8eyJWIjo
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%
> 7C&sdata=DQ2%2Fv%2BuCZRlBD4xHiKwGOnicwv84g6rXZ2j%2BjMolt%2FE%3D&reserv
> ed=0,
> - i.MX Secure Middle-Ware:
>   -- URL: 
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgith
> ub.com%2Fnxp-imx%2Fimx-smw.git&data=05%7C02%7Cpankaj.gupta%40nxp.com%7
> Ca61c8211ef7548dfde0008dcd0ca0bec%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C638614813421814882%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=TL
> 3gmQWdzNkseInz3DQ%2B4eOO1iMpgD8QYIldXIaKIgA%3D&reserved=0
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  Documentation/ABI/testing/se-cdev   |  43 ++
>  drivers/firmware/imx/ele_base_msg.c |   8 +-
>  drivers/firmware/imx/ele_common.c   |  36 +-
>  drivers/firmware/imx/ele_common.h   |   6 +-
>  drivers/firmware/imx/se_ctrl.c      | 790
++++++++++++++++++++++++++++++++++++
>  drivers/firmware/imx/se_ctrl.h      |  52 +++
>  include/uapi/linux/se_ioctl.h       |  94 +++++
>  7 files changed, 1010 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/firmware/imx/ele_base_msg.c 
> b/drivers/firmware/imx/ele_base_msg.c
> index e3e570a25e85..ae200ce64100 100644
> --- a/drivers/firmware/imx/ele_base_msg.c
> +++ b/drivers/firmware/imx/ele_base_msg.c
> @@ -68,7 +68,7 @@ int ele_get_info(struct device *dev, struct ele_dev_info
*s_info)
>       tx_msg->data[0] = upper_32_bits(get_info_addr);
>       tx_msg->data[1] = lower_32_bits(get_info_addr);
>       tx_msg->data[2] = sizeof(*s_info);
> -     ret = ele_msg_send_rcv(priv,
> +     ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>                              tx_msg,
>                              ELE_GET_INFO_REQ_MSG_SZ,
>                              rx_msg,
> @@ -150,7 +150,7 @@ int ele_ping(struct device *dev)
>               goto exit;
>       }
>
> -     ret = ele_msg_send_rcv(priv,
> +     ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>                              tx_msg,
>                              ELE_PING_REQ_SZ,
>                              rx_msg,
> @@ -206,7 +206,7 @@ int ele_service_swap(struct device *dev,
>       tx_msg->data[3] = lower_32_bits(addr);
>       tx_msg->data[4] = se_add_msg_crc((uint32_t *)&tx_msg[0],
>
ELE_SERVICE_SWAP_REQ_MSG_SZ);
> -     ret = ele_msg_send_rcv(priv,
> +     ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>                              tx_msg,
>                              ELE_SERVICE_SWAP_REQ_MSG_SZ,
>                              rx_msg,
> @@ -268,7 +268,7 @@ int ele_fw_authenticate(struct device *dev,
phys_addr_t addr)
>       tx_msg->data[0] = lower_32_bits(addr);
>       tx_msg->data[2] = addr;
>
> -     ret = ele_msg_send_rcv(priv,
> +     ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>                              tx_msg,
>                              ELE_FW_AUTH_REQ_SZ,
>                              rx_msg,
> diff --git a/drivers/firmware/imx/ele_common.c 
> b/drivers/firmware/imx/ele_common.c
> index a06d7015d3f1..9114c3594567 100644
> --- a/drivers/firmware/imx/ele_common.c
> +++ b/drivers/firmware/imx/ele_common.c
> @@ -18,16 +18,18 @@ u32 se_add_msg_crc(u32 *msg, u32 msg_len)
>       return crc;
>  }
>
> -int ele_msg_rcv(struct se_if_priv *priv,
> +int ele_msg_rcv(struct se_if_device_ctx *dev_ctx,
>               struct se_clbk_handle *se_clbk_hdl)  {
> +     struct se_if_priv *priv = dev_ctx->priv;
>       int err = 0;
>
>       err = wait_event_interruptible(se_clbk_hdl->wq,
>
atomic_read(&se_clbk_hdl->pending_hdr) != 0);
>       if (err < 0)
>               dev_err(priv->dev,
> -                     "Err[0x%x]:Interrupted by signal.\n",
> +                     "%s: Err[0x%x]:Interrupted by signal.\n",
> +                     se_clbk_hdl->dev_ctx->devname,
>                       err);
>       else
>               err = se_clbk_hdl->rx_msg_sz; @@ -37,10 +39,11 @@ int 
> ele_msg_rcv(struct se_if_priv *priv,
>       return err;
>  }
>
> -int ele_msg_send(struct se_if_priv *priv,
> +int ele_msg_send(struct se_if_device_ctx *dev_ctx,
>                void *tx_msg,
>                int tx_msg_sz)
>  {
> +     struct se_if_priv *priv = dev_ctx->priv;
>       struct se_msg_hdr *header;
>       int err;
>
> @@ -53,7 +56,8 @@ int ele_msg_send(struct se_if_priv *priv,
>       if (header->size << 2 != tx_msg_sz) {
>               err = -EINVAL;
>               dev_err(priv->dev,
> -                     "User buf hdr: 0x%x, sz mismatced with input-sz (%d
!= %d).",
> +                     "%s: User buf hdr: 0x%x, sz mismatced with input-sz
(%d != %d).",
> +                     dev_ctx->devname,
>                       *(u32 *)header,
>                       header->size << 2, tx_msg_sz);
>               goto exit;
> @@ -62,7 +66,9 @@ int ele_msg_send(struct se_if_priv *priv,
>
>       err = mbox_send_message(priv->tx_chan, tx_msg);
>       if (err < 0) {
> -             dev_err(priv->dev, "Error: mbox_send_message failure.\n");
> +             dev_err(priv->dev,
> +                     "%s: Error: mbox_send_message failure.",
> +                     dev_ctx->devname);
>               return err;
>       }
>       err = tx_msg_sz;
> @@ -72,24 +78,26 @@ int ele_msg_send(struct se_if_priv *priv,  }
>
>  /* API used for send/receive blocking call. */ -int 
> ele_msg_send_rcv(struct se_if_priv *priv,
> +int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,

> You are heavily patching a file you introduced just in the last patch.
[PG] There is no new file introduced in the whole patch-set series.

> It seems you have messed up while rebasing. Please cleanup.
[PG] Instead of " struct se_if_priv *priv" in 4/5, I have used " struct
se_if_device_ctx *dev_ctx", to have
Device-name printed.

> +static int se_ioctl_cmd_snd_rcv_rsp_handler(struct se_if_device_ctx
*dev_ctx,
> +                                         u64 arg) {
> +     struct se_if_priv *priv = dev_ctx->priv;
> +     struct se_ioctl_cmd_snd_rcv_rsp_info cmd_snd_rcv_rsp_info;
> +     struct se_api_msg *tx_msg __free(kfree) = NULL;
> +     struct se_api_msg *rx_msg __free(kfree) = NULL;
> +     int err = 0;
> +
> +     if (down_interruptible(&dev_ctx->fops_lock))
> +             return -EBUSY;
> +
> +     if (dev_ctx->status != SE_IF_CTX_OPENED) {
> +             err = -EINVAL;
> +             goto exit;
> +     }

> You don't need this. Just trust Linux that it won't call your
ioctl/read/write ops when the device is not opened.
Ok will remove this in V8.

> +
> +     if (copy_from_user(&cmd_snd_rcv_rsp_info, (u8 *)arg,
> +                        sizeof(cmd_snd_rcv_rsp_info))) {
> +             dev_err(dev_ctx->priv->dev,

> You have priv as a variable already, please use it throughout this
function.
Ok. Will correct this at every places in V8.

> +static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
> +                            size_t size, loff_t *ppos) {
> +     struct se_if_device_ctx *dev_ctx = fp->private_data;
> +     struct se_if_priv *priv = dev_ctx->priv;
> +     int err;
> +
> +     dev_dbg(priv->dev,
> +             "%s: read to buf %p(%zu), ppos=%lld\n",
> +                     dev_ctx->miscdev.name,
> +                     buf, size, ((ppos) ? *ppos : 0));
> +
> +     if (down_interruptible(&dev_ctx->fops_lock))
> +             return -EBUSY;
> +
> +     if (dev_ctx->status != SE_IF_CTX_OPENED) {
> +             err = -EINVAL;
> +             goto exit;
> +     }
> +
> +     if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx) {
> +             err = -EINVAL;
> +             goto exit;
> +     }
> +
> +     err = ele_msg_rcv(dev_ctx, &priv->cmd_receiver_clbk_hdl);
> +     if (err < 0) {
> +             dev_err(dev_ctx->priv->dev,
> +                             "%s: Err[0x%x]:Interrupted by signal.\n",
> +                             dev_ctx->devname, err);
> +             dev_err(dev_ctx->priv->dev,
> +                             "Current active dev-ctx count = %d.\n",
> +                             dev_ctx->priv->active_devctx_count);

> active_devctx_count is never used except for printing this message.
> I don't think it provides meaningful information for userspace. Just dorp
it.
[PG] Like to maintain the count of active dev_context. This will be later
useful for debugging and in case of suspend/resume scenarios.


> +     dma_free_coherent(priv->dev, MAX_DATA_SIZE_PER_USER,
> +                       se_shared_mem_mgmt->non_secure_mem.ptr,
> +                       se_shared_mem_mgmt->non_secure_mem.dma_addr);
> +
> +     se_shared_mem_mgmt->non_secure_mem.ptr = NULL;
> +     se_shared_mem_mgmt->non_secure_mem.dma_addr = 0;
> +     se_shared_mem_mgmt->non_secure_mem.size = 0;
> +     se_shared_mem_mgmt->non_secure_mem.pos = 0; }
> +
> +/* Need to copy the output data to user-device context.
> + */
> +int se_dev_ctx_cpy_out_data(struct se_shared_mem_mgmt_info 
> +*se_shared_mem_mgmt)

> Only used in this file. Make it static.
Ok. Accepted will correct in V8.

> +{
> +     struct se_if_device_ctx *dev_ctx = container_of(se_shared_mem_mgmt,
> +                                                     typeof(*dev_ctx),
> +                                                     
> +se_shared_mem_mgmt);

> This function is only ever called like:

> se_dev_ctx_cpy_out_data(&dev_ctx->se_shared_mem_mgmt);

> Instead of this back and forth you could pass a struct se_if_device_ctx *
directly.

Accepted. Will correct in V8.

> +static int add_b_desc_to_pending_list(void *shared_ptr_with_pos,
> +                            struct se_ioctl_setup_iobuf *io,
> +                            struct se_shared_mem_mgmt_info 
> +*se_shared_mem_mgmt) {
> +     struct se_buf_desc *b_desc = NULL;
> +
> +     b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
> +     if (!b_desc)
> +             return -ENOMEM;
> +
> +     if (b_desc) {

> b_desc is not NULL here.
Will correct this in V8.

> +             b_desc->shared_buf_ptr = shared_ptr_with_pos;
> +             b_desc->usr_buf_ptr = io->user_buf;
> +             b_desc->size = io->length;
> +
> +             if (io->flags & SE_IO_BUF_FLAGS_IS_INPUT) {
> +                     /*
> +                      * buffer is input:
> +                      * add an entry in the "pending input buffers" list
so
> +                      * that copied data can be cleaned from shared
memory
> +                      * later.
> +                      */
> +                     list_add_tail(&b_desc->link,
&se_shared_mem_mgmt->pending_in);
> +             } else {
> +                     /*
> +                      * buffer is output:
> +                      * add an entry in the "pending out buffers" list so
data
> +                      * can be copied to user space when receiving
Secure-Enclave
> +                      * response.
> +                      */
> +                     list_add_tail(&b_desc->link,
&se_shared_mem_mgmt->pending_out);
> +             }
> +     }
> +
> +
> +     return 0;
> +}
> +
> +/* Open a character device. */
> +static int se_if_fops_open(struct inode *nd, struct file *fp) {
> +     struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
> +                                                     struct
se_if_device_ctx,
> +                                                     miscdev);
> +     struct se_if_priv *priv = dev_ctx->priv;
> +     int err = 0;
> +
> +     priv->dev_ctx_mono_count++;
> +     err = init_device_context(priv,
> +                               priv->dev_ctx_mono_count ?
> +                                     priv->dev_ctx_mono_count
> +                                     : priv->dev_ctx_mono_count++,

> priv->dev_ctx_mono_count won't be 0 here as you just increased it.
[PG] In case it got wrap around to zero, then to avoid it open a device with
name appended with zero, hence incrementing it. 

> +                               &dev_ctx);
> +     if (err) {
> +             dev_err(priv->dev,
> +                     "Failed[0x%x] to create device contexts.\n",
> +                     err);
> +             goto exit;
> +     }
> +
> +     dev_ctx->status = SE_IF_CTX_OPENED;
> +
> +     fp->private_data = dev_ctx;
> +
> +exit:
> +     up(&dev_ctx->fops_lock);

> You never acquired this semaphore which is likely not what you want.
[PG] Agree. Will fix it in v8.

> +     return err;
> +}
> +
> +/* Close a character device. */
> +static int se_if_fops_close(struct inode *nd, struct file *fp) {
> +     struct se_if_device_ctx *dev_ctx = fp->private_data;
> +     struct se_if_priv *priv = dev_ctx->priv;
> +
> +     /* Avoid race if closed at the same time */
> +     if (down_trylock(&dev_ctx->fops_lock))
> +             return -EBUSY;
> +
> +     /* The device context has not been opened */
> +     if (dev_ctx->status != SE_IF_CTX_OPENED)
> +             goto exit;
> +
> +     /* check if this device was registered as command receiver. */
> +     if (priv->cmd_receiver_clbk_hdl.dev_ctx == dev_ctx) {

> This is racy. priv->cmd_receiver_clbk_hdl can be accessed by multiple
tasks without locking.

It is not accessed by multiple task. It is slave to the FW.
The "cmd_receiver_clbk_hdl.dev_ctx" can be only one per 'priv'.
This is accessed by Callback function only, to receive any command from FW. 
Not more than one such device, allowed to be opened.

> +             priv->cmd_receiver_clbk_hdl.dev_ctx = NULL;
> +             kfree(priv->cmd_receiver_clbk_hdl.rx_msg);
> +             priv->cmd_receiver_clbk_hdl.rx_msg = NULL;
> +             atomic_set(&priv->cmd_receiver_clbk_hdl.pending_hdr, 0);
> +     }
> +
> +     /* check if this device was registered as waiting response. */
> +     if (priv->waiting_rsp_clbk_hdl.dev_ctx == dev_ctx) {

> +             priv->waiting_rsp_clbk_hdl.dev_ctx = NULL;
> +             mutex_unlock(&priv->se_if_cmd_lock);

> This mutex will never be locked here. 

Accepted will correct in V8.

> +     }
> +
> +     se_dev_ctx_shared_mem_cleanup(&dev_ctx->se_shared_mem_mgmt);
> +     cleanup_se_shared_mem(&dev_ctx->se_shared_mem_mgmt);
> +     dev_ctx->status = SE_IF_CTX_FREE;
> +
> +     priv->active_devctx_count--;
> +     list_del(&dev_ctx->link);
> +exit:
> +     up(&dev_ctx->fops_lock);
> +     kfree(dev_ctx->devname);
> +     kfree(dev_ctx);
> +
> +     return 0;
> +}
> +
>  static void se_if_probe_cleanup(struct platform_device *pdev)  {
> +     struct se_if_device_ctx *dev_ctx, *t_dev_ctx;
>       struct device *dev = &pdev->dev;
>       struct se_if_priv *priv;
>
> @@ -247,6 +939,14 @@ static void se_if_probe_cleanup(struct
platform_device *pdev)
>               priv->imem.buf = NULL;
>       }
>
> +     list_for_each_entry_safe(dev_ctx, t_dev_ctx, &priv->dev_ctx_list,
link) {
> +             list_del(&dev_ctx->link);
> +             priv->active_devctx_count--;
> +     }

> The only place where this list is ever iterated over is here.
active_devctx_count is never used except for printing a message (see other
comment).
> Just drop this list.

Like to keep the active_devctx_count, for debugging the stale dev_ctx in the
system.
Will replace the dev_err with dev_dbg.

> +
> +     devm_remove_action(dev, if_misc_deregister,
&priv->priv_dev_ctx->miscdev);
> +     misc_deregister(&priv->priv_dev_ctx->miscdev);
> +
>       /* No need to check, if reserved memory is allocated
>        * before calling for its release. Or clearing the
>        * un-set bit.
> @@ -254,6 +954,87 @@ static void se_if_probe_cleanup(struct
platform_device *pdev)
>       of_reserved_mem_device_release(dev);
>  }
>
> +int init_device_context(struct se_if_priv *priv, int ch_id,
> +                     struct se_if_device_ctx **new_dev_ctx) {

> static.
Will remove it in V8.

> +     const struct se_if_node_info *info = priv->info;
> +     struct se_if_device_ctx *dev_ctx;
> +     int ret = 0;
> +
> +     if (ch_id)
> +             dev_ctx = kzalloc(sizeof(*dev_ctx), GFP_KERNEL);
> +     else
> +             dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), 
> + GFP_KERNEL);
> +
> +     if (!dev_ctx) {
> +             ret = -ENOMEM;
> +             return ret;
> +     }
> +
> +     dev_ctx->status = SE_IF_CTX_FREE;
> +     dev_ctx->priv = priv;
> +
> +     if (ch_id)
> +             dev_ctx->devname = kasprintf(GFP_KERNEL, "%s_ch%d",
> +                                          info->se_name, ch_id);
> +     else
> +             dev_ctx->devname = devm_kasprintf(priv->dev,
> +                                               GFP_KERNEL, "%s_ch%d",
> +                                               info->se_name, ch_id);
> +     if (!dev_ctx->devname) {
> +             ret = -ENOMEM;
> +             if (ch_id)
> +                     kfree(dev_ctx);
> +
> +             return ret;
> +     }
> +
> +     sema_init(&dev_ctx->fops_lock, 1);


> This semaphore only counts up to one in your code which basically makes it
a mutex. Just use a mutex instead.
Accepted. Will change in V8.


> +/* Private struct for each char device instance. */ struct 
> +se_if_device_ctx {
> +     struct se_if_priv *priv;
> +     struct miscdevice miscdev;
> +     const char *devname;
> +
> +     enum se_if_dev_ctx_status_t status;
> +     struct semaphore fops_lock;
> +
> +     struct se_shared_mem_mgmt_info se_shared_mem_mgmt;
> +     struct notifier_block se_notify;

> se_notify is never used.

This will be used in next platform/feature addition.
For now, it is not needed.
Accepted, will remove this in V8.

Sascha

--
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       |
https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.pengutr
onix.de%2F&data=05%7C02%7Cpankaj.gupta%40nxp.com%7Ca61c8211ef7548dfde0008dcd
0ca0bec%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638614813421828163%7CUn
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
VCI6Mn0%3D%7C0%7C%7C%7C&sdata=9%2BsmzPhaxGzr3vn1pD5V81XEqxY%2BEz%2FfFFZugiHY
%2B08%3D&reserved=0  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

------=_NextPart_000_00A7_01DB0B83.5C39E140
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
Mi5jcmwwHwYDVR0jBBgwFoAUeeFJAeB7zjQ5KUMZMmVhPAbYVaswDgYDVR0PAQH/BAQDAgEGMA0G
CSqGSIb3DQEBCwUAA4ICAQAQbWh8H9B8/vU3UgKxwXu2C9dJdtoukO5zA8B39gAsiX/FcVB9j8fr
Y7OuqbvF/qs5SNGdISMIuXDrF5FSGvY5Z+EZcYin4z0ppwDr0IzVXzw5NvopgEh6sDXgPhCCh95G
Mpt9uHDuav1Jo5dfN9CWB78D+3doDK2FcHWxT6zfBOXQ69c7pioBz5r5FP0ej4HzWWzYUxWJfMcQ
uxwIRfISM1GLcX3LliiB3R3eDUJyvgsPhm7d+D1QIgElyLpUJJ+3SZpXK6ZVkQlLcpEG01Jl5RK7
e0g7F2GGn8dkTm2W3E9qRnHLnwj3ghnewYTOk8SWARN7Epe0fPfeXyS0/gHEix7iYs4ac2y8L0AG
2gbegEAKATWSxTgN/At+5MLPqnQuilUZKlcjgtDMzhnSJK2ArmuEXTEJUa/0fwKsnIQuhF4QONqS
nm8+QSb+/uRm/IWcW5LuCUuxwufQDzto7Xlc1q1dpOggtUJI+IojSlzTfeHkgYNr2XFZ4BrkY0i8
VFVmnqichsJOM2+zqQU4ZGszdFz/RLD4mLMCvmsMzRI7jIg7fkQer3CvIZkBwS1xjl4+ZGrkzyZm
zHyP274V7PSyYztkXvYr/CkTgjIu+JG6vGEN8LuVXt7AmwD7WNF8MKAkPOFIKWHXviyotKGRb0Jl
x2XwYgoaXD5Noa1jwB8kKTCCBaIwggOKoAMCAQICCHIFyg1TnwEcMA0GCSqGSIb3DQEBCwUAMGUx
IjAgBgNVBAMMGU5YUCBJbnRlcm5hbCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQK
DAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MTQwNzQ1
MzFaFw0yODA0MTIwNzQ1MzFaMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA0MQswCQYD
VQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwN
Tm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDET
MBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDVSMlM/AT8vRa4mBRQJwL0iYE6It2ipQbMoH8DzO7RQLmGmi82PhZs2XhTRcEWtede
DstWIRWwWC4vQiZvwshmknxltM+OwkFHVcUrpG5slDwe2RllSij7099aHWJmOai6GjOz7C/aywDy
zrftFuzd3+7JsGlBi4ge5d7AT9NtlhBOySz4omF4e1R+iNY8mqq/mfPcBFbAe6sGWQ96+0+UAAVx
BpCZ8NmtwUjeSGvWVSfPDga4IW+VoJdQWFsY0YoDVdglKSmA4n9J0hfq+gErN4nq8/1/Q8AamPaN
qVRwtN1g/mI/1JyHa+J2nmqLiixjtndxIPnwrKdS+sM34VuXAgMBAAGjggECMIH/MFIGCCsGAQUF
BwEBBEYwRDBCBggrBgEFBQcwAoY2aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRl
cm5hbFBvbGljeUNBRzIuY2VyMB0GA1UdDgQWBBTlMnr0ZsFHliR//CeAOVjfKxfiuzASBgNVHRMB
Af8ECDAGAQH/AgEAMEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3Js
L05YUEludGVybmFsUG9saWN5Q0FHMi5jcmwwHwYDVR0jBBgwFoAUeeFJAeB7zjQ5KUMZMmVhPAbY
VaswDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQB9ysTcSisP+PmOFcN//fmoimql
EXMtFHPygpRjW4aa0s9GnKk31mO6aKr48BKD4yYRPIy2dWwRI2P2JqNxBPRLVF8vPi/h7sFt9Or7
4marYCgw8GtEDKZ5DWFJpPLCI99UsYY71u/lpQvY1H1TqvAwkjvTGriWmuCzl+M3SueIl1Eu74AZ
Y9tN+codSViZhFjV8s/nWeNhD40npdTEl+cOKHHfkALQlhR+JG33z1vX1blyGIfeXpGldgKX7unN
r05B0DhU1gT9Rb0PvVJjr9zQlVUHA3cklQ8a4xRTB1hpIp2ZkmgFr1IWDS8H21o89gO0AA6LmR0w
C7/aVOg0Ybn3TjzmpggTbDIAiF0jBhO0MffStheqFsZZJ0xd09tUlert+HPemkuNtDRMSd92mr/B
p9iv4obXXR4nwCDE7n0YCeYBeSBOEDwpE7TganD0S6Csg+5bpgmDriIT1eXt40qBgG2fBpYKAzI9
/S5+pnqP25nGVuuFb5ZyHLXhQtXGHk44eyh6kzI750GF2ldN30wu363hDdq53T+KoP2dLvTosA3z
ipknv55JRUU77pn5Y/AEAWedYttK0k6DqE63akxW1AOu+OKMywLXTVz+EWod6ZLrCKrfp93MKbcd
fC2USt3UV04kTeTnXwSWX4e0h0hC57UpBZX6y9rBk8tN5aRQrzCCBawwggOUoAMCAQICCE5+Bsxl
kQBIMA0GCSqGSIb3DQEBCwUAMFoxFzAVBgNVBAMMDk5YUCBST09UIENBIEcyMQswCQYDVQQLDAJJ
VDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjELMAkGA1UEBhMCTkwwHhcN
MTYwMTI5MTI0MDIzWhcNMzYwMTI0MTI0MDIzWjBaMRcwFQYDVQQDDA5OWFAgUk9PVCBDQSBHMjEL
MAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xCzAJBgNV
BAYTAk5MMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAo+z+9o6n82Bqvyeo8HsZ5Tn2
RsUcMMWLvU5b1vKTNXUAI4V0YsUQRITB+QD22YPq2Km6i0DIyPdR1NbnisNpDQmVE27srtduRpB8
lvZgOODX/3hhjeTWRZ22PAII57gIvKqZCMUWvYRdYZsSKP+4Q+lEks89ys953tp3PI8EeUztT3qU
Tfs7TbgD5A9s+1zCPqI7b/XmXTrkWBmwmmqDHBijwIvzy5uE3MTBunVZFAl2kD/jiBgdj+4O4u59
3Ny1c9c4If6Xvz3+DEIjdvbULrUyGIatwJdvw6FxRt5znmYKe3VyzsY7Zk/8MsOZvzoSPBMSZBWS
Hj/e8fBwDEDKf6XQ0BD7Z27AWTUcddk1sphn38HHOwEpjKfOxNGX7fSXqz2JaRtlamvSoCrd4zrH
5f94hcSVFcP9nF9m3JqRzAmbGYTdzgAjKjPRVWAgaZGF8b/laK5Ai8gCEi767DuzMsXkvj9/BQw8
fyn5xOY55zRmFo2jU8/blWy/jsAwUeEBDo4KPRAuPbSiOt8Jf8NbDOvDGPKwEC8de76SxPi3ulhu
Fb0Qzxsbk39+ET3Ixy347MAZTji/a87GeIDWi+nCWHwZPQSEg0e0LVh7uRNNb1clWILEF/bSMe3z
T3rWKWDmzCiTn3+PicqvYM7cWiZi3srlCkIAeaiav9tMaAZ3XG8CAwEAAaN2MHQwHQYDVR0OBBYE
FJBIUyMqeeqEmz0+uQ7omXRAXqC2MA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAA
MB8GA1UdIwQYMBaAFJBIUyMqeeqEmz0+uQ7omXRAXqC2MA4GA1UdDwEB/wQEAwIBBjANBgkqhkiG
9w0BAQsFAAOCAgEAhIKiXslbxr5W1LZDMqxPd9IepFkQ0DJP8/CNm5OqyBgfJeKJKZMiPBNxx/UF
9m6IAqJtNy98t1GPHmp/ikJ2jmqVqT0INUt79KLP7HVr3/t2SpIJbWzpx8ZQPG+QJV4i1kSwNfk3
gUDKC3hR7+rOD+iSO5163Myz/CzzjN1+syWRVenpbizPof8iE9ckZnD9V05/IL88alSHINotbq+o
0tbNhoCHdEu7u/e7MdVIT1eHt8fub5M10Rhzg5p/rEuzr1AqiEOAGYcVvJDnrI8mY3Mc18RLScBi
VHp/Gqkf3SFiWvi//okLIQGMus1G0CVNqrwrK/6JPB9071FzZjo5S1jiV5/UNhzLykSngcaE3+0/
zKiAP2vkimfHHQ72SJk4QI0KOvRB1GGeF6UrXROwk6NPYEFixwTdVzHJ2hOmqJx5SRXEyttNN12B
T8wQOlYpUmXpaad/Ej2vnVsS5nHcYbRn2Avm/DgmsAJ/0IpNaMHiAzXZm2CpC0c8SGi4mWYVA7Pa
x+PnGXBbZ9wtKxvRrkVpiNGpuXDCWZvXEkx118x+A1SqINon8DS5tbrkfP2TLep7wzZgE6aFN2Qx
yXdHs4k7gQlTqG04Lf7oo2sHSbO5kAbU44KYw5fBtLpG7pxlyV5fr+okL70a5SWYTPPsochDqyaH
eAWghx/a4++FRjQwggX8MIID5KADAgECAgg4IAFWH4OCCTANBgkqhkiG9w0BAQsFADBaMRcwFQYD
VQQDDA5OWFAgUk9PVCBDQSBHMjELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYD
VQQHDAlFaW5kaG92ZW4xCzAJBgNVBAYTAk5MMB4XDTIyMDkzMDA4MjUyOVoXDTMyMDkyOTA4MjUy
OVowZTEiMCAGA1UEAwwZTlhQIEludGVybmFsIFBvbGljeSBDQSBHMjELMAkGA1UECwwCSVQxETAP
BgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xCzAJBgNVBAYTAk5MMIICIjANBgkq
hkiG9w0BAQEFAAOCAg8AMIICCgKCAgEApcu/gliwg0dn1d35U0pZLMvwbNGN1WW/15pqzBcpG/ZB
q5q+ygq4/zkEqQAM3cZsSi2U2tjiKZOEfj4csyEJVZFQiwXMptsmErfk7BMoLtaIN79vFOd1bzdj
W0HaSTb9GkJ7CTcb7z/FKKiwc2j53VVNDR1xVBnUNEaB1AzQOkp6hgupCgnlkw9X+/2+i7UCipk2
JWLspg9srFaH0vwrgMFxEfs41y6iBVD70R/4+suoatXvgFv3ltGZ3x/hak3N1hHkjJq3oa1jSkLm
p6KoQAqbcHTkeKomMOmPUJK1YqDkpdbGuuRkYU3IvCW5OZgldrkigcOTaMNUaeZUAv8P3TTtqN4j
Ip/Hls/26VR+CqdoAtmzypBEyvOFDtzqPqVzFXfkUl2HZ0JGTYEXUEfnI0sUJCyLpcLO1DjnwEp8
A+ueolYIpLASupGzGMGZ5I5Ou1RoF2buesEgwb+WV7HRNAXTmezUh3rWLm4fAoUwv1lysICOfGGJ
Q2VkNe5OXzObvzjl30FYdDWb6F+xIDyG0Awxft4cXZcpFOGR3FH4ZZ5OH+UNl1IxnNwVpGSqmzEU
7xnoTXlyVH3Q/jYDG27HSoILQp/yRMJXWx/Xn57ZVXNm63YrZ35XsX91pMHDRoQdJBMKkya813dg
gmhEszSIBYKqoiFt1HaMK/KnPwSSLO8CAwEAAaOBujCBtzAdBgNVHQ4EFgQUeeFJAeB7zjQ5KUMZ
MmVhPAbYVaswEgYDVR0TAQH/BAgwBgEB/wIBATAUBgNVHSABAf8ECjAIMAYGBFUdIAAwOwYDVR0f
BDQwMjAwoC6gLIYqaHR0cDovL253dy5wa2kubnhwLmNvbS9jcmwvTlhQUm9vdENBRzIuY3JsMB8G
A1UdIwQYMBaAFJBIUyMqeeqEmz0+uQ7omXRAXqC2MA4GA1UdDwEB/wQEAwIBBjANBgkqhkiG9w0B
AQsFAAOCAgEAeXZR8kIdv3q3/VJXsdc8y+8blR9OWqmxjAo40VqPOWLcxLP2PkH3pleOPO/7Eg26
pQzIESYql5pxlw/tL7b4HhjcYpFom8yECNChnIxWeh8L/EfMPmcxi8wts4Zuu9q3bWOJxAcu4zWy
SDzbR/F/y6tzuaLgOZOmYihKTvG4dbRYBsC+0QMkf+6mfmDuB0O/HXE6bP9yf8rYZ1QWIfDp4h0e
MtRuPZ7DeJd15qEqv0AqeAWtuwAdXCQIBxYTYXHJxIwg7sxAMXdkFOXrGc8mCe6J+myQ0d449XIA
FVTpBtKPBjUfAnulbDFY8bEmkEEgyPYSmMALe+gDhOIlL3dJ2jeOd/edEfaIGlMfUPEnfD1s2sDX
PH8O3o9zWHWaU2bevYw+KUK86QiSa+wGussopb+n/cnBhgd9g1iNsO4V29YpaqaUQZVnKhL3EAhu
cecoNPiOJ2MMSboxLKmKtAGALdP2VC2gU7NxmatkzbU/FeZVApqWw/k6SPcO9ugisCOx93H77CHt
0kD6JWcMOn5/fQQmVvk34PESJrHCbYb11pdfzHsSPMwgih/CHik1cWP09mP8zS8qcucbUAloNHlk
kZl/V5eub/xroh4Dsbk2IybvrsQV32ABBfV6lfiitfvNOLdZ4NJ2nbPM8hBQpcj7bPE/kadY1yb1
jgaulfXkinwwggdyMIIGWqADAgECAhM/AAV1goSswyqoLYNbAAUABXWCMA0GCSqGSIb3DQEBCwUA
MIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA0MQswCQYDVQQLDAJJVDERMA8GA1UECgwI
TlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEG
CgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2Nv
bTELMAkGA1UEBhMCTkwwHhcNMjQwMjA2MTA1ODIzWhcNMjYwMjA1MTA1ODIzWjCBmjETMBEGCgmS
JomT8ixkARkWA2NvbTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA3diaTEM
MAoGA1UECxMDTlhQMQswCQYDVQQLEwJJTjEWMBQGA1UECxMNTWFuYWdlZCBVc2VyczETMBEGA1UE
CxMKRGV2ZWxvcGVyczERMA8GA1UEAxMIbnhhMTg3MTcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
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
KoZIhvcNAQkFMQ8XDTI0MDkyMDEyMDQzNVowIwYJKoZIhvcNAQkEMRYEFHP0DUDqqG/lDST5miUI
O2zuNepOMIGTBgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggq
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
AQCpaX5LxL7DEu5Kl6/3FrWocuyfz0a1IloCPiN4N2seS9BLcASfeezkLXqkoukKAkZui2ECRU3F
oWRpVs/VKMV0KystJTS6mLAxm5aV+RK8xa9KOZdKahR3I4erDD0U8Y5v7e66bHXhURS7d0JhEuHV
L1xasU7gFeEpjviZF5Vmk7cItvWAGlGw5nn+mxtRM4M5TALgLekXE7fW7KihWiVy+XbD0OL8/iie
F/U/KxjpnMLreQ2egEt3yTGMOjJL9UPfLWwuDxOBExIalGNaQqdTDZgGwnUieCNegzXIkARNas82
JDU7fOpgrtKgtXhNgO+bfNAIcQeOzW1W9rNQP9/HAAAAAAAA

------=_NextPart_000_00A7_01DB0B83.5C39E140--

