Return-Path: <linux-kernel+bounces-242593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C7928A3C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3641C23C46
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD8915F3EA;
	Fri,  5 Jul 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F/6gGYdT"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D5C15ADBB;
	Fri,  5 Jul 2024 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187761; cv=fail; b=S6ExyYdgi4OQg2vk3RfLCaVTvD6X6PJcwqKDRmonRN76piglnCMjBghTJvQJaIC1z73ivjvVShduAJ54k+h86gq6IaHwBudFHIrZwoKxNLzHytKAK2FIiQRgBUJPIqa9akzffbfmIYLIk8jvw7AhIK1FL8EQxhJIx9ChQ8kSTL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187761; c=relaxed/simple;
	bh=EVN1PD0DbRAt3m/2onpulg4TwDsl7xnd9tG+Foo0WsI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=c657RTcDgkFXgfdRwil8BS3GnoSkxMCbv8v7k2FLk+Yper+uERS8PHgrdTHEzG0jHsW9ql5aftFW51aMszVunLexP0hLXU+PBaVdgX6dtV5nq0S2kxheshd5Jy7CNBH752dtNEgj9XTnkB8F9aOEOBe5ZLIn+XOM2FABTlx0hFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=F/6gGYdT; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCpzhRTT1Mv647nB5QENcQ2DAqlAzWTbnZIzpFge1Dn42db9cG/7SPjFAsEDutUQB3SOz+SHYKiMNxKCF2Q291ODmZoHsZtc+0uPDQEodO4BznGU+OyrQFxivoU7CnNJSyPuBpPoFfDv2D2XDKP3yTTBhDlYLfoOXrHvBoy4JwqhHt+TKO9D70ozs8yEfYwAAsgvG0b+aFgZLt3iuK2hxRLFsds3dKZ1hwZcdOyddCYfWNcnGieJWvWLOKmo6VDBlc1pk+FfEvZ6yqNNALfQ8eRxo/Syz8OGY2qIbkanUUkVTl/OEKwXjGKTZf0Qu7t8hKJMRriT9hicb4vu4bcTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKRGDFXYh1nK9oVqCxNJGhTBJh0QvgS6gXTXFthBCD8=;
 b=RbmzgWpDB17fd+PwR842yqDHCYbOElM2E73b/AlGuvzn08YTMyHnuCZGrg7PWhDPctxm04uc2QYbe6TGeDLGjsIBFaiZRrmtF0F553JgHB5Wf+yG6O+GWq5JXZ1NlZXM4KMK9oMDxLLcaAzuhFNcsNoDHMDE4MI1WruWdzgUHSM9Syfp+4+4F6w3T3WCtrk5PuDrIMURJ6OYJ89I450PybTj4mUpNxW/fJ+gjbke3rAn2dyPg006x1xlNHy6/yxcUwCtCdRjlfEbT5hKEQoFztsYBcEpCda4IRo+P2DG+RHvwWSwcQxpQabfSRQhvas1kuESL+WHFbtAlSKjn5pkKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKRGDFXYh1nK9oVqCxNJGhTBJh0QvgS6gXTXFthBCD8=;
 b=F/6gGYdT0nI3a83d7jooSzcD/wK8thAl0pz+BoaUWQkFzPeUoABsyNd0HAlb5ynZF6eK0xh5OOXMgMVKqi9fNgs0q/Puo0oK5yfvpaTGe/Fx+Fb69Fh5/CmLapXZ7/QrQXpmJqllIa0Q6bX4DwNMaiFHILgrpI++hoMCL+ECx8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB9260.eurprd04.prod.outlook.com (2603:10a6:10:370::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 13:55:53 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7741.030; Fri, 5 Jul 2024
 13:55:52 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v4 0/5] Changes in v4:
Date: Fri, 05 Jul 2024 19:22:39 +0530
Message-Id: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKf6h2YC/1XOSwrDIBSF4a0Ex7Vc37Gj7qN0IGoaB3mgRVJC9
 l4TCrHDc/H7cUXJx+ATujUrij6HFKaxDH5pkO3N+PI4uLIRBcpBgMJhWHAq1w4bDiAEaOasROX
 9HH0XlqP1eJbdh/Se4udIZ7JffxUCVSUTDJgqK4xUXBPp7uMyX+00oL2RaeUoqx0trqDOkVYbw
 fS/Y6eTpP51ZsUZ5WjrvBGWm9Nt2/YFrOiBghABAAA=
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720187574; l=13891;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=EVN1PD0DbRAt3m/2onpulg4TwDsl7xnd9tG+Foo0WsI=;
 b=6QGfmmsDI8S4PqDqE0j4ldnY9sYupJQnIfTYH7YTTnR/1Xk+kcwb6DvkeFiviky769n9NnBUh
 fNRgWOTm5KZAPzim1jGOWViNL2HxMK9GFUdOkreWBzCcoUUJenvPX4I
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB9PR04MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 427175a3-6489-4733-cb5b-08dc9cfa2f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXlrUUNrWGNTbXdMaHZrbkY3Nk42UGpRaFp6enM1cTljTlMyUHpMZjVlbEhn?=
 =?utf-8?B?bkk3N200bTliT21idlVsS1R2dXphbzNvNUxSeVo4RmxlbUQ2TlkwZFRCeHND?=
 =?utf-8?B?ekJmUjlpOVJ1bUZPMmIzQzhWc0hPdjEvRG41eTYxTXBSeExUVTBTaGtObmdL?=
 =?utf-8?B?S1pMSlRDN1BBVWxncG5aUnREWXJ0Mks2aE9pbThhTG9xbHNrRThqVTJIcnVD?=
 =?utf-8?B?eVF2SXNnRFZDOGJyZk0vOHRpV3oxVmdBZnRIc1dQaUF6c2l5VG1wY0cvSU01?=
 =?utf-8?B?bnMxMmNaQWIrOHU2M3p6SG53WHpzQ0VZVlpxbmdoaE8rSmZjL3VreFFFS3Zt?=
 =?utf-8?B?U2dyaDNIRHF6WFlXNzVjbW5ONGkwV0FHT21lWmRhckpWVkIyMzRyeHZMSzJp?=
 =?utf-8?B?V0wwOWlZdjFIaEJ1aGxKajVDbEREQXlMUVBGYmduMHFLVERjbVQzbk1TOGlm?=
 =?utf-8?B?SGc4czNKZnREblNrK2pRSFVRMSsxVDVNY1RqaVpMZm1BTWUrZ3BkNGNNTTZN?=
 =?utf-8?B?VHExVlgyN1RHOWlpcGlRU3krcU5oU21sVSt6bEdKZSs3UnVRYjZpVHpyWDQr?=
 =?utf-8?B?VjZNS1BmSERveXVveDNTUVFjaExlbnlob0lsVU9vSlg2L3RlQVAySFFtZzlz?=
 =?utf-8?B?aDJVeC9ucU5MZnk3SnQ3ZTdCVGVVbGk2SktkMk5WbjBUdU5zazZlaHQ0aHZ1?=
 =?utf-8?B?RVBMb0R4elo5NUxqaWQwMU5ERHBWSVlUZ3loV3dPQjJuSDB6Z1pNdjQ0ZzNk?=
 =?utf-8?B?a0V5Q0JoR1Q0R0dzaDBEZEhkTUl0a1p1S3AyeUZyMXBBZDZUOEcvVGF1L2ho?=
 =?utf-8?B?dmlvdTBra2ErakRIdzB4emdMMlg4N3ZJMlI3MjNIK29KdzYvTXVVakR3L0Qr?=
 =?utf-8?B?WDFxazJKMTQ2azJmdFpMeTdaWEpoOWY1c1ZPb040RUlkMkZuajJNU09SUlgy?=
 =?utf-8?B?S1NTLzM0K2tvcHdVQlpLWmZBOE02emVXN0VDWUlyVHB1dVVUSXYrU3pvTmJl?=
 =?utf-8?B?bWpPK3JFRGZzMm1aTE1YbHpVWktiQXY4MUFNdmJscll3b1UxU0lHaEZJMTlU?=
 =?utf-8?B?SDBUOEJoMHNjZmFmOTZPMFhoeWF4cWpKdFVhRjF5eXFrTmU2TTk2VE9PZ3J4?=
 =?utf-8?B?UnBzbmhtaWFWSVJTbTZUNWhJa3hpZnRqK212UXJGTjU2SndDc09Ebnl4ZDRw?=
 =?utf-8?B?RjBXckJ4ZzJMbXNUSkNKQ0FnTWdZQ3BzQ1VBdmxvWXhLaTZuQlpCV2VtTkJs?=
 =?utf-8?B?UEh4MXRxNUsvMWRwS0dkancxSjZ3RXY2VVB3ckdKZzBhNWJsRHFwalhLZmRI?=
 =?utf-8?B?R25TRWFsNlA3U3R4ZG8wL2RLYnR1ck5HeFhTb1VVdkJ0TEpyQXhZRUp4NUtw?=
 =?utf-8?B?U3QrNjhvNHJaY095NXVWMjVHQTd1Yll5YVF1cEtGSUdkdngyK0gzdXdrcEpM?=
 =?utf-8?B?TzJVTm1NRlZQTlNHUllLVEZkOHM4VDA3Y0pDaExwdW8wblc0TlVLQ2U1VGNF?=
 =?utf-8?B?aWhXemVXR1VZbVRLM1NCQ0hhbU5VL0xac0t6dlF0S1FWNm1aTS9uUDBYMDJH?=
 =?utf-8?B?VSs2ODBEMWFDc041Wi9LbjMvYm12Yk9zZXFva2ZldDFCVklmSDZBK1JqRFV5?=
 =?utf-8?B?TC9JYU5iVUMyWExHWDNuWk5wVUJjSU10ZzhQcSsvbnB0dTVNU1JpcXFqYmRQ?=
 =?utf-8?B?L25Qb2VHdmF2c0Y1aFpRQk5TMEFFc01EUlNaZ1JKb2M0dXZNZVRJVERwL01E?=
 =?utf-8?B?emJlcTRqbTV6L2Iva0hQNFBMNUxrVit5Q3pwQm4rbnZra3FndUIvbkpUMC8z?=
 =?utf-8?B?WHh3d2VrQ1hkZnA0RHpyT1A1RjBXeEIwa3B1VjZ5TzFrTDQ3S1J0TWFzc0J2?=
 =?utf-8?Q?5wPJMcAL0WQho?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjJ3REtVN0ZtN1Jzd3NMUVFoM2MvRlRZMGtJM0gvTGJYYUd4Y3ZraXlYeGFN?=
 =?utf-8?B?V3NOUWh0SE9Fb0FDZDNoUWNaUHY3aVZNUVFJUUk4b29RN2d5dFpLZmFqK1pm?=
 =?utf-8?B?QVBobm83OXJYS3phc2xyODFLS0crbTIzTkJ3bEJEMUNnN0NNL1J1d2VhejF6?=
 =?utf-8?B?b2J0djl3S09ZV2pLa09MbFVrZXRNZmFWTjIwdUhCK3VIeGFJWXpnTFNCNUlZ?=
 =?utf-8?B?TzkvSTFROFZ3QmpZYW9yQUgweFgyYXVCNUJxZzM1NE53ZG9FNldRSGVvd1Rh?=
 =?utf-8?B?N1hlcnMzaDc1Q2RMTlZZbzlIcEk4NlloM09KZ0IwZkEyZUJldDkyVVgvWmZ1?=
 =?utf-8?B?Ly9UcytNNlhLNUR0TXNJcGFSTm9WUXJXNmlGMWtGZmtDM05qam5xeGdxTC9a?=
 =?utf-8?B?eVpXTm5KaWgwV0pxbWw0bXJJQ1BqdHIyZ0hzYUxjaDNVQjV1YThlUVVBNFl4?=
 =?utf-8?B?QklhOC9IbW5ZSnpzeWZqamF6NmxrcFJiMjlVSWdTVnZEbytsanBCNWxRVGkw?=
 =?utf-8?B?Vk9rS1FGMlZIVXUzNitRUnVuMGFDUzZHOVdIeEdLNThCd1ByL1Z0d1VCbTRH?=
 =?utf-8?B?UHRhL0ljK0E4bmxadzhnOVc2TDNOTG1QRjFVZk10cXphNm8vaHB6MXpqc3lw?=
 =?utf-8?B?MTVlZ2h6d3ZlRU0xU3N5UUp1c0tnMEVlRWRhS1ZhNTZPY295OTU4cTRaNzZT?=
 =?utf-8?B?eGYzSWhaanNpbC81djZlMjVseXQwRzhqcEtES3VJV0hPUWxwWC83cDYzWjZ1?=
 =?utf-8?B?TThkL3ZrbEx0L1J2ejJXUytSKzlqZjlQWG9DT1M4MUUrS2ZQU1pLc3ErZ3BB?=
 =?utf-8?B?SzVBNW1LVjA2Vm92RHlENEJmTTNLUk1FeUw4U01FeGRPUW1LaEloaktnZ3Vy?=
 =?utf-8?B?OG1BNVFYWE1hcGh3UXBFZ2NlRWFhYnc3ajhYaENrUXoxUXV0Qmd0V0E0QnpY?=
 =?utf-8?B?Qy9rYTZObk5MaVliN1dYcFFnd0RNNFoxUnFNS1M3RVRlNWRPM0hZRFZyL3Zy?=
 =?utf-8?B?NGgrVHVvd0xKVVNGQ0JLUDFYdFJIVEdpbmxqRTlFTlZUcmEwOWRtOGc2cGRF?=
 =?utf-8?B?aEZPMFRiMzFOZjhmOUc2bDZMS3hUdWZHRklpTTBzQzU3ZFYxL1Q5ZzdySkpH?=
 =?utf-8?B?WG1WZ0xXK2RJM1hvYTVFMDdWdGRJWnhuZjB3OWlSSDNBeGpQa3I4VGRMdEhH?=
 =?utf-8?B?elRYekRhbENtM2hGODFQZEkwZEZyOHVqMlRtRGJRYzVqK1FoNUh0anprVlhu?=
 =?utf-8?B?T2ZBRFpIelc1c094QjM5dU9aM2ttRGJCeWVGT2l3YlVjZXRpT3h1c2J1WEtG?=
 =?utf-8?B?VmxVUE9BN2k1YnhQSm5HMzV0d0JvelJFSmFXbTVjRGhTaXhmZnE1cEN5QjZx?=
 =?utf-8?B?czMwYU1MdjJibVlpR3Qzc1FqWU5YZFVLR2FhWXRGWXRORWZCWmwzalF3SmV4?=
 =?utf-8?B?Y0JobVFOOG1hRjdRZjVUZXFYaHRPbm4wKzNWbTFrU1FsYjNDczA2SENndFNq?=
 =?utf-8?B?SzhuVzhwOE1may91WExNQXR5Sk1mZFc0V21yMzZiR0JiYWhrMFRHa3prNEhi?=
 =?utf-8?B?eENNN1l0WitRenJvNnNVZXpRa1ZjbUlVc0hVZ1pkN24rUVpybFp5czRzN2la?=
 =?utf-8?B?TUszV2JnZGk0dkVFdHp1RlQwUVlmL0RCOXVEeThQTnZFb3dEeFQwc3loS2Fi?=
 =?utf-8?B?dUZhN1N0akJoeHRXalNranpldW1hM0xNdDk5V1RjNDU3Zi9YVXVlSkZxei9U?=
 =?utf-8?B?MndPRUJUS2tzTktGaFY2NFJCdCs2QVhEc0ZoZGxycWg3SnRuT1JRRmtOckJE?=
 =?utf-8?B?azBybFBvN3RIbG1oSGpnNCs3YjVLcnZuZ1J6YVhaemMvUk5DSFpSZVkzUmJN?=
 =?utf-8?B?VWhSeDZvc1hxc0pRWUkvdWpDY1M0UXdnZDRtOVpBOUhWN1MvOWZZSTRZK3R4?=
 =?utf-8?B?am9mSmorZ2tBKzIzRHNTQzlRdk5xMzN3ZVAyeFhoY2lIb0t3Mzltb2ROQXhv?=
 =?utf-8?B?eHJnYWFBaHNKTUhnQ2hja1k0akY3ZnU3cWpBZURqbmZSaXlRK0lzYmJxTmRT?=
 =?utf-8?B?N0ExYjlvdC9WZzQwcDVCaDF0RDNyZnNzaHZsdG5keVhGYlF2NXZWU24xQlNu?=
 =?utf-8?Q?FASV8BdNQwsSHO6+4SRbehkby?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427175a3-6489-4733-cb5b-08dc9cfa2f33
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:55:52.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGJaqitcvynx6OrRWkxE4ppn7V4KLmNIn9JFYVY9z9xjVdpPIEYbh9fV/rl2escDWJKHqnhpjLvAwdcXlEbz+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9260

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

