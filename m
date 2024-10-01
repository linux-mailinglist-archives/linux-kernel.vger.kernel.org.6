Return-Path: <linux-kernel+bounces-345408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D70FE98B5F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F0F1F22558
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8FA1BBBF4;
	Tue,  1 Oct 2024 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="NrVG0kyZ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2087.outbound.protection.outlook.com [40.107.117.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F90156962;
	Tue,  1 Oct 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768717; cv=fail; b=gMT39fPQj9eIJsdZlzYm3fU8WSQnnPXln6z1uHov9L4/W5/VvxjQ+McV+QrKsYm/x5DEPrqPM9iJq2YtMpsgQDZJtR4n9CB4uEC+yTxv82043/jGG1QiWSdKZTuVvHVhjrbazJnkI7DA6qVA2swkO+Mzxsx91QQfgseUM7nKs68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768717; c=relaxed/simple;
	bh=oxLlAOKXT1RUE6aTQ7gMw7e35C9QPqBg78k/owbHzuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D8+tr4Pr36O5L57r3RWhPDkqCTbASUY4Fo7WhXVjzBQRzqqtSObIayd5SjuDMwNcNr5FZan9DHqNQtGRQKtqyvWjfU/nRSic97E6bwukSG7sBYB5QH1EEN8KkdIxl0ddkpM4pzkAQXN2mBcOuUQajg6KtcSjllVQ2a0URi7NKS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=NrVG0kyZ; arc=fail smtp.client-ip=40.107.117.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5p4p+siFTZwy38hpy0SofiCvRzQ7DW/AQ0JLjxD/Bprry693EU5P/dIeBf5AuHZdXbgELA6J8MDIhaJxDqEoLHJ/IEfYEkrNW2c81xB56f1HrNCYNABAQcXCEPeA5KBc2/s88bMoPj8vuUCpkTkP4sW8qDHClTwo63QCoXmKvAH8+OPUBQY4MQCZn7yf/dbkBpsFDCdhMB6bG9MrlRTb9RChmRzssEkVlh5cMsQVvAu57MHF/ZQgnz5cRNICl7QaisFxluZvlNEsqXPAm94yBl+rxzoKN+l+C5+Lv+mK0bVjEMlH8qVkIYjLaUTLQV5dqnuYdJCg/FPnemj3IzyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxLlAOKXT1RUE6aTQ7gMw7e35C9QPqBg78k/owbHzuc=;
 b=s8JGBgnU1Yvk0UiI92NZHttuBHSSaZDfiigdYvIjmsFd5Y4m7O9ankT140bqVNkqJajwcp9x9GqHx8hme0rLeaf0+3XvwoJp+BGENAwgcaNbJhCAQsm81bOG+YRXATNuXNPSUJb8RynMRbJ8PxTzTCMC77ZSAzve0kX+4XLKXL4W4zHCI2O8Rc64NoeBfsDbasY1uBrINzZL/+LPtB4joT6vlYiSWYgWrdbevIUUpHVV78DIezHdierF3B0cI7HogQCg31B9Y0fGM9LBDI7iHAavJ+6s3X1Ab26jEDo/gy1/vFpXgsOpnVtjjwT5Ow1TX6wfm3YMu9909QMsh8cUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxLlAOKXT1RUE6aTQ7gMw7e35C9QPqBg78k/owbHzuc=;
 b=NrVG0kyZMM2ToeeFMOf4f29UCOu0zfjn3geOhpbIT+LPCxdzlCtgo1e4IKZlFUiPkvgRXPlQYq+hwRORlEoQONEEWWhEU3+BkCFv6sM60o8NiaDTs3o386bZvK+xqdH/FzGMFw4jqREsWBFpNEjmcJEihDT/XHIQ36FeYShj+fztcFJSdK/ynTT4tW6aRiWKM+tAIr5m+2nPD7tFV7Q4YSIs7CHXFdN7cuizXrfDGOaxoemgsbqsQQR6VKH2VSpgNNhHAlxdsx5bG6Qr7MjbMt9h6UV8pUvC13834f+mOxvdslIjGF5lmhBWFJs+2Qp0iQ8KY553L0gKNdzv47w3Yg==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by SI2PR04MB6129.apcprd04.prod.outlook.com (2603:1096:4:1fa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 07:45:11 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 07:45:11 +0000
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
Subject: RE: [PATCH v1 4/8] ARM: dts: aspeed: yosemite4: Revise address of
 i2c-mux for two fan boards
Thread-Topic: [PATCH v1 4/8] ARM: dts: aspeed: yosemite4: Revise address of
 i2c-mux for two fan boards
Thread-Index: AQHbEwce/StlEYMjVUCWVzKhyOD1W7JxDqgAgAB2pNA=
Date: Tue, 1 Oct 2024 07:45:11 +0000
Message-ID:
 <TYZPR04MB58537972801CB54C46AF0C27D6772@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240930070500.3174431-5-Delphine_CC_Chiu@wiwynn.com>
 <9c0a5a8247622e094b927f2c26550d3ce9af5896.camel@codeconstruct.com.au>
In-Reply-To:
 <9c0a5a8247622e094b927f2c26550d3ce9af5896.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|SI2PR04MB6129:EE_
x-ms-office365-filtering-correlation-id: 62b8699a-148b-4b30-48e3-08dce1ecfacf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UktranRpcDdaWmtXazlSWlJzUktTWXVPYUpJVDBMVGd4dTFUV2JUYXhUbjcw?=
 =?utf-8?B?T3NhM1VSNG9HQmNXdEhOVkwvekcwRzAvTVo5bFRSYnZJYlBMVGtKV2xYbFBk?=
 =?utf-8?B?emJDZ3pMaldycVd1eFk4czQvaWMzL3hPVmFlRFN1SDVHTnlMMG9tNzFOd0c1?=
 =?utf-8?B?MkJiRHAyRTB5dDJCSWR3Nmh3KzJ0QndmWVhPVmdVbFF2VmNEdHhNZHkwYXdZ?=
 =?utf-8?B?d2RySG1USjJaNmkrY2p6VzF4QWZDS2JXYzRGNExyUU85Smc3akgwODlqczJR?=
 =?utf-8?B?d2dWOXJqbFordjFzVG1FVHJWUGx2eTZqL3JPZnYvd3NqODJ2Q0VuMm5FRUJr?=
 =?utf-8?B?Zjh0S3Y0QzZ3NmsyVXJ4N0oyekhqWFMxUm5NdEpzSElGRUsyNnRrc2J1S0d2?=
 =?utf-8?B?QVRIUFM1cThlSm5ycG9wTEtoU2VvRmxRN3lLS1FNWFdreGRMUDN2b3RHQkNx?=
 =?utf-8?B?eVpZbjkzS3o3QmJOWXRUdERneFVWR1FQemVNbWJ2N2h5UkNvbWlVSnhKN3p2?=
 =?utf-8?B?cHhkR0todEtxWElQbktZVW5hZXhxRk9jQ2YyaXZ0bXE2Q0hrTm5aMjg0QTF3?=
 =?utf-8?B?Wkd0YmQ2V20zLzRpY2srZEEyT3c5bDB3eHc0ZTkrMDQwK2kzS1ZqKzlrUHlR?=
 =?utf-8?B?L3pVSjJkN3RLeXpWYVVPdC85aTR4MThEM050KzhFVitlVzU0S0FRaE9CeWI0?=
 =?utf-8?B?WFB2cVNlN3gvRDMzWGZCaU9CR2c0SkJEc3prU2VMNWZZeUdVU2RmS1pGNXNU?=
 =?utf-8?B?dWZhN3J3T2o1WjlvYll2SnYxcXMvVDRSajcwZEl3T3U3UTl6TmNBeFE5eUFl?=
 =?utf-8?B?YXVIendmbEQreHNFaVJhQWNnOXA3Rnp1T3IrU0ZhOTJaQjQ3V2UvQllRSjdj?=
 =?utf-8?B?MTllOVhlUS92My80SXFrK2Q5MS9TZGlFMDdHQ0xVNkE5SEkwYUlJbXgwYm1F?=
 =?utf-8?B?Z09aK2M1bmd6aUZUcDEyZTMrV1F1MjlMSDd3azRIV3FtVnk4QVE5blE3VUFr?=
 =?utf-8?B?T254b0VNaGk5MkJHL2k4UmNWS1VKcFgrR3FsU01xNkhWUEEyQnBVUnUxb2px?=
 =?utf-8?B?Tk9lTkFvYjVJQzdEZkpsUkpHVGF0aGFEazQyOWpZK29KdC9TWVFMczBlWjhG?=
 =?utf-8?B?QmFtTHI0Y1lrRVIrdlRzQmUrTXg1cytZazhrV2IzdmJDNjk0Y0VKbXVncUtl?=
 =?utf-8?B?SHRiU1RyQ1pxWitRV0pQWVZIQ1FiNXk2aS95K2VFemc0SXlzU3NzNmc0SSs2?=
 =?utf-8?B?MEx2S2VIT0hSbDYwWnp3ZzNFZi9MNEVBNjE4NGVxemdyR3YvK3FpeWQ0K254?=
 =?utf-8?B?b1B2aW45aytSVTA2aVJBUWhFYkw4aTJxOHJOeW1Ua1VMNGMyeWZ2MnY2ZmMy?=
 =?utf-8?B?UWFpVXRmdHIxZld0R1dBRmgwVVpaQnZ1WEhtWDdEKzdoSTgwcnhxdERyeW92?=
 =?utf-8?B?MDY3RW1iZEVkM3RtNVJoNEVabDJGdXN2Nk9BTUp5VGZFVVlGU01UQzErQ0xH?=
 =?utf-8?B?VlpqTW9JMmFDVXpLZUx6RWV0YkYvSXhVRHp6R0NoUXhGRnZXWGdTRWNHMERB?=
 =?utf-8?B?RUJsbmZFY1pxQTcvNDRESUxWSDlVZENMT1g0ODZwVlUrNWI1US9XMzZCeFBK?=
 =?utf-8?B?RDdhYlhPb1RGUS9RQmVhTlh6WEd0RlFFOElQSDk4RExwRG9iZWNIQ1dwSkZR?=
 =?utf-8?B?TzZZaXM2WVNlNUttbmVqK3cwMWZpYVlPc2I4M1VVRW9JbW5xVU1SZWNjWmZL?=
 =?utf-8?B?SHEreFRLRDRkQkdvM3VZZWdUK3pwa0lHbnRwNlpGY2RGd3QxU1JjVjF1Q0E4?=
 =?utf-8?B?U2swejY0eERCQUFVRTNMR1dWaUVHaUZXTnlYK1BkYUswV1ZTMlhac3F2RnNH?=
 =?utf-8?B?MngzdVZGeGRvTXZkZGZhV2ZXVXNUNEk2TjJyNklZQ2FQN3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXk2N0p0VVFKSDRXNUFNWWdQdm5MTGU4WlJnV1BMbXNDN3FsWmtVV2xZc1dC?=
 =?utf-8?B?a2d6bjJjb0VDNnZqeUxxcUpkblQzdUJIUkFlZHVxZE0wZTgrRTdoUzZ2d2tx?=
 =?utf-8?B?UnQxNTFqYzNDK1doeG5FMGpqRnhmOVk1VWJ6OGVCYnR6U0JLSlRiU2xoWnhp?=
 =?utf-8?B?c2tSb0g5Qy91S3BLcElMdEE0d1haNmE2V29mRXgrT2FOazQ0VFZBNDZXZ0lI?=
 =?utf-8?B?RFBwSVpPRzRkY3NNNVJsbnVZTWRHY2ZFenNoK0JMV3F3Rk8xOFVRcXhqMDFj?=
 =?utf-8?B?VmJNejNtK3ZyOU84UlR4Nkx4UUl2a3J1aW45WFBybER3WGluOERMM0NEL3N5?=
 =?utf-8?B?cWtOa0lKZE5BRmFUaCt2SGx5a0VOMVpFekZXOTdXbGpDOWtkWk1Hank1akhT?=
 =?utf-8?B?YXBkZUhCcGRXSExZQUtwclovTHVTUVBMU2VZVllOWXFHakZ5dk5aTDY1V01U?=
 =?utf-8?B?aW9qUWNZK2FJU20vbS83MlVWc1JOUGduY1FoUWZPd2szd0hLL0pEN0hycTRJ?=
 =?utf-8?B?b0hqNXUrTG1iREJiYWkvNUg3dE56RmNqdFRRTmY4ZUtDYTJQUHQ2VlFJanpP?=
 =?utf-8?B?MmpFa1pjT09wSWFwTWFtMkN5Z1JpYW5RZ0IzK0N0bDBxMnpKUlZmZ09KSkp5?=
 =?utf-8?B?bGxTZENveW03MFBNRG9rMFUrUTVNUnhmRTZmcndPeW5DdHNkTGtWbWlXOHZP?=
 =?utf-8?B?QmlBWnFlUE9RN3o3QnE4QS93RkloYkhReG1PVG9GNEZ4c3BrMGJGL2lIVmw2?=
 =?utf-8?B?T1pwYXAyRFRTamJsSk9sTkhxbHBuY2xrUTdlaGVFMXE0TkZ0cTdCS3plK0wr?=
 =?utf-8?B?WVR2dy9odjhuZDVIRzFuTXpIVzk2dXFDbVVoRGVUQTE4WVFRQm5ralhvRWE5?=
 =?utf-8?B?VEVyT3VSQ0hISzlPZHlYcFZOeXhjRHBLbkJERzNNdjZjWGJCRUJoSkF2aDF1?=
 =?utf-8?B?Q255dXhNZEM2VzAzWEppQWxuMzR5UmI3dEs3UWEwaTlidVMrQnNwK3lyeGpS?=
 =?utf-8?B?Q214OW5sT01RSXpLL3J1WVlpVmtCODQ5Y0ZPRmtVeVJNOERIa0NuNW9Kb3du?=
 =?utf-8?B?MTAyYWY2TWw5eEQ0UDBBVXY5NzA0TDdzQk9NUUczbUxCd3hWMStKdDZjcXpu?=
 =?utf-8?B?NFE1b3BhYUN4NW56K3NRcE5DUXh5Zzh2Wnp0aGFmbHpBcDZYazZveHN4K25s?=
 =?utf-8?B?dHlNcVFJWWc1bnZidE1TeU9RYkYvMTB6UE5xL3ZGeEJ3T1ErbU1xbENQL0hC?=
 =?utf-8?B?VE9OMWVmdnV4T0xnclhKR3JQTXROcnAwZ3dkLzQxZzJ3V2QwbllRNlA2aVB4?=
 =?utf-8?B?dlZxQ2E1NlE4UnZuanlVd0ZlcFNublpHcjdKRjJzV05iM2ZSK3BVYm5nU01z?=
 =?utf-8?B?MVJIWlZDdnFjZzZXSmhIamo5NW9oM3dxODljQnhjc0ZUemdRaVVySFdhcmNF?=
 =?utf-8?B?SVlGcnk3MXlrTDgrR3N6eWszcFRWOVlvb1QyanRuVDJ1NGlONU4rVGRhdG8y?=
 =?utf-8?B?My9HdFI2VlEyOFR3RlA3VURla0ErN2xnZjRoaGdpcFYwT3N6NHEyeSszSlN2?=
 =?utf-8?B?OG1OZGpGQ0VtRTZmeE16VXBKVkk3c09INHJGVFJnRk5TanY5djczM3M3Sjl4?=
 =?utf-8?B?Yi9nbWNNTllZcDh3VlhnMGo1aFRwUkt2WWhLWXJQLy9wZDF5UlFLKzg0b3BO?=
 =?utf-8?B?allHeGFiWlN4NDhtWFJUV1lOaE45VkFIU0hSM2xYMU9PZ3dhQjhpQnhkNlhy?=
 =?utf-8?B?bHFyZVNNdUpsTHh0Y2JGazBDS0w3bVNSdDBtNkdXY01SS3pkcjdGN2lVM3Z0?=
 =?utf-8?B?YmJCS0ptdy9lOG9JekZxQ25TR1MyVVRGZzdlQzNkTi96c0xIMzI0bHk1ZWR3?=
 =?utf-8?B?WFpnWlJKd0trUjk4T0lUUUZrUjg0eFUyZHdYODg2K1k1QWtwWkN0eUFkTjBS?=
 =?utf-8?B?dlhZN3Y5R3BHdkNNdzROZDROVjNBeTFqaTUyRDQ2bk05WmFvZ3JTci9LQjBV?=
 =?utf-8?B?SittRTZaMXBFV3c3ZU56dTRFT1FJZUI3ZWR0OWt2M3JiKzhqazNNVGdYcGt0?=
 =?utf-8?B?SkIwYWUrdmc0OXBBejVhRW05T0RoN0NYSEJ4UWowRVRRbnUwK2lVcXBTakt4?=
 =?utf-8?Q?VxUZiAZV3dWicW7TpfmSIXQ9Z?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b8699a-148b-4b30-48e3-08dce1ecfacf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 07:45:11.5769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYlQiXEyPPlSE+VOr1xts7OM2/rflNc1k1i4VK3xIIk5ufmyw4jtKeEYCsUjmR2VQsEMKIWVsecDciEuZLYkMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB6129

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAx
LCAyMDI0IDg6MzkgQU0NCj4gVG86IERlbHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4gPERlbHBo
aW5lX0NDX0NoaXVAd2l3eW5uLmNvbT47DQo+IHBhdHJpY2tAc3R3Y3gueHl6OyBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6aytkdEBrZXJu
ZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgSm9lbCBTdGFubGV5
DQo+IDxqb2VsQGptcy5pZC5hdT4NCj4gQ2M6IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53aXd5
bm5AZ21haWwuY29tPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MSA0LzhdIEFSTTogZHRzOiBhc3BlZWQ6IHlvc2VtaXRlNDogUmV2aXNlIGFkZHJlc3Mgb2YNCj4g
aTJjLW11eCBmb3IgdHdvIGZhbiBib2FyZHMNCj4gDQo+ICBbRXh0ZXJuYWwgU2VuZGVyXQ0KPiAN
Cj4gIFtFeHRlcm5hbCBTZW5kZXJdDQo+IA0KPiBPbiBNb24sIDIwMjQtMDktMzAgYXQgMTU6MDQg
KzA4MDAsIERlbHBoaW5lIENDIENoaXUgd3JvdGU6DQo+ID4gRnJvbTogUmlja3kgQ1ggV3UgPHJp
Y2t5LmN4Lnd1Lndpd3lubkBnbWFpbC5jb20+DQo+ID4NCj4gPiBDaGFuZ2UgdGhlIGFkZHJlc3Mg
b2YgdGhlIEkyQyBtdXggZm9yIHR3byBmYW4gYm9hcmRzIHRvIDB4NzQgYWNjb3JkaW5nDQo+ID4g
dG8gc2NoZW1hdGljLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmlja3kgQ1ggV3UgPHJpY2t5
LmN4Lnd1Lndpd3lubkBnbWFpbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGVscGhpbmUgQ0Mg
Q2hpdSA8RGVscGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYXNw
ZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGU0LmR0cyAgfCA4MA0KPiA+ICsrKysrKysr
KystLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDM3IGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvYXJjaC9hcm0vYm9vdC9kdHMv
YXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGU0LmR0cw0KPiA+IGIvYXJjaC9hcm0v
Ym9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtZmFjZWJvb2steW9zZW1pdGU0LmR0cw0KPiA+IGlu
ZGV4IDI2ZTBmY2JlZDhkMi4uZWNmMDEyYzljYmJjIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWZhY2Vib29rLXlvc2VtaXRlNC5kdHMNCj4gPiAr
KysgYi9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1mYWNlYm9vay15b3NlbWl0
ZTQuZHRzDQo+ID4gQEAgLTMyLDYgKzMyLDggQEAgYWxpYXNlcyB7DQo+ID4gICAgICAgICAgICAg
ICBpMmMyNyA9ICZpbXV4Mjc7DQo+ID4gICAgICAgICAgICAgICBpMmMyOCA9ICZpbXV4Mjg7DQo+
ID4gICAgICAgICAgICAgICBpMmMyOSA9ICZpbXV4Mjk7DQo+ID4gKyAgICAgICAgICAgICBpMmMz
MCA9ICZpbXV4MzA7DQo+ID4gKyAgICAgICAgICAgICBpMmMzMSA9ICZpbXV4MzE7DQo+ID4gICAg
ICAgICAgICAgICBpMmMzNCA9ICZpbXV4MzQ7DQo+ID4gICAgICAgICAgICAgICBpMmMzNSA9ICZp
bXV4MzU7DQo+ID4gICAgICAgfTsNCj4gPiBAQCAtMTA2Miw2ICsxMDY0LDggQEAgZ3Bpb0AyMyB7
DQo+ID4gIH07DQo+ID4NCj4gPiAgJmkyYzE0IHsNCj4gPiArICAgICAjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCj4gPiArICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiAgICAgICBzdGF0dXMgPSAi
b2theSI7DQo+ID4gICAgICAgYnVzLWZyZXF1ZW5jeSA9IDw0MDAwMDA+Ow0KPiA+ICAgICAgIGFk
Y0AxZCB7DQo+ID4gQEAgLTExMjIsMjAgKzExMjYsNTAgQEAgZWVwcm9tQDUxIHsNCj4gPiAgICAg
ICAgICAgICAgIHJlZyA9IDwweDUxPjsNCj4gPiAgICAgICB9Ow0KPiA+DQo+ID4gLSAgICAgaTJj
LW11eEA3MSB7DQo+ID4gLSAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54cCxwY2E5ODQ2IjsN
Cj4gPiArICAgICBpMmMtbXV4QDczIHsNCj4gPiArICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
bnhwLHBjYTk1NDQiOw0KPiA+ICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+
ID4gICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPg0KPiA+ICAgICAgICAgICAg
ICAgaWRsZS1zdGF0ZSA9IDwwPjsNCj4gPiAgICAgICAgICAgICAgIGkyYy1tdXgtaWRsZS1kaXNj
b25uZWN0Ow0KPiA+IC0gICAgICAgICAgICAgcmVnID0gPDB4NzE+Ow0KPiA+ICsgICAgICAgICAg
ICAgcmVnID0gPDB4NzM+Ow0KPiA+DQo+ID4gICAgICAgICAgICAgICBpMmNAMCB7DQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
cmVnID0gPDA+Ow0KPiA+DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGFkY0AzNSB7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtYXhpbSxtYXgxMTYx
NyI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MzU+Ow0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+ICsgICAgICAgICAgICAgfTsNCj4gPiArDQo+
ID4gKyAgICAgICAgICAgICBpMmNAMSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICNhZGRy
ZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9
IDwwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDA+Ow0KPiA+ICsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgYWRjQDM1IHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb21wYXRpYmxlID0gIm1heGltLG1heDExNjE3IjsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByZWcgPSA8MHgzNT47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IH07DQo+ID4gKyAgICAgICAgICAgICB9Ow0KPiA+ICsgICAgIH07DQo+ID4gKw0KPiA+ICsgICAg
IGkyYy1tdXhANzQgew0KPiA+ICsgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJueHAscGNhOTU0
NiI7DQo+ID4gKyAgICAgICAgICAgICByZWcgPSA8MHg3ND47DQo+ID4gKyAgICAgICAgICAgICAj
YWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+
Ow0KPiA+ICsgICAgICAgICAgICAgaTJjLW11eC1pZGxlLWRpc2Nvbm5lY3Q7DQo+ID4gKw0KPiA+
ICsgICAgICAgICAgICAgaW11eDMwOiBpMmNAMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IHJlZyA9IDwwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8
MT47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgYWRjQDFmIHsNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInRpLGFkYzEyOGQ4MTgiOw0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDFmPjsgQEAgLTExNTIsNiArMTE4Niw4DQo+
IEBADQo+ID4gcHdtQDIwew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBncGlvQDIyew0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAidGksdGNhNjQyNCI7
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MjI+Ow0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdwaW8tY29udHJvbGxlcjsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAjZ3Bpby1jZWxscyA9IDwyPjsNCj4gDQo+IFRoaXMgc2Vl
bXMgdW5yZWxhdGVkLiBTdWNoIGNoYW5nZXMgc2hvdWxkIGJlIGluIHRoZWlyIG93biBwYXRjaCB3
aXRoIGEgYEZpeGVzOmANCj4gdGFnLg0KPiANCj4gPiAgICAgICAgICAgICAgICAgICAgICAgfTsN
Cj4gPg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBwd21AMjN7DQo+ID4gQEAgLTExODEsMTAg
KzEyMTcsMTAgQEAgZ3Bpb0A2MSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4g
ICAgICAgICAgICAgICB9Ow0KPiA+DQo+ID4gLSAgICAgICAgICAgICBpMmNAMSB7DQo+ID4gKyAg
ICAgICAgICAgICBpbXV4MzE6IGkyY0AxIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcmVn
ID0gPDE+Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgIHJlZyA9IDwwPjsNCj4gPg0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICBhZGNAMWYgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAidGksYWRjMTI4ZDgxOCI7IEBADQo+IC0xMjAyLDYNCj4gPiArMTIzOCw4IEBAIHB3bUAyMHsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgZ3Bpb0AyMnsNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInRpLHRjYTY0MjQiOw0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDIyPjsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBncGlvLWNvbnRyb2xsZXI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgI2dwaW8tY2VsbHMgPSA8Mj47DQo+IA0KPiBUaGlzIHNob3VsZCBnbyBpbiB0aGUgc2Ft
ZSBwYXRjaCBhcyB0aGUgaW5zdGFuY2UgYWJvdmUuDQo+IA0KSGkgQW5kcmV3LA0KSSdsbCBzcGxp
dCBhIGZpeCBwYXRjaCBmb3IgdGhpcyBpbiB0aGUgbmV4dCBzZXJpYWwgcGF0Y2hlcy4gVGhhbmtz
Lg0K

