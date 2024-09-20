Return-Path: <linux-kernel+bounces-334039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 992DE97D1BB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550E9284ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094B6433CF;
	Fri, 20 Sep 2024 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="ZlqIqqrj"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94EC1C68C;
	Fri, 20 Sep 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726817474; cv=fail; b=u0fcKukfSr0lSkXMiRcsgdDG1GFeNWGdICvCIk6YCdD4hQ1el0jY5VgluIfp3FQKW96zcboqJ6AB7zM+mbwDV07ZlBHl7CDPwn7iLCQPeYmuou/IE1f1s2cqmTlTofrQVmTsKor8fCCPx82YNn8dT+t4h9tvDUBRnu89DX7rX8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726817474; c=relaxed/simple;
	bh=7RzwtukUaa3DoFI9U2ypWaBTA04Of54k8jl/5R/CB38=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QKJkYkUu8DqKCXYy40L6BkVMvrngyoN9+gLZy5XuL/ijxAsVaQRpq1hOyEEhOUBofbhyN/VMyUUBnl/z3Lw1bzQWwrPOqTMO3yCgcCa21HlJAQ5gTAi2oV10jL3LbqQMIarhJB0ATqZ7OgOjOqIPIDkek7uJwObloZeYgnxl0vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=ZlqIqqrj; arc=fail smtp.client-ip=40.107.255.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqTO05SkxeYoWLMs33wFvjZAEXnYtjytQwDzAaQQwUKgEno8+wfPwcduxVJGUtkI3SiIy1vBK2vabmc0qgqDbZ8CCqecdQoFI37TrGztfSRaMxyIPOket91B96+ntJg1QQH8aVMz2EmPIFiWdtBRYoSCCNm5yWc15KtCezaNOnfr8769Bj5tBaC4ksh5K3azR+/8CWTzzdCa1NowjUXRoE4vQJgjvWGqnm1/ncqPno3t9EZ2gbBmkQIfV2iZLiEMoi5m2ZAKKa3YVoJHOQRnb906KtIgO28PwNMlxZtb858uqliLkVyZw+6dAfsWboH8rchM9yRUTANV+XtBZdY0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RzwtukUaa3DoFI9U2ypWaBTA04Of54k8jl/5R/CB38=;
 b=WDVochQ0ZKv5SB/e9xi3q1PKH8ksXnCMLrZfKnp5jPeveKabZDfIMkgOAdN4vGHvM0i8QXTODXMXGb4wVa+Z0toYS77hwHptHVTy7+JETtB0rUbgP13RHr2Gx/GshCXtrCBXkbuSRuWx4Ft/Hg1W4tfOMOIZiFl0525vWJAZRjqlezzSFAKpjPqOo8/28Tdl3VXCcwK04JedVnWa5lUCvGrBDvBjhTaieeJ6Xx4fvI6d2ozLYz9Cbu5IeiWAg93wRLsg3PVKyr+/npXwqCptLptcLLPrSjfCXK/KCn6ktdNXPwic7VdjZAyLpIioeQNj3RbPvZdthxcVlGehjcprQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RzwtukUaa3DoFI9U2ypWaBTA04Of54k8jl/5R/CB38=;
 b=ZlqIqqrjsu3mp6sS0bANokE0Fm0PYrNyLSogszcUG6Mq5qMms6Gi+ZnOhYfjvdbRGGQ5iu6Zojqwjyhf08vC4N6lJyyY7poPQhshOIdCEHS8DfGYErXJ7u4rqXc3WGBqc+xrWJ+hkusLyFvQSxdJMYQ4AUTqQhtPeeqXwnAm4K8sIh5v4GNYydZH0Qbja8pJ2LR9E/VEtUxjU39rUwaAcZMCOIA5a2RcU7Ha1jB+HHrkjQn0kTSxi+qt2JS9RHIpMasj6w+B7udzeMW4dOKehttzva7TOTZ8GEf+am7RJrrdBP4+b45yJt/ClhDiRlShStuDs7NQ2q05NDSW0uSxZA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SG2PR06MB5384.apcprd06.prod.outlook.com (2603:1096:4:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.18; Fri, 20 Sep
 2024 07:31:02 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%4]) with mapi id 15.20.7982.012; Fri, 20 Sep 2024
 07:31:01 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 2/4] dt-bindings: Add AST2700 bindings
