Return-Path: <linux-kernel+bounces-309959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44BC967274
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B6A1C20FC3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA13AC01;
	Sat, 31 Aug 2024 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hvet2eiT"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2107.outbound.protection.outlook.com [40.92.52.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B96033EA;
	Sat, 31 Aug 2024 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725119161; cv=fail; b=BLbrdiaVHMWAaakrrP9c72RyqpZ4OBy6WyXbpV4YPHteiPwssrgD33zRPGSWXm1gFiCwXIPraleWehWUOVIX/7Hz4FNXVldaQy+LB+U/wrFo0d4fgit2ml9Q7GoD37Y627p67jFQl88GVwL0iETBx5KWlaTO5CK8w+FrUOWr8Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725119161; c=relaxed/simple;
	bh=TIHgvpWxr9T3P/xmaTLtswQu7BL3w+sdbDZjas4NgjI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fYjwF7hT9f2qGfBMBb6jQvheOVKDpjV1xWrd+JbhDg05g0f/NbHLd86mcx2QY9uxYirALjwO1gkSGvovoNtcubA8Sbpm1iosqUCmYlp0hHPTRye+v+0lh2F3X5OQppKWqmqfPgLK1a/7gOPckO5BIDh1aEBzd5GpNfezbA25LZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hvet2eiT; arc=fail smtp.client-ip=40.92.52.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQ3vlHrECXVfXVfKsphirKPR8qYk1yYIgMSfjHd1jxeLrynRPHN1Ozf+5uaKei78BITXRvix/RPtp8GmoJmusiR1WouD7iSMjsbKyP6N+eWyFYjDOoLUR4nRW2MwaCE3ZCYoqNOlJDua6msokjoCPeplypZ06cKobhi8UPCsnjXDJn8cOWaH25XgTDWhRazWFsDxrorJx+4y5xbSxXH68Cxj0O73aBu+D0+FdZSVhDRKG7Oyhouh6bD4oHx8svXK4OomGsmdppbwT0itR8dhLShAnZjErNmhMg2eEIpu3qUf91sp5no48I23UtB5FEzg61qoQqZHRMDMFtMbyvvnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEwasrvuFJz9mphQNFnmIjeY5lItGaucHDbaNMNNOSU=;
 b=ZaKLhoAiEDKDSDq86O+DNFAts85w09uoRx3jevGMHPpPfYMCCI87kiQofhALgDZbHAjUP/1RDA0jAw9/hOacoAmcV84L+BgtyumXxxwZpGTDcwIqvXCOLX3IIzw1Q7rHxcbWfKiClCY1DASia4l9ZUG8N9bHEIXoPKd6OmSVwJ/tFD6e7WlXKrtupR4GPsZd510PP06bdFIQUS8WBfMb6SN/3Me88GxiQMquVSMZ8BwbNRrMoXpiYJxGHMPIBw4wS2OEV7nJ3+JR3WeOB/3U0ynTAx3jlSTWanfHCZu0c7PPoO4J+VbN2Vxe5Wpz9wSKhcv0MnAKXotdcpPHYqDWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEwasrvuFJz9mphQNFnmIjeY5lItGaucHDbaNMNNOSU=;
 b=hvet2eiT//ZtZF8yOInBAzwc76ONBsjefRCVeewuodXWedURsuBavVAkto667r+5YKRQ6BQxz9cDwzPes4BaXgFSdpmKR0G6x9i26+F5wWsgEFcw9HwR8wURCinoJaU/GOIFl6oTcKeEGXBG4CTT1uXYEn8drko4j9wgZumrIzxngijPuhER0r028beyrnFHgLqvld05/cGBHf67sdGbL17lDJ9mDjZ1avDyakDu9UjqjF9wFFRE/39xCzDGlTrT1tBh3EajQVzzxgfj0L9Ph1xWCRWYGx4kMTFB19w6ZQ/XaaHglhjoFJA3XLrK/55I4GEgQgnwh2bJjPTn8B5tYg==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by SEZPR01MB4757.apcprd01.prod.exchangelabs.com
 (2603:1096:101:a1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.21; Sat, 31 Aug
 2024 15:45:54 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%6]) with mapi id 15.20.7897.027; Sat, 31 Aug 2024
 15:45:54 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haylen Chu <heylenay@outlook.com>
Subject: [PATCH 0/2] Add clock controller support for Spacemit K1
Date: Sat, 31 Aug 2024 15:45:38 +0000
Message-ID:
 <SEYPR01MB4221B3178F5233EAB5149E41D7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [zBIVGY+TUlvwKHp6pu1aakEbII9vjBjn]
