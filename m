Return-Path: <linux-kernel+bounces-175505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFAB8C2086
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA551F216C7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45E716C844;
	Fri, 10 May 2024 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RXwxvEg0"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2082.outbound.protection.outlook.com [40.107.241.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56450165FBA;
	Fri, 10 May 2024 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332349; cv=fail; b=qtI4MJfQtZSvs76waem+JMccLOxrezglSt1ACHAzeBQ05SCu0Ybb4XIbD368a9qLX9i04SqhkbGdE6p6nepCybZFreSX/jfS1p9NhlZL36qlwsuDiAHGHjF+SP5I1nvd4VDlTWssG+dmPDJyKH5u71FOLrXtT94idEuQlIMt46I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332349; c=relaxed/simple;
	bh=BXE8p0r/N9cwzw9hvSQemC+9EJkYUN9CqF+Rr+r1zUs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lpaDIZQBkPnMeftCgLTGbObkKHffgM4UFBurqgozxOPJia71jl83I0N/A4gaA04xIUmVHAZWu045X2l2LQTIMVZwMITYAKGVk5L157a3rnPRFIBlHoluai88aZJa/LeKq17nVpOGo6qxREn5S8QRA3EOPoIttRdw+dJwZJ6QOv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RXwxvEg0; arc=fail smtp.client-ip=40.107.241.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhFtxTfs7wvDbbpKgazBaNWb7wRxgqrq/UXJeFjqSo6B/+GN7UF5OUpVmMBO2IZJUW+w74WI3rm8lNgX7q1AXw668G7c3ErBAoWkKc3hLtHw/dTJumUn+seqAnPKPvb5Alb1ZtojFeTBNfY6HYYd7fOyGZDKxFecaVP6cJbMMzMF/hgPbEQKrZ9SqFer/f5wEQV62YLFGj56WtpRFTHlOte6dxBnENIhE8bsQOipbb/6wFhnKhhJihOEnkCqZLzH/sETRp86RGOuog8HzxBZqCKhcX4Gt46BT8KafCP5TYYQW/IaXfKurshSBT11HVDz80kAo0uOiTJ7N7lSL6ibiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jembaBdxFeQLoGQq8jEpWbT4U96f9uWnSv2yKKMqdjE=;
 b=PScBUbNdnxYqG0E3mVBgR5iylz+jOmA5rElKFUqY9NGQoLqhOBZyE6NP+WjaLaTPRU0UrycxYLZr055w8rx2uIpiFtHhZC17nappat6DjXZ8/zCGLU/nwqzcS3AJTSKO6prcJf+oYYiIsYCaQDybuB14B4xXfvpPU8N8nhe7sqmg1Yce716rN9KLnzyGHXaeDSDBuBcgQpqHsKrEThmbxuLCu1QpbYwEXTBznKNUHicAQdNNAu7X2LFdG5NIXca+rYSCs9eg9xhTZNRZAh4C3Ak6FoFjN1HPTw7objTquAK71s3gAD4CB5PQHyjyLanywhFFCRqSrao6Ah70cnWqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jembaBdxFeQLoGQq8jEpWbT4U96f9uWnSv2yKKMqdjE=;
 b=RXwxvEg0cAWEks2IYPKMa68FmeoXhHVk5EFb72k38SH0TxwGiTZPN0YkhHFPOz5WFdkEOnHJEhrZlspJNaGqfHTOf3PIr3+fzh9xSe8ZHkQIfMyyxYi9YTRLyLHyzUtV0zoVeYIOUqBh576mQIQHy7183rlyOxHDjicUW/ZZuX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8065.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:12:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:12:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:19:08 +0800
