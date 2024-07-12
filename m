Return-Path: <linux-kernel+bounces-250226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08F192F56F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7676E282F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC4213D610;
	Fri, 12 Jul 2024 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F/daEBIV"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC513D511;
	Fri, 12 Jul 2024 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765402; cv=fail; b=eyWkMlXMCvxErihvPgQZx/OqQTSJ8YUErtluAyFfbUXsnD/t0QDythtGOOBRDuqtw02ncW2F108meICBWSPMFOoxxdgCWpooa6KW4AvUeHX0kMeJ5oDimuUI+d1JmNf15Ls4Uk/ZsK/BzeOUe2wgbe/IxARElsLOf8f+pMH6Xnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765402; c=relaxed/simple;
	bh=FwHu8HOgjdeesS4jBLvkey7Y+WnnBYkcgUp1hGR75ZU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mgiY6FWK59cKJPqMjaXft8NLQWC6N1qOjtU1jgTLZPGz3yEbsTHHe1q4QJIB53HCmmkUoUGQMvgEyrpU1BYG7HG5xWOx9vugHF0cDz9UR/MzlC6NONaBATlZV4mdAl00kQL8g9huKBFkvm8IsJFGK6lwafaKKN0UPsNgvT/wc4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=F/daEBIV; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWnt4hAkZCw8a3wwh6b0IdUkKjFKWtuGcXHywIS1Ml/RrzGO51+PEsZZCOgLQ+ZX+0I1QzIuN1OdwLNmLS6qnkRo8mIjjRkmx7h9bJpz3jJitAYA744469jZ/g9nLzEQM7fFGnNFBkZWV7uwt4QmHMv5iO2sT7D+rdWzg/v3xDCeRjE+9BL2E+zOTpvfmVtZqUxe4ls6zz0VHDowgrSE+RGHsiiMI49XZWBA8fvzVkLm/quc7L43mhhS4juTKgVgz471QWYyKspXDY+SzJuhtOvsCWWU33Mdocn9idsOBUJt6TjrX20J09j3MhKtlyYHmfLwIoTji4pGwTXi/3PRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rydjPSyjFpE1b+KVUJhSPw9jPLhoKfIzwxtGoWGJhg4=;
 b=Es/cPaMwkBrSEfR5Pgtp1GUSqkNG3yG11EHjB7HzMAGorT+CUHKLPNmnVur00/XsaYO+RjM/hl/qaJnRz0ubxYkahov+kDnzTsZ5WdwptvJ1gEe/DreNn2wBrT4rtLkhsaYTlk5AU2xySmVj1S0DhmIxpRc+TkVN+5ZkH4mQld5H6SW6BH/1OpzrwqR7cN0kQYwrUBxjb0K87DCkpelONFliG36nX7ogdtYrgA3IvVyM8kJ3jBn+L9K4pkXIhvMRVuoJ7gAeApUubNOVeYDwtOUunt1ZVSTAMQBtMbctn/uC8bmDOS/EszS9z2PPoxrurBHEKIyldt9alJe2bosb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rydjPSyjFpE1b+KVUJhSPw9jPLhoKfIzwxtGoWGJhg4=;
 b=F/daEBIVZo2C4yDyT/Z0bWg4hvOeYDD28qD6VtmKm3FRJKXqnSiJDdQf+7ZHKdcBGoM4b6n4qeS4oCFUkmSo0V552WQzPKwP6SvqY6TgnQXzXyz8Jv1M2mm48b3KaHEXOOfo2Vo65jHVHKlORaHUUBvMYUk9FAcbR13om1F4Cj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 06:23:18 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 06:23:18 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Fri, 12 Jul 2024 11:49:56 +0530
