Return-Path: <linux-kernel+bounces-175236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D33358C1CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35E65B224A1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC152148858;
	Fri, 10 May 2024 03:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ed5J3EFN"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56430149C7B;
	Fri, 10 May 2024 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310722; cv=fail; b=aVOLHF3/0+q1O+joNevBAsOsYGKW3yxOl9YzjqZJTPDhNaDDwbyTI+eOgprE8NsuEvpRLC+pgls7LN+ykz65yfRK8H+7TXvxd00fQ5u8tVtpWEHbZG5UcGuDepmZyhRALp7s/jIlub6IH0awGOqAZvXLrAgbE/yrAe+Oa5HlGw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310722; c=relaxed/simple;
	bh=37DuUjKhsCRD8GOrkSk7kJgQqUkqyMhx8F1hEbDiTgM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bbABV39WWYS9l+n20t0tnN4JmfIHplI/u88iPgq3zvWe8a4tosW6xr5pnQ3mLuETt8fJGeEWPVBu5QJWBbP2ZiveTXn9kmYI0R5utDXGFiOY+NgMdTbEXrkDFK2QZ6lzUd3zmDQMRsx71zjGnjrTSd5HdHmR35oX8E8LckkcS4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ed5J3EFN; arc=fail smtp.client-ip=40.107.249.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYIVEk2vkBPzWVMMe1lLqNbyG7P9aF2+f3fp2Lf6hXJANKxVWPecHmN0j6lkRIPSk01xquhQYxVPzXmDp1luWRNXGXXPtxMtjXGDtSxmz8uiIkcXtSdV+dOcEdS0Jg+caWlmiWeUCoRjChj8XsV+AKFOS7fRtHSC3htFINP2UvpegfJ1L32oMhl/eKTRHvCMss22aLQHnS3N7By7M7EEabZKjXr+QtisZTZYdnknlRDyHhL/VFBD4bvnu1v6QdzebYlcATGMkI0cSHreb+nkKjBkicD9H5tcNnh7QpWIe+KkMfQFBRb1gEWQzaFExZ8bCfvCBsfACbeuzK1ZZnfavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpmF1IFBgbpxyeYXhFcOjI3S70BfzuDDwMISjtcPQmY=;
 b=Avs6jdqimi8k9LkipyBc690JkG/63VXKDgqUIYQ1oVQgCvK/zi+aJ0zWM7GhBKPrLasVw7Q6DGDoSE6Wyi+AGNl5pA0rjnq/8mkkPX9Ylzi0BJpG4cDgIGyFtLUAyYd1dBZhkaBo9bxVwcfbNddkJ9Mzl4V+FGVUgJIxzT9bHYSNIZDwrRAvOIceqzXJjOgwtIv3OhpOuVGrJkhbzc76ERc/fIjv7WkWe2eZTD/Gq0YjixJXv54LQY/2K3nq6Rz4RArV8p0JXRT8G8iwmXPkF8yV6DhjP+NnVqEqhtUJ++O7Os6/rJNks1gfzO3ycqILyCD/oTTIVKEvKnfHpkSJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpmF1IFBgbpxyeYXhFcOjI3S70BfzuDDwMISjtcPQmY=;
 b=ed5J3EFN7uGhee30vU++zbOJ4/gL8Nj430ftIeUMR4nwuxcWdgG8ukdzj7oIouUdIqBu/K4orxUoS0Idzr3n6rnMKgUL9X42m46W+rcu9wRD9N//ddzl7SjTeRBjidJ1/zMbebGvwl/Nsguwh4JXLGANVIHOvM/237R2IvDz7EU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB10135.eurprd04.prod.outlook.com (2603:10a6:150:1c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 03:11:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 03:11:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 11:19:48 +0800
