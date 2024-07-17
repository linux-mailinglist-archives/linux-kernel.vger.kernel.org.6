Return-Path: <linux-kernel+bounces-255128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC421933C77
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECAA1C22E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AF317FAB4;
	Wed, 17 Jul 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="DYEHsE4H"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B60717F50F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721216763; cv=fail; b=A4xqSfXw4jqYHXB2OAtXpKPe0sOww9pujNflfNaan8LaPeYfD7vP2ZB19wk8D8WXR2ynFmX4Ajk7oRbfToNBv0Ta0tSg6nLcai8nWMO9vGSB9rrub4nvmM1nRuan3LDQhsoUdiLM+dTl70fR6fSmQpgmet5ylhWuAIFtOG6/G0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721216763; c=relaxed/simple;
	bh=UAarv437Lc0GUu99WNIou0+YW9lf58yZY7n2FQNUbYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DHTMycZuYuOQ75Q+j2zHA3u5nCFV5QXg5Oefk+yTxU0Nx9ODr6jtxCCVTDb1uSvdwSTCyCaWb1IckQmXX7omyzPkUPmeNpsqjwYzQTSA5EiL6f87kLr78Z0tb/83fk3AT96pGw4ydclZ21y6VcAxnLHfp9HFuycHaq1WflIh3lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=DYEHsE4H reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HACi2w020590;
	Wed, 17 Jul 2024 04:45:54 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40ec0b0808-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 04:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSoyia3G+hhbjLlI1C5ebVRB6oGmIP0PIiqaf8o2AHMnfDtaFz2YVGR8LVGDOhRmkO0Q3f7iFxw5OtwdtkVwNnYrd/s2NOPHdtVmLvMFxmGl/CWd+nAwV8aeqLhIuX77SzP5FjffzF3tYJVtmaX/PrM5LLtLkoKLw2NmIv4Y3XSD6lKhv2qjHQBpIy/yJ6vIgsJE/cdSmIm+h6oRaPDagwZayZtuaKh3CBK+THvgQnee6n78g8zWNaIwRi/k2O6s/Xv4Yc/dWF2x99PYvb/XUi59zffXhZgjjDToVO71QIvmRRJuR5OI8HjEE7WSCGrEBlRr+Io2tsB/H1ZDFM6TWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94o5jaD3w7T8PCWIpS3if5ZXzEZSfUbQvdBcIIkEIGA=;
 b=km8qsmgCBVrVlWxiGATLaWjB1ZBDrIRK4T1WxCdxRhxov4S7z3jZDur3Ams5MmF788Az3gy7eRLg7DLPsKroc9D66fpvGAEm7mNj3FUh0gXSvdoA2XuLKYrRfYVJ+4N3b9ENLe3TdLxhwei2+dMilrDI8+MjHb4vK0fHF9lUBgf78vsJwJT8oFxi4apWrYM5dOewUvz5LmMZOGclMG7WT6fj1XRlZpjRFxsj1CMJ9ImIgWhUsy93dS4YuJtuAe1nh5I315HMtT7iuSfZZGmYezX613jzPnHcXjNZYAoqY51e6hbNDEuB98EvfADYxt4Jya0+4FUJ6WC4obYORwIyzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94o5jaD3w7T8PCWIpS3if5ZXzEZSfUbQvdBcIIkEIGA=;
 b=DYEHsE4HxcnK8ZwMYah+RJsmtGgQ+k4tQnSO4ASunDeEMLgkbueYEmbuTc/w83Zykii+lp7usbqXdQS23i1S8HW3jJB3stLRexPjbwPr+yIEd8F73K8pAXtWsNnFsVPF7tyNgOKjNU/WqrXX6clppdpsJMeF1/djzCjclNMUIlA=
