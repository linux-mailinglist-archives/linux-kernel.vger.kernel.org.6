Return-Path: <linux-kernel+bounces-446760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA5C9F28D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5714818875E1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC140155312;
	Mon, 16 Dec 2024 03:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="LRsKC+zd"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2121.outbound.protection.outlook.com [40.107.117.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8BC1BF24;
	Mon, 16 Dec 2024 03:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734320100; cv=fail; b=DTzD3cobvj51Qxa6x9M9oFdueOyvhtx5JKfI71mv5q/AT91AdpVcf4/mGZC0wgXwtrUEgdMrkcIrupM82H76vn62jAnTpqFGKhFciBALa1CGkeG2tOI0Whj6qhhKqxux1WrQkhJIQSyvjBC/uW4hzJ7JdesYD/IM7fycgJwqF0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734320100; c=relaxed/simple;
	bh=Vnk88sYLBRKljOkLTnnJFRKY5Fo92aKoBXRPdaj2DgU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W84LvG4b5ypEkomfCu5zsS34Ltc3ZTItFHmYGIC83R6FYFz1QW1YikWm4ZOwFs9vocyXeD+bGp/aRwWEpGXNmLmlEmR1ZLMwiz95X7IxAcQQgMokKiI4y+xOJivs339XS/CZAh1GtAHbJgHNR84p/xl8auSAJ5tpH4UHegBgACA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=LRsKC+zd; arc=fail smtp.client-ip=40.107.117.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x55jjMQjpprkmMnqgYpmuojQ0Y+kgXcul6gojGhVug36ybB/ksYAlzxNa63axKRzQgmm+anaZBt2k9PN0L1b34sYI8cWUilS534M97gwKQy7pI55MpZ9oRpu26i0aNAd4u7S5Wk4X1hUjbuLLBtYP0VY/nmlM67Vr/ZGnb/xubBSAO/QFLxcRWe0HOsYcgHusUiEvYagjtITO5jNcTUPjKFIrnBXEX+UU77CxwtYdysDvMRgGMLxpir/cPTYxxh7XSIZ4C7gl20FJi4w87rm8WBPyCb1XgN9jh1E8FKV/eiyD9MG2hHIIjJWmr9RAxCgx8EWYPRkoB6RX5I5WyH1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vnk88sYLBRKljOkLTnnJFRKY5Fo92aKoBXRPdaj2DgU=;
 b=EodJMGyjv1LnYMLPoG6EkbIGUoBcLPSQ5IXMb2ycXvXx3+zF8r/fzawZZQIaxJoq9YgymLkb4E+eQZXfccuWvvJWgAPJS3Tp4OnGAyXACtrOz3Enl1MKV9O7Uhndc+sA06RCRVtRN2BMDyEzf1nJbyAFHQ1VUH7R+C6eeD/SaJW5V/562GJi3z8banOLEIxy4ODo/bi4tco2j88jfDvs1apUmh4Hochqh2k1WH13VBfcAnh8QBbjIOA3X2B2UNVf+KRcuAT7nFfwsuRzIOAAz0hT1h0PeaAMAZxxtz+BrQHLSwpbaOLVgM5nl6J3F9BQuBDhpg/6OHkaCotOdCCXDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vnk88sYLBRKljOkLTnnJFRKY5Fo92aKoBXRPdaj2DgU=;
 b=LRsKC+zdtSRs/6j6/54wWp5gimpI9ntpkvvicHauvUfk19n5aIyK8JWSk98AjoZsBK4AyBQP0CRYrmIC4fa30P2YDIf17ZIZXvQ6oiivZOJxpFkuedMSWptRiLhHST3iQDVPRU4bs8BAEk9PlLG72h72+/+j1hK1prBfKm4wTlXA7zWwJhWOyZRPq1+sM1bQyUKyRWZB+/Eunctt6aNcgTzPDiphr5iXn/AWG9tFyoRWLfPiPQnMZXIMIcjAePsGeKXDDfWxWQIBBuX3BXQ4f74RqSKq9HHOho6FrQNvbsO4fEhPF26EU2U+9GLO5SjFRfVNL2erYK1QwhOCVsz/ig==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by TY0PR06MB5459.apcprd06.prod.outlook.com (2603:1096:400:31f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.10; Mon, 16 Dec
 2024 03:34:53 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%4]) with mapi id 15.20.8272.005; Mon, 16 Dec 2024
 03:34:52 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net"
	<olof@lixom.net>, "quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"konradybcio@kernel.org" <konradybcio@kernel.org>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"johan+linaro@kernel.org" <johan+linaro@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "soc@lists.linux.dev" <soc@lists.linux.dev>
