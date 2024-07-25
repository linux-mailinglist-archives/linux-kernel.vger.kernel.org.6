Return-Path: <linux-kernel+bounces-261846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D97C93BCDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28D3280A74
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C30316EC18;
	Thu, 25 Jul 2024 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LuGrDd/b"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCA16EBEE;
	Thu, 25 Jul 2024 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891196; cv=fail; b=kXThR9zgTZN0SpUKYgkZS4WI9+PG8+yKcpHGhDii+XpwJlpzihrLIO954KOwT9lPnFv9f9LWfuZnSJphQjAHkb7mX8jGmNX7zkyw1EW6EIgj0NhTZnfIhuJ8ykpKUonYmoDYrzAVGK2/AP86a+kE6CcJOHAVjwHZsTtFTlHtXkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891196; c=relaxed/simple;
	bh=r5+UwUUDv+q7ZJumdvVYkmjzKu4RTlrP3VhY5CIb8jY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYr5S2xZ/E7RrmCJtZMjOtlfrezTXU04MDLYwfjne7U/xTUXCtDX54/IA+oaFpJJ1AEYtCKlQgjufzg08ifzuOli1sdJUWRwMCHykg0RcHgTeIIWZniR443zJCFQ8+eDhBXJybUX8K+3oYUNjfTe+mtOx2Y8u6oyV12K6uTL2Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LuGrDd/b; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYbtza7ijR38JjqCBj8RCRUuFx9mF4Y/BK35DRLunnHuSUlXScy/rMRKuB/tKq+Vdyp6zfyXxcDrG5JSNKQ9oBzVgSIKaCsFGeryk3wpViNnD1vVA89xiUhit6OtHd6mLJAuRmFHIi8nIVsSWW1f1K9bzEGBgsLxywDJayqVQWrmC/xAALd7c9w/ibkwFRF3yvbPoNI5kfBsg5LMN6HlzpeVx8f9Em/u1gaRYqz2kJFtLU1syVSee7oqONP7yDTfRJtQIxTQ7MYpXE2jOyygEp6XwSEExjKMNJdCY0xIe6Zq45akrtkD4YeeBGvOfbdKZOXffPILiJ4NKdPJQDMrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tb466xVbLiPjJh/U7d3sbg9azVmQUQIFx3qkTlVlTkI=;
 b=M3OaRNwmR2cNVeiJiJlFBccEFOlgIZ4XzWPdGwBu+PO40u5IS7L7kN6ZKt1zl+sudGm4bl9BL+RcflmCLetlyqJqI6//gGwqWwy5zSYjnkTbcwdcy91sm+7rvhFWPjQUrtAfY+uYlWGXIu2VyNZ4TncaYwNBjq5TQF2mDVzSDQVJA8i7cMnmA4Swq4YbyNSuSPy402MR4kl+di3AbVsNSzbF1FTfKQDbJXUIuHGsUBJUf2+Rb7enptFj8YQCz9x4JCyglabGX9281OuzgYlyqxalJFSBb+Y0b1CSXInyiVBPYZMd9E/k6xO7JGwQEoGL5jj4i4z4/gb0n8NrXjG8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tb466xVbLiPjJh/U7d3sbg9azVmQUQIFx3qkTlVlTkI=;
 b=LuGrDd/b1sQRV+K4uS5j8hX+vFypeuWZ5uH1k6TBlEHPrMeh0ugQc6fO7quv22aPwijqk9eyBa0MxxHVZV8dxjCSvc8M6W6EfRfboeKGK7TsYDc3A+LSEmXTnMg6zQ3cN1wYyXeSisMU5PEtNHr2Dg8CrUM80OvL+99reJiJwIB6QAPnC1JZYDgZ2TPbNsEOD1oJzWJrndxsCbh5IO5OUXOJLIn2uMP3fngHrvYUvT0h8lr9Vwv6V8LHIKIc+EvaDo6L5bD8LrR7mD4GuCcNsPkdQaPlYIji4Fz8wySf3Uk7I4CTZKZUZ/XQAwaCkZRiYhALCz6rwSazBB7xaPIAng==
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7)
 by DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 25 Jul
 2024 07:06:30 +0000
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72]) by DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72%3]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 07:06:30 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index:
 AQHa2/NU1sJztJxAoEWO7LSlO6AOebIC9paAgADLMzCAAJnWAIABTu8QgABaVYCAAPz18A==
