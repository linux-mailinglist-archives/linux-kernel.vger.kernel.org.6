Return-Path: <linux-kernel+bounces-236518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321C591E34F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5572F1C20D49
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEF216DED2;
	Mon,  1 Jul 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mCps65Dk"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C13D16DC31;
	Mon,  1 Jul 2024 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846250; cv=fail; b=ILBhpSk/Fal2lfPUNDWEX7iY5OUKx+rlcFwKiByBIhQ0hBTKHiivt9iYE38GP6N/tQPye0yN1uwk8jY6D0qd8jG4P3R72i7nK7tdgfhjYBvgTfFsKMX3e+NuSl0ZWPET3w9F2MusRdbGFKDToFg+J52mf0VwGMAzEDI+Lp1TBJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846250; c=relaxed/simple;
	bh=XRqBWVGSHdf5zR2f2daBiuyt82NoqI38HxfdQkKNzOY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gEIrzwwSt2iK+DNznEqcFkh3MWkgVul6CBJN9fQCJssPL9NfernEkOIYx7nsMModLUJvB5iPEd8LPnlTggaLSGCNF0M4dZERgFOCTDX4RyqShiBFQ/6tXT/40qfhk07gmqNb/LzQj/1t0iq50gJqrE8qwDwneUW3Ql6SVU3qvkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mCps65Dk; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLCdHHtYIerNrgbbKNFpI+lOKMxiB+qgnNgu+RRyvxgpdxFUuo9hDzTljx2Mr94kLhwYy5pC0eU/YSp8sTlVawdyIx0B8uFgFHjYH3qQo+KZ3J5cBcpG+oYmTnSHbzKudu08vP9UDMe19RTCsKINO/WXCUq9FMsmjgQetA8YrbJW0SvuiDTyuBwvhiVfnKOlM2Vw1dDgdgx89Ie6ebvBGSDMqUJl0axZvxfhqqK91zKbHnxSYktQuGgqjGzsAbAn16H3ikpbx1fpc7sOe0dLdz4dp699KhtIMFwvmRRU7YnP7EYqaQmst4Jp/a2cerqMWt5infWWEuYVcB+CfIhfqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpq1AC9mz4pT9GIp5G+fdD9mlv1KekLqmjkHWkmgZcw=;
 b=VOxS9fWonH2iXqU6RCRVJjUiNCBWDTb5cz0XBaiCXT1EKchV7yYif1QN0WnmhZQ1TEjpU0IGGrQ77Lvs6/Q15m3YaZ9nLcjKWy7w9U9koFq4GEIroGXqvu/ervaY7/pc3j0m3Q9WuyqnO5/rpXnbalJn31f+oLy3TQiux2afAJa2rWi8vMLiLT9HCZZl8mOXgfj46ish2SsNjjAL+M6U+Rerf7lwzFtL3OV0uVQ2RoKZ0SWeebwZtpDd7YORfjuWCyKBHzsQQEza4sIgAK42HM6hCGc+FmPJaSbHnpNyaT1uPtTx7Yo6CG7FsovDuU/tzjptULB9YfM1QSeAsxmRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpq1AC9mz4pT9GIp5G+fdD9mlv1KekLqmjkHWkmgZcw=;
 b=mCps65DkWvMCZtmOFRtmH5HAoCyKzK8R4ehWmMhduvP0n6wFp1XDYL2g8Ybmli44ikEzcW+ktAnhlFSNWMsbjNSTYLuLJx3o3PMV+T4YhYyhMIjidp/5ZSaaRBDBePAwDRZj5wQtzsatmZKMyshTB/WAMAmc8HsBWqTB23HuInY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8166.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:04:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 15:04:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Jul 2024 11:03:31 -0400
Subject: [PATCH v4 5/8] arm64: dts: imx8qm-mek: add cm4 remote-proc and
 related memory region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-imx8qm-dts-usb-v4-5-03cdbc8c44b6@nxp.com>
