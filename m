Return-Path: <linux-kernel+bounces-175234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951468C1CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AA71C2136A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6561148FE3;
	Fri, 10 May 2024 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iXzfx4zq"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2059.outbound.protection.outlook.com [40.107.249.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C698E33CD1;
	Fri, 10 May 2024 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310715; cv=fail; b=HNZGhoQYYtD3HJ1XiYecqZDaSL7CyPA00ixAgQKHQJKJQjHitqj4JzIGB9veOl7JnFg+lLnxeTzAyFb9siQw8l/v8H2Widp/6j+C0Z9wW4nj4HOg4bMdD/eGHUCDtD0RcsK2UWONlgHO+X8NGHBjhD3yIok0hWHsFYDkrgGSKio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310715; c=relaxed/simple;
	bh=YtyTpdvrQ5zl7BSEMed4Pj2k2OlKSFatIr7+BP2lbIo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=QMo5M/RlH3tsJ04hGWXSb8TLnblRGjRTRVKQ5EvKDxDxqn7KSB3r2qJko4wtaFTqj+CZDiexSJ+sj5c4C8HnP5WSNQvE3yv300rbiESj3ZhcSwEOsMOXV6zny+cYLVjfUXbp3CkD6yHjia76XvPjg7BlTNeRX6DM9b9j9wGNxlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iXzfx4zq; arc=fail smtp.client-ip=40.107.249.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/WEDBdcuDm+A7V4WuOlyD0CRS8Pcq9Myqf0bcrvdvjyBezjqruyrx3XXdUpLiQAh6Xvy/b2dWnQTF+C5Wy9piPq7tIgNaHV1rT/ug+Vg27/44rYU6+d1xxPKlsSXYoNlWe5iXAr2naWMAdi2HI6wff49fNTct/uFLoqVFe2pqylWnzA83+Q3bDh6pof8zkZf5pkEh0wjrgC0LXlJJhS5MNlRQSQU5+kf57d2M2js9cUQp8x0MO5x5cc3R4Mp8LmTGcn17Y5ZvzQPU55XrnSkoEhnwF75uhdTPQTufd7vv4vZzRzQb9SUSWXxCKjymcag3pn0NQ1JE49nIOiUGcWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP11g84Vnuc+0uP0MR0IJjhbNvIU2a/0hUAFSbXXWPI=;
 b=HvWPcje3e8rOzA41pRK5we8g8mP/6Y2qANyZqgGzr6CUYpqEtrMdAYnH0Sayg5mHkbmfRe+vqmophbNFFtrTGZwCYZOoR9Xq42M7Q/8ALf//Nx5fewsz6W3lbIaHYG99hKeVsUAY3XFSsAJduruTobIpTRo2yMgaix5h82jiO4nF1MbArz7ae/dXyYVwiWsqUzl3pzs4xEzBAklBISvQA92diEtMFlugTNjpEja0xLfz/to01cOS0nT79q+9YdSgObmZ+VWT3q4AjDIdMb9GcOOUcUNVETGD/LvbKjOCi9Y1IL5Si0t5guIsZAeV3uA/tinrEGPfnAEYRKN+ZpKNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP11g84Vnuc+0uP0MR0IJjhbNvIU2a/0hUAFSbXXWPI=;
 b=iXzfx4zqG8JNdPlmEVJoRNfE330300rKNFU/ujimHjF7aqVjNE9hjxpBnKSNwWuDyyF8eg04A/duOcUP4I0XeTwLf1qpXghqqRpExxMWdl1kiKzY+ceRZkLUCgwNwKaAnhaiWDO/t4ucKeVvTpSt7Bj210HGVeot2S6UBELF7FY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB10135.eurprd04.prod.outlook.com (2603:10a6:150:1c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 03:11:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 03:11:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/2] firmware: arm_scmi: add notification completion
 channel
