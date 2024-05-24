Return-Path: <linux-kernel+bounces-188485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DD78CE294
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93FA1F21733
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3E612AAE5;
	Fri, 24 May 2024 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SAJfiW5a"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D712AACB;
	Fri, 24 May 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540509; cv=fail; b=fV5t0+nb5K6xbRUK510SoWpYKp1pXREqgtEsAoOnKIBBXT/Ii0oTUu/0XDd5K2OZb36WSJFIxX6pcw+VptS0le6lglBu+0EtBXvma62ZGSUmCkbj1+Z7apmaATSB7DkTXXfUqyjm2tng/At+gGcbRrGa5cO13EspzdiD4Sw8jjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540509; c=relaxed/simple;
	bh=UST1CuimqEbriXSDjaucQsENlov7zvfPaJsa85c4Yn0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lO1oHV//BPbc2e+QfZixbi+hLuDTV8xUEdgWndMzU1nme1kFQ//FLO7iGUZ7vzgypB3Pgmc+T/Q0FIl7nrchx0YzPUtCFcr6QfeJSJPaEqzvE74cB27TUW2l0pD547OnHgm8tNOBoW+BXxf1r5pt6NQtnNoJjvvq4PR60xymxYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SAJfiW5a; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Od9Dug1wopLwMXwUL55VG8anG97DPn8ndU1FkEUUbobKP6WThlDCBhNd0WfLyF5tOj42GhZt+9MlaL0bFIoMUi7RuovcDEl+TV9NdbvO/ulvj83wgCqhQh1ZUu8RSPN9FQv6cEnt+bJmWuuOiQuXi5JofItSIvwAqFFVwJ75+LBJS2FH8Qqn5KcGE35sFK2dEDbpiTDbsZL8U1Kk8bJBuph+pCINHIXFqMYy5dfM/ml1TfX8b1udlWg/AL4g0tery4exmptmS2iUN8JqqJmFW49dRBBJKsFQPWU6Vwy6vYhi13HNQSxoj/DzJb/jKJcCmjK75EwKZOT+gVoRhQ3WQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NQY5udEZ6Omsl8pKuZ+IUofTK0jwbagvhq1E6uaoio=;
 b=RRv5CmxBCetvPEzHILcoovO13oC6u/lLkzNNorr40jGu0b7YSfEH+l+USPZEwb1z3201x3zsA3x8eP6fpZdcDBksNoI8QvT7KF6ovy723y1oR9T0wLnKY3qbgui46vquzvE81rQPa4EnroJ0nYF5XjGFVd30gTDsC703wfL3XcDLxhupQ3PUn+aHdKzpxoRfTEbPscFgqcSiKdWgaiXVaOMU1RNKVhvlcWWR4Sdr8wWBOsFy+WaUmCYEZ9TU8F05y4NNg+ARFevP7rBFtIJmzrgQL4dEB6gvpmK6QgiDoO8aNBVuiAFvzkPeTEtoT7/GSh2bO+3X5I8UEfA95ApYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NQY5udEZ6Omsl8pKuZ+IUofTK0jwbagvhq1E6uaoio=;
 b=SAJfiW5aouMleQ5Veb08DJDuibkTFZL8sfsj2IXX9ljqpWUaeYzz3H2uTKyopD0m6DoqVNjDhVmQ+QqqRxRUPoEbIVpflmRus6J0qiaJV+/NL9IIjCR1aeJhdFSEQ/tDUk7Th2lngcQw6YsDu6mTXbqNxnG201x0U+I/cMFc/lQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7149.eurprd04.prod.outlook.com (2603:10a6:800:12e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 08:48:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 08:48:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 24 May 2024 16:56:47 +0800
Subject: [PATCH v4 5/6] firmware: imx: support i.MX95 BBM module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-imx95-bbm-misc-v2-v4-5-dc456995d590@nxp.com>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
In-Reply-To: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541024; l=9301;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=KYTXizoOVzSc57FIiRlksrodLSf5KroN9SCC/ukM9b0=;
 b=yQzW0dtrAJUl8NZNLs95d+aCLrCAYAH+il+T0WnEUyCaHfk+nhykqizedGrUSiGgfaYDwqKz6
 f7gXNnWnILGBorWfVBmjCoFW+ONWzK7wLbfPvXQIigaoBN5HTQugmHb
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 262250b7-d1cf-4bcc-a00e-08dc7bce45b1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|7416005|52116005|1800799015|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTFlNzVKN21xSmVlQSszeW51ZXlwM00rZXlmNzNXSlZsbDdYSGxiVUVBb051?=
 =?utf-8?B?Um03QUl6K2YrR3BZTTRocGxZTnBvTG80aTJTVFpRSm9IVXQ1MmVOOUlsU0JQ?=
 =?utf-8?B?UHdRYWRYVGNjRy9oNFFSMXlCcVFpRDFLTXlSSnl1VUoydkYzaDdRTjh0U0NE?=
 =?utf-8?B?RVFHaVVjaTl0SmJaU3JjU3hXY0RNdjFvcXI2bk5HQWpUWGUxYjhBYkxteXlJ?=
 =?utf-8?B?ZFZUeTJKV0ZWdWJOVU0xY2VXQ1hzbVAzcnpHVlJBcWJFZkh0T1hsaEZiN1h6?=
 =?utf-8?B?elB0Z3Arb3RWSjhDamtVOGtnWWlUUFdUdG1lRkVCRTdnMktmZXhWUnpyTlRB?=
 =?utf-8?B?aHlNdzA3ZFBFM1pJdlg2ZC82bC9Yc0xHSmx5SklRNDNmMmsyeDZFeVBmbWJD?=
 =?utf-8?B?cGF2Q1doRGZsMm14MHg2YTJDQ2NBWDM3OEc1OXZZZzB5TzBSeXQ0NVNsZEFl?=
 =?utf-8?B?Si95SmZvV01Qc0Zod2tHempvQ2xzdTg4WXM5ak1hMDRBK2hlcEVJVFgyR2Fl?=
 =?utf-8?B?U0c3cmFJaFZydUppeU9KL3l3cmNkQzhmbjlJSFVkdUFJemZLbUs1dlZIRHNK?=
 =?utf-8?B?dU15WGtLdHRkQVNlS2pUV0Y4TTF4VDJCTWJ0WFlMM1lwZWhCSWttblRnWjY0?=
 =?utf-8?B?bXkzaS9sNkN4eStXTkgrU1J5OTgvUEpERVNSSnlGV2x2QTNtdVBaZGFmalVh?=
 =?utf-8?B?NXNOMG1sUVRuNCsyTUpoQ2JtRWU1a2RmTUNjZXpXVUtSUDV3UDFsZnNIOE93?=
 =?utf-8?B?eVkrV1JKanpQbUFOcFc4dWg5RnF3QXVmc1lwZGkrblV2akxyazE4Q2FmQnl1?=
 =?utf-8?B?eGpJKzRIMVZ4bGRsV1pidHlPWnEySWFuZlVxZ3U2dXhyOVJFVGFaSzVrVjYz?=
 =?utf-8?B?dTIrRWRxbXNrSzZXWExiVGhNT3g3L2E3ZmFvODladnUzL2tuTHUxRmsxWDlt?=
 =?utf-8?B?SUt0MnZ0OXYvYkZKdE9Cd0YwdDZUdlhOOEdUM3J2M1F5WFAyMExuV2Q1Y1dO?=
 =?utf-8?B?NlF2ZGRjWW9uQ1YvNjlRTmtUOC9BRXJlYktaR1JSQ3AyU0NjTm53UXNPbzVJ?=
 =?utf-8?B?c1ZtYmRWNWRoRzZBdzdzM2dmQXdoOTR6MnNjQzJQTW9MYVpGUmhvVUNnZi9S?=
 =?utf-8?B?TzRabFB5TlBNbWNRTW1GVGNheHVES3B1YkNxaXYveXNVOEdjSFBjUzNpVFd6?=
 =?utf-8?B?Q0dKNnlNSXQ3ZXErcjhUYWl3Nmhvcy9Ia29MYTZQcTlJQ0NEUlkrWmY5YlVU?=
 =?utf-8?B?K0F1czZKdVVVdkZZd3dIVmZmTzN4YmlOUXlMUWhHbHpvand5MkZ0N1ZFNHZZ?=
 =?utf-8?B?SHJMaGNZK3JLSVViV2R6RTJ2ejlucklBdG94N21adjBCTytHaHV3NzN3OWEz?=
 =?utf-8?B?VHNQcGFwNlVTZEVPS2FOUkczdWo2Z1pkaFBVYjJzRkhXTHRRcDFlMytmejhi?=
 =?utf-8?B?b3BIUlRQUWpYRlZ2cTlsYm90SEM1dXltNFNiOXNhYVp1NzRmWXBmR2l6RzZy?=
 =?utf-8?B?QXpyOTI1bDZuMXhzZFZWM1JUZWk0a2E5cy80TFgvajBJaXR4TzgrVnpuNlI2?=
 =?utf-8?B?Y1ByVFlqZHlkenlnYWpyQTVXRmlETk9iUHJGa09qZTdUb2V3c3ZUKzU5d0ZK?=
 =?utf-8?B?K2UwM0d0dUlBZ2h5K1ZNNVpWVUlSVlhrbHhOeTlxNDhVS3hZb0NsY1crZkFh?=
 =?utf-8?B?LytPTGF5S29mQ3h3djdLQU9uTkpLd2F2OVFKRmdZNjNhbkpuT1lTalFkZnBZ?=
 =?utf-8?B?U0J1MlZjYnFRakRhYkYzV2tFMk1WdFBMaW9aQnlGbGc5TjlQSU9VV1o2ZUk3?=
 =?utf-8?Q?FXjnlRdMLB98H9yL1iy9FcRsBT4e0ELi8XSfw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1F6WU42MVp3dHhnQWI4akxYam5id1BYT1Nvc3RUeVUzaEROa255UEpINzZw?=
 =?utf-8?B?a3A4VUxaeTNsV0l5dWwzb2VnNVcxdVdoaDhFSzFFREdDdHU4VmVtZ2x2Z3cx?=
 =?utf-8?B?WW1kdnhxck5ncnZ0ZktGYkdPS04rU0VjMDhiWHBDSGJTelA2SGxXNGlrcFZm?=
 =?utf-8?B?akxkKzRTNXJsMGRDRXhKT2x0UzgrYmFleXM5TlgybVdQQlBub2gzdFFySzFq?=
 =?utf-8?B?MmpGdHBONlk3QkpETjdrTXA4WDFUNENENDc5Rll1QVlydU9GSCt3aDZxdkhr?=
 =?utf-8?B?cEJDZVVyVStwbWJtSDdvdjlvQXVaelR1ekF1U21kNlphYnVHY0NyeDN0d3VK?=
 =?utf-8?B?YXVyUktGdjdrc0Y1dlIvQ0toRjhmTGZleWoxNTlnTjN3bmRaTDhPOEs5ekYy?=
 =?utf-8?B?d20zUnc4ZXdPZXM3R0JrWHp6Q2l4eDBHTjNMN2pFWGVJczBaeFNOTWdkVEZN?=
 =?utf-8?B?R2U1ZGphNkkzWnJiOWRtc2NFMFRsWEd5ekl1OEFnM1FlckQzdjVVNkU1MHNt?=
 =?utf-8?B?RjlSL2kvYk51VjdIK21IZy9kK3p3emdFcGpXdW5Oc2tEWHl5dEFXKzhlQlJK?=
 =?utf-8?B?K1NaSmdqaFRWZjg2QUJNZ01kVlc1bytNcnlXaloxWmVxT1FucVdWVlZ4ZFZK?=
 =?utf-8?B?V1J5YWJPUXN4SG9kaWhzeHJMWmFVNE0rdnpDSkJ0Zm12ajc4NTB3U1lEU0to?=
 =?utf-8?B?K2FSelk2d3c0SjMxTXpCUHhCbVVIMVVFdG5sWWRaZExqT1JIQlNLY3VIcjY3?=
 =?utf-8?B?Sk1ldUVieG5CU1ZMeHErTTJBbGs0L2s0Y0R5RkJQazhveU1MU2RKUlhKbHJO?=
 =?utf-8?B?bjZUNVNQM2pROE51ZjJ3SnZxUUJYWlFObmhrdFF1THRnYnN3SzdPdWxtVE1H?=
 =?utf-8?B?V3lWcDVDbFUva1VjOVkzK1pyUXlqNlhKU2hFdUcvbEY2cUFLRjQ4UzNjdXg4?=
 =?utf-8?B?OWM3ck1LTHRXYy9Rek50dFVSK1FWL2VLazdMamhvdXNFb3FBVGErUHBRN3FZ?=
 =?utf-8?B?L0Q5QnJEUHE5SVpqd3VUd0VwUHdWb2s1R252Mlcxc1RETEErSTFmTjZhYTJL?=
 =?utf-8?B?djl3UXhwS3Zadm1TUXJPamFHRk9sRXFjOEM1bnArUldnakpjUGtTNFRjWkMv?=
 =?utf-8?B?UjRZUGZDYkRmTURZbzdyRWR4aTk1aUdwU1F0UmhmaCtUUGtHYVI2T3FKMWMx?=
 =?utf-8?B?SVR6Vm1QZ2lpa25FaFFCZ0tCT0ZpcENjYnBlN3FKbDVhbDlJM2lBYkh4Y2VR?=
 =?utf-8?B?UW00SGMxbjdvbGorUDNUdnhKdnlKZjdPdHZWdnY1OWY2cVM3ZXJ3Qjh6MWky?=
 =?utf-8?B?N0FsRVRRVHVlWERYL0xPNC84ai9xdlp0dWZSUUIrbVd2dG5VZVNlTXNOWnBa?=
 =?utf-8?B?K2k0T1d4WU1jY0V3QWJneGZyUVRyOE02TWZTVkZVSFAyRDI3UkppdkJDWlUr?=
 =?utf-8?B?TnJ3bll4dmJZeVRYbmtXVTdPTDdTRGlXMFlPVlI0aGpGTnJBL0RxTnU0Z1ov?=
 =?utf-8?B?THo1V1BTSytoUms4cWlCLzFyaEI3UnB6MFdycXp2djluVHlhbFJvWTJQc2lT?=
 =?utf-8?B?OGZzLzA5c0drRkozT2I0bWRBSnZQMUpTUzNPaGYyY2FxUTYzc1VWNUlBVlB1?=
 =?utf-8?B?c3dycENDZzhpbk1SZ3ovUGs3bDFsclJrRDVkejJad2RqQTF5THBYa2Vwd0N6?=
 =?utf-8?B?YlRpOEJ2YnpVZDFtbEovVlBIaGhXZ2U1aVZMMmlrdjZ4WFFyckt1WTRrdVpM?=
 =?utf-8?B?TStYaTB4Z3NBTm5COTZDa3ZScU1FdHFxTTlITDc3Uk5Fc29sNEM5aEh0Rzlp?=
 =?utf-8?B?eGZPLzFDb2U5VURwTnpVNjZrbjg1OE1rRlBodk81T3ZOZmF0RWY0MC9kemk0?=
 =?utf-8?B?MytXWE9lbTJPUWZUcVFScFp5M05TVzkyZ0hXMkVtL1VXWVpGTDUzY2wyaDVh?=
 =?utf-8?B?TGFvczkxMFY5c0Y0TTFxY3l1SXVBQTJOWFhqQ0VZTWM4VzVqeDhmUHdORWJH?=
 =?utf-8?B?VXBlanhUTTFLVnNuNnB2TG9ZbnlBZEhLcjF3VUlwNEN4MXJsaEc1MGhGSlNW?=
 =?utf-8?B?QnAyb0k3L2crWURKVVpLRWo5Y3RPNUxaV2tySHVqdlE1QVgzU2hFZGJMSFp0?=
 =?utf-8?Q?Bc7YtZ4SULCmx6OH0IUvAObbW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262250b7-d1cf-4bcc-a00e-08dc7bce45b1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 08:48:24.3637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2TFUp60S/dgfReowZnMSULWUWnHTpC+ysNpiLzhTDAphiEW7pqgzvs4YgJ0dopOuny93hTUC8Nf8pKOwy6P2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7149

From: Peng Fan <peng.fan@nxp.com>

The BBM module provides RTC and BUTTON feature. To i.MX95, this module
is managed by System Manager. Linux could use i.MX SCMI BBM Extension
protocol to use RTC and BUTTON feature.

This driver is to use SCMI interface to get/set RTC, enable pwrkey.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/Makefile |   1 +
 drivers/firmware/imx/sm-bbm.c | 314 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 315 insertions(+)

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8f9f04a513a8..fb20e22074e1 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+obj-${CONFIG_IMX_SCMI_BBM_EXT}	+= sm-bbm.o
diff --git a/drivers/firmware/imx/sm-bbm.c b/drivers/firmware/imx/sm-bbm.c
new file mode 100644
index 000000000000..5e7083bf8fd3
--- /dev/null
+++ b/drivers/firmware/imx/sm-bbm.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP.
+ */
+
+#include <linux/input.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+#include <linux/suspend.h>
+
+#define DEBOUNCE_TIME		30
+#define REPEAT_INTERVAL		60
+
+struct scmi_imx_bbm {
+	struct rtc_device *rtc_dev;
+	struct scmi_protocol_handle *ph;
+	const struct scmi_imx_bbm_proto_ops *ops;
+	struct notifier_block nb;
+	int keycode;
+	int keystate;  /* 1:pressed */
+	bool suspended;
+	struct delayed_work check_work;
+	struct input_dev *input;
+};
+
+static int scmi_imx_bbm_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	struct scmi_protocol_handle *ph = bbnsm->ph;
+	u64 val;
+	int ret;
+
+	ret = bbnsm->ops->rtc_time_get(ph, 0, &val);
+	if (ret)
+		dev_err(dev, "%s: %d\n", __func__, ret);
+
+	rtc_time64_to_tm(val, tm);
+
+	return 0;
+}
+
+static int scmi_imx_bbm_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	struct scmi_protocol_handle *ph = bbnsm->ph;
+	u64 val;
+	int ret;
+
+	val = rtc_tm_to_time64(tm);
+
+	ret = bbnsm->ops->rtc_time_set(ph, 0, val);
+	if (ret)
+		dev_err(dev, "%s: %d\n", __func__, ret);
+
+	return 0;
+}
+
+static int scmi_imx_bbm_alarm_irq_enable(struct device *dev, unsigned int enable)
+{
+	return 0;
+}
+
+static int scmi_imx_bbm_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	struct scmi_protocol_handle *ph = bbnsm->ph;
+	struct rtc_time *alrm_tm = &alrm->time;
+	u64 val;
+	int ret;
+
+	val = rtc_tm_to_time64(alrm_tm);
+
+	ret = bbnsm->ops->rtc_alarm_set(ph, 0, val);
+	if (ret)
+		dev_err(dev, "%s: %d\n", __func__, ret);
+
+	return 0;
+}
+
+static const struct rtc_class_ops smci_imx_bbm_rtc_ops = {
+	.read_time = scmi_imx_bbm_read_time,
+	.set_time = scmi_imx_bbm_set_time,
+	.set_alarm = scmi_imx_bbm_set_alarm,
+	.alarm_irq_enable = scmi_imx_bbm_alarm_irq_enable,
+};
+
+static void scmi_imx_bbm_pwrkey_check_for_events(struct work_struct *work)
+{
+	struct scmi_imx_bbm *bbnsm = container_of(work, struct scmi_imx_bbm, check_work.work);
+	struct scmi_protocol_handle *ph = bbnsm->ph;
+	struct input_dev *input = bbnsm->input;
+	u32 state = 0;
+	int ret;
+
+	ret = bbnsm->ops->button_get(ph, &state);
+	if (ret) {
+		pr_err("%s: %d\n", __func__, ret);
+		return;
+	}
+
+	pr_debug("%s: state: %d, keystate %d\n", __func__, state, bbnsm->keystate);
+
+	/* only report new event if status changed */
+	if (state ^ bbnsm->keystate) {
+		bbnsm->keystate = state;
+		input_event(input, EV_KEY, bbnsm->keycode, state);
+		input_sync(input);
+		pm_relax(bbnsm->input->dev.parent);
+		pr_debug("EV_KEY: %x\n", bbnsm->keycode);
+	}
+
+	/* repeat check if pressed long */
+	if (state)
+		schedule_delayed_work(&bbnsm->check_work, msecs_to_jiffies(REPEAT_INTERVAL));
+}
+
+static int scmi_imx_bbm_pwrkey_event(struct scmi_imx_bbm *bbnsm)
+{
+	struct input_dev *input = bbnsm->input;
+
+	schedule_delayed_work(&bbnsm->check_work, msecs_to_jiffies(DEBOUNCE_TIME));
+
+	/*
+	 * Directly report key event after resume to make no key press
+	 * event is missed.
+	 */
+	if (bbnsm->suspended) {
+		bbnsm->keystate = 1;
+		input_event(input, EV_KEY, bbnsm->keycode, 1);
+		input_sync(input);
+		bbnsm->suspended = false;
+	}
+
+	return 0;
+}
+
+static void scmi_imx_bbm_pwrkey_act(void *pdata)
+{
+	struct scmi_imx_bbm *bbnsm = pdata;
+
+	cancel_delayed_work_sync(&bbnsm->check_work);
+}
+
+static int scmi_imx_bbm_notifier(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct scmi_imx_bbm *bbnsm = container_of(nb, struct scmi_imx_bbm, nb);
+	struct scmi_imx_bbm_notif_report *r = data;
+
+	if (r->is_rtc)
+		rtc_update_irq(bbnsm->rtc_dev, 1, RTC_AF | RTC_IRQF);
+	if (r->is_button) {
+		pr_debug("BBM Button Power key pressed\n");
+		scmi_imx_bbm_pwrkey_event(bbnsm);
+	}
+
+	return 0;
+}
+
+static int scmi_imx_bbm_pwrkey_init(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	struct device *dev = &sdev->dev;
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	struct input_dev *input;
+	int ret;
+
+	if (device_property_read_u32(dev, "linux,code", &bbnsm->keycode)) {
+		bbnsm->keycode = KEY_POWER;
+		dev_warn(dev, "key code is not specified, using default KEY_POWER\n");
+	}
+
+	INIT_DELAYED_WORK(&bbnsm->check_work, scmi_imx_bbm_pwrkey_check_for_events);
+
+	input = devm_input_allocate_device(dev);
+	if (!input) {
+		dev_err(dev, "failed to allocate the input device for SCMI IMX BBM\n");
+		return -ENOMEM;
+	}
+
+	input->name = dev_name(dev);
+	input->phys = "bbnsm-pwrkey/input0";
+	input->id.bustype = BUS_HOST;
+
+	input_set_capability(input, EV_KEY, bbnsm->keycode);
+
+	ret = devm_add_action_or_reset(dev, scmi_imx_bbm_pwrkey_act, bbnsm);
+	if (ret) {
+		dev_err(dev, "failed to register remove action\n");
+		return ret;
+	}
+
+	bbnsm->input = input;
+
+	ret = handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_IMX_BBM,
+							       SCMI_EVENT_IMX_BBM_BUTTON,
+							       NULL, &bbnsm->nb);
+
+	if (ret)
+		dev_err(dev, "Failed to register BBM Button Events %d:", ret);
+
+	ret = input_register_device(input);
+	if (ret) {
+		dev_err(dev, "failed to register input device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int scmi_imx_bbm_rtc_init(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	struct device *dev = &sdev->dev;
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+	int ret;
+
+	bbnsm->rtc_dev = devm_rtc_allocate_device(dev);
+	if (IS_ERR(bbnsm->rtc_dev))
+		return PTR_ERR(bbnsm->rtc_dev);
+
+	bbnsm->rtc_dev->ops = &smci_imx_bbm_rtc_ops;
+	bbnsm->rtc_dev->range_min = 0;
+	bbnsm->rtc_dev->range_max = U32_MAX;
+
+	ret = devm_rtc_register_device(bbnsm->rtc_dev);
+	if (ret)
+		return ret;
+
+	bbnsm->nb.notifier_call = &scmi_imx_bbm_notifier;
+	return handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_IMX_BBM,
+								SCMI_EVENT_IMX_BBM_RTC,
+								NULL, &bbnsm->nb);
+}
+
+static int scmi_imx_bbm_probe(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	struct device *dev = &sdev->dev;
+	struct scmi_protocol_handle *ph;
+	struct scmi_imx_bbm *bbnsm;
+	int ret;
+
+	if (!handle)
+		return -ENODEV;
+
+	bbnsm = devm_kzalloc(dev, sizeof(struct scmi_imx_bbm), GFP_KERNEL);
+	if (!bbnsm)
+		return -ENOMEM;
+
+	bbnsm->ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_BBM, &ph);
+	if (IS_ERR(bbnsm->ops))
+		return PTR_ERR(bbnsm->ops);
+
+	bbnsm->ph = ph;
+
+	device_init_wakeup(dev, true);
+
+	dev_set_drvdata(dev, bbnsm);
+
+	ret = scmi_imx_bbm_rtc_init(sdev);
+	if (ret) {
+		dev_err(dev, "rtc init failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = scmi_imx_bbm_pwrkey_init(sdev);
+	if (ret) {
+		dev_err(dev, "pwr init failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused scmi_imx_bbm_suspend(struct device *dev)
+{
+	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
+
+	bbnsm->suspended = true;
+
+	return 0;
+}
+
+static int __maybe_unused scmi_imx_bbm_resume(struct device *dev)
+{
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(scmi_imx_bbm_pm_ops, scmi_imx_bbm_suspend, scmi_imx_bbm_resume);
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_IMX_BBM, "imx-bbm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_imx_bbm_driver = {
+	.driver = {
+		.pm = &scmi_imx_bbm_pm_ops,
+	},
+	.name = "scmi-imx-bbm",
+	.probe = scmi_imx_bbm_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_imx_bbm_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("IMX SM BBM driver");
+MODULE_LICENSE("GPL");

-- 
2.37.1


