Return-Path: <linux-kernel+bounces-309647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD0A966E4E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8FC289FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB5A1B970;
	Sat, 31 Aug 2024 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NZuGxDsP";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gJJ/N3OG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="S5RoK2qz"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C7210E7;
	Sat, 31 Aug 2024 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725065477; cv=fail; b=HaxmmN7CK0OEZ+t19I8kgefxnHX+RUhHISnUo73iQ1i7R/KFo61Rlw4mTI3dIEeJtSNSjkjc0ObbTQDEKdeb1a3+RKyliG6ONPiOzEZP8h3/CR/zexXkJkn3ZAvYWvqm7sBoYlgMV0uIDmTPS3/3XHRII5dgmPCGKHtXT73+YKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725065477; c=relaxed/simple;
	bh=6SqkenvoCtNDheA8qncRzGs9CCLqrqMk3s9czjKGY40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K739A9bOTVGcNENq4HqSFb9p7Xf2peeiNuL0uy/9zZLpzwrM7F3lkE5rknFAGN97V3fDfGe+ZDjyewEmx3G4g/ZEcfDhhLwnhme6Uzg0bm9xcmpKXPwn7hnEGSGyf1PhSIy2gpbAguSfHp+lQVGHRbZWvFuO5NbUl/XBia0x2c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NZuGxDsP; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gJJ/N3OG; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=S5RoK2qz reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UMR6im013454;
	Fri, 30 Aug 2024 17:51:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=6SqkenvoCtNDheA8qncRzGs9CCLqrqMk3s9czjKGY40=; b=
	NZuGxDsPc+ZbmFX7ZtjW5uQoIH937c7olni1+3j3ESa4KQIQrm3Go4zktlpJrftK
	PorUtr0ZotCfL8IuwUT/wfLOPcP1a7WzI8I3aGkNCGdMOmpczl3897TmipUg2kLk
	iaCwkaOYajRmnVhZCjk9R9o8q+bAvzfD6ARb5SHYJjgiZl6guyJyMno3ZGH74PO0
	+ehEn5gklEfQBEDQqOFmDcf28+hywk8v7gf0jFJTo9fnw2liB0A4EzACF70ntmag
	AlE66FjPIhnKAGZk6CSZ3tne06y+zACM4K0UQVQ88CQ2/2olvQZ6cntVXFFJva4P
	Op1rtmrE9qg5qj9v6cDoTg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 41bpvv09mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 17:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1725065461; bh=6SqkenvoCtNDheA8qncRzGs9CCLqrqMk3s9czjKGY40=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gJJ/N3OGBm6FzBLdv3ksDgIUKM00Q8EDlC/CFZcOOanX/+Y5IZEeb7Pgga5/QUx+0
	 BMfYBNmyie2b3Xbfm4I9Fj9gZmb+NfsZxG4bFwcSifZDKJ/NDNoim3stPPnLxyH92u
	 mYCfKobH8TBGXHRipUk8KaQPBhjzo1/3WtKt+HqlT5QNd+lnRxHvU+z3F+AcK6xXvC
	 bM2r1OlgbF1ogZSAe1VQoWY+ieo0AGw+oJGJCwZGCruHM8nX0/HlEQdspB1e+oxcUh
	 7+C0pTPt4PsKA2bD1Km0VD7AEXO9coDF6YJEAXzaSSPPt50b/21/4rSVHj6+iXcgbO
	 gJMLFD2tRuPSw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C18FF40346;
	Sat, 31 Aug 2024 00:51:00 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5B55DA00A5;
	Sat, 31 Aug 2024 00:51:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=S5RoK2qz;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5D17540354;
	Sat, 31 Aug 2024 00:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5cTNw3PLRbjhoDpZYwsA6rPv9KbHYq/b+aR2Tcj3R5JxBUk4DcyjXEt+DkjND75MhcAa6fWUfC8ac22mUCmqi85PEhiAsb5hP1b1RIxoA04np81ApZM+tDtVN0+edsFuJKo2vBsoyTfNwCItFw4bz81hZtdkBW5nnIia+wEPIdPb1R+ozxMIVE2fnuPeiQ805RV7mcpgpklJvFZ0MlcQ3r1qtpMgMWsFlRywZu1H2v2it3RYv+uC3sTS4Ab8spH4P2Un/hiLBOnPX9t4eqhieuf/yVzf28knVDVhSvLd8e+TdZZ1qyEsnV6PzCYLLL6wOs11WjZGZ9BXKHx2Ls2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SqkenvoCtNDheA8qncRzGs9CCLqrqMk3s9czjKGY40=;
 b=L+mPjakvIze4P7zVByVEEJopctosDVZvthMMb3jwZrW2vBCuDmskKAddev6XyPkoGhlIcH/IumMFy2t8uX0ZlLDjX0/ObKuLKspi1YItzl18nn2ZVoNyumfSQ4jHrvaOq8uGZGDyKDK3jOTbT/eSeuWii7s8j67Y3GwjXxi1/P3Jdl8Yq9gat92Enu5A+6BosXcnF5esmZIPwiSNbyVK/Rzr9fOWbs2f5jP3eTrnGCY96jw1hsNk+yLbDDcqrLL/xdTdyzuBOzCr8Z/NDV7G1NJBaSYbeyavvXMkN4QlShAF/Uj2lBlh6apbH5o6Op9DZI5WkaU66iF0+3efmyP1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SqkenvoCtNDheA8qncRzGs9CCLqrqMk3s9czjKGY40=;
 b=S5RoK2qzRDDvyc4pDkvtavBrL6MiUfu0e6zm6SBzFPe5GkQwoOcbE0Pg/+4JytKEhuPI3RRwzXkZxYNJVO0jK0EIgh2+UUv0G96BEEs89vUsSm2zugl5L0IvkaQqbmvXZqja8fvV9bRWMjhabqMIIPOUmva/l37GorjygAinqC4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.27; Sat, 31 Aug 2024 00:50:55 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7897.027; Sat, 31 Aug 2024
 00:50:55 +0000
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
 AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AIAAVgGAgAK0ooCAIEFKAIAA0sIA