Date: Fri, 10 May 2024 11:19:46 +0800
Message-Id: <20240510-scmi-notify-v2-0-e994cf14ef86@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFOSPWYC/23MQQ6DIBCF4auYWZcGUQN21Xs0LigMdRaCAUM0h
 ruXuu7yf8n7TkgYCRM8mhMiZkoUfA1xa8DM2n+Qka0NgoueD1yyZBZiPmzkDsYlKqnVe9Sig/p
 YIzraL+011Z4pbSEeF57b3/rfyS3jrHUWnRlVb4fu6ff1bsICUynlC+1QTyKkAAAA
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715311198; l=1618;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=YtyTpdvrQ5zl7BSEMed4Pj2k2OlKSFatIr7+BP2lbIo=;
 b=f7DAUG+W7vauCfSk6iYdQieRMfEGTbAn9vvYCYwnpeXDiWoGehSXf7HlILCorJreQ3HKN6SOb
 x681+V7diudBLH8WMkuioSkHFsb4anfM4sNb/haqB84r7ijuEXhdqhC
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB10135:EE_
X-MS-Office365-Filtering-Correlation-Id: efdc46f5-ee5e-4a45-1ff5-08dc709eef2a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnFrVzNnV3g0Tm00eE9valFTS3ZLSUl2cVRsQ2ZVSHBPcVNseFpObm40MklX?=
 =?utf-8?B?SjBlN0w4cE9pZ1ZQbUpKSHJIc1grNVY1S0pYUWR0T05Ua05wdnVHeGI4VlM5?=
 =?utf-8?B?eFpJT0pNSUswYklBbnIvQVkvOVlBUm9rWWlDMVdnK1VBemdCSGcyc3NqUDN1?=
 =?utf-8?B?ZXlNdVVDTHdrZFFRRVB3cmVDQkFCOHhtZzhJUDQrRlA3VlVZMTh3TnVnaVNr?=
 =?utf-8?B?WmVmMDgwSk5KQUhZTWlpZEZGeWUwUTVPME5ldkRxV2dLUDR4V2h1Rk1aNmRk?=
 =?utf-8?B?ZmNLaWRGdzc4aitzdEZnUnA5dVN3eHBlTDFjWTYxTWthSzV5Y0hmS2tjcjJr?=
 =?utf-8?B?b1kzb0UzaTd0VEZrcWZhdUJPNnd5SWZVYTlUbzRzVjZZZEZWUzFQS1NRSTVF?=
 =?utf-8?B?c3dtS3ZUMVhkeHJEV3k4UzJwNUZ2bXlKSm5KQkFMM0c0NjMxOSsxczQ3cmk0?=
 =?utf-8?B?YkFZT2QvbmRybHN2MW9hVzAvMGdOVzYzVkVwVjZjdmo5VTFQT3VpNFZWNGxk?=
 =?utf-8?B?YUJwOUl3MnFJOUlld1hhdzNhVnZ3dS8rb2Nrd1ovay9jWkE1T21Hd0Q4TDN4?=
 =?utf-8?B?QWtHSC82L0VYelNaVzdtb0FyLzhWZjIvZnl1WDdENVNYVmRwWHdYQVhucDdi?=
 =?utf-8?B?N2RTMzRjRUxsR0ZDVGpnWnJaWGVITUd6VWJOTEt2a1lqenJVUGJHb2pxRzR6?=
 =?utf-8?B?aEhNS3pKM0dwUXNJLzlSVU1WcHFZTzBKem56VnVKNk91SXI4UnpyaEZ1b2or?=
 =?utf-8?B?QUpCK20za0UxNVhEYkk3dUVUZG16Z2ZaTVh6Yzhta1NTU0U2VjNrNXVvK2pp?=
 =?utf-8?B?aVRUZjYzTGJ6dlp2dkZnMFhILzNTZnJqRjVTcE96Y0d0ZG9nSGJRMnc1L1ZK?=
 =?utf-8?B?VmM5VVQ5NllWazlwNWlldXd6T3orWUprRTAxcmlRV2hmZ2ExUkE0UitZMitk?=
 =?utf-8?B?UFJNR2kzdTJuQ096eEprdllTVXE1bnNZcldPTnVkUWhBYmtmVU9HZ2Y5VmNi?=
 =?utf-8?B?RURNNWQzMXQvaERzanFoYjN4R0xYWnE1VHZHbk1lTDhodVZOaldPb1NlZE9o?=
 =?utf-8?B?aDNNeHUzYjlKR2lrNnZ4c1JrT3NBMUNVMTlUdHR2TlhkampwanNwcFVZNGZZ?=
 =?utf-8?B?TklJd2FkdkF6VU55RnhXbUxxOGh6Zi8wWXhIc0NQRVdiaHRnVVdxa3NJbTNT?=
 =?utf-8?B?V3U4Wm5vYU1pdXN4b2ZWWHdJVXdwVEZWdDZCRWVZMTZwNnRhWjZTdnU5SUFr?=
 =?utf-8?B?NXZIVWZmUUxtc2RUejd0RUE2Syt3M2l4ZWZqM1Y4YytyN1dEeWpmY2MxcEhG?=
 =?utf-8?B?RTFDTXFIOU8vYXN6MDJnS1FMK0tkMEdCNUVUSDlMaHZyVDViR3k2UCtqTEYv?=
 =?utf-8?B?RSs1TThjMHcyaUdRNjdoMnN2MnhUOTJJb3lRRzB1VWxDT3FFWWwvQ29tUmxP?=
 =?utf-8?B?UTdhdTZjNG1OVmh6ZldXMzFYNnROdXY4L2txcU1qam5zK0E3a1RwT3NPU0pW?=
 =?utf-8?B?Z1VWUTIxelQzWURzZ2ozVjJyck0xU3VlTlRtcXdkTGlRWWpnbnNlT0VWbTFK?=
 =?utf-8?B?eHAzc0h3eGtwc0oyR2VZak9MMGV4azlRZ21xSHgzSTVOV3hlOVZvTVByZ3dw?=
 =?utf-8?B?NlhpU2Zxc3pMejhqamNmLy84c2c4bE83MlZ3dnZKNy80Tm9VR2FwQW5SSE9a?=
 =?utf-8?B?eGtPcXhmc1pDUUNseGUvb0R6UGJIU0tIcWg3U1pkT0FseE9IR2I4OXNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ymx5ajlhVENVaTBRNXIzUEdMdnc5dDBzRmlnMU9PdFY4YnhOVDdrQ3Q3MEs1?=
 =?utf-8?B?c1BpRUJuc1FHZk45czhLd1czeEhjalRuNThHcjIwbktUdUZLcSt2SW5TVy9P?=
 =?utf-8?B?TER0eVBTdDFqVW1CVWJSYkIveDNMSEZpUk5LSFE4elpDeHhwM0JlSXpwY1lh?=
 =?utf-8?B?WFgrZDVBVURoTE05ZzAxV0dZV2F6V1o2ZXFSazBWQUYzOGwwV1hDTi9DODQ1?=
 =?utf-8?B?U21ISWpTSVFwb3RpN0kyNGhWbDhlSmlPNmtPVkgrLzlCK2hZUFZHc0NEOWwz?=
 =?utf-8?B?TktrcWdSZHAvQmlyUVRZMWpDN2pPTUJ0cUREYTQrTXp6WDFOcFl4ajVIbzZh?=
 =?utf-8?B?QW5xNjFveTlWci81V2NZQWxwS2E5UEgwVUFBNjVpUFJ1bUJvZmRMLzZwMVA1?=
 =?utf-8?B?TE45ZDVGbmtmL3c0TkY3WXM3M3JPTjZ3YW01UTBDaG1KQjc5Ykc2djlzRGg3?=
 =?utf-8?B?ekZYZEdFNGsxUnBscUtVeGFVYXdudEZ1Q3BNaUhwUFgxSGd3WURpTTd6MXU3?=
 =?utf-8?B?UzVsaWpoaGJsUFBNN2RNUm5yN0J5YmY3SEZQRVBBRForWmprbnJqR1JveDBD?=
 =?utf-8?B?UzR4b2dmNEJhWjFOdDJ2djBTYVJKNTFhczhNazZNSWpmb1Q3VUxqR0c3Umg0?=
 =?utf-8?B?bGpCcWtoakJlNnNCanZ5ak5BckpXRnVaZlpvayszK1VodWVJRkh0WStUL05s?=
 =?utf-8?B?aCswc3A4MlVFM1NOQTN2WUtrN0JaKzlubit1OWtBY0dhYVEvR0NYT0J6Y1hl?=
 =?utf-8?B?b21Fdk80NnZNS1lYSFNiZTJNMGZxMndBcFBSVTl1emNaNzdSUVdmdDQycUpE?=
 =?utf-8?B?bWNoWlFCMmNlck8zSXVTQ3NZeGUzNk1DdEpNTlJ6SEFNN1lCaUVNUVlWdTRG?=
 =?utf-8?B?WlRQSzVBaFVJMXBUbnNwL2NEZ1V6OWJYbmE5SHhkeVVSOFJpK3lIdzlVOFor?=
 =?utf-8?B?M3FteXdIZmdpSDllQTd1Z3JBa2VRbGkySkltdTRTdVpMaCt0K044WHdsUG5Q?=
 =?utf-8?B?WDRXbHVId0plbkdiUzV6Um9NUFVDTG5QMm1xRDg5VzdaOGxsSEVWaUV1d2ZZ?=
 =?utf-8?B?WUp5VUJRS0hrU3BidXpSWEZhRjFTQ004d0RjOXFhZlJJNCtCKzBxMi93MEJk?=
 =?utf-8?B?RTJEbTZ6b3RSU1JyTkVLZVpnL0RwSGxNTW9xWmliVSt1VzhsV25IZUcxYlVs?=
 =?utf-8?B?SWdLR0o0bmhCSHJreSs3cHpTNDVBbVZib0xHWTlSNFlCeGxkaGxVWVRuakV4?=
 =?utf-8?B?MjJEWDFjTFQya0s0UHlOdkUwVXQ4MlM5WDVRcFdqeUl0Z0tsWExLNjY4VVp6?=
 =?utf-8?B?R29JdDA3ODAveDFXMjYzU2hjZDQycGlJRG1LcEMyNVdTZjFJZVcrbzQwYVdx?=
 =?utf-8?B?VWJ2c0J6QnB5Z0JuVjI5SjlKRWVMWXpBM09Jc3NIalY4dUE4anhiUVR1RGov?=
 =?utf-8?B?T2ZVSDRvdE5lYTBzajJFa0loVjFacHFiUGtDVUdxbmNZOUpFYmtRVmZxSmk0?=
 =?utf-8?B?aVU4UDFhbGZpRW9PRHZ5SHBPYnJURGNReTc0TmUvQXAvZFVLUUZHNFZLdWh2?=
 =?utf-8?B?U2xpWVJjL3p3OThuRk1mMGpyQ2c3TU5TYWk3djErazNSTytjdnRsaHpUWHhh?=
 =?utf-8?B?N0xTQXIzNWtsUlJreE03VTBjUzRRZjVQd1FwVDZCZVBDQ1VhaTg2Q0lheUll?=
 =?utf-8?B?SmdJTk9ZbTZsb2VZdW9TeU5yRVF1TEdBUlkwVVFyMUNBdklDL01kcVo5Mll3?=
 =?utf-8?B?OHFsN1NUK0F2MU53VllmQVF1aXFiZC9ObW1Dd3JVU1Z0NDZMNzdYUXhaak1Q?=
 =?utf-8?B?YWhYM2tSeVh4T3BqMDJsMFJPT0t1cUZVYWJVT1BTUVRWMVpvM3Z0MG1BdzY4?=
 =?utf-8?B?TDN1aFIxRGZtL1NRSE5BSjZzdmw2RWpBRGxqRmVHU3F4R2NjSVdneE5wdGhx?=
 =?utf-8?B?YjFrMmlhUlBzYVJSd212RXJINnkwdVEyeWpCL0dKWnJ5aGkrMDhYRWEwSFdZ?=
 =?utf-8?B?QXQ0WnEvbGM2UkpqYTJYaVNxY3pjajU4aU95VUE5eHcyckwzUjFvSW1sRXFW?=
 =?utf-8?B?a09POExIdGpZd24zdHNhRTgrcDFiNXJnaXRFWEhvSWJ0U2R6SWEyOGNOQ2Ro?=
 =?utf-8?Q?bM7bKAKOZ4l4YdofZwLaf58tF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdc46f5-ee5e-4a45-1ff5-08dc709eef2a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 03:11:50.2773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4v7MsRe7zfZfjtv2V/mo+I99cYJO+NaqAoTblAOMIwM7DDS3T/DgBOMtI80Sz+EWmET08H6+NJRL2V8+LJtGqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10135

