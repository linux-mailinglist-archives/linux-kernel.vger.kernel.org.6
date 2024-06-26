Return-Path: <linux-kernel+bounces-229886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884199175A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4047D2843EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF9F12E5B;
	Wed, 26 Jun 2024 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uPGxKCk9";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="N7Bl1A6F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nsqI1qBA"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E4CD2FE;
	Wed, 26 Jun 2024 01:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365398; cv=fail; b=eeJc8+7I+xEr6kHAbOnDRNgFc3/uDKk5lrEH7Knue5Hzge6SZc798cVjJ8OCKsXJ2/8KAcxTvg8YQ9Gx6/uW0qbdMFiIazaQktIm0Ym2yiXBp5tuqQA1f7w9vQ2AP+P9XY7+RlcnpFfMGJId2ZIWElnxjz3vSpx6wO4ExVIkIiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365398; c=relaxed/simple;
	bh=kSbLQ46LvldOBWJMmiYCW5iASaJ6CxfwEh0Fc9JW9Hg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q/v7Mi5E+/Hf/HXS5kKhYEjcNmTisH1XOVjLgwDWBpV/SQIvXeWigogdjX+e5lMBbhi3u5AZ1hCEp0MH0Xfv1YVm+dWnH4HZkdJq2hMdLOtad2pM88vCVH2kWC5oKL1om+VhyOQNZ6c8aTXoP3LSIqeKKG4sGTM+1O7M5Nkxt7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=uPGxKCk9; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=N7Bl1A6F; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nsqI1qBA reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PMi2ld031325;
	Tue, 25 Jun 2024 18:29:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=kSbLQ46LvldOBWJMmiYCW5iASaJ6CxfwEh0Fc9JW9Hg=; b=
	uPGxKCk9JrgKc+dpU8qXLgCA52DMsrNIn46BQumRyG7aPiPsRwxbgxEBSj8z0f+Y
	CXQLDEzsA+AdnlhoA6zXgkiQmexDspAXf/bfqnN4eita9E10aGtnm6i9dNijdukk
	z3oEh6EY100hEGYWEFXV6fsFDlADGvqSn4kq8dR/P4II/4lRZIwq00JDn9b1/RO9
	GjF0FwkXT+Nqw4Zs9jYe5iVcAaNsQD/7/PZVgy3ub9fDjhRcPUhn+rGT/VYrt+cH
	4wQ0LhkaYCCCOiP9PKMr9ZPfjPeSLzfQneiRZr9oev81bbsDGoiX+mgzTVy3Twty
	+qETJcslQErmYHzws0HGEg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ywwmjwub4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 18:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1719365379; bh=kSbLQ46LvldOBWJMmiYCW5iASaJ6CxfwEh0Fc9JW9Hg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=N7Bl1A6F0UQAdFqaaml+Tqo6lpTetDxuyK1GwNPhVlnc5gssYc+XpXlb5ewLjn6CL
	 RcBDM4dpo9iFbZ9tTAuLhmXKqxchfJc+cg+Pce/a4YP9KUxeZpCRoaaFSDaWSBJYI6
	 p9MVn/JoNr8e3j/FeU+US58WSj+UdLfcJxnutzWuBAm47wZ8IMhcCTQo+rlssh1kHp
	 Bza6QKhXKBIpNCubueKmg0gPcXgVLkSRca6tHXe6VK3Vq5ODGJGrzzlCAdLUEm4qex
	 A8WNb9OZ84Y6d44/0PiX4mWPQjZ/iHJ1Fn94AaErzxxExxGgjJxVrqsZySmu+lhHtf
	 81NmBmf4KjAbg==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 443CB40141;
	Wed, 26 Jun 2024 01:29:39 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B6D1DA0098;
	Wed, 26 Jun 2024 01:29:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nsqI1qBA;
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 95C8940347;
	Wed, 26 Jun 2024 01:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJFOYcTybSVr9T+/H3FxQRqfQ+Xz48+gaZmYghsVU+dUy8R/NqzQ2CdFsjT6mrN4lOEjJlBpwSSRGQ5QJBmW16ELBYK13RPAQVemdbPbFSOBsgEtjbmLTpBFulSYiTxVUJSdWEv/bBVk1eNXG5YkfblIMtL+7jmbh3e1v2MW+jcPE/h4+1IRbgQTBOtkAdtdgd3ck5aQNICKwpuYOIQ1sb/8UCQzVdxiXq0wwXdMyGM+UMCf1piLY/jWiYvVUe1c3NmcMs92l/ur5muo6HO1agQwPbt8RpnhpsoPhWyAb6e4PGiSPFKg6r48GKSNqeIzl3VNYEXjssmfilN0WDFnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSbLQ46LvldOBWJMmiYCW5iASaJ6CxfwEh0Fc9JW9Hg=;
 b=GyXs8HvRV6zdBWkDXDIx6Zde6Whz+Qyhg2PbbptACM3gy38l0ONVzJRFWHG3TAbcUeOvJ4dnMwfhz1vR3nE19AD2/lPHxWUpG7dYJkkjEmLPBQSzIe/G2vXY0ww4FQXP6ivxiUOLeBWbeJvqbfXn9/CQ5zHv1feSYOSYP7YO+XxkGxbJSMpQZ8Hqu7EeIh8yCUv/il8CiXC2CWvuThKhfRF6Nb11QclXlz9DN0gcdz0eGx0f0ITPezXfNpFmYATP4KQ7dprEhRx/V31KtSJ44/qMMNYnGPFOxxEifxIdC2kMFFNjk+7NHGkMU5nzvoohM4y5YrE0jKrgU+0fB/hq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSbLQ46LvldOBWJMmiYCW5iASaJ6CxfwEh0Fc9JW9Hg=;
 b=nsqI1qBAL//Es3+CcKRR3t8kwkhfoXlT3GjnRkU81GJVIDmIaEftO0HZgwAS/y6duKasjKlEDgtlX1ofxth2BbgwNgAZCyYZ5/zYMauH1Y6noxCifB8mi3tstp+GFoECzg7xYdoD+ahBjf0Re9CO5zvJ0ea9GYSC0qqMmN8a+g0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Wed, 26 Jun
 2024 01:29:33 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 01:29:32 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: joswang <joswang1221@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        joswang <joswang@lenovo.com>
