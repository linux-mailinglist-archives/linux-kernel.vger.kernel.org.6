Return-Path: <linux-kernel+bounces-348686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D5998EA8D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0FCBB21E87
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413611272A6;
	Thu,  3 Oct 2024 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="3EoZ5nfj"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2053.outbound.protection.outlook.com [40.107.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7143E499;
	Thu,  3 Oct 2024 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941347; cv=fail; b=eHS4NJh1r9lVnjHxJ1sxU7UxKS6IrEV/fsb9/2qeNy9qchQWTzctWFpso3AUtyU08RVQN1b97G5bEOWfxrwnsk1z1nH9ftNw0LE4MhMraFmE6OywIgRngc/rFIynwwT1BdOkfEogI5kxbGGTAq9LC0haQp2Lz8OcYjvxtRH1EcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941347; c=relaxed/simple;
	bh=2DHPTlGl1K/RAuH5Z+lWRmHW86NeAnR4ddj5yoRJIOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nbwSxRrfCqAknGQYTExG9/Dr0BBuemx06/QQnjZWnW2JTCKJ+WdBybHYAscaLJ1lEved1B7SborxqDww6SfMhUrMHkIe/9JBhZLDNSCHlzG6rGqtOHoaCvUN2YBY9cQzCsQKQxU6237UXHaNDT7VT3AgULLop7+h6pTRGqC6hcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=3EoZ5nfj; arc=fail smtp.client-ip=40.107.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwMTJ0PUoZk2aUUhFLV2DqIW3TaVfQ0WsmAqazO9Apmnq35JX8IfZgrTE23VWFyLsyXqywqX9ysCvy9maB258lxhHO57malXVIXquoLK7iU3VyNKrUCpIVY9QI1C6FcGnlfHJAHP83J1/JG+IVyA3iFxhk53tsu7+W90TFxlOwi26WYOXQyd3U6k1Y/AllLvbaBObwINNdhD0gJtneI6IXw8h0w8s6fb28AAOhCoKyrr1bMCD7BMo09NSaKY6F07CEAhFBRmOOZsthd62xpg2atVsbIO6eXRMbZTLmrLTl7ukDjH0MQ4UhYrYHm0J1tFuCfk1TsH4iOYMjQPrJUSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DHPTlGl1K/RAuH5Z+lWRmHW86NeAnR4ddj5yoRJIOY=;
 b=ZQM7p9KBaCxSYrD3a/o703tabWYeNx3EIEFgSfR2UFdAYzKrcuP3O5kP1vJoklzNh/EBVjyDh4nOR297s2n/vKUCcOJcfGMwJL+E9HvRYVU5RiFpAeKsUkXo7PMmLTIg/JNDtmKbecQgpuFmPr89FOB8qOxw9zqtOwE5XJ+mQOXlxCVDHZXT2Ujsoe52/SWc5qxwB7eGkXuvNGN30d1WnACKkBYFpW8Ab6BgPiSYD02uBDNz213MW1NmpESqhGuWtfQyJG91xq8MPQEscEFur/eKg4xOzalkOclsO4HlwFKhvE3gwyBYMh+qLsImizCrJmdXG5P4LFMozWcV1JVubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DHPTlGl1K/RAuH5Z+lWRmHW86NeAnR4ddj5yoRJIOY=;
 b=3EoZ5nfjqUMrcfJsoaSI3kbvegnUEHU4RpTKLY1QJPb3PufPq2riOppUm0AROo6YBk1Df2RZqUbQR9Cw91UUinpjj8Kd0OKwnE9qIUAVxfGCu5L1c/4fE6uDZUQjH8WwYZ+CPj0yXtaNzHM4uGsGn5hZn/KEUswrw2gBd9I4K0ePUrxf0W6o1Bu0jJBRAvd9foQ1wp3Qgls6t6xuqt/xK+UQyQeFtCT+B5p3/2IieFYYBUwB17djV8NsZCbf4Zw5hkjspjTevUsWFmZT8HsjP0Nw96a5uCoOkONkgmt2AwlsiUCHKHvOSwzPYa0QMoH28KT4Q0vdVv0prcT2bw152g==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by JH0PR04MB8088.apcprd04.prod.outlook.com (2603:1096:990:a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 07:42:21 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 07:42:21 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/8] ARM: dts: aspeed: yosemite4: Add i2c-mux for four
 NICs
Thread-Topic: [PATCH v1 2/8] ARM: dts: aspeed: yosemite4: Add i2c-mux for four
 NICs
Thread-Index: AQHbEwcaMrmlQxTcsU+R+KRlEx+LtrJxDhuAgAB3jQCAAS51gIAB9Q4w
Date: Thu, 3 Oct 2024 07:42:21 +0000
Message-ID:
 <TYZPR04MB58532C9A6FFB916888D664F5D6712@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240930070500.3174431-3-Delphine_CC_Chiu@wiwynn.com>
	 <fffb98e40d407c68dc3de6fd21c8a724be96e38a.camel@codeconstruct.com.au>
	 <TYZPR04MB585305DCD18AF723B8A48480D6772@TYZPR04MB5853.apcprd04.prod.outlook.com>
 <ac786013183162b78181de85fd72b1eb7df81e3d.camel@codeconstruct.com.au>
In-Reply-To:
 <ac786013183162b78181de85fd72b1eb7df81e3d.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|JH0PR04MB8088:EE_
x-ms-office365-filtering-correlation-id: 765947f0-9dee-4390-d2f9-08dce37eea2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YUltOHdVdHVDWGNHQ0swYTUvNGFMSFFFYlgyRlkxajd1UnV6c0lFbnNtdG91?=
 =?utf-8?B?WGNpRjMxaHpQVUEwbzcrekF3TEVoUFc1bDZSTEgyWFBqRFZnRnVxSzFXSytU?=
 =?utf-8?B?RTNtT0U5NHFaUFNDaHUwOGJGWU04Q1Q1NTM4V0ozMWU5WUh0NWZzRktKVWlt?=
 =?utf-8?B?Vm1yN0F0OFpzYzRqY05uYnk0MDhoOTdqVWI1d1VYa29CQ0QwejlJQ1BDVndp?=
 =?utf-8?B?MDhnSnJGMzlycUFUMVVldm9JSnVKWk5UTXJCSURHQVhwTkxQZXdZbU1jMEp3?=
 =?utf-8?B?dzc5V3U1TWZSWm1oRUVTeWNKVlk1a3I1SG1ZZjVUVmxFdG5JVXFQSGVLVjBv?=
 =?utf-8?B?Rm1kU0ZKdXhBMkhGYkloNjdtZEpNZFNPSVlaYzVJWG91VGNuNUdZbk1SVDZj?=
 =?utf-8?B?VW52OGdlWlBQOW9TZW4xNmVVTEJhRnpvL2NveTdWN1R3Z3RrWWpsbE9hd0N0?=
 =?utf-8?B?K0J0aGJlQktHUVo2WDBRZGY2cHJwNVlYK2xzNXZVTW5sU0RUSEJtTjdLanZo?=
 =?utf-8?B?NU94Tk1wS3hhempEeU9uY2ovbmFYQkliMVFkWWdqNml5SW9QM2pRNUJ1YkNU?=
 =?utf-8?B?WTJKZDNoSjZHMnFYU0xkdkhmOWpyM3BNTmh5anhOcmhWRGVsZWJVczVXQjBZ?=
 =?utf-8?B?dkx3UGxmdWxLUGtrSitpTk5JOVltdHVENjFUV0QxWjB3NTlIM05MRzhUMUJa?=
 =?utf-8?B?THpTTy9hdG1lUy9mNk9RZDVPSHRrSk9uSmg3RWdSQTRsOWV4RFVmbkRpRzBl?=
 =?utf-8?B?R1c3RzZkZi9SSFFxYituWVl1emg1NjR0Z3VZSEJ2YVdYT0V5K3JNZWV6ZDhm?=
 =?utf-8?B?Ri8xQ1JyWTJnREVFekdqV0ZCY29uTnZqeThUc25ickUvQmZPeWNDcFZkd1M2?=
 =?utf-8?B?VnpmUUlidmFCLzgwUlRFSG1rb3c0K1g0Wm1mazdjSnpOSCs1SGZoL3hCNFBQ?=
 =?utf-8?B?eXNKUWpVRnUrSlRMdittam1DQmtFZjNjQWdnbGJZY1QzRmdmUXVTdllBNGU0?=
 =?utf-8?B?VzlVM3NzeWdQUXNaWkdSWStDRW9lYTBsdjdKZmtVdEhVWGxSdklRUFErYUt4?=
 =?utf-8?B?TEhkUTQ5cEFjRHZPaWYxVlgvR2kxV2xNd3NqQXF4SkMzWXJwTDI5QzJ0OG9h?=
 =?utf-8?B?NkQ3M2YvaDEyUXVobkUvMXRWUFVEZVlobGV0QTFCZEtzQ0RmTnhncEFpcklY?=
 =?utf-8?B?NnhmU1A2b0NsbWRkWTZ5endXZ0oraG1DSWZLVi93UUoyUFdxRTVuNGlHNkJF?=
 =?utf-8?B?bUE0ZG9zcUd0Smp6QUVKREk0a1o5QlMzMm5jZzROZEIvYmlsVCtaajhXaVM3?=
 =?utf-8?B?Zm1Fb0NybUE0QVd3SWJKWWNjVE9JN250K1RlTGZRRVdNMmZrWmZNUUlHeFpT?=
 =?utf-8?B?TUJkTDAxVndoYkUrY0xaNU5vOFE4RDRTRzFqUE1BcGpUaS8wTXFKbk9id1dw?=
 =?utf-8?B?c3JxOUJ5OUNTTkk5UUJuZ2Vrbm1BcVJoZnQvRGhyWWVEZFNaeERxUjJRTUJy?=
 =?utf-8?B?N2tuSGo0aWNBSjNzZUxxb3Vlc1BpSUNqN2RreVFLaGdQV3pBcHdURGpLQWJk?=
 =?utf-8?B?VlZIODVDTXUzbHJhYWx5Y2hSZUZyN1pxdFloUXk1YklZR2NBOThLMXFPVXV1?=
 =?utf-8?B?eW5yMmpzbG5sazh2R0hsTVQrZFVKQTBlMjlHWXlBU2FNaEFWVWg5b3dSVDF1?=
 =?utf-8?B?SytmWVIrRVhkOGQ1ZzVrME90S1A2eFZ0Sys5ODNZRzI3dVZWVDh1TmxZOTkw?=
 =?utf-8?B?Q1JxeDFkQnNVWmhDZDYxYW5hQzZJNkRSRlVvVk5VcjBVaDNacEljM2hoZWRS?=
 =?utf-8?B?WXZsWldjWjRJMDR6WkhqZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3MrckdVSHVCdTlDd0VJM2FvVzZXU041SHRmZ3hvVk9WV3J1c2Y2aEM4cjZp?=
 =?utf-8?B?cEVWS0hIZ3MrbXpQSkFKOXF1NGNLQTh1Ry9GVEJiVE5McC9uRzZwb1FZWXVX?=
 =?utf-8?B?ZVRrejhkKzlzNkNqWHI4YVJQUGMzRFU2TjBWVTZ3UVBSNVRNRmt6VUFEYmVS?=
 =?utf-8?B?MFJlZndYcjR2cUhmSk01S05MV3BQVWF6TXhpMHdON3QyWDZpdDAxZG9wNTVL?=
 =?utf-8?B?YnBYNnRpdzRjTU1LTHZNdGM4SElWQytJMHlTeE5ZM0ZpL1VaZjN6eTE4R0M2?=
 =?utf-8?B?VmZobkdQOXAvV29HdUJHMTl2Z01KdVFzb0JZdkJLVHpCdmtpMmNTWlM4NHBZ?=
 =?utf-8?B?QnR2RGljelRuSE1IaGZFK1MvNzZneStmWFlwQTU5RjZQKy9Ob1ZOZlM0ZE1F?=
 =?utf-8?B?Mmx6elJWMEI3ZjlQb0xQbDF3aitqZERlSERPOUt0QU8rRGtnR0dZczNrbnJV?=
 =?utf-8?B?ZmRaVWdnQXNRdnhUa01hSktxK09EU1lXbEgxWTlGQjZGbEp5THlBUjBBRFNX?=
 =?utf-8?B?VFNvaVNpMTRkWG9hcHRpNUxKNndJdC9TYXp1TkJtbDl0Q1lwU3BuRlYweUgy?=
 =?utf-8?B?WnI0NThJMlFVYzdHYnVJNFJHcjVkdnIxOUZnY3FJNHJVVXNjbm42bXFvKzJx?=
 =?utf-8?B?bXBXTVZ1Y3VRVjdCUGovVTZhaGxQdFRHV2RhU054aUMraXpMVWZXM3lKaGZy?=
 =?utf-8?B?K1AyQWFUS2V4M1psTHlyRS8yVEhwSHB6TEYrUkMzQ0hjMFQ5NE9NNGNnK2I3?=
 =?utf-8?B?dk5ZTlRkYUx6L0hTV0EyY1hjVFUyY3JrQmF0bndGZUpJRXVycm9acUlVRlhq?=
 =?utf-8?B?d0lxV0ZEMnZlSHJsRFlwVDN4ZXZFbWNhS2Vrc1BSWUNHSHk5Z1NpaEN3RFUy?=
 =?utf-8?B?OWhyOVgzMCtFbThyLzJmcTNzRUVicmYycmFMclYyZWRYNE5IS2x2VTk3TEJK?=
 =?utf-8?B?RzV1RDZ4NElMWmhYd1htN1ZwYzdIYzFVc0h6bkxCT1JSYTdvK080Y3RNNkRs?=
 =?utf-8?B?NG5DUVJ0VmdYT3lEUUtrd09KUlowWGNnT0ZnN3dKMXF1WmU1L2xGNHRnU2I1?=
 =?utf-8?B?ZUtyV0c5c2NkZUNrUmVnVWl0Nm1Pd0tHdHg5cUg3WWFsSHQyWnhyZ2NPL3pQ?=
 =?utf-8?B?Y25EUDVraUd4elJoTDJmYk54a3BDcXRVR0NoWVRZek9BN1Job1ZERGJQMnh6?=
 =?utf-8?B?d0k1eVRiQ0tWWXE4ZzR3WUt3dDk4cEo4dGEvSzdiekRNdk1QM0JEVTBGSU1y?=
 =?utf-8?B?Um85em9aaVVveTBGWkVJaWtyL0JpT0RpeUt0UjFSTkdtQWI1RWtwcFBEZFMx?=
 =?utf-8?B?R28wcVFVTmQzd3lIMFIwTS9GWVg0bE9lTmZLUjFNM1IwdUhaN0kxa2tOdGpD?=
 =?utf-8?B?ZVcwVmJDRFd2K0Zmdi9wRG5YMTZvMlZodUJVSFEwWTlTNVNNUVFvN0RUZGdV?=
 =?utf-8?B?VWZJbEd4N1RPS3pMa21XbnkwcElKYmFOVkdveTFSVDYzQzAxWXRqNit1SWF0?=
 =?utf-8?B?U3R1VGdmT3RnWnI3NWtnYmE3SklOM2UzbDg1dW0yUDRxMFZtRFgxYnRma0Qx?=
 =?utf-8?B?SXVpeExRYnJqQUNaSlEvT09rdXZ3Z2hjZURIdHpHRFZJMi94b1BjTEhQL3o2?=
 =?utf-8?B?Tk5lcHVKZ3ArMzZBNGdxUytpS01seW8wQjBmSkhabERNUElET3lyckxERXVI?=
 =?utf-8?B?QWtJaVJmRlY0a2FpMEtpVmFhakFSOXdWa2VmdTRiR1YxV2tOLzJUWE9YNnky?=
 =?utf-8?B?UmVGRmJ1RDN5TFBOTFBkbnVZQW0veEwrSnJRekc3TllFYmExS3NkTlA2NkhB?=
 =?utf-8?B?UTVsZWhicGNtRXpoaFRjbGZTeTFTUWxiSmt4QTJyaTV3akxUR1lvd1pIUTJQ?=
 =?utf-8?B?MU9ka1ZnNDd0LytMMGpWQ0lBblkyOUh5aVJPeVhtUjRHdTBVZ2VLaVJFc1hm?=
 =?utf-8?B?SlpoeUNGS083OEJwTzMxNk5JNW1qaE1jN3JnSXBkQjFkU01zZ1BPV1Jqd1hZ?=
 =?utf-8?B?bG9aOEVUM1JSUGFBUXRES28yYy9MTVZmMk9WeUpSK0lSQkpkV0xucE1rQm52?=
 =?utf-8?B?QmUxc0llbkhtdDNXbCt4NDlOSmk1YW5XZ00ycENiU3gvQnVVMVVnckdWUTg1?=
 =?utf-8?Q?Jk15EpFDl6iwXU2rldUnDcO/5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 765947f0-9dee-4390-d2f9-08dce37eea2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 07:42:21.3282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjhddv1mL47f/A8HPiVsOTW99JAhDaZbWBhrqd/HTuOWWtapq8LEnEioYURp4NAlmB5VLUpFXmknhg6ylPHCyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8088

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDIsIDIwMjQgOTo0OCBBTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8RGVs
cGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0BzdHdjeC54eXo7IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtl
cm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0YW5s
ZXkNCj4gPGpvZWxAam1zLmlkLmF1Pg0KPiBDYzogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1Lndp
d3lubkBnbWFpbC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJz
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxIDIvOF0gQVJNOiBkdHM6IGFzcGVlZDogeW9zZW1pdGU0OiBBZGQgaTJjLW11eCBmb3IgZm91
cg0KPiBOSUNzDQo+IA0KPiAgW0V4dGVybmFsIFNlbmRlcl0NCj4gDQo+ICBbRXh0ZXJuYWwgU2Vu
ZGVyXQ0KPiANCj4gT24gVHVlLCAyMDI0LTEwLTAxIGF0IDA3OjUyICswMDAwLCBEZWxwaGluZV9D
Q19DaGl1L1dZSFEvV2l3eW5uIHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0
LmNvbS5hdT4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMSwgMjAyNCA4OjM3IEFNDQo+
ID4gPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubg0KPiA8RGVscGhpbmVfQ0NfQ2hp
dUB3aXd5bm4uY29tPjsNCj4gPiA+IHBhdHJpY2tAc3R3Y3gueHl6OyBSb2IgSGVycmluZyA8cm9i
aEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+ID4gPiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVs
Lm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47DQo+ID4gPiBKb2VsIFN0
YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KPiA+ID4gQ2M6IFJpY2t5IENYIFd1IDxyaWNreS5jeC53
dS53aXd5bm5AZ21haWwuY29tPjsNCj4gPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBsaW51eC1hc3BlZWRA
bGlzdHMub3psYWJzLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MSAyLzhdIEFSTTogZHRzOiBhc3BlZWQ6IHlvc2VtaXRlNDogQWRk
IGkyYy1tdXgNCj4gPiA+IGZvciBmb3VyIE5JQ3MNCj4gPiA+DQo+ID4gPiAgW0V4dGVybmFsIFNl
bmRlcl0NCj4gPiA+DQo+ID4gPiAgW0V4dGVybmFsIFNlbmRlcl0NCj4gPiA+DQo+ID4gPiBPbiBN
b24sIDIwMjQtMDktMzAgYXQgMTU6MDQgKzA4MDAsIERlbHBoaW5lIENDIENoaXUgd3JvdGU6DQo+
ID4gPiA+IEZyb206IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53aXd5bm5AZ21haWwuY29tPg0K
PiA+ID4gPg0KPiA+ID4gPiBBZGQgaTJjLW11eCBvbiBTcGlkZXIgYm9hcmQgZm9yIGZvdXIgTklD
cyBhbmQgYWRkIHRoZSB0ZW1wZXJhdHVyZQ0KPiA+ID4gPiBzZW5zb3IgYW5kIEVFUFJPTSBmb3Ig
dGhlIE5JQ3MuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2t5IENYIFd1IDxy
aWNreS5jeC53dS53aXd5bm5AZ21haWwuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEZWxw
aGluZSBDQyBDaGl1IDxEZWxwaGluZV9DQ19DaGl1QHdpd3lubi5jb20+DQo+ID4gPiA+IC0tLQ0K
PiA+ID4gPiAgLi4uL2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRlNC5kdHMgIHwg
NzUNCj4gPiA+ID4gKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQs
IDcyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYg
LS1naXQNCj4gPiA+ID4gYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1mYWNl
Ym9vay15b3NlbWl0ZTQuZHRzDQo+ID4gPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2Fz
cGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGU0LmR0cw0KPiA+ID4gPiBpbmRleCBkYmM5OTJhNjI1
YjcuLmI4MTMxNDBiM2M1YiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMv
YXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGU0LmR0cw0KPiA+ID4gPiArKysgYi9h
cmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1mYWNlYm9vay15b3NlbWl0ZTQuZHRz
DQo+ID4gPiA+IEBAIC0yNiw2ICsyNiwxMCBAQCBhbGlhc2VzIHsNCj4gPiA+ID4gICAgICAgICAg
ICAgICBpMmMyMSA9ICZpbXV4MjE7DQo+ID4gPiA+ICAgICAgICAgICAgICAgaTJjMjIgPSAmaW11
eDIyOw0KPiA+ID4gPiAgICAgICAgICAgICAgIGkyYzIzID0gJmltdXgyMzsNCj4gPiA+ID4gKyAg
ICAgICAgICAgICBpMmMyNCA9ICZpbXV4MjQ7DQo+ID4gPiA+ICsgICAgICAgICAgICAgaTJjMjUg
PSAmaW11eDI1Ow0KPiA+ID4gPiArICAgICAgICAgICAgIGkyYzI2ID0gJmltdXgyNjsNCj4gPiA+
ID4gKyAgICAgICAgICAgICBpMmMyNyA9ICZpbXV4Mjc7DQo+ID4gPiA+ICAgICAgICAgICAgICAg
aTJjMzQgPSAmaW11eDM0Ow0KPiA+ID4gPiAgICAgICAgICAgICAgIGkyYzM1ID0gJmltdXgzNTsN
Cj4gPiA+ID4gICAgICAgfTsNCj4gPiA+ID4gQEAgLTExOTYsOCArMTIwMCw5IEBAIGFkY0AzNSB7
DQo+ID4gPiA+ICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiAgJmkyYzE1IHsNCj4gPiA+ID4gKyAgICAg
I2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gPiA+ICsgICAgICNzaXplLWNlbGxzID0gPDA+Ow0K
PiA+ID4gPiAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4gPiA+IC0gICAgIG1jdHAtY29udHJv
bGxlcjsNCj4gPiA+DQo+ID4gPiBXaHkgYXJlIHlvdSBkZWxldGluZyB0aGlzIGlmIHlvdSdyZSBu
b3QgYWxzbyBkZWxldGluZyB0aGUgTUNUUCBlbmRwb2ludA0KPiBub2RlPw0KPiA+ID4NCj4gPiA+
IFVubGVzcyB0aGVyZSdzIHNvbWUgcmVhc29uIHRoaXMgaXMgcmVsYXRlZCB0byB0aGUgTklDcywg
dGhpcyBzaG91bGQNCj4gPiA+IGJlIGl0cyBvd24gcGF0Y2ggd2l0aCBpdHMgb3duIGp1c3RpZmlj
YXRpb24uDQo+ID4gPg0KPiA+ID4gQW5kcmV3DQo+ID4gSGkgQW5kcmV3LA0KPiA+DQo+ID4gV2Ug
aGF2ZSBkaXNjdXNzZWQgd2l0aCBKZXJlbXkgZnJvbSBDb2RlIENvbnN0cnVjdCBhYm91dCByZW1v
dmluZyB0aGUNCj4gPiBtY3RwLWNvbnRyb2xsZXIgb24gYnVzIDE1IGJlZm9yZS4NCj4gPg0KPiA+
IEhlIHRob3VnaHQgaXQgd291bGQgYmUgYmV0dGVyIHRvIGFkZCB0aGUgbWN0cC1jb250cm9sbGVy
IG9uIGVhY2ggaTJjDQo+ID4gbXV4IHBvcnQgc28gdGhlIE1DVFAgZHJpdmVyIHdvdWxkIGVuc3Vy
ZSB0aGF0IHRoZSBtdXggd2FzIGNvbmZpZ3VyZWQNCj4gPiBwcm9wZXJseSBiZWZvcmUgY29tbXVu
aWNhdGluZyB3aXRoIHRoZSBkZXZpY2UuDQo+ID4NCj4gPiBJJ2xsIHNwbGl0IGEgcGF0Y2ggdG8g
cmVtb3ZlIHRoZSBtY3RwLWNvbnRyb2xsZXIgb24gYnVzIDE1IGluIG5leHQgc2VyaWFsIG9mDQo+
IHBhdGNoZXMuDQo+IA0KPiBBaCwgc28gaGF2aW5nIGxvb2tlZCB0aHJvdWdoIHYyLCBJIGNhbiBz
ZWUgd2hhdCB5b3UncmUgdHJ5aW5nIHRvIGFjaGlldmUuIEkgZG9uJ3QNCj4gdGhpbmsgaXQncyBu
ZWNlc3NhcnkgdG8gc3BsaXQgdGhpcyBvdXQgZnJvbSB0aGUgTklDIG11eCBwYXRjaCwgdGhleSBh
cmUgcmVsYXRlZC4NCj4gDQo+IEFuZHJldw0KU3VyZSwgSSdsbCBtZXJnZSB0aGUgcGF0Y2ggdG8g
dGhlIE5JQyBtdXggcGF0Y2ggaW4gdGhlIG5leHQgdmVyc2lvbiBvZiBwYXRjaGVzLg0KDQpSZWdh
cmRzLA0KUmlja3kNCg==

