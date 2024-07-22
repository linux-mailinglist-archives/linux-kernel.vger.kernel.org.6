Return-Path: <linux-kernel+bounces-258459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB2F938823
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33E4B20A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3199D17BA2;
	Mon, 22 Jul 2024 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QkaU2hsU"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D796917579;
	Mon, 22 Jul 2024 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721624109; cv=fail; b=kZsUUcS4CmuCo/wq1CZqW04BiDvxaTfG/J2CfsQ5uElld36AnnyM5EehvIjfaegN1osopDqHpFLdbxXGRfR0rELpjwsgUaof7xLyWASQ9CteJHH6M17tcPXNUs9WJ2PpY2R+DurXoPmZtR3byAJWrvG0NGwFDx66RAqeTpQUz2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721624109; c=relaxed/simple;
	bh=FwHu8HOgjdeesS4jBLvkey7Y+WnnBYkcgUp1hGR75ZU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r2xfAgfhtTngukJEQiD2e+BSUnOnjM3fvOnd+B+nwo+txUV/zXwc2lV1Wh9O28O4DB4pRNo1Ghy1lFDPJSE3b7Iy717q55pCnXPwXWrURfQjXC8hxJMI+0oj4wmKyG4OkUZwzyRahVDdEz4miVwdCG9aP31uuJZkuuOwUb0Ueqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QkaU2hsU; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNwMEmSzMdWWmUytHCvif/talqi7XwRw/9BLsJ5vQBmEn44PmLbveOerNuWjSEGjD62vIU8DHemrgdNg05cvowPYGQoJfa4jJGJ1l4liwZEVFTqgHa5YqFFbbLEDDOAwyOQYoe10dhz8TFqIzWEOOWU/WV3tG89wfOnUPeeLF0ESOWq3od6OW8FJTFxKnGX9yzWT8V2LisUbnuQvhnDh188klxR/eTzrLx32LogqHomtH4oiWLgNabqsWoQBPbkEDmktZDovAWWhJq2R+Szjve+KLFxIFGn/riOZfTXPxy6EgGroTKf1OxMWxuXw8RKOwL/i2ItwoP4xvaM9l4IDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rydjPSyjFpE1b+KVUJhSPw9jPLhoKfIzwxtGoWGJhg4=;
 b=ONBBF3gZkSkwhQED7KFL25ecyiCcYDTprdJQAWjjohy1Bsyy+fk/Z1elFeuYMnEOq+cCS9+C9NZMcsn2e+nM83uqXpPYt9dlIpZl18UF0+/oUQ9hwST3DyVPVtXhphikN2twCSJuyUNKkVC+dS/c2zmciHP0mt/rjIZnedFODxq+1n3NnLxs6SfhSoF7tAOUuYh5XD9bDqSHIEhszc8t+IzxymCIdCck/jiaPbq7MosoMhJPmjppC6MRBvWkdQM/B1UwulA16AkYZsH2WBXEYKS33Hy79Bl0awBRC35A7khWFkUJ7fgfkfSiFC/a6wplUoR2ylE8sic2cWDjo9Cwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rydjPSyjFpE1b+KVUJhSPw9jPLhoKfIzwxtGoWGJhg4=;
 b=QkaU2hsUqa41lcW1M/YkxZSxcQJa87DkcGtk/Yj4IVktFsisuwKc/rwycIcM/CmbmXXUe8G+9bqCCczQoyOmXPaPfZj8p7uJkm3uoVxk97aWkypM77zBUvs042ioNLQSQNETmfRM2qiL7T1yl4YNlXKhanJT9tcdDO2J32ZuBT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA1PR04MB10441.eurprd04.prod.outlook.com (2603:10a6:102:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 04:55:05 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 04:55:05 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Mon, 22 Jul 2024 10:21:36 +0530
Subject: [PATCH v6 1/5] Documentation/firmware: add imx/se to
 other_interfaces
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-imx-se-if-v6-1-ee26a87b824a@nxp.com>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
In-Reply-To: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721623911; l=6679;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=FwHu8HOgjdeesS4jBLvkey7Y+WnnBYkcgUp1hGR75ZU=;
 b=Xf/d3sgwWHkhondZwUgp3VsXNunyBRZ1EEnsx75Uh5JowvZ9cLtNB0Vi1on+/y0FqhfhbBKHU
 t/6poiigNd7BUYD1lPdygLhBAcQpWEpfWQzLk8/ai8BvIZAS94a11O8
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PA1PR04MB10441:EE_
X-MS-Office365-Filtering-Correlation-Id: cef6496d-01b9-4c37-44e4-08dcaa0a7448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDBCcGVwVURNZGhkMFNtcWpxOElCdWVUckh6azlNSU16VThITnV1VWNpMysx?=
 =?utf-8?B?VXFQVVY0NXZJTjVFbER5blNPOGF0Yjl5M1VkT1pXSXpnQmhiZnNYaWNkNFBF?=
 =?utf-8?B?U1Z5QXZVaVFYYTN3Z1hzREc4TUVJRHcyZ0NXY210ZHRxZG84WURCSTVFUmkz?=
 =?utf-8?B?TVdkUVF1eEtkVWx5akRQaU51Y1J2WXFVSEFTVHFvSTVoSGt1alF6YnQ3SytG?=
 =?utf-8?B?a1BsQnhObzJjdFJKVUlDbnVWZjZDa0pROXNxS1V6ZThuUG50RlBsOVlXckRu?=
 =?utf-8?B?ZG5iWURBZVFZbS92RXA1RlN0U0R6Y2VuSlQzNmtBVW11cU0wQ1ozaFZSSHBS?=
 =?utf-8?B?dUd2aWZRK0hreGh0cXcybmtrc2ZRL3lveE1wcisxM1lMc1E2Q2wwY09UU21z?=
 =?utf-8?B?ZTgrbEFkVXJkWnBwTTlHZWVMWFFuU1VNNUt4THR2ZFhyZzlsUHlMWit2RDNi?=
 =?utf-8?B?cG1ZdnVKUzZVeWdDMHl4SXRNZTJtTHhHQ2Zjd1pQeEp3eW1xeUpNenNBYzBG?=
 =?utf-8?B?NDk5NHI3cUFaaS9GOTFlZGlsVFZ1OHBBSmpMWnhCbEQ3OTBuRHZrc0N1T2ha?=
 =?utf-8?B?eEJDODlqNCtuYkdjc2RDOEUrOE9Bd05USExhWUlOOGZhbTh2QVlkeGllRUw3?=
 =?utf-8?B?QjNZamN5NXV3aHZETFBjMUNEbTltRmc0UXlCamRISHR5WDdqVUdJd0pnMWhP?=
 =?utf-8?B?R2s2U09FN1dIamlZWENRcjZoSnRZV1VXZ0ZkRlVnRE9WOFpLUWZvaTBVbjhY?=
 =?utf-8?B?MGhtc2ljSHlKRUpNSDI2QUxmNTRHUVNwUjVhRUVab2h2ckppbDR1bGIwVGJ5?=
 =?utf-8?B?ZDlDSlhOMTNxaXB6aDUvZExGUGhBTXE0SGw4UTdrcjlTQzd4Vm90d1NjOVkv?=
 =?utf-8?B?MFdwcEV1RmhxYm9qbVNBcVJJdTZUQ0NvWlhSZ3lZQUF1TEVVK0dWTmptYmc2?=
 =?utf-8?B?dDdyUVQ0ODI0OVV2bHA5amZsbVJCazlmT0NHWTNDS2d2eGViWmY2THQ1UEJL?=
 =?utf-8?B?b09IU09jNnhaamJnZnZja200dzdkWDVJeTVEZzh1d3UwZjdzQnJUTFBFeFI4?=
 =?utf-8?B?NVRzMnMzVU9kOTFneUp4US9xZCtLMlNncWNaTlF6MW1YVVFwVXRSeGg3MGFG?=
 =?utf-8?B?ZGRoS1VmUlorcVkxV1AxVFUzRGxGOHoxUm5saGdZUVRzbnV5NzNqdENKWllD?=
 =?utf-8?B?MUNTY3VST3ZtL0s4K2QyMEg5WDBlRWU0cEw3TGZmQ0M0SXBpU1hRU0EyeUR2?=
 =?utf-8?B?b3puaUUrNWx6dW1la3B2U3F0czRValVxZVhCb0V6UGhXMVVpUDhxandJbDNJ?=
 =?utf-8?B?d3dzRTdKWG84eU5HaEY2V1hseVp4QTFORlhkZXMrOG9jN01GSzRwM1ZmME0r?=
 =?utf-8?B?YTNiSEJjVDMyK2kzZnZLd3VGM0lMMlZXTmxGdGlCUjlKYmxIOXNQQ1VsSlpr?=
 =?utf-8?B?dGpYQ05vR3NqYjFhNnB5WURkaERHV3pqRGNZZ3lkdW1nT0hPSjNGN1krQ3Y4?=
 =?utf-8?B?UDBEQUt3dlNvK1JGeFVacFFkbnZKTVllZG9FSjFWUHVVMmFnWXdhTTZrOE85?=
 =?utf-8?B?YjRMK0xQenNqSWFYbTZWY3o1eFZyY3JBR2pvVWExYUNhWmNZZ0tUeFZKdzhY?=
 =?utf-8?B?ZzdneXZKYW44VjVRM1EvL1UxdWViS1VlaFFLdzlBSDVnZXM4ZmtjVUgvRThV?=
 =?utf-8?B?Nk1jRHVMNzU5NzFsNHhEU2JnVCsvVyt6Q3V4akdzNlFQKzltcnVrLzVmZjZS?=
 =?utf-8?B?cHh2aVVnRkppUjdudXhNZ1dDc2lWNHJzeUd5Wm9YVHR1RXU2UFQ1RnJwVmM4?=
 =?utf-8?B?Y3EzK0hIQWk1amF1YUFxL055bXcvZ2ZXVUV2WVJVNmk5cHA5M3BIck8rdHNh?=
 =?utf-8?B?d1cwM1JxQnRrTnZQRUhiTDdDR0hvdU52UWppdGRTSHg4dENaN3hLY2wxek0x?=
 =?utf-8?Q?0WnatsKNb9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTRiSWw4Zkoxb0dwL09uTmI5OGs4bWlrdmZhUjdUeW0vTHUrN2ZFZy9iSU9U?=
 =?utf-8?B?cjR2NTJHeVNXZW9rL1BoQ0JtQ25tRFV6M2FCc1ArWFJwdXVuWGJKM252TVEr?=
 =?utf-8?B?bzAza3hwUnM0VDdDY1Y1SjFYSktNMDhtcXlaRzNwN2N1RVRjWjI3ZUxwT3hU?=
 =?utf-8?B?VDZTWDhyMithSVRUVk0wM2dCczdlT1h5NFZqSGY0WTB0WkdmSHdNVDE5MDAy?=
 =?utf-8?B?aVR3S0E4dlo1MnJRbjJmb1BqYW9wNHQ0Q2pDWEJLTkhtS1A5WFM2OW00RnhK?=
 =?utf-8?B?K09TU3Nwd3RPazJhQ1FFSHhqT21HdHM3RnpTVTNtYjlWNEVzWXVWS2NYK3VO?=
 =?utf-8?B?MUZkeVRqY1NhdEozdGxDU3hxUnpVa00rdWhYY1dYclQrTFJxdllsbDlLQkN6?=
 =?utf-8?B?eVNySUhhVmRYWnNCMnFocHN1VC9vaFY5SjRPYkpReUVzNFRNVGh4em1lTU85?=
 =?utf-8?B?alpvbmJaZlB4T2MzYk5wZ3U5SG52UzhrdTRIK3FiSEIyRmNTQWhUdTNOYWxN?=
 =?utf-8?B?bjBwaXVWUkpqNllhSlh5bGlGdmxGZVhIcGh5VytPeFk0V1RKQlEvcjJNTzZ1?=
 =?utf-8?B?TnFNZzJtL0NnSzU3bjRPcVo3YTluYkhzNkVmQlludGtTdmRFbmwzeGdZU1Zr?=
 =?utf-8?B?ZGJHWi9RZzRod0JxZTEyZmZtaXVxaDZOWEJMUkxtWnFac2dNcTZNUms4L0Zm?=
 =?utf-8?B?K1lSZVNuNUlMUXBPZ21QL3NacldoSk9CY3pucHBUNkRsSXR2UGZ2NGJZMWdV?=
 =?utf-8?B?UFJ4TWNKMk9GVDFPei80M0J2MFc1bm1OSnJlWStRbjVyQXhsWjI4YkxoK3ls?=
 =?utf-8?B?OTZmSVZKRTQ4YVZ1VVg4YmxhK1B5VUN3WENsS0psUXhQNE9iTEk0NFZYbnVU?=
 =?utf-8?B?MHJWQTVDZXlrcENsd3VqUk04c1RGOGJRYkRST2RHVXlhR3lld2c1YTZ2SHZX?=
 =?utf-8?B?WGhybEx6T21TR3Y2SC9jNFN2dEh4ZVFaK1NuRndPTW5zU2hUM0krOG8rVVNK?=
 =?utf-8?B?WGNlczBUaCtMbEtvNWhNMFZaaDIwK3BXK08zd1Rpa01LWWJUODEvVmk4TTJu?=
 =?utf-8?B?UEpFUXRTdHpaZHN6eDV5SnhTem5wTHlpS1RON3FTQVJOUjZyclV2QmN5Tml6?=
 =?utf-8?B?K3FjU1NqRlVkMGZ6MnMzS2xmM3NER3dGOWR1c0diZ1EyNjRETlhtNjE2YXhZ?=
 =?utf-8?B?ZVJCWlFjaTNnd3M2cFhnTmM3eTJtSkR5MjVlcFg0K2RCYVp6R1VVT0MyblZp?=
 =?utf-8?B?aEZLVEJvNEpqUlRBb2hFSm9paHN0VWZjSmVLOVB2QXdOQ2lmSlEvaW9LRG5H?=
 =?utf-8?B?YWQvRFpVU09HSVZaVGc0T3o4YTJOVzNpUzh6Z2NOQktQR1VuVTVWSzFmWGFx?=
 =?utf-8?B?N0k4MnlETWdPUkFIaXNCOWFhZnFQdHBqeCtjMzJUOGI0ejJmTkNSY3doMW9J?=
 =?utf-8?B?K2w1LzRGY1R4SWdTK0laNVFLdU5mN3hhd295RTRFVm9kMlVHRURUMzZyVmxO?=
 =?utf-8?B?cW5WaWVEakpuVlBGWWdpdU15MGdUZkh4ZmtKZHlTM1dLdGs5azgyZUpKOUJq?=
 =?utf-8?B?aGQrRGtEdFZMenpHTXc1VFVQYVdmSm1ESFNJVWoxOEcreEVrQWcwVVd1MFZS?=
 =?utf-8?B?NVZXT1VXUVYxWVM3UHNNL2tyZWFlOXIxZjNraFNZVTRwSVlGRVN0UHRscEsr?=
 =?utf-8?B?R2xGQlV6QU04VkJmWlVQb1RwMDkyalNmWDBkSkxZeWo0ODUwZ3VjZ1pJWjI1?=
 =?utf-8?B?SW9BV1ZyalpXdTcyWFBEd3l5NHNhbmkxZ3VGNit6QUFzdWJnWFpUeVVxZ2ph?=
 =?utf-8?B?S1ZqSlp3ZDVSbm9LSStGZ2JpQXN0T2QybzZyMXNqRXZjcTNnVmc2ZzE0VmlJ?=
 =?utf-8?B?Sm5HankzYVNIMm5TVnBGYjl5alFnL0VteGVacGdrWk5vZVk5dEpucGFydXZB?=
 =?utf-8?B?RUpMUjlBWVBZVzF4RzFDRi8rbFBpcHJuV3IrYTk5Z0JzNnRYcVNJMTBESC9D?=
 =?utf-8?B?cE16RUpVczY3Qis4b1pva3VtNVhNbWlNazF2WHFzN3grblAweTVHNnBqSmdP?=
 =?utf-8?B?K2FLUmpZZmhEYitnLys3eFhycngvR1FtYk1zdW1oRWI4N0FjV2xFYVpPQ3pB?=
 =?utf-8?Q?pXdkOw+o4oquQLf/p+2905J76?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef6496d-01b9-4c37-44e4-08dcaa0a7448
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 04:55:05.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iT00UfuvfMehJorHpuL1SSTxXZowAxsNir75zN8ZFou8G7ZaTlq36qOdw48qZmDoqicguXtuSBsy5TBkZCwH0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10441

Documents i.MX SoC's Service layer and C_DEV driver for selected SoC(s)
that contains the NXP hardware IP(s) for Secure Enclaves(se) like:
- NXP EdgeLock Enclave on i.MX93 & i.MX8ULP

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../driver-api/firmware/other_interfaces.rst       | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 06ac89adaafb..a3a95b54a174 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -49,3 +49,124 @@ of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: drivers/firmware/stratix10-svc.c
    :export:
+
+NXP Secure Enclave Firmware Interface
+=====================================
+
+Introduction
+------------
+The NXP's i.MX HW IP like EdgeLock Enclave, V2X etc., creates an embedded secure
+enclave within the SoC boundary to enable features like
+ - Hardware Security Module (HSM)
+ - Security Hardware Extension (SHE)
+ - Vehicular to Anything (V2X)
+
+Each of the above feature is enabled through dedicated NXP H/W IP on the SoC.
+On a single SoC, multiple hardware IP (or can say more than one secure enclave)
+can exist.
+
+NXP SoCs enabled with the such secure enclaves(SEs) IPs are:
+i.MX93, i.MX8ULP
+
+To communicate with one or more co-existing SE(s) on SoC, there is/are dedicated
+messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
+MUs, dedicated to itself. None of the MU is shared between two SEs.
+Communication of the MU is realized using the Linux mailbox driver.
+
+NXP Secure Enclave(SE) Interface
+--------------------------------
+Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
+multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
+that is/are dedicated to a particular SE will be enumerated and provisioned using the
+single compatible node("fsl,imx95-se").
+
+Each 'se-if' comprise of twp layers:
+- (C_DEV Layer) User-Space software-access interface.
+- (Service Layer) OS-level software-access interface.
+
+   +--------------------------------------------+
+   |            Character Device(C_DEV)         |
+   |                                            |
+   |   +---------+ +---------+     +---------+  |
+   |   | misc #1 | | misc #2 | ... | misc #n |  |
+   |   |  dev    | |  dev    |     | dev     |  |
+   |   +---------+ +---------+     +---------+  |
+   |        +-------------------------+         |
+   |        | Misc. Dev Synchr. Logic |         |
+   |        +-------------------------+         |
+   |                                            |
+   +--------------------------------------------+
+
+   +--------------------------------------------+
+   |               Service Layer                |
+   |                                            |
+   |      +-----------------------------+       |
+   |      | Message Serialization Logic |       |
+   |      +-----------------------------+       |
+   |          +---------------+                 |
+   |          |  imx-mailbox  |                 |
+   |          |   mailbox.c   |                 |
+   |          +---------------+                 |
+   |                                            |
+   +--------------------------------------------+
+
+- service layer:
+  This layer is responsible for ensuring the communication protocol that is defined
+  for communication with firmware.
+
+  FW Communication protocol ensures two things:
+  - Serializing the messages to be sent over an MU.
+
+  - FW can handle one command message at a time.
+
+- c_dev:
+  This layer offers character device contexts, created as '/dev/<se>_mux_chx'.
+  Using these multiple device contexts that are getting multiplexed over a single MU,
+  userspace application(s) can call fops like write/read to send the command message,
+  and read back the command response message to/from Firmware.
+  fops like read & write use the above defined service layer API(s) to communicate with
+  Firmware.
+
+  Misc-device(/dev/<se>_mux_chn) synchronization protocol:
+
+                                Non-Secure               +   Secure
+                                                         |
+                                                         |
+                  +---------+      +-------------+       |
+                  | se_fw.c +<---->+imx-mailbox.c|       |
+                  |         |      |  mailbox.c  +<-->+------+    +------+
+                  +---+-----+      +-------------+    | MU X +<-->+ ELE |
+                      |                               +------+    +------+
+                      +----------------+                 |
+                      |                |                 |
+                      v                v                 |
+                  logical           logical              |
+                  receiver          waiter               |
+                     +                 +                 |
+                     |                 |                 |
+                     |                 |                 |
+                     |            +----+------+          |
+                     |            |           |          |
+                     |            |           |          |
+              device_ctx     device_ctx     device_ctx   |
+                                                         |
+                User 0        User 1       User Y        |
+                +------+      +------+     +------+      |
+                |misc.c|      |misc.c|     |misc.c|      |
+ kernel space   +------+      +------+     +------+      |
+                                                         |
+ +------------------------------------------------------ |
+                    |             |           |          |
+ userspace     /dev/ele_muXch0    |           |          |
+                          /dev/ele_muXch1     |          |
+                                        /dev/ele_muXchY  |
+                                                         |
+
+When a user sends a command to the firmware, it registers its device_ctx
+as waiter of a response from firmware.
+
+Enclave's Firmware owns the storage management, over Linux filesystem.
+For this c_dev provisions a dedicated slave device called "receiver".
+
+.. kernel-doc:: drivers/firmware/imx/se_fw.c
+   :export:

-- 
2.34.1


