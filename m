Return-Path: <linux-kernel+bounces-278768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE2594B485
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B327283382
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6185179CC;
	Thu,  8 Aug 2024 01:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TQub2hHu";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MZcf7ESB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="oZV/0U0c"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5382913;
	Thu,  8 Aug 2024 01:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079754; cv=fail; b=QPatjgB4sPOtUzffItakK+tQFFIVhDC2Tn8aFPJjYTVP614suBNmsop1678W2iF6AcgFb11fP5WI5IwUAwND2x+0CnGa0Hs3Os1VYaldrOruOAgpqiMP3Ym8jwkngi+pkg/YY8IRb0S/N8O7HrOEoRm1DFWzUsXFB288HV3kltQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079754; c=relaxed/simple;
	bh=rDzwVGIxD5Y6xmIJ/FX59InRrtOSZr4Fhs0w1i2ftmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tvtAlT2718Pu4Q0pePJrAjqWbw04t2rWxG4xjMUdCbq5qUz6u/hKVLctQFMO2I03dRWY8f2hj/w3yvN7BEj/b3hMThU6vVaVZ0Jo46GTExc1q7HB0fY6KraatPWlMy+f5UCsri2F1qign17+xPnH5rtR6N/Ksl2FAGDhumzu7Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TQub2hHu; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MZcf7ESB; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=oZV/0U0c reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477MmccW021832;
	Wed, 7 Aug 2024 18:15:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=rDzwVGIxD5Y6xmIJ/FX59InRrtOSZr4Fhs0w1i2ftmI=; b=
	TQub2hHu2kj9uyt9L4fYWug5vNlxMnF31GkEmJucn8a3gYVd4OiMem4mwnsoDVhk
	7J0uzTS2tg3braBVkykCdaKRxpo8aa/DqHtuZB7WzAlSlLoA2uQ1XFL/24MhHfWk
	UrItW7mST1outD7r53QeydUJeuRFU8IipNgLL5vrhaGqzTZmiUWrcCRL4nJ8z0C/
	obvNjwmiEoTrQpwnaThCMcrwbVPP85VeATBrNFXuOYP9IjK64gi/QgkSZHOSDd8A
	3WqCQZaEJZkhe9M49P8Tn1PDqfoiIuqah70aIvsMENIf2Yp6q2+cFcpJMCdeNfmv
	Cc6sOOFTIYTR9IP4L60jUA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uuj5xs7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 18:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723079746; bh=rDzwVGIxD5Y6xmIJ/FX59InRrtOSZr4Fhs0w1i2ftmI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MZcf7ESBhLUMJv+l3rSQndDGp+oB2Qnt3Wltra/CCX4EZAP/9FRsR1ENiUpTFUxfA
	 2YIP1x4TUMIRaXziGmN5Yr53IyBm0++zBqOWd484vjQ2Np+fIaVCjuO2gFAL7T/4iC
	 3OMnxeslHdzeGb6X/QRJce/SWNR1knVGlMQIP2FRsVyo7JzjqWQy6z+q1Y88eqjvxE
	 IAAUPQAj3MWV95CdS9Nf7agxK1cZFmP4myvDkh358M+Rusy1tjS3VFBbAevmvQEFo6
	 pWdIsNc8TBUyhYjt++QUXnUVpIHa/1siAbpjPcUG2ztxLal/2pzR9srQNV7noAxAqw
	 G3TO1u3JptV3w==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D41364052D;
	Thu,  8 Aug 2024 01:15:46 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 1FCFFA009F;
	Thu,  8 Aug 2024 01:15:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=oZV/0U0c;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C288A40352;
	Thu,  8 Aug 2024 01:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gj9zg/4uxi8c3hFx4W0y+GFL+NxchnSl2jRjakqoPufMdyrIS1FUQJM0rT46WfkoRXk3iYYFHvtKRP5hCMo8HIh+tiH/eu6vWl1B2Gy+J9XE+vTs9NEI42wNsQMJQVclJQfPgySsVYNfRacjEZm7tfUvJmKvmnYSfGGDPRr0NyaBdsg3wn3IFZ2yxOq/KULUAt3QFQsRL3buJw9UWy4YVbsJlZpMKV5ksf3SxydITik0/kv58ibrbSzk29936bhrWlCXv6maYghVmgEbpHpBtkB7Q1eDd8nYzLKtCRZe/wwUCtyjUDx9Q/0I1EgVDr3OZJVk1Qj4EcXDNSyLDXO1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDzwVGIxD5Y6xmIJ/FX59InRrtOSZr4Fhs0w1i2ftmI=;
 b=riMHhJOYLYfrLxTPE50oHQKBx6Hyx85POFuPZulNxq8JSaEmSmeu7oqXO/ALs3tjiN4f7ZROKh4rzXxEsppVpHaSzP8M/Q9y1x1Yba2U8yY66TVuS2s0jemh6bdI1mqCaAeuuZg877wFCDGV0P13/346ATYD1HZCE+yh9VKsSM3A3mt1wNWvkPItO+ztwILrIeiN0MkLV/XvJ9awGug622ZuBN0mlDZpgVpDOD2eBorA3U8OvtwuLPB3pwIdg9PalZ2YxpHzI0S9KjC3N0TACtxC9r1P6KEv+r+NtbEK6U5iLPuVXDBq7/cQMvsvY7b49kILZmxjkcyWXkiwgo0cYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDzwVGIxD5Y6xmIJ/FX59InRrtOSZr4Fhs0w1i2ftmI=;
 b=oZV/0U0c305JccKu0I00LJpN8yBBqIcS/UYeG4IT9wYNHjTGIr39OptlpOFS/p0Z1n0CCpBnZ2yBS9WjvRFGeL85Fj7QO5ieDbTpO2qATIpJag6m7NzktGbcDVCl424jYZo1T4tHYggY3b8rrAeEVI7TREIamGt1shuvWAniaOQ=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 01:15:42 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 01:15:41 +0000
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
Thread-Index: AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AA==
Date: Thu, 8 Aug 2024 01:15:41 +0000
Message-ID: <20240808011536.oid627ez4ppdfkhp@synopsys.com>
References:
 <CGME20240719110149epcas5p3dd468685a095c094ed2e540279bf3ec2@epcas5p3.samsung.com>
 <20240719110100.329-1-selvarasu.g@samsung.com>
 <20240807003806.5owtgwgw2lczg4u5@synopsys.com>
 <b6baeb45-1684-4fcb-8c71-392cb4788c85@samsung.com>
