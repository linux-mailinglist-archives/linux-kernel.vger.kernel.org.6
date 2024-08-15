Return-Path: <linux-kernel+bounces-287427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAA495279D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C7628265C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAA36FBF;
	Thu, 15 Aug 2024 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="EZuGT9M8"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2113.outbound.protection.outlook.com [40.107.117.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D80910FF;
	Thu, 15 Aug 2024 01:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723686242; cv=fail; b=R76nslE1GvHofdPpPVtuGhxXXosNFDvz5pJNyhLnlEyd685cOkzVbNXdkZUiMfzdw8ICdgni4t+jkhjftamLQySNMiMVZ9Zk9sCQfdQL4m2bFghHxW0g2NY8zu9KVSM1DfDkPlLHHKa7ZMtIvD64mOq1w2YWEcf07Y5Y38eFwf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723686242; c=relaxed/simple;
	bh=Fs8n9zggqp9TYCM22hPh1Z612Um01av2ZvqOYjpkw9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EtejlOwAvdHOu0jvclpyrNZ7c6fhIbBgn4nwNPUx49LEZeDfSmDWV2P/B2NatU9LPQJNvvwp8mD6MegUgGyd0Z57bJSRgMiJGIS0ru2aXbLFGX/OnL/N5JQOV9R2y8T9tQpbHi1qw/jnrMv3lZDJoMJRBQstYL+t97nlSSmGNqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=EZuGT9M8; arc=fail smtp.client-ip=40.107.117.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfTrxzYWvT1TlNg0VfO6SV9HVJ6dO4SoW0Cd1qSsvWRQt5VwDf8SpCLtmk9u4mPeu+ickZYqnb7+XYWybnJCD0dfV57htuJlFCENuyQsqKesT21Gd+tiB4r9f5jpvmJQu0AFN04nBJzrRvNfeZzxQAgSL8LjW1P85HHV8jel1udo87Rc9fFoxuI8iCpmXzpeyGuMrLw0m30IMGqNfEqGdtQquW5SzGP2GIkagO2hvJ/ywXxRMtUCUKgYs9dYsG+M1Z8NX3TFcDi/DQfPgPjrIXZMkToSzYKQg1pxh1HpQ/+bHigiWP1eBovnABbobtxeukxNKkcfddUKrGbYBO6JsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs8n9zggqp9TYCM22hPh1Z612Um01av2ZvqOYjpkw9M=;
 b=PNsuR1keMtuhKqi4fxJiR15OFNviUq1DgKlV5+EUlNsozay15WlT0bFbvU4lkQUB0ll6m72L+KsH8Bo8bs+R/lBPcF0HFJTjHLhvK/5Gg+t7DTHf+mCHMAmn0VSf7LWf9G6nGVby7/GdrCQzIiTU7SuMOdWGXlbUVxDi6k7FDOOU3VTxAD48g7i1AyymUOHxHwTEn4fELaxxABhRVSlN+zY+/MOU+0sIDyXnRlKi6hASlN6WeL4bS61xFSw0S0+b/d2/BFQI4Bk3anMxJWDr0v3dtwGnMoKVjLfg4ozhM+JyeIlhRfE5RGCumCSKc2OGR94jvjfxtd2GqHbfMbk95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs8n9zggqp9TYCM22hPh1Z612Um01av2ZvqOYjpkw9M=;
 b=EZuGT9M8EoaIhYR3M3Z0CfnnpiywuRaIdcAuqljyEhngi2HB8aIRghfqwACFsNaS7Llqb9I/eneTPvbsXIWYgKdE6XXTOQUq1Z9H2G3Rz9x9Gx7nzV9x4EWoZPdVdvZGEhDwHDmbiMUcKIZoXhZyOTJjrIZTKafqg807MobtLIj96t+RhmY6rOp1F2FwhlUrQeFYBwhzDdm3pxqPdpB7NF1+usffbvlq+uh5qepv5AqJOzMmecG9yW8A//KlUMtI25wFUkYYlWWUjiS3/MqxG3mdDMaXAMRlL8ay9Xv06iW9piFXcG/WFvuoyV5iibT3LmaVKVYxTDushkEYEYtwrg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEZPR06MB6597.apcprd06.prod.outlook.com (2603:1096:101:18a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 01:43:47 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 01:43:47 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring
	<robh@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Topic: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Index:
 AQHa6Wjwpmm6AqTUmky9VcIbkjW1JLIdJMiAgAFHtRCAAAQ8gIAAARxAgAclgACAAL3qcIABK1kAgAAVdEA=
Date: Thu, 15 Aug 2024 01:43:47 +0000
Message-ID:
 <OS8PR06MB754121818B9431941C18E09DF2802@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
	 <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
	 <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
	 <OS8PR06MB75416FAD2A1A16E7BE2D255DF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <10809e91-31be-4110-86c1-1e1ccb05b664@kernel.org>
	 <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <20240813191454.GA1570645-robh@kernel.org>
	 <OS8PR06MB7541BB03AEE90B090AB990B3F2872@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <7e1dc98e0f69a095a8f7725b742df3c8d8436a67.camel@codeconstruct.com.au>
In-Reply-To:
 <7e1dc98e0f69a095a8f7725b742df3c8d8436a67.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEZPR06MB6597:EE_
x-ms-office365-filtering-correlation-id: 6439fea9-16e8-41a3-afdf-08dcbccbb483
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2R5alFWTFFBWitIUEtFVFlqYWJVYWlYSlJYTG04R0hYMW1tR3EzWSt5cWZz?=
 =?utf-8?B?WmNXbEU3WENVRGx0blV5QUx3RTJZcnFqWDBwNWFGUUFFa2Fwbm1SMDh2Rkxm?=
 =?utf-8?B?TDgyeFA5Wk1SYjRhWTNQWHBaS2JqSlhTL0RyOUduRVFyaEd6dDYxMlM5QTZu?=
 =?utf-8?B?WlFXNjA0OXhzU2ZNK0VKeU9NTlpSZUh4dWpPWkhraGtKK09xb05xSG9oN0Ix?=
 =?utf-8?B?eWw3Z2daWE5ONlNTRzVVcm5MRlZCVW5XelVlYWR5RHZ2SWlLOTE4RjJOalZI?=
 =?utf-8?B?U3hDR1cyR0NTaUdSTjZVUEUrY3JJRURwSXM4aWJ5K0FFV1pGSXY2QlAxN1Vs?=
 =?utf-8?B?eGdXOWhBL0ZxSlVKbFBhNnlxNWIyRDVOZDBaQkhCSjczOGl6TC9EbG1xcGx3?=
 =?utf-8?B?V0cvQmRkbTgyZXVQeVdqdGdvV1Uvem5XSnlzc05wb08ydTRQNk5mUDNtY0pl?=
 =?utf-8?B?d2ljZTFMelhNc3plQ2N2V2p3NHo0TVphdjNSV1FoVWg1QnFrZFMwbnFaT2tS?=
 =?utf-8?B?b3FnWS9oVkRUcE9NUmRFTjJMMDFjTzZuUlIwd2phcmhXdVNUZThReDBIY1JZ?=
 =?utf-8?B?WGNPbTJLTFlWYWNCS3FWdVNUQUFRemYyWnl3YjYyUTZabmY2OGUrMXRjcHpR?=
 =?utf-8?B?SkRscmg2NkxmUkZsa29jVkF2bk5uakZRRWEyZjIwbER2ZmtqSlVodjFWelRV?=
 =?utf-8?B?aDF0WG1QWktqSFd1ZFhCcmg5OE9aVDJOem1XTUJBNHJlei9UMSt2VlRoWmJV?=
 =?utf-8?B?VnZOWFVOWlJMS211bjd0K21FbXdHMDh3K3kyS2JneVhPbEt1YVlRNm9mckJ1?=
 =?utf-8?B?NncyS3ZqdVNrbmFGdE16VDJtcU01OVpEZENiZGVLQkdrbFFmenVPTTdta3lm?=
 =?utf-8?B?eVJDdWlZQmVWMHUxL3RBNnBkUUZkS0JOUGMvMWdaMjlDakZXSDVabVEyMHMx?=
 =?utf-8?B?dkE5LzlqZ1k0YWN2SytvK01DNDZVa2pTQXRuK292Q3BNRjQ3M0xZZHlaRlF0?=
 =?utf-8?B?NHhVY0ZoaWUvMDU2c2hvMG5EV3FOTlQyMGFtb2V0SmVlV0llR0NqZTUyVUpW?=
 =?utf-8?B?bWhRcGhqcVViR0NPYnY0UHhocEZBSitLdnY2dy9hYzlsWmZ0eU1XaXNWaUov?=
 =?utf-8?B?bzBTaXA5Yko0Sk9mTGd4ZFFreTVmcGlVSnloVXpjUGZjN20rbWxrbDZaaGhN?=
 =?utf-8?B?U2lEZXhsb2tWUnhVbi9saXlra2NSTkhMQ04yTU9FYk0wTWRQMDBNSm1mRXJY?=
 =?utf-8?B?ZEo2RWF2ZGZOd3FZS3dEWU1scXRLQklEVHB0c0xIUXBuRUN1WG85UTk4YTR5?=
 =?utf-8?B?QzIyUGRPQTNBTkoxcEdTTTZ5SXZURUU3NG0vUTFTdnJTdFJwODVHYy9Cb0F2?=
 =?utf-8?B?d1hKbVBkaUpvZEd0T08zeGQ4MDIrcldRZVl0VkJqTkZNMVRvWTFPUCtWTDJt?=
 =?utf-8?B?b0g5U1pMbGdJcXF4UzlEM2FlZXVvM2E3T09OMTdXc2gyT201aCtUNXFZc3pz?=
 =?utf-8?B?cElleVkwU0tnaE4raWxHUEFaTGc0bktXRHgrQUlPOVR4Z1JPTnh4Ty9LOWdM?=
 =?utf-8?B?Y2QwMG1nL1ByR1UwL3A5Zmd2VXdEUDF5bFEvbnA5MFdiYVE1YWVCUUJsaFk3?=
 =?utf-8?B?dWFDM1NPWlFLNEdaUGpjV2Z0V0dCRFFlOWpxeWl0VFgyWDc2QVdGV3JSeXFO?=
 =?utf-8?B?U0JlbGhKNEllSDBwZE9UZGl4MmJhbDBIN1JHaTU5cHJDSlJzVjExaFEwZTNr?=
 =?utf-8?B?Z2szQ1hscWJ3aGdVNnA4UDgwcWxnN0FrSTNDU0ZRRTFzN011bHFnblpMWTY5?=
 =?utf-8?B?OEhPejVEQnNpMHlEdnZNcExNZzlGbXVBOEl3V2ZCL1BIL0lHSkFQNVNSdEpt?=
 =?utf-8?B?Y3BLR3ZvWWZlTFNScW90Y0ZYS1NnVk5TK3AydERJVzNTaWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2tGc3JqWFVUdGxpWHJBSERiRGVkdENPTHRzS00zejVBMjZGazZwZjBsTEd4?=
 =?utf-8?B?U1FVZGYzc1Y3WE9DdWlTcFNwbXZ6d0o5VTE3bHE5bXF6ZGZ6djlGSXNPd283?=
 =?utf-8?B?M2ZLVUcxMkRmZXJwdjQ4YThyaFNjdkdvaEIwckFyWEdQdlYybE1WNHBUbFRT?=
 =?utf-8?B?RGZ2N1VXRmphTU1KaFFLUDFsaUxoV3R6aWRGeTdEYU8vU05jWVdKNFlkcDJl?=
 =?utf-8?B?d0JNWFdIalNsc3pwVHQ1Tmh2clpWM1E4RzVHN1g3Vy9NbW5ZZGlNeUpxM3Zu?=
 =?utf-8?B?L1BnY0lsRlhqSkc1ZTBmTHFyQ1BoOVY2QkJIUlc1MEFZZUJwRCtXdVgzWG9G?=
 =?utf-8?B?S1J3d1JQcENva09iT0NjL0VKZ3o0R0VkdG1XMHFTQlg3QmdmSSsyWWxnOWNu?=
 =?utf-8?B?N1p6emlPazc0SGxmVHh3Q1U0MDN0bk1nZjFkZ2ZwY2lvcGRHUDhRdU8zbXhr?=
 =?utf-8?B?azFFS1hjcm1Hd0MwS2R6WnpNNWxkZUdOMVV0SXRWZnMwYjlFNi9BRmVGbWpy?=
 =?utf-8?B?d2lBWUlsemxaY3BZcmN4VjdyTWZ0MjBjTzdXSjBKK29zUVE4cExubERMTlJX?=
 =?utf-8?B?aG1Xb3RkWnVRNDRGU0ZMQnVDZDBOR3prQkx3RVk5RnlIVDRUNDAxQTJoanNo?=
 =?utf-8?B?b0JCTW5vdTdhcDFGUmtPTjFiMmllK2JOdTltaUhPTkUxUjU4RG5BVml1Ym5l?=
 =?utf-8?B?cDlGQWJjSEdwWFgvVTJRNEVIM0I2Zm9GZHcyYVpraUg5Ynk0ZjdYdWdYc25J?=
 =?utf-8?B?cStBWUlMZW1RNWVTOFlEZFFLYStrUTlMMzBtclc1bkd5bEprU1ROQUhYN3pB?=
 =?utf-8?B?ZHhQbVEyUE9FL1AraGhNQ2NqRUlUczZ1b1hBRFROTityS1hzdzBZWmR4NGxY?=
 =?utf-8?B?Q2Jmd3hyT0k3V0lhcHVnZERsZ0dTS0g2bGcxbFQzQWUyY0xIQUd2b3prNlV4?=
 =?utf-8?B?Q2ZCaldJYStvZDF5dHRDblBVT0lpTWR0Y244SVVEMzR5OXNNbkVjT0FKSDlX?=
 =?utf-8?B?cXRvUWs5TGdaWjQ1TGxuRU5IbE11OE5oNmF0S1FOVk5WOWJIRVRFdVBFMGFx?=
 =?utf-8?B?bGFtV2RMSGM4OHY4SXJQU2w5RnJlTHFXNjE0WS8rK2xDN1N0OERtc0VWSEEr?=
 =?utf-8?B?Q1JOM0M2UkthcktSYXkzQXU2c1E4OFV6Zit3bGFmL2ZVcmR2eTA4WUtKSjdF?=
 =?utf-8?B?ZFhUN1BxQ1RqQXQrSFQ3N0hJODNBSWc3SEE3ZTlwcWVjd1luZkFkbXNxeFpM?=
 =?utf-8?B?WDlJMUNma1BQaEh6Lys5VUs3UzlteHZPVE9XTVF5THE5Y3ZuemlzQjBibDE1?=
 =?utf-8?B?cEhYaHVISTZTbFpHMnFCc3NFbjRIcms5c0tiaW1GdUluVzJud0src2ZkNGdz?=
 =?utf-8?B?WWl6Ulk4QUpHQTkxZGt0UG11WldUYm1BN0RjSERwNmhPN1h1MU4xUnAwMnlL?=
 =?utf-8?B?M0ptUlVNVW1YajB0V08zdE1xK3EvbWpXM0ppakZIQ05tTW1PYlZVdC9HM2lz?=
 =?utf-8?B?SEU3c2VwbTQrTmdsMko4SUJOZldsVTcrckF2UTRVYjV4UGtGeUtYTUZWdW5G?=
 =?utf-8?B?Z0EvTVIzanh6YmFlVGpLb21BbUxpTWJ1U0JKdUxCMXVGck5vbGZFS0UvbEpX?=
 =?utf-8?B?OXBqc290amprZlV4djRqNXJFaXVDU2tYMiszektIWGJ6SmZIZFlFZ0JLcDZi?=
 =?utf-8?B?U0JhcEdKbWt2QVVtVXdXMzNPamlqZGk3L3o1WjlXUkpiMCtmZUJZWDVNQ3cr?=
 =?utf-8?B?bkU4Uzl4S2tJTnRLSnhXUlNNYXFPUXlTY3kzOTBMZm0zRjlGd0JJL0F6b2VY?=
 =?utf-8?B?SVFmQmdLckMxTnVEekxDUUdwUGpkNHYxb3Z0TUNscmZ6YmYzd045c0VVSklO?=
 =?utf-8?B?RmpCZXlBNVh1VzRLNlE0L0taZkw3RGhFbEdrWUtoZmRhRitHcmExc2h5S3Zn?=
 =?utf-8?B?cnU0NU9JOFRVUUdqYUM2VlNjaU9jMWJ5Q0ZKSVNkbkI5NzJqNnJsYm5McEJZ?=
 =?utf-8?B?ZkU4bURpenBWRHRDbEdFbE1PSVdSM2hhWlFkS0pUSDNQdEpFZWFpSUU3bm45?=
 =?utf-8?B?Ym53QlF4bXRXeThSeXIxRFI2SVdKYXR1b2JyMGtDaHZBVHp2cWxIYmxoQTIx?=
 =?utf-8?Q?79tCwfQiaRXyWx1EQnmW6/oRa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6439fea9-16e8-41a3-afdf-08dcbccbb483
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 01:43:47.2473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSedeRBDUZ9j8QU0BzZy1HEktsHWF0wv3l3hgdKTx8QXKRfG4TxxR/+v2PWL0A4CeD4yDkbWfWFIlxuwY0L2rcs3EN1qAeXa/yMA60pfr+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6597

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkOiBzdXBw
b3J0IGZvciBBU1QyNzAwDQo+IA0KPiBPbiBXZWQsIDIwMjQtMDgtMTQgYXQgMDY6MzUgKzAwMDAs
IFJ5YW4gQ2hlbiB3cm90ZToNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBkdC1iaW5k
aW5nczogbWZkOiBhc3BlZWQ6IHN1cHBvcnQgZm9yDQo+ID4gPiBBU1QyNzAwDQo+ID4gPg0KPiA+
ID4gT24gRnJpLCBBdWcgMDksIDIwMjQgYXQgMDY6MTA6MjJBTSArMDAwMCwgUnlhbiBDaGVuIHdy
b3RlOg0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBkdC1iaW5kaW5nczogbWZk
OiBhc3BlZWQ6IHN1cHBvcnQgZm9yDQo+ID4gPiA+ID4gQVNUMjcwMA0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gT24gMDkvMDgvMjAyNCAwNzo1NSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+ID4gPiA+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkOiBzdXBw
b3J0DQo+ID4gPiA+ID4gPiA+IGZvcg0KPiA+ID4gPiA+ID4gPiBBU1QyNzAwDQo+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+IE9uIDA4LzA4LzIwMjQgMDk6NTksIFJ5YW4gQ2hlbiB3cm90ZToN
Cj4gPiA+ID4gPiA+ID4gPiBBZGQgY29tcGF0aWJsZSBzdXBwb3J0IGZvciBBU1QyNzAwIGNsaywg
cmVzZXQsIHBpbmN0cmwsDQo+ID4gPiA+ID4gPiA+ID4gc2lsaWNvbi1pZCBhbmQgZXhhbXBsZSBm
b3IgQVNUMjcwMCBzY3UuDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiA+ID4gPiA+
ID4gPiAtLS0NCj4gPiA+ID4gPiA+ID4gPiDCoC4uLi9iaW5kaW5ncy9tZmQvYXNwZWVkLGFzdDJ4
MDAtc2N1LnlhbWwgICAgICB8IDMxDQo+ID4gPiA+ID4gPiA+ICsrKysrKysrKysrKysrKysrLS0N
Cj4gPiA+ID4gPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdA0K
PiA+ID4gPiA+ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9h
c3BlZWQsYXN0MngwMC0NCj4gPiA+ID4gPiA+ID4gPiBzY3UueWFtbA0KPiA+ID4gPiA+ID4gPiA+
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MngwMC0N
Cj4gPiA+ID4gPiA+ID4gPiBzY3UueWFtbA0KPiA+ID4gPiA+ID4gPiA+IGluZGV4IDg2ZWU2OWMw
ZjQ1Yi4uYzA5NjVmMDhhZThjIDEwMDY0NA0KPiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+
ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0
MngwMC0NCj4gPiA+ID4gPiA+ID4gPiBzY3UueWFtbA0KPiA+ID4gPiA+ID4gPiA+ICsrKw0KPiA+
ID4gPiA+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3Bl
ZWQsYXN0MngwMC0NCj4gPiA+ID4gPiA+ID4gPiBzY3UueQ0KPiA+ID4gPiA+ID4gPiA+ICsrKyBh
bWwNCj4gPiA+ID4gPiA+ID4gPiBAQCAtMjEsNiArMjEsOCBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4g
PiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAtIGFzcGVlZCxhc3QyNDAwLXNjdQ0KPiA+
ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAtIGFzcGVlZCxhc3QyNTAwLXNjdQ0K
PiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAtIGFzcGVlZCxhc3QyNjAwLXNj
dQ0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgLSBhc3BlZWQsYXN0MjcwMC1zY3UwDQo+ID4g
PiA+ID4gPiA+ID4gKyAgICAgICAgICAtIGFzcGVlZCxhc3QyNzAwLXNjdTENCj4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gV2hhdCBhcmUgdGhlIGRpZmZlcmVuY2VzIGJldHdlZW4gdGhlc2Ug
dHdvPw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoZSBuZXh0IFtQQVRDSCA0LzRdIGlzIHNj
dSBkcml2ZXIgdGhhdCBpbmNsdWRlIGFzdDI3MDAtc2N1MA0KPiA+ID4gPiA+ID4gYW5kDQo+ID4g
PiA+ID4gPiBhc3QyNzAwLXNjdTEgQ0xLX09GX0RFQ0xBUkVfRFJJVkVSKGFzdDI3MDBfc29jMCwN
Cj4gPiA+ID4gPiA+ICJhc3BlZWQsYXN0MjcwMC1zY3UwIiwgYXN0MjcwMF9zb2MwX2Nsa19pbml0
KTsNCj4gPiA+ID4gPiA+IENMS19PRl9ERUNMQVJFX0RSSVZFUihhc3QyNzAwX3NvYzEsICJhc3Bl
ZWQsYXN0MjcwMC1zY3UxIiwNCj4gPiA+ID4gPiA+IGFzdDI3MDBfc29jMV9jbGtfaW5pdCk7DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBXaGF0IGFyZSBoYXJkd2FyZSBkaWZmZXJlbmNlcz8gRW50aXJl
bHkgZGlmZmVyZW50IGRldmljZXM/DQo+ID4gPiA+DQo+ID4gPiA+IEFTVDI3MDAgaGF2ZSB0d28g
c29jIGRpZSBjb25uZWN0ZWQgZWFjaCBvdGhlci4NCj4gPiA+ID4gRWFjaCBzb2MgZGllIGhhdmUg
aXQgb3duIHNjdSwgc28gdGhlIG5hbWluZyBpcyBhc3QyNzAwLXNjdTAgZm9yDQo+ID4gPiA+IHNv
YzAsDQo+ID4gPiBhbm90aGVyIGlzIGFzdDI3MDAtc2N1MSBmb3Igc29jMS4NCj4gPiA+DQo+ID4g
PiBEaWRuJ3QgSSBzZWUgaW4gYW5vdGhlciBwYXRjaCBvbmUgZGllIGlzIGNwdSBhbmQgb25lIGlz
IGlvPyBVc2UNCj4gPiA+IHRob3NlIGluIHRoZSBjb21wYXRpYmxlIHJhdGhlciB0aGFuIDAgYW5k
IDEgaWYgc28uDQo+ID4gPg0KPiA+IFNvcnJ5LCBJIHdhbnQgdG8gYWxpZ24gd2l0aCBvdXIgZGF0
YXNoZWV0IGRlc2NyaXB0aW9uLg0KPiA+IEl0IHdpbGwgYnV0IHNjdTAgYW5kIHNjdTEgcmVnaXN0
ZXIgc2V0dGluZy4NCj4gDQo+IENhbiB3ZSBkb2N1bWVudCB0aGF0IHJlbGF0aW9uc2hpcCBpbiB0
aGUgYmluZGluZz8gUm9iJ3Mgc3VnZ2VzdGlvbiBzZWVtcw0KPiBtb3JlIGRlc2NyaXB0aXZlLg0K
SGVsbG8sDQoJRG8geW91IHdhbnQgbWUgZG9jdW1lbnQgaXQgaW4geWFtbCBmaWxlIG9yIGp1c3Qg
aW4gY29tbWl0IG1lc3NhZ2U/DQo=

