Return-Path: <linux-kernel+bounces-188480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC98CE285
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C800B21673
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DC41292F8;
	Fri, 24 May 2024 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ViVPT7O+"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2087.outbound.protection.outlook.com [40.107.247.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05FD22331;
	Fri, 24 May 2024 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540486; cv=fail; b=Ncpx93+wB8+RPYFZC3GcumscKChxyOvm2n3O9dOcId9Llcu9tfqrfvkIlWWiz7hwBWIKM7/blBIDklJVVtUiiuC3v70nBseYSL14zH4cQoyAz29L3m+Szfwg1kbh0Sa2SbD220VdOPyp7FRFYZ0+UBAcnvqJXpIzwlMSXF0YB4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540486; c=relaxed/simple;
	bh=WdPMawk0WqsjDoWa2iGTMrHzSKWq9MJ+fJ5Ir7nfqHA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=NWc9gD2+ZkJHkTvTXNFnlDo63oIOS4pDqTvAFYIWuFTiFKZgh1G7AEjXjlmci/HLiryFla2iVpUvclmenOAwzzmB86MqKESUco2hra7abd7APPaAKzLkyKZP3jyeM9ZWt+4KjlFqVsFIj6ZRqomeoAA9nRgGq2f9y0klUi1dODE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ViVPT7O+; arc=fail smtp.client-ip=40.107.247.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S22gtoTrVDy/z1Bj8UAeMY1ApneEfERGeLzbAB37uGGrKltzQzcPzitr3eoWwfPK+0EPNj32Z9LYDmV0gA7Vy8mtFlE+0wfQv6QfSp0xe07keUl6Y142Fma2z8ze3yMQiSosRAxkXkEL8j67wN00QfCx+YC0dqtx04EQErVn/Qqg5pMe0Em5tywE5TjELnKFP45De/GCITxWgrRo1znrXK/oHIzPtKMJe+U+tFX9GNwZQ2lDpuLwTU03xaAWvDLNjPCYd8fKWkYQNC4PlihI7LUE3W9IzgUSeup/YxkW5nBK1LNfIdL5Q7uOExUeEcDH+QAxhusqDfZ03PhRPTDkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VoHbCh8IRJzY/HWRP2W5CVoQtlzHhv0fVr7ZVuaxXI=;
 b=cg01WvXlIj9IgEiGppAmoBuC02P7RI6ITe/5AebrjinWhqEcmRooSMdmGEFRkPoTTH0GzIDPMaJDw1Zp8aqQTFCCWQPFV+CyVwR8aV19Ekm/VINPTl82R2JHklkAku+4n8sDkEwyc7kMZVY3iXtdyU2UmM1mLFq8xy/qhyFUp11UnrUJ/7a2RKy9uwltNrPYSUc6LwxVit9Y/C99N8abSy2JV6tBBsOM3HNsn8RpMIbur3+aXdkd48LxWmzRrd/wythiFkNbtU/vCb1CZT2tdaoDLr4xSuff4fKI6Em9M8k342jO/25EUipv1/Fd9AGQcAP4SHWFyiR+wAID9RJKeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VoHbCh8IRJzY/HWRP2W5CVoQtlzHhv0fVr7ZVuaxXI=;
 b=ViVPT7O+qdrWJ5v3cZjJ96xUeXniwRwyBEVTlA9H6undydr24TI/9Qr0vnBGA9A1ho/uJiKuDarRGi7gL6AM9RLHhj5uOfDAhwh2sb73P4CO4fMp2deZP5ecdy7NUzfSwCmCm56+wbiKP5ZnbtO4xpyTXpXT2P6pt2J4FJW6NQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9931.eurprd04.prod.outlook.com (2603:10a6:800:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Fri, 24 May
 2024 08:47:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 08:47:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v4 0/6] firmware: support i.MX95 SCMI BBM/MISC Extenstion
Date: Fri, 24 May 2024 16:56:42 +0800
Message-Id: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEpWUGYC/32NQQ6CMBBFr0Jmbc04tNi68h7GBZQisyiQ1jQYw
 t0tbHRhTGbzfvLeLBBdYBfhUiwQXOLI45BBHgqwfT08nOA2MxCSRIlKsJ+NEk3jhedoRSLRKGd
 aknVrJUH2puA6nvfm7Z655/gcw2t/kWhb/9XyoTCdNSddaVVZug7zdLSjh62Vyi//RL/8Mvuy1
 FhLPKPR+PHXdX0DO+y2OfAAAAA=
