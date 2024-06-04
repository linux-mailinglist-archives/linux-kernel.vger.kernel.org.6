Return-Path: <linux-kernel+bounces-201537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CDC8FBFB2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA9628A258
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E17914D45D;
	Tue,  4 Jun 2024 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ifFqKYgn";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="URqrO6Ah";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XDaZ9Lu6"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310DA82D98;
	Tue,  4 Jun 2024 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542833; cv=fail; b=KtZKje90Z+RFr5IFhn73J3WvMb3PX/9M8nsEqvnbR/hjoL9mt2Uz4/naHi2Fjl3+DVjEuOhxHOjRA3wXHYcXqD0wWLaBKP0Aif8M2s1cWCBdKiwDfN16GQZOhOjn1aT9X7BMPqo7wXNaH49dL6HnMgA1fUafU88ZVkfuWuJ8sds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542833; c=relaxed/simple;
	bh=+omfaitdgWFsQt7tM/HlfB1pvOPSdKRunHNtzcEK/NY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JsWr+nae7GH40Wvn0ECbLjGO/cB1pU21761O5iN3wmVsntBDTIdcrGTy7VLSJDuVK8qFIinI/Z1XvgexEZ8CJnNDhjiQ2XqgKfKlUWWlwky2XeATQOYukcV8yMeikYB1Maip82LGBfjeQ1G5J++izgFNmtK+NZVcqEnmKs34WVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ifFqKYgn; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=URqrO6Ah; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XDaZ9Lu6 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454LbUaq011613;
	Tue, 4 Jun 2024 16:13:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=+omfaitdgWFsQt7tM/HlfB1pvOPSdKRunHNtzcEK/NY=; b=
	ifFqKYgnLR7ttm7kMASRJFK/+15XMWOxMLzO9R+TJ1MKYrOXHm/9Ki7XmwGL1HEY
	a683/sqJBtCjsZLsJ6pq/Yj5sG+cmd1/YItSrSGFus7OI1MpTcDlqH/AoW4Qyhsn
	F6MT78ANqiRUHFQWgdHtLv5t0JYxDuIJ9ICe0RyhmJxyP585PtX+HTjeWnKvBQQW
	hz9Qd8nYdF0L91Lq3yLzMvq++8x+doEzr1eFUH33foohT+6JmOhLUPwX8G4CTfBz
	ImVKgDYY5uBh30nz1GOJPRWNh7qA+wt6fEUPGssMZLdfUx5IjVmUtlOrxdu1I+vM
	bq8AE2l1MykjdX0l8pYCPg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yg2w369yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 16:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1717542823; bh=+omfaitdgWFsQt7tM/HlfB1pvOPSdKRunHNtzcEK/NY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=URqrO6AhralzJV9wpVD4u/ICytS+GFT1ZYhtnUNs/p9ql7oRUNwM/6vk+ADQrepHF
	 h7G4cCImpuhIg6kyZOyInhCA3MDWT4XYy7hnRF2XtmDSDxxh52f0MT006z6qSCAArO
	 KCG2OMft+0iYHXl7gMKLfQaHsHE3UFjEKPjDLQ/2B4Rydlzuedq/Tw7J7oJnaySnxA
	 Pxain/t0mj1yAjKedYm+79kfaCbKDzB/pUxD0CaffHDPZpzjaHGafHS/EsrHDddW1w
	 3zuo+2cBB+ehl/bYOLU270Zm48HT8BEtxeaKR2TEdI8GYHOsQyqr5kt0hTBtyhU4EN
	 sZ7850ufE0hew==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 121734044C;
	Tue,  4 Jun 2024 23:13:43 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C26FDA007B;
	Tue,  4 Jun 2024 23:13:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=XDaZ9Lu6;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1D6384034F;
	Tue,  4 Jun 2024 23:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/706NUy/woFtsGc8Fmbapbxc4BvFMVY/2BaoWt41fLUgMi5/rhMeyuemjeSh9pYemGl+KQMR9tSrXOsBM5WUZvlt+GsWj6jTy3jmiO2log7hSaHZDnUqZ9fBXZKc3LSh9Axbm1kGq9ORiCpheAYaifzAk6Z5l7CYioG+J48gKkIId04McPwLg/Js+l2PfWA17NSfHBpnq/7Wg2Xp4ZzRFqbosHSJdXaAK0aKfd6J74Ukpl4wf79ZUiGWpSkg4QYGGVy3V1/mmYOLBjUjLNwa/+KxiyZ6HAcF1U9G9K2vFPVcO/61Qd3NPjByt1cqrRxY6UTHZ3nIelF8OHxblKhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+omfaitdgWFsQt7tM/HlfB1pvOPSdKRunHNtzcEK/NY=;
 b=ZwCsOvyVuqXmpD6Jpq9eobEcHkCtKxQ7FP+CSpUToeyfEPi/z5dSCzyf3HB/ghnhhDkNHZsxJcyOSRZSrMijzlwu5HxrVc9UN3mtpe4XwxuOCWn5laveg+wEDBrR4Lq+wuiosIyXhtQ1q2XAU4UlcWGodfCP3cicA1TGwV2NIXgAaWydoQOXze2u51O2ppmSfe7v+1YiOtWgVgWP9sZkwD3NK+wmZAGLhlPQfT8gIV5P348QYMZpLJRRbZmgMq7tzG+39zUqV8JruTk6zGgpvukDaAH1iZSm7mLJz7Av7VQ7yNAvKgX+G/hNnRQzaVmu2YjO/nfBWBrLvav4fjWhJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+omfaitdgWFsQt7tM/HlfB1pvOPSdKRunHNtzcEK/NY=;
 b=XDaZ9Lu6bqTOeK7sBY0jJHGqaqesIXLqVgdkg9kMkkT72g0gDr+Al0IfDV/JpROf3nBjGH9xEF3vZxJSahpxDqZ1nJ+ZHHBphh9TiunSe2xUupxdHpQpeTJXh14hu2UPUOUo593rJTuZwJd3/9arflstJfdHFcaI49TEiN0E4vE=
