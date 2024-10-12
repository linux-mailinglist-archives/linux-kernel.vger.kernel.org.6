Return-Path: <linux-kernel+bounces-362300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 762B999B34B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E620B211BA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE327158DD2;
	Sat, 12 Oct 2024 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O9Q9RQSI"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D5D155327;
	Sat, 12 Oct 2024 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731441; cv=fail; b=FiXPpVWVhLG8AonoS+tD7NJSnkHdA6cMrRdCyVXYZwj7lGcRfW1cI0SpdQwTRS5s6Mc0xTgPUhHwEYsqptJDz3KBE1gEXgW6MPa6WDvPJexfhrbUCrIr+eMbwxhJt+v54LILyqKd3m+Xi30wZPqDYyE9tqG/f5i0jnUwFhgfjjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731441; c=relaxed/simple;
	bh=lc7r5N6if+t7M4qgDjbQYSu9kdSeH6GDkyEEGsukoeg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=J/6UJtddZnw1RobHgC2NCa+oBgTceRgARs+g0/xJebUjuVG/f5n6ftnX5AKzKGZDD+Za9bwSRNLgET4nby4GO9JvGbYZbacozhgZPWhdtlMDCtMfbFQMa8SgjJWkKHFTXvmMvCoMKyUHJ/Aa9cjuclgbGrjUVGgPLSk2dfYuXPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=O9Q9RQSI; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usJ9mOXhSrR2gq4gLnAJTVIkSXvuHTKZ+g6shn4W8N0R6VczVEx0jJBHwwpons7YJK25ACTfMSqPTxw3eTbQBvFipjJXCbURSTCB2JyjtnKqy+QM2JXaD/DCzBerPGlKSjRII3STb/Z6lfyWKlvN6NuMQTXAYAItwh1VxHp+shZBpNcAPHV6Es48nHauXbi5bbocToNIoOyHE2WTarPvTa+Ch/Flmp+JrKn/m1fR7Yy44YP0vC//w7uxVOFcuOGPDXx7PPI7M8v0JnRpqIs3Baosle0i9aAvM/FF/m9vq9Imb+HxO4hCtXeOr+NVNhKxsCc543eFhCjbiZfbubBc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=va8MO1BT99jAeAk9lxDUmptxYcL5ib/bEXPRViVluvA=;
 b=AkTsLBXX1pZxVarowKj2nEJVYpElKcjcDnj0otSjONryDV6QO7qL81MLQLG785TCku5YlgpA7I2jIYQ0ayxcAnGbsayrbe3Y9yRnLlFlxTpxFeAzClXAI/AYFgxkER0ROyFF40uLzfx7EuLJ8xCK9qExaQwXXG+moNdhnD7KZqC+T02qZPiBc4FW5/hh1MbKiC7lNL5wPsO4pGtJZV+PerHPD9M8SmJKRD3EtFJeB6FfwDZGcrUJBiiIpF9pmp4/LGN+IljKicPK3d4OyzLjqvIa7UQNB4tpVCwG62m6ALh/AawsUvCXnquZRT6ATWyTGoq3gRkN/bogciYjK+iQNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=va8MO1BT99jAeAk9lxDUmptxYcL5ib/bEXPRViVluvA=;
 b=O9Q9RQSI1zBPdRsjeBqk3O6lcPnjNZw8mz8gISd5HNUrxqe9WOTe+hDSONPvJnZPVg5n6HBu5JF/XA2i2Tixn6d4CjMrmkOBLLWFLJ/QHND97uNjc7kp7YJO85ETT4tRjb/8MUCfBYJ3otdXr8VfCixCq+mVEg0OawuejwlAWiPFbS0gBFoHx81lBZkVVpsMSp4lkOsc9R4sChh/ktj8DhN9+LHUTdHxgGbZp3d1JF0N4oJjbXt3NTcAMFiUxLrFFfRUAmXU8GSeC9ZlnF3XUeF21VVIjAIYs/eMCPbxLY3LmLFycENidcDGv+qmTifsCJHv/PC0fYOI8vzFyeYMvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Sat, 12 Oct
 2024 11:10:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 11:10:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 12 Oct 2024 19:19:08 +0800
