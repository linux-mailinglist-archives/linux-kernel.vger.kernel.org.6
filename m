Return-Path: <linux-kernel+bounces-392313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B979B924F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DA81C20F43
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2A61A263F;
	Fri,  1 Nov 2024 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="b2vUwJDp"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2A19BBC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468837; cv=none; b=UBplLKGIWnSBYbOD7Ri13FkcsHh5PFoTA0xwN87voVuMwf7pZc2JW0s1WPYAspnJCSv4zYbh19z8XGFoP366M6iq11G/rK23ddMm6KD8mTgKNyhF7uOboJIy7vaTTbIU2bI5OM0EHf5g0OJ485mds1NsavTEMnG1hdmyvXaWz5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468837; c=relaxed/simple;
	bh=9QuDdEZObFLdVCdi41vb2/DdOJlzTAuOMJoNWdOngAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jp76Tooo3CXMWmMleEq6/RYhAw7nfazZdl/XCV9buYEO3P3TGriEuiBbdhpbuS8qObHQxmHEhzvx34kXaREdWZwyqKq//t5oD+PbgDYnNkDoyML5AtQVhym04Xx03Bmqn2HnGT6RvQih/ufIolohPmQHejoX4iHsUE06SAwGQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=b2vUwJDp; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc04d4777so959554eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 06:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730468834; x=1731073634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=958SxrMmW3i4D+ZplSVQbEZWrtI+ztOMZMWNYttFV2M=;
        b=b2vUwJDpBdmmhSmacJahUb93YQXKLLZZLex1e6GV5mveutQtUVijI9XlD/FbFHpx25
         tmkkjwk2X8upxMoWF6Yd7rYiy7WHrCcaFmAucpK3mLt6GN5JogOBtBqT9/P62v3Whw1l
         rvgoF/BaEORUF/C/d27UiYqp4fKvLTgGP7lPmNm+XgEkyni8GY95q2XT2gZ/AonZSG4+
         deeq3a/TPGWnHpFaXvPrO+scFwEvVNZTCLT8NW0HmwrDVLGGdlG2mkJrF4UGgwCZWNUQ
         SxNFMExH5iZQYq7Aj+N7VORcXzOho/DyJctzMQfa+wvQTODmEvzxxKtjfE5blmNq1WyH
         ZL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730468834; x=1731073634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=958SxrMmW3i4D+ZplSVQbEZWrtI+ztOMZMWNYttFV2M=;
        b=E7SBaUuv7g8GR+6CDa/G7B+1hgsQqex8PkQAwT0GXCjdJ1ZK6S3iTTosP4woUlV8kf
         6a5802HlSsYZuHKtnP3t3/I7cO+IpEwcHQkaZ7kHx3SgTQFRy5g4iwojQfLU7epAOJg4
         3u/Xi7Ce80n7szEzvGA1gIQwaLRggOtduWRqezzxlEXcqThR2ZQlS3+nWm49KEEo3zIz
         yFeLkcNf6ol3cpCH4eVAyxAV8Ubwktf9x9SfyMZiqr9K69HaeGhr0/YhogSMKgB8/jzZ
         plVAZ9NpXFrlqIDnZ3pRhZZ204fL0Nm92vY1T37daWMDAxEys98J5I5xaZKc1Elxj4cB
         9FMg==
X-Forwarded-Encrypted: i=1; AJvYcCWP5qATh4uIvKqbPeugTbfScHt2mv/rJaPxIsH55uDC5rV20XNWZPxtSS2zyDFOAFG8s+h0lESNx+3BgMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx48Md3kcNk2+eI9e7Kl3s+CD187tXfKNMDagcit99IFcQq03WP
	n8dKUWtmCz3svScxFAuRdxqVdovXcgEGo/sNHOf41luFcf66bIeMbguOJFFqYigCYO9MV+kv2oy
	utKE=
