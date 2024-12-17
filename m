Return-Path: <linux-kernel+bounces-448843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBBB9F4653
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A6A1883830
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8EC1DDA17;
	Tue, 17 Dec 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R6qu6BQA"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBEE1DD87D;
	Tue, 17 Dec 2024 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425061; cv=fail; b=BSGYWEFNGayFdTczNk32B2ASVk2kvvo4FUQQatfxJc1uGvb5Rm4t+RYJvdA1ltq/k1iB+kmYiA9j5XoTA7AqBPVPI73YQtfWbFiZxfL3XY9cd0NNIqQX3ZZF3g9wc+AdnVcZyw6jUYPVof1W1ATp2dEKRzufYBVlZaBklht6uKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425061; c=relaxed/simple;
	bh=5MOyojSpqwX11IxVjOOF9R2GXBqPmMiF2EXNPK+MRjw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KLDtGsYMRJrjmJP5UaqXzh9rtMMOCSv9Vp+0hnlwPAGHCLEx/wEjm0wyaj/a5GZQPlXGWpIY5sT1/iX2cMWVIK3qinSIwCcyzuRRdMTd889bnqrSUYmEmw8KYi5gpaHHcZSZe7MBEWjUq+47GGGqt51y1a5WI2Au2/farNo+XVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R6qu6BQA; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwfK/m5+XntlAXsSFZehDrQykky7ePIQMybzj4/pSmtfW9iaQSPslo7eujb0dkFrRXmMsDylUYvrZ8HpIuzT67Ej/mRTgh+2IIEJ6BTQgdIR6XbLB4Lbd5oJwzy+Y7sM/pwWWz2rUJl6YsijOqziwebux8GvTzJse9cynJqx+vcobkvxi9DoxUNx0DSiCGvjw5zfKirR8VDTVAuwaU3MIAP+qX+VScwA64+fo6rk4u0SZLDSp4REJIn0eFftwJgWH6DKXSNTYjW0QMoezN7dMe61cIRiXvehrQgApkV2O/je/6t64DZKk/jK/vG8pFDC8GTzqPRPb8NqozJjJ3AQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKqYYMZ0dll4o/xlOunswmWr380CZWxAgBUCCt5iNNQ=;
 b=mTM5KjJ2mkiJ3eIAfDhFBZnbGNf2s+iNGVg63SByuZOYk/c5247bZ9jnpoucDdgD+N+M9aNgcMrITRZ1IGR1AT6tTAi2kidFuwubldk9bKXeuUWcMARw5v0ZVCvKU/dpS9JfGRUuRzPTR/rwGECBGe0ouJEKtUFBvzJO2m5DEXJeAjISs/bRfnv00DK+SPm31tQEgUuDlSTjsP0kGw5UNcV7cK9yAtajealsEG4T/n4Zxs+2XxOyfGAzQbuXW/pTC/B9aSUDRIpgBHz/TMU2f/4dHvj1ap8KLb03/p7KYFKbXh9ksGo14NW3wB9Tf1sFidec/lwWmhijpZMnYX56Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKqYYMZ0dll4o/xlOunswmWr380CZWxAgBUCCt5iNNQ=;
 b=R6qu6BQA0E4lTCDK7J+NEHqEUd12geavQuPe7s59mD/AZ0gqPv2lnrGV2G18IDDQfwMDSOLrHxLsPf4wkUJjeLEQuAwePst8eEplN+eaWW8sMglcDPd8bfX5kXXwVjO6QCwkK505KQy0ARGDa51Z1hFc/HX/vLU2wjuFG1/ftmyN46anwwt8c8/U9IvJXb9rK+McdSICcRcI0rsEjkns18wyq/972qTrX5D2zm+FnxruPpkX+LPh64Wv/3hdYylTMfEw6k6zuEaRwWs8KGBDKFxwLfexhn8cmYsFLR/Sg4MCi0Z5mVBuO/LQYwCUDuAwG313H6c9PBl4am0V0gSfbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB11054.eurprd04.prod.outlook.com (2603:10a6:10:581::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 08:44:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 08:44:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Dec 2024 16:43:37 +0800
Subject: [PATCH v2 2/2] nvmem: imx-ocotp-ele: Support accessing controller
 for i.MX9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-imx-ocotp-v2-2-3faa6cbff41b@nxp.com>
References: <20241217-imx-ocotp-v2-0-3faa6cbff41b@nxp.com>
In-Reply-To: <20241217-imx-ocotp-v2-0-3faa6cbff41b@nxp.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734425027; l=9112;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Piq5sVdSYED7IC9ZoL2zyr8SbeoLnUS3/Uj4YKL+I/Q=;
 b=8YC/hCOExDRy9NMJVOiQc3ikw5yJ4NVB90QaDnT7diUdsN3WCnhGPiC0BFQN3UredBaUr9aof
 RrCalOAjU0AAMrTIqSI+wWAg/mUXvPWHzoUioN2anUevROkcE9HSVmD
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB11054:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b1b9eb-0918-474b-a349-08dd1e76fd99
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWNjM3VuSFlaZi9GOUJESk9iTGdndWtQdEhIZEJZbWhKdkx2Rys3UWJ6K1NR?=
 =?utf-8?B?MTJTd09qZUJGa0t1czFMUjAraDQrVHVlNUZhWUVJNXhmN0pKTHlvaG1YQVIx?=
 =?utf-8?B?dWJiamt0VjRLUk5Rb1N6cklpYVNnODlLaHhaam5JTWRIckFHWm5LK2drK1ha?=
 =?utf-8?B?VHVYTzZGUm92TE9lcFpMaGU5TUxXa2VSZ3hpZ3QzUlo1KzVZNjEzQUtwSzNu?=
 =?utf-8?B?Q1AwRUVpUEtyK2RrQ1pGMGRia1cxbEtvc0JkV21udFNwdC8rSUpjOG5YZ3FG?=
 =?utf-8?B?bTMzY0o0MDdvMjdtbVZyckQ3Wi9KeERySzlmK3hWRnVzMlVsdWJoN0tTNStL?=
 =?utf-8?B?NEZULytaeXhTUjl6YzUzZ0NUMVRmK0hxQzM4eU5qS3o3Nm9TYzRCUHE3TWNi?=
 =?utf-8?B?WXZzQkhzUlFvRC9VL2tVeEtmVysxSDlENDRKSlI5TExHUlB2aWdheUlKNFhs?=
 =?utf-8?B?VEVQa1doalFPL2VqQkZiZ25IZXQ1dThhdm82L2w4b1NEOXM0RVB6eG9BSDB2?=
 =?utf-8?B?bVFYVEJNWGoweUg0V1V1SERreG4wRWVpZFlIRUpmemc1NHhVM1ZHT1k2TWlK?=
 =?utf-8?B?K3V3T0lNK0dlTTQxSEZOejFDbk16Z2JlUFB6S3V1NitXUUFCRzBENlZPemdF?=
 =?utf-8?B?NnduV2hQK3VFYXZMSVNuN1p4N0NmQkR2NFlOeGVmV1k5TFV5VzNVWDR0WFhI?=
 =?utf-8?B?bk5qSkhLckNsWklOdm8vZ0FGU0JzeUlYZ0lmTFlXVDh3WkVobUdRR0ZJRDlZ?=
 =?utf-8?B?c08zRkRqTmpqdng1ZFRoSERuWGdFUG56NXNYamZoWWVZVEUraDdSV09uYzVl?=
 =?utf-8?B?SyswT1ZGdkE0NU5jM0JZaGtONDVucFFzbzZ3UUtLYlFuMTFGZ2U4dFNTNXVz?=
 =?utf-8?B?Y3F2Zk5EaldQSzhwZEZFdWVNZFRnQzhWa0RCT2VyR2dMNHFCakFHeFJ4Tzdz?=
 =?utf-8?B?S3FQd3pQcnRYNUlITExMa3FvOEpwTERhc1lyb2IwR0M3Q2xBWnh0VUx5Vm5a?=
 =?utf-8?B?YlllbW8yTTIxandjUWluR3gzVHhnNk5MMUJtN1psaGhXeVgwV29tckVKSUha?=
 =?utf-8?B?QzFDQnV5bkJUdmtybmNVcmVKQWVTM1VuYXhUcmljOS9rOGVWSitvUU1VL1Nk?=
 =?utf-8?B?QXoyQnhUT2JiU3YwNFg4RWVNK0dvbzZiRWw1YmR2T0ZEd3FOQnUrd0czeHpZ?=
 =?utf-8?B?TGJoaVlzaGJCVllQRnBQTVk2bUZDUFprdGx6NHBpaTJwMUI4NXNBcjJwUWs1?=
 =?utf-8?B?ZTF5K0oxRUM2dzE2NjhRbUJvWWpMVVU2cEduVW56M0hFa2crTHVwV0U4cktm?=
 =?utf-8?B?a3BuYjFpeTR5ZDBzNyt3NWhCclAyS2Z5VXQrOGhzSU5TbytTUkEvd3Z2WHh1?=
 =?utf-8?B?MmdOUjFmeHEyeGt0WFE4SlZnV1hlM3pESlZrMFlGN25rWjRDeWR3bDBFVE8y?=
 =?utf-8?B?aXJiSTVmdWoweWdJb2dBVm9tWE91QjB6V08zWXJBL1JMYWs5MTB1bnMrMXky?=
 =?utf-8?B?RnBjS2dSOXlPSzFzMnRka3NyQ096LzZmSHNCSTF5YUFPVmtaM1RBUEhFZjVs?=
 =?utf-8?B?WHJ3Vks0bzl0MDdUQXlidWFWTmN5cUoraTBFc0NkakdhbWl2MzlkOGJWQndB?=
 =?utf-8?B?Z3FXRXdLWURBRXpTZ1Y1eWo4RlhoZExJcDlsNlp2NU9mdWdZTEY5SUluTUpL?=
 =?utf-8?B?a2tibnQ3eHdEVEsrV0o4b0twZ1lUa3hJSG1jb1ZPYjk3b09XSnhKWVZOaVhK?=
 =?utf-8?B?ZmNzY05SVDRTZlJrQytlbThpamZvTy91SXJCZ0VSUjF0U21kbDlCRXJLS0hF?=
 =?utf-8?B?NDlzSUFoSVBHWVNzVlg1T2dSUGNmWDNGVStJcDhkZjdOZlpMS0d3Vmd6ejdY?=
 =?utf-8?B?MkFzRjErWi9EZlY1NjFuZ3RLMGlhWHlBSktDSEcrM3lENVRJblJIVkZzNnVW?=
 =?utf-8?Q?8+EOtiYM3WB5u6BhlBq8rhY4oLXHECo+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHlXamgvN1BXdzFNeElZNWVvU1VrdWVtTkxEaGg2bDhDRzdLQjZtdmZ6YjBj?=
 =?utf-8?B?MndlWTVCRkdMRjNJcnpOYk1BSis2RGltR0ZJNXF5dWhNaWtWeEQ0NXJKSHE0?=
 =?utf-8?B?QTk5clBpc3BraEowSmJSMG1iUDZGajFJM2p4SjJhWmVwc3M1ZEhjTGlxN0hF?=
 =?utf-8?B?Tlh5c2FWTThLaSt2UXN3Y241QnNrZmFKcTdCZktQSlRmVmxLRXpzZnhBVGNu?=
 =?utf-8?B?VjVPM0FJZ2E0WEJ0UFE1b0Y0Y3NNUjkyWlVsQnhRV0dmTGVxcTNJczZWV0JL?=
 =?utf-8?B?Yi9BNWxmY051NGhVcXBwVzdDd0cxRHRXdmpWbndaaXVaTEdFSFBPYmxwY0ZG?=
 =?utf-8?B?WGlCMWRDalhGdUIwc2U3Z282b3pwZWZJRUFibFZnOFFaSkNmdmVvNXZNcG9U?=
 =?utf-8?B?ckRBYTdUTDlERWlVdVVzbWJFYlJpL3NXMEU5Q01CNWdkV0NkcVJlRGttK2px?=
 =?utf-8?B?b0x4V1J0NnAvVTU0VTVKaWhYSGRmam04a1BTQ0dhbkdnQzdJVEttcld2VlRI?=
 =?utf-8?B?SFUzUVhNQWxWdjhET3NqWEpuSmlOM2RGR0llcDRuMlR5cm53MFNnM1VrQVlG?=
 =?utf-8?B?ZGp4MVUrWUc1SWFydlBXYlYzcjBscS9SRGZuNERRL1pERExGZjNTbzNEQjFE?=
 =?utf-8?B?d0RoSTZScXg5ZHV6bVJwVlJ4N0tNd0d2Sy9yeVhqMk5TTk9Lellmck1zRjZk?=
 =?utf-8?B?c3c1eGN6ZURHYzI3M3kySVgrbHE5SUxhL09uMTVaOWJicE5nV2RUc1JHajdV?=
 =?utf-8?B?dnFvUitKeTRvYjNPU04vM0k0S2NxM1lBTXptZ1JVTStENUhhQUF0UlFHa2N4?=
 =?utf-8?B?NUU5US9tYXBXN2lxV05WZEdLKzlYcU1CZlpnb3dCRW9jdytSbFlORjZvZkhV?=
 =?utf-8?B?bEswOCt2SHdHYUR0SnRYL1NzR1ArNE5lM3ZveVpIUnFNVkdMMkFET2JMQVFG?=
 =?utf-8?B?OXR1L1gyUVJRUDRMaUxLRVhxcldLU0FZSG5EdTFYRGFFdHRBSkFGZjBtMnI1?=
 =?utf-8?B?YzZqSHFFdlI2cnkvQWlKQVd4MnR3NjdYdTNDQzkvc2c5OEFkZlNOaDRjUkkr?=
 =?utf-8?B?M0NoRFlWWi8vL1lOY0ZvZlBQL2xDRlhkcmdUb0x0QjloYTgzYjZpSVBEQkJT?=
 =?utf-8?B?WXRMZ05vY2JPUjhaaXpoRDJMT2ZCcjR3YkJlaExySTFubDQ2SFM4S1BXMXU0?=
 =?utf-8?B?YlVRQm55eC9Yb2ZmSzltRFdENEkvaVczNzdLakY2dzNEK0lXbE50M3lPdXhJ?=
 =?utf-8?B?SGVJRks3L2NQM1Q4OXRnd1U3NnB1YXMrNyttcWdUdjYvTDQ1NXA3eXMxRmVk?=
 =?utf-8?B?eWkwblVXTzY4c2tEelBpLzlKWHlGc1hGSThrcHZKN0tOQnppUVZuNmw0aGtl?=
 =?utf-8?B?ejNrc1JUdFV0dlZvOURXUnpoaU5DYjhaWm82TitBcTFKMzRLNUlESGNXcG1P?=
 =?utf-8?B?RmQ5aU1iczE5ZDYva25mL3lBRGw2Q29MQWsxOG9kNEw0Z2plRnJTZWZZbWRV?=
 =?utf-8?B?dlkrRVQwenFHUm1Ld0JBUVNyV3pGRGFnL0JtdVRmNmliVkdhMThUOEg5dEhX?=
 =?utf-8?B?MXY1UUZZcVJKcmxMcU9JcXJCK0FaTjREZWoxN1ZIcFlTaFZCZGMvTXZGaE56?=
 =?utf-8?B?bnhNWlM4WnQrbzRsZ0E1dS9vaEdVN20vSXpTNUVNUDNRdUM3OVhsVlRxbSt2?=
 =?utf-8?B?bXZnLzBrSmxTb3pIOFYxSmc1L3Z3SXFuMEIxbkxXTVdETVhRWi9WTkJrL2Vs?=
 =?utf-8?B?djk3czVxdVZQcit5UGRETGdnK0F2MTh0K0xITFNaZUUwcWorVmZvWURWNlBq?=
 =?utf-8?B?czA1VlF0aDY4K1BVYlNOSU8zMXZTK2Z0UGtTcEZQbTZXR1VHNmlCSkdRY1Jm?=
 =?utf-8?B?cmp0Y3J4a0RxbHBmekFDcU9BVWF1bUZjKy91Z25aNm1DNktsZzRBNi9BQ2Z0?=
 =?utf-8?B?Ymw5Rkdpdm1VbFNDNWZYT1Vkd3JvMTNzKzZnRktRdVhKam1PT2FodnBQb0FY?=
 =?utf-8?B?RFprdlVqL1lIbnlXQVIrOGpPVU15SlBaT2l3VE5VbUVYZndVbUx1NmNVUHpp?=
 =?utf-8?B?UkRxWWlDWEhWVzFKRXpUL0dKaStjOTNLZE9yVG43SyttWGFWVkVldDhrbjE2?=
 =?utf-8?Q?lg7huqrDQrKrx7QE2OHDFakIj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b1b9eb-0918-474b-a349-08dd1e76fd99
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:44:16.7753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5asnvvcSVRa8o8vgOdX4Kri9UnBD8FFXQHhWRKK2sNv2GOcoty8VIvb/k/2b1fGVW9mk7GtgxnHzHFWyeWVxnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11054

From: Peng Fan <peng.fan@nxp.com>

i.MX9 OCOTP supports a specific peripheral or function being fused
which means disabled, so
 - Introduce ocotp_access_gates to be container of efuse gate info
 - Iterate each node under '/soc' to check accessing permission. If not
   allowed to be accessed, detach the node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvmem/imx-ocotp-ele.c | 184 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 183 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index ca6dd71d8a2e29888c6e556aaea116c1a967cb5f..2c7b698ae4da0ec22eeeabf4ed35d1b703771f6c 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -5,6 +5,8 @@
  * Copyright 2023 NXP
  */
 
+#include <dt-bindings/nvmem/fsl,imx93-ocotp.h>
+#include <dt-bindings/nvmem/fsl,imx95-ocotp.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -27,6 +29,7 @@ struct ocotp_map_entry {
 };
 
 struct ocotp_devtype_data {
+	const struct ocotp_access_gates *access_gates;
 	u32 reg_off;
 	char *name;
 	u32 size;
@@ -36,11 +39,26 @@ struct ocotp_devtype_data {
 	struct ocotp_map_entry entry[];
 };
 
+#define OCOTP_MAX_NUM_GATE_WORDS 4
+#define IMX93_OCOTP_NUM_GATES 17
+#define IMX95_OCOTP_NUM_GATES 36
+
+struct ocotp_access_gates {
+	u32 num_words;
+	u32 words[OCOTP_MAX_NUM_GATE_WORDS];
+	u32 num_gates;
+	struct access_gate {
+		u32 word;
+		u32 mask;
+	} gates[];
+};
+
 struct imx_ocotp_priv {
 	struct device *dev;
 	void __iomem *base;
 	struct nvmem_config config;
 	struct mutex lock;
+	u32 value[OCOTP_MAX_NUM_GATE_WORDS];
 	const struct ocotp_devtype_data *data;
 };
 
@@ -131,6 +149,97 @@ static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
 	cell->read_post_process = imx_ocotp_cell_pp;
 }
 
