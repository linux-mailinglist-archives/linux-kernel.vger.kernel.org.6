Return-Path: <linux-kernel+bounces-318008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E21996E70D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823781F24276
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB833FEC;
	Fri,  6 Sep 2024 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="X1SXz2gd";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Fc3sKDkP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JFsRBQH7"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1828186A;
	Fri,  6 Sep 2024 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725584403; cv=fail; b=gi2sxlzaNOyc4uYO2aRsFpc1BzYYrYdyDaTIUag7X7muZG8hXm+TV3QFcrJ0jzt5m7cN1mGeFbCapWzP0eaTmRZNzDmt5+n+meh5QYW4y9kCqekdC0dC78rTWxjxt8W55riVthsVFxMfX0Kx9nKcgrqo9O04rFbMJ1cEr3ITMog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725584403; c=relaxed/simple;
	bh=oXvzb6mls0uT/AuPaepTWvIPjo6NWnSOetWbup4/Rnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M1mw8lQ2niLxltidXXFct4MUI0upCNThO9aovxSbp10Xq+Fe0mIew4ASg9t4r8mH28jtAiPWVzPqji28wl5RY9jCIlgoHIbfE1rEPr9gyPccSZzN8Z8C5Vx2aj2UlUawYudI+qwbyUPZ9XqC7AQI2AA0dHPR3ghPB6u46nZbhKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=X1SXz2gd; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Fc3sKDkP; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=JFsRBQH7 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4860GDEc009419;
	Thu, 5 Sep 2024 17:59:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=oXvzb6mls0uT/AuPaepTWvIPjo6NWnSOetWbup4/Rnw=; b=
	X1SXz2gdR6PItHnSspk01jYFjckEMwUvkjbG217GAV23bjsCJ3O1tQcsDlSN+pP6
	AqbACAqpFHfKVaCY8iTb0nvjRn8OC1ieNyuWJf4UfENAv0bf0BtDDh80iDmo70FK
	qHvtC9X1VLBD+DcanzwF67hDTC65Lf3XFirH8As30qTuXkgwvD9pYkJh98+Ivgi7
	20/pl3aJd6veKGxhLXcpjWQ9gCEZ08GNBmdNW0N9HB+OInHjF1SQx3w+ufg3SzXX
	aG6F+yc1bR1paKxy6cKPJShWlHG7kDQvjFbi+IM9zBZgis2uovu0hjcc5YZL3+La
	CrkDo4ktyN3KM8Mg9pAKWw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41fhxm1dtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 17:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1725584389; bh=oXvzb6mls0uT/AuPaepTWvIPjo6NWnSOetWbup4/Rnw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Fc3sKDkPBNP5ySjACm0+Ohz54fM84O8UnunA1oR9liiP/Da3ibbLkDeF+cEow9HeL
	 667S1nByeOuowsNAT18f85BqjsGJ11uyt9OgOx6poXT49rZUb5QFQ+2PC3ozpGwv/u
	 lmIF3AIS/mbJBjYVP5cMiYcl81PnxIemIWGH7KUEwdSRL0P8usxAZXUuB3SKm29RXk
	 Sq9jc2AHeHF7JHb/txfg7/ixiT5SGE/I53fW7rx5MLP7Srd+fbCL/qU9VkCjS0+H2Q
	 XHDb74dUh3goBcKrub4bAftqU922u4hoQ42UXsLb6fcGEn7Edd25nvSg90/+4DVLfg
	 IOaAhoqv3KdwA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0A2B640349;
	Fri,  6 Sep 2024 00:59:48 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 954BAA0264;
	Fri,  6 Sep 2024 00:59:48 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=JFsRBQH7;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D177740211;
	Fri,  6 Sep 2024 00:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nd5IRLC7TNOy79hYJc4bjDmQGl4t3T47exmy++6YpCYZdJTflXpbwRjxh4v9n7D3aEmEq2iVVS/pYTA88eV8eBJvQEVCpwW9AW4y8vmweU2jjNKa2QTcLsCD2eXuaMTjho7XEiks265DfGM/3H1vWann0sMch4F8MxAVifWY+7WwYmh44gvJbOkdCM+9zz6WulMAUU8yILg0FQVHbk11+rwryws9tklqtLGXxSXvUxbg0+t7s8b6IAIwPN8F7HWNoD3I6lB3O2ggmsbOvYXMuhA4ahXZq37IL/T+Fr6/PUc+Lcjuyym2k0zqheWfJpnDoFujRllUEpGh5qQNdKGV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXvzb6mls0uT/AuPaepTWvIPjo6NWnSOetWbup4/Rnw=;
 b=xkXpu+5UDgsbWunq3byol3krFcU4rGQPjnZ1h0PCU2jibM45mUQ3pHCx/GsDIDAXzEytYRF7XbF3lugz8+fjwMgSGgjuOg86aTo6MbkKdVsvWYTXWUma2fMquamc0RA5iP6VzdRXCHF/Pp3hOfHUzXxXS30Ry5iwSYSlSWiNYPEg5I1+Hsup3AaRbJJ1sCeI0ANJkgYCrqqJiVkzSVAQ1Uat7p9LMLwVH30yeXDAHXaL4JMIFqTL1WJGgR7aaNf53U2GO/dKApKpewioC+Bcwg1rnHt//KwP4zhQjgAxA4oE6wElGQd/UPHvuJNirX3S2f7oN64cPTXvwEh89cyppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXvzb6mls0uT/AuPaepTWvIPjo6NWnSOetWbup4/Rnw=;
 b=JFsRBQH7RK5inLyUj8dmuweHn9dCgShirNgUwLvtrKmyCFHs/5qIXbIGFws/F1f/38BJRMbI8GxOJ7KXgLOw5oeQA5ZoUPmE27CdHRsIV1b9cwterFdrmtmiPrynZk9J4bGnyfx+EHtW+NML87PBjIJLywcWP7I5Q9sAMQiC5c0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Fri, 6 Sep
 2024 00:59:41 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 00:59:41 +0000
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
 AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AIAAVgGAgAK0ooCAIEFKAIAA0sIAgAPWhwCAAnZSAIAA99mAgACQGICAANfzAIAAhJUAgAAfSwCAAAOTgIAAE4YAgAAIvoA=
Date: Fri, 6 Sep 2024 00:59:41 +0000
Message-ID: <20240906005935.caugoe3mqqdqwqao@synopsys.com>
References: <2e678109-8399-48d5-9567-033eab910bca@samsung.com>
 <20240904010322.leqt3pap6lguivg4@synopsys.com>
 <11535d95-c972-4dbe-afb5-de3a44bc4a21@samsung.com>
 <CGME20240905002630epcas5p4532c1e66864e39990376b696aa1f53d7@epcas5p4.samsung.com>
 <20240905002611.rxlv66zsker2h5w2@synopsys.com>
 <d5552437-119c-4a0f-9d71-6959727b6364@samsung.com>
 <20240905211338.omst6jr3okbxkqdh@synopsys.com>
 <f9561f03-5f83-4270-b7f3-17b880cfabfe@samsung.com>
 <20240905231825.6r2sp2bapxidur7a@synopsys.com>
 <64d049cc-d55d-4376-b6b9-402eb6f170c0@samsung.com>
