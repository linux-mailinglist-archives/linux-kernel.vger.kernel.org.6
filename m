Return-Path: <linux-kernel+bounces-288938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C03954070
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EFE289185
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8576B146591;
	Fri, 16 Aug 2024 04:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Qjq05kMy"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8217DA8B;
	Fri, 16 Aug 2024 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781214; cv=fail; b=HwSYdl0VBP2/Q7rB7dyCRvhV18wIax1fA6JELe3uG8o0Pr5aDVsLIXwzd+nQPcanZJ0n/OvfxYf/LeShXE9D0zfxJvc2OqjGsQKmuOAl5x4QeuWh4ovITw40QzInDz2NH/pmBH50dOdnkqyNuWCiTUNtOZOWqt0xXU4PeUk7yLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781214; c=relaxed/simple;
	bh=3yX6/WZwBa0W5WEjMPtxbVYxfzZU24Rp0G4ErxmVOdc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QLM7L2NZ2WYz/Pswt58EatVYgC9/fOWEVV64z7TCgZb588duQEQFr1+usZrC3elkbqXz6gdrhXAHXSdvb5fLQwMPDZDqvyjXqWorDcSvKQM1vzXv3mYNkE1uUzELSi56MODvD2w2Oe2BM8QOpgRSJFyoIoFPnd9ujWYGx2KX8tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Qjq05kMy; arc=fail smtp.client-ip=40.107.215.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5gJc7FPjzXMqzHuo8ggmxMAA5HNu2W6KHqhVk0uUUQHL2ZkJ+Y1X/jmeIHfcrRe5C4nSoqI0BQkVi8wT/vqHh4jpbHeCoGO4VM7sR2aPXhjeApRSHcF00z91KvMpk+jr2cuki+5ACwAsyzhYnd40qvPLP5HYC5g9STbSocCzrS0KtgWquGXfWJoay8Eu0AjCKRutRx60ZeJ008Rhu9ZFOMZ7cHJflrkc8GLEaqy3EkylHAlGDtshdyYbvRc8Hvb6qpRfZtJ8v4V7AiVO3cF3h9dEYNFaLfTLxf1F63ayXydbu0CakaDw5PfTs32Hx4fe+Wp0AD3txyEj62pMXOCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yX6/WZwBa0W5WEjMPtxbVYxfzZU24Rp0G4ErxmVOdc=;
 b=Km/P7U+C0CP4jslZnNmXadGSGJ2W3HGXyh6De47fRd5mXRscFcD5mu/SdjrWZIuVNAgaxSgzx1SjgQkbZ29YY1nxjfB4fL3o69JIOg60vpRQkguiovKghx5Bv9WALS1ivmIQjq4qSQfVCrdhdSpOFkoWwQHr8XoBM/fBHd/5H2S7i/1W8gilTo03mW6cscUkgJtPmYaHaQsRuVHEX/Evrhdcf/ZktgK9tJA4b1UD5yFj5FhkNP5jXGVk9pbo/se6PE/NTrQqkRqjx3O1T+gVySbMEVzmRHKdHCuWW9r6ISucDBfUVCktoW9ngjvB27ve4QJ2pV/5T/9RG0ufeZty4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yX6/WZwBa0W5WEjMPtxbVYxfzZU24Rp0G4ErxmVOdc=;
 b=Qjq05kMyeDrAJ1lsK3V7LZozAI8uuIFJCbQGlL3VZeZF3Ouxl9t/uBsuGXDZocIjQihAdDx+2LFMxm9UUHMdKn0qMqFuYjE6RlUDRNAhCbZUM2W0XFww4yHaWadM/0C9qL7zsJHrijTkab7kMrBG+cTKsrCSKwG9j29B0T5NcsaTeiHi1t7oXHdbhJEc9oZTvq1QMBfM/vAMYGByoTqDa0gh6B/9TRR+io4RoS5pG1JkaiQvR5uccHunCFD8AG6tS95BedYCWqa43XDpgpaVwzN1ue0tEbR2VVbylLCwKvZxt+j7m1r0gVRL7wuboZV3KIqqxRCN67MYzy8vxFmFrQ==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by KL1PR0601MB5510.apcprd06.prod.outlook.com (2603:1096:820:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 04:06:48 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%7]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 04:06:48 +0000
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
Subject: RE: [PATCH v1 01/10] dt-binding: mfd: aspeed,ast2x00-scu: Add binding
 for ASPEED AST2700 SCU
