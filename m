Return-Path: <linux-kernel+bounces-512135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659DCA3349C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF5E3A6261
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EC8139579;
	Thu, 13 Feb 2025 01:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kG+YFCs2";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UY45KumO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="i2XFRxeZ"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B61278F26;
	Thu, 13 Feb 2025 01:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409979; cv=fail; b=WLx2IaR2Rt72sk1LN144UbCQG03HSgPhsW+Jt/pXHSWsuE2+jJiGddgrjIPuoYj1r8SnYdDcxJWKDrferdcvKU3a9PUZ+0xxsATWK2AS307IHqUb4/KBLnj9kqmUD0zvp8yVwVBkPc6rh5L+ss9TC+LJhvewdUt04uwPKqcAPc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409979; c=relaxed/simple;
	bh=wmoxWVITsb8EwVBu3dyLdZsNbUT5NRCizc1/z14l8jw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M1tv3BI0n0P2Nrqi3KJlFvoSLUrVsL0FUJE2GhrPDhqNGcbLp6qHUF2dGKXD3VkGRGNs9WNsb21UcfRAUqTDatV/HUqYNUnEG8iXX4mXc6mTmKvANiydo29spXXaKASU6kikVPXzYQJuCg3kmmXLNKoIJ11Vx8lANhNEkpQovs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kG+YFCs2; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UY45KumO; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=i2XFRxeZ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D104hU027168;
	Wed, 12 Feb 2025 17:26:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=wmoxWVITsb8EwVBu3dyLdZsNbUT5NRCizc1/z14l8jw=; b=
	kG+YFCs2MneI12tXx4oAMSDyN9A3RUu4+HerRSchnsULG9II8g28ihQKDBpJAKRa
	t50a/Tw3GNaP0AEJPANW4Pw6pA+fyZqNKM9RyV85d153i3Oy40FzGgETajb16QD8
	oK7DsWoU+K4eupDUV24/Lp6sk/7NpLW9PYXP8F15j/QHqt3sLkamAD+Z6FM9+HWQ
	1ymJWi09DUM0MNoUoFrHv4VhBTT+sUkAQDqoJQHTrO2bm2lXeem2MDCfVSmmtITJ
	mU1x7QqJk6PRan6yVQ1zZv31kOwldv57w5o7kcz0MTuoKC5jTqnXzzDXJIpDlWke
	krjlSvKeDMNbCJoPaJ1Drg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 44p75tg5a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 17:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1739409959; bh=wmoxWVITsb8EwVBu3dyLdZsNbUT5NRCizc1/z14l8jw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=UY45KumO596eIhNmwuQ2Wyi7Tkcsp7UgtD1sWcABnzQF4L8hs25QzMvSxzVjfIIFH
	 DW5NhoM7bdVie6HfcbcrxHV9ptstmRogOsdUgIuUBLch05kceLmjSWeKt2+OlrsRvQ
	 /QXxxhQoFV/52FbXfDtRdirOn8NPH4aSOt+XPbz2adxRI/X9Nh2AvrmVe2mT1QdEn+
	 9luhmge1u/2Yr7w8Vl7Y8yJPRtpv5VqOIrRiQfYsZ69GPO+w1+r0bkGGvd/HTYxfKv
	 IIlgi0eppqt4Fomjb+xg9Zd2g1cuq2kBVG3hitqLrGt2k9+y3M89iZ6bzIJTO/1DQL
	 lARzs/ZXwjsQg==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AA21640175;
	Thu, 13 Feb 2025 01:25:59 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 662BFA0077;
	Thu, 13 Feb 2025 01:25:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=i2XFRxeZ;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0A307401E3;
	Thu, 13 Feb 2025 01:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcL0G7Zmyho4bItbineXZkx8wVQg268kYJEGpsvdryNa5ImatvoDbFpSGLLyui0Cdf4uP8PMcVd02IL2TwpJYxjbXMtqQ2ntrlcggnn3PqzH6rz6cLRRFMuZPCMH8XEJ1oksqlrxqNxPvejuWSW854Moy3ThCKb8sqmza+kJmZJOpCkIvXFtW6RTEmAn0mEn13pzm/UTJyz6pA2xvKgZTyzIQPi5mYbmNeAnlSLI4kKCXixlZiM6lFmgOdUnU0ScM+p3z1fd6zpofTaiGtT3F95x5zeKhO3JK48kiPdyGlWx6FjqYdfAxKZODSrT1gPqPfFLENZBHlWiehcpGrVuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmoxWVITsb8EwVBu3dyLdZsNbUT5NRCizc1/z14l8jw=;
 b=gQsCNC8LTXYST7hzA7GSUNnp0tKO9diJK7bm/5ubrYgJIpoqhEACAKpp0hLRKmWPxKezGhXx999Zzz9qQ3diEgQ+VMqtg93ekgoEJ9KGM9HRVE6JYRrjDY8ETL5ctqR/kCf2o3nv9l6ySYMNTfGjB0Owauz37lwhOLJ0OJIcmDLKSKc9pW62kaJB1VbM1p542gJcW1TLcQ0gadO55Hk4Z4SewI//AwN10am6EpKqO8lOXaZZn26YbnOHxj1IuM2t3F0v2PEB4pirFc4HHykMiVfN5Ng04C9rPCsSdvy3eL8bV9XeHrYKGvtH4I/lks4bgpAy/TZgDMk+k8+AMfUFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmoxWVITsb8EwVBu3dyLdZsNbUT5NRCizc1/z14l8jw=;
 b=i2XFRxeZ8Txn034uDCpBO4RvyHSIlbnGsr1rAnxPQCgxT8Cx4wZaD4rA98c5DZvPfe+XW3JPnG3plrWJI1T2hVPku7D/ldNIANNiIMsc40yIANrEH0ACr45LZ+Wi3EWJEzE65dBnFQZnWNEC+Yt+W5kLSUK3i96+gFU0yVSBzAU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 01:25:56 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 01:25:56 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v3 2/4] usb: dwc3: gadget: Refactor loop to avoid NULL
 endpoints
