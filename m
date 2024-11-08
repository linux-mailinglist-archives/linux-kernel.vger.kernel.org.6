Return-Path: <linux-kernel+bounces-401526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7289C1BC2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE104B2534A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA271E2833;
	Fri,  8 Nov 2024 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="TO24MGcu"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2517C1946DA;
	Fri,  8 Nov 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063512; cv=fail; b=pwX1zgCe8ankruHa8BTUNOviMHBgY1nSlQbmaY65Mj5OhkwShtCndhTrn8f/X1kw3qqrHOAW4qN8nsnD6eYBoSRE0BEzqxjmgpXS5xTCVZc9u1E5oVdiMpyTa1T+7tXkIb8KGTgYw9MENqjpOvtwlvJZkre60Eku4SMmlMzONjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063512; c=relaxed/simple;
	bh=VCpUBskj7UusPWBJ2Ms4uv8w3XUTCMK9FiO44uRA6rE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IlghDC6uRk5/u4j/EbVDEFO365BzwJFxHK+JdqCYljXzVmVtsUf8Skx/tYWWu4paPJqO4NsYoMkwsF0A+momNoV4ebsx2PMgWEpkpywD4EbOwNrFTSPA2NDA9ffp+E1KmF5/M5zsr+hoPDP+WFpOOsf6BpnFam7mLJAYUwG4ZcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=TO24MGcu; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8AGexC021628;
	Fri, 8 Nov 2024 10:32:03 GMT
Received: from ma0pr01cu009.outbound.protection.outlook.com (mail-southindiaazlp17010006.outbound.protection.outlook.com [40.93.131.6])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42s6f5r8jr-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 10:32:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7ueCwBvMkaaNQnKqqRk4G6PTjuoENZEB+kyQquEYkbQ2UsPHqoYNpTmxkvktRD1UQ/ZoNqHbfSQvdmlsoW2VJetIkkfvqZYm6E/XdOZvmhkp4wQ9NflpdxSPn0PyaKuA0jWO0p1ldokiemxZaAX8xdqhvYbGPUSi5mwoDn8IEXy9oqKl83G9ybsxGSN5os+KhVHovq2G2zh6uW9IvRbKO7It+hIV7kVon+uxTB7yOAjkVC1K+9wqTtFW03s6TYXG8txHB74GVUuf3kJJYYKGtCKJ5QboJBsStyX0MK+MDngzh7qPoDcBGjaVeMLeZz3AnYRCOlMvTn8la3OntrRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOSkFZQDl/4AVGLypJ6tDdWQ7xxoeU8baMYb7Dn5YuI=;
 b=weONW3OwXW91f2tPTctLFcwItQmRLUPoZBIjef4Kj9yQimexP7t9b+4axnki94Vxr1lpx/9fqzqPXN5FvtBTQWW1MmQ+IzhpxQfLYyg/pZER301QV9EiFsvsMKT//dqvKWWnuQJRFar+wYUCEHdkH67t9NXFr01XXxNlExxEEV4o5Op711GDSFGAqzTNG4I2naMZ5bzy4H/2ppxGg1iScz/Y5mZFt9ny0MZBb+YEuMAboBAv67sXdqxC36pdLRCKLJdE945sADTXkOBDAMFI5AOJbYybbq+8ZTfA+sNAOZPNYwX6arVF6pfmdJTzkyZn+a972C8zLzK4BFh0MdHwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOSkFZQDl/4AVGLypJ6tDdWQ7xxoeU8baMYb7Dn5YuI=;
 b=TO24MGcujJ7q5Q3DsrfwzhUt1ZGLxQW5Mi+wOda0Mx9yLE5p3KcUyI8VwGIsQXgsiskB81HZtb/OgSv0KZusEi2VUQwG0pQD4zi6kesXkiCI8Pp4rIEGtN7eHpxLz/+lQ/tcosgnxQS2Nnmgrd6vT8y1qR/WDOeZakyMDD2kDd4=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB7813.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 10:31:56 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:31:56 +0000
