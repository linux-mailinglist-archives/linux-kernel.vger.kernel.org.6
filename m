Return-Path: <linux-kernel+bounces-206822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D20900E39
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61FFB21DE0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2333155C8F;
	Fri,  7 Jun 2024 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NKO2Z2Ts";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eWQjy8s5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NZcNr/CW"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB671552ED;
	Fri,  7 Jun 2024 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800616; cv=fail; b=e2t8Kaxyi3jBVKxWi99oe+mLLerN/V/ND5N2a/YXQFE+Boe3E7kTiWdOP0wW32Nwuyile/6JBk6JJ2xgsqrw++hn74bcU397379rvZM0e6mQTwjbp2ZCuYr28LP1FJQsjNfDNxYQeaLgYLl3MvVkZw48gEgzUohnJPnJiLK0Ks8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800616; c=relaxed/simple;
	bh=cNtGSLr9qdm7U2DVuSjYRbXZv5WxALbKjLse6FVTDPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kW3r6LyGz/pam4uxQ27S0lhPXjQc6BRIMM6X0sHAEBLDWOq8EDwUMTl8ahGpsGsEFt9qQpzmAK/gaxl2BGWt2ALMRU8QluqREBc9mYQX3hBJyZMm9DTKaQuUINKLqQakVYYLjspnUnZuXfdlBH4GS5wQFh6O0WU2eMoQRtwlqFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NKO2Z2Ts; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eWQjy8s5; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NZcNr/CW reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457LaVjE008410;
	Fri, 7 Jun 2024 15:49:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=cNtGSLr9qdm7U2DVuSjYRbXZv5WxALbKjLse6FVTDPc=; b=
	NKO2Z2TsKkhyacLFJfnguxVfQyZ+KbseiuYtGxvd6nUOMLZVncPsBri5YsSOuJHQ
	JZW9s7p/1R+mxqbAnI4q5oYsnv/KzRuhs7fLV5uAssKwtnj0oNzJ9U2YgA+tOOg4
	4ayDC8AIQ+awFf+RpvyqiL9KMPr6wafxeRg1I3u+JgtzSoATlsNYATmmWZPxJXE1
	83AcsbF6iKkQd6txgWScOJyyCG/y/34q7tZbR9SXdHEI9aJOvsvXi4ju0+8jU/2H
	dsP7y2qXgy219B3aYQ8QntVkfUUYV/Im3JhmdF/b0WEKtVUevtb0EoLHTViTbMML
	EpuIJ0XTECcSopNTYatyBQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yg2njwkjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 15:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1717800593; bh=cNtGSLr9qdm7U2DVuSjYRbXZv5WxALbKjLse6FVTDPc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=eWQjy8s5Sngpy+Ojz8fWjWlWfKlCyMsL7wtEmgOwkYgkAcSkVyq0OG4+3XlhDJwg+
	 2wEolcpYza9O284VpP/sDyT6kd6zHjbp6TwfXuiStImRpDXfd2CvgcB33weWzNRXkl
	 /CeRaa+7MR+WJzjEezM1g1wpDJRNV703kIVfZHimt0Bbzr5c9T12Vf3Tv9RBFyceoQ
	 hYAAeJVFimyw4wGGJq4hEZRuzRYejaSVlvKWCiVjiY+w8/s5FdVtoTI5jhpX5C9qWa
	 UKallQbPTbjqnYQDpw61RA8Naza0dO9DiiWl2lFEMslvvNkbfumKoY9GWx1gijyr+r
	 Z7jxCtrxrfIxQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4581340453;
	Fri,  7 Jun 2024 22:49:53 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E7491A006A;
	Fri,  7 Jun 2024 22:49:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=NZcNr/CW;
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 410A240355;
	Fri,  7 Jun 2024 22:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvuIKyEEUT7EwXRSJsLJ+gMrTNhhzdDHDC+vtvtCkT9ZqFYHOwWPJWYcHI1Vhs6i28bqsx/tcn3CgIUoDPnTU+O2RFVSo6+ddyyZUN6PA4NmjG48Ta1M6FbWE+WejcgJ74ARwWWuliBLIVOcElrco8dNoTuziKxNlD220szslZG6Zo25mQyy6m/nNac8XYlHFkThjW+G4kLxIBcMnEogYDOmB80dx/UUUQEUxaaEQLZ6DefEsB0MbyDeCeZYNHB7bvMgpLIsDQV8+0RAENsJ54I8px5Q2IbdYNBGAvzYs9iVpTG5MmpaPKVYr25Fu4P+h2pcKHUsJ9HGyfMnSwo2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNtGSLr9qdm7U2DVuSjYRbXZv5WxALbKjLse6FVTDPc=;
 b=hF8N1+4FTrtrj5+EsTghrCiBjjv/hH40xoXKViGWOFlNJuVN8yc6mHqlp7njzIcfv6BUkcN0TthM3A67NQxZrOJjgU+W/Cp/Dje2/1OU/qfGKyg1DF230YNR0AWzLe8jkH7gCTZcfKsumrqpAqM6Zo3Jjrx79VzMzgQGif9y3LEhLr6Qf/YWnN9th0edNHkT3fAqN9zRWZmEwl73tA+2fwLaoDim6h7sGtRXkpM1RVv2rAQKIGne3F1IErziQGQU96NSohtm1GIu79Nb/mH/BG7tmXesgkZ84A8wMgmkRb+njIdr5IaavqvIcRlyxbDcZrs9Pb4glX9Qbqr33hU5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNtGSLr9qdm7U2DVuSjYRbXZv5WxALbKjLse6FVTDPc=;
 b=NZcNr/CWI5djXwHAwj3rmnpcA0MT7QRVVqdyxYqrQ1TMg3PcDX6i2yPWsQNjIodl6ltjxSYL8mS1QOb9K5yP3X5ZX2jiqrBkvkPl7Fj2aTJ9Grdbh0WQl6UsZgzTMStlAcATeX+K9V5zlrnlrt6bSf8GA1XW2Z2rCpNVR27Dv6I=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Fri, 7 Jun 2024 22:49:48 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 22:49:48 +0000
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
Thread-Index: AQHatbZOP6V8cE1jeEGogZmaKJg11rG2uuOAgADiIoCAAlmJAIACX2QAgACYngA=
Date: Fri, 7 Jun 2024 22:49:48 +0000
Message-ID: <20240607224946.wob7gfgzhozvg7gq@synopsys.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240603130219.25825-1-joswang1221@gmail.com>
 <20240604000715.3rlmzxriof6wwksm@synopsys.com>
 <CAMtoTm3XnPr8DY9qPW0X0+aayu_7CWrC1od8qKqU3S2wRjMi1Q@mail.gmail.com>
 <20240606012936.jdokepv73qrdorbp@synopsys.com>
 <CAMtoTm1roAvvWCu9LSfcbnozZnakMEexdUVxNyZ7N5KOG8tHcg@mail.gmail.com>
