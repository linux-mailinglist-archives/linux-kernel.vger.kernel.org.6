Return-Path: <linux-kernel+bounces-383573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1057C9B1D82
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BAA9B21137
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A351553A2;
	Sun, 27 Oct 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="M9j3EllY"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68388150997;
	Sun, 27 Oct 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730029806; cv=fail; b=WPB0YIuNm13RVCsFm/c6Q/KddJPYwXNDFhgIzstX2aH0IP0EeCqwpJiDYOVWI0rmJFFUuIhNjdWT8Sq1ZGQWy3i056f4Zc4uoEh4QZVWPMk8p1bxMMWkhmXII30Tx8O/gJh+Tg14nOabAA98Ao8vRPkKlTxquzqzOvnfbrvp5qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730029806; c=relaxed/simple;
	bh=V6y9acTiwqtybC1H8iAA8twJOIdkgZkkpDiPsiQqTeQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GYxXLcq/Cp/hxtnxd0kEPq1qdcPypWMX++yFsmJhrXsMI0uFvHKyr1oEeKg3GXaWvYze5aBrIFlIDcCTH3zfOAWrYxT0deyoIsz61HaTaRs8eppMbSOtdoxE8NpXavFZSm/MqabSmV6C99+YXpgOZdDQsn9NTsBHyNAT0uE9fRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=M9j3EllY; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQfIyI31tbIR2h4PvnWXf2jzWnblITkWffvtm1KKR2vI9oDWtYcQa4FNJQ/h8SdcRXrPjWNdhckGMWLGKj3367+J3ZiovjlbaQrR9Mnm9sSpgX3d5se99v5SVQDRtt4E7m0ad0Lb0/5JuQd23LsOcaL4rj+Q4dRPUCqyjhgTQ7A+i41OHWGS5Sudafr7bBPyAIHurMJFeRIYDEmdgBG3JkJnTZhguIGactvKEDJZa5IMoz64ah7U7JJUYGl5H6K4aXi7F7S+kMNWVMUR7xkKuYksZBSMqgOEeBHoL94jk8EWBQ3yLR0ndHK/RUoK2gnfdHjZlTBc1iZrGJVS1nlkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WECvtFrL6i9TqWUnlboazsCz7Ojc7WJTFHkIjGGXBCM=;
 b=XIHNcTlRoDpPr6/H2RKZmJuundhwLGE06gXt5kJbZVjcAFVZWY/fD3tAp9BSYemp9okGxWW3+lqfjzUNnfhc4HXf+w7eqj2tr/n2yU1z66nH5IGWE3/5urdG2mcEMfuND+kY9+rFiDORAPRrYz+mUqvxvhDT2MiTPjcLixxCjZijt7Geh/3W8NKj+BrJUPE+QVTiw2jFeLhjO/kWmnT81fyphmRpPR0hWacUU5IJqx0src4bNPzcG5lRQlgg9AQ+p09Uc2woAQFZgzgLN6/m2MYsyCru/lL7t4oXqP3xYKu5S+z9CYyvqjT7fzvKpuxNOIp3/S0CLjcJ5rOxjGjfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WECvtFrL6i9TqWUnlboazsCz7Ojc7WJTFHkIjGGXBCM=;
 b=M9j3EllYFA2ryRC7kGReTtCHN7DEPMA86bEq2jw+sA2q7NW6JJZ0LNRDrm0rkvcWl9liJ/w3xw71ST+no96TONE1MMmjJl94TvGuZPLohHZQpcOG1Hccz3rUsQNBfzl/Koj6NIwYzou2x/DMr/+4v6SfXO2upIk5v5mr+r0dtdZtznS5Pue1ZNE3tujXc1WMlP3Yw6EhGeLEK1i2YOQKNdzS9ZWL1tJTIp3qytOfOwwM769RaLPAsZc3wJ5LCUmeF7oMVLBqICih/SkoXuQ01uBTKicI9mTLsaTswgdBm2GXUAVABCDYz0rbExtdalTJA7YtUf55rLoVWtZ5BuH8UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sun, 27 Oct
 2024 11:50:02 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.8069.016; Sun, 27 Oct 2024
 11:50:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 27 Oct 2024 20:00:07 +0800