Subject: [PATCH v3 1/7] arm64: dts: imx95: set max-rx-timeout-ms
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-imx95-dts-new-v3-1-edfab0054c71@nxp.com>
References: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
In-Reply-To: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728731962; l=935;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Ovw1R944SPiJTGRodFjORkR1i5DxZJsVD5EHl0wThw0=;
 b=AZzIG++m1PX22E3Cw21bXu9vyZGyGoiFKjsQxxdfTqyQkgBOrfcqppUfh7vTTyY8IX7uZF0M8
 QP998Q2Il3+A6haLmVj7L7+CyZyJ4ObMhfNo5jAm+OXbIukR3sPNtOn
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 748ceb5a-edfe-4fec-7ac4-08dceaae8045
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VS8yclYyaG91R0E1WGs2Zk1kWVF1dHBnT2Nzc25zK08waXdjODVDSTQ2T0JY?=
 =?utf-8?B?ZWp6UCtGN1hsQnlETFFiNjlTZmxGek5CVDNDcEdJY2tUNjZZcXY0eTFqb1A3?=
 =?utf-8?B?WEdhWGVvU3YvUGk5OFNCaFgxa2lOT2dNRlNyVGFNSmxGelJsdjRYN3hpZk5u?=
 =?utf-8?B?ZFQwK0NrQjF5ODBZNkhHUHNXOWZleWdyK3pLbUNCakpwZ2JDSTF6d29WQXFu?=
 =?utf-8?B?WGZ5OHRkb1ZVQkg3cEpqK1o3SnRsMC9vazM2S1FkK0VmSStJbUEzUHFPY0Q0?=
 =?utf-8?B?NTI3bTI1V1VQNW1WajJFQWN4c3JEUGJXbWNIcmcrUzVOd1B5b0FmMDltcVNj?=
 =?utf-8?B?dFNNUzhDcWJGQ3cwazIva0UyaGFNNElkUVdIVm1aUmtDdlNrVnM4aDF0bnlt?=
 =?utf-8?B?ZFR3SFdZcjNobXhnUjhHVEdWUkpaSGpnM3RlUjZCb1ZxUzJGQWp4UnhSUHNK?=
 =?utf-8?B?VzBwZE8xdkdkRWFEdTlxMVFSZURWN1BkbDhlVmx0L0JPdnNCeEgwT0RYVTVN?=
 =?utf-8?B?a1pDWFhDTU5BSlBKZWlNcGliS00vNS9xRWJzYS8vQ3Bxd0JsaVdGSnU2Qmha?=
 =?utf-8?B?Z3JveXNNUVpiNThXOU1hYWRZbGtDZUxDNGFRVFVSazFFakVUdUROenJJMHFO?=
 =?utf-8?B?RGN0Q1NoTUdldmY1ekJrclJyaU9xTzRqZnhsK3VFbVZpRHVmL3pPK2U0akFE?=
 =?utf-8?B?cGNRKzVSNEJiNjUzS2VIcFF6UFdSSjBnQzNGa3haS1lyVElOTVpqamlqTDdF?=
 =?utf-8?B?YW5Bc2RkUlNwS2UvVlpYdjNhNVNIR1dSM0RrSU11czdRNmpuMDhqNTlFUjha?=
 =?utf-8?B?V0Z0czdmL000d0cxdWNob2d5RmRieFVrRk41akJZeDhZekMrODVpODE1MzVH?=
 =?utf-8?B?QzV2TVZmaTNabDMzaEdzbXhUbjZYZ09xSFlIcGRVM2ZCUEQ3bjJsNUwxeW0z?=
 =?utf-8?B?dGtpOTVualpUYlRTSEtrcjd3TWlEWEpSNUsyYzR3NFk3SFc4dVd1QVV1Yk81?=
 =?utf-8?B?K1NFMldzVEZ2cmxjME9BeEZrT0RUMUkyQk5adHJzakR0TU15U3d0Z0JGc010?=
 =?utf-8?B?clhreE9EUFBaRHduN2Q3UFluNlFoRHBkRjhLMCtIcWo4RFZrMlRCUXExc1pJ?=
 =?utf-8?B?UHVUS3ZJRVd0TzJMNmlRUkV6VWFEVVl1dFFLR3N4K1NJVzU2YkJMTmJkOHFG?=
 =?utf-8?B?dS9kUnN0cnFseVdGeHB3dU1jTS9TU0RmcVFNY0Rxa3Q1VFByZU5RTjhFRUYx?=
 =?utf-8?B?RGlNbWRlamJBaXFzTTd6TlJxUHVFY3BjZ1hHYi9NN3owSEhPdUluTFVXRlNF?=
 =?utf-8?B?Vzg0dE91QjVBa21rWG1qaGhGaHZ0YURCSjRhYUZiR3pHWUk5c3h4anlDNXpa?=
 =?utf-8?B?cGQyRG84VXFSTjRNVFdNcE1ITGw4ZW9FQWx1blRtdE1veXVjNytWeTkrNDU5?=
 =?utf-8?B?WjhHNnlUaGY4ZGxlaDdHWllUeW5zOFNBVjJGK1hsKzFLZU0vd2ZiYlF6eE9n?=
 =?utf-8?B?ZFUrQVRTY1k1dFczY0pJakVhUjlsaEFDM1U0NzZjbWliTzVXT2ZNMVNHUy9T?=
 =?utf-8?B?VC82V01aVDIwbU91dlRObCtCU0lqcS9HVkczalBoMC9lcmluMVZCRDdUeFdN?=
 =?utf-8?B?UTltUlB2N3pCcEtuS0xNZDk1dW1HQ0FwQlcrV082SkZlc0VJbE5XOUNqbEFW?=
 =?utf-8?B?aDdvTXMrYzFwZzFxVTVrK2pzTVdWazBxZlZYYkhBdXQ2WkEzbVd6ZVMxMjJx?=
 =?utf-8?B?SHVTRkVhaXNSSHZ3NDY2RURnemZWTTBjUUdwSmZLL21aSUdiQ3AzL1g4QmZq?=
 =?utf-8?B?MCtFNCtQK2ljL3Q0Y3JqUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REtyQVJWNTduVDlBRm9PVzVlb1N4UWhKVWFESEdNRTcwYXh0cTZHOXNiNXdh?=
 =?utf-8?B?MWhEblJ1RDhMVlAzb1pEYU94UlNyZk5IaGt2TFhUWlNHK2gzbEpDMmhWREZn?=
 =?utf-8?B?Zkx2WWs1MnQ4b0Rmb1lEYTVEL1VWanB3K2xEd010Uy91QmdMRXpTalRFRkxV?=
 =?utf-8?B?SHV4MElKeCtxd1RWb0p3WENqbXdGQU9KcUdXK1Q3MmxHUldpUGV6RUNEL2dh?=
 =?utf-8?B?aE14QmhBMm5teldCY1UxZElMQW1yVnZ6ejJLNUJSaXdxbUYyT0Q5ZG1nR1Vh?=
 =?utf-8?B?KytzQnZJZUVTeW1GS2k5anFpRERLOXN6WlE2cFlKdFZLYkpERFdYUDhCSG9m?=
 =?utf-8?B?S3JxRGU3Z3dMa3ZsTi9SUEp4YlF2VTl5NllISVNGdFpLUVh6cmNuRU5qSGUx?=
 =?utf-8?B?bHprTklLS0h1NUoxbUs3T0YyTzhjaE13cTA1UVVlTEFMa2oxampZNTJxR1JW?=
 =?utf-8?B?VEM5YUd2STRkRzIwLzJhbHNNTk1CRExPWTFYMXV6akgvS1h1dXAxZ3hJeGVM?=
 =?utf-8?B?c1pFYysxOWdnVkxMT3NHUldGeGVoZGJSWDE2WWcwY0ozcFZIam1ORmJUNnFz?=
 =?utf-8?B?cWdXTjJUK1BDc0lENW1lVisvUjRFRnNueTNwendDU1U0S0o4cFBWNzhjNXpT?=
 =?utf-8?B?bjV1VEVoV08zQmdGSVBnWGhaTjl4bzhYT2hGaDMxZE1qanFJaGwzdkNjS2RU?=
 =?utf-8?B?U1lFbFlDZWQ4dnRtRzFRL045SDFyTTVUVmdmMWJaWVA1WG5hM3o1cUhIeXZo?=
 =?utf-8?B?OEdpTkZuWVdDemt2a0dYMWRwdmJzeTMrUG93ZGhpWm9mTEJQQVJ1NmpEOTl1?=
 =?utf-8?B?RjZuNWpFMGpOQTdhNlZIbkZsdHo3VitkTXBTOW1NVzVWYjF5ZkxydFBBK0Qw?=
 =?utf-8?B?NnlaL21FcjhhY3ozYUtkcDJueDNSODJjaHZRVjJ5U1VEdjB5U1JLRkJBN1RX?=
 =?utf-8?B?Wk1WTVBSYkFrbG9MOEYxRTNma2hxT1hCcnhQTFRDL3dSYkRYQ1ZPSSthYS9h?=
 =?utf-8?B?akFockZ5aHU2SXRQcVUxaTJrRmZpVzErTmg5VmpVSXFvdlFDaGJLVDczemZU?=
 =?utf-8?B?VDFCaDRYQkVKYUNvaWlkWHA0Nm52QzNjMWxldWR3SHV3OGoxYnRxUHR0WVR1?=
 =?utf-8?B?amNMOWt0cmZQYjNIVTZkUjdGUm15SlZYZHhDMng1RDBaS241Wi9wNmYxbGhq?=
 =?utf-8?B?a2ZCaC9hOFVVU2JUOWRWZE5SejA3NG1vNEMvRFErRDF3R0psRHZ6RStMSFVQ?=
 =?utf-8?B?aVk5ay9pZnYyRjBodE9LUGRQN2h1REF6dDJYNzlXMm1hSlNobk5zdExLQ29H?=
 =?utf-8?B?YUZiOVlZTDc4K21EMld5eks1NFUwL1Bteitqc1FhcExBWDBiVWtRTFhGaVJN?=
 =?utf-8?B?SFpnSW1ITk5tNmNSODg4NG9TQ2d3SW83Tk5ZU1ZkMEZEQklvdVpWZFJvRGsz?=
 =?utf-8?B?b2xVSHdPMW1DYzU0SzgrdjM0RnA0Z21KYkxhVG1VN256RXZiU1g5ZlowMkds?=
 =?utf-8?B?REpQdHhsUHFKUGREek1jL1EwcjhvbVc4UU1XME54Q3ppNCtwMS9ESDdQM0do?=
 =?utf-8?B?c0Z0MlNidExLS0NWUlFCSHJmb2tia1Y1UmJWMERBWkZHYlJIYXlZQkNSUHFm?=
 =?utf-8?B?ckdTSE8xdm54ZnJQbmlaNTlCT1NWNlhDNTFWMG9ocDVRTGVkbEM3Q1lYbmsx?=
 =?utf-8?B?V2Q1RG1wbVJGQk1kNjU2WUZDdGFTaGNvZVRyV0Y0dFBjMmtrVHgxYVpJd1hq?=
 =?utf-8?B?TDJObk9aZmx5U0lGTTRYMklVWk1vQjAvOFY1c2xneC9RMk5FUG9NeUJLd2pF?=
 =?utf-8?B?YlE0bXNFYk5CcCt3cWhVLzRRb2JReU12ODV4TFdaTHgyMEZWMXZhM0paMU93?=
 =?utf-8?B?N1J3QmpseldkaTdyWDY0Y3ZwaTRESDJjdit6VjlPWUx0T1V0NkVTYnF0dGt3?=
 =?utf-8?B?bWZRdjQvSllZUVlHR3ZxRThZNk15K0c0Si9BUDV2V0dteVB0RWo0MnE3Q2hQ?=
 =?utf-8?B?NElHMlVMWTU0aG9QTFQ0eU5OWlczYWkwaWhCUVFObUJvSFZMRjhBc0dVSDl0?=
 =?utf-8?B?K2Z1V3kraE1mS3ErVE1RM1ozN0VCS00ydFRERGp6SnZ6VjhUUUdEdUVLaFpx?=
 =?utf-8?Q?m8YRM8xjSqecdAGwuM/EzSR6B?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748ceb5a-edfe-4fec-7ac4-08dceaae8045
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 11:10:37.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1y2gqfoJCtGqJ9YEfinYTEOhqKMUnq0TQVDyXhL64ogzeHGtScohWclch8Ilx5fuoGJXCNbpZ22Adl2ELq55pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771

From: Peng Fan <peng.fan@nxp.com>

With 'max-rx-timeout-ms' property added in 'Documentation/devicetree/
indings/firmware/arm,scmi.yaml', set the value for i.MX95.

NXP i.MX95 SCMI Firmware designation does not allow timeout, it will not
recover if the Agents use timeout design. So set a large value (5000ms)
here.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 03661e76550f4d5b8e5e706ad51d6f7620cb1dc3..9c802c2344fcfb2802e5d52c762b0178a2a88ba8 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -293,6 +293,7 @@ scmi {
 			shmem = <&scmi_buf0>, <&scmi_buf1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			max-rx-timeout-ms = <5000>;
 
 			scmi_devpd: protocol@11 {
 				reg = <0x11>;

-- 
2.37.1


