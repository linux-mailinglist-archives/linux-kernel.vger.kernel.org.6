Return-Path: <linux-kernel+bounces-361347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A05B99A713
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319991C212F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ECF1946A8;
	Fri, 11 Oct 2024 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka2xoCpp"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02D19414A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658823; cv=none; b=Y63LdUExkHKrzOE/acAFTAyz+DzX6iBZIEu9nwl3ddEIVsftmEb7Y+F+f9txBjN5hMaNIkD7IVXa2WEt94Zegwrl+8e/POqYMyCotesH4GszyHuzTeGzTyl4ISnuWz7cQNJZtPt0QvSf/3XND4Uhxhjp9+oCgqOBvqZWxHKzzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658823; c=relaxed/simple;
	bh=Q3jhxMB9vfD+HsEj7etjE6Ea4lyy82jH6qx2KW0ZZxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgs70fSDPyxp2xmXFrTQTdbToANFUCsQX3SHJcVq2fECKoz3DIBDRrWbvzDJbjAtfrNzt/WCYhVloq8Tdol1rftrpWp29nBNMK8O387TiP5tTjtcmjDctu7mXGBwPGj/Y63nmnppryytwJ72kmREjyXx7LQZ2IPiuwgmUNzOTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka2xoCpp; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71dec1cf48fso1839008b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728658821; x=1729263621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOuvgWQlE/foa4I7724xWSn7l3vcksejBT7rSNJjxxM=;
        b=ka2xoCpp3QZjE6G/ix1VN5b6Vi/DYzuaX1ASaA3kC+YfbhPQNQxj2zRozz6bHbLbuZ
         A2+Xr/5+sHLPgir8yXqQvzdSPfYptVLi1DT/KlxBAHRnYh9xpg/jnbfw1KaFjeRYwhyS
         /vdqsZXTHLl7h4WvNEvBpH0Cf9uKeejJG41+t2USF7kcIMUzPuX1+Hp1EiEA6MZTFK2o
         pUE3wb0SSAApCleqzUd0oP/tO7XAXBhon2VH5+TiBg2ZS2tDP1Z6S3dn5qidrDl6qEBg
         nPjtV9I9JerxqbE2s24fWPp8go3m9a1X6SO/HDYBHfT4l6DscQoVxQSiIGvlnN0v8fhX
         BjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658821; x=1729263621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOuvgWQlE/foa4I7724xWSn7l3vcksejBT7rSNJjxxM=;
        b=KoW5P+iBacsw8MW3kx/yfPByKyfl6WuQbl7np+RZ0+pzoIQwNdjdvCv61MltSIApIi
         dQE4CtcSK5YcAmMEOSpbbbaL1nQEzew+HpzGMZf6WV8ptCbw9rx5bS17PQ//+4WF6/Ck
         oSzX20UiF99BWZWPEZ784VmkVvkhpNXJpwuP/cAgLFjydq43PAScarybRVh+L17HJcYE
         DM0UHlX+JLhVvLH7BsAz5bWZ0G/vopLXF/TevrCkrT+DrNzefI/Jfr/qybzJTYla8Q9u
         Ip0ufeb951tYrwRtYtPMJUrhih8sv5riCyOpPWLpnXwiHMWCHnMZVXDehpwwOuB3PY1X
         qngA==
X-Forwarded-Encrypted: i=1; AJvYcCVMYc3EvbyT5L9vPHwHzfgqXiVu46I/X7x85zQ6gjHU3wXBoLTIyOSBhnQcg2/ArddPO+SZ8o8HcTYqQNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDN7C8Z0PNYCBTHQ5F9sNlc9Dl0GgzgLHl82BiB/lnuxq2/whJ
	LcTGaKS0zz5YigR+H33Lp7e4pxMwz2zCrXzogIuXYcUQWqseLnDQ
X-Google-Smtp-Source: AGHT+IG28SN7o4rqiQUvFnUoGcWs4GuDv3GMOcb/mAbo3sv1g27mwrxdu/TPHQf2tYzBTJhSQ+rF+g==
X-Received: by 2002:a05:6a00:4fd6:b0:71d:fb10:7d1c with SMTP id d2e1a72fcca58-71e380beb6bmr3997069b3a.26.1728658820768;
        Fri, 11 Oct 2024 08:00:20 -0700 (PDT)
