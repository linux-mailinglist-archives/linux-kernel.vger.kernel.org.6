Return-Path: <linux-kernel+bounces-305919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247DB963668
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C1A0B2474B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB13B1AD40F;
	Wed, 28 Aug 2024 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WsDQY80E";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="V0QWlvE4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dUlGs/RP"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6452C165F06;
	Wed, 28 Aug 2024 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888781; cv=fail; b=hfHa98RUlVRI1OKwh815l45uCCqxI4k+DwNrwmr7xeFv7mhqvla5/kgzmN8QpMrWs0loH/RJ0Y4UBtiZ6ZYEtNSXu3H0vztXeijPmnpYZgO5rkZ0mYtYR5tByTxI+vy8tclntYCPnS9WOMsn/mv3q1bAyEg670CuxCSnZnUoZFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888781; c=relaxed/simple;
	bh=vv47RRnFm0KL5TPMEp4Yuowd/GglLfVcP6s+ovrVQfQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F2y0IOi08lZwcK6IwkoJjwDloDbn6gZLfuzW019QxGxgaOD3XXMqBhm6wDqXqScR5H2Mwu3MDEDh+rWAjWYvcOG4+vGBkJBQ6w8NgzrCMRnDkGAL4b88y8SOWjUUUMnDMJx2paViESN6n+d45o1wiLxSxBsS5hbLT7GG8RJQazM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WsDQY80E; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=V0QWlvE4; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dUlGs/RP reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJ5lP9005430;
	Wed, 28 Aug 2024 16:46:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=vv47RRnFm0KL5TPMEp4Yuowd/GglLfVcP6s+ovrVQfQ=; b=
	WsDQY80EaIrvB4ZXM9kaR4Dq4ZM29Hsx+C4w67wsgtlI0rlLWJRczWOIOfLFpw0v
	BoQK1pormjWs6ieQyaU7nFL9U5FSXRVDy3qJHENdu+YsnSjlA8eiUvbuMgcECq2w
	iYW0LdlBxFakAfREYvzxWu08CuwYCrMWBgNQd06Vy4fsBmJKfnKiWXInedZ6/Sfx
	+WCeXbHWUAf3lIHAVxAXzoKM92MHTwC09gmft4sOcR28XCjLsECodmBnjkgEkKAh
	UO8eL64paDAQwrNO5WpmsoxPynbHGJhnshRPAj0QV1LV1qes890GsLYh60iBj4hB
	LtyBjQkgQYFB358Cx2EQTQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 419pxyxsef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 16:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1724888770; bh=vv47RRnFm0KL5TPMEp4Yuowd/GglLfVcP6s+ovrVQfQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=V0QWlvE4DFhcgxpjUkOJAx+Y6quJZTAXgyRXWLtXBvwqVR7TAj2hrbbf1gyYGETod
	 Uk6SzdYdGycF7rylITSTSNukUk9Yvgkokckt0t6vLmR/ZRhXo5PTm45WrR1SZEVqj6
	 eAWkIim+ZcSozvbOrxLXFpqhNtLIWZBE/xxuKzBXJDdOgIxebOh3OHEc3hWpy+jppS
	 c92zwu/5hG4LEl1qifuShPWLX2AE1yfxT3DihPrSkwmMuNhzTSoeR75xsyNhib5Tp3
	 O9uE4CZwlz3C07n8tznCiRqUZvo+ouHaS+Jh3Mao8Nr7BeAKEqSs7wK1VZrYypf7dX
	 JHNAaW/IDtNbA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ED42740235;
	Wed, 28 Aug 2024 23:46:09 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 662D7A00BE;
	Wed, 28 Aug 2024 23:46:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=dUlGs/RP;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D931840147;
	Wed, 28 Aug 2024 23:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOt+HAXI399baKQudNqhX8nyQQBeDpwIliMLsHFB6WBM1T7fCqx/6obgx7LqHnVJCgt5ETsPY+S0LznJwbTM1UOFuM+dkVuROfxht5zPdz2aAgf8ZU8CZD5z7niegaK2Lptoh1z8E+6F1ZCndHQzZahYAF5NXL/hnav4QMZlzXPTiSbtYMQaXO6jt7AqolBnVZJFVPhgGazHZJkJ8V7sCaZbdf4KveV9ByZNd7eEL8shmAeHbGw5Ro7MJramQLMFL17QfhOrtwdDIE4rpdQI+ymSxbO6JbhAy/1DNkhYjuufe1bH4LuIbGmwFRzmNKF0BUY7q1fE8L0dniCpl8H6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vv47RRnFm0KL5TPMEp4Yuowd/GglLfVcP6s+ovrVQfQ=;
 b=VAwsNyc22b3O3YNOZqB8QPXu5lj/788XxSVhR5VdM03Tpzm9DJPaO3/wfGRm4sYp78d/uRyc4qf4+GXmKVkIBf7kmaGsKPXSx2ZgAAQ4x8tQl3FAPGbPX6HjTEhDlu43h3ScyPyRGped1yTmjWHaDKokolHLWUjBl6+e39vM4QT8Ls9xY3bo8UH+LFSMq9GxBdha+j8Hnc6el8WRFlLCiXoRJ2ZgIgSSWibvdBkx/CRl6PiPvg9Idt4VRz6GuZvPd1KOiSsrsPOQ6nV4yl0BwCR+wWOWZHFehUEYVazGiNu47P60AurqvBCBBYR7hEIx2LYMKfAn0zjdRhc9WeHI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv47RRnFm0KL5TPMEp4Yuowd/GglLfVcP6s+ovrVQfQ=;
 b=dUlGs/RPaIVTJwOCW+HO30yNMU4Qtg5OJ6G1gSpSoxmfIV4CvGLHfWsV/fIvdigVTg2oAoWDPLjirPijD8wmDB4FkxahuxsZJ2BZ66cbu5VD0M17u4l91w3yykVU4Wd1RhK9AeiITlybIEJG1ie7p3KHwG1+N3p8Mjtn5GmaLYs=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 23:45:58 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 23:45:58 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: AKASH KUMAR <quic_akakum@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng <jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
        Jack Pham <quic_jackp@quicinc.com>,
        "kernel@quicinc.com" <kernel@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix TX FIFO size for HS ISOC endpoints