Date: Thu, 25 Jul 2024 07:06:30 +0000
Message-ID:
 <DU2PR04MB85990A0AB8AF8ABFCDA4CBD995AB2@DU2PR04MB8599.eurprd04.prod.outlook.com>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-2-ee26a87b824a@nxp.com>
 <20240722-popper-comfort-7538ea70c77b@spud>
 <AM9PR04MB8604123E065315093347F66C95A92@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240723-smitten-shower-1d15c0f3cf97@spud>
 <AM9PR04MB86043E4B4B2FB206BF9223C695AA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240724-huddling-neatly-88813c0b1f1d@spud>
In-Reply-To: <20240724-huddling-neatly-88813c0b1f1d@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8599:EE_|DU2PR04MB8822:EE_
x-ms-office365-filtering-correlation-id: b2447940-5da8-4f1b-c5ac-08dcac784f31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EfT/k31c3ZfPhHQLgNLQMN5GmsXKuATcr5+EKJcD0PG2X1rZzZI1IA2xJu6H?=
 =?us-ascii?Q?jFvCznlHngayRxs/bxmP/VaxxDwOtYKiVDbWlg24+IRXnBuH8kcK4j20KIAJ?=
 =?us-ascii?Q?X4LLgbGiq8fSHWAndYwsUY4Mvaa3EvWSF5wlhyYhy7PkfyI0eGeL5AFeGHPS?=
 =?us-ascii?Q?xoQFKEDj8UK0DnFHH7NRoD9k1PHHJOruG0Q96b256PFIJhLTPqgirsbeNXyC?=
 =?us-ascii?Q?ZVuWecmEfxGf1+DOgBuXx2HzRLuMa9ErQhENtP7hCudTT5+UQOU1mNWwU0bK?=
 =?us-ascii?Q?M9BfU4ineQ98ks6tJ45tcG8zN+CTlBomvHd4qERo21u9pcqCyWXAwtQx1+g7?=
 =?us-ascii?Q?p0Fr065YqsZQGIpYN1jJKFD5s6tIeG7JxANT6If+VcEyR2l6T4ieu+q6bLuz?=
 =?us-ascii?Q?g6JVPaViPUcMLWd+rQ7WfnbecgDwE1YPc9ee7cJKK4Q9v+qXhPKboljcO8Rr?=
 =?us-ascii?Q?4xbkEpIdVVlMDDhHS56CrKrOt3f61hXNKlyh09EcFgDTA2RCkqvozAVXgGRu?=
 =?us-ascii?Q?JxGDc3Zu9rVIpuSLyBV/dBxTGsm5gLEcts7dMwmAP0Y5sYtUKx6Q0WsSJUzv?=
 =?us-ascii?Q?yErQJsYkOnB7QdkYqP/iZDdpvEP8tpT483xw2wa6cjDOpZC0UTMFGiiwJVeQ?=
 =?us-ascii?Q?YlY56DA2aB/XPY7fu8wxY1KfN+ZSI4jX2n71kDVTI2Xv/s+0V1b/P9eqUuQG?=
 =?us-ascii?Q?yOMKVtWXBP4qOXblAoCuUY4uQy0uLPSLQEkrJ7w9DhfQgPC1+Whd6OG1z4Vt?=
 =?us-ascii?Q?XX6qb+IFxoRdE/mNU/nG00RdYSUjhpdq+81/i0WAXUK6deAW5pWCo+AwUY3b?=
 =?us-ascii?Q?yrYr0PleMetuLs+Wx4pSfKOztKfHqMqLDZCt5QLKuwLCN3Cqh5GvU21AgJGu?=
 =?us-ascii?Q?eIUNRXaGtAd525Vr15B6GiCI++JuYMt+bC7ak68nwY1ay+GMx3sz6SA8jB/2?=
 =?us-ascii?Q?EB5D/Dlal6Vo+tP6y+Hn3SHATAbrOMhuVt+LsAB/uF+WEKGPAi1FkJB3U31y?=
 =?us-ascii?Q?5TVbU7gysfmHh5ZMTQD8fv9am9usRFH3eo3x8Qu9XQwaRaRTVY3+fb8UKHoo?=
 =?us-ascii?Q?16IhAx6aMETsVUTjFuDLjS0iCKmG2ETO8eEf9r6v+NfxCmK0BQMMI81fT9kf?=
 =?us-ascii?Q?N5PlDfQVPrV77PzaZgCtHlZdMnpFCQF6IWzSUK4RnMOYJlC9evBtk5o/InGU?=
 =?us-ascii?Q?NnAZ5hFGQogCS8Ojm+Gfse77ZlUk577WnwTz4L6R8Rq+2zzqLorG6pkLKsal?=
 =?us-ascii?Q?fjHAZbdank7uy0CW5GsuuP6/uhIiOAY5xSb8jTWsQLVRWmhqocWsCjf+YLEK?=
 =?us-ascii?Q?ndQ3YRe0th2YGDyv1WR1NpFuqs7SPEsrN4X2FkbeKntpt61LfVJ1yBuApOg6?=
 =?us-ascii?Q?7096/NJLAgDmG/QV/h76dd0A/0fgBp0aClxxnPbZ/+vZ0fymAw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8599.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bg/cffHBw4lViEKy+BLVyWvl3g6ES5PytNabS+UiiPU0PMijZjPUm91A9wCs?=
 =?us-ascii?Q?CdDtjm6qv2YwLxSV/g808IAlBwDsWujuVR8PxdtP/mZAyM+zDK6A/z5+zsab?=
 =?us-ascii?Q?ICy6tvCMyN12AvqMVQAnQVC7soqEpM0TqYIjHNtOIepJkYye0hcdZaPR4a/N?=
 =?us-ascii?Q?7Lpt2Qd8SWbk3vMb/VmE2b2rfw19Yj2D0FiKqI4X+wXf4XDwTB87x65iJpXf?=
 =?us-ascii?Q?3AhurE6sb9USxoIlI4g1oDool1g97AF1iDkG025pxPgn91xpZgTPCE2i/Ja4?=
 =?us-ascii?Q?Ca6vabdb9/FbF8H0eZY6EJQvZaAqOeqBRxeWJrU7Ndo28G0JXV4I5xXy5rx3?=
 =?us-ascii?Q?KCPq5oy9HaCkpNzT2TRlat43Vh/yMy1Rn6+Hw+dvd5EvKEuC2Gw76gOPRknS?=
 =?us-ascii?Q?BdqNsW+CKbdIleN6XVSe6NLThcPhwgChHXpwCHhp4j/bpQI4cCFaE3Cu1J8A?=
 =?us-ascii?Q?7BAYB2e64ty4hM6HPZfsY2NJHETk9/mkQw2tG7dXo7aJZE1dMdIJuSx9CIWM?=
 =?us-ascii?Q?pZnXjQgSG1OYYq8LFg+YsamAFUZiKdQni22uqbQdGpC1KX6kidi+vBqgu2FE?=
 =?us-ascii?Q?aqrgBYgDSllLXTOllXAC8m7BqEb4oRWzv0WSnvFEtrCtOdmZIDIgPzMzAH3N?=
 =?us-ascii?Q?r87kPMBmaWdiVFhT+jbh7nHvlz9ynicycvM6g7ztwcqxrQztTsJhqGiEjqa3?=
 =?us-ascii?Q?suRLF68GjCyAGOiFopyC8JRzjdXc3cspjWkal3uOVJgJK63T2bvg67vUW1R4?=
 =?us-ascii?Q?5dXuAbGXm/BnQdUtkU/sFMDiXLtJ6FmB2A64fs3mhbN5Kub2vlnk4OvqCXl7?=
 =?us-ascii?Q?wtqCaoGbmjC2kl8GpCJiB9u9chXuVqBYUWmIKqyXB7/GXMPZZIAq2rPy2WVT?=
 =?us-ascii?Q?oC79LrHnekR8crlcqrpgGwnsgXP4LIzKVDfot6KtOESB42KtUrWGWL4MCjo/?=
 =?us-ascii?Q?2Zywm7GMpN5nS5gMU4Tu3OFfc6xpFKXKaTCg2Hoh56R9Z2AyE+saLFsLlXLa?=
 =?us-ascii?Q?QrJAK5WPeJzZ10frgsBjFKHYnxaCeuurtkfnOJTc4xROB4jpA/Zv4kbUuzVg?=
 =?us-ascii?Q?yF3qd65TmGKWFUVs+4yGJz4rJJEd5NL2K/tSdARFdUjx8VRccL4H/nPOnLD1?=
 =?us-ascii?Q?H4ES9eTFYrgYmi7ulWmos7xlmfaolr03en6Pea+56IXYpV1nuFc4MwN+zhfx?=
 =?us-ascii?Q?9093SwnLaDpwtZeWpXygpHuaPWYZrqwCDXyd/4+Md/B1fA7pCGRPeaMUy5CJ?=
 =?us-ascii?Q?csaIN9BQJ6KO57WSyRc2ET78rgpKMgPFTc+C/YKZ3M77G4EI1xC1tZGWL7+c?=
 =?us-ascii?Q?uCX/284FY24rLS+YAilUYULmqCdAjj+ocuto3sMT14B9VD9KfSi++YQqkkwJ?=
 =?us-ascii?Q?4h0aR2myOrV7Ojb35DLR1YOJBlUP4PX7xxWg5JyJjcooTp+DpR5wz01EMKSP?=
 =?us-ascii?Q?MVlvSXYBwD4/rCsdSRsalynRN0wkWUJnsZAujaAZZVnAa/UlRh0kTHcPgO6H?=
 =?us-ascii?Q?LqL2zA/s73doibDJkvNs8aD5ObVKGsRNORNCm3Fdx1jHALUOfBswZhm8+dx8?=
 =?us-ascii?Q?xLh2rbThmz8z3GMbkjZKoO/jUkxXtzEazRdRemqK?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8599.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2447940-5da8-4f1b-c5ac-08dcac784f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 07:06:30.3867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbznO6fCN35HQhMjiyYpMWUJ+vDPEX2uII8rGuKcM7ORnCtJIJ+DdUebNx7lQ89LEIgAoho4tndOtsTA7COkuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8822



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Wednesday, July 24, 2024 9:00 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-f=
w
> binding doc
>=20
> On Wed, Jul 24, 2024 at 11:02:21AM +0000, Pankaj Gupta wrote:
> >
> >
> > > -----Original Message-----
> > > From: Conor Dooley <conor@kernel.org>
> > > Sent: Tuesday, July 23, 2024 7:38 PM
> > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> > > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha
> Hauer
> > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> > > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add
> > > imx-se-fw binding doc
>=20
> Please fix this ^
>=20
> > > On Tue, Jul 23, 2024 at 09:28:31AM +0000, Pankaj Gupta wrote:
> > > >
> > > > > -----Original Message-----
> > > > > From: Conor Dooley <conor@kernel.org>
> > > > > Sent: Monday, July 22, 2024 10:20 PM
> > > > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring
> > > > > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> > > > > Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> > > > > <shawnguo@kernel.org>; Sascha
> > > Hauer
> > > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> > > > > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > > > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > > > Subject: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add
> > > > > imx-se-fw binding doc
> > >
> > > Please fix this ^
> > >
> > > > >
> > > > > On Mon, Jul 22, 2024 at 10:21:37AM +0530, Pankaj Gupta wrote:
> > In case of imx8ulp, there is a single node.
> > Having a same node name for both parent and child, is bit strange.
> > firmware {
> > 	firmware {
> > 	};
> > };
> >
> > Request you to allow to re-evaluate this point.
>=20
> I dunno, it's all firmware so I don't really get why it is so strange!
> Can you remind me again why it is inside a parent node to begin with?

Three type of security firmware(s): HSM, V2X-SHE, V2X-HSM, are running at t=
he cores dedicated to the each different secure-enclave hardware IP(s).
Each firmware receives the message to act and response back with the comple=
ted act.
This message exchanges happens through the Message-Unit hardware interface.=
=20
There could be multiple MU for multiple security firmware, that would be us=
ed for respective message exchanges.

This node defines the details of each such MU interface.

Reason to put under firmware:
	Since this node specifies interface details between kernel and firmware, i=
t was put under parent "firmware {".
	I am not sure if this reason is correct enough to begin with.

Thanks for allowing to revisit.

I will make the change to whatever you finalize now. Thanks.


