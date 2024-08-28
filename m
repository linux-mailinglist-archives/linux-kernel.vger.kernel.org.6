Return-Path: <linux-kernel+bounces-304213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F37961BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA011C232B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEA5482C1;
	Wed, 28 Aug 2024 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FjzKsFry";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="M1R2HP/Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VsXQAcA7"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613AB45945;
	Wed, 28 Aug 2024 02:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811073; cv=fail; b=ZYw/LTUqnFeDoF4nvWtpRUnMdt3yYfTETapizcxlPz5qVooN5MyPw1rvZY5BOBa5Tk0EgU6ZYh7RpMCkc3kMvavZ4QpHzzDyU+z0Pdv+kgjZ/oXQjN5I3PbrwLz+fOtUlQsy91jw83R25+v+XjIDzDDunt6mveBitnIvxSEHabY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811073; c=relaxed/simple;
	bh=ahvLPM6eoUOIxhRzNSViBTzfBiRgeUImDER6nJcpSDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b9dbQ79aRDqOwSzt7nMlr5UJkAyCkM3lK+tx+OZeYoBKJdZvyzY4qlSEURp6Y8A5hMoRpYBtWP/5S6VpPaE5uF3hItoJxKtcQglvJOz2bKdXNPG9+2TEV4V5oy9a6YtnQOxnzB5gh9317YJQW/wvywv46jaZlmhhfJV0fjq6ZFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FjzKsFry; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=M1R2HP/Y; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VsXQAcA7 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RLgXHL014556;
	Tue, 27 Aug 2024 19:11:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ahvLPM6eoUOIxhRzNSViBTzfBiRgeUImDER6nJcpSDE=; b=
	FjzKsFryF96h4INdKwNIhNkI8GIeRoyOdOBhusf8X4JAtvPkGdoo94VaKemcM4ne
	i6qztmi55uukyolZu+++Q/FMYp2ZbPRxHk2toRB5F757tz0Ba5RJpxJqFDLNWI3C
	vpr2Y5pygZj2slIN1DiwfE1jyMG7739Pk1UGAwaTJ53vPLoFKee2L66YRK1sqVU/
	5D1NIbB4Hc1CaNjCX/1yocs40J0sCsDLc9Ztfjna9s2kjg2MsKsX31LwcyaG2fLs
	bIiG5p3uStN1M9mfOZvCPFkV1Ckw1ShxSEwmF3SMI+ddVQjsYk2ADAmFtX6TsYkC
	a5BPutvMO4rKywrHTQ/0HQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 419pxyrxj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 19:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1724811067; bh=ahvLPM6eoUOIxhRzNSViBTzfBiRgeUImDER6nJcpSDE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=M1R2HP/YIXC/JQFYeWmp3sxxnuNQ/p99AbPIUFvU8mh2UYpJnvYdiMav/ZHtyt0nb
	 c7OUQ+khoDl0P3f59X+pUn0CFgJy0N+D0PpWL6Ef8sqKwL+Co8WMNM8fnp356Xa4O8
	 NzT67ygl0jdxCc65QheDSDaZVOgF6zg7j6iFyvZCtQjwMEKVFV2VQxF6MPqm7gOizi
	 wG4OkS1w8t2rTeXp3Jqi9hPhJekB1cfur6r5wPtFdt0gqNo34VY7yP+mU2Y6VDZ1NJ
	 fasVWWNvNw3PTZ/rCOQ/CG02+74hBoBtJi5O68lUFKd/D2UeDp/UOaKQwns4GTnDKn
	 xigmkMZa8fymw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 857AB40175;
	Wed, 28 Aug 2024 02:11:07 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 4391FA00A5;
	Wed, 28 Aug 2024 02:11:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=VsXQAcA7;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 89A81404D0;
	Wed, 28 Aug 2024 02:11:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUx9h/DQCwMmyvxFkzOU6SfSodF9xMN99YG5DR1IEAZz9yqBxsqxYfVqENPZ8jhKqdCA80pA4iWjGkXS7Ym4f0Mu5Id3s77VK1T40Nl/xezd6ZoEzJcONdH7d0/j864KYRMKWnFXz57CVebVce8wBnrFq1dGVWyFMkUTGWirksgWpyrRAuUXUU8nYQxDMB6SFPliVymxbcduOP4G6BAnWDHjHScMSQGl/sWAGEMDaCU207QUXtt+/uLIIq/wp9lZbNFpX/02LVlb0xiQHx+/tFtMjIDgCHJbuS/owp6plNyMrvHBQHAQwLkvKX1WEIr5rzthzNMMe0cztlZ7jJSFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahvLPM6eoUOIxhRzNSViBTzfBiRgeUImDER6nJcpSDE=;
 b=gVgy90Wb7stRy9YUMjfYNVXc4ID6FbzzZXNMWJ4gkfgIaiTog0tviTmfo78mG0vs3w+WUeJh1gD0G0ip764oJoR32fxUqjviK9ox2uYyyr3YTMrW+e27p/AMVlzvgZ4IOeNE9lwFbcQeYGvrWXUIWHCHvrjRrcRrpiine9UZoHfda5fPDUrfWdkx+GXfmhT7RNP111V8yoxNJr2v8Oh6TueJGCz9Qu3UI5l3CwDaz6rZlQZA4Gzd/7iTNkxf1ziEPD5F46STiA9+QayMP+zxgMUCVUYf7YFGIczT2mO6+hdgi0dqMXvTvuOCTJn0pf/U2juXDh4SCQoirWGZhbNMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahvLPM6eoUOIxhRzNSViBTzfBiRgeUImDER6nJcpSDE=;
 b=VsXQAcA7Y2yjf7iF94SC72K5aYiPyCghK+0TnzDdg26BZNGavKmW/ZGNBkXgUuFjwjyEerKLrgDYhh4Ha6tHQ0fG2GVsA+cOHK8bhOwS79v7yfO5XBEToe2/marj72U13RBuw5FDJ/a9gIp8lkq2MWbjklg/9GlOKK+Ldwr80N4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 28 Aug
 2024 02:11:01 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 02:11:01 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: core: Set GUCTL1[29] to ignore single SE0
 glitch for FS/LS operation
