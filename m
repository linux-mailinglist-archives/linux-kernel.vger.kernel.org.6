Return-Path: <linux-kernel+bounces-355342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C089950E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5732877C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99461DFDA5;
	Tue,  8 Oct 2024 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Oh0u6p98"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF11DFD9F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396056; cv=none; b=jdpAVzURKV7Aku35YHgkha0O0qQNPdMFD0OccyMbmvDF8NLxPh2qZ2bUlsi8HN019tBBW0XZCXeC5/lQPqwsYJ3qX2AHHVdwa250Rq6SYVUNT3/YGpfJmEhTMDWJAmybSSVEOR2fbz63Fgdn0z/mEGOD4o+e0YRCeP9jfGEtnvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396056; c=relaxed/simple;
	bh=6Fojn6KYi9Rnmp9EMOv/t6rJ9pIb1bMhH4aerHdoOZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOFhHpftm4YXNo/azG7Oi6z4nWIuU5ilhhG6/+so97SXJFE0XxqgtNrWxCmxF1rZvkUx9nAb1fxeCRDTe2rRr0w93VuL/jOM2IlgUrWkZ05szTKj8l/IG54dh8j399w1vmWHPCkBiOmOWe+27ExcqswFdAyxkI4rU+bcdhngtFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Oh0u6p98; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbc28f6d10so3833396d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728396053; x=1729000853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnKzHoFsIxSKvnCi298qgtwKBJFTSXeEqlrSeNMpfd8=;
        b=Oh0u6p98IfMFdV7CJ8/g+chEZT7jYwu/BAhJrvfPUlT4LhtEP8Nk1lKm+3U0I5/BvG
         Z9pDeqRaYWPHV7bvCCpId5IBT4XPM7SnbzKO2BK+RZOK9XmhQHtz7rGEU5pqGsk++q5U
         OSczRhi3xWZqjA4roT86+fvUGMJRkno/6vDP96SK6xy9ASf2ZtX4qsLixgU8hnxSWY0I
         OOBU5DGtBfv0k5TO31H+mfMeznnFznlXi2c0rQ0LeSTgsx+lzYka8vTcrAyVCz579Tum
         GyNjuGbdcUJvzGtEk4HmXjMbJIuvlj+QKHxfD3nVQ+DIs9l46cB6CbD08u4imORWydvq
         uK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396053; x=1729000853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnKzHoFsIxSKvnCi298qgtwKBJFTSXeEqlrSeNMpfd8=;
        b=oQr1bo0DW1KjmkC+0BZT2N5Vgt2fs5JNf2PXRkQHvUtZz1ncFIwZimW2Fjw2BhvrO1
         MMtkiZsj2fN572BGgPfdySMYi0GngMlShzcZ5rKYA5p3kUUxHuCI4kYCIx5xmVInC+u5
         yPKDUAZqqNPV/GQhuey5h3PUuRCgtvixqyrA6skpi56buWtvZDZyT3cZ59vOmE1YFjOU
         LNOpfLnyN4drbAKFYryQlBC7T7gnGIbTGUU5JxrILhEfKc23PqGp6brn8CM6Us6fFrlb
         bqoH8OpapxZtrT1bSVMrWebg7HnjLwKos1aLB6LNxxBovi20Yg1Q0rA6HLrpx/KA4/cE
         SRqA==
X-Gm-Message-State: AOJu0Yxg+i6cANb8nsuwEi1eSSXI0bblM+vaQCazRDQzIUpXLg7Mc74V
	/uQSAd0QGUKFKGbwYvq1YWvUWZMsalfQLTV+giGJ47cO8nZ1eknxIlOFsIJX+0M=
X-Google-Smtp-Source: AGHT+IEWQaL+bYEjt3RyVfxhNXMy9Cz/JlOtCh7gn34GRctxubICCfzpYSUr2ZJbwepGsgKWAr958Q==
X-Received: by 2002:a0c:e5c4:0:b0:6cb:a705:c05e with SMTP id 6a1803df08f44-6cba705c0aamr170960556d6.6.1728396053465;
        Tue, 08 Oct 2024 07:00:53 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbc78650efsm698396d6.39.2024.10.08.07.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:00:53 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@Huawei.com,
	alison.schofield@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com,
	lenb@kernel.org,
	dave.jiang@intel.com,
	ira.weiny@intel.com
