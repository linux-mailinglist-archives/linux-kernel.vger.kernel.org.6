Return-Path: <linux-kernel+bounces-312308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36949694CC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F2DB234FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60891201273;
	Tue,  3 Sep 2024 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lkLi4SeF"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737920124E;
	Tue,  3 Sep 2024 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347359; cv=fail; b=tXRCYueOE3Nfetsqv3Nbo4wuWpH/L7h7DaxhlaZaOe7Wu/zsy9E5kDUfH3IcCmvH5j6B414p99CCgymjfwsufLgNZypZ/37zRSI7uFyz2GromFCz/GUv3W72EHbxTCOcNrviFs0MfprBBAufsBsv4WOWiM/S4WPA1nunGyw71BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347359; c=relaxed/simple;
	bh=iv+Xnp6szQwP0LlAEm9s69JzGawGSXHr8OrgUbO7BrA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ecztVpibmdNIRtTVhYn3ADXnLigB1b5YODmynRs3Ee+MWqEGDuHJBtXubflGd+6oJjBJg5Ys5iplkDuRgSUD4F3BfSPlwc9zfzBDa0Pa6hVt6IxJpNzsT4ILELtDHWGmj8iphCiCXJVQ+sU8WBZorkIhYPfpo4a37UTebHWluio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lkLi4SeF; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUyNu8Msfw7HaQjnKbpuAJx2g0q6FPd1zgEZjpuQ7mIgYSSu65VjjORZ/p5psVqCu0BvGqcASINCxu3yNMk6EltqOZ//i/dRPUABrVy0nWle0Pgq/P6TdWjlTcz6qJY/fTtVSuhuC9R9D6Mmep2dXdGbUKtVMZ2sed4A+AyKNiCUvmQAmNwAs+RqOUW3ux/j7wqWE9Xio30vwsONfptrYzCRq6nnFBDENBhP1kwfZmHpNO/V/7IqyANNEcAqtAiVJSYlKu9DRnwuFQl4RvML0Qrs7gT6Itjvg26fGF6GE81XWeO7bEX/zN5MRlbkn0NtT7jJcslzTN0hDFgjiasb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fzeVCk2IEOiCOL05rfNNFErdeSeG1XWUkm4nAespeY=;
 b=uRdfqpFgTfa+yH+oiP701FQnYHZGDaYHb8/ksYO6fZQt7w7xlJVkKw9mCMk6Zr/ibyS5yIcve/PiojiLO5OLZX7zreLCgcMHciEt3PKBytEjjv91a2CGXQAbq5KTeaBtEJymy59t0eGBnw/wOmNF/zfDaWY/cPvMdhHoUMi+XfE95+f6jC0MMwKwfsO8AnTbCn4+STugct1C4GA1UC6djmyBpeWC2MCBivKGeT/4F/XNQ3cFe/IjlmNbB7MbAPGg6F5QcCMhrFK7WMrm2Q6XNx2oAL6rwcfcY3lroLttEyMmz4ftxM+u5/XOdBQi3MauvxJLGNhahTwFQJz9zBoVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fzeVCk2IEOiCOL05rfNNFErdeSeG1XWUkm4nAespeY=;
 b=lkLi4SeFTtFX4OYnMAmk5b+5KwSWNOxKCaVq4UMWgLkMsoHCAy0xHXnXC1y8yeH9V5BIVdWGbXKgHHJKX0YjX3WCS7XqvfmDe440I+CXSox+1sxQUAFX5VUGH+3r3mUENXbAjjwd2WjKSvS4OidutTinWG5X5w+T/yRLDLwYBc2opuCuv62xnmUUz2VFrda9kf31urGKCPEtL08+quNjaRC1NKQwLznuSGpMI/Oia/93lohVfKF/soib7/hlftKUrjeNSpVbPap4vWAJuY+8zSwbZUQ8jiIxHUqV8uBq1643ul8GqeO7mO+9d/0vKoV2JteYM/w+AXDgO8JJ5ZCsfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9365.eurprd04.prod.outlook.com (2603:10a6:102:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:09:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:09:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Sep 2024 15:17:50 +0800
Subject: [PATCH v2 5/7] arm64: dts: freescale: imx95: enable A55 cpuidle
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-imx95-dts-new-v2-5-8ed795d61358@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725347874; l=2478;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=rzWCgPVY+Scu1I6HkQDGLw1kH0NbKbPzqEDgDkYWCVU=;
 b=e83oKjPJ1iKUD4sLPuTyuKc7LyYemaJgzZBDzfMnetRdZj2Kai4p/FOKU2uD03bpnnBPkgSea
 VLFebpF4BR9BkBUeV96zcpswgHJ19v6NCdebHtPdsdoMlj6+zb11FrY
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
X-MS-Office365-Filtering-Correlation-Id: 158d0ef4-1bb5-4ab1-49fa-08dccbe751ff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnI2SitLQUtZV1Z5QWZoUlp1dDVKekRScGxNTS94SzlHL0VZK2FvVXloUmtn?=
 =?utf-8?B?UDU2ZVlMWDZpNzYzcFNvU0EzOGx2VGlYeHVWekdwS0czOWg3TzVVNXQ1eXZU?=
 =?utf-8?B?b25vWWQrWXZveFAyeTkrUHBMMnpzL1JPU0lhZFlZVUVaRU5UV2dPTE82NWR4?=
 =?utf-8?B?dFphdm9jMFo4UyttSmdER0hEbGR5Q1JIL095MlZQdVRHQit4eXR5UGFoUkRp?=
 =?utf-8?B?YnV4NVQzcVVZbGN4RzkrRzB1azRPbjlUYTl6NHBCckh6RXdlMkpQa0RuNjVo?=
 =?utf-8?B?NVlCeGZhU0NkdW5CVXV6RjhETk1GUEN6S0V3clZGa0J6N285bVNtMW15Skxz?=
 =?utf-8?B?UWI0UExzSXQzUDFLOHBOZFBrWU9uenNVUzM5eUx3MWtralQxT05hOEh5R1RQ?=
 =?utf-8?B?VWh2blNTRG81dDVJUHp5bE8wcjNkSEVocndNdDNRcnZZY3RweEI0RkVtNUR3?=
 =?utf-8?B?SmRoakpXVjYzVFBuNjdzSmExbXlkVUlLNnczZDVpaTlkSk1lS1BiY0huZzFV?=
 =?utf-8?B?RlAzMlk4RGVUNVZDcHlKbG1VSkNZd3ZhRTk2MlhjajlTVTdQNURIZEt3aTM4?=
 =?utf-8?B?UG1FNEV4OUJYQXJlNWVCWXpQeWZrcnFTMSsxM0dzZXNTZE5YM2NrZUFJQlRD?=
 =?utf-8?B?TDFQWEVNbkpBakR1R3cxaHhLR0g5TDhicE5HUGVEdUZGM3hjc1RmWDlXazVm?=
 =?utf-8?B?VVJsczRwVkVONm1pQUpxeUxFWElDL3BiNEdnQjUvYUtycVJqRXNrbEdTL05l?=
 =?utf-8?B?bkVvSkdWQlRUdzkrUk5LLy92L0dEeXdpUjliOGZOSGNIL3RMcFJNZFJsL2Zl?=
 =?utf-8?B?S0c1VDhGR3E5QWVGOUV1eFhSODVXTDh5K0VGYUlJZ2tsdVNvODZ2bnpMM0FX?=
 =?utf-8?B?a3ZteGsxTG14amt1WXo4dFk2VHpNeWdBbU9BZEthTlZVMnRucm0xWUhKdThW?=
 =?utf-8?B?NGYxdlc4dnNTNFRtVzV5dWd3bjM2a0xHcFBERDluVGNxcHBiNkdid2VZUDI4?=
 =?utf-8?B?K2VNWGYxejhCMmlOTE5IQjE5UGVZaVdGUTZXL3hhL2ZrQVNFejZlaFV0MlMv?=
 =?utf-8?B?WStxeHhXZkE1R25vUzgvb0ZqVW1EUVBKTkF2cFcxNC9Ob3gxVkNKT0h4azk4?=
 =?utf-8?B?SGNWRHZMdHhkdytxTE5pWko3NlY5LzhKVWtSdFJqVTlzTUhDdDBNOFo4KzRn?=
 =?utf-8?B?dkdUdGtaS3VnR2VXZ084VHgxTU1oZ3NDNk00Zy9aUityb2s1ZXJJcUk4U0Q1?=
 =?utf-8?B?QjFIUzhQcFgzQmlXelV1YjdzV3Y3ZzVJTUk4NmN2YXBwdGd3WjJDK2tVSVdk?=
 =?utf-8?B?VmRXcU1LRENOczhVbXdxYUZLZzJTSFVyZ3FKeXE3VDM3MHBaKzUrZndvNEFO?=
 =?utf-8?B?M0MzSmtHNlFiUVdhUkJ4ZVdDQnhIMUJVb2cyOVB6V1Y4Z2FsUW4rdWlOcE5h?=
 =?utf-8?B?cXV0M3YzQXlkd1NUS1VkUU5DaUlpcnZCd3lRd3lsRmpRVVRCekhyUnVBV1hq?=
 =?utf-8?B?N1hZc3E0d1FwSHZCdEZTeS9VUkd0MTE1eHJOajNlaTJYNGllT1RzRDk0Ri8w?=
 =?utf-8?B?dUZ4K0l2QlFLUVNvRWVWUEV0Mmk2N2dhQ2NxL1J5aGJBL3dIK0R5d3ZzZ1NK?=
 =?utf-8?B?SnZBREtWR1N5MXc2K0w3MG1lMmR6THFqK01BTGppZWliYzZ2by9rY0VyMFRx?=
 =?utf-8?B?R3p4YStITkw2WlhnOTN6RjVSY05saHNmSGxCcHVmWEk0ZWF2SWZWU0NRM01Q?=
 =?utf-8?B?eUo0cVdXbVVDbTJ5c0tNbjZzV0k0WTllN0VXcFpzK1Z6Qko3Z2RzSWN6czRI?=
 =?utf-8?B?dFV0cXIyTm8vVGlkNjZ3NEljaWt1bldwcEZLeW9QTE9UcDQrbWpBUWxRUnZ2?=
 =?utf-8?B?U09rY3ZLd1VVVzhhWU9QWElFYzJiYTAyWjh5UzNmRVJPY2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1RPKy9RbW85cFNhQWhISSs4LzB6WFI0MHM1SjVyaXptRFRKaXJUMzdhS3p6?=
 =?utf-8?B?NjZhbEJtU3AxSXY0ZmxHVWtGVUMwQjlQRHJNZ3RwTVQ2NUFYVHcyQ05aNnVq?=
 =?utf-8?B?Lzk5MllGdy91dkI3bVgwRXk2dWZydmtpWGFXanNvT0QwVGhqbnFSZEF6S3NR?=
 =?utf-8?B?QTB1bFl0RVVqUCtBdUo3cjlQMm5pN1prVFJVVm11ZjViTTh4UWsyWi9HaDdO?=
 =?utf-8?B?d01FNmw5TjZKTytIdnhGT0pqTGJWMktPVzFPcXFvS3NKRVZ6Y0svTW1ibmo3?=
 =?utf-8?B?SURZZmZpckJTZEN4MG4rUmwxNllmMndGaUNHcUs1NEpkSU9SNVVpczdzZXZU?=
 =?utf-8?B?Y1l2d09GNHdFRXJjSVJPSHBLYXRROTl1SEpMbEwydmhJazU1VlZBV0xwaEV5?=
 =?utf-8?B?dy90QWlNRWUxV2h6K2Fjcm44MExKOG12WEhGUUJoZVA5WmF1MmtIaDI4YStQ?=
 =?utf-8?B?cnRkcnZiZTJQZkxFQi85dnkweVlPM29pYWNZMVRqSmhQMWlsUTI5aDUvS1ZD?=
 =?utf-8?B?UFloQXovNVdQaFZYandyMnhyVmV4aVgvUzg0UmRqOWRLd3g0a2JPREtjMzZH?=
 =?utf-8?B?cVo1TXlWemxZa2cxdE8yVzhxbm5LNmoxUEtqdStYMGF2ZHcrbjErWUZJUllr?=
 =?utf-8?B?RkREZjhOUHY5VENQbk9lZXRqT2FINDJORWVteFExSk4rR1A4eDc2WE5Bb0I2?=
 =?utf-8?B?OHZwWkU5YUN3cm55QWJ5QzVza2Rzbld5NVVHcDdYd2N6MlQvbG1MWVN4eW16?=
 =?utf-8?B?bnZUZEg5dFcvV3hvYjhBRjNyRXloZkhnOURqaTFoY3ZTN3ZLTW5MQkN0aTFO?=
 =?utf-8?B?Yzk3VkU1TGxEMkJTczZ4OXhqN0QrTUhKUGpvNm9TYVVwWWZPTjZNdXRVWnFp?=
 =?utf-8?B?Si9VWDg2UWhoUEppaEIxbFdEcllKckJhbXAyNlFSRmcvUkNzR2p6dlNDRVUr?=
 =?utf-8?B?VTNiN21DWG9DTnB2clpYdGM0WHJZcEQxd3I1RER5ekZyQXRFNndqYjdmZnJN?=
 =?utf-8?B?dzQyS0RKRVpMZE16cSt5ckxXWkprRnUrbTB6b0hUYUxaUm1lei8xblNISVFY?=
 =?utf-8?B?b0lFRjQrdjlEclJxa1hvTFpJdnN2WWJMRWlsZ0E3aktXTU1mUm9RWFY2aE11?=
 =?utf-8?B?eVh6d3VPL3VJM1NoS0l5ZU5oZ1hFSVg1bWtvaFFmVnhxa1QzRkcvbVRPQVAx?=
 =?utf-8?B?eDJnK0dZVGdpS2tTTHpPV0hDRUprZU8zNjBwcHljekxYd0JJU0xhOGMwRkVw?=
 =?utf-8?B?T2kybmh2WURHMjBsdFJuNW9lMnFyZjZDMjllZ3BONDZWUVhmVEc4aGxLVFRN?=
 =?utf-8?B?aU1WSjZBbTYvMDUzYTVMR21majJJRHkzZmZRanFxMEZjYTcza3dMaTVkeUp5?=
 =?utf-8?B?Z1ZaMHZ5YzdlRWJHbUo3V3Y3eDluZHdEQ0pQYU05T21oWFRQeXpUT3lwaGYw?=
 =?utf-8?B?T01TT2h5blBrNTVtTUU0WmIwOG1nVGU0MCtRcnVzYzhZcXZ6R1ljL0d4b3Bi?=
 =?utf-8?B?cWdIdlFPOWZSZ0syRmxxVlIxc3NycE1UQWU0WDFkR1pWV2J1V1F4eWtuYzdW?=
 =?utf-8?B?NUtzT0g2QXN5dlRVMjJQN0c4V1dDaCswaEFtYm1OUnR4R0ZwY0x2Ui9pSlVI?=
 =?utf-8?B?Mmg4aTcrY0dkTHVMR2JlN3BYa2xwRTM1b2N5YXB3ZDdDQldMd25pS3ZXYzhv?=
 =?utf-8?B?WmRzSXkrb3FvVzNtcUsyMWM1WlZSZTNSMmJJNERNcmRKYk4rWVFWTWFURW5I?=
 =?utf-8?B?SnNJMHRQemtGeVl2RXNoS01JWWNNY2FOMXJQVHlyS1NnR1VCc1Y3ZnJXSGlT?=
 =?utf-8?B?aXhBZXlmdnI3MXlUQ21na2dMQ1RPN0NQUE80eW9NOXZNdHVNZU01Rmp1dWNt?=
 =?utf-8?B?dmtZRkljODNmQk9EQTdGTjUyRE0zUzRIZFhrOG9saFNaeWlTajNTWXBqQ3la?=
 =?utf-8?B?YWR0T2VjZnNFdDYveHdhaGVBOGtGa3M1ZFMwTVJJTzYyWE05QUtaZkcxU1ZX?=
 =?utf-8?B?ZVYvTVZVc0xONTNaTUNzdjdON0RvN29xbHNMdENsUXdmaUFsbFo0a3UxcFVT?=
 =?utf-8?B?bVNPU21salVzcG8xdEU1V0VjT25oZlhRdnZ2Qnlkb01sMFJoSjVzazZRTjFN?=
 =?utf-8?Q?hZ2bsjKd6+DFX9WhcBIk736Ap?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158d0ef4-1bb5-4ab1-49fa-08dccbe751ff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:09:15.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IE688/sobZniVYe0VCJ1gswfYp369hu+B49qngJhbvu1gvNHdan6blQpjtqePzIV3YKJbRbqmhX+wMk1mP8DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9365

From: Peng Fan <peng.fan@nxp.com>

Add cpuidle node and enable cpuidle for A55.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index d031b9548aaf..a7e411f1daa6 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -22,12 +22,27 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		idle-states {
+			entry-method = "psci";
+
+			cpu_pd_wait: cpu-pd-wait {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010033>;
+				local-timer-stop;
+				entry-latency-us = <10000>;
+				exit-latency-us = <7000>;
+				min-residency-us = <27000>;
+				wakeup-latency-us = <15000>;
+			};
+		};
+
 		A55_0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
@@ -45,6 +60,7 @@ A55_1: cpu@100 {
 			reg = <0x100>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
@@ -62,6 +78,7 @@ A55_2: cpu@200 {
 			reg = <0x200>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
@@ -79,6 +96,7 @@ A55_3: cpu@300 {
 			reg = <0x300>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
@@ -98,6 +116,7 @@ A55_4: cpu@400 {
 			power-domain-names = "perf";
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -115,6 +134,7 @@ A55_5: cpu@500 {
 			power-domain-names = "perf";
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;

-- 
2.37.1


