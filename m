Return-Path: <linux-kernel+bounces-284092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101D394FCD4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB831F24FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202A33D0D5;
	Tue, 13 Aug 2024 04:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JX2N07S3"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F188249ED;
	Tue, 13 Aug 2024 04:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523732; cv=fail; b=E0o1/02TxKfEn+C0yz9H4/I2MO/inXJC3tBBDjOWU80PT+rIubp4rQmcv5gRfmcOJwN9YBwAJjcRsjxB6VPVGRUE1Zus3YwFL+2rEOCfBaiiEUL0dc85Tpk5+CB13JWPPJF1XVH+3pwwCsCWys32zyC4AglsukI9ThclTG62agY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523732; c=relaxed/simple;
	bh=HW90x3ZwEXDosMMA6gjW5Q/j7VQ1KUZhAGfk7EyVCZc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sUSLS2MZ9r6qCBTK+7NTrOSk871RUfPLFFf8WJhlqEJwaKW+iZYjchSCFQtrICgJZOmHwsOKTVbYKqrHzs82NBZ1NGqyiZkJG4G6D+w91SCExb8s9mGU45Ju7rJX6y35HQnGqmmaaVcdbB6A+MUF95h9M6dk4s+urbkcUj/8orM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JX2N07S3; arc=fail smtp.client-ip=40.107.241.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSq7BK9bT3EwbE51Adr3aJH/OV6u22ZNNECAE31RazEsyXzGnnPOr238pXUDfakxFiX/EFWKHWCMp2ycwLb/JJZ9pHUBkxa83XFhRuJ19XZ0xbp/9lXbsajNIW5d12zboAxtTJCOGbD5Dd/4D6OfYKSre5WGBxPMqD9K7lHBJoriFU15htdohRo3oudK0QIPrWTnSMF1yEJEJXW0l3Y7PcpBDw8HeIKbMKP0DkT1/dcsUFWUt5yn1bFbMBGI69/84lXAWTUbHxiOf+VTkxyrypDv6tWqMLKuD8Ey4an2mg8wJWQz/P7XBTZoumHt9r/Q0Y6zmdcwwcklHtMgDFjA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8eGgXQBEpfcDiUWGzMRsusT1bjDP+P32IDTkuxIXW0=;
 b=UL4lbMBmIbKzfnHIGrJM/naDZL23jLljQp3RidZtedN2hxIIvdYX6+KinXix1DQ0ohDZZlvREqaU3/pL/tblvpy7xVX4IMt8wuq4LMuLRiiSiAyNtYcrAr1QQFCe6+9CzbA4xIotjz8Gyqde/kRMb/yaGiaKl/KOCycH+Rrc/J+79CpS2JSus9zUeLskn5XzZMg/d7f5y1O0HpR+0TRgBF5MwbyGSmQ4amiyVQyXhNHaqLP5d26U5qkrbadYIFUvvFCk58lxj1+8swddsVYAdoXx/Ip6+X92jPOA1TZ5eCmR1LGAHnWY+eJ4kefMv2SrZfrCzsabmEbHZGJeDT4pkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8eGgXQBEpfcDiUWGzMRsusT1bjDP+P32IDTkuxIXW0=;
 b=JX2N07S3Vl6p52/AFBZpNLpARiEi/+0ZNiqcpdBLPEgMj7GIPLr4fE43U4MZXANDJEbyiKpzWhzYHdVlmVIR4+OGK74NFF35KP8xI6tIt3xS0ebjlOVjmOnF304dLWVAvM9TJCKhijqkrRghyw9KJzOG9QRYwp0x1nLx2P35G78O/iJV8f45n2LfKGMgeeZktafwfj7KRCojNwdsbVESs0dQ/faniWhFM8UPCi9dpa0ki/RvaJ2hXE4rswhRPA6wDe+zEOg6sV2GxaZ/qOWLoHI7c//ngsoZQbUy4U7Qj8B2U5H6M/Hc1Istcw2ShkxRe7Fs8DzSS2hNtT+t2QSHhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:35:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:35:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:35:00 -0400