Subject: [PATCH v2 2/2] firmware: arm_scmi: mailbox: support P2A channel
 completion
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-scmi-notify-v2-2-e994cf14ef86@nxp.com>
References: <20240510-scmi-notify-v2-0-e994cf14ef86@nxp.com>
In-Reply-To: <20240510-scmi-notify-v2-0-e994cf14ef86@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715311198; l=7217;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=t2BrE0VMd+eaNJXrBR3kIz/FCOpC1Fqa3t0eTfMaVPo=;
 b=8yirybGc7pZUIqZaPnpQNc/H3/40ApGm7JIfkg7WnlONJsc2dtlS6Qr6UpVjOWlwmvZeVNieF
 w4NfmGBVjTBDlS9dSwJmIwWJtU8dXzI7MyrDU0hVpv+CvEUU3qsPCG/
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB10135:EE_
X-MS-Office365-Filtering-Correlation-Id: 696fad76-4236-4bf8-1066-08dc709ef38b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGNWbHR4ZkFoMTZ4Y09nMDY0ZjhZMVhhQlBDa1BZaVFEeXFnV3ZmSUNaS0FC?=
 =?utf-8?B?M3JXdzRpMkcweVB6UnY0Z1RkNnBKUkhLUnBlalZqZzc2Y3lqc2o1eUZTTDRU?=
 =?utf-8?B?dGthTkl4cjRCanRLSTRIWERjZ0xKNm5HR0JTVFNQWjY2YWtsWmZVeUdCeFd1?=
 =?utf-8?B?U3kxVGovc05yZW5hZWZxRVpzMkV2YlhORUVvQnJhcDNDTEpkdmZaY0wrSUJD?=
 =?utf-8?B?Kytack5PaDRHMU9QZms0ZFVtTFVZQXlZQWE2elgwRXlRdng4QjV6bGFiL3Qz?=
 =?utf-8?B?N3NTcXdxcDAra2tObWFtUTBXY2VmZENwd0FudjBiRnpabk9IcHNCWXZ0MXZx?=
 =?utf-8?B?bWhRS0tYRHJnaEtBSFFFT25US1BhVVNvem81RXFEVWsrak5xOUZWa0pTUmxP?=
 =?utf-8?B?b280bHhXTURGT1E1bVo0c3h2S0VFdFNBRGpkeFF0N3JxUTNRMitsL0Q0OWw4?=
 =?utf-8?B?bXdDamlaeVM3S3dmdnJZdmh0WVVXbUloZmlzdS9rRFU5emtBMFd5UUdTUUdL?=
 =?utf-8?B?cEpsbkdRUDFJcnN1cFN6TlpsNWxJbitGdHRKUVExWDk1YlEzTGUwc3NFSGo5?=
 =?utf-8?B?bW1HUVNDVzM4RGdUQnBMNXFuV0VGc25nRkFMcVJCK2hLbkVtRHgwbTlmVnRi?=
 =?utf-8?B?TGpHb0F3L0s0djZDNXlVeXhVSlRSZitEODhQWUdUbm4wMkpTRmp5LzBKUTNZ?=
 =?utf-8?B?Q3FXVEZndks0Q1hyTGRHNDE4ZkRGOVhoV1lpQzRuNW5veEhEcGhZNUV4dU9W?=
 =?utf-8?B?SzIya1hwUUd5L2U5ZWRBQkJxb2ZsZXlDd0JuVkRWWmk2OTVBeHVRUWZ4TG8r?=
 =?utf-8?B?SUFEd1F5ZnU2NWFKRnM0WGQxVmJnVGVSWk8vZXdOeEk4a2V4TFlucUZHSFZY?=
 =?utf-8?B?U3lWVHQwZjY5OFo2WWtPdGdtTXVEcXNNSHRXYXIzYVIyUUJnRzVrWDA3L3ZU?=
 =?utf-8?B?MWRVL3p4dTNCSXRiMm5uREtOVU1LQVM3SzcwZTdmV20zM0hkSFYzSk52NVBD?=
 =?utf-8?B?OHlmaTM1aDNTWXdVVFhXTnV6SVVvVmNXcGcrVUx0c3lRT014MjZiN2liWVdi?=
 =?utf-8?B?VUptMTRCYk4rYi9lTXoxbHZ4Y25CL21mZWZFYzZOU1FhcjhCSE1OYjI4MHhl?=
 =?utf-8?B?cjhiT25vckZYSmNoNjJLcjZWMmllU1N6K3JiS09PWm15NFZiMFc5enlWUlJF?=
 =?utf-8?B?bDlnNE5UdXRINUR6MDFNN1YzZW1mSTYzWC9CWTdFR3QrTTJnM3dXVEhEYU5R?=
 =?utf-8?B?QjVadTVDWFgzem5PalVjMDIyMm5QVkFjczRKb0MyYXZyY1phU2h5c2lUL0dy?=
 =?utf-8?B?dDIxQXRmdktDUmxKYUtTSE1ZVTJpZzl3RktQOUVZWnppdVIzMGFScDRyVCti?=
 =?utf-8?B?YVYyMS93d1N0RENscC95b3lQbE05OUlqT0lqbDhBQmFIN0ZNWVBGWndDTjQ4?=
 =?utf-8?B?bXVoMHpZYlVwMitiSDJralZMYU9xWXg1am5QT2RCNDZHcnRzQUtUbkNnMEFw?=
 =?utf-8?B?dHpES09mTEdlempsRTJJMlRVSE5tWFMvQkMzeHlBQnlIdjVFUmhSU25zN2h2?=
 =?utf-8?B?WXk2WEJwaUVBWmdYZEliSWFsd0tQM01PSEUzK3ZVeTJrRHAzUUJzRndYay8v?=
 =?utf-8?B?bXQ1S0wwL1hnZ0VBUy96aUxmTVRyTmpiNGVlVGxTZ0RSeUE0dzBuSENsc0Q5?=
 =?utf-8?B?c3diQUZaSWpvaThtZmxPNUZlbVNkMVp2VmVNMGNHaDdnOWdobWZTTW5YM2Ey?=
 =?utf-8?B?MlpLWVcvQUdpejRJUUhRUmlhajFGVnUwQkVBR1ZUb2FYTTkwTHowZVJlaWNU?=
 =?utf-8?B?SGVxc2hFa29LdUZ3Qml0dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXlpYjY5bVQxc1JTeldtT1JyM01ONjRsbk84bTg4UVViVkI2RlViaXJ3aWl1?=
 =?utf-8?B?amdsQWZEakM4WHBneVFrYk5Md3phNzdacmQyMDM5OVcwMno0NzYzKzNUV014?=
 =?utf-8?B?N3pNdGM2RDcyZ0RJdHZua05lcC92d2FpNHdjN0wyM3BjYTViTFQwYkw4UzJQ?=
 =?utf-8?B?MlFYend4dG1acGJRbDlmUi9RZnVvMHRGbmFxcy9jOGFxaW0zY2lBcXAzVjlk?=
 =?utf-8?B?YWZvNk5RN0VsNmtHVnZFM29Kd0lyNXRFNWcrNGR5MW1rVXRLb2tSb3lsbTI2?=
 =?utf-8?B?SHVKOVVvVzZzTjlCQ0M2NVV3NlNFdnJBajRCNU9LWTRGMHcwMU9qRTZjblps?=
 =?utf-8?B?SWpnWkJTY2Z1SHVnbDVHRnJDUWwyY1U3aEVQbHM0aFh5SkpKQzB1cDlBT3lx?=
 =?utf-8?B?Q2k2WU5EOXpjUVZUdk5Xa3ZUR0VtbmNzbm9USzBmOUFKZFo5d0s2bzRLTitn?=
 =?utf-8?B?aUZRQlB5eE9DdXZzUDNrdEJ1bnhJM1A1QnU3UXVDL3hWeUJ2TnlENXFvMmV0?=
 =?utf-8?B?dWJqUmorelpDOVdwS0lURUdYOHFNYTduNThzQjVoYzE1dlFIMSt6bUlSVU9a?=
 =?utf-8?B?azdDL01rNE15YkhXNVFCTDVwL0diMVd6MldVWVhFRmpNRU83VVJtTTQ2cmI4?=
 =?utf-8?B?clplMHR3MXJOVnhvUTRQaDNSK2U1K1dVTzVkM2xPejEzdFVISzlWazJWeWtu?=
 =?utf-8?B?bXg1QUV6K1JaS0xKcHVXS3lYYjkzdm5zMStHM3Q5RW51cVhmcjRKOTcrRlNZ?=
 =?utf-8?B?VXlLd3VPeUxNVWN0VjNQOCs3UjJEMmRJVnNrQkRPckJIbG9TTnZvNjA5UjRH?=
 =?utf-8?B?WTFUN2xMdS9FTk1zRW5TdVdjNTVQTXVCQk9UZWZwcm5HUzk5a0cyek1UODJy?=
 =?utf-8?B?YlhHL0c0bDE2bUxBeGd6Uit1MCt0L2dnaVZtQWI5dWpxeS8wVzcwRjVRWHR0?=
 =?utf-8?B?TWJvVGN6YWVWWXdpMG9wcnRPa1M4dWJ0YXdmOHZYN1ZEcWhMMkNJSU5mUDVP?=
 =?utf-8?B?SXg3eFFBVUZpalpQQnB4MTdNeHpMWGkwVHcyekZKNVgyeSsxc1hnODBJUlRS?=
 =?utf-8?B?bTRRZGFTOWJremVlUDRYNzQ0TndKQ2ljaCtYVGdVWWFGMnJweS9FM281cmZC?=
 =?utf-8?B?UlpRMlJ0S0YwK0xMb0RyMmY5R2VRTlVjQkc2VUd1SE5jZndXQWFXa0U0d1VP?=
 =?utf-8?B?cFRUY05rSlo2UTVqc054UDZqZmZlMUZxUEx4SFhLSlJ3bEFuOXREZktIVk1t?=
 =?utf-8?B?TU1EbkthZWtONS9PTE5WaW95UzkzMzlzcTdtdnB6YStTMmY2dHBIMWJqREpU?=
 =?utf-8?B?VDkrejVNb3BLaHNnd1M1cnh2THpvZzJKaUt2WUxQYUpSLzRpSURraEZoa3B2?=
 =?utf-8?B?VHE2RzdlWnllc2REdndqU3ZtWERyang2OGZEK0xRaTB2N1lBVStubjM4OTdn?=
 =?utf-8?B?akNyUDJzdjBnNmYvb0hrM3l3Yi8zS3hGaXNQbHpaa1JHZGFteGJ1VXI5R1Zv?=
 =?utf-8?B?MlBVMEtteDVQR2VQZjZoZ2FxeWFoL2oyTy9CR0VGZUwvTnBYcGZuZGtZTnlx?=
 =?utf-8?B?ak52L3FCY2RlaWtERUZUckF5VmhVNzg2VkRXWVZtd3dVV3QrVkxCUU9EMUNK?=
 =?utf-8?B?RjVWdTdpeGRNR3ptQW5MUDBBR1hxVUx3aFpwUXA0SGs1ODlUKzE1MXNPeWdi?=
 =?utf-8?B?alZCTEo3a3FUL01GT01sclZFb0dMMmwyeVpHbXQ3eDZKbUlrRXRwZ3BGakpO?=
 =?utf-8?B?Qkl2SWk1Tlk2NXRzYUdTQlEyTUQrd0o2Y3l0YThzUXpKMklHY2tuTEthVFBB?=
 =?utf-8?B?Z1BWV1p6emQrK2dqbHBObHpjNG9NczdqcGd4ZG8xUCtubEhCMDdKWnAxaFNW?=
 =?utf-8?B?dkxPblJ6RzJVOGZURGRhUCswczNlMXZ3MXVmRW9xUlArTk9SNHJsRXkvSVpJ?=
 =?utf-8?B?dDFObmtNdGNFSW0xTmxZNyttZ1ljclVrVEdLS2xOdklXQmJkNk53dHhoM1Yw?=
 =?utf-8?B?YXFmQ2hkQzhjUFlwK1krVGttZ2NkL1ZKTFcySTlyMnNRK2V1TUlDVER2c2pq?=
 =?utf-8?B?V3NlSVNCempSQ1VoWWZiZlNHc0JoQkR0RHVTR1ZqZmFQN1FsWllkK3lwMWE4?=
 =?utf-8?Q?rRhRw/HrCH4HmWcDtuBBAZd5V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696fad76-4236-4bf8-1066-08dc709ef38b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 03:11:57.4066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCS11YWf8OxBr59cTOz9d54mdtA2ukIB0q5wlPy/VU5M45MdFwVBZiW1aX3R9Ui0AQ8QAwOvP83/51Q3YY4F6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10135