To: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541024; l=5483;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=WdPMawk0WqsjDoWa2iGTMrHzSKWq9MJ+fJ5Ir7nfqHA=;
 b=d1SpNPX8iLpGi0K7dbxBH9EOeQgU3j/Iy9coXIIhQsJTgsBXj1Virr5ndFWBs8/W1HJvQuhS+
 Sn93Q+jpf39AWtQOrC4vcLW8h/AbHwEXJaSW15ax+AjiYZ5CQT9neO0
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b67cfc6-f780-42bb-5aab-08dc7bce3516
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXRyME1PaGgyZ0VLdW9xQ01Ja0w2ZVdzTkVOUStGdEJ2SUxSNDVqUXRVV3dj?=
 =?utf-8?B?M24vUUwvOG5OK3VWWFUyaTcyb042WWFOSU42Rnpiamt0eE91ZHFNaWMvZzBZ?=
 =?utf-8?B?NHJWWTROMmlqbVZHcUhyWkh5QXk2V1VMOTRFcmFUZVF4VWU4NjFoamFGRFFG?=
 =?utf-8?B?eGZYa2NISXZ4blpYL2s1VktWVU5MLy9DMnlFaFoySlJwcDBManFNTE14K3dh?=
 =?utf-8?B?cHR4dktqUTJUWEgrdDJQTFdzeFc0Wm95S21PSHIrSndmUUhrNUpGRHhJcjZv?=
 =?utf-8?B?ZHVqT1lGOW1BdmFTOXo0QUNyL0lrTTR2V01QN1NkUWxkYkNFc0h1U0lNS3ln?=
 =?utf-8?B?L21UZXVWbS9yQ3phQlYxdzNvcEFHR2RRV0xZNWRFZCs1VVh1VDlJcGQ5WUdW?=
 =?utf-8?B?aUMvblJhT0owdUVwbWp4UCszM2xDRyt2aFhyVFNhYTh2dTBlWFVFRmUxQk1E?=
 =?utf-8?B?QWFnM3lseEd6SFAvNUdOWjdQVmU4RHo3RHAreUdYcFZHd2h3R2UxaHZHcllm?=
 =?utf-8?B?WC9DSnI2TTRtKy9VNVJ4WUpBbDhubTVMMk11azZlVzZWa055eVlpRVZ3WW56?=
 =?utf-8?B?Qlg3OHhScnhpQ2UwaURZYjdNaXlHZzNIeXlYNGp6YUl3Vi9GRHA5TFNCcDlP?=
 =?utf-8?B?MlV2ekpqYzRac29lZzdJZS9jMlVvUklZY0tCYVdlakhsSDY1aEUwWjNoYUVC?=
 =?utf-8?B?V2RZeGJ1Y0ltVlBPWFBid0tpZE43cDlSYXlLK2ozeCtwYmpRZDd6bUdneW9h?=
 =?utf-8?B?NkhlV1RLNDVEZVVjcys5ZkpZTEEweWpoZjlHUlp2b0pOV1BYZkIwVTJBa3Np?=
 =?utf-8?B?di84bkpPZjR3VFQxbnFxcmpoWSs3S3FBeTZEUjNMYnVac2drSWxBZ1BkRVU4?=
 =?utf-8?B?eU5leFIwZ0FnUWRNbGdURFJYVzgwcXhuRE02Q0tOTitvRGVjQksvR0ZrYml6?=
 =?utf-8?B?YnRyTDR2djBjMnFKNVIzTUdtZC9kdXEvcXR1V1JxaHRGTEh3cHhWYXlXbkhH?=
 =?utf-8?B?WkVOZThnYXZwRXUyYUdOMHdkU2xlRFEzOG1UcDQ2Rk84S2p2djBHRWZLQ2o0?=
 =?utf-8?B?eUtCdXRjWlI1Zk9JYUMwbm8xSjgvU0poMWVrNnVCbDByU3UyZmQ1YjVzTkxP?=
 =?utf-8?B?OE1DTDl1ZEcxWUpabHpqVXQ0Wlg3Qjdmd2VLRkZodFd1ZzFsRkpjd2NsWGRQ?=
 =?utf-8?B?VzYzMjNxYnVkcmJldG85aTk3OVYweS90ZlhWZFQ3ay9OUXIyM1k3eWg2Vk1q?=
 =?utf-8?B?dU0zQ1hUMDdBeWRDZ01pNjh2b2h2ejUxaUF0bVRpM2FwSkxRSGlIOVdpSzN3?=
 =?utf-8?B?NTRKaURjeHk5allkNG5JWDZIQlN5SXM2eG4rVTRpbnNDdUFnVjVuSytHazZn?=
 =?utf-8?B?QXo0Vm9zbnc4aHZCazdtZlVtb2lkcWRIMUpLeXNVVHQvbW0rNXNuVVFHanlh?=
 =?utf-8?B?UXFEeTJkS3NiSXQrQWVvTk4zMlJYOEpoN2YzaXRjM21mek92K2NmaHRoR2hH?=
 =?utf-8?B?THZKM3huVVF2UG4xTmpoNXRaRWFESVo2NmY0TVV5elJKTGlFRE1FTGxVMXpo?=
 =?utf-8?B?VFNnY2EzRTU2bHBSL0ZxRStlWW8wK0xYbnVjdHdiM3ZrWkQ3OG81am1WZWph?=
 =?utf-8?B?anFBQ3V6YzNIbHAwUmhLMEpqSHdaZGlkLytzR2c3V1NCREoxajQxeTJxcHVC?=
 =?utf-8?B?aTlFZ3dGU0pCWUxjdVEyOExRbnFrSlRaWE5KajNQRlZObGFxditFb2tjbHJp?=
 =?utf-8?Q?Zo40EeF9fnxbz1hMTUThjXtlZtcWG9nnI92uQU4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzdDN2plVUVuUmxZUmRvZXZQaDdoeVppZlRtVnIxdXErczhKbk5NQlRRMWdq?=
 =?utf-8?B?ejB6ckNZUnpEM2NqbSttckFFd0ZORXl6cC9uNUh5cXM4T0hMT0REZWRpbWVa?=
 =?utf-8?B?THRaQSthL0FUdzR5OUdmRGw4Sy9zRFRkczNSdnVwVXpzYUpIN1ZlTFhGcy9l?=
 =?utf-8?B?VjA1SWtWK3FVVjJFbHFCODF6R0dndFpYcmdkWUJSM3lkUXBWbkhXZGRtYytH?=
 =?utf-8?B?dTRLWk5aUUhPd3VoUEpPNU9hbHpvR0ZCOGVOMDdoQ1c2bFVwN0RRSTU1eW1D?=
 =?utf-8?B?NG9yWHdiSld6ekxlQ3MyNUZpa1JmTGpNcXNxR3RCajFyWjNqdFFOVDlmbXhh?=
 =?utf-8?B?eTZhL3lXbFlHKzhMaURKb3FWWCt5MlhDb3labWlZUjU5eERNdG9kM2RqaFFw?=
 =?utf-8?B?WkhIRFU1TVVmQkpqSkxNTkVtZENuYm9xTGxWT3NXbFREdEhSRnFabDVUaW9q?=
 =?utf-8?B?MStNcGV6aGJKNzd2ZnA4LzJiMVF3MCtiM1JuV05RUmdocHNDSVpYbWc1STh2?=
 =?utf-8?B?UVl6WEQ5WUFpUXZkeUxCVjF1cUVmT0M5akd0MTlxNG9PMThJb01ScUNIUlgw?=
 =?utf-8?B?ZjM4RDc4RlNoSjVhOUxJK2Z4NGswV093V1F3T25NV3cxVHVERlBycXdaNERP?=
 =?utf-8?B?alBKV0RTUmNqdURieWcvKzE5SnpXTXJOWW5YTkV4SHNDdU9aakNOSlU1UFRS?=
 =?utf-8?B?eDBnanI3MGp6RDZaWlRlT0E0TldjSVIyR0RkcHpvZXNYMW5nYUdBY0VKWS9Q?=
 =?utf-8?B?Y1lMRzQ0Y0tHa0xENExFdUdRMG1Cc0w2aDJ2OURaRE92NmdTRzQyTURKY1Rn?=
 =?utf-8?B?ajZHSHhIMnJTTDcwREt1Q3VHWGo1ZU1kVndLcmpYcXlFNFRjL2oyUVhrYkx0?=
 =?utf-8?B?bjhWbUVmQzUvQVpXWFZESzJFRWVTWjdVdzdYK0g4LzBJNWhaVE5kVVRTQWFY?=
 =?utf-8?B?QWt3cERXaDgweHZzSlRzeWYwUWNmSVFzMkloYWNJN2ZLTVprWFZQVmZRNFhB?=
 =?utf-8?B?QlZlV3kzWUFnT3ZQNDkrekVZZEVNZ0tzTWJQSVZzSHU2SERMWllibWZsZDF1?=
 =?utf-8?B?UmVicFNlU1V3cVFlSHc0WGpuL3NMOTlvdEFaNmFKZTlaUGNqSXIwdStuZlpM?=
 =?utf-8?B?cFFlTzJ2cnl0YWVZQk1OdVNkTFFTNEpmck1BUVFNRjNOWGFEZlBHZDNwWHh6?=
 =?utf-8?B?UG9ZME9uYWpGeUNMMFhBMW1MQ2d2Ulp0Vm9SWUNJbVMydStveW9WUDg5WUZJ?=
 =?utf-8?B?QWNOUGpjTHRRYk1rckw0OXpad3BzSU1CWU15NlhseEYwQ2Y5TWJxdHUwZXpE?=
 =?utf-8?B?TlloK3gvaGRVMWp2RTFkVzNKN3ZrNGowNnFLR3VycTFXdXJJQWFVMjluQW1Y?=
 =?utf-8?B?cURDL0Fodjk0ZTNrK0NuOGFMQjNLN2FrTEZMekV2OTJJZ3ZvZmJUaVZUUEo3?=
 =?utf-8?B?eWJ6dVR4ZUE1anY1cTJWOU9CL05UNmt0WjhBWC9tNTlDc0c0WHdMZFU4dHNw?=
 =?utf-8?B?dlJBSGFhb09QQ2NRc2pGaVgrMlRIT1Ztc0EzdDFXTVpibGQzVWJZblNBUlZL?=
 =?utf-8?B?dmJiQXJ5S2VwcGZSYWRLc0RwV0FTNlhBYndCZWFBbGhDVCs2RHpVTVRjekpH?=
 =?utf-8?B?UndQeWF2UWI0S2VPV0lnMFkrczRNR0J6dDlFU1JrNnpZeHVvcXJrMkNzenpI?=
 =?utf-8?B?cmxpOVYvUmRvMVZndWpoeUErSThqZzZSVHNuUHpvaURKdXVQUzVvMjZRSjJh?=
 =?utf-8?B?SFFsTDMxRlZwVjdQVFc3QTkvOHROZFFyb1BIRVhwV1NBbHltTE9rd3VLV0Qy?=
 =?utf-8?B?clZjME84Q1dKOG1Mbm4wQzlBQ2l2Tmd0UmxreEhTQXlFa0NIdjg5a0xTSU1q?=
 =?utf-8?B?SHpla2dvbU81UWVncnNJOHljUWpaRnFmVnh0cXdraDBOUTBBMCtla1c2Nmt5?=
 =?utf-8?B?RXFQdzB3U01scWViSGZiUTY3R2t5M3JmSUZjVlhYNnFLZlp4SzBTTy9iRjU1?=
 =?utf-8?B?eWJvVHduVzQvRlAvSks2MU9HZkNRS1lsQzQ3cHMzWXI3SVNQZU1vcFNpWXlZ?=
 =?utf-8?B?RlZlOTZYeTl3S0tWM3dBZy9mb1dHU3pZUUdscVp3eWRnS3hqdTA4T3EzN3px?=
 =?utf-8?Q?gy/bW3O0SjkoGqtc3T6Od5t34?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b67cfc6-f780-42bb-5aab-08dc7bce3516
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 08:47:56.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNzZc/lWyI5UkOI5y4ClRnlc9aeX6XD6brbogn9klQzcr54w6rTjsYflXXDD53iM9zxcBClpV1yQAUOl6U/M4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9931

