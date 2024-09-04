Return-Path: <linux-kernel+bounces-314812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2871A96B95E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5C31C24FCF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD8E1CFEBE;
	Wed,  4 Sep 2024 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hTWZI5nO"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058D1CF7A7;
	Wed,  4 Sep 2024 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447337; cv=fail; b=JHCRu0j1yFAGh6Ff5NZfvk3lu82bIGRtFJRVdIsJMLAP8iMSH4q5Pp3IM2hiVaKwyccJiVjYU4U+oC2x20rMJPWgdsuMzAJ067DXYAyQB//Wu+ypbJhaP7Mz28AwZ+dFrsHiPzAxpFtfgRrSqExGkGSLp3ceUmU4rvDe/yiPmrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447337; c=relaxed/simple;
	bh=FwHu8HOgjdeesS4jBLvkey7Y+WnnBYkcgUp1hGR75ZU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ffX/BgRyOUl6MU/yT2igtQsGt2xdPpVIAomFF0DYhaoGKevOgltyQVTyjnPQLeiWUFWvAktCT8326EXXnlES3EBAVYRnsafcF4jlcez9TqB+T7eV2EH1vHixIpjjlLEElinMm79oMv95SmAcH3aThOxQImGA5lFjGYN2AIPDO9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hTWZI5nO; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuUycfwKuDS07l6+H5ncwIjvzy4a03265ojVSOoGaFTsRXdAZHSQLrfie+MNlml85xpvAu1UzwssT6k6rFefk3sIwQC6vxw8cpdWlOyGPREFrW3UH+nPn9Jjio9CwEtlpvIMFOcUFT3Z2jYrf/5RqpoB314gyWmcDsQZGFOeXH/DOcG8vlUDDhueT4Qj/LYlnjfe85S6FKGmbY4Bnhk6pSRr7P4fpaA7VMtSE8yZFV7QjXk8hOYLlTxNC3qVVmZ5TxvkfP9mNfoZPLb/3nZ5B4A4inEVlP/W0F55vB3rzBLG0dTu+yX8sjRTycHbo8RnKTavfO128wVGCRQfDbnLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rydjPSyjFpE1b+KVUJhSPw9jPLhoKfIzwxtGoWGJhg4=;
 b=R6GJjdbmhz9tjgvFYMBRoTFGadqDsaDMqJn6miTYeUAV+H/Qi8waxOSFvFvh242CC/S6maIhMN4w0zp3Flca0JJk+SwaGbM4rdz6FvbCzUhOgXqBYj4+h2Gfvk2tH9ziLB6G7DVJhY2Lya+Yj4oQ2ZZ1f4co3/Aee5L4YBePVN6Ydj7dOpJHYUTBEZrXCt3OlEAjNx0Dea1wLmoL3l9mqqvBJmNqx0a1HYaGp+qCUziDpTlDbSjWi/ITfva3EdJfvruracWjDMtb94TAMG4FjeGejiS5rczKzeEpK2wt2Xs3g1l4t2bJliT3FNuV7i/gfNp+AfT8LDfM2Fp1Mmu5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rydjPSyjFpE1b+KVUJhSPw9jPLhoKfIzwxtGoWGJhg4=;
 b=hTWZI5nOjTmG8yQSrOC9nnvJkkuYmVYZIbWPkqhuZetn0jtp3skHWrO2P9gWxs88jTEHssL2t4N6lMC+rQPkSKoAknO9PO4g8D1WfFvL8ZuCTCWP2/tPvYUscDtAvFE4kgRNjp9wSNiaUgmrjjnDu9HUhyIa2RRzR6tbSApH8OQY80RbFpDbgIzN+llT16NW3oveJQHcvVZYG5sE9Xdsuf90M3VDiVRYJktMyfoZ3iuqWorbrKfYjV+4wYXucw0ZL3XRf3h+WzPExX36GFnODA9YN8aYgJFp+pItNSd0NASoH/iFE7A6kgs0xz97Fe538ziuT5xRisedCOjk78JuGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 10:55:32 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 10:55:31 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Wed, 04 Sep 2024 16:21:17 +0530
