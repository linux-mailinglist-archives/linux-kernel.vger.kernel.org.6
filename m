Return-Path: <linux-kernel+bounces-274949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8845947EA2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7551C1F20F07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1D715B551;
	Mon,  5 Aug 2024 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bk1bcQuM"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795615B10B;
	Mon,  5 Aug 2024 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873021; cv=fail; b=qOI9xng4kewJn62b0wyLHBBwDfZye9j5yUPTpO3m8ECJQbA22nXrUZMgLZFbDh3x2vJr3T2TKmh5q/xJI2ViTsPWggBhf/U7Djv+pEp0InhqYYv5cJ75ffBScySNwrh0ITlCxMcnpNX8ZN4RhNkZSXGPtuCmiFiOBgegwS3f2Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873021; c=relaxed/simple;
	bh=vZgHFshOypFEKbfFw+84vLXiwwF+Avero7ne4xUFTEY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=a8E28AQWtzoa6ugBNOp0rjacloCRQPNz6iWkz11rECmmX4lcw1yWzDbQq+1AK6dzYvPl8coeZP+enIqWB/WVgS3de5e961Dgu+/h7ubGNgvajC27Qu2iuYb2rtgp26QQJisdJs2tywSbp2pkch8WVJZwAQbkqRyV81y76c48CXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bk1bcQuM; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAaMW4ceXbI4ZKNyaHjU6XfOSnw+eZgYIBBBrahPfj8oXz/EsvQsQjs+F5hFq73NJCJe/yhdrYeqB9lFXHMhFI9Q804Cq6DKoFAc01uqCUjpTdfi00amR8LW9ILARipHLbRCZSd3HSwAmEVPgkXuTVzDI77FJkLI67CysD5znFOg2T7UOTMuYu/Y+DA/VgQjLS2bJHv7C666GKliqDkK4Krn7V0zWzJ+Tb+vwh7eGX/aCIR82QohzJ8HKHs1vUqNWp3qy23pAWygVGugMrr9tcZ/WQlqxOyVT/4jeh4vmoGKL3my8QHfQeXNYrtSBWP+RHhhKUYcFvtqQ+OzPciy8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzSNgr38+ZCJs2NcXNH0KafZXxwYFNFvRQPB+joQmvQ=;
 b=m55Mu9LycsUgsBRbl3Nqhr7cw02bZLjDQBx0Dc3k04dZ+4DPKnlzYS3RcSgxuwXNRCySYDm+H/U9yPlLmScOLL5djviOpjaZTAlCmW3Ujb0RBM1kjYVb2EyStikiGbyQx4yAEaQw49n7tRq3/sFCftqLiw8g1SAWwu+q3F5K1WowGafPQr4RVthJ2XCQyGaHvtz4onI6BZblbN6Bfsrn4uWUtY2IX1mLKGXSyuGpUWfET8X+aUMv1GUrEhYO129rpYmL9IsU7nJJWNM0K3qu1xo1dhYuzewBXATDpoPSl+joL7PftooMbXk/6xfyex44mIhOohm3zW5t9sqMcre77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzSNgr38+ZCJs2NcXNH0KafZXxwYFNFvRQPB+joQmvQ=;
 b=bk1bcQuMTSbYHbUAxnOYv0WEQVoS0FkBABWlepF8LJs3E5jlXssXBGSXv7SJqctULhnLOJg9CCLclQ+nvo1FsWJlijLTegU7oIG25Jd/HCV0CtBokHPB6MIoyTOCONDoGUmG8TO1pGFmPPJjQ8uNNW1F5I7oHVWP0O8+I5mcdHx1+hAI6rumONU+lVuigpf1v0APVATl8PNTsKNYizK+nKUDmxWIUz1JS5Hj3aKOaOgYO0PfFDbAiYj+iOuU33thbmLjPEveAxYVSi3Jg3ngZ3W3Qzf+or2DTDphvM5vgmoUIg2StM2+9bf9eM6jlPEeoQWRJJrZOLPhP2kFAx2qZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:50:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:50:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Aug 2024 11:49:43 -0400
