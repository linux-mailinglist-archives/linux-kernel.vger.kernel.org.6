Return-Path: <linux-kernel+bounces-210038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C13903E67
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 208B6B243D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E0017D889;
	Tue, 11 Jun 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kAvhgHn5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nEjexR67"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0149017C7BE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114919; cv=fail; b=LHI01fOYvWGOwXCw65dfSJbH5o5dY70lmN/2HnkStVncuokrOBuWCWDkGt/Xz555TKm2tERg7G7tf1u1ebtoCzT5XcqfjeUeWjxXR7BCZ/pDNhwiWPjdMZgnBCosIRwGPDPlVIrF4frYZ1phjv+2xAsw8Eg5+TLrEMT5dhKTlMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114919; c=relaxed/simple;
	bh=2diHHeNusKtvuqLHanPBaNQOH9LzSYotWH6+G4+GU2Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IsqR+4sidMnQbWHoOMLXh7YbrZyIXfIgSrVy548WmqLl4060u5oNjVQvOmBK3FetY2AgRYrZ6lRNPaYan1JM1tK/axJAC7Cz05NQECmDHsJ8d4vkxXdOS2/ummbAeDip4j6xm7Zu9iv6zpE/Ve4asIyAPD2iWdlR8jybA3xuD9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kAvhgHn5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nEjexR67; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B7fSqN012059;
	Tue, 11 Jun 2024 14:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=2diHHeNusKtvuqLHanPBaNQOH9LzSYotWH6+G4+GU
	2Q=; b=kAvhgHn5X03muMZPO1lEQPrEAjrKkDJlAc9UB6KqHupF3yB/c5X6I3Ndi
	csPCFCYEGOgBtzRIDoKlOw+QXLoaQE8u2YRfAIWdcmw0Q6hNGkTyd24Bjk7L2ru+
	P10xaPZby0GZMRe7/MD66DQMnjFysr0+uIdRgUJOjq6ghtXLpqvcfPx0pWfjZZq0
	IKy6tv1gU7n8VRn+gBDQqk/8Cc6yRQRRBv4mlopiaKuEcdfvROPo+c6FW54bIKNn
	rjrayF++AXmyQiCdJtI0L/u8cH97tHhS/8FYLCyIpn1iBuoH4X69TCZYA5noiuLQ
	1SUIm6hEbQVbu8mMIvUjrGHko5Tig==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhaj4xfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 14:08:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BDsAWQ036760;
	Tue, 11 Jun 2024 14:08:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdw9wg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 14:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWDORKX08FCfiMFePHV7c3dLalE32p0/B90F+O31U4ZsMWoD6e2u4fIxZ6D4jY9wKJp/0CYCDnTy7Ml02ichGE8pjOBmw4FUSHhN/lgvp40YfNiPrBoJzkZ2Zs57YoqziVrIUPUnvAhoO+6u/YEkj+I+EL8xyIkZCK6t2kGUcmPlTBUu40VJNTnRpvhlXSRQCiYOx5PY/BLEzj2RccYMpIh5XBYiqNWn9VloSuR5Hsz7srPgNps8ZNC0jOHd2ol/iBTXsGbrPzEywqIPv387F9rAvxKeXeXmjV9GUeDq9mKEhiOdU46AJDb4MyTDkNbK0h1TWZsljt0EPKQnlvyudA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2diHHeNusKtvuqLHanPBaNQOH9LzSYotWH6+G4+GU2Q=;
 b=FbXn0eMwf0+nX2uNaHSkPrcwIP3OPXfuI93PGKmuTVojSDRQ6nIPCOvo19WzRHPHhAQ2nJub5mEon4CjJnuwKtcI90xCIySy+7jBeQgErdtqc7chwiXhCSeLkBgXlGjJCpTLDIMPH5GlPai7CxRNmgQTS/cadxa7Ise9lOTA0FuxKe0syAQme1ROtf5ccJxLdCOot8ZAyYluubMpRr6uce0WTTdGD9caSO6B4kq37IY3viFXbE43RVMhFOxG/Y0sWyZpNkgxJsM0WYuOOkyyOyqKA038MkgpP+e+x2vk5i+oj6P0Qbh/7FF7oLfBPUZzbSOq5jDo/1fZ2VEg1qZhFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2diHHeNusKtvuqLHanPBaNQOH9LzSYotWH6+G4+GU2Q=;
 b=nEjexR67KnSqYnuZUMop8y/66i+hIgVxfrYFrgfKANCSsk9sijFAu+INiGHkeID26mrLMFPYfTxPgLqwMX/AMND+tAIO7I22XiOteFDzk4xaMxh+IXm65x/F8sByLIPKpaDePnhdAyaZxTbA+hSzJ1PSzAZlEhPz61ejdvFZQuY=
