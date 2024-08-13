Return-Path: <linux-kernel+bounces-285055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D6D9508B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384091C22172
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B97B1A0B1B;
	Tue, 13 Aug 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XM4VfFk8"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF51A0B0C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562147; cv=fail; b=eSh/xrVZYa4qV12+Hj6n7BqI12Kkx2cZp71b2NgxMelLQBjLhOmC4QjfPBZqRYuvuJMb5iPLFViwj1zMu4BPhR9vbzStxE/HEPRxOuTO9//bNl1KUhrrpDHr1BF0VKsV08OXnjsWi25EEGRVGjs3HP+FZdHoevT4rvPkPKx+amI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562147; c=relaxed/simple;
	bh=wdMOaxvdED4nYxZmlnJu7BdBDpzKEEzpzk8ZMhb0ahU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SzgG+Nsjl1hKlxIevL2+6MgAdFmpU49nxJ0X71A4xknXFMjb0zNlXUPomtAXdBKHpWXkDwkhUIMEBYRgCXnUqhHLcURHZ5b19e8iIlzCti8cgFCe1Mx0lQDEIcp1RW8f+ZopD5aB/3N6XWR6uqF8KRYLHK0wwx3HE6vXsYKtd4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XM4VfFk8; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxsUMbL5agChusyNig9RMxGSm8btWIIybk73PtjpLq+z3uRIPyqW3akrSB07UuUHE7VrMjiOceWyD3Y3L1Y3SPkQeGG8oOS7iEJsRCMIISDO8cMp8shc15BFdeycloJD45WGLzFJfasvb6PmCdAoN+cOv9PhK1MeuBKGYmQJSZfBEJlRx5p+/0hl/dZTOlr4mwDyFLNMRcwqWFxSHmx6fRDRke+GNp/8WYJ2pZTPfOZZxJF/2jSGdUdNEd/EV90J5Efjs5yXyWsHh2jpdTxNOE42AczrVBFyqHjcgxnktQ8fHUF78LrqDCNXcRpxdI9PiMmwcmC9FXplYqzr63EcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cmOmx2TRWp/2Uy3nWsX2Ky5UGNNorgOPghwcI1aG9c=;
 b=vxMARKmhWmk9USpXNG2EpcUFSX/+hfaChyg2cd7koLpM92c4Ia3kxm5A0nCBjOGH8ktUcfPthdSTl26iehVs8pl2QE/ca11XmLrCE6m/uZy+Ckkmr8vcMKmD+0FLSoLlugS6Wz+ZuLLx9SvJXuIFRERsleaVKbHzkrM5DXJxIt14C9QYn4ixUD21UHoZDxWkPIgoEGVh37N+Gb/y6yodC6zoQfEu2HPaon/+LWucwfsQuEgUZ4gcp/c+QiPmvYAZO6T7fjngEXhOrX8Yb/zdMxkiu03bSwufrCYnuVR42+ROVeq7/xU0hq96QNHrjTgjCenkFMAZTZT35aLSceySPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cmOmx2TRWp/2Uy3nWsX2Ky5UGNNorgOPghwcI1aG9c=;
 b=XM4VfFk88cp6IsaHIJQ9kzODEww3st8yf2DOmMUD+8vaLdyVTnTQndrbJB0hLXjjLYwF/bi1Su1oP5U3YKz4gIZVZv6WMqOAMjMxZhyn7vo3ntmAt/BCpInGUeKIjrysP/64t+gqaUw3b2QtGERZglssGVg7pbFWMWEDUwU2j94lyzvXWo0UvfQjI/XVtiQVZ80KFJ3+sX/kRZM+aarIa5v16L07S/8IaiI7M4053mhhR0Z+V5l3NchwUqa7i6U6qwRU7GlXp4mP/OqQvow+1XtxLLCcPc+kLSu3fdokkkDEdI+BGIH42BG7OSL4naryC6Fl5ouBQ7RagGNLyz5tYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 15:15:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 15:15:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 11:15:05 -0400
