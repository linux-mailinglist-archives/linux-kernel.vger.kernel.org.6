Return-Path: <linux-kernel+bounces-399120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE859BFB41
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3D6283A94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3128A79F6;
	Thu,  7 Nov 2024 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="B/x1SXzY"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892C5C13D;
	Thu,  7 Nov 2024 01:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942249; cv=fail; b=DS/QPQOfaA5bKVcB3ogMWCxQMP75xYG4s6XnSWTfG2yiyjQKxDzEnogSIVptAvwfAAzrc3rp8MqoQobqJIyexamW/PpVLoGZ+4RkKz70wmWaTEbNsFue7NG82SKQaZUpi1Btlu8yP9ljEJ8OW6xq+PIC+BsikHGUY604aSRzHik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942249; c=relaxed/simple;
	bh=98wr8gYirA8UBfcnS+9fjXGbYMS0gVK6dNK4C9+1jFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cuLFY7SWtGUAz23lLddcz3ZIy49vSgoNKCr5qts2qGXU/48aPu0eMPbHbfnWMgAQUAE2lHUoNiO8AoevoCcairAWMo4DyB7dnhgPY0iMtDCPEw0ClHslyJUE9fcRrEFC1rscxk39PHj2p5n0cCREzGRFlKGJgWnGGqTLklVMzwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=B/x1SXzY; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6L2VKt000475;
	Wed, 6 Nov 2024 20:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r2eHO
	n7ywqakckanuMnw6PAuUFRtaCOhGv1g2rWHTHo=; b=B/x1SXzYypyqEQ+wjzZr5
	/YRdAwqkIWqNvlHuW9vz03/z6e+NlwFg6+zhE/Z+Iu9CHqi6dpvIzOyKv8suOHlX
	OWiJm6kUnxbxhhTeEyuHEyikkUVs4AfwFYje+mH+KdXeJFp15JXs5q/bLKIn7BpS
	PL8IczCaHDKR8TSQC6NJknzybLfzYMChTnTH3M8hcxZcXav2Uwbj8VXcm9iFRCUt
	g6TwMvzqhv031yXKo5ob7JwzW5eQDGjDVPzfDQgf6rrD5Fc6DEmX/InSMtmYAo9V
	kNp1jv6NrUjUGm0/cTsYDxci3Bdzmvgw9GuGdxQydLKVMQwlyFNvJxx3uA5mt2aI
	A==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-eastusazlp17011001.outbound.protection.outlook.com [40.93.4.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42qf1dhhgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 20:17:07 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwRt17YjepK8N9k6h+q/nusdBIbyk7LVghAmHIK+/iCD1/bWvMI3liVtFoLQ6ZbOkInSEP5xAqr00O1iftDhvIEmnF1V7by2uc+iBeDBgnFDocZ29EfsQ29D28r/AlxoIzq680snmRZ9J59FZyvisIcyNZRzDdyJQxlzdFJ9s3o7DIOk7zk+YqyrIR37MxrfFjhemSe/UD66bsLrroWiaK0+Gu0qvT0P4Cyu8tMJTHHTh0MJj9pwDWLINV4apbpJwSxCVzWnvzjlJGB25SrjBlrNUCH4se3ENPzyjtLW7ivPL3y7Gwn1nRs83rwO0dqsI8eEiFTKDyBSg22nXDahWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2eHOn7ywqakckanuMnw6PAuUFRtaCOhGv1g2rWHTHo=;
 b=yBPdpVdICJch/tsq8KfQGMHv0tCbk2B9pgl+GijJqvs4zI4wxM8jrqx4QU+egKdsMtO49+/yfCpyryLy+s2jbE57rYGIvVzr94OR5fFI3fkEYi2sxQaT+WqN50r7TmiIIILby7GkSPaBexCGJNgrHymbzuyWe3yLewMxfTbX/3M8SkqqVkRr5BVafv6VOS/uMqzm45vnLVfUHArQ/TfXzn7tWPAG9qFtYYGwT51SGYXGCbEimhlRPtlHJikESkbxrJY8e2lgsG/+kw/F4ZapgGt0DFr5KWGwWTcY8SM6BBrwOuHI8fxynQOfTIPr7LVxNNDHgdIEQUbgVd1QI27p1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by MN6PR03MB7575.namprd03.prod.outlook.com (2603:10b6:208:500::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 01:17:04 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354%3]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 01:17:04 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck
	<linux@roeck-us.net>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "Sabau, Radu
 bogdan" <Radu.Sabau@analog.com>,
        Jean Delvare <jdelvare@suse.com>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: RE: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and adp1055
Thread-Topic: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and adp1055
Thread-Index: AQHbMCrJ4Y9sFgRAo02CKADXnFeaqrKqHK0AgABLmQCAAAGcAIAAlSkw
Date: Thu, 7 Nov 2024 01:17:04 +0000
Message-ID:
 <PH0PR03MB6351F678D8FDC9C28174E9EBF15C2@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20241106090311.17536-1-alexisczezar.torreno@analog.com>
 <20241106090311.17536-3-alexisczezar.torreno@analog.com>
 <ZytSCD0dViGp-l2b@smile.fi.intel.com>
 <55825e91-b111-4689-bb3e-ede2c241728d@roeck-us.net>
 <ZyuSzPXnxRYG4Gk3@smile.fi.intel.com>
In-Reply-To: <ZyuSzPXnxRYG4Gk3@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|MN6PR03MB7575:EE_
x-ms-office365-filtering-correlation-id: fb6fa5fb-e757-4ca3-43a0-08dcfec9e3e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5dkoUoKF5mrJjRKC2wIIXk/2qlN14JFg+a9y1yWzWx2mPKMnUOJMLrn7HQ?=
 =?iso-8859-1?Q?lUdIHep39rAtMn/QOwGVTa6CoVNI89ZbKJUnaUdXadBeZ+8jeafeIvfhs2?=
 =?iso-8859-1?Q?Avs7hCXgHjAm6vOBt8O1MIDcif2tnYHmL9nd12wknE3NREO1RqTnSUHkAw?=
 =?iso-8859-1?Q?rebfodjjV48Rh/JXV1yUQpnd/PplZotYBaTS+0SC2i70a8Cb1NaRYuKMo1?=
 =?iso-8859-1?Q?rFr+FephF66kdb5zDCkDf6KJ096bmmhGDOogYUjwEBTyqRQPKipvQGqFAN?=
 =?iso-8859-1?Q?nez4Jbx96EVYtMgqTOG8HgApE2eufUrJqMnOQ6vnVw8540TcQ3bddQiMW4?=
 =?iso-8859-1?Q?nMK6QpoWLnKzINIItHgET4VX+xOSGam127aFDd6p0JRSDIk+n5uEXYZyZo?=
 =?iso-8859-1?Q?nwPncuXFoQ8h235ZEfrT8A2N5Ltz6lec0SLozqYFL4tlYVck1mh0lSNo8e?=
 =?iso-8859-1?Q?T5tUoKdwMOgT7RplCJnCVj+Do5efD/4LlHzAAwCMrmFJUfUIaj1QsFhOr7?=
 =?iso-8859-1?Q?fQGW5cKXXspWdk3g0H0YPt0H+8Oe2w2oXObvIihBiEXhnV0KoaVfAHZN6p?=
 =?iso-8859-1?Q?fMjDXIXAQku0Z8xgxxl24J0+hVX1Qo+U+XksThSt7fFFD4sS4roMVYQslV?=
 =?iso-8859-1?Q?+bZ7D0mMoRIgFXEPeFAWfyW4Ic64RBD0IvTCs7tj5u43zowBITry09EXEn?=
 =?iso-8859-1?Q?UMiZz+axsaF7FuV88G3qIAM+i6SBBms7KhluYVufcaK16mBtPE373hLyxH?=
 =?iso-8859-1?Q?szzgzk3dtm9FFGXVc3JU6malm2BddshF5U/XXrOAUTwl2kBIuv9KkGXnWa?=
 =?iso-8859-1?Q?ZoHWqcpm1Ne+3VM6A8eG4Tt30UPGsYlcoNgyOW5RbjFNY1+8gDxUsyJggc?=
 =?iso-8859-1?Q?M4fM7swxpFSfzQWiWggBxWCfLTfUaXaiuryaxcQorvLNS9DbY/1jZNsGGe?=
 =?iso-8859-1?Q?fFf7GzuzO0ua9rG54JIihRWrDkx9Fl9owaUpRxJwWh+iT262sVPtRaH0OI?=
 =?iso-8859-1?Q?++MZdBCwkr62I9lN0gWCtXl9MuEI5TXJQSnSl2RxqxL7/iHEVsdja09nYz?=
 =?iso-8859-1?Q?C/WRMdP+J8aUvWadiAjbuU738cydIlJIm40YqqSt1Bxoyxdb6W/yNKt7N8?=
 =?iso-8859-1?Q?L+6k/zAjwacsm/c+ksNgf22EIUeotCefJUQJMz3QuEKpAY4TvMY6PMpjbz?=
 =?iso-8859-1?Q?M6N9Fawihaq+4bqxAOlARbxMed223BSYsgvCEcAR9+2W/vNTfLzgKE8TgF?=
 =?iso-8859-1?Q?WXJObyKcitemWPXjiR9Lq0VxpBvoiKt3X2/39BxGXyQdrBJpKXIycF1kPG?=
 =?iso-8859-1?Q?uoIdBCkHmaF5gZRXwg+GkcA/j3OJYOPpgmtNk3fAo/uYoPnN8nr7dtsMyz?=
 =?iso-8859-1?Q?98cCk3u7R3UkQpDNfkG0RrnFV8iCHGx827SCQGzCCbef/p2Zh4J5A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9UdCAfFOxv/E2c/khBZcsn0VJzjnk6A3NChLme5WP3g8pNAPe6FqaCLTVq?=
 =?iso-8859-1?Q?cqnFz2w7EAl/RJw6Xbt1z5A4ItAlMucYXs0ARDPv66OzTgvmPqo18yS8Mj?=
 =?iso-8859-1?Q?sKKrDZ8VyvGS+P3qIQ9FAYlJLyTfRqctN1QkimJOsnVbUo6ZUBXrF1TLN6?=
 =?iso-8859-1?Q?vfzEy+3JFWWTdUFy7QdtFcysADpKu6jBVnBOCIAPhJqppwIj2KqsCNQRc4?=
 =?iso-8859-1?Q?hVBYA6Sl7fjDbbeq41srOg7IavXooW1YmM8hKGCY7tv0+TADwwcr8HQkid?=
 =?iso-8859-1?Q?f0ujaaOPnNEo9XyYhHn9KJq5BGbgeKJygzvFtH1JuN3JLB4TIggpS8Yw77?=
 =?iso-8859-1?Q?6iCNskatIrWh/lfuq0ZV9XZUp5cvbEdi3rsPIfpYDKJOyAxVTMZnncadmI?=
 =?iso-8859-1?Q?qA8AKyKd6GU03xUhuPvu3bxvczJ+62ku82u12WCSOkUXnl4LNRYlswF3Kv?=
 =?iso-8859-1?Q?om2R6n29eHHM0xYcvgELwCLnSeudnVy4HeoI1NLmZc9xD2BvQT8uqKulWH?=
 =?iso-8859-1?Q?xUWav07BNp7eUdAzcraYSPM3QrIC2nKTfMatoZEVBL2ewletH9EMEY4RXZ?=
 =?iso-8859-1?Q?DcwizuOP8N3WnEP9sRH19UCpZC1laESVJl/Bdfr33nhb1IXZ0NMjuGdEkN?=
 =?iso-8859-1?Q?LCXAANxgEhwJiOQPHMa+HbXU7J2K8UuYKk9eRX0676vhJHVhesh7nfVk9C?=
 =?iso-8859-1?Q?pFk7Pz+MmTF8tanSYjydkMI2IcxDt3pdko8fBKDFkyUrHW5GMbWFDtzLFG?=
 =?iso-8859-1?Q?nIyWop3Y9/I8twGkbqGFVCtQFBce+HnfiyEzabNFm8utY7+v94PO7ReEll?=
 =?iso-8859-1?Q?Gi3JVAvBVVzhCRqnUxtMR7dnkLCwBKv0ZVv3s4a6UA4p/yZ1gIobOJ4nrM?=
 =?iso-8859-1?Q?0z6jl8gayWs2IU8txFrEOkqkr7O8HfpaRt1wMUs2hOv3hkdTKR7vNCs1qI?=
 =?iso-8859-1?Q?XvhM37pHJBp3fZrgBGzFhwPzJPT7xTQAD0mngyhFR3kiuCdg/jZKrUwP3S?=
 =?iso-8859-1?Q?rLYXjINm2SKWkJDpy1p3TA7xYOVTvOfPoO+NtnLPkZBNdR8W/3Yr1RH/P0?=
 =?iso-8859-1?Q?2nhz/hm6mT0BgcSMH8jOb4TOvZeVdy5hUzi3xFMXIcnKOq/6087suFZV2V?=
 =?iso-8859-1?Q?xb/lq8Ugg41SnA06mVbM0jMfh1jNfz3IbNaU7hUYPxWr4JUekcGQO1biw1?=
 =?iso-8859-1?Q?l2VU2SXZNO14FJ5vKhHcTyh+MIE+GUH6h67klHKWCP7SeSzF3pXs/KhV3v?=
 =?iso-8859-1?Q?47wjbrf6Ig+qOPFt2AfxuTvSUORQeuY40QeKSVXqvtzJ/SM0F9moy6fpVZ?=
 =?iso-8859-1?Q?ePHwH0YSXBJmRQP1RTYXj/UHmHCBG420fB66YKyWo35BCOhm4Qzl6yYfR1?=
 =?iso-8859-1?Q?RgiXCRAPN9bp3V6b9YhAmK3Ffz8KsK2aJ+kjU67G1AiSArAx3kTsErUALa?=
 =?iso-8859-1?Q?qRWKqyl8xUdCldE74og3cx0zLkq66vkcaNhEaI/mOrWwfQda7LIrHkkIcJ?=
 =?iso-8859-1?Q?Y3wqoeigL5lvhEs78h2u/Cnkl/lafiQqD2WxZc7wcM6faicw23Fv0Y4fEB?=
 =?iso-8859-1?Q?832eabUQik6ZauirtJgU4WDnEKqC1KNaH2Ub2wVisN1qY6aHJ9Prv7OJHk?=
 =?iso-8859-1?Q?Uvz/4bJz3O76SU50NPPRQysPaQ2719nDyqcEIRgFS9vO76CP8kOaimog?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6fa5fb-e757-4ca3-43a0-08dcfec9e3e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 01:17:04.4838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yiLcsdOgGDEmz9gGxIH2ddnKTN5DJLhjCOQ0jkoz9AGK3om0vcGLGl5Ra4e+9GjSW7F9GI8IBqcVh/DScmliY0/9ZSEuAzNgVtySoS/n0ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7575
X-Proofpoint-ORIG-GUID: fIhi9xDTqokuOk4zKJibtTpnBdiJ9XJ5
X-Proofpoint-GUID: fIhi9xDTqokuOk4zKJibtTpnBdiJ9XJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070007


> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, November 7, 2024 12:01 AM
> To: Guenter Roeck <linux@roeck-us.net>
> Cc: Torreno, Alexis Czezar <AlexisCzezar.Torreno@analog.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-hwmon@vger.kernel.org; Sabau, Radu
> bogdan <Radu.Sabau@analog.com>; Jean Delvare <jdelvare@suse.com>; Rob
> Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Cono=
r
> Dooley <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; Uwe
> Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Subject: Re: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and
> adp1055
>=20
> [External]
>=20
> On Wed, Nov 06, 2024 at 07:55:30AM -0800, Guenter Roeck wrote:
> > On 11/6/24 03:24, Andy Shevchenko wrote:
> > > On Wed, Nov 06, 2024 at 05:03:11PM +0800, Alexis Cezar Torreno wrote:
> > > > ADP1051: 6 PWM for I/O Voltage, I/O Current, Temperature
> > > > ADP1055: 6 PWM for I/O Voltage, I/O Current, Power, Temperature
> > >
> > > Missing blank line and perhaps you can add Datasheet: tag(s) for thes=
e HW?
> > > (see `git log --no-merges --grep Datasheet:` for the example)
> >
> > Is that an official tag ? Frankly, if so, I think it is quite useless
> > in the patch description because datasheet locations keep changing.
> > I think it is much better to provide a link in the driver documentation=
.
>=20
> I believe it's semi-official, meaning that people use it from time to tim=
e.
> I'm fine with the Link in the documentation. Actually with any solution t=
hat
> saves the respective link in the kernel source tree (either in form of co=
mmit
> message or documentation / comments in the code).
>=20

Will add the blank line after description.=20
Am I right to understand that we leave this as is? No need to add driver li=
nk
in patch description since it is in driver documentation?

> ...
>=20
> > > > +static struct pmbus_driver_info adp1055_info =3D {
> > > > +	.pages =3D 1,
> > > > +	.format[PSC_VOLTAGE_IN] =3D linear,
> > > > +	.format[PSC_VOLTAGE_OUT] =3D linear,
> > > > +	.format[PSC_CURRENT_IN] =3D linear,
> > > > +	.format[PSC_TEMPERATURE] =3D linear,
> > > > +	.func[0] =3D PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
> PMBUS_HAVE_VOUT
> > > > +		   | PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP2 |
> PMBUS_HAVE_TEMP3
> > > > +		   | PMBUS_HAVE_POUT | PMBUS_HAVE_STATUS_VOUT
> > > > +		   | PMBUS_HAVE_STATUS_IOUT |
> PMBUS_HAVE_STATUS_INPUT
> > > > +		   | PMBUS_HAVE_STATUS_TEMP,
> > >
> > > Ditto.
> >
> > That one slipped through with the original driver submission.
> > I thought that checkpatch complains about that, but it turns out that
> > it doesn't. I agree, though, that the usual style should be used.
>=20
> Oh, okay, that's up to you then.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

I based my code style on the original, but I agree that the usual style
should be followed. =20
I will change it to follow the usual style.
Should I leave the original untouched or should I format it too?

Regards,
Alexis

