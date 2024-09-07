Return-Path: <linux-kernel+bounces-319571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796A496FEC9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32832282769
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EB1A935;
	Sat,  7 Sep 2024 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P1VMtsk+";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OuMAonqg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Tcph8S9s"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4DD17BB4;
	Sat,  7 Sep 2024 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725670501; cv=fail; b=LL0pPyImKdZGLh2CbpIHZB9UUM80syfRnM3ZMzU5bQReuDqhBdvSt+64zt5c3yR+hhR7Iyz0qEDRXv0y+4TJa+3GZSujt+89Te1l2h0cN/WAXeG118cQE2U/NNNRUnZnRagEfNoE+V3xlRTef2oSD4T5OY7xHK2OVRCz7DncVqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725670501; c=relaxed/simple;
	bh=p7krYmqQ0hHdJCUeo9ilDXDuJSxfKRtskoRGK6yMtlc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kV9gHLbQsVa5i3MCDK+SQwp0x5vcN533UCAB0yl7RLu1i4Q/W6kBJ2pJvFMQ5QNS1bbAVSGpyYTm5Sou3gQcboiBPDR2ycWqXFMRJQUrNxffynQAC+iRLw8IUNhfVVdClunt5bvvDD4lxuBQU8eFrkvr7FX3qNAeatE2+M5+QE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=P1VMtsk+; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OuMAonqg; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Tcph8S9s reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4870H71m002474;
	Fri, 6 Sep 2024 17:40:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=p7krYmqQ0hHdJCUeo9ilDXDuJSxfKRtskoRGK6yMtlc=; b=
	P1VMtsk+vSscHy8ebj/rXscZEHOKpLDWHH+15Nza8hkBKsejThw8uEY5fVYQDdUj
	y9pO8fLy5irRDYxQ6GN1h8LcnggAgb5P6ZhKrtUnM+6C0sctD5XeNzM9oOQEQu3n
	AEcI6fVLe5gmhlT7FCNrO3bDV/WIrSNCBC438T4iQ97/NoNb6IcKJPDgz9GcYoPV
	HU/FtYJAAWEu/Wob/wPM4oKaTOwbrho/aC0rbv4YjzWxE5zf4MwQQpngapQsnTTX
	xLRcq76Zil10P57q4kDHUW1CbqH023HAtmybIVxvgcN9JY4+XZsC2PHAt35LQ6A4
	E3zreC7i41h1jrNTappdQQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 41fhxtemnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 17:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1725669599; bh=p7krYmqQ0hHdJCUeo9ilDXDuJSxfKRtskoRGK6yMtlc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=OuMAonqgQX467G5qST3qQXPA9rvFpS0QKFVj9bvdoOo+MFt3gviEMmz7pgxp6axTF
	 FxenWVpvPh9wBOmxJIlXRMJq6lrQSb7Ba5xYZEMtAxMTZhdFt6FYjpvahGdk19lQV3
	 ek/qF+/LCD71/H7u6yS//eXhTqha7SUp6Z/AeBLvHLlh/SupImMP0eFbER2nSlwcW3
	 HGVbINx46zE/UBQz7jvafZJpYNA7sTBiASv0y2Nz+paIjFCPgHc2n2zzSrwcx7964D
	 kursBTAlu9ZeOEBeuBTZMU1IklH4yzHJraQ6Jzt3SMXoF7x1bEUPPMsr7v78QBhZlJ
	 aI/tYZwNb4e8w==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 207DB40130;
	Sat,  7 Sep 2024 00:39:58 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 89895A009C;
	Sat,  7 Sep 2024 00:39:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Tcph8S9s;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3E95340235;
	Sat,  7 Sep 2024 00:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZtTDIIA0FWoQEvGLZot2M3vv8d3Hr8dAsUwdo9l4mbwbenfZccuaIOlWIqPpEGJZscMq8YbmrLeoR0ufGMmPXnfRgfg30kM5RZ64sFhgzPhGtuSl3ayobU/9wmiHA269HO7K1+luy4GgnTApBPu0v/ja5hoMLuKVh8YFBKfd8uroPsVUJuaQL5rL6SGiQl1o/wjC6YuHY3lHCmDBr4sTmYuRU5XiIU/nGmz0EHIYzbawNqPV7RK+KifLiPmW2lPkmwogdiENBZKJJAQ1ZjdFz8EhWMfoWxIp9dkmG4BO/gFZWJLaqoOKIhkW4ovEzCs+57Koud6H4voWQSo4l95mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7krYmqQ0hHdJCUeo9ilDXDuJSxfKRtskoRGK6yMtlc=;
 b=IIBLEGTPVtQfOATw7Ua/Uk7Z2HytzVIN7iZENS4XLffvjbXjI09EqM9nehFSxL8YN3A1eesqHEMvV+f3g9kh/6iVioT37VUNyVzU8G/joXmuvDRxAXnPg4yVSai/Nn7a+K3i7jXzOh0DfaKA5gV48cPQAxznDl1Qlokq+yJsRudXMakt1Imf/xjA0s0C5Nn9Nr6zOhld1bsTyJiohrXaYLnxr468RVLUDRAeecunZs+iuSVRREGD2fs/So6xt/stmI+LSuUQJ1ppcr4pxHsesbH5InhpLrZ7NruZ5LyWeb49OYm6cBTWwjr2PuY31FVkYtc+by0wNyoQQC4JiYj5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7krYmqQ0hHdJCUeo9ilDXDuJSxfKRtskoRGK6yMtlc=;
 b=Tcph8S9s6KCOfUDTPMbPGEHcwRYia2ARMNzWHK5Ut8pFUwToTA0eVRDMnQPe8gIoWGFPPuenJ6oykerRSj4X3yNTdlKR4c17nijtrQYiExb6R5CXeOSslcvgtvuzazrkQlDjQZWWHEITHQOZPCOJaO549WpH5b0tgcoSZ5h/nOs=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Sat, 7 Sep
 2024 00:39:54 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7939.017; Sat, 7 Sep 2024
 00:39:53 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com" <rc93.raju@samsung.com>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt storm
