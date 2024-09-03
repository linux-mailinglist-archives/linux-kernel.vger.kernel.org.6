Return-Path: <linux-kernel+bounces-313892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB4F96ABEA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C61B1C2416A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F241D7E2F;
	Tue,  3 Sep 2024 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="as1ZOen4";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cBOQ3X12";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KyK7CAVb"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65071D799E;
	Tue,  3 Sep 2024 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401484; cv=fail; b=Mp+rnTtowLNBpXJtm5d1ZHmph+baoUqVPywkwbT2CClc+43UAo8zwmRl56+ouHWqhPoRs0CHQ674L8jHNyDnTCsxrvNvdHJvObCRkaWXky0lfSZ5DuTNHy+Nob1pIw9DWwcogXMmURjqDOhSwkaGVgxqcr9MpQq4AeXd3iW5aSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401484; c=relaxed/simple;
	bh=gp9YWVziIfFdMfMZadpKUdjfxLxKvK/Ea/6aJ/tqudg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RfOI4sELI9vn17O56fi5BC4DLjdPhgIvyWcMNak2mz+2lchQmMqmp3XBxJTUzM7fHXivZpRC+pqPNd5pwM590xbnsU7VOt/m+IBjv7xB0NEekSkIrW8lxC4f5Tg/MNiULREY8hIUSzJQMC+OMmRTAMykuW0q7gzri8X88sFjDaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=as1ZOen4; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cBOQ3X12; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KyK7CAVb reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LYJiP001398;
	Tue, 3 Sep 2024 15:11:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=gp9YWVziIfFdMfMZadpKUdjfxLxKvK/Ea/6aJ/tqudg=; b=
	as1ZOen4PtCAZuYqXjW1pwrjy4b9pUhWcXg6QiEHUJt2R1CroAXbl75UdNd5f3oJ
	ZAli9Q2fkmole9XqF/jnczIgPMQPcK8nJZoAJ4nWmVrIIA4XhyqdsiI5eWLDjg6K
	cKJrwXy9PLsNzohNFBQaakJtQfGyH05C1F93xk00sada9VNDu36QZjnMOeHy9rcs
	KyGBgF8FLQv+0llaemiza/u3Tc2i1W9xxCAFdmAcHma7bO95G1ZtZVYEORWte0mt
	NXvjKRgGnKJH/6EpuDQN03x9WK0V32qwvOezRtiedsiTpmAzQ3kL1Ct19lLTCHrJ
	ofQAscXVaeOIfptFwQrtGg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41c26pw5v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 15:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1725401473; bh=gp9YWVziIfFdMfMZadpKUdjfxLxKvK/Ea/6aJ/tqudg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=cBOQ3X12+DmFDAwtZIAmPyq53orGFNAhTxhUMYrvgIfkLD4JkxksSN6W7BV/TCGsS
	 NnDWjQ6LKgu3RI5HkAsKbZEEdTMRxh5XEORxa1uFTx0NKv5Q9D14ItrGzLdPvs8SBP
	 WEEIvIiKlkBoRZez+yyT441cdgNcVoUwXJ4E2IPDHqDg0M9HnkIiht7roLHrce051W
	 1nzbQ6AACCdQKuF2/R5+f8dPoLSj7A85MPlxZAHFu4LPl5XAPIM8q9jlVjRObbCZMT
	 7ugDHM09Ob+X9H+X69/hWn5G3qoKR5mE8WvMSo4TyBkPLwGQcysLgKslLZOwgCdr00
	 G1n1TSZLJDp4w==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1F6AE404CF;
	Tue,  3 Sep 2024 22:11:13 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id AAE35A007A;
	Tue,  3 Sep 2024 22:11:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KyK7CAVb;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 02D1540149;
	Tue,  3 Sep 2024 22:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hi1uD6ibySS5JL+Za8Bon/LagAKX8S9qoCL4J4m6Ijzn3FMK5bxV1YRf05s2SCE3J8/q5w/8Us1TuKJtqbQ/RK7IxfNhktWaYlHel5sCtoNIEvlbZfYd9ZoLUr2WwKuncbhYT3CxKoIBeC5O00ffPPHPWPqtoZUDxxecTiPRjAfjsXLVbGHL+0PGB6FcwMqiMM/JKwJgiodSGCEwixYg1G0oyQUsR+1XSNvfLivY4qzqd6R7KX6K+DtJtRNIRuBtHoRD34S0Z2Ib+5foIFn74OBa5i1Xh955q49GjTCQ7B03U+i1AC1YIBFWsRkKa4vUOhEx9K2PfgE86WEH9tfcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp9YWVziIfFdMfMZadpKUdjfxLxKvK/Ea/6aJ/tqudg=;
 b=ZPvmBwY/JD8gAwN3aCASsKVJ84YRaIQ2M9TqK7Hsmrg4moYO3TwJxVnKsRBW4H6bn01+e5Mnk6Ezx1QkMY0FEcADoXXJG9cfPODEdiiH+zRFsgilVYlfL7UAj7cE3aAtpapxyjWyO8sVTPiR63tH+KkoPt7ucvFHhE2dr8JD1YcbBGickbACvN4BgRhO3Q9eOqFzPTwrKZs9J02n9jnLrcUjp9xPFeP4Lhx9LIkRk/B1BInxo5hfpjAjjrvO1EdLtU7RHiZezZ41SmLi/VKOKu4iVwpo8T4qQ3ua2f9bKcSV0m9PrbqsfsmRONDLKPSrlNNrPA6TDRz7lh1U/8oaLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp9YWVziIfFdMfMZadpKUdjfxLxKvK/Ea/6aJ/tqudg=;
 b=KyK7CAVbgaWk6jsGkjW2bbY/vpteaTKtClJ0Ki746vLjr5rJBsl9XZ1OhvIJl4tl71yBzVr04bGnSAhRXvIGPFY8p8Tieot9yWs/gJMv3Qi2mcwiH7HXPubCtUd1XGlru5mDaHXgAq9Dvxnki4oFRl9dVq7ta+gqbuOX1KNytR8=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Tue, 3 Sep
 2024 22:11:08 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 22:11:08 +0000
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
Subject: Re: [PATCH v2] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Thread-Index: AQHa/gVcU2dx3NbwU028Vf9GncOMbbJGoECA
Date: Tue, 3 Sep 2024 22:11:07 +0000
Message-ID: <20240903221055.s4gu6actfbrkonmr@synopsys.com>
References: <20240903132917.603-1-quic_akakum@quicinc.com>
In-Reply-To: <20240903132917.603-1-quic_akakum@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN2PR12MB4063:EE_
x-ms-office365-filtering-correlation-id: 5c8b89fe-4314-45c7-95fd-08dccc654fb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2IrOE9jeHlQdFBrTVhrOFpmc0JVdzdmb0dibnoxOFFvS0toaTBmRDkvWlh3?=
 =?utf-8?B?Q0dRRmh0amZWSmJqSUZrc2NkMUtJLzZGSnZwN2NvREpyaEpjdFAxR0xTVGpX?=
 =?utf-8?B?cGhqTlFaMS9RWDdKanJiRmluSi9JdHNLY1dVYzRFV2NFSkZ4YVlCTHBZZmtw?=
 =?utf-8?B?Z2I1TFYvRTY4Rm40TlJGNklTZmJUNUpUQWtvZlh2MjNQeGRaQy9ycFN3Wkl3?=
 =?utf-8?B?VjM5bS9IRW5oNGVOeGhua0lDbStvQmpzbldJMWthQ3hremFRVzBqajlBbW5X?=
 =?utf-8?B?NEppWXVSVjYvaUhMT2VudDJhYmk5WGZ6aUM0TTRMT0QyZ25ORTA3cXJLcDNk?=
 =?utf-8?B?anRzaEdXRGpTWEdNaEF6bEJSdGNLUUdSS2l5OFA3cmhyUE1vZEQ0SUVWTFZz?=
 =?utf-8?B?WUZFdU5xNDdpRUZ5SUl4TWMycjIvMDJhNStOTFB3VEFRUVYrR1NxS3ZVblgw?=
 =?utf-8?B?M0VFcGxrYW9MU1JDcWk4WFdneDh6NFFOSFFhUnJCVTlNeGlJMHF3enBZUVA3?=
 =?utf-8?B?UkZWbk9IYkIwaTE0NGV4bzlQRVNXTEt4VUZCV0ZudytLdktvTmlUd2VKZ2sz?=
 =?utf-8?B?SEI0Qko2ay8rbVJDMTkxRWZkbDhxbTRWK1V4UFJ3bENYTExGS1pybU9xaHN2?=
 =?utf-8?B?VFRzaElXYjNCSVJJK1Z6UHl3ajc4ZVBTZk4rRE1RK3dGVWZaTlNEWGZRazhx?=
 =?utf-8?B?OXNYN2hNbktHQlVvaWtXRUszN2VFLzN4ZzBNS1AzWUNhblNBN1J5U2VKZ1dE?=
 =?utf-8?B?V08yVWxYb3lTOXB0YmdkdTJuRXVZWUtaTm5nOTBaYitoQmFjWXpjMkVvTEF4?=
 =?utf-8?B?VWNuTFhsZGtuOFN0emJYYlQ5eVY1RTJPSHk1dldiYkVUOEdILzJpY3lmSU5M?=
 =?utf-8?B?TS9NMlBNOEJ4NnE4TmJ0Q3o4RjA3eldlVi9WTE1rV1J4bkY1K255SkpXMlhE?=
 =?utf-8?B?d1VzQWZpNk1pbWtBZWtLUTF0YmNhWnlkdStqc2pFNGxXeXFIMzFPYXhIcFht?=
 =?utf-8?B?WFNEZTlOcytpNk1ldlRUbDhYaWRyM2U5TFROV2VMRFVXR1RhUDU0UTI2d2E2?=
 =?utf-8?B?VGV4aSs5b0NrdjhIek1qRUpIb21hZDlIVEhmS3lmQjd3WWREWTh2YUx6Nmxl?=
 =?utf-8?B?a2JSMTFDS2ZEUFFyaG5GWDN6di9yTTZ0LzhqNzlkZDVWeE01VnRoWUJMTkkz?=
 =?utf-8?B?MTVNTEVYOFpIUmt6aVllWWYvWFhhRkFBUWhhcFdabWljU3RRTWZqN1l2QWxv?=
 =?utf-8?B?Vnk0MU9JTjI1aTdKUUFFTEFtUVh3dGRkVjlCZ21FYnJOOFhiWWhJTmZPODFp?=
 =?utf-8?B?R0U1NkRWTnlzUXRvRTJPU1JUa00rSys5MmsxOVlxbThYTlJHRTFiQ1hudmFz?=
 =?utf-8?B?ZE5BYm50Ym5qSldSMThCR2hTSHcrTHNkUDFHeFJxb2twRE9zTTRLVCtJSkJJ?=
 =?utf-8?B?SEpZUFNab0JYaEZuby9HVEFyMFJWU1ltUnZVeHhIdk4rdFNOWWlWRlBKV0sy?=
 =?utf-8?B?QnI0dVA5SnkwaXVUek9Yc1ZIN3pYZ0h5RlhOSEcvZkJMTmQ2aWhiQnE0TDZo?=
 =?utf-8?B?aWVoODBFWUZZRXNEaTQyVWIvYWFOM28rVlV4SnMyWnllLzNmTzRhYldXZ1d3?=
 =?utf-8?B?MDNrSkU2aXpiOUNyTmNDb1dQMldWOWpYaGtER0hUenZCK1JUNUxJK3VaNDlp?=
 =?utf-8?B?R0dNZnk2Y21WcmNMVExBTEN5bUFZWG1ldW1nbTV2QkFQYTFyS3cvR3pxSmJG?=
 =?utf-8?B?UnVlS2M2MjZHVklGVlFNdTU0ckI2b2E0ODFrQTR3V2p6dlBtZlZXMVp3Z1Qv?=
 =?utf-8?B?UFZpbFBnTG9IQU1GcWIvOHRFV0ZPK1ZGRFc3SzczQjBjYy9nUnFtWW5yYzJp?=
 =?utf-8?B?UTdHNEpvcXpHSjlkbjhnSjB3azE3c3d0UmZXZjQzQ3owQ1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmhaNktvQXJYbVRZY0dCam9QV1cvTEg4akZhYVpBbWRhdFNQVlZUUEdXT1Z1?=
 =?utf-8?B?aTVQZjNxNzI4dGZpLzBGOGw2UllGOThVN1BKTVhHYkJDSVVEY0FHVC9IeXNJ?=
 =?utf-8?B?WGJCem9vTUsrbitFMHhrOURWb1NvblZPR25CeGRTdEtOMTkzSFNZR2k1MGRF?=
 =?utf-8?B?cTVBc0Y5Z1htb0NRUVBMTDBBd1B4eGR5bW1uZG81dUJmWko1RDZTSEZzNmhI?=
 =?utf-8?B?eW1GMkRVMW5SbXRTZHZ4TnVNQkRBWVBRQ1hIWWVYb3pmSFJsZS9UTkdjZTE0?=
 =?utf-8?B?N3pVbW5jNFRtU1hUK09yZXIyOTFKdWY3K3FDeDV4Ty9sS0Jwd05sOEoreTNw?=
 =?utf-8?B?YnJUblY0Mk9MZkRyb0FJUGRCT1kyTC9HS0NWYkFHSlpydHc4WWRKeGhHbGVP?=
 =?utf-8?B?bHJLbTV5V3pMZjFWc0ZnUURwbm5Eai9zcWN5OERKTXFNNFJGUktoNU1GUEhB?=
 =?utf-8?B?c1VmL0RjcHJxMGFueFdEN1FiOEZENml3NFVXbkJKM1pZa1RWREdXNnp0SDdV?=
 =?utf-8?B?WTlBRGpqT3llZXNlU05EbmNHQlBobU1rTU1zSWRlaVJBWmhjR21uRlVScTN0?=
 =?utf-8?B?b2lDOHBYeUU5dnpJZ094RkFtWHErV3hCWjBySU1YSStxc1BNWFZ5WXYwcUlK?=
 =?utf-8?B?V0pQaDdXVER2VG1OakcwOXlOL0V6RGxLcWVBSmlXUzhSNnltZVpvRkI1b1Y0?=
 =?utf-8?B?ZXYva1EyUllxRjJOMG5wRWpONUlEbkhWM0htWFoweVl4dWR3SUtoNnVrNjNR?=
 =?utf-8?B?TnBYdnJjRXh2cVh5bW40ZVpQSE03MFgzZ3FRRzlnTFRRMTZyS2FMYVd1TEQ3?=
 =?utf-8?B?Vkt0ZWZMcUgwWnFkTm5rclVzMVBDNzhPM3JJYjc1VXdpOW9JU3lHb09SQW1m?=
 =?utf-8?B?M0tmOEJhOFNMR09lK3FPK0o2Sm01SUVMRXErV09FM2ZRT0E4NUpLb3MwV2gz?=
 =?utf-8?B?NWk3WVZhVG1tVFJ2QldrZ1E5YlZHQjg0dGRiWE1HZUFoazRESW9oUTVOWVkr?=
 =?utf-8?B?Wisxd045NTlBbXF3L3pkc28xL1dRNVpLTUxJZzA5cUlYbUxjNHhaL091a0xO?=
 =?utf-8?B?c29RdTRsZ1BlZEd5b0pObHV5NU03WlFCKy9PVUFuRldmc2pBNHZWL1FITXJs?=
 =?utf-8?B?amtwTE5hZmpEeXVYeThPN295NVFadW5pRXNLUUdQOTJwcDRPTlNkeDBEZjc1?=
 =?utf-8?B?QnZmVEwzYjdqS3RRVWtRS3BGdGlmaTg3K3JjeUJ4YVFFYXR1aGhhbnNTRHZu?=
 =?utf-8?B?RWVYQmNjdEFkdnB5MjNxTFZ5bGxwbFU4N3AxM1BqaU5RVWNGdzlER2hZLzNi?=
 =?utf-8?B?b0l6L3NmT0pGZFRxSWdTN0FHd282QW9BREFRK3pocDZ3Y0pnTHVxM1FWY0xv?=
 =?utf-8?B?ZGZYL04yNSsxWFArU2EvTG00eDRYWi9QQUdrbG5JRzNJdlpzWVprdEg3UUJl?=
 =?utf-8?B?RlJPalJSVzJ6amdZdm5OK3VvS1EwLzNSNGtpOGpPUFNvSlgveGZsajc4WGp1?=
 =?utf-8?B?cVBGaWh6TTF2dFZVM1NuT1pEbFBSTFpMalA2ZGVVSGFTZ2k4OXErSndwY3Fv?=
 =?utf-8?B?M3hCUzIrQkxwTmZlK2FZZmc3cFhaZVJFZGl4TW9DNldSZWcyL3cyN2x0WWls?=
 =?utf-8?B?TjlYandxVnJyRGlJU2FaRmtveFZTcUJKb3pzMkF3b2lWREE3UUF6OEdPRlVJ?=
 =?utf-8?B?YmxvaWdURitLejZrYm15RTZ3S0E3TENjWmVSR3BoTnBNMXRhVG05R3VYYVE5?=
 =?utf-8?B?TEJoWlVOZytKMDlYWHZhY3FicDFXdXJ6WXdtdm8yMG83eVNTdWMzRHljUFdF?=
 =?utf-8?B?WW9XK0hUa1ZsRDVWbitnN1NZcVdzNzBFUHdlcXppQVdLbUoyMWIwYmNCSm95?=
 =?utf-8?B?RGFkN2RxZExMV3VDV3VZZXd3a0ZuVVNmNGNETkx0U2Ewb3Y5TDM2Ym1kRmtR?=
 =?utf-8?B?ajRBQ1ZncWEyRU4zTE1DYVR1d2V0ZHNOdWJCeHgxN2J3bExRVHkxbW9tbit0?=
 =?utf-8?B?RTlpeFdUd1NhNVJZMk9HY1ZMN2hQMnl1MmsvM0RGSjN2ZG1RNHh2N2YweEtt?=
 =?utf-8?B?dUUyd2x2M25WY3lKelFvTE1ndGJTcFZUTWdwQjlybVBaZTczSXdsUHBTbzlK?=
 =?utf-8?Q?PTfskHSE/ZzFXmW0jbUIgSZr3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC0F4CD2F635104DBE7DA260647C1ADE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aduvgSPaPHeG+sFxT7upcxtcFNK+s8wyYy7GpsLyh9HVkm1txlBldyP0bsP0b1qPi+4hWvtcolI2bO7Av3zEf6TcxFl4NvudqgtHcY9NBp+ZYc1bHEEZLmpCSyTkIADdf2LjiTIKJ5hITGoyuo62o7ul6hJO4pkMx5rLZFzQj/+iiGvEmvGPdokeFcRbY2Qz1Y7aHCs+eU74QHcbYbKWQUbW2MR4SYQrI7YlGgGqx+Ce7jj7NfUo7hBxGgdLV4YeXuAICy4HCQkgEqMBJwoG8S57lw+9vNG9gZB/e6q0CmVh6rwN92OZNipZSLeJ+LovtZEfJp4OVl4WU54f/bT8JqxNHRVfL8iMtNCJz0FUS3dQxqDfxN0ZqkBEkQ9ZJ3kbysh1rlYpR1oDbu12SmobPi/LsEynyG6LZAL7dD0EEOUsh4TB46OFJ+MDIJHCyJesQDnequsg1PJ8SxdEsjFo+fEZgtyFrR72/j6YI63lxcB/JInEdKDbIJxB6OTDJpJ1DPRwXwRDo6SRi6pXpQg+OqPdroGmXCPvgGnM9t3i7DVx+MZ38MONh2gODdsNXXMdzbY972cvIWajG8EI1GPzG1R9Dr0hHlWokil9qs9jnUy+xiZ3kPORZZh/DKqr6iArN+caUrr/8n1xpQSYfs6GjQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8b89fe-4314-45c7-95fd-08dccc654fb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 22:11:08.0086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: My3/IBpRLkY6eiBnn25shxK/uV50MTB05+I9TZZkmJkeGYwBq54MMlgAC+rM/OlpC/+IBnUxyTCC0BWZRlZxiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
