Return-Path: <linux-kernel+bounces-314005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA3B96AD94
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2251F24E56
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A136FB0;
	Wed,  4 Sep 2024 01:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OTC8PLD/";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AzceaLTr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lcs2jpGP"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF02F23;
	Wed,  4 Sep 2024 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725411819; cv=fail; b=lCEUVxekFzUhugOTV+NShHCuuWg3Z1H11OTIf91MKgV7bRlmVfl2i15WYcExp8tgJfUvYZscN5OyEm/TO6TZurvEqwu+tkfTePFrW11QokbboPuH6EbIbGP7bMfTgRNw4/0NLGH7g6uCjk6TZEfZwQhSsWMHdWQkvmO95CI7OPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725411819; c=relaxed/simple;
	bh=ZLxAWHpzh7eeBiFdlFbMLuRnF9VBhhjFocvdg0rF+3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SpYWZqcY829nktvkQnsw2L55aXbn+ThPPKPn+rKp/6m+rLCaBywpxh4GkTK+ZfmvEvfLGJk92HN0aCVyJBt489y3tEQkD/5zChkiGjCV0LhiDbHuo1bOeBcfdvsbf69COmmZ6hRbBIBCeR458KaTbPE79HYHbywdu6G3jNnMjb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OTC8PLD/; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AzceaLTr; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lcs2jpGP reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LYIhL023487;
	Tue, 3 Sep 2024 18:03:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ZLxAWHpzh7eeBiFdlFbMLuRnF9VBhhjFocvdg0rF+3k=; b=
	OTC8PLD/aogBTXqGH1KL7SJa/HLCmX82wojoIJt+J6Mqr3uBUbY1mRD88IwT+u6G
	l1fIQN2n1q2FhAkjBNBB4yfpAYk6WzuFP6Ky2lnrBDB9jvR8kmeXt67IWDY00aIs
	yfUejMkw5vV2afb/tcVmz3RJR8/7Y/9L/TnIQ/GyZPGkyonUmnD8P7iF7CW+rn30
	xgiwv7OagqyzobJZh/WoStXpUSCFgddvZa9ft2aa89UM8kszD4YNhj9p2Qs6MQf1
	rhCr0nqEFB7pdvS/umTvVaj2QouiCta8MM82MTpnBUzUHAOSowuk9+5y1tPCjyqR
	UaLf2oicFo/QP0jflL83YA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41c23wwmbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 18:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1725411811; bh=ZLxAWHpzh7eeBiFdlFbMLuRnF9VBhhjFocvdg0rF+3k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AzceaLTrpkLBdFF1j2ojgr3YSYAlaO5+dJUV9nr9Jjla/sEd045Ycnbuqgei86zLt
	 xXk5X5jEEBEFWnKGerm651/5qej3c3FeJYv6obIVzkZDV3gTo1ZJ4a5cbeU0rpyiBE
	 YD3Guz/k0uG4cDISBFvXNLeuj4AewuKxAS6G3n4DMaCb6+P2qBjZ0yk6D9TebrT+kr
	 z90dcEaJ48E6XuZqQAXctzf0bS6uND5CDhLP7Vy8JOxu7FOr1Qas+aX+aDQ5ALhnvV
	 l+3s0KX4n+FeWbpcKtwNgSK3fFxeBz48L+f+014dw0Ry7PpArfyemeC0fC9Jh0qY76
	 iDqNwht3g+jlQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2CD8040361;
	Wed,  4 Sep 2024 01:03:30 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C1C3BA0079;
	Wed,  4 Sep 2024 01:03:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=lcs2jpGP;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C32AA40149;
	Wed,  4 Sep 2024 01:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe+Nx+N/2XxDHDFkjWwTsjAaPSsXxpPPZrpHPvcV/6Tf4rn6ljMSeQkZ0UPjNh11q7OoUIBEfpWiMY6wQgnf/XrSBi/zfyk/TVHjYGXYD9zw+jM+h2XA5PLM9malmzVx2eetk0jj4ixGgJ4QfdYWjmoV5l+WzQC24AgNBfvu1D9prnLYxAv3CtUMIYSDxhccS/rPntzuMXQLtYDxRHyPkILYhTBGdYmYKBAt2lbNyqsaqkNvBSLVtyhtE6vzeqGw5PhtymLqcD9gbe9NscNHHzokikO4IVzly2ZMp+nyc6Cejzia8TRgtfpbooA1di5RhgeUKcf7KHuCH9aGCdxFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLxAWHpzh7eeBiFdlFbMLuRnF9VBhhjFocvdg0rF+3k=;
 b=xtr7Nu4dIF7LfiOKcxvbr8EMK+NSKOhNZ/2YVYST14TmW7qRkunAwbMuTdr6VtzGLbcNetCydwTswHrRg9jyLP2b9xgJUF1ZmJxGgTvZijxlOiM1tsj1gxHEXKsLp2alMPkzar+DmdS32nL23K/HT8ehMcjvEwxphUHQwbIgbKt0vDUZeSyVfZWpDc810Shwebb+F73RqxT2BH9tPSiSHJ75W8208RQ04sfTilpjJLJslTuZZDLNyaadFD6EbsBqizrXKIQdwSnBYpPQt4KyOGijRJB2+TO6Qum0BtTTajEgDYTeH97gfSbBAlC2SbDliAG+MXGZKVFHkURpeRvtmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLxAWHpzh7eeBiFdlFbMLuRnF9VBhhjFocvdg0rF+3k=;
 b=lcs2jpGPdp/64nIXBSneEbpqQ3v7/mDt1g4j1miQy93AmRAudykE98h54neKyBSc2iR3cTkROsTWDXS8irB8GuKvTfKNtxSKutGmt9ni7GAKSOr2NFNADk0AL/PfPx4jbWriejVpD3PmC+FiF3xmlobcZH/r0h5rbiMa0Fm2IJw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 01:03:26 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 01:03:26 +0000
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
 AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AIAAVgGAgAK0ooCAIEFKAIAA0sIAgAPWhwCAAnZSAA==
