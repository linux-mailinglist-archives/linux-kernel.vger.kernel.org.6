Return-Path: <linux-kernel+bounces-308235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D52CE965911
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FB91F22C36
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE69615B116;
	Fri, 30 Aug 2024 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Dr85gxHR"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671DE12F59C;
	Fri, 30 Aug 2024 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004237; cv=fail; b=ICc39LJLQ7ywIqsMfc9tCdyTZiRP0fZ7Xnt7kBA83wjr5q6E5+wEW2eHNv9OuwgvYOQAHWG1CCrgxntg6MwSFQdt2yvqt+Nb8xkS6xNdAWW1m0cNiyv6N2/2a7+klOMGW3RGLsRGiZT9gfoI93NuNwNIuk7zN8yZn3xt/gWPKX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004237; c=relaxed/simple;
	bh=FaGkCgJl9xSXnthGc7nox8fyykczlsaaavMXKZ9razU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NgO+fQZamI13DTeTVWGDuCicIZYJJq620XUYZc2qe8y23PZyPIZ0Kx+5mg9uja4RhU5XUBCBqzUbH1Rj0tzvWH9YXN9gKsRMC3UMKvdewQCeN135UxIp/OSosnjW3rU3o23yjCh6Rb5gOyW7P9FZf1ZetfER8l2MwT+jKosq14k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Dr85gxHR; arc=fail smtp.client-ip=40.107.255.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXvDZ6z5eG5NUIStOtpNUgEXYifBbK5+q/fzlODtc6x/9LGWwnwAKVyUEhxgmJ9Zsyb/g/Qdtvs/+dyFgTI5VLXjJi49+YjAaqhATaRx+nv+rjch4vjJ1Z8TgNiguD1JjaT4E2aCuZYkM7QpWs564yhYKv2T24c7mvFIXYP5b1LBEPHTnuWJ22n3whAEgU9adUt20eyVxh6Wy/h6wwfzV+t7ZOzXzMNxWv4ROPukm1bIWn1k1axMgk9qgHAAabHV7fkUdfkZbaWBOiBBbLXD3DFj3diDaTLvk5MeqG0MpxXj53SpRsfWxrKNQnYV71EvC3NVNmbbsEZ/n3REeP1uGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaGkCgJl9xSXnthGc7nox8fyykczlsaaavMXKZ9razU=;
 b=LTBKOIFqissoerygkHJvIw3KZKFRhgylLZ8Hsa47LF0EFRu4PNbBMhN3Vtih71kxzf8st/DLFhH/IxEyCp65vvb8HqfsEg0QH8DMXaVYuYNYE/3r4bXD+7C1RVBidLg0b1Y4mkhi7gyEHpTaqVqTbWY9siHLfBhWU4LlsvEJgglSphlO+MBlBv5BgOQax2bGFuIwLaeG43CjR4cpsqsHldO2f0p1NedfsXakHy5P2m9L+WA5W36jIjp8YSFRu9aTmmQXJMkcM8qSiCPf3h3pIyweVXIl7/gUWSCG39+TTWIstSaCHCUURM9UTIDuRwaIA2oEQjl/1f5OTFTeasu1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaGkCgJl9xSXnthGc7nox8fyykczlsaaavMXKZ9razU=;
 b=Dr85gxHRJrnWF3ebwA+QUWiEt8lKptT0icw+YPlyUU1k1ANQ2YpO1htbu2XSTBhIGvBJOwLLQN2zslQRzJ1xmJLzq+kjv9vc1T2XwFMMFoKnDEqJ/uLsWUlRAons4ltMnzfZ00DA9LTqs0bOoK74Z78wfO5UPBqc2unmPUFhDdZLLnUsarNB/HFIfY55QksWRLr9fJWJ5ts/07sIuckF4JIushYzDiaU/Y4aV39k7V0isoCQzI+mBGdizPkJU+NwzSzWGgFyd2Jxc3iZ6M1Jn+DMQbOXTJQ0gSd66ytkbPeNCPZV3Wb+ondNMT6/nXI2dUq7QqxroljG7AuQUv2Ezw==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYZPR06MB6747.apcprd06.prod.outlook.com (2603:1096:400:45d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 30 Aug
 2024 07:50:22 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 07:50:21 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Stephen Boyd <sboyd@kernel.org>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
Thread-Topic: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
Thread-Index: AQHa+RNp/f6Zl0wHLUuBnq05ailKU7I9A24AgABp7FCAARhngIAA6eUw
Date: Fri, 30 Aug 2024 07:50:21 +0000
Message-ID:
 <OS8PR06MB7541BFDC6D2E490ECDAE085CF2972@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240828062740.1614744-1-ryan_chen@aspeedtech.com>
 <20240828062740.1614744-4-ryan_chen@aspeedtech.com>
 <61c8234139fcd2b27610ef18e9d9fbf7.sboyd@kernel.org>
 <OS8PR06MB7541F12972412AE565A93287F2962@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <3569ef6d81adc41330c4002752ba3aa9.sboyd@kernel.org>
In-Reply-To: <3569ef6d81adc41330c4002752ba3aa9.sboyd@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYZPR06MB6747:EE_
x-ms-office365-filtering-correlation-id: e5b8d83a-c4a7-4183-b970-08dcc8c86687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVdZR3ZVZHNidWxwbkZWcU8zZ2NnTzE0WmdqMEkyY1BON2tmQzFCNWlnaXZl?=
 =?utf-8?B?Vk4rNnRQZkV5bnhuckNGUjhNRkFxOEkrN3oydTcyV1pqVUxWdmNudXYrejdx?=
 =?utf-8?B?ZjBXTUI2UTk0Q1FETTNhQWllNGliejhiUDhWUi8rZlJ2RlhHdUNETlRwMno2?=
 =?utf-8?B?c1NYMWNqdmZlOTdCRjFDUHVzdDhFdXEvMy9qNDBDUC9yUXZ5SUFZMTJKM2sw?=
 =?utf-8?B?M0k1UmNpSDYxeXlKd2xVc2NNaEhJZURVckdEVExUblFhRi9sZkJRTjN3akk3?=
 =?utf-8?B?Y0lRM0gzTWFEOUJoTTBLcU95dHJoYXd1UE1ENkI3RGVISW4xeTQwc25wTDVm?=
 =?utf-8?B?MVRpVFdhbUw1dnlhdnZ3Wm1tYm9nTlRxdWMyMUI0T3ZvQWxNZStxZlFlNVc5?=
 =?utf-8?B?bTlaWEZmR3BLZjBhdVpWeEprMC9nalB4N0g5QitmUmZ4VXFxOWVBbXpTaVpm?=
 =?utf-8?B?RER3QUhWQ3RCTHprVjMrd0hXV0pBOGlOYnRLMmNqdTJ4UkVhd3NLZlM2ZFlp?=
 =?utf-8?B?RG9DNGtJL1M2bGdJT2hiSEgxM01IeHVvUXlDWXczNDhFYUFJbHlkV3FNNXd2?=
 =?utf-8?B?SHhQVGszdFAwYTJNM2NOWnhOWDMrZDhpc1E5bmNDSzdJbG5NRDZyL3NySHhj?=
 =?utf-8?B?cTdPcnNmM0IzUTRiWnRRcVVBZUJvQjZzdmQwRGpmQ3RvWUlJUENlRjFlc0J4?=
 =?utf-8?B?N2NsNmdsRk1ocjVOWlk1UDRlSU5PLzFJcVNtRTEwa2JCTVNVUEdlMml2TTdi?=
 =?utf-8?B?c1VGaVdodmd1K3J2NStTR252bk93TnhyWlhyajNuUXhqM1YyWTladTVXR1lB?=
 =?utf-8?B?cHJYRmxzQmJJbnQzMnhQVGlLSncxd2dhNzNVckc2d21BdVZydk0xSC9ZMUs3?=
 =?utf-8?B?aEVSbnRpMTlZT2UrVmY1c3hGN25EQUxtemE1OUV2UlROUUNyRFZyTHdvbzJh?=
 =?utf-8?B?Z1A5dzlCOVhrMlVxZlo1OEVBMGloMG9JV2pxUDl0bWpvNThhWXl4S28vVzRD?=
 =?utf-8?B?WnhpU01qWGVlc3k1ZTU3RTBvYThnODMrTC8yN2tYR1RhQUpDa0w0WkFtb0VN?=
 =?utf-8?B?bzRMeldQMUtKbGh1TnpIbWkvdTdWVWRkNDNOSlRFUkZiUzhDelRHVTZ2Y2ZZ?=
 =?utf-8?B?Zk5NYzdLalZRVUdVK0l3YXNBZ1YwdG9iUnBxMHFsaHpxSVZyNm1IWWg2SHo3?=
 =?utf-8?B?bGtJQXpXUklDOFFXQVI3OWJFVVVxcHZPWHBxenZjMXVYTzZrTjBzOEdaTkRI?=
 =?utf-8?B?eWc4WW5ubm5za25KbmZWdGRZWUZGTkZ0Yk5wNzdsaVpOYkttcjJpQ2V3TW0z?=
 =?utf-8?B?WnBidk1JclBwUlYzeVB1d2pIWkpYZVdOeDhMTVRlcW5EVTVXSEE2Ujh6U2Nq?=
 =?utf-8?B?WHlnaW1SVFM3bjBKR2RRcnRrNittcjBWZ1JEMmNTNzh0VHZYdzcya1pWeVZB?=
 =?utf-8?B?cEdWaFVWbmhneHdsVGt6YUJ3eFJRcWFQY25kdmREYndla3pyTTJFbEJlK0Zk?=
 =?utf-8?B?eWdPb3doWmZ3S0J1bDBHMnNoVnFnZGdXUk5EcEoxdFBESTFZZHJZbnJ3cGVR?=
 =?utf-8?B?YlIzd05GblNzMW9hTjh1bGdBWUdwR05qTHU1NUlMbWgzRjU3ZzR3SjdTUjhm?=
 =?utf-8?B?ZGZaeEgrdFFzMnZTRm5adXo1UENjYmsyZXJ0WjdFanhuUlBpbG16dmFXTVp1?=
 =?utf-8?B?R2JkOXJGMHI5UUFOTzBJZWp0ZnZjdmdrUU5SNmZTTFNNMUFxT3JoeW1TdjJB?=
 =?utf-8?B?akRSTCs2YWNxZDAvL1ZBUTVzUGhNUE1qa21WVW9mdHpvNlNJOXA5KzdjcWFx?=
 =?utf-8?B?a3lteGVKYjVkUVVsMWNtWGd5cDhidU1RdHJCWXZBMGZqVDIvT3l3OWUvWU9j?=
 =?utf-8?B?OG84aThhNno3T3NhTVlGYmNDeGFZMk1EM3dNcm1GS25MWkFab2tJQmdvV2N6?=
 =?utf-8?Q?oJp+N+zHTo8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEwyUG9sQUxTMjlneTZHOEpxdjVlWmtSd3BoODlSMEVNdjVLa200cmZjRmdF?=
 =?utf-8?B?RG02c3NNckt1a3kxb3BtUU9rbk9GcUdvRDJZQllLMVBoaWZIcTRGYUpNMEIv?=
 =?utf-8?B?Z2dyTElROFNlNGJtdHkrNnlLNmdBNkxESmtOTEM3SllCL0NHSE1XaXhJbHF1?=
 =?utf-8?B?cTNmWTc5MTMwR1daSk4zUnMxKzdNeldtcUhUUCt1eEltU29nSjFVUWRPL1Fu?=
 =?utf-8?B?THRRSktjaXNSVTljS29Ma0YwUVNPU1hsUjhIaTR2aUNUSGlDazhGWUxoRFpw?=
 =?utf-8?B?UmkrMldJbnFiTEo3cktwL0lRZVJQMVczWitJQlRuQ1ZsWHh1aDQ4VmdPRzdX?=
 =?utf-8?B?M0dQa2MyODdwdWM3SW1jWjVPYUVqcjBEWExhdzBCcmJJL1NVN2kvUlZiNVRD?=
 =?utf-8?B?dzJ2NkxRYXRBa1ByamxFR3dBMk5Za3M5NjFQam5iUHViWitWcGFHZm13enpH?=
 =?utf-8?B?dEJ6eFhtVVRxb09SNDBHdlhZZnhvRWFKQVJRSHFOVEcxcG5YZnUxMzdZcDdt?=
 =?utf-8?B?c0JWamxjL1JJdVNOYTdnMnRCR3RVN3NJZ1hLZmppcXcvQ0NVRFljVXc2d0cv?=
 =?utf-8?B?Wjl3R3JMbW9FTE4rTmRydzNhd3JRdnp4NGJsWlJWTTBYRmdDbEZKN0FaRkx2?=
 =?utf-8?B?U0RzTlJ0YndaM1JNRmpxTFlzVnRQaVpuMGhwMXl5N0N0dCt4ekx5eFkvb3JX?=
 =?utf-8?B?YVVSdnNOT1FhU1BGdm1FWkpvT3ROKzR0SDdFVkpGc1hUWFdKSmFvL3VLY1Rv?=
 =?utf-8?B?eDdvVzYzeUdiaEgzVXpFUnB2YWJmMmhKVnhNRVlDTVhNY3diUTNwOXBIa1Bu?=
 =?utf-8?B?YW5iYTVGTGpoZzlVdUxyMWFMNGsxTkJDeE43TThGSFJKZmxvOVdYY25iVGdC?=
 =?utf-8?B?UnBiMU1nMnpGRU5icDNHYnhLWjBtcDBoWnQxOUt4N3ExVFlWQXI1Zi9RQTNj?=
 =?utf-8?B?cEhFZHBUaTQ2TVlvYUhxNnB3bEhtdWtldWJWMmJxRGdiNGVWaWhBZVliUWZK?=
 =?utf-8?B?Q0s3aWd6Y3dpUEpKTzVZbHc0cmszSGlSVTY4WEpSZ2g0NXpoaEIzTWovNGJT?=
 =?utf-8?B?QVBPS3c2bU9vWFFPY3c4QjJlYU1LZElYNGhjc2tCRkVCb29Pblpsemt1eGJl?=
 =?utf-8?B?bTViQzRCVnQrNktCNG50NWFCSzRvVk1henp6Lzh3c1pCRDNpUWFHV3RtSlBG?=
 =?utf-8?B?dDJFOEk1dGN0UkhreENUUFluSU5CSnhZNUVKQjJPZ2NiZlVVNGpIaUdSVE5X?=
 =?utf-8?B?WDlyajBiMVZPS05pNVUva24xNmxONC9lM0FDdkdWMjZUczUrTGI0YXRyaVpE?=
 =?utf-8?B?QzRZQ1hwSWdxWXk1ZzF0c3paVWFNMDVwTWpWd3Bjdmx4NDgxaituNFhhOWpr?=
 =?utf-8?B?ZURwRFlMbTFTK2VVZ2VDVkphVmhGbGdHL0xPV3BxT0paQzR0VHAvRExKNXQ0?=
 =?utf-8?B?VisyUHFZY0dkVXl1U1JDWW9FakdvV1ZDV3ZFa2hsbUw5a0FuR2ZwSm95NzRR?=
 =?utf-8?B?RERldmkvSVdneXphNjBSVUZnQnBaM2FFRmFteEMrVDRDekNieXkxOGVqcTdU?=
 =?utf-8?B?L1BaUVpUVW9NVVdVOENYMmpZOFBFWTUyRk1vUkliWG4rblFCSkU4Ymk1R0Jx?=
 =?utf-8?B?ZUtKZG1CeFJQNUJablVEbHNSUWVuTmE2V1VxK1pHeWs1Um05UjhiV2RBMjVs?=
 =?utf-8?B?Y05INWJYT25XZ2JnVnJXV1gzSyt4MHhDWjU3WWt4SlpVcHlnQSs4Vi9GV1VP?=
 =?utf-8?B?YmNGb2dBZkFWZkNxR2xZOEFaUUNEbzRZcFcwbzcyeXIwRXh1NVJJeUE0bldD?=
 =?utf-8?B?ZWY3R0JNZW1QWFVPUkx6ZU4xWDJKN1RHUDRUbG85ZGlKek9zVnN3emFNeGlV?=
 =?utf-8?B?OTV4R2hoaVpNZnpQbVRzZytCZ3lnUFF5OWUxTDJETGh6cFRUSnhyOGZsSlJG?=
 =?utf-8?B?ZEZya1hOcXpob1ZSUzVCbmZTVjBFMGl3Q3k5RUtMdWdqMng2Wlk5VnRYcXVD?=
 =?utf-8?B?M21XSjB2ME5RMTlmcmpneWUwM0RydHBaZ3dIb3hTYUNJZHBDdWE5TFM4WmpR?=
 =?utf-8?B?RXM3ZWUrVzFSOFJMOEVPd0hVRnhJSzl1aEM1d3dwYW1hUXN2Z3RrcWRKemp5?=
 =?utf-8?Q?Ay35KRcojwOYmQBH9ZuOZhsmS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b8d83a-c4a7-4183-b970-08dcc8c86687
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 07:50:21.8866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jDN2oCSdVMpjHTsrUfRmZW27bq+IF1chcuVGj4JtEL4dCPouAibD+WAAPwoQ+5SJ9jmbwWtjAB1O8jXMPVPMmIGmFBSajzBuB0vXfK8fb+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6747

PiBTdWJqZWN0OiBSRTogW1BBVENIIHYyIDMvM10gY2xrOiBhc3BlZWQ6IGFkZCBBU1QyNzAwIGNs
ayBkcml2ZXINCj4gDQo+IFF1b3RpbmcgUnlhbiBDaGVuICgyMDI0LTA4LTI5IDAwOjA5OjEyKQ0K
PiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzNdIGNsazogYXNwZWVkOiBhZGQgQVNUMjcw
MCBjbGsgZHJpdmVyDQo+ID4gPg0KPiA+ID4gUXVvdGluZyBSeWFuIENoZW4gKDIwMjQtMDgtMjcg
MjM6Mjc6NDApDQo+ID4gPiA+IGEvZHJpdmVycy9jbGsvY2xrLWFzdDI3MDAuYyBiL2RyaXZlcnMv
Y2xrL2Nsay1hc3QyNzAwLmMgbmV3IGZpbGUNCj4gPiA+ID4gbW9kZQ0KPiA+ID4gPiAxMDA2NDQg
aW5kZXggMDAwMDAwMDAwMDAwLi43ZTA0NjZlNzM5ODANCj4gPiA+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ID4gPiArKysgYi9kcml2ZXJzL2Nsay9jbGstYXN0MjcwMC5jDQo+ID4gPiA+IEBAIC0wLDAg
KzEsMTE5OCBAQA0KPiA+ID4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAN
Cj4gPiA+ID4gKy8qDQo+ID4gPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjQgQVNQRUVEIFRlY2hu
b2xvZ3kgSW5jLg0KPiA+ID4gPiArICogQXV0aG9yOiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3Bl
ZWR0ZWNoLmNvbT4gICovDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9iaXRz
Lmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvY2xrLXByb3ZpZGVyLmg+DQo+ID4gPiBbLi4u
XQ0KPiA+ID4gPiArDQo+ID4gPiA+ICtzdHJ1Y3QgYXN0MjcwMF9yZXNldCB7DQo+ID4gPiA+ICsg
ICAgICAgdm9pZCBfX2lvbWVtICpiYXNlOw0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBhc3QyNzAw
X3Jlc2V0X3NpZ25hbCBjb25zdCAqc2lnbmFsOw0KPiA+ID4gPiArICAgICAgIHN0cnVjdCByZXNl
dF9jb250cm9sbGVyX2RldiByY2RldjsgfTsNCj4gPiA+DQo+ID4gPiBQbGVhc2UgbW92ZSB0aGUg
cmVzZXQgY29udHJvbGxlciB0byB0aGUgZHJpdmVycy9yZXNldCBkaXJlY3RvcnkgYnkNCj4gPiA+
IG1lYW5zIG9mIHVzaW5nIGFuIGF1eGlsaWFyeSBkZXZpY2UuIFRoZXJlIGFyZSBzb21lIGV4aXN0
aW5nIGV4YW1wbGVzDQo+ID4gPiBpbiB0aGVyZSBpZiB5b3UgZ3JlcCBmb3IgYXV4aWxpYXJ5X2Rl
dmljZSBpbiBkcml2ZXJzL3Jlc2V0IHRvIGhlbHAgZ3VpZGUuDQo+ID4NCj4gPiBEbyB5b3UgbWVh
biB0byBoYXZlIGFub3RoZXIgcmVzZXQgY29udHJvbGxlciBkcml2ZXI/DQo+ID4gSWYgeWVzLCBJ
IG1heSBuZWVkIHN5c2NvbiBmb3IgcmVtYXAgdHdvIGRyaXZlcnMuDQo+IA0KPiBZZXMuIEEgc3lz
Y29uIGlzIG5vdCBuZWNlc3NhcnkgdG8gZG8gdGhhdC4NClRoYW5rcyBmb3IgcG9pbnQgb3V0IGF1
eGlsaWFyeSBkZXZpY2UuDQpTaW5jZSBvdXIgU29DIHJlc2V0IGFuZCBjbG9jayBzaGFyZSB0aGUg
c2FtZSByZWdpc3RlciByZWdpb24uDQpZb3VyIHJlY29tbWVuZCB3aWxsIHVzZSBjbGsgYXV4aWxp
YXJ5X2RldmljZV9hZGQgZm9yIHJlc2V0IGRyaXZlciBhbSBJIHJpZ2h0Pw0KPiANCj4gPiA+DQo+
ID4gPiA+ICsNCj4gPiA+ID4gKyNkZWZpbmUgdG9fcmNfZGF0YShwKSBjb250YWluZXJfb2YocCwg
c3RydWN0IGFzdDI3MDBfcmVzZXQsDQo+ID4gPiA+ICtyY2RldikNCj4gPiA+ID4gKw0KPiA+ID4g
Wy4uLl0NCj4gPiA+ID4gKw0KPiA+ID4gPiArc3RhdGljIGludCBhc3QyNzAwX3NvYzBfY2xrX2lu
aXQoc3RydWN0IGRldmljZV9ub2RlICpzb2MwX25vZGUpIHsNCj4gPiA+ID4gKyAgICAgICBzdHJ1
Y3QgY2xrX2h3X29uZWNlbGxfZGF0YSAqY2xrX2RhdGE7DQo+ID4gPiA+ICsgICAgICAgdm9pZCBf
X2lvbWVtICpjbGtfYmFzZTsNCj4gPiA+IFsuLi5dDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsIGNsa19iYXNlICsNCj4gPiA+IFNDVTBfQ0xL
X1NUT1AsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDI4LCAwLA0KPiA+ID4gPiArICZhc3QyNzAwX2Nsa19sb2NrKTsNCj4gPiA+ID4gKw0KPiA+
ID4gPiArICAgICAgIG9mX2Nsa19hZGRfaHdfcHJvdmlkZXIoc29jMF9ub2RlLCBvZl9jbGtfaHdf
b25lY2VsbF9nZXQsDQo+ID4gPiA+ICsgY2xrX2RhdGEpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsg
ICAgICAgcmV0dXJuIDA7DQo+ID4gPiA+ICt9Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICtDTEtfT0Zf
REVDTEFSRV9EUklWRVIoYXN0MjcwMF9zb2MwLCAiYXNwZWVkLGFzdDI3MDAtc2N1MCIsDQo+ID4g
PiA+ICthc3QyNzAwX3NvYzBfY2xrX2luaXQpOyBDTEtfT0ZfREVDTEFSRV9EUklWRVIoYXN0Mjcw
MF9zb2MxLA0KPiA+ID4gPiArImFzcGVlZCxhc3QyNzAwLXNjdTEiLCBhc3QyNzAwX3NvYzFfY2xr
X2luaXQpOw0KPiA+ID4NCj4gPiA+IFdoeSBjYW4ndCB0aGlzIGJlIGEgcGxhdGZvcm0gZHJpdmVy
Pw0KPiA+IER1ZSB0byBjbGsgYW5kIHJlc2V0IHdpbGwgYmUgdGhlIGZpcnN0IGRyaXZlciBpbiBj
b3JlLg0KPiA+IERvIHlvdSB0aGluayBhbGwgZHJpdmVycyBzaG91bGQgYmUgcGxhdGZvcm0gZHJp
dmVyPw0KPiANCj4gWWVzIGFsbCBkcml2ZXJzIHNob3VsZCBiZSBhIHBsYXRmb3JtIGRyaXZlci4N
Cg==

