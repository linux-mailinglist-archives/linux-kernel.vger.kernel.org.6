Return-Path: <linux-kernel+bounces-292588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 877EE957182
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44443281D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82E118A925;
	Mon, 19 Aug 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D/xs3X6g"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2059.outbound.protection.outlook.com [40.107.249.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E912D18A6CD;
	Mon, 19 Aug 2024 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087030; cv=fail; b=Fjch3A+UoTRPAnDhiEhS5sWJjhsjquAA4c8P3kkJkflX6F4tTCmzLqGHWtiDm6Kq6QS8eI5ZR8FDW9aaTIxuEgdOLEcn4tyCtV576FB+8CFmk3quf/jZttrYHXcZI9rgKaHGZ6j6Svrm8iGNvzTpP940/GEqmcV9FfwPMiSuSAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087030; c=relaxed/simple;
	bh=DFnzYZQ2LpxQhM+wUU0IN6vzE+9cHON6yMRUQw212GQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Au3pC9A0spZJVLtMdW57jwooTQIOasF7p6N3eWOnGS+9O+6Xz6jhVq/r8vhWhd+SYu1bugW5+tdJp+42fyq90fkwSsTL1YrD1PMXYZFdG9/yEsmJppmzae0h0Pcobff28Z6yAC9yln3ZSOdLAzidpgsjVHSAFENH/IsizhpmVCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D/xs3X6g; arc=fail smtp.client-ip=40.107.249.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXdJILNGJ/KH2tGx6GJZuOYWXCV4WJ5xF6RJBWdX6uJqyf/5xzNAzTgVUiLjYYCGVqpTUJ9o/F1f7asTe31T5CZoFDuScelwZaNAPe0ZdsrlUNl4jiWrl6Kvi77GQJf6QgE9P+b/B+HBmqqNBWYfdm/4tw7zQogI2L+VKJGcWzPHs/LzMEvMt5M3OaeLfLATd2jndnlgB4HvxQZvgr17YDaf8SaPJxnqkq63YeO6G64YPU9E/E30JBZs2yZtU1cssVAVhCYMh1QOkSaVXfX4BJkuAueDx/WOtjl0owGQOFaJLo7RLl/K7jt03NzO/1XJuYDb6CRe10SNBienp1Qilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0afN2LPICL18TrWBB9UPgYL9/sbs4IALA3OVU540ew=;
 b=CQbRTQbvF1umk7AMjDFsIhJwBsNG9sL1j7PW8/ZgzfG6hBRxdSeew2rQuJQJkECocLR+v3WBL1+QbKWKqktxZveCDQmdz433obQscfKaOAnJVASKVnPwZyw2tDwsVdsXPt9g2NNMxdewTwMEizbr/FlcHdhFySDh5tROrn0sBaqpHRHsCmVZr0tIaO9ITt0fR8SbuajPJADpqQ6oyeAu/EULGZlRYWmkIv7jkRRJSdPO2KwbtC/aii7Ka6zHVlb/sbB6cMwgClOewN//7/zmo9o2exfoVhBnkS3PyolHoMISGuuUnhmA2jRCdsVHzTRgEeWIRU4Wo9KZNJ57u/3bIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0afN2LPICL18TrWBB9UPgYL9/sbs4IALA3OVU540ew=;
 b=D/xs3X6gqqJ5rW7HUObxJPjfqdX8Z7UEiQFrsjv3kD+UKB/UgPYtUg8TQEsb1t3uRkbiZ9CVH5nL4OT85OddCk0HtfnNSOfdyzEutVt6iLM80y075mpE9saOEQUq/Gg7AFdEZxdTjSZ9VbyVAEkCWSUVJGC5v1UiUWSK6cRswuMMVjH1PuPpZGbVHPm6hB8O5cjxlMxLHcNPC7yinmrOhQMUySCs/NwhRc+0pd6dracHL4/CJqV90vyZz7gClUggYV6lfCBbSgXGSjZOzulLZ1+UYAkziRQotzq0/VzYiyb4TiToMjkN0iYeAazW8YtWjKRSN5HgooVn0XypkqZhyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:03:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:03:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 13:01:20 -0400
