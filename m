Return-Path: <linux-kernel+bounces-277109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71223949CB1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1ACEB2331C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8434320E3;
	Wed,  7 Aug 2024 00:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HTRN3PFo";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Uvnlt9nq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SE+gCS7S"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD37163;
	Wed,  7 Aug 2024 00:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722989668; cv=fail; b=kVDEM4tpNLHcStcPVLlbCUXH7+wAEOD/G8iGGQKx3z0f8uFM8aW/7OSP2Vkzzbt2R5skCrAeLhKnIMsTzFqdGW7vg2S+E44NBaQt/CbCWhJ6W2TCtRLoVq/eX6KtjSlrTs/zWY719OXBCpztOXet9GpUHaPv1ePvZ2EMUybI2pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722989668; c=relaxed/simple;
	bh=1kmVZjEjtN0BSMfjyDxbJduf4tZ/l3nTPwBN4cud5SM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mDmD8usl09gd7lJKoqr+pX9iX2Kun0naWjxX78u8Nt+RFeD+/RzkHkyEjub7SnPa9kyLBRR8zYVns3htWoG2vwjgiElvdKTFPiFlcRwqDfSTuBPdTEv42pGMXnAJajhdOSxgmsCdO3pgRn4Fj3o1aNQp6BaOpYu3Re+MwwARX5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HTRN3PFo; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Uvnlt9nq; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SE+gCS7S reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476MJhns025809;
	Tue, 6 Aug 2024 17:14:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=1kmVZjEjtN0BSMfjyDxbJduf4tZ/l3nTPwBN4cud5SM=; b=
	HTRN3PFoyEc6TCxjSkJCIRCbW44Gc6B2nYES59AOz13orQ1r+uYfjWRioDiiO3DN
	N2QVOvJIcXcjh56rfGHmL2vZdSMIXOQ4oYOmy6SLOYivwyemmJU439oE7WXEQFOn
	T13sf+zawuuK7D8DGa0xNLBRXB1plttdoNS6f6+LzJi1J/LczzRy8esn8WHNLpwv
	fnBPBe93E7G+Cj/XIb8xrCRs+YgPUxs4SIY/VbiXJgKSoSAw59os3mX2dFkb2a9g
	p52ciJeDqAo4i5KMA51QA7HAh1Pl2NPZzqfNtgGayCaEbYUO51G/cRYqeh8Rk/IX
	DgnPiWI2MhG0VYVNNMHT6w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uujb8gyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 17:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1722989660; bh=1kmVZjEjtN0BSMfjyDxbJduf4tZ/l3nTPwBN4cud5SM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Uvnlt9nq4ST3IQAA3sK5ZK6SwsO4bFW43i1thEYMVHEvF160Ct1wCvmeor9bfcGn9
	 npkBGTMo3kTFoyXR/Etl/g6YMQReXS8V5B8IzVRtEQCbdlZJbSK7Z+zSEHi3lSzFrV
	 ncig5PwQqa1O9ejH3MA3yWHbkfT2vOqGBp0XW+9nIC8DJC0SYV5khi0iEsQgarYgbg
	 Xt1uC6wDbr4PXyaL3MnHVvHIpZFsABZISR2/sqqorSuq5u1aNtJ1QKQi0aHfMAsQH+
	 GKNG62QHDYZzn4smXyk7iCsTZiaytPCZSC6t/3ZfxKUmRzJ8FWy4Magdx9Ede0kzD8
	 KvBSE6n77mveA==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7E1A44035A;
	Wed,  7 Aug 2024 00:14:20 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 38048A007B;
	Wed,  7 Aug 2024 00:14:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=SE+gCS7S;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D8ECB4035C;
	Wed,  7 Aug 2024 00:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLfEMq/+G6+7JAERjwW9N2uoH/0zIG/q55yNd3wGCcKVm7jiDyputvt0BClYmNdSJZu8b0P2PwyX1JyiyBsR2xfasf9cE/x6ljEbVXJEAzJIHatPz4VDNqtOFRWRujJk3cR++BWiOJjnKCD3lDBD5h5Ueaw6HiiNVcuDP5nVld6TKz8D88IlbWvPseViAiIpClBE+toW1JSML3ad9XMDmzYOxvaHp8buo7V93Ax6Qvq8gUnO2vNkr/jtjtgk/z0fIHGS2eG+6tMvpBLg6H4Cbk402yurj6wlpLQjVuQRv1vVZeTr1AxTBtoiAytt8FgviudUPduz//jfxIotnlELoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kmVZjEjtN0BSMfjyDxbJduf4tZ/l3nTPwBN4cud5SM=;
 b=XGLNotHtB0VwBQrV4uTHmKemU+GDQvAK1OPvOUQnKv/I50Y34LtsPwdpqQ1DxbCokfJ6Qj8C3srwqFJhGSjPT1KFJ6zMAic5cJRCrkhK9cLWSLUDExvVgr0mXNrz4zki78HmE4Xe3y04ngBZoPKXvBh7JebZzx9O7li2NSKECVUG86e3aR52+a+H8wlGzHTjB3bGsJ0MqrQB2uqcrsh8r+VwVPwroqd3CwpUQ08Thw7v8BXwmkJT6L5hPj9MMCYHA0pCbkiGW2lYdjGffl8SDQow+5RxiK9f+9LNYerLSc8CK4kD2EU1YyzkuLhR3FB5PcF8eT623+tbkuIRBCxWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kmVZjEjtN0BSMfjyDxbJduf4tZ/l3nTPwBN4cud5SM=;
 b=SE+gCS7SdPSVX85AQliozbeh1dzz1sz49kYBBs3cwFa2XOwgcc0aWmmNL6CD/gS9V+TCmlNXNDWLITcSwd8jbLViX5oJqktuBO5ZG9fms75FL9LT/yxxycd/JW2RBHcdCTsUbyV7vQt72y0Fm4b3XoQw2JY5Yo/wjrPNnnbxhZE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 00:14:17 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 00:14:14 +0000
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
Subject: Re: [PATCH] usb: dwc3: core: Prevent USB core invalid event buffer
 address access