Received: from SJ0PR18MB5246.namprd18.prod.outlook.com (2603:10b6:a03:443::6)
 by LV3PR18MB5663.namprd18.prod.outlook.com (2603:10b6:408:1a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 11:45:51 +0000
Received: from SJ0PR18MB5246.namprd18.prod.outlook.com
 ([fe80::5a7c:1cb2:fcc8:8966]) by SJ0PR18MB5246.namprd18.prod.outlook.com
 ([fe80::5a7c:1cb2:fcc8:8966%5]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 11:45:50 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan
 Chancellor <nathan@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: RE: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve compilation
 issues on 32-bit ARM
Thread-Topic: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve compilation
 issues on 32-bit ARM
Thread-Index: AQHa2AUlZI50MZOoe0yWhZWePjzeErH6YQQAgAACIRCAAARUgIAAY0ZA
Date: Wed, 17 Jul 2024 11:45:50 +0000
Message-ID: 
 <SJ0PR18MB524672A30BAE8A7163FABECCA6A32@SJ0PR18MB5246.namprd18.prod.outlook.com>
References: <20240717045225.138799-1-vattunuru@marvell.com>
 <2024071709-nephew-scooter-5c6b@gregkh>
 <MW4PR18MB5244DBBC231E986EDBEDD5BEA6A32@MW4PR18MB5244.namprd18.prod.outlook.com>
 <22bf9a24-b4db-4017-b5a9-1b03e6f20bff@app.fastmail.com>
In-Reply-To: <22bf9a24-b4db-4017-b5a9-1b03e6f20bff@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5246:EE_|LV3PR18MB5663:EE_
x-ms-office365-filtering-correlation-id: b7eb45ff-0a58-47f1-9f4b-08dca65601c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aWJiVXVYalVRS0x4VlJWR21kVFVhNCtYRW0vRnk3UU5Yc21EaUo2Y0tZakdw?=
 =?utf-8?B?ODZvNmdRMDFlTlFpTVFMbmFqZ3lWZ3cxNmd4d0h6WXQyUUhYaHBXMS9DVURt?=
 =?utf-8?B?cHFpQ2FTSm1XM0Fnb2taZ3BrdENzVUhMVitEUnZzK0N6WnAxRUg5VWs1TUlU?=
 =?utf-8?B?Kzk1WkxqS0ljaHpyZmNVeUVINjJBQWExdE0vWkViZGNoOWRVeE1GYkd2SlM0?=
 =?utf-8?B?QVdxb0g0a2xNVXZYaE00YjI3R2Q4MmQveGQ4eHUzQjhtUnVBdGRSeW1JQjJn?=
 =?utf-8?B?NThPNDAxTllWNG5xcWc5MWc3dGxERHdKSTJuSnE0eGpBemFZaVhlbWkyQnpX?=
 =?utf-8?B?QTdJUXAzRElPT3hJa25WQUhCNEQzUjNJTHFaOUx2VHJMbkRoM1AvbWlJbDNy?=
 =?utf-8?B?UUlJNk9CUHZrQ3V1dGZHUWJML1lDdHVCWk50ZktTRmNCNVEwZzZvNlNZT1M2?=
 =?utf-8?B?S1lvT2ZRUGxvSUZKajE4Unp6bmdLdEhjVUdHU21PZGtzY1UzYmhVdXZiNm1Q?=
 =?utf-8?B?SG9KSmJob3E2SWV3SGhqaVNYcVVvVHdJdkdETGQwcllqSGFZdUN6TnhTYUt4?=
 =?utf-8?B?UDdIR3dyczc3K1lsUmVRbEhqZzdUWDV2aWtlc0swbWx6MVFYM0VkWXBiUUJT?=
 =?utf-8?B?OGNNNm5zbHBCdmp0aEZSVzQ1N1E2RXU3c3pNNzR6Qlc3NEtDMEdmU09uY2Y3?=
 =?utf-8?B?SU0wdEJPYnY1SkFIOG51ek9Sa01WMHdZTGRubndhY2k4cTFPNXdmMzVsVHRT?=
 =?utf-8?B?enlEVGFTQlFnL1VZTitkSzRNSkUvS1JVa292VUxGNk1TeFprdy9JVW50UGR0?=
 =?utf-8?B?c1lBQlZTRWNIWGdRM2dzcWtTNitHVXJkMnV6c1ZTVWlPNVBjNjJiRDF5VGR6?=
 =?utf-8?B?YisyODVjT3dWQXVMb0tlUTlITUNKSUxqYVNaT3RSQlVIQ0dZUG5KU3dpdTFB?=
 =?utf-8?B?TGhZZy9oUXluMGU0a2VRWlM5amtvczMwREZQN3duTjFaY01lMk1sRit6aHVK?=
 =?utf-8?B?U2dGQ1kza3VqY0VrUmU0NWV2aFFxWnFBYUNUc1lOdXEvL0lyRThHUzZwdDAv?=
 =?utf-8?B?b3NqdHUzeXpPNlYvOVU4anNBKzlHdm91RWxrNHRXcUU1VTJ2RjJuUzVwdTZ3?=
 =?utf-8?B?bUVPR2dUdTk3bE9XQ2VsNHY4c3RpekVtejUvRFZ2cmRjbVM2RGhZc0xYUFM4?=
 =?utf-8?B?YmNsT0pRWkdITmFBZzBDeUlMeG1ZT2NCTU96Uk95K2xwcTJ5TW50NWJXWGt2?=
 =?utf-8?B?T3pIUlpYODBSdm5obHNtQ3p0Tlozci9FTDhqRGFqRXBnbkJ1YnlhTG1yakl1?=
 =?utf-8?B?c2NZcGtoRXh1ajFQLzgrRHlBT1d1Tm5vT2ZmWk1lUHFtdXpqZDBxbTlLNzU2?=
 =?utf-8?B?d0hiWTZtYWxDK3F0M1ZhQkhzUWNtQk9nWEd1a3A1Tm9LYkJKVlJUUDVLMVJE?=
 =?utf-8?B?MHRIUVRDL3N3MHZzZHJubjFGcXlYaWV1c0d4Nm9jYzgwSk5oa3FDWWZvTGlK?=
 =?utf-8?B?UGIrcVJFUll2SjJBTUpaK2tPak5CdHRXMThVbEgyZmcrZU52cUg3MDljTmhQ?=
 =?utf-8?B?bGtaVVhiL2RCWld6WHZoWnpyZVVVWTNGc0tVT2J3RHZKcW5ORDR0SGVHYTdz?=
 =?utf-8?B?Qmg0cjBuZzRHN0dyRWhqazBPaEgzTXl4L0Zod1ZsR1BrT05XK2I2RGE3T0Ri?=
 =?utf-8?B?VUZJM0tqSGQzdzdhQXZreDNlSlVRWXRBWXpva29LWldwWnQ5cjlTSkxqWk1y?=
 =?utf-8?B?TTRReVhvcDlyc0ZYUklZT0JJQTZwdlNGeVhRbHlkMEdDVHhZcFdvRm43VEth?=
 =?utf-8?B?VWU5aGJ0dHNtaWhCR3BmVXhwU2xYMGxURjRCSDFIa0thWitFbld6cEp2VVcr?=
 =?utf-8?B?ck5heVF5aS9EWGErc1ZXYmpYclRibkRIekVINlpvN1l4VGc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5246.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WE1BaWJRQ051VEZGc1pxekFQc0c3bjJHZmpzaVh4QTJxUHNQbmRaWE1UcklH?=
 =?utf-8?B?aEdRRDJrbnlScnhyU2s2NFYybEUxbEhLSGJMNE0vbzhVeU9mZnEvSi9GY29n?=
 =?utf-8?B?Z2NXcGZ5RFJWTm5TUElZc0VkcnIyZ2pPajRUS2ZuSU42UjZEdjVGWCtpYUxY?=
 =?utf-8?B?WkdoWGw4SWZjaDN1ODBYMVNqN0ZGZDBGR25idmFTTkhPSnBxRzBHbUgvR25F?=
 =?utf-8?B?cnF6S3A0THZ6OWdzTlYreWZub1FIQnRvN2pXU0wzcDdZT2p0YUR6V01EWEo3?=
 =?utf-8?B?b1NjVmw4YzRIU1Z1VmEvaXVJVmxmTFBVNnBUc3I1VDhlUGdydmNlUjNoaUs3?=
 =?utf-8?B?dTR6Q0hZQ1M5RFpYODRJNmFkcXY5Uk5GVlcrejE4QmlBekhWbXRWVDdwbHJs?=
 =?utf-8?B?OE5kM0VYTHlZeXE1cTFOOHJpTFpjMTJHSDR4WGJaQTRBVHJISW82c1c3T2R1?=
 =?utf-8?B?Z0tIeWh4QnBzT3ZUUXgwV3Y1bUVqTlMvQVdZZGRYY1VEZEZBNThQZlRCdFI2?=
 =?utf-8?B?SlExOStCdWptR1FXU0hoVnZ6YmM1OFMxSVF5cGR4Q2lEWVd6VDNET3c3a296?=
 =?utf-8?B?MW4wUE5BSnB2SE9MZ042Y3d0THlYYkdLOGs2aVluYVV0TFdlVTUwZnNPZVl3?=
 =?utf-8?B?TVVmUWVLdGt5WVhna3RrZk41ZmlyK0V1dGdKc0NhY3QxSCs5ZzlPU3lBTm1v?=
 =?utf-8?B?bDI1SGtXTjErUzB1YVQ4UG5nSmprZ3NpaTVBZTlQT2NiemIrQmxsaitjR1Ns?=
 =?utf-8?B?aGRZYVk5RG11NmVZaGs3Znl4REdBc1pPVzJCMFBLMytGK0QxRFlGaWo1QWEv?=
 =?utf-8?B?d3llbXZFNTlUNFlPUU1SRFZKalZES05wZEhxRVJsTUZJRjhOWXMrMFBKNmsy?=
 =?utf-8?B?d29mVTBkaW5mSFhPR0FvMW95YjRtMURET0pOSTJWTDk1dkRwSEFrN1Uvc1VS?=
 =?utf-8?B?SjFQTFJuMkJ0REc2eDNSbll1Q0ZMQm5pVUZXSm9ESE5hK2hIOURha2pNNG5i?=
 =?utf-8?B?OVoyZVJFMUNiSFBOYVg2d3llcUZ4NTJtSm9hYWVvV0lRblMrSXRna2t5Mzg2?=
 =?utf-8?B?ZlVoM2NFQWIvTmZtVkpqOUc1NjFFZlZiRjVlVHhjb2hEMkVlZGdmUDI3NXdQ?=
 =?utf-8?B?cW5DMmVHZmpNMjNtRjZhTGFNc3JFajZQZkFYN3JrYTZITGRhNlJOMFh6WHVI?=
 =?utf-8?B?WEZyRHdzTjJUTFdtWEVZZjFld252SzVWSnRXd3FyOHFFSnY1RnVyck5NKzhw?=
 =?utf-8?B?OWRqamZFZXA4OWZvQ3ZpZXVoRTloL3FDRTR4S2Z0ZUlUZlRUQkJqMnVYWEFL?=
 =?utf-8?B?dk51V1NKYWs2cnNEMms0eVkyNWZtOC9YN1hEQk12MW15VUlyRmFjV2I1ekZm?=
 =?utf-8?B?RGtCc1VoY052eU01cENra0pjZVp4emFiV1I2azhFakcza0s2amJON3oxM0RG?=
 =?utf-8?B?ZFprZkNCZCtxSFcyVkUrdG4yWTFBQ2hFd0hMbDd1MHlyZU55SmhqUjlVellk?=
 =?utf-8?B?YWYzaGVQMTJVZGQxYVZ4VS9hZHVnd2xadU9qVmluSzhNcE9oeFpreUQwUWox?=
 =?utf-8?B?bVJvMGZNVnR4WEc3MmgyMXIrVXZFRWh4UENKSGpqaXFxaktDeFJGWHUva1Q0?=
 =?utf-8?B?aGRhb3ZEM2VoYTJXVmJpYWNseWZkZXN2T1RjaE9yQUZoOTBDS0dHK21BRDhh?=
 =?utf-8?B?MjZLSk5ZZ0k4bW12T1k2Mm9FSlZRRStmSmV6b2Y1bkw0ZmRVTnk2QjBWdm43?=
 =?utf-8?B?eGVkaU1BbEpRc2NXTDBtbkJUKy9Zb25TcWxCNTFjUFNzYlFEV00zc3h0SU43?=
 =?utf-8?B?bTdjNTlDbXhFMFZoTHQ5OHRSS0ZxRTNCU1pTT0xLK3hVMGRCK2JSVlJ0VTQy?=
 =?utf-8?B?dHozWHE3Q3ZSOFA5TEp4YkhhM3VtT2VIV3lVL0psbUpUMVhHN0J1T016MUhV?=
 =?utf-8?B?RGc1dWxyY2NxM05VYjlRNnZPWUxxQitUdHdORG5CajhXV1VOWDJYN0Z1dkN6?=
 =?utf-8?B?YkR1T2RaTHZkTkUrb1VBdzRVVWRiTTBrOFNvU2E2QXZpZiszQStXV092QUkx?=
 =?utf-8?B?cWNrbSt1L0NDQ3Z1d09ha3VGWUZWaENIVHZnKzJlY0w2amZpTmQ4c3dQZktl?=
 =?utf-8?Q?JFIeGHGFxBAQ7UROGS6aFahHN?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5246.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7eb45ff-0a58-47f1-9f4b-08dca65601c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 11:45:50.6523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIaPr9XZJodcPGr+vVtiWA6gqMxFW20heDjF/xCFuK1isaCoPH+hmyGRiVUetW2D8XWQvX1UV20YVos2NoayPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5663
X-Proofpoint-GUID: rbzCvHTK04GBynGJ61G2ogMORJhJyXlx
X-Proofpoint-ORIG-GUID: rbzCvHTK04GBynGJ61G2ogMORJhJyXlx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_08,2024-07-17_01,2024-05-17_01



>-----Original Message-----
>From: Arnd Bergmann <arnd@arndb.de>
>Sent: Wednesday, July 17, 2024 11:10 AM
>To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>
>Cc: linux-kernel@vger.kernel.org; Nathan Chancellor <nathan@kernel.org>;
>Jeff Johnson <quic_jjohnson@quicinc.com>
>Subject: Re: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve
>compilation issues on 32-bit ARM
>
>On Wed, Jul 17, 2024, at 07:=E2=80=8A35, Vamsi Krishna Attunuru wrote: >>>=
 #include
><uapi/misc/mrvl_cn10k_dpi.=E2=80=8Ah> >>> >>> @@ -185,6 +188,8 @@ struct
>dpi_mbox_message { >>> uint64_t word_h; >>> }; >>>
>
>On Wed, Jul 17, 2024, at 07:35, Vamsi Krishna Attunuru wrote:
>
>>>>  #include <uapi/misc/mrvl_cn10k_dpi.h>
>>>>
>>>> @@ -185,6 +188,8 @@ struct dpi_mbox_message {
>>>>  	uint64_t word_h;
>>>>  };
>>>>
>>>> +#ifdef CONFIG_64BIT
>>>> +
>>>>  static inline void dpi_reg_write(struct dpipf *dpi, u64 offset, u64
>>>> val)  {
>>>>  	writeq(val, dpi->reg_base + offset); @@ -195,6 +200,40 @@ static
>>>> inline u64 dpi_reg_read(struct dpipf *dpi, u64 offset)
>>>>  	return readq(dpi->reg_base + offset);  }
>>>>
>>>> +static inline void dpi_writeq(u64 val, void __iomem *addr) {
>>>> +	writeq(val, addr);
>>>> +}
>>>> +
>>>> +static inline u64 dpi_readq(const void __iomem *addr) {
>>>> +	return readq(addr);
>>>> +}
>>>> +
>>>> +#else
>>>
>>>Normally we do not like #ifdef in .c files, are you sure this is the
>>>correct way to handle this?
>>
>> Ok, came across the similar usage in some other drivers and presumed
>> it's fine with small routines. I will move the #ifdef inside the
>> routines than.
>>
>> Thank you, Greg, for the prompt feedback.
>
>You shouldn't need any #ifdef here, just call readq/writeq unconditionally
>after including the header.
>
>Have you been able to confirm whether the device works correctly with the
>lo_hi ordering?
>

Neither of them worked in our case, HW folks also confirmed that only 64bit=
 access work correctly.
I will just include the header that address the compilation errors with ARC=
H=3Darm, anyways nobody
will use this driver on 32-bit kernel.

Thanks Arnd.=20

Vamsi

>      Arnd

