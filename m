Return-Path: <linux-kernel+bounces-218214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8B890BB33
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700B32842ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD94187339;
	Mon, 17 Jun 2024 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="egtWXHwH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AFE1BDEF;
	Mon, 17 Jun 2024 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652963; cv=none; b=G3z4daNWQSRjYgrMhMjDvAhzGekrItP0Vhkbr41D9gV21i1L7kCLhFoljUkghGsRWv3y8f9JDwpi24P7w6YPQYJdRYhzjXTXJcQZ5XW77SYvYOd+/01FhzSZiEUyRQzVe4BbxPxVpS7HRm/ERWhClNR3JGsjrmDwm85n3K2QTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652963; c=relaxed/simple;
	bh=5LCDuNSoORs1LN+gWbAt18oTeKlDeMnuGc+aWySrwYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgcnFlR21GwxPp9dpWJuaZ74M3rAPc9t2x1Bfr5aa4p9qP6wyFpETPdj+1CKaEnEUTdrYFdpIU8DXiQrXyHub19vPA+HcpYNFRs2wS80IYcyP2jHuTU8RGRsoGrSTONSE6V8cNX8XN3fHMfzWcT9zc3EfBUUkil7UWCvLneeG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=egtWXHwH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HAeAjB024622;
	Mon, 17 Jun 2024 19:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n38ftMpU9C8qamwfma+gAf6Zymvr8UVC3i4FP76IJQo=; b=egtWXHwHYSVXWVqW
	Avy7DNxtP+iRcvZ7F9F84PCZJCtnkJNTZoFnK4t884ERSJU7ct/yDux0l/T+7ElK
	/M4QSapg/Fn13FpCQn//0zy5SolX3TJzUhTdcsUw0SLI9xPx478utS4dMjW1SyuR
	Fu6GAgpadO1KFEt5BFD+gy8hvJJqqS47j9WOxHQ3tTWXeq1dsQJcH5ahjTGrUbJw
	ffBb027dzp26XKglqufsmpSQ3I5U/lpbdAn2OwnQ34zSGSvCN/ZKpG0wHS3w+lLD
	9iNDpVbftnmF7msMVTXeFA3iR3vc5m9ufQifGfmPSYZWoFG+setCJQC+whGKze/d
	iLxHvA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys3qf4kp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 19:35:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HJZgJ7028531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 19:35:42 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Jun 2024 12:35:39 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <robin.murphy@arm.com>, <broonie@kernel.org>, <conor@kernel.org>,
        <nathan@kernel.org>, <robh@kernel.org>
CC: <catalin.marinas@arm.com>, <devicetree@vger.kernel.org>, <hch@lst.de>,
        <iommu@lists.linux.dev>, <kernel@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <quic_obabatun@quicinc.com>, <saravanak@google.com>, <will@kernel.org>
Subject: [PATCH] of: reserved_mem: Restructure code to call reserved mem init functions earlier
Date: Mon, 17 Jun 2024 12:33:57 -0700
Message-ID: <20240617193357.3929092-1-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <002b6176-41b3-4888-abb1-978399d108b8@arm.com>
References: <002b6176-41b3-4888-abb1-978399d108b8@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vypRI1pEiUoF6yC72dTSbtfK0hxwGNjA
X-Proofpoint-ORIG-GUID: vypRI1pEiUoF6yC72dTSbtfK0hxwGNjA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170151

After all the reserved memory regions have been added to the
reserved_mem array, a region specific initialization function is called
on each of reserved memory regions in a loop to initialize them.

