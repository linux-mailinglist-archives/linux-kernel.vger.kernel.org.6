Return-Path: <linux-kernel+bounces-399516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E382B9C0013
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B071F22626
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB3D53F;
	Thu,  7 Nov 2024 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="k3b4jp8C"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1DA1DF988;
	Thu,  7 Nov 2024 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968502; cv=fail; b=qMriGbKTcfbBBbW0BuUJtTnTryUS6epoEJY+qLrvCtyObv8yRpG6cQpBLJx/RODzpUbKMinRSZVSwHy85ZWUpnsScHEJJGwvZUDeiH5b0gYY+VwiSLIgHiBl45MGuYJaCz1ewCh8eUpgWLmqrk49BAV6AKNLJ10DpT6an/J8iSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968502; c=relaxed/simple;
	bh=jcPUewKm3OkqpSQ3OWHJ7m8SET7xQKspDvihWwOniiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f8RF7fK5pNt0bavS4+v0YqbIGhcfNiz18FxHxyrD1SZekcAIEALVlE8oQ11yYXiQLgQz5vlEE16lBNkofQFqhya1+H1esk2R/uCzcSmNxwSpBFxWX3VHpLhmFb3KITf94E4mtOuHVnPRdshjkaDtYO2hXKN8KhQN7Hkllcv7BoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=k3b4jp8C; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A77iDEv010361;
	Thu, 7 Nov 2024 03:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1mNre
	hWohWrZ2seUySIY9rnnW2T/VBgcC/WvnKkQILI=; b=k3b4jp8CM22sesqdLLVrr
	jV0WSvLfokrl0Bqu3kdtRiz9uwNHvuo8SsBKUe+tXHwZS0iIfglXb7uyUlOSDDSC
	em6CxKatSB6cEqBFagLNABgt9NBFDzxMR2t/MI5RhjsnNDhSfWak9YLDgCfPJ2df
	lFTxjO+jZ30H8qBNFV/OBGLoOsurZV301G8rVXK4vtINgRriHhRV/1RBTSZQ2Iv0
	XJcxW0Xq9ndeIp4pJW0wMDh5HBu9W7LbEgsf8NvGjW8134wlSeVifObzi4ewp9vU
	V8QYUvx1QUxwuvmsHSyHT3xN3AcBLpdfPG1TD2KZss3iNQ15towzEX51LOs8MgtQ
	w==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011029.outbound.protection.outlook.com [40.93.12.29])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42rse086jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 03:34:39 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+9c19ZEek3wVG9Qb9C8PkdLxaSWg0bKmUk4HpP2hI8qqA10SRj18zsffKrJQHvzNYw24RfNs2lloNIogXUfN/he9O5YvN8xy3FUJnzJ9bJqY7SNTz7RCbvDLyZioyFM1r/QVk+3z9L78ji7GU4+i0OBi/cpGR3ZSNSJflW3RHNsqiHmhu0VCf5Wd0H+nIichIKk7Irns5oEosNlO1mJhnJsAFooys9wix/pBX0j7ayQz+VRjUD3vgPRWWpN2VVyf2auEne4sqdTBUgFMkVZsK3ql2wYiRvCEgI3WPar+c2pVdwOX5Y/iuLUGNzpxm3vhjy300yBTHp9oaXWC9Pa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mNrehWohWrZ2seUySIY9rnnW2T/VBgcC/WvnKkQILI=;
 b=arJ8DLHsB5GAGQJ3wLvfzuircXvo/fG2rXIZUTbba2ijSmWcbrVlxYcdEdmu7M1vASsFXDu73TdRfvedDqwEkQWb+XRf4mSXlTHt8Wf4NVVhSqhPiCTyfWkTtSObNvW6cImV8Fv1UUmifrgtcMDurNgDQzYMiVZp4hXs3Dwrfs1rxnDOEmS74zCvJsJR7joyl6hH+uQX8z9LNpMgcfktKTC4NxDh+b2xWlyidDNqGHqGyqXk77RM0mj4XYhFbpgQW7cGDZEcfK6XS0kYsDpOvo6BPD7WCzWV/9+SMw9gwvN93Xp0vzgrp0U74C0Mil860IG7kOSDhDX7YaNjlhF+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by BN8PR03MB5074.namprd03.prod.outlook.com (2603:10b6:408:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 08:34:37 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354%3]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 08:34:31 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Guenter Roeck <linux@roeck-us.net>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>,
        "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
        Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: RE: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and adp1055
Thread-Topic: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and adp1055
Thread-Index:
 AQHbMCrJ4Y9sFgRAo02CKADXnFeaqrKqHK0AgABLmQCAAAGcAIAAlSkwgAB4NQCAAAcFkA==