Subject: [PATCH v2 11/12] arm64: dts: s32v234: remove fallback compatible
 string arm,cortex-a9-gic
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-imx_warning-v2-11-4c428bd11160@nxp.com>
References: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
In-Reply-To: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724086982; l=1495;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DFnzYZQ2LpxQhM+wUU0IN6vzE+9cHON6yMRUQw212GQ=;
 b=xEYOC9mGSulfFnJ/qrKNG4mSfvF/mUGvqm1seJKrYbccF7iqGsFQVp0m2fPQGXdrVZudNyQoR
 pXPK5hodR5UAP1l3/qL69ptOZ/srpaUz3L3ITPyH8XyO8BKSms/X0Xd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc5edc9-42d6-415b-bc67-08dcc070e3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anRmN3ltbjlPRUhPSTdRME1MZnh1UVN5WG9ONmVxb3oxb0VGSzZTaUZIN1hL?=
 =?utf-8?B?UGUrQWljM1VJd3V3OEtuNTA5UUp5YldYK3BVSVd6MHdvVHBTekhEUEs2SE5I?=
 =?utf-8?B?U3RyRmhYVGdmV2tMd0JRVDZrV1BVWmpXbkJpWm84ZTFZRkVteXl3dXVZTkxR?=
 =?utf-8?B?K3cvMkV2MXEzNFFlRFlDUTluZVF4NUhwWmFsaFZBbHNRVkRxS2pRbHBkeFB4?=
 =?utf-8?B?RW9SQk53cmdsbU9WTTAvb1NXZS95ZG1YZ0tTQ2V0bERWc0pZSHM2RGxCU1l4?=
 =?utf-8?B?Q3JHUlNpQlVqcFVpNFJ0elNnaW03blMzMERxNm0xQzdINmRkOWZTeVc2Z295?=
 =?utf-8?B?aS9xK1Q4a1p0TFNVbkVCc294MjZKQlRvUEVzNGZ4dmFiWXZreHN0aHVwRmRn?=
 =?utf-8?B?bWZEQktwdXdGV0IzRGVLVnVzQXEwUWdlS0g2bGpmS2NycXRSTjFjS2szSHMy?=
 =?utf-8?B?WUd1eHAxNWt5RzV5djRhTHNRU1Y0Vjl6R2dYTEhsOWlhVXRyeUpnM2FjSW5t?=
 =?utf-8?B?OCtXWndERUlxQm8xcFVLU1U2eEFkNkRGMEF1REcrV0NGdFFCOVYvTHNSak9u?=
 =?utf-8?B?dHVrUUxBZ2pnWFpwRDR4aW5oeEFZZUdHTjVsWG1tZjNpa2VXdzNINXFNQU5T?=
 =?utf-8?B?S0xDV3l1L1Z6QnFjV3hVUDJhKzRzR0JsSmRmc1Yvc2pMQUEvakVuYUpSbTNJ?=
 =?utf-8?B?cURZRUdvaGpBcWNIMUFxdlRRWXR0Mmt5TUdlc0V4eEFNL1NzcVNKNEkyVzBi?=
 =?utf-8?B?R1daOE05enduOEd6RHNJRUFocnQ4VzRudWR0NmNSU1JkNXR2MGRuMEllTzlS?=
 =?utf-8?B?Vzl1bjg5ZWNLT1poUjcxaktqWm1PZjFtWFVtanl4UGlQNEptWFdoM3c4bHlK?=
 =?utf-8?B?eVJ0aVI1SG5zRXhXdTIyalloeUd2SlVwL3dUdXhhQTZiWWZCc1dOSkRNazNC?=
 =?utf-8?B?aDNKOGRpOTh2N2JtdXFFMmtOZ0htVk5LU1RrbUZYQmhWb21vME02R3c2aE0x?=
 =?utf-8?B?ZCt3VHlzcTllM1JQSGdTdFA4VkNkclBrWmQ0N0ZCN3RvbkhlNnhLa290QVdM?=
 =?utf-8?B?SkJQSUp1OXZIWHRvTVBUYTZzT0RiRlNWNDZHT0JjTjFLWWVWa1RUbVVCTzl0?=
 =?utf-8?B?SzVKUlNyZ1dSRjRVOW5RVXpPNDBERHJlelJaaHJtVVdFQzYzbFJVTTBvRHpI?=
 =?utf-8?B?WEZnVnpSSERXZERuRnNsTGMyYU53b29yOTF0c25YN095RnVYL2d2V1BRZVdx?=
 =?utf-8?B?dzVnbXZRMjBWVXVuV0Q4Si9xbVZXSC9ZS1h1V2dvbXprYzVWQ3k0T0VSNS9F?=
 =?utf-8?B?bTJSUnVZdHBqTlZJaGY5WFlLdXRZSGtjNFFvNEo5TUJ0WWRGR0tqZmc5Q2E2?=
 =?utf-8?B?M3BNa2k5YTBRSENXeWpWKzh1Q20zMTBYS2ZZbHoxMVdDYjZzbS9SUDVnd0xy?=
 =?utf-8?B?d3dRdFFiS3ZPRlJyVUlsQjljVXI3cWJmOXplNEUrUmYxRVZaK1BZK1NQczlH?=
 =?utf-8?B?eEE4OVdpTkZ6cmgzQkZXdVpjMk11QXZHci9jaWdKQVJXUGYwcWVnbS82SWNN?=
 =?utf-8?B?ZGNNNFVGeWQ3Nkt1OUR3ZWxXemRmcG1jY2dJblI0dzcvN1Uwb3R1NGNNKzVW?=
 =?utf-8?B?UW55MDhTVU16aEdWdWF1Y3RSMGlWL3U5THRKclNvQThsaENOVGhHZmhJRTN0?=
 =?utf-8?B?bjBrSW5YSDNnYjZKZm9GRzZLdHlWbUZvZm9IdUtSb2o3SkFRUnp1aVRLTEp1?=
 =?utf-8?B?ZWRGV2RXMko0U2RqaFIvQjJqblR6RDJZNnFKY0tOUk94VVJGMmlJcExMTjRF?=
 =?utf-8?B?NzZFWUpodlkvWkNPUkN0S2M3RjhudENTWUIyUjZPYVc1WmwrTjBkdHlxNFFw?=
 =?utf-8?B?ZUR6d2JKSURsem8zTW02RlJyRUdic2xHQ3FpSGszaHcwWlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUFsZmJFbnh6WnpyVzFsazd1K0pvZWxwd05WYktWYldZZm5kVzJSL3p1WTZi?=
 =?utf-8?B?NGUyRkU1dFBhUkNNNE5hM0gxaU5IaFNNNDRSMlZ6NG9lZlM1cXVEeGQzV2Yv?=
 =?utf-8?B?SlI2aUM4SnFldzBscnpZK2hqK2p0QU8yUjFCRmMza0xrSjJPOHgvSnkzT1R1?=
 =?utf-8?B?RW5icEZHekU5R0tEL08rd2dvejlqelFkY3dBUUxuaFVWU3JjS2xVNlRZZ0JP?=
 =?utf-8?B?M1BLdVVvZE5uamxCZXk4bnpneGVmQW5vR2p0d3phYmRyV2NaK29PODkydmNt?=
 =?utf-8?B?K2VEYU1GZjhla3RFQUUvd2lFQjVvQ2NqOU8vREt2VHFVUXI0ajdLVnRJTG0r?=
 =?utf-8?B?bXU3cjN4RWJzcVZyelF3bit4dEFuVHJJWXZ5ZVVMTWhXek51S3ZBM3JONFRQ?=
 =?utf-8?B?RkxLNTBzd3doNlBaZ0U4bmpVU3phSTl1ZEhITkZPMmlFMmplMGNmV1hCWFI0?=
 =?utf-8?B?UVk0UnJtUzV0TzBKU2UwTmlBUERWUjJHazhSRG1IYzdvd0VSalBJNVRHQzZt?=
 =?utf-8?B?WWwvaGlIMDVVelZxZHN3VGpkb1hKTHJVMFVsb2EzclZ1eEtJdEtnaEhBR3Zj?=
 =?utf-8?B?ZkRKczlrSWMxVDM0a2t2Tmd6WWp2VFM3T0ZjeW1kajR6cXYwT3hjTkVndUtN?=
 =?utf-8?B?QTRiY01hbWJLMzZUVU5rRm5hVG40QmZaWWF4NWJEb3AzVGdTK0U1c0pCR1Rj?=
 =?utf-8?B?QjlGWVJVY0EwQnpibjJTVFNuc09GR21CSmhVbTFvWlIxOVdubmszUGxHS1dF?=
 =?utf-8?B?YzNjNlpVcDcxdzkwQ0pTWmNRYmVZL1B1UVA5cDFnNTZlTTlSWUJOWGhCZHIw?=
 =?utf-8?B?aVZ5YXlIQkQ0SWg0QTExOXJGMEFUSzNabEpXVG43Z2huQVBHdlVtNVBNZEYv?=
 =?utf-8?B?cG1vcy96cmJwZUE0RytMVWF4OXRVcG1KRzdnMzZxS0NZR0dtZHBtT3M0aUw4?=
 =?utf-8?B?czhsNmpqSG9GcVEyQkgvNFg4WmVUbS9tZUJHRTI4NkE3ekhhdzVGaHhneWgy?=
 =?utf-8?B?QWdHK2VwZG5kekpwLzFlM1FtSytRSTFDVklhNU5kVHNoUTdaWlJPTCtFd1VF?=
 =?utf-8?B?RnFWOWFyRjRQR0dlUGdTY2hKYXRRbXpGTlBoZVhxL1AwVTJpclBLY20rNk1o?=
 =?utf-8?B?VG8vWVUvNnMrTkFkOThXVDdEQ0hHbk8zQ1Q4cnI1UTJzOTNFcTZXRm0xbGt6?=
 =?utf-8?B?RWp2QnpkQXlDLzZFU3BlcHNIQmRrcC9PdEUxUGN0TitFdDZGMHF3b0NmVlZo?=
 =?utf-8?B?K2RSdFQyVlorTkVYVXNsb2JHZFZQSkEzYit3K05OSGZ2MjJjRkdFWm4rSmNj?=
 =?utf-8?B?Wnl6NHpOL3NBazVVaUNaSzBqMTllNCtQaU1QSjdTcWc5MFV3Q1U3M0xuaEl5?=
 =?utf-8?B?cSt3MHFkN3hpKzdYeGlzN015VXllbGxDTGNMNUxyWFZ5dnI0bldlQ2gyYXN5?=
 =?utf-8?B?VkgwRnNubldNZmowRThIcy9DNVZWWHYvMmJFUHkzaFVKTnUvQXE3Z1RzZkd5?=
 =?utf-8?B?M2pYY1QvRjVZckROblRtcDhEcytTUnVkakpCL0RmRU9iUG5Ia2hVT1BOUy92?=
 =?utf-8?B?dW85Mlg3SUJDbWNYUmFNRXc5L094Uk5mUHZDVXdMa25qNWVITVo2L0lUeWho?=
 =?utf-8?B?OFZaSDEvUzkzY3NWbjFDME4wNGUxL1IxSGp6U3RvWkZuMlkvb1pMNlEwR2Vm?=
 =?utf-8?B?bXRQTUpsdXFka2NNRDFvY256WmNkbDU1R1JScEVRZ1BWZ0tudkl1WFNHWmc2?=
 =?utf-8?B?citKNnZvSU5OSXNRNm1VTEJ2RGg3emhiK1VncXJIR2ZhS051a0VWbHZpWVpk?=
 =?utf-8?B?MnpSUUVLRG1qNWsyekJaQzB0SjZRRWxraGxOTlJrLzZPWTRBY0l6emVuTWRa?=
 =?utf-8?B?dDRuM05zaEN1ZGx5VzAxa0hXaXYvZlROVzF6aDdIam5NcitacjViOXVjRkU2?=
 =?utf-8?B?MUF4RjZacVYvWmZCbzVtVVduMXlCVHpWS216MGJlUEhWYm1qME14Unp1ZU5i?=
 =?utf-8?B?blhQeEFvTWR6eHE3L3gvOVYxeEs1NDkyWm9lcnFSYlFlS096MHFvbWJ0Sngr?=
 =?utf-8?B?UnVuTUtTNGl5d1VuWlBobkk2UXY2RmVWbEp1b1JjM0xTRU5BakZ1c2tKUTFZ?=
 =?utf-8?Q?Iqh4yFKTx7A6r7EkePt9ORyXf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc5edc9-42d6-415b-bc67-08dcc070e3ff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:03:47.4998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XnPlLM2r6tJY/lScmunhyDWpj7oABt56YFPSczSonxe+K10RAB6ZiTCFCc+QrqcIrfln7F8Q6GKoq9IiRyfkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761

