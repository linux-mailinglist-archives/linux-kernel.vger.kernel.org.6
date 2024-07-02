Return-Path: <linux-kernel+bounces-238384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9D49249AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48702B236F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC6E20124E;
	Tue,  2 Jul 2024 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chH1WdRO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5294D1BA06B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954234; cv=none; b=ssUm9Vnp6DoAvc+ZbCfLKNXiv+DodKNCC5Mf7mTY5UQWXCbTLe2bctdp2uv2FFXtzkFDBs0IxRhHmtzPbpZI6JjPPCf6tJnYSHg7IT5VjQd0kK/VfFE39IKq0yxJIV7g5CjryHYJetpS+n5/AeTQlzjKNFQqKVnkil/r26v+vCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954234; c=relaxed/simple;
	bh=TWwYAQR1/ZQz/7w57+uehXebPTXv6mBfcflgPdnnh5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOCMiwWeCsbaOsE44LgMm5FHyar3R4mASxl7IOqr6H3il7ZP8vJq9BBosDxau89FSXk/8c7Vk2WTRMzhQV9WmXHXg2waz14EPsfsQRysSihIGJheh+xM+JKMf9alI9uBWfzltg0zhMN41jX0IyEOAYMgMz2Ggbeth5FpKripOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chH1WdRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF44C116B1;
	Tue,  2 Jul 2024 21:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719954233;
	bh=TWwYAQR1/ZQz/7w57+uehXebPTXv6mBfcflgPdnnh5I=;
	h=From:To:Cc:Subject:Date:From;
	b=chH1WdROMrOiLZfIMPm2z55nJ9wY79Igw6knK4JxetYJgEGb4DIhY4LFHk7hIqD9F
	 b5iqjqAQ2b+RRiVkxTc6ZOPWgp1HuhNd2IzWOwGO246STu9LQtPQXKucZhC3gtb3JV
	 W8iT1sZkxyPXRK7O7/+ETlQUyOW3GNpXPCUebwEC56IGXc1sL7/7yfue5IDZ9ZRB28
	 9kEF9TYJjUKYwIGda8MBE4vv7KUPb+za5k4o8aCE5Ak9M3qXc0M36ngMQaIhd+riqQ
	 A6m6o3/XcbuimYwUGPKBQxjGFj5fm1kiEBgiomMvg1bq6AsWufPyEkbRuGf7UCfc+Y
	 5IYtnmvlhq2cQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: kexec: Use of_property_read_reg()
Date: Tue,  2 Jul 2024 15:03:44 -0600
Message-ID: <20240702210344.722364-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded parsing of "reg" property with
of_property_read_reg().

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/powerpc/kexec/file_load_64.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 925a69ad2468..5200529bf4db 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -18,6 +18,7 @@
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -376,10 +377,9 @@ static int kdump_setup_usable_lmb(struct drmem_lmb *lmb, const __be32 **usm,
 static int add_usable_mem_property(void *fdt, struct device_node *dn,
 				   struct umem_info *um_info)
 {
-	int n_mem_addr_cells, n_mem_size_cells, node;
+	int node;
 	char path[NODE_PATH_LEN];
-	int i, len, ranges, ret;
-	const __be32 *prop;
+	int i, ret;
 	u64 base, end;
 
 	of_node_get(dn);
@@ -399,40 +399,29 @@ static int add_usable_mem_property(void *fdt, struct device_node *dn,
 		goto out;
 	}
 
-	/* Get the address & size cells */
-	n_mem_addr_cells = of_n_addr_cells(dn);
-	n_mem_size_cells = of_n_size_cells(dn);
-	kexec_dprintk("address cells: %d, size cells: %d\n", n_mem_addr_cells,
-		      n_mem_size_cells);
-
 	um_info->idx  = 0;
 	if (!check_realloc_usable_mem(um_info, 2)) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	prop = of_get_property(dn, "reg", &len);
-	if (!prop || len <= 0) {
-		ret = 0;
-		goto out;
-	}
-
 	/*
 	 * "reg" property represents sequence of (addr,size) tuples
 	 * each representing a memory range.
 	 */
-	ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
+	for (i = 0; ; i++) {
+		ret = of_property_read_reg(dn, i, &base, &end);
+		if (ret)
+			break;
 
-	for (i = 0; i < ranges; i++) {
-		base = of_read_number(prop, n_mem_addr_cells);
-		prop += n_mem_addr_cells;
-		end = base + of_read_number(prop, n_mem_size_cells) - 1;
-		prop += n_mem_size_cells;
+		end += base - 1;
 
 		ret = add_usable_mem(um_info, base, end);
 		if (ret)
 			goto out;
 	}
+	if (!i)
+		goto out;
 
 	/*
 	 * No kdump kernel usable memory found in this memory node.
-- 
2.43.0