Thread-Topic: [PATCH] usb: dwc3: core: Set GUCTL1[29] to ignore single SE0
 glitch for FS/LS operation
Thread-Index: AQHa9SFgaRsPPuhX8UaUutAfxbViOrI79MgA
Date: Wed, 28 Aug 2024 02:11:01 +0000
Message-ID: <20240828021058.dxzzvrdqat4gwut2@synopsys.com>
References: <20240823055642.27638-1-quic_uaggarwa@quicinc.com>
In-Reply-To: <20240823055642.27638-1-quic_uaggarwa@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH8PR12MB6820:EE_
x-ms-office365-filtering-correlation-id: 4b56786f-21d5-4f73-66c6-08dcc706aa08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?andrU29EVmJEUyt0TVo4Sm1sUHBqY1lWbUZhSitHMlRzWk13eGswT1RuRm9T?=
 =?utf-8?B?SXdnNmo0OVJpY3F4UFc5S1pmdllHVmZ6ZkN1RGM0Y3dZa2NWR2VNVGZiMUp1?=
 =?utf-8?B?b1JhU0pyM2dqQ0w1aXVCY1Aza1dvM1o0MmxhVklCeU5HUTBaSGpFTk8wdUR3?=
 =?utf-8?B?T29GVWUzUVhRMG0zTUo3dmFGMUdQRXpQaGw5T3JtQUU2Mk8xMFAraVdmL2Z6?=
 =?utf-8?B?Zi9sV0MrWFRTSHBXdmd2NTFLbjArRkhucEFUbFJLWnBKTnBjOUdEY2lzMXhm?=
 =?utf-8?B?bUl4WUFSTFNoU0Z4eUgvM2x4c0NSQ2d4dlJCQmlVdnRzTjM3QlJTOTJMWW13?=
 =?utf-8?B?dVZncDB5RDBycVVHSVMxUjhaV2Vic1RYbG5aQi9PUmdGQzZEU21IUGpaQUln?=
 =?utf-8?B?ekNDVkFuR21NNWs1aDdQTXI2K3R6L3c4ZTE3anA2QklraE1WQyt4OVN6dzJZ?=
 =?utf-8?B?dkJYSWlvRFQybEc2bGFNeVBscG9HemNrN2syVU9GYjJINXpaQnBibDduclhP?=
 =?utf-8?B?YmN1dVRLNUdUdC84cVhhWkt4Y3pGMHZoR1RRUUpGaFRqMFZZV2x5c3gzM1VW?=
 =?utf-8?B?cFArOWZVS2NtbEFlWGRjYXZWdTFJN3J2YjZVOHMyMGFwbTFGQ3B2Y2Foamsx?=
 =?utf-8?B?cmhBMzhnN25NUFBrbXJlU2NkUFp5S3lJN25CYkVlVnJXQzVWalFsR1Ercmdl?=
 =?utf-8?B?bXNBb3JZN3pRZlhKQUJ5SUZrUk5KdVZQV1VuWllDNG1CMzF0emROTDlUakY2?=
 =?utf-8?B?Z01ZWkw5Ukp3SklxZEVqdXFNdW9yRy93aGVoNEtKanliQi9vdUNoVnV2cnFs?=
 =?utf-8?B?SXg5cElQTjNoQ0I5VFdseldlb2tLa25aMjNMRFdhTzUvVzBoenZaZHJLSGFJ?=
 =?utf-8?B?cDRHODI2R082aWZMaFlnbEoxTGpGUm0xOWtSM3ZFNUZQdFRGTFBlSVJtaUJK?=
 =?utf-8?B?VCtMdG1QSGwvT1h3NVk5aUhuLzMwQWJURlpVOURtRy8xUHJGZnZFOFR2M0FR?=
 =?utf-8?B?MnJJYlB3ZXRwdHhnYVZyOEY1SGUyRnBiQVZsOC9WVWNwVFNWT2RuWVByRzFO?=
 =?utf-8?B?aGVhVDJ4a3o1aVAxaTAyNnJjRStiMGdibEp2OFI1VWE1Vi9Xb0ZqbHk3dC9r?=
 =?utf-8?B?Y3Z3TE1ocG9QcnRncStjdTNDY010eXhhVDJjNVZZSjFQWTlURFAvaE1oaEx5?=
 =?utf-8?B?cWJYbGxLcm1TWDRaZ1h0eERjZmJKaXdrV0tBd1dhWDRzeEJmMVdZMEk2bXB4?=
 =?utf-8?B?ODV1V2xid0pVMnlVZExtbFZZOHVvNXRjajM4cUwzbWNhMnVnNVRxVTVUSi8x?=
 =?utf-8?B?bUlEUXBOV21TSVpBblRLaXRZWGw1U0syR1ltMWZFZHJEQjBjOVNISHJpaFVt?=
 =?utf-8?B?dXp0R2FkNEFUdXR1bG1TVWcza0ZtTlBmVFdCSndzL3p0ZzNDcXdTelRhc3hH?=
 =?utf-8?B?OUF3eEFtdVF1eXZDWkxGNzhGMFJNZXNFbGVuUjRzVVVKK1dBRzAwSkZmQ28x?=
 =?utf-8?B?Zk1kZHRYaFhlMU9KTXlsSzYrNWRSc1I1VUxyVkFFdDRLMktscjV3SDF6Qkxw?=
 =?utf-8?B?SFNrUFJMb3JCbG5HSUFIS2NmaTlTbkZPSkFEN2M4cVpka1R6OC9XajdvNG1q?=
 =?utf-8?B?elpkQXNxVk1YclBjQmZQZnJDV2VGeHJyWkZJV0thOTZzZFY1LzNrMFlROTFI?=
 =?utf-8?B?THNFN3RjaDVXL0FzREcza0hFT3FrWmt1ZWVEaVV6VFlsREJXVEVGdXBsd09U?=
 =?utf-8?B?M1dTcGx4Z2hKbXZEc0ZxcUdzOEd3aW1PVVZqd0grWUJIS2ZQRmpKdGt3V2l1?=
 =?utf-8?B?a0xVWDJ6ekNGY0drNXlXYnpYU0NBZWVpNzlsemJRZ3ErTlhEVG1jMlNZcjBF?=
 =?utf-8?B?cjd2c2ZqNUdmeWRIZXdZWlYzUXl5RndwdEpjMGdhUE9FU3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0d6V3E0V0RlZys5S0JTOXlYOGM1MExlS2o0aUFjZCt5Z0x1OW1mZUFCV1k1?=
 =?utf-8?B?RW92ZkdlQlAxWDRHVjVNNmR3OGU0NGU3bCtrSkJoVmZZaktoTXJvSlVUb2Z1?=
 =?utf-8?B?NUZXMlRBdEcyVFgxanZCa1htSnBXWDZmaW95YVpiV2N0SElUOFpiN2ZVMGlM?=
 =?utf-8?B?NzBQNUEwUDFwQktNZWlYV2pETUZiRGpQUlIzbGNGNEcrRlZmVm1pREp0SkI3?=
 =?utf-8?B?cUYzTGN4eFZhWmptV2UvNWN2WkMxVnF1OGh1MCswaHFOaUNPZGFidTB2dVNq?=
 =?utf-8?B?WHpzWm9aMEE0UHRGNWZoYis5WWpzeDBBUU5SMG92VHdCelRwRlNWZlQvc29j?=
 =?utf-8?B?YkZEU3lwVjlGU3ZTZXhPVllURFVITzlxTWhmRk1uR0svclpPU3p0cnZuMmg2?=
 =?utf-8?B?NWE2MUxpWWVvOUllWWpvNWE0bTdybmtGOXF2YlVrTHB0SjJSRkNCNGJvTThO?=
 =?utf-8?B?UVBtVkRDN1FFRm5qcVM1MVZtWlFaZEozTTh4ckdJelpNZDZyN1ltN3hMbDZP?=
 =?utf-8?B?SzlYWlNUSDFtZm5yNVZBRUlYb28xdUZRUEhyZEV2REpBWElzSzR1elovaEtX?=
 =?utf-8?B?RHJheCt0bEFIYlc0UzlQUkkxZ0xIVG9UdVlaM05tb3JvaXJEc3Y4Tm1sZy9E?=
 =?utf-8?B?K0IvNmR1RXZiTkVCVEhOckNtMDA5Snh5Y2sxN1lGRWswRHNCN1cvWkhzUlVw?=
 =?utf-8?B?WmxIU1RDYkcrNnRVR1REaDQxd0VVcS8vWDJzU3ZKNUtTNkVIcXpXamFiSW1O?=
 =?utf-8?B?M3IwbGZRenB2dm13cFZYSXBqWTc4WXBDN3JyOFE3U0VkUjYvTDV2ZEt0azF3?=
 =?utf-8?B?cWg0REJQL2RjR1ZCTWR2OWpwazVMRlAwMUhHRlVENFBGMFdPWUtnZU1RdkRU?=
 =?utf-8?B?NFJXOUQ0K2Jmb0xrd0VZRm8wSzhyMGlJSWNacmtMczVSZjIyWlBieDVuMFFQ?=
 =?utf-8?B?Q09YZytVc3Ntblp4dGlMU3Bndm8rdEN3VHM3UEpJbTlpbXc0M2xSUWhjekVx?=
 =?utf-8?B?L3hjSlo0UW1UTkJVSCtaMm9Nckl4L3RXaFNRSlZ2a2lFd3pnRFBVWmkwMTE0?=
 =?utf-8?B?RUdTcVBMTGNiT0w4dHFDU29RV2UzL1kvT1IyYUQxKzJtNlZ0eVBGYkVVWitF?=
 =?utf-8?B?V2IySG9GQ0F3eXcvZHFpVTluVzdLVElnUG5uVUZMZkdFZlhaUlpIdGV5V0Nq?=
 =?utf-8?B?RHFwcWtYYXN5QVd2cHFaZmRJWkZYWEFlait6MFZtZWJIVGNpdU1XbGRtN1pp?=
 =?utf-8?B?NDNHY25vYUhScXlHMlMwMWxQRENGS0loZENBeTJVZUZENXJQWGRuRjRLdEQ4?=
 =?utf-8?B?dHJSYnpDSnJkbnBoQ2VDVlNkQ1Y2TDZETkRXa0cvK1E4VHhxalVYZ1U2Tm1s?=
 =?utf-8?B?eGl0WEY1ZTV1UXBqU3VJMjBZN2h2NnVIQnVDYmpIWVFQY2owMjR3QVM5Y0RV?=
 =?utf-8?B?cEZ4RDBubWppYWZCSFd4aGZIVVpPblRFSjRJWHV2RmszemlNazFReTl1M0hY?=
 =?utf-8?B?d2pOejV0ZThBOWZNNi9BMHNONUpIVU1ORUkxNFBIMTJicVk2aFN3L29CZzIy?=
 =?utf-8?B?aWk3U0tOZ2hMbVd0RnEzdmg3QjNpRU9IU2NmNnVvM203VFBNblpscjNzSWpw?=
 =?utf-8?B?akRMNEF1d2hHWDl1WnlqdWdXK243bmU5RlpXcm81Ylcvbi82b09pdVdBeGlq?=
 =?utf-8?B?YThYcmxqTUtseWR4QVhjb0Y0TE9GVklqMnpmL0pBNUJqRk0zc2tsTnlsZTQv?=
 =?utf-8?B?MTlxVVNuMnA2em5tdlUya0R3YUljSXFYbmRVRUpzeDhqTFZiSTJ2N1BVc0da?=
 =?utf-8?B?dlB3WGVpcFVBOTFGeExITzN2YzdNakpYNWJmU2JRUzBYWWpvUDg2eWVKcWtN?=
 =?utf-8?B?b3JMK0s1RFhFdVplOW1yTmJabnNHSHRPdE02dVlYb1ZFc1kvcVBpbmU5K3V0?=
 =?utf-8?B?NFlzbjZtQWV5L00yRnAwMHpDbUxoczVBTnpuaXpUWnRxMmpRUnNzbG93b1pj?=
 =?utf-8?B?c2FlVEJPYzRoQTFQenEySm41N0dweHN2ZSt2dG5nZmNJK2tVM2ZxYmcyU2dE?=
 =?utf-8?B?NUJKTjNTVldmSFA5YzRaWXlBREFvSU0reXMrNzBrUDFQM3QxYnhOTElRR2Vx?=
 =?utf-8?B?aUtWclNBL3g1bE9QQzFaaFkwbkRkNk1MQ3NmcEsvUzNvYlMzN0hFRzl0c1h2?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4717CA104B70FC4391807BA70354F5BE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K4swmkJZyMoEFJ0m+5QSPt0to1KNMPiE3x0M5MSaevtQtcbTq+bHxmZCkRWoqmsI6fJ968tKuoHzMxfkyUqawcHULGcdgUCJ616ZCMK13Xf9VjT3Iu9vMhRLbB+a3m1FqjBgnIeRSWkPyOFAyHmbQ8t7CJJ33yUQbMaR/7n76NbZJB93UKz4TACXfEbmnknZn7mLCIv6NVf8SsamshscFjg9HHgCTkZ9BmysjvS71ze8ASroT2j0IQH3tktT4moT4Y7EdwRamfd8PMzfYuKDwKtvyRjXvOPBkey7NmiMM2ixY8rI5OWvnFEN6lEqal/n02H4UNBdBKfhk/9aUGewi/fRHzL+Ixlnjhb6i3zBpbUOOz5qduNn9NC2T+b1jnwEj6iQKJpEiWTFFed0xlb/LpO0xxqtbrZar6Qfl/mnoIgtyxxQaf7u/8+/3XZeJ2hzWY0lOYgYiLvznw8FFrFOetSx1Bbb1qEzFcvQrLia+L+anjU5GHwQIp7So6JWSZwjXfu4DCj37B2SZWYuSWiCSRfnczbuXiAi2iW2IUdPlYQY0bVgtIXj3gYe1BmsgpQ8dDIyCbwXm4BTeVvPWA0E3OUkwk8pfRxR0cxxF4CC4ISjgWdZh7yvNLCsRjGeBcXcosDpSiQotuiyKeIdpmMRYw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b56786f-21d5-4f73-66c6-08dcc706aa08
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 02:11:01.5680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VUHuR60/MWfMozV4M+HS2euxzXTajWRe+Ze4xZRuba3LYG2NbLONDgmfLy1q9nmtrFhomhhCGHHhOBVtrnwXwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
X-Authority-Analysis: v=2.4 cv=PdethThd c=1 sm=1 tr=0 ts=66ce873c cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=COk6AnOGAAAA:8 a=WdQrT4bIvP9AzIray7IA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: YRaa37foAjWaKfjW6BqqEF9_GAD6r9UW
X-Proofpoint-ORIG-GUID: YRaa37foAjWaKfjW6BqqEF9_GAD6r9UW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_01,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 mlxscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408280014