+static int imx_ele_ocotp_check_access(struct platform_device *pdev, u32 id)
+{
+	struct imx_ocotp_priv *priv = platform_get_drvdata(pdev);
+	const struct ocotp_access_gates *access_gates = priv->data->access_gates;
+	u32 word, mask;
+
+	if (id >= access_gates->num_gates) {
+		dev_err(&pdev->dev, "Index %d too large\n", id);
+		return -EACCES;
+	}
+
+	word = access_gates->gates[id].word;
+	mask = access_gates->gates[id].mask;
+
+	dev_dbg(&pdev->dev, "id:%d word:%d mask:0x%08x\n", id, word, mask);
+	/* true means not allow access */
+	if (priv->value[word] & mask)
+		return -EACCES;
+
+	return 0;
+}
+
+static int imx_ele_ocotp_grant_access(struct platform_device *pdev, struct device_node *parent)
+{
+	struct device_node *child;
+	struct device *dev = &pdev->dev;
+
+	for_each_available_child_of_node(parent, child) {
+		struct of_phandle_iterator it;
+		int err;
+		u32 id;
+
+		of_for_each_phandle(&it, err, child, "access-controllers",
+				    "#access-controller-cells", 0) {
+			struct of_phandle_args provider_args;
+			struct device_node *provider = it.node;
+
+			if (err) {
+				dev_err(dev, "Unable to get access-controllers property for node %s\n, err: %d",
+					child->full_name, err);
+				of_node_put(provider);
+				return err;
+			}
+
+			/* Only support one cell */
+			if (of_phandle_iterator_args(&it, provider_args.args, 1) != 1) {
+				dev_err(dev, "wrong args count\n");
+				return -EINVAL;
+			}
+
+			id = provider_args.args[0];
+
+			dev_dbg(dev, "Checking node: %s gate: %d\n", child->full_name, id);
+
+			if (imx_ele_ocotp_check_access(pdev, id)) {
+				of_detach_node(child);
+				dev_err(dev, "%s: Not granted, device driver will not be probed\n",
+					child->full_name);
+			}
+		}
+
+		imx_ele_ocotp_grant_access(pdev, child);
+	}
+
+	return 0;
+}
+
+static int imx_ele_ocotp_access_control(struct platform_device *pdev)
+{
+	struct imx_ocotp_priv *priv = platform_get_drvdata(pdev);
+	struct device_node *root __free(device_node) = of_find_node_by_path("/");
+	const struct ocotp_access_gates *access_gates = priv->data->access_gates;
+	void __iomem *reg = priv->base + priv->data->reg_off;
+	u32 off;
+	int i;
+
+	if (!priv->data->access_gates)
+		return 0;
+
+	/* This should never happen */
+	WARN_ON(!root);
+
+	for (i = 0; i < access_gates->num_words; i++) {
+		off = access_gates->words[i] << 2;
+		priv->value[i] = readl(reg + off);
+		dev_dbg(&pdev->dev, "word:%d 0x%08x\n", access_gates->words[i], priv->value[i]);
+	}
+
+	return imx_ele_ocotp_grant_access(pdev, root);
+}
+
 static int imx_ele_ocotp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -161,14 +270,43 @@ static int imx_ele_ocotp_probe(struct platform_device *pdev)
 	priv->config.fixup_dt_cell_info = imx_ocotp_fixup_dt_cell_info;
 	mutex_init(&priv->lock);
 
