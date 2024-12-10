Return-Path: <linux-kernel+bounces-440482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E4D9EBEBE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C45318823D2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2505211260;
	Tue, 10 Dec 2024 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="g0XZT2Xg";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="im76p6NN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="buSkZ3Jw"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7C62451EF;
	Tue, 10 Dec 2024 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871555; cv=fail; b=ZVgcF5KzPc/dORV917swBrbIcitSp/7EDLtO2fDZwRhqf6XNakyxoz4W3dpIb/9UrMu31nfqQb1DJantacUoKi0twSQQ2MVnbT/0H5UxV5EdqR1OZnNh18mr03gckK4UIvCV6VW4XsYxadzBeCvruJp8a89UBSctBAjl7fZ3kAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871555; c=relaxed/simple;
	bh=WadwK5BjLuerjhetWtxKWac7AdkFgK2mdIT+0GwFUPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Se8Qs5Fcv2fskoNTlDVlSy9w8E0ZfGnEEZSMsjBXbQmleRRh9RBDx4BNlAsMWs0TeiVKi81dwthOK8Eis37+A5oVQtUzklq9YAoPLCYbfHxyxkPHRS+aQAUuicoBJI1tvNZcJutkrWgeu3ReHHzwGMVsTHtfh5S61v+mr1eDq+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=g0XZT2Xg; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=im76p6NN; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=buSkZ3Jw reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAM2nfv017323;
	Tue, 10 Dec 2024 14:58:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=WadwK5BjLuerjhetWtxKWac7AdkFgK2mdIT+0GwFUPA=; b=
	g0XZT2XghtjwrqYLxopDuNGb5Wisy0/e8XrOgyM1RgzSHqSm62A+feUsXb6lpQJl
	jriYijUIhRY08p56PzHyfz1IhibAlZaXjfyDhV+r4BFgi7PopL6UtEccsVDmRVkt
	duE7IjFoU9AQmO2s2ws7seqwViTSV4PCbv04WcEx5p392hf4OljBFzkUWhBQrAiU
	4TIyXyDzo2kRVfJE/M6fI8mTpPL1RuLUWnUUNvh+fwkfblIru2a+5erxSYqyDA5W
	xGVc2d0hC3q6CrsrRjeNrFAfSSSHxj6f9pVoN0LiIX5YGI9n9lSUc8xao2u3IpeK
	kJWCuPprZAIJmyBDx/oiRQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 43cp60sm6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 14:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733871530; bh=WadwK5BjLuerjhetWtxKWac7AdkFgK2mdIT+0GwFUPA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=im76p6NN6fMafhHpHyV6nfCB/CvMj5V6psTpky5rPe43iRjUNIH7/EVQJJ3K03rdq
	 oZfEpQE8K+qaL2df+NMKM/uen1gAAxGP7JuWnu6vdG1sbyPP2MP5NKGmv/YYRyA5PX
	 S/0YAA9Otw8M+uY6u7hO51BEXF1swfCEDsee/tjzNVu7ijnfChoodj1Gv83N1N8kNP
	 Xucz04DXCprz7mrKfAsY03rpL4Sk6rhfGkV0vLdsOBLJt6le5J8qu9aNVMo9FZpcbv
	 Qiu6tMswNR0FMVOUYl+tek9RyQxJLxmK+SixjEG6l6snoMhkRrV6ebX00NgsJllweB
	 UUTexvTMAM4jA==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 13CD440112;
	Tue, 10 Dec 2024 22:58:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A00DBA0092;
	Tue, 10 Dec 2024 22:58:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=buSkZ3Jw;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E113D4052F;
	Tue, 10 Dec 2024 22:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeKgkNIDw+mxhOLFwai7yrclqepwa3qX047n+2jmhSrStRUdRIDaIe9IO9hJ46FhbLxyFmbvxQ6Xxsx5j+ySjnLPpYUH3EyFv1Xm2WfsVr9rIHai0nvDURIMYUNhTvs8j8OOwZHn3PvjZOaTN6D93Gg6P4H8kC/BXyQpGXOj0Veo6c+VuBmRqcLGBjjSv2dAYz2+38qw+GZqkuob5d87OcjOUlUiSTmN8i55kvqXNJqfk/JMJjDnFVWf72Hd6HMX+cLkJPvc51mTO6Tjset5BJiegAwA4lX3fOPXd6LUD+QvHxNIHlQ+J/6FVojxuQBqkezSKuPqC+my6j0+itqRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WadwK5BjLuerjhetWtxKWac7AdkFgK2mdIT+0GwFUPA=;
 b=K37pjiPOvpcwl37KkFFN8m9trolup5gEiTwwLVTUVG11Vass2xLF0WVQ82Q6m0HJI6xJ8La02TUJhgbuHvGLugn4M4V+4jfD0hy9aG4Z9Z4Bb4/XpkjXDYzemgcGG9hlF8ci1XBnotBIuA169hXOy1KmLwvbAg8hddrE5cHBFUsYVNAmvrlNJIvujSCvJwoXEQ/yzh7edjUdZ42qLSNlq98vCI0GpQSlO2Qxac3OYhzhZfFn2gHbu9L+nFlRXGVl/r4rZEyVUEmfFs83nrzYD9l/sLLq3MYMM+NT340jTuJZ+IvMGJwdCCKj7NzpYQb9q76SfKU7Wq/h6mGaZLiMRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WadwK5BjLuerjhetWtxKWac7AdkFgK2mdIT+0GwFUPA=;
 b=buSkZ3JwhfzpGwOCiOdzbaPdA5s2y61hjsif1mmicA1YARVMFekO/F0WZIb5yiTOK/oB6Q6IJSO2wc5SkxeA28xoVIAuEXl6bYFiZXsBA2fSvG3PGR59qSTybyvFfx607XoifXE5+AIrv+iLVF5HgNb3xHf4OAT62BwMVHppj5U=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 22:58:44 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 22:58:44 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, "srk@ti.com" <srk@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: dwc3-am62: Re-initialize controller if lost
 power in PM suspend
