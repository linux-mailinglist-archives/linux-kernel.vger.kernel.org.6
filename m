Return-Path: <linux-kernel+bounces-278729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E58AE94B41C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7651A1F23881
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83751C2E3;
	Thu,  8 Aug 2024 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GyyWgrz1";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VaQS5w79";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L64buDx7"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D46FD3;
	Thu,  8 Aug 2024 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076488; cv=fail; b=Ld77uTd7QeVtPNU6HyuqkaIn9fs3GZ1QnSsvnFEDwVv8hBh4jbXqltC9yZslMZpZypWUCsiZD+Q4n9KAifg9zowvlzqCcl04JgoKXkSB69a1hXhncsdpsFJTcMGgt614WkaLa70FMeZ8l77gNHD44pd8ttnaT23NG+srQKKr2W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076488; c=relaxed/simple;
	bh=b0hULtA35bjFQt3xaroJGMjauKvNH2FR6Jzw35BEWSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bz/vo76jaIDOJvN96N351VUrXYuJ9zfhfxPz1yErmWQ5XqNyuyBSApnSuiiSwfU/BQS6t96/16g2RPzcmwFuXaDdNgnVKdWiRvyNuU5HeCsnAgZPxkwY0xCvOnWUJ++0QDK0zSqvHTtSCTX3tONCCa71qoNKIY/dzsVFanMyqPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GyyWgrz1; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VaQS5w79; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=L64buDx7 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477MmfIY021919;
	Wed, 7 Aug 2024 17:21:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=b0hULtA35bjFQt3xaroJGMjauKvNH2FR6Jzw35BEWSE=; b=
	GyyWgrz15Zfu9viVJLMknWOWVz/zWZd21YGcCt1+dZHf7wh+hvpupCJoPFu6HNfi
	OpB6PC4Uc/Va2FoRPNvNM3l6qQtDk9QHGSXr0B3KlPrivNbcefOS24I8HMvPfMAn
	h8d8xW2W6LvBqoor1B39p0h3wwhQHT2gUjr9oq6eTJFRorIPpiTpKLd8l90IAPy0
	G7234pty/IxFqMvP+A/8tO+IGYqPv3CVzLWAMHoBjzSLrKgZS0Y4frPuPWLpdYVy
	Aq8Rh+fvDYSfJQZ2OScqndGVpxDsefTw6eSgWDQ6F7EcYFO5CooiYXckIay3xAxw
	oAbrJuCvXnA2pWXn4D5CDA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uuj5xm2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 17:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723076475; bh=b0hULtA35bjFQt3xaroJGMjauKvNH2FR6Jzw35BEWSE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=VaQS5w79qLLTNSu2SH7daKpHHacB3qFAdm3IJSCRnTnvz+JXZT09hE5jFoNxKBoMR
	 fMidRwSmXQAT2VXzX0hZLM2Pd+88bZNjCv06PEaOtCcx1cu1Qqrhn3m2JTGIjeLEHy
	 RJjc1ELV6M8DtqgF2sU6+rr2+w41l2zcgt45IaViB99X5y43qovgHInf3cXlfXxq57
	 r5cKKLK8rPpi+acexDaH/wusvHxly4xyQjq99Z38bRRTEoeSgqYAEoolNR4gimBX2S
	 ajtORMU3QBIjJNFR1nTfuZN1I3xMohErtdaBIhm6N2vQXJXvPVd3pXWesE376Ns+TJ
	 70ldcTljB1cgg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8860D4052D;
	Thu,  8 Aug 2024 00:21:15 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5465CA0267;
	Thu,  8 Aug 2024 00:21:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=L64buDx7;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4C9BF4035C;
	Thu,  8 Aug 2024 00:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cb+zLm5UyS7tJZQOCuagrtcTym8RvaqxB5B77Hc91oS/FE8iZE8P311fh6+TAIjB5Gev8v9c+yJTLJH4uWj0spBm4qMyb0n2KaJKL6W16pVnM5fljsw3lh5X6zSUjm5MIwGrfg6X9BOnvk1eSGHOT0YRJiHiYBBPtxj+zq1TaA1WgwT7QkyS/zrEv0zArX92vKJtg5mLU+C/xam8c5WtwwflhjOPxcovCmfTKZBdM6GT6vlCpHTVJ1mY3rzLD0LW0lbhqufOm7POoP7+sbADVq+7rEKyuXvMcgIOXy9i4jAdPmRV3AFLB6qa7L8kkMmPDCmhCcIMSHb1PhMfzdzjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0hULtA35bjFQt3xaroJGMjauKvNH2FR6Jzw35BEWSE=;
 b=cLJoSxo18i8OVXJRtpz54vxLZazVQM+TICczX9wKNqzLbRzsCWDYf9zwUg2LsIvd7qipDCrJCEN2tQacczIEUVMyOn7JHj9jesuzpTQoOPFBQNwr9PEu87H04jJC/xNRms6L/FuiiHnZ+qtW7Z2uLBU0ZaxvTnhZ/zdZnv47MQiun5mMBMKv7kxoqmY+qkmvePI4cjwpIM36TaeFmADgvmx4IFEKWSDlUi3fTkY3v+AW1B5Z5aTUJA5HjdS6NQCefFYjQTwzR7sF66amwQ7jXz1fAwUbzEZO2lwg2osgrxAwJveqAfh6aSOfuQdaIZu63VYpvdN5/AnuovhkF3bkbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0hULtA35bjFQt3xaroJGMjauKvNH2FR6Jzw35BEWSE=;
 b=L64buDx73vek8hm4zUKY04wEaHfO/wRDn11JKT0KU5pjAn0r8z9abPNs/Jxb5P77A9AXDI90jha6OwxNfGRj30rm61PVVQ7gCdPWdsnq6jTPPyobBMM7RPe84fRbN7paXuaTIIekn748nX5uf1HW+se26k2J41pNEpJ8GsuVDtU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 8 Aug
 2024 00:21:10 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 00:21:10 +0000
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
Thread-Index: AQHa3Fh5nl8CDkK4NUOHZiwybpoX8bIbBL8AgABMOQCAAUgPAA==
Date: Thu, 8 Aug 2024 00:21:10 +0000
Message-ID: <20240808002106.uixkgga6lvyfdct3@synopsys.com>
References:
 <CGME20240722145728epcas5p38f8ecf57278b4a89c0b09430518c8599@epcas5p3.samsung.com>
 <20240722145617.537-1-selvarasu.g@samsung.com>
 <20240807001408.fby2mjug3jym2lqs@synopsys.com>
 <0b985241-31a4-4d12-80be-4e211d21dfd6@samsung.com>
