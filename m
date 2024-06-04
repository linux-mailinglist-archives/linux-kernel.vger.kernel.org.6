Return-Path: <linux-kernel+bounces-200325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257F38FAE6C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F311C23FFC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F01A143895;
	Tue,  4 Jun 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dmwAWrFv"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02BD145A14
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492169; cv=none; b=kK4p++bSl/BCD/iHhTkQASVq9giBIHdMjwd6MJW7nX6lCn/VFe6X8LMObbIhx9zsVrAd3unbhv+2Del8iEfKVmscFFpmffdVLwENypaqmit122COlV+63wWrZdiD4Byyq6b8VMJKz8Pp/IFv8YVW9n1//VEcKDH1wLFy0fMW08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492169; c=relaxed/simple;
	bh=HD/XTIQjEizEu0O4MOPQDcGyqhajbjK+uDvPpK4p2jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SsqlqXQrfN9GE9iyIn8BcRc77N9tnLCJ+2+5OVi4YvtEMv6bH7qjYRna3TnW07noO37T6n4YJL0yWpddUsJb8CH0D8bBGxVR1lzyWG/90c94USwh6XSDv/aPlxbPjsacyjKHHloMT8PzKIFZ/SkjXX3KKsDEKJeq8swsHk82rPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dmwAWrFv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a7dc13aabso850991a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717492165; x=1718096965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i89wEAwGLV+FFt8LVEfujtav/wRlt8aIRY/CjDWyxYI=;
        b=dmwAWrFvkCM29wyBVVBcY6ITOhiCvnXkhdkN8fMYSQoSPlik7Sai9Vd8rrxy/FrnHV
         m3VrLVGlqFzGRj8PTJggPT7QDSurjqMXgla0/Fq4JJZrzT+V6TK8s0ze7PsAaopsqzwI
         GXLG0/rYizSaOZ4lsefcNpg7mXtY5LigBC/XJTvl2nM5qNgV08yOOzTdb01fEIMjV6Hj
         hQLE6SnzMdk87WMpazTU1b7RxOzN9kL7QIrFHA35HPDDfwa8dLe2N7BzqONtlEWC5VhU
         8p/QWK366aGz36tYgONqgYvpIm5XEgtN+VwKfC0dXMyZiWXyMj8C/RFeYDdBHohQyb+i
         WtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492165; x=1718096965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i89wEAwGLV+FFt8LVEfujtav/wRlt8aIRY/CjDWyxYI=;
        b=X7R7zvMQ1ov+/48uldsMAxpN9ZqGCwoH8VlcV9d0ASxQ1H93ipUwOqfNI1THMGEZuA
         vJUAOlCDzANRv2JpSBVmhq+5+HFdKKTqrThiJnBN3iEbR300mSZvlmYY+8KT447AHcJo
         Ix/HhmeT42s6d70SjRCj5XHPLMWMjAD5qNkroWw1kvO2PDYUKUy4RBA+9vzaBmEm7KS+
         SRs2eWmeow4ssk0s32hK9X98rNxeyIit9WjRHyBbOqq3Sc5ho8eP1snv/mF5FX4uPguT
         fc6kyXaVbUQLLx2oWU66Sp5Fi2iyZtPaGSIuVZrNHKvFZNVRPg8I+Fbizse1hg/wacuM
         CnAA==
X-Forwarded-Encrypted: i=1; AJvYcCWmpSfjoSWSr7OOkOY1p4KfpS9ljcjz3z+fm/hpkozmUZXItSE0cIcH1x6tY4W2mK9sO6bVOhvTzI1XA0SuCLLhWTAAaanhFRTL1jSi
X-Gm-Message-State: AOJu0YzmOkpxWgb2Oxi7wGro7TgP2XCZbcdHKqY+OK+69C1CDzewNuod
	z1vhwPGD3D2V8oIfXL9aUgzeJeCScEDB0ZPN016pdGeLcQiNlHu3739xoO0mr/s=
X-Google-Smtp-Source: AGHT+IEEQrB10Ia4g3WkoPKh5/jpdFJJpYBOp5KDOiMCUB9VjtT3LFxj+J1ilVV1yreFVtWqt8rEuw==
X-Received: by 2002:a17:907:970e:b0:a69:228:8a6e with SMTP id a640c23a62f3a-a690228939dmr414530066b.44.1717492165278;
        Tue, 04 Jun 2024 02:09:25 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm328376766b.129.2024.06.04.02.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:09:24 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	david@redhat.com,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v6 15/15] include: reduce dependencies on linux/mm.h
Date: Tue,  4 Jun 2024 11:08:45 +0200
Message-Id: <20240604090845.2182265-16-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604090845.2182265-1-max.kellermann@ionos.com>
References: <20240604090845.2182265-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace <linux/mm.h> with the smaller pieces that were just splitted
out.  This affects a few headers that are included by many, e.g. bio.h
and highmem.h, which now no longer depend on the fat <linux/mm.h>
header.