Date: Wed, 4 Sep 2024 01:03:26 +0000
Message-ID: <20240904010322.leqt3pap6lguivg4@synopsys.com>
References:
 <CGME20240719110149epcas5p3dd468685a095c094ed2e540279bf3ec2@epcas5p3.samsung.com>
 <20240719110100.329-1-selvarasu.g@samsung.com>
 <20240807003806.5owtgwgw2lczg4u5@synopsys.com>
 <b6baeb45-1684-4fcb-8c71-392cb4788c85@samsung.com>
 <20240808011536.oid627ez4ppdfkhp@synopsys.com>
 <b48e7aba-6c54-431f-bbb5-3e5490df0c1a@samsung.com>
 <20240809234227.eriwy5e6leatzdyh@synopsys.com>
 <b273201d-c589-4c57-9d57-ad2affaeade0@samsung.com>
 <20240831005046.5lndwdr7cfm3k3to@synopsys.com>
 <2e678109-8399-48d5-9567-033eab910bca@samsung.com>
In-Reply-To: <2e678109-8399-48d5-9567-033eab910bca@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB9395:EE_
x-ms-office365-filtering-correlation-id: 67785454-e466-48ec-ae24-08dccc7d61ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDIrWXY0WmVpcnY2V1I4VGdCeTBWaVFRVDZwLzllL2xTTk5vdDdPN0tVYnZn?=
 =?utf-8?B?NEVqN09hRWlJQTdHdDFkQ0ZTZ2psdnhsRVdFRHZmR21WcFljb0VDLzJCV24r?=
 =?utf-8?B?SEN2aC9JU1lXcFh2VU1CTzZhYVQvYUFMSERqV3N6eS9aMjYxVkdHZXg1Y1Rn?=
 =?utf-8?B?ak5QT2R6YlZWcEJ0d0Y1dHdhQ1Jna3pabzhGWC9aMUZlajlseTQzQjBMeFEz?=
 =?utf-8?B?ay9YUUNzSXFWUWNjM1JjckpZeU95dElyUDk0Vld0aVA3WmE0VkxxbkNhSGNR?=
 =?utf-8?B?b0UvQlVRMnA5Mnl0RXk1Ny9LNExmUXpQcXphS2thRHV0VkVHcEEvUXhoS0Ir?=
 =?utf-8?B?VUtwUFRoNVl3L2VEMGNLd1V2UWdwWW5Sd1FoemtORmJtcVZmYzBEOWozcGZ0?=
 =?utf-8?B?cDd2UW1NU21ZanlnTndUN1p0eDF3b2VEamdFcm53MFB5RUR6a3BvMFNOajRD?=
 =?utf-8?B?akRwNXRvL0MrZFplQXB4b3BsdXVkblMxa0Fib1p6Y2pUWTZtVGFleFdoZklk?=
 =?utf-8?B?SWk1VHg0ZisvS0RwK0N2VHZOczFSL0NWY1NWRU5KSWlZdlUvOEUvZWRzaDA5?=
 =?utf-8?B?bmR2M1B3KzhndjNuQ2tJeWROYjk3WkJybWZha3lZbWxwQmR1WDFiZ1VyOEIw?=
 =?utf-8?B?MmMyWjhhUDdTNndkY3VYQ1VsYnhkVEYvbXJoNFhlV25XSVpxNmpLK1djblB2?=
 =?utf-8?B?bEtERTFLeHlsL3J1MFVFRnVsRmE1UUVQOE03NlBnTkdLckZ1MTlPREp2eExY?=
 =?utf-8?B?MnVDZGZ6OWVhR3czMUo5ZVYraTZMV1FLSjBmRFhDNExvNnZlYkNMdjJLQSt4?=
 =?utf-8?B?WUpNdzVUY3pKN3hLa2l2bEJUUjBPdUdra1h0OHF0SDlmaWVBbXI3V2kvNjhJ?=
 =?utf-8?B?enJQbWxXVHR3a2pCMUdBTWlRTE5kcGVnNmdUMnU2RGp6UCtSRnVaMU9EY0s1?=
 =?utf-8?B?YjZLaS94bEp1R3FWd2ljNTlNWVhGV1JQbmJic0pyQ1pISGtkRElEVldKL3Vq?=
 =?utf-8?B?TjRTTDllOGxONGJZV2hDemtXQ1dKS1g5N1lRNjhTaUxZTzJiaDBsSjhHQzhY?=
 =?utf-8?B?ZmJodXNBNytDdXlZalkrQS9KbU5TR213Y0Y1VmVvVFRoejJham9pTCtkUUVx?=
 =?utf-8?B?dUc5VXh4SjFJSDd6eU96M1ZoTEFtUGhybDNsUld5c1BuZTdKRmZOdzh1b0da?=
 =?utf-8?B?Mk82ek5MbW4reWorNTZleXAya2tFOWVaNHhZazFEazRIMFNvNkdUM2p4clhq?=
 =?utf-8?B?NDgxVmhMb3N6Z3JEVlRNcTdlaG5Bb09Wam9hSHZ4WWwvMW5QQThkTjhWOHRS?=
 =?utf-8?B?SkdQK3JjZFdrYm1Ob1JtekU4WUN4U2VleVpjckJzMWtJbC9KNENvc3NFcFNJ?=
 =?utf-8?B?RklzeXBSSjRQNUZGOVFIWk92QjQ4NWhMUEpEQ2o4RzBCeDVNMUYySTlxRjJH?=
 =?utf-8?B?ZGc2OFFSbTNzYS9wNlkyM2tEbU1zVjJCSVM5dWZBaDczYksvTnU0akYySXcw?=
 =?utf-8?B?WVdiQ2hCUE1wVUFTdzJCQWRRWjFvQUFlZ1AyUzhiaGdReWRNTnNrRVc0eStY?=
 =?utf-8?B?dGM1YjhISUdibDEzaWthVi9mV3VzRXNvQjAvWHgvQ0xHSkI3dnhvVUdGY3lk?=
 =?utf-8?B?Vmt3eVdjWWROcEdxZGVHSzcwYmY4SXNaUTJNN0RlekhoZWRtcHNFRVJuYUNG?=
 =?utf-8?B?Qkp5VE1mUTVnWE5JdU90YWh3SUl5OTlEK21NVWlBcllGNFZnZmc3dDFBVldE?=
 =?utf-8?B?V3lpNEcyYjRNTXJGMmllZlc2TnNzMnd2cFFHN2tzYVlrc3RpamhLMWpjK1hO?=
 =?utf-8?B?WkFnVUNjeVUvazJUWWdHT0R3WXNRcVZCMkRxTzJ6QVhKRFR5UkZvanN6MlBU?=
 =?utf-8?B?UHNoQUpwWmNROXlaR2xKaWUxY0NwSUlpS2VxdHBjQlpMb1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THBCb0tsZXJsKy9IenBRSjVyQlZsekRTUFB6dXErcDNDWHB5Z0NhZ3pYNkFh?=
 =?utf-8?B?T2N2TlVobjAyM2NYYkVmaE9URWwvQmpQdkhJTG1kbHZCQStTQTM1Q1pvYmZp?=
 =?utf-8?B?TE80UHAvTlJ3MEZESG5HbzBiYWpPQnA0Tk15eE9VZE5ZOXNjemV2TjU1UkFn?=
 =?utf-8?B?RElvSmZ4NFNFeEppTXB5VnpUc0ZCN1RvVkhMODBYRlhjSXBSWU1PdXg2UXdQ?=
 =?utf-8?B?YWZBaUlkdmx4d0toZzFhV09oWEI5OStuN2pCblJ1a0VpcmVXQ1ZrdG44cjd2?=
 =?utf-8?B?UlpLWWtBb0pGT0ZUUzNhMTUySmRtUmdNYU1OSld6aHp4N0MxWForWXIxVHc5?=
 =?utf-8?B?SlVBLyszVnZ4SVhwZ2JVVWRzWUxBKzJzeklwaXkvL29uUVhnbEVPT1NUb1k3?=
 =?utf-8?B?VUo0WXNMOGVkSE9OSk9yTDN3NTMxM0pIUTJOTVBqUVUybi9wU2dRL01YUS9X?=
 =?utf-8?B?RS9LcU5tTjFoNXVZNnJkYzFpeGhjZDl6aDhtZm4yYVJicXRHdlppVUgvWk5L?=
 =?utf-8?B?Y3ZZYlNmR3BPZmVHSGZiSVh6eWNkdlVCOFY5cHFDK21qVUtyQUdvS0hBelRE?=
 =?utf-8?B?L2Q2RXR3UGprc1c4QittRUNmMUZyNUJPUkcwRDVqYlVTQnRCUy9mZ2VkeTV3?=
 =?utf-8?B?akRMUmtiajZDNS9FWXlRWFlmWlR4N1dzU1ZyQmg1NVVjYWJ2d1dGK2kwb1g4?=
 =?utf-8?B?RkY0Q1AyYTI3c3V0dkFUdVpFWXlwdHFlb0RQaVJpcjdlREdVRHgvVDk3MDhX?=
 =?utf-8?B?ZmJJN0NrVkFwV3RaOXFmSWluS0dBR2NHQzZYdjZFSVBoVHZyby9EQ2dxbTBN?=
 =?utf-8?B?ZUlzY3puMFd0RDV4cXJiT3ZTRmZSYlQzZG5POGtSZDJxT1hMQm9iRVBlU2FL?=
 =?utf-8?B?OUhySForYit6T3d2d0ZCR3JlRDdIdC9NeDlvR1BOQjE1ZlhYRUNkMmQ5Ti9r?=
 =?utf-8?B?K0lmZGw2WXN5SWdxb1dIOGE1QVdpVS9nMU56YWI2TFhiSU5SQ25wSm9nb2tO?=
 =?utf-8?B?TFA5S0tOZDJMTzYwSCtJY0RjNG5YbmEzc0JnVlN0NFJidjZDbnZzaTJQaktL?=
 =?utf-8?B?WStMN0E5T0E5bW4zRWU5NzNZekttdGhlU2U4ZTdHWjEzcGpwVFF1UWJXMGRX?=
 =?utf-8?B?Tnpsb1A3clYwbVZLUVR4TSswSU9vRXUxOEx4eFc5UW14OTJhVnB2U0o0ZnMw?=
 =?utf-8?B?MWErUVBFSldaLzNRcXY4S3VOOE5BNDkrVjA3S2Z0bTZaQ2t5YnJ6K1h4aXhY?=
 =?utf-8?B?WGFSOXU4a3FsM1Z2YTJlUUIrY2VVMXZOWi9jZlpWQXZhNXRyRDd0MnUwM1Z2?=
 =?utf-8?B?ckF4U3FFc3pzZ3NubFVVMnZVOFRsU1J4K2c2VTlnbmhmdDhlc3NOa291dHNC?=
 =?utf-8?B?Y0xBN1JJemhyZWZiKzJ3clpuL1VNMjFKVkEycWhZbW4vdmVBYUh2NmFBdWY5?=
 =?utf-8?B?Wk5tMHA0bGxLSlNPbit2YmVBR21FSFRBRTcyVDVUOW9Ld2xOWVJxNmt2MGl1?=
 =?utf-8?B?VFpVZ2JDRG8yS0RMRU5xTGJ2WTVCVnVqbEIxUk5hczNteEpzd041QWxjZkEr?=
 =?utf-8?B?UW1WR0xNKzFRN1BqNHVDcGQ3VitEbXl2UEZUYmNyTi9nY3NZWFZLUERPd2RV?=
 =?utf-8?B?ays2Sy93L0tCN0k5Q0RYRzdzNTJVT2I5Nk9UcHJpQ1pUUENKQTNiR09EWndq?=
 =?utf-8?B?bWxJR05vWHdFMjhrZ2JHVzNJOEorZ2w4dHVyOHVWVTIvL1NCT29RaldZMkJV?=
 =?utf-8?B?R3RLbklyOEdnUGJjdUtTMDQzRWYya3ppUUZGZUExOXh3eXBLbStUTjFFOGNG?=
 =?utf-8?B?dDJwVk1SK3lPRStTVTcreXNPY1JLUlk5NmFyZmVOUDVwQzM3RFpxNTBqdUpm?=
 =?utf-8?B?VmRWelRSS1lGcVlsT0tpd3MrUnIwcVI3NElLamdhUU1IZHc3UUxNcDVTN3ox?=
 =?utf-8?B?N1RqelVudU5OWHJ0eVJZV0NDNklFZDFaT2lZYUpyZ01sY1ZZQjV3S2E4eHFl?=
 =?utf-8?B?S3lSdVRRdXdlZmYvSk1taDdzRWp0VCs0Y0R0czI1WVhuakVROFpYWndoNFpT?=
 =?utf-8?B?YkZ6SDhoVk0vVnJXbmM0U1Z3NU1IbjhkeGJkenRteHkzTTlMcnh6SmhzWThE?=
 =?utf-8?Q?LZGdhSppD3fUa1NZaka6eNXjp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A3BB125D77B1A4F8C1D5DB1177D4105@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H2Nb8Qd1stIaeo4P0XPLc98MN1r1fZ7rjHW/ERTwPwKJJO8LGS+d9lQIDlJxiJ/b9uft99UIbAAW5omksYS0Mdr8iicrmG1U098HVuFgIS2TaMNHM3rszf67NR5gH/FxOZoyK7QiuEYuon5LIeRhsSlV+UBnXIDYiiMayIgVPQ3SKymYv069P/rCKowA9PDsD2q2DI8RHijYAj7USABziCTUQEI12HRBB/AliULYHuOIoyfrSXGVuKLsYrlVEOzD4WGu1kcboDcoKUl0sBTeBnjK/XJgNaYng3Ijo5T1jN3lEYITzb0B+BKhzjAgKUIXMrGvRoPmKm1dbtcOcY9S1h9If1M2+wv8ZX7e/5eGjS37s8kEtkSumjswHv43F8BeH4ZWexe3HAxNLb5m21iRj4TdVVBSBF9FAwdaXuXxK9b6LXVAQ1RBcEczzdpW/RU8GRAMmN2D0kXNgCpvlGJndd77M+5eRy8O7cP/NGt4x5V7h3IDOf++A7KYrB6y6M4oh9HbM9kjsPGf6fEQS/4E9exZ0xp8/L9XSn5a231u4c1UlAoOoEjnqLa0ORVrF1ZMjTVmvjqmlfI9CjZri0xntXZLrHuxJQmmduVXv+eUz0BclH6LgkBksDggA4t5S2eBcEf5yYzKgGkNqIpKxEyctQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67785454-e466-48ec-ae24-08dccc7d61ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 01:03:26.0983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9in00L3tXUSBiJRUT9DG5yFRBwlBxaTNFlEAsJCbZ3U/m0/XiLu4eBfcFuebtuEyEHTNXnoqlmnH8S67pX4qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