Thread-Topic: [PATCH v1 01/10] dt-binding: mfd: aspeed,ast2x00-scu: Add
 binding for ASPEED AST2700 SCU
Thread-Index: AQHa30uG4RfiWECZjUKlZ41AVxAy57II2jIAgCBt0fA=
Date: Fri, 16 Aug 2024 04:06:48 +0000
Message-ID:
 <PSAPR06MB4949851D669EB456677AFC3A89812@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-2-kevin_chen@aspeedtech.com>
 <e6cb6f26-fef2-49bc-ab25-fdc9a659f593@kernel.org>
In-Reply-To: <e6cb6f26-fef2-49bc-ab25-fdc9a659f593@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|KL1PR0601MB5510:EE_
x-ms-office365-filtering-correlation-id: e7a90690-2924-41d8-eca6-08dcbda8d9f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?YnJoTE9KUG5QdnBvNis4ZG8vNE1JQlA3SjF1T2R3bUJaOWpvR2I5U0VmZFFx?=
 =?utf-8?B?aTd6a3dSSWdqNU1Wc1ZCZTl4OFpNTHlLc3l5ZlgyOXVxNnlJN08rNTBIUTBz?=
 =?utf-8?B?NTRTTTdRN1NObTJWUVErUTF3cmkydlVKYnBZZTRnVU5aNjdCZUJIQURNY3V4?=
 =?utf-8?B?UkhxRTU0aEZ1MTlLek5CL2ZZRXNrS0J0QzFZSDlkbk56b1pCNi9VNSsrR1Ux?=
 =?utf-8?B?QzdkbW1MM3dscFY5NGIrZmY1cXdCcXl1S3JoK09tSzk5bnZiNktBL1VtYzB3?=
 =?utf-8?B?VjNTMHUrVjBIR0lRQjg4bS9LRFJHSjY5TXVDOWIwZm9XRUtXSzEzbDZtaTg0?=
 =?utf-8?B?V1JhakZDOWhZYzFGWXpPUzhJbXJhUExPaW1jRnRiSlJSTWQ4MVhaKzZ2emRx?=
 =?utf-8?B?VHAyUkhVVWh3a1JubkZ2NFBUZDZ5UTIvRnRrZE52TDNYVnNqb2ovQm1wLzBa?=
 =?utf-8?B?cFdJSjJrL1RRVEpTaldZc2FwRVk5eXloNmRhaHJnbXhXOWhrOXFKU0dOdHlq?=
 =?utf-8?B?ejZyOG00WURKT2lKc0pzaUgrNk1mMndIK1lIUFRLVENkT2k1cENEU3VpeVVP?=
 =?utf-8?B?eEEwanZsZXFoZ3huaFB0VmFXZ3BObUhBZlVYWm9hZ0VjRS8xWVNtK1VVWlI1?=
 =?utf-8?B?cGU5NTM0OE9iNjllVGtIajd3SjdZaEtqUmgvQ1FDVmdrTFFqSDZaczhUb0ht?=
 =?utf-8?B?QjVXaWZWRTZJeUEvOE1kYUJ1WWR3QW15bVBFZXNuY2ZST1RoNnE5RGE3YWVI?=
 =?utf-8?B?K3l6M1hLc1VNcWpkSjZZU2NNYnNLUDMzTWhxMEMvU3lObGFRR3JNanA4RUZ6?=
 =?utf-8?B?eTRxUTJZVkxiMXlMdFJOYjQzWG43bVZacC9TdzVGeVVESWppN3NBUXVUZVpM?=
 =?utf-8?B?UDFJc3hlbHVZZnBFMmVuNTJvNVpEd25WUHBTUURtbDRGbEFZQndKdVd1cEhP?=
 =?utf-8?B?bDk2K2prM1Nia2o3dHZSZFVtRjllNlU4Q2lTMmF4YUlWOSs4M1hmQUs1citC?=
 =?utf-8?B?dWM4TFFhZmREN0NLWDVvcHplNDJnbkQ3eGEzcW80Q1dvY2J5NTU5U0NjMXZk?=
 =?utf-8?B?R3hTbXp1WWsrZWh1c2NLZTFDT2RsY1A0TmpseDZqZlExTU9VRlZCb0tLbUtm?=
 =?utf-8?B?TTZlZmJ0S3ZPNEljYUxtOFpiUzRzVGoxOEVpcXh3UDVRWnh5bnNTRys4MVRP?=
 =?utf-8?B?Snh2UkJTcTN4eThJVVNQRFlyRitXUlpIMWg1bm1VNmNaTFFzcWxSZlpEbXll?=
 =?utf-8?B?OUFzRUtFWkZiRDl6RDN4YkdPb244d29rWmpYczB2a25TdmpYeFljWnVlUXA4?=
 =?utf-8?B?SHRkUk5MQjUweENaT2QwbkxweW5hclE3ZjY0YlZoZEJ5d1BhRU00MGxmNCtn?=
 =?utf-8?B?NmFSVnA3UXQxV1lpbkxkc2dBNlhKc3M2NXoyaGd2ZVVocXBldndwVTdWWmxQ?=
 =?utf-8?B?RVE1aytGOC9PaEE4dlhwTHRzTXI0R0NxTFJXUkt4dzR0Unp6aUw1SGtoSDVk?=
 =?utf-8?B?NWo3dVF0eUEzTUE5SENXWTZEcm5TTlQreDE4YW9MOTJDc1NOVUlLMnBSTkVa?=
 =?utf-8?B?SkxMYUR3REFEajdYNHFuUTdIcWJzTEVlRm55dlg1Y2JFVnNhZWtRVXlCTFps?=
 =?utf-8?B?OC9HUU42YTB2ajBhdTJRME5CVVpNZDYxbk83cDNGZzZ2Q25OL3docnkwU2JW?=
 =?utf-8?B?N3BjMVpQVms2U3hmNURaYzN3d21ENFMxeG5BTWJJVVhmTHA2akthZTFRSzJi?=
 =?utf-8?B?MzdzMTBNWTJzNlR5T1FEZEMxdS84V1ZvZEJhMXBFNmJ1V0RPU0NkZGdqWSt1?=
 =?utf-8?Q?eqGh7mxOKOqn1Baa+HF+qR5hyAbjATQ0OwHBk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGZaL1VwcmRxSWlzenRDaW5BQ0s1R1dKUE5vdC9lWndwLzk1Q0xGeGtaSStW?=
 =?utf-8?B?YmgwaGVUdjEvUTJkbTJyd1d5N29GVkExRTlFVGRoaVhjNUU5dUxoWkZhVllU?=
 =?utf-8?B?VmJuc1U3N1REemljWWl0eEFEODE0Vy9ieUdjWnlNTm9ydkgvNnhEeE5LRTFK?=
 =?utf-8?B?NHNIdjRpaC91YXJOUWhqUmdSTnBDZzdkeEd3QlpPbUF6NDdqK29wTWVsclhX?=
 =?utf-8?B?SUp2eXNQTzdTbVc3ZHlZeFJaMDRDMmw1cW94Q241aElyeHF5UkNwTGUxOUxa?=
 =?utf-8?B?dGRIWUJneGFrSTZtRjNzTG04cXhCcTExcnpqTjJXcDQzaFVFRHJwc3RNRUk0?=
 =?utf-8?B?M3RiL2xiaTVXdWFrTVVkRzM3b0NVNFFVNkdyd25wTjdZNmRVWGM3NlMreFlR?=
 =?utf-8?B?MUJ0Rm1SelZEanU0ejVhSTFCb0hCNFBIRE5EUW12KzBFTG9zK0hJdDJsdnlW?=
 =?utf-8?B?ZVF5czJkbnhyK1Y0aXdNRm80QTVsUXBhc3ZIVm5LK0o2R1V0eW8rWVh1dmQv?=
 =?utf-8?B?NFhhZHAwNExZWnNOVlV4aVJGWEpCMmJyRjlQeTk1bkNXTnVhOGpUYWtmemV5?=
 =?utf-8?B?R0hmUEgrRnBDaEQ3MFZrSHNHWFRTUHBOTUhUUVI5Wm1wck5EVkk2QW1wMnJp?=
 =?utf-8?B?eTNLb1piOFZ1N0c0RWg4MWx0cWZJV1dHelBhMERyeDVVakRPVy8ycnZRYjRR?=
 =?utf-8?B?YlhIZ3pueFBzRzNIdUpiYlZ4NjNnWm5MQVdjWEtlWkZGRkpIb1dnR1BFTTFC?=
 =?utf-8?B?bGt2RE5FSjdRUHlSd3R4RkRPSnlQQ1BDL01qcWpwVWlidGNRejlMV1V5SEJ4?=
 =?utf-8?B?S1dQalJYSDQrcDVIMmFKRjhhelVqcmdkY2hKQldoU2dPT0RNYXNqdkE1Rllv?=
 =?utf-8?B?c1JDOGdZcnZkVFJQSDF6a3FVWFNKOTFoR0h6YXZvUitqRGYvWERTOW1DTlVa?=
 =?utf-8?B?SmNCL0x6RnBBcnpJL2plUThjRTd2ZWpVZDZRWnRHTjQrblZncC9HNVEzS1My?=
 =?utf-8?B?Q1BzTzVwRmYzOVAyZ1ZKZWZTQnhzSVQ0SjNYa2UvQkxLWlZ3SG0rT3hiMyt6?=
 =?utf-8?B?Z1R0ZUdPUGZWQmtQZlZWN21RM3JERVozZURrNFJkbURFZWR2S2tqbHI3SFZq?=
 =?utf-8?B?VjkyUVJXamh6REtSRllhWnN1Z0VkK2VYd1g5WUJ0Tm9mWGUzcG1qc3lHaG1Y?=
 =?utf-8?B?NzZwZm82VEYwVGpJVkIrTG9VMzlpdEpYNTI5WUs2eHpuaERGTFRnWERuMmgr?=
 =?utf-8?B?M0Y3aUxxd3NUZFc2Qm8yMU5xYm1xWTRBQjBMUGRrYnRjMkNhYUhFZ1pNbFBk?=
 =?utf-8?B?YUFHUnJ6bmV6U1UwUnFqWU5QajNQeXBWSm8xNTRXYnd5M1QxbjFPU2NobmNT?=
 =?utf-8?B?TTNzSFg5ZWp2bHptR3FHR2xzMXVxeGJiL1l5ek1KWHFuRExFeHQ3aVFaY3dH?=
 =?utf-8?B?ZmZRYWxkMHNVTDRKZWE3Y010ZUNyVVdvNERuOGIwK3ZHMGlzU0xhSFdyUnZI?=
 =?utf-8?B?NzVnelFkMW5JSlZBUGtIc29vbGJhaHZ5NlV3djVGNkZkdGdaMmJwN1hDdFBi?=
 =?utf-8?B?YWRiZlJFT1lMMmt2aEpyTXVpTmFtWGFjL0hOZVVmZitjS2o3NmdZRGl3SGlC?=
 =?utf-8?B?eE5OVVZadDcvRSthblI4dE1UNTdTWFNLSmpBc2VsTGRseGUrUHIvcVFGRmpK?=
 =?utf-8?B?NklFSUViNmd0Rk5HTjU5eFhtamVFem9EV0ZrakFQRVRJaEZCMlRmUEhBQjFq?=
 =?utf-8?B?d2Fjdk9qQUpsbksxWGV4aFpCOEZ6WFhPMzduT2tFS0xQdXR6ZjhjalRiLzlm?=
 =?utf-8?B?WDZqRXRKUm1yYjMreWxMNnpSVEplZWtJNTZsdlZqSElJUTVxMG5IdCtad0k4?=
 =?utf-8?B?SlpQMGkrQVh3djJsbW1vU0NWc2xwL3N2emliRURadFRKeGVhc3dhYk5hc2pt?=
 =?utf-8?B?V0F5RlA1WklMdVYvU2JqV1o3MndscTkxNDVsUm4wbUw0NlkrUTBwNUVTYi82?=
 =?utf-8?B?VTR3R2ROV09HSlB0K0Q5UVBMWFBTcTRrV2VPUHIwM1I1dXAvMWx0UUJUSkpQ?=
 =?utf-8?B?dFFVSWZ2S2xoNTMwRHphRklaT3htUGZtMEpreXkza3FCaTFwSkc1emNOZ1JM?=
 =?utf-8?Q?5AA5GhY+Mhp67vWa+Ez9Gmdx9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a90690-2924-41d8-eca6-08dcbda8d9f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 04:06:48.8080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKUELQ14GVZAlub2yudrGsb46PSCL9HKDK9GFT/f2HSM6DLVGWAJP7qqeqmdl/F9D46pit+17ADwtWpLF5rpmf0xyhaW69EotjQWQygI5xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5510

