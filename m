Return-Path: <linux-kernel+bounces-206849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9607E900EBB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 02:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF761C211EC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94758C1A;
	Sat,  8 Jun 2024 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UOiyEYT8";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="T+/EAzV+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FAPNa5X5"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B5228FA;
	Sat,  8 Jun 2024 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717805350; cv=fail; b=gQAftAhPwekeNrqGkb7B36XAPdVFIOw/HzMZ/amsIqFNaYAFXO9B0jsPUqIJlLjtObpNjwzfJhCkL+pKlAKTKMLzMGAjIyV52kmNayRsCh6p6/+0sRCMSm8SJzmZS4znZDrvyOZ4f/4OXxzXVdYR2Z4URT7Rw5gMbA57mezRDG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717805350; c=relaxed/simple;
	bh=hBST6JRrQD030Ys2ETWpm5HgVmHUTUlhOvI9lJFrggM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MkY+Ly8MwYt+THDcagFPVImeE/B5uSGJIPMr/11Ep9UnGu4qVjFwOvPCQmupAUmnCM83Pf/c9/sST9sKXU3d3kR0mMltAieZ+Y0bGe5qZ6/HROhSQ3+aSk2vb0LZamQUsjV8ihIC/ZqNZHoGoRAAVkdWDW6W9cOKv3nt6Ams1FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UOiyEYT8; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=T+/EAzV+; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FAPNa5X5 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457LacWK011373;
	Fri, 7 Jun 2024 17:08:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=hBST6JRrQD030Ys2ETWpm5HgVmHUTUlhOvI9lJFrggM=; b=
	UOiyEYT8iH4dVypaM3+GtGR7Zwl1TvJwMvrCTnnIynYM3qE5z1WgaPm4sL4XZGVC
	zl45JhVf81ulUsEU/aUyOLljwKSDYakquCoxqka/MjJEnHDl+cu7Lp0yQHPJ4qaA
	QMk2ChvC/6CNtBVOMNgpvglex5G5q8fZSrezr9b09BUe8WmhMwLsUr8wYOXgg5ds
	93WmtU/V3PQSY0QapZgrebXa+ZA5L1huyIn74PduaHTykDTfFV+/EQTDOmxJobul
	9feLLhYJdtw13c7rvCVjwaChyuhR6HK6UpSO238xofFqcu2hqr1Eyv6YzvvqwDnh
	PABhFJSVFOX/uSVBLj9loQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yg2w3njyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 17:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1717805336; bh=hBST6JRrQD030Ys2ETWpm5HgVmHUTUlhOvI9lJFrggM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=T+/EAzV++9HVue+Xp2N62Co+QOJC8iwlG899OVzeI8vA+OgAGvzUnVPjCvIokBciM
	 NRoeCdlK7bVvf17BiobYIYpq5mvasnVugskx/hIrsRc93NMWjiMJ9qOYX5/Ahn9C1t
	 byjOZFLYBgwKSQR7dNYTtB9x//ChnQjDQ8i37EM8nuZSNKa5L65oa2JhybMQRIIgiN
	 XtXZbaPKhc5ImOrtG6xQFCk4zIjb3gyDBKRoMBI9anVvgSqGFHCfvgIqr8ToarqjuS
	 cAWoNBX5ivqHBgMlI9qE/qvRs56N9NSllJDYnt5isB6bmEDftxoVwjrsdp6TCYvvnJ
	 wEMqDlk12SLVA==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C3CB340136;
	Sat,  8 Jun 2024 00:08:54 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 78F4CA007B;
	Sat,  8 Jun 2024 00:08:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=FAPNa5X5;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id BB0414011F;
	Sat,  8 Jun 2024 00:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzlXzCaqoUCSIYzNDo9HTEeaDM3SkjfqjKhsCNZrReFmo41NESYYvBEVJEED8lVgZa+WwmDCBtZFGTcEuZCMdXYlYmakCS2ktnUuU0B5MvwxiUtwdpRkA+Cl2ZkjwV1Xf87afP+OiTA+Xbdav666DMqaMzHVz59TRZb31LPcKCPtdW2uprcJ4lAtLCzwsXUhkILjIApGW+eVhQpHjdmZsd/3PEn2XC/F//6D6c/7IpbGy9HD5wIuHb7bu7xux7X1HWVwZCfXZtDoZBg5GhlFmLPNMOiCjy1u/qk6vYbzhMbwiChwPEUmzikM1iNU40CA1AtKuG0hDNGopuMk3t3kvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBST6JRrQD030Ys2ETWpm5HgVmHUTUlhOvI9lJFrggM=;
 b=oX2w/W4dl9lg7hRLct1jswB2VII6bIHlsOyQ5HWGMPUyHu8J0tUNl0FCKwGC2JwOiOFli9kBRrJ/pLq0Q0umZtczzlu7mVWVecMlzQQ2ucZ693pQtTbVpijac5NtYPRAr1HhpY/UJSHfy5vyFWE0XHxIgeQ9Dm/FcPeyVbLL+rwBWZi40vZBfdUiMZ0WytlxuxU8Qd+TW2BcR0j95BzJOgSPTWvwDim1ICx4VEkYmlYVgmz/qas8DOzpCqpYG10TFr6ynzJDX/iljqNfYPWXABSi+30HpgGF3nVXwa55a3uo4vfpo8SKlrKkPgQyYIygQrX2YsTo2W5Ioq8GUDDyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBST6JRrQD030Ys2ETWpm5HgVmHUTUlhOvI9lJFrggM=;
 b=FAPNa5X5vlDgFl/mJX2N76mgc70/tDMFSuItf/VPwZUOJ73oZC7IkkqRPsQJlkrM3RxHJVzBfchURf5QanSp0CQR6GzTeVuGLjapqj6V4u8O2r/ILH83QRT7XowE5siF0jVueNQ03sbhw0a4wjaNBbD8MmhAGraN/SGXqI/PUvM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Sat, 8 Jun
 2024 00:08:43 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7633.021; Sat, 8 Jun 2024
 00:08:36 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "git@amd.com" <git@amd.com>
