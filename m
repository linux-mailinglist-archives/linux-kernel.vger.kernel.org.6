Return-Path: <linux-kernel+bounces-273823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCBC946E98
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842C8B20F12
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 12:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF9F3BB32;
	Sun,  4 Aug 2024 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VjyrvMEL"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD936139;
	Sun,  4 Aug 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774248; cv=fail; b=KZ3FjATSfDl38yL8Ys54SjGK+u3QnggxX9c2w6M5ze0yI2wklrADvCqCqCepL2zbOtQt3LfQm+zXNQ/zEXhUIAq0sFmqE+4GzK9Z+TanKIyfO/ZgmUprxSTxOWXVaOLgzA4ULQ6XLUIYZoyo3wCoX+bqQwm9lgiPYV54uIjj0CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774248; c=relaxed/simple;
	bh=jJHtN5cdjpw48j/RwDXB2cYoH8FaDj/mkqJp7Fm5m44=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ouFRKgzUWAFiGqUQd4BmDQButuTc5S1qFKF6z3GxwhMfj2rCtfhMAENAqqC+d1H7hjoXBd9vsB0GXc77DSdi4R27eNhz75Vrz12qdOnTh7CTCU+rd25idmP9O0+txGj6MCiTiZgoh6vWeN/vYKDDB+uCtM6lIFJY5K8uhPcfhJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VjyrvMEL; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPOrdhHlK2PQSZtoznZ++fU3a6XCavKAMtWeZnWCPJATMGkl1empKo6byOcP9IucmcKRUcT3YDfDMo5nMYiumOqvSv9hJrGEHH+hIV39/sMNN7wlVYRxxEISQydu3eFpYOk5+6K4c90RVciq27zTy8z1hnMd8ljhlNesy3cD2K2yYt2Ei2EqDUkve4EHInfgElhE1dlEmju8DWXKaKYRA17aRkh3IlJcEIuhqmhPturNp53kN6E1LMJPB6eUmB8Io9aRn4aYzYEZJQOK7KVVQge0+2z3jacsjzNgdGttZkee+a1/ZwzaUgLCVeWW9fMCD5r16Hph0sZgfRIaTW9TVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Inysam4Nwgvdh+lgZZMJHWWZI7brIH8XEIf9gyI9WyY=;
 b=Nnb9B5JW7rxc4+gExaiHYq/Y4AQsbx8+yFhGguyjt5gSytjgToy4cz0u+26oddl4kj85m9boGs6v89mJPXjFTyL9V7PKl6c04XN7Fx9FrjQ3xuMGEkzayuwGxijabb2qZZdRuRatR0yMuK0el6JVlJldElMCyMGBpQ8Tpvu1pKEsG5IgmHIQBmWon2bFX0xKzWe8g8hZJCEhbkLsKMQDMpF1Cx/qaA0KKO/ljHL5mBTRTZ5lbcD9PTNfu9TGLnAWTdWryClzHQHtKa12Y8FrBqGxHySaMGKebOTpZQoF1/i0qmPLngEOW+Ut1wHOUnoYV9Z015qFFfQr5mTC5zMxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Inysam4Nwgvdh+lgZZMJHWWZI7brIH8XEIf9gyI9WyY=;
 b=VjyrvMELoZTn2VRN0S6d8il/f1y1mU4CRbNFyt3kyR/LsNuG+oXHLzbpP2GAslsIJblLgD9hFu3XgsxTTQzjqAPgx7a8AsnAffPMLgV/c/q8mVw2qb/3/3MEdwVxdDOIfr2l1jyrsG5z4vOlT+PtgXXQLs5/FulPNDv7n0OrqtonLcH3DcFKtC7WnAjWnKJx/1jxh7mUdzaFGTa+Xk8ddVhh5HPlpMt4DslpssBjI+A6L38TbedCMZiXf5us57X0YIZVZbUcTz5HfYDhEWmpaPm4bmnJ4gghC3tjxhlaMMqMSVWyEltwHGVuIiC3RI4y3s6TARNECgtDOjAWK5IRvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7413.eurprd04.prod.outlook.com (2603:10a6:10:1a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Sun, 4 Aug
 2024 12:24:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Sun, 4 Aug 2024
 12:24:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 04 Aug 2024 20:32:55 +0800
Subject: [PATCH v4 1/2] of: property: add of_property_for_each_u64
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-clk-u64-v4-1-8e55569f39a4@nxp.com>
References: <20240804-clk-u64-v4-0-8e55569f39a4@nxp.com>
In-Reply-To: <20240804-clk-u64-v4-0-8e55569f39a4@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722774785; l=2787;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/uWDVm5pCySyF5BAPfXac+GeAhNij296nWQXpAULzPw=;
 b=AaLZMkjvJbIRJu9kcvya9BVP2zvCnZC09Wm/5CF4hx7T1aPMA+kl8/CW65aM7EzzUppKlibbq
 jntreCoxCFPBI1nOQwRZkyUfA6xt8eEfOrjoyRCZLbYHKu0XsnMrS2G
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: fc070f14-d584-4333-8066-08dcb480534f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0NHU0VQTGZGaTNaYzNSSE1sMU5VWk5Jcm1uN3YwUEtuYjZ0REoyazhRMWFV?=
 =?utf-8?B?Sk12UjFWM1BreTA5S3FFQjBYTXpVV1FwRDFrN0Q0VGsxbUxieU9vajIzZ2Nt?=
 =?utf-8?B?VkxtZXByMlVHclZlWE5nMlNoQUlEVkxZUm04N0drbWlxOSthZ1NscWs0VnlR?=
 =?utf-8?B?QzcvM0tudUlHZllhbmJzaFhnRmhJUGhSOFhUdmYwMHN6bTVVU0RmTDZ5S0ly?=
 =?utf-8?B?MmdFWGgva3B4UTRyRWJXMHdUTEVjUW5iT3g4NVRwZ2kyclgvcEZTV3N2SkdC?=
 =?utf-8?B?Z2ZXc0ZrZG9VUVVPZnlwMmJFN1N2dlRaR1N3Ymhid3hxRmZISkIvVzVoQWhk?=
 =?utf-8?B?TzhILzZBQTY4dHNVQlBpVktYN28xV2dPSjkwMkx6dEh6cXlUUFY1dUl3ZFcx?=
 =?utf-8?B?YUZZdkFMakhQY2dWQkNCMU5PeXpMc0xSdmlNekM2T2d6dC9meXRvRDllZU85?=
 =?utf-8?B?REpJeUE1d1JtMlR0em4rU01BRXVZU1RKQ1FwUnM1Qm1sT3F3SnRHMFRwK0Jh?=
 =?utf-8?B?eTVocXVaZlpvWjFvWitMUGt6dzk2UXA2T0ZEck1sN3hXWVJKczlWQjh3Nnpi?=
 =?utf-8?B?WmJZVnVCOWVOQ0M4OVJOUVZ1RVlXa1hwamI2Rk8yWXNRZFZDNURaYWhvbUl2?=
 =?utf-8?B?ZlNDbXNMb21qeXF0Snk5OERJdlpZZ2lDQURqam1iTS9NSEV1UzJtTHZ5MHY0?=
 =?utf-8?B?VnpmbFhZV2ZMeFhRV25Fb3ZmTmY4V1VSdHhuSGhTa3dGUFN3cm9rNjFqYnFm?=
 =?utf-8?B?V0thRGpBenlBKzVvSHkvRUVvcUZoeWJTcWcrK1M0UWxWUjJwc2JuNkRnbkVW?=
 =?utf-8?B?SnlwcE9FL21hMzFaWTVaK0RUZng2dlhZY0dPZjEwT2l6TVR3WXg4OEVCazcy?=
 =?utf-8?B?T20xNVJRek5qZGQwUUlvMWhNMkl4WXBHUWhIOXVLYkZxczdyUWtVMnF6KzNv?=
 =?utf-8?B?WE8rbjdNeFpiTm5HT1QvdGp4UzdiMURqMlQweVEydHZkakFMTklMWlB5RjlI?=
 =?utf-8?B?djAvZ3F0OTN3TVlRaDRvUnFCOG5vTStmdmxkZk02K1hXSlZPVTdKSVlkY0h2?=
 =?utf-8?B?VXNqeVVCVmtGdzBRcGJTTTNpQ1FtTmVvT3ZlVW95NTVBaWN1MWcrTGtEV1lW?=
 =?utf-8?B?UGhXZ051MHcwY3NOSHdSRUZmcXREaHhWNXl6MElFb1o0WEVJbjE1RElqUXRl?=
 =?utf-8?B?MWJlTWF0dDdJVDBwWVE3a2thbFdQMkxOMENFZnh5MTlmSjBaRkRMT1hpdkl2?=
 =?utf-8?B?dUVCZWVrZUhheUhmMVgrK2VldlRDdzl1aFpxSVlVQUtJWEk5U2ErR2Z4bTNY?=
 =?utf-8?B?RHM5alBUZDFmL0UyQlF3am5nVUQ1STNQYnZ1UzZmZkFNd29GcUhCNGFHVFk5?=
 =?utf-8?B?empYMWN0V0YrYnBwY0JWR3hpdm1pUW9ROUVJT2N5Y2NVRW11UFFzVy9xMnFp?=
 =?utf-8?B?a1d4RU8vZkxtaERlQmVZUUh3VnVhdFlEMSt1dFFvNzVXZVg5bjROMm9rSzM4?=
 =?utf-8?B?TXFZVG5Pdmg1dVhwOThvMDBadGl0N2pkUnZaV0VWVjk4bzlqNE53eXBKd2k4?=
 =?utf-8?B?OHU2ZTlrOVgxY1NJV1ZsOHk2OWlJM1R4bDUxZitYZFJtUUZZSHgrS1Z3VFFK?=
 =?utf-8?B?UU1waHB6ZGxJRWRGeFNzY1R1ak9uL202aTFLN2pUSEM1OTlNaFVpNU1KOEx4?=
 =?utf-8?B?RDIxYVJubEY3SHhYd2VvaGU2bkpML3p3czVGQmtxcUJXZHY4OXdQTTJpYlpU?=
 =?utf-8?B?blIwT1FHYTFSSWd2SlZkTEE2ZjNDZTNyWjgvUHNUSHVPamM5ZXNSZmY5d29T?=
 =?utf-8?B?MzFOZlhiY0NWeWw0UTdNV04rRE9SeUY5WmI5NnIrekNTSUw1NUtwSUFkaFVz?=
 =?utf-8?B?dEIxTHd6dmgvbm9GRG1BNUtNTStBT1lLekRMSXk4WGkwT1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkhUM3ludHRKa00rL0s1S1JZRmRneCtZVVIrT0VMM0p4MjRhWUkyYW1nNmpp?=
 =?utf-8?B?ODVwNEl1NnlxQWJ0K0o3OHNjcGUzRExwbEZaMDkyZWFtSFNNSkZZVEp0czZS?=
 =?utf-8?B?c2Jxd2t0Nmo1dXROYXIwaFc2eGtYQ0FsekFLeWtBeDJFWGM4QlpHOS9Ja0x3?=
 =?utf-8?B?VGJab3ovajNuWGgzZVMzVXlqUnhkdFA2YVhpMm4zZldta051d3dKNStGNmQy?=
 =?utf-8?B?dUtEQW1Yd3BPa3BLaitKZTlHbGZURG15NnU5LzlXdUFLVTJzV0RBL0dwNE93?=
 =?utf-8?B?c1dYa1ZVbFp3S1FXQnF1WmdwNS8xUzV4OW5zNmpuN1A3dVJzdmdqNDNxdWFG?=
 =?utf-8?B?VndyWExQa0hMamF2ZXVtL0JZNlFCQUF1cmpKbm15b0FEcGlsWmVNWnRUYk9o?=
 =?utf-8?B?VW9qenZzYXozVzFSVXRzcDdFUGhLbkcyM0NTamx2VE9EeUpjaEoxWG1tSTB5?=
 =?utf-8?B?eWYwenIxRFNtZDZrMEZWczZYVnRVVEJZVjVWcFFmS1NyTGtzblpMYkRlOVZo?=
 =?utf-8?B?Zyt1NUltbXZFWXRqTVN0dDJKUWwwOTAwbGkvR3ZzeFZod1NPZTc4bHIvUSt3?=
 =?utf-8?B?REszRkhSNlBHT1ZNRTNiREJESWlHbjZLWlZDMitualF6T3NRaGxFNlBqNnZO?=
 =?utf-8?B?cS9zdGhHc3BVam5VQWhWL2R3K2V2WFpzVHhub2NxOFVuNHMrRU94elNqUFE5?=
 =?utf-8?B?RFczcXYya3JUYTdKR0s3M21LcU1wSlpKQTM3SmFVVFI5TnhaRytHZjVEbGg3?=
 =?utf-8?B?Q0lDeHYreUo0NHBhMjBORVk3aW1xaHNBTE1icm5wSzJiaDM2cXo4Z09QN2RD?=
 =?utf-8?B?ZkdEaHVaaTJ1STdNcm5jU1NvUVN4U2hyb0RSWkZJSFc2NHdCZUV5UFlSV3o1?=
 =?utf-8?B?WDhXZUY4SWxCWkRUbEc1QlVpcklqYlZkSG5xRUw3Ym9wRW9zcGdDblg4QWt6?=
 =?utf-8?B?SUNGcEMvNEx3ZGd2aHB0ZXNMcGRTRjI3S3JnVytYYXlzRThTU0hRRVp0elpv?=
 =?utf-8?B?MnRrU3FINE42TGRiZXU5Sk5IRi91dXJ0cDJqcmNrWVNQNUczNTY3RGVEbGV4?=
 =?utf-8?B?UTJKaXdYbXNaVHptQmtSa3dsZ1ZCaEplbTJJZHlBcFQxOVlWQ2JwemQ5Y3pJ?=
 =?utf-8?B?U1VadVhralRzSzVOSUMycG9YZEhwZjNtaWl3N3NMaW5XNWpvd01WV3RTaVhx?=
 =?utf-8?B?bWc0ZXdaL1ZMKytqd1BMcXlZcjFrWTg5N1pnRmhML2tuS2hvOU5SSTNrUWxB?=
 =?utf-8?B?MGpsS0hqd3BZazZoai9ML1lKT0NJeFRCRWxSSXFnMi9YUjFIa2RvL3lKK0pi?=
 =?utf-8?B?R0NPTmdOU2h1TWdqSFJ2SjNzdURoS0dXWDZDQUozZmp5QmxCdEhFK3daZ2FK?=
 =?utf-8?B?d3U5NnpKY2p6V3RsK1hsN2lPbnhMb3IvY1IyVzhzTVFnUk1mZzZMbFIrQzI5?=
 =?utf-8?B?Kzh5b25LQWlQSWI3UWhxQWJ1aDZ0RzhBZXBubVpLWDNyNTFucGJQMmdTTngy?=
 =?utf-8?B?THRITVlZalVQU0hDdUI1WlZ6Y2FHdUNqTHAwaFc2Z0dCNCt4OVk1ZElZc1JK?=
 =?utf-8?B?aWpTVndkUGFlLzMrVTgwOWh0TjBGNmxQUS8yU3NPdlFsWE9iQWRqSDRvdW1W?=
 =?utf-8?B?bXJqdTVlbVliMG5Tem5McWZzMnpHb2VQRitRVmpHQ004Qno5RVJYdWN6M1V6?=
 =?utf-8?B?WWt3aDVyY1doQTNZa1YzcEZkVE5jcWwrMEllTi9KVG5NbjFJSTVtc1d1WGZ0?=
 =?utf-8?B?V3hoZGVhMVA3VkVOZDRXY2dyd0pteExpMVVmeGpjVjNKdVBGb2g1RHJGUjU3?=
 =?utf-8?B?NmRoYkIwLy8wQnVZcmN4WnJybUF2NDNWQyt1RFhlKy9MaHFxT3ZsL1ovMnh6?=
 =?utf-8?B?bm8yZElVUUtOODNqSU5reVpieWJuR3pYbUsyQnVIdUMxNVg3MDZNdERuVEdD?=
 =?utf-8?B?RU93L09SRC9HbEJ4T0pmYUZBM1NVY21ndVNmd2s1YWtxY3dCa3pIaFJxQXVy?=
 =?utf-8?B?amQ1MXlna2hoWHBoUmZOcWtacEZTa1dnSHZGZHBYWTdQckNCcE5rMGFsQlIw?=
 =?utf-8?B?UHNVSXpjeWZNcml5c3RpUjE0TklxRnVVL2l2czdJL25LM3Z6MXM5dE5sVk9F?=
 =?utf-8?Q?8eAQKgAShUSzpTSaiwYETUAfe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc070f14-d584-4333-8066-08dcb480534f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2024 12:24:02.7176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiyutEYalAxiuJXFzv5NI/56CaMPF+3W+veMbWPwzdY7AOOeboSOLELo1mQqlFrTW1FRWSnAA087ngdZbLyWtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7413

From: Peng Fan <peng.fan@nxp.com>

Preparing for assigned-clock-rates-u64 support, add function
of_property_for_each_u64 to iterate each u64 value

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/of/property.c | 23 +++++++++++++++++++++++
 include/linux/of.h    | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 164d77cb9445..f70fd8deb9cd 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -548,6 +548,29 @@ const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
 }
 EXPORT_SYMBOL_GPL(of_prop_next_u32);
 
