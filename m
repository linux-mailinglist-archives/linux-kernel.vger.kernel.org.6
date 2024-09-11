Return-Path: <linux-kernel+bounces-324053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E77B8974750
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E651F237DE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56712B644;
	Wed, 11 Sep 2024 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="vRAzomf0";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EQ7x8mRH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rOVYDwca"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58414F6C;
	Wed, 11 Sep 2024 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014267; cv=fail; b=N0iS1EHgQTW7Asap9WgSijSZe/bY232aDOuM7jrkdF/qfDixhCo/8p/iPM/temzeq7T+Kz9bV7TYHv0hjr9fSybY+gQel76m/JK2fnLKT7dK96Kj2HBCeWzjOJZI8qUBWEQdawNKu0TceuveuBckIinwcpPPJd+gLT0b/afaEpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014267; c=relaxed/simple;
	bh=rD+oJ3e72WynX00ML+d5b/vutg6Z/RwaeXFQSfnYiNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kdV685mUs6CWHZu/tAql7+dbQOJ4IVPGDaqvf00shEihAtEVl0O6GQFDbTl2Wl9r+HOVzlVdXuPmhg1SD2iWNWHTF41b0jNG3+vEXW7JrOFVG2rm4kpnQ4fWf+r8y9sNr6Wv/sJbZd/WcACNIxZ3tlhGwxzns1YB9aLKl0C+FNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=vRAzomf0; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EQ7x8mRH; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=rOVYDwca reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AIBR3x013053;
	Tue, 10 Sep 2024 17:24:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=rD+oJ3e72WynX00ML+d5b/vutg6Z/RwaeXFQSfnYiNA=; b=
	vRAzomf0VdpQo4uSzJTSaE7hOTF0L9cLvIVOjarqXOGZtNjI5M5yAoJp5s09T4s3
	YOBKLrs1WmD+yPAQn+1+CTVraxqHfvD5l2nE/I1mJpjc/ziyYswo+LF4upidy7d8
	FvuOyDwD7/z+EVexxo+HmNpLWd3g/uh2yHojoQXMYayAvVDiDTMXNF2stZVvwknR
	Qksl+o/JYC3Wzi/baTnhHyhIS7hsKvs2+hImwQQYLLlfxAk1gWHllcNt+3UCqdYN
	muOYZmjPnGrEbL8Dbnf35dvpv/LWxuRKjPBc+W/pxCRSInByFkiMJCUdYHuM/R6g
	FhK/tMDr5ljws0acQkbMWQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41gy8jq1dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 17:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1726014254; bh=rD+oJ3e72WynX00ML+d5b/vutg6Z/RwaeXFQSfnYiNA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=EQ7x8mRHjw/JkXlXaQkHDIYr+BxQYNfXBWVvm0v6L/7yKcZtREw1qCLT+Njmzonw1
	 KUtOrCaxnjWxyZSS98nExKpeNaxYUqJD2HPdhyyXbuUly/dpaK3Q438kAh8mJY/BDb
	 H7fCEO+tXnFSTaQPBil26I9Zxg8MAEvdXluDlJKiO5Se2mPJ+0i3c2lkaiFaSoy7RX
	 1UaB4tHP6/pPaUh3d0oBdgvteyoabz9LXgAm3hSjXhriHgdQPzSlsrNDFcRYqxQly6
	 Jr/Mh493OZsC97l9Az5lO5lRJ8LxUozrvK2L3s10yhbgOytYJv0S2znwf/Hj72nwcA
	 +xEi6bG/fSZkw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BA10D40540;
	Wed, 11 Sep 2024 00:24:14 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 73EFEA005C;
	Wed, 11 Sep 2024 00:24:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=rOVYDwca;
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0B17A40147;
	Wed, 11 Sep 2024 00:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/wngM2X3gNy6pWgbE4e4hChryz2y/OG0i/kedYWqIrBQL/eEXtNpyVRe/nHq7xhDpUW6VWHM6sgxlMDcQ14brAefoJzp/28fyxWwCX8BD8Gp3vOUX2yEqg8ldDVqlvwVHN0fBYAyPLRA2TXtVAOJ1div9NcocqnihRxlFxSjw3V9O6HpFdTsK+MRVQbIUtc0yVaWKvwT0l4UVdyGE8q2QP6YE/ucPxDraZ4DggYe4EbOajNVtbvBQuhMQoq7BVsfllHcxI7nHFxLN0EvFd84fbew/g5JclkkpwXrjNZ8EFyBvHdjoyDBq1LO1qOGWmQzh3hMeoZ84GeTajUKBBUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD+oJ3e72WynX00ML+d5b/vutg6Z/RwaeXFQSfnYiNA=;
 b=tbCTPz8LYpfRY9zFVqstNaDiI8gWn89xhwCZA6ZskWgTbC5xOpxxf2BfJv1r06q+JVRYse5r6fSoJYYxR2y+7kPRACh5Nr+JUm7tGg6+IiGkLAC5oneOvl3Wk94EYM9Aqx37RtR620zobjk6gMV7gYv+loSRy+E7TBqs0+MSHRZI35lTtNE45495EEH2462xRqr/FCHL+tCyeMUl8g83cK4Vkm5MxPJFaH2fgtAMxXKOqiJWM+mA25G5aC5lYHYXG5moiuMEjfBULk4nKaevJ+GiEA6qhtMeLs/HlQll46fR1bg8cy/lw3V+dbHIj+ED90IX+AYxBl/8dcZxMoIPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD+oJ3e72WynX00ML+d5b/vutg6Z/RwaeXFQSfnYiNA=;
 b=rOVYDwcaESpxVcn5lxkK5Kcd2+CpJfNUGxg7OsaRnoToBCkkwxO3bL9hcYt78JN5thPbeKcZFnXHPUTt3HxphfStNw4M3QhpSwGHtyLyIGBl9GGwY2UqBsXi0FUQlAVczsOoMGhEnnv4FcjOH46NXTQVpWzslNMVj5EXGIEkTuk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Wed, 11 Sep
 2024 00:24:10 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7939.017; Wed, 11 Sep 2024
 00:24:10 +0000
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
 AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AIAAVgGAgAK0ooCAIEFKAIAA0sIAgAPWhwCAAnZSAIAA99mAgACQGICAANfzAIAAhJUAgAAfSwCAAAOTgIAAE4YAgAAIvoCAAS6LAIAAXkAAgAWQSACAALStAA==