With recent changes made to allow the reserved_mem array be dynamically
allocated, the cma reserved memory regions are not initialized until
after the page tables are setup. This causes the warning seen in the
dump stack below:

	WARNING: CPU: 0 PID: 1 at mm/memory.c:2789 __apply_to_page_range+0x360/0x380
	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc1-00007-ga46cccb0ee2d #1
	Hardware name: Generic DT based system
	Call trace:
	unwind_backtrace from show_stack+0x18/0x1c
	show_stack from dump_stack_lvl+0x54/0x68
	dump_stack_lvl from __warn+0x74/0x114
	__warn from warn_slowpath_fmt+0x13c/0x1c0
	warn_slowpath_fmt from __apply_to_page_range+0x360/0x380
	__apply_to_page_range from apply_to_page_range+0x24/0x2c
	apply_to_page_range from __alloc_from_contiguous+0xc4/0x158
	__alloc_from_contiguous from cma_allocator_alloc+0x3c/0x44
	cma_allocator_alloc from arch_dma_alloc+0x128/0x2b4
	arch_dma_alloc from dma_alloc_attrs+0x90/0x150
	dma_alloc_attrs from drm_gem_dma_create+0xa4/0x13c
	drm_gem_dma_create from drm_gem_dma_create_with_handle+0x24/0xac
	drm_gem_dma_create_with_handle from drm_gem_dma_dumb_create+0x44/0x50
	drm_gem_dma_dumb_create from drm_client_framebuffer_create+0x9c/0x164
	drm_client_framebuffer_create from drm_fbdev_dma_helper_fb_probe+0x84/0x23c
	drm_fbdev_dma_helper_fb_probe from __drm_fb_helper_initial_config_and_unlock+0x2e4/0x4f8
	__drm_fb_helper_initial_config_and_unlock from drm_fbdev_dma_client_hotplug+0x74/0xb8
	drm_fbdev_dma_client_hotplug from drm_client_register+0x5c/0x98
	drm_client_register from aspeed_gfx_probe+0x278/0x3c0
	aspeed_gfx_probe from platform_probe+0x60/0xb8
	platform_probe from really_probe+0xd4/0x3b4
	really_probe from __driver_probe_device+0x90/0x1dc
	__driver_probe_device from driver_probe_device+0x38/0xd0
	driver_probe_device from __driver_attach+0x118/0x1dc
	__driver_attach from bus_for_each_dev+0x84/0xd4
	bus_for_each_dev from bus_add_driver+0xec/0x1f0
	bus_add_driver from driver_register+0x84/0x11c
	driver_register from do_one_initcall+0x84/0x1c8
	do_one_initcall from kernel_init_freeable+0x1a4/0x230
	kernel_init_freeable from kernel_init+0x1c/0x138
	kernel_init from ret_from_fork+0x14/0x28
	Exception stack(0x9f015fb0 to 0x9f015ff8)
	5fa0:                                     00000000 00000000 00000000 00000000
	5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
	5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
	---[ end trace 0000000000000000 ]---
	aspeed_gfx 1e6e6000.display: [drm] fb0: aspeed-gfx-drmd frame buffer device

Hence, restructure the code to initialize the regions as soon as each
of them are added to the reserved_mem array.

Fixes: a46cccb0ee2d ("of: reserved_mem: Restruture how the reserved memory regions are processed")
Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c             |  2 +-
 drivers/of/of_private.h      |  2 +-
 drivers/of/of_reserved_mem.c | 77 ++++++++++++++++++++----------------
 3 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 9cde2abd2fc0..ea2dff0478c7 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1239,7 +1239,7 @@ void __init unflatten_device_tree(void)
 	unittest_unflatten_overlay_base();
 
 	/* initialize the reserved memory regions */
-	of_init_reserved_mem();
+	of_scan_reserved_mem_reg_nodes();
 }
 
 /**
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 01b33c4b1e9f..7412aed903df 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -181,7 +181,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 #endif
 
 int fdt_scan_reserved_mem(void);
-void of_init_reserved_mem(void);
+void of_scan_reserved_mem_reg_nodes(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index eb54490a0a11..0b1eb34b891e 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -97,6 +97,8 @@ static void __init alloc_reserved_mem_array(void)
 	reserved_mem = new_array;
 }
 
+static void __init of_init_reserved_mem_node(struct reserved_mem *rmem);
+
 /*
  * of_reserved_mem_save_node() - save fdt node for second pass initialization
  */
@@ -115,6 +117,12 @@ static void __init of_reserved_mem_save_node(struct device_node *node, const cha
 	rmem->base = base;
 	rmem->size = size;
 
+	/*
+	 * Run the region specific initialization function for the rmem
+	 * node.
+	 */
+	of_init_reserved_mem_node(rmem);
+
 	reserved_mem_count++;
 	return;
 }
