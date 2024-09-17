Return-Path: <linux-kernel+bounces-331313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A92797AB2B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB92328328D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B5954F95;
	Tue, 17 Sep 2024 05:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WUnIDMRi";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PKsOBlSf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TXrJCkhQ"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941BD2EAEA;
	Tue, 17 Sep 2024 05:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726552044; cv=fail; b=SJItq+DCVRGTMoOY20Q1/nTvMZpVGLGvZp8XaZvaVO9jV4/GPGccGee0+OzkZBFJZeuslbJDhWD5QaxvjIhvllM4vhBh2XDMjcrZO91BguAUZwwkz03ydV26N/2ZSlkrH9g5HeYUZLsJudH09G8j8ACOdf0AWkYWCpDM0Dfm4/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726552044; c=relaxed/simple;
	bh=mQTvLvGO2ZQQaAWUI7WcuJ2w3KEiXVMucoS5Vt5J68Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pbqv5dYvlrJkYcRLv1j1X9Hm6gqLJ4Ajs3/IwoFZbaa//XdchPsKgId9/FKws1CiyrsbT18hIobLZU99xT9UcX8OMch2n314vYZzdBXCFNJmmlQwNTjkCLbuU9PLosJUkHB0lZVAvYo+Q2tpxH8keoWnTTaf0F4eAZoZ11OpEGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WUnIDMRi; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PKsOBlSf; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TXrJCkhQ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H40bxU019559;
	Mon, 16 Sep 2024 22:47:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=mQTvLvGO2ZQQaAWUI7WcuJ2w3KEiXVMucoS5Vt5J68Y=; b=
	WUnIDMRiJJbQamgBlSwEn5qNufAJcyuOWwSLue+wOR13aEsNAJc7zfth4+Lh4sDB
	o8ZDOkHJLhygNlV3jsGMxnlL2WcxLDHmKmZdcEb/GSQy6loGQiBM6RlkzRp4BCYo
	UmhTxuAf3/Sm/OgGVEP6lCdZXj4jdHSnjwr6+QzH42BgAc3hUpZV8w6suJD2kvZZ
	L+LcFlbJc5nRKKHaZPqdVqsG4IXx4uDP21u2TNfoIK70jHWjNueEwpdXYKgt95vS
	XrIwXFfMX1tuhmc87Wt7BKn7OOo1xT8hqB25sEFKCBVt+/ssShPDudvWZpj9l/HE
	4mjf4itE07vN35W0LNvdEg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 41n94f9xp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 22:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1726552031; bh=mQTvLvGO2ZQQaAWUI7WcuJ2w3KEiXVMucoS5Vt5J68Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=PKsOBlSfLyfzKIL95tDfV9ugkdMv8oWgahX503/5VUS+8k8Ueqnl83UY6n1q2mKWA
	 T0AmamTbwi5053RMK6mNa6l14j2Wu2dX/MnouVBmb71jMdIChH4vpIf8YD1CqPQ412
	 tgAroXr2rC9dyzBkkyJZCUN03Nw9lkDNF4/cnrRcc6CXyfosMNrtiEbhOIU8a78SM4
	 +1bdqtIvdnCQ79d3Vec4EmT2SR/+BwE+ePZOIMHScY6Xj6SVCtPsDVIhfHBjEsnUM2
	 i5mvCv0c+kvd/++j1qVcuBWyFSH+jacnMlo1gCLSdRuMVJw/1iKiYvor59PVoYMYYX
	 ZYraaTf2gvO9w==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ADF7140147;
	Tue, 17 Sep 2024 05:47:10 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 2B900A00B2;
	Tue, 17 Sep 2024 05:47:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TXrJCkhQ;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B0A2E401CB;
	Tue, 17 Sep 2024 05:47:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUgPXHzEyh2d0RQFC8cjIdMP+RLPFN79joYjCBAUvB7MKBQ9xVkGzrhQBg70sjKWxHIsijYT8BurWgGofBQkQZAjl3kPrRpFSMyRkvedEKPdNj6oGSBmh868DxOnVheImMIP5n1FV954g51dEyJ9Q7Ubu1s48vPC1crf2zLEa52wGROhnVmSW7mcIJheSKnADQPr4sDDC21XEhB7uSR7El6XkgoGxzgmuz9+OZ6xeRRUXaKgagZ5qloVjH/FMgGs0wQv5aCDZM4xCgCqUsp9CXJsX/0P1H1mjiZPrdpmRxHt6yhrdr2NVK6O3D323jBAS3vEe7MU2dCPmqZ/bfEwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQTvLvGO2ZQQaAWUI7WcuJ2w3KEiXVMucoS5Vt5J68Y=;
 b=gUuu2GauVKdsE0AuNN33XbMwA9/oBC1v+wI4Nq4xJAldCj+Gf0cXDXZWAkx3on/A49lymjFqfFJDzPLJ/BmTTyGI42UyiKMfMiGBEF3mSCfadjXx6EYBzKr1E7PTUv3CjuMtCBNdFMq68wFu9gAnvoHvpIckXf0nOmWY4GqpaNRDY8rTtMSK84DzN3o+ZSRSnYg/T4EQ5LzYTSKvhkGgoWCxlulwZkLsx3AhrkAkIb1Cl97fSGs/pO1cbvRg5+OQ1M8qvkccEZL2DPU9gOzg7cYQp4uIhvboo9PpXHY6n+NmmSmK27DqOKjFFa5sTePHmRJ/HW+pyRnz1z0xpAIY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQTvLvGO2ZQQaAWUI7WcuJ2w3KEiXVMucoS5Vt5J68Y=;
 b=TXrJCkhQGAyPg67itQwgJ+0VrVBQMZrocW7uoJozVp9vHS4DWPvE9dgE2jHUpLo5hgMrsDVulY8wEGq6wuzTJJPr72Dy40Q2YcX9LE5JGFkSJr8Nx9IPEK/oCgtshI/0Ie8KbXRrwrFoGpDMdHqaltMsMQtPhYc0Xuos8se7jU0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 05:47:06 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 05:47:05 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Selvarasu Ganesan <selvarasu.g@samsung.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
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
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        stable <stable@kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: core: Stop processing of pending events if
 controller is halted