Subject: [PATCH 3/3] acpi,srat: reduce memory block size if CFMWS has a smaller alignment
Date: Tue,  8 Oct 2024 00:43:55 -0400
Message-ID: <20241008044355.4325-4-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008044355.4325-1-gourry@gourry.net>
References: <20241008044355.4325-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL Fixed Memory Window allows for memory aligned down to the
size of 256MB.  However, by default on x86, memory blocks increase
in size as total System RAM capacity increases. On x86, this caps
out at 2G when 64GB of System RAM is reached.

When the CFMWS regions are not aligned to memory block size, this
results in lost capacity on either side of the alignment.

Parse all CFMWS to detect the largest common denomenator among all
regions, and reduce the block size accordingly.

This can only be done when MEMORY_HOTPLUG and SPARSEMEM configs are
enabled, but the surrounding code may not necessarily require these
configs, so build accordingly.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/acpi/numa/srat.c | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 44f91f2c6c5d..9367d36eba9a 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/acpi.h>
 #include <linux/memblock.h>
+#include <linux/memory.h>
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
@@ -333,6 +334,37 @@ acpi_parse_memory_affinity(union acpi_subtable_headers *header,
 	return 0;
 }
 
+#if defined(CONFIG_MEMORY_HOTPLUG)
+/*
+ * CXL allows CFMW to be aligned along 256MB boundaries, but large memory
+ * systems default to larger alignments (2GB on x86). Misalignments can
+ * cause some capacity to become unreachable. Calculate the largest supported
+ * alignment for all CFMW to maximize the amount of mappable capacity.
+ */
+static int __init acpi_align_cfmws(union acpi_subtable_headers *header,
+				   void *arg, const unsigned long table_end)
+{
+	struct acpi_cedt_cfmws *cfmws = (struct acpi_cedt_cfmws *)header;
+	u64 start = cfmws->base_hpa;
+	u64 size = cfmws->window_size;
+	unsigned long *fin_bz = arg;
+	unsigned long bz;
+
+	for (bz = SZ_64T; bz >= SZ_256M; bz >>= 1) {
+		if (IS_ALIGNED(start, bz) && IS_ALIGNED(size, bz))
+			break;
+	}
+
+	/* Only adjust downward, we never want to increase block size */
+	if (bz < *fin_bz && bz >= SZ_256M)
+		*fin_bz = bz;
+	else if (bz < SZ_256M)
+		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
+
+	return 0;
+}
+#endif /* defined(CONFIG_MEMORY_HOTPLUG) */
+
 static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 				   void *arg, const unsigned long table_end)
 {
@@ -501,6 +533,10 @@ acpi_table_parse_srat(enum acpi_srat_type id,
 int __init acpi_numa_init(void)
 {
 	int i, fake_pxm, cnt = 0;
+#if defined(CONFIG_MEMORY_HOTPLUG)
+	unsigned long block_sz = memory_block_size_bytes();
+	unsigned long cfmw_align = block_sz;
+#endif /* defined(CONFIG_MEMORY_HOTPLUG) */
 
 	if (acpi_disabled)
 		return -EINVAL;
@@ -552,6 +588,18 @@ int __init acpi_numa_init(void)
 	}
 	last_real_pxm = fake_pxm;
 	fake_pxm++;
+
+#if defined(CONFIG_MEMORY_HOTPLUG)
+	/* Calculate and set largest supported memory block size alignment */
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_align_cfmws,
+			      &cfmw_align);
+	if (cfmw_align < block_sz && cfmw_align >= SZ_256M) {
+		if (set_memory_block_size_order(ffs(cfmw_align)-1))
+			pr_warn("CFMWS: Unable to adjust memory block size\n");
+	}
+#endif /* defined(CONFIG_MEMORY_HOTPLUG) */
+
+	/* Then parse and fill the numa nodes with the described memory */
 	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
 			      &fake_pxm);
 
-- 
2.43.0