Date: Sat, 31 Aug 2024 00:50:55 +0000
Message-ID: <20240831005046.5lndwdr7cfm3k3to@synopsys.com>
References:
 <CGME20240719110149epcas5p3dd468685a095c094ed2e540279bf3ec2@epcas5p3.samsung.com>
 <20240719110100.329-1-selvarasu.g@samsung.com>
 <20240807003806.5owtgwgw2lczg4u5@synopsys.com>
 <b6baeb45-1684-4fcb-8c71-392cb4788c85@samsung.com>
 <20240808011536.oid627ez4ppdfkhp@synopsys.com>
 <b48e7aba-6c54-431f-bbb5-3e5490df0c1a@samsung.com>
 <20240809234227.eriwy5e6leatzdyh@synopsys.com>
 <b273201d-c589-4c57-9d57-ad2affaeade0@samsung.com>
In-Reply-To: <b273201d-c589-4c57-9d57-ad2affaeade0@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS7PR12MB6096:EE_
x-ms-office365-filtering-correlation-id: 25048890-c294-4d2c-4adf-08dcc956f8b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OXJDaUpUa2psbzZJWk5NNGNvT1VkdlBJYzllT3JqTkl1c29ZRG1jbjlwakE0?=
 =?utf-8?B?Unk1UzBZbGoxM2hISW44aUpyNkFnMlVIdE5TaXVYZTJMVmdPenJiMGdQNFZW?=
 =?utf-8?B?dGNFZU8vYWNTQURkK0c2cXRHdWhEcUdPbVpjd1g4dW1qVjFwQ2xTVDM2WmxO?=
 =?utf-8?B?VGZIZldQWTIvYStwS0RtZlF0UmJiWkRnZGNsUXRRY3I2bUVGNXBtSThlZlBM?=
 =?utf-8?B?N0lUUFVrOUhsVS9UK0d3cjVWT2F4ZWdiRDhodDVMZWt1cUtFYUMzTGFBdmZT?=
 =?utf-8?B?c1gxNmZERzVHNmdqRTdIdnE2THdMM09MV29YL3ExUDBaU2xYY3JBbEZvMlpE?=
 =?utf-8?B?UmVlY1RwT252MExpSi9ENFBDQkhqeE1wNUF2cWY0bTJNZ1ZNdHlwMFR4N1d1?=
 =?utf-8?B?dm1jd3hNU1gweFBFRHI0dUd5UDN3VkpiRnM3aUVmZ2pLWktTWFVLYmhUNzhW?=
 =?utf-8?B?WWprYkJxNDhLZk9YdHcxUWMvak54aktHWXZVTDIxWk1RQm5XaHpzRSs2R3M1?=
 =?utf-8?B?bkl3RU9YTjVCUnRDQXJYZjNXTnEwZEVlQW5tT2h6dVU3eUJ6RCsvUFdGMHpr?=
 =?utf-8?B?a204YmkyS09MbG91b3B5NXFZazE1N0pVd2xMR0ZQNi9zdVVzZTRpNjZoVmVE?=
 =?utf-8?B?aDE3UDdSdDQ3T0Rab2gyU2VBbmhCcytqMDBnejZvbVdyWXREWWx3MkdlSHlr?=
 =?utf-8?B?cVRqWTA3cW1sMjByNG5NRnhwVmhJSGxrbjI4NVlXQ0JVclRGUGxlTUkwTzFw?=
 =?utf-8?B?NmxLTVhRYTdYQmpFcHV3VmR1Vml4Q3VzcmVhWWRKUVk0VndwRThGL2ZVQ3RK?=
 =?utf-8?B?T1JyLzdhNmxqWERBMEJyS3RvV2tiWUxyNDFEbmlHVDgycDlZYnBFMEdMOE5t?=
 =?utf-8?B?ck9QbFVtMEoxSVI0eFJMWC8rOGlxNzUrMVFpMDhjcGxFS1lodHpZZS9oWlBQ?=
 =?utf-8?B?ZXhaQzI1ZW13SFJHbEFkMVROcDY0WHFOa2Z4SDJwclBwdHpYL2VNRWhnNHRn?=
 =?utf-8?B?aWZNSHZiWldXYldkeExpOUx0cVppSFJYalhQQ1JXaFE3WEsrWlZkK3JDbzhm?=
 =?utf-8?B?K0tzcC9xTlZ4Yko3SEtiUmNmdDhEYXlDdVpiMWR3S3ZLR0lqU2VkbmVkbVA4?=
 =?utf-8?B?eHJsRVpkTE83bXV5OSs5ZFBIR3VNZWR6M2NEdjF1Nm54eTFmZWllbEF3Q0hC?=
 =?utf-8?B?ZTZRZ3lFMFVVRFAxck16cUV1OWMvOU9WT1BCSjVqWkZLSjc0a2dTbEFFb1Jv?=
 =?utf-8?B?SFdzL3VOMFBka3pJMTFhVnFGZGJYd3RsMkVXNVFTZVAwaXpzc3RMM1BFM3lz?=
 =?utf-8?B?REhNdTE4Q211aTN2RUl2T0VlL1NidlNBeTZCdVNaZWVaazFYV0k0ZFd6T3RW?=
 =?utf-8?B?T09SOVgxelpXOFBwTy9UUWZyY1g4TjFKL21hUERqS3k3eWtOMnk5S3pkNmJH?=
 =?utf-8?B?UFRIQ2w2c1dJRFZ5V2xoTDRTc0trbk8rU1h1RW85SkJjeVgvN0c1RHJJVzBa?=
 =?utf-8?B?TjV6N3kwRXFqSlI5STlpa1l3R3lMeGpUY0E5N2RhdjZyaTcvcXVkRkJIeVha?=
 =?utf-8?B?bmtFMUoxU1B0T2JlUnVXYkk1MVBCaGY1T256MjhZakorZ3gvTUhtUUVLSDF5?=
 =?utf-8?B?cStxVHZwUjg1UE5PM0t2WkNubE93WkU4c3RGZzUzU09xclJXbUJ5UUp1ckVn?=
 =?utf-8?B?NEVvRnN2N2VpR1JzK3dDeStVMmY5b250QUNxRTFQQVhmclorbEJ0cWV0QnFR?=
 =?utf-8?B?SUtkWVUxeHdGcnhKZWpzMmcrRXZqZ2xaZHlndG5Rdk1JV3k0WExadmhpQXJI?=
 =?utf-8?B?M1pHR0NhalZNK3NCSmRZY2xrRWdwdnJTc21HR0htVmxUbVlkVGRqS0pmQW5Y?=
 =?utf-8?B?NXRWNFp2Q3ZUOFkyVksxTi9vdGNqRVJtbWk2U1dmSGw2cEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWU0Y0M4Z1NBTk93T0M1LzZ3ek5tSjNGcUl3U0FSODVLUENaQTU4ajdzZ2ND?=
 =?utf-8?B?S0hrN053RUFBQ2ZNY2tDUjJPTGFXcnNiUzNsQ2c2T3p2U2VlOEFGS2NvN2Zz?=
 =?utf-8?B?NTZmVmxxa0dsVCs2UUhEQzlydlJpMEdaR3pGS3ptQndSSjRtVFI0M1ZTTmtv?=
 =?utf-8?B?MG5SQlZTMzZNaW0wcTJSUEVhaVVqeEhTSHVxUjkrdm51U1Eyb3prQlRLWXpE?=
 =?utf-8?B?QjNBQ2JVcE4wVlVDZjZQTTNYSG1Ub0d1bndSaEF3REVvanJvbFJHRzRPZlFX?=
 =?utf-8?B?Y0F2MzVncDZyRTFJaVhibW03RU1tcHJVVExxVkF4TVl2Qm4rRUZOd1FNUTRW?=
 =?utf-8?B?SU5KWnpQVkVuVWhvTCtFci8xWGVlUkUyNFViNS9TS0YzVEJxTTBYUUQ1enkw?=
 =?utf-8?B?Q3lIUkpxbVNJWll1Q1FUd0c5b29DYjlMN2JUa0dCSXRNNWN6S0s1WVh2dXhw?=
 =?utf-8?B?T0dVTGJwT1JsaHhOY0RlaFptTkRpakM2a2I2dkQrcGprVnc4ZmNtNm1rZkt1?=
 =?utf-8?B?OWoxTFFrcDc3NHFSSTlkYjBBSndPb0lCTmorS3hvK3NkOXlobTArUGtGL0ZB?=
 =?utf-8?B?Umh4eEk4Q01laWplUU5MS09aTGFFU1pqR1hCTVNFbTJDSlRqQjFuak5Lc1hK?=
 =?utf-8?B?RmxXdEVHcXdYUDkyTFIxR3E3RURoZ3BvMDI2dGVSYWpzOU9oMkFTZi93aXlz?=
 =?utf-8?B?cCsvT0FrT1V5cXZabzM4eWV3WGhyT3Zqdm5jUnBzcU1PREo4QXYyOXMreGsy?=
 =?utf-8?B?MmlMc3lGbGM3THYybCt1TExWN2pEeGZkM1JSbUlOTVF0MHlGWENYSmFCTy85?=
 =?utf-8?B?dUpvdVJZRmJhc0VRa3pzWjdyeEJjMDZMb0dGZC9TUEsrVjhoSmQ0VUQzcUl2?=
 =?utf-8?B?SXhsQlJmaVlKSkhSU2tEclFhSTFOQy9oZUoyc2xVaWV3UG5pQXppejV4VGJW?=
 =?utf-8?B?MnhIZVlqczU0aHRndHh1NGxwUFBCRmZOeG9XMmV3Z0V0eC8xSkhIdXp1Nm1P?=
 =?utf-8?B?KzhKdG5SQkFiWS9VWUxDNmN1UmxUU3Zmcld0WmdqOUxBREZpem1tc2lXbTcx?=
 =?utf-8?B?b1o4VzF5b01PZ0hoSitXQW42RnNLbFdNbGV2SXJCTzgvTzJaM241SXhJeEtW?=
 =?utf-8?B?dHlSMG43aDlkZS9YWEhjazZ0Z29lbEJUOXpOcmY2R2F4UFVmYWZFeG13eWt4?=
 =?utf-8?B?U01EWittNERJYjhHeU10Rm1FV1hIbnlKNHZmT1UyUVFVbFBBbld3Z1UrSENY?=
 =?utf-8?B?V3FNcUVqcHY2a3FxY2N4WTk2OVRvcktQQWdvQTRPWllqd0hhZitad0NwTkRE?=
 =?utf-8?B?Zkxha05jYVdxZmdUVmd2MU5qeElwcnZTNnp2VGxjVVFEaGp0TlAycm15TE9V?=
 =?utf-8?B?ZFlIbExOMHBxUkpMaTdHNVFoWkNtVjQ3OTVSUVQwZmF2UzFBdG83UHh2OUJu?=
 =?utf-8?B?eDZ1Zk5CeU90b3QrYjY4Z0FKNjI0YXBGcTY4K0R3Rk1lQmp4RjJmSGxvZFh5?=
 =?utf-8?B?b3cwTzJRZ1NJa0s5aXVLZHhpN0dqTTBaMm1FcitweGdBVDJSeUxMRkc2WlJZ?=
 =?utf-8?B?cWx3dkQ2alFoWko2RmJvMEU2SXczdVFzdEtrRDZLN3JYTGl4RjRiOXVSVUlR?=
 =?utf-8?B?MFB2WHBzeUMvZE41L3pDY0o4VkE5OUlQUmR1a3dEYS92aFlwUXo0Wk16cFd6?=
 =?utf-8?B?bmVwdG9wZE0zekI0OFpQSmcwRno3SnlVUkorcVE3b24xTTcwTFowT1FTOFZl?=
 =?utf-8?B?LzRmSlVjejFlbGhuMjFGcy9NUlBzUGd3WTFpb0dNSTZwMXJEajZJdkZLanhN?=
 =?utf-8?B?cklwK2hlQ0NBc1lJSXplT2tDRHJWakR6Y09WSnZwVmlkYXJhU3JvN2FvMitC?=
 =?utf-8?B?NHlvNXNzUkVtTVQ1bGlWTnVuQmJYdmo0Qm94d1ZJQnFjZ2Q2bHY1aXhvYTVh?=
 =?utf-8?B?RFVEVStsWVcyMmw2U0lwYzlVQTBPdnhzN1c5QjJoOUtpWC9sUGF5MVBBc1pZ?=
 =?utf-8?B?K3hUTElWQ2h2NDZwSDdOV0dVblIyU0RCdmtJQVA1OTdkOHBmOGFZNW9pLzM3?=
 =?utf-8?B?SnNCMGQ0NTJkeFBiNnFwSmxEcnNpTlRoWTAzeE4vNFdWZWVOZnBqTkhEQmVR?=
 =?utf-8?Q?BMjnE0a8StAN5z9BHqshN45zx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7DC0534EC3976479F7ABB39AF386175@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Myt5X6MZ+55BG0gZCNQ+UY4ocqzlgjX5OT9SCyCP+n6/jcsNeS3sMMYhyxMOUrS0gxgDDOju+uPMs9i62ZbV9QISQapvwkBWm513ZWN3aIsaIFyPaNzasBfWkq1uBtyzVOrZEXDDzEG76U2RwpbpoVqUcCAv+IDcHZKJtzBw3dNU6HDmyEMQ0iWurSssRb204EoHM8g6fVIjkZ2k0QO39kPF9c/ycPULwQhZ4Ghg3n+zjQeU4I9ZanzMKNxC/cBp2r3thy941xoqxW/mJ6lNxzzXnXaY13Bt1uiMEie7NMljTz5OnXrM0KVnwJpLtCQiqc6iCwO1LQtBfeCnEQyO8wJGbD2olNMpQ25xf343OMx1AHd1v30/4nKL5Lze0/ZeCQoMkF9ayBFqn2Ja+/8pRj77SFunpjv4kawLN3OXGXOiHG/E9fQTrGsEj2Fj7mYNkD28XEux73J37X6bq6MpCWi0gFu6Z/579ycRfO66aH5t15WTPkBROJiF/fq7eJ5Zo/9jWhgrHBq5VV2sfT8CVqtO69zU8k6YHo0kYBWC3ZUx61XljOfwVxcoH7u3GI3J0qu0zJWdrPru63YcxY5yD/8zH2rzjz9+h/H3Xcqa3FQcIzI4tN35RyuOAvVV0I9n/tqA5GqIge5t+Sniv3qCVw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25048890-c294-4d2c-4adf-08dcc956f8b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2024 00:50:55.6649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XISb/wArVUYK0mhh/40D9F8LaTHEo9ledDTYT5NkVrIug5iXMZSzp5a0z2wTtHELsnClMmSc8f1usN2lFZq+mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-Authority-Analysis: v=2.4 cv=ZI6Fmm7b c=1 sm=1 tr=0 ts=66d268f6 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=hD80L64hAAAA:8 a=xccHyP5yBSD0ifJCz6QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EPrYyTzksRJPwUS32u0gtE099q9nshVw
