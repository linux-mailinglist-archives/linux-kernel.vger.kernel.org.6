Return-Path: <linux-kernel+bounces-215594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F09B9094BD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02C41C21196
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FF218F2E1;
	Fri, 14 Jun 2024 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kyqvEup1"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88667188CBA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718407223; cv=none; b=fN6FYczjVg3nFqBberByCFoEldufHGqDpGuJioaKXRWhAQpZzzGwr00/uZt1mBtdb5GA83IU9bfs7IdiQ/IU/y9bijiuJ7QMLNZ0tr8ctQRMnuJVqxOQPw48DaTibjE5XX4Ok1gJ7VqCMmWL4LH4dHfEwjSfbK45r2ftvl98CLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718407223; c=relaxed/simple;
	bh=q+6qZrb3RdoangQKqi6dIYyRHARSJeq03WZY8KBQenI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFosxoCbA9z0oFdBI3kI62ob1P+r7YoNksqjbn0v+JmxDnrpE3DxlsnRHqbG1d+ZnzH6iFGwEWT2NxEPaHgv3IRRx0iF2aHUQYX/iAiaPGFRzebKeSyiJbAwGAaD02EBI9lcbj4kkDYPT36N1VdgV8bIyXtibXCQfhsmh1meuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kyqvEup1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70109d34a16so2424863b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718407221; x=1719012021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sKXX4VALlpzvd31iPrb4eMztLZWEFkwR52gFSz74AM=;
        b=kyqvEup1hfHQXl0fB+Vrn5StarmDg7WBGkw35cOtFN60VuBSPa0ZZkq7Y3//qpjMOW
         cefXX6LZQeiZlgag1rk+IxcHN3fkLP/WcE5IdhlGE5+SFi94ZV7zvNzExTIMnhHmaV4E
         GCu+RKzjZCOP3ABW6SSEpbKCMszV/bfgI4dKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718407221; x=1719012021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sKXX4VALlpzvd31iPrb4eMztLZWEFkwR52gFSz74AM=;
        b=S7IketRc3x6L9SaeSfpqeEhe7oYK1fk7jiWKpGT+F6tZMVysgdnLpGUFrHWrCihUdl
         SbrZbO7FSSbdmH6NN1VA8OrBE8ufDZiUHe7rxZzwRZfeL/OPBoEbxnOoACkK5qBn62tP
         RgQHiV3N4bO0vmSe9gZbMzxM93rViUFLtSKDtnm6ctPCa6YwRtMuFUAh3KOuhoETSjzY
         oDYIBqMBqhQvjhPycntXimBkP+aDeDyXBfYquLrWA2eZHkXrZYbRFVgHfhLdR3GvJqcY
         rh/Ozw495RILHlRjILbv7xEpBiwzA1Xd+nGNzYyTWf0YyxlxC7Uui0Yx7vVjB1GzKll5
         8q+w==
X-Gm-Message-State: AOJu0Yz4CQMk9yS2c+E4vndRTZNV+JhCcv9cnxCJZYfPmeMzufgJtJTp
	gJuBMmvtLKTMv4jFnvbJ0qbIW3yxnSaX1eG44K88YsXvl68Uz26mtpbfCDljEP32jEKcWelMGmY
	=
X-Google-Smtp-Source: AGHT+IEaKtIKsVDOYcOmB47qgVisOpqhdKsdmoxHcr8Lwv42IwYY08IPuEJQDEoV3VsClwjTqs1o7g==
X-Received: by 2002:a05:6a00:1888:b0:704:b8c0:42ed with SMTP id d2e1a72fcca58-705d7144e01mr4910662b3a.9.1718407220764;
        Fri, 14 Jun 2024 16:20:20 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-6fee39bb90dsm2698718a12.77.2024.06.14.16.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 16:20:20 -0700 (PDT)
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
Subject: [PATCH v2 1/1] /proc/pid/smaps: add mseal info for vma
Date: Fri, 14 Jun 2024 23:20:14 +0000
Message-ID: <20240614232014.806352-2-jeffxu@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240614232014.806352-1-jeffxu@google.com>
References: <20240614232014.806352-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add sl in /proc/pid/smaps to indicate vma is sealed

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/filesystems/proc.rst | 1 +
 fs/proc/task_mmu.c                 | 3 +++
 include/linux/mm.h                 | 5 +++++
 mm/internal.h                      | 5 -----
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 7c3a565ffbef..82d142de3461 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -571,6 +571,7 @@ encoded manner. The codes are the following:
     um    userfaultfd missing tracking
     uw    userfaultfd wr-protect tracking
     ss    shadow stack page
+    sl    sealed
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6ed1f56b32b4..93fb2c61b154 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -711,6 +711,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
+#endif
+#ifdef CONFIG_64BIT
+		[ilog2(VM_SEALED)] = "sl",
 #endif
 	};
 	size_t i;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 587d34879865..84c4cc7354b4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -406,6 +406,11 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_ALLOW_ANY_UNCACHED		VM_NONE
 #endif
 
+#ifdef CONFIG_64BIT
+/* VM is sealed, in vm_flags */
+#define VM_SEALED	_BITUL(63)
+#endif
+
 /* Bits set in the VMA until the stack is in its final location */
 #define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
 
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