From: Peng Fan <peng.fan@nxp.com>

i.MX95 System Manager firmware is fully interrupt driven. The notification
channel needs completion interrupt to drive its notification queue. Without
completion interrupt, the notification will work abnormal.

- Add an optional unidirectional mailbox channel. If the channel flag has
  INTR set, and the completion interrupt channel is provided, issue the
  mbox message to Platform after the channel is freed.
- Support bidirectional channel completion interrupt.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/common.h  |  1 +
 drivers/firmware/arm_scmi/mailbox.c | 60 +++++++++++++++++++++++++++++++++----
 drivers/firmware/arm_scmi/shmem.c   |  5 ++++
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index b5ac25dbc1ca..4b8c5250cdb5 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -326,6 +326,7 @@ void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
 bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
 bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem);
+bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem);
 
 /* declarations for message passing transports */
 struct scmi_msg_payld;
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 615a3b2ad83d..adb69a6a0223 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -21,6 +21,7 @@
  * @cl: Mailbox Client
  * @chan: Transmit/Receive mailbox uni/bi-directional channel
  * @chan_receiver: Optional Receiver mailbox unidirectional channel
+ * @chan_platform_receiver: Optional Platform Receiver mailbox unidirectional channel
  * @cinfo: SCMI channel info
  * @shmem: Transmit/Receive shared memory area
  */