i.MX95 System Manager Firmware source: https://github.com/nxp-imx/imx-sm
To generate html from the repo: make html

i.MX95 System Manager Firmware support vendor extension protocol:
- Battery Backed Module(BBM) Protocol
  This protocol is intended provide access to the battery-backed module.
  This contains persistent storage (GPR), an RTC, and the ON/OFF button.
  The protocol can also provide access to similar functions implemented via
  external board components. The BBM protocol provides functions to:

  - Describe the protocol version.
  - Discover implementation attributes.
  - Read/write GPR
  - Discover the RTCs available in the system.
  - Read/write the RTC time in seconds and ticks
  - Set an alarm (per LM) in seconds
  - Get notifications on RTC update, alarm, or rollover.
  - Get notification on ON/OFF button activity.

- MISC Protocol for misc settings
  This includes controls that are misc settings/actions that must be exposed
  from the SM to agents. They are device specific and are usually define to
  access bit fields in various mix block control modules, IOMUX_GPR, and other
  GPR/CSR owned by the SM.
  This protocol supports the following functions:

  - Describe the protocol version.
  - Discover implementation attributes.
  - Set/Get a control.
  - Initiate an action on a control.
  - Obtain platform (i.e. SM) build information.
  - Obtain ROM passover data.
  - Read boot/shutdown/reset information for the LM or the system.