Subject: [PATCH v5 1/5] Documentation/firmware: add imx/se to
 other_interfaces
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-imx-se-if-v5-1-66a79903a872@nxp.com>
References: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
In-Reply-To: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720765211; l=6679;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=FwHu8HOgjdeesS4jBLvkey7Y+WnnBYkcgUp1hGR75ZU=;
 b=RD5rtwxBrO46VyRWWD++pn/rgjgg4wsYvG3GphfG8JxJ6bkSM/6sDtGpWCpyfOUgU7fia6/zL
 /RjEZdDSbqIAsuLUVq61NoOlpBRN3MZG0w4j7vJJFAiUs2s46LF5+HH
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c218f2-583e-4e51-17a9-08dca23b1eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVZUdlFLeEptenF6UGVkTjV5dEMrbGdUOGdQTjlzVkRNTUxJckUwWDQvRUE0?=
 =?utf-8?B?MStBUEIzVXR0ZTZ1UmdNdG5iZlNDUFBveFpwakhDM0JRTXlKajVLUHVJSGRP?=
 =?utf-8?B?azByaWRkYklmNjZEL1l4RDNncHd4RTczMVZGemZ3cWFMTzU0ZS9QM0I0eDh5?=
 =?utf-8?B?MUtLeW5TcjY3QnBjN1MrbW9qNEQ1QVdacTRuQjRESDl4K0tCNzFwNFpTTGRB?=
 =?utf-8?B?ZWVTbEROMEtJODl3N2VoZUxMTEFtWmZxVWtxc09yUlBDbmdEaHA5eUFXa1lF?=
 =?utf-8?B?NjZjN2pmNFBGRS84SElxbkIzcHI5UVg3Y2xwSzByVkhacitpeXNpdytBbGdV?=
 =?utf-8?B?VGpZZkh4ZEhoWUdVRU1mUXA2WGJxWjJ1T2Q2ZUMxKyt0cjQrWTFRUC9EVjFK?=
 =?utf-8?B?QXBkd1JTSHR0dDdpaVRWaEZ1YnBldW5JZnlhMy8vYjVKelQ1Z2FGVjlhZG5O?=
 =?utf-8?B?a3hjdDE1ZHFOZGdmeWI1Tkl1VmpWZURLOUNIcWphZXptTjJIL0xXbGtDd3Av?=
 =?utf-8?B?VmNmZ2YxbFdjVytYeCtGMngzcFJBVXZLS3FIeXBNUFpOYVQwVlJwTEtUdFpD?=
 =?utf-8?B?TmFmUERBVzhKSmJ6cU0yVWgxQml0a0x5S2ptaWJjZ0xPSEw3dnRWSm95dU5y?=
 =?utf-8?B?aTI2R1ZucUVidVN3dzlvZUVKSkwvMzZnY09YNzJuZUR6RzFLUDNQbXdCVy9t?=
 =?utf-8?B?K2I5NkxMemE4VGJNaXl0d0hOTlJiQlcvamwvVTZaNktMeElvcG5yYXIrYVhS?=
 =?utf-8?B?MGNGbzlSQVdLcnExY0doOGhHQURLemVaZ3VkOXFEMkduOWl2Z21UUHdBU1RM?=
 =?utf-8?B?dHhMbjFHMkgrWWhvclg3THZBaXBxaG0zbUF5L05wV3FHOTl6WEpGZ3FwQ2Rn?=
 =?utf-8?B?ZjUzVGFzVTVMQ3RGeUVRY1VvSC8wWWhJVlUwT3BqK1dBa0prNHFETzFkOHBD?=
 =?utf-8?B?RzloRDQ1NTF1ejIyTVBKTWEyUWM0bTBQVXNVdXhUNlpqVU1acVRkWVlEejM0?=
 =?utf-8?B?Vk1ROFB4NXpnSDZpZGh3Yy9UOUVieXlVamZZSVUvd3hDYVJPcmlpYUlLb1cz?=
 =?utf-8?B?U0RTOUJxYmN2akk2dVg4WGFUZzlaM2JkazhSNmIwalhVQ2hiM21QUGNkV1M2?=
 =?utf-8?B?dHhPZDRXNW9vdVFOVkR4bzREUitEeWVtTkVoN0llOXo1L0RGNWI1VDcvclA5?=
 =?utf-8?B?MGJ0enNIR29Ob2RDeWVnYjZEVWpIWnFJRUZKSFZTVVJ4NkQxaEYyeEVMM3hh?=
 =?utf-8?B?bUNKTG9ya0hEZHlvSWFCeVJNejZXUnZxMU9EQTIvQkVFdGNhRSs5LzhpVFdR?=
 =?utf-8?B?blVIQVh5bUZrWXpLd1RURTJSL2pDVDUvNHFmSm5WUGp3VTFaUkk1V2NXRG9H?=
 =?utf-8?B?WFgyN1VjbEdpMTI5L2IyODA3QnpOQ2tqd09JZkwyckpmQ1Btam1sUThmWXl6?=
 =?utf-8?B?MkRzY2R5M1Zxb0YwSzJGZ0xsRExIdG05R1RyZUd4cXhnMGw2U0JnUHU5Y05G?=
 =?utf-8?B?bWdxT0ova0dkcm9XZ0dGbURJd2d0cVVISHdjU2ZRS3RXaHo5cWt6ZVJUVHY4?=
 =?utf-8?B?bDZqcCtiQzBYeEtNNzJ4aU1DeE9Pc3hSUkd4ekVXZWtUa2F6b1U4bnF1RlZG?=
 =?utf-8?B?Z2hvcE84b3FUS1BYWmNTbTFBYTQ3Vmw0SFFyR0RWRU53T1oyOWNqbm1TcTIw?=
 =?utf-8?B?akI0S01JUnZubTNwQnpzUnRYYXRpbHlZaWRCcmVBR1VrMUVpWlRtVXJlbW5Y?=
 =?utf-8?B?eFZMTUpBazQ2OGdTSmlvNGZtSEtRQkwrSHk5OUwycUM1WVhpcVZrS2hHNmpn?=
 =?utf-8?B?YWZNNjh6Z0pKSTRQV1JydDQrK25vYk1EOXlRbS9acmJzckNHQUtHWVlteFp6?=
 =?utf-8?B?NzZsZFJrUmJkZWxUMEk0aTR3cDNuRTIwNlpFZC9EeHgzVlBoQkxVbEtLTmtF?=
 =?utf-8?Q?QhAAWxWawuU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGMzQktMdDkxYTJhSkd0ZjB3RUpraVlwRHVSQ0QwVndLZ2c1RjhXMjQ0YTMr?=
 =?utf-8?B?WE1zYW9lcTg3aHE2b1F4RDVyS2E1SnBWdGszRVNnRDFHb1hSNCtCYm5rUDhk?=
 =?utf-8?B?cW9GYlhiVlBrZ2hSd2w3b2h2OHpBY056b0lLQW1ITFo0WHBzaisxeXNpUG9w?=
 =?utf-8?B?dmZzb1JHajQ4Rm5SaDdWSWtrR3pGOVBYeUwxWHQ5LzNVS1JvUVhmenhnYWxn?=
 =?utf-8?B?MDM4OUVTQW9jMWMzWUh6bmR0MnA4Z0NJUDYvd201OHluNHVEOW5kc1RzM0RH?=
 =?utf-8?B?cHc0LzhoZ3hwcEljZno0a1ZVSkozVFJvSkVTdEMzbTYzbFN3UEQyLzI5NVNr?=
 =?utf-8?B?T1JNUmhEUmU0eU5hQk50cWo0azd6djg3c21vK2JjUG5ZMDNYVlZFYnc1LzhQ?=
 =?utf-8?B?ZFRoV2xZanVSU0FpYWpkMWEyd2gyNCszSmRTWkpITWI2c3ZuckE5dm1HbUR6?=
 =?utf-8?B?aTJva2lKVWppNjJwSHdTNEpBYmxNbjJOcEI5STZuVmNVcldHdzVyYXdQYkEx?=
 =?utf-8?B?S3N0RmFYM0VRRlh3Z25JdElGWlI2a0NSV1pwS0kwWlNmY0xvbkdMYXYwd0Z2?=
 =?utf-8?B?SkpZQXZnL21mY05JL2ljZE9lVndGTFVFUE1Ba2ZHc3oxQ3lvWjhzK2ttVkM1?=
 =?utf-8?B?dm84eFFqUmVjMnJJNklnTTMzM1NBWjhwTDhJbkhPMlBpUFdMK1JhN3EwWHJk?=
 =?utf-8?B?Rk9EUkY1STd6QkJNVUhTR05sMHFRSWh4UE9vMDJzUnVGSEI2WWZSZnJ0SkJY?=
 =?utf-8?B?bEJ3RHFVMkZRL1hEOG9KOTI3KzFvKzJUQjVRdDNwd1haM1M4UExveFFGUFdK?=
 =?utf-8?B?dU9KbVMyaWpsUFd3VkZyZS8yN1Q3UnRpMEZ5ZmF0TVlOd0QrUzlYVzdYSU1t?=
 =?utf-8?B?dGwvUWdobWVFc29EMm5YK2xYZzIzRmpvUk9mdmNtYzkvSlI4U0lyeXhOVUJC?=
 =?utf-8?B?N2pDcmlieHlBa0dQdHBLbWt5NUdmOTdLUFNoMnJ6WVhRWng4SnFHVjJmYkNy?=
 =?utf-8?B?TjVrdUg0Tm9FcXM5RjJPa1M5UllEVnROY1pDcDVJMGxSUUNkYzFBZ1V4VDE1?=
 =?utf-8?B?MEszcGlyOFY1d1ZiM29wcFdXSlF2OHl6K1pmdXR6bml3UkFHcU9CMzIrR3JH?=
 =?utf-8?B?a3ROUEZRZHU3bHV4bHk2d0hoK3A2OTRMUjFNZXVFZFZYZVowSWZDdUt2TjZ2?=
 =?utf-8?B?T1ZNRjRPckNEdHY0UDhpdlZiTjN1VG1TSXpEUWdoL3ZieGtKcy90WEx4ODF0?=
 =?utf-8?B?dWg0VzN0VCtpRXZRNVM0N3VHSVpicW5LeTlZRENxTE5tczZEdlRyMGJ4MjVK?=
 =?utf-8?B?WU92Si9FTTd1S3Z1TG5FZXh2Uk02K3VpdTVOK3pWNnlYNnVxMHBWc3Bqbjd3?=
 =?utf-8?B?UjBzRldRQVQvVzhYYUtRVTdqWmZnWUtWYVVzSG5kVzFPRFZCdXMrSVVvZlhq?=
 =?utf-8?B?ejh1N1FEU3hFdHg5YWlYUGtsZFV5U21QaHcyY2x0cEx1WitDZm16dWxkU0Zu?=
 =?utf-8?B?bzQ2V3BaN0hEN25tK3p0c0ZGVTNTVzV2YmxBV2hkQlpuV2szTVRGbzB6SjhM?=
 =?utf-8?B?dElXZFRsOW5meXZOUVFjMU5TWFVaeE5pcEd1WHZaUzNCNW1iQkJYeU1CWHFo?=
 =?utf-8?B?UFhpb09TMlBGMmwwakZVa29lUVhYWkorTTR5VDlUa29yZmF4VmZZUE9RcWpU?=
 =?utf-8?B?MmhCUzY5RXpzaDJSNzVRVmMrK3Q0M2xMaVMxdkFkYlovdWliSldwL09VeEVs?=
 =?utf-8?B?R3h3eXVnZFJIbTNKZnU3WFhXejZFZk5uTkdPUDJ3YysvSjIvVW9jQzlGUkt0?=
 =?utf-8?B?eDRSOEgwZ2ZjemJIYWQ3WFMvZjU4bzg2bythVkphd25UcVMvb2gvcW5LQUlh?=
 =?utf-8?B?UFYvSHpLTmxjRjhBUWlzYUdOUVZabjB1NFJEMStnK0I5dlFCZUlBY2dvMVFP?=
 =?utf-8?B?Q3YvZ1g4ZXZuMTZvNEFPam5qejk5STdxNmdMWTQ1UU84N2doYngwTnVOZlVq?=
 =?utf-8?B?bjY4MGk1UlVvVmxoWjhlcjFLT2luSHlVTjVlRXpCU2lFQm05ZzFhWlRvYlVP?=
 =?utf-8?B?MzQ0VDZNZjdJOGQvcks0b2d1cW1KTHkzQitpVFVtWmQzZ0thUXFrL1VZOVIv?=
 =?utf-8?Q?IGMRrsG/7y7YQ9GFK+tdiCRXD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c218f2-583e-4e51-17a9-08dca23b1eef
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 06:23:18.7089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YznCul5qZ6GgPcMu4bsef0ISkZugAOYoKHKiWbjqHhZgnxeq+hIuP9ScL0p7X1YPF33Asr84P3v4nhq1v8a9nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

