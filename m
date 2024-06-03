Return-Path: <linux-kernel+bounces-198669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AC08D7BDC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FCC280FCE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3122E83F;
	Mon,  3 Jun 2024 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lbU+kX9k"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5794A0C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397474; cv=fail; b=qtEg/FDHvV1DtWmPJHhfmWWN7I7430GTJIZFXp7VSOEsdg3e7bOHrycHB1+VoIMZ8/gZ0HzXSpk2PWzv/cHTfAAUKvH9nDSc6dKKzbgFo2PZ0Qn6ua3/zptDe0qX7XBq6pmvw/Hzi+mViZ0Ys9Gq0n3AVMEw9izWw71PR9t9DsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397474; c=relaxed/simple;
	bh=IMLeaSVGzxlrPy6pLHbU6FAWljTDAhorNEHd0/dR4rE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HplTJCALXfUI+DX838exk6GLDH+p5sZ4QUb9JUBL6y+ELyr5yXa+PKmuLGxGsFeJCR9ci9kqbeglj1ZT21OpCwWLOjMO5EavVMy5hDEdTgSSGIigNtuDTFQLF/Q90bgfzMTo0o0sn8yzpZiQNL9sAuxWfKWfSraHJytNEMfDlxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lbU+kX9k; arc=fail smtp.client-ip=40.107.8.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6oeQ95CvJwuIqq8bjzJrX0rbfZuv0+O9VSak5kD7qhP8M1QCEHTGy/uMzcv18INbEycQxqG08J8+BGooIQ+QUl5jqe90cR99sOmlZAauiTWqilO/e1JvolSAgkJQA4UEArXRU3qQOodbHTleZveg/Pz17MUwXW0BW69NehJrSag+XiFmIgnNgY/zdCXz7FThFgj3zvWP+dYgzOzaALpoHZy/ZJbCqNSlvDkBWatz4HaKdIFuE8Kg6FHOtDzpuwTCYmGdWPtEQkq3HTUGM+5zCDs2Ttk0tDeV8YZmmaJH2yyFCS8vR8jBNI2opYJA5g1n5xBcx4d2c9ngw85ot/y3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPmT+/2+DWraD4gM0JgxS7uTJRJmd3icIGiJAhoHm1c=;
 b=JvdYgCrDSbNw5JAduB5+N5flvaX/nqo1fha08qRvfWb5OHFEfNjJQmLmQTSR4Oabf73jI5+z9PQF+x/d66Jbou4ugiDCin0kn6OpApMQvVo03iwgCTcvJib+XLE/CAJzYbkgJYfjcmio9oM6RQh5a4UNiD6cT1NdPGeKE8jBJFCnDe6qNsquzZrbCnV1ZlcmmmNrlnN/LxnEW+i9AwGXY/DLLSQW8wLuY1MLxpxdb6CFDcK67FGRNDNFR9I1Jk1qse+3GoxXwrzVL1lE+RfCPyntyQnPv8h7y8LfeLvc0oyRrjMEEzfjIOkWjg2+1I7rKOHKM7lFxK6YWDcI2YNIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPmT+/2+DWraD4gM0JgxS7uTJRJmd3icIGiJAhoHm1c=;
 b=lbU+kX9k1nlAHr3x6GfA+IIQyTRr7AsZEzcKo2PFFHLo7RUf/G8k7JLuX2FIMZAlPMwiOCZghrkgqBWTG7SSpGXM4PdfOlWVGp9UKfuWJDi56R5NmEnXoRzpP6Gtw21G+O9JcqKN5vAYtDy4Y0nYKkINvUB5Ga2FhCPCsB2juJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI2PR04MB10191.eurprd04.prod.outlook.com (2603:10a6:800:22c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 06:51:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 06:51:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: srinivas.kandagatla@linaro.org,
	shawnguo@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	aisheng.dong@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] nvmem: kconfig: set i.MX OCOTP default y