This patchset is to support the two protocols and users that use the
protocols. The upper protocol infomation is also included in patch 1

Signed-off-by: Peng Fan <peng.fan@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org

Changes in v4:
- Rebased to next-20240520
- Added vendor/sub-vendor, currently the sub-vendor is "i.MX95 EVK",
  this may not be proper, I will check with firmware owner on this to
  seen any update. please still help review other parts of the patchset.
- Added constrain value in binding doc, change the property name from
  nxp,wakeup-sources to nxp,ctrl-ids to match firmware definition.
- Put i.MX code under new directory imx/
- Change the misc event from three to one, the code in previous patchset
  was wrong.
- Link to v3: https://lore.kernel.org/r/20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com

Changes in v3:
- Update cover letter and patch commit log to include more information.
- Add documentation for BBM and MISC protocols under
  Documentation/firmware-guide/nxp. Not sure if this is a good place.
- Fix the bindings, hope I have addressed the issues.
  Drop imx,scmi.yaml.
  Add nxp,imx95-scmi.yaml for NXP vendor protocol properties.
  Add constraints, add nxp prefix for NXP vendor properties.
  Use anyOf in arm,scmi.yaml to ref vendor yaml.
- Use cpu_to_le32 per Cristian
- Link to v2: https://lore.kernel.org/r/20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com

