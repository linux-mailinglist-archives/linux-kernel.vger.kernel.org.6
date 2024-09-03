Return-Path: <linux-kernel+bounces-312568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02245969848
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270EB1C2321A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9516219F42B;
	Tue,  3 Sep 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="akel0LVj"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3F1C767C;
	Tue,  3 Sep 2024 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354377; cv=fail; b=G8gTPWpLIF5GzP3Mhbn/V/ueH1qm05F4lPrOou/LNch/8boRsx6kr0CMk2rw9EUFh9m6ELK1IxQVaZoKXxSLWf2WKqZT+zlP8/71M6go2pQIr3LGKuFiYxYd88nUMqc9IA9ZDb2oc9ef8rUt+VsrXm0u6CSrYBbN2BeLAVHxrm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354377; c=relaxed/simple;
	bh=MOuoIR+w67dKqN+XbwuPTK6O8MhsHcJgsHgfbWYvF10=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KcSXTqSyBVJvHB/QwhdVTSdRXUJM+3pzFkfMJFWkaqwN6guyQ2Y/vfuIgaCHXf4oPIUOMo/BzPM50PIOgUuu0kCRn8XJTx363gGVDaDHLlx/un9cTp1KOuZvXnRdkPACwNXYjv8SMUzcubk9XrO8oyycplIMNyRUPJWY7EnUnPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=akel0LVj; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DC2t1ailQup5hYVeiGyyO3O539bYDHkIxuGknCxqBclksp1pScOrte1y8oHP2BVTlrCDU/9xvmpcASAERmRHGy6qwkEcFn9XrsmltGyaW7rpCCJT0JpLG23TqjioFURYP3st3SwtzF7UJ7RdfbhUSHlj3SyH53zExRk9qAYgV/s098Ln0amY3VzQXbP7YxCEaTOsVbU5IJ24S7oYYGXDeRo2iW4UK/xeXtkMn3sMQmrhoqKBa52HRfYKFgeiT0Rs+qqstAeZCMovW6m5gwN5xMQs6xt51kNcus/y2Ev4ImTaz+IsH04oBSjM62pVUXYrOnYRWV+KMTD/HsuplyFYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOuoIR+w67dKqN+XbwuPTK6O8MhsHcJgsHgfbWYvF10=;
 b=G/dKdeYCuV9WQO0jL36sn2SgSjH1UlpKKWrJVKKqOFKB7OPM+fNZ/x7LGrn6lhOMV9EZkpE+kAIP0Aqm86px8Zxl3l5nQgJ9BosH2+WykjUDZR5Ketxn+n3tMTzOlHwRQ38TLy9OISMMLDl1FI6QADsTk4mPibkKj+hKPySTIed9qspM0GOWR+oDWFRymVHSaf9wbQYI7+8MRJpnfLxEbjykgQOCbYKDMjJq++JHSD3AE0BHmOdOeIfdYtreuROoGbwd5Du0DQE4CZwNkUOlOuAY983t4yd2hW0mlcBXm2BDy+7dnH0JeXmA4X3PARxDFiDOKfUtrZK90Uz6dPKuYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOuoIR+w67dKqN+XbwuPTK6O8MhsHcJgsHgfbWYvF10=;
 b=akel0LVjZ1RDxJhSAE/5cPXWNwpBOnjkvzLu37QpR0F78wTM1YolLqFwXIpYSBVaticvk6qKtNPK3hVUtfeGwDA8afh3VEZ/H/3MMVMRENDB0SZlRMfkh8wdGVUAj8UVXdwb8KC5+RKMrnba35DCzYfve4+oioEpcRkjFhcXQUeuXVRI07tF/aBzLkmKT+Lzjr5alWt0C4Hg3eIKLKRBBEcY80SwDxLeE1OUYdNFW8GiUIecmTI6HY7YemEpKeyxb7OBtaCo2FiLlFouHs2BRxTHrakxpwttkI/vrAstvMYqbdkX8OBfPdDMt6E2w71bIO6TRqbaHwD1WNEOF6GSvA==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by SN7PR11MB7092.namprd11.prod.outlook.com (2603:10b6:806:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 09:06:13 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 09:06:13 +0000
From: <Dharma.B@microchip.com>
To: <Varshini.Rajendran@microchip.com>, <tglx@linutronix.de>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 03/12] dt-bindings: interrupt-controller: Add support
 for sam9x7 aic