Subject: Re: [PATCH v2, 2/3] usb: dwc3: core: add p3p2tranok quirk
Thread-Topic: [PATCH v2, 2/3] usb: dwc3: core: add p3p2tranok quirk
Thread-Index: AQHatbYvEKCjzMC7MUi9d+7VCvXe+bG2uVyAgBhalICAA/BqAIAFmDAAgADImoA=
Date: Wed, 26 Jun 2024 01:29:32 +0000
Message-ID: <20240626012927.obxdoarp6cotfowo@synopsys.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240603130126.25758-1-joswang1221@gmail.com>
 <20240604000147.2xxkkp7efjsbr3i5@synopsys.com>
 <CAMtoTm0S2WSO6VxK79DkTs+1aq5xBYBMRsPXWAFuWo4DoymUEw@mail.gmail.com>
 <20240622000528.3keexfbetetkrxpy@synopsys.com>
 <CAMtoTm2_QoT6YL=9fDJfdgcc__X-dkJymwDXj8VpyYdXx1mHAA@mail.gmail.com>
In-Reply-To: 
 <CAMtoTm2_QoT6YL=9fDJfdgcc__X-dkJymwDXj8VpyYdXx1mHAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB8106:EE_
x-ms-office365-filtering-correlation-id: bc150376-a07a-4a47-a769-08dc957f6e90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230038|1800799022|366014|7416012|376012|38070700016;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aTRXbXYwUE1uc21nejAwNVduN0d3U0VEWWxnaVZHMmZTRXgrWnZsQXcrUDlP?=
 =?utf-8?B?ejIwc3dQQUpBTzVyWmRVRTV6cGk5SW5hc2oybXJaYjhUS2VZK0xzQ2JJM0NH?=
 =?utf-8?B?N1J2aWNySFh5UlplL1BDUS9qakgxVGFSTU5SdEgwMFROUjBYZGY1Tm5aWkRl?=
 =?utf-8?B?Vk0xUk9nSHNHeUMycUgvbDdMMDNZTEpKL3I1RmdTWHlnTldLcnBBYTFIQnZv?=
 =?utf-8?B?bkRJUll2NTZTNkRPUHA5YlRSYXhkcXFtNnV1K1JQOUxNbi8zS21vQ2V0UHA0?=
 =?utf-8?B?ZCtUK01hMmRIL0o5U3NtV01SaG0raUlxcG1UWlhWMWVWMFF3a3ZwcTVUQk0y?=
 =?utf-8?B?cGlIemVSN05wT2pna1NvV0UxdUhvZGQ0SjNTNHdTYms2cjhSSzRzWWlMRmpS?=
 =?utf-8?B?djg4UmZENWxtT2ZIdnFGRTAvcWo3amdLSjVaV3hZQXB1S2VrT1NiQnY4VUhk?=
 =?utf-8?B?WjdjVzRqMUJsWkVZUHJoT21SdWpSc3RWclVPUkZXUzEwa0tSeDM4bFRXbnFh?=
 =?utf-8?B?elk5TUxMcWNiUVpMYTdobzdobitMa1JTalBneDhSelZzQmc2eE9nSUF1T09u?=
 =?utf-8?B?bUpyeEpLZllTK0I4OG4rbmh0VXVqWVZRMDJKbnU5TXZhTU92Nks3Wit0dmNo?=
 =?utf-8?B?dGhhVGVpRnN3OUllSTBsSXhDUHUwSExKQ0RSR3V5N3A1TkdxY1l2TDFwQ3p0?=
 =?utf-8?B?ZFNCZk1vWXBBbWlKc2ZHd05nZElGTWVKOXFkd0loRmY2Z3h2eExFWStCekt4?=
 =?utf-8?B?cjFQQTRBQ0thSmdvb3dYSUJ6UXRrMWlkTkgxQ1NRb3MwVnVyNU9ZOG1VZ0ps?=
 =?utf-8?B?eHpZQkNUWVRiVlZRTlFvUkVoOTRCeURTK2orTENZRnNYVnd0a1BRaVFzQzJS?=
 =?utf-8?B?VEVVbEhNc1JKMmF6ZmdkZURZV2R1RFhKVVJ5MndqeElqYklBK2ExS1IzQ2JW?=
 =?utf-8?B?ZmpKTExET3RJT2U3a0h3WUZVV1JjVTBFQTVpTHl3Q21zTlFwWXdHbFNiM05T?=
 =?utf-8?B?NVh5ZXlxNVVCVk1WODBLT21kNVNORXRtRXBqTi84Witsc05MdlE4UTdZVGNW?=
 =?utf-8?B?UzYxU2xkUGE1MnRTU3lpOFZYVWl6NnhQeklWT1hJSXBJMU5tY2JHVjRqTHdT?=
 =?utf-8?B?QWNEQWtTS0w3V2pmOS95R2ZIbVhqWDNHdFNwVVhyYW0wSXhMNk1wTWlCbEY4?=
 =?utf-8?B?ekdzQnBDOU1TNkl2K2hPUVNnUXBOcHdpc0s1ZkptSk10c3I1QVZUOWw3T2xo?=
 =?utf-8?B?ZS9wTTIxTk8xTHRVZGhPSldabEhSOUVYdnVydysxODJCSjYwa3VnTHZMakdr?=
 =?utf-8?B?UFoxdGVmNzZjMHdSNlZkT21Pem9UMDFHcFBhbk9MVXJGSzdURlUrZHlITU1V?=
 =?utf-8?B?dXF2bGt6dEJFV2FLR3BmdEJ5ZzYvK2dsUTRuSXBWMXQxSEM5ZHpHQ1lacC9n?=
 =?utf-8?B?WHg0bnVMaUNodmZHRXlRQ0d2VFQ4VUd0SCtYcGwxb1RzU1prT2tyczA4MHhW?=
 =?utf-8?B?RTNKeEdlQXBWeG9Sa084SlAyR29aMG1sQVYxZ3o4VVorK0x1R01KTHlJdktt?=
 =?utf-8?B?dFRZa2dyQURoaUMrcHUySkwreUhnQ0pERk5tRXdubGZlS2VVSFRGaU9QUms3?=
 =?utf-8?B?RDFmRGpFQ0Jrb3hvbUFpSlYzTXBnM2FFeEs1QUt4OEpuUzdVU0Nub0dNWjZy?=
 =?utf-8?B?TFNmcjRPY3VjS2Z0eTJrc3lieE5SN3UvQUNSWlB1Z2RodnUvK2p5TWw2VG5m?=
 =?utf-8?B?aXMwYmxTMkhlaFhraXZLb1JtcE92cFV5L1hraXFRN09VVWVmRnJZeXlTMFBF?=
 =?utf-8?B?TE9MQWhpK081ZXEyRTN0S25WTnlhdXY3M1hPZmFlWHhhSmtyMEJ1aDl1RTVS?=
 =?utf-8?B?bTZYOW9md1BMZkgrTDhtL1ZjSHRhZW1kai9JejkxMG02Ync9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OU1KcndHOVJyMzF5Tk81NDBZZGJYMFg5aUpXTDBCNWY4K05ndUwxQlRzc1hm?=
 =?utf-8?B?Y2Fac045TEpIeFlRbmhwUWVpUkFCMFAzWEp2U3h4bzRaOWoyNnV2eUViNU9p?=
 =?utf-8?B?ejQvWXlOeTlVM2xZNXk1K1paTlNwS3JtQzd2K0t5VTZCN0lVSnJQWS8xeDBJ?=
 =?utf-8?B?WWlCV3FJWFFnYlg5MFNYSjUwRW1NanQ3UUVCak9rYkFZUlhzdC9ad3Nlbktr?=
 =?utf-8?B?OVRYN2cyUkF4L290bXRTUmRRZ2tqRCtoK2ZDQVI5SW9ZcllLOXdnUVpXWnRO?=
 =?utf-8?B?cVpOb3pWQ3orZW5HY28xMnljNzJ5Zk1uTDVQRGZRcmlob2ZISkV0ekFaVkdB?=
 =?utf-8?B?WUdET1ZpeWRiVzdBc2dUNVg0MjZGOVRJVXd4QlF6TERlSThKNmxSU21xT3NJ?=
 =?utf-8?B?eHJzaE5xeEZhY0x5Rm5YelBSTHIrUnVQbEFRWUsvbWcvMmU0WkxYQk9MUWpX?=
 =?utf-8?B?NUJZdDFiZDhDMDhhU3YxTmc3dmlvWWltbGg0Zm0ydGFFM2ExdFlndHoxN3U0?=
 =?utf-8?B?dy9YUWk2WXFzQ0NoZXlCd01MSkx0eU5SU2N2c0daYkpGQXFTUkV1L1E0bVRM?=
 =?utf-8?B?bHFCNGhvbnVuSUZCdUNickpKTU5UTTJsUkNYN1o4QmhxR0V4VlB4dmZ5QW1w?=
 =?utf-8?B?YmhRTk9BazF5WHZtb1ZlZjJuNGRuZzJWcXBkWWp1dkxRQm9JaHQ1bHVTSndj?=
 =?utf-8?B?NktzVFJ5VVhmTHlKdlFuV3lPL092YUVzMHZ5alJnRnhZS3V5OGFJYXFVMFRT?=
 =?utf-8?B?VHFOeHd1SGVSSEVZSG9BM0RxUUNxRjRQbnBGcWRCRnd2bEFOZUJvNi9PaGkz?=
 =?utf-8?B?SlI2eTRETUE3WE0rblo3MHFqUGFtTFBvYXFuL0tScTR4V2RoczZHK2hHQnlq?=
 =?utf-8?B?Nm5mcUtvTWJ4WDJucExDZythZE41OGlYVlI3elBna1pYZ0ZGZmtocGRaa1Zz?=
 =?utf-8?B?Y0QyTDZyYnJ1cWIzTlBCMTlxalN6bG1pTE14RkRqMTh1VXNYUVl0KzUydlRI?=
 =?utf-8?B?NXR1Yzg4RlVDdER1MERqUVhodGVRcE00Wkd1LzRtem9xdElITGU3ZkZWWitI?=
 =?utf-8?B?MzJCMy80MDJFVjl4MklYandnNFBkcXFhZGZYalVMaEliTm1lOGNkSTU0YkFU?=
 =?utf-8?B?WFhLU0ppQ01DZkFoaUd6dHBhYVQxZVVxbFJoRU1jalFERU15SkJ5MTBFb0ZT?=
 =?utf-8?B?YzBmbzlYRFlEdUQxc3RsOHR6V1dwVmdqZkJIcGdFbUU4ekMzVUFjb3N1M2dH?=
 =?utf-8?B?bzhTM1E5OUpXcHZMS1R6cnZLdnV2aFJqZ3NJSVphNklOdFVwY2kwQXJzRHZy?=
 =?utf-8?B?RytvSEdSaVE5VndiaUFzS09pN2VDbTRiM01LS0FVelVmdVVITk55ZlhQanlJ?=
 =?utf-8?B?WHhFUEFIL3VOVFZtNXNnL1pYdGkrdVMxbVRXSGJ4anFjbjZ0NEo2UGFiRTNu?=
 =?utf-8?B?YnUySkxPYXNCRGZSNnZZS1J5ZEtiQk9jSFpKK2dLb0FGZlJIVytScHpzMzUr?=
 =?utf-8?B?RUdrUHN1dElTazl5WDVXTHZCMWZaYjd4ODUwQW5GamR5bTBhMmxmYTBIQkE3?=
 =?utf-8?B?UmlkY2pPWlByQ0VoYmZJblF0NmxMRGNGa01HOU5YTXdwb3M3Q2JPWGNWV2Nj?=
 =?utf-8?B?ejRlajE4WlhvcmsvMnpqMTgrbVdMYW4raVY2WVcydjN0ejBNaEdHanc0cmdw?=
 =?utf-8?B?cW9OdlFBbWF5ZXQyWnR0QlR0NzdScWhTVmh1OGpUQ1VVZ003VmJEczdENHVv?=
 =?utf-8?B?dVVNY2V4WE1zNTdhSmduRi90c3lBTWpzQ1lKcjI1a01ONjluMWFuVlpCanVm?=
 =?utf-8?B?dVhGS3RwZm9RM1hiRVk5cWh2Mk01RHNQdkl5aTFEZ1lKWDhucHdnNVdvdXk1?=
 =?utf-8?B?UUpOYUtYVVZKUk9seTliUEZzQ2w2TjdUWWtDMUk2bU9LeThrUWMveTF5VnJn?=
 =?utf-8?B?a2w5bm90UUY2ck1rMktuZFVOQW1lUnhtNDZFL3grMEFzOHgzanV3TVRiWW5y?=
 =?utf-8?B?RFRxbFhkS2Y0cjNPb3cxL1VyeUhrV2dHQUpBVGFTSDRRMVNEeFVqYjhyaG5W?=
 =?utf-8?B?Wmw5aHVZMUgwdk1PU0dkWUpneHFCSnpsdEdxTEY2QlRqUzlpdzhqci82MWZ6?=
 =?utf-8?Q?Y4aRzUL0ZyR54lmL8i1Lh5ebm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B50FE3A210E5A94CA6C0070A20F82F03@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UrA/8NKyblkd2SbwqBizT3JF86m2MMd5pEi8YXm4o1L+DeSbqC2r400t4eFQ3yohKXzgti86eIvZFp90pVbLWs6r0ceaNC5Cxxza8+xCR7n6/qywHIBjekxtVXgAfna+i1qW6XgE7EUdxzPtTVMwb4/YIz6GUaDsD03tfwCP9xbU8yUSRJyGrzvsAupxDdQVGacXL1mn8ADqmgOIUkCMqksCwAJ0j8xUBsYwgS56UMGHujSCgjzw7AyqBng7aTH5GOunTHWHfoiJZJ4LNA9NurQh8J4zvgO+XWEwOnB7aVbd3Wm16TYUuZsJ0OBRsc2LmD8h2qI+FKly+W27M7cyQp2v+jBgiSsZr19nkM3/WWNcmFAKNWoP7MyFgEph6OhpqkGgaesdfoRioMv4T8BCVlfMyJwwkwwAVl/N5/R28foI347LznfzvJMpE1oJ7dfmlNvy2Bm9fSUW5FO5SJZq62xHseIxEly5L0yj339c7kF8jzHGuCZLts9OE66d3/U0sy9daQ4mQukiaZkvvC21WVWeYCsO6tMu/bnJ5S6VAaXxrI9UE+MPiINuXwXSom0zT6J+AeJmlroNHYcgW7cSQauMXG93/vjQzOmm8+6oHiRAbtxfD6JRXX0fig3VrfRsMu1Gy4dm7Z/aY/xtxAWcSw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc150376-a07a-4a47-a769-08dc957f6e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 01:29:32.8046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYa8YkFAC3TqkBET8ZirqXL+VYrG3KfeRNXWMKuuhsOr7WBUSFKYMINDHgJ+mmJyBmzffcY4ZTjKJZ/N28P5iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
