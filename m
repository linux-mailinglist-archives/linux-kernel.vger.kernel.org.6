Return-Path: <linux-kernel+bounces-358178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17122997B16
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A14D1F24C20
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D856C17C228;
	Thu, 10 Oct 2024 03:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Uwf5EF5c"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3414293;
	Thu, 10 Oct 2024 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529640; cv=fail; b=oTnmPauV/0AEknfQvDiX88o0kga1umA5eBQ5/VKwRm+xh/q1wFJtdIO9CA4FlvKzuWcrgYxOLWcz0xk+AUtCRy7x5pRdABKDFEv+EzD/E2zeYiREujFqgO/DlNKw9+zbxSA8OY/Ws51gLP0icxhD4vEQCaZaOJ7gpiWpAz28wLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529640; c=relaxed/simple;
	bh=8iUyb9mKksJfhDumCtKY6J6aVexAmserfEivb81BnGk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PcRnnGgmeQd+4in3ZdFSYOOjsK0rqCS0cXEx4gybTw+7ax0S9mL0ZWq+4Q1NdUGXQI9feufmyNiZq1OnRwFcNEfQ9A+vuWhpV8NgGtkem0HVg+R4lMu/nv7jms5fj826sSvHI1XOiRmNnLdSvcZMfT3sS4c3jHddhs58pZFzTI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Uwf5EF5c; arc=fail smtp.client-ip=40.107.215.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grup5iM7TGHkakB+vqqQr1ZLcrKGBrBVvNA6Pbzt2jHWsT/ugrcOpNPoGVRs5DlULbpx1vdjVGmhBNE1ip/UAL6l21+WS1K1BhXrfFqp3fymRsVEbbBZFH5t+IT79rLTVwKYbze8uy5Tw9i5H6r6oY7NwBRdjql7xuaePaCVPLkQ1/SfGtQ4JDuYwc3VobtUuXz32kWZZ6cCz2Y/bYN/snUCguyCjyrfNtjEYFRlKbLVyPCGG1i3mmltIWVIU2RtWWXYem4C4If5pIb4+iA0qHA75iVFZq0xRAfZMOTox5Z+xBP6X8A1UagPqJXegfgALp0AdCXOn6VP2mWwwUnlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iUyb9mKksJfhDumCtKY6J6aVexAmserfEivb81BnGk=;
 b=p8ILrvDpDCAqt18Xh49tiinvsPrECeIFSkElhIjc/hd8OrPXtNpPbqL9agOCUXC0biQVXdJYbWqr/F09b8n5NAoKAFZGdOXN0ltS7Dd6fPopBcpHwbWN5OHDaH1ZxVKzAWYycw9G0KYPbYAKtZxLfyLmx3/xJfyt7tRg1RZ6z6wDZ8WDOY+rdUrz+V2BkQHfVWlgwxMAiqB9VreGV5+wPUhhTmYxuJkFF6upCmaxo6RH+twM/XlQ1REQo9mIUt5bIK4g4eqrfOpKEOxC+/nxrNUtFfVSaCMoEAZDXs/j5R/5yiG1H5Rr1vu0nnNq/x4KZJTOSaWxmUPi0xI1PRM24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iUyb9mKksJfhDumCtKY6J6aVexAmserfEivb81BnGk=;
 b=Uwf5EF5cRZ39e5oZYnwsw67c8LH5mC8hVjmdGdBrp+UHlVppxQecT2cTYF918O4WDPP0tpNuRUGqOqab+B2kK9S5PZwhioU2VDgxow6fRiYvAfTjzcRbheT9slHLYZMh1cep1PkxRd3eK+uVRWNt2f0BIRnKKmUwQiFUsH4CJY+8ZAmHj8ztMsavzZ7jn9DYsaKQobpblLqHU2EMLmCAKhh+FI8ZnC+HufDDddVJ+7iabaVmIP0U9XBVpqRqKESB6cxZevdDAzyla5ginCmySsGre0Xn7NPzKxkZjp7fhhNQ6ZWItPktQFWwoW94uKTpTecqS+c4zheuC2OI6+vAmQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYZPR06MB5687.apcprd06.prod.outlook.com (2603:1096:400:281::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17; Thu, 10 Oct
 2024 03:07:13 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 03:07:13 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, "dmitry.baryshkov@linaro.org"
	<dmitry.baryshkov@linaro.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v5 3/3] clk: aspeed: add AST2700 clock driver.