From: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn
	<matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        Niko
 Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "olof@lixom.net" <olof@lixom.net>,
        "hverkuil-cisco@xs4all.nl"
	<hverkuil-cisco@xs4all.nl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "rafal@milecki.pl"
	<rafal@milecki.pl>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "nm@ti.com" <nm@ti.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 2/6] dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
Thread-Topic: [PATCH v4 2/6] dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
Thread-Index: AQHbMclvy2IBapmjm0+h657pqRfwBA==
Date: Fri, 8 Nov 2024 10:31:56 +0000
Message-ID: <20241108103120.9955-3-nikolaos.pasaloukos@blaize.com>
References: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN0PR01MB7813:EE_
x-ms-office365-filtering-correlation-id: dcc44805-e1a7-463e-b02f-08dcffe091aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?M3b5AZ5FlTBV4NViVrkqrxEXfkoMkaFPwZkk/qPOXXvV7q2YF0f1RH3fwm?=
 =?iso-8859-1?Q?h6ZTHsKFRFgFr/Yr9TE+PzkugnFLW7gqxFOtIMKEBNVW81fcfp9xgaoc+5?=
 =?iso-8859-1?Q?Gc7OgKR+sHN/mtHR5xu4hjKbNQvPm67UMHiR3/zPh6TqAFEU4I+F0Apilx?=
 =?iso-8859-1?Q?qF29+gR2hSwE+lAJEDWMquScPRzwxGfoLNVmGyjtGv0OPVr2OJqgUy3592?=
 =?iso-8859-1?Q?vCfSzYUnrz7/xfTi5WgKscNR9af/STiteyJRj2CxM86w3YFIdjRzM4aNpx?=
 =?iso-8859-1?Q?WU85107z4z7gGUiO8x1r+TonKW+fQ6qx5R09vJWv7jKJ1+io/gbpRnmo7D?=
 =?iso-8859-1?Q?C08Bma4mIIT67rYEDvajkX3K15suvpvHKllNaZfPd3csg9eQbEGoXVRu+m?=
 =?iso-8859-1?Q?BJkVUVPDR1Y0uOkXI/d2v8SYiSt6vTd0GeOo0GC3oDOunKBtTxwgT6wZFJ?=
 =?iso-8859-1?Q?+brYODc8qnTB5IeBSfzKMs3wZE3q18+dLUS+wVN5qkYshW0v3uEbw9R/j4?=
 =?iso-8859-1?Q?m87ipXtY/vlYftzqIBmohZboPKd59WzkemRDvARPtnOmUybUNnJl32JesQ?=
 =?iso-8859-1?Q?auVlyc6hCpa248MeJ8myT4LWnh1ag4n7qPst9G/gK6NiulJsOmrRYH0FcI?=
 =?iso-8859-1?Q?cF3JGPRm9sXD0m4kleYSvtXhP+Qm5MZEKHa5BUAvjmigbfCB3XrfVORW53?=
 =?iso-8859-1?Q?YUX+rTp1obGnPDpJBRAV0szHFfg/6m23aX5gZ4760NyjcZMOey811a4iKH?=
 =?iso-8859-1?Q?Ffw55ujT4+uew2CYGWRTyeh6MYx65hjiJGvVYotu4g3PcJHJFeyQkqE4hx?=
 =?iso-8859-1?Q?NYnmhK0dGTQrptZs1R4ipoDLpcfav85eClg2IUl2+N5uZ5tshlXGiD34nf?=
 =?iso-8859-1?Q?PdV3hUhprTMj55CtkKaipl29IMzouAGjfMJRhnk8xUZ0HpRQoIcEC+hqni?=
 =?iso-8859-1?Q?if5c9/PipX6UnblIs/cB/y9Ql/l+7FpsL6SVDjwFS0DLiQ8dCt0fcXR4XC?=
 =?iso-8859-1?Q?RQuaSQQh/BZwWT99QCXkoyLVDk1q+mgereTFxPmbb2/qBVcRCx0KMcji4Z?=
 =?iso-8859-1?Q?s9OF7asnankLZMhjDztQTC8lOpWxHkTUnTxDltPtR+TgzDFZ/0xOlW352A?=
 =?iso-8859-1?Q?Ggr7vqksz18V5n3mXQX5ggEiBB8UKx9p3PNCWGPWZaYgZzjcmFQl37QNxQ?=
 =?iso-8859-1?Q?tKEzHLXN9uDDByJly+6BovBa3Rb/RWHsiRn52BYt2m337Osoh3GtNqHiub?=
 =?iso-8859-1?Q?2+MWcfcUSGtqBzE4Q3IULNbIc3q/2sOnz+J7Yv9NYksfVI5FLJReWIOeBU?=
 =?iso-8859-1?Q?A44zUk2yaBjUS1E8N8ZxHdO0sNHldtZ1u8AS+FD0YgY6VBxLbOne0DjTEH?=
 =?iso-8859-1?Q?MhEWf5srl2v6oYvmxsOg+dtSeQS4c3Vg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LIjU9qAbUNQy22sy9ttH53MfQLGtH1eR7NVPXP7fLCTY4qFPSmPE/KbaPs?=
 =?iso-8859-1?Q?lc6JKB3XP3F0f45wDKi3mq92M0xGoK4dm1k1OUBR2gyDZJ45bO3zyjdSBE?=
 =?iso-8859-1?Q?1SmwDEOtWc+v1BFIidEkGNC852rGuYzorQq8OzLJziZv972T+rCdPBX9OC?=
 =?iso-8859-1?Q?NuCZaPdv9MyWUNo/R7xEuCFobw7aFYD9n+uNX3HDu2TmcoKkXSpOK0fH0q?=
 =?iso-8859-1?Q?Vsip3YCbH3i5lXI7n9Bt4egxR+fdgAh3osvX1HPxq3v0CaXSRaHhXa3aQU?=
 =?iso-8859-1?Q?d4g+xlurV0CXqbkYsOFHRuCEDxi1absbch0BZNFnhc1+V47+MmjnHKZzn+?=
 =?iso-8859-1?Q?4lOe9XmQHdaiINkm4+snrSAE7zXYwCvjUOCmzOjIGltYgb8dQ67CZHStL3?=
 =?iso-8859-1?Q?gGesyQ9qP5DpB1+0DwDxdx3CjoVgpgNSt50shZaIiT2ZuAqcr/gq3Nnup8?=
 =?iso-8859-1?Q?7eJJfzsaqj3avR1OvT7wJCvvpLyE8MzuBJjw0WNWpCnpEXHlSjS4A991VR?=
 =?iso-8859-1?Q?HW3FIGg5rfKAFEpEORI2Dx3kzBu+Fnw542ddJVdGwtIedhdMlvEYYmr6Lz?=
 =?iso-8859-1?Q?/3hbu6fXd7w32M8cqMNWFt0/sPMzBcg1DpdD5NuW/cwI+XkW8WZHmNq1oh?=
 =?iso-8859-1?Q?Jv8Epv1M5ZmOgsEySer4Y96Il3ieVapGG7BY3rxHC9c9Kh3kRAjMWpuDk8?=
 =?iso-8859-1?Q?tCl91de42L/dq7Lb2Y4cvdvfp06FXfrNyqbm+WjloVo9sBbklGmpZtBV2Q?=
 =?iso-8859-1?Q?PFMncmFOQK1SIevF0iyHysC8N0V/E8dKPcASTzvteUgnTgxlGDm71hDnWa?=
 =?iso-8859-1?Q?CtqTphmce/zkWYm87ebF2V2sxRqF08p8vemJkBE0dsBfXg+mmItgNO75bq?=
 =?iso-8859-1?Q?MELiqpxmpHldkDtHGHhg73ty0yIk5kD5qMA1IHe/VRIyliX6gdXzfZWzQZ?=
 =?iso-8859-1?Q?8QQIqccIGR5OUKirFS8jYiUqrkTE1a2of7iFa3ysKsDckHBZ1nx6Yew2zF?=
 =?iso-8859-1?Q?YDgveJbhmGutDeM1oqxOX8mwOQhXtE2ICXjMHnLVCVgIqtUQeDSsqKxWY0?=
 =?iso-8859-1?Q?vvDx6MNmWcK4SQy2Jq+1NJ1gSEXKKrhbxGAAxWjg1I6HtqKR9IeKEsoHhq?=
 =?iso-8859-1?Q?sLLGcuJt+7XUXDet/6u1+c1uxtA7Om86MYR33BlsnUWTP+pBITPmYpQnzd?=
 =?iso-8859-1?Q?WTTltFuo3C7Pg7WHA5jmzgerm1ePo0ZLil+zZYntNkk5uG9HJ+44Sw9ffM?=
 =?iso-8859-1?Q?57qFNiJBzgoZLKEKzfnqYDJoTOc6LFgIQHqFotCvo5BCKQxMqM3XXD38z8?=
 =?iso-8859-1?Q?C8fcuVqW0QsiAaCjAHXh2afyVJPsIq7orIOZaF302StZmnZTIGACGqPpJB?=
 =?iso-8859-1?Q?7jpvrFag77mdpk/YPJKiG66QLuh8Lps2NkrxKO+wMjY+xS4+1NfodAioaC?=
 =?iso-8859-1?Q?WFNUs3EEQ4My3GaFlhVM39GvR1sbC/j6NPvANLbjCBexvm7u7lpnnqOfbd?=
 =?iso-8859-1?Q?9/uDK6e5QdMlpvWSyaSzKWeJlF4QAkdhmBfhl6qVoW/mqrIQvZafk0+lFi?=
 =?iso-8859-1?Q?D/xK15Xornnb53L5SReLbHKCulRUEpaF1KH8Ox0uEpxzocqbkg3CZ/cLsd?=
 =?iso-8859-1?Q?XTwt4I7KuEhGzYCAwdiYlw/6/sYz9lPycLTRIFIqweLBXbyfDEY8ixhw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc44805-e1a7-463e-b02f-08dcffe091aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 10:31:56.1004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YSiQtKF/TCeiC4PmWOBz/erGtLIMNfVkGOraGGt938gRc3IfC6ZA/Fe3J9mHh0b1CwG1LuFnxFGHRxaCQaS+tvHKm4eYnO95bDiI7QOSwSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7813