Date: Mon,  3 Jun 2024 15:00:06 +0800
Message-Id: <20240603070007.2413599-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI2PR04MB10191:EE_
X-MS-Office365-Filtering-Correlation-Id: 316f9ade-8300-4b54-a1a1-08dc83998bcd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Jp0r056qZaWW8J1IkPQ62qwzl/LLvwtTWmqA3JqZX7cZv/5fABcFUecwnhy?=
 =?us-ascii?Q?lLYTgWOzLP0OrV7owh9FLZugPnfGWGVDxpFx998c7nyy4rC2dlqrGVlYsqs9?=
 =?us-ascii?Q?KjzMbhNh5xcB2+u6naMGYyUVcl/ZrfJ3Pc4M7pWv1ECrKxaF/QZtTuiwIq6I?=
 =?us-ascii?Q?i4zNl7nzQ5NqIRQdRrZ+IP2iZvXd/1JCCSeRhOwCe21D4AFmuiirr4lKVM8r?=
 =?us-ascii?Q?FJ2J4/df8/tZOhjhRp1X+7d9lIvJ2wDBFqBnX8/Cbg9vxivHnmofNXVVZeWd?=
 =?us-ascii?Q?d59yJ7UQgMcm2aTyxyz1uESqfTJFpdJAxKnshriKLAGwc6zY1lBCdxbEFT2j?=
 =?us-ascii?Q?CW6iC08h9nVdNIDoFGRWxh5SLAhPKutO8nYSiOuRMbdS4gR00nXRWuG0mR49?=
 =?us-ascii?Q?6snuwqpnHZjfzVYicLW6ZkrJU8YHYxfI/TMkNWnAgyRu7mD+E1fkcHbJeSe9?=
 =?us-ascii?Q?2djOcjlDTOaKdBBmMWqdsyHni0X1GLVFavvmBB1U9cEMlykDDmxZujJ2IPlM?=
 =?us-ascii?Q?vzsBBHwq9LEQXOfd6hA45Nj2IuxGq4RI6P66tcWCjqd764BuAOb1ZgBrOhB+?=
 =?us-ascii?Q?CjaY9FsJuvpPGysSlPQ9yNi/FJ84S7OBSe2oECYfUF7Wy+w8bbKYR6321mYe?=
 =?us-ascii?Q?RgA06hhSBGGGycvREInzrwZu+mTbI9bMQvJj018krIfezmN/RP7Vjj8Re6uS?=
 =?us-ascii?Q?uh+bWmzVdUrLBxNJLhYewKh0qK6ZQYoFxzwg7tM8OGjq70BK6vPQ1+pe+kbt?=
 =?us-ascii?Q?KQI/jGS8NtMs5f6Ns7QFx5IODcmsoqxNg4fmbBwMJTvH/Fp/RKFIeau3Jp8T?=
 =?us-ascii?Q?lBFAiNYqXiuHvL8V1zswCIm91DmlCYpYbw4m4RoN6m16zCDziRm/2BvOGA+t?=
 =?us-ascii?Q?CL/vsgBU2gQJjkEQrexDOsVuIiE46504yLtgdyAlhBH7lWCOsak2KoyrwXvx?=
 =?us-ascii?Q?vLBhjAIPCWDTp586J0OV4swNSjiE72dkHX/mu9Y1vVT3JValgxdb52A8m4ao?=
 =?us-ascii?Q?venMnqKgFM7pdE2GR1EOtAyirMVeW+v037n0Z33oLNLhOEAuXp94A3HOs6qB?=
 =?us-ascii?Q?8haX5e6cjjjlRMWHdnC80oBtch37X9ZCqDQEIIB0k5bYXVHOv1Sv/mc6yjFC?=
 =?us-ascii?Q?eiY2PHX0QSJN+R5z4nm8IIAdAAjFevnCZ7Woz9cboStSvgu4lE/HiTqP1YlM?=
 =?us-ascii?Q?17o+QFuwRDYiCWc3KtaNw1x/iRr5sCHgByFeguqfm8FRLXAOt4CEfkhSjmn0?=
 =?us-ascii?Q?SFnzLHFhYKBezPSE44v4VuT0cV8EmxW1uXmJR31YgFzlFpzoUOvwlFcgaERF?=
 =?us-ascii?Q?6sdosHDapoxly9utrm/hv79kAxtYGpX5R409QmARbeOZ9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nenhar041HTsb4gUjP+GTfU4Vu6pYLkFdf7hq821ZSpxIhNc95PxGLveCz7X?=
 =?us-ascii?Q?2Iz1t4tH6rhQuHLPVXg0BtDeR9OuP4QkVgdLGSFBw3eOVY9ErJwTtBa4xeUH?=
 =?us-ascii?Q?4GF7qPtJ1TCustvMBkSi2sxzTL/FwW8mMA2jGitO9HF1Qx1Zf1x+BBbIYyP3?=
 =?us-ascii?Q?Iz+0NkwPmO5AvyaqFQYa+gHEXjD8RkU4WyWt6oT7gWS1GdXstOAKfE1Sf+XX?=
 =?us-ascii?Q?HxNyZnzJaaiefXpWSsJTTHva6Wx2OnLGk1qgF5yzxgMVTil/pnN57gBfVbam?=
 =?us-ascii?Q?gSsoQs2emXYuvRfE9jD+KUgZcTj2b9m9WQGNLMTpWcsyoH6RULobTbMkOCVO?=
 =?us-ascii?Q?v891lT7mDg5KsOO+qfOaM9PT4jb2LZis8s7tEROLsawSFMeQ7G/4b+J8j7p/?=
 =?us-ascii?Q?6CQ/LsBKItAea6a/d4ZxtfdWfEXV7ZMK5rsYLA6dZMbBeU8B1rfQtSqTCKtL?=
 =?us-ascii?Q?beUZnG/9ZXxLSM4BfXwfNjbIsCcZBqhNZB7O89AvNhF92kF/llj4hPSwi8Oh?=
 =?us-ascii?Q?bH1FkGHAybdb7tWJWDG02QyAqEpRNYGM1DdpfoIDwcAmXlpz2dqhh5V8GbsI?=
 =?us-ascii?Q?jt+VdOv80MOt2OnVC//ISQ/CYiBwFYzNtQD1HXdvihv1dNquFPaEEUE1uu8J?=
 =?us-ascii?Q?TVihgfIozYeOfWZZFGoGP9fqzMmeq2CMjGbD2KHj98GsNrwRWN6pxpW0b7Gt?=
 =?us-ascii?Q?91UjZ386LcwEAzStKgKtAvXuICbcr5KRSlYOholgzrTKjSF6o3uTOYJFevoj?=
 =?us-ascii?Q?2JMEBKk86iPxwSf/LEN/6KG+lFVNNjf9zMciuCWX8fL/ummxT9XjY5ze6ilL?=
 =?us-ascii?Q?ik4SD12mnAEy/2r8cwbPRqBGWZlYAu35lC8OGwJ9iaFLcI4MZvkGQ92or2H5?=
 =?us-ascii?Q?p20UJ3ehivrzjKN8BcSu92/JYsgyK+bsBPQ+3tCnudGpB1qX1JvY2ar/vJuV?=
 =?us-ascii?Q?rdJE8zgQR6zDUseVcpiNwrJfzDeJe5jUiPDbECxZi+Oh1BkcpYz7GFq4km3Y?=
 =?us-ascii?Q?3JLRuqPi/EuwLg5goBaeCP0eB8z9r1UKNpw38g9aFmlqDrOz6KapXUENCVlj?=
 =?us-ascii?Q?UB7mFkiMsLfOB0N0Okn0Rdeg6ELQe+YNS0clJt3nsHgHKbTrSLZ7YVi+K9qA?=
 =?us-ascii?Q?TYjUlQAtRExrZtBctAGwX4TQcSPvBZHOy+OWyUmnrA8j3RdETw8GSKnB28Uc?=
 =?us-ascii?Q?38uoQH3OrbbxYnM6wx9HJQ8wufEau5QuFEOTmhxdXrmBAS2KPtt8R5ihSK7n?=
 =?us-ascii?Q?y1XRxDW6444wZ3bM5G9LB2+qAVxF6leGRBuEe7poh5nhukrt5rqlHov+MUZk?=
 =?us-ascii?Q?Tjdv3qwNgSii1Hga6B9OyFyZjSK6N3/rRGob7nxgquexQ9wu5A1KLMbSqVEx?=
 =?us-ascii?Q?XNxCPa8WO7ZcYSCCbzVJLPlTJ8SDtZJfoVjQLWCeNQzP5kDWj2xVoACVPd0s?=
 =?us-ascii?Q?4cBq655xwOh4bYfyCgJdZX5ECLy68OikLkotGeSkX4dhZyL3YuZCSFVth1+r?=
 =?us-ascii?Q?s3nu+19r0cNmnN+Fn3ZlW53yhwQtd3Mwb6Ygs0rQmmd079IoP2LEqKAXs3ZH?=
 =?us-ascii?Q?FavtOs1Ex+Ss91YuoOFNezoIahaB3+utrcfpbCzk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316f9ade-8300-4b54-a1a1-08dc83998bcd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 06:51:08.5845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRcwVYrPGHzFx+WRThCHt6UppOthRrqCz/B99l+qHuxU+6/6uGBRqsGUKN7gqp0NDRu1x6w1ieWA7t7E3aGsNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10191

