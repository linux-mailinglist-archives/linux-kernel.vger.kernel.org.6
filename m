Return-Path: <linux-kernel+bounces-246769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1840892C66D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67D6DB21D8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D7A187863;
	Tue,  9 Jul 2024 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rTaMC+iY";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VN5OfsU4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WgzsR5XY"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB401420A8;
	Tue,  9 Jul 2024 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566583; cv=fail; b=KfOZVL9yK+zzxGjsKFnljo/br8fP29qMM2/ml9LcXjRjaAQtaJRbFdb4EiuF9aQMw+6L6Os7ADw1TvOfDJ6aywTk0h2SydEczhe0FU4ie+OHJoRK7OCVE+UhNdkQRDt2/tcYrQZpOwOWyL2I25EmLyBLTGJTnTHkwrhYB4uyH94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566583; c=relaxed/simple;
	bh=pGLmAyFL+S5z2ubYK4XFR61UHbvFLFqGYdAzzOG5YNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GMCbbyH/lX3mGBeWIx/Nmh3yTUll7g89uwz5x+3iiQMQU38cJogKTvVCW4qWbhzAuylh3d01ornr6grJvB+xscbvitopM/P9Ol842zOlN/0mqC8Op4P/AV8brRUAtsv7Ff9b1xxO87SH9pPQ5Xnf6I58oxFABtTzFu9XzWwICuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=rTaMC+iY; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VN5OfsU4; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WgzsR5XY reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469L6UnW016268;
	Tue, 9 Jul 2024 15:09:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=pGLmAyFL+S5z2ubYK4XFR61UHbvFLFqGYdAzzOG5YNk=; b=
	rTaMC+iYsZQ4/2WbW0qBO57IFbnWo5foOPndZnepLtfahpSH+XOwvItRBzyir5yW
	6U3rEYXq8cDWDSSP5NtHpPBm6zPmvsM0YeLRU82c4ldDDpbinTp77MCUu9oUuOVQ
	VtDggjbKMreSZPMMVtRxWoLyyDBGEU6QO80v/XEqVkLusYFCOnqqyyvWZKKlDZNH
	BHWnswc5CSYbthWx0Jgsooe9CCsUzSStcxZ0OnKFKRcHmTrXII6RtClOyt95O/2y
	8zAdDGkZlYHOLZJvfbDOifxlaj0SMASxU0vWAwZ6JMj079JSulZka+O2ip9IiufI
	J2NMIfuE/U7OdzqPLvx8cQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4074xjeb52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 15:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1720562971; bh=pGLmAyFL+S5z2ubYK4XFR61UHbvFLFqGYdAzzOG5YNk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=VN5OfsU44iVBq+XfL4g9Am3wVFIzmC4AjUbbzRei4R6W8oWPStBVYZ9ktLdTCERg/
	 ELGJ/EjdE2ncGJfrQrI+ksoZLIkv+tVe1A4NbAPHfJftX6/mbt6Vv0NOmvj/RFp/D1
	 9bjOyiy20iM5c2SkWZ5Vl7s2pWrv+b9nqjJL0Dljdx+DbCEn6m8fCTeIsgm1FZ7Mjy
	 RwkSgmw5uaTosXz5mqZd9UrgJ+uS57UyjIG0nrdcau4kUMULlR2KJGaYhfNcX5jVJl
	 diwblUHeC2fLrXNqDfZSJKqblhk52M8GSHiCJ2hJeRe7e0YzlkYehqicK4U3XbwL8K
	 75/4tk+iVtaow==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 269944048B;
	Tue,  9 Jul 2024 22:09:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B6F09A0084;
	Tue,  9 Jul 2024 22:09:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=WgzsR5XY;
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 914BD4048B;
	Tue,  9 Jul 2024 22:09:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NT0mFhBeTFwcrFKZEuxBvRQYMWbpMnCcxiX4qxw9/V1AZBEMgOMHwlgRhgpDAsyevWaYJGZiVhzjqwWYU4M+CtAPgV7tD7TJt+xAeGt2vyKKZafAA19OVeYOxUId7AkE9Y8b86ShW/PsyzXNeNX/38jKV3wb2ULgFMpfbLtSP12V/xs35jkcjuY/667UH5VLY/ywjeqnOtJEFvlBFwPBthOjgxlSXjs3tT5zLGJDVdxKhk173YsHc1MnFLXImOpl7sSHqLzOH8TAYtyCF2Kj1MnFmY3F62JpVfEp32YGl0JB9C+tTkBTxT5npYtZdXjfQgYiMplG94ElOVEZ6nQh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGLmAyFL+S5z2ubYK4XFR61UHbvFLFqGYdAzzOG5YNk=;
 b=cyptNBp9B/KVrGmCVaysVdpzFNK1xEjbjSuHDbTKPezCK8X6ZlQ/lH833d7AKsEGd7VbPSK4vmC18BmKxorZM91WL4zWrsLY1sGygl251OBO0kcS0jKKLqstAd7MM+72JaCEdRUk1OyuWNdnFbxWndmUX1E08UgiOwgZrdtH3jTYRAG1c35FTiP9gDfLrlArMq2jPi1WbLfwD81DwBnb2KDUKicA/VOPV6TFagLB6K1IV+5UtxGeP0mM1d5NPQ+vQ+Xzn6dkye7Qhnw8ic6pTj54KTx+PowhgIXYTBomKrkyUqQi8p+Qva8xfDgun0CZUFeYV9Etn3NYjCrYRtcxew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGLmAyFL+S5z2ubYK4XFR61UHbvFLFqGYdAzzOG5YNk=;
 b=WgzsR5XYyDQozPeWyz15EEPHZR0nwGZ2qxSaNwnLJ5I0wcdcDulwFMNjWfU3Lu/51xo6r20LmweB6TbpJIJNMod5FR1CTy5/nACuOGxAW2yZ9oE0rtguCo3xi+k/jF6i9J22X+nZXG1330PE9l4Bn3X1ToaQMlA6I22v6FDRn5I=