Date: Thu, 7 Nov 2024 08:34:31 +0000
Message-ID:
 <PH0PR03MB63514E801BD8D2C08BE206E7F15C2@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20241106090311.17536-1-alexisczezar.torreno@analog.com>
 <20241106090311.17536-3-alexisczezar.torreno@analog.com>
 <ZytSCD0dViGp-l2b@smile.fi.intel.com>
 <55825e91-b111-4689-bb3e-ede2c241728d@roeck-us.net>
 <ZyuSzPXnxRYG4Gk3@smile.fi.intel.com>
 <PH0PR03MB6351F678D8FDC9C28174E9EBF15C2@PH0PR03MB6351.namprd03.prod.outlook.com>
 <Zyx0wqJnOwGfto_F@smile.fi.intel.com>
In-Reply-To: <Zyx0wqJnOwGfto_F@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|BN8PR03MB5074:EE_
x-ms-office365-filtering-correlation-id: 14e521ff-e93a-4934-ddbf-08dcff07002a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rYj4VDCHd4VXWImZBax+XnXO/6tVlpXyyTbGEodska4+8rvJSxXnspGT4+?=
 =?iso-8859-1?Q?Ck7k5aQxW56gomH9yBL4M9JxQy1QW1MYbwAcRSiH7BF+xjYXOEAOatLumx?=
 =?iso-8859-1?Q?CnRSfmr4zOPq38gTKZXM7KTCnU8urlYjcM7v16f48X9tQ/sRHIE2ZYdis4?=
 =?iso-8859-1?Q?ftWJn/BZEcTa2Iq9vzwBBjatwTzs3Uj8kMjdK2zfU7K7acVtAC+SuXCUuj?=
 =?iso-8859-1?Q?P1Xm34IUuUepH809KRF7lScMQGt85/jRbkWrhVzlWKHmGtM4PoCLXVzTCG?=
 =?iso-8859-1?Q?KcDU2ZO2HQKHiqOpVEOy/GRFaPJRorUw5aH578c8C56Gg21YLgQPljRRiz?=
 =?iso-8859-1?Q?kR4scvwintO5davilaOj+zsATYjMKoXCYAKHBe77bHka6MoZ7dgTbjbR83?=
 =?iso-8859-1?Q?4ZNdlvQCJFFnvOZSIvf5votqM0KYvHN2AmcnzxZRNXsnsYxjHJPQ+vbf7f?=
 =?iso-8859-1?Q?fbcN68H3s3NF+hAi0tCMiK1ntjk5eR1AhScFGhIRzYJsTFN3a1Z4EpnkRD?=
 =?iso-8859-1?Q?nbnshskp37XaFTxM7trKeJKhffffiNVIFU3L6MENVeOzNL2XVZDLsMkSEQ?=
 =?iso-8859-1?Q?crCfr9I1Omu5hh9BHzpdq/X/BSr8tpoopjrI4Y+qhFmrTLnERGA8t4df0b?=
 =?iso-8859-1?Q?ijdVhDvStXsKstODXLbanj8mBoCAKr0Hn7FO+3spFFu5fiM69HM/mn6S1c?=
 =?iso-8859-1?Q?/RF3nDvNGUrgAUt/gfl1tqaXwR31d2HV5DLYCjpNiUFBX7rXpkM/Z7oQek?=
 =?iso-8859-1?Q?fBl14C2PYnefyuriGr7QMNswKdPN51vRAd1WJzys4SO3Stx5bd6zariKIx?=
 =?iso-8859-1?Q?h4wqbV3hyoITFB1Ej0axZ6XS3vY4vR0u1myip52o1I9xHymcvxMHuS71Eb?=
 =?iso-8859-1?Q?qqb0o7juGpBj2Bx5GJipUiIaExxQVv/7DkBF7r5/rzKG/pfcgxfz8yC4bW?=
 =?iso-8859-1?Q?ICxjY5P7jKDeK4odbrEr4L/j/TdYz8ZvKR6KM9Ow6nVqnfHbtRef5hDFHz?=
 =?iso-8859-1?Q?RHW5PubPtw70NX24fWDQHRTEVC5UafQ6Hj60ZY4hbZjEYjOFge0QQJW0lJ?=
 =?iso-8859-1?Q?ZJbRL6XeD5uFkKXCGBDnk7bBCXBrxT+IL2Anfa6sDpnhGFTlRwh7pWfaR+?=
 =?iso-8859-1?Q?K2LAj8VUKd3Slc9y3MvxSDRxHJSOdxLffdTVKICSgBIDDBOxsvXy1Z15hh?=
 =?iso-8859-1?Q?iq4o1lBADuW/g5LPPoWzEGTDMXkA5ddbn4TDvxB6XF4CopXnUVKFmF6gDU?=
 =?iso-8859-1?Q?YFaJgjYgwSkoszqeAfFCSbJUnePpLNnBhHG/8L5Bnbqs+Bme+ArPNM2fhr?=
 =?iso-8859-1?Q?iUdigwLruOacgu3uQqQ2818eIAqsOjW6QxIBnYEUHQ46TmggRAW/+t+vuK?=
 =?iso-8859-1?Q?FO6WGyj+rTrgCzk5xCOBCM8lLTblSQvE6fPY1A38MnoaNH9KcYmaw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ao6nT39NzxGWSaEO8+qbdfUkPYTYfa9hsgi/Xm+w0NS0Czzs87T/qLig1P?=
 =?iso-8859-1?Q?cG/8U/xFFvC6D3SELtR8GNN+egCKFBg8PDyll78fD9kyWOogRfEwfjOxoC?=
 =?iso-8859-1?Q?aWt3VNeaAg0OhPzR+G0SJGgns0PwVnKBtd49N/uXXfdd0hrqt3At3U8H+U?=
 =?iso-8859-1?Q?5Up5WR4igW7C69tIC4UJBvPhUoDsPgsYUxzUpmDR+yQQ6QqPzcdWmnc4ao?=
 =?iso-8859-1?Q?1WRpdf+S1wkwZMO6+s+0mDXJbQs26ikL91hV+Ul/xy5EJEILkzmk0ANdCA?=
 =?iso-8859-1?Q?M8w55qt5nUdM/xO/2r6bzxPi+PIgADiMZhzYrnf5lzBTtRRF/+l81x56ba?=
 =?iso-8859-1?Q?UCIgsMal98sTRCRZd6XUDyAGj+0mIkjcRODZYlcbd73lH2C9ywfzlbxB4C?=
 =?iso-8859-1?Q?bKiwWMkyDipjdKXQu/UgI0T2f+wbZiobxRE5Z+NmBxMFE0ZnVkVqAS0Bql?=
 =?iso-8859-1?Q?wdkSKyk/0l/z4l3zVQW/oLa4bhTXIPlpEkXTTPs1zpOJRGsUWLrFYwi0iM?=
 =?iso-8859-1?Q?wvooa/mES4Hu+9mUVKdmOkJq0C40E6pvEIsu3k0+yDgN8HRBZAIBtJp0eK?=
 =?iso-8859-1?Q?yRYXgTbW9VrSj9ouL66hlLxxRtRhwPLe+oBP9/qPcmgAVaZ1nT2D8STe03?=
 =?iso-8859-1?Q?0/SFjko2gT6w3ODd35mJZzhky8ouxOJEpYERjkS7tKQctqP3ylHyFs3SbR?=
 =?iso-8859-1?Q?eZWe1bgpMTzGrGfKueMWp4glz3yB0UOfHs3DxbM4Slrb0/Q8t6/Wbf0WPZ?=
 =?iso-8859-1?Q?iBrSOa5J+WEX/dY+gFlZ0dbcpvCm1L4tCChsX/IivBdK52xfKaLfe5okJ4?=
 =?iso-8859-1?Q?O+xffdMOFp9u0aAui8L2t+2fAkna8dt3Ve2J8+b03AmQnjQl127zGUMhfI?=
 =?iso-8859-1?Q?R0qdny8ncqhPwaB7+Itoq1YPIeLc/6OHeggeeabauhc30lrqC1bJQUI8Cw?=
 =?iso-8859-1?Q?c0PNsfoP6ufRUv+Afy6GE8DIE7YpdzcWMLw1b00SCryG0SEQGE+cOupHwX?=
 =?iso-8859-1?Q?SRfuEycjEsw0XyAAohKdjXYKaVisI11CAKUCiPphamDFj9XX6XJDuohXVI?=
 =?iso-8859-1?Q?XXDgS0NCmm4vH0ZNPIDaS+dMRjlug4I2FHqMyBYeybcNX1d9Xh26tWT6Ie?=
 =?iso-8859-1?Q?OH4q3o3phM3EiQr12qEXqRqSPCYpUwMYVe1P///XaMKFN4zDGE6wo2t1tb?=
 =?iso-8859-1?Q?ArLPd3l7h+ZQverR1LTGJS+Y512IjaFpPjEfREERsiqv9IMya6/1Jwezge?=
 =?iso-8859-1?Q?soMoaPiBVnwBmoiMSPinr4ZPywlUP73iCWAjGFqR0BVcJh9LEBtVqAAeNI?=
 =?iso-8859-1?Q?woPfZgQ/ZQYiatHFy1xebYN84gl4RV9+C1WRdQJPryZXuG8C7j+Qfo04Vd?=
 =?iso-8859-1?Q?lHGGR+m/DTHKzhpL/PUiNR5h0qAnMiE/YoZIMLgd3ZFsw/nEDF13K8a8WM?=
 =?iso-8859-1?Q?B6uO38rGZ3x4fqjpmj2sAl1Efa3d7Ou/iTm+q1JeipWooDRkx6Ih7KdY22?=
 =?iso-8859-1?Q?loQt5owem/5lfnUInQ/aBLKrFOAfhPQY0sQa2A/tZy+z4CSq9R0ntV16mV?=
 =?iso-8859-1?Q?K3Qf+8Ry6bAmfpwutEJJ8oeCVL30YKVQdUHF4YtedjnqKkzETOZ38zyp8K?=
 =?iso-8859-1?Q?KZ4JfvEdVk/qkq5Cdi9FBOPHDOfDXT6+Ifc86F5CJDov/KFHUYzq4BJA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e521ff-e93a-4934-ddbf-08dcff07002a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 08:34:31.1980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVMebhKnI1wV4TrU+KXwXTgIoEPTA324wBdDq2tW+0j8fb4EnU3Nubpu9SsH0m6vwLKpD4GpgnwnDabEZiOcdxt/XCWvWiAks050Dy2VxUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5074
