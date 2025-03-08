Return-Path: <linux-kernel+bounces-552217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E7EA57711
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 02:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63318175E1A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71C71DDD1;
	Sat,  8 Mar 2025 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="S3Sz/3At";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Vz42Kc8e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LuEsyyei"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6C3C38;
	Sat,  8 Mar 2025 01:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741395866; cv=fail; b=uYfrrn7Li3D4pf9YpMfUKX0c3rMSMpflDhiUNtZfHW8FzgvlBA5nqmMVYz5dXS5YsYKRVL0jf3rr1SfGWLdIqSXYRb5c808bVURXvN52OzEx7vxZKTZ1p2nYduN7UQ9peF8YVAG+QTfeRpacAuTPUpwhnHxu2jgI6ce2KwxeoFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741395866; c=relaxed/simple;
	bh=Z8M7TtrRsugdix+uHqU8S4Rd7KCJwORBJVkSnDCtSh4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TvwPmOSOBLZRV26kf1pINDtXxEqDQ7Sj4b2+WYXoNAxcrWxhb9Dugv2pRXB1OOOu14s2sc9qFgcVtl+CPJtx1dzGDAAnTdcPvLv04SDqPdh/fZoIs0wYlR81MkdvSN1uTQH1TW+eUD2GL7Jzm60ftyo3JaW3Zfl1RIfPoO15yEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=S3Sz/3At; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Vz42Kc8e; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LuEsyyei reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527JDcxO007845;
	Fri, 7 Mar 2025 17:04:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Z8M7TtrRsugdix+uHqU8S4Rd7KCJwORBJVkSnDCtSh4=; b=
	S3Sz/3At/Ax7nXuvv+uNxxsQYiWqST6hKb9ySP/iTHQH4JDqmbgSCj5KS9QnrIso
	FC/ox5XViwhJ4LdwtCIXkpR6AutWEM7XL//4FQXBxyVDRFuncdork8nV643JIoRC
	z98kCBS/WClGWHHzKEYPOJg2B/Hmr9OpukfP/eJSIc6nm4jgpBIvXt2SE7vS3jhf
	vGyfKs9GMDPAGni0JdaFm9NFfSlEb1txIB71xW4ZTG5FL/zn/Tt/d3+u8515yBmP
	U0VQa8s9zQjC9mgz78D3jwIlO3zyBbGVXZCM6XBVfxzjJuj57NRwlWd/Qrga89Fg
	JI/GvEcrQ3rzavX5Qn/P1Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 45424twu36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 17:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1741395860; bh=Z8M7TtrRsugdix+uHqU8S4Rd7KCJwORBJVkSnDCtSh4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Vz42Kc8eANr0JYUXcBu0/H1S1/ntFpDmi+dHAYrrzmmBrJ8v/wieJi8Bom3qawf/9
	 O6owOEcgRKchQrtfPbqd1q0iRlFYWQGA9VOb4PXGw0PIHhYxChOnwh2BntGArRP4/T
	 vMcDaqVUPsWgw51YFsHd2imjGxWuezfv36drpmPq8Q6r8FAo31g6ZjCZtXcsRGvGwv
	 7U//cdriM6fFJEsqxVw6qSUabRW8dIdhYCIH9bQdRZQMJ9gLEm8kZfdNenQh20kSHx
	 JRQprx0Apx/LdsBZXNopyMV5q1Ry83w1qYcdxQsBLKDgSrhI1wBf6gUGcMDdUeUNYU
	 mDqmJYqhkzA6Q==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E32E8401F9;
	Sat,  8 Mar 2025 01:04:19 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 2DEBAA015F;
	Sat,  8 Mar 2025 01:04:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=LuEsyyei;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9CB6E401C2;
	Sat,  8 Mar 2025 01:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/vnkOwJjp2FQEblIG+DA08QOiaKro25b9Ir/RQoaaDufEdmHwE84DpYN4pciCf00TS6vBBrsePjt4l40G4NZ+RnQYDRYqAm4bwJvwIJfvRXmGhct6sxO+uJQveb6yT7M65p6ZkfYRqyhbIVvQfBm4li/y3R9Q3RuCBeMaokH9lSzNIcmMU5xSui9boq8qhbA54VyjjAd9peL2XXngT5cGoIlP7DTrEVoWIt0PQS6tzCuRw2xJNgYVcmczwvJ3Ck84aQaYgDyzMt/qZLVa32v4qUG+h311UjIwT7GFKeZ3UdW0BXc4WIEGMrSdWF5INwJ2naebtaXzMXwLLj4FKkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8M7TtrRsugdix+uHqU8S4Rd7KCJwORBJVkSnDCtSh4=;
 b=Tx5/MN72BY/VWUJFT3KRs/GoAhgUrW2qLYQBc6yKCbZrh0inclkAYExVkMnEYsbu/5OWzkOFYR4AbFDhbQdzRhSOPfplOLfAog42L9YDGGJbjyh15kmP9e1fkV9HNO3yoAibt542QK+GT64/7AYfWcIRnr1qf6WCZIzgzDLrk0qUHcNyBKTg+vdH51uOSSMtOFkPYI46YTeLclV/WI6azcq4Yl8opAuSLb92VhsgygmyKpU08nrxLIUNpzZSxk98E1MfEmMNEczn2avwSfR5Fgtud9ZLr1nCostAjeEdW6ObYU3nv7LeNhrjILzW2Mi54NUrNQ4w9IqI8dPRKw/Khg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8M7TtrRsugdix+uHqU8S4Rd7KCJwORBJVkSnDCtSh4=;
 b=LuEsyyeiZJtCkgma8xExUTdnpxTTPwm8VbNeG2u3AtKrLttV820kf2qGuLDMlYi9N8q/w5GZUKiRq2mdLGzTpEcnxnohe1+02AihKZOtdpWZhynxXntLlouUpPxXIN3eg1zaKjVQ69ewpYhLxdR2jpy/h4e5u+nzrgFLHzH7aBg=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Sat, 8 Mar
 2025 01:04:12 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8511.017; Sat, 8 Mar 2025
 01:04:11 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roy Luo <royluo@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] usb: dwc3: core: Avoid redundant system suspend/resume
 callbacks
