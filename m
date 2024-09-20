Return-Path: <linux-kernel+bounces-334001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9894697D142
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4287B223E3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E988A46434;
	Fri, 20 Sep 2024 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="gg8H29An"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011004.outbound.protection.outlook.com [52.101.129.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17B487BF;
	Fri, 20 Sep 2024 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814304; cv=fail; b=KlnI5dnHKbJ06yhFQOH9JQsPM5wlqxdz1JtFTdzyxzKpXZ3h1t2o1mZw5CJKF+EGjbcOc6ot+a2TPJceKC3Zgi8zdxR+fg6917gb8s4FMYLLgt2Q+p66SenfolGU3NY7Yv0sKBWVPuh9bvf8R9ZOgQldgxUwadC3utDlxsNfSHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814304; c=relaxed/simple;
	bh=214oYR4sNChOnzJap7VqiTe/Sh1bLVPAaRJW2PTrDtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K7prKZYqFHARnt11/Nn4b0thX+/yAK1WjeqajfafojPGEM9CI7LKdFvRKooxPzHvYCJ0xKaPAAZu+vF4wuv6gw/G6ypJQvULREOQa2U66BKiTv1/j0Dj1vKiKiUEMludXnl3KwfQfl7JXkZ8LGhNcZcN6cHiZ7JX6pob/Zzo4Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=gg8H29An; arc=fail smtp.client-ip=52.101.129.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMT/2JF5U04zo4UuFq9NXohuVqWvUdCley9YPuUUotBlPFyQ51IqL6vxfxgGAF299+RvuKjTXdEll5ZwzzCmnfImR4Z8rsRsoZy3oQwqBRYlTRG4rQOo4FvQjOJI0wDyaNMJ5KhCQ9psvjVyv0LTrd6+UDsiEGyvpQBt9xuRTTVVyw8I5B3pOkYg4hbUSmo3Vb1d2HMNNwN2x1GbJ0EQelqk6ixo11Ql5V7+XNQGmqUbvcN87nW03JXXi40ur4OZxj9OqZw0Ex5+prz6hS9w8AqryboPyCva2wu2Mz9aQqgEFl7mFWbkbt80Z1AOFx5aDGN4L8XmAPGx3vkPEEEawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=214oYR4sNChOnzJap7VqiTe/Sh1bLVPAaRJW2PTrDtI=;
 b=pbTkUkE1XaA/51bA389aQaM5PK9S2VwVNt0M1QwGmT7k4jN1odHvAY3E+haAoHJXP0gXA5cq9xPhjeyK1fb26yRR80GFZo/YHSIU8YpBgEkkEbFpuOcSQ0lHcoDZbh1okALbHTwHVL9EcS5cqXcmxWZdXO1XNEHdrKmNTEfi8yzfi1gdq++21ObR/Zl1O1EdD1I0XOB9VHOPnGScs3O8x29lNTiN1UyXspXPkJGWvfXbdL1SrTCOv13t6aHb2j9EKGFiL+wmDWTUmtFZS0WwtYXRf9jSpKehnSECOYHqwqsfApY/pASCIGIRv48nqmRxAtMPz4LCnFsP/1clNqXiCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=214oYR4sNChOnzJap7VqiTe/Sh1bLVPAaRJW2PTrDtI=;
 b=gg8H29AnwAorYJG+t1SQDwj5Cj0S+h6vopDhmSRPIsF5mfYAbBF2znXWZo2aFkvBf5LUmUBJ7qZLIsUCmb5J6rUKEkdlXTrpjlOaSzRxXN+t47/e8H10yXLHaaFIVMIeotxhIGQzUtqUx3iAbwPH8lvmORYFu1rKJvLdH9Gr/NvDuFlzV32HAhsOP7yacBOy7/EGl1/azOEKa5y4M1kPr03DuJCOHXiaiUxPuplBC19K7MAsau4RT41v7QqBmV2GS3YyK9DEq63ab/SnvJHwfLWqDHrQLqwMew9O0RYgLma7nZlwyejAlogF5xf2ANyARFExIgL8jPOPbfZ3mvM7tA==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by TYZPR04MB7336.apcprd04.prod.outlook.com (2603:1096:405:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 06:38:18 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 06:38:18 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
CC: "Rob Herring (Arm)" <robh@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Joel Stanley <joel@jms.id.au>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "patrick@stwcx.xyz"
	<patrick@stwcx.xyz>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v18 0/3] Add i2c-mux and eeprom devices for Meta Yosemite4
Thread-Topic: [PATCH v18 0/3] Add i2c-mux and eeprom devices for Meta
 Yosemite4
Thread-Index: AQHbAs9UsRT8G4eST0K6kmzY7eISWbJTctWAgAzWFtA=
Date: Fri, 20 Sep 2024 06:38:18 +0000
Message-ID:
 <TYZPR04MB58539D6253FD5A8579FF154FD66C2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com>
	 <172589661042.199175.14634437656639420015.robh@kernel.org>
 <39630cb9cf923eec6d8e229aea4e6fc5980aa73e.camel@codeconstruct.com.au>
In-Reply-To:
 <39630cb9cf923eec6d8e229aea4e6fc5980aa73e.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|TYZPR04MB7336:EE_
x-ms-office365-filtering-correlation-id: ad684a2b-90d5-4819-6aa1-08dcd93ed04f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnc4bVlKcnRvRmpBbFpBUFZKZXE5bWxRTnVmQjV6cWhhRFY2T1VWM0lCTDQy?=
 =?utf-8?B?QUJpZ2F2ZUNZSVRNWDhYU0lXek5vRzNCakF4OXIyODJoQW5BNUtHWEdRNzNS?=
 =?utf-8?B?c2NzY3kzQU1ZTWc2Q1N3YjQzbCttaXRXdUxCdXY3UU4yY0ltS1FxWE5EMUhK?=
 =?utf-8?B?MGxabHdJSnJ2TldyYWd3ZmQ5aGxLb1J2WnZyazlFeWhXWFpKMWR1ZDdLeXJ6?=
 =?utf-8?B?c1laWFQ3Q3hTbXBqdmpESldmek9yL1ZlUE5OWlFJWGZCaFEwR0xRM3ZIVlcw?=
 =?utf-8?B?eUVncEk2VWhIa1JrakxubmJPQWVXeGc3OU1ROVFERzNYbzFPRWwvTW1kSDNo?=
 =?utf-8?B?RStjM2xPTkVJSEdGK3ZtdTM5SkRDOHcxV3pDZDI5cnlubmx3SGN2aTVkTXEr?=
 =?utf-8?B?WUdYLzlqT3RZM2t5V1NjcjgzVmovRStiN1BmeHQwV2EydWtudGdkUjk1c2Z4?=
 =?utf-8?B?Nnd4VlN5NzVsSWNFc29yMS9UZGJBNUFPRnpPY0p0aTZGMlBCaDdIb0hyb3hk?=
 =?utf-8?B?T3FtdEMxdWI4aWhiVkdBSFVuSmtrNmRLNXFjLzJqdWk2SDVwNXFqLzFwRCtR?=
 =?utf-8?B?ajErMFgzQmc2NkczQ05IR2hHZEpkR1FMODQ1NUxlQ0MzZkRtanFqblBuTDQ2?=
 =?utf-8?B?UCtyYXI3Nm1pZE5UZXdsM0l4ZmR2SkRZd1JabzhlcTVwRDY5UG85SEJ0V1Ex?=
 =?utf-8?B?TG5xYTNCaXpIa0hVbkM4V0JSbytFMWpGV1dIMkxvcS9HQzBjNDB2a2tBM1Vt?=
 =?utf-8?B?L3hpN0JtemYzamNvd01JWksxalE3SWsvUC9nWUhESWk5eUZGYUNMVEt6aU1r?=
 =?utf-8?B?cEExRzhHck1ROUQxZ1BvNklDVXpxWWdsLzFwTW0rN0hFamo3cXIySTlsTzhN?=
 =?utf-8?B?RVkvZlB2NURiSFFGSm5JYlVBdmhObjR5UDQ2V1hUa29uU2w5dnVSRzhycWtu?=
 =?utf-8?B?UUwzUVNOMEdCZ1ZPaGVGL0EwV2crT3RYbExDZ0tJTm15dm16MS9TR2hncWNW?=
 =?utf-8?B?QURaWTJubkRPdjRpMlVQTkZjSGphclczUmh4emJENVh2dTkrNEpidGpxSTZQ?=
 =?utf-8?B?eUNrRDhKVlAvdFUzdDI4cisxT044S1d6VnlHSVhtaXFRYXpPdUVYWnlVZUlu?=
 =?utf-8?B?YkJZQWRJVUlSNVFFSWl3ZVZwY2t3TTE4NjZLeEI1VzV4MldmZzJBK29YMnBI?=
 =?utf-8?B?TjJvdng5bFJoYkxnTnVOYVFzZjAxZGIwRjVmL2ozVlk0Z3FyaE1icFJ3cDlU?=
 =?utf-8?B?MTZucGlBZjBxQStCbVhLZm41RHUzbFBibE5VNm5DcTJHUm1sOXdIazlGbWpH?=
 =?utf-8?B?RWtqU0RMTWpHVGFJYzFzZnJlYnlLcHVvbWpLTHNFYWlNWWQ4L0ZHZk8zTUtj?=
 =?utf-8?B?ZnRXOU5zMlpPNm1zeUI5TFU3OHMwSmFtVzIwNkljcFp6WEJYSStONmNDSDRk?=
 =?utf-8?B?N0NkNzhubGU2M2ZKdUVRQVF0RmpzQlZieEFiN2QzYlp6RjNmYVB3ZDhvazFx?=
 =?utf-8?B?S3JPaGo4RVNIald3UmFBa25PNlErSUxjMlRCVVhSTmRGbFZrS3EyRVVFV2Q4?=
 =?utf-8?B?Ti9rYzg5dGpyb3lvaFdCV3Z6bVJMZmFwTU1Td2R5R1IyWHNWbnBJSFBvZ3V4?=
 =?utf-8?B?WUZmaDdDNTVhazJ6a055aWQrRTg2TDg0clEzNUx5cXBROWVoQ2p3dlFPdkRI?=
 =?utf-8?B?dEdNUFJDeE1sUzFWc3N2UlRjQ0Q0VTh0MjBLWFVNK09tV3MySVhyUWh1akxi?=
 =?utf-8?B?TEF5UGh0MFNGbm1mZUcvV2hhZ2JMb0dhWDBKcDJnMm5UT2JwWkdCKzFEdDJy?=
 =?utf-8?B?UFhPbkc2WFk4Ymh1NFgzQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OURsYzZkSEZHMjdLaEJlL2c2Y201ZjBTSzlCbUJydEZpelpVMmc4TVRtSzRQ?=
 =?utf-8?B?TXZNWjEyZGNMT29Lci9kZDg2YnhhSzNHMmtxRm0yL0o3MWVGRUNjUEM1TENS?=
 =?utf-8?B?MjhOVXJkVnFCNVFzcmFUMGJLMitYODgyL1FHVERiTTBUU0R3b0RGY2xobXNp?=
 =?utf-8?B?KzA1TkxHTitQcW9welFhTlU0ZkJ2NmZ2bG82SVRUQ1RlRFhmakJHRVFuQ3RH?=
 =?utf-8?B?TFhuenFNZ1RKWlZDcUdQaFAwWVEwUUo5QnNBL24xNlJLVEZ3R2RxazczRDhp?=
 =?utf-8?B?cDNPWUtuM1JsQUl4SWs5ZlphUGQ0ZElTQTUzVXI4RmF2WHRMYTNBVEFVeWNv?=
 =?utf-8?B?ckhuNHFOaFpGZGhaZDlMQjhDaWJCM2xjZXQvSG84ZjNTdFlmcEJkdGFKVGc4?=
 =?utf-8?B?ZWJnSzk5Z0dkVmJEQkxCT2xZRzBRLys1TUhNU0FZNVVYMkEwRDZqcjdybVlP?=
 =?utf-8?B?NGdWdmx2a0I2MDhWY1V2VmVWWEVOSXR0a0RMQVBpdHdwc3FjdUtQb0hNL3Jp?=
 =?utf-8?B?Znh3VnZZQXpyRTVPbU15NTh3NVZRMHhHaE9maVFsZ0N6ZFVqWURMQmV1aFBO?=
 =?utf-8?B?RFZiMXlxdHAyZkwrK1ovcUV2dHhTQ3krWHNFRDFremJ4aDlQZmtUem9vS3VB?=
 =?utf-8?B?RFI1dXJya0F3anA0TjRBSDlWZllpSGhXRGtkTGE5TnVEbXY1dVpnV3RKbnNx?=
 =?utf-8?B?MWl6dWc1ZTh1a3QzUitjQTUza2g3Zk5kVEZzdVNKZG13UXB6TXdXL0FLbnU0?=
 =?utf-8?B?RjBwUGo0ZGpta25xdXRrWUg5cWMxMk5oSG1qcHg3WFhZVHM2cU8wdmxvWXk5?=
 =?utf-8?B?QXhsV1l5Q0dFdkwzaXF6RVQ5dVlZWkpHQzlJOWRqZ2toQ09tTGhQcWgzRzJl?=
 =?utf-8?B?ZUxYajAzaEQ2akhVOG1KQ0NhVWJxMUxZQlQ3RTJreDZzYkI3TFZwdGxseWx5?=
 =?utf-8?B?TDRkZFJ2WGlVRUNVZXVRYzBSdld1bFI5a3A2MXE1RllTK0VvcXVNSkJYc1J2?=
 =?utf-8?B?bDNwS05vb2VyTmZsa3lZM010ZW9FV05SZlZvU2I5Y3c4RGxua3RxU3F4a3JO?=
 =?utf-8?B?T3ZTOTFYcXZqZkJuRU9EY1BrRXhqRWVMTjhYVC8xNHpzcWQ5NU9hQjk1SUZa?=
 =?utf-8?B?Q0Y5eGgrVDF2aXZtZVFXaU5wNllDWTFjblVuN0RNTWMxNlFDSGRXb0Q1a3Fs?=
 =?utf-8?B?YzhReUlTTmpKWmtIM05ONDduRXp0QkgvY1dxamt4QnBsa3p0Q2ZpTnFQRG9a?=
 =?utf-8?B?UnlXdFBaSlo3SEZrUzl3Z1ZGYXJyZHgzZlp4aitObFkvZXI0M0krclEzQ1Fr?=
 =?utf-8?B?dmR0MnhoekxVREtXaW5EcmdWYzRUQXhzRnhjcitFV3hEWlpXTWprNDY4WDRj?=
 =?utf-8?B?YkxRQzVLcEdma3FoekNRWmpRczNMNmZWelh3b1F4c1lZM0VFT2lSUTJiYkI4?=
 =?utf-8?B?YWlZakQ4QmtzNWJjYkxnV3BkK0I3d2VwS1oxdGx6OFRQZlNpK0xMUnE4ZmlZ?=
 =?utf-8?B?azFGR3Z0eDg0VW0wdGJEZWl3eDAxVkN1b09JaTBPcmVsZnM1MTJWTC9JQm5x?=
 =?utf-8?B?RGFOMVN4SU12Mk9YcUl4Yk8vQW1YQmxaMmFzOUFqcTNCTnJnajBaUHpkRTJz?=
 =?utf-8?B?ZG1MbXFIckt0YnBwMnhnTUdxSUo1TDhzK1pDK05ML0w2NFAyRDE0Qm92dXVi?=
 =?utf-8?B?c0lMdFdlWmhEU1NiVW1xa1BvVUZ1b1k4b2pnTlFKVWlrZklaK3kxalJkRzk0?=
 =?utf-8?B?SWpWUlhhTUc5WmM0a0hmMnpWc1lWK3p2VG0xSk1DaHgxd3h2dFk1Q3JvM3NY?=
 =?utf-8?B?UHZ2R05tNWZtRjQ2K1hnYU5oWW42dC8wY000SG5GdVBLZU44RTNJMGdCVXFD?=
 =?utf-8?B?bVI1cUxxUm84VE5MVXhlazU1ZlJSTDVYdlBFZTJUeUNHL2JSbDFNZEVuWmFX?=
 =?utf-8?B?SmUrU3ZYWHVnVjhTcm54Snc5SnlvTkl0eXRIcnN0Q1FmUFVqVjZOYjQvMjBU?=
 =?utf-8?B?V2ZzaElQb3dFWC80YVpOdmdxM3JzMG9wVytKTkNVbytMV2w1MEpOU01FWkxm?=
 =?utf-8?B?ZExRcWlNWFpwYzcwMXVQajN5blI5eUd4UHFKeGFzT1ZTRkFjaU9JVFFXUXJ3?=
 =?utf-8?Q?sOvPiPyBDGYS+VF3xAXik0S6O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad684a2b-90d5-4819-6aa1-08dcd93ed04f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 06:38:18.5482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8e9dvgXsLGZWAqcarcfCGt7J8My30iPOtSufryBwO7LgDXHgE1BG4tGRxShqXBb7WIQxEuoM3AVd7W75Rvh+hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7336

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJl
ciAxMiwgMjAyNCAxMDozNCBBTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8
RGVscGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1
Lndpd3lubkBnbWFpbC5jb20+DQo+IENjOiBSb2IgSGVycmluZyAoQXJtKSA8cm9iaEBrZXJuZWwu
b3JnPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IEpvZWwNCj4gU3RhbmxleSA8am9lbEBq
bXMuaWQuYXU+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YN
Cj4gS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBsaW51eC1hc3BlZWRAbGlzdHMub3ps
YWJzLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBwYXRyaWNr
QHN0d2N4Lnh5ejsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYxOCAwLzNdIEFkZCBpMmMtbXV4IGFuZCBlZXByb20gZGV2aWNlcyBmb3IgTWV0
YQ0KPiBZb3NlbWl0ZTQNCj4gDQo+ICBbRXh0ZXJuYWwgU2VuZGVyXQ0KPiANCj4gIFtFeHRlcm5h
bCBTZW5kZXJdDQo+IA0KPiBIaSBSaWNreSwNCj4gDQo+IE9uIE1vbiwgMjAyNC0wOS0wOSBhdCAx
MDo0NSAtMDUwMCwgUm9iIEhlcnJpbmcgKEFybSkgd3JvdGU6DQo+ID4gT24gTW9uLCAwOSBTZXAg
MjAyNCAxODo1NDoxNSArMDgwMCwgRGVscGhpbmUgQ0MgQ2hpdSB3cm90ZToNCj4gPiA+IEZyb206
IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53aXd5bm5AZ21haWwuY29tPg0KPiA+ID4NCj4gLi4u
DQo+ID4gPg0KPiA+ID4gUmlja3kgQ1ggV3UgKDMpOg0KPiA+ID4gICBBUk06IGR0czogYXNwZWVk
OiB5b3NlbWl0ZTQ6IFJldmlzZSBpMmMtbXV4IGRldmljZXMNCj4gPiA+ICAgQVJNOiBkdHM6IGFz
cGVlZDogeW9zZW1pdGU0OiBhZGQgbWN0cCBjb25maWcgYW5kIHNlbnNvcnMgZm9yIE5JQw0KPiA+
ID4gICBBUk06IGR0czogYXNwZWVkOiB5b3NlbWl0ZTQ6IGFkZCBmYW4gbGVkIGNvbmZpZw0KPiA+
ID4NCj4gPiA+ICAuLi4vYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGU0LmR0cyAg
fCA3MDYNCj4gPiA+ICsrKysrKysrKysrKysrKystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2
NjAgaW5zZXJ0aW9ucygrKSwgNDYgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+
IDIuMjUuMQ0KPiA+DQo+ID4NCj4gPiBNeSBib3QgZm91bmQgbmV3IERUQiB3YXJuaW5ncyBvbiB0
aGUgLmR0cyBmaWxlcyBhZGRlZCBvciBjaGFuZ2VkIGluDQo+ID4gdGhpcyBzZXJpZXMuDQo+ID4N
Cj4gPiBTb21lIHdhcm5pbmdzIG1heSBiZSBmcm9tIGFuIGV4aXN0aW5nIFNvQyAuZHRzaS4gT3Ig
cGVyaGFwcyB0aGUNCj4gPiB3YXJuaW5ncyBhcmUgZml4ZWQgYnkgYW5vdGhlciBzZXJpZXMuIFVs
dGltYXRlbHksIGl0IGlzIHVwIHRvIHRoZQ0KPiA+IHBsYXRmb3JtIG1haW50YWluZXIgd2hldGhl
ciB0aGVzZSB3YXJuaW5ncyBhcmUgYWNjZXB0YWJsZSBvciBub3QuIE5vDQo+ID4gbmVlZCB0byBy
ZXBseSB1bmxlc3MgdGhlIHBsYXRmb3JtIG1haW50YWluZXIgaGFzIGNvbW1lbnRzLg0KPiA+DQo+
ID4gSWYgeW91IGFscmVhZHkgcmFuIERUIGNoZWNrcyBhbmQgZGlkbid0IHNlZSB0aGVzZSBlcnJv
cihzKSwgdGhlbiBtYWtlDQo+ID4gc3VyZSBkdC1zY2hlbWEgaXMgdXAgdG8gZGF0ZToNCj4gPg0K
PiA+ICAgcGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0tdXBncmFkZQ0KPiA+DQo+ID4NCj4gPiBOZXcg
d2FybmluZ3MgcnVubmluZyAnbWFrZSBDSEVDS19EVEJTPXkNCj4gYXNwZWVkL2FzcGVlZC1ibWMt
ZmFjZWJvb2steW9zZW1pdGU0LmR0YicgZm9yDQo+IDIwMjQwOTA5MTA1NDIwLjQ0MTYwNy0xLURl
bHBoaW5lX0NDX0NoaXVAd2l3eW5uLmNvbToNCj4gPg0KPiA+IGFyY2gvYXJtL2Jvb3QvZHRzL2Fz
cGVlZC9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRlNC5kdGI6IHB3bUAyMDoNCj4gJyNhZGRy
ZXNzLWNlbGxzJywgJyNzaXplLWNlbGxzJyBkbyBub3QgbWF0Y2ggYW55IG9mIHRoZSByZWdleGVz
OiAnXmZhbi1bMC05XSskJywNCj4gJ3BpbmN0cmwtWzAtOV0rJw0KPiA+ICAgICAgIGZyb20gc2No
ZW1hICRpZDoNCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRy
ZWUub3JnL3NjaGVtYXMvaHdtb24vbWF4aW0sDQo+ID4NCj4gbWF4MzE3OTAueWFtbF9fOyEhSjYz
cXFnWGohS09yVUNJZ0hKeWpCcmNjTWlVOFpJSUtEODQ0QXFfQXFRZVVaRjlxZXINCj4gWXMNCj4g
PiBqOXJxdFFBY1JTU1JGYVZjazh0dUUweFdGUFZ0MHBUQ2I4WnB0T0dNemhMUUNDaVkkDQo+ID4g
YXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGU0LmR0
YjogcHdtQDJmOg0KPiAnI2FkZHJlc3MtY2VsbHMnLCAnI3NpemUtY2VsbHMnIGRvIG5vdCBtYXRj
aCBhbnkgb2YgdGhlIHJlZ2V4ZXM6ICdeZmFuLVswLTldKyQnLA0KPiAncGluY3RybC1bMC05XSsn
DQo+ID4gICAgICAgZnJvbSBzY2hlbWEgJGlkOg0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9od21vbi9tYXhpbSwNCj4gPg0KPiBt
YXgzMTc5MC55YW1sX187ISFKNjNxcWdYaiFLT3JVQ0lnSEp5akJyY2NNaVU4WklJS0Q4NDRBcV9B
cVFlVVpGOXFlcg0KPiBZcw0KPiA+IGo5cnF0UUFjUlNTUkZhVmNrOHR1RTB4V0ZQVnQwcFRDYjha
cHRPR016aExRQ0NpWSQNCj4gPiBhcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1m
YWNlYm9vay15b3NlbWl0ZTQuZHRiOg0KPiA+IC9haGIvYXBiL2J1c0AxZTc4YTAwMC9pMmNANzgw
L2kyYy1tdXhANzQvaTJjQDAvZ3Bpb0A2MTogZmFpbGVkIHRvDQo+ID4gbWF0Y2ggYW55IHNjaGVt
YSB3aXRoIGNvbXBhdGlibGU6IFsnbnhwLHBjYTk1NTInXQ0KPiA+IGFyY2gvYXJtL2Jvb3QvZHRz
L2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRlNC5kdGI6IHB3bUAyMDoNCj4gJyNh
ZGRyZXNzLWNlbGxzJywgJyNzaXplLWNlbGxzJyBkbyBub3QgbWF0Y2ggYW55IG9mIHRoZSByZWdl
eGVzOiAnXmZhbi1bMC05XSskJywNCj4gJ3BpbmN0cmwtWzAtOV0rJw0KPiA+ICAgICAgIGZyb20g
c2NoZW1hICRpZDoNCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2Rldmlj
ZXRyZWUub3JnL3NjaGVtYXMvaHdtb24vbWF4aW0sDQo+ID4NCj4gbWF4MzE3OTAueWFtbF9fOyEh
SjYzcXFnWGohS09yVUNJZ0hKeWpCcmNjTWlVOFpJSUtEODQ0QXFfQXFRZVVaRjlxZXINCj4gWXMN
Cj4gPiBqOXJxdFFBY1JTU1JGYVZjazh0dUUweFdGUFZ0MHBUQ2I4WnB0T0dNemhMUUNDaVkkDQo+
ID4gYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGU0
LmR0YjogcHdtQDJmOg0KPiAnI2FkZHJlc3MtY2VsbHMnLCAnI3NpemUtY2VsbHMnIGRvIG5vdCBt
YXRjaCBhbnkgb2YgdGhlIHJlZ2V4ZXM6ICdeZmFuLVswLTldKyQnLA0KPiAncGluY3RybC1bMC05
XSsnDQo+ID4gICAgICAgZnJvbSBzY2hlbWEgJGlkOg0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5j
b20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9od21vbi9tYXhpbSwNCj4gPg0K
PiBtYXgzMTc5MC55YW1sX187ISFKNjNxcWdYaiFLT3JVQ0lnSEp5akJyY2NNaVU4WklJS0Q4NDRB
cV9BcVFlVVpGOXFlcg0KPiBZcw0KPiA+IGo5cnF0UUFjUlNTUkZhVmNrOHR1RTB4V0ZQVnQwcFRD
YjhacHRPR016aExRQ0NpWSQNCj4gPiBhcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWJt
Yy1mYWNlYm9vay15b3NlbWl0ZTQuZHRiOg0KPiA+IC9haGIvYXBiL2J1c0AxZTc4YTAwMC9pMmNA
NzgwL2kyYy1tdXhANzQvaTJjQDEvZ3Bpb0A2MTogZmFpbGVkIHRvDQo+ID4gbWF0Y2ggYW55IHNj
aGVtYSB3aXRoIGNvbXBhdGlibGU6IFsnbnhwLHBjYTk1NTInXQ0KPiA+IGFyY2gvYXJtL2Jvb3Qv
ZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRlNC5kdGI6DQo+ID4NCj4gL2Fo
Yi9hcGIvYnVzQDFlNzhhMDAwL2kyY0A4MDAvaTJjLW11eEA3Mi9pMmNAMC90ZW1wZXJhdHVyZS1z
ZW5zb3JADQo+IDNjOg0KPiA+IGZhaWxlZCB0byBtYXRjaCBhbnkgc2NoZW1hIHdpdGggY29tcGF0
aWJsZTogWydzbXNjLGVtYzE0MDMnXQ0KPiA+IGFyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3Bl
ZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRlNC5kdGI6DQo+ID4NCj4gL2FoYi9hcGIvYnVzQDFlNzhh
MDAwL2kyY0A4MDAvaTJjLW11eEA3Mi9pMmNAMS90ZW1wZXJhdHVyZS1zZW5zb3JADQo+IDNjOg0K
PiA+IGZhaWxlZCB0byBtYXRjaCBhbnkgc2NoZW1hIHdpdGggY29tcGF0aWJsZTogWydzbXNjLGVt
YzE0MDMnXQ0KPiA+IGFyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vib29r
LXlvc2VtaXRlNC5kdGI6DQo+ID4NCj4gL2FoYi9hcGIvYnVzQDFlNzhhMDAwL2kyY0A4MDAvaTJj
LW11eEA3Mi9pMmNAMi90ZW1wZXJhdHVyZS1zZW5zb3JADQo+IDNjOg0KPiA+IGZhaWxlZCB0byBt
YXRjaCBhbnkgc2NoZW1hIHdpdGggY29tcGF0aWJsZTogWydzbXNjLGVtYzE0MDMnXQ0KPiA+IGFy
Y2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRlNC5kdGI6
DQo+ID4NCj4gL2FoYi9hcGIvYnVzQDFlNzhhMDAwL2kyY0A4MDAvaTJjLW11eEA3Mi9pMmNAMy90
ZW1wZXJhdHVyZS1zZW5zb3JADQo+IDNjOg0KPiA+IGZhaWxlZCB0byBtYXRjaCBhbnkgc2NoZW1h
IHdpdGggY29tcGF0aWJsZTogWydzbXNjLGVtYzE0MDMnXQ0KPiA+DQo+IA0KPiBQbGVhc2UgZWl0
aGVyOg0KPiANCj4gMS4gUmVtb3ZlIHRoZSBvZmZlbmRpbmcgbm9kZXMgZnJvbSB5b3VyIHNlcmll
cyBzbyB3ZSBkb24ndCBhZGQgeWV0IG1vcmUNCj4gd2FybmluZ3MsIG9yIDIuIFdyaXRlIGFwcHJv
cHJpYXRlIGJpbmRpbmdzIGFuZCBzZW5kIHRoZW0gYXMgcGFydCBvZiB0aGUgc2VyaWVzDQo+IA0K
PiBSZWdhcmRpbmcgMSwgeW91IGNhbiBhbHdheXMgdXBkYXRlIHRoZSBkZXZpY2V0cmVlIHRvIGFk
ZCB0aGUgbm9kZXMgYWZ0ZXINCj4gc29tZW9uZSBlbHNlIGhhcyBnb3QgdGhlIGJpbmRpbmdzIG1l
cmdlZC4gSG93ZXZlciwgaWYgeW91IG11c3QgaGF2ZSB0aGUNCj4gbm9kZXMsIHRoZW4geW91IG5l
ZWQgdG8gZG8gMi4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEFuZHJldw0KDQpIaSBBbmRyZXcsDQoN
CkknbGwgcmVtb3ZlIHRoZSBvZmZlbmRpbmcgbm9kZXMgZmlyc3QgYW5kIHVwZGF0ZSBiaW5kaW5n
cyBpbiBvdGhlciBwYXRjaGVzLg0KT25jZSB0aGUgYmluZGluZ3MgYXJlIGFwcGxpZWQsIEkgd2ls
bCB1cGRhdGUgdGhlIG5vZGVzIGFnYWluLg0KDQpUaGFua3MuDQo=

