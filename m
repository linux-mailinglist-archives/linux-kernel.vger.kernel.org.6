Return-Path: <linux-kernel+bounces-317864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A11E96E4B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06561F22753
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4611A76B4;
	Thu,  5 Sep 2024 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aVwXY9PO";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RpWLaZI8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="U3hf14e9"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A86165F0E;
	Thu,  5 Sep 2024 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725570842; cv=fail; b=Xw8jatUvaxgHO3yxZA09Yh3yhqd5RAjB/L13CBJth9+zx56w95UD/v6qwELrK7bUcHQdeFbuUa3NeAl6calRjW41PQsVjx4/Fv0/CcUrUtZFnM2UxUH81GBwAtT/aRhmHXb3FF2xKENzIWe2dRJ5RstlozUwWr3hBBxgRPrSBz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725570842; c=relaxed/simple;
	bh=Pu0/EkOze9XhwZ4ks830okEJslseajBRbVHdlaje4IQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QdvNwogQy5aggUpqUTjU1XSVjmfMG+Wge5TmZZ9lN1TVfpsaDld7xm2DHre4hgLsAyVqZl3kBeVAYgwAHbhYLckpE/f2i0Mrp394cos7ro51r1ChyoPUeBwExGU9azPD0FL11nLNaiJCbPXO77qEjSRh+yPmeyCBkvptzF1J4xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=aVwXY9PO; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RpWLaZI8; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=U3hf14e9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485Kq7G2027171;
	Thu, 5 Sep 2024 14:13:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Pu0/EkOze9XhwZ4ks830okEJslseajBRbVHdlaje4IQ=; b=
	aVwXY9POXArnfa8AOancR9DL2mKbxglOiOYCw2M3Z4iOZjaiy6w9w2uePpjTl752
	GtdtX4amAQl0g93N897c81Vjfu+bRds1KbxhmqP1XSG3yc0Nzirz0FzEYr4kv1Z+
	Sp6Ke3bghvrVYO7q8rKNSndrfhJOgb7/YBaBTWPyuD7Pnnz/Dpxkjb33I4wAyK88
	858x+r/QUTTRZmyhyOVuS0d1WwU4u0YTS3EyNeVq6S29cXl3HOw0nKaAd0VUNXxq
	NTya/9cEDKaGCTm4sxrXf1AJPgcC4r74PgMQtmMOyg4sXweny6EVgeAE++nzGqh2
	doAwfPUbiAyngUX53hqkZA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41fj168nte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1725570834; bh=Pu0/EkOze9XhwZ4ks830okEJslseajBRbVHdlaje4IQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=RpWLaZI8owL2wqaDaVAhg61g4IZVjltSzypXoIBlRNQMSsVe3QZMU8oon1nT1mh4t
	 LNX5lRgQpEkoORbQOgOfm+KqGrzXDe3IUGHZHLi+4q89TcHZJloilDq9VJ53nE1UWq
	 o8NpLhl1YsLqJh14YIInCrMrCSZpZrWQ9Q7HCxHbJ9Y27vSMuWHpdqH0+LPoRGSTB/
	 VUphOlbDlxuwQKtWTiSnf26hluzJT34UMyAGAgFfzfD2IARxaDtNkmGCCRnCr5n5uT
	 DE64tZuLURUb3CvMBJQwj9a9XIgczmSaeo1CHgXoT1IXlCJEr3FgmJM0L5Mk82Rhk0
	 s3aIODPH+3j7A==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 00E6240340;
	Thu,  5 Sep 2024 21:13:53 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A2669A006B;
	Thu,  5 Sep 2024 21:13:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=U3hf14e9;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 91AA540132;
	Thu,  5 Sep 2024 21:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy5+OTb15ROuLyRe2jUnMkYFgJbrxQjBpWQvACwem8LRbNlwSWmSLFvUKQgj9mHw4nrCcxw21Xdi3QHZfQJJXdTcD6lPqpd3o52mM/n/hpnV02Pakc5eavwtjy0y4T05k6yqCFwRIEs8rNoXFOmB/e5zT7AYwAhPkJoHsH4mn1H847b0C7+8U2Dgb7js6G71X11lNCqz/GiaMlvZ1aC5BJG3FzV4zR0/S+2u9t4Y8DxdnlpaHlcyGz2aWXS+rRpt+ydDB2+a36jcl7ikTJnf8w92YtNfJX0UO7G9AB4qVM+VSlrt2sx3G+D22H1V6LSmvBXjvS3ZrhXQNOGzaL+QSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pu0/EkOze9XhwZ4ks830okEJslseajBRbVHdlaje4IQ=;
 b=ZSaLShnVnrj5jPZds9aaU3zOXyhP9PhQui0OqRaBwQjwx0f+80xZruHrB5dwDRHLLRdiLtGnqlBdgChxJ2nKBqYKZcMP6SzuDx2YlSk7yoji2TpJY+VWOZSNleVC95icV9I37xFwmZVdbCVC/VrSOqSvDXgevcdo7Psb04ApJCryXIlPsIB9eReFiHYyuMS19NQxkllFRi4t3LDrmRC2z4F0xuJy7ho4T1g4xS9VnvU4SdRm6BDbufJh36PQLol76gnA9sGYCxGcNlbaZpPOTjzsPdCDm5IJup0dK1aMFYNCUW78rz+in7Ld8NUyopmFZGvkMw3kaptk5i+8lx2nuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pu0/EkOze9XhwZ4ks830okEJslseajBRbVHdlaje4IQ=;
 b=U3hf14e9od8jYWaorY/vfwHl9eea+5wIt/nTLWZIImGagph0OfRzHRuMju2Bfdw0zab83UGx+/lVcBQHktn2rNq9ffyokZ5BTQY3IPyoT/TARfJyfm2JLZDidtwjaVapdnzKtYbXNqvcCE7GSnmNmAoWjv7lxOZIz4tHxYoPe5E=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 21:13:48 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 21:13:48 +0000
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
 AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AIAAVgGAgAK0ooCAIEFKAIAA0sIAgAPWhwCAAnZSAIAA99mAgACQGICAANfzAIAAhJUA