Thread-Topic: [PATCH v3 2/4] usb: dwc3: gadget: Refactor loop to avoid NULL
 endpoints
Thread-Index: AQHbfYS3K8PfvhPH8k2UvUooTpCyJLNEcWcA
Date: Thu, 13 Feb 2025 01:25:56 +0000
Message-ID: <20250213012552.krl2yo2o5wsjxjmj@synopsys.com>
References: <20250212193116.2487289-1-andriy.shevchenko@linux.intel.com>
 <20250212193116.2487289-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250212193116.2487289-3-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB8402:EE_
x-ms-office365-filtering-correlation-id: aad7c646-3263-41e8-8b5e-08dd4bcd5d61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0gyQXZsVlp4WUJUOVRnWjgzZ3lwOThqZm52eGQ4M2F2Qi9jN0ttb0Fkenp5?=
 =?utf-8?B?cTJEU255TnYzaWVaaHFXN2hOZGozcXdxNklRSUs2cG5ReFVrVkdoSjQ5a1RD?=
 =?utf-8?B?bUF3bU1iWWp5Ly9sZFhJekhHaDdQcWJ0ODQ4eW5NdUJlK3BaNDhpalRBS09B?=
 =?utf-8?B?Z2JiaXp4MTltZm5MZitvdHRWODBVcWhQbnZncVZXam0xQndiZXhPeWxqMGUr?=
 =?utf-8?B?Q1FOTGZFVUh4NVk0T0tYeG1rcktJQ1JvS3ZkVm5nbDR3SFcwMUNqTTVEeHlC?=
 =?utf-8?B?R2NlZVJTVElKWVBScDUvVVJQeWlONXd1QWpuTVFOTmRiU2k2WGt2MWEyOS9M?=
 =?utf-8?B?R0d1ck8yK0hwbG9PeWd2VFZvbm05Q2h0TDFiMVBPdUR0RmtSMlNMVnNhTXFi?=
 =?utf-8?B?NGcvRldFRFZFZW0wS1JIODRocEpqMy9lYVVOalJMYjhTSDl6UmlaSFBmTCtD?=
 =?utf-8?B?Y3dxMUpEd2Z5UkhmK0kyT01DRE1rQTF2MDlNenpFNlc0c3dIcVYwSzhENHVi?=
 =?utf-8?B?eGp4Z2t5Rng4blZUTkJqcjd4dlpySzJpd1BWZEZLNEFxK0x5UEs2emVnemVH?=
 =?utf-8?B?NEJZdk1IYU1lR05SSFBxMk56aUdvUFlLRHVVOFpocHNaTUY4YTNlTXV5VCtZ?=
 =?utf-8?B?OUg3a0RBTzUrOHc2eXE5MU9DM0l1dmp1VnZFQUx3NWJaOStybE4yMmZYd3Zy?=
 =?utf-8?B?VlJZNVJJWnZLc25MaEJIRUhvNGFqSkMyeHV1L1lwZXRzTFdkOEpvQW1nS0Np?=
 =?utf-8?B?VHA4QlFhQUxWSGhzUXFzQXQ0REQ4TklEdmZsbnJGSi8vMGU4YXVzanVmZE1u?=
 =?utf-8?B?ZkZmUnB1VTB3LzdTc0QrN1VFOXg2ampYa2ZFMEptVDRtTzJtbDhVdVhZWFcr?=
 =?utf-8?B?SkFwblE0bEptMTJoWXl0Y1ltZWZUMTFvcTBZZEJnTVdkREx4WThoSk9DMzB5?=
 =?utf-8?B?bXlKcWdrTEV4R2lVQWtzdHBMWG55SGcyWTZyb2RUeXArc2JOcnpNeU5HeE1F?=
 =?utf-8?B?c2xqaFFCL2hYM3Z2UVFCeERGWlVGTGErTlBhWU1sQWNIZm5oZ2F3UzlXeHhI?=
 =?utf-8?B?dzZBeGxEYzMyS3VCVFBiWVRFUE95TUE1OGJBWU5xUGdaK3R2S2NJaFVJT3hH?=
 =?utf-8?B?WWRNRlV6MHRVaWlya2g1d0JNMTZER1R2R2hLNWVnQ001MjFiS0VwU0txUG90?=
 =?utf-8?B?MGU3MnZxOG1IelBCSzU1UFhhOFlkdUVoMWJIOE5TRmgwa1dLUmJTNmtRVjdm?=
 =?utf-8?B?SENPck9oWkpHcHRUN1lrN2tCSGlybFBGcUE4UTZZQmoyMHBLSU5BNzlkRkZF?=
 =?utf-8?B?MG8zMjY3Q1VBMDIzRlN5a3ZoMTU2OHlvRDFOdWQ4MlZXZWJuVWo2dGl1WVlC?=
 =?utf-8?B?SVVuWlBuWUkrTDFiUFkzQXQrK0p4WThkZm9vVHNubElIRWt3a0ZMRldDUnZP?=
 =?utf-8?B?aWtvYk83L1pxN2ZvbndIRlZ2bkxBSGViOE8zQUlYclhJOEVkR0lLWUVqWXFE?=
 =?utf-8?B?VDhzUERLblBKRTZiY1VIQUJVWnN3U2F3eTR3b3p5MUpZT1V1TkhUSkt5UGdq?=
 =?utf-8?B?RkQ2czRoaTJjSjI0VHBFU0dJaWNSQ04wY09USmw5eE5iZlJpSzJ5SFBOQlQ0?=
 =?utf-8?B?cVg2NjEzREZpcWVGeS8yZEE2ZnVIUklDL0EvR0VlREVwbEVNZCt3SFhJU3d0?=
 =?utf-8?B?dlhwcG1mVW1abFJCMW94aHpZSTZQNGxad2JZcG9JRW1zWEdqYktJejJKVmRT?=
 =?utf-8?B?NXZrTFVmZ1dlSmUvTmdyZG5ucWYvbzBET3l1QnRZUkVCZGhZeXlobG5ZbTFu?=
 =?utf-8?B?MTB0M1d6d0lZRjFWcFFkKzlVUU02VWEvaWJZSko2b2xGa050djVuclBQWnJi?=
 =?utf-8?B?cTFDZnZaZUppeVRyMUoxYkpSQkJSa1pkRllEeGRvaTRiWUw3d2QxRmRDSUlN?=
 =?utf-8?Q?EUmpMwRBMqhSDzupTtLac5F5DNhcFr2r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGcyVzV2RGkrZjI0QTJXcjJ2T2xFUS9sek5xdUpNZ0Vubk9FYVZpYUVId3Rm?=
 =?utf-8?B?NVN4TVJRSWVpdVZEdXFwMDJnTXVZSGJrSnB1TUNtSW9ZK1RxK0pjQWVMeGpJ?=
 =?utf-8?B?N1cwWTJ4bHQ4aUMxTUNBaFhZUzljVTRoY29NN0Y5Z3FoQWl0b2Q3QWd1Zi9U?=
 =?utf-8?B?V2NhaGVqcFZoZkhibDlXMXh5U1ZoL2VWWlFLV2hqemQ0V3l3MmVBdFN3d0JL?=
 =?utf-8?B?L3FuQmV2QlBCZnhXdVNJNVA1OU1NOUF5VzgrQWhwakI5UXBVNDM1NHQxV3BM?=
 =?utf-8?B?NW1vYzlzOHlEcHpsV2xSVVJrbDRGQnNFTXJKamlKdktqVmc2Wi9wT3daSjZk?=
 =?utf-8?B?NU43M2hlenR5UjE2M0JmamdRZms4LzAyays4RHBsbVgxWGxIZ3hHU2ZOTWI3?=
 =?utf-8?B?Umx1eDNwWWw4NWFJT2hoZGUydlNWY3RDQ1E2WG83bDV6RFZSdGxySEwvb1ZY?=
 =?utf-8?B?amxhbW5Fa1FJeU5OVXRxM0tuaW5uZUNaTHBRL3lhTVE3MVV4clE3bHdJSGs4?=
 =?utf-8?B?L3p4TzVnemZLdzNQT1dIQTZML0YrWFM4ejFRN0s4L2NhcUdvNForbDJpNFc4?=
 =?utf-8?B?T3hqd01wSFVCSnc2Z21rcHV1eEhBZ0JoKzhQR2Y0eVB5NUpXTi9wQmpTVVAv?=
 =?utf-8?B?UWNEUmRmaVgxNVVCbW4zTkQ0elBjblpmQjV2M294aFlLWW1tNXU2Z0I3SXZ3?=
 =?utf-8?B?c0xySlA0NTFTSDl5TlNWK0pvaXNXMVQ2ejFyczBUeVpqNDVSRVhvd1U4WmhT?=
 =?utf-8?B?Yk03SFk0ZWRxdWZVdUtXZEVsTzlna1VuWnZTZXdmTlRHcVhNdjRqUG1YZE1m?=
 =?utf-8?B?dDhUUmVyUEhZZnl6b2VDVFRzdUV5WVZ6eUpYeTlhU1gzTnRFeXhDem9lSUR6?=
 =?utf-8?B?ZUdzVDlYM21YUU9KbHVKbGMyaU1MT2M5VG9EK0FDaGpZdFhEM0xqakFSY0Iz?=
 =?utf-8?B?TUZNZVlvdmdCbHdMWE5SZWQ0dTd3NmtkM2tpUnhSSGpzdFhmSlh4ZHZLSVBQ?=
 =?utf-8?B?bUw5MnpuNkxxQWFsaGUwMWw5SThiQlFHeWM5WXA1UlJYSUhtY1JlR29meWRX?=
 =?utf-8?B?WU9Kckd3L1RWYk5sMDhqZC9GUi8vbElMZUtzbXlEbWVoTEZpc1Z1ZGVKZko3?=
 =?utf-8?B?Z21ZazFBK1NadzY4cVVuZUdBb0F3QlNUZEhYSmFYQi9IUmdTN3JoZEtvbDdH?=
 =?utf-8?B?bFhLdE94MlVadGVNYkFpcEM3cEdyYzFkR0tuRmx6U2xTWlhsMTVsU3FUMmJm?=
 =?utf-8?B?OGlvTFE4R1p1TFo0M0YxTDFySzRLcDJ0Z2lxK2pHdEtwck85S2ZCK2MrKzM2?=
 =?utf-8?B?djFqZGpoS09jSFMxa1ZjSHN4THJpRWhCSGFIaUN2RmdMRUQrUlhDQjE2MkJ3?=
 =?utf-8?B?NjVHZzNVTHp5a3lCOSsveGl0NDJwdHlUUEZDaGYzTWQ1K0FJVkRiYTRKRVUz?=
 =?utf-8?B?NW9KM2Jqams5c3RVN0xnZUFzYnZjSVl5TE4ySjFJbDByL2FIMXNsUjY1d25T?=
 =?utf-8?B?aVFsbE01RCtweDZNR3hvUHpmMDIyVmxYSjVFUkNFUkU5L2VHZ0pyNnZGOFpJ?=
 =?utf-8?B?em8zZXFrZkJUMGFSTnlTRWppZllneDBrTVE2MEVaUXBycldTNGYzZjRrcHpF?=
 =?utf-8?B?WVVRY0RINEhUeFBLMEJ1YzhvNDQ2bERtMlRWV2pXd1BzamJHLzZSZ05tQzZD?=
 =?utf-8?B?cFA4SDNtRnJIcUwxMDJHWm56eTVBbDZRNzl0dVJZRmNvbHB3b1lLcGQ5b0xP?=
 =?utf-8?B?dVNncHRKYUtrVGlFdFE3ZDZJK3dTVVNYOUt3Y0liOGZyVzlmQk9DeUJXQnFw?=
 =?utf-8?B?dG9DdnhKLzh1aDVadzNIVFkvRjQ1NHI4RDc4a3ppSUxoaDBwN0NveGkxYnh4?=
 =?utf-8?B?cjc3V0g5NXloeEpOWTBXTFhzVzZwQ3dLekxRWHF1NmRoTnJ1eW5ud3lOdkZ5?=
 =?utf-8?B?REF2ZTRpYml4RmFEZDlWdTkrOW1FWG9aM2k0SW96QnYwUGxEd1hzUzhFcC9k?=
 =?utf-8?B?OFBLaHMwV0ErTU56QjNIaEkrSHBCZGo5RWc5d0ZCYklWc3VnQTdyZlhrM0NS?=
 =?utf-8?B?M2hNU1RQNzN0ZmpXM0ZrNVJWNGdISXRCL0V2aEdQRzY0KzBOT2tDYmtoNVd4?=
 =?utf-8?Q?NuKAnpuLwq5NrdCOHbrpzP9T9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF663B1C58AF28438CF27AF0DC0C8C5A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5GjYzhWkn84Yhv8djndw5BxMoKo4yqn5oPYmfL+bXnQckOQ6aSkS6y+Xy64+wvYm6lwTHVwnd7WUHKMdqiCMGi6RBSlB0NYHajOM94AayRczWbjJrAXHGF9Cjx2cjEXwgLml0IKd/OnwslGQPquG+lMIFuXIDMCsRGQ7eQwMGDIPvWDmkpFzhkvD7LeDYF+x7cwbSCU1WkmXbkmDEPSzEqs4c/OrZIHnCQHby6po4ZnAVNSa6YRIYEFhLHVHA/IK0ELSkk+iQWLNxWnrXS2mclbuoNgOhFEHcmIkRRHrEfUDhytsJUSQ8Ws46/nD1Z/+bz+rzdSxYlMLKQHxPgESNdEDXJPcuaFweCYfZkzkYKhs7u/TbwfbzX9nS2pACwn1IL0u/3VFIniNOimAUiKaIAKQP78mHLjCVrKchtvY1wp30v2V5rpCCKgOLIvxoig1SwfbYUzS80zm6x2ZNVWp4wWKkAOKLYvU3IK9v6GFyXgBiL+bvcT2C7bvyuW3oLRa+mAPuUGvaYWypbVFZdte4Br2MLG25v4RH4PvU/69BtyV3Ki50VA4fTybGJ45L6MT0YuEluGH2fGaHqoc2XqaXoNKSthNOl0mjAtiJjY85AWP0GKWHZxoVB21GU4LojW43GmsBmrpI9p0a2uasnCiOA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad7c646-3263-41e8-8b5e-08dd4bcd5d61
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 01:25:56.3407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aST3KpF/pf+CHnYEZ2dAe8AXxz5obO6Iwj/Tl1lb2cNKuS+LlTonpGy1is9tK6wROah9pzUwtDp32AXariKd2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
X-Proofpoint-ORIG-GUID: aR_Vu9ba5vom_nFuFMWrtyrPG6Mt7fVr
X-Authority-Analysis: v=2.4 cv=NJEv+16g c=1 sm=1 tr=0 ts=67ad4a28 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=jIQo8A4GAAAA:8 a=A2vfRnhfoAeGkUpEi7sA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: aR_Vu9ba5vom_nFuFMWrtyrPG6Mt7fVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=954
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130007

