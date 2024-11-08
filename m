Return-Path: <linux-kernel+bounces-401522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546A99C1BB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F1C1F23D59
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F1C1E47AB;
	Fri,  8 Nov 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="NF8W7dfM"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251D71DE8A8;
	Fri,  8 Nov 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063511; cv=fail; b=n7Ez08PE1fZl/3mrfOLpgO27BQF2ebNhMViMFdaGKpNk5t9vIa129erqNGSH48qvxXwyB36QdaCWhX1mSyB3Z5OEPImuwzLL2Xrib7zBzR7Y5q5g+yIn/3ZVNKfEBnGEHszXdeEhquYo5Feqwy8S2Fcfh86Zz30wjpddyu2K4Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063511; c=relaxed/simple;
	bh=fWx5zKZ3WCbVsnPDsEB5e4kSNRGU+N7BeNkjhnXeJ8E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fi77w8+ZIXd3tH8NrncwruX9eUPXSygYXdrnDiflrOqZPA0fNdGr5JO3Ogt8E7WeAt+LxYRHBCmDGjF5aUPK73bRFk8NCc3T7mJwDEu22b2SW1d/bGKRrc1FuAmpocU/y9atC7L5zN++5cTFp2RJ1FRfcqXuEy0FaODTFigLEbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=NF8W7dfM; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8AGexG021628;
	Fri, 8 Nov 2024 10:32:07 GMT