@@ -201,6 +209,8 @@ static int __init __fdt_reserved_mem_check_root(unsigned long node)
 	return 0;
 }
 
+static void __init __rmem_check_for_overlap(void);
+
 /**
  * of_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
  * reserved memory regions.
@@ -211,7 +221,7 @@ static int __init __fdt_reserved_mem_check_root(unsigned long node)
  * size are all stored in the reserved_mem array by calling the
  * of_reserved_mem_save_node() function.
  */
-static void __init of_scan_reserved_mem_reg_nodes(void)
+void __init of_scan_reserved_mem_reg_nodes(void)
 {
 	struct device_node *node, *child;
 	phys_addr_t base, size;
@@ -222,6 +232,13 @@ static void __init of_scan_reserved_mem_reg_nodes(void)
 		return;
 	}
 
+	/*
+	 * Before moving forward, allocate the exact size needed for the
+	 * reserved_mem array and copy all previously saved contents
+	 * into the new array if successful.
+	 */
+	alloc_reserved_mem_array();
+
 	for_each_child_of_node(node, child) {
 		int ret = 0;
 		const char *uname;
@@ -246,6 +263,8 @@ static void __init of_scan_reserved_mem_reg_nodes(void)
 		if (size)
 			of_reserved_mem_save_node(child, uname, base, size);
 	}
+	/* check for overlapping reserved regions */
+	__rmem_check_for_overlap();
 }
 
 static int __init __reserved_mem_alloc_size(unsigned long node, const char *uname);
@@ -526,44 +545,32 @@ static void __init __rmem_check_for_overlap(void)
 }
 
 /**
- * of_init_reserved_mem() - allocate and init all saved reserved memory regions
+ * of_init_reserved_mem_node() - Initialize a saved reserved memory region.
  */
-void __init of_init_reserved_mem(void)
+static void __init of_init_reserved_mem_node(struct reserved_mem *rmem)
 {
-	int i;
-
-	alloc_reserved_mem_array();
-
-	of_scan_reserved_mem_reg_nodes();
+	int err;
+	bool nomap;
+	struct device_node *node = rmem->dev_node;
 
-	/* check for overlapping reserved regions */
-	__rmem_check_for_overlap();
+	nomap = of_property_present(node, "no-map");
 
-	for (i = 0; i < reserved_mem_count; i++) {
-		struct reserved_mem *rmem = &reserved_mem[i];
-		struct device_node *node = rmem->dev_node;
-		int err = 0;
-		bool nomap;
-
-		nomap = of_property_present(node, "no-map");
-
-		err = __reserved_mem_init_node(rmem);
-		if (err != 0 && err != -ENOENT) {
-			pr_info("node %s compatible matching fail\n", rmem->name);
-			if (nomap)
-				memblock_clear_nomap(rmem->base, rmem->size);
-			else
-				memblock_phys_free(rmem->base, rmem->size);
-		} else {
-			phys_addr_t end = rmem->base + rmem->size - 1;
-			bool reusable = of_property_present(node, "reusable");
-
-			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
-				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
-				nomap ? "nomap" : "map",
-				reusable ? "reusable" : "non-reusable",
-				rmem->name ? rmem->name : "unknown");
-		}
+	err = __reserved_mem_init_node(rmem);
+	if (err != 0 && err != -ENOENT) {
+		pr_info("node %s compatible matching fail\n", rmem->name);
+		if (nomap)
+			memblock_clear_nomap(rmem->base, rmem->size);
+		else
+			memblock_phys_free(rmem->base, rmem->size);
+	} else {
+		phys_addr_t end = rmem->base + rmem->size - 1;
+		bool reusable = of_property_present(node, "reusable");
+
+		pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
+			&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
+			nomap ? "nomap" : "map",
+			reusable ? "reusable" : "non-reusable",
+			rmem->name ? rmem->name : "unknown");
 	}
 }
 
-- 
2.34.1


