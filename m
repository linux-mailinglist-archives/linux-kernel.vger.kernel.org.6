Return-Path: <linux-kernel+bounces-288947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EBB954086
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875EC1C23846
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF12112E1CD;
	Fri, 16 Aug 2024 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="gm1s310W"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2108.outbound.protection.outlook.com [40.107.215.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50912CD89;
	Fri, 16 Aug 2024 04:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781269; cv=fail; b=hL7jjGPYH+u0rnCprLzgH83hB3WP9vyI375PkEcJnGboTX3stfcPSms25o85mTomrRd4RjrUPeLq7Th7c6FC5gwGFzz3melQlSLBAcgfCpRNyU/2l4vNBmG18dIhTwcB1o0u66TvZAZvGz2oXiYWU5tv4cGE7NXr14wtCD/vRNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781269; c=relaxed/simple;
	bh=66PCdLHxCS/bJEp65Y5YsbAVuatSLVTyB05suZtuY7Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QHYi4RBSeWgjkGsoBCeafIuZ49KPxx/JOoVzFtiRQm0ZueQ8UM886m+NiXnvLNOq7ogpyjIW2Aqhxf8UocaBOuslxq5Saf2NStXGHLUztgNj6TGIP3KE4N1vttdm279Zd2qj4tA+Z8YqRKmBoa5Wj4GFP3ybrxnapscQNHCxda8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=gm1s310W; arc=fail smtp.client-ip=40.107.215.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlpkfGhXIlc7dOzrfUrbD9GWt0PkCuigheztJFPpBSdT/NkR14nbjrMyq8YuqVmWy3cVPA5E0abN3Aj/lSq/NbRHUoVZ/6znRt/1Q0tMmJDHvtDIsRcnPNxOTwoYcqlLy6VQvA1VFLrv8FD7g5RKwqOkEG7YLksJJhsqACq066/pwDyp5nB7xH2bqR1Z4mrdxup9AakTWkJ3Yf/ednymOqt3uzURld1i1l7/n3y5ZoXBMfIUT6Cb0Fg83UEgdYvFRXsP4G9kZ+aHnLlFyQIoLoW71F43iQb9AkM0VId7JMG+QEEgzpXZjvvMI551U6HE5xW5tJMdqhKg+R0wgu3DLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66PCdLHxCS/bJEp65Y5YsbAVuatSLVTyB05suZtuY7Y=;
 b=WwczHFWyYz/Vf/5rJ5ugwxVGxGsckVpFNoIv7Muk9uTEtILlPGbe7xw4wDHzX06XOifgIWERAKnuJD/S7XI3eDObEZXGjy2BkRRXOQpyySbX6N29NWdghKBVB3Nwv/88xmJXn9wjp8NE/wEfcrokqkuOgRl3xeKjhA2Xf2hXDbLrh1q0HK+g+Vh/lNIMOnDCWAM1GrINjYV8WAZvhfqvN8mJAGjbyQu5oHSsEt1IDKomiDu0STwzNYp869xK5SgCTxME8X6EAwUugnikGAGu/RIuf8LQaq8t2/TFwNEWlIEMfuh3sXkfqdoYBjkBjGNrKlogKh9zSub9yiRPutR3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66PCdLHxCS/bJEp65Y5YsbAVuatSLVTyB05suZtuY7Y=;
 b=gm1s310WMPMpHUVJcr6dRM2OTDufjS7xm59iNR5VoQ4scQG9ZPeN1Ohjr5u4iQYShOKvYOhEFuTfvArKnDo4uOWDHcs2ZCl+GQDgSKwRQ2ZZqNkSReZ7e8BxPcG0VMI4eNRHWHHT9NHHR3FRtIAnK5z0e6DNi1TgmTfix0qHOQWvsI7jeoSJuFQtZ/1HYvQZaPekjc7RbDZ8BSjpzP6koFjKDH5r3Ms3w6NQbYkMhsn2qdww/U8BEbdKNdfLC08u3wo5yaKTLSfoTzmVrYs4z/znyhgXvGzcb7pA58RuebLzuA9tKmI80KUtkLat8x/bseEFpqMg1KLoMre9egasUA==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by KL1PR0601MB5510.apcprd06.prod.outlook.com (2603:1096:820:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 04:07:44 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%7]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 04:07:44 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "lee@kernel.org" <lee@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net"
	<olof@lixom.net>, "soc@kernel.org" <soc@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v1 04/10] dt-bindings: reset: ast2700: Add binding for
 ASPEED AST2700 Reset
