Return-Path: <linux-kernel+bounces-236516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA9E91E34A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4423B27074
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CBF16CD01;
	Mon,  1 Jul 2024 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nngrLQW8"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569016DC13;
	Mon,  1 Jul 2024 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846246; cv=fail; b=g+4JCIz1S9uEMQiYXOCOjUJVPP2cL78HgRKeiC41AVwE5Mo3j3HdaGy5sjA/yKoujJUQrwzHsPCbP5Nn+jrmgF7qTxTu2El9hpIudS4n7Ky2Q68aNBmwFMx9qbBC5J4xSbKsUpknZgaHGrFDCBYzLxtXfJy8CsESbOLBGdyExyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846246; c=relaxed/simple;
	bh=GyyQFBwQxEU9iU2kiD5JCDDv7dPwtt10eTEDTb0pmFw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=B/97Py6oTYDv4FxWCh48J1Bzo1AhH733y+hJ0cHqX6OEfamJ8aeTbJ0dcCOiU5kVVh7KqiBRuV0dU/mgUUrCQu7TYR9DnFkLP7P+JUhczJvmBqvJegXS5xCDtlZbG8jPWqLt5UM7aFws8KP+DXjaDMm/tOweiCCL+4uEJv8f/nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nngrLQW8; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJ0her2WLgrCw7l1uUEfKY7lzIz9LuozwqTvh1ahsvIWMywLIBbq/gH1p85ATQXvm3K8Ww5JSa6bmo6R7eIthJY7NmOM45b5qRawpXCrjwHJ65db7kkryTuOiW51V+gbtHowVxKG7D1+cUqYVu9t2sooqcIE5f9kJTSYC0H0pXu9gGzsU+oOyPGvsaYWZmcYR4XBdEVbJa8YQAIpecdNbqcPmy0dqyHZ5XmWH0RS4VpXCd0oITF9WYbJnjGSw/hN473FRks+04XXKSyhyPLIqbme0WnW4fBrmJulmbljhZYgNYrXVDVCpF8SGThVNFk37CaZJDiTGUn7nZE2KegA8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8QyXFldvojdWrKZneAZxjwtFdGbAS4u4yutJCttA14=;
 b=EcvebmKgfYUm8+9ig65F43x6Axt7ShzINZSsSUUcoeU6DJm9EyGgymwHzGfBVLt6/ASXg26Fe5yEFXfXZygEhQb8Z8ZCOdPyvWBcFhL2LREygdTzgkxlUIL7RBTe0nmCO0zM5iziftSYFqxhsSLZB3M8LU3vYAgoL7mtXS3I05BQ+N0IDceC9+R85EJE3CY/UvRWT1yu6XFOyv+E6eNBy/zj8M/u08dg5xebEAEq1yCl8DWbAVrbt6hGdDiPVvG/5eTCS3auyd3EThnC172UIb+2SfY8MvU4c0WnrAkS72gjVpt97i3GPLbHiLWsS+lOISIagoYxfEw7tgv/Nyo4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8QyXFldvojdWrKZneAZxjwtFdGbAS4u4yutJCttA14=;
 b=nngrLQW8SRLsUEkzCqm+/G+7shN11h3QtIq3T+GrxQDuIfAcHGr61gYXnt2BtovEMMWBxJbJL2Vw2fIvknk9xSyXpFzYR8VpM4OfKLiVV46KdRL/BnoHLYz9/4OuK954Y91wLaU/fYYPYbPeCkHSc/aQRC2XWtz5eeBsCo/NbwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8166.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:04:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 15:04:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Jul 2024 11:03:30 -0400
