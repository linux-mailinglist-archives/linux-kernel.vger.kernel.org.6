Return-Path: <linux-kernel+bounces-387586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C45939B5345
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549B91F23EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C473207A1A;
	Tue, 29 Oct 2024 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qnBfIcj7"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22392076BB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233248; cv=none; b=kQtBwhlaU5ANeXLfvXRX/JBKIUjYs5LWv8ONAzaYT1k99qu6gs6oaEarlaYTQW+oTLHwpIQ8ysRHhVaE0ap672QJNNqhgWhb3h5IVsc5tIu2f9BLjLWYF6s3mRN9hpMi9r5kPupxH5DS0DqSZigkclT975LsXAIXaDljR3QbJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233248; c=relaxed/simple;
	bh=BazxSNmpxlGCpFCf1Hx0SRVIOcK24C2uL40XGo91tgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgnGwVcElf/0NvmEWWbgiIaWfVt4grlrH5VhsZSoYUXZGBuXlqRXViWiryVIOwgTQ0OZCVmp5F+QUGt+aybj24hxIoyDJ3euetmmhaJL55OqlXoxEJT2M6yqo4VDxTwskZowSQbvX6CqGJWGJdpB9Wov741w+p+0rRbzStBjdp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qnBfIcj7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4611abb6bd5so35600231cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730233245; x=1730838045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYJpDly5fR8R/Ele1I4od50o5TfHJqlCfC6WSHHqe0A=;
        b=qnBfIcj74KvGuuSYTpl6qgwUxB8CAyOxj5LSm42MIybF9nTiY1TSTFxRlE6kD79fWV
         BhP+js5Qtm3cjQs4oQGrSqM/PyF9XnTBttWGI+kk1mEcREJ8abnR5EYymJmEv/Myd7JF
         HfHuFowNbjAKRbXKfh6L+L4DuB8mBtsvbnrRk/tqRgriFmAdEiDxVYMWYwPi9dW9RTRA
         Ya5dNmzJTo4rbmhoO5DKq5VteW1AzHgk8HDA0KY3kpVECt3aQGlkmrAEVp/SdYb7TDqn
         tyKL2RSNHJVS3y2esRZ4LbxF2+ctH7LJ1cZj+UNjlTFSNj4iU3WdobyZ4MC5JZcdWlaw
         YhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233245; x=1730838045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYJpDly5fR8R/Ele1I4od50o5TfHJqlCfC6WSHHqe0A=;
        b=CH96G7rM1Rf2Rjw3zYzNJIUtR+jVJEeYSdQk7wKMlgY82g4TTre8Vo0/qFu43x/L3O
         Ggdd/AAVEzxdk1Aqqc2P51V7YI124e2LdnwZ1dN02IOEqlr4qQgoUNjSDGrMZhdCNR44
         eCNGsomHvnnxeDrh7rWyO7rJCk/n0CPA1cbkDQ2Ilicto2D7OCN0ysk1285lPLmrKcKe
         Ztd0kuxMpVyYjSqELUBase122t6EgjNoIziULbx5U47FkN6ojvTezOsmDbvJoKME3yu7
         +FnryPmlbZPHIzXM6SvkNwk/bYQYEU4NqMjMUUqWE24Tv1wCaPQWbn2P1p6sNViAugx4
         xiMw==
X-Forwarded-Encrypted: i=1; AJvYcCWeJ1LpT8pvj2r9F3b2gHmCRZ9xEQ18GzfBM/hsUzhKMEQkfCnVPbtt+1YQo2+qjcK3p9sZXssp4Ws0aMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF3b4cshfrwF4T6g4ze7+6A4zfS8if6VN7PhbEUgZUlUJAjSRz
	R5LRTeGpKeimrG8em6DLvbFnRJvZckp6Kt00m+v0l4/Em2zbo5vs2wV6Xgw+QZw=
X-Google-Smtp-Source: AGHT+IFEYRquwMMLuxm/I3OurD9YlNDiDcPqhW8mBugt6yiiX34O6cvjwJwhU0+zT5zZPMP4mvN4Qw==
X-Received: by 2002:a05:622a:4a:b0:460:a287:2069 with SMTP id d75a77b69052e-4613c036755mr178235441cf.35.1730233244725;
        Tue, 29 Oct 2024 13:20:44 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798bd8bdsm45071796d6.54.2024.10.29.13.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:20:44 -0700 (PDT)
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
Subject: [PATCH v4 1/3] memory: implement memory_block_advise/probe_max_size
Date: Tue, 29 Oct 2024 16:20:39 -0400
Message-ID: <20241029202041.25334-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029202041.25334-1-gourry@gourry.net>
References: <20241029202041.25334-1-gourry@gourry.net>
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
---
 drivers/base/memory.c  | 48 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/memory.h | 10 +++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 67858eeb92ed..099a972c52dc 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -110,6 +110,54 @@ static void memory_block_release(struct device *dev)
 	kfree(mem);
 }
 
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
+static size_t memory_block_advised_sz;
+static bool memory_block_advised_size_queried;
+int memory_block_advise_max_size(size_t size)
+{
+	if (!size || !is_power_of_2(size))
+		return -EINVAL;
+
+	if (memory_block_advised_size_queried)
+		return -EBUSY;
+
+	if (memory_block_advised_sz)
+		memory_block_advised_sz = min(size, memory_block_advised_sz);
+	else
+		memory_block_advised_sz = size;
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
+size_t memory_block_advised_max_size(void)
+{
+	memory_block_advised_size_queried = true;
+	return memory_block_advised_sz;
+}
+
 unsigned long __weak memory_block_size_bytes(void)
 {
 	return MIN_MEMORY_BLOCK_SIZE;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index c0afee5d126e..07e20a77b717 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -149,6 +149,14 @@ static inline int hotplug_memory_notifier(notifier_fn_t fn, int pri)
 {
 	return 0;
 }
+static inline int memory_block_advise_max_size(size_t size)
+{
+	return -ENODEV;
+}
+static inline size_t memory_block_advised_max_size(void)
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
+int memory_block_advise_max_size(size_t size);
+size_t memory_block_advised_max_size(void);
 #endif	/* CONFIG_MEMORY_HOTPLUG */
 
 /*
-- 
2.43.0