Received: from DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) by
 IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Tue, 4 Jun 2024 23:13:38 +0000
Received: from DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb]) by DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb%5]) with mapi id 15.20.7611.030; Tue, 4 Jun 2024
 23:13:38 +0000
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
Thread-Index: AQHatbZOP6V8cE1jeEGogZmaKJg11rG2uuOAgADiIoCAAKE0gA==
Date: Tue, 4 Jun 2024 23:13:38 +0000
Message-ID: <20240604231335.7hveikgyu4tjtcwf@synopsys.com>
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
x-ms-traffictypediagnostic: DS7PR12MB5984:EE_|IA0PR12MB7628:EE_
x-ms-office365-filtering-correlation-id: 496d0547-b4d5-48f2-b84f-08dc84ebf77f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dHZoWHJ1VkNZWFZuNEZ2Qkk0NFBMbERMYTVHVE02cGZrSklueXh2VWM2NWZG?=
 =?utf-8?B?bGd2dnI3UTRhOS8vY2lHb09RNGRrdktPVU0zTWNleTRsbmlKTWpjSzNENnMw?=
 =?utf-8?B?UkJlOFFtdzRqaDE4ZG12b1YvaEZoYXF5UTNmM0g5WHFibU9nR1BDTHl0a29I?=
 =?utf-8?B?MXlIdGpzT2FDYjVTZFNRN1JTcFROMFhEN3Axc2NSQkxRejA4YUczRkFRaXdN?=
 =?utf-8?B?NVVXa21nQXZFQnJlMVZYL2ZkV0IzNmlYSmV1NTN1ckFkUTFmUU0xWDZjN0xC?=
 =?utf-8?B?SEp4c2doQkpLRVVNdUw2clpreSs0RlFXbWsrSjhGYTcxUzVvT0NNQzE3SHBW?=
 =?utf-8?B?Y1h1cTJLS3hrN2ZrNGZLL0dkaEt3dWRZWkxPdFZRWW1HOE81Y3BTSlI0SGV6?=
 =?utf-8?B?b0swVm03VTZEbHl6NTltR1U4eGg3dHJDZnhvY1VlZ3Z1RENxaWRVZ01TZ2ZM?=
 =?utf-8?B?bVozT1M3YTh2L0VBWDBBKzBSbmJjb0xMQWpzKytGQ05idDBvNnN1czNnOTBT?=
 =?utf-8?B?VHRYMEZVaFkrV000bi9oTXpqVnhFNVhMRFUvNmtPWm81VkpkeUZENE1UT2VK?=
 =?utf-8?B?SlZESjI2UXdsN1N3bXJGY0E4WFczRWRyYlBaYm1yTzB6MFJUWDJwTGNhMitO?=
 =?utf-8?B?VTMwUVMzRklvcVdoemRWK3hTc2VkSDZmMGplMDRoM1FoMXllSGV3QlYxdFVk?=
 =?utf-8?B?U3J5MlEyTkF3N0lxQ1U1ZVFYOStWMmp1SHBCTS9SRy84Ti9naW50akRBS2Mx?=
 =?utf-8?B?WHZ5eEREOTZOYnpWZjF0THJHM3VBVEo5NkZZWnNqU2NyRlVxaEJUcGRabzVR?=
 =?utf-8?B?MXBxZzJGZUxvQnNsR2dYd0pSZ21QRnZCVmczMzJyUVQyR2Z1WUF4SG5OSVRB?=
 =?utf-8?B?aDlFMVAwaFY4NnNEc0lkMzRUWEpEY2tBOVJDWGtKd3R0YjdVWkdKWVh0U0JE?=
 =?utf-8?B?S3h4L3pyckZiMVlxSmJGUjd0WmRwaFB6bTB3T3JzTkZ5RHZDQ2FJZlBIc056?=
 =?utf-8?B?UjBhTW16MXF4bStvWUM0NVNOSEVrV3JGMjBtY0VnQ29vaTgybFBYbUtCeHVr?=
 =?utf-8?B?ekxCWjhxZ3FUaUVyK0ZnVzZwQVozMngzbnRLVWh2Z3BMSzhzNkR0SjJTRUg4?=
 =?utf-8?B?SjNMd1VUb2taU2R2MU9nMFVWYjFyYzNnS2VabFcxTFNsWnY5NEs2YTRKSVZy?=
 =?utf-8?B?aEErSTdWMXZLandwUVBSbEFueXBFUFI2OURIVHREVXJkRGN4S1FVbzJOZUF0?=
 =?utf-8?B?eWlhOFFUZWhtU0Z1enJ2eW9iS2lHMThmSnVWbVdkMjlYdjNWL0J0eldEZjJ1?=
 =?utf-8?B?eldsTmtic2phaVYxdzErbjVnOU1zS3NVQ1VrbDJuUE5jT2hCUHVOZXBELzlv?=
 =?utf-8?B?YmVhRmRYK1RpSnZ2aHM3dEI0eU9mc0JTRnluZk9QeFZNOWF5U0poSGNMSVhi?=
 =?utf-8?B?UndwNFd5N1JONVVpYmdkRDJFenJnS2NnK2Z3enJ6eFFORW1hU2pCSXM2VWtG?=
 =?utf-8?B?d1hIbnlDcTFCQTVkMnNPdUVTYVgrVENtUU5qTXZ1SXd6VGdWamVueEJJMjVm?=
 =?utf-8?B?WWpiOGtZV1hTTmlFcWpZUXc2Y1lZejZ5UzlUUk5WSVFEZzBVWE93ekVQd0xU?=
 =?utf-8?B?S1hmWFZ3UlhENVpoUUNldnVUQTBoSExBWWhlYnRNTVlYcFY5MGRhRC9FOHpo?=
 =?utf-8?B?aGNQcG16UVpqYUo4YjVha0piV3RnUTRvWFZYRUg2c2NkNDdwZ0JXKyszNmJ4?=
 =?utf-8?B?OUxaVGFDZUdPMUpYYlNoUlYyS2lCOG4wR1FwNFZNSHRmVWloRldtNVRLNUpi?=
 =?utf-8?B?R0l0OVhQa1ZtMEJZNlluZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5984.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RXNzQm5OVEE3a1FKaGFaNHRyU0xCUDMwV05OK2JNVEFoZWJiMGNYYmxLS3NM?=
 =?utf-8?B?azNPUzhvZ2xTWjdUemhSSUYyVmlBT2V5bFZYWlJJcnl6Nk40WjkzT1EvR2lx?=
 =?utf-8?B?bEh0ckdQazhJRzlIZGZMa2NNZldDbk51Q1FKUFk4Ly9EdFhiaWdYd2NXYnRV?=
 =?utf-8?B?dzBvTTQwN1ZSbktXK29ad3VJVU8vQ1JPKzhxRDFrbGN5V3VpYi90WnZyVStY?=
 =?utf-8?B?UkoxN09WbS82K3V3bzd6bERXcDJFNDNrWWluOTYvY0VZVmFvMVdEakNqTHVC?=
 =?utf-8?B?dldJdUxFbzY3NUdzYStJMXRZZS9DQ3JzZlErWXBxaGZuTG9wb0VtbkZvSm9n?=
 =?utf-8?B?Tk9vOXNPVjZuTFJRRTBUYTBNRHNvcjVHdkM2SmNEc2dBZmt4eXdwM2NLYzNY?=
 =?utf-8?B?dnFLelMyR0VoQUZpazMrRDhTam04VDBKRHp4dmp0Q3RGSVRhSDJROVNGVGJ4?=
 =?utf-8?B?Y2pQQWt1djhhOGY5SXQrbGUzRW1tM0pNNm1BUFNJUDhjQVFmTzZBQllqWUJ3?=
 =?utf-8?B?enNtREVxOHBVd01GZGNXWXhtL29qVWwxeTBFUVFEcXhQTEUzVGtkY3NkUnpv?=
 =?utf-8?B?MEdwNDZhbit6UHV5aCs5ejI4dUxpR3Y3Z292a2c0Y2FBTi9yYndvZmxHMk44?=
 =?utf-8?B?Qytobm9qdXVRRTNSWVlZN0dPdEZCd1FTays0WStXOUEvVG9NRU1iQVVYM2VE?=
 =?utf-8?B?ZUpjNHFJYVVKTjFxeHJZTEFRL3ZIdWt0L2NidHhCdEVKM1BsWlhtVlNueld2?=
 =?utf-8?B?cENYSW4rekIxRk5EWmJ2aG4vMEdZdzFPV201RHc3MVcvVUd3dTFUa1RTTHNs?=
 =?utf-8?B?bHk1a2g2a3RxcThuVkR2RElYdDdza0NEd3E1ZS95UHQzVjVoTGpFQzJ2ZEQ3?=
 =?utf-8?B?dFdPSG9yNGNreW5qVCsyL2dQSUs5ZklMQmxEZ2t5QzgxY251dmJGQUhWbnli?=
 =?utf-8?B?MHpud1V5WmhjVVhqME5qdk9jU0lxL0c2US9UeGV2YUd6L2JBL0pJaUFQUVhM?=
 =?utf-8?B?Y0pLMkUvRWxBSEJlZkNBK05Fem9PMlEvNDRZa1RzL0hUL2ErZzdhUXNROWZ5?=
 =?utf-8?B?ZHh3N0xoWWhrdnlIR280a1MzNGtSVVNJcWhPT0lYTTlpRWxEeW5yREQxWWhN?=
 =?utf-8?B?SS9hejVRTlpBcjFrbDU1amN5MkZwMlBRSkYyRGJOY21YbW1USmlZVDl1UVM3?=
 =?utf-8?B?UHRGOVNSQndsK09GaTBNWXA0T0ZlUG45cVk2YWYyd2pWRWZRNE8zVWtQby9a?=
 =?utf-8?B?bkZvODZqclhNVzBFVVRTTVMzSHNCbk9PL1pqWGs0R2FVakZrYkFVSFN5Zkdj?=
 =?utf-8?B?dEJ1YUxYalJSUWZ4NmV4UW5VM3hVcGpuV2xsb2VXNjJRQnNUUFlTQmJ4OHF3?=
 =?utf-8?B?eVRCRHFYR3FCLzVKRldlQU5TemFEK3NlVFdhczlPUjhTeXpaQXJEeG4wZUhV?=
 =?utf-8?B?RFVPTFpSRmtZSEh4RUtzWGtSZ2NNZElSOG0zVlhSbTBWUlRYbDg0eU14SFY2?=
 =?utf-8?B?Uk81RzJYMk1xLzFkY2lHMGZsTVhwUkt4dlNBYXJGSjBub09SSWpVVVdndXRY?=
 =?utf-8?B?OU1nVzJ4NGxTT1pDdWIwRnhiU1RIRStvVWgwNnBOU3hRK3Y2S0w5RzMxS2xq?=
 =?utf-8?B?ZU5GMlVCNnhaWEtQWE1uV1hHVWJzeGlnelcvNUJ6dU5mVDdWNDFYc24xRzJL?=
 =?utf-8?B?MU8zRGsxbEE3ZDlsWG80N2JzTHJ2NjFXVmZUQk44a1drb3g3TGhudW5jM2k4?=
 =?utf-8?B?b0FiajQxN1BHc29jNjJBbVFucGVtQVFoYU9XZ1FtdEFjQlR5NlZaY2hUQ3N2?=
 =?utf-8?B?NzhKWnJNcXRQcXljOFhaaFRDZGw4aVlodDNCTFBEZjhHaXpjWkpVcG96THRR?=
 =?utf-8?B?UHZYM3FKaFo1SjluMlNsNU45aXJCUnNOWWh5SlNkQ0U3UEU2eFkrL01CZzVN?=
 =?utf-8?B?TzhSQkdxMWZFd3FkWjhBMCtSOEZEVG1zelFZQkVERVJMRFhoZjBSRVNwM3cw?=
 =?utf-8?B?OVhNVlQwb3FrNzZ2cGlmNUF1eDlaczM3OFM0cFhQMWxLb3VQa2JYMjA2bnJX?=
 =?utf-8?B?eE52WXdoNWZQa3dycHRDYVlCWDg0Y29LTFUvTmNIa255UVBRREpFQ0xQVHFN?=
 =?utf-8?Q?cryYXpbNV1kF5mkqKD6fcxnTT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A046B45FEFCD254FA64D2A9F7AD47502@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iiyYQ6FEEjd87c/56x+zxwAjc9c0VCV8b0LD/UMVI6CNZVp6w8+LTLFAZuYBzkHqGyPQua1YmOKXAHCYgeYh29E8qxZp9H0n3U8gvV0Iw6BeKdu3igZyeL4L4G7r4O233xqsmGY2DUntEIOSv1wufMHP3GdJyS8tAros2lImY7YqUAh91q/g84iJ8nrZREhs4plPpVPM+B72oJeEZFQlzN/gQ73DJbzQcOQnbhUcAmQCnyVH/MOh1Kew9Yv1CGTUJNIsQ9k+fB+/tNgVj2ILceLwdmBVzjhC/70HzDie8F4aK/Qr1t+XMHacbT8CN2N5cC4V6WsEtAG/yh0mBcnjiabqY248YTZFKVbUlidSE1ohR9GhErGKc2qXg6E+9g/5zgs5u9VL7f9CEzYLS9i/FtgiZMacTF+DQ4MNBgiyuMrOveovNXxi9dlDjjXRFO4RM7O9oBdR2yu1n5lOv5Z7ReQsz2M2ts5aw1i6TfOxl8pq5XxVP6o0cUhx6lJcMQJqsB9udbuPqZOr5J4BZSH+wyyUAXFA73on5ZpbkkkhARXyvZi5WEzQ/kxrsvSSRsEG8l2jAQM5J8kgWu0JQ3Je8v895v6GWDOnTP3qiUWMrkamKTFPXFph/aZw35fAJLUT+2C+T/kR4eP7uWAt4O+Usw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5984.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496d0547-b4d5-48f2-b84f-08dc84ebf77f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 23:13:38.3807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEkm1BWJznnEZfZQawNDJAdW9g380DclB2HUDf/dJ0GTpf9rVw0+HnQLYQoNR6qfp7rQ8j0reQd24Eyfx+WiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628
