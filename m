Return-Path: <linux-kernel+bounces-421428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B41539D8B45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7D0B32726
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542011B85D1;
	Mon, 25 Nov 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="NTHtikmE"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2098.outbound.protection.outlook.com [40.107.100.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD01D1B4F08
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555032; cv=fail; b=DbOrpn8YyLZVw3mqeIWnUadiGupJySWjKzBBPdelZvAd2toyaUknXa65tvvni7ruGsLOmzM4b4En/0jumoA6UwWTSojMm0gZiTVW0SNCIpnrmzVHGOwuu6DW/IJUdTROPtS4CSRY6wJ7/7dtZJ0VflBdsIhKIU+ajlHpDPSlNPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555032; c=relaxed/simple;
	bh=y1p8JwaMFVdZGOL3eRE3Se/vXHY+7YKxmhV/yjQSnrE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a6/w8Wz8FZtwAXwYL3oHMO+PoqP6/xX+mBzzSw9O8xWESMejOGhvLLtDATBULfPeDLUI/7nfoAexU0sPf7WZ5ZDmw4DvRrzyQdLSy4WhJiB2lGLa9dkZMwwo257eTHL0q2JkZ2RZu1hRKzjZ2o8CVCHGpbtwZULmruVjoUKo9rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=NTHtikmE; arc=fail smtp.client-ip=40.107.100.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwJQi2Zt7VOAW9xJFy/XEI433y0Nb6sr6LhqgtXISYpFrWthWyp0+xAdjc2xE4v5o9kKMViNHk6wG0A519dbRfsA6m/Xgwxy8YC4NFO4OavEC8m+JyS8ZgHx5Yb49wCQ9IE0zVAZTYnjC9Yr1IN5FIHdnQq2jVGujEeGW11Lh1eBvfyIBBvvaNEvu/yPnGMJqrJp4/jtivDhlaH6IiJuq5XoFZgU1rpuXJIICWVQsLM7lQPvAzRc0RK0UmCBaHXy75B+TO7qP/UWka92xSFl++lrGvHgMUlsHa/k3vNOmQwr0UCY1FvqfFoqEfImNTfZJRo/3bEEq8mAQCSta1p2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKGrHXzPjTMtOu8xNtZ4fL4TvJqYyj5I1qgj12mvHz8=;
 b=ihrHu29c//w6h8NaiuZNsC2DM7vO16TcOLdvpJ7O0g6EQou+us8vld2zYZdvPwmmRntqESC3Tl9bPbKZfp45zOv2l37nbk2tEG6d3tRJ2YfgbDavUsQfbbPRihMsfWPH6hFrR+s+alSP9WZal0JbsTsJcqiDbMK5x+RnrjRrml0dg+jQkgd4FmVprcf9DiPU83p/KbCtKgTZYdCyCUP3E+eAxWnQoJg5Db8YCsYyEUOC7sVK9zZ3VRP8DHeAo1U2Wf8qsWx5eTqTdEKPzWCsIR+fHzwDqreRn4x0yRuZUkvyUMp4KX/4GEFu3M/SmZg4s9ggLBplE3NHDVnpqs//NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKGrHXzPjTMtOu8xNtZ4fL4TvJqYyj5I1qgj12mvHz8=;
 b=NTHtikmECyDbTIx4FxxiKpH+k8UJcOMK2SRUAUM52da0TwRfmimj6sE5dTl3P2uTmVJA754Lwq6MwLqnzSEAuVl6yMrO5XRAXvoLFnBkuGDEYzME5YscnbgNGMJ5wTu4FK67OT2KJVG2V7JyjIysjPBCh8Qm6X/GgaYMMvzjUvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6420.prod.exchangelabs.com (2603:10b6:303:70::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12; Mon, 25 Nov 2024 17:17:06 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8207.010; Mon, 25 Nov 2024
 17:17:06 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	baruch@tkos.co.il,
	ptesarik@suse.com,
	hch@lst.de
Cc: yang@os.amperecomputing.com,
	jiangyutang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: fix zone_dma_limit calculation
Date: Mon, 25 Nov 2024 09:16:50 -0800
Message-ID: <20241125171650.77424-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0445.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::27) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 84881333-ab35-4a1e-2a9d-08dd0d74fcad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y0+wf+R7hT0FQclPtKl2taMO6oyDGzhg8V5MNydypCKYqwhGKWexSX6SsbLa?=
 =?us-ascii?Q?NN9w9AN4S4Uo0+uo4+ky93mb/LE178lHXFvume1xRgUgJdRfgGjFfnHF6BZ+?=
 =?us-ascii?Q?Tb1peS9iRpnTQE4urWrurVAtniHhA3pCoNA2LcNFhc9ZjeeNBwDhRLUGM3sF?=
 =?us-ascii?Q?t2/crw1kK5vY5z6NB0zxjpaq4J8f12ThFFhgmS9Uao5h5BR4rabb4L9Ild2e?=
 =?us-ascii?Q?oy47YPddR/7BiDzog7fZ0qVLVtYFQHAlguxcjkjCt4Fdd/Xjt50w37qHHGbT?=
 =?us-ascii?Q?SrgVqs6HlpqgzFkRp2REwqVp0z1ynNmlR02ajE5rSL17zp6y5geVm90H9WaF?=
 =?us-ascii?Q?WfQqda88346ZeGjnwRVtiKur7AYjlHpZfjudRm+hxyTqtdDzSJ3QMLl1mrvB?=
 =?us-ascii?Q?cH/iTsooPZIKGww2TqZOYXBhFZF29aSKGycbv1Wx+GMqRarqNiu0ZKCDnTim?=
 =?us-ascii?Q?5jngjHksG6m3QfNWwpuQqQYUU1tT0D5oaZM6LcIOFUUJXUtwZL+DNbwNYCGs?=
 =?us-ascii?Q?WnQCsxCtpncFGhiEq70KUPHX9UC2BJVRTPuasFXL0vfaZeNSOFm2gxYTyT72?=
 =?us-ascii?Q?Myk0/Znt8RjQKmOFhxyhJCPwYHEiRFwQX0q4n/bIbJ7E3sHv6rdDIt/Nz3G6?=
 =?us-ascii?Q?kspIq2vmCQJ6vmDlmQE/o7fo0/8ltWYn8VFjKiac3k8Zc09LmaVYcVTFGcJZ?=
 =?us-ascii?Q?zkeOI7PCxxjcURVBPIeWsb6DLnp6g6WXyIJJ1hVhEMK2jnDsLuhOKHmJIsYi?=
 =?us-ascii?Q?SpbSZmr6CGQc209P5zZOADPjFXgzKamMJW5Rfpvr3GHzievxau7rLPCP0EB4?=
 =?us-ascii?Q?C3I7LErbyl90B/ovkjRQLGDZgW7K6R9kaI7jxXYHhru7pTaWhxXSg+k67vNW?=
 =?us-ascii?Q?YJk6HhiNDL6wTyze3v8iaPFxKPTmPTOUGffPdXtyCHn+ZeXDqqlkp2T03Hkr?=
 =?us-ascii?Q?xUYT0DkqCiCLLP3ZbPOZyl1UHDpwRoRVlNIE8V2EQOgadRCSiXET4yELww1q?=
 =?us-ascii?Q?LAu8z/uWACAZaGUwyrWZlVQttdyx45CCHCPfc80G0JzyfbepgDvjxAA11vmB?=
 =?us-ascii?Q?JZkmD9LJAqEPTt4Q0rCwRD7hgrPVionTpcH0z4Uqto/5oCOY1mJWeNWbEx/B?=
 =?us-ascii?Q?EI4gOigYFJ3RPapOy3uEL3+A9GSIvHwqi/vs1ArL8gmsSAAX6Xaow1JOWcDQ?=
 =?us-ascii?Q?4ijf7b0qr2bPggCNqwS4Pvuam2CUwCvzErirleAEfU7ybjvUZhsiZFHGDskr?=
 =?us-ascii?Q?UFW5c5GEWWl/bnBIQ6bF6V3+qkR+iHD54yXyl3EN0gxTETGsZioYJaS6eZ7K?=
 =?us-ascii?Q?M4dxOvfSqZMlv9tZT7AodH3JlHo19vVf98hjUlSVF6m2ntlMxcDac9yJnGJE?=
 =?us-ascii?Q?Wa9r4sWVz91juvc3Je+Y9RunpG3gtpYDrukxvJ9sXxGYuGKenA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AsAkfE5pyvwzKxA79AFec1hfcc3w9HOwmWfFfFjQZnmZGP8Pcdw1YAAlPga9?=
 =?us-ascii?Q?EyUNcKptbOClr7IJmLGs8tU1cBCKToHfQSGczykoaFAo7T0N4HKl+zwAZBoo?=
 =?us-ascii?Q?iZgscL91iFmaU58CuZQV42oUs9dlYK09JtrdnyjXQ5di6ZGpFKtF/fK3JzRf?=
 =?us-ascii?Q?XtaRkFcQ/gO7S7X8Ltr31Rx55Wyst9BrCUmu5bJd6DEjjaPF++YqYvtw7Nem?=
 =?us-ascii?Q?mC4jovpRiSjNm2ydpXYiAxaKrt8bZw+dLCH/Ov0xLLEbpPNGsPUw3hw+x5O6?=
 =?us-ascii?Q?vUhIrjSiqsFbAuFiSgdHtjMjUbh109GqcNV9Ao3GQE9rj1Uz9VMQq3IA+BeF?=
 =?us-ascii?Q?eLdU3ICGIxbe8TZZG9nRPR6YKswvO5cnGsLdQMw54V6qHhNJ5Ts426JY81Qg?=
 =?us-ascii?Q?1xTJYcKNCK7TgDjY/XJ7SXIzeSZoxALEtPs3h88deHL76ANRzHi6aY05x517?=
 =?us-ascii?Q?USgneiDheelFBD7fK1+bx4NaRYiu45ncMdkW3NALgF3juMr7PfCXeAOCnxG2?=
 =?us-ascii?Q?5E77pglzyKIXqQE7S7riUUqZcrpdcWnYCjcjLe3dgkNk9XJH2wUYUfpLV4ir?=
 =?us-ascii?Q?y/D+/pm/O2Yr95vKk8ezZzxbkeQmH9ab45AoQ7OviKR11A9K6C1M7H16B7ms?=
 =?us-ascii?Q?HgJCQEFvk2Qmm1g4GV5FjpxwpAp26kItCSQN0dOxm61YOnNQrayilaQbEPlj?=
 =?us-ascii?Q?TqkvMnPShJdmYMKQOevknykdN2FR9k9ANfInGr2RxZmW3TGZxv6XwaIz9Lik?=
 =?us-ascii?Q?xUn3pW/K66S/1qq9nFlWXFMQw0Dv1MWEzGdt3vmPcLGSNDGnZcokcNu/bz8I?=
 =?us-ascii?Q?AjscN+6/eaETvkFVgljdXyMmdxtjCCj9X4H1wkBGKGwfpUSghTEoaB4pW/5L?=
 =?us-ascii?Q?cEhnYz2v0OqGp1biVvTv+OTznvYGPFrM597/M8N2BTYSsUwMrn1bKjWNaZKb?=
 =?us-ascii?Q?Ofe9t8jkF/XTZrw5l0Dpf9DjzvjlBsZ8lW6WNqNUiVBqB4hQ4y3ZFrSp1ygC?=
 =?us-ascii?Q?66qvjKT2yJWyruDhTlkjACCidsFZb7vAl3YvbQbpz6kc0RVyYmd4xKPTenmW?=
 =?us-ascii?Q?C3Dynnb8dMZOXSXH242AaFWaAL3sX0aC71GhIK1v8406FxUkVZyLVuFgeiqL?=
 =?us-ascii?Q?nziwF+BEV0Rs1CodJYkXw2uF5qLdHYWcp/WewTEkNioXUYLzU3q5F3H8DRrQ?=
 =?us-ascii?Q?ymNHSpjrQHWHTOV+cIsdCWsC8g85LN6Vxw3T3cu1YOh0mq876hXzlLGwp4Kg?=
 =?us-ascii?Q?4wjesl6KFsg19PvWDdaWtkxrCeh+AmVFD+E0AXqstChTEvAyLKTdqrxhJYTI?=
 =?us-ascii?Q?jV7kES9WdlHgMA3DJgrBnhSoN6DdE2w1Kgu7LJZHKgnEWUzimzgjsZLd6l3w?=
 =?us-ascii?Q?bCrpXtSmUeMtYTAUldWPBuXvrYgwq4Cz6QrxhuDje+ah/tVUiYxB+Kfjbw+L?=
 =?us-ascii?Q?3XQtCdyt/jelnVgEvSe+XZNeEtkNaGcnqshtHUYM/M0V6pFDtQ/Dk6g8Z8H/?=
 =?us-ascii?Q?Af/36UHs0yB/vs+K8CzDpu9Lz3UyuWI6Aw+e75tKp0thmpTqe9JMVxCNiMYh?=
 =?us-ascii?Q?Bl27dy+uFOwv3jJ4GCdGsm7YeubtxM9fyi2uhIVeXqRIG8CBIlzlkcNgs71o?=
 =?us-ascii?Q?ayQ9RHMandjJZHVspGe1TI0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84881333-ab35-4a1e-2a9d-08dd0d74fcad
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:17:06.5029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cpse/Pi9+Jj4lLPOT8i8xSdXygeA93LldRax2I4aQq1yYenCSo31g3tRGET/iknfOqLqnkEu3nEF+ZhkNq76yydAu5QoW0LV1gDXO+gjJCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6420

The commit ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by
zone_dma_limit") changed how zone_dma_limit was calculated.  Now it
returns the memsize limit in IORT or device tree instead of U32_MAX if
the memsize limit is greater than U32_MAX.

This resulted in DMA allocations may use GFP_DMA even though the devices
don't require it.  It caused regression on our two sockets systems due
to excessive remote memory access.

Fixes: ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by zone_dma_limit")
Cc: <stable@vger.kernel.org>    [6.12+]
Reported-by: Yutang Jiang <jiangyutang@os.amperecomputing.com>
Tested-by: Yutang Jiang <jiangyutang@os.amperecomputing.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/mm/init.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d21f67d67cf5..ccdef53872a0 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -117,15 +117,6 @@ static void __init arch_reserve_crashkernel(void)
 
 static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
 {
-	/**
-	 * Information we get from firmware (e.g. DT dma-ranges) describe DMA
-	 * bus constraints. Devices using DMA might have their own limitations.
-	 * Some of them rely on DMA zone in low 32-bit memory. Keep low RAM
-	 * DMA zone on platforms that have RAM there.
-	 */
-	if (memblock_start_of_DRAM() < U32_MAX)
-		zone_limit = min(zone_limit, U32_MAX);
-
 	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
 }
 
@@ -141,6 +132,14 @@ static void __init zone_sizes_init(void)
 	acpi_zone_dma_limit = acpi_iort_dma_get_max_cpu_address();
 	dt_zone_dma_limit = of_dma_get_max_cpu_address(NULL);
 	zone_dma_limit = min(dt_zone_dma_limit, acpi_zone_dma_limit);
+	/*
+	 * Information we get from firmware (e.g. DT dma-ranges) describe DMA
+	 * bus constraints. Devices using DMA might have their own limitations.
+	 * Some of them rely on DMA zone in low 32-bit memory. Keep low RAM
+	 * DMA zone on platforms that have RAM there.
+	 */
+	if (memblock_start_of_DRAM() < U32_MAX)
+		zone_dma_limit = min(zone_dma_limit, U32_MAX);
 	arm64_dma_phys_limit = max_zone_phys(zone_dma_limit);
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
-- 
2.47.0