Date: Thu, 5 Sep 2024 21:13:48 +0000
Message-ID: <20240905211338.omst6jr3okbxkqdh@synopsys.com>
References: <b48e7aba-6c54-431f-bbb5-3e5490df0c1a@samsung.com>
 <20240809234227.eriwy5e6leatzdyh@synopsys.com>
 <b273201d-c589-4c57-9d57-ad2affaeade0@samsung.com>
 <20240831005046.5lndwdr7cfm3k3to@synopsys.com>
 <2e678109-8399-48d5-9567-033eab910bca@samsung.com>
 <20240904010322.leqt3pap6lguivg4@synopsys.com>
 <11535d95-c972-4dbe-afb5-de3a44bc4a21@samsung.com>
 <CGME20240905002630epcas5p4532c1e66864e39990376b696aa1f53d7@epcas5p4.samsung.com>
 <20240905002611.rxlv66zsker2h5w2@synopsys.com>
 <d5552437-119c-4a0f-9d71-6959727b6364@samsung.com>
In-Reply-To: <d5552437-119c-4a0f-9d71-6959727b6364@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB5620:EE_
x-ms-office365-filtering-correlation-id: 83dcd9d4-efd4-4a60-a870-08dccdefa236
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1dzOWdmWVhTY2lRTHlnOU5HY2J3M1pHbWFoNElKaEF1ai90aW1vNDVBOHly?=
 =?utf-8?B?c3Bid3EyUE0xZndSVkhGVDZuWll3bUNDcTRubkVSQnJvMThkQVZzMDJIYVlU?=
 =?utf-8?B?Y3V3aEg1V2VVUTJyd1VPNEZhUFU0YzJkTkU2aFoxWnprS3BqME82eDY5aDRz?=
 =?utf-8?B?V0NtR0k2OUhHbEFZZU1Kc0hZVkpJcTk4NGw2ZHNwTFJSR0Nnb2tDSnBoYkZC?=
 =?utf-8?B?WGRSV21lZ1dxcjNjSktHQnh2L00zNHZ3NndCUnVVcytBWEcya2ZGNXFWZHA5?=
 =?utf-8?B?ZWt4ei9ueG9pMjdZSnpNdm9vdGxPMFJ4Y0JtMEp0enBRTlBKbUhjS3ZWU2I3?=
 =?utf-8?B?ZWRLSDNBRU5ycjJZZFJtY1I2NEZ5Vmh3b2hueWcxbDljNDZGRG5BUndoeDBE?=
 =?utf-8?B?MDU2V3hWRnlKemd1OG9iL1ErNWxjbFhmejkrdTBOZ2gzSk9HTXRzRU9ZbVRw?=
 =?utf-8?B?aG9YYVJOa3ZDclExRitHdytpZThkTWx1MzZGdWJ1TXZHYzk4dWJXOXNza2R6?=
 =?utf-8?B?SkJNWTFGZ1luaWtZb1RvUjVXSGJSWTBrKzUwWkovRTNmOTZKSW1aVU16TklT?=
 =?utf-8?B?cFg3M2Q2aUxLY0NpVjdOcEdhcExBL2pWMHk1Mnl1WXlIOG5wdE9TTFJwTmhn?=
 =?utf-8?B?ZmtOM2lHVjA3MGI1QTJTSi9obWFsb2lPSlhkZ2REWk9kUWlGbHZQQTdkVTVO?=
 =?utf-8?B?WmlZRkE2UVI3SUU0bTFNL2taUzZwc1ZncGRmZlRIbEpCNnVWeDQ5a3JIQ2tL?=
 =?utf-8?B?RkNLL2ltVktRNmduVWoxVWYydlNjYllVMW5DbzFTUEtmaCtvek4rOHpqYStX?=
 =?utf-8?B?WEJaeWVKK1R4M08vNEVkMnQ3czVLV3BuWlZqOGZQRDJsWFczYU1QQTVvR1FC?=
 =?utf-8?B?N2NibCszaEtTQ1JnbklvRmdsR3hyS29Cd05ONDZaRVhOMExkeXo2bGw3YmVZ?=
 =?utf-8?B?U3ZmOHpBOE9SdGhlNTI5S05ZcmRaWEd3akVoL0E5Y0kxMlQzNXVGWGk1NVdD?=
 =?utf-8?B?RlYwWmloY09aa3FQY2FqU3VVODlPOW4yc2RjUmZwWG1RRm5PZ0JuOXZycFJp?=
 =?utf-8?B?WVlDQmUyMWFHTG85TW1rY25xZms1amxyYXl3bUpPdytPZUtmd1kzRHMrOU82?=
 =?utf-8?B?UHozbGd3ZzhYNFBGZm4xN1RoSFJVSUx3dUdBZzhHSUZ1MitFMFBnUkZSTGE1?=
 =?utf-8?B?YnRXbzVmNGtram93clNOblR0bUpqcmJTVmx2YmtJWjdkOEdFOFYvZTE3RVNK?=
 =?utf-8?B?RnZ6d2FoenVNMHdIQS9RQ0NVaHh0WFBzUFUxaUpUSjVRVDNYNlVXRUxJeFRE?=
 =?utf-8?B?QzZRb2NkektnbjdLRjg2aWNFWlZPRkJkbFNWSWpsSU40Sm4wTlRLWHFLWk1h?=
 =?utf-8?B?bTdHT3ZMa3l3OUVTVFlRMjVHOXpMSWVVVmJuYU1semxUb1FTVDNtdk5iSXZ3?=
 =?utf-8?B?amlpRDFKaTR2aDBwcGNBUVJ2dWZ6aXFGV2hqakJESnF3V3FtUGwwVXJnVVJj?=
 =?utf-8?B?amROODM4dW9Pb0FHQklDdUZzQnhLSjZ0LytLNFZsaHQ0ZHU2VDlHUFlzZjJ4?=
 =?utf-8?B?TDhlY0E4V3FsTTFxTGpTZWRUSk44V1dGVEYyOWRKM3JUaGc0aGx1TmhPeHdJ?=
 =?utf-8?B?ejdqRDNmdWlJNlVYZWJlNVd4a3FyK1JJVFNFNWljN2lJOS9ybm4rNTdvcGMv?=
 =?utf-8?B?MmpIQllZWEVlQml5UUJtR2p4cGhsakUzZm00T3RhcXBSY0pQN2Z1QVFSU050?=
 =?utf-8?B?ZWJqNlF1N0lzdG9ITUJuc2RZTFV6cktwMUVhd3h1bDBYdGJLcEJRN1B5d0g0?=
 =?utf-8?B?ckRsVVVzRWlNVUFLNGRLaUVrMWFWSEJvVUNETlFkcU9BUFhzbkhQODNVdkh1?=
 =?utf-8?B?MWFLeUw2K1Nod1VRT0FnY2IxKzdxQ3RId2dmOHJmWFZNeEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjh2SFk0Ti9qeGhEcXFWVVU2WWZSbEpwRmhjVnhkcFdGUitJck0reFhlTSs2?=
 =?utf-8?B?VHF0NEEwNGRkd29VdFBIMWdiTDdIUlR1MkFMWUZLdGw1Qm5NVEs3RFNEdXNo?=
 =?utf-8?B?UCtBSDhNcVZyelFzS3pzU21IVDNIVG1EOGdlK2xFbktZL0F0YURwVU13NGQ2?=
 =?utf-8?B?TnRCb1dYODlGQ0tBSGZtcDl3MVIvalVyekViY1AyMVBML28vZno5aGZmSmRn?=
 =?utf-8?B?VWVvNjZLYnVlQ2tLdXJTYllMdlJkR0Q1dE5vRk04MkFmbTYwaCtQQ1BUcmUw?=
 =?utf-8?B?Uis2elFqcE1Zb1NiWWNBWkRrcnBBNGU5SU5ZZkVLMzN2VzhoUDJXVVkyRE1h?=
 =?utf-8?B?SXlvYW56S1Bkd2V4TjlpN01KYmV2MXBhN0JpRUppWlBMZytBZEM3amU3bCs3?=
 =?utf-8?B?ZmhhejA5UnYvK2VkSG5xKzJHcGdXT1FDMzJSdzdkUTZpYitTUS9QRjFGQzVF?=
 =?utf-8?B?STI0c1hvWms3YWJHY1lVQW10Z0NvMUFKNklMc0NVM04zT2lMQ0JYS2tlQTMx?=
 =?utf-8?B?TUVWTjYvcndUeDBmSjFWQlJkazBHa1l1dnpSVkRBQzJMWFU2SmVxdUVRWlFv?=
 =?utf-8?B?Z2Z5ZWlNWnVQbSt3TGRVZHVnbUo3aEd2citBR0MxM0V4NDM0aFlMc04zVHJr?=
 =?utf-8?B?b0RCN3JuZGF3aUVSTEMzTlBtbzIzdml3SjZmNGY5OHEzYVpOTGUrQ3pVRURG?=
 =?utf-8?B?cStwNEt2UUJhTWgzaWlGUG5NZittK2MvcExhbnp0SG1DdmlIZGM4UkwyTWoz?=
 =?utf-8?B?M1A0c3pJVk1MRDg1cDRPbmFKQlVQT0U5YzlGTnRLa2d3L2lYQ2FZcU54RDd4?=
 =?utf-8?B?YTAyWTBUYVZ4bXYxbXFpU1gwQTdRN1VJWlc1dmZ4Nlcrb3dBbEdHcWdBQm1B?=
 =?utf-8?B?UUM0VkR6ajdQQTZLa1dGVHJ1TTc3VFJhNTN2VkhBM3NaMFYyZlI0aWxnd0NS?=
 =?utf-8?B?UktsVXl4NHM5T29jMDV1RTlLaFR2MWlmWGhUTFJDMUtzb2lVVVRiUVJNRWJX?=
 =?utf-8?B?MlhnSjFDSEluWFpVT25QMkd2a2h2MlRCR09RZ3FTOWpwZ0FGSFNCVmNUUURI?=
 =?utf-8?B?SEVOR2ZSeDl4WXhaZ2xWanBnczQzcUZkeXZDN1lTK0ljZkJ5bEN4bjhraHdU?=
 =?utf-8?B?STRzQjZBa1g5VVozVzVpNVhFeDRwUldPVkNlQXVGY2QyM3V0UmhLRFYrQURU?=
 =?utf-8?B?dmowSThDNVJFbzFhdjJWVS9UL0pjWlJHY0dkS2FSa2FMeEhLcmVUVWR5NzRG?=
 =?utf-8?B?T05nd29TRldINVJ2ZVlzTmtVUVBZV3JVR1BxbE5MQ2xhQThZMFlSK0w2WVRk?=
 =?utf-8?B?cFVxZzBiRVdLQThLNXpUSUEveUhIUHRRMS94ZXdQZnZXS2VNTmJ2YnVDMWZZ?=
 =?utf-8?B?eFhzSDRCV254RzFVL3BGMEwybjhld05jcWZ5bExTc0J3REgvclRSVHlPUTI2?=
 =?utf-8?B?d08xUDVXRmx0UDQzRUszN2pIWUNPb3dETTJWTmVtaloyRDNUY0xLOCsvZGlu?=
 =?utf-8?B?bkpqQ2poS1ExWDZ0eWtaYWFVRUtQV2NLc3h0QXVEY3VTMWRCUTUweitlU1FR?=
 =?utf-8?B?NUtLZ0R5NU5YTFA3UGdycVR2QnY0VXNFQzFpeW1iSk43SnVnN2o2cXEvZHNF?=
 =?utf-8?B?NnNRSWEvQmVpQ1lybG91Q1NqSnZoSGRhd0p1K0twK243U0EzMFZmTlF4RFJY?=
 =?utf-8?B?RW43NHhZdUlsTmpmTWtVNHJFQnk2WkNDTkx4bW1OK1JUVStvSnAzSzBHY1pm?=
 =?utf-8?B?Qk0wYWxJbXQzQ0JUZUw0Z2QwaXJ6NGFSRjFpb05Dc0pmTDBNZVlRTHFhbzJ1?=
 =?utf-8?B?K2tIVGtCRlYrd29hb1lpdnplOXI1MDY0NFpNTXFkZi9BQThuQUc1Z1JRT2ZI?=
 =?utf-8?B?VXNkOHI5NTlZc0lRQzl1WUh0N05HTm84dmdGZHVYdU0wYUlsTFAvTytZbmNs?=
 =?utf-8?B?TXdIRDEyenRuMEg3WnRvQVlsb3NmR0VjSzFpTFNOWHhkRlRRaWtUVERKTE1k?=
 =?utf-8?B?UlpxaUsrc3BrZ0NOZUhuVWJFcHRuenFzTzNVdEJXMzNGdTRjOEF6M0dTS25Q?=
 =?utf-8?B?MzBiSjhYWHFzbTBYUUJvcUtiWUpWWlZ3aFdDN0h4b2IzcEhMaXl3S1NwZ21W?=
 =?utf-8?Q?HarSDQ3y5bLtr3RlaRxZxMT8j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23671DCA6F3BE34DB57C5DB0F0767269@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wLlLp5nUJZIp//5Vuw6C6haSoJESZwqVcmH4clgpls9X/Ai09HQppiAuEkWOQXxXrWrgpc3/dZ9lqRrtHW4rj32qrfH4sg1WPN70JRByIoT9oOzfAPF3OI6Phkr13EvgyruU6eBhvP1Hks1GHd6Uiajy6magQ2+PcSHgonMQ1y36COSl2giHhikNZaL+xeyjT+2R87PbnhtY23gLKiccrzvYe53JuoUpmNzAqcnes4/JLRe4rZGpiujo/6D2ITfbxJW/gzBlnJ2lppi1JzuOwPE2b5uPDYFG0zqTnLPpFtNLrZ9axmjWeYP7V7fDgtqp8pcwzzMZqWGWXJ8Tb3dyKysqAlmv7c82kBIyN/h+b0MT2e/h/Lvpd9J+OzH/idlH5Acx7QZxOLZYysDc0kM2vTOprX7GIUzX4m/Ix84t7iryR9DumSb6inpn0FSGJAAMsOC7lxYY030TglnYJ1ji9YY99uQ92GtSgvUcvKhwd7jboWebgvlZk2sWEU28QIHeNO+2ZZ4N9ihk5qO5wh1HCXsU/sbxcVRK7OOVB3piXzZJFTGl9B45AhoSaTsIPPw6NL/Dz094J0dDL9nXndSuSOJ12AZBxQcy+8sOIUj0/GUjkjiYSfzKQzViWSXZpMvJUwESKecCm0hh7NTjuJyZMw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dcd9d4-efd4-4a60-a870-08dccdefa236
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 21:13:48.1574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iIW2g0NuU9UaNxcNDOPK9/mWNWkie5ICsRughQZ2AQoNpZiBA6qigfYc9i4DIYdsu2iDnsF+J+pLiaJTHoBb8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
X-Authority-Analysis: v=2.4 cv=QLg6RRLL c=1 sm=1 tr=0 ts=66da1f12 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=BeYmWBOyg7LB-H5XWlYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: B-MlCo6dJQPFNzREHhguA9nOkEcXrYOT
X-Proofpoint-ORIG-GUID: B-MlCo6dJQPFNzREHhguA9nOkEcXrYOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_16,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1015 phishscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409050158