Date: Wed, 11 Sep 2024 00:24:10 +0000
Message-ID: <20240911002408.gr4fv5vkst7ukxd5@synopsys.com>
References: <20240905002611.rxlv66zsker2h5w2@synopsys.com>
 <d5552437-119c-4a0f-9d71-6959727b6364@samsung.com>
 <20240905211338.omst6jr3okbxkqdh@synopsys.com>
 <f9561f03-5f83-4270-b7f3-17b880cfabfe@samsung.com>
 <20240905231825.6r2sp2bapxidur7a@synopsys.com>
 <64d049cc-d55d-4376-b6b9-402eb6f170c0@samsung.com>
 <20240906005935.caugoe3mqqdqwqao@synopsys.com>
 <30ca8527-419b-4e44-a21b-18e494b39076@samsung.com>
 <20240907003946.qn6t3xw65qwl2cn7@synopsys.com>
 <dff83c7d-56b8-481f-af69-8d4262bd54e4@samsung.com>
In-Reply-To: <dff83c7d-56b8-481f-af69-8d4262bd54e4@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN6PR12MB8513:EE_
x-ms-office365-filtering-correlation-id: 3ef32f1a-63c8-424b-fa8f-08dcd1f80e6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajBFUlg0M1hYRVBjbElmR3liVHB2MGk3UzFtd3huWVV6Y3dGTVZ5aEhjT2JP?=
 =?utf-8?B?US8vTkE1c3FXTVRkaTUyWlV3SitjZEhTNEFKbCt1STVhT24rU2h3dDgrbGFC?=
 =?utf-8?B?bjMvVThkS0REaW0wMVNEVmVJd1VSOGFLeUloaG9acGRSNG9LVms4a2poWWZj?=
 =?utf-8?B?MndMT1pmZHRQVGFmR1JOMXhaQU9qcFVZSERpcHI2TDk2d1VjMHhSNkc3c2Vj?=
 =?utf-8?B?SE0xRENlcDFRME8yNkRnZkc5VW5IdFl6UmdrZXVlcldyTUZrcUt3S2lJSEZh?=
 =?utf-8?B?QVFMZGVYNW13MmlIbm14b0Y2K1E1RDVrSFVwSW1YSFpJS1hSdFI1SFI3Mlph?=
 =?utf-8?B?QXF2MTRiQnpxYzdONG1XNDg5Mkw1TDl3eEw4d0hUVGJQY0JEWVRtbG4vOEFm?=
 =?utf-8?B?WENZV2hFd21STzBGREJoOVFnSzJmTWh3MWE1cU9XeGZONFZ3TVYxY2l0NUVv?=
 =?utf-8?B?VG1FZ1dZZW5OYVJ0UHNzN0VyWXV6UHZKQzNEWUQycnBQVGIwdWZBbTlRZVd3?=
 =?utf-8?B?V25IUnZDNFZjNit5YnVTaEF3MFBJWTFObDZWaXNKWjRyVTh4b0R1ejc0SCtC?=
 =?utf-8?B?TURLT2NVUGNQaEZHd2Nzc0d4R1pwTFlzdm1jU2s2NldiZUtYamF1aUhSek5F?=
 =?utf-8?B?TlNxSVp5V3l5R0tUMUZLUjRYeThhcjk3ZFZIYVZtdDdmZENFVCt2V3JDRGNM?=
 =?utf-8?B?UC9EVjNwMTN5WDM5TmZTbmxZbDgyZzVITDhJTHU2NVhDcytKQURIbmVHOHhu?=
 =?utf-8?B?NW1MRmdNOVFuUWNsVlRhT0RNbytobVlRRnJ0ajFtZENod0hLQXhDS3JFTEh2?=
 =?utf-8?B?TUsvSXc4ZGJmRFRSczZBeVFOMXl3MjJYam9wRlpEbHFobmtEeGxKQ0J3Kytj?=
 =?utf-8?B?OVBBVCtReUFVbUFVdllqR2JKSW02a09ZUFF5MHd0UnhCbENjeTF5ZHU1STdt?=
 =?utf-8?B?VVFQNGE2MHJTUWxJSVJyeGhvRnhtMGRpU2UzWTRnSDUrRjllbkdzYlBzY2NO?=
 =?utf-8?B?dVVncU93aTNtRU5TRXN3YTBrQ2JSNWlHZ2FFRjRUdnVMOWJiczNOTnh1SUNL?=
 =?utf-8?B?NDBLaGo3NmZxZ05OMGtTWWlJbEM0RDRmUXdjMG9LOXhkRHB4c1VhUy9HbFMz?=
 =?utf-8?B?alErVVQwOFZiNHFSTEJMUDMwRTZaRHp0c21qQS91anJqdVQvdGE1aGRKNTJR?=
 =?utf-8?B?eTN0WWlad084Q1RkcHpvcWpQeFhkRDVteGo5NmliOHIxQnFPMVl6TWE3a2R6?=
 =?utf-8?B?dk1WU2ZkajBRa2RVQmlPbitwSEllWmxBSmkxakdTZ3hIZzlNUENaaTU3Umxw?=
 =?utf-8?B?WEpqNC9IeTFrUXRrcSttbCtRQkFxWHFnSTZmVlFCd1E3MEF5RzVXY2tzdmJV?=
 =?utf-8?B?ZmZ5bGdvdENQNkR4aEdiaGtJS25IZ3d5eGlubVhXdGRWOXdEU3ZhTGtWYjkv?=
 =?utf-8?B?eTdFa1UyQU8xQ3pVekpndlhlNVEzNzF0bldLcC9sOFlDczgvNzRBNSsvOUV3?=
 =?utf-8?B?eWhJWHdnTjk3YmZERnAweWt6czlUTGZRdXF3K29jSEU1clNHNFplZENvVklz?=
 =?utf-8?B?K2hsaFVpZmlSeGZWNWdaaXhldCtsNEttVGJnUjRSUXV6Ui9rNWluVENEVDZK?=
 =?utf-8?B?Z0NhQlV6WTdNQ2dZQWp4RHQ4UlNocEFzV0JrRDJhalFzdW5PUUprTy9maWFs?=
 =?utf-8?B?OVhjSkgxOXgreFJheUxUSGZiZDFTODZBbVowd1RDOVZ4azEyalQ0dFZCb0R6?=
 =?utf-8?B?eVZXUGtoaitVTEU1d3FnZmd4WVNFT01oR3NKaVdoWVNFNXlBelMvUVhnbGJz?=
 =?utf-8?B?cCs5Zk94anNCRmxuMUgzOXJzM2F6QkpZMWF1cDV0R3Vlb0xUTGlXUzV1MC9N?=
 =?utf-8?B?NndUNlMxY1NjNmFSQWlCWkF5d3FPMmRaZk1VOEZRWGZUUUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkJSMC9CTW1EczRONlhVY0hoMjBiR084c1MxQUowSHp5eXppMlB4QnlCVWsv?=
 =?utf-8?B?U1l1MTRqSTJJMHo0WmtsU285OUZaOW5kWkVUMkUvZk52aHphcW5xWTRvRSt3?=
 =?utf-8?B?Y0dNYmNLRDBHSCtWT2p4U1ZGS2RJS0NsMzRidVlXNFd2dmtTeWVMUDNlQWdK?=
 =?utf-8?B?U2Q2dEsxMFpUWWN5WHBKUk5VMWZNd2lvam5ONnR0djZzZ01XT1NLK05lMUZn?=
 =?utf-8?B?L1Z2U0YrRERuK0ludU4zOUY5WWZlQnN3U0tWRzdLOTViSFVrcmdrZ1B6eFBS?=
 =?utf-8?B?SWJLK3NjN2FVZGxMK2NWcGs2RXNLRFNoSnlCa3BRK2d3b25xVForbXhqK21i?=
 =?utf-8?B?VFhYWldFaGl0eWg4cHBrRHRubWtxYm1uRDdIb3Job296eWJ4RFdoUmhMamU5?=
 =?utf-8?B?dEtGL25aaHEwZDRnVVh3Q1U3dnd2TTQ0UC9RTTZ2MXhRMm9WUmVxRFRoQXBK?=
 =?utf-8?B?R0tubWk4cEIzZUZaeDB3czVEZVRwalFpYlRtMTNoM0dJRHEvY2VWeHJsbGti?=
 =?utf-8?B?MHpjbnQzSHlnTDllR1hpQmNoYTg3Ym9ZQ09US0VVaUMxcm4wdU5EMS9PKzhW?=
 =?utf-8?B?aGJoSmo5c1Q1VG02TG9ZNUtycFhHRHk1RUMvZys0RmhEcnh5cFgvRStYU0JW?=
 =?utf-8?B?MFdrYmVBZElVV0djSzBUcUkxUVVtUDU0YlBacDR5RkxEMHI3emsyK25JbDly?=
 =?utf-8?B?L2szYU9paVUrNVkwbnZUUXNad1J1Z1JLNTloWkJ2cVFKTTZWVXI5ZldOUlcx?=
 =?utf-8?B?TU1PZERmWWV3OGNzNTRGcXViM1hJWlFxUGRnSnNrVkNRdkpuWU9ZQkVsbHFh?=
 =?utf-8?B?NEs5MklRdCtIdHhvVUxYMHV5Uzc0TnFVSStQalRjbjRRckNnbjFZMzRTOXgx?=
 =?utf-8?B?SGVuMTByd1NNNXRzajJxWUlqOWhpeXRCb0Yvelg3Z05DOTlCM2xGelg2blh0?=
 =?utf-8?B?VTJSaVhvY3BKQUtpanlTLzdONHhLUDNaWUE3bGh5OWRLMGlKNEs2MWx3WGpV?=
 =?utf-8?B?YklrUDRIYlFtRi9TSHd0ZkJWUzVkRXc5U2JDQXk5OHBWY3lsWXl5dEpzUzF5?=
 =?utf-8?B?Q2tjWEpjL2hmS1RuSDFVS0tmVGt2QUR0VTBaNlhHdUk2QWdhSDduVURhMEt6?=
 =?utf-8?B?OWd2LzVQQklibkoxdU5ZMnRnaXdKY3puMVViWlIrbXlIbWVDY085NHFqdzV2?=
 =?utf-8?B?TVFXWmhkQU1NcmRPQjJPYXlrckNDa0pjTkUyWldTb2J3NSsyVGNjT3ZYUzUx?=
 =?utf-8?B?bU91T2pjL2ZWNW1HdGNyMlEzSFhaMi90RnRPZzZKbTFmZitRR1ljOXNEbzFt?=
 =?utf-8?B?UWdTaXp0RFRpalZOaTFtNnJ2ZGxPZW1YclA5cmVsTStiamY2RlRKS3k2ckFh?=
 =?utf-8?B?cXRjdWRMQWhlOTRBRS9NajJmVXUxN056OHpTYnVaUCs4bGFSMDM5Y29NS294?=
 =?utf-8?B?NU9TZlAvMG9lODRxRUliM0xsQUFPcEt6NEh0c0JyZzgvalVsUmFlcVBNNzNj?=
 =?utf-8?B?U2IreDR1NnpHbVVTOXdkNkJzemhVajhnaklTNUpoT0JNOUE3dHgydUtMR3Ux?=
 =?utf-8?B?eXorVWhQQjlsSWZtV0prMXZ6blBDbU8rVFJxWWpVa2pJY1MxWkNkYU45bWxY?=
 =?utf-8?B?aGFZVHl5MUtvWVFGalJNaUt4RnJtMk14RHlWWHFzbGdVOUNqUG1lV20vOGhi?=
 =?utf-8?B?eGNPVVhScVQ5TkJDYUZ6cUNPcnM0dzRSZWM5WHJjRTNCMlpkSnlUUkZKWnFK?=
 =?utf-8?B?U3RCSXVOc0Vpb1BDRURyVjNzTWlUZm9rYkRHcUNOZFc1a1BZM2FITGRSWWgy?=
 =?utf-8?B?eTVPMnczNDZIRERsVU9NZTZ4TlEzcFZQemJqVWtoUExSTWJ3cUpwc01mWS8w?=
 =?utf-8?B?RWl6d3hpbERVVytzUGRzem1RTlVDTEU5eVQ5bHZNZVdCQnEvY2FPSXJOc3ox?=
 =?utf-8?B?am10QldyNFpCdnpWVmJpZFo3eWFsSlRnTkN2NFdwcDRYQnVmU3VvL2ZnNjNS?=
 =?utf-8?B?a3JKbG5MYzBTQ1psMEpWRGhCSEZ2VUxwYUppeXJUZmhhWXFyV1BjRlJGMHVP?=
 =?utf-8?B?K1FhUnVqZFlzaHp3K3RDbU0wNUNZelZMRzNka0NMWW4yelJ4YkRxdmhiK1lr?=
 =?utf-8?Q?K6KCLLXiUWgTVNNCikL6Kknwh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97AB9CDCA300804D9947F37C929307F8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tSOvwINv+4F8ZltCB2j+2SVpUzax2m9/FBp3ZCvKfi3kE1auKKbvaa0OTIceuX/Ih6xOUnO3mu/iJt9wz+oNceDyJznUzPzYPMOUIqkeHmkP8F9vHPlKdgT2X4OIK2oZV0D87W+viPA71XV8/ScTMj88sSnresMjvU8Gs+UPyfC3xqqvAArWU7wDIjQg5p+EYb5C7cvDLh5eR3SFQoIuK7ycPZ0HBwH85aDwpZny4cuagq0LAGcGlVi+tLKy9tmh6kToGBi0kESS6U2eyUj9u+sbbzi4WW6jsff6rGJFETVhmMvkGjAhfapM/rIWgpha4vdbWH1FdlDa6z0a8NE5wwIh6jXZiJU/Lppa4X2l9dYoGM3NQl2XR4QTE+WpH57SLADKtcTSW5IAMaXoolpRFJKZU7W6dRpyzyL3iR7666J/TCJhxbK7ljuBBtal6RtMdhC5VLQf0TRor8/ZimoxyZ0jGItkv5fO8YKij0GWrUnFJh23I+05M6hVpRfDkHStdpk7QdbK5LJHoCYcKLmme9eJ+YHD+zDWpgKe18Ud5C3OxEF/CuELAUX6gsxH+jK3FmAGfDwVnqpd5Rlds2VFr4QYpvIZ4rjnVyDjbj1jM76yCdOKTkVBrFX4mP0zFPo+2kQod+g1H9ccnisiOB11hw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef32f1a-63c8-424b-fa8f-08dcd1f80e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 00:24:10.3777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2cweeghCZLJhXWaQh+gHYXdvTfRoVm3TWEmfD6f8NZ+dynvGtRxpLmyfKHws64SH+QfHfh6OWxFbk38lUFG3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