Thread-Topic: [PATCH v2] usb: dwc3: core: Stop processing of pending events if
 controller is halted
Thread-Index: AQHbCIpOIl8f+8LK4EmR75pMhvNsxrJbB2EAgABuigCAAAMLgA==
Date: Tue, 17 Sep 2024 05:47:05 +0000
Message-ID: <20240917054703.w47rfo7x4lhzgccn@synopsys.com>
References:
 <CGME20240916224630epcas5p42b355e2884c665e19d3c9c3a5afd428e@epcas5p4.samsung.com>
 <20240916224543.187-1-selvarasu.g@samsung.com>
 <20240916230032.ugw23x7gijamrf5x@synopsys.com>
 <2024091716-snide-mashing-2c21@gregkh>
In-Reply-To: <2024091716-snide-mashing-2c21@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ2PR12MB9006:EE_
x-ms-office365-filtering-correlation-id: 990d75b1-7887-4377-17d6-08dcd6dc2941
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?emZGU09DSGtJZHcyWnBxRkE0dzlmaXV0SnRzRldjMFBEbVQzaVdEMWxZTUpp?=
 =?utf-8?B?OVVnZEwwdHRwS2NuVWVPRzhaQlJYODh1UkwxN2hWN1NHeFh4RzZrL0F3enFC?=
 =?utf-8?B?eitTeXJjSERtWEphVHZsMTFMeFFlV3Z6WjljejFXNzQxVUNRQkhFSXMybW1K?=
 =?utf-8?B?TnVIS3hremkxaU10UE9OQ0VheUJJZHBBNllERWN5UURUWW1qMTRNci9DZndB?=
 =?utf-8?B?SHRYWGllbW52b0MwR25oS2o4U29GVGF4d1lGQVd0dVBBclE3UU01TENnMitQ?=
 =?utf-8?B?NXZhVEF6NGYvN0t6YWRIMVkyZ2o0bldPWTlma3dyRUxaTHNJblc4Z1ZMWDlS?=
 =?utf-8?B?QTVQTHVyQy9hN292enFwN2pwakFmcko3bXoydjZ2QU1yME1zNCtkYlV0ZUNt?=
 =?utf-8?B?QWltR3l3RUVGT0w3VmlzeEpsOGVKL3ZNMjdSalo1UHpSYVdxQms0T01SNk5R?=
 =?utf-8?B?T05wWTI5UlRMK1diMmFrYk04OFltenc2bmdzbkJNcjNnWFN6U1NFNHlvR29M?=
 =?utf-8?B?ZmsraFVteW9VaWwyVVRzSFRyZ3ljNmhETDdNS0RnajlCVWlPZTFJYkVyS1R5?=
 =?utf-8?B?bENVdHY4dU5aY1hVSVk5SXBUUnFoOWd1WTByRkRORnU2dzlTVlJTZ0tLd1lh?=
 =?utf-8?B?K3p1eDBrR09nYTZET0xPRlRFcWhId1BubjVSNkdWVWRZZjdhZDlEaVpMS05h?=
 =?utf-8?B?YlFrWnM2WkttVXpPQUNkK2srTC90enAybWQ3cHEzekdyMFNZay9CcjlES1Vw?=
 =?utf-8?B?YnNsZTFrNDhjV0JIc2tzbW8wZXlDejVaOEM1ZCtYZjErcWw5K05FL0t6a2xL?=
 =?utf-8?B?VHdsLzFYL08rWHpLdlMwYWxRaDNWRlpDaUkwSUE3OGFGaEVKd3JjZ25aY1pu?=
 =?utf-8?B?OUk1L2xxTHJMclZJK0Nmc2tHbitsdTRUVVhYZldVaWdYQWFrait2RW5oUVJx?=
 =?utf-8?B?TWE0M250QzRKclppa052RCs4czZ0S3lyMzFWK3lNWUpCRDNqcVhrLzhjaFEv?=
 =?utf-8?B?REtIWXRyWDg2YVB0MnZKRG9hc1hlam1GdmZEcWExS3o3ZFVVUjN1MFUrbTdk?=
 =?utf-8?B?clZvZnFncEp5YjBja2FvV2dVbTJ0STJvcEppZUwxbG8rZkhEUHJXV3RpcVlk?=
 =?utf-8?B?eGlHelVSTVdRbHUyTnJ6dWQ0UWRJQmV1MUprc0VMSFQwNVdXTXc1NFhTSWo4?=
 =?utf-8?B?ME45em1mbWNSYU50SXVObWlNdlRERTVnVjNkNDdxand4Q2MvRFBOWUI1cjJk?=
 =?utf-8?B?cnl6c3UrTm5YWDJhWlBMSzcxRDU1aXUrQmNQZDJJRTYyOG1NdkF5SFNXTDJ3?=
 =?utf-8?B?UytDTyt3MFE5WThXSS9QcStGYTFEL25jem9iT2lGMENwV3pEcUE4S2RjSUt1?=
 =?utf-8?B?ZTJBU1FTL3pQd3hSR2VUaW1JeDJxOHdiMyt1K2kxbmp5cFdrc0xEallPSUox?=
 =?utf-8?B?d0Zla2xtQ09ieVVEQVNFeDBUQ1JGdlRXWUF1RnVBMjVnVkIxNzhGSTQxb3pD?=
 =?utf-8?B?VFBiQVhlQ2VUQWQ1bktsVmp3TmdIT3R2ZndZZTA1NHdWOVYvL2NxWEhXQkFz?=
 =?utf-8?B?bHNpYW5GZkZZejh1bGZPSEt0U0NoTjZ5dGo4eGtqdUF0c1hTRWVncTB2ZlFN?=
 =?utf-8?B?QU5jM1c0d2wzY29rNmx5RmxGSXJRZjA0TXdyZm5haU15RHF2MGU4bjNwWUlE?=
 =?utf-8?B?Vkl6bEh1NDU1OHNLc0p2aUg0MlVDWXlaVVZBVVFrbGlieHg1bERYOE9KTmJx?=
 =?utf-8?B?MUhvNC9oQ2I0dWdSV1RmQisrTWN0V0dZYTBzTFFnOG14bEk0TVRvMnZlMjIw?=
 =?utf-8?B?bzgxRjlORDZtM01pcnhGSUdqelVMbFljTUtZNzBoZ0RpRHR4SWpDYmRDbi9a?=
 =?utf-8?B?YlVCaCtTbktxdXNSaHg5cnJjL282N3k0WllnNU4zUmNpTlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZkNxYkYwQ2ZUYmpwZnlDZG5GVlYzZVZzUk9xT201aFVINm9mRkVGTXBvc0lJ?=
 =?utf-8?B?ZHkxcklVMXoxMHpscXFZNzFpRkFFcTN2QTRaT2NCMitla2ovT2IxRUQ5K2Nz?=
 =?utf-8?B?UEU3b2c0NlN1OXJpeURPK0FZdURBOVgzaGg3bTBqNFpuakNLdzhZOE0rc0hC?=
 =?utf-8?B?Yk5WSFBjbG5TcElHRE04K0dhM0pNcVc5d1QrOGxKS2hESnJpaWp2MitqMmFw?=
 =?utf-8?B?cVRyaFdKL1g4T1BLQ0JKR1BWeHovc2JZSXcwNU9kS1VQRTFLVVR3YmMzN01w?=
 =?utf-8?B?MFNjenpRWHZ4NjNZNXpUZEs0M2ZJSUtQKzl4dE1BaGwrOG5PekVNNVRncnBs?=
 =?utf-8?B?U0tVbFZUQkhjakRBZVdFamxqZ2hvWjlpLzRnNzYrdDRteUloS0psRVB5RjlU?=
 =?utf-8?B?NWxwRlFpNno5N040MDU0Zk9SdGpUUmZVdEtaOXk4emZOTWVXVFMyWDFkYU1x?=
 =?utf-8?B?eVVLQ2RES1czZEVmdmIxQjJyVEZpV3BhMkRmOGVxUkYybjl1ZnRUZDRuaG5t?=
 =?utf-8?B?bWViSkNGYTNvV0Zzc0FhcmJ5a05peGl5dC9Vc2RHZlJ1N0l4cEZzdHlFTzBp?=
 =?utf-8?B?TkNQTTU4Z1pVS05wK1NLcEhkVHMwOTlZSVVtUkJCUXNWd2VRWEpjZGZYaHd6?=
 =?utf-8?B?empvYnliMzFodVlwV2VFSC9PL0ViM1Joa3BRdW1tdWNSaURPNjFYdGRSbVFU?=
 =?utf-8?B?amRmMUQzR0FhL2tkVmJYcWM0andjYW9FanlqUGNxWU5FelBNYnY2TnpEcFJX?=
 =?utf-8?B?Mnp5N1labFJaMWlFekRqWW9ma2UzT1dWTE1pZ1hTNldLU3dKbzZKWDdKVmgv?=
 =?utf-8?B?N1JkMFN4elcvcG1hdjh3ZnU0bUF6bnB6RnVHZVcxQ1VvNDY4OGU0NHRibmFj?=
 =?utf-8?B?cDJYa0NmTk0zZVFFUnFNeWJoYjFBaHhuakpKZ2VDSFRCKy85NXUzMlo1Tzky?=
 =?utf-8?B?bUYvVzI0dTJPY1Y4cUE0ZEt5d056NTVJUktLYzZ2WUFSeDByUldWdTZJTjRE?=
 =?utf-8?B?L3gwNEZIbmJxcEsrM3lUdDMrbHpoM2R3ajlpT1lxRWZhWEk3NkJaYnA3bXpI?=
 =?utf-8?B?akhTMUtDemZreURxTGRQRGhRV1ZXckIwZVR0aEtJa2hGTjkvR1gvTndJb0Yx?=
 =?utf-8?B?di9Rc1lCWFRuRUNuRkVYbVlvS2hIWTZad1hRT29UeUlDM2tHRnFUQjNZNkh1?=
 =?utf-8?B?NjIrbHhjM0xVeGlROUk3b2xUVk92L0dzUlBreElUb0lNVVpsL2dIN1FoQ2U4?=
 =?utf-8?B?ZURIVDFPRUw0ZnYzbFJueHRnZUxidWJEb0k4OGhyVFBFdW0zVFVOSVVkU2kw?=
 =?utf-8?B?bUdoT2NrcEdVeG5DMGtjc0FrK2M4UENXNzNBcHh0OXpDOHlXeEdoaFhLNGxa?=
 =?utf-8?B?amUvRFErUUNaSGFpSW1ZWGVGdTl4YmprUGM1dko3Mk5DUGtvSElaZzJBUEg3?=
 =?utf-8?B?bWZib3ZUdS9hZ0FOQ01KYXF1ZW1vb2wvd1JOT2FqUnNuOUQveWhFdVpJZXFu?=
 =?utf-8?B?QWdTU09vNWpraUtGTWRydlJDUjRUd2ZHTk8wbUhRcGhUcms5MENsRmxVTDdX?=
 =?utf-8?B?bVBsNVRhcGxObjFvK3dwZkNtRWhhaTYyN2VmY2MvMG5uYmp6aE43ZTVNS3hx?=
 =?utf-8?B?MFY0ak1KcnFLcERuMGYxWG9Id2hhY1IzbUd4YnFCaTlvaUkwYThrZWEzTUlx?=
 =?utf-8?B?QXhZVGFKYnoxY2FsaTV2cUtVOHhyb3U0UE91cWJNWkdDSWVKazlzZUdsSTlJ?=
 =?utf-8?B?anAwN0ZucTZkaGdaTXNHVUUrM0sxVDZNR2pmNHN6N1BWWFlXcEZ4Tk9lcFRU?=
 =?utf-8?B?cm4yS3B0dzVjZnQxNmI4T0c4ZDVOYWpNRm40eHlpNFBJb1VRNG91THN2Zllx?=
 =?utf-8?B?RTBxL0RWbTJjNDlrdHAwK1VZMk56Z3VzTUNzZHNkRGxtcmxKNURlaW83dnVm?=
 =?utf-8?B?TWNyeEhjNWdNZkZtQjUyNENJTi9NOUNvV3E3N3NVbURGWEdEVVNkQ1JzSGM1?=
 =?utf-8?B?UTJzNXNhbXl4cUN1RlpnaTdzaU9tSlBFeHd1enhQdEpjM2tzSUdUbTdmcGlP?=
 =?utf-8?B?N3B1MTd5OFRpVzdDaDRJZkxtb04zdUhaQ1crSG1pRmxEUGNCRXpTTFl4djNS?=
 =?utf-8?Q?CnxwLz43WbiwdrZ8jWyvGgP4k?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94D08A79613DC14D8BDCC63C86BC7DDA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JQVTdVpfWA1D3eoMTexuFvKMNpdEmw718A/G/FNszyaipLhQXVdUDCAMSrDvD+JZvUzNAl4CYAO/VnV9vNFpe7PU2b4hiAr7aKm34WDNrRG9d8CQqZDlDz0ZgDFkEKiwTgKMH8No+nEpQHbj+lpmImBF26j/vmYGC7U2DkzvqqWgUDbnXk6+4VGxAZLZFBU4pKeBqLI1QEWxN1zM05HsBdpkPibVofk8UYxZYiR6FlmAru3kr+nEr5Wgm/kINeCp70IPRWw4ftYU0ANLc1VO1GatH//XuITvgHId2OneKDknx5fdUEjsbupxoO6JScFAxLlDReug7RhYL78PYFKdsl8QsY4ZcVqSU9/eJDImFTjbuM7hmxsxbVJmuRe7cuEXyxdU08hwcafKZbakjju1u+IAy1SiXe8Zx2h93+KTtFkOznI2C5DRNgtascQNaUC4YgppU7wkNfNRZS2NwbKypL/xyv59VOh6zIBWGzjzT9bK5j3RAyJp6riVtB1oUvHV8rGsbVsPMB1RTIOzlJze/bFrvkR9etUsJ4YqIKcUS8nCyRDT2X83p7ZhBAHagwz8jDEpGvAe+fvT7FRkzVvy+vrgeFuAcwPNVjTrhZWuGaicHKnrCkqlYIlKrI7x4rIl+Y9/xwqrNj3w1xd0XBDKzA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990d75b1-7887-4377-17d6-08dcd6dc2941
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 05:47:05.2608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRxUKMVKj5BgpVL5VHmDpoCN0UVg14O9o2g72slqrvYBZvCAfiUUD47tTDM//T5h1rxT+4X+Q6YikVXc32+97Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006
X-Authority-Analysis: v=2.4 cv=Q6WA4J2a c=1 sm=1 tr=0 ts=66e917e0 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=oXcl8_jr1CRkUtAwhVEA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: EDDZYMMM8LhmLcErmWfT7vTEx8PXvgb5
X-Proofpoint-ORIG-GUID: EDDZYMMM8LhmLcErmWfT7vTEx8PXvgb5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxlogscore=696 spamscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409170041