X-Proofpoint-GUID: sUlAjRq8R7WpZwdTJkKTswgk5lu_dcTw
X-Proofpoint-ORIG-GUID: sUlAjRq8R7WpZwdTJkKTswgk5lu_dcTw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070064



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, November 7, 2024 4:05 PM
> To: Torreno, Alexis Czezar <AlexisCzezar.Torreno@analog.com>
> Cc: Guenter Roeck <linux@roeck-us.net>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> hwmon@vger.kernel.org; Sabau, Radu bogdan <Radu.Sabau@analog.com>;
> Jean Delvare <jdelvare@suse.com>; Rob Herring <robh@kernel.org>; Krzyszto=
f
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> Jonathan Corbet <corbet@lwn.net>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>
> Subject: Re: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and
> adp1055
>=20
> [External]
>=20
> On Thu, Nov 07, 2024 at 01:17:04AM +0000, Torreno, Alexis Czezar wrote:
> > > -----Original Message-----
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Thursday, November 7, 2024 12:01 AM On Wed, Nov 06, 2024 at
> > > 07:55:30AM -0800, Guenter Roeck wrote:
> > > > On 11/6/24 03:24, Andy Shevchenko wrote:
> > > > > On Wed, Nov 06, 2024 at 05:03:11PM +0800, Alexis Cezar Torreno
> wrote:
>=20
> ...
>=20
> > > > Is that an official tag ? Frankly, if so, I think it is quite
> > > > useless in the patch description because datasheet locations keep
> changing.
> > > > I think it is much better to provide a link in the driver documenta=
tion.
> > >
> > > I believe it's semi-official, meaning that people use it from time to=
 time.
