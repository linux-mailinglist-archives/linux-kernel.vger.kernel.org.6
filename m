Return-Path: <linux-kernel+bounces-312056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CCA969168
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E351F22AAB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ACF1CDA21;
	Tue,  3 Sep 2024 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="U7qquG1E"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2085.outbound.protection.outlook.com [40.107.117.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5613D8B2;
	Tue,  3 Sep 2024 02:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725330221; cv=fail; b=uUEeSd0CFrbrKy6nJFjVKbbjUrJnamL+KJFoPwXkyOG6Xdev+XtYFLakYtjYBDviT8UPcoJusokbbOUwsfHcIShXNLVBBcOsmCwJvQw0DxUR1CYwOGoW6Sy7LeE/VpZAO0sLJzG9jpwqDNSnfSuPm7qjVpK99BC7gKq1RmVM+m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725330221; c=relaxed/simple;
	bh=x+1vKWjiSo6udY3RDSGIcUMw9V4KbittP8HDl3Fcmn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T+CQJiwVyxC9AqEq/ygIA5fHifRxshZvJregh54k5PpmWLfRsqr3XmrkSGIaCrS4dnIjJHHzDbzp+aTYt5ihmzaBKFLa9vYt+MOZLervxfTmqrHcdZkKIwpxjR6rMHkqU5yBCaGC2NpqppnHhfxBW6qOZ36WSscnXGyGxPTaxJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=U7qquG1E; arc=fail smtp.client-ip=40.107.117.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMDr4W+BQVgBW35lc46pt0NuGoIYlAxDkiRzyVZ+tRtA1w1nPN4qQ9OfWWz+XAGAx7Y/1opQ8o1QgcaEEBQqxjCe44ynxAJiPcXLhfFiG7cpygagltjq1EndmZnVkvUw8aDWgWQIrVOEO2uwevJO7ViyoVMbWyBwUSHzKl28OQm7J/pH0miuM7NZEwsyVi3xQIO0q7MkOP0tdpNVVGnzFWAxonz7vzTeS6quxjKiLVOntr/Y0YCUdvIOADlmInsl5pdyLBA2qQu9bQh1nv9nwEKklaOcF9uEyRThoAxFbGkXt4gR2fynjnCNwrtwKtTmxIbcxNsqDQ6Dyn54HRdohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+1vKWjiSo6udY3RDSGIcUMw9V4KbittP8HDl3Fcmn8=;
 b=Y1O+5LUQJvdA4mxDcu4HaiuNR1/fF5uk1JWqahAf4LGc6F6ua2xiElpZ57GyKE/BWKKsbAYlD7dumi/S6YRmVkG7K1pXAG5lnqLNSkfAJ8kv8bFE+BFdGlxx/cNvii76z5cRxJl1U5PPSLKbUn574kgtHOF7IzYrByjABe8+SVoeH9Bse9hJzRR6ajTSnA0wsTawNFq6ogQxtirx8IyxaSzyb603az6f5rCV3RwSgB3n/Aw7kTVO1qFSogzRmcqO4Zp9bAozM7pCsjIuX6ziMHggP3uXEG4khswg/y2pd7m4WlC1LP25TgVY/dBZHBzR2po8ZCLUtgxefmHvYRAnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+1vKWjiSo6udY3RDSGIcUMw9V4KbittP8HDl3Fcmn8=;
 b=U7qquG1EbtEBHYlc7Sp59rrqijd0nmFmvpIPlZDzwptFifk1JBs5zBTjQdqFkq/VV5YJKeaoumc62nb9zAIVOUPpM+ADW7bMCJVBxl5tEI3hFL69wpFShw5S2P3ABAK2uHfnuLSSSerzu+I3PuwRfsNwUtMtC1yjVbUsaKfq5kEEvyrwJqotjKleDBaC4HQJLejVV31brZDR6n+ERyyYHOD0lXg6ME4NMh0PLqdB/pQu/u4hKUyeToBNpUuANNGdRpRVdx3t2ypxEH5xbnqke8gxX6uz93W7PIfmMptntVHVMFa4DcTKCWKAsL43eJoWCIjBZ5HB3C28X5DwkVTQKQ==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB7188.apcprd06.prod.outlook.com (2603:1096:101:233::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 02:23:31 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 02:23:28 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>, Prashanth K <quic_prashk@quicinc.com>
CC: "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, =?gb2312?B?wO7UwMvJ?= <liyuesong@vivo.com>
Subject:
 =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIIHY5XSB1c2I6IGdhZGdldDogdV9zZXJpYWw6?=
 =?gb2312?B?IEFkZCBudWxsIHBvaW50ZXIgY2hlY2sgaW4gZ3NfcmVhZF9jb21wbGV0ZSAm?=
 =?gb2312?B?IGdzX3dyaXRlX2NvbXBsZXRl?=
Thread-Topic:
 =?gb2312?B?tPC4tDogW1BBVENIIHY5XSB1c2I6IGdhZGdldDogdV9zZXJpYWw6IEFkZCBu?=
 =?gb2312?B?dWxsIHBvaW50ZXIgY2hlY2sgaW4gZ3NfcmVhZF9jb21wbGV0ZSAmIGdzX3dy?=
 =?gb2312?Q?ite=5Fcomplete?=
Thread-Index: Adr6Cd+UUO/sbS6xR4e70mPa/mlHZgDOySAgAANWEwAAFL5oEA==
Date: Tue, 3 Sep 2024 02:23:09 +0000
Message-ID:
 <TYUPR06MB62171CA61CC646756826B8D9D2932@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB6217DE28012FFEC5E808DD64D2962@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <PUZPR06MB6224FF88145DAA364464EA7FD2922@PUZPR06MB6224.apcprd06.prod.outlook.com>
 <1179f9e8-1e5e-4658-8102-ee4d2c49575f@kernel.org>
In-Reply-To: <1179f9e8-1e5e-4658-8102-ee4d2c49575f@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB7188:EE_
x-ms-office365-filtering-correlation-id: c5e536ad-cb85-4cf8-364f-08dccbbf5a3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?aHhVT28zM0p0dDVMdFdHdWVZaG4yTHZwRVF2S0VtYUhUWUptckdkbW9lMWFw?=
 =?gb2312?B?aVdlU2VZakRIanpiQ0xzQVIxd1FrTGJNeGtDb1J5ZTRwNm81dHlFdk5BREZZ?=
 =?gb2312?B?T2hMSEhmY25kOVE5NlF6bVNPbjlXVFBGVklHWURpMmpGRW9SSkhxR29GSXNv?=
 =?gb2312?B?NUVvcStsbjJJNG5YRkUzMDRDRUM5QnpBSCtxejdhVS85cnBpWkp0SzFoeURG?=
 =?gb2312?B?L25sMFhuQ1JsNHo2bmhhQlkyTXVBWGxIa1FmVURwZzZNUVJxUGxxSUxNZm5P?=
 =?gb2312?B?djNUSTREMzFoZXplZC81cWF4a0s2ZjBBZ1RpdFcwNkg1SDVXdFRPU3l3eHEx?=
 =?gb2312?B?OEptUnpva280d0VnVGsxKzhjQnQ5VW5RWkNEcDRIODFJUWFlTHpCKzFUNjRB?=
 =?gb2312?B?NnJENlZiOHRJNEdYNGovUkl4L0tEME1LTmJWakEwY0RHTlBrNlkvUWRYcFY1?=
 =?gb2312?B?amRYRHBDR0JDQ3RERVM0WVJxNnJJbFE4VFE4bHRMMFd6bFY0Y1d2Z3NTditV?=
 =?gb2312?B?aWpLVmNrbzI5R1E5L1hhcFBKNHVDcklBdnlsYk92K21heDFhY3RoOFZMNDlQ?=
 =?gb2312?B?MC8rS2VxQ1hEYWNKdC82SlZZS3c5dGluay92V2NDVllESG1HYjcvL0Z1aWs4?=
 =?gb2312?B?ZmlpRUlrTnA5WFNwOVo4bm9BTTFOTnQxeVNTY3QyUjlyNnlMUzNXbUhXWHhh?=
 =?gb2312?B?bFJMeFFScnM5enBzSElIVlNSdDNYYTdDeXJBdWtkY2FHellxVGxUbVFFdUQ5?=
 =?gb2312?B?VURsRStZNWpTWHFvYkZXWVV0aVdVWDFXRWp2V2xTNi9mVXZlSXRGRzRqcDNJ?=
 =?gb2312?B?Z1hMMDg0SUx1Z1RBLzNSVFIxR2EwQStCam44UjR0U3g3S3NOYzYvQWNuajAr?=
 =?gb2312?B?NTlMbjJvOU83bzZUMUlwTmRCVjFYc3k3RVJQcEVjYWVRK0VTT1plaTc4cy9k?=
 =?gb2312?B?UWpTWExqMUM4MVVPV05nTUllMjhJOGlJRkFYd1d4U3FEck9NSnVIZ1V3Q0VR?=
 =?gb2312?B?ZnNiR2o4aXRPNkdRd1hyMEowaWJXVTA1WS9pQmQwL0liQTBqOEk5ejkyR21s?=
 =?gb2312?B?YjAxd01mR3gySzFjRkN5VVVKRUxIdXZTdWxzZzRUS3QxSnJFUmJVOTRqZ3Rh?=
 =?gb2312?B?OHpsb3luT1RVdkdyWXpNMkszekdHdS9oOHg0TEg4djVZV1poOUhOQ3lJOEVL?=
 =?gb2312?B?Z1dUSFdWemZ2TjJGZDNXYzFsaS9aM2wrajUyNWdxckRMaVhrano2Vll1OUtL?=
 =?gb2312?B?Rzg2M0pMR1BlSHNBVWZGUC9jdjVOQm5aVTlLYzg1ZThxTzl4cndweWpmcS8x?=
 =?gb2312?B?VlQ4N1NUNlhFZXBQZWIraGh2amkvNmJ1VTVsd3ZBdWI0RjlKVXpuR05OVnFo?=
 =?gb2312?B?Z2d4TjBidUNVU1pja2dta1hkUXBwZ0JFTE9ZY01xY1V5bGh4RHFVNGxtaklp?=
 =?gb2312?B?NEZ2SDNuQzJ6R2Z6bFdrUCtvN3pVaWNUdTJmSmxvUjYyWXgyNWRURzFKYU5S?=
 =?gb2312?B?R1hQSXZiVVZrNmRFanF5cU1LVFNyWlM0dlJKbk9BYld1WkdCTURuVC84a2lF?=
 =?gb2312?B?Q1hqbGc0SXB6T3JEWWNFYkg1dmRSTTRKajlmK2JLeGJ3aldmdzRWWUZwVXZM?=
 =?gb2312?B?ODVjVG5aS2N3OHZmWGJqR1JLY0lKTjY3UG43Y3dPelhabGNFYVZ2RUNjcnZM?=
 =?gb2312?B?d24vSjhiK203djl5eGJqeUNNR0hyYU0wUTljbGc1R2VBUnc5Tk1DWndhT3Nm?=
 =?gb2312?B?dFU0NitjaWI0ZEJ3MlI2VjdtVUFiOXRhSmtIbVA1SlVRQ1RwbUZBajVZNjhX?=
 =?gb2312?B?clBCSkpFaFQ3MmlVcExRMWtxYkV0OWZaYTdORXptZlduS0tVdTU4YUdHV054?=
 =?gb2312?B?SWhaQVN3ZDRzeTVobjVNTmppTlVQQzlmRUlIWEExWFJLcnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?K2ozQzRRN2NlT01wVWROV3I0cWxIVDZ1R3dyWDRjMDNIZFZFaEFYVVFVTGJB?=
 =?gb2312?B?OU1ucUVzVWtNbkZvQnp1cWFVUFVCRFNIWGwybjhSWWZRa1d4RTA1Rm1vNHYv?=
 =?gb2312?B?a2czQzgwZkY2ZmdUV3Bpd3puQnRPak13NkJoU09acjNmWmNETXpwTUdyd21j?=
 =?gb2312?B?YVNZMkt4WFRhQUdoQ0tQMTRXajF6UGhlNHNEcHlJeVJCdmVra3pYZnNQeWhI?=
 =?gb2312?B?Wmc0OTVULzlJSUd5VnJ0MXVBNXg3WXJkbElLUDQyYmhiZXBrZzNvc1hCS092?=
 =?gb2312?B?UnkzWjNVWXJjYTdETDNRV1FuMGdCUE05TjZvYjk1aU5aMVJsRzloOGxHK3pJ?=
 =?gb2312?B?eHUvdnkxOFNjdGR6bVVDYXdWMExpYXJZMmRmell1djROanhDWE5hVzhnQW84?=
 =?gb2312?B?TWZpUlRlanJDdnIxWlhUK0pERUJsYTluWVFYRXJ5OENDN2FYNVVoajZVOVNL?=
 =?gb2312?B?QnhOWXZMVjlTM3pTTmxENUx5TzM5cjgvN2VJWWI2UjUxcG5kVENYa1d0OGZC?=
 =?gb2312?B?TXVnbFNMR3hCSmRBTzRlaTljeVJvNzA2WTBBRnIwRU00Q05pTzF3ZnVkSHVB?=
 =?gb2312?B?dWE1dFhqUzNHUmlCc05veW90VytzL0p2bitlU29qM0R5NTYralJTbGhaaUlC?=
 =?gb2312?B?bGptRTYvaGMrTWRIRDJSRlZQdHZ2M0JFRnRHZ3o0dDBPNW5hd3FnallqOEtK?=
 =?gb2312?B?dVgvY1NXSDBvRXdsK3I1ekk3WjJNZGVqWnMvYmYydllpYmdza2c1K0x5TmdH?=
 =?gb2312?B?bjMwZHZuYzNBQW00Wm5oSG5tUzlvRmNoTktXeGN2dms3S3JleUh0OUZXZGNK?=
 =?gb2312?B?NXlHQ1VTUE9kTlhDNmZlSnFQSHRVM1F1cDJ2OXBvdVB6VFZZMGVhQXIzR3dj?=
 =?gb2312?B?MkU5MUdoOWpMTk1jeG1hV1JMc2ZyMVIvNU9zcnlaZFVEVWNlTVFTQnZkYW1a?=
 =?gb2312?B?aVRkZzVlY201TTY3QUtHQVZ4dnZzRkMwWVFPWFRZdFdKVjhaZ3c1aFlHOHNC?=
 =?gb2312?B?T2daeFJ6VUpObXkzN2J1Y2FXaXZ4anJJZHNPaVFMYzJWVnBFN0tNTjc1RlA4?=
 =?gb2312?B?a2crb3Y0Z1RXRWxyZ21jeWs0Rm9pYWxYaU1YSDRURGt6cXlSaDVuNTdJNENx?=
 =?gb2312?B?cVVweXA4VzNBVGlFcXhPcWFaOUUzcG8xZEk4bWdaKzFGeWt3dWVIa2FBN3B3?=
 =?gb2312?B?L0dSTEsrMGV2b2JBMklvTHNQR2RDak8vZWJ4eUNzTUF6VktPdExuZzd0dFVY?=
 =?gb2312?B?cmNhWnlLU3NiNGk5MzlLZy9uRS95Z3VDczI5T2JTT3hxRTI3Q3U5aGNqU2Z3?=
 =?gb2312?B?SXpNV0ZpTUlDT1hhYzVYVjNOOVdHU0dJRHVDK3JZMEU4VHRKdnAzYzVYcTNU?=
 =?gb2312?B?U0c2dHVpUFZPaDYvNUFHdG5zYThTYktnSXYzSTROd3hHQWtGMzlYMVBwdTZy?=
 =?gb2312?B?UXNlaTdvbTI1YU8rVXFrZ2JXcHZOQ01ZZGhDcFB6RE4vbDdBeVhMcmREcHpR?=
 =?gb2312?B?cHNCNDVtMHVtTjhWcGVwU0hGTGpLWmhyNGM5ZlpyRE0rNVQ2bXZKa0krV25Z?=
 =?gb2312?B?MVNwbzg3OWRWOWc0MU1TR2NGTmlQVDA3ODFGU0hrT3Ewbzc4WUNueGFDOXRj?=
 =?gb2312?B?eFU1ZFlWTDJXcXcyV0QwSEQyblpzREZ4bE1Xbml0anlDUEVGNDltTWtJUlJp?=
 =?gb2312?B?MTFCZlVMc2IvdEJ1SzRPc3JDV2hBOUZNUUFXRC96SXU3ZUorSEY1OXVidWtp?=
 =?gb2312?B?MmMxS1Nkdkd2Rk11YnBVMnlESzZ1NnhMdFErQ0NDYUdCOUNNWGJBTFBFOFpa?=
 =?gb2312?B?bUw0MHk1RElBZXhLTVRLQS96b0hVYjJTb3A1SElXck1MSUhoKy9QekFnVEwr?=
 =?gb2312?B?TVgvanZpQ1ZnVWdCOUZqY0dIeVVPZkpDTmgzdDNDTUtndlZBUFhMN3g5WCt6?=
 =?gb2312?B?b3U3ZlRSRU43ZXFUSEtPRm96eGU4NG4wNlNQVzZVQjBFemdQRVhxc01vT2lu?=
 =?gb2312?B?ZEI0b1MwaGt4dU9vRW4zVFdmVGkrNStadzJsdHZXSkxlQ3N6cmVJVVRuVGlI?=
 =?gb2312?B?NEVoa1k1MkFqYlhIRWp1aUpndFVENWIxVGxubTZiblhkMXE3ZnhSU0ZsODg3?=
 =?gb2312?Q?6VkE=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e536ad-cb85-4cf8-364f-08dccbbf5a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 02:23:09.2687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CSKfMH/2+fE4h3BvL3Fk77CtvDaHtkuJU4P0FHLBTSH4nnhxZszoZo2wd+CQPvsJ9iu9SC6qpiaYMNqULSDWhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7188

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KPllvdSBwaW5nIGFmdGVyIGZvdXIgZGF5
cz8gQXMgd2hvbSBkbyB5b3UgdHJlYXQgdXM/IEkgYWxyZWFkeSBjb21wbGFpbmVkIGFib3V0IEB2
aXZvLmNvbSBpbiBzZXZlcmFsIHRocmVhZHMuIFRoYXQncyBvbmUgbW9yZSB0byB0aGUgbGlzdCBv
ZiB2ZXJ5IHBvb3IgaW50ZXJhY3Rpb25zIGZyb20gQHZpdm8uY29tLg0KDQo+UkVBRCBzdWJtaXR0
aW5nLXBhdGNoZXMgdmVyeSBjYXJlZnVsbHkgYW5kIHRoZW4gZ2V0IHlvdXIgcHJvY2VzcyBmaXhl
ZC4NCg0KV2Ugc2luY2VyZWx5IGFwb2xvZ2l6ZS4gV2UgaGF2ZSBhbHdheXMgcmVzcGVjdGVkIHRo
ZSBtYWludGFpbmVycyBvZiB0aGUgTGludXggY29tbXVuaXR5IGFuZCBoYWQgbm8gaW50ZW50aW9u
IG9mIG9mZmVuZGluZyB0aGVtLg0KDQpQZXJoYXBzIHdlIHdlcmUgYW54aW91cyBhbmQgaG9wZWQg
dGhhdCB0aGUgcGF0Y2ggY291bGQgYmUgbWVyZ2VkIGVhcmxpZXIgKHRvIHNvbHZlIHRoZSBwcm9i
bGVtcyBlbmNvdW50ZXJlZCBpbiBwcm9kdWN0aW9uIGFzIHNvb24gYXMgcG9zc2libGUpLCANCndo
aWNoIGluYWR2ZXJ0ZW50bHkgb2ZmZW5kZWQgdGhlIGNvbW11bml0eSBtYWludGFpbmVycy4gV2Ug
YXBvbG9naXplIGFnYWluIGZvciB0aGlzLg0KDQpUaGFua3MNCg==