Received: from CH3PR10MB7762.namprd10.prod.outlook.com (2603:10b6:610:1ae::7)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 14:08:26 +0000
Received: from CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9]) by CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 14:08:26 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: "jeffxu@chromium.org" <jeffxu@chromium.org>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Keith Lucas
	<keith.lucas@oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Andrew
 Brownsword <andrew.brownsword@oracle.com>,
        Matthias Neugschwandtner
	<matthias.neugschwandtner@oracle.com>,
        "jeffxu@google.com"
	<jeffxu@google.com>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "sroettger@google.com"
	<sroettger@google.com>,
        "jorgelo@chromium.org" <jorgelo@chromium.org>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: Re: Re [PATCH v5 4/5] x86/pkeys: Restore altstack before sigcontext
Thread-Topic: Re [PATCH v5 4/5] x86/pkeys: Restore altstack before sigcontext
Thread-Index: AQHauGKRsi5M+37X+EC5+PbkNn0mn7HBjg0AgAESyIA=
Date: Tue, 11 Jun 2024 14:08:26 +0000
Message-ID: <C89ABF81-0EF8-40CB-8B04-B71868B79316@oracle.com>
References: <20240606224035.3238985-5-aruna.ramakrishna@oracle.com>
 <20240610214446.3380115-1-jeffxu@chromium.org>