Subject: Re: [PATCH v3] usb: dwc3: enable CCI support for AMD-xilinx DWC3
 controller
Thread-Topic: [PATCH v3] usb: dwc3: enable CCI support for AMD-xilinx DWC3
 controller
Thread-Index: AQHat99ljSVm/UWMYUGSocV5MsZNRLG9AEAA
Date: Sat, 8 Jun 2024 00:08:36 +0000
Message-ID: <20240608000832.globqeu3ca775vcv@synopsys.com>
References: <1717657279-2631757-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1717657279-2631757-1-git-send-email-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB6586:EE_
x-ms-office365-filtering-correlation-id: 890f0c24-ddb6-483a-b2ef-08dc874f2495
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?V1lycHFwOFpTNEJnb0VVUDBHM2xyLzBzT2c3SjRvUVFoNDcwb1BUVkxVdGta?=
 =?utf-8?B?TkJSTlN6TXR0ZFNuVkZyTGtEOUl5S1dDbm5KYmpFSEMxY2h0N2VuYWlwcG5P?=
 =?utf-8?B?cnI4emNVam01OXBrNm4vTHB3RmljQVNEY2JGTDRpbjdYb1REUGJOUFNSYldF?=
 =?utf-8?B?TEhpemk1bTF5bmRRaTlUdEdZTXYwWXhuVDRNMWdUV3J2ZURuTVBuc2NnaDhB?=
 =?utf-8?B?cTRsSC9UYlh1cEZ4dVM5OUkzd1drUm0rcDlOZTFFSytHdit3eFJBOWdPbWty?=
 =?utf-8?B?YXdWRzJMNnQ2TFpxN1VqZjU0ZDBORTlsTmxTWExyK2ZuMTJFZDdiaC9zanpW?=
 =?utf-8?B?THB1SitQYmtodnNsYXhtWXp1QjdLMUladUtEQWlTcTVTRnlxbGt1V1htbEFF?=
 =?utf-8?B?VUJZWWlxc1FtZ2xJenlOVTNDd2xjeUFYZmxGT1dZMXhLalNtb1Y1Vy8yd1dz?=
 =?utf-8?B?NiswL1d1ZTJUWGpFVTMzb1BiRGd1N2FmbHg2a0hVNnNHWGJwclB3aTdjcHBa?=
 =?utf-8?B?T1Y3ekhzblpmNXhsVzg0UVUzOS9BUi9xdDF6WVVxQzFvNEFDbFhWT0pjNDRH?=
 =?utf-8?B?UzY1V2NxeTFXWGpJZjNFTERzNCtLMzAyOTlXUy9VOVJNNWFsaHhvS0F2a0RY?=
 =?utf-8?B?ZkxkdTJ3K01hMEdUYXdQTlEvWk9BNitHL3dCalZwZmtoRXVNWC9veHA5QWR5?=
 =?utf-8?B?SWVWWW1uTXhpSGRKRXY5K3lrdk0yTEhDN1ZwT3JHNWZkSTFPOUtNdW5Fbk9w?=
 =?utf-8?B?Y3RRekY1bWZFRTB5cVZwOUg4RTBNVUNjZEpVcUlQMWg5b1F5WHE2NVc0ZW5Y?=
 =?utf-8?B?c3RmbTk1WTQ4azVFOFJIdndnQVk0R0YvR2VzM1FMTVJ5b1Zuc1R1ZFlWcElB?=
 =?utf-8?B?cmE1TUFieS9uZFRGc1JORkhpUG5XU3gyN2RSVEI2akhoT1VHcU54aXRkSWV4?=
 =?utf-8?B?aGNFbTZZYW9oMXBDbW5IaWVqbG9FeU9RWDBTWmhhcFNOVm9JaXFLTWxPMElk?=
 =?utf-8?B?RGVmYXFKalZ0U3MwclBOcmtGN3pGenEzbFF6L2VLaGlDd0g1TjlrUkRJMFhJ?=
 =?utf-8?B?SVRKaTJPYTZJcVlWN05oeUpnM1hITW5KeUxwU0N5KzNOVVZrWWxnazJXUDJB?=
 =?utf-8?B?UnMvejJlT1dYUUlLT2R1all6RXA3WFEwbUxQSlROQWZEalZxRWdSaHlEQjF2?=
 =?utf-8?B?elNOR3YyUS9GYm54ZUlpajZhbndLbUpxSVUycndhZkluUmR3cG1pMjc1dGgx?=
 =?utf-8?B?aHRSc0dyUnBTNGgvM09RWWJRcDVla3BvNjJOTExpaUtjd0g4N0lXTkV0NldB?=
 =?utf-8?B?YjJuSWY5ZEJqWjNDRndFOEh4Nm96dUtPb0FkbFZqTytOL2dUQ3BRQUtyOUFm?=
 =?utf-8?B?OVNWQjRrbjJKSnVkaGoyYS9PbENwaFBkU3lzcTRWa2hSRkVvdVdxcytQSkl2?=
 =?utf-8?B?SFd5bUdJZWRubTE0eitQejhoODR3MW5IQ0t1aFlTeGl0ZXJrV2lmUVJvNThp?=
 =?utf-8?B?TG5TTWZDWCs5bWxxMVhNUzc2SThOV05mbktOSHI1b0JlMzd3ZC9oakI1UEZz?=
 =?utf-8?B?bm4yOVpadTVINUhVcWZ2enNLVUdKV0ZzSFZwd1BScG9hN1FRSnhVQklsTnZL?=
 =?utf-8?B?dkNXUmZQVFpVYVQvYlBiYmM3K0ZFcTgvUmlVSGlZSXNOL1BKajVoT3IyaDky?=
 =?utf-8?B?eG5hcVVPbUZ2c2Z0NlJYUUVsNzBMMFYvMjhOMFc4ODh1WDc0Zk5BUUt4SEpM?=
 =?utf-8?B?dmFPbmlGUW40bGIzU3Q1aUFJNWorOVc2SnFZa1ZES3dYWXUzSU5EWkpQdzdN?=
 =?utf-8?Q?y1vPC8HP8RO94UaXU1ozk6ION72+lnxfm3I0M=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S0ZPTjhwa1BUSFQzNHVPVjRyZU44Z3pUMW1SaXYzWkRCWEphZm5tZEdITzkx?=
 =?utf-8?B?bEhOanVPdnAreUlLcFVnMC8wZ3ptc3ltVVNIcTBJcUhYVGVvSmcrRTZSREpP?=
 =?utf-8?B?QjI0cHMyclhQckZ4OWwxTG8yc3JWd3pCUlN6Uk9tblRVUkljVVRvbFNvMjJx?=
 =?utf-8?B?eU1GTVRvOHRldVdieE53RU1JSXFVTXB4SzIxWHNTMkxMRTdDNklaWnBuQ1dY?=
 =?utf-8?B?dld1TjUrWGR0bUZkZGloUys5dFlibUpjOFNxc3BCcXEvdDBzK0RZT3Z1VDNH?=
 =?utf-8?B?ZExNR0JtaFRiVlJheDYrY2hQZ2RVUG1OVzA1L0w5TVN0QlE2bGJpdTVNejNs?=
 =?utf-8?B?K0hDYzVtT0ZXbm5ibnA2dXdPOXBGT0kwSC9qWGNGWStGcDMzN1AzRzBnR3N0?=
 =?utf-8?B?eXpJTnl2ODVDSFhtdnoxY0Q2UFdjQjUvWXlQajF3VEx6VUtmLzY4ZjlKZmFw?=
 =?utf-8?B?Smx0bXMwS0VaOTQ4M0QrY0pCRUFSYkdLU1QzZUlON09ZS3dkcU43UUU4cVJn?=
 =?utf-8?B?Q05HSUU3c2FaZUNkL0E4U0lzV0EvUTMzOTJmN3JzR3pUd2FwbTM3OWxHRGsz?=
 =?utf-8?B?dzJldEJZZHVBVUI1ODNPaTFpN0M5c3dleGVjcWE5UTFCeWZJSzI0Z3pCbzFO?=
 =?utf-8?B?aC8rMlkyTzUwY1owM1QvMXo2Y2kzT0dKcHFFWEFDVURUM2RPMzIwWmFoekVs?=
 =?utf-8?B?YmZxV1JnNUMzTkxHakJCQVlQb0dFK0ZSSmUzTkZLMGpLVzI0VWQrNVhBQUR3?=
 =?utf-8?B?WmNJODhDbDVqUWhzKzVjQW8vdkcvT0IrMWdjTU9nTFlGVlcwU3BQdnFRTG9L?=
 =?utf-8?B?TmVnSmY3bSticnFmM2pNUFNEZmZFMUN5VXFTZlZldkRVakZTTU1KbzZocHVw?=
 =?utf-8?B?Z2lkZlQyQnlUaUE0SFlBYk9GTVZWaEtPVnduRnZ1dmN1LzJxNThjR1gzS3lm?=
 =?utf-8?B?elhoRTNYSCs3RWQzTzdjdllsS2orcDc4dGUzWGY4TjZOTE1kTlBYb1laeGFx?=
 =?utf-8?B?TTBjRjVSWG8rZ0J2VVlOZkJUSDFOVlgwU2dkeGZSazUyWVUxbXEyay8xMDNx?=
 =?utf-8?B?c1JVSTJVdUpCZ0JhcjlPMDZzVCtOeEZNYWRlU2hkQkQ1NzdPdUUvOUxLY1dp?=
 =?utf-8?B?WmpaMllBaEQ0NWVwMldhZTlKREdyMFlOeWNiczRnd0doYXRVaDRWeEdJMmIz?=
 =?utf-8?B?Qm11R3Irc1poTHdzeC9yRDgwOGU5VWkyaXlGL09JWHlhbFlPVmlPelVMV0VP?=
 =?utf-8?B?YTBSdnFYMWdQTzJ2NS8vS3VzTklzWk9PS1AyVzFkTGwrcFFzUHVCcFpPQXBI?=
 =?utf-8?B?RTF2amwrRWl4cDN0MkNDWk9PZGVBZXV2eFhBRDRyMi90a3FOTVlIMjE0bmhp?=
 =?utf-8?B?WC9ERndhYXlnZHU0WUEvQUdNRjE3Z0doaWJoQ1Y5eG93dG9QcXh5UUJLTGVz?=
 =?utf-8?B?dFlCUWhBNXdPS2xBQ1lVQ0NGd3h3dExLNERzMy85Y2tWTHF0MzNSWmY5cjRl?=
 =?utf-8?B?Z25wZXE2UWlZTGhIU0k5OHhsbHBYdVc1N0pZWTFITzhUOEU3QzAvTVo4anVz?=
 =?utf-8?B?K0FLckxZS0hvSm9KVGlWc3VMTFJjT0dYbVNEVkZtSW1BcFpCU1I3SWlUS2Nh?=
 =?utf-8?B?b1RwYWlYYmxnNG00NTNkSWxDMEYwbkMwMWtiQ0lsL2U5cFlkd2liZzB5bnZv?=
 =?utf-8?B?eHVVNU5vdEZ3V0R2ZVZMRlRaY3o0OXIzMnl5aCtjME9sLzgxOWdCdWx4dGFs?=
 =?utf-8?B?bHgwSmcxSVJkMldtV1ROK1RweHN4RmE4c3praU1aS1R5ZEF4dVVieW1ENUpi?=
 =?utf-8?B?TmMxOEt1ZHdab2hBN1FzcUxUS0hkV0Yrc3BuSGgxNno3aytDeWVybnhnSG5V?=
 =?utf-8?B?UlJDV3BPMUtXRTRScEYyc3k0THdaajlFc3I4VUhIUDc1alJIWUpPckszOVh4?=
 =?utf-8?B?Z3dEemw1T3ZMU0ZwdEFmdlJKRG9NeGhvalFvbW1ZY0dVUkRXSkdSMHhyd2FO?=
 =?utf-8?B?UWhnanJPbWhDRTlWK1k0K3Z1MEN2dkZpWUx5N0E5bUZCckNBQm9ITXcwWFpO?=
 =?utf-8?B?WmZnaTBoWGdEbkROMWoyWnZLcjhObk5Fem5ObEdIWmoyV3FPaGZkcWlCWHJr?=
 =?utf-8?B?eDR5dzIvZmJZMXBmZ2U2UlNVaUNWSDFMbUEyUDRKRC9CMGEwTkJ6R0dVN1Yz?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E28FA8E83F73FF46B39DAB9548195843@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8CGF4HVb/uCXIEx8s0FrQdnjStgQGao1QeMSj6zBOPorS7p4oHeKGM1gPOjLkxyzHpJ8BKynGW2f+wXcUQzQMr3brjlUxtwziokIoItrIuk13F7lJYPodD8nt3sWVscsHrfBlqxjeeUv4g3jCPHlZbmwyEliarhcSFV+KZNgyi4AxcJ6yGhj7ZHhF2iZQpgClizd5Ntg39DbSepvmEcnp5mvNPLFlXlMfq0yK4NBzGBuX9S8xfhSyFQPO0dbn1jV0THs0x2lVHPW7mauVVOes40o4ACeOyN7E1BgY+XNgd+7A+KxfKOpMKuujeyeuj8Mxc6eXT49lWGFs02ZiuZpnUMnO+XpRRpECJgkCfL+DdyE57lkHpL9z1qM5lEXYpNkGjINIbAkOMLD/N1kSqW/PpKoLJNBtQOTnFYM2hZEZxJdfdFSkR9nU+dkT/4cg80JkNlqxUQRKLoiFcYfI3A8RGiKgObg5u/rQj6vVvNWdOt7opTrOwbfJg/DX+l05v0QU7yu2tXEXwPDAn3Con0NIN4j13y9IhsUrKrkd/vXpZrosSqgH2bWeYw8TTlbqxnGUutryVJ+qJWudZXObp6RlnnCgZeHDYd1gQijCXruTzmYyOzwPRV79ENejZgJC7dDVQR74M8mOg4C+TDkzVZRKw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890f0c24-ddb6-483a-b2ef-08dc874f2495
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2024 00:08:36.5188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYMmtXVYanx07KpshoWlI7/eHSeZn0GIMJwZA6RrmG34VJya2SL8L8+aqMfSoVtmJ9eO6G7CfkG4rqyecUWDkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586
X-Proofpoint-GUID: nanHyn4ed7jj2mODrSDmEuvqEREcSanw
X-Proofpoint-ORIG-GUID: nanHyn4ed7jj2mODrSDmEuvqEREcSanw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406070179