T24gVHVlLCBTZXAgMTcsIDIwMjQsIGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnIHdyb3RlOg0K
PiBPbiBNb24sIFNlcCAxNiwgMjAyNCBhdCAxMTowMDozMFBNICswMDAwLCBUaGluaCBOZ3V5ZW4g
d3JvdGU6DQo+ID4gT24gVHVlLCBTZXAgMTcsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3Rl
Og0KPiA+ID4gVGhpcyBjb21taXQgYWRkcmVzc2VzIGFuIGlzc3VlIHdoZXJlIGV2ZW50cyB3ZXJl
IGJlaW5nIHByb2Nlc3NlZCB3aGVuDQo+ID4gPiB0aGUgY29udHJvbGxlciB3YXMgaW4gYSBoYWx0
ZWQgc3RhdGUuIFRvIGZpeCB0aGlzIGlzc3VlIGJ5IHN0b3ANCj4gPiA+IHByb2Nlc3NpbmcgdGhl
IGV2ZW50cyBhcyB0aGUgZXZlbnQgY291bnQgd2FzIGNvbnNpZGVyZWQgc3RhbGUgb3INCj4gPiA+
IGludmFsaWQgd2hlbiB0aGUgY29udHJvbGxlciB3YXMgaGFsdGVkLg0KPiA+ID4gDQo+ID4gPiBG
aXhlczogZmM4YmI5MWJjODNlICgidXNiOiBkd2MzOiBpbXBsZW1lbnQgcnVudGltZSBQTSIpDQo+
ID4gPiBDYzogc3RhYmxlIDxzdGFibGVAa2VybmVsLm9yZz4NCj4gPiANCj4gPiBDaGVja3BhdGNo
IGRvZXNuJ3QgbGlrZSB0aGF0IGZvcm1hdC4gRml4IHRoZSBDYyBzdGFibGUgdGFnIHRvIGJlbG93
Og0KPiA+IA0KPiA+IENjOiBzdGFibGVAa2VybmVsLm9yZw0KPiANCj4gV2hhdD8gIFdoeT8gIFRo
YXQgc2hvdWxkIGJlIGZpbmUsIGV4YWN0bHkgd2hhdCBpcyB0aGUgd2FybmluZyB0aGF0IHRoaXMN
Cj4gZ2l2ZXM/ICBUaGF0IHNob3VsZCBiZSBmaW5lLCBhcyBpdCdzIHdoYXQgbXkgc2NyaXB0cyBw
dXQgaW50byBwYXRjaGVzDQo+IHRoYXQgSSBjcmVhdGUgOikNCj4gDQoNClRoaXMgaXMgd2hhdCBj
aGVja3BhdGNoIGNvbXBsYWluczoNCg0KV0FSTklORzpCQURfU1RBQkxFX0FERFJFU1NfU1RZTEU6
IEludmFsaWQgZW1haWwgZm9ybWF0IGZvciBzdGFibGU6ICdzdGFibGUgPHN0YWJsZUBrZXJuZWwu
b3JnPicsIHByZWZlciAnc3RhYmxlQGtlcm5lbC5vcmcnDQojMjM6IA0KQ2M6IHN0YWJsZSA8c3Rh
YmxlQGtlcm5lbC5vcmc+DQoNCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMCBjaGVja3Ms
IDcyIGxpbmVzIGNoZWNrZWQNCg0KQlIsDQpUaGluaA==