+	platform_set_drvdata(pdev, priv);
+
 	nvmem = devm_nvmem_register(dev, &priv->config);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
 
-	return 0;
+
+	return imx_ele_ocotp_access_control(pdev);
 }
 
+static const struct ocotp_access_gates imx93_access_gates = {
+	.num_words = 3,
+	.words = {19, 20, 21},
+	.num_gates = IMX93_OCOTP_NUM_GATES,
+	.gates = {
+		[IMX93_OCOTP_NPU_GATE]		= { .word = 19, .mask = BIT(13) },
+		[IMX93_OCOTP_A550_GATE]		= { .word = 19, .mask = BIT(14) },
+		[IMX93_OCOTP_A551_GATE]		= { .word = 19, .mask = BIT(15) },
+		[IMX93_OCOTP_M33_GATE]		= { .word = 19, .mask = BIT(24) },
+		[IMX93_OCOTP_CAN1_FD_GATE]	= { .word = 19, .mask = BIT(28) },
+		[IMX93_OCOTP_CAN2_FD_GATE]	= { .word = 19, .mask = BIT(29) },
+		[IMX93_OCOTP_CAN1_GATE]		= { .word = 19, .mask = BIT(30) },
+		[IMX93_OCOTP_CAN2_GATE]		= { .word = 19, .mask = BIT(31) },
+		[IMX93_OCOTP_USB1_GATE]		= { .word = 20, .mask = BIT(3) },
+		[IMX93_OCOTP_USB2_GATE]		= { .word = 20, .mask = BIT(4) },
+		[IMX93_OCOTP_ENET1_GATE]	= { .word = 20, .mask = BIT(5) },
+		[IMX93_OCOTP_ENET2_GATE]	= { .word = 20, .mask = BIT(6) },
+		[IMX93_OCOTP_PXP_GATE]		= { .word = 20, .mask = BIT(10) },
+		[IMX93_OCOTP_MIPI_CSI1_GATE]	= { .word = 20, .mask = BIT(17) },
+		[IMX93_OCOTP_MIPI_DSI1_GATE]	= { .word = 20, .mask = BIT(19) },
+		[IMX93_OCOTP_LVDS1_GATE]	= { .word = 20, .mask = BIT(24) },
+		[IMX93_OCOTP_ADC1_GATE]		= { .word = 21, .mask = BIT(7) },
+	},
+};
+
 static const struct ocotp_devtype_data imx93_ocotp_data = {
+	.access_gates = &imx93_access_gates,
 	.reg_off = 0x8000,
 	.reg_read = imx_ocotp_reg_read,
 	.size = 2048,
@@ -183,7 +321,51 @@ static const struct ocotp_devtype_data imx93_ocotp_data = {
 	},
 };
 
