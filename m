Return-Path: <linux-kernel+bounces-401527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C299C1BC3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A98B253CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F011E7C22;
	Fri,  8 Nov 2024 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="EFkkzCyw"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253231E284D;
	Fri,  8 Nov 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063513; cv=fail; b=gqHv8pjVsIEUHDWPYIZ+Brl4NeAAg5PU7b3/Kc9BmoF6z6FhHlVaHfNOTB0S0ZyBBqLIF6P1S7wq6rJaYqTsai3uu+gCicArnonotJBnB2l1waSG+2Mq08LpE2F00wellosVx0lORdsRikOVfOTtyNZaCbpt9dYOHR+sedsxS50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063513; c=relaxed/simple;
	bh=KqmrDiyKDXTb05FTIGqmO4TqObvA8RDw0Nh2NBbiM7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JgMFbN6B3t0GKdq8r+5Ks2HXQY7KbAJysvVD7LLbg5D9aiwmaZV262jbn5eBWLHROyJMRGP0GFKhIuKDjid7rNmGqLdhZgJG0ESvcktFGgB5jBJz1nh+2lWgU06mE6ckgu5KdpR+Ugvp0erJ5NwhjpYettdmhAu0BCw4QLorSao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=EFkkzCyw; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8AGexB021628;
	Fri, 8 Nov 2024 10:32:02 GMT