In-Reply-To: <b6baeb45-1684-4fcb-8c71-392cb4788c85@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BY5PR12MB4164:EE_
x-ms-office365-filtering-correlation-id: 646739c3-b043-4dfc-9af2-08dcb7479ea1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnZjMlRnVXlDRXMycmJhS1ExcTN1cGpENkpTRU9lTzNadUdUYUhweFlSNUZK?=
 =?utf-8?B?Y2xhQmd2cDZXUDN0L2wxNDdlaHFXaUtkRkJwZ1liSFhCdC9TNXJubVZnUHQ5?=
 =?utf-8?B?c3M5cTlxVzBYeVlwcGVPdGtDSzRIZWw5VVY5V3ZFZFZLSVZNL3pMNXdzOXAw?=
 =?utf-8?B?VTh1M1hTMzA3M0xMNGhJd0VjZjUwWXloOTE3MzhkcUdDWElDZVU0NEx3OXFu?=
 =?utf-8?B?L3Q4bVkvendhNmRxY2I5bUIrYWQ5NVhGOU1DbnpsRGtPVFBRd2QzMEx6cFZi?=
 =?utf-8?B?MjJBUCtnK3dac05CYUV3cmVWVHk2a3d3OHBOWWw4bzcrRi9JZW01amVHM0xD?=
 =?utf-8?B?TGdDTFZObTE1QlFOWXFXNk1TUFNlYVlEWU5TRFppUXM1SmhmK2FRdEZnQStm?=
 =?utf-8?B?a3BiUTV1aUFQK2graFZNUXI4WmdmZWxwQmRtalhqbHBiVmFJNDNjbjQ4Nzln?=
 =?utf-8?B?eEU4aWVYUkljNDNJc2hWckNaRGpRSE1qUTlnYXNSTnVTb2FZcGVNMkorRmNn?=
 =?utf-8?B?UDAwYkFtdk13QlNiNzg1Rm1tWVZZOS9WbDdmNmVrTEx1NUMvUlRsb01XN1JN?=
 =?utf-8?B?V2RQOXJGNDR5dTIyMHZyV0EzbUFvbzZEaTA5S1ZSdFQ5M2ppRnVzUExYd3RT?=
 =?utf-8?B?eTVDOWF1NDJIS21qUXZIRTZpaldleUFDVndtdFd3cW1VYnVoMWlHVzNpZE1H?=
 =?utf-8?B?SkZPK2I2Z2F3ZGNKWERDUWx3MUlqcHhXQXFQVjBwbEtNQUNzNXJKbk14akhz?=
 =?utf-8?B?bVJaK3NDcGZpS2piWmdMS0dVc2Z1WXAyL1VqMmh2QW5GMWFLRXVEc3FiUjFE?=
 =?utf-8?B?STJ5d1N2bklITFVjYzVBbnZyQ1NLa2ZpOHdtb0RaMm5HaFZkSFBpM0VmZno4?=
 =?utf-8?B?Nm9WVURyZ0svVlg1bE5mQVdhZHhodHBTc1BxcW10dTVhUHhzUElid0twT2JQ?=
 =?utf-8?B?emVTbnVpZ3JGcngvcWxXL0gvbUw2NGJLd2V5c0g3WHg1amRpMExyUGNwdjFs?=
 =?utf-8?B?RWRuQ1crNXk4VGgwYjdseDdoWmFlaWo3clFQTk9YQkxDQVRndHBJZTNGSWVE?=
 =?utf-8?B?UC9JM3NSZDZlSitFSE9XOU81VjhudXh3WXdkZ1BjQzU5b3JqdmZRNGtPT1JT?=
 =?utf-8?B?b2VIb2Jrb3ZWcUFkU2s3WitkQ081MDBwMzJMU2Jhd1Y3RFZDUXo2OGNkOVpV?=
 =?utf-8?B?MTFBNFZwREg3WlRjQ202MTdqajkwTXhTV0xYOENTRjhzVTlZR3JKRXM5RC9R?=
 =?utf-8?B?STh5UzJFQlFYVS9jaWp3TThqWXhXSnJxZ25yOWhmWVZwNjdlbG83UjRQZW0r?=
 =?utf-8?B?ZnRzOGVwbzJjL3MvQmpET2tKNjY1YmgrRktkb1FvTHpITVZ4Sk5oZXAzcmhr?=
 =?utf-8?B?WSs4OHhsKzBHK0dLNDVhaWk2d1QwTDRzekVCRnpxb0pVYU8zY2tYYzVDeTZs?=
 =?utf-8?B?VURrN0prdmVORk5ybm5ZV3RRTUFnTnF6RTQ5YnFvejN4YTJMQjJLSWY1NWNE?=
 =?utf-8?B?aVlNd0JZVzhWcXBXcEtmVEZQMStqRnZJeFgyK0krdkZheURVTzJxWjQwNUJo?=
 =?utf-8?B?YkN6YU5iYis3SHhCa044RFJqZUtCTlM0M1Y4c3N2K2VpWWxZQitndEUwY29D?=
 =?utf-8?B?RHF3cS9UdTlETWJ2RW90VmJ5THFMZGNKQ2R2SXoyOEFoaU9FVVFHNHd4TzM3?=
 =?utf-8?B?VEJ3bE9nTUdKWEJFbzVjV0pyS1Q2eU14KzhIYUVDVko3MGpTVTZNUC9vTjAr?=
 =?utf-8?B?Tmd3UE9BcmpuM2xjQ0lnbm5pb0VpekZYNHhvUEdheGlNMVJHNkp3Sk5xN0sx?=
 =?utf-8?Q?Zz2s2MT7wdNBUg6mfqm36PoM4wUzs5Ca+DFYk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFVlVzJuSnFzem4wOTU3Z3pnRlRwZnZSTmtqTmIzZWw3bDM5MklvREtwSzM1?=
 =?utf-8?B?SVM5ak8wRU5UYkJiWldDT0NiWUJzbDZUUGQ3cXNNRmNBaGtiMmd0V291VE53?=
 =?utf-8?B?NlVMbERJSmVhVGxBTnR2c3h1c0NSUk9BT3BmQWtqQnVqeHpTK1Fzbk0wMFVE?=
 =?utf-8?B?YTlaWmVEWFFYRjE5ajEvZnZsc0ljUEVlbjlyeDFXOE5PWENhNk1yZHN4ditj?=
 =?utf-8?B?cFlCK3B0eEVQZjV1d0Rjc3FNTGtTMFVETG0yLzhzV2E0VzA3czk1NWJnMTRj?=
 =?utf-8?B?WEZRSnhERUNMMWJ6TEZucm81RGMzOEQzRnpYb2NNU2xqS1pCbEl2NEVFSDFS?=
 =?utf-8?B?d3Izb056OEpET1BTWTQvRW0xanBjUDExVVZYTTRqTzlsaFl1ZDhYdkxueGFY?=
 =?utf-8?B?U1ltSUNVZlY2TzlObWVOQkUxY0lORjRwVGRyV3hOYk5rVzhoT2xMMmxhS3l0?=
 =?utf-8?B?L0VTbnhFZlBkRzVCTFVpc0lKdkMzdENJOUFyakhLL1UvcnJkcko3VzVxWUh3?=
 =?utf-8?B?RUtndGlydXBjeW9QMktOS3VtazFvNWV6djhZME9NR3NLUy9jcmpHckJldThh?=
 =?utf-8?B?Q2ExVHNpSnpxSkJXSkxjYkNMaWhvYXBjcEFKcGFsY3V3aVFnTGV6elA5YnJo?=
 =?utf-8?B?VG13clVKeldTekY2TlRCRll1d0RsVXBHSzFkeVB5Zm10M2xSay9GOGlPVENp?=
 =?utf-8?B?OGtoaFNGMUlWejRySnlvMnluV0JRTmpTdXhOM2VudXk5SmJyRXdkZjUybVhs?=
 =?utf-8?B?TE9WRUcvTkdrT09BNlNyMUs4cHBZNHl2ak5HUlJER2pldERTQjl0S3AvQTZi?=
 =?utf-8?B?dEZmR2dkUkEvSUNXbGczVk4vbHNrbWU5c09FeEw5dWhNWjdZOUtYVlNlU0t4?=
 =?utf-8?B?TWVYdTVJQzZ2aFo2T3dYZU1WWGtoc0JYYk5xVERkOEdTdTBiUldTWTN5UnVq?=
 =?utf-8?B?OFQvblNoT1lNOFpuRzZwK09BMks4Mm5hYnJ1alpxZ3JnSTBHYVM2UVA4eUdq?=
 =?utf-8?B?MGJZZkEzdW1nM0JNK0FzYnJNSStaUEx3eG5hTVphMVd6Nk9tVmJuOUJGZkxW?=
 =?utf-8?B?bkh6NWppOWt0SW4xbmpQdXhjdkZLc2tMaStnVHYzK09uTm5US1FiVStzL25K?=
 =?utf-8?B?bklHOTFXOXF1TDFCOEpyYnY0MnZKTEQ0d2V5MWJzTDFEWmZBQzcxS1JXcTdN?=
 =?utf-8?B?Sk9TeXJIcXluMXJCdm9PYnZUeTMxQjNQeHE3VUxlcFdET0Zldng3dTdpbmhM?=
 =?utf-8?B?TlZzOStwdGpDNnpiV2xtOG5MKzhtNU1HR0tFQjBJeUlnZGVyWnlrM1h1SVhL?=
 =?utf-8?B?YU9oeE5KcFdqS2Y4WlRLS1pQUFF0Vk1PVVp4MitkeCtTS2J2WEFNRDNQM3M1?=
 =?utf-8?B?NDhnNzd2NG5WbUNNTUJjRUtObFRoTTM1UzY5cGZweEZDS3hRc3htMkx6bzR0?=
 =?utf-8?B?SlJyMFc4SDJTd1J5OEtkZUVTa3Q5eSsxSGNobFp5WEY3dEFZTGZNckdZcjZv?=
 =?utf-8?B?ZVRjQUxNUWRyVWVNK2xNVVMzZ21mQmlyQzkySmdoZmtjTFJpR2pwcXVEMWEw?=
 =?utf-8?B?N01oUFpuU3k3VEg2b0N5S1Z0dW5GSi9qWWJYYjNKcmpGbDBDS0NqdFhlRE1v?=
 =?utf-8?B?UnVXUEFNTWxnaVVjMnhXeGUyS21Xa1BkSjh0OGRJbHlSM0ZsdkRwaHEzV0JT?=
 =?utf-8?B?ajZnYWNON1I0cElERHpxcWFoUlI5b1FuM0lDRUR1cGtyZXpEang3dTZ4SlpE?=
 =?utf-8?B?Q05acUIwUDRzbXg3MUZUR3k2bnZ3aGE2UGsyU1diaGkzRXNqZU11bUhSaEhC?=
 =?utf-8?B?VXU1aFkzTVVQbERMNWNlSXI3b0g3b0lDUU9RTzJLM2thTzYyUVdhYlRiTUFO?=
 =?utf-8?B?bDh5WVg0VlJDVGRtZFhiOHNRblZtakRCOVhKemI0Y1R5WHhsZHJybzV4MVps?=
 =?utf-8?B?N1Fpa1hFaTBBWDd2OE1WdnN6M2tkUDVsTzJjUTFnVWFHcUt5d0lEd1p5UWJt?=
 =?utf-8?B?QU1MRTkwU0RZb2N5alhSeFpGbjM4bmxMYmRzYk9NT1NJenhVRWtsMzBXSzA4?=
 =?utf-8?B?ekx5ZnZjdENLV0NwUXV2VWJESmwvWTJ2WkFIOHlqVlNUSTMyb2NRTG53Yk1G?=
 =?utf-8?Q?NQ6iMlZMHgjm+h+yJQYPDQqqC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABB4E117F1542340A61DFAEBF219112E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9CQ3WQSVJfFBnd3bdb+/NxOf7IEcajQCg25it+J+Lu9YV+OeLGNPcNFSYH+m4N9UXfKBPINSRVXvZgnzX3bpo7zjbHxTYMyUrI29WZVFotH/qm+XkloT9EO2Zk03AgPyXATZbbdlia2vydEsqNMkrfXeRGuzoqPQ2Fz964xjgHrDR0GeN45EpnKDjTQzoBiouF37sbjH9jFPgb7fj58dxbv3CBvIxeOkZygLXZOP0FQU/8s30uEqdWfReB6YTkolQ1CycgoX6CMeG/IiycgYM61cs/i53Gexdk6aCxkTyeMgAhnWHnKtaYNdDQ/mIRlO4il5XPUfLW17/wAqpHVNScew34ueXkts4QJV6uvYTJm9r/lLpfRTJWoEry+CnPrqb6tpdWqq46qtBNWbsGkRfn1bNs8gIPWxQ/PAn59GXyeU1dv4fqWCZmyV5amRCqJ99gfLPw5LDrOs5BOzaWSBTQeONk4KN643TO0xECwRrLckJ8Gj4aFKn68TqZgeyCdFr8v1qKZhWuqzzXIthDjWSfzcc5P4fRJKoxw81oIQwsyOMOSLF0FwwGSErH1OnFGXpcaH617h2znPj6fLziHk16a+KpFEPoMycKh1+1D2UISnc4lDj7op0tYxUl9j5o8/g/y2RrPiyaQCW0ZMA0MqzQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646739c3-b043-4dfc-9af2-08dcb7479ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 01:15:41.1165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vo2PWZEqQFUKDUwVc4zUyUgOWOOP52UU21suRb9tqFYoQ4pjduBVIn6GNYIYFlSLDdYh99ymP7vpENSwn/FomA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