X-Proofpoint-ORIG-GUID: EPrYyTzksRJPwUS32u0gtE099q9nshVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_12,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408310004

SGkgU2VsdmFyYXN1LA0KDQpPbiBGcmksIEF1ZyAzMCwgMjAyNCwgU2VsdmFyYXN1IEdhbmVzYW4g
d3JvdGU6DQo+IA0KPiBPbiA4LzEwLzIwMjQgNToxMiBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0K
PiA+IE9uIFRodSwgQXVnIDA4LCAyMDI0LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4gPj4g
T24gOC84LzIwMjQgNjo0NSBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+Pj4gT24gV2VkLCBB
dWcgMDcsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiA+Pj4+IE9uIDgvNy8yMDI0
IDY6MDggQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4+Pj4gT24gRnJpLCBKdWwgMTksIDIw
MjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiA+Pj4+Pj4gSW4gY2VydGFpbiBzY2VuYXJp
b3MsIHRoZXJlIGlzIGEgY2hhbmNlIHRoYXQgdGhlIENQVSBtYXkgbm90IGJlDQo+ID4+Pj4+PiBz
Y2hlZHVsZWQgdGhlIGJvdHRvbSBoYWxmIG9mIGR3YzMgaW50ZXJydXB0LiBUaGlzIGlzIGJlY2F1
c2UgdGhlIENQVQ0KPiA+Pj4+Pj4gbWF5IGhhbmcgdXAgd2hlcmUgYW55IHdvcmsgcXVldWUgbG9j
a3VwIGhhcyBoYXBwZW5lZCBmb3IgdGhlIHNhbWUgQ1BVDQo+ID4+Pj4+PiB0aGF0IGlzIHRyeWlu
ZyB0byBzY2hlZHVsZSB0aGUgZHdjMyB0aHJlYWQgaW50ZXJydXB0LiBJbiB0aGlzIHNjZW5hcmlv
LA0KPiA+Pj4+Pj4gdGhlIFVTQiBjYW4gZW50ZXIgcnVudGltZSBzdXNwZW5kIGFzIHRoZSBidXMg
bWF5IGlkbGUgZm9yIGEgbG9uZ2VyIHRpbWUNCj4gPj4+Pj4+ICwgb3IgdXNlciBjYW4gcmVjb25u
ZWN0IHRoZSBVU0IgY2FibGUuIFRoZW4sIHRoZSBkd2MzIGV2ZW50IGludGVycnVwdA0KPiA+Pj4+
Pj4gY2FuIGJlIGVuYWJsZWQgd2hlbiBydW50aW1lIHJlc3VtZSBpcyBoYXBwZW5pbmcgd2l0aCBy
ZWdhcmRsZXNzIG9mIHRoZQ0KPiA+Pj4+Pj4gcHJldmlvdXMgZXZlbnQgc3RhdHVzLiBUaGlzIGNh
biBsZWFkIHRvIGEgZHdjMyBJUlEgc3Rvcm0gZHVlIHRvIHRoZQ0KPiA+Pj4+Pj4gcmV0dXJuIGZy
b20gdGhlIGludGVycnVwdCBoYW5kbGVyIGJ5IGNoZWNraW5nIG9ubHkgdGhlIGV2dC0+ZmxhZ3Mg
YXMNCj4gPj4+Pj4+IERXQzNfRVZFTlRfUEVORElORywgd2hlcmUgdGhlIHNhbWUgZmxhZyB3YXMg
c2V0IGFzIERXQzNfRVZFTlRfUEVORElORw0KPiA+Pj4+Pj4gaW4gcHJldmlvdXMgd29yayBxdWV1
ZSBsb2NrdXAuDQo+ID4+Pj4+PiBMZXQncyBjb25zaWRlciB0aGUgZm9sbG93aW5nIHNlcXVlbmNl
cyBpbiB0aGlzIHNjZW5hcmlvLA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IENhbGwgdHJhY2Ugb2YgZHdj
MyBJUlEgYWZ0ZXIgd29ya3F1ZXVlIGxvY2t1cCBzY2VuYXJpbw0KPiA+Pj4+Pj4gPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4+Pj4+PiBJ
UlEgIzE6DQo+ID4+Pj4+PiAtPmR3YzNfaW50ZXJydXB0KCkNCj4gPj4+Pj4+ICAgICAgLT5kd2Mz
X2NoZWNrX2V2ZW50X2J1ZigpDQo+ID4+Pj4+PiAgICAgICAgICAgIC0+aWYgKGV2dC0+ZmxhZ3Mg
JiBEV0MzX0VWRU5UX1BFTkRJTkcpDQo+ID4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4+Pj4+PiAgICAgICAgICAgIC0+ZXZ0LT5mbGFncyB8PSBE
V0MzX0VWRU5UX1BFTkRJTkc7DQo+ID4+Pj4+PiAgICAgICAgICAgIC0+LyogRGlzYWJsZSBpbnRl
cnJ1cHQgYnkgc2V0dGluZyBEV0MzX0dFVk5UU0laX0lOVE1BU0sgIGluDQo+ID4+Pj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERX
QzNfR0VWTlRTSVoNCj4gPj4+Pj4+ICAgICAgICAgICAgLT5yZXR1cm4gSVJRX1dBS0VfVEhSRUFE
OyAvLyBObyB3b3JrcXVldWUgc2NoZWR1bGVkIGZvciBkd2MzDQo+ID4+Pj4+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGhyZWFkX2Z1IGR1ZSB0byB3b3JrcXVldWUg
bG9ja3VwDQo+ID4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZXZlbiBhZnRlciByZXR1cm4gSVJRX1dBS0VfVEhSRUFEDQo+ID4+Pj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZnJvbSB0b3AtaGFsZi4NCj4gPj4+Pj4+DQo+ID4+
Pj4+PiBUaHJlYWQgIzI6DQo+ID4+Pj4+PiAtPmR3YzNfcnVudGltZV9yZXN1bWUoKQ0KPiA+Pj4+
Pj4gICAgIC0+ZHdjM19yZXN1bWVfY29tbW9uKCkNCj4gPj4+Pj4+ICAgICAgIC0+ZHdjM19nYWRn
ZXRfcmVzdW1lKCkNCj4gPj4+Pj4+ICAgICAgICAgIC0+ZHdjM19nYWRnZXRfc29mdF9jb25uZWN0
KCkNCj4gPj4+Pj4+ICAgICAgICAgICAgLT5kd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoKQ0KPiA+
Pj4+Pj4gICAgICAgICAgICAgICAtPi8qRW5hYmxlIGludGVycnVwdCBieSBjbGVhcmluZyAgRFdD
M19HRVZOVFNJWl9JTlRNQVNLIGluDQo+ID4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERXQzNfR0VWTlRTSVoqLw0KPiA+Pj4+
Pj4NCj4gPj4+Pj4+IFN0YXJ0IElSUSBTdG9ybWluZyBhZnRlciBlbmFibGUgZHdjMyBldmVudCBp
biByZXN1bWUgcGF0aA0KPiA+Pj4+Pj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4+Pj4+PiBDUFUwOiBJUlENCj4gPj4+Pj4+IGR3
YzNfaW50ZXJydXB0KCkNCj4gPj4+Pj4+ICAgICBkd2MzX2NoZWNrX2V2ZW50X2J1ZigpDQo+ID4+
Pj4+PiAgICAgICAgICAgIGlmIChldnQtPmZsYWdzICYgRFdDM19FVkVOVF9QRU5ESU5HKQ0KPiA+
Pj4+Pj4gICAgICAgICAgICAgcmV0dXJuIElSUV9IQU5ETEVEOw0KPiA+Pj4+Pj4NCj4gPj4+Pj4+
IENQVTA6IElSUQ0KPiA+Pj4+Pj4gZHdjM19pbnRlcnJ1cHQoKQ0KPiA+Pj4+Pj4gICAgIGR3YzNf
Y2hlY2tfZXZlbnRfYnVmKCkNCj4gPj4+Pj4+ICAgICAgICAgICAgaWYgKGV2dC0+ZmxhZ3MgJiBE
V0MzX0VWRU5UX1BFTkRJTkcpDQo+ID4+Pj4+PiAgICAgICAgICAgICByZXR1cm4gSVJRX0hBTkRM
RUQ7DQo+ID4+Pj4+PiAuLg0KPiA+Pj4+Pj4gLi4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBUbyBmaXgg
dGhpcyBpc3N1ZSBieSBhdm9pZGluZyBlbmFibGluZyBvZiB0aGUgZHdjMyBldmVudCBpbnRlcnJ1
cHQgaW4NCj4gPj4+Pj4+IHRoZSBydW50aW1lIHJlc3VtZSBwYXRoIGlmIGR3YzMgZXZlbnQgcHJv
Y2Vzc2luZyBpcyBpbiBwcm9ncmVzcy4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBTaWduZWQtb2ZmLWJ5
OiBTZWx2YXJhc3UgR2FuZXNhbiA8c2VsdmFyYXN1LmdAc2Ftc3VuZy5jb20+DQo+ID4+Pj4+PiAt
LS0NCj4gPj4+Pj4+ICAgICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDggKysrKysrLS0NCj4g
Pj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4+Pj4+PiBpbmRleCBjYjgyNTU3Njc4ZGQu
LjYxMDc5MmE3MDgwNSAxMDA2NDQNCj4gPj4+Pj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+ID4+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+Pj4+Pj4gQEAg
LTU0OSw4ICs1NDksMTIgQEAgaW50IGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPiA+Pj4+Pj4gICAgIAkJCWxvd2VyXzMyX2JpdHMoZXZ0LT5kbWEpKTsNCj4gPj4+
Pj4+ICAgICAJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQURSSEkoMCksDQo+ID4+
Pj4+PiAgICAgCQkJdXBwZXJfMzJfYml0cyhldnQtPmRtYSkpOw0KPiA+Pj4+Pj4gLQlkd2MzX3dy
aXRlbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRTSVooMCksDQo+ID4+Pj4+PiAtCQkJRFdDM19HRVZO
VFNJWl9TSVpFKGV2dC0+bGVuZ3RoKSk7DQo+ID4+Pj4+PiArDQo+ID4+Pj4+PiArCS8qIFNraXAg
ZW5hYmxlIGR3YzMgZXZlbnQgaW50ZXJydXB0IGlmIGV2ZW50IGlzIHByb2Nlc3NpbmcgaW4gbWlk
ZGxlICovDQo+ID4+Pj4+PiArCWlmICghKGV2dC0+ZmxhZ3MgJiBEV0MzX0VWRU5UX1BFTkRJTkcp
KQ0KPiA+Pj4+Pj4gKwkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UU0laKDApLA0K
PiA+Pj4+Pj4gKwkJCQlEV0MzX0dFVk5UU0laX1NJWkUoZXZ0LT5sZW5ndGgpKTsNCj4gPj4+Pj4+
ICsNCj4gPj4+Pj4+ICAgICAJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09VTlQo
MCksIDApOw0KPiA+Pj4+Pj4gICAgIA0KPiA+Pj4+Pj4gICAgIAlyZXR1cm4gMDsNCj4gPj4+Pj4+
IC0tIA0KPiA+Pj4+Pj4gMi4xNy4xDQo+ID4+Pj4+Pg0KPiA+Pj4+PiBXZSdyZSBub3Qgd2FraW5n
IHVwIGZyb20gYSBoaWJlcm5hdGlvbi4gU28gYWZ0ZXIgYSBzb2Z0LXJlc2V0IGFuZA0KPiA+Pj4+
PiByZXN1bWUsIHRoZSBldmVudHMgdGhhdCB3ZXJlbid0IHByb2Nlc3NlZCBhcmUgc3RhbGUuIFRo
ZXkgc2hvdWxkIGJlDQo+ID4+Pj4+IHByb2Nlc3NlZCBwcmlvciB0byBlbnRlcmluZyBzdXNwZW5k
IG9yIGJlIGRpc2NhcmRlZCBiZWZvcmUgcmVzdW1lLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBUaGUgc3lu
Y2hyb25pemVfaXJxKCkgZHVyaW5nIHN1c3BlbmQoKSB3YXMgbm90IHN1ZmZpY2llbnQgdG8gcHJl
dmVudA0KPiA+Pj4+PiB0aGlzPyBXaGF0IGFyZSB3ZSBtaXNzaW5nIGhlcmUuDQo+ID4+Pj4+DQo+
ID4+Pj4+IFRoYW5rcywNCj4gPj4+Pj4gVGhpbmgNCj4gPj4+PiBJIGRvbuKAmXQgdGhpbmsgdGhl
IHRyaWdnZXJpbmcgb2YgaW50ZXJydXB0IHdvdWxkIG5vdCBiZSBzdG9wcGVkIGV2ZW4gaWYNCj4g
Pj4+PiBkbyBzb2Z0IHJlc2V0LiBJdCdzIGJlY2F1c2Ugb2YgZXZlbnQgY291bnQgaXMgbWF5IGJl
IHZhbGlkIC4NCj4gPj4+IE9rLiBJIHRoaW5rIEkgc2VlIHdoYXQgeW91J3JlIHJlZmVycmluZyB0
byB3aGVuIHlvdSBzYXkgImV2ZW50IGlzDQo+ID4+PiBwcm9jZXNzaW5nIGluIHRoZSBtaWRkbGUi
IG5vdy4NCj4gPj4+DQo+ID4+PiBXaGF0IHlvdSB3YW50IHRvIGNoZWNrIGlzIHByb2JhYmx5IHRo
aXMgaW4gZHdjM19ldmVudF9idWZmZXJzX3NldHVwKCkuDQo+ID4+PiBQbGVhc2UgY29uZmlybToN
Cj4gPj4+DQo+ID4+PiBpZiAoZHdjLT5wZW5kaW5nX2V2ZW50cykNCj4gPj4+IAlkd2MzX3dyaXRl
bChkd2MtPnJlZ3MsIERXQzNfR0VWTlRTSVooMCksDQo+ID4+PiAJCQlEV0MzX0dFVk5UU0laX0lO
VE1BU0sgfCBEV0MzX0dFVk5UU0laX1NJWkUoZXZ0LT5sZW5ndGgpKTsNCj4gPj4+IGVsc2UNCj4g
Pj4+IAlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRTSVooMCksIERXQzNfR0VWTlRT
SVpfU0laRShldnQtPmxlbmd0aCkpOw0KPiA+PiBZZXMsIHdlIGFyZSBleHBlY3RpbmcgdGhlIHNh
bWUuIEJ1dCwgd2UgbXVzdCB2ZXJpZnkgdGhlIHN0YXR1cyBvZg0KPiA+PiBldnQtPmZsYWdzLCB3
aGljaCB3aWxsIGluZGljYXRlIHdoZXRoZXIgdGhlIGV2ZW50IGlzIGN1cnJlbnRseQ0KPiA+PiBw
cm9jZXNzaW5nIGluIG1pZGRsZSBvciBub3QuIFRoZSBiZWxvdyBjb2RlIGlzIGZvciB0aGUgcmVm
ZXJlbmNlLg0KPiA+Pg0KPiA+PiBpZiAoIShldnQtPmZsYWdzICYgRFdDM19FVkVOVF9QRU5ESU5H
KSkNCj4gPj4gCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HRVZOVFNJWigwKSwNCj4gPj4g
CQkJIERXQzNfR0VWTlRTSVpfU0laRShldnQtPmxlbmd0aCkpOw0KPiA+PiBlbHNlDQo+ID4+IAlk
d2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRTSVooMCksDQo+ID4+IAkJCURXQzNfR0VW
TlRTSVpfSU5UTUFTSyB8IERXQzNfR0VWTlRTSVpfU0laRShldnQtPmxlbmd0aCkpOw0KPiA+IFNv
LCB0aGlzIGhhcHBlbnMgd2hpbGUgcGVuZGluZ19ldmVudHMgaXMgc2V0IHJpZ2h0PyBJIG5lZWQg
dG8gcmV2aWV3DQo+ID4gdGhpcyBydW50aW1lIHN1c3BlbmQgZmxvdyBuZXh0IHdlZWsuIFNvbWV0
aGluZyBkb2Vzbid0IGxvb2sgcmlnaHQuIFdoZW4NCj4gPiB0aGVyZSdzIGEgc3VzcGVuZC9yZXN1
bWUgcnVudGltZSBvciBub3QsIHRoZXJlJ3MgYSBzb2Z0IGRpc2Nvbm5lY3QuIFdlDQo+ID4gc2hv
dWxkbid0IGJlIHByb2Nlc3NpbmcgYW55IGV2ZW50IHByaW9yIHRvIGdvaW5nIGludG8gc3VzcGVu
ZC4gQWxzbywgd2UNCj4gPiBzaG91bGRuJ3QgYmUgZG9pbmcgc29mdC1kaXNjb25uZWN0IHdoaWxl
IGNvbm5lY3RlZCBhbmQgaW4gb3BlcmF0aW9uDQo+ID4gdW5sZXNzIHdlIHNwZWNpZmljYWxseSB0
ZWxsIGl0IHRvLg0KPiBISSBUaGluaCwNCj4gDQo+IFdvdWxkIHlvdSBiZSBhYmxlIHRvIHJldmll
dyB0aGlzIHJ1bnRpbWUgc3VzcGVuZCBmbG93Pw0KPiANCj4gIEZyb20gb3VyIGVuZCwgYWZ0ZXIg
Y29uZHVjdGluZyBtdWx0aXBsZSByZWdyZXNzaW9uIHRlc3RzLCB3ZSBoYXZlIA0KPiBkZXRlcm1p
bmVkIHRoYXQgdGhlIHJlc2V0dGluZyBvZiAiZXZ0LT5mbGFncyIgYXJlIHN1ZmZpY2llbnQgd2hl
biANCj4gYXR0ZW1wdGluZyB0byBlbmFibGUgZXZlbnQgSVJRIG1hc2tzIGluc3RlYWQgb2YgZW5h
YmxlIGV2ZW50IElSUSBtYXNrIA0KPiBiYXNlZCBvbiBwZW5kaW5nIGV2ZW50IGZsYWdzLiBUaGVy
ZSBpcyBhIHBvc3NpYmlsaXR5IHRoYXQgcmVjb25uZWN0aW5nIA0KPiBVU0Igd2l0aCB0aGUgaG9z
dCBQQyBtYXkgY2F1c2UgZXZlbnQgaW50ZXJydXB0cyB0byBiZSBtaXNzZWQgYnkgdGhlIENQVSAN
Cj4gaWYgZGlzYWJsZSBldmVudCBJUlEgbWFzay7CoCBTbywgVGhlIGZpeCBzaG91bGQgYmUgYXMg
Zm9sbG93LiBDb3VsZCB5b3UgDQo+IHBsZWFzZSByZXZpZXcgdGhpcyBvbmNlIGZyb20geW91ciBl
bmQ/DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCBjY2MzODk1ZGJkN2YuLjNiMjQ0MTYwOGU5ZSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMNCj4gQEAgLTU1NCw2ICs1NTQsMTUgQEAgaW50IGR3YzNfZXZlbnRfYnVmZmVy
c19zZXR1cChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBsb3dlcl8zMl9iaXRzKGV2dC0+ZG1hKSk7DQo+ICDCoMKgwqDC
oMKgwqDCoCBkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRBRFJISSgwKSwNCj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdXBwZXJfMzJfYml0
cyhldnQtPmRtYSkpOw0KPiArDQo+ICvCoMKgwqDCoMKgwqAgLyoNCj4gK8KgwqDCoMKgwqDCoMKg
ICogVGhlIERXQzNfRVZFTlRfUEVORElORyBmbGFnIGlzIGNsZWFyZWQgaWYgaXQgaGFzDQo+ICvC
oMKgwqDCoMKgwqDCoCAqIGFscmVhZHkgYmVlbiBzZXQgd2hlbiBlbmFibGluZyB0aGUgZXZlbnQg
SVJRIG1hc2sNCj4gK8KgwqDCoMKgwqDCoMKgICogdG8gcHJldmVudCBwb3NzaWJseSBvZiBhbiBJ
UlEgc3Rvcm0uDQo+ICvCoMKgwqDCoMKgwqDCoCAqLw0KPiArwqDCoMKgwqDCoMKgIGlmIChldnQt
PmZsYWdzICYgRFdDM19FVkVOVF9QRU5ESU5HKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBldnQtPmZsYWdzICY9IH5EV0MzX0VWRU5UX1BFTkRJTkc7DQo+ICsNCj4gIMKgwqDCoMKg
wqDCoMKgIGR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HRVZOVFNJWigwKSwNCj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRFdDM19HRVZOVFNJWl9T
SVpFKGV2dC0+bGVuZ3RoKSk7DQo+ICDCoMKgwqDCoMKgwqDCoCBkd2MzX3dyaXRlbChkd2MtPnJl
Z3MsIERXQzNfR0VWTlRDT1VOVCgwKSwgMCk7DQo+IA0KDQpTb3JyeSBmb3IgdGhlIGRlbGF5IHJl
c3BvbnNlLg0KDQpJbiBhZGRpdGlvbiB0byB0aGF0LCBwbGVhc2UgcmV3b3JrIGFuZCByZW5hbWUN
CmR3YzNfZ2FkZ2V0X3Byb2Nlc3NfcGVuZGluZ19ldmVudCgpLiBXZSdyZSBub3Qgc3VwcG9zZWQg
dG8gaGFuZGxlIGFueQ0KbGVmdC1vdmVyIGV2ZW50LiBTbyByZW1vdmUgdGhlIG1hbnVhbCBjYWxs
cyB0byB0aGUgaW50ZXJydXB0IGhhbmRsZXJzDQp0aGVyZS4NCg0KT24gcnVudGltZSBzdXNwZW5k
LCB0aGUgZGV2aWNlIGlzIHNvZnQgZGlzY29ubmVjdGVkLiBTbyBhbnkgaW50ZXJydXB0DQphc3Nl
cnRpb24gdG8gbm90aWZ5IGEgbmV3IGNvbm5lY3Rpb24gbXVzdCBiZSBhIGN1c3RvbSBjb25maWd1
cmF0aW9uIG9mDQp5b3VyIHBsYXRmb3JtLiBObyBldmVudCBzaG91bGQgYmUgZ2VuZXJhdGVkIHdo
aWxlIHRoZSBydW5fc3RvcCBiaXQgaXMNCmNsZWFyZWQuDQoNCk9uIHJ1bnRpbWUgcmVzdW1lLCB3
ZSB3aWxsIGluaXRpYXRlIHNvZnQtcmVzZXQgYW5kIHNvZnQtY29ubmVjdCB0bw0KcmVzdG9yZSB0
aGUgcnVuX3N0b3AgYml0LiBBIG5ldyBjb25uZWN0aW9uIGV2ZW50IHdpbGwgYmUgZ2VuZXJhdGVk
IHRoZW4uDQoNClRoYW5rcywNClRoaW5o