Subject: [PATCH v4 4/8] arm64: dts: imx8qm: add mipi subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-imx8qm-dts-usb-v4-4-03cdbc8c44b6@nxp.com>
References: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
In-Reply-To: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719846224; l=2369;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GyyQFBwQxEU9iU2kiD5JCDDv7dPwtt10eTEDTb0pmFw=;
 b=kbmqq9ijTWafEfx73os8VrnKWinIz05chLAPmaL+h9jw/17MTtvx7ov76j8nlBYMU+zQvskzG
 ltu+M6gjp+GBresCUB3W73mGWWzAOXd84aYzKoJd7rNOi4XLLyBsUQD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5ae241-22f7-4020-9764-08dc99df0ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGQ1VWxYYWErNG1hNW1ZMGNCUW96dXI2dnllYmN6elY0WGc2aDM2YU9ZcURS?=
 =?utf-8?B?NExYYVVHbTIwN1VHSHdFOHc4TW1DREE1K0FUYVY0VmlhaGN0Y2NyQW4welZz?=
 =?utf-8?B?ZlJ5Q0RObWdSakpyQ01OOHZiMS84aHEzc1ozbFRpME9jUkhUN2p3cWVhVzJK?=
 =?utf-8?B?OTNkY2NyK1ZNbGdNZGRScjlTTDJxeHYrcEMyWUZCU3hYb1gyZXZFdG42RXlh?=
 =?utf-8?B?MlZXcXROVjQzU2h4ejZMS1JsMEJpYlh4TzZvSGRaL0oxQitYOURoQlJqZnFx?=
 =?utf-8?B?UzZ2cUtoKzVRa0llZ01MMjB6cFhqcEgyU2g4OVFWQzJvZEdWV1lBb3VldVI1?=
 =?utf-8?B?Ni9WUmhmNkpTQXBmbVZmY1MvOXZ2bFBuQWx2WnFVUHRtK1I0WXBCdVEybWhp?=
 =?utf-8?B?U3ZnYy8xRkUyTGpXdjBvRkdMUzBOMGpoRE1wLzYva21uUUsyemhZUTJGcWVu?=
 =?utf-8?B?UUI4VzFXWEZrMk5xU09RUVRVZmU5ZW5rT0R3eG04blo5NmNkNUtYT2pGTWhq?=
 =?utf-8?B?MU9BSFpiMHNFblUvcUdZd2VnNlI1NGhVYVpOcjNrZjZ4YmhFZFJuRGFHdUho?=
 =?utf-8?B?VVpPOGpQS25MTGxMZHBNZDhYczhLQS9oYk9IL2RpdnRzOCtRN2xWK1RVVVFF?=
 =?utf-8?B?Z3JzUkV0Y3pURlFtUkw0UFFQeXo2eHEyZWV3VVdsc2Z1azlhT1BTbC9HMENn?=
 =?utf-8?B?emRIUEdHTVMrWkV0TFFGK0syRlBKTDBHbFFscHVWSlFtS2lnKzA4Qk5Ga3lm?=
 =?utf-8?B?cVBqRktQdWhCTDlYVDgvTWFFblVWNGhjd0dudXJ4QzdDZVBBOUtFNHVZMUdy?=
 =?utf-8?B?SGFDT0wrR1pWckI5bHl1OHJFczNLWkp1NTB5cndNdXp0UWVOZ0dHSnJiaTI5?=
 =?utf-8?B?WjRvN25NeFRJN1lGb1FBUXNFNktKOHJBSmgraE1PVWhCbWtZdkJhSG1tWlJj?=
 =?utf-8?B?T3QyQTFBcGJvTVpKSklKRWNyNFdzbHNXK1lBWFV6QmtWcEhzQ1ZrWGloZVI5?=
 =?utf-8?B?OWFRYWJhRmkwQ2xWNnBGZFNURGpWMDJiVnhSWHFFTTliaC9vWXQvK1V4QWJV?=
 =?utf-8?B?RUg4NUZabjIySWRpVlBsa25WdkxFandFalhseXI1WFBvNGdFOWJJazlSbDhH?=
 =?utf-8?B?NU54Ylh6bFZWWXkrMytTWFlvTkhRa0xnTGdwbytnYXlYeHRGd1RTQXV5L09K?=
 =?utf-8?B?d1o0RkR2czJvMzFoMFJ4L2FCcXc2MFd6cWRLbTQxdXNQRnErTlFSd1IrVUlr?=
 =?utf-8?B?bDQxSlJ6TGNDa2hEck9LbW1mbnlnWitOUllITitOWUxSOVBYMXVWcWs3L0Nz?=
 =?utf-8?B?MVR4TDdxb1VFYktzeTNMYjExTmpIRHVSMVJTREo1L0ZDY3ZSODZOVW1sY1VB?=
 =?utf-8?B?dUxBaHMwZnJPcE1taXQvSUFBMWFab3lTU3lpeXNNNWR4UU4rVEpkNUxMcmtX?=
 =?utf-8?B?dkdOUnAzNGc1Uy9rUmM2NnNublF3VUU1c00veDN6Q1BENWJsT28vTkFEOEF2?=
 =?utf-8?B?NjFEKzR3Uk5wbDdPMnNBVjlaMjVFRDY4NXVyeWZsWTJ4NngvOFhhMzBpMmY3?=
 =?utf-8?B?Mzd1dDlJWkJUbm9WZU1wRHFGTkRLVVA4ek96aEhlMjNEdFNwU3JTSE14OXMy?=
 =?utf-8?B?NEhuUlpac0RuQXhPSlZaTFVPS0ErK216cW8yMTcyWkpGSC96dmpWRHBsVHd0?=
 =?utf-8?B?RW1YU25IUW1zOGpBYW1HWkZScEthdnEwZUltbGtQbHZISEhxdGQ0by9vOXdN?=
 =?utf-8?B?ZnJQSVpJaFppbkRYeGJPRWNOejVZUGRiQjlhWWlsdFFmTlEreklEYnVNY3p4?=
 =?utf-8?B?SWR2QmhsdWZXY3BkdTJZbWlJMDM5aExtTXo5TTNJejZ5YSthLzhBeWZIZmFH?=
 =?utf-8?B?TG51THpRTVZhcWZJZ0p6b3VQeXMrT3ZteDQ0QVNjZXhGNkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V21tc21IQ1lVR3FNTTdZSWN3QlpvdCtFVzJEbzRaM1Z1TG9uQS9wN0pxTElr?=
 =?utf-8?B?NkJRbjdBOVU1QVdEOWVHWEFSZmxGdTYvNlJZdTZNWHhaaTRSZGtoNUJlZmJl?=
 =?utf-8?B?WlQ4RTF4YUhaM1JHUHRpZU5JSG1lTzRzUVdnMSszbHc2STdoZGllOWJUOXFH?=
 =?utf-8?B?VXMyeEFScW5uSHFROWRGQXNvd3pRMlJSNUFJWXU0eEN1WnAzamVzV1FhUE1M?=
 =?utf-8?B?YXVCRnVnVmtHZlpaWDhyWFd0YTJMZlZUYUViSVlhMHdlaUdKSlF6OXErOGFh?=
 =?utf-8?B?azFHNzM5c0M2bW9rL01VZVZIallocGFqd3Z6c1dVQXZ0c3dmdHIyMmUrVDFm?=
 =?utf-8?B?Q1FkVzYzdHgxOFZmOWZZa3BFUm8wRzFLNWRIcDVEeDRCSWsrNmlGbTkxZDNL?=
 =?utf-8?B?VVdYM1lsY21lK29yQXFXcmJUaFlROE55ME9qdFdSaGJJUTN4R1FLY1R2QXl1?=
 =?utf-8?B?cXFDUDcyVVdXbFk2NVQwb2RHOW8rVlZGbkIvZjRwMllxRUpJZlZxU1dIUXpi?=
 =?utf-8?B?STNKcEVkMnRlanFTSmprVzZ1Z1RlOGl2bmNaeEp5VU5rcGRjVTZ5NHpPdFhq?=
 =?utf-8?B?TVRtM0dWY1MrNTBqZTM2bzNDeWhHQjFtc01zU1JuS3ZXVml2MUdVL0JGdjYv?=
 =?utf-8?B?TmRPTmxOdDVsazRrSk5PMlBhbGpJbFk1QVFvV045cjloeG1mQUpIZTZMZmwv?=
 =?utf-8?B?aENoYnVrSzNGYW9PTFNVdDROdk4zTHQwTjNBa2tvWXhlL2w1cDJEYWpZQ1Jo?=
 =?utf-8?B?YUs1UmNYWmh5VnNrdDk3UkZVQnNPMmhoSjVHc3VNTXB3WEFXbU5welZyc3Vu?=
 =?utf-8?B?eW9BU0ZZcWVJd2E0b2ZGeGN1NmdVandaLzFZSUZNVTBZb0FNamtUTS9tTDVx?=
 =?utf-8?B?ZE05ZXo0SFEvdEFna2VFcnJ5ZGJSZXUxUEk1TFRJNVBzTkpFNlZIeWdKWFly?=
 =?utf-8?B?Y0M3NzRxU3lCU0EyRnFKQ3I2ZDNLL004VXlWV1JIRXhzaFIyTG9OY0NJbVUr?=
 =?utf-8?B?SEg5OVdjakdrT2dtaDFSVGNHWGc2RWlMY09pZEFhV3BhRFk0YVdWT2tMUmJC?=
 =?utf-8?B?OXJyajd2aDY2YlV6SmVSZGY3NzV0MzdNQjIvaDZKZ1o2a2RaZ3AxVE5UQ0R5?=
 =?utf-8?B?dWZaMUNFY0RUSDYwNWxJd2pHYlBpMU5QZytITkprenJRWnRFblZlWjRQQ2lY?=
 =?utf-8?B?MnN6cjh0cGp5TE4zVWhiODMwSjB2czI0ZTFQSXlZRGxLYlljd3NKRm1ReWV3?=
 =?utf-8?B?RXVrWkt1NFRQbkFqY05GQmt4ZGZaN0dXWjhIc0UxWE1oSFUxeEcvbWY2QlBQ?=
 =?utf-8?B?QUdFVXB1OFZMVTg5ZHBrcmhIblFxRDZDV29nem0vNm0vNHV6QUxCbjBqQTBq?=
 =?utf-8?B?M3BUYUpYdW9hbDVGOTFIcnIrZmdYbWluQXhVZ1lKS3RSTjlWZml0Q2VETGVX?=
 =?utf-8?B?cGtaOWsxa2QwdW5CQkxuL1BLaGhKeUdEbGRESEVFK04wVEU3bU9rYTB1MWNB?=
 =?utf-8?B?WVZ0TEdwRXYrVzZndW5waUorZ1doQXZEb25RbUVvWTFqb1NnaWZ1WVpHaGV3?=
 =?utf-8?B?UytYL3N4TXFqcFd0WlJ5UisrVHNOT0FQSEt4bS9mWDZyWlBGbUc0SEJKQTB2?=
 =?utf-8?B?TnZ0ZVhFNFB4bEJTemUwWndnaTJpV1FPZlAvY1lISXVJdHRvckNaQTdlNkV6?=
 =?utf-8?B?ZjFJeVRSM2lmbHJxUlJIRlNDd2UxZHZGNkhmMzc5YXVkK3c0eFUvV2JoRkZz?=
 =?utf-8?B?WXJZR0U4QzdSS0tEeFFKUGQyMWRMYVA0d01yWE1xRWpJeEhkZ3h6N2NXS1hJ?=
 =?utf-8?B?SFl1c2JidDdNOE5SeVdvR2s1S2JqWk8rZjFBWCtEZzFRM3BYY0x5MUphM0Fa?=
 =?utf-8?B?b1hIN2l1bmpudnE1SVlzc1FYeUptSEdFQ3lDaGdBZ1dxWkdKTXRQTWh4Z3B3?=
 =?utf-8?B?dEhuWGZFNTMwM0VEQTdUZkJhZmVDS1Fjait2WWt3Qlo3SUxUSlJzbU1iODNu?=
 =?utf-8?B?QWp0eUhNOC9GMWpiUWdNL01ENnNaZUlJTlFVS2dOcitUV0VTdEZIVXpUb3RL?=
 =?utf-8?B?ajZ2alRxOFF2SFVSbUxKQUthRXJGTXd3Z0Z5Z212b3Y0bXdVd05Sbk0xeVdr?=
 =?utf-8?Q?nTCM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5ae241-22f7-4020-9764-08dc99df0ab8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:04:01.7890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5T9/n6hLHsCmnJ/nUUHUEFkbTIhPBRWeBKA1gDffY/gh/+sH8Wm0rhIoKW5I6qoxPiWwFpBve6ow6lwVsJ40hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8166

