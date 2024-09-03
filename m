Return-Path: <linux-kernel+bounces-312309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6029694CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEB5EB23863
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B5D1D6C58;
	Tue,  3 Sep 2024 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DBYwh9cv"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72D5205E0E;
	Tue,  3 Sep 2024 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347364; cv=fail; b=RcfYi/l/xZP8cNJMtYlCbANjab+XlM+8i03NZF3Pdvna603HX95sn0ogRf5GTQh7P7dkbGT+fGK0ncEE4pHFC/T603Vp3CBffdZnwmd7UN8fLGPO1e24vQAS+Tr4MCN14uE72v6HphkE6xWeJRlUANp9OtjAq3BKwGAWocYEoOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347364; c=relaxed/simple;
	bh=AOW3qJIK3PnIJkBgDHPLbX9ja3EsSAXc3rFMnTlymAg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KhHUkTlrsb51z7QduWDltJRvjlGYvzndbA8+aRcUZ1MbIZQxQD8mKK/ni8oDk+swLX9gzbbOst5VA/JoRi+8Od0x/zzPh2iW6sT4n2+eN3LNUShyqnnlUBrh6fJLmQmG6SFtCI2BJC/5QccLQFVMgVK2WkGrdZFKN0yt6/74POk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DBYwh9cv; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiQozhhFANdD3//8YtlG1jst0MR/GtJBXf+1lpyOVhcn+tHuxmS0Ean2fr34xQlRYl53KB3kstMS43V7Xd0befq0z7kIzml1tlEA8WsWbhhauje6Kfcn6DO0xcc5gya4Yy6miv3hYwKkwyf1ON9aN0QzjSYbhjmS8yrV0reDXRYtqqQap9M4Zcziqtb8fGNu/b7KX+YhWWgnfeZ6G0vx7OvuYC12jzvsxECivRkklZhJfYEiyzRBr7s9nI+T4gFPZlY75s1kPxwLSfnSnWW1vA4fQF5HUgYUPzNdiRHrhgmGjbr6q2fmuWMdleLB11GHtQrN7/s3/w+c8MVSuTwXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24Q3gOMGagIDtU+Gq4rLz3OCK4s4M2hs8o7OQMkyeF8=;
 b=TKmLhSsw6wuNIE/koW94pTlMosk+a9GmYWOFsQ+iEACx8sLL1QM6uYHFmohEPLMSbHGvqnyA8Srz4JGhbtLZ6imEJPw4TxfcajibCwFevpcLq6154xObTWaD7jIA1BG7MHHpvJ6S8qiN6pn0LxNNnHUldWjW6cDBKd+0DrMqYzard8Cspev0cUfzQY6NyZqVi+Rj47tLvALzkrWM1El0Z8JiT4jI7MuFoismRC/aibI55AvKQXTpmXH15SCmLGYq547GHweEasnaW9pCgcZtl5G7/swzVHXwPx0k5tPWqfNkKrUyuf/gVVwNnWiivl9eyKEedk6NzlB26YiK+8Ox8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24Q3gOMGagIDtU+Gq4rLz3OCK4s4M2hs8o7OQMkyeF8=;
 b=DBYwh9cvcMslxlV0N+YME2s60Z7I2snbscaFsz/nz6v8vh4kFpLPprcdVbyMIBXc/opDov4pBGpBrhHJJmtosAH9JPItWGRelIn03z9Gdg8bdaYAnkubLSitY10tIBT4B5/RDUPlumbVA2cGTVrm03a4Nid+XnudQoDoXoTEhMzZ6gsZ/rvTS5eUwK4kbSF2s+0E8qq0mPLiRz+ex2RIkmoY3JiLleXOrV2OxqIHSyCvBw8BLW+DwnOv/apo988XgqWOGTj/uxfwqwxBaIoeMgN4TWYNPx1+mhf1c1qJ0SnjPkq6RL+6OJMVBnf1ChEv+4muHa6O7WDDaZ1P5AVRfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9365.eurprd04.prod.outlook.com (2603:10a6:102:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:09:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:09:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Sep 2024 15:17:51 +0800
Subject: [PATCH v2 6/7] arm64: dts: freescale: imx95-19x19-evk: add
 nxp,ctrl-ids property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-imx95-dts-new-v2-6-8ed795d61358@nxp.com>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
In-Reply-To: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725347874; l=1405;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=pJSS4nFlbHegGKzBbz85OQWg077AQK46lC4okdt27kA=;
 b=glyYsd7mLt736v3fQE8Krb2yiD/OjaL1kuVrHmciwatGzdRJvlv+KiKCxQAnnHEheWbwKAhxS
 FP1sM8AeaZED3t7k9mLYttf3h9dF5Q+t1T7p+lfgmUikxGQ/cSSSAii
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
X-MS-Office365-Filtering-Correlation-Id: 3a11c533-c4b8-4b6b-bcb4-08dccbe75430
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDR0WlhLSEJ2c1BiaDJHcHIvL0J4Zlo3VHRib3lKY1oxQUdvSW9JWVpXU2Fn?=
 =?utf-8?B?L2V0OE5xUXJhdjQ2ZFU4TjV4SnUvdDZVbk1taDFuaFlRangrdXZLZ0wrWDZp?=
 =?utf-8?B?UTB2M0o5TDhPcG5ZOGk2Wng4Rm4rMVdoaHBTZENtZUJOTFgyS3pWU3JUemF0?=
 =?utf-8?B?L2dqWnhXczlSNkVMaEFqcmY5NFA0eldDNWtiRUY4bXd6ejdhL1hsV2hPUkNL?=
 =?utf-8?B?dVpKb0htc2Y2YTBaalRuUis2Nm9IbEUyc3Zlc25tVmtheUpSSVRCMXdiSE5y?=
 =?utf-8?B?VmMvdVROd2h4MkUwZy9RbTBIS1ZRY2hFRVdJQ2FnOWxKN2NUZmVIRXduVjdi?=
 =?utf-8?B?bEhzRTUrcFZNZ1g3eEZyVjEyWFdVZHpJVjdHV2RUNkZoWEZ4Um52YTlKZ3ox?=
 =?utf-8?B?Y3dEamtVUmpsT0tqWXJZbmtTWGdJVDloRjYyaUNjdnNZWlY3QWxoVWhUQk9o?=
 =?utf-8?B?dE84ZFpOM3FqVGkyQXRsNnZsQ0VKT2ZENE9KK2lhZWxGTVhEdXRqdzI1L2oz?=
 =?utf-8?B?VmJBSTVJdkVlclNmNzh6VVpvMXhPVkppWmlHak5HR21ZM2pQUmlPbTcrbytl?=
 =?utf-8?B?cmpyemNvWlZ6ZnNXaHhES2FTbGRROHp4Y1ZaMGhjVDd5RGd6RVhKOGh1cUp2?=
 =?utf-8?B?Qzk0YWNVUk1TbFpobFlROFZhV1h0SnlUZmQydkR3M0NjeUcyNS9zOWJnekdm?=
 =?utf-8?B?NUxSRnJ1S3JhVzNCZXJLcFN4NWt5enR1NjdmZ21HWGgvNWFOR1NzRmFJOEp0?=
 =?utf-8?B?dlI4NG1HNXgzd0ZBTWVkKzdxSVB3NGFDZ3hXR1ZuUWF0eXJvNGFNKzhwcjdK?=
 =?utf-8?B?VlFndzQ4U3d1MUpIakhCbjY0em1FQmUvWlVFdGU5Q2tzeG1XdWtmbWc0Rkl3?=
 =?utf-8?B?WGhLYU1BeWh6TG9YLy95SVlhd0RuVGRQUFk1aGRSanM5dHN5enVOVEFCM3Jp?=
 =?utf-8?B?eWRicUJreUNmN3dBWmxVZlBiemZTakluLzZzQUhMdDF1T0xrajZtR09BYm1l?=
 =?utf-8?B?WkNQMCttSTBnQkRuU3RPTlk5M25xWXIwcEFrUFluUlRDMW5sNndWczlTSERO?=
 =?utf-8?B?NnJ2T2FuQXRkTHZ3VkxEVVh5d0JTdkVHR1JmNUZKZGJZZnYrOVRPMUN2bVkr?=
 =?utf-8?B?dGZqbHFhQWJIcEZsS3pWbXpQNmhyYzR1ZzRkeTdtaDBVUGtid0M4ZjQzbitM?=
 =?utf-8?B?SXZQQjRkaFlLQktOTXg0b1VYR05HeE1FZzlCdkE2ZkhacEZ3ZFlOWS9DeEhn?=
 =?utf-8?B?K3dVdFk2US9xaFI2elBXazNwb1MzMjFNNVQrN1U1RlliT0xBVjVUV2puclVn?=
 =?utf-8?B?NUtuZVAxR2NXZXJUWC9iUEFYOTF6ak9Gb2lIcUp0TS9hRDNZbTVnQTZqQTVn?=
 =?utf-8?B?bVhjUnE5NXE3VFpCM3NYQ2ZhMzA2TEVzV205MWI4WG1QNXQrRUxuYjhqTSsv?=
 =?utf-8?B?dmtJL1dEZWhKUUNrZDZuWjJtRVVqT1N0K0lESWZQNW5KSzQwQTIwRS90Mk1U?=
 =?utf-8?B?MlFDdmVubk1KVzRnOHhUem9yTHFvVnNxTDN0Z2djRXRyTUxuMDNYSWN0V2hY?=
 =?utf-8?B?TFloMjN5UUFvYTBid1RHOFY5Q3ovMEpWemVOSnhzSzBiSVJ2a3lOZm5ZamtW?=
 =?utf-8?B?aSszdGd4eEVHSkFqYUxCTCtXVFZKMjUwaXZZQWIyL2RWMHB0L2lMWW5DYi9i?=
 =?utf-8?B?NFdhYWZtTHNRamtrNkM5bWxhdzlaOXplanloc0gwNTlvWTAvUXpwcmx1NXhH?=
 =?utf-8?B?YXRLMUcycS9SNEJuUFlwRXIvUHZJdHVCNENsQjdSY1NhMU9xZC90Nzc2UTg4?=
 =?utf-8?B?TzVkc0VSTktKaUtsTm1iRVY0U0p4TDU0TUxHSGJVS1YvTTBpejRsZDd3SE03?=
 =?utf-8?B?eG9rMDRUWDE1cStPcVgybE1wME9BMDBHcFpZcGZVbWUwZXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFU2UVc5N1A4S1Z5Ni9SM0VlZWo2di9pcjZneVZQU2dQb1NLL253T1N4VWNo?=
 =?utf-8?B?dWFlQkNOSGNmZGFmWGFVN0NwU3BhWmt0MmVjcnovcC8vUExjMy82ZnNjM3pm?=
 =?utf-8?B?RDFpL2gxaSs1TGpCQURYYlVpSHVNdWlUYXpLaXdERFgxdjdWRXBRM0diT1di?=
 =?utf-8?B?RmwrcXpQVERncFJhODF3Y3NOeUZGejdBcFlQZkFDQ2dyRTVjSW5Nczk0V1M4?=
 =?utf-8?B?MEo4VkRyaWZLRW5pdlBPNTZRb3pnSUtRcUg3Z0Mybi9uUmFDR0N0ckdGWkdI?=
 =?utf-8?B?eTJDQmpsdHNOekhMcjUvaFk4QmZUV2F5QiswQ2hUVG9IYWhGZzB1UFlHeWk0?=
 =?utf-8?B?R2JLendJVE1nOWFKL0xLVEg5ZEhTYWJ0UlB6Sk83NG9veldMYkdvbFdKWUtn?=
 =?utf-8?B?NGw5QzJ5d0N3ZDZSaFhoQWExQ3VvZEljK0JYQ0drK3FSWU5ocjhHcGs1WWRa?=
 =?utf-8?B?TFgxTUR0U01pUThRZHZpU0N1K3Y1Ri9HRFRCbE5tOHliVkVtT2FJUDl1bE12?=
 =?utf-8?B?VlBrUXovdmVEYXR4TWQyUGZvUk9ndjRqbVRWU3VPZjcrTmdqcEl6K2FMZU0z?=
 =?utf-8?B?WkRxcVpCc0draUlBR2E4Y1lSTkhHU1BRcGw4bGMwVEpieXlaUWxnSHFncDJi?=
 =?utf-8?B?aVUrZnFRTGJVSEE5TDlGZGMwdHpwc0syZXZVWmVodEtFSXZmSzVJSzVHWmRI?=
 =?utf-8?B?aVI1OFZIUmhmdmpMOFdyaDNzUUVsRUhTemZHbnIvcWFmRG01TjR1YWcwZjQz?=
 =?utf-8?B?K2NPNEdZdm9XZEJleExyUXhxTTV6cFYyYWZ6cGp3aTdyZXJUSElDMWdQbVhS?=
 =?utf-8?B?Q05GWklON0poVVhWTmhWRVN5bERkZ3UvQzh2MWRYYnZTSHVZQnFaMHZZU09p?=
 =?utf-8?B?UlJJRCtpR1NZdTgzZU5ZZUpHNjdSd3ZsQmRJcVJIN21RYyt4TE81ZHVUMnl1?=
 =?utf-8?B?SndXYUhmb3Y0d3I4bVozS1BNUGFOcGhaYU1CdGoyb2RudllwWXhnSitBVys3?=
 =?utf-8?B?TzFoRzM3emVSWmxWeE1keXdEUVN5dU9jUEVVRlRHVHJJT00rOG82VlhQT3dr?=
 =?utf-8?B?d1RJc0JIbS9PM1JqN2JPa0NxTng0endMQWd1MmdrdUhIdHJmVytsK3crbXNv?=
 =?utf-8?B?aGljVy9YOVF6Nm5vckllZzlTb2dPT2V0VGVTTVpjZHBzeFJjU1VjOHhjb0xF?=
 =?utf-8?B?aGF2TG1ZMUlKY216eWhOMkh4NFhiOUdHNytpanVWYVJ4U2VwQVgwVGNza1JZ?=
 =?utf-8?B?ZTRFQlFEaTdBRTRPOHU0ckZBamxVdzY4ajM3RjdyUXNBQVYrR1VRUnovTUsr?=
 =?utf-8?B?a29IbzFZdnM2MXhCcm81OFYyN210RmhTV29hRnZLc29mWVlDeUxHNlFubVFy?=
 =?utf-8?B?TE1weTYyMUlXdHM1VVYwODZsT1dMTklWSVIvRVFFaC9KYVFCM2JJYjN3Qjhk?=
 =?utf-8?B?VnM1QlJabkNhZjNWTUh0elAyZ2FlZldvSWRPYjcxNUZqQVhkZnpOYU5kZmZY?=
 =?utf-8?B?a1JCRWQ3RjNRQ1k5b1FtSXpHbHBDWjVPYS9BS2NuLzRidUNCa2ozLzUrcml4?=
 =?utf-8?B?VmZMMnB4TXJacHFQMmNLMkZZSDc5VnNrcG9qMm8vZm94QjdKTG9PUFU0UUtG?=
 =?utf-8?B?WXpTdTF5T1VhcVptRU9ndGc4NmpoOUJiSmYxQ1ZMc1JiVFY1R2R1aEFDVGdV?=
 =?utf-8?B?UjhLV1gvR3RUaTZtb0hxM1ZqSEJETi82N1Zuc250c2JlT0VPaWhUK1I2Z3Rj?=
 =?utf-8?B?Q1NRVHJEaVRJWkhKdlJ2c3hNeFUrdmo0NHRFdUQ3MCsrZ21Gb2hZTUxFdi9I?=
 =?utf-8?B?d05ubFMyWVgwRDBkaDRtbUlENC9kODRjSFRiVWtVMTFndWZDaVdrY2hPMitL?=
 =?utf-8?B?OEN1akdhelZRYWN5U09rUTY1Q0xOVUZnNmxqZ1RyZStmTmw0dlViSXg4YXdL?=
 =?utf-8?B?MkVKcjZIZzdEL0MvSU15M001VnFzMm1ha2U4WDNOWGpXdmV6eDRZWGhVRVRa?=
 =?utf-8?B?MVIyNFN4R3dST1V0b0tvcWtnR2FYMG9WTjVCUDVQRHJ6WUpLSGZNWnFaRXND?=
 =?utf-8?B?WjIwQ09kZWFyN0xnMTdoaHlTcnExcWZrZHJzVDcvdDFKcjZzaDg3SS92YTVt?=
 =?utf-8?Q?25RdeciRlwh/5KfGG8OvaUuWL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a11c533-c4b8-4b6b-bcb4-08dccbe75430
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:09:19.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZddcuIr/23yLBLwvcLlnyt69ZhFrzgy4hCdFZCVoNu6TAHh4MHf6oQ+kBS9yBa8vZBWx9Mcz78yM0cMtdz8jxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9365

From: Peng Fan <peng.fan@nxp.com>

Add 'nxp,ctrl-ids' for SCMI firmware to confirm the board ctrls as
wakeup sources.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 37a1d4ca1b20..5101cd171e09 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -8,6 +8,15 @@
 #include <dt-bindings/pwm/pwm.h>
 #include "imx95.dtsi"
 
+#define FALLING_EDGE			1
+#define RISING_EDGE			2
+
+#define BRD_SM_CTRL_SD3_WAKE		0x8000	/* PCAL6408A-0 */
+#define BRD_SM_CTRL_PCIE1_WAKE		0x8001	/* PCAL6408A-4 */
+#define BRD_SM_CTRL_BT_WAKE		0x8002	/* PCAL6408A-5 */
+#define BRD_SM_CTRL_PCIE2_WAKE		0x8003	/* PCAL6408A-6 */
+#define BRD_SM_CTRL_BUTTON		0x8004	/* PCAL6408A-7 */
+
 / {
 	model = "NXP i.MX95 19X19 board";
 	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
@@ -357,6 +366,14 @@ &usdhc2 {
 	status = "okay";
 };
 
+&scmi_misc {
+	nxp,ctrl-ids = <BRD_SM_CTRL_SD3_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_PCIE1_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_BT_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_PCIE2_WAKE	FALLING_EDGE
+			BRD_SM_CTRL_BUTTON	FALLING_EDGE>;
+};
+
 &wdog3 {
 	fsl,ext-reset-output;
 	status = "okay";

-- 
2.37.1


