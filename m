Return-Path: <linux-kernel+bounces-399345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A6A9BFDBE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945DB28448F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1D6194123;
	Thu,  7 Nov 2024 05:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lTAOHMml"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292D0192D6C;
	Thu,  7 Nov 2024 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958173; cv=fail; b=QWKZJYH7CxmvU+LMFX0Vug+xsySpHqPXdau313/03Q6c9V97VEd43pOCVRrG4OqapUxTJIsHtNiwidzFLpglBgH56ngy0QvJjSgfDKJMtHNpK4koCy0/Sc5VTvtEfUAx6gHMMRFzSyqEDo2rTc20zDu7p47jQWlOJTPYUAdg7Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958173; c=relaxed/simple;
	bh=34FF491ZJSDO129ZCMtrnaGbCyv6wFF+EMeynPpwbFY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IjD9PXeJytNuF2nRAYZ1JK8KB9RQ0Mj0lz7goVhCW5Rs+z2QJwyArQQmwR5Il6PCoozog64uqYjYztfjGSeFT85ek2as038miTnDZAGlUlVBVjqVcZusGX7gVDDo1uB1QKiBliqD9E5nVIKjCC8ij31TIIMuxf01i/eU5Y++gOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lTAOHMml; arc=fail smtp.client-ip=40.107.247.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCMQirRTfbRsEzeb7GiP9ileXxmsjMzOWJSVDGli0YApL2p9FYNpPY2FCmonQBUfbR+SxwUbWlr+8HyYgx3eDUaMY3lp+FAOTLRp1mF8RF7sYF/THKScdBlJZxOl9qF9Eh8quL2UysESLmDR+v6OI/NIxLOQqjaekfVOnNAD/aOQkuBAWY6oi+rfXgymU5ke9Sg53rhR1qeKirCizmROifG8hAkgqByk+6QhtX9kCY+GT5Yy3ejyHbpBuvb+dXlxLsAvnnzoahFBLYmtUMH7etELJS+Avsyr0zWr0ynBQLfZpK0rlp8kIRMI6UhZCdLDOeJMZx7h4WItEDSBsl5WBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbLAgjXjhD46oGKQLWhlHSclrDOmmgRZNY+dScF3B/M=;
 b=hO9UNwFkVQYzRTqzIq2AzE0pZmaRhQDvUsySGmJmyAPQyfZ7XQaRLCharqhfTAttqHFdGaVT9fYD0J0fEdQVKNmv0/qyOOcLsUPlwezch2YmrQhXJzd9yiKUVv4zi8ufSw59BUb3Hj7+uKkW9UesSNojK7uh2WAQbWudDOReQCi/O/qK6chhIUXSJ4dgRWF6zrWA71OVyPrud6ebsUvoQ5srqfI/ZqEb7n8HMW32n2D/A6la5vJX5Gq0aubbsYi3zVLO37pXQu9FEy1W2TLrb+1CzvTGsVf5MfAzOsqBoSvhdgkgdayl8eQhEzMJDZ01WU+AxYYyNqLHPH1Eahl8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbLAgjXjhD46oGKQLWhlHSclrDOmmgRZNY+dScF3B/M=;
 b=lTAOHMml4QuHTb2wMBxhUm2sn4tHPnkP8NFoFQWF31sap3+3egJ3H7AYF/uDbFNJc0AuNJejTljiZzO89032CFNvZgoDqSIQ1Qfw1lJL58uUWRbyf4z6Tp+Ew73wnQ5UPKi5m137Mzf/cwEBnBySWVRGDvkaM3OHt76M19MHy9j0l8T3Yy1zq4RDthxpLCysoGk9jTj+vLdFZru2CxAwgpu364GPvnsx/hbL4GmR5kgPlKuxxicAmT/GlaYw/ZerRhKM3XXOtpGZCRTPC97I2uTuS4ByTtS08xq0oM6hAQpHBPyjWmHY5SXCTy5bhDirxVtzldVrudZl8/pw2Jxqfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com (2603:10a6:10:36c::10)
 by AS8PR04MB8434.eurprd04.prod.outlook.com (2603:10a6:20b:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 05:42:47 +0000
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab]) by DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab%4]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 05:42:47 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
Date: Thu, 07 Nov 2024 06:42:40 +0100
Subject: [PATCH v3 2/4] arm64: dts: imx8qxp: add node for nvmem property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-secvio-v3-2-ea27f1e9ced4@nxp.com>
References: <20241107-secvio-v3-0-ea27f1e9ced4@nxp.com>
In-Reply-To: <20241107-secvio-v3-0-ea27f1e9ced4@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, frank.li@nxp.com, 
 pankaj.gupta@nxp.com, daniel.baluta@nxp.com, silvano.dininno@nxp.com, 
 V.Sethi@nxp.com, meenakshi.aggarwal@nxp.com, 
 Vabhav Sharma <vabhav.sharma@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: AS4P192CA0010.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::17) To DB9PR04MB9354.eurprd04.prod.outlook.com
 (2603:10a6:10:36c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9354:EE_|AS8PR04MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 983bc40b-8116-4fad-fb7c-08dcfeef0246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amlhL3pNQythS1krcWNOUExYQkF0NUFUbGRqMlNnZy92MGwwMUR3WkRSZWx6?=
 =?utf-8?B?UE1HN2JSNzFxWHdFL3FiTHJJazdObWhWRDVzMkt6UFBkTGU0VXdnalZSTUwy?=
 =?utf-8?B?YXBOWkFRZmtGcE9YblpUd0NjVW1NUnRoQ0cvTmN0ZjNZT0pucG9UVTFVbkI2?=
 =?utf-8?B?bEhnKzdjMGUxaG85emdyMDVENnFSVThnbTBXTzE3dnpIVTNlRHJrbkVDTHlF?=
 =?utf-8?B?OEhFRnNXTldSZm5OaFJxT2RzeUJhaXQ3VHUrZEdwSkhoL05YZzlVNWswaFVa?=
 =?utf-8?B?d2hjS0NvNnZjTER1S3FIM2sxRkphclMydjQ0VHRDMGxCNUZCSDc5YWVKUS9o?=
 =?utf-8?B?djJDcE1haTFUeUtNR0VRQ3BCd1lEamFpVFBIVDl1SU1sVzVyanRsNjdJNnNX?=
 =?utf-8?B?UVZZNmVWL0NzSkxIUmlHSzhoelZvd29mdVcrYkI0L1BuS2d0S2NLVHBJb2dQ?=
 =?utf-8?B?NnlkMFRjRXkvendlUGRoTC9HaUhoR3BLeC9SQlRyT2VPRm5mcVUwOGZXNllq?=
 =?utf-8?B?akdveUt2L2Z5UnBwS0ROVi9Wa2lGby9rcDJ0ZVJjZGZLdFM0ODFteWxEY1lu?=
 =?utf-8?B?RWJSUzUyMjBWNHliOVRZcmtqVDNqaGRlWVUxUDdyTk9OVnZjR0cyV1JLVDRl?=
 =?utf-8?B?Q0NEVmpvTjdmc3RGUmxwZlhOVXp1SUx0OVdCWWdzT1BlclpyQVp2STdtMlJk?=
 =?utf-8?B?Snd2R0Z5Z2FOV3dwZVl2Z3REUUg4SEpBakFyOWIvVTJEMlVZREUvNVlvMXdE?=
 =?utf-8?B?cDlGR1lWekJhMlBYNG5NR0d6SWhHMk9zN1R5UzVsdU5oR2tRMTRiYlFaYWtI?=
 =?utf-8?B?UWI1RG81dVF1dWY0VGRRdHQ1anpJN3Q3Y1UrdldjbUdlcDBzemx5RjlIVHU2?=
 =?utf-8?B?MHVEVmZFTXMzWkwxSVhTcHBKcHBWbWFVcnJuVGcwKzZsVTk2VlpGeUF0d0Zl?=
 =?utf-8?B?Z2lmZnJrbW1lNEpXMVV6bjRkK3dmc0Y3OFp6cG44NlVUUlI3QXRVbjYxL3dy?=
 =?utf-8?B?RVpmWlU2SDVxU0tmTzRQaXdVYkxBYis5T0pYUSt5TEFyNHlMQnptVllmTjRN?=
 =?utf-8?B?YjNhK1lEcHc3alBDR3c0ZkZvWm1aaWFJYkg2Q29OaEdOc3N2MnhGTlJCRFZi?=
 =?utf-8?B?dXVSa3lYZ1dRQ2JVbkMxdGJ0NDF2MFJ3OWlXNi9uYjEvdE9hL2NZUS9obXg0?=
 =?utf-8?B?N0xoNktCTnAxUXg1NEFQcjVxQkxoenRlVWZSbHBuUUdmTCtidTVVY3Y0Nkpn?=
 =?utf-8?B?V2U1YTN6Zk4wdFNmeVR3M045NGlkRWp6dHNBYkF4K29EL21keUlnbGZBM21z?=
 =?utf-8?B?RDlZUFVzMWVXTndGdVA2ZUt6Zm1EQ251YTZpUWJWemE3Z1BnbW90bEhkNEpn?=
 =?utf-8?B?dk45bEV3dFo4UjFIMDFUZTdlZk5NNUhXbUpPMWx0T0FrVHg1b0trRTlZRXl1?=
 =?utf-8?B?aUozYnYrOXNCa0d0cUpWYmxvR1lCZ3dtUndzUGdRY2w1TEFjcFVSZTBmUEdE?=
 =?utf-8?B?dWpFejZBQUw3T1k5MDhMVnc4MmFtWFR4SnZIMW9qSkFuR1ZuRWpFd1VpeGxm?=
 =?utf-8?B?dmdCMXNlT1ZHR3dpWFdYelhxMXpybEdVeElxSmo5b2xWQWxEQ2hkTk5wb2pE?=
 =?utf-8?B?ZnJxL3ZmbU5vL08vbXV0bFlsaC92L1IyZ3BSYkdUeDhkdWgzaElnK09zVFhY?=
 =?utf-8?B?VFYvdVhNNjNrcXU4YS81UU1ZYmtDdmVRT2Q3dTd6NmorNWNRMGJDZHRXUE5w?=
 =?utf-8?B?ZW94STVxYzMrbGNYSEpnNktyaXJwNjk0bTJZWFgvZkpvRmtlcStDSnhKYnpI?=
 =?utf-8?Q?+GGQ+D0SkTjPFBBklycX9WOQeYbNr5jmW6XKo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9354.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk5nUDhSZkdNVjJ0c2w0T0cvbXczYUtrZHBsd3JHaGhZNEo4bG1INFBRS2FW?=
 =?utf-8?B?andlZ0w0RW1CaEtDRXUxT0JkTjczMUhGSloreEFyZzY5TFNZUDlEcU9pZzd2?=
 =?utf-8?B?NENxcW9MajJVb1JpRWdmOUZUTysrdEFwM3QrQkIyUjBIbUhtSUZBTHZZSGJz?=
 =?utf-8?B?eklxUFloYVlYRk5BSkU2cjZuMTIxZXhlbENIdHVmSWJ6eHJ0bjBiUFdpdkJZ?=
 =?utf-8?B?ZjBVcWc0RVp2OEExMTNRQ2JpOUd6bVNrN0htelljMXBUM3d0aTRmSXd3WlM1?=
 =?utf-8?B?NDNYYnowQm95ZSt3cndiblovL0d0U0JJYUlmeUc1Mll3Um5VdHpwS1BweUt3?=
 =?utf-8?B?aDB0Y04rNjd3TzFJN0w3ZTJqOVdNY2dzSXRva1RWdWovUERhMm5GbTJTQWJF?=
 =?utf-8?B?MGNEWDcvanljaVlaNkpadlo3UnhkMklEdi94cEZoU1h0L1pvQ2x3NE9LMnhl?=
 =?utf-8?B?bkxHOExudjJGVXdTcVFJdXJQQU83eEFVMzUzVENkUFJxYThiNzV0NE1uK1pi?=
 =?utf-8?B?cG9paE9XbzluVU5hcTFiQUFWVm9JNTFtTDMyUUlvdkJPSWgvbVkxaGRzait2?=
 =?utf-8?B?VFdQVm5yREQwR2g1bmlKTS9qTnVLRllDSmk3bEM0Y1lwZkI2QS9KdkFKUkM5?=
 =?utf-8?B?OWQ0aE9YOVo0TXU0S1dKOTZDU2VZQWdXaEZhSnFkTnVDN1JkSDVYbDk4M3lT?=
 =?utf-8?B?cjdaUXFpa0t6aTF6cGNTQjMvMmJlK1B0Rk5rcTZmUGJzTENsYVg5elpFL3cy?=
 =?utf-8?B?b2dGSUFmRW93dFJsSXhlQnhwUmpMSWI5QlpoMGdnZWNNS0J4OXBBTEQrL0hy?=
 =?utf-8?B?bDc5NEs0Z0VSdHdRdkpFbXVKek5uVnFvZTJ3TWtsSGxXTFlBNjZYYWtnRTBB?=
 =?utf-8?B?YjFHa05SYnJKYXpicFUwRHRzazZ2RGJubzFJVVJPQStzTDhtU3czMmJUNTM5?=
 =?utf-8?B?S1VsOXUvZmVFbkhDM2VlUng2ODlNNTRObThyMDgzUHRpTUdmRmZiWlowMTFa?=
 =?utf-8?B?STBKSllkcUNJUTZDVEkvTlFJaGtiUWUvaXNzQTJNT2p6THR0TzRBSjcwMFpP?=
 =?utf-8?B?RWdKZEV4ZDRKM2xhKzFmSVNWUDZWNmd6R2RuVTVyVFBzQndiSDg5OEhsN3B3?=
 =?utf-8?B?QW1qVzV6QkVLMnlRbXhXWE00em9MQWF3ajhCMXdYeHRodTBmQ2tkc1JJQjlu?=
 =?utf-8?B?b0JiZ2MzcVZrRDdjM0Y5aDVhNE8wWVJQRmtlUk5tQlJsRW8vbWFjVHZxMXUx?=
 =?utf-8?B?TWtTOFRiajU1V2RDN0RrWkVGSTU2WDFSdWloYVhvT3FKZkVITHdEeFFqUWtS?=
 =?utf-8?B?dTVkMm9XYUtBaCtLN0cya2JFNjk3S2lVL3dCcXA3SWJZL1N0NTk4UGprSkJP?=
 =?utf-8?B?bW9wSXQ2NU0vc3NVTWJDRFNaNGg4UkVuTWxsdVV6czdkbFlXSzZlemZQWDIx?=
 =?utf-8?B?VnZtcTRVUW1xaVo5VThESTlTZkN3b2FMZEJuc2ZYUjZyRFZ4TVdtOGNXcklK?=
 =?utf-8?B?WDgrR0trV3J6QVNzbE5lTEtEeEZwVlZGVXhoR0lrMGhUYU14UFR6b0gvRXNV?=
 =?utf-8?B?cTFQdG8rZEJkd2pHaDh0KzNRRVE2MEk3OUNYM0NBOUNIWXR0YUdwaHZDN3FI?=
 =?utf-8?B?U1NNR3kvOVA1UTR4SE11cVBGR1h5dU9icmhxUE85aVVWODdXc0tJdHRXelpn?=
 =?utf-8?B?ZmNWWHhZYzRVblBmMlhxV0tCTkZSV3JVTFM1T0l2bUZJZWt2cWh6SVk2WHh0?=
 =?utf-8?B?YnFyZndHaHg1d01oYXhweG00QzNvcWFiL3FUTEtKMUJ3bHhxZmdnT1puY2Vm?=
 =?utf-8?B?SHNSelV4R0k0cWRDSWRHVUIwenJLYTRhOHdXRVNVREsreFdjMklGVmxSTXJV?=
 =?utf-8?B?ZUVCazk0eHVHMVBGS2NxL3FtYUdYR25sTjJpNGRBR1MzbVRIaGxFQnpKUUxG?=
 =?utf-8?B?YzR0bEdqYTlDYjJmZTMrT3BJR2JLT1FwcGxyMWg0cW1FSVZoYlEwWGVFT1kx?=
 =?utf-8?B?czVVOWFySW83aGJhcXpwOW03eXhIV0ZBeFl3TWw4eFIveFR3TkNIQ2JHeGtq?=
 =?utf-8?B?eDZtL1NpUUw4VEtNWkU2Y0JsaFBmRXZLcm5Obmc1RHh5SmtpYW5MSUF6T0wx?=
 =?utf-8?Q?Y6I4ify7F2OkGFoM9i6lX8Rl2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983bc40b-8116-4fad-fb7c-08dcfeef0246
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 05:42:47.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrQ6BwpfVYggoXPW+kCyYYHGhAwIWsGMfeOYWpdujNOFywYmZP43UBxNWnxVpqsc2MYBDshs+PGabFiNTw+3pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8434

Add nvmem property to be used by secvio driver.

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 0313f295de2e..2b1dd0addb50 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -210,6 +210,7 @@ system-controller {
 		mboxes = <&lsio_mu1 0 0
 			  &lsio_mu1 1 0
 			  &lsio_mu1 3 3>;
+		nvmem = <&ocotp>;
 
 		pd: power-controller {
 			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";

-- 
2.25.1