Thread-Topic: [PATCH v2] usb: dwc3: dwc3-am62: Re-initialize controller if
 lost power in PM suspend
Thread-Index: AQHbSkB43R0mNCt0+EyHxw6Of5Nf3bLgGZoA
Date: Tue, 10 Dec 2024 22:58:44 +0000
Message-ID: <20241210225840.r22ds7g3rt4zelnq@synopsys.com>
References: <20241209-am62-dwc3-io-ddr-v2-1-da320392b509@kernel.org>
In-Reply-To: <20241209-am62-dwc3-io-ddr-v2-1-da320392b509@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW3PR12MB4345:EE_
x-ms-office365-filtering-correlation-id: b77d1462-6e84-4417-c479-08dd196e32ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWlrWHdBVHFSNEF2clFFUWoySThFQ0Nya2xGUU92djdCQWFqUzZabTg0UFht?=
 =?utf-8?B?RGRhTUpKMjNoN1pzVVVrbktyS1ptOTV2Z0ZmVVMvM1pSeTNPU05oRkVZbnNq?=
 =?utf-8?B?RkZiTWhLSVZUYVcwUHYvRjdyUW13Y2ovaVpmR2lBb0p6ZGcrWnNXUytJSnhZ?=
 =?utf-8?B?R3orbVkxMDBRMWNYUUtJWDErbXFrcEhYMkdab3NNSk1LWHFzMnBHRVF5dTNh?=
 =?utf-8?B?RVVpcG91eGdzYm9pZEFQU1hLWHJSdW1kTmlUM0FvaEd4UmpuMXhpSkRKMzlS?=
 =?utf-8?B?aXVxdFl2RFFBZ25RYVJXMWVNVmZHbGlxNkJpS3RwUVM5c2RoS0V2aWhHS2p3?=
 =?utf-8?B?NGVoci9LdzdxS0pXZHlaNnp1Z1E4eHJMVzFSNWtqZ2ZKQVpvY0FPQzBxdjF6?=
 =?utf-8?B?M2R3S1BrVk1ZaUcva1lGeGdDcTZCb1F4UUQ3ZGo4YjJOYVNzOXJsWXBNZzlm?=
 =?utf-8?B?Mk9YNTFBaVpqdjNXRHgyUVpHaWo3N2tpcytaUXNZUjRCRjRQZGZjbmdpSnNY?=
 =?utf-8?B?MVBXWlVicGNFN0lvaDJWWllvWjdwUDRHMm0vQjVjdW5FZjlTQUJjM0NHREw5?=
 =?utf-8?B?QUhScXhwQURRWDlpUWhNOS81RW5zbWczVE4rblV2aERBQUdZc09XNnhuSXd3?=
 =?utf-8?B?bjA3YnI3SUFQMGJXOXFwK1VObWhJVnJCWjFEUjYyRlNqclFpTWo5NllhWjA3?=
 =?utf-8?B?dHoyV0I4eldSQ1hWL1YxSFZBWHlOalBja3hzM080U2VucVZFRi9iQWE0aDZ3?=
 =?utf-8?B?amhTVnlQdWc3NExmakM3UnJHQlFHNk1hRy9mYVEzbzN0MEw2Y1dmUTFQcVdt?=
 =?utf-8?B?V2ZhRkRJeTBOVE9kTkpBNTJZaEhqU3BvY1lHSXhhcHExSmgrRGkxeE5iVEFH?=
 =?utf-8?B?cTA0RGhrVkU1Ykh2emxxaFJPaGQxQ0Q2U1I5ZnprK1JTTHppb0NMTmZkVEtY?=
 =?utf-8?B?akJBdzBzR3BlQmZkdVNlNUc1NjhJZTdjM1lLR01mUW9tMmFCN3BlV1ExUXFV?=
 =?utf-8?B?OVh4Szk4cm9vd0FENTdYS1NTYmE4SEZMZ0tvVkVaVmRDeGcwR2Y2RGpFRnQ2?=
 =?utf-8?B?TGh4NGFlcHZrQnZCb3FzR3prbXNvdTNyYUdCSjJ1Z1l3NDA5T0Y5cURacnd1?=
 =?utf-8?B?VzFFYXRzY3FjQUxZemU2TStDZ1B4SkpnQTFNWXFhTTJYMGVEbUVKL0hGM0Jy?=
 =?utf-8?B?aUE5cHZvQzBpTWpIa1JZdkRrSXNJd0NrTVJmc1Ezc29NRng1QUNQei9rVm5X?=
 =?utf-8?B?M0dpTHNZMTBNM0xDdlZzOW9QSkVSR1lFYkw5SFNyYWc0UEZFV0NKZ3dMQ0p3?=
 =?utf-8?B?b1RpNmpkeXArczZoaVdXd0c3dWRGdUpHcnB0MkNmR1lJMzlraFI4Tzl1WjRC?=
 =?utf-8?B?QWthMFE0Y0RFc0RrUVRSQjUzSUdWazFOZDFnTXZEVzNqdi8zV2VHOXg5SGht?=
 =?utf-8?B?MFVCR0gzTk54eW1OMHFYc1RMM09zbE5sMnBYMWxnbXFvdFpuclBreUdlRHY5?=
 =?utf-8?B?OW1VTUpkdk80K3liTzZpUDdPdkxoeVpzK0gwZ3BlWFgrYnUrRHBmaWdYQ0hG?=
 =?utf-8?B?ZTVLUjZkMHB6ZmpIVTJENmxHbkUrQkZOWjE4YzM0NitieERXb1hkS2JCeFB4?=
 =?utf-8?B?YWlZZGJJanVhZDl2KzZZM2VsK1VhYW4wRWxLM2EzVWlGYTBZN0xyc1ZqMVh1?=
 =?utf-8?B?OE9vaFdMOHFmM3krdGQ0Zjg4Y3JnbjJ5RHh4dk5yaEdvYlAvRTR4YmxTbm5F?=
 =?utf-8?B?WXgvc1ZDa1NNeGFxWkk3RVhWUG5pOThlYjY0ZWhIVjRRN1hmby9mcGNJZ1hP?=
 =?utf-8?B?OHNIZkdhR041Si9pbUplUVZyTFBSamszQUp1cnpQS2luVmkvaEZlQ2tDOFp6?=
 =?utf-8?B?cFVmdnJVN01yZGxLbkNVQUp3b21TZ0l6aTVTTzNraGZTb1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWwrcFo0WVkwQnpTN0h6QVFCZTIxQTExeXY1dmpRRSs0TVBCZUxpT29vL284?=
 =?utf-8?B?VDRVOG1pUDFTb1o2QnZsZ2dCTzNqaXpXb1pYWjd2bDFqK0U3OXNSYXFML0kw?=
 =?utf-8?B?RzRKQzdXZGVHb1Bxa0l2SysvekR1Sk92MmJRR1NtV3JVZlZjWEhoQTNJalYv?=
 =?utf-8?B?cFpOaXY2RjQ2VFJLVmpXa0NVTmJuNDBJR2poR1h2aGFwbVE0azBsbGVQdDE5?=
 =?utf-8?B?dE5abER3TkczSmpZclNGRnBVdjRoT0U4dkRQUXhlMFdjOGk0Ymc5ZS93cDcr?=
 =?utf-8?B?VmY3SVBvZkE1TTBpL0wyWXJ3N3ZDNndML3hWMjExUXU1ZzZjM2FoeXFuUkNi?=
 =?utf-8?B?RTZuUFEwTS9BNkJpd0hqQkI2YzFUR1gxa2N1a3Nya2M0K3c4Vm1KRUpiYzIz?=
 =?utf-8?B?KzdBSDBkVTd0UVJtZFdESngrelhmTlM2M0tNRkRPVWg2SWFVVU0vOWdISVlz?=
 =?utf-8?B?T3ZRcEd0TmxwOVFjVCt0cHh0QlJtMXdkU3J3NXlJMSswbDBLUEdObjhnNjAr?=
 =?utf-8?B?QjY3UmtRVVZRQmV2UEQwcUlFblBpcm9IeUp6YVJQLythaDVwSy9JRjFMclhp?=
 =?utf-8?B?WDFndHRhaG9vNGFyRzBYMkd3dDJUQWdGeDlkV3k0cVROTTJZUm1IeEpkQTY3?=
 =?utf-8?B?MHJnNWZsTDdGT1lmaVhGWTE4YTV0U3ZJRFZDZW9udGNYc21vWER2ZG1kRUVs?=
 =?utf-8?B?L2tPY1BiMnlkd3MyTEtxK1htbnZHZ3FHR3BxYWZQRk81d3lHS3NweUsvMGdH?=
 =?utf-8?B?M0l0eHlyWUx3WFhpZ0hUL01adU44eERLZ01vZGdwd1JFQjBLaHNkcTdVdlZJ?=
 =?utf-8?B?RU1mTFRVb0VGeDNwUVZMWmxJZUFXbnlYUCs2cTU3MCt5cXRLa3EybGRnOUxW?=
 =?utf-8?B?NFFYNExyWTRNQ2xwbFZrUTJWTU1FM1hxcGdNK1hKajUxY0p6c1RyUzRBSmJ5?=
 =?utf-8?B?eDhYL2Erb29mNmNQbjlYZUo0YTJiWlBUekNuVXNuQ2J1UHpzQjhhejY2VjRn?=
 =?utf-8?B?VU0zWkNHNG9LT3QxNExUUHV2NDlKbkd4R2EvRTNKK3JpSXc2MzdBVGp6elhv?=
 =?utf-8?B?YS9TWGJBbFlRRU8yL3JXc2lla2U3VnRkcytOV0R0dC9rNk8xblc5R1BaQ0Ji?=
 =?utf-8?B?ZTM3NlZBWEJmejZISWFZclk1czFsb3lDeTZvSExGbkZuanhwOXBjUVd4dWl6?=
 =?utf-8?B?Q2xPbmEvUkNXRUhxdlROeWlVVUt5dlFuNHVwMUJUeG1DYjE1bktjdXVKU3JJ?=
 =?utf-8?B?T1kxTkZHWVZHQXhuaHFtMXJsUDBhQ2FHUnBuZlFXUUlVa1lxSlJxb21hYklx?=
 =?utf-8?B?MjdPZmpTNlhNcHd6M1l6VThXdjNaeG1idDQxN2lnRXNkeStWZ1M2Mk1NaGJB?=
 =?utf-8?B?Y0V4cnZldkNITFVVWjBnemRWMFpTbDlqb2tMUmtOaXJ0SjU0T1ErYkNGTnk5?=
 =?utf-8?B?Mk5xUU1oVHBBQXRyNHpwMXg4R282K3kzS25WQ2puRHYyMndYY3l2SU1xbDZP?=
 =?utf-8?B?OXN3Q0pGa3JJa1pQMHA4QjIwS0psN2F3YjBCSi91U1hlcEQycEhaL0owdHpx?=
 =?utf-8?B?SkoxSnNuSTN3VTFjM0ttZ2ZEK0NjWGlmamd1V0dtQnY1dkFQbUN3MGExTEJ0?=
 =?utf-8?B?ZGRJbmllMm1XUUtmS1BTTS9DWXhGVXpaaU1qNVdjVGxvM0pjU2E2ZjduemJR?=
 =?utf-8?B?c0JKQnF0MGtZL2JkeFpxM1pvd2lRankzKzVvbDFLd0g1cVZpYXJMaFNja0Z1?=
 =?utf-8?B?dWR6TVlRV2FMUStyVElYY1dzMWV1OWttNUkzM3hMcGY0SXRPNW5RcVhaMUJY?=
 =?utf-8?B?U0hzcVFhSkE0N0dRRm0rQm92RUxwOG5VYWZuaEhKelVSU2dtUmRoOElWbU41?=
 =?utf-8?B?VExWcVpBdi9KV0w5cDFsR1VIY0thcE9CaE1ZOW1hWEhLdFd2RGUxQUwwUUcy?=
 =?utf-8?B?V0dwNnJBOWQwdGI2VmFDQVY2V1h3algrTTRBRGxzT2JlNVdpaW53R3U4a2Q2?=
 =?utf-8?B?UjVvVFYwTG1IaTZTUzNaYkswakRua0kyL0NSeXVwK0FydUllWmtBUkpaUTNG?=
 =?utf-8?B?ZDVLcjBxWGIvakZaQnZBUXBrSGpKTEVhdTZGMnVSQ1VBQS9GeUVQSXgrWm9a?=
 =?utf-8?Q?SAskweUVL/pb1xkjqmUX4PEOr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <586013E0A1AB904DA736C924707FB24E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qi/26OL0CSngF1O22HWFWD4cnMMn4ovwIKXjC8VzeTsk6IS+1Bosk725EIPK1DvKs/IgHhXZ8GYESW/dsxPh7JEAhqx/slmnLqJ0PJDYVoL9zAfpoVzs4FiA7sWAukQpX8sULU+5Tp9TmGRt9/WLgyr8qjiflK3287IAH8p6kodgPbfw1hztefQIF5YN3DLQu1/u9YUQDfFxnu1qkuDS2HcZWhJf1KO3L4S8VDRGAB2W3oqc3DuSOOiP4sg6+w155ui6oWNLt3D1QP6AvqCPgcll4MAS6J09yzd+eFGRXXDNULwFbiMcYiWRjzCG0yTVqVNvaQNLi4lvbEOjY14rxngAzhC3eI4Ae5NqRX7e/4cLcMGit7il9NYTX3GSapj1UVfpXcPUgYZdSueunf8XdwOIhrUIIEqVopeVK/pza8gnWD/LkvWYF/clSmTjcpPPDgEfxABeYsUymcRftrlLjkChD3Aw6a7PiCTGhQY45eVUZFqdU1WNPgIb1LIeO3AQRDrJNTP3hGBtTeAXDTx9aUOX3jC/yZtRdA8n5c70zLam0yoAzrADMogrmfW4rr116qgOu6NKEbGUDyKR7CLMKkzufTuFkSe0YSdBhIyPSICRRaV9DbyTzPnZHQ5u6FOHtWXJ3WcEO+8w+DhEJkNNIg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77d1462-6e84-4417-c479-08dd196e32ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 22:58:44.3579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hwspGK1o+W03hXdyVg+fLz0RYjHsRzg1YeWhI+XOxSKcSbdVs0o5HO6YnccH4Klo/6AXJ9weZWJAEIpNCIsWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
