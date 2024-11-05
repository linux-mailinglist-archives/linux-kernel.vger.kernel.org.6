Return-Path: <linux-kernel+bounces-397079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C489BD672
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D89B1B221D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43802161F0;
	Tue,  5 Nov 2024 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1e3uYa3B"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7205214429
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837002; cv=none; b=uLU8PVcemwCpyH5QOOX2VZL3aEtX/zkLeiMoUcVnCOppI9gmS44qmZlAyu9MMHYLuqH+l2Dp8PF0QZbk8r5ySjMlSVgC76vLwX/QZfNfjBjT84tuYo4nSyfgyWoMFVrJg7U/CCmkmWvRzrPCV3ffOM4eNE6Gv7isYXwg2Bqft38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837002; c=relaxed/simple;
	bh=ByO9EbBsdbo8f4wzbHz7U6PsYIGoUUKB+DY0NL86V48=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CIxHmS9iCHib+dkrqu5M2vtwqh6ZKVu9RR4XrLhwcEVb3bwg0SdnwLnLKoAz6x2pF23X4xEEDeEHhsK2il+FDgKiil/4tlNNK0qLDDXtpW/pErEB/qIeVUUbE/L9GKQqvv0HhA03ztJC4vny3TR8PvtsWrhOJfG9zERTJtAOJMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1e3uYa3B; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72065695191so6218311b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730837000; x=1731441800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q5v3+KfpfwdILNkg4koDdfGwqNcMD/SqajiCjPCWk4k=;
        b=1e3uYa3BXVaD+hHEWsXPOMgxdJ1JWyKV5bcrVxohpnAsWEW5fu+NE3iQiO3aA2fBdm
         wCg91WXAMSCylw2vynQM+HQHWoaZ/fiDyQcaUWiJISfhRdJUpyr9bukrM9jKpvVopuf5
         k+EM6LRcd8BhwVm4vDtGN4OUoXwcReHnHowK/uclEqig9Rwa7KKyqN+0ig+NF3vGwmXH
         3O/DIqAtDP4WSFb6yePrO7xnsW7b1Nvcncgt1PtMrMUzrEtRFv6cUeBI9La8wzjHyDGy
         eSKEcj0uF2tAurkx+B/P3duIVdckg2JQYSLPLIhSh67vTzZPRQ4QX/D+/jA1SbP6Pc/r
         gj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730837000; x=1731441800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5v3+KfpfwdILNkg4koDdfGwqNcMD/SqajiCjPCWk4k=;
        b=GEd910PTGQ3wffbb4NUwIdT6fG4GnztxuZLJfS8C63gT4VpyljDZ4oMGoKW5vhq+Ja
         X2Q+aqCmuk0o9JFOmfAsnaZ6ftde6qlgv7WVuYvrBTUG7fZ14Sgi68Te3CjwYmZsBzsf
         eqAgAl2vOUzOVbcb8smjn/mbevrm2k0SYe2XFxDAELOZOZFAK1QlFLCgZEJgLtOCR1fG
         5xdKLHAFL6ld4Ia+cWLaOv7W0IuCwf2eWCll7YX9qjZ06ONZtWmbu0x3O6udMsFhykXC
         YwYjLdzMWLcvVahl88vX3Gm+yhk0KxypLyCB5NoMWdEY6njm5tPc+z10QwO1wvQEfn/C
         l9XA==
X-Gm-Message-State: AOJu0YzcLnoyasArJ5PiZdlZqhU02p+hZGh2871IEDlaTrNKlG4FbkQ1
	HKKOETeATB8F4aSG1OAeUH2z1FD6Suj/n6RzsScFAnzAczyzlNLTpUImYU2niJOM/7yaPkUiLsv
	wuPqJPxdZJA==
X-Google-Smtp-Source: AGHT+IHfFpQRhSgwzNc3hWaihNKT1tw5eG3qTrjyrfrYDChT1ZCVMccErN3lVms4lIZml4bMQXPrb0Cq8Vui4Q==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:8b87:b0:71e:59e7:cbe2 with SMTP
 id d2e1a72fcca58-72063078393mr53593b3a.5.1730837000021; Tue, 05 Nov 2024
 12:03:20 -0800 (PST)
Date: Tue,  5 Nov 2024 20:02:48 +0000
In-Reply-To: <20241105200258.2380168-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105200258.2380168-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105200258.2380168-7-cmllamas@google.com>
Subject: [PATCH 6/8] binder: remove cached alloc->vma pointer
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
index aa299cbdab92..a4b7bf8696dd 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -369,20 +369,6 @@ static void binder_lru_freelist_del(struct binder_alloc *alloc,
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


