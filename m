Return-Path: <linux-kernel+bounces-247290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A4892CDA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F19E1F22BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE23D17D896;
	Wed, 10 Jul 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r7m1aSiw"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013005.outbound.protection.outlook.com [52.101.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC49916F0C5;
	Wed, 10 Jul 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601798; cv=fail; b=lhUwQTf1Z4gbCwQgErLdTt9hAbPmUuilmBXj6hSuwf48l9IKrcqG4Qp/5ueCS+6r19fgliuS9gGy39qYkj5+7Mvhp/kmZo47skzaflZ4yggGp5JMHb9NxbTqaeN+43KPJrA3M1o3IhrA3T6up3lzm25kl7HuP3L9AKdY/PjfY6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601798; c=relaxed/simple;
	bh=WepyS6WmmPHHW7E4H5OOX+ed3kiq6dGXZLCM/ZFJ01k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eIlFzkiEoPPHXNPvwxDbaHy66IFSfemO6EGf4v9x30gEqh7T3eNZike4O5h9OxI3f3tTYM8+hBIH0IlPcTssn45PQ7XlxXyPUe44DaQ5i41sH4EhpnUHzGUM0kWsp2N6CRrQuZcwjN4a9LXctkPvb6CZLsWEyDlo20hG3NfcpMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=r7m1aSiw; arc=fail smtp.client-ip=52.101.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjAUQYTCjReVzk2A7KxL9rp0vGFroRDfyh6+FDoN0fyyx8oYrLxNXjPto5dlxkEy9yvL/HZEZvmfVbTkhUsYplqLK7xaS/cwANnJQN5XnqzYUmQ2ZOnUfkTfRf7bC6Bqf01gWFEGcKnUGPXdCJbqtlU7xOrwGsrdOnpNcuAQlfLgr0e8Iychgx9u9sggm7/a0TZj7OrvYvAQbUlVJceO5eS4SGlHFtdy35bWvf6S4dtRtbAOxs8zaEFG3spjV4GhfKCcc02Y2ldW0ybn2t/iG4rCKvcEqZLNjsHGuwTffjIdr8yJqMSNGz9kE9P36IwtRbDzhBSbubEJwD8TCxcYWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOCuKesYpa1/nhz4pE18D5X77QYhMG6xFiwZQmM8s1M=;
 b=Jit9Lexp/U5MUV+FD2r0Qdgg+C6yGUkivHtR0w4izwjKs/DsXDO24McPCqYTgxnYaTX4UxlcGCRHluokr9I8+cu5sKb+8bJ+Z+ZLgJa3xFK5VlsGNSTciHJNjSj1LDtkPfxyLk6kZCBBHTnzec5bbrYDFy1v3jUHsbnuBXaoE+wlftgfA64o8UUmch8673CvWnZ+GYZT7pGVFRk3/LCjN8wngwLynuIHSa8iBXIpxSbFqjog+6wd4b/5+SfD9JV2ANrg8Xdv9yZRuW+MVvQZoqUPxmGVjZVtxiXVfHQTHmJ9f3N92/Lu2HZuaWdwPk02wjM+d37I+2kUcHRwh7hEfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOCuKesYpa1/nhz4pE18D5X77QYhMG6xFiwZQmM8s1M=;
 b=r7m1aSiwX+LVfTP8y0o8zTHvplzWWm71lyy58Zg8HxLQ2Lin3FE6S8qYsDc0dOv/VJJyC9CCKgke8AUtbekjC//ThmfKvqNmp/BeHZjPI7/8yd0TXdwJpkBIDgzEaO108LMdfhBMzd0+r0FZ4dlo199llWW84wgFbngId1kW+fQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10091.eurprd04.prod.outlook.com (2603:10a6:800:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 08:56:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:56:33 +0000