Thread-Topic: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt
 storm
Thread-Index:
 AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AIAAVgGAgAK0ooCAIEFKAIAA0sIAgAPWhwCAAnZSAIAA99mAgACQGICAANfzAIAAhJUAgAAfSwCAAAOTgIAAE4YAgAAIvoCAAS6LAIAAXkAA
Date: Sat, 7 Sep 2024 00:39:53 +0000
Message-ID: <20240907003946.qn6t3xw65qwl2cn7@synopsys.com>
References: <11535d95-c972-4dbe-afb5-de3a44bc4a21@samsung.com>
 <CGME20240905002630epcas5p4532c1e66864e39990376b696aa1f53d7@epcas5p4.samsung.com>
 <20240905002611.rxlv66zsker2h5w2@synopsys.com>
 <d5552437-119c-4a0f-9d71-6959727b6364@samsung.com>
 <20240905211338.omst6jr3okbxkqdh@synopsys.com>
 <f9561f03-5f83-4270-b7f3-17b880cfabfe@samsung.com>
 <20240905231825.6r2sp2bapxidur7a@synopsys.com>
 <64d049cc-d55d-4376-b6b9-402eb6f170c0@samsung.com>
 <20240906005935.caugoe3mqqdqwqao@synopsys.com>
 <30ca8527-419b-4e44-a21b-18e494b39076@samsung.com>
