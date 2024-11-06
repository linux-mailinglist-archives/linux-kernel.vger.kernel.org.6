Return-Path: <linux-kernel+bounces-398523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 736689BF25E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D57E2B249FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC7920514C;
	Wed,  6 Nov 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WQxBWyPG"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D564E204958
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908744; cv=none; b=tvIjshA8CrXRn0p2/iI4Qjjf5rof9UCkCkflsrfjfiroI+2D+YIGpiz1XKnW4ZzFdcskpw2s/IJi3bUo8TYqKzhYi0Ufl0MYNiocnqcllo9gc64JTKOxf9zruVvJkRDerptLEQ3zEk2FbgfpM6dz4jQVeBTKJ4D3joW4imD5THs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908744; c=relaxed/simple;
	bh=U6iBxzGB9ud+QRG4vYXmsvGy5bvVDY0ZsOTjOcgg3Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNh7QxxoNvyrWaAtUbdFFqdJY2NtIztJcmvWoPWZM669r9banygRYSUo+lXETDntVb6WwMYadODVHmgx4TWu6mvpIBJRDGaMYpRxoQTOpBKrUjimGxBkZ7rQPi2DNfUbZUiK7JiV/oTzF2pDakHm2Z90U7ojyM2cJOTVBoZZgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WQxBWyPG; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-513de426bf5so537833e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730908742; x=1731513542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrV9O4GPEUiGe4j9uKnxvw7X+oP7rfAOpfBnY6P0I08=;
        b=WQxBWyPG8XGbFeuw9JC/Sj/giEp3s/Vj742IuJk+Cmk5TC8Noz9UwaY9LuYyb4Jcyt
         C7bEYT6hS+XGfAqRy5BUdq/ilO0wYyZ3P7NEWEDy9BsQDHwYngoHab256Fl4VRkn+uZI
         e29SeyOZoIuB0USlCwlYKshcMBlVQtTXbPIC8QcRlh4OrLi+sDuxQWMZwIGPmyr3q0nJ
         ie/DbkyA1xoZy7y7ZbAcEqZgESHe1PVhJYXbzVDLxoPA9XG4S2ALdmaFQ5KXkWS+OH/n
         4zmbEyQuStF7KxDEy8aaHqEuAK4+PONpfKo2NfWMU1j7BDjspVQ3JNWIGarbUyrc+B38
         tcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908742; x=1731513542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrV9O4GPEUiGe4j9uKnxvw7X+oP7rfAOpfBnY6P0I08=;
        b=gyz126zwAlX7B7eIsUUEC+A3Y66tAKf3TVOILHt1KmmofYykOGODL3Q1KDpSDgg6yB
         akeFfrdcdOxMPkz6pxJpk12z3WDjZfvv+Hx/kLTwH8G76ql6op7GxbDtXQMpw5H4/RGU
         py8wspqeIuhphD4ReKxL6tLS+njCUT6QEoKhx1mH/3Kxr5EznOz5b+HWLOok5gnlJ8Pc
         u/0vzaKVUwt9Br03MN/RIJGhHDadNJ23a+a0UzX45cNieeorZHk+NIA2st65GGhKEUFg
         UHJBhxSKxrlDSR42wpaff39wNCvEABA30Lc1MEPtO7EtC2NUeq+oSgKyBbfrKbQkNDnK
         Q3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXEH6w43qJHijn7i2pJ5R1YHTepLmTthaLcW5MiZpYPGu3HGwUgcQgH7aMMtMr5mkwPce1GBTelIK/2Tww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8awgLKJiUp7/nhhF5yfLpk1b8K29OLDLSXWA+wOxKfxgiZLTv
	lEd5twqIJx/x5eszkvqH+V/jvCH3Agcfqg+CR0YDeThcqAh+hGksjcbOtIJVzcg=
X-Google-Smtp-Source: AGHT+IFsdN7WBxVaMsC4Loys1Mpdq5x23y2sQKFk/taNoch7FUZg+El0slCCEmCVOauncv36ulU/bg==
X-Received: by 2002:a05:6122:2a41:b0:4f6:aa3e:aa4c with SMTP id 71dfb90a1353d-51014ff7a70mr36295778e0c.3.1730908741730;
        Wed, 06 Nov 2024 07:59:01 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f7b85sm641377285a.31.2024.11.06.07.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:59:01 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
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
Subject: [PATCH v6 1/3] memory: implement memory_block_advise/probe_max_size
Date: Wed,  6 Nov 2024 10:58:45 -0500
Message-ID: <20241106155847.7985-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241106155847.7985-1-gourry@gourry.net>
References: <20241106155847.7985-1-gourry@gourry.net>
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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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