@@ -28,6 +29,7 @@ struct scmi_mailbox {
 	struct mbox_client cl;
 	struct mbox_chan *chan;
 	struct mbox_chan *chan_receiver;
+	struct mbox_chan *chan_platform_receiver;
 	struct scmi_chan_info *cinfo;
 	struct scmi_shared_mem __iomem *shmem;
 };
@@ -91,6 +93,8 @@ static bool mailbox_chan_available(struct device_node *of_node, int idx)
  *		 for replies on the a2p channel. Set as zero if not present.
  * @p2a_chan: A reference to the optional p2a channel.
  *	      Set as zero if not present.
+ * @p2a_rx_chan: A reference to the optional p2a completion channel.
+ *	      Set as zero if not present.
  *
  * At first, validate the transport configuration as described in terms of
  * 'mboxes' and 'shmem', then determin which mailbox channel indexes are
@@ -98,8 +102,8 @@ static bool mailbox_chan_available(struct device_node *of_node, int idx)
  *
  * Return: 0 on Success or error
  */
-static int mailbox_chan_validate(struct device *cdev,
-				 int *a2p_rx_chan, int *p2a_chan)
+static int mailbox_chan_validate(struct device *cdev, int *a2p_rx_chan,
+				 int *p2a_chan, int *p2a_rx_chan)
 {
 	int num_mb, num_sh, ret = 0;
 	struct device_node *np = cdev->of_node;
@@ -109,8 +113,9 @@ static int mailbox_chan_validate(struct device *cdev,
 	dev_dbg(cdev, "Found %d mboxes and %d shmems !\n", num_mb, num_sh);
 
 	/* Bail out if mboxes and shmem descriptors are inconsistent */
-	if (num_mb <= 0 || num_sh <= 0 || num_sh > 2 || num_mb > 3 ||
-	    (num_mb == 1 && num_sh != 1) || (num_mb == 3 && num_sh != 2)) {
+	if (num_mb <= 0 || num_sh <= 0 || num_sh > 2 || num_mb > 4 ||
+	    (num_mb == 1 && num_sh != 1) || (num_mb == 3 && num_sh != 2) ||
+	    (num_mb == 4 && num_sh != 2)) {
 		dev_warn(cdev,
 			 "Invalid channel descriptor for '%s' - mbs:%d  shm:%d\n",
 			 of_node_full_name(np), num_mb, num_sh);
@@ -139,6 +144,7 @@ static int mailbox_chan_validate(struct device *cdev,
 		case 1:
 			*a2p_rx_chan = 0;
 			*p2a_chan = 0;
+			*p2a_rx_chan = 0;
 			break;
 		case 2:
 			if (num_sh == 2) {
@@ -148,10 +154,17 @@ static int mailbox_chan_validate(struct device *cdev,
 				*a2p_rx_chan = 1;
 				*p2a_chan = 0;
 			}
+			*p2a_rx_chan = 0;
 			break;
 		case 3:
 			*a2p_rx_chan = 1;
 			*p2a_chan = 2;
+			*p2a_rx_chan = 0;
+			break;
+		case 4:
+			*a2p_rx_chan = 1;
+			*p2a_chan = 2;
+			*p2a_rx_chan = 3;
 			break;
 		}
 	}
@@ -166,12 +179,12 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	struct device *cdev = cinfo->dev;
 	struct scmi_mailbox *smbox;
 	struct device_node *shmem;
-	int ret, a2p_rx_chan, p2a_chan, idx = tx ? 0 : 1;
+	int ret, a2p_rx_chan, p2a_chan, p2a_rx_chan, idx = tx ? 0 : 1;
 	struct mbox_client *cl;
 	resource_size_t size;
 	struct resource res;
 
-	ret = mailbox_chan_validate(cdev, &a2p_rx_chan, &p2a_chan);
+	ret = mailbox_chan_validate(cdev, &a2p_rx_chan, &p2a_chan, &p2a_rx_chan);
 	if (ret)
 		return ret;
 
@@ -229,6 +242,17 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 		}
 	}
 
+	if (!tx && p2a_rx_chan) {
+		smbox->chan_platform_receiver = mbox_request_channel(cl, p2a_rx_chan);
+		if (IS_ERR(smbox->chan_platform_receiver)) {
+			ret = PTR_ERR(smbox->chan_platform_receiver);
+			if (ret != -EPROBE_DEFER)
+				dev_err(cdev, "failed to request SCMI P2A Receiver mailbox\n");
+			return ret;
+		}
+	}
+
+
 	cinfo->transport_info = smbox;
 	smbox->cinfo = cinfo;
 
@@ -243,9 +267,11 @@ static int mailbox_chan_free(int id, void *p, void *data)
 	if (smbox && !IS_ERR(smbox->chan)) {
 		mbox_free_channel(smbox->chan);
 		mbox_free_channel(smbox->chan_receiver);
+		mbox_free_channel(smbox->chan_platform_receiver);
 		cinfo->transport_info = NULL;
 		smbox->chan = NULL;
 		smbox->chan_receiver = NULL;
+		smbox->chan_platform_receiver = NULL;
 		smbox->cinfo = NULL;
 	}
 
@@ -300,8 +326,30 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
 static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
+	struct device *cdev = cinfo->dev;
+	struct mbox_chan *intr;
+	int ret;
 
 	shmem_clear_channel(smbox->shmem);
+
+	if (!shmem_channel_intr_enabled(smbox->shmem))
+		return;
+
+	if (smbox->chan_platform_receiver)
+		intr = smbox->chan_platform_receiver;
+	else if (smbox->chan)
+		intr = smbox->chan;
+	else {
+		dev_err(cdev, "Channel INTR wrongly set?\n");
+		return;
+	}
+
+	ret = mbox_send_message(intr, NULL);
+	/* mbox_send_message returns non-negative value on success, so reset */
+	if (ret > 0)
+		ret = 0;
+
+	mbox_client_txdone(intr, ret);
 }
 
 static bool
diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index 8bf495bcad09..b74e5a740f2c 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -128,3 +128,8 @@ bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem)
 	return (ioread32(&shmem->channel_status) &
 			SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
 }
+
+bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem)
+{
+	return ioread32(&shmem->flags) & SCMI_SHMEM_FLAG_INTR_ENABLED;
+}

-- 
2.37.1


