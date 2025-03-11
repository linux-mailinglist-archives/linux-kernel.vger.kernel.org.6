Return-Path: <linux-kernel+bounces-555858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804F9A5BD81
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37287189925A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6640C1E832A;
	Tue, 11 Mar 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VEdIppC0"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586D225A31;
	Tue, 11 Mar 2025 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688195; cv=fail; b=W9bNJqa8Iykz8pmyuQFtzatcmXnngsNV3eDgvTqREJspv1YRnzO1VcU2UazKkmOcJIzI9PS4TYW3elgbgOnB6UjITjW1+LCb4lIajGE/UlE+3OoTGudEkI/gTCinxv1dL+p+zHcfU6pFht/GKoBtx5Rgi7fSeyBUeouCqcI6W0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688195; c=relaxed/simple;
	bh=9cFJkvLXF5I0ycijnsUNxuzFSZduOOkKE6JOaJOd9zc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Ib0waeNpY9+pNzEwc1FC5HEus8KgW/XB5L0+SJDaNjosA24XNa3Ml6/xB/z1JBguzP5YDjJrONtvZGcuke9VxOo70Fd0AinVG+aWPjDKfRoS68DA4KbGTJWhlcNWF+s5/K1YR4mH42o77ED/Y0fOeIfXgNtSS95V0nLEmOdIMxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VEdIppC0; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jfx/El5zS/0OFbbAoVz5VReB2P64vU5fJEoAnrhp+FaLm/p5XBHNeQAt43ZIeABFECb3bUa1XOvNtrMUPwvr08D680aFwahtr/ZrY/Ic2H32SzmsQEWPm26H8rrw2xyVyxPGbXWpPW0PUHILOQPfPsupepVxiMFdUx2aRGBGHHrd4f5VVApFcZjfwagglGhulA2uhnfDdILzqYF1wKCDgSLTNXCc0Ex73Asj0S1lLSJuArAv9xeux5ZS/09pNalksD1TdDmSEZBbVUfkLe3zOvQrl9ewdJCOv4xyPQW+m4RnWnkuLoniJyKg6/wQxaIlg+8yL4HCR2AUplasl1sTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC7rtFdKcHKFmTLPOrRCKpsZcCyUR+c5NYj6hTEe0Fk=;
 b=AK5arCpxuDDbinaQ/Gx/baUFAtRYp3EEtOOypx79d+TTXlxaoe8afqRkgjuiABueNKACIq2d1LSgd07ENqiozf4h0kP4Qt8gaUcZ1igPE1N8MnKduz+qlLbKIt1p/pCdqbjgUyaKfQlLlOO6Qg0NrKIsu5Y3H+bmmgmqtKKwbmwuuiKxnpqeO5XDTIlSXaQ0yoh3g/XXeNJfVGTa74s7NzwqyCxcMoIjwlsV1s2ViCn8ypWlXAg3/LAZ4pSN3RGtuvsuqUdNlB9/V7yu3sYPxthpMpSZwr+eyCygW00AoHUF+bn+yhgxf6gDpl7muggJHGOpRaUL5y+Cs2SN9TD4Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC7rtFdKcHKFmTLPOrRCKpsZcCyUR+c5NYj6hTEe0Fk=;
 b=VEdIppC0Tg+rOYP6njNTQNfqjEQMyTbXX8nzdHnwg0pdfHuNhbKBAXEASMmabZ7XGHLzZQihBZjdBegTL78wDnmObxuslpkcQyueThQ/55zDmllCUfQA2KOKwopoP2mL1RZ1Sc13P4Vco/dq9yyHPpoOzVysU3dsg9IL1zfRHy6daALZYU+NOHwA4aMzC0B6S4ozM3ZIUDtCZauaeA+xyBnJd0yT5S6S0cSznC0d8MA7wCZlBVxVT091LOZaG3xLxT1/l1aZcL1Ksdd+RieXcKbxSNZ59RaJQ2S85c72EdqSr8XfxHRPd9DUWY2z82uupV7eMcMYHw219Vr4WW8OWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB8449.eurprd04.prod.outlook.com (2603:10a6:20b:407::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 10:16:28 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 10:16:28 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v13 0/5] v13: firmware: imx: driver for NXP secure-enclave
