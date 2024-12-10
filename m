Return-Path: <linux-kernel+bounces-440401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD64A9EBD7E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F5B188C2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9113223EA64;
	Tue, 10 Dec 2024 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rDXiFPQ9"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93EA23D41C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868349; cv=none; b=Rrr6qi6gf9NzuTExDchndeHyjRehLKlHF+CQimpGgsfNNP3Bb+POjg4fLBPXcLnEs8utsJJevUSo7XNFLQR0EsQ8odoN8WVXyqxxbE5/IBtTyU7pElm/M/W8nTbY8lqX7sw+S/FmgRj8ol3Y6ewJFEZyMaXD7oeGgbcTvjMV8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868349; c=relaxed/simple;
	bh=jfyUSmubMj4b/gkkdGyIXgcZf1BpJ5K73ybeRlCwDBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPdsldiFkbQ4S82D3fP+mHjOf1eFHpu17SN0Ebd9zPFVTefiCvOomH0Pn3ZkSiZviJG4WmXlotr1Lq6kAoFiORvUcFk2JZfoM07J+4AJDcguZ1up4vI9W7100Z3h3qFL1c+yGuWyZ1WS3Jv7XFbjD6ExXWWVmhqLiS0lj4NHYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rDXiFPQ9; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d89a727a19so905196d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733868347; x=1734473147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60R1hVTxsjiamUbrEoUH7TiaG7L9jG3XfbmxuhEpKo4=;
        b=rDXiFPQ9qVwB9tFaE6PvzGPx5pe+d4rZHBH72PDtHEZVLyiHNeKw+P0dsgRk+D/C3E
         LPn6R0SkxWuBpr9Ip0N8VXTVlwkhqi4lJ/6mJnIz1yOTTDWqLEn9+yvs84cCm03CXgTC
         NsAhn1o7Ap5Jj2gE9M699fPZEC4FLo4nc2+o4W+tiLNMtxTErqNYZJvHdszhTnn12FC6
         U2+6xnCa+WZyAgy8pdYrBgmsb4+kvTCvMOE9lzJ8xV7HpMgHyPqkk9VWfmPMctRFV+N7
         Sd3CKcn4efBSHS+qslJfFjQSpwW2XG2+31v5kDRzzLQXvcvpKop8gFXtMn7ldYB07uuz
         NrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733868347; x=1734473147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60R1hVTxsjiamUbrEoUH7TiaG7L9jG3XfbmxuhEpKo4=;
        b=L5HUUrZQ+/019setFN4HBH7FJQq0ksPgZlXIWJSpd1mCUDEXtS6Q08gR4GsXGjy2mH
         80SmHL8SH/oaZpw3dIBYoK7DsMN3pbBnsSRxwqaJX8CGBd/EZSOjQkND8VC4mCcSyhDt
         ccsf7rnVqIAoHgd/TUevagG6wJ8hXg3912WuBq/7lMbfgd97m7XG8JsLNzyMJA7jXueK
         Fs3e0uDb9J16mYViEXuLpX6cMBgMCChIChZOcp0Q0xKhefPYPKjKhKdf3lfb37Bxx09v
         Mg+SLcNjsQNmS3SF3eW8MNDaFlwl5cIEwAmqHqFYvkxmOrQs4AUCh0ZFwj3jifMKNTm5
         iFGw==
X-Forwarded-Encrypted: i=1; AJvYcCV8+DmpX7VPzq8jJJxsxOpx8G7JjeUb4BxqIqDN/zBJNWOcgFsLccx9ejh3lXPV1l1QnbZgv+8wFX3is48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPAOT7/VSsuZged3UjfMLkMRbXfINF7ApRjGVtJqcvPMJZXJJu
	h0Z6s+2Z+z3FK81a1tml6iyIj3X0jerl1JeQsDzItNDQg/ZL0RwWIQ/f102FEX9XxbWwk9wlDp8
	n
X-Gm-Gg: ASbGncu9XCLWPNxcM2Nfm4m1SGZ9TALV5Wgd69dk1QbsMXF28BcdVXqX+KMQCkp+PDt
	BWcQV4LkQJ3itCODk1VevhLTyMNfI1V2rZMqCnGSsf/XrrwSEB5lVl++J1JeG+cWr9jfYedUVvl
	rsePHBSi5boyf95EQnt7/nglWPzVTpL/eQsoECkXcv+TsaT6b7Xmn5OAswY5JsgTvHmAnfdruG9
	Jk4pEoxan8yOGct+k9EfSE2srjOs9R1HoyxL/+qzo1JBjsF9l6WeMlcRu8VLwCtRD4BGBDvPhnW
	SwgBB7JeKBtQ9cqYhqkyBLI1EDQZO8xIfCTpV28=
X-Google-Smtp-Source: AGHT+IHc57rNPDT3ETou4ayUZZMOYLv4oTDJ4vzRb5FMnCPekUkkWfUgKrPMA1hVHVlHX0Bm8hfnCQ==
X-Received: by 2002:ad4:5de6:0:b0:6d8:f50e:8036 with SMTP id 6a1803df08f44-6d935314e21mr9170026d6.20.1733868346746;
        Tue, 10 Dec 2024 14:05:46 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8eeb132e1sm49707756d6.35.2024.12.10.14.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:05:45 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	osalvador@suse.de,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v7 1/3] memory: implement memory_block_advise/probe_max_size
Date: Tue, 10 Dec 2024 17:05:15 -0500
Message-ID: <20241210220517.3744-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210220517.3744-1-gourry@gourry.net>
References: <20241210220517.3744-1-gourry@gourry.net>
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
Acked-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
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


