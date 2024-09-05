Return-Path: <linux-kernel+bounces-316141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48A296CBBC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096C51F2757F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872668462;
	Thu,  5 Sep 2024 00:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TkV+Qdl4";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ri9Psk2B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TItzgue9"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46387FD;
	Thu,  5 Sep 2024 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495997; cv=fail; b=utAyhxFle/DzvUbdG0TexlrAk/E6tEK5LtXkv1AlaGAm9wAOCNHabUaJDDzHnhRmFs7BkDLUZKzWLPJQ0zqF8OZf8RmK/co/3J4sV6DLVqR9uu6f6wzee1TvdP6D8q68SnBZaWwaoN0I44gRfrqiaKjL/PSDPEAnrYz1zZlpL6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495997; c=relaxed/simple;
	bh=BtSsA+YzJg+7B+UQQrMq0KwvaYxIn4EBaVezkVL4U9o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BK4sZ+lsXOwKtWXdVFKHMx4g/q12pFMqVa7J9VJlE6o/uT5JtG7veNaoIkhQDgzT2PqNaHJzLGm8suOzGTxEMAotgEcxeUSYwHk/qicR91fQQYUInOmIzBAvBRYGfxwaAWrPkrjbgI5R4MkA50IIACXGAm+6wVeJCYE5namWPh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TkV+Qdl4; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Ri9Psk2B; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TItzgue9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484MCZf1010167;
	Wed, 4 Sep 2024 17:26:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=BtSsA+YzJg+7B+UQQrMq0KwvaYxIn4EBaVezkVL4U9o=; b=
	TkV+Qdl4wnRg+p1dHwJTKZGnja9XpfrByvNSKJA89qTtQ2/INrJCRdBacR6oHsr1
	QByg/W6k2KCuAh6uRuutw7C7GMkWGTz6XbqFors2JBwMYJDdNOyjcwBPg5c1+NlF
	NwhI4rhOkP/4R0foBoR/7c3jaAGbUj6bEk2Wls/ZYjgZgXr+0/tYnn/eagV+F1pv
	ELH32quQRuR29rCjus4dQRopFybyI2mww0ZmtSKaAAI9LJQ6SSDhUBB4MB2dQb46
	fiiVprii25c3DMTmVXaXgvaPlg2r6RCzRdrqVixhc9LCzPfNtzFuOLNslnAEVVn8
	RutwQPD7L6ljt8iipqJsRA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41c26q3cu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 17:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1725495984; bh=BtSsA+YzJg+7B+UQQrMq0KwvaYxIn4EBaVezkVL4U9o=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Ri9Psk2BsPz9MEjewa+c/ZTWOPSdSLBkT4YMlm0V5lk3svQKZ9htHPGTUg123T5Db
	 KVAZi80dxzviYcTx/UYQcRO1eHx219G9PMgQf3cI3iKFCYVgkxXdhCQKd9TE6fh0bj
	 eq0MPP1ZdynpUD6RGlkAW0nseUyPMuDqOC/XMbT/Lca6+OdyXFyANB/HpNdhkpeE7k
	 VDb8zofs1DIEvLUxSa0NIWZSlR+1wiSqeLYhLmnmzeiTdF+S2CQeIvChTIsH3Xd7ff
	 ldTnVuycRKOOdqlXYfGR4fHEeHNMugQ5ALhuGk5DRaHFXYWWFtVasmzjqk1tTQDy05
	 0jcoVKK/jHQeA==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2D2D940346;
	Thu,  5 Sep 2024 00:26:24 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C1E14A0097;
	Thu,  5 Sep 2024 00:26:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TItzgue9;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id CC41A4052A;
	Thu,  5 Sep 2024 00:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9eC0j+WllxZCfObNq3PGzz2j54lyExRH910v0RAt1sAcFEBapWwunG8dW/ABeFDUcd1YaEem//gcy9Kn4I7UoG+Bsg0rEbzroQ7ElC2AwQpkDd4pegkOmP4mlL6gFh2Vj8Zy1fcinkQKefjQXaJv6JlJ4qT5oy4MZPNQK2idvzrep3i7rxp2Ardmxj6pRC0TwNqYMfWcfo+EN8KW8kscW59u0uAf1QsOB3Y9iZ4X0WT2SG5BMonlCY7Plj/gQSoARWey6LmnOzutuep8n+U0PrStuNNEG7Up1+aWpgoKR2BYoyAJmcuqGcxmL0X56D26LhezlIf0NW1OhCAPektCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtSsA+YzJg+7B+UQQrMq0KwvaYxIn4EBaVezkVL4U9o=;
 b=NFjFg36GiMb9rXkdpEODHEtMSbzrKiq+xKw8Vp64yYrVkwP9zGgMqU1XK9oKkQnpoaBoVn6CVQMO3VIk6Bvpve0YcjgZ+eyfe/Y/WZixGBBdBpeXTSPSizxjYisssbRmUcZED2+cEpugFHEU3jdJmDs3N0Bi3CzbQ4DknrGO5mLw2FGBJfJrSAWkJtNigl15my1SsYO95ye6b0WnGoMYyCoO9sc31EC7BST42IwaJGa4vMc4dSD2vFTHJQyfTq6yNLQL50GSQYGVrQHgmgWLNlZEWXzwiHDNAJGdb1m5ObilKMqM47A6t3EC71xK63LvKUWSy/VXEi7p/I0C0xV01Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtSsA+YzJg+7B+UQQrMq0KwvaYxIn4EBaVezkVL4U9o=;
 b=TItzgue9kdC/IqnzPucyPGy5Qy6qm+xgW7ndEs41qwMbKYrzyhf41Ekw8DUNHRlvBN0VBwsgZerla1/bd0qZ95d+cVBOwGjO/wSFJwQqd8VR7JEz3eNWrRkRnMAfplQnzrT1cwtblAwKNIisxVl6lpQJZ2N2LM7s2DeghM3oi10=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 00:26:20 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 00:26:19 +0000
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
 AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AIAAVgGAgAK0ooCAIEFKAIAA0sIAgAPWhwCAAnZSAIAA99mAgACQGIA=
