Return-Path: <linux-kernel+bounces-267094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4577B940C49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6671F214C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4759194C9A;
	Tue, 30 Jul 2024 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DxCnGbsg"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440F194C64;
	Tue, 30 Jul 2024 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329356; cv=fail; b=lElShC5PcsHUM/0Rq0zk93BzOxIcGnkd77CzS5Zpu+r0fuvhKEJuUaQAhJ9aLVJtAP1US03sgwDTc5RBrznp9bbfRB2tIPZoE6Tq+Dtprk1ouFtDEgogGbRVa3sHMGrvtLPcbvknftMYGeVRZSSQxDMmga5yDlIPt0On4HLuROk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329356; c=relaxed/simple;
	bh=5xRTsdrn1Ix/3Mgzo0lry2VgymrmTTFr4xJYfhC4puQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mc4dMzIb1MRIO3WuRAU0O2GeWrC5DJF2jsVYiMFwIcM2B0nQp5rzp3csZyOAyIRwowbcw/VooFBv4c4Q2acONUgcFOsDmIimdjH/2xU3JTHMqEnpwfxxmZwdjlfayjcTv3x1mkcMywHiAiXYyQExKQde/0zyxA0Szqzg+TA5RyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DxCnGbsg; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6g5uvusBkBB7y26xpTv6SaVl7PHiJV4sVvh1QGX7MH+S6KkeJH3lBilXTnnCmbiNB9Juntnm4OnrNpf1JjmU8drjcsHIi4+pnLJt58o34HKqGJpCVn1udkat45E7KnWBNQ3b49Iw6MGxrRX65d4MocjO7B9eQrHvyKcAmnf4G8/Q95VPz4aGeZOIvqdpScuy9h93HhPT1jrFYZbNVIkSEkpwUH6PjAay+p03AchcRnRM5vI0p0t42CEM4/R8b7wnXCJrKMss+dWL8dswZ4tdMbbw+LgEiVkHgC9SOj8iUMTAfB+ySH1MKiWmOOBXJ6HSQK5Bzh+A+YbGEjRBuqWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRwnZNctTZuOkS8PGldxochCXwtjTKzp19U8R/f50d8=;
 b=PTBmfNYG8Z3j2b0oQLvhsPqDGo7ZIwB5urJlooTgyEj+5DofLzf7EBwe8PGiPQQFA33/Tb5WQyTxhr+yVeu+LeZL+JOAtcjzSOp5ORxX1urgAxZolb3IHHfyiyfOoWYekEw2naBiSbUkWAuP2ijNQnDC3t1FIi85+fSIxLBg94+AiaB/v4jxQNfObOciJsOGQmhZTp+eCDtcLUHq1OYdzyKJibF6V25Ym/kFEUyjGDVyuDfv0+TQ19GmQJm/zxa/nxjzelv/O68VU1sIiYZwYkesyOD10smSIp06eFFGAT/4gXlb18A467c3cZRCzU+h8UXJHGSvkfijcQ3R7LW91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRwnZNctTZuOkS8PGldxochCXwtjTKzp19U8R/f50d8=;
 b=DxCnGbsgjPYfFFSrxfAMifA5Ljl55f/4BbPxDfsblwJwVHwMMBJSueZKQGc35ju77b6uZSnVvgNewuOclqLFRoankUHHqgZrcE1+8W9cDN3bwoRciyBY3qo7dIP0ftUH/I3O5hlaKurGd1aFM+ytCwlwkDzulaV2FxxUzzAKCNKtBVDuseUU3YsjlE4bpaxpQFmqsCPawSiXaeL1pTw6WaJm9HoMc++frLBZx4pSYZbZEbhtgSlnmV4vCSjVSlBPldEklhrT4kHSGssvK9QGHxHTmsqj0TFQgt3Pt6uS6dKdjK4QjxFVRfY2st4qURNsZqKYY3gPnkPY5fThb6fDOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAXPR04MB9021.eurprd04.prod.outlook.com (2603:10a6:102:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 30 Jul
 2024 08:49:10 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Tue, 30 Jul 2024
 08:49:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 30 Jul 2024 16:57:55 +0800
Subject: [PATCH v3 2/2] clk: clk-conf: support assigned-clock-rates-u64
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-clk-u64-v3-2-4d2b19edaa6e@nxp.com>
References: <20240730-clk-u64-v3-0-4d2b19edaa6e@nxp.com>
In-Reply-To: <20240730-clk-u64-v3-0-4d2b19edaa6e@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722329887; l=2412;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=J5oFMdGnIXFx9n/65+BOh2zj6XyKbv53dEmcaGstyuI=;
 b=UhMJbV25O1exKMZCzyHLn3ZwXPY4PneE5qvA4s5rfAlHmPku0SN4ZeXrFpebYFQ3ELx8DxqKy
 IoUKGqJqU++DUVH/olwIPLPZmu2JkH5IbyyHxMKiAdZZuiQVV8BvWwx
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAXPR04MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d28519f-a112-4803-4adb-08dcb0747a86
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0NEYUFvN25pYjJObVE1ckVyb3lOQnptUWUrWDFlbERWQnNvdjVsRlN6NSt0?=
 =?utf-8?B?d09nMG5QcmxUN3JrOElEMnErZW1iOXY0YU5CZnAwYTZtNTlFTDZaeEZjdW9C?=
 =?utf-8?B?RWdqSzA4SmJwN1hJaHpUMmJiWVBvSmRJQnNrR1FzVkRUSzBDSVRMNnZZMys1?=
 =?utf-8?B?VXcySFZJcHkyQVlOSlZmZVRBbk8za2dCbUpOUjVndkRrUmdGdmRYOW96TGpR?=
 =?utf-8?B?emVLM1J4TlBHQ3J0ejVZYnZvcW10WlJmRDd0Q1kwV3o5cDU3MFN6UE02ZjlY?=
 =?utf-8?B?eG1aRStRKzRkVXQrczMrbk5WdnN1VVVOUGU2cDRRdG14ZGdQOEJjcU01VnZn?=
 =?utf-8?B?UFVTVmszODl5Q1hrTDVvOVF0RWJ5K0lNcDlxaVVFcTdzRXBSY3lndHpHYVJ2?=
 =?utf-8?B?S0ZDaWVid0xwWWx0ZTZpaGpnT1FJUzdXMGNWVDcvbDRVVXREZThKQ2lyb1BS?=
 =?utf-8?B?SzhMSDN3TkRLcW9KYzRPYnR4Mkc1djBaeFMvUUMwMDNKN1NZdXRoMUFxajU3?=
 =?utf-8?B?RkwwdE0zdzN1NE1OT29SdXVxUzhDSXB1ZGZOSmVhQ1o4SmVwVlFGWkREWFQ3?=
 =?utf-8?B?UjJhazM4dVg1TmtuRUM5b1dxZHpSUDZDSlhMVFEyMWI0NDkyTC9uc0Y5Tmxk?=
 =?utf-8?B?ZUZDbUx2OXF1em5mZVk4dmlHM0sxQkZ5dW1FOVZmWXdzWDduZ3hJRXp4YVkz?=
 =?utf-8?B?ZHZVbzYraURsRjN6WnVnV0pFRWhtN3F1NUU2M25WUWNzVGhKUGxiRlBkK2J4?=
 =?utf-8?B?ZWpYWDNlU1ZVRTBXKzM4cEZTdnVpV3lkMTJwYnF4Zkd2KzVTa0p0bk1yL0FU?=
 =?utf-8?B?eHhvMlUwK1NtMUlkU0RTMnQyOW51Q3FuZXhHelV6cDVZWGdxcFBzdmFDZHVq?=
 =?utf-8?B?NjJVMURqL21zdXU3ZHlOR2NETGIxM01hU0RiSGp6V3FUMW14dS9jQU1tZU1X?=
 =?utf-8?B?a1pJaG9TeFNqK251dEwxMTRiajk0QzgvTUxGVmdpMXVtRDRPMlh5aFM1RlRi?=
 =?utf-8?B?Qy8xZCtseTFaeGRzcFpSZzM1V2hjV3c2MU44dkk5NkF5WlNuNHZIK1UreUYz?=
 =?utf-8?B?OS9BaWRkMlB5ckY3Y29kUWZla3R0K3ppK0x3UzR5Y0JJcW9uQWk4dU1XR3Nv?=
 =?utf-8?B?dVBWRXhVbTBza3NiaGNMWDYyUkpya1NBVjNxbVFNUkRBZzM3NkNsYTl6VlVZ?=
 =?utf-8?B?UUVnL2N3bWxsMGEyNUV0NldqZktnRTAzT003VXlPMEZpanFuWGVGVE5FR0p3?=
 =?utf-8?B?UXVyOGhobWdrSUxyTUc5U0dWd3hLQzJaYnJJbWNFVnY0UHlQQTNKWEFhVnMz?=
 =?utf-8?B?ZUYyRUtjdzhRYVlaa0pRTkY5aWtFYkU4bnRlUWVVYUpSMmoxRHNSMWI1dDV0?=
 =?utf-8?B?UHVLZVgyWDI3VmY5cVcrYWs2NjJUakRSWHhQN0RDRDJLWWNpVkJVVkV5OTJr?=
 =?utf-8?B?ck53blBreFlYK1h0RWVINXU2T256aE1YVmNLUWpYN0xDNDBxTmJmUExlZzNj?=
 =?utf-8?B?N3lQVWpiMXNzQkszdTNldkVBNDRGa25wa3kzVnMrVUY2SXUwdkpCc1NXNXcx?=
 =?utf-8?B?dGVtelpKTjlzVUtKK25UUXhIOGZGTWdwOHpNL0FiMnBSczMwd3NLMHlzanRN?=
 =?utf-8?B?S2J6Q3FHdnhQOEwyMXN3M3RYVXk4bWQvRThwSnNYekZRNHlHZjZZVW5JUVlZ?=
 =?utf-8?B?QW5Hc2lubXZFZWtCcVVuMzRidnhabGRRT3RXcnJHRXgvKzE1YTJSZUJZNkdm?=
 =?utf-8?B?Uk04aHVnZGhnTUFjcmUzcUFNVSt1QlZhdXl2Vm9Qakg5dXgrZW1sRXNsRUhu?=
 =?utf-8?B?dHo1WUpUVEFYNVVLbEQ2SUJGbWkvMmowamF4TWtCVHVxdWg1OTlPdnNySmh1?=
 =?utf-8?B?ZnNwNEVWckd3MVMweXVubEVSK0pxcFdyOE5OdzU0ZE9GWWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U01sZEhVQ2dtSlZ5TUt5R3lIN2lMRTZoN2hRMEtFVUcxV0hVc1pGWXpzOGlj?=
 =?utf-8?B?VURPaUlXZk1CcHU1WE90d05wMlFxVUFKYWU2dGdLSTlDSXFtTnltelJsd2RF?=
 =?utf-8?B?aEtaWStiREh5bFl6MGpZNWY0OWpzTmpkWkhqOGdMS1NyMDJpV2I3Q3hpYXNX?=
 =?utf-8?B?V0xHN25VQ0pyTTRDVDYwT2JaNFhpR3ZLNmpFdG4vVHRyQkZFWnpHTWpyYzNu?=
 =?utf-8?B?Y3RLcVZZbXZ2ekhKU1Mzb3A5MHJWWTJWbExna0JuSmZkQUFvWG9WWFdnZmdX?=
 =?utf-8?B?b01wZThvOFhjYVc2cHlKMUZ3cHVpUmhUaW0ybG9mWUZLWEJvSVlMWkNQM1NX?=
 =?utf-8?B?V1pqMjRIbG9CdDZhU21tTzVsaWd6NDlJdXpsVFJ6eEJ4V2haL3IwWnIzell5?=
 =?utf-8?B?NVVrc1dpSjNwWVJSOVZwdXhyWDRSVUp0OGRZalZkZGhXeGZQcjVFTGpZVDhE?=
 =?utf-8?B?MXQ0dVJBOXlKYnN6VWxTZlhjK1NIdGZaTXZKLzQ5YlNZZjdOK2k3eXkyRi94?=
 =?utf-8?B?K1ZzK0lQUUFyZHVVdTZEaExFczYwSyszWWNIaGUvQkNORWhSaTRvUm9kaTRh?=
 =?utf-8?B?enExU0hKQ056dGJ0VC9LZDdKTk5QVU05Zk45SDFaTHNFTmxSYnExN3FvYTFI?=
 =?utf-8?B?SGNUdysxN3BmN1dOSktRdW5hcERLdjEybmpVSU9lemtLNktGMmQwNzBYUzl5?=
 =?utf-8?B?dlpjSDU1akNVNGZaVDJoSzgyWHVic1l2NnlsYXhxK2lZazNPcGJWWlZuZWQ5?=
 =?utf-8?B?ZjFFRkkzZXRUS1lFbVpoUnkrekg1b1hkN2NsNktOa3FkK1VXWnhOWEY3K2pW?=
 =?utf-8?B?S3JmZDZHZitLdXpJTjR5RUhrdktoQ3BDU1NyVXgvVkVLcWhVeFQxcG9yMGxS?=
 =?utf-8?B?Q3RBcFpaRDdDVE1ady90NjlicEdnNU9ualZIVUlpY2c5aHlTWDBMRHltQ1hN?=
 =?utf-8?B?M1NvUUZFSFlOWE1nRTNhcW9VekZiLzFidGEzM0I5dHpFT0k5Y05LODRPVGph?=
 =?utf-8?B?YmxpY3pxZWdtV2NCSnQrblo4VGZoT0Yxcm1OT0w3OWhVT251WmNRTHM3NzA4?=
 =?utf-8?B?S1drOHBGUG96VjhpUlZHSjhxNnpjd1BIbzJUd3Z5N2N6RzMxU0pCTHk3Y1lj?=
 =?utf-8?B?L2JzK0ROdUxxVlA1Zld0Smg3bGhLVmxsY0NJSnkzTWg5ZHRYRDE4WnZBK3Fo?=
 =?utf-8?B?ZFZOZDZNZmlpWGJEbUM5bEYzTy9BSFlRM1R4Z0szS3FDSVU5NnJMdVBOSW9h?=
 =?utf-8?B?Z2hiTEtYaFJDbXQxTWJuZTZzZlRueXpiRjcwcndPZlExQ3lNYzQ2LzJNNStE?=
 =?utf-8?B?QS9laC9NTGxybGFGYTB3dzRWYmdZVml1SEJhSHY0REUrRzNkZVBTRG00VHRw?=
 =?utf-8?B?R0FoZzhKZjJrTW1pK0M1RjQ4YUQvdUFSbHcvOWY1NXgxS1RiSDQ2OENFdVN4?=
 =?utf-8?B?ODNHNGdrMmxvNTF3NE0rZVFqNkVqcWRQenpJc1ozbkVQYUNBa1FnSmlSSXBl?=
 =?utf-8?B?dUgveW5yYTZTbFJmdXNodWxIWE5NRGZqZjBsWGxuV3BPK2xLK1Z0eTJKQnhO?=
 =?utf-8?B?d2NSLyswNmxLbCtLQVJibmFHR0taZTVmZUl3Y085UXgwS3lDbTJSM08vbWVw?=
 =?utf-8?B?c2J3RzRWNkhpVEQyaTRzZ09kVnVYV0lkY0tKa3JVa2lzbHRaWUlNak1RQ3Rv?=
 =?utf-8?B?aVJqeWVrT3VRbEp6Y3dyaENDY05qSHdHNWJrNVc2Z09zaVJhK3AwaC91NURS?=
 =?utf-8?B?c3doRGU4Qzg3NXE0WWdjSksrK29TL0M3bVNiRkZWbFJLZDgxVk9sWmlJWG9i?=
 =?utf-8?B?ZFFNUzc1RjdxMDVtWk1GVmdBZXJJTkp1VVIwM1JhS1l4RExEcjRDK0M0R291?=
 =?utf-8?B?czEyeUlFVkRxenFCZUFJT0E1eFArbjY3ZEk1dUdVNURzek9wejN2MkpYZGVT?=
 =?utf-8?B?T1k3NS9EUVN6RjM3MmMyWS9kaFJ1YWN5c2s0V3BlQzhKMG9xc0hnVjFnOGQz?=
 =?utf-8?B?NlVILzNhODdkQ0hwYmVnQURIM1N4a1BEc3EvYk1QcGYzZmdxVDkxTnZlYWha?=
 =?utf-8?B?R0F0UTg3Qmo2dWVqTEJCQkVmN0lmL1QzZEhwczBXK2pBUDhvaVgrWTN3N2ZI?=
 =?utf-8?Q?sEknnfUAhw+QPo0TG62FY7F5H?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d28519f-a112-4803-4adb-08dcb0747a86
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 08:49:10.0435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9EvV2wZNOEYInmB4c/W+ONFQOpm6RLefn4+HVFcM4bJqkSMSwyq46znbaj/6jPEK3izFNYAsX5dy5oKH4h0wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9021

From: Peng Fan <peng.fan@nxp.com>

i.MX95 System Management Control Firmware(SCMI) manages the clock
function, it exposes PLL VCO which could support up to 5GHz rate that
exceeds UINT32_MAX. So add assigned-clock-rates-u64 support
to set rate that exceeds UINT32_MAX.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-conf.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 058420562020..684e0c0738b3 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -81,11 +81,44 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 {
 	struct of_phandle_args clkspec;
-	int rc, index = 0;
+	int rc, count, index;
 	struct clk *clk;
-	u32 rate;
+	u32 *rates __free(kfree);
+	bool rate_64 = false;
+
+	count = of_property_count_u64_elems(node, "assigned-clock-rates-u64");
+	if (count <= 0) {
+		count = of_property_count_u32_elems(node, "assigned-clock-rates");
+		if (count <= 0)
+			return 0;
+
+		rates = kcalloc(count, sizeof(u32), GFP_KERNEL);
+		if (!rates)
+			return -ENOMEM;
+		rc = of_property_read_variable_u32_array(node,
+							 "assigned-clock-rates",
+							 rates,
+							 1, count);
+	} else {
+		rates = kcalloc(count, sizeof(u64), GFP_KERNEL);
+		if (!rates)
+			return -ENOMEM;
+		rc = of_property_read_variable_u64_array(node,
+							 "assigned-clock-rates-u64",
+							 (u64 *)rates,
+							 1, count);
+		rate_64 = true;
+	}
+
+
+	for (index = 0; index < count; index++) {
+		unsigned long rate;
+
+		if (rate_64)
+			rate = ((u64 *)rates)[index];
+		else
+			rate = rates[index];
 
-	of_property_for_each_u32(node, "assigned-clock-rates", rate) {
 		if (rate) {
 			rc = of_parse_phandle_with_args(node, "assigned-clocks",
 					"#clock-cells",	index, &clkspec);
@@ -112,12 +145,11 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 
 			rc = clk_set_rate(clk, rate);
 			if (rc < 0)
-				pr_err("clk: couldn't set %s clk rate to %u (%d), current rate: %lu\n",
+				pr_err("clk: couldn't set %s clk rate to %lu (%d), current rate: %lu\n",
 				       __clk_get_name(clk), rate, rc,
 				       clk_get_rate(clk));
 			clk_put(clk);
 		}
-		index++;
 	}
 	return 0;
 }

-- 
2.37.1