References: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
In-Reply-To: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719846224; l=2962;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=XRqBWVGSHdf5zR2f2daBiuyt82NoqI38HxfdQkKNzOY=;
 b=woS4I7x2/+/Ek1xi+3bWQwNgOcZgrZrih3VWk/Iqf2XqrGi9Q7vk2ZcIydWESGYu9CVGWRdhr
 ewAzYpqjOUTAaQpP4QLnFw0UpvOvAJRShfJknFIxyeSxWy0LIUc5GPS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: d52b6cb6-f118-4ae8-def5-08dc99df0cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTRBbjBlcFNSWFBPS2dXWHZJYlhqOVV2QzBRME8rN0ErTjVaNlBDalVUbE51?=
 =?utf-8?B?bjlud0J3cVB5NXljQ3pMK29hdHErdW5KYXB4aDBaU3lBZmJsYTJHNzBPU1ox?=
 =?utf-8?B?ZTRiTGpFWWhnOFg1YlplRDJXR1d6cFpRNGVpNlpENlJRRkdqa0owRGtHWGNG?=
 =?utf-8?B?Q3dwek9DM0xMM2VpVXE5UlhZRHpsaHQ5c2RiVkMyRGJ1MnI2RkVHcEVXT2hn?=
 =?utf-8?B?d2hERDlCcHp5Ly9sdHlUN3plUEo0MWZGNHpKZ0VaUnp1MGtHYnM5cWNhWjl6?=
 =?utf-8?B?eC81Qkp0eDFEZzlzYkJDS21iVUUrT0hUS1ovb2ROUHMvZEVWS3YxcE1aclBh?=
 =?utf-8?B?VVZQNXpJSW5YMUR1MjlvdXBIM2RyazdBYVB5dkVQVjQ3Y2RzSnVIWjdPYkFk?=
 =?utf-8?B?M2Q4OEc5Sm5xaHROc01FMUZtNU0zYWRIbkxZaUQ1U1A1MHd4M2FnSEpOb0JL?=
 =?utf-8?B?TkdRWG0zd2Y4VmJ0Nnl2TXYzUzUyZDFUUFRWTDM2UklWeWhRb050R3oyL3BS?=
 =?utf-8?B?REdyV3E0Y2JuMU52YSs0eHkwSGh1YjhRTmljeHZEbHhGbWd2RWswZ2VkL1B5?=
 =?utf-8?B?dFRVREs5cjRNWW9jZ0pDOXFYU001eGdCaXZuQllFbUd2ZlJ6T0l0M2xUSHdF?=
 =?utf-8?B?amlkOXJLUDJldm43TXMyQ0pNVHdVT2d3R21MeW1QL25oTng2VDhxWW95cU1X?=
 =?utf-8?B?aElaYit0Y3NZaWp1YTlELzJROHpQU2pab2JKa25kMDlldjV2TmI4UTFMaUJC?=
 =?utf-8?B?QXVKa2RzL0psVGRMcEpLcEVHK2o0SzhFWUNYczB1ZnhFS2UvQ3VQQS9hWUZY?=
 =?utf-8?B?ZTRmRDc5ZnpkK0hYTE1ydFRwbVBmTmRsV016blcwei9SQys1TVBjZ2tjUW0w?=
 =?utf-8?B?NjNGcFN3Q056bko0cHlRUFoyVzR0cC84M2RldWVGb1BKSFd4RDltcnJ0WURP?=
 =?utf-8?B?a0gxQVhoSFFDU2xacjJ3Vmg5d3Vva1R6RUkzL1djNjNvR1JqdlJONnVDRU1j?=
 =?utf-8?B?TzNHL3FoVDBEVVFCb2JLdHkzaU0yUnFtaEkzSXNDUWt3cFl6Tyt2eFlzVkVh?=
 =?utf-8?B?b2krK05nRFJqa2c2NWYvSEJpNkxLSkpIcTl1a0dzRUtlNXp0a3hWM1dNRkNS?=
 =?utf-8?B?SUZvYXNGNHJvdnpPR1F0ZW1hTi9ZUnVoSXQyN3RRNUpxVHAwRWdBb3o4K3Fn?=
 =?utf-8?B?YnZKUmxVT1lKc1RmRldEVzB6YVRzRnpMREw2YlBwaEZzbGpnSWtQVTU0eG1X?=
 =?utf-8?B?ZHhLSzNnazFKT1EyZ094Q2lqamRpcTd3dDUvS1Q5NkttRnRPemxDcURkNi81?=
 =?utf-8?B?UmhQaDlqVDJqVG9Ia01hMytUTXF6T0RFMW9WaGxzUGFHUnMxcVpiTXdTOUVq?=
 =?utf-8?B?dUJzc2VwQUxORzhYaldDTmp6VytCVHE1VVV1S2FUZGZkRmp6ZktiN3A5aUxW?=
 =?utf-8?B?QjVYUDY0L3lKZGk5d1huV2FwelhITm0vK1I5Q3R5OU1jazMyV0UwczJ2bUZ3?=
 =?utf-8?B?QXM5SWZMb2E3RGZzZ05lQk9qWkpwTis5Z1J5aHk0ZzhXcDhzQkczRmRQRGtO?=
 =?utf-8?B?WXRIR3FpZkR1UnlVMU1zOGFlK1lBdndUMURYcld3bkRYb0xGdERhQmdWQ0Y4?=
 =?utf-8?B?amVseG9DQzF4RWJJbDYyRWsvVUE3TXJ3VkRLWlJDYjlxeWtYWS90ZjlXdmdS?=
 =?utf-8?B?UjhaaXBxaGNGVm5ZZGRVZzB0dXdUQlN3d3BucEJkNXI1RlVaeXh1Y3RmUlZI?=
 =?utf-8?B?YjdMNXEybUViQXpoL1RDRjg0andCZkUyR0w4ZXVZRnpITzJPZ3FSMjAzekky?=
 =?utf-8?B?M3JEb0dnUmRWeUlBbzZvaXdpcjN6RTNWNVN4YjBhaEhBM00xbm55VnV4UjdJ?=
 =?utf-8?B?d0ZtRnlBNDlreWFRMHpWeGFSVGNPd3N0MTFxUlVXZ1RwR1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um1URHZ0WFUwWnc0YUd0M0tyTk9GTWdmV2ZPcENjZ2padEZOL2kyYlBlZ2F2?=
 =?utf-8?B?YjdsM1VGQzFDcTFaSW5qV3NMaFlEcm1RM1o5WWVialdFbDVwc3lPN0hRMFZH?=
 =?utf-8?B?MDBPS01GanlWV2RVbDNxQzc1QTN4bGpsMGVwVHZmbUx2U3d0ZlArSGNFWE1R?=
 =?utf-8?B?S0hWblAwdjFTeWZqWWxRMmJ1RHhCTDhueTEzeDNKSDE4Zm43ZEJ1anY3R0Zj?=
 =?utf-8?B?T0VCRjllRFphTXUwUFM4ZDcwMlBBRVpNWG1kMkF0TExRT0pSdG5PcXZwRkha?=
 =?utf-8?B?SHUyVHZHUlpFYTJLUjgrODc5ZkxpTXNNbVZibWtnTElMaGNkRDJmMmI5cXFr?=
 =?utf-8?B?Sm1CRFJsZGN6QnhCQzR2UUl3L0IxWlBOb0RWczI2TjZDYk9jRFN0WklQMWpq?=
 =?utf-8?B?MVA5b3pDRkwzOHBCaUd0WUt6OHQxRnJURlZrVDNKL0xQZ3dxd1pPUjhBdzJw?=
 =?utf-8?B?QkoxdldXNVBZZE9QWFh1M3lCYWJqd2JLYnZRWlJqYkc2N20xT1JQZmQ1VWtT?=
 =?utf-8?B?RGxmcG9sQUdMamtkVk13SDZ1TmtQL2gybER3ZU9FejA4QTZrZUFoREhXZ2dO?=
 =?utf-8?B?RHBBbDBQQ2lLcXNCQTdSdTBZaWlhZkZvMkpPV2Y1bHdrOUJpWG9ybzI0bEl6?=
 =?utf-8?B?UGRiK2FWemIxalJQMThwU0VFd21xMXZkTEpldjBMK3RoUyszZ0Fqb1BlTGtW?=
 =?utf-8?B?UFlJN2YxamZibFNEQktjc0VWSUtTZXFXQTN3WStNSWRucU13WE1BS3B4QXFx?=
 =?utf-8?B?YlFKQ2ZoR3ZXM1JQVmlRZnJBbFd1TzBvSjVpU2l6SmxZbEhjU2ZDM0d5SXdI?=
 =?utf-8?B?OFY2UTVGc3pPcnJTV09OYm53QzVhd1lIdWo0Q2I0dlBocmtxL0lOK1hIejRD?=
 =?utf-8?B?SWRvZWNoaXdEYTNBU1BGcjZXQVpkdWdWNEJxZ21YdkdmL0lORjZvUm1sVTB3?=
 =?utf-8?B?U1hFWTlOWFZsMXNWQTUxNm9xUkNRRjhtR0JQWG1hUks3aHN3TlVLTXp3OGhB?=
 =?utf-8?B?OW9RRWY3N0tPVVZNclA2UjFHSlV4M01uMFpDM1Vxd1Yrd0ltZFFkU0xieU45?=
 =?utf-8?B?bW5sY3lkdzJxRSszbGFVMFo5RW9RUkVoWSs1K3BJRDBldUZERzNvU09NYlk1?=
 =?utf-8?B?VTJWaitoNUZib2ZmNTlJY3VYbThzNURqeVhZbDNQZ2VyV0NkRlFvRHh4bUZI?=
 =?utf-8?B?cUVVODhZQkIzTU1WSk9tQnFrNG5NeEcvUy9lMXRlWnp3NzM3TzBlTFVtbnRS?=
 =?utf-8?B?N1U0bG5xa2tOMlpMVHJIaDljamV5Y0g3Vm5UbCtvZ05qL0lSMGE4TlNYbktp?=
 =?utf-8?B?cTVFQ1UzRzE0anV1MzVWaENvaXFVU1BVVHlidGNlMHBqMzdjYUtJS25OeFFD?=
 =?utf-8?B?UitxeDZMb3RCQVByZ2hvc2cyNlRDcnN3T1VNcmM4RFFKOHJJZHNDZHBrNzcw?=
 =?utf-8?B?eWl2cyt1eC9TZEk3YVFvaUFkK1F0SlIxNWF2T3ZVK3RUeWlNa1kvM0FJUVpm?=
 =?utf-8?B?dldwcExUMFhsbVhobVFaaE0yUVovVHdHeFRHV1pwSmV0N0hBOGxLM2dQcmJz?=
 =?utf-8?B?RzV0a2Noa3lqT0hKUWZKekV5Y3RqYWkvZEtzTkpLQmlIalhaaEFNZitaUjZs?=
 =?utf-8?B?bm9OajJvU3cvNzBNcnZQeGdUL1lqVkQ0TXZ2Qm9QV2JpNWZoNklUQmI3N0lO?=
 =?utf-8?B?WEFaUGhjQ3FuMVk0WWZLZlVydEtkTVJ4akdTdjBvQWNKZE9XRkIyOFNubmZN?=
 =?utf-8?B?ZndlbDB4Um9BKzJScGFCTmtIdWdoZytXUU0vbHI4Z1RhV0pQV0kxVzZOaU5y?=
 =?utf-8?B?ZVEyK2tPeTFBMWx4dUI3NEhhem9aZStvSTBCWk0zNzBMbWgrbEtVWVQ5YUsx?=
 =?utf-8?B?VjdoL2M4MnI0OUdYdjdxdWhoYmtQaTVaUUxXS2o1TDROMmJHbEZLLzhrNmls?=
 =?utf-8?B?MTZ2SGtETkpIRHFSK25pWmJWaWkwOWpkTnhqSnp4TlFSR1laekR3NTJVRVJi?=
 =?utf-8?B?c3NzeEJxTVMveEV0eCtXQjJZZVJJS3lTTHI0cmR6bEF6UytIUjhkaWdUQkpz?=
 =?utf-8?B?OTYydElVSm1YWERBWkV3SWZmRFlLNzkyeEthTGtjQWNFU3VrQmEvMjRXa0Iz?=
 =?utf-8?Q?rokY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52b6cb6-f118-4ae8-def5-08dc99df0cda
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:04:05.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWCw0civrTmVo60qTXXnfLyqRLAvrIsO+lu1GlsqM9TgL9D2qAyLDTiddO0c3tdQ9gOUzpd9UD9s0yMItYMS0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8166