Date: Tue, 11 Mar 2025 21:09:31 +0530
Message-Id: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADNZ0GcC/13SO27DMAwG4KsEnuuCpB6UOvUeRQdZj8ZDk8Auj
 BRB7l46KGLJowh9JCX8t27O05jn7u1w66a8jPN4PskB1cuhi8dw+sr9mKTQEZAGA9yP39d+lmr
 pgwYwBrxK0XZy/zLlMl4fzT4+5Xwc55/z9PvoveBa/e+CUHVZsIeeOJpgWXu06f10vbzG83e39
 liocqRqR+IElYTOB6N869TmLNZbL0pc4EQu5WCiDq3Tm2MwtdPrPEoAkNEF3O1pKodUOyPO2sD
 egwqOqXW2ctQ4Ky5nsmIGR/s9eXMedO348S8lURhYk9Wtc0+HgM37nDiPRisnQzmp1vna2dp5c
 SW5EiCCzmFoHcIGsV1UYgD9UMCCUzF6Lju5RQaJ2sismYHI2ZrEIfN+5jM0BnAn19REk2Wc0YY
 hbvJ+v/8BvMVvLw8DAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741707617; l=23680;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=9cFJkvLXF5I0ycijnsUNxuzFSZduOOkKE6JOaJOd9zc=;
 b=q8OoP2u1facA02r8Pit7iQTP+RoGMCcryjHvj+Y0odmzn9zkTpBUNDvkYR/2hhHU5ikMoYSNf
 BQU4lxsUD00B0vOo19aEz08SukbDhjuKrubszj5aHvoUosWgS6oT86c
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
X-MS-Office365-Filtering-Correlation-Id: d8128178-a48f-4f67-6619-08dd6085c923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTByOEdIQkczQVp1eEs0UVFTOHc1YWM5VkIrMGpzMGJQN215R1JBMFJiWDJ0?=
 =?utf-8?B?UEVtRE5yRnllSGdRK0NhWUw1L3JUbDkxeHltTWFGSHVvaUFsV1ZlYVR2bnlP?=
 =?utf-8?B?V2dkOWdzVml3aDcwa2xBaUJ4eG5JVjR6Q09BSkQ2emx1K1dkejZLVll3UXJk?=
 =?utf-8?B?Wi8yQ1ZQcXhqeXQwWCtIb1ZQMkZMcDJxYlpycjRCUWUzYVRGenVjUExvRnlE?=
 =?utf-8?B?NHRSSmlDalJVbGRWeUx1Nnczb3Uvc1pqU01Vc2ZnQkRSY25DUkdiMHpvVmdH?=
 =?utf-8?B?Wk50TGhXb2FYNjg2N1VKNmswQzZFL0JkYnNHdUhxeldBNlk1WnhQT1M4akVy?=
 =?utf-8?B?R1JyTkFPWGJzcVBid3Q0NDJrUVYzVTZ3VXBOcnRDbmtGejBwQjF2dnNLdkJz?=
 =?utf-8?B?U1Z2aFhqMHEwRVFPOHBwT293RXRPYUNEOW5WRCtXZWNZSnFibGRqTE1rWGho?=
 =?utf-8?B?cVhvU3AvUGRoTVlYbFpNZW5CK3FyS0lCNTJNQm5KSktVcm1XZm5tbWYwRGN4?=
 =?utf-8?B?dTdhL0JNak8xSWJ4Ti9TdVM0K2h1bXhCN0xvenh2Z3dSdjljRjVCNE5UL0dQ?=
 =?utf-8?B?UUo4UEdsNEVhc3RRTlo2Y0w1TmE5SnJrN0ZZMjN0RmFoTzhXS01rdE1ONDFP?=
 =?utf-8?B?QnFpeDAyamZFVXlnS2hGdlh5TFJDVUZ6UFpmMCtVdmE2NGoxbnRHYVhyb2xm?=
 =?utf-8?B?aEFXRGxlMEtha3Z6S3NWUVJFbW16eXZ1MHNwQUhYTXJFVHk0eGdobDV1VUMx?=
 =?utf-8?B?Ti8zMnhiakI4djdMWDRKQzVZVEFWYUltVEFwaEhDdStDOVZOanUrcFpkNmRI?=
 =?utf-8?B?bUoyWkxMSkh3STFQZmFNWUdnM0VQREdEVWdVTTIxclJKb1F2a28vV1l2eTU1?=
 =?utf-8?B?YUZyR1MydUEwSE8wd3dIUXlxNFMwUzFVVk85aGhFM1dYSVZhREVNUVMxem9m?=
 =?utf-8?B?aDVNOENNdW9UQU12Ujh5WmgyajkvelZhUzhCZUQ0dlhjM1FiS0ZrM1cwcEdy?=
 =?utf-8?B?YUcydFpXRHYvS1BqYy91bm41a3QzYmFIQUFHSmtzWU0yQVh6eTI4ZTJPaE81?=
 =?utf-8?B?WEtpaUZ2dDYza21kcThTVHlsM0JLK0tkMUhRaVgvSm9vMVcvNWpQTGdBTGw4?=
 =?utf-8?B?d3RRMjFmbnJuWWp5Y3djOW5VTERFS3REL0w4Ri9mOHl5ejBNdUtvTjZ2QVRB?=
 =?utf-8?B?VVE5UXMwL29FU0puRnB1VkJuSXQ3Yk5ZYzM5QXc5Y0JQSWtnUmlQVG5ZRngx?=
 =?utf-8?B?QVVnUzJteFBtdFZzWW1XUVNLRmZMLzR5VlZFbC9XbmFUSDVJM1NwZi8yQVpp?=
 =?utf-8?B?NCtJV3FWRis4SkhzS3IwZUZFNTk1dERmMkxBTHBQOGFERGQ5Z2hlRmw0WFZH?=
 =?utf-8?B?TWxYUWlndlR1cElLSjNhQ1NZUmN3MHl1SjFjMFp2dWhsNndaMzdFVWV4bmw2?=
 =?utf-8?B?ZDEzODdiRFRWUlRqNVpYQktKZUE3QWtabEhpYTZCVWl6V2JOUS9CMGtXM3dK?=
 =?utf-8?B?R0hiYmU1MGNCTUNiVVZVa2E3UmVtZ1NlZjdGU3F2Y2lOSzRKTzNiV1FzTXpm?=
 =?utf-8?B?U1VKVVZaTzFKSEp1ZUwzMUppUWd6QmFlY2lqSS82cTZWQ1NnaDY5bDJvQWVj?=
 =?utf-8?B?enpPS0w1ei9BMG9YemRDaDFWUUZuazAxci9zQ2I5ZTM2bzF1WlpYL05NL2tO?=
 =?utf-8?B?R2s0V2FKTXB6azh5UnpRTFBaUjVKbWVTd3EyNGp2LzVoREVZOWtqVDFndzZM?=
 =?utf-8?B?RGhHRndFNjNZVXJjN1ZnZTI2SzdTN1pPMFZzc0crcVFXNUNTTGpFV3RKZnpH?=
 =?utf-8?B?czRlUndhbHZ3RnJZTFNIMUVNSzYydmVPeVlobEtiTUl4QUJyZTNUT1VQZmY5?=
 =?utf-8?B?Y2RFNklsdjdIQk13dmxmc0Exa205U05HMXMycjBUTW5WNFFPbGcxWkJRQUZx?=
 =?utf-8?Q?vpamGT73QdCOvZxSyKXHgGiLcLz2cQaY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0ZtdS9QSTYzQkRiSko2U0Z6d2tlcno2SGhCaTdoL2NZWE1tLzkwMTNxN3JY?=
 =?utf-8?B?VENjV3BnMHFXMDNrL0k0RW0zeTRHOTFQUGV1UFNVdy9STU00TzRwbVI2TDlS?=
 =?utf-8?B?U0ZnTlBnUXZDaXdmQ2w0cWJZZW4wZDMwdFdGUUNjUnh2VkFVQ1RYVngxMzJa?=
 =?utf-8?B?b3FCU2wwRDI4dFNJbTQyKzdGdVJuMmdSRno3WXE3dEZSeEJWZU96NFh1V0R2?=
 =?utf-8?B?eTVqYVJ2eTZBU0dzT2RpZi9VOWxIczNXQ3RTUm9vK0hkeUppOFhqUGR6SG4v?=
 =?utf-8?B?OHYzNkJVYjlRWm9SZ1hNcGNDejJJNi85MmloSmRROXlkWFAyQkZFL21FSTd4?=
 =?utf-8?B?WXZoQUttU2lINU0yKytQNUpkRjJ2VGFuY1h0MEllRCthdFlSczNBWk42TCtJ?=
 =?utf-8?B?QmQvNGUwU1QwTGVyZ3FWV29KczlIS2lPZUd1RmFnZktUdmtEQURNMVZzank5?=
 =?utf-8?B?S2NoblA2WUVZRHBrU2NTT0FWN0xXOGJ4UXJtUWh5RlVGWWZYc1pUZkV5eFkz?=
 =?utf-8?B?OUJrK1RMVE96S0hFc1FrMDhLWHlsYzRPcHdBd3l4YkZGUCtub2c1dGxOdDlo?=
 =?utf-8?B?RzdUdGZGaTBrMWk2UW5oYmlqNG92OHFUT0ozY081WnFXTk9JL2lpTjVPdFNF?=
 =?utf-8?B?c0VRSTZTcmlFU0hUTktwcXo2UTdYYlA5NmZXcWhsSGJ1a0F3UzhGZFY0dlZO?=
 =?utf-8?B?eStYbm5hUHJKRzV1NngvWi9xelFyVURnMzN2WFVZTWdyTzdnK0V4Wm1xUzVF?=
 =?utf-8?B?ME9BTjB4VnViNC91TWVHbU5GTkRwaHdyVDJ3cXYxTEYyb1lKSkdBOTluUjdR?=
 =?utf-8?B?UU5Tek1jd0h3N0t5K0FqSHlyT0lUaTcrQ1FVWlYzb1dmYjdDTWhUYWw5VFor?=
 =?utf-8?B?ck9aN1R1NDFralAzTld0UlA2WmRPaGl5aGE4K3ZlRGczQ1RraUZ6c1RmV2Fw?=
 =?utf-8?B?SVJwdHFXRnVJRmRqTVdXaFluMHE1UzBBU3g3VWQzT2x5UlhwQ2pxTnlRQnEy?=
 =?utf-8?B?YzU3Y244TFVPMGJTWEZOZVdZTG9yTkRxY2NYVm4rdzRlclBjQkN1MXhhalVG?=
 =?utf-8?B?aWlJeTJ2L2l4MHltMi8wdmZFSG8yTDVYeVByNXAybUw2U3lVY0t5M084RGVM?=
 =?utf-8?B?bjVpV2VybUNJcDVhVFFhOE1OaXBkRlcvbUFtc0E2eWU2Mnh3aG51OXo2RHZI?=
 =?utf-8?B?akh4ajdsamF5U0ZqdUI2T1d5ZERpUTdFamR6UDJYbXhscXU5bmNtVUNyZ3lB?=
 =?utf-8?B?OTJTcUZQYkt5VWJWVlJ0dkFXZ3piZEtFb1VSdGhPK08rNldDeTN0aGI1Tk9Y?=
 =?utf-8?B?bHJLSkdTb0FjSnVsTUFnbUdSMzRQT3E3V2JTZm5EMjVhOGsyWllHUFFCbUVR?=
 =?utf-8?B?UWUveTNxbVliVytVMHcya0lvbjI4ZDRaOFlLc2NJNmQvekY4VGU2bGN0MERJ?=
 =?utf-8?B?ekgwNEp1ZTBnT0IwSDJodTl6d3RZU3NQcFA5akZDd1MveGFCL2NsbU5xVVhB?=
 =?utf-8?B?bHlJSHhWbXhWakFGcDVhdzhubEFBQ2hkU1J1RnRyaDM3bVJCYlJEOThkVmw1?=
 =?utf-8?B?OE5rRHZDdUI0MHRFVE1ydGdoM21aQUZ4SGVFNVJ0cHpvbVE3YnlKU2lSK0Nq?=
 =?utf-8?B?dmJNMEVyNUtiU2RHQVNwbHBSS1FDOGNvZ1BZeDk4aWNXMGxETnNWT3g5NjJP?=
 =?utf-8?B?ZFpZN2RXS2RHZTlaOHdaRTZTd0FrMVUxQ3F5QmZidjQ2SlpnREEwam5VTkQ4?=
 =?utf-8?B?MkhOZFNwcTltOW0yQ2NoZ080alk4dlNxaWI0ZElrZkdqbElXODZkWUs4Sytn?=
 =?utf-8?B?TGxBbUhKeGJBTkdGQ0t0R2hWQmFHSndMK05ZeEEwekorNFZ6VmhDc0kzbE9w?=
 =?utf-8?B?cTQ0bi9FbEtNQUNUMlRQRXlyUVhWOWxuOFk2Tlh1K2pBM0oyYnJxcEYwc0gy?=
 =?utf-8?B?VkxXL0lLWXFudmZzQUFGSGxNWnlHbWlScW9WNGFZbC82MGtxSXQvajA4ZDRj?=
 =?utf-8?B?a2thaG1oNlJEUU85dTlXbzZlTHNTeHUzelhERkh6cklYa2F1V3MvRG9RazUr?=
 =?utf-8?B?NXFtMFQrL3BJN01LNWt3MnhKUko2R2tGT0FTdU5RaGljdW1Bck5mdE85MnBU?=
 =?utf-8?Q?MPt76toxdqOJbmD+rCqQyCYP6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8128178-a48f-4f67-6619-08dd6085c923
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 10:16:28.1315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnhYvHopTVKhhS0eOlpGBYpMhVoo7oj+WFWgSO8da7jLztyRakvB85/j92g6Yjc5n6HWKqML1wU9kMeUeYjCzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8449