In-Reply-To: <0b985241-31a4-4d12-80be-4e211d21dfd6@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ2PR12MB9163:EE_
x-ms-office365-filtering-correlation-id: 647c0ccc-d692-4821-06c5-08dcb7400123
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RUExMW8wcG5uKy9lMGNEdlNlMU1HbGhnSWRtbVBBWWhoOEZqMDBSUndaUDN6?=
 =?utf-8?B?cW01ZU5VeitsOHZrTkphUUpsd1A0M2JuK0NnSHdrYi8rVHZuN0tBZ0M2RjlW?=
 =?utf-8?B?QmtHVzlrUDhQQ2ZYdVY0cnppM29xNmxySWNSdzdGS25WY1FrSVRMSDBva0JS?=
 =?utf-8?B?aHkxcG5LNUtra3pWa1FjN3hNL0ZaMGFNbUEvQjVFMDdVVnRKL3ZHVUlNZlVv?=
 =?utf-8?B?clJCb0ZKKzhTTHNBbHNoOU8wSWhWbmpXN0NIbU02bERoNm1zSGlPLzloWnJp?=
 =?utf-8?B?VkFMVERCcnVZMHcva2ZxdGlZRGl2SGZINDNuaURMeDduV0RvL1B4L0hZd0VP?=
 =?utf-8?B?eFJqU0RKaWJPWVVPakVaVEtNaXV0dGdZL2RnYTFiU2pBdjJyb3djdW9MOFll?=
 =?utf-8?B?SGRiajFXOXg0WUU5cUI3QVppZm16dVI3cDczSzZwQXhYNXNaMUQxdExlUTJ2?=
 =?utf-8?B?OGJLb25IUldvUFNtK2E3R1NrU292TzI4UmtFbWhYU0JWcXY3QnRNK0FaQW9G?=
 =?utf-8?B?YWJGQXcyUXFPdTRWR0VFTW8wTnI1TE9aU3Q0MnlwVWY4Z09LRWw0dWtCWURh?=
 =?utf-8?B?Yk9yc1hLRWRJUmxxem9NdW5YQzdvVEFZVVFROUZ6aW04SUI0NUsxczJHTnhJ?=
 =?utf-8?B?QkZpaGhHeWwxNWpUTjhZRkJMZGpodm9OcnhwMmlrY0tzRksxbForQzBxYXli?=
 =?utf-8?B?ZzZYRy9RV1VLWmt6cFBpM1d3RmJRMlhDaGViY0c1MGcrL1pkbzI4ZkdSdXQ0?=
 =?utf-8?B?N2kvUmtzWWdNam5qRmFMUWVlQllaMTFSRWVuZE9qNUtRNnFIS2x0UXVVSlJo?=
 =?utf-8?B?ZjZ3K1hqOVdrZUxvUXNyVnFvc3UxWjB5NjhEaGRzNHJnYnZBOFZYZTA0Smtj?=
 =?utf-8?B?YU9yQ2U5bWFHQnIxcnc0aDkxUlBRYWpZbTRFQVBMY1plRkdLcGswaGpNWks3?=
 =?utf-8?B?bzl6QSttNjhmenZoTmhUcmJ5MnM1N3RlZkNQOUx2S3Y5YkQ5R2NQSHMzVkEz?=
 =?utf-8?B?SVNuRm9wRHNlTmZqVWVURmdNd1gxSHBMYnVTVHF3TU1hc1MrUzFNU1ZPSzFH?=
 =?utf-8?B?eC9XZVVDdWEzNFFhRkhKVTJaR2pGMGJDbnFGc2JkUXVNWHNiOE4rSXFaSEMv?=
 =?utf-8?B?SzNIbGxKNFdrbUxTUHNkb0paUUVGa1VkME1BTzNNbnQ3d05iU3BBYzliRGht?=
 =?utf-8?B?aEJwbElkZHdpMEJDS0NoTnhTeThiZkxZQnVKSklpMFhuZW9rOTNTVGxQQk5n?=
 =?utf-8?B?RG1EaWN5YUtNM3VKVXV3RVNrY1BUMGZhNE5mcTl4Q29PSkRoeWtWcG9lZExG?=
 =?utf-8?B?STBjSUxJTzVwc2YwN3R3UFJFTWVoT2hCb2hWKzhsbEZDUG1CM3JzRWRDOVMy?=
 =?utf-8?B?NG1EZ2hGNlBKU2F0bXJnMVNrL1VjQUxGVkxHTFJQSld2TDVFLzlBb3NsQ005?=
 =?utf-8?B?bFZBSDZSNFA1WTV6YkExZHc0UUFaaUx1VzVaZjE3TnMyMnhBMk1uTGFVV0VO?=
 =?utf-8?B?WHp0VUJhcFNSR3QwTHg3WXJtcnlxOEFuOGdNWTEzQTdKMTFTMTdmTzRhYzZ0?=
 =?utf-8?B?RDhUNjF6YWV3RUVDMkhNZXJRV0U3eEVHdEsxM1ExNEhYaFl2NVgrbmxyckht?=
 =?utf-8?B?NXNIS21mVUZVZ0w0RlFuMFhBM0xtSzZ1VGl1bnorQkpSOUJkeUNqQnNPT0VU?=
 =?utf-8?B?c3hDN1M5UDBUSDcySHN2b2tGcFROR2RNL3ljV0YyMWNBNGJRRWIza0ZIRUJp?=
 =?utf-8?B?MnZIUmh2ZXlIcUZ1Q2FSTVhiOGM5eFVTWXpPRFcxcWhnZlZRZENzRWJJTlFI?=
 =?utf-8?B?UVNybktuU2JTdmJ2SWhUSThKNWFTaTBTMWU1T282aTNCR0xjT2JnMkt3eE9s?=
 =?utf-8?B?cU0rYjdwMEx1TnArZEF5NWNVaGdzYU1HVG45Qjk4TjJHMEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFZ1VmtPdjZVZ1llNDhxa2VjN3c1SEIvcUNHcjRNbmlMVzVBUzJlZ2tuTzVB?=
 =?utf-8?B?dDF4K2huKzBhekNmOThUamUycHg1akdFWHE1NXRZNnpTbWV0MDBpYlV2a0g3?=
 =?utf-8?B?Nk1YWUxwZ2tqU0xWTVV4Z1ZiL2xBdHhQaDFnemE0R1hKK2ZlV1UvOHRKclVG?=
 =?utf-8?B?aytGRHlrS3ZRS1BUS1M5RDlvVEpEOHNqQWw1VGgyV0xaRkYyUG1oQ2NTcGR6?=
 =?utf-8?B?WU5BeDZFMDdTdHRXb21tZDU2SjRkNEFQdWd1U1lvL2FRZ3lKNVZnRkROdVZ0?=
 =?utf-8?B?SzI4V1RTU2tmNG9XM1RlSnY3U1BBQ2psM2IxWmduVDh5dmZyL2pORWFHT3lE?=
 =?utf-8?B?MzgxWm91SEVqTTdlVGx5Sy9xUlJLQXhmb25UM1VnMUV0N0JBVjB6aXZlcE5o?=
 =?utf-8?B?L1krR2pSU1h2bzQ1S1JkRzJpeVJKd2NkR1FzdTVwRk5kQkYvSXFYNDE1U2dj?=
 =?utf-8?B?LzRWNHZsL0RuU3NyRWc5UGs5VlZmRWZ6ZHFYeDRKT2g0R1hNQ01XUkxkQmRt?=
 =?utf-8?B?bTUxbHlQTVVwemdrcXZEeTZKQXZuSWU1RWF0UHptSE9BR2FMN1l1YS9TTmZs?=
 =?utf-8?B?NG8wUkNPZ05reEJnZStPZFVEVzZ1aDB2WFlzZ1E4aUNIK3R2d1lxZnliQjJS?=
 =?utf-8?B?Z2FrOEMzQjZFdm1PbVY5ejN4SjVPUVFURUhHakY1YXFGOXRvaFJCSmROV3Qx?=
 =?utf-8?B?NzR2cHBUeE95UTdVSEdhVnljYncrSHRuUmpOemV3bmJTUnJCMjMxejhWTDVh?=
 =?utf-8?B?NDZzek5vS2NLY25ZaXAvRnhBVjNGcVl4SkdLdmd0R0J3RkFDeEE1cEJ0bEUz?=
 =?utf-8?B?dXpoRnU2WmlMaXdlY05iNXBiMzhEWlRrWGVCUHdaclNFL2FTaDhsTXhpZklv?=
 =?utf-8?B?bnVZdEpFRXlOYzA1TWRqL0kwRU9JY242R2Uxb3NvTXFtcExwVzA4M0psMkdl?=
 =?utf-8?B?SkhJZGhrc3Q2S0FVWWdrSCtKSUlrSkUyajlxU01CeHgxcUhseVFzM2NZcGlQ?=
 =?utf-8?B?Y1lmZk1VLzJlejc1NU9NNzJRSmUvYitDdmNPMEFEdlhTOTN1WUU2cms4aVBo?=
 =?utf-8?B?b1B3bzEyaHQ1VElvTWJ0d3VhUjh5MUZkVzBXejVrNUpsd0x4NFY3MWhCUHB4?=
 =?utf-8?B?UXhVd3o1eTNJMHRNN0RENGJNVWQzcDBTQXdDazZOZXR2YTd4TUtJTXEweTdC?=
 =?utf-8?B?bkZBcW8zZEJOcm94THNQNDczS1ZHNndQWXRoR3ppTkQ1bVdwYXp0aWN5UURW?=
 =?utf-8?B?M3ByUE1SSDdHc3BGT3lWMUdmL1RiOFBsY1BRemRDVjdZYkdnZTNOdG1ZUUNr?=
 =?utf-8?B?S3hqbjVQRkhBR2VGSE1vYk8zd1RXZkxrTGF0V1UxNktTUUNLKzhSa1F4elR0?=
 =?utf-8?B?d1MvTXdtd0NML3pkdFpvUy9LaDFGQWNyMjVidmJRUnIzQzhHbkNJZTdhNUVN?=
 =?utf-8?B?Uk9sRldJUDcvZTM2bEVoNnJrS1VBditaRVJ6Y3NVS2lydERqNHZtNTRVcDVZ?=
 =?utf-8?B?RHFwVHZSSjM4MGxnOHZHcWFMSGNvMm9wK0ZwbVZ6OVVsV3N3dXhxU3NFbTFK?=
 =?utf-8?B?WUY0Qi9pU01TSTdmMmhDVGlnVmVhakZCZCtzYkNrNGFhTzd2OEgwUXFxZ3ZO?=
 =?utf-8?B?c2VOOUZMNS9Xb21uLzZMamhnQ3h2TXBzUzBFNmpzR0o3SU94Y1Bub3ZFcVZG?=
 =?utf-8?B?Y0EvczZZQUxkUVo5V1VnNzFVbTgyRCtYY0VOZFVGT2tnZy9ZZ1EwNHZ3dk9C?=
 =?utf-8?B?T0s5R1ZYMFZxdEhlNi95ZDAzUmh5UzQxVXdrT01KNWMzTGxuUDNQSmhRMzFq?=
 =?utf-8?B?MUVxbDBUVGhFemJMKzM0M2NSWUtPYmNjK0VjSmdNYWhBSnZLWFcrQm1oV1pT?=
 =?utf-8?B?SG1GL0JVckRpYmRBV3dlZDZxWXZOdENSQVU0VDZMRjJabEVCTmw1SzBQaG8v?=
 =?utf-8?B?eHBVUHdnOW9hRktJWkRydUNETFZxeW9sMmhDYWtmdGlrYnRCQStpNGZvVzhO?=
 =?utf-8?B?OTMwNlRvQVc1SWNmWjJqbXp5K2VLNDNueHM4NjVSU1NTUURpVk9nMWRselUx?=
 =?utf-8?B?NjA5bE1vSzJodThHRDg3bktrSzVtODRzaGgxeGl5MjFJTzZ5bnVxWDhIZ3lh?=
 =?utf-8?Q?lRC2Y3enmK8mvb2yx100SzO2p?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF9E2CABB9878C4F9A0181D5CDE139F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	guw40PI/f05dPsctofGkXWprR+RL06Pb4JcT3UafMix0tNZwW67vilFl5XNgZcNyuz+cDViWq08pyGMylg2JtHY4D7iX503VrR80q1xn8ST0VoJ+iKEyl23NfyArht27Mff9gxbz8aqNwbdB2s/3SqsUvZyv2eUnfcLCXcjs1oO+1IcuDKRqPRkazwch9WldIH8BhYQQ5IvhM/5ttFvkIw67y3ahAV80WVFj2wUHzm6Dzs/II1RGwCvaMXqdZ6cGGszGY92HSN9581RrOKcbcgus1A6yBjJE4RQyjV9mu8bbBDUnA3H5KPibp5d5p/O/HUQ/XUFmOXKLv0k2pAEnqGLFXVc40NnVvafeUmw8Bo3uj0TXJVtmpZ0KC9v9joxWb6b9xeAw/DNZiOcNqPmElzm5Mg6a3EkEp08b3LT1Pw5qAfC8CeF3eQZoXEjSqVYUfizB/sHnjjCkrLwPlKeM/4HySiDOpV7s9gRuV3018AbN1qTrcDhxoMbPiczhpOnFpOzInIH+yfYNGWgf4fQTTT78j9lu/8zgyFGLSM7q7tMsTWdF6NlHg80dyaZ1ixBgnrFafEYUYBTJAwAqCtn2JhK5DYsPsF/HWjeWeocRq85ViB+rt3AGL0HtRsNtDfFSOQqT40MUfM6qYUAZRcC4ew==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647c0ccc-d692-4821-06c5-08dcb7400123
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 00:21:10.4455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIUITmOo05YT8XSdQXx9s6bITydcIiLEbFhpp5bZ0Gd+Nhx4OwUrepeSapXMZBBhen7gCY4hJAA1fqtN2OOuTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
X-Proofpoint-ORIG-GUID: MEWCjt0VvTkY7yDlpoLJQDb2UhBr5Oua
X-Proofpoint-GUID: MEWCjt0VvTkY7yDlpoLJQDb2UhBr5Oua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_15,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408080000

T24gV2VkLCBBdWcgMDcsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
OC83LzIwMjQgNTo0NCBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIE1vbiwgSnVsIDIy
LCAyMDI0LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4gPj4gVGhpcyBjb21taXQgYWRkcmVz
c2VzIGFuIGlzc3VlIHdoZXJlIHRoZSBVU0IgY29yZSBjb3VsZCBhY2Nlc3MgYW4NCj4gPj4gaW52
YWxpZCBldmVudCBidWZmZXIgYWRkcmVzcyBkdXJpbmcgcnVudGltZSBzdXNwZW5kLCBwb3RlbnRp
YWxseSBjYXVzaW5nDQo+ID4+IFNNTVUgZmF1bHRzIGFuZCBvdGhlciBtZW1vcnkgaXNzdWVzLiBU
aGUgcHJvYmxlbSBhcmlzZXMgZnJvbSB0aGUNCj4gPj4gZm9sbG93aW5nIHNlcXVlbmNlLg0KPiA+
PiAJMS4gSW4gZHdjM19nYWRnZXRfc3VzcGVuZCwgdGhlcmUgaXMgYSBjaGFuY2Ugb2YgYSB0aW1l
b3V0IHdoZW4NCj4gPj4gCW1vdmluZyB0aGUgVVNCIGNvcmUgdG8gdGhlIGhhbHQgc3RhdGUgYWZ0
ZXIgY2xlYXJpbmcgdGhlDQo+ID4+IAlydW4vc3RvcCBiaXQgYnkgc29mdHdhcmUuDQo+ID4+IAky
LiBJbiBkd2MzX2NvcmVfZXhpdCwgdGhlIGV2ZW50IGJ1ZmZlciBpcyBjbGVhcmVkIHJlZ2FyZGxl
c3Mgb2YNCj4gPj4gCXRoZSBVU0IgY29yZSdzIHN0YXR1cywgd2hpY2ggbWF5IGxlYWQgdG8gYW4g
U01NVSBmYXVsdHMgYW5kDQo+ID4+IAlvdGhlciBtZW1vcnkgaXNzdWVzLiBpZiB0aGUgVVNCIGNv
cmUgdHJpZXMgdG8gYWNjZXNzIHRoZSBldmVudA0KPiA+PiAJYnVmZmVyIGFkZHJlc3MuDQo+ID4+
DQo+ID4+IFRvIHByZXZlbnQgdGhpcyBpc3N1ZSwgdGhpcyBjb21taXQgZW5zdXJlcyB0aGF0IHRo
ZSBldmVudCBidWZmZXIgYWRkcmVzcw0KPiA+PiBpcyBub3QgY2xlYXJlZCBieSBzb2Z0d2FyZSAg
d2hlbiB0aGUgVVNCIGNvcmUgaXMgYWN0aXZlIGR1cmluZyBydW50aW1lDQo+ID4+IHN1c3BlbmQg
YnkgY2hlY2tpbmcgaXRzIHN0YXR1cyBiZWZvcmUgY2xlYXJpbmcgdGhlIGJ1ZmZlciBhZGRyZXNz
Lg0KPiA+IFdoYXQgaGFwcGVuIGFmdGVyIGFkZGluZyB0aGlzIGNoZWNrPyBDYW4gdGhlIGRldmlj
ZSByZXN1bWUgYW5kIGZ1bmN0aW9uDQo+ID4gcHJvcGVybHkgYWZ0ZXJ3YXJkPyBJZiBub3QsIGRv
IHlvdSBrbm93IGlmIGEgc29mdC1yZXNldCB3aWxsIHJlY292ZXIgdGhlDQo+ID4gaXNzdWU/DQo+
ID4NCj4gPiBUaGFua3MsDQo+ID4gVGhpbmgNCj4gDQo+IFllcywgd2UgY2FuIHNlZSB0aGUgcHJv
cGVyIHJlc3VtZSB3aXRoIHRoaXMgZml4IGV2ZW4gaWYgdGhlIFVTQiBJUCBjb3JlIA0KPiBub3Qg
ZW50ZXJlZCBpbnRvIGhhbHRlZCBkdXJpbmcgc3VzcGVuZC4NCj4gDQo+IEFuZCB3ZSBub3QgdHJp
ZWQgc29mdCByZXNldCBhcyB0aGlzIGZpeCBpcyB3b3JraW5nIGZpbmUuDQo+IA0KPiBBbnl3YXkg
c29mdCByZXNldCBpcyBwYXJ0IG9mIHJlc3VtZSBzZXF1ZW5jZSBhbmQgaXQgd2lsbCByZXNldCBv
ciANCj4gcmVjb3ZlciB0aGUgVVNCIElQIHN0YXRlIG1hY2hpbmUuDQo+IA0KDQpPay4NCg0KSnVz
dCB3b25kZXIsIHdoYXQgY29uZGl0aW9uIGRvZXMgdGhlIGJ1ZmZlciBhY2Nlc3MgYmVjb21lIGlu
dmFsaWQ/DQpXaGlsZSBpdCBtYWtlcyBzZW5zZSB0aGF0IHdlIHNob3VsZCBub3QgY2xlYW51cCB0
aGUgYnVmZmVyIHdoaWxlIHRoZQ0KY29udHJvbGxlciBpcyBpbiBydW4gc3RhdGUsIEkgZG9uJ3Qg
dGhpbmsgU01NVSBmYXVsdCB3aWxsIGFsd2F5cyBvY2N1cg0Kd2hlbiAoIShyZWcgJiBEV0MzX0RT
VFNfREVWQ1RSTEhMVCkpIHJpZ2h0Pw0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBTZWx2YQ0KPiAN
Cj4gPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBTZWx2YXJhc3UgR2FuZXNhbiA8c2VsdmFyYXN1LmdA
c2Ftc3VuZy5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwg
NCArKystDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+PiBpbmRleCBjYjgyNTU3Njc4ZGQuLmM3YzFhMjUz
ODYyZSAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPj4gKysr
IGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPj4gQEAgLTU1OSw4ICs1NTksMTAgQEAgaW50
IGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+PiAgIHZvaWQg
ZHdjM19ldmVudF9idWZmZXJzX2NsZWFudXAoc3RydWN0IGR3YzMgKmR3YykNCj4gPj4gICB7DQo+
ID4+ICAgCXN0cnVjdCBkd2MzX2V2ZW50X2J1ZmZlcgkqZXZ0Ow0KPiA+PiArCXUzMgkJCQlyZWc7
DQo+ID4+ICAgDQo+ID4+IC0JaWYgKCFkd2MtPmV2X2J1ZikNCj4gPj4gKwlyZWcgPSBkd2MzX3Jl
YWRsKGR3Yy0+cmVncywgRFdDM19EU1RTKTsNCj4gPj4gKwlpZiAoIWR3Yy0+ZXZfYnVmIHx8ICEo
cmVnICYgRFdDM19EU1RTX0RFVkNUUkxITFQpKQ0KPiA+PiAgIAkJcmV0dXJuOw0KDQpDYW4geW91
IHNlcGFyYXRlIHRoZSBjaGVja3Mgc28gd2UgZG9uJ3QgaGF2ZSB0byByZWFkIHJlZ2lzdGVyIGZv
ciBhbGwNCmNvbmRpdGlvbnM/DQoNCmlmICghZHdjLT5ldl9idWYpDQoJcmV0dXJuOw0KDQovKg0K
ICogSWYgZHdjM19jb3JlX2V4aXQoKSBmYWlscywgZXZlbnQgYnVmZmVyIGlzIG5vdA0KICogYWNj
ZXNzaWJsZSBmb3IgPFhZWj4gcGxhdGZvcm1zLg0KICovDQpyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+
cmVncywgRFdDM19EU1RTKTsNCmlmICghKHJlZyAmIERXQzNfRFNUU19ERVZDVFJMSExUKSkNCgly
ZXR1cm47DQoNClRoYW5rcywNClRoaW5oDQoNCj4gPj4gICANCj4gPj4gICAJZXZ0ID0gZHdjLT5l
dl9idWY7DQo+ID4+IC0tIA0KPiA+PiAyLjE3LjE=

