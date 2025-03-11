Return-Path: <linux-kernel+bounces-557078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B82B7A5D351
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9280189DE49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505BD2356A1;
	Tue, 11 Mar 2025 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uOngPwme";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RdgpsEVP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GyA2aWkO"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD527233D85;
	Tue, 11 Mar 2025 23:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741736708; cv=fail; b=OOPb5kg01hfifytLGduUj8mhwh8pR0MsU6mycXAHBX44z1/DK3TteMBA3qWLKJkinaLf9xnI38plKCHbUFoYgjaWnkDg7bekp3FBlGtv+OOgPxf/61W/Yks8RP9KR8Zier35eJUTUetF31aLLXeChVvHS4OkShdgiYWE9thob9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741736708; c=relaxed/simple;
	bh=g1cxOiegttvqs9qKqjKC5PXSijAHvVVh6NVF9/Rr0xw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tH87o9jzV++ylFEvVqofiIldzRqaoiH3eVzGqam+mX40kHcojj5uTrXVk85iTZN4fRkxcbduYWBp9jvzj9mNRiczVCK8ZSXF1JT5pG7IprRotegoabzWFBz003dge0obXg3Vpvd4/chhHUU/qgul71GuBOncEYteqNZZTIoTdDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=uOngPwme; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RdgpsEVP; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GyA2aWkO reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BJBlAP012026;
	Tue, 11 Mar 2025 16:44:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=g1cxOiegttvqs9qKqjKC5PXSijAHvVVh6NVF9/Rr0xw=; b=
	uOngPwmecNd5RIDqGPWIOuUGAtu3VNfBu7g5z0mUbgKGHRdDt7kxkppD2k4sTu5C
	NPr3XSvh2e2Sp055TRiV8fyi1iyiJpuFIPYSdaTmOfJLZNfbQ0C8eJyEV049qEQt
	ebzzEWQQkqT0tup9GYxcso1UClUWX4R3Yc/iI2CNntgsZ8GuqEPyUoAfDtLW0CXb
	9oUtACcjYJrK47BALp/es5n0KsqMYmxRQG7Dl6P+Hv1b+ja/lkhiF4fH9JOfEZjV
	UEQj0B912eV/ehdiJBQjtAzu5yElk5dAs6El3BuPqPfvoTyZGtq2Bxcb5zr/MjbB
	Z7LgMGBp9exSGXpysNDZPw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 45au4b1bqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 16:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1741736696; bh=g1cxOiegttvqs9qKqjKC5PXSijAHvVVh6NVF9/Rr0xw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=RdgpsEVPIsBvw+mVwXDp2TU8IEyBNM5yGy8GQeHeK+Kg5KNNSqYXWsqiRISqUvY8j
	 1b6YbvzHBpR2tfF6IsArZwxLHFJX6NCz1UEXu7UUdQjBfR5pq+KAPkRON2+3JVgd6w
	 wygswYFSnjxyYZ+psxZfpGJx6ybB9daCklHXbbgQ3xjubNizG2+bCFX8/mwYRUqhSk
	 YBlnOgS8DbFtfxaLcvqSet/vm2GEBP7JpLKThbj1BS0j6PTRsUWPCzFTYWkjBC8HhK
	 +u2cPAbEcT5AvQuB9eN10ZoSSKpN68NXeH4caD8hnnbwYiW/OzGSpnxmNiSU9hyUoe
	 qhtYSB6vlYGgw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 03B2540352;
	Tue, 11 Mar 2025 23:44:55 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id CB046A011B;
	Tue, 11 Mar 2025 23:44:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=GyA2aWkO;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 10F98406CF;
	Tue, 11 Mar 2025 23:44:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U32x+3OvU6metVqwQZNQd6OS7nqyFr++ALfDLwwLxNSjH8VwW9ua32KhUwFtOW7TgN9NRGhoFOf/8DUjDL88hIYq5todF94ZqtdQ/bwXJePEFRPvlKzDQoCa3metmCm3xO81Mrt46UVrviEBx8eNxwRkU34seGpgUu3C+HZ54x9oq45pPLKIHPh1AJNkY62Ubg6RjFtQuvv0c+iX5IOYuvoNsocem1ndXHYmWwu7AJD81rdHQRp1EQd5ODcLFLncjHfJyfVUfeUHbjqVoM47TZ51AKLwXXfN45AQaeBrMibKHqejZ6YiqXS3SpM+9iuDhg0nCBc4jwdi/IfCoCUESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1cxOiegttvqs9qKqjKC5PXSijAHvVVh6NVF9/Rr0xw=;
 b=ocq80a2RH05gvdQWit9ScJsRzxB5pfo4poiFBqHXMMOwPH56Bo0EXw6r6aumgxR9sDQE0REIeFXriRDp2VD8I2lMMYS8w2y1b0E3BQPMsV9vHgNrAEi5KXOJX7yAK+p++GSWP57gIG1WWD2E+CYMCawO434CoO5ARfBGw5TwvBBvQEjyo+xe1wMDmznZ9zCDEWK5jnYcaFqaUQt0GZT/NtzidFij1DGuMbXlQ/GGcjl4b9H5h+MFE0t4s1wXToTDd6/nITucaHORRi+4WYMXvRpXJeqJcGnuXEd7iwBNqWgPRul3q+k/M0zL3pxiB/otZkq052kodPy0l084Q6D69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1cxOiegttvqs9qKqjKC5PXSijAHvVVh6NVF9/Rr0xw=;
 b=GyA2aWkOgo1NrTpP2Daj+CbYyZXmUdnV208XXBSYwXUORrzQCFc4ZaFLL+Hoqhph8q6xCdeKvSXzb6nVPvlwMoJt4dP8/PT13XK9Vm9Hsk3djA5+b9YnPxLXRmuWOEVLssLkT25gSn50NZuIkeAGoIEXTxH0h3UjNZBkF+nq51I=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 23:44:50 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 23:44:50 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roy Luo <royluo@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] usb: dwc3: core: Avoid redundant system suspend/resume
 callbacks