In-Reply-To: <30ca8527-419b-4e44-a21b-18e494b39076@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB8539:EE_
x-ms-office365-filtering-correlation-id: b60b9237-e10d-4bb4-19c7-08dcced5970f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2E2UjhWZzhnUDNsZStuUDRtcFlFbkppY283OGxJREZ4Y0l3dHc5Rmx0czBE?=
 =?utf-8?B?WWFZQWF1cGZ0Sk1KaGJjS1lTWlIycVFrdHB0aG9VN1piYlU1amF0bDBiRUJ3?=
 =?utf-8?B?QTJxR2pSbGpSZ3RxSEhPVzgxNDBtbC9lek9pcWhrR0Z0elpyN1Jham5KTkMw?=
 =?utf-8?B?ZHNPdjdhWWE3bS96NWttSHZodzl1cXYzSEpORmJBT1hJa0pGMmk3c29IL0Np?=
 =?utf-8?B?OFhNOGE3MkpoUmlzT0ZzTFlmZXdqMXNNNm5iNDNGOXhVWThYZDFLckxuQnBL?=
 =?utf-8?B?cHphdXE3Z3IxNzJsR2hNcjdiMUYxdUlWdXMrbHd2dk9nbjF5TDd5cWwxQmpt?=
 =?utf-8?B?ZVVkZDdCNURkdHJobVdwYjBySk5EUUZVNXMrb1FJVUloWjZGZ1hqRjMyZ2ZQ?=
 =?utf-8?B?QlV3L0dhZHFnekdRUFk5dnIzMnBDN1U2S2Z6ZWRab2RGQk16L3VnYjdESm8v?=
 =?utf-8?B?aEZtSE55bzlMTkRSRlF3cDgvZVMyY1l4VDMxZEt6a1R4Y09pYno5V1BrUFFn?=
 =?utf-8?B?c0FqZWw3Q0ttK21XWHVHZGFvcHFzY0JabC9PSkM4Qmt5YWdlNkowVHFaYWxX?=
 =?utf-8?B?Zkk5TGFCb2pqV05ISlFEdjREbGt1MUF0UDR3NG4rY0NWKzVrU2g2Y2I1eDIr?=
 =?utf-8?B?ZEZ5ZEQxK1ViTHE4Q2FhRzhoTnNEWHpqcFdyM25iVlJzQjMydHN3RmhWcC9h?=
 =?utf-8?B?TGJmK20wTVB2dzUzRS9Ick52SDhiYkhoSHRaRGQ5SHRZOFNXTVYxWlR3S21T?=
 =?utf-8?B?NlRsL1VMak42ekFnbTFySnEzSFpmbHE3ZnpuRlk4OG02OGpFQ3BCa0k0dEJT?=
 =?utf-8?B?M1owdnBXYnRKRnFzakdrRWl0YW5Zam84bnQ2WDJreGVreE40MzdGUFNqVC9O?=
 =?utf-8?B?ZnFaY3dpaDBmSHhlV1lKY2paWGlsdGozVTRhTjR6YU1GY3duejRLUWZuQ2ZD?=
 =?utf-8?B?TXB1N2VUUGRLTUdUL1k3RTZzQTdvRk14WU9yeFFPTDZSOUdMbnJXcC9JWmc0?=
 =?utf-8?B?NWxoQkZjMEE5WWNLdUhpNjBxdVl1bHJJcmZBcnZNcHY1cE1VekM3RGcwTXVk?=
 =?utf-8?B?R0Y4SytBWk5RaHQ4K0h1eDh2NmhCa2xLVTdyVWcxRUJhcDR4R3pnblNaalhi?=
 =?utf-8?B?WUhsOWROTEZzc3pBN0Z3Y2YzL3B3ekxld0ZwbkVXMDd0Y1Q3R3Z2MDNFUkJQ?=
 =?utf-8?B?MmxWT0VWZHJEWFR3TmVob3ZSbW4rUFozek9WS2xlQ1lROHBPcW1OU0s3Rktt?=
 =?utf-8?B?anU4ZmJ0RisyNUhRQnorQzg2ZE5kNmgzbFA1aHpnaDVSc2E1UWt4TDNNeWNC?=
 =?utf-8?B?N2ZxYW5scEhyYVUzQUlYTmFpK0dkdXhUanFyZUQ3V2svN2tURE5xMUdsUzA0?=
 =?utf-8?B?Q0hvbnloRjkvQzExRzNDYUVibFpQNzZtMENoYWtwUjVFaG95bldQYjUvKzBQ?=
 =?utf-8?B?RVAvMEM3SXhkdzlYWUE1Uzh0aVRMVHRnZXV5S0p1Tjc5Vk9MRVdxa2VEVkNX?=
 =?utf-8?B?bW45TTU4OWxkdkxINlJuZ1QybG42Nmx4SUlFaUZ6WVpENDJqNUpiSlVlM2pr?=
 =?utf-8?B?Z3dCakVrcFM5UitkTWJXMy9MYTd1eVlvTDRBRlE3M3pIVm9SbUJTeE1VcS9h?=
 =?utf-8?B?MXRDUHJ6K0Z3bGxtL3FoVFBaNVV2TWtKMUFLMGpUaks3Z21IMGpPdGVuaGJs?=
 =?utf-8?B?VGVWem9sY2VTZ1NjeFZFTk1XemFIek95Tk5weGI5ZzVyMTN0RkdUaEZQQUt2?=
 =?utf-8?B?MUJlTWRONmNoMGxZUUdPUmYydnhlQWpVdVdBd2F3b0tySzloNk52elVEYlNQ?=
 =?utf-8?B?Ym02Nk5lS1lRMjR5eHJ6TUdFbzNmOEJmbnBrWEtOdlNGckZ0a0crNmN5endY?=
 =?utf-8?B?RE9pZSttSW9UTlJSK1BYRkVvK0IvT3pTSGZya05FQlJVT3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVFtZmI3cENtbUx5dm1WcEUzb3IrYVJmRzdPQjV4ZCt6NVlSQW1qc3paNXda?=
 =?utf-8?B?eFloWFk2NHN5WjlRTmlPTnE5dUc1dUY3RE1NUE1BVlRnbFJkZGkveEJKUGNw?=
 =?utf-8?B?ckVzejBSOGljMkJRd3pmUUFoZmh5TjY2WFVBNGI3ZlpaTjQ3ZlZGa1N6Wk1G?=
 =?utf-8?B?SVZ0ZXFYMjNMWHRqY1BKQTQzY1hNSTU4cDN2amdwNlF1cjdxclJCMDFnb25l?=
 =?utf-8?B?RnlDbUVtNWNWaGV2VVR4TTR0NDdjc0Q4YUluc2lxZ1Q0bFdSZGo5N2swTm1G?=
 =?utf-8?B?VlVTTzhuMmZ5S1hFQzFhNERxcnV0RzFCNDZxQllTM1Ywanlhc25lTjAzUjEr?=
 =?utf-8?B?VXZPMXo3OXhsU0FZZmZTUFp4S3djUVlvOTQ5alVEd2pydm5aMmVZQU81OHVk?=
 =?utf-8?B?anVJbXlaWmRFeUF0TmtLUkxZK0NVV29CdU52d29IRGtlZVU5bWdzSVJ0NHk2?=
 =?utf-8?B?T1JCcXFBSEJOUWprdjJuS1RPaXpuYmpjUnZVc0Q4d1FKeHBRYjJOUnJ3UEZm?=
 =?utf-8?B?NmlwcTlYeXM1UFBzcTZXb0ZmbGY3SFhSYUpvZDAzSTlRZG02UW5TTUhuOUlG?=
 =?utf-8?B?T1p0ZkxNd0tFR25KMmFLRDh5dVpnOFc0eHZXa1VvaGUzc2kxTGtpNUxyeTZB?=
 =?utf-8?B?TjJDNnQvZHhqMXhVak0yRktsRmJ4cm8yemxBMGZ4YlFLOUt3UGwrQ1NONFFK?=
 =?utf-8?B?TElSQWxyNGhQeHJySThadDE1VWZBbXE1bHR1b1Jrb0JmQktrVkNpTE9nRTdy?=
 =?utf-8?B?UG1ZMk5JRzdEZ08zMFBEVDhrWmFtemxxeVpld2QzZkQzL0xJZ2Z2VzNuRjZE?=
 =?utf-8?B?eWh6Sk5mdTh6bksxZG8zRXZKd3FheC9uUWJJdFR3NERzYlp2aUl3UndpWFNu?=
 =?utf-8?B?ZUF2TWFCNDdVZFczUkI5Rm03elBXc29YZkdaM3B3VXIyNWlEbkI1ZGQ5aHl0?=
 =?utf-8?B?NUNwNWlhTXFIa3ZuL0JuNlFlY0p0SUE4YmpYQWFXWVFCTVVMZDE0RlhBSEVr?=
 =?utf-8?B?WENaa0NmQUZ6NVZqZTIvSG5wQzNZczQrQ0Fsbkt2LzNGV3BMOWJLUGZ5RGJl?=
 =?utf-8?B?SSs5VGc2enZXVTE0akJ0N09hSDNjZnZhTEp5dU1kbG0wNjBjcnBadWgwaDll?=
 =?utf-8?B?WHRCeGpVaERMQzN2QTFMR1VJSFZxSzRaUU9uUjhGKzd0UEhQL3lCMHo2N1Bi?=
 =?utf-8?B?NlVRS0F6c05tRmRxTTRocDArTGJFcEd3azZKVTN6OXRSekNDRHBvaVh5bGxI?=
 =?utf-8?B?bVlyYjhrOEZyTWlCT0dYNkppaVNDZytXNXRhYmxrZU1kb2Zsa0o0NVlPSUIy?=
 =?utf-8?B?V2lRQk9YS1pGMENYVk1UaTkvWWxNclJyRlhEbXUydm12QVViK1dCYld1anN6?=
 =?utf-8?B?Q3pvUkU4eEg4UDlzZURSR3FTb1g4U2pYdlVLQmZJY0JPYXk5bDl5ZGhvamxE?=
 =?utf-8?B?ek02ZTVYOWZhY1FSOHNLUVhpdUluRTZObS9aSVhIcEtJbzc3WjZXZytlM0VP?=
 =?utf-8?B?anRJeENhd0l3Z2FNcXo4cnNwUUZMdWRzT3pxZy9ISm9pWnRPSmFGekVNTkZm?=
 =?utf-8?B?RjZxaWttYTVzOTJ0RTlyUm5zYlNBTkdZMDI4cGtwc0YxWGhnYjZJOXQxSWN0?=
 =?utf-8?B?b3ZGVWZkQVhvNk1iWHFya2xWakJCMFBmT3lLUk5UMVoyaE8xcy9yaW9FQm9r?=
 =?utf-8?B?dExHSDRZYWY0RWQ0ekJnZG5SSkFQTngxclJCUHdyaEEwS2VXZVBsR25wLzVE?=
 =?utf-8?B?SlZ4OTlhZHJ0cllhVUNIcmtmbjUzWStjRmlTK1BPbnpZbjZMN3Jqaks5djB3?=
 =?utf-8?B?azRRd3doa05keGRrd3BnVWU5TVc4cVFUZ3lGV0IveGs4VnBKZWpDMmR5MXVn?=
 =?utf-8?B?cnVZMGtjcWhqUWNLYTU4VlRGV2ZwSHBkdkFvOGlicTdXaERETzhoZXkxYzA1?=
 =?utf-8?B?dlJ0Ulc1RjQwc29NQnJ5RGtXTnR4M3N5bGZ0cklzTGNpVHJLdTlSVUNvWXd3?=
 =?utf-8?B?SndHWWhjNzJLeWg5K05XRnVmM3FZKzJEM0hqYVVHMllEMjljay9kK2F0aHho?=
 =?utf-8?B?bVhudDNMS3N2Y2lBVGlvakk3QjZJY2wvK285MkFhSnVBdXBKV0IwSXp1WlZZ?=
 =?utf-8?Q?HawgQI8WubWsQ8kYMZo+nhvQk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FB4A13D5A07A146AC2D8B1FBF248717@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fY7JsYNeLxSue4BfdFLy6D+1jGCCxPu7yyiYeKjVb6YRfPGCxk6y4+PNq65Wf23RlQhnCjd37pUj9KD163S/zNXGr3ofqwhkNqTr3JA+WPFY3LNit4sL4zqk/RtRdzwa7J/TNFicVQNPFb2f9t6P6mE6hFnP7vRxPJozlzHmBw8alEUPgqkBB/pLXHmnFryXnJ2C/F4v9vYyuozInLX6Qm7vpMcApWKwgW8dHgNZRThLLvo3N/pxnNq1r0pSJo5Lb2/GhoFBrn2Th12jedkIOzJyYBWjAAVGTOfw3Cwt2srAGmwKq0OcBfHVEjsJWAUdjPBonntiJKn+rJK33v9o1sNhgaf3cbqjf4Mm2nZaDrNO14TG3N/Tx3/xmkCfaRZCDwcr4SjT64+GqBgh6YLU2/zRwS31eOU7MZOjwG0VCkqnECczLgZ/b3KnkB6wz9msKZiKahX0YTy7jHxZ3WgL1rJrsxpng/1Jlla8/Lil/BREVFz4gtbVCeQRbt+aTI2VYb9FEyjhDV8n8RSGSUR+5lD7JBkTo3PfrovKYK5Db+/gK7Q1g7qy3DqXGyo8I/6UbgRT25jpeMP7MG9+nUOdz4Bzzj60MfnvYbjf0Svq+WhOXIiciAtiPc2hdasd4+pBtwKmelMpkd7dQdOAoz5ozA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60b9237-e10d-4bb4-19c7-08dcced5970f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2024 00:39:53.6840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAidHsyD4NE8gd0onENcNpjoWpsQwXXM7zmgoEe+NBiu0MFd0qQG7simjzuNWgBTX1PWcVP7e+ilq4PZBVRd7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539