Subject: [PATCH v7 1/5] Documentation/firmware: add imx/se to
 other_interfaces
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-imx-se-if-v7-1-5afd2ab74264@nxp.com>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
In-Reply-To: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725447104; l=6679;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=FwHu8HOgjdeesS4jBLvkey7Y+WnnBYkcgUp1hGR75ZU=;
 b=CFQ2dR7bZ3jQ2Kh5VOKxn8XPuCrg7pIeyQ6UcEm3wqjDw12DgR2TgZofUdu6tIFvN51Hiy+ON
 o4LmypXiMQ9DefI3JKcUpN8JN46yyI4WKFsqzKyElnpmYgHB6lyosqj
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DU2PR04MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 64649f9c-da98-4ba3-a79f-08dcccd0185f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWtWUTdlMmNlc2ErNjFjUGEwQTRVeHZ2aFNHTmZnL0dvZDZHd2ROM3dxaEt5?=
 =?utf-8?B?Lzd3UVkzcVplNDAveHVMTUVOT2xUc2czWEZaN3c2cXJNMHdaV2VzUm9RbFk0?=
 =?utf-8?B?SnEra1pCeXRKQ2g2S0ZHNkJGYkFLNzZkcDdLM1p5aTU3c2xPRFNpUDkrVVhL?=
 =?utf-8?B?c2lzckE5Z1VJR1lNTHVSNkkrcVZIWTlyZktDcEtNTXhXYW9IUnl6Y2JvOUNs?=
 =?utf-8?B?cmwvdVpIUE9EcU9BQUdtOEwyb3FJNkx2elR5SXZRdVFuM2Frb0Vac3dSdGxQ?=
 =?utf-8?B?TklvM1E0THBrNjNhbDM0V2RtQ0pBOFc3REpma0F5N3NzQTh4ZDNRVjBCcnBi?=
 =?utf-8?B?b2xGQmZwVUpMM0xJZTZRdlFzV2ZPeGZiUWxoM2ZCaXUzMnVlOGt4a3paM2F5?=
 =?utf-8?B?SWIyOXNXNHFlbU9jc3dEWlpZZjkydEYzTkpKQ0MyNHZ2ckJWcHM0dzE2V2cz?=
 =?utf-8?B?NklaRlR2ZUdUZHZ2d095ZDIxRXdRMldLSnZHWEQreU9rb0piOUkrL2FUT1JE?=
 =?utf-8?B?Zm9SWGI0MCtDRk5wWkRRWUFSQUtYMU15U3RqMzVPVG05azhrcU1zNGU2TXBi?=
 =?utf-8?B?Zi82NENPQktvbW1wS2lLYUZQVjhXdk4rMXVudkFWTkJiY1JRRmNqdkhGaDZt?=
 =?utf-8?B?UGM5MVNpbEhVa1JKVkRWL3huSGNnSndpdmRMT3llbDhvbUVGTHFPN09CTU5j?=
 =?utf-8?B?b2VTaXhMcU9zNjRuOGZ3NHRpZExMZTZCZ3dUcnhwcmkrN0RPdnVkUitYQjVo?=
 =?utf-8?B?eDdKWGN5S09jR1F3ZEYwL3h2YU5yVkkxL0sxRmxuaFo2QWtMZFVNUnM0L3Fr?=
 =?utf-8?B?c2ZZVVQvVkZWTmVMTTVTUkZhdHBxVnRhNWF3MHEvMzVOVXFiQVZJalJqTzQv?=
 =?utf-8?B?c0hkTCtGaE9keUlUNmdiUkpZRTVRUVJaaWRpSCt3UCtTNHp0V1IyQzZVY013?=
 =?utf-8?B?dnBJWURLN0RCWXg4Smllb1B5c0pTWEl2eDdnU0EvbU5pcjJURjFVSUl4V3dS?=
 =?utf-8?B?SldjSzZQSmFJSVlxVnBLNDRBV1RQRXkrazZ3STg0YWFvUEtVTnd5anVuditO?=
 =?utf-8?B?UUVOcVI1RThtbVZwTlFLRkNqdldKbTB3cEhKQU1qbDJwNVJHd2o0WlZOdDdH?=
 =?utf-8?B?SGpQU1lJVldoSk1CK0dyRGV5OXNuYVRWUXhMcnhxMUxCeUxDSkhmakNjQ2lH?=
 =?utf-8?B?SU95a3E5SkZZVEl6bEQ2NkhySVR3RTZQMWd4VS93dGFjM2Vha29uWWFITmRS?=
 =?utf-8?B?bVRLWXlGdTk2dWwyTXhtT3o1a3NBd01lMGZWc202ODdzY3VFazV4V1pqbEZH?=
 =?utf-8?B?dnZETFg3eElnQmlCN3ZZbHduQkVQRVhuYXpqbzlzUkF3Mlk2NFdzYUJ1QStN?=
 =?utf-8?B?Z1ExRjkvODZ1a0JMMEdvbDhoK21BVGFsU2pnZjVkdHdKNGtSQ0FNL2VhLzVG?=
 =?utf-8?B?MzVYRVBOM2tMNEhMSllSTk9JVFpJWUs5MndxQndZWEZFMklYSytPdytkOGlJ?=
 =?utf-8?B?Y3RMWUlLazd0MTBubTJJT2J4U1E5UnJuUTZNZUE0UjhvTXRTcWNXNkRPTFg2?=
 =?utf-8?B?QXF2a24rUjV2RHpydUpjSzRKSUI1MzVPeEZ5L1lOdkFZUGtYMGptbnZ4eFli?=
 =?utf-8?B?NUFCMzNQQkJWVVRJVTJNMFdDVGJvU1VKN1NlS3FNVStHYzBJQ0FwUVh2a2dw?=
 =?utf-8?B?azdydy9Qc0FySGZmdzJNWEFZbmxISVZaTko4bkNTSEtmcE93K3VKUG9qZ2dL?=
 =?utf-8?B?QUVPaFdBOVZ3THo2MXpzeUU1NEROTWdIZlZxNm50bk5QZU1pY0xySVJLT1ZM?=
 =?utf-8?B?Qm5LdXpjcWxndmlack5wQ0d2NXlEak5DdWU1dkRET1Rqa1kyMDRJQ2o5aml1?=
 =?utf-8?B?dXQ5djNvdWZoWjZEb3BROTc3WlVlZ2tYV3ZiNy9OcVJHUkozeEhpMWtpWXdm?=
 =?utf-8?Q?Ksc9KXosbS4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0l5Ri9LZ0s5Y2JnaGxYelp2NnZDTUVUNEFMSGZySGhEa1c4Q2dYeitqVHBU?=
 =?utf-8?B?SXA1ZDMwZVJqWDhoakdwQUxUcUFQN0hqZkwrRDR0YXR1L0JsdDl1VUs4Vmtr?=
 =?utf-8?B?ck55bEo5LzliYTJYRENRSURiQU9tYUJBTDRybGNGRUxrYUpZVE5wbUNyN3lV?=
 =?utf-8?B?T3Q2OGRSeTZnUjl5a1pSbmdVQmlXSmx4WVBwb0Z6NXI3L2dpekNLcnZ4Kzls?=
 =?utf-8?B?VHNtdUhFdEY5MzJGeHoyaTBUU2ZnbWdBZm5TMlJuemwyLzhSekkxV0piMkJr?=
 =?utf-8?B?eU5vQnI4MjQzc3dsem9RSlBKTzRVekdxZDM0cUpNMENkaDcvRHlBeHhEY2gy?=
 =?utf-8?B?OCtjUEhVai9rUURlOW5zd05xOXIwRHVtNGRETjlOMTFZSTR3aFhObExLcks0?=
 =?utf-8?B?TXpOcHFsUFc2ZDdzQWVBb05iZUhZSTV5Q3c0UzBpUzhlcHZZVmpxS3FERk1t?=
 =?utf-8?B?cFZDOGVVUnlYUzR5RnJtc0RhMnNQUDk3QW9Ob3Y1UCthOTNhMWtKTFhtTTlF?=
 =?utf-8?B?d0hiOGJWcjJPOWhBVFlvNklnUGtBckkyNy90S0txekFZbnJiOWFNam5lRlhw?=
 =?utf-8?B?QlFsc2MzUFFucnAxNWNQZ0VYaHJPRWpNaGFQeUhJUm9TUWFrTktvd1l5Sk82?=
 =?utf-8?B?MExzekxZOU1rZjZ1TGxXOVN0SnhFZXVKUFR1dXRUa1FWbG8xN05jMUY0K2pi?=
 =?utf-8?B?VkFJbHJsWHJXTk5UemRoaVQvMDNpeEpLSFNucEVSd3lrYkREM1phcTNiL2Vs?=
 =?utf-8?B?TWVvQWM1N3VWSjVzMnFCdTF1ZXNWczRKWGtROWNFUk9GN0VBWStjeVp0Yi9u?=
 =?utf-8?B?YStReHgvTkdWQUNqV3VnREdWbmt1ak5paDJjdDB2WE5uSzFxUzM5TkNmSUlz?=
 =?utf-8?B?K1Nnd3Vnamo0OVQwR0JZcE96RTJIcWVNWjF0UWRUUHd1V2xVdVZCdzhTRVB0?=
 =?utf-8?B?aldrQ2s4MWQvMnJVQ1l1MmkrTldQWWdLOEZSSlBWYTU5Y0FzTlhXdnJwRkxP?=
 =?utf-8?B?OVJZY1diNzl0UGZCK3lEQlVCdThrK0pOMXJ1RklzQmpEVHZrbUpRRkhNZU1a?=
 =?utf-8?B?a3djQVRTc1kzTHFFdlZRRnVROEVCOThSU0FVcmpIcElWdXJqSmE3OGRZbWlY?=
 =?utf-8?B?ZEVyNlVmSi84YzFqVndiR1hOT3ZvS25OVU5hOS9BUG1zWTZQNlBaSDIyd1BB?=
 =?utf-8?B?SjB1S1d6b3ZHRWQ3MSs2d2V6RWNaQ25YMkZTOHF0eitTZGg3dTg1QmZhaDQ2?=
 =?utf-8?B?TUxvWlQzdVJQZmxyVEswU0daOGJXaUhXcndqeXVYNGU1MzdkbVU3bmtPcmhw?=
 =?utf-8?B?SlRmbzhwY2xkc1ZVTHZlM1RGRHZUZUtBNlQ2NGhXN3FNa2tDWGhpeG1lNDky?=
 =?utf-8?B?YUIxaGlRYmxUYkhGbU5jNUptQUYzdHVRd21RcmNPLzFiZXdvejZUcHdhSlJZ?=
 =?utf-8?B?NkYwMnZJZFdFNGZrNkNERVNxemVHN0FROG9BSjR4dG10YmhJaCt3eFNLMExq?=
 =?utf-8?B?NzhjMWdkS1pkUGlQc1JrVERsRWx3QUNtcmNCSDRNbjBlSURTS0t5enVJL3FL?=
 =?utf-8?B?ZWZxMXNVZ1BNQkFaaE5hb0RGNzRPaVo1bTZBdk5pZS9EUDFtdTN4UWNUNHE1?=
 =?utf-8?B?SEwxMHAxNkFqUDExOE1qTEZEZVJhR2FGSmZDazVkd0lwaERBSkVVVU9yWGxR?=
 =?utf-8?B?bkU1MkE1VHhjd0gzTGJGbGdvS3Z1cVdRbllGb2ZkMWJQWGlLODExbVZrYWZW?=
 =?utf-8?B?cjYvemkrdmhqNGVxMjEzU2dUMk5uVFROYTRseXNwWmo4MHQ0dFRZMUsrc3Ix?=
 =?utf-8?B?RURvTG53bld5ajE0M1JUNFRhcmdrMDJWdzBsR0NhaTBZWGNSOVVxbFExWlVD?=
 =?utf-8?B?c0dkcm1VTUZrbTRpWlNrQmJkUlQyTE1KZ2EvbmlZVnJMZ1dRZlphTzV3MkFM?=
 =?utf-8?B?ZHlxQnp6OHkzM0pNR0xvS3JqL1M2Nk1xMXNNMExKMHE1VGUyZmdldmo2V01R?=
 =?utf-8?B?S3NPaE9xVWtXRm1wam16MWdIcUNOUGhYOXhGeHdTdXFrdjRWaUhIWS9SZFpJ?=
 =?utf-8?B?ZGllWHlpQVYzbXI5ZGNicVhzZzZ4elV5T3BHNFlLejgxTjVRd21ISTdTY0t2?=
 =?utf-8?Q?pY0+u/lcSHBcdqV75Emt1V53m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64649f9c-da98-4ba3-a79f-08dcccd0185f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:55:31.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pcy5svWIgGlVyT6YF/iLFkfVlMXpPl4HhtHFDPSFdjD5TGHzAcOha/xvNPYQvQB7iPUtW6lxdtZsy+THj/PyYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583

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