In-Reply-To: <64d049cc-d55d-4376-b6b9-402eb6f170c0@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH2PR12MB4312:EE_
x-ms-office365-filtering-correlation-id: 91175eb1-fbfd-4d9f-6d85-08dcce0f3097
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mk82S0g2a21oYXJiWVJUeVc0Y3A1YVFDbjhDbmJnclBlSEd3UkUzQmtoWWZz?=
 =?utf-8?B?T3F6NGZDUEJNUWltaWlVc3k2K1dIbWVxTlVOSlBSd08ySVBOZ2NFd2tDNVJ0?=
 =?utf-8?B?aTRBMmRESExhaUprOUpLV25valJPYWgzRU5JUWNtbDBmTWRPUlBzTS9qaXBV?=
 =?utf-8?B?YitoSHd6bG5kc3ZCTkY1NzRobVQ4MThKK3F5eE54M0NobklXblJMM3duMTRx?=
 =?utf-8?B?N090eCs2c1RKOUFBQnJuVkxMQWR0MVdBbmRSNnYrVWdoZmlRMDdvd251Q3FH?=
 =?utf-8?B?TGoyWjU3SkpHYjMzY1RPcHd4MTBiUGFPUkxoNCsrRDZaQXM2NitjUU5GOVNN?=
 =?utf-8?B?L3h2NVlIUzczTG5VdENONy96RU5kei92cHdBWWtZMjNPM25hblBqNGhRMlBu?=
 =?utf-8?B?c21TOXNReFRNL2dVQkVlZnViK1B1aFdNV2ZUVW5zb2hrRm0rUXppWWV3OVRt?=
 =?utf-8?B?aGNJRDlCTGZwcnVZcG1ZeHJRbVFNc3hSdVlpNm4zVHBvczZ1clN5NkE1SjRM?=
 =?utf-8?B?RFdmL2taRTc4Y0dsRGRFcEtPS2RpOThhR3VlQ0pJY2Rnd2s2TXRXZDZEb2xY?=
 =?utf-8?B?WmFBQ0JWUUJyR0dlUXFXb3pZbElRTW1mbC9SVWhObGdsa1dSNWk1VUVVZFR3?=
 =?utf-8?B?a3B3ekh5VFlVT0VRRkNRSlg3ZUlYWnlzK3NSbUFBeEtrcnROM015NEppcUNE?=
 =?utf-8?B?SnMvaTVTM0hSdFRqVDdzclcyOHZ5N3hSR0d0WEprcUc2V3gyQnV1RW1CWW5z?=
 =?utf-8?B?Q0FlOWdOSHh1U2M3SU9IWTJDbHVXMUIzUUl1SWNxdldwZVlIcXBWRDlOSUhO?=
 =?utf-8?B?Z1ZQVVJWaTFxU0E4b0pPMkdOWksyU1NhVWIxNTF6K1FWSHNSbmVybGxnMktr?=
 =?utf-8?B?ZXhqbVNkeTNhMVUxT21seDhRNzMwa1ZMLzFxbzZsbHZ6OTZteE53UmxCQjhx?=
 =?utf-8?B?Sjhac3NFbjVRUnI1NE1CVG9ZYnJlMzNXWTNxMURLZjBQaGp2NzRyUTcxVlh5?=
 =?utf-8?B?NU1LZFBWZXFydktoOHdTL0lPYnhxK1JaZHYxeHNvNTlTN2tTZGhYTzRqUXVk?=
 =?utf-8?B?d1BsSFlVRUlsRHR6ejVNRVp1aUh1Y2hwOXhKV0xMakJwSkJMaDk5TTZBelU1?=
 =?utf-8?B?SjFMblVZSlpaU1JGdlRBc0d6T3R5dFNVams1bE5WODFEYk5LQlR4Y3kzZm9s?=
 =?utf-8?B?YUdVSjRsbU1RUmJadXhEVU1NWWpPdGJoY0hpQXRkSE5HRkxobERObStuWWJJ?=
 =?utf-8?B?SHkyL1d0K2ZWNzhpRlRlWVRKaDBXUXdHUnJ0SDFidkwwclF6WlFyZEJ0aHRO?=
 =?utf-8?B?OHRwdG1vUVZNSXk1YXBGRDVtdkRwaUNLWTBrVzEzUExjbTd4Qmg1S1BKZlVy?=
 =?utf-8?B?UmhQZ05aN0ptdVA5M0J6RktPMVBmSUlaZWxtZzRHTjdHMG5NS1FoYXUxYzIx?=
 =?utf-8?B?K1p4eHpzYW82dVVGd0EvemNqMzY0cFpKc2krSkt1TDZSOS9zRkdXQ0VsUzl2?=
 =?utf-8?B?NTlsZHVyV2k1UkFMRm1yTHVYNUVkNW9jVC9WTTdrTldpNHNmakF1YVdqRTFw?=
 =?utf-8?B?NisvZ1JvQ1hCNVNqeHU3azFLV3JWQkRmOERSQUM1ME4vdzZSLzhldlV1YnVK?=
 =?utf-8?B?OTNpbE85cUszL1draVVoQU40eWU2TzFCTGhrNjJjUUx2YXVMNDE4TERiclFL?=
 =?utf-8?B?Tk5FYjdZazBhMkRza3cxYktUMEZDMzhCcnlrbmRreFBpZWdsa0NuVlRkNlFz?=
 =?utf-8?B?eko4N1NZT2pZd3NjUTVvQ3B1SEx3S2VqbWI4bmVXcGRDTmRkTVpmaUNGbXNK?=
 =?utf-8?B?cEVLSy9rVmRPcTBMMjZydDh3dGR4YVd0OFI2T0xTdDZRd1pMVElXNTNFVUti?=
 =?utf-8?B?NEV4MWlQajJXWHJWZFV3ZVpYaXF6d1JjU1A4YnRUZkFzQkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkN0ZFZWbk0xMFJ2RG9KSHpwaTdheVFJcUNVQ1ZNdXZoam83WTVwZWVUTDU4?=
 =?utf-8?B?bG9qL0RNWnkwYTZ4MEZZeFFFMjd3SHBRaWkrK1lzdzV4ekhMeXBQeTJkUS9s?=
 =?utf-8?B?UE5DRmNROGFpamxxWGpYVmhnWjMrc1hkODVCWFczUFAwcnFBWE9iTDY2ckp3?=
 =?utf-8?B?R1FSUUprc1pFY2ErU0FrbThIL0J2cEllZlZXQzJib3lzVWpWWTBFNVg4NUUv?=
 =?utf-8?B?N3o1YWw3bDFBZmpPbCtYbVZOc21HK3JPNlJEWk5HOXRtU3JmTlE2dWdlRXFZ?=
 =?utf-8?B?alVrYVVFbVlheUlmVmp1L0J5OWxmOG5iQUFmdElxNG9xdmRuYTdmbTF0SkZr?=
 =?utf-8?B?MVFkT3pqeUdyRW1rd1F1bHM5SjJOaSs3ajhJeG9nam9zY2laVHZaWG9LaEdq?=
 =?utf-8?B?blJTM0xVcW9EM0xGZitobTdUZWlnSXgyekhvdVF4L3d4VUVvSHE3eDljdDNZ?=
 =?utf-8?B?TlhiUUdGc0FsZ1Q2bU1MSUdYRWdXK2dwVFhvMzVRR3R2enZEQnhJVUt0YVZq?=
 =?utf-8?B?NU5YWGhKbzJrQmw3ZjllVzF1ZXg3UnhMc0RoL1VuQzBHZlpsZ00xTG5WRHRO?=
 =?utf-8?B?QWhINXNMTTRXRVZqV3VrbnQ5Q2U3YVcrSmN2M2ZmbU4vNUEwSC9xNTJmeUEx?=
 =?utf-8?B?ZFpIV1BiOUMvLy9aalJIS0x1a0dXaDBCZDR4VUxHTGhXYVJmSUlFVllGV2dT?=
 =?utf-8?B?SFh0NCt5SkgvMkdhckQ3cXFLdTE0c2FQdGRXMTRnVkt4cHNjM3p5aWNYRXJT?=
 =?utf-8?B?VU5Vb1pyT3lZUldxMHJoR2QzVHhtV2xidERRYWJFcDFOaGZBNzJseTdQdVBw?=
 =?utf-8?B?Q1RmUzFrOVROSiszUXlITlNCWFd0NENJNENiWGowdDhMRVRhaHp4WHZsL2Ey?=
 =?utf-8?B?RVgwK2UyTmw3R29paVkxUHlSTXJ3UGIzY3hFNGxuelQ5cjdCZWtlTFFZekpo?=
 =?utf-8?B?Yy8vRExtR0p3UmU0MTNSamFSOFJvdjlKdUp5eFI1cHpHbm1CR0tqQ2Y4alJr?=
 =?utf-8?B?MVVld2R1c3RlY2RQRHY3MHlvNnBYRGNhUFA4L0kwR0dZRGZGbUVwcy9mZCtY?=
 =?utf-8?B?VEdQcitVRkVaQnhhMElTZEIxRGtVMXFBcjZRSTdKcnMycVEwb1lFNlJoVTFI?=
 =?utf-8?B?T3JjRFpjNE9VdXBwa3NSZDM0d1dqdk5sTmp6b0NuRVhUZUFmQ0JueVVDUFZj?=
 =?utf-8?B?T0VBdElpclUrRFJkclcxc0lEdm5jYi9YdGFVVXJlN2NEZUYvelZVZWNBWjgv?=
 =?utf-8?B?RzlmMTdkV1BwRnZlWkx3U05udU5Qb3ErdGZzaFhxU05HSGFuemFzNUpWNlE3?=
 =?utf-8?B?aHkvY1V2cDE0WE9oWDFxdFJWeWxWNFdsM0JhVW41VlF6TWhGUldoYlRPMmEx?=
 =?utf-8?B?M3JlT3VwTFhFeVlTKzNxbjU1MTE2MjJ3MTdjQmV3a0xDQUR3U2lDWGd0VTVu?=
 =?utf-8?B?NVdJeFdRaGZCTTkyOU9ycVVDZDVOcklYdGc4ZDc3ZDNpaHZ3UFc5cm9Tckkv?=
 =?utf-8?B?NXhpdWJLWjhIcnhsN2d4dVVRWUJxZURNYUNEdnMxaGVWZHhxS2xXdU5hNHlR?=
 =?utf-8?B?TVVRNVJWUmNiWVlXaHNZUTlWSDNBclkvUGxuS2J1NXhLc1pRRGpCMVkwdFF0?=
 =?utf-8?B?Nkx1L2hGdXhidzRIcFpZM2NWRFVsZmtVUG5Jcm1wdXpoSGxnTUpPa2M5Q2xQ?=
 =?utf-8?B?QjBGSlM2bXlhUVNUWHZPeFdCdzJrdHJERTd5TElxQXhoN24xTXo4VTJFT1F6?=
 =?utf-8?B?WEsrOGpZZmJjVUtXT0piZm5pNnVXQVlwSlpLNE1QVnMraWJVTEVQT2FFajlS?=
 =?utf-8?B?cHZXU1ZjSjNQNmtqemZyM2xkM0VxQzBFaHBSZGVvdDJEWkY0WmtyOWZRbkM0?=
 =?utf-8?B?M0lKeC9jOURjZXJrMjcyZktiMm83WVBHQm1ZTVk4OVZiOWhud2hlUGZhVHFU?=
 =?utf-8?B?TVVCUEsyVGd1MC9HL25mK0tQZ2VIVE93UWRra1QwT0EyQVVJN1FHV2FUWDBn?=
 =?utf-8?B?ZDJPY1QyVE4xblVMQVhkU2dSdGNBNm9IbEFVWWlFNk8reW1EMHJOaHhHd0FQ?=
 =?utf-8?B?TDFBNWwrNndmTDlqSzMxTzcwUXkySkpwVzNFeS9kQjJMcmN6bHdXYjAyMWhU?=
 =?utf-8?Q?KjXeI1BlGJIY+tdgJhT+AHcF4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D808F9C36815E3489DA8850FDA6E16A1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+70Ki4dNYV4EOw2G57IL6cRq5wO8k8Ie72PiM7orgc7rdvhcag1/833g8J6HUbhCLHOW4txThQgQvEQIyKgKEft32EGV17Z/OZNOf2ALw/skYiPkR+YzB1YURKc2OMuIT8iGKRxxROgZNuY8TKl7XlMob3bAUosUFP55j8gKb0OjS+UBdOSz3rArOLF8Y+73jCkxEKU23cVqyB6kd8XuRenXG3uY9xarSHx6QWT00ViZ1Tw694Ur1CRvEF2aJlKYXr+cEpjRZuSZzo3iFyRYujgGPeoIrIR11aE1yjg+3D0HInDclgGH0ZJsiFBt6fjrdN1tolAqiimPVrIwNu7SPdd2fuF3II5gfQ46W1oQdxilGdbyOhy+oTS2093hjF5aqn8C+dQcYIOelPrI425lyHTuIoXnZTD2CdRul6q4BOs1soUVb7K0XKTJY/s2iCpZbgXkFV8VLnpsPTWDzXNcSxDs6xUQvG82zYaAg7cn36wd00m/OY/hiEHvY2/Yqj0TqDs1kRDvlXO66B0M/XHuPxfiVVROdHvVruIvlClT2GGyluLnG8cx6JkKW2mDmhoS5BvsXNKWYAjjHNaimq7L9Z9Z9iabdE47RT5oMkaSG01qplERHOtH5+xAqTtkIKvgVkeXwAe0Ebko037H1tJMhg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91175eb1-fbfd-4d9f-6d85-08dcce0f3097
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 00:59:41.4790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tFKiGYhXu8ZaTLuKvWc5NFgBF+/DMv8RBTXqtJZq2jEaupwwkywBASfiVJ3bxLZMYC/wvMUd+WGIcvGG0XbLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
X-Authority-Analysis: v=2.4 cv=YNLNygGx c=1 sm=1 tr=0 ts=66da5405 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8 a=oarfYKg-q7TMkqutwZYA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: tc1XyGMP3tmvxx2__FNZalzrTl2z0Ts3
X-Proofpoint-ORIG-GUID: tc1XyGMP3tmvxx2__FNZalzrTl2z0Ts3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409060006

T24gRnJpLCBTZXAgMDYsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
OS82LzIwMjQgNDo0OCBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIEZyaSwgU2VwIDA2
LCAyMDI0LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4gPj4gT24gOS82LzIwMjQgMjo0MyBB
TSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+Pj4gT24gVGh1LCBTZXAgMDUsIDIwMjQsIFNlbHZh
cmFzdSBHYW5lc2FuIHdyb3RlOg0KPiA+Pj4+IE9uIDkvNS8yMDI0IDU6NTYgQU0sIFRoaW5oIE5n
dXllbiB3cm90ZToNCj4gPj4+Pj4gT24gV2VkLCBTZXAgMDQsIDIwMjQsIFNlbHZhcmFzdSBHYW5l
c2FuIHdyb3RlOg0KPiA+Pj4+Pj4gT24gOS80LzIwMjQgNjozMyBBTSwgVGhpbmggTmd1eWVuIHdy
b3RlOg0KPiA+Pj4+Pj4+IE9uIE1vbiwgU2VwIDAyLCAyMDI0LCBTZWx2YXJhc3UgR2FuZXNhbiB3
cm90ZToNCj4gPj4+Pj4+Pj4gSSB3b3VsZCBsaWtlIHRvIHJlY29uZmlybSBmcm9tIG91ciBlbmQg
dGhhdCBpbiBvdXIgZmFpbHVyZSBzY2VuYXJpbywgd2UNCj4gPj4+Pj4+Pj4gb2JzZXJ2ZSB0aGF0
IERXQzNfRVZFTlRfUEVORElORyBpcyBzZXQgaW4gZXZ0LT5mbGFncyB3aGVuIHRoZSBkd2MzDQo+
ID4+Pj4+Pj4+IHJlc3VtZSBzZXF1ZW5jZSBpcyBleGVjdXRlZCwgYW5kIHRoZSBkd2MtPnBlbmRp
bmdfZXZlbnRzIGZsYWcgaXMgbm90DQo+ID4+Pj4+Pj4+IGJlaW5nIHNldC4NCj4gPj4+Pj4+Pj4N
Cj4gPj4+Pj4+PiBJZiB0aGUgY29udHJvbGxlciBpcyBzdG9wcGVkLCBubyBldmVudCBpcyBnZW5l
cmF0ZWQgdW50aWwgaXQncyByZXN0YXJ0ZWQNCj4gPj4+Pj4+PiBhZ2Fpbi4gKGllLCB5b3Ugc2hv
dWxkIG5vdCBzZWUgR0VWTlRDT1VOVCB1cGRhdGVkIGFmdGVyIGNsZWFyaW5nDQo+ID4+Pj4+Pj4g
RENUTC5ydW5fc3RvcCkuIElmIHRoZXJlJ3Mgbm8gZXZlbnQsIG5vIGludGVycnVwdCBhc3NlcnRp
b24gc2hvdWxkIGNvbWUNCj4gPj4+Pj4+PiBmcm9tIHRoZSBjb250cm9sbGVyLg0KPiA+Pj4+Pj4+
DQo+ID4+Pj4+Pj4gSWYgdGhlIHBlbmRpbmdfZXZlbnRzIGlzIG5vdCBzZXQgYW5kIHlvdSBzdGls
bCBzZWUgdGhpcyBmYWlsdXJlLCB0aGVuDQo+ID4+Pj4+Pj4gbGlrZWx5IHRoYXQgdGhlIGNvbnRy
b2xsZXIgaGFkIHN0YXJ0ZWQsIGFuZCB0aGUgaW50ZXJydXB0IGlzIGdlbmVyYXRlZA0KPiA+Pj4+
Pj4+IGZyb20gdGhlIGNvbnRyb2xsZXIgZXZlbnQuIFRoaXMgb2NjdXJzIGFsb25nIHdpdGggdGhl
IGludGVycnVwdA0KPiA+Pj4+Pj4+IGdlbmVyYXRlZCBmcm9tIHlvdXIgY29ubmVjdGlvbiBub3Rp
ZmljYXRpb24gZnJvbSB5b3VyIHNldHVwLg0KPiA+Pj4+Pj4gSSBjb21wbGV0ZWx5IGFncmVlLiBN
eSBkaXNjdXNzaW9uIHJldm9sdmVzIGFyb3VuZCB0aGUgaGFuZGxpbmcgb2YgdGhlDQo+ID4+Pj4+
PiBEV0MzX0VWRU5UX1BFTkRJTkcgZmxhZyBpbiBhbGwgc2l0dWF0aW9ucy4gVGhlIHB1cnBvc2Ug
b2YgdXNpbmcgdGhpcw0KPiA+Pj4+Pj4gZmxhZyBpcyB0byBwcmV2ZW50IHRoZSBwcm9jZXNzaW5n
IG9mIG5ldyBldmVudHMgaWYgYW4gZXhpc3RpbmcgZXZlbnQgaXMNCj4gPj4+Pj4+IHN0aWxsIGJl
aW5nIHByb2Nlc3NlZC4gVGhpcyBmbGFnIGlzIHNldCBpbiB0aGUgdG9wLWhhbGYgaW50ZXJydXB0
DQo+ID4+Pj4+PiBoYW5kbGVyIGFuZCBjbGVhcmVkIGF0IHRoZSBlbmQgb2YgdGhlIGJvdHRvbS1o
YWxmIGhhbmRsZXIuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gTm93LCBsZXQncyBjb25zaWRlciBzY2Vu
YXJpb3Mgd2hlcmUgdGhlIGJvdHRvbSBoYWxmIGlzIG5vdCBzY2hlZHVsZWQsDQo+ID4+Pj4+PiBh
bmQgYSBVU0IgcmVjb25uZWN0IG9jY3Vycy4gSW4gdGhpcyBjYXNlLCB0aGVyZSBpcyBhIHBvc3Np
YmlsaXR5IHRoYXQNCj4gPj4+Pj4+IHRoZSBpbnRlcnJ1cHQgbGluZSBpcyB1bm1hc2tlZCBpbiBk
d2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAsIGFuZCB0aGUgVVNCDQo+ID4+Pj4+PiBjb250cm9sbGVy
IGJlZ2lucyBwb3N0aW5nIG5ldyBldmVudHMuIFRoZSB0b3AtaGFsZiBpbnRlcnJ1cHQgaGFuZGxl
cg0KPiA+Pj4+Pj4gY2hlY2tzIGZvciB0aGUgRFdDM19FVkVOVF9QRU5ESU5HIGZsYWcgYW5kIHJl
dHVybnMgSVJRX0hBTkRMRUQgd2l0aG91dA0KPiA+Pj4+Pj4gcHJvY2Vzc2luZyBhbnkgbmV3IGV2
ZW50cy4gSG93ZXZlciwgdGhlIFVTQiBjb250cm9sbGVyIGNvbnRpbnVlcyB0byBwb3N0DQo+ID4+
Pj4+PiBpbnRlcnJ1cHRzIHVudGlsIHRoZXkgYXJlIGFja25vd2xlZGdlZC4NCj4gPj4+Pj4+DQo+
ID4+Pj4+PiBQbGVhc2UgcmV2aWV3IHRoZSBjb21wbGV0ZSBzZXF1ZW5jZSBvbmNlIHdpdGggRFdD
M19FVkVOVF9QRU5ESU5HIGZsYWcuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gTXkgcHJvcG9zYWwgaXMg
dG8gY2xlYXIgb3IgcmVzZXQgdGhlIERXQzNfRVZFTlRfUEVORElORyBmbGFnIHdoZW4NCj4gPj4+
Pj4+IHVubWFza2luZyB0aGUgaW50ZXJydXB0IGxpbmUgZHdjM19ldmVudF9idWZmZXJzX3NldHVw
LCBhcGFydCBmcm9tDQo+ID4+Pj4+PiBib3R0b20taGFsZiBoYW5kbGVyLiBDbGVhcmluZyB0aGUg
RFdDM19FVkVOVF9QRU5ESU5HIGZsYWcgaW4NCj4gPj4+Pj4+IGR3YzNfZXZlbnRfYnVmZmVyc19z
ZXR1cCBkb2VzIG5vdCBjYXVzZSBhbnkgaGFybSwgYXMgd2UgaGF2ZSBpbXBsZW1lbnRlZA0KPiA+
Pj4+Pj4gYSB0ZW1wb3Jhcnkgd29ya2Fyb3VuZCBpbiBvdXIgdGVzdCBzZXR1cCB0byBwcmV2ZW50
IElSUSBzdG9ybXMuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBXb3Jr
aW5nIHNjZW5hcmlvczoNCj4gPj4+Pj4+ID09PT09PT09PT09PT09PT09PQ0KPiA+Pj4+Pj4gMS4g
VG9wLWhhbGYgaGFuZGxlcjoNCj4gPj4+Pj4+ICAgICDCoMKgwqAgYS4gaWYgKGV2dC0+ZmxhZ3Mg
JiBEV0MzX0VWRU5UX1BFTkRJTkcpDQo+ID4+Pj4+PiAgICAgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IElSUV9IQU5ETEVEOw0KPiA+Pj4+Pj4gICAgIMKgwqDCoCBiLiBTZXQgRFdDM19FVkVOVF9QRU5E
SU5HIGZsYWcNCj4gPj4+Pj4+ICAgICDCoMKgwqAgYy4gTWFza2luZyBpbnRlcnJ1cHQgbGluZQ0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+IDIuIEJvdHRvbS1oYWxmIGhhbmRsZXI6DQo+ID4+Pj4+PiAgICAg
wqDCoMKgIGEuIFVuLW1hc2tpbmcgaW50ZXJydXB0IGxpbmUNCj4gPj4+Pj4+ICAgICDCoMKgwqAg
Yi4gQ2xlYXIgRFdDM19FVkVOVF9QRU5ESU5HIGZsYWcNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBGYWls
dXJlIHNjZW5hcmlvczoNCj4gPj4+Pj4+ID09PT09PT09PT09PT09PT09PQ0KPiA+Pj4+Pj4gMS4g
VG9wLWhhbGYgaGFuZGxlcjoNCj4gPj4+Pj4+ICAgICDCoMKgwqAgYS4gaWYgKGV2dC0+ZmxhZ3Mg
JiBEV0MzX0VWRU5UX1BFTkRJTkcpDQo+ID4+Pj4+PiAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiBJUlFfSEFORExFRDsNCj4gPj4+Pj4+ICAgICDCoMKgwqAgYi4gU2V0
IERXQzNfRVZFTlRfUEVORElORyBmbGFnDQo+ID4+Pj4+PiAgICAgwqDCoMKgIGMuIE1hc2tpbmcg
aW50ZXJydXB0IGxpbmUNCj4gPj4+Pj4gRm9yIERXQzNfRVZFTlRfUEVORElORyBmbGFnIHRvIGJl
IHNldCBhdCB0aGlzIHBvaW50IChiZWZvcmUgd2Ugc3RhcnQgdGhlDQo+ID4+Pj4+IGNvbnRyb2xs
ZXIpLCB0aGF0IG1lYW5zIHRoYXQgdGhlIEdFVk5UQ09VTlQgd2FzIG5vdCAwIGFmdGVyDQo+ID4+
Pj4+IHNvZnQtZGlzY29ubmVjdCBhbmQgdGhhdCB0aGUgcG1fcnVudGltZV9zdXNwZW5kZWQoKSBt
dXN0IGJlIGZhbHNlLg0KPiA+Pj4+IEluIHRoZSB0b3AtaGFsZiBjb2RlIHdoZXJlIHdlIHNldCB0
aGUgRFdDM19FVkVOVF9QRU5ESU5HIGZsYWcsIHdlDQo+ID4+Pj4gYWNrbm93bGVkZ2UgR0VWTlRD
T1VOVC4gVGhlcmVmb3JlLCBJIHRoaW5rIGl0IGlzIG5vdCBuZWNlc3NhcnkgZm9yDQo+ID4+Pj4g
R0VWTlRDT1VOVCB0byBoYXZlIGEgbm9uLXplcm8gdmFsdWUgdW50aWwgYSBuZXcgZXZlbnQgb2Nj
dXJzLiBJbiBmYWN0LA0KPiA+Pj4+IHdoZW4gd2UgdHJpZWQgdG8gcHJpbnQgR0VWTlRDT1VOVCBp
biBhIG5vbi1pbnRlcnJ1cHQgY29udGV4dCwgd2UgZm91bmQNCj4gPj4+PiB0aGF0IGl0IHdhcyB6
ZXJvLCB3aGVyZSB3ZSByZWNlaXZlZCBEV0MzX0VWRU5UX1BFTkRJTkcgYmVpbmcgc2V0IGluDQo+
ID4+Pj4gbm9uLWludGVycnVwdCBjb250ZXh0Lg0KPiA+Pj4gRm9yIERXQzNfRVZFTlRfUEVORElO
RyB0byBiZSBzZXQsIEdFVk5UQ09VTlQgbXVzdCBiZSBub24temVyby4gSWYgeW91DQo+ID4+PiBz
ZWUgaXQncyB6ZXJvLCB0aGF0IG1lYW5zIHRoYXQgaXQgd2FzIGFscmVhZHkgZGVjcmVtZW50ZWQg
YnkgdGhlIGRyaXZlci4NCj4gPj4+DQo+ID4+PiBJZiB0aGUgZHJpdmVyIGFja25vd2xlZGdlcyB0
aGUgR0VWTlRDT1VOVCwgdGhlbiB0aGF0IG1lYW5zIHRoYXQgdGhlDQo+ID4+PiBldmVudHMgYXJl
IGNvcGllZCBhbmQgcHJlcGFyZWQgdG8gYmUgcHJvY2Vzc2VkLiBUaGUgYm90dG9tLWhhbGYgdGhy
ZWFkDQo+ID4+PiBpcyBzY2hlZHVsZWQuIElmIGl0J3MgZm9yIHN0YWxlIGV2ZW50LCBJIGRvbid0
IHdhbnQgaXQgdG8gYmUgcHJvY2Vzc2VkLg0KPiA+Pj4NCj4gPj4+Pj4+IDIuIE5vIEJvdHRvbS1o
YWxmIHNjaGVkdWxlZDoNCj4gPj4+Pj4gV2h5IGlzIHRoZSBib3R0b20taGFsZiBub3Qgc2NoZWR1
bGVkPyBPciBkbyB5b3UgbWVhbiBpdCBoYXNuJ3Qgd29rZW4gdXANCj4gPj4+Pj4geWV0IGJlZm9y
ZSB0aGUgbmV4dCB0b3AtaGFsZiBjb21pbmc/DQo+ID4+Pj4gSW7CoHZlcnkgcmFyZSBjYXNlcywg
aXQgaXMgcG9zc2libGUgaW4gb3VyIHBsYXRmb3JtIHRoYXQgdGhlIENQVSBtYXkgbm90DQo+ID4+
Pj4gYmUgYWJsZSB0byBzY2hlZHVsZSB0aGUgYm90dG9tIGhhbGYgb2YgdGhlIGR3YzMgaW50ZXJy
dXB0IGJlY2F1c2UgYSB3b3JrDQo+ID4+Pj4gcXVldWUgbG9ja3VwIGhhcyBvY2N1cnJlZCBvbiB0
aGUgc2FtZSBDUFUgdGhhdCBpcyBhdHRlbXB0aW5nIHRvIHNjaGVkdWxlDQo+ID4+Pj4gdGhlIGR3
YzMgdGhyZWFkIGludGVycnVwdC4gSW4gdGhpcyBjYXNlIFllcywgdGhlIGJvdHRvbS1oYWxmIGhh
bmRsZXINCj4gPj4+PiBoYXNuJ3Qgd29rZW4gdXAsIHRoZW4gaW5pdGlhdGUgYW4gSVJRIHN0b3Jt
IGZvciBuZXcgZXZlbnRzIGFmdGVyIHRoZQ0KPiA+Pj4+IGNvbnRyb2xsZXIgcmVzdGFydHMsIHJl
c3VsdGluZyBpbiBubyBtb3JlIGJvdHRvbS1oYWxmIHNjaGVkdWxpbmcgZHVlIHRvDQo+ID4+Pj4g
dGhlIENQVSBiZWluZyBzdHVjayBpbiBwcm9jZXNzaW5nIGNvbnRpbnVvdXMgaW50ZXJydXB0cyBh
bmQgcmV0dXJuDQo+ID4+Pj4gSVJRX0hBTkRMRUQgYnkgY2hlY2tpbmcgaWYgKGV2dC0+ZmxhZ3Mg
JiBEV0MzX0VWRU5UX1BFTkRJTkcpLg0KPiA+Pj4+DQo+ID4+Pj4+PiAzLiBVU0IgcmVjb25uZWN0
OiBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXANCj4gPj4+Pj4+ICAgICDCoMKgwqAgYS4gVW4tbWFz
a2luZyBpbnRlcnJ1cHQgbGluZQ0KPiA+Pj4+PiBEbyB3ZSBrbm93IHRoYXQgdGhlIEdFVk5UQ09V
TlQgaXMgbm9uLXplcm8gYmVmb3JlIHN0YXJ0aW5nIHRoZQ0KPiA+Pj4+PiBjb250cm9sbGVyIGFn
YWluPw0KPiA+Pj4+IFRoZSBHRVZOVENPVU5UIHZhbHVlIHNob3dpbmcgYXMgemVybyB0aGF0IHdl
IGNvbmZpcm1lZCBieSBhZGRpbmcgZGVidWcNCj4gPj4+PiBtZXNzYWdlIGhlcmUuDQo+ID4+Pj4+
PiA0LiBDb250aW51b3VzIGludGVycnVwdHMgOiBUb3AtaGFsZiBoYW5kbGVyOg0KPiA+Pj4+Pj4g
ICAgIMKgwqDCoCBhLiBpZiAoZXZ0LT5mbGFncyAmIERXQzNfRVZFTlRfUEVORElORykNCj4gPj4+
Pj4+ICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIElSUV9IQU5ETEVE
Ow0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICAgICDCoMKgwqAgYS4gaWYgKGV2dC0+ZmxhZ3MgJiBEV0Mz
X0VWRU5UX1BFTkRJTkcpDQo+ID4+Pj4+PiAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiBJUlFfSEFORExFRDsNCj4gPj4+Pj4+DQo+ID4+Pj4+PiAgICAgwqDCoMKgIGEu
IGlmIChldnQtPmZsYWdzICYgRFdDM19FVkVOVF9QRU5ESU5HKQ0KPiA+Pj4+Pj4gICAgIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4+Pj4+PiAu
Li4uLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IC4uLi4uDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gLi4uLi4N
Cj4gPj4+Pj4+DQo+ID4+Pj4gU3VyZSwgSSBjYW4gdHJ5IGltcGxlbWVudGluZyB0aGUgcHJvcG9z
ZWQgY29kZSBtb2RpZmljYXRpb25zIGluIG91cg0KPiA+Pj4+IHRlc3RpbmcgZW52aXJvbm1lbnQu
DQo+ID4+Pj4NCj4gPj4+PiBCdXQsIEkgYW0gdW5jZXJ0YWluIGFib3V0IGhvdyB0aGVzZSBjaGFu
Z2VzIHdpbGwgZWZmZWN0aXZlbHkgcHJldmVudCBhbg0KPiA+Pj4+IElSUSBzdG9ybSB3aGVuIHRo
ZSBVU0IgY29udHJvbGxlciBzZXF1ZW5jZSByZXN0YXJ0cyB3aXRoIHRoZQ0KPiA+Pj4+IERXQzNf
RVZFTlRfUEVORElORy4gVGhlIGZvbGxvd2luZyBjb2RlIHdpbGwgb25seSBleGVjdXRlIHVudGls
IHRoZQ0KPiA+Pj4+IERXQzNfRVZFTlRfUEVORElORyBpcyBjbGVhcmVkLCBhdCB3aGljaCBwb2lu
dCB0aGUgcHJldmlvdXMgYm90dG9tLWhhbGYNCj4gPj4+PiB3aWxsIG5vdCBiZSBzY2hlZHVsZWQu
DQo+ID4+Pj4NCj4gPj4+PiBQbGVhc2UgY29ycmVjdCBtZSBpZiBpIGFtIHdyb25nIGluIG15IGFi
b3ZlIHVuZGVyc3RhbmRpbmcuDQo+ID4+PiBBcyBJIG1lbnRpb25lZCwgSSBkb24ndCB3YW50IERX
QzNfRVZFTlRfUEVORElORyBmbGFnIHRvIGJlIHNldCBkdWUgdG8NCj4gPj4+IHRoZSBzdGFsZSBl
dmVudC4gSSB3YW50IHRvIGlnbm9yZSBhbmQgc2tpcCBwcm9jZXNzaW5nIGFueSBzdGFsZSBldmVu
dC4NCj4gPj4+DQo+ID4+PiBUaGUgRFdDM19FVkVOVF9QRU5ESU5HIHNob3VsZCBub3QgYmUgc2V0
IGJ5IHRoZSB0aW1lDQo+ID4+PiBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoKSBpcyBjYWxsZWQu
DQo+ID4+Pg0KPiA+Pj4gU3BlY2lmaWNhbGx5IHJldmlldyB0aGlzIGNvbmRpdGlvbiBpbiBteSB0
ZXN0aW5nIHBhdGNoOg0KPiA+Pj4NCj4gPj4+IAkvKg0KPiA+Pj4gCSAqIElmIHRoZSBjb250cm9s
bGVyIGlzIGhhbHRlZCwgdGhlIGV2ZW50IGNvdW50IGlzIHN0YWxlL2ludmFsaWQuIElnbm9yZQ0K
PiA+Pj4gCSAqIHRoZW0uIFRoaXMgaGFwcGVucyBpZiB0aGUgaW50ZXJydXB0IGFzc2VydGlvbiBp
cyBmcm9tIGFuIG91dC1vZi1iYW5kDQo+ID4+PiAJICogcmVzdW1lIG5vdGlmaWNhdGlvbi4NCj4g
Pj4+IAkgKi8NCj4gPj4+IAlpZiAoIWR3Yy0+cHVsbHVwc19jb25uZWN0ZWQgJiYgY291bnQpIHsN
Cj4gPj4+IAkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09VTlQoMCksIGNvdW50
KTsNCj4gPj4+IAkJcmV0dXJuIElSUV9IQU5ETEVEOw0KPiA+Pj4gCX0NCj4gPj4+DQo+ID4+PiBM
ZXQgbWUga25vdyBpZiB0aGUgY29uZGl0aW9uIG1hdGNoZXMgd2l0aCB3aGF0J3MgaGFwcGVuaW5n
IGZvciB5b3VyDQo+ID4+PiBjYXNlLg0KPiA+PiBIaSBUaGluaCwNCj4gPj4NCj4gPj4gVGhhbmtz
IGZvciB5b3VyIGNvbnRpbnVvdXMgcmV2aWV3cyBhbmQgc3VnZ2VzdGlvbnMuDQo+ID4+DQo+ID4+
IFRoZSBnaXZlbiBjb25kaXRpb24gYWxzbyB3aWxsIG5vdCBtYXRjaGVzIGluIG91ciBjYXNlLg0K
PiA+PiBBcyBpIG1lbnRpb25lZCBpbiBzdGFydGluZyBvZiB0aGlzIHRocmVhZCBwbGVhc2UgcmVm
ZXIgb25jZSB0aGUgYmVsb3cNCj4gPj4gbGluayBvZiBvbGRlciBkaXNjdXNzaW9uIGZvciBzaW1p
bGFyIGlzc3VlIGZyb20gU2Ftc3VuZy4uDQo+ID4+DQo+ID4+IGh0dHBzOi8vdXJsZGVmZW5zZS5j
b20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvMjAyMzAxMDIwNTA4MzEu
MTA1NDk5LTEtamgwODAxLmp1bmdAc2Ftc3VuZy5jb20vX187ISFBNEYyUjlHX3BnIWEzVnBQSHZN
cjllbmswWVBqU29XSjEyS3I1SHcyS2E0M1Ffd2k4MGx3NnR5MnRKVDRoS1JLc0NuUU5kcWJWUzNK
T1JLMlZ3cWRvWERXejFxOHlucGU3RXg2Y1UkDQo+ID4+DQo+ID4+DQo+ID4+IERXQzNfRVZFTlRf
UEVORElORyBmbGFncyBzZXQgd2hlbiBjb3VudCBpcyAwLg0KPiA+PiBJdCBtZWFucyAiVGhlcmUg
YXJlIG5vIGludGVycnVwdHMgdG8gaGFuZGxlLiIuDQo+ID4+DQo+ID4+IChzdHJ1Y3QgZHdjM19l
dmVudF9idWZmZXIgKikgZXZfYnVmID0gMHhGRkZGRkY4ODNEQkYxMTgwICgNCj4gPj4gCSh2b2lk
ICopIGJ1ZiA9IDB4RkZGRkZGQzAwREJERDAwMCA9IGVuZCsweDMzN0QwMDAsDQo+ID4+IAkodm9p
ZCAqKSBjYWNoZSA9IDB4RkZGRkZGODgzOUY1NDA4MCwNCj4gPj4gCSh1bnNpZ25lZCBpbnQpIGxl
bmd0aCA9IDB4MTAwMCwNCj4gPj4gCSh1bnNpZ25lZCBpbnQpIGxwb3MgPSAweDAsDQo+ID4+ICoo
dW5zaWduZWQgaW50KSBjb3VudCA9IDB4MCwgKHVuc2lnbmVkIGludCkgZmxhZ3MgPSAweDAwMDAw
MDAxLCoNCj4gPj4gCShkbWFfYWRkcl90KSBkbWEgPSAweDAwMDAwMDA4QkQ3RDcwMDAsDQo+ID4+
IAkoc3RydWN0IGR3YzMgKikgZHdjID0gMHhGRkZGRkY4ODM5Q0JDODgwLA0KPiA+PiAJKHU2NCkg
YW5kcm9pZF9rYWJpX3Jlc2VydmVkMSA9IDB4MCksDQo+ID4NCj4gPiBUaGlzIGlzIHRoZSBpbmZv
IG9mIHRoZSBldmVudCBidWZmZXIgdGhhdCB3YXMgcmVzZXQgYWZ0ZXIgdGhlDQo+ID4gZHdjM19l
dmVudF9idWZmZXJzX3NldHVwKCkuIEknbSB0YWxraW5nIGFib3V0IHRoZSBmaXJzdCB0aW1lDQo+
ID4gRFdDM19FVkVOVF9QRU5ESU5HIGZsYWcgd2FzIHNldC4NCj4gDQo+IFllcywgdGhlIGJ1ZmZl
ciB0aGF0IHdhcyByZXNldCBiZWZvcmUgYXMgcGFydCBvZiANCj4gZHdjM19ldmVudF9idWZmZXJz
X3NldHVwKCkgaXMgY29ycmVjdC4NCj4gSSBhZ3JlZSBvbiB5b3VyIG5ldyBjb2RlIGNoYW5nZXMg
aW4gYmVsb3cgd2lsbCBwcmV2ZW50IHNldHRpbmcgDQo+IERXQzNfRVZFTlRfUEVORElORyBhbmQg
YXZvaWQgdGhlIGJvdHRvbS1oYWxmIGhhbmRsZXIgaWYgdGhlIGNvbnRyb2xsZXIgDQo+IGlzIGhh
bHRlZCwgYW5kIHRoZSBldmVudCBjb3VudCBpcyBpbnZhbGlkLg0KPiANCj4gQXJlIHlvdSBzdXNw
ZWN0aW5nIHRoYXQgdGhlIERXQzNfRVZFTlRfUEVORElORyBmbGFnIHdhcyBvbmx5IHNldCBpbiB0
aGlzIA0KPiBzY2VuYXJpbyBpbiBvdXIgZmFpbHVyZSBjYXNlPw0KDQpCYXNlIG9uIHRoZSBkaXNj
dXNzaW9uIHNvIGZhciwgdGhhdCdzIHdoYXQgSSdtIHN1c3BlY3RpbmcuDQoNCj4gDQo+IC8qZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jDQo+IGluZGV4IDg5ZmM2OTBmZGYzNC4uYTUyNWY3ZWE1ODg2IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMNCj4gQEAgLTQ0OTAsNiArNDQ5MCwxNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgZHdjM19j
aGVja19ldmVudF9idWYoc3RydWN0IGR3YzNfZXZlbnRfYnVmZmVyICpldnQpDQo+ICAgCQlyZXR1
cm4gSVJRX0hBTkRMRUQ7DQo+ICAgDQo+ICAgCWNvdW50ID0gZHdjM19yZWFkbChkd2MtPnJlZ3Ms
IERXQzNfR0VWTlRDT1VOVCgwKSk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIElmIHRoZSBjb250cm9s
bGVyIGlzIGhhbHRlZCwgdGhlIGV2ZW50IGNvdW50IGlzIHN0YWxlL2ludmFsaWQuIElnbm9yZQ0K
PiArCSAqIHRoZW0uIFRoaXMgaGFwcGVucyBpZiB0aGUgaW50ZXJydXB0IGFzc2VydGlvbiBpcyBm
cm9tIGFuIG91dC1vZi1iYW5kDQo+ICsJICogcmVzdW1lIG5vdGlmaWNhdGlvbi4NCj4gKwkgKi8N
Cj4gKwlpZiAoIWR3Yy0+cHVsbHVwc19jb25uZWN0ZWQgJiYgY291bnQpIHsNCj4gKwkJZHdjM193
cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09VTlQoMCksIGNvdW50KTsNCj4gKwkJcmV0dXJu
IElSUV9IQU5ETEVEOw0KPiArCX0NCj4gKw0KPiAgIAljb3VudCAmPSBEV0MzX0dFVk5UQ09VTlRf
TUFTSzsNCj4gICAJaWYgKCFjb3VudCkNCj4gICAJCXJldHVybiBJUlFfTk9ORTsNCj4gDQo+ID4N
Cj4gPiBCeSB0aGUgdGltZSB0aGUgaW50ZXJydXB0IHN0b3JtIGJlbG93IG9jY3VyLCB0aGUgY291
bnQgaW4gdGhlIGJ1ZmZlciBpcw0KPiA+IGFscmVhZHkgemVybydlZCBvdXQuDQo+ID4NCj4gPj4g
SVJRIFN0b3JtOg0KPiA+PiAodGltZSA9IDQ3NTU3NjI4OTMwOTk5LCBpcnEgPSAxNjUsIGZuID0g
ZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9IDEpLA0KPiA+PiAodGltZSA9IDQ3NTU3
NjI4OTMxMjY4LCBpcnEgPSAxNjUsIGZuID0gZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBl
biA9IDMpLA0KPiA+PiAodGltZSA9IDQ3NTU3NjI4OTMyMzgzLCBpcnEgPSAxNjUsIGZuID0gZHdj
M19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9IDEpLA0KPiA+PiAodGltZSA9IDQ3NTU3NjI4
OTMyNjUyLCBpcnEgPSAxNjUsIGZuID0gZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9
IDMpLA0KPiA+PiAodGltZSA9IDQ3NTU3NjI4OTMzNzY4LCBpcnEgPSAxNjUsIGZuID0gZHdjM19p
bnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9IDEpLA0KPiA+PiAodGltZSA9IDQ3NTU3NjI4OTM0
MDM3LCBpcnEgPSAxNjUsIGZuID0gZHdjM19pbnRlcnJ1cHQsIGxhdGVuY3kgPSAwLCBlbiA9IDMp
LA0KPiA+PiAuLi4NCj4gPj4gLi4uDQo+ID4+IC4uLg0KPiA+Pg0KPiA+Pg0KPiA+PiBXZSBhcmUg
YWxzbyBmaW5lIHdpdGggYmVsb3cgY29kZSBjaGFuZ2VzIGFzIHlvdSBzdWdnZXN0ZWQgZWFybGll
ci4NCj4gPj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXVzYi8yMDIzMDEwOTE5MDkxNC4zYmxpaGpmamRjc3phemRkQHN5bm9wc3lzLmNv
bS9fXzshIUE0RjJSOUdfcGchYTNWcFBIdk1yOWVuazBZUGpTb1dKMTJLcjVIdzJLYTQzUV93aTgw
bHc2dHkydEpUNGhLUktzQ25RTmRxYlZTM0pPUksyVndxZG9YRFd6MXE4eW5wMzY3enZFdyQNCj4g
Pj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQo+ID4+IGluZGV4IDY1NTAwMjQ2MzIzYi4uM2MzNmRmZGI4OGYw
IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPj4gQEAgLTU1MTUsOCArNTUxNSwxNSBAQCBz
dGF0aWMgaXJxcmV0dXJuX3QgZHdjM19jaGVja19ldmVudF9idWYoc3RydWN0DQo+ID4+IGR3YzNf
ZXZlbnRfYnVmZmVyICpldnQpDQo+ID4+ICAgwqDCoMKgwqDCoMKgwqDCoCAqIGlycSBldmVudCBo
YW5kbGVyIGNvbXBsZXRlcyBiZWZvcmUgY2FjaGluZyBuZXcgZXZlbnQgdG8gcHJldmVudA0KPiA+
PiAgIMKgwqDCoMKgwqDCoMKgwqAgKiBsb3NpbmcgZXZlbnRzLg0KPiA+PiAgIMKgwqDCoMKgwqDC
oMKgwqAgKi8NCj4gPj4gLcKgwqDCoMKgwqDCoCBpZiAoZXZ0LT5mbGFncyAmIERXQzNfRVZFTlRf
UEVORElORykNCj4gPj4gK8KgwqDCoMKgwqDCoCBpZiAoZXZ0LT5mbGFncyAmIERXQzNfRVZFTlRf
UEVORElORykgew0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWV2dC0+
Y291bnQpIHsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHUzMiByZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HRVZOVFNJWigwKSk7DQo+
ID4+ICsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmICghKHJlZyAmIERXQzNfR0VWTlRTSVpfSU5UTUFTSykpDQo+ID4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXZ0LT5mbGFn
cyAmPSB+RFdDM19FVkVOVF9QRU5ESU5HOw0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9DQo+ID4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBJUlFf
SEFORExFRDsNCj4gPj4gK8KgwqDCoMKgwqDCoCB9DQo+ID4+DQo+ID4+DQo+ID4gSSBkb24ndCB3
YW50IHRoZSBib3R0b20taGFsZiB0byBiZSBzY2hlZHVsZWQgaW4gdGhlIGJlZ2lubmluZyBhcyBp
dCBtYXkNCj4gPiBjb21lIGJlZm9yZSB0aGUgY2xlYW51cCBpbiBkd2MzX2V2ZW50X2J1ZmZlcnNf
c2V0dXAoKS4NCj4gWW91IG1lYW4gdGhlIGFib3ZlIGNoYW5nZXMgZm9yIGNsZWFyaW5nIERXQzNf
RVZFTlRfUEVORElOR25vdCByZXF1aXJlZCANCj4gYXMgeW91IGdpdmVuIG5ldyBjaGFuZ2Ugd2ls
bCBwcmV2ZW50IHNldHRpbmcgb2YgRFdDM19FVkVOVF9QRU5ESU5HIA0KPiBiZWZvcmUgZHdjM19l
dmVudF9idWZmZXJzX3NldHVwKCkuDQoNClllcy4NCg0KPiBCdXQgSSBkb250IHNlZSBhbnkgaGFy
bSBpbiBhYm92ZSBjb2RlIGNoYW5nZXMgZm9yIGNsZWFyaW5nIA0KPiBEV0MzX0VWRU5UX1BFTkRJ
TkcgaWYgaXQgYWxyZWFkeSBzZXQgd2l0aCBldnQtPmNvdW50PTAuDQoNCllvdSBjYW4gYWRkIGl0
IHRoZXJlLCBidXQgZG8gd2UgbmVlZCB0byBpZiB3ZSBjYW4gc29sdmUgdGhlIGFjdHVhbA0KaXNz
dWU/DQoNCkknbSBpbnRlcmVzdGVkIGluIGNvbmZpcm1pbmcgbXkgc3VzcGljdGlvbiBvZiB3aGF0
J3MgcmVhbGx5IGNhdXNpbmcgdGhlDQpEV0MzX0VWRU5UX1BFTkRJTkcgdG8gYmUgc2V0IGhlcmUu
IFRoZSBjb2RlIGxvZ2ljIHdvdWxkIGJlIGNsZWFyZXINCnJhdGhlciB0aGFuIG1hc2tpbmcgdGhl
IGJlaGF2aW9yIGJ5IGRlcGVuZGluZyBvbiB0aGUgcmVzZXQgYnkgdGhlDQpkd2MzX2V2ZW50X2J1
ZmZlcnNfc2V0dXAoKS4gVGhlIHJ1bnRpbWUgcmVzdW1lIGRvZXNuJ3Qgc2hhcmUgdGhlIHNhbWUN
CmxvY2tpbmcgbWVjaGFuaXNtIGFzIHdoZW4gcHJvY2Vzc2luZyBhbiBldmVudC4gV2hpbGUgaXQg
bWF5IGJlIHVubGlrZWx5LA0KSSBkb24ndCB3YW50IHRoZSBib3R0b20taGFsZiB0aHJlYWQgdG8g
aGFuZGxlIHN0YWxlIGV2ZW50IG9yIHJhY2Ugd2l0aA0KdGhlIHJ1bnRpbWUgcmVzdW1lLg0KDQo+
IA0KPiBBbnl3YXkgSSB3aWxsIHRyeSB0aGUgeW91ciBuZXcgcHJvcG9zZWQgY2hhbmdlcyBhbG9u
ZSBvbiBvdXIgdGVzdGluZyANCj4gc2V0dXAgYW5kIHdpbGwgdXBkYXRlIHRoZSBzdGF0dXMsDQo+
IA0KDQpUaGFua3MsDQpUaGluaA==