+const __be64 *of_prop_next_u64(struct property *prop, const __be64 *cur,
+			       u64 *pu)
+{
+	const void *curv = cur;
+
+	if (!prop)
+		return NULL;
+
+	if (!cur) {
+		curv = prop->value;
+		goto out_val;
+	}
+
+	curv += sizeof(*cur);
+	if (curv >= prop->value + prop->length)
+		return NULL;
+
+out_val:
+	*pu = be64_to_cpup(curv);
+	return curv;
+}
+EXPORT_SYMBOL_GPL(of_prop_next_u64);
+
 const char *of_prop_next_string(struct property *prop, const char *cur)
 {
 	const void *curv = cur;
diff --git a/include/linux/of.h b/include/linux/of.h
index 85b60ac9eec5..de481a4bdad0 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -437,6 +437,16 @@ extern int of_detach_node(struct device_node *);
  */
 const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
 			       u32 *pu);
+
+/*
+ * u64 u;
+ *
+ * of_property_for_each_u64(np, "propname", u)
+ *         printk("U64 value: %llx\n", u);
+ */
+const __be64 *of_prop_next_u64(struct property *prop, const __be64 *cur,
+			       u64 *pu);
+
 /*
  * struct property *prop;
  * const char *s;
@@ -832,6 +842,12 @@ static inline const __be32 *of_prop_next_u32(struct property *prop,
 	return NULL;
 }
 
+static inline const __be64 *of_prop_next_u64(struct property *prop,
+		const __be64 *cur, u64 *pu)
+{
+	return NULL;
+}
+
 static inline const char *of_prop_next_string(struct property *prop,
 		const char *cur)
 {
@@ -1436,6 +1452,13 @@ static inline int of_property_read_s32(const struct device_node *np,
 	     _it.item;							\
 	     _it.item = of_prop_next_u32(_it.prop, _it.item, &u))
 
+#define of_property_for_each_u64(np, propname, u)			\
+	for (struct {struct property *prop; const __be64 *item; } _it =	\
+		{of_find_property(np, propname, NULL),			\
+		 of_prop_next_u64(_it.prop, NULL, &u)};			\
+		_it.item;						\
+		_it.item = of_prop_next_u64(_it.prop, _it.item, &u))
+
 #define of_property_for_each_string(np, propname, prop, s)	\
 	for (prop = of_find_property(np, propname, NULL),	\
 		s = of_prop_next_string(prop, NULL);		\

-- 
2.37.1