In-Reply-To: <20240610214446.3380115-1-jeffxu@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7762:EE_|SJ0PR10MB4527:EE_
x-ms-office365-filtering-correlation-id: 37d36982-9a00-4bce-480b-08dc8a1ff681
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QzR0WmZiVDZFb01POTgxNFcydHBtU3Q4MG04cEUzUTM1QWxiTnJ2RUdpM0hF?=
 =?utf-8?B?QnN5Nmg2SnJTU1FqR0ZUUVh0U0o0V1JTclZYbnRmYkorZVJwUW1YeUxZdmJu?=
 =?utf-8?B?TkM5Z1B0N1I0ckNMYUdDSUM2THFaNUk4UDRlT1QzdUJObnBZYUdDOFBaTmhP?=
 =?utf-8?B?bWRsdUQyRDE3OFExa2Vibmw3clZKUWlJVnlzbXA1dUJZSUM2Q1E1QmZlT3Fv?=
 =?utf-8?B?a3VtRFBQb2NzS3Z1eDljeFNEMUNZUE1HRWpoMCtFenFmSGdvV1hIOWZzK0RE?=
 =?utf-8?B?L05mWElrTUZOTVJFdFI5UVdXVXVBRmx1Nnc4clhpdlFPeEpGQWZRU3lGUmE1?=
 =?utf-8?B?Q0VYdnY4VGRDOWg4citWUGFoeXJGSlFCV3RzMEhRc2taN1lHNlFoN21tWnFK?=
 =?utf-8?B?amI0Wk5VbnZ2K3JzMXdGR1hkNGRoTm10d0ZYL0F1d0VJamw2VFR5TjBCa2Zv?=
 =?utf-8?B?dzFnOHVNK0NPVVVOemM0aEI2V1VzODJiYXRZUldaMzkxQUxtbHdkL0RHZ0s3?=
 =?utf-8?B?THRSVmN3WVdSbVpSK1RWR2h1MFdnRVUrREhXQklrV3oydmcwWk5wdW9yZVJH?=
 =?utf-8?B?V2dDbmRBMnAyd2RwL1RYeXEvTmhPWVpoYzFteWp1QytBenhHbW9pS1c2R2ZK?=
 =?utf-8?B?NTVweEI1SHg1Q3VxbzhJc0lra3NXeHRpeE9NYXpYaFQ2YjlRVkZFZk15TlVy?=
 =?utf-8?B?WVRINGN0ZjNEMXYwZ1c5c3FhZTFHc1haZEI0WHEwcWZnb2w0ZzZ1ZTRGdXoy?=
 =?utf-8?B?M0pHV0ZUR1VPQ2g4TW85Mmtua0ZrN3JPdmtYeWc5T2JEd0gvTlZNK0gwT0NT?=
 =?utf-8?B?OXBoNzNOMHo5V0Nwa0hYNm5ZQklPY0VnQzdLd2Y2SXlkU29CTTYrWVpXNDh6?=
 =?utf-8?B?dEk2ekQrREZ6MmhvTThlUTBGRmVCUko4V3JsTlkyRjVkYlRSRGJsRzBWbHg0?=
 =?utf-8?B?eDE0bUYzUURhUDU5ZXVuOENTdk1pMU1OblRPUytBN2R5bVBzRktzTW11OVlS?=
 =?utf-8?B?MXN3ZEgzaS9HQlk3SFZERmk5VytHU21DRW5RRVk3N2ZURHZrOWREY2c1dzFB?=
 =?utf-8?B?RUNvYi83eTFwQmNhWmgvb2x1T2NOVTdya1lFbWVWUU9BTWZtYVdsajVoOUs1?=
 =?utf-8?B?ZjVqZlFhbHhqbkszbUE3K2VnMTRaZHFmQTJvanlGOXZMK0VpWXA4TkswenpY?=
 =?utf-8?B?TUJocUxTVkVHSFo5TzN6b21jQnByektoclF1a0xYaDJIKzVFMFFLNCtRV3hJ?=
 =?utf-8?B?YS9ManQ3VGJORzcwSHZoTkRLcG90ZHI4WklOdDVydE5hN1RNK0h0dUsxZ29p?=
 =?utf-8?B?ZUE1cnVTQU1ST2hONnM4UDZIQXlwTzNRZUhpU3BTSjJNNzdWanVaZ1hDMThV?=
 =?utf-8?B?Z20zblltMHpwUUo5dVBPMUpqK1FMNEtDcUFRclhlMUgxOWZzTHpHM24rT1pX?=
 =?utf-8?B?VUg3aDFZSk1RN3gvbUYwdVlXTzN3RG1Rdm5YZXdNcEcvZWxuY2xtMEFXZUdV?=
 =?utf-8?B?WHVMUnBiQTFETjBpa0x4WlBxUEpGc2NoM0J2dUpYZzN1THR0ZXc2T1JweHVL?=
 =?utf-8?B?ZEgwOHEvK3M0OWlSdDZkZ216c1ptNCthWlcydU9TL21ZMmRmQ0kweHlobkJq?=
 =?utf-8?B?VTRMV0d0WS9oSU9zblA2Yy9Dci8zSngzV054VXRManRZWWhrQWljZEVFWnVI?=
 =?utf-8?B?S0l6ZE1EV1VpWDkvOExzTW0vbEJTNk1DazJqeXZsZ2VQVlFXQllCODBpR0l2?=
 =?utf-8?B?eHpBNWdSczlhTkdsQnl1T2o1aUlTNEdlMkF0NnM2MnBBbFZtZDlpNEMxMWhw?=
 =?utf-8?Q?kvtQtHjaHuMmrP8cBUv75+Vd1EmDV+RJWrO/4=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7762.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WDF0RnptNDJieERXZ3V2cGIwZktUdjgrVUYvL3N4bllUTlJYYmlpS0xiQ2o5?=
 =?utf-8?B?WGg4M0lOL3VJMy9YVkZDYTJFOS81eGdMNWc4Sm05NFRyOG9IQUplV0NIUVpv?=
 =?utf-8?B?aXBiMm1mR1ByaXVkYXNGaCt3NThDdnNrQnRqcXBrSjhCTzhCOXE3UlN6L3dB?=
 =?utf-8?B?NnFHcXVybUpGQXlqUGNJckxjcEFNT2tNODhjVnhQWGVpUGtFVzlkaUlJdzVS?=
 =?utf-8?B?cCs5azhPT3FOVE9BVFl1NWVKSE1nWi8rRTI1emRWdnEzL3BXdHZkRFBwelhC?=
 =?utf-8?B?MEVrOW1VbUJRWkNMdTNOcHlkeitWK0MzRWs4d2FqMGlvVW5HV2R4RHdYNU91?=
 =?utf-8?B?eUk4RjY1VEhwMFZwaXU0MU56bGFlR2xyU3h2ZlpnKzQ1TmM2T3F5a2t3VjZw?=
 =?utf-8?B?YldFLzE2blR2VEMvQnByMzNwSUY5bGtnNWhyb05XNVdKUkpMSlF6UjVuZkN1?=
 =?utf-8?B?Q1BrNU1rdlA5YXl3ZWN5S1FPdVhtenFwTVZlQUplTWc5MFYyRnJQajJNYU95?=
 =?utf-8?B?WEk2Nld0dERTb1ZsUnFZNURqM1ZldEJtaWpjVTZMTGdSSzl4dyt4YXZGLzVt?=
 =?utf-8?B?OTNLYnVJS1Vub0Z0ekVjN1krWGJhMkZKZHFJSWxoZ21vcXFHRTVlRmpQblpm?=
 =?utf-8?B?QkhlSXhmUHBibTB2alFJL2ozU2l5WlJ5ZHdKeVhjd1JGUDdZRjAvckw4OTZ3?=
 =?utf-8?B?UHM3UXRmZFJsVmM3VjlTUkNiRWhzWkEwTWNOK1ZUc1pMcXFCWUFTTzV1ekR4?=
 =?utf-8?B?Q1JDWlA4RVJCeXRTWVM0Y1hTOTNlMGUzTGdja252N1FMdVljbktPRytwd1hQ?=
 =?utf-8?B?UTZsS1pTSFN3ZHU5a0VNKzNZbk1WdmtZancvRDYwcDJGWC9LU2RxQ2pxRUVp?=
 =?utf-8?B?WHZVbzhqT0ZBbGcyMXp2R2RNUzdZanpYajUwT3JPSEM4RUVRR3BJUGh3Tm5B?=
 =?utf-8?B?czV3ajdQb3AvbzBFMFRXa0RiZkF2NlZBYUVVTlRjcGU1bERBNWRvQ0lVcWp2?=
 =?utf-8?B?Z1dlakRSUlJUQVVsd2MrTEh0aUYxeDB4WnA2R2VLT1JBamdlYjdXUldDRDFp?=
 =?utf-8?B?aXhGS2c4M3JESDNBSkxYcUNkUU80eXFEVTFjMmticjJraDhTUjAzVXA1NDUy?=
 =?utf-8?B?M3c5T1YydncrRDNjV0ZoTm9BRzZ4RzVoL3lzMUtFbnZlVGduNTFpWGxHYVZ3?=
 =?utf-8?B?YzVUdnVNenRCTkNyeUl3amdoRHJvU0tpQm9nUEE0RnhPejF3Z01HU0ovNmNS?=
 =?utf-8?B?NEFhT0FHLytWMnV0Tkp0ZDc1d01nUmtCYUltMGR1amJyeGxRSnp0MlhSRnNX?=
 =?utf-8?B?OVY4a3RVSVR4clplZDFHbk5SZjZGNjk0MUpQdnI0YmpZUWlaQ0ViZ3had0lW?=
 =?utf-8?B?S0JHdG1wYjdMSWV3eDVVWXNjakw2UnFjY2F4ODFqU3lhU2F3bVpNU3ZKZW1j?=
 =?utf-8?B?VVRveFNhM3kwek1LTWRlU0xoZXJ1Z2dHRWo4ekhFRW9tWXB0SWx3NDh2WS85?=
 =?utf-8?B?N1pNbjEzd1VKK0xrODhxOTc4UmZtUis5akcwM0lDYk1HcEE0Nit1L2V1SGpI?=
 =?utf-8?B?d3NmMGZ2WkdoWEkwQ0p3d1IraHN4b2RNem9hcXVrb2JpYlJ6M1FaeUxOTXhl?=
 =?utf-8?B?bTZsMjVyN0RYZUNUOXVNclhiMXU0SkdqUkUrWmx0NWFtaFJVckJSRVJUdXFU?=
 =?utf-8?B?SmtyNXJDQXhRRlJuanh3Y3Rnb1hvYlRpTEhKTEFBODVaaWRvVXFGL25wTVhq?=
 =?utf-8?B?N0lrSUNXbzBKZXdkTVhNYTBtbG9kOUQybk1FcWtmTVlIRlNLbW9KSTBSeU5z?=
 =?utf-8?B?K3B3WkxwaHZVNk5uVlJLdHZ3YkxVS2xadWtybjRmaG1XaTMxcWYzYWh3eGp3?=
 =?utf-8?B?dkdWeEw5RGMwVjJqRE16K3ErMDJxazVzSnBnVnZIT1NtQU5wK0FtL01HNG13?=
 =?utf-8?B?eWFlN1N3bFNyUzcyNCtzMEdmeE5BWlY1RzFOS0R6bWpzNFpNRHpMWGFCMkVR?=
 =?utf-8?B?K00rQ2o1clRXR21aVHNCUTlqT3ZSeE84K0RkaFJReWdaVXJrL01zNWFRK2dP?=
 =?utf-8?B?Zkl2d1NrNHNFbVhsMjRXa2VTUmMrbk9jUGFNNE1SWllTN21PcVRkOUpvRWFW?=
 =?utf-8?B?NTlsRWNZNmFmcHgxbmZ5MmYrenZNQ090Ym9uVWxBLzNVR29iZC9IcXNnd2Fi?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAAF330BABFAA342A868841F07C4067D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	V7pmJ4pmusLgV4q+lc/xLDo0vwKxRMKjZcc9hmjrXMRNH8KL9mfos/xVLdcTyuJGJb/eR2F9WnO/o18bbyojCBxPpAb6+lLvhhb9hmEEWayXQouxGM1Ez9lw8enMHPXomyHsOZT5v5ITSJHHSX2H4wfkCA+VXQA7Pc4joEUPguuezJX1c4c0S18QoYOwbWhstYB4qOkq0PyUigBPAMq8EtMdWqTy7kpOOW4C8yrGYw4ZlLqzY5WWjZ36ti6qEHXRQy/WmumyTdJBRnB8ZGa66F8b1g/mLwJUB9qApJY5iykuMg/olTpXZx0/9NNHEkgw52AywRdDGsI/mixbaEzYom7iuP4iU7WbEwGt79zCxrjHtCZUMLnoiwMgiE7nhOthgF+VmQY3x8FYyAedJeAWLhdQIcoAOHnICpwuCNZxGG5tLF7Y+guKuv4SCU0J421/sEzlDD12dEmJlKIsbljHgHb+TFmuV5euZUJXVlgkaUuLvye3HFY+8j+MEEw5CJq5TlRxl19BgbqNcXWcZWneANv0V36pTA30DNVT2+njG+L6EvdsjOsiHIdFgc+fk+ZydZSr71nRM55RFke6mGR8OlmYIdwhnageg6Ko65x9D5k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7762.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d36982-9a00-4bce-480b-08dc8a1ff681
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 14:08:26.3444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3WkwRgyvO/C/jz2JMeaOnnVqFx12ctu8ezo+DLBGLOGfW/Lsbjoz3YH7sF7INThf3pmn5ir0ok7+tBDh83cdlJ32sRl0WMIL9GjG+OOfMyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_07,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=876 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406110102
X-Proofpoint-GUID: vw_JC7bhhrQd3tFrhWlmuCA_s0OmAaOr
X-Proofpoint-ORIG-GUID: vw_JC7bhhrQd3tFrhWlmuCA_s0OmAaOr