> > > I'm fine with the Link in the documentation. Actually with any
> > > solution that saves the respective link in the kernel source tree
> > > (either in form of commit message or documentation / comments in the
> code).
> >
> > Will add the blank line after description.
> > Am I right to understand that we leave this as is? No need to add
> > driver link in patch description since it is in driver documentation?
>=20
> Add it to the documentation.
>=20

Already added the links for the datasheets in the documentation.

> ...
>=20
> > > > > > +static struct pmbus_driver_info adp1055_info =3D {
> > > > > > +	.pages =3D 1,
> > > > > > +	.format[PSC_VOLTAGE_IN] =3D linear,
> > > > > > +	.format[PSC_VOLTAGE_OUT] =3D linear,
> > > > > > +	.format[PSC_CURRENT_IN] =3D linear,
> > > > > > +	.format[PSC_TEMPERATURE] =3D linear,
> > > > > > +	.func[0] =3D PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
> > > PMBUS_HAVE_VOUT
> > > > > > +		   | PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP2 |
> > > PMBUS_HAVE_TEMP3
> > > > > > +		   | PMBUS_HAVE_POUT |
> PMBUS_HAVE_STATUS_VOUT
> > > > > > +		   | PMBUS_HAVE_STATUS_IOUT |
> > > PMBUS_HAVE_STATUS_INPUT
> > > > > > +		   | PMBUS_HAVE_STATUS_TEMP,
> > > > >
> > > > > Ditto.
> > > >
> > > > That one slipped through with the original driver submission.
> > > > I thought that checkpatch complains about that, but it turns out
> > > > that it doesn't. I agree, though, that the usual style should be us=
ed.
> > >
> > > Oh, okay, that's up to you then.
>=20
> > I based my code style on the original, but I agree that the usual
> > style should be followed.
>=20
> > I will change it to follow the usual style.
>=20
> No, please be consistent with the existing style. If you want to change i=
t, add an
> additional patch to do that for the _existing_ code first and base your p=
atch on
> top of that.
>=20

I see, I'll keep it consistent with the existing style.

Thank you, will send an updated patch soon.

Regards,
Alexis

> > Should I leave the original untouched or should I format it too?
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20