X-Authority-Analysis: v=2.4 cv=cLmysUeN c=1 sm=1 tr=0 ts=66e0e32f cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=I6Ie2F2unyQtFSFz06kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rz4fPSw8P1scmVVkqYMQPFMj_798fYcZ
X-Proofpoint-GUID: rz4fPSw8P1scmVVkqYMQPFMj_798fYcZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 phishscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409110001

T24gVHVlLCBTZXAgMTAsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
OS83LzIwMjQgNjowOSBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFNhdCwgU2VwIDA3
LCAyMDI0LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4gPj4gSGkgVGhpbmgsDQo+ID4+DQo+
ID4+IEkgcmFuIHRoZSBjb2RlIHlvdSByZWNvbW1lbmRlZCBvbiBvdXIgdGVzdGluZyBlbnZpcm9u
bWVudCBhbmQgd2FzIGFibGUNCj4gPj4gdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSBvbmUgdGltZS4N
Cj4gPj4NCj4gPj4gV2hlbiBldnQtPmZsYWdzIGNvbnRhaW5zIERXQzNfRVZFTlRfUEVORElORywg
SSd2ZSBpbmNsdWRlZCB0aGUgZm9sbG93aW5nDQo+ID4+IGRlYnVnZ2luZyBpbmZvcm1hdGlvbjog
SSBhZGRlZCB0aGlzIGRlYnVnIG1lc3NhZ2UgYXQgdGhlIHN0YXJ0IG9mDQo+ID4+IGR3YzNfZXZl
bnRfYnVmZmVyc19jbGVhbnVwIGFuZCBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAgZnVuY3Rpb25z
IGluDQo+ID4+IGR1cmluZyBzdXNwZW5kIGFuZCByZXN1bWUuDQo+ID4+DQo+ID4+IFRoZSByZXN1
bHRzIHdlcmUgcXVpdGUgaW50ZXJlc3RpbmcgLiBJJ20gY3VyaW91cyB0byB1bmRlcnN0YW5kIGhv
dw0KPiA+PiBldnQtPmZsYWdzIGlzIHNldCB0byBEV0MzX0VWRU5UX1BFTkRJTkcsIGFuZCBhbG9u
ZyB3aXRoIERXQzNfR0VWTlRTSVogaXMNCj4gPj4gZXF1YWwgdG8gMHgxMDAwIGR1cmluZyB0aGUg
c3VzcGVuZC4NCj4gPiBUaGF0IGlzIGluZGVlZCBzdHJhbmdlLg0KPiA+DQo+ID4+IEl0cyBtZWFu
cyB0aGF0IHRoZSBwcmV2aW91cyBib3R0b20taGFsZiBoYW5kbGVyIHByaW9yIHRvIHN1c3BlbmQg
bWlnaHQNCj4gPj4gc3RpbGwgYmUgZXhlY3V0aW5nIGluIHRoZSBtaWRkbGUgb2YgdGhlIHByb2Nl
c3MuDQo+ID4+DQo+ID4+IENvdWxkIHlvdSBwbGVhc2UgZ2l2ZSB5b3VyIHN1Z2dlc3Rpb25zIGhl
cmU/IEFuZCBsZXQgbWUga25vdyBpZiBhbnl0aGluZw0KPiA+PiB3YW50IHRvIHRlc3Qgb3IgYWRk
aXRpb25hbCBkZXRhaWxzIGFyZSByZXF1aXJlZC4NCj4gPj4NCj4gPj4NCj4gPj4gIyNEQkc6IGR3
YzNfZXZlbnRfYnVmZmVyc19jbGVhbnVwOg0KPiA+PiAgIMKgZXZ0LT5sZW5ndGjCoMKgwqAgOjB4
MTAwMA0KPiA+PiAgIMKgZXZ0LT5scG9zwqDCoMKgwqDCoCA6MHgyMGMNCj4gPj4gICDCoGV2dC0+
Y291bnTCoMKgwqDCoCA6MHgwDQo+ID4+ICAgwqBldnQtPmZsYWdzwqDCoMKgwqAgOjB4MSAvLyBU
aGlzIGlzIFVuZXhwZWN0ZWQgaWYgRFdDM19HRVZOVFNJWigwKSgweGM0MDgpOg0KPiA+PiAweDAw
MDAxMDAwLiBJdHMgbWVhbnMgdGhhdCBwcmV2aW91cyBib3R0b20taGFsZiBoYW5kbGVyIG1heSBi
ZSBzdGlsbA0KPiA+PiBydW5uaW5nIGluIG1pZGRsZQ0KPiA+IFBlcmhhcHMuDQo+ID4NCj4gPiBC
dXQgSSBkb3VidCB0aGF0J3MgdGhlIGNhc2Ugc2luY2UgaXQgc2hvdWxkbid0IHRha2UgdGhhdCBs
b25nIGZvciB0aGUNCj4gPiBib3R0b20taGFsZiB0byBiZSBjb21wbGV0ZWQgYmVmb3JlIHRoZSBu
ZXh0IHJlc3VtZSB5ZXQgdGhlIGZsYWcgaXMgc3RpbGwNCj4gPiBzZXQuDQo+ID4NCj4gPj4gICDC
oERXQzNfR0VWTlRTSVooMCkoMHhjNDA4KcKgwqDCoMKgwqDCoCA6IDB4MDAwMDEwMDANCj4gPj4g
ICDCoERXQzNfR0VWTlRDT1VOVCgwKSgweGM0MGMpwqDCoMKgwqAgOiAweDAwMDAwMDAwDQo+ID4+
ICAgwqBEV0MzX0RDRkcoMHhjNzAwKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDogMHgwMGUw
MDhhOA0KPiA+PiAgIMKgRFdDM19EQ1RMKDB4YzcwNCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCA6IDB4MGNmMDBhMDANCj4gPj4gICDCoERXQzNfREVWVEVOKDB4YzcwOCnCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDogMHgwMDAwMDAwMA0KPiA+PiAgIMKgRFdDM19EU1RTKDB4YzcwYynCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCA6IDB4MDBkMjBjZDENCj4gPj4NCj4gPiBUaGUgY29udHJvbGxl
ciBzdGF0dXMgaXMgaGFsdGVkLiBTbyB0aGVyZSdzIG5vIHByb2JsZW0gd2l0aA0KPiA+IHNvZnQt
ZGlzY29ubmVjdC4gRm9yIHRoZSBpbnRlcnJ1cHQgbWFzayBpbiBHRVZOVFNJWiB0byBiZSBjbGVh
cmVkLA0KPiA+IHRoYXQgbGlrZWx5IG1lYW5zIHRoYXQgdGhlIGJvdHRvbS1oYWxmIGhhZCBwcm9i
YWJseSBjb21wbGV0ZWQuDQo+IA0KPiBBZ3JlZSwgQnV0IEkgYW0gd29ycnlpbmcgb24gSWYgdGhl
IGJvdHRvbS1oYWxmIGlzIGNvbXBsZXRlZCwgdGhlbiANCj4gRFdDM19FVkVOVF9QRU5ESU5HIG11
c3QgYmUgY2xlYXJlZCBpbiBldnQtPmZsYWdzLg0KPiBJcyB0aGVyZSBhbnkgcG9zc2liaWxpdHkg
b2YgYSBDUFUgcmVvcmRlcmluZyBpc3N1ZSB3aGVuIHVwZGF0aW5nIA0KPiBldnQtPmZsYWdzIGlu
IHRoZSBib3R0b20taGFsZiBoYW5kbGVyPy4NCj4gU2hvdWxkIEkgdHJ5IHdpdGggd21iKCkgd2hl
biB3cml0aW5nIHRvIGV2dC0+ZmxhZ3M/DQoNCkFzc3VtaW5nIHRoYXQgdGhlIHByb2JsZW0gb2Nj
dXJzIGFmdGVyIHRoZSBib3R0b20taGFsZiBjb21wbGV0ZWQsIHRoZXJlDQpzaG91bGQgYmUgaW1w
bGljaXQgbWVtb3J5IGJhcnJpZXIuIFRoZSBtZW1vcnkgb3BlcmF0aW9uIHNob3VsZCBjb21wbGV0
ZQ0KYmVmb3JlIHRoZSByZWxlYXNlIGZyb20gc3Bpbl91bmxvY2sgY29tcGxldGUuIEkgZG9uJ3Qg
dGhpbmsgd21iKCkgd2lsbA0KaGVscC4NCg0KPiA+DQo+ID4+ICMjREJHOiBkd2MzX2V2ZW50X2J1
ZmZlcnNfc2V0dXA6DQo+ID4+ICAgwqBldnQtPmxlbmd0aMKgwqDCoCA6MHgxMDAwDQo+ID4+ICAg
wqBldnQtPmxwb3PCoMKgwqDCoMKgIDoweDIwYw0KPiA+IFRoZXkgZmFjdCB0aGF0IGV2dC0+bHBv
cyBkaWQgbm90IGdldCB1cGRhdGVkIHRlbGxzIG1lIHRoYXQgdGhlcmUncw0KPiA+IHNvbWV0aGlu
ZyB3cm9uZyB3aXRoIG1lbW9yeSBhY2Nlc3MgdG8geW91ciBwbGF0Zm9ybSBkdXJpbmcgc3VzcGVu
ZCBhbmQNCj4gPiByZXN1bWUuDQo+IA0KPiBBcmUgeW91IGV4cGVjdGluZyB0aGUgZXZ0LT5scG9z
IHZhbHVlIHRvIGJlIHplcm8gaGVyZT8gSWYgc28sIHRoaXMgaXMgDQo+IGV4cGVjdGVkIGluIG91
ciB0ZXN0IHNldHVwIGJlY2F1c2Ugd2UgYXZvaWQgd3JpdGluZyB6ZXJvIHRvIGV2dC0+bHBvcyBh
cyANCj4gcGFydCBvZiBkd2MzX2V2ZW50X2J1ZmZlcnNfY2xlYW51cCBpZiBldnQtPmZsYWdzIGhh
dmUgYSB2YWx1ZSBvZiAxLiBUaGlzIA0KDQpPaCBvay4gSSBkaWQgbm90IGtub3cgeW91IG1hZGUg
dGhpcyBtb2RpZmljYXRpb24uDQoNCj4gaXMgc2ltcGx5IHRvIHRyYWNrIHRoZSBzdGF0dXMgb2Yg
ZXZ0LT5scG9zIGR1cmluZyBzdXNwZW5kIHRvIHJlc3VtZSB3aGVuIA0KPiBldnQtPmZsYWdzIGhh
dmUgYSB2YWx1ZSBvZiBEV0MzX0VWRU5UX1BFTkRJTkcuIFRoZSBmb2xsb3dpbmcgdGVzdCBjb2Rl
cyANCj4gZm9yIHRoZSByZWZlcmVuY2UuDQo+IA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtNTA1LDggKzUwNSwy
MCBAQCBzdGF0aWMgaW50IGR3YzNfYWxsb2NfZXZlbnRfYnVmZmVycyhzdHJ1Y3QgZHdjMyANCj4g
KmR3YywgdW5zaWduZWQgaW50IGxlbmd0aCkNCj4gIMKgaW50IGR3YzNfZXZlbnRfYnVmZmVyc19z
ZXR1cChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgwqB7DQo+ICDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qg
ZHdjM19ldmVudF9idWZmZXLCoMKgwqDCoMKgwqDCoCAqZXZ0Ow0KPiArwqDCoMKgwqDCoMKgIHUz
MsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJlZzsNCj4gDQo+ICDCoMKgwqDCoMKgwqDCoCBldnQgPSBkd2MtPmV2X2J1ZjsNCj4gKw0KPiAr
wqDCoMKgwqDCoMKgIGlmIChldnQtPmZsYWdzICYgRFdDM19FVkVOVF9QRU5ESU5HKSB7DQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2luZm8oImV2dC0+bGVuZ3RoIDoleFxuIiwg
ZXZ0LT5sZW5ndGgpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9pbmZvKCJl
dnQtPmxwb3MgOiV4XG4iLCBldnQtPmxwb3MpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBwcl9pbmZvKCJldnQtPmNvdW50IDoleFxuIiwgZXZ0LT5jb3VudCk7DQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2luZm8oImV2dC0+ZmxhZ3MgOiV4XG4iLCBldnQtPmZs
YWdzKTsNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkd2MzX2V4eW5vc19y
ZWdfZHVtcChkd2MpOw0KPiArDQo+ICvCoMKgwqDCoMKgwqAgfQ0KPiArDQo+ICDCoMKgwqDCoMKg
wqDCoCBldnQtPmxwb3MgPSAwOw0KPiAgwqDCoMKgwqDCoMKgwqAgZHdjM193cml0ZWwoZHdjLT5y
ZWdzLCBEV0MzX0dFVk5UQURSTE8oMCksDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGxvd2VyXzMyX2JpdHMoZXZ0LT5kbWEpKTsNCj4gQEAgLTUxNCw4
ICs1MjYsMTAgQEAgaW50IGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChzdHJ1Y3QgZHdjMyAqZHdj
KQ0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1cHBl
cl8zMl9iaXRzKGV2dC0+ZG1hKSk7DQo+ICDCoMKgwqDCoMKgwqDCoCBkd2MzX3dyaXRlbChkd2Mt
PnJlZ3MsIERXQzNfR0VWTlRTSVooMCksDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIERXQzNfR0VWTlRTSVpfU0laRShldnQtPmxlbmd0aCkpOw0KPiAt
wqDCoMKgwqDCoMKgIGR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HRVZOVENPVU5UKDApLCAw
KTsNCj4gDQo+ICvCoMKgwqDCoMKgwqAgLyogQ2xlYXIgYW55IHN0YWxlIGV2ZW50ICovDQo+ICvC
oMKgwqDCoMKgwqAgcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRDT1VOVCgw
KSk7DQo+ICvCoMKgwqDCoMKgwqAgZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09V
TlQoMCksIHJlZyk7DQo+ICDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gIMKgfQ0KPiANCj4g
QEAgLTUyNSw3ICs1MzksMTYgQEAgdm9pZCBkd2MzX2V2ZW50X2J1ZmZlcnNfY2xlYW51cChzdHJ1
Y3QgZHdjMyAqZHdjKQ0KPiANCj4gIMKgwqDCoMKgwqDCoMKgIGV2dCA9IGR3Yy0+ZXZfYnVmOw0K
PiANCj4gLcKgwqDCoMKgwqDCoCBldnQtPmxwb3MgPSAwOw0KPiArwqDCoMKgwqDCoMKgIGlmIChl
dnQtPmZsYWdzICYgRFdDM19FVkVOVF9QRU5ESU5HKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHByX2luZm8oImV2dC0+bGVuZ3RoIDoleFxuIiwgZXZ0LT5sZW5ndGgpOw0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9pbmZvKCJldnQtPmxwb3MgOiV4XG4iLCBl
dnQtPmxwb3MpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9pbmZvKCJldnQt
PmNvdW50IDoleFxuIiwgZXZ0LT5jb3VudCk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHByX2luZm8oImV2dC0+ZmxhZ3MgOiV4XG4iLCBldnQtPmZsYWdzKTsNCj4gKw0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkd2MzX2V4eW5vc19yZWdfZHVtcChkd2MpOw0KPiAr
wqDCoMKgwqDCoMKgIH0gZWxzZSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGV2
dC0+bHBvcyA9IDA7DQoNCkkgd2Fzbid0IGF3YXJlIG9mIHRoaXMgY2hhbmdlLg0KDQo+ICvCoMKg
wqDCoMKgwqAgfQ0KPiANCj4gPg0KPiA+PiAgIMKgZXZ0LT5jb3VudMKgwqDCoMKgIDoweDANCj4g
Pj4gICDCoGV2dC0+ZmxhZ3PCoMKgwqDCoCA6MHgxIC8vIFN0aWxsIEl0J3Mgbm90IGNsZWFyaW5n
IGluIGR1cmluZyByZXN1bWUuDQo+ID4+DQo+ID4+ICAgwqBEV0MzX0dFVk5UU0laKDApKDB4YzQw
OCnCoMKgwqDCoMKgwqAgOiAweDAwMDAwMDAwDQo+ID4+ICAgwqBEV0MzX0dFVk5UQ09VTlQoMCko
MHhjNDBjKcKgwqDCoMKgIDogMHgwMDAwMDAwMA0KPiA+PiAgIMKgRFdDM19EQ0ZHKDB4YzcwMCnC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA6IDB4MDAwODA4MDANCj4gPj4gICDCoERXQzNfRENU
TCgweGM3MDQpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgOiAweDAwZjAwMDAwDQo+ID4+ICAg
wqBEV0MzX0RFVlRFTigweGM3MDgpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA6IDB4MDAwMDAwMDAN
Cj4gPj4gICDCoERXQzNfRFNUUygweGM3MGMpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgOiAw
eDAwZDIwMDAxDQo+ID4+DQo+ID4gUGxlYXNlIGhlbHAgbG9vayBpbnRvIHlvdXIgcGxhdGZvcm0g
dG8gc2VlIHdoYXQgY29uZGl0aW9uIHRyaWdnZXJzIHRoaXMNCj4gPiBtZW1vcnkgYWNjZXNzIGlz
c3VlLiBJZiB0aGlzIGlzIGEgaGFyZHdhcmUgcXVpcmssIHdlIGNhbiBwcm9wZXJseSB1cGRhdGUN
Cj4gPiB0aGUgY2hhbmdlIGFuZCBub3RlIGl0IHRvIGJlIHNvLg0KPiANCj4gU3VyZSBJIHdpbGwg
dHJ5IHRvIGZpZ3VyZSBpdCBvdXQuIEhvd2V2ZXIsIHdlIGFyZSBmYWNpbmcgY2hhbGxlbmdlcyBp
biANCj4gcmVwcm9kdWNpbmcgdGhlIGlzc3VlLiBUaGVyZSBjb3VsZCBiZSBhIGRlbGF5IGluIHVu
ZGVyc3RhbmRpbmcgdGhlIA0KPiBjb25kaXRpb25zIHRoYXQgdHJpZ2dlciB0aGUgbWVtb3J5IGlz
c3VlIGlmIGl0IGlzIHJlbGF0ZWQgdG8gYSBtZW1vcnkgaXNzdWUuDQo+IA0KPiA+DQo+ID4gVGhh
bmtzLA0KPiA+IFRoaW5oDQo+ID4NCj4gPiAoSWYgcG9zc2libGUsIGZvciBmdXR1cmUgdGVzdHMs
IHBsZWFzZSBkdW1wIHRoZSBkd2MzIHRyYWNlcG9pbnRzLiBNYW55DQo+ID4gdGhhbmtzIGZvciB0
aGUgdGVzdHMuKQ0KPiANCj4gSSB0cmllZCB0byBnZXQgZHdjMyB0cmFjZXMgaW4gdGhlIGZhaWx1
cmUgY2FzZSwgYnV0IHNvIGZhciBubyBpbnN0YW5jZXMgDQo+IGhhdmUgYmVlbiByZXBvcnRlZC4g
T3VyIHRlc3RpbmcgaXMgc3RpbGwgaW4gcHJvZ3Jlc3Mgd2l0aCBlbmFibGUgZHdjMyANCj4gdHJh
Y2VzLg0KPiANCj4gSSB3aWxsIGtlZXAgcG9zdGluZyBvbmNlIEkgZ2V0IHRoZSBkd2MzIHRyYWNl
cyBpbiB0aGUgZmFpbHVyZSBzY2VuYXJpby4NCj4gDQoNClRoYW5rcyBmb3IgdGhlIHVwZGF0ZS4g
SSBob3BlIGVuYWJsaW5nIG9mIHRoZSBkcml2ZXIgdHJhY2Vwb2ludHMgd2lsbA0Kbm90IGltcGFj
dCB0aGUgcmVwcm9kdWN0aW9uIG9mIHRoZSBpc3N1ZS4gV2l0aCB0aGUgZHJpdmVyIGxvZywgd2Un
bGwgZ2V0DQptb3JlIGNsdWVzIHRvIHdoYXQgd2FzIGdvaW5nIG9uLg0KDQpUaGFua3MsDQpUaGlu
aA==