DQoNCj4gT24gSnVuIDEwLCAyMDI0LCBhdCAyOjQ04oCvUE0sIGplZmZ4dUBjaHJvbWl1bS5vcmcg
d3JvdGU6DQo+IA0KPiBDYW4gd2Ugd2UgbW92ZSB0aGlzIHBhdGNoIHRvIHRoZSBmaXJzdCBvZiB0
aGUgc2VyaWVzPyB0aGlzIGNhbiBiZSBhbg0KPiBpbmRlcGVuZGVudCBwYXRjaCwgdGhlIHByb2Js
ZW0gbm90IG9ubHkgYWZmZWN0IFBLUlUsIGJ1dCBhbHNvIG90aGVyDQo+IHNjZW5hcmlvcywgYXMg
UmljayBwb2ludGVkIG91dCBpbiBbMV0NCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sL2QwMTYyYzc2YzI1YmM4ZTFjODc2YWViZThlMjQzZmYyZTY4NjIzNTkuY2FtZWxAaW50
ZWwuY29tLw0KPiANCj4gLUplZmYNCg0KRm9yIHRoaXMgcGF0Y2ggc2V0LCB0aGUgaXNzdWUgd2l0
aCBydF9zaWdyZXR1cm4oKSBpcyBvbmx5IGV4cG9zZWQgYWZ0ZXIgcGF0Y2ggMy81IC0gaS5lLiwg
d2hlbg0KY29weV9mcHJlZ3NfdG9fc2lnZnJhbWUoKSBjYWxscyB1cGRhdGVfcGtydV9pbl9zaWdm
cmFtZSgpIHRvIHVwZGF0ZSB0aGUgUEtSVSB2YWx1ZSB0bw0KdXNlci1zcGVjaWZpZWQgUEtSVSB0
aGF0IG1pZ2h0IGRpc2FibGUgcGtleSAwIGFjY2VzcywgdGh1cyBicmVha2luZyByZXN0b3JlX2Fs
dHN0YWNrKCkuDQpTbyBpdCBzZWVtZWQgbG9naWNhbCB0byBtZSB0byBoYXZlIHRoaXMgZml4IGFz
IHBhdGNoIDQvNSBvZiB0aGlzIHNlcmllcy4gSeKAmW0gbm90IHN0cm9uZ2x5DQpvcHBvc2VkIHRv
IG1vdmluZyB0aGlzIHRvIHBhdGNoIDEvNSwgYnV0IHRoaXMgb3JkZXJpbmcgaXMgZWFzaWVyIHRv
IHVuZGVyc3RhbmQgKEkgdGhpbmspLg0KQnV0IGlmIHRoaXMgcGF0Y2ggbmVlZHMgdG8gYmUgYnJv
a2VuIG91dCBvZiB0aGlzIHBhdGNoc2V0IGFuZCBzdWJtaXR0ZWQgaW5kZXBlbmRlbnRseQ0KKGZv
ciB0aGUgb3RoZXIgc2NlbmFyaW9zIHlvdSBtZW50aW9uZWQpIC0gSSBjYW4gZG8gdGhhdC4NCg0K
VGhhbmtzLA0KQXJ1bmE=