Subject: RE: [PATCH v3 0/6] Introduce ASPEED AST27XX BMC SoC
Thread-Topic: [PATCH v3 0/6] Introduce ASPEED AST27XX BMC SoC
Thread-Index: AQHbTK3jpAwOf3M7kkqeKzDuH2LfgrLjoJAAgASclEA=
Date: Mon, 16 Dec 2024 03:34:52 +0000
Message-ID:
 <PSAPR06MB49493DBCC874A32174E3C180893B2@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
 <5d91b7a7169e6db27b2493213d0df2b77699a49e.camel@codeconstruct.com.au>
In-Reply-To:
 <5d91b7a7169e6db27b2493213d0df2b77699a49e.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|TY0PR06MB5459:EE_
x-ms-office365-filtering-correlation-id: 05c7f18c-9561-4ce7-208f-08dd1d829a35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NURNK1hMbWs1WFFFNEhkc0ZDRzVPeGtRK3p4dUNnTHZwaTZSelM4V3dDSStV?=
 =?utf-8?B?UFRSeG9vWnlGeUxxSTI2cDRTdHhxbWMrYWxFNXljajRXdkRicW5aY2txYXJK?=
 =?utf-8?B?YVFnQkR0K3EwczIxam4zNW41d2Mrb01RRlJqL1Ryc1NSem1EYW9WOVRIL2Js?=
 =?utf-8?B?RmM3Qm10WTh1eStMQWNyYkJmaWVMTW56NlErUkJubXFYWDZ5bTFDWC9sZUJD?=
 =?utf-8?B?c2JOU1VKQjNUSjBTdDVORHpvb2IvWXZXNld5bTJhRjZSbytRd085N05MVENk?=
 =?utf-8?B?SVVZUWJXWTZmWXJiZmlCUEZORjlFbzduZDRlMUxVYWk0ZHNaWUdVQ1Z1Wmky?=
 =?utf-8?B?ZWVZb0N6YnNXeGpCSThKZmtMSlJTWVJsVWJrSnVUN0RSQXF5MVU2UTQ4VlVa?=
 =?utf-8?B?b1N0NzhzYzJVdS9NYW9BYitOaUs0SWF1K3YwVXRwcEtNSFNrS0pBQlprWUk0?=
 =?utf-8?B?eTg4QnQ3Q2tUOHJndko1QmlTd1JCdnk3SzAyV2JuRGhQWmF3TW9yNnhGOHAv?=
 =?utf-8?B?THlZT3VncXpudDlHZStFVkVlVm9ObTNjcFgxN1M2MkVjME9VUVJPQmpaTThD?=
 =?utf-8?B?eU04NE5PY2RpQzlmL3FXVnNwN2FRdXUzZHZGd29rQlNrK1U4N1ZvcC9GbEdC?=
 =?utf-8?B?ekpyaUZuK0p2WWh4RExRdElPTlQ5b2NNM2dzeFhyNkM0RmprOFEvVGNnTnZK?=
 =?utf-8?B?MXJMQXNiVGRWWWRzTTdxc1JSUDdvajdCbXgxS0Nma29QNWxFTlc2QlRvRjFM?=
 =?utf-8?B?SEZWbjhZSnZNNUF5aE51c2s3QWhkd2VhTDFwcjhVaGQzZitObU1Ec0JreGdP?=
 =?utf-8?B?QTVlSTBzQUZMaXM2WlVSS0kvaEU5eURoa2NUVTh4RkwzeC91QmthbVlNbEF1?=
 =?utf-8?B?M01qcm1naElLbzNJOEZsZU00Q1hKZDZMbkRwMkZGY24yd2VEdjBOdS9lRlVQ?=
 =?utf-8?B?MzcxSzBNZDBLVWMzMFJWWWhFcmI3MENCeHEzMnV5UUEwOHZHeHJKeVJIQS96?=
 =?utf-8?B?ay94Z3RQZ09pcVBXQnhaQmFWRFJyaEtaREJKNUJkVlVBVFI5czZFNXR6TFRN?=
 =?utf-8?B?VlkwNE9qbEJYVU95STA0S1RGMUZSU29KVHh2bWs1S2xQTHJwZDFNelpVTmwy?=
 =?utf-8?B?ZVV2TTlndDlhR0xKQlBLNHZ6UXdaQU1KS3JZTlZlamxMbkJTZ004Y05WVUFk?=
 =?utf-8?B?dU5Lb2ZXZ1VZT0paSEVUVXZxWkFoZkQwb1p0MDlhR3ZycjdOaHkxTERUQzQx?=
 =?utf-8?B?TmxhdHVXbVh2V00zMkE0UWp2N3RzUmF1dCthcStwUmlKKzRzNVpSa2RUN3Vh?=
 =?utf-8?B?VGY4VG52bTJsQmtpYXJDa2FoWXVkNFNVNy9FelRxUGMra2k2RDNOR1NuTGRn?=
 =?utf-8?B?SWpob0xod0MwYUl5UE90Z1ZyUGVKalhUYy9ZL0NzeFhoWCttanBveVBVWVpk?=
 =?utf-8?B?TEh6WXkwT2l4LzlCbE92NlhDemxJOThNczMvSk5STWY2UmxZU1FyVlhPLzBx?=
 =?utf-8?B?akM1MWcvRUZ1eURjNlBzcWZleUNuTm1uMlhwNzJBS09weTZnNjdWZ25JTjZR?=
 =?utf-8?B?L2g4SWpzZVBYUXZvZS9lY1FpamVTdXRSL3Q3cGl0YlBXQkJBSm1OVVE3YTlH?=
 =?utf-8?B?T1A1eElQN2RNS2NtK0Yycy9LV1NaM2l4ZGF2RThSUkFNV1ppWVoxQUpWRkkx?=
 =?utf-8?B?QWhLdVJ0bFU5eUxHUWNjbU1MVkJWSm5hVmpjNmxuMmtVNFVTUENGUTlvLzJs?=
 =?utf-8?B?TlFFcy9ncnlwOFNXRTRQeCtjQmhocFpIMVBNclVSRWxyd3kwZjI2aUlvMUJE?=
 =?utf-8?B?ZUlNazRKSmpBVzNORXRKMEM1UGQ0bm1XcDNlSjI0K3QvSkNscE9kVHdzNHRi?=
 =?utf-8?B?eFo0ZVExL2dnSDBKZGwrNzc1bUdmV0VuWi9rL0dRVldGSExUUHJWYkRCa3My?=
 =?utf-8?B?RDd6TVJQeklxeng4d1BKRnhON29jOU93bEQrdW9UWksvMVpuY0xQVHROOEwr?=
 =?utf-8?B?RG9menprdDJnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUlyamhmRmFYUHFSMUhTZXpnMTJXY2xmTjRQQUlQOEljeldnSUg1dkhnaTNs?=
 =?utf-8?B?NnZFNjk2RS9rTzFzM0k3aTIyYVlOaURkZUQ2d2dMU05DVGx0L2hMWEhTRSs2?=
 =?utf-8?B?UlpYLzNDN25BZ29vQ0I2QjROTEFhdEs4YnplY1g4K0VheFlhSk1adjNIb1ZG?=
 =?utf-8?B?bkhhVjRPNDl6cUFsUDhNTEVleE9YTURrbWordkxLNThiT09JY3c0cUV4WDJD?=
 =?utf-8?B?NHlMaTZFNHdKaWtlaGpZZ0RyY0EyN1R1SUt6SkRUOVlXR2lTZTY1VGtLMDNm?=
 =?utf-8?B?cFlOVGNsS3Z0OEVlWjZVYlB3RFNlekRSelREd2JxMzRFcitqdWRIOG9xc0t4?=
 =?utf-8?B?VkdSNFZoRGM5Z1VjWUpQblNDcEQ3Q05KenFsaEI0Z2dlYzB6T3YxbVRUbVU2?=
 =?utf-8?B?OW1GcXdxdmxEbTdmMmRhZndtbU52S1IvMDJERldoaDRsOFJEQklIdkpoZHk0?=
 =?utf-8?B?aFlyRTBtV1F5UzZwN3Y2cTVmZFI5R1ZFdFJkM2xDRkVnR1VYa3RaSW96MUlw?=
 =?utf-8?B?RnpsVDZBSGcwWXdKN1RSSk44aXUyenFiaHpZNlE5WVV3ZHZkam0vbzJZRWNX?=
 =?utf-8?B?WkQzSDNad2pycExaQVlsT3RRWDhMM09HTWt1K2dhd3BKY1hjeWVXQitjN3JH?=
 =?utf-8?B?SUF6bG5RWlhjcjR2UEh2QkxZN3NTL2tiYnRRL1lrbUxHWHR6SVFKUnFqT2p4?=
 =?utf-8?B?cmFubzJ6NHFMeHErU2FuRUJhM2hEK0FXeHE1NHNGZDVyRCtiTXhSbmtRY3Zl?=
 =?utf-8?B?WjRJMHVsVWpLK1l1RDNoS09zMnIyeG9qdkFWUlR5MVJzYmw1SlYwdllGdisy?=
 =?utf-8?B?a3pBRGR5TW0yKzBjbk15Ym91MmZuR2Q4TEJ0a3B1OU5MK2I5RkNGbGFkaHFo?=
 =?utf-8?B?aEc1Q2laK1dkY0ZUNmNZL0R1VEh5WlhLOXNoK2dtL3dkY0czTkRsQjNnNFdM?=
 =?utf-8?B?RlZEdURoQktlY1lHT1pzU0xTSDRaSkVVOCtLZmhLRGM3UGFvSk1maUZPSzQz?=
 =?utf-8?B?aDlYdzJmMVc1U2tGendJamo1RzI2ZnpveDRIb1VnNm9NUkc0ODBBM3hWbHVn?=
 =?utf-8?B?akZhTjFXRW1UZHNWRXVYaXE0aVk2VmhJRHBvWmhxbE9GWnNjam9zMnpWTXpp?=
 =?utf-8?B?eHBsWDhzd1daV2xGSDg0cmEvZCtNdHB2T0F1NHNOY2lEajFMOTBER3VUU2Nt?=
 =?utf-8?B?STZVR00yMWJrbURINlhabk84Ym02a1d4NFRub013Szc2Z0dNcUFVam00cGRv?=
 =?utf-8?B?MDFKSHIvSEZBMVhtZURWQ05oZGFKVUJHR2tkWUMyazd4enZSNytRclFBQU45?=
 =?utf-8?B?Y1FsMFJ6T3UybzBvZGtEZEhDbXZhL3Vjd2pDZzI4cWp3RDBQMzJGSk1uNG45?=
 =?utf-8?B?V0JBNkhIWlVNRmxick9vMkxaRzNwMDE3WjZUNm5QVkdlYkhxMitnNHBOM2g0?=
 =?utf-8?B?c0s2Sk5ncXBhWmVFZ01KbFRlZ0hhL0NySEdiblB1a1JzOUNvSnFSQmk1SWFG?=
 =?utf-8?B?ZWpaV3dZd251c1pUbVNFZjd3dU1WaXRRWlJEK2FuY3U1MDZiUDBlNEdEcGEx?=
 =?utf-8?B?TXhQYXptR2hCMFYzT3FLZkNRTytjbCtIMW1NREM5VU0vM01vaml6dHp4cUxE?=
 =?utf-8?B?RlNQYkVUQVFCNEt2L0lEZzBVbFZ1dTBiSHFuU2phUFZHR0s4UVFvVWpCWGxr?=
 =?utf-8?B?YU92RktnTHEvTCt2UWhXQ1lPWGdYNk01ZkdwK2dBUzRvTVExdHlNd1hqYk1O?=
 =?utf-8?B?cy9KR2ZkTjE4QlJmV3NTWG9jMUNkandBSWFYZFF0bm5JZ0xDTjNFeXVHNFQr?=
 =?utf-8?B?Uk9JQnZ0L3ZJeXVFZGNUTGx1Sml6NnFvRDJyN0dJSHNmcDI0dnBNWWtIQlY0?=
 =?utf-8?B?SGd3bXNscm9SSStlZWRTNU9aSlNLdXhZRVoyWEZZNjZsaVhzdTdXM3czaXFD?=
 =?utf-8?B?YzdYYVp4bEdoWmZFdUZWZjFFWFlkSWJPRENyOHQ5enZTdkJBY251aU1CdVVy?=
 =?utf-8?B?bWNpd0pSSG8xYllUWkxyMkw1VTZOOTFrZHduR2pnWHRnOGtJL3dmV0hEYk9M?=
 =?utf-8?B?T0t1UzJYcitKcE03VFBtdjBKdGpubjRUekkyNlBNaVk2WmlHL0k4aWZtTWk4?=
 =?utf-8?Q?7kjkd3SlIl9wW76CajsqbpAH6?=
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
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c7f18c-9561-4ce7-208f-08dd1d829a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 03:34:52.6318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QzbDWw9AE5q+eDZ/U0nzHXyl8fSX76uJ0NHMq0tJN6JbRJN9Yq0smXcBWgSAtu87KCftzKKPe0ZlmIft7XkgN+cUMDEaFAt/qGp5fQjHtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5459

