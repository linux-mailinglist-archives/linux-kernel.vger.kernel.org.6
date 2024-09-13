Return-Path: <linux-kernel+bounces-328674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E77D978732
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D071F21D97
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA9885656;
	Fri, 13 Sep 2024 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="wHBhkv5/";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aqIlXjN4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DGcyZhJL"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287083CA3;
	Fri, 13 Sep 2024 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249891; cv=fail; b=ktu3Y+skAu+8PqWGJ139RvvJS3LY1wAW6GHaoybDh0yCG8Ee/sW7zVXZhck136iXHkJyBJn4L/MxvgVyUY4l/PgppAWzvhj/Y9wxFu0htDAHdEBEyBtZJjYFAgmR4/lwqOEdzKxnDDhPXCzd5XSgE34aVdiKbPHA1wBAOpZ9mDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249891; c=relaxed/simple;
	bh=nlqwhCmuPJU66eS1KTzaLsYBR9cfNO+57LKGowqzres=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eotvqFwnrOK+a8rfxKLPdVFT3v1Gw8xgM8HKSGGgZBSDbbsiHeTtpkbIo/u6qgSRH6V6a3OJpgCZe5uHYPLZj+2Khsz/iR6dAAgx0d2XH0roScECt8mYXrh7LGewdqASJBR9Pq7igtkUKQxmXJDOLWkCiTRs4iRJO0To7dt2XCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=wHBhkv5/; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=aqIlXjN4; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DGcyZhJL reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DFwRAJ014411;
	Fri, 13 Sep 2024 10:51:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=nlqwhCmuPJU66eS1KTzaLsYBR9cfNO+57LKGowqzres=; b=
	wHBhkv5/1yzEq4ALWkcEyaFnqeaSWRpZs+rIwhx6ctPs7XTLsUpV79VzD/NQWdrD
	68ClYZ6eaU+DD8h0cJISiiqH9sBkPWZkmGrtDo7JRsGHqo2wlY6kJM3NcqBVNey8
	hYGWNL9LwZnkiq81+Xp7HWcatBeBclv3z6Vv07+l+QkT5QDWVRkTsloXqcvQfiG2
	k/IHYeu2m9c1SuJO0rMNbovif3IWS5CR+x9YA9feYWYjCt7k4Uqj7W463OGjJieM
	Hq7GIwcp53uvX9FsGN7oLX2KwBAjnln2oGExZ77NvsgkpilojymKOoHyXUpxZ1lk
	LQXjycLg4ioeVACq3+uQOA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41gybcjn8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1726249879; bh=nlqwhCmuPJU66eS1KTzaLsYBR9cfNO+57LKGowqzres=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=aqIlXjN46CkweBoUmpq08WIcDd+5URHz4G9hi/1V25aTmYtKRVKVMXOIwqTl8zPY8
	 cetWzO2qOEbyH9rKd19p5XDPx2i1GeicTI5iUcybEGplf3upINdcpYp705ZA7H8CHn
	 1lcbO7UfI4m1u5SciDInNhU4HlSTptgHQuXP+gGEos2XCKmuHpLYnonSRQheFBmXQ4
	 AEZStjlTxtex8OCjSSltiZMw3mttplwZWeZUTsjXhb47dMobWNIlqfjZlY7K9APHnG
	 eintqJiB78iYUu+1zAw2ss387UHwKBjrqFT4bKBERfdPFzoIzcwSKObj4QWlnKmwpF
	 AuIDGUJCxYHTg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BA6B140346;
	Fri, 13 Sep 2024 17:51:18 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 348F5A007B;
	Fri, 13 Sep 2024 17:51:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=DGcyZhJL;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 92C1040353;
	Fri, 13 Sep 2024 17:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8i7abwfLbW8mZiBJJm2Wx4oVdIYUcF3fKE61kA+jJNBESf48ecf7UiQUf6JaLjjhon3qA7iJuKgosr31Epj9mucXEYqXTshLek3GwmZ9+iUl73GzYhAaZWdw73BegT4fyOjm9svZ0Knygf2jwbIXe85yi9Ps3Wh+YQnAMlqrjp5jWoIOBBX5VzL6cGTUwZzhdsGpvjC6GQN+9WSN1O4XiGFi4qh03BsCX2k5lyfEcweszB4mDQ0nhsKqgLo2ncjuN4Js2OZpox/rbJlGaCI33lPAGDAH6KsVlmvwjIZNj/8FeGmBxhYp4Eg7q/49QM7WgfLzspEXchO//938r1fPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlqwhCmuPJU66eS1KTzaLsYBR9cfNO+57LKGowqzres=;
 b=Nd66AClpR+OIOGRXXLKHj+Z1/Ar+a1s9vl5RaCxnfhpBirv/43NtMcZ0Jm9vIbGyHLX0k6E8N7d58tzlSq8a9EZQsHzOHv8UhDTpoFFNuUgWHDgTtQRmi3UEiM7e3x5iGoC8UWgjWMNAd0JpmuGhtzIaQcCIGpzuChWploEwL5iXcjBe0pqWjdffUgMpi+M2IKJ1WTb5l2aypgPmi0D4LULAQkvdnxLrcCyW3/bpTjSmboO68VzRQJjHct+qN9c4Y559yKwIgtM++5gbhbr3yQEf8xmeswGI1o9SvgKCFYmNuIIMFEwQu8O/O5PykN4yf9+lMQbBCi7Yswpp7ixAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlqwhCmuPJU66eS1KTzaLsYBR9cfNO+57LKGowqzres=;
 b=DGcyZhJLXKN7OmOOoYMF8NkfybgN09u1WaPxht3I9KnpsirZUbXzcfhk4CKjVciQQ8SKplsY8L02Dday5mLG/rziXiDKLQ76ibwsSYg9XKTMAHs1IE2eapWiVn3rkUU7K1Wi0FQL7q/9yYxx7a4i+/GqNge1atOFMrp78Ksdx6E=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Fri, 13 Sep
 2024 17:51:14 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 17:51:13 +0000
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
 AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AIAAVgGAgAK0ooCAIEFKAIAA0sIAgAPWhwCAAnZSAIAA99mAgACQGICAANfzAIAAhJUAgAAfSwCAAAOTgIAAE4YAgAAIvoCAAS6LAIAAXkAAgAWQSACAALStAIAD8tcAgABWWAA=