From: Wei Fang <wei.fang@nxp.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	abelvesa@kernel.org,
	peng.fan@nxp.com
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] add NETCMIX block control support on i.MX95
Date: Wed, 10 Jul 2024 16:43:41 +0800
Message-Id: <20240710084345.2016687-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB10091:EE_
X-MS-Office365-Filtering-Correlation-Id: f6de3a21-8420-47d9-06b0-08dca0be328e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L6caOrXFxlNKuZt7Q1MVO/YPSeHsdbj6diBmsHgoA+kWepISOaGMZBmlRndX?=
 =?us-ascii?Q?Aalh3eBhiEG0YD80SM6zqaS4w5USTz/FS9izBGCZgr0k6v8tbQPtfoWu1ZP0?=
 =?us-ascii?Q?aeNdIYUkfiwoqgXHPsatvU+9URp5yKjKpYmb9hI4Mqg4WwjUDLN/ZUlp3Yff?=
 =?us-ascii?Q?MbrfiHNkQcG6Tmanw680EeWOwbMkrzv9STtsnlBBiAkZar3XdQB9JbvcCoh8?=
 =?us-ascii?Q?/jl/0VjYZxLMgBOTFwdELoyzmn2uw/OdsOLZGIAJinFeM6uX4FpW/HPsA3ZB?=
 =?us-ascii?Q?WJQOkoVgAdbV3ROKI9IHGcMsTSFdx8hSyIt39CfkGxhcD0rTjLxh752fqY2g?=
 =?us-ascii?Q?U+6x1hn77Md0dJv2h+UCW7/SbMeZTpr5rZJZ0ek9oI8m3mozPCPuFbkgzROW?=
 =?us-ascii?Q?UzJRzhkn7FCapFYFvFe5mJmyQ02XSMlcSHXEDP5vMfIvs/9zP40UVgQ/h50y?=
 =?us-ascii?Q?ytJti2MrSH07jhzfdXq6gTiDwWoJie6kf35V8JPNVwRHByJGiAy7p8dCa1jj?=
 =?us-ascii?Q?4g/NxoIFx9HkTrW6TsobzyQ0NPv/7ouPBSQdTKVeaAVpEl9clo1p5jMghYND?=
 =?us-ascii?Q?bilHOAeyqGCoaPrLkj1E4tkExnGKPVqVMcsbjv/GqPHJxp6W+wtaBSUcejMo?=
 =?us-ascii?Q?A6wcjaoAAjQ5+SPOANNW5LWfJhpVSz19KIM0slY8Iii3Mvwkl/cHtgxpEMkZ?=
 =?us-ascii?Q?rzoBPva2uNcs8h5uLwmlvmMvczz/bvsZ6N4ReN+4qd1aQ//3tyX24jzbECE8?=
 =?us-ascii?Q?wXTgvqm2McLvA7U/ZIMKsgtZBzMYEyS784aB6+iD1wZz/Po7fFG3AXu4GzbP?=
 =?us-ascii?Q?RShqrKieBU+bojwFVk3tUeSCyGMUk5WLBy/1uuJ+9fUUK59qEQ4ouxCQMOX8?=
 =?us-ascii?Q?Ja+o7KXFphaDBKguYeZGj+c7AGV1mq7FC3cXqtnH8U3485WDcHsHvau7Zpft?=
 =?us-ascii?Q?y8+1OKX4izojKtH7cf/u4lcsaWHk6u56opPaNDoY0xtjmiSaER6yZdH+6r0H?=
 =?us-ascii?Q?vfHjvls4cN11XALru7xcaTLuTLgO7w1AWYE5f0t9ZFhLADVXsErPinLD5m6H?=
 =?us-ascii?Q?vFjfiJQlQB+d6582zBOrOGlt3im/V6YKtDRlFPzpbz2JgMNjcLv6AWaO6wpG?=
 =?us-ascii?Q?9qzOAdzBP+hSf8eHmjwcrbJWuuqiRVpM8jA8ro454GO2Rqlqfw0FRawMBnY/?=
 =?us-ascii?Q?R9kTowRaxje4LkmcG7nzAeuRzqKZoVgMI6L6byCXkBVuXL5adhfeGBYLSHrH?=
 =?us-ascii?Q?Kvf87ufLBnMPaLs6yrlfxfJj7DRJlm0OSxlBvZWXEbUPrTrKxaH2Lt26ltZW?=
 =?us-ascii?Q?++y6sYG8VpAMUJlooonbbH1515xCL+EujR5NvXw4Ez4y6I/sKIZLIv4Y4VmZ?=
 =?us-ascii?Q?/kbErGk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mgFyLdUmqZbxaC9XeKwsimCjJGQVgWjKc+58d4gxzrG9WIy7+cXbBM/EynoD?=
 =?us-ascii?Q?QsrmEQNUVfz3pMzgeqIqkRJ2DIRXXne6k+qUALwA1EvcNir9aiAcbAi+xDg2?=
 =?us-ascii?Q?SxO0vzw485Pdn+T6uOZFzP19aVG3evJ0T+S4p/9GNJGCmMZ8KXjwVj+Bg/Vq?=
 =?us-ascii?Q?vxtSRc/oC1B2xVjPg2M1ncFyyDcz4JUC9MeXr+RMg0laBoVG+EtKnu3dtxSC?=
 =?us-ascii?Q?T2bTippME0ZkFGd+KTZ7otZE2bkBOs0Q20lsk2MQe8uuec59uu5cj8WUhKDp?=
 =?us-ascii?Q?NdvayRYP5pdYnUqf7sPCfkTUg5VLXaXjXhQc9Z4+eUukUL1JUkMF/Cc14n26?=
 =?us-ascii?Q?fr+XkVTAz2Gjlj88H8eZyDTWnBd7EnpGE7BYn28b7P63c1/szsrEGLUfaXqh?=
 =?us-ascii?Q?e8Ne5j6fQnI4sEWxMokqygwjPUf2RDsltaNXPrMKu9ey7HNH/Zf53IJeq+yl?=
 =?us-ascii?Q?O/mte/ObO9g0aURfyK360kzKms7DyTHZbjZtqIER4VNFOE+2wK6pjRvPVZ+R?=
 =?us-ascii?Q?6M7eUoiD74IHjvdDg5dHMqJfS/ItIsHFiG2sRG60VVWqS1/ZU4g+j6A5isCw?=
 =?us-ascii?Q?qBGhPPrP9nMofdp1O0DQfn3sEDqMfsEaKJQairV+z/bn1/nIYEVIzJ3mUT9Y?=
 =?us-ascii?Q?p8JW8CjgmN96hnLuM6VYe1O8Ffg4wtwSmwpYx28wiyR5wA4w0M1A8Q9jsdu0?=
 =?us-ascii?Q?uHQthtDc+yIYHpBzv0vQvkLf45ISKJjePBQEStzdsVg76JtvqXP7fjXMuM2h?=
 =?us-ascii?Q?0ehunuPSet0hsfQNpTUv9MWZub3KHkyRRPSb6h9C/f3fFS29czu1LVgZ3Pee?=
 =?us-ascii?Q?roI6YxIuWgj6aIZ5RKe+oNUYlaKcSrDZu6h1FWWZeVX0Em+e93R5gdGP9wTI?=
 =?us-ascii?Q?JjttzYxojHX/DPz3SVsU5KsHF4lgu8WLERkpkyy+CBQpRm+wmm71+ZO4I/EA?=
 =?us-ascii?Q?Vz7b3Cjv1IQinPpngt5cZh24WbJetYIApqp6nlXHAXU0SgxcnDBydGPMvD5t?=
 =?us-ascii?Q?kLQn1+FC1IB7OE3F7C6asfy5AYwEObbLUSNh+OebEuPvLLVcovWjJp6MdIP8?=
 =?us-ascii?Q?yXAmxkKre/SvXnk/ebwpyq7sB/xReB0/Vaunj7vPYjKTTjBKnxckjRKIJ7zd?=
 =?us-ascii?Q?nAFK/aboibtxCm+srsUcCdw79VOucXD36BolQg4/hyQmQDtcR3dHk+C3+F+l?=
 =?us-ascii?Q?jZT6OaZyuxDp05Ou81/LP2z9WNuV+ZXTCBYMhTXKzLW5USH6B96hChtrzFaY?=
 =?us-ascii?Q?yeO1a2Y4c4ctXLcR7PxUqnoUfEGeCpORVREORqVqjju/2UDxmylY+sVF8LZw?=
 =?us-ascii?Q?+lmmJKnpXhQLwWl+KkVAU6WhTMnchV1atochM6iZ3isDyddfdU4dXoxia1sa?=
 =?us-ascii?Q?rBqAwaDEM5iSqGxZY2T2yyK/Dfb8svDK2ANUMFl8ZC0yBg0J8/X+eE+3KZZ5?=
 =?us-ascii?Q?4eN+McUVzTwcJLUgnDeSvoPWKBKl05hCzVrudBi1GD+1EY7ctaZQG6G13Uti?=
 =?us-ascii?Q?c7X4jzI6fScmpdb0c7MESpU7aXFffZADFuMAoml4TxdiI3w5N0piCgfwGQkR?=
 =?us-ascii?Q?EFcPJsMAU/VbwDhTcLKXVNh5DqB4FoIOrcJNy75/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6de3a21-8420-47d9-06b0-08dca0be328e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 08:56:33.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: No7acT53rL7suRviWD3jVrzRAkLJQO1xnIgQDAmgArFtAnqEkxlQZQCxG79T1+YqrdgNk/MktRdOwV66pDkPRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10091

The NETCMIX block control consists of registers for configuration of
peripherals in the NETC domain, such as MQS, SAI and NETC. So add the
NETCMIX block control support on i.MX95 platform.

---
V2:
1. Patch 2 is new patch.
2. Add rmii reference clock mux for ENETC0 and ENETC1 in patch 3.
Link to V1: https://lore.kernel.org/all/20240709073603.1967609-3-wei.fang@nxp.com/
---

Wei Fang (4):
  dt-bindings: clock: add i.MX95 NETCMIX block control
  dt-bindings: clock: add RMII clock selection
  clk: imx95: enable the clock of NETCMIX block control
  arm64: dts: imx95: Add NETCMIX block control support

 .../bindings/clock/nxp,imx95-blk-ctl.yaml     |  1 +
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 12 ++++++++
 drivers/clk/imx/clk-imx95-blk-ctl.c           | 30 +++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h   |  3 ++
 4 files changed, 46 insertions(+)

-- 
2.34.1


