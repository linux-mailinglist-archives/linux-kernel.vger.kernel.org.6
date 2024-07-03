Return-Path: <linux-kernel+bounces-238615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5260924CE3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324CAB2278E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97C2184E;
	Wed,  3 Jul 2024 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVTnvFl1"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887EC1361
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719967925; cv=none; b=cS7NixFMbeObo55BiFAQ7yN51NbvvnKU6/fOrWQKVy+dPgqyi7NTeZyIhtsTOGoRqioS7t88HX3Fc+Um7GwZP6dt0PkW9AF/Krf+biCqwSK41+qyqC0l3K7kshdjapKv+xvFvtlBBOfytuQ2ckXal3KrwGplssPD9SORIH4CqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719967925; c=relaxed/simple;
	bh=ltUrQvMYkrnR2vxDcCFsmiZW/cAH8Io56cKxONvIX68=;
	h=From:To:Cc:Subject:Date:Message-Id; b=k0uQoYQq8Si/I6S7jk4Sa38+bNwjFkaAYpsW4S7Nog05PFqPvStl18pXtl5GkiHnEpYOQSvR3Aobqa9xcM44ZVWLXFj8bJ7MhEdJnQ2v0SsabrG0B8OOcqeRtP6KSGvRPcHfoIOYGPU1ipQPeS4SMipSParbd286tn9n2YgT/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVTnvFl1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab63so2851962a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 17:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719967921; x=1720572721; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MW3+KCt0VbfQ+K4lOyKJpNbWf1zA/bLKqUJGuJ8fH2s=;
        b=YVTnvFl1TVdMIMuZ4V3WjVlBy3g6PIw45PLN3LOG27H/GB69+R7SPXbVSgvTvO0VJh
         DiNrbwOfXnz+pKSYJOKoVfMGj6+G7GOoy2qwtF9wKCGxwa+SQZBUy525585poINyABAp
         I4Z8NYnrw9Y6PbDJNKpNozAWgTlFoXzQrNnK9roGlQZNDYXbNkWVRPauWfIaXKWjkk65
         ec0aEGws4XhCHY+Fhkso1qsMaEg6LWz3z1lIy3ej8vkEaL9xeZQV3cpDgT5xTOhctppv
         LYRopO3ePjoeq1hFxOuleV6kGGe5MaYZ2HgDXW/dJtGrPgwkzxyJCHt75RGhX/BYXTBs
         g9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719967921; x=1720572721;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MW3+KCt0VbfQ+K4lOyKJpNbWf1zA/bLKqUJGuJ8fH2s=;
        b=WQA9u+ZtyjF8XZhEABsj0KVHzJ1WSUG4iV6Q8cDg/MvD1cTH5LAOJNY1KOPnDkOjCY
         2+i6PcFcqgZdxXBy9WW+QwWjP7tvpVMJtq0yY/qAWu+NVJAmzLc5KLQyyiGXbpMfRyEy
         Mmg6T1x/PO9DaqHyNo0c9DRcql6tpi2Wy1f6uvRLv48QgmDQhzlyAmxNo9JNgw9bIhL2
         2SK34PygWXXsr8NS3MI7H2X20nSDYt0v3Z2bJn7zE7zyDc+wx1g6DhZq+ImPzCDDNYoZ
         OadOt2tl54k9zvzNHgx61dAsLDRRbj2J+abedGFNO5mm1morbaCmdiEQySaZouDvq+IO
         xOTA==
X-Forwarded-Encrypted: i=1; AJvYcCW74HQouzOxDVxk5LcXgQ1IHWFZeh4IIcyBlEHrAr6ZluPZrf6B1z51QNwhvInq3je2MFp1pSwQEWE92kgB9/99B25FgnEJD+/E3sfX
X-Gm-Message-State: AOJu0Yx+PcYnLr5p6oZ2qpECYHdNAy1R3TPN1VOHN6URWV4yfgXI6jh6
	rLM2JEFih5XE2iKSyUx/WeoaZf/o0S6yraXWrpu6ikMIDPK++4ZO
X-Google-Smtp-Source: AGHT+IHPI+fSwgtEknM8e9ynK8VNw85j/2JpMiCRWnR/STEydt2SSHaCpqYPTUArhwRPunkCPjM9FA==
X-Received: by 2002:a05:6402:27c7:b0:58c:8c06:74c8 with SMTP id 4fb4d7f45d1cf-58c8c067bb0mr639292a12.33.1719967920869;
        Tue, 02 Jul 2024 17:52:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-586132502ecsm6351257a12.40.2024.07.02.17.52.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2024 17:52:00 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com,
	mjguzik@gmail.com,
	tandersen@netflix.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v3 1/3] mm/memblock: introduce a new helper memblock_estimated_nr_pages()
Date: Wed,  3 Jul 2024 00:51:49 +0000
Message-Id: <20240703005151.28712-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Instead of using raw memblock api, we wrap a new helper for user.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 40c62aca36ec..7d1c32b3dc12 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
 
 phys_addr_t memblock_phys_mem_size(void);
 phys_addr_t memblock_reserved_size(void);
+unsigned long memblock_estimated_nr_pages(void);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
diff --git a/mm/memblock.c b/mm/memblock.c
index e81fb68f7f88..c1f1aac0459f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1729,6 +1729,25 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
 	return memblock.reserved.total_size;
 }
 
+/**
+ * memblock_estimated_nr_pages - return number of pages from memblock point of
+ * view
+ *
+ * During bootup, system may need number of pages in the whole system to do
+ * some calculation before all pages are freed to buddy system, especially
+ * when CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
+ *
+ * At this point, we can get this information from memblock. Since the system
+ * state is not settle down and address alignment, the value is an estimation.
+ *
+ * Return:
+ * An estimated number of pages from memblock point of view.
+ */
+unsigned long __init memblock_estimated_nr_pages(void)
+{
+	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
+}
+
 /* lowest address */
 phys_addr_t __init_memblock memblock_start_of_DRAM(void)
 {
-- 
2.34.1