T24gVGh1LCBTZXAgMDUsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
OS81LzIwMjQgNTo1NiBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFdlZCwgU2VwIDA0
LCAyMDI0LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4gPj4gT24gOS80LzIwMjQgNjozMyBB
TSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+Pj4gT24gTW9uLCBTZXAgMDIsIDIwMjQsIFNlbHZh
cmFzdSBHYW5lc2FuIHdyb3RlOg0KPiA+Pj4+IEkgd291bGQgbGlrZSB0byByZWNvbmZpcm0gZnJv
bSBvdXIgZW5kIHRoYXQgaW4gb3VyIGZhaWx1cmUgc2NlbmFyaW8sIHdlDQo+ID4+Pj4gb2JzZXJ2
ZSB0aGF0IERXQzNfRVZFTlRfUEVORElORyBpcyBzZXQgaW4gZXZ0LT5mbGFncyB3aGVuIHRoZSBk
d2MzDQo+ID4+Pj4gcmVzdW1lIHNlcXVlbmNlIGlzIGV4ZWN1dGVkLCBhbmQgdGhlIGR3Yy0+cGVu
ZGluZ19ldmVudHMgZmxhZyBpcyBub3QNCj4gPj4+PiBiZWluZyBzZXQuDQo+ID4+Pj4NCj4gPj4+
IElmIHRoZSBjb250cm9sbGVyIGlzIHN0b3BwZWQsIG5vIGV2ZW50IGlzIGdlbmVyYXRlZCB1bnRp
bCBpdCdzIHJlc3RhcnRlZA0KPiA+Pj4gYWdhaW4uIChpZSwgeW91IHNob3VsZCBub3Qgc2VlIEdF
Vk5UQ09VTlQgdXBkYXRlZCBhZnRlciBjbGVhcmluZw0KPiA+Pj4gRENUTC5ydW5fc3RvcCkuIElm
IHRoZXJlJ3Mgbm8gZXZlbnQsIG5vIGludGVycnVwdCBhc3NlcnRpb24gc2hvdWxkIGNvbWUNCj4g
Pj4+IGZyb20gdGhlIGNvbnRyb2xsZXIuDQo+ID4+Pg0KPiA+Pj4gSWYgdGhlIHBlbmRpbmdfZXZl
bnRzIGlzIG5vdCBzZXQgYW5kIHlvdSBzdGlsbCBzZWUgdGhpcyBmYWlsdXJlLCB0aGVuDQo+ID4+
PiBsaWtlbHkgdGhhdCB0aGUgY29udHJvbGxlciBoYWQgc3RhcnRlZCwgYW5kIHRoZSBpbnRlcnJ1
cHQgaXMgZ2VuZXJhdGVkDQo+ID4+PiBmcm9tIHRoZSBjb250cm9sbGVyIGV2ZW50LiBUaGlzIG9j
Y3VycyBhbG9uZyB3aXRoIHRoZSBpbnRlcnJ1cHQNCj4gPj4+IGdlbmVyYXRlZCBmcm9tIHlvdXIg
Y29ubmVjdGlvbiBub3RpZmljYXRpb24gZnJvbSB5b3VyIHNldHVwLg0KPiA+Pg0KPiA+PiBJIGNv
bXBsZXRlbHkgYWdyZWUuIE15IGRpc2N1c3Npb24gcmV2b2x2ZXMgYXJvdW5kIHRoZSBoYW5kbGlu
ZyBvZiB0aGUNCj4gPj4gRFdDM19FVkVOVF9QRU5ESU5HIGZsYWcgaW4gYWxsIHNpdHVhdGlvbnMu
IFRoZSBwdXJwb3NlIG9mIHVzaW5nIHRoaXMNCj4gPj4gZmxhZyBpcyB0byBwcmV2ZW50IHRoZSBw
cm9jZXNzaW5nIG9mIG5ldyBldmVudHMgaWYgYW4gZXhpc3RpbmcgZXZlbnQgaXMNCj4gPj4gc3Rp
bGwgYmVpbmcgcHJvY2Vzc2VkLiBUaGlzIGZsYWcgaXMgc2V0IGluIHRoZSB0b3AtaGFsZiBpbnRl
cnJ1cHQNCj4gPj4gaGFuZGxlciBhbmQgY2xlYXJlZCBhdCB0aGUgZW5kIG9mIHRoZSBib3R0b20t
aGFsZiBoYW5kbGVyLg0KPiA+Pg0KPiA+PiBOb3csIGxldCdzIGNvbnNpZGVyIHNjZW5hcmlvcyB3
aGVyZSB0aGUgYm90dG9tIGhhbGYgaXMgbm90IHNjaGVkdWxlZCwNCj4gPj4gYW5kIGEgVVNCIHJl
Y29ubmVjdCBvY2N1cnMuIEluIHRoaXMgY2FzZSwgdGhlcmUgaXMgYSBwb3NzaWJpbGl0eSB0aGF0
DQo+ID4+IHRoZSBpbnRlcnJ1cHQgbGluZSBpcyB1bm1hc2tlZCBpbiBkd2MzX2V2ZW50X2J1ZmZl
cnNfc2V0dXAsIGFuZCB0aGUgVVNCDQo+ID4+IGNvbnRyb2xsZXIgYmVnaW5zIHBvc3RpbmcgbmV3
IGV2ZW50cy4gVGhlIHRvcC1oYWxmIGludGVycnVwdCBoYW5kbGVyDQo+ID4+IGNoZWNrcyBmb3Ig
dGhlIERXQzNfRVZFTlRfUEVORElORyBmbGFnIGFuZCByZXR1cm5zIElSUV9IQU5ETEVEIHdpdGhv
dXQNCj4gPj4gcHJvY2Vzc2luZyBhbnkgbmV3IGV2ZW50cy4gSG93ZXZlciwgdGhlIFVTQiBjb250
cm9sbGVyIGNvbnRpbnVlcyB0byBwb3N0DQo+ID4+IGludGVycnVwdHMgdW50aWwgdGhleSBhcmUg
YWNrbm93bGVkZ2VkLg0KPiA+Pg0KPiA+PiBQbGVhc2UgcmV2aWV3IHRoZSBjb21wbGV0ZSBzZXF1
ZW5jZSBvbmNlIHdpdGggRFdDM19FVkVOVF9QRU5ESU5HIGZsYWcuDQo+ID4+DQo+ID4+IE15IHBy
b3Bvc2FsIGlzIHRvIGNsZWFyIG9yIHJlc2V0IHRoZSBEV0MzX0VWRU5UX1BFTkRJTkcgZmxhZyB3
aGVuDQo+ID4+IHVubWFza2luZyB0aGUgaW50ZXJydXB0IGxpbmUgZHdjM19ldmVudF9idWZmZXJz
X3NldHVwLCBhcGFydCBmcm9tDQo+ID4+IGJvdHRvbS1oYWxmIGhhbmRsZXIuIENsZWFyaW5nIHRo
ZSBEV0MzX0VWRU5UX1BFTkRJTkcgZmxhZyBpbg0KPiA+PiBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0
dXAgZG9lcyBub3QgY2F1c2UgYW55IGhhcm0sIGFzIHdlIGhhdmUgaW1wbGVtZW50ZWQNCj4gPj4g
YSB0ZW1wb3Jhcnkgd29ya2Fyb3VuZCBpbiBvdXIgdGVzdCBzZXR1cCB0byBwcmV2ZW50IElSUSBz
dG9ybXMuDQo+ID4+DQo+ID4+DQo+ID4+DQo+ID4+IFdvcmtpbmcgc2NlbmFyaW9zOg0KPiA+PiA9
PT09PT09PT09PT09PT09PT0NCj4gPj4gMS4gVG9wLWhhbGYgaGFuZGxlcjoNCj4gPj4gICDCoMKg
wqAgYS4gaWYgKGV2dC0+ZmxhZ3MgJiBEV0MzX0VWRU5UX1BFTkRJTkcpDQo+ID4+ICAgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIElSUV9IQU5ETEVEOw0KPiA+PiAgIMKgwqDCoCBiLiBTZXQgRFdDM19F
VkVOVF9QRU5ESU5HIGZsYWcNCj4gPj4gICDCoMKgwqAgYy4gTWFza2luZyBpbnRlcnJ1cHQgbGlu
ZQ0KPiA+Pg0KPiA+PiAyLiBCb3R0b20taGFsZiBoYW5kbGVyOg0KPiA+PiAgIMKgwqDCoCBhLiBV
bi1tYXNraW5nIGludGVycnVwdCBsaW5lDQo+ID4+ICAgwqDCoMKgIGIuIENsZWFyIERXQzNfRVZF
TlRfUEVORElORyBmbGFnDQo+ID4+DQo+ID4+IEZhaWx1cmUgc2NlbmFyaW9zOg0KPiA+PiA9PT09
PT09PT09PT09PT09PT0NCj4gPj4gMS4gVG9wLWhhbGYgaGFuZGxlcjoNCj4gPj4gICDCoMKgwqAg
YS4gaWYgKGV2dC0+ZmxhZ3MgJiBEV0MzX0VWRU5UX1BFTkRJTkcpDQo+ID4+ICAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBJUlFfSEFORExFRDsNCj4gPj4gICDCoMKgwqAg
Yi4gU2V0IERXQzNfRVZFTlRfUEVORElORyBmbGFnDQo+ID4+ICAgwqDCoMKgIGMuIE1hc2tpbmcg
aW50ZXJydXB0IGxpbmUNCj4gPiBGb3IgRFdDM19FVkVOVF9QRU5ESU5HIGZsYWcgdG8gYmUgc2V0
IGF0IHRoaXMgcG9pbnQgKGJlZm9yZSB3ZSBzdGFydCB0aGUNCj4gPiBjb250cm9sbGVyKSwgdGhh
dCBtZWFucyB0aGF0IHRoZSBHRVZOVENPVU5UIHdhcyBub3QgMCBhZnRlcg0KPiA+IHNvZnQtZGlz
Y29ubmVjdCBhbmQgdGhhdCB0aGUgcG1fcnVudGltZV9zdXNwZW5kZWQoKSBtdXN0IGJlIGZhbHNl
Lg0KPiANCj4gSW4gdGhlIHRvcC1oYWxmIGNvZGUgd2hlcmUgd2Ugc2V0IHRoZSBEV0MzX0VWRU5U
X1BFTkRJTkcgZmxhZywgd2UgDQo+IGFja25vd2xlZGdlIEdFVk5UQ09VTlQuIFRoZXJlZm9yZSwg
SSB0aGluayBpdCBpcyBub3QgbmVjZXNzYXJ5IGZvciANCj4gR0VWTlRDT1VOVCB0byBoYXZlIGEg
bm9uLXplcm8gdmFsdWUgdW50aWwgYSBuZXcgZXZlbnQgb2NjdXJzLiBJbiBmYWN0LCANCj4gd2hl
biB3ZSB0cmllZCB0byBwcmludCBHRVZOVENPVU5UIGluIGEgbm9uLWludGVycnVwdCBjb250ZXh0
LCB3ZSBmb3VuZCANCj4gdGhhdCBpdCB3YXMgemVybywgd2hlcmUgd2UgcmVjZWl2ZWQgRFdDM19F
VkVOVF9QRU5ESU5HIGJlaW5nIHNldCBpbiANCj4gbm9uLWludGVycnVwdCBjb250ZXh0Lg0KDQpG
b3IgRFdDM19FVkVOVF9QRU5ESU5HIHRvIGJlIHNldCwgR0VWTlRDT1VOVCBtdXN0IGJlIG5vbi16
ZXJvLiBJZiB5b3UNCnNlZSBpdCdzIHplcm8sIHRoYXQgbWVhbnMgdGhhdCBpdCB3YXMgYWxyZWFk
eSBkZWNyZW1lbnRlZCBieSB0aGUgZHJpdmVyLg0KDQpJZiB0aGUgZHJpdmVyIGFja25vd2xlZGdl
cyB0aGUgR0VWTlRDT1VOVCwgdGhlbiB0aGF0IG1lYW5zIHRoYXQgdGhlDQpldmVudHMgYXJlIGNv
cGllZCBhbmQgcHJlcGFyZWQgdG8gYmUgcHJvY2Vzc2VkLiBUaGUgYm90dG9tLWhhbGYgdGhyZWFk
DQppcyBzY2hlZHVsZWQuIElmIGl0J3MgZm9yIHN0YWxlIGV2ZW50LCBJIGRvbid0IHdhbnQgaXQg
dG8gYmUgcHJvY2Vzc2VkLg0KDQo+IA0KPiA+DQo+ID4+IDIuIE5vIEJvdHRvbS1oYWxmIHNjaGVk
dWxlZDoNCj4gPiBXaHkgaXMgdGhlIGJvdHRvbS1oYWxmIG5vdCBzY2hlZHVsZWQ/IE9yIGRvIHlv
dSBtZWFuIGl0IGhhc24ndCB3b2tlbiB1cA0KPiA+IHlldCBiZWZvcmUgdGhlIG5leHQgdG9wLWhh
bGYgY29taW5nPw0KPiANCj4gSW7CoHZlcnkgcmFyZSBjYXNlcywgaXQgaXMgcG9zc2libGUgaW4g
b3VyIHBsYXRmb3JtIHRoYXQgdGhlIENQVSBtYXkgbm90IA0KPiBiZSBhYmxlIHRvIHNjaGVkdWxl
IHRoZSBib3R0b20gaGFsZiBvZiB0aGUgZHdjMyBpbnRlcnJ1cHQgYmVjYXVzZSBhIHdvcmsgDQo+
IHF1ZXVlIGxvY2t1cCBoYXMgb2NjdXJyZWQgb24gdGhlIHNhbWUgQ1BVIHRoYXQgaXMgYXR0ZW1w
dGluZyB0byBzY2hlZHVsZSANCj4gdGhlIGR3YzMgdGhyZWFkIGludGVycnVwdC4gSW4gdGhpcyBj
YXNlIFllcywgdGhlIGJvdHRvbS1oYWxmIGhhbmRsZXIgDQo+IGhhc24ndCB3b2tlbiB1cCwgdGhl
biBpbml0aWF0ZSBhbiBJUlEgc3Rvcm0gZm9yIG5ldyBldmVudHMgYWZ0ZXIgdGhlIA0KPiBjb250
cm9sbGVyIHJlc3RhcnRzLCByZXN1bHRpbmcgaW4gbm8gbW9yZSBib3R0b20taGFsZiBzY2hlZHVs
aW5nIGR1ZSB0byANCj4gdGhlIENQVSBiZWluZyBzdHVjayBpbiBwcm9jZXNzaW5nIGNvbnRpbnVv
dXMgaW50ZXJydXB0cyBhbmQgcmV0dXJuIA0KPiBJUlFfSEFORExFRCBieSBjaGVja2luZyBpZiAo
ZXZ0LT5mbGFncyAmIERXQzNfRVZFTlRfUEVORElORykuDQo+IA0KPiA+DQo+ID4+IDMuIFVTQiBy
ZWNvbm5lY3Q6IGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cA0KPiA+PiAgIMKgwqDCoCBhLiBVbi1t
YXNraW5nIGludGVycnVwdCBsaW5lDQo+ID4gRG8gd2Uga25vdyB0aGF0IHRoZSBHRVZOVENPVU5U
IGlzIG5vbi16ZXJvIGJlZm9yZSBzdGFydGluZyB0aGUNCj4gPiBjb250cm9sbGVyIGFnYWluPw0K
PiANCj4gVGhlIEdFVk5UQ09VTlQgdmFsdWUgc2hvd2luZyBhcyB6ZXJvIHRoYXQgd2UgY29uZmly
bWVkIGJ5IGFkZGluZyBkZWJ1ZyANCj4gbWVzc2FnZSBoZXJlLg0KPiA+DQo+ID4+IDQuIENvbnRp
bnVvdXMgaW50ZXJydXB0cyA6IFRvcC1oYWxmIGhhbmRsZXI6DQo+ID4+ICAgwqDCoMKgIGEuIGlm
IChldnQtPmZsYWdzICYgRFdDM19FVkVOVF9QRU5ESU5HKQ0KPiA+PiAgIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4+DQo+ID4+ICAgwqDCoMKg
IGEuIGlmIChldnQtPmZsYWdzICYgRFdDM19FVkVOVF9QRU5ESU5HKQ0KPiA+PiAgIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4+DQo+ID4+ICAg
wqDCoMKgIGEuIGlmIChldnQtPmZsYWdzICYgRFdDM19FVkVOVF9QRU5ESU5HKQ0KPiA+PiAgIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4+IC4u
Li4uDQo+ID4+DQo+ID4+IC4uLi4uDQo+ID4+DQo+ID4+IC4uLi4uDQo+ID4+DQo+IA0KPiBTdXJl
LCBJIGNhbiB0cnkgaW1wbGVtZW50aW5nIHRoZSBwcm9wb3NlZCBjb2RlIG1vZGlmaWNhdGlvbnMg
aW4gb3VyIA0KPiB0ZXN0aW5nIGVudmlyb25tZW50Lg0KPiANCj4gQnV0LCBJIGFtIHVuY2VydGFp
biBhYm91dCBob3cgdGhlc2UgY2hhbmdlcyB3aWxsIGVmZmVjdGl2ZWx5IHByZXZlbnQgYW4gDQo+
IElSUSBzdG9ybSB3aGVuIHRoZSBVU0IgY29udHJvbGxlciBzZXF1ZW5jZSByZXN0YXJ0cyB3aXRo
IHRoZSANCj4gRFdDM19FVkVOVF9QRU5ESU5HLiBUaGUgZm9sbG93aW5nIGNvZGUgd2lsbCBvbmx5
IGV4ZWN1dGUgdW50aWwgdGhlIA0KPiBEV0MzX0VWRU5UX1BFTkRJTkcgaXMgY2xlYXJlZCwgYXQg
d2hpY2ggcG9pbnQgdGhlIHByZXZpb3VzIGJvdHRvbS1oYWxmIA0KPiB3aWxsIG5vdCBiZSBzY2hl
ZHVsZWQuDQo+IA0KPiBQbGVhc2UgY29ycmVjdCBtZSBpZiBpIGFtIHdyb25nIGluIG15IGFib3Zl
IHVuZGVyc3RhbmRpbmcuDQoNCkFzIEkgbWVudGlvbmVkLCBJIGRvbid0IHdhbnQgRFdDM19FVkVO
VF9QRU5ESU5HIGZsYWcgdG8gYmUgc2V0IGR1ZSB0bw0KdGhlIHN0YWxlIGV2ZW50LiBJIHdhbnQg
dG8gaWdub3JlIGFuZCBza2lwIHByb2Nlc3NpbmcgYW55IHN0YWxlIGV2ZW50Lg0KDQpUaGUgRFdD
M19FVkVOVF9QRU5ESU5HIHNob3VsZCBub3QgYmUgc2V0IGJ5IHRoZSB0aW1lDQpkd2MzX2V2ZW50
X2J1ZmZlcnNfc2V0dXAoKSBpcyBjYWxsZWQuDQoNClNwZWNpZmljYWxseSByZXZpZXcgdGhpcyBj
b25kaXRpb24gaW4gbXkgdGVzdGluZyBwYXRjaDoNCg0KCS8qDQoJICogSWYgdGhlIGNvbnRyb2xs
ZXIgaXMgaGFsdGVkLCB0aGUgZXZlbnQgY291bnQgaXMgc3RhbGUvaW52YWxpZC4gSWdub3JlDQoJ
ICogdGhlbS4gVGhpcyBoYXBwZW5zIGlmIHRoZSBpbnRlcnJ1cHQgYXNzZXJ0aW9uIGlzIGZyb20g
YW4gb3V0LW9mLWJhbmQNCgkgKiByZXN1bWUgbm90aWZpY2F0aW9uLg0KCSAqLw0KCWlmICghZHdj
LT5wdWxsdXBzX2Nvbm5lY3RlZCAmJiBjb3VudCkgew0KCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3Ms
IERXQzNfR0VWTlRDT1VOVCgwKSwgY291bnQpOw0KCQlyZXR1cm4gSVJRX0hBTkRMRUQ7DQoJfQ0K
DQpMZXQgbWUga25vdyBpZiB0aGUgY29uZGl0aW9uIG1hdGNoZXMgd2l0aCB3aGF0J3MgaGFwcGVu
aW5nIGZvciB5b3VyDQpjYXNlLg0KDQpUaGFua3MsDQpUaGluaA==