Received: from DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) by
 DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Tue, 9 Jul 2024 22:09:20 +0000
Received: from DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb]) by DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 22:09:19 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "Frank.li@nxp.com" <Frank.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@amd.com" <git@amd.com>
Subject: Re: [PATCH v5] usb: dwc3: enable CCI support for AMD-xilinx DWC3
 controller
Thread-Topic: [PATCH v5] usb: dwc3: enable CCI support for AMD-xilinx DWC3
 controller
Thread-Index: AQHa0itk2lHfHtdjxESM+YbBKkxb1bHu9O6A
Date: Tue, 9 Jul 2024 22:09:18 +0000
Message-ID: <20240709220915.522tqicndfqzre3y@synopsys.com>
References: <1720548651-726412-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1720548651-726412-1-git-send-email-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5984:EE_|DS0PR12MB7510:EE_
x-ms-office365-filtering-correlation-id: 689c6f63-e4b4-4202-5c25-08dca063c780
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Q05EM1lZVzdhWEpqRkpmbCtoeGs2V3NNNVVTeWpHVVdqYjJIWmpMTElPTmw0?=
 =?utf-8?B?ZXIvZzVhLzdQK2s2SUZSdnFGMGdUeENseUU3eitmOFprU3BWeEF6K2pyaDRa?=
 =?utf-8?B?SU1TekZsU1JlNEIwbWt3V1Rna2NDWGQxNDhWY2pJajhiL2VlLzRseHRjWkFn?=
 =?utf-8?B?TFFGTHNlTGhkVWtFYU03Y3VWaDdQYUtJaUpCWFErUU40VG5QOGE0NmNzRHBs?=
 =?utf-8?B?ZHlqL0RhblZzQy9yV09vZ1BXQlJJNFlpZ1dQc09pSmE3LzQ4RlhmbzZKNHdF?=
 =?utf-8?B?SVpyR0VjbFR3aU9VWEFtSVprZEFZOGRpUkVXcnRiT1VTS1VkeXpDdUFybVR0?=
 =?utf-8?B?SDZYOUR1UGRLa0ppcnJOSFZJK2lrWkRxT2tSSjQvYkI0S0dNT3ptNGMrOTBJ?=
 =?utf-8?B?N05MYlFaUklsYStMcU5kVEJ1WHczRjlxWjFEVEJPRWUrWlMxVHVaU3pXRWhD?=
 =?utf-8?B?N2RJdUY5RDNZUUZ4SWVHSnlUUU5HMXlvR2JNZmZRQ2RwTkh0OUZNTklwOStT?=
 =?utf-8?B?VUNSSHZTckNCUW1PME5KZTBDNjZtaUVuOGp5U1NoYzF6ei9jclZvMUNWcUJG?=
 =?utf-8?B?MUxvNCsxVjQ0VFpjcitHS1hGaWFsTEFzaFNKWWZTVDVrWkY1a0EyWE9jMGJp?=
 =?utf-8?B?NkIzZ3BPNVh5L2JxSlozZ1BFV2ZGSG5OZmZTRlM2L3BBS2NRb0k0anNJVGR6?=
 =?utf-8?B?c1h1VmYzcXZYaVdmdVVTcjVyUnhzNWhObjZyTS9VTG00eWhRM1p6Zlc2YVlV?=
 =?utf-8?B?aWhidWl0cUhJMGllWC9GMXRxT2docjV6Z2xGOEFnMG1JbUZvZUVXNmF6ZUt2?=
 =?utf-8?B?dTJjem9qU2ZvaHVIVE5zUm1WUmJmNHZNTTErb2I4RFZsblF1eW1CMThjcWZs?=
 =?utf-8?B?OFkyUVlVd24xMTUvVFRmY1FYQ2tqRURPRWdQbXA2bjJMTE9NRGxob1BvWitV?=
 =?utf-8?B?eHg4Q1lSQnEzZFJzb3BucXlueEZCb2Iya3hLbi9CUXJEUlFJZmZEblZBOC90?=
 =?utf-8?B?aXQvVzV0cjg1MW45VXl4VEliMjV4ak5BNnRaVTVXblZIWHBTMVBrYVR1ekx3?=
 =?utf-8?B?T1hvR3I0b2N6ODJSOU9mTnk4UGpBVWxrZjA0bDBFcUthRGVPMUUxdjc1TUFN?=
 =?utf-8?B?ZU1weFZSTWdBMlpXYnJjZEs3NnJmS09NU0cxSTQraXF5WGFWZTBzeEJmclMw?=
 =?utf-8?B?ekZsOXBLSjBidzBCQkY4N2VxZDJtQjg3ZSt5cEExQjRVMG83ZDRESkRHOU13?=
 =?utf-8?B?WnpRbmNuUDZnZnoyYjJmZWF6WWtBc2JzeWZzcDNaN2pITmNDdy9zd3lEbmJ3?=
 =?utf-8?B?eHdoMm9hTjhITHlaZGJNUUtnZTd4MjQ0WURIM0Z2VHZMMDJGRFVHWjBWR09p?=
 =?utf-8?B?akxlL0EzM2swazBhcWc2bmJtR0hGcFc0R1dzTGRiMHR3by9hZkZKNnYrbkNV?=
 =?utf-8?B?UEovVnhYSzF2NjlnNEliZnY4eXR1SHdwNTJwQ2tEUC9HTlNwYjlQNGE1aU1q?=
 =?utf-8?B?dGoyZWtLaEl3S0dOa0hIQkRkdVFVNC9aUVI5eEZWaDcrRkNqWlNRMURGTDgx?=
 =?utf-8?B?YTNCUEN1M0RzT2hWQ2xDdG1FZ2IzVU9nYStMamNXYXBQa3VSR216bktSeXpi?=
 =?utf-8?B?V2JobjR1cmpab2RzQlFYZElaK0UrL0dUNktneUtsRUZHWHBJaWEwMGFKN2Q0?=
 =?utf-8?B?SEVaWWpZMDByY3B5UWgvazZUOEgyT2YxQnRTZVdKY21vTDZBVzhzYTB6bkNo?=
 =?utf-8?B?Rk5QS0NNS2dCbGtQV1k1QmNVRUdKZ1JLVEI4T3Zrb1lVa0dpTGR4cWZVWnNn?=
 =?utf-8?Q?dlSUy4BGy3Q8/go6ZQBjL3YnJsYm6OXdoYZbI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5984.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Q0k1Y2k5Q2x4ZnlBL2wwejFNVFp5NUlTYit1RU5jVzdpdlJtZmJocWl4VlY1?=
 =?utf-8?B?MFRhMFhPTjcrSUduT3ZtRDlWUVNQR2NhbHk4ZE1aRE12eXFkZGNmQnYxUTk5?=
 =?utf-8?B?aEJGR0ZRYWRvTEZKRGx1VHAwV3JML0FBM2FqNmlnSm5PMnNaaTlYWmxWSElt?=
 =?utf-8?B?My9XQy9vZWVoc2FVY1R3dTJrd2NRNzFCRnRDYitmTVBkMVFlUWk2OTVodjAw?=
 =?utf-8?B?M24xd3VjRmo4RmV0bFVRR0tyR2ZxblJ5OVA1N1BFNUhibjFtRk5ZM1dRbUhk?=
 =?utf-8?B?amYwOExXYktWZytmeXhOZDQ0RzcxQ1ZZYXdtc0RHU3dHdEl2OG95bXB4c2R1?=
 =?utf-8?B?eGpTNFBEdWZORzk2ZUhEU2hEa0FiYVgrWURCSG4rZEM4OU9FNXhRMDZPdzY2?=
 =?utf-8?B?QzUycDRJYVVseWF6WFBOM3hObjRnNGIrS3ZUNkxNV0pJQ2hpTUlwUURNQnFD?=
 =?utf-8?B?dlg2YUdUY25DcWtVak51L0xRTkNkYWp4aWxXdFMxV1FjRGxtUU5NTEZVakdO?=
 =?utf-8?B?bjdrMXZVOFFSVzlXTmtscVJNclNITFRtVDkzSHpqb2tPWGVIRWRyQnNDcitS?=
 =?utf-8?B?UjIvQTZvYkJPYk05MHRRTi9hVGhRY0lsaEoyelhRV25PVDAvN2Z6WGNCa3VC?=
 =?utf-8?B?ajRlQ3g4dnN1bjlWUWZ0OWZvNEtuYU5VM08zU25CUlkxeHJ3VGtQVmtQRHhV?=
 =?utf-8?B?MDYxejlNUVRlb3VMc2VCUHMzV3praERValN6U3dYbW1zem43dlkvNDZlTjh5?=
 =?utf-8?B?TmNFRHhwZVNMRXI3RXZaeEFPZURaTno3cEEyYjhHWStDSkVZa04zclB6d2lH?=
 =?utf-8?B?RkhmL3FLa1RKeTdqTVFMdUQ5U2VrbExTU2ZPUW14RDJGUXJSdjNFM2lWcjEz?=
 =?utf-8?B?NXdlNWw5RjVEdURqYlc4TVF3cEhpeUFUMFJuTndiZU1sbVBpcU0rTUh0QjVp?=
 =?utf-8?B?NVcxT3pSMTBPcktDZDcwbmdnaWNOVWhIRXlBc1N1bmhqbUE4bjRHR0NJWmRy?=
 =?utf-8?B?NW9wVFNOYTIxMWg5NjErOWhEcFhGUFhPdVo4VGlkQmZnU0R6dWdaMXJ6akEz?=
 =?utf-8?B?UzNtT1dDQWRwdkpJYkpZS0U3QWgwVWlpYmNNRXBvdExQZklIdFhXTWY2YmxI?=
 =?utf-8?B?UjlWcHZocVNDMWs1L1NDNU1ma0orNlFiTzNrRkxyQklvYjEzRzl3dzZxQkQ4?=
 =?utf-8?B?OXFVTWwwQ250eUd1QlRjV2drbHpUZlZieVRYQTNzZGdqTlJ1VTdSeDQ3NkFQ?=
 =?utf-8?B?ZGxmMy9GalBYNlBLY1RFV1ZvWFJwRnJiR1dWdFFJd1MxVzZHajFzQ2FhN3pl?=
 =?utf-8?B?dnFDdVVkcVFKdzR0eU1tRlYyaTRoZ2o3ZHVpdXQ3TWZSMzViaEZlelJCS1oz?=
 =?utf-8?B?YVhXME5KRjdrdlhoMFVIUVpOU0ovUG5VY2lzY1lJMXBZSzhtbjhSOGE3aFQw?=
 =?utf-8?B?Rm51cmhvNnFDS2FkSkdxV2NTRkxhSFg0YjlaYlZUL2RwN29DZWRpYzY2MG9m?=
 =?utf-8?B?K3NaR3JlWUcvRGYvWHQwYk5qcGRJQ2RvcWREaGtiZFh6YitHT0ZkQ3ZWaFBQ?=
 =?utf-8?B?WFBOVXQ1Z1NsbithTmdpUk1pYlM4Zm4yd2Z4NWVTTllLOXBwbytmN205bkYy?=
 =?utf-8?B?ZE1LR1ZSQnRONm1IeUk3bnBKTjU4dWF0SVRNaE11RHJ1Rm9FdGRDZCtFRG5E?=
 =?utf-8?B?cFdkMEVxUFZnajFISWJZWE45Q01GWUwzZHgzeHFidG9yb0srd1FEUm9wWDY3?=
 =?utf-8?B?Q1NsK2tDdGNzZ3pZVzE3ZGxYL3N6SmNKZWtRcnN1R3p0OHp5akpkVWpyeDlL?=
 =?utf-8?B?dFI4bDMrcHVCVDl4Umhoc3ZuNVJLWG1hSFhlRExSaTk0clpTMmJnbysyUXdz?=
 =?utf-8?B?SXhuL1BFQVdFUzRvaGZTNWVMUm5vS0NtZ2RaOWNHMlp2U3NWMjlYWVhpSC91?=
 =?utf-8?B?SXZiOU5QWFZVNlFRTEc0NEdLTDlzMDY1bnBHQmRkcWl5MGNaYTA2LzZ2c2dD?=
 =?utf-8?B?V0NISEUvc1ZkU0ZuakZKeE1ITlVzcWlZYm5NMm1lK0hrRElYZGlhMzJoajNB?=
 =?utf-8?B?WjR3UUQyMnhTZzBQb24wTmxucnVpbXVGK0JZcWdUS1ptQjJkRTd4SEVXTHM3?=
 =?utf-8?B?RDl1a3RmUFdncUtCQ3A1NGppMUs2b2ZFNWc1KzcxNWRnZ3RVMW9EckQ5ekk5?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E53E6FD225B43428638ED02CE14A346@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fucGkw46zvP3w/CuT0sicUdLjI03Gf8Pm6a5gLMQ4jRuaXrJZu7M1AA+1t/9fMGamvGGsFcGIuEThtG+/vOLCwKODBwgOQGnndcWZBHjMnuNTfdzy04DeqVelNRkgyLtl6lFNQLhi2P9uUO3L93OJA2wziyo6tqaQISLKw2SO4IeTmRVNbtJNzny5UHoxHldhVJxVbVR08cc0yUXUEFL2HVYvsZgxDGnM6tZiwHIRKfYiv45hy9w8Wv7srsho3zyrVThzjgoqHKr8ZwItdWp+IofP5SsWEolAqYRPARy0+q3FXqZecPntQMdYAB5G6tWQg3P4VfuDFzyuwXQrGriVY/5TrUIOxqF2fh1WICfo0Q1JG//hkwCMEnJ0aHxFmAfn2o+c3SYPte74uEpaktiK407nujCBhcYn5q2yUUvpk9vNHXC6rUYmL0ItqqofNfh0EFOVWxPX863gf1Ic4FpuAcRE9gTkI3K6eah1iPJNDBNyRafCQrr4s+0tuhr7c/hDRRfJNGa52Rtpc4SaRKv9OuDVfeVR3jRFspKbay6ORKTfAXH4bwNElFYzxnSIAc6vUSMDchpIFuoT0Ut/FwI4ww2SUVWclKm9irR/OCc6/cd2UWIi4DbI0bzU/uEDlJ8VM0Y6MmnQzVd5uZa5CT1Fg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5984.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689c6f63-e4b4-4202-5c25-08dca063c780
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 22:09:18.7593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ulHzSCgFT1LVdMWVCR4JbY0luGoTzW0/7APXfKWhwoP0igwAEguFuPD/LudOBcaFj5RSD2iqVEAk65NwLHYhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
X-Proofpoint-GUID: qiOhSK4F3qEcyH-GYCGpg0IEaqdXwZUU
X-Proofpoint-ORIG-GUID: qiOhSK4F3qEcyH-GYCGpg0IEaqdXwZUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_10,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 adultscore=0
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407090151