Thread-Topic: [PATCH v7 03/12] dt-bindings: interrupt-controller: Add support
 for sam9x7 aic
Thread-Index: AQHa/cyB57+7Gy/cDEiR8njStl3xkLJFxIWAgAAA7IA=
Date: Tue, 3 Sep 2024 09:06:13 +0000
Message-ID: <da3dcc0a-5586-431b-bfbf-97f20fd2f47e@microchip.com>
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
 <20240903064240.49415-1-varshini.rajendran@microchip.com>
 <44d176c6-eaf2-493b-9fba-81f5bd9dac82@microchip.com>
In-Reply-To: <44d176c6-eaf2-493b-9fba-81f5bd9dac82@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|SN7PR11MB7092:EE_
x-ms-office365-filtering-correlation-id: a76c9d4f-5c8b-4ab4-43fa-08dccbf7a8e3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0dkSjhYMEdzLzhpb1dBYUxpeVV4UURGYU0zQ3hNbDJzMWxwNDJqVHdsdVUx?=
 =?utf-8?B?NXNTcFVsZnZ3b3N0VDFuWERVTlhrOENPdGNWQ09PVlVzL3Z5QlBRWHdwSGxG?=
 =?utf-8?B?V3B4bEhPVTc3THlydVBEVWZxcEx4b1ZlWWVONGw3S25UREE0UmVVOGtvSHNa?=
 =?utf-8?B?YmhKcTB2NnZHVUVidkc0WjVaNUlvTTQzWDhGRjRDQ0FLTnRmbVJxZ3AxY05E?=
 =?utf-8?B?YWg4dnp1dDllL29DSGhQdW1mb2VUdFpOU2V2MUJSVzZmRFFHUEg0WStmdThp?=
 =?utf-8?B?TStaZ21RWXY1ZzZDdVpXZTF3VVVoSXlTVGFrYU1qRVhyTi93MWpLOHkwREM5?=
 =?utf-8?B?M2MyQ05tVUM4dlo4K1RKSDRLT29ZcVhqTVhFMmtnR2FqSzQyOWJoMHVrRGx1?=
 =?utf-8?B?cWRwbCt0Z0ZobFlhQ00xQTh3YWpNcjg4eTdLQnkvY3MvM0lyZS9MejhSVm53?=
 =?utf-8?B?a2JYUmRiV1FzWHR4NTMzZzFJS3lhNHBEZ2JrQU1vQ3ROT1pKcjRzaTFmSm92?=
 =?utf-8?B?SW9Ta1VkenhZZUFEbU9NMjY2aEp1QnVhMk5sQ3dQdk4xM2VxVEgzNjlrYWFt?=
 =?utf-8?B?bFptODFqSDArcDgvbU9MSm00aXNtWlFHb2thUTJDYmRPWmxXa0RwM3Y5azBY?=
 =?utf-8?B?NWx1SHZxSFo2ZjdHYzVuMFdCdDFSVGR4c1paN2p5OWhWSFYvQ0NYRjhpY0xF?=
 =?utf-8?B?R2ZFelRta0RkbXJsSXczdlpIT0pLdFhNOWVQNjQ2S05nbjZmQXFNdkU1ZFcx?=
 =?utf-8?B?eklDZStyMmh2U0k0SXpySE94b2ZESHRrNlFEQ0VRRlQrQndoa21sNHhOWkoy?=
 =?utf-8?B?ZVZSLzhYdnFMSjVtQ2RMWnltWi9USGFKbUNxWXFzNUU0bUp6d1QyQ1pZRGZI?=
 =?utf-8?B?cVNZWkV4MWJCNXZkVk5oaWxCZHhyMVp0eFo2aEZjN0hnTFpwdnRWOUh0cmVz?=
 =?utf-8?B?Tm4xYXRnTnNEYkJoNzZuMUpyYS9vakFMYmxUOC9Fdm1TOGZrVGtEaGQ2SmFB?=
 =?utf-8?B?SzhyTG5kS3lXaEV1Z254Y0Z4RXMxTmU3SFN1dmhVV3NYZTBSUWdsaEQwOTgr?=
 =?utf-8?B?U0tZK0d1SlpEQnZJY3F2MEw2MkhNLzFKUHNiQXlFNXBBU3pyZTV1MU9qNFZy?=
 =?utf-8?B?OGZDRGlIL0JxdDNBWFFLUnFmRSt2Z094MWlzbFNwVTY0VGU5UTArYld6SHhw?=
 =?utf-8?B?M3M1T0xyWlhScDBmRm5CK1hKR0NyZnZwalNzUEhORXhZeWhQWlNVQk9wdVdT?=
 =?utf-8?B?TDRIODF2ODVOMHlXZ0doRjVSb21BbzFaUlo3TWJ6OFF2bm9XUDUvbkNCVmla?=
 =?utf-8?B?bVhzT2c1dU1GSnVyblBsVndONXJrT2sxaXVSNU8rcHlVR2JINlBaYldRc0Zn?=
 =?utf-8?B?LzR4YXJTajF0RjRsd1VmN2hpajZHTUtpVlc4Sy9Sc3JNMkE5bkFnZllpWXdp?=
 =?utf-8?B?NnhIdzBCSWh0aEFGQkdqbVBITmhMd2dnZEk0U0xUOG1CcHhWSnJrUi9VdTJq?=
 =?utf-8?B?cENkeDY5SVNWWGNOanY1U01rVEZ1ZGViMXVZWEsybCs1SGpnUEFaVURFZjVI?=
 =?utf-8?B?dTlRZElBZHZMbXVZaE14MVA2elkvYlcrZlQ2cDVrUU9ibHJtWVNPYXJ6bzlj?=
 =?utf-8?B?QUtrdUVCZ0dRUVpwMlNnZFFMeTlkaDlwU1RqRkdGR0NnTFYyb2pTWWVpZmpX?=
 =?utf-8?B?ZDlJNHRhNU9lZlFHUkRYUllCUExHQ3dzNHVwa0F3REM2RFdSdXh0Q3NyWHd4?=
 =?utf-8?B?aXhmZ3JqN0dsR2d4OWlsVVlCQzRoaUhkdHJ1UUUwTzNWZmREc1hIL1NIZnha?=
 =?utf-8?B?TG4zVUdGbzhzZ2FzN2l1SkdNaEh3dFJXTUZkUys2V2cxTUdCVitKeHVjZGxp?=
 =?utf-8?B?bXMyamNwZS90ZUE5TWx5dExFOVdsRWZucVJnUTBRMGQyVWd3WXVwQ0hKeitr?=
 =?utf-8?Q?s58tBZHaVrQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWNiY2xBTFJIbWwzUlVla3Y3TzQyWkRjWTgyRWFkZm9VTFg0UFU5dkpYaXZR?=
 =?utf-8?B?bS9PY0luMXBTb2dDRldsa1dOTGw0dWJ5cHIzRVRwczN3WlFkUzd6VVpGVG85?=
 =?utf-8?B?S0dHbWJDaHJvUi8xd2hBdEpvR0p0RkF6L3ZzejF1aTR1eFEwWTdiZHhZdEZy?=
 =?utf-8?B?RllWSThhbnI4aWc5bUdSWU1KVUhGVmdPUGRvTFk3cm5wNjh3aXRzSVhoT0wv?=
 =?utf-8?B?Z3JORlZDWlBNV0NJQVhVYnBmWkpSMkppMmlQMTBBY1doYjVCUGVoTTdxOUp6?=
 =?utf-8?B?TXI5V0RISnZVQzJiRWFuMWVhMzhuNnVnN01ZMDJYR3BlZll1NTVkNFdQeUU5?=
 =?utf-8?B?SVBCWWRTYUpvQ3ZGVkM1bC8vRldDMnJOS3BOVXNpb1BZeXM5aHJNdFdSaDNy?=
 =?utf-8?B?TXU2RGMvenhIcDFIdVZYcEIrOWErWEdXbmd0RFk1UU45djUrd2R4VXFQUk9q?=
 =?utf-8?B?cHZGZWJ0dzFUbFhQdHBSREJ2cElpY2hTQ1FiTFNlanQxMWJTNVdFT0NZQW14?=
 =?utf-8?B?YXdvUm1RMitIb3Z1ekJQL3dONE81U29iSHFnSU5oU2xxR3MzWGQ2TmZ4RmNW?=
 =?utf-8?B?VnpmOWJwYVREY0I2T2ZKUUlXOFJUalB2MWdwZWRqUVdYVGMycmZpWDl2dE9j?=
 =?utf-8?B?RkNkNEZia0REVEZ1ZVNUNG1QZ3dXU2tlcm5yckhaTDRRYjdBRmQveGcweDJF?=
 =?utf-8?B?MG9jVGZQUTdwbjl2OVlrYkJPSzZuNGlWRzBEd21iUHBkSUdvNXRKeDZ2YTl1?=
 =?utf-8?B?Z1pKNEtiV1NEUFR4c1BjelNDOTY4dFZQNk05d05pZ0JEOGlYeUhKakkzSkR5?=
 =?utf-8?B?czI5YkxORHFKbXBSUVhSTmZaV093ZEI2bTUweW5kMkg5UnZadEpmNHdhTEFv?=
 =?utf-8?B?ampmZ1RNREtVRHZGb1U1RnYwMXFhVFJWUm1hQ0Q3OG1LbUx0czhNZ21lSWFx?=
 =?utf-8?B?OHZsa3NObzJmaTdBdm03V1lJWlkrUmNUUFlPQVBqVGVSMHUwSkU4TDJCODZo?=
 =?utf-8?B?d0ZaeHNONkFFbVd0WGZXTzV3ZVZOZ2RpSXpTTndCcE9aSzdiMmpTME02cTI0?=
 =?utf-8?B?MkxMT0crdzBlRlVEWDN6Y2UzWldmRnJGU0l6RWFyZUpYU3RBdFBJbnZMUjYr?=
 =?utf-8?B?bEsraTVLZi9rMzQxanoxRllGbU16MlF5U1BSMjdubENHajc3MHdONlBrQjhG?=
 =?utf-8?B?VEFDaWJFMmV4Q1AvU1UrMWo0RWpGWGoya3BIeDBDRXlCblljR281dlBKa1Iv?=
 =?utf-8?B?dDlsN3dGMmlJSEIrSHNjbXpMb2ptckcya1BzaXpQYmRZSHR5aGhmVXdPcU81?=
 =?utf-8?B?enp4UXp2OEtUZVpTU3NFczRBMUh1ZEYzLy8wZGhlendNZTl1WU51VDNPQWZv?=
 =?utf-8?B?MnZtaFdVbi9xb0FkOWZMOFRRSmNRT21vK3hRT3hLeDNxNGk0djdCV0puU0c4?=
 =?utf-8?B?MVcrTkJYcGNlcDRzc09xMjdqNjRvbTcxU2pFS0h5ZTFLaTJHbU45WmpxdzQr?=
 =?utf-8?B?WS9BelFwZnRsNWdjUElIaUtQVDUyOEN5R2x3L0FMM2RWdXNKS1dub21UVWVs?=
 =?utf-8?B?TFpvcmkvRFd5SlQ2SmpzQjlOUlE5VXhmU3g0cU9Da2JJVFRsaU1CYXlGZHJQ?=
 =?utf-8?B?eTNNcW9pUFVxRUgraUFYakUzVGRVdVNjd2Fldk1XVzBlT1FNRTViTVVBcFVD?=
 =?utf-8?B?VlRWVU91aFY1VG5FZmg5alBTalBVR0o3OWN6QWdpRmJCTUJwNVNqNXhNa0lh?=
 =?utf-8?B?bmRLUmdqTDdQaTRoRzRlUWVMcWl2QVdnd0VmMU8ydjFKSmdaYjdvazY2SlhX?=
 =?utf-8?B?a05UaW5PNmtzZjJ5NElhTFVWT3EvK0tScGNuejlRQmw4NTZ0SlUzenluZlZP?=
 =?utf-8?B?ZFROZ1dyWEF4U0h6bkh1QnBCQ2g3M2dvdVBlNlpGZXl2ZDlYN1Jra2l2ZWNR?=
 =?utf-8?B?TDU3SUZGZVg2R3FRS2R4L1N6dU43L3RNeVJRNHV6bXphMHd3Q2MxelFJZDdw?=
 =?utf-8?B?cUp0ZEtUNkNrQUdiVisrVHREK1pWRk84V200WGVtVkszMVM4am0vOUxtYkt0?=
 =?utf-8?B?VVl3RFNjNlhmeTlPWUVFVnFTVnQraEVCUzRFVXp6ejh5bG12ZC90RjJyNzVv?=
 =?utf-8?Q?2ZquHqmtlpkuG/lxs1LV33b9m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <771822DC733C304F95091FD59931D4E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76c9d4f-5c8b-4ab4-43fa-08dccbf7a8e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 09:06:13.0286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/jPWd1Z7J+fCvD23ljV4PpXsfuxTfVG0H6Dw7XtuVo3zGb1c2jmO5X58yeK1hVvVWuk3/zWR+bnnBIsLU3zzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7092