5/5
- Updated the commit message for imperative mood.
- Remove the usage of macros- NODE_NAME, GET_ASCII_TO_U8, GET_IDX_FROM_DEV_NODE_NAME.
- Clean-up the return path by replacing "ret = -<err>; return ret;" with "return -<err>;"
- Clean-up the return path by replacing "ret = -<err>; goto exit;" with "return -<err>;"
- Removed goto statements from the entire driver, where there is no common code at function's exit.
- Fixes the check-patch erros reported with flag "--strict"
- Replaced devm_add_action, with devm_add_action_or_reset
- Removed the un-necesary and obvious code comments.
- Removed dev_probe_err at the exit of function se_if_probe().

4/5
- Clean-up the return path by replacing "ret = -<err>; return ret;" with "return -<err>;"
- Clean-up the return path by replacing "ret = -<err>; goto exit;" with "return -<err>;"
- Removed goto statements from the entire driver, where there is no common code at function's exit.
- fixes the check-patch erros reported with flag "--strict"
- removed the un-necesary and obvious code comments.
- variable received msg timeout to be different at boot-up & suspend/resume and send/recv ioctlis.

3/5
- compatible string is modified from "fsl,imx8ulp-se" to "fsl,imx8ulp-se-ele-hsm".
- updated the alias name.