Received: from ma0pr01cu009.outbound.protection.outlook.com (mail-southindiaazlp17010006.outbound.protection.outlook.com [40.93.131.6])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42s6f5r8jr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 10:32:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhSe4jwTHOmUIuhDvZxfWsklMCknh4+p8DKhlVWdJO5kTTzdZoteRD/gRz0hf2RHZjpDr1FMytcJf7WzFMj/zfOvpmncJee2t4LhmjSiY/y5M0sb5XKvKgslQI4Nl7JW7YFHrHs1naUWxYS37pxTap8YzgQopGgZJdHOEsEMGbs3Kgi3S9VuaJ4S58TKRE2OM55ufNIEkY8WxUVXAbAwp3PLOzVHVvMsWLH7+2lLbwp+ktyXiln1wYvjz19th8N0mME4EdVac8eVbmMWx1FAhCHKXnnABZwk5lBcFPZtrYBoRbShPgPJ/6Wvqd0uLUUdOHPO/yzxyBy6QRhTAkz/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ypmRk+3znv3JMt2dsuwCqZ66PiZxKegatXFmU/weC4=;
 b=uDYMLlGbcciwzme9BGimZfLygaN6AQoJDii7cR7I3w4UzL9fAKDsl9HVgZWUwxJjOwmx8qJANuZzDges/VCBHLKNyG/P5uat8X/lX2Rgry+uaIO8Sm+IUyV4cQtIuJ1WV9QGsVzuSbiXdbzhnAokN5MBrOCLhg663/lMK4ZILjSuqNta6bhHmC6oZrgZ1TNGLuNnyPcgG0DqKaBvpMaIr+Uov3NXPaSSJWxhw6BchWSG673pUx2nxLKOcdiPuF4eR/2yyWCIgA/0C5juHkbp4KQIvSzVZoA54Nl+GwIu2L/vdmxoeEZ3PuDWE3YivBZ8/nCtG+AfVQmEeGp9EXRm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ypmRk+3znv3JMt2dsuwCqZ66PiZxKegatXFmU/weC4=;
 b=EFkkzCywkMxcO8ricL54XShVv3GXxskXIes05B0Z9VZ0kwmhZuogLl0L3Z091AFf5sUGPs09lRAhiaRkLHubNiji3+5YzQjHYjD07Q1fLm3j4D2VX+F1CtmoFewSB90EvrD0m8wcVycgSrf9EPjC3KMib6IcdgaAb4W8E8Fs1Lc=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB7813.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 10:31:55 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:31:55 +0000
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
Subject: [PATCH v4 1/6] dt-bindings: Add Blaize vendor prefix
Thread-Topic: [PATCH v4 1/6] dt-bindings: Add Blaize vendor prefix
Thread-Index: AQHbMclu5Jjr99qLEU6skLunq3bf8w==
Date: Fri, 8 Nov 2024 10:31:55 +0000
Message-ID: <20241108103120.9955-2-nikolaos.pasaloukos@blaize.com>
References: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN0PR01MB7813:EE_
x-ms-office365-filtering-correlation-id: 81db6cb8-453a-41a6-a437-08dcffe0912e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?wCXRoJYZ/i/r/8ChXCJPKYPdIiURgQWFNO+6BSNqCaUNK7CfRmMROtXX62?=
 =?iso-8859-1?Q?qwdzDkvN72AzUJEcZcIFfm7PgpxJ4StsBYYxyGWd6prjfMrrhP2O80HEPt?=
 =?iso-8859-1?Q?HtazOOpSJQ17qtEu2hWQMootRRVDPl1sCR5B2E9lPi4vThkxOcVLhJ28d0?=
 =?iso-8859-1?Q?oyyBoUkRo+lP5+PbNHcdbL3F7bXmrognYi9yK3EHPezaMy7/54354zQ360?=
 =?iso-8859-1?Q?3fhstwYj8fkrBHMmvZgdUmtX9dbAJRYufd1I6MAmTccetVrkgGIFe1nbjl?=
 =?iso-8859-1?Q?YqhD/B9ghWaqr7Tzfwa63F3tBoQcYJkdL2lJMohblt9AdSuWShRAW4Cnor?=
 =?iso-8859-1?Q?tNeiC7UVg+Q2b2VcH+qMpDMXIYTIJubhqIVa1mEa1+YBaqmNIO952MQ7MV?=
 =?iso-8859-1?Q?wM/wAqpUsV9hXup6sI9zbpJthTCslpwa1ZuQCAMVy1akglx1FrCwYNzDcF?=
 =?iso-8859-1?Q?oX0Sk4mjzhw5+Vj0BBMgU8j7Py05C8HRTcRlQtk/cmxSyapaRL0AD1lLaD?=
 =?iso-8859-1?Q?e+lzqbYCkEzCxNHIJwbpXQQs4vRzmO5G+pxaFnPEQvLM7dqsap3LNU3AbG?=
 =?iso-8859-1?Q?UmtKTsPnCuEYb7j1nRmx1twsyBTnFccNKQQWnXKxA8lJlTMsOspe0qf46w?=
 =?iso-8859-1?Q?6xlav1qSgPZLi44uWbP5X9tCzzSPY3YIj7sg24zJuu0ItLdrVoTD9Z5qNZ?=
 =?iso-8859-1?Q?RSSt6olTBCRkDNXRhN7jPJH8Bn2t7DvYhqM0GWA1NDyHYMgKCgz9wRiBPi?=
 =?iso-8859-1?Q?TssT88L9QbMZLHX6vqeYGAn9UnCs4rwrUjoJP9RCk7Zv6Qg8NEvqo4SpR2?=
 =?iso-8859-1?Q?dD6sdAu5KLvgKzhhDFJDmw+Oes90HkO3S/MZxxfWUoUz5U5u4K0N7XRQk/?=
 =?iso-8859-1?Q?+560ZKQtk9dJXSfpTnGn3GT8WUron2IPfNqy8VNT5WGPOzgI83NwG5Gi49?=
 =?iso-8859-1?Q?SrGTy2vMlGAXc5ug/FcsH1XoRoLD8xRKjncX5OF/WoJmTbFUhGR+TONr+C?=
 =?iso-8859-1?Q?1nsuXAYV/aa7vtJEaMCjvcfOAIj425IOTn3YRsgbY1F+3NRZQchaqes0Hx?=
 =?iso-8859-1?Q?YhRGetawOdzxHD6JCSBHa9REEDQCJhbWsTghVvsjEG8ZOFPQOhmEZJsjOh?=
 =?iso-8859-1?Q?kp70pYx1sWKU0u/Ee2Zs22Dywxdvnh8mqOo2fPqRO/q2FYAMXRDRwHn86e?=
 =?iso-8859-1?Q?0NsEHJcAQHbX+OeKrA6JCcIYj7v0YAxLc/067IEs1JSfoqW8DznuUx+j+9?=
 =?iso-8859-1?Q?Tin+tMvmt3nCUX/QLo5MKAeIO9S40em8i6cxzqvtn3ERxWFA+mwDECD1rs?=
 =?iso-8859-1?Q?nHNt01V5HtFMr8HdxaueGikNLJ2va8lkWwt0+GNOL8Lf0dY/3Xn1U95yDw?=
 =?iso-8859-1?Q?wgssZHr0lOM1Ds74AhlNquvVvoY4V08w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RpDfE1P1BGZCZHk66TUlqQR90J6On7SncaE1ir5gDhFzPt4usFF+kXhweS?=
 =?iso-8859-1?Q?fJkI84raz45rk5gR3K8+yf8pUt/j6Gm+k9uBX7Qa41goPz0NbfIs3ay4uJ?=
 =?iso-8859-1?Q?H8ySC7Xd8xNCLuWrgHemUfSbNdNSmG+vuWe51J6IKPJMJjhq2+pGsSuDxO?=
 =?iso-8859-1?Q?jssH+85TupKUsyLRrcaDxo0flIIODUQ4VUHn5pSK2DhJittT1dUwqzaDR4?=
 =?iso-8859-1?Q?C96oz99RvfqVwOKKBZ2y+bXazrToYmD9W0oeG69qayR9p6vNdpRv9yC9Le?=
 =?iso-8859-1?Q?s4avDMo65i7K2sM/rrsBITOG/lKIygBxezU4gQfAuxAN7V57s+GR+38nOK?=
 =?iso-8859-1?Q?zene+MT/7Rl5ir8zyeGdV9t+pONeH4RLp3Spw4JOewtAnSx6ap5eVy5gTA?=
 =?iso-8859-1?Q?yG7MsLV/M9is78yyxYxoVnpYAvl4SUnfvDiJiQ0OAI+KJ4m3WJHPgg+cor?=
 =?iso-8859-1?Q?ge+4SbF30HEjjHbZAB1zlH+j8uek8YBG2Lg3yuKWVpX7FdT4y+AsrZ+kBl?=
 =?iso-8859-1?Q?mjbbW0YUEN2qtLghQy64eegvK4mhWJO6KXJihZ4vmmyB7gGyoz4M6eoT+A?=
 =?iso-8859-1?Q?p6RqHVEw2fnfj+vn5fvcYKsW/0oL9SE/kcJ55QXxlj/HxvsLbQG6zE4r47?=
 =?iso-8859-1?Q?wCEgQRVOoK17zznsyCRWtfXCyGBRmf1mUTE6uXlXj37El/4xLEJpPF2UjJ?=
 =?iso-8859-1?Q?jTOjw2kH8SZBvWrq2uQr8WSI0SFA+1+yoHLp/eVcOMWlAMcrM8MIhXiP76?=
 =?iso-8859-1?Q?+2zrhKPkx7eljcSKeIDJRVd1WvBEgLgR6zNUcwneAiZSwQA2YUDI0hpyn1?=
 =?iso-8859-1?Q?ySW3U2dYQCS81Gx7LMfXv4ZXY8QIvYaKY9LOK+tsc+g9xGLSaPNd0ukOKH?=
 =?iso-8859-1?Q?lpbpRJ/JmBGUNDuGOWvB/HVXn02yenYEf8+bA5SOZsRhJArgVMQQ+3b8Df?=
 =?iso-8859-1?Q?2QxVm38/6wxRSwz0e5uaw3b+Toi8AkKe58uNkB3doh71wcRFgxowELLGJz?=
 =?iso-8859-1?Q?IT1dIPX1fi9T9FjpsKH4igGVJPyi1RA2Guc1AQx7gndzRpFwufufO1afgX?=
 =?iso-8859-1?Q?mFRX+rWv9CX/EWzURWHYSa7NC7oZV27oyPGXER6mnpcS0kpIb5Y02tAkGV?=
 =?iso-8859-1?Q?wmcuaisxLzhJkV7qdFeqaBbJRRxDO5HadjFLuyhjJNT8b7P2v3rAzABf/q?=
 =?iso-8859-1?Q?SZJ8zSx1mzcyUrL/gXter4sFPkVlmIR/bT1dSR9WBN6mDXfYn9pYWiy5pN?=
 =?iso-8859-1?Q?gT7jGVdh6I6adI+Cwfd3EphGEwcwT9qVYQ3Ivzh9rGGQ5Fhf3gQg7zGsWW?=
 =?iso-8859-1?Q?6RL2597puAP1Pc8O1G1ugNz5D1C+KRP0mqK4tQ/7P43hSC1JkC/lLmLMe/?=
 =?iso-8859-1?Q?zoTjQhTmhMZ4lB+vUWJc3f9p4Q1+wFvd15muMwtKWia6LRKr0IFQA7USs8?=
 =?iso-8859-1?Q?w94BQopSmivhH1WmBTGWbsWbvXzJvzsbrxf4ErdlABxDQK9X+jtglSB6VX?=
 =?iso-8859-1?Q?JXXPSdo5z1pOmUcj+cP5RMpW24vcMWhyV4iEVEc7uEFi+Ed7Gf2Uve5axy?=
 =?iso-8859-1?Q?J3IQIhvxvICCwNjgtUtSnXurx6aF5NQVZU4NA8LUhd0QnDBDe2UcPBpG/6?=
 =?iso-8859-1?Q?eUP6BmNLGmyRJo8Vix6uRMiJ8IoN/WuH8vWUmlznScJvrxzkdWlM3y3g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81db6cb8-453a-41a6-a437-08dcffe0912e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 10:31:55.2827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrVJ7hOMN7No8n/6JfuFZICVMcelSzw1II/5hLovGSxCxnt2jXs/R1zmZDsqnKNDq7N4Gw4nTpEokge/laFvQXFSvj2nq5ujH2TdoY0VlqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7813
X-Proofpoint-GUID: YqTW6AErl4wuq5qI1sXxgI7DTP6U5lF7
X-Authority-Analysis: v=2.4 cv=BqvPwpX5 c=1 sm=1 tr=0 ts=672de8a1 cx=c_pps a=TXs1g+7sIME2BPo3OSn30g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=VwQbUJbxAAAA:8 a=sLGeIa-cgJAdIGUq7OoA:9 a=wPNLvfGTeEIA:10 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-ORIG-GUID: YqTW6AErl4wuq5qI1sXxgI7DTP6U5lF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

Blaize, Inc. (www.blaize.com) is a SoC manufacturer with integrated
programmable Graph-Streaming-Processors for AI and ML.

Resolves: PESW-2604
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index b97d298b3eb6..746ff14028d1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -214,6 +214,8 @@ patternProperties:
     description: Shenzhen BigTree Tech Co., LTD
   "^bitmain,.*":
     description: Bitmain Technologies
+  "^blaize,.*":
+    description: Blaize, Inc.
   "^blutek,.*":
     description: BluTek Power
   "^boe,.*":
--=20
2.43.0