Subject: [PATCH 1/9] arm64: dts: layerscape: use short name about thermal
 zone
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-fsl_dts_warning-v1-1-055653dd5c96@nxp.com>
References: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
In-Reply-To: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722873010; l=4701;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=vZgHFshOypFEKbfFw+84vLXiwwF+Avero7ne4xUFTEY=;
 b=AalDaybymnvORC9A1mTbjTQijsqAV1IQsKL163155LHm1dOQ9kaMUxI8KqSUH2A2IyNHsq9wS
 bqjvAEOEq0ZCT+8ZvfVa8MISMbiI8nTFw3x4XKhpsX+ZrjMy56PWHSM
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:806:27::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: 9081d030-236d-4eb4-823a-08dcb5664c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUdzODhFNnFkWWgvalZ1cktEZ2RXY3NHL2pmcERGUUlhaTA0MHZtU1JoakxI?=
 =?utf-8?B?MzNjOUluWXdFOXZUalNJY3hocTB0bi9MRkp1RHdYUndrMmdsdzhmQ2lGbFdB?=
 =?utf-8?B?VmF6enhiS0lNU00yRGpKQXdTWUxVL1BIclUwNE5jZkhmOFdqOEdjUGJNNzdZ?=
 =?utf-8?B?REUyaFRWc3V4SWVYaDhZblhDZFErT2VpbSttV2p5VytCRGg1UU1VK3I3dVg0?=
 =?utf-8?B?N05UZytGclM0ZzlCN0laTElzYUQySHRBbm1YeEphMnFjZXhvVkhTVzdqSnp1?=
 =?utf-8?B?Rk4zQ25XTlgyUU84cy95Y3dienczVkIyRk9EbnlFRmxsZUFMcHdlMFJtUHQx?=
 =?utf-8?B?MVlXakNSVENrOGg3d1ZVUHd2SS9leTR4ZkZydFFaY3hRU1M5d05lNHVNaElP?=
 =?utf-8?B?YkV3K3JkanZCN1M5bm5vdFJDRjc4c3lTbStzTjZvT096N3FnWE1CSE5zc3c0?=
 =?utf-8?B?TWRUZTdvRkNIczA5WTU3cXdnMXhlWkI1bmEzWG5LSjkwc2FEaFVxZ3pqTVlW?=
 =?utf-8?B?VnVuQThmeVhjRDNYSWI1V1FHMm9uVmtuYURqaVp1UkFoWkMzcTZCc1RhTFZy?=
 =?utf-8?B?Q3FQeGFQUmU4YVd1bk1wN0hwcTdTUFNlenNqMGRIYmZiMkJnYkovenNET2Nw?=
 =?utf-8?B?djYzSThiNkplRVA5YjZ3eStDN01tdmFlNG80ZXJDVkdUUENIV0dKMTR3Y0RW?=
 =?utf-8?B?UGZiM3A1NXo2UldOai84c1V4VkljQXUvMDdJNlZwRCtoNUdyK29ySHZOWXpw?=
 =?utf-8?B?QkhJWnkvMDlrWGQzYjJVSm1XOUhnRlF3eHdYMklTQ1VNTlR2TFFZMHhha2pB?=
 =?utf-8?B?L1FVNVhFbXBoa0lodThDTUd3MXY3eE9vUS9FMHQyT0p0WU5vaU51anA0aWlo?=
 =?utf-8?B?UlN4ZzYwOXlWTjFvb3g4QWFEZW1IU3JsREx6S3lQZGlTbjhDdkN2QklTV3Y5?=
 =?utf-8?B?TFp2ajRHTTlLSjROK3ZYMHZtNmNRNVpnaTM0RWdpNU1LOXBQb3Q2aWp5dUJu?=
 =?utf-8?B?Z2drTFhkRlNONDVoVHBMMFFMa293enExTkpDZHFCNkkxMzNRYVhaMFVpK3Vs?=
 =?utf-8?B?Vi9uZzdGeml1c1REbEx4K1E3N29rbDRHb21GMlZHa0l1MnU1UkU1Z3BVVWNX?=
 =?utf-8?B?aWlVL1ZYc0FkSHR6SE1UeVQ4T24vdVB5YTJFclR2UnA0RFFtekZjaUZyVjJL?=
 =?utf-8?B?RWIrdTMrWGgrR0prMFZ0UzFieUtrdTBOT0dUVlFPbjBFUDJQYkpGQUtYdjFP?=
 =?utf-8?B?b042dE9Obm5JaXdYNiszUmdnNWRsL28yOWtza1d0elpVU1R4Mk4yTDluY1dl?=
 =?utf-8?B?TERzelNrY1poWkFZb3ZYbWRsZWlVRndabnJvcGZEVm1wZTE4L3hZNTAyMW02?=
 =?utf-8?B?Q0NzdDF6VTZqaHpzZGFtWmR4YjZienh4MjAva3hQWWkwNmJ3T3ljZnR2SE1D?=
 =?utf-8?B?Z2IwWGk3RU5zdUhTQ2xiVWFtQ0NNSFhlVFIwTHRIaGc0ajIvSGJVSUNlTWs5?=
 =?utf-8?B?ZmlOb2d1Q0pZdWFCRkZqTWtScGkzVmN6ZFpwVEwrSzQ3NkQvTXVZTHMxdGxv?=
 =?utf-8?B?U2ZITjMrM2JoL2o1T21BSjVJMlJtK1g0QlAxZU9mVktxQW1ZazByeTFqaU1H?=
 =?utf-8?B?ampJMmpNcG1UemNRSkJmeWViRUZmMzltY2s0TGVSbit1eE9ZVjkrdUQ1NVRF?=
 =?utf-8?B?WFZmYndYWmJnM2RnZnFsUDMydzRtVkFjTXlmNzJyank0c0VDa2k0UXluV0k1?=
 =?utf-8?B?OTM2MFVTeTNUeXd6dFRMNWRvanFTYTNPYzg3QTErYTJwOFhzTGMwTENaVDg3?=
 =?utf-8?B?Ynp1M2JHRzNRQWtobU9UdEo0ZVJyTWNiMTYzcXhxaEY0L1hXTHY1ZW5yR1hk?=
 =?utf-8?B?TDNBTFB1T0xUSzVYNnZua21DTXpUejJWNUtHalVvQnptbWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWNnZkgvb1QreXJVWGFPVHNtTXpqRmJ3aU53YVJmM21tQVhHbnpJVU42ZHV0?=
 =?utf-8?B?VkhaaDR0Z002UmdIRldOMFBrZ1Bqb0oraEw2MVNDMnNRcXpoM0xXdE43YklJ?=
 =?utf-8?B?SzVwVURmNWlFUXZOa0kvK0p5bFhyTksxcmR6bDF0aGJoSjRKamRPZHVQQ2s0?=
 =?utf-8?B?ZUd3bzRTYlZqeDhwaXdrSEplQ3JidzlHenk5SlZKOUoxRnlCVTRSVzhQWGpG?=
 =?utf-8?B?QWF1bHlHWUV0QkVPNlVVbWpsZlhnNTlIMkkxakZHZitzUnZJNFlIdUQxbzk5?=
 =?utf-8?B?SVdQbTJKVXVFMmZvcUhiZU16cUU1eDRuWFVMdlNlcnVKSzdRd01MaGtZbEF2?=
 =?utf-8?B?K3p5LzBuRUZzU3Z2QXdaK2Z5TkNWeEgwWGRja2xmYW5OTW9VRFMwc2RLN09h?=
 =?utf-8?B?Mkx6T2xCNVNMTzhFNlF0S3dUK3ZaMVcra2tTR2JvNnBMaFhPd2NjSnJnNm85?=
 =?utf-8?B?aEloSjlwMlJOVFlhZnNhY05lNFBGcFpWaXJaVjlvMHo5SElpTVNoS2MvSGoy?=
 =?utf-8?B?SklmSmR3Zk1EWThHODRIcVIzVWc0REcwcXFrRFU0TzkzTkZXTTNxSnlLUWp5?=
 =?utf-8?B?TVRQZllacmJwc05pOFNSSXlaekxHRklMZkcwNmdiM1BUTy93bnh5UGFSdVJS?=
 =?utf-8?B?M0kvd2Q0Z1gxQXhLMHRNV3dFRG9nSWZHOEtVdDhsTTk0aWNDN2xGYkhYWHdP?=
 =?utf-8?B?ZmQ4QWVwejVYVVR3d0U1Zm9RUnh2RUdoRjZaRHZZS2lzY081NDhOOXZTR25w?=
 =?utf-8?B?aXZCN2JaZVRjR1ZaSkNYcmZJY0RpOXpkbXJ0Q0JKZUZLeXJVSk13ckYrTWFC?=
 =?utf-8?B?Y1AyL0tWUHpjLzNrS1dVNFlWdC9sanFsK1dWQnZTelNnRXZMSm5yUVRIbEZ2?=
 =?utf-8?B?eGZtdDdRMXl0eWJMTnFPZFZ4a1lzWmMwalNRVkU2ejR3NTZiQUh0NUZWUjdP?=
 =?utf-8?B?dUdMZWk0Q3R0T0c0cDd3akZYcTFRNTU1UEJvZEF0MlVHc3B0bkFVUndBYk02?=
 =?utf-8?B?blA5K096TmtWYW9WR1hGSEVnT1EwWlJsUGY4eFl0eFpLa1l4WDdONXNJQWln?=
 =?utf-8?B?WmcrVnM2bEx5YkNDRHo5ZmcrcDNuTTIxejRuZ3RRVlZyMi9nS3pMOHo1QTFB?=
 =?utf-8?B?VW1vcWNnc3cySnZDZElqT3ZYUFdEd3FteU1qQnk2ZzNFYjMrbTlMRlF0TnhQ?=
 =?utf-8?B?aWFsTlN6T3RNZnZYejhxRm9HZXVlZ1VWQUVDZzlkUDRyM0RBeUlkQngrSnZD?=
 =?utf-8?B?akhMZ0FTTFJaeDFxQ1VxWkViNmRNdERIVTJCY3NjYXVQMTU2d080ZnVldjV3?=
 =?utf-8?B?Mm1lNHRnQzhKRnRmVWxCRVpxM3d0YXJCTTkrVXpSZTlESWZDK21Mc2hWRjA5?=
 =?utf-8?B?SjlGM3FRODlPTUhGVDZMWTBZSE14U0ViTXhUSmRFVkcvbUZSNmozR2Nuc3Fm?=
 =?utf-8?B?TXh0UTNJRWdEUHRxakJwdCs2cmpYTDhBeHRyY0hkZGkyc3V3Zk5BakJFcHlz?=
 =?utf-8?B?K1dhbmZINTgrZEpmM0ZWY0hZQnBJaWppTm5lTDlYamZGbnZxb0FNWTV1UnV1?=
 =?utf-8?B?NUJlRTV0ZzdHV3VOUllzYUFhbjV0UzJUTkZKUWdrOGVRY2Y1SlB4aEhEU2Rz?=
 =?utf-8?B?Ly9KcnQrQnBWQUQ4QkQ0d3JRS053S0syaWR5UGxmbm5YdlBRQVI4K2gweSto?=
 =?utf-8?B?TzlPMDhnb0JCeWFuSGNuQXJBZS9BdFI4c3BJczJSZm42eG81VUVFU3YvbDB6?=
 =?utf-8?B?UnVWQTBnZFVmeXRSMXp5ZEhRZ0RnRUNXcVpmQnA2K1RWcVBhVkNMa0hMZnBE?=
 =?utf-8?B?ZnFkN1ZhbWtpWW1Hb2cvZnIySUtyMDQ4Rm4yaTRteUhyUDZSOEVHZVFJM0hv?=
 =?utf-8?B?R3FoZDFXenFib0VvejBLS3RpSzFLSFZnajVIUndWOWdXU2pEeG9nVEhHeWJl?=
 =?utf-8?B?OTU5MUtMOWJZa21pVUN6OGg5a3lHaytidWQ0Qk9WSEtTZU0zMkVRcEdUQUlF?=
 =?utf-8?B?RkZidndGdGFVTVcvZjIvSFlzVnlXUTJuNEFMZXEzbVc2L3Q0Zk5ZNE1qUzJ5?=
 =?utf-8?B?L0xrWlRFVWVudzdwT2Z3eFBnQ2pSOCtPRU1JbVdsNEVjQTBlQWlPYTRxdnh2?=
 =?utf-8?Q?N2Y6JDbU/o4XAP9SHlh2xhPA8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9081d030-236d-4eb4-823a-08dcb5664c56
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:50:15.2773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AaOvXXGXo/uGTICplSLyrNuDuuGS/fAiS0dRKJ8LKRQwZcWkm49cPhheFoaIXBYVEExBqlsYM7Q03Yf/kuv3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Cut thermal node name shorter to fixed below warning:
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb:
  thermal-zones: 'core-cluster-thermal' does not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$', 'pinctrl-[0-9]+

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 14 +++++++-------
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 6b6e3ee950e53..82b0bef07034f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -175,7 +175,7 @@ ddr-ctrler-crit {
 			};
 		};
 