Thread-Topic: [PATCH] usb: dwc3: gadget: Fix TX FIFO size for HS ISOC
 endpoints
Thread-Index: AQHa+EULTkB2OCYKX0iBD1wqItnyWbI7vZQAgABSeACAAUhBAA==
Date: Wed, 28 Aug 2024 23:45:58 +0000
Message-ID: <20240828234554.lw4hzeajneee7n55@synopsys.com>
References: <20240827054956.28241-1-quic_akakum@quicinc.com>
 <20240827231552.7yokoe7jqdm3wduu@synopsys.com>
 <93955b6d-0ce1-42cb-ad18-a82e2e8cfca9@quicinc.com>
In-Reply-To: <93955b6d-0ce1-42cb-ad18-a82e2e8cfca9@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH0PR12MB8486:EE_
x-ms-office365-filtering-correlation-id: 11d86df5-9fb8-4064-806b-08dcc7bb90e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUgxRWo3MmxDZm9OL0ZxbE9ZK0VjS3BLVHBPZWxjREM2OURPaTdLQWp6bVps?=
 =?utf-8?B?VHBTd092WDVIT3IwQWZtK1NIUWo4bnZBSk84TERlRFpTdEF2OGxweWdFdzFE?=
 =?utf-8?B?cFdCckc4S0dEeDUrLy9xdldsOGwzVjZlY0VkZkRLdXBjWEh3RVVTeDN4MjR0?=
 =?utf-8?B?TVBRTmxhSTZuMFlnMUY1d0ZvVHRLTXNVeURXVFZhUzhtTnhtcVhPbHVBenBi?=
 =?utf-8?B?bEVKSFhxQUhWOE5oOTlHNlZLOEEwNGF6RC83SENVc2xlNjBzcG1TWFFYTHBG?=
 =?utf-8?B?ejExUXV4Q1VQbUxTa1VNNld5RHI1OFUxRXhDYVN3dU54M3FUMzVNcnFOcXcw?=
 =?utf-8?B?Ynk5MnhhYng0QUNOTVgyMkJodnRpc1lGdzVwMHFFSTRzN3dBa2JHb3lnVW14?=
 =?utf-8?B?aDdza2xwYkJ3T2k4dUMwWWQ4T0tyZ2drZ0JqdlBpR3RWYTJUaHlTU3MyczYr?=
 =?utf-8?B?ZDNCYkpQaS9na2UybjRjQ0tBdThpYlBMdXNvZXp3YVpYWjcxTDd3cGpldzk1?=
 =?utf-8?B?NWxJVUpzNGEveVJJSm93ZGZpTWlEblZDMHc1N0tBZ3NDSE1ydWZtN1M4RDJu?=
 =?utf-8?B?Y3RoS0JPeG0xRzBGWm5rMTNHWXovdWR5NGs1bUdqRmEzMHozRFY2dm1say9U?=
 =?utf-8?B?N0oyeGVNYVBlZTMyM1M3YU9vUWJBdTJ6dzgzT2NXSGhjN1BOTnpEVmc4NVNQ?=
 =?utf-8?B?TTZvT0hPVXhlMjVzSFJxVHp2bEQ4MkVuUTE1bUdhUjRmODhWcmtkSVVGNmRa?=
 =?utf-8?B?elhBSGhHSzBMTHB6dVRkUk1UMkc1ZWhUN2krQ05GV1VtcXZibHlkdnNuVndP?=
 =?utf-8?B?YnhlS0VlWlkrU3hzaHNvMUZYYzVqVXdDTmgxWWJKZ05sZERmVWtSZGpGdG51?=
 =?utf-8?B?ZFdITW4vS3ZGSXFrMEpJZzFQUU9MU2RwZ2xyNFdIdEdoV2gxb01wODY3R2Q5?=
 =?utf-8?B?WUVzT2t5dmVCUjlqMHlBYnNEMnlEQXVWMFpNN09ZUlVvMkR0ZlBvRUlFV1hj?=
 =?utf-8?B?cFRSRlVsOHlkUTVKNmJ3dHFDRFFRbjZRNlkraUlmYUg1ZDJSajcxencrb2V2?=
 =?utf-8?B?TzFFQ3pUV0lBcy9Fb0l6ZVRoVnJZdFVZajFqU0dFSVhGbFM1RWJ6RHhNVzJH?=
 =?utf-8?B?QzQ0TG1jQ2xNZXZYRGVEWXdkYy83cG8zaDl1cTYxM3RQMm0yK2hHM0NmUllO?=
 =?utf-8?B?bmxUYmYxRjVGTUhkalRKYXVCeGo5VDdOSDh5K2syV0xMdjRidDBLSmVBdCtm?=
 =?utf-8?B?WU5aTU1QcmwxSzRFREpGZ012ZGhNVlU0LzBxUEVqZk1jR0xxT3dYOTVLMTZF?=
 =?utf-8?B?VTY4ejdrK3I4cjAyZENBeFZFaFFSVmlTRDdnbHFZUmlxTnlZSFFVTnhZcUlr?=
 =?utf-8?B?eVN2Qi9JdjIwUlMyWlAzcDdPZVVNZjJrQnVlNmRhTFJZZHBDUkFuTzJ5SWtI?=
 =?utf-8?B?a1VvUlMxYVJGazhvb3o2b01xN3E1a2d1d01uUm5hbnFIUFNKN1dudTJyTFN4?=
 =?utf-8?B?SXFIQXpYNk5LTHlueG5KT2todHlhUkJrcWJxbS9hRk1BRm85Mi90MGdxandZ?=
 =?utf-8?B?bVFBckNlRnZQbEN1bTRLOThYTVppRjNCMkNZSjRmVFluZFFDMkx6WEhRTy9r?=
 =?utf-8?B?WmRQbWNzei8zdWRpV1h3NW5wM3lSMWNrTlg1aUJzU2FldFF1VUhqYkdVMjdZ?=
 =?utf-8?B?NWd2ZERmdnFNOEJPc2ZWUk53bVUvRlpuOEdwVFpCYzZ3d2xiazQ4a0RMMmtz?=
 =?utf-8?B?akJQS3BZa091czhwZEMwNDZ5aXVGMVVMdGtKTVQvRy9XTzFIMzJRcmI1di8w?=
 =?utf-8?B?QXd4WkhwUnZNSmZtL2hLL25KVldkaThGdGk3Nm5BY2piNnRkc3BYSEx6Zzh2?=
 =?utf-8?B?T0FRdzBUQ09lQlloenFBS2RJOG9CVmZkV0VLZ0xPcDFNTVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R21WMWhPZWt3TG1lZnFZTzNYcTNKTGw4ZFFkRVR2cE9KV2hnS3haZi9rbUdi?=
 =?utf-8?B?bUxIVzYyME8rUXlmTHRnMGdtQWxCbmF2RVBDTEFYYVNJcDhEMVhzMjZzclc0?=
 =?utf-8?B?QzRkcXpxY2Jxbmo5Z3VJcEZrVitCSytGZ1NJSzJCcXVsRTdaejU1RjRXNVpI?=
 =?utf-8?B?SlhCT3UySjRjSXk4ZHFBUURoSzFFb3VoWWJYRGNFSlJ3TU00dWJQZ0VadlU3?=
 =?utf-8?B?Wjh4NWhNOURUVURTdnFKYUp1Tzd5azZmNDZ5YVRWbTZ4bDJCMkxmRHZHaUdB?=
 =?utf-8?B?dEZ4Vlp1NHdLMkFFeTJXWWl6U0Y4Y2ZLUUZGQUNESTNLQUVvejNxdVFOTTdE?=
 =?utf-8?B?eHZHUFdtemlxOHdreDFTYmhqcENCNkU5TFJLZlZaRHI5UmRRQjNMSGRqeHFL?=
 =?utf-8?B?b2ZYRGVLMlhnb0sxeEhOaC9YelZuZlBBbUJnZGFSMTZCekNOOTcwVmZkNVYy?=
 =?utf-8?B?TGR6bG1MbkJoSERzZW82Z0lwdHhSNFF4U2VBdHB3Vzl4WVR0OHR0Z1Y4VlBF?=
 =?utf-8?B?RXZhL0ZLaGY4ekI2OUo5N3ZHVmhYbjhHcXVwVjBmcUU5ZjgyU0tDeFhRUUdY?=
 =?utf-8?B?ZnZtdll0K1RYRWROUGdRa1lSZ2tZNFVrei93WlkrSlRHTzBVTmh3L3FRMkh5?=
 =?utf-8?B?VXIwOUdYUTNOcmVCalBCMXcyRy96dk9IcTQwckxERHd1aVJObXd6K001Q2cx?=
 =?utf-8?B?QlV4QnBBclJxL0lXZWNKUDErVk05Z0NUUzVDOEt3Q2VXT2tjTlh2c0xlblZO?=
 =?utf-8?B?Sy9SajJWdXBjZ1hwOHI0UjdsRzROOXdRRHJOc0FBaDF3UkRpcVhnd1phVlhG?=
 =?utf-8?B?RGZidjdHd0JqZXVYY0tsdjkxTWZhUWNleDlsQU03VHBlWVBQSysyVWRNeVRU?=
 =?utf-8?B?VjhKQzFTMllQTUkrdlM4MUNjK2k5L2d0a3JsREFyVVNaZ3JzY0t1SENieXhQ?=
 =?utf-8?B?THYweVpJU09yRmxWOThQa1MyKzZ4by9abmdBTmwvZ000a1hZdjcwVUNIWlNh?=
 =?utf-8?B?ZGxrNGVIaG1IVGdxQTh6T1AxWkdySUN3RlBqdmFUSWlEL0VlYTNoWXNNTkk2?=
 =?utf-8?B?MFZZSE95bnZMV2NKWlJmVy84NW9lVE5vUkpZNXVVSmlWYVk3eVlGMW9rcVVw?=
 =?utf-8?B?a0FhbUVpQ0c1ZWExR3NFSi9JVkFRZk92V1FJd2hwS3ppWG5lUWtUS2gvckR3?=
 =?utf-8?B?Zmhvb2FkVGpGTytCeSt4aEN5Z3lrTUovd1VGWHJZSjBMenBMMVpPR0JYSGZx?=
 =?utf-8?B?VTR4L2EzaTk3WEZpZzF5TUwvWWhsZi9aYkhaOVJLRm9hSGNoeFVpNTVSY0FD?=
 =?utf-8?B?Zk4xV3E2OFJCMDVSZmp1b0M3RFY4QkcxNUU2eWZNR2E0Z1E2MldRekZDMEhT?=
 =?utf-8?B?OFJTQ2xvdlp4Ny9RekI2RHBXcmVwT2NEZzVqN1JxSE5qM3BMTzg5Z1BhbExC?=
 =?utf-8?B?V0p4TWZhNnI5elQzdzhqSXkzeDg0ZnVsNnlQcUdQZms2UUxzWGNDdFFyWFFo?=
 =?utf-8?B?dFFZMThzK3MybUQxeTZXSWxqZHFBMDhpMGRjOUFEejZJblBPa0FCa01tN2hl?=
 =?utf-8?B?QVQvOFBCRjFLQXQyR2tYTUQ1ZHRRUkozcXlBY2VCVUNHWHJ1V0krUmlDa3FF?=
 =?utf-8?B?UVNjMmVpT2R0Vy9SQXNJYmJLN2NCb2hLWUlvYnpxaUhRb1NLMm4wUzVVODkz?=
 =?utf-8?B?TEVFSjZpWWNDMmRkdDgxUkVaTXp6eVViY1M1ZUtxLzFndytiT3V6U0NvZXBm?=
 =?utf-8?B?bEJ4cHB3WkoyRjA3VEh0aXdzWWgvQkcwVjEvR0FUcEUycDRVMFRtRHg3dE9P?=
 =?utf-8?B?YlFkRSsrSU1YeS9yMVhURXJ3T2VtUXV3VUhBUHIvWGt1VjgyMElGdEZ3RXFR?=
 =?utf-8?B?MDhCYXZtdi93WHdvUnljMExIdmFDL25RVUhlS0dDYm9FeTFURHMzWU5KQWZn?=
 =?utf-8?B?YTZ5M2NUd1ZzK3IyMWRHMkZJQkQ0S29qRWdjamlpRXRuODc3dGhtdHhPOW93?=
 =?utf-8?B?NDhKN25UeW45UkpORTJOK005WGpEaW5DRGRqZ2twK1Qwb240U21tK3p2TW55?=
 =?utf-8?B?QXNPY0lQaTZvdURoNXhlY203ZTNTWll3N1Z4TWJEVlB0WlQzcXcrSE9Pc0pa?=
 =?utf-8?Q?6Ks6/ZvsAMLzRQHUJwGXRrzrX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DAD477A6552A14C8F7155B5E2B874A5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iES5zMmi/0wZ1pdwzCggda1yCezjOUYEsADHkzliUtTuur2VKJcdTMDoh/H3ARja+KU4T156UQ0iCuUZmIZ4py084/StKP6lExrU8IoiXMyT7RYgIRxcVNA8qVfFfQGdTV8StPWf/PeD1ChlUeJeJogEANBtUl1bCeHoAkyf3etIIphd7H+/NgmrG4LZVUwcQD9VIgrbQS9gkOxNySoJap+nQBt/j5brXupHeD/aqbTu3SeLNu3Uxp58AGyFDzsYqIKuHTas5nsDuye0WBaxqsJGkgIgFyUjbuq6SYJVlC1XVb6y6akZGMQJCNmETAA8anLRMByEim3I5SDyzcXO5GJXja/JR6ANKYWhLv/tj5fCNfrQt0jpz602pvtMtOdMLV9JyGcawYd5F/S1YychLs+NW6prDSTxHCFBU/ostkkvoif3RkHep7+d/UUpRzi6UVSrAoFBHBX/Kiz8m94/Qhz+/GB8oQ3ivqyIJQx38LDAzgb62TZn6ALWbkz/vaGRUvBY4BvlSdq/YZyzE4F+qT8ieEje5NRCNe1Ih7LiriRmN34gCTUFmqwJ7nYvhyoYPemCQrwqcZRYaO4Cr4yAaE1kyqQ8FWJgHrsYlBXTITe4XG9KCdSJ8epklmHf3x1jlmBq3gHvFp+50Hf/lzFecg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d86df5-9fb8-4064-806b-08dcc7bb90e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 23:45:58.2979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 735cqn4LTSQVBtIbuIb2omSYGEMkQgXysyWksjm162Uo9IlcMBIQtSto/jzEP/X4DhtrdsSeLALnmsWjTvlFcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486
