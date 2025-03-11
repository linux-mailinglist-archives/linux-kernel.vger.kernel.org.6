Return-Path: <linux-kernel+bounces-555860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907E6A5BD84
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CEF175FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F4233141;
	Tue, 11 Mar 2025 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dk3lsOlO"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6A230BF3;
	Tue, 11 Mar 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688200; cv=fail; b=TPDC9e275NAxL0COptJ+iNA9Q1+wh4e1Mab6aN/WcHcNtk/t0gukkdho5XClWfJd81hoHw4jJax4RA/KL/SCwkklfw9H9MSigpYyYLYOqrBxHvBaAYitrlxxYBG7lQ2HC5DgxpgL9sLd5gzxb8y3MMvFCTWFrUyVy5xpasJ5Jps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688200; c=relaxed/simple;
	bh=tOtSXomq2KH+8clEacb9RWYs1iYcwyaRAGNdBtHVSY4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=que/NWEc2ichNwPNldnc5CWfnnZ6CVYwQI2dJIT+KaeKVB+MB4UbwRiECDwC1W7tW0wYA7oLwbtmv/V1PVk/ZgraGNMx9g/aHGE8uF0prQpIRGK6y6ciMNmVCiEzDI4/6odPVOShD3Q+sTTjz7Jx5Ft/N04YmXHgtN8ath4yKPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dk3lsOlO; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACbE36asHhscGUkSrEozKDbKADxuclBRSNr3HpvWoZVHjvkv54ORKAper3XcyqrwQquCFLpNbQXA3G+9OfI5iBJvl6ELWwc2slFQETV7DVAm7OSkfg0AKHhUp2NcRP+qSsQapNgykLmAknAxO107iQprmkLxZQyxJMNPfZyngUKS/iWGI7XfIFYVfNbC9njpxzbA463f6VVOMgJim5A8XZ1glzkO6obZySV6QZbC6diMtT7Vj4EWoDDbcQOk5hUXMnt8Y8nb9SKmMy8BTnftlvuFRZa8v/+H9U720JhIUtq2OTMD4s8uW5WgvEgBsEdOGV4p0XfCHlCoyN1PBC8LYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9LQ6U97DJmOvAnP/Hm3/sLsl0YOZft52i2nAtpwopw=;
 b=Qqipur4cBJ37jqa2JK3M4WexxY52MZg1/LM+P1c+VuYJw2dx7V7HzLPF0pdGOtpWigTMOwGUmGorQK7HGamBzWtGs2CPitb5CLPEo76RaY/1qOg5t66vIQ5DlYvfH8Uyjjupi6Uh2Aykyk4ijTPsFBBYUsOWjmZIGTz5O6CSHfgwL/gACJKUTcwj+4Qox9Yc40AUvGnrf9Qm0QoYitgrK4mBjy7W3tDHjhyJ3GT71ltdGwpm1m0L8NTNqDL7YqWsblN4a28D96Zgtga0kQot8YnBdJmjsgW1FqQEUwYOIOpCYlVwzKe8mlfzUO+Y+rGqtlITk/eBTcfMu0g4RuFgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9LQ6U97DJmOvAnP/Hm3/sLsl0YOZft52i2nAtpwopw=;
 b=Dk3lsOlODnkCbLt5r6dQVyVVeo+TCp1G+k2RgwG/XT9APiWAlIu1VHcQHMn+3dK+bFMWRwVrZ+DtHNhCJ0ANbRI6q3S6WLbLS6L/hQTCfSf4W76UTxRAINGAMNtOj7492JvG0b4f9LhLfcPFS2vJRtknyAyjQ5eTlj9WnPlVNk9RPXOUY6zMfrMvIUwsXCeTLCtGTfTB+bP754ZdEJO9abRYRc6eqtcF/1kHZfzaA44V5LJL+U/8Pm5eh6GPF5F/OaREBVcHIuHDz1jBbubkNNP5dFG/T5uXHJexScRAODEztXFCdgcyCxl/1ASz2CGJRvo0TGqaK7OkFSZv4QPvsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB8449.eurprd04.prod.outlook.com (2603:10a6:20b:407::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 10:16:36 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 10:16:36 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Tue, 11 Mar 2025 21:09:33 +0530
Subject: [PATCH v13 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-imx-se-if-v13-2-9cc6d8fd6d1c@nxp.com>
References: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
In-Reply-To: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741707617; l=3201;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=tOtSXomq2KH+8clEacb9RWYs1iYcwyaRAGNdBtHVSY4=;
 b=PfJg2HnaMyvoAxt8BWpyonmNqzkSFr3iuieqEh9hn9KIUDZHojdCFrfNl2Py9QpmxoKt0k5pT
 WxmgfvtcdJrB9Z8oFSLsNOmsco2wEJLki7qGoAa8vKRXKwNSFy5UPbH
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AS8PR04MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e84f09-20af-449d-aaa6-08dd6085ce35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sy9PUWlCSDh4QXhRTWV6dk4rL29jbVFrRlNha2laR3M3K2R4WkRLLzRPRGs2?=
 =?utf-8?B?QnU4K1czRkNKR0VKa2lrQ0lVS1RzeUhMcDlBQUlKMlBRZW4wV3RvQXRtMG9M?=
 =?utf-8?B?d2Mvb0ptUkRCYVBYcll1SGcrNFNnSWpJQldVVkVzeUU0RXg1dkVvZHBwc3dz?=
 =?utf-8?B?L0pwRVVtcnhuREpxQ2FIallwV3FybEJNSlpjOWdwSzRXWW0zODlYYTMzSEpQ?=
 =?utf-8?B?eUZPZE9ySFJUeVp1WU1hZHg4cjVYUDkzempySTNST0hZck1YZlloZC94aENa?=
 =?utf-8?B?OEdaV0FReFJqb2JFNm5lNExMR0VidGMrUkNkczd3VENLb3o4K1hsS3pzTVRp?=
 =?utf-8?B?TmdMcXhEeXRPYXNiSm9pSHZBRFBuWG85S1hGS3ZsaDE0a1MvUURxMXVWS1NQ?=
 =?utf-8?B?R2oycEhoRFRwaWczSmpIYjMweGhIUndNeEh2NEZaSy9oa0UyRTF3MWtkTm9P?=
 =?utf-8?B?K1huUmZuVmNhUWlKL3ExYTl3QzVnWURpc2hxY05pYStEb3VPaWJDS3FlTjZa?=
 =?utf-8?B?ZnNTZkRwZXpZa3VjdnlLcFpDOVI3WnpPYzVzYnRCWnZscHNZQ0tqdE1IR0FD?=
 =?utf-8?B?S0RCdkpteTlmeHgxdXhBZjNNZno0VmZJWnh2WlVpbnlvMjFzbkNsdEJFL1Jo?=
 =?utf-8?B?bHU4OWNXWlZ5NS9zV1hJSkVBMTAyN29ocmIwMWRSZmQzcW1ZT3lSMkFvR3ZO?=
 =?utf-8?B?QlNtWHZuRkJCNWNLbUc4bmVkZFZVbzhQRjl3U0RWTVdKcEh4THhnbjJrd1ZJ?=
 =?utf-8?B?QUpReDErY0Fzdlc5a3VPMDE3ZVBGVVZuWVhJWDd2azJHemFxRHRQRFNRVDNE?=
 =?utf-8?B?TVlHU2VDaTdRMkVJSllZNTkvUlVrbTNUQ0doVUNJTGhxeUQydm9hQkNpUDdF?=
 =?utf-8?B?NHYrbnNpMGtic1RKV3pITEl1WlFYRUpCdVVJZngzcnpMdlppK2VkYXhDV0tO?=
 =?utf-8?B?cHJkVkxUbjZKRGNCMy9uR1plNnpWQk5ldVJLdzFUSTF5TWV3Z01uL290OHN4?=
 =?utf-8?B?OVhDSmxaUW0vWVRNaXRGM3hiRXlwMjVzOElDQ2hRS3Njd2F5dE95L1g1TGhJ?=
 =?utf-8?B?c0IyNTF3eXdacFdxS0hQdS9yWk5KV3dTeFJmMk5meW1TREV1RWozbzlaN2Zk?=
 =?utf-8?B?N3ZoZ0JLVUVQeTM1NTZRMWpNRHlKWkxybUhnWlFTNTZUdW8rM0FVekp3Ymtk?=
 =?utf-8?B?aEM4MkdrUzY5RkhKdEl0aENXMlo2RVd0QXJodTNQTU43QWJWamluZzREOWIr?=
 =?utf-8?B?NStyTFJEQ0NWcnlhOHpVMUg2LzVoNlk3VjFRQWxuV1ozck5kRFVNTGcvYllj?=
 =?utf-8?B?ZW0vWWY4Rjk1M20yaUhrYmgzV3JoTjUrRkpGNnNJZlF2aVNWcnczbjFNcGFM?=
 =?utf-8?B?aVIvY0ZwRVBzSXFPWThIa0Vic2tpL2pMT0FzQ1lmRWt2c1p4SDdWNW1iWjNL?=
 =?utf-8?B?dXRFcGZocVY1dmFhZHJ2NDQ0TWJaMURGbWl5UitKZzRkMUpyMkx1Y3NvL2xq?=
 =?utf-8?B?dWFUdjVaVDllNkgzWllXM1V5UmpkNE9QbUlSb2h2YTBVN0d3N1NkY21SNEtN?=
 =?utf-8?B?cHRyM2FTcVBMcXg1eSswYUNYZlRjaEhmNjlyeFQ2dldoaWp6SGZBUUNyVXc3?=
 =?utf-8?B?V0o1VjlyWHpxODhxSjEzVE15SHE3MldJN2ZxYnFZUjBiL3hycGZCZDBsMnhU?=
 =?utf-8?B?SlRrYnZPL1FDUG5sdUMwYWNCeHpWMDNwSmVGRmN5dDNqRHEyZ2FpYU1zRlVN?=
 =?utf-8?B?ZE13aGg5VGhNVlFyamlsbVVVWGl1dTd6cXcrVUp2SEJid0x6K2RpaGRZaXBU?=
 =?utf-8?B?OHlPOFhxeUErb21NWmgwTm8wZStOc1ZZTlQvUDQySlV4VkdZV2lBbzM4Y2xH?=
 =?utf-8?Q?1eB4t6mrLStE6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzlaNVZZU1l0OGRzYkQ0VEhxKzBkdHBhWEttdG0rQ2VlU3NBdnNtVmxCQlNP?=
 =?utf-8?B?b2ZKYW1leWZicHY2V2NyNHloUEVZYkhFZ2ZWZW1PV2Jja0J4clJpeG1iOWhQ?=
 =?utf-8?B?K0ErY0g1YVdCcjk5YWgrdnk4ako3UFlsNEU4SVdSelVObFpQN05Wc3dBelRI?=
 =?utf-8?B?cWlUVXdnUnhndm5RUGtkeVdUUXg4eTRySXhrMlMrWEZxbm1tT2Z0by9vYkRV?=
 =?utf-8?B?dUFHdEVSQ2xaL2laTVZvN042b0hxOFY0RGxRTU9ERzd5bHFMRDJhaTUvekQv?=
 =?utf-8?B?ZHRYcG1ndTZtNG02QWw0MkF4RXg0dWtpdnFjR3YvZVdab0V5aWFqTmNtQXUx?=
 =?utf-8?B?a0xqc3FmUTNzdkU3V0twekJPNm5TN1p0ZkpWd28zTTlZK1dJcWwydTQ5TllO?=
 =?utf-8?B?WTVJdTdvUjg2OHNVN3hyVG11enNIWnd6MXNPY0JxRk1WYUVwMWFCS1lPb254?=
 =?utf-8?B?S2thWXBtZ1dyTk55VHRGdVhzRzQ4RlZJK2FFNXNQWEd2QWN0UmV6OTdKbVdJ?=
 =?utf-8?B?ZCs2ZHJxc1NWRWdNTldEbUxhdzdsOTNVM0RtajRkczVpYTM2VG9tUEZFNmt4?=
 =?utf-8?B?dVVSYTJjT3JaTUg5T3hZYmR4dGUwYU8zUVcycGFwQnlKWElENXRDUk85ek8y?=
 =?utf-8?B?RTQrUzhkcjdhRUJpUU1NVjFmR2dXd29CUnFFcGQySVF3MVlBbG9pT1Zpb3Mr?=
 =?utf-8?B?dTlZbUZsb2s1RVlGR3NBRHQySGQ2MnNsaURiQWNxSUJXS3BzREoyYjJaVzBZ?=
 =?utf-8?B?TGlpcUh6NGxieGRFengvY1ZCRUhZcmRNR3BxaHdXYUVwYXNrS3BBakdGeEVK?=
 =?utf-8?B?SWdoVFl3VXlmc2FTOS93eWVRSzRJTjJISDA2dzNrZTBEbG9tOVdvcklNbW5H?=
 =?utf-8?B?dGt6RkhxYWlzQnJRMGtiK25IeEp2cThZVWVvWmxYOGdrd3h2WVlqZjM0VlYx?=
 =?utf-8?B?MjAxUkhzL0dkSEFPUUVHZTFzZzlGTzc3czRZNU9pTThjUGs2QlJZQy9oWTRx?=
 =?utf-8?B?TzUzaFN1YlZKYjUyYm5PYTQrOUQ1K3gzWUdYSEg3Uk85TnRLNElkVnVnVnor?=
 =?utf-8?B?eUp1ZGdTTjF0ZjFqb3pQbFF2SzcwTk9DMjViRzR5UTNMNktvQkprSkJEUEE5?=
 =?utf-8?B?ZFZwV0VMTkhSS2lMdVdUbWRTSmlrU2ZzT0ZoZlRHY1lYcEtGSktBbWlIM1Jz?=
 =?utf-8?B?N2pKVEZrcUMxbVNVVnB5NHVyZnIyQ256d0s2clUreDlUN1IyU0FyOUhPU0t6?=
 =?utf-8?B?Y05vYUNXVlBRZEo2TXZNRENOZ0dJb0JHRFBGakNacnpOREVrTDZYcUxrbDJQ?=
 =?utf-8?B?LytJMlI5cWJtNVFkTktzbXZGbmtWQk9QWUJ0bytFTGw0cS83bkJ3N3JJQWRE?=
 =?utf-8?B?ZTZSeUpTRnJFbmo4MWkrcFVXK0hjMVRJdDEzTkc5SWNjeEsvVG5HWjh6Qm00?=
 =?utf-8?B?ZDRqWWxvNENLRU1jeHR3T045T1A3M1lMM3VsYXpncGdWdVhEQUh3SWdqazls?=
 =?utf-8?B?RFlPeS9Uc3kxcEV5aVpZaXpUajY3cEMyZDlmRitlNHZIMTFQWjI2RkZuUWEv?=
 =?utf-8?B?ZEEzOG40aFpjSGZvcSsraHRwSU1RNjViQTYxdjFPRnoxa3pzZUN2eTdCZ0Qr?=
 =?utf-8?B?MkIyaGZ2VHp5aEdlY3Y5cThUeHlSMmExaHhiUjRYWjVpcHFhTmRSL1RpSlI3?=
 =?utf-8?B?NGR3UStPWGlnRDJJaGtZWTNLZVJDZVhoOGs5OUYydmdDZVIxODlsVnZPUjAy?=
 =?utf-8?B?Z3A2SzU5L3BrZEVRZjFsYktJT0pmQm1qMW9rV2d6dktYTzhpUS83Uy9JWTVx?=
 =?utf-8?B?YWljV0VzQklubm8xNTZYTWMycC80S0RxWEVtK3hMT3R1TUFnV2xEVS9haHBY?=
 =?utf-8?B?N1J6b1B1emJ3NnlweXI2TWIzV2RPSVlTUkZRMDF6VUt1Z2JBOWRWd3BaUkp5?=
 =?utf-8?B?a09XQjlGdEhGeE1WRjJiUHNEQW8wZGZDTG5HOXV6VmpGeTlXZ2svVVJqRjMr?=
 =?utf-8?B?VFcxMTBXMm41ZEtrMnJxakloaGsyVStXSGVSM3BEaHZRRTY3L2k3QlhabTJn?=
 =?utf-8?B?L1dISUhyK1VRYXNvdHN4c1djMUtZWktjTHVUd1pGOWljaDBPWlhybFpEOUtr?=
 =?utf-8?Q?AI1xPCEb8Ar9vnRi5SbVRo1qq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e84f09-20af-449d-aaa6-08dd6085ce35
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 10:16:36.4302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UatOBRP1S6Ba3Ncnf1mpVrprGlCWocO0DegmHD3mss+RwG/f6lwlu0ReVD2z98Yq1t3cmXkcEXihstwYRYYxsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8449

The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
creates an embedded secure enclave within the SoC boundary to enable
features like:
- HSM
- SHE
- V2X

Secure-Enclave(s) communication interface are typically via message
unit, i.e., based on mailbox linux kernel driver. This driver enables
communication ensuring well defined message sequence protocol between
Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications, to be able to communicate over single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
new file mode 100644
index 000000000000..fa81adbf9b80
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description: |
+  NXP's SoC may contain one or multiple embedded secure-enclave HW
+  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
+  enables features like
+    - Hardware Security Module (HSM),
+    - Security Hardware Extension (SHE), and
+    - Vehicular to Anything (V2X)
+
+  Communication interface to the secure-enclaves(se) is based on the
+  messaging unit(s).
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8ulp-se-ele-hsm
+      - fsl,imx93-se-ele-hsm
+      - fsl,imx95-se-ele-hsm
+
+  mboxes:
+    items:
+      - description: mailbox phandle to send message to se firmware
+      - description: mailbox phandle to receive message from se firmware
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+
+  memory-region:
+    maxItems: 1
+
+  sram:
+    maxItems: 1
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+
+allOf:
+  # memory-region
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se-ele-hsm
+              - fsl,imx93-se-ele-hsm
+    then:
+      required:
+        - memory-region
+    else:
+      properties:
+        memory-region: false
+
+  # sram
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se-ele-hsm
+    then:
+      required:
+        - sram
+
+    else:
+      properties:
+        sram: false
+
+additionalProperties: false
+
+examples:
+  - |
+    secure-enclave {
+      compatible = "fsl,imx95-se-ele-hsm";
+      mboxes = <&ele_mu0 0 0>, <&ele_mu0 1 0>;
+      mbox-names = "tx", "rx";
+    };
+...

-- 
2.43.0


