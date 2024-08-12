Return-Path: <linux-kernel+bounces-282623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EE994E691
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141AF1C2145B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4668814F13D;
	Mon, 12 Aug 2024 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="MfmpiDO+"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2108.outbound.protection.outlook.com [40.107.215.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A98027457;
	Mon, 12 Aug 2024 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723443990; cv=fail; b=N+C2OPZUifHxMTraqWwsWCKw8pr4i1nnwqDnf8tv7j54Z5oX7MEl6LbHHV5glDvxwv1qlC11tq2b2jlcN2JpJ3wMiF8hs4wQJOOCOqfVOoTr3KfnXqzNxaOdnqcRqsE4VV+2zezwEN0tWnSAs6anbfnMgXm2oNxB3o5/2MiV9c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723443990; c=relaxed/simple;
	bh=0Y26NFRybjQ/vFujTrJTUUYMwWTAwze51r1oYWeDQ7k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JEk1v1vhYtCE9lS9TpaWinmcmbCk/rMmMPOsE3ZTwxBcN5/og+4NB/gV4MA30XpNyGJsbRjbF9LYq6u7fGLDYOjQxomVIbsCj1Btu4/WzmzieGZVKQzKhLV6fizNYx5j+TVc4PUsp30IXMJRzYQ9QUc4QXbFmnKGwNRxudx3WT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=MfmpiDO+; arc=fail smtp.client-ip=40.107.215.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSNY2CuuNwD8yk/FigbXoZb5ZnRsyKtWoKFxbiSVpm5M53HJO5yqDEGedIyM5rFJrCW54t0lav9NsVmuv2/J//7RXHasT5lxhkBcM6hu1jgl1BBlmV6pQghqacP5X26PkqDM3FrQMhHn+xnAiG+54pQvG2Icf3tYNKCQ/ALo2bTGgNl3yqztQ65Us3qoRBH0vvcHyP5yHhPMc87WV4F1COWvvY2Fb8/6i/qOtvh093QgtaMejixwoE25CQYE7sE3ikhjg38VK0th8MKCW4PRcP7SOFglN04mZn3yWB6pNM9Y/g529zkrS7V8oo+loiV730saQDOfj48/Th3W/YgJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y26NFRybjQ/vFujTrJTUUYMwWTAwze51r1oYWeDQ7k=;
 b=DeQfD6alX2uDmC6pcH0NaO+o0dSAioX5SFlw61gZG0tBmOpd5RZr/xIADDk1VhLvQYK9C4Cy75YqcjqmX91V3asBEdzjaUkIjvZn4HevJo2k5sHuJyRjOfFDmcEVUtqnZs0JgMj8QzAST3Ui9XbggqVlPJPg2dhkMut4XhTnkc8upxqwsXbx14QwcZAWwtnMOzPtmyMdMqPzf25vusVZ8ztsKaVNyk0Fcdq4z5v9w90i3RhXFlXdlahF/W/+TO/8EqYXEyaws6q0SzU4VHkKg/ztNhdHrYqq+GDz2kld6Z/m7PcJ9BUgSyLUazyNd7Br9JW6914bd9YmuTGN02IFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y26NFRybjQ/vFujTrJTUUYMwWTAwze51r1oYWeDQ7k=;
 b=MfmpiDO+QV+RDXI974nW+aLPe2y+K/wIHBBZhY+U1TF4GTGhBniF9ElOX4tEQBrJFduj20qLKD9GiHhWFHgJNimwcd7b1j4TVub+rMvYQkisoFVv+f4yHRyhwIV1FodJNM4azt1sczpEp3FIetqtaPzuwHPy58zQG+oEJKvE50NJpn+NneIQZtUqhZJEMPUoNnw6w8H3n94B1+Jxz1IFxYJlIkejWSJiXE1O4UHKWnJaeYLq1D5r6VB/Lkd/JuuyLXHBL45lS7buv74iEQQiiDgq8fP4FTg1ZUlx4VTXbgy1Gkgkyh69CsNAGLIh2b9oy2Z5Fqdv0Kh7TeHdtrLFOg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEZPR06MB5521.apcprd06.prod.outlook.com (2603:1096:101:a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 06:26:22 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 06:26:21 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Topic: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Index: AQHa6Wjwpmm6AqTUmky9VcIbkjW1JLIdJMiAgAFHtRCAAAQ8gIAAARxAgAS7u2A=
Date: Mon, 12 Aug 2024 06:26:21 +0000
Message-ID:
 <OS8PR06MB754103B3285153723708931EF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
 <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
 <OS8PR06MB75416FAD2A1A16E7BE2D255DF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <10809e91-31be-4110-86c1-1e1ccb05b664@kernel.org>
 <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
In-Reply-To:
 <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEZPR06MB5521:EE_
x-ms-office365-filtering-correlation-id: 032af5f7-3b64-4259-6bd2-08dcba97af0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3E0L0V2RXd1dCtHY1l2RDVBemFmbk16QjlLS3djY3Awb2VyY1lGY3VCVEp6?=
 =?utf-8?B?Tk8wWEtzbmVtVVFNZjZNSFQ1ZndEMWVySUk5bzhPdngzUFJoTDU3MDVzdk50?=
 =?utf-8?B?bTdGbDI5QitCUVI2U085b2xyTWo0Z3FDS01XaXNUbGFhWC9wK2Y4SWE0d1k3?=
 =?utf-8?B?VFVmTEhkWThVaWpwN293Q3h6UzgzZDJaT3N5SUp3SW1yZ09RcVhlbnRvR3Q1?=
 =?utf-8?B?L3c4RldjeWpnRU1kOHc0OFI5YmxMK2pQWG9TSkVjTWJLWTNLUmYxMm9hWmxH?=
 =?utf-8?B?RHVjWWpQb1hGSVN3SkNlSVYyN2hFeTJzdit6YUhwYkJqWWxOYVVzejhOcUcz?=
 =?utf-8?B?Tms4NjFVcWt0dXJOS1owRERlMzlPZmNIQ1c4enU3b25DYUVLVzdKamZKTjZO?=
 =?utf-8?B?OTYzeDlNcjJzQ2k4QTRxWXNWaVBiQWJzNk9VaWpqME1UNGpUSjhBNTNMeTZt?=
 =?utf-8?B?eW80SUlSanBZTGZIYWJ3MmlubGxuUG94SFpQTDYvdk5yQktyeE1MOWlkdjg5?=
 =?utf-8?B?dDRqNTBTZVVSaWlTL1RMZ3d1dWxoUWJkUUhsdDlVTzlDM0cwZWhkb1g1V2Jq?=
 =?utf-8?B?WEJyM2E0cUloRW1CVFh6Q2xZTXJyTy9TbjhRSG1oSHBPVkhxcVBnb1p3RUwx?=
 =?utf-8?B?UW5UandIeWgwekRrcW1VNXRMZlFURmdvZE5HNTlFdENkcVZURE5JMk1vTVpy?=
 =?utf-8?B?TmxQbEVPU1ZVRDF3ZHpqajIvYWVML2NQQlJScGxYcTBmRlF5QVhUV1l2WUFB?=
 =?utf-8?B?SkIzRStnRy8rVGdYb3k1MW0zQUhwTmRReG5kajh0ZTVnc3k1aDFXN2ZaR1U4?=
 =?utf-8?B?V3laK2Z0ZVQ5THdUV1dpR1BrMGNSU1JzN0J0YnlsVk9uSXpyR0Q2bVF5UEtP?=
 =?utf-8?B?dktWbE9VQ2FNMGJoM0FDUzROREMvWTdwSEdDc2pjcjQ2emM1Qk1CRmp4ZHov?=
 =?utf-8?B?MjRPblB1WWR2SEgrMGJrYnQrVnVMUjVqbFR4TWRQMWp0eWxQemJEbU9mYVpI?=
 =?utf-8?B?aHBoRWZHQy92RDA3R21NOUFQaHMyQ3kzTHcwSCtFb21yVE1SOXBpK1J5TEtN?=
 =?utf-8?B?R2F1OTZaUnMvTmxnVmxnT0NNd1g5ekMydysyL201ZjRtY0ZVQ1hPdEc4R3U0?=
 =?utf-8?B?ZmwxM1RwWE9NcDRNQ2lwcDU0VUo5SElCZjVzNDc0T1dPUmhVZlFDMUdYK3ln?=
 =?utf-8?B?czNvd3RnSXdad2o5U05jLytNL3FxNW8rY1hrb3pGVTR5dnJBVGxvWlF1em9C?=
 =?utf-8?B?U1BtRWVkZ1pnOWYyWklWUC9UVGlpK2tYL0FPOFVsOHhSeGw2aU9WWFl0cHNR?=
 =?utf-8?B?YjJXTm5hSHFsZXFyekhMZVo4Zmo3dG8wSnd6SlM3eit3dWR2eHdLWEdlcThI?=
 =?utf-8?B?S2w1Tlc2dmxpZ0hnc0FUbXRpSHJlVUF6SldRV1BNbmJTVTZHemRjRHpYeUdq?=
 =?utf-8?B?RjdvR0N3WXpQemRrRnlrZmZ0UTI5VkZnSE8wTkY1cTlSalpUWTBiT1dQTTU2?=
 =?utf-8?B?Sko5QkxXZ29ZM0QxYXlGcHNRSzNnWTFBZnNuVmNTazN2QUNzcFlVRDR1bDFm?=
 =?utf-8?B?eDV1NmhCSXlWaUN2UDNMWGNnb3VKbm1aTmVVMkVsaVVXZzYwYldjVEpCeno0?=
 =?utf-8?B?UlhPbjZjQUttQnhwTk9FVEg1OGJEUkVMcXlGV2VuV0JSZ0MxQjdGMUhFeVNq?=
 =?utf-8?B?aUdFVUxPK3NFOE5zeDZuNDcvdVZUUnBHRmFlR2lRYXNYSnJ5NU05VmtuNU5U?=
 =?utf-8?B?WmFRL3N6MkN6d2VIRHVTQnVSNTI3OGZJeTlQMFN4WU03ek0rc0t1aUhjRGVC?=
 =?utf-8?B?d0R6cFRLYU1CK3RCL1RVbi95UFY3bXNpa2drbm5LNVBoUnF3emZBQ0MzTWhu?=
 =?utf-8?Q?lA/4SmKWgN3PL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWhlT0Vyck5xMkNlb1V3bjFmV2J3N0RrMXhMMHhGTlBhamFXY3RtU1BGZGR3?=
 =?utf-8?B?LzRaYjhHM2p3QWhXQmJKMmpmRGZzVlp3Y1oxRzluMWthY0F0ZDNQSldnam5B?=
 =?utf-8?B?OXdpNFFFeVUzWit2RDI4Yldrd0VPQWtQSGtxWk9TRFREdTRwMFJ3QUJabndW?=
 =?utf-8?B?Qy9OQmw3RFVDeXN1Vm5tdXhqYVZUQ2oyODBpMEpZTC9ucWNibUpCaGZ2RFZH?=
 =?utf-8?B?MnpmbkRnd0xLZEV0VGVXWTFxd3Z3UExsRkNURDFyMzVzcTRCV0pGQ0xsd2hJ?=
 =?utf-8?B?UWU5U09nZnFkWkhiTXlNOWxXWGhxdnNuNngrQ1RuS1IwU2xRRVVjcmRLT2JU?=
 =?utf-8?B?MThnVCtiV1NONG9ud3p6UHpodk5UODU1anhHV2JHcTZZcmJhamllVmRQM2p6?=
 =?utf-8?B?RU9tVGdRdUsycm0rcllBeWpPTVVML3MxaXEvZTdsV3RjYk83SFEzVTlnN2Vm?=
 =?utf-8?B?aU5iSDFKUmdxbUVSQnJ4YU9oMGNBOWs3NS85dUxJdCthZEN6aE5aY2VMWDcw?=
 =?utf-8?B?dlNNakdJS3FnM1hBZy8rWVhHZ0J5RlQ2SERCSWlLbDlmM3Y3NEoxQXlndml3?=
 =?utf-8?B?L09ZblVrVjlZK0ZJb0NzZWRBbHNUQlFMSHlxamFvUXFiWVBJS3FlMGl1TitX?=
 =?utf-8?B?QlZqeEJSbm9CTVJJaVZhc25Yc0RjMEFYVEFXNmxEb2FVWE1lQlFEcG5rSmg0?=
 =?utf-8?B?U2REMUg4bXRnc3lueFlwZmszbW5rSFJqMHJ6cHpsWm1xVXJBTm1EbzRFTVBh?=
 =?utf-8?B?K01YQXlNd3FIZVF0Y2VVZUh6N3oxMlBYZXlwYVFDNG1FeEExcmw2OWFWdS80?=
 =?utf-8?B?K1UrOHNUS0pDanFTMmE1aWVKNGFBT1dhNWZSL0dQS0UwUktsVCt6NW9Ba2tY?=
 =?utf-8?B?NHpndjhJSm1VNWRacExrMHZPbzFnQjNiaDBSUGxTNFhaYWtuSzBIandXUUds?=
 =?utf-8?B?cm0wenVUVzJ5MCtFWkx0eUFkOXNBOHJWczNYdWthMlQ4RHM3Z2E1bXZ6VWEv?=
 =?utf-8?B?OEdxbWF4eGIzOXIxblpaQ2tOT0d4aTBRRGFMeWVhL2F2TjhhcU8xNUVtOThM?=
 =?utf-8?B?NFhvbXJEd3RwSllEZER1aCtVV3VGTjk4RFBEbnFZcjUzZ0M5TnZ1WTFyeGhO?=
 =?utf-8?B?bUFSVTlaVGF6TE5tTlJIL2V0MExHYTJ1a0pCWnZkQlpXeDFLQmJnUU1wYjlO?=
 =?utf-8?B?RjFsM3B5Um9vcFdXbk9XVmdwQXRLWG5rZ1VLWkhCTnFjR3FtNnNFRE9MUEZ3?=
 =?utf-8?B?bS9qWlJEUUl5SGEwZ1JnTXl1cUM5cFFzSXNUb0ptcmUyNDQ3SXIrSmx3QTI5?=
 =?utf-8?B?Nm9jdDQ2VVZaRGJCM3ZwQ3pURWkwczZISXRxMnhSWS85TTQvbnJCa2EwdXFr?=
 =?utf-8?B?elBEcDhiT29NUlFwNlp2azVlUUNESTdwdGVVcVFrNktLNmF4K1BKVWNlMGJW?=
 =?utf-8?B?MUEyNDlSRTdHODRGRXRlS2N6V2dvNGxNdHpob1lNNGtYYkp0WXFHYTFEZ2hH?=
 =?utf-8?B?WG9rRTZrN0VidDhFZk5xVldLK3lOV1pWa2FJVjRGQ0pCQlVqZXpvU3pkUjd2?=
 =?utf-8?B?bjZ1d0dDUmovNzBTVnF5MlVzZHF4b0p0dk8yVWJVM1dIZU9Wa2pnSEdDY2Yz?=
 =?utf-8?B?UEhqQmY5VWJKL0loQWZJOWhJaG1yVkZpbk0weFVRZ1BBdUwzeXB5NFFjcmJC?=
 =?utf-8?B?bWdiUlNLZ3FTaDYzL21GVklURlNzODB4RnJUeFJSVUxvZkJwRGMrSXRvdzNt?=
 =?utf-8?B?REdkRnJUeDdzdUtjSUx3QnZjdVBxM2RRU2RaT0FPSjVab0JTcWg5Nk1UN2po?=
 =?utf-8?B?SDZnWHd1THEvQkg3S0t5M0lqaWp3SzNaVUExVjNDa3hyLytncEkxcVlySk5o?=
 =?utf-8?B?MktPT0ZlcXFDZkhiUDFnNTZiakF4QXFVK1czUDhmYTBTNXNDamVwNDE0RmI4?=
 =?utf-8?B?d285N2NRVm9mZHZqUk9mL1FUWTJQejRYZ3JWUXpYK2NNeUhSL0pjTEU1R2R2?=
 =?utf-8?B?Y3E0Ylgwc3ZRbmRERUdtZ1E4czNvbGI5UDF3TEJJRERSbE56cHdkZU5Hd2tR?=
 =?utf-8?B?Q3hnRTlIazJSUjgwUG1rQmIwN1ZSNDRCWlhOb0ovb3FhVzVVK2ZRMmk4TUpR?=
 =?utf-8?Q?o4/7zajQhA5cgTNMCpINuOHMe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 032af5f7-3b64-4259-6bd2-08dcba97af0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 06:26:21.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mre+xO0e3HXvlYQDuYD/ertTk3WZ3U+CRH6Adbr/FqnSYeuNMyn4QR4qktMQhzDeD4gzuoURqvpus9+yQOL+18JII6is7segUtjyhs9yzH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5521

PiBTdWJqZWN0OiBSRTogW1BBVENIIDEvNF0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkOiBzdXBw
b3J0IGZvciBBU1QyNzAwDQo+IA0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBkdC1iaW5k
aW5nczogbWZkOiBhc3BlZWQ6IHN1cHBvcnQgZm9yIEFTVDI3MDANCj4gPg0KPiA+IE9uIDA5LzA4
LzIwMjQgMDc6NTUsIFJ5YW4gQ2hlbiB3cm90ZToNCj4gPiA+PiBTdWJqZWN0OiBSZTogW1BBVENI
IDEvNF0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkOiBzdXBwb3J0IGZvcg0KPiA+ID4+IEFTVDI3
MDANCj4gPiA+Pg0KPiA+ID4+IE9uIDA4LzA4LzIwMjQgMDk6NTksIFJ5YW4gQ2hlbiB3cm90ZToN
Cj4gPiA+Pj4gQWRkIGNvbXBhdGlibGUgc3VwcG9ydCBmb3IgQVNUMjcwMCBjbGssIHJlc2V0LCBw
aW5jdHJsLCBzaWxpY29uLWlkDQo+ID4gPj4+IGFuZCBleGFtcGxlIGZvciBBU1QyNzAwIHNjdS4N
Cj4gPiA+Pj4NCj4gPiA+Pj4gU2lnbmVkLW9mZi1ieTogUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNw
ZWVkdGVjaC5jb20+DQo+ID4gPj4+IC0tLQ0KPiA+ID4+PiAgLi4uL2JpbmRpbmdzL21mZC9hc3Bl
ZWQsYXN0MngwMC1zY3UueWFtbCAgICAgIHwgMzENCj4gPiA+PiArKysrKysrKysrKysrKysrKy0t
DQo+ID4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gPiA+Pj4NCj4gPiA+Pj4gZGlmZiAtLWdpdA0KPiA+ID4+PiBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXNwZWVkLGFzdDJ4MDAtc2N1LnlhbWwNCj4gPiA+Pj4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FzcGVlZCxhc3QyeDAwLXNj
dS55YW1sDQo+ID4gPj4+IGluZGV4IDg2ZWU2OWMwZjQ1Yi4uYzA5NjVmMDhhZThjIDEwMDY0NA0K
PiA+ID4+PiAtLS0NCj4gPiA+Pj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWZkL2FzcGVlZCxhc3QyeDAwLXNjdS55YW1sDQo+ID4gPj4+ICsrKw0KPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXNwZWVkLGFzdDJ4MDAtc2N1LnlhbQ0KPiA+ID4+
PiArKysgbA0KPiA+ID4+PiBAQCAtMjEsNiArMjEsOCBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4+PiAg
ICAgICAgICAgIC0gYXNwZWVkLGFzdDI0MDAtc2N1DQo+ID4gPj4+ICAgICAgICAgICAgLSBhc3Bl
ZWQsYXN0MjUwMC1zY3UNCj4gPiA+Pj4gICAgICAgICAgICAtIGFzcGVlZCxhc3QyNjAwLXNjdQ0K
PiA+ID4+PiArICAgICAgICAgIC0gYXNwZWVkLGFzdDI3MDAtc2N1MA0KPiA+ID4+PiArICAgICAg
ICAgIC0gYXNwZWVkLGFzdDI3MDAtc2N1MQ0KPiA+ID4+DQo+ID4gPj4gV2hhdCBhcmUgdGhlIGRp
ZmZlcmVuY2VzIGJldHdlZW4gdGhlc2UgdHdvPw0KPiA+ID4NCj4gPiA+IFRoZSBuZXh0IFtQQVRD
SCA0LzRdIGlzIHNjdSBkcml2ZXIgdGhhdCBpbmNsdWRlIGFzdDI3MDAtc2N1MCBhbmQNCj4gPiA+
IGFzdDI3MDAtc2N1MSBDTEtfT0ZfREVDTEFSRV9EUklWRVIoYXN0MjcwMF9zb2MwLA0KPiA+ID4g
ImFzcGVlZCxhc3QyNzAwLXNjdTAiLCBhc3QyNzAwX3NvYzBfY2xrX2luaXQpOw0KPiA+ID4gQ0xL
X09GX0RFQ0xBUkVfRFJJVkVSKGFzdDI3MDBfc29jMSwgImFzcGVlZCxhc3QyNzAwLXNjdTEiLA0K
PiA+ID4gYXN0MjcwMF9zb2MxX2Nsa19pbml0KTsNCj4gPg0KPiA+IFdoYXQgYXJlIGhhcmR3YXJl
IGRpZmZlcmVuY2VzPyBFbnRpcmVseSBkaWZmZXJlbnQgZGV2aWNlcz8NCj4gDQo+IEFTVDI3MDAg
aGF2ZSB0d28gc29jIGRpZSBjb25uZWN0ZWQgZWFjaCBvdGhlci4NCj4gRWFjaCBzb2MgZGllIGhh
dmUgaXQgb3duIHNjdSwgc28gdGhlIG5hbWluZyBpcyBhc3QyNzAwLXNjdTAgZm9yIHNvYzAsIGFu
b3RoZXINCj4gaXMgYXN0MjcwMC1zY3UxIGZvciBzb2MxLg0KPiANCj4gPg0KPiA+ID4gU28gSSBh
ZGQgdGhlc2UgdHdvLg0KPiA+ID4NCj4gPiA+Pg0KPiA+ID4+PiAgICAgICAgLSBjb25zdDogc3lz
Y29uDQo+ID4gPj4+ICAgICAgICAtIGNvbnN0OiBzaW1wbGUtbWZkDQo+ID4gPj4+DQo+ID4gPj4+
IEBAIC0zMCwxMCArMzIsMTIgQEAgcHJvcGVydGllczoNCj4gPiA+Pj4gICAgcmFuZ2VzOiB0cnVl
DQo+ID4gPj4+DQo+ID4gPj4+ICAgICcjYWRkcmVzcy1jZWxscyc6DQo+ID4gPj4+IC0gICAgY29u
c3Q6IDENCj4gPiA+Pj4gKyAgICBtaW5pbXVtOiAxDQo+ID4gPj4+ICsgICAgbWF4aW11bTogMg0K
PiA+ID4+Pg0KPiA+ID4+PiAgICAnI3NpemUtY2VsbHMnOg0KPiA+ID4+PiAtICAgIGNvbnN0OiAx
DQo+ID4gPj4+ICsgICAgbWluaW11bTogMQ0KPiA+ID4+PiArICAgIG1heGltdW06IDINCj4gPiA+
Pj4NCj4gPiA+Pj4gICAgJyNjbG9jay1jZWxscyc6DQo+ID4gPj4+ICAgICAgY29uc3Q6IDENCj4g
PiA+Pj4gQEAgLTU2LDYgKzYwLDggQEAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gPj4+ICAgICAg
ICAgICAgICAtIGFzcGVlZCxhc3QyNDAwLXBpbmN0cmwNCj4gPiA+Pj4gICAgICAgICAgICAgIC0g
YXNwZWVkLGFzdDI1MDAtcGluY3RybA0KPiA+ID4+PiAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0
MjYwMC1waW5jdHJsDQo+ID4gPj4+ICsgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNzAwLXNvYzAt
cGluY3RybA0KPiA+ID4+PiArICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjcwMC1zb2MxLXBpbmN0
cmwNCj4gPiA+Pj4NCj4gPiA+Pj4gICAgICByZXF1aXJlZDoNCj4gPiA+Pj4gICAgICAgIC0gY29t
cGF0aWJsZQ0KPiA+ID4+PiBAQCAtNzYsNiArODIsNyBAQCBwYXR0ZXJuUHJvcGVydGllczoNCj4g
PiA+Pj4gICAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjQwMC1zaWxpY29uLWlkDQo+ID4gPj4+
ICAgICAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI1MDAtc2lsaWNvbi1pZA0KPiA+ID4+PiAgICAg
ICAgICAgICAgICAtIGFzcGVlZCxhc3QyNjAwLXNpbGljb24taWQNCj4gPiA+Pj4gKyAgICAgICAg
ICAgICAgLSBhc3BlZWQsYXN0MjcwMC1zaWxpY29uLWlkDQo+ID4gPj4+ICAgICAgICAgICAgLSBj
b25zdDogYXNwZWVkLHNpbGljb24taWQNCj4gPiA+Pj4NCj4gPiA+Pj4gICAgICAgIHJlZzoNCj4g
PiA+Pj4gQEAgLTExNSw0ICsxMjIsMjQgQEAgZXhhbXBsZXM6DQo+ID4gPj4+ICAgICAgICAgICAg
ICByZWcgPSA8MHg3YyAweDQ+LCA8MHgxNTAgMHg4PjsNCj4gPiA+Pj4gICAgICAgICAgfTsNCj4g
PiA+Pj4gICAgICB9Ow0KPiA+ID4+PiArICAtIHwNCj4gPiA+Pj4gKyAgICBzb2MwIHsNCj4gPiA+
Pj4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4gPj4+ICsgICAgICAgICNzaXpl
LWNlbGxzID0gPDI+Ow0KPiA+ID4+DQo+ID4gPj4gVGhhdCdzIHRoZSBzYW1lIGV4YW1wbGUgYXMg
cHJldmlvdXMsIHJpZ2h0PyBUaGUgZHJvcCwgbm8gbmVlZC4NCj4gPiA+DQo+ID4gPiBBU1QyNzAw
IGlzIDY0Yml0cyBhZGRyZXNzIG1vZGUgcGxhdGZvcm0sIHRoYXQgdGhlIHJlYXNvbi4NCj4gPiA+
IFNvIEkgYWRkIGV4YW1wbGUgZm9yIDY0Yml0cyBwbGF0Zm9ybSBkZXNjcmlwdCBpbiBkdHNpIEkg
aGF2ZSB0byBhZGQNCj4gPiA+IHNvYzAgdG8gYmUgYWRkcmVzcy1jZWxscyBhbmQgc2l6ZS1jZWxs
cyB0byBiZSA8Mj4gVGhlbiBJIGNhbiBkZWZpbmUNCj4gPiA+IHRoZSByZWdpc3RlciB0byBiZSA2
NGJpdHMgYWRkcmVzcyBhbmQgc2l6ZS4NCj4gPg0KPiA+IFRoYXQncyB0cml2aWFsLiBEcm9wLg0K
PiBEbyB5b3UgbWVhbiwgSSBkb27igJl0IG5lZWQgYWRkIGV4YW1wbGUgZm9yIGFzdDI3MDAtc2N1
MD8NCj4gDQo+IE9yIGRlbGV0ZSAjYWRkcmVzcy1jZWxscyA9IDwyPjsgICNzaXplLWNlbGxzID0g
PDI+OyBJZiBJIHJlbW92ZSBpdCB3aWxsIG1ha2UNCj4gZHRfYmluZGluZ19jaGVjayBmYWlsLg0K
PiA+DQpIZWxsbyBLcnp5c3p0b2YNCg0KVXNlIGR0X2JpbmRpbmdfY2hlY2ssIGl0IG5lZWQgI2Fk
ZHJlc3MtY2VsbHMgPSA8Mj47ICAjc2l6ZS1jZWxscyA9IDwyPiBmb3IgNjQgYml0IGFkZHJlc3Mg
ZGVzY3JpcHRpb24uDQpPciBJIGRvbid0IG5lZWQgZXhhbXBsZT8NCg0KPiA+ID4+DQo+ID4gPj4g
QmVzdCByZWdhcmRzLA0KPiA+ID4+IEtyenlzenRvZg0KPiA+ID4NCj4gPiA+ICoqKioqKioqKioq
KiogRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioqKg0KPiA+
ID4g5YWN6LKs6IGy5piOOg0KPiA+ID4g5pys5L+h5Lu2KOaIluWFtumZhOS7tinlj6/og73ljIXl
kKvmqZ/lr4bos4foqIrvvIzkuKblj5fms5Xlvovkv53orbfjgILlpoIg5Y+w56uv6Z2e5oyH5a6a
DQo+ID4g5LmL5pS25Lu26ICF77yM6KuL5Lul6Zu75a2Q6YO15Lu26YCa55+l5pys6Zu75a2Q6YO1
5Lu25LmL55m86YCB6ICFLCDkuKboq4vnq4vljbPliKrpmaTmnKzpm7sNCj4g5a2QDQo+ID4g6YO1
5Lu25Y+K5YW26ZmE5Lu25ZKM6Yq35q+A5omA5pyJ6KSH5Y2w5Lu244CC6Kyd6Kyd5oKo55qE5ZCI
5L2cIQ0KPiA+ID4NCj4gPiA+IERJU0NMQUlNRVI6DQo+ID4gPiBUaGlzIG1lc3NhZ2UgKGFuZCBh
bnkgYXR0YWNobWVudHMpIG1heSBjb250YWluIGxlZ2FsbHkgcHJpdmlsZWdlZA0KPiA+ID4gYW5k
L29yDQo+ID4gb3RoZXIgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5b3UgaGF2ZSByZWNl
aXZlZCBpdCBpbiBlcnJvciwNCj4gPiBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmVwbHkg
ZS1tYWlsIGFuZCBpbW1lZGlhdGVseSBkZWxldGUgdGhlDQo+ID4gZS1tYWlsIGFuZCBhbnkgYXR0
YWNobWVudHMgd2l0aG91dCBjb3B5aW5nIG9yIGRpc2Nsb3NpbmcgdGhlIGNvbnRlbnRzLg0KPiBU
aGFuayB5b3UuDQo+ID4NCj4gPiBNYXliZSBJIGFtIHRoZSBpbnRlbmRlZCByZWNpcGllbnQgb2Yg
eW91ciBtZXNzYWdlLCBtYXliZSBub3QuIEkgZG9uJ3QNCj4gPiB3YW50IHRvIGhhdmUgYW55IGxl
Z2FsIHF1ZXN0aW9ucyByZWdhcmRpbmcgdXBzdHJlYW0sIHB1YmxpYw0KPiA+IGNvbGxhYm9yYXRp
b24sIHRodXMgcHJvYmFibHkgSSBzaG91bGQganVzdCByZW1vdmUgeW91ciBtZXNzYWdlcy4NCj4g
Pg0KPiA+IFBsZWFzZSB0YWxrIHdpdGggeW91ciBJVCB0aGF0IHN1Y2ggZGlzY2xhaW1lcnMgaW4g
b3Blbi1zb3VyY2UgYXJlIG5vdA0KPiA+IGRlc2lyZWQgKGFuZCBtYXliZSBldmVuIGhhcm1mdWwp
Lg0KPiA+IElmIHlvdSBkbyBub3QgdW5kZXJzdGFuZCB3aHksIHBsZWFzZSBhbHNvIHNlZToNCj4g
PiBodHRwczovL3d3dy55b3V0dWJlLmNvbS9saXZlL2ZNZUg3d3FPd1hBP3NpPUdZN2lnZmJkYTZ2
bmpYbEomdD04MzUNCj4gPg0KPiA+IElmIHlvdSBuZWVkIHRvIGdvIGFyb3VuZCBjb21wYW55IFNN
VFAgc2VydmVyLCB0aGVuIGNvbnNpZGVyIHVzaW5nIGI0DQo+ID4gd2ViLXJlbGF5OiBodHRwczov
L2I0LmRvY3Mua2VybmVsLm9yZy9lbi9sYXRlc3QvY29udHJpYnV0b3Ivc2VuZC5odG1sDQo+ID4N
Cj4gPiBJIHdpbGwgbm90IHJlc3BvbmQgdG8gYW55IG90aGVyIGNvbmZpZGVudGlhbCBlbWFpbHMu
IFRoYXQncyB0aGUgbGFzdCBvbmUgeW91DQo+IGdvdC4NCj4gPg0KPiA+IFRvIGJlIGNsZWFyOiBh
bGwgbWVzc2FnZXMgZnJvbSB5b3VyIGNvbXBhbnkgd2lsbCBiZSBtYWRlIHB1Ymxpc2hlZC4gQnkN
Cj4gPiByZXNwb25kaW5nIHRvIHRoaXMgZW1haWwgeW91IGFncmVlIHRoYXQgYWxsIGNvbW11bmlj
YXRpb25zIGZyb20geW91DQo+ID4gYW5kL29yIHlvdXIgY29tcGFueSBpcyBtYWRlIHB1YmxpYy4N
Cg0KU29ycnksIEkgaGF2ZSByZXF1ZXN0IElUIHJlbW92ZSBpdC4NCj4gPg0KPiA+IEJlc3QgcmVn
YXJkcywNCj4gPiBLcnp5c3p0b2YNCj4gDQo=