X-Authority-Analysis: v=2.4 cv=PdethThd c=1 sm=1 tr=0 ts=66cfb6c2 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=COk6AnOGAAAA:8 a=8tJctg-XEu8YvO4tXP0A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: riWKTTAqm2Fa7NQ_jvjK2avxK4zGsJ16
X-Proofpoint-ORIG-GUID: riWKTTAqm2Fa7NQ_jvjK2avxK4zGsJ16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_09,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 mlxscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408280172

T24gV2VkLCBBdWcgMjgsIDIwMjQsIEFLQVNIIEtVTUFSIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4g
DQo+IE9uIDgvMjgvMjAyNCA0OjQ1IEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gVHVl
LCBBdWcgMjcsIDIwMjQsIEFrYXNoIEt1bWFyIHdyb3RlOg0KPiA+ID4gVXNlIDJLIFRYIEZJRk8g
c2l6ZSBmb3IgbG93LXJlc29sdXRpb24gVVZDIGNhbWVyYXMgdG8gc3VwcG9ydCB0aGUNCj4gPiA+
IG1heGltdW0gcG9zc2libGUgVVZDIGluc3RhbmNlcy4gUmVzdHJpY3QgMksgVFggRklGTyBzaXpl
IGJhc2VkIG9uDQo+ID4gPiB0aGUgbWluaW11bSBtYXhidXJzdCByZXF1aXJlZCB0byBydW4gbG93
LXJlc29sdXRpb24gVVZDIGNhbWVyYXMuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFr
YXNoIEt1bWFyIDxxdWljX2FrYWt1bUBxdWljaW5jLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBk
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgNCArKysrDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gPiBpbmRleCA4
OWZjNjkwZmRmMzQuLmYzNDJjY2RhNjcwNSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
PiA+IEBAIC03ODgsNiArNzg4LDEwIEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcmVzaXplX3R4
X2ZpZm9zKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ID4gPiAgIAkgICAgIHVzYl9lbmRwb2ludF94
ZmVyX2lzb2MoZGVwLT5lbmRwb2ludC5kZXNjKSkgJiYgRFdDM19JUF9JUyhEV0MzMSkpDQo+ID4g
PiAgIAkJbnVtX2ZpZm9zID0gZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhfbnVtOw0KPiA+ID4gKwlp
ZiAoZGVwLT5lbmRwb2ludC5tYXhidXJzdCA8PSAxICYmDQo+ID4gPiArCSAgICB1c2JfZW5kcG9p
bnRfeGZlcl9pc29jKGRlcC0+ZW5kcG9pbnQuZGVzYykpDQo+ID4gPiArCQludW1fZmlmb3MgPSAy
Ow0KPiA+ID4gKw0KPiA+ID4gICAJLyogRklGTyBzaXplIGZvciBhIHNpbmdsZSBidWZmZXIgKi8N
Cj4gPiA+ICAgCWZpZm8gPSBkd2MzX2dhZGdldF9jYWxjX3R4X2ZpZm9fc2l6ZShkd2MsIDEpOw0K
PiA+ID4gLS0gDQo+ID4gPiAyLjE3LjENCj4gPiA+IA0KPiA+IFRoZXNlIHNldHRpbmdzIGFyZSBz
dGFydGluZyB0byBnZXQgdG9vIHNwZWNpZmljIGZvciBlYWNoIGFwcGxpY2F0aW9uLg0KPiA+IENh
biB3ZSBmaW5kIGEgYmV0dGVyIGNhbGN1bGF0aW9uPw0KPiA+IA0KPiA+IFBlcmhhcHMgc29tZXRo
aW5nIGxpa2UgdGhpcz8gKGNvZGUgbm90IHRlc3RlZCkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
PiBpbmRleCA5YTE4OTczZWJjMDUuLmQ1NGIwOGY5MmFlYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
Yw0KPiA+IEBAIC05MDgsMTUgKzkwOCwxMCBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3Jlc2l6
ZV90eF9maWZvcyhzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiA+ICAgCXJhbTFfZGVwdGggPSBEV0Mz
X1JBTTFfREVQVEgoZHdjLT5od3BhcmFtcy5od3BhcmFtczcpOw0KPiA+IC0JaWYgKChkZXAtPmVu
ZHBvaW50Lm1heGJ1cnN0ID4gMSAmJg0KPiA+IC0JICAgICB1c2JfZW5kcG9pbnRfeGZlcl9idWxr
KGRlcC0+ZW5kcG9pbnQuZGVzYykpIHx8DQo+ID4gKwlpZiAodXNiX2VuZHBvaW50X3hmZXJfYnVs
ayhkZXAtPmVuZHBvaW50LmRlc2MpIHx8DQo+ID4gICAJICAgIHVzYl9lbmRwb2ludF94ZmVyX2lz
b2MoZGVwLT5lbmRwb2ludC5kZXNjKSkNCj4gPiAtCQludW1fZmlmb3MgPSAzOw0KPiA+IC0NCj4g
PiAtCWlmIChkZXAtPmVuZHBvaW50Lm1heGJ1cnN0ID4gNiAmJg0KPiA+IC0JICAgICh1c2JfZW5k
cG9pbnRfeGZlcl9idWxrKGRlcC0+ZW5kcG9pbnQuZGVzYykgfHwNCj4gPiAtCSAgICAgdXNiX2Vu
ZHBvaW50X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50LmRlc2MpKSAmJiBEV0MzX0lQX0lTKERXQzMx
KSkNCj4gPiAtCQludW1fZmlmb3MgPSBkd2MtPnR4X2ZpZm9fcmVzaXplX21heF9udW07DQo+ID4g
KwkJbnVtX2ZpZm9zID0gbWluX3QodW5zaWduZWQgaW50LCBkZXAtPmVuZHBvaW50Lm1heGJ1cnN0
ICsgMSwNCj4gPiArCQkJCSAgZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhfbnVtKTsNCj4gPiAgIAkv
KiBGSUZPIHNpemUgZm9yIGEgc2luZ2xlIGJ1ZmZlciAqLw0KPiA+ICAgCWZpZm8gPSBkd2MzX2dh
ZGdldF9jYWxjX3R4X2ZpZm9fc2l6ZShkd2MsIDEpOw0KPiA+IA0KPiBzaG91bGQgYmUgZmluZSBm
b3IgbWUsIGFzIGVhcmxpZXIgdGhlcmUgd2FzIG5vIGNhc2UgaGFuZGxpbmcgZm9yIG1heGJ1cnN0
IDw9DQo+IDEsIGJ5IGFsbG9jYXRpbmcgZmlmbyBiYXNlZCBvbiBtYXhidXJzdCBpdHNlbGYNCj4g
DQo+IHNob3VsZCBiZSBhIGdvb2Qgc29sdXRpb24gYW5kIHdpbGwgd29yayBmb3IgYWxsIGFzIHRo
ZXkgY3VzdG9taXplIGJhc2VkIG9uDQo+IG1heGJ1cnN0IHRocm91Z2ggaW5pdCBzY3JpcHRzLCBs
ZXQgbWUgdGVzdCBhbmQgdXBkYXRlLg0KPiANCg0KQXMgSSBub3RlZCBpbiB0aGUgZm9sbG93IHVw
IHJlc3BvbnNlLCB5b3UgbmVlZCB0byBhbHNvIGFjY291bnQgZm9yDQphZGRpdGlvbmFsIHRyYW5z
YWN0aW9uIG9wcG9ydHVuaXRpZXMgZm9yIGlzb2MgaWYgb3BlcmF0aW5nIGluIGhpZ2hzcGVlZC4N
CihpZS4gdXNlIHVzYl9lbmRwb2ludF9tYXhwX211bHQoKSkuDQoNCkJSLA0KVGhpbmg=