Per spec:
Completion interrupts This transport supports polling or interrupt driven
modes of communication. In interrupt mode, when the callee completes
processing a message, it raises an interrupt to the caller. Hardware
support for completion interrupts is optional.

i.MX95 SCMI firmware is fully interrupt driven, so Platform expects
completion interrupt for Platform to Agent(P2A) notifictions.

Add another optional mailbox channel for Agent to notify Platform that
notification message has been accepted

After notification channel status become freed, Agent will use the
new mailbox channel to send completion interrupt to Platform.

Add shmem_channel_intr_enabled to check channel flags.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Support bidirectional channel and update commit log to include
  bidirectional channel in patch 2.
- Link to v1: https://lore.kernel.org/r/20240507-scmi-notify-v1-0-1fdefc984d53@nxp.com

---
Peng Fan (2):
      dt-bindings: firmware: arm,scmi: Support notification completion channel
      firmware: arm_scmi: mailbox: support P2A channel completion

 .../devicetree/bindings/firmware/arm,scmi.yaml     | 12 +++--
 drivers/firmware/arm_scmi/common.h                 |  1 +
 drivers/firmware/arm_scmi/mailbox.c                | 60 +++++++++++++++++++---
 drivers/firmware/arm_scmi/shmem.c                  |  5 ++
 4 files changed, 68 insertions(+), 10 deletions(-)
---
base-commit: 9221b2819b8a4196eecf5476d66201be60fbcf29
change-id: 20240507-scmi-notify-07e87a8b9a23

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