-		core-cluster-thermal {
+		core-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 17f4e31711209..402499f68f47a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -214,7 +214,7 @@ fman-crit {
 			};
 		};
 
-		core-cluster-thermal {
+		core-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 3>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 200e52622f998..f8f45c99507db 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -182,7 +182,7 @@ fman-crit {
 			};
 		};
 
-		core-cluster-thermal {
+		core-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 3>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 8ce4b6aae79d4..1a696f54c0be5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -131,7 +131,7 @@ its: msi-controller@6020000 {
 	};
 
 	thermal-zones {
-		core-cluster-thermal {
+		core-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 0>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index bde89de2576e1..2e4dfad637bd9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -80,7 +80,7 @@ reboot {
 	};
 
 	thermal-zones {
-		ddr-ctrl1-thermal {
+		ddr1-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 1>;
@@ -94,7 +94,7 @@ ddr-ctrler1-crit {
 			};
 		};
 
-		ddr-ctrl2-thermal {
+		ddr2-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 2>;
@@ -108,7 +108,7 @@ ddr-ctrler2-crit {
 			};
 		};
 
-		ddr-ctrl3-thermal {
+		ddr3-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 3>;
@@ -122,7 +122,7 @@ ddr-ctrler3-crit {
 			};
 		};
 
-		core-cluster1-thermal {
+		cluster1-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 4>;
@@ -151,7 +151,7 @@ map0 {
 			};
 		};
 
-		core-cluster2-thermal {
+		cluster2-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 5>;
@@ -180,7 +180,7 @@ map0 {
 			};
 		};
 
-		core-cluster3-thermal {
+		cluster3-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 6>;
@@ -209,7 +209,7 @@ map0 {
 			};
 		};
 
-		core-cluster4-thermal {
+		cluster4-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 7>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 26c7ca31e22e7..65d05e5fc010e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -492,7 +492,7 @@ map0 {
 			};
 		};
 
-		ddr-cluster5-thermal {
+		ddr5-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 1>;

-- 
2.34.1