T24gV2VkLCBGZWIgMTIsIDIwMjUsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gUHJlcGFyZSB0
aGUgZ2FkZ2V0IGRyaXZlciB0byBoYW5kbGUgdGhlIHJlc2VydmVkIGVuZHBvaW50cyB0aGF0IHdp
bGwgYmUNCj4gbm90IGFsbG9jYXRlZCBhdCB0aGUgaW5pdGlhbGlzYXRpb24gdGltZS4NCj4gDQo+
IFdoaWxlIGF0IGl0LCBhZGQgYSB3YXJuaW5nIHdoZXJlIHRoZSBOVUxMIGVuZHBvaW50IHNob3Vs
ZCBuZXZlciBoYXBwZW4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFu
ZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gVGVzdGVkLWJ5OiBGZXJyeSBUb3Ro
IDxmbnRvdGhAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMg
fCAyMiArKysrKysrKysrKysrKysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCBkMjdhZjY1
ZWIwOGEuLjczY2ViYjdkOTBjMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC01NDcsNiArNTQ3
LDcgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9zZXRfeGZlcl9yZXNvdXJjZShzdHJ1Y3QgZHdj
M19lcCAqZGVwKQ0KPiAgaW50IGR3YzNfZ2FkZ2V0X3N0YXJ0X2NvbmZpZyhzdHJ1Y3QgZHdjMyAq
ZHdjLCB1bnNpZ25lZCBpbnQgcmVzb3VyY2VfaW5kZXgpDQo+ICB7DQo+ICAJc3RydWN0IGR3YzNf
Z2FkZ2V0X2VwX2NtZF9wYXJhbXMgcGFyYW1zOw0KPiArCXN0cnVjdCBkd2MzX2VwCQkqZGVwOw0K
PiAgCXUzMgkJCWNtZDsNCj4gIAlpbnQJCQlpOw0KPiAgCWludAkJCXJldDsNCj4gQEAgLTU2Myw4
ICs1NjQsMTMgQEAgaW50IGR3YzNfZ2FkZ2V0X3N0YXJ0X2NvbmZpZyhzdHJ1Y3QgZHdjMyAqZHdj
LCB1bnNpZ25lZCBpbnQgcmVzb3VyY2VfaW5kZXgpDQo+ICAJCXJldHVybiByZXQ7DQo+ICANCj4g
IAkvKiBSZXNldCByZXNvdXJjZSBhbGxvY2F0aW9uIGZsYWdzICovDQo+IC0JZm9yIChpID0gcmVz
b3VyY2VfaW5kZXg7IGkgPCBkd2MtPm51bV9lcHMgJiYgZHdjLT5lcHNbaV07IGkrKykNCj4gLQkJ
ZHdjLT5lcHNbaV0tPmZsYWdzICY9IH5EV0MzX0VQX1JFU09VUkNFX0FMTE9DQVRFRDsNCj4gKwlm
b3IgKGkgPSByZXNvdXJjZV9pbmRleDsgaSA8IGR3Yy0+bnVtX2VwczsgaSsrKSB7DQo+ICsJCWRl
cCA9IGR3Yy0+ZXBzW2ldOw0KPiArCQlpZiAoIWRlcCkNCj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+
ICsJCWRlcC0+ZmxhZ3MgJj0gfkRXQzNfRVBfUkVTT1VSQ0VfQUxMT0NBVEVEOw0KPiArCX0NCj4g
IA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiBAQCAtNzUxLDkgKzc1NywxMSBAQCB2b2lkIGR3YzNf
Z2FkZ2V0X2NsZWFyX3R4X2ZpZm9zKHN0cnVjdCBkd2MzICpkd2MpDQo+ICANCj4gIAlkd2MtPmxh
c3RfZmlmb19kZXB0aCA9IGZpZm9fZGVwdGg7DQo+ICAJLyogQ2xlYXIgZXhpc3RpbmcgVFhGSUZP
IGZvciBhbGwgSU4gZXBzIGV4Y2VwdCBlcDAgKi8NCj4gLQlmb3IgKG51bSA9IDM7IG51bSA8IG1p
bl90KGludCwgZHdjLT5udW1fZXBzLCBEV0MzX0VORFBPSU5UU19OVU0pOw0KPiAtCSAgICAgbnVt
ICs9IDIpIHsNCj4gKwlmb3IgKG51bSA9IDM7IG51bSA8IG1pbl90KGludCwgZHdjLT5udW1fZXBz
LCBEV0MzX0VORFBPSU5UU19OVU0pOyBudW0gKz0gMikgew0KPiAgCQlkZXAgPSBkd2MtPmVwc1tu
dW1dOw0KPiArCQlpZiAoIWRlcCkNCj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+ICAJCS8qIERvbid0
IGNoYW5nZSBUWEZSQU1OVU0gb24gdXNiMzEgdmVyc2lvbiAqLw0KPiAgCQlzaXplID0gRFdDM19J
UF9JUyhEV0MzKSA/IDAgOg0KPiAgCQkJZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1RYRklG
T1NJWihudW0gPj4gMSkpICYNCj4gQEAgLTM2NjksNiArMzY3Nyw4IEBAIHN0YXRpYyBib29sIGR3
YzNfZ2FkZ2V0X2VuZHBvaW50X3RyYnNfY29tcGxldGUoc3RydWN0IGR3YzNfZXAgKmRlcCwNCj4g
IA0KPiAgCQlmb3IgKGkgPSAwOyBpIDwgRFdDM19FTkRQT0lOVFNfTlVNOyBpKyspIHsNCj4gIAkJ
CWRlcCA9IGR3Yy0+ZXBzW2ldOw0KPiArCQkJaWYgKCFkZXApDQo+ICsJCQkJY29udGludWU7DQo+
ICANCj4gIAkJCWlmICghKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0VOQUJMRUQpKQ0KPiAgCQkJCWNv
bnRpbnVlOw0KPiBAQCAtMzgxOCw2ICszODI4LDEwIEBAIHN0YXRpYyB2b2lkIGR3YzNfZW5kcG9p
bnRfaW50ZXJydXB0KHN0cnVjdCBkd2MzICpkd2MsDQo+ICAJdTgJCQllcG51bSA9IGV2ZW50LT5l
bmRwb2ludF9udW1iZXI7DQo+ICANCj4gIAlkZXAgPSBkd2MtPmVwc1tlcG51bV07DQo+ICsJaWYg
KCFkZXApIHsNCj4gKwkJZGV2X3dhcm4oZHdjLT5kZXYsICJzcHVyaW91cyBldmVudCwgZW5kcG9p
bnQgJXUgaXMgbm90IGFsbG9jYXRlZFxuIiwgZXBudW0pOw0KPiArCQlyZXR1cm47DQo+ICsJfQ0K
PiAgDQo+ICAJaWYgKCEoZGVwLT5mbGFncyAmIERXQzNfRVBfRU5BQkxFRCkpIHsNCj4gIAkJaWYg
KChlcG51bSA+IDEpICYmICEoZGVwLT5mbGFncyAmIERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRCkp
DQo+IC0tIA0KPiAyLjQ1LjEuMzAzNS5nMjc2ZTg4NmRiNzhiDQo+IA0KDQpBY2tlZC1ieTogVGhp
bmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