2/5
- compatible string is modified from "fsl,imx8ulp-se" to "fsl,imx8ulp-se-ele-hsm".
- compatible string is modified from "fsl,imx93-se" to "fsl,imx93-se-ele-hsm".
- compatible string is modified from "fsl,imx95-se" to "fsl,imx95-se-ele-hsm".
- Mis-understood the +1 from Conor. Hence dropped the Reviewed-by tag.
- Collected Rob's R-b tag on v7 (https://lore.kernel.org/all/172589152997.4184616.5889493628960272898.robh@kernel.org/)

1/5
- No change

Reference:
- Link to v12: https://lore.kernel.org/r/20250120-imx-se-if-v12-0-c5ec9754570c@nxp.com

Changes in v12:

5/5
- increased the wait-timeout.

4/5
- rename flag "handle_susp_resm" to "imem_mgmt"
- moved the buffer allocation ot load_fw->imem.buf, to se_probe_if.
- setting imem state at initialization.

3/5
- No change

2/5
- No change

1/5
- No change

Reference:
- Link to v11: https://lore.kernel.org/r/20241220-imx-se-if-v11-0-0c7e65d7ae7b@nxp.com

Changes in v11:

5/5
- devname is constructed by concatinating get_se_if_name(se_if_id) & se_if_instance_id.
- ele_rcv_msg(), is updated to add the wait_interruptible_timeout for the non-NVM-Daemon message exchanges, such that in case of no response from FW,
  Linux donot hangs.
