Return-Path: <linux-kernel+bounces-312301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CBC9694BA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E8B1C22926
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5E11D6783;
	Tue,  3 Sep 2024 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WOHI8iNj"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5787015250F;
	Tue,  3 Sep 2024 07:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347342; cv=fail; b=Ee2oarH2hz/Jw2hqOkKoGKgv88PmmiYFwygtBpVrfE1NIeZ6nBUcW30Y1Ttvgf6F0qdW1uaN5K2x+pBHD8eAemJ6Hk9cpuQcil1z5e222U3F3rgGO7zUX0sB/BiIjJvmtL5JtuvaVcN2/HTa80ye2SKrM5TzAYeA6XCyQeMa2Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347342; c=relaxed/simple;
	bh=xkHGYmcFI6SVvhkiP8/De6xfCNO6X3cbMEqNo+AnNdA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=r2qkczM7uVdmcr9KzitIxTxb28uhgCbFNAK4Mh2slPhzkk4PHHUbs5zTWlc3Y3daplEWCKEQls8R2X1z00FPXAlvMvqIkO/8czlZl7buBL6ua1P0PSh/yWhfTr2PyJCbli1oXgH5dXngQc4K4CxcQ/bRAfXSo+2ZSolAGs+NLkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WOHI8iNj; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQImke7T5FClV5esAIybO43U6rT8MQmItREwoM5mPNQiq+rzLDWDEmYI+nQOjI8t39HSnzBM26ixoEHk9v1G14hORuTkJYwfIwIrtHN2KvoGMc6cKbJnpTsXJ69i26t715X8m0t8FOCGQykdXxWPat2EGGYEssI3N7ZuM36IwmW+NV9fYgArRQX4cKwtQMVeTToyHYg97QJFZRm4CqmSyewnEmy0gHzFoT9iMCyRPeiYYOX8c2Kv+LC4aZlCYQuRZ0ENHxvKZ+u8klpDdcqGbM/cnzU4/T564QMByTfBtZwPdNwh0K54I0ud1F8LQvBZm5y/eYpwsGEiDq6N+u/FrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tqBRsE3Ro6qvE1riAsy0AlQCcPkVXaMgf+z28T0e7w=;
 b=sIrt/6FVeuasc9ksvkN6EOshFz5iRQlWY41dz4Blth7P2+nK6ba5xkHbwQvm2M5J++FnBD4ipViCAJYbNGJN/08GwhLWOqAHPZScTo2IR3hNpvbaB9o6BQLckQOeo68lfraC0oelV5jwUkIyL5t4dddBD9cBQOVcAPIFUGspK4f+4UpNtuMJibDyDSqsP9VshQuZ9e2EahiOHbOGq7YjFnCS4EazBZVmQRMnU6I+c6azu69bMT8k7aXEL/5j1gywQD4FN53KIkfrnwj6eBztNwGmZHjWXZLHbTJT0ycxSRqOZ4pxIhXtsfhHlr9Wrv+3Kcq4UlifoUdDGrCs0w+3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tqBRsE3Ro6qvE1riAsy0AlQCcPkVXaMgf+z28T0e7w=;
 b=WOHI8iNjU+x/JXUXzb+51IXrXFo7y1o0XiNe5/f8gzZbCtqSDiMFk9xTBDxPnS47e/AypTK16QJhmYluqKbU/NWftYZg6/rlN80R5+koG3OnqjWblPVnyjRdooBSRw+mjJwWvHoHybRhYW3SlI9MjFbrh5BzIlPXfuTvWbcwnaQM9VJyR9pARmPmSnMX3v7NK51/oAl5H9tMW0Y/SdEdSZ+hQwmOTsqHWDLbEsKtx66VNi+AvdicR0OuBrz5wLavrCQU+Ql2I6dj5HkE6mYC+0vQWI8eg8WHeNIibavM811wlFBVkUqAF30X1wK6oT2940Fq1FpZuVEcisF92R1zqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9365.eurprd04.prod.outlook.com (2603:10a6:102:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:08:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:08:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/7] arm64: dts: freescale: imx95: add various nodes
