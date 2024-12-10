Return-Path: <linux-kernel+bounces-439741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 013A89EB369
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2385518842AB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC901C07DB;
	Tue, 10 Dec 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYWp09p0"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482561C07DA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841114; cv=none; b=Gqhaa4ZKEdYFaxxxEp4ZfJjUimv0jtbEB67oT/pQsqVqaoKONPfGcS3D5/EArIbOqs1xyBdLwFVcmnigKtNSPaiIw7R/ksjjRSqeip54sC/CasD/ED+o/uRO+63pGAO1RUOLARrVvxd4jmJ1KfJTEhDl9aTcTkT73IPlqS73cuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841114; c=relaxed/simple;
	bh=RPAX22n2S6+tLLnaPHMOwC8ALJtiHJFwY5JY+BrKUCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gc7DsiVGfci9a9xQcbNOygnHaJtScJCOVZJPNc7bZJmEIOfkDH1tQmdi7wdF46bvY8g5MIg1KgdtTjYGfO7cUk/4A+6YAqQ1rSLftHDQev65Z2kiskA0XEtDPkz6tzE5GYuvrssbpiTlUJH3/TdPr9EKhRBZvDGVTMdx6qE8E1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYWp09p0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7fcd2430636so4145727a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733841112; x=1734445912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ElcxclfcYlOMSELtXDxg5j/9v6WDvHeMeZCbap56uk=;
        b=DYWp09p0yf0O88y2YrfUhMV9BiPUu5Ic8QPqjMkuVWsqxQv2nPfZEk+n8DIZNcV5J2
         MiRMtW9UaZ0VKo7s72kyyHNmxX9J44agad5VS4rGznV+IWaERNk3YZplG5GYlNpnNtrY
         UWEjtVn8yycNuskyb/3Vr7wqF0x6PPJ4Yse/l2IgHrI+DDHRQ6L/tPqcpi88oSHXR0kJ
         DNVrdFvAH5Vv2SR9G3a/6VVTGcbXaOJH4h3f1c1CDhSU4CnVwcU0j8UO7bItJB6lRiaB
         VH6+jmOxNSJ5ignxSzDUAMDdturZ7nq+XeU8R5m4W1crwZ9g2w3p/LFxxLfaP2MjyZhI
         p39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841112; x=1734445912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ElcxclfcYlOMSELtXDxg5j/9v6WDvHeMeZCbap56uk=;
        b=eYiIxx7+10muvjrLB4MReOG/vguKPHDB8VRDw6Vytjy7NxSlEpOAgywZ3WGuYGgccy
         IDhE+1BJqb6kGn8dSn25WcOz7qrRU6ixJs7zr/excOy0J2OM/Li53EGzs0ZVmBzuxF+N
         ZwOL0dPVvPC/K7R0ibRaOuWZxAkI1G1ofRoR1idcl4NV9f0YnoyoV2B4pFG+GcBlqEn7
         +widU4bNJWlm7iGHHGFkoRFDCi+/YATaIf0Nwe8WUXfHJfy3gNPGjiK4HB+JgF8Ildu8
         707wR2J6ajRXnT+7VbQ5y+UPfqBM/2xnUclEIJdcxbImtOEqAt4HN9QMtLecEeKTS6sa
         NMZA==
X-Gm-Message-State: AOJu0Yz8+WYakO0U5Yzf533J+0OnkXKh2S9nwD/4Ty+L4ifpJcSXBtSy
	L6y/w5iKIH/871ULlvTzBu5Ut/dqeJKu6D80spcuTJ9pRTK7FygTE3ym4tsf4/VWMSEqDx7ZtKD
	s+lHUgjM6YQ==
X-Google-Smtp-Source: AGHT+IEpOTuT8NMAUNbej1hpf+sDkoTSGLcFtU+9aZr0RoEarmp1wDzt1YFH6LiLGII43yjvL6beWvbavDLMAg==
X-Received: from pgbfe10.prod.google.com ([2002:a05:6a02:288a:b0:7fd:460b:daa3])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7895:b0:1e0:cbcf:8917 with SMTP id adf61e73a8af0-1e1b1ac445amr7412686637.21.1733841112554;
 Tue, 10 Dec 2024 06:31:52 -0800 (PST)
Date: Tue, 10 Dec 2024 14:31:05 +0000
In-Reply-To: <20241210143114.661252-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210143114.661252-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210143114.661252-10-cmllamas@google.com>
Subject: [PATCH v7 9/9] binder: use per-vma lock in page reclaiming
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Use per-vma locking in the shrinker's callback when reclaiming pages,
similar to the page installation logic. This minimizes contention with
unrelated vmas improving performance. The mmap_sem is still acquired if
the per-vma lock cannot be obtained.

Cc: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index b2b97ff19ba2..fcfaf1b899c8 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1143,19 +1143,28 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	struct vm_area_struct *vma;
 	struct page *page_to_free;
 	unsigned long page_addr;
+	int mm_locked = 0;
 	size_t index;
 
 	if (!mmget_not_zero(mm))
 		goto err_mmget;
-	if (!mmap_read_trylock(mm))
-		goto err_mmap_read_lock_failed;
-	if (!mutex_trylock(&alloc->mutex))
-		goto err_get_alloc_mutex_failed;
 
 	index = mdata->page_index;
 	page_addr = alloc->vm_start + index * PAGE_SIZE;
 
-	vma = vma_lookup(mm, page_addr);
+	/* attempt per-vma lock first */
+	vma = lock_vma_under_rcu(mm, page_addr);
+	if (!vma) {
+		/* fall back to mmap_lock */
+		if (!mmap_read_trylock(mm))
+			goto err_mmap_read_lock_failed;
+		mm_locked = 1;
+		vma = vma_lookup(mm, page_addr);
+	}
+
+	if (!mutex_trylock(&alloc->mutex))
+		goto err_get_alloc_mutex_failed;
+
 	/*
 	 * Since a binder_alloc can only be mapped once, we ensure
 	 * the vma corresponds to this mapping by checking whether
@@ -1183,7 +1192,10 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	}
 
 	mutex_unlock(&alloc->mutex);
-	mmap_read_unlock(mm);
+	if (mm_locked)
+		mmap_read_unlock(mm);
+	else
+		vma_end_read(vma);
 	mmput_async(mm);
 	binder_free_page(page_to_free);
 
@@ -1192,7 +1204,10 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 err_invalid_vma:
 	mutex_unlock(&alloc->mutex);
 err_get_alloc_mutex_failed:
-	mmap_read_unlock(mm);
+	if (mm_locked)
+		mmap_read_unlock(mm);
+	else
+		vma_end_read(vma);
 err_mmap_read_lock_failed:
 	mmput_async(mm);
 err_mmget:
-- 
2.47.0.338.g60cca15819-goog