X-Authority-Analysis: v=2.4 cv=H/mJwPYi c=1 sm=1 tr=0 ts=66dba0e0 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=31x7j-imqBRvD0IK44gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xo8gXNWDxNOy__aB4_oqNzF98RdVFpwY
X-Proofpoint-GUID: xo8gXNWDxNOy__aB4_oqNzF98RdVFpwY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=576 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409070001

T24gU2F0LCBTZXAgMDcsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gSGkg
VGhpbmgsDQo+IA0KPiBJIHJhbiB0aGUgY29kZSB5b3UgcmVjb21tZW5kZWQgb24gb3VyIHRlc3Rp
bmcgZW52aXJvbm1lbnQgYW5kIHdhcyBhYmxlIA0KPiB0byByZXByb2R1Y2UgdGhlIGlzc3VlIG9u
ZSB0aW1lLg0KPiANCj4gV2hlbiBldnQtPmZsYWdzIGNvbnRhaW5zIERXQzNfRVZFTlRfUEVORElO
RywgSSd2ZSBpbmNsdWRlZCB0aGUgZm9sbG93aW5nIA0KPiBkZWJ1Z2dpbmcgaW5mb3JtYXRpb246
IEkgYWRkZWQgdGhpcyBkZWJ1ZyBtZXNzYWdlIGF0IHRoZSBzdGFydCBvZiANCj4gZHdjM19ldmVu
dF9idWZmZXJzX2NsZWFudXAgYW5kIGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cCBmdW5jdGlvbnMg
aW4gDQo+IGR1cmluZyBzdXNwZW5kIGFuZCByZXN1bWUuDQo+IA0KPiBUaGUgcmVzdWx0cyB3ZXJl
IHF1aXRlIGludGVyZXN0aW5nIC4gSSdtIGN1cmlvdXMgdG8gdW5kZXJzdGFuZCBob3cgDQo+IGV2
dC0+ZmxhZ3MgaXMgc2V0IHRvIERXQzNfRVZFTlRfUEVORElORywgYW5kIGFsb25nIHdpdGggRFdD
M19HRVZOVFNJWiBpcyANCj4gZXF1YWwgdG8gMHgxMDAwIGR1cmluZyB0aGUgc3VzcGVuZC4NCg0K
VGhhdCBpcyBpbmRlZWQgc3RyYW5nZS4NCg0KPiBJdHMgbWVhbnMgdGhhdCB0aGUgcHJldmlvdXMg
Ym90dG9tLWhhbGYgaGFuZGxlciBwcmlvciB0byBzdXNwZW5kIG1pZ2h0IA0KPiBzdGlsbCBiZSBl
eGVjdXRpbmcgaW4gdGhlIG1pZGRsZSBvZiB0aGUgcHJvY2Vzcy4NCj4gDQo+IENvdWxkIHlvdSBw
bGVhc2UgZ2l2ZSB5b3VyIHN1Z2dlc3Rpb25zIGhlcmU/IEFuZCBsZXQgbWUga25vdyBpZiBhbnl0
aGluZyANCj4gd2FudCB0byB0ZXN0IG9yIGFkZGl0aW9uYWwgZGV0YWlscyBhcmUgcmVxdWlyZWQu
DQo+IA0KPiANCj4gIyNEQkc6IGR3YzNfZXZlbnRfYnVmZmVyc19jbGVhbnVwOg0KPiAgwqBldnQt
Pmxlbmd0aMKgwqDCoCA6MHgxMDAwDQo+ICDCoGV2dC0+bHBvc8KgwqDCoMKgwqAgOjB4MjBjDQo+
ICDCoGV2dC0+Y291bnTCoMKgwqDCoCA6MHgwDQo+ICDCoGV2dC0+ZmxhZ3PCoMKgwqDCoCA6MHgx
IC8vIFRoaXMgaXMgVW5leHBlY3RlZCBpZiBEV0MzX0dFVk5UU0laKDApKDB4YzQwOCk6IA0KPiAw
eDAwMDAxMDAwLiBJdHMgbWVhbnMgdGhhdCBwcmV2aW91cyBib3R0b20taGFsZiBoYW5kbGVyIG1h
eSBiZSBzdGlsbCANCj4gcnVubmluZyBpbiBtaWRkbGUNCg0KUGVyaGFwcy4NCg0KQnV0IEkgZG91
YnQgdGhhdCdzIHRoZSBjYXNlIHNpbmNlIGl0IHNob3VsZG4ndCB0YWtlIHRoYXQgbG9uZyBmb3Ig
dGhlDQpib3R0b20taGFsZiB0byBiZSBjb21wbGV0ZWQgYmVmb3JlIHRoZSBuZXh0IHJlc3VtZSB5
ZXQgdGhlIGZsYWcgaXMgc3RpbGwNCnNldC4NCg0KPiANCj4gIMKgRFdDM19HRVZOVFNJWigwKSgw
eGM0MDgpwqDCoMKgwqDCoMKgIDogMHgwMDAwMTAwMA0KPiAgwqBEV0MzX0dFVk5UQ09VTlQoMCko
MHhjNDBjKcKgwqDCoMKgIDogMHgwMDAwMDAwMA0KPiAgwqBEV0MzX0RDRkcoMHhjNzAwKcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIDogMHgwMGUwMDhhOA0KPiAgwqBEV0MzX0RDVEwoMHhjNzA0
KcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDogMHgwY2YwMGEwMA0KPiAgwqBEV0MzX0RFVlRF
TigweGM3MDgpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA6IDB4MDAwMDAwMDANCj4gIMKgRFdDM19E
U1RTKDB4YzcwYynCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA6IDB4MDBkMjBjZDENCj4gDQoN
ClRoZSBjb250cm9sbGVyIHN0YXR1cyBpcyBoYWx0ZWQuIFNvIHRoZXJlJ3Mgbm8gcHJvYmxlbSB3
aXRoDQpzb2Z0LWRpc2Nvbm5lY3QuIEZvciB0aGUgaW50ZXJydXB0IG1hc2sgaW4gR0VWTlRTSVog
dG8gYmUgY2xlYXJlZCwNCnRoYXQgbGlrZWx5IG1lYW5zIHRoYXQgdGhlIGJvdHRvbS1oYWxmIGhh
ZCBwcm9iYWJseSBjb21wbGV0ZWQuDQoNCj4gDQo+ICMjREJHOiBkd2MzX2V2ZW50X2J1ZmZlcnNf
c2V0dXA6DQo+ICDCoGV2dC0+bGVuZ3RowqDCoMKgIDoweDEwMDANCj4gIMKgZXZ0LT5scG9zwqDC
oMKgwqDCoCA6MHgyMGMNCg0KVGhleSBmYWN0IHRoYXQgZXZ0LT5scG9zIGRpZCBub3QgZ2V0IHVw
ZGF0ZWQgdGVsbHMgbWUgdGhhdCB0aGVyZSdzDQpzb21ldGhpbmcgd3Jvbmcgd2l0aCBtZW1vcnkg
YWNjZXNzIHRvIHlvdXIgcGxhdGZvcm0gZHVyaW5nIHN1c3BlbmQgYW5kDQpyZXN1bWUuDQoNCj4g
IMKgZXZ0LT5jb3VudMKgwqDCoMKgIDoweDANCj4gIMKgZXZ0LT5mbGFnc8KgwqDCoMKgIDoweDEg
Ly8gU3RpbGwgSXQncyBub3QgY2xlYXJpbmcgaW4gZHVyaW5nIHJlc3VtZS4NCj4gDQo+ICDCoERX
QzNfR0VWTlRTSVooMCkoMHhjNDA4KcKgwqDCoMKgwqDCoCA6IDB4MDAwMDAwMDANCj4gIMKgRFdD
M19HRVZOVENPVU5UKDApKDB4YzQwYynCoMKgwqDCoCA6IDB4MDAwMDAwMDANCj4gIMKgRFdDM19E
Q0ZHKDB4YzcwMCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA6IDB4MDAwODA4MDANCj4gIMKg
RFdDM19EQ1RMKDB4YzcwNCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA6IDB4MDBmMDAwMDAN
Cj4gIMKgRFdDM19ERVZURU4oMHhjNzA4KcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgOiAweDAwMDAw
MDAwDQo+ICDCoERXQzNfRFNUUygweGM3MGMpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgOiAw
eDAwZDIwMDAxDQo+IA0KDQpQbGVhc2UgaGVscCBsb29rIGludG8geW91ciBwbGF0Zm9ybSB0byBz
ZWUgd2hhdCBjb25kaXRpb24gdHJpZ2dlcnMgdGhpcw0KbWVtb3J5IGFjY2VzcyBpc3N1ZS4gSWYg
dGhpcyBpcyBhIGhhcmR3YXJlIHF1aXJrLCB3ZSBjYW4gcHJvcGVybHkgdXBkYXRlDQp0aGUgY2hh
bmdlIGFuZCBub3RlIGl0IHRvIGJlIHNvLg0KDQpUaGFua3MsDQpUaGluaA0KDQooSWYgcG9zc2li
bGUsIGZvciBmdXR1cmUgdGVzdHMsIHBsZWFzZSBkdW1wIHRoZSBkd2MzIHRyYWNlcG9pbnRzLiBN
YW55DQp0aGFua3MgZm9yIHRoZSB0ZXN0cy4p

