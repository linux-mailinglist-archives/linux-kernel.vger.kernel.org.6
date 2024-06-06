Return-Path: <linux-kernel+bounces-203499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B420C8FDC25
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FEB2850F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707C15491;
	Thu,  6 Jun 2024 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eXYptMXT";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AUKMVtud";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MySezRTc"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9593E4437;
	Thu,  6 Jun 2024 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717637412; cv=fail; b=mklP7xh1RDNooVrZ7TWwHClJB5Yt/1piotg1adkbA/6yMaOGQ0tdXZKO6IJQOV6K0T5hYaOqQBYn9/9wgwzmrRn7f6pn9+fwYKrHV7H2WCLc9RSn6TpW5eUmAJsCnaLvK2j+JhWZa4n6Jr6hAOfmS9veDux15IhAXNSHBXO+iQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717637412; c=relaxed/simple;
	bh=XVVQssUy1j24qDiNwVoNewo4uzuUe5wBXdTVYSYRIbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t8Md72X+Yc3TwX+nFQbfrV2aFqnWe4I0PmpQDDHkqf8hzZ4M+nFUta+/hNKP0IOKCF1QEVy9ciyn7eZEIjP2MnCol43C+YVjA/23tG1un57bWPCqNYS9n4Wj0fShVMj4RiKo6VIUjH1zPhjIh3eV7JgenNFxzAcT0fEuzPPIJbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eXYptMXT; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AUKMVtud; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MySezRTc reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455M4DM6030865;
	Wed, 5 Jun 2024 18:29:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=XVVQssUy1j24qDiNwVoNewo4uzuUe5wBXdTVYSYRIbQ=; b=
	eXYptMXTDxiT0oc7oXFTWGDHxpBHsUp7vjCC+1K2WIxAojcRrU9wvOOrP1BHFhM5
	2oytVJ7ihLuHKu08cegq3A3wCFTN9Bik3QuNWxBzc1Nu1RQFclt1va4R6W93nIqY
	IofQp9szzHZntW6H3/G9WuHHn4gz9YtI6Xk9DZ66+ICQ8YW2g2G+QQyhihf49SEm
	JH+UGEsMjZubmSIcBQn8J+XLbcjM8AvIRnh72uCjA6OitGdB647Jym2WOArnjykQ
	NBqoAvCe8GVmr7vSQVDqiEMSETa86ISRZkihoLL2M+7qFSOqiG3MYZeZwqEO718V
	ob8mbXhZ0Rhl0sbtjuJ3DA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yg2jsbw9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 18:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1717637390; bh=XVVQssUy1j24qDiNwVoNewo4uzuUe5wBXdTVYSYRIbQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AUKMVtudPYOGSAuTgo+WHVNNLF7RUe91W6jaalyjJlWQiv6pP3qbMalSYPAwEsMA4
	 REX8rTmeS3sCsX8HAN72JZKErXQ1hVjpJVnpykT4KcngnL2HgcinIi1B1Unu7iur03
	 E2LljtyN6tuNfaJwSoPLtui3z3S2t8+ExELvm8+PSUK9Ea4UIsbcUfmtH0T219VvHQ
	 l6YHevOiOf+bpZNg3p51Ws4zyM5Xy+XH/EN1VGymPk2wG4LTzZsL878e8n3C8rZ5pn
	 LyHUCGToEEbCWUAQZVTJAS/HKoRIoFneyMYc+oR8YSSlwgFgmKUpgSP5HOzWKqj24/
	 09o6yg4rWf2fQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5A35F40349;
	Thu,  6 Jun 2024 01:29:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DDBC1A009A;
	Thu,  6 Jun 2024 01:29:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=MySezRTc;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 39F3440524;
	Thu,  6 Jun 2024 01:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVHjblpI8cYR4SfrV5Q1xMIwI+zo08qLSUYNt5H9PLxca3wIS2lficsV1KIfUW09s+maYASSXy+zIgmDqvnZ+AWXw63klM9Rn1peyfdP4+JPe/I+/hPD/LpDfE4iKJBEmTxbIJTtOLctjXLxcC51nUgPhqsVyxqPKvQqiRSImkbtAEyyb9w896yowgZ3MJhEG1Njxp1K2ichhI5TdxhLJuLk+G0WEFVYuIXfRc2kAuj/Iaygy+2Cd0XIHveLOIZrYMrMIVR6xyHUsJw2rZGIG2TABkH2CPYybyelI+RUY//0fhfoUB30dCxEcXWC8e7IlX8oCf9BpD+1YeLXIcQQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVVQssUy1j24qDiNwVoNewo4uzuUe5wBXdTVYSYRIbQ=;
 b=f9hd/cu9OSpcAGkEyKpFOFuRSVwnsi2oMLGszvhNFmST27ubHlDdXwmyOxiaqBmmonKljfuMfO+hcK/AZb2389VGmHqvQcQwCSfEa3oz2FtvznL0mwgeUtXizm/t92Yfb7G/cn88F5kWpejFVsIHaMW7Azn3/U3neZb+zMlZ/YfudQrazud9f5TTSLbFrO/PHbl6cV845RDlf2v5rgcXRN6J9867H7OkhY96vHWiKd7JpZRU9XNsUagygeipTku27CVOc5VdVjuUCOZKJmQmbcssW3+Iwyt8VXch3IV17cJedGC/Gs/aSN2UWO4e6mMqrqRJoAuRZSJtAQfgfiX/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVVQssUy1j24qDiNwVoNewo4uzuUe5wBXdTVYSYRIbQ=;
 b=MySezRTcsvnUSaz4LF+Gma1dTeP9l9G+CwsFEfLpEpKmj4jmyei3nflrJPMXq2qTX4Gzwnw9ZSrHynE4XIIctAUyHGlvoYbQF2PEn156cWa9M/rjl8lxezulK2oapezBXm/VoBS+aAZhtlDsJ3kCbqRJNbRpKgFO9MR7BrnjZ0k=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 01:29:43 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 01:29:43 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: joswang <joswang1221@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        joswang <joswang@lenovo.com>
