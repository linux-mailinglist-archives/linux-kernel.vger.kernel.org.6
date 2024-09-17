Return-Path: <linux-kernel+bounces-332147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD9897B5FE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 01:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C28E1F24C44
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663A18DF81;
	Tue, 17 Sep 2024 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="I9KdFNMH";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Oiz3qO+v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fsu02EaD"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EEC3AC36;
	Tue, 17 Sep 2024 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726614528; cv=fail; b=a5bUCXV6RnOoGJbY3k4XQ+h9/Ic//t2sB/zRC8IrGAeU+HefqlFb+n2r5dWhvzrgTnm3Y5CYFotTjmEOdwuWRzP/yRRijkgmFkU9uiUMRdejEfWPceJWCC94gh9/E5+JBJBM9cudmVw0arK/pP8miyrYeohNU3qQzi+tGt+9iEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726614528; c=relaxed/simple;
	bh=6ZB2jfZmk/BjzvXHFOWZXf3RieLCy6adrh/aVv97zsM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rfcaY7b1j7t+Oc04sf40PEePKXGr6lovv7AeSMWHlPoBGUeYwqIhqyv2KWp+WvcqCnEJ3m8xSOtA0qs76lCJItiO03QkpyFNjldX/usafn8t5c1tTCwC4nkyvGq2QKNp4SkuI3ogsGugF+iSZ6TYUlH9zMjkHewiNvF4MKhledc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=I9KdFNMH; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Oiz3qO+v; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fsu02EaD reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HJ4d5t020673;
	Tue, 17 Sep 2024 16:08:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=6ZB2jfZmk/BjzvXHFOWZXf3RieLCy6adrh/aVv97zsM=; b=
	I9KdFNMH0GJIEPb1+FywfEhNA+UDaQ2W6LDSOMNqWcIZHTh1dKX/C9Xp9SsgKpsC
	iWP9KYAL641yMcxLBBseBvvJ/859wDrAinrNp8JPXOSpBtK2+VUQTufz68x7iD9N
	ApGCzwiPd/d35okkHZF25LY408an17PivxMP3OVuonNczsQIaP5asLHnS2VQ/xAZ
	+WntICpV1SWGP5/UbdLrmxZrieoPlut7c2kMHQrq1lth4Qb57ozr0zEeInJhBe5s
	gTD1coxjG7jNN4fXw2+EEwwxNP25gd/kRQc4CFAEcMsYQsno2VmlKHFskMeAbQgZ
	yxH6DiBiqQg030zeMKtPkQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41n9dv7djr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 16:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1726614497; bh=6ZB2jfZmk/BjzvXHFOWZXf3RieLCy6adrh/aVv97zsM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Oiz3qO+vHXbIhI7xnv/mIR8cJICQ1sKNb6+YngXkLVqtXpW20CbnN98dzrTrox8VO
	 MVd3i3ynvXqgLcUllkW42i/gereMOru8f+FxxPKh86cMfyLgD17bx4w8VJPcqDmP6m
	 OXqffiZYmxJdzC4vQhfLIgj7gJaFy9SJym3KhfdJ7tXGiUKH42FVJrX7f2kQuzyT3V
	 qXO82Yht9gGUDs1e7hdm0YtVyHljy5T/lGKFu/UtsdqBT6fQiKnXlMPR87Oo9uwa8v
	 mFpnqdl9HZegvjbEvenbAR/I1jeTl+rIPEtDJSWYvsrAZOXrZiuqeoOffir/kP0j2j
	 uGJRH9aYKxBzQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6F4184034B;
	Tue, 17 Sep 2024 23:08:16 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 9FF90A0070;
	Tue, 17 Sep 2024 23:08:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=fsu02EaD;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D0EBF404B0;
	Tue, 17 Sep 2024 23:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdtkW0ErDBxYBfkca2ZH5cf75mtCJohH4jq5PuJJxZaucf0MB/qv0ybabGbr/wU/nAaNXM/x7j8vZRKNSwkULMzqXHrHvdTNuuzp27Af8++Fg5F64Wj/5chy2wgU5o7iQq3iJTOd1qlncTEnrbfXGCkgv5rhU5uJCYLSFvDfycXj9N2YWDiql+pnd1qsSKaPXdrbDy6fTbAB4JiHcaonNojhM9EdJIAz9BosBE1W/y0+Mu3zdgNWfhH/zSq98UyPkchB547GqeWYywyI9inIrQzuZWqfEfSNDMaAsQ0ERRbLW+RYvs2vaIcs88OOYGViqINmlOjHLEkJIzDy2d5FNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZB2jfZmk/BjzvXHFOWZXf3RieLCy6adrh/aVv97zsM=;
 b=lPZjjsCagqnQH7FwapJPewu/moQkLERxx23qPM1GmJq2f9+4XOVpgLWkWijj0h+66El+xwHw4+Xnnrch01GG1ozzLoB8bDi4rPN2PxfRfr7GwMZb173I0OHLSpv+qYS2TsnfFsy1AWbaTf1avC5GdazBDIakz3gMvfuJyTJ6Oq1i2U+ERDtzlooz8F0YdXjDBEZtezhiF1qIPg9o4B/Scuk9IdOkSDyDWikWEXBd/BoAHNYXCwKkSclVRjdlXbAk45psyFFsJAvtXIC8QP/md5lWAoDXnYe2LTb22OgzQjtFyNsDhrIqxwWQAcludDQJKcUlINpNYJmlRNCJY59XOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZB2jfZmk/BjzvXHFOWZXf3RieLCy6adrh/aVv97zsM=;
 b=fsu02EaDWw8bn1RYmzwrjl1Qh/6jZVObKE7fP+v9mrITnHqCjs4jUmBiiBA7sykJFW7iaAwezosV3ZWOHf6PIKYADWFdBdyZSkkRk9KI12w0IRxSC8ew3Wiu+UQNsOiAM46h8PR6exL5t5epr2NsFC99rNtoCWn0ScLOghq0xzI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 23:08:11 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 23:08:10 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Joe Perches
	<joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
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
Thread-Index: AQHbCIpOIl8f+8LK4EmR75pMhvNsxrJbB2EAgABuigCAAAMLgIAAFrYAgAEMJoA=
Date: Tue, 17 Sep 2024 23:08:10 +0000
Message-ID: <20240917230805.gf4sw6phbicysixb@synopsys.com>
References:
 <CGME20240916224630epcas5p42b355e2884c665e19d3c9c3a5afd428e@epcas5p4.samsung.com>
 <20240916224543.187-1-selvarasu.g@samsung.com>
 <20240916230032.ugw23x7gijamrf5x@synopsys.com>
 <2024091716-snide-mashing-2c21@gregkh>
 <20240917054703.w47rfo7x4lhzgccn@synopsys.com>
 <2024091758-devotion-clutter-29f6@gregkh>
