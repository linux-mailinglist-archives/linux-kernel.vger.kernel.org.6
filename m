Return-Path: <linux-kernel+bounces-510663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1E9A32020
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722B716754E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574D9204F8E;
	Wed, 12 Feb 2025 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LrnUpXcx"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1711204F6F;
	Wed, 12 Feb 2025 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346104; cv=fail; b=L3FSpiG3Jb6FyhMopRMIoE1n0FyaQD+Mgpljxd4NqZAnyoO3EIdvsiJPv5KedQl+F4CmAIGBMgOBjio7SQWoEfRjWPf8f4L4MQiOd1uZXMUqkE/trzxee+n1Ae9rERijQ48V43F9ev0uZJFMG+9To4lKuAoG92e0gtmcu2CEzCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346104; c=relaxed/simple;
	bh=B9WCtZzNDzcAv0zYcRKrn1wJyQpqdYdt5NkZOxIAptM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lXsSgimjfs71pbcWDOGmZ93nzMutUJJg7uwSx3NaQDmR3EMZu0DU3KQaPKLtYSaSuG+4mYqDN3HmvSN6yGkDu5FSHA/RATsmsdOaAmj8FI4NJl1kJgFygLgStvtbDGsyi4zl047W6lhdav2PJrrydqmHBmFjmgULSw6luDHxQms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LrnUpXcx; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjeK6kEW/VK7yjEuSOZjd5SdMSDQtLKaoirutmjA7T31xwlKwN/gpmAcMJ8S9Lse3afj85ZRHGboLdhzb2UwDowjcVUc3aWTxsCH1dEpLHlTLOTAxhZeQM2UYS6uBkdEAtVUeAm8wUW8dYeKI6ABbKYzlEzDNUEOCn0IiB4s5uhkLRt9s7esC6JvH2jBf35VMGu9oT8Wpc225TegtVDOP+H7K2tQmzpGPdQvjIvkg62G/j3Jy56SFkUfENX8jrGRAX38Fy1hdggo/IUvo+AnqdODoO4vlG+2QrhuCy8JMSGGSGoZpx0urvcreirRpHyKDpLSb+B/9CX7C9YsETJhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwJ6/lxr9FomupW0m1i8fOytNWU+gCFsnxkKpEd8NDk=;
 b=Rh3ySw9n5WHsEjec8AC0IJOmC7I21v/KB/0KGUqbNHpNZzW51LBc5L1LWjpsttp5n7paZ8Pu2hU6oNCY7F30eSTs88LYVvXhXK0XaDT8p4rRm2ODeE+d5XemMoUh3XFacB54UdNXnkxj1R3Y9F9wacyTIYEU9c+RvmYNUAIN/o4A1GO19Z1GxtPnM4IOMUyZvkm1oV3ePPKcZMgr2C4/d3c2eCk41fNJuoQ4K3oUGO/WZbmv+tJCUVvo6X+DrUylksjY5tsAWp0rAwuwQFL6ub0xV1HXXoL4EZWlCEt823XkdCWYXznMgDE/09MA8C9ML9fZVScfQl6Gy2dsp6qbwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwJ6/lxr9FomupW0m1i8fOytNWU+gCFsnxkKpEd8NDk=;
 b=LrnUpXcxjirta3fst6DpLHXyPreDFVUSDzFdjaqdW0WvMDyPjXZ6qlUb8kTWy4sysA/Mam0V7eIrXeclZTcUB/2ZANKYGOeOLuF0RcIZEkt/DX5h87E40+oPwZq7qPRfoWDwaYmkw3OjcE3JoL/DBYL+Bb5Qiz4dZJyGwMEZPYtKGiwYyikzgnv3CQxLv6tOkjWDwdzSuB66umTrrxeCDt5U6YTg5GnlAcEYDwQuymLPGFZHrvpDkFstihgBvWyheUnt6JrSy5YdIUvtIDjfEYIJcDYgZwGRTZ6E5JWQnE+taNBSffqVUyaORTMkfgGkNytX+Ks4Jj9oleD1H3cmNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10865.eurprd04.prod.outlook.com (2603:10a6:102:48a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 07:41:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 07:41:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 12 Feb 2025 15:40:26 +0800
Subject: [PATCH v2 4/7] firmware: arm_scmi: imx: Add i.MX95 CPU Protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-imx-lmm-cpu-v2-4-3aee005968c1@nxp.com>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
In-Reply-To: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739346036; l=10406;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=NvFULzB1HrCABVbOpkyWAcBVXMReXmha9//xPqxA0GY=;
 b=l9oAkRR1pIEzmROiDzXNITKyd0in4P9MIeQBsOTb4sy3cnyNczlBh5AvXzPmWvj+xqmB1Z3VA
 QSkj82HcQD4Dkpjv8nM+CUYIJKZ2P5hvQqkEhqUA0qiO7FEoazwZp7O
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10865:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fff6577-7ce0-4882-c380-08dd4b38af41
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWNucVpzKzlNUkd6N2I2UlB4cjlpQUpmcEdQSVZxbm9wNkZYaVNmb2hiMUlm?=
 =?utf-8?B?SXBucFZvczJtNHZNVUJYT3BLTFZ1Mm83OVRGcVJVM1VUVVA2RE1QVFdaSzAz?=
 =?utf-8?B?ZjFSWWdrSmNrQ0tYcVBGeG9xeWVReUZVeDNQVUlvUzR2T1NzNlZuUERUZWpk?=
 =?utf-8?B?dG0rZjBvZzJRVjFmUDd5bmNIWW9ySHNIMzVVbHAwWEQ2a0JCVll5clRYTXpl?=
 =?utf-8?B?YmM2ck1VbWl0VVRDTERRbmJ2MVpLTkpNZXNPMDFGMngzVjh0ZS9yM0FGSXR4?=
 =?utf-8?B?NzZmM3BSd0VIeC9SbStXdWVUb1V3SE9ENnFBai9pTmNlTXd1aXhSUUNmV1R6?=
 =?utf-8?B?OFp1Rkh3SUswNTFsNnk5SXg0dUZZM2k1WjViZm1SaUFXNktocWlJZ0k2U3VL?=
 =?utf-8?B?Umd5N3hLMjI3V29xU0puZnZOdlFmVW9OcG9rWWVZS05JUk1CbTMyOHMyM2pU?=
 =?utf-8?B?YVV5Z21Rd2VacVYyRkd6SkpvcmNxSGFLVmNXTi85dTZCUTVFQUlRSnVNSlAy?=
 =?utf-8?B?ZnlTVU5QNEVIWUdHSVZDWjMvdGpXaHkvWE5nM2xSdU04WEp3Q0FFaXRmUEln?=
 =?utf-8?B?ZHo0ZGJ6dGgrSlAxY1g0Snk5eHF1c3pMeEFkMXpta1lPR25CNnZNRHJGek5p?=
 =?utf-8?B?SnZ0VkRBSGFOYXhVOFQweVV6N09jQS9FaEhhQmN0VW5rT1F2cnVZdE9wUUxH?=
 =?utf-8?B?NXhCdjFpODlpY3NEQ2p5aWFPU3JTMXFhVUJ5UHhkK0c1OEVSczBSVVV6dkFX?=
 =?utf-8?B?ZnpRUUZWZjM1WlFvOTFCMVFGcTVVWTlXbzF6T0M1TXNOSHFQTEcvSVlkNDdQ?=
 =?utf-8?B?WmNJa0QxcHJlRzlma1pDeVJXckorWFVMQzRRTndzUGxkUjQ1Y1pwZW9EOHVY?=
 =?utf-8?B?bEFQUHFMUXdDaVNOM2pJYW5tSGRKdlFDTVhGYW9kTmRTY25KV1RoNHRHd1FB?=
 =?utf-8?B?Mk9kejhTbE9rZmcxZUVxMUpneXNYSU45MFByVnE5QVNxbDRTOHVvd1pTc1RG?=
 =?utf-8?B?aVp3ZWRZczBwRkNJRVlwSjFxS05FTEp6MW9Vc2RuN25kWlUxK0lacDRWSWg1?=
 =?utf-8?B?bkRUa2RSOTZMUlhxc2hBbVRVQ1ZhVHlZTG4xcVJMOVhydkNQQlY1STFoV3FX?=
 =?utf-8?B?bWh6dXJLaHF6RnJ6a2N2MFZtcTRVM1hMdThJRnhHSklBVjRoMTNhTnhDamt4?=
 =?utf-8?B?b2RzY2dOVnVXUjJUcWZRUVhVNU1jem81eVNERGNZb1RGWGYwM2cvUTN2OG9O?=
 =?utf-8?B?VjY2dVZCbVVOQnBNaXJrenBTVVdRRzIzOFd4alppTExzTzlXQ1NMeHFJcGtD?=
 =?utf-8?B?Z04wRHF1b3l3UERGSC8yL1ZENmxEQTFzb0FWd2hGVlVuWUE1WjZIcVBiRHJ6?=
 =?utf-8?B?NDJaZXc2VWtydUtHV0doUGYzRU44QTEyVzRyZzhvc09aRHJyaEFmQUpJQXdB?=
 =?utf-8?B?MXQ0VHpqaWZVMU9zakpHbFgyYk85OU51WFI4SzdIcW8xekxXcTNHTkNkdDBy?=
 =?utf-8?B?UnMrcE5hSWxIOXdyeGlOOTMvY3FpQnhRZlBBZlFtekN6QjNWdk9DU3pQTDE1?=
 =?utf-8?B?dEFKVGdWS2Z0VmFybE1WdUFpLyt2WTlmSjBVcWpnbCtkVWxPczJXZTB3eENo?=
 =?utf-8?B?bENxOS9KU3V3RmNTWm9CT0t4SHkrL0FQc0xJOU9QVHJUdTFGT0E5di9oVVJo?=
 =?utf-8?B?eC9wT3VSOUphUlJCaUQrVzZibDlxczZ4VzhTeGdZMUtWbmNwWHVrWEtKd05p?=
 =?utf-8?B?a0pta1RRdjdFMlQyRFZRMVFzQzU4TnpmWVI2SmFoRFNYL3hJdUZVT0lGS0hT?=
 =?utf-8?B?WVVKR3JHbjl1QWRqZWc0WnZFaWNwQWhzUFpMN1BWR3hwcGJVNWQ0MGoxdWFB?=
 =?utf-8?B?SHU0ZHRGTSsrSy9uUFExVHhkTDlKYjAzOHM0YThtSCtyaVlIUHRkY3hRRVVw?=
 =?utf-8?Q?fQ4GDk5NbkPPb9e6vSybY7/+1f5ELEHL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2RocDhjZCtmT0NXdUMvL0hFT2ZsY3FxTkxDTWlsQ0xnZCtLN0pXZG9JYzlJ?=
 =?utf-8?B?V0UyNElNZUp2RWkxWUdzVkxPUDhTZzZ5R1JadFU3ai84Y2wyKzZRUDJDNzcw?=
 =?utf-8?B?V3BsNkU2cThxdTVWVlhKU3VPZllOZ3NmbmFzR2E1ekcyV2ZyTk9IYU9kR1Rt?=
 =?utf-8?B?eGR3NEZrdENUajcvcVI1WHBDT3JHYlZPODVQV3VNMGs4SHhZR3N6QzZDS0xt?=
 =?utf-8?B?Y29ISENnNFFrdmMxeXJPVWJ0QmNvMXIwbUwybFh0ano3dmpSTlpWU1Jmckdh?=
 =?utf-8?B?ZDR2U0o2RitWaWhsYUhpcDZPY1RMeHpGQW9OUUp4OFdMbDYyd001K1haMlo5?=
 =?utf-8?B?QkZJYTVUSXBNMmU4SVZUZVRrck5rcWRhL2NXdjdnMElXSTJJdmd4Mjlud0hV?=
 =?utf-8?B?TnIwNlk2TXoyRHg0WE8rclcxS0oxSEdhUEdrWjB4Ym9SNGtRYVBlTm9SeG45?=
 =?utf-8?B?anQ5UnJ2aWJpMkpZdUR1NXp3OVQ5MWFsVUgvd1c1NDVxQU5CSnBCdVRSN281?=
 =?utf-8?B?TFBKRUVQN0Q3RlRUREh5THIxUWNRc1BxLzBMU2RhTy9lbFpjb25WTWhZY2lw?=
 =?utf-8?B?alh1YW1DbWFFa21aVi9qSE5tNzZiZkVpckMzV0JFYWxSNEY4RDJkQTJXdnFJ?=
 =?utf-8?B?Zm9QNmxIVUVvWkhEemRpV2FJSGc5L2JLYWpYSUExTldJdHBSV1VoWU0wMXBK?=
 =?utf-8?B?VUlaWC8xS2lrZ0IwS3NJay90aVdJYlhpWTROT3lVbEljMkpySnMwMHc4di9o?=
 =?utf-8?B?U2VnNENEQVVEZ2hnTmRqdDlJSjY4d3MvdVY5WXVUaVc1aWh4dzg0ZldQbmox?=
 =?utf-8?B?QmMxcUQ4RkxnRGVEbTJiQXhzSVdVWmpvQ1N1WW1IWTNNUnp3bjl3ajJpTTdS?=
 =?utf-8?B?TkRlbnkwUlVJQ0NDb1RFY3MzMlpqbFN0OEVTekJZZ1EyekIwVUI3NnZCeGx2?=
 =?utf-8?B?bC9OS01DUm5RcmdVQURXRDhkVE52NnBvbWpIdnJMZ2FnNTBlazY5dUw4Qk9O?=
 =?utf-8?B?cDNOYzVwZ1dxWWROaXl4OEtaVUxkWUJNczArWVFvc3lQUURyMDlsV2orMXNC?=
 =?utf-8?B?S00vTVY4R0E3SGROYnJxbXRSNmZuMFRQZ1RmVGs0eUQzeHBId0NQRUN1cmZF?=
 =?utf-8?B?UUlCUURYcWRDdysvK0NmTjdHSVVIVjYxVnFIbWJpdkdRMGgxSlhlZVhFZFNC?=
 =?utf-8?B?c0tJbXFFQjMrdFF4aG5tRzBJQWFDV3ZxK1NtTkVRdUdsOVpkK1VacW91NVhY?=
 =?utf-8?B?TW5JNDF3UFRNdTVQakNKVHJMYkZqbTJURGcrY2dyWVZuN2NIai9Wd3NaRzBo?=
 =?utf-8?B?Z3o4c2xzRXN5QW1WMEVuZS9TdWhQZm5KQmF1M0lyOUFaVWF6Qzk4OWgwMm5m?=
 =?utf-8?B?bndhYWlmQzRTbCtoRFVybEJkaWpWbjFVbDJudUNyOFhlN0syYTR0MldTQ0Jo?=
 =?utf-8?B?bUtEY1lDOE1iWkYrb3dVblZFOEFOWEE2U0lVUVJGNmVnWFNpcjJSemVRT05w?=
 =?utf-8?B?dXFDOEZBOUdaeWNWRDluaGdrMFpwSUd5a1FnMEkyN2Z4czZXcm02Ti9wSXl5?=
 =?utf-8?B?cUZ0QmQvUTkzbmlRRHZMUm9BeUF3OTBQQmFnYzNCNm9HZzh2ZnQ5SGpDcHF3?=
 =?utf-8?B?S2hIcFc5ejR5bTEwWnVlTVppcXpYSS9NYnQvbGhpeERuS1daWDFHVTJEeUY3?=
 =?utf-8?B?alNONm03eU1vUW5qdWloYnBWd2JpMGJCeG1ZSFlVRVc4cytwQzFHNkgwV3dz?=
 =?utf-8?B?ZVRWeVdocDZ6QjlxVjBMMktxWFluUmN5R1NvMHVFWlJwT0lBQ2VRZ3M1SjlZ?=
 =?utf-8?B?b3djcmhEZ1RSVXQzNXdxMnV5eTYzSHpLa2sycTNHSk1NTFlZZ0JTRkxnZzZZ?=
 =?utf-8?B?b2VtMXZGM1pmL2lOejMxVW5IZXlWTXp2c0FIY3VGS1o3VmM5MVFqazJCSnZS?=
 =?utf-8?B?Wjlvb0xNWG9zRVk1M1doamxQRGVZWTBnZjh6bGgzV1Uxa2tlSlNMeDV5ODI0?=
 =?utf-8?B?NEkyOEdDNjk4RWlmaWF0NGdIMlJuVDZObHZ1VXd2eXh2Q1NNU1hxTTdBVUNw?=
 =?utf-8?B?cVdnYnFpbEdnRFZUNERDb1drMTBFTU1zUllGOElrS2pjeStWcnlHeGFZMlJh?=
 =?utf-8?Q?gY4eXYaUbhHs7Um/f0m6G06fL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fff6577-7ce0-4882-c380-08dd4b38af41
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 07:41:38.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTq14Xx/KR32vngWvfaC7+IT+9TgSrUhJR9vGovO76RmcVtggl4DbRVkTJyQxJe2J3jLxwmll9bInXDjJ76W0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10865

From: Peng Fan <peng.fan@nxp.com>

This protocol allows an agent to start, stop a CPU or set reset vector. It
is used to manage auxiliary CPUs in an LM (e.g. additional cores in an AP
cluster).

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/vendors/imx/Kconfig      |  11 +
 drivers/firmware/arm_scmi/vendors/imx/Makefile     |   1 +
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-cpu.c | 287 +++++++++++++++++++++
 include/linux/scmi_imx_protocol.h                  |  10 +
 4 files changed, 309 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/Kconfig b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
index 1a936fc87d2350e2a21bccd45dfbeebfa3b90286..b5f13d0e40155e485f4d1696e9550645d888ef44 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/Kconfig
+++ b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
@@ -12,6 +12,17 @@ config IMX_SCMI_BBM_EXT
 	  To compile this driver as a module, choose M here: the
 	  module will be called imx-sm-bbm.
 
+config IMX_SCMI_CPU_EXT
+	tristate "i.MX SCMI CPU EXTENSION"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y if ARCH_MXC
+	help
+	  This enables i.MX System CPU Protocol to manage cpu
+	  start, stop and etc.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx-sm-cpu.
+
 config IMX_SCMI_LMM_EXT
 	tristate "i.MX SCMI LMM EXTENSION"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
diff --git a/drivers/firmware/arm_scmi/vendors/imx/Makefile b/drivers/firmware/arm_scmi/vendors/imx/Makefile
index f39a99ccaf9af757475e8b112d224669444d7ddc..e3a5ea46345c89da1afae25e55698044672b7c28 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/Makefile
+++ b/drivers/firmware/arm_scmi/vendors/imx/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
+obj-$(CONFIG_IMX_SCMI_CPU_EXT) += imx-sm-cpu.o
 obj-$(CONFIG_IMX_SCMI_LMM_EXT) += imx-sm-lmm.o
 obj-$(CONFIG_IMX_SCMI_MISC_EXT) += imx-sm-misc.o
diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-cpu.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-cpu.c
new file mode 100644
index 0000000000000000000000000000000000000000..c815b58897c3b74dcc8ffdbbde9714f3c7e0784e
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-cpu.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System control and Management Interface (SCMI) NXP CPU Protocol
+ *
+ * Copyright 2025 NXP
+ */
+
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+#include "../../protocols.h"
+#include "../../notify.h"
+
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
+
+enum scmi_imx_cpu_protocol_cmd {
+	SCMI_IMX_CPU_ATTRIBUTES	= 0x3,
+	SCMI_IMX_CPU_START = 0x4,
+	SCMI_IMX_CPU_STOP = 0x5,
+	SCMI_IMX_CPU_RESET_VECTOR_SET = 0x6,
+	SCMI_IMX_CPU_INFO_GET = 0xC,
+};
+
+struct scmi_imx_cpu_info {
+	u32 nr_cpu;
+};
+
+#define SCMI_IMX_CPU_PROTO_ATTR_NUM_CPUS(x)  ((x) & 0xFFFF)
+struct scmi_msg_imx_cpu_protocol_attributes {
+	__le32 attributes;
+};
+
+struct scmi_msg_imx_cpu_attributes_out {
+	__le32 attributes;
+#define	CPU_MAX_NAME	16
+	u8 name[CPU_MAX_NAME];
+};
+
+struct scmi_imx_cpu_reset_vector_set_in {
+	__le32 cpuid;
+#define	CPU_VEC_FLAGS_RESUME	BIT(31)
+#define	CPU_VEC_FLAGS_START	BIT(30)
+#define	CPU_VEC_FLAGS_BOOT	BIT(29)
+	__le32 flags;
+	__le32 resetvectorlow;
+	__le32 resetvectorhigh;
+};
+
+struct scmi_imx_cpu_info_get_out {
+#define	CPU_RUN_MODE_START	0
+#define	CPU_RUN_MODE_HOLD	1
+#define	CPU_RUN_MODE_STOP	2
+#define	CPU_RUN_MODE_SLEEP	3
+	__le32 runmode;
+	__le32 sleepmode;
+	__le32 resetvectorlow;
+	__le32 resetvectorhigh;
+};
+
+static int scmi_imx_cpu_validate_cpuid(const struct scmi_protocol_handle *ph,
+				       u32 cpuid)
+{
+	struct scmi_imx_cpu_info *info = ph->get_priv(ph);
+
+	if (cpuid >= info->nr_cpu)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int scmi_imx_cpu_start(const struct scmi_protocol_handle *ph, u32 cpuid)
+{
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_START, sizeof(u32),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(cpuid, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_cpu_stop(const struct scmi_protocol_handle *ph, u32 cpuid)
+{
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_STOP, sizeof(u32),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(cpuid, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_cpu_reset_vector_set(const struct scmi_protocol_handle *ph,
+					 u32 cpuid, u64 vector, bool start,
+					 bool boot, bool resume)
+{
+	struct scmi_imx_cpu_reset_vector_set_in *in;
+	struct scmi_xfer *t;
+	int ret;
+	u32 flags;
+
+	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_RESET_VECTOR_SET, sizeof(*in),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	in = t->tx.buf;
+	in->cpuid = cpu_to_le32(cpuid);
+	flags = start ? CPU_VEC_FLAGS_START : 0;
+	flags |= boot ? CPU_VEC_FLAGS_BOOT : 0;
+	flags |= resume ? CPU_VEC_FLAGS_RESUME : 0;
+	in->flags = cpu_to_le32(flags);
+	in->resetvectorlow = cpu_to_le32(lower_32_bits(vector));
+	in->resetvectorhigh = cpu_to_le32(upper_32_bits(vector));
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_cpu_started(const struct scmi_protocol_handle *ph, u32 cpuid,
+				bool *started)
+{
+	struct scmi_imx_cpu_info_get_out *out;
+	struct scmi_xfer *t;
+	u32 mode;
+	int ret;
+
+	*started = false;
+	ret = scmi_imx_cpu_validate_cpuid(ph, cpuid);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_INFO_GET, sizeof(u32),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(cpuid, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		mode = le32_to_cpu(out->runmode);
+		if ((mode == CPU_RUN_MODE_START) || (mode == CPU_RUN_MODE_SLEEP))
+			*started = true;
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static const struct scmi_imx_cpu_proto_ops scmi_imx_cpu_proto_ops = {
+	.cpu_reset_vector_set = scmi_imx_cpu_reset_vector_set,
+	.cpu_start = scmi_imx_cpu_start,
+	.cpu_started = scmi_imx_cpu_started,
+	.cpu_stop = scmi_imx_cpu_stop,
+};
+
+static int scmi_imx_cpu_protocol_attributes_get(const struct scmi_protocol_handle *ph,
+						struct scmi_imx_cpu_info *info)
+{
+	struct scmi_msg_imx_cpu_protocol_attributes *attr;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
+				      sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		info->nr_cpu = SCMI_IMX_CPU_PROTO_ATTR_NUM_CPUS(attr->attributes);
+		dev_info(ph->dev, "i.MX SM CPU: %d cpus\n",
+			 info->nr_cpu);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_cpu_attributes_get(const struct scmi_protocol_handle *ph,
+				       u32 cpuid)
+{
+	struct scmi_msg_imx_cpu_attributes_out *out;
+	char name[SCMI_SHORT_NAME_MAX_SIZE] = {'\0'};
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_CPU_ATTRIBUTES, sizeof(u32), 0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(cpuid, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		strscpy(name, out->name, SCMI_SHORT_NAME_MAX_SIZE);
+		dev_info(ph->dev, "i.MX CPU: name: %s\n", name);
+	} else {
+		dev_err(ph->dev, "i.MX cpu: Failed to get info of cpu(%u)\n", cpuid);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_cpu_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_cpu_info *info;
+	u32 version;
+	int ret, i;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_info(ph->dev, "NXP SM CPU Protocol Version %d.%d\n",
+		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	info = devm_kzalloc(ph->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	ret = scmi_imx_cpu_protocol_attributes_get(ph, info);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < info->nr_cpu; i++) {
+		ret = scmi_imx_cpu_attributes_get(ph, i);
+		if (ret)
+			return ret;
+	}
+
+	return ph->set_priv(ph, info, version);
+}
+
+static const struct scmi_protocol scmi_imx_cpu = {
+	.id = SCMI_PROTOCOL_IMX_CPU,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_imx_cpu_protocol_init,
+	.ops = &scmi_imx_cpu_proto_ops,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+	.vendor_id = SCMI_IMX_VENDOR,
+	.sub_vendor_id = SCMI_IMX_SUBVENDOR,
+};
+module_scmi_protocol(scmi_imx_cpu);
+
+MODULE_DESCRIPTION("i.MX SCMI CPU driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
index 07779c36ef9a126907e26e304a8feca16fd60ab2..6aa76580718f2604a5da25f71fff564cf59dab45 100644
--- a/include/linux/scmi_imx_protocol.h
+++ b/include/linux/scmi_imx_protocol.h
@@ -16,6 +16,7 @@
 
 #define SCMI_PROTOCOL_IMX_LMM	0x80
 #define	SCMI_PROTOCOL_IMX_BBM	0x81
+#define SCMI_PROTOCOL_IMX_CPU	0x82
 #define	SCMI_PROTOCOL_IMX_MISC	0x84
 
 #define SCMI_IMX_VENDOR		"NXP"
@@ -88,4 +89,13 @@ struct scmi_imx_lmm_proto_ops {
 			    u32 flags);
 };
 
+struct scmi_imx_cpu_proto_ops {
+	int (*cpu_reset_vector_set)(const struct scmi_protocol_handle *ph,
+				    u32 cpuid, u64 vector, bool start,
+				    bool boot, bool resume);
+	int (*cpu_start)(const struct scmi_protocol_handle *ph, u32 cpuid);
+	int (*cpu_started)(const struct scmi_protocol_handle *ph, u32 cpuid,
+			   bool *started);
+	int (*cpu_stop)(const struct scmi_protocol_handle *ph, u32 cpuid);
+};
 #endif

-- 
2.37.1