Subject: [PATCH v3 1/5] clk: imx: lpcg-scu: SW workaround for errata
 (e10858)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241027-imx-clk-v1-v3-1-89152574d1d7@nxp.com>
References: <20241027-imx-clk-v1-v3-0-89152574d1d7@nxp.com>
In-Reply-To: <20241027-imx-clk-v1-v3-0-89152574d1d7@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730030419; l=3213;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=aeiGOFthGwsWpWxLMDzbGyOzHOzdaByvU+6qeurmvKg=;
 b=pw7m5MOW0uwLila30EbATDQCOC2ob55BW8uO/+dR89JpBKRdRawoiPz6suMqO9tJRGhf9Q2QI
 R9aIO/q1+o7DFU/L1BTJDNJwde1sovQt0emNa2dF3GdMiWGG4aI3VMH
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AS8PR04MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edc3ae5-c936-45df-0d52-08dcf67d7dcc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFRsYjd5d1RuSHFKYkc0Q1FOK3JMUHFvNURKTlZjSUlJRFJnWlBzODAyYXly?=
 =?utf-8?B?THp4WGR1WDJxZ25DazBkamszUWhyKy9LUkxXYnQ2NHQxblVRbmpQVU1aUDdG?=
 =?utf-8?B?cVREcHhLS1FpUmFUT2Q5aWZlVW9CaE45YW0wTkJSOHZyUUNTVXBZUFVhR3dy?=
 =?utf-8?B?NGxqS0dmcnhkcnpSNzZUR2p3Zk9aeFc2MGREVG1yZHBsT1l0TnpiSE5UYUNt?=
 =?utf-8?B?ZHRDa0tVQ3Z4RlhiRlJCSDhZb3BteUNjS3NaNVVpYjhUTzZsZGZNMmFmR0w0?=
 =?utf-8?B?Rnd5ZnFqYUk5eGVKaGZiN2RvM1F0b2J2SDFNb1JOYWxNZ0cyVmo5RG1ib1Fi?=
 =?utf-8?B?T2NEK1FzeUs4UmdZR1lTZnJsbE1DWUlLTDdLSFZZNHlmMWxoOWpFZjdWTWlm?=
 =?utf-8?B?bnNEdEpkMEdtK1hHN3ZxSWNFckpJWkVsZWo3OTYyVXdJUFFsa040UVVtOU5M?=
 =?utf-8?B?TzRmZDlQejhXL002LzVSV2plSXFuQzE5Z3FOTnNJR1JJcjAra21OWFlhVjYw?=
 =?utf-8?B?YVl2Yk1zcWpVT01xK3pjLzY1SFZmWXhtTTNPSmtEWVB4YVFFL2I4cHhLTVd1?=
 =?utf-8?B?RkZ4YURYTlZtamJCZHJjZlEvSXNnRVdQRVU3OGlnRENnTXRWc0lTUFdYNk9j?=
 =?utf-8?B?YzlzRjVRTjN2a1FLL0hWY01WRi9rQ2ZrRDMrU0JFTHcxNHo1TXFBbjM4UDBF?=
 =?utf-8?B?aHVLWFlvbzBYN1BZSWM2Rm5TSCswa2RaMWhxWlhGWS9aYjFETm05LzhLMDRk?=
 =?utf-8?B?T3ltQUJuWGdsWFp1K24xQzByRHFvd0g2eXBjeURyS3VFWlBSQnlxQ04xek1w?=
 =?utf-8?B?OVBiYStBalYrNjU0VVM4aTZUNDdnaXlvWUg4Y3B3YlA1T3M0TElvTWdNVmdD?=
 =?utf-8?B?M3VBOWR1MFJCcUVPUzV6MlFPLzVWZFZ5VXh5RHluZnJSMFd1VDZmTUZLS3Fs?=
 =?utf-8?B?Qm80ei9hSVUzTGQzelVyZ0lYSTdqTXJoczA1Z3dNS3ErdzNKZ1FYUkhTeThP?=
 =?utf-8?B?bGZzdXNMamEwZGMxQ2hWMy9LY1NTTDVGNy8vT2FlUkl6WFJaaHZKdm1oWW1z?=
 =?utf-8?B?L29BU29JcE9UNEVZMllIa214WmNqM0xLSVAvcTJYaldDK2h2TWNyOUpaWjZT?=
 =?utf-8?B?bW42RFYzaThSZVVyK3FPVGN1VmxCZkh0QUN4MTREMzdSOWdtVkRaakNGS09n?=
 =?utf-8?B?QURQWVllczdaTXZhUHJyM0hSd1Q1azIzUXllWkJmOHNVR3RVN0dnUmV4TDRQ?=
 =?utf-8?B?Q1JIV3FWRUtpNERGcEh3MkZSUEVXSmh2UURuNTQ0WllLRzZOSE1xYmFQV2dV?=
 =?utf-8?B?SE1zd1M5N2gxVHRjSWZvMXN4RTJmbnphcDEvK1BSclF6Z29OTExxcUNZMFU5?=
 =?utf-8?B?YTh6T2gyKzRVMXI2ZnZVOFZPZkwvZ05FVWZvMnU4Z2NlSllPcWI3b2tQcUxi?=
 =?utf-8?B?VjYycTZ1S0JncEsyenlRdnhwZkxQRUV1bmhlSnM5YitvSkZaYnVJVVVDSWpa?=
 =?utf-8?B?UkY0OUUzNFpuWktxTU9ldjRWTzRBSFJVa2V0alZWVklERkF1WWxLRXluTHlx?=
 =?utf-8?B?Mk13OXBSUUFkZGtqVVBYREtBbVM1OEpmeU1tMFhvRlFxK1ZqLzJLZFFwMFI4?=
 =?utf-8?B?cjU1eC9VaWxjQmUwblh5MnMxcTFpNHBGOHk1bmRUNkV2WmhzS096SkV5RjJH?=
 =?utf-8?B?MXVuSVA1THFvaHJ2MXdKOGczcTZsM2JXKzhpWUkzOXJ2eFQybytuVGhSc05u?=
 =?utf-8?Q?819SK8D+sdZVS/SbKJ/CRXMl9tVGO5twZT1cQUD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnFQaGZvS0tRWm1sOFNxZGVHWGlNTVp6V1ZKUlRjNU9SK0pqWlBEcXFNM2o5?=
 =?utf-8?B?ZS9yOXp1cDdjZUV4S2hLcU5XZUJSYlMvN1M2ektCNERwQXFZWm1XT0gxR01a?=
 =?utf-8?B?ZlBzSVNmVjhXYlpqWDVlVGEyR3JteDJiYUt3VDJSZ3pVbzlFeG01ZVhsdlVx?=
 =?utf-8?B?K283RUVRUWpnSGZwTS9SRXRPUEpIL01WRDZ2aUorRkcwZUF4dXpXT1pPRExV?=
 =?utf-8?B?WVJCbmxOWGQrd3Q4ZFc3anFhMGhGK2hORnlpdVNKVk1JZzI2eHloY0hrSHQ5?=
 =?utf-8?B?c2RyYnhVMkRuN05XVVN0QVhhbkVPTURZQUZXUFhhVDdPV1dldVg3U0g0ek5X?=
 =?utf-8?B?aUtpYmcvaCtuanFVbnlPeUFzMkZnekV6SGlkSlRzSFg0aUJZSllZWTR1WUky?=
 =?utf-8?B?YkNwR2hITUZEeDlCd0lUb3FONURXNUFocTZyd3BTOHNuU3p2QnNYak4rQzFH?=
 =?utf-8?B?TjhTLysyZzhSNHk2UUNaVDB2MkhnbE5ER21sUytvNkx4WDJoQitpU1p3RnpP?=
 =?utf-8?B?UjFZZVh3SDgyV083dlBWb2ZDa1hXTzZxbUp4b1U4Q2tyMlhxOGFVWUNmdHdQ?=
 =?utf-8?B?eFdIK1VKRDRkNEZoMnVEMHA0OVRjMUZDNlJXOE9ydTUvV2FBZVh2bTdyRk1n?=
 =?utf-8?B?M3R0dlZCMldsUTZpSWN4cHcwWWJzeW5ST0EwR3ZDWHNKdVBHRlZsRWlyWmNO?=
 =?utf-8?B?Ni9nV3BwNmcvVjJzeXcwUU93Q2ZnZkM1dnJpcmF1S3BRTU5xczFkeGhRZEpP?=
 =?utf-8?B?NmNJeUJaazRFTElHWGR3elo3dkRwRzM0UjVtZ292QmJzOHhxNGtBMHUzaXNE?=
 =?utf-8?B?YXlCYll5ZGs2WTM4aHN0TWJZcnVrR2ZiMFRtYklwdG9rSGlPODhTazhHc2hB?=
 =?utf-8?B?WU1iMlNFTGhTOEFPV29tL1UzUndPNVp0dGc5OVJJaVIxUGJiT0lPdyswVUZI?=
 =?utf-8?B?OFlpZ29JeWtSeTRDbUhJYXJKVXNmVTNCZGR4djAxYWZ0WGZDeXFtTE5sdUhw?=
 =?utf-8?B?SndNUml1NnJiaHFtenFRMnJXM0NWTXlNV2tNV1AyY0pVSVNibnk5K3llR1Bz?=
 =?utf-8?B?M3A1K2QxNnZDYk9mekhWd0VEN3o1NWRheHJpdnA2djBYYjdiNzZZOVR4SzND?=
 =?utf-8?B?Ly9DRE1DcjFzUytydXdOTmRhdFZ3M2R3WTFrWUZuODZhZmx3NmNPVVk2VFdE?=
 =?utf-8?B?ZEFZMVo3bC9SNklOTVBRRVdnOVpuQVFsYlpLdUVjOWdYWjZtdkpuaUpYTXhp?=
 =?utf-8?B?eXZqMnppYnpEOXg3dGNlaTJFUXNEdGYyK3pDUDVSd0VtV2M4VXRVN056TFRR?=
 =?utf-8?B?V01nQThzT0txY2RVb3p6aERnT3hib1AvK3RhTlhKSkIzMjhDNDJNUTIrU1k4?=
 =?utf-8?B?U1ZtOTNFdlNFMEVocDNtT21YR0UwUjVOQkVVeTRkWG15ZXhWOW1QZ0xSa2J1?=
 =?utf-8?B?anNJR3F2S3RaNnI0L1RYTlJLYlBhUDg3bE10dDNsR204U2hIWTgvZWw3K3Rv?=
 =?utf-8?B?YmN1QUhSOWJNTy9KYW9iRVNIR2lucTk0WVoyWkRzSi8zOXhUdUN0VkUwZ20z?=
 =?utf-8?B?eDJKeW1JZG9QTUVmemVYVkhRSDNVdS96b2g3VXhZaU85em9YYkFyVVcrdXRs?=
 =?utf-8?B?MzZGbXpML080NnNUdTNFOHlnK2xoeWRLRjhUNmdhUVorYXdJK1Y2YjdtQVYw?=
 =?utf-8?B?bzQzVnhGYTJudEpudTl6YWVVaC96cUpuVnVUd0lOZnNLbk1hSmpRTEdmNHFG?=
 =?utf-8?B?REpiRDBrd2NVOUo3YlJ1NVg2N2pBVmE3M2loU2ZCV2E5d3lMNXQybHNTQWNE?=
 =?utf-8?B?VzgrTGN0VTE0cVVFRU1XcG1RYUNlbktNcS9IZlFTU1F6ZlNzQlpDdzN4U1N5?=
 =?utf-8?B?bjJtTHF3b2pvamwvdVdKZGIwa1VXQ09NUlhINnNtRktBTUVLcG0rV3RuMmVX?=
 =?utf-8?B?R2drSlB6MUNFckR3ZkJtTEZ3VXlJYlhBdTUvaDkzQUxYeXFwVURVdzNNcUp5?=
 =?utf-8?B?cmtDNUw3N1ljOVBrb3R5ZU1TUysxVVRDbTd6ZDNIaklpLzZFZWtMU25icG9y?=
 =?utf-8?B?YURNUCtLMmlNa3drNlcyUFNZVVFsTUs5dVhMdk9CR1VuaGUyT0lFbHVnMWY2?=
 =?utf-8?Q?UZbXOeHJgyUdP+osTDrs6lNoZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edc3ae5-c936-45df-0d52-08dcf67d7dcc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 11:50:02.2554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20iqOMZO8yp2NpUobal8ACgcrWJZLG088iEMr6zuWYa4Lid4p2hYyLhbcc1fgzSy9KIg4V9OdfyNboOJxzKWpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689