Subject: [PATCH v2 13/17] clk: imx: imx8qxp: Add LVDS bypass clocks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-13-c998f315d29c@nxp.com>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
In-Reply-To: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=3946;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=UduvV+cQrI7InFFBa0tNN9NOOunIk8WRP1Hq2ak4H5Q=;
 b=AqhfO+i9LpAzWXwoQR3CAJ8ynYOyLL2Rw9BABX7XivoRZhqCqP11vjl62EETeZj1YmDBJdjmI
 KHjSkVx/vP0AFJR4uGyztVVNpKCE2/VJMEOsjKDjSzHnmNO1agShlV7
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: d1fc0bf4-51d4-405e-14e4-08dc70d14a43
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHhkbDRXM24rYUxMNjJHajNKMDNzT0YzZnhvcXEvVENkM2hTaFhYUGp3Nmpn?=
 =?utf-8?B?ejgvVE01b3k5OVZZNWRCVXFzS2ZNdzFxUWh2YWw5RjZNRklWWkhkYmJyeVR1?=
 =?utf-8?B?NzNXUG9WMUxhVGVkSTAwdUJWNWVnQThNL3EvUDVxM0dZcWdPWUE2SUdVWXRa?=
 =?utf-8?B?T2VmSnJyQzlodEY1ZU5xbTUrMU5JTE1PL3dhSUN3QitTeE5hVFB5MDQ0Y1V5?=
 =?utf-8?B?Z1EzZ1pGbUN5THdKckFodlhTV2d1RnhPMDVCZzQzS1VyM21Pd0tLZFpOL29X?=
 =?utf-8?B?ajBVdzJzMXRMc1VJRkNyM0pnSjJna0Y0M1FPWHdwVThYUTNmUGVtRWVhMGx4?=
 =?utf-8?B?UE00NTJlRllGelpNSDE3Yks0enFMMkJnTk1rZ0MzdjZKZURFVDcwbGJiRVhp?=
 =?utf-8?B?aGp0OFFtZlhSL2lpV2QxZ1o4Tkx5WFBWVzJRaGdQRzRFUUR1eHJkOVd1bTQz?=
 =?utf-8?B?L3Q4R2ljdUtIL1BKMXRiNUJrU3JaODRxck9BSHRUekZkZG0zTU1OQzZHRzQ2?=
 =?utf-8?B?UHN5bXFRa2hMcEVOVWpOYi9heE1VVUtEV2JhcDhOL3ZQQ055UGowTEdkbDZl?=
 =?utf-8?B?Y3BtdnNqajJ4Zm9pMTJEUzlKOEpxZjZKSjRuYjVyNy9XaXJMU3I0Y2xjREVR?=
 =?utf-8?B?eTg5cmRzSXovd1BaL3pmejlhZWQ0TzBJOFNXN3hGS3ltWWJvZUh3Vm5JMFZ5?=
 =?utf-8?B?YnZJRjhFbzNQZ1JaTHZ1ajhuMXRLWCswT21XNFVBMGhlVitMUmFSRk5jeU5F?=
 =?utf-8?B?cjZXQzlqaC9wME5sZHN4RUJRcHllTU5nNE9jcjlmeWdtZnQ1b1h2TzNXUlZ4?=
 =?utf-8?B?RWVHS0FMVmxIeXZFSGFYUW0xb0J0N3dLTjlTU0JyRFVCZmJoVGVkRktrL3B5?=
 =?utf-8?B?ejVFbjk0cVFJZXVSSHJKTGdkZ2hRbGRZa04xNWlSam1pY3lQOEk2dUg2UTBK?=
 =?utf-8?B?MVBjcm5pMFpSQXNucDhDekdpTWU0QjM3aUJyMS9kWG5VVlhucGhrSmp1TVly?=
 =?utf-8?B?NEVoY1NNc2VLcTlON05pSTd2UEgyMGRhOS9BcWx4V2VLajRqNHNncVA4alVr?=
 =?utf-8?B?U2tSTGJkeXpwTy92d1FxNkZEUHZxRFNFdjJodUc0R1Y4c2VLcDd4V1RCNytM?=
 =?utf-8?B?U21rTjZtejZmYzQ3djNQWTQ2d1Rod3hWbkxtOTJtckx4dmwvbnJISFByNm1D?=
 =?utf-8?B?YmxVYU5vUzBlWFJvV3BvNzM2dnJ5cmRJUElOT0RjUEZ6d2tvbG5PaFhOTFQz?=
 =?utf-8?B?ZEVmRlJ6YndkOTBaTVlOd0c4STBFWTljS3ovWkluVkpMQTdDVEZtMEsxcThL?=
 =?utf-8?B?eU1Ba3k1SkVlWWcvaGZXL25lOFlCSmQ3U0RSbVhhbGNHdTIvcnVNdE5ybjkz?=
 =?utf-8?B?SFhYdUpUNC9uQ3FKQXJJTWFsQTg2NytvNXZlSWNqZWM0MEp0dEVuUWQ2ZlBa?=
 =?utf-8?B?eTZtZDROZ3NvdXhBYmgyYlF5SEFFbU56Vjc0NFl6bTV0TDR2SjQ0bnBlcVU1?=
 =?utf-8?B?UGV1M01aUUdLc3NUQWFaMTY4YmNTdkV3Ymp1TlhHbjlTV0JnQmN3YjVlMG5Q?=
 =?utf-8?B?Tk1IL0ZIbnRPQVdTR1cxVjJtTHlmNHVuakVtR0RpVnRIYUNjYzB5VXYzckZj?=
 =?utf-8?B?WWdCT1Z0dW96NUVPU0ZKYmFWN29MTXpTQWNIeVJOZExtbFkrLytJc045TEQ1?=
 =?utf-8?B?YmFVWjNEZ0UzeXdydkluSE5MQzQxNFFuNHQwK0l0U2ZCeDBWaEI3TlhUbElm?=
 =?utf-8?B?YmJCNWlTUDhpYmtUbGdnUnZzMXpsWjZtZ29EWTh1VUJXK2pWUEYreTlvVzBH?=
 =?utf-8?Q?KvN/dt9yCQRTOWklzmhbJ4fv9OnajF6sV+Sfo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODZnaHFTcHFtcUc2SzlDaXlhd2d6aCtyOTF6aHl6Y2xNVDJFdkZiMmluSFor?=
 =?utf-8?B?RGI1ZTlIWUpqTTNIakl2S1pETkZDUVhZeXBxYnhNQlBWSDBCTkRJRU5oaUQv?=
 =?utf-8?B?cXlQV3R5QUQ3UEZNRWpXZUtNZ0ZEaDFLSWQweDA2azhWRE0wb2ZzTnBLcEFM?=
 =?utf-8?B?N1NleTJSdGlFVFhCYytXcy9rSytha0ZQeWkxdlRrLzVFRlA0TTRIdUU4eFEv?=
 =?utf-8?B?MmJrZ1VyMmE3WU9HWWJjS24wUnROYjlZaXRHRWozZ2xTWWEvNmF5dHIrN09C?=
 =?utf-8?B?NzZEcUZ6OG5VWHdnaEQ4S3J1czdTbGNuQnhiY0ZreGRQaXBKNkIvdkVyOU8v?=
 =?utf-8?B?Smg3ZzVDdE41VE8xd1V5NTMzd0lHVVBZQzViZFE1U1puSDkvL1dtenBCeTBV?=
 =?utf-8?B?eiszNEd2NXZMUndzNU50QURpaTFZZXlIUWNFT0ZnT2tDL2RXMWRpdGdpa1ho?=
 =?utf-8?B?cFhZbWZZbzJWbkNvYUVEUWdYMHZsd0JQOERLdEJ2QmRUWDEySVlnMVhTaDh0?=
 =?utf-8?B?YjlrUTRqSS96elc1WXIvejM4RnlxQnpyc3AzeHNwam95RTRUQXcxWEl5WGVJ?=
 =?utf-8?B?cUVEMEZLZ3FjbDZHZFl6bHEzRmhGdFlLVjB1Rm5BR0JUY3FENi9SSHVXRjgy?=
 =?utf-8?B?V2JyU2N1RjF0d3VCeEdUakVwd3dVVUZ1QnhpZVl0c2t4eTJtSVQyYmZQdi9I?=
 =?utf-8?B?VGlqMXlOS0NXWHluelZaVXNPdkhDQmZZU0pQZGh1Rk5aTldqa05jY0wwMkZT?=
 =?utf-8?B?TDVoN1BreFFnZEw0bjVJV0Y3OVZyY1lnajVUVlZuSmd4SWlOeWNyU21mZEov?=
 =?utf-8?B?QUFDYS9ySzRDWHVoVVJ1YmgzL0VvemJNTGFEZXNsNFkxRmYydUFIa05SUENO?=
 =?utf-8?B?TnR0Z3U0SHFQUFhyNDhZTzByU1hDQlBIdlpOMjFMbmFwSUt0OUtwK1BQSmdJ?=
 =?utf-8?B?VzdaY0orRFdqSGFVMFN3UDJ6WjJhLzhPd1JRMFV4NzhDb0kxTUNGOVAvamor?=
 =?utf-8?B?VGU0M2E1a3c1K2ZUQjZ6MmRINkh1bkxURFJWenVQWkhsR0wyNnkvUmxnUGpN?=
 =?utf-8?B?M3hoV3VCeG1ZVTRLN2llWmIxcnEvWnVQcms2cHQzUndtaGdVTTZqNGRiODBs?=
 =?utf-8?B?RFozazBHSDNtOEFkMitJRWoyZHZpMWZraDBnVUtUajh0TmtUYytmQ0tpQ3NZ?=
 =?utf-8?B?SWNSZWxUcTE5VEZXcG5KaVRRSlBUdGRMT25JcHdrL3UvS3RkVzFYMVpnUGE3?=
 =?utf-8?B?dVptYVBSM0x4SG85eXFJZHR0N0dtaEFNYWhhNzhuQ28xVnFjSGxWY05yYVJE?=
 =?utf-8?B?WFlZZTFHbVB5YStGRGtJLzJKdytuMS81VWErRkdlTC9pdVVaQXoxbkFhVHhB?=
 =?utf-8?B?WWZ5ek1qMWpQSDkzVG5lRTNLQ2lvMVYzWG15eVVkRDVxUGp0TGFiNCtsY2dG?=
 =?utf-8?B?R0hiQkhNVDArV1hpVVE3QlV1SmpNY3R4OTJZZUdralhGUUR4aDN1UENOQkpJ?=
 =?utf-8?B?cEZVRUtZTnVpaVBaSUNJWkVQejBxZGhLUHd2SDRoaWJHUGo1Yi9QekhkTnVW?=
 =?utf-8?B?WjZiK1VmVW1aeU9TUXcxVEF2WTRyM3FROUpTZGVkSUp6YW53MlQ2UEx4cWox?=
 =?utf-8?B?T2tOUWVJcVdCYUxjN0JUT28vSzNnVjVsTkFiZTFWV0RsclhtUnd5UGtHNUhK?=
 =?utf-8?B?WEFHczVXOE8xMmRqd25GOFl3WnJBdzEzMWJYdzJaWnpEOWNWNTNWSmNPMnpY?=
 =?utf-8?B?azJjVnNWTVVzM2lnQS93V3VvRmd1Z1pPaVRWRnBKSS9wMDJaS09qZzBhZGtG?=
 =?utf-8?B?ckk1L3U5RGkyNTdhd0NxMHI3dTEyT3V6UGdMWS83bVN1cnovaUxHMXFJV3BJ?=
 =?utf-8?B?UitjWlVhN3VESndvaWlEV0ZSY1lydHUrdTB5dFhDTit1eVFBQXg2ZnZ1RHky?=
 =?utf-8?B?emNJRWExb2VSVGtHcEFtR2VTczFhejZlVGx0Z09MV2VpNUV0S2lraXlwb1l5?=
 =?utf-8?B?QjhrMG9CdlI5bVlMMzFIb3VPTWU2QzRjdnJiQzVNb2xzU3hTRXJTL3VycDJl?=
 =?utf-8?B?bFlJY0RqVHA0T0RvWUxtelcvU2RoOVYzdmpnUTVmZTB1TzA4Y2p3M2ZVWUhz?=
 =?utf-8?Q?YOxjncOcxwkpsn0NCslLOXMpO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fc0bf4-51d4-405e-14e4-08dc70d14a43
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:12:17.7531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxulZRYSktghw8JILmh0Gu6a0/yTbwiEXRJzDGi8BpAusvim6pRSGJPjCsMmqpMdsN6x4XJg1cvA+ZLNf8rSBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8065