X-ClientProxiedBy: TYCP301CA0086.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::12) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240831154538.24782-1-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|SEZPR01MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 89027a08-28d7-4b83-7a3a-08dcc9d3ffad
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|8060799006|15080799006|461199028|1602099012|3412199025|4302099013|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	XAInTmn5aTwg6iKJtJhyzH9Tn95GeFhxWm2vtr1mm6QpH3QIYUugqkCpdmwMFRPRHFW2YHgRJh/+Etg0bg3bc3t0o/HFxM9Xg4EVl6J3wtpX/mjvydP8BfKT9djvCsWLQeMcFO3j+HjPQLZPK8b8sDGCT5PidppvTzqwssZ56pFBd2itrQw87v2k/6W+DPsyaE/6Pz+fI428dOjG9IG7ehHqicnsZl8vk763+M4xdRGKCMLe4QOXG8AmRK4HaISKSkRhVrmLjelf3CzlStCkcno/4h+ROJGAHqtEaCgEsgDr9O13Ms5yTNyML/9qPQmi3/zD9idUa7zFOQp55PeOy1zDYdeGA6CXOkIOH53eTfmr0e8k/mgLRYAG8SrXqo3SXgB0ojFizAYRcu9KP6lx6GTeJRxibSsmNSvVJRJI42Z0LZWVRZmz1tUtV169aQkRnTC/AAZPqpraFvz6MSupVYVA2zYlfzElyQSLRb03gVSwDKX7ePU0Ltl/OYLCWoYRL33r3g3WbsZ7WYV9iT+6JuHMwR5HrL34+uPSPhjctpsya8oilHOXikTDdZBtyXoLg2FMgrjFqZmAE7+I2g5do+QbZDaG0Cpl1iYBt1yvbJdBPfyIhtC1xpBQV3wWpAr/L8yqomKFQZiaXJeKyZP+bStk1y2UryaK38fiVX5+NhQy0QxXNy78y9skk8wJfJViABbT+UKL3k1HkKDYqQwXLEgzFd8oNweUdJpeY6eAKXumH3asEOA0sNOavOQbFAtiwUyG4H1ZWiDhawirA2+JpL0Rv3Uvl/rcmCuC24Yuyq1tbxxjH0MfGvrezoH9Tj21wfN7mZi58bjLdN5hU5SFtPGK75mMsLXNBMDFzwduMMc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1gEVnyqUn1o9AlfahrPH5dS7/osZs0Jk2kSwT9fn5RvNFWOlM4ulfTKk1nEC?=
 =?us-ascii?Q?kDiDZ57kLMp3U8fowrlazGXwZ0Q0/g/eQGCno0ODbQowBga65JkKJt4y1L8I?=
 =?us-ascii?Q?ifUQgoqKDgeV1kqmf+65qnA6KyvHmfZaon3nY3dSsekbygPQuENVfUFWkL5G?=
 =?us-ascii?Q?4JYxr3QaKON4Yuz3V3/g7FVL2HTGBZl7Udkpz0Ww/LqeULp+hUxmqygHJV8I?=
 =?us-ascii?Q?jEpNyc1fv5FtMfychJqKL921p07Px90Qn3oVk0KcnucttM731x/0tPq9oroD?=
 =?us-ascii?Q?EfVixgJrYj9x6jrb1irQF1VcaPNrA5yz9Dzs66nOmmL7kKZNzWuglHyVkzMJ?=
 =?us-ascii?Q?wkLFdYp/MsxNvzNVz6ARibt+9kQKCf/eonfkIVZkn2nMI+ZNnBN1zfeJiF1s?=
 =?us-ascii?Q?lzp+2hvHVOtYhyfMQ25DPxloa+xNvZPQPzTWaGzTJo15XJ32eIG9EQNDDAbB?=
 =?us-ascii?Q?hnbA6xOzHqurdkFbtnG1sFYJ3IGb1343Yw1YUTg6SSWauVt4WSksJ8lb/NWS?=
 =?us-ascii?Q?jS239MSKPXIMXt1sU7+DIqJRQjFYSEWMqNPFW/X2ra0TmV/MzpCv8I07IHS4?=
 =?us-ascii?Q?nvQjg5HdNDCI6b/xnh6C0dn5i8JKFyoxT8Ws3kQxcWWYkATgBm7Q8Lq+SQ4s?=
 =?us-ascii?Q?I/SAwzULE/V7gqLpNY5Nz0qWoCwEAj8l7LrWfDRHWivEhyoZDAH5EwBsu3Zc?=
 =?us-ascii?Q?+rebOi4GveXFImwUkKQzdJTS2szWsBWiTwU53AFVHFtCz3DHQ868Z6N/IJnj?=
 =?us-ascii?Q?zUqYKtaA9anZxbvRDB2uKrskpJqnagn5dCKUQ3ftbWwG1Tk/szi69RsxuXxp?=
 =?us-ascii?Q?tYzrEzyBI1xhMYpAAmTGm7Ide8TUbGGULKfMxQ7DL3htnIjqb2VyZ9l0uGei?=
 =?us-ascii?Q?slCaqFCEGSuDZKpW8qFB7QCxHwJGDCIQ8pnmQFeyXK/Y/6qjNBR7XZRWC20U?=
 =?us-ascii?Q?gs8HrZqEz6+JoNxT2fOLvoNs3GqCdMiO1sc1B9d6UtIAlU2t9prGf4S1v965?=
 =?us-ascii?Q?1CbfBKXws02N4Dja9U40KLUer/k6KTlkVrnivYk2HlDZc+HTSZjyurMV5ctD?=
 =?us-ascii?Q?QjIX7r/kgPXSBEZLjBR88DT+fc9jf/iZMTTq8nioik6gxHTvnpIQjX2CfBdU?=
 =?us-ascii?Q?Tfp/ZtmgfPyZwMQ9W+g4LOEdfu27ADYMXs/4uy+KyZIJiU4hGT1v6RDuY9P7?=
 =?us-ascii?Q?YRxDDvijUiFnGiAwq/qeXAWJ2wWMxIlgqq2u4i5r7FxMk/4bDuLIkqM+qm4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89027a08-28d7-4b83-7a3a-08dcc9d3ffad
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 15:45:54.7529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4757

