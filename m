Return-Path: <linux-kernel+bounces-510660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D417EA3201A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61284164FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF33D2046A2;
	Wed, 12 Feb 2025 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OjjGFd/o"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCA2046AD;
	Wed, 12 Feb 2025 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346090; cv=fail; b=ip+cH1OIU/FNL1uu4fLed868lC9v3eZ7Hq8CWpuA+Rd91jT9FBmsGuZnNJkiM61tcUFFSyI5TlbdTbaxPFvCdGX8E9WMJcLBYiVJ1zfVrXAVUdzpfbS8TLezu/rjBfqNNKyI2/Dov4qN7ZPnfv7v2Cwfcpa2P+Hh82k2CF0GjaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346090; c=relaxed/simple;
	bh=JaGCgwiXovMxOULH552iIc/Xz42kf9MIaR0jqTbK/Mk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=F5y6tlZio7umkUc7XUOKO877Szu1cPkTgRu3pmX1W4iubxLLJZwdgopFRvYBzoUD3N5L1Zl+OwH+BY696vEjZ4S5o4y6+tpSN4S4avTw/NAuN0pLzpwqnvXxbsxY29BK0oFqkytcLm6OSG3ls0SIcABIrkKYA4xfTUWxwSOi8KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OjjGFd/o; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaace57brspKE2Vbinhd2jWHFEl+bi/zb/32GE3dXEhSU6u6Zuz87WxQWdxnWhV46AVs62mph88fzX21Ke9vFD7tg1whADEnpfNxlrgtzzFEjUj13YHQVeLAZpLIGZv0T06QUaMb8YZfKS/0VC9bVcrDhl3he95MdHip3OCb9gDmpmS8o5lggGCOuZ4V1/q3BotyEK4Sp6o9xBjxo19jTx6QwHykOhtByW+fHYmfdFI6qc7j0m3pJJ2D39JucU+Gdc64H9+ugeptxbIZLq5Swil57cTB2c2QSYqarCwkEauN0ZXoNjyzpSm2fp7uyVwZmLrPPg3h9gor4UAYkBslYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANnsaSQu9v+dXsEa8nLp4hGE1OxMJ3A5MhNkRRBPxuM=;
 b=U8GybYfq7xFCYwKllnF/6ZoZtQ4tcPov81VuDoNkpNO00WPL+Eo27f6tFWedOXAmu3upWswkmSeN4xQPr8fQ8prrES5nO0lfrMb9QVKGliz1ptjUrf6Ua4bKPs9j2lCy7cIULjJg8eUMk+fOq3ByeFgqSrHObwXVgjBFBBdXgmfwIs6krX29c9UeB55XOmYBXzMf73bVuRlOC1JDrJhYoehVJsdJCXDG1sNEMbdZvi0y0hiWjrQ754RvSOa7wWKqm5TxdVs4mav8Mp3EmuKU1sw54lbhsaBoYE9M1bwV3EFZUhzVL9ixg07ZTFdSYfFQ6ZzVJwJ6FjljBBbwUYNn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANnsaSQu9v+dXsEa8nLp4hGE1OxMJ3A5MhNkRRBPxuM=;
 b=OjjGFd/oaP9xVHRqAUsriZqd3KKW/+o0sqoQlRikkE29TUMYmwhGn7GTjXuWc1wHqXLjhx8K4dG56vue35H1zde6vWVAMR8X4ZCAyNAxetZCbYFsq+rbcPuek1VTcSLVONQwWydCSjfWNwdmyy6FCEuF7xMIayQ1Q6cHMyhLOmJxodbMIWBdBrmS3hnDwhi7y5dodgXTVUpoWQARmvRm9P0v6SUCpSCFFQB/vKaik60V/lRRJnGkQc9068c0jHTMSY+uloeW7Rc7hrmVQPo9U5czYWMpj5EgMw+35P86bpPeZ+QkTLOCdylM20eHoWESdXVpm4ow4OityKogFVWc3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10865.eurprd04.prod.outlook.com (2603:10a6:102:48a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 07:41:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 07:41:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 12 Feb 2025 15:40:23 +0800
Subject: [PATCH v2 1/7] firmware: arm_scmi: imx: Add LMM and CPU
 documentation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-imx-lmm-cpu-v2-1-3aee005968c1@nxp.com>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
In-Reply-To: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739346036; l=47604;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=eE9l9TA9pCk/iFtIAlt9euJ2zISH4ZXCj0VwFDxu54s=;
 b=s08eUySPIT2+EKBEIRDHGUp8LC9hf4/3YPP8DNJMvflaEacxa4G07YLIYBlVSFuZjwDsac/bp
 FMqTbpelCnwALbv8o29xRmLFLMxagr7DqvHPKlVR5FbyGaEQ5QmhiRD
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10865:EE_
X-MS-Office365-Filtering-Correlation-Id: c361aef4-9c84-4870-d8f8-08dd4b38a64a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QS9Pa0N4T242c243NWcrdjVUNm56WmtvcmtWNERlMXZYMWNoUS9SYlgyUFhO?=
 =?utf-8?B?THVZR1ErNFBXYWFETXJGMUM0Uk1yaXZNT2RrSGVkYnBMSzk3YXNnNmFmc2Fu?=
 =?utf-8?B?djJZRzVnYmVPZHYwbnJlcFdpT3VoWHZoWmdjdU5kbXJRQXdzNE9zUVhQSlhh?=
 =?utf-8?B?NHJvaTl1YmZ3cGp0dE43MkVIQ2N0aVpCWUhybjVtV00rL1FsSFB1UVJqWkNx?=
 =?utf-8?B?bCtyaEpjWDROWVZ1M2tXQ1VMY0lIK0pVcWNjdWJoWG00bjIvZFFPRVpqcUtR?=
 =?utf-8?B?NmRUYTlqYTNFaEJ3eVZpWnJZL0Ewd3BGVlhDa1lOejNFTjVzcUdpQzM1RkI0?=
 =?utf-8?B?UjErMHp4VG5jNzRSSFYvdFNEOUVTNEtGcFlZaFNBNkFpcHB1NVE3YVNidmR6?=
 =?utf-8?B?VDA5MlFwdG5wWXMyRnArY2xvdmRrQnRsU2VLUksxV2wwQ2c4d2ZmRVZ4MkhP?=
 =?utf-8?B?a3ZMMXFpYmxUUjltVHFEMEh1SjAxWGtlZ0U2enRMV0VvNk5pckJxUi9OZUZo?=
 =?utf-8?B?MHFYcmkveVRhVmhFZHB4Zmt6ckxnMTRnVWhlK3NTV0l6L2ZSUi92eU9aYkZx?=
 =?utf-8?B?MGhaNG9QZmQzaWZRajZOR3Z0WS96aUpWVnpWenRHcnZ0SmlRYTJRSkFPOUxM?=
 =?utf-8?B?dkdnWGZzc0U4OC9JTDRRNDg1bWVsWEcralVtbXpZOGRyQXlzUGpxM2Q2cmZ6?=
 =?utf-8?B?WDFxeTNUVGtTamFaZXl3aUpNbVBnUTRqQlZyN1dKVkN0NkNrMUhxNTcwcEgx?=
 =?utf-8?B?T1BvaDRiWFhHQzV1NjhyUFpCR1J3QytOaEhvYWR5UGpENHp2WXc4czRmem1y?=
 =?utf-8?B?QUVxTXZhdXhxVXl6WGh5clQxSFRORzRVRWZZT0t2d2hkc2dqaFduaVIvR05R?=
 =?utf-8?B?aG4xRm0rZ3hVWFVOc3Awbm5FQ1BmSkVvTHN1VDhYb2NvSWZKRUpBQlpVT0Va?=
 =?utf-8?B?c3huOFZSMDFiZnFZUFEvSUp0a1REaXRyRGFIczhES1FxekpDcXNCV0dVczNl?=
 =?utf-8?B?Y1M5OXEvTkd0QW5oSkxHZzRJd09kb2JBNU01ekF1TWVwK0tCWmE2VUtYbElp?=
 =?utf-8?B?YndiT2Q2eXA5ZTIvL2YwL3lqOGJpdGo4eDU4MVB3R1k3OFBkQVRMMDBMT01t?=
 =?utf-8?B?Q2V0RDdBd0FyOWZwY0FPTEQrNUFTSHdFdmFLZlpaMGhyblpNb0U1WGgyV0JW?=
 =?utf-8?B?aXhiSGtWZVRFZnIxOHdBTVZqd05mb1A4VkRRTDA1MnBnS3Bkek1GQXNBeXlk?=
 =?utf-8?B?UE0vR0FnZkJMbVQzNlA5aFRLRC8zMElXa1RFUCsydWhzY2tvaDdTNlNvVHly?=
 =?utf-8?B?R2V6Sys2TVd3SU51MUROYWpuckg5STg4cVYzZys0VWxkdHkxeWNqeWU0d3pS?=
 =?utf-8?B?ZkhVc3ArVEVlcG5YWXJRK1cyTnZOSGl0THk4a3l5OUpSSVdna3pLZFovSGY5?=
 =?utf-8?B?TnBzN25jVFMvaU40ZkQ0Q2NIVk9Fc2pJTU9JZFVpVFAxT29qRDhYQVd1V0ZH?=
 =?utf-8?B?dEQyaW9PTFFaYTd1UTQ4QWw5eFEzRTdHZWs1QW4vdURsVmgwa3M0dmxFdnRX?=
 =?utf-8?B?Uzc5cEFvLytQcFBwZ0FTM0srakVCT2hnbEJuMWpEYkhVcGJkMWZ5WkRKaXRZ?=
 =?utf-8?B?Z25NN0diN2YvZGRNT244aUFac2Z0ZXRnRm9tOUc1Ny9VNHRlVi9lTy9mRlY5?=
 =?utf-8?B?amlrMmhFdlRrYU1rbkkveHRWb3RwRFhvbUlmVmtndlljR3pxSVRUVkcvcWNQ?=
 =?utf-8?B?MEdzT1NqTGJJVUNmb0FFajAzTzBJaE9UQXM2T0VmQ0ZyZnB2NTJKdllYL3FW?=
 =?utf-8?B?dXVwNzNSUXF3MHVwbDV3YTZZOVd0VWpKdSt0aklRVm9YSjhTVXVOOU5lUG8r?=
 =?utf-8?B?SU5XN0F1emVMSVd3T0dZMWM3N3RJR09sclAxWjZNbTJxU3l6VFhENlgxdUQ5?=
 =?utf-8?Q?njvfHYBquO63ootAHAojcDKUlBIftOcI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3VnYk50U0lkTjNVbld1WTFuM0R4WmpINzlYbDFkRUZjR05OU091YU5Ed2Nz?=
 =?utf-8?B?Q1Y3U29TUzVNQXBCenB3WkI3UUp6Y0g0RFdGeW1xa2RBZXNFcmFwRGwyMlJK?=
 =?utf-8?B?ZHJtSVpVYysva0FTRGFZOFNCNHVlYUEzdHZDK0JqSERuWm5TZ0F1cEU3QmZi?=
 =?utf-8?B?YkxkMU9YOWk5b0g2dCtRZEg0VDlpUlZka0x0S1BjMVM4Sm54akFmSkVhdlYr?=
 =?utf-8?B?NkMzcUZEL3oxaGpZVG1DTGF0SzlsemI2UDFqVGVWbE9qVDAyT2FJQ0daK3lJ?=
 =?utf-8?B?S3pHQmZzRUgzWTJjRWQxQ2p5RWI2bXJQNTRnMFJzaFZVOGZVWW1qdG1yTDIw?=
 =?utf-8?B?T2pjMVdPazhIdk10RVh2YmtPc2Ryc2Fvb1NmalZvYytscE1sWTRtRlhON3pE?=
 =?utf-8?B?MmNjR0hyQ0xXYzFXbmJ1TkVwYnJMdVhEN1MweEQxWlBUTXcrMjlSZWFGMVVa?=
 =?utf-8?B?dlVqOXA3aFR2Ukp6Mnl2Z3U2RHovbnF2cXNQWWdTSWtBUndBVnhySzRiOXFh?=
 =?utf-8?B?NFNFTzBBcVcvQWVBQ3IvT0VXMC8yTFFoRFF0RUdoUG1peXJJT1V5VW43SEg4?=
 =?utf-8?B?N0t0eWkxenVIVGFuTkozVWtvUXZZaWlYSHFHWDZNYWZTRDdHaWh2K3dscXZ2?=
 =?utf-8?B?QUNqQlNtdVRaU0V1cFFDSElrZ3Q4T3FFTksxT1Z6a1g2SHpraGNRblBGNUNI?=
 =?utf-8?B?c24wNmRmcERZUWN2SlhudTdibWtTOFRBVFRRclVLSkloZmxrUXNLU1dQWlhI?=
 =?utf-8?B?M3ViUzdQRVEvaGZtdmhJZklnNFpPcWFzR3NORmtUejc0SGRmQXFMUnovM0xP?=
 =?utf-8?B?ZE03bEVvMU4vSjZxRGMyTEV2S05mUEIrSnpwOENBNFRrbUw0anc2RWF2TExY?=
 =?utf-8?B?M1ZGbVVTUU5lOU5mT1A5MW5RcEhkTkdLRWhWaWZ3eGZaWVA2NVJUTW5HSnVZ?=
 =?utf-8?B?YTYwVFJEMms1QytNTjNpT3hkVStOTFNTQnlrY05FR2VqeDFFckl0b2pNeE1E?=
 =?utf-8?B?Z0lRS2JqdnZaUWdmZHN5VmJNSDFHNHdWaXdZcmRscFZscnY2bXhGaHdwdmsy?=
 =?utf-8?B?M21UYUxrRit4bmRBaE1Wd3lZL0tsT0lEb29sc1hTUERaL3lJSDB4eW9va2kr?=
 =?utf-8?B?NDZsaEU5ZjRtMnp2elFXcU9FTjVsRk1Na0tGQUozK3FYejVUZ2V0cXBXWHYz?=
 =?utf-8?B?bWZ5OVlMZmxTWGhDUkRLWDh0cE5SLys2eGNIMU82OGxQb010WFp2QTFvRVdK?=
 =?utf-8?B?b0MxVHZPZ2liaWo4Sk85TVRmQmppRjRtbmZreW1uYS9xcVNqa0k5UW9wSmtm?=
 =?utf-8?B?VHNCNmV0TS90dDh3NHFWMGR6RVhmUWk0VWw5Wk5zSlpia1NoL1h2UTk2T2hR?=
 =?utf-8?B?QWVLam55aDlVZDcvdmZ0RmE2aG9VaGt3VlZIMC9CejJEQ0dJU2FJWjJPakYz?=
 =?utf-8?B?NGlqdjFPVWl3YVZEV1UwTk00amJLbUFRUk1KcHE4MS9TOHdFMnRpZGtDeUVv?=
 =?utf-8?B?SG5uYitCUjBsb0xXT1l2OE1DdFR4cEloajhkWWFzTXU1OXNrK3JUeVF4NnJ3?=
 =?utf-8?B?aEh6bmh6encvbktmU280UkFsZDRHMHAwS1pCemRteEZhdm81YXVSVkJqb2Fp?=
 =?utf-8?B?cTh5OUx5LytEbVhFbEpJUVZDY0FtOTQxT2tUSUNENllmeGhqbXJIbmpGS1Nu?=
 =?utf-8?B?TTlHUzhlZmxLMnZHdlcwNndCdjFoZTJhT3I1cjk5c1VleGUxeEtpNzZranVp?=
 =?utf-8?B?c1kvYnRPbHlxZEpvTXNrUEczWjVxUkloaWZuYkFQOHhUaStBZkxCMklaQnFG?=
 =?utf-8?B?UGMyWkY4L09ZTjEwVzVmNkpFNmJpWS85N21FVlV5dk9PUlM0ZXZvVnlEc0li?=
 =?utf-8?B?TlpveUpsV2hEV0hITTNGWmQ0dkltWnZOMVFRemtxblkwUzlXZHVzWGd2WkJv?=
 =?utf-8?B?TlVwYVphbUpxTmI5cmsrTGI4L0FRNUxWTEdRWHpUc2kwZ1dDcWRiV2grS1Y0?=
 =?utf-8?B?Nm5VQ04xZ2hucGw5SzI5eDlFZ3BoMys2NVBaeFh0enZmQk9BeUUySnFHR01Y?=
 =?utf-8?B?c1ljdnR6bVc2NW9WS0t3eWhmb0lnWHM1MEttOEd3MTY3KzJudmdRNEdwbzdS?=
 =?utf-8?Q?TPt7QaQRy5OKoAsMjtCOj0XS1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c361aef4-9c84-4870-d8f8-08dd4b38a64a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 07:41:24.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjaSpochQ149WaktwGkaXzA62kvpBozrCSCs++vMbj5PQv0JrrguvJC1ByAJl1637jnQQYnBcUXMUJloQd75iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10865

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 Logical Machine Management and CPU Protocol documentation.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/vendors/imx/imx95.rst | 737 ++++++++++++++++++++++++
 1 file changed, 737 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
index b2dfd6c46ca2f5f12f0475c24cb54c060e9fa421..78a09cd8102becd5584d28bdef18df2d77fb7e7c 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
@@ -32,6 +32,461 @@ port, and deploy the SM on supported processors.
 The SM implements an interface compliant with the Arm SCMI Specification
 with additional vendor specific extensions.
 
+SCMI_LMM: System Control and Management Logical Machine Management Vendor Protocol
+==================================================================================
+
+This protocol is intended for boot, shutdown, and reset of other logical
+machines (LM). It is usually used to allow one LM(e.g. OSPM) to manage
+another LM which is usually an offload or accelerator engine.. Notifications
+from this protocol can also be used to manage a communication link to another
+LM. The LMM protocol provides functions to:
+
+- Describe the protocol version.
+- Discover implementation attributes.
+- Discover the LMs defined in the system.
+- Boot an LM.
+- Shutdown an LM (gracefully or forcibly).
+- Reset an LM (gracefully or forcibly).
+- Wake an LM from suspend.
+- Suspend an LM (gracefully).
+- Read boot/shutdown/reset information for an LM.
+- Get notifications when an LM boots or shuts down (e.g. LM[X] requested
+  notification of LM[Y] boots or shuts down, when LM[Y] boots or shuts down,
+  SCMI firmware will send notification to LM[X]).
+
+'Graceful' means asking LM itself to shutdown/reset/etc (e.g. sending
+notification to Linux, Then Linux reboots or powers down itself).
+
+Commands:
+_________
+
+PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x80
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++---------------+--------------------------------------------------------------+
+|Name           |Description                                                   |
++---------------+--------------------------------------------------------------+
+|int32 status   | See ARM SCMI Specification for status code definitions.      |
++---------------+--------------------------------------------------------------+
+|uint32 version | For this revision of the specification, this value must be   |
+|               | 0x10000.                                                     |
++---------------+--------------------------------------------------------------+
+
+PROTOCOL_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x1
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      | See ARM SCMI Specification for status code definitions.   |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Protocol attributes:                                       |
+|                  |Bits[31:8] Reserved, must be zero.                         |
+|                  |Bits[7:0] Number of Logical Machines                       |
++------------------+-----------------------------------------------------------+
+
+PROTOCOL_MESSAGE_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x2
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: in case the message is implemented and available  |
+|                  |to use.                                                    |
+|                  |NOT_FOUND: if the message identified by message_id is      |
+|                  |invalid or not implemented                                 |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Flags that are associated with a specific function in the  |
+|                  |protocol. For all functions in this protocol, this         |
+|                  |parameter has a value of 0                                 |
++------------------+-----------------------------------------------------------+
+
+LMM_ATTRIBUTES
+~~~~~~~~~~~~~~
+
+message_id: 0x3
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if valid attributes are returned.                 |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |DENIED: if the agent does not have permission to get info  |
+|                  |for the LM specified by lmid.                              |
++------------------+-----------------------------------------------------------+
+|uint32 attributes | Bits[31:8] reserved.                                      |
+|                  | Bits[7:0] Number of Logical Machines.                     |
++------------------+-----------------------------------------------------------+
+
+LMM_BOOT
+~~~~~~~~
+
+message_id: 0x4
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if LM successfully booted.                        |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
+|                  |DENIED: if the agent does not have permission to manage the|
+|                  |the LM specified by lmid.                                  |
++------------------+-----------------------------------------------------------+
+
+LMM_RESET
+~~~~~~~~~
+
+message_id: 0x5
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Reset flags:                                               |
+|                  |Bits[31:1] Reserved, must be zero.                         |
+|                  |Bit[0] Graceful request:                                   |
+|                  |Set to 1 if the request is a graceful request.             |
+|                  |Set to 0 if the request is a forceful request.             |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if LM successfully resets.                        |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
+|                  |DENIED: if the agent does not have permission to manage the|
+|                  |the LM specified by lmid.                                  |
++------------------+-----------------------------------------------------------+
+
+LMM_SHUTDOWN
+~~~~~~~~~~~~
+
+message_id: 0x6
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Reset flags:                                               |
+|                  |Bits[31:1] Reserved, must be zero.                         |
+|                  |Bit[0] Graceful request:                                   |
+|                  |Set to 1 if the request is a graceful request.             |
+|                  |Set to 0 if the request is a forceful request.             |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if LM successfully shutdowns.                     |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
+|                  |DENIED: if the agent does not have permission to manage the|
+|                  |the LM specified by lmid.                                  |
++------------------+-----------------------------------------------------------+
+
+LMM_WAKE
+~~~~~~~~
+
+message_id: 0x7
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if LM successfully wakes.                         |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
+|                  |DENIED: if the agent does not have permission to manage the|
+|                  |the LM specified by lmid.                                  |
++------------------+-----------------------------------------------------------+
+
+LMM_SUSPEND
+~~~~~~~~~~~
+
+message_id: 0x8
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if LM successfully suspends.                      |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
+|                  |DENIED: if the agent does not have permission to manage the|
+|                  |the LM specified by lmid.                                  |
++------------------+-----------------------------------------------------------+
+
+LMM_NOTIFY
+~~~~~~~~~~
+
+message_id: 0x9
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Notification flags:                                        |
+|                  |Bits[31:3] Reserved, must be zero.                         |
+|                  |Bit[3] Wake (resume) notification:                         |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification.                               |
+|                  |Bit[2] Suspend (sleep) notification:                       |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification.                               |
+|                  |Bit[1] Shutdown (off) notification:                        |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification.                               |
+|                  |Bit[0] Boot (on) notification:                             |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification                                |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the notification state successfully updated.   |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |INVALID_PARAMETERS: if input attributes flag specifies     |
+|                  |unsupported or invalid configurations.                     |
+|                  |DENIED: if the agent does not have permission to request   |
+|                  |the notification.                                          |
++------------------+-----------------------------------------------------------+
+
+LMM_RESET_REASON
+~~~~~~~~~~~~~~~~
+
+message_id: 0xA
+protocol_id: 0x80
+
++---------------------+--------------------------------------------------------+
+|Parameters                                                                    |
++---------------------+--------------------------------------------------------+
+|Name                 |Description                                             |
++---------------------+--------------------------------------------------------+
+|uint32 lmid          |ID of the Logical Machine                               |
++---------------------+--------------------------------------------------------+
+|Return values                                                                 |
++---------------------+--------------------------------------------------------+
+|Name                 |Description                                             |
++---------------------+--------------------------------------------------------+
+|int32 status         |SUCCESS: if LM successfully suspends.                   |
+|                     |NOT_FOUND: if lmId not points to a valid logical machine|
+|                     |DENIED: if the agent does not have permission to request|
+|                     |the reset reason.                                       |
++---------------------+--------------------------------------------------------+
+|uint32 bootflags     |Boot reason flags. This parameter has the format:       |
+|                     |Bits[31] Valid.                                         |
+|                     |Set to 1 if the entire reason is valid.                 |
+|                     |Set to 0 if the entire reason is not valid.             |
+|                     |Bits[30:29] Reserved, must be zero.                     |
+|                     |Bit[28] Valid origin:                                   |
+|                     |Set to 1 if the origin field is valid.                  |
+|                     |Set to 0 if the origin field is not valid.              |
+|                     |Bits[27:24] Origin.                                     |
+|                     |Bit[23] Valid err ID:                                   |
+|                     |Set to 1 if the error ID field is valid.                |
+|                     |Set to 0 if the error ID field is not valid.            |
+|                     |Bits[22:8] Error ID.                                    |
+|                     |Bit[7:0] Reason(WDOG, POR, FCCU and etc)                |
++---------------------+--------------------------------------------------------+
+|uint32 shutdownflags |Shutdown reason flags. This parameter has the format:   |
+|                     |Bits[31] Valid.                                         |
+|                     |Set to 1 if the entire reason is valid.                 |
+|                     |Set to 0 if the entire reason is not valid.             |
+|                     |Bits[30:29] Number of valid extended info words.        |
+|                     |Bit[28] Valid origin:                                   |
+|                     |Set to 1 if the origin field is valid.                  |
+|                     |Set to 0 if the origin field is not valid.              |
+|                     |Bits[27:24] Origin.                                     |
+|                     |Bit[23] Valid err ID:                                   |
+|                     |Set to 1 if the error ID field is valid.                |
+|                     |Set to 0 if the error ID field is not valid.            |
+|                     |Bits[22:8] Error ID.                                    |
+|                     |Bit[7:0] Reason                                         |
++---------------------+--------------------------------------------------------+
+|uint32 extinfo[0,20] |Array of extended info words(e.g. fault pc)             |
++---------------------+--------------------------------------------------------+
+
+LMM_POWER_ON
+~~~~~~~~~~~~
+
+message_id: 0xB
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if LM successfully powers on.                     |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
+|                  |DENIED: if the agent does not have permission to manage the|
+|                  |the LM specified by lmid.                                  |
++------------------+-----------------------------------------------------------+
+
+LMM_RESET_VECTOR_SET
+~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0xC
+protocol_id: 0x80
+
++-----------------------+------------------------------------------------------+
+|Parameters                                                                    |
++-----------------------+------------------------------------------------------+
+|Name                   |Description                                           |
++-----------------------+------------------------------------------------------+
+|uint32 lmid            |ID of the Logical Machine                             |
++-----------------------+------------------------------------------------------+
+|uint32 cpuid           |ID of the CPU inside the LM                           |
++-----------------------+------------------------------------------------------+
+|uint32 flags           |Reset vector flags                                    |
+|                       |Bits[31:1] Reserved, must be zero.                    |
+|                       |Bit[0] Table flag.                                    |
+|                       |Set to 1 if vector is the vector table base address   |
++-----------------------+------------------------------------------------------+
+|uint32 resetVectorLow  |Lower vector                                          |
++-----------------------+------------------------------------------------------+
+|uint32 resetVectorHigh |Higher vector                                         |
++-----------------------+------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if LM successfully powers on.                     |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine,  |
+|                  |or cpuId is not valid.
+|                  |INVALID_PARAMETERS: if reset vector is invalid.            |
+|                  |DENIED: if the agent does not have permission to set the   |
+|                  |the reset vector for the CPU in the LM.                    |
++------------------+-----------------------------------------------------------+
+
+NEGOTIATE_PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x10
+protocol_id: 0x80
+
++--------------------+---------------------------------------------------------+
+|Parameters                                                                    |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|uint32 version      |The negotiated protocol version the agent intends to use |
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: if the negotiated protocol version is supported |
+|                    |by the platform. All commands, responses, and            |
+|                    |notifications post successful return of this command must|
+|                    |comply with the negotiated version.                      |
+|                    |NOT_SUPPORTED: if the protocol version is not supported. |
++--------------------+---------------------------------------------------------+
+
+Notifications
+_____________
+
+LMM_EVENT
+~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |Identifier for the LM that caused the transition.          |
++------------------+-----------------------------------------------------------+
+|uint32 eventlm    |Identifier for the LM the event is for.                    |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |LM events:                                                 |
+|                  |Bits[31:3] Reserved, must be zero.                         |
+|                  |Bit[3] Wake (resume) event:                                |
+|                  |1 LM has awakened.                                         |
+|                  |0 not a wake event.                                        |
+|                  |Bit[2] Suspend (sleep) event:                              |
+|                  |1 LM has suspended.                                        |
+|                  |0 not a suspend event.                                     |
+|                  |Bit[1] Shutdown (off) event:                               |
+|                  |1 LM has shutdown.                                         |
+|                  |0 not a shutdown event.                                    |
+|                  |Bit[0] Boot (on) event:                                    |
+|                  |1 LM has booted.                                           |
+|                  |0 not a boot event.                                        |
++------------------+-----------------------------------------------------------+
+
 SCMI_BBM: System Control and Management BBM Vendor Protocol
 ==============================================================
 
@@ -436,6 +891,288 @@ protocol_id: 0x81
 |                  |0 no button change detected.                               |
 +------------------+-----------------------------------------------------------+
 
+SCMI_CPU: System Control and Management CPU Vendor Protocol
+==============================================================
+
+This protocol allows an agent to start or stop a CPU. It is used to manage
+auxiliary CPUs in an LM (e.g. additional cores in an AP cluster or
+Cortex-M cores).
+Note: For cores in AP cluster, ATF will use CPU protocol to handle them.
+
+The CPU protocol provides functions to:
+
+- Describe the protocol version.
+- Discover implementation attributes.
+- Discover the CPUs defined in the system.
+- Start a CPU.
+- Stop a CPU.
+- Set the boot and resume addresses for a CPU.
+- Set the sleep mode of a CPU.
+- Configure wake-up sources for a CPU.
+- Configure power domain reactions (LPM mode and retention mask) for a CPU.
+- The CPU IDs can be found in the CPU section of the SoC DEVICE: SM Device
+  Interface. They can also be found in the SoC RM. See the CPU Mode Control
+  (CMC) list in General Power Controller (GPC) section.
+
+CPU settings are not aggregated and setting their state is normally exclusive
+to one client.
+
+Commands:
+_________
+
+PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x82
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++---------------+--------------------------------------------------------------+
+|Name           |Description                                                   |
++---------------+--------------------------------------------------------------+
+|int32 status   | See ARM SCMI Specification for status code definitions.      |
++---------------+--------------------------------------------------------------+
+|uint32 version | For this revision of the specification, this value must be   |
+|               | 0x10000.                                                     |
++---------------+--------------------------------------------------------------+
+
+PROTOCOL_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x1
+protocol_id: 0x82
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      | See ARM SCMI Specification for status code definitions.   |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Protocol attributes:                                       |
+|                  |Bits[31:16] Reserved, must be zero.                        |
+|                  |Bits[15:0] Number of CPUs                                  |
++------------------+-----------------------------------------------------------+
+
+PROTOCOL_MESSAGE_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x2
+protocol_id: 0x82
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: in case the message is implemented and available  |
+|                  |to use.                                                    |
+|                  |NOT_FOUND: if the message identified by message_id is      |
+|                  |invalid or not implemented                                 |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Flags that are associated with a specific function in the  |
+|                  |protocol. For all functions in this protocol, this         |
+|                  |parameter has a value of 0                                 |
++------------------+-----------------------------------------------------------+
+
+CPU_ATTRIBUTES
+~~~~~~~~~~~~~~
+
+message_id: 0x4
+protocol_id: 0x82
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 cpuid      |Identifier for the CPU                                     |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if valid attributes are returned successfully.    |
+|                  |NOT_FOUND: if the cpuid is not valid.                      |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Bits[31:0] Reserved, must be zero                          |
++------------------+-----------------------------------------------------------+
+|char name[16]     |NULL terminated ASCII string with CPU name up to 16 bytes  |
++------------------+-----------------------------------------------------------+
+
+CPU_START
+~~~~~~~~~
+
+message_id: 0x4
+protocol_id: 0x82
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 cpuid      |Identifier for the CPU                                     |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the cpu is started successfully.               |
+|                  |NOT_FOUND: if cpuid is not valid.                          |
+|                  |DENIED: the calling agent is not allowed to start this CPU.|
++------------------+-----------------------------------------------------------+
+
+CPU_STOP
+~~~~~~~~
+
+message_id: 0x5
+protocol_id: 0x82
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 cpuid      |Identifier for the CPU                                     |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the cpu is started successfully.               |
+|                  |NOT_FOUND: if cpuid is not valid.                          |
+|                  |DENIED: the calling agent is not allowed to stop this CPU. |
++------------------+-----------------------------------------------------------+
+
+CPU_RESET_VECTOR_SET
+~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x6
+protocol_id: 0x82
+
++----------------------+-------------------------------------------------------+
+|Parameters                                                                    |
++----------------------+-------------------------------------------------------+
+|Name                  |Description                                            |
++----------------------+-------------------------------------------------------+
+|uint32 cpuid          |Identifier for the CPU                                 |
++----------------------+-------------------------------------------------------+
+|uint32 flags          |Reset vector flags:                                    |
+|                      |Bit[31] Resume flag.                                   |
+|                      |Set to 1 to update the reset vector used on resume.    |
+|                      |Bit[30] Boot flag.                                     |
+|                      |Set to 1 to update the reset vector used for boot.     |
+|                      |Bits[29:1] Reserved, must be zero.                     |
+|                      |Bit[0] Table flag.                                     |
+|                      |Set to 1 if vector is the vector table base address.   |
++----------------------+-------------------------------------------------------+
+|uint32 resetVectorLow |Lower vector:                                          |
+|                      |If bit[0] of flags is 0, the lower 32 bits of the      |
+|                      |physical address where the CPU should execute from on  |
+|                      |reset. If bit[0] of flags is 1, the lower 32 bits of   |
+|                      |the vector table base address                          |
++----------------------+-------------------------------------------------------+
+|uint32 resetVectorhigh|Upper vector:                                          |
+|                      |If bit[0] of flags is 0, the upper 32 bits of the      |
+|                      |physical address where the CPU should execute from on  |
+|                      |reset. If bit[0] of flags is 1, the upper 32 bits of   |
+|                      |the vector table base address                          |
++----------------------+-------------------------------------------------------+
+|Return values                                                                 |
++----------------------+-------------------------------------------------------+
+|Name                  |Description                                            |
++----------------------+-------------------------------------------------------+
+|int32 status          |SUCCESS: if the CPU reset vector is set successfully.  |
+|                      |NOT_FOUND: if cpuId does not point to a valid CPU.     |
+|                      |INVALID_PARAMETERS: the requested vector type is not   |
+|                      |supported by this CPU.                                 |
+|                      |DENIED: the calling agent is not allowed to set the    |
+|                      |reset vector of this CPU                               |
++----------------------+-------------------------------------------------------+
+
+CPU_SLEEP_MODE_SET
+~~~~~~~~~~~~~~~~~~
+message_id: 0x7
+protocol_id: 0x82
+
++----------------------+-------------------------------------------------------+
+|Parameters                                                                    |
++----------------------+-------------------------------------------------------+
+|Name                  |Description                                            |
++----------------------+-------------------------------------------------------+
+|uint32 cpuid          |Identifier for the CPU                                 |
++----------------------+-------------------------------------------------------+
+|uint32 flags          |Sleep mode flags:                                      |
+|                      |Bits[31:1] Reserved, must be zero.                     |
+|                      |Bit[0] IRQ mux:                                        |
+|                      |If set to 1 the wakeup mux source is the GIC, else if 0|
+|                      |then the GPC                                           |
++----------------------+-------------------------------------------------------+
+|uint32 sleepmode      |target sleep mode                                      |
++----------------------+-------------------------------------------------------+
+|Return values                                                                 |
++----------------------+-------------------------------------------------------+
+|Name                  |Description                                            |
++----------------------+-------------------------------------------------------+
+|int32 status          |SUCCESS: if the CPU sleep mode is set successfully.    |
+|                      |NOT_FOUND: if cpuId does not point to a valid CPU.     |
+|                      |INVALID_PARAMETERS: the sleepmode or flags is invalid. |
+|                      |DENIED: the calling agent is not allowed to configure  |
+|                      |the CPU                                                |
++----------------------+-------------------------------------------------------+
+
+CPU_INFO_GET
+~~~~~~~~~~~~
+message_id: 0xC
+protocol_id: 0x82
+
++----------------------+-------------------------------------------------------+
+|Parameters                                                                    |
++----------------------+-------------------------------------------------------+
+|Name                  |Description                                            |
++----------------------+-------------------------------------------------------+
+|uint32 cpuid          |Identifier for the CPU                                 |
++----------------------+-------------------------------------------------------+
+|Return values                                                                 |
++----------------------+-------------------------------------------------------+
+|Name                  |Description                                            |
++----------------------+-------------------------------------------------------+
+|int32 status          |SUCCESS: if valid attributes are returned successfully.|
+|                      |NOT_FOUND: if the cpuid is not valid.                  |
++----------------------+-------------------------------------------------------+
+|uint32 runmode        |Run mode for the CPU                                   |
++----------------------+-------------------------------------------------------+
+|uint32 sleepmode      |Sleep mode for the CPU                                 |
++----------------------+-------------------------------------------------------+
+|uint32 resetvectorlow |Reset vector low 32 bits for the CPU                   |
++----------------------+-------------------------------------------------------+
+|uint32 resetvecothigh |Reset vector high 32 bits for the CPU                  |
++----------------------+-------------------------------------------------------+
+
+NEGOTIATE_PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+message_id: 0x10
+protocol_id: 0x82
+
++--------------------+---------------------------------------------------------+
+|Parameters                                                                    |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|uint32 version      |The negotiated protocol version the agent intends to use |
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: if the negotiated protocol version is supported |
+|                    |by the platform. All commands, responses, and            |
+|                    |notifications post successful return of this command must|
+|                    |comply with the negotiated version.                      |
+|                    |NOT_SUPPORTED: if the protocol version is not supported. |
++--------------------+---------------------------------------------------------+
+
 SCMI_MISC: System Control and Management MISC Vendor Protocol
 ================================================================
 

-- 
2.37.1


