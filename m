Return-Path: <linux-kernel+bounces-442762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C0A9EE13B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E918E280D51
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C2620E6FF;
	Thu, 12 Dec 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lM6jTjgU"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D586120E6E2;
	Thu, 12 Dec 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991921; cv=fail; b=syWepb80ZtO6SCp2TPirWduSjEpDIej1PPuG0Bs28RIqF+Oye93NBJK17XdVtZ1nhrdEpwLQSBuGcvhLSrAatH2eeQX1oSK+pbumT7tWnWH8FBDPiXQDJ8Mhr4oSicUqyzUXgkDmEcSlcuI9fWT7h0/AoDuTLpPgfO18wLZAFvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991921; c=relaxed/simple;
	bh=TyGpyZTm37NXXz84SrttT6osI57F50HtEIRR9STVsZA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qpBYx8SITXkprsx2hAODA0GPJ8Djkea1TLihSVG2MU2PDlEozj5Npy0HvLS8vGUxiw0GrnQKzo/DD4DMAz3K6/W6wx3dqh5z0ihXpd6AQ0BSYoCGspjep92RSQY5pCgT6U6S7SeCYI9Ktpqp5+92Qyf1lpzMsy+YI7qZXUtSoiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lM6jTjgU; arc=fail smtp.client-ip=40.107.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ+pqdOWTzwD20YEzsQyAZmhn1bsrwjeTTZXqQLXPblesduHXSWRdZLBa649eGpTka88Bky0EIzVa5HwJNl1NFolafKSbMCGJiEF/Ut2fX+9Her563VySPSZA8wsF5ePKwZQl9xbsO2rVHcg0gA1Z9batryVqYMSLt8zrXLCPNqT7RKW+uQzk3qDSsLaRcNwtNSN6IPG1Wo076+JmHgy3OC1RfVD9FDxpjl/bpehwha2kizMwi3z2B8glsB8zEWTqn5/DF5xSDq62xFfmIfOIlggXhvYtpQKITWHHQnMaBkMQrVBkPfcQN2rjWNBvl0u7D0rQwRQNgKRl5jKBwCwJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/GwGoEswcMwP6dImfpCh/5bROjzZhO2GB4Bj2W/jlo=;
 b=meTteteMdj5+hzNOtNC3KA7B3TZ6fFPROUgarcR6/3I4rjXmyAmlCOpQxidyoWpScFAsfZYHtpFep2N/bDveW7ys/b0F7/s3O9QAhnrxIJ3AQIl7svX5xJ6ZEjpi9C1jvyX3ehwSJj4dF0ieC4g5GXjJvP4qPv2M1FkjcsUWgzBuPM2MujxukaukE7dbO0e9nXwPiiUvjm3XFAwLCibEF2xm6Q2qk6/E+SPLdfVXi6ioSgGxd/twpetvQ2oGLWHBUSJdILQfmtpCcfK+kbTvpIjFDYRMYTJKdnZ3qIiCGaqHyLrfMvRzjVMTk8eOP38I1DO6vYhORWlV+X+MLzismg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/GwGoEswcMwP6dImfpCh/5bROjzZhO2GB4Bj2W/jlo=;
 b=lM6jTjgU0oz8H9xkynsFrsaG2tCH+iKI9u5r5wzAla8+OUXDtu923GWVDuYNTkIlqV6vFmbkoV6iNM8K2COtlyc0cpRj8zCplLri7g5cKd5Z5csIutyRbmEIFBpe97dfcHf7u/TizolYJmhlOgNS4pSM/owr6vf2i/rKt1woXS2X13ipXvSkeHp6AjPXCIv5BHjxCCVFocdgyFcgalT/MvQ55VF6m5Pyygsmf1PBCXBuRGVAPpA4X34nfQ1d7Q2tMDF4VBIIk9pvemd6G4TbnyrszaZtbEqaUec/BSLusTgJj+7RCCv8KYB3jWtGO363MSTK+DFrW9OMPPgGs0QRmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7323.eurprd04.prod.outlook.com (2603:10a6:102:88::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 08:25:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 08:25:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 12 Dec 2024 16:24:42 +0800
Subject: [PATCH 2/2] nvmem: imx-ocotp-ele: Support accessing controller for
 i.MX9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-imx-ocotp-v1-2-198bb0af86a0@nxp.com>
References: <20241212-imx-ocotp-v1-0-198bb0af86a0@nxp.com>
In-Reply-To: <20241212-imx-ocotp-v1-0-198bb0af86a0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733991891; l=9171;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=VGXYDR2iua2/vwS9AThGTtVqrYdCN7AqMGAxlsDi9cU=;
 b=CsG0WjWARWk592cZJjm36SheQz5QUOMXSOIlZ2v/0BMSfBqGJ5maR0G6vRpygPO8Y6AKFUzWE
 2GXHFUFFbW8CaItf0ucA3xxiC8GMJESpDqlbIuJYSc7ytvbCqG9+CPX
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a7a820-8829-4131-8b30-08dd1a8681c1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0JYNEFtN05OTWhuSVlhQ3RRcktWMXM5Wnc4eUhWVis1WjNGcU10Njh3bXhj?=
 =?utf-8?B?UXYyQ29DekorYjcvbzAxUjBrUGcrWm9CN3M5SmlVb0NwU2RqSE8rbTMyR3ln?=
 =?utf-8?B?OVVEeDhBZWowS1FVSHVaKzZIak9ySWRjM0RqYW5VditMVlRUUFd5ckVFQmxK?=
 =?utf-8?B?TjAzSDlGSkVoTGg3SnhkTUZUT29sT0NpUGZ0azFOYmJBazNLblBzeHJxY1Qv?=
 =?utf-8?B?VkN2NGJKSllJc1FTVDlUT3k0Nll3THFGcTI3VjIrOXBXK1NqT2xhcjJEQWhU?=
 =?utf-8?B?TDdhS3hLc3F0NFBRQStRRmZkVk1MR2dQMWRGOUJmczlLL3JsVHRxL1ArcDE0?=
 =?utf-8?B?ZG1BRzR5YytWWFhmUXQ0SEQ3Z2diekVWeXVrbHRlSEdZYjF5WVkrRlRGZlc3?=
 =?utf-8?B?bUJ2YmlDRGxDbGhhdUxydWlJbENrZ0ViUytlUzBnRmRndk9aREVGM21hQ2RX?=
 =?utf-8?B?UHdJNUJmbGRZUkoreUNqNjFYM09OUEh2UmdTVFdTNlR3ZzI4TE9LTEFCRzFX?=
 =?utf-8?B?QlU5MmM3dnpFRjRFMDRxMHdHY2tlTGdwY1dnOHlUWmtmVjdwa0J6Z1QzOTdk?=
 =?utf-8?B?M1MyL3VteEhxdHhmT1BhLyt3RWJDZGxwSXYveUxWVVRmQmdFSGFzNG5vNXVZ?=
 =?utf-8?B?TEx2Uml6dGNhMGt1Y01PaEVmWkJNZUROSGE4YnR0TDd1VFFVZ0JRTFYzTnVJ?=
 =?utf-8?B?QmJDbDNSL3oyK2dkNzIzWDVOSkdnYzFOSWV5WkQ3aHlvYVFoaEpWT01CMWZD?=
 =?utf-8?B?eGxqSzJXTVJjR3ZzN1AzK2cvSnhsaFhmYjk1WVhkZjR5Q1FNUEJ0ZE9iUnJl?=
 =?utf-8?B?TFk1WUM5cjFvWmFCak91MVhZeStURXBlQUl3MHU0WHhOd0dQeko3L2JWUlFC?=
 =?utf-8?B?RDgraXp5R1laYXAyRmVPL1JzQVJIcG9XYXZtMEFnL2hjMTZlaGhjaHhHWk9n?=
 =?utf-8?B?a2cyUVN4aUdZaTZnZmxkZnJZQTNEVDY2emlCb0xId0ZVVlBvYVpER1QzNlVj?=
 =?utf-8?B?ZlpvR2FoYktTT2xqY1BwTVdRTUJsWFhhQzFKbmxhajA1L1oyNXRQUVJxZExT?=
 =?utf-8?B?bG5keEtwdFpRd2JGTjVvNjBERnJMZGZyRkpMWjFTMTNnWkNYL3Rndk1PWHJZ?=
 =?utf-8?B?Vlk4TDVESVVrK0lpcEl1TlV6QnpXY3ZjdTYvTi9hVlFodXJwTTVHbEU3Q1VJ?=
 =?utf-8?B?ME42NEVIQk8yOHFxbml3Z3ZqdmJpMHREZ0drRkZnZFVxU0JULzZvdlhMZUZw?=
 =?utf-8?B?U21SWTJkaW13YUViWFpIQkFMaW5QTDVLRmhaUlhhQ3JaM3RtRXRFZ05RVEww?=
 =?utf-8?B?ekRxTlZQR1ptVXpvLzNob1lyZjV0MmJlTkc1clM5cWFLbkpyNWt5UVFKUHZv?=
 =?utf-8?B?Y1ozUzZMSFJYUVBOS09wODNYSk5FZFJFZ1d6NTNFZktaOWEzZHllMHR3dlFq?=
 =?utf-8?B?a1dMbjRrMDBOWFZDa0J3WW9XeG9RSi95MVRnTXY0cDR1RWg1azVFQkZLNGxv?=
 =?utf-8?B?UkovZGlhcmtQMjVBT2JjUVBOYlhPRUpmaXhhcHl4RFpYc3Z3NWNPUjFvaU1B?=
 =?utf-8?B?K3BCeGxNUEJKMTdocTlZbGVPQUdHd3A0ZFNuY0JHZVlNV3BxQjhueHoxcFYv?=
 =?utf-8?B?ZDBSZzVjVDJpVGRMc0tQelZNU29ON2JuMmM4cjdmbmRBZDQ3U0F2M3lFK1dW?=
 =?utf-8?B?RDNocmdtL3V6OCszcFUxTmwxN0VvdXRBc09DN2xmN0dqeHo0N1gxUDN2SW5S?=
 =?utf-8?B?SWsvVnBGM2plV0gwMjJYbHQ1R29RNmJiamI5OFNtTnhmRlcwalNQdm5rMVFn?=
 =?utf-8?B?Zml3aWlVcFBOSk5hUGwxQ09Wc1diM3NEUGpDR2dFZ2kvK1JOaCs4V2xVZ1da?=
 =?utf-8?B?R0tlRGNhNWVqbkk5WjBXTWxIR2lXNnZWRG41UlI4Qlk2ZXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVFxc1JSNEpnQXlKOWpmdFJOZjZvdFMzZW96UVgxNWFvNFlOazcrcjNnZFdt?=
 =?utf-8?B?RXpoV3Jkck5ZZkg5a1hGVHEvTjVGNnhlVHd4WjVSRmVvRGMxaHloQkRLQkJL?=
 =?utf-8?B?am1QKzgxdlhHcmM0azlxOXg3ZDM2Q2JkMHFVM3Y0N0NIaExjRTNvWGpwU015?=
 =?utf-8?B?S2k1dW1GZ20rV2ZvY25mVXN2c1gxeVZGVE5VNisrUXpoU3FldFVadzN3Qk5F?=
 =?utf-8?B?WjZDTHNUSU56WTNKTms2TS8zNGYzOURMYW1sMDNIVklZRnA5bHNPQU9KRkpX?=
 =?utf-8?B?WHVYSmg4d3p0UWNvaWpwVXFPbTh1UEVpVnJmbm1MUC9HRisycFZUdTh1NFUx?=
 =?utf-8?B?NitPYW9mUVlkMFVLdDNUamY5VTY3aW1qSVlmM2VhN2dMR2gwemdBWWoyVjR2?=
 =?utf-8?B?cGY1NWMrQ1Qxc2Q5TUFYVFVPWUc5VVY2bVRSQkNHS293K0hKZlRnZEJPMzYz?=
 =?utf-8?B?SGtIR0d1eG5td0gva1JCNkZXaFc3UTJyL0t3OUVQbkh2aFlmWUUvNCtiQTNy?=
 =?utf-8?B?YTh6elNNVTZSNXhoWk1mY2VqdktLRmRocjVuSnF1WnpGT0oyNVZvYVV0MkZ3?=
 =?utf-8?B?K2dwbnAyMHJLWk1jRVE5ZnFzbW1rd3g0d1VRZ2lLVHAzdVh2MzRhYXBOWDVS?=
 =?utf-8?B?aVNMNXcwTFlJK2h0dkRhRU9wRkJwNGt4T05RQlQvUEZyNGxVc0V1WExqaUZM?=
 =?utf-8?B?MDV3Mk5oUVFsWXh1WVNzK2tWN1R6L291Q3R3OFJMUFJIbFN4TncwbkNVc3N5?=
 =?utf-8?B?STJWZ3kvNTRWbUZRc2xVTVVmakl5YzN0YUhLblNQTlArZHFVMEZtLyt1VzZV?=
 =?utf-8?B?dUZRclZuN0RrUThBZk5vS2tIQ2NmdE1POXVqZUpSajFEM1d3aGlEdVMzaEk4?=
 =?utf-8?B?V0Jic3lvd0xObzdWU0ZZd25lVWcySTZNTDJiL0JxWUZDaW12MVJYYzhnMlBD?=
 =?utf-8?B?SnBlaXl4b2o5RTRXNWVKeHlmenhZZi9NdVdObXNiampmZUxrMXo1aVpVamhZ?=
 =?utf-8?B?TkhMZnl6ZDFTY0J1TDZEY3VEYnRxenA4ek5yZFVtcUR2SElpN1kweklnSGkz?=
 =?utf-8?B?SllxSkxWL1BCaFVVZWEvbHlTMTM1ck9Wd2NiNlUzdUhuTnR2eGdWeVh1OHBV?=
 =?utf-8?B?NGdLTFd0TDdZOE1oVHU1YjJ5NnBkMmRYUlNuVi9ibUF4QnhvUDRwcjVHYk1C?=
 =?utf-8?B?MkwydGhvT1ZQZXhtR283NktMd3hEZmwrVTFoWitocHBTVVRqd1hsc2kvL2Fq?=
 =?utf-8?B?alFlNkkrOVhlL25ZejBXZE9nVFAxQllFbEpEenZ3M2NBTWNWQ2o5U2UwQWFq?=
 =?utf-8?B?TjF1cnJEeWNPdkNVMHpCWXkyZUJ1YXpwWTFZMG5vUEsyVDU5YVRrTEg1cW9L?=
 =?utf-8?B?LzJ5Lzd1bVVDaFg0eklZZjcwNm9oYzRCL1RFWitMKzZuek9Nc0hvRHdHVncw?=
 =?utf-8?B?aGJjNzhUOXZteG5mVHc2dWtFNlc4MnFhMkNhc3FZTm53Q25lcjBVMVlJYWVR?=
 =?utf-8?B?d0FFWUFuajFKSlBIOEV6MjI1QUNRVElZY210OUk2OG15OUJXUWVqN2huU0xv?=
 =?utf-8?B?cjdFajdNUE5qQmtXVnordFAvT3ByQlU0NHBqdmdsSXlSSEljeUQxUTRDQlZF?=
 =?utf-8?B?TStzbnk2K25kWWZQeXdxWGJYL1hrT0xWYkJmZkUxdnhOMWkwK1pISmRYb0VQ?=
 =?utf-8?B?dDNqaTBZSXFtdlhSN3g1N1FOejE3QklBNkxiNVo5dHFVMTJzWml6d3lzOGN5?=
 =?utf-8?B?eXhNcFJ0TWJ0bGovcnI3OVM2VC9oeUFKdmduYnpzM1ZUbVpHc3l4dmx2eEJl?=
 =?utf-8?B?Sm1mQndpdEpBTHVYZVVJYnBvZ3lsMWFVQkdTVzIzSlpUTXYvWDZBUUlCeER6?=
 =?utf-8?B?K2cyWENCdWtha1FlMGJZMlFScVI1WjlMVFprTkRycHF6VG9xK01qSk1sWnZN?=
 =?utf-8?B?YkxlSUx4SDh2eHdoRlJ3aDc2aXgxUE5vcElmaVNnREEzM29meWxoTEsvZWoy?=
 =?utf-8?B?R2JUQzRQM0JwTk5PTXd3amxGZmxHZzhMbjYrS3lKQ3NhNzNrRzJGdnoyOG5N?=
 =?utf-8?B?MHgwWUUzZmZNVzZ3WjdNSkdCbEhVNnIvQmQzL1NkQXNyNFdxMUk2WGhtWGw2?=
 =?utf-8?Q?ye47szB5i1VX+mewXuiDZ/Axu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a7a820-8829-4131-8b30-08dd1a8681c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 08:25:16.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMQgxAaK/BnUEtTx8bUtR2HyODgjdNjEQ7e1pBNwa+hgIsMPp5dJ5d1RqMmiLjVgnT1eCmBpxOvDW1ge9lFAUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7323

From: Peng Fan <peng.fan@nxp.com>

i.MX9 OCOTP supports a specific peripheral or function being fused
which means disabled, so
 - Introduce ocotp_access_gates to be container of efuse gate info
 - Iterate each node under '/soc' to check accessing permission. If not
   allowed to be accessed, detach the node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvmem/imx-ocotp-ele.c | 187 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index ca6dd71d8a2e29888c6e556aaea116c1a967cb5f..542539b86efd2d38be2903c1d0ea72f918ff5b75 100644
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
 
@@ -131,6 +149,100 @@ static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
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
+	struct device_node *soc __free(device_node) = of_find_node_by_path("/soc");
+	const struct ocotp_access_gates *access_gates = priv->data->access_gates;
+	void __iomem *reg = priv->base + priv->data->reg_off;
+	u32 off;
+	int i;
+
+	if (!priv->data->access_gates)
+		return 0;
+
+	if (!soc)
+		soc = of_find_node_by_path("/soc@0");
+
+	/* This should never happen */
+	WARN_ON(!soc);
+
+	for (i = 0; i < access_gates->num_words; i++) {
+		off = access_gates->words[i] << 2;
+		priv->value[i] = readl(reg + off);
+		dev_dbg(&pdev->dev, "word:%d 0x%08x\n", access_gates->words[i], priv->value[i]);
+	}
+
+	return imx_ele_ocotp_grant_access(pdev, soc);
+}
+
 static int imx_ele_ocotp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -161,14 +273,43 @@ static int imx_ele_ocotp_probe(struct platform_device *pdev)
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
@@ -183,7 +324,51 @@ static const struct ocotp_devtype_data imx93_ocotp_data = {
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