From: Peng Fan <peng.fan@nxp.com>

Back-to-back LPCG writes can be ignored by the LPCG register due to
a HW bug. The writes need to be separated by at least 4 cycles of
the gated clock. See https://www.nxp.com.cn/docs/en/errata/IMX8_1N94W.pdf

The workaround is implemented as follows:
1. For clocks running greater than or equal to 24MHz, a read
followed by the write will provide sufficient delay.
2. For clocks running below 24MHz, add a delay of 4 clock cylces
after the write to the LPCG register.

Fixes: 2f77296d3df9 ("clk: imx: add lpcg clock support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-lpcg-scu.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index dd5abd09f3e206a5073767561b517d5b3320b28c..620afdf8dc03e9564bb074ca879cf778f7fc6419 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -6,10 +6,12 @@
 
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/units.h>
 
 #include "clk-scu.h"
 
@@ -41,6 +43,29 @@ struct clk_lpcg_scu {
 
 #define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
 
+/* e10858 -LPCG clock gating register synchronization errata */
+static void lpcg_e10858_writel(unsigned long rate, void __iomem *reg, u32 val)
+{
+	writel(val, reg);
+
+	if (rate >= 24 * HZ_PER_MHZ || rate == 0) {
+		/*
+		 * The time taken to access the LPCG registers from the AP core
+		 * through the interconnect is longer than the minimum delay
+		 * of 4 clock cycles required by the errata.
+		 * Adding a readl will provide sufficient delay to prevent
+		 * back-to-back writes.
+		 */
+		readl(reg);
+	} else {
+		/*
+		 * For clocks running below 24MHz, wait a minimum of
+		 * 4 clock cycles.
+		 */
+		ndelay(4 * (DIV_ROUND_UP(1000 * HZ_PER_MHZ, rate)));
+	}
+}
+
 static int clk_lpcg_scu_enable(struct clk_hw *hw)
 {
 	struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
@@ -57,7 +82,8 @@ static int clk_lpcg_scu_enable(struct clk_hw *hw)
 		val |= CLK_GATE_SCU_LPCG_HW_SEL;
 
 	reg |= val << clk->bit_idx;
-	writel(reg, clk->reg);
+
+	lpcg_e10858_writel(clk_hw_get_rate(hw), clk->reg, reg);
 
 	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
 
@@ -74,7 +100,7 @@ static void clk_lpcg_scu_disable(struct clk_hw *hw)
 
 	reg = readl_relaxed(clk->reg);
 	reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
-	writel(reg, clk->reg);
+	lpcg_e10858_writel(clk_hw_get_rate(hw), clk->reg, reg);
 
 	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
 }
@@ -145,13 +171,8 @@ static int __maybe_unused imx_clk_lpcg_scu_resume(struct device *dev)
 {
 	struct clk_lpcg_scu *clk = dev_get_drvdata(dev);
 
-	/*
-	 * FIXME: Sometimes writes don't work unless the CPU issues
-	 * them twice
-	 */
-
-	writel(clk->state, clk->reg);
 	writel(clk->state, clk->reg);
+	lpcg_e10858_writel(0, clk->reg, clk->state);
 	dev_dbg(dev, "restore lpcg state 0x%x\n", clk->state);
 
 	return 0;

-- 
2.37.1