Received: from dw-tp.. ([171.76.85.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4a2c9767sm146561b3a.85.2024.10.11.08.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:00:20 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Sachin P Bappalige <sachinpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v3 2/3] fadump: Reserve page-aligned boot_memory_size during fadump_reserve_mem
Date: Fri, 11 Oct 2024 20:30:05 +0530
Message-ID: <32496f6daeb4ed04c772ae484895241ab2ae1da1.1728658614.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <030b6d46fddac126a6cf7e119bea48055338f0ed.1728658614.git.ritesh.list@gmail.com>
References: <030b6d46fddac126a6cf7e119bea48055338f0ed.1728658614.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch refactors all CMA related initialization and alignment code
to within fadump_cma_init() which gets called in the end. This also means
that we keep [reserve_dump_area_start, boot_memory_size] page aligned
during fadump_reserve_mem(). Then later in fadump_cma_init() we extract the
aligned chunk and provide it to CMA. This inherently also fixes an issue in
the current code where the reserve_dump_area_start is not aligned
when the physical memory can have holes and the suitable chunk starts at
an unaligned boundary.

After this we should be able to call fadump_cma_init() independently
later in setup_arch() where pageblock_order is non-zero.

Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kernel/fadump.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 162327d66982..ffaec625b7a8 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -80,7 +80,7 @@ static struct cma *fadump_cma;
  */
 static void __init fadump_cma_init(void)
 {
-	unsigned long long base, size;
+	unsigned long long base, size, end;
 	int rc;
 
 	if (!fw_dump.fadump_supported || !fw_dump.fadump_enabled ||
@@ -92,8 +92,24 @@ static void __init fadump_cma_init(void)
 	if (fw_dump.nocma || !fw_dump.boot_memory_size)
 		return;
 
+	/*
+	 * [base, end) should be reserved during early init in
+	 * fadump_reserve_mem(). No need to check this here as
+	 * cma_init_reserved_mem() already checks for overlap.
+	 * Here we give the aligned chunk of this reserved memory to CMA.
+	 */
 	base = fw_dump.reserve_dump_area_start;
 	size = fw_dump.boot_memory_size;
+	end = base + size;
+
+	base = ALIGN(base, CMA_MIN_ALIGNMENT_BYTES);
+	end = ALIGN_DOWN(end, CMA_MIN_ALIGNMENT_BYTES);
+	size = end - base;
+
+	if (end <= base) {
+		pr_warn("%s: Too less memory to give to CMA\n", __func__);
+		return;
+	}
 
 	rc = cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump_cma);
 	if (rc) {
@@ -116,11 +132,12 @@ static void __init fadump_cma_init(void)
 	/*
 	 * So we now have successfully initialized cma area for fadump.
 	 */
-	pr_info("Initialized 0x%lx bytes cma area at %ldMB from 0x%lx "
+	pr_info("Initialized [0x%llx, %luMB] cma area from [0x%lx, %luMB] "
 		"bytes of memory reserved for firmware-assisted dump\n",
-		cma_get_size(fadump_cma),
-		(unsigned long)cma_get_base(fadump_cma) >> 20,
-		fw_dump.reserve_dump_area_size);
+		cma_get_base(fadump_cma), cma_get_size(fadump_cma) >> 20,
+		fw_dump.reserve_dump_area_start,
+		fw_dump.boot_memory_size >> 20);
+	return;
 }
 #else
 static void __init fadump_cma_init(void) { }
@@ -553,13 +570,6 @@ int __init fadump_reserve_mem(void)
 	if (!fw_dump.dump_active) {
 		fw_dump.boot_memory_size =
 			PAGE_ALIGN(fadump_calculate_reserve_size());
-#ifdef CONFIG_CMA
-		if (!fw_dump.nocma) {
-			fw_dump.boot_memory_size =
-				ALIGN(fw_dump.boot_memory_size,
-				      CMA_MIN_ALIGNMENT_BYTES);
-		}
-#endif
 
 		bootmem_min = fw_dump.ops->fadump_get_bootmem_min();
 		if (fw_dump.boot_memory_size < bootmem_min) {
-- 
2.46.0