In-Reply-To: 
 <CAMtoTm1roAvvWCu9LSfcbnozZnakMEexdUVxNyZ7N5KOG8tHcg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB6232:EE_
x-ms-office365-filtering-correlation-id: d8f9e730-06d5-4a19-e2c9-08dc87442298
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aGNUYUVUNVdkMUdVUUlyc3UvWWZzb2Qrd0k4OWZ5cFhuTEw0SHIxUFdhNTZy?=
 =?utf-8?B?MTVFRHZIaDM2UXBqVlVmaGplR0t5eHlMOVB2VnlHWFFxb0JxYStvZXdmS3lx?=
 =?utf-8?B?c2pOZGNRaGc4aG5BZ0dBQkF2eTV4VXYrbHRoenFUZHdSSmdrSGhqODUycXY2?=
 =?utf-8?B?VnVDeVREWEgvcWJDZmpndUdheTJhWk5lb0ZqV25sTVY2Y2NBZWorazRWcEdh?=
 =?utf-8?B?MkdoSU1kc3lhNjZXTmtpb1NtQ1l4WENEZExvRnlGdWUvTEdYSWhwVkRjRWdT?=
 =?utf-8?B?ZnljNElxMXhPSjZJUVBITWI2M1hubFUwaUlBVGltUUw2YlFmYTZQd2dCU1U1?=
 =?utf-8?B?N2J1cjIwLzZiNzcwdGk1RTJhbmdXK2Q5NWVoYnRyNENGNXJ6clhSSVMwMnNo?=
 =?utf-8?B?UEJtc1VzU0RzSDNnOFptRVlFUjhhQWltU1IyYXB4YldNYWFyTzF6Mm1sRkVx?=
 =?utf-8?B?ZTdpaFV1UkFsbGJibzB3dFlIaStKQ0dTVEVhSC9XRksvU2VhajlGSGxlVXJ3?=
 =?utf-8?B?cWorUkVzN3UreXlFWDN6VU9oMWxEbnVZbUxEY3pyWFhvd2dHRjk1cjFBc1FH?=
 =?utf-8?B?MWErYTdnUU1TWlorb1BxeXhQcTB4b2NiKytRcm5vay9pYVFuc3ZCeHM0RU8v?=
 =?utf-8?B?NTVoYUpCVEhxSGRLN21Wb1NQbmlEVHFYZkplNkVnTUFLVEFpOXpRLzh4eG5l?=
 =?utf-8?B?NDNCdzJrKyt2RzlZeEhpb3lSeTd4SUFHQzZubld3TWtNYmxaQ3dDeVpJdVZ1?=
 =?utf-8?B?RXdpZnNMb3VlRVdLdnJpa2NlbTJhaVZEd2lpeFBpWGJnWUlta2t3em1TdHdw?=
 =?utf-8?B?MUs4bWMxdUtLWlA3V0czdzJiM0htbmRTZlNJV2djYklkWHV4YnRkWmxxS3B4?=
 =?utf-8?B?NmlQYUFaTXBQcWd6eTBjMis4MzY0ZGZkNFlKdDMzc2VFeEExcC9tSGZSelRV?=
 =?utf-8?B?STdjRUphZHpidVJzL0NacW44ekZKcFVxVU1VcU1FZGNWcVZjRkZuNk0vckZk?=
 =?utf-8?B?bHh2ZTVaM1ZKS1k4K3NwVERDN2wxbHhmRXkwV3k5NnFMSzFKUlQxK3NKWjFZ?=
 =?utf-8?B?cm9YdjRIQzltSmFUTUdNbWJkcjVnQVd0TzM5Szk4Sk9mMGRNMU5OMDAxWTlh?=
 =?utf-8?B?ZkFwSUtRYndBT1hJUE9HRkJ4OGhEQktlbU1PdDR1OWUyY0UwYzBBU2NZOTVi?=
 =?utf-8?B?OTh1eFpQVDVVTEhYZi9OWmFqT2JWbG53YWFpeGZTRkVkUUVIVjhsSlcwK2JX?=
 =?utf-8?B?TGZ6LzIwcHVHUzZ5R3pUSXUyMHdONWZZNFF4S3NJdjNhdVBsYzZaZUg3Y2Zs?=
 =?utf-8?B?aW1uUCtaNlkvWWRwamY3M0E1UW4zdHBvYm5SYmh5akk0dURkamo2TitZcUhE?=
 =?utf-8?B?b25xYlVhU2NJdHVtMEZ3bjF4MlRrdTdTbHM0bDZxd3dwODcxN1NvTG5ydTRR?=
 =?utf-8?B?bHVBaXZTLzNLcGNrQ1M4MFdLY1FiQ0FzeU1DWGZZSWJ2YUtBNUdBVWd4Q2VI?=
 =?utf-8?B?RUhjYncyLzJrZHpxMjRzcXRhRFNvcXhvK1EwR2l0K0F0MWVOUVJIV3ZUQ2k3?=
 =?utf-8?B?RXVQb2Erc1d6NTVKdDFrWCtpWEhQN2k5S2hEcCt3cXVXZ1pvajJhQ2lBTmZk?=
 =?utf-8?B?UzBHSXJ1eW1GL0lHazl6WldBaWliK1g2NVI5SngrdEV0MVkxTG0zNnZKY3lM?=
 =?utf-8?B?M2k5TUFBU2E2MFUxbmJYY0dZNnJ5cTEwQXUxT1ovc0FvTnk2bmlyL0MwSXhI?=
 =?utf-8?B?bVI2TzdxOUpERlg2NTNkTTIyY1VxUjlsSU4zU29OQnk0MGFEdWpyUFFEdFFJ?=
 =?utf-8?Q?kL1p2vONYYelG/dRX6X2IGfVEZmWm9gtzpptc=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SmdwU1M4eEo4Y1VaR1k5RzFJWG8vcExoUFF6a0dkSnZTZ3UyaXk3dGFrTGsr?=
 =?utf-8?B?bVB4b1pQR2JXR01yOWppNTg4QWFzNzYvQ2M3TmpJbndra2RqTStXV0YydDA3?=
 =?utf-8?B?bk85elc1NmNyZ2RlL1pkVDVZaWtGUTJNWUVmNGp3R0ZjS08ySkw0Q2gwOUQr?=
 =?utf-8?B?SmhRblFNOUd5dHBFUUlXTHN2OUVuQkFkbzd5bVEwR2NDSmU0MmtscjhLTndU?=
 =?utf-8?B?cGhHWGp4RkozQmw2ZlNLQVlwaENuOW9hdjl3d0RJcXpOYkJQdkd5ZFZxVU1J?=
 =?utf-8?B?YWd2QW9nV1FZTEFsZmVMTTlyZG0yRTExdlpwV210TVpqeWd0Tng0cUgybG4w?=
 =?utf-8?B?MFVQdGJUNHhFR1R0aTZRU3dkdVMxb0g0b1NSWDRWc25Kc0hocVQ5RjZHWmVO?=
 =?utf-8?B?cTBybkF4RDA3MkJLRTZkckNuR3luN2hnR1JoNFhnSlJmM05SdDE0cklheEFx?=
 =?utf-8?B?enRmakE3UmdxL2k3eGM3cDNuamFHOFJHTWt3UUZCcU4yVTdqUXNSRzlicmlp?=
 =?utf-8?B?ZHQ4dkluQXZCc3lvWmJZblpTTm1xRGRXUERGOUVlQzl5OVVYenh1bjJZMElE?=
 =?utf-8?B?UHY1dGtjNDJtV0I2UGIyUUpnbFQyaUxkTE9zOThiZHBhSXNJd3RoWnhzb0g3?=
 =?utf-8?B?NUFjQU5Jcm1CTy9yT1duenFBaTJLUVZrNHRvMXdJc0RWWStFUDBsRnUyV2hX?=
 =?utf-8?B?VnIvUW5NSVlMNnJjYTgrbDJmUjNuNXA2TDVaQUJRUnBpS2ZCVXVsY0NqOHRa?=
 =?utf-8?B?RjhWUzZWL0JPbUYzNjJiRGJQdmlVT2pweDVOb1pvWFJuQmYvcHNCck9ENWNa?=
 =?utf-8?B?TzF3ek53NkNWakVwWTk2b0xxaFhUY0htdTY5Mng0VE1tY2ZNMjUyZ3NPWXJN?=
 =?utf-8?B?eDJITHdZSWJMMHRZL1VDaXVxMVZIb1daYmVNY0FMYnR0ZmhhM2VwMGJwSkxN?=
 =?utf-8?B?MzYrZzVCOFg2YlBTNk9Rc3E0cFRlY0ZmZlFIMWFOd3Y5OStlYTNZYnJRY2Fu?=
 =?utf-8?B?V0RGY3hacnErTmZLc244cC93RWVoNEk5OGwwbFVrTmdBRENod2VEdEU1eXBm?=
 =?utf-8?B?RE5Tb1lwbjBBVDMwb2cyWHJBN01uQjNCdTBYRTJ4RVF5OWN3dnhnalFqbXdy?=
 =?utf-8?B?bXo0Z21GTkhoRnVaVGIwaFplZ21OSEY1RzhTWk02dHBrOUdvTDF1SnA1YnJR?=
 =?utf-8?B?bDJLY1dhNWNVK25pU3FwUDNkV0RVNkU0cTVISXBPUnZ1dTZ0TUFueFY5VTd2?=
 =?utf-8?B?bUo2bXl4YldqZ1RCclFQRHphbE5PSndnclpVRU9BL3hrY1FMK08yTkFSSkgz?=
 =?utf-8?B?cjNHNHdHbXJqVlpGd3cvQVdraTlxR01hQ0RNemJhNVBpYW4zbEhsaEhKQjRJ?=
 =?utf-8?B?ZW5yNlJDYmM3SmZYbTdxOVg4M3BNYnF4bjFwOCszd0FwL1RBRWdDcmRLTzhq?=
 =?utf-8?B?SXBOK2RDMTNvTGZZUnFnWko1Zk9FY0VZK2pPOXVnRlYvc3ljNUV5LzBoTTRx?=
 =?utf-8?B?S0ZTNnBhTHlMUkRvbng3YWc5R1pCQ1FOWlZUY25sbUNraEtvbTJKSlI3MXFr?=
 =?utf-8?B?UHM4clY1eEE3bTZSZGgxTkJ4aVkyZzJ3eGhwRUxBbkZtOSs0SllpeFdmZGRm?=
 =?utf-8?B?UUo4eDRvbWViZ0xYdkI5enBZSWoxdGsrYStuZTdnSnoxa2pETWFZWDhBSnZz?=
 =?utf-8?B?ZFlWVVpyMHBFK1o4c25HcmVDc3grMGxHdXFGOG4zRzhDRnF1Q21QMHh5U1J6?=
 =?utf-8?B?QmJKblh6RnpnN2tnYUdsOG5sdDA4R0xEUVU5TkI3Wnk1UlczQ3RaalN4WlRK?=
 =?utf-8?B?WU9XazhuMTFuUTdmVURYT2FNZU5SWTFoYmdFOWxOZXhrcURzaDBUKzVoeERH?=
 =?utf-8?B?U1YwVkxjcUtraWVyd0RGY3BqZEIrK1JSemZNclZNYldzbGtkUnUxY0d3cXAx?=
 =?utf-8?B?ZTZUaW5vd3d6ZjZscXhSblJ6ZmhqMnFCd0E4QklkTElyZFhmMHRlOXZoVjNV?=
 =?utf-8?B?eGVqMzF2K3RvZ1NxQ0RFN09hbHJPazRRdWxvaG1YcHRPWWhyVFduV3ZDV2VC?=
 =?utf-8?B?bFpOQXU0R2dqSGhIUTlPWG8yQ0F0UWp0dDdsQURkc0NSbzFLL1NsRDZiVWU5?=
 =?utf-8?B?WWZLZ2toQ2ZJUFNTeUpnZS8ra0pMaWRYdmR0STdEWEJGL3FLRVdsOEQ2dmEx?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB0BCF2431BC384A9E84C18487AA3798@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mCc56Reu6+AjkQDABkxrL1yEohc2Ff9xbu5RuLmip6dCd3JMpQH9Ha53OF+KbeF5KmaI1Kyy/4xLIoAGXi56M0VoEJH6K+9y3VHILKp/v/02V4agVhp6akjv4ISJDF57nzY4rn1NQlXa7J4CDkdN5+ho+E1Ymhbf832UQi8ymmUzK8WefIuFJNf4p71mzkg7NGWfkcug6JQ+ecEEzOsEyqVsIF1SOWZDqHwVReXSqhnlnS2gi4u+WkOT0CwSKlZsyj3nJpG1Mh5w53QrbesJRBw+qcEnLIaW0ZsM9FtTp05XRDIAUgvaCeLg0xDpC63Bt1ahXlOq+ZKAQ4FeXUMeyJrKFNU7DAFTSK93All+FaZZ1oh8AfSOpjNKYXi+UUyYRvsfg2auWWkZxrWkgxe+46chVE/HMmo7dvxs1VGxNtinmwcvpCCdvtUzOLSIEFLMlz7cphjkYgzhV+9dhdCgxex6XX0BtZOOECtkRWHUP/IMQ84qV5hlut23YycvqG2LIvAJRrvLXcw2Q3b/+2gkH9KnQl7M0iuuPqkEsT7eQnZdiUAVY/SDaiot2TTpaSMKO8STxjlN29ZpmvRfcN97nTyOIUGg59bobngdf6FnEJyOPl/8N5AmiJOuHykjmo7JlhCddw73kPEaiOkUWXe2Kg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f9e730-06d5-4a19-e2c9-08dc87442298
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 22:49:48.7140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tpbOisy60lJhGRl6SPkEa76UwVH8F2ojn2zpF6zSvD9SzVqUP/UjXTNCb4p+8n0UigRrbnuIgZaUfq6RvExsww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
X-Proofpoint-GUID: DpDds5UIk7z4NWFM675gsRVCaJZoEyAP
X-Proofpoint-ORIG-GUID: DpDds5UIk7z4NWFM675gsRVCaJZoEyAP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406070170