- added a new helper function get_se_if_name(), to return the secure-enclave interface owner's name string.
- added a new helper function get_se_soc_id(), to return the secure-enclave's SoC id.

4/5
- moved the se_if_node_info member "soc_register", to the struct "se_if_node_info_list"; as soc registration done once, not per interface.
- moved the se_if_node_info member "se_fetch_soc_info", to the struct "se_if_node_info_list"; as soc info fetching is done once, not per interface.
- Added two member variable se_if_id and se_if_instance_id to struct se_if_defines.
- removed the member "se_name" from struct "se_if_node_info". Rather, it will constructed by concatinating get_se_if_name(se_if_id) & se_if_instance_id.
- moved the static global variable "se_version", to the newly created structure "struct se_var_info".
- moved the member "struct se_fw_load_info load_fw" of "se_if_node_info_list", to the newly created structure "struct se_var_info".
- Replaced RUNTIME_PM_OPS with SET_SYSTEM_SLEEP_PM_OPS, in power-managment ops.

3/5
- No change

2/5
- No change

1/5
- No change

Reference:
- Link to v10: https://lore.kernel.org/r/20241104-imx-se-if-v10-0-bf06083cc97f@nxp.com

v10: firmware: imx: driver for NXP secure-enclave

Changes in v10:
5/5
- replaced the u8, u16, u32, u64, with __u8, __u16, __u32, __u64 in
  'include/uapi/linux/se_ioctl.h'.

4/5
- No change

3/5
- No change

2/5
- No change

1/5
- No change

Reference:
- Link to v9: https://lore.kernel.org/r/20241016-imx-se-if-v9-0-fd8fa0c04eab@nxp.com

Changes in v9:

4/5
- change se_if_remove function signature, required after rebase to v6.12-rc1.
- move the info->macros to a structure "struct se_if_defines if_defs".
- Removed "info" from "struct se_if_defines if_defs".
- Moved "mem_pool" from "struct se_if_defines if_defs" to "priv".
- Fetching "info" using container-of.

5/5
- Fetching "info" using container-of.
- Fixed issue reported by sparse.

Reference:
- Link to v8: https://lore.kernel.org/r/20241015-imx-se-if-v8-0-915438e267d3@nxp.com

Changes in v8:

5/5
- Remove the check for SE_IF_CTX_OPENED.
- replaced dev_ctx->priv-dev, priv->dev, whereever possible.
- func "if_misc_deregister" moved before func "init_device_context".
- func "init_device_context" before func "se_ioctl_cmd_snd_rcv_rsp_handler".
- func "se_if_fops_write" and "se_if_fops_read", are moved after func "se_ioctl_get_mu_info".
- non static functions "se_dev_ctx_cpy_out_data, se_dev_ctx_shared_mem_cleanup & init_device_context" are moved static and local scope.
- Removed back & forth between the two structs "struct se_if_device_ctx *dev_ctx" and "struct se_shared_mem_mgmt_info *se_shared_mem_mgmt"
- removed the NULL check for bdesc.
- fops_open, is corrected for acquiring the fops_lock.
- Fops_close, mutex unlock is removed. Infact check for waiting_rsp_clbk_hdl.dev_ctx, is removed.
- sema_init(&dev_ctx->fops_lock, 1);, replaced with Mutex.
- structure member se_notify, is removed.

4/5
- removed initializing err to zero in func ele_fetch_soc_info(),
- replaced 'return 0', with 'goto exit', if the condition (!priv->mem_pool) is true.
- replaced "struct *dev" with "struct se_if_priv *priv", in base_message API(s) and others.
- Created a separate structure "struct se_if_defines" to maintain interface's fixed values like cmd_tag, rsp_tag, success_tag etc.
- removed the macros "WORD_SZ", "SOC_VER_MASK", "DEFAULT_IMX_SOC_VER", "RESERVED_DMA_POOL".
- Added handling for "ctrl+c", by postponing the interrupt, till the response to the "command in flight" is received.
- Removed the mutext lock "se_if_lock".
- furnction prototype for "se_save_imem_state" and "se_restore_imem_state", is changed to pass "imem" by reference.
- Added a new structure "struct se_fw_load_info", dedicated to contain FW loading relevant info. It is a member of struct info_list.
- split "imem_mgmt_file_in_rfs" into two "prim_fw_nm_in_rfs" and "seco_fw_nm_in_rfs", to be part of "struct se_fw_load_info".
- moved the function "se_load_firmware" prior to func "if_mbox_free_channel".
- function "se_load_firmware" is updated to use "request_firmware", instead of "request_firmware_no_wait".
- function "se_load_firmware" is updated to load "primary" fw image, if the imem_state is not BAD. Then load the "secondary FW" image.
- Added a new mutex_lock in the function "se_load_firmware", for ensuring FW loading done once, when there are multiple application are in play.
- instead of "wait_queue_head_t wq", used "sruct completion".
- add devm_add_action with action as se_if_probe_cleanup.

Reference:
- Link to v7: https://lore.kernel.org/r/20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com

Changes in v7:

5/5
- struct se_clbk_handle, is added with a member struct se_if_device_ctx *dev_ctx.
- func call to ele_miscdev_msg_rcv() & ele_miscdev_msg_send(), are removed.
- func se_ioctl_cmd_snd_rcv_rsp_handler(), is modified to remove the func call to ele_miscdev_msg_rcv() & ele_miscdev_msg_send()
- func se_ioctl_cmd_snd_rcv_rsp_handler is callig func ele_msg_send_rcv(), instead.
- Mutext "se_cmd_if_lock", handling is removed from this patch.
- func ele_miscdev_msg_send() is replaced with func ele_msg_send(), in fops_write.
- func ele_miscdev_msg_rcv() is replaced with func ele_msg_rcv(), in fops_read.
- fops_open is modified to create the new dev_ctx instance (using func init_device_context()), which is not registered as miscdev.
- Only one dev_ctx is registered as miscdev and its reference is stored in the struct se_if_priv, as priv_dev_ctx.
- Separate func cleanup_se_shared_mem() & func init_se_shared_mem(), for shared memory handling part of struct dev_ctx.
- Input param for func(s) ele_msg_rcv(), ele_msg_send() & ele_msg_send_rcv(), is replaced from struct se_if_priv to struct se_if_device_ctx.

4/5
- A new structure is defined name struct "se_clbk_handle", to contain members processed in mailbox call-back function.
- "struct se_if_priv" is modified to contain the two structures of "se_clbk_handle" - waiting_rsp_clbk_hdl & cmd_receiver_clbk_hdl.
- func ele_msg_rcv() is modified to take a new additional input reference param "struct se_clbk_handle *se_clbk_hdl".
- func ele_msg_send() is modified to take a new additional input tx_msg_sz.
- func ele_msg_send_rcv(), is modified to take 2 more inputs - tx_msg_sz & exp_rx_msg_sz.
- func se_val_rsp_hdr_n_status(), is modified to take input of rx_msg buffer, instead of header value, as input param.
- each caller of the func ele_msg_send_rcv(), is sending these two additional input params.
- func se_if_callback(), is modified to work on two structures of "se_clbk_handle" - waiting_rsp_clbk_hdl & cmd_receiver_clbk_hdl.
- Variable "max_dev_ctx", is removed from info & priv struture, as well its usage.
- New member variable "se_img_file_to_load", is added to structure "priv".
- Other member variables - rx_msg(ptr), rx_msg_sz, completion done & list of dev_ctxs, is removed from priv struture, along with their usage.
- func se_resume(), updated to wakeup the two "wq", part of "struct se_clbk_handle": priv->waiting_rsp_clbk_hdl & priv->cmd_receiver_clbk_hdl.

3/5
- Node name is changed from senclave-firmware@0 to "secure-enclave"

2/5
- Node name is changed to "secure-enclave".

Reference:
- Link to v6: https://lore.kernel.org/r/20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com

Changes in v6:

5/5
- replaced scope_gaurd with gaurd.

4/5
- replaced scope_gaurd with gaurd.
- remove reading the regs property from dtb.
- Added NULL check for priv data fetched from device, as a sanity check, for ele_base_msg apis)

3/5
- replace firmware with senclave-firmware.

2/5
- replace firmware with senclave-firmware.
- drop description for mbox
- Replaced "items:" with maxItems:1 for "memory-region"
- Replaced "items:" with maxItems:1 for "sram"
- remove regs property.
- remove "$nodename"

Reference:
- Link to v5: https://lore.kernel.org/r/20240712-imx-se-if-v5-0-66a79903a872@nxp.com

Changes in v5:

2/5
- updated the description of mboxes
- updated the description & items for mbox-names.
- updated the description of memory-region
- move "additional properties: false" after allOf block.
- removed other example except one.

4/5
- Corrected the indentation in Kconfig.
- info members:mbox_tx_name & mbox_rx_name, are replaced with macros.

5/5
- Replaced "for  secure enclaves", with "for secure enclaves"
- Replaced "user space" with "userspace".
- End the line "[include]<linux/firmware/imx/ele_mu_ioctl.h>" with a period.

Reference:
- Link to v4: https://lore.kernel.org/r/20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com

Changes in v4:

1/5
a. Removed - from EdgeLock Enclave.

b. Removed , after "Each of the above feature,"

c. replace "can exists" with "can exist".

d.
-messaging units(MU) per SE. Each co-existing 'se' can have one or multiple exclusive
-MU(s), dedicated to itself. None of the MU is shared between two SEs.
+messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
+MUs, dedicated to itself. None of the MU is shared between two SEs.
 Communication of the MU is realized using the Linux mailbox driver.

e.
-All those SE interfaces 'se-if' that is/are dedicated to a particular SE, will be
-enumerated and provisioned under the very single 'SE' node.
+Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
+multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
+that is/are dedicated to a particular SE will be enumerated and provisioned using the
+single compatible node("fsl,imx95-se").

f. Removed ",". Replaced for "Each 'se-if'," with "Each se-if'.

g. removed ","
-  This layer is responsible for ensuring the communication protocol, that is defined
+  This layer is responsible for ensuring the communication protocol that is defined

h. removed "-"
-  - FW can handle one command-message at a time.
+  - FW can handle one command message at a time.

i.
-  Using these multiple device contexts, that are getting multiplexed over a single MU,
-  user-space application(s) can call fops like write/read to send the command-message,
-  and read back the command-response-message to/from Firmware.
-  fops like read & write uses the above defined service layer API(s) to communicate with
+  Using these multiple device contexts that are getting multiplexed over a single MU,
+  userspace application(s) can call fops like write/read to send the command message,
+  and read back the command response message to/from Firmware.
+  fops like read & write use the above defined service layer API(s) to communicate with
   Firmware.