SGkgS3J6aywNCg0KSSB3aWxsIHNlcGFyYXRlIGNsb2NrIHBhcnQgaW4gdGhlIHYzIHBhdGNoIGlu
dG8gUnlhbidzIGNsb2NrIHNlcmllcy4NCj4NCj4gTWlzc2luZyBjb21taXQgbXNnLg0KPg0KPiBQ
bGVhc2UgdXNlIHN1YmplY3QgcHJlZml4ZXMgbWF0Y2hpbmcgdGhlIHN1YnN5c3RlbS4gWW91IGNh
biBnZXQgdGhlbSBmb3INCj4gZXhhbXBsZSB3aXRoIGBnaXQgbG9nIC0tb25lbGluZSAtLSBESVJF
Q1RPUllfT1JfRklMRWAgb24gdGhlIGRpcmVjdG9yeSB5b3VyDQo+IHBhdGNoIGlzIHRvdWNoaW5n
LiBGb3IgYmluZGluZ3MsIHRoZSBwcmVmZXJyZWQgc3ViamVjdHMgYXJlIGV4cGxhaW5lZCBoZXJl
Og0KPiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3N1Ym1pdHRpbmctcGF0Y2gNCj4gZXMuaHRtbCNpLWZvci1wYXRjaC1zdWJtaXR0ZXJz
DQo+DQo+IEEgbml0LCBzdWJqZWN0OiBkcm9wIHNlY29uZC9sYXN0LCByZWR1bmRhbnQgImJpbmRp
bmdzIGZvciIuIFRoZSAiZHQtYmluZGluZ3MiDQo+IHByZWZpeCBpcyBhbHJlYWR5IHN0YXRpbmcg
dGhhdCB0aGVzZSBhcmUgYmluZGluZ3MuDQo+IFNlZSBhbHNvOg0KPiBodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC92Ni43LXJjOC9zb3VyY2UvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2Jpbg0KPiBkaW5ncy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0I0wxOA0KQWdyZWUsIGFscmVhZHkg
Zml4ZWQgaW4gYW5vdGhlciBjb21taXQgaW4gUnlhbidzIHNlcmllcy4NCmh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1jbGsvcGF0Y2gvMjAyNDA4MDgwNzU5MzcuMjc1
NjczMy0yLXJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbS8NCg0KPg0KPg0KPg0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IEtyenlzenRvZg0KDQotLQ0KQmVzdCBSZWdhcmRzLA0KS2V2aW4uQ2hlbg0KKioqKioq
KioqKioqKiBFbWFpbCBDb25maWRlbnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioq
DQrlhY3osqzogbLmmI46DQrmnKzkv6Hku7Yo5oiW5YW26ZmE5Lu2KeWPr+iDveWMheWQq+apn+Wv
huizh+ioiu+8jOS4puWPl+azleW+i+S/neitt+OAguWmgiDlj7Dnq6/pnZ7mjIflrprkuYvmlLbk
u7bogIXvvIzoq4vku6Xpm7vlrZDpg7Xku7bpgJrnn6XmnKzpm7vlrZDpg7Xku7bkuYvnmbzpgIHo
gIUsIOS4puiri+eri+WNs+WIqumZpOacrOmbu+WtkOmDteS7tuWPiuWFtumZhOS7tuWSjOmKt+av
gOaJgOacieikh+WNsOS7tuOAguisneisneaCqOeahOWQiOS9nCENCg0KRElTQ0xBSU1FUjoNClRo
aXMgbWVzc2FnZSAoYW5kIGFueSBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gbGVnYWxseSBwcml2
aWxlZ2VkIGFuZC9vciBvdGhlciBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlvdSBoYXZl
IHJlY2VpdmVkIGl0IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmVwbHkg
ZS1tYWlsIGFuZCBpbW1lZGlhdGVseSBkZWxldGUgdGhlIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1l
bnRzIHdpdGhvdXQgY29weWluZyBvciBkaXNjbG9zaW5nIHRoZSBjb250ZW50cy4gVGhhbmsgeW91
Lg0K