Subject: [PATCH v2 07/11] i3c: master: svc: manually emit NACK/ACK for
 hotjoin
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-i3c_fix-v2-7-68fe4a050188@nxp.com>
References: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
In-Reply-To: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723562115; l=1762;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wdMOaxvdED4nYxZmlnJu7BdBDpzKEEzpzk8ZMhb0ahU=;
 b=R24unpZV65f6GitW3gBYzE3DRfrhLKsqwD4i6ayIdG6CyoGGtPNBgpuX/FPj4DKC2/d+M7PbF
 OXNZ5iTyDuwA4YKFnhW1n+G8PRwT3DK2BOW6gmpFfd2IzV7TXEPpmhi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bac5ff-445c-4825-7537-08dcbbaacc54
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?N0xzanpLRlRqSFFQTTRNQm16VkJ5Yms4elFWeEVieTFVb3h2am9TVkRQai9m?=
 =?utf-8?B?YldrRHBzTzhGcFE5eTQrcUN5SDQwT1FicDJOZGdsMmhFYXVXeCs3WmtyS0hD?=
 =?utf-8?B?ekh4d1RPS2tjREZkR0NqVXQ2SXFkQ1VLR2oxdlR4b3ZxZDhqbXV6cTVIZ1dO?=
 =?utf-8?B?Vk5hTllnR3N2VTMydG8wcmtBT0F6QTZOMk9ScERMV1JyLzk4ZzlmWUxnbnpu?=
 =?utf-8?B?aThxeHNkL3ZMNkFxT0NJVHdYektuQjZ6NUF5dm84L1NkdUloTnEzNENMZHcx?=
 =?utf-8?B?TzYxZDdNVVZ3MmpGdmsrZzNFdzZyVUhsZS9hbklWWlRtTkp3Z1ROU1NxTE1G?=
 =?utf-8?B?OHFlMTFqSFFUMGVOZjV6ZGZKcjVMaDI4SFJsY2VybkY0dzJIeFlBR1Jaejc5?=
 =?utf-8?B?WENxRVhaNmpld0Z1WnZJSzk0eklXZ2s0N3VXYUJoNzdKZlM3emdoeHVhbWdB?=
 =?utf-8?B?OHh0YlJoUzEwOGFVNlh4b2NHdi9OMFVaTEZCR1IzeWJiUUpzU1JIeE9iaDBD?=
 =?utf-8?B?UStPOUthSHpBZWRBcnVLNXhvYk5ZdWZZcjc3aFB1ZElOWFNiVG9oUEFiMUNF?=
 =?utf-8?B?RWpkYzRVODVqL0F3cHZjdml5ek5sa1AweUE0SlZUOC9UeHlRcUhqTmJiWVZy?=
 =?utf-8?B?aEFJemM0NS80K2RtejkxUGVzeGNIVEFYZ2NudWhOUmp5UVJuelJpQVIzdEw3?=
 =?utf-8?B?cmREdUZOSzhZTFI5bGw3bW1QV0NzQ0lEMzVlb2Y0WnZDcndpK1FHelMyTzlS?=
 =?utf-8?B?ek1OcHZ5dWRKdlBLWXNHQWt4ZjZLZ3JNdlo2dW5TZ1B3cDFWbFBNYm5LNTJx?=
 =?utf-8?B?R3QxaXF5QU5hc1NGWFIwTG5RV3JGQWxVdnFVWXdIN1JabHRpb0tMZU9iZVA4?=
 =?utf-8?B?K0xxZ2htMEtVL0pnMTZRcGZHMzdWbGZPcVJqSHF6ckZDRzhkQVF5b3FXNVFZ?=
 =?utf-8?B?UXIwRzJTYklEb2grZFhVeHgveDlnOTVUckk1WFNHY21NTmNkYllaSEQ0OFdy?=
 =?utf-8?B?K2wyRVUxZStDdXVqN3R4Z2M4Um5hS2VSa3B5SE04Yytpbk1RN1dMMVU5Wnll?=
 =?utf-8?B?OVRoclI5Tm1pbk9VYlk2UE8zeUdsdzdQY2UvMUFnR3BMNkxiN1Y5elVDUG9x?=
 =?utf-8?B?dWNEWFZMbVpHdi9DM0pWRzRPOEpSMTh6cThadUlmbUJHWXhaNENrYk9Ic2lq?=
 =?utf-8?B?WTBGaHVVUWxId3lDSXBvREJCb0w5S08va1ZZTFI0R1JSV2s5d2ZrOHNHYldC?=
 =?utf-8?B?cWtPUnh0b0h3RS9la2pSc3hmOE1LUC9sV2doQXRPckhNUWF2dXdSTm9DdVdn?=
 =?utf-8?B?M3pmeGtyeXhMVTlvVmQ2UTRyU2ZXVnNRMFdSMVQ3UjFrV2xOU3NuSVJ0cXV2?=
 =?utf-8?B?b242ajJZczlmZFFCeXUyT0tKY3ZySElnWUp6Y0Z2WXNmNFRDcTNOeHNybUF1?=
 =?utf-8?B?Q1djZG9JcjFDbmo5RVIxQ3pVbHZCZnVOd3hRUHFmNW0zN2xweXNSeHpoZHBT?=
 =?utf-8?B?ZmJ1R3RsK1BGaS9kS3VUN0ltRS96WjV3MkRveXFVVmxHbmd6bVpGTXlZMEsw?=
 =?utf-8?B?VU5PSFE0U2MzWEpKanl4S1ltTVVibi83U0JtTVAzS1U1ci92SEZ2eXdSOEpv?=
 =?utf-8?B?RXo2UGhKNGtZN0Y2dGU4T0FuRjVjRm9XdzdPMnNBU1N0Q2JQYStFOXdPTUty?=
 =?utf-8?B?YUY2cU1Ec1VlT3JRVWpacDd2VHdFcFRkV3FPTkgvVmdLMHd1WVgzUWRFd0pX?=
 =?utf-8?B?NDRQeTNuaDhrL1g3b0dqS3VwckxiVks3UXI5UnVqZDZkR1VWQ0ZGaTEwVTJR?=
 =?utf-8?B?NkpOVGp3R2w3ZFo3OVNnNmEvdDRYT1VmYlhac3dydUZVNzlETllYYzNjeXNS?=
 =?utf-8?B?bWhxdHlZR3M0QTVHUGJwUFJCSXgrRkRidFVPaTljMGpYb3c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TzZvc2wrWnNxenpFMFVVa0FrRVdRenBUMUZoRXpYc2Zmell2bWFKYmk1dGUx?=
 =?utf-8?B?RjcyeFdBNGZCU3RUTTVMSmUwT0J5b25MUmhRbUpRbUZUYkwxdHlCSzNjcGNq?=
 =?utf-8?B?dHRUVS9hclF0K1NCTjJTZHJsaWlycmltNnFZWWZMVkJnVHdJVkNRbmNQakp1?=
 =?utf-8?B?UHRVUFQrbTZzaTEvMFZOUTRRTXZRSWpTMDVDdmRKS09pRjNoWHdRRWViLzNs?=
 =?utf-8?B?TUlWaEFFNUJLV2FIV1YzclFuKys4UFZxYUFBYjVWZVVOQ3dLSWVpRFRmTTY3?=
 =?utf-8?B?NHMyckRrVW1zUWdJQ3FNdUR1U2lIclZhaDFva0xVa1d1RFBESkdRckhLSnFo?=
 =?utf-8?B?RjQ5UlVaVUdES1p5dVNWNVV0T0thOFVKK3RwYXUvL2ZiU1dxVW12OHdTZnhB?=
 =?utf-8?B?NUlaTnI2TnZvS3QzRlhiQmY0eUNFWHlOZkFKTjFRZzd1anl2ejRqOVQvZENx?=
 =?utf-8?B?a2hPQld1VVVFS2N1eFN5QVNnL1pRY041Qk9OZEFCSERWb2E2UW9Sc2krSXBD?=
 =?utf-8?B?LzlRRmF0T0dualhnei9Ha0V1Uyt2elp4S21hMlhzY2RZR2U3Qi9WRUFNbnl1?=
 =?utf-8?B?dldsNTN2TXA0TWVUa25Damt1eFBLNlJkOC9aOUw4NzJEYjg5aVNibFJhbHlz?=
 =?utf-8?B?QTBEVE1YeVlackt5SFhyQzZxMm5FMjhOL0dKRFVlN3BWN1A5S2dSeTdLSnFT?=
 =?utf-8?B?TVpadmRzK2poT2VMRUZ2dlJ6cnpjSGdLSGc5NEljaGlGUS9rTlJncnNyZnRk?=
 =?utf-8?B?Y1lEb3cvbHRmMmZZanhpVUF6RXNSaENBYlJrUWZlUDVDclJ3RTJ3K1J3bDkr?=
 =?utf-8?B?TU1sOGRncW1DU0plTURCQzduNHc0bFR2RHk3dzBYNm5XaTYyb2l3VHB6Uy80?=
 =?utf-8?B?aVdHUzhnQnQydTg5cWJmTkk0NVUxWnl0UmdwV2IrUm9nM0xmc0hDWHVKNzVL?=
 =?utf-8?B?MU95RmFWcCtvdXk1WGlIdmlXUXBzN2VFd3JjYzNmWVpBdHdjbzlwc2ZKdkhG?=
 =?utf-8?B?ZDA3bTJ4TDd0ZzFSZkFpZldwY081a1pFc0d4UTRubXZ6aDkxOHVBem9HbkRv?=
 =?utf-8?B?SmxXVE9kYThCUi95Qm9GS2h1MjFhVGJmR1NpTmNmd1VTQ0dHcGxMSWZYWW4r?=
 =?utf-8?B?eXRyM1lud0JQWng4eWhud04xalNCcXh3VHhMNEI0d2RMckpoaEszNmNVNHVo?=
 =?utf-8?B?VmIrZUFJSmpuNGJvSVRFUXZrSHJUZHlRTGRUQUJ2YkVYTU1NN0xmekV1YWFy?=
 =?utf-8?B?K3cyRm91dW1LVGZ6cFAwYkF2d2cxd1RYQkZEcFZtMzJYcW42aWE1cm1EYThu?=
 =?utf-8?B?MzJ5WmpyaWEwWUJ0RUlWOW44a2k5Z0xDWkhUN0JwbDJFcHMvdytiQXVwdGJz?=
 =?utf-8?B?NFFhZnN6UmpnaGFJbUlvSHVyZWMzZkdUNlc3cDRtdzg2MEk1TnlQUEdMVms5?=
 =?utf-8?B?YW91Rlk5NmtEcjQ4NEJ4ZUZsalY4Z2hoemRiODlNVmZiN0VUYzBoaW1MYVp3?=
 =?utf-8?B?TWw3bzZveDlaZVdyWmlYWTZmM09VMHQzdktEU2dxKzRDZGRUNWE3Sm5MK0hk?=
 =?utf-8?B?dk5FVWJhSmFHZjdqWUdOelMzYy80STN4Rmg4VHJES3V0eTkyLzQ5a1R6TFRr?=
 =?utf-8?B?RTVvT3dFQ0ErYnZwa1ZEMjFqQlNkNFoxQmJYcTc0Umd3S2ZOeTkxTHF3ZFpC?=
 =?utf-8?B?NlJ1VG9QVnRCaUk2MXRQRXk4bUowWXRCbW9LdG5yRXQ3TDhJdFYzYVNKNEJj?=
 =?utf-8?B?RWZIQmhzN2ZWUW9qWGNIY2ZuZGUyeTArZjZXYVlsZnRHOHNKNUJkcGxBYlZR?=
 =?utf-8?B?YzBpMlJlSTRRSUxPS0FjK3JleVI1eHlUazRiUWpMY081MktDTmExMXljUW1N?=
 =?utf-8?B?RldNSzhzdFlCMytGZU1zZDdjbmZnR2h4M3IydWRma2hjWi9aTHMxMDdGY3Bi?=
 =?utf-8?B?dk9RSnB3TUhWOVM4QTBVRjk1cHFJVDBWN2FlYnNRVW0wa21SUWxGRzFGMGVE?=
 =?utf-8?B?bnVKTkVJZHQvNXpocHQ2ZjFrMUwxN1NIa1o5YWlOWHExbHVTQXVPcUVXODFk?=
 =?utf-8?B?a2M5KzlZcnRRMGo4bllLdSt0RTNwejdhbFYwQ0RPVmM4aC9salNoaFgxcytX?=
 =?utf-8?Q?83FM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bac5ff-445c-4825-7537-08dcbbaacc54
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:15:42.7747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcJqCt58PO4OzxexIk3V1hzsELXfyY9cVq4dEwU6MEXUf1Odsko8DDGF+FlJNJndm26l2N1bS1UjpXxFnZBWcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404

When the address is arbitrated at send address, the hardware can auto-send
NACK if it is an IBI. However, manual emission of NACK/ACK is needed for
hot join or controller request events.

Add help function svc_i3c_master_handle_ibi_won() to check event type and
send out NACK if the event is not an IBI.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 5d19251238ff8..d665639523e3c 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -405,6 +405,24 @@ static void svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
 	       master->regs + SVC_I3C_MCTRL);
 }
 
+static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 mstatus)
+{
+	u32 ibitype;
+
+	ibitype = SVC_I3C_MSTATUS_IBITYPE(mstatus);
+
+	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
+	/* Hardware can't auto emit NACK for hot join and master request */
+	switch (ibitype) {
+	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
+	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
+		svc_i3c_master_nack_ibi(master);
+	}
+
+	return 0;
+}
+
 static void svc_i3c_master_ibi_work(struct work_struct *work)
 {
 	struct svc_i3c_master *master = container_of(work, struct svc_i3c_master, ibi_work);
@@ -1113,7 +1131,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		 * start.
 		 */
 		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-			writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+			svc_i3c_master_handle_ibi_won(master, reg);
 			continue;
 		}
 

-- 
2.34.1