Received: from ma0pr01cu009.outbound.protection.outlook.com (mail-southindiaazlp17010006.outbound.protection.outlook.com [40.93.131.6])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42s6f5r8jr-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 10:32:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZ+5/Z/f3NXR1/VyEohB01i1s/9a4onYT8ctUsPL8miVU19F4t82zvP2aCtNkitJirnOR4YD/rUt09MYOX+SorJg4UiCY+Ty5JQ7/fxs5onf+GD/9yaRblAsT84vNvz9XBP/eX82k7b6SFx9N0//DJDX2fuJ2cBokZLqFBL9fxCJYA9dm1ujjaeTWJ//JmF/l753qBgrMZhCilDZa0H5wJ1Z1d9Pqr/T58ppmmZ/2l4Y2EgWbGEBAOPmdK16SpFctlFFl3m2aQ9SgT+pC/KkX9QpD1504Ajy6+ndH2HlQvRJjwrEi4xE2mT+uMkoRAIwOntqflsjRiv5uDFAacFtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keC3+QD706Hmw6ia2QKtGQJdMmZHSMOirycWwbtGBbw=;
 b=dwszkU2LSn+OVLT0LnKBgOQ983DMYnN8m6+18zY+udILIFQZoneRl5pnjLbFxJ1q9BQn4UbuYwhhNM8qc16TAYRJTMlbgD5XUgvkjDgoJLI8bIvcMpHTXG5KcGbSffqzI/vNZiEtipWSyU35nHo/zfHHbqDBzh+pKCGZbcosLrzqIShBN6KfZNnmFmn4MC2vvXv/GrXHkXZfUmtNXnhlglPwfKnBHTCwJbZxi66eS474CRauBXIZVqIQ7/SAddf7B9meYgS/sjISyJndv/E7xNWpcp0XXeFTU8q6HUcitYkU6YrdIzRndKT5iPGYbIK1lLDtVo2atMMqVwmQCDJ6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keC3+QD706Hmw6ia2QKtGQJdMmZHSMOirycWwbtGBbw=;
 b=NF8W7dfMOGtnO0J2Bq4gF+TQuiSS09HtF1c1vOdI9hZeNGrGAfMHEY6UAAYOjIH9MgTWyPeHkaAyB6Ynf82J1f0S7M29c3luVNJ/3P0EFgsw+mkpVmlRslD/HeUwm9wzP/d7BzCnjlJdxIrBSgDmekr6V0rQwohTkb/iNCAfLSs=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB7813.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 10:31:59 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:31:59 +0000
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
Subject: [PATCH v4 6/6] MAINTAINER: Add entry for Blaize SoC
Thread-Topic: [PATCH v4 6/6] MAINTAINER: Add entry for Blaize SoC
Thread-Index: AQHbMclxND9+YNk/m0CAi4+5zBw6OQ==
Date: Fri, 8 Nov 2024 10:31:59 +0000
Message-ID: <20241108103120.9955-7-nikolaos.pasaloukos@blaize.com>
References: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN0PR01MB7813:EE_
x-ms-office365-filtering-correlation-id: eb965b58-4262-42cb-64ce-08dcffe093be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DRgUEMG3fIqI3DtOHOVOlF0aKheOi1J06cy0kULwuPgjFSWM/bbwrUwp0c?=
 =?iso-8859-1?Q?0NYe8aL8h9pmurdxq8wZUttL2pUL8OSP2hgbQ/McB9TkxVLm66x4fHhAhO?=
 =?iso-8859-1?Q?9VvuU5WhKMrF/pt4vRsC254XrY5bJgcGYIygzdi5DAY5m2sTjLYHWv3GOH?=
 =?iso-8859-1?Q?P14g69/Cw6O5vQQZuHi08iuMRXFf2Rjk78nbAhVT0VOxislAqb4Dqzuqm8?=
 =?iso-8859-1?Q?gXQCaBjWWr27TEUGZScTKTYg8j7s6Pbe/M/6zaJzQxybDFk6RgrOfF4lAE?=
 =?iso-8859-1?Q?uDrXk6drye4s7aPMX4K/ObbmbwGFt/EHIR5ZdcN18Sa7bYP7TkQGBW6goh?=
 =?iso-8859-1?Q?0AW958ZqjON2gawh1DjlYBQ0EA+oR2NN519jaq+urhsZw38QfROAjDzBr+?=
 =?iso-8859-1?Q?TNFdR++YaRo6JpoDr3l1nYsrRzWc+PHcU7rfbhOxCtkMPtMRcJN9SB6Rt2?=
 =?iso-8859-1?Q?e379N7OUnKo1Qh+R0hK/zt5lrM+7hzQ0H1KR3FKlOKUO7OCWn2II1CGDFi?=
 =?iso-8859-1?Q?s/ZG+ft9RVRyhhNoVjHurFhFTMZLHeksHgg8bGxLHGpQVzR1eW53gOJ13c?=
 =?iso-8859-1?Q?hJDZIJX+5sTnw6QxPAlCRXx8mI/UfvQPgJSX7Zv+hb0jKVELiGZ1fQf6pG?=
 =?iso-8859-1?Q?LQFuBgYiJWmyuunm6B5KWsFsQTLQpNazXzxpobs017lsM2cvbSbR6IOCeY?=
 =?iso-8859-1?Q?lFMfbCoVK846KBJYCnO86eSEZJcY2xRdC/CyI3u8hNQwds5zFb0m8IIZ0B?=
 =?iso-8859-1?Q?5FW9aAyIw07k0XzuZV+yfWKGImDY3I7k/F2z+4WVT5q8oE6vVauFjXqwCA?=
 =?iso-8859-1?Q?9uAsIP7z9aOv+2xPPnBDQyOWZsHtvUbq0xIRPI41VbM+lyZOll78svBQId?=
 =?iso-8859-1?Q?5jDGWlIkpxKptZfTMQupqkmuj/Wb4fjG+q/9NL91cX0Mp/tb3XsrNjD+un?=
 =?iso-8859-1?Q?r4pm9VDtDUIPFlV7QuLSRnSbn0MEMnIIqT1YdL0xEiKfhL9PSFPHUmEzca?=
 =?iso-8859-1?Q?RUY+C28B0lCkMQWQoM+3/o/zg4fiVJxE3nPAmr21XhX+QF8iuIQXdzRs+L?=
 =?iso-8859-1?Q?T/jEfX1vN+oM1vs1jW1G1s/WGtJ1HagsYt16wIvFwoH2ybFDaX5Kd5aJup?=
 =?iso-8859-1?Q?8hXpJYXU3iMcYkEXQWsxM/O/4nz0ELI4bvxvEOnIMNjqXGdAziLFEJA2fb?=
 =?iso-8859-1?Q?/inTf7wKnbjmIL+Bsvh18y81q2ziwKjAjaQyBti7z4pPyfKPOSKfFZ1n5w?=
 =?iso-8859-1?Q?zw0h+0WihRaB1rJRBhd3KYUKyTp3SgUwjNBV1TBWMK3nzEcEqgblG7LbZk?=
 =?iso-8859-1?Q?jXHCx6h20ukrT/+C6ydJGP6TAbqDnguuM0MTnx4RnMx9DSuqQYKvse6Ouj?=
 =?iso-8859-1?Q?RuBc0x9wgjG7I+EKxsO5Zc3Eu/FP+RiGDIJgcQtYLqADHhuWbsIWvSqrX3?=
 =?iso-8859-1?Q?iDmsO+qlbHAdanTe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cTSl+u4n9lfFSpttJUemQArjr9Hh0k/F1zlqqW41oy+pkznNafiYW4Uxh4?=
 =?iso-8859-1?Q?Yz/rXYZsL+F7IG7PeQQr80lt2QDzwzcB+ICjcvfdtKYLXoo3IAo9ui8/WD?=
 =?iso-8859-1?Q?wJBCBYFMFMTv9P9OP5Pthzdp95FbUupYB/3npUoROycQZmVdOjnf3FG73D?=
 =?iso-8859-1?Q?RzfISMnkrUj1s9psmzDmGfKp9Bf3p8T5JP+dmsNEvWqhReXFL2amNMrKX/?=
 =?iso-8859-1?Q?BlEwbP1JW4iLJyzFWBfQsiq59mh0hp3bHHJmxODl2oohRGUYQdvrP2QYoI?=
 =?iso-8859-1?Q?NR479seno2eADGkOo6MoighvmcZiPqG0kj/Bh9QasEoeqUSxkNkdQ2upwx?=
 =?iso-8859-1?Q?OHVNLae79Ea7916AJ3h0OGm47cY+qQEcm8eqJD8s92dzx9POzK0n7mtNsk?=
 =?iso-8859-1?Q?ZwMMKiznLCepeN/mHmAEKekKFY82wz/xcX++w8IVdnmPAjrBSSd/D6X1te?=
 =?iso-8859-1?Q?R1p2SACdQr9HxLrDt5nU39c2dyF4Dl1mEoy7EFMtR8MVVPVrfwZNbM3djr?=
 =?iso-8859-1?Q?VppupFJDrSEtGK633+P2Fc12TrIHAmPqdOVcf6Fr82eCVUUOyMK/rgAYz4?=
 =?iso-8859-1?Q?oOl9noNlyFLYywfkJdopwy4Z24SWQa9ZZb5OrlMnjsJ5+H4FBN8U7kGQFv?=
 =?iso-8859-1?Q?8LV9X2Lih+irgECxX/w+fdrKMT8LGyFJnq7SWFxJnItsKoj/Uke5toyH02?=
 =?iso-8859-1?Q?BfS006+YZal4g8Qddliw+aN7vtsFc/FkHcjAa8dPmZ9pfyGF64fSfWjakF?=
 =?iso-8859-1?Q?sBYThTgF+PBV2ctBLoL5cDFGl8k8wMP/dQRsSWxg5tIrAOS7E/a7bTWf3I?=
 =?iso-8859-1?Q?uuxeui7nwpk/njxgKII4MKjnlva8leCgiKpjvJkwW/gx5ME2iTqdz5wM2i?=
 =?iso-8859-1?Q?K/ze4uP38Y5iYvrD7lz0VLRb/TS67hxYAqDPTF9AlO7oNt69ja3FrHPxA3?=
 =?iso-8859-1?Q?GK59R7X0718xJ6gw+zMfIAumMLBW3Ktt46CWTGHJz4StNW7RK/yELAvhnS?=
 =?iso-8859-1?Q?LaRpTbVX2fBRvB647MYVpQI/LJePXsFtOBRUSTva0vM7qTxPL0v0ydkRnj?=
 =?iso-8859-1?Q?zdJnOUcWvfal3z82qzCp7t58ZNjqV764GcqP/pNUT0xl3Ny87zjp3k30r7?=
 =?iso-8859-1?Q?HL8dseJK0UlXP3Pf16Nw49C6twA+j2ttki3TuVTQInjW/alBXvDs+oE8q3?=
 =?iso-8859-1?Q?IyEFQ8l7VUefLHpxwx//Jfp0iNhYJGF3h0lf1K36Jj0r8+4L6gg3qNzmmX?=
 =?iso-8859-1?Q?CVk8b17l5aB5I4bkOVjt41xCejtB+fasTP8469QOJGHWx4JH2oj0TxnmXy?=
 =?iso-8859-1?Q?oGATjDxuSnL9l8t5iIfvX4Y7pFgd3Jj9/i9w9RLjTetRbLf5sUdb8+Cn5s?=
 =?iso-8859-1?Q?d8Ia1CB3zo5ATrfBwijPJ+IV6yoTMFRq1ruPivHDvZBf2P7d+PxYAJN0qo?=
 =?iso-8859-1?Q?dteSvQLFXbQrzGGYrMKRjD7Db/D13F744A7uqKnaz4P0plCofDf0aMQZHG?=
 =?iso-8859-1?Q?n0jMp0DvXMCYnx1dcPHr1EsWFz4ueGFCeRLGYh3soLL0FfYXDfCSdoRjIF?=
 =?iso-8859-1?Q?a72Ne1b6BFzdXyLJVFkRZ228/ZYKwcAEhP4ALzrFYS7zWwUE+TQQiMO3I4?=
 =?iso-8859-1?Q?L2Rnbne1tmsuZszFRxhbKZhEHLn23ZHx6npxxgVcWkTohAq4DDWnQn2w?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb965b58-4262-42cb-64ce-08dcffe093be
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 10:31:59.5746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWDlaLBMmWKtQ5I/iu2HMsAnRNAFzUpaR03YELNour5lmZ1q5ot9LvXijjTTWamo4vqDhEjXbHOvh1MiGOCZHXwyKaUUq285HKWpoMo4TEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7813
X-Proofpoint-GUID: ZQvS0hzx3jsDzP3i59gMrXUW5h678-sR
X-Authority-Analysis: v=2.4 cv=BqvPwpX5 c=1 sm=1 tr=0 ts=672de8a6 cx=c_pps a=TXs1g+7sIME2BPo3OSn30g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=yOddBj_2bG4RPtLnvvEA:9 a=wPNLvfGTeEIA:10 a=zapPnUM7SFj2ezx6rUw-:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: ZQvS0hzx3jsDzP3i59gMrXUW5h678-sR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

Add MAINTAINERS entry for Blaize SoC platform with a list of
maintainers.

Resolves: PESW-2604
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9db17a2fe3b0..11ede0281316 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2037,6 +2037,15 @@ F:	arch/arm64/boot/dts/bitmain/
 F:	drivers/clk/clk-bm1880.c
 F:	drivers/pinctrl/pinctrl-bm1880.c
=20
+ARM/BLAIZE ARCHITECTURE
+M:	James Cowgill <james.cowgill@blaize.com>
+M:	Matt Redfearn <matt.redfearn@blaize.com>
+M:	Neil Jones <neil.jones@blaize.com>
+M:	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/blaize.yaml
+F:	arch/arm64/boot/dts/blaize/
+
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Andre Przywara <andre.przywara@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
--=20
2.43.0