Thread-Topic: [PATCH v1] usb: dwc3: core: Avoid redundant system
 suspend/resume callbacks
Thread-Index: AQHbjJkfO2ONbJJIu0CfZmqfULn61LNocsyAgAUXuICAANtdgIAAQAQA
Date: Tue, 11 Mar 2025 23:44:50 +0000
Message-ID: <20250311234436.dtpkfvnwuwqhw5jr@synopsys.com>
References: <20250304000458.1826450-1-royluo@google.com>
 <20250308010409.n55ivdubj7ylkr7j@synopsys.com>
 <CA+zupgzB2aKRn_KDcqSLctqmvnEW1923XQPDwDzfDVZxU70ORg@mail.gmail.com>
 <CA+zupgzw0Fr-PHzj0PPRQGuvxB+py0EMseiToq5iPKe=iRNtgg@mail.gmail.com>
In-Reply-To:
 <CA+zupgzw0Fr-PHzj0PPRQGuvxB+py0EMseiToq5iPKe=iRNtgg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB8285:EE_
x-ms-office365-filtering-correlation-id: 5135da78-c361-47c2-e583-08dd60f6b706
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXhTZUN4NGZva2k0Rm9YTVk4RExTdjViYlRFa29UM3JSdGQ5U3NMcXBFTDY2?=
 =?utf-8?B?cnNQandQbzJoSWhrb0wwWjVSK2twTkQ2bU52TzA1TXBnWmg1eVJnSFYvVUgw?=
 =?utf-8?B?UWVDQ0JmdEZteXl5b1hxWHVyUDkxWWkyQ1BmdWZIYWRKbHMxWVpldHpXYXpw?=
 =?utf-8?B?TjNMMmdGbWVlS1VRWCtjbjZPT1M3OElpWjU3a1ZYUkduT09rdFRFb1ZoRkNr?=
 =?utf-8?B?TlgxeFdRRFBXOGZBYmVkc051ZmZITkdGVWlTNUJLbkVHMkJkWFJoSEhZTzIy?=
 =?utf-8?B?N0prVG94UFkvT0lmajh1N1hKTTFzbUpBVk4vOGpxODVEZnBWL1JLdEU1clRz?=
 =?utf-8?B?UERkZFhSSVBUU0ZiejJhRklsdElpTjVGSkxXYlNYNXRsMlMrZjZUaUFiamtv?=
 =?utf-8?B?Z1EwMWJwczl2bGRta3o2N1p4SytWVzNYZTFuUHl6Y1FuWFVaWGlRYnBsMzJk?=
 =?utf-8?B?aW5mZG41YWJ3T1h0OEdEeGRxcmNucUl4cldEcm9uNlR5VEhOZkNMdjNXb2ho?=
 =?utf-8?B?UTdmYThaSFI5VzBYbXRWbjBzSGhNdG5seHRSZW1IQmtLQmlncm05WjYyYlZI?=
 =?utf-8?B?NnFPbUNEallsbkhwTUJhbGN1UXBFOVlxQk10K3ZJZURiUlYyMUpyT2taZGVG?=
 =?utf-8?B?dFFwb3BxZzZQbTl5KzlSVDFiSVRublVXL0J4T2Q4cU5QUndTYXNNNkhkRE5E?=
 =?utf-8?B?d0g2am00eEhYV2Fqcm5VWXRBdW1CYVFJUWJHUW5SZ0IwWGpHbHFYMXYrK2gx?=
 =?utf-8?B?bWpuaW4wbHdXeWplTmFsekN1amJ4bTgzcjgxb2pHTm9DOUpycnhZSklCbjlV?=
 =?utf-8?B?WlVybW1HNHllTnpZY1dFT0c0a1hROStwWlJHaHhOc0p1NWozM2pGRmNkTThR?=
 =?utf-8?B?b2J3ME9FMy84NGlFaUNQYnVKT21oTGsvQ3dMR0h6RTQ1UFEzazZKck0rWWJx?=
 =?utf-8?B?OHl0Y3hiMDZ0cC9XTlNtbUREWUdLNGxWbW53NllyZ2dYYmdJeGhaY2lmNE5u?=
 =?utf-8?B?b3ErWlZSMmRxVFpVNjFxM0h0M1hIMWdxWUlBbTdjbzU1REREZTFYaFhFVHZ4?=
 =?utf-8?B?b3RzTTBGYTVERHorazB1cUJjemlremJ0ZjU5R0gzMnQyZytncmt0TnVaS3BU?=
 =?utf-8?B?eEdCbjF5QVgwMmNhekY5MlArRUhPb2lnOWh5b2M0aE9ONlNDN2tYNHFXNWkz?=
 =?utf-8?B?VC9SakdOTzd3eUE0eEw2M3V0TGRSZHlkb3BobnFJNVZTbVBQTXpibjU1cDQ1?=
 =?utf-8?B?azlkY05RQStNcUE4K3U2THpLN09taDZIUThUZUcxbjZPTi9rZE9tNzR6VW4r?=
 =?utf-8?B?R2xhRWsvU0ZISUVTalRrUXZDWjh5NUlUL0V2VWVjZGRVYW5VdG12eEp4SFpn?=
 =?utf-8?B?R0NYb29xTmEzKzdId3Z2N3lkRC9KM0h2dGtJZ29ZUXBQajBYRk9qdG9MNWFP?=
 =?utf-8?B?ZkVJaXJkaFhGaW1FRUxnU3F1c0huOW96c2o3aXlsLzFSZkh1eTJ2Mi9OeCt4?=
 =?utf-8?B?TFA2QzBzKytoL0c5MW5PeWJlZk9aanE3Qnd3R3VtUW9uNFJGNk1OSTlKR1Iy?=
 =?utf-8?B?NGZVSUVpcWhwYlgzdDFMRnZIbTg2RnVLZFk4ZFZ1enF3QWVNdnhVRkdFV2Yw?=
 =?utf-8?B?MUdLNWtWWnJLMmRnVDJ0Y0JuSE1iS0YxZG9qeG5kUC9qWXBQUHp5RE0wQVlt?=
 =?utf-8?B?UGNaaWRXQ1I4K3Nud3JPS1JMTTMvcmpPZ0N3WTduak14OWJZMnY2WnkyYlpC?=
 =?utf-8?B?UnNOaHg3bzB2ODZDNWdqQUdFZWZ4clA0Wk1WeEwwWjk3QkF2MGlxdFUvcnFa?=
 =?utf-8?B?MkcyLzV0OGVYTnhYbXB0ckNxdmVteDBrZitreEhHcVVkWUxCU2RSWjlGNEE5?=
 =?utf-8?B?NjJ3S0FBSTdKODFiMFFKNlJ6LzlsbTRidkRFTWZLYVFyZ3BPL1czQ1R4Mlll?=
 =?utf-8?Q?kwgCamd8xHidZMoFqCpS6OcTFQYKOCem?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0IyZFhEdVUyMHQ3Zmx0VUFjSTZ4dS9rSEtHZDJ0OUVVa3B6MnVqV0ZOZFU5?=
 =?utf-8?B?b2tNMjdQMHdOY0JVZ3dNWURrbHVxbjhEZzZkbVRYRmdxWkdSY2krWnZVK29o?=
 =?utf-8?B?azdINk8zMW1TQVZZY2o0ZFJSNWtXRHZ4WHhXL2hXRE1pY2dkVnh4Mk9LSEg0?=
 =?utf-8?B?UGZvcXdram1hRGlnNUdpMWhMWTNRQTVSSU9nWXl0bGQzY3FnRnJqM3NSZGNp?=
 =?utf-8?B?Nzg2MmkvTTJDbndBTUhRQk12YWhNaVBPV0JxMFpOS0tKQ3h3WjNmQnA2STJh?=
 =?utf-8?B?K3NtV254YUtkL1NVQzdSTWNZQWZZbUJhVldRRXFudFY4SHpqNUp4KzNJMjBk?=
 =?utf-8?B?T0NDZ0ViWC9FcGoyTWVHSlhQem1Cakl6bHkzT3NZbGs4UURHTHUxalJxOTRh?=
 =?utf-8?B?RkZqYThIN1NLZVZrMGZ3azJJQUE2dEQ1UUZ5VjE2bzliTHNEWWRLVzN4T0hz?=
 =?utf-8?B?SG1YbXJVZm5ydVZmMDJHVEJJam5DdkhqV053MHpwM1NjZEVpQ0RzaFRpYWgy?=
 =?utf-8?B?eEc0b3NzcFA3a0xKaWpzbWNMWWtsWHFCQzFWMkxobUV3a1BpdWhaSlVvUEI2?=
 =?utf-8?B?TVNaTXJMTm1laU1RS3N3U1N0eU9Ydm9lb3R0TmZmZThmYTJFS0MyUDhIOWRR?=
 =?utf-8?B?ZC9YYlRjbDM0R09MQ0dvYm9xeFRaVWQyNU5yc1V6L2trcjlKUEwrZ1VMbG5z?=
 =?utf-8?B?dEluOEpRUG5zTE1aQ3crVGpGTzd5ZmxqNkRNczR5UzFML3UxWXQ5RGpLd0gx?=
 =?utf-8?B?aUt2MmFob295ZU9SOW5MTWU2eHk2c0k2VWYrNGErbGQrT1pNN2lYQWpCMFUz?=
 =?utf-8?B?dlNJczFyODJWN0NvUThpd01za3BERnZKcXM4bGxqbHA3d2ozVFFiS2tmSWxv?=
 =?utf-8?B?RWNsc3dCcDJrR0ppRVdsaU8wUENvVCtLOEJvdEpGRTJJQXBGNXNFZXAySWps?=
 =?utf-8?B?WDhmT1QyMEQySHRSMU9zVUpvdXBMTWJ4c1M5L0hGeWFRa3puKzhYWDludEhh?=
 =?utf-8?B?RXQybHpNQXNOTVRxZmRmRnhveTZ4Sm1oWDR2Z2pDM1FDc0J5VHN4T24zRmhk?=
 =?utf-8?B?MkVwSHB5dWN1Wm5KME8vTXIwdXBTUHF5SzEzbWkrejJkRkNvR0lQSVpPelpz?=
 =?utf-8?B?QVpmV2VkZ0JFT2tmOGxlOEdnL3N5Tll4T0xxa0E1VjhqbWNkam1MTkpoaG9m?=
 =?utf-8?B?NnRoOGRDRm5VUDlrcTF5ZjVBWURXcTl5RFdCMS9KZ3YrUGhSWHFLQjZUT0lT?=
 =?utf-8?B?YjRLUEI3YlZEV09ndGlDMUs4WWZUOTE2WWxJRmRSQzNJY1p3ODhCV3BBVFAy?=
 =?utf-8?B?YmI2d09sb00venJJMnFkanp2bkJBZmxNZXcrUVdtdHdac3lORDh6MEFuN3NO?=
 =?utf-8?B?cllRWmxiUm0xbW5KdE0xb05wSTNmaVNRQ2lmNFQ0S2FpNXFUL21DbWRYQUQx?=
 =?utf-8?B?Vnpja1RFTnNuYzg2dmxzYklGSWUyS2pKbmZCNXAyWFkyNzFJTmcyZmt1UjI2?=
 =?utf-8?B?S0p4RGZZUUtHV3pDLzZHM0VSdnJDNXdjYy9MOWZJSjltZnVCZHRYZFRNQlVt?=
 =?utf-8?B?eDZLK1Z2L25iOGs1QmhmamlUWWUwaXJqQnROelVHVm9IRENTTFB3NWIzaEdy?=
 =?utf-8?B?K1g2Rk5MTUVpNFFrUmdsUktWTXlQcFh6S3F1TDVDNTltYmx4bGQ2MUM5SzBL?=
 =?utf-8?B?Z3dNVG1zL0YwUkgwcFpDbUZXcjl2M1dKeHNIblIzK0tiTU5qL0l4ak4zQUJX?=
 =?utf-8?B?c2pML3pOWE5IaWIwaytkNkQ5ZkhhMFJkbXRydHN5RTVsQ3ZhT2FPNXc3Mm50?=
 =?utf-8?B?RTRJaXFOUnNQV1Zid2RhbmxOVFlkdHNNMmdCWW9WVStVUVhpUzdibnROMzAv?=
 =?utf-8?B?MlFxT3Z2L204OXhuQ2h4WEZMS245MkcrTVRQV3N3cDVtU1NGRnVzN05RNE1Y?=
 =?utf-8?B?Ny9mYm9MUEo1K1l5MW5LajJzeGVDYWxIcHhMZVRtS0l6V3VuR2gxcnlJWnJS?=
 =?utf-8?B?YXdBVEN5enlmclk1QkRBaEl4REVuMjBjN2JybHZ1QzA3aDJlMzlrem1vZldL?=
 =?utf-8?B?bytBaWxMcy9jVnlFN0lWQWNvSDZtU1p1a0E5ZUZkVDhMaEtuUUlqNUl2NWNU?=
 =?utf-8?Q?6Wg0ri73O43u3g2TisQkhp487?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC7712EC3C001E40A634B02E85D6603E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+TPuLH5sc5nsFM0jr+RYloqy2xneTIljCp7/4GZ23dZ3GhP0svZkcjlEDbrh0K6KLmvsrAKhQ5AB5nBWcyk8BDkGmgtHrNWC044YroFGMZCdEerxnDwb0Q4Gx449avOpenf17elswELKJ1NHYgYMchkbYHMeTZb/Tq0wh4XvKBVe2eQKANjqhok3MMjmwUlmLxqsDCnMczKjEfNdXFqpj37znpNsYKTm/Pii+EmtUWARUbP+bCo2kIVRupbm2oz5KbnfxlwS4/a6EYbbakmVIrNrWE7+hUidU34x4myx+mnr25TGXRhALyonj2OYpFMrTH19k5rQ8plX7FXIbbmbTMHVW9IzgDHqUERZ3GIDi48Oxtq9mQhn7GXu3PohnN7/tT2bK1a4HxVEAkhWpYo7+D9x7c7PA9TG/s8CkpE3mw9jJvqPLbJrsAK335+Py38IriErCARVLFYW80la2mYx7EJBDiwqh1aPesBiFO6fkBCtdDCi9oKUHxcS1q/9vS+EhUTHsvjXg5bL9MKQHHt97YoAP9Z+QaieM1CYyH9aY31VAyj+340V5VeWk1IKkWpkUbt1T4qDYZTxcQhPFd1alooXyMLI5XEGIEMZ2lusxHiBJztiXsaRJ6JV80wFzbRX7qyYfiq4WvIdnrvDi2kagg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5135da78-c361-47c2-e583-08dd60f6b706
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 23:44:50.4882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQoI1V3CWM5z1rceMEL2db4Gk7wGKpnkjKXD80K5PMCrK+VRLJyRtaI1bCXYDcY4cs73IVVnHj3JEJjJL15fkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
X-Authority-Analysis: v=2.4 cv=ctubk04i c=1 sm=1 tr=0 ts=67d0caf8 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=jIQo8A4GAAAA:8 a=n5ya6kK5oNX7lHAxAAMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8vx-TauJgajsS-rkJlEHh7ZK1KCncbKc
X-Proofpoint-ORIG-GUID: 8vx-TauJgajsS-rkJlEHh7ZK1KCncbKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_07,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503110157