X-Authority-Analysis: v=2.4 cv=Z9YWHGRA c=1 sm=1 tr=0 ts=6758c7ab cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=KKNhQcjnE_LWeCCJ4WYA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: DpfC30jfCskZKXHWU8hV3orkgiY2DuyD
X-Proofpoint-GUID: DpfC30jfCskZKXHWU8hV3orkgiY2DuyD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412100164

T24gTW9uLCBEZWMgMDksIDIwMjQsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IElmIGNvbnRyb2xs
ZXIgbG9vc2VzIHBvd2VyIGR1cmluZyBQTSBzdXNwZW5kIHRoZW4gcmUtaW5pdGlhbGl6ZQ0KPiBp
dC4gV2UgdXNlIHRoZSBERUJVR19DRkcgcmVnaXN0ZXIgdG8gdHJhY2sgaWYgY29udHJvbGxlciBs
b3N0IHBvd2VyDQo+IG9yIHdhcyByZXNldCBpbiBQTSBzdXNwZW5kLg0KPiANCj4gTW92ZSBhbGwg
aW5pdGlhbGl6YXRpb24gY29kZSBpbnRvIGR3YzNfdGlfaW5pdCgpIHNvIGl0IGNhbiBiZSByZS11
c2VkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUm9nZXIgUXVhZHJvcyA8cm9nZXJxQGtlcm5lbC5v
cmc+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIGZpeGVkIG1hY3JvIFVTQlNTX0RFQlVH
X0NGR19PRkYgdG8gMA0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMv
X19odHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQxMTIyLWFtNjItZHdjMy1pby1kZHItdjEt
MS1jYzQ5NTY0NDk0MjBAa2VybmVsLm9yZ19fOyEhQTRGMlI5R19wZyFmUWxmRTh0bG1MVzU5WUJo
c3dabmZPU2ZfenlwR1JjcVdWMzEyQjVBME5GMHJMYU9GUHZUa1dhUHpDb0twejlFLTJpaWhYcFI4
N2ZGVHJmdWJiLXYkIA0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMgfCA4
MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3
YzMtYW02Mi5jDQo+IGluZGV4IDVlM2QxNzQxNzAxZi4uN2VlZjk0NWIxZjg5IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtYW02Mi5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvZHdjMy1hbTYyLmMNCj4gQEAgLTEwOCw2ICsxMDgsOSBAQA0KPiAgDQo+ICAjZGVmaW5lIERX
QzNfQU02Ml9BVVRPU1VTUEVORF9ERUxBWQkxMDANCj4gIA0KPiArI2RlZmluZSBVU0JTU19ERUJV
R19DRkdfT0ZGCQkweDANCj4gKyNkZWZpbmUgVVNCU1NfREVCVUdfQ0ZHX0RJU0FCTEVECTB4Nw0K
PiArDQo+ICBzdHJ1Y3QgZHdjM19hbTYyIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ICAJ
dm9pZCBfX2lvbWVtICp1c2JzczsNCj4gQEAgLTExNyw2ICsxMjAsNyBAQCBzdHJ1Y3QgZHdjM19h
bTYyIHsNCj4gIAl1bnNpZ25lZCBpbnQgb2Zmc2V0Ow0KPiAgCXVuc2lnbmVkIGludCB2YnVzX2Rp
dmlkZXI7DQo+ICAJdTMyIHdha2V1cF9zdGF0Ow0KPiArCXZvaWQgX19pb21lbSAqcGh5Ow0KDQpU
aGlzIGlzIGFuIG9kZCB3YXkgdG8gbmFtZSB0aGUgaW9tZW0uIEkgd291bGQgYXNzb2NpYXRlICJw
aHkiIHRvIGENCmRldmljZSBtb3JlIHRoYW4gYW4gaW9tZW0uIEhvdyBhYm91dCBwaHlfcmVncz8N
Cg0KSW4gYW55IGNhc2UsIGl0J3MganVzdCBtaW5vciBuaXQuIFJlZ2FyZGxlc3Mgd2hldGhlciB5
b3Ugd2FudCB0byByZW5hbWUNCml0IG9yIG5vdDoNCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8
VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KQlIsDQpUaGluaA0KDQoNCj4gIH07DQo+ICAN
Cj4gIHN0YXRpYyBjb25zdCBpbnQgZHdjM190aV9yYXRlX3RhYmxlW10gPSB7CS8qIGluIEtIWiAq
Lw0KPiBAQCAtMTg0LDE1ICsxODgsNDcgQEAgc3RhdGljIGludCBwaHlfc3lzY29uX3BsbF9yZWZj
bGsoc3RydWN0IGR3YzNfYW02MiAqYW02MikNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAr
c3RhdGljIGludCBkd2MzX3RpX2luaXQoc3RydWN0IGR3YzNfYW02MiAqYW02MikNCj4gK3sNCj4g
KwlpbnQgcmV0Ow0KPiArCXUzMiByZWc7DQo+ICsNCj4gKwkvKiBSZWFkIHRoZSBzeXNjb24gcHJv
cGVydHkgYW5kIHNldCB0aGUgcmF0ZSBjb2RlICovDQo+ICsJcmV0ID0gcGh5X3N5c2Nvbl9wbGxf
cmVmY2xrKGFtNjIpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwkv
KiBXb3JrYXJvdW5kIEVycmF0YSBpMjQwOSAqLw0KPiArCWlmIChhbTYyLT5waHkpIHsNCj4gKwkJ
cmVnID0gcmVhZGwoYW02Mi0+cGh5ICsgVVNCX1BIWV9QTExfUkVHMTIpOw0KPiArCQlyZWcgfD0g
VVNCX1BIWV9QTExfTERPX1JFRl9FTiB8IFVTQl9QSFlfUExMX0xET19SRUZfRU5fRU47DQo+ICsJ
CXdyaXRlbChyZWcsIGFtNjItPnBoeSArIFVTQl9QSFlfUExMX1JFRzEyKTsNCj4gKwl9DQo+ICsN
Cj4gKwkvKiBWQlVTIGRpdmlkZXIgc2VsZWN0ICovDQo+ICsJcmVnID0gZHdjM190aV9yZWFkbChh
bTYyLCBVU0JTU19QSFlfQ09ORklHKTsNCj4gKwlpZiAoYW02Mi0+dmJ1c19kaXZpZGVyKQ0KPiAr
CQlyZWcgfD0gMSA8PCBVU0JTU19QSFlfVkJVU19TRUxfU0hJRlQ7DQo+ICsNCj4gKwlkd2MzX3Rp
X3dyaXRlbChhbTYyLCBVU0JTU19QSFlfQ09ORklHLCByZWcpOw0KPiArDQo+ICsJY2xrX3ByZXBh
cmVfZW5hYmxlKGFtNjItPnVzYjJfcmVmY2xrKTsNCj4gKw0KPiArCS8qIFNldCBtb2RlIHZhbGlk
IGJpdCB0byBpbmRpY2F0ZSByb2xlIGlzIHZhbGlkICovDQo+ICsJcmVnID0gZHdjM190aV9yZWFk
bChhbTYyLCBVU0JTU19NT0RFX0NPTlRST0wpOw0KPiArCXJlZyB8PSBVU0JTU19NT0RFX1ZBTElE
Ow0KPiArCWR3YzNfdGlfd3JpdGVsKGFtNjIsIFVTQlNTX01PREVfQ09OVFJPTCwgcmVnKTsNCj4g
Kw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IGR3YzNfdGlfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSAmcGRldi0+ZGV2Ow0KPiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IHBkZXYtPmRl
di5vZl9ub2RlOw0KPiAgCXN0cnVjdCBkd2MzX2FtNjIgKmFtNjI7DQo+ICAJdW5zaWduZWQgbG9u
ZyByYXRlOw0KPiAtCXZvaWQgX19pb21lbSAqcGh5Ow0KPiAgCWludCBpLCByZXQ7DQo+IC0JdTMy
IHJlZzsNCj4gIA0KPiAgCWFtNjIgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKmFtNjIpLCBH
RlBfS0VSTkVMKTsNCj4gIAlpZiAoIWFtNjIpDQo+IEBAIC0yMjgsMjkgKzI2NCwxNyBAQCBzdGF0
aWMgaW50IGR3YzNfdGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIA0K
PiAgCWFtNjItPnJhdGVfY29kZSA9IGk7DQo+ICANCj4gLQkvKiBSZWFkIHRoZSBzeXNjb24gcHJv
cGVydHkgYW5kIHNldCB0aGUgcmF0ZSBjb2RlICovDQo+IC0JcmV0ID0gcGh5X3N5c2Nvbl9wbGxf
cmVmY2xrKGFtNjIpOw0KPiAtCWlmIChyZXQpDQo+IC0JCXJldHVybiByZXQ7DQo+IC0NCj4gLQkv
KiBXb3JrYXJvdW5kIEVycmF0YSBpMjQwOSAqLw0KPiAtCXBoeSA9IGRldm1fcGxhdGZvcm1faW9y
ZW1hcF9yZXNvdXJjZShwZGV2LCAxKTsNCj4gLQlpZiAoSVNfRVJSKHBoeSkpIHsNCj4gKwlhbTYy
LT5waHkgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMSk7DQo+ICsJaWYg
KElTX0VSUihhbTYyLT5waHkpKSB7DQo+ICAJCWRldl9lcnIoZGV2LCAiY2FuJ3QgbWFwIFBIWSBJ
T01FTSByZXNvdXJjZS4gV29uJ3QgYXBwbHkgaTI0MDkgZml4LlxuIik7DQo+IC0JCXBoeSA9IE5V
TEw7DQo+IC0JfSBlbHNlIHsNCj4gLQkJcmVnID0gcmVhZGwocGh5ICsgVVNCX1BIWV9QTExfUkVH
MTIpOw0KPiAtCQlyZWcgfD0gVVNCX1BIWV9QTExfTERPX1JFRl9FTiB8IFVTQl9QSFlfUExMX0xE
T19SRUZfRU5fRU47DQo+IC0JCXdyaXRlbChyZWcsIHBoeSArIFVTQl9QSFlfUExMX1JFRzEyKTsN
Cj4gKwkJYW02Mi0+cGh5ID0gTlVMTDsNCj4gIAl9DQo+ICANCj4gLQkvKiBWQlVTIGRpdmlkZXIg
c2VsZWN0ICovDQo+ICAJYW02Mi0+dmJ1c19kaXZpZGVyID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRf
Ym9vbChkZXYsICJ0aSx2YnVzLWRpdmlkZXIiKTsNCj4gLQlyZWcgPSBkd2MzX3RpX3JlYWRsKGFt
NjIsIFVTQlNTX1BIWV9DT05GSUcpOw0KPiAtCWlmIChhbTYyLT52YnVzX2RpdmlkZXIpDQo+IC0J
CXJlZyB8PSAxIDw8IFVTQlNTX1BIWV9WQlVTX1NFTF9TSElGVDsNCj4gIA0KPiAtCWR3YzNfdGlf
d3JpdGVsKGFtNjIsIFVTQlNTX1BIWV9DT05GSUcsIHJlZyk7DQo+ICsJcmV0ID0gZHdjM190aV9p
bml0KGFtNjIpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICANCj4gIAlwbV9y
dW50aW1lX3NldF9hY3RpdmUoZGV2KTsNCj4gIAlwbV9ydW50aW1lX2VuYWJsZShkZXYpOw0KPiBA
QCAtMjU4LDcgKzI4Miw2IEBAIHN0YXRpYyBpbnQgZHdjM190aV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiAgCSAqIERvbid0IGlnbm9yZSBpdHMgZGVwZW5kZW5jaWVzIHdp
dGggaXRzIGNoaWxkcmVuDQo+ICAJICovDQo+ICAJcG1fc3VzcGVuZF9pZ25vcmVfY2hpbGRyZW4o
ZGV2LCBmYWxzZSk7DQo+IC0JY2xrX3ByZXBhcmVfZW5hYmxlKGFtNjItPnVzYjJfcmVmY2xrKTsN
Cj4gIAlwbV9ydW50aW1lX2dldF9ub3Jlc3VtZShkZXYpOw0KPiAgDQo+ICAJcmV0ID0gb2ZfcGxh
dGZvcm1fcG9wdWxhdGUobm9kZSwgTlVMTCwgTlVMTCwgZGV2KTsNCj4gQEAgLTI2NywxMSArMjkw
LDYgQEAgc3RhdGljIGludCBkd2MzX3RpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICAJCWdvdG8gZXJyX3BtX2Rpc2FibGU7DQo+ICAJfQ0KPiAgDQo+IC0JLyogU2V0IG1v
ZGUgdmFsaWQgYml0IHRvIGluZGljYXRlIHJvbGUgaXMgdmFsaWQgKi8NCj4gLQlyZWcgPSBkd2Mz
X3RpX3JlYWRsKGFtNjIsIFVTQlNTX01PREVfQ09OVFJPTCk7DQo+IC0JcmVnIHw9IFVTQlNTX01P
REVfVkFMSUQ7DQo+IC0JZHdjM190aV93cml0ZWwoYW02MiwgVVNCU1NfTU9ERV9DT05UUk9MLCBy
ZWcpOw0KPiAtDQo+ICAJLyogRGV2aWNlIGhhcyBjYXBhYmlsaXR5IHRvIHdha2V1cCBzeXN0ZW0g
ZnJvbSBzbGVlcCAqLw0KPiAgCWRldmljZV9zZXRfd2FrZXVwX2NhcGFibGUoZGV2LCB0cnVlKTsN
Cj4gIAlyZXQgPSBkZXZpY2Vfd2FrZXVwX2VuYWJsZShkZXYpOw0KPiBAQCAtMzM4LDYgKzM1Niw5
IEBAIHN0YXRpYyBpbnQgZHdjM190aV9zdXNwZW5kX2NvbW1vbihzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+ICAJCWR3YzNfdGlfd3JpdGVsKGFtNjIsIFVTQlNTX1dBS0VVUF9TVEFULCBVU0JTU19XQUtF
VVBfU1RBVF9DTFIpOw0KPiAgCX0NCj4gIA0KPiArCS8qIGp1c3QgdG8gdHJhY2sgaWYgbW9kdWxl
IHJlc2V0cyBvbiBzdXNwZW5kICovDQo+ICsJZHdjM190aV93cml0ZWwoYW02MiwgVVNCU1NfREVC
VUdfQ0ZHLCBVU0JTU19ERUJVR19DRkdfRElTQUJMRUQpOw0KPiArDQo+ICAJY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKGFtNjItPnVzYjJfcmVmY2xrKTsNCj4gIA0KPiAgCXJldHVybiAwOw0KPiBAQCAt
MzQ4LDcgKzM2OSwxNCBAQCBzdGF0aWMgaW50IGR3YzNfdGlfcmVzdW1lX2NvbW1vbihzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQo+ICAJc3RydWN0IGR3YzNfYW02MiAqYW02MiA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOw0KPiAgCXUzMiByZWc7DQo+ICANCj4gLQljbGtfcHJlcGFyZV9lbmFibGUoYW02Mi0+
dXNiMl9yZWZjbGspOw0KPiArCXJlZyA9IGR3YzNfdGlfcmVhZGwoYW02MiwgVVNCU1NfREVCVUdf
Q0ZHKTsNCj4gKwlpZiAocmVnICE9IFVTQlNTX0RFQlVHX0NGR19ESVNBQkxFRCkgew0KPiArCQkv
KiBsb3N0IHBvd2VyL2NvbnRleHQgKi8NCj4gKwkJZHdjM190aV9pbml0KGFtNjIpOw0KPiArCX0g
ZWxzZSB7DQo+ICsJCWR3YzNfdGlfd3JpdGVsKGFtNjIsIFVTQlNTX0RFQlVHX0NGRywgVVNCU1Nf
REVCVUdfQ0ZHX09GRik7DQo+ICsJCWNsa19wcmVwYXJlX2VuYWJsZShhbTYyLT51c2IyX3JlZmNs
ayk7DQo+ICsJfQ0KPiAgDQo+ICAJaWYgKGRldmljZV9tYXlfd2FrZXVwKGRldikpIHsNCj4gIAkJ
LyogQ2xlYXIgd2FrZXVwIGNvbmZpZyBlbmFibGUgYml0cyAqLw0KPiANCj4gLS0tDQo+IGJhc2Ut
Y29tbWl0OiBjZGQzMGViYjFiOWYzNjE1OWQ2NmYwODhiNjFhZWUyNjRlNjQ5ZDdhDQo+IGNoYW5n
ZS1pZDogMjAyNDExMjItYW02Mi1kd2MzLWlvLWRkci0zYmNiNjgzYTkxYTANCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gLS0gDQo+IFJvZ2VyIFF1YWRyb3MgPHJvZ2VycUBrZXJuZWwub3JnPg0KPiA=