The clock tree of Spacemit K1 is managed by several independent
controllers in different SoC parts. In this series, only all clock
hardwares in APBS and MPMU, and some in APBC and APMU, are implemented,
which is enough to bring up CPU cores and UARTs with some changes to
UART driver (see below). More clocks will be implemented later soon.

No device tree changes are included since Spacemit K1 UART needs two
clocks to operate, but for now the driver gets only one. I would like to
defer the changes until this is resolved.

Tested on BananaPi-F3 board, a clock tree dump could be obtained here[1].

[1]: https://gist.github.com/heylenayy/aaeac90e4fc95a7078825642b7240f47

Link: https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb

Haylen Chu (2):
  dt-bindings: clock: spacemit: Add clock controlers of Spacemit K1 SoC
  clk: spacemit: Add clock support for Spacemit K1 SoC

 .../bindings/clock/spacemit,ccu.yaml          | 116 ++++
 drivers/clk/Kconfig                           |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/spacemit/Kconfig                  |  10 +
 drivers/clk/spacemit/Makefile                 |   4 +
 drivers/clk/spacemit/ccu-spacemit.c           | 594 ++++++++++++++++++
 drivers/clk/spacemit/ccu_common.h             |  55 ++
 drivers/clk/spacemit/ccu_ddn.c                | 167 +++++
 drivers/clk/spacemit/ccu_ddn.h                |  84 +++
 drivers/clk/spacemit/ccu_mix.c                | 338 ++++++++++
 drivers/clk/spacemit/ccu_mix.h                | 349 ++++++++++
 drivers/clk/spacemit/ccu_pll.c                | 229 +++++++
 drivers/clk/spacemit/ccu_pll.h                |  82 +++
 include/dt-bindings/clock/spacemit,ccu.h      | 197 ++++++
 14 files changed, 2227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
 create mode 100644 drivers/clk/spacemit/Kconfig
 create mode 100644 drivers/clk/spacemit/Makefile
 create mode 100644 drivers/clk/spacemit/ccu-spacemit.c
 create mode 100644 drivers/clk/spacemit/ccu_common.h
 create mode 100644 drivers/clk/spacemit/ccu_ddn.c
 create mode 100644 drivers/clk/spacemit/ccu_ddn.h
 create mode 100644 drivers/clk/spacemit/ccu_mix.c
 create mode 100644 drivers/clk/spacemit/ccu_mix.h
 create mode 100644 drivers/clk/spacemit/ccu_pll.c
 create mode 100644 drivers/clk/spacemit/ccu_pll.h
 create mode 100644 include/dt-bindings/clock/spacemit,ccu.h


base-commit: 3d5f968a177d468cd13568ef901c5be84d83d32b
prerequisite-patch-id: 47dcf6861f7d434d25855b379e6d7ef4ce369c9c
prerequisite-patch-id: 77787fe82911923aff15ccf565e8fa451538c3a6
prerequisite-patch-id: b0bdb1742d96c5738f05262c3b0059102761390b
prerequisite-patch-id: 3927d39d8d77e35d5bfe53d9950da574ff8f2054
prerequisite-patch-id: a98039136a4796252a6029e474f03906f2541643
prerequisite-patch-id: c95f6dc0547a2a63a76e3cba0cf5c623b212b4e6
prerequisite-patch-id: 66e750e438ee959ddc2a6f0650814a2d8c989139
prerequisite-patch-id: 29a0fd8c36c1a4340f0d0b68a4c34d2b8abfb1ab
prerequisite-patch-id: 0bdfff661c33c380d1cf00a6c68688e05f88c0b3
prerequisite-patch-id: 99f15718e0bfbb7ed1a96dfa19f35841b004dae9
-- 
2.46.0