Add two cm4 remote-proc and related memory regions.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 93 ++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 778741dbbb338..fcd904383daff 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -31,6 +31,68 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0 0x40000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		vdev0vring0: memory@90000000 {
+			reg = <0 0x90000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: memory@90008000 {
+			reg = <0 0x90008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: memory@90010000 {
+			reg = <0 0x90010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: memory@90018000 {
+			reg = <0 0x90018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table0: memory@900ff000 {
+			reg = <0 0x900ff000 0 0x1000>;
+			no-map;
+		};
+
+		vdev2vring0: memory@90100000 {
+			reg = <0 0x90100000 0 0x8000>;
+			no-map;
+		};
+
+		vdev2vring1: memory@90108000 {
+			reg = <0 0x90108000 0 0x8000>;
+			no-map;
+		};
+
+		vdev3vring0: memory@90110000 {
+			reg = <0 0x90110000 0 0x8000>;
+			no-map;
+		};
+
+		vdev3vring1: memory@90118000 {
+			reg = <0 0x90118000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table1: memory@901ff000 {
+			reg = <0 0x901ff000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: memory@90400000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90400000 0 0x100000>;
+			no-map;
+		};
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -133,6 +195,37 @@ sound-wm8960 {
 				"LINPUT1", "Mic Jack",
 				"Mic Jack", "MICB";
 	};
+
+	imx8qm-cm4-0 {
+		compatible = "fsl,imx8qm-cm4";
+		clocks = <&clk_dummy>;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu5 0 1
+			  &lsio_mu5 1 1
+			  &lsio_mu5 3 1>;
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table0>;
+		power-domains = <&pd IMX_SC_R_M4_0_PID0>, <&pd IMX_SC_R_M4_0_MU_1A>;
+
+		fsl,resource-id = <IMX_SC_R_M4_0_PID0>;
+		fsl,entry-address = <0x34fe0000>;
+	};
+
+	imx8qm-cm4-1 {
+		compatible = "fsl,imx8qm-cm4";
+		clocks = <&clk_dummy>;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu6 0 1
+			  &lsio_mu6 1 1
+			  &lsio_mu6 3 1>;
+		memory-region = <&vdevbuffer>, <&vdev2vring0>, <&vdev2vring1>,
+				<&vdev3vring0>, <&vdev3vring1>, <&rsc_table1>;
+		power-domains = <&pd IMX_SC_R_M4_1_PID0>, <&pd IMX_SC_R_M4_1_MU_1A>;
+
+		fsl,resource-id = <IMX_SC_R_M4_1_PID0>;
+		fsl,entry-address = <0x38fe0000>;
+	};
+
 };
 
 &adc0 {

-- 
2.34.1


