Return-Path: <linux-kernel+bounces-312513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BAF969797
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6EE52839D6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431A419F41F;
	Tue,  3 Sep 2024 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="S7d/0kUS"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021086.outbound.protection.outlook.com [52.101.65.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0319F413
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352951; cv=fail; b=skoGRtaDQHfGhk9tGuWHg6FdDk67cvrAFEpvRJVwatg1RddLWLU6dXQsHCVWHCVnK5W1p60KDt023AYdKlVoTn7N54Aqb66o4E6LF3JLjmwwS4YA8+kbawa8QreDvSdx/TfmNT1AmmksdEHF9wVJaU/ep/6dOX3x9URpr3DmwJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352951; c=relaxed/simple;
	bh=fxe6oTCN6MEvjLBQdhkqeRawsNDqe6eEuwylD/9GSB0=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=PsYmaKXlvzQMN7VnWaeZalJBYHA9eIEYroRTAPTKB/Hjmq9TgVRaChjFWGof6S83i3ueWpmpLXy2qminYo+bIJln75DeENTStP6AYLxxp9l2W/A3ZUSvaVAROU4xTkZbP14EZOjCeAUhtFaNKzz8OoNLQM1qb4+G6An7+zPJ6dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=S7d/0kUS; arc=fail smtp.client-ip=52.101.65.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjSvxhSV1iG8Br8RcQdQrHNDhiPSeplwVKWwEsOx+Xl/lUPgmnL+Lm48r/qeXpGcytQlngVRU9/pEJYrJVqBcSqmup1AooddrwAtcrUzRKEmuiSRmCEU88/FF0cg17vGTA1G1nUngdbnyCBUO0mWP9I6QH5j9aF/Xo0hNQg5OFYNiyoYnlTOs9Z04XgpXS3IPl3bDOs61uwej/cxphY4TejBns3dxb1anU2DFnDjK/yPBtq8fV/IECpCBJxZeEjP3cBQE4rCOhKqadnmEjI8G705TGAs0MYB/SGb2jXf9mmdhFuXk9IOe4rXb5jyeVHxhVJ8LPu15nZ1xtb4htleyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGY+Z/fwqXfPlvTjOWRA139gBrn+2QMrMxqImcidDXo=;
 b=SVE7zYAFE/qmUiGTsOjKvnCAG0wO966n03p6h/WNlBoVRDzdhXlYGA1naXITPcSO5udD0cGAPBDHZD+CinPZSYMUTyiFUuO6uUDTUXZJVwiKQiN69VY8Aog1xP2aHNe7LhdxHxEdAeBZYsfEF28rLQA7o4hLqT8vKX/D+l9yXdljHGI1LuQox9mrplBWOdWcMTFr0Z6sZE1jDa7M7yyXF3WUJnJY4lv7MQlDLZAb+f1EF2vAWpz7TwQSikqU5Vxx2PqSVbpR5MZ4ZPDDoRMBi1OCvPs+uwrrJBet6mDbZVpBt6oGpt+6arNP0pSXfhkNWPjT+ZOsj8qPIOm4hflU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGY+Z/fwqXfPlvTjOWRA139gBrn+2QMrMxqImcidDXo=;
 b=S7d/0kUSGLdTzMIqDvMhG0nOMoHIUlskgK2cf4YiB/l+H3sIL7KPn0hsr3mx3bvDkMbhaMsfbA+cP38KUoKZRlsqRNJRICpK7bteCDcsg/SX9LTkOT8R0SS0FHb/NgIJ7umgxgJXiBleqeXp76bIbHmTNLqfDhHBBJ7Fz/0v0y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI0PR04MB10734.eurprd04.prod.outlook.com (2603:10a6:800:25e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 08:42:24 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:42:24 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 03 Sep 2024 11:41:54 +0300
Subject: [PATCH v2] phy: mvebu-cp110-utmi: support swapping d+/d- lanes by
 dts property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-mvebu-utmi-phy-v2-1-7f49c131fad0@solid-run.com>
X-B4-Tracking: v=1; b=H4sIANHL1mYC/3XMQQ6CMBCF4auQWTsGShFw5T0Mi9IOMolQ0kIjI
 b27lb3L/yXvO8CTY/Jwzw5wFNiznVOISwZ6VPOLkE1qELmQeZ1LnAL1G27rxLiMOzZSqbIfyra
 qDaTT4mjgzwk+u9Qj+9W6/fRD8Vv/UqHAAltT6oZIyRtVD2/fbNBt81XbCboY4xeq/YWgsAAAA
 A==
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|VI0PR04MB10734:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9d3689-96e3-4766-ae8f-08dccbf45537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1B1VUdMcUZFWnYyeDJONGRLc2h3dHNrc2hqb0F1LzJUZkhvUWgwWUNiSWlq?=
 =?utf-8?B?Q3F5THFETHpuTWZZSnJXRVBPNDBiVHlUWk0yZmFhajBncHBEQkVadkExU2lq?=
 =?utf-8?B?MEU3NGxBbDMrd3M4M0E2dUdkL29qUXFBOW9FcHRrdkJ1cXB3MllUeUpXQUxr?=
 =?utf-8?B?MGxNNXc2VXlsR1NXdGNNcmpLS2pxaHdDVml0UFlYTGh1YzFZVjIvTlJyR1I0?=
 =?utf-8?B?YWdsMFF5OVA3WE5neVlzZ2Zia1RKT2lTWVJoMWtkMHNnRjliZ093MGgyb3Bk?=
 =?utf-8?B?S3Q4QU85dmFRdmJUWStoTmZsMW1Ua2p5K0JFVHR4alVnUUZPZS9oNGRvZkR5?=
 =?utf-8?B?WG5BWUdTM0pzOThOOTVNbjl6bVROQ0l0ZGluTms4QnJKK3BPd2Z1M3Budm14?=
 =?utf-8?B?U1ovNWtvTVFWK1dBcXZBZ1lKR0pLUUZxNlR5eFlKT3IxL3gvYkdiZWUzb0Q1?=
 =?utf-8?B?Q1pBM0Z4VEQrdTlndklPa0xhcXREYzlwMm9IZjlkVWIzNnhQVmdDK3Q5NEYw?=
 =?utf-8?B?MGNuaGdlOW1KUU0yVUdtcHNXa1haZ09SR0lRQmFBci9mck9XeElDVUlLOGhx?=
 =?utf-8?B?N0NIQ3EvSFBnbUVsTkZEYnF5L0Jpd2lKTm11a29CZTU1NVd6Ty9uZmd3WDQ3?=
 =?utf-8?B?Ri95SDFTTFVBdnhyM3FqZk1kTmJQNGZsMGl0Z3ptQm1EajF1bFRqNHAwdEVs?=
 =?utf-8?B?TjdheWNTQ2hwU3VoTmRLRncxbDhoYnlTQUhmS0JsSEViLzNobFZvTzRGMFRH?=
 =?utf-8?B?WUY5bFo3TVZMRGQ0WEJEZ0poelNDbkJhNnpTbVl2Z0JoSjkrVkxrelp4MDBZ?=
 =?utf-8?B?Wk5BZ1Z4aVd0ZVJGWVFFS2dTSGhSbHh6ZGdEc0cvZDN6dHNhTDZkWEUzY3RI?=
 =?utf-8?B?QmZEWUd6bHZYc1d6aTNqL2ErT1FvSENUZUVueG44cWZUbkNsUTJYblFVN2dp?=
 =?utf-8?B?azREYjQxYjhVeHNuc0RSZ0F3a1BVTzBDRzB4TjdaYXFTYWk3NXgwRWxPbDJM?=
 =?utf-8?B?VmdDQ2U3SzF1TU54eEIva25jR3BwejY4cVpBZGQxOG5RZndLd3NWM3M5aUZm?=
 =?utf-8?B?TkxjZVdPaSthd2ZhTldSTmZpaHBEQ05rbGQ5TkZId29IaUlUUUxrRkdZQXIw?=
 =?utf-8?B?QnE0ZTdEeDhsMVZmdHZmTjNCYXIrVFpWSE15eW1qT2tOOVU0cmhjeWEzMUFR?=
 =?utf-8?B?VXhmU0RmeWR0QUVVVVA0bXB1cVM4RmNTNFBlaHg4bi9XUkVPK3lOWFczL3Iz?=
 =?utf-8?B?RFlhNXFXUmFXMXB5ZUhTZjk0U2piNi9uUEZIWEZLaHdyaXhrNHJlSW52SXYv?=
 =?utf-8?B?ZXB3aWx1Q1c3SzNYbDJRRGFDL3JkcC80Um9EYXlVTUxrd1RXOHVVbmZiZ0oy?=
 =?utf-8?B?R2tFMHdKSS9aNUpnL0ZIL2RHS041eXo0TzhMVm9TREJZeGpRa1VBVkdyZDFX?=
 =?utf-8?B?b2tyM01CK3I5cTRzY2p1R0hIS2drV1lKbVNYUm1LaVJIMnAxTm1YR0xUc3ZP?=
 =?utf-8?B?TjR4amlzWkx6VnBybis4V213QlEvS1VYdTM0RzAvUWJ0VnByMW9MNURXeWVK?=
 =?utf-8?B?Z1VBUGUvUWhpSGVySGphQ2ZBc091NjNWWWVtWmlJV0syYXFlbTk0YnN5eDVB?=
 =?utf-8?B?K29GSHJvRE1jdnY4cW9QdkJ1a0t3MDJzdWI4R2pMTjFQUnVDMlZ5WmZneFFm?=
 =?utf-8?B?ZVNnV214Qnl0K2ducVBRQmtId05xeFByc0V0NkxnYSswS0EzZmJZSHFCMXNJ?=
 =?utf-8?B?UVhySE5sd29XUFd1SmY2NDM5bEppbENub3A1MmpBd0sxMTVpNGtvZmVCemZ1?=
 =?utf-8?B?eTJVYWV4cm0za0dxVEJqekY3ay9CMXVOdUdqTnJiWTBkRVZZMEpzY0ZrY3Fk?=
 =?utf-8?B?Rnk1ZXBmS013S2Nac0xoTVdzL1FUOElKZG11L1FST3ZpR0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eC9WSFAzRi9rcXFTTDVIZWE1c3FITFVkMXZVNjV6cndOaDE5ZGRCUXdRM0JM?=
 =?utf-8?B?MU9FQ0dvSnE0Ujd5T0R2V1dna1hBbnFtQzE0czhlL2tpcVl5bklOT1R3NFdR?=
 =?utf-8?B?Vlhsc0d6YlgxbXhKYVRZK0drZG9zMjJ6QkUyVnhVMDNpRERhakNqSjJBVWxP?=
 =?utf-8?B?dFVVLzYyY05URVU2K3NPNUxuMmtnelVMMzN2SEFWZkRzMXFYWi9jZlY1Tk45?=
 =?utf-8?B?SWNDbXgvTUpBYmxnOVdPeXN1eUpqUkF1T0w4V2trNCsvT0xOSmxnaWtCSDBm?=
 =?utf-8?B?RTY3NDJqQlk3SWFTZFc0UjRhVkRONnFxdWg4clFlV2ovNnhSSTN3WEpaNm1v?=
 =?utf-8?B?dDkxYUR3aVZTWVAxSnpjQnBqUWxIU0VEWUlGVThQcEtIa0t2cWcrSC84SUZl?=
 =?utf-8?B?RW1rNHF4Nndxd08xY2NJQXc5TXZHL1NBS1FlcXZsTFYyS29XRDdpbURpZnIy?=
 =?utf-8?B?Z0FzSUg3bkxxeXJYbE1PNEF2WXhnWEJvazRDOTlkVEZ5blZ3NHRUV2NhOWg2?=
 =?utf-8?B?RlVrOHRPdHpZaU5TVUUrTkVMYXc0aVZFSk5NcnlQZEM0ZitCWG4yWWFzTlFX?=
 =?utf-8?B?RlcrS0ZqV1NkenhkbmlCd1dHV3J1WVdTRG9KdUlZeXI0ZUlXdU5FYUxxZlA2?=
 =?utf-8?B?aWlBaUliZ1l3aUR4R0RVNmZLS0EreGo4b1MvTmtaU3FnWlZpaVFpL2IyWUZt?=
 =?utf-8?B?ak5MYnVPMkhXN0h1dzVsRCtiR1JhQ1FYdXc3OU9lbU5FTlFEMUwydlJQam15?=
 =?utf-8?B?dFhreUhWNE8yeUc3aFRmRzdTTjNzZXNHNjh2KzRlZGRpSG82LzNBd2dEVUNm?=
 =?utf-8?B?ZEkxRzViWVFRZVdObjZ6OFE0bEl4Mll1ZjJyd0lWNFh1TzRNRy9qNUx2bG1x?=
 =?utf-8?B?UzZSdFZhQW9rSFl2V0wrMlNZUXZLT0RWUTd0cWNSZGpTenBVN3JYTHN0NjRh?=
 =?utf-8?B?Uy9HbU5MU1NRUUR3dDVjaHZ4d3ZwYTVWVFNabmlScFgxb0s5Q1dhL0dodkxK?=
 =?utf-8?B?elZORTlzczhzbHVpUStJejNDbXVWMHlmSng2SzVXU0duV2ZTUXV6QXR5UDJl?=
 =?utf-8?B?MWxPT0ZCTnhndVlpK3VpQUR3MmdDV2R1RlpsMnFvcjV0VzJ0WHRzK0J2MVV0?=
 =?utf-8?B?Mk9CcDRqRVdwNVdOWjR2QUh2OWhyNzMwYUgydktrN21zN2NOTGdSRzZFSFZn?=
 =?utf-8?B?ZXV0K2tDU2VQOWNpOTBmNDRPRkNqNjg1aW8rNDkrQ3V1cEdmQkNJNjF1V3dJ?=
 =?utf-8?B?K3FMOGNrZ2RDSGo1S1VIcFpmYjhNOEhSRUxVRFMxUlFldEMyMFFFMzVST0N6?=
 =?utf-8?B?dEQwNk8rcFpVVzFIeWRseFNjcXJGWWhMSXU1czJBdnFQckR1bU1Ec1lxa1Ir?=
 =?utf-8?B?N3dKOHQreXpaMVp6QUg1TmRJY1JVdk14N29ERTVTbERTY24xcU5nalV0UUpB?=
 =?utf-8?B?SDM0MlBPQ2pGOVFMbHB6WG1JYjFWNWVYZUd5cEtKdGlxelJkMEpvUDFBbHRY?=
 =?utf-8?B?SGNia0E2NHFVVDRacDQ3ejBPNmUzRWZyb0d1bzVvMDRKajFQNVVkV2R1eG5o?=
 =?utf-8?B?NlRhL00xVUNZaS9zQkhZODlEekhRS2tlSjdEbDBKZll5SU5JMEx0YWUrQTVG?=
 =?utf-8?B?K2duTnVLNVNUSXVEbjloNEk4dldybEpNcExLQi9QOTdOaXdmQWRZRlo5MWJw?=
 =?utf-8?B?b2xUS3Vwb1d6Si9jY3BINis5eDdPRDQvVnU2cm8xa2pSZlFTSlM5V3VURW8v?=
 =?utf-8?B?cDlVUjJGeXFRbXdHbDFLcloxUHlFWENDU0dVYTNTSVhCRjJRa0dGcWpRbGNi?=
 =?utf-8?B?OG02RVpEcFRGZzNnc09WUnBhMm9FZENhakE1bit5N1J3YUxSNWVsWm5xNXV3?=
 =?utf-8?B?TE54RDJVeGdVYmJZMFpnT3lwM1VleWpvWjZuRDFpOVhSbkJaSkJhTDR5MGtG?=
 =?utf-8?B?YmZJSnM4WU1uRmcwVWczYVl5MXFYV2wybGpETVJBRlk2N2FvalZPVHIyVHJU?=
 =?utf-8?B?dXJiK2Jkd0dTZlNiYUhaZnF6RzBNUHRZSEJJTnZnZThIOVlxai9hb2p5M0lQ?=
 =?utf-8?B?V24rU1hPWThER1cvTHVSbzZ5cVk5R3RSTityNnV2K053Y0MxYklvUUVUSk44?=
 =?utf-8?Q?ewdL2ifIKGbbVs1KiJR5d5p00?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9d3689-96e3-4766-ae8f-08dccbf45537
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:42:24.4177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EdmNkLyXi9KPUxNGQuIoPSqz/WvC2n+vvZ26+0vg5dVxycQyGGnV5YXM0+Jp2r/gQdun9qBOJtvhVFxlpVsLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10734

CP11x UTMI PHY supports swapping D+/D- signals via digital control
register 1.

Add support for the "swap-dx-lanes" device-tree property, which lists
the port-ids that should swap D+ and D-.
The property is evaluated in probe and applied before power-on
during mvebu_cp110_utmi_port_setup.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v2:
- fixed compile error introduced with v6.11-rc1:
  parameters of of_property_for_each_u32 were changed from 5 to 3.
  (Reported-by: Vinod Koul <vkoul@kernel.org>)
- rebased on v6.11-rc1
- Link to v1: https://lore.kernel.org/r/20240704-mvebu-utmi-phy-v1-1-9d3c8eea46e5@solid-run.com
---
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
index 4922a5f3327d..12d619d9cf97 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
@@ -62,6 +62,8 @@
 #define   SQ_AMP_CAL_MASK			GENMASK(2, 0)
 #define   SQ_AMP_CAL_VAL			1
 #define   SQ_AMP_CAL_EN				BIT(3)
+#define UTMI_DIG_CTRL1_REG			0x20
+#define   SWAP_DPDM				BIT(15)
 #define UTMI_CTRL_STATUS0_REG			0x24
 #define   SUSPENDM				BIT(22)
 #define   TEST_SEL				BIT(25)
@@ -104,6 +106,7 @@ struct mvebu_cp110_utmi_port {
 	struct mvebu_cp110_utmi *priv;
 	u32 id;
 	enum usb_dr_mode dr_mode;
+	bool swap_dx;
 };
 
 static void mvebu_cp110_utmi_port_setup(struct mvebu_cp110_utmi_port *port)
@@ -159,6 +162,13 @@ static void mvebu_cp110_utmi_port_setup(struct mvebu_cp110_utmi_port *port)
 	reg &= ~(VDAT_MASK | VSRC_MASK);
 	reg |= (VDAT_VAL << VDAT_OFFSET) | (VSRC_VAL << VSRC_OFFSET);
 	writel(reg, PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
+
+	/* Swap D+/D- */
+	reg = readl(PORT_REGS(port) + UTMI_DIG_CTRL1_REG);
+	reg &= ~(SWAP_DPDM);
+	if (port->swap_dx)
+		reg |= SWAP_DPDM;
+	writel(reg, PORT_REGS(port) + UTMI_DIG_CTRL1_REG);
 }
 
 static int mvebu_cp110_utmi_phy_power_off(struct phy *phy)
@@ -286,6 +296,7 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
 	struct phy_provider *provider;
 	struct device_node *child;
 	u32 usb_devices = 0;
+	u32 swap_dx = 0;
 
 	utmi = devm_kzalloc(dev, sizeof(*utmi), GFP_KERNEL);
 	if (!utmi)
@@ -345,6 +356,10 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
 			}
 		}
 
+		of_property_for_each_u32(dev->of_node, "swap-dx-lanes", swap_dx)
+			if (swap_dx == port_id)
+				port->swap_dx = 1;
+
 		/* Retrieve PHY capabilities */
 		utmi->ops = &mvebu_cp110_utmi_phy_ops;
 

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240704-mvebu-utmi-phy-84aa3bf3957d

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


