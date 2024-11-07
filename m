Return-Path: <linux-kernel+bounces-399302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E919BFD29
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BB8283590
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E71E18E762;
	Thu,  7 Nov 2024 04:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ol9i1I2F"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0739E192B90
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730952189; cv=none; b=ngUR76YDaFBJ1tyDomu0PHdDveOcqWQ7CfkiPiLx4HWcV6c7zJf7262xfYT7wM19GoBsvYWcuerqyAn7gA+UvsQOsOJvqMFA3Kql662mxMikZrQdaC3BcWiuOHDQdoMs8yjTBlYExV0+11gRvbRbbjVLUc2UmYTdwBHXl+NpTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730952189; c=relaxed/simple;
	bh=noVMPsxz7gnOXfT074HrLmzedzvtN+Mhx45a8w5ZR2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NKfhp1+ckMEymoTPFwFH8pIaLOybBp1dopick6FIDxf7VNr/Tqbytyq5SlIOXtyPHoU1aNhQM49AaZqqPW5w/lcmA7G0yPIe4ry4VnqdYsDDpUBFQ/ftAKmQ6p4JORtjYGxDMI+OeQiVznTd0wpQL36thzyWeasGTF+UuD5vIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ol9i1I2F; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e2d17b0e86so583204a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 20:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730952187; x=1731556987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OGsgJ8yqUfMcfrrc0Lq3bkxwEd6Y6CbCViBngZVv6No=;
        b=Ol9i1I2FNSygaO/eo+ni0bDvdFW3jN8T+XxWpG6WJ9VKSJNiB2/tDPRvIeYJmSPqQv
         7CCQGq7zCnq1i19Ui09rveJtpMyNH5LzilA5T2FoJUoYCHDakXVqN7R9+4+BOdq1YJ9p
         +9fLBJbpQsDlWr5HPZ9ggx1xAN3lGysHicmfY6bafPW9VxTs3t3Y33Ttum5++tLlI99h
         gqRszD6aGsbEL1iEyBs4IsKmymjqnnzeb/SpULNY5mo3wdcm7bxkkY+tN25KEqRlbHO6
         HtVWu105S0W8HpVVWtFQ+wr62+GyM1RSKAl4lWWFw2LANFtGWR7aUI69vK5mnjPvwl6S
         b7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730952187; x=1731556987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGsgJ8yqUfMcfrrc0Lq3bkxwEd6Y6CbCViBngZVv6No=;
        b=Fu+H+r5PPEx1w6eUD5DBfFzRx1Z3YgTQDChrYNGR43L4/9uJvMKJYunkTp0UipkAwP
         WBKZ4OutHEiwjSM129n8Jl1KRZD6+3ge0sHZ8W11nctmpWhvGWlNY8DtrVLaiKlaURDd
         O1JosUqwojKnXiUfg8s2dNT4JaGD0o0ACt+EGZnRudnIYEKKBd4z3+UEQmv2/f/KSj63
         WTHet2lErrRdVrFPVvHOtEzL3me4PMe3TBPvOOH9OdCS8r0WkZ7vD8dVFJfqvflm/3nt
         JTLA5EdZGaytZPrhz5FhjyKas7L6bGqBVJ8A3p1w4p+Ai5uSkFB9HWgzUDw/OhJFiu26
         Bcww==
X-Gm-Message-State: AOJu0Yx++s0gXbmlv6TXg8ZCRdjQ4RCvmSdCocyIjnq2Lr04b83PKRgh
	NXCIEjEKsnG5BLVG0Z6OjPenUzMKEBdzsInyJIvjZzUScw9wRw/XVw+92bLBQ+bju3k4EDk4bqB
	VOS+D2pqdwQ==
X-Google-Smtp-Source: AGHT+IEHzYzkFFvY5RxacsZqR/q0S6nuas6iXnNgQiyipYj7bpf9h6nCNhyvxpHxdYsNcHxkK1ASq3ry6j7Vyw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90a:708a:b0:2e2:c183:8b1c with SMTP
 id 98e67ed59e1d1-2e9a7695607mr4190a91.7.1730952187278; Wed, 06 Nov 2024
 20:03:07 -0800 (PST)
Date: Thu,  7 Nov 2024 04:02:28 +0000
In-Reply-To: <20241107040239.2847143-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107040239.2847143-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241107040239.2847143-7-cmllamas@google.com>
Subject: [PATCH v2 6/8] binder: remove cached alloc->vma pointer
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Minchan Kim <minchan@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

All usage of the alloc->vma pointer has been removed from binder.
Instead, paths has been refactored to use either vma_lookup() or the
alloc->mapped state. Using the alloc->vma was unsafe and required the
mmap_sem in exclusive mode, which caused several performance and
security issues in the past.

Cc: Minchan Kim <minchan@kernel.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 14 --------------
 drivers/android/binder_alloc.h |  3 ---
 2 files changed, 17 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 7239b92ef20a..13b476cc5b62 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -377,20 +377,6 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
 	}
 }
 
-static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
-		struct vm_area_struct *vma)
-{
-	/* pairs with smp_load_acquire in binder_alloc_get_vma() */
-	smp_store_release(&alloc->vma, vma);
-}
-
-static inline struct vm_area_struct *binder_alloc_get_vma(
-		struct binder_alloc *alloc)
-{
-	/* pairs with smp_store_release in binder_alloc_set_vma() */
-	return smp_load_acquire(&alloc->vma);
-}
-
 static void debug_no_space_locked(struct binder_alloc *alloc)
 {
 	size_t largest_alloc_size = 0;
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 89f6fa25c670..b9e2e9dc90b3 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -61,8 +61,6 @@ struct binder_buffer {
 /**
  * struct binder_alloc - per-binder proc state for binder allocator
  * @mutex:              protects binder_alloc fields
- * @vma:                vm_area_struct passed to mmap_handler
- *                      (invariant after mmap)
  * @mm:                 copy of task->mm (invariant after open)
  * @buffer:             base of per-proc address space mapped via mmap
  * @buffers:            list of all buffers for this proc
@@ -86,7 +84,6 @@ struct binder_buffer {
  */
 struct binder_alloc {
 	struct mutex mutex;
-	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	unsigned long buffer;
 	struct list_head buffers;
-- 
2.47.0.199.ga7371fff76-goog