X-Proofpoint-GUID: pm4JVQD2LAaNEfGgOc_B5qpzoge98Mu7
X-Proofpoint-ORIG-GUID: pm4JVQD2LAaNEfGgOc_B5qpzoge98Mu7
X-Authority-Analysis: v=2.4 cv=X9YAK3Te c=1 sm=1 tr=0 ts=66d78981 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=COk6AnOGAAAA:8 a=HpOj8qZY8x3RjJIJHrAA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_10,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409030177

T24gVHVlLCBTZXAgMDMsIDIwMjQsIEFrYXNoIEt1bWFyIHdyb3RlOg0KPiBUaGUgY3VycmVudCBs
b2dpYyBpcyByaWdpZCwgc2V0dGluZyBudW1fZmlmb3MgdG8gZml4ZWQgdmFsdWVzOg0KPiANCj4g
MyBmb3IgYW55IG1heGJ1cnN0IGdyZWF0ZXIgdGhhbiAxLg0KPiB0eF9maWZvX3Jlc2l6ZV9tYXhf
bnVtIGZvciBtYXhidXJzdCBncmVhdGVyIHRoYW4gNi4NCj4gQWRkaXRpb25hbGx5LCBpdCBkaWQg
bm90IGRpZmZlcmVudGlhdGUgbXVjaCBiZXR3ZWVuIGJ1bGsgYW5kDQo+IGlzb2Nocm9ub3VzIHRy
YW5zZmVycywgYXBwbHlpbmcgc2ltaWxhciBsb2dpYyB0byBib3RoLg0KPiANCj4gVGhlIG5ldyBs
b2dpYyBpcyBtb3JlIGR5bmFtaWMgYW5kIHRhaWxvcmVkIHRvIHRoZSBzcGVjaWZpYyBuZWVkcyBv
Zg0KPiBidWxrIGFuZCBpc29jaHJvbm91cyB0cmFuc2ZlcnM6DQo+IA0KPiBCdWxrIFRyYW5zZmVy
czogRW5zdXJlcyB0aGF0IG51bV9maWZvcyBpcyBvcHRpbWl6ZWQgYnkgY29uc2lkZXJpbmcNCj4g
Ym90aCB0aGUgbWF4YnVyc3QgdmFsdWUgYW5kIHRoZSBtYXhpbXVtIGFsbG93ZWQgbnVtYmVyIG9m
IEZJRk9zLg0KPiANCj4gSXNvY2hyb25vdXMgVHJhbnNmZXJzOiBFbnN1cmVzIHRoYXQgbnVtX2Zp
Zm9zIGlzIHN1ZmZpY2llbnQgYnkNCj4gY29uc2lkZXJpbmcgdGhlIG1heGJ1cnN0IHZhbHVlIGFu
ZCB0aGUgbWF4aW11bSBwYWNrZXQgbXVsdGlwbGllci4NCj4gDQo+IFRoaXMgY2hhbmdlIGFpbXMg
dG8gb3B0aW1pemUgdGhlIGFsbG9jYXRpb24gb2YgVHggRklGT3MgZm9yIGJvdGggYnVsaw0KPiBh
bmQgaXNvY2hyb25vdXMgZW5kcG9pbnRzLCBwb3RlbnRpYWxseSBpbXByb3ZpbmcgZGF0YSB0cmFu
c2Zlcg0KPiBlZmZpY2llbmN5IGFuZCBvdmVyYWxsIHBlcmZvcm1hbmNlLg0KPiBJdCBhbHNvIGVu
aGFuY2VzIHN1cHBvcnQgZm9yIGFsbCB1c2UgY2FzZXMsIHdoaWNoIGNhbiBiZSB0d2Vha2VkDQo+
IHdpdGggRFQgcGFyYW1ldGVycyBhbmQgdGhlIGVuZHBvaW504oCZcyBtYXhidXJzdCBhbmQgbWF4
cGFja2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWthc2ggS3VtYXIgPHF1aWNfYWtha3VtQHF1
aWNpbmMuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBmb3IgdjI6DQo+IFJlZGVmaW5lIGxvZ2ljIGZv
ciByZXNpemluZyB0eCBmaWZvcy4NCj4gDQo+IENoYW5nZXMgZm9yIHYxOg0KPiBBZGRlZCBhZGRp
dGlvbmFsIGNvbmRpdGlvbiB0byBhbGxvY2F0ZSB0eCBmaWZvIGZvciBocyBpc29jIGVwcywNCj4g
a2VlcGluZyB0aGUgb3RoZXIgcmVzaXplIGxvZ2ljIHNhbWUuDQo+IC0tLQ0KPiAgZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYyB8IDE1ICsrKysrKy0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRl
eCA4OWZjNjkwZmRmMzQuLjQ5ODA5YTkzMTEwNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC03
NzgsMTUgKzc3OCwxMiBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3Jlc2l6ZV90eF9maWZvcyhz
dHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiAgDQo+ICAJcmFtMV9kZXB0aCA9IERXQzNfUkFNMV9ERVBU
SChkd2MtPmh3cGFyYW1zLmh3cGFyYW1zNyk7DQo+ICANCj4gLQlpZiAoKGRlcC0+ZW5kcG9pbnQu
bWF4YnVyc3QgPiAxICYmDQo+IC0JICAgICB1c2JfZW5kcG9pbnRfeGZlcl9idWxrKGRlcC0+ZW5k
cG9pbnQuZGVzYykpIHx8DQo+IC0JICAgIHVzYl9lbmRwb2ludF94ZmVyX2lzb2MoZGVwLT5lbmRw
b2ludC5kZXNjKSkNCj4gLQkJbnVtX2ZpZm9zID0gMzsNCj4gLQ0KPiAtCWlmIChkZXAtPmVuZHBv
aW50Lm1heGJ1cnN0ID4gNiAmJg0KPiAtCSAgICAodXNiX2VuZHBvaW50X3hmZXJfYnVsayhkZXAt
PmVuZHBvaW50LmRlc2MpIHx8DQo+IC0JICAgICB1c2JfZW5kcG9pbnRfeGZlcl9pc29jKGRlcC0+
ZW5kcG9pbnQuZGVzYykpICYmIERXQzNfSVBfSVMoRFdDMzEpKQ0KPiAtCQludW1fZmlmb3MgPSBk
d2MtPnR4X2ZpZm9fcmVzaXplX21heF9udW07DQo+ICsJaWYgKHVzYl9lbmRwb2ludF94ZmVyX2J1
bGsoZGVwLT5lbmRwb2ludC5kZXNjKSkNCj4gKwkJbnVtX2ZpZm9zID0gbWluX3QodW5zaWduZWQg
aW50LCBkZXAtPmVuZHBvaW50Lm1heGJ1cnN0ICsgMSwNCj4gKwkJCQkgIGR3Yy0+dHhfZmlmb19y
ZXNpemVfbWF4X251bSk7DQo+ICsJaWYgKHVzYl9lbmRwb2ludF94ZmVyX2lzb2MoZGVwLT5lbmRw
b2ludC5kZXNjKSkNCj4gKwkJbnVtX2ZpZm9zID0gbWF4X3QodW5zaWduZWQgaW50LCBkZXAtPmVu
ZHBvaW50Lm1heGJ1cnN0LA0KPiArCQkJCSAgdXNiX2VuZHBvaW50X21heHBfbXVsdChkZXAtPmVu
ZHBvaW50LmRlc2MpKTsNCg0KTm8uIERvbid0IG1peCB1c2JfZW5kcG9pbnRfbWF4cF9tdWx0IHdp
dGggbWF4YnVyc3QgbGlrZSB0aGlzLiBDaGVjayBiYXNlDQpvbiBvcGVyYXRpbmcgc3BlZWQuIEFs
c28sIG5vdyB5b3UncmUgaWdub3JpbmcgdHhfZmlmb19yZXNpemVfbWF4X251bSBmb3INCmlzb2Mu
DQoNCkJSLA0KVGhpbmg=

