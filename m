Return-Path: <linux-kernel+bounces-363603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 680B399C49B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3EE1C22264
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EA81581E0;
	Mon, 14 Oct 2024 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="saPI0gTJ"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2054.outbound.protection.outlook.com [40.107.247.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A181C156F27;
	Mon, 14 Oct 2024 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896582; cv=fail; b=ps5jJcEA9UT99rK/+kwThvZ5OWDilc9aGsAMwlDqFD7i/dXgMRLisgOA3rl1VwLUU1Agez6jU8qkCqryXRnXIe9Hc5eSPere/ytcUSmw4+eusfBUOKBilnaxvOUfO+UxAHZDjvzBoVILALF3T67MlGXYu3F27/qDNcNzUP5bm4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896582; c=relaxed/simple;
	bh=v8ksMBxvbeVAy80xC/9SxZUA+6+FZGxZgqOBK4nC2MI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ax0aeI14TXtH/Xj3Bsyy8Ko8FIZTXl3zFauv/+wXhcq1fGmVO/iZkSdWRE2SU6F5iVdG/15wMxTt/Q8uEgcxYQOZWusxdByLUBqJgv7s+WuM+nQJjDJXYzmsUSMtJ9m8t8tSnoUTsxowK+aUsJg4L7LSUPFQjUuyNTS4DeLHWbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=saPI0gTJ; arc=fail smtp.client-ip=40.107.247.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rw3mQQWRFYN3OK760Qm6amBGTx8MMpr5A6KreozADSVOL/kfZrxSUXaugRtpyjZEgsIIoCfQ3pKBmrXyz/Pe+qjRLwrxeFAAQxUEvHNzuAMYDEsrb5TLA6Rmluxgssh8ENS4vDb3/w+6nNYV9LSsP4SsHlLIidoxgUXZ1aMjxMBL+OqFczAz6RgfDp/w4kiUGRZXkA83SXAdxk9qIN6p8Yo55sQNAeCrxpTnYomqvnD60gnPoy8EHjCWqXaP+ZEKURcjW1C/boIpIvogAHfsXOJa4XEgdZFcqRasvYJyCpY1UgsQknIGL1ssybdgpA7ejzhjgwpJv+OXpdM12q3NXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tll9CQpoI2JYPFCpRJcMtd6vZ7urFG2dHGkXxAOPskU=;
 b=DptD5A05zeoEkqfd76+xq5E21bguA7/h4NySK8MEto3DhlI/JfKs/U3qI/GmxviXpAqa4U5LP8QJ5QFJKJ+XmGHesJpqKznP7PptWTa0Kv+bnNJ0BQ3Anddu82/Gc5pgtQLcMBrmEG4YtmUJX37YgX73dlNkhqKUrBaJTB0UrIoMZTuPAHbyCJPbvUJaCP7vUoe7NRQI00cff/FeRnjKPnClfWDNVrg2syossHmAr//jvaeltet+sKnRE6FwZEK7egOxNrwoyGVQxKSO2k9W/djgIipuiH6JA9w7Xil0VZ/VpNKsxw5MEsi6KuRCpnjnmJZm8kki9nnsQhlnM58fFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tll9CQpoI2JYPFCpRJcMtd6vZ7urFG2dHGkXxAOPskU=;
 b=saPI0gTJf911xgSKUcwNNMnfz4zfzwpYayiZI+cQ3/k2JIcZiBv1xWemTewN5CIfOuNVHPl3PoLxUUspA2Emt6oKmFDisLt/Fa2Yn62Thvd6honJr9iqq0/rZoneosq2/hZF2c+L4A+EJOqODdQTEfMgIUO2qgWobQ+pqAsH0TU1dQaNU0dH+jNcpK01DW28wZ8kN6+LsS/cNOKxiYI07xM+HimhrsbEF4qWepTYfjil9ahu7VslR0ZnMYp7y5KqpBL6gem1gzIQlbvrnuomh2m0PX27a7bAoSJiuv2ASrgSb96hzMOg/dnri9nRA7UF/1knEuPt+D7VNCnxnC1d8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAXPR04MB8765.eurprd04.prod.outlook.com (2603:10a6:102:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 09:02:57 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 09:02:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 14 Oct 2024 17:11:24 +0800
Subject: [PATCH 3/4] clk: imx: fracn-gppll: correct PLL initialization flow
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241014-imx-clk-v1-v1-3-ee75876d3102@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728897092; l=1523;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Sv4CHyV16UexiFdZ+yIX03Ey/S7U3vzUPoU0hMATx6E=;
 b=Don9BLt1qZNpRnAE7hpt4WSRL7PiCdVd51Urgvhksw/MZFdrgL/IxtagQMHkQY7ElrL6GNtqO
 aMhQYmeGrrrCuR2ZfCeyyCZ8W92DP5KOyYWcV5LwxPEIu+H1eXLpoOF
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
X-MS-Office365-Filtering-Correlation-Id: e786ea21-fbd5-4716-4554-08dcec2eff44
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXZlNTJVTXJWSTI3VTYyZlFHRk9tSzRSK3hEdkxHQk03TFJoSnVTQkFuZlpV?=
 =?utf-8?B?NEN0YnhYWHZrekc5ZU91RGZUdVlTMUZEU3JYREZOVnVQUU5JL0lIbGJZT2o5?=
 =?utf-8?B?U1N2WGl1Y3l6NFFPeEkrWVdnbXBUTnUrTk9EaUdPYlFzQ1VtWncvaU52QnRZ?=
 =?utf-8?B?WE5RaEpuVkNneHNHRTJjRE4yYThzalN4b2ZlaGJKV2RhVlM2NEszNmdza3NL?=
 =?utf-8?B?NU9qVEpVSEN3NFUzeUo1OUZFc0x3bHlXWW1nU1M0R1JJYnhpY3NGc2RtTkZP?=
 =?utf-8?B?VWU0RWNMd2UvNDdReVFGcU0xQUdyNzJYcmtkRmJMOGxtK0VJbmdpMyt2MmRP?=
 =?utf-8?B?VVI5Q29aSVN5akhxcWhndjRBaXlJM3VTVE1VQ3VLcy8vR1lGYmdsd2FCUWtn?=
 =?utf-8?B?eWo0MElZWDUxd3VBRkF0UHFuUHNNdjFMOU5DVTJVQU5zSHh0WGFlcU5rNGNp?=
 =?utf-8?B?OS9YZlFzd1ViMFgzVU1XVFVCVUdTelJTa0ZRK1lmWFJVTTVuNDhWaFZLVnNn?=
 =?utf-8?B?eEVvNmFNTFVDZEliVldFV0toU1VZK1pMbThnSjlhaXcrdGZJVFNRem5GcGhz?=
 =?utf-8?B?YXVydTZOYjdiM2pDaGVjZk1ScHlMZzh6TFBFc1IrN2I3QTlrdTlEd1o5SVB5?=
 =?utf-8?B?VXh4YnN0QmlXT2haODQrZEVwWUdZd1pzQUo2am1zdDZEK1ZHYlFINWpyV3lR?=
 =?utf-8?B?d0VSb3JkT0I4QW15dXB6OWlxNjduSmxNRXdKR2hESTlDelFoV3pkN3E1MTBa?=
 =?utf-8?B?c3ZFZDAvc29xUXFjQnJ4VXpua251ODJvMmJIck1FbXJ1clRSVXkxTFF0RzFv?=
 =?utf-8?B?VXZNcVFVRDJrVlVrNHlISEVNQWR2cGtONUFPQjl5cjR0L2d2K3RFZUp1OHNp?=
 =?utf-8?B?SUNoMzk3cEtlZHI1czBOUG9RaDVPN2tEZU1EYlVsbzA4UEZPNVNIRlBUdXRD?=
 =?utf-8?B?OWdoZVJiOExYT25tSkI4M1BzUHJDU0FiN2ZFM3BXcWk5T0RVdC9TdWJuR2hC?=
 =?utf-8?B?UUVuRmY2VTRQQitsUm00bHhKNmg0SVJsUTVYQUFpaTZqZzFiNnhVU1NZb293?=
 =?utf-8?B?WExwWXdYVVVlYkkxUUVIY2ZPL0xNZDJBckJIbXVMSG9mYmliTlZjNHMva2Zl?=
 =?utf-8?B?bmY2ZDl0dk1CYStidHA2eW5pbXhUYlpRSm10T3RMVElIMkN2bENjeXJiUEg1?=
 =?utf-8?B?VjlMTFlvQ1RSaVVqZVRHbWFrVHZHanVMS3Vzb0o1cWFiRUc3azlIRHpnTFF2?=
 =?utf-8?B?VFI2NXBLd1psQ2VXN24vcGt5bTl1MCtqL1h1OElXckgzSlBEOWNtcWlwalY4?=
 =?utf-8?B?aU5IZzBOUTlqY2JRbHFPbzl0Q21xRmNDUjRmcUtkZm5naVFUV2NZN3JaY05K?=
 =?utf-8?B?bVRLYzZhYVRmREFEUlhWSnplSTJvVisxT0tLM3VOdVJpQWl5elpMeFlKVkRK?=
 =?utf-8?B?MHI5c0YrN2o4ckNNaXdlWnVqbEEyZWk0cmZFSTQ1MjI1blJZeE5GL0dIWWVZ?=
 =?utf-8?B?V2JkNWhSVkp5b1dwd0FQY3dxUmxTRmU3ZmNPc05ES3RIUlRqWm1UMkplejFV?=
 =?utf-8?B?aytBdS9MT2xRUm83L3V2TG9lcDJ1SkFsRGx6TzlkSklLTFFzenNjWUFiZXVM?=
 =?utf-8?B?SEFrV1p4VThBaDB4a1ZoVXkyUEhrMDcrRmJhUFhZbXVsaWYzZEc2NCtUd2pD?=
 =?utf-8?B?UWoyQXFBT3RYRENJRmE2OVl3SnYyY2tGcDZTT1dMQ3ZtM0E1ZkRCdms4ZDBi?=
 =?utf-8?B?eTVkL2NuVWNnQU1uS0xxMklBOFhhWGc5TnUyeXNXTlBOQkFRd1I4VERVNmsx?=
 =?utf-8?B?cXU1TW5oVmxYK1EybFA5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVZRL0IxRGxlZHE3dy82dFQveGVaeUY0WGF2YUJhMEFaaVQ4VWU2bFNoYmtJ?=
 =?utf-8?B?T2JYeW9HVFdIWUFSR200YnFWNlU4S0xFRngrRHVzT1h3ekNkM2xjZGM3aWh3?=
 =?utf-8?B?SE8zQzVzZFFxTWtMekk3VkRGR3NNNHc5SnViUS9Ed3Q4R2pRWlEyMWlpOU5R?=
 =?utf-8?B?MVkxOHQ5NlA2TUdqeDltMlk1dXNKa0lhdjhjYlJzclpQQ0VSdTIxOHltU3pS?=
 =?utf-8?B?OWJJL0ZFTno3UGlKSXI3YVAyamN0ME4vZ1BFSkR3L3VwdEVudHJBRVZxNXJq?=
 =?utf-8?B?Mm9QZ2gwcFluOFZWVGh5dTBTWXFFVHJ6bmc1elI5L3BFMnJyM0NFZHhmczFT?=
 =?utf-8?B?S2locnlxM1FVNGIvcTBJcUlPQU14Z0NuY24wZE1MVWpUaFlVbEZheHhraEtH?=
 =?utf-8?B?a2Znc3BTdm9WK3NreFhJMmRIMVJ1dk0vNlMxKzd6YUVSREx6dmR4OTZ6eFpn?=
 =?utf-8?B?K1VBQTUwZGFhWmwwV0dBOHVJeTY5THg1VHZJN3R3WHFaU1ZBczZPcnZUd2tq?=
 =?utf-8?B?eE9hbWo1WVVSR3ZvYXk4amtqTlRGRDRHQXVZRHpvUktaYndhUXN1TFV4WHdZ?=
 =?utf-8?B?dkE3ZG1ub2dWYWF3OW1jM3I3RHJHak4ybHU2eGorL3dDMDZOcVQ5bmJOMnZL?=
 =?utf-8?B?ZDBiSjBTa2dKTit2aDYyUFloZHJFTU4vK1ZFWk9RNVdMMDUycms2aEN4TjFH?=
 =?utf-8?B?OHpCNmpHYnhjZzNDLzljRzNaVkRES1JaODBoT3ZsREkyL3FjeXFKNU5yNkx2?=
 =?utf-8?B?OVVvNkNDaitYZ29xdWoybjRHajkyWlpVVWEwSUMydFdNeUovL2d1M2JnLzZ3?=
 =?utf-8?B?SnJpTEpFOTVKWkI4MSt1S252UERPdVdXT0s0UHpOM3haWWlwOG90TzFSdXMr?=
 =?utf-8?B?c1pLcnlZWVp1TVJHNDArMWVVanJKSm1CWlkwVVNrdGw4MzhyclZtZVhJaFVp?=
 =?utf-8?B?N2dnSmlJQU9Da2JKdGFnaGVaK3NDYmJqOU1nZDFQQ3BZblg1cElBRXZ4QWNn?=
 =?utf-8?B?dFRSU084SzZIQVQvNHA2dldBNEZwQjl4R2Q2RW01ckVxMllpK0hJYmQ5T1lh?=
 =?utf-8?B?ZWJsWDV2UGpVeXAvNk9NWms5TktTZkhIZWxUS1gwVE95eWhYaGk0MTRtcjRZ?=
 =?utf-8?B?ck9IaTA4RzBYRmcwaDNQQ2x0MHBkZzlDejFvSzFOVk0yVWtxQitzZElDT0E3?=
 =?utf-8?B?T1gwWXZoWmlnVHlKUFB4Q09vTUZiOE1IQUxpWVZsd0I3T2V0T2NLZVpDbVRy?=
 =?utf-8?B?cURPQmpGcDEreXhNY2xXTlhrYjJ3dDViZDlCOUluY1RCNWlDdkNrNndQY3Zs?=
 =?utf-8?B?aUlJemhYYytKSFV6aWJuWE9BTnBKQXcrVEpqWjFrS1UrNTJWWlpneGFMV05w?=
 =?utf-8?B?dENQWXMyRnlqaVlPUlRyREdGSWRTK0RzRjN3RWZJNHpQVEdMZGRQM1BYOEJ4?=
 =?utf-8?B?V2NKU0N4cjR5NENCcXFPeC9pR1FSTTJSMitmR0E2aDFTUEVLaFhhalN5NHY0?=
 =?utf-8?B?NEJyVnhRMlpFSTRmQ1pBUTFjQUlGdVdVL2hGejNMK21hTldoUVpKc2VGTXhk?=
 =?utf-8?B?NVd2aDFpNGNXZ0JEdXF2dWdkYUlVQkpONW1RL0hjTmE1emNtSGJiRlNzVmxN?=
 =?utf-8?B?QWZEYjdVaTZwWi9uSTlPOEFYNEFLbmthV2Q0MG9Cd0RaTGtkYW5IUjMyT0ZH?=
 =?utf-8?B?YkVSRG44QlBqeVhJSlVtWm50aGZZaENFelRRakI0NmlBOUoxaEg1bDl1blJ0?=
 =?utf-8?B?SDArRlNSb0tlcXBYaUs3TFYwd3B0SUhBNnBxQ09yVXlldUlxanY4YUtkT1E2?=
 =?utf-8?B?RzR3U2E4ZU16cWl0WVY3Q3NxR25qaTQ1ZXlQeU5zc2IzTEljVTAxbDlpa2V5?=
 =?utf-8?B?WStLOHBiZjlqTGZQZ0NlNmp6WVVaS2NZSWo3aFl4Yjk1YmRrNWVBSW1iQy9C?=
 =?utf-8?B?MVpZWENiT1VLbWY1S0F0TTc4UUJqY0NoVVJHZ2Iya2djSVZiRUdFSTNsY1U3?=
 =?utf-8?B?MUJDRUtyNmpPZW1teGE2dXcxMDFodDV2OGU0T2QxRU9kU1hFc1pqdWpyWVJi?=
 =?utf-8?B?UndaQUtCSG9nb2YzUWZsZ05oYnFhazM5Nms0QmlnOFdrNG9BU3E3ZWxrTkVJ?=
 =?utf-8?Q?fOY+JlHQ0zLcatUVf20/HABXx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e786ea21-fbd5-4716-4554-08dcec2eff44
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:02:57.6066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qs3S88VDgbywuuLAc9mc47CNwrdU5zbpCLGt+hi1nqXT3lUeyCjrO9hOSLdLW8VdW+b7eenqBLw7r/X79hGXkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8765

From: Peng Fan <peng.fan@nxp.com>

Per i.MX93 Reference Mannual 22.4 Initialization information
1. Program appropriate value of DIV[ODIV], DIV[RDIV] and DIV[MFI]
   as per Integer mode.
2. Wait for 5 μs.
3. Program the following field in CTRL register.
   Set CTRL[POWERUP] to 1'b1 to enable PLL block.
4. Poll PLL_STATUS[PLL_LOCK] register, and wait till PLL_STATUS[PLL_LOCK]
   is 1'b1 and pll_lock output signal is 1'b1.
5. Set CTRL[CLKMUX_EN] to 1'b1 to enable PLL output clock.

So move the CLKMUX_EN operation after PLL locked.

Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Co-developed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 591e0364ee5c113859a7b6271c8c11e98a0e0ffc..4749c3e0b7051cf53876664808aa28742f6861f7 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -303,13 +303,13 @@ static int clk_fracn_gppll_prepare(struct clk_hw *hw)
 	val |= POWERUP_MASK;
 	writel_relaxed(val, pll->base + PLL_CTRL);
 
-	val |= CLKMUX_EN;
-	writel_relaxed(val, pll->base + PLL_CTRL);
-
 	ret = clk_fracn_gppll_wait_lock(pll);
 	if (ret)
 		return ret;
 
+	val |= CLKMUX_EN;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
 	val &= ~CLKMUX_BYPASS;
 	writel_relaxed(val, pll->base + PLL_CTRL);
 

-- 
2.37.1