Remove fallback comaptible string arm,cortex-a9-gic to fix below warning:

/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/s32v234-evb.dtb: interrupt-controller@7d001000: compatible: 'oneOf' conditional failed, one must be fixed:
            ['arm,cortex-a15-gic', 'arm,cortex-a9-gic'] is too long
            /home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/s32v234-evb.dtb: interrupt-controller@7d001000: compatible: 'oneOf' conditional failed, one must be fixed:
                    ['arm,cortex-a15-gic', 'arm,cortex-a9-gic'] is too long
                    'nvidia,tegra210-agic' was expected
                    'arm,cortex-a15-gic' is not one of ['nvidia,tegra186-agic', 'nvidia,tegra194-agic', 'nvidia,tegra234-agic']
            'arm,gic-400' was expected

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/s32v234.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/s32v234.dtsi b/arch/arm64/boot/dts/freescale/s32v234.dtsi
index 42409ec567925..bf608ded5dda6 100644
--- a/arch/arm64/boot/dts/freescale/s32v234.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32v234.dtsi
@@ -89,7 +89,7 @@ IRQ_TYPE_LEVEL_LOW)>,
 	};
 
 	gic: interrupt-controller@7d001000 {
-		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
 		#address-cells = <0>;
 		interrupt-controller;

-- 
2.34.1