T24gMDMvMDkvMjQgMjozMiBwbSwgRGhhcm1hIEIgd3JvdGU6DQo+IE9uIDAzLzA5LzI0IDEyOjEy
IHBtLCBWYXJzaGluaSBSYWplbmRyYW4gd3JvdGU6DQo+PiBEb2N1bWVudCB0aGUgc3VwcG9ydCBh
ZGRlZCBmb3IgdGhlIEFkdmFuY2VkIGludGVycnVwdCBjb250cm9sbGVyKEFJQykNCj4+IGNoaXAg
aW4gdGhlIHNhbTl4NyBTb0MgZmFtaWx5LiBOZXcgY29tcGF0aWJsZSBpcyBpbnRyb2R1Y2VkIHRv
IGNhcHR1cmUNCj4+IHRoZSBkaWZmZXJlbmNlcyBsaWtlIHRoZSBudW1iZXIgb2YgaW50ZXJydXB0
cyBzdXBwb3J0ZWQgaW4gdGhlDQo+PiBpbnRlZ3JhdGlvbiBvZiB0aGUgSVAgdG8gdGhhdCBvZiB0
aGUgcHJldmlvdXMgZGVzaWducy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWYXJzaGluaSBSYWpl
bmRyYW4gPHZhcnNoaW5pLnJhamVuZHJhbkBtaWNyb2NoaXAuY29tPg0KPiBUaGUgZHJpdmVyIGFu
ZCBkdHMgY2hhbmdlcyBpbiB0aGlzIHBhdGNoIHNlcmllcyBsb29rcyBnb29kIHRvIG1lLg0KPiAN
Cj4gQWNrZWQtYnk6RGhhcm1hIEJhbGFzdWJpcmFtYW5pIDxkaGFybWEuYkBtaWNyb2NoaXAuY29t
Pg0KQXBvbG9naWVzLF5taXNzZWQgYSBzcGFjZQ0KQWNrZWQtYnk6IERoYXJtYSBCYWxhc3ViaXJh
bWFuaSA8ZGhhcm1hLmJAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2NzoN
Cj4+DQo+PiAtIEVsYWJvcmF0ZWQgdGhlIGNvbW1pdCBtZXNzYWdlIGJ5IGV4cGxhaW5pbmcgdGhl
IGRpZmZlcmVuY2UgaW4gSVAuDQo+PiAtLS0NCj4+IMKgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2ludGVycnVwdC1jb250cm9sbGVyL2F0bWVsLGFpYy55YW1swqDCoMKgwqDCoCB8IDEgKw0KPj4g
wqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci8gDQo+
PiBhdG1lbCxhaWMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRl
cnJ1cHQtIA0KPj4gY29udHJvbGxlci9hdG1lbCxhaWMueWFtbA0KPj4gaW5kZXggZDQ2NThmZTM4
NjdjLi5kNjcxZWQ4ODRjOWUgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvIA0KPj4gYXRtZWwsYWljLnlhbWwNCj4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJv
bGxlci8gDQo+PiBhdG1lbCxhaWMueWFtbA0KPj4gQEAgLTIzLDYgKzIzLDcgQEAgcHJvcGVydGll
czoNCj4+IMKgwqDCoMKgwqDCoMKgIC0gYXRtZWwsc2FtYTVkMy1haWMNCj4+IMKgwqDCoMKgwqDC
oMKgIC0gYXRtZWwsc2FtYTVkNC1haWMNCj4+IMKgwqDCoMKgwqDCoMKgIC0gbWljcm9jaGlwLHNh
bTl4NjAtYWljDQo+PiArwqDCoMKgwqDCoCAtIG1pY3JvY2hpcCxzYW05eDctYWljDQo+PiDCoMKg
wqAgcmVnOg0KPj4gwqDCoMKgwqDCoCBtYXhJdGVtczogMQ0KPiANCj4gDQoNCg0KLS0gDQpXaXRo
IEJlc3QgUmVnYXJkcywNCkRoYXJtYSBCLg0K