In-Reply-To: <2024091758-devotion-clutter-29f6@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB6354:EE_
x-ms-office365-filtering-correlation-id: dc9411c2-9b25-48b2-5806-08dcd76d99a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWg3eHdjTXlMcWNVS2dyVlUrOFY4cnRUVUtkUXZoMzR5c1BZUWU5KzNCalE2?=
 =?utf-8?B?MUVEdmtpamFmOU9pd2QrZUJHSldGMkhSa1NYMzVDdmZNdkRFNUJySlVIN2d2?=
 =?utf-8?B?cUVGNlpqUE9FaDJ1aGkzcndESnZWNjRwMVZrZkZZeGMydVB2Y3JOUSt3VGw3?=
 =?utf-8?B?WmZGa0FUM0xxa25OSkYyL3FoL3RwVTUxM0NiZ2xhTkd3UDY5NjNnQmx5QjdG?=
 =?utf-8?B?QUZndTFORXEyTGJxYjVlYnYrOFhhOXVJQmJ6MEhDVnd0cStXbCtaZHlqTldO?=
 =?utf-8?B?Ukt5R1NLNmtjU1dRUE51S1F3a3FNT2ZRU01hU0I3T3NlUmowZG5DN1pPdzZD?=
 =?utf-8?B?eG1oNFk3Sm9ETDBZOFJkOVh3cnI2Zm15cS9QL1Z2akg5THo0aWpFcFA0ZEVD?=
 =?utf-8?B?M1lFQ1RGTytGK1dxZStXLy84WFVORy8zamlwV2NMMGFNZnBQN1RHSDdJTkhz?=
 =?utf-8?B?aU9VV3B0d2pNMnZJRFB0S3ZCN1lRWEMra2k4ZFM2Sm1sais2c1RVUXlWQnA0?=
 =?utf-8?B?Uy9BekFzeWtiTHJ5OTBydWpRTlBWcFROM3RGQUE3N0d3YkZWRXJDSzB1YmNP?=
 =?utf-8?B?SC9ja3U2MEVtb3BvcWhuNXNwYUxUU3RFT3JmelpNQ2RWV3BWb1dZWnNqWncw?=
 =?utf-8?B?ZFRtRjFhSDFpZXpsdS9WN1N3M0hhckVuWTgzV0hsbTRLMHFQZENPZERUMHJS?=
 =?utf-8?B?aitUK1RoNlViTy9nWU9laUc5Z2tZdkd4R3NRK3N1VG1XWVhyRHF6QXM5eXAy?=
 =?utf-8?B?UUxqTXJ1a0FaVGNXN0JGOG5HSEtjZU91c1FrRVJaMjFycU8zVkhHWklWeWFj?=
 =?utf-8?B?eHd2L040TEQ3NUN6TmllaUlWdEJ6SmcybUVuT25RdzA0UXYvaVhMQkpZVVVz?=
 =?utf-8?B?bkd6elBjSjZrZ2VBZVU3aXZwa0k0V3hUVm5QMzdKdkcvVEFoQU1uVGZ3eXZX?=
 =?utf-8?B?bU9ZSUNwSUloUmlzc215bVMwSTV0cEwyT25KNW8zOGlyK3lyZ1IyQnVVMlVT?=
 =?utf-8?B?NmpBdkdLWmNTbjNpeE1ic05vK0VZN0VhR0FqV0pnTnBpa1hab0lIay9qNjFo?=
 =?utf-8?B?eHp2UjBLVlV2QThlVlZGMlZKdFBkQkFkcmQ5NktlaXM2ZGF2UXRwOFVnWWJ6?=
 =?utf-8?B?bEJLSFFlZU5oWGdydDBHTllUZm9pYVJLS3lEaDdYdmY4RDVmOGJ4ejlBMzRv?=
 =?utf-8?B?ZTZaTHZXRi9TeXp1MGJxeG9jejRTVngvR2FFN0t3ZVFET3dlakg5SHJ3WGhz?=
 =?utf-8?B?T2Q0K1BuR3dPQjhLV09iRHVwYUhuQldYd1VpMS8zZzMzbWMxcFBRM3ppdzYv?=
 =?utf-8?B?N2FhbXlXQlBaMTZUTVlMU1JWa241Q0ZTSnh3V0toNFp5YXlQN1B5M3NUYWtJ?=
 =?utf-8?B?T25sR00yd3JpUEN5aTkyMUNSeXQ2R2N5Z0RSYkJwZEd0ZkRnejI4UEIvZzFi?=
 =?utf-8?B?cktMRWNZQk1zbTNYNXFGeUw3Q0dURkZlSGZjTjNkZ0c3VVdXeSs1Q2sxOGRI?=
 =?utf-8?B?eUN0UTFnTk5XK2VjbW50Z1JLTVJWL2MxNSttL042TVdpWVB1Q1VGbUFIcnRZ?=
 =?utf-8?B?Ui8yN0hybjJleFMyQXU3dzVnTlRjdThwRlRPMWlCWmFTN053V29xaDVKWnY2?=
 =?utf-8?B?cGZpT2FOQmdPSi9SdVU0bDNuV2ZjL1UvTEpYT0hBcWRUd2xBZ2M3cHJnVStP?=
 =?utf-8?B?UVErSjR1MEZIbmMwT2hWYzRXbUZYSk1TRGNmU0xha09pRVFDNUJXTlZydm5Y?=
 =?utf-8?B?U1lUYnRRUzE0VGdEbHdPakowdWx5TncvbzhodmJYczY5ck9PWFE2STF5VGZ2?=
 =?utf-8?B?TmU1UEhTK3NyUUhOVXNSdGlXT1VUMnFwRGlwTURFSjJoV0JZL2NZY0RTTlZI?=
 =?utf-8?B?RFdBTDNIUWxwbXFGS2M4ajFXOGlVY1FoemZOOHdoSEM3bnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzF5OXJSK2pBNUs5c2phSW9DdVpYV1hHc21abndpUXJjMHpVVW9MQlRlcUcx?=
 =?utf-8?B?VEErRWdzNFlHbzJueTE2R1Y0MjhNZGYwTU1IbXI5YkhEd2lrQnFoenpKNDBF?=
 =?utf-8?B?bm5LelR5MWJZc3dGV0VXeHJMMGUxNkxpeGVjWnQ2b0RjMXhDeEZSWVE5cUp6?=
 =?utf-8?B?WDd2VStaN1g5VzVNa1dERUFobW1PNnZ1YWdMMU9IaGYxTHRKTWViOXdxNUcr?=
 =?utf-8?B?SW00UnJ2dVZLWmU2RzNOeDFOK1VnL0FSaExla1B1S250ZW9HN1orWFpIMkw0?=
 =?utf-8?B?MWs5Y2lXK25veUpPWWJqVmx3SnNVMDcrSm9pUUlkQmJoTW9mdGNxU0ZLWGhX?=
 =?utf-8?B?dURrb1JuaFA2Z0wxKzdEZFlNcVFPWUMzQzNzVjk0c3NLSy9HSWgzUmVScWVT?=
 =?utf-8?B?RVhWNy80cXlka2s2a21YdU1NRkdMREh3S3ZsdVRiZHRjMnlFMURERXpjMkNK?=
 =?utf-8?B?Q2dSOGJ2amthNEdJbEtlRnpUcHV6OFdodzhkK3NlUDFxaUFJL0NLMHhiTlBt?=
 =?utf-8?B?K2s5ZXB0SWlGTWVZMkNSVTVxK2JKdXpZWXFhYlR6SUVjU2h1QUlaa0hzenNI?=
 =?utf-8?B?dGFKNngySktER2JQS0pVSWs4OXJwNldQUDhHM09xUXpYZ3oreXNEcUxxNnk4?=
 =?utf-8?B?UkkwTjk5MlQwVkMwSy9RdEl2ZFloWHBXRTJmQnJwY1Rzc3UrblE1MDlGbDI1?=
 =?utf-8?B?TFJBUnhGc0k1dXlOY0hLVWNvQ2NGQ3FCdU9hcUNJaFVROWIyNjhPZ0lXbnY4?=
 =?utf-8?B?TFo1Y3JaVWpnU04vbUJYUC9Yd0hEdHlIRHRwWmNsOWdJOENiNEJSRHVCUHVC?=
 =?utf-8?B?REFpQlZLQ1dEQmFJZk1tSUZncW1CMDk0UHYrZHpBUHdWR01ncFhMTHlDTytB?=
 =?utf-8?B?TldqdlJ4dnFYcFVXNTl4dTlBV2J3d3ZySlpaUEJXSFpTa3l1OXRBbDU3ZkFk?=
 =?utf-8?B?MUMrT0dwSXNCb2liNXVVZFJCNnZ4N2FmSkFVWUhrRkthaDYzaEk1cUpxL3Fw?=
 =?utf-8?B?dGwwdWZGMVU2NUdpYWlJcVVWazN1UUNXemlWQmk5TUZtUTJNL0RiUnBEK3F4?=
 =?utf-8?B?bVkvRmlFUk9xUmUxTkV5LzJDUkxFTW9nY2FWSm1ZMks5K2ZabmNoWlBqR2do?=
 =?utf-8?B?VzJGRnVQVzRmdEdTSWNFQkF2dlZ6c3daZHJneENVSGY2NkZWVldEeEgwTDdI?=
 =?utf-8?B?djlqL2s0TnZNTzRCTFBwQ0FmSi9NM2NoV0xTVVIxNEtLaTlFK2JhMk00MEdF?=
 =?utf-8?B?VWdkbUtaalNXUERUZEF4aUVHTjVyN1NpckhNRmgvMjRrZWdydTYrSVEzZzl3?=
 =?utf-8?B?N2Q3ZHhHSHVBVkQvRGJES0lGTk4rbHZmblBNSDdGdUVPNWNhYmt2MVVmTmpD?=
 =?utf-8?B?OGFkL3Z6SUQrR1J1WlBkSlJWQ3hRSERZQnc1MUwrT2ZNSkw4QVJldFYvL0Ro?=
 =?utf-8?B?NkFDSVd3ejRKNEhhSzBUYmlmQ1JpOHpWRDZuaG4wbWN5MG5OU3kzc05Cd3M1?=
 =?utf-8?B?cWJ4ZjQ3L1B4djhGM3pQc3ZpMjFML2JLVVlBUEhUYzhLRTFiSVU4cFdKcEIx?=
 =?utf-8?B?aDI0dGJGT2M5bFQwNVNncFc0cTl6RFBjc052bFYyeDlxeG1GR1FTUmZBSUxh?=
 =?utf-8?B?Mm1CbktiSGt5VmJKRUFxaDdZQXh4MVBUTmlMZHZqQVlkYWFTNFJJK3JDaTNX?=
 =?utf-8?B?WEt1SWVBcEVtNWVaekE4aEF6bEVDOGEyWVYzQlAvYnhVdlQySytnbmRsb2lO?=
 =?utf-8?B?eEdZRFpvTk8rdU1rQ3I0MWJtcEtQZzBUajNwUlZ5ck5weXJKNG1UNWI4WHR5?=
 =?utf-8?B?YWlwOTdHeFRiaHdTTmVMYUdOcUJSeHB2YzdqYmkzcjlHcmJsUGcxK01DWFd3?=
 =?utf-8?B?TncyMU9hQ29qZnNiOWliOEJ3NjRlNmVGaytKWHV1aDJjZUVidXdRYWE2Wjl2?=
 =?utf-8?B?aVB0YUFZTXFEdU9LeXJnVXVBZnlweVgvdHhsS1RXM1hFQmpSMnpzeHE2T3Zk?=
 =?utf-8?B?d3RKUnA2eTJtbm56eHRJNFBsa2RIVzlQamtxRGc5MHpaNjkzVnFIRG94ZU0z?=
 =?utf-8?B?c293dWZlUDNzc2M0ZTNyUkVaK0VFK3RIeVhqcDJVdlVzN1NHeFIrSy9pM0pP?=
 =?utf-8?B?K0ZON244SGhGNnk5TGlUT0ZXS3RwbHlNVkZHbDRDWU5QdFk2WC9IR0VmN0FC?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <686D01541B526D459FD749F6D2DA81BC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gfN1JUIzHfVpg0YpOvgBBIRquOKHIKX8m1zjO0UbkkaQ6Y206nF9s//EEiGtz0GyqEIQtb7k45PQSLjlPup7jUCWdFH3HloRRDCNwsavC6HB5zGUe/+TAuFalHcQopblKuBjrx6P3w6woyrOON2o26ydYwEFLxVKont8V6dCp8drUW+ZW+1ixYDR+9Fb72VesSxqefptvBnGltsasSS7PVOLJrMjElcOVZ8iEe6c/5VZAzR3dXhMehFPRFOHfOvY+ZJG7ZQyGLD3ShR1Actrttohvgm5tXoB+WFhgdm72fsxDFPaqe+PJ6E22N+O57Mge/8LrTPYA+Gj/IaHh5cE3swupVSIJ6uxxCITVFbx3Cr2L8ag37SLXhV4UgiVDmfmJKo+9fsdoUJ9LyKq9vfyJdMWaG+bf3m0/LbOye1Y5mE1vxgvYUksWG8tSmmlhfp730RxSqJ1uQV7ZOxmELntjrtB/440N20P3jy0e84ClJYjoGhEgfgy/HbgqnTy87OeptxVSl/fZBNOIOUOSU7T/I3+DSNk5DEUC/OYWdTaaLsrrUD/W1SaUbIKlJP1ALYRCckjOW0iy+T88UZWmkNyiqA/bEXqSXOw1hHxsn6KyACyUeXafK69XQJg4k919XjyJpIjGq+O/stfHh/izhHQIQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9411c2-9b25-48b2-5806-08dcd76d99a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 23:08:10.8496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vKCDPyPXoRvzM7u3xMzmIi+2sjLVctnYzSqvp/ju+FZR6KfrjjR1W0iZr2lrwb5Qay1cpRqcixEiPeTsHkTqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