T24gRnJpLCBBdWcgMjMsIDIwMjQsIFV0dGthcnNoIEFnZ2Fyd2FsIHdyb3RlOg0KPiBDdXJyZW50
bHkgaW4gZmV3IG9mIFF1YWxjb21tIGNoaXBzIFVTQiBMUyBtb3VzZSBub3QgZGV0ZWN0ZWQNCj4g
c2hvd2luZyBmb2xsb3dpbmcgZXJyb3JzOg0KPiANCj4gWyA4MS41ODUzNjFdIHVzYiAxLTE6IERl
dmljZSBub3QgcmVzcG9uZGluZyB0byBzZXR1cCBhZGRyZXNzLg0KPiBbIDgxLjc5ODY3Nl0gdXNi
IDEtMTogZGV2aWNlIG5vdCBhY2NlcHRpbmcgYWRkcmVzcyAyLCBlcnJvciAtNzENCj4gWyA4MS45
MjgzNzhdIHVzYiAxLTE6IG5ldyBsb3ctc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMyB1c2luZyB4
aGNpLWhjZA0KPiBbIDgyLjA3NjI0OF0gdXNiIDEtMTogRGV2aWNlIG5vdCByZXNwb25kaW5nIHRv
IHNldHVwIGFkZHJlc3MuDQo+IFsgODIuMjkwNjMwXSB1c2IgMS0xOiBEZXZpY2Ugbm90IHJlc3Bv
bmRpbmcgdG8gc2V0dXAgYWRkcmVzcy4NCj4gWyA4Mi41MDM4NzddIHVzYiAxLTE6IGRldmljZSBu
b3QgYWNjZXB0aW5nIGFkZHJlc3MgMywgZXJyb3IgLTcxDQo+IFsgODIuNTEyNTQ4XSB1c2IgdXNi
MS1wb3J0MTogYXR0ZW1wdCBwb3dlciBjeWNsZQ0KPiANCj4gQmFzZWQgb24gdGhlIExvZ2ljIGFu
YWx5emVyIHdhdmVmb3JtcywgSXQgaGFzIGJlZW4gaWRlbnRpZmllZCB0aGF0DQo+IHRoZXJlIGlz
IHNrZXcgb2YgYWJvdXQgOG5TIGIvdyBEUCAmIERNIGxpbmVzdGF0ZSBzaWduYWxzDQo+IChvL3Ag
b2YgUEhZICYgaS9wIHRvIGNvbnRyb2xsZXIpIGF0IHRoZSBVVE1JIGludGVyZmFjZSwNCj4gRHVl
IHRvIHRoaXMgY29udHJvbGxlciBpcyBzZWVpbmcgU0UwIGdsaXRjaCBjb25kaXRpb24sDQo+IHRo
aXMgaXMgY2F1c2luZyBjb250cm9sbGVyIHRvIHByZS1tYXR1cmVseSBhc3N1bWUgdGhhdCBQSFkN
Cj4gaGFzIHNlbnQgYWxsIHRoZSBkYXRhICYgaXMgaW5pdGlhdGluZyBuZXh0IHBhY2tldCBtdWNo
IGVhcmx5LA0KPiB0aG91Z2ggaW4gcmVhbGl0eSBQSFkgaXMgc3RpbGwgYnVzeSBzZW5kaW5nIHBy
ZXZpb3VzIHBhY2tldHMuDQo+IA0KPiBFbmFibGluZyB0aGUgR1VDVEwxLkZJTFRFUl9TRTBfRlNM
U19FT1AgYml0MjkgYWxsb3dzIHRoZSBjb250cm9sbGVyDQo+IHRvIGlnbm9yZSBzaW5nbGUgU0Uw
IGdsaXRjaGVzIG9uIHRoZSBsaW5lc3RhdGUgZHVyaW5nIHRyYW5zbWlzc2lvbi4NCj4gT25seSB0
d28gb3IgbW9yZSBTRTAgc2lnbmFscyBhcmUgcmVjb2duaXplZCBhcyBhIHZhbGlkIEVPUC4NCj4g
DQo+IFdoZW4gdGhpcyBmZWF0dXJlIGlzIGFjdGl2YXRlZCwgU0UwIHNpZ25hbHMgb24gdGhlIGxp
bmVzdGF0ZQ0KPiBhcmUgdmFsaWRhdGVkIG92ZXIgdHdvIGNvbnNlY3V0aXZlIFVUTUkvVUxQSSBj
bG9jayBlZGdlcyBmb3IgRU9QIGRldGVjdGlvbi4NCj4gDQo+IERldmljZSBtb2RlIChGUyk6IElm
IEdVQ1RMMS5GSUxURVJfU0UwX0ZTTFNfRU9QIGlzIHNldCwNCj4gdGhlbiBmb3IgZGV2aWNlIExQ
TSBoYW5kc2hha2UsIHRoZSBjb250cm9sbGVyIGlnbm9yZXMgc2luZ2xlDQo+IFNFMCBnbGl0Y2gg
b24gdGhlIGxpbmVzdGF0ZSBkdXJpbmcgdHJhbnNtaXQuIE9ubHkgdHdvIG9yIG1vcmUNCj4gU0Uw
IGlzIGNvbnNpZGVyZWQgYXMgYSB2YWxpZCBFT1Agb24gRlMgcG9ydC4NCj4gDQo+IEhvc3QgbW9k
ZSAoRlMvTFMpOiBJZiBHVUNUTDEuRklMVEVSX1NFMF9GU0xTX0VPUCBpcyBzZXQsIHRoZW4NCj4g
dGhlIGNvbnRyb2xsZXIgaWdub3JlcyBzaW5nbGUgU0UwIGdsaXRjaCBvbiB0aGUgbGluZXN0YXRl
IGR1cmluZyB0cmFuc21pdC4NCj4gT25seSB0d28gb3IgbW9yZSBTRTAgaXMgY29uc2lkZXJlZCBh
cyBhIHZhbGlkIEVPUCBvbiBGUy9MUyBwb3J0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVXR0a2Fy
c2ggQWdnYXJ3YWwgPHF1aWNfdWFnZ2Fyd2FAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmMgfCAxMCArKysrKysrKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuaCB8ICAxICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMNCj4gaW5kZXggM2U1NTgzOGMwMDAxLi4xZWRiMTZkMjk0MGMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+IEBAIC0xOTQsNiArMTk0LDE2IEBAIHN0YXRpYyB2b2lkIF9fZHdjM19zZXRfbW9kZShzdHJ1
Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ICANCj4gIAlzd2l0Y2ggKGRlc2lyZWRfZHJfcm9sZSkg
ew0KPiAgCWNhc2UgRFdDM19HQ1RMX1BSVENBUF9IT1NUOg0KPiArDQo+ICsJCS8qDQo+ICsJCSAq
IFNldHRpbmcgR1VDVEwxIGJpdCAyOSBzbyB0aGF0IGNvbnRyb2xsZXINCj4gKwkJICogd2lsbCBp
Z25vcmUgc2luZ2xlIFNFMCBnbGl0Y2ggb24gdGhlIGxpbmVzdGF0ZQ0KPiArCQkgKiBkdXJpbmcg
dHJhbnNtaXQuDQo+ICsJCSAqLw0KPiArCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdD
M19HVUNUTDEpOw0KPiArCQlyZWcgfD0gRFdDM19HVUNUTDFfRklMVEVSX1NFMF9GU0xTX0VPUDsN
Cj4gKwkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dVQ1RMMSwgcmVnKTsNCj4gKw0KPiAg
CQlyZXQgPSBkd2MzX2hvc3RfaW5pdChkd2MpOw0KPiAgCQlpZiAocmV0KSB7DQo+ICAJCQlkZXZf
ZXJyKGR3Yy0+ZGV2LCAiZmFpbGVkIHRvIGluaXRpYWxpemUgaG9zdFxuIik7DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+
IGluZGV4IGUzZWVhOTY1ZTU3Yi4uNzNlOTBkYWFmZWNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAt
MjcxLDYgKzI3MSw3IEBADQo+ICAjZGVmaW5lIERXQzNfR1VDVEwxX1BBUktNT0RFX0RJU0FCTEVf
U1MJCUJJVCgxNykNCj4gICNkZWZpbmUgRFdDM19HVUNUTDFfUEFSS01PREVfRElTQUJMRV9IUwkJ
QklUKDE2KQ0KPiAgI2RlZmluZSBEV0MzX0dVQ1RMMV9SRVNVTUVfT1BNT0RFX0hTX0hPU1QJQklU
KDEwKQ0KPiArI2RlZmluZSBEV0MzX0dVQ1RMMV9GSUxURVJfU0UwX0ZTTFNfRU9QCQlCSVQoMjkp
DQo+ICANCj4gIC8qIEdsb2JhbCBTdGF0dXMgUmVnaXN0ZXIgKi8NCj4gICNkZWZpbmUgRFdDM19H
U1RTX09UR19JUAlCSVQoMTApDQo+IC0tIA0KPiAyLjE3LjENCj4gDQoNClRoaXMgaXMgeW91ciBw
bGF0Zm9ybSBzcGVjaWZpYyBxdWlyay4gUGxlYXNlIGFkZCBwcm9wZXIgY2hlY2tzIHRvIHRhcmdl
dA0KeW91ciBwbGF0Zm9ybSBvbmx5Lg0KDQpUaGFua3MsDQpUaGluaA==

