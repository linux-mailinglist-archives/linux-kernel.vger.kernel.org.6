Return-Path: <linux-kernel+bounces-363602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACE099C494
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84211F2106B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32FE15697B;
	Mon, 14 Oct 2024 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dxSFdCOX"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F60156669;
	Mon, 14 Oct 2024 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896578; cv=fail; b=FJJWwQB29T/q8EsRDfoKp5AB6MFlqEjCniHY+upHlbT4+QUKmLBGWV7CQP5U0BbNCpoQDLWPpOwANoUT8hE+E96cAJctL1ur/tGhVaUhCRFv20V4hFeNpA/gUy8Q1uBRKElYvI+f610CGJ/DhPYDpiFMcfaCopudWFgJVufbU+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896578; c=relaxed/simple;
	bh=ExlIgQbunead4w7dEkppAfw/EYJaVq4W07T9IlXzOBY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=i454Y29qZPcgOkYxdSxpJvlQH5VbKs631+9NYKzaPpBtMPDeinjECAgbCAc9mYRAhB61THC2cyGK8io4G5LMJVDFb7ynju4c6H5FeZAjVUotkO3tfae4SHNCbqqLKNk1RoFHGKMEqZlmVlu7UJ9BRHs8EY9ApVrYuOs3nqz7QfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dxSFdCOX; arc=fail smtp.client-ip=40.107.247.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFaMAok2L3Hjg024R3Ukwz+6qBY8YFN4eeuu1RTfMEefbTEvc98c4eQeUV7KoBv7vCelw0tQUydM8TtTomvs+gjDrLKLS1boG0sgHlWgpTWF+Wzq8YQeT6xsIcbjdCw+0rFiH+jvrcppC97Ketv2bN7cX6687f5J4uj+Cs4sdo2jFfYMsE+4R5O9JxDLTuJTa4MUVo+txVYZ1mQMMiI39QfdUNJfBoLhSKrROHYl98Zt5ykjKt/7BuwSqlMj6vfC1yHqb8UeTgQuZgbs72h8fKoIz4uRilIvMaMnl9SpjHGnspLci5RN7ivvvVGUMo6dmuf/LiL07ERN3vRFDIahZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdvKNvGzumUXSlt5L+eIRW+tInE4yBzZKKVPMUHT4sI=;
 b=gAjs8ptdSLMVLTV91YONZIytl5xLucaw81XtbNlTVIZZQ7oD9vOw50KGdAMpyMhBiQt9dQktMaFobtlcKvAcONkY4qahVb5Qilh9u0qwFZUCGix8baiZ+ooD5ZRgQ2Xdp1g6gU2AltC4WHs0RziFeniVKxXR9ksjTodMZ0p2sLxk0RJ9vx3vYZ/MNG0ZpEAoLa/n9O7xpU0oHisxr4Ti1wADF95yq+V/UUGtKLCZArU78kiNCm6BugmZXk1nN9jIyqi/DG7xRsO6b3X2z0vx+cW2EkcbCRjFoZeMrjMAYESSvHtsqKPqXpRY6aIFYzHmyl2n7tN0NlRBTIfEoKRNhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdvKNvGzumUXSlt5L+eIRW+tInE4yBzZKKVPMUHT4sI=;
 b=dxSFdCOXUuQ+HZEflL5dm0vCjEkIiVXT5iSqsvTsaA81lCIs+UtI4v7RNefXuKYK7pTWWcHFO155WzkbOTZOn7Fi/b8NE9J44G8WcqEH/i6417nvKQLb8SX9IVkR7koGh9Sgkxv75xod8sSq+X5ufDFYtQdRsAC+oyCARtTo3X16c2TMCV5C26+KseAfeBN4wJ12AdPIWDlBxa8tYEKAVEdpLVg9NkW7TTr5/FlXhXisoUzrt5X5GCmSXkLh7xfnl5h5hhmDRd1xAsREU2BtSOl34eRwtaDw3PJCS4BIDZwHYEMR+EVS35wS0OtMegyosgcQhCyL0t4zMYXeD92ytQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAXPR04MB8765.eurprd04.prod.outlook.com (2603:10a6:102:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 09:02:53 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 09:02:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 14 Oct 2024 17:11:23 +0800
Subject: [PATCH 2/4] clk: imx: lpcg-scu: Skip HDMI LPCG clock save/restore
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-imx-clk-v1-v1-2-ee75876d3102@nxp.com>
References: <20241014-imx-clk-v1-v1-0-ee75876d3102@nxp.com>
In-Reply-To: <20241014-imx-clk-v1-v1-0-ee75876d3102@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728897092; l=1501;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ymw2GjjoDDKGoLL2K77L2xxO6NJ0H9lsK5VA9yIxUtA=;
 b=ZP8NYaa4S+DFKcFlOpHarpyP2wmmB8Ry7k0Sq3edfJFNRNtDTYyCmr+klBq4jhAtSpSk7oyvx
 fTVSGV2VdpOCIYqC/+VXYL25EMmR/NaKnjF9tLtT31NwoXFhlGeUWeK
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAXPR04MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f74bca5-4915-4722-8a0d-08dcec2efcbf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2haWlhTU2ticGFVMEZKcXUwcS9rcHM0V3pyRzdmUFZEYjdjNFp4WG1kbDU4?=
 =?utf-8?B?T1dDTjV1Nms5Qk9zMEZITVRMVW1PTUFxSE1CNktXOWhna21pa3pBTWJpSWVt?=
 =?utf-8?B?cDlRY3FOb2M2dE83anNkWUxwUkY2SHlia2owK1RXQ1E2djEvQWpQdWRlWWdG?=
 =?utf-8?B?TzJoeW9Lc2dmaEhpWlJ0am5PUFNCZHFTRVBxb2gxdVA3ZWtWbXB5NlVQYmZ3?=
 =?utf-8?B?dUhSTkF5Q243Z2kwNGhDZVlqRDUyUFBIdlJhMXlNMVhLREVTN3QrR3NnOXpR?=
 =?utf-8?B?SHJhZWVpWXRsZ090TmZoT21zZnhGc3BlZWFSN29neDhoZDYrcjBHRzd1VkhH?=
 =?utf-8?B?RUZQc1ltWVNpd1p3VWxpYWY3WERYbHE3TkYxcFhvVjF3MExEWVNDTCtJSVpI?=
 =?utf-8?B?V3hiYWFoZWc3Mk9ianozQ1B3NmRHcnZ0TG83YlpBN2JERjVxTkYzOWtOK1o3?=
 =?utf-8?B?TVhzRXR2SGd3b3ZERmtPY01rWnBQQmEyQi9rTkI2c0pxNHV0dzIwemhLR0wv?=
 =?utf-8?B?b3VVL3doSTZja2FIanltT25iUWRhTGJScFFHaUg2eExjczFDNlZZalJVam1V?=
 =?utf-8?B?VE5jWDJYdWVmUUt0NHV1b0I1V3dvTk9zMUlKZEpOWmtrVGtCQjUwcjhKdVJG?=
 =?utf-8?B?VTU2Z0lrNjJucTFPTnV6a0NOSDRzc0NDVi9zcXd0YTRqVFR0Qmg0d2R5cFZo?=
 =?utf-8?B?dE4rajFISExKZ20zMGxXUTlyZjlpK1lSUnNsYU5JYUVHMFJ2dFRrd0pMNTZj?=
 =?utf-8?B?WXlLclkwNWx3RzRTTWJ1QzBQbVBEUHZMV3VmdWZ2cXZRN1R3K0diR3JVVjlQ?=
 =?utf-8?B?WmNyUUlvcXJ3RkJnOHo0TFBNZ0R5QWk1YXF6RWxxQVcwWHE1eG9pcjRHcjBE?=
 =?utf-8?B?YzlNN3UxQjJrRHFDc2tFMWtnV2swUTlTQUZmUlF6dWMxRkswbFpxTk1rSkFw?=
 =?utf-8?B?SkFOemVKWXIwMjRRbnMxZDlueU0xTUpobjhpQ2s2QlFiOGs3WUZzMkRUZFdz?=
 =?utf-8?B?YURjVmlEaldLNkw4eVlKOTlBYWo3Vk5NZGtTL1dYSU5ZRXEzRUxNeVRnalNL?=
 =?utf-8?B?bGQ0amV1NWV6L2pLZHRCWDhsa1hPL2J3QkpYVjhFNTNZRkdoeDNEbXRENGtH?=
 =?utf-8?B?ZXR5S2s4NUlIY1B1OHJWVUljcERwWTJFNG9JaGFPT3BaTEtFMSszLzdxYjNR?=
 =?utf-8?B?RVh2OGJ5VjAzTVlFcmVvUVNnWlV2S0pRV3dobG5XRENVOXFHM3hyNjdDTnRC?=
 =?utf-8?B?TEllaVBpVEE1K0Fmb0NBOVRhWDViV0E1TFlGMG4yM1pQUXYrWmllZHZNU0xY?=
 =?utf-8?B?YzFPWVBwOVNvK0E1L2x2L2VjS0Z3YkxlNE5hYk5XZzBUSjRKM2FFdFNzbE5L?=
 =?utf-8?B?dkN2VC96TmRQcmlmeS9SeklaVHI4cWhFYzJRK05BemtVOFZ2R3F0N08rSWxy?=
 =?utf-8?B?ZXdaZlJncXpCejNvK3lrYk1iTllBd04vU3FIQjFqQlFIY2JnYTl0bDlER3d0?=
 =?utf-8?B?UWd2eVZnbmdSQ3o3cUIyTldWZXhxbDA3akVVb0Nub0x5UlRONXRIRHh5c21G?=
 =?utf-8?B?ak1uWnVDWWNhd3pOMXl0K25ZOUlnL2xxMTJUZjVwWXdReStLcmU2c3hpeUt3?=
 =?utf-8?B?K1JVVFdOUXQ2SzBJekgwMWJRbU1rSTlOYWRVRXFsakJ6WGQyU0V2V1FrRG9q?=
 =?utf-8?B?MWs3VWcxa3oraFRDY2MzUzlTQ0pYK25sL2VrUHZSNXpDUjhmWFBEaXMvZ2dm?=
 =?utf-8?B?QVlxVTl6QzVhdTNqVzlQSXlBa2RKMmZQdWVVOHZaVFNxNmwzWXlXZGZvSzNq?=
 =?utf-8?B?NjNQRm4rNERZYjJiR0YwQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTNmREw5Mm5xZTZYaWh0RmpEV3FWMktWTWNkSnlkYnczYTArK04vVTJzYTRF?=
 =?utf-8?B?clF5MnVRT2VIVjhWTmprZ2FoMHdpUUZybWlSVHhTS0ZhaysxVzJ1cC9VNmJz?=
 =?utf-8?B?dmpSL1lIekMwamdnc3d1RmJkMkxuem16SkxXM0Nqc1pRb2V2alg1QlVWdEs2?=
 =?utf-8?B?L2ZHcFlvSS83dHNtZUxxaTZCaHVnQnZJUUk4dGErOHZPRVhDUDBRZ1lOSWZH?=
 =?utf-8?B?MEFZL0o1SU1RWGU4TFZORGNQUk5jYjI1M0QyV0VaTitBaGRCWjRINHdiRVRF?=
 =?utf-8?B?dW9QZWlzcGE4dWpaYXVwWWtwWjdzelhzdkEvR2NyWFBzY1JHeE51alc2ejg2?=
 =?utf-8?B?TGVBZmJWRW5IbVBpb1I5bEF2NkFNb2I4Yzd4d3UyWHB6dGtZWThXcmpnSjFh?=
 =?utf-8?B?WDRMb1FhUHRyZE05Q1dPMDN6a2R6UDVSSWMwNlFtZ3BOelNmUVRzRHBXRUVk?=
 =?utf-8?B?ekVRY3lyUDk1VzBHOXAwWkZ0QUFZTFF1OERjU1A2Z0I3RnBXaGpWazZPQ2lX?=
 =?utf-8?B?ajZjM0xqSWZwRmRhTFFiTkFJa3lmR0pYZnFPamdrcUYrUnU5SDBPNVNSYkVX?=
 =?utf-8?B?SXQybi9hSG5hSFdUOEc5TUdzMmhGN2w4SlJRTFVlVTY3dHpKYTZsb0poUHRG?=
 =?utf-8?B?TG5SUGdQbFdzeDdsbVVxZ1FMRzZQOVNxZENDODdFby90TjJvZDA0WjFBNU45?=
 =?utf-8?B?b1RiNXF2MjJRbFEvVHIvN1dXQ1ArbGt2c2RDbjZqdzRaYjV4U0tQalNNa0FE?=
 =?utf-8?B?dm9hS1NBejE0djNuQi85aE0zcG9IVHA2b2RCbUY5UXhpTncvRVNvWGVDRFVL?=
 =?utf-8?B?VjVzLzN2VEh2SEpnUHpTd09COURmMXYyeXpHUUpFaTNoWWRBck1zRVRFcTl2?=
 =?utf-8?B?TmQ2TS96bWRURlQ3YnpBMUNQeHVDc21MaEg2YVhhU1ZoVjBvbHhybkNMRXhI?=
 =?utf-8?B?UDFwRlNLMnN4SHRZKzdJY0pVWkVuS1RTb1R4T0g0b2h5RUU3N3oyOTRkWlcr?=
 =?utf-8?B?bFJ6TXZnMWpkNENCUTEzNWY2YWF6K01TTlY3ZnF3eEUzN0ttZkREeGFJU2NW?=
 =?utf-8?B?a0dmcXltYy92NVdXbC85bDRqWUgvVVp2KzF4cUM5OWhkdXBkUkM5Z2JjQTd1?=
 =?utf-8?B?Rk5zRWc2dHd4Wkw1YkIzeWluQkxwRi84YkJtL0ZFQ1RqMkVGeGVUblU5RmN2?=
 =?utf-8?B?Z3NsYXNQTlV1djUyYVpQWUR6amxtdU5ZVXRVRUVrdUUwcFp0ZGkrTFpOZkg0?=
 =?utf-8?B?OXhvdFFZT3lIalMrTFEwVGZtMmprcEZMSmNJTnNqSTdxeUtlWWQyNUpmNEFF?=
 =?utf-8?B?ckJTZmRKcTB6elZQa2hodisrTEoxUHJha0VWaWVycFNNd2V6TCttTVk5VjJm?=
 =?utf-8?B?NG1rV2pOM0lMVlJCejJvUXJsSzlsZmpXMDhzMWJQTGZrMXVUbEU3WldJOEJu?=
 =?utf-8?B?MGtlYjl1V3d2WE40TEhpVE94a3FWMkhMYzlQYnN1M1VEeG9JTEtEOFVVK1pJ?=
 =?utf-8?B?ZVVGQjFRWnJRTUhUeXlhZGhFandsRkpNbjlVRU1kUEFlMkxreUY0OHZzaTFE?=
 =?utf-8?B?bS9HRktVRDJJYU9Lc3lXallQajRsZlQ5UzIwNkFmOGlOOU9CNGpqdkdUTzI2?=
 =?utf-8?B?ZnZJWGxsK1JqQml2d3R2WkZSZGxPKzhQdk1QMzVjRkVMYVl0R0dZeFB4bkgx?=
 =?utf-8?B?Rk5oSDRybll0T3RwYUpkV3N5OE52NzlVRStQdS9QdGFUcE5MaFM2SEQrMXN2?=
 =?utf-8?B?ZVpQWUdUcXRSZjl3K05rUndPMkI0ODkzVHZGN1J4RndrSFRWNXlYclRvNlhp?=
 =?utf-8?B?bTROTUJEa1Vjd1BCOThXSEVQRjBXZmhUNzUyR2lKaEJuVnlOWktQNG1JdVNq?=
 =?utf-8?B?T2o5OCtienBUeU1EdThKQjVxOVNrNWU1Y2ZzVmpRM2VwMUFLaU1FVmtHNjd1?=
 =?utf-8?B?WmlnU0ZkZXJVRWVoT21qYnpwVHAyWjFXSit3OTBqZjRyemxiL3J1V0xjNkc0?=
 =?utf-8?B?UDNxRjM4UG4yVTRqSTJrNzhuYnpoeGdIeEc5TmVmYitUcmZ2THgwN0hMa2xB?=
 =?utf-8?B?d1lhQlhuZ1JzQUlnYjlWcFFRM0lGMkJ4RU1oQ3NGM3ZGRWJPZ1lYNXkrU21o?=
 =?utf-8?Q?enGNkD8oYD/sML8T9embcxx1M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f74bca5-4915-4722-8a0d-08dcec2efcbf
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:02:53.3611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNkMpz3ri6gFWqMsmTOCFdtYfSV8JM2WAYRs3NYs0BQQbsOSYCaD/O6PtkKDn3oirBULvwot1LCjSOyH3/WaWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8765

From: Peng Fan <peng.fan@nxp.com>

On i.MX8QM, HDMI LPCG clocks operation needs SCU clock "hdmi_ipg_clk"
to be ON. While during noirq suspend phase, "hdmi_ipg_clk" is disabled
by HDMI IRQ STEER driver, so SError will be triggered when accessing
the HDMI LPCG registers.

Skip all HDMI LPCG clocks save/restore to avoid SError during
system suspend/resume, it will NOT introduce additional power consumption
as their parent clock is disabled when suspend.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-lpcg-scu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index 2cffec0c42dccc256e8dc5e9181952e250870a76..466c0de11ca7d5af42a5ec34fb197dc90b1742b1 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -162,6 +162,9 @@ static int __maybe_unused imx_clk_lpcg_scu_suspend(struct device *dev)
 {
 	struct clk_lpcg_scu *clk = dev_get_drvdata(dev);
 
+	if (!strncmp("hdmi_lpcg", clk_hw_get_name(&clk->hw), strlen("hdmi_lpcg")))
+		return 0;
+
 	clk->state = readl_relaxed(clk->reg);
 	dev_dbg(dev, "save lpcg state 0x%x\n", clk->state);
 
@@ -172,6 +175,9 @@ static int __maybe_unused imx_clk_lpcg_scu_resume(struct device *dev)
 {
 	struct clk_lpcg_scu *clk = dev_get_drvdata(dev);
 
+	if (!strncmp("hdmi_lpcg", clk_hw_get_name(&clk->hw), strlen("hdmi_lpcg")))
+		return 0;
+
 	/*
 	 * FIXME: Sometimes writes don't work unless the CPU issues
 	 * them twice

-- 
2.37.1