Changes in v2:
- Sorry for late update since v1.
- Add a new patch 1
- Address imx,scmi.yaml issues
- Address comments for imx-sm-bbm.c and imx-sm-misc.c
- I not add vendor id since related patches not landed in linux-next.
- Link to v1: https://lore.kernel.org/r/20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com

---
Peng Fan (6):
      Documentation: firmware-guide: add NXP i.MX95 SCMI documentation
      dt-bindings: firmware: add i.MX95 SCMI Extension protocol
      firmware: arm_scmi: add initial support for i.MX BBM protocol
      firmware: arm_scmi: add initial support for i.MX MISC protocol
      firmware: imx: support i.MX95 BBM module
      firmware: imx: add i.MX95 MISC driver

 .../devicetree/bindings/firmware/arm,scmi.yaml     |   5 +-
 .../bindings/firmware/nxp,imx95-scmi.yaml          |  43 +
 Documentation/firmware-guide/index.rst             |  10 +
 Documentation/firmware-guide/nxp/imx95-scmi.rst    | 877 +++++++++++++++++++++
 Documentation/firmware-guide/nxp/index.rst         |  10 +
 drivers/firmware/arm_scmi/Kconfig                  |   2 +
 drivers/firmware/arm_scmi/Makefile                 |   1 +
 drivers/firmware/arm_scmi/imx/Kconfig              |  23 +
 drivers/firmware/arm_scmi/imx/Makefile             |   3 +
 drivers/firmware/arm_scmi/imx/imx-sm-bbm.c         | 380 +++++++++
 drivers/firmware/arm_scmi/imx/imx-sm-misc.c        | 303 +++++++
 drivers/firmware/imx/Makefile                      |   2 +
 drivers/firmware/imx/sm-bbm.c                      | 314 ++++++++
 drivers/firmware/imx/sm-misc.c                     | 108 +++
 include/linux/firmware/imx/sm.h                    |  33 +
 include/linux/scmi_imx_protocol.h                  |  64 ++
 16 files changed, 2177 insertions(+), 1 deletion(-)
---
base-commit: 81ec2bad50c0c1bd3c66389fda32a6f2cf922508
change-id: 20240405-imx95-bbm-misc-v2-b5e9d24adc42

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