Date: Thu, 5 Sep 2024 00:26:19 +0000
Message-ID: <20240905002611.rxlv66zsker2h5w2@synopsys.com>
References: <20240807003806.5owtgwgw2lczg4u5@synopsys.com>
 <b6baeb45-1684-4fcb-8c71-392cb4788c85@samsung.com>
 <20240808011536.oid627ez4ppdfkhp@synopsys.com>
 <b48e7aba-6c54-431f-bbb5-3e5490df0c1a@samsung.com>
 <20240809234227.eriwy5e6leatzdyh@synopsys.com>
 <b273201d-c589-4c57-9d57-ad2affaeade0@samsung.com>
 <20240831005046.5lndwdr7cfm3k3to@synopsys.com>
 <2e678109-8399-48d5-9567-033eab910bca@samsung.com>
 <20240904010322.leqt3pap6lguivg4@synopsys.com>
 <11535d95-c972-4dbe-afb5-de3a44bc4a21@samsung.com>
In-Reply-To: <11535d95-c972-4dbe-afb5-de3a44bc4a21@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB8502:EE_
x-ms-office365-filtering-correlation-id: 16488b4a-32bd-4ee6-976c-08dccd415d0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VnAvc2xzWHZteWNYQXc0NmwydXdaTlV3OWhWVmdVdkJ2VGM1N2tleG5JVzFM?=
 =?utf-8?B?VjR5UE9uZGZJRVljb1NDNmk2TnlxelEvMmxjcC9LV3ZOcUM2SXdzeVJKS2x0?=
 =?utf-8?B?azViSGpFR3dOQzVkbXZQQy9TYmM0L2phcXhkUkdpczM3UTVBOG5DR0RLVURp?=
 =?utf-8?B?bkoreHFrSmVsSjNyL09ZMUk4Mzg0RDJWSkY5Mlg4WWNCMlRtNXR3MC9OeVp4?=
 =?utf-8?B?dXJmK2Vac21rVVl2enNPeTNsNVBXcTVTeWJxd09rWUpQSzB0ZkRtdVVSZk91?=
 =?utf-8?B?eXp0L2lzZGUwVGp1ano0ck5DRDFHdlAxS0xOVXloT0JRL3E3UnpDR3lVTHZN?=
 =?utf-8?B?cldraCtGRmlKUVlmSlZ4WU5xcy9jNS9hV0x6c0xLeDBIMmpLOHVFZ0Qrbk03?=
 =?utf-8?B?UGJEeEs5ck9jci9SSXltajFZRXM3SWVCQW1nMlo5VHhoeDNqM3JCYXpPZmI2?=
 =?utf-8?B?N3ExUk5RbURod3VKeVZMOVMxK0oybVBKVDM1WUpQclBUa05JeCt3VnZhcjFk?=
 =?utf-8?B?QzVsajJJbzNmRzhoVWFTS2EvT0pDNElNeU13ZGQ0NDJXZkZEMnQyUWpSSkVn?=
 =?utf-8?B?TC9KaDRhOVVqamVYcGFvWlViRGtoZHpsYkYxVzZDcHlveU5Sa3dXNUh3eXV2?=
 =?utf-8?B?OFRCSzVsTlRQOFplSWttUmhBZXVydHZwdTZIc3hUME9qR1JFSGJNSkFCbjFZ?=
 =?utf-8?B?WVc0UHQwdmJIMnJBQzRJMUdlMlJPeUxVZVhKN1JoUzlwZ2tZR0o5ejRqVVZv?=
 =?utf-8?B?OGc3NHNWYkp2Z0dYL1pCWHdnSDk4QVpOUjN0QUV3OURhcVM2UmN5S2UvWWhw?=
 =?utf-8?B?YUxXbnM0VkF0NmExdWtSTGNzeW9ZUXFnTEs0azNaR0NkK0RHNXBSWTNPVVhJ?=
 =?utf-8?B?R1I5d29zKzA3b3RGM250OVJ3bk9oOUVOR3pOTTN1cnYvbmNNYTlLRi9rUTNv?=
 =?utf-8?B?OEViMFNhZUZJa1pydzU5akpBcXZTa2JqdDhpRFAzRThFZmxONEhFWDk2Q0lv?=
 =?utf-8?B?NW9KRktLckR5dW9NM3BUcXhnb0JzNGFOaW00Z29xVkZFRjhCVHExeUEzeDdZ?=
 =?utf-8?B?TlBRa3NoT09xTmVQanM4azAzNFFTaFE1WFpaYVBheHVvRXBNaE5KRWpZejhw?=
 =?utf-8?B?TXIxZDNxSG5MRGxBeVg5WS9xaW4yZFBUT3R0QWMwTlFWbnFmK0xCOU8yaVg1?=
 =?utf-8?B?NDQvYjBIRWFUd2ZWb3NSb1lBZ3FMRlN5Q0xWTEowZDlSNXdPQWdKZFh1TDJB?=
 =?utf-8?B?YmFUcjhNNjZGOEpjT2JPZ3ZsSFg5eldFS0NSN2hxUVN5U0VESEV5MWZuTUFq?=
 =?utf-8?B?SDUzSGxFWXhEdmh1Y0Z0Tkc2TFdNU1NnSDZaekc0eVFHeEVCczRNSWFDT1Qz?=
 =?utf-8?B?UzBHTmR5Mk9JM01SK2U2R3lHZGU3Nm1lSTdHdDlyS2RUSWZNZlptUU15MHl5?=
 =?utf-8?B?MWtycklLQzQwYlhHa2RlaHltQ0VWNUlMRWdOMldXRzRkbFB2ejBHRHREM1dr?=
 =?utf-8?B?ZTBLZFN0TXZtK3VFKzNkOTFzVHY4eU5hazFvVndJanE1LzdHckw5SGlsNTVq?=
 =?utf-8?B?c0dWbkdMeWZDazFrb251ZldkTTZic2U5SVNIalVtS2pwaFUyODIwcFk2b0x2?=
 =?utf-8?B?M1ZPa0RmUS9RK0RORkRKb2t6L2o4cjFlQWdJcy9DZnA5R2c3QXhNazVmczVK?=
 =?utf-8?B?elN3VnMrbXZsWXp2VTVJalI5UWNyK213RVdJcS9tcHBhOGhiUHVBTy9pN2V5?=
 =?utf-8?B?c014c0ZPeXQxMnNCdEJ0ZGpQQnZSMTZvTitPN2d3MGRiQ1ZpS3V5MW9Cdllr?=
 =?utf-8?B?RU9ZUmJFcFNvR1ZmR1hOcE9jVUtZMEt6M1E0UllzNFBXK0V6QlkwN21ER01t?=
 =?utf-8?B?ZnNRc3VXYnV4VkQ2djNUYnlhSVBwektiU0tlQlB1STNPZ1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0xGUnNmVVlFQ1l1ci9SODE2N3pqMU9aUmNsbjVzSnUwY3Erb0hsc2xIMG5G?=
 =?utf-8?B?Y2paQVd3T1h4OWpNdnhENHhQblVxY3ZCamh0c0JrOXFFMkxqNFk2VkQ5VXFD?=
 =?utf-8?B?VGlPS0h0czJBaDVhU3dRMmE3QVFXRG1EMDBoRGppR2x0ZEpUZ2s5WFFpeHhI?=
 =?utf-8?B?cS9xNE55SHpEcWtNRU5lYUpwc2JUWU1kRGpoUWhlSWI3eVA1RWJ3dEhqNC9p?=
 =?utf-8?B?THk2UzMrU0w0OEh2V0xlM1hJZWYyOFNqN05nMW0rSGFOM2hobGJuanpIYm8r?=
 =?utf-8?B?VjEyZXJPb2UwYUdXSGV4VW1pWjhCVXNCMFRPdHNEaTAvbHVpeVlRRUJiVEpM?=
 =?utf-8?B?KzhoeUgvcENZYzFpWW9xZW5tSnlycGpOZHA5NkhOcGhXY2NSdEN1YTZ1QzNM?=
 =?utf-8?B?YmNoVHA4UmQrQzJ5YmFoTXJkNGRqMmZidjdMN1Z4MmRPaFRDYVFuRUFqbGhS?=
 =?utf-8?B?cnJIaTRsVzU4aHlScmxESE81d05lMVhONnc3aUIyaXRGcU9iTG8zaE1TODJJ?=
 =?utf-8?B?SWUyK3NaLzVnekt1MFBtbVc3TXloUUFDNVRSSGcrelczU040TmVva05HM3RY?=
 =?utf-8?B?MlpTUWphdzFkK2l1TkdWYmwyVlprNEFOWVVqREIweGtJUThMY0pzUTczVEtq?=
 =?utf-8?B?REpEbmxRQ2hOTVozWEVpTi9DMmdjcnZzM3M1bWxnYzVURC9DVm1sN1JRMk15?=
 =?utf-8?B?MmRXaE9UZkoycDIwTEd5d01Jd1VmeEJPWmdIajNTTEY5TjJ2enp3R3VFUU4x?=
 =?utf-8?B?aHFWWWpNa0poU3NSNi8vdy9kSUNUbDVvWE85SjcvUjlXMndqaXl4WUJtR3M0?=
 =?utf-8?B?VWw5VEJBeXlDZ08rUjhBdGpJb29YQnV4WjhlakpDMkxKZFZTZkVVNzNnS2VG?=
 =?utf-8?B?UWxXWkZoK1R4aWo1K0J5OXhsWEZIUFk3eTVFeW1XQ09IWDRDUjREYzU0TFBJ?=
 =?utf-8?B?RC93ODFQTWN1eE9lUzdMYnZYZUs4dzh2TytMaVk4SUdEeExWbFR0UjA4UlFu?=
 =?utf-8?B?N010MEZEdGhGR1B3djhOdzQ3L0ZCOUtObFl2NGx3bUczMnFaOE5OVno3UmZa?=
 =?utf-8?B?cHFaSzBNS282dU1pazE5eEphTlVtLytrUHp3RysrVC9jYUJWdjNYQjlsYnF3?=
 =?utf-8?B?NzdPdC91T2ZSMGNDdVlRMXJHQUxMOHd3Y0VXMHJkditYdmpmY2ZaQ2dvdURU?=
 =?utf-8?B?WnoyT2JVQ0dpWWtHUVlIRWFOUklrRU1MMWVhNEV1RmNETTFBN2VnWWY0aUdn?=
 =?utf-8?B?UmhqbHBOQWt5TE1Hbmxkekh3V0Vud2hrSHFBNGxsMjBQYmFDMC9LWTFCVXls?=
 =?utf-8?B?VHc0WmZZZm1raTgvVXBBRnNkZFdnTm4wNzV4Yms5OEVPeVE1TDhiYThKeVhL?=
 =?utf-8?B?aEFVaDJBVVJBMThVNXV2SFk4UFhjZVAwVkxsR29HWGV5YzRlUUY3VWt1SjVh?=
 =?utf-8?B?cmxiWXpPQlArWXMwdGpNZTJSQjlTVTZkVjhGdjNNV2JmSGJsbUJaUHl1M01B?=
 =?utf-8?B?emZEeWQyOG9DUnJVNlZ0aWVzRHRrN05CR3NkQndYclFCOTZqM3BkdVFOTlQx?=
 =?utf-8?B?N2tnNTkzeFYvQVBZbUh3R2t4VkZRVEtsQ2VoZ3FCTVFGSk1zdllzRWNnOEZ4?=
 =?utf-8?B?NUJNc1hNVThNcFNGUmJVMUxDVGxIaTZjNHNJZ0x1M1pGRTVweWFpTUFyeTZq?=
 =?utf-8?B?VkprN3BFMEVPbWlncmloYzBnY3E5Mkg3MXZyUnp0WUcrb3hmUEY4UWVWc3hT?=
 =?utf-8?B?UXZiNC9FbVY4YTdQcnFjOEdBZnN3WFcvaVZPaEJyMUFBOG1FajE5WTJWUXpW?=
 =?utf-8?B?UVNTNGVNaWZxOXdrV3JLNzRscTd2ZjRWaWdHQWRFZDVpSndORXo3K2JRQk1h?=
 =?utf-8?B?MlFZMndvWDRzTHBSbHE5N084VXpyVzYxVEhua1hjampmOEZwckV3cHlnMGli?=
 =?utf-8?B?dCtaT1kwYWFzcEJOVTZBRjN0YUJ6SCt3dktEY3orRXRCd3ZvSGxGZHdVMWdT?=
 =?utf-8?B?REEzYmlZbTNCTitJN2lXcGFnM2t0MVN5OFVIWHl2USt2cHdySWdWVkU0TjJL?=
 =?utf-8?B?RnIvV1d2VHNyMXNaQVlHcFNIc2lIMUlZRHhqZWI3WVZlRFI5WUZJNWNrTFdQ?=
 =?utf-8?Q?IyOxg1ae/jGAI7BlMTK/Sth4p?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BEBB7D099484C46B43A444CD937A891@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EbsbF50U/IYBfK0rTV6uFtFqCWwiU4FJYYEL+kA77tIvCeKYfdIwPFSdNLpp3GSEO657VMbYnTFd23ZPI8ftvVZIcTcniK1hL/QsX4NX+ADpv8vSSKZF1bo6yfidWU5sRpPtkX+yP9EjqY+mpF11/wow4QtBUM3wjQPiTAJJTM0nJ4ammprt8GCht978SgPmwojTXLKPUhjAAoGU7N1Uqo0SmAs9wBKP9/W4csImnoISUqebzR7fUo8RpLnW7pNialWiSdh0F2lXOLHI67yhzNhUYDzZ8h+ntrA+ilSZh9vWeUrt3qoAE3+IvhxNhpEAedYU0tpStzue7xBU+QPSvMF6PipseX868oigpobdte62Jd5/HeX3i2JVePuodb5j1dimT0q9kZRH/Y7pm8cOTtLUMX+m2arflzS9B6GGyceR8I/8CXpPjfHaBBvLsSOo2d9pLV6sdOEAqUViBqTe8yI2UX0C2BB1BMMMgmGQTbmpx1EnuqiMAjIjAcU0/v0QoTnj9DhwT6GxV8qxRNP2uOUY1ImaxaG0QeD479kkplchWFbeILZ2O4Z0BxlmLN+iQGg0kZAnWN0ErPgKwIrRp7E6xqM/E7reqp2dcSN7jPLSWe8kY4hTn8iIKmlTsauC6yx8sSTFaRua9glF+TLgBQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16488b4a-32bd-4ee6-976c-08dccd415d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 00:26:19.7430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3HdACJ6dLsI5X9S9XL9vEXXX51SDj6ZA25pDw4xoRjSKMdatr/sAOJfwmUYvvIoUQMpcOr4FT3fnXerNjHDEgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502