Documents i.MX SoC's Service layer and C_DEV driver for selected SoC(s)
that contains the NXP hardware IP(s) for Secure Enclaves(se) like:
- NXP EdgeLock Enclave on i.MX93 & i.MX8ULP

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../driver-api/firmware/other_interfaces.rst       | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 06ac89adaafb..a3a95b54a174 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -49,3 +49,124 @@ of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: drivers/firmware/stratix10-svc.c
    :export:
+
+NXP Secure Enclave Firmware Interface
+=====================================
+
+Introduction
+------------
+The NXP's i.MX HW IP like EdgeLock Enclave, V2X etc., creates an embedded secure
+enclave within the SoC boundary to enable features like
+ - Hardware Security Module (HSM)
+ - Security Hardware Extension (SHE)
+ - Vehicular to Anything (V2X)
+
+Each of the above feature is enabled through dedicated NXP H/W IP on the SoC.
+On a single SoC, multiple hardware IP (or can say more than one secure enclave)
+can exist.
+
+NXP SoCs enabled with the such secure enclaves(SEs) IPs are:
+i.MX93, i.MX8ULP
+
+To communicate with one or more co-existing SE(s) on SoC, there is/are dedicated
+messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
+MUs, dedicated to itself. None of the MU is shared between two SEs.
+Communication of the MU is realized using the Linux mailbox driver.
+
+NXP Secure Enclave(SE) Interface
+--------------------------------
+Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
+multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
+that is/are dedicated to a particular SE will be enumerated and provisioned using the
+single compatible node("fsl,imx95-se").
+
+Each 'se-if' comprise of twp layers:
+- (C_DEV Layer) User-Space software-access interface.
+- (Service Layer) OS-level software-access interface.
+
+   +--------------------------------------------+
+   |            Character Device(C_DEV)         |
+   |                                            |
+   |   +---------+ +---------+     +---------+  |
+   |   | misc #1 | | misc #2 | ... | misc #n |  |
+   |   |  dev    | |  dev    |     | dev     |  |
+   |   +---------+ +---------+     +---------+  |
+   |        +-------------------------+         |
+   |        | Misc. Dev Synchr. Logic |         |
+   |        +-------------------------+         |
+   |                                            |
+   +--------------------------------------------+
+
+   +--------------------------------------------+
+   |               Service Layer                |
+   |                                            |
+   |      +-----------------------------+       |
+   |      | Message Serialization Logic |       |
+   |      +-----------------------------+       |
+   |          +---------------+                 |
+   |          |  imx-mailbox  |                 |
+   |          |   mailbox.c   |                 |
+   |          +---------------+                 |
+   |                                            |
+   +--------------------------------------------+
+
+- service layer:
+  This layer is responsible for ensuring the communication protocol that is defined
+  for communication with firmware.
+
+  FW Communication protocol ensures two things:
+  - Serializing the messages to be sent over an MU.
+
+  - FW can handle one command message at a time.
+
+- c_dev:
+  This layer offers character device contexts, created as '/dev/<se>_mux_chx'.
+  Using these multiple device contexts that are getting multiplexed over a single MU,
+  userspace application(s) can call fops like write/read to send the command message,
+  and read back the command response message to/from Firmware.
+  fops like read & write use the above defined service layer API(s) to communicate with
+  Firmware.
+
+  Misc-device(/dev/<se>_mux_chn) synchronization protocol:
+
+                                Non-Secure               +   Secure
+                                                         |
+                                                         |
+                  +---------+      +-------------+       |
+                  | se_fw.c +<---->+imx-mailbox.c|       |
+                  |         |      |  mailbox.c  +<-->+------+    +------+
+                  +---+-----+      +-------------+    | MU X +<-->+ ELE |
+                      |                               +------+    +------+
+                      +----------------+                 |
+                      |                |                 |
+                      v                v                 |
+                  logical           logical              |
+                  receiver          waiter               |
+                     +                 +                 |
+                     |                 |                 |
+                     |                 |                 |
+                     |            +----+------+          |
+                     |            |           |          |
+                     |            |           |          |
+              device_ctx     device_ctx     device_ctx   |
+                                                         |
+                User 0        User 1       User Y        |
+                +------+      +------+     +------+      |
+                |misc.c|      |misc.c|     |misc.c|      |
+ kernel space   +------+      +------+     +------+      |
+                                                         |
+ +------------------------------------------------------ |
+                    |             |           |          |
+ userspace     /dev/ele_muXch0    |           |          |
+                          /dev/ele_muXch1     |          |
+                                        /dev/ele_muXchY  |
+                                                         |
+
+When a user sends a command to the firmware, it registers its device_ctx
+as waiter of a response from firmware.
+
+Enclave's Firmware owns the storage management, over Linux filesystem.
+For this c_dev provisions a dedicated slave device called "receiver".
+
+.. kernel-doc:: drivers/firmware/imx/se_fw.c
+   :export:

-- 
2.34.1