Include common imx8-ss-mipi0.dtsi and imx8-ss-mipi1.dtsi.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi | 19 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi         | 17 +++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi
new file mode 100644
index 0000000000000..f4c393fe72044
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2024 NXP
+ */
+
+&mipi0_lis_lpcg {
+	clocks = <&dsi_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>;
+	clock-output-names = "mipi0_lis_lpcg_ipg_clk";
+};
+
+&mipi0_pwm_lpcg {
+	clocks = <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>,
+		 <&dsi_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+	clock-output-names = "mipi0_pwm_lpcg_clk",
+			     "mipi0_pwm_lpcg_ipg_clk";
+};
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 1e8511e8d8577..3ee6e2869e3cf 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -567,12 +567,28 @@ lvds_ipg_clk: clock-controller-lvds-ipg {
 		clock-output-names = "lvds0_ipg_clk";
 	};
 
+	dsi_ipg_clk: clock-controller-dsi-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <120000000>;
+		clock-output-names = "dsi_ipg_clk";
+	};
+
+	mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <432000000>;
+		clock-output-names = "mipi_pll_div2_clk";
+	};
+
 	/* sorted in register address */
 	#include "imx8-ss-cm41.dtsi"
 	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-gpu0.dtsi"
+	#include "imx8-ss-mipi0.dtsi"
 	#include "imx8-ss-lvds0.dtsi"
+	#include "imx8-ss-mipi1.dtsi"
 	#include "imx8-ss-lvds1.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
@@ -586,3 +602,4 @@ lvds_ipg_clk: clock-controller-lvds-ipg {
 #include "imx8qm-ss-lsio.dtsi"
 #include "imx8qm-ss-audio.dtsi"
 #include "imx8qm-ss-lvds.dtsi"
+#include "imx8qm-ss-mipi.dtsi"

-- 
2.34.1


