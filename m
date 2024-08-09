Return-Path: <linux-kernel+bounces-280432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD3294CA6F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6A21F232CB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE516D31E;
	Fri,  9 Aug 2024 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="JcKzwcy8"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2129.outbound.protection.outlook.com [40.107.117.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194816C6B0;
	Fri,  9 Aug 2024 06:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723184761; cv=fail; b=eWZQO93lyp6DnIVvOKEkbHB/2TvyZZK+tU5tfF64B44W9b7h49euUEw/1s2nmM4moczfnTpjNl6Soi2hwyGHsnW5Ja4m/FnDhQ4RxYiNe5ftOgOZBqVWdYo7dPb1lWU4GsOoPKSeFd8ZWXalHLlApZwOcPYdIiZk8IWV6+QSc1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723184761; c=relaxed/simple;
	bh=rxRXPe0birUMYFXMc82JthTQakEvc50v3OVjzEqFszo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jo0kaokH1ZID8xm43+T1VtkB9BSHSOa00TgzvEonL8GuCBA65eFHD0IBd2RMZFdeKHwzvkihDOTmqHnYQST1di7OKNZoreoIdR4lqyBaUgAsxILXn4lC+frITEbVkTnldZnnaNNsTRE3XooRVnMQztMrXVymlDO8PnNurG8hHJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=JcKzwcy8; arc=fail smtp.client-ip=40.107.117.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DG4Utw/zcAJt6Jh0I8fbDcToehrEitX6tgJPmPAWWJSRcgaB1SIALk5j3lGIcjUAlA+4XeHm7v994nA3baWzu2g44OS/6SVRuaKHhsKPPdmBnnrHCy3C7GZ1Ij78vdnykhNWyx+iSX+ijXLLrldvLnZkHRyx/0zb59SIY85RZ65nYP9USIeggWJ2RMU/wPfI80idd631UiK1fv1z/8yeL29EnP9N+TNJj+Rv2PEMebnHDV0Vg+3CKm36+SKaSo9BbFpFUw/FEGH/DMa8B1PmE9b0MRDFD6SP5OrLpioUY+LOjc4IwooZ/gWfLVbvI9RnDLnrxKzV3zAaBS8OkvZCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxRXPe0birUMYFXMc82JthTQakEvc50v3OVjzEqFszo=;
 b=vywDQkOXaXFGBS92oodOkKCbg/9RE/ScC1f+WpOBdhUujJ6RAcbxDDnYQa7tJUsUULKGpOzguzZrb8WZ434kcbBPx4RK3BCfr5R+7alywqOConpUWYDNX4/nqQAPP8JbDqSTMVrWaDHfP5S68Hnk0yvIn8LDIBHqUGmrBAqtJtcHXebnRDvGMTRkWFvXdmzeMY5cfPy7/KiAaNQ1NQw06B/2xcwktdLjXNeDKJj3RU7W1f5FeJmWvClWdMUEq+l59Mz1CypBGXDoZ9NowNKda8I6nn8rjv7J8D55PUj/pQPjkhsyEV1olAP/7myoMZ9pp2HEMo4btgSnxX5Z4S5zxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxRXPe0birUMYFXMc82JthTQakEvc50v3OVjzEqFszo=;
 b=JcKzwcy8G03VucOmkiaUofebYP9AaPji2ZxCBOH5xn11UjHsuVn1NRDCSGTw4OnU8Jb1lMmJAGfk5QrXnCPN1YIxCntTU5/XpzSl9GS+/MV4oVaW0JA6Vsb2in7GD/25qaYZAnfT6iEIjxOnTrBTugJw8pFufXeXzvJX/F7Qp1D/T+kf+1M0byVNUZ1zBSyrDNIEhTEymyfmt+R3q9S0v1s2ynH46bKlPQ66LJLcMO4y5mzBWvRQoxDJC204eK3UcjEbKZgOTlhaWTXE8vdzQOtcNdrsI5yxwYyDkzgjCqMg2W/IEgy5MYVEbVBI/kJvn1ulEZx8cbk5dtQNb3LQxg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by JH0PR06MB6293.apcprd06.prod.outlook.com (2603:1096:990:10::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 06:25:54 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 06:25:54 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, Lee Jones <lee@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Topic: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Index: AQHa6WjvtGERsBjdbUe0s1M0hUJcKbIdCjAAgAFhFjCAAAaDgIAABO+Q
Date: Fri, 9 Aug 2024 06:25:54 +0000
Message-ID:
 <OS8PR06MB7541CA018C86E262F826B9E5F2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-4-ryan_chen@aspeedtech.com>
 <14ef9485-54ba-402b-9b90-5f10c1523d4e@wanadoo.fr>
 <OS8PR06MB75413728F0FCEE022B4B4F5BF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <eec21668-3674-40c6-b443-90c7c02262e3@kernel.org>
In-Reply-To: <eec21668-3674-40c6-b443-90c7c02262e3@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|JH0PR06MB6293:EE_
x-ms-office365-filtering-correlation-id: bfac5492-a9e7-4917-4152-08dcb83c1f37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?b255MkFVSXVKaUJUem1OYVp2bmtjTVBLdTB0RnpDRnAxU2VyelhzbUVycFli?=
 =?utf-8?B?NmNVd2NpWjQ4V1lUTTh1NHZiZE1maXNFTVQzd0hJeU5kbUlsQlZNQnBYMUE3?=
 =?utf-8?B?ajFFTmZTYlVUNkJibGt0ejlPS0wycmkvOVZ0cWxpcUozRWVqTGovazJpWGd1?=
 =?utf-8?B?cnNMVGlJN0M4b1BWbnRORzRnRFdGeEpob1NmTGdzTzk0a0pPSjJKc0h6NWxP?=
 =?utf-8?B?cDdsS0FVN0NSQVREN0EwMzBORVZZc29rRjZGdmFCT3BOQmdhaVVmYk90aEVm?=
 =?utf-8?B?ZXM4L0ViT0YyaldSV1R1eVdGQmJITTZicXFpdGljMFUvc0FkS1Nya1lwTjg4?=
 =?utf-8?B?ZC9zYzRPR04ra1pQKzZqYTN4ZHhNUmV1clNiOTVDejdwaXIreFFDNjZVQVlV?=
 =?utf-8?B?UjJUMlZFeldTbm91cHlxWGhLUkNtT2RFZXJIVkVDWlhEZzJ6ZGFyTDlrenNZ?=
 =?utf-8?B?L2VYTzRWOTVFZTZocDJvVUI1N3p3Y3hHejd4bER1WUFFTDBUWE4zN0wzaHRs?=
 =?utf-8?B?RE1OWm1iajdrT2ZpeUJQUnFHRHYxNnY1Qm9oU2JkeGJyODdFYjZnKzZaZFd5?=
 =?utf-8?B?Q094b0M0OG90SlpSbjhwUllOQXRVanRIUkNpTFhDMTVkeEpibndGNHF4V0dz?=
 =?utf-8?B?SEVsdzNQb08yM1p4M2dIOVhWaVZmTGEzUENleDZqRVNSeHJGaGFsNEdIWU4v?=
 =?utf-8?B?ek9YMkZTaTRQZUVtNGZNYzlSUXFkdTJqakY3QVliNC9IWGNYeXNIdUVwbVZx?=
 =?utf-8?B?cS9qY0FkdjZNeUt1eTRQMTdFQUZRWmdqQmNNVzEwN1hpL1UzcWIzOVBVUkMv?=
 =?utf-8?B?ZkkxUmxjMjN6emlPMS82N3AvL1lWbWFDVTlEcHVzdU9DcHBSNGt3Tm84SzVO?=
 =?utf-8?B?WG5nTUlTL1hic1JXenlSZU1lbTBUdnFWYXR1QlQ5djh3U0VkSDd2Slpad0d6?=
 =?utf-8?B?clJLMC9jeWhMdm1NdVdKT2t1YWNDbDREQlNSZGxOLyt0L0tVRlh1cVlGN1l3?=
 =?utf-8?B?WTAxY29xRU5SSm5jQm1Zai9KYnJZNUlPNzc1MU9oVzJidWF5TFNYdzJjN1RM?=
 =?utf-8?B?VFRUQzJUVWJORUtvSlhvTldlc1U2OEkzRXFQcUl0ckpMQ0taaGR5K0IvWC9w?=
 =?utf-8?B?MFlQTk9kOFNuMnNFK0RyMlp6aHJENlhibjQvdUw2VG5pdjJpY3RTVFFvMmph?=
 =?utf-8?B?dWJlNHpCWVNmMHhBZjFQOERWZVBsK1VJS0t2YVNOVC9LZUVuTGlXbWRqaWpZ?=
 =?utf-8?B?Y1I0M1dVdXBHSjhDeFl3TjMvZVUwSUtyby82OUk1MmR1R2FSQjUveFh4VVRZ?=
 =?utf-8?B?WXdUUndMZXdmS2hWNEQ3bXBINmVlc3NtU0c4K285SHJLekk1b3RSRCtjU2dv?=
 =?utf-8?B?KzhwY1ZYZkxISFZUYWYxa25ZbDZwcy9yamlkZVhlbm5TZVB5N1oxVFRTeGtm?=
 =?utf-8?B?UjV3ZGM5c1B4QWkxbjROTVRKTVdIaCtrSktiV3RJK29QM0JSbTBuR1c1cndV?=
 =?utf-8?B?bFNmM1FNTmI5YVZacXdoc05VOUJXWjRYRmF1eDNUeUFzT3VmWUQ1UWp6NFhZ?=
 =?utf-8?B?dFNXMzJTRlphanhTOTRiWGhqakJkajdFcDlhUWoxSEtmTXdkaDl2d2tCYThL?=
 =?utf-8?B?a1lrZnEzSEdHb3J0WDFJZWZLVHZaZnZDckpSd0p3anNzV1JDdHAwK2tPbXRD?=
 =?utf-8?B?R2orUjh2emFNMnZCWW9qdGFXalJueDJFK0JwaFlxd2JWR0dkdUg1ano3KzZz?=
 =?utf-8?B?bHovanNZTEVVR0xOOThOdG0yRGtzaGwwOXpkRVN4U09VMjN6TEM1ZitKdlI4?=
 =?utf-8?B?eXNXaUgrWnRvS1I0UDhrS1lBd3lKV01ERGNrYVQ4dHk0R1Y5OTAxOVhZbXNZ?=
 =?utf-8?Q?mIJRSZPPQ0Wl8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0dwaXFOY1AzYWxZZVdzK0V0SUE4eFRJUndBY0dWeVE5WFZOT3FyMlU3UTAz?=
 =?utf-8?B?Z2E1U25yRFU3SFRqVHRTMGZMdXVQMzlPa1YwaFl0ZWdQc05aMUNPZlhMa3h2?=
 =?utf-8?B?V0dXTWI0TDBVU1NwU2crdDE3dVNzdmJmSlAzTm1xYUZ0YkJaQzRUT3NQc1lZ?=
 =?utf-8?B?Z3ZOTlBUN0RNRjlNVUdFRUZybUZueVZRbjB3V0pXTXZCQitsQ0RHR0xtUnli?=
 =?utf-8?B?Y3ZxZHVtcUxtRFZWZzROOWRzVGtxVWNEWXJLZ2ZYT2FFYVI1YzZXeHRrNXZY?=
 =?utf-8?B?ZkxrYnFCb3k2Wm5sQ2MwREhFOS9jelJFVWdnRWt5WDFYZFpxeGdDd2ZHSWMr?=
 =?utf-8?B?SW80OHpRakxtY0RQd3FUTTU3Q0tSdHhOR3c5Mjd1SDlPU21xQkhhalNCTmZM?=
 =?utf-8?B?OGNJcUdtbjZMU3pxQzJWMGp1alBpNFVyU2M5Ni85YlA5NmdZTWtOaGFKTW1X?=
 =?utf-8?B?TmZCM1huSWdzNWRWZUxWNEVoaU9VaWthd28vVnR6T3B5NkUvTFZaN3RFWS9j?=
 =?utf-8?B?eVZqZ1V5aE1YUG55Sjh4YzZSN3FRczRqSWVtL2sxTk4rWFhFUkVkQXZSaERS?=
 =?utf-8?B?ekJTRUpZSXF5WFJucGJTU0ZBaEZpQnM1OGJLQmFUSzVLc1Q5VU9BbTMreTFG?=
 =?utf-8?B?Tlg5K0U0MUlCaGtLeDJ5eis5ZXVxWWNyWjErVHZLdXlQWnlXdmFoTnRMeHlI?=
 =?utf-8?B?U2xxdHdOdUQ5ekRTMHphME1VdVhZM21OZERoTWV2TGQwL2dIaloveXNwWWVY?=
 =?utf-8?B?dU5Nd3ZOdngwcWY0QzE1QjNNeEMvTVFPUWVYTlNQeXIyVkVoR2lDQmJKODZy?=
 =?utf-8?B?bEFNc1F5eUZvdHpOT04ydnVDU2JheHFVQ0pGRURSYjJRMGJpQ3I4NzBGb2th?=
 =?utf-8?B?OGFybUhLRVRGL3RJT2JoZUw1WDRnODdIRmVGbW41SXpEdzdsVkxmM2lMTkdh?=
 =?utf-8?B?aEx3RS9oNGl6QlFVWWpjblJFZXF4UnBmMCtobzFEc2Jqc2dGeW5vU1lwZElz?=
 =?utf-8?B?YW1zeTQrZ0RldUFTY2Y0aWNjTjFpL2g1andaYUMrUC9nNHJZRmlNR0g3dWZ0?=
 =?utf-8?B?NEJuQjJqYmI1R1UrSEM0cjJKdHF1V3Rid0VZMWtOZ3AwdFFxY015ZzFnLytE?=
 =?utf-8?B?amptdjJKbkVxYmxTckNOWHM2Z0hTaXFTQUxhOWRFcnhaUzN5SHhFTXZQNE9P?=
 =?utf-8?B?eDNBcHRVTjBsNGplb0dNYUlYTzFGK1h3NjZBdTE3Q0t1UFA4Szc2SDhOWXh2?=
 =?utf-8?B?NHJYMTdud0RxUjJWZ1JJUlZLN0o5OUdIblBnREVKeW5UWjFCandQRUM0cVhu?=
 =?utf-8?B?eXJqcWh6a1M3eXFjd1lGRS9aU1BXTWFGK0ZWSmp2M3V2aERncFNRemFsNUFh?=
 =?utf-8?B?eEYyalI4YkJJRDlyalBJeWVQN0Rlc1Q2d25VSTk5d1VoRVhUSjVqNkJrcXYv?=
 =?utf-8?B?RlU5MFFNZzZEZnliWGsveWdiaDNOZDN3KzUvc2J0bVozVzJrYnlhcnErTnNL?=
 =?utf-8?B?c0l3MEE2cnNOSzBuYW92UUliSnpCNWhWZG5RaEs2MnA0MDU2SWhyVXZyS3Zs?=
 =?utf-8?B?czBsYXB2WDEvaEgwWkw2dFV4c1l5ejNUM1hqVDJXcEN2dFVlRFpGZnJsRGxI?=
 =?utf-8?B?MUs5ekNJc0Fhb3U5VFdmYmVhOXRFV0FQbDBQSlFEMHh5WFljak1BMHNqcWdC?=
 =?utf-8?B?c3d6VVRzVUV5MUdkNFUrMmR3RFVtSU5uVEZLeHQwcWpFK0ZmbDQrcy85Sllu?=
 =?utf-8?B?YTJxTlhYTnNra003TCtKYmtTSHFsTm9aeHphM01aUnFuSG1kNUZUVWRBdm1i?=
 =?utf-8?B?MmswK3JCbWVuWTR4c1k3OTBHSWxHMldRRDVMbU1SS1JnYUlBRTBNbjlVWlcz?=
 =?utf-8?B?QlRlaTF5SEZGN0haOVFGVCtNRnZ2cjM3TW9RODlVeGdoLzEyczY0dkN1alJO?=
 =?utf-8?B?NGNINkFCalYwS0t0UXVZcGtUZlVaWFRsOU5xLzd5OHkrWm1ERXRkalhiZDBo?=
 =?utf-8?B?dkhjM3lFU29ESndsZDhYNHlMU0Z0VEUvRjBlaXBCcXhYOWVKdnJZQ2pncEgv?=
 =?utf-8?B?TEN5Q0hCNGsyYjJHaVBqdVZWK3ZTQndBUGFiaWdlT2V2bUpJRFkwL2o0VXFL?=
 =?utf-8?Q?hskBCK7HP/AmZnu7r+o724O++?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bfac5492-a9e7-4917-4152-08dcb83c1f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 06:25:54.0838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CtWeiCDtRtXYlbRrKhe235ClroZY40fQga1KVDL/rcw6Z8ucg459AAYfuVLcNdovgbpFTmnw1x3ol9qKusYp2FP5FphvoODDWS+l0xknPMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6293

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcw
MCBjbG9jayBiaW5kaW5ncw0KPg0KPiBPbiAwOS8wOC8yMDI0IDA3OjQ3LCBSeWFuIENoZW4gd3Jv
dGU6DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy80XSBkdC1iaW5kaW5nczogY2xvY2s6IEFk
ZCBBU1QyNzAwIGNsb2NrDQo+ID4+IGJpbmRpbmdzDQo+ID4+DQo+ID4+IExlIDA4LzA4LzIwMjQg
w6AgMDk6NTksIFJ5YW4gQ2hlbiBhIMOpY3JpdCA6DQo+ID4+PiBBZGQgZHQgYmluZGluZ3MgZm9y
IEFTVDI3MDAgY2xvY2sgY29udHJvbGxlcg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFJ5
YW4gQ2hlbiA8cnlhbl9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgIC4u
Li9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0MjcwMC1jbGsuaCAgICB8IDE3NQ0KPiA+PiAr
KysrKysrKysrKysrKysrKysNCj4gPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE3NSBpbnNlcnRpb25z
KCspDQo+ID4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2Nr
L2FzcGVlZCxhc3QyNzAwLWNsay5oDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
ZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3MDAtY2xrLmgNCj4gPj4+IGIvaW5jbHVkZS9k
dC1iaW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0MjcwMC1jbGsuaA0KPiA+Pj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4gPj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZmFjZjcyMzUyYzNlDQo+ID4+PiAt
LS0gL2Rldi9udWxsDQo+ID4+PiArKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzcGVl
ZCxhc3QyNzAwLWNsay5oDQo+ID4+PiBAQCAtMCwwICsxLDE3NSBAQA0KPiA+Pj4gKy8qIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkgKi8NCj4g
Pj4+ICsvKg0KPiA+Pj4gKyAqIERldmljZSBUcmVlIGJpbmRpbmcgY29uc3RhbnRzIGZvciBBU1Qy
NzAwIGNsb2NrIGNvbnRyb2xsZXIuDQo+ID4+PiArICoNCj4gPj4+ICsgKiBDb3B5cmlnaHQgKGMp
IDIwMjQgQXNwZWVkIFRlY2hub2xvZ3kgSW5jLg0KPiA+Pj4gKyAqLw0KPiA+Pj4gKw0KPiA+Pj4g
KyNpZm5kZWYgX19EVF9CSU5ESU5HU19DTE9DS19BU1QyNzAwX0ggI2RlZmluZQ0KPiA+Pj4gK19f
RFRfQklORElOR1NfQ0xPQ0tfQVNUMjcwMF9IDQo+ID4+PiArDQo+ID4+PiArLyogU09DMCBjbGst
Z2F0ZSAqLw0KPiA+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9NQ0xLICgwKQ0KPiA+Pj4gKyNk
ZWZpbmUgU0NVMF9DTEtfR0FURV9FQ0xLICgxKQ0KPiA+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FU
RV8yRENMSyAgICAgICAgKDIpDQo+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1ZDTEsgKDMp
DQo+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0JDTEsgKDQpDQo+ID4+PiArI2RlZmluZSBT
Q1UwX0NMS19HQVRFX1ZHQTBDTEsgICAgICAoNSkNCj4gPj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dB
VEVfUkVGQ0xLICAgICAgICg2KQ0KPiA+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfR0FURV9QT1JUQlVT
QjJDTEsgKDcpICNkZWZpbmUNCj4gU0NVMF9DTEtfR0FURV9SU1Y4DQo+ID4+PiArKDgpDQo+ID4+
PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1VIQ0lDTEsgICAgICAoOSkNCj4gPj4+ICsjZGVmaW5l
IFNDVTBfQ0xLX0dBVEVfVkdBMUNMSyAgICAgICgxMCkNCj4gPj4+ICsjZGVmaW5lIFNDVTBfQ0xL
X0dBVEVfRERSUEhZQ0xLICAgICgxMSkNCj4gPj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfRTJN
MENMSyAgICAgICgxMikNCj4gPj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfSEFDQ0xLICAgICAg
ICgxMykNCj4gPj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfUE9SVEFVU0IyQ0xLICgxNCkNCj4g
Pj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfVUFSVDRDTEsgICAgICgxNSkNCj4gPj4+ICsjZGVm
aW5lIFNDVTBfQ0xLX0dBVEVfU0xJQ0xLICAgICAgICgxNikNCj4gPj4+ICsjZGVmaW5lIFNDVTBf
Q0xLX0dBVEVfREFDQ0xLICAgICAgICgxNykNCj4gPj4+ICsjZGVmaW5lIFNDVTBfQ0xLX0dBVEVf
RFAgICAoMTgpDQo+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0UyTTFDTEsgICAgICAoMTkp
DQo+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0NSVDBDTEsgICAgICAoMjApDQo+ID4+PiAr
I2RlZmluZSBTQ1UwX0NMS19HQVRFX0NSVDFDTEsgICAgICAoMjEpDQo+ID4+PiArI2RlZmluZSBT
Q1UwX0NMS19HQVRFX1ZMQ0xLICAgICAgICAoMjIpDQo+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19H
QVRFX0VDRFNBQ0xLICAgICAoMjMpDQo+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JTQUNM
SyAgICAgICAoMjQpDQo+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JWQVMwQ0xLICAgICAo
MjUpDQo+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX1VGU0NMSyAgICAgICAoMjYpDQo+ID4+
PiArI2RlZmluZSBTQ1UwX0NMS19HQVRFX0VNTUNDTEsgICAgICAoMjcpDQo+ID4+PiArI2RlZmlu
ZSBTQ1UwX0NMS19HQVRFX1JWQVMxQ0xLICAgICAoMjgpDQo+ID4+PiArLyogcmVzZXJ2ZWQgMjkg
fiAzMSovDQo+DQo+IE5vLCB5b3UgY2Fubm90IHJlc2VydmUgSURzLiBUaGV5IGFyZSBhbHdheXMg
Y29udGlub3VzLg0KSSB0aGluayBmb3IgbWlzLXVuZGVyc3Rvb2QuDQpJIHdpbGwgcmVtb3ZlIHRo
ZSBjb21tZW50Lg0KQW5kIGtlZXAgaXQgaXMgY29udGludW91cy4gVGhhbmtzLg0KPg0KPiA+Pj4g
KyNkZWZpbmUgU0NVMF9DTEtfR0FURV9OVU0gIChTQ1UwX0NMS19HQVRFX1JWQVMxQ0xLICsgMSkN
Cj4NCj4gTm8sIG5vdCBhIGJpbmRpbmcuDQoNCkkgd2lsbCBtb2RpZnkgdGhlIHN1YmplY3QuDQoN
Cj4NCj4gPj4+ICsNCj4gPj4+ICsvKiBTT0MwIGNsayAqLw0KPiA+Pj4gKyNkZWZpbmUgU0NVMF9D
TEtJTiAgICAgICAgIChTQ1UwX0NMS19HQVRFX05VTSArIDApDQo+ID4+DQo+ID4+IFNvIFNDVTBf
Q0xLSU4gaXMgMjgrMSswID0gMjkgd2hpY2ggaXMgc2FpZCB0byBiZSByZXNlcnZlZCBpbiB0aGUN
Cj4gPj4gY29tbWVudCBhYm92ZS4NCj4gPg0KPiA+IEFjdXRlbHksIEkga2VlcCByZXNlcnZlZCBp
cyBiZWNhdXNlIGRhdGEgc2hlZXQgaGFzIHJlc2VydmVkIGJpdHMgZnJvbSAyOX4zMS4NCj4gPiBJ
ZiB5b3UgaGF2ZSBjb25jZXJuIGFib3V0IGl0LCBJIGNhbiByZW1vdmUgdGhlIGNvbW1lbnQuDQo+
ID4gT3IgYXJlIHlvdSBwcmVmZXIgYnkgZm9sbG93aW5nPw0KPiA+ICNkZWZpbmUgU0NVMF9DTEtf
R0FURV9SRVNFUlZFRDI5ICAgICAgICAoMjkpDQo+ID4gI2RlZmluZSBTQ1UwX0NMS19HQVRFX1JF
U0VSVkVEMzAgICAgICAgICgzMCkNCj4gPiAjZGVmaW5lIFNDVTBfQ0xLX0dBVEVfUkVTRVJWRUQz
MSAgICAgICAgKDMxKQ0KPiA+ICNkZWZpbmUgU0NVMF9DTEtfR0FURV9OVU0gICAgICAgKFNDVTBf
Q0xLX0dBVEVfUkVTRVJWRUQzMSArIDEpDQo+ID4NCj4gPj4NCj4gPj4+ICsjZGVmaW5lIFNDVTBf
Q0xLXzI0TSAgICAgICAgICAgICAgIChTQ1UwX0NMS19HQVRFX05VTSArIDEpDQo+ID4+PiArI2Rl
ZmluZSBTQ1UwX0NMS18xOTJNICAgICAgICAgICAgICAoU0NVMF9DTEtfR0FURV9OVU0gKyAyKQ0K
PiA+Pj4gKyNkZWZpbmUgU0NVMF9DTEtfVUFSVCAgICAgICAgICAgICAgKFNDVTBfQ0xLX0dBVEVf
TlVNICsgMykNCj4gPj4+ICsjZGVmaW5lIFNDVTBfQ0xLX1BTUCAgICAgICAgICAgICAgIChTQ1Uw
X0NMS19HQVRFX05VTSArIDQpDQo+ID4+PiArI2RlZmluZSBTQ1UwX0NMS19IUExMICAgICAgICAg
ICAgICAoU0NVMF9DTEtfR0FURV9OVU0gKyA1KQ0KPiA+Pg0KPiA+PiAuLi4NCj4gPg0KPiA+ICoq
KioqKioqKioqKiogRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioq
KioqKg0KPiA+IOWFjeiyrOiBsuaYjjoNCj4gPiDmnKzkv6Hku7Yo5oiW5YW26ZmE5Lu2KeWPr+iD
veWMheWQq+apn+Wvhuizh+ioiu+8jOS4puWPl+azleW+i+S/neitt+OAguWmgiDlj7Dnq6/pnZ7m
jIflrpoNCj4g5LmL5pS25Lu26ICF77yM6KuL5Lul6Zu75a2Q6YO15Lu26YCa55+l5pys6Zu75a2Q
6YO15Lu25LmL55m86YCB6ICFLCDkuKboq4vnq4vljbPliKrpmaTmnKzpm7vlrZANCj4g6YO15Lu2
5Y+K5YW26ZmE5Lu25ZKM6Yq35q+A5omA5pyJ6KSH5Y2w5Lu244CC6Kyd6Kyd5oKo55qE5ZCI5L2c
IQ0KPiA+DQo+ID4gRElTQ0xBSU1FUjoNCj4gPiBUaGlzIG1lc3NhZ2UgKGFuZCBhbnkgYXR0YWNo
bWVudHMpIG1heSBjb250YWluIGxlZ2FsbHkgcHJpdmlsZWdlZCBhbmQvb3INCj4gb3RoZXIgY29u
ZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCBpdCBpbiBlcnJvciwg
cGxlYXNlIG5vdGlmeSB0aGUNCj4gc2VuZGVyIGJ5IHJlcGx5IGUtbWFpbCBhbmQgaW1tZWRpYXRl
bHkgZGVsZXRlIHRoZSBlLW1haWwgYW5kIGFueQ0KPiBhdHRhY2htZW50cyB3aXRob3V0IGNvcHlp
bmcgb3IgZGlzY2xvc2luZyB0aGUgY29udGVudHMuIFRoYW5rIHlvdS4NCj4NCj4gTWF5YmUgSSBh
bSB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IG9mIHlvdXIgbWVzc2FnZSwgbWF5YmUgbm90LiBJIGRv
bid0IHdhbnQNCj4gdG8gaGF2ZSBhbnkgbGVnYWwgcXVlc3Rpb25zIHJlZ2FyZGluZyB1cHN0cmVh
bSwgcHVibGljIGNvbGxhYm9yYXRpb24sIHRodXMNCj4gcHJvYmFibHkgSSBzaG91bGQganVzdCBy
ZW1vdmUgeW91ciBtZXNzYWdlcy4NCj4NCj4gUGxlYXNlIHRhbGsgd2l0aCB5b3VyIElUIHRoYXQg
c3VjaCBkaXNjbGFpbWVycyBpbiBvcGVuLXNvdXJjZSBhcmUgbm90IGRlc2lyZWQNCj4gKGFuZCBt
YXliZSBldmVuIGhhcm1mdWwpLg0KPiBJZiB5b3UgZG8gbm90IHVuZGVyc3RhbmQgd2h5LCBwbGVh
c2UgYWxzbyBzZWU6DQo+IGh0dHBzOi8vd3d3LnlvdXR1YmUuY29tL2xpdmUvZk1lSDd3cU93WEE/
c2k9R1k3aWdmYmRhNnZualhsSiZ0PTgzNQ0KPg0KPiBJZiB5b3UgbmVlZCB0byBnbyBhcm91bmQg
Y29tcGFueSBTTVRQIHNlcnZlciwgdGhlbiBjb25zaWRlciB1c2luZyBiNA0KPiB3ZWItcmVsYXk6
IGh0dHBzOi8vYjQuZG9jcy5rZXJuZWwub3JnL2VuL2xhdGVzdC9jb250cmlidXRvci9zZW5kLmh0
bWwNCj4NCj4gUGxlYXNlIGJlIGluZm9ybWVkIHRoYXQgYnkgcmVzcG9uZGluZyB0byB0aGlzIGVt
YWlsIHlvdSBhZ3JlZSB0aGF0IGFsbA0KPiBjb21tdW5pY2F0aW9ucyBmcm9tIHlvdSBhbmQvb3Ig
eW91ciBjb21wYW55IGlzIG1hZGUgcHVibGljLiBJbiBvdGhlciB3b3JkcywNCj4gYWxsIG1lc3Nh
Z2VzIG9yaWdpbmF0aW5nIGZyb20geW91IGFuZC9vciB5b3VyIGNvbXBhbnkgd2lsbCBiZSBtYWRl
IHB1YmxpYy4NCj4NCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KKioqKioqKioqKioq
KiBFbWFpbCBDb25maWRlbnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioqDQrlhY3o
sqzogbLmmI46DQrmnKzkv6Hku7Yo5oiW5YW26ZmE5Lu2KeWPr+iDveWMheWQq+apn+Wvhuizh+io
iu+8jOS4puWPl+azleW+i+S/neitt+OAguWmgiDlj7Dnq6/pnZ7mjIflrprkuYvmlLbku7bogIXv
vIzoq4vku6Xpm7vlrZDpg7Xku7bpgJrnn6XmnKzpm7vlrZDpg7Xku7bkuYvnmbzpgIHogIUsIOS4
puiri+eri+WNs+WIqumZpOacrOmbu+WtkOmDteS7tuWPiuWFtumZhOS7tuWSjOmKt+avgOaJgOac
ieikh+WNsOS7tuOAguisneisneaCqOeahOWQiOS9nCENCg0KRElTQ0xBSU1FUjoNClRoaXMgbWVz
c2FnZSAoYW5kIGFueSBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gbGVnYWxseSBwcml2aWxlZ2Vk
IGFuZC9vciBvdGhlciBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlvdSBoYXZlIHJlY2Vp
dmVkIGl0IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmVwbHkgZS1tYWls
IGFuZCBpbW1lZGlhdGVseSBkZWxldGUgdGhlIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIHdp
dGhvdXQgY29weWluZyBvciBkaXNjbG9zaW5nIHRoZSBjb250ZW50cy4gVGhhbmsgeW91Lg0K

