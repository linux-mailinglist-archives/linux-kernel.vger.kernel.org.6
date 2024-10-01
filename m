Return-Path: <linux-kernel+bounces-345081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F5F98B1BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA2FB2229F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C879EAEB;
	Tue,  1 Oct 2024 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UgqYh0Ep";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lV877Nlj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="A0cwzx9u"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8D63C;
	Tue,  1 Oct 2024 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727745665; cv=fail; b=fnZVqEvoXJZPBoDjl+dJvfRZfauSvmbCDnc6BYQLWbAnInXmLVWGCk4EZXlWAppJcGQJlFfaNtIGEXW1tK3gjqr6YKX3YocGROwakmBXoQbqQugoOXS3IE4CrTy/3PxPMirBl0y/L8KaUJnaPybFsC41jtntZv/Zg5kWCuBw1ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727745665; c=relaxed/simple;
	bh=ByURc0B/boEh6bE2s9YjpWx8+Xf6kvwP/zc9oBO4E5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EL/CMAWpLjJF1U7Ow7k6JUEIEwVZ28wR3bMDc/3P8PFeZwWQU9ucLiLc8KQeMrKwEDL0r/G/KZZTANmLQR0m8R3vcia61uUmMupFeI4dKi+5wSa2xLLgIqx5vGQWDw7knGsmzFMtMdiK4dFV6/3ATxNQKVfw4qe3gC+YBZ5jj50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UgqYh0Ep; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lV877Nlj; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=A0cwzx9u reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4910TZsg027541;
	Mon, 30 Sep 2024 18:20:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ByURc0B/boEh6bE2s9YjpWx8+Xf6kvwP/zc9oBO4E5A=; b=
	UgqYh0EpI+2ageaUxC2p2l8Te2qa9JJllXo7pX3Sxsazrn4UoZzry54weG3cgraq
	0g4UweX/xmoZGu/dXCKaB6rUc/n12+zbf8FBgHmEgUeZl+moZ6cIq1sXRobzbdN9
	JT9COxk6ZWbksyl6Ta/Ogz2WcGpnfW/G+ADB08bJX3P9rUI56hTC/1boFDoHTQ0A
	LlaByQhe9G+eudqZxXIw4GqEEz95QlsohyO4ZGCbeF5ibEXPzs9mtgc4HYk4nZt1
	jpzvABvGsnnFaVwJoaPdzWs76SOODYeZQHX8hCxEIA+DvS64GWBSt+y4syiJSM3C
	Kkbjh8JR3Un//IsMtHsdSA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41ybr38d2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 18:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1727745637; bh=ByURc0B/boEh6bE2s9YjpWx8+Xf6kvwP/zc9oBO4E5A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=lV877NljOGIpldq4y06b6jtCQLBqwJjozKwwJrN1MZYxzifIp8KWgkr/z8BGokx0a
	 PXJpu/Y3futznebtq/b6TODHPwGywuSZvz+HQHRaLxpNTUvCszjQRFpvIFDfzuNoGq
	 COtrBDeX7RFcGovolKzlSP61ZrfQtlFCoGDL8bZ2GgmLYLU0FxaF4BPuJ1V1mVmP7r
	 ICy1cdyIYUsnZFOEEUczS/hWqC5Ojj1GicIakwbuxshcSo7fXj2vlvYT3W92m1g9ij
	 R9HCvmsv5HNbrPVVPU3v95lYQbWwaO9IhT4PrE/85X0wIUFnyYH2Lij4m8e9LA0W7i
	 q5NxD6wQO8jCg==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 056024011C;
	Tue,  1 Oct 2024 01:20:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 4113AA005E;
	Tue,  1 Oct 2024 01:20:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=A0cwzx9u;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8A68340120;
	Tue,  1 Oct 2024 01:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUSBuzqD7vWaxnz9TAs7KHT9uEILDKd8JZ4fP2TrBWc+7pr9z5LJrYg87Tf1TYIpJTib1k8IAlIU9HVlko+ZLxq+8xm7k7feqYF15j/viInb3gnTPLIwR/qmzi4arMc6Z3Bz20r/YFE8snQJtdCtJBL0EzW6mJH1HDf1daIpcmBSJIX75OGhLex7COsLatot3XAoaG7Dw/T76bkfrw2UOQw6akFFOXN30mr7I69hGgFx2BO8N13CDDydeVqPDpQNj6WFkGrRyQ5zw6cILTdhX46hanwEw1dx/Dt6ExJsJrGq5oOBd7sEKAN4DWAWKu2b77xIznT+htKwrQHLOU91ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByURc0B/boEh6bE2s9YjpWx8+Xf6kvwP/zc9oBO4E5A=;
 b=HYMx3Shm6EmtO96pwIz9E6v3rAXLSilULL+Y+idbpOTjYeR3xjJCw94QIpTUq1DqTw4rx4656oqSB5tmUPb3wo7tAyvXNq16C0h0XgmG2LK3N8phqs91hBZBe0d31/IYWKLS7RQLhbrKTaUaLcj242GUv7WGduOqG/ciq3gPS9Ge0XotzkagBt/Hw13t7EdB8rk7hygznOncBHfQA9RmgSLL2PVEK6NPcQnEBzKqX6vm4LaG0YDmcNqaFughhAIBrJLviyQs1+0JhcD60fUo+ZE+gNvaKIG0T3UV4eyjZLUFtswepkhbuOowKdiKz+ppRyqWdf5quPU2ia2iFDiiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByURc0B/boEh6bE2s9YjpWx8+Xf6kvwP/zc9oBO4E5A=;
 b=A0cwzx9uku7k/LKzvoNPEtNIV43HCtQYVI8C6ofx5BGUIMF6qZZUNqtoBjlkdw5DticqE4CKHVdKqMebfQmgkzfLJdWunQF7bZrAnluqqSp9A/CAf67j03Tu2KNi2Um4YRa4nD3f8SvJPLG5Gtt8kow4tQ0mhc4bpA26UsuYA1w=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 01:20:32 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 01:20:32 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Akash Kumar <quic_akakum@quicinc.com>
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
Subject: Re: [PATCH v5] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Topic: [PATCH v5] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Index: AQHbERgbhpllPryqekWvculkuFQOJrJxHgIA
Date: Tue, 1 Oct 2024 01:20:32 +0000
Message-ID: <20241001012028.eoxwugdaisj2uw2j@synopsys.com>
References: <20240927195931.10404-1-quic_akakum@quicinc.com>
In-Reply-To: <20240927195931.10404-1-quic_akakum@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ0PR12MB8091:EE_
x-ms-office365-filtering-correlation-id: 80d85f32-6804-4c11-2939-08dce1b73e69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ckJRNGFIZHhtYWdjenVNQktzamNCdWpaZm5ZQUp5M243eWFFbmZsTHNMMGFW?=
 =?utf-8?B?aHJpUmpxQmE0OVFBTE1LTlFHZDlIWXFnUUMwdXlKN1dCMzV4YVNaMjRudjQ0?=
 =?utf-8?B?NVZTSEp6akVjM2RBc3A3eFpySzh3T2V4MG9TZFZzd3EwU2Zka3MrQkl1UnRH?=
 =?utf-8?B?c3p1cE9JYWxxR3ovTkxLbXVmcnl2MG4yV3FhMEZUTzdZNTYreGZ0TjV4dDQ2?=
 =?utf-8?B?SDZEWDNHS1ZaN05KRGJMMFBKY3phV2pZd0dZVnEraUt4WnlibTI0RHVVZHEz?=
 =?utf-8?B?ZDNZWU9zeEtGT3BoOTJEWDhHSU5rYW1sY1RtRDcwck1jckU5SXVZMEdjdW56?=
 =?utf-8?B?VzdYbWhhWlJsdkhmYVZvMVZrMURMRmFiWkJvOW5mNHhRRlVkS0Vyb1cyTHAx?=
 =?utf-8?B?N3YzOG53ZlBOWUtzMlVlVi9EOE82TUxXaGgxaFZVMEFESUdWeW1xbHdYcWxZ?=
 =?utf-8?B?WE9FTC8ydXNtNlJQSzFIdlkzdjE0QXZkRERDam1KRjU1VjNyd3ZrM1gyWmVY?=
 =?utf-8?B?b3VTOHVKZWJKbU96c0hHMkkzN0Vya3BIckxCV2Q4aGxWRFpWR0tYcjFXdWJ0?=
 =?utf-8?B?VHhMSXNnUG1aYjJhSWpTemh1MTJna3hobi82cHM3UVBtK0QxR2NDdHNHZ1Ji?=
 =?utf-8?B?MGVLZkVWK2pyb1B5MWREZ00vcGVsa05SR1Z4UDVKMXBMU1BJSDh0REtSeFdQ?=
 =?utf-8?B?aUhVVUZUSXNhRkpLV3ZiOGtrVnlTOTl4Mnh1UjVaMzduWXo3RmVQbWs2ZWUz?=
 =?utf-8?B?My96ZnM1Y1k3Rk9zbHhYSFJzVXZBbkFHVXVlN0lXWEJ3R21BcDBJa2ZkNWZl?=
 =?utf-8?B?a0l1aTlnTUNBRmJQVTliV2hEdEJZSXYyRDA1ZXhnclIyT1dRaU1UNlROWEJQ?=
 =?utf-8?B?MkJoOWxjTk9oNVJ3Z25hbDU0aUpmcG1yTFlhSkJtYk5aM1NIUE41L3FvSEdz?=
 =?utf-8?B?WDByMkZVdWM3VGdMRTFUTHFiaVlrZHBpNUFyOGR3NHMyUWNIdWJ4d2dQRUla?=
 =?utf-8?B?UnNxSmtlYkNPOUEvdXA5TFNEOFMybDFhTWs5Y0ttbjlmdm9qRGxQR3h3K0sw?=
 =?utf-8?B?NlNzeGZobnhZcW9HU1QvY1NMSjRab0tNVllPYTBPNGthZllTbWJ1TlpHYXh3?=
 =?utf-8?B?dkNtamRGZEdHMEdBdm9pTUxrdlZzYi9IRU53VGVVWlNBZml0K3FDTHViMC8y?=
 =?utf-8?B?UElxcFFBcDBTaXFvakJ1Zi9jYWQ0RDVYTXRDc2g4SzhDL1ZUbnRNNE9GbTF2?=
 =?utf-8?B?OW04VDE1Z1AybkwwMUJZU1dVYXpOYTBhZkM1RXhBYUpKNTFkUFgwNFBLb1Ix?=
 =?utf-8?B?TWNIV3ZNTUhXTS9EUUZFSk90UWloSytqbG14bk9wQmlKVUdpTHdRNmZFbys3?=
 =?utf-8?B?MmNxOC9TSTJmSEJwL2NUZGtoZlVjd2Rwc2NmekgyMTliK2pxRUcrb3FibXNO?=
 =?utf-8?B?cFZTTnFPY3YxMFZXbGJjb3RyRmNvRVRhNWRJVWxEODY2d2tseGU0M0RMTEkz?=
 =?utf-8?B?M2xHeXBXZ3JUZlJwam1WVElNNVRrWlFNR016RUZURmlPTjkzWjVjYzZOYUc5?=
 =?utf-8?B?SlpoMUV6eHZjZzBZLzV1d3MyYXJPRnBIalVQdmhTVmRGT0lOZWN2STE1VkNl?=
 =?utf-8?B?WER3RFI2MHFhV25ocWF2L1YvUGlnMDIxZTlGTHUybDlwZUR6S09MVzBabTBO?=
 =?utf-8?B?cGYwellhRnIzMnBwbTh2QW54VFBHYjFwWVErb2paRHA3c2lQcGZBRGhnZ0wx?=
 =?utf-8?B?V1pzV0JJUEtBdW41R214U1g5MXFDWjMra0hNUFRLOWkwdk5lb083eDVRaS8z?=
 =?utf-8?B?dHQ3WGwrckZDK011bHhzZkFFQm5XbWRsR202UFgyRXA1TXJxQkJOYzdRMDhh?=
 =?utf-8?B?cGlBTHFHeE1sM3NmaUU1d0dBZFk1c0RPNnRnVVE5ZmVOcVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFNlekxzWXA2U0NvMHdnVVNZOHNKZkZqTUJHazhWMUJ6SE5hWHA4bHJONS9x?=
 =?utf-8?B?TlovL084SXc2QkNDcXRjOE9yTHlJNysxSVNsTjRwdGZzeXNUN1NLZ3VVSGE5?=
 =?utf-8?B?Q1pCSTdnSC9TWWU4Q2xqSjNyVjJGNVNrbVNrU3MvbDZ5dXJrVFVMVGQvSkFD?=
 =?utf-8?B?d1A3M2lmSkd5andHRmdqUzdOczNyODhCRnYxdHBWRDRSNElESTMyQVNYUDdo?=
 =?utf-8?B?ZVN6Wi82SGo3b3NVTDFwQjhjeDBmb1JDTzJkVTdFK1hyT3pVZVM2SEw5RTRI?=
 =?utf-8?B?aDZWSWJFRlRBZHl5UFl4OFFWUDltRExVSzBYQjZpT3ZDRGZaUk9oazYxcnQw?=
 =?utf-8?B?aXZpQm9iOTJNMGE2Sko3VE0vcUpPL25YQlFtNEtqRDVKUS9aMS9rcTg3TEwv?=
 =?utf-8?B?SEhoa1VYTGFINWYzRE1RaElLRnZyZWdhM3RQbzMrVHZ5cVBiUU5lZmxHZHh0?=
 =?utf-8?B?b0tLOHM3Z0kwS3MxVmJHVEhjTEpRU3pTWis1UWphTXNiOTJGMnhLWCtTbzJi?=
 =?utf-8?B?U0cvbU9pbjFra25FNVFLMzhablVMME10V2JaZ3grY2ZZNmZZN2RVY1h5Y3RO?=
 =?utf-8?B?WmJhQlhSYU9TZjBBWlA0bVhrUWUxS1RpMTIvQjVUNERya01NZjNGNkFHNWhn?=
 =?utf-8?B?cGsxckNmYUtGN1BPVUluSVBDeHZQak56eFdnOGlGcCs1TVJVblBEbGhNMUtE?=
 =?utf-8?B?NzViV2FJTEhPRDRWMC9XS2lMSFNyR1V2TEZrZVRob1hGRHE5cTQ2M3ovWDlZ?=
 =?utf-8?B?b3pxd25pL0E3TWdMbkZGdjUxa2IxVHM3cXVVYnZOb3JLSmdRaDJSQTE0YkNs?=
 =?utf-8?B?T2hIVW5LSmNJSzZDSDdSQnRGNk1lVm5MTURWRjduMEZNQUlrSGI1UDUvaEVw?=
 =?utf-8?B?Z2o0QXZZVHY5Ri90dzJYYmkyVEU3SnBGekwrU1pVNmFWZ3RyeStOcE9zVHcy?=
 =?utf-8?B?bmFiTk5BMEdlRVg4Um1hOHd5SDRGa0EzditBT0JvdWJCbjczZm1QK2xOV2Nv?=
 =?utf-8?B?Z3kxdzFlNXlld2orV3hUa3VuR2QzV2Y2WWg4QUgzM2s5WkJGM2ZTM1Q4c1Vw?=
 =?utf-8?B?VVJHZW10dWpMY2xvRExYbWMrT2NTV2EyVXJkdERqbWQxaEFVMGFxOWNubzJ2?=
 =?utf-8?B?S1NmbWx4TjBDUXhqdXZvSjF0TFQ3dE5IVzNZVVlXRDR1TlcxSXZJSDVrbTRV?=
 =?utf-8?B?cmVKUzM3WFRBNDlKa1pIYmZFNkgvVW1GT2NBWk5rUWlSM3VUbGpXVHJEcUN2?=
 =?utf-8?B?UHVnM3NvNUJ5NnNjdnRGcWtHaWI1UUIxODhTL09XTFlsRi82c2NUM2wxZDFi?=
 =?utf-8?B?Z0pabENvcEFGY2JPQ1BNM21WajNvdW54ak1DTHRKRzVicElROE5tMloydGZ3?=
 =?utf-8?B?YmYrbk1QanJwMXNxZUYvL0JjN3FxTzg2ZUFDc1pWUFRuTk9CZjlEZ2UvRUtG?=
 =?utf-8?B?ZDUzTXUyajA4YnZQQkl0eTgzMVhLSmRnT3hFVjVERWVVMWgyc01LeHBJYUYz?=
 =?utf-8?B?L1JXN21OT0lDa3ZEK3hHV1dRNFFYVVh2ZmtKWURNUGFoVWY2eEVtWHFpOGdq?=
 =?utf-8?B?NVV1SnFITFBsaUdqaUJ6V0lPNHViV25ySFFaOWlhNjI4OVI2WnF6RkM4Rytq?=
 =?utf-8?B?R3RBR1pQMXMyd05HMlFQYkVyOTdmbkdDbWdwMllDL1A2WWtiQUdXa05EYXo0?=
 =?utf-8?B?NlM1OGQ0d3BsUVdaSlQ1OFYvTFQzSXZrYzJjTFYxTGRMNncrRFlZd25sQXN2?=
 =?utf-8?B?UVVJblFiYXUzdEZrMmdZMzM1cVkvN2NURWJoRDFKS2thWkJ4WGxaNFJNVmpm?=
 =?utf-8?B?QmFtbnQramVURFEvVktDaWw5eWRBRGdJbHRFUUR2dlA4YVk5dXBsckhNVXVY?=
 =?utf-8?B?TnhWSFBHTC9FVFI0VDVCaWZZZ0llRExISDJGRmR4NlRYTzdnWXp3cEEyWWEr?=
 =?utf-8?B?TnRWOWROWTdCanVJYkZxVEdVaXFoQkF1SnRxRll3dlZodXRyR3g0eGhkRnoy?=
 =?utf-8?B?Q3lKRUNzUHpBbjBCM2ZKK1Rla0labDBiOWdQUHVQREhkMWtJcll6MVN4dksr?=
 =?utf-8?B?bG9sSE9mN0tESCt3eW5LWms1d0h5dzFwTHBPaStHZWQvUC9scEIvQWhsanAz?=
 =?utf-8?Q?ed+F36h9RPz40QMzwdjT8cy3d?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52637156ECFD2D478662702E04884DE2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dsyysAAvXGM+jm+FzwTbVZSNuxxebCAJ3GSni/UahqzqDzCwkLmMxav5Bbj21nSbrTvI2wHY8/ghBaWa1DmcYWfB5P0cVYaBgZnaDaWWe/8SXwEYxHhigEu+wCuUkVef+olBEDO9USzFI38Q0aYGX7QczRmh6TC/FUKvaxezm51qV10yur7u3H4XWHn51/uEMksiaHzRur8QXpfomxJQ0dNPMTzCTqL2mwrBdJJ7AwGzaCNMbvZws/12DOCWNDp4DdjjxS+nYN+7AkHOLbVq6A1iu7AukKSr85op4OhNOr1up22eLDzPgZXFXEJvU/pmgG0oR4bPnw67Q0c6nfVVjcUFGeH9XfQDIxspUvAhqEXW2FPHEcgPXrE6C913EwMsFhqiBUqda74fXJ0foJolBaUSgVv3OTB5P+3RHMiLKyrfPi0n6YRVKkOSzfdc0zmoBZo0QjrJ8M12z3FCzSOhEY2jjYX1uMw7iTUwZiOojpJAlPVWa9PdvnA7Lokn7zagCIHBBMK/3p9bqh3nTSt3mPY7Sf70MRjqn0DfX1rE6leRHQD50nRH0bOOR+E7vi9kH08IPa8ivSwk8AMkvrP5GEeRZgyyljL4+oiP5bzuxNSD/bZmfNpf1vrUOMN7JJ+HhKuef9rDvl5qnW/W9dYghA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d85f32-6804-4c11-2939-08dce1b73e69
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 01:20:32.1826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGOSQn8j/v67qEzm087tx4TS3jiU5m+Fwv8F9E1owM4M7cY1ZRDI6VlYRrafC38f9wovORdQcUhKEI2vgmG8QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091
X-Authority-Analysis: v=2.4 cv=NpODcNdJ c=1 sm=1 tr=0 ts=66fb4e75 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=COk6AnOGAAAA:8 a=Fw8nr6mc_DSmYoaB-Y0A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: J2ovTUvW9gsUi5DONKEQzaPQMqYuax2O
X-Proofpoint-GUID: J2ovTUvW9gsUi5DONKEQzaPQMqYuax2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 impostorscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010008