SGksDQoNCk9uIFRodSwgSnVuIDA2LCAyMDI0LCBSYWRoZXkgU2h5YW0gUGFuZGV5IHdyb3RlOg0K
PiBUaGUgR1NCVVNDRkcwIHJlZ2lzdGVyIGJpdHMgWzMxOjE2XSBhcmUgdXNlZCB0byBjb25maWd1
cmUgdGhlIGNhY2hlIHR5cGUNCj4gc2V0dGluZ3Mgb2YgdGhlIGRlc2NyaXB0b3IgYW5kIGRhdGEg
d3JpdGUvcmVhZCB0cmFuc2ZlcnMgKENhY2hlYWJsZSwNCj4gQnVmZmVyYWJsZS9Qb3N0ZWQpLiBX
aGVuIENDSSBpcyBlbmFibGVkIGluIHRoZSBkZXNpZ24sIERXQzMgY29yZSBHU0JVU0NGRzANCj4g
Y2FjaGUgYml0cyBtdXN0IGJlIHVwZGF0ZWQgdG8gc3VwcG9ydCBDQ0kgZW5hYmxlZCB0cmFuc2Zl
cnMgaW4gVVNCLg0KPiANCj4gVG8gcHJvZ3JhbSBHU0JVU0NGRzAgY2FjaGUgYml0cyBjcmVhdGUg
YSBzb2Z0d2FyZSBub2RlIHByb3BlcnR5DQo+IGluIEFNRC14aWxpbnggZHdjMyBnbHVlIGRyaXZl
ciBhbmQgcGFzcyBpdCB0byBkd2MzIGNvcmUuIFRoZSBjb3JlDQo+IHRoZW4gcmVhZHMgdGhpcyBw
cm9wZXJ0eSB2YWx1ZSBhbmQgY29uZmlndXJlcyBpdCBpbiBkd2MzX2NvcmVfaW5pdCgpDQo+IHNl
cXVlbmNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFkaGV5IFNoeWFtIFBhbmRleSA8cmFkaGV5
LnNoeWFtLnBhbmRleUBhbWQuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBmb3IgdjM6DQo+IEluIHYy
IHJldmlldyBhcyBzdWdnZXN0ZWQgYnkgVGhpbmggTmd1eWVuLCBzd2l0Y2ggdG8gc3dub2RlIGlt
cGxlbWVudGF0aW9uDQo+IGZvciBwYXNzaW5nIEdTQlVTQ0ZHMCBjYWNoZSBiaXRzIGZyb20gQU1E
LXhpbGlueCBkd2MzIGdsdWUgZHJpdmVyIHRvDQo+IGNvcmUgZHJpdmVyLg0KPiANCj4gQ2hhbmdl
cyBmb3IgdjI6DQo+IE1ha2UgR1NCVVNDRkcwIGNvbmZpZ3VyYXRpb24gc3BlY2lmaWMgdG8gQU1E
LXhpbGlueCBwbGF0Zm9ybS4NCj4gVGFrZW4gcmVmZXJlbmNlIGZyb20gZXhpc3RpbmcgY29tbWl0
IGVjNWViNDM4MTNhNCAoInVzYjogZHdjMzogY29yZToNCj4gYWRkIHN1cHBvcnQgZm9yIHJlYWx0
ZWsgU29DcyBjdXN0b20ncyBnbG9iYWwgcmVnaXN0ZXIgc3RhcnQgYWRkcmVzcyIpDQo+IA0KPiB2
MSBsaW5rOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjMxMDEzMDUzNDQ4LjExMDU2LTEtcGl5dXNoLm1laHRhQGFtZC5jb21fXzsh
IUE0RjJSOUdfcGchY09vV3htYWN4UGVZVkN4RGZnMy14bFFMaEttOE1JRWd3V3g0NWNMUWpnd1JX
QTRlNFF5WV9rR1ZWSG8ybV9kY1JicEJRRUZwQjlKc1lQNm56YXNLMkFJQXN5ZWZqUSQgDQo+IC0t
LQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgICAgICAgIHwgMjQgKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAgICAgICAgfCAgOCArKysrKysr
Kw0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jIHwgMTggKysrKysrKysrKysrKysr
KystDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jDQo+IGluZGV4IDdlZTYxYTg5NTIwYi4uMTU5ZDIxYjI1NjI5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYw0KPiBAQCAtMjMsNiArMjMsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+
DQo+ICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9v
Zi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gICNpbmNsdWRlIDxsaW51
eC9vZl9ncmFwaC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4NCj4gICNpbmNsdWRlIDxs
aW51eC9waW5jdHJsL2NvbnN1bWVyLmg+DQo+IEBAIC01OTksNiArNjAwLDE5IEBAIHN0YXRpYyB2
b2lkIGR3YzNfY2FjaGVfaHdwYXJhbXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJcGFybXMtPmh3
cGFyYW1zOSA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dIV1BBUkFNUzkpOw0KPiAgfQ0K
PiAgDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2NvbmZpZ19zb2NfYnVzKHN0cnVjdCBkd2MzICpkd2Mp
DQo+ICt7DQo+ICsJaWYgKG9mX2RtYV9pc19jb2hlcmVudChkd2MtPmRldi0+b2Zfbm9kZSkpIHsN
Cg0KVGhpcyBjYW4gYmUgYXBwbGljYWJsZSBvdXRzaWRlIG9mIG9mX25vZGUsIGRvIHdlIG5lZWQg
dGhpcyBpZiBjYXNlPw0KDQo+ICsJCXUzMiByZWc7DQo+ICsNCj4gKwkJcmVnID0gZHdjM19yZWFk
bChkd2MtPnJlZ3MsIERXQzNfR1NCVVNDRkcwKTsNCj4gKwkJcmVnICY9IH5EV0MzX0dTQlVTQ0ZH
MF9EQVRfREVTX1JEX1dSX1JFUUlORk9fTUFTSzsNCj4gKwkJcmVnIHw9IChkd2MtPmFjYWNoZV9k
YXRhX3JkX3dyX2luZm8gPDwNCg0KV2hhdCBpZiB0aGUgdXNlciBkb2Vzbid0IHNwZWNpZnkgdGhp
cyBwcm9wZXJ0eT8gV2Ugc2hvdWxkIG5vdA0KYXV0b21hdGljYWxseSB3cml0ZSAwIGJ5IGRlZmF1
bHQuDQoNCj4gKwkJCURXQzNfR1NCVVNDRkcwX0RBVF9ERVNfUkRfV1JfUkVRSU5GT19TSElGVCk7
DQo+ICsJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HU0JVU0NGRzAsIHJlZyk7DQo+ICsJ
fQ0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IGR3YzNfY29yZV91bHBpX2luaXQoc3RydWN0IGR3
YzMgKmR3YykNCj4gIHsNCj4gIAlpbnQgaW50ZjsNCj4gQEAgLTEzMjAsNiArMTMzNCw4IEBAIHN0
YXRpYyBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIA0KPiAgCWR3YzNf
c2V0X2luY3JfYnVyc3RfdHlwZShkd2MpOw0KPiAgDQo+ICsJZHdjM19jb25maWdfc29jX2J1cyhk
d2MpOw0KPiArDQo+ICAJcmV0ID0gZHdjM19waHlfcG93ZXJfb24oZHdjKTsNCj4gIAlpZiAocmV0
KQ0KPiAgCQlnb3RvIGVycl9leGl0X3BoeTsNCj4gQEAgLTE1NzQsNiArMTU5MCw3IEBAIHN0YXRp
YyB2b2lkIGR3YzNfZ2V0X3Byb3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIAl1OAkJCXR4
X21heF9idXJzdF9wcmQgPSAwOw0KPiAgCXU4CQkJdHhfZmlmb19yZXNpemVfbWF4X251bTsNCj4g
IAljb25zdCBjaGFyCQkqdXNiX3BzeV9uYW1lOw0KPiArCXN0cnVjdCBkZXZpY2UJCSp0bXBkZXY7
DQo+ICAJaW50CQkJcmV0Ow0KPiAgDQo+ICAJLyogZGVmYXVsdCB0byBoaWdoZXN0IHBvc3NpYmxl
IHRocmVzaG9sZCAqLw0KPiBAQCAtMTcxNiw2ICsxNzMzLDEzIEBAIHN0YXRpYyB2b2lkIGR3YzNf
Z2V0X3Byb3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlkd2MtPmRpc19zcGxpdF9xdWly
ayA9IGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LA0KPiAgCQkJCSJzbnBzLGRpcy1zcGxp
dC1xdWlyayIpOw0KPiAgDQo+ICsJLyogSXRlcmF0ZSBvdmVyIGFsbCBwYXJlbnQgbm9kZXMgZm9y
IGZpbmRpbmcgc3dub2RlIHByb3BlcnRpZXMgKi8NCj4gKwlmb3IgKHRtcGRldiA9IGR3Yy0+ZGV2
OyB0bXBkZXY7IHRtcGRldiA9IHRtcGRldi0+cGFyZW50KSB7DQo+ICsJCWRldmljZV9wcm9wZXJ0
eV9yZWFkX3UxNih0bXBkZXYsDQo+ICsJCQkJCSAic25wcyxhY2FjaGUtZGF0YS1yZC13ci1pbmZv
IiwNCj4gKwkJCQkJICAmZHdjLT5hY2FjaGVfZGF0YV9yZF93cl9pbmZvKTsNCj4gKwl9DQo+ICsN
Cg0KUGxlYXNlIHNwbGl0IHRoaXMgdG8gYSBzZXBhcmF0ZSBmdW5jdGlvbiBhbmQgbmFtZSBpdCBh
cw0KZHdjM19nZXRfc29mdHdhcmVfcHJvcGVydGllcygpLiBGb3Igbm93LCBqdXN0IHRoZSBuZXcg
cHJvcGVydHkgeW91DQpjcmVhdGUgaXMgZmluZS4gV2UgY2FuIGludHJvZHVjZSBuZXcgcGF0Y2hl
cyB0byBtb3ZlIGFsbCB0aGUgc29mdHdhcmUNCmRlZmluZWQgcHJvcGVydGllcyAoaWUuIG5vbiBB
QkkvRFMpIHRoZXJlIHN1Y2ggYXMgc3lzZGV2X2lzX3BhcmVudC4NCg0KPiAgCWR3Yy0+bHBtX255
ZXRfdGhyZXNob2xkID0gbHBtX255ZXRfdGhyZXNob2xkOw0KPiAgCWR3Yy0+dHhfZGVfZW1waGFz
aXMgPSB0eF9kZV9lbXBoYXNpczsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdj
My9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCAzNzgxYzczNmMxYTEu
LjU3YjNjYjczOTM1MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTE5NCw2ICsxOTQsMTAgQEANCj4g
ICNkZWZpbmUgRFdDM19HU0JVU0NGRzBfSU5DUkJSU1RFTkEJKDEgPDwgMCkgLyogdW5kZWZpbmVk
IGxlbmd0aCBlbmFibGUgKi8NCj4gICNkZWZpbmUgRFdDM19HU0JVU0NGRzBfSU5DUkJSU1RfTUFT
SwkweGZmDQo+ICANCj4gKy8qIEdsb2JhbCBTb0MgQnVzIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXI6
IEFIQi1wcm90L0FYSS1jYWNoZS9PQ1AtUmVxSW5mbyAqLw0KPiArI2RlZmluZSBEV0MzX0dTQlVT
Q0ZHMF9EQVRfREVTX1JEX1dSX1JFUUlORk9fTUFTSwlHRU5NQVNLKDMxLCAxNikNCg0KQ2FuIHdl
IHJlbmFtZSB0aGlzIHRvIERXQzNfR1NCVVNDRkcwX1JFUUlORk9fTUFTSw0KDQo+ICsjZGVmaW5l
IERXQzNfR1NCVVNDRkcwX0RBVF9ERVNfUkRfV1JfUkVRSU5GT19TSElGVAkxNg0KDQpXZSBkb24n
dCBuZWVkIGEgc2hpZnQgdmFsdWUuIEVpdGhlciBkZWZpbmUgRFdDM19HU0JVU0NGRzBfUkVRSU5G
TyhuKSBvcg0KdXNlIEZJRUxEX1BSRVAgYW5kIHRoZSBtYXNrLg0KDQo+ICsNCj4gIC8qIEdsb2Jh
bCBEZWJ1ZyBMU1AgTVVYIFNlbGVjdCAqLw0KPiAgI2RlZmluZSBEV0MzX0dEQkdMU1BNVVhfRU5E
QkMJCUJJVCgxNSkJLyogSG9zdCBvbmx5ICovDQo+ICAjZGVmaW5lIERXQzNfR0RCR0xTUE1VWF9I
T1NUU0VMRUNUKG4pCSgobikgJiAweDNmZmYpDQo+IEBAIC0xMTUzLDYgKzExNTcsOSBAQCBzdHJ1
Y3QgZHdjM19zY3JhdGNocGFkX2FycmF5IHsNCj4gICAqIEBudW1fZXBfcmVzaXplZDogY2Fycmll
cyB0aGUgY3VycmVudCBudW1iZXIgZW5kcG9pbnRzIHdoaWNoIGhhdmUgaGFkIGl0cyB0eA0KPiAg
ICoJCSAgICBmaWZvIHJlc2l6ZWQuDQo+ICAgKiBAZGVidWdfcm9vdDogcm9vdCBkZWJ1Z2ZzIGRp
cmVjdG9yeSBmb3IgdGhpcyBkZXZpY2UgdG8gcHV0IGl0cyBmaWxlcyBpbi4NCj4gKyAqIEBhY2Fj
aGVfZGF0YV9yZF93cl9pbmZvOiBzdG9yZSBHU0JVU0NGRzAuREFUUkRSRVFJTkZPLCBERVNSRFJF
UUlORk8sDQo+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgREFUV1JSRVFJTkZPLCBhbmQg
REVTV1JSRVFJTkZPIHZhbHVlIHBhc3NlZCBmcm9tDQo+ICsgKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgZ2x1ZSBkcml2ZXIuDQo+ICAgKi8NCj4gIHN0cnVjdCBkd2MzIHsNCj4gIAlzdHJ1Y3Qg
d29ya19zdHJ1Y3QJZHJkX3dvcms7DQo+IEBAIC0xMzgwLDYgKzEzODcsNyBAQCBzdHJ1Y3QgZHdj
MyB7DQo+ICAJaW50CQkJbGFzdF9maWZvX2RlcHRoOw0KPiAgCWludAkJCW51bV9lcF9yZXNpemVk
Ow0KPiAgCXN0cnVjdCBkZW50cnkJCSpkZWJ1Z19yb290Ow0KPiArCXUxNgkJCWFjYWNoZV9kYXRh
X3JkX3dyX2luZm87DQoNCklmIHdlIGRvIG5lZWQgdG8ga2VlcCB0aGlzIGZpZWxkIGFyb3VuZCwg
cGxlYXNlIGRlZmluZSB0aGUgZGVmYXVsdA0KZm9yIHVuc3BlY2lmaWVkIHZhbHVlLiBBbHNvIHJl
bmFtZSB0aGlzIHRvIGdzYnVzY2ZnMF9yZXFpbmZvLg0KDQo+ICB9Ow0KPiAgDQo+ICAjZGVmaW5l
IElOQ1JYX0JVUlNUX01PREUgMA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LXhpbGlueC5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jDQo+IGluZGV4IDYwOTVm
NGRlZTZjZS4uZjM3NTdiZmJkNjUwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3
YzMteGlsaW54LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jDQo+IEBA
IC00Nyw2ICs0NywxNSBAQCBzdHJ1Y3QgZHdjM194bG54IHsNCj4gIAlzdHJ1Y3QgcGh5CQkJKnVz
YjNfcGh5Ow0KPiAgfTsNCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBwcm9wZXJ0eV9lbnRy
eSBkd2MzX3hpbGlueF9wcm9wZXJ0aWVzW10gPSB7DQo+ICsJUFJPUEVSVFlfRU5UUllfVTE2KCJz
bnBzLGFjYWNoZS1kYXRhLXJkLXdyLWluZm8iLCAweGZmZmYpLA0KPiArCXt9LA0KPiArfTsNCj4g
Kw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBzb2Z0d2FyZV9ub2RlIGR3YzNfeGlsaW54X3N3bm9k
ZSA9IHsNCj4gKwkucHJvcGVydGllcyA9IGR3YzNfeGlsaW54X3Byb3BlcnRpZXMsDQo+ICt9Ow0K
PiArDQo+ICBzdGF0aWMgdm9pZCBkd2MzX3hsbnhfbWFza19waHlfcnN0KHN0cnVjdCBkd2MzX3hs
bnggKnByaXZfZGF0YSwgYm9vbCBtYXNrKQ0KPiAgew0KPiAgCXUzMiByZWc7DQo+IEBAIC0yODgs
MTAgKzI5NywxNCBAQCBzdGF0aWMgaW50IGR3YzNfeGxueF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiAgCWlmIChyZXQpDQo+ICAJCWdvdG8gZXJyX2Nsa19wdXQ7DQo+ICAN
Cj4gLQlyZXQgPSBvZl9wbGF0Zm9ybV9wb3B1bGF0ZShucCwgTlVMTCwgTlVMTCwgZGV2KTsNCj4g
KwlyZXQgPSBkZXZpY2VfYWRkX3NvZnR3YXJlX25vZGUoZGV2LCAmZHdjM194aWxpbnhfc3dub2Rl
KTsNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIGVycl9jbGtfcHV0Ow0KPiAgDQo+ICsJcmV0ID0g
b2ZfcGxhdGZvcm1fcG9wdWxhdGUobnAsIE5VTEwsIE5VTEwsIGRldik7DQo+ICsJaWYgKHJldCkN
Cj4gKwkJZ290byBlcnJfcmVtb3ZlX3N3bm9kZTsNCj4gKw0KPiAgCXBtX3J1bnRpbWVfc2V0X2Fj
dGl2ZShkZXYpOw0KPiAgCXJldCA9IGRldm1fcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4gIAlp
ZiAocmV0IDwgMCkNCj4gQEAgLTMwMyw2ICszMTYsOSBAQCBzdGF0aWMgaW50IGR3YzNfeGxueF9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgZXJyX3BtX3NldF9zdXNwZW5k
ZWQ6DQo+ICAJcG1fcnVudGltZV9zZXRfc3VzcGVuZGVkKGRldik7DQo+ICANCj4gK2Vycl9yZW1v
dmVfc3dub2RlOg0KPiArCWRldmljZV9yZW1vdmVfc29mdHdhcmVfbm9kZShkZXYpOw0KPiArDQo+
ICBlcnJfY2xrX3B1dDoNCj4gIAljbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZShwcml2X2RhdGEt
Pm51bV9jbG9ja3MsIHByaXZfZGF0YS0+Y2xrcyk7DQo+ICANCj4gLS0gDQo+IDIuMzQuMQ0KPiAN
Cg0KVGhhbmtzLA0KVGhpbmg=