From: Peng Fan <peng.fan@nxp.com>

For iMX8QXP and iMX8QM, add bypass clocks and register some of the LVDS
clocks with imx_clk_scu2 as the parent needs to explicitly set.

In order to make sure MIPI DSI works well after suspend/resume, the LVDS
pixel and phy clocks must be initialized before the MIPI tx_esacpe
and rx_escape clocks. LVDS phy, LVDS pixel, tx_escape, and rx_esacpe are all
on the same MSLICE. They all share the same clock parent. So, setting the
parent source or rate affects all of these clocks. In the LVDS use case the
MIPI tx_escape and rx_escape are not saved and restored. So, LVDS works for
either clock initialization order. For MIPI case, LVDS must be initialized first.

Signed-off-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Signed-off-by: Oliver F. Brown <oliver.brown@oss.nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 7d8883916cac..a0654edaae83 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -71,7 +71,7 @@ static const char *const lvds0_sels[] = {
 	"clk_dummy",
 	"clk_dummy",
 	"clk_dummy",
-	"mipi0_lvds_bypass_clk",
+	"lvds0_bypass_clk",
 };
 
 static const char *const lvds1_sels[] = {
@@ -79,7 +79,7 @@ static const char *const lvds1_sels[] = {
 	"clk_dummy",
 	"clk_dummy",
 	"clk_dummy",
-	"mipi1_lvds_bypass_clk",
+	"lvds1_bypass_clk",
 };
 
 static const char * const mipi_sels[] = {
@@ -223,9 +223,9 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	/* MIPI-LVDS SS */
 	imx_clk_scu("mipi0_bypass_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu("mipi0_pixel_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PER);
-	imx_clk_scu("mipi0_lvds_bypass_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu2("mipi0_lvds_pixel_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC2);
-	imx_clk_scu2("mipi0_lvds_phy_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC3);
+	imx_clk_scu("lvds0_bypass_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("lvds0_pixel_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC2);
+	imx_clk_scu2("lvds0_phy_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC3);
 	imx_clk_scu2("mipi0_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi0_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_SLV_BUS);
 	imx_clk_scu2("mipi0_dsi_phy_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PHY);
@@ -235,10 +235,9 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 
 	imx_clk_scu("mipi1_bypass_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu("mipi1_pixel_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PER);
-	imx_clk_scu("mipi1_lvds_bypass_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu2("mipi1_lvds_pixel_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC2);
-	imx_clk_scu2("mipi1_lvds_phy_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC3);
-
+	imx_clk_scu("lvds1_bypass_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("lvds1_pixel_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC2);
+	imx_clk_scu2("lvds1_phy_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC3);
 	imx_clk_scu2("mipi1_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi1_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_SLV_BUS);
 	imx_clk_scu2("mipi1_dsi_phy_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PHY);

-- 
2.37.1