X-Google-Smtp-Source: AGHT+IG2zNy5gFfziJXkBV7+Rtit8XCDlH0hFpywbEzbxKc71T+qTweXHMmo2vX3g3z1Usqutl9fyg==
X-Received: by 2002:a05:6358:248c:b0:1c3:9144:fde4 with SMTP id e5c5f4694b2df-1c5e32cc4c9mr790146855d.9.1730468834126;
        Fri, 01 Nov 2024 06:47:14 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com ([50.193.156.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0cac07sm18840631cf.48.2024.11.01.06.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:47:13 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Terry.Bowman@amd.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	rppt@kernel.org
Subject: [PATCH v5 1/3] memory: implement memory_block_advise/probe_max_size
Date: Fri,  1 Nov 2024 09:47:03 -0400
Message-ID: <20241101134706.1185-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101134706.1185-1-gourry@gourry.net>
References: <20241101134706.1185-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hotplug memory sources may have opinions on what the memblock size
should be - usually for alignment purposes.  For example, CXL memory
extents can be 256MB with a matching alignment. If this size/alignment
is smaller than the block size, it can result in stranded capacity.

Implement memory_block_advise_max_size for use prior to allocator init,
for software to advise the system on the max block size.

Implement memory_block_probe_max_size for use by arch init code to
calculate the best block size. Use of advice is architecture defined.

The probe value can never change after first probe. Calls to advise
after probe will return -EBUSY to aid debugging.

On systems without hotplug, always return -ENODEV and 0 respectively.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c  | 53 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/memory.h | 10 ++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 67858eeb92ed..835793150b41 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -110,6 +110,59 @@ static void memory_block_release(struct device *dev)
 	kfree(mem);
 }
 
+
+/* Max block size to be set by memory_block_advise_max_size */
+static unsigned long memory_block_advised_size;
+static bool memory_block_advised_size_queried;
+
+/**
+ * memory_block_advise_max_size() - advise memory hotplug on the max suggested
+ *				    block size, usually for alignment.
+ * @size: suggestion for maximum block size. must be aligned on power of 2.
+ *
+ * Early boot software (pre-allocator init) may advise archs on the max block
+ * size. This value can only decrease after initialization, as the intent is
+ * to identify the largest supported alignment for all sources.
+ *
+ * Use of this value is arch-defined, as is min/max block size.
+ *
+ * Return: 0 on success
+ *	   -EINVAL if size is 0 or not pow2 aligned
+ *	   -EBUSY if value has already been probed
+ */
+int __init memory_block_advise_max_size(unsigned long size)
+{
+	if (!size || !is_power_of_2(size))
+		return -EINVAL;
+
+	if (memory_block_advised_size_queried)
+		return -EBUSY;
+
+	if (memory_block_advised_size) {
+		memory_block_advised_size = min(memory_block_advised_size,
+						size);
+	} else {
+		memory_block_advised_size = size;
+	}
+
+	return 0;
+}
+
+/**
+ * memory_block_advised_max_size() - query advised max hotplug block size.
+ *
+ * After the first call, the value can never change. Callers looking for the
+ * actual block size should use memory_block_size_bytes. This interface is
+ * intended for use by arch-init when initializing the hotplug block size.
+ *
+ * Return: advised size in bytes, or 0 if never set.
+ */
+unsigned long memory_block_advised_max_size(void)
+{
+	memory_block_advised_size_queried = true;
+	return memory_block_advised_size;
+}
+
 unsigned long __weak memory_block_size_bytes(void)
 {
 	return MIN_MEMORY_BLOCK_SIZE;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index c0afee5d126e..8202d0efbf46 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -149,6 +149,14 @@ static inline int hotplug_memory_notifier(notifier_fn_t fn, int pri)
 {
 	return 0;
 }
+static inline int memory_block_advise_max_size(unsigned long size)
+{
+	return -ENODEV;
+}
+static inline unsigned long memory_block_advised_max_size(void)
+{
+	return 0;
+}
 #else /* CONFIG_MEMORY_HOTPLUG */
 extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
@@ -181,6 +189,8 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 void memory_block_add_nid(struct memory_block *mem, int nid,
 			  enum meminit_context context);
 #endif /* CONFIG_NUMA */
+int memory_block_advise_max_size(unsigned long size);
+unsigned long memory_block_advised_max_size(void);
 #endif	/* CONFIG_MEMORY_HOTPLUG */
 
 /*
-- 
2.43.0