From: Peng Fan <peng.fan@nxp.com>

If ARCH_MXC is selected, set NVMEM_IMX_OCOTP[*] default y which will make
nfs rootfs work since i.MX network driver needs read mac address from
fuse.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvmem/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 283134498fbc..7e92e855eb50 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -76,6 +76,7 @@ config NVMEM_IMX_OCOTP
 	tristate "i.MX 6/7/8 On-Chip OTP Controller support"
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on HAS_IOMEM
+	default y if ARCH_MXC
 	help
 	  This is a driver for the On-Chip OTP Controller (OCOTP) available on
 	  i.MX6 SoCs, providing access to 4 Kbits of one-time programmable
@@ -89,6 +90,7 @@ config NVMEM_IMX_OCOTP_ELE
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on OF
+	default y if ARCH_MXC
 	help
 	  This is a driver for the On-Chip OTP Controller (OCOTP)
 	  available on i.MX SoCs which has ELE.
@@ -97,6 +99,7 @@ config NVMEM_IMX_OCOTP_SCU
 	tristate "i.MX8 SCU On-Chip OTP Controller support"
 	depends on IMX_SCU
 	depends on HAVE_ARM_SMCCC
+	default y if ARCH_MXC
 	help
 	  This is a driver for the SCU On-Chip OTP Controller (OCOTP)
 	  available on i.MX8 SoCs.
-- 
2.37.1