T24gVHVlLCBKdWwgMDksIDIwMjQsIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+IFRoZSBH
U0JVU0NGRzAgcmVnaXN0ZXIgYml0cyBbMzE6MTZdIGFyZSB1c2VkIHRvIGNvbmZpZ3VyZSB0aGUg
Y2FjaGUgdHlwZQ0KPiBzZXR0aW5ncyBvZiB0aGUgZGVzY3JpcHRvciBhbmQgZGF0YSB3cml0ZS9y
ZWFkIHRyYW5zZmVycyAoQ2FjaGVhYmxlLA0KPiBCdWZmZXJhYmxlL1Bvc3RlZCkuIFdoZW4gQ0NJ
IGlzIGVuYWJsZWQgaW4gdGhlIGRlc2lnbiwgRFdDMyBjb3JlIEdTQlVTQ0ZHMA0KPiBjYWNoZSBi
aXRzIG11c3QgYmUgdXBkYXRlZCB0byBzdXBwb3J0IENDSSBlbmFibGVkIHRyYW5zZmVycyBpbiBV
U0IuDQo+IA0KPiBUbyBwcm9ncmFtIEdTQlVTQ0ZHMCBjYWNoZSBiaXRzIGNyZWF0ZSBhIHNvZnR3
YXJlIG5vZGUgcHJvcGVydHkNCj4gaW4gQU1ELXhpbGlueCBkd2MzIGdsdWUgZHJpdmVyIGFuZCBw
YXNzIGl0IHRvIGR3YzMgY29yZS4gVGhlIGNvcmUNCj4gdGhlbiByZWFkcyB0aGlzIHByb3BlcnR5
IHZhbHVlIGFuZCBjb25maWd1cmVzIGl0IGluIGR3YzNfY29yZV9pbml0KCkNCj4gc2VxdWVuY2Uu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYWRoZXkgU2h5YW0gUGFuZGV5IDxyYWRoZXkuc2h5YW0u
cGFuZGV5QGFtZC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGZvciB2NToNCj4gLSBSZW1vdmUgbGlu
dXgvb2ZfYWRkcmVzcy5oIGluY2x1ZGUgZnJvbSBjb3JlLmMNCj4gLSBNb3ZlIGR3YzNfZ2V0X3By
b3BlcnRpZXMoKSBpbXBsZW1lbnRhdGlvbiBhYm92ZSBkd2MzX2dldF9wcm9wZXJ0aWVzKCkuDQo+
IC0gUmVuYW1lIERXQzNfR1NCVVNDRkcwX1JFUUlORk9fVU5TUEVDSUZJRUQuDQo+IA0KPiBDaGFu
Z2VzIGZvciB2NDoNCj4gLSBQYXNzIHN3bm9kZSBHU0JVU0NGRzAgY2FjaGUgcHJvcGVydHkgZnJv
bSBnbHVlIGRyaXZlciBiYXNlZCBvbg0KPiAgIGRtYS1jb2hlcmVudCBmbGFnLg0KPiAtIEludHJv
ZHVjZSBmdW5jdGlvbiBkd2MzX2dldF9zb2Z0d2FyZV9wcm9wZXJ0aWVzKCkuDQo+IC0gUmVuYW1l
IERXQzNfR1NCVVNDRkcwX1JFUUlORk9fTUFTSy4NCj4gLSBVc2UgRFdDM19HU0JVU0NGRzBfUkVR
SU5GTyhuKSBhbmQgZ2V0IHJpZCBvZiBtYXNrIHNoaWZ0IGRlZmluZS4NCj4gLSBSZW5hbWUgZHdj
MyBtZW1iZXIgZ3NidXNjZmcwX3JlcWluZm8gYW5kIGNoYW5nZSBpdCB0eXBlIHRvIHUzMg0KPiAg
IGFuZCBkZWZpbmUgMHhmZmZmZmZmZiBhcyB1bnNwZWNpZmllZC4NCj4gLSBJbiBjb21tZW50IGR3
YzNfZ2V0X3NvZnR3YXJlX3Byb3BlcnRpZXMoKSBkZXNjcmlwdGlvbiBhbHNvIG1lbnRpb24NCj4g
ICAibm9uLURUIChub24tQUJJKSBwcm9wZXJ0aWVzIi4NCj4gDQo+IENoYW5nZXMgZm9yIHYzOg0K
PiAtIEluIHYyIHJldmlldyBhcyBzdWdnZXN0ZWQgYnkgVGhpbmggTmd1eWVuLCBzd2l0Y2ggdG8g
c3dub2RlDQo+ICAgaW1wbGVtZW50YXRpb24gZm9yIHBhc3NpbmcgR1NCVVNDRkcwIGNhY2hlIGJp
dHMgZnJvbSBBTUQteGlsaW54DQo+ICAgZHdjMyBnbHVlIGRyaXZlciB0byBjb3JlIGRyaXZlci4N
Cj4gDQo+IENoYW5nZXMgZm9yIHYyOg0KPiAtIE1ha2UgR1NCVVNDRkcwIGNvbmZpZ3VyYXRpb24g
c3BlY2lmaWMgdG8gQU1ELXhpbGlueCBwbGF0Zm9ybS4NCj4gICBUYWtlbiByZWZlcmVuY2UgZnJv
bSBleGlzdGluZyBjb21taXQgZWM1ZWI0MzgxM2E0ICgidXNiOiBkd2MzOiBjb3JlOg0KPiAgIGFk
ZCBzdXBwb3J0IGZvciByZWFsdGVrIFNvQ3MgY3VzdG9tJ3MgZ2xvYmFsIHJlZ2lzdGVyIHN0YXJ0
IGFkZHJlc3MiKQ0KPiANCj4gdjEgbGluazoNCj4gICBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMxMDEzMDUzNDQ4LjExMDU2LTEtcGl5
dXNoLm1laHRhQGFtZC5jb21fXzshIUE0RjJSOUdfcGchWjRYdGJ4ZnhYNzY4TjdueWR0aFAwd0xB
dkhPRTRYLUFXYmRqSmZVdlFnUG5tR2g4emNWOVU0NE1saXBwbWJncHpmLXlQTjNYWUZxWjV0Rjl0
NzV4TWU0eUFDek03dyQgDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgICAgICAg
IHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmggICAgICAgIHwgIDggKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdj
My14aWxpbnguYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNo
YW5nZWQsIDc0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IGNiODI1NTc2Nzhk
ZC4uZWJiM2Y2ZWIxOTFmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0K
PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtNTk5LDYgKzU5OSwxOCBAQCBz
dGF0aWMgdm9pZCBkd2MzX2NhY2hlX2h3cGFyYW1zKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCXBh
cm1zLT5od3BhcmFtczkgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HSFdQQVJBTVM5KTsN
Cj4gIH0NCj4gIA0KPiArc3RhdGljIHZvaWQgZHdjM19jb25maWdfc29jX2J1cyhzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPiArew0KPiArCWlmIChkd2MtPmdzYnVzY2ZnMF9yZXFpbmZvICE9IERXQzNfR1NC
VVNDRkcwX1JFUUlORk9fVU5TUEVDSUZJRUQpIHsNCj4gKwkJdTMyIHJlZzsNCj4gKw0KPiArCQly
ZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HU0JVU0NGRzApOw0KPiArCQlyZWcgJj0g
fkRXQzNfR1NCVVNDRkcwX1JFUUlORk8ofjApOw0KPiArCQlyZWcgfD0gRFdDM19HU0JVU0NGRzBf
UkVRSU5GTyhkd2MtPmdzYnVzY2ZnMF9yZXFpbmZvKTsNCj4gKwkJZHdjM193cml0ZWwoZHdjLT5y
ZWdzLCBEV0MzX0dTQlVTQ0ZHMCwgcmVnKTsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBp
bnQgZHdjM19jb3JlX3VscGlfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiAgCWludCBp
bnRmOw0KPiBAQCAtMTMzOCw2ICsxMzUwLDggQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdChz
dHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgDQo+ICAJZHdjM19zZXRfaW5jcl9idXJzdF90eXBlKGR3Yyk7
DQo+ICANCj4gKwlkd2MzX2NvbmZpZ19zb2NfYnVzKGR3Yyk7DQo+ICsNCj4gIAlyZXQgPSBkd2Mz
X3BoeV9wb3dlcl9vbihkd2MpOw0KPiAgCWlmIChyZXQpDQo+ICAJCWdvdG8gZXJyX2V4aXRfcGh5
Ow0KPiBAQCAtMTU3Niw2ICsxNTkwLDI3IEBAIHN0YXRpYyB2b2lkIGR3YzNfY29yZV9leGl0X21v
ZGUoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlkd2MzX3NldF9wcnRjYXAoZHdjLCBEV0MzX0dDVExf
UFJUQ0FQX0RFVklDRSk7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB2b2lkIGR3YzNfZ2V0X3NvZnR3
YXJlX3Byb3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4gK3sNCj4gKwlzdHJ1Y3QgZGV2aWNl
ICp0bXBkZXY7DQo+ICsJdTE2IGdzYnVzY2ZnMF9yZXFpbmZvOw0KPiArCWludCByZXQ7DQo+ICsN
Cj4gKwlkd2MtPmdzYnVzY2ZnMF9yZXFpbmZvID0gRFdDM19HU0JVU0NGRzBfUkVRSU5GT19VTlNQ
RUNJRklFRDsNCj4gKw0KPiArCS8qDQo+ICsJICogSXRlcmF0ZSBvdmVyIGFsbCBwYXJlbnQgbm9k
ZXMgZm9yIGZpbmRpbmcgc3dub2RlIHByb3BlcnRpZXMNCj4gKwkgKiBhbmQgbm9uLURUIChub24t
QUJJKSBwcm9wZXJ0aWVzLg0KPiArCSAqLw0KPiArCWZvciAodG1wZGV2ID0gZHdjLT5kZXY7IHRt
cGRldjsgdG1wZGV2ID0gdG1wZGV2LT5wYXJlbnQpIHsNCj4gKwkJcmV0ID0gZGV2aWNlX3Byb3Bl
cnR5X3JlYWRfdTE2KHRtcGRldiwNCj4gKwkJCQkJICAgICAgICJzbnBzLGdzYnVzY2ZnMC1yZXFp
bmZvIiwNCj4gKwkJCQkJICAgICAgICZnc2J1c2NmZzBfcmVxaW5mbyk7DQo+ICsJCWlmICghcmV0
KQ0KPiArCQkJZHdjLT5nc2J1c2NmZzBfcmVxaW5mbyA9IGdzYnVzY2ZnMF9yZXFpbmZvOw0KPiAr
CX0NCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgZHdjM19nZXRfcHJvcGVydGllcyhzdHJ1Y3Qg
ZHdjMyAqZHdjKQ0KPiAgew0KPiAgCXN0cnVjdCBkZXZpY2UJCSpkZXYgPSBkd2MtPmRldjsNCj4g
QEAgLTIwOTAsNiArMjEyNSw4IEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICAJZHdjM19nZXRfcHJvcGVydGllcyhkd2MpOw0KPiAg
DQo+ICsJZHdjM19nZXRfc29mdHdhcmVfcHJvcGVydGllcyhkd2MpOw0KPiArDQo+ICAJZHdjLT5y
ZXNldCA9IGRldm1fcmVzZXRfY29udHJvbF9hcnJheV9nZXRfb3B0aW9uYWxfc2hhcmVkKGRldik7
DQo+ICAJaWYgKElTX0VSUihkd2MtPnJlc2V0KSkgew0KPiAgCQlyZXQgPSBQVFJfRVJSKGR3Yy0+
cmVzZXQpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCAzNzgxYzczNmMxYTEuLjFlNTYxZmQ4Yjg2ZSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmgNCj4gQEAgLTE5NCw2ICsxOTQsMTAgQEANCj4gICNkZWZpbmUgRFdDM19HU0JV
U0NGRzBfSU5DUkJSU1RFTkEJKDEgPDwgMCkgLyogdW5kZWZpbmVkIGxlbmd0aCBlbmFibGUgKi8N
Cj4gICNkZWZpbmUgRFdDM19HU0JVU0NGRzBfSU5DUkJSU1RfTUFTSwkweGZmDQo+ICANCj4gKy8q
IEdsb2JhbCBTb0MgQnVzIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXI6IEFIQi1wcm90L0FYSS1jYWNo
ZS9PQ1AtUmVxSW5mbyAqLw0KPiArI2RlZmluZSBEV0MzX0dTQlVTQ0ZHMF9SRVFJTkZPKG4pCSgo
KG4pICYgMHhmZmZmKSA8PCAxNikNCj4gKyNkZWZpbmUgRFdDM19HU0JVU0NGRzBfUkVRSU5GT19V
TlNQRUNJRklFRAkweGZmZmZmZmZmDQo+ICsNCj4gIC8qIEdsb2JhbCBEZWJ1ZyBMU1AgTVVYIFNl
bGVjdCAqLw0KPiAgI2RlZmluZSBEV0MzX0dEQkdMU1BNVVhfRU5EQkMJCUJJVCgxNSkJLyogSG9z
dCBvbmx5ICovDQo+ICAjZGVmaW5lIERXQzNfR0RCR0xTUE1VWF9IT1NUU0VMRUNUKG4pCSgobikg
JiAweDNmZmYpDQo+IEBAIC0xMTUzLDYgKzExNTcsOSBAQCBzdHJ1Y3QgZHdjM19zY3JhdGNocGFk
X2FycmF5IHsNCj4gICAqIEBudW1fZXBfcmVzaXplZDogY2FycmllcyB0aGUgY3VycmVudCBudW1i
ZXIgZW5kcG9pbnRzIHdoaWNoIGhhdmUgaGFkIGl0cyB0eA0KPiAgICoJCSAgICBmaWZvIHJlc2l6
ZWQuDQo+ICAgKiBAZGVidWdfcm9vdDogcm9vdCBkZWJ1Z2ZzIGRpcmVjdG9yeSBmb3IgdGhpcyBk
ZXZpY2UgdG8gcHV0IGl0cyBmaWxlcyBpbi4NCj4gKyAqIEBnc2J1c2NmZzBfcmVxaW5mbzogc3Rv
cmUgR1NCVVNDRkcwLkRBVFJEUkVRSU5GTywgREVTUkRSRVFJTkZPLA0KPiArICoJCSAgICAgICBE
QVRXUlJFUUlORk8sIGFuZCBERVNXUlJFUUlORk8gdmFsdWUgcGFzc2VkIGZyb20NCj4gKyAqCQkg
ICAgICAgZ2x1ZSBkcml2ZXIuDQo+ICAgKi8NCj4gIHN0cnVjdCBkd2MzIHsNCj4gIAlzdHJ1Y3Qg
d29ya19zdHJ1Y3QJZHJkX3dvcms7DQo+IEBAIC0xMzgwLDYgKzEzODcsNyBAQCBzdHJ1Y3QgZHdj
MyB7DQo+ICAJaW50CQkJbGFzdF9maWZvX2RlcHRoOw0KPiAgCWludAkJCW51bV9lcF9yZXNpemVk
Ow0KPiAgCXN0cnVjdCBkZW50cnkJCSpkZWJ1Z19yb290Ow0KPiArCXUzMgkJCWdzYnVzY2ZnMF9y
ZXFpbmZvOw0KPiAgfTsNCj4gIA0KPiAgI2RlZmluZSBJTkNSWF9CVVJTVF9NT0RFIDANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYyBiL2RyaXZlcnMvdXNiL2R3
YzMvZHdjMy14aWxpbnguYw0KPiBpbmRleCA2MDk1ZjRkZWU2Y2UuLmJiNGQ4OTRjMTZlOSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jDQo+ICsrKyBiL2RyaXZl
cnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiBAQCAtMjQ2LDYgKzI0NiwzMSBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBkd2MzX3hsbnhfb2ZfbWF0Y2hbXSA9IHsNCj4gIH07
DQo+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBkd2MzX3hsbnhfb2ZfbWF0Y2gpOw0KPiAgDQo+
ICtzdGF0aWMgaW50IGR3YzNfc2V0X3N3bm9kZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+
ICsJc3RydWN0IGRldmljZV9ub2RlICpucCA9IGRldi0+b2Zfbm9kZSwgKmR3YzNfbnA7DQo+ICsJ
c3RydWN0IHByb3BlcnR5X2VudHJ5IHByb3BzWzJdOw0KPiArCWludCBwcm9wX2lkeCA9IDAsIHJl
dCA9IDA7DQo+ICsNCj4gKwlkd2MzX25wID0gb2ZfZ2V0X2NvbXBhdGlibGVfY2hpbGQobnAsICJz
bnBzLGR3YzMiKTsNCj4gKwlpZiAoIWR3YzNfbnApIHsNCj4gKwkJcmV0ID0gLUVOT0RFVjsNCj4g
KwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZmluZCBkd2MzIGNvcmUgY2hpbGRcbiIpOw0KPiAr
CQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gKw0KPiArCW1lbXNldChwcm9wcywgMCwgc2l6ZW9mKHN0
cnVjdCBwcm9wZXJ0eV9lbnRyeSkgKiBBUlJBWV9TSVpFKHByb3BzKSk7DQo+ICsJaWYgKG9mX2Rt
YV9pc19jb2hlcmVudChkd2MzX25wKSkNCj4gKwkJcHJvcHNbcHJvcF9pZHgrK10gPSBQUk9QRVJU
WV9FTlRSWV9VMTYoInNucHMsZ3NidXNjZmcwLXJlcWluZm8iLA0KPiArCQkJCQkJICAgICAgIDB4
ZmZmZik7DQo+ICsJb2Zfbm9kZV9wdXQoZHdjM19ucCk7DQo+ICsNCj4gKwlpZiAocHJvcF9pZHgp
DQo+ICsJCXJldCA9IGRldmljZV9jcmVhdGVfbWFuYWdlZF9zb2Z0d2FyZV9ub2RlKGRldiwgcHJv
cHMsIE5VTEwpOw0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlu
dCBkd2MzX3hsbnhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4g
IAlzdHJ1Y3QgZHdjM194bG54CQkqcHJpdl9kYXRhOw0KPiBAQCAtMjg4LDYgKzMxMywxMCBAQCBz
dGF0aWMgaW50IGR3YzNfeGxueF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiAgCWlmIChyZXQpDQo+ICAJCWdvdG8gZXJyX2Nsa19wdXQ7DQo+ICANCj4gKwlyZXQgPSBkd2Mz
X3NldF9zd25vZGUoZGV2KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIGVycl9jbGtfcHV0Ow0K
PiArDQo+ICAJcmV0ID0gb2ZfcGxhdGZvcm1fcG9wdWxhdGUobnAsIE5VTEwsIE5VTEwsIGRldik7
DQo+ICAJaWYgKHJldCkNCj4gIAkJZ290byBlcnJfY2xrX3B1dDsNCj4gDQo+IGJhc2UtY29tbWl0
OiAzNGFmYjgyYTNjNjdmODY5MjY3YTI2ZjU5M2I2ZjhmYzZiZjM1OTA1DQo+IC0tIA0KPiAyLjM0
LjENCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5j
b20+DQoNClRoYW5rcywNClRoaW5o

