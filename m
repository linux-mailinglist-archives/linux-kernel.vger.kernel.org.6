Return-Path: <linux-kernel+bounces-215402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FE9909237
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8411E280C10
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4211A01D6;
	Fri, 14 Jun 2024 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gU/7VymU"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ED719E7FE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718389443; cv=none; b=tfjoJozaNmc/F3mz2uGyz9c1VI0oMIgLiaV7ENZXsO++6Fp3sP1l53v91nnJ1Th0vaGg73bdGhneVWupr8ErMk9iMmSnjzmhSsc+hz9lr5sxHzOJMW3z7W1iZ65yHex39UTjFhFxeAXIEKgFe63VsbsYkrcomRBjHgGZWWj4uDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718389443; c=relaxed/simple;
	bh=UiXFJ8pa0mlV/npeoh3CFJYXYDs7ONLuEzzjS78YDTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKY/8UgAyqGXAN6i4T7yb1ujyV1lGX3TE2gOT+wGXg6R6krdT72PItCveZLs4iTvbrTfo9vha0x5AjW6r2PvipO3FeWzISzn5CNizt/ZGD1u2F3U4Got9sx+/tl+pBoI1F3Gk/00E3n9ZkEhD08H04J7PUIUDSnu2S+RGhQ7Jz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gU/7VymU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6fd8506a0b2so2004046a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718389441; x=1718994241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVHZFIyiPWaIjhxXT8vFMd23GY5cZ8Wtr6v4ExnEFT4=;
        b=gU/7VymU3rGcIamGmV8JJUy2NJntp4j5ekNEDfg3nEkXNoCTW01iR+4unOPBnh+8i2
         7OsxFXEW7qg7LfNgQTntTbArQ322mNlcvXS6SZ9V1EmQBIDo5CBLRZcQ7yGTMuDCOn2M
         /0UAHQUMWjwZKVtsgLZitXbN1euF2eUE0jdwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718389441; x=1718994241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVHZFIyiPWaIjhxXT8vFMd23GY5cZ8Wtr6v4ExnEFT4=;
        b=kHDF06Dgne+qExWecReHp1aDv/96j/n0Ln+UBaGVp/QWEFtxZ1inTDa32DxW3w7Okj
         EEYJ7Vu9lJJrJjF+jXBoqeL7zqBV/1kFch+2eNJuk0qXdROiBr1UTwgWqYL/jovZC1Xc
         l3SlrpHaXqtds8P1YUwlXxEIVWbiaWOS5pBFX4D8JrtN4UKut8nqdOo38mDIXmhIRSRi
         63RlkrwnBNdQ+cjDHx0lCzzZ6Q6/cgoVjQfBY/04lEZ5LuyC+a24brXtDDuC4TYfpBqU
         c7qGtvv88qDdTx5uS0PX/F2NruTshrJZ9Z8eK9ix+IBW2+G32Hbqrl2pRxPNCVzpzhr3
         6f1w==
X-Gm-Message-State: AOJu0Yx8n0ZFTZllaBcXfpS/JdjOUpQOo+/lscnonLDUAcyc7AMv1WuN
	c3X4NbxNpHMy3eTUZGEkuvPpnMn14AI6AzsXRjSDXuuYFda3BcGjgs24XvaDqw==
X-Google-Smtp-Source: AGHT+IHGY+/B1ncUMFBE/3CojUtQT1wv0qbtFEgFQVZatzHMVqfYLbr7b4a6VgXLaakYnYqdtomNQA==
X-Received: by 2002:a17:90b:4d8b:b0:2c4:aa67:895c with SMTP id 98e67ed59e1d1-2c4db242648mr3495956a91.17.1718389441185;
        Fri, 14 Jun 2024 11:24:01 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2c4c466c3desm4234620a91.46.2024.06.14.11.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 11:24:00 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	jannh@google.com,
	sroettger@google.com,
	rdunlap@infradead.org,
	david@redhat.com,
	adhemerval.zanella@linaro.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1 1/1] /proc/pid/smaps: add mseal info for vma
Date: Fri, 14 Jun 2024 18:23:27 +0000
Message-ID: <20240614182327.752156-2-jeffxu@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240614182327.752156-1-jeffxu@google.com>
References: <20240614182327.752156-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add sp in /proc/pid/smaps to indicate vma is sealed

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/filesystems/proc.rst | 1 +
 fs/proc/task_mmu.c                 | 3 +++
 include/linux/mm.h                 | 5 +++++
 mm/internal.h                      | 5 -----
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 7c3a565ffbef..400217a1589c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -571,6 +571,7 @@ encoded manner. The codes are the following:
     um    userfaultfd missing tracking
     uw    userfaultfd wr-protect tracking
     ss    shadow stack page
+    sp    sealed page
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6ed1f56b32b4..ba2db75ca22a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -711,6 +711,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
+#endif
+#ifdef CONFIG_64BIT
+		[ilog2(VM_SEALED)] = "sp",
 #endif
 	};
 	size_t i;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 587d34879865..8600564898fa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -314,6 +314,11 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
 #define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
 
+#ifdef CONFIG_64BIT
+/* VM is sealed, in vm_flags */
+#define VM_SEALED	_BITUL(63)
+#endif
+
 #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
 #define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_1	33	/* bit only usable on 64-bit architectures */
diff --git a/mm/internal.h b/mm/internal.h
index fd68c43664d5..72f7c110d563 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1509,11 +1509,6 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
-#ifdef CONFIG_64BIT
-/* VM is sealed, in vm_flags */
-#define VM_SEALED	_BITUL(63)
-#endif
-
 #ifdef CONFIG_64BIT
 static inline int can_do_mseal(unsigned long flags)
 {
-- 
2.45.2.627.g7a2c4fd464-goog


