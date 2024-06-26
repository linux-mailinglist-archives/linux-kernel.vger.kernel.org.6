Return-Path: <linux-kernel+bounces-230158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0517491792D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E338B226F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78960156F36;
	Wed, 26 Jun 2024 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cWxjNMhf"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208CC154456;
	Wed, 26 Jun 2024 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384583; cv=fail; b=dVTa7VuddjBeGluxyZwldbCnSDlNhtQK2CL4VFMuQz3oNcQFDvi9d+Zy189WVm0dmul8V5y0Pz6nTwuLusW2rzLVYv3dELii9/9DWMMsbkQwdTjmLgzmO81hNii7iXc7JXSDdhveqLgIWBlcS8EV4TbE+4kW/cXs1JDOW6W9RwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384583; c=relaxed/simple;
	bh=QEuc9mHC4BgDPIdjpod3oGtBxxhi5mgVVYjSLFuWFCc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZDBeMalArebjoZ7V6M3Q/+aWnw+oFXW6DWrfwbZ3OZoIL5fIwqO/djAp0pYZAaKOp/RtgCMMQMXoreP4Hqb1SZnu2xdgk8LX9bhA0E7i7qAgXNlUXN3xFy39gb0lN2ldqFFI9henC6B+uTuuD7KTJ3ckYNJLS6eU4Oh4mTB6B98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cWxjNMhf; arc=fail smtp.client-ip=40.107.247.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0rQVld5PZPQlJ/ckaYZjF5T3hyb97BCT/cFyYCsoM1dsilxwbEzdBtYuUwNtJhd6OKm6dFJocP4K27hT1rkl5pXjLy6lqTN/QCo0LAvsrF/Sn8+I9Wgm8ZGIIHSC68tq9vTz9+iIyas95cX9JypFE3pyMNcn6Gp5ApVd1/pY7NnsJO8JPIGDcymoZbSWPW1wsXi4+ajYdhwyvJDws3SS4/CJrXsw26Ew87V3hY9m9b3CI82eFAT25X5lOWddpSMHzQ9RtJYQWCYE9vJIWUYNnGw6JskOInQeIifF/j6BiRGBRhYRbEg7Aw+Y7mm5hlfK1VNJPvvoOcyfPSHvaomdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXwT7pcoPs4gUA7C/cu1HMPajA9byoLEk5jLA8tUv7Y=;
 b=bFi2eMq8BIM37lWqlk+8kBDa1c7X5ERFWUiY9m2huELRlbWk/WKd8XE2yj+VUY0pBBLTKTQ3fdFXx4Z1dNLVgSixJntVaXcz5Nb+Mgs2yE5dn+5tXRjfDoTGIKsXUL6tDlLoABvdjDGa+k7jeptlyZt8K6L4ELvLlCOO+JB0fLrmQ+/Fx9t0a/SPi9RSDR1ypRScv8SI1uBOCuUgavXSwbAjMpBSjvxr9Go6+zxm289hchZeR6/+ZFJTCyIiM0hZMhhZGywtshTo4esEdi3ZCpK8zVLoMYaPbXwmjGg7Lou0Nc+AekEY0aNScU3HAw2Z9xlbLOjM5qEAXML3vxSvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXwT7pcoPs4gUA7C/cu1HMPajA9byoLEk5jLA8tUv7Y=;
 b=cWxjNMhfbekrQia5tMiBKo707fzH7w/yUcv7rECvsXmwq6ar0++fIezdq8pALDoTeY3AGfBGTYpTU3p/NJDFAvNjFn1DcqkVgQ3pSVePNVJLxGzdzXga8ISR5XoZe+n3wwKvr2bOJjXiuVomou/Lm2dejUaLIG443c/p+EoIye0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PR3PR04MB7449.eurprd04.prod.outlook.com (2603:10a6:102:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 06:49:38 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 06:49:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 26 Jun 2024 14:58:39 +0800
Subject: [PATCH 1/2] firmware: arm_scmi: channel unavailable if no of_node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-scmi-driver-v1-1-f16d777e004a@nxp.com>
References: <20240626-scmi-driver-v1-0-f16d777e004a@nxp.com>
In-Reply-To: <20240626-scmi-driver-v1-0-f16d777e004a@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719385128; l=2477;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=RNHjX3icUu5Fa3quGe1D5sfhXIBG5EyoXdwa6hawOCk=;
 b=g5aclVtPfp6pWAMKhn54fSIHpidP4x6TUuFQI9AUuyXHpSYhGjTyv0A+xhAO9HyJfbQhfjV8J
 JHT3/Xj/QQXDLCkmj/FjMGsGpPbyWgyrkmfA1XDa06bI5kfHlXBAv4w
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|PR3PR04MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: ee522686-3e92-4abd-c4a3-08dc95ac25dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDRybERUM25sbHdxc1FPN0tDWjJQQ3Rpc1BPN3d4V2h2OTlUaWNWeElHYVlr?=
 =?utf-8?B?S3MxdlZqMTZHREVkbzBqRGNaanNURUQ3aTJmMUJ2akxIYkE5NWh2WVBXWXpE?=
 =?utf-8?B?SEwyVzlGL1FlS1BMcDJzWTlGRFJnc2oxcW9PZlZOMlVZR0RmWmVQK2szbFF6?=
 =?utf-8?B?ZitpZHpFWElFZkFSVUtUcXZKZlFFN1hKSWgxanlkaldkMm1HZk55SlFnRWFB?=
 =?utf-8?B?TEZ3WVhrRUJzYW1DR3lnMW5UTzNadG5wYWMxaW1xVWF4STUvZTJsRWlOemhR?=
 =?utf-8?B?ZWV6MnUxV0lVZU54M3FwY0JMb3p3TVNvRkpvNEU1ekxMQW9mREswYUl3Qlhk?=
 =?utf-8?B?ZzZLZVJPMFR5bS9Jc1hPd1AybkJVZ2tRK1lnc3RpdDM4aXNIbXI0empRLzM1?=
 =?utf-8?B?YzcxdTVHWDFMTW1wZER2elBYNUh6UGxCVzNibFcwKzEwSDArKytIQVlsMVVj?=
 =?utf-8?B?Q1k3em5OdHVFeThFWTllS1Z6UkVWdHdDOXhPWHBxQllLRHJiRFkwd2xZWmpQ?=
 =?utf-8?B?d21aQnZyd0o2K1hPOG9ldEM5Y3hLUGhBVHJDM2NxU2xVSEZnTWdkQ2hkRW1o?=
 =?utf-8?B?aUU2SDYvVmJrcVR5clNNSkdTSUpaL2U3bW84ZS9yT3ZaYlEvSnppMzM4MzM2?=
 =?utf-8?B?dUxkV3U1b2JXZi9YOTBWQjIwdStHSlNoUG1nY0RaNTc1YWpkNEcrQVVwQitX?=
 =?utf-8?B?eXJWWlYrOWlQUkJkcHJrc0ZFTGFpT0JLdW1uVitaSTd0c0lGYXlUMUJ3cmZD?=
 =?utf-8?B?SnNkR2dnbklkR3VuTXFrTkc1NEdtSzJFNVE2V29UVWUrVjBxQ29MSzBkRFNJ?=
 =?utf-8?B?SVkzcWpUYytMVlFCS1JQZzRTYXBjL3ZOb0lqSTNiWFZLd3Z0ajB0d3drcmZs?=
 =?utf-8?B?R1pPT3lGT1d1MTRKOEhhTThKWmxuWE13T2lWS25JUkMyODNQTFdnRUM3NnBr?=
 =?utf-8?B?MEJrODVnKzk4ZW80bnVsSmhiV0NzQUJ1U0phKzJUUjc1NDFXdVIzK3RVMVp3?=
 =?utf-8?B?OEpuNmp0R3pmVFhQUTh2akRBdzYvOGxpUUZpMjBmNkFpaEw0S21NaXEyVVRD?=
 =?utf-8?B?QmZGK2txQ0dIREprVUh3N205eVVnQmVVdGs5b01zZUd2OUdjNmpxVmdJWWJ1?=
 =?utf-8?B?NFhHL0NXRVZ1aWpXRXlTLzZiZVNyWGYzanRtVUxWazFuS21GNVo2R0QxQXpI?=
 =?utf-8?B?VDJUZTNBNDBGclFXSXgrZTRRT0VvTi9LOTF2SHBudkUxREc5eElYWXpMZWxz?=
 =?utf-8?B?U3V6cHNmaWNaYnZGM3kzaUpYYjdIR3pHaFl0bFB3YzBVaTl6YVpqQ2hvTVNY?=
 =?utf-8?B?b1pYOFlMQkhIUkRtOFZrS2FLbDFuNW5WRDl2R05KY0JKbkY2UUc4UHpFRmlX?=
 =?utf-8?B?b2x0WlVUWjBETzJHcWxjOWNqTHVlTVdpNkNTaVdraVdTbHp3bVduRklFMGNE?=
 =?utf-8?B?WDl6aVpFN1kySFh4MGtZa3BqSlNGWFQ1Z1VmQzg4azJpd045ek5abDNHVWpS?=
 =?utf-8?B?V0hHNktyS1c5NzZRK08xMVRzNzdxdXhSemxncHJHa1YzWGwwZTNQMDFYSUMw?=
 =?utf-8?B?emdhN0lmRTdXNloxelVHVUNFa3p5WUZZTGhjb1JRL2NOTHNUTUc3ckxLTzB3?=
 =?utf-8?B?M1pkRmVRNmZFT3ZadzBjYXNtN2RMWm15dXJFOGtnOFg4QVlIQ2tuc3hNb0d1?=
 =?utf-8?B?RzE0OGFIRURDOGNEQ3JWRlJZY2hiRTRLODJMSFd2QUh2LzVPQ3A0VUltZjhM?=
 =?utf-8?B?ZGJkYTZKcGVXQTRaZWE2cjYzY3dNY2FKUzJtNnNraHhDNHdCWEx0ei9kSU9L?=
 =?utf-8?B?VnN4WFdKb1Z4bzlab3F0L0VZVWFrWmNJTU96d2lOMkRnOUkvMDBXY2JvREwx?=
 =?utf-8?B?T3VLK1plMFV1Nk8vV3BKL3NUTEl5SGJRd3c0SkluMEI2Rnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXp6ZUlMQW13SEo3bmRBcktoVmdESk50eDVYY1JjTEJCMFlralo3bmRqRGEr?=
 =?utf-8?B?bFF4Q0drOGhmOUkwUm04N0ZTQnYxUk5vVXhWYi81eDFPQTRNMzR3V0pzUTlT?=
 =?utf-8?B?R2FDUkxVa1pDQmJMeGw1eUU5UWloNFpJcE5IMWhUWXN5eEh6eWtVcXBOakFl?=
 =?utf-8?B?SkhnK3ZtY2R4OEw3ZTVpNDhuekdCNDhiWkNlMCtFdnBNTHhiOUV0aFdGN1ZC?=
 =?utf-8?B?TjBkSkJVeStaYmpTTGh6WTFONCtGUkZ5ampRbEliZzZHak5aOUlETUhYYWtI?=
 =?utf-8?B?eUVMdGV1VTZHRW15cWdXTUhpN3ByQmEreTRrUWFpRUplRWNZYWV4U0kvWDE0?=
 =?utf-8?B?eTJuL1JXcWNSbFVJZ29qQ05kZkljcHBtekhQamdaTkJxYnZnUmlvMm5JTkJs?=
 =?utf-8?B?K0NINUpzOVZvYXIwZkxzMjl5ZDRIV01wdGpUaDM1WmpBOFBjRVozLzNOOGwr?=
 =?utf-8?B?SGhGZE9HUDFVT2VpSHhWd2lvUlhTbEdwNXdsSy9hcTh2VHB5ZnVWazBlZ0R3?=
 =?utf-8?B?cVRPcGRkNlRNaFJRSlNLblA3OEhEak5qRUtTbEkzSHdINHY4dzFOM3JmVFZO?=
 =?utf-8?B?cDB0WkhMRXVXcUJkTUxGaFlYbFlPT0c2dUZvZVltb042UDNJS0l5RlUvcUdx?=
 =?utf-8?B?cWhJNVk2ZGJFY3VqTm1Ick8wU2lKNklHQktpWGxPNUgvbzR0ajBINWRmZENh?=
 =?utf-8?B?VnRvWWFHMUcwRnloQTZ2amUxQWg5TUQ3T2hsaVJUMGZUOEIxUFhYdWJMUk5n?=
 =?utf-8?B?eC83NDNmbFRNVkYyMXIyVmt2VjRUMStGamdyRER3NTZtYmlLa0s0aU5IWEpk?=
 =?utf-8?B?UUtuS3RWSjBrZDk0S1IvenBYNTRPMEpWMkdZMFA0VnhGam11RHZmTks2U3hT?=
 =?utf-8?B?bTZqY0lncjlTSXZWSFNxaThMeGNPaXJnWk5pbW5JNU9vSSs3aDN1ODlFQWJs?=
 =?utf-8?B?RHRZd3R5NEdXa2FJSy9zOFE1cUVkNC9TcUwvaVJrSjZ3QWNGYkwycHNqb3FV?=
 =?utf-8?B?U0lHbG5YOWJTSGYyUDAxTVpWaE9ER0lmNVJ1cEQ4L1hqVmJTT1RhRGs0VnEz?=
 =?utf-8?B?eThWdm9tRUlkYnh2TEZnVVlKdktRL0lxa3JpT0JFOHlJalVhVXltTzhNN3hZ?=
 =?utf-8?B?QmZnS1dvWWd1bURKa3JVSnhUTWRTMDlUNDRJbUs5SWxvakp5NmdZd0dzVmty?=
 =?utf-8?B?STBEQ1RCTVkweENGMUJUVm1JdnZrYjZIWjh5V2w5Z2FnbVBiM2lGLzc2Y3Vi?=
 =?utf-8?B?b1dRMnY3dXFXNENPV0h6OXdBWlZnSWhkektpMmpYVXVMUzZGamE3YW5hMk5h?=
 =?utf-8?B?dmJ0cmlNc3BpdEJaaGthRUl3Mk5CTzF1WngvNjFZS3R3aUxUSmExNWpjMXlo?=
 =?utf-8?B?MzB6R2E1UzJncm9SVk1wMmluYmtockJKY0ZpRUwrek91aWxON1RlK1p3WEFR?=
 =?utf-8?B?eWFEbDRMSnlXOWxZVTd1M0hSN255WE5QUmdBeHlrbzJOZnBORGlmdytMZ2kx?=
 =?utf-8?B?NE41RFYxS3puV3ZVdVB0bk1iNG9aYzhQVDZyR2k5S3JqRFd2WlZvWmZ5U2Fm?=
 =?utf-8?B?WTFYOUFvM01FSHl2OTRMRWlyZDVGazlZT0pma0lJeXZIYUdlM1NoR2RBdVZL?=
 =?utf-8?B?TitwRDRKNkhyZldrVG5MTEU5bE5zRHNQYUw4UUFOZU03YlNFSEFBMlRCQStI?=
 =?utf-8?B?bTkrZkI5M3RnbkdNS3VzSzhhRWlESUs4QUJ3aFNvQ2NsQzNobmE3dlJycDRV?=
 =?utf-8?B?MVk0NkRTV1RMa0lzeW5vTG9ROVZtRHJDaVdLTjNvUnM1RElGMHI5clE3bWJX?=
 =?utf-8?B?d1NmSEowY2JQSDZCbTRGZTBTRkhEdmh2Y3RhY3psOWMydXA5ckU4ZWY1dndL?=
 =?utf-8?B?TWU3UWlCeHpxMHdJT1BSb2dTaGRVMGR1V2FGVHZ6MGtKU1IzL1BrUzBtbDBU?=
 =?utf-8?B?aHJRZTFVVktPbkNZaFZwdXZQZWFMNDBZMlVteGZ6cThTSXArMEF0elZvWllh?=
 =?utf-8?B?UnJJaXBMYjhpRWxvbTlLMDB3elZqcTNZRDlrZHhiYXUvYWt0SFpBb3FybFRV?=
 =?utf-8?B?WDVHd2IrdnFHbUxwTG1YQ2h2dFdkZUhKdVhSUm1kYUZ2R3J1bk9wUFN5WHJO?=
 =?utf-8?Q?hwLg6o9spzRGeQubTRZ4wEWLM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee522686-3e92-4abd-c4a3-08dc95ac25dc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 06:49:38.3499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MANfo4IKdSZFoIahUzy87GRh7LnmklVzBxxnOll/o7+qO8gHADXcREODXeJ11WqlQE/nvc91KZmNhXJeSRbKsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7449

From: Peng Fan <peng.fan@nxp.com>

If there is no of_node for the protocol, there is no per protocol
channel, so return false. Then it will reuse the base protocol
channel per `scmi_chan_setup`.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/mailbox.c | 2 ++
 drivers/firmware/arm_scmi/optee.c   | 3 +++
 drivers/firmware/arm_scmi/smc.c     | 7 ++++++-
 drivers/firmware/arm_scmi/virtio.c  | 3 +++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 0219a12e3209..4f3abc933315 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -71,6 +71,8 @@ static bool mailbox_chan_available(struct device_node *of_node, int idx)
 {
 	int num_mb;
 
+	if (!of_node)
+		return false;
 	/*
 	 * Just check if bidirrectional channels are involved, and check the
 	 * index accordingly; proper full validation will be made later
diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 4e7944b91e38..c0a198baa706 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -334,6 +334,9 @@ static bool scmi_optee_chan_available(struct device_node *of_node, int idx)
 {
 	u32 channel_id;
 
+	if (!of_node)
+		return false;
+
 	return !of_property_read_u32_index(of_node, "linaro,optee-channel-id",
 					   idx, &channel_id);
 }
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 39936e1dd30e..5af1f781fa10 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -81,7 +81,12 @@ static irqreturn_t smc_msg_done_isr(int irq, void *data)
 
 static bool smc_chan_available(struct device_node *of_node, int idx)
 {
-	struct device_node *np = of_parse_phandle(of_node, "shmem", 0);
+	struct device_node *np;
+
+	if (!of_node)
+		return false;
+
+	np = of_parse_phandle(of_node, "shmem", 0)
 	if (!np)
 		return false;
 
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 4892058445ce..4d8d6ad3ab5b 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -389,6 +389,9 @@ static bool virtio_chan_available(struct device_node *of_node, int idx)
 {
 	struct scmi_vio_channel *channels, *vioch = NULL;
 
+	if (!of_node)
+		return false;
+
 	if (WARN_ON_ONCE(!scmi_vdev))
 		return false;
 

-- 
2.37.1