j. Uppercase for word "Linux".

2/5
a. Rephrased the description to remove list of phandles.

b. Moved required before allOf:
+required:
+  - compatible
+  - reg
+  - mboxes
+  - mbox-names
+
+additionalProperties: false
+
 allOf:

c. replaced not: required: with properties: <property-name>: false.
   # memory-region
-      not:
-        required:
-          - memory-region
+      properties:
+        memory-region: false

   # sram
-    else:
-      not:
-        required:
-          - sram

d. Reduced examples. keeping example of i.MX95.
e. node-name is changed to "firmware@<hex>"

3/5
- node name changed to "firmware@<hex>".

4/5
- used sizeof(*s_info)
- return early, rather than doing goto exit, in ele_get_info().
- Use upper_32_bits() and lower_32_bits()
- use rx_msg here instead of priv->rx_msg
- Moved the status check to validate_rsp_hdr. Rename the function to "se_val_rsp_hdr_n_status"
- typecasting removed header = (struct se_msg_hdr *) msg;
- Converted the API name with prefix imx_ele_* or imx_se_*, to ele_* and se_*, respectively.
- Removed the functions definition & declaration for: free_phybuf_mem_pool() & get_phybuf_mem_pool()
- removed the mbox_free_channel() calls from clean-up.
- Flag "priv->flags" is removed.
- Converted the int se_if_probe_cleanup() to void se_if_probe_cleanup().
- Replaced NULL initialization of structure members: priv->cmd_receiver_dev & priv->waiting_rsp_dev , with comments.
- Removed the function's declaration get_phy_buf_mem_pool1

5/5
Changes to Documentation/ABI/testing/se-cdev.
a. Removed "-" from "secure-enclave" and "file-descriptor".

b. Removed "-" from "shared-library"

c. Replaced "get" with "getting".

d. Added description for the new IOCTL "send command and receive command response"

e. Replaced "wakeup_intruptible" with "wait_event_interruptible"

f. Removed ";"

g. Removd "," from "mailbox_lock,"

h. Replaced "free" with "frees"

i. In mailbox callback function, checking the buffer size before
copying.

Reference:
- Link to v3: https://lore.kernel.org/r/20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com

Changes in v3:
5/5:
- Initialize tx_msg with NULL.
- memdup_user() returns an error pointer, not NULL. correct it by adding check for err_ptr.
- new IOCTL is added to send & recieve the message.
- replaced the while loop till list is empty, with list_for_each_entry.
- replaced __list_del_entry, with list_del.
- Removed the dev_err message from copy to user.
- Removed the casting of void *.
- corrected the typcasting in copy to user.
- removed un-necessary goto statement.
- Removed dead code for clean-up of memory.
- Removed un-mapping of secured memory
- Passing se_if_priv structure to init_device_context.
- Updated the below check to replace io.length with round_up(io.length).
	if (shared_mem->size < shared_mem->pos|| io.length >= shared_mem->size - shared_mem->pos)
- Created a function to cleanup the list of shared memory buffers.
- Used list_for_each_entry_safe(). created a separate functions: se_dev_ctx_cpy_out_data() & se_dev_ctx_shared_mem_cleanup()

4/5
- Changed the compatible string to replace "-ele", to "-se".
- Declaration of imx_se_node_info, is done as const in the whole file
- Remove the unused macros from ele_base_msg.h
- Remove the function declaration get_phy_buf_mem_pool1, from the header file.
- Replace the use of dmam_alloc_coherent to dma_alloc_coherent
- Check for function pointer, before calling the fucntion pointer in imx_fetch_se_soc_info
- Removed the unused flag for SE_MU_IO_FLAGS_USE_SEC_MEM.
-  Removed the unused macros WORD_SZ
- instead of struct device *dev, struct se_if_priv *priv, is used as argument to the funtions:se_save_imem_state, se_restore_imem_state, imx_fetch_se_soc_info
- Removed ret from validate_rsp_hdr.
- changed the prefix of the funtion: plat_add_msg_crc and plat_fill_cmd_msg_hdr.
- indentation correction for info structures.
- remove the check for priv not null from se_if_probe_cleanup
- Removed the casting of void *.
- se_load_firmware function is corrected for not freeing the buffer when allocation fails.
- Checking if get_imx_se_node_info() can return NULL, in se_if_probe()
- imem.size has type u32. return value from se_save_imem_state() will be assigned to imem.size in case of success only.
- removed the flag un-setting in case of failure. priv->flags &= (~RESERVED_DMA_POOL);
- removed the function call for devm_of_platform_populate(dev);
- Checking for not-NULL,  before calling the funtion pointer se_fetch_soc_info.
- Removed the checking for reserved memory flag, before freeing up the reserved memory, in se_probe_if_cleanup.

3/5
- Changed the compatible string to replace "-ele", to "-se".

2/5
- to fix the warning error, replaced the "-ele" & "-v2x" in compatible string, to "-se".
- Added an example for ele@0 for compatible string "fsl,imx95-se"

Reference
- Link to v2: https://lore.kernel.org/r/20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com

Changes in v2:

4/4
- Split this patch into two: 1. base driver & 2. Miscdev
- Initialize the return variable "err" as 0, before calling 'return err', in the file ele_common.c
- Fix the usage of un-iniitialized pointer variable, by initializing them with NULL, in ele_base_msg.c.
- Fix initializing the ret variable, to return the correct error code in case of issue.
- replaced dmam_alloc_coherent with dma_alloc_coherent.
- Replace the use of ELE_GET_INFO_READ_SZ, with sizeof(soc_info).
- Replaced -1 with -EPERM
- Removed the safety check on func-input param, in ele_get_info().
- fix the assigning data[1] with lower 32 address, rather than zero, for ele_fw_authenticate API.
- Correctly initializing the function's return error code, for file  ele_base_msg.c.
- replaced 'return' with 'goto'.
- Use length in bytes.
- Corrected the structure se_msg_hdr.
- Moved setting of rx_msg  to priv, into the function imx_ele_msg_send_rcv
- Will add lockdep_assert_held, to receive path, in v2.
- corrected the spacing at "ret  = validate_rsp_hdr"
- FIELD_GET() used for RES_STATUS
- Re-write the structure soc_info, matching the information provided in response to this api.
- The "|" goes to the end of the previous line.
- Moved the locking and unlocking of the command lock to the caller of the function.
- removed the safety check for device private data.
- Structure memory reference, used to read message header.
- In the interrupt call back function, remove assigning waiting_rsp_dev to NULL, in case of response message rcv from FW.
- do while removed.
- replaced BIT(1) for RESERVED_DMA_POOL, to BIT(0)
- The backslash is removed while assigning the file name with absolute path to structure variable.fw_name_in_rfs =.
- Update the 'if' condition by removing "idx < 0".
- mbox_request_channel_byname() uses a "char" for the name not a u8. Corrected.
- devm managed resources, are not cleaned now, in function se_probe_if_cleanup
- Used dev_err_probe().
- Used %pe to print error string.
- remove "__maybe_unused" for "struct platform_device *enum_plat_dev __maybe_unused;"
- used FIELD_GET(), for  RES_STATUS. Removed the use of MSG_TAG, MSG_COMMAND, MSG_SIZE, MSG_VER.
- Depricated the used of member of struct se_if_priv, bool no_dev_ctx_used;
- Moved the text explaing the synchronization logic via mutexes, from patch 1/4 to se_ctrl.h.
- removed the type casting of info_list = (struct imx_se_node_info_list *) device_get_match_data(dev->parent);
- Used static variable priv->soc_rev in the se_ctrl.c, replaced the following condition: if (info_list->soc_rev) to if (priv->soc_rev) for checking if this flow is already executed or not.
- imx_fetch_soc_info will return failure if the get_info function fails.
- Removed devm_free from imx_fetch_soc_info too.

3/3
- Made changes to move all the properties to parent node, without any child node.

2/4
- Use Hex pattern string.
- Move the properties to parent node, with no child node.
- Add i.MX95-ele to compatible nodes to fix the warning "/example-2/v2x: failed to match any schema with compatible: ['fsl,imx95-v2x']"

1/1
- Corrected the spelling from creats to creates.
- drop the braces around the plural 's' for interfaces
- written se in upper case SE.
- Replace "multiple message(s)" with messages.
- Removed too much details about locks.

Testing
- make CHECK_DTBS=y freescale/imx8ulp-evk.dtb;
- make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx-se.yaml
- make C=1 CHECK=scripts/coccicheck drivers/firmware/imx/*.* W=1 > r.txt
- ./scripts/checkpatch.pl --git <>..HEAD
- Tested the Image and .dtb, on the i.MX8ULP.

Reference
- Link to v1: https://lore.kernel.org/r/20240510-imx-se-if-v1-0-27c5a674916d@nxp.com

---
Pankaj Gupta (5):
      Documentation/firmware: add imx/se to other_interfaces
      dt-bindings: arm: fsl: add imx-se-fw binding doc
      arm64: dts: imx8ulp-evk: add nxp secure enclave firmware
      firmware: imx: add driver for NXP EdgeLock Enclave
      firmware: drivers: imx: adds miscdev

 Documentation/ABI/testing/se-cdev                  |   43 +
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   |   91 ++
 .../driver-api/firmware/other_interfaces.rst       |  121 ++
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts      |   17 +-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |   13 +-
 drivers/firmware/imx/Kconfig                       |   13 +
 drivers/firmware/imx/Makefile                      |    2 +
 drivers/firmware/imx/ele_base_msg.c                |  373 ++++++
 drivers/firmware/imx/ele_base_msg.h                |   98 ++
 drivers/firmware/imx/ele_common.c                  |  366 ++++++
 drivers/firmware/imx/ele_common.h                  |   54 +
 drivers/firmware/imx/se_ctrl.c                     | 1272 ++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h                     |  126 ++
 include/linux/firmware/imx/se_api.h                |   14 +
 include/uapi/linux/se_ioctl.h                      |  101 ++
 15 files changed, 2701 insertions(+), 3 deletions(-)
---
base-commit: 8250927cfd6e6538b6c569926865d833ae6b5bc0
change-id: 20240507-imx-se-if-a40055093dc6

Best regards,
-- 
Pankaj Gupta <pankaj.gupta@nxp.com>


