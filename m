Return-Path: <linux-kernel+bounces-333160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699B097C4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C641F22103
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279D519259E;
	Thu, 19 Sep 2024 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="rPa4b6YU"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2129.outbound.protection.outlook.com [40.107.117.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CFF20314;
	Thu, 19 Sep 2024 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726730137; cv=fail; b=Be8Zg7ogABaRpQsAIxtX18TKdXCloRKlXmuRUfU6ueeE0+A64fMeEaM3IoyMlC5lA7EsOCW//jJyaYmV6nUXWmrpPuRt6tswKvQDSGIVs3dltE/HYa6MTCN+tPrwkOsKEJJjbzGbcCAYqICEk8n/gcy71oBBDhmD21zdzCx8xAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726730137; c=relaxed/simple;
	bh=GYF2ZK8/J8YnjuuBh09I3hIaoJeSsgSDLEWEnKiDp7M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RXI1zLMSTvC9DL0aIZewBT9DblyL5Xna9u0wDuzXeMKE18F6dV/R35vgIThkoDqgFnvXvT7KwGgwuLI30C12f6pRBQIKR4iPY6ceDUwfUr6FpeLQqv6mskMTcLoPXvSsXV6W45GJ5qVJIzCuxzXBWw8KUXAUvT3bGbIYalup8yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=rPa4b6YU; arc=fail smtp.client-ip=40.107.117.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5AD3MV1YRucTNkPVoLPqypJu1PO0sAuZgrli/7B48iL08hOP1LeJP+J99wjTrUSXc/GbiIYkng9Rfb77qY31ri5gtWw8iSN1wT9xGrtJqR/gEvd0VqpEcgREHB3g03S9wOtvj7lyh3ztDc+R0NcAhzpUXRbpyE0BjnzoEkR6wtUAAE5YcaBUB4m7O0ipPULIVRKe23KM0jtB+YxpUeZ9B1kowt09rwEoCLo/2wwkR2LaFbLt2jDhPQIrNwhZzYgsAc452KPWeNHLtI+o+LkSDI480SpqToVbXRtaBB6AuMfK2Cllm1vNt/yNhXh+05OqJHAF/TWnBUVnidj/jOlag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYF2ZK8/J8YnjuuBh09I3hIaoJeSsgSDLEWEnKiDp7M=;
 b=CT5Nui1VIJiaCBqTaI6p81VVq/OV//tCSdXK5gqlEIyKT8aTee2eH3BORQuGhr/eenjIIlT44SOQqihmJpR6gq0RIikUB8Rp0BYMkWovquZ66zaESrOzQ7/epNuf3xqEgqN3cledJ+yr9KU9ZyqPnNlaBK8980Tofh4nQJsW+TzRKdq5Qf8N0D0zWJal2JAvxeAQV4srW9vELRqv4bls9BqxAJ1zSiKFswCoKlOD0NdM/Zdm5dyzznhtca2sArhMPQ4XcS8R1g2OrH+sUkB1JrzNQB6irRnqHB73SUUj+PTzINvByZs/1Fq6MlZX7nVHO5xTo21Lf8X2PYNu8wGLjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYF2ZK8/J8YnjuuBh09I3hIaoJeSsgSDLEWEnKiDp7M=;
 b=rPa4b6YU9QFPL1DNiIftjbD2zbIcQvk0IqZ0YrWUXLIu+a7cEqsuFJngnfGm/9fvgKK47Y0dgrNwlif2vDeqWNLV/hETMFDnoOdcAoaTKtDsw5BIzNNm0/6lm0gO0ISmGe655OaNwPA/QkK5l0/VMnlGQsD4GE0g4SPnhPnriuGYU6ff58yu41/mWa7hIHivffFTj/loJMbG7vtGeigcTrFa1VhkfoCZyvJLTIrdznBLTiY9qfowDkI9JT3E1Ue1llilLyEiATdpjQh50/43qMTkyI9rzrp3zJMrGFU70Ji1tSjZFNZhkNbP+rX7XcC2lX3HyzoJi1wrR6IUsdtNcg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by KL1PR0601MB5583.apcprd06.prod.outlook.com (2603:1096:820:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 07:15:28 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%4]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 07:15:28 +0000
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
Thread-Index: AQHbCBhUQ+ayLz0D00qz0gJFvBN4g7JaMBwAgARxxVCAABCFgIAABGwA
Date: Thu, 19 Sep 2024 07:15:28 +0000
Message-ID:
 <OS8PR06MB7541F08D97EC0CF83F8B36ACF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-3-ryan_chen@aspeedtech.com>
 <b9bf19af-0c3c-4622-9124-a66d9df649b2@kernel.org>
 <OS8PR06MB754148AD165538D3D6B6C3DDF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <195a8bfe-e4d7-4140-9635-b86a6ce3c663@kernel.org>
In-Reply-To: <195a8bfe-e4d7-4140-9635-b86a6ce3c663@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|KL1PR0601MB5583:EE_
x-ms-office365-filtering-correlation-id: 019f013f-13cb-4558-6a26-08dcd87ad722
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmJpNklHU3Y5dTlqemErMEZEYVRvRzZhSTF1VUpzcFJhRU9CcEJ1RUNGUDh4?=
 =?utf-8?B?QVM3alozaENLcXFib2cxQ092Zlo1NTJ6aExLYllMS1N5d0tKcHNmMEI3WEho?=
 =?utf-8?B?VXZ1dW5ZS2NkV3EyMktHZ2dkYjY5VFBuRU5HNU5iSE5hQlJEUFRyVm13Y1Br?=
 =?utf-8?B?Zm1sdXc3eWZPL01FWWs4NDQ0aGE1OFEyQk9LdTR2ZkE5eHhrSkp2RzkxUnBF?=
 =?utf-8?B?UzBxSW9rbnJOMlIyOVp5WnZIQTJmeUY2UFhxcEhFNjNsTUVkazM3UitDTmlV?=
 =?utf-8?B?RUhJa2dYZlQ2OVc4cEpmNXpxMHVRNkNDUFdXSEwzTUorRjFkTEkxQkREK2tT?=
 =?utf-8?B?Q2VsVnlxVWVBQUo0VjdQUHhaWmJ5NFJLREFPcm0wbERHNHJWK1VqNy9QbkN4?=
 =?utf-8?B?a3ZLb3JzMnZOUkVJTHpqakM4SjFtNzBvN2RJa0psbzZWeWZlR1BRN1oyV09s?=
 =?utf-8?B?N3paY0VpeHpCN2E2U1pGUGV5L2JXZVRkYmRtQTlHRjhZV1pzM21YMlE1SmhT?=
 =?utf-8?B?SlhXTnBNL3NNYjlwYkZzYmZveXpkcXREVkV1SENMQnQ5S0JVVS8xWUFNa2N6?=
 =?utf-8?B?ZTVOcncwcXk5cm5IZ1B5Z2VrMVFQeHEyT2swNWRRRnpWMis3cFpVeXJlbCtW?=
 =?utf-8?B?U1BuUVNaWWFRZ3dHVkUzenprMzM2Nk85dHdwemFvdEIxeTZVamJlSGovaktZ?=
 =?utf-8?B?ZlR2M00xTExtV3BFdlIvYVJWbStESXhaWGxOZlczSUVFcC9PT0lSR0ExazJD?=
 =?utf-8?B?RlV0Z3V6TktGZUQ3dHphY0NtSUF6c1ppNDBpNWRudDF2SXRHWlg3QTNsU1ll?=
 =?utf-8?B?SHVyK3NZem5od2J1QzR2SmV5RnpUM0xMc01Yb1YyNjk0d1JXRS92T1FJQ1pJ?=
 =?utf-8?B?KzB4UGQ1MTZOY0hxdURXZkx2TkF0VFFrWUVCcEQ4NExiWGRJZHJ4aDZVZlp4?=
 =?utf-8?B?QnNHNmx0U0FkTnZFaUtXUjFjd3pxeEptbXFMNjF3Nkl4VlRQNldLZGdvQ2Zk?=
 =?utf-8?B?Sm1VdDJSaXpoT05lZkFyUW8xMytXZnZkZE5jZUxzTURWdlNOVG9zcXpuL0Jj?=
 =?utf-8?B?TkdLbUxlS1I4aDFhTGI3dDl1YlB0WjZDRFZqSXBCdCs1ZG4rS3ZmTmMrK2VX?=
 =?utf-8?B?K3dpTXIvSk1zanZRY29DU0l1ais0WkxCa0k0Wll0aytSbDdXSkRaZzV0UWdm?=
 =?utf-8?B?eVA2TzdlZVZudWlsZGhpcFk1NitKZXNubmJJOHVUUlh4engyM1ZkeXM2eitK?=
 =?utf-8?B?dmw2eXlkSXdFbm1KSXNEQlBTOUNLaWRZamV5V3NidGI0clhDclZGZXBCdHV1?=
 =?utf-8?B?aHJsdFN0U21aRm5EYW12MGxKL0JLRDhySlZhR3J2MkhPMlNPbnlVQXNDaS9L?=
 =?utf-8?B?Nlc2S25ZYjFVT2Rhb0NnbVMrTWJxQiswdGNnS3ZpL0JKUGxqSjUwcjAxWUht?=
 =?utf-8?B?KzVuQ0M0Y2pjOGsyekc2WHNZM3FZSmx3RXB0aUZISnd4Ynh2Wlh1emYyVE90?=
 =?utf-8?B?dkZPQVQ5aE1IYzBNU2ltUmpYYURxOFlWNDdXSzdyc1FMN2Zic3lxWFZJSzdu?=
 =?utf-8?B?ckxJajBRcXU4aTYrTE8xZFVkd0xia1k1TXYzUXBVaC9YTHhJNWJNQ1ByVlNv?=
 =?utf-8?B?K2xqdVNaQmpHaWNpYjJZWG5xOEJQYzB2c3ZnVTIySFlOTUUzcUViQnlVRkN0?=
 =?utf-8?B?WGMydDlZQUtHQzcrN213a0ZobWRpcllvNWFqL243UWt1SndjcWhiUkc5VXNv?=
 =?utf-8?B?R0VRZC84OHdOMFdIczRJbWNCanlFWHNzc1BlTGxPK1UwdWtlNThLRWJFMWpo?=
 =?utf-8?Q?OY2vuogjPPbyFWT3+52YFjIVYpECHuywqwcIk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2E3dUVwR2RyNFU1WHRmbXBGMVQxelE2cHhDZW9qVGd2Wkt5Q2ZDSE45OUNi?=
 =?utf-8?B?bXY5Ny9aRG1BREFRWEdQd1M1d2YwcmFhMW1ld0tVWDlncVlWQktacTV4Q3dq?=
 =?utf-8?B?VUx5Y05HejViMy9INUJBOW9PcndKTEQwRFlBVnpldzMxWGhTbHhtTUVyQTRN?=
 =?utf-8?B?dW40MUFnUjFVMVBjN0YrVEh4OTlKRmtVN0s4SXMwcG84ZlE2citlcjdvUXYw?=
 =?utf-8?B?RmhzSFBGV2FTekFSYnBHNFJ1cjVGSUhPNE9Vai9pQUJRM3Z0RUpueFJZc205?=
 =?utf-8?B?ZVNKU1c4WUNlK1pQd1FPcXd1WVk2R2RkMVQrV1R3QlMzWFgrVDRwSngvRkg3?=
 =?utf-8?B?ZDEzTUtITnplQklOcTBPSnFJM1BST3lqeHVuT3NWWVV5MHFHSWtVbGI2NEVL?=
 =?utf-8?B?QW51NGdIU2VsWnBkM3k5ZWhDRnpGN1NVUzY5OUNxWDdWWEdsWWV1Qzc3amRw?=
 =?utf-8?B?c3JDeHdQYlI5ZFNscnh4eFRhU1o5LzhiamFQanRkUDBaeEpMMmt4SllCaTMy?=
 =?utf-8?B?MlFHK2kra3ArRnRMS0p6RE51R3A2MDRRWXFZbUFySDYyMFJJU1ZwUFhid3Nx?=
 =?utf-8?B?R2xVRDNzUzB1aU40Yk9BemtwVG5mWkxRRDhYM3kvQklVeGdtc2pjYzBSbWZY?=
 =?utf-8?B?NHFDMzNxc08yOURYeFZZU01TZ1kzS3JZdDYwRnRCMklkVEJDK3pQeWI2RkdE?=
 =?utf-8?B?SnhGRW90b29Bci9XNzZObVQwTnhHVFU5cGRZS2c0ZHU1cDNWc2xjd2d1UDhB?=
 =?utf-8?B?VDJHR0V6b2ZURmFZZ2Rqd3dtc2NPVVcvb09nNHlEK2FIQXhYdzlDck9CcHhV?=
 =?utf-8?B?SzdjZGpTeGRhekFpZ3hPMEtldGpCV244TUxXTEZhNXVtSUZyaG9UWWF6QkJy?=
 =?utf-8?B?NVo5dGNjZk81TFc3S0hrR0pzaFNzNU9aUjhUTUVTbUNGU1YzZHJ2b3A0ZW5Q?=
 =?utf-8?B?WGhBU0NUbVc1ZlBpc1ZFd0dEcGV2Q1pxVExzVTFRNTM0YkhaSmphcHZjUUpX?=
 =?utf-8?B?eENLSDJzTUUzTFVVV3hxQnQ4ZzRLV2xQSERUVFVXZWMwcTExblhTeUhLbXYx?=
 =?utf-8?B?RDUyYUp1dU1rQnFWTmE4cnJmYWE3ZHZwZGZYWmtUVk9FSlhiQlZlN2ZRL2lx?=
 =?utf-8?B?bVZuV2VCK0JNbFdVVFZqK0tpcUczblRPV0UvTXlEbmMybnZLVVBiTStaa3lI?=
 =?utf-8?B?bm9lZlNPWitUZE0vQmlOR0xENnhKdk13K3ZlZVRPMzlmdGw2dHlVUVppWFlZ?=
 =?utf-8?B?TmovYWxLNkphNmF3cC9VNFNLa25aNFVudk5LKzU5SURRSGlaN1FIVGlFaXpv?=
 =?utf-8?B?eVg2OGNuWDhnbjNRSTlScEF6QUwyY0pQWHhhOVZ0MDQrRnVKZnZzMmNGenZQ?=
 =?utf-8?B?RENBSmZWeWVVdkl2d01ndFhGRUZ2cENWaGpjT0tvdGw5TGdERUNBS0dHYVFa?=
 =?utf-8?B?UTQ3N1gxK2hNajhsVHZFRXV2L0pCVHFML3lybTEvejZDVWQxbm8wT2hTMXpY?=
 =?utf-8?B?RGpieFEvVU9YeUFCeFltd21nNEk0aHVIU1FyaUlEaVhteTk2Qk9TQ1lCOHpY?=
 =?utf-8?B?dVJNKytoNVltbDFKcGFTZ1d0alJhYWdJTzVXRUlKM2lSOXdmVE0wK2NsdDVl?=
 =?utf-8?B?V3VUYXlSR0xsMlkxa3M0bmVZOFpsam5mVzBZU21zd1pubEVoQlRlNE50cVFX?=
 =?utf-8?B?VXdlaFh3Y3N2ek9mQ2YyYml6OE02Rk1NMHlFWXRqcGlLWnJVMkE3V1RCR3NG?=
 =?utf-8?B?bUdhVHZ4Z2tHMHlINTJmNkRoZlFGeEorWEVsRHk3Rk9URHRiZFQ3ZmpFaGxE?=
 =?utf-8?B?bXA4SkhIUWIrLzFPNEhkY0JKc2JQUGF1bG1nR0FGdWVOU2Q0UmtiNnZLSDVW?=
 =?utf-8?B?OHFRUW41ekVCQVVZcWxoYXhlUGRBT08xWVY3OXk4ZTYzaUVFaGk3SHozd1pw?=
 =?utf-8?B?UmVLdFUrUm5ITmwrWXVVZjg3MUJ5a1lwRFVDQ0JmYWovSmFGNnVZL1Q3SHBt?=
 =?utf-8?B?TTVNOFRtTUd6NWY3RnpuZHY4QzVuQ1dCSGg4cnByWFF0UjhQTUFSQitud3p5?=
 =?utf-8?B?cTlDazVyMy84YlhWNytUOVNVbE1waXgwbHNwMkRiTGY2ekdlTkJNSnRzZkpN?=
 =?utf-8?Q?KxzUItT037F1QREqfpo9mamhe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 019f013f-13cb-4558-6a26-08dcd87ad722
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 07:15:28.6332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSQJc6CXjl22OpK1/lNIsmJCiVHOifv/PpsnbcgMuumn5Xmt0Kl0JCc/auSCfzpfsS3j7pFsugH7HX+z8aBZqkjb6Vz+/ob6Tnwv5KTwczs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5583

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvNF0gZHQtYmluZGluZ3M6IEFkZCBBU1QyNzAwIGJp
bmRpbmdzDQo+IA0KPiBPbiAxOS8wOS8yMDI0IDA4OjAxLCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi80XSBkdC1iaW5kaW5nczogQWRkIEFTVDI3MDAgYmlu
ZGluZ3MNCj4gPj4NCj4gPj4gT24gMTYvMDkvMjAyNCAxMToxMCwgUnlhbiBDaGVuIHdyb3RlOg0K
PiA+Pj4gQWRkIHJlc2V0LCBjbG9jayBkdCBiaW5kaW5ncyBmb3IgQVNUMjcwMC4NCj4gPj4+DQo+
ID4+PiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4N
Cj4gPj4+IC0tLQ0KPiA+Pj4gIC4uLi9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0MjcwMC1j
bGsuaCAgICB8IDE2Mw0KPiA+PiArKysrKysrKysrKysrKysrKysNCj4gPj4+ICAuLi4vZHQtYmlu
ZGluZ3MvcmVzZXQvYXNwZWVkLGFzdDI3MDAtcmVzZXQuaCAgfCAxMjQgKysrKysrKysrKysrKw0K
PiA+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgMjg3IGluc2VydGlvbnMoKykNCj4gPj4NCj4gPj4gVGhp
cyBpcyBzdXBwb3NlZCB0byBiZSBwYXJ0IG9mIHRoZSBjb21taXQgYWRkaW5nIHRoZXNlIGJpbmRp
bmdzLiBZb3UNCj4gPj4gZ290IHRoaXMgY29tbWVudCBhbHJlYWR5LCBkaWRuJ3QgeW91Pw0KPiA+
DQo+ID4gU29ycnksIEkgbWF5IG1pcy11bmRlcnN0b29kIHlvdXIgcG9pbnQgaW4gcHJldmlvdXMu
DQo+ID4gSSB0aGluayB5b3UgYXJlIGFzaywgeWFtbCBhbmQgZHQtYmluZGluZyBoZWFkZXIgdG8g
YmUgdGhlIHNhbWUgcGF0Y2gsIHJpZ2h0Pw0KPiANCj4gSXQgaXMgb25lIHBhdGNoIGFkZGluZyB0
aGUgYmluZGluZyBmb3IgdGhlIGRldmljZSBhbmQgaGVhZGVycy4NClRoYW5rcy4NCj4gDQo+ID4N
Cj4gPj4NCj4gPj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9j
ay9hc3BlZWQsYXN0MjcwMC1jbGsuaA0KPiA+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRl
L2R0LWJpbmRpbmdzL3Jlc2V0L2FzcGVlZCxhc3QyNzAwLXJlc2V0LmgNCj4gPj4+DQo+ID4+PiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQsYXN0MjcwMC1jbGsu
aA0KPiA+Pj4gYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLWNsay5o
DQo+ID4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi42
MzAyMWFmM2NhZjUNCj4gPj4+IC0tLSAvZGV2L251bGwNCj4gPj4+ICsrKyBiL2luY2x1ZGUvZHQt
YmluZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3MDAtY2xrLmgNCj4gPj4NCj4gPj4gVXNlIGNvbXBh
dGlibGUgYXMgZmlsZW5hbWUuDQo+ID4gTW9kaWZ5IGZyb20gYXNwZWVkLGFzdDI3MDAtY2xrLmgg
dG8gYXNwZWVkLCBjbGstYXN0MjcwMC5oLCBpcyBpdCBvaz8NCj4gPiBIb3cgYWJvdXQgdGhlIGFz
cGVlZCxhc3QyNzAwLXJlc2V0LmggZmlsZSBuYW1lIGlzIG9rID8NCj4gDQo+IE5vLiBGb3IgYm90
aCB1c2UgdGhlIHNhbWUgZmlsZW5hbWUsIHNvIHRoZSBmdWxsIGNvbXBhdGlibGUuIEZVTEwuDQoN
CkRvIHlvdSBtZWFuIHJlbW92ZSBhc3BlZWQsYXN0MjcwMC1yZXNldC5oPw0KQW5kIG1vdmUgcmVz
ZXQgaW5mb3JtYXRpb24gaW50byAiYXNwZWVkLCBjbGstYXN0MjcwMC5oIg0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