Date: Tue, 03 Sep 2024 15:17:45 +0800
Message-Id: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABm41mYC/3XMQQ6DIBCF4auYWXcaILZKV96jcYE41FmIBgy1M
 dy91H2X/0ved0CkwBThUR0QKHHkxZdQlwrsZPyLkMfSoISqhRYKed71Dcctoqc3umFojdXOGtl
 C+ayBHO+n9+xLTxy3JXxOPsnf+k9KEgUa6Rrduto19b3z+3q1ywx9zvkLVFXSbqgAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725347874; l=1296;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xkHGYmcFI6SVvhkiP8/De6xfCNO6X3cbMEqNo+AnNdA=;
 b=AGl5JS+LrcQFB7UBc6ZOFfYQkZYUQW3DNh5BqkjhtmzzyuxDI3ZLWx0pE1YWIWs+/OxW/7v4H
 RHax+LtCQKMAkr0TJ/LqWKfZTAh2BcaDYWx3NBWs5taaf/c3L77H21u
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9365:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b4d850-9d02-46ad-1eb7-08dccbe746c8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG5yUjQ5TytLOS9DY2lXekp4eU9JR1R1STlqUWc0MUpqdlErQVZhWDg5UEdL?=
 =?utf-8?B?ai94S1UxbXlvMHBLVjdQdXR5OStUamZIMnJvZTVDZ1ZwQm5qalBYZjdJaVBH?=
 =?utf-8?B?TjYvenlnSVFud2E1RFFXS0hQVUc0STlQVVhFaDBKc3ROY0s0eHBiZUlwMTAx?=
 =?utf-8?B?NDBvZTRUUmMwNW5iQlZ1eFd4aW8rTjNqNFcveVdQemErU1l1ZndlaWxVYjEx?=
 =?utf-8?B?SkZ3cHVVZm80NHBqejI0UEJpOS9qSU82WEZtTjlVRzN2R1lKSnI2ZTRBbDBI?=
 =?utf-8?B?eklYbjlTakhRZm41bWdqOGhxWVNBSzRiQnRnSDJRT2JVdytPYW12SE1oR0Ux?=
 =?utf-8?B?VVV2UTU2dVVrczk2alRYN1V5RnNCb1ltQ25xczF2cU1uTkdZcEVHdjIwSlBL?=
 =?utf-8?B?U252bTF5cFFzM2dxR0RsN21qeHFWWUo1ZGFWUzN1TG9ITzhnQ3ZYNERaeDBj?=
 =?utf-8?B?RGJ6NTJFd1dPc21OeUVwc01mcUZZT1FodzdnazJBWWdqbzh3ZWF3ZWphYzBm?=
 =?utf-8?B?RXpIWFVUbXVmWk1iOEZQL3A3djZJVjRGclBPSjNHUnlyYi9lbGFKZG1qN1Zy?=
 =?utf-8?B?UytEanA2bkJmZDdkU1Q5K3d1czdlOE9CQXRFWUxyWXArbEhPNWFEVGpPcS9y?=
 =?utf-8?B?OEV5ZjFWcmZVRTh3L2pIWmhxMTdDU2s2SExMSXZTZVJLNFduaC9WcFZWaDN6?=
 =?utf-8?B?Q1NnaGhNUUpEVHl2UWpzaWlPeEVXYnIvUDJoMUhacnFxSHNrQTRPWFFXRGZ0?=
 =?utf-8?B?TTVsRE0zazA4VW4rbFlxNzg0V1ovUXppNERtQ0sxbzFXSFJmOXk5Um1LcktW?=
 =?utf-8?B?UnVRdmV1a1BqK2tDdnRvbS9FcXF6djVJQmNiVllUR2lLVDZON2VpQVdkQUlW?=
 =?utf-8?B?WnpPNzdFZEphcldZQW9uNnR6RlE4L0huczZSOEt1LytTaExJU282dS9wUzMv?=
 =?utf-8?B?dnZYL3BrQU9CbU1QbTNHbjBiNUI5MW5pa1VVQ204K252MDlJMnBBNk93YVUy?=
 =?utf-8?B?UWNnWHVDYkJ3YmdqZDJlRFdtamRuaUNBNGhzNHdiK0hCbkFZRVIyMWFSczVL?=
 =?utf-8?B?OXJNeUd0dlFadlpQTFRKVzgxUTFNeG1nSXhBM1luTHZDMlg0THJhc3liRWVU?=
 =?utf-8?B?YXN4ZE1aR3RkaDRxMTV2U2hnQ1prQXlrRlA3aWpvTTFBL1FTa2RBMW4xcnJF?=
 =?utf-8?B?eTBFaDhaclFibTIzU29IeGwyZGdWck1oR2tXSDNZbzVrWWVKdlUvMm1Nckkv?=
 =?utf-8?B?aGhBZGFJWHo1TGhTM283am9xK3dtdmlkdmp3aEZWYjBYUDlwUnQyaGRQQWhw?=
 =?utf-8?B?TWF4VlRjMVY0R2RYYnFZVDdHSkxXWWsyTXFPMWxvQitkVTBTbWVXRUQ5OWRU?=
 =?utf-8?B?ekNPY0gxeHRMdDh2eURKQzdLMHRhMzcxdmdsZDVVaHFTdkQvNGEzSDlMdk5Y?=
 =?utf-8?B?WHVDbS9NWU9PdEI2TzZzaXJDeGM2cVYwWVE1MUZYQlpERTBsZ2Nsb0F5N2oz?=
 =?utf-8?B?Ums1N1R6c25RdWVKSFlTVWhFTTl6Z3ZRZHhVcWE2SkY2VS8yS0NUMGFFUlJZ?=
 =?utf-8?B?UU9uSU5pb3ZVTGdueXAyaTN2b04zNC9FVUplV2NkWVp0bHpaWE9XcjFra2RC?=
 =?utf-8?B?RlpaSnA2UG9lUUwvc2FxWFltYk9LYnZOMmc0a0ZINnZqWGZ3djc4MUtLSXhq?=
 =?utf-8?B?cHdXcFBwQlZiRnQzNXk1dmlpSk1sY04yYlIxenVvbTBDM3VpOXZJWFJZRnlV?=
 =?utf-8?B?NFhmQ1JvTHFjT21OQlM3WEw3TmxlbDhlcWlJTUtUQm44cU5HZUpPajIrQUtZ?=
 =?utf-8?B?eittMFZIYXpsSmlTcXNwSjd0VG0yWk5oRWsrQjdNSTU2WE82OHptNEtkSWdK?=
 =?utf-8?B?dUJCNC9BZW95YTh2eFVWVjlEWExhK0JyY3dYRWdiVDFJM0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVFwTUxFL3dzUW5WQStTazBFaFNleEZHSmczcU1aYnRmc0xXQ3pGU1g2eGdi?=
 =?utf-8?B?OXE1a1BxT0hTSTJlb3dtejNYNHFKZ0RoOVZ5OWZrdEpoNUlnKzRUL055MXJp?=
 =?utf-8?B?QTA5dE5yb2dKVzlDV0hWcStkc1FSd2VNK0VDUy9nUldMUEN1ampubXplSm1X?=
 =?utf-8?B?ejd1MWJvKzdRckNSVHVHc290ZFpTMitXK2RMY0VZYTNPMk01RGJidWRUYUZE?=
 =?utf-8?B?cG1LZnZHQjI0czN3MEFzQjZJcGFOZGZGMGhlcEpmK3dESUwrWEVLQzRpTEI2?=
 =?utf-8?B?dklta1A1elJxYVNFVjlGQjdSeG5iWHVhNzBzdEx4Q09lM21IeTkzaWVURCtr?=
 =?utf-8?B?ai9hY3MwSnE5MTYyRXYzVXFkRjNrOU5zRThYV3BKeGZmTENxVkQ5eWdDWmwr?=
 =?utf-8?B?MW9nOTFzNVlIRFpXeTNPNG5Uc09MY2t4cW1sdCtyczg5MlVDT2Q2cGdVU3dj?=
 =?utf-8?B?dldDNThRMXoxcVZsdlZwWGJvekpDMDJuVkQ2RkQ4allZcWZLU2xVRFhCN0pj?=
 =?utf-8?B?bmpCUk9ZR2tGdXY1MklkWk9aRE5rQ2IzZUJxS3Vtc1NxcmIyM0tLWWZVQjlD?=
 =?utf-8?B?dDJyWkRGanJ5bmNwdCtibFlPS3hKTEQ0R2l2ZEttOSszS1FmZGFwSEQxWTAv?=
 =?utf-8?B?ZWtuK0hlSjQyN1Q1RlBTdkFpYW8ydk51ZTd5SHA2TldZU0JOTUw5RFZYcWJW?=
 =?utf-8?B?MDRKVXo1MzlOTG1RQmdHNHhSdzJ6M1JXOC9ZRncxNytPeFk3Z2hHTVJ0Qi9O?=
 =?utf-8?B?S2swSWVCOU5lTzh3Zm5ya1p3eFlHa0FBaUNBZU9MRkl2UDZiRUIrTzhnSnFn?=
 =?utf-8?B?cFBwcnpoU0NkWEVsVTBzQk9LTWtxd1kvbFB6QnNsbExLRS9kNGo2QVdmT2ky?=
 =?utf-8?B?UmtSSDlPVDRGdGZSSmI4akxUKzFyc0pCSG5UNmNFZkJjdmJ2M0NGWWlrSFZq?=
 =?utf-8?B?KzZtZHF1RkErczFUOHhRVmR5SThaN3BiSVNJS2RCWXpONlg1MGI2MEhuK0Rz?=
 =?utf-8?B?Vk9UeVJ5SldBY0ZsTHBVZTJXRk56YjdlRjBGcytiaXBZbU4zaDRKaU5UeEtT?=
 =?utf-8?B?TmhwUUwrZ3RqVG9IYUJQVHlDYnNYN21saHcybU1wTkdJYW54MEFzNXJyQ3R6?=
 =?utf-8?B?aTBIRUh2WkZMRVh5WUNjZXFhY2R5QVc5VTVyUFhlc2R3d3dkZ295NVYvUVA0?=
 =?utf-8?B?b1dla1pBeTB4c0tFNzdpTThKUGg0Uk9qWGh2d3hiUGtxM3NlZWlRdHZJQ3ly?=
 =?utf-8?B?T1h3UFNPN3ZBaUF3cnFtbHhYYURhMkp5YkluTmlrVWpkVWRtbDJLRFJZY2VE?=
 =?utf-8?B?RW1NbGZWOWQ2YlpjS0dBVWRCYys0WTZ0WVl0SXFWR0ZkRmZYZVFTMW1BdDVY?=
 =?utf-8?B?VVBBNGc0WUJRTVF6QnpXMU83aDFoU3liYnZCSGFaOXprK2diQmFZeG9pNnFK?=
 =?utf-8?B?Wkc1TFc2Z2oxM0ZxQkZsM3RvODlKVlYwQVZpTndKODFaUlJiaVVYWkN6L0Jw?=
 =?utf-8?B?b1VHaTMrN2ZwMUMyQmcxNHNQY1pYTUNXU0pWeHlkOGJqYVJEbVVhbjRGemJL?=
 =?utf-8?B?ODFDdWYyV2lGTjJlMmtySDFxOEttcVptVEswemJORlZUT25mL0dkRkp5V094?=
 =?utf-8?B?RzFoTlJFbENvd0pGdFNYT2M5c2dUa3k3ZFNQakJlaW5XcUQ5L1pUZ3EycFAw?=
 =?utf-8?B?ZC9kSldMOStoYkZvWFFuZFJOb2dOY3dHRjdzYmJ4MGFFNkU1VWt6d3ZrNXN2?=
 =?utf-8?B?RTIvT2s5TTdyNEE3alRjVVRMQ0JVSjAvS1VrVjNBbDVwQ0pjNmg1dzUraFI1?=
 =?utf-8?B?VkYvNzJaZ0ZWeXFIMVZRZ1lDeG90VnB4ZmRUN0NvS3Jyb2RuK2k4UlVFdW1u?=
 =?utf-8?B?RXEyZ3ZrdkREb0VkR0JkWXcwcFRUZnNvN3BZdUN4bFllYjVwTDZZclROY0px?=
 =?utf-8?B?RFRvbjRMbEJnL00xL1JsVy8zTTMzYlo3bnViV0RnU3I4NzR1SHlYbUVDVGdq?=
 =?utf-8?B?SXVhVEFiYkRJdjVybWpldVdsT3loTmFjRnlMelBTT3kxMVdhbGF3UmpuSFJ1?=
 =?utf-8?B?T1pzYU9mUWNKNWxsaEVodnJnRWQyYXBRakRZc2xMeDMvOFlkOHpuSDEyR1NZ?=
 =?utf-8?Q?tkBHmn5cAC5e2BTvkIb7CxTdM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b4d850-9d02-46ad-1eb7-08dccbe746c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:08:56.7322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZgTRKVK0WTtjuvUFOGxzI5yu4+VKT612lm0xtV0YQYnLmiZdDEra27C4dsirNirm/6M7dPUiVxPtfcdr7sBxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9365

Per scmi binding doc update and i.MX extenstion supported, add the nodes
in imx95.dtsi.
Enable cpuidle for A55
Add anamix temperature thermal zone
Add lpi2c[5,6] i2c nodes and sub-nodes

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Use generic node name "gpio" for gpio controller in patch 7
- Link to v1: https://lore.kernel.org/r/20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com

---
Peng Fan (7):
      arm64: dts: freescale: imx95: set max-rx-timeout-ms
      arm64: dts: freescale: imx95: add bbm/misc/syspower scmi nodes
      arm64: dts: freescale: imx95: update a55 thermal trip points
      arm64: dts: freescale: imx95: add anamix temperature thermal zone and cooling node
      arm64: dts: freescale: imx95: enable A55 cpuidle
      arm64: dts: freescale: imx95-19x19-evk: add nxp,ctrl-ids property
      arm64: dts: freescale: imx95-19x19-evk: add lpi2c[5,6] and sub-nodes

 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 86 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi          | 69 +++++++++++++++++-
 2 files changed, 153 insertions(+), 2 deletions(-)
---
base-commit: 985bf40edf4343dcb04c33f58b40b4a85c1776d4
change-id: 20240902-imx95-dts-new-fbb8ac9fca18

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