T24gU2F0LCBTZXAgMjgsIDIwMjQsIEFrYXNoIEt1bWFyIHdyb3RlOg0KPiBUaGUgY3VycmVudCBs
b2dpYyBpcyByaWdpZCwgc2V0dGluZyBudW1fZmlmb3MgdG8gZml4ZWQgdmFsdWVzLg0KPiAzIGZv
ciBhbnkgbWF4YnVyc3QgZ3JlYXRlciB0aGFuIDEuDQo+IHR4X2ZpZm9fcmVzaXplX21heF9udW0g
Zm9yIG1heGJ1cnN0IGdyZWF0ZXIgdGhhbiA2Lg0KPiBBZGRpdGlvbmFsbHksIGl0IGRpZCBub3Qg
ZGlmZmVyZW50aWF0ZSBtdWNoIGJldHdlZW4gYnVsayBhbmQNCj4gaXNvY2hyb25vdXMgdHJhbnNm
ZXJzLCBhcHBseWluZyBzaW1pbGFyIGxvZ2ljIHRvIGJvdGguDQo+IA0KPiBUaGUgdXBkYXRlZCBs
b2dpYyBpcyBtb3JlIGZsZXhpYmxlIGFuZCBzcGVjaWZpY2FsbHkgZGVzaWduZWQgdG8gbWVldA0K
PiB0aGUgdW5pcXVlIHJlcXVpcmVtZW50cyBvZiBib3RoIGJ1bGsgYW5kIGlzb2Nocm9ub3VzIHRy
YW5zZmVycy4gV2UNCj4gaGF2ZSBtYWRlIGV2ZXJ5IGVmZm9ydCB0byBzYXRpc2Z5IGFsbCBuZWVk
cyBhbmQgcmVxdWlyZW1lbnRzLA0KPiB2ZXJpZmllZCBvbiBvdXIgc3BlY2lmaWMgcGxhdGZvcm0g
YW5kIGFwcGxpY2F0aW9uLg0KPiANCj4gVGhlIHVwZGF0ZWQgbG9naWMgaXMgbW9yZSBmbGV4aWJs
ZSBhbmQgc3BlY2lmaWNhbGx5IGRlc2lnbmVkIHRvIG1lZXQNCj4gdGhlIHVuaXF1ZSByZXF1aXJl
bWVudHMgb2YgYm90aCBidWxrIGFuZCBpc29jaHJvbm91cyB0cmFuc2ZlcnMuIFdlDQo+IGhhdmUg
bWFkZSBldmVyeSBlZmZvcnQgdG8gc2F0aXNmeSBhbGwgbmVlZHMgYW5kIHJlcXVpcmVtZW50cywg
dmVyaWZpZWQNCj4gb24gb3VyIHNwZWNpZmljIHBsYXRmb3JtIGFuZCBhcHBsaWNhdGlvbi4NCg0K
V2FzIHRoZXJlIGEgY29weS1hbmQtcGFzdGUgaXNzdWUgd2l0aCB0aGUgYWJvdmUgcGFyYWdyYXBo
Pw0KDQo+IA0KPiBCdWxrIFRyYW5zZmVyczogRW5zdXJlcyB0aGF0IG51bV9maWZvcyBpcyBvcHRp
bWl6ZWQgYnkgY29uc2lkZXJpbmcgYm90aA0KPiB0aGUgbWF4YnVyc3QgYW5kIERUIHByb3BlcnR5
IHR4X2ZpZm9fcmVzaXplX21heF9udW0gZm9yIHN1cGVyIHNwZWVkIGFuZA0KPiBhYm92ZS4gRm9y
IGhpZ2gtc3BlZWQgYW5kIGJlbG93IGJ1bGsgZW5kcG9pbnRzLCBhIDJLIFR4RklGTyBhbGxvY2F0
aW9uDQo+IGlzIHVzZWQgdG8gbWVldCBlZmZpY2llbnQgZGF0YSB0cmFuc2ZlciBuZWVkcywgY29u
c2lkZXJpbmcNCj4gRklGTy1jb25zdHJhaW5lZCBwbGF0Zm9ybXMuDQo+IA0KPiBJc29jaHJvbm91
cyBUcmFuc2ZlcnM6IEVuc3VyZXMgdGhhdCBudW1fZmlmb3MgaXMgc3VmZmljaWVudCBieSBjb25z
aWRlcmluZw0KPiB0aGUgbWF4aW11bSBwYWNrZXQgbXVsdGlwbGllciBmb3IgSFMgYW5kIG1heGJ1
cnN0IGZvciBTUywgYWxvbmcgd2l0aCBhDQo+IGNvbnN0cmFpbnQgd2l0aCB0aGUgRFQgcHJvcGVy
dHkgdHhfZmlmb19yZXNpemVfbWF4X251bS4NCj4gDQo+IFRoaXMgY2hhbmdlIGFpbXMgdG8gb3B0
aW1pemUgdGhlIGFsbG9jYXRpb24gb2YgVHggRklGT3MgZm9yIGJvdGggYnVsaw0KPiBhbmQgaXNv
Y2hyb25vdXMgZW5kcG9pbnRzLCBwb3RlbnRpYWxseSBpbXByb3ZpbmcgZGF0YSB0cmFuc2ZlciBl
ZmZpY2llbmN5DQo+IGFuZCBvdmVyYWxsIHBlcmZvcm1hbmNlLiBJdCBhbHNvIGVuaGFuY2VzIHN1
cHBvcnQgZm9yIGFsbCB1c2UgY2FzZXMsDQo+IHdoaWNoIGNhbiBiZSB0d2Vha2VkIHdpdGggRFQg
cGFyYW1ldGVycyBhbmQgdGhlIGVuZHBvaW504oCZcyBtYXhidXJzdCBhbmQNCj4gbWF4cGFja2V0
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWthc2ggS3VtYXIgPHF1aWNfYWtha3VtQHF1aWNpbmMu
Y29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBmb3IgdjU6DQo+IFVwZGF0ZSBDYWxjdWxhdGlvbiBmb3Ig
SFMgYW5kIGJlbG93IGJ1bGsgYW5kIGlzb2MgZXBzIGJhc2VkIG9uDQo+IHN1Z2dlc3Rpb24gYW5k
IGZpeGVkIGF0IDJrIGZvciBidWxrIGVwcyBjb25zaWRlcmluZyBmaWZvDQo+IGNvbnN0cmFpbmVk
IHBsYXRmb3Jtcy4NCj4gDQo+IENoYW5nZXMgZm9yIHY0Og0KPiBVcGRhdGVkIGNvbW1pdCBtZXNz
YWdlIGFzIHBlciByZXZpZXcgY29tbWVudHMgdG8gY2xhcmlmeSB0aGF0IGl0IGhhcw0KPiBiZWVu
IHRlc3RlZCBvbiBzcGVjaWZpYyBwbGF0Zm9ybXMgb25seSBhbmQgdHJpZWQgYmVzdCB0byBtYXRj
aCBhbGwNCj4gZXhwZWN0YXRpb25zLg0KPiANCj4gQ2hhbmdlcyBmb3IgdjM6DQo+IFJlZGVmaW5l
IGxvZ2ljIGZvciByZXNpemluZyB0eCBmaWZvcyxhZGRlZCBjaGVjayBiYXNlZCBvbiAgb3BlcmF0
aW5nDQo+IHNwZWVkIGFuZCB1c2VkIG1heHAgZm9yIEhTIGFuZCBtYXhidXJzdCBmb3IgU1MgIGFu
ZCBkZWZpbmVkIG1heA0KPiBhbGxvY2F0aW9uIGJhc2VkIG9uIGR0IHByb3BlcnR5Lg0KPiANCj4g
Q2hhbmdlcyBmb3IgdjI6DQo+IFJlZGVmaW5lIGxvZ2ljIGZvciByZXNpemluZyB0eCBmaWZvcywg
aGFuZGxlZCBmaWZvIGJhc2VkIG9uICBtaW5pbXVtDQo+IG9mIG1heHAgYW5kIG1heGJ1cnRzLg0K
PiANCj4gQ2hhbmdlcyBmb3IgdjE6DQo+IEFkZGVkIGFkZGl0aW9uYWwgY29uZGl0aW9uIHRvIGFs
bG9jYXRlIHR4IGZpZm8gZm9yIGhzIGlzb2MgIGVwcywNCj4ga2VlcGluZyB0aGUgb3RoZXIgcmVz
aXplIGxvZ2ljIHNhbWUuDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDIw
ICsrKysrKysrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCAyOTFiYzU0OTkzNWIu
LjAzNWQ0OTE1NWQ1NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0K
PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC03NzEsMTUgKzc3MSwyMSBA
QCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3Jlc2l6ZV90eF9maWZvcyhzdHJ1Y3QgZHdjM19lcCAq
ZGVwKQ0KPiAgDQo+ICAJcmFtMV9kZXB0aCA9IERXQzNfUkFNMV9ERVBUSChkd2MtPmh3cGFyYW1z
Lmh3cGFyYW1zNyk7DQo+ICANCj4gLQlpZiAoKGRlcC0+ZW5kcG9pbnQubWF4YnVyc3QgPiAxICYm
DQo+IC0JICAgICB1c2JfZW5kcG9pbnRfeGZlcl9idWxrKGRlcC0+ZW5kcG9pbnQuZGVzYykpIHx8
DQo+IC0JICAgIHVzYl9lbmRwb2ludF94ZmVyX2lzb2MoZGVwLT5lbmRwb2ludC5kZXNjKSkNCj4g
LQkJbnVtX2ZpZm9zID0gMzsNCj4gKwlpZiAoZHdjLT5nYWRnZXQtPnNwZWVkIDw9IFVTQl9TUEVF
RF9ISUdIKSB7DQo+ICsJCWlmICh1c2JfZW5kcG9pbnRfeGZlcl9idWxrKGRlcC0+ZW5kcG9pbnQu
ZGVzYykpDQo+ICsJCQludW1fZmlmb3MgPSAyOw0KPiArCQlpZiAodXNiX2VuZHBvaW50X3hmZXJf
aXNvYyhkZXAtPmVuZHBvaW50LmRlc2MpKQ0KPiArCQkJbnVtX2ZpZm9zID0gbWluX3QodW5zaWdu
ZWQgaW50LA0KPiArCQkJCQkgIHVzYl9lbmRwb2ludF9tYXhwX211bHQoZGVwLT5lbmRwb2ludC5k
ZXNjKSArIDEsDQo+ICsJCQkJCSAgZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhfbnVtKTsNCj4gKwl9
DQo+ICANCj4gLQlpZiAoZGVwLT5lbmRwb2ludC5tYXhidXJzdCA+IDYgJiYNCj4gKwlpZiAoZHdj
LT5nYWRnZXQtPnNwZWVkID4gVVNCX1NQRUVEX0hJR0ggJiYNCj4gIAkgICAgKHVzYl9lbmRwb2lu
dF94ZmVyX2J1bGsoZGVwLT5lbmRwb2ludC5kZXNjKSB8fA0KPiAtCSAgICAgdXNiX2VuZHBvaW50
X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50LmRlc2MpKSAmJiBEV0MzX0lQX0lTKERXQzMxKSkNCj4g
LQkJbnVtX2ZpZm9zID0gZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhfbnVtOw0KPiArCSAgICAgdXNi
X2VuZHBvaW50X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50LmRlc2MpKSkNCj4gKwkJbnVtX2ZpZm9z
ID0gbWluX3QodW5zaWduZWQgaW50LA0KPiArCQkJCSAgZGVwLT5lbmRwb2ludC5tYXhidXJzdCwN
Cj4gKwkJCQkgIGR3Yy0+dHhfZmlmb19yZXNpemVfbWF4X251bSk7DQo+ICANCg0KRG8geW91IGhh
dmUgYSBkZWZhdWx0IHZhbHVlIGZvciBvdGhlciBlbmRwb2ludHM/DQoNClBlcmhhcHMgd2UgY2Fu
IGRvIHNvbWV0aGluZyBsaWtlIHRoaXM/IFdoYXQgZG8geW91IHRoaW5rPw0KDQoJbnVtX2ZpZm9z
ID0gMTsNCg0KCXN3aXRjaCAoZHdjLT5nYWRnZXQtPnNwZWVkKSB7DQoJY2FzZSBVU0JfU1BFRURf
U1VQRVJfUExVUzoNCgljYXNlIFVTQl9TUEVFRF9TVVBFUjoNCgkJaWYgKHVzYl9lbmRwb2ludF94
ZmVyX2J1bGsoZGVwLT5lbmRwb2ludC5kZXNjKSB8fA0KCQkgICAgdXNiX2VuZHBvaW50X3hmZXJf
aXNvYyhkZXAtPmVuZHBvaW50LmRlc2MpKQ0KCQkJbnVtX2ZpZm9zID0gbWluX3QodW5zaWduZWQg
aW50LA0KCQkJCQkgIGRlcC0+ZW5kcG9pbnQubWF4YnVyc3QsDQoJCQkJCSAgZHdjLT50eF9maWZv
X3Jlc2l6ZV9tYXhfbnVtKTsNCgkJYnJlYWs7DQoJY2FzZSBVU0JfU1BFRURfSElHSDoNCgkJaWYg
KHVzYl9lbmRwb2ludF94ZmVyX2lzb2MoZGVwLT5lbmRwb2ludC5kZXNjKSkgew0KCQkJbnVtX2Zp
Zm9zID0gbWluX3QodW5zaWduZWQgaW50LA0KCQkJCQkgIHVzYl9lbmRwb2ludF9tYXhwX211bHQo
ZGVwLT5lbmRwb2ludC5kZXNjKSArIDEsDQoJCQkJCSAgZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhf
bnVtKTsNCgkJCWJyZWFrOw0KCQl9DQoJCWZhbGx0aHJvdWdoOw0KCWNhc2UgVVNCX1NQRUVEX0ZV
TEw6DQoJCWlmICh1c2JfZW5kcG9pbnRfeGZlcl9idWxrKGRlcC0+ZW5kcG9pbnQuZGVzYykpDQoJ
CQludW1fZmlmb3MgPSAyOw0KCQlicmVhazsNCglkZWZhdWx0Og0KCQlicmVhazsNCgl9DQoNClRo
YW5rcywNClRoaW5oDQoNCj4gIAkvKiBGSUZPIHNpemUgZm9yIGEgc2luZ2xlIGJ1ZmZlciAqLw0K
PiAgCWZpZm8gPSBkd2MzX2dhZGdldF9jYWxjX3R4X2ZpZm9fc2l6ZShkd2MsIDEpOw0KPiAtLSAN
Cj4gMi4xNy4xDQo+IA==