X-Proofpoint-GUID: WQtZB_xvsOo8A8guW4Q_prpwvW4vRdoc
X-Proofpoint-ORIG-GUID: WQtZB_xvsOo8A8guW4Q_prpwvW4vRdoc
X-Authority-Analysis: v=2.4 cv=X9YAK3Te c=1 sm=1 tr=0 ts=66d8fab0 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=qDtSe1WEgndmS0A9WgwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_22,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409050001

T24gV2VkLCBTZXAgMDQsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
OS80LzIwMjQgNjozMyBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIE1vbiwgU2VwIDAy
LCAyMDI0LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4gPj4gSSB3b3VsZCBsaWtlIHRvIHJl
Y29uZmlybSBmcm9tIG91ciBlbmQgdGhhdCBpbiBvdXIgZmFpbHVyZSBzY2VuYXJpbywgd2UNCj4g
Pj4gb2JzZXJ2ZSB0aGF0IERXQzNfRVZFTlRfUEVORElORyBpcyBzZXQgaW4gZXZ0LT5mbGFncyB3
aGVuIHRoZSBkd2MzDQo+ID4+IHJlc3VtZSBzZXF1ZW5jZSBpcyBleGVjdXRlZCwgYW5kIHRoZSBk
d2MtPnBlbmRpbmdfZXZlbnRzIGZsYWcgaXMgbm90DQo+ID4+IGJlaW5nIHNldC4NCj4gPj4NCj4g
PiBJZiB0aGUgY29udHJvbGxlciBpcyBzdG9wcGVkLCBubyBldmVudCBpcyBnZW5lcmF0ZWQgdW50
aWwgaXQncyByZXN0YXJ0ZWQNCj4gPiBhZ2Fpbi4gKGllLCB5b3Ugc2hvdWxkIG5vdCBzZWUgR0VW
TlRDT1VOVCB1cGRhdGVkIGFmdGVyIGNsZWFyaW5nDQo+ID4gRENUTC5ydW5fc3RvcCkuIElmIHRo
ZXJlJ3Mgbm8gZXZlbnQsIG5vIGludGVycnVwdCBhc3NlcnRpb24gc2hvdWxkIGNvbWUNCj4gPiBm
cm9tIHRoZSBjb250cm9sbGVyLg0KPiA+DQo+ID4gSWYgdGhlIHBlbmRpbmdfZXZlbnRzIGlzIG5v
dCBzZXQgYW5kIHlvdSBzdGlsbCBzZWUgdGhpcyBmYWlsdXJlLCB0aGVuDQo+ID4gbGlrZWx5IHRo
YXQgdGhlIGNvbnRyb2xsZXIgaGFkIHN0YXJ0ZWQsIGFuZCB0aGUgaW50ZXJydXB0IGlzIGdlbmVy
YXRlZA0KPiA+IGZyb20gdGhlIGNvbnRyb2xsZXIgZXZlbnQuIFRoaXMgb2NjdXJzIGFsb25nIHdp
dGggdGhlIGludGVycnVwdA0KPiA+IGdlbmVyYXRlZCBmcm9tIHlvdXIgY29ubmVjdGlvbiBub3Rp
ZmljYXRpb24gZnJvbSB5b3VyIHNldHVwLg0KPiANCj4gDQo+IEkgY29tcGxldGVseSBhZ3JlZS4g
TXkgZGlzY3Vzc2lvbiByZXZvbHZlcyBhcm91bmQgdGhlIGhhbmRsaW5nIG9mIHRoZSANCj4gRFdD
M19FVkVOVF9QRU5ESU5HIGZsYWcgaW4gYWxsIHNpdHVhdGlvbnMuIFRoZSBwdXJwb3NlIG9mIHVz
aW5nIHRoaXMgDQo+IGZsYWcgaXMgdG8gcHJldmVudCB0aGUgcHJvY2Vzc2luZyBvZiBuZXcgZXZl
bnRzIGlmIGFuIGV4aXN0aW5nIGV2ZW50IGlzIA0KPiBzdGlsbCBiZWluZyBwcm9jZXNzZWQuIFRo
aXMgZmxhZyBpcyBzZXQgaW4gdGhlIHRvcC1oYWxmIGludGVycnVwdCANCj4gaGFuZGxlciBhbmQg
Y2xlYXJlZCBhdCB0aGUgZW5kIG9mIHRoZSBib3R0b20taGFsZiBoYW5kbGVyLg0KPiANCj4gTm93
LCBsZXQncyBjb25zaWRlciBzY2VuYXJpb3Mgd2hlcmUgdGhlIGJvdHRvbSBoYWxmIGlzIG5vdCBz
Y2hlZHVsZWQsIA0KPiBhbmQgYSBVU0IgcmVjb25uZWN0IG9jY3Vycy4gSW4gdGhpcyBjYXNlLCB0
aGVyZSBpcyBhIHBvc3NpYmlsaXR5IHRoYXQgDQo+IHRoZSBpbnRlcnJ1cHQgbGluZSBpcyB1bm1h
c2tlZCBpbiBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAsIGFuZCB0aGUgVVNCIA0KPiBjb250cm9s
bGVyIGJlZ2lucyBwb3N0aW5nIG5ldyBldmVudHMuIFRoZSB0b3AtaGFsZiBpbnRlcnJ1cHQgaGFu
ZGxlciANCj4gY2hlY2tzIGZvciB0aGUgRFdDM19FVkVOVF9QRU5ESU5HIGZsYWcgYW5kIHJldHVy
bnMgSVJRX0hBTkRMRUQgd2l0aG91dCANCj4gcHJvY2Vzc2luZyBhbnkgbmV3IGV2ZW50cy4gSG93
ZXZlciwgdGhlIFVTQiBjb250cm9sbGVyIGNvbnRpbnVlcyB0byBwb3N0IA0KPiBpbnRlcnJ1cHRz
IHVudGlsIHRoZXkgYXJlIGFja25vd2xlZGdlZC4NCj4gDQo+IFBsZWFzZSByZXZpZXcgdGhlIGNv
bXBsZXRlIHNlcXVlbmNlIG9uY2Ugd2l0aCBEV0MzX0VWRU5UX1BFTkRJTkcgZmxhZy4NCj4gDQo+
IE15IHByb3Bvc2FsIGlzIHRvIGNsZWFyIG9yIHJlc2V0IHRoZSBEV0MzX0VWRU5UX1BFTkRJTkcg
ZmxhZyB3aGVuIA0KPiB1bm1hc2tpbmcgdGhlIGludGVycnVwdCBsaW5lIGR3YzNfZXZlbnRfYnVm
ZmVyc19zZXR1cCwgYXBhcnQgZnJvbSANCj4gYm90dG9tLWhhbGYgaGFuZGxlci4gQ2xlYXJpbmcg
dGhlIERXQzNfRVZFTlRfUEVORElORyBmbGFnIGluIA0KPiBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0
dXAgZG9lcyBub3QgY2F1c2UgYW55IGhhcm0sIGFzIHdlIGhhdmUgaW1wbGVtZW50ZWQgDQo+IGEg
dGVtcG9yYXJ5IHdvcmthcm91bmQgaW4gb3VyIHRlc3Qgc2V0dXAgdG8gcHJldmVudCBJUlEgc3Rv
cm1zLg0KPiANCj4gDQo+IA0KPiBXb3JraW5nIHNjZW5hcmlvczoNCj4gPT09PT09PT09PT09PT09
PT09DQo+IDEuIFRvcC1oYWxmIGhhbmRsZXI6DQo+ICDCoMKgwqAgYS4gaWYgKGV2dC0+ZmxhZ3Mg
JiBEV0MzX0VWRU5UX1BFTkRJTkcpDQo+ICDCoMKgwqDCoMKgwqDCoCByZXR1cm4gSVJRX0hBTkRM
RUQ7DQo+ICDCoMKgwqAgYi4gU2V0IERXQzNfRVZFTlRfUEVORElORyBmbGFnDQo+ICDCoMKgwqAg
Yy4gTWFza2luZyBpbnRlcnJ1cHQgbGluZQ0KPiANCj4gMi4gQm90dG9tLWhhbGYgaGFuZGxlcjoN
Cj4gIMKgwqDCoCBhLiBVbi1tYXNraW5nIGludGVycnVwdCBsaW5lDQo+ICDCoMKgwqAgYi4gQ2xl
YXIgRFdDM19FVkVOVF9QRU5ESU5HIGZsYWcNCj4gDQo+IEZhaWx1cmUgc2NlbmFyaW9zOg0KPiA9
PT09PT09PT09PT09PT09PT0NCj4gMS4gVG9wLWhhbGYgaGFuZGxlcjoNCj4gIMKgwqDCoCBhLiBp
ZiAoZXZ0LT5mbGFncyAmIERXQzNfRVZFTlRfUEVORElORykNCj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ICDCoMKgwqAgYi4gU2V0IERXQzNf
RVZFTlRfUEVORElORyBmbGFnDQo+ICDCoMKgwqAgYy4gTWFza2luZyBpbnRlcnJ1cHQgbGluZQ0K
DQpGb3IgRFdDM19FVkVOVF9QRU5ESU5HIGZsYWcgdG8gYmUgc2V0IGF0IHRoaXMgcG9pbnQgKGJl
Zm9yZSB3ZSBzdGFydCB0aGUNCmNvbnRyb2xsZXIpLCB0aGF0IG1lYW5zIHRoYXQgdGhlIEdFVk5U
Q09VTlQgd2FzIG5vdCAwIGFmdGVyDQpzb2Z0LWRpc2Nvbm5lY3QgYW5kIHRoYXQgdGhlIHBtX3J1
bnRpbWVfc3VzcGVuZGVkKCkgbXVzdCBiZSBmYWxzZS4NCg0KPiANCj4gMi4gTm8gQm90dG9tLWhh
bGYgc2NoZWR1bGVkOg0KDQpXaHkgaXMgdGhlIGJvdHRvbS1oYWxmIG5vdCBzY2hlZHVsZWQ/IE9y
IGRvIHlvdSBtZWFuIGl0IGhhc24ndCB3b2tlbiB1cA0KeWV0IGJlZm9yZSB0aGUgbmV4dCB0b3At
aGFsZiBjb21pbmc/DQoNCj4gDQo+IDMuIFVTQiByZWNvbm5lY3Q6IGR3YzNfZXZlbnRfYnVmZmVy
c19zZXR1cA0KPiAgwqDCoMKgIGEuIFVuLW1hc2tpbmcgaW50ZXJydXB0IGxpbmUNCg0KRG8gd2Ug
a25vdyB0aGF0IHRoZSBHRVZOVENPVU5UIGlzIG5vbi16ZXJvIGJlZm9yZSBzdGFydGluZyB0aGUN
CmNvbnRyb2xsZXIgYWdhaW4/DQoNCj4gDQo+IDQuIENvbnRpbnVvdXMgaW50ZXJydXB0cyA6IFRv
cC1oYWxmIGhhbmRsZXI6DQo+ICDCoMKgwqAgYS4gaWYgKGV2dC0+ZmxhZ3MgJiBEV0MzX0VWRU5U
X1BFTkRJTkcpDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIElSUV9I
QU5ETEVEOw0KPiANCj4gIMKgwqDCoCBhLiBpZiAoZXZ0LT5mbGFncyAmIERXQzNfRVZFTlRfUEVO
RElORykNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gSVJRX0hBTkRM
RUQ7DQo+IA0KPiAgwqDCoMKgIGEuIGlmIChldnQtPmZsYWdzICYgRFdDM19FVkVOVF9QRU5ESU5H
KQ0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBJUlFfSEFORExFRDsN
Cj4gLi4uLi4NCj4gDQo+IC4uLi4uDQo+IA0KPiAuLi4uLg0KPiANCg0KSSBkb24ndCB3YW50IHRo
ZSBkcml2ZXIgdG8gcHJvY2VzcyBhbnkgc3RhbGUgZXZlbnQgYWZ0ZXIgYQ0Kc29mdC1kaXNjb25u
ZWN0LiBDYW4gd2UgdHJ5IHRoaXMgaW5zdGVhZDoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCmluZGV4IGNjYzM4OTVkYmQ3
Zi4uYTFlNmJhOTJlODA4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCisr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQpAQCAtNTQ0LDYgKzU0NCw3IEBAIHN0YXRpYyBp
bnQgZHdjM19hbGxvY19ldmVudF9idWZmZXJzKHN0cnVjdCBkd2MzICpkd2MsIHVuc2lnbmVkIGlu
dCBsZW5ndGgpDQogaW50IGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChzdHJ1Y3QgZHdjMyAqZHdj
KQ0KIHsNCiAJc3RydWN0IGR3YzNfZXZlbnRfYnVmZmVyCSpldnQ7DQorCXUzMgkJCQlyZWc7DQog
DQogCWlmICghZHdjLT5ldl9idWYpDQogCQlyZXR1cm4gMDsNCkBAIC01NTYsNyArNTU3LDEwIEBA
IGludCBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoc3RydWN0IGR3YzMgKmR3YykNCiAJCQl1cHBl
cl8zMl9iaXRzKGV2dC0+ZG1hKSk7DQogCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HRVZO
VFNJWigwKSwNCiAJCQlEV0MzX0dFVk5UU0laX1NJWkUoZXZ0LT5sZW5ndGgpKTsNCi0JZHdjM193
cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09VTlQoMCksIDApOw0KKw0KKwkvKiBDbGVhciBh
bnkgc3RhbGUgZXZlbnQgKi8NCisJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR0VW
TlRDT1VOVCgwKSk7DQorCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HRVZOVENPVU5UKDAp
LCByZWcpOw0KIA0KIAlyZXR1cm4gMDsNCiB9DQpAQCAtMjQ4NCw3ICsyNDg4LDExIEBAIHN0YXRp
YyBpbnQgZHdjM19ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogDQogCXN3aXRj
aCAoZHdjLT5jdXJyZW50X2RyX3JvbGUpIHsNCiAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0RFVklD
RToNCi0JCWR3YzNfZ2FkZ2V0X3Byb2Nlc3NfcGVuZGluZ19ldmVudHMoZHdjKTsNCisJCWlmIChk
d2MtPnBlbmRpbmdfZXZlbnRzKSB7DQorCQkJcG1fcnVudGltZV9wdXQoZHdjLT5kZXYpOw0KKwkJ
CWR3Yy0+cGVuZGluZ19ldmVudHMgPSBmYWxzZTsNCisJCQllbmFibGVfaXJxKGR3Yy0+aXJxX2dh
ZGdldCk7DQorCQl9DQogCQlicmVhazsNCiAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0hPU1Q6DQog
CWRlZmF1bHQ6DQpAQCAtMjU3NCw2ICsyNTgyLDEyIEBAIHN0YXRpYyB2b2lkIGR3YzNfY29tcGxl
dGUoc3RydWN0IGRldmljZSAqZGV2KQ0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBk
d2MzX2Rldl9wbV9vcHMgPSB7DQogCVNFVF9TWVNURU1fU0xFRVBfUE1fT1BTKGR3YzNfc3VzcGVu
ZCwgZHdjM19yZXN1bWUpDQogCS5jb21wbGV0ZSA9IGR3YzNfY29tcGxldGUsDQorDQorCS8qDQor
CSAqIFJ1bnRpbWUgc3VzcGVuZCBoYWx0cyB0aGUgY29udHJvbGxlciBvbiBkaXNjb25uZWN0aW9u
LiBJdCByZXBsaWVzIG9uDQorCSAqIHBsYXRmb3JtcyB3aXRoIGN1c3RvbSBjb25uZWN0aW9uIG5v
dGlmaWNhdGlvbiB0byBzdGFydCB0aGUgY29udHJvbGxlcg0KKwkgKiBhZ2Fpbi4NCisJICovDQog
CVNFVF9SVU5USU1FX1BNX09QUyhkd2MzX3J1bnRpbWVfc3VzcGVuZCwgZHdjM19ydW50aW1lX3Jl
c3VtZSwNCiAJCQlkd2MzX3J1bnRpbWVfaWRsZSkNCiB9Ow0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCmluZGV4IDFlNTYxZmQ4
Yjg2ZS4uMmZhM2ZkNTVlYjMyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgN
CisrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQpAQCAtMTY3Myw3ICsxNjczLDYgQEAgc3Rh
dGljIGlubGluZSB2b2lkIGR3YzNfb3RnX2hvc3RfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KICNp
ZiAhSVNfRU5BQkxFRChDT05GSUdfVVNCX0RXQzNfSE9TVCkNCiBpbnQgZHdjM19nYWRnZXRfc3Vz
cGVuZChzdHJ1Y3QgZHdjMyAqZHdjKTsNCiBpbnQgZHdjM19nYWRnZXRfcmVzdW1lKHN0cnVjdCBk
d2MzICpkd2MpOw0KLXZvaWQgZHdjM19nYWRnZXRfcHJvY2Vzc19wZW5kaW5nX2V2ZW50cyhzdHJ1
Y3QgZHdjMyAqZHdjKTsNCiAjZWxzZQ0KIHN0YXRpYyBpbmxpbmUgaW50IGR3YzNfZ2FkZ2V0X3N1
c3BlbmQoc3RydWN0IGR3YzMgKmR3YykNCiB7DQpAQCAtMTY4NCwxMCArMTY4Myw2IEBAIHN0YXRp
YyBpbmxpbmUgaW50IGR3YzNfZ2FkZ2V0X3Jlc3VtZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KIHsNCiAJ
cmV0dXJuIDA7DQogfQ0KLQ0KLXN0YXRpYyBpbmxpbmUgdm9pZCBkd2MzX2dhZGdldF9wcm9jZXNz
X3BlbmRpbmdfZXZlbnRzKHN0cnVjdCBkd2MzICpkd2MpDQotew0KLX0NCiAjZW5kaWYgLyogIUlT
X0VOQUJMRUQoQ09ORklHX1VTQl9EV0MzX0hPU1QpICovDQogDQogI2lmIElTX0VOQUJMRUQoQ09O
RklHX1VTQl9EV0MzX1VMUEkpDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCmluZGV4IDg5ZmM2OTBmZGYzNC4uYTUyNWY3
ZWE1ODg2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KKysrIGIvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYw0KQEAgLTQ0OTAsNiArNDQ5MCwxNyBAQCBzdGF0aWMgaXJx
cmV0dXJuX3QgZHdjM19jaGVja19ldmVudF9idWYoc3RydWN0IGR3YzNfZXZlbnRfYnVmZmVyICpl
dnQpDQogCQlyZXR1cm4gSVJRX0hBTkRMRUQ7DQogDQogCWNvdW50ID0gZHdjM19yZWFkbChkd2Mt
PnJlZ3MsIERXQzNfR0VWTlRDT1VOVCgwKSk7DQorDQorCS8qDQorCSAqIElmIHRoZSBjb250cm9s
bGVyIGlzIGhhbHRlZCwgdGhlIGV2ZW50IGNvdW50IGlzIHN0YWxlL2ludmFsaWQuIElnbm9yZQ0K
KwkgKiB0aGVtLiBUaGlzIGhhcHBlbnMgaWYgdGhlIGludGVycnVwdCBhc3NlcnRpb24gaXMgZnJv
bSBhbiBvdXQtb2YtYmFuZA0KKwkgKiByZXN1bWUgbm90aWZpY2F0aW9uLg0KKwkgKi8NCisJaWYg
KCFkd2MtPnB1bGx1cHNfY29ubmVjdGVkICYmIGNvdW50KSB7DQorCQlkd2MzX3dyaXRlbChkd2Mt
PnJlZ3MsIERXQzNfR0VWTlRDT1VOVCgwKSwgY291bnQpOw0KKwkJcmV0dXJuIElSUV9IQU5ETEVE
Ow0KKwl9DQorDQogCWNvdW50ICY9IERXQzNfR0VWTlRDT1VOVF9NQVNLOw0KIAlpZiAoIWNvdW50
KQ0KIAkJcmV0dXJuIElSUV9OT05FOw0KQEAgLTQ3MzUsMTQgKzQ3NDYsMyBAQCBpbnQgZHdjM19n
YWRnZXRfcmVzdW1lKHN0cnVjdCBkd2MzICpkd2MpDQogDQogCXJldHVybiBkd2MzX2dhZGdldF9z
b2Z0X2Nvbm5lY3QoZHdjKTsNCiB9DQotDQotdm9pZCBkd2MzX2dhZGdldF9wcm9jZXNzX3BlbmRp
bmdfZXZlbnRzKHN0cnVjdCBkd2MzICpkd2MpDQotew0KLQlpZiAoZHdjLT5wZW5kaW5nX2V2ZW50
cykgew0KLQkJZHdjM19pbnRlcnJ1cHQoZHdjLT5pcnFfZ2FkZ2V0LCBkd2MtPmV2X2J1Zik7DQot
CQlkd2MzX3RocmVhZF9pbnRlcnJ1cHQoZHdjLT5pcnFfZ2FkZ2V0LCBkd2MtPmV2X2J1Zik7DQot
CQlwbV9ydW50aW1lX3B1dChkd2MtPmRldik7DQotCQlkd2MtPnBlbmRpbmdfZXZlbnRzID0gZmFs
c2U7DQotCQllbmFibGVfaXJxKGR3Yy0+aXJxX2dhZGdldCk7DQotCX0NCi19DQoNCg0KLS0tDQoN
ClRoYW5rcywNClRoaW5o