Subject: Re: [PATCH v2, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Thread-Topic: [PATCH v2, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Thread-Index: AQHatbZOP6V8cE1jeEGogZmaKJg11rG2uuOAgADiIoCAAlmJAA==
Date: Thu, 6 Jun 2024 01:29:42 +0000
Message-ID: <20240606012936.jdokepv73qrdorbp@synopsys.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240603130219.25825-1-joswang1221@gmail.com>
 <20240604000715.3rlmzxriof6wwksm@synopsys.com>
 <CAMtoTm3XnPr8DY9qPW0X0+aayu_7CWrC1od8qKqU3S2wRjMi1Q@mail.gmail.com>
In-Reply-To: 
 <CAMtoTm3XnPr8DY9qPW0X0+aayu_7CWrC1od8qKqU3S2wRjMi1Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CYXPR12MB9442:EE_
x-ms-office365-filtering-correlation-id: 833f318d-68ff-46fb-889d-08dc85c8244f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?a0pKL3Eyb1kwU1VyT25Da0J0OENDTjNaS1ljc3M3YWJEckxvd1Y0VlVlUmxu?=
 =?utf-8?B?Qi91VzRkbUMveEE2S2JQVDZ2WGpqdE93dk5TL1lBam9KS0pCS1hPb2U0N2pO?=
 =?utf-8?B?WXRyRjNiUUZNOUxzYmZIVUt4dEp1ejhwNzNsTVdEencrTGFZbmtmOXprYW53?=
 =?utf-8?B?ZWtGcjRSNVd2eEM3ZlFNMFpPeC9ybTdKbTVjY1FXT2p5VlZpTEN5L0lRYVJS?=
 =?utf-8?B?WWZYRFFhMTR2TXA4TVRHUmxBVFNFWkRLN25EQVE0RExUL3plQUd3N0hSNlF0?=
 =?utf-8?B?ckIwQ3pUMnF4WDh2amlYUmU0TWdHTVAvQzRNWlljeHdlM1p6L3h0ZnpOcHVN?=
 =?utf-8?B?Q1hWeCtVaXp1UGxPVXkxMjlMYldnak44V045eTlWeVFuaGdkUDF6d1oyUzVw?=
 =?utf-8?B?RzVPUkVRcHJ3K1ZVNmxFZXY4MFBKcjlJaXNMcnNreGJmbkh4SlRwbUxwc1dT?=
 =?utf-8?B?dGZrYXNEd0R4WEZXRm1OTURqUk5jb3ZHUnpWUzNLaEhrdDNHa3ZzbEJIWDlS?=
 =?utf-8?B?VWZGb0krM2pOaFNnbnN4U0czazZseWlvME9BcmxGcGNGRGV5YllYZGZHdFlZ?=
 =?utf-8?B?UWVQSGZBeUs1U0xnR3BQVCtYeWJqT2FZbjlrbTF1Z3RiVDhJYk4yL3RkVDJB?=
 =?utf-8?B?L3k4Mmg1YjFuTTRiQkpUMnhhNFo3T0N3OUg3VXhEQ1FCUEFXMU5aNVJNUU1X?=
 =?utf-8?B?UEEvZTVHNnhCbnpNV2tXdUhEV2lVNVFmRnpsUndCL2R0S2VETHZQN3lvVll1?=
 =?utf-8?B?cG5SKzArTTRXZHdOVEE2MmRKOUJlTXZWYUpScE1vUmRXazY3L1dOWXBNWDVr?=
 =?utf-8?B?NDZUWGZNVTM5UFJrNGQrQkxyczV6UnRVOEhRTGdjR2VkNENVbkFjYjBmS0xJ?=
 =?utf-8?B?OVQ4RVBzamZBL0ZZdW1aV0FRU3NOSEZMaE85NHVQbXFOTTJHQ3dlUTc1cElU?=
 =?utf-8?B?bzIvWmxFbXZ3MWtOUGp0b3hoaW9rQ2RNWksyazYrNXI2aGNXZDU4c1dVSHBB?=
 =?utf-8?B?eHYzR2t1b0RhYzdGUTZ0aXdUYXlLcytvZ0IwS1ZxMDFYUFBuMWVJT254YWxu?=
 =?utf-8?B?elBHMlFHSjIzUHFuRzVjQTBTWHV6cU5OL0FzNmZtbFRsY1dYSjlackh0S285?=
 =?utf-8?B?dDFPWmY0NTI0cUhhaUY0eTFwM2R6OWRoNjVuaFJyRVFTVUhEcUlieEw4RTNj?=
 =?utf-8?B?Z1cxWHh5bGVDTTA2VWhKdEsxNSt2QVpXSHNZbk5MUkYxaXdRQWl2Z0tBeVB6?=
 =?utf-8?B?SGRMcWE1eFNGRUs2a1RFSC9lckl0WFJJVkNXY3pzcVlTVzFrbElseE1ITmJl?=
 =?utf-8?B?Zy9JRTVxTHZqbFRUbVRXc2hScCtDeE1CNlREUWpuenpQVGNNTkdaMlMyUG5p?=
 =?utf-8?B?a0VEQzVsWnhPcEJlTUVXb1AzaDYzZU04Q3NzSFY3ZkR3RTlzV21ReXp6MnU0?=
 =?utf-8?B?VThpU0RmUkRhTUQ4bGZNMzdOcGUyL3Y2WFpUWWZxQWUybHorc0l1aWxxTEx5?=
 =?utf-8?B?SitaRzd6S3JJdm52bXowZG5nSlVsaFllS0hYb29GVS9UZ2dzbDFwUVFoR1VQ?=
 =?utf-8?B?VjliWHQ4bGJ0Mk51bUhTUGRMelN4VUo2d3FlbzduckV0dk1yTzFQa3pEZlU4?=
 =?utf-8?B?MU4vY3J4aG5tdjZGVnVZZGEzOFkxckROZWdSYkZ2eG15WFkrL2hlNSs1RkIy?=
 =?utf-8?B?ekRwRlI0YXBWeEpqMnV2MnB4cjJqUEJVcVRNZzlMTUVUMTkxNnpRYlJZSkUz?=
 =?utf-8?B?YmJtRWVJVDhNQWdIOUMxMlQ5bjN4ZVhSS1cyUnZYUzgyMzV5UVJzTTdPMkp5?=
 =?utf-8?B?QmpmNzNLNDdpamxaL3Zwdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YWNaVTNDR01xdDdWZERvNjRoaWtxcitYcjkxUlNMNWs4M1VMTnAvQU5UVkgy?=
 =?utf-8?B?bHZ0RGFPU1FoZjc4YkFvMnJRSC8zOVJ0UVNFbk1IQXNIVmRERkhUbFVmRXFB?=
 =?utf-8?B?bGg0ditUcEVqOTcwelp2NHlOZXg4TlFVaGlXSjNjY0t1K1k5bHpWci9FL2Jv?=
 =?utf-8?B?VmlXOCtyUlZPUlJBZDg0QzJFMFN5MHZrdWJWRVAycFZidkp2blBmR3JtdFdi?=
 =?utf-8?B?dWNGQS9VY0U4aUh6bjV2ekI2TS9ncmk1K3JNeVQ3b2xGcWo1dWpYbkdQcW1D?=
 =?utf-8?B?QWl5dmRPRTNXK2tZWGkrVVFtOTNuOE9MeTY2R2E3bXNiZlNnOCtoMXBRRk5n?=
 =?utf-8?B?bCtBQzdqSFhzNjNSaWlRM2VxMU9OQ1hxNnhja1RxWkRaVWxBc1VUaUdvMmxX?=
 =?utf-8?B?K09sVUhubmxEWDZEZUVFd1FBNklwbnlUWDZXdjY2T1o0MW5DUTV3Z1NjZllj?=
 =?utf-8?B?YnpFTTNJWm5GNjNZN1BaeExZbUxrOGRQMmNiVGhKd29rWnF4dVl4QUFZdG9w?=
 =?utf-8?B?MDdoamdkQmpVUXJ6SWJ6aE9hWWVCcHdrZlRySEZocDJ1Z3crTVIvMnEyNmR5?=
 =?utf-8?B?Y2d6ZXBqMEtNU2UyeXVhc2d1SVRwQksxQ0VCUkxWNjE5d2JKQzN0eXZ4R1NQ?=
 =?utf-8?B?WllvUlF4SU9hWVdzOUQvMzRpckJ2RytWRDJrSCtEeFJpTm5OR0lCM1hLU3dY?=
 =?utf-8?B?SWNESDNBU1VueXl0R05jS2JDd0dUZzFpOG5FUmFOdUZiVnQxT0hlNG1vdXAy?=
 =?utf-8?B?cnVqa1NMRUozZzFWelNqRzFWL05VaFJMSzg0YzFtbVRBOHhPdS9ackIvdGhv?=
 =?utf-8?B?dk5hWDdSVGFmUHZKTkpITStBU2UxY1E3V0phUnluTFpMYmo3dkhMNEpCVURP?=
 =?utf-8?B?UTV6R2JuQndSbnJGbWNZWTdRZG5Nb1I3bXlwSkVzY1ZwaEt1RVlwdGM5Q3Bi?=
 =?utf-8?B?UXplY3hqbW9ZUmlRazBPSUwvbFUveEkyK2FQaVp5STVNOVE5OG0yZktwS1dF?=
 =?utf-8?B?a294dFEzMmd6VmFrc3dWNE1tWTJxY2RXdTRTaEtUL2dzYUVyVXloaHFRRTgw?=
 =?utf-8?B?TDRsSVZNa0t6a010bHZIUFE1SzBXcmljZVQzalNiY0doUTdKdWtQVXIzajF3?=
 =?utf-8?B?N3A3K2V2Tk9MYVJOeWxhaE8vSkdOWUlWSG8vSlAvdXpVTExjVDE1dW0yanZC?=
 =?utf-8?B?eXlZRXFWT3dYckgvWkVEZXlWU3FVZmJpMTllUWFTSy9pUEc3ZWRlQzFydGYy?=
 =?utf-8?B?U2kxOVNsUUNXNmF5aEwwNk14dG43TlhhTGRaemJBNGdlUjErcFZUUFpvRXZB?=
 =?utf-8?B?U1BNd0c4R0tHWVhabUFUanUwdy9paDFrSGMraG0zZmx6aXZDdWJCVkpSclYy?=
 =?utf-8?B?N2QzN2VkSFUzTnB2REVPVzBDYjluSjREQ1ovSTB4akVSMFFnYThkdVhvUENM?=
 =?utf-8?B?cGlpSDV3ZEtUQnRLQ0tUT3VLMnZ5dGZIY2lrT1dIRjZLUHM5QWRYYi9oZWhx?=
 =?utf-8?B?Nm1uKytDdmticm1uTFFJc29tZFBPMFBGQjFqMTFEM2Rkajk1TGhKSUpTTG5O?=
 =?utf-8?B?TDU1R3haUDFXakc4aTJoSUFmZVU2cEtjRXNjaG9CYnhnL3FuVmlKeXFSOGc0?=
 =?utf-8?B?TGtva2NFYmx5UW52bHZNL1BjUFRRUThiNG9ib01BeVlobXFTTXhIbThGUUIy?=
 =?utf-8?B?NU0wYnVyUDB0SjNYZDlRdzhKYVQwUENFSEd3c1EyMVRlbERJN2ROUkFlZHJP?=
 =?utf-8?B?SzhnMzdPMVJTakI2eWtwbm9zQU9QTmhUdVFpNzdsK1B5WERSdjJOb01jbXhx?=
 =?utf-8?B?QXhQbHhwSXVHUHdaN210MHkyTUMzc0IwMW1NVUhucy8wMU5Gc2ZxMFdCV2FZ?=
 =?utf-8?B?c3FDeTE5ZVRSdFNGWjhLL0hRczF6djFqOGQ4TXhiKzBpcnROazNmK3dJb1ZX?=
 =?utf-8?B?aUpid2lUV3NJVmRTK0E0UUtVZng5VlB3ZmlRQUdXZy91S01kMEdZVWZXR2ZX?=
 =?utf-8?B?VzJpdTNWTWdVeUJaWUJKMHQ4a2lJUUVrTEdvcCtuUnUzbHh3ZEZJT0pTYkts?=
 =?utf-8?B?N2krYk9ONjNXNDJsK3YxSGkycDV1RVNFaThMR0NTUS9MV3JMWS9mcXJlOE1n?=
 =?utf-8?Q?IQKI5pGx1Dbv4AoZZk02+mVVJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E854794355E7B46A2BD4B87D262692A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bZHGTSrMbLX1ERU0s4TtBmT5iDQv6XIlLbZZfMGQ+Ygfo72zusBmnTmCXT4KdGHPYeQwqcYQjH+Fi0O0tjkCOm6wApZS8tsJ1iPtVgwciRAdxqnSfL5/q6EtVFKLhqy5DWZyBPSjnS7tpTMh5kYqcHPC5Ff/m4k7fiATLKJRi1HtbTCC0vw+35ktya5dCbOmdWc243YajXb5Q4ML3UXWvNZg9d1q8w7HgOCy5oE0izLHxYdkgWbBufe4J86fqnEHcrRsQ5uQgD7Sc23cAn3hRWKs0KAZ2ICgKz7ZGC69GVZQ/WkP8XPSQVnwDtLyui3yZFK3yLRcIrEkQ251dLmMqUgzJktG32q02xyWCQxMBMEcLnLWG1sL6+PW+i3N6oBW2UIZNsHVgbO3mF7WJhaEOmeeAnbbpg/NuTzLzjbKXxlpRSLJIkzfm1dQdIF21ILbWfCywd+RbY6qVdWzt8NydUPjNFk9vVSjgIbEXXLhVOGPIInFBUqQmbNux6mfuw01KXzqHIcpdkAKQGOzES0oQsOsrd4H4vNKb06Lcah8rinpxGrWQXHSsSusHCY8053oRlJXB571oAK49z6ahKLhCbx+ItvAbjl5pJadgiUzs4XFzsaYFp8VQbvavd7e8DaJplrumK/jntPQS3ckfg0cHw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833f318d-68ff-46fb-889d-08dc85c8244f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 01:29:42.8732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Wfp7lpWlLv+CqMYXandL/ZbuIu0Or3PLCh2PnC8iNu1MxziLfjK2CFNW7XDDBNUG8T9AqkB7/Og25qaS2VFkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442
X-Proofpoint-GUID: 6QjoDQ78iDfX49vzDh1V2BHkC64ejqnZ
X-Proofpoint-ORIG-GUID: 6QjoDQ78iDfX49vzDh1V2BHkC64ejqnZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_08,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406060010

T24gVHVlLCBKdW4gMDQsIDIwMjQsIGpvc3dhbmcgd3JvdGU6DQo+IE9uIFR1ZSwgSnVuIDQsIDIw
MjQgYXQgODowN+KAr0FNIFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBPbiBNb24sIEp1biAwMywgMjAyNCwgam9zd2FuZyB3cm90ZToNCj4g
PiA+IEZyb206IGpvc3dhbmcgPGpvc3dhbmdAbGVub3ZvLmNvbT4NCj4gPiA+DQo+ID4gPiBEV0Mz
MSB2ZXJzaW9uIDIuMDBhIGhhdmUgYW4gaXNzdWUgdGhhdCB3b3VsZCBjYXVzZQ0KPiA+ID4gYSBD
U1IgcmVhZCB0aW1lb3V0IFdoZW4gQ1NSIHJlYWQgY29pbmNpZGVzIHdpdGggUkFNDQo+ID4gPiBD
bG9jayBHYXRpbmcgRW50cnkuDQo+ID4NCj4gPiBEbyB5b3UgaGF2ZSB0aGUgU1RBUiBpc3N1ZSBu
dW1iZXI/DQo+ID4NCj4gVGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIGNvZGUuDQo+IFRoZSBTVEFS
IG51bWJlciBwcm92aWRlZCBieSBTeW5vcHN5cyBpcyA0ODQ2MTMyLg0KPiBQbGVhc2UgaGVscCBy
ZXZpZXcgZnVydGhlci4NCg0KSSd2ZSBjb25maXJtZWQgaW50ZXJuYWxseS4gQXMgeW91IGhhdmUg
bm90ZWQsIHRoaXMgYXBwbGllcyB0byBEV0NfdXNiMzENCnYyLjAwYSBmb3IgaG9zdCBtb2RlIG9u
bHkgYW5kIERSRCBtb2RlIG9wZXJhdGluZyBhcyBob3N0Lg0KDQo+IA0KPiA+ID4NCj4gPiA+IFRo
aXMgd29ya2Fyb3VuZCBzb2x1dGlvbiBkaXNhYmxlIENsb2NrIEdhdGluZywgc2FjcmlmaWNpbmcN
Cj4gPiA+IHBvd2VyIGNvbnN1bXB0aW9uIGZvciBub3JtYWwgb3BlcmF0aW9uLg0KPiA+ID4NCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IGpvc3dhbmcgPGpvc3dhbmdAbGVub3ZvLmNvbT4NCj4gPiA+IC0t
LQ0KPiA+ID4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMjMgKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jDQo+ID4gPiBpbmRleCAzYThmYmMyZDZiOTkuLjFkZjg1YzUwNWM5ZSAxMDA2NDQN
Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gQEAgLTk3OCwxMSArOTc4LDIyIEBAIHN0YXRpYyB2b2lk
IGR3YzNfY29yZV9zZXR1cF9nbG9iYWxfY29udHJvbChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4g
ICAgICAgICAgICAgICAgKg0KPiA+ID4gICAgICAgICAgICAgICAgKiBTVEFSIzkwMDA1ODgzNzU6
IENsb2NrIEdhdGluZywgU09GIElzc3VlcyB3aGVuIHJlZl9jbGstQmFzZWQNCj4gPiA+ICAgICAg
ICAgICAgICAgICogU09GL0lUUCBNb2RlIFVzZWQNCg0KU2luY2UgdGhlcmUncyBhbm90aGVyIFNU
QVIsIGxldCdzIHNwbGl0IHRoZSBpZi1lbHNlIGNhc2Ugc2VwYXJhdGVseSBhbmQNCnByb3ZpZGUg
dGhlIGNvbW1lbnRzIHNlcGFyYXRlbHkuDQoNCj4gPiA+ICsgICAgICAgICAgICAgICoNCj4gPiA+
ICsgICAgICAgICAgICAgICogV09SS0FST1VORDogRFdDMzEgdmVyc2lvbiAyLjAwYSBoYXZlIGFu
IGlzc3VlIHRoYXQgd291bGQNCg0KQ2FuIHdlIHVzZSB0aGUgZnVsbCBuYW1lIERXQ191c2IzMSBp
bnN0ZWFkIG9mIERXQzMxLg0KDQo+ID4gPiArICAgICAgICAgICAgICAqIGNhdXNlIGEgQ1NSIHJl
YWQgdGltZW91dCBXaGVuIENTUiByZWFkIGNvaW5jaWRlcyB3aXRoIFJBTQ0KPiA+ID4gKyAgICAg
ICAgICAgICAgKiBDbG9jayBHYXRpbmcgRW50cnkuDQo+ID4gPiArICAgICAgICAgICAgICAqDQo+
ID4gPiArICAgICAgICAgICAgICAqIFRoaXMgd29ya2Fyb3VuZCBzb2x1dGlvbiBkaXNhYmxlIENs
b2NrIEdhdGluZywgc2FjcmlmaWNpbmcNCj4gPiA+ICsgICAgICAgICAgICAgICogcG93ZXIgY29u
c3VtcHRpb24gZm9yIG5vcm1hbCBvcGVyYXRpb24uDQo+ID4gPiAgICAgICAgICAgICAgICAqLw0K
PiA+ID4gICAgICAgICAgICAgICBpZiAoKGR3Yy0+ZHJfbW9kZSA9PSBVU0JfRFJfTU9ERV9IT1NU
IHx8DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkd2MtPmRyX21vZGUgPT0g
VVNCX0RSX01PREVfT1RHKSAmJg0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
RFdDM19WRVJfSVNfV0lUSElOKERXQzMsIDIxMEEsIDI1MEEpKQ0KPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgIHJlZyB8PSBEV0MzX0dDVExfRFNCTENMS0dUTkcgfCBEV0MzX0dDVExfU09GSVRQ
U1lOQzsNCj4gPiA+ICsgICAgICAgICAgICAgZWxzZSBpZiAoKGR3Yy0+ZHJfbW9kZSA9PSBVU0Jf
RFJfTU9ERV9IT1NUIHx8DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkd2Mt
PmRyX21vZGUgPT0gVVNCX0RSX01PREVfT1RHKSAmJg0KDQpUaGVyZSdzIG5vIE9URyBtb2RlIGZv
ciBEV0NfdXNiMzEuIExldCdzIGVuYWJsZSB0aGlzIHdvcmthcm91bmQgaWYgdGhlDQpIVyBtb2Rl
IGlzIG5vdCBEV0NfR0hXUEFSQU1TMF9NT0RFX0dBREdFVC4NCg0KPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRFdDM19WRVJfSVMoRFdDMzEsIDIwMEEpKQ0KPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIHJlZyB8PSBEV0MzX0dDVExfRFNCTENMS0dUTkc7DQo+ID4gPiAgICAg
ICAgICAgICAgIGVsc2UNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICByZWcgJj0gfkRXQzNf
R0NUTF9EU0JMQ0xLR1RORzsNCj4gPiA+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiBAQCAt
OTkyLDYgKzEwMDMsMTggQEAgc3RhdGljIHZvaWQgZHdjM19jb3JlX3NldHVwX2dsb2JhbF9jb250
cm9sKHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gPiAgICAgICAgICAgICAgICAqIHdpbGwgd29yay4g
RGV2aWNlLW1vZGUgaGliZXJuYXRpb24gaXMgbm90IHlldCBpbXBsZW1lbnRlZC4NCj4gPiA+ICAg
ICAgICAgICAgICAgICovDQo+ID4gPiAgICAgICAgICAgICAgIHJlZyB8PSBEV0MzX0dDVExfR0JM
SElCRVJOQVRJT05FTjsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgICAgICAgLyoNCj4gPiA+ICsg
ICAgICAgICAgICAgICogV09SS0FST1VORDogRFdDMzEgdmVyc2lvbiAyLjAwYSBoYXZlIGFuIGlz
c3VlIHRoYXQgd291bGQNCj4gPiA+ICsgICAgICAgICAgICAgICogY2F1c2UgYSBDU1IgcmVhZCB0
aW1lb3V0IFdoZW4gQ1NSIHJlYWQgY29pbmNpZGVzIHdpdGggUkFNDQo+ID4gPiArICAgICAgICAg
ICAgICAqIENsb2NrIEdhdGluZyBFbnRyeS4NCj4gPiA+ICsgICAgICAgICAgICAgICoNCj4gPiA+
ICsgICAgICAgICAgICAgICogVGhpcyB3b3JrYXJvdW5kIHNvbHV0aW9uIGRpc2FibGUgQ2xvY2sg
R2F0aW5nLCBzYWNyaWZpY2luZw0KPiA+ID4gKyAgICAgICAgICAgICAgKiBwb3dlciBjb25zdW1w
dGlvbiBmb3Igbm9ybWFsIG9wZXJhdGlvbi4NCj4gPiA+ICsgICAgICAgICAgICAgICovDQo+ID4g
PiArICAgICAgICAgICAgIGlmICgoZHdjLT5kcl9tb2RlID09IFVTQl9EUl9NT0RFX0hPU1QgfHwN
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICBkd2MtPmRyX21vZGUgPT0gVVNCX0RSX01PREVfT1RH
KSAmJiBEV0MzX1ZFUl9JUyhEV0MzMSwgMjAwQSkpDQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgcmVnIHw9IERXQzNfR0NUTF9EU0JMQ0xLR1RORzsNCj4gPiA+ICAgICAgICAgICAgICAgYnJl
YWs7DQo+ID4gPiAgICAgICBkZWZhdWx0Og0KPiA+ID4gICAgICAgICAgICAgICAvKiBub3RoaW5n
ICovDQo+ID4gPiAtLQ0KPiA+ID4gMi4xNy4xDQo+ID4gPg0KPiA+DQoNCldlIGhhdmUgdGhlIHNh
bWUgY2hlY2tzIGFuZCBjb21tZW50cyBoZXJlLiBDYW4gd2UgcmVmYWN0b3I/DQpQZXJoYXBzIHNv
bWV0aGluZyB0aGlzPw0KDQpwb3dlcl9vcHQgPSBEV0MzX0dIV1BBUkFNUzFfRU5fUFdST1BUKGR3
Yy0+aHdwYXJhbXMuaHdwYXJhbXMxKTsNCnN3aXRjaCAocG93ZXJfb3B0KSB7DQogICAgLi4uDQp9
DQoNCi8qDQogKiA8Y29tbWVudD4NCiAqLw0KaWYgKHBvd2VyX29wdCAhPSBEV0MzX0dIV1BBUkFN
UzFfRU5fUFdST1BUX05PKSB7DQp9DQoNCg0KVGhhbmtzLA0KVGhpbmg=