X-Proofpoint-GUID: p8fVlu8DpnXvJlfoIDTutZoWWDMJdXpn
X-Proofpoint-ORIG-GUID: p8fVlu8DpnXvJlfoIDTutZoWWDMJdXpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=919 impostorscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406040188

T24gVHVlLCBKdW4gMDQsIDIwMjQsIGpvc3dhbmcgd3JvdGU6DQo+IE9uIFR1ZSwgSnVuIDQsIDIw
MjQgYXQgODowN+KAr0FNIFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBPbiBNb24sIEp1biAwMywgMjAyNCwgam9zd2FuZyB3cm90ZToNCj4g
PiA+IEZyb206IGpvc3dhbmcgPGpvc3dhbmdAbGVub3ZvLmNvbT4NCj4gPiA+DQo+ID4gPiBEV0Mz
MSB2ZXJzaW9uIDIuMDBhIGhhdmUgYW4gaXNzdWUgdGhhdCB3b3VsZCBjYXVzZQ0KPiA+ID4gYSBD
U1IgcmVhZCB0aW1lb3V0IFdoZW4gQ1NSIHJlYWQgY29pbmNpZGVzIHdpdGggUkFNDQo+ID4gPiBD
bG9jayBHYXRpbmcgRW50cnkuDQo+ID4NCj4gPiBEbyB5b3UgaGF2ZSB0aGUgU1RBUiBpc3N1ZSBu
dW1iZXI/DQo+ID4NCj4gVGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIGNvZGUuDQo+IFRoZSBTVEFS
IG51bWJlciBwcm92aWRlZCBieSBTeW5vcHN5cyBpcyA0ODQ2MTMyLg0KPiBQbGVhc2UgaGVscCBy
ZXZpZXcgZnVydGhlci4NCj4gDQoNCkknbGwgZ2V0IGJhY2sgb24gdGhpcy4gUGxlYXNlIGFsc28g
cHJvdmlkZSB0aGUgU1RBUiBmb3IgdGhlIG90aGVyIGNhc2UuDQoNClRoYW5rcywNClRoaW5o