T24gRnJpLCBKdW4gMDcsIDIwMjQsIGpvc3dhbmcgd3JvdGU6DQoNCj4gTXkgaW5pdGlhbCBpZGVh
IHdhcyBzaW1pbGFyIHRvIHlvdXJzLFBsZWFzZSBoZWxwIHJldmlldyB0aGUgZm9sbG93aW5nIGNo
YW5nZXMuDQoNCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCAzYThmYmMyZDZiOTkuLjhjNmEwOTcxODczNyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTk2MSwxMSArOTYxLDE1IEBAIHN0YXRpYyBib29sIGR3YzNf
Y29yZV9pc192YWxpZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgc3RhdGljIHZvaWQgZHdjM19jb3Jl
X3NldHVwX2dsb2JhbF9jb250cm9sKHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+ICAgICAgICAg
dTMyIHJlZzsNCj4gKyAgICAgICB1bnNpZ25lZCBpbnQgcG93ZXJfb3B0Ow0KPiArICAgICAgIHVu
c2lnbmVkIGludCBod19tb2RlOw0KDQpVc2UgcmV2ZXJzZSBjaHJpc3RtYXMgdHJlZSBkZWNsYXJh
dGlvbiBzdHlsZToNCg0KCXR5cGUxIGFiY2RlZmcNCgl0eXBlMiBhYmNkZQ0KCXR5cGUzIGFiYw0K
DQo+ICANCj4gICAgICAgICByZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HQ1RMKTsN
Cj4gICAgICAgICByZWcgJj0gfkRXQzNfR0NUTF9TQ0FMRURPV05fTUFTSzsNCj4gKyAgICAgICBo
d19tb2RlID0gRFdDM19HSFdQQVJBTVMwX01PREUoZHdjLT5od3BhcmFtcy5od3BhcmFtczApOw0K
PiArICAgICAgIHBvd2VyX29wdCA9IERXQzNfR0hXUEFSQU1TMV9FTl9QV1JPUFQoZHdjLT5od3Bh
cmFtcy5od3BhcmFtczEpOw0KPiAgDQo+IC0gICAgICAgc3dpdGNoIChEV0MzX0dIV1BBUkFNUzFf
RU5fUFdST1BUKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXMxKSkgew0KPiArICAgICAgIHN3aXRjaCAo
cG93ZXJfb3B0KSB7DQo+ICAgICAgICAgY2FzZSBEV0MzX0dIV1BBUkFNUzFfRU5fUFdST1BUX0NM
SzoNCj4gICAgICAgICAgICAgICAgIC8qKg0KPiAgICAgICAgICAgICAgICAgICogV09SS0FST1VO
RDogRFdDMyByZXZpc2lvbnMgYmV0d2VlbiAyLjEwYSBhbmQgMi41MGEgaGF2ZSBhbg0KPiBAQCAt
OTk4LDYgKzEwMDIsMTggQEAgc3RhdGljIHZvaWQgZHdjM19jb3JlX3NldHVwX2dsb2JhbF9jb250
cm9sKHN0cnVjdCBkd2MzDQo+ICpkd2MpDQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAg
ICAgICB9DQo+ICANCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIFdPUktBUk9VTkQ6IERXQ191
c2IzMSB2ZXJzaW9uIDIuMDBhIGhhdmUgYW4gaXNzdWUgdGhhdCB3b3VsZA0KPiArICAgICAgICAq
IGNhdXNlIGEgQ1NSIHJlYWQgdGltZW91dCBXaGVuIENTUiByZWFkIGNvaW5jaWRlcyB3aXRoIFJB
TQ0KPiArICAgICAgICAqIENsb2NrIEdhdGluZyBFbnRyeS4NCg0KTm90ZSBpbiB0aGUgY29tbWVu
dCBhbmQgY29tbWl0IG1lc3NhZ2UgdGhhdCB0aGlzIGFwcGxpZXMgd2hpbGUgb3BlcmF0aW5nDQph
cyBob3N0IG1vZGUuIEFkZCB0aGUgU1RBUiBudW1iZXIgcmVmZXJlbmNlIGluIHRoZSBjb21taXQg
bWVzc2FnZS4NCg0KPiArICAgICAgICAqDQo+ICsgICAgICAgICogVGhpcyB3b3JrYXJvdW5kIHNv
bHV0aW9uIGRpc2FibGUgQ2xvY2sgR2F0aW5nLCBzYWNyaWZpY2luZw0KPiArICAgICAgICAqIHBv
d2VyIGNvbnN1bXB0aW9uIGZvciBub3JtYWwgb3BlcmF0aW9uLg0KPiArICAgICAgICAqLw0KPiAr
ICAgICAgIGlmIChwb3dlcl9vcHQgIT0gRFdDM19HSFdQQVJBTVMxX0VOX1BXUk9QVF9OTyAmJg0K
PiArICAgICAgICAgICBod19tb2RlICE9IERXQzNfR0hXUEFSQU1TMF9NT0RFX0dBREdFVCAmJiBE
V0MzX1ZFUl9JUyhEV0MzMSwgMjAwQSkpDQo+ICsgICAgICAgICAgICAgICByZWcgfD0gRFdDM19H
Q1RMX0RTQkxDTEtHVE5HOw0KPiArDQoNClRoYW5rcywNClRoaW5o

