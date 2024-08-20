Return-Path: <linux-kernel+bounces-293925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1F695868E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0768A1F27421
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F019190666;
	Tue, 20 Aug 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cRcjYvTZ"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2069.outbound.protection.outlook.com [40.107.215.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83AB19049C;
	Tue, 20 Aug 2024 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155495; cv=fail; b=jzADU3oeLPMg2Ib97UxFuokiKW2zEdKn/Y6ca1khW4PTV52tJp3qFpbCMUfHKun5mNmSdT9/S48JzzIrC0oI81xSDyzI7q4QhR0seNhS2xusPeAzDfemZBy8jYkDJuTz4VsICsKdYHa/FY4Z5VOq4qOtWbeoJ4nEy1wUKv6k6ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155495; c=relaxed/simple;
	bh=/utfiJ/Kpy4lcgqrAHbVrH2rIH03HihNoSQnIhD2w9c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z1rnRWL1WQUTSZT6HZqi2SpqinXYxM5xIPG8LP0ar3mIXGwIxrfF0JynJpkOZQ9LMDrt1ZRijhYHVPO/csvm7Lht1TJQ2WoiYFSgU3hL8NZu2baCcApD8VPoLFyfPZd9kRCvmVBL4uNOHNmMfOIHH0cnX6VcQI+7zzZduhCH5UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cRcjYvTZ; arc=fail smtp.client-ip=40.107.215.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8qiBezPvcldW9r9F5JmIu6YlMdc1aOWxVxicbU2U+3AhhKidI3OLFEBEU2UBKExQDrdCx50NxQnQxH5ZmJUslJuekxKLAOM933ICZgf4vAqeQ3DVKjRA17LMK3niQ51A1JgKuDrilNu1OOTQyBcgsArelvxyLFH8LZqvbF/NfyANVDe3aAy9NmVBB68G+1AjaanZ46inC+5r9E00k/ea7qYMOPE6FibGod3/GEf+pj/yybPFyoQdGjJw32AAt2ytN+EVv1pEPApO5qUaeZtkvkgNtv0hHTO/n3JfYeWrUAJjJv2Z/VSA2CD72jblBiYE7WWej2fIVtyCGz/vXzlAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/utfiJ/Kpy4lcgqrAHbVrH2rIH03HihNoSQnIhD2w9c=;
 b=tGuAohpKdClfhXM8Y7XGd3hY9F8iWkDv0lbZr/j8Hg8UfayIbxe23l36F+Z5GnHckRPXnRixcXZfGfUYQUVXFxZYqOQ812CeEKfHmtc5UnSc10N5fruyskI8/Gj5G+1+EdvOBUwWxJjR32hVvY3njqGQsELp00u2xze1yKMHgIP5jozKLXQ4bEoCDqsukx1VS3U/rNBggWjFhzy4RUbiojc773KgUY9pMCIsm1SykJ2KuUqx6MVW7+GlOyav7uIorWMvmj6k4PyGi5bZHa68F3gKyY+mUsIgn4YE5wml/76ddJFinC0OGDSsF6wFRfvq8kcL/6kgqRpKhO0D54D6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/utfiJ/Kpy4lcgqrAHbVrH2rIH03HihNoSQnIhD2w9c=;
 b=cRcjYvTZyhiH0UEQuL6ihUak5usS4hXFTT52poNJUUMFz/SZn0hFA8YcSn2tDQgoUIj+JHbMSV3CTGfy3GYLtQZStSvu7u+BQ6izGljns0Szu4Ck7h4XyUE/dPR3JL0ZSdNDlzAzUfJJfh1JUga2wmN57LvUPccLWx1xWR1OqJ0I7u7bPpmmndgHMuaIuD2eVVqr+rIEodLDjXxFHrVsmfb8rlli3/p3UScB+15uQVqOkO7Dn5FEqzhOjOGn0O7W4sjUlHFwg9UaZn8KVJTOqOfB6mXL29m751SvnVsf46kCFLaAy2qi/y/v1QVEyHQc8Hcq4zHhunPSWVa/6K+vDw==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by KL1PR06MB6651.apcprd06.prod.outlook.com (2603:1096:820:fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 12:04:48 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 12:04:47 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjFdIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogY2hl?=
 =?utf-8?Q?ck_Null_pointer_in_EP_callback?=
Thread-Topic: [PATCH v1] usb: gadget: u_serial: check Null pointer in EP
 callback
Thread-Index: Adry+R+rIhS7p3rRT8ymZjfRuj/pdQ==
Date: Tue, 20 Aug 2024 12:04:47 +0000
Message-ID:
 <TYUPR06MB6217F8B2397EAFCC67240E46D28D2@TYUPR06MB6217.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|KL1PR06MB6651:EE_
x-ms-office365-filtering-correlation-id: abb4f6c2-39f3-48dc-baac-08dcc1104996
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VVp3b005T3RqMzFOMDhVSEQveW5tdUdRekljOW4wWDNhSVZ4bzgwQlVSbTVT?=
 =?utf-8?B?TURqbExLRGJoV05hS2lHOGFVd1p4aDMvNXdsOU1Hdk5pb1o0ekRCUE9YOU1H?=
 =?utf-8?B?ajE1OHRwT1pVSVVnRkhQNVVmZGJFWkpEd3k2cDZ4Z2VaZi96SVU2cFVYbWdE?=
 =?utf-8?B?ZTBBSGxzd0gwbHFuV0QwYUpEeittMFduUG9ESFhwSXdBcURSRXBIMnFtaXE5?=
 =?utf-8?B?aktvOTVGWnloL2U3SUZNanZjUlZaVXJaMGQzZEx1UmdkNm9PdHBvazBvTzI0?=
 =?utf-8?B?R1Y4YTRJZU5UczEwYmphSUhYRDNTUFhYU1lhbDQ1RzRwd3JwZlN1S0dkeVZ3?=
 =?utf-8?B?NE9Sd3dtdTNMNlV3dkhSdk5TdEFsQXljLzBTUXR5THl3dDk3MVdOcXFvYUtS?=
 =?utf-8?B?UG9JVEhxMVZvTnNXcm8xb3JOc0FqMENMUGx0eWVXV3pRWGFmUGxOMGFMYlla?=
 =?utf-8?B?VCtUc1h6aE1SNDZqZWtxVXpoV3BYcWx5NnlYV1BPb0VUREhQdEtLNkJJSjcv?=
 =?utf-8?B?SDcwRHhaclR1cWFnUysyeVRMUHg0a1Z4WUl6Wm5SYkRERENuZjZxeExMUmto?=
 =?utf-8?B?WmNsSVpMYWhwVU5EOU5pSkJQbW1lSXQ3dndvbVB4VXVWNWVXZ1QzRXVMN1J2?=
 =?utf-8?B?T29vSmRWUE1DbnJRS0hpWFlweHUzZVBIYUVCbk9jNXUzNlh3elQwRGF4bVFJ?=
 =?utf-8?B?ZWNXbGpzcG5nUkZ3b0ZzRTQwQ2JNSHVCYlRPL2o0ejhuY0NlYloxYTI5di9o?=
 =?utf-8?B?SzBpSi9CaERvaVNEMlg3Y0N0N0NwTlNndUxseUN2V3lyQVdpTXFCS2R1TURQ?=
 =?utf-8?B?RVJWK3l0amt4aDBZVFNSZUtkODB3WGVuV3hFSzVtVW1NdENvRWl6cWxFMEY0?=
 =?utf-8?B?ckxUaWFSZitPaWZtMDNYWHVDc0hyNlZIOHpvblczNVltbldZYXl4MS9idS9Y?=
 =?utf-8?B?RlpsOWkwS2hFZGFsYnVuNmVlK2RGY08yd3JkNUhCREpKOXVFV0QvTmlYOUJD?=
 =?utf-8?B?Q1dGU1BsY3VpbW9MQkJybUhjUFpDNk8rcVdaK2dyUVpVamFaZlFodVh3TWly?=
 =?utf-8?B?aXhTOGJNbUZ5MXcvaHh5MFZWdmZoQUxnb3ZtaG5mdXBKcFlMek1BYmZHOU1P?=
 =?utf-8?B?dzVpV1B0OVJqUm1JM3hQcTNrUlFTRUgvdUNJbGoybTVOSy9wWVhwZWJhTHRH?=
 =?utf-8?B?ckxkbFg2ckpqNGUxZkw4cUU3YmlndGh0QW1kQkVpazdTYnZXS0RHcVk4ckVy?=
 =?utf-8?B?V1FNLzM1V1piSmt6cE1qODlheVRGNEp1RFMvM0Q2K0YxMlFpZUdkZGxudDJJ?=
 =?utf-8?B?akkwelhpTTNJOFIxU1RLN0tYSUxJZEpnWEIrcENiL3VMVXd4SjlScFVmRWI2?=
 =?utf-8?B?U2pNOVpZTmx3bXZscnlIcEloaFFBZHVnOGdCOEdrM2pEcXVmWnpCQU1xZytM?=
 =?utf-8?B?UHpZNTZWKytYeG92emJnSEV4b0o1NTRTODVKRWFvNUp2TjcxUkwvRFBaMXZp?=
 =?utf-8?B?V2tXS1llT01HVE4yaXgvOVpaVDlrWlNienhLSWQ0aFZxQXRzRzdVZW5tU2Ro?=
 =?utf-8?B?VG5qMDYxNzZ0OG1PL1FoZGpQRFQ5a29iQ1hHaFpGY05YckVXT2xuRk1USFpz?=
 =?utf-8?B?ek9UV25HLzR0YVlUZUs0N0dxUzhmVXlyUUN4K0Q4ZVJiVm5qTytZbTU4d3Zt?=
 =?utf-8?B?QldvSG9rRHNKR01yMlVlR1luemxaZTdMd3RJSksyeVlTdVRvSFhtd3Q3NnVE?=
 =?utf-8?B?R0E5Y20xdERLaXVGTnVQc2ZyTFh2QzdsZExmOFd2Vnh2aUQvd0xNRkY4TlhF?=
 =?utf-8?B?ZFJzb3N2b0poUjV0TTNtNi93ODhZZjBoamljRG9HWlkwSHdaZWNWRFBFTFl0?=
 =?utf-8?B?QzNxa3lCQzJwd2NHRStYWnlWWjNmdVJGUlE0bE1EMnA1b3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnFjTTluaXE3WlBzV3A5cUVPVWg4ZjZTS1Fpa1RiSTg2eGZoQldLbWFkS0Ur?=
 =?utf-8?B?U1puSXRkckxFbytEUTVZUHlrRTdNYXM1bmJxMHZhbDFiNENhblA3emVtQmtt?=
 =?utf-8?B?cWlFanZ5MWhzajBpTklOMVFYQWlrZ20yK2lQUFZYZjAveStadVFreUNUOGti?=
 =?utf-8?B?ZEZtN0s2L1hqK3lRY0NMbG5tUVBYQXJSNzhEMUM2TlorS3VFM29KRmlVWnAx?=
 =?utf-8?B?Q0JtWDBTaFpBdnJ2QStjYUJZQkdKL2FMZXJOeDdXUWpUUnhlNWxkYlJmNE5M?=
 =?utf-8?B?SDF1YlNYS2kxSEdLN2VLRE0zOHpiZ3VqUHB4UjFOM2ltQ3Y0UGtCVEFXSHEv?=
 =?utf-8?B?d0xLakdiczBxd3lNYUFYVHN6ek9uN1ZFdFVUMkxMZURtS1FuSHI5R0FhSFJO?=
 =?utf-8?B?SS9QeGZudGYxckNJeE1RdFBHM3NzT1laNURGZUxaOVR6d21XZWljd25xTHlz?=
 =?utf-8?B?OGN1VysxQkdjY25pcEpLY21XSHZobVVNSS9WZ2hsZkdKRjFiTjJuOTZMS01r?=
 =?utf-8?B?dzdFWGorQm51YXR1aUw4bC9NTG9pMTNBcG02TkJ4aTVuaFQzMktYZkY5a2dS?=
 =?utf-8?B?TjJvM2thK08zNmhNYXBCUHhETjcxemttZGsxNldDRXhJU2pRZHpLZzFnblhD?=
 =?utf-8?B?Zlh4bGp3TUNtc0FFWVh0UCtLeGRHYkNEeHJOVHdEQmlyK3VOZVZka0dLNmJx?=
 =?utf-8?B?MEQ2SFFVOExNSUlzeWIwRGNSSm9JbGl1VUNNWDBKd2o2Tk1sRkRFU0hSMlRO?=
 =?utf-8?B?WEc1V0JlTkorU3ZOKzVaU2FiU2VWc2k3QXl0LzRrK0ZteVlEbHhuNmY3Rlcx?=
 =?utf-8?B?cGlCZmFEV2RsaUdsOW5lcldVbUl4T2hvamM3QXlPN1pGZkt4MUZuTjJiOWNk?=
 =?utf-8?B?aTRyL2xrWjFaY1JNaUZWN3ROQ2N3eGliYlJENFAyYkdGWHlJTWJsUURJcHVq?=
 =?utf-8?B?WHRLbEw4dzh3UmE1Uk8yL3Q5MEk3VWpnbUE2NmcyN096VXgvV3g5T3ppNnBm?=
 =?utf-8?B?N0haU1FsVERJSVVHeGZ0dUJlL01qdDhISlVxblBzNWd3NkRxb1ZtZzlveENv?=
 =?utf-8?B?cGhRWDJEb3VzV2dibXlvOStwMXlMY0lQNjRUTVI0TnpoN3lOVTMvN1dWazBm?=
 =?utf-8?B?Z1ZNaklQUzAxenYvMHQ2TGNXUURmUW1OTi8xS1k2bWhCSHp1SDhtL25WcEtp?=
 =?utf-8?B?NHZ2cXNNYnpXT1pENjVHZ2psTjZzd3JlME01Qi9LSStPNTk5Zkw3ZC8xTjlC?=
 =?utf-8?B?blBqUmxYRDlnWENhUTdiZGpFZCtTVldUMkdUaHBwc2k2L0gzUDFsaVppWHZ0?=
 =?utf-8?B?ZUI2TFU5emRkTFhwRUVmeTB3TWNNWG5YaGEvNUk0emgvK3Y0VTk4eFhqQVFv?=
 =?utf-8?B?bnBSV0txcjhBZ1R4MjBSbC9JWng4RTdHNGk5VzNOZkRzYVRyK1VsOTJnb2F5?=
 =?utf-8?B?Z0hEcmc0ZWsxTGpKa3ZsNGVQb1FPY29xQU14aUZaVzlqUkc4SEZSdStJcnBk?=
 =?utf-8?B?YndNamJNTnBTRnMvR0FlU01HQW9UOGhTR2VOZU9VL3ZXdkFRQUY4QzUzRHJE?=
 =?utf-8?B?UzMzbGlvdFY3aUJ5cVBhM0FKNmxDdVovdmI0djNGbUIybjduYitKeFZxMFBp?=
 =?utf-8?B?NE5NUXd6L2lFd0VKTDlBa0pudzY0ckRYcSttUk42dG8yRW9BcWFLMzVtT1J5?=
 =?utf-8?B?Y2t6eVZSZWlWVmQzK2w1QmxJdzdDVHhiY29PVGFDQVJRa1l5TFZqdWxBL2R4?=
 =?utf-8?B?Ym4xUVk2YTdBNFU3dFF1a3hkTlI5dGw0dW1zWmE0eC9lL0RMcnBoSUhMZFVu?=
 =?utf-8?B?eit2M0RWZ3NhdHIzVTdWRjdpTk1EazJhcUM4YzBpNndrb2VkcytneEFYRjQv?=
 =?utf-8?B?UUZzYW1NN1NUQzdkL3ArSlpIUExGbUxwbk9xSU1OL1cvMG90ejk0QWdWTWc0?=
 =?utf-8?B?bzIwVFVaNWtkVk9NczhyTjlPUUtaak5uMlZ3YVRnNVJmZVJRVTBLR1U5dzZ3?=
 =?utf-8?B?LzVVTTY1WW9xM090TXc5cVhBd2Faak02YWppRkpZY21tR2N0cVB4elY1ZlRm?=
 =?utf-8?B?WmdtbzVVZTQvSytVbVhsUDJzWW1RSGR5VG9SbktDa2VhWE9uOHFWem9pUUFY?=
 =?utf-8?Q?v2V0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb4f6c2-39f3-48dc-baac-08dcc1104996
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 12:04:47.7724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2BIS68MxRyj+qiwzgMgTNvbiCIVV1I6Z0s1E0/QopgaLwDlsfpqWnaK5CezVBDRj5iK/wFV7u5rGjdXOu2hbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6651

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KPiA+ID4+IENhbGwgdHJhY2U6DQo+ID4g
Pj4gZ3NfcmVhZF9jb21wbGV0ZSsweDU4LzB4MjQwDQo+ID4gPj4gdXNiX2dhZGdldF9naXZlYmFj
a19yZXF1ZXN0KzB4NDAvMHgxNjANCj4gPiA+PiBkd2MzX3JlbW92ZV9yZXF1ZXN0cysweDE3MC8w
eDQ4NA0KPiA+ID4+IGR3YzNfZXAwX291dF9zdGFydCsweGIwLzB4MWQ0DQo+ID4gPj4gX19kd2Mz
X2dhZGdldF9zdGFydCsweDI1Yy8weDcyMA0KPiA+ID4+IGtyZXRwcm9iZV90cmFtcG9saW5lLmNm
aV9qdCsweDAvMHg4DQo+ID4gPj4ga3JldHByb2JlX3RyYW1wb2xpbmUuY2ZpX2p0KzB4MC8weDgN
Cj4gPiA+PiB1ZGNfYmluZF90b19kcml2ZXIrMHgxZDgvMHgzMDANCj4gPiA+PiB1c2JfZ2FkZ2V0
X3Byb2JlX2RyaXZlcisweGE4LzB4MWRjDQo+ID4gPj4gZ2FkZ2V0X2Rldl9kZXNjX1VEQ19zdG9y
ZSsweDEzYy8weDE4OA0KPiA+ID4+IGNvbmZpZ2ZzX3dyaXRlX2l0ZXIrMHgxNjAvMHgxZjQNCj4g
PiA+PiB2ZnNfd3JpdGUrMHgyZDAvMHg0MGMNCj4gPiA+PiBrc3lzX3dyaXRlKzB4N2MvMHhmMA0K
PiA+ID4+IF9fYXJtNjRfc3lzX3dyaXRlKzB4MjAvMHgzMA0KPiA+ID4+IGludm9rZV9zeXNjYWxs
KzB4NjAvMHgxNTANCj4gPiA+PiBlbDBfc3ZjX2NvbW1vbisweDhjLzB4ZjgNCj4gPiA+PiBkb19l
bDBfc3ZjKzB4MjgvMHhhMA0KPiA+ID4+IGVsMF9zdmMrMHgyNC8weDg0DQo+ID4gPj4gZWwwdF82
NF9zeW5jX2hhbmRsZXIrMHg4OC8weGVjDQo+ID4gPj4gZWwwdF82NF9zeW5jKzB4MWI0LzB4MWI4
DQo+ID4gPj4gQ29kZTogYWExZjAzZTEgYWExMzAzZTAgNTI4MDAwMjIgMmEwMTAzZTggKDg4ZTg3
ZTYyKSAtLS1bIGVuZCB0cmFjZSANCj4gPiA+PiA5Mzg4NDczMjdhNzM5MTcyIF0tLS0gS2VybmVs
IHBhbmljIC0gbm90IHN5bmNpbmc6IE9vcHM6IEZhdGFsIA0KPiA+ID4+IGV4Y2VwdGlvbg0KPiA+
ID4+IA0KPiA+ID4+IFNpZ25lZC1vZmYtYnk6IExpYW5xaW4gSHUgPGh1bGlhbnFpbkB2aXZvLmNv
bT4NCj4gPiA+PiAtLS0NCj4gPiA+PiB2MToNCj4gPiA+ICAgLSBPcHRpbWl6ZSBjb2RlIGNvbW1l
bnRzLCBkZWxldGUgbG9nIHByaW50aW5nDQo+ID4gDQo+ID4gPkFsc28sIHNhbWUgY29tbWVudCBh
cyBiZWZvcmUsIHdoYXQ6DQo+ID4gPiAgLSBjYXVzZXMgcG9ydCB0byBiZSBOVUxMDQo+ID4gICAg
V2hlbiB1bmJpbmQsIHRoZSBnc2VyX3VuYmluZCBmdW5jdGlvbiBjYWxsIGdzZXJpYWxfZGlzY29u
bmVjdCB0byBzZXQgZ3Nlci0+aW9wb3J0ID0gTlVMTCwgYW5kIHN0cnVjdCBnc19wb3J0ICpwb3J0
ID0gZ3Nlci0+aW9wb3J0LCByZXN1bHRpbmcgaW4gcG9ydCBiZWluZyBOVUxMLg0KPiA+ICAgIEl0
IHNlZW1zIHRoYXQgdGhlcmUgaXMgYSBwb3RlbnRpYWwgY29tcGV0aXRpb24gYmV0d2VlbiB0aGUg
Z3NfcmVhZF9jb21wbGV0ZSBmdW5jdGlvbiBhbmQgdGhlIGdzZXJpYWxfZGlzY29ubmVjdCBmdW5j
dGlvbi4NCg0KPiBUaGVuIGZpeCB0aGF0IHByb3Blcmx5IHBsZWFzZS4NCiAgT0ssIHdlIGFyZSBw
cmVwYXJpbmcgYSBuZXcgcGF0Y2ggYW5kIHdpbGwgc3VibWl0IHRoZSBuZXcgdmVyc2lvbiBwYXRj
aCBsYXRlci4NCg0KPkFueSBzcGVjaWZpYyByZWFzb24geW91IGlnbm9yZWQgbXkgcHJldmlvdXMg
cmV2aWV3IGNvbW1lbnRzPw0KIFJlcGx5aW5nIGhlcmUgaW4gcmVzcG9uc2UgdG8gYSBxdWVzdGlv
biBhc2tlZCBwcmV2aW91c2x5Lg0KDQpUaGFua3MNCg==