+static const struct ocotp_access_gates imx95_access_gates = {
+	.num_words = 3,
+	.words = {17, 18, 19},
+	.num_gates = IMX95_OCOTP_NUM_GATES,
+	.gates = {
+		[IMX95_OCOTP_CANFD1_GATE]	= { .word = 17, .mask = BIT(20) },
+		[IMX95_OCOTP_CANFD2_GATE]	= { .word = 17, .mask = BIT(21) },
+		[IMX95_OCOTP_CANFD3_GATE]	= { .word = 17, .mask = BIT(22) },
+		[IMX95_OCOTP_CANFD4_GATE]	= { .word = 17, .mask = BIT(23) },
+		[IMX95_OCOTP_CANFD5_GATE]	= { .word = 17, .mask = BIT(24) },
+		[IMX95_OCOTP_CAN1_GATE]	= { .word = 17, .mask = BIT(25) },
+		[IMX95_OCOTP_CAN2_GATE]	= { .word = 17, .mask = BIT(26) },
+		[IMX95_OCOTP_CAN3_GATE]	= { .word = 17, .mask = BIT(27) },
+		[IMX95_OCOTP_CAN4_GATE]	= { .word = 17, .mask = BIT(28) },
+		[IMX95_OCOTP_CAN5_GATE]	= { .word = 17, .mask = BIT(29) },
+		[IMX95_OCOTP_NPU_GATE]		= { .word = 18, .mask = BIT(0) },
+		[IMX95_OCOTP_A550_GATE]	= { .word = 18, .mask = BIT(1) },
+		[IMX95_OCOTP_A551_GATE]	= { .word = 18, .mask = BIT(2) },
+		[IMX95_OCOTP_A552_GATE]	= { .word = 18, .mask = BIT(3) },
+		[IMX95_OCOTP_A553_GATE]	= { .word = 18, .mask = BIT(4) },
+		[IMX95_OCOTP_A554_GATE]	= { .word = 18, .mask = BIT(5) },
+		[IMX95_OCOTP_A555_GATE]	= { .word = 18, .mask = BIT(6) },
+		[IMX95_OCOTP_M7_GATE]		= { .word = 18, .mask = BIT(9) },
+		[IMX95_OCOTP_DCSS_GATE]	= { .word = 18, .mask = BIT(22) },
+		[IMX95_OCOTP_LVDS1_GATE]	= { .word = 18, .mask = BIT(27) },
+		[IMX95_OCOTP_ISP_GATE]		= { .word = 18, .mask = BIT(29) },
+		[IMX95_OCOTP_USB1_GATE]	= { .word = 19, .mask = BIT(2) },
+		[IMX95_OCOTP_USB2_GATE]	= { .word = 19, .mask = BIT(3) },
+		[IMX95_OCOTP_NETC_GATE]	= { .word = 19, .mask = BIT(4) },
+		[IMX95_OCOTP_PCIE1_GATE]	= { .word = 19, .mask = BIT(6) },
+		[IMX95_OCOTP_PCIE2_GATE]	= { .word = 19, .mask = BIT(7) },
+		[IMX95_OCOTP_ADC1_GATE]	= { .word = 19, .mask = BIT(8) },
+		[IMX95_OCOTP_EARC_RX_GATE]	= { .word = 19, .mask = BIT(11) },
+		[IMX95_OCOTP_GPU3D_GATE]	= { .word = 19, .mask = BIT(16) },
+		[IMX95_OCOTP_VPU_GATE]		= { .word = 19, .mask = BIT(17) },
+		[IMX95_OCOTP_JPEG_ENC_GATE]	= { .word = 19, .mask = BIT(18) },
+		[IMX95_OCOTP_JPEG_DEC_GATE]	= { .word = 19, .mask = BIT(19) },
+		[IMX95_OCOTP_MIPI_CSI1_GATE]	= { .word = 19, .mask = BIT(21) },
+		[IMX95_OCOTP_MIPI_CSI2_GATE]	= { .word = 19, .mask = BIT(22) },
+		[IMX95_OCOTP_MIPI_DSI1_GATE]	= { .word = 19, .mask = BIT(23) },
+	}
+};
+
 static const struct ocotp_devtype_data imx95_ocotp_data = {
+	.access_gates = &imx95_access_gates,
 	.reg_off = 0x8000,
 	.reg_read = imx_ocotp_reg_read,
 	.size = 2048,

-- 
2.37.1