- Link to v3: https://lore.kernel.org/r/20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com

Communication Interface to NXP secure-enclave HW IP like Edgelock Enclave

Hardware interface of the NXP Secure Enclave  HW IP(s) like EdgeLock Enclave,
V2X, SHE etc, is based on the Messaging Unit module that enables processing
elements like ARMv8 core, RISC V core, within the SoC to communicate and
coordinate by passing messages (e.g., data, status and control) through 
these interfaces.

The NXP i.MX secure enclaves hardware interface kernel driver, is specifically
targeted for use between application core and NXP secure-enclave(s) HW. It allows
to send/receive messages to/from the secure-enclave.

Patch-set adds the kernel driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock Enclave,
both from:
- User-Space Applications via character driver.
- Kernel-space, used by kernel management layers like DM-Crypt.

To: Jonathan Corbet <corbet@lwn.net>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>

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
- Link to v2: https://lore.kernel.org/r/20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com

---
Pankaj Gupta (5):
      Documentation/firmware: add imx/se to other_interfaces
      dt-bindings: arm: fsl: add imx-se-fw binding doc
      arm64: dts: imx8ulp-evk: add nxp secure enclave firmware
      firmware: imx: add driver for NXP EdgeLock Enclave
      firmware: imx: adds miscdev

 Documentation/ABI/testing/se-cdev                  |   43 +
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   |  133 +++
 .../driver-api/firmware/other_interfaces.rst       |  121 ++
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts      |   17 +-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |   14 +-
 drivers/firmware/imx/Kconfig                       |   12 +
 drivers/firmware/imx/Makefile                      |    2 +
 drivers/firmware/imx/ele_base_msg.c                |  251 ++++
 drivers/firmware/imx/ele_base_msg.h                |   93 ++
 drivers/firmware/imx/ele_common.c                  |  450 ++++++++
 drivers/firmware/imx/ele_common.h                  |   48 +
 drivers/firmware/imx/se_ctrl.c                     | 1197 ++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h                     |  132 +++
 include/linux/firmware/imx/se_api.h                |   14 +
 include/uapi/linux/se_ioctl.h                      |   94 ++
 15 files changed, 2618 insertions(+), 3 deletions(-)
---
base-commit: b63ff26648537a5600cf79bd62f916792c53e015
change-id: 20240507-imx-se-if-a40055093dc6

Best regards,
-- 
Pankaj Gupta <pankaj.gupta@nxp.com>