Thread-Topic: [PATCH v1 04/10] dt-bindings: reset: ast2700: Add binding for
 ASPEED AST2700 Reset
Thread-Index: AQHa30uL3kuW/7xi5E6UxuPnh6N4WrII2zeAgCBs9WA=
Date: Fri, 16 Aug 2024 04:07:44 +0000
Message-ID:
 <PSAPR06MB494977BF6BAD22E4D4C3436389812@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-5-kevin_chen@aspeedtech.com>
 <3b6777d8-14b4-4076-9877-4c71657a49e6@kernel.org>
In-Reply-To: <3b6777d8-14b4-4076-9877-4c71657a49e6@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|KL1PR0601MB5510:EE_
x-ms-office365-filtering-correlation-id: 03f945af-22b0-4346-153e-08dcbda8fb1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWNhNkdRM2xvUHlSaUhSZTRoSnEvcE9ZU1hMU1djRXIwdFZYZCt2YkgzdlYv?=
 =?utf-8?B?SDZXdCtJVTdZWEx2bXlNWHZoY0Nja2hzeFduNWlSSHVlS25OdG1CQ3JrNHAw?=
 =?utf-8?B?Q2xjT3RaY0YrZlhRZks1NGZCSUZiUG9qeVBhOXFTVnFUZ2xhQksrOVk5N2VG?=
 =?utf-8?B?cEhZUUxlbXFSTkM5TUF5UkNyRGtrQlVZSXNuT2RzZEZpS1hDQ0IzR3BVemFz?=
 =?utf-8?B?ZUN4NjJoMklCME9VR2JjNzJSWjEwUE02bWYxVndINTQ3QW9ENzQ4YVc3UGtG?=
 =?utf-8?B?TnphVTA0QnU3cFJuNktQUVZMZE05UzlBeXNaSmE5NVhkYTVNNzJucmpWNFpU?=
 =?utf-8?B?S24zWktxSFEzYUZJNHAxVXNOVGduYktYd0Y4dnZIdG1OYmcrdGhKeE1zTTkx?=
 =?utf-8?B?WXYxS0VJL1RTS0ZyOXdXTTZwNzhJSmFxU0UxWWVISk0zQkpOQlMrN3BGN2Rt?=
 =?utf-8?B?aFlpMGluYWxsQnJVcC92WGdJelhZSDdGeW5uZTNvMTRvNXdVRnVIT0h1aTF2?=
 =?utf-8?B?cDlvUTdkdlVYSThMVGdRV0JlMmJvWlRjQW1JYWEybmtZRi8wRjJMM2ZnNDBZ?=
 =?utf-8?B?K1J6VTlFbUk0VHdJbmFUL281bjA2MHdxbEtrNGFFQ0pvZ2V3cXkzZHNVMS9Q?=
 =?utf-8?B?Wnc5TFJSOWVPSTVLNEFya2ovV1NkRTMxS2ovQlM5aUp3eHB3Wm5obGgrWVg0?=
 =?utf-8?B?VzhVa1BtNFhpOG1YU1JmcUxRMFVxUmpvbUtnL3dPQzhHc3NiZ1lQSS81ZTFj?=
 =?utf-8?B?M2N4b2JqazFLU2ovekZ1QlE3N3h6REV0ZjBkcWEvOXpvUjk0bktVdFBWUGo5?=
 =?utf-8?B?Q3JxSVdadDIxcURxaGQ3bDVrelRtekpxdzlrTmFlYmVnRDB5a0RoUEtIVkN3?=
 =?utf-8?B?UFlPbU8rRXUrMk5aV1licTlMWlpJdUR3Y21VODNvYzZTTWorSUtKcUhBbk1p?=
 =?utf-8?B?bnIyZVJ2K0h4dHZtV2NPQ280aTMvOUNHN0ZwS1UvOHNWU0dLQkNGL2tFaDMw?=
 =?utf-8?B?aGxzenpod1BBdVJJYklKYTNHaXg2bWVVZXN0ajdPdWFLQlJER3N0S2VpcTRH?=
 =?utf-8?B?RVRBQXdzeUY3VFdRUUF0UVc4TS9FYkhDVXJLdzNVb3R4NlBlc1RWaXF5R3RC?=
 =?utf-8?B?RGpFaEdvRGthYm5wUXI3czczTHFpbVdSYzQwRFlBOFdySi9FdURwQmdFRkNL?=
 =?utf-8?B?bEFNWlpxVUZnWURkVHNjbU05TlZncEREL1NFczZ4ODNkNFFkUy90cFFRRGw2?=
 =?utf-8?B?ajZoNXVUSytsQ2h3WXJhY01ZNVJRUnFKZ29uK1BTbXpoZDkwQzhJaTVGT0Ns?=
 =?utf-8?B?S29sckpYL005aGJiSG5FdDlTNDMyd3hNS1lteHE0UDJpM2VlakNjTWlLRmh4?=
 =?utf-8?B?NUc1ZjdkOXgzd2ZXSWJINmZkZTBYZTJYQ09HVVE2djV4VTRPeVlJTEZ5dWp3?=
 =?utf-8?B?Q0pjUGtVQVVGSTdxRWVtZC9FSmYxL2NhWEdIdU8rM01JVFk5aUNBdmZnT25C?=
 =?utf-8?B?WEU3cGFIY0p5c2d5SU9nNFNudzlYNmZTRTFHN08wSTc0UE9rMHBsYlQyL0RQ?=
 =?utf-8?B?MXM1aGk1YkxzcmFhZHYxb05CT3lPMmdtcDZCUUYvbTlHR3FqMVd0RHNndHBs?=
 =?utf-8?B?bFZicEd3T2l6YXlxb1Z2NkU0ZVZzSzhsZlJvbnlUU01yVERiNlBxK09OVUxj?=
 =?utf-8?B?L2FUUjM0SXo3TFVDZlB1WC9sVm90NHZtdUk5RWRjc3pyeU80b1ZyL1BqRmFx?=
 =?utf-8?B?VFJxbXZSVi8xblNwYVRQOGZGOEVWd2FpVWlpbUVUVW1QL3BvaFp6QWU1RDA4?=
 =?utf-8?B?cFBTdUN0cXhCUnJobEhmMFRQRXRUbG53RW1xc1lZS1BuTEZrSDBFdkhaQ0RT?=
 =?utf-8?B?citHUnZxTjNqOXpxV0RyUFJzM0VYd1lRK3BqcWlzYS9JUG9IS2xONlFmWWJP?=
 =?utf-8?Q?alfsAzQfmn0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a011cFd3QU5PVDh0bmhYd0NnS2w2VlB5eDFNVTlsQVdla3pTZVJBOHpROURN?=
 =?utf-8?B?YXNEd2Z0azRVb3pxSFhrRTlPemdTWFI1Tm5lOTlZeEMvb1ZabHpaR1J0U25u?=
 =?utf-8?B?bWhOcDZCemFTY1Z6TTNIS2U0M1IyREdRY29jVGEzcXVaelE2NG9oeTJxZU5j?=
 =?utf-8?B?YjNrSElBV1NKeklNbVdIcGdReXQ0Y2hhMndPSjdtSzF2d1gyT0Nwd09LdGlP?=
 =?utf-8?B?ZHFhQTArbzdsL0FPOUgxZndCZG1BNlYyZU5pREtGYjZHekc1eGUyN2dDTGcr?=
 =?utf-8?B?dWIwZzJWMk1vcXEwWk9yekF3WEJQcDRpTW1ZcWJyZUxTTGZOZHN4bTB2QjFB?=
 =?utf-8?B?QSt3ZkVmdmtmQUlxVFBHQm14U1FRM2orRHc0QXFnbUYzQmdJSFpiYnRLZWY3?=
 =?utf-8?B?VG9LVmYvaEJ4cHhrOSt4YysvU3UrVkc3NlFmQStBZ1NNL3kzYmhFbkVlNmxx?=
 =?utf-8?B?ZFFXckZmYUJ0bjlUNGMvM1ZITm8rM3NzcXh6K1hrRGhxelo0eWtmQjgxL0tS?=
 =?utf-8?B?TmhpeDZyd2xHZzJ5cTQ4UDdDZDZhYmt5VkUyR2V6bGlqZlpKYlpxVlNOQUdR?=
 =?utf-8?B?dXhHd05SaU0rMHN6NXRZK0ZiNzRMSkwyUWN6SzlVeHh4TDlQSFFabGpVVnBD?=
 =?utf-8?B?VU5tRXdMcEpEd3YrNFhQYkdPTU9tQzBjejdHVHdNbGhubSsxeHdPbzluQmNq?=
 =?utf-8?B?R2ZCa2l1b0NuclNyN003d2ZhVElTN25tN1NmSG5ldlRKemxCbnR3M0xTdGlI?=
 =?utf-8?B?MUFXdktkVUFBbWRCK0hyekthR1dOSzh0OFFPUFlvcEc1Z2EvZ29pT2plakFF?=
 =?utf-8?B?YzRzZ05RVlJWb0c2OHBHZVJDQjV4QXpScHF5aGFFQitySjh2a2JMR0E1SzhF?=
 =?utf-8?B?ZkVyRm41MmVDTUZzckZmSE9taGRKZ1FSV3NIZEszNUdvNCtoaW5tQzUvbnFY?=
 =?utf-8?B?RndSbTNubzk3OWZqWVRDeSttR0hKRnlodytXZ2VZSnpjRWs2eCt2SkNRN0Ir?=
 =?utf-8?B?NlQwUEhra2k0WUl3M2dFLytRVUluMjA5bE0xcksvN3VFSWw4aCs2dUN5LzZ3?=
 =?utf-8?B?NUc1enR0c29tN1ZFWk5DYlB5TXRRUU5nMk93aUgwUGcveXJBSnlXa1hNTXB6?=
 =?utf-8?B?b1p4elprbWhHbkgyajdzbFlQNVh4RkdycVVtM25tL0ZXRUR2ZzRjSGpJTjNq?=
 =?utf-8?B?Qmh5ODVYQWF1RHpGeEQ4blVOdklWTE1VV1BlQnM1cEVvcGtDNU10dDNoWFlW?=
 =?utf-8?B?VXd1Z3B1WGQyakNScytEcVBveVdyd2EzYUhQZGNqQXpLaUxuSGthbDhRSXEz?=
 =?utf-8?B?R3k4K2V3MnlNeWxhcTZQeWY2Z2RXcklod2xEMWdId01PZjZ4dnI3QUZITGVh?=
 =?utf-8?B?YWV5bmlSL0tZcU96T2xEL2pkb3o4aHpxWWNQSzNpSFpmQ2VvYVV6MjhaajdV?=
 =?utf-8?B?QTMyY0xDaktwM3BEMnAzclhFWVQzdDNnclNMZkd5Y3N3dFNTZ05yVDl5dldz?=
 =?utf-8?B?REpwQVBQb2NMYjFJcHFyeW1rMjhpZHNHUGo1UVFLODdteitaaUUwYU9Ebktz?=
 =?utf-8?B?a1dveWN1S3F3c1NGa2NlZ1pldTBZYVB2dVpUK3JQNjdyejJoT1BYZU1HaVRk?=
 =?utf-8?B?blY2dEFNZ3llVG82WDNoRE41RGNOZGpKZ2xQQU9PaEQySjFUNzYyZnhoWSt3?=
 =?utf-8?B?TVdFajNwU3M0encySDIzdHRmaWI4V24zS1pKbzlWTDVwMFRUQlBia0twT2Ja?=
 =?utf-8?B?QWRLZ01HcGxPRTF5THQ3bkRiWk54ek9ra200dUg5dU1YaFdZalRFSjNFZWpE?=
 =?utf-8?B?c0QybU9jU2pLT0wzNUJzQW1kOVlwM2dEaU9nM0lxRk9CbkhEcDVacHFaNFNM?=
 =?utf-8?B?MGJ2RW9wWnlPYTQzS1BxZVBGaWlFYXhOUlErQjdKeVoyU0NIVHFZSGNYVjlI?=
 =?utf-8?B?MXVEMUhTYzJObHcwbWFwTTNGUW9mU0lBa2FQQW5IM1U3RlRtd21kaGpHSXVB?=
 =?utf-8?B?dTdiOWNQT1JIdGYxcWVrcHI3eWVzb3VxVkdtdmhWSy9oZTZvNXc0RXV3NjhL?=
 =?utf-8?B?T05yS1FTUU9QNTFQQkdYT1RZQWZWUlVyK0Uyd2JGK0wrRk5mRGhoNi9TZURn?=
 =?utf-8?Q?Vp2rr4cP8GR7gFIfLEEHNAm5U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f945af-22b0-4346-153e-08dcbda8fb1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 04:07:44.4457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLFtK3w2UsxqqBW5wGtnJVODAL/1SZcbjgGqIs7Vz9yQa28d9JPRMKAQpXzoQ7jc4p0HdcnGvyixIP/UpVwQVQ6CgUqSjkrScR4HEpxYXl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5510