SGksDQoNCj4gPiAtLS0NCj4gPiB2MzoNCj4gPiDCoCAtIFNwbGl0IGNsayBhbmQgcmVzZXQgZHJp
dmVyIHRvIG90aGVyIGNvbW1pdHMsIHdoaWNoIGFyZSBpbiBzZXJpZXMNCj4gPiBvZg0KPiA+IMKg
wqDCoCAiQWRkIHN1cHBvcnQgZm9yIEFTVDI3MDAgY2xrIGRyaXZlciIuDQo+ID4gwqAgLSBGb3Ig
Qk1DIGNvbnNvbGUgYnkgVUFSVDEyLCBhZGQgdWFydDEyIHVzaW5nIEFTUEVFRCBJTlRDDQo+ID4g
YXJjaGl0ZWN0dXJlLg0KPiA+DQo+ID4gYXNwZWVkLGFzdDI3MDAtaW50Yy55YW1sDQo+ID4gwqAg
LSBBZGQgbWluSXRlbXMgdG8gMSB0byBmaXggdGhlIHdhcm5pbmcgYnkgIm1ha2UgZHRic19jaGVj
ayBXPTEiLg0KPiA+IMKgIC0gQWRkIGludGMxIGludG8gZXhhbXBsZS4NCj4gPg0KPiA+IEtjb25m
aWcucGxhdGZvcm1zDQo+ID4gwqAgLSBSZW1vdmUgTUFDSF9BU1BFRURfRzcuDQo+ID4NCj4gPiBL
ZXZpbiBDaGVuICg2KToNCj4gPiDCoCBkdC1iaW5kaW5nczogaW50ZXJydXB0LWNvbnRyb2xsZXI6
IFJlZmluZSBzaXplL2ludGVycnVwdC1jZWxsIHVzYWdlLg0KPiA+IMKgIGR0LWJpbmRpbmdzOiBh
cm06IGFzcGVlZDogQWRkIEFTUEVFRCBBU1QyN1hYIFNvQw0KPiA+IMKgIGFybTY0OiBhc3BlZWQ6
IEFkZCBzdXBwb3J0IGZvciBBU1BFRUQgQVNUMjdYWCBCTUMgU29DDQo+ID4gwqAgYXJtNjQ6IGR0
czogYXNwZWVkOiBBZGQgaW5pdGlhbCBBU1QyN1hYIGRldmljZSB0cmVlDQo+ID4gwqAgYXJtNjQ6
IGR0czogYXNwZWVkOiBBZGQgaW5pdGlhbCBBU1QyNzAwIEVWQiBkZXZpY2UgdHJlZQ0KPiA+IMKg
IGFybTY0OiBkZWZjb25maWc6IEFkZCBBU1BFRUQgQVNUMjcwMCBmYW1pbHkgc3VwcG9ydA0KPiAN
Cj4gRG8geW91IG1pbmQgc2VuZGluZyBhIHY0LCBiZWNhdXNlIEkgcmVjZWl2ZWQgYSBjb25mdXNp
bmcgYXJyYW5nZW1lbnQgb2YNCj4gcGF0Y2hlczoNCk9LLiBJIHB1dCBhIG1peGVkIGNvbW1pdHMg
aW4gb3VyIHNlbmQtbWFpbCBzZXJ2ZXIuIEkgd2lsbCB0cnkgdG8gc2VuZCB2NCBwYXRjaGVzLg0K
VGhhbmtzIGZvciB5b3VyIHJlbWluZGVyLg0KDQo+IA0KPiBbUEFUQ0ggdjMgMS82XSBkdC1iaW5k
aW5nczogYXJtOiBhc3BlZWQ6IEFkZCBBU1BFRUQgQVNUMjdYWCBTb0MgW1BBVENIIHYzDQo+IDEv
Nl0gZHQtYmluZGluZ3M6IGludGVycnVwdC1jb250cm9sbGVyOiBSZWZpbmUgc2l6ZS9pbnRlcnJ1
cHQtY2VsbCB1c2FnZS4NCj4gW1BBVENIIHYzIDIvNl0gZHQtYmluZGluZ3M6IGFybTogYXNwZWVk
OiBBZGQgQVNQRUVEIEFTVDI3WFggU29DIFtQQVRDSCB2Mw0KPiAyLzZdIGR0LWJpbmRpbmdzOiBp
bnRlcnJ1cHQtY29udHJvbGxlcjogRml4IHRoZSBzaXplLWNlbGxzIGluIGFzdDI3MDAtaW50YyAu
Li4NCj4gDQo+IFdoZXJlIHRoZSBjb250ZW50IG9mDQo+IA0KPiAgICBbUEFUQ0ggdjMgMS82XSBk
dC1iaW5kaW5nczogYXJtOiBhc3BlZWQ6IEFkZCBBU1BFRUQgQVNUMjdYWCBTb0MNCj4gDQo+IGFu
ZA0KPiANCj4gICAgW1BBVENIIHYzIDIvNl0gZHQtYmluZGluZ3M6IGFybTogYXNwZWVkOiBBZGQg
QVNQRUVEIEFTVDI3WFggU29DDQo+IA0KPiBEaWZmZXJzLCBhcyBkb2VzIHRoZSBjb250ZW50IG9m
DQo+IA0KPiAgICBbUEFUQ0ggdjMgMS82XSBkdC1iaW5kaW5nczogaW50ZXJydXB0LWNvbnRyb2xs
ZXI6IFJlZmluZSBzaXplL2ludGVycnVwdC1jZWxsDQo+IHVzYWdlLg0KPiANCj4gYW5kDQo+IA0K
PiAgICBbUEFUQ0ggdjMgMi82XSBkdC1iaW5kaW5nczogaW50ZXJydXB0LWNvbnRyb2xsZXI6IEZp
eCB0aGUgc2l6ZS1jZWxscyBpbg0KPiBhc3QyNzAwLWludGMNCj4gDQo+IERlc3BpdGUgc291bmRp
bmcgbGlrZSB0aGV5IG1pZ2h0IGhhdmUgdGhlIHNhbWUgaW50ZW50DQo+IA0KPiBBbmRyZXcNCg==

