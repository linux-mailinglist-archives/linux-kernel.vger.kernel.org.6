Return-Path: <linux-kernel+bounces-293135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DB9957B31
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322F7B2165E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602A017BD5;
	Tue, 20 Aug 2024 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="jsua9Pcd"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2106.outbound.protection.outlook.com [40.107.117.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086F17740;
	Tue, 20 Aug 2024 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118731; cv=fail; b=rFYJY9lb6IKxWKuP6A8CCUZ4Upd6zMGSRxYSENWZ5CRGURcaZxCLMDZWK1MHCx8OCpgcBQHMC2CNP9BeTw6axGtubs5UaoyyzWmyCszLQzjqtkxo6/jEIHQ6lJW25SKI3WP9A8gOkbe5OmWh2S5pZ0coDi8dk42Pmg/ONHXEzvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118731; c=relaxed/simple;
	bh=sI/QTJrnGaHFG7YJ6wyUmGt/chZFSycsFXgi052xsQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QULMHeTC/Y2Cu5O9Gcugi2MG8fsSTKLXEMyqJJqssT8cx6BUBM+W/BRjOH6bIRSwOz8BWZFwM0qgM7RtHHsCy9MpgmWgp/pQsXrl7apQ3ExAQupDw+gYDTz5lMQKUiKz5HRXm4/oZfcRy75Hv+m3BTEzOHC1dgB3AN6tC/6MNBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=jsua9Pcd; arc=fail smtp.client-ip=40.107.117.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2nr7cbC/rYsbaR1iG+BWEqpDVhBS9eTkFkJwGwvenSDMS0p4u3vJTqsQeF0rwS77OVkk3WOJ/Tf3dgrUSMVpn4hI5ksUzVfbC+vcEwbhCOshHIvRUSLEsYA7gYP8HYwuq+LIvDp3D9FQdOpCezDd+jMscQxTWOOspr1zSWaAXSNdDjusBlDWkHJUew5QZthAac3zSix3+H3084L2t9kIWKLZHcVcZAXdHA5Yzt1AoFTuYRTWKrY+LaKVYbm/45cXlc9f59ULC9VQ71rETZ4usYLz9+7whKzwI89s4MP0QBPU3nzROpDR0NIRUterLReLWECL4BvSEZU/Ccii19SdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI/QTJrnGaHFG7YJ6wyUmGt/chZFSycsFXgi052xsQ0=;
 b=X/g/q9L5fnvCwo2Wh3h5omkfWZkp807bRCW7ty4TMoLHPjFUdX+O7DCiQD+IpYi4GBrLo1DRQNNSQx+LvbGzyFED3tAjO1TAJimeciuKIbF9jkrY3gma+IevB+BqBrnD81sKtHEfHgv4R8vVGqy2FeP7w9EYs1cnabB107Hu/yhoetuaYIGSSgCgVWXaZ7DsFNFP4sVCnw8ZzOi2Lr0xOtpAPpn6+L6V9QJr/yk9GZzj5BVpskNLM99igQuU5jXHAR6+1yzqMjbp+I7nJJ7wP0JZBtP5uC0k+MOh8FBTjaUtvjRJHTq3IWUjPAWNGWzP8gHBy7LQkyIG0w68Kg97yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI/QTJrnGaHFG7YJ6wyUmGt/chZFSycsFXgi052xsQ0=;
 b=jsua9PcdE+jPhw2d96/rJP/4BSOMj+ZLzMae+030xw8kRtAxB+QJZ2Nqb4SQrqon6Z42vzoERvhEKJ0qpaCcu93X4PGgpIQ4hCPy2aNgDb3N8UCM+rOKHtBYf6TquAKabQUPHU0LqNMtP5xMpWNPJuwtUwHr1AumQA4DpxbroDzvaVVeA6aWNf4mgH6GE/z8wFULqB232UATeGS0w/QetGut7zOUjHJpUtKHJQK//2k8Oe/NaHnF9R+JWwHPw/J/9LvrHrPKjAz1dQIqTnlP2ID518gWM/uYd+L54bBDJkWIY3CirzV4U1gBDfQQMtUuuq9yJ7FgTpXWAxnFY8UAIg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYUPR06MB6271.apcprd06.prod.outlook.com (2603:1096:400:352::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 01:52:04 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 01:52:04 +0000
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
 AQHa6Wjwpmm6AqTUmky9VcIbkjW1JLIdJMiAgAFHtRCAAAQ8gIAAARxAgAclgACAAL3qcIABK1kAgAAVdECABl63wIABbTUAgAART1A=
Date: Tue, 20 Aug 2024 01:52:03 +0000
Message-ID:
 <OS8PR06MB754148E915F6E6014F490583F28D2@OS8PR06MB7541.apcprd06.prod.outlook.com>
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
In-Reply-To:
 <64d13efd3119429ed876ad7ea499cff62e100fb9.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYUPR06MB6271:EE_
x-ms-office365-filtering-correlation-id: 4bbad916-17a3-4eb2-d4f2-08dcc0bab0a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjczR2F4MDRqRGZRVVlMb2tsMlVINjlvZis5UzdPU0duOWk1RDlhUDljcWRq?=
 =?utf-8?B?RTFweHlkejBPZGVSd2NTbUVCVmNCTUQweTR0ZmF4aUZWcDQ5elRYZ3ZBZDQ3?=
 =?utf-8?B?THpLSUFHcEpOMzlLS0ZUejRIcUxWSDBjaFRMM1J2Q0lYUnhuZHF0L0dUODc4?=
 =?utf-8?B?ck5mNHNEQWFLeWFMd3JsM010Q0xXMkE2WjBGN3dBTnJQMUJQUVA2Ry9lMGhs?=
 =?utf-8?B?WU9nREF5QzRUNy9kZCtjOXg3NDA3YmhPRUE4K2lIVTVKSWNTYjJka004WmdS?=
 =?utf-8?B?QmIrYlR3V0N4MjhTU3JQUWdKSzU4YnRSTE5EVTB2RG8zcVJvVWplRDcyanNT?=
 =?utf-8?B?ejJCNFdDS3J1TVIzM3lKdEZEYkEzUVk3dkp2RzI4b2hFczhHSW0ycGgzczlQ?=
 =?utf-8?B?SEhmZlJpdWFsc3NhVW9BYnZscFAyWHMzZ3dOa1pRbXJrSmsyQlp5WnB4T3J1?=
 =?utf-8?B?TW5DL2lleHRlSFpKaFpkZmlLdTVYdEVXbENFdUZRNW9BSHdhbnRnU1lZcVpS?=
 =?utf-8?B?Z1Q3UkdyWlB0OS9kNWpOWTU5YjJyRDgxUnpjMTIxajd1d1F3SFFuVTluQVN4?=
 =?utf-8?B?UjZhandEMnMvQjdBRlZSc0FpQjAwekFpNENlVDJnMmt0SW5PbUYzR2taRzJa?=
 =?utf-8?B?L3B2K1lnNHkxUU5YbTNZQjM0R3pzbUlwWnkyZ0J1UHhXTEVaY3NTZnBUaUlv?=
 =?utf-8?B?a3pDcFcwT200cGhvUnY2enJpb0VPQW1NV2dicEpYSnNjcXVTMGczVjliakVT?=
 =?utf-8?B?alowRGh1SnpRV1A0dVR5c3V4TW1LSzlJSmtSRm91UVF1RnJiUDEvTzE0MHBM?=
 =?utf-8?B?ZGgxdENJcXgvSzhqMFk5cGwwSXhieEFRSm9VUDgzaWNxQW03SGxFZFBBL3VR?=
 =?utf-8?B?cXo0bi80UEcvbmpnMVdkSTE0YnpjWmVwNmR0clB5Z2J5UUFya3o1N25yRjB3?=
 =?utf-8?B?TG1sNk9oQzR1dDFhcGJhM0ZBeDU4RmgyaTMrZ215ZUhQV2s1RGdUMmJZQkRP?=
 =?utf-8?B?ekpnNXJsdktuMnpyY2IraC9WVGdJQTZxRkVGNk84WStOaVRMUXlXNFFmbTFy?=
 =?utf-8?B?MkRvcDFYTVc2M0lVU1A4ckJOeEJQeUJvRmthQlVsSW5SVStwNWdZNnJFNHM4?=
 =?utf-8?B?eW4vK3RjU2ptRVBURHVkNllJYllBeDlqU1JEVDY2YXRhRlJBZVRIeHFKUXVv?=
 =?utf-8?B?KzMzQlFWaXk5NGJpa3EyempIOWF0SmVDbTFhYWJXS0JjaEUzNmxTcjQ0bnhK?=
 =?utf-8?B?VENtWC9WTlRaS0UwY3pTdU1YOTA1Wml1WExXdjRaemhhMEFSdUZEQndIUnJ1?=
 =?utf-8?B?SHViQXBIYjlBWWNYMkdmYy9seGtFaDExYitoamhXelIyQWVTbWozV3p6MWdo?=
 =?utf-8?B?NXJMVjZUejlTNEdFOFZjZ1VwQzdwbmI1STFSaExQOW5sOUU2Qm1qcHpoTUpu?=
 =?utf-8?B?NzlqRmpHMi8waVpwSUNVVWI1RDZiL2x3eUVyWFNGQUlSMW5MRElqbytoZlVB?=
 =?utf-8?B?SkJNSS9RMnNyZERZMXpnS2tPeFRYMXZKWWlvRFdoeithYXFjNzJzbHEwK0pG?=
 =?utf-8?B?OHpBNXFCNnhJaFFITFFJU3BuVDhmc09kbjl0eUdxaDZ6WGI4Z0w0UVlGc0Jh?=
 =?utf-8?B?MXhiQ0w5Q3NzNHBaSHVIOGE4VVBXVzl0bU5EUGE2R21KMDdTL3VPaU82NHNx?=
 =?utf-8?B?TUNCYUJDU21ETC9OWDAzRmk2ZjZmekFJeVM4V3RWMSs0Qnc4alh6SGRNbnI3?=
 =?utf-8?B?OGRUL0NCc0NjMmNNS0lXTFlIa3pUbWpzS3lpa1M2cW1LQUExMCtIZlpvNWQ4?=
 =?utf-8?B?cFJVa2VsMjJpdlpEeGgraERPWTFtR1kxSmkrZnNnNEVQMnVaazJtTzJtN2Fn?=
 =?utf-8?B?Si9FYWlweklHa0lwVlhUcU95VEJmUkE0Tm5hR2lnektkSXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NU1jejFIOC9Td3JIK1VMeTI1ZisvVGJ5TStSdVhPNUl4bWMyNk5TZEFLNi9K?=
 =?utf-8?B?ZkZ0TVdBZll6VXowYmR0aVVQdktRZTd2azcwa2ZFRHNBN1JGVWZsVEVQbi9a?=
 =?utf-8?B?MjNwRG9OR2pEamdpZEpsQUhwak5pWDBIcVF5NVNsck9LMmlJaEJXMUxJT25F?=
 =?utf-8?B?ck9zM0lTY2w2Y2JSaW9lYnFUc2dlMjJteEROekxpem1Jc1NiRmllQ1JRaVNF?=
 =?utf-8?B?aGlTMnBKVTJIeUVneExwN1dtQ3E2RXJwMWRHcGRERUN4Y2VwZFVEOTIxUHB6?=
 =?utf-8?B?MmgyT2lPRUJEUXdTSHFRaGlMemdIajd5d2lRNmlEODV2SlRjckVOL3lIbm1T?=
 =?utf-8?B?bGh4dGI2bDZBaDRqYlR5akVmTVB5SklBUFlZb3NHOGxubEFJd3p5T2dmRUp2?=
 =?utf-8?B?TExLdXJid2NNQVRoTGdsS2ZiYUlPOGY1TzNKZW8vUnhpN3poT0xnWDNGZ29l?=
 =?utf-8?B?cnYydTduV2x3b3NkVG9LWmJsSzNjNW4vdHhOQ056b2g0S2ZmZHRBcHlZTnRJ?=
 =?utf-8?B?bkJWTVdVaytJMDlhZVlyZjNRMnJVQmZwK0FmVkcrSE0wVzk5UWdsc2tWUFdm?=
 =?utf-8?B?dzBUUzlXMWk4S3NVMTBGNnhCUm1IVjdEbVBJbFQvZlVmZVBOd2ZkTWR2OFdh?=
 =?utf-8?B?cStaU3M4ckdSSnNsWUl2YmlRM1NiNzlkb3FlUEUwUWdnTFVSbHl6MGRVZ1Iw?=
 =?utf-8?B?c0ZtT2lYQ2ExenErVnFJNTh2RmluNDNPMzBFRUtHNmZIeXN0ODVDZ05KZnJD?=
 =?utf-8?B?cUdGdG1xeWJxYTk3WkdRTjAvSVhRYnNMVjNtMlFnNjFiNTY2NnBYZDI1MmRD?=
 =?utf-8?B?M1ozdVNjeGw2eWd5bFZJK3lIREx4MlJNbm1sT0RGcTcxOHJydjNadGp6c3Qy?=
 =?utf-8?B?MXRxaXNITXhuQkRBVy9hY2JKdkRnRmZEb0ZnOTlFM0J2bjlPbnBpSXlucXhz?=
 =?utf-8?B?bXE0TWtXejZwblFyb1BYRnRodnBvY3N0VHVGZ2RSNE1zODdYWWd2MzZkOFNG?=
 =?utf-8?B?ZTZ3MitBa2h6RkNiSTVMNXh3aEVvQkMybHkrWmoyY3JtNFJLOXlwS3huaVBU?=
 =?utf-8?B?a1ptRUVEUXFNSGNFbnBkMDFFNlIrUy9LZkRlV29SWWhwSFl4VTlGV2JpdEhs?=
 =?utf-8?B?Z2VURUZPY1NsN2xHUkZBT24vVmlWNGYvMzRPd0VEZmFsQ0R0UDl0Y1NxbjBM?=
 =?utf-8?B?d1cydW05VGZVVjM3b0tvQ0hCcUM5c1luLzV6SDFmRTliMllSMEh3Q2JPYXln?=
 =?utf-8?B?ZUV0V25oR1NnN0ZUS2k1ak5QMUUwN3QydzVKbjFZYlhicmN2STY3Z2VYWlRI?=
 =?utf-8?B?dHBqMXlyaTl5SXI2VnZFaGRFYUQvTUpXUTUxdEVLU2dlV2NCdEUzVE1nYmtM?=
 =?utf-8?B?WU9FYnREL0o5Q1lZNzFZcU1BNDJLZkpZZjd1a0xmV1Z1NWw1eUE5S0pDZ0pR?=
 =?utf-8?B?RGNGMlpocGZMNVlSOGV3bnNxZ0YxUitySVFPMVdPS1l4bUVvc2JINU5qSnA3?=
 =?utf-8?B?TVNHdGRJUG0wQ2RXSWV5R3g5eWphVHJqUkkwMTgyVUhEcUYyUWtKYUh0bEdx?=
 =?utf-8?B?bk83QnRoWnNnYURTUklzaS81akFUWG5LMnRnUmtzclcvejQ4ZnFiN3N2SGlJ?=
 =?utf-8?B?Vy83TUdSUXVscDVyQTFBL1Q0NU5jWVVzcmJyRFl0b3hDNzFlWEowTE9JYXdj?=
 =?utf-8?B?dGd2cDRMS2JtYklwR0t6WlpjTm96a3kwQ1BoWTdtQ0xQbEExOTlyV1pVNjZ0?=
 =?utf-8?B?NDh4WEI1N1pvL01LZTc1bVZSSEVyczZDZDhYZzYrMFdCcWpjUkZYU2JXaFFs?=
 =?utf-8?B?TmdHalZEYmpLU3l6cVNBTG1jY0Q2bHRWYXZqYzdMUDI5c3oxOFJNYndGSFND?=
 =?utf-8?B?WTNWSEtVU256bjhBMldFZW5qTEQxVitNQ2pSMzVuTm1iMGFBQ0hublBqMWNC?=
 =?utf-8?B?L3U5M01SUndsZEdDMUtERnVDQUppcWNZMERjTTB2NUZHaTJhUE1xQjEwWHV4?=
 =?utf-8?B?cExha0ZleTlQY3JtOTFVcFhDbExKMjdjczZJVjJ3Q252RWZ1VWc5cFdSekJL?=
 =?utf-8?B?ZEVzVGRMK3Q0RzI5MXhTTDA5dG9hMHJWSWFzOXJaTFE4aURXT2FxOStXTXFY?=
 =?utf-8?Q?vGPyMSAybSVpVLZSc8Dr8UAuJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbad916-17a3-4eb2-d4f2-08dcc0bab0a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 01:52:03.9317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYVFbJkMw3gu7HJBx1AMmU5TPyyzhSW1gfTkg09QQV7Hc5siK0UqnTR11p33Ww/tfaHEQ/Mrv7905Xit2gPbuPiDNHAEwa30wDr2loraMO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6271

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkOiBzdXBw
b3J0IGZvciBBU1QyNzAwDQo+IA0KPiBPbiBNb24sIDIwMjQtMDgtMTkgYXQgMDM6MDUgKzAwMDAs
IFJ5YW4gQ2hlbiB3cm90ZToNCj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzRdIGR0LWJp
bmRpbmdzOiBtZmQ6IGFzcGVlZDogc3VwcG9ydCBmb3INCj4gPiA+ID4gQVNUMjcwMA0KPiA+ID4g
Pg0KPiA+ID4gPiBPbiBXZWQsIDIwMjQtMDgtMTQgYXQgMDY6MzUgKzAwMDAsIFJ5YW4gQ2hlbiB3
cm90ZToNCj4gPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBkdC1iaW5kaW5nczog
bWZkOiBhc3BlZWQ6IHN1cHBvcnQgZm9yDQo+ID4gPiA+ID4gPiBBU1QyNzAwDQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gT24gRnJpLCBBdWcgMDksIDIwMjQgYXQgMDY6MTA6MjJBTSArMDAwMCwg
UnlhbiBDaGVuIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80
XSBkdC1iaW5kaW5nczogbWZkOiBhc3BlZWQ6DQo+ID4gPiA+ID4gPiA+ID4gc3VwcG9ydCBmb3IN
Cj4gPiA+ID4gPiA+ID4gPiBBU1QyNzAwDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4g
PiBPbiAwOS8wOC8yMDI0IDA3OjU1LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4g
PiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBkdC1iaW5kaW5nczogbWZkOiBhc3BlZWQ6DQo+
ID4gPiA+ID4gPiA+ID4gPiA+IHN1cHBvcnQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gZm9yDQo+ID4g
PiA+ID4gPiA+ID4gPiA+IEFTVDI3MDANCj4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
ID4gPiA+ID4gT24gMDgvMDgvMjAyNCAwOTo1OSwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IEFkZCBjb21wYXRpYmxlIHN1cHBvcnQgZm9yIEFTVDI3MDAgY2xrLCByZXNl
dCwNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBwaW5jdHJsLCBzaWxpY29uLWlkIGFuZCBleGFtcGxl
IGZvciBBU1QyNzAwIHNjdS4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hlbiA8cnlhbl9jaGVuQGFzcGVlZHRlY2guY29t
Pg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKgLi4u
L2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MngwMC1zY3UueWFtbCAgICAgIHwgMzENCj4gPiA+ID4g
PiA+ID4gPiA+ID4gKysrKysrKysrKysrKysrKystLQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKg
MSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2Fz
cGVlZCxhc3QyDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4geDAwLQ0KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IHNjdS55YW1sDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWZkL2FzcGVlZCxhc3QyDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4geDAw
LQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHNjdS55YW1sDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
aW5kZXggODZlZTY5YzBmNDViLi5jMDk2NWYwOGFlOGMgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gLS0tDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWZkL2FzcGVlZCxhc3QyDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4geDAwLQ0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IHNjdS55YW1sDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKysr
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWZkL2FzcGVlZCxhc3QyDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4geDAwLQ0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IHNjdS55DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKysrIGFtbA0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IEBAIC0yMSw2ICsyMSw4IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC0gYXNwZWVkLGFzdDI0MDAtc2N1DQo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC0gYXNwZWVkLGFzdDI1
MDAtc2N1DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC0gYXNw
ZWVkLGFzdDI2MDAtc2N1DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAtIGFzcGVl
ZCxhc3QyNzAwLXNjdTANCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgIC0gYXNwZWVk
LGFzdDI3MDAtc2N1MQ0KPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBX
aGF0IGFyZSB0aGUgZGlmZmVyZW5jZXMgYmV0d2VlbiB0aGVzZSB0d28/DQo+ID4gPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gVGhlIG5leHQgW1BBVENIIDQvNF0gaXMgc2N1IGRyaXZl
ciB0aGF0IGluY2x1ZGUNCj4gPiA+ID4gPiA+ID4gPiA+IGFzdDI3MDAtc2N1MA0KPiA+ID4gPiA+
ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4gPiA+ID4gPiBhc3QyNzAwLXNjdTEgQ0xLX09GX0RFQ0xB
UkVfRFJJVkVSKGFzdDI3MDBfc29jMCwNCj4gPiA+ID4gPiA+ID4gPiA+ICJhc3BlZWQsYXN0Mjcw
MC1zY3UwIiwgYXN0MjcwMF9zb2MwX2Nsa19pbml0KTsNCj4gPiA+ID4gPiA+ID4gPiA+IENMS19P
Rl9ERUNMQVJFX0RSSVZFUihhc3QyNzAwX3NvYzEsICJhc3BlZWQsYXN0MjcwMC0NCj4gPiA+ID4g
PiA+ID4gPiA+IHNjdTEiLCBhc3QyNzAwX3NvYzFfY2xrX2luaXQpOw0KPiA+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gV2hhdCBhcmUgaGFyZHdhcmUgZGlmZmVyZW5jZXM/IEVudGlyZWx5
IGRpZmZlcmVudCBkZXZpY2VzPw0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBBU1QyNzAw
IGhhdmUgdHdvIHNvYyBkaWUgY29ubmVjdGVkIGVhY2ggb3RoZXIuDQo+ID4gPiA+ID4gPiA+IEVh
Y2ggc29jIGRpZSBoYXZlIGl0IG93biBzY3UsIHNvIHRoZSBuYW1pbmcgaXMgYXN0MjcwMC1zY3Uw
DQo+ID4gPiA+ID4gPiA+IGZvciBzb2MwLA0KPiA+ID4gPiA+ID4gYW5vdGhlciBpcyBhc3QyNzAw
LXNjdTEgZm9yIHNvYzEuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRGlkbid0IEkgc2VlIGlu
IGFub3RoZXIgcGF0Y2ggb25lIGRpZSBpcyBjcHUgYW5kIG9uZSBpcyBpbz8NCj4gPiA+ID4gPiA+
IFVzZQ0KPiA+ID4gPiA+ID4gdGhvc2UgaW4gdGhlIGNvbXBhdGlibGUgcmF0aGVyIHRoYW4gMCBh
bmQgMSBpZiBzby4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gU29ycnksIEkgd2FudCB0byBhbGln
biB3aXRoIG91ciBkYXRhc2hlZXQgZGVzY3JpcHRpb24uDQo+ID4gPiA+ID4gSXQgd2lsbCBidXQg
c2N1MCBhbmQgc2N1MSByZWdpc3RlciBzZXR0aW5nLg0KPiA+ID4gPg0KPiA+ID4gPiBDYW4gd2Ug
ZG9jdW1lbnQgdGhhdCByZWxhdGlvbnNoaXAgaW4gdGhlIGJpbmRpbmc/IFJvYidzDQo+ID4gPiA+
IHN1Z2dlc3Rpb24NCj4gPiA+ID4gc2VlbXMgbW9yZSBkZXNjcmlwdGl2ZS4NCj4gPiA+IEhlbGxv
LA0KPiA+ID4gCURvIHlvdSB3YW50IG1lIGRvY3VtZW50IGl0IGluIHlhbWwgZmlsZSBvciBqdXN0
IGluIGNvbW1pdA0KPiA+ID4gbWVzc2FnZT8NCj4gPg0KPiA+IEhlbGxvIFJvYiwgQW5kcmV3LA0K
PiA+IAlJIHdpbGwgYWRkIGluIHlhbWwgZmlsZSBpbiBkZXNjcmlwdGlvbi4gTGlrZSBmb2xsb3dp
bmcuDQo+ID4NCj4gPiBkZXNjcmlwdGlvbjoNCj4gPiDCoMKgVGhlIEFzcGVlZCBTeXN0ZW0gQ29u
dHJvbCBVbml0IG1hbmFnZXMgdGhlIGdsb2JhbCBiZWhhdmlvdXIgb2YgdGhlDQo+ID4gU29DLA0K
PiA+IMKgwqBjb25maWd1cmluZyBlbGVtZW50cyBzdWNoIGFzIGNsb2NrcywgcGlubXV4LCBhbmQg
cmVzZXQuDQo+ID4gKyAgSW4gQVNUMjcwMCwgaXQgaGFzIHR3byBzb2MgY29tYmluYXRpb24uIEVh
Y2ggc29jIGluY2x1ZGUgaXRzIG93bg0KPiA+IHNjdSByZWdpc3RlciBjb250cm9sLg0KPiA+ICsg
IGFzdDI3MDAtc2N1MCBmb3Igc29jMCwgYXN0MjcwMC1zY3UxIGZvciBzb2MxLg0KPiA+DQo+ID4g
SXMgdGhhdCB3aWxsIGJlIGJldHRlciB3YXkgPw0KPiANCj4gV2hhdCBSb2IgaXMgc3VnZ2VzdGlu
ZyBpcyB0byBhZGQgdGhlIGNvbXBhdGlibGVzICJhc3BlZWQsYXN0MjcwMC1zY3UtDQo+IGNwdSIg
YW5kICJhc3BlZWQsYXN0MjcwMC1zY3UtaW8iLCBhbmQgdGhlbiBpbiB0aGUgZGVzY3JpcHRpb24g
c2F5DQo+IHNvbWV0aGluZyBsaWtlOg0KPiANCj4gICAgVGhlIEFTVDI3MDAgaW50ZWdyYXRlcyBi
b3RoIGEgQ1BVIGFuZCBhbiBJTyBkaWUsIGVhY2ggd2l0aCB0aGVpciBvd24NCj4gICAgU0NVLiBU
aGUgImFzcGVlZCxhc3QyNzAwLXNjdS1jcHUiIGFuZCAiYXNwZWVkLGFzdDI3MDAtc2N1LWlvIg0K
PiAgICBjb21wYXRpYmxlcyBjb3JyZXNwb25kIHRvIFNDVTAgYW5kIFNDVTEgcmVzcGVjdGl2ZWx5
Lg0KPiANCkhlbGxvIEFuZHJldywNCglTb3JyeSwgZm9yIGNvcnJlc3BvbmQgZm9yIGFzdDI3MDAg
ZGF0YXNoZWV0LCB0aGUgZGVzY3JpcHRpb24gaXMgc2N1MC9zY3UxLg0KCVN5c3RlbSBDb250cm9s
IFVuaXQgIzAgKFNDVTApLyBTeXN0ZW0gQ29udHJvbCBVbml0ICMxIChTQ1UxKSB3aHkgbm90IHdl
DQoJS2VlcCBhbGlnbiB3aXRoIGRhdGFzaGVldCBzdGF0ZW1lbnQ/DQo=

