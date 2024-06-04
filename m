Return-Path: <linux-kernel+bounces-199853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 590B38FA6B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CFF285F18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111D7611B;
	Tue,  4 Jun 2024 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VsN3F3WT";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Wv9npmb4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XHt/lr6T"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F48D10F1;
	Tue,  4 Jun 2024 00:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717459352; cv=fail; b=NPhUaQDeMqekFTQaZ6qYLY1tilKcYBHygiARYN8Q/pCbVCHFz2ULhJY8b+c+YboV6ilMwOW9L5D8zWNkfrkf1JmfqJj0mLTKBgAaQh8gV77nfZN2i+j+FirdfF+Ff7Oz5SfEJpZB3rCSlzB+xNs4bVTdJTyQgROT1k1ui+KIetc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717459352; c=relaxed/simple;
	bh=8pjwMebQYGusZ3/BzMnxQYbb1vb8ujX/tAVGIcRYyb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hg3Ir97HGNzGpzVJj1y5wBnMdsFIx0tSDi887gN+I9KTh4uhzeJJWBvx7aEEsd7vldBJ2rCkUBbehSrykd3sEXhPf5Y5LQUhU0GOw81MMMzEqu1dXCPl1LL9l6k/J/Pe2Dy93uXB13hdHMeOT+CzafKKWcRRXdwrjNMryLfjhhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VsN3F3WT; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Wv9npmb4; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XHt/lr6T reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453NqSXM021217;
	Mon, 3 Jun 2024 17:02:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=8pjwMebQYGusZ3/BzMnxQYbb1vb8ujX/tAVGIcRYyb0=; b=
	VsN3F3WTulNzt6IyEXokOcrt6iCua2ozxg6HJB9rOexDRo5uJ5mKnCfIkTpdNrqB
	QmbFK2JxqxIldlVBHj9fi25P8FDWiLpDd5dybNHXZyv8CCFlumnEJauTcEJMdU7v
	cSo7mDZ0WSatc0+7dAvzSyqlyuwuwF4T2aAt3ytnLsUgdj3TQ72LsoiT6RN1cmnW
	6AHwITe8RRvCh4ZaA5B+tywvd0/fKNXIQu+ssoUkbDY1mJggFJw434nUMBtFt3MA
	oHeNebRo/Ow17ZJuvl5EyeueIwB/ShMOm62aGVUK6Jp83/NyU+IeajbgUJ1gLDlt
	3zzFfMRj61sUlzIgsOs6Xw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yg2js0y4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 17:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1717459326; bh=8pjwMebQYGusZ3/BzMnxQYbb1vb8ujX/tAVGIcRYyb0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Wv9npmb4d5LM9AmnnYtUfr4lBlEpCW+vk9Oa8SOGR3liEGBVJTRgQNYLo62G3Vxi9
	 sWSyTOF6oSIvzstou8l5+xtw6yTTQk8AuXhXCUvzq3Air9y2LrvuQMhkZXC3QH5orM
	 p3JVHVNK4wdHkCh/NMEnu7JBRhVYGp2lO+mrN5smZz39PRVO9UDRMUZJONnd/jdtKF
	 gr//58wwd6ZgUA/6xCgotqr9p9c73n34ufiltOuMqv1OJoGi+TNi57mxmvatOCIgSs
	 Vvynn+QL44SNEDco9+zCygKj73n+V9FpjAWOAdO9EYQOjGLCxjk3/eYsWbe92kQsE3
	 pAwjoOROmmJZA==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 90D504045D;
	Tue,  4 Jun 2024 00:02:06 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 1FE95A0081;
	Tue,  4 Jun 2024 00:02:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=XHt/lr6T;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 66BE140352;
	Tue,  4 Jun 2024 00:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6/TDOmRSgHR6qDc5HEBPatwvRfQgGPwut13u6Zznd5dvE70KI6XXO7D+FUV1ZPRIDPCphc6t22a400DM/kTMjqZ8oHpzURP6m8nK46NHc1epqbiILlsUaFmVs74h0vCD2g+wCBMf63zLSyWFljfxTlEZny5GWbmJ3XiQMDfUqvobcjH9czno/GMhtsZaBViYApS0wfC1oZwL7B/yiodw+czhRixsjwe7XhHDMWxh8AGfaASFUJM94t2hmAhIAZReDS4mj7ogL2VnP/mqQTbpYJPOuQVpJ3CQNsyfwzNcy5qIo1sK/xlovNIAEL8luJK6rQg/SwQYsPZ0e76rdSsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pjwMebQYGusZ3/BzMnxQYbb1vb8ujX/tAVGIcRYyb0=;
 b=G5q0IW6JGfeCeUfLB84NvIKFYJ9NRdrDWcCEHaEdrirIrASuQVKyGFUrcZ25nnLWhEyKvpZtCXDcqsha+3tTt0/g4TfnJaMIFbZpFLq99vIQn/S8VKIhzRMLrWOwBhRYjXdeHrqcXHUaLztAdkEwJ1svU7DG6Dcm+kQZP2Sdh1Mzx+ZEQIBJerb8aX3Odg4bTi7uqaqIwU+l9LawXpdeq1zl/GSHADiiSNRnoQ2FRlQZV3QOqe4Erlxfrk4+vyHuIkGWFpLc6djkdBD53grIuxaA5sfEIEw9fGqfHbNqN7TbHw1Fc5UmU25Jwr8LGxfatgaJWF1aSH8v7GS1qtFdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pjwMebQYGusZ3/BzMnxQYbb1vb8ujX/tAVGIcRYyb0=;
 b=XHt/lr6T9mv7iE4H78P/XeXTtND1dy9z2VgagAKkR1RQOmcq6RlnTkpZLtwPY3/+2TqIEHdjASMuYRL17cOYOvPY6oMKo6NA4tlV2mo0gpDedK2JddnlehFzq5fYEcxbaoR8y8cqkvw72V/t3psu/U0ajlVJF8Sp98g9uLCzWZE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 00:02:02 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7611.025; Tue, 4 Jun 2024
 00:02:02 +0000
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
Subject: Re: [PATCH v2, 2/3] usb: dwc3: core: add p3p2tranok quirk
Thread-Topic: [PATCH v2, 2/3] usb: dwc3: core: add p3p2tranok quirk
Thread-Index: AQHatbYvEKCjzMC7MUi9d+7VCvXe+bG2uVyA
Date: Tue, 4 Jun 2024 00:02:02 +0000
Message-ID: <20240604000147.2xxkkp7efjsbr3i5@synopsys.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240603130126.25758-1-joswang1221@gmail.com>
In-Reply-To: <20240603130126.25758-1-joswang1221@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN0PR12MB5833:EE_
x-ms-office365-filtering-correlation-id: eff50249-f47b-42f4-51eb-08dc84299000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SGs1cUE4ajd0L3BsRWVVSVZ6SkwvWVNaTm5LT215aG12bFBLclhsbVNzOTQv?=
 =?utf-8?B?WW5KeFEwMlVGUC9zbkx4dkoyRlhQT0tKUzcyRW9jZnlqNEhTaXNlcm5ydXNN?=
 =?utf-8?B?RVdPaXlLbGE3YzVzdVVpLzJOSCs1VzBYK3pWbEM4LzlISjFoOEVNcVZjbGpK?=
 =?utf-8?B?Y3p5dFgwWEFiMVBQZXRIS1RzU04vK1prQzhWSnRDdHQ1a09Yc0t4ZUY2OVNH?=
 =?utf-8?B?VXFQNDhhZzU3amhNVFRJakpWVGMxWUJZaXNFSjBxMGtONXN4TmtPSDVLOEJr?=
 =?utf-8?B?SU5iZTRvRjM0RjhsMmFqNW5jQVlDRWJlUmtsbS9xUUY3ak82R2VibWxqRUs0?=
 =?utf-8?B?ZVFVUmV4cUw2WjVMTnhSVFk5Z3c3bE5ta1dMNjhMRUdXSVIzWEFpemxLQlJX?=
 =?utf-8?B?ayt4SjNpRzFRRXN2MTRxeTd3UitlN3g2QjVBamhwNDc4dk13Y2xqdnJ0V0Y2?=
 =?utf-8?B?MVpxaDVDaGZMdEp6R2x5T2twN2dvMWhBWmQyWlFSNGxodEcyY0I4WTNkQ0xy?=
 =?utf-8?B?SlZPNXNBZWhjR0dOWUcrY0hkWmZaTERSekhEUlJEM3AvOVFlRVdXbzNxMVB5?=
 =?utf-8?B?VGlMdFpNUXRCNVlGM1ZHaTcwNC8wejdPNitPOVg2eGhIS0s0cW0yZmNXcTN6?=
 =?utf-8?B?QjBQTXZ0ekRoRTNRZ0pKeU0xK3B4SXNUazNLa1lUQXlUdSs1c2pUSHlnS0pF?=
 =?utf-8?B?RnVyWVpLOU1LdjJ5QTR6d0FrdlAvamNtblhlQS9SVWszbm02OExxREkyVHll?=
 =?utf-8?B?WDYvZHY3K2QwcVd6ZDVHeEVVZTFNcE5pOXBsemE5b2c4Nm14U3NPZXBYWFV3?=
 =?utf-8?B?NzBTNjNTMkFxZHhSMC9Vb1Bud1hCVWdGWXUrck1NT25UellqVW10eXYwOUtn?=
 =?utf-8?B?L2xJV3lEbW9PSGRTK1ZrTnFhbDRZR0hlM0pXSjdwNklnUDBmeGM1b0N5SFZC?=
 =?utf-8?B?aUdsUStkWGdnSVl3VWtkQlJSZGJrTWJGTFFSajlTMzR1dFBXTlNKZDl4WjVy?=
 =?utf-8?B?UUg2d1VmM1BUWDQ4NzErQ2RyTXRqN1BoRmY4WkYvMkJCVHZuaENobFliMks1?=
 =?utf-8?B?V3Qxb1JXaE5UMVViVERNcGJ2VzV1bXFNWktUaHFlK0tSSjlKSFhxckFOQW5Q?=
 =?utf-8?B?ajJQcko3a0tUb0NPckd2b0FKWVZJRWVvZTBWcUY1Snp6VUFWZm8vYVl3YnYz?=
 =?utf-8?B?Qzh4ckNDVzN1Z2tDNnBHaWhOYkc1eXBqUU85MDhVNUtQWWROeXVYNlpDSXo3?=
 =?utf-8?B?TURORkk4YVQxajBWM0RJVFY3M0RJdE0xaXlXU1pZSGx1UHZVTzFIamJ3dU5S?=
 =?utf-8?B?WGNpempvUGtxd1EvdWsrZzUrcTFIeEcxMHBzMkhqMGRvcm9sTTI1UzI3aVhk?=
 =?utf-8?B?d1pHdUZZa3FKYWI4NjIrdGdLUDlKeFRSUjFVdGdwenh3Z285bXR5eERmTjRR?=
 =?utf-8?B?TnUwVm1ncklwR0VnbTNxUW53M2dlc3VMaUVwRXNTWUJzM3VJRHEvS201S3ov?=
 =?utf-8?B?UmxOV2lkSFZSSWNNQ0gybndmZkFyNEhDYlhuSUVId01OVmwrUitHZ2ppRDY0?=
 =?utf-8?B?OHo5a3hYQnUwOFcrR0tVaEFyaVJkSHRrZFVCbGVJZ3I2NlNxUlByS0MvUEZu?=
 =?utf-8?B?SnFwc1AxSlNoeTlMb3ZJRjdMQTlLcDZBTExscDJBMy9zVlVtcVNCTjhuL0t5?=
 =?utf-8?B?dkhEU0h6azVyZVZncDBEMzRtYndNQzRRL1RBZElpeVRJR0hEaHVQcVhYTmFC?=
 =?utf-8?B?Mmh2dm1OcTZKMTd4YmdTVlgrN3VNMFVZK3pFNk0rS0pobU9TZjBMMXRCeTlC?=
 =?utf-8?B?K0RkNUM1aFFDdkdYbXlkdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RnR6Ny9NWjRrNlRqRWYrZDUyelEzVUlpTlM2T3J1bGxtRzg3aFc4VE94NGVp?=
 =?utf-8?B?VE5XVmhHam9CRW0zNWZxZSt3ZU1VcW14em1uTjRZbmdJRHFzeWlpTmFZRmhV?=
 =?utf-8?B?aStLSnVCNWl0azJLTDZITmZQWUgvTmtXekJLeVhoRzcrYVBIWG56bjZQaWJI?=
 =?utf-8?B?UHp6OXlDR2FQYjhvcENzZGtMdkNNajBQMjBHRHlxaHhvTEF5eFI2cWtQVlNo?=
 =?utf-8?B?M3VGN3JGU1JuRUpSVDVNMWxvUktxQWV4K0Ywd3R2UXZrU2hUcHVZZkpUd1Z0?=
 =?utf-8?B?SWlSQ1NONzNKZjlSaTdXcFNwU21QTmg3dW8wMmdPWDlhQ3RpendZUnN0aVpU?=
 =?utf-8?B?WU45RjlZSERBUU9HNlBnTUJyQ0oyTVFuMDRWamtFRnJZZmxKcVJxY0VGZ3M4?=
 =?utf-8?B?YXJFUzZxTDAwMDRwYVNLTWE0Vjk0WW5kSmttaDNtaWdReXdhSEVYTDQ3M1NZ?=
 =?utf-8?B?QlhtaE9IeUVnR2Z2WWNXaUcxRFd3NjBiTlNrVVZNVDNzdHdianlydGNBQ0tq?=
 =?utf-8?B?VUVoOUJpcXdaUDN1enhlMm9jUUFwZVNFcTM5MWtVVkhtSHJYaTRURm1sWE1z?=
 =?utf-8?B?cHdGa0JDSlNCaVZaRW4xbE4vVVB5QTh4dW5STGhaR2NXOCtHVUxTaG9XejFW?=
 =?utf-8?B?UjVWeHdrT1p5MEo5UmNEYnY4OFkyZ0prWGY5NDd1dGpFM20vdWwwa1VEV0la?=
 =?utf-8?B?VnlLVzZGOHdaVmhMN2ErSkN2QlBnQ01na2EwK2RBY25JM0ZsSk9KcHY1Zk5H?=
 =?utf-8?B?cWNtbjBBSExnbG5xNmZ4enNvcTRPWkdsMEdsbWUxV2lvaHUwVWhCeG1GclV3?=
 =?utf-8?B?Mi9UaGFxRzF2dHJaZmVDMWNzVFJ0N0hWcWMrbDBKdE9pWXRpN1V5eFVwdkRS?=
 =?utf-8?B?Wjl1N1BwdXcyR1gvN3FTelZHbnhPK3hENEx5V20wQnRMaUVENzFSSm9IWXJt?=
 =?utf-8?B?M3A5YnFXclJGdFI3aVZoNVp2Z2EzTHlQRUhGaWdFOVUyYStYbGZvNWQwNmtC?=
 =?utf-8?B?MFNtK3Z3a3U1aWpqMVdHQk1uN0dhdmFtOVZZdWllY1ovczNSbzkrT2U1NWZS?=
 =?utf-8?B?T2hsclhNelplN1dZczhSNnNYQk1ueFN4WGUwaHU2N1lqb2lQM3pPdFJFVjZG?=
 =?utf-8?B?eDFia3B6Tmlha0R2bU05ZlRyVVRCdm11dndBYmk4RXQxM1RzUDZzSWlsVGs5?=
 =?utf-8?B?QThuSTJlU2VoeW5VQlJlRXMyTFVCVmRZNDk0ZmVMU3FzcDd3MThiNHFWcHdw?=
 =?utf-8?B?U2x2SjVJL2lXdTFrLzV0clBwZzI1dEZxd3NYWjk0UStCSDNpbmxjaFEybWlQ?=
 =?utf-8?B?blI5RDdTQlJ1QW9ZQjUxbHFITWZMcmpicll0QnJValdmekNGcG84Nko3WC9H?=
 =?utf-8?B?eFhibWc4eVpQb3EvU0NKczdoZ1ArVkp6eENzVmtrS250Y0tqdkN0TEdOT1lw?=
 =?utf-8?B?MjJBZXVqbzBiZDd6ZVpkU1FlN0w0WSt6U3hZcDkxT2lqRTBveXN6aVAzNGpY?=
 =?utf-8?B?OUF1MUpDcW43c0R1VkZRaUdWYkgzUFFiS3ZKWW5TOGcyQStUUVQ3Si9QUk5U?=
 =?utf-8?B?YzZTakNtNnFwN2dZaXlLQnlHT3poeDZjWVB2N05EdXozeUF0Nk1tb0MvN1hN?=
 =?utf-8?B?YndYR0tJUW84elRVYVZtRTVZcGJMay9CTU5TMUdJQk5hcWZha0tIY1QzQzN5?=
 =?utf-8?B?Q1cwNGIzblVwVzl5bEhWbXk0N0NaWW5VNzZvTE5xVnRabXEwRTM1TllxWFYz?=
 =?utf-8?B?dE5jK0U4eVBVVkRiUFRZWUhXWjdBVkhzYlhZVGxpdUd5K1dXL0xtMHRUeTh2?=
 =?utf-8?B?ajY5L3htdG5ZNmM0U1ovYVpVcXpkY0p6ZkhyRjJ2Sk5UOEFhLy9aK09rUVNO?=
 =?utf-8?B?b1hJcERsYTBCazN5OHFvL0JHMURoMzgwOHViTTRjdkFxRU1GbnpMaDE4OS9V?=
 =?utf-8?B?aXVlTkUxS0o3akpRdU50L2pCcG0rZDJSRTVCQk9Yc3AycUtvSk5lQkRoZFhp?=
 =?utf-8?B?a1czNmc2SlIraTVwT0w2bWNZUkpTR1RvK2R1YlZjaTU3Z0lEcFQ0VDlDN0lw?=
 =?utf-8?B?MmxZRmdHalJEUXF2OXdBMVRxOU1XMXM0TEpTZlFKNDJrazlSVzkwVXE3NFlj?=
 =?utf-8?Q?/rt/38L1b4YVK2uHM8nMfXbhY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16ED16532C39464CB61B6A8DA3ED8722@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XsslwPQEudxRMZrX0u53TsLK6c2fdUgXVmTIbjfJpZ//Edtf10dK09lYEyRTnGgJYRy6VnOEwYhQE5pvwXJboQhuHq6L1Qe/oKF0PnrHRd3Oi0dupmJMYe2ljjvNtfnb43aGDD2ZPoRgynKB0V13bKeHol/lK3Inz5d5JC/nNARgWA0tSuKX4ey9Ks2ZLyO+8GAUFYmnUSrnx1fv8dSoeExSQnOtvwzrRJRxJnomL2y4QMxKKAg0Y4KOgKgh+elCMUUn3oBp8Iih/22WjilZfgHbv7Aa+HFsFOpp1tItO14vPv2XSGP3T0oUKJYojGNuhQ5OOtkWK6gJLZL4qnC8i87cUkeC8oAfBioEg+tv1KhMNgBV1razYlrXTKu6wQ6WtqT14Hl4BuNa37WeppuEmgHTR8nn8mqD4Rnlwtrk3jVcFqcdi72L6OnnJrQ/05fesxpbXSxPcMAn63hEssYaeCzaZKy5TjeubkDXP5lGZBraXl9sl3YMPGzPLeHlCUjfUldsMO/3+qmPtbhC4Y/uqY/T7nSPF3rNR+WFDWMTIn3JILAUlvLttejTha5bgaBlrGQn3iN1jcgikziKk+HLeqD5oUtICCwYAz8IwGnCzys6LtPJWqH+6/0HOJu/oNfKXGqRnY5iyAUQgyQZgYg8Vg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff50249-f47b-42f4-51eb-08dc84299000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 00:02:02.3897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrR+iX1Xzv4wWA8CKsgURu34c5Isrka9SrFaX4ppjUkmB3UUHNhw6kdg0qW5v1hjC+FNsheY2JkRFAvNFNdt4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833