Date: Fri, 13 Sep 2024 17:51:13 +0000
Message-ID: <20240913175106.qbav2aigzwaj7pvd@synopsys.com>
References: <f9561f03-5f83-4270-b7f3-17b880cfabfe@samsung.com>
 <20240905231825.6r2sp2bapxidur7a@synopsys.com>
 <64d049cc-d55d-4376-b6b9-402eb6f170c0@samsung.com>
 <20240906005935.caugoe3mqqdqwqao@synopsys.com>
 <30ca8527-419b-4e44-a21b-18e494b39076@samsung.com>
 <20240907003946.qn6t3xw65qwl2cn7@synopsys.com>
 <dff83c7d-56b8-481f-af69-8d4262bd54e4@samsung.com>
 <CGME20240911002436epcas5p19be55e1144edd6f77184192c7f22a85e@epcas5p1.samsung.com>
 <20240911002408.gr4fv5vkst7ukxd5@synopsys.com>
 <dd7965fa-9266-46b9-9219-1ef726480a9b@samsung.com>
In-Reply-To: <dd7965fa-9266-46b9-9219-1ef726480a9b@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB7771:EE_
x-ms-office365-filtering-correlation-id: dca054bb-4e05-459c-e3f4-08dcd41ca8cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEhWNXNEMlFpaE1IV0JLN3BSTVRva3BJSUVzZWVqd09aa1FYY3RPa0Mrd0tw?=
 =?utf-8?B?cUpKeHZLVTV6V3JYNzI5NDRyaGlubTRkeUxxZFYwQkpXQUlpREVrOGxsdGkr?=
 =?utf-8?B?YjdEVkgrOG9HVTBZV09BbnR5Y253b3lPK1RraGRvT040U2pUbDFOQlF6UWxP?=
 =?utf-8?B?RkxkSGRqazY0eUxkbWtFcFJ3N20zWUR1MEVqTm1LRVJpYVR0bSswYWdmdmdu?=
 =?utf-8?B?TTdBQ3lVN2hGMGRycUM2eHpYNWs2UEVpSUxPSkI1MU8waEFiSGdQMjVvRmJw?=
 =?utf-8?B?UWpmc0liSzZTSVpkTFV2Y2Q2aDVtYi8wREdXUHY0bTk4c2Z4T0w0WmlMUk1a?=
 =?utf-8?B?enU0THBGakl3aERkT2JJNHdwaGhyVWdNa1orL3BTMmNWSm43a3dGVXBMOTY2?=
 =?utf-8?B?SU1WcmpDdDVsQklrQjhjc0F2cW5mc1F3V0N3Y2FjRS9oRDlpdjRmT2VnVTcw?=
 =?utf-8?B?dlphYWlTRDFleXNSbXpBU21abmsrK25PWm9UbDB0OGhpSjQxWlMzeXFqQThF?=
 =?utf-8?B?YjhvUWN5dGhBSjJLdStHY0RlM1BRUzFFclJFQlgza2s3ZFRJR3NFMEQ2alBQ?=
 =?utf-8?B?QnBLNE5ZUVpPU1lLUG1zWlNSTzI0TWFlRFJnK1pkdWI4NHNWUXVFaTd5V1pi?=
 =?utf-8?B?R3V2V2c0WlU0NWpUaXdQVHNkKzVCR2kzdEpVN0VBaThURDFBZVJjbjZJQnc0?=
 =?utf-8?B?c01FdmI0TlZNK0IxdHB2UjFVa2tCN1hKdlFZOTFReVEvbkI0bmROMVBla1pq?=
 =?utf-8?B?cFdxMU1KOEhPelUrMWpEd2ZLKzQ3QUc0N1QwdjVxZ2JOU0VoSUVWc2JkdG84?=
 =?utf-8?B?VUZBVkM5RnlMOWU2Qm1HOXlFSFpEenJsRGZlMjRKcnA2ZWh0WWRpdDFENTFJ?=
 =?utf-8?B?NGk4ZXpzOWFvbGZhY3N3Q3IvVjJUZXJCampzZXl5VHZabHFxb3g0QTRkQlhr?=
 =?utf-8?B?Mm9QWktFR1VBWVdUU2srSk1seHpHT3l0dWRJSzM2QURubFVkcU9aWDU4ZGJM?=
 =?utf-8?B?SVM1L0VnZzlXd0VCVHVTZUV3Z3ZVOWFPY0hqWTUzMnJEeVg3WVFQR1N0b0FF?=
 =?utf-8?B?WktRTVVtek0zZXphWmxGSHo2akQxak1jSFptbVJuTmFQTzlHa09scGJOTDJ0?=
 =?utf-8?B?UExyN2pwbGE5SFM3WGxlbU95SlhYVVoxMzBXd0trelVYRGwwcUk0c3l0VGph?=
 =?utf-8?B?SFBMeFJXOVFKM3hoZTc0RUczQTB1VmFTODdNV2hCazdIcFRadWFIOUNPdUpq?=
 =?utf-8?B?UTM3LzREN2J5OENCSUNVRHRwcllONktGOXYvaHEwcy9nVTNSYmJPaDhaZ3lG?=
 =?utf-8?B?VC9OcUQyaFFjRnd0NlV6emM5TUtpM3R1V3c3bXBWZkFmQ1BGdnZPMHJtVkhj?=
 =?utf-8?B?RTZSNE9mV0hBMUxrREZ4WkRrZmdKR2dnMWNWTXhHZ2YrRjFVeTlUMEFHRHV1?=
 =?utf-8?B?RUlPeEZJcHh5eUc4a2pWNlNxeXNLSkdHUnpqTyt2cWFBTDNRSkdMbE45Y2Fp?=
 =?utf-8?B?V2hEc1RraTFvMVkwZTNZcWxQN3dZV21oeXE3SE5pSnc2SkloK29pbVVuS2Y4?=
 =?utf-8?B?cWV2cHF6d09jWTY1NzNxeURoMVU2bDNMaVBVK04yMzcrYmJhWXlvc2kzeDZs?=
 =?utf-8?B?T2RRMXM1WjVCMGNwQ1JKa2dMb0FYUDdZVEZOUjRZd1dPNlloa2psM2ptRlBG?=
 =?utf-8?B?QmNGK3RSTkhsdzZ4Qkt6eUpJYnFCT2tOTWFXV1VPUm5Mb1BEUHRMWk52dWcx?=
 =?utf-8?B?NEJ2RS9RTnJIeTlvQ1lscHRQVDF6Sy9GeUYwSVBYMkNESFVWcS9jUVNydTkz?=
 =?utf-8?B?WkRXWEhhUk1Mc3BLRkRBS25zYnZlUUVvdUtKN1B6U0V4RUJlVlRJeWNKTUhq?=
 =?utf-8?B?U3RUMG5taHVZT0JGN1EwR3NSTCtXVVc0QlNYMXQyYVNpclE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkMzbWFPRzAvT0tzZkM0Z0VUQkkrZEY4VmFjZitsSEJoOTBHRncyR2kvbFdi?=
 =?utf-8?B?eW5ncExreXZPOTF0N2pZOGVpQ2RyblU2RWdCL0ZvRUExc2Jzd254M2tmdU5m?=
 =?utf-8?B?enRUNXhQWm5BWmlrWXp2QkdraTBTQTFPeTQ3SWZVSHMxRTQvUWJoSmRjQlBx?=
 =?utf-8?B?d0FtN1c0OExWT0hNVDZFa044V3dYVEptNlNiQ3A1T2tUWkxEVkZuTVk4Z1lN?=
 =?utf-8?B?dUJ5cEM0S29OUlU0blRUdk04Yk1najdIZDRtYVZBMTkxdUZJS1BMOSt0ZW4x?=
 =?utf-8?B?cTI4VTNyQlFXTTlKdXR6dDRRUTlsNjFvZEhRdFAva2ZPclN6R2l6M21KYnV5?=
 =?utf-8?B?cXBCSTdBR3pQZExMRmwrVmkrZ1VWS2IrbDdmSkQ0d0tEaklYRW9YWjVZNktz?=
 =?utf-8?B?ekE2allwUXBuM3pQWGU4NlN2Qk9GTEhTOXZGc0p0TTFHL0JORWNuSHd5Z1hX?=
 =?utf-8?B?aVZhcUlaTS94TFRUeUVCa0hPRk10SUJxaUVKMGpWS2VDMk0xZnVlVXVHMith?=
 =?utf-8?B?U2VlWlV4RGtNSU5Vb1hPMVhWQnNIRUJiWmV2Z3h0QzNxckhhUFM4UzFLZHRY?=
 =?utf-8?B?c0N3SC9rM29pQ2ZwQmZsejVXVVRkb0RkQUw5QTlsMHdQSGw2cDQzZWczeG9I?=
 =?utf-8?B?czFLM3d6K1RaK042OEJiakxWU0VLZ2RkbEZrT0hsNGxhdU5mRTJpTm1mOGR0?=
 =?utf-8?B?NXNKZmlnM3dVMVNRbCtheEZoU09CQ3NnNU5nc2xxNzVlaU8zSlRPYXRYY1pS?=
 =?utf-8?B?V01lMzNIelhnWXFjY1lLWHVCZTIzQlBxRW5tcmRDZEh2YlFFWFhVazhxQ0pR?=
 =?utf-8?B?SzM3Z1M1dEMwUVhodzNua3c2YnVDa0FlL09XNUdSalowMisxK1dmQkljcTFt?=
 =?utf-8?B?UmE2K3RzQnBWTFFyNThqc2RqWXBEUXpJSTRkejhucVZOSUFFcDY1REhwemIx?=
 =?utf-8?B?b0p1Yjl5UXQvY3N2UVlhRHJHc1Avcy9VQW94SUxvZ0tjeWN3cjE2YldFWXp1?=
 =?utf-8?B?cmdWcTZCSWtzc1V0cFIzRS9HTjBSaHpFdFdFQTlMVXVuSGJZUXQzT2xCR1ZQ?=
 =?utf-8?B?RFhSbHlrTjFlMnEyTjdUM1dCbmNUQ1A1ZGtlQmFndWN1V3F6Wm54QnFoN2Rh?=
 =?utf-8?B?ekpzWGkrK0hSc0hWMC9FUWEyWnliSGFUclhlNFpBQ3I1WUJtWDAyNWR1OSty?=
 =?utf-8?B?VkNSTWo3QlU2a2hVNEUvSU0xZ3pXWHBScmx5RGVqM3dVUzExK0NEckJHZG5P?=
 =?utf-8?B?eEgvRm15cG9NQkxldWQ3MlZML0MycG4yTnZqYk11VmxaNjEweDVERWc2SUt1?=
 =?utf-8?B?Ky9wUjBFUlNWOFlCMTN4aTZZYW1nLzRCREwvMzd2QWtFWW5xeEpVV2FYVFJU?=
 =?utf-8?B?eE5SOEl1dExzL0xBRzJDcTBEQU1XdlFOTWVZOVJOL25jbW9EbXl2Ny9kY2hp?=
 =?utf-8?B?R1pUT1VDUE9CZTh4K3ZBR2t6OWZxY1Z0eFNUbUhiK245Q29sT0hMOFp6a3Fr?=
 =?utf-8?B?dldTK1VaYk1kY2ZoNlBIdmhDYndRcE11dXA5cVIyeGE1RTNFYU4vTFNQb3RO?=
 =?utf-8?B?VkRLQThhYkEvKy9nZmNxRDRiTXMvRGQ5cG5SY04rbGpmbGRYT1AzMEFzN29P?=
 =?utf-8?B?TCtyblhja0Y2TGhYRU5adEhidE0rTmMxOW9ISVV4K0VuUUZSTTlHV1d5ZVRw?=
 =?utf-8?B?K3huc1pjNFZnVm1URExnTXZqU1o4cTZ1L3pVWi9ZNmxnZ0hqYXE3WmJ3Z0xG?=
 =?utf-8?B?OGluL1JrYzI3eHF1c0dvS0h3ZTlCRUNoQzVZaGdoNm9ScFd3OGR5bHJGcFFn?=
 =?utf-8?B?bmJTbmpGNldkTnVLYUxtYVp3Y1B0RHJvRExyN0YzUUZybzU3MUVXVDEzclMy?=
 =?utf-8?B?Unk2MGtFeHVXSzQyRUxMYlk2TDJ5Mm91a1A0WGl1TVF6S09jekx5bmt6ZkUz?=
 =?utf-8?B?dGxXMEJXaGtMMlkxajNhSEhmZVFWZkFVTFZ4WCt1dUl5STVvR3BrV0dKZVdN?=
 =?utf-8?B?M3FOU0sxcTJqRTRnbmJEZ1hQRUtHR05CSmxEWTk1QWhXZFJ4bXNFbFQyd1RJ?=
 =?utf-8?B?MHhGUmxjSzVPTkRkbDZQK1pqOWN6bUtUTjFkVFIrcjR4WGNRS0dWVkZMdmxL?=
 =?utf-8?Q?tHfC66RCQsveJKrnbfCPzmSPT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07FA7EC6C2FF264CB86291F527A2EB18@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OeW4N32w3ZanygEdQCUHxf/T1LDGsxQO/v1t/oCvDdif42uUCqX6VUqwjpB8nOmnFSJviUlL/tdKR+9FsJO09tDO56HhqKUdG4/SQ4qCFfSH/u1tzQuXv3RD3FJMkiJrFQFt2ZHr7ifFC0RGlsD4WcX7SPTaehbG13Uxlu0hugqUzaZh0KbOZBE8AnUgwJCisvODNB1VvxsmGpdk6ng7dHlapJAjYbnV7Vc0U51GRUjYMmMK6UxM7ejamQtLtMgM6J7EuH2zPbpGROVaOUFQJxNbk13F5c+pQXDM7NF4ydV6pzv31mlQfK5uMgx1tugmqPB503wSra4mYDnqERpOm6bEKos83l5L4e8tlIQrV0SPknDCYsY8hgldw73dJLTcYSkr83CV6IVtmRGfbrouXEINKWsAjdjyqV/orzyPp9R+/Ytv06YhsaMGNToua9pC2vHPPO8Dj97FEgeEaTNF5hhyZ97fxtVpqqTR93p+7K+9eHQQAdBInFIH+Gp11sqUCQwrnT5CL3ZcIrfSdCPnb725dnWpV6Dz3o0I8+ip8TKCkvhLoW+1Yq0M1rpp3c/NAAedw6PZZcBwxQ0nnyKQxr4PcB49HAHP4CqAMKWHb4KI2CBxQRUw9FVFyCjQOH2UFl8vmmzGIDTPZnj8ISJAxw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca054bb-4e05-459c-e3f4-08dcd41ca8cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 17:51:13.5369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyBigxqXVkwerG6CElWbpLzVDr1+YyYmIwIH08F+KT4ItkjfvKAGO2V+pCOrWdGaHZzrQEU0V7EmWMLMxPVU8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