X-Proofpoint-GUID: McXc3vBwAr9s5glYDHGXlXypYNbDPX2F
X-Proofpoint-ORIG-GUID: McXc3vBwAr9s5glYDHGXlXypYNbDPX2F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_20,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260010

SGkgSm9zd2FuZywNCg0KT24gVHVlLCBKdW4gMjUsIDIwMjQsIGpvc3dhbmcgd3JvdGU6DQo+IE9u
IFNhdCwgSnVuIDIyLCAyMDI0IGF0IDg6MDXigK9BTSBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXll
bkBzeW5vcHN5cy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gU29ycnkgZm9yIHRoZSBkZWxheSByZXNw
b25zZSByZWdhcmRpbmcgdGhpcy4NCj4gPg0KPiA+IE9uIFdlZCwgSnVuIDE5LCAyMDI0LCBqb3N3
YW5nIHdyb3RlOg0KPiA+ID4gSGkgVGhpbmgNCj4gPiA+DQo+ID4gPiBUaGUgd29ya2Fyb3VuZCBz
b2x1dGlvbiBwcm92aWRlZCBieSB5b3VyIGNvbXBhbnkgZm9yIHRoaXMgaXNzdWUgaXMgYXMgZm9s
bG93czoNCj4gPiA+ICAgV29ya2Fyb3VuZO+8mmlmIHRoZSBwaHkgc3VwcG9ydCBkaXJlY3QgUDMg
dG8gUDIgdHJhbnNpdGlvbu+8jHByb2dyYW0NCj4gPiA+IEdVU0IzUElQRUNUTC5QM1AyVHJhbm9r
PTENCj4gPiA+DQo+ID4gPiBBcyB0aGUgZGF0YWJvb2sgbWVudGlvbnM6DQo+ID4gPiBUaGlzIGJp
dCBpcyB1c2VkIG9ubHkgZm9yIHNvbWUgbm9uLVN5bm9wc3lzIFBIWXMgdGhhdCBjYW5ub3QgZG8g
TEZQUyBpbiBQMy4NCj4gPiA+IFRoaXMgYml0IGlzIHVzZWQgYnkgdGhpcmQtcGFydHkgU1MgUEhZ
LiBJdCBtdXN0IGJlIHNldCB0byAnMCcgZm9yIFN5bm9wc3lzIFBIWS4NCj4gPiA+DQo+ID4gPiBG
b3IgU3lub3BzeXMgUEhZLCBpZiB0aGlzIGJpdCBpcyBzZXQgdG8gIjEiLCB3aWxsIGl0IGNhdXNl
IHVua25vd24gcHJvYmxlbXM/DQo+ID4gPiBQbGVhc2UgaGVscCBjb25maXJtIHRoaXMsIHRoYW5r
IHlvdSENCj4gPiA+DQo+ID4NCj4gPiBUaGF0IGRlcGVuZHMgb24gd2hhdCB5b3VyIHVzZSBjYXNl
IGFuZCByZXF1aXJlbWVudHMgYXJlLg0KPiA+DQo+ID4gSSd2ZSByZXZpZXdlZCB0aGlzIGNhc2Uu
IFRoZSBpbXBhY3QgdG8gdGhpcyBpc3N1ZSBpcyB0aGF0IHBvd2VyIHN0YXRlDQo+ID4gY2hhbmdl
IG1heSB0YWtlIGxvbmdlciB0aGFuIGV4cGVjdGVkLiBJdCBtYXkgdmlvbGF0ZSB0aGUgUElQRSBz
cGVjLCBidXQNCj4gPiBmdW5jdGlvbmFsbHksIGF0IGxlYXN0IGZvciBob3cgbGludXggZHJpdmVy
cyBhcmUgaGFuZGxlZCwgSSdtIG5vdCBjbGVhcg0KPiA+IG9uIGhvdyB0aGlzIHdpbGwgaW1wYWN0
IHRoZSB0eXBpY2FsIHVzZXIuDQo+ID4NCj4gPiBDYW4geW91IGhlbHAgY2xhcmlmeSB5b3VyIHVz
ZSBjYXNlIGFuZCB3aGF0IGRvZXMgdGhpcyByZXNvbHZlIGJlc2lkZSB0aGUNCj4gPiBmYWN0IHRo
YXQgaXQgd29ya2Fyb3VuZCB0aGUgaW5jcmVhc2UgbGF0ZW5jeS9yZXNwb25zZSB0aW1lLg0KPiA+
DQo+ID4gVGhhbmtzLA0KPiA+IFRoaW5oDQo+IA0KPiBZb3VyIGNvbXBhbnkgcHJvdmlkZXMgdXNh
Z2Ugc2NlbmFyaW9zOg0KPiBTeXN0ZW0gc29mdHdhcmUgcGxhY2VzIHRoZSBjb250cm9sbGVyIGlu
IGxvdy1wb3dlciB3aGVuIHRoZXJlIGlzIG5vDQo+IHRyYWZmaWMgb24gdGhlIFVTQi4NCj4gU3Vi
c2VxdWVudGx5LCBzeXN0ZW0gc29mdHdhcmUgcHJvZ3JhbXMgdGhlIGNvbnRyb2xsZXIgdG8gZXhp
dA0KPiBsb3ctcG93ZXIgdG8gcmVzdW1lIHRyYWZmaWMuDQo+IA0KPiBUaGUgbWV0aG9kIHRvIHJl
cHJvZHVjZSB0aGUgcHJvYmxlbSBwcm92aWRlZCBieSB5b3VyIGNvbXBhbnk6DQo+IDEuIFByb2dy
YW0gdGhlIERXQ191c2IzMSBjb250cm9sbGVyIHRvIG9wZXJhdGUgaW4gZGV2aWNlIG1vZGUgb2YN
Cj4gb3BlcmF0aW9uLiBQcm9ncmFtIEdVU0IzUElQRUNUTC5QM1AyVHJhbk9LPTAuIFRvIGluY3Jl
YXNlIHRoZQ0KPiBwcm9iYWJpbGl0eSBvZiBoaXR0aW5nIHRoZSBwcm9ibGVtIHJ1biB3aXRoIGEg
c2xvd2VyIGZyZXF1ZW5jeSBmb3INCj4gc3VzcGVuZF9jbGsgKGZvciBleGFtcGxlLCAzMiBLSHog
YW5kIDE2MCBLSHopLg0KPiAyLiBQbGFjZSB0aGUgbGluayBpbiBVMyB3aGlsZSBlbnN1cmluZyB0
aGF0IHBpcGVfcG93ZXJkb3duIGlzIGRyaXZlbiB0byBQMy4NCj4gMy4gUHJvZ3JhbSBEV0NfdXNi
MzEgY29udHJvbGxlciB0byBleGl0IFUzLiBFbnN1cmUgdGhhdCBmb3IgUDAgLT5QMg0KPiB0cmFu
c2l0aW9uIHBpcGVfUGh5U3RhdHVzIGlzIHJldHVybmVkIGltbWVkaWF0ZWx5Lg0KPiA0LiBQcm9n
cmFtIFUzIGV4aXQgZnJvbSB0aGUgcmVtb3RlIGxpbmsuDQo+IDUuIFByb2dyYW0gYSBEMyBlbnRy
eSAocG1fcG93ZXJfc3RhdGVfcmVxdWVzdD1EMykgYXQgdGhlIHNhbWUgdGltZQ0KPiAoZnJvbSB0
aGUgZGV2aWNlIGFwcGxpY2F0aW9uKSBhbmQgb2JzZXJ2ZSBpZiB0aGUgRDMgZW50cnkNCj4gYWNr
bm93bGVkZ2VtZW50IChjdXJyZW50X3Bvd2VyX3N0YXRlX3UzcG11PUQzKSB0YWtlcyBsb25nZXIg
dGhhbg0KPiBleHBlY3RlZCAoPiAxMCBtcykuDQo+IA0KPiBDdXJyZW50bHksIHdlIGRvIG5vdCBo
YXZlIGEgcmVhbCBlbnZpcm9ubWVudCB0byB2ZXJpZnkgdGhpcyBjYXNlLCBidXQNCj4gY29uc2lk
ZXJpbmcgdGhlIEFuZHJvaWQgR0tJIHJlZ3VsYXRpb25zLCB3ZSBuZWVkIHRvIHN1Ym1pdCBwYXRj
aGVzIHRvDQo+IExpbnV4IGluIGFkdmFuY2UuIEJhc2VkIG9uIHRoZSBmb2xsb3dpbmcgd29ya2Fy
b3VuZCBzb2x1dGlvbiBwcm92aWRlZA0KPiBieSB5b3VyIGNvbXBhbnnvvIxzaW5jZSB0aGUgaGFy
ZHdhcmUgY2Fubm90IGJlIGNoYW5nZWQsIHdlIGNhbiBvbmx5IHVzZQ0KPiB3b3JrYXJvdW5kIDEg
YXQgcHJlc2VudC4NCj4gV29ya2Fyb3VuZCAxOiBJZiB0aGUgUEhZIHN1cHBvcnRzIGRpcmVjdCBQ
MyB0byBQMiB0cmFuc2l0aW9uLCBwcm9ncmFtDQo+IEdVU0IzUElQRUNUTC5QM1AyVHJhbk9LPTEu
IEhvd2V2ZXIsIG5vdGUgdGhhdCBhcyBwZXIgUElQRTQNCj4gU3BlY2lmaWNhdGlvbiwgZGlyZWN0
IHRyYW5zaXRpb24gZnJvbSBQMyB0byBQMiBpcyBpbGxlZ2FsLg0KPiBXb3JrYXJvdW5kIDI6IERl
bGF5IHRoZSBwaXBlX1BoeVN0YXR1cyBhc3NlcnRpb24gYnkgYW4gYW1vdW50IGdyZWF0ZXINCj4g
dGhhbiB0d28gc3VzcGVuZF9jbGsgZHVyYXRpb25zIGF0IHRoZSBpbnB1dCBvZiB0aGUgY29udHJv
bGxlcidzIFBJUEUNCj4gaW50ZXJmYWNlLg0KPiANCj4gV2UgaGF2ZSB0aGUgZm9sbG93aW5nIHF1
ZXN0aW9ucyBhbmQgaG9wZSB5b3UgY2FuIGhlbHAgdXMgY29uZmlybSB0aGVtLg0KPiBUaGFuayB5
b3UhDQo+IDEuIFRoaXMgY2FzZSBzZWVtcyB0byBkZXNjcmliZSB0aGF0IHRoZSBQMyB0byBQMiBw
b3dlciBzdGF0ZSBjaGFuZ2UNCj4gdGFrZXMgYSBsb25nIHRpbWUsIHRoYXQgaXMsIHRoZSBEV0Mz
X3VzYjMxIGNvbnRyb2xsZXIgdGFrZXMgYSBsb25nDQo+IHRpbWUgdG8gZXhpdCB0aGUgRDMgc3Rh
dGUuIFBsZWFzZSBoZWxwIGV2YWx1YXRlIHdoZXRoZXIgdGhpcyBwcm9ibGVtDQo+IGlzIHBlcmNl
aXZlZCBmcm9tIHRoZSBzb2Z0d2FyZSBwZXJzcGVjdGl2ZSwgc3VjaCBhcyB3aGV0aGVyIHRoZXJl
IGlzIGENCj4gcHJvYmxlbSBpbiB0aGUgeGhjaV9zdXNwZW5kIG9yIHhoY2lfcmVzdW1lIHByb2Nl
c3MuIElmIGZyb20gdGhlDQo+IHNvZnR3YXJlIHBlcnNwZWN0aXZlLCB0aGlzIGNhc2Ugd2lsbCBu
b3QgY2F1c2UgdGhlIHhoY2kgZHJpdmVyIHRvDQo+IGZhaWwsIHRoZW4gd2UgbWF5IG5vdCBkZWFs
IHdpdGggdGhpcyBwcm9ibGVtLg0KPiAyLiBJZiB0aGlzIGNhc2UgY2F1c2VzIHRoZSBhYm92ZSBw
cm9ibGVtLCBmb3IgU3lub3BzeXMgUEhZLA0KPiBjb25maWd1cmluZyBHVVNCM1BJUEVDVEwuUDNQ
MlRyYW5PSz0xIHdpbGwgY2F1c2Ugb3RoZXIgdW5rbm93bg0KPiBwcm9ibGVtcz8NCg0KRm9yIHRo
aXMgdG8gb2NjdXIsIHRoZSBob3N0IG11c3QgdHJ5IHRvIHRyYW5zaXRpb24gZnJvbSBQMyB0byBQ
MiwgYW5kDQpzb21laG93IGdvZXMgaW50byBzdXNwZW5kIGFuZCByZXF1ZXN0IGZvciBEMyBpbW1l
ZGlhdGVseSwgd2hpY2ggY2F1c2VzDQpEMyByZXF1ZXN0IHRvIHRha2UgbG9uZ2VyIHRoYW4gZXhw
ZWN0ZWQuDQoNClRoaXMgaXMgbm90IHNvbWV0aGluZyB3ZSB3b3VsZCBleHBlY3QgZm9yIHhoY2ks
IGJlY2F1c2U6DQoxKSBPbiB4aGNpX3Jlc3VtZSgpLCB3ZSB3b3VsZCBleHBlY3QgdGhlIHBjaSBk
ZXZpY2UgdG8gYmUgcG93ZXJlZCBvbg0KICAgKEQwKS4gU28gaXQgd291bGQgbm90IGJlIGluIGEg
Y29uZGl0aW9uIGZvciB0aGlzIGlzc3VlIHRvIG9jY3VyLg0KMikgeGhjaV9yZXN1bWUoKSB0YWtl
cyBzb21lIHRpbWUgcmVzdG9yZSB0aGUgaG9zdCBjb250cm9sbGVyIHN0YXRlcw0KICAgYW5kIHJl
aW5pdGlhbGl6ZSB0aGUgcmVnaXN0ZXJzIGFuZCBzdGFydCB0aGUgY29udHJvbGxlci4gVGhlbg0K
ICAgeGhjaV9zdXNwZW5kKCkgYWxzbyB0YWtlcyBzb21lIHRpbWUgdG8gc2F2ZSB0aGUgc3RhdGVz
IGFuZCBoYWx0IHRoZQ0KICAgY29udHJvbGxlci4gU28gdGhlcmUncyBzb21lIHRpbWUgYmVmb3Jl
IHRoZSBwY2kgZHJpdmVyIGNhbiBzZW5kIGEgRDMNCiAgIHJlcXVlc3QuIEkgZG9uJ3Qga25vdyBo
b3cgbG9uZyB5b3VyIHNldHVwIG1heSB0YWtlLCBidXQgaXQncyB1bmxpa2VseQ0KICAgdG8gaGl0
IHRoaXMgY29uZGl0aW9uLg0KDQpFdmVuIGlmIHdlIGRvIHNvbWVob3cgbWFuYWdlIHRvIHJ1biBp
bnRvIHRoaXMgc2NlbmFyaW8sIHdlIGNhbiBzZXQgYSBwY2kNCnF1aXJrIHRvIGluY3JlYXNlIHBj
aV9wbV9kM2hvdF9kZWxheSB0byBpbmNyZWFzZSB0aGUgc3VzcGVuZC9yZXN1bWUNCnRpbWVvdXQs
IGF2b2lkIGhpdHRpbmcgdGhpcy4NCg0KVW5mb3J0dW5hdGVseSB3ZSBkb24ndCBoYXZlIHRoZSBy
ZWFsIGVudmlyb25tZW50IHRvIHZlcmlmeSB0aGlzLiBCdXQNCklNSE8sIGZvciBhIHR5cGljYWwg
dXNlIGNhc2UsIEkgZG9uJ3Qgc2VlIHRoZSBuZWVkIHRvIGludHJvZHVjZSB0aGlzDQoic25wcyxw
MnAzdHJhbm9rLXF1aXJrIi4NCg0KQlIsDQpUaGluaA==