X-Proofpoint-GUID: k74XLKPSaevAWg9anPXqKVd4Vj8Hp51T
X-Authority-Analysis: v=2.4 cv=C+C7yhP+ c=1 sm=1 tr=0 ts=66ea0be2 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=C3tCkf5U0EG87gYTkk0A:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: k74XLKPSaevAWg9anPXqKVd4Vj8Hp51T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 clxscore=1011 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=815 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409170163

KytKb2UgUGVyY2hlcywgRHdhaXBheWFuIFJheQ0KDQpPbiBUdWUsIFNlcCAxNywgMjAyNCwgZ3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgd3JvdGU6DQo+IE9uIFR1ZSwgU2VwIDE3LCAyMDI0IGF0
IDA1OjQ3OjA1QU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBUdWUsIFNlcCAx
NywgMjAyNCwgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgd3JvdGU6DQo+ID4gPiBPbiBNb24s
IFNlcCAxNiwgMjAyNCBhdCAxMTowMDozMFBNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
ID4gPiA+IE9uIFR1ZSwgU2VwIDE3LCAyMDI0LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4g
PiA+ID4gPiBUaGlzIGNvbW1pdCBhZGRyZXNzZXMgYW4gaXNzdWUgd2hlcmUgZXZlbnRzIHdlcmUg
YmVpbmcgcHJvY2Vzc2VkIHdoZW4NCj4gPiA+ID4gPiB0aGUgY29udHJvbGxlciB3YXMgaW4gYSBo
YWx0ZWQgc3RhdGUuIFRvIGZpeCB0aGlzIGlzc3VlIGJ5IHN0b3ANCj4gPiA+ID4gPiBwcm9jZXNz
aW5nIHRoZSBldmVudHMgYXMgdGhlIGV2ZW50IGNvdW50IHdhcyBjb25zaWRlcmVkIHN0YWxlIG9y
DQo+ID4gPiA+ID4gaW52YWxpZCB3aGVuIHRoZSBjb250cm9sbGVyIHdhcyBoYWx0ZWQuDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gRml4ZXM6IGZjOGJiOTFiYzgzZSAoInVzYjogZHdjMzogaW1wbGVt
ZW50IHJ1bnRpbWUgUE0iKQ0KPiA+ID4gPiA+IENjOiBzdGFibGUgPHN0YWJsZUBrZXJuZWwub3Jn
Pg0KPiA+ID4gPiANCj4gPiA+ID4gQ2hlY2twYXRjaCBkb2Vzbid0IGxpa2UgdGhhdCBmb3JtYXQu
IEZpeCB0aGUgQ2Mgc3RhYmxlIHRhZyB0byBiZWxvdzoNCj4gPiA+ID4gDQo+ID4gPiA+IENjOiBz
dGFibGVAa2VybmVsLm9yZw0KPiA+ID4gDQo+ID4gPiBXaGF0PyAgV2h5PyAgVGhhdCBzaG91bGQg
YmUgZmluZSwgZXhhY3RseSB3aGF0IGlzIHRoZSB3YXJuaW5nIHRoYXQgdGhpcw0KPiA+ID4gZ2l2
ZXM/ICBUaGF0IHNob3VsZCBiZSBmaW5lLCBhcyBpdCdzIHdoYXQgbXkgc2NyaXB0cyBwdXQgaW50
byBwYXRjaGVzDQo+ID4gPiB0aGF0IEkgY3JlYXRlIDopDQo+ID4gPiANCj4gPiANCj4gPiBUaGlz
IGlzIHdoYXQgY2hlY2twYXRjaCBjb21wbGFpbnM6DQo+ID4gDQo+ID4gV0FSTklORzpCQURfU1RB
QkxFX0FERFJFU1NfU1RZTEU6IEludmFsaWQgZW1haWwgZm9ybWF0IGZvciBzdGFibGU6ICdzdGFi
bGUgPHN0YWJsZUBrZXJuZWwub3JnPicsIHByZWZlciAnc3RhYmxlQGtlcm5lbC5vcmcnDQo+ID4g
IzIzOiANCj4gPiBDYzogc3RhYmxlIDxzdGFibGVAa2VybmVsLm9yZz4NCj4gPiANCj4gPiB0b3Rh
bDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDAgY2hlY2tzLCA3MiBsaW5lcyBjaGVja2VkDQo+IA0K
PiBVZ2gsIHRoYXQncyB3cm9uZywgd2hhdGV2ZXIgeW91IHdhbnQgdG8gZG8gaGVyZSBpcyBmaW5l
Lg0KPiANCj4gU29tZW9uZSBzaG91bGQgc2VuZCBhIHBhdGNoIGZvciBjaGVja3BhdGNoLi4uDQo+
IA0KDQpJIGluY2x1ZGVkIHRoZSBtYWludGFpbmVyIEpvZSBhbmQgRHdhaXBheWFuIGJhc2Ugb24g
dGhlIGJlbG93IHJlbGF0ZWQgY2hhbmdlOg0KZmNjYWViZjAwZTYwICgiY2hlY2twYXRjaDogaW1w
cm92ZSBlbWFpbCBwYXJzaW5nIikNCg0KU2VlbXMgY2hlY2twYXRjaCBkb2Vzbid0IGxpa2Ugc3Rh
YmxlIGFkZHJlc3MgdGhhdCBiZWdpbnMgd2l0aCBhIG5hbWU/DQpIb3BlZnVsbHkgdGhleSBjYW4g
aGVscCB0YWtlIGEgbG9vay4NCg0KVGhhbmtzLA0KVGhpbmg=