X-Authority-Analysis: v=2.4 cv=Z+i+H2RA c=1 sm=1 tr=0 ts=66e47b97 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=njV1CBhiTl0FDbj9u7gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Nji8tggjEGDHtLmbalQUe-q1CpWjLIB0
X-Proofpoint-GUID: Nji8tggjEGDHtLmbalQUe-q1CpWjLIB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409130127

SGksDQoNCk9uIEZyaSwgU2VwIDEzLCAyMDI0LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4g
SGkgVGhpbmgsDQo+IA0KPiBTbyBmYXIsIHRoZXJlIGhhdmUgYmVlbiBubyByZXBvcnRlZCBlcnJv
ciBpbnN0YW5jZXMuIEJ1dCwgd2Ugc3VzcGVjdGluZyANCj4gdGhhdCB0aGUgaXNzdWUgbWF5IGJl
IHJlbGF0ZWQgdG8gb3VyIGdsdWUgZHJpdmVyLiBJbiBvdXIgZ2x1ZSBkcml2ZXIsIHdlIA0KPiBh
Y2Nlc3MgdGhlIHJlZmVyZW5jZSBvZiBldnQtPmZsYWdzIHdoZW4gc3RhcnRpbmcgb3Igc3RvcHBp
bmcgdGhlIGdhZGdldCANCj4gYmFzZWQgb24gYSBWQlVTIG5vdGlmaWNhdGlvbi4gV2UgYXBvbG9n
aXplIGZvciBzaGFyaW5nIHRoaXMgaW5mb3JtYXRpb24gDQo+IHNvIGxhdGUsIGFzIHdlIG9ubHkg
YmVjYW1lIGF3YXJlIG9mIGl0IHJlY2VudGx5Lg0KPiANCj4gVGhlIGZvbGxvd2luZyBzZXF1ZW5j
ZSBvdXRsaW5lcyB0aGUgcG9zc2libGUgc2NlbmFyaW9zIG9mIHJhY2UgY29uZGl0aW9uczoNCj4g
DQo+IFRocmVhZCMxIChPdXIgZ2x1ZSBEcml2ZXIgU2VxdWVuY2UpDQo+ID09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQo+IC0+VVNCIFZCVVMgbm90aWZpY2F0aW9uDQo+IC0+U3Rh
cnQvU3RvcCBnYWRnZXQNCj4gLT5kd2MtPmV2X2J1Zi0+ZmxhZ3MgfD0gQklUKDIwKTsgKEl0J3Mg
Zm9yIG91ciByZWZlcmVuY2UpDQo+IC0+Q2FsbCBkd2MzIGV4eW5vcyBydW50aW1lIHN1c3BlbmQv
cmVzdW1lDQo+IC0+ZHdjLT5ldl9idWYtPmZsYWdzICY9IH5CSVQoMjApOw0KPiAtPkNhbGwgZHdj
MyBjb3JlIHJ1bnRpbWUgc3VzcGVuZC9yZXN1bWUNCj4gDQo+IFRocmVhZCMyDQo+ID09PT09PT09
DQo+IC0+ZHdjM19pbnRlcnJ1cHQoKQ0KPiAtPmV2dC0+ZmxhZ3MgfD0gRFdDM19FVkVOVF9QRU5E
SU5HOw0KPiAtPmR3YzNfdGhyZWFkX2ludGVycnVwdCgpDQo+IC0+ZXZ0LT5mbGFncyAmPSB+RFdD
M19FVkVOVF9QRU5ESU5HOw0KPiANCg0KVGhpcyBpcyBncmVhdCEgVGhhdCdzIGxpa2VseSB0aGUg
cHJvYmxlbS4gR2xhZCB5b3UgZm91bmQgaXQuDQoNCj4gDQo+IA0KPiBBZnRlciBvdXIgaW50ZXJu
YWwgZGlzY3Vzc2lvbnMsIHdlIGhhdmUgZGVjaWRlZCB0byByZW1vdmUgdGhlIA0KPiB1bm5lY2Vz
c2FyeSBhY2Nlc3MgdG8gZXZ0LT5mbGFnIGluIG91ciBnbHVlIGRyaXZlci4gV2UgaGF2ZSBtYWRl
IHRoZXNlIA0KPiBjaGFuZ2VzIGFuZCBpbml0aWF0ZWQgdGVzdGluZy4NCj4gDQo+IFRoYW5rIHlv
dSBmb3IgeW91ciBoZWxwIHNvIGZhciB0byB1bmRlcnN0YW5kIG1vcmUgaW50byBvdXIgZ2x1ZSBk
cml2ZXIgY29kZS4NCj4gDQo+IEFuZCBXZSBhcmUgdGhpbmtpbmcgdGhhdCBpdCB3b3VsZCBiZSBm
aW5lIHRvIHJlc2V0IGV2dC0+ZmxhZyB3aGVuIHRoZSANCj4gVVNCIGNvbnRyb2xsZXIgaXMgc3Rh
cnRlZCwgYWxvbmcgd2l0aCB0aGUgY2hhbmdlcyB5b3Ugc3VnZ2VzdGVkIGVhcmxpZXIuIA0KPiBU
aGlzIGFkZGl0aW9uYWwgbWVhc3VyZSB3aWxsIGhlbHAgcHJldmVudCBzaW1pbGFyIGlzc3VlcyBm
cm9tIG9jY3VycmluZyANCj4gaW4gdGhlIGZ1dHVyZS4NCj4gDQo+IFBsZWFzZSBsZXQgdXMga25v
dyB5b3VyIHRob3VnaHRzIG9uIHRoaXMgcHJvcG9zYWwuIElmIGl0IGlzIG5vdCANCj4gbmVjZXNz
YXJ5LCB3ZSB1bmRlcnN0YW5kIGFuZCB3aWxsIHByb2NlZWQgYWNjb3JkaW5nbHkuDQo+IA0KDQpZ
b3UgY2FuIHN1Ym1pdCB0aGUgY2hhbmdlIEkgc3VnZ2VzdGVkLiBUaGF0J3MgYSB2YWxpZCBjaGFu
Z2UuIEhvd2V2ZXIsDQp3ZSBzaG91bGQgbm90IGluY2x1ZGUgdGhlIHJlc2V0IG9mIHRoZSBEV0Mz
X0VWRU5UX1BFTkRJTkcgZmxhZy4gSGFkIHdlDQpkb25lIHRoaXMsIHlvdSBtYXkgbm90IGZvdW5k
IHRoZSBpc3N1ZSBhYm92ZS4gSXQgc2VydmVzIG5vIHB1cnBvc2UgZm9yDQp0aGUgY29yZSBkcml2
ZXIgbG9naWMgYW5kIHdpbGwgYmUgYW4gZXh0cmEgYnVyZGVuIGZvciB1cyB0byBtYWludGFpbi4g
KEkNCmRvbid0IHdhbnQgdG8gc2NyYXRjaCBteSBoZWFkIGluIHRoZSBmdXR1cmUgdG8gZmlndXJl
IG91dCB3aHkgdGhhdA0KY2hhbmdlIHdhcyBuZWVkZWQgb3IgY29uY2VybiB3aGV0aGVyIGl0IGNh
biBiZSByZW1vdmVkIHdpdGhvdXQgY2F1c2luZw0KcmVncmVzc2lvbikuDQoNClRoYW5rcywNClRo
aW5o