Thread-Topic: [PATCH v3 2/4] dt-bindings: Add AST2700 bindings
Thread-Index:
 AQHbCBhUQ+ayLz0D00qz0gJFvBN4g7JaMBwAgARxxVCAABCFgIAABGwAgAA29ACAAV/TAA==
Date: Fri, 20 Sep 2024 07:31:01 +0000
Message-ID:
 <OS8PR06MB754175D3DEB44835C673A82DF26C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-3-ryan_chen@aspeedtech.com>
 <b9bf19af-0c3c-4622-9124-a66d9df649b2@kernel.org>
 <OS8PR06MB754148AD165538D3D6B6C3DDF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <195a8bfe-e4d7-4140-9635-b86a6ce3c663@kernel.org>
 <OS8PR06MB7541F08D97EC0CF83F8B36ACF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <d076275a-ff71-43e2-8a30-969a7d062acd@kernel.org>
In-Reply-To: <d076275a-ff71-43e2-8a30-969a7d062acd@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SG2PR06MB5384:EE_
x-ms-office365-filtering-correlation-id: 6bfea79e-8fd4-493e-c467-08dcd9462d90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkxqbGdXWDR0d2xYdnNYU3hIK0ErVDJudW5XekFuSjNnL25LOWtqSm9WTlFC?=
 =?utf-8?B?Z1J2bk9yd09sUFVxWms5V3FwTFVvbXdlQzJFaklac0VBaU96NmJKOEtuRTFP?=
 =?utf-8?B?ZFJIUWVIMkdOaEtDNVA5UzkrblhPS3l0SjBnVDd3WHo4ZXlRMVpQVzVGaGtM?=
 =?utf-8?B?S1YrVHVyQXluZ3gxMUxOYi9DYnY1azAxd1ppckRiOXhDVFJWbkV3QkQ0NmRw?=
 =?utf-8?B?WitQZ2tVQnRLc016enJzZHBDZml2VXI4Qyt2cUNyZmFDdlhHRk9sSUZLZ3Q4?=
 =?utf-8?B?RTRxbmkybi9ROHl6SmxjZm12bDZyZTBnQ3FNdVV0Q0l5TXhmY1Y0WmRRQ0N5?=
 =?utf-8?B?NkV5TTRRNW00SG4rVitiZ0dhcEVIVFY5cjVGL0plZW8vTXNuN3VpY3cvazFL?=
 =?utf-8?B?TkdabG5obW4wUG8wS0JUYWJoV2tnUDJTaEYrZTQ5VFFmMlRRNTNhZ3llVzRC?=
 =?utf-8?B?cmlCa2kzemFkVXJuUlg4NGZrcFRNd21JRlEvc01hY0ZXOWJ6ekFLWmE1M05r?=
 =?utf-8?B?ZE9xSzBWQTZ0Nm01WXl2ZWZtSFpJUVZsZXNkRklNSzhrdFFjN09LOXVzcHV4?=
 =?utf-8?B?a2F2dVAvOGNYaUpMMmR1ZmRZSzFOU2pEZUs5WlN6MThLNi9YQ1lLRTVocHZX?=
 =?utf-8?B?enZUZHhONEV0cEYwblNxYjY3dXpKU2JEeHhqZVA5UlNQNUthaVF0RVZHSFZQ?=
 =?utf-8?B?UnlPemRONlYzdVBINTNZdjc3Y0tSN2liYllCQWRoQ0kvOU1UQTlEU1RJRnZ3?=
 =?utf-8?B?d1hwNVRRV0RlYzNxemxyWFozb2tGUENMT2FXQzIzaWliVjk0RWppbm5EV0NU?=
 =?utf-8?B?bnJOdExyMFk4MDh3SEYxZGd1Z0t3UnhaNzU4NFVxZ0dya0p2dlpNdnNHZGsx?=
 =?utf-8?B?b01US3NJaGpienFWUjBydFVLWFN2bm5OMHUxV2owV1NhV04xcWN4aDFYUHY2?=
 =?utf-8?B?T3BPdTJqdDArRk03QTg3Uy92VWxPQyt2UHgzUUVNdnUvcitya2kvb1JWcDRX?=
 =?utf-8?B?cXVFZ29kUG5ZbU5UZU9OY3BIKzk3OFZ0NE4rQ21iRUhlWFJ0UTFIUnJleU8y?=
 =?utf-8?B?Q3AvRHBGTXNYbEpRdG0rMEJqcGQvUTFnbUIwRFBBRERiSlljZytueWF6Rmlz?=
 =?utf-8?B?TjRiMEowTEY1UTB1RkxUMWJoUEdXOTYyZHJsZnA4U0dxVEhqSCtCV1pwSmQx?=
 =?utf-8?B?ZWw3eGtub09Bb09oREJ4UXByNFNHOGVjK1g2aHhpZlFJY2VJUlVBenp2ZGFT?=
 =?utf-8?B?OU5FNFVkdlc4a09GNXgrb2FyL0tESUJuakdrb1ZsN3R3NGI3UkttSE0wWmxm?=
 =?utf-8?B?VXpoZlIzbkxuQW8xT0cvV3JPUHA0cmNpc1RzemptUjdaRU5UUzNtRWhjazFN?=
 =?utf-8?B?K293ZXhjSWxxcE1QSEcxSUlKWDFCQU5sNkpkUEk2WjBDeUtaL3cyT2l1NExr?=
 =?utf-8?B?ZkQ4enJYdnM3WVA4bnlnUXJUQjdkTTY0YXFhdDhCczZrN1VrSURXZWpiUFFC?=
 =?utf-8?B?enc1RXFLNlB1d2oxSmUwdE01cWJLQUpCVnlCUkU4RHZSUkQvTEtxSU9lRnQz?=
 =?utf-8?B?endPRXFPLzJTTUJUcGRyY25rSm00cDQvQkVVakdLWmJvZjE0bTRhcHBUNUNL?=
 =?utf-8?B?TlkwUFFvRjBzaWo3Tk5DRTJFUVJNUjU4SHpFTmlkY0JFSm9BZXViS2ZKZ1Nu?=
 =?utf-8?B?VXNsUndMSEJ5MXBCSHYyYjRuK0pKYnZaVGNhVDVnQklKNWc3bmEzRlJVeCs2?=
 =?utf-8?B?ckYxQlVnRElsY2dLZ0NSa1hidDh1Q0VjQjcrL2o3TlVuck1YY2pxcC8zbTI5?=
 =?utf-8?Q?CQE5tMPfspdTl0IUTvJ2eGIxq5pSxfCfdhND0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NStMcUwvSWFhNnQwK1UveWVXN0V1aHMzd0s2R0U4UzMyazFRMnEycUE3SmZT?=
 =?utf-8?B?YmFRODZERkRFaml0cmVMa3BkY2xEY0Mrdm1wOU1VamFmUlBVN09JRm00RUxI?=
 =?utf-8?B?L3lyQTArUG9xVjFVWERiMERQSndJK3N6MGlqalg1d25nZ0J2OTJFblFMMTY1?=
 =?utf-8?B?bEdUTnVabUxOUkJnaHpvNjNIMGVZZ1RHdWVsdkNpMmpkL0h0SHVTd3pncTdV?=
 =?utf-8?B?bmlUVnEvY2xwQVhHSXBkWVR0Ky9ZMHhiKzhqaG1RMU05T0tYdHl5QTRsVTFm?=
 =?utf-8?B?MWRDM2NXcm12djNSMmhoZWE2Z1VneGdvWnNrUllkTWJIQzlScmtEWnFOSTNQ?=
 =?utf-8?B?dCsrTnZYYmhxRGRkL1o4MEw4bjh4VUJwOW10ZlNNUE5KYU9TMmlSL05VSjA4?=
 =?utf-8?B?QzBFMzhiSzdrRzhrbU1jQXdsUXRBeHRVK3hNS1F6NUQ0WmZlL2IvMnphTUFN?=
 =?utf-8?B?ZHRIK1NKZnN1MmtXY1JrT1JnNXluVUs1UDBGZnlwaHZxZFo1UVRycmx5WFNq?=
 =?utf-8?B?TDE0SUtEY3BaUTBHd3QrSGt0cytWT2dFQzd5d1RuNnRTMGYyZFcvSnFIc3FK?=
 =?utf-8?B?bWdHbHJyQXRNVU8yWENIak94SlZ4RS9SbDFoUEhBOWdXdjZucmtJQXE5WHF3?=
 =?utf-8?B?MHl4MEM2UVpIdHpJSlFpZXdQNm1QRGptdjRBWFlGTEFiQmZLU0JzVW10dCtO?=
 =?utf-8?B?cTZDQXh2eE9UU2VMSjVOdzBzVjJpekUzelBFTjNxYy9Dd0diSlJ2ckUwWG9J?=
 =?utf-8?B?YmNucWowdG96STNrMjIrbXZZR0M2bkdhOW9oRUdpeGVmZzZybWFQTmVkK1My?=
 =?utf-8?B?cjFIcE9KaE5XbGZjOTJqTWhnYVNPWGlGOGEyQisyKy9ZSURqeW8xMGwvakxV?=
 =?utf-8?B?RXBmNjgzdVRWb245aTZIbFpENmhmcTBRSWMwampZUytJOXVGaGV3WmNKOUlB?=
 =?utf-8?B?U2FvK21sdWQ2cXVGeXJPRU9kWFo2UGJyMGJ2NDFzL1VRTy95c1NDUm5QTE1N?=
 =?utf-8?B?cWkwZ3VEeG1zQWhmRWxWa21ld1Axb21mYmk5dCtwT0RtVllOMjdsM1pQbVVq?=
 =?utf-8?B?RjZCTUl6dUd2akVQQ045aWNkcTg4eHZZTk41MThNRlA1OUNOOHFPVWtGNUhu?=
 =?utf-8?B?Vmc5ZXBRdU1uRnB1dUY2ejk3cVdGbXpvNXcwUkhqOGp3ZFhIdk1YamFlRXBD?=
 =?utf-8?B?bEhLNnNrQnMxSDVVVHhQUkNIL0E5dGNCdnNSSWxkc0x4SlZ2TEVQYVpiRlcw?=
 =?utf-8?B?VmhBOHVuVEhaYkhacnpGQXYwbXpGVWNIclZQc1NUMVBrcWJ1VlEwZFpCeVg1?=
 =?utf-8?B?Q3c3eFI1ZDFQOFgvczJObFN4bVBmVEZOcERXdHdTZ0d4azRFRmNmVThaRDNV?=
 =?utf-8?B?MjIxajM1WjdGNDdVbkszd3RETFB4Nk5PdnN4N1RpTklnUGYwQi9GMTJkNVUw?=
 =?utf-8?B?OEdhdXRSRE5IdmVSd2hKQm5sMHMrNDI4aURJUnlpbTZtL3ZlSFB0c0U5YnRH?=
 =?utf-8?B?emJNaFJ0TWRSVlhzZmZWL1VqOGtVeW5qRVFUN0pKcEpQRjFiVGI3Yi9OS0Jn?=
 =?utf-8?B?Zm1JWlpuRHNoRUVjZ1h3Qlg5elZ4MkxUYlNoKzBKcXFVaHhCbDVLY0xuMzd4?=
 =?utf-8?B?VzMzREJMVERCY0hyYldRR2ZBQmlQVnAvSmR6dktHN21CekEwaDhwZmJRTzBV?=
 =?utf-8?B?Tjh1Zk84LzBmT2JyU1BuSm9XRDE5NlFwT0k1UUloZnFwY2Urd0ErYWRHb3Nr?=
 =?utf-8?B?TnZPWHU3aXBRb2I1RHBnUlZybUc1eDE2ajUydlR0YmxoWnF5KzBHTlp5enlr?=
 =?utf-8?B?bG5RTkRGQzFPd1BUNVVncWFsd0thY2F3V3BLQStheWUydFdRSVBVTUIzQ0xa?=
 =?utf-8?B?NWpTdE91RHkxbGY5ZCtZdkpvenBtcTJQT01BK0VRbUsyZGJFemVwelR6K2xT?=
 =?utf-8?B?OCtxMlpZaVJTRE9UaDhZL3FxZ2JqSExmOUV1RGFkS2FRaGJUVWhoMjhINjdK?=
 =?utf-8?B?Mkp4NDNXbmRIbTRDdlptYkRJdU1jWUZuMGk4bTBselRhZXpTYkFuMVU2dldp?=
 =?utf-8?B?MHNWaUhlbVRGcWE4YlRCalMxOEc4eG52R0J2dlNtZXlMV3U1WGl2elRlYTZa?=
 =?utf-8?Q?9D4v+hWTutALBufey5h8DGw4c?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfea79e-8fd4-493e-c467-08dcd9462d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 07:31:01.4691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKQl+SlsedvttUn9XRWRGcLFYtRY4E10NadPDAW/6TNSkMymuvGqf+0bajlF4yXop7GL1BSyJIZEH+iz/GvcBkLnfqX9VkXm9Ol0NDoSfdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5384

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvNF0gZHQtYmluZGluZ3M6IEFkZCBBU1QyNzAwIGJp
bmRpbmdzDQo+IA0KPiBPbiAxOS8wOS8yMDI0IDA5OjE1LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+
Pj4NCj4gPj4+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2Nr
L2FzcGVlZCxhc3QyNzAwLWNsay5oDQo+ID4+Pj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPj4+
Pj4gaW5jbHVkZS9kdC1iaW5kaW5ncy9yZXNldC9hc3BlZWQsYXN0MjcwMC1yZXNldC5oDQo+ID4+
Pj4+DQo+ID4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzcGVl
ZCxhc3QyNzAwLWNsay5oDQo+ID4+Pj4+IGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hc3Bl
ZWQsYXN0MjcwMC1jbGsuaA0KPiA+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+Pj4+PiBp
bmRleCAwMDAwMDAwMDAwMDAuLjYzMDIxYWYzY2FmNQ0KPiA+Pj4+PiAtLS0gL2Rldi9udWxsDQo+
ID4+Pj4+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3MDAtY2xr
LmgNCj4gPj4+Pg0KPiA+Pj4+IFVzZSBjb21wYXRpYmxlIGFzIGZpbGVuYW1lLg0KPiA+Pj4gTW9k
aWZ5IGZyb20gYXNwZWVkLGFzdDI3MDAtY2xrLmggdG8gYXNwZWVkLCBjbGstYXN0MjcwMC5oLCBp
cyBpdCBvaz8NCj4gPj4+IEhvdyBhYm91dCB0aGUgYXNwZWVkLGFzdDI3MDAtcmVzZXQuaCBmaWxl
IG5hbWUgaXMgb2sgPw0KPiA+Pg0KPiA+PiBOby4gRm9yIGJvdGggdXNlIHRoZSBzYW1lIGZpbGVu
YW1lLCBzbyB0aGUgZnVsbCBjb21wYXRpYmxlLiBGVUxMLg0KPiA+DQo+ID4gRG8geW91IG1lYW4g
cmVtb3ZlIGFzcGVlZCxhc3QyNzAwLXJlc2V0Lmg/DQo+ID4gQW5kIG1vdmUgcmVzZXQgaW5mb3Jt
YXRpb24gaW50byAiYXNwZWVkLCBjbGstYXN0MjcwMC5oIg0KPiA+Pg0KPiANCj4gSSBkaWQgbm90
IHNheSB0aGF0LiAiRm9yIGJvdGgiIG1lYW5zIGZvciBib3RoIGZpbGVzLCBzbyB5b3UgY2FuIGtl
ZXAgYm90aCBmaWxlcy4NCj4gDQpTbywgSSB0aGluayB5b3Ugd2FudCBib3RoIGZpbGUgdXNlIHRo
ZSBzYW1lIG5hbWUgcmlnaHQ/IFRvIGJlIGZvbGxvd2luZw0KaW5jbHVkZS9kdC1iaW5kaW5ncy9j
bG9jay9hc3BlZWQsYXN0MjcwMC1zY3UuaA0KaW5jbHVkZS9kdC1iaW5kaW5ncy9yZXNldC9hc3Bl
ZWQsYXN0MjcwMC1zY3UuaA0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