Thread-Topic: [PATCH] usb: dwc3: core: Prevent USB core invalid event buffer
 address access
Thread-Index: AQHa3Fh5nl8CDkK4NUOHZiwybpoX8bIbBL8A
Date: Wed, 7 Aug 2024 00:14:14 +0000
Message-ID: <20240807001408.fby2mjug3jym2lqs@synopsys.com>
References:
 <CGME20240722145728epcas5p38f8ecf57278b4a89c0b09430518c8599@epcas5p3.samsung.com>
 <20240722145617.537-1-selvarasu.g@samsung.com>
In-Reply-To: <20240722145617.537-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB9347:EE_
x-ms-office365-filtering-correlation-id: 45e47227-5820-4754-3b74-08dcb675deb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aENTSExGZDkwSitjbG5HcUVRc09YT3NZUGU4Y0o3MnVxTDFjeHduNmQ4dnNz?=
 =?utf-8?B?bWV1VUlSUkp5VWdEOXd3Nk1LWUNRbUtVclRlS0VlQ2w5YUN1cHJiNXJ0ZG9Y?=
 =?utf-8?B?OWFWVUZlcGFCaFZKMnAzd01TblhMWDFMUU9HZFp6L29QN3o0WlR3N2hKTHls?=
 =?utf-8?B?UUt4LzlEKytqZFFmOEZLQ0lnRXptbGorVGpBdjRKT29kalVacXdneHRBMkNN?=
 =?utf-8?B?eDljUTA4SWxCK2RFZHVhVHBRSDkyaFlQNHRzd2tVMmlGR3JxWGNuZnlZQWRm?=
 =?utf-8?B?VFlvdGd1N0ppdjZWak5zSnlTMWRHWWdLSVNRclFJWHVOaWhFZG11SHlzM3Mz?=
 =?utf-8?B?M2hzSEdsRm56cFlvekdGaGRvd29QaE9UNWNCOGU0SWUvUWlFeS9LSk5EdTE2?=
 =?utf-8?B?MWRRSlZaZjZSODluRjEzNi81eVRjRmxCYUtGRkthSTY1VW9SRVc4MDdwcEt0?=
 =?utf-8?B?NUczdUdFNDRwR2ZDR1ZldVY3dU1oT0JBTFM4Tm1QNGxvZEJ0M3FaT090MVJZ?=
 =?utf-8?B?ZDYxN3dUOEI2K1pYUGtNQm04VUkxVXdUYzVvR3V0ZTdyeEdBYkQ1WXBHTExw?=
 =?utf-8?B?Y2VDcUZlWmM4d1hocGF0U0czb0VMcFRiRVNPaDRyRkNvdkd1ZldYZ2M3TE1m?=
 =?utf-8?B?K2VyK3ArUjFKdjlaWjcwc1Q5ME5hRFVuT24rOUNTTjZ2R3Y2MTh4TFJiUTVQ?=
 =?utf-8?B?KzlDVWFkNzR0cGMvakJRWjhjU3V1cTdVMmVCNmUva0xwSHpOeVBZYXFUYnpY?=
 =?utf-8?B?WWNyZmNIbjdGOGpqbmQzaFRaWmd6cUo2dTNnQnNaeEVjYUsvTjZwRndYa2Zo?=
 =?utf-8?B?ZFNtcFc5UHRrd1c5eWJ6VjFDY1ZZeFRBdXhWVHZCOEJjQXNYaW1MbndjczNy?=
 =?utf-8?B?aks2eWJtWHZKUmFQWTZ3aTd1c2kzZW9Wb0c0N3FFaFcrdWQ1ZTlKQVJIdHhP?=
 =?utf-8?B?MzAwTzFUY2tub3ZZTkhWWmtlMFJnZWFrbjVWNUF0eDdacGNHQkw4RGRMOGFz?=
 =?utf-8?B?d3VjQTR6anNQMy83YTg2V3B6NlZWdnd6ZjNwV29jczFzQ1hKVGU4TkpuOVdL?=
 =?utf-8?B?VGZ2SGZYVTgyYjJEZ0ZpbnRSTlJzdFVNb0twWjJUSzNTdjdkenJSSnh3RUVW?=
 =?utf-8?B?NldQaERxNUQrVWdyM0RobDFERktMcUVrcy9lOHAyczBPVk5nZ003Um0wU2NV?=
 =?utf-8?B?R3g2cXJOTDFCeGl5QmE5MFN4Q1FRVHdkYWx0blpyUUtVeWswdEh0TWVYTldJ?=
 =?utf-8?B?UGhhdHFOQ2tDdFdqeHIyWm5rcW1CYmpmVStTTG5iTm1jYVF1TVo2WUU1TUJN?=
 =?utf-8?B?OWNFYmN0Sk1ORU9NRTlFL204TjVIbEZsOW5pL1h6NG10NnpMUzRqbDdVRU5u?=
 =?utf-8?B?SDNXRVhVek8xRXI2aXlpV2VkMC91bFNvZzRSZVdGVWZuM1NIVGhzL0l6UGU1?=
 =?utf-8?B?M2xKMmo4ZkJjU2dOSm9zaTlVaGNKaEtwQ1JTUnRLVlN3d1pRaEtYMFhpZzUx?=
 =?utf-8?B?Z2ZkcC92U0czWVF0V1ZzN1NtUmwrNmlGUXhJUXpEc0NHM2ZETk9XQzEwTm5F?=
 =?utf-8?B?cWdDWjhSNWVuakRWVytqSzNYTU1xUittczMrUzl5eUNkcUdIOVVMY081OGRL?=
 =?utf-8?B?czdmcVdnMHN0Y2N0V3ArN2lXK2E5YUFSbXdZRWlrVmE1dEQrVWNLNjJrVWRY?=
 =?utf-8?B?RGtvNS9jWDV2ekNoOFB2UFNIM0NLb1NUd05OQm5ubzBRZzVIMFZiZS9haWQv?=
 =?utf-8?B?c0IvV20rV2Q0UmdDc3hYc255WVlVYUExSEZBZW5zQ3p0SjlaaG8rY21xaE5h?=
 =?utf-8?B?ZDdNNG9vRkFZcFVJRE4xOTF5LzVmUmY3NjJ2SWtxRjZPcmtkY0g2TUVwQ29w?=
 =?utf-8?B?Q00yTmxlbjd5QlBmcSttZEM0R0I5WXpmRmVoalMvUWZNOXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFRWUWVLL0Uzd2pNSzIraUhiU2FObjlhL01uVWFTQnM1WmV2Tlh3NEwrdVh0?=
 =?utf-8?B?OUZZb1phbGxaWkZKZ3JPV1REazJydTVqR0Z4NFgwRUNUQzU5KzZjaGJ2ME5B?=
 =?utf-8?B?YzMyS3Y4bTR6Q29GY0E3cXczaDZkVWJjQ1dMTWkzOUJuVnJyYjFtaUhpL0p0?=
 =?utf-8?B?QkIzS2tpQ1NDNlpJVDJoUzBHaSt5VHNuK3BLdzNsSk1VaThRbS9NWDQ4emcx?=
 =?utf-8?B?VmNNR1FXeEFMWDVGcFZ2VnJmNlZ5Y01uSjlQMDN1b0dvLzBvZmtJWThRL0wr?=
 =?utf-8?B?a1d3ZTNSamJxdHZDdWtSK2YwVUVXek1Va3pRVVNydEQ5djRKdThSWVd3c2hM?=
 =?utf-8?B?SEg0UmVjUHp5R2tuME1aNTE0MVkvNjZ5ZllvaUxMRVNnL2YzcW4zMFQ2MGVm?=
 =?utf-8?B?NHFGNmxtK3RwbENISXo4Mk0wa01GWnhVZEh3Z0lyYWVwMk1uUzAwQ09yVnZW?=
 =?utf-8?B?cmNSWm1yNkVkbFpYRVdMTkdXejVUaHJJVFdMT0h0WlQ0UE1hVmgwcHd3RUhh?=
 =?utf-8?B?MjhremV1amhEY1lzR09NVVdTZHhYOG9aSG1oUlc5WFZleDhXaCtwWnQ2eHJH?=
 =?utf-8?B?dXc5Rk9zK2tOaEJ6cjBiVUZBaFdJcXY0REo0d3VONjlMRHVPODlFQWRHcXlC?=
 =?utf-8?B?SDF3UU9XeHdNUWlvWGVWOEtMV3djdmtJS3lBV1I4TEFMMmlPK1Q3S3YzZzVS?=
 =?utf-8?B?UEVUOFFxUUZ6ZkkzLzRmR3BxeHA1OHhpOEpaOXFZU2lMejFFcVErOEYzNU1v?=
 =?utf-8?B?eHlhcUhCeHloRUhVcUYwaEFua1hUZnh3VGVXa2RqM2JuN1FUWHNxR1dYSUk2?=
 =?utf-8?B?SldiZlhoZ3hEN0tTaFY1UmFDeTI4YXNVek5nNDJwYmxKWnNVaTFHdzI2Y3hS?=
 =?utf-8?B?WVlMMDdrR2Fna1BlNXVuVEpJbHljeW9WRDRYM2s1YzEySnU1MW5JN0VSMDY3?=
 =?utf-8?B?V2pDVTVuSTNqd010b3YvT1cyRWdFS3hJY2lSME9TQlJlbElrUEYyVnlSUGdw?=
 =?utf-8?B?VjRXRHJDUi85ZzdHcUdFNjVPb0ZkVGpsazJBbDd2ZGp4Wk9UaHgxRjhkWFdW?=
 =?utf-8?B?R0lWU29nc2ZGTWV2bU9wUitiL2w4eHQvTmZvSjNPMkpoazZzWFZRdkZjaU9p?=
 =?utf-8?B?RlllQWNaeEVzUFJBcnYwcitVbGNVT0lHTnJKQXRaTWtTOFRZbTRncVZoM3FF?=
 =?utf-8?B?eDNOemR2MGZGTmJ5VUJuaHhpTy8xZGp4Y2MrYnF2QzY1bFpLSVFJemFGb0Jy?=
 =?utf-8?B?L01NaHFYT1pvenJBQjlYY1pJaW9zOVprMERhbzVPMkZoKzhSS20rdW5CZmYw?=
 =?utf-8?B?ZmZOajlXaW0wWmtLMjFUWEh5Qk9WMjM2ZXpKV0x6TTRLKy8xU3hZUTUyVURs?=
 =?utf-8?B?Ris0T2pjL2N6Z21XMW01ZkN6LzFWTW5uck5qUGpXdWkyN3Z2dzFCMUp2V2du?=
 =?utf-8?B?VkZXWVBaeWFiWk1VSVdqK3FDVC9yejg2cjZmd0N1TjJmM2t2TjNVYWM4ZmlI?=
 =?utf-8?B?QmdnekZReG93SDM2NHpMYU56OHlGYldCNGlHZjRWUmFYMlBPalIzMHJ1STJX?=
 =?utf-8?B?Sm1UcDhIUy9wQ0V4YW5JN0xqL3VKczRCTHB2bi95TFIxL3VJMDM0ZWEyQkcv?=
 =?utf-8?B?b0MzTlRNVU1ub25NMWxlaGxWT1o1NGYzcDF4YVl4MUxWS0xackNlc0VZU1B3?=
 =?utf-8?B?SXhwNnlQWWJBQ1FQK2ZZMDVSMEFhMDc3azhOVmFxalYvck54aXBBQ28yQjlV?=
 =?utf-8?B?N0o0WXRsOEc3RlpKZ3l6ZUpMUjJOSk5GMDJzRGpUU0gzaG14WFhmODAxMmth?=
 =?utf-8?B?Z2dxS1JUVjJMR3ZUZklJbDEvVHA4NHV3L3lqK0I3NkFXT2xtTFZvaWVvZ1lY?=
 =?utf-8?B?cmM3Rk9FeVQzOFJDcElTL0xQemsxMnJOQkRwS3RCWmZhNDZ1MGx4RXVqaUNq?=
 =?utf-8?B?MUZ6eTdtd2NWY2xoRXpIYTFkRDZmdHN0Z0dGQTZTR2tQR2xHNjk4LzhDa1NV?=
 =?utf-8?B?eHordGVNREtrTkVXdnp5MXdkeGpuK2Y3SUJ0VjRoQWloOXpOT3BYbVI4RnhS?=
 =?utf-8?B?NGdpZEt3SFN6U2R5bHVEaXFXL2pOUGc5VFVhR0ZzaXJBQ0xLM29ZQlJoQ3RP?=
 =?utf-8?Q?xWKlGVuqgahYL3Evh4Dl1YH4f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6377F322FF6C84AAD7D1297DC07F9D9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r8XBVGZZBqPJxKHeBCUVOGSj78G0M8qhgZmUH0dmC00G25spccCK5b5z1p9gP9LJpI2SBrg/ITvlmGVcuw7zfFgxuHdWpJf3CFl7/SGMJ/5AFjLDyL3+ypkHWQwZNIhDNOXYvDjER2+TmkHEdLi8dvkm7MuB+XtY00FB0I3MppMzPwrANKDij86KjAKXMkusKe5Y3xXUkzsTKxFZ6we7Cw4Wkb8iD4YmJAMiDbqX6VZ5kcoWQNSq9ZZJRx7UkCTw3tTGTej4Eu6i17lsRRa7nGSaDlq4cwAlVlbWQ4NM54QMOf0sOa7YEa8CC6GSYtp6AFQsUgUcbOixrsRomcfD74QE2lqZ7jdxuJx6RNPnBKkXNi601TtR/XzFxvK9Rs66WHVnxH/zRFRKwMBKiUvQnxYlbGouushVsV04sxPadbevwMdNbGFSJedLPjXYjaawpk+HRL78sOZMNXPXRkp5gWbynRoSYmt2ghXpr/X6cz4RZF0SrjxdxMfAXFqaMGJ4n52NT9pKAkzmWjvaMbSpsHYz9n3bQtvBtrxcrk0npkD8F8i9S1VKReMXPD2zXNJj0x53qga0RoEIWLe6l4k/2tp1i0GOaHZ5LEA8YZg4FqJO9U1pXJGKJguOdzGoWx1545si01E4sJjji4QhzeVDJA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e47227-5820-4754-3b74-08dcb675deb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 00:14:14.2964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lAspdDiXL/GvxtmmLPkolvCZQp166ja15zssraN+0ay4JlLUvU6PYIl/AzsdJmNf9weJvUA5N9dqJkjcykQL+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347