X-Proofpoint-ORIG-GUID: bOcOwJgcGgs-SxBblVUacy1kbSNgDsau
X-Proofpoint-GUID: bOcOwJgcGgs-SxBblVUacy1kbSNgDsau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_15,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408080006

T24gV2VkLCBBdWcgMDcsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
OC83LzIwMjQgNjowOCBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIEZyaSwgSnVsIDE5
LCAyMDI0LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4gPj4gSW4gY2VydGFpbiBzY2VuYXJp
b3MsIHRoZXJlIGlzIGEgY2hhbmNlIHRoYXQgdGhlIENQVSBtYXkgbm90IGJlDQo+ID4+IHNjaGVk
dWxlZCB0aGUgYm90dG9tIGhhbGYgb2YgZHdjMyBpbnRlcnJ1cHQuIFRoaXMgaXMgYmVjYXVzZSB0
aGUgQ1BVDQo+ID4+IG1heSBoYW5nIHVwIHdoZXJlIGFueSB3b3JrIHF1ZXVlIGxvY2t1cCBoYXMg
aGFwcGVuZWQgZm9yIHRoZSBzYW1lIENQVQ0KPiA+PiB0aGF0IGlzIHRyeWluZyB0byBzY2hlZHVs
ZSB0aGUgZHdjMyB0aHJlYWQgaW50ZXJydXB0LiBJbiB0aGlzIHNjZW5hcmlvLA0KPiA+PiB0aGUg
VVNCIGNhbiBlbnRlciBydW50aW1lIHN1c3BlbmQgYXMgdGhlIGJ1cyBtYXkgaWRsZSBmb3IgYSBs
b25nZXIgdGltZQ0KPiA+PiAsIG9yIHVzZXIgY2FuIHJlY29ubmVjdCB0aGUgVVNCIGNhYmxlLiBU
aGVuLCB0aGUgZHdjMyBldmVudCBpbnRlcnJ1cHQNCj4gPj4gY2FuIGJlIGVuYWJsZWQgd2hlbiBy
dW50aW1lIHJlc3VtZSBpcyBoYXBwZW5pbmcgd2l0aCByZWdhcmRsZXNzIG9mIHRoZQ0KPiA+PiBw
cmV2aW91cyBldmVudCBzdGF0dXMuIFRoaXMgY2FuIGxlYWQgdG8gYSBkd2MzIElSUSBzdG9ybSBk
dWUgdG8gdGhlDQo+ID4+IHJldHVybiBmcm9tIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciBieSBjaGVj
a2luZyBvbmx5IHRoZSBldnQtPmZsYWdzIGFzDQo+ID4+IERXQzNfRVZFTlRfUEVORElORywgd2hl
cmUgdGhlIHNhbWUgZmxhZyB3YXMgc2V0IGFzIERXQzNfRVZFTlRfUEVORElORw0KPiA+PiBpbiBw
cmV2aW91cyB3b3JrIHF1ZXVlIGxvY2t1cC4NCj4gPj4gTGV0J3MgY29uc2lkZXIgdGhlIGZvbGxv
d2luZyBzZXF1ZW5jZXMgaW4gdGhpcyBzY2VuYXJpbywNCj4gPj4NCj4gPj4gQ2FsbCB0cmFjZSBv
ZiBkd2MzIElSUSBhZnRlciB3b3JrcXVldWUgbG9ja3VwIHNjZW5hcmlvDQo+ID4+ID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+PiBJUlEg
IzE6DQo+ID4+IC0+ZHdjM19pbnRlcnJ1cHQoKQ0KPiA+PiAgICAtPmR3YzNfY2hlY2tfZXZlbnRf
YnVmKCkNCj4gPj4gICAgICAgICAgLT5pZiAoZXZ0LT5mbGFncyAmIERXQzNfRVZFTlRfUEVORElO
RykNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBJUlFfSEFORExFRDsNCj4gPj4g
ICAgICAgICAgLT5ldnQtPmZsYWdzIHw9IERXQzNfRVZFTlRfUEVORElORzsNCj4gPj4gICAgICAg
ICAgLT4vKiBEaXNhYmxlIGludGVycnVwdCBieSBzZXR0aW5nIERXQzNfR0VWTlRTSVpfSU5UTUFT
SyAgaW4NCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgRFdDM19HRVZOVFNJWg0KPiA+PiAgICAgICAgICAtPnJldHVybiBJUlFfV0FL
RV9USFJFQUQ7IC8vIE5vIHdvcmtxdWV1ZSBzY2hlZHVsZWQgZm9yIGR3YzMNCj4gPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aHJlYWRfZnUgZHVlIHRvIHdvcmtxdWV1
ZSBsb2NrdXANCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBldmVu
IGFmdGVyIHJldHVybiBJUlFfV0FLRV9USFJFQUQNCj4gPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBmcm9tIHRvcC1oYWxmLg0KPiA+Pg0KPiA+PiBUaHJlYWQgIzI6DQo+
ID4+IC0+ZHdjM19ydW50aW1lX3Jlc3VtZSgpDQo+ID4+ICAgLT5kd2MzX3Jlc3VtZV9jb21tb24o
KQ0KPiA+PiAgICAgLT5kd2MzX2dhZGdldF9yZXN1bWUoKQ0KPiA+PiAgICAgICAgLT5kd2MzX2dh
ZGdldF9zb2Z0X2Nvbm5lY3QoKQ0KPiA+PiAgICAgICAgICAtPmR3YzNfZXZlbnRfYnVmZmVyc19z
ZXR1cCgpDQo+ID4+ICAgICAgICAgICAgIC0+LypFbmFibGUgaW50ZXJydXB0IGJ5IGNsZWFyaW5n
ICBEV0MzX0dFVk5UU0laX0lOVE1BU0sgaW4NCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRFdDM19HRVZOVFNJWiovDQo+ID4+DQo+
ID4+IFN0YXJ0IElSUSBTdG9ybWluZyBhZnRlciBlbmFibGUgZHdjMyBldmVudCBpbiByZXN1bWUg
cGF0aA0KPiA+PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NCj4gPj4gQ1BVMDogSVJRDQo+ID4+IGR3YzNfaW50ZXJydXB0KCkNCj4gPj4g
ICBkd2MzX2NoZWNrX2V2ZW50X2J1ZigpDQo+ID4+ICAgICAgICAgIGlmIChldnQtPmZsYWdzICYg
RFdDM19FVkVOVF9QRU5ESU5HKQ0KPiA+PiAgICAgICAgICAgcmV0dXJuIElSUV9IQU5ETEVEOw0K
PiA+Pg0KPiA+PiBDUFUwOiBJUlENCj4gPj4gZHdjM19pbnRlcnJ1cHQoKQ0KPiA+PiAgIGR3YzNf
Y2hlY2tfZXZlbnRfYnVmKCkNCj4gPj4gICAgICAgICAgaWYgKGV2dC0+ZmxhZ3MgJiBEV0MzX0VW
RU5UX1BFTkRJTkcpDQo+ID4+ICAgICAgICAgICByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4+IC4u
DQo+ID4+IC4uDQo+ID4+DQo+ID4+IFRvIGZpeCB0aGlzIGlzc3VlIGJ5IGF2b2lkaW5nIGVuYWJs
aW5nIG9mIHRoZSBkd2MzIGV2ZW50IGludGVycnVwdCBpbg0KPiA+PiB0aGUgcnVudGltZSByZXN1
bWUgcGF0aCBpZiBkd2MzIGV2ZW50IHByb2Nlc3NpbmcgaXMgaW4gcHJvZ3Jlc3MuDQo+ID4+DQo+
ID4+IFNpZ25lZC1vZmYtYnk6IFNlbHZhcmFzdSBHYW5lc2FuIDxzZWx2YXJhc3UuZ0BzYW1zdW5n
LmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCA4ICsrKysr
Ky0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPj4gaW5kZXggY2I4MjU1NzY3OGRkLi42MTA3OTJhNzA4
MDUgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4+IEBAIC01NDksOCArNTQ5LDEyIEBAIGludCBk
d2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoc3RydWN0IGR3YzMgKmR3YykNCj4gPj4gICAJCQlsb3dl
cl8zMl9iaXRzKGV2dC0+ZG1hKSk7DQo+ID4+ICAgCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdD
M19HRVZOVEFEUkhJKDApLA0KPiA+PiAgIAkJCXVwcGVyXzMyX2JpdHMoZXZ0LT5kbWEpKTsNCj4g
Pj4gLQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRTSVooMCksDQo+ID4+IC0JCQlE
V0MzX0dFVk5UU0laX1NJWkUoZXZ0LT5sZW5ndGgpKTsNCj4gPj4gKw0KPiA+PiArCS8qIFNraXAg
ZW5hYmxlIGR3YzMgZXZlbnQgaW50ZXJydXB0IGlmIGV2ZW50IGlzIHByb2Nlc3NpbmcgaW4gbWlk
ZGxlICovDQo+ID4+ICsJaWYgKCEoZXZ0LT5mbGFncyAmIERXQzNfRVZFTlRfUEVORElORykpDQo+
ID4+ICsJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HRVZOVFNJWigwKSwNCj4gPj4gKwkJ
CQlEV0MzX0dFVk5UU0laX1NJWkUoZXZ0LT5sZW5ndGgpKTsNCj4gPj4gKw0KPiA+PiAgIAlkd2Mz
X3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRDT1VOVCgwKSwgMCk7DQo+ID4+ICAgDQo+ID4+
ICAgCXJldHVybiAwOw0KPiA+PiAtLSANCj4gPj4gMi4xNy4xDQo+ID4+DQo+ID4gV2UncmUgbm90
IHdha2luZyB1cCBmcm9tIGEgaGliZXJuYXRpb24uIFNvIGFmdGVyIGEgc29mdC1yZXNldCBhbmQN
Cj4gPiByZXN1bWUsIHRoZSBldmVudHMgdGhhdCB3ZXJlbid0IHByb2Nlc3NlZCBhcmUgc3RhbGUu
IFRoZXkgc2hvdWxkIGJlDQo+ID4gcHJvY2Vzc2VkIHByaW9yIHRvIGVudGVyaW5nIHN1c3BlbmQg
b3IgYmUgZGlzY2FyZGVkIGJlZm9yZSByZXN1bWUuDQo+ID4NCj4gPiBUaGUgc3luY2hyb25pemVf
aXJxKCkgZHVyaW5nIHN1c3BlbmQoKSB3YXMgbm90IHN1ZmZpY2llbnQgdG8gcHJldmVudA0KPiA+
IHRoaXM/IFdoYXQgYXJlIHdlIG1pc3NpbmcgaGVyZS4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBU
aGluaA0KPiBJIGRvbuKAmXQgdGhpbmsgdGhlIHRyaWdnZXJpbmcgb2YgaW50ZXJydXB0IHdvdWxk
IG5vdCBiZSBzdG9wcGVkIGV2ZW4gaWYgDQo+IGRvIHNvZnQgcmVzZXQuIEl0J3MgYmVjYXVzZSBv
ZiBldmVudCBjb3VudCBpcyBtYXkgYmUgdmFsaWQgLg0KDQpPay4gSSB0aGluayBJIHNlZSB3aGF0
IHlvdSdyZSByZWZlcnJpbmcgdG8gd2hlbiB5b3Ugc2F5ICJldmVudCBpcw0KcHJvY2Vzc2luZyBp
biB0aGUgbWlkZGxlIiBub3cuDQoNCldoYXQgeW91IHdhbnQgdG8gY2hlY2sgaXMgcHJvYmFibHkg
dGhpcyBpbiBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoKS4NClBsZWFzZSBjb25maXJtOg0KDQpp
ZiAoZHdjLT5wZW5kaW5nX2V2ZW50cykNCglkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR0VW
TlRTSVooMCksDQoJCQlEV0MzX0dFVk5UU0laX0lOVE1BU0sgfCBEV0MzX0dFVk5UU0laX1NJWkUo
ZXZ0LT5sZW5ndGgpKTsNCmVsc2UNCglkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRT
SVooMCksIERXQzNfR0VWTlRTSVpfU0laRShldnQtPmxlbmd0aCkpOw0KDQo+IExldCBjb25zaWRl
ciB0aGUgc2NlbmFyaW9zIHdoZXJlIFNXIGlzIG5vdCBhY2tub3dsZWRnZSB0aGUgZXZlbnQgY291
bnQgDQo+IGFmdGVyIGdldHRpbmcgYSBpbnRlcnJ1cHQgd2l0aCBkaXNhYmxlIEdFVk5UU0laX0lO
VE1BU0sgPTAuIEl0IHdpbGwgDQo+IHRyaWdnZXJpbmcgdGhlIHNwdXJpb3VzIGludGVycnVwdHMg
dW50aWwgZW5hYmxlIEdFVk5UU0laX0lOVE1BU0s9MSBvciANCj4gYWNrbm93bGVkZ2UgdGhlIGV2
ZW50IGNvdW50IGJ5IFNXLiBUaGlzIGlzIGhhcHBlbmluZyBoZXJlIGJlY2F1c2Ugb2YgV2UgDQo+
IGp1c3QgcmV0dXJuIGZyb20gaW50ZXJydXB0IGhhbmRsZXIgYnkgY2hlY2tpbmcgaWYgZXZ0LT5m
bGFncyBhcyANCj4gRFdDM19FVkVOVF9QRU5ESU5HLiBDbGVhcmluZyBvZiBEV0MzX0VWRU5UX1BF
TkRJTkcgZmxhZyBpcyBkb25lIGluIA0KPiBkd2MzX3RocmVhZF9pbnRlcnJ1cHQuIEluIHNvbWUg
c2NlbmFyaW8gaXQncyBub3QgaGFwcGVuaW5nIGR1ZSB0byBjcHUgDQo+IGhhbmd1cCBvciB3b3Jr
IHF1ZXVlIGxvY2t1cC4NCg0KVGhpcyBjYW4gYmUgbWl0aWdhdGVkIGJ5IGFkanVzdGluZyB0aGUg
aW1vZF9pbnRlcnZhbCAoaW50ZXJydXB0DQptb2RlcmF0aW9uKS4gSGF2ZSB5b3UgdHJpZWQgdGhh
dD8NCg0KVGhhbmtzLA0KVGhpbmgNCg0KPiANCj4gVGhlIHNhbWUgaXNzdWUgd2FzIHJlcG9ydGVk
IGVhcmxpZXIgYW5kIG5vdCBkZXJpdmVkIGFjdHVhbCByb290IGNhdXNlIA0KPiBmcm9tIFVTQiBk
d2MzIGRyaXZlciBwb2ludCBvZiB2aWV3LCBhbmQgc29tZWhvdyB3ZSBtYW5hZ2luZyBmaXggd2l0
aCBvdXIgDQo+IHZlbmRvciBrZXJuZWwgYnkgdXNpbmcga3JldHByb2JlLg0KPiANCj4gVG8gZml4
IHRoaXMgaXNzdWUsIFdlIGhhdmUgdG8gcmVzZXQgdGhlIGV2dC0+ZmxhZ3Mgb3Igc3RvcCBkaXNh
YmxlwqAgDQo+IEdFVk5UU0laX0lOVE1BU0s9MA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzIwMjMwMTAyMDUwODMxLjEwNTQ5
OS0xLWpoMDgwMS5qdW5nQHNhbXN1bmcuY29tL19fOyEhQTRGMlI5R19wZyFiMFVqN052WXpXcXJ2
TktPcmtrWGFZLWc0VWFzby1wVzUyMEFZMmZCZGxxbUpldWRVbm1kc2dwbkwxWXhBWmF3MnlkeWcy
TS1YemhldGJDcmFLeEphNUMzTkJRJCANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8xNjQ2NjMwNjc5LTEyMTU4NS0xLWdpdC1z
ZW5kLWVtYWlsLWpoMDgwMS5qdW5nQHNhbXN1bmcuY29tL19fOyEhQTRGMlI5R19wZyFiMFVqN052
WXpXcXJ2TktPcmtrWGFZLWc0VWFzby1wVzUyMEFZMmZCZGxxbUpldWRVbm1kc2dwbkwxWXhBWmF3
MnlkeWcyTS1YemhldGJDcmFLeEoyZDJxRHFBJCANCj4gDQoNClRoYW5rcywNClRoaW5o

