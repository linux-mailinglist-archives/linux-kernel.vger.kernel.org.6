Return-Path: <linux-kernel+bounces-553834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1E8A58F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 888137A4F89
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6E92253B7;
	Mon, 10 Mar 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DhzPhhRx"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF91224AEB;
	Mon, 10 Mar 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598828; cv=fail; b=QsWm++gV6u2FVfbdNhus/hjeCEGfKFkUQv61E0qGAhC1d9t2KT+aEAJPrNLqVYHK0fpwdB0bPtDVd50dVCTFkGTLHShHESpbkGxdwM/Oj48SMdNoYOwqMFxDrLzKaj2H3IAILkf0AP4prvzcWkgOy3cwCJ4FGal/CDbrTYDBavo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598828; c=relaxed/simple;
	bh=tUM2FrYH1Rtu2oRL9GwN5qLjLkWB6t06RSadNz8BMms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rG1VzHDTlGZAb+btnP1zAXG/KOWQaXLk8o8ZCflMKCPrD7kHUCtmMPJFN3Zr8fr8gxUf7rwFas3SUK2gm9rIDL9LDDM+SvO9WVPASF7qqcPRClseawOl8hxr7BLnH9hwolbxC2AhDZ7/cFItEqNiyUbH+6qTrHAirbT/gvtXsGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DhzPhhRx; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A7ESrt012120;
	Mon, 10 Mar 2025 05:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tUM2F
	rYH1Rtu2oRL9GwN5qLjLkWB6t06RSadNz8BMms=; b=DhzPhhRxKJ+CbknzUMfQ6
	NRYELVUejtrGwlhSr6ToK0Unem3TcZWGbImwvjX99fhLLf22sDmxCEzyuDsfBxNB
	fFTjJ+NkMVD6tuXHVL5nQBrf4cbr9TVLSYhN2CkJDTqZbB3d69l/Htdf7aQTAXxT
	7qJRCzqFoSPoDwDT+ZrpsLgfJc4M0+jTtmQUA+PDmPUMUmH1Kiol4Tin7dbqw7f2
	iILysgUjXPpbqDtDuGjAcuxV8iJSe2US7DBWgnBSVZb5LEOLCap7PxWIrC8zw9jI
	2atnExCoKhzWaQjVrDinP0du/edIZxe3arrVrwdzAZqUasTli0qXAOoVoS68qeU6
	Q==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.11])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 458gme02k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 05:26:50 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wj8Sh7l8b/P/oAADN8ucYzWD/lRnDa47v9V/sLqFYw3mPxUcHNA3DhA8Cji6SO1lNJIc51l0Ftcb6Co9MkIPChIZz2K+tV6QymhgLPztud22KeRHqzZbTo36tFt1UZs7Dbt5fH6NO1dIZWjBvc2Pk05NlZIlHYC+wtIsRSAi7rYUgswggnAlujYZ4uXHwwPvZvgrv5K5vwCaLhN8oZfNeScHoP03lws4PY1PyzuBwNY3Fql0/bRMztWasYJFtFIBsQzAHEhXCCLIuqtHcb49BesBnMrdfQd+LL+lA2D95xbQFExwETrnMee07fEdCH+wLyNXFCbuV6CGArtPvLeJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUM2FrYH1Rtu2oRL9GwN5qLjLkWB6t06RSadNz8BMms=;
 b=Nj6YhJ4dNacpJHLjpXhMGc1cx9Ufnz8a3w5cDgZMbnAEHcELLHlW3fzTUqMvx21XldAQvQxHvN1H5qb/UyMj7AG0l3+jMCO8yYabBV33VEL12mhZQYjLGDo817DqO+2+OL3ILMGOUBCjDCqb6fsV/5bYdlNWlYi3DJIAVmUKF7EYYZU5tvMjzoRTCTLb7DBTszatrTjLlBz/37wsi5T4tAxQlrHigBZW3HLSfIgq4tu4BpFME1ae3zEICsaB3DrMBcYlnK35MfobHMxjrRBHe2P5a9cFwOnWrW7J8d2sRLySEPc0l9erPEWM7FMHx14JNeme4iWGm0Ep2q1pRhbVzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6376.namprd03.prod.outlook.com (2603:10b6:a03:395::14)
 by CO1PR03MB7868.namprd03.prod.outlook.com (2603:10b6:303:276::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 09:26:48 +0000
Received: from SJ0PR03MB6376.namprd03.prod.outlook.com
 ([fe80::9515:1981:b065:d4bc]) by SJ0PR03MB6376.namprd03.prod.outlook.com
 ([fe80::9515:1981:b065:d4bc%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 09:26:48 +0000
From: "Libetario, Kent" <Kent.Libetario@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: hwmon: add adi,max42500.yaml
Thread-Topic: [PATCH 1/2] dt-bindings: hwmon: add adi,max42500.yaml
Thread-Index: AQHbWDxnm7N4AyX3SEmSXSf1Hj28A7Nshr4w
Date: Mon, 10 Mar 2025 09:26:48 +0000
Message-ID:
 <SJ0PR03MB6376EB36C0C192181A32EE7AE6D62@SJ0PR03MB6376.namprd03.prod.outlook.com>
References: <20241220012003.9568-1-Kent.Libetario@analog.com>
 <20241220012003.9568-2-Kent.Libetario@analog.com>
 <bsxt5jk7snbweg6ocnlizsmmvlts5rmmpxxwpqqn75kqtperoa@u4faqhvioqon>
In-Reply-To: <bsxt5jk7snbweg6ocnlizsmmvlts5rmmpxxwpqqn75kqtperoa@u4faqhvioqon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6376:EE_|CO1PR03MB7868:EE_
x-ms-office365-filtering-correlation-id: 8085b6c9-27a6-4672-0666-08dd5fb5aede
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QW52bzJmTVB6YWluRnlVTUxyL1FuTkxsdHllK01EUlR5TzdpMitaODBKdU9S?=
 =?utf-8?B?WFpBaU5GRWZVWENsZGE1MkFlTDUyay82RWNkVm02UWJxc1BiYURRRWUvWHd3?=
 =?utf-8?B?WmRtbHo0aHNGaS9RVnZJZ2poOExGR3JnazYyYzVpbVlhd08yb2d2WWJIZWQr?=
 =?utf-8?B?MWRBYTllWHlFdk81ZWxBVU1VVitHTDl3VmRXbjhPN3hXejBKb1BqZXNNbDRr?=
 =?utf-8?B?TmJBUEw1c0MzZ3UxaHZHdktpQTU3a0xWOUZwYVVNZjFUdnlVMld4K29LVTFE?=
 =?utf-8?B?VkdEVjJZOWZFRXBLdzdVYTl3OFFEZzhMNStkb085RnNFUHp1Y2xFS0FueSsz?=
 =?utf-8?B?SDVsL1pJRTFpbHNFb2xDSFdGRTNqMFFDaEg1TUNndjZpSG4rRzAxU1NnRkdi?=
 =?utf-8?B?eE1ramRla1NLb0NibitvT3RHQlB3UzB0eDZQZTF4am54TWNWYk5EVm0vN3VN?=
 =?utf-8?B?Q1ZzVzVnaE5VZjI4TmhJaHVMdkcxYzJjNFJoRlpRN2xoVFptcU5IVjRObUNi?=
 =?utf-8?B?bW1CQzBsVUx0Z1hFNGpjRDZ5S0FOaHExVTFhYUpJNCtNaXpvRUdwNmV6bGFG?=
 =?utf-8?B?bnpBbnpzaDFaeVJGMnhJRjRwSXdmK2VFMDdOOHBsc1pkV2xoMGhKWFRyMEs0?=
 =?utf-8?B?amtpL0ZDWm4vaU5jd3pTcjRaYzJYdVR5NXg5VkhwT2tqQU1jZm0xMEtKdUhN?=
 =?utf-8?B?ZzU2QWR5bkM0Q1AzajlLTWZHZ0UrcW5lbTNwR3FrV1hjUWtLL2toSnVHc05n?=
 =?utf-8?B?dUFWdmFvbmp4V0l1UFNrbWVDWVExemNNaVBKcDY2Y3pwRDFnRUNmWkZMaFdu?=
 =?utf-8?B?a2hNb21tSFpaSEtVc2t4WkczU3ZBcStRVjFXVURYR2pBTnFwYU1aZGgzZ0pW?=
 =?utf-8?B?MnlBa01ZS2QzRmJCOXhxNGs3Y3ZuaVM2MlZMcXh1Q2dCT3ArYms1RkY0dFJZ?=
 =?utf-8?B?R3VQS3pFNytzNThGVDlMcEVObnFKcjJ2SUJvS21LNFNYdDBlN2ZzUmhZbGdK?=
 =?utf-8?B?U1BaMjNVK0Q0VkFpRHI0Y2dBQmxieDRWOHZ0UndDU05oY1BBNEtmTzZxSUhu?=
 =?utf-8?B?WVVEVGxueklxNFd1NVJvVXQwOFNSdDdKa3UwUzhsVVlaWStBRSttanBTZjVn?=
 =?utf-8?B?aTFrSUE2WS91V05HRjNQS2QvUUNFeUN2WGF4ZUwzcVQ0NTJTcUVSM0N2ajRV?=
 =?utf-8?B?TUE4Q3BuQWU1Wi9pSG0ySk9ZQkNYSWdhbjNQSUsrZGpIUGxhT0xWdjc3SjFW?=
 =?utf-8?B?QTRJWGM2bHI3RjAvd0FVOGU5MnQzM0pGeStnQm5VcFpFWXpTM0lwZUlsUnNp?=
 =?utf-8?B?eWZIZk5GY0tYYzk3bGFwNWt1WUdmMFJ3SVhLcTdQRTBQWm5XclQyL3hMbkpU?=
 =?utf-8?B?T3ZnUFV4WXdWYytkc2FCYUNGVjM4M3dBTWRtUUlwNTROTGYyTmdGVmtDeGll?=
 =?utf-8?B?cjNTOTh0ZjN4cVNJeFd0bnp5RVdzWVdRKzBkM1czTGo2dXRWWk1LOWNJY0tm?=
 =?utf-8?B?d2tCVTJuOFY1Q25YSEcwczc4UW1HendYNVR2QVFiSElndzlHQ0lOejZQd3pM?=
 =?utf-8?B?bjdSMjBSQkhrSlZvbXdEclFjbDZ3dFBoK3hsYVZ5eWJ4NFJGSE4rYmZyUlMv?=
 =?utf-8?B?bisrRkFCRWVUZ3Y4NFQyaHV6R3FrNjZvWkhXTGN2M1ZUVGxUbkE3ZVRoM01t?=
 =?utf-8?B?S0t2a3ErUjA3VmxjRkd4ODh5RTNCdTRTQjV3RWdsUC93RGhCUUJ2c0kwZVYx?=
 =?utf-8?B?NktvdWRySFVlTWovRjUyNVpSRTYxOE1iQ0NEeFFxTEZ6US9IR3VUVWZGRUli?=
 =?utf-8?B?VWpCb29SelVtWnRXSDRpUk9CZWp3ZHJKMEo3Ly9Hb1F5VzRiNFFZWE56L2RM?=
 =?utf-8?B?SE1kRXU5WDZwTEZmRHhuTFl0QlhnOGYwL1A2cWduZ1JmNlRCVkJVRm9DZmpC?=
 =?utf-8?Q?30itRYr2+PZRMZowzvPs7pnIUbso/I0V?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6376.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlltazR6UHV1YWdyWWlRQ3duWWMwd29lVVJvOG9mR0I3THJmc2xTZlV1VVhI?=
 =?utf-8?B?TDYwWHdCZG95ZHIrTzh1dGRVUGFUK1IvOXpEZ2wxbllGRnl3VkhoQ09jMjFp?=
 =?utf-8?B?TFVtbGQ3OWhIcnc5WlpDOHZyUnRhV2NwZGo0dFJhQ3NpTkI4bklqUmhDOVFL?=
 =?utf-8?B?RDM0OUtBVzZTa2p4Y3A1ODFNTTBzTm9mT01SV2JTVGpFejFQaHBwZVFCb0Nz?=
 =?utf-8?B?NzkwVXU3OGZ3K0p3ZmU4MHJ1OXc0T0UySm5HK0dEdENKN0JYZTZJaCtMN3Mz?=
 =?utf-8?B?MGUzM3NudDU2WFpkaFl5eEFPSGNpUi9Ja0k1TVRkZVVxODZRSzFiVFhlc25J?=
 =?utf-8?B?V09JaHdPK0k4VXNJcjFlYnJpNUZFSmY1YU41MkJISzZMOGh6Z3o1V2xYeWlw?=
 =?utf-8?B?TGRHTldVeGd0UDRLOEtsRytleVRMaFVBbTBhZExTMWhkcERlUzFCVGZBbG1y?=
 =?utf-8?B?cm1kUVFzNHJwQ3p5akxwaWsyem9pR3JYWTgvL0RIQ2h0Wmxab0FhT2t2UmVm?=
 =?utf-8?B?REtqQk9jc1Q4WEFuZmh3cTE2RmQzMmkvZml1a2tRYkpKRFE1VGhRZ1BQNHJv?=
 =?utf-8?B?c0treHczd2NUdXRTd2d1Z1RIL0xRaWN2TTg0T2N5T01Lcm1OemlySUloNnQz?=
 =?utf-8?B?YTZDNm4xNzdUQU00QVZVQ0I3S3h2OGNBK0kvS2JKYWx2Y0pLZ3N3ZUpPN05Y?=
 =?utf-8?B?RW04VDAySnJRZS9IajJ0UzIyRnJHdEZ5ZitjbWxkQmJUZVdXb0xvWFJLUXM3?=
 =?utf-8?B?WVBqZ0JpRDlseWNQcGVJMnBFVUxKWXdZTWJZOG9XK1I3c2szdWNKOXFzdzVr?=
 =?utf-8?B?clMzbUIwNldoRFFwSG9FWmhXQ0YxSzQwMVBYMmE4V0VpRHAraEJkcmRScUZX?=
 =?utf-8?B?WkdpMmJiT2xyWVlXWEpzbElCeGx4R1pBNkZIWVQvaVk5OW1ha1hWUk0wSEhu?=
 =?utf-8?B?ZnA2ZjRxblVDNmgwY0t5WmgzekExSC9WVG83RzVWajhaUldnTXlkY0I0WDZy?=
 =?utf-8?B?cUtLWmgvbkc4Skd0ZW16R1NsaHBjSWZYMUN4K0tqeFo2RDRQQzk1a3FtM043?=
 =?utf-8?B?SjNuTjNBVjlVcFN0M2FnbGlQVHRiS2tiU2F0eGxPV3ZyaW45ZVVDc0FvRFJj?=
 =?utf-8?B?WWNoRVJocTZwa1pyOVBXQnM1SThwMzU0K05IR2NWc3FkeS9PZFRCSWZtaDZO?=
 =?utf-8?B?aXp1cDZ2dTBydFhFTFNFVGdJb0MvUGsvNmRoZWdURVZGcytNTmcwZ1R1SS9a?=
 =?utf-8?B?ZkpsWUE0a3E2MnppRjZCREVGOW9ZVmFqMUVvbW1ueGJPLzZxZ1I3WEEvRDNR?=
 =?utf-8?B?NVF4bXZHeGtna0hwZlozakxjcXRRTVVSQ0hEOGJWWGVibDN3VHFBczhVeEds?=
 =?utf-8?B?MTNBdm9Xd0ZyYzA3T0l4ZW53YUQ0SnBjd3dLdlFKR0I3ZTZYbHNlZzJsSFVD?=
 =?utf-8?B?Rm5xVXRaSGxGNCtaelhKZDg4c2NyTGJlZVd4akV1aGpTVlk0di9xK2JZQ0pn?=
 =?utf-8?B?c2s5MVRNQkJ0a1lRWjhRejh1OEltY3VQNTNMcEZtVWpTdmtyeGJ4eXRialZR?=
 =?utf-8?B?WEIrUFFsREFtek1udjZoVWFMTzZ0d0lyeW51VDBibzJmUkdiZEhuMnFqeGxM?=
 =?utf-8?B?TEFjZzIyeEk1UTBtZnRWNEVxNEFoSkp1b0lWYmt5Q3RJcWZPZ0phL1hzOXdv?=
 =?utf-8?B?cDZ5ZGwraWtkdC9YTXB5TjhxTXl2M3VVUUZ3OUtxMWh1NHZKTHNBN292eHEy?=
 =?utf-8?B?R1VWRFpXd2ZPb0JCYkFNaWxsMGlYWnhUaFVER2pJU3VZdnJXSTlnTWIyd1Zi?=
 =?utf-8?B?bGgycGkwQis3MGZrdnFpNlJYODdEc25DZjFCMnZ2UjBSQ2xqdExGc2F6czFT?=
 =?utf-8?B?ZSt5blJKTlYxRlF4SUVpNFhuenUwV2JZMDdpUEljRHFRSFp5RG1vd0hVOGJs?=
 =?utf-8?B?WDAwVWU5dk1kWjcvVXQ2ZW9pbThRcTd4K1gzNlQ5ZUhwNVJRcWJTa1R1SUc0?=
 =?utf-8?B?V0VCVzlCRklad3E2UXpCSERtSS92NTNPSjlpR29iamVIUzJIQWxKdWhDY3lh?=
 =?utf-8?B?REl6SHQ2cGxoV25YVTdkM21tT3ZubjBMTjJSTDlPcnYvemdPS2REL3R2Wjgw?=
 =?utf-8?B?bUh3c3FnYTE5K3ptLytwOFpUdU95Q3ZzQmpZdjBjVTF5dU1yNHlidGR4Z2xI?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6376.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8085b6c9-27a6-4672-0666-08dd5fb5aede
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 09:26:48.3629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQ2UgL/B/mx2XRt5Ube2ZIlk19woKtac49P87OqtLHCeAOCY4fUgFRhI7i3qurYwTGm9yuiUAQUH9UnNKIbzvpk4+5elj+k8toS4oFPBbiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7868
X-Proofpoint-GUID: n3KmDkYf1tX7cjYgSC_XFKqOvhuqTqC4
X-Proofpoint-ORIG-GUID: n3KmDkYf1tX7cjYgSC_XFKqOvhuqTqC4
X-Authority-Analysis: v=2.4 cv=S7QjwJsP c=1 sm=1 tr=0 ts=67ceb05a cx=c_pps a=XJbScVYJ+YTk0JuXi+vtpg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=iox4zFpeAAAA:8 a=_jlGtV7tAAAA:8 a=G1NW02Wz23pCcY45t_sA:9 a=QEXdDO2ut3YA:10 a=VYcpXjmDHnEIALPoEwzu:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_03,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100074

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDI3LCAyMDI0
IDQ6NTEgUE0NCj4gVG86IExpYmV0YXJpbywgS2VudCA8S2VudC5MaWJldGFyaW9AYW5hbG9nLmNv
bT4NCj4gQ2M6IGxpbnV4LWh3bW9uQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKZWFuIERlbHZhcmUg
PGpkZWx2YXJlQHN1c2UuY29tPjsgR3VlbnRlciBSb2Vjaw0KPiA8bGludXhAcm9lY2stdXMubmV0
PjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4g
PGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBod21vbjogYWRkIGFkaSxt
YXg0MjUwMC55YW1sDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIERlYyAyMCwgMjAy
NCBhdCAwOToyMDowMkFNICswODAwLCBLZW50IExpYmV0YXJpbyB3cm90ZToNCj4gPiBBZGQgZG9j
dW1lbnRhdGlvbiBmb3IgZGV2aWNldHJlZSBiaW5kaW5ncyBmb3IgTUFYNDI1MDANCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEtlbnQgTGliZXRhcmlvIDxLZW50LkxpYmV0YXJpb0BhbmFsb2cuY29t
Pg0KPiANCj4gV2h5IG5vdCBhZGRpbmcgaXQgdG8gdHJpdmlhbCBkZXZpY2VzPyBBcmVuJ3QgeW91
IG1pc3Npbmcgc29tZSBwcm9wZXJ0aWVzLCBsaWtlDQo+IFZERCwgRU4gYW5kIFJFU0VUPw0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KWWVzLCBJIHdpbGwgdXBkYXRlIHRoZSBF
TiBwcm9wZXJ0aWVzIGFzIG91dHB1dC1vbmx5IGluIHRoZSBob3N0IHRvIGNvbnRyb2wgYW5kDQp0
cmlnZ2VyIGV2ZW50cyB0byB0aGUgZGV2aWNlLg0KDQpCdXQgdGhlIFZERCBhbmQgUkVTRVQgcHJv
cGVydGllcyBhcmUgZml4ZWQgaW4gdGhlIGRldmljZSBpdHNlbGYgYW5kIHRoZXkgY2Fubm90DQpi
ZSBjb25maWd1cmVkIGJ5IHNvZnR3YXJlIG9yIGRldmljZSB0cmVlLiBUaGUgUkVTRVQgaXMgY29t
bW9ubHkgaW5wdXQgdG8gdGhlIE5NSQ0Kb3IgUkVTRVQgcGluIG9mIHRoZSBob3N0IE1DVSB3aGls
ZSB0aGUgVkREIGRlcGVuZHMgb25seSBpbiB0aGUgY29uZmlndXJhdGlvbiBvZg0KdGhlIGhhcmR3
YXJlIGNpcmN1aXQgY29ubmVjdGVkIHRvIHRoZSBzeXN0ZW0gc3VwcGx5Lg0KDQpSZWdhcmRzLA0K
S2VudA0K

