Return-Path: <linux-kernel+bounces-250862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D301E92FDBE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895DE285490
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315C717333C;
	Fri, 12 Jul 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lLQoJ0ji"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B7F174EC3;
	Fri, 12 Jul 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798860; cv=fail; b=UR0iPpSAegpRZsS7oPYks+I07GSO10+ZFmpre796r4k82M99RPDVRXNsm8NiQKI1HZXzrly6kxw71VWH4rqek8xO2q/r6+G4hbhDXEb9Jq+8TLAu0RhcgCJRWPhnZgpyMJPqLo9CoBXOJ67UVdz1htMWOBWtZbtcOsYRb06XphM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798860; c=relaxed/simple;
	bh=SaIf7opiJAmqwuDjaWgawxfzMs2af1K+IOLeH2hYimQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Hhfh39HMYS5bRkvq2KVg0RJTvaWifr4MniZIgdWmICg4fJWqAWJskkreZtCgH8hJpgfkU9vmJ65cavFlNs8cs83AJo1x1mWNmP9tlyOzbSXPdNTEdKVWRAplCV/0a8Jmb+bKRPRwR47Mo/YIBLwOZa3YyuEtCHPKErmsdwc9nB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lLQoJ0ji; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2QKoJKzUWiUy4hV/aY59PwvLM/lYQSj4gq2n/lczz2wezQQohwVIruXXhKrvQ1fQ6/kXA4jwbzj8Lcz2Fyljcqp/NzJj296v9WHfLYMSGwH8hoycg0wcRcqA2vI9ES3O43ylmm5BuZ4ycCKP2fm9Eze608pHHYTdwe+JynXLu1fJukq5C+/t8gzBCeIk0TrYNUO3alFfgHITx+GtNINlzTBrN1kcXIciDGV9OwXJJ+RZIwZSO1hAF/Txfr21yeM7cW+3R0knN3Z92sbUmogCOg8AHsMe2Gc7reMsSAFCp7ZU6+179rViVyrDiBgG32ZN6OaxPloIZAzu3mVEJdlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D98Q488QXdfIcWQyu4qXDVPKVoYkyj7k42xNKXurkNE=;
 b=n5X9Kfy2e39vpdZx/dQqF6ozYN/k8zGGE1CfA1abPweoE2K5eSFhsautzs7chYcfwHk+kVNvL9cgEw127Db1xmeBRnoRf2/Nm8ZiB0CXIZs85pM6rOFPJcXXPhsODK67jHY+SKwmCSYOqCubT2PjOXuuB5f3bYONw1Xmal5Yx3NW7IOs9vtlXnmy5Q6NzH2WXhOG3b80ZOmg4snGLOdwAi0RpHhvqqTtuoIAAaQTHNLdpiG16RIg9hQP9VgRIo/31nEM5lN0Mi+Mbycnmlb5+YiVV2Ly8FZdtJhZZWziQD8wv9eurKWwZYw46ltarbJJBNttedPbMzsWwXHSX3x8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D98Q488QXdfIcWQyu4qXDVPKVoYkyj7k42xNKXurkNE=;
 b=lLQoJ0jiAw+muC+GYjENIRkkXr4rDBCZLvLOnqBSbrjDC+B+sY1jIxcQzRvUl3Qy0fI+lya0BOUCywOWSMvus2k4Rco8F7x+69aG7787tTBWMhBqdZRwczkiTDwdrSWANb7ei6UydLJYGAynp+VZpzUns5jqdgjOR6W1Mlm6hwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9803.eurprd04.prod.outlook.com (2603:10a6:150:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 15:40:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 15:40:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 12 Jul 2024 11:40:28 -0400
Subject: [PATCH 2/4] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-dwc-mp-v1-2-295e5c4e3ec9@nxp.com>
References: <20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com>
In-Reply-To: <20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720798845; l=1434;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SaIf7opiJAmqwuDjaWgawxfzMs2af1K+IOLeH2hYimQ=;
 b=XUIe+D14hdDTmZ+zis/snwDeLUqSU7Y9rxKU+o4r6ko0CpCmB/Jv6fn+yDkpUd0EblD5H6Vdk
 WZpzmK1905cBcYnf/lxuWHlOg5uZFQBIiPtXLrTmiUfXWQqiatFllmB
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: b700ad6b-fc58-475d-2401-08dca28904d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXJPWm9XenhHMnFvNy9ockVtVWRhamFYdXBtY05yQ0hlRGZVVS9QbGZiWkNh?=
 =?utf-8?B?OVNRNGIzQ0gzYUpuWW03TFYrWHVLZVQ3cytKQWJ0MGFtNnFlMnRVN1kvc1dp?=
 =?utf-8?B?Rk8vMlpNVEZSenZZWkt4em5Hc3poR3BLMlUrR0ZWRCs0Nm8wc3VRQVA2UU5T?=
 =?utf-8?B?dlBZZi9TZ0FCajBoWlZOcEVLSU1GZnlFaUdBMHNaVDJBZUEwbE5HaXFyNkpJ?=
 =?utf-8?B?YjV5OUNTenJoK2tmcmhMYjVhVW9JZmlYR3dpVEo0NXlqK3ZKVlZzdU5Fb2tV?=
 =?utf-8?B?VXQyMjRpTU5yckl2NXd4dE5nVkpWTHhTeGptZ1djRjlPYmE3VDVUbll4TWty?=
 =?utf-8?B?ZTF3elZ2d0Q4NmZXK1VqeXNJdStCZmoyajdaVWRyZ0ExQ1gwMkd6TkZETjBx?=
 =?utf-8?B?aEV5Y2hrUTdUaU5OakV1aElwa2laZVRNVDU5MW03TFlNVnVlditEZG1oU2JL?=
 =?utf-8?B?aGwwVWxsNXhyUHlIN3Q3Z2trQnFwVzNFUlhES1dtaFBHUkdyRXNybkdIRWc5?=
 =?utf-8?B?U3lZUnlIYVdFdDJYbDhqNEYycElxNWY5N25SNm1IZi9uT0ZvOVUxNmVnQ0hq?=
 =?utf-8?B?K0kwZzlaT3RVUUlKNjdCNnZxYXF4MG1qNEtaVnREOGVoK0hrYVhLNWJlOHFP?=
 =?utf-8?B?NGtBclRZOGg1K0FDQ2pzYXdoK0dERnV3eEdrMDg5dHhRWXlTMnQyY0VPR1pZ?=
 =?utf-8?B?ZDh4cjNDYW1pWm9UNE55MWdMMDY1Z0UzcUk1cHViNDdwbmdKQUloY3JrVnMv?=
 =?utf-8?B?T21qNURNditJOWU5dnNpN1RFMElDNHRzTzBCMDd0NUZjR3VQaUNHY1dmaUJR?=
 =?utf-8?B?U3RYWi80ck13cUFLOWs3QUpoWmMrS3hUQlZlY3pVQjl3UFhJQVczeWNhYkll?=
 =?utf-8?B?V1QzOVUxejVCVWxObEs5dEp5T0lCQzA4YkViR0d5Y3RnZzlNV2ZLTnlkNW56?=
 =?utf-8?B?dnBmbHVoTXVKQkZDd3pzMHRwNWFsYVVSSURHQlYvSCtJekJJVVRQTmdKMzBW?=
 =?utf-8?B?aVFkaDJVRnljSGNyVVYzODFaczNFYVNRUEhBMVJQKzc3N0RuQ1BueFFCWndS?=
 =?utf-8?B?WDZWK0xCb05kQVVXRlJqZWF4eXFabHlLN2ZqNExMWm9XNXAxWnRHcnlOSjFU?=
 =?utf-8?B?VGJROGt6RVdoY2FPYU9VYVUyM0g1cjEyNE9wTTZhTFlySEtqZTJzdm1ScEJQ?=
 =?utf-8?B?d0pMTVBlVUcvbWhDSFBCejREV2FUdXVtRm9Bc2x2N0R3U3A2dVkxU0ZqZzFa?=
 =?utf-8?B?TGVabmhlMnJaNndGT2gzUGdYSEdxSFhWOEZjeEdoQnQxQWM4OTJuRG0xREhB?=
 =?utf-8?B?TjN3cFN3ajR2SEIzL254UzFlaFRhaXlVTGRxNklZSElWaTdGZXNtTkd3S3pt?=
 =?utf-8?B?RmJBQzk3czJTQXQ3OVJ0cTFrOTdsZy9qVWtTSWV2RmZBd0o4eEMxbm1uZldt?=
 =?utf-8?B?bFhDSmxtVXNjYkJxQnRoSEQwS00yKzR4a0xvNFR3bUFvLzdzSURWNzJseDFQ?=
 =?utf-8?B?MVBaRmxPL0hRT1hwNGJ5c2wxZ0dEREVPdTB4ZGpQVDk3bThkWTFha3hnd2NJ?=
 =?utf-8?B?T2FkRzAzbGNFODNkRjZYSW1qZkNEdGVYRmdHeHRIck44T1hhb3NmNEJSNUJL?=
 =?utf-8?B?TTBadzFkR0oreGR6MHBqeWt2UDhIbFNsdkNyZyt1T1p5RGI2c21WeWZqNFFx?=
 =?utf-8?B?UmtPZUMwMWtoRXZVRkE1Zmo3NDZMNjJoSlhrVXVBSTFRQldyOUx1cGQ5ZUtE?=
 =?utf-8?B?S1YxVi9MYmIyakNjSDBIK2dLZ1R1N0QrNXRQZFc0QUN2ZFBDWG1FTUlpWXM4?=
 =?utf-8?B?Z1d1bDNMRHpVR1lhWEVtd3g3cmcvd3dpY3hwQ0NWNEZCNEdlQWM2ZzcvTHgz?=
 =?utf-8?B?N0JUZERmUllBSHpBUEtqbVN4bm5KZ0FiVHg5N293UVB0M0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHVCV2JyVXY1a21DQ0lyeisrYmMvcWdwWkJVaTdmeDV3ajNqQnl3TUIxaElG?=
 =?utf-8?B?Z2J4aG5iRDZmYlhiTUdyQUpkVXZWK2tzMGE3TVM5dklBS3BYcm11WTZXZlRa?=
 =?utf-8?B?L1RqaXJqTlJzUUIzUnkyZCtkcEZCbWh3NER1bnAvSzZMU3IzOHhJRldCdjNP?=
 =?utf-8?B?dXVZQ0h2dVRseEFqL2QzelhrcDF6b3RrV2QvQTNGL0FnMEZYYmZZQ2VyRmhj?=
 =?utf-8?B?L09BeDBRNnBOcm10b1RmOGNXL0lmUXRRQUJnN24yMGozaklUbVc3c0NvVVA5?=
 =?utf-8?B?aUFMV0tLYUdzTHVhN2hEYXhzeGJ3cEJQc3gxQkF2ckZwUFdYY3pOOWNCeXBk?=
 =?utf-8?B?Q1V3NXg0QjRjL1RvRFJaNGdsTUtoYTI1VkNIZERvcnVMSTFrdDFIZmlRbnhs?=
 =?utf-8?B?dThYdVRPMjhGSExiYStQVDRScUpBNFZ1ZEs1VHJMa1BRS0hESDdnTm1VcE9p?=
 =?utf-8?B?dy9DWloyanh5T2JOVXhhRUtldHZEdU11LzNEUS9BU3REOFQwSU0vQklxVTc1?=
 =?utf-8?B?WGZJdER0MkZVOFByMEoxbTkxODByWjY2cElid3dpYjZoa3dXSXVabGpTVklR?=
 =?utf-8?B?VHJRbTFSQm1NRlNpb2hzRmkyTjJwTUs0a2NoWmUvR0xMMjlVcnZmRGYzRm9X?=
 =?utf-8?B?UlBwVmdNekpVeEhkV1BXK1UrMXJVbW1wbGpSUlYxU2REL2JBeC94TG13WGh3?=
 =?utf-8?B?YlZCKytoNHlERW9mMHQ1dGlQVGh0MCtPYUl0SmRQdnU1aERiS1Z2YmIzemhH?=
 =?utf-8?B?WG02a1piK2tacXE4bnNuV2k2TFM0Z2RXYVhnRWpOYUVOcUlmWENidFVEVm51?=
 =?utf-8?B?UFdxa3FYNTJ2OUZnNk40NXZuN0xmUXRQKzU1cTFVSlA0K0ZCek9VQ25SdThh?=
 =?utf-8?B?Wno0cVRHWHFLRkNkR0l2SkFzb0xRWElPdUJUUlppQ3JVUHh2bzNIRHdPUW5K?=
 =?utf-8?B?TUlnNjRFZklWZ0t5YnNZNWp3TzAxK0JKZkdKbzlYNHB6ckc4cG1wb1l4a3dW?=
 =?utf-8?B?dHpkbTUyUU1oNFhDcDhJTmwreHlRaStoYVAyLytiUDVJSm9uMHQyUklncVZJ?=
 =?utf-8?B?OEhpOXVOR2pBWFBpU3RQNlpMeS9aN3V1RnJYTE5FK25pVGdrZUhOYVFaNXlw?=
 =?utf-8?B?VHVMZnFrQkZpdzNpRUlVQTB4bEN2ckVrSXF0NWx3Q1NuSnY3S2kvVGxJb214?=
 =?utf-8?B?WVlwbTkvc3czUWh3SzNJZVZXZG1aVkhFakk1bWtKdFRleVhyeGFZSWsvTzhi?=
 =?utf-8?B?NTZtWUVGcy81WkVRSGNVajNuL3RIdnB0ME9Rb0ZUd3YyL1ptSFpVYmU4YTlQ?=
 =?utf-8?B?dDlrM2JLYUFScHVPOXJ2UkZROHFJMEZqVGNMN1hsV2M2OHVHMXhRYzFOWEs1?=
 =?utf-8?B?VDM4S2xXVzhQSFg5TDVDUUdiUmkyU0NGbFBvbHowTENTS0F1MytDajJPR1Nv?=
 =?utf-8?B?Q3huT3lXWU9Fb0dBTnIvRE9yZDk5aURZSWRQVUVNeXVmMTdGVVZvQ3JGMjh3?=
 =?utf-8?B?aVF5eXJhTWE1Zk55azd1NGY3Mkg0NTAvYzY3MU9YMzFiOG1kUnNHUzFSRFQv?=
 =?utf-8?B?RExKbDMxaExndnUzS1ZyUFBCQkJGYnhQcHo3bUUvcHNFMklrN1Q1NEd3SU8w?=
 =?utf-8?B?YWZranNyR2hCY2FnM2NXcVA3cnpCLysrSXZXNW9YM3VudVEzOWZXRFpqTGw0?=
 =?utf-8?B?YWtjeXhMNG5WU0czdDFVK1FDK1Rvc0hiZmpVY3EzbVRmd0l2Tm5vR2VGMFJ1?=
 =?utf-8?B?MUVQdmxEQ0RKa3NzSHFXODJYelg5cG5sNS81OEZaQzdRZFB5RERtTDV1NnJI?=
 =?utf-8?B?UXBmY1BLUWJQcklmanB2VGV0M3NXeG8zTmJTS1FlQncza2lNRzIwamVwU2V3?=
 =?utf-8?B?RzFzeTdyT3VnYllkdGVoTmVXb0xUK0tGdmo2bmxzc3JRUG50S0RkaGZIcDZR?=
 =?utf-8?B?WDVLb2QyZlM0YldhZy84MlJWS2xxQXE3bnc1RXBjaHlhaU5odk1pL2NKajdz?=
 =?utf-8?B?MVc0c3lVems5ZjdZSkZTS09DOG5IOHpic1NFTDZxd2tFK1RLWW5hRDhJWGNF?=
 =?utf-8?B?RERTOVJqUlBmNEh0MmRoNVYrSW1PZlJRbko4SjNDUmNmUk9sbzUrZlBuVXpn?=
 =?utf-8?Q?cXyFwLI3/PEndrkpat10HsyZA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b700ad6b-fc58-475d-2401-08dca28904d1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 15:40:55.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAfXYKQp8v7KexhFTrwNBS8GJCNuYWA2gTaM6Qd17RG0zkfauT2OxGk3SOV9PfgB5wYY08iZye27QsD7kcmk6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9803

Add 2 software manage quirk properites (xhci-missing-cas-quirk and
xhci-skip-phy-init-quirk) for xhci host.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 8ee4480685031..5794bb75f7604 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -144,6 +144,17 @@ static irqreturn_t dwc3_imx8mp_interrupt(int irq, void *_dwc3_imx)
 	return IRQ_HANDLED;
 }
 
+static int dwc3_imx8mp_set_software_node(struct device *dev)
+{
+	struct property_entry props[3] = {};
+	int prop_idx = 0;
+
+	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-missing-cas-quirk");
+	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-skip-phy-init-quirk");
+
+	return device_create_managed_software_node(dev, props, NULL);
+}
+
 static int dwc3_imx8mp_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
@@ -226,6 +237,13 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 		goto disable_rpm;
 	}
 
+	err = dwc3_imx8mp_set_software_node(dev);
+	if (err) {
+		err = -ENODEV;
+		dev_err(dev, "failed to create software node\n");
+		goto disable_rpm;
+	}
+
 	err = of_platform_populate(node, NULL, NULL, dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to create dwc3 core\n");

-- 
2.34.1


