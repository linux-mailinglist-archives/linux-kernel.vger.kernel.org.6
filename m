Return-Path: <linux-kernel+bounces-293387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA23957EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B11A281C59
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C996146D65;
	Tue, 20 Aug 2024 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="FK9m6xvm"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2124.outbound.protection.outlook.com [40.107.117.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4285F18E35B;
	Tue, 20 Aug 2024 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136731; cv=fail; b=fPb0L5Br6diyUQdI7rK2cgEx44rqgJdSkugkeAb0BmqHzCzn/tyv2i0SjWNt9w24min6i0PYZJkgviS53dHAWyaVreSt+VlhnSFBH6DZvluZalJ59D/cXWqHN8cC1lLLcG4lGE7uGe9MxMvHkMPcQ/KowHG9xzVDomOVfkZRC3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136731; c=relaxed/simple;
	bh=wWLFLa4OzNdJmAaasLCjvdT8eBW1iRXF2UEQqN3wxtY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FtMerb+8TtVdhn1tp16UNq3YbhJ2yBopxKJhYOVjf4HI0H/OWiTu3Iw2kvpJZqq3BdKNhhlvpCFERpD5CxVBaoIIz/wVMJLpL0DnHjnh+iMfZ55M209CEbf3iIbRATBAyO0b6L9x9TLAhxNqSF57p1jy37i4PAd1MFgSThrvZAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=FK9m6xvm; arc=fail smtp.client-ip=40.107.117.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGjOsqk+hYa323i1ZTDvYIMjQptvSnrt9nkzhjJXQeuUyVvIV3a+NDw9Dib+suJdgeEDWHEJF43/3JxrXb0aIE8nuX4+7VVETRG36smgYKBUpxt3j9RlWAxdLt3eOcieoc3sTppJV7IvTCZsenUa/eVuQIV2OOFiEHbO7FGBn+AuAIRjcJG3HGecKCbz6GAHQv5kKZx0yQQqRE9Xf+MqauLHOSmOUxb13v5N0AHycJBr7H9IDoVeNXEJ6+JBr1FQ/6l67lkXnVsEDDWVfnJ9MGGsrn8wA/ohP7yzjoVu25Enw9KPf9qi7QQ1ldrFY3nwAqezk3SYwmGosfTbfqXZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWLFLa4OzNdJmAaasLCjvdT8eBW1iRXF2UEQqN3wxtY=;
 b=VbTpxez6gOT7xFCn1BugVzbzJR/VhFo8XgizxKOwgjKUjDdx1wkFqCHRGcbQJZbJKb4/CBspjQPFqS43yxPEhfb6IOdhgSwhnbPAC/SKUszHl76TYk7a/o3jR0GDdylRwkauKcznSAufcl1SUKPdr6pr5JUoi0k4njnS3xb4QudB5hpAX2fucIeMWrVs24rdWkGAJ+r/pUJhexF5V2okiWVfTLx6AoctqmSEQjXEdSXfeRdk/jLrbL75k9rpbifgs4IdvjifJnkA7lM69Az1n6gojAe8tY8vuasYFDJSWeJhHppYfeXywbQW/kaWiVq6UbL000gNlGnbACIqZq0yWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWLFLa4OzNdJmAaasLCjvdT8eBW1iRXF2UEQqN3wxtY=;
 b=FK9m6xvmqmb5fNkWJpLcWUkhZS0aM+kqRDaTW6QAR9F8SbQgkQ3dyun8x4IVyDn/Yje/LicfjwW94jwXPOqNKaQ8tKoZx+oLPECID3ytB/NKpHlfNXmIfLxyrvB7Ts5cHC/7uJqHQJ6zaIWxHhwQiZjZk2RqZIBaHOuUFJT4dpgdvViRipjN5mwrKYb+iB8S9prpAQ0ddT2J4HR7T8cJp0TLSojQK1mlvXKXjrx0xkqff5MgIPD9ObanYCFYWANLEcSrZDRf8D382b0m/729nk9JFH+nL0Pgw5VmSARxHmbVcrZ5QcXyPPoOZAUlX1ROElv48HOuD3xTL5KRugSHSA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by KL1PR06MB6348.apcprd06.prod.outlook.com (2603:1096:820:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 06:51:55 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 06:51:54 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring
	<robh@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, Stephen Boyd <sboyd@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Lee Jones <lee@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Topic: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Index:
 AQHa6Wjwpmm6AqTUmky9VcIbkjW1JLIdJMiAgAFHtRCAAAQ8gIAAARxAgAclgACAAL3qcIABK1kAgAAVdECABl63wIABbTUAgAART1CAADXVgIAAHptw
Date: Tue, 20 Aug 2024 06:51:54 +0000
Message-ID:
 <OS8PR06MB7541E86C43C2078617A69E2CF28D2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
	 <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
	 <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
	 <OS8PR06MB75416FAD2A1A16E7BE2D255DF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <10809e91-31be-4110-86c1-1e1ccb05b664@kernel.org>
	 <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <20240813191454.GA1570645-robh@kernel.org>
	 <OS8PR06MB7541BB03AEE90B090AB990B3F2872@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <7e1dc98e0f69a095a8f7725b742df3c8d8436a67.camel@codeconstruct.com.au>
	 <OS8PR06MB754121818B9431941C18E09DF2802@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <OS8PR06MB7541C54CA074410C50BA419AF28C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <64d13efd3119429ed876ad7ea499cff62e100fb9.camel@codeconstruct.com.au>
	 <OS8PR06MB754148E915F6E6014F490583F28D2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <94efc2d4ff280a112b869124fc9d7e35ac031596.camel@codeconstruct.com.au>
In-Reply-To:
 <94efc2d4ff280a112b869124fc9d7e35ac031596.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|KL1PR06MB6348:EE_
x-ms-office365-filtering-correlation-id: 62846401-16a1-4e83-56ae-08dcc0e493b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?blZYTktUNjM3eDVrS2ZaU25kTEN0MDVRVmh4VklRekFzeFBXcjZaWEwwYXJH?=
 =?utf-8?B?bVlEL1VGT1lBcXhiZ3ozVHU5OCs4QTZCcTJ5dmlCbjZaUHZOMGZxTEVEOU40?=
 =?utf-8?B?ejVyVmIvSnV3UGx3dVFhY3RRT0o0VXVLeC9QQ21JMU0wNDJ3blNlNk0rVnlH?=
 =?utf-8?B?WkdhZzM5a3Z5anY5NzVqenNTak4rTlFPb1E1eTMrY2M4WjdwUEg3ZTdjV3FR?=
 =?utf-8?B?UnFhZUtrUGwrYm9XV25qbEhDNWpERnI3RnI0NWdLUU1jVGduUEZtRzNObnRE?=
 =?utf-8?B?Q0VpK2gwVDFZT1lMTVdHZi8xWVlIdkdZYWdVTGVOK3N3aTNsdXpubDg3OHlr?=
 =?utf-8?B?ak5WZjdxVVVoK1ZLSHRCZ3R4Z056WmtLbjdQNENCSC9weWwrNEFlUjlCK1Ny?=
 =?utf-8?B?eHhnYWRTUVl4OVp0TDR1MTM4U1pHVHFXOUpjdXhFSmpmci83K0ZNRW1LQ0tG?=
 =?utf-8?B?cjdYTWlEYnlJYS9rbEJlTlpiU2ROYXFDRFIxMXd2U2dxcnNVWkJabDMzbXlt?=
 =?utf-8?B?aDhMUWdCR1BOTkFpc21uR0I5NjdzekRzRDhHcy9RRXZWZlhVUWIyY1krUUxw?=
 =?utf-8?B?aEdpWDhBQlNQUEdpMlVLR0xaN1l3c1pBTmZ6R3FyYytDMjFXbzBSeHNzUUVk?=
 =?utf-8?B?bkhxdFpWcHVtM1g5QmlWamkwNlVtOENhMTdWenBabU9XcGpsK3A1NE9IQkY4?=
 =?utf-8?B?emFVSnRobE1MU0ZIVUl1NDhLUXhhSE9HODNmN0FyaGdYTm13WDdIZW4zNGJq?=
 =?utf-8?B?ODROb0JMbWxuWGhpK1F3RGU5dklWNzRSMHplTkpIN1VHZ2RtOEdKQ05LUWpo?=
 =?utf-8?B?alhUellUanRZYXB4VW1lcVg4a2lKRzl0Z1NsNno1QmliM1A5RTRMbDRXUWg5?=
 =?utf-8?B?Z2M5TEo5RzA3alNJZHBrNzVEWS9rNWdCRTFWNFIvWkJ2cEdmTUVaQ0REUWhh?=
 =?utf-8?B?VytERjFYbzRYNC8vRVVsdnBzVE9kMzFiWERJNVQ3dDBZQWs4K0RMbGhPL0RO?=
 =?utf-8?B?Ly9uSFljZTFCOCtBWFRGeVFHZzZMb1FPWi84ZDRKMkhKa2ZLOTVabDJzdmp3?=
 =?utf-8?B?cVRrK01FRlliNEZCb1piemRIUmE3alhuQ1F4eTV4NHJ6WC9sSmcybVpJdTgx?=
 =?utf-8?B?MHVKZ2wwbkJEaDhYeXQ2UDdRc0g5L21GZTFySGxCcHQ1OVVpaStjM29MN21v?=
 =?utf-8?B?WW1SeDBSdy91bEM0QU1BeDhMVmRuM2I2RW4wdWxLMEVmTnU4RkxvUzZOaFI2?=
 =?utf-8?B?UW9PcG1DeGlxVTkyYkFlbG41K0Q5NS9tTkdqb3R2c2tSQXJYT09vVTY0V0t4?=
 =?utf-8?B?QXg5aHQ2QzhOamJtcWtwbVVzRURNVkIxSy9XS2VoNzg3clQ1Vmh2Y2pXUkxx?=
 =?utf-8?B?YzErYWZURmtkNk9FL2tKNjJVQUdCY1RrQTlhYmNzRGVFbzFjN0lIYXVXM3lP?=
 =?utf-8?B?S2lkLy96Nm1nNXJzdzZvSVZyYkxKMU96TU9UUU5ENHE0SDJJb1JXVm1hVytP?=
 =?utf-8?B?NFVuZXRUUGFQUnVrV2YwbUhGaTRKUXNjeWpUUHJPQ0M3RFBzcHgvWTJxN080?=
 =?utf-8?B?aDFDSmJ6T292OThmeCtjSU5WTnVsdUV6Z3E4UGZNTTM4bC9uamhQcHlremlC?=
 =?utf-8?B?bGtkekJ1QVFhYmY1Q0duVXduTlR5eHpOR25Yb2JIbkpvY2tPWGRSZjZsRCtr?=
 =?utf-8?B?YW5oY1dpNE1RUFdCZTB0dDFlQnVacVpxUGgyL0x1TUF0ZlMxRTl3UFJMcGow?=
 =?utf-8?B?dVRQcGQyVEpLMG42d2dGQ3pkbVkwRDlvUUd0SDkxcFZ5c0pOaEFORm92eHZh?=
 =?utf-8?B?QlkzRXdMM3lDemk3VEIxR2NNa1l6S0J1RGFOMkpzb0dHUE5jNDhleG9EVkVN?=
 =?utf-8?B?dW9vSnR2RFhDNjRmcjFTUTk0UUpXa2QvTVNQUGg0eS9NRmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L1V3VTROV2tIMjczc2p5ajhTc2pLcVF4ZVJScDJMb2tMWDJjSk1FZzhnRzBY?=
 =?utf-8?B?Q05ldGJ1MG9TT083NUJRRE91amhRVVBJSTRhcmVSaGplMC90cEJURGo2WlJs?=
 =?utf-8?B?ODdNd1N1R1VyLzVhdEdSWGQrdlJoUkRGZFNOWTlGNnpzU3I5U0NWb0RyWXJz?=
 =?utf-8?B?VXNCK1NhNkNqTW9jRXp5MTVUd2UwSFdxUHBNUnZobWJ2a0xvdXFxeXV1RXdU?=
 =?utf-8?B?YzA1cTVTb2ZXY081T1ZCN0RhY0NpVkJRclluU1BCY0R5SHUrMXhpQmtkZlEw?=
 =?utf-8?B?VUIrOTVvT2E0UzJJQTNZWW9obGxxbTRCQUNDbS9rT0hKcXBhaStBM01TMHFr?=
 =?utf-8?B?T1FhaHBzVXpsbHB1RkxUR3BubFpyNTRMKy9uRll0VnRmb2tXYURvU2FKUVUz?=
 =?utf-8?B?L1A2bldiMlM3R0NzTU04cDJGTzFSYy9GUVowUGQrVnRLSkRJa2pldjRMWGxT?=
 =?utf-8?B?bUYrS0FFQ3dWREF3KzhTWWg2endkelZadUhMVHMweUhQQWtkU2U5RDhpMFhj?=
 =?utf-8?B?RkRzVWFZRWY5RWV5WnROVkttcVQ3UjU2bk81V2F4M2RCcWJQWjJ5YjJQWkNu?=
 =?utf-8?B?M3lLQTBQNWEyWENuNFhKaGd2NXN2RW1NbFJYbUNMVDZ2TGpCQUI4VkZMYXhz?=
 =?utf-8?B?OEpJTm5lSmVwamFlY3lRY1FQZ0I5RDRpUG9XRmdFcklFdjZlWld2SEZkOW5I?=
 =?utf-8?B?VTBLMkorYTVia0FZUFdxKzM0aVRIdzdFM1pURFlHdjdPMWpTck5raFBqQUZ1?=
 =?utf-8?B?WWZyOURxL0FXcDlxM0lrMGdkVzRXejM0TEQzd3hKV3hqM0lpVDlTVFVUR1Bz?=
 =?utf-8?B?SXRRMmNCSnlwbk1FUnJtZk9qTmhSQ09vREFxYUsyMzVlSmRmQVZ1RHRLdDBi?=
 =?utf-8?B?ZUVpdlhWTERpc05nTEdUNmd1SG9QZHZicEpQVFdXU3hDTm4wUDdUc1hjbDR6?=
 =?utf-8?B?VmNaU09YbUp2d0lwMGUxMHYzS3VSa2pVR2U4dTl5QlFNQjJJaGFTTXlIVi85?=
 =?utf-8?B?L1pTOE9CaXJIdW92N3Q2L0hWUXM4NktUZ2YxbDNSdlJMTFcwQkwzZ2ZQRyt2?=
 =?utf-8?B?ZFZSV3l2UktUVmc5RmM1RitCVmlnN0lTN1VVRDJmdFpFUUU2TE81eFN2Witu?=
 =?utf-8?B?MnJ3SEE5VEpxOG4ya2FSWjBaWHhOaTlEdytyN0lhWmFQd2x3S21lUVpnYitP?=
 =?utf-8?B?cFBOV1RITWZlQVJRMkxRMWlXK3llckQyK3hmVTB2QWRma1lDQ0lSS3RrSHU1?=
 =?utf-8?B?a1pLcENPQ1hBM09LYzJ3WXg4WlJwbnVHT2dzR3RSUU1HYUZiQUhVZ1JwSlA5?=
 =?utf-8?B?V21zYVpjcUZUZHp6Q0l3dmFIb0oyUlVIMjFZSkh6b3VORUF6bHI1QjdQQVRY?=
 =?utf-8?B?TUkvclI2UXhRcS8zcFFZVklpcUUrUFBPbEhDenlSNDB2dVpURk4wUVg4ODlJ?=
 =?utf-8?B?U0pISDBYd0w3SGRQOHhuMjY2eWlKOGJrS2lhUFl6QTRTYnRTbWN5WURuWThR?=
 =?utf-8?B?SEFXaiswdmt0Zy9HSDBpOE1uUndrbGt5QjdFZjc1TmVHMi9ocTgzdWM5NGVl?=
 =?utf-8?B?MkhGbURlQkpPL0MyYjZzem1GVndneEJpeXlEMlRVQnpPQk5TRUR1NEFXNzFz?=
 =?utf-8?B?YUd6N05MU1FuSU42dUpnRnNWWVJmTnh3ME9kVjFUUGRuSU9EMkU2YWhINlZD?=
 =?utf-8?B?OTN4dVNOd3kyTk9rdjhsczZXeDQzRm9KbGNvb25jVmNlOGFEKy9tNk5RbGda?=
 =?utf-8?B?OGhnMlBHNHN5ejQvdXVxMFl2ZXF3RkRrelZpSnk2YjUzaUVKTGxER09WYTNz?=
 =?utf-8?B?UGxvR1ZZSytBeDhBZ0xrMDNzck11bEtJc3IvSnp3UWFlTjRxV1RwbEtlVHA1?=
 =?utf-8?B?eS93eDF1dXJvdEtrdXI1a1hON0U2ZFF2akNQRHBtZGV3TW1NUnlEY3BYYkFs?=
 =?utf-8?B?N3NtY0p5S3ltaDBPNW9nTDlqYnJDVFVENkZ1djJSYkROcDBEK0ZDYXBYODZy?=
 =?utf-8?B?K1hXUWRhY296QnlheEhrUEl2QzMyMU5tMXlIU0ttbnVjLzdLV0E3VEZZa0wz?=
 =?utf-8?B?QmxjVm1BR2xQamU5UldxSmpZQmNzd1FCQ05OWVVzTWZjK1BlM0pDL2tRdlNh?=
 =?utf-8?Q?VXEe1vIs6fC7wS2RAth28MDVg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62846401-16a1-4e83-56ae-08dcc0e493b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 06:51:54.2132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1+Dsd4SqgG8ENvRTC6oWzqH6kjiXilYXTdSazUHi3zu3OohIocpdlbItZaelhUyLTuMVMLjbSK5Tk74kQRp7jAExazxXR0x1XEen44BiR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6348

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkOiBzdXBw
b3J0IGZvciBBU1QyNzAwDQo+IA0KPiBPbiBUdWUsIDIwMjQtMDgtMjAgYXQgMDE6NTIgKzAwMDAs
IFJ5YW4gQ2hlbiB3cm90ZToNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBkdC1iaW5k
aW5nczogbWZkOiBhc3BlZWQ6IHN1cHBvcnQgZm9yDQo+ID4gPiBBU1QyNzAwDQo+ID4gPg0KPiA+
ID4gT24gTW9uLCAyMDI0LTA4LTE5IGF0IDAzOjA1ICswMDAwLCBSeWFuIENoZW4gd3JvdGU6DQo+
ID4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gZHQtYmluZGluZ3M6IG1mZDogYXNw
ZWVkOiBzdXBwb3J0IGZvcg0KPiA+ID4gPiA+ID4gQVNUMjcwMA0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+IE9uIFdlZCwgMjAyNC0wOC0xNCBhdCAwNjozNSArMDAwMCwgUnlhbiBDaGVuIHdyb3Rl
Og0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gRGlkbid0IEkgc2VlIGluIGFub3Ro
ZXIgcGF0Y2ggb25lIGRpZSBpcyBjcHUgYW5kIG9uZSBpcw0KPiA+ID4gPiA+ID4gPiA+IGlvPw0K
PiA+ID4gPiA+ID4gPiA+IFVzZQ0KPiA+ID4gPiA+ID4gPiA+IHRob3NlIGluIHRoZSBjb21wYXRp
YmxlIHJhdGhlciB0aGFuIDAgYW5kIDEgaWYgc28uDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ID4gU29ycnksIEkgd2FudCB0byBhbGlnbiB3aXRoIG91ciBkYXRhc2hlZXQgZGVzY3JpcHRp
b24uDQo+ID4gPiA+ID4gPiA+IEl0IHdpbGwgYnV0IHNjdTAgYW5kIHNjdTEgcmVnaXN0ZXIgc2V0
dGluZy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBDYW4gd2UgZG9jdW1lbnQgdGhhdCByZWxh
dGlvbnNoaXAgaW4gdGhlIGJpbmRpbmc/IFJvYidzDQo+ID4gPiA+ID4gPiBzdWdnZXN0aW9uIHNl
ZW1zIG1vcmUgZGVzY3JpcHRpdmUuDQo+ID4gPiA+ID4gSGVsbG8sDQo+ID4gPiA+ID4gCURvIHlv
dSB3YW50IG1lIGRvY3VtZW50IGl0IGluIHlhbWwgZmlsZSBvciBqdXN0IGluIGNvbW1pdA0KPiA+
ID4gPiA+IG1lc3NhZ2U/DQo+ID4gPiA+DQo+ID4gPiA+IEhlbGxvIFJvYiwgQW5kcmV3LA0KPiA+
ID4gPiAJSSB3aWxsIGFkZCBpbiB5YW1sIGZpbGUgaW4gZGVzY3JpcHRpb24uIExpa2UgZm9sbG93
aW5nLg0KPiA+ID4gPg0KPiA+ID4gPiBkZXNjcmlwdGlvbjoNCj4gPiA+ID4gwqDCoFRoZSBBc3Bl
ZWQgU3lzdGVtIENvbnRyb2wgVW5pdCBtYW5hZ2VzIHRoZSBnbG9iYWwgYmVoYXZpb3VyIG9mDQo+
ID4gPiA+IHRoZSBTb0MsDQo+ID4gPiA+IMKgwqBjb25maWd1cmluZyBlbGVtZW50cyBzdWNoIGFz
IGNsb2NrcywgcGlubXV4LCBhbmQgcmVzZXQuDQo+ID4gPiA+ICsgIEluIEFTVDI3MDAsIGl0IGhh
cyB0d28gc29jIGNvbWJpbmF0aW9uLiBFYWNoIHNvYyBpbmNsdWRlIGl0cw0KPiA+ID4gPiBvd24N
Cj4gPiA+ID4gc2N1IHJlZ2lzdGVyIGNvbnRyb2wuDQo+ID4gPiA+ICsgIGFzdDI3MDAtc2N1MCBm
b3Igc29jMCwgYXN0MjcwMC1zY3UxIGZvciBzb2MxLg0KPiA+ID4gPg0KPiA+ID4gPiBJcyB0aGF0
IHdpbGwgYmUgYmV0dGVyIHdheSA/DQo+ID4gPg0KPiA+ID4gV2hhdCBSb2IgaXMgc3VnZ2VzdGlu
ZyBpcyB0byBhZGQgdGhlIGNvbXBhdGlibGVzICJhc3BlZWQsYXN0MjcwMC0NCj4gPiA+IHNjdS0N
Cj4gPiA+IGNwdSIgYW5kICJhc3BlZWQsYXN0MjcwMC1zY3UtaW8iLCBhbmQgdGhlbiBpbiB0aGUg
ZGVzY3JpcHRpb24gc2F5DQo+ID4gPiBzb21ldGhpbmcgbGlrZToNCj4gPiA+DQo+ID4gPiDCoMKg
wqBUaGUgQVNUMjcwMCBpbnRlZ3JhdGVzIGJvdGggYSBDUFUgYW5kIGFuIElPIGRpZSwgZWFjaCB3
aXRoIHRoZWlyDQo+ID4gPiBvd24NCj4gPiA+IMKgwqDCoFNDVS4gVGhlICJhc3BlZWQsYXN0Mjcw
MC1zY3UtY3B1IiBhbmQgImFzcGVlZCxhc3QyNzAwLXNjdS1pbyINCj4gPiA+IMKgwqDCoGNvbXBh
dGlibGVzIGNvcnJlc3BvbmQgdG8gU0NVMCBhbmQgU0NVMSByZXNwZWN0aXZlbHkuDQo+ID4gPg0K
PiA+IEhlbGxvIEFuZHJldywNCj4gPiAJU29ycnksIGZvciBjb3JyZXNwb25kIGZvciBhc3QyNzAw
IGRhdGFzaGVldCwgdGhlIGRlc2NyaXB0aW9uIGlzDQo+ID4gc2N1MC9zY3UxLg0KPiA+IAlTeXN0
ZW0gQ29udHJvbCBVbml0ICMwIChTQ1UwKS8gU3lzdGVtIENvbnRyb2wgVW5pdCAjMSAoU0NVMSkg
d2h5IG5vdA0KPiA+IHdlDQo+ID4gCUtlZXAgYWxpZ24gd2l0aCBkYXRhc2hlZXQgc3RhdGVtZW50
Pw0KPiANCj4gV2VsbCwgSU1PIHdlIGhhdmUgYW4gb3Bwb3J0dW5pdHkgZG8gYmV0dGVyIGluIHRo
ZSBjb21wYXRpYmxlcy4gSSBleHBlY3Qgd2UNCj4gc2hvdWxkIHRha2UgYWR2YW50YWdlIG9mIGl0
LiBBcyBzb21lIHN1cHBvcnQgZm9yIFJvYidzIHN1Z2dlc3Rpb24sIHRoZQ0KPiBkYXRhc2hlZXQg
Y2hhcHRlciBmb3IgU0NVMSBjYWxscyBpdCAiU0NVSU8iIGluIHRoZSBmaXJzdCBzZW50ZW5jZSBv
ZiB0aGUNCj4gZGVzY3JpcHRpb24uIEZ1cnRoZXIsIHRoZXJlIGFyZSBvbmx5IHR3byBTQ1VzLCBh
bmQgSSBkb24ndCB0aGluayB0aGUgbWFwcGluZyBvZg0KPiAiY3B1IiB0byAwIGFuZCAiaW8iIHRv
IDEgaXMgdG9vIGRpZmZpY3VsdCB0byBrZWVwIHRyYWNrIG9mLCBjZXJ0YWlubHkgbm90IGlmIGl0
J3MNCj4gd3JpdHRlbiBpbiB0aGUgYmluZGluZyBkb2N1bWVudGF0aW9uIChhcyBsb25nIGFzIHRo
ZXNlIG5hbWVzIGFyZSBhY2N1cmF0ZSEpLg0KPiBUaGUgYXJndW1lbnQgd29ya3MgYm90aCB3YXlz
IGJ1dCBJIGRvbid0IHRoaW5rIGl0J3MgY29udGVudGlvdXMgdGhhdCB1c2luZyB0aGUNCj4gaW5k
ZXhlcyBpcyBfbGVzc18gZGVzY3JpcHRpdmUuDQo+IA0KPiBUaGF0IHNhaWQsIHRoaXMgaXMganVz
dCBteSBzZW1pLWluZm9ybWVkIG9waW5pb24uIEl0J3MgdXAgdG8geW91IHRvIGRlY2lkZSB3aGF0
DQo+IG5hbWVzIHlvdSdyZSBnb2luZyB0byBwdXNoIGZvci4gUm9iJ3Mgc3VnZ2VzdGlvbiBzZWVt
cyByZWFzb25hYmxlIHRvIG1lDQo+IHRob3VnaC4NCj4gDQpVbmRlcnN0b29kLCBJIHRoaW5rIEkg
d2lsbCBrZWVwIGFzdDI3MDAtc2N1MCxhc3QyNzAwLXNjdTEsIGFuZCBJIHdpbGwgYWxzbyBhbGln
biB3aXRoDQpPdXIgZGF0YXNoZWV0IGdlbmVyYXRlcyB0byBiZSBjb25zaXN0ZW5jZS4gc2N1MCBh
bmQgc2N1MS4NCj4gQW5kcmV3DQo=