Subject: [PATCH 05/17] arm64: dts: imx8mm-phygate: rename uart4_rs485_en to
 uart4-rs485-en-hog
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-5-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
In-Reply-To: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=1663;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HW90x3ZwEXDosMMA6gjW5Q/j7VQ1KUZhAGfk7EyVCZc=;
 b=TTHyKnU4TbLqQuCEqrbB/surxbbpGQfLRbp8+SjVrNVDKePFozRzZaw2gY8R2YSOEyKoMXb5i
 b7XP6sgQmWGDhvO3961Bfx57WIeP2ej8PR9Cxh7CBEcTMsDaX9CewOJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d3c8d9-4e13-4b6c-a0c0-08dcbb515b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXRmK1dPWk5mNjJlOXBCUGl0RkxheU9NRHB2bUNvWUo1bEc4K0daQUJseUN3?=
 =?utf-8?B?dmFTMU1QMENUZGxTcWpSZlUwdjNRMzBwd0w2QVAvMjRsZ1dPVEtpQ0w2Y09I?=
 =?utf-8?B?a2IwY2tXaTZUWXhBU0NKa3E2TC8yQytscGlYeENCbitHWWNYQlVMYWVZMVRT?=
 =?utf-8?B?UUxYOWkyOVhHbDdyTzlJbzBERXhuc1d0WmI1MDNabEVrckVrVTVqTG5GYytJ?=
 =?utf-8?B?UWUzQmpDNERtT2tLaS9WNit4R25jOEFHZm9uNDRMWm1ya0VyV1cvQlFkV2hT?=
 =?utf-8?B?b29xTFVOYzBRSkp4N2RhdGJGc081blJpQWRmN1JuMzRvZnA4VmdMeERsOUxu?=
 =?utf-8?B?cDllRm1LaXE4ZE4yMGJhQ2FJWkJiQnJYVVRvZUg2T2pHOHFCUm0wZjR5VEp3?=
 =?utf-8?B?SDZpYzRmZC90ZlcwVzF6VU1GMldUclJHaHA5VituVEduU1ZvRzQxdVFnSk1B?=
 =?utf-8?B?Ykt2QlNXMzRVaW9pb1MxRkhyNVd5bzN1ajUzd0Z1cGg1YVVjSGVyWnhEZFgz?=
 =?utf-8?B?U3I5YVR6RnNKWTZFVVNlRWZKYVhEZGNPdGVHa0loL2FVUXZ5N1dhV1NscnVj?=
 =?utf-8?B?M3JqRXJEVDI5ZWtidkxXRnE0V3EyNk9wdzFwMHhuNzYwaUE0LzFZQVlKTlFp?=
 =?utf-8?B?QTkyRVdkZEdpWm5wMk8yakVRWjZXS0tzZmY0MUpnSU9OZDM3WlE4aWsyT1kw?=
 =?utf-8?B?Uk1nbjk5ZVMzakJwMS9VT2lnU2ZkVG9Vd042NG9rUWh4NC9ROWN5TmdmVEpF?=
 =?utf-8?B?RkMwd1p2blJWSlc3RHJoMnB4L3pJYWx3Zit4OVFNUFowd0QyYmR1YTNBK3NS?=
 =?utf-8?B?a1pqM1ZmZFN0NHpFdDdCaHVXaGdWc2lnbCtDVWd0emFNMnB5K3ptTVV5MGZB?=
 =?utf-8?B?L1dQVTFCWTBTZTI5MklISnZiL3IvM0lHTmt3QWZEYzREcnA3VU94OHZ2ZlNJ?=
 =?utf-8?B?ZFJwdnpqS0RFMUlnb0ltYmtGUnNrd3VQNXdHMGtrckVHbWVrSGhUVzNqaHVV?=
 =?utf-8?B?anlWTkluQi9iRHRIMFdaVElMbDFyVjNRSFhqV1E3cXNRYzdrZ3k0V01RZ0k1?=
 =?utf-8?B?dkFyMU5xVDNUUTRYUWxCK1VhTWl0S3lsenRKUTJSTjVkZGV0K0xlNzYrL0dU?=
 =?utf-8?B?MWdZaC92S1RDN29YZWVjcEFRRngrY0htN1RZRFZhdytCakNKNGx4dER6dkhY?=
 =?utf-8?B?RXZFRmR1allJc1h2ZHhDa3JUdUc3UVd2Rk5lckd0KzVZMjJPRStWMTd0czFJ?=
 =?utf-8?B?M0lKS1hVTWRwMytvRHhwYWt6Um1pcldxaEJ0ZG9wcXM0QWFBQXVraVNyaEVI?=
 =?utf-8?B?QWZBL3FBU2Z3akJOcjhvUVU4dUtDVXZoWTY5SjNQR2VPMFVIYXlnd0tQMUVP?=
 =?utf-8?B?dmU0RHkyNlVNRzlvQ3AzMGIzU3Fod0VkWld0QWw1ZG14cUhpS25XUzJoRE40?=
 =?utf-8?B?TVpmRUhBSkFraFdwRm9oalNXd2ZzOTQ4SnRZV0k3UDdzdE9jZjdRZHVQWC9L?=
 =?utf-8?B?KzZKcE51Qmp3ZC9FZWhkUmN0UDd0b1BXS0FXN3pPVDBDcEhIZGdBcmNqSHBD?=
 =?utf-8?B?VTFLZktHYzJtRG9UWnpXbktoeUs5Nmltc2J4QnQyeHZINlpMUVhURG1zc3V2?=
 =?utf-8?B?c3hDNHFKNkZiLzk3RTNPeDNWV1IxZGwvRTVFRUwwS1NYalhqWTA1cHVRSmhI?=
 =?utf-8?B?K2Q2NzIra0xLTVVqNDcvNlFBQ0JTR05hcm95NzdyN2VxWnQ1R2o2VmFqdmxv?=
 =?utf-8?B?QnhFc2MwWTVGZjJhUi8vb1FzelRWdG1hekE3UUNwSFUvcXNnR0VLT0I3TC9D?=
 =?utf-8?B?ektFSEtkRjNQUGtEK2tsL2h6dkI0eVhCbmh5dG5kYUlMOFlBQ3pDeUNZOEJE?=
 =?utf-8?B?WG9WeW40OFM3aURTR1dWRjhDWU1Ld0tidzZ1dGp5Y1UvQnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWZzeUJENDNWY0R0VHVUbUNvWW9WTjd2V28wOVJ3RXJ3ai9VVzg5dWJYMm8z?=
 =?utf-8?B?NkNma2JRZTBINUJyVWc1QWh3V0tYaVVDSHBrbVBQWGRFOTFWb2xNMFpzZHp4?=
 =?utf-8?B?dVR4eHdwQkpGSmhtSjRiWXpHdDBZM0lIVTUzTS9iM0JaZnQ1RTROYURmZjhQ?=
 =?utf-8?B?enFQenNoZStOOWk2QnVEZXU4aE4xaUF0T3BqdE5HSkJjYURuV2Y2aHlVUlcy?=
 =?utf-8?B?M2hYK3NsNG1HaUNxK25oL0pWK0cycWNUbzZHTXBwRVpkZkd5Q1VCS2RXOHFl?=
 =?utf-8?B?SUdybjA0SktBMkJpMzdsSzBaMzRMYVZTVmRmOXhTSDIwQ0M5QzJnTW9YS29M?=
 =?utf-8?B?Q3dKeUdmR3JaTmNnWDVtSG8xMURZNGtFQk4rMkVXUGtnRXhPVmF4cjFyMU1j?=
 =?utf-8?B?c09FK1NLU2M0WlREVFhCOE9sZUFMRlRwbEFabEtBakJWWWpZQUJuTEh3TkFT?=
 =?utf-8?B?aElQMTN5cG1Jek9zSEJ4U21YS0dINHdWaTgyY21EWFFKU2hxR0dSNGtHVVdm?=
 =?utf-8?B?NkNmYlVhODYrNTBPZ1p5eG05U21uZHNCMVkrcy9lYlpEUTdUU0x4dDJPSUFm?=
 =?utf-8?B?dWx4S2pzVkNhRlJmVWhXdFhreStsakNEblVSVUhSM24vQzBFV1pta3BVQ3ha?=
 =?utf-8?B?NGlxM25kZFJLNnhCSnprZnVQSWlrY1EzdGZSUWZhSEZIZXVDbHc2US90eWp4?=
 =?utf-8?B?V2IrRHBRMDBYdjVrL3dBamVDNk5GQ25BbGxrQm9KbGo4STgrdUEvQjZEQ3FD?=
 =?utf-8?B?SkIxeDE3TDJqdC8zY2VHdS9McUw5Zk1icEQwaGQ1VW1HN3pPMisrZ0JTRnhm?=
 =?utf-8?B?UkloTC9wemdxdzY5Zi9YOUI5YnljS2JrVFNBZlVVRytHYXUrQ0J6anFmaTNm?=
 =?utf-8?B?alZMZFZuQ3B2Q3lHWnJTQUtNQ1hvRFdDOGlwM0ZlajZPUEE2K0ZrNEQ0eEsx?=
 =?utf-8?B?UDJjWmFScU5JY0JsblJic1V1TUQrUEwzR3lSaERJeVFld1QweDJUUzRBNUti?=
 =?utf-8?B?U1gxVDlaYm5PczhFeTVLaUNwZ2t6ZnFMRDZmSmo2TnJ0WFJBZGd5clZVRHds?=
 =?utf-8?B?cklWUUw0SWdEUEUwQ0dPYTN2TEw1NE1aazMvMFIwS1VrT2k2cUYxVXNibDRp?=
 =?utf-8?B?ZGJucnRlK2hNWmt0ZmdGWjJWbGF3emY5WVlJUjV6KzRZaC9NN2xSR2I1a3By?=
 =?utf-8?B?djM2WTFKdnhyZmFTQVBPME0rOGNGeGZaT2R0LzZHOWVkanZXcVZwOVBrcDUx?=
 =?utf-8?B?NHdxRzBPbEdmSS95Y0lxck5OTlZ0bU0xaXlRNGlFWk5XczdEZnFSZ2VsaSts?=
 =?utf-8?B?b2NFVjNlRUFjQUQ3SFExTzJGbHVMSHZ1L2s4TXVydzJvR0s1Mmk0N1VpdHlC?=
 =?utf-8?B?WHVGYklIMW9ySkVuNlpXcStzbjBETTdWVUtOc0JPWm5LSUgyMVkvb1BMT2pO?=
 =?utf-8?B?WUlsY0t5TDVJelNTTitUVTI1NzNMOUhDUTBFa2F5bW1Nc1J3Q3NtMVRZRnNX?=
 =?utf-8?B?Y1VYYU1TZ0pTUDJDMHNIZWQ2UjRxM1pPNXYzMnRoRWdsRmc2WEQ2OUYzNVlx?=
 =?utf-8?B?aXRWcXdjV1hHaXJQc3pOZ1BNT2ZwcmVRZ1hlZmF4aWVqalBCbWV2RFpJOHdU?=
 =?utf-8?B?SFpBendHM3hkMnVXcUpiVkJzZm9VNDV2czk5ME9RUmRUR2UrUjFJZ1lKOU9H?=
 =?utf-8?B?WjVNMWRoMnFWUVVrNjlnbStlcndRS04vNGU4bXA5UlBSK25aQXUwUTdqYXph?=
 =?utf-8?B?bXJiODBGcUMzQk9sK3pCczlWTjlCYzJUSEJMMHBhZlZ0TTNUeWFSQlZoNktv?=
 =?utf-8?B?QkFrak1XdGNab0lGODVIYUpCL3FzVXpVOTZhbEZRc1QrY3hIM0kwbnR0L2JJ?=
 =?utf-8?B?NFdKS3paU2dHR1M2QkJmNm9ndVl2OHd6RDNVQnVHOGJtS1F4VFlzZVk1bWdT?=
 =?utf-8?B?blpIU1pZdFVvM283SGlCQkxWR1ZmTXQyaWJ5dW9KNmhSQUVoYnljZ3NBYmhY?=
 =?utf-8?B?QlpzaXAxUWFKMFVHbTFwK0VSdTBhNk9yT1pnSE1YU1B2d2FZQ1VTYnREQ1FY?=
 =?utf-8?B?MDRtVzB0cEdWb2ljd1dNc2dScWxSV2hrRTAxekQ0K0QzTHptbWZkQzZFbWNX?=
 =?utf-8?Q?0pMSbKByUfB8cgX8m+iXkFsXN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d3c8d9-4e13-4b6c-a0c0-08dcbb515b1d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:35:27.6137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqwIclhoU/iLbAfJk59bvY6MjffSzRpoWPjcP0ziDkrv0Eje2dr4e6Gn5yzqD1eGGlWuWdPEdeyXH8Vrbv77pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

Rename gpio uart4_rs485_en to uart4-rs485-en-hog to fix below warning:
arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtb:
  gpio@30220000: 'uart4_rs485_en' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
index f1f38b739ef76..78f4e8d5814da 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
@@ -18,7 +18,7 @@ &gpio3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio3_hog>;
 
-	uart4_rs485_en {
+	uart4-rs485-en-hog {
 		gpio-hog;
 		gpios = <20 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
index 1d8951e1a47e8..66288948bdd39 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
@@ -19,7 +19,7 @@ &gpio3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio3_hog>;
 
-	uart4_rs485_en {
+	uart4-rs485-en-hog {
 		gpio-hog;
 		gpios = <20 GPIO_ACTIVE_HIGH>;
 		output-high;

-- 
2.34.1


