Return-Path: <linux-kernel+bounces-305193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A26962AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAFD282C11
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7AE18A94D;
	Wed, 28 Aug 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenze.com header.i=@lenze.com header.b="NhCS4maS"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2121.outbound.protection.outlook.com [40.107.249.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89C2868B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856744; cv=fail; b=CrgCvvsPpHB863TXb3Q/JAxtCUla7DJMCflH4tAlrt6+Or2DQ6Hz/0FWNwIGSC6c8fMKk1kyxCXviUHX7Go9/WClGFPWQ1ZYDMsy1L+F4R74wLLcnvsTLKGAdwQ3bvm8kHbET2o7KJFlC/KS8tbgHWE9SAc7ABfqLd8ZieGTJRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856744; c=relaxed/simple;
	bh=3Omg24JN/moEdp3VK/fg2KUG1BZdDYjnAnYBenhALW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ix11SMXsKmQ98g56dlDnCiteX+Ra8ra+8XbrEIYsHLlSvMIw8TSzG2i9gH42eLxP0Nlo80Tz7vzSsihngxFAbFYAPUWb7sIMTxRz680d+d4Bs4qI/LukPqZc0Idv3ejxvR4ThIBkhs2OybU73kR+h6QTpQ6HeNrIqgrlhZO6IsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lenze.com; spf=pass smtp.mailfrom=lenze.com; dkim=pass (2048-bit key) header.d=lenze.com header.i=@lenze.com header.b=NhCS4maS; arc=fail smtp.client-ip=40.107.249.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lenze.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenze.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bB55fAepT07p8I4pK6vRhGfDU5G1WRj1OIg2SLhGxfDGsuKKKiPJHro/Tl8lSf5zOIN5ZpX7+6AMdfisXazROkb/pqPb3zoW5fql+fJiTYgiCdfD3v9/qUKiOfLMECPFmVnMU72lWjk//EbQfBfdm4yISd2/+3rciFSMTsE8PAwIOa2qH/66Ch8vVOMUtUoK/mHDxz7m+au4IRNIbu72BlR3arsH4HLkzgOqmk4bjV//840EQXpx53b2ALVPtfp+hK7qST1z4Ry4BHe1FwS7iKGKcqq4DtvS7kgGzqw4GQ+ZRfrK3UTe6L6vOl7/Lmypt604yIXKJelJ6UuI3qknaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Omg24JN/moEdp3VK/fg2KUG1BZdDYjnAnYBenhALW4=;
 b=RS8Ja5kHnnWT0m8Mvse8WJBFrI5nhuknx1Z9v1hp9blCZH+mfVW473NJ3Ovc2MNJQaj+l/Y1nppTcrmhORHmZDNK+Cf+fP/JcWQiGpH+m1NQffgpTqBn/j9W/EF20Xnj0CxVrM03OmGR2DVJNknWSkzUkjPGAb/WS1DS7hPt7vtE5TQl2j1UysCzTHrPgJBQlY+CbPoEdI6Em2fjRfWpNMiP6HffViz0yYUjP34AocmPp07kOSJ97DNXva2nV/XUqkw2pbJjrwkEOre/1/NHdYsTcPWLEeeKFDweeP1Rcsyj3GJGXGlNR/3AT8I/OYm0Tm/Hp/+2CRJ5j+7kdfsIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenze.com; dmarc=pass action=none header.from=lenze.com;
 dkim=pass header.d=lenze.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenze.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Omg24JN/moEdp3VK/fg2KUG1BZdDYjnAnYBenhALW4=;
 b=NhCS4maSsYrtMH2Dfqam8rsraCxfsCSVEhTOs9sDMflPmrTqO7/d04IeFUkbllFP00vH0g2sckbaYttOEc7VauF4VuLryLH2wMpHvbWFYU03eLMmCHDfwRQVNSYN1ee0MaZyK/5+mqNEMelDNUa/mtZ8vkK8d0etHJpdUsrpyDcW1pgHrrnHwXeXB696OI/Fn33gfXE8lBYHzxu7HH8H2x3o7ZqTJrOOk2vP4gDD5fCNCK0L3hZjXOudGCGv2hY20MOoXP4vgNNzrr/rhSmc4U3+hdECCgPe1pDvsRfw8cM7z1mFykCdWUD6qZfYU/L5ho4/ILhmZ8Ty/SbScm67Hw==
Received: from DB8P194MB0806.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:162::23)
 by DU2P194MB1517.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:2b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 14:52:17 +0000