For this, several missing includes need to be added because they are
no longer indirectly included, e.g. <linux/fs.h>.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/bio.h              | 2 ++
 include/linux/bpfptr.h           | 1 -
 include/linux/dma-mapping.h      | 1 +
 include/linux/highmem-internal.h | 2 ++
 include/linux/highmem.h          | 4 +++-
 include/linux/net.h              | 2 +-
 include/linux/oom.h              | 2 +-
 include/linux/pagemap.h          | 2 +-
 include/linux/scatterlist.h      | 2 +-
 include/linux/skbuff.h           | 4 ++++
 include/linux/vmstat.h           | 3 ++-
 lib/scatterlist.c                | 1 +
 12 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index d5379548d684..ddb0c831557b 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -5,7 +5,9 @@
 #ifndef __LINUX_BIO_H
 #define __LINUX_BIO_H
 
+#include <linux/fs.h> // for struct kiocb, IOCB_NOWAIT
 #include <linux/mempool.h>
+#include <linux/mm/folio_next.h>
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
 #include <linux/uio.h>
diff --git a/include/linux/bpfptr.h b/include/linux/bpfptr.h
index 1af241525a17..19967a0e510c 100644
--- a/include/linux/bpfptr.h
+++ b/include/linux/bpfptr.h
@@ -3,7 +3,6 @@
 #ifndef _LINUX_BPFPTR_H
 #define _LINUX_BPFPTR_H
 
-#include <linux/mm.h>
 #include <linux/sockptr.h>
 
 typedef sockptr_t bpfptr_t;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f693aafe221f..5a66ade2ddf8 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -11,6 +11,7 @@
 #include <linux/scatterlist.h>
 #include <linux/bug.h>
 #include <linux/mem_encrypt.h>
+#include <linux/mm/vmalloc_addr.h>
 
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index a3028e400a9c..a479e6b7c54c 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_HIGHMEM_INTERNAL_H
 #define _LINUX_HIGHMEM_INTERNAL_H
 
+#include <linux/mm/page_address.h>
+
 /*
  * Outside of CONFIG_HIGHMEM to support X86 32bit iomap_atomic() cruft.
  */
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 00341b56d291..10a165a913ad 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -7,7 +7,9 @@
 #include <linux/bug.h>
 #include <linux/cacheflush.h>
 #include <linux/kmsan.h>
-#include <linux/mm.h>
+#include <linux/mm/folio_size.h> // for page_size()
+#include <linux/mm/folio_usage.h> // for folio_put()
+#include <linux/mm/page_address.h>
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 
diff --git a/include/linux/net.h b/include/linux/net.h
index 688320b79fcc..481fd7e831af 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -21,7 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/once.h>
 #include <linux/fs.h>
-#include <linux/mm.h>
+#include <linux/page_ref.h> // for page_count()
 #include <linux/sockptr.h>
 
 #include <uapi/linux/net.h>
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 7d0c9c48a0c5..518426e092d0 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -8,7 +8,7 @@
 #include <linux/nodemask.h>
 #include <uapi/linux/oom.h>
 #include <linux/sched/coredump.h> /* MMF_* */
-#include <linux/mm.h> /* VM_FAULT* */
+#include <linux/mm_types.h> /* VM_FAULT* */
 
 struct zonelist;
 struct notifier_block;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8f09ed4a4451..43e233c998d2 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -5,7 +5,7 @@
 /*
  * Copyright 1995 Linus Torvalds
  */
-#include <linux/mm.h>
+#include <linux/mm_types.h>
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 0516e64dc03e..9221bba82b23 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -5,7 +5,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/bug.h>
-#include <linux/mm.h>
+#include <linux/mm/page_address.h>
 #include <asm/io.h>
 
 #ifdef CONFIG_UML
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fe7d8dbef77e..09d020d5a6f4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -16,6 +16,10 @@
 #include <linux/bug.h>
 #include <linux/bvec.h>
 #include <linux/cache.h>
+#include <linux/gfp.h> // for alloc_pages_node()
+#include <linux/mm/folio_usage.h> // for get_page(), put_page()
+#include <linux/mm/folio_zone.h> // for page_to_nid()
+#include <linux/mm/pfmemalloc.h> // for page_is_pfmemalloc()
 #include <linux/rbtree.h>
 #include <linux/socket.h>
 #include <linux/refcount.h>
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 67c2505d3b78..b9ad7fa932e0 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -4,7 +4,8 @@
 
 #include <linux/types.h>
 #include <linux/percpu.h>
-#include <linux/mm.h> // for folio_zone(), folio_nr_pages()
+#include <linux/mm/folio_size.h> // for folio_nr_pages()
+#include <linux/mm/folio_zone.h> // for folio_zone()
 #include <linux/mmzone.h>
 #include <linux/vm_event_item.h>
 #include <linux/atomic.h>
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 7bc2220fea80..775bad99fcd9 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -9,6 +9,7 @@
 #include <linux/scatterlist.h>
 #include <linux/highmem.h>
 #include <linux/kmemleak.h>
+#include <linux/mm.h>
 #include <linux/bvec.h>
 #include <linux/uio.h>
 
-- 
2.39.2