Thread-Topic: [PATCH v1] usb: dwc3: core: Avoid redundant system
 suspend/resume callbacks
Thread-Index: AQHbjJkfO2ONbJJIu0CfZmqfULn61LNocsyA
Date: Sat, 8 Mar 2025 01:04:11 +0000
Message-ID: <20250308010409.n55ivdubj7ylkr7j@synopsys.com>
References: <20250304000458.1826450-1-royluo@google.com>
In-Reply-To: <20250304000458.1826450-1-royluo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS7PR12MB5718:EE_
x-ms-office365-filtering-correlation-id: 376e0bed-5205-412f-f20e-08dd5ddd2365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VWw5eGM2VklmWGs2ZW9hTzV3U2hNbWRaMy85NHJJU295ZkRUeGF2cnM0WTM0?=
 =?utf-8?B?RERyWWJ2Sko2bm8zMGF2eTFmUXkzZjJCZEtwcFZyTUFBNmxndGpEaHZ1aWxH?=
 =?utf-8?B?bDJrSGlYajg0aDZONVp0aHkwU1JHWkhVZHREL2tNRWJLTW50RDBldHN5VHpi?=
 =?utf-8?B?YVErOFdJYko5cjdnQmNnUkJ5MDFyQW5DNXVBOVBuN0NxR1lFcGR4Z0x2YzFU?=
 =?utf-8?B?cFdMWFFnbERzN3RmeURRV0s3cENmUWl1eGlmTnR5NFZLaE96dVlKeDZ4bjl2?=
 =?utf-8?B?UklqTGpvai9jcGJMQlB5MTQ1STkreEw1NnR4ZjAzOGVuVFdpd0pML0VEYmxJ?=
 =?utf-8?B?SnFZeGhGa25xbDR3cGFuTjdVdllXZi85MlVZalg4TTZPNm1Tbm9VY1pGcEJR?=
 =?utf-8?B?NUt4OEpGUFFGcWRZMENqU0dPR0ZrUnBWTHV2Vy9SSkNMR2pIZzdka2FLVUo5?=
 =?utf-8?B?c1hoSXVHVFgyWlBZK1hiZnFRM002T3Y1NXluZ1lkWXovWDJJdWQ5T1dnMEIy?=
 =?utf-8?B?MFlWaktLVnExNStOMEd5UWZOem92Q2RUWmxPRVhIdTNvRVR6UFlsd1JndHg3?=
 =?utf-8?B?WkhSbXBDODl2UUZ4eWZORkdxcU85RmZpOTI4RE8rck1ISFM5Mk11cENtWi8y?=
 =?utf-8?B?TStBcG1hbk5RVzhHeGZna043SmpsRy9zWER0WDB3Z1g5Q2IycVRUcW54N0hU?=
 =?utf-8?B?Zm1IMWNlSmZrTWRqQlhQSzJCdVh2L0wrVnlBTENaaC9ONXN0Mm43N1dFMlkz?=
 =?utf-8?B?UHdsWHRZL3ZoMXdVRXMzeGs1aDRIbVVvMVZsdnI4WFpCMlF5dWpXUjNsM2hO?=
 =?utf-8?B?M0xiWWkxb2ZwWG1SWU9QNmdKTXZNdVBsSGtSZW1hU21jVE5MYkhVbkVCaHlh?=
 =?utf-8?B?OEx1aXZ5Q2IvS3dkT1ZlYjJ0RHZ0S3MxMjZyd2E0YTUxbklsVGxET1lHK2FX?=
 =?utf-8?B?dDlHeEZiS0pTNHdzcllyMnBKemFMNjJ4VjllZzJMUVJta1d5c0dXTWdVSTZK?=
 =?utf-8?B?Rm94QkZSaldsRXJGTUNFWWQrY1FudDg3TURXRGRxVC9McGUrUzViWExlZkgx?=
 =?utf-8?B?OStqSG9JWGZ4c2RJMDR1Y01jUkhPdW4wMktUY3BCM21Jb3EyMDNEVEczN1ph?=
 =?utf-8?B?YVlOVi91aTNRQTJYMTU0OUxzL1NMZ1JkNys3NW1sMGpLTkhrWFo5U014b2Na?=
 =?utf-8?B?WUtpZDVLY2ZwOU1Ldk1LK1JvUWo5Vi9UbkhJcHpqYWIzT0FFL0dlcGsrRmsr?=
 =?utf-8?B?ZGlTTWV1bWlmTFB3bGZSYnV3M0IxMTR3TVRJQmFVRHdUMVdYTHloT1MyMXZk?=
 =?utf-8?B?Y3VrUXBscnB1N3JNSDErU0lwQml4aWtxL1pSUEpPMVFnNGRjbEZWazJIaThp?=
 =?utf-8?B?VmZrWExsOVBVUURXWlh5NTNnMU92eFBpL01qWXdlQUdQYklqNktKVVhXKzdT?=
 =?utf-8?B?bzdVK0VuSzJQUmNEdEthQXZwTElnTmxRVGRQQ0ZKclRJZ2ZGa2x6bnNRRmJX?=
 =?utf-8?B?OW1ob1RxTFMvdCtROGdMclUrTGRuVDIyS1VDdVMzaktoZFU2dml5VG1vMTMv?=
 =?utf-8?B?ZFU4eTFlam5EY0VDcEhsQ1BBR21vbmZMaXdVako1REQvMk9ybmhhRk44aEc3?=
 =?utf-8?B?T0hEbVVxb2E0Z3AzamthTXJlQlRGNC9sbWRiTGdPbjJtOGY5L0hPRVZra1hU?=
 =?utf-8?B?K3lBTXRHbWtBNXUzd0M0S0d4SVBIQXlFNVBpNmhndWxuUGlHem16b055VzJF?=
 =?utf-8?B?OTZmVklITFc1c2dZTEtjY21QRHdiUjlKcS9NdkMvYTM1STljRmZkZ0JVd0xt?=
 =?utf-8?B?NkpNby9QY2lvbS91RnphNVRobGhNQmw4YWNBTFFUaTRobklJL0g1WXBBRlZu?=
 =?utf-8?B?MFNZaWllbUJXVHNDVWhUclZ6eTdjdkNNNGt0NmMwekRwdnVDMGI3NzdFbWVJ?=
 =?utf-8?Q?hfH5lwzdx7GCzDxhqIEIbFgYv2XkfWlM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzB2Nm5OUkU1Y01zRnlwL3JJeE4yMVdHZVpQZVNLY253aXgyMFNHQVdaeng2?=
 =?utf-8?B?RUVxcDRoOWNwclREa1oxbWFnRmNIOXFYdlplYkc1Y010ZzI1TmxOUFpBeENW?=
 =?utf-8?B?QWYvS0p0OVVKblRYT3ZET0hXMWdKUm5McnZkUXNGc3NIaUt3M241UlpCc2hi?=
 =?utf-8?B?dzF6QnE0R0h1d2dwTnVuOGlURVZOWGJkU1BWRnp1eUQrNnRSSXZzZytDTWdQ?=
 =?utf-8?B?WVUwMTA5WU9RbC9mRzEyakZabGx6dHhmOXZIeTNqTDJva3d0bG1ITWJuNlpB?=
 =?utf-8?B?K0t1TjlsVzNIZG12aE13VndEYml4Nmx5SXVBa1VEU3V0ZGJvUEx4L2pRV3Az?=
 =?utf-8?B?UTRoSGlzZjZ4eXB1L2pzdUl5dE11YURVQi9TSmcyTUYrVnNTNVFZNUVCVVFB?=
 =?utf-8?B?anltQmJ2dC9wK0xucjRyWXV3VFd3YTR6M1hiL2xMMk1VYkdjWFdvcmRIRytF?=
 =?utf-8?B?eWRobGZoSk5WRVEwSWNLSUIvRnNMSGNNcUhKSHdyZVI2UmVUT3ZxNUIwM2cy?=
 =?utf-8?B?a0thcFg4K3ptbER0ME44cHdha1I5bm5Ra2xtTGx2ZmdKNUJNMEEwdGhJR0Fy?=
 =?utf-8?B?dmZTUWpnVExrVHhWbGlVQXdQMDU0TW5VTVhDOGJ0SSt5WDRMckRGRDQ4UG50?=
 =?utf-8?B?UTdrK3VmTW9UWWRGQ2QvcXhDYkVQUXNIazNRcXlGa2s3WVU1dU1DRGNXckFl?=
 =?utf-8?B?VC9UMUtjeW1WR3dEOFZRQkI4UmNQN1owajdna3VQc0xPR3ZCZXVhQ1FSeHJq?=
 =?utf-8?B?NEx5UE93YWJ5a25INFU4NUIzb2VkOGRpcTcwNFNoNXFWeStXaU5INnpKR2o5?=
 =?utf-8?B?YmdkNlRpR3o2ODhqVUtRZHlXRlFoUlhpbm9YZldXcWlLcHJXZWx0NnhkbHI2?=
 =?utf-8?B?SGloVGdxZlNGU0pqWGNwamxVWTRvNXlsY09LT0xGWHlnNW94b2RPSDY5UXp1?=
 =?utf-8?B?WFhzMFBjNWcvMkFCWXhFczh2dHVDbXNPbk1HWnRpV3VwajZ2aEYwa3JQZEdC?=
 =?utf-8?B?VE9sU2xUSFB2VUNmZ3JaSnIySDZVMXRXVVRFSlptbkt6NkZreVZ5QUxkS2JL?=
 =?utf-8?B?L0VRS2dWOUhCM3ZURmN0ZjNtb2lHd2VNRWRtQWIzaUZLandvSGxEVnpBZnh2?=
 =?utf-8?B?MkxuUHpHR044L2RKd29BRVNpZmtJYnB6YXJtVmwxR1dNY1FvVEJtdlUwenEx?=
 =?utf-8?B?MmFJT1hJNkxpU3dmSGVMUWphb0dvTmFaeWZrVDBaWjVWN0tTTEhJNWNyT2o3?=
 =?utf-8?B?OXIwYnBSMmZCNkg4T2RCZWIrSVIzQ1pabVRRSDMyVmxPWEZ4UEpFa0syVmdy?=
 =?utf-8?B?dTBTYzFIQm44STdSOGJCSUhsSnJaS1hZRjFCRVVMQUNablo4RG9IU1JCWEdQ?=
 =?utf-8?B?azZXcitCSXZCckdsVjhva2ZPeERlZnVCSGVRdGNTWDJ1bFdDNE9BbGZpaE1R?=
 =?utf-8?B?WGorMHpXcTFEWXVIbFZnZzBwZzdsczJnVTlDRmd2NTNxdDhIYWQzeENmaXNC?=
 =?utf-8?B?MHRwUjR1U2ZqTDliczVjWWEwQ3NCVHlucGI1c2QyK1VIR040NUhHQlE1WDZQ?=
 =?utf-8?B?N2d6bjFFR1NnSWFzV3NJNjFKOGI4emhBTW1xaHhYdG0xb1RMWjB4NlRhRTMz?=
 =?utf-8?B?a3hUbTNjbDl5MUZiV2xnTThIb1BPVkYwclREWWt6TVJ0dVpkbzNyYUhKSDRQ?=
 =?utf-8?B?QUdLODlWcTgySmk3QlR2eVlueU9zYWlmMG1FR3NyM3Z2THI3MzZIbHJzaURN?=
 =?utf-8?B?NjcvbFlPbG9MUk9PRVFKWmprVkpQYkdHRzg5L2JuS0IvK2Z2K1ZuMVNCVmZL?=
 =?utf-8?B?Vi9TMFdRcXR5aTFiZTFLcmZrV055RSsvQmdUZUphMnRlZTg4R29qcDA0Y1Qz?=
 =?utf-8?B?dS8wZ1VqWGtJVEVoVkpoVkVTbHVaZG1iVmlTbllrZ0oxVEdEZnp3bFZtdDc5?=
 =?utf-8?B?WVcwNHl3RWhaZHF2akMyTElYTHB6bExvb2VZUkwranM3RFg5eE4zRHRuNmZh?=
 =?utf-8?B?cUZtUVhnK2Vpby9WWnk2aWhheG15emx3TzBQMlVWRzNJWWJ3bW8yVjdZbmpm?=
 =?utf-8?B?SDUwc1RRcDFMdUhEREl2ak5Ndk9rUGtuWXc0YVFRMFF2OHRuTC8yamFxV2Zw?=
 =?utf-8?Q?554IUKifEKdkjrGx8Q3R6MPvT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B67467DFE433C479EBA7FEA87D49777@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8MqTBcIm2WgkEFNh1VixbmzEdENNzkgWSwPci6v+qkm+3gLEcH5N0YR/zn+Tbm905jiirSnKnGG9xRnxj61H7P+gAHyQrHxGGYctLxbVc9JQFkdzeGKdCBzVjaZLLQdlX2zFirsEXldLZQK/rpgpD7v7jGk03xo6sHLvGOiu092h5dXCY2mF3SLPmbEbnVmGsK9G/oefRDmSxdQCJrT+SJhUd3jonNmIkAbPTlaprJR4p9TelsP8xazD/GqUlI6dvIfVxpuM0/3/4za3QsKvlEoyjE7gZHZb+fj+quO7wsdVue5iiD/p+s4eW8tCsC8162peenOHuKr0DgQk5BW9l7ShhlTAFzkxfHqPHQAP8cj7CMJwQ8k4EE4Fnv0LdZcDkZkrD2+Zra75bHhYn7KqlWOR7M2fD1ZRzzklKtauXBZsStMGoTsgr+qXu7YA0qStBUPhYq/HwwYQR7wVVeQGi2Zlu0p+kRYAZWW9QQHymbjwiE06MKBK/EprjhnaBwNtLzCQ6GXIVULbO3OZ+Z6zsqrFgOyUtm1E0IRaBM1QsRkqwN2rWQI5NmUkOaCi4YVmNgr8YHBwR+FIya4sRFUgvYVmuoOL69lC+uq3z6BpP01E8cQlhR0s9Mr9flhGM+VxqYx2Wy1wXcCgMtbnbU1hPQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376e0bed-5205-412f-f20e-08dd5ddd2365
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2025 01:04:11.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LlmGiZsdSeErKp1aa0DANDAk6UCZIsRsb8ddjOfK343/qWo5AEdg89Jyx1heopC0zbLfCZqeCXRIsEboUZha+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
X-Proofpoint-ORIG-GUID: hTOiUiWBVWOsykr1q6VE62qOd_WD1pw2
X-Proofpoint-GUID: hTOiUiWBVWOsykr1q6VE62qOd_WD1pw2
X-Authority-Analysis: v=2.4 cv=NPgv+16g c=1 sm=1 tr=0 ts=67cb9794 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=qPHU084jO2kA:10 a=1XWaLZrsAAAA:8 a=0c6iBtieEY3WEej9n5gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 malwarescore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503080004