Thread-Topic: [PATCH v5 3/3] clk: aspeed: add AST2700 clock driver.
Thread-Index: AQHbGhE+l0ofGs4yjE6/z0/G6mEcM7J+LI4AgAEhmqA=
Date: Thu, 10 Oct 2024 03:07:13 +0000
Message-ID:
 <OS8PR06MB75412523C3F28F07A32B8E28F2782@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20241009060521.2971168-1-ryan_chen@aspeedtech.com>
	 <20241009060521.2971168-4-ryan_chen@aspeedtech.com>
 <cc7faea42df6281a24360090d99cef8f99aa7736.camel@pengutronix.de>
In-Reply-To: <cc7faea42df6281a24360090d99cef8f99aa7736.camel@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYZPR06MB5687:EE_
x-ms-office365-filtering-correlation-id: dfb9500d-53e7-4c0b-9daa-08dce8d8a3cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFQ5UW5JQ1dMT2VlRVdWUFBCMXJ4Ky9EaCt3VnVJQVhiUEowVWlRbzhJS2sz?=
 =?utf-8?B?UkRqZ21pMWZFZVphd0hhOUx3RnhWdHFZSkJxRGt5SlNocXN1R1FkenpaUVIr?=
 =?utf-8?B?U01tNFhiSDBPL2hLcllIQ2MzNzRra291UkpiZ2d1eWM4eXZzM2lxQnlaOVo3?=
 =?utf-8?B?MnpqR0I4a1JTVkVmY2tpSE5QVVFiWldmUVUzOGMyUDZSQ0YwWmFadnlEaGo0?=
 =?utf-8?B?SlNtNVB0T1FEUURYOStBUDBaalltRzU3MDZrQVZPdzJBOGU5TUU4SlZaZUsy?=
 =?utf-8?B?Y1lWaTM1dUVuZm1nZWRmRC9tQ2ZIazR5MTFEeW03aUZCUkgzNXl4aU9EUzB4?=
 =?utf-8?B?VnFKYUxoditNMVJYMHVMUHVQc1c0SDJMZ3VZN3dHL2tXT2hDdkc4RjFZREtU?=
 =?utf-8?B?RzFxdm5pQTFCSlRheWUrbCtLbEJpK2x3RmFZZzVUeEloMlBvT29VZlhnL1N5?=
 =?utf-8?B?c0FqQ1JvVFJyenRZUzdxTCtUbyt1WHp4cGFpU0xKWEY5bHJQUjZzQ2hUSXF1?=
 =?utf-8?B?c2ZyVmsxY05LVUYxWXluKyszTm1mbW9Qalh4WC90Z29TMkdRYnFOcjNUbmZK?=
 =?utf-8?B?Y2RNQmlWYStXQTMyQU9RNFE2M0NjN0NJazVNL1VWQk0wQ3BaVUQvMHhYTUtn?=
 =?utf-8?B?bEVUbzJIVTdsblI5NUVsaitpaTRsRjZ0ak1rRHdxOG1tVGJlZVVSdjJkU0Qw?=
 =?utf-8?B?UC9BY0llRmRnaCtVeFVmaUxpc21ObXBBVTNYRmRYVk5aOTRiamp2cDRXbW1t?=
 =?utf-8?B?dk1DbjJTc2hTSTRWdWY5Yzd3NFVYSjdMMENqazkxTWVRZkRSbVRqLzNkd3JZ?=
 =?utf-8?B?SlhRQTFoaWZhc2hNWGxVUVZMa1pJM2c4MWhmNktHUkx0Y0thamsvTWlsaTg1?=
 =?utf-8?B?UThEaHJmUW82MGF0TW9lSmZoUVI1YndFdGVUS2U1RUVwU1lRYUQ5eWlRUWQ3?=
 =?utf-8?B?dmZkN1lhMS9DQlNwNmZqVjVjSGsxSURJNWpFaGxLVGZsclpXckJxUGg4T3Zp?=
 =?utf-8?B?S2I3OENobzlGa1ZyNTdEOGJDSHVzeVF2VExSYThTNzV0ZnA2ejc3T2lhUG1i?=
 =?utf-8?B?QTdDNysrY2pmamhTRjV3eEUycDJaWitFYjFjZnFJWER1cXlBb3RPYlhNZE84?=
 =?utf-8?B?aFVyMWQ0QUhoenVLZ1BwNFpPUC9GNGh6am9yUTY1Vm8rK1ozVUdWbEZ2T240?=
 =?utf-8?B?YVZ4RnVnbHVKTmo3WE9BeHVpYytveUh4K1dOUTZ2MEZnb2ZQYmsxQ0VoSHlm?=
 =?utf-8?B?Q1pnMHhEeE9HZVo3YXFZVVRPUlVqYWUrc3RTRTF5WkIvT3ZHN0VUa3hZZmpo?=
 =?utf-8?B?Y2JYZjNRS1NGYjN1NmkxMHZtU2gwc0tLalRZRFJFSkRvUjB4Sm9jd2FkdzBS?=
 =?utf-8?B?d2ZyQmIxZlJWNGRPOTAwZnorbU5ZSlhWZXRXblV2c3lSVWk5UklMZldNQ0tN?=
 =?utf-8?B?N1Q0WVlIMUJqSjZoeWwxSUtiNDVIclVrZkF0YVZNMVNsUlRGVjY2RjBjNWJ1?=
 =?utf-8?B?VStRUlhjSEI1TDUra1RYbFVHRGN2ZWZkS0lzZndmNUdQMlAyMmtGR3JKcU5L?=
 =?utf-8?B?MldvYkJjRC9LZXd6Q0F3VTIrUENIQWRHRWRnUm93eUJmb2xhV1RiUTl0bVB5?=
 =?utf-8?B?Qk85V01NTlI4aEdyUFJ6WXNkcndVZHc2eHVMR3VvNTVDdmdMd2t5YVd3eWND?=
 =?utf-8?B?ckhnOUIyNy9yZGd4Q2o0N3h3TGdKaEd4NkdnQmZJRm9YT3RIV1hjd3J5THVy?=
 =?utf-8?B?QXFRaGRLZCtpYmhwSVIvMTFNakVHVlEwZW9TVnFyUHdTUHJJbzZ4S0lrM1Zk?=
 =?utf-8?Q?8WZ1zQfzz1lm2QqLlXn7LqJ/Zp2roun6ZOqEY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUg4MC9zdHJvUVdsY05MdktEdk9CVnR4WDJIbUo4VHROMzl0VjhxWmZJVUww?=
 =?utf-8?B?aGp4Smd3RkxJWkJYNngyRW8vTmVmN3JFUXlodDlER0x0bEtoVlNOZEVweWhp?=
 =?utf-8?B?Vmp5VFNoRXRUU2xieTZYUldpRlp2MnpGMkFvdC82ZmJ3cW4wdEY3M2Y4ZHUx?=
 =?utf-8?B?cTJPNDlJNThSZWR0MW1hb1ozUHllTyszbnNGdWQrRm5FaWFjMkd6WVpickth?=
 =?utf-8?B?WjkxR1ZJY1I1Q2Q3UG1FOWQrc2NhV0duY2pFRG4rc04ya0NDQ3AyYXFQc3BT?=
 =?utf-8?B?MlRBa0duOUc1SWpXMFQvdFFqQkJCTzFFelVITmRGbFVtNDd5Z01pUU9BdUhk?=
 =?utf-8?B?R2FwVnNsN1ZwYUpFSTFNaGpCR0JGZ0pRNkNDSUFRaGwwb2xkYUc2VTNTc1Vh?=
 =?utf-8?B?SzVXZndOTE1pZUJvV2xQaTBIYXV1b3pxVUlTQU44UmxzcmJ4OHZSYlZlelZY?=
 =?utf-8?B?aXZSNW0yV2lKRTFPK05xSTFpODl5L0NzaGNEcHoyUWNEVlJobUc5NXl2Q1JI?=
 =?utf-8?B?WTlhN2NOLzVFdmwrazRWd3ZjeHNRc3MwN1dQR1g4aXV5Uit1bEhFK0xnZ1pR?=
 =?utf-8?B?VDNnYytWZ3VtOFkrVTVXeGhKTHd6VStRZGlYWFNiZ1I1U3ptS2Z3bnhEbnlD?=
 =?utf-8?B?M2tnYUkzaXlZdk9kUXVJZDA2VGNJTGdBMC92VFpjMVRrRHRiOW9RaG01aFhh?=
 =?utf-8?B?T0Z3RmNlSjZrYmFxTEpSQ0YvdE9JOW4xT0FSc05EWHFXM2RSYmluRTRSa1Bz?=
 =?utf-8?B?T3gwL1UwSDc4ZWpkM2NzVnZHaWNXV0I3aWJWOXhJSTRteGpiVHNVbjlvWkNZ?=
 =?utf-8?B?TVRUVzU5YStnbEhKWE0zeXN1V00raEZMWFJUczMxZUFRYXFKTCtsRFBYbXRE?=
 =?utf-8?B?a2ttVTJqSVMxYUpWTUo1TE5SdXM0UFVFc3l0N0I5SHdkMGRZTTZtZmcvbUpO?=
 =?utf-8?B?L0wwUjBPeGdXemdHeW0vMlRLYS9WN0gvOVAwOGRWNlVndnk1OUNXMmh1emNL?=
 =?utf-8?B?VEdTandsNjFlZ25jaFFRaTNvb1lhdDlTSkFVaGttMjF3cTBjOEliTHR1U2Ey?=
 =?utf-8?B?UUZuU3JaMi9BUlNUcDlEZWl6T1Z5NUtQbjJmcDRYOGhSZStRSWNZSW5KYkxC?=
 =?utf-8?B?TlpNa0JpUmZmamIzOW5wNzduVVp5aGdqdEpWbXpNRVN5U2JTYS9VK1RWN0Nv?=
 =?utf-8?B?RlRHWHl4WVUxckNJMnd1ZERDNXh3WFUwWWUyNG5BeEZwZVlYTDBDb3hDRk5u?=
 =?utf-8?B?WEZFd3pzZTlWbHJCOGV2c0QxMzVaY3RDcll6bnhyU2dYdFBsL2hpczBXdng3?=
 =?utf-8?B?VitKOXc1TjQ5eEhJY0lVdnJLc2FUNEtYbktIbExCc29aeHFUYVlqRW8zSWZz?=
 =?utf-8?B?Z2FEcVJUL3BKa0N3WWk0UjZWTGhiVUV1Rndvb2ZPUW91Z1ljdmZyV0ZoVm9Y?=
 =?utf-8?B?dmRoczgwS3pjSFpUMlJLeW45SGRISndQZEE0SXppSzdkdHM4OXhCMnJQVEdl?=
 =?utf-8?B?cnE1Rkl4NzdRbHdYd1dTY2s2TzFDdFJpM2ZLRTJtM2dWODNVMjZiTGpUT0hj?=
 =?utf-8?B?aEUySWxWdjNFRzVhUi9DeGN1THlUay9OaTZOUjB4UXpTRlRrSXQxdVNOYVhN?=
 =?utf-8?B?c1hpZmFhblpPQU1TZVo2Y28zSUlocnRKT052OWMzYXFGbW5EWjdQRGQxSlZJ?=
 =?utf-8?B?OHN4bTlwWVpxNVpWanBLVU9EVDR1eEhnWC95Wk4xWElwV2RFV0JGVlArMTM0?=
 =?utf-8?B?T01pVFducTNJV3BxNUI0azUxUEdxZnVXd2o3UFNtU0pkOWhWT2VsRzVhL2xR?=
 =?utf-8?B?N1pzcE5oeFRsS0x3cm9ibjY2cUgwbE45K1dhUFJhTjJheFF0UHZQUlJPQzA5?=
 =?utf-8?B?M0MrNDMxaXAwMS9PVllITHV4L2VTQ1Z2T3JEN3RHL3BBUEdSc1Mya05meGVD?=
 =?utf-8?B?c1Z1Q0lidEdJaGVoT3FEYmx0OGVoMWVmUXJ0cXlwM1dJdkR0cFN3WUh5TWZ6?=
 =?utf-8?B?aEtMVjdQSklCZG45cXdBTkR6VzgycXpOMUJTNzlSVHA0aUZ1TTlxN3ZidUdx?=
 =?utf-8?B?R2ZIUEZ4K2c4amg1endOVTBxUG5kR0wxb3lSTHNJRHQrRXFxUklmNTNkS1VP?=
 =?utf-8?Q?AK6kpK1e+2kzIsy5PGYbBbg+e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb9500d-53e7-4c0b-9daa-08dce8d8a3cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 03:07:13.7947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPCxfl8+PftOmQZLr4Hdogqx88vbA5dEhrWMOz/733uY//TywKj2uLDfTgRrXEi2AtI5aQwGtexYS8ri8+qHVv6TcB0ogdYidmVvMk7/IJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5687

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDMvM10gY2xrOiBhc3BlZWQ6IGFkZCBBU1QyNzAwIGNs
b2NrIGRyaXZlci4NCj4gDQo+IE9uIE1pLCAyMDI0LTEwLTA5IGF0IDE0OjA1ICswODAwLCBSeWFu
IENoZW4gd3JvdGU6DQo+ID4gQWRkIEFTVDI3MDAgY2xvY2sgY29udHJvbGxlciBkcml2ZXIgYW5k
IGFsc28gdXNlIGF4aWxpYXJ5IGRldmljZQ0KPiA+IGZyYW1ld29yayByZWdpc3RlciB0aGUgcmVz
ZXQgY29udHJvbGxlciBkcml2ZXIuDQo+ID4gRHVlIHRvIGNsb2NrIGFuZCByZXNldCB1c2luZyB0
aGUgc2FtZSByZWdpc3RlciByZWdpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENo
ZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jbGsv
S2NvbmZpZyAgICAgICB8ICAgIDggKw0KPiA+ICBkcml2ZXJzL2Nsay9NYWtlZmlsZSAgICAgIHwg
ICAgMSArDQo+ID4gIGRyaXZlcnMvY2xrL2Nsay1hc3QyNzAwLmMgfCAxNTU0DQo+ID4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE1
NjMgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvY2xr
LWFzdDI3MDAuYw0KPiA+DQo+IFsuLi5dDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Ns
ay1hc3QyNzAwLmMgYi9kcml2ZXJzL2Nsay9jbGstYXN0MjcwMC5jIG5ldw0KPiA+IGZpbGUgbW9k
ZSAxMDA2NDQgaW5kZXggMDAwMDAwMDAwMDAwLi5lZjFmOTM5YjFjOWYNCj4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvY2xrLWFzdDI3MDAuYw0KPiA+IEBAIC0wLDAgKzEs
MTU1NCBAQA0KPiBbLi4uXQ0KPiA+ICtzdGF0aWMgdm9pZCBhc3BlZWRfcmVzZXRfdW5yZWdpc3Rl
cl9hZGV2KHZvaWQgKl9hZGV2KSB7DQo+ID4gKwlzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYWRl
diA9IF9hZGV2Ow0KPiA+ICsNCj4gPiArCWF1eGlsaWFyeV9kZXZpY2VfZGVsZXRlKGFkZXYpOw0K
PiA+ICsJYXV4aWxpYXJ5X2RldmljZV91bmluaXQoYWRldik7DQo+ID4gK30NCj4gPiArDQo+ID4g
K3N0YXRpYyB2b2lkIGFzcGVlZF9yZXNldF9hZGV2X3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2
KSB7DQo+ID4gKwlzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYWRldiA9IHRvX2F1eGlsaWFyeV9k
ZXYoZGV2KTsNCj4gPiArDQo+ID4gKwlrZnJlZShhZGV2KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIGludCBhc3BlZWRfcmVzZXRfY29udHJvbGxlcl9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNl
ICpjbGtfZGV2LA0KPiA+ICsJCQkJCSAgICB2b2lkIF9faW9tZW0gKmJhc2UsIGNvbnN0IGNoYXIg
KmFkZXZfbmFtZSkgew0KPiA+ICsJc3RydWN0IGF1eGlsaWFyeV9kZXZpY2UgKmFkZXY7DQo+ID4g
KwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCWFkZXYgPSBremFsbG9jKHNpemVvZigqYWRldiksIEdG
UF9LRVJORUwpOw0KPiA+ICsJaWYgKCFhZGV2KQ0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+
ICsNCj4gPiArCWFkZXYtPm5hbWUgPSBhZGV2X25hbWU7DQo+ID4gKwlhZGV2LT5kZXYucGFyZW50
ID0gY2xrX2RldjsNCj4gPiArCWFkZXYtPmRldi5yZWxlYXNlID0gYXNwZWVkX3Jlc2V0X2FkZXZf
cmVsZWFzZTsNCj4gPiArCWFkZXYtPmlkID0gNjY2dTsNCj4gPiArDQo+ID4gKwlyZXQgPSBhdXhp
bGlhcnlfZGV2aWNlX2luaXQoYWRldik7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJa2ZyZWUo
YWRldik7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXQgPSBh
dXhpbGlhcnlfZGV2aWNlX2FkZChhZGV2KTsNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlhdXhp
bGlhcnlfZGV2aWNlX3VuaW5pdChhZGV2KTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0K
PiA+ICsNCj4gPiArCWFkZXYtPmRldi5wbGF0Zm9ybV9kYXRhID0gKF9fZm9yY2Ugdm9pZCAqKWJh
c2U7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChjbGtfZGV2
LA0KPiA+ICthc3BlZWRfcmVzZXRfdW5yZWdpc3Rlcl9hZGV2LCBhZGV2KTsgfQ0KPiANCj4gU2hv
dWxkIHRoaXMgYmUgbW92ZWQgaW50byByZXNldC1hc3BlZWQuYz8NCklmIG1vdmUgdG8gcmVzZXQt
YXNwZWVkLmMgdGhhdCB3aWxsIGhhdmUgRVhQT1JUX1NZTUJPTF9HUEwoYXNwZWVkX3Jlc2V0X2Nv
bnRyb2xsZXJfcmVnaXN0ZXIpOw0KQW5kIGFkZCBvbmUgaGVhZGVyIC4vZHJpdmVycy9yZXNldC9y
ZXNldC1hc3BlZWQuaC4gDQpUaGF0IGlzIGV4cGVjdGVkPyBBbSBJIHJpZ2h0Pw0KPiANCj4gcmVn
YXJkcw0KPiBQaGlsaXBwDQo=