X-Proofpoint-GUID: O5-rRZWEgPVEh9UtWDKdch4ycxQ-y-PM
X-Proofpoint-ORIG-GUID: O5-rRZWEgPVEh9UtWDKdch4ycxQ-y-PM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_19,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408070000

T24gTW9uLCBKdWwgMjIsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBUaGlzIGNv
bW1pdCBhZGRyZXNzZXMgYW4gaXNzdWUgd2hlcmUgdGhlIFVTQiBjb3JlIGNvdWxkIGFjY2VzcyBh
bg0KPiBpbnZhbGlkIGV2ZW50IGJ1ZmZlciBhZGRyZXNzIGR1cmluZyBydW50aW1lIHN1c3BlbmQs
IHBvdGVudGlhbGx5IGNhdXNpbmcNCj4gU01NVSBmYXVsdHMgYW5kIG90aGVyIG1lbW9yeSBpc3N1
ZXMuIFRoZSBwcm9ibGVtIGFyaXNlcyBmcm9tIHRoZQ0KPiBmb2xsb3dpbmcgc2VxdWVuY2UuDQo+
IAkxLiBJbiBkd2MzX2dhZGdldF9zdXNwZW5kLCB0aGVyZSBpcyBhIGNoYW5jZSBvZiBhIHRpbWVv
dXQgd2hlbg0KPiAJbW92aW5nIHRoZSBVU0IgY29yZSB0byB0aGUgaGFsdCBzdGF0ZSBhZnRlciBj
bGVhcmluZyB0aGUNCj4gCXJ1bi9zdG9wIGJpdCBieSBzb2Z0d2FyZS4NCj4gCTIuIEluIGR3YzNf
Y29yZV9leGl0LCB0aGUgZXZlbnQgYnVmZmVyIGlzIGNsZWFyZWQgcmVnYXJkbGVzcyBvZg0KPiAJ
dGhlIFVTQiBjb3JlJ3Mgc3RhdHVzLCB3aGljaCBtYXkgbGVhZCB0byBhbiBTTU1VIGZhdWx0cyBh
bmQNCj4gCW90aGVyIG1lbW9yeSBpc3N1ZXMuIGlmIHRoZSBVU0IgY29yZSB0cmllcyB0byBhY2Nl
c3MgdGhlIGV2ZW50DQo+IAlidWZmZXIgYWRkcmVzcy4NCj4gDQo+IFRvIHByZXZlbnQgdGhpcyBp
c3N1ZSwgdGhpcyBjb21taXQgZW5zdXJlcyB0aGF0IHRoZSBldmVudCBidWZmZXIgYWRkcmVzcw0K
PiBpcyBub3QgY2xlYXJlZCBieSBzb2Z0d2FyZSAgd2hlbiB0aGUgVVNCIGNvcmUgaXMgYWN0aXZl
IGR1cmluZyBydW50aW1lDQo+IHN1c3BlbmQgYnkgY2hlY2tpbmcgaXRzIHN0YXR1cyBiZWZvcmUg
Y2xlYXJpbmcgdGhlIGJ1ZmZlciBhZGRyZXNzLg0KDQpXaGF0IGhhcHBlbiBhZnRlciBhZGRpbmcg
dGhpcyBjaGVjaz8gQ2FuIHRoZSBkZXZpY2UgcmVzdW1lIGFuZCBmdW5jdGlvbg0KcHJvcGVybHkg
YWZ0ZXJ3YXJkPyBJZiBub3QsIGRvIHlvdSBrbm93IGlmIGEgc29mdC1yZXNldCB3aWxsIHJlY292
ZXIgdGhlDQppc3N1ZT8NCg0KVGhhbmtzLA0KVGhpbmgNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
U2VsdmFyYXN1IEdhbmVzYW4gPHNlbHZhcmFzdS5nQHNhbXN1bmcuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgNCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCBjYjgyNTU3Njc4
ZGQuLmM3YzFhMjUzODYyZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTU1OSw4ICs1NTksMTAgQEAg
aW50IGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgdm9pZCBk
d2MzX2V2ZW50X2J1ZmZlcnNfY2xlYW51cChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiAgCXN0
cnVjdCBkd2MzX2V2ZW50X2J1ZmZlcgkqZXZ0Ow0KPiArCXUzMgkJCQlyZWc7DQo+ICANCj4gLQlp
ZiAoIWR3Yy0+ZXZfYnVmKQ0KPiArCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0RT
VFMpOw0KPiArCWlmICghZHdjLT5ldl9idWYgfHwgIShyZWcgJiBEV0MzX0RTVFNfREVWQ1RSTEhM
VCkpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAgCWV2dCA9IGR3Yy0+ZXZfYnVmOw0KPiAtLSANCj4g
Mi4xNy4xDQo+IA==