T24gVHVlLCBNYXIgMDQsIDIwMjUsIFJveSBMdW8gd3JvdGU6DQo+IGR3YzMgZGV2aWNlIHN1c3Bl
bmQvcmVzdW1lIGNhbGxiYWNrcyB3ZXJlIGJlaW5nIHRyaWdnZXJlZCBkdXJpbmcgc3lzdGVtDQo+
IHN1c3BlbmQgYW5kIHJlc3VtZSBldmVuIGlmIHRoZSBkZXZpY2Ugd2FzIGFscmVhZHkgcnVudGlt
ZS1zdXNwZW5kZWQuDQo+IFRoaXMgaXMgcmVkdW5kYW50IGZvciBkZXZpY2UgbW9kZSBiZWNhdXNl
IHRoZSBzdXNwZW5kIGFuZCByZXN1bWUgcm91dGluZXMNCj4gYXJlIGVzc2VudGlhbGx5IGlkZW50
aWNhbCBmb3Igc3lzdGVtIFBNIGFuZCBydW50aW1lIFBNLiBUaGUgbWlub3INCj4gZGlmZmVyZW5j
ZSBpbiBwaW5jdHJsIHN0YXRlIGNoYW5nZXMgaGFzIGJlZW4gbW92ZWQgdG8gdGhlIGNvbW1vbiBz
ZWN0aW9uDQo+IGluIHRoaXMgcGF0Y2guDQo+IFRvIHByZXZlbnQgdGhlc2UgdW5uZWNlc3Nhcnkg
Y2FsbGJhY2tzLCBpbmRpY2F0ZSB0byB0aGUgUE0gY29yZSB0aGF0IGl0DQo+IGNhbiBzYWZlbHkg
bGVhdmUgdGhlIGRldmljZSBpbiBydW50aW1lIHN1c3BlbmQgaWYgaXQncyBhbHJlYWR5DQo+IHJ1
bnRpbWUtc3VzcGVuZGVkIGluIGRldmljZSBtb2RlIGJ5IHJldHVybmluZyBhIHBvc2l0aXZlIHZh
bHVlIGluDQo+IHByZXBhcmUoKSBjYWxsYmFjay4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJveSBM
dW8gPHJveWx1b0Bnb29nbGUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5j
IHwgMjcgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjIg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IGRmYTFi
NWZlNDhkYy4uYjgzZjA5NGZmMWM1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMjM5OCwxMCArMjM5
OCwxMiBAQCBzdGF0aWMgaW50IGR3YzNfc3VzcGVuZF9jb21tb24oc3RydWN0IGR3YzMgKmR3Yywg
cG1fbWVzc2FnZV90IG1zZykNCj4gIAkJZHdjM19nYWRnZXRfc3VzcGVuZChkd2MpOw0KPiAgCQlz
eW5jaHJvbml6ZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0KTsNCj4gIAkJZHdjM19jb3JlX2V4aXQoZHdj
KTsNCj4gKwkJcGluY3RybF9wbV9zZWxlY3Rfc2xlZXBfc3RhdGUoZHdjLT5kZXYpOw0KPiAgCQli
cmVhazsNCj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBfSE9TVDoNCj4gIAkJaWYgKCFQTVNHX0lT
X0FVVE8obXNnKSAmJiAhZGV2aWNlX21heV93YWtldXAoZHdjLT5kZXYpKSB7DQo+ICAJCQlkd2Mz
X2NvcmVfZXhpdChkd2MpOw0KPiArCQkJcGluY3RybF9wbV9zZWxlY3Rfc2xlZXBfc3RhdGUoZHdj
LT5kZXYpOw0KPiAgCQkJYnJlYWs7DQo+ICAJCX0NCj4gIA0KPiBAQCAtMjQzNiw2ICsyNDM4LDcg
QEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21l
c3NhZ2VfdCBtc2cpDQo+ICANCj4gIAkJZHdjM19vdGdfZXhpdChkd2MpOw0KPiAgCQlkd2MzX2Nv
cmVfZXhpdChkd2MpOw0KPiArCQlwaW5jdHJsX3BtX3NlbGVjdF9zbGVlcF9zdGF0ZShkd2MtPmRl
dik7DQo+ICAJCWJyZWFrOw0KPiAgCWRlZmF1bHQ6DQo+ICAJCS8qIGRvIG5vdGhpbmcgKi8NCj4g
QEAgLTI0NTMsNiArMjQ1Niw3IEBAIHN0YXRpYyBpbnQgZHdjM19yZXN1bWVfY29tbW9uKHN0cnVj
dCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ICANCj4gIAlzd2l0Y2ggKGR3Yy0+Y3Vy
cmVudF9kcl9yb2xlKSB7DQo+ICAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRToNCj4gKwkJ
cGluY3RybF9wbV9zZWxlY3RfZGVmYXVsdF9zdGF0ZShkd2MtPmRldik7DQo+ICAJCXJldCA9IGR3
YzNfY29yZV9pbml0X2Zvcl9yZXN1bWUoZHdjKTsNCj4gIAkJaWYgKHJldCkNCj4gIAkJCXJldHVy
biByZXQ7DQo+IEBAIC0yNDYyLDYgKzI0NjYsNyBAQCBzdGF0aWMgaW50IGR3YzNfcmVzdW1lX2Nv
bW1vbihzdHJ1Y3QgZHdjMyAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiAgCQlicmVhazsNCj4g
IAljYXNlIERXQzNfR0NUTF9QUlRDQVBfSE9TVDoNCj4gIAkJaWYgKCFQTVNHX0lTX0FVVE8obXNn
KSAmJiAhZGV2aWNlX21heV93YWtldXAoZHdjLT5kZXYpKSB7DQo+ICsJCQlwaW5jdHJsX3BtX3Nl
bGVjdF9kZWZhdWx0X3N0YXRlKGR3Yy0+ZGV2KTsNCj4gIAkJCXJldCA9IGR3YzNfY29yZV9pbml0
X2Zvcl9yZXN1bWUoZHdjKTsNCj4gIAkJCWlmIChyZXQpDQo+ICAJCQkJcmV0dXJuIHJldDsNCj4g
QEAgLTI0OTAsNiArMjQ5NSw3IEBAIHN0YXRpYyBpbnQgZHdjM19yZXN1bWVfY29tbW9uKHN0cnVj
dCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ICAJCWlmIChQTVNHX0lTX0FVVE8obXNn
KSkNCj4gIAkJCWJyZWFrOw0KPiAgDQo+ICsJCXBpbmN0cmxfcG1fc2VsZWN0X2RlZmF1bHRfc3Rh
dGUoZHdjLT5kZXYpOw0KPiAgCQlyZXQgPSBkd2MzX2NvcmVfaW5pdF9mb3JfcmVzdW1lKGR3Yyk7
DQo+ICAJCWlmIChyZXQpDQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiBAQCAtMjYwOCw4ICsyNjE0LDYg
QEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCWlmIChy
ZXQpDQo+ICAJCXJldHVybiByZXQ7DQo+ICANCj4gLQlwaW5jdHJsX3BtX3NlbGVjdF9zbGVlcF9z
dGF0ZShkZXYpOw0KPiAtDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gQEAgLTI2MTgsOCAr
MjYyMiw2IEBAIHN0YXRpYyBpbnQgZHdjM19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAg
CXN0cnVjdCBkd2MzCSpkd2MgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gIAlpbnQJCXJldCA9
IDA7DQo+ICANCj4gLQlwaW5jdHJsX3BtX3NlbGVjdF9kZWZhdWx0X3N0YXRlKGRldik7DQo+IC0N
Cj4gIAlwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4gIAlyZXQgPSBwbV9ydW50aW1lX3NldF9h
Y3RpdmUoZGV2KTsNCj4gIAlpZiAocmV0KQ0KPiBAQCAtMjY0NywxNCArMjY0OSwyOSBAQCBzdGF0
aWMgdm9pZCBkd2MzX2NvbXBsZXRlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAkJZHdjM193cml0
ZWwoZHdjLT5yZWdzLCBEV0MzX0dVQ1RMMywgcmVnKTsNCj4gIAl9DQo+ICB9DQo+ICsNCj4gK3N0
YXRpYyBpbnQgZHdjM19wcmVwYXJlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1
Y3QgZHdjMwkqZHdjID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsNCj4gKwkvKg0KPiArCSAq
IEluZGljYXRlIHRvIHRoZSBQTSBjb3JlIHRoYXQgaXQgbWF5IHNhZmVseSBsZWF2ZSB0aGUgZGV2
aWNlIGluDQo+ICsJICogcnVudGltZSBzdXNwZW5kIGlmIHJ1bnRpbWUtc3VzcGVuZGVkIGFscmVh
ZHkgaW4gZGV2aWNlIG1vZGUuDQo+ICsJICovDQo+ICsJaWYgKGR3Yy0+Y3VycmVudF9kcl9yb2xl
ID09IERXQzNfR0NUTF9QUlRDQVBfREVWSUNFKQ0KPiArCQlyZXR1cm4gMTsNCg0KV2h5IGFyZSB5
b3Ugc2tpcHBpbmcgc3VzcGVuZCBmb3IgYWxsIGNhc2VzIHdoZW4gaW4gZGV2aWNlIG1vZGU/IERv
bid0IHdlDQpuZWVkIHRvIGNoZWNrIGZvciBjdXJyZW50IHJ1bnRpbWUgc3VzcGVuZCBzdGF0dXM/
DQooaWUuIGNoZWNrIHBtX3J1bnRpbWVfc3RhdHVzX3N1c3BlbmRlZCgpKS4NCg0KSSdtIGFsc28g
YSBiaXQgY29uY2VybnQgYWJvdXQgbW92aW5nIHBpbmN0cmxfcG1fc2VsZWN0KiB0byB0aGUNCnN1
c3BlbmQvcmVzdW1lX2NvbW1vbiBmdW5jdGlvbi4gSXMgeW91ciBkZXZpY2UgdXNpbmcgcGluY3Ry
bD8gSWYgbm90LA0KaG93IGRpZCB5b3UgdmFsaWRhdGUgdGhpcz8NCg0KVGhhbmtzLA0KVGhpbmgN
Cg0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICAjZWxzZQ0KPiAgI2RlZmluZSBkd2MzX2Nv
bXBsZXRlIE5VTEwNCj4gKyNkZWZpbmUgZHdjM19wcmVwYXJlIE5VTEwNCj4gICNlbmRpZiAvKiBD
T05GSUdfUE1fU0xFRVAgKi8NCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3Bz
IGR3YzNfZGV2X3BtX29wcyA9IHsNCj4gIAlTRVRfU1lTVEVNX1NMRUVQX1BNX09QUyhkd2MzX3N1
c3BlbmQsIGR3YzNfcmVzdW1lKQ0KPiAgCS5jb21wbGV0ZSA9IGR3YzNfY29tcGxldGUsDQo+IC0N
Cj4gKwkucHJlcGFyZSA9IGR3YzNfcHJlcGFyZSwNCj4gIAkvKg0KPiAgCSAqIFJ1bnRpbWUgc3Vz
cGVuZCBoYWx0cyB0aGUgY29udHJvbGxlciBvbiBkaXNjb25uZWN0aW9uLiBJdCByZWxpZXMgb24N
Cj4gIAkgKiBwbGF0Zm9ybXMgd2l0aCBjdXN0b20gY29ubmVjdGlvbiBub3RpZmljYXRpb24gdG8g
c3RhcnQgdGhlIGNvbnRyb2xsZXINCj4gDQo+IGJhc2UtY29tbWl0OiA5OWZhOTM2ZThlNGYxMTdk
NjJmMjI5MDAzYzk3OTk2ODZmNzRjZWJjDQo+IC0tIA0KPiAyLjQ4LjEuNzExLmcyZmVhYmFiMjVh
LWdvb2cNCj4gDQo+IA==

