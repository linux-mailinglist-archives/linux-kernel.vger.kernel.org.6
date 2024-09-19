Return-Path: <linux-kernel+bounces-333119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8CD97C41F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6985C1F225A4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A91017B508;
	Thu, 19 Sep 2024 06:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="VC73PRTn"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021087.outbound.protection.outlook.com [52.101.129.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B017ADE1;
	Thu, 19 Sep 2024 06:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726725940; cv=fail; b=f0n3ERHPf0Sh5I/gli7xmN98emCnQc/hf2ZM1j8J8jreQuve7vOhA9BXUVJieJjnClp+E7SM7oV5Kv59eYWa/fUyNEG2O4omb2eIbKQpe9acolbqeXpPQRLXRCRU8U4slTfRuhc3nIUne43CbMru10+4xLU7nfvkTy2V8HReOsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726725940; c=relaxed/simple;
	bh=QbyjLfvbKHj3oDHs2t7hNSVWqtevNQ2sPVQ/jsUkZSw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oA8HBgnTQmvFI5VG3CbJ5twiqF5OcV6laIS973m2CsMbcHuFqAmY+mUx/P448v2a8A6ZduC9HSeUkKQohtxNtT059Hz2hWjtQr/3GXqKNQmAQEEL7gwptS0iLFIoFXlMEjApQaFktcs3nkpivjiGrqAEPxIWTu5BEYlqcOahfQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=VC73PRTn; arc=fail smtp.client-ip=52.101.129.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SharRLjG3qhas53tZZr/gL0/RcLd4XCZ2p3xtejwBbC8sUSyTDSLTMpBNEQCovLi2ds5r1maDnE/NCC+dJDYYuorA+nxUzv3TFROdZPdHGwbJltTsgE+Svmq9lbtQE1gxzdq9p45HeYugBYsilRE8sIASezFvvAxDhPJ93dZP5QowrKL2rDhe9dJlKSM8BKMzeodywIORo9OkZEfd5EegvwyBxVqhiG60rKlS0lCzOF6tgb+b4JiKbTa7t8o7GBVkrIQ9OLmbVaX8zJslXhskGforR5zoHYosv2zwzi3xOX14gmsIM+xrsJLpvCcSgQ4Ovc4ovDyYmjDTR1UKz+LKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbyjLfvbKHj3oDHs2t7hNSVWqtevNQ2sPVQ/jsUkZSw=;
 b=Ga8AwVE8hNMkX6AxLjDfEUK+oW6ZLsMy1B9w3jBy7+dviOY/j2pv1BNG9kuawsEL06nGW7Dmc5OCDzzIrE3Jqs5SeSlm+wW+V75WPDahOw3mzaV+/hEIrsg3ClKQsMnmM+Z93mdkuaIzLvCUvnveDXCQ14IwX40zUlSxB+MsyaMKeR90Pk/9yBdN2b5rbKf2ggYYHV7Wa6V4I050eM3n3zg6B1rUApw1/jzdvcOM7Q9KPfEfqQB9d2gpfVQDXK60scmw51XmNgbfqXY2wIqmT+kTO4mFLp4GHdvKkoDNyE7B10dI0E3H0uVRarqyI9H6cCroHGrxk905drUGoI7jTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbyjLfvbKHj3oDHs2t7hNSVWqtevNQ2sPVQ/jsUkZSw=;
 b=VC73PRTnxdxGnKnl4T8hEI2cydonpF+BUGCutodSXF7eM93+chdaMkL+wYyjQ4mbcAPNmoMmBFvcpgn5E/9PVJtD+8cP9p0fnEy/BqjkbUWnArczu9ImCZjbLIgn0AIFa9dOtoYC6Qx1NtCf8htfHiNhXM5XKzZPWRIzbq/EttBYhSeeZ/wue8yC+0xI/+bTszy1rQdKxZODR8f68ulnD8PBXGi+lOwlmCe176/DLPL8XoK8ePHDz30vL8hjgvnOiCraI9hd3UnltZ4O8OmX7/zG7xexv27e7aV5YsLCEtGxJxyU5Dy5440F6hlb0dkcRZJqAxV7J/7jyzKuRFdRmQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SI2PR06MB5242.apcprd06.prod.outlook.com (2603:1096:4:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 06:05:34 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%4]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 06:05:34 +0000
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
Subject: RE: [PATCH v3 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Topic: [PATCH v3 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Index: AQHbCBhSCltx7mVaxk6lgtgjWxjd+LJaMKkAgARx6aA=
Date: Thu, 19 Sep 2024 06:05:34 +0000
Message-ID:
 <OS8PR06MB75416C23247B7AC64260C0AFF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-2-ryan_chen@aspeedtech.com>
 <9b356379-907c-4112-8e24-1810cfa40ef6@kernel.org>
In-Reply-To: <9b356379-907c-4112-8e24-1810cfa40ef6@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SI2PR06MB5242:EE_
x-ms-office365-filtering-correlation-id: 6b3ad535-9138-4517-1ffe-08dcd8711320
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?dERyZUFHV3VaYW5hRG10dTI2VGlsMS9ZM0JqLzcxemo4OGpnKy9HNk9mRGVx?=
 =?utf-8?B?dkp5WGVpeGh1WjFmSnB2a3ZaYmRtS25EQ1cvaGlVZ053bnhYUGgyVmg1ZUxn?=
 =?utf-8?B?b05jSUVoU1Q4cnNmekxUbUZMNHkzcEtpbmxPdE5NZXRDMXZmZjFrcVN3U2VN?=
 =?utf-8?B?dVM5d0VPTHNGNFM3TUxxUWJWblk5S2R2aDU4WHhRU0lVZmoyTnFGNDRXWFR2?=
 =?utf-8?B?QjFIUzFHT2pRK056cHhoQi9aNFA3Q2l1T3lCdU1mY05XN29zS2UrMjVWMFpl?=
 =?utf-8?B?b21GRWlqd28wejI0aDVBVytuOFN5RGtoalg1d2NpNmxJWHBEYjZTK1Jhd3Zi?=
 =?utf-8?B?Zng3bUxtelZmQmdqbFpMU1pRL3lFSThnWUM5VGxueXVsYWd0dDl3RVdrWDhh?=
 =?utf-8?B?YUs5T2pFT3JhNURIeGloMHJNWlVkZDUvOTA3V0FVamM1cFlEYjFrZEg3TTZt?=
 =?utf-8?B?WFFtNkg1T1RBRkcvS2oyOFVLUzFsTk03c0xuM3k2L0ZWejBTSndiRHUyaHha?=
 =?utf-8?B?bmhzV2RQUmRSbkd2MFhiQWJDanhMaGxzVUtycHJ0UURBaEpPWTBNMXRFT2hl?=
 =?utf-8?B?bDhOQlVkY2JaUVFDMzA4Mk52aE5Kc0F4bkgwYzVRZGFpd1AxUjRjaTlLNEVs?=
 =?utf-8?B?dWJlS0tCdDZmWFRFZnpyRGNpOCtQeHhlVzJuOEVGYk5ZTVMzVmlkbm5aV0xS?=
 =?utf-8?B?RWhDSmhsMVZjd3NNbmNBU0hhemFvY2RCN29OVTRTbVJqT3VKbVQwOUFGRW9C?=
 =?utf-8?B?dEZvTDFwNS9YaWJpTmVXRmU4VnhMdkxTODJsWjZ5MG5xOU5wOEtEOHlDL001?=
 =?utf-8?B?cWRzeEtKcGpEWGVsdS9yQzFhTlVFL3VaSjh0Y0NseERUOThxTEhCRXJISFpF?=
 =?utf-8?B?Snh6eEVFalRJR2luZ0FKNlNORnBmQ1U1REZEdDdPRFFGMFVqSUJtcGNiaWxS?=
 =?utf-8?B?Ty9YdGV5VG9SdS93Qk1TMEZoQTJaVUxBSE9hUFpxZ3hmTDJ0YzZ0ZkNtbURY?=
 =?utf-8?B?YlpaRjFNRGxseFhlTUpUREtXVUJEMHJEVStMUkJ6WnFXRGlHVGZKTkFNbTNC?=
 =?utf-8?B?elR5R0RvaXFnMjMxM1hhWkxXc1pQTVlxNjVETFFpOW8rR0FRMm1yTlBwR0tk?=
 =?utf-8?B?N3FEOUlUSk5VUjlvbDhWSk1wRXRHZGZVckpDZzh6eU0ycGV5Z3VtOVVzUkQ4?=
 =?utf-8?B?TFd6dmNhUXpLUXhFc3hpamlVb0RKcjFXR1lkclFOeXFJQ0pFc0U5aVAxUEpi?=
 =?utf-8?B?enNOdDdMT25MbjhRc1p0VnN1RnZ1bWlkdEFDYmVxUllSWWVVemlCalNxSytt?=
 =?utf-8?B?MHVTN0JvUGVEeXJINlVseEkzWUhtWUhHdDIwSXhXWC9hYmVOVG1mMmRCYUFz?=
 =?utf-8?B?Zk5JZFBEQm5EcEkvaThnRm1ISUJPWDc2azVrTlhZOGN3UDVpa2tOOWJyZUY5?=
 =?utf-8?B?dW41Qlc2bXNxSGIrWkVJK2JIYVVGYjVXY2ZXUjN6WWo3UTNlZENQQkZOazFr?=
 =?utf-8?B?WDJvbVlxcGRicEhIVDVOWk1ra0JrbUNhUUNMYVVZdld4WUJGc2xCWThwQm50?=
 =?utf-8?B?ODNrRGxUY01aNmNoMHkrdks1b25hNFgwaVVlOHhQMUp6UGVVWk1jNkJxNERB?=
 =?utf-8?B?NDhxS04xQ0xmb2I5ZWtxOEh1YndnZCtrUWJqTnV0YzdVRmZISjdXMVVFRS9M?=
 =?utf-8?B?OWNnZ1ZNUVNkR2lTcFdZby95cFdFV3oyc21zNVNNMjk5eVMvQUJXajRkT0V5?=
 =?utf-8?B?VHZEN3UvUGtEdGxkTERDQjVuekRmY2pBd2lWNnpCU1FxSlN6REdSRiswb1NE?=
 =?utf-8?B?UDdQaGZxZ2xtdmMrVU5obUo4azZhN1RVRUFoUytaZEJNY3ZaZThCMjhtNDZH?=
 =?utf-8?Q?h93IyNGCNFkn0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDJhSXFIRGhPa2I1cUQ2TVBQaG5kZVcyWUc5Y0t4OXIvWXhYaWJrb1dPU3RG?=
 =?utf-8?B?TGFwN2FYVjlMaGM5dUQ2dzNKVmZYWUc5dzhtMDhLdXFSeFArY1Z1eTM4dDF5?=
 =?utf-8?B?M1grczBDMXc3UWhoTGtBV2xOM2EzbGZXVy9ucnpKZWl6SDcrMVhDeUxiZTBv?=
 =?utf-8?B?Z1Q1a2oxaFRiZmR4Vk40cktlYVZJSUZCSmRFaUJvZFdGSmsyMGNmRnRnZ2Yr?=
 =?utf-8?B?c2FLWHBpM20vK2xCcmc2cFZFVWVwOUdtdzhDQjdjTlhyRThtYldpWFZrQ29s?=
 =?utf-8?B?WnA1aWhodEJtaFdubTF6MGRrNUt6VGlWTnFKSkRSWHR6d3I5dEsyN0pRK2xH?=
 =?utf-8?B?V003akRYdW5rbWI3VlppR3FYbFM2Y0RpNUpOT3RQR0VFTHBqZG1ub1B1c2NJ?=
 =?utf-8?B?K3Nyc3VRMkZkTmhtbExxWGZrMnF0Z1ZDSzUyeDA5RkR2OE1UaytuYWt6WG9n?=
 =?utf-8?B?eUVNRzhneHlnelE5a2hmQXV2Q21oSUNxSkY1OWNBZFVqNmxXemFkN25Dd01n?=
 =?utf-8?B?M1ZrcjlubXd4cm5jdFpUR0ZSL2kzZXhSY0czVEo5OUJHNkh4ek5NZ0NGR2Q0?=
 =?utf-8?B?YVN1QzhiYlBlSGtQUE9KTVduNXMwYXVOSjI5V1EvRnkxV0ViNm1BN2huaVFR?=
 =?utf-8?B?ZER4ZEZ2K2wxOXdwWjhoelBESWwwZHNyRkVwcjFaRkRiNkk2RWdSTDZVUHgw?=
 =?utf-8?B?b2o0U0E5UWVJU2N0UWhBdEthWmVlTHhEdjZUdThVVmM1MmNrL3U3Z2VHWG5X?=
 =?utf-8?B?a1h5cTZEMUFpM0JJYXNmQzNTcGIyWTVHeGJ6R0h3aGxWSXZEWGpqS2twbHlL?=
 =?utf-8?B?cVhzOHYvRGxQdWRDUUE1TXVoaWhSWnV2RzlQdk5GVnVPYUhUWnlnSDJWOWRI?=
 =?utf-8?B?bzN0N3ZzQ3VMVmYvY1ptWmtEQmZhUC81VnppNktBbnR4dUZ4bVJCRlVyQytF?=
 =?utf-8?B?WkhSczh1Qk1hNll5UUNJS3JpUDh5R3VQUVdmUk5BZGsxRzhKVSt6RG80V1cr?=
 =?utf-8?B?cVpiRkRGMlZtUEk4YWo0d0dIa2FMU3RRWmo1dUFycTBXdlFZbFNhQnY2aVBo?=
 =?utf-8?B?MW1WOGVRbTREeERWK2dTQ21kQjhHcmEydndmSVVaYitzMW9tbFJ0aFNJWlh5?=
 =?utf-8?B?Nk9zNkRaQk0vUGhNWTVOQWMyZ0FGeWhyYkl1YW03cDNmR1NVeGtJMkVVcFZa?=
 =?utf-8?B?Rk5nNGdtMy83Snpqbnk3RHI4UEZhRE1ic1JPZ0JEcFhocjBHYld6Q2ZtMk1z?=
 =?utf-8?B?ZzNCYzJ0U2RYRThrMHIzSXIwSlN4ZVpLeldkZ2Q2emlXNkR4VHhEQVdISDBs?=
 =?utf-8?B?SUN0RGpEUmo2K0dSUjRjQ2hTcE1McUJLYTVkbzJJVUhUdStGdmgvTlNDempt?=
 =?utf-8?B?RE9POTMwLzNLamY2TGhwUnB2TVFQd0orbllJSnp5YmFKVzFsTzB1bEFDcm5L?=
 =?utf-8?B?ZEtwQkVCR0wxWHJUcFVZRGdZc3hXTUV6LzBvVVZvazRQMTZUSi9aNnMvcW1H?=
 =?utf-8?B?Ymo0QUQ0azJ4VHV4b1ltOEEvVklGWDBHUFp2RVFxUmhJbTZiQU5zbjdpc1li?=
 =?utf-8?B?cy8xSEdMalFFaVR4YTJGbnd1WW4wYXdUUVR6U1k4bFBHcllkazVKbURtT1pi?=
 =?utf-8?B?MDA0UWxieEFJQms0emlSNDU0K1JZa2l2RVRQRTBhckpENDB2MWs5djRDcEdL?=
 =?utf-8?B?SDhGRTdUNjhCcHJ5SzB3bmpEbWQxYStOMUh3N0pWVVVIZ3BnalVnblhxV2lR?=
 =?utf-8?B?N3RMZVBpYmFyYndJSDJEUUU0VmVQMGVFaWdETDN0OGFjcU82UGNDdC8xRGQy?=
 =?utf-8?B?WXNFMHZ1ZldsTnlOQ1Z5WWEwZUZNSUxCbXE5Tk9zNitwYkg4dEU0c0RCai9o?=
 =?utf-8?B?UUUrSTZDSjBNSElMM1Bzam9ZSUhTSDQ3cEdLbVdoaWtWWnFXTkMranJKL2ZJ?=
 =?utf-8?B?Q0VuYkx5Rk1vZ3I0ZGlEU3BNMU9DQ1FCSFRoQ3lPelZyVUMrVW84eThqbmVZ?=
 =?utf-8?B?SENpcENaVU9yUXZCcjVlTWRqb2t6WXgxSkJlcWZ3ZWVIRlZhclprbEphVUt0?=
 =?utf-8?B?cGk5NGhTelgybEFjQ2dYZytlV3g2OXBTdHNpWE1HdmcxRFpmRlVPWlFpMGkw?=
 =?utf-8?Q?qRdxnFt7vghhcygd7wN597mhk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3ad535-9138-4517-1ffe-08dcd8711320
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 06:05:34.3343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFiJmRelATgOAeWSfPTIRofFDg/GhIsgSHxsEoPTOizW+90bXPopcneKk1vCXyvhNCGzFjGVAP5Y+Q9tJXL4tw/gALixOnU25G8yzZ+v02Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5242

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvNF0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkOiBz
dXBwb3J0IGZvciBBU1QyNzAwDQo+IA0KPiBPbiAxNi8wOS8yMDI0IDExOjEwLCBSeWFuIENoZW4g
d3JvdGU6DQo+ID4gQWRkIGNvbXBhdGlibGUgc3VwcG9ydCBmb3IgQVNUMjcwMCBjbGssIHJlc2V0
LCBwaW5jdHJsLCBzaWxpY29uLWlkIGZvciBBU1QyNzAwDQo+IHNjdS4NCj4gDQo+IFBsZWFzZSB3
cmFwIGNvbW1pdCBtZXNzYWdlIGFjY29yZGluZyB0byBMaW51eCBjb2Rpbmcgc3R5bGUgLyBzdWJt
aXNzaW9uDQo+IHByb2Nlc3MgKG5laXRoZXIgdG9vIGVhcmx5IG5vciBvdmVyIHRoZSBsaW1pdCk6
DQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjQtcmMxL3NvdXJjZS9Eb2N1
bWVudGF0aW9uL3Byb2Nlc3Mvc3ViDQo+IG1pdHRpbmctcGF0Y2hlcy5yc3QjTDU5Nw0KDQpXaWxs
IHVwZGF0ZSBpdC4NCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5f
Y2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWZkL2FzcGVlZCxhc3QyeDAwLXNjdS55YW1sIHwgMTMNCj4gPiArKysrKysrKysrKy0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21mZC9hc3BlZWQsYXN0MngwMC1zY3UueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MngwMC1zY3UueWFtbA0KPiA+IGluZGV4IDg2ZWU2
OWMwZjQ1Yi4uMTI3YTM1NzA1MWNkIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tZmQvYXNwZWVkLGFzdDJ4MDAtc2N1LnlhbWwNCj4gPiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FzcGVlZCxhc3QyeDAwLXNjdS55
YW1sDQo+ID4gQEAgLTksNiArOSw4IEBAIHRpdGxlOiBBc3BlZWQgU3lzdGVtIENvbnRyb2wgVW5p
dA0KPiA+ICBkZXNjcmlwdGlvbjoNCj4gPiAgICBUaGUgQXNwZWVkIFN5c3RlbSBDb250cm9sIFVu
aXQgbWFuYWdlcyB0aGUgZ2xvYmFsIGJlaGF2aW91ciBvZiB0aGUNCj4gU29DLA0KPiA+ICAgIGNv
bmZpZ3VyaW5nIGVsZW1lbnRzIHN1Y2ggYXMgY2xvY2tzLCBwaW5tdXgsIGFuZCByZXNldC4NCj4g
PiArICBJbiBBU1QyNzAwIFNPQyB3aGljaCBoYXMgdHdvIHNvYyBjb25uZWN0aW9uLCBlYWNoIHNv
YyBoYXZlIGl0cyBvd24NCj4gPiArIHNjdSAgcmVnaXN0ZXIgY29udHJvbCwgYXN0MjcwMC1zY3Uw
IGZvciBzb2MwLCBhc3QyNzAwLXNjdTEgZm9yIHNvYzEuDQo+ID4NCj4gPiAgbWFpbnRhaW5lcnM6
DQo+ID4gICAgLSBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KPiA+IEBAIC0yMSw2ICsy
Myw4IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAtIGFzcGVlZCxhc3QyNDAwLXNjdQ0K
PiA+ICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjUwMC1zY3UNCj4gPiAgICAgICAgICAgIC0gYXNw
ZWVkLGFzdDI2MDAtc2N1DQo+ID4gKyAgICAgICAgICAtIGFzcGVlZCxhc3QyNzAwLXNjdTANCj4g
PiArICAgICAgICAgIC0gYXNwZWVkLGFzdDI3MDAtc2N1MQ0KPiA+ICAgICAgICAtIGNvbnN0OiBz
eXNjb24NCj4gPiAgICAgICAgLSBjb25zdDogc2ltcGxlLW1mZA0KPiA+DQo+ID4gQEAgLTMwLDEw
ICszNCwxMiBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgIHJhbmdlczogdHJ1ZQ0KPiA+DQo+ID4gICAg
JyNhZGRyZXNzLWNlbGxzJzoNCj4gPiAtICAgIGNvbnN0OiAxDQo+ID4gKyAgICBtaW5pbXVtOiAx
DQo+ID4gKyAgICBtYXhpbXVtOiAyDQo+ID4NCj4gPiAgICAnI3NpemUtY2VsbHMnOg0KPiA+IC0g
ICAgY29uc3Q6IDENCj4gPiArICAgIG1pbmltdW06IDENCj4gPiArICAgIG1heGltdW06IDINCj4g
DQo+IFdoeSBkbyB0aGUgY2hpbGRyZW4gaGF2ZSA2NCBiaXQgYWRkcmVzc2luZz8NCg0KQVNUMjcw
MCBpcyA2NGJpdCBhZGRyZXNzLCBzbyBpdCBhbHNvLg0KSXQgaXMgY2hpbGRyZW4gZXhhbXBsZSBm
b3IgcGluY3RybC4NCg0KICAgICAgICAgICAgICAgIHN5c2NvbjE6IHN5c2NvbkAxNGMwMjAwMCB7
DQogICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNzAwLXNj
dTEiLCAic3lzY29uIiwgInNpbXBsZS1tZmQiOw0KICAgICAgICAgICAgICAgICAgICAgICAgcmVn
ID0gPDB4MCAweDE0YzAyMDAwIDB4MCAweDEwMDA+Ow0KICAgICAgICAgICAgICAgICAgICAgICAg
cmFuZ2VzID0gPDB4MCAweDAgMHgwIDB4MTRjMDIwMDAgMHgwIDB4MTAwMD47DQogICAgICAgICAg
ICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCiAgICAgICAgICAgICAgICAgICAg
ICAgICNzaXplLWNlbGxzID0gPDI+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgI2Nsb2NrLWNl
bGxzID0gPDE+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgI3Jlc2V0LWNlbGxzID0gPDE+Ow0K
DQogICAgICAgICAgICAgICAgICAgICAgICBwaW5jdHJsMTogcGluY3RybEA0MDAgew0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNzAwLXNv
YzEtcGluY3RybCI7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDAg
MHg0MDAgMHgwIDB4MTAwPjsNCiAgICAgICAgICAgICAgICAgICAgICAgIH07DQogICAgICAgICAg
ICAgICAgfTsNCj4gDQo+ID4NCj4gPiAgICAnI2Nsb2NrLWNlbGxzJzoNCj4gPiAgICAgIGNvbnN0
OiAxDQo+ID4gQEAgLTU2LDYgKzYyLDggQEAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gICAgICAg
ICAgICAgIC0gYXNwZWVkLGFzdDI0MDAtcGluY3RybA0KPiA+ICAgICAgICAgICAgICAtIGFzcGVl
ZCxhc3QyNTAwLXBpbmN0cmwNCj4gPiAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjYwMC1waW5j
dHJsDQo+ID4gKyAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI3MDAtc29jMC1waW5jdHJsDQo+ID4g
KyAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI3MDAtc29jMS1waW5jdHJsDQo+IA0KPiBBcmUgdGhl
c2UgZGV2aWNlcyBkaWZmZXJlbnQ/DQo+IA0KPiBXaGVyZSBpcyB0aGlzIGJpbmRpbmcgZG9jdW1l
bnRlZCAoZnVsbHkpPyBQcm92aWRlIGxpbmsgdG8gbG9yZSBwYXRjaCBpbiB0aGUNCj4gY2hhbmdl
bG9nLg0KDQpJIHdpbGwgcmVtb3ZlIGl0IGluIG5leHQgc3VibWl0LiANCkl0IHdpbGwgYWRkIGlu
IGFub3RoZXIgcGluY3RybCBzdWJtaXQgcGF0Y2guDQo+IA0KPiA+DQo+ID4gICAgICByZXF1aXJl
ZDoNCj4gPiAgICAgICAgLSBjb21wYXRpYmxlDQo+ID4gQEAgLTc2LDYgKzg0LDcgQEAgcGF0dGVy
blByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjQwMC1zaWxpY29u
LWlkDQo+ID4gICAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjUwMC1zaWxpY29uLWlkDQo+ID4g
ICAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjYwMC1zaWxpY29uLWlkDQo+ID4gKyAgICAgICAg
ICAgICAgLSBhc3BlZWQsYXN0MjcwMC1zaWxpY29uLWlkDQo+IA0KPiBUaGlzIG9uZSBpcyBmaW5l
Lg0KVGhhbmtzLg0KPiANCj4gPiAgICAgICAgICAgIC0gY29uc3Q6IGFzcGVlZCxzaWxpY29uLWlk
DQo+ID4NCj4gPiAgICAgICAgcmVnOg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cg0K