SGkgS3J6aywNCg0KSSB3aWxsIHNlcGFyYXRlIGNsb2NrIHBhcnQgaW4gdGhlIHYzIHBhdGNoIGlu
dG8gUnlhbidzIGNsb2NrIHNlcmllcy4NCj4gPiAtLS0NCj4NCj4gU29ycnksIHRoYXQncyBub3Qg
YWNjZXB0YWJsZS4gVGhpcyBkb2VzIG5vdCBoYXZlIGV2ZW4gU29CLg0KQWdyZWUuDQoNCj4NCj4g
QWxsIHByZXZpb3VzIGNvbW1lbnRzIGFwcGx5Lg0KQWdyZWUuDQoNCj4NCj4gQmVzdCByZWdhcmRz
LA0KPiBLcnp5c3p0b2YNCg0KLS0NCkJlc3QgUmVnYXJkcywNCktldmluLkNoZW4NCioqKioqKioq
KioqKiogRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioqKg0K
5YWN6LKs6IGy5piOOg0K5pys5L+h5Lu2KOaIluWFtumZhOS7tinlj6/og73ljIXlkKvmqZ/lr4bo
s4foqIrvvIzkuKblj5fms5Xlvovkv53orbfjgILlpoIg5Y+w56uv6Z2e5oyH5a6a5LmL5pS25Lu2
6ICF77yM6KuL5Lul6Zu75a2Q6YO15Lu26YCa55+l5pys6Zu75a2Q6YO15Lu25LmL55m86YCB6ICF
LCDkuKboq4vnq4vljbPliKrpmaTmnKzpm7vlrZDpg7Xku7blj4rlhbbpmYTku7blkozpirfmr4Dm
iYDmnInopIfljbDku7bjgILorJ3orJ3mgqjnmoTlkIjkvZwhDQoNCkRJU0NMQUlNRVI6DQpUaGlz
IG1lc3NhZ2UgKGFuZCBhbnkgYXR0YWNobWVudHMpIG1heSBjb250YWluIGxlZ2FsbHkgcHJpdmls
ZWdlZCBhbmQvb3Igb3RoZXIgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5b3UgaGF2ZSBy
ZWNlaXZlZCBpdCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5IGUt
bWFpbCBhbmQgaW1tZWRpYXRlbHkgZGVsZXRlIHRoZSBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50
cyB3aXRob3V0IGNvcHlpbmcgb3IgZGlzY2xvc2luZyB0aGUgY29udGVudHMuIFRoYW5rIHlvdS4N
Cg==