Received: from DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
 ([fe80::5491:d30f:43f:4123]) by DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
 ([fe80::5491:d30f:43f:4123%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 14:52:17 +0000
From: "Brandt, Oliver - Lenze" <oliver.brandt@lenze.com>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irq_work: Avoid unnecessary "IRQ work" interrupts
Thread-Topic: [PATCH] irq_work: Avoid unnecessary "IRQ work" interrupts
Thread-Index: AQHa+JgsDXr6phuOQ0i6GwOBiXtqZrI8ao+AgAAEvICAADtagIAACfmAgAAN8AA=
Date: Wed, 28 Aug 2024 14:52:17 +0000
Message-ID: <2f59d15b63bfe1911261af86991820aadaf54b38.camel@lenze.com>
References: <25833c44051f02ea2fd95309652628e2b1607a1e.camel@lenze.com>
	 <20240828093719.3KJWbR6Y@linutronix.de>
	 <20240828095415.43iwHYdM@linutronix.de>
	 <1dc4fa0a48b05e14a1ae2a751441ba021ecee286.camel@lenze.com>
	 <20240828140223.P5vGN54Q@linutronix.de>
In-Reply-To: <20240828140223.P5vGN54Q@linutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenze.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P194MB0806:EE_|DU2P194MB1517:EE_
x-ms-office365-filtering-correlation-id: 4e3a67d3-f731-4049-1a48-08dcc77102b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0dybEYvZWZmN29rKzVmNzgxZzFLRXpOTFRFektqeVE3V0ZzdkcyY3dUK0x2?=
 =?utf-8?B?aDNseVplbGpodHY4aFRNWTk5L0FZclhQWUZuSWVzQ01tWTJrc3ZNOUNSRHBQ?=
 =?utf-8?B?VzVvWmg0ek9PbklRMkRyNHBlYmZSbTRrcWFKaFhHYTFOcVRtNUhlWHVOeEYx?=
 =?utf-8?B?eTVEM1RCcng0dy9hZzZ2MXVmc1NFNVRGTkNmQS91ZGd2WkEvV09RWEo0NVM2?=
 =?utf-8?B?MXJHaEYvcm5VYUVxSGplbitNRzVieEJ2QWRTa2pCb3g2Rno3MEQ0SzZsMEtw?=
 =?utf-8?B?MjN2a2JjdzZFUmR6R3NlQXAwY3JrcFEydW13UXdVR3UydHVtYkFKYktZRzBr?=
 =?utf-8?B?WWVwU0J0b3Jqc0Ird2Nha2xpK0F0RXZEeVQ3NUtoQVRTOHJjYjArdzY2ZnBl?=
 =?utf-8?B?bWpTQnVIZ2NLOXc1L1FGZUpFN3BOcUZ4ZGFHb3RHZHhSUDE0aGxDSEpPUXVN?=
 =?utf-8?B?UG40aHF3YUgyMU9kVU1pZXdhZTFCbDJIclFsMWI3aFVJR2IwdmdmdlVMdU9i?=
 =?utf-8?B?Y2cvemhkVmoxVE1DZlNLdEFncm00cjhTZm9waGNLVUtyMzFzQ0JUejZjUXFj?=
 =?utf-8?B?SHpHcTNpaU94OExEWDUxMVoycmpJb21LRkgwY0lBRmU4U3d5dVdMOUwwTUFE?=
 =?utf-8?B?MG1BNnVBZlliM0M3ODUzRnFMRWFmZmRSK1hTV1RNeXd6c2pDRm0rb1VwOUVp?=
 =?utf-8?B?dmJnNnVLZ0VkMXg1VTR4bStnRWdXTkp3OFgxM2FJdkpYc1lWYmZnamNVODF3?=
 =?utf-8?B?RmVHY1RXdFFiTzB5eDEwM2V1aHRET25abWVLSWFIbnErNlZERlVmNnNiVnhp?=
 =?utf-8?B?RGlMSEJYeGpUUXNheUZWT3hpQW53WC83a0dCbW5TSWo0cThpYXZhVEw4c1l1?=
 =?utf-8?B?V0FuM2kwZW1rQ3FBYnp0WFBPVFZvRkVNN0dacVpVYm1xWjZUNkRQR0NJTXpZ?=
 =?utf-8?B?Zmh4SkhwOHJpQ3d1aXRyUlRobVpFT2dycmozU3A1OEdaV3pTK002UFJmVTdi?=
 =?utf-8?B?NDJPVldFMWtTV3ZUdmxBYUJGdkg1YzlNYXYxemt3WHo5Rk1Lb25PUkhnZWtI?=
 =?utf-8?B?ZlJGS1A2VVljV3BaSituY09Xd1BvL1VFcDdJZVN3RmVPQlU2eGZSUjRkQUQ2?=
 =?utf-8?B?Y3J1OGk4RGV0U0NNWXlBWnltYTZCQW5taHk1YVc4b1ZXenBCK2VlNUR2a0NS?=
 =?utf-8?B?eXJERjBKK0s5UG1qdlVjVDJVbmQ0L2VlVTlFL0FRbWFkTjR2SERMSUg2QU9C?=
 =?utf-8?B?Z1d6bmxMejdBWHYwVWVBOHY5RzRqbFg0b2VUaWd5bGc5LzdlMytvRzY0UDBZ?=
 =?utf-8?B?Ujc2Z3drRElUa2hxM3BJR1ZDOHNyWDl6bGtRVGVDYTJWN2pHSzRwclhvNys5?=
 =?utf-8?B?Q2FiTTFoVU94TXkvODBIRkN4NlI4eFF1RFRWeWhSMkFNVHpRTjYrb3dGcEpm?=
 =?utf-8?B?S0tMZ2NpWjllQ2t0bElvNHBVd3BCOWVDU3E1T3cyb0hJdE9NaGFBSkViLzR3?=
 =?utf-8?B?YjVNTWJXeDU0blNIOFNTWGh1NkFlaE1MY250Zk9PSFRkUFFtbzlLM3JxMmoy?=
 =?utf-8?B?MVhwUWhLeUJiU3RuRTBETnl2Q0hYVE5peXRTWFFKV3VCSXZmVklpdXNsMFNS?=
 =?utf-8?B?V3J5cWxZQ2w5c2J6NEZnK29qVWN2SzhZY0YxSGhRbWg0U1JFNC9ZcEdKY1Fs?=
 =?utf-8?B?Y2syWXVTL25hdkQxd3N4cE1icXdWb0dqNDlpSzBPOTlFWUtoSU92Vi9sVFp3?=
 =?utf-8?B?bDYwZXlJbmdOZDZ5RDNFUmx5dm9nQmtXQmdOT2FMQUtJdnBpOVBDTzNUbnBX?=
 =?utf-8?B?UFVMTHZQY1VvSEdKejArKzlzaWFmbFFIcGxMR1ZwZ0VkcjhCQkloYUdqUS9y?=
 =?utf-8?B?aER1WDFVU2Ruek0zMnZnZjBwZUtwR2VzYzhuUEhsWURXUFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P194MB0806.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGc2a3lJUENGQVFlckxSTm0zZVBCbTJpUG9DMmZDNHJZRkh6c1ZrZkRzWUkx?=
 =?utf-8?B?cWhUbFhvMy9GcmdLNGM1N2VBL1Fmd0RXMTlDS1h5UVVLZGxUbWVqRVQ5V3Zl?=
 =?utf-8?B?bkVpNjFjUmhzazhqMTJKWFg0UWsrWVFkbnJJK0tKY0cvbEV4cHA4Nk9nMnIr?=
 =?utf-8?B?cnp2a25UN3dkeFFIUWFNVTZRRHVQRFJCQzE5UmxSUGpSV2N1cWJvaGtuZ3Vv?=
 =?utf-8?B?cHFoSW85YjdkV1Z0UUJyS0JMS25EOXhIQkdVQTdpTTZFc1lYRlFuNWZGeEFK?=
 =?utf-8?B?ZzlJK0haWm1kemE0amtCNVVkRXBBa0ZSYk5Vc2luTXJiUzBBb1AvZHZnR0dm?=
 =?utf-8?B?eGREc2pac1dTc21tZXpCK1lsdW8zTktLZEY4Y1huejdVZUMzMUN1a1Nob2NB?=
 =?utf-8?B?eldaeE1iaXROWXgrRmt0cFlJNnM0R0R2aVdZWk5OMVJmZWsvMUtjeEdnQ2Vr?=
 =?utf-8?B?cTh0eFgzSVhpOG9vZjdzSURQRmZuR1laekQwL25ZcnhZYTB0SjY2K1p2NEdO?=
 =?utf-8?B?OUNHZmpmQSttKzY1QzRxSHFnUDEwUnNFaGRjb3dHbjhyNlVNYmJyQUJvMUZy?=
 =?utf-8?B?VnJ6bzhBMXNpK2dKK0phWm1MUDVOb2Z1Tnd6dEROalg0TGtzRTdWdHptOGNZ?=
 =?utf-8?B?VjNLL3JURTA0V3VFWitSYllRdDhBenErRlk0VmNSOHYwT3ZPb1l0NGI4c3dP?=
 =?utf-8?B?SHBRTi95RVc1SmtON01vSHdjZHVSUDh0VXAwLzBLQkwyYm5tRlQ0bWJOSWJy?=
 =?utf-8?B?S1poWVByMjRCTnJ0Zk0rYjVNZENZYTRpZXVvMmxZdmJYZDNRZ2lRaWtSMGRn?=
 =?utf-8?B?ZCtwUlpTUklnazJpRmkxRTZQSDUwTEpvNWFIaFIxbXpDNjAyUlZoTUVTMXVI?=
 =?utf-8?B?NGpvYVU0Y2l1dFpsOHFjSUx6SkVtQWJjcktibGpnMExzQ0h3UHNmc0J1dXVj?=
 =?utf-8?B?cEF6a1A4UWFJVjg4VnVRY05RTWx6WTZ6MytmSmpYRjAwTnlVWjlSNUJHZE14?=
 =?utf-8?B?bU5rL3JJSjFHeFV4cTRsbTBWOXhpS3g5STlsRnhLdmpRUERISTlpMER2d3Fs?=
 =?utf-8?B?Y0E3VVBmVVZyRFJwNyt4eHRmTjlRekZabTJ2ZmY4cVBGUlVsZndGc3l4K3FY?=
 =?utf-8?B?WklDak9vQ0dUS2Y5U25qZG16Vm50ZXIwMG40MlZoWFdxR1lnRjRpdlZEMi91?=
 =?utf-8?B?WXBTak9teFZHaDYwZzBmdnR6NTNFRXBjNklQVCttaVBzaFFtWTA0QUs4SHlt?=
 =?utf-8?B?aFhJbGI2Vmd1NzdBdEV5VHA0YS9oUUdVYkZhdWdxQ3R6aUt3UDE1UTRwcDhX?=
 =?utf-8?B?cFEvMCt0QTlnSEROeXJDdmI2S29XODI1djhJWkFCOWNnUWhoQnJMV3gwbmp4?=
 =?utf-8?B?ZEgvNm9VYm84UEYzaXo1c2FabXp0dEVTMnN6eGdkMnp2MGVXbkJnUkZSQTZz?=
 =?utf-8?B?cHo1cXJkWDh2SXFZRzlzdzQwRGRuay9uSnVjUXlrRXduaGdEWHUxZEN3K2sx?=
 =?utf-8?B?L2pKVW4wNWRFOXBQdGV3emdWSUc5VlRLK295TGJxWmdqNjNMR200aDllQitp?=
 =?utf-8?B?elJINkVlb1AzVkl1MGR3ditreVRSdUo5VXhyUGNLcUN4WGdLYk1IVitrQncx?=
 =?utf-8?B?dWtuNFdXQUVXMnBBNHl6Y2hsVkhYYkNqdTU0Q0VnRmtkM1ZyN2xwZmRIMUQw?=
 =?utf-8?B?R1ovdHVQRVh4TDBoY25nbXN0UnByYlpPWUJMT05MeWhDZ1NsaE9ZUDg1Qmpq?=
 =?utf-8?B?TFJ6TjVlMHVXYkk5ZHdrRDdxWVVUaVRDV3VINDhVelBvdEwvRFV5cHdGSlYv?=
 =?utf-8?B?NFM4a1ZPVW5VWjVIRVAzYnRoeElOOUhWdXJWZm5IYmR1cUV4ZEdZMFBiVEJl?=
 =?utf-8?B?K3gyY0xaZWlYM2lWQStKdWZIMFZ1NGNCaXhXa01USDlEb3BVRXZoYTVoRHZz?=
 =?utf-8?B?bk5PVUt0M3dQWCtkQ2V6R0JQaXFnNCtlSHZJVmhvL0hJSUpqWXU2OVZEM2o3?=
 =?utf-8?B?UnpMWkxrWWNldHFRNi9QOUZONEI1dkJydkRyMWI2M1FJZEhIcHdBOExDTVhy?=
 =?utf-8?B?c2RZY0dNczIxVUFtajlIRUtqR2NzanhQMkgzQ3ZyNFpGYXpkU0ZNMDFBRTBT?=
 =?utf-8?Q?jsSCfKGTmcc/tdX/nPeq2E68+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AAE02EBC09F7A41A6835FB5188DB120@EURP194.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lenze.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3a67d3-f731-4049-1a48-08dcc77102b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 14:52:17.0195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 37cf0ce8-ac09-4e7d-9ff2-f1da44914b3e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+gMlJsZopGB98keQgkJz8ed6zp/4FVZW9Xd4zETndDHksIzK0jir5tOfBua14zTvn9jGISfwTzyiH94nYYs2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P194MB1517

T24gV2VkLCAyMDI0LTA4LTI4IGF0IDE2OjAyICswMjAwLCBiaWdlYXN5QGxpbnV0cm9uaXguZGUg
d3JvdGU6DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2Yg
dGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBz
YWZlLg0KPiANCj4gT24gMjAyNC0wOC0yOCAxMzoyNjo0MiBbKzAwMDBdLCBCcmFuZHQsIE9saXZl
ciAtIExlbnplIHdyb3RlOg0KPiA+IEhtbS4uLi4gSSBzZWUuIFdoYXQgYWJvdXQgY2FsbGluZyB3
YWtlX2lycV93b3JrZCgpIGRpcmVjdGx5OyBzb21ldGhpbmcNCj4gPiBsaWtlDQo+ID4gDQo+ID4g
ICAgICAgICBpZiAocnRfbGF6eV93b3JrKQ0KPiA+ICAgICAgICAgICAgICAgICB3YWtlX2lycV93
b3JrZCgpOw0KPiA+ICAgICAgICAgZWxzZSBpZiAoIWxhenlfd29yayB8fCB0aWNrX25vaHpfdGlj
a19zdG9wcGVkKCkpDQo+ID4gICAgICAgICAgICAgICAgIGlycV93b3JrX3JhaXNlKHdvcmspOw0K
PiANCj4gdGhpcyBtaWdodCB3b3JrIGJ1dCBJJ20gbm90IHRvbyBzdXJlIGFib3V0IGl0LiBUaGlz
IHdpbGwgYmVjb21lIGENCj4gcHJvYmxlbSBpZiBpcnFfd29ya19xdWV1ZSgpIGlzIGludm9rZWQg
ZnJvbSBhIHBhdGggd2hlcmUgc2NoZWR1bGluZyBpcw0KPiBub3QgcG9zc2libGUgZHVlIHRvIHJl
Y3Vyc2lvbiBvciBhY3F1aXJlZCBsb2Nrcy4NCj4gDQo+IEhvdyBtdWNoIG9mIGEgcHJvYmxlbSBp
cyBpdCBhbmQgaG93IG11Y2ggeW91IGdhaW4gYnkgZG9pbmcgc28/DQo+IA0KDQpUbyBiZSBob25l
c3QgSSBoYXZlbid0IG1hZGUgYW55IG1lYXN1cmVtZW50cy4gQnV0IHdlIGhhdmUgYSBzeXN0ZW0g
d2l0aA0KKnZlcnkqIHRpZ2h0IHRpbWluZyBjb25zdHJhaW5zOiBPbmUgdGhpbmcgaXMgYSAxNmtI
eiBpcnE7IHRoZSBvdGhlciBhDQo0a0h6IFJULXRhc2s7IGJvdGggcnVubmluZyBvbiBhbiBpc29s
YXRlZCBjb3JlLiBTbyBpZiB3ZSBhc3N1bWUgfjJ1cw0KIm92ZXJoZWFkIiBmb3IgYW4gaXJxICh0
aGlzIHNob3VsZCBiZSBtb3JlIG9yIGxlc3MgdGhlIHRpbWUgb24gb3VyDQpzeXN0ZW07IENvcnRl
eC1BOSB3aXRoIDgwME1Ieikgd2Ugd291bGQgc3BlbmQgfjElIG9mIG91ciAyNTB1cyBncmlkIGZv
cg0KdGhlIGFkZGl0aW9uYWxseSBpcnEuIE5vdCByZWFsbHkgc29tZXRoaW5nIHdlIHdvdWxkIGxp
a2UuDQoNCkFkZGl0aW9uYWxseSB3ZSBtYXkgZ2V0IGFuIChhZGRpdGlvbmFsbHkpIGxhdGVuY3kg
b2YgfjJ1cyBiZWZvcmUgb3VyIDE2LQ0Ka0h6IGlycSBjb3VsZCBnbyB0byB3b3JrLiBBbHNvIHNv
bWV0aGluZyB3ZSB3b3VsZG4ndCBsaWtlLg0KDQpXaGF0IEkgZGlkbid0IHVuZGVyc3RhbmQ6IFRo
ZSAiSVJRIHdvcmsiIGlycXMgYXJlIG5lZWRlZCBpbiBvcmRlciB0bw0Kc3RhcnQgdGhlIGV4ZWN1
dGlvbiBvZiBzb21ldGhpbmcuIE9rLiBCdXQgaG93IHdhcyB0aGlzIGRvbmUgYmVmb3JlPyBJdA0K
c2VlbXMgdGhhdCAic29mdGlycXMiIHdlcmUgdXNlZCBmb3IgdGhpcyBwdXJwb3NlIG9uIGtlcm5l
bCB2NC4xNCAoZG9uJ3QNCmFzayB3aHkgd2UgYXJlIHVzaW5nIHN1Y2ggYW4gb2xkIHZlcnNpb24p
LiBCdXQgSSBkaWRuJ3QgZ2V0IHRoZSBpZGVhIG9mDQp0aGVzZSAic29mdGlycXMiLiBBcmUgdGhl
eSB0cmlnZ2VyZWQgdmlhICJyZWFsIiBpcnFzIChlLmcuIElQSXMpPyBJbg0KdGhpcyBjYXNlIHdl
IHdvdWxkIG1vc3QgbGlrZWx5IGhhdmUgdGhlIHNhbWUgY291bnQgb2YgaXJxcyBvbiBhIGtlcm5l
bA0KNC4xNCBhbmQgYSBrZXJuZWwgNi4xIChvdXIgZ29hbCBmb3Igbm93OyBJIGRvbid0IGxvc2Ug
aG9wZSB0aGF0IGV2ZW4gYQ0KdjYuNiBtYXkgYmUgdXNlZCB0aGUgbmV4dCB5ZWFyKS4NCg0KQW55
IGlkZWFzIGFib3V0IHRoaXMgYXNzdW1wdGlvbj8NCg0KPiA+IFNlYmFzdGlhbg0KDQpPbGl2ZXIN
Cg==