X-Authority-Analysis: v=2.4 cv=Z9G+H2RA c=1 sm=1 tr=0 ts=66d7b1e4 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=muGHTWwmNkmOsSG7cvkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: d6lvZ3iV-jvHaFaPoEQ1QQXsS3W9Bo9z
X-Proofpoint-ORIG-GUID: d6lvZ3iV-jvHaFaPoEQ1QQXsS3W9Bo9z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_12,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 mlxlogscore=530 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409040006

T24gTW9uLCBTZXAgMDIsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gSSB3
b3VsZCBsaWtlIHRvIHJlY29uZmlybSBmcm9tIG91ciBlbmQgdGhhdCBpbiBvdXIgZmFpbHVyZSBz
Y2VuYXJpbywgd2UgDQo+IG9ic2VydmUgdGhhdCBEV0MzX0VWRU5UX1BFTkRJTkcgaXMgc2V0IGlu
IGV2dC0+ZmxhZ3Mgd2hlbiB0aGUgZHdjMyANCj4gcmVzdW1lIHNlcXVlbmNlIGlzIGV4ZWN1dGVk
LCBhbmQgdGhlIGR3Yy0+cGVuZGluZ19ldmVudHMgZmxhZyBpcyBub3QgDQo+IGJlaW5nIHNldC4N
Cj4gDQoNCklmIHRoZSBjb250cm9sbGVyIGlzIHN0b3BwZWQsIG5vIGV2ZW50IGlzIGdlbmVyYXRl
ZCB1bnRpbCBpdCdzIHJlc3RhcnRlZA0KYWdhaW4uIChpZSwgeW91IHNob3VsZCBub3Qgc2VlIEdF
Vk5UQ09VTlQgdXBkYXRlZCBhZnRlciBjbGVhcmluZw0KRENUTC5ydW5fc3RvcCkuIElmIHRoZXJl
J3Mgbm8gZXZlbnQsIG5vIGludGVycnVwdCBhc3NlcnRpb24gc2hvdWxkIGNvbWUNCmZyb20gdGhl
IGNvbnRyb2xsZXIuDQoNCklmIHRoZSBwZW5kaW5nX2V2ZW50cyBpcyBub3Qgc2V0IGFuZCB5b3Ug
c3RpbGwgc2VlIHRoaXMgZmFpbHVyZSwgdGhlbg0KbGlrZWx5IHRoYXQgdGhlIGNvbnRyb2xsZXIg
aGFkIHN0YXJ0ZWQsIGFuZCB0aGUgaW50ZXJydXB0IGlzIGdlbmVyYXRlZA0KZnJvbSB0aGUgY29u
dHJvbGxlciBldmVudC4gVGhpcyBvY2N1cnMgYWxvbmcgd2l0aCB0aGUgaW50ZXJydXB0DQpnZW5l
cmF0ZWQgZnJvbSB5b3VyIGNvbm5lY3Rpb24gbm90aWZpY2F0aW9uIGZyb20geW91ciBzZXR1cC4N
Cg0KQ2hlY2sgeW91ciBwbGF0Zm9ybSBhbmQgaW50ZXJuYWwgdGVhbSwgd2hhdCBjb25kaXRpb24g
d291bGQgY2F1c2UgdGhlDQpzZXR1cCB0byBnZW5lcmF0ZSB0aGUgaW50ZXJydXB0IGFuZCB3aGF0
IGNvbmRpdGlvbiB3b3VsZCBzdG9wIHRoaXMNCmN1c3RvbSBjb25uZWN0aW9uIGludGVycnVwdCBh
c3NlcnRpb24/IFRoaXMgaXMgb3V0c2lkZSBvZiB3aGF0J3MgZGVmaW5lZA0KYnkgdGhlIGZsb3cg
b2YgdGhlIGNvbnRyb2xsZXIuDQoNCkJSLA0KVGhpbmg=