X-Proofpoint-GUID: OWRHhof3pzw6xxikh2rtGIonGN70Z585
X-Authority-Analysis: v=2.4 cv=BqvPwpX5 c=1 sm=1 tr=0 ts=672de8a2 cx=c_pps a=TXs1g+7sIME2BPo3OSn30g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=gEfo2CItAAAA:8 a=K7meqxQepcaBtQuIGAwA:9 a=wPNLvfGTeEIA:10 a=zapPnUM7SFj2ezx6rUw-:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: OWRHhof3pzw6xxikh2rtGIonGN70Z585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

Add device tree bindings for the Blaize BLZP1600 CB2
development board (carrier board), which uses the
BLZP1600 SoM.

Resolves: PESW-2604
Checkpatch: ignore
Reviewed-by: James Cowgill <james.cowgill@blaize.com>
Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
Reviewed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 .../devicetree/bindings/arm/blaize.yaml       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/blaize.yaml

diff --git a/Documentation/devicetree/bindings/arm/blaize.yaml b/Documentat=
ion/devicetree/bindings/arm/blaize.yaml
new file mode 100644
index 000000000000..e93e1b8ececc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/blaize.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/blaize.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Blaize Platforms
+
+maintainers:
+  - James Cowgill <james.cowgill@blaize.com>
+  - Matt Redfearn <matt.redfearn@blaize.com>
+  - Neil Jones <neil.jones@blaize.com>
+  - Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
+
+description: |
+  Blaize Platforms using SoCs designed by Blaize Inc.
+
+  The products currently based on the BLZP1600 SoC:
+
+  - BLZP1600-SoM: SoM module
+  - BLZP1600-CB2: Development board CB2 based on BLZP1600-SoM
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Blaize BLZP1600 based boards
+        items:
+          - enum:
+              - blaize,blzp1600-cb2
+          - const: blaize,blzp1600
+
+additionalProperties: true
+
+...
--=20
2.43.0