X-Proofpoint-GUID: 72KCQrADLYmK2HW21v1Lx67Gn2A7zAm2
X-Proofpoint-ORIG-GUID: 72KCQrADLYmK2HW21v1Lx67Gn2A7zAm2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 mlxscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406030194

T24gTW9uLCBKdW4gMDMsIDIwMjQsIGpvc3dhbmcgd3JvdGU6DQo+IEZyb206IGpvc3dhbmcgPGpv
c3dhbmdAbGVub3ZvLmNvbT4NCj4gDQo+IEluIHRoZSBjYXNlIG9mIGVuYWJsZSBoaWJlcm5hdGlv
biwgdGhlcmUgaXMgYW4gaXNzdWUgd2l0aA0KDQpJIGFzc3VtZSB0aGlzIGlzIGZvciBob3N0IG1v
ZGUgc2luY2Ugd2UgY3VycmVudGx5IGRvbid0IGhhbmRsZQ0KaGliZXJuYXRpb24gaW4gZGV2aWNl
IG1vZGUgKHBsZWFzZSBjb25maXJtKS4NCg0KPiB0aGUgRFdDMzEgMi4wMGEgYW5kIGVhcmxpZXIg
dmVyc2lvbnMgd2hlcmUgdGhlIGNvbnRyb2xsZXINCj4gbGluayBwb3dlciBzdGF0ZSB0cmFuc2l0
aW9uIGZyb20gUDMvUDNDUE0vUDQgdG8gUDIgbWF5IHRha2UNCj4gbG9uZ2VyIHRoYW4gZXhwZWN0
ZWQsIHVsdGltYXRlbHkgcmVzdWx0aW5nIGluIHRoZSBoaWJlcm5hdGlvbg0KPiBEMyBlbnRlcmlu
ZyB0aW1lIGV4Y2VlZGluZyB0aGUgZXhwZWN0ZWQgMTBtcy4NCg0KQ2FuIHlvdSBwcm92aWRlIG1v
cmUgY29udGV4dCB3aGVyZSB0aGUgMTBtcyByZXF1aXJlbWVudCBpcyBmcm9tPw0KDQo+IA0KPiBT
eW5vcHN5cyB3b3JrYXJvdW5kOg0KPiBJZiB0aGUgUEhZIHN1cHBvcnRzIGRpcmVjdCBQMyB0byBQ
MiB0cmFuc2l0aW9uLCBwcm9ncmFtDQo+IEdVU0IzUElQRUNUTC5QM1AyVHJhbjBLPTEuDQo+IA0K
DQpXaGljaCBTVEFSIGlzc3VlIGlzIHRoaXM/DQoNCj4gVGhlcmVmb3JlLCBhZGRpbmcgcDNwMnRy
YW5vayBxdWlyayBmb3Igd29ya2Fyb3VuZCBoaWJlcm5hdGlvbg0KPiBEMyBleGNlZWRlZCB0aGUg
ZXhwZWN0ZWQgZW50cnkgdGltZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IGpvc3dhbmcgPGpvc3dh
bmdAbGVub3ZvLmNvbT4NCj4gLS0tDQoNClBsZWFzZSBwcm92aWRlIGNoYW5nZSBub3RlIGZvciB2
MS0+djIgaGVyZSAoYW5kIHRoZSByZXN0IG9mIHRoZSBvdGhlcg0KcGF0Y2hlcykuDQoNCj4gIGRy
aXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgNSArKysrKw0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmggfCA0ICsrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYw0KPiBpbmRleCA3ZWU2MWE4OTUyMGIuLjNhOGZiYzJkNmI5OSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4gQEAgLTY2Niw2ICs2NjYsOSBAQCBzdGF0aWMgaW50IGR3YzNfc3NfcGh5X3NldHVwKHN0cnVj
dCBkd2MzICpkd2MsIGludCBpbmRleCkNCj4gIAlpZiAoZHdjLT5kaXNfZGVsX3BoeV9wb3dlcl9j
aGdfcXVpcmspDQo+ICAJCXJlZyAmPSB+RFdDM19HVVNCM1BJUEVDVExfREVQT0NIQU5HRTsNCj4g
IA0KPiArCWlmIChkd2MtPnAycDN0cmFub2tfcXVpcmspDQo+ICsJCXJlZyB8PSBEV0MzX0dVU0Iz
UElQRUNUTF9QM1AyVFJBTk9LOw0KPiArDQo+ICAJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0Mz
X0dVU0IzUElQRUNUTChpbmRleCksIHJlZyk7DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gQEAgLTE3
MTUsNiArMTcxOCw4IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2V0X3Byb3BlcnRpZXMoc3RydWN0IGR3
YzMgKmR3YykNCj4gIA0KPiAgCWR3Yy0+ZGlzX3NwbGl0X3F1aXJrID0gZGV2aWNlX3Byb3BlcnR5
X3JlYWRfYm9vbChkZXYsDQo+ICAJCQkJInNucHMsZGlzLXNwbGl0LXF1aXJrIik7DQo+ICsJZHdj
LT5wMnAzdHJhbm9rX3F1aXJrID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ICsJ
CQkJInNucHMscDJwM3RyYW5vay1xdWlyayIpOw0KPiAgDQo+ICAJZHdjLT5scG1fbnlldF90aHJl
c2hvbGQgPSBscG1fbnlldF90aHJlc2hvbGQ7DQo+ICAJZHdjLT50eF9kZV9lbXBoYXNpcyA9IHR4
X2RlX2VtcGhhc2lzOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCAzNzgxYzczNmMxYTEuLjI4MTBkY2U4YjQy
ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTMyNyw2ICszMjcsNyBAQA0KPiAgI2RlZmluZSBEV0Mz
X0dVU0IzUElQRUNUTF9ERVAxUDJQM19FTglEV0MzX0dVU0IzUElQRUNUTF9ERVAxUDJQMygxKQ0K
PiAgI2RlZmluZSBEV0MzX0dVU0IzUElQRUNUTF9ERVBPQ0hBTkdFCUJJVCgxOCkNCj4gICNkZWZp
bmUgRFdDM19HVVNCM1BJUEVDVExfU1VTUEhZCUJJVCgxNykNCj4gKyNkZWZpbmUgRFdDM19HVVNC
M1BJUEVDVExfUDNQMlRSQU5PSwlCSVQoMTEpDQo+ICAjZGVmaW5lIERXQzNfR1VTQjNQSVBFQ1RM
X0xGUFNGSUxUCUJJVCg5KQ0KPiAgI2RlZmluZSBEV0MzX0dVU0IzUElQRUNUTF9SWF9ERVRPUE9M
TAlCSVQoOCkNCj4gICNkZWZpbmUgRFdDM19HVVNCM1BJUEVDVExfVFhfREVFUEhfTUFTSwlEV0Mz
X0dVU0IzUElQRUNUTF9UWF9ERUVQSCgzKQ0KPiBAQCAtMTEzMiw2ICsxMTMzLDggQEAgc3RydWN0
IGR3YzNfc2NyYXRjaHBhZF9hcnJheSB7DQo+ICAgKgkJCWluc3RhbmNlcyBpbiBwYXJrIG1vZGUu
DQo+ICAgKiBAcGFya21vZGVfZGlzYWJsZV9oc19xdWlyazogc2V0IGlmIHdlIG5lZWQgdG8gZGlz
YWJsZSBhbGwgSGlzaFNwZWVkDQo+ICAgKgkJCWluc3RhbmNlcyBpbiBwYXJrIG1vZGUuDQo+ICsg
KiBAcDJwM3RyYW5va19xdWlyazogc2V0IGlmIENvbnRyb2xsZXIgdHJhbnNpdGlvbnMgZGlyZWN0
bHkgZnJvbSBwaHkNCj4gKyAqCQkJcG93ZXIgc3RhdGUgUDIgdG8gUDMgb3IgZnJvbSBzdGF0ZSBQ
MyB0byBQMi4NCj4gICAqIEBnZmxhZGpfcmVmY2xrX2xwbV9zZWw6IHNldCBpZiB3ZSBuZWVkIHRv
IGVuYWJsZSBTT0YvSVRQIGNvdW50ZXINCj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICBy
dW5uaW5nIGJhc2VkIG9uIHJlZl9jbGsNCj4gICAqIEB0eF9kZV9lbXBoYXNpc19xdWlyazogc2V0
IGlmIHdlIGVuYWJsZSBUeCBkZS1lbXBoYXNpcyBxdWlyaw0KPiBAQCAtMTM2MSw2ICsxMzY0LDcg
QEAgc3RydWN0IGR3YzMgew0KPiAgCXVuc2lnbmVkCQl1bHBpX2V4dF92YnVzX2RydjoxOw0KPiAg
CXVuc2lnbmVkCQlwYXJrbW9kZV9kaXNhYmxlX3NzX3F1aXJrOjE7DQo+ICAJdW5zaWduZWQJCXBh
cmttb2RlX2Rpc2FibGVfaHNfcXVpcms6MTsNCj4gKwl1bnNpZ25lZAkJcDJwM3RyYW5va19xdWly
azoxOw0KPiAgCXVuc2lnbmVkCQlnZmxhZGpfcmVmY2xrX2xwbV9zZWw6MTsNCj4gIA0KPiAgCXVu
c2lnbmVkCQl0eF9kZV9lbXBoYXNpc19xdWlyazoxOw0KPiAtLSANCj4gMi4xNy4xDQo+IA0KDQpU
aGFua3MsDQpUaGluaA==