T24gVHVlLCBNYXIgMTEsIDIwMjUsIFJveSBMdW8gd3JvdGU6DQo+IE9uIEZyaSwgTWFyIDcsIDIw
MjUgYXQgNTowNOKAr1BNIFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4g
d3JvdGU6DQo+IA0KPiA+IEknbSBhbHNvIGEgYml0IGNvbmNlcm50IGFib3V0IG1vdmluZyBwaW5j
dHJsX3BtX3NlbGVjdCogdG8gdGhlDQo+ID4gc3VzcGVuZC9yZXN1bWVfY29tbW9uIGZ1bmN0aW9u
LiBJcyB5b3VyIGRldmljZSB1c2luZyBwaW5jdHJsPyBJZiBub3QsDQo+ID4gaG93IGRpZCB5b3Ug
dmFsaWRhdGUgdGhpcz8NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBUaGluaA0KPiA+DQo+IA0KPiBJ
IGNvdWxkbid0IGZpbmQgYW55IGRldmljZSBub2RlIHRoYXQncyBhY3R1YWxseSB1dGlsaXppbmcg
dGhlIHBpbmN0cmwgInNsZWVwIg0KPiBzdGF0ZSBpbiB1cHN0cmVhbS4gSSBkaWdnZWQgaW50byB0
aGUgcGF0Y2ggdGhhdCBpbnRyb2R1Y2VkIHBpbmN0cmwgdG8gZHdjMywgaS5lLg0KPiBodHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzlkZDcwODcw
Y2ZlZTQwMTU0YTM3MTg2ZDRjZjNhZTBlOWE0NTJjYmQuMTQ0MTAyOTU3Mi5naXQubnNla2hhckB0
aS5jb20vX187ISFBNEYyUjlHX3BnIWNoS2JFNE9WV0JHSUVRbkhtajduLVZGSUthaXlqZ2RKU21Q
N2xxTXgxTjRwVDFncEl6X3FZTWlJX3ZTd0NSYTZJek1ISjQxZXE5d2tOM044SEU0JCANCj4gVGhl
IGludGVudGlvbiB3YXMgdG8gY29udHJvbCBEUlZWQlVTIHBpbnMgdXNpbmcgdGhlIHBpbmN0cmwg
QVBJIHNvDQo+IHRoYXQgVkJVUyBjYW4gYmUgdHVybmVkIG9mZiB0byBjb25zZXJ2ZSBwb3dlciB3
aGVuIGRldmljZSBpcyBzdXNwZW5kZWQNCj4gKHdoaWNoIGFsc28gaW1wbGllcyB0aGlzIGlzIG9u
bHkgcmVsZXZhbnQgaW4gaG9zdCBtb2RlLCBhdCBsZWFzdCBpbiB0aGUgaW5pdGlhbA0KPiBwYXRj
aCkuIFNpbmNlIHRoZXJlIHdhcyBubyBydW50aW1lIFBNIHN1cHBvcnQgaW4gZHdjMyBhdCB0aGF0
IHRpbWUsIHRoZQ0KPiBjb2RlIHdhcyBvbmx5IGFkZGVkIGluIHRoZSBzeXN0ZW0gc3VzcGVuZC9y
ZXN1bWUgcGF0aC4gWWV0IEkgZG9uJ3Qgc2VlDQo+IHdoeSB0aGlzIGNhbm5vdCBiZSBleHRlbmRl
ZCB0byB0aGUgcnVudGltZSBzdXNwZW5kL3Jlc3VtZSBwYXRoLA0KPiB1bHRpbWF0ZWx5IGl0IHNo
b3VsZCBiZSBzYWZlIHRvIHR1cm4gb2ZmIFZCVVMgb25jZSB0aGUgY29udHJvbGxlciBpcw0KPiBj
b21wbGV0ZWx5IHRvcm4gZG93biB3aXRoIGR3YzNfY29yZV9leGl0KCkgcmVnYXJkbGVzcyBvZiB3
aGljaCBzdXNwZW5kDQo+IHBhdGggaXQncyB0YWtpbmcuDQoNCklmIHRoaXMgcGluIGRyaXZlcyB0
aGUgVkJVUywgY2hhbmdpbmcgdGhpcyB3aWxsIGFsc28gY2hhbmdlIGhvdyBvZnRlbiB3ZQ0KdHVy
bmluZyBvbi9vZmYgVkJVUy4gVW5mb3J0dW5hdGVseSwgSSBkb24ndCBrbm93IGVub3VnaCBhYm91
dCB0aGVzZQ0KcGxhdGZvcm1zIHRvIGtub3cgd2hldGhlciB0aGlzIGNoYW5nZSBtYXkgaW1wYWN0
IGl0cyB0aW1pbmcgYW5kDQpzdGFiaWxpdHkuDQoNCj4gDQo+IEJlc2lkZXMgbG9va2luZyBhdCBo
b3cgcGluY3RybCBpbiBkd2MzIGlzIGludGVuZGVkIHRvIGJlIHVzZWQsIEkgZGlkDQo+IGFuIGlu
dmVudG9yeSBvbiBob3cgaXQgYWN0dWFsbHkgaXMgdXNlZC4gVGhlcmUgYXJlIDMgbWFqb3IgcGxh
eWVyczoNCj4gdGksIHFjb20gYW5kIHNvY2lvbmV4dCB0aGF0IGhhcyBwaW5jdHJsIHByb3BlcnR5
IHNldCBpbiB0aGVpciBkd2MzIGRldmljZSBub2RlLg0KPiAxLiB0aS9vbWFwDQo+IFRoZSBwaW5j
dHJsIHByb3BlcnR5IGlzIG9ubHkgc2V0IHdoZW4gZHJfbW9kZSBpcyBob3N0IG9yIG90Zy4NCj4g
T25seSB0aGUgImRlZmF1bHQiIHN0YXRlIGlzIGRlZmluZWQsIG5vbmUgb2YgYm9hcmRzIGhhcyAi
c2xlZXAiIHN0YXRlDQo+IGRlZmluZWQsIG5vdCBldmVuIHRoZSBmaXJzdCB1c2VyDQo+IGFyY2gv
YXJtL2Jvb3QvZHRzL29tYXAvYW00Mzd4LWdwLWV2bS5kdHMNCj4gdGhhdCBpbnRyb2R1Y2VkIHRo
ZSBBUEkgdG8gZHdjMy4NCj4gKGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvNGE4YTA3MjAzMGMyYTgyODY3YzY1NDg2Mjc3MzkxNDY2ODFiMzVh
NS4xNDQxMDI5NTcyLmdpdC5uc2VraGFyQHRpLmNvbS9fXzshIUE0RjJSOUdfcGchY2hLYkU0T1ZX
QkdJRVFuSG1qN24tVkZJS2FpeWpnZEpTbVA3bHFNeDFONHBUMWdwSXpfcVlNaUlfdlN3Q1JhNkl6
TUhKNDFlcTl3a2ZkNzd6TWckICkNCg0KSG0uLi4gdGhpcyBsaW5rIHRvIHRoZSBwYXRjaCBhYm92
ZSBzZWVtcyBuZXZlciBtYWRlIGl0IHVwc3RyZWFtLg0KDQo+IFNldHRpbmcgcGluY3RybCAiZGVm
YXVsdCIgc3RhdGUgc2VlbXMgdG8gYmUgcHJldHR5IGNvbW1vbiBpbiB0aS9vbWFwLA0KPiBhbmQg
dGhlIHVzYWdlIGlzIGFsaWduZWQgd2l0aCB0aGUgb3JpZ2luYWwgaW50ZW50aW9uOiBjb250cm9s
IERSVlZCVVMuDQo+IEl0J3MgdW5jbGVhciB3aHkgInNsZWVwIiBzdGF0ZSBpcyBubyBsb25nZXIg
dXNlZCB0aG91Z2guDQo+IA0KPiAyLiBxY29tDQo+IFRoZSBmb2xsb3dpbmcgMiBib2FyZHMgaGF2
ZSBwaW5jdHJsIHByb3BlcnR5IGRlZmluZWQsIGRyX21vZGUgYXJlIGFsbA0KPiBob3N0IGFuZCBh
bHNvIG9ubHkgdGhlICJkZWZhdWx0IiBzdGF0ZSBpcyBkZWZpbmVkLg0KPiAtIHNhODE1NXAtYWRw
LmR0cyAgJnVzYl8xX2R3YzMgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHJf
bW9kZSA9ICJob3N0IjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCI7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwaW5j
dHJsLTAgPSA8JnVzYjJwaHlfYWNfZW4xX2RlZmF1bHQ+Ow0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ1c2JfMl9k
d2MzIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRyX21vZGUgPSAiaG9zdCI7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1
bHQiOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGluY3RybC0wID0gPCZ1c2Iy
cGh5X2FjX2VuMl9kZWZhdWx0PjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07
DQo+IC0gc204MzUwLWhkay5kdHMgICZ1c2JfMl9kd2MzIHsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZHJfbW9kZSA9ICJob3N0IjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcGluY3RybC0wID0gPCZ1c2JfaHViX2VuYWJsZWRfc3RhdGU+Ow0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiBJdCBzZWVtcyB0aGUgcGluY3RybCBpcyB1c2Vk
IHRvIGNvbnRyb2wgcGh5IGFuZCBwZXJoYXBzIGRvd25zdHJlYW0gdXNiIGh1Yi4NCj4gTm90aGlu
ZyBpcyB0dXJuZWQgb2ZmIGV4cGxpY2l0bHkgZHVyaW5nIHNsZWVwIGFzICJzbGVlcCIgc3RhdGUg
aXNuJ3QgZGVmaW5lZC4NCj4gSXQncyBtb3JlIGxpa2Ugc2V0dGluZyB0aGUgcmVxdWlyZWQgcGlu
cyBmb3IgaG9zdCBtb2RlIHRvIHdvcmsuDQo+IA0KPiAzLiBzb2Npb25leHQNCj4gVGhlIHBpbmN0
cmwgcHJvcGVydHkgaXMgc2V0IG9uIGNvbnRyb2xsZXJzIHdpdGggZHJfbW9kZSBwZXJpcGhlcmFs
IG9yIGhvc3QuDQo+IFN0aWxsLCBvbmx5IHRoZSAiZGVmYXVsdCIgc3RhdGUgaXMgZGVmaW5lZC4N
Cj4gVGhlIHBpbiBpcyBhc3NpZ25lZCBhY2NvcmRpbmcgdG8gaXRzIGRyX21vZGUsIGNvbnRyb2xs
ZXJzIHdpdGggZHJfbW9kZQ0KPiBob3N0IHdpbGwgYmUgYXNzaWduZWQgd2l0aCBwaW5jdHJsX3Vz
YiogcGluLCB3aGlsZSBjb250cm9sbGVycyB3aXRoIGRyX21vZGUNCj4gcGVyaXBoZXJhbCB3aWxs
IGdldCBwaW5jdHJsX3VzYipfZGV2aWNlIHBpbi4NCj4gICAgICAgICBwaW5jdHJsX3VzYjA6IHVz
YjAgew0KPiAgICAgICAgICAgICAgICAgZ3JvdXBzID0gInVzYjAiOw0KPiAgICAgICAgICAgICAg
ICAgZnVuY3Rpb24gPSAidXNiMCI7DQo+ICAgICAgICAgfTsNCj4gICAgICAgICBwaW5jdHJsX3Vz
YjBfZGV2aWNlOiB1c2IwLWRldmljZSB7DQo+ICAgICAgICAgICAgICAgICBncm91cHMgPSAidXNi
MF9kZXZpY2UiOw0KPiAgICAgICAgICAgICAgICAgZnVuY3Rpb24gPSAidXNiMCI7DQo+ICAgICAg
ICAgfTsNCj4gQWdhaW4sIHRoZXNlIHBpbnMgYXJlIG5vdCByZWxhdGVkIHRvIHBvd2VyIG1hbmFn
ZW1lbnQsIGl0J3MgdGllZCB0byBkcl9tb2RlLg0KPiANCj4gVG8gc3VtbWFyaXplIHRoZSBjdXJy
ZW50IHBpbmN0cmwgdXNhZ2UgaW4gZHdjMzoNCj4gMS4gTm8gdXNlciBvZiAic2xlZXAiIHN0YXRl
LCBtZWFuaW5nIGl0J3MgdW5saWtlbHkgdG8gY2F1c2UgYW55IGltcGFjdA0KPiBvbiBzdXNwZW5k
IGZsb3cuDQo+IDIuIFR5cGljYWxseSwgdGhlIGRlZmF1bHQgcGluIHN0YXRlIHJlZmxlY3RzIHRo
ZSBjb250cm9sbGVyJ3MgZHJfbW9kZSwNCj4gYWN0aW5nIGFzIGEgcHJlLWNvbmZpZ3VyYXRpb24g
c3RlcCB0byBzZXQgdGhlIG9wZXJhdGlvbmFsIG1vZGUuDQoNClRoYW5rcyBmb3IgdGhlIGludmVz
dGlnYXRpb24uDQoNCj4gDQo+IEJhc2VkIG9uIHRoZSBhYm92ZSBvYnNlcnZhdGlvbiwgdGhlIGNv
ZGUgY2hhbmdlIG9uIHRoZSBwaW5jdHJsIGlzDQo+IHVubGlrZWx5IHRvIGludHJvZHVjZSBhIHJl
Z3Jlc3Npb24gYXMgaXQgYWxpZ25zIHdpdGggdGhlIG9yaWdpbmFsIGludGVudGlvbg0KPiBvZiB0
aGUgcGluY3RybCBwcm9wZXJ0eSwgYW5kIHRoZSBwaW5jdHJsX3BtX3NlbGVjdF9zbGVlcF9zdGF0
ZSgpIGlzDQo+IGVzc2VudGlhbGx5IGFuIE5PUCBpbiB1cHN0cmVhbSBhcyBvZiBub3cuIEJlc2lk
ZXMsDQo+IHBpbmN0cmxfcG1fc2VsZWN0X2RlZmF1bHRfc3RhdGUoKSBpcyBjYWxsZWQgd2hlbmV2
ZXIgd2UgdHJ5IHRvDQo+IHJlLWluaXRpYWxpemUgdGhlIGNvbnRyb2xsZXIuDQo+IEkgaG9wZSB0
aGlzIGFkZHJlc3NlcyB5b3VyIGNvbmNlcm4uDQo+IA0KDQpUaGlzIHN0aWxsIGRvZXNuJ3Qgc2l0
IGVhc3kgZm9yIG1lLiBJIHdvdWxkIHByZWZlciBhIGNoYW5nZSB0byB0aGUNCnBpbmN0cmwgbG9n
aWMgYmUgYSBzZXBhcmF0ZSBjb21taXQuDQoNCkZvciB0aGUgcGFydGljdWxhciBpbnRlbnRpb24g
b2YgeW91ciBwYXRjaCwgY2FuIHlvdSBqdXN0IGRvIGEgY2hlY2sgaWYNCmRldi0+cGlucyBleGlz
dHMgYW5kIGxlYXZlIHRoYXQgYWxvbmUuIENyZWF0ZSBhIHNlcGFyYXRlIHBhdGNoIHNob3VsZA0K
eW91IHRoaW5rIHBpbmN0cmwgbG9naWMgYmUgc2V0IHNvbWV3aGVyZSBlbHNlLg0KDQpUaGFua3Ms
DQpUaGluaA==

